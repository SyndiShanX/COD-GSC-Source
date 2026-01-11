/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_destructible.gsc
********************************************/

#include common_scripts\utility;
#using_animtree("destructibles");

MAX_SIMULTANEOUS_CAR_ALARMS = 2;
CAR_ALARM_ALIAS = "car_alarm";
CAR_ALARM_OFF_ALIAS = "car_alarm_off";
NO_CAR_ALARM_MAX_ELAPSED_TIME = 120;
CAR_ALARM_TIMEOUT = 25;
DESTROYED_ATTACHMENT_SUFFIX = "_destroy";

SP_DAMAGE_BIAS = 0.5;
SP_EXPLOSIVE_DAMAGE_BIAS = 9.0;

MP_DAMAGE_BIAS = 1.0;
MP_EXPLOSIVE_DAMAGE_BIAS = 13.0;

SP_SHOTGUN_BIAS = 8.0;
MP_SHOTGUN_BIAS = 4.0;

init() {
  SetDevDvarIfUninitialized("debug_destructibles", "0");
  SetDevDvarIfUninitialized("destructibles_enable_physics", "1");
  SetDevDvarIfUninitialized("destructibles_show_radiusdamage", "0");

  level.destructibleSpawnedEntsLimit = 50;
  level.destructibleSpawnedEnts = [];
  level.currentCarAlarms = 0;
  level.commonStartTime = GetTime();

  if(!isDefined(level.fast_destructible_explode)) {
    level.fast_destructible_explode = false;
  }

  level.created_destructibles = [];

  if(!isDefined(level.func)) {
    level.func = [];
  }

  destructibles_enabled = true;

  destructibles_enabled = (GetDvarInt("destructibles_enabled", 1) == 1);

  if(destructibles_enabled) {
    find_destructibles();
  }

  deletables = getEntArray("delete_on_load", "targetname");
  foreach(ent in deletables) {
    ent Delete();
  }

  init_destroyed_count();
  init_destructible_frame_queue();
}

debgugPrintDestructibleList() {
  total = 0;
  if(GetDvarInt("destructibles_locate") > 0) {
    PrintLn("##################");
    PrintLn("DESTRUCTIBLE LIST:");
    PrintLn("##################");
    PrintLn("");

    keys = GetArrayKeys(level.created_destructibles);
    foreach(key in keys) {
      PrintLn(key + ": " + level.created_destructibles[key].size);
      total += level.created_destructibles[key].size;
    }
    PrintLn("");
    PrintLn("Total: " + total);
    PrintLn("");
    PrintLn("Locations:");

    foreach(key in keys) {
      foreach(destructible in level.created_destructibles[key]) {
        PrintLn(key + ": " + destructible.origin);
      }
    }

    PrintLn("");
    PrintLn("##################");

    level.created_destructibles = undefined;
  }

}

find_destructibles() {
  if(!isDefined(level.destructible_functions)) {
    level.destructible_functions = [];
  }

  dots = [];

  foreach(struct in level.struct) {
    if(isDefined(struct.script_noteworthy) &&
    }
    struct.script_noteworthy == "destructible_dot")
  dots[dots.size] = struct;

  vehicles = getEntArray("destructible_vehicle", "targetname");
  foreach(vehicle in vehicles) {
    vehicle thread setup_destructibles_thread(dots);
  }

  destructible_toy = getEntArray("destructible_toy", "targetname");
  foreach(toy in destructible_toy) {
    toy thread setup_destructibles_thread(dots);
  }

  debgugPrintDestructibleList();
}

setup_destructibles_thread(dots) {
  self setup_destructibles();
  self setup_destructible_dots(dots);
}

setup_destructible_dots(dots) {
  destructibleInfo = self.destructibleInfo;

  AssertEx(isDefined(destructibleInfo), "Setup destructibles did not execute properly for this destructible");

  foreach(dot in dots) {
    if(isDefined(level.destructible_type[destructibleInfo].destructible_dots)) {
      return;
    }
    if(isDefined(dot.script_parameters) &&
      IsSubStr(dot.script_parameters, "destructible_type") &&
      IsSubStr(dot.script_parameters, self.destructible_type)) {
      if(DistanceSquared(self.origin, dot.origin) < 1) {
        triggers = getEntArray(dot.target, "targetname");
        level.destructible_type[destructibleInfo].destructible_dots = [];

        foreach(trigger in triggers) {
          script_index = trigger.script_index;

          AssertEx(isDefined(script_index), "Must specify a script_index for trigger being used as DOT in destructible prefab");

          if(!isDefined(level.destructible_type[destructibleInfo].destructible_dots[script_index])) {
            level.destructible_type[destructibleInfo].destructible_dots[script_index] = [];
          }

          triggerIndex = level.destructible_type[destructibleInfo].destructible_dots[script_index].size;

          level.destructible_type[destructibleInfo].destructible_dots[script_index][triggerIndex]["classname"] = trigger.classname;
          level.destructible_type[destructibleInfo].destructible_dots[script_index][triggerIndex]["origin"] = trigger.origin;
          spawnflags = ter_op(isDefined(trigger.spawnflags), trigger.spawnflags, 0);
          level.destructible_type[destructibleInfo].destructible_dots[script_index][triggerIndex]["spawnflags"] = spawnflags;

          switch (trigger.classname) {
            case "trigger_radius":
              level.destructible_type[destructibleInfo].destructible_dots[script_index][triggerIndex]["radius"] = trigger.height;
              level.destructible_type[destructibleInfo].destructible_dots[script_index][triggerIndex]["height"] = trigger.height;
              break;
            default:
              AssertMsg("This class is not supported for DOTs");
          }
          trigger Delete();
        }
        break;
      }
    }
  }
}

destructible_getInfoIndex(destructibleType) {
  if(!isDefined(level.destructible_type)) {
    return -1;
  }
  if(level.destructible_type.size == 0) {
    return -1;
  }

  for(i = 0; i < level.destructible_type.size; i++) {
    if(destructibleType == level.destructible_type[i].v["type"]) {
      return i;
    }
  }

  return -1;
}

destructible_getType(destructibleType) {
  infoIndex = destructible_getInfoIndex(destructibleType);
  if(infoIndex >= 0) {
    return infoIndex;
  }

  if(!isDefined(level.destructible_functions[destructibleType])) {
    AssertMsg("Destructible object 'destructible_type' " + destructibleType + "' is not valid. Have you Repackaged Zone/Script? Sometimes you need to rebuild BSP ents.");
  }

  [[level.destructible_functions[destructibleType]]]();
  infoIndex = destructible_getInfoIndex(destructibleType);
  assert(infoIndex >= 0);
  return infoIndex;
}

setup_destructibles() {
  destructibleInfo = undefined;
  AssertEx(isDefined(self.destructible_type), "Destructible object with targetname 'destructible' does not have a 'destructible_type' key / value");

  self.modeldummyon = false;
  self add_damage_owner_recorder();

  self.destructibleInfo = destructible_getType(self.destructible_type);
  if(self.destructibleInfo < 0) {
    return;
  }
  if(!isDefined(level.created_destructibles)) {
    level.created_destructibles = [];
  }
  if(!isDefined(level.created_destructibles[self.destructible_type])) {
    level.created_destructibles[self.destructible_type] = [];
  }
  nextIndex = level.created_destructibles[self.destructible_type].size;
  level.created_destructibles[self.destructible_type][nextIndex] = self;

  precache_destructibles();

  add_destructible_fx();

  if(isDefined(level.destructible_transient) && isDefined(level.destructible_transient[self.destructible_type])) {
    flag_wait(level.destructible_transient[self.destructible_type] + "_loaded");
  }

  if(isDefined(level.destructible_type[self.destructibleInfo].attachedModels)) {
    foreach(attachedModel in level.destructible_type[self.destructibleInfo].attachedModels) {
      if(isDefined(attachedModel.tag)) {
        self Attach(attachedModel.model, attachedModel.tag);
      } else {
        self Attach(attachedModel.model);
      }
      if(self.modeldummyon) {
        if(isDefined(attachedModel.tag))
      }
      self.modeldummy Attach(attachedModel.model, attachedModel.tag);
      else {
        self.modeldummy Attach(attachedModel.model);
      }
    }
  }

  if(isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    self.destructible_parts = [];
    for(i = 0; i < level.destructible_type[self.destructibleInfo].parts.size; i++) {
      self.destructible_parts[i] = spawnStruct();

      self.destructible_parts[i].v["currentState"] = 0;

      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][0].v["health"])) {
        self.destructible_parts[i].v["health"] = level.destructible_type[self.destructibleInfo].parts[i][0].v["health"];
      }

      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][0].v["random_dynamic_attachment_1"])) {
        randAttachmentIndex = RandomInt(level.destructible_type[self.destructibleInfo].parts[i][0].v["random_dynamic_attachment_1"].size);
        attachTag = level.destructible_type[self.destructibleInfo].parts[i][0].v["random_dynamic_attachment_tag"][randAttachmentIndex];
        attach_model_1 = level.destructible_type[self.destructibleInfo].parts[i][0].v["random_dynamic_attachment_1"][randAttachmentIndex];
        attach_model_2 = level.destructible_type[self.destructibleInfo].parts[i][0].v["random_dynamic_attachment_2"][randAttachmentIndex];
        clipToRemove = level.destructible_type[self.destructibleInfo].parts[i][0].v["clipToRemove"][randAttachmentIndex];
        self thread do_random_dynamic_attachment(attachTag, attach_model_1, attach_model_2, clipToRemove);
      }

      if(i == 0) {
        continue;
      }
      modelName = level.destructible_type[self.destructibleInfo].parts[i][0].v["modelName"];
      tagName = level.destructible_type[self.destructibleInfo].parts[i][0].v["tagName"];

      stateIndex = 1;
      while(isDefined(level.destructible_type[self.destructibleInfo].parts[i][stateIndex])) {
        stateTagName = level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["tagName"];
        stateModelName = level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["modelName"];
        if(isDefined(stateTagName) && stateTagName != tagName) {
          self hideapart(stateTagName);
          if(self.modeldummyon) {
            self.modeldummy hideapart(stateTagName);
          }
        }
        stateIndex++;
      }
    }
  }

  if(isDefined(self.target)) {
    thread destructible_handles_collision_brushes();
  }

  if(self.code_classname != "script_vehicle") {
    self setCanDamage(true);
  }
  if(isSP()) {
    self thread connectTraverses();
  }
  self thread destructible_think();
}

destructible_create(type, tagName, health, validAttackers, validDamageZone, validDamageCause) {
  Assert(isDefined(type));

  if(!isDefined(level.destructible_type)) {
    level.destructible_type = [];
  }

  destructibleIndex = level.destructible_type.size;

  destructibleIndex = level.destructible_type.size;
  level.destructible_type[destructibleIndex] = spawnStruct();
  level.destructible_type[destructibleIndex].v["type"] = type;

  level.destructible_type[destructibleIndex].parts = [];
  level.destructible_type[destructibleIndex].parts[0][0] = spawnStruct();
  level.destructible_type[destructibleIndex].parts[0][0].v["modelName"] = self.model;
  level.destructible_type[destructibleIndex].parts[0][0].v["tagName"] = tagName;
  level.destructible_type[destructibleIndex].parts[0][0].v["health"] = health;
  level.destructible_type[destructibleIndex].parts[0][0].v["validAttackers"] = validAttackers;
  level.destructible_type[destructibleIndex].parts[0][0].v["validDamageZone"] = validDamageZone;
  level.destructible_type[destructibleIndex].parts[0][0].v["validDamageCause"] = validDamageCause;
  level.destructible_type[destructibleIndex].parts[0][0].v["godModeAllowed"] = true;
  level.destructible_type[destructibleIndex].parts[0][0].v["rotateTo"] = self.angles;
  level.destructible_type[destructibleIndex].parts[0][0].v["vehicle_exclude_anim"] = false;
}

destructible_part(tagName, modelName, health, validAttackers, validDamageZone, validDamageCause, alsoDamageParent, physicsOnExplosion, grenadeImpactDeath, receiveDamageFromParent) {
  destructibleIndex = (level.destructible_type.size - 1);
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts.size));

  partIndex = level.destructible_type[destructibleIndex].parts.size;
  Assert(partIndex > 0);

  stateIndex = 0;

  destructible_info(partIndex, stateIndex, tagName, modelName, health, validAttackers, validDamageZone, validDamageCause, alsoDamageParent, physicsOnExplosion, grenadeImpactDeath, undefined, receiveDamageFromParent);
}

destructible_state(tagName, modelName, health, validAttackers, validDamageZone, validDamageCause, grenadeImpactDeath, splashRotation) {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size);

  if(!isDefined(tagName) && partIndex == 0) {
    tagName = level.destructible_type[destructibleIndex].parts[partIndex][0].v["tagName"];
  }

  destructible_info(partIndex, stateIndex, tagName, modelName, health, validAttackers, validDamageZone, validDamageCause, undefined, undefined, grenadeImpactDeath, splashRotation);
}

destructible_fx(tagName, fxName, useTagAngles, damageType, groupNum, fxCost) {
  Assert(isDefined(fxName));

  if(!isDefined(useTagAngles)) {
    useTagAngles = true;
  }

  if(!isDefined(groupNum)) {
    groupNum = 0;
  }

  if(!isDefined(fxCost)) {
    fxCost = 0;
  }

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  fx_size = 0;
  if(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_filename"])) {
    if(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_filename"][groupNum]))
  }
  fx_size = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_filename"][groupNum].size;

  if(isDefined(damageType)) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_valid_damagetype"][groupNum][fx_size] = damageType;
  }

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_filename"][groupNum][fx_size] = fxName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_tag"][groupNum][fx_size] = tagName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_useTagAngles"][groupNum][fx_size] = useTagAngles;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["fx_cost"][groupNum][fx_size] = fxCost;
}

destructible_createDOT_predefined(index) {
  AssertEx(isDefined(index), "Must specify an index >= 0");

  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"] = [];
  }

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size);
  dot = createDOT();
  dot.type = "predefined";
  dot.index = index;

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex] = dot;
}

destructible_createDOT_radius(tag, spawnflags, radius, height) {
  AssertEx(isDefined(tag), "Must define tag where dot with be spawned for destructible");

  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"] = [];
  }

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size);
  dot = createDOT_radius((0, 0, 0), spawnflags, radius, height);
  dot.tag = tag;

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex] = dot;
}

destructible_setDOT_onTick(delay, interval, duration, minDamage, maxDamage, falloff, type, affected) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  dot setDOT_onTick(delay, interval, duration, minDamage, maxDamage, falloff, type, affected);
  initDOT(type);
}

destructible_setDOT_onTickFunc(onEnterFunc, onExitFunc, onDeathFunc) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  tickIndex = dot.ticks.size;

  dot.ticks[tickIndex].onEnterFunc = onEnterFunc;
  dot.ticks[tickIndex].onExitFunc = onExitFunc;
  dot.ticks[tickIndex].onDeathFunc = onDeathFunc;
}

destructible_buildDOT_onTick(duration, affected) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  dot buildDOT_onTick(duration, affected);
}

destructible_buildDOT_startLoop(count) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  dot buildDOT_startLoop(count);
}

destructible_buildDOT_damage(minDamage, maxDamage, falloff, damageFlag, meansOfDeath, weapon) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  dot buildDOT_damage(minDamage, maxDamage, falloff, damageFlag, meansOfDeath, weapon);
}

destructible_buildDOT_wait(time) {
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));

  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));

  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  dotIndex = (level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"].size - 1);
  dot = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["dot"][dotIndex];

  Assert(isDefined(dot));

  dot buildDOT_wait(time);
}

destructible_loopfx(tagName, fxName, loopRate, fxCost) {
  Assert(isDefined(tagName));
  Assert(isDefined(fxName));
  Assert(isDefined(loopRate));
  Assert(loopRate > 0);

  if(!isDefined(fxCost)) {
    fxCost = 0;
  }

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  fx_size = 0;
  if(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_filename"])) {
    fx_size = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_filename"].size;
  }

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_filename"][fx_size] = fxName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_tag"][fx_size] = tagName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_rate"][fx_size] = loopRate;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopfx_cost"][fx_size] = fxCost;
}

destructible_healthdrain(amount, interval, badplaceRadius, badplaceTeam) {
  Assert(isDefined(amount));

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["healthdrain_amount"] = amount;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["healthdrain_interval"] = interval;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["badplace_radius"] = badplaceRadius;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["badplace_team"] = badplaceTeam;
}

destructible_sound(soundAlias, soundCause, groupNum) {
  Assert(isDefined(soundAlias));

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(groupNum)) {
    groupNum = 0;
  }

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["soundCause"] = [];
  }

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"][groupNum])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"][groupNum] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["soundCause"][groupNum] = [];
  }

  index = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"][groupNum].size;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["sound"][groupNum][index] = soundAlias;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["soundCause"][groupNum][index] = soundCause;
}

destructible_loopsound(soundAlias, loopsoundCause) {
  Assert(isDefined(soundAlias));

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsound"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsound"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsoundCause"] = [];
  }

  index = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsound"].size;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsound"][index] = soundAlias;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["loopsoundCause"][index] = loopsoundCause;
}

destructible_anim(animName, animTree, animType, vehicle_exclude, groupNum, mpAnim, maxStartDelay, animRateMin, animRateMax) {
  if(!isDefined(vehicle_exclude)) {
    vehicle_exclude = false;
  }

  Assert(isDefined(anim));
  Assert(isDefined(animName));
  Assert(isDefined(animtree));

  if(!isDefined(groupNum)) {
    groupNum = 0;
  }

  array = [];
  array["anim"] = animName;
  array["animTree"] = animtree;
  array["animType"] = animType;
  array["vehicle_exclude_anim"] = vehicle_exclude;
  array["groupNum"] = groupNum;
  array["mpAnim"] = mpAnim;
  array["maxStartDelay"] = maxStartDelay;
  array["animRateMin"] = animRateMin;
  array["animRateMax"] = animRateMax;
  add_array_to_destructible("animation", array);
}

destructible_spotlight(tag) {
  AssertEx(isDefined(tag), "Tag wasn't defined for destructible_spotlight");
  array = [];
  array["spotlight_tag"] = tag;
  array["spotlight_fx"] = "spotlight_fx";
  array["spotlight_brightness"] = 0.85;
  array["randomly_flip"] = true;

  add_keypairs_to_destructible(array);
}

add_key_to_destructible(key, val) {
  AssertEx(isDefined(key), "Key wasn't defined!");
  AssertEx(isDefined(val), "Val wasn't defined!");

  array = [];
  array[key] = val;
  add_keypairs_to_destructible(array);
}

add_keypairs_to_destructible(array) {
  destructibleIndex = level.destructible_type.size - 1;
  partIndex = level.destructible_type[destructibleIndex].parts.size - 1;
  stateIndex = level.destructible_type[destructibleIndex].parts[partIndex].size - 1;

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  foreach(key, val in array) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v[key] = val;
  }
}

add_array_to_destructible(array_name, array) {
  destructibleIndex = level.destructible_type.size - 1;
  partIndex = level.destructible_type[destructibleIndex].parts.size - 1;
  stateIndex = level.destructible_type[destructibleIndex].parts[partIndex].size - 1;

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  v = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v;

  if(!isDefined(v[array_name])) {
    v[array_name] = [];
  }

  v[array_name][v[array_name].size] = array;

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v = v;
}

destructible_car_alarm() {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["triggerCarAlarm"] = true;
}

destructible_lights_out(range) {
  if(!isDefined(range)) {
    range = 256;
  }

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["break_nearby_lights"] = range;
}

random_dynamic_attachment(tagName, attachment_1, attachment_2, clipToRemove) {
  Assert(isDefined(tagName));
  Assert(isDefined(attachment_1));

  if(!isDefined(attachment_2)) {
    attachment_2 = "";
  }

  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  stateIndex = 0;

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_1"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_1"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_2"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_tag"] = [];
  }

  index = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_1"].size;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_1"][index] = attachment_1;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_2"][index] = attachment_2;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["random_dynamic_attachment_tag"][index] = tagName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["clipToRemove"][index] = clipToRemove;
}

destructible_physics(physTagName, physVelocity) {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(!isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics"])) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics_tagName"] = [];
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics_velocity"] = [];
  }

  index = level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics"].size;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics"][index] = true;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics_tagName"][index] = physTagName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physics_velocity"][index] = physVelocity;
}

destructible_splash_damage_scaler(damage_multiplier) {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["splash_damage_scaler"] = damage_multiplier;
}

destructible_explode(force_min, force_max, rangeSP, rangeMP, mindamage, maxdamage, continueDamage, originOffset, earthQuakeScale, earthQuakeRadius, originOffset3d, delaytime) {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  if(isSP()) {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_range"] = rangeSP;
  } else {
    level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_range"] = rangeMP;
  }

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode"] = true;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_force_min"] = force_min;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_force_max"] = force_max;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_mindamage"] = mindamage;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["explode_maxdamage"] = maxdamage;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["continueDamage"] = continueDamage;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["originOffset"] = originOffset;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["earthQuakeScale"] = earthQuakeScale;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["earthQuakeRadius"] = earthQuakeRadius;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["originOffset3d"] = originOffset3d;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["delaytime"] = delaytime;
}

destructible_function(functionPtr) {
  Assert(isDefined(level.destructible_type));
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["function"] = functionPtr;
}

destructible_notify(notifyStr) {
  Assert(isDefined(level.destructible_type));
  destructibleIndex = (level.destructible_type.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["functionNotify"] = notifyStr;
}

destructible_damage_threshold(damage_threshold) {
  destructibleIndex = (level.destructible_type.size - 1);
  partIndex = (level.destructible_type[destructibleIndex].parts.size - 1);
  stateIndex = (level.destructible_type[destructibleIndex].parts[partIndex].size - 1);

  Assert(isDefined(level.destructible_type));
  Assert(isDefined(level.destructible_type[destructibleIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex]));
  Assert(isDefined(level.destructible_type[destructibleIndex].parts[partIndex][stateIndex]));

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["damage_threshold"] = damage_threshold;
}

destructible_attachmodel(tagName, modelName) {
  Assert(isDefined(modelName));
  Assert(isDefined(level.destructible_type));
  Assert(level.destructible_type.size > 0);
  modelName = ToLower(modelName);
  destructibleIndex = (level.destructible_type.size - 1);

  if(!isDefined(level.destructible_type[destructibleIndex].attachedModels)) {
    level.destructible_type[destructibleIndex].attachedModels = [];
  }
  attachedModel = spawnStruct();
  attachedModel.model = modelName;
  attachedModel.tag = tagName;
  level.destructible_type[destructibleIndex].attachedModels[level.destructible_type[destructibleIndex].attachedModels.size] = attachedModel;
}

destructible_info(partIndex, stateIndex, tagName, modelName, health, validAttackers, validDamageZone, validDamageCause, alsoDamageParent, physicsOnExplosion, grenadeImpactDeath, splashRotation, receiveDamageFromParent) {
  Assert(isDefined(partIndex));
  Assert(isDefined(stateIndex));
  Assert(isDefined(level.destructible_type));
  Assert(level.destructible_type.size > 0);

  if(isDefined(modelName)) {
    modelName = ToLower(modelName);
  }

  destructibleIndex = (level.destructible_type.size - 1);

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex] = spawnStruct();
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["modelName"] = modelName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["tagName"] = tagName;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["health"] = health;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["validAttackers"] = validAttackers;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["validDamageZone"] = validDamageZone;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["validDamageCause"] = validDamageCause;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["alsoDamageParent"] = alsoDamageParent;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["physicsOnExplosion"] = physicsOnExplosion;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["grenadeImpactDeath"] = grenadeImpactDeath;

  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["godModeAllowed"] = false;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["splashRotation"] = splashRotation;
  level.destructible_type[destructibleIndex].parts[partIndex][stateIndex].v["receiveDamageFromParent"] = receiveDamageFromParent;
}

precache_destructibles() {
  if(!isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    return;
  }
  if(isDefined(level.destructible_type[self.destructibleInfo].attachedModels)) {
    foreach(attachedModel in level.destructible_type[self.destructibleInfo].attachedModels) {
      PreCacheModel(attachedModel.model);
    }
  }

  for(i = 0; i < level.destructible_type[self.destructibleInfo].parts.size; i++) {
    for(j = 0; j < level.destructible_type[self.destructibleInfo].parts[i].size; j++) {
      if(level.destructible_type[self.destructibleInfo].parts[i].size <= j) {
        continue;
      }
      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][j].v["modelName"])) {
        PreCacheModel(level.destructible_type[self.destructibleInfo].parts[i][j].v["modelName"]);
      }

      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][j].v["animation"])) {
        animGroups = level.destructible_type[self.destructibleInfo].parts[i][j].v["animation"];
        foreach(group in animGroups) {
          if(isDefined(group["mpAnim"])) {
            noself_func("precacheMpAnim", group["mpAnim"]);
          }
        }
      }

      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][j].v["random_dynamic_attachment_1"])) {
        foreach(model in level.destructible_type[self.destructibleInfo].parts[i][j].v["random_dynamic_attachment_1"]) {
          if(isDefined(model) && model != "") {
            PreCacheModel(model);
            PreCacheModel(model + DESTROYED_ATTACHMENT_SUFFIX);
          }
        }
        foreach(model in level.destructible_type[self.destructibleInfo].parts[i][j].v["random_dynamic_attachment_2"]) {
          if(isDefined(model) && model != "") {
            PreCacheModel(model);
            PreCacheModel(model + DESTROYED_ATTACHMENT_SUFFIX);
          }
        }
      }
    }
  }
}

add_destructible_fx() {
  if(!isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    return;
  }
  for(i = 0; i < level.destructible_type[self.destructibleInfo].parts.size; i++) {
    for(j = 0; j < level.destructible_type[self.destructibleInfo].parts[i].size; j++) {
      if(level.destructible_type[self.destructibleInfo].parts[i].size <= j) {
        continue;
      }
      part = level.destructible_type[self.destructibleInfo].parts[i][j];

      if(isDefined(part.v["fx_filename"])) {
        for(g = 0; g < part.v["fx_filename"].size; g++) {
          fx_filenames = part.v["fx_filename"][g];
          fx_tags = part.v["fx_tag"][g];

          if(isDefined(fx_filenames)) {
            assert(isDefined(fx_tags));

            if(isDefined(part.v["fx"]) && isDefined(part.v["fx"][g]) && part.v["fx"][g].size == fx_filenames.size) {
              continue;
            }
            for(idx = 0; idx < fx_filenames.size; idx++) {
              fx_filename = fx_filenames[idx];
              fx_tag = fx_tags[idx];

              level.destructible_type[self.destructibleInfo].parts[i][j].v["fx"][g][idx] = LoadFX(fx_filename, fx_tag);

            }
          }
        }
      }

      loopfx_filenames = level.destructible_type[self.destructibleInfo].parts[i][j].v["loopfx_filename"];
      loopfx_tags = level.destructible_type[self.destructibleInfo].parts[i][j].v["loopfx_tag"];

      if(isDefined(loopfx_filenames)) {
        assert(isDefined(loopfx_tags));

        if(isDefined(part.v["loopfx"]) && part.v["loopfx"].size == loopfx_filenames.size) {
          continue;
        }
        for(idx = 0; idx < loopfx_filenames.size; idx++) {
          loopfx_filename = loopfx_filenames[idx];
          loopfx_tag = loopfx_tags[idx];

          level.destructible_type[self.destructibleInfo].parts[i][j].v["loopfx"][idx] = LoadFX(loopfx_filename, loopfx_tag);

        }
      }
    }
  }

}

canDamageDestructible(testDestructible) {
  foreach(destructible in self.destructibles) {
    if(destructible == testDestructible) {
      return true;
    }
  }
  return false;
}

destructible_think() {
  damage = 0;
  modelName = self.model;
  tagName = undefined;
  point = self.origin;
  direction_vec = undefined;
  attacker = undefined;
  damageType = undefined;
  self destructible_update_part(damage, modelName, tagName, point, direction_vec, attacker, damageType);

  self endon("stop_taking_damage");
  for(;;) {
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    point = undefined;
    type = undefined;
    modelName = undefined;
    tagName = undefined;
    partName = undefined;
    dflags = undefined;

    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, dflags);

    if(!isDefined(damage)) {
      continue;
    }
    if(isDefined(attacker) && isDefined(attacker.type) && attacker.type == "soft_landing" && !attacker canDamageDestructible(self)) {
      continue;
    }
    if(isSP()) {
      damage *= SP_DAMAGE_BIAS;
    } else {
      damage *= MP_DAMAGE_BIAS;
    }

    if(damage <= 0) {
      continue;
    }
    if(isSP()) {
      if(isDefined(attacker) && IsPlayer(attacker)) {
        self.damageOwner = attacker;
      }
    } else {
      if(isDefined(attacker) && IsPlayer(attacker)) {
        self.damageOwner = attacker;
      } else if(isDefined(attacker) && isDefined(attacker.gunner) && IsPlayer(attacker.gunner)) {
        self.damageOwner = attacker.gunner;
      }
    }

    type = getDamageType(type);
    Assert(isDefined(type));

    if(is_shotgun_damage(attacker, type)) {
      if(isSP()) {
        damage *= SP_SHOTGUN_BIAS;
      } else {
        damage *= MP_SHOTGUN_BIAS;
      }
    }

    if(GetDvarInt("debug_destructibles", 0) == 1) {
      Print3d(point, ".", (1, 1, 1), 1.0, 0.5, 100);
      if(isDefined(damage)) {
        IPrintLn("damage amount: " + damage);
      }
      if(isDefined(modelName)) {
        IPrintLn("hit model: " + modelName);
      }
      if(isDefined(tagName)) {
        IPrintLn("hit model tag: " + tagName);
      } else {
        IPrintLn("hit model tag: ");
      }
    }

    if(!isDefined(modelName) || (modelName == "")) {
      Assert(isDefined(self.model));
      modelName = self.model;
    }
    if(isDefined(tagName) && tagName == "") {
      if(isDefined(partName) && partName != "" && partName != "tag_body" && partName != "body_animate_jnt") {
        tagName = partName;
      } else {
        tagName = undefined;
      }

      baseModelTag = level.destructible_type[self.destructibleInfo].parts[0][0].v["tagName"];
      if(isDefined(baseModelTag) && isDefined(partName) && (baseModelTag == partName)) {
        tagName = undefined;
      }
    }

    if(type == "splash") {
      if(GetDvarInt("debug_destructibles", 0) == 1) {
        IPrintLn("type = splash");
      }

      if(isDefined(level.destructible_type[self.destructibleInfo].parts[0][0].v["splash_damage_scaler"])) {
        damage *= level.destructible_type[self.destructibleInfo].parts[0][0].v["splash_damage_scaler"];
      } else {
        if(isSP()) {
          damage *= SP_EXPLOSIVE_DAMAGE_BIAS;
        } else {
          damage *= MP_EXPLOSIVE_DAMAGE_BIAS;
        }
      }

      self destructible_splash_damage(Int(damage), point, direction_vec, attacker, type);
      continue;
    }

    self thread destructible_update_part(Int(damage), modelName, tagName, point, direction_vec, attacker, type);
  }
}

is_shotgun_damage(attacker, type) {
  if(type != "bullet") {
    return false;
  }

  if(!isDefined(attacker)) {
    return false;
  }

  currentWeapon = undefined;
  if(IsPlayer(attacker)) {
    currentweapon = attacker getCurrentWeapon();
  } else if(isDefined(level.enable_ai_shotgun_destructible_damage) && level.enable_ai_shotgun_destructible_damage) {
    if(isDefined(attacker.weapon)) {
      currentweapon = attacker.weapon;
    }
  }

  if(!isDefined(currentweapon)) {
    return false;
  }

  class = weaponClass(currentweapon);
  if(isDefined(class) && class == "spread") {
    return true;
  }

  return false;
}

getPartAndStateIndex(modelName, tagName) {
  Assert(isDefined(modelName));

  info = spawnStruct();
  info.v = [];

  partIndex = -1;
  stateIndex = -1;
  Assert(isDefined(self.model));
  if((ToLower(modelName) == ToLower(self.model)) && (!isDefined(tagName))) {
    modelName = self.model;
    tagName = undefined;
    partIndex = 0;
    stateIndex = 0;
  }

  for(i = 0; i < level.destructible_type[self.destructibleInfo].parts.size; i++) {
    stateIndex = self.destructible_parts[i].v["currentState"];

    if(level.destructible_type[self.destructibleInfo].parts[i].size <= stateIndex) {
      continue;
    }
    if(!isDefined(tagName)) {
      continue;
    }
    if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["tagName"])) {
      partTagName = level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["tagName"];
      if(tolower(partTagName) == tolower(tagName)) {
        partIndex = i;
        break;
      }
    }
  }
  Assert(stateIndex >= 0);
  Assert(isDefined(partIndex));

  info.v["stateIndex"] = stateindex;
  info.v["partIndex"] = partindex;

  return info;
}

destructible_update_part(damage, modelName, tagName, point, direction_vec, attacker, damageType, partInfo) {
  if(!isDefined(self.destructible_parts)) {
    return;
  }
  if(self.destructible_parts.size == 0) {
    return;
  }
  if(level.fast_destructible_explode) {
    self endon("destroyed");
  }

  info = getPartAndStateIndex(modelName, tagName);
  stateIndex = info.v["stateIndex"];
  partIndex = info.v["partIndex"];

  if(partIndex < 0) {
    return;
  }
  state_before = stateIndex;
  updateHealthValue = false;
  delayModelSwap = false;

  for(;;) {
    stateIndex = self.destructible_parts[partIndex].v["currentState"];

    if(!isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex])) {
      break;
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][0].v["alsoDamageParent"])) {
      if(getDamageType(damageType) != "splash") {
        ratio = level.destructible_type[self.destructibleInfo].parts[partIndex][0].v["alsoDamageParent"];
        parentDamage = Int(damage * ratio);
        self thread notifyDamageAfterFrame(parentDamage, attacker, direction_vec, point, damageType, "", "");
      }
    }

    if(getDamageType(damageType) != "splash") {
      foreach(part in level.destructible_type[self.destructibleInfo].parts) {
        if(!isDefined(part[0].v["receiveDamageFromParent"])) {
          continue;
        }
        if(!isDefined(part[0].v["tagName"])) {
          continue;
        }
        ratio = part[0].v["receiveDamageFromParent"];
        Assert(ratio > 0);

        childDamage = Int(damage * ratio);
        childTagName = part[0].v["tagName"];
        self thread notifyDamageAfterFrame(childDamage, attacker, direction_vec, point, damageType, "", childTagName);
      }
    }

    if(!isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["health"])) {
      break;
    }
    if(!isDefined(self.destructible_parts[partIndex].v["health"])) {
      break;
    }

    if(updateHealthValue) {
      self.destructible_parts[partIndex].v["health"] = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["health"];
    }
    updateHealthValue = false;

    if(GetDvarInt("debug_destructibles", 0) == 1) {
      IPrintLn("stateindex: " + stateIndex);
      IPrintLn("damage: " + damage);
      IPrintLn("health( before ): " + self.destructible_parts[partIndex].v["health"]);
    }

    if((isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["grenadeImpactDeath"])) && (damageType == "impact")) {
      damage = 100000000;
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["damage_threshold"]) &&
      level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["damage_threshold"] > damage)
      damage = 0;

    savedHealth = self.destructible_parts[partIndex].v["health"];
    validAttacker = self isAttackerValid(partIndex, stateIndex, attacker);
    if(validAttacker) {
      validDamageCause = self isValidDamageCause(partIndex, stateIndex, damageType);
      if(validDamageCause) {
        if(isDefined(attacker)) {
          if(IsPlayer(attacker)) {
            self.player_damage += damage;
          } else {
            if(attacker != self) {
              self.non_player_damage += damage;
            }
          }
        }

        if(isDefined(damageType)) {
          if(damageType == "melee" || damageType == "impact") {
            damage = 100000;
          }
        }

        self.destructible_parts[partIndex].v["health"] -= damage;
      }
    }

    if(GetDvarInt("debug_destructibles", 0) == 1) {
      IPrintLn("health( after ): " + self.destructible_parts[partIndex].v["health"]);
    }

    if(self.destructible_parts[partIndex].v["health"] > 0) {
      return;
    }

    if(isDefined(partInfo)) {
      partInfo.v["fxcost"] = get_part_FX_cost_for_action_state(partIndex, self.destructible_parts[partIndex].v["currentState"]);

      add_destructible_to_frame_queue(self, partInfo, damage);

      if(!isDefined(self.waiting_for_queue)) {
        self.waiting_for_queue = 1;
      } else {
        self.waiting_for_queue++;
      }

      self waittill("queue_processed", success);

      self.waiting_for_queue--;
      if(self.waiting_for_queue == 0) {
        self.waiting_for_queue = undefined;
      }

      if(!success) {
        self.destructible_parts[partIndex].v["health"] = savedHealth;
        return;
      }
    }

    damage = Int(abs(self.destructible_parts[partIndex].v["health"]));

    if(damage < 0) {
      AssertEx(0, "Logically, we should never get here, and I plan to remove this part of the script.Tell Boon at IW if you see this.");

      return;
    }

    self.destructible_parts[partIndex].v["currentState"]++;
    stateIndex = self.destructible_parts[partIndex].v["currentState"];
    actionStateIndex = (stateIndex - 1);

    action_v = undefined;
    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex])) {
      action_v = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v;
    }

    state_v = undefined;
    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex])) {
      state_v = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v;
    }

    if(!isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex])) {
      return;
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode"])) {
      self.exploding = true;
    }

    if(isDefined(self.loopingSoundStopNotifies) && isDefined(self.loopingSoundStopNotifies[toString(partIndex)])) {
      for(i = 0; i < self.loopingSoundStopNotifies[toString(partIndex)].size; i++) {
        self notify(self.loopingSoundStopNotifies[toString(partIndex)][i]);
        if(isSP() && self.modeldummyon) {
          self.modeldummy notify(self.loopingSoundStopNotifies[toString(partIndex)][i]);
        }
      }
      self.loopingSoundStopNotifies[toString(partIndex)] = undefined;
    }

    if(isDefined(action_v["break_nearby_lights"])) {
      self destructible_get_my_breakable_light(action_v["break_nearby_lights"]);
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex])) {
      if(partIndex == 0) {
        newModel = state_v["modelName"];
        if(isDefined(newModel) && newModel != self.model) {
          self setModel(newModel);
          if(isSP() && self.modeldummyon) {
            self.modeldummy setModel(newModel);
          }
          destructible_splash_rotatation(state_v);
        }
      } else {
        self hideapart(tagName);
        if(isSP() && self.modeldummyon) {
          self.modeldummy hideapart(tagName);
        }

        tagName = state_v["tagName"];
        if(isDefined(tagName)) {
          self showapart(tagName);
          if(isSP() && self.modeldummyon) {
            self.modeldummy showapart(tagName);
          }
        }
      }
    }

    eModel = get_dummy();

    if(isDefined(self.exploding)) {
      self clear_anims(eModel);
    }

    groupNumber = destructible_animation_think(action_v, eModel, damageType, partIndex);

    groupNumber = destructible_fx_think(action_v, eModel, damageType, partIndex, groupNumber);

    groupNumber = destructible_sound_think(action_v, eModel, damageType, groupNumber);

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx"])) {
      loopfx_size = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx_filename"].size;

      if(loopfx_size > 0) {
        self notify("FX_State_Change" + partIndex);
      }

      for(idx = 0; idx < loopfx_size; idx++) {
        Assert(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx_tag"][idx]));
        loopfx = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx"][idx];
        loopfx_tag = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx_tag"][idx];
        loopRate = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopfx_rate"][idx];
        self thread loopfx_onTag(loopfx, loopfx_tag, loopRate, partIndex);
      }
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopsound"])) {
      for(i = 0; i < level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopsound"].size; i++) {
        validSoundCause = self isValidSoundCause("loopsoundCause", action_v, i, damageType);
        if(validSoundCause) {
          loopsoundAlias = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["loopsound"][i];
          loopsoundTagName = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["tagName"];
          self thread play_loop_sound_on_destructible(loopsoundAlias, loopsoundTagName);

          if(!isDefined(self.loopingSoundStopNotifies)) {
            self.loopingSoundStopNotifies = [];
          }
          if(!isDefined(self.loopingSoundStopNotifies[toString(partIndex)])) {
            self.loopingSoundStopNotifies[toString(partIndex)] = [];
          }
          size = self.loopingSoundStopNotifies[toString(partIndex)].size;
          self.loopingSoundStopNotifies[toString(partIndex)][size] = "stop sound" + loopsoundAlias;
        }
      }
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["triggerCarAlarm"])) {
      self thread do_car_alarm();
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["break_nearby_lights"])) {
      self thread break_nearest_light();
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["healthdrain_amount"])) {
      self notify("Health_Drain_State_Change" + partIndex);
      healthdrain_amount = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["healthdrain_amount"];
      healthdrain_interval = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["healthdrain_interval"];
      healthdrain_modelName = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["modelName"];
      healthdrain_tagName = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["tagName"];
      badplaceRadius = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["badplace_radius"];
      badplaceTeam = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["badplace_team"];
      if(healthdrain_amount > 0) {
        Assert((isDefined(healthdrain_interval)) && (healthdrain_interval > 0));
        self thread health_drain(healthdrain_amount, healthdrain_interval, partIndex, healthdrain_modelName, healthdrain_tagName, badplaceRadius, badplaceTeam);
      }
    }

    dots = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["dot"];

    if(isDefined(dots)) {
      foreach(dot in dots) {
        dotIndex = dot.index;

        if(dot.type == "predefined" && isDefined(dotIndex)) {
          dot_group = [];

          foreach(triggerIndex in level.destructible_type[self.destructibleInfo].destructible_dots[dotIndex]) {
            classname = triggerIndex["classname"];
            _dot = undefined;

            switch (classname) {
              case "trigger_radius":
                origin = triggerIndex["origin"];
                spawnflags = triggerIndex["spawnflags"];
                radius = triggerIndex["radius"];
                height = triggerindex["height"];

                _dot = createDOT_radius(self.origin + origin, spawnflags, radius, height);
                _dot.ticks = dot.ticks;
                dot_group[dot_group.size] = _dot;
                break;
              default:
            }
          }
          level thread startDOT_group(dot_group);
        } else {
          if(isDefined(dot)) {
            if(isDefined(dot.tag)) {
              dot setDOT_origin(self GetTagOrigin(dot.tag));
            }
            level thread startDOT_group([dot]);
          }
        }
      }
      dots = undefined;
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode"])) {
      delayModelSwap = true;
      force_min = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode_force_min"];
      force_max = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode_force_max"];
      range = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode_range"];
      mindamage = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode_mindamage"];
      maxdamage = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["explode_maxdamage"];
      continueDamage = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["continueDamage"];
      originOffset = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["originOffset"];
      earthQuakeScale = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["earthQuakeScale"];
      earthQuakeRadius = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["earthQuakeRadius"];
      originOffset3d = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["originOffset3d"];
      delaytime = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["delaytime"];

      if(isDefined(attacker) && attacker != self) {
        self.attacker = attacker;

        if(self.code_classname == "script_vehicle") {
          self.damage_type = damageType;
        }
      }

      self thread explode(partIndex, force_min, force_max, range, mindamage, maxdamage, continueDamage, originOffset, earthQuakeScale, earthQuakeRadius, attacker, originOffset3d, delaytime);
    }

    physTagOrigin = undefined;
    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["physics"])) {
      for(i = 0; i < level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["physics"].size; i++) {
        physTagOrigin = undefined;
        physTagName = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["physics_tagName"][i];
        physVelocity = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["physics_velocity"][i];

        initial_velocity = undefined;
        if(isDefined(physVelocity)) {
          physTagAngles = undefined;
          if(isDefined(physTagName)) {
            physTagAngles = self GetTagAngles(physTagName);
          } else if(isDefined(tagName)) {
            physTagAngles = self GetTagAngles(tagName);
          }
          Assert(isDefined(physTagAngles));

          physTagOrigin = undefined;
          if(isDefined(physTagName)) {
            physTagOrigin = self GetTagOrigin(physTagName);
          } else if(isDefined(tagName)) {
            physTagOrigin = self GetTagOrigin(tagName);
          }
          Assert(isDefined(physTagOrigin));

          phys_x = physVelocity[0] - 5 + RandomFloat(10);
          phys_y = physVelocity[1] - 5 + RandomFloat(10);
          phys_z = physVelocity[2] - 5 + RandomFloat(10);

          forward = anglesToForward(physTagAngles) * phys_x * RandomFloatRange(80, 110);
          right = AnglesToRight(physTagAngles) * phys_y * RandomFloatRange(80, 110);
          up = AnglesToUp(physTagAngles) * phys_z * RandomFloatRange(80, 110);

          initial_velocity = forward + right + up;

          if(GetDvarInt("debug_destructibles", 0) == 1) {
            thread draw_line_for_time(physTagOrigin, physTagOrigin + initial_velocity, 1, 1, 1, 5.0);
          }

        } else {
          initial_velocity = point;
          impactDir = (0, 0, 0);
          if(isDefined(attacker)) {
            impactDir = attacker.origin;
            initial_velocity = VectorNormalize(point - impactDir);
            initial_velocity *= 200;
          }
        }
        Assert(isDefined(initial_velocity));

        if(isDefined(physTagName)) {
          physPartIndex = undefined;
          for(j = 0; j < level.destructible_type[self.destructibleInfo].parts.size; j++) {
            if(!isDefined(level.destructible_type[self.destructibleInfo].parts[j][0].v["tagName"])) {
              continue;
            }
            if(level.destructible_type[self.destructibleInfo].parts[j][0].v["tagName"] != physTagName) {
              continue;
            }
            physPartIndex = j;
            break;
          }

          if(isDefined(physTagOrigin)) {
            self thread physics_launch(physPartIndex, 0, physTagOrigin, initial_velocity);
          } else {
            self thread physics_launch(physPartIndex, 0, point, initial_velocity);
          }
        } else {
          if(isDefined(physTagOrigin)) {
            self thread physics_launch(partIndex, actionStateIndex, physTagOrigin, initial_velocity);
          } else {
            self thread physics_launch(partIndex, actionStateIndex, point, initial_velocity);
          }

          return;
        }
      }
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v) &&
      isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["functionNotify"])) {
      self notify(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["functionNotify"]);
    }

    if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["function"])) {
      self thread[[level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v["function"]]]();
    }

    updateHealthValue = true;
  }

}

destructible_splash_rotatation(v) {
  model_rotation = v["splashRotation"];
  model_rotate_to = v["rotateTo"];

  if(!isDefined(model_rotate_to)) {
    return;
  }
  if(!isDefined(model_rotation)) {
    return;
  }
  if(!model_rotation) {
    return;
  }
  self.angles = (self.angles[0], model_rotate_to[1], self.angles[2]);
}

damage_not(damageType) {
  toks = StrTok(damageType, " ");
  damages_tok = StrTok("splash melee bullet splash impact unknown", " ");
  new_string = "";

  foreach(idx, tok in toks) {
    damages_tok = array_remove(damages_tok, tok);
  }

  foreach(damages in damages_tok) {
    new_string += damages + " ";
  }

  return new_string;
}

destructible_splash_damage(damage, point, direction_vec, attacker, damageType) {
  if(damage <= 0) {
    return;
  }
  if(isDefined(self.exploded)) {
    return;
  }
  if(!isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    return;
  }
  damagedParts = self getAllActiveParts(direction_vec);

  if(damagedParts.size <= 0) {
    return;
  }
  damagedParts = self setDistanceOnParts(damagedParts, point);

  closestPartDist = getLowestPartDistance(damagedParts);
  Assert(isDefined(closestPartDist));

  foreach(part in damagedParts) {
    distanceMod = (part.v["distance"] * 1.4);
    damageAmount = (damage - (distanceMod - closestPartDist));

    if(damageAmount <= 0) {
      continue;
    }
    if(isDefined(self.exploded)) {
      continue;
    }
    if(GetDvarInt("debug_destructibles", 0) == 1) {
      if(isDefined(part.v["tagName"])) {
        Print3d(self GetTagOrigin(part.v["tagName"]), damageAmount, (1, 1, 1), 1.0, 0.5, 200);
      }
    }

    self thread destructible_update_part(damageAmount, part.v["modelName"], part.v["tagName"], point, direction_vec, attacker, damageType, part);
  }

}

getAllActiveParts(direction_vec) {
  activeParts = [];

  Assert(isDefined(self.destructibleInfo));
  if(!isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    return activeParts;
  }

  for(i = 0; i < level.destructible_type[self.destructibleInfo].parts.size; i++) {
    partIndex = i;
    currentState = self.destructible_parts[partIndex].v["currentState"];

    for(j = 0; j < level.destructible_type[self.destructibleInfo].parts[partIndex].size; j++) {
      splash_rotation = level.destructible_type[self.destructibleInfo].parts[partIndex][j].v["splashRotation"];
      if(isDefined(splash_rotation) && splash_rotation) {
        rotate_to_angle = VectorToAngles(direction_vec);
        rotate_to_angle_y = rotate_to_angle[1] - 90;
        level.destructible_type[self.destructibleInfo].parts[partIndex][j].v["rotateTo"] = (0, rotate_to_angle_y, 0);
      }
    }

    if(!isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][currentState])) {
      continue;
    }
    tagName = level.destructible_type[self.destructibleInfo].parts[partIndex][currentState].v["tagName"];
    if(!isDefined(tagName)) {
      tagName = "";
    }

    if(tagName == "") {
      continue;
    }
    modelName = level.destructible_type[self.destructibleInfo].parts[partIndex][currentState].v["modelName"];
    if(!isDefined(modelName)) {
      modelName = "";
    }

    activePartIndex = activeParts.size;
    activeParts[activePartIndex] = spawnStruct();
    activeParts[activePartIndex].v["modelName"] = modelName;
    activeParts[activePartIndex].v["tagName"] = tagName;
  }

  return activeParts;
}

setDistanceOnParts(partList, point) {
  for(i = 0; i < partList.size; i++) {
    d = Distance(point, self GetTagOrigin(partList[i].v["tagName"]));
    partList[i].v["distance"] = d;
  }

  return partList;
}

getLowestPartDistance(partList) {
  closestDist = undefined;

  foreach(part in partList) {
    Assert(isDefined(part.v["distance"]));
    d = part.v["distance"];

    if(!isDefined(closestDist)) {
      closestDist = d;
    }

    if(d < closestDist) {
      closestDist = d;
    }
  }

  return closestDist;
}

isValidSoundCause(soundCauseVar, action_v, soundIndex, damageType, groupNum) {
  if(isDefined(groupNum)) {
    soundCause = action_v[soundCauseVar][groupNum][soundIndex];
  } else {
    soundCause = action_v[soundCauseVar][soundIndex];
  }

  if(!isDefined(soundCause)) {
    return true;
  }

  if(soundCause == damageType) {
    return true;
  }

  return false;
}

isAttackerValid(partIndex, stateIndex, attacker) {
  if(isDefined(self.forceExploding)) {
    return true;
  }

  if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["explode"])) {
    if(isDefined(self.dontAllowExplode)) {
      return false;
    }
  }

  if(!isDefined(attacker)) {
    return true;
  }

  if(attacker == self) {
    return true;
  }

  sType = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["validAttackers"];
  if(!isDefined(sType)) {
    return true;
  }

  if(sType == "no_player") {
    if(!isplayer(attacker)) {
      return true;
    }
    if(!isDefined(attacker.damageIsFromPlayer)) {
      return true;
    }
    if(attacker.damageIsFromPlayer == false) {
      return true;
    }
  } else
  if(sType == "player_only") {
    if(IsPlayer(attacker)) {
      return true;
    }
    if(isDefined(attacker.damageIsFromPlayer) && attacker.damageIsFromPlayer) {
      return true;
    }
  } else
  if(sType == "no_ai" && isDefined(level.isAIfunc)) {
    if(![
        [level.isAIfunc]
      ](attacker))
      return true;
  } else
  if(sType == "ai_only" && isDefined(level.isAIfunc)) {
    if([
        [level.isAIfunc]
      ](attacker))
      return true;
  } else {
    AssertMsg("Invalid attacker rules on destructible vehicle. Valid types are: ai_only, no_ai, player_only, no_player");
  }

  return false;
}

isValidDamageCause(partIndex, stateIndex, damageType) {
  if(!isDefined(damageType)) {
    return true;
  }

  godModeAllowed = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["godModeAllowed"];
  if(godModeAllowed && ((isDefined(self.godmode) && self.godmode) || (isDefined(self.script_bulletshield) && self.script_bulletshield) && damageType == "bullet")) {
    return false;
  }

  validType = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["validDamageCause"];
  if(!isDefined(validType)) {
    return true;
  }

  if((validType == "splash") && damageType != "splash") {
    return false;
  }

  if((validType == "no_splash") && damageType == "splash") {
    return false;
  }

  if((validType == "no_melee") && damageType == "melee" || damageType == "impact") {
    return false;
  }

  return true;
}

getDamageType(type) {
  if(!isDefined(type)) {
    return "unknown";
  }

  type = ToLower(type);
  switch (type) {
    case "mod_melee":
    case "mod_crush":
    case "melee":
      return "melee";
    case "mod_pistol_bullet":
    case "mod_rifle_bullet":
    case "bullet":
      return "bullet";
    case "mod_grenade":
    case "mod_grenade_splash":
    case "mod_projectile":
    case "mod_projectile_splash":
    case "mod_explosive":
    case "splash":
      return "splash";
    case "mod_impact":
      return "impact";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

damage_mirror(parent, modelName, tagName) {
  self notify("stop_damage_mirror");
  self endon("stop_damage_mirror");
  parent endon("stop_taking_damage");

  self setCanDamage(true);
  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type);
    parent notify("damage", damage, attacker, direction_vec, point, type, modelName, tagName);
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    point = undefined;
    type = undefined;
  }
}

add_damage_owner_recorder() {
  self.player_damage = 0;
  self.non_player_damage = 0;

  self.car_damage_owner_recorder = true;
}

loopfx_onTag(loopfx, loopfx_tag, loopRate, partIndex) {
  self endon("FX_State_Change" + partIndex);
  self endon("delete_destructible");
  level endon("putout_fires");

  while(isDefined(self)) {
    eModel = get_dummy();
    playFXOnTag(loopfx, eModel, loopfx_tag);
    wait loopRate;
  }
}

health_drain(amount, interval, partIndex, modelName, tagName, badplaceRadius, badplaceTeam) {
  self endon("Health_Drain_State_Change" + partIndex);
  level endon("putout_fires");
  self endon("destroyed");

  if(isDefined(badplaceRadius) && isDefined(level.destructible_badplace_radius_multiplier)) {
    badplaceRadius *= level.destructible_badplace_radius_multiplier;
  }

  if(isDefined(amount) && isDefined(level.destructible_health_drain_amount_multiplier)) {
    amount *= level.destructible_health_drain_amount_multiplier;
  }

  wait interval;

  self.healthDrain = true;

  uniqueName = undefined;

  if(isDefined(level.disable_destructible_bad_places) && level.disable_destructible_bad_places) {
    badplaceRadius = undefined;
  }

  if(isDefined(badplaceRadius) && isDefined(level.badplace_cylinder_func)) {
    uniqueName = "" + GetTime();
    if(!isDefined(self.disableBadPlace)) {
      if(isDefined(self.script_radius)) {
        badplaceRadius = self.script_radius;
      }
      if(isSP() && isDefined(badplaceTeam)) {
        if(badplaceTeam == "both") {
          call[[level.badplace_cylinder_func]](uniqueName, 0, self.origin, badplaceRadius, 128, "allies", "bad_guys");
        } else {
          call[[level.badplace_cylinder_func]](uniqueName, 0, self.origin, badplaceRadius, 128, badplaceTeam);
        }
        self thread badplace_remove(uniqueName);
      } else {
        call[[level.badplace_cylinder_func]](uniqueName, 0, self.origin, badplaceRadius, 128);
        self thread badplace_remove(uniqueName);
      }
    }
  }

  while(isDefined(self) && self.destructible_parts[partIndex].v["health"] > 0) {
    if(GetDvarInt("debug_destructibles", 0) == 1) {
      IPrintLn("health before damage: " + self.destructible_parts[partIndex].v["health"]);
      IPrintLn("doing " + amount + " damage");
    }

    self notify("damage", amount, self, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", modelName, tagName);
    wait interval;
  }

  self notify("remove_badplace");
}

badplace_remove(uniqueName) {
  self waittill_any("destroyed", "remove_badplace");

  Assert(isDefined(uniqueName));
  Assert(isDefined(level.badplace_delete_func));
  call[[level.badplace_delete_func]](uniqueName);
}

physics_launch(partIndex, stateIndex, point, initial_velocity) {
  modelName = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["modelName"];
  tagName = level.destructible_type[self.destructibleInfo].parts[partIndex][stateIndex].v["tagName"];

  self hideapart(tagName);

  if(GetDvarInt("destructibles_enable_physics", 1) == 0) {
    return;
  }
  if(level.destructibleSpawnedEnts.size >= level.destructibleSpawnedEntsLimit) {
    physics_object_remove(level.destructibleSpawnedEnts[0]);
  }

  physicsObject = spawn("script_model", self GetTagOrigin(tagName));
  physicsObject.angles = self GetTagAngles(tagName);
  physicsObject setModel(modelName);

  physicsObject.targetname = modelName + "(thrown physics model)";

  level.destructibleSpawnedEnts[level.destructibleSpawnedEnts.size] = physicsObject;

  physicsObject PhysicsLaunchClient(point, initial_velocity);
}

physics_object_remove(ent) {
  newArray = [];
  for(i = 0; i < level.destructibleSpawnedEnts.size; i++) {
    if(level.destructibleSpawnedEnts[i] == ent) {
      continue;
    }
    newArray[newArray.size] = level.destructibleSpawnedEnts[i];
  }
  level.destructibleSpawnedEnts = newArray;

  if(isDefined(ent)) {
    ent Delete();
  }
}

explode(partIndex, force_min, force_max, range, mindamage, maxdamage, continueDamage, originOffset, earthQuakeScale, earthQuakeRadius, attacker, originOffset3d, delaytime) {
  Assert(isDefined(force_min));
  Assert(isDefined(force_max));

  if(isDefined(range) && isDefined(level.destructible_explosion_radius_multiplier)) {
    range *= level.destructible_explosion_radius_multiplier;
  }

  if(!isDefined(originOffset)) {
    originOffset = 80;
  }
  if(!isDefined(originOffset3d)) {
    originOffset3d = (0, 0, 0);
  }

  if(!isDefined(continueDamage) || (isDefined(continueDamage) && !continueDamage)) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
  }

  if(!isDefined(delaytime)) {
    delaytime = 0;
  }

  self notify("exploded", attacker);
  level notify("destructible_exploded", self, attacker);
  if(self.code_classname == "script_vehicle") {
    self notify("death", attacker, self.damage_type);
  }

  if(isSP()) {
    self thread disconnectTraverses();
  }

  if(!level.fast_destructible_explode) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  currentState = self.destructible_parts[partIndex].v["currentState"];
  Assert(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex]));
  tagName = undefined;
  if(isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][currentState])) {
    tagName = level.destructible_type[self.destructibleInfo].parts[partIndex][currentState].v["tagName"];
  }

  if(isDefined(tagName)) {
    explosionOrigin = self GetTagOrigin(tagName);
  } else {
    explosionOrigin = self.origin;
  }

  self notify("damage", maxdamage, self, (0, 0, 0), explosionOrigin, "MOD_EXPLOSIVE", "", "");

  self notify("stop_car_alarm");

  waittillframeend;

  if(isDefined(level.destructible_type[self.destructibleInfo].parts)) {
    for(i = (level.destructible_type[self.destructibleInfo].parts.size - 1); i >= 0; i--) {
      if(i == partIndex) {
        continue;
      }
      stateIndex = self.destructible_parts[i].v["currentState"];
      if(stateIndex >= level.destructible_type[self.destructibleInfo].parts[i].size) {
        stateIndex = level.destructible_type[self.destructibleInfo].parts[i].size - 1;
      }
      modelName = level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["modelName"];
      tagName = level.destructible_type[self.destructibleInfo].parts[i][stateIndex].v["tagName"];

      if(!isDefined(modelName)) {
        continue;
      }
      if(!isDefined(tagName)) {
        continue;
      }
      if(isDefined(level.destructible_type[self.destructibleInfo].parts[i][0].v["physicsOnExplosion"])) {
        if(level.destructible_type[self.destructibleInfo].parts[i][0].v["physicsOnExplosion"] > 0) {
          velocityScaler = level.destructible_type[self.destructibleInfo].parts[i][0].v["physicsOnExplosion"];

          point = self GetTagOrigin(tagName);
          initial_velocity = VectorNormalize(point - explosionOrigin);
          initial_velocity *= RandomFloatRange(force_min, force_max) * velocityScaler;

          self thread physics_launch(i, stateIndex, point, initial_velocity);
          continue;
        }
      }

    }
  }

  stopTakingDamage = (!isDefined(continueDamage) || (isDefined(continueDamage) && !continueDamage));
  if(stopTakingDamage) {
    self notify("stop_taking_damage");
  }

  if(!level.fast_destructible_explode) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  damageLocation = explosionOrigin + (0, 0, originOffset) + originOffset3d;

  isVehicle = (GetSubStr(level.destructible_type[self.destructibleInfo].v["type"], 0, 7) == "vehicle");

  if(isVehicle) {
    anim.lastCarExplosionTime = GetTime();
    anim.lastCarExplosionDamageLocation = damageLocation;
    anim.lastCarExplosionLocation = explosionOrigin;
    anim.lastCarExplosionRange = range;
  }

  level thread set_disable_friendlyfire_value_delayed(1);

  if(delaytime > 0) {
    wait(delaytime);
  }

  if(isDefined(level.destructible_protection_func)) {
    thread[[level.destructible_protection_func]]();
  }

  if(isSP()) {
    if(level.gameskill == 0 && !self player_touching_post_clip()) {
      self RadiusDamage(damageLocation, range, maxdamage, mindamage, self, "MOD_RIFLE_BULLET");
    } else {
      self RadiusDamage(damageLocation, range, maxdamage, mindamage, self);
    }

    if(isDefined(self.damageOwner) && isVehicle) {
      self.damageOwner notify("destroyed_car");
      level notify("player_destroyed_car", self.damageOwner, damageLocation);
    }
  } else {
    weapon = "destructible_toy";
    if(isVehicle) {
      weapon = "destructible_car";
    }

    if(!isDefined(self.damageOwner)) {
      self RadiusDamage(damageLocation, range, maxdamage, mindamage, self, "MOD_EXPLOSIVE", weapon);
    } else {
      self RadiusDamage(damageLocation, range, maxdamage, mindamage, self.damageOwner, "MOD_EXPLOSIVE", weapon);
      if(isVehicle) {
        self.damageOwner notify("destroyed_car");
        level notify("player_destroyed_car", self.damageOwner, damageLocation);
      }
    }
  }

  if(isDefined(earthQuakeScale) && isDefined(earthQuakeRadius)) {
    Earthquake(earthQuakeScale, 2.0, damageLocation, earthQuakeRadius);
  }

  if(GetDvarInt("destructibles_show_radiusdamage") == 1) {
    thread debug_radiusdamage_circle(damageLocation, range, maxdamage, mindamage);
  }

  level thread set_disable_friendlyfire_value_delayed(0, 0.05);

  magnitudeScaler = 0.01;
  magnitude = range * magnitudeScaler;
  Assert(magnitude > 0);
  range *= .99;
  PhysicsExplosionSphere(damageLocation, range, 0, magnitude);

  if(stopTakingDamage) {
    self setCanDamage(false);
    self thread cleanupVars();
  }

  self notify("destroyed");
}

cleanupVars() {
  wait 0.05;

  while(isDefined(self) && isDefined(self.waiting_for_queue)) {
    self waittill("queue_processed");
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self.animsapplied = undefined;
  self.attacker = undefined;
  self.car_damage_owner_recorder = undefined;
  self.caralarm = undefined;
  self.damageowner = undefined;
  self.destructible_parts = undefined;
  self.destructible_type = undefined;
  self.destructibleInfo = undefined;
  self.healthdrain = undefined;
  self.non_player_damage = undefined;
  self.player_damage = undefined;

  if(!isDefined(level.destructible_cleans_up_more)) {
    return;
  }
  self.script_noflip = undefined;
  self.exploding = undefined;
  self.loopingsoundstopnotifies = undefined;
  self.car_alarm_org = undefined;
}

set_disable_friendlyfire_value_delayed(value, delay) {
  level notify("set_disable_friendlyfire_value_delayed");
  level endon("set_disable_friendlyfire_value_delayed");

  Assert(isDefined(value));

  if(isDefined(delay)) {
    wait delay;
  }

  level.friendlyFireDisabledForDestructible = value;
}

connectTraverses() {
  clip = get_traverse_disconnect_brush();

  if(!isDefined(clip)) {
    return;
  }
  Assert(isDefined(level.connectPathsFunction));
  clip call[[level.connectPathsFunction]]();
  clip.origin -= (0, 0, 10000);
}

disconnectTraverses() {
  clip = get_traverse_disconnect_brush();

  if(!isDefined(clip)) {
    return;
  }
  clip.origin += (0, 0, 10000);
  Assert(isDefined(level.disconnectPathsFunction));
  clip call[[level.disconnectPathsFunction]]();
  clip.origin -= (0, 0, 10000);
}

get_traverse_disconnect_brush() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  targets = getEntArray(self.target, "targetname");
  foreach(target in targets) {
    if(IsSpawner(target)) {
      continue;
    }
    if(isDefined(target.script_destruct_collision)) {
      continue;
    }
    if(target.code_classname == "light") {
      continue;
    }
    if(!target.spawnflags & 1) {
      continue;
    }
    return target;
  }
}

hideapart(tagName) {
  self HidePart(tagName);
}

showapart(tagName) {
  self ShowPart(tagName);
}

disable_explosion() {
  self.dontAllowExplode = true;
}

force_explosion() {
  self.dontAllowExplode = undefined;
  self.forceExploding = true;
  self notify("damage", 100000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "");
}

get_dummy() {
  if(!isSP()) {
    return self;
  }

  if(self.modeldummyon) {
    eModel = self.modeldummy;
  } else {
    eModel = self;
  }
  return eModel;
}

play_loop_sound_on_destructible(alias, tag) {
  eModel = get_dummy();

  org = spawn("script_origin", (0, 0, 0));
  if(isDefined(tag)) {
    org.origin = eModel GetTagOrigin(tag);
  } else {
    org.origin = eModel.origin;
  }

  org playLoopSound(alias);

  eModel thread force_stop_sound(alias);

  eModel waittill("stop sound" + alias);
  if(!isDefined(org)) {
    return;
  }
  org StopLoopSound(alias);
  org Delete();
}

force_stop_sound(alias) {
  self endon("stop sound" + alias);

  level waittill("putout_fires");
  self notify("stop sound" + alias);
}

notifyDamageAfterFrame(damage, attacker, direction_vec, point, damageType, modelName, tagName) {
  if(isDefined(level.notifyDamageAfterFrame)) {
    return;
  }
  level.notifyDamageAfterFrame = true;
  waittillframeend;
  if(isDefined(self.exploded)) {
    level.notifyDamageAfterFrame = undefined;
    return;
  }

  if(isSP()) {
    damage /= SP_DAMAGE_BIAS;
  } else {
    damage /= MP_DAMAGE_BIAS;
  }

  self notify("damage", damage, attacker, direction_vec, point, damageType, modelName, tagName);
  level.notifyDamageAfterFrame = undefined;
}

play_sound(alias, tag) {
  if(isDefined(tag)) {
    org = spawn("script_origin", self GetTagOrigin(tag));
    org Hide();
    org LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org = spawn("script_origin", (0, 0, 0));
    org Hide();
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }

  org playSound(alias);
  wait(5.0);
  if(isDefined(org)) {
    org Delete();
  }
}

toString(num) {
  return ("" + num);
}

do_car_alarm() {
  if(isDefined(self.carAlarm)) {
    return;
  }
  self.carAlarm = true;

  if(!should_do_car_alarm()) {
    return;
  }
  self.car_alarm_org = spawn("script_model", self.origin);
  self.car_alarm_org Hide();
  self.car_alarm_org playLoopSound(CAR_ALARM_ALIAS);

  level.currentCarAlarms++;
  Assert(level.currentCarAlarms <= MAX_SIMULTANEOUS_CAR_ALARMS);

  self thread car_alarm_timeout();

  self waittill("stop_car_alarm");

  level.lastCarAlarmTime = GetTime();
  level.currentCarAlarms--;

  self.car_alarm_org StopLoopSound(CAR_ALARM_ALIAS);
  self.car_alarm_org Delete();
}

car_alarm_timeout() {
  self endon("stop_car_alarm");

  wait CAR_ALARM_TIMEOUT;

  if(!isDefined(self)) {
    return;
  }
  self thread play_sound(CAR_ALARM_OFF_ALIAS);
  self notify("stop_car_alarm");
}

should_do_car_alarm() {
  if(level.currentCarAlarms >= MAX_SIMULTANEOUS_CAR_ALARMS) {
    return false;
  }

  timeElapsed = undefined;
  if(!isDefined(level.lastCarAlarmTime)) {
    if(cointoss()) {
      return true;
    }
    timeElapsed = GetTime() - level.commonStartTime;
  } else {
    timeElapsed = GetTime() - level.lastCarAlarmTime;
  }
  Assert(isDefined(timeElapsed));

  if(level.currentCarAlarms == 0 && timeElapsed >= NO_CAR_ALARM_MAX_ELAPSED_TIME) {
    return true;
  }

  if(RandomInt(100) <= 33) {
    return true;
  }

  return false;
}

do_random_dynamic_attachment(tagName, attach_model_1, attach_model_2, clipToRemove) {
  Assert(isDefined(tagName));
  Assert(isDefined(attach_model_1));

  spawnedModels = [];

  if(isSP()) {
    self Attach(attach_model_1, tagName, false);
    if(isDefined(attach_model_2) && attach_model_2 != "") {
      self Attach(attach_model_2, tagName, false);
    }
  } else {
    spawnedModels[0] = spawn("script_model", self GetTagOrigin(tagName));
    spawnedModels[0].angles = self GetTagAngles(tagName);
    spawnedModels[0] setModel(attach_model_1);
    spawnedModels[0] LinkTo(self, tagName);

    if(isDefined(attach_model_2) && attach_model_2 != "") {
      spawnedModels[1] = spawn("script_model", self GetTagOrigin(tagName));
      spawnedModels[1].angles = self GetTagAngles(tagName);
      spawnedModels[1] setModel(attach_model_2);
      spawnedModels[1] LinkTo(self, tagName);
    }
  }

  if(isDefined(clipToRemove)) {
    tagOrg = self getTagOrigin(tagName);
    clip = get_closest_with_targetname(tagOrg, clipToRemove);
    if(isDefined(clip)) {
      clip delete();
    }
  }

  self waittill("exploded");

  if(isSP()) {
    self Detach(attach_model_1, tagName);
    self Attach(attach_model_1 + DESTROYED_ATTACHMENT_SUFFIX, tagName, false);

    if(isDefined(attach_model_2) && attach_model_2 != "") {
      self Detach(attach_model_2, tagName);
      self Attach(attach_model_2 + DESTROYED_ATTACHMENT_SUFFIX, tagName, false);
    }
  } else {
    spawnedModels[0] setModel(attach_model_1 + DESTROYED_ATTACHMENT_SUFFIX);
    if(isDefined(attach_model_2) && attach_model_2 != "") {
      spawnedModels[1] setModel(attach_model_2 + DESTROYED_ATTACHMENT_SUFFIX);
    }
  }
}

get_closest_with_targetname(origin, targetname) {
  closestDist = undefined;
  closestEnt = undefined;
  ents = getEntArray(targetname, "targetname");
  foreach(ent in ents) {
    d = distanceSquared(origin, ent.origin);

    if(!isDefined(closestDist) || (d < closestDist)) {
      closestDist = d;
      closestEnt = ent;
    }
  }

  return closestEnt;
}

player_touching_post_clip() {
  post_clip = undefined;

  if(!isDefined(self.target)) {
    return false;
  }

  targets = getEntArray(self.target, "targetname");
  foreach(target in targets) {
    if(isDefined(target.script_destruct_collision) && target.script_destruct_collision == "post") {
      post_clip = target;
      break;
    }
  }

  if(!isDefined(post_clip)) {
    return false;
  }

  player = get_player_touching(post_clip);

  if(isDefined(player)) {
    return true;
  }

  return false;
}

get_player_touching(ent) {
  foreach(player in level.players) {
    if(!IsAlive(player)) {
      continue;
    }

    if(ent IsTouching(player)) {
      return player;
    }
  }

  return undefined;
}

is_so() {
  return GetDvar("specialops") == "1";
}

destructible_handles_collision_brushes() {
  targets = getEntArray(self.target, "targetname");
  collision_funcs = [];
  collision_funcs["pre"] = ::collision_brush_pre_explosion;
  collision_funcs["post"] = ::collision_brush_post_explosion;

  foreach(target in targets) {
    if(!isDefined(target.script_destruct_collision)) {
      continue;
    }
    self thread[[collision_funcs[target.script_destruct_collision]]](target);
  }
}
DYNAMICPATH = 1;

collision_brush_pre_explosion(clip) {
  waittillframeend;

  if(isSP() && clip.spawnflags &DYNAMICPATH) {
    clip call[[level.disconnectPathsFunction]]();
  }

  self waittill("exploded");

  if(isSP() && clip.spawnflags &DYNAMICPATH) {
    clip call[[level.connectPathsFunction]]();
  }

  clip Delete();
}

collision_brush_post_explosion(clip) {
  clip NotSolid();

  if(isSP() && clip.spawnflags &DYNAMICPATH) {
    clip call[[level.connectPathsFunction]]();
  }

  self waittill("exploded");
  waittillframeend;

  if(isSP()) {
    if(clip.spawnflags &DYNAMICPATH) {
      clip call[[level.disconnectPathsFunction]]();
    }

    if(is_so()) {
      player = get_player_touching(clip);
      if(isDefined(player)) {
        assertex(isDefined(level.func_destructible_crush_player), "Special Ops requires level.func_destructible_crush_player to be defined.");
        self thread[[level.func_destructible_crush_player]](player);
      }
    } else {
      thread debug_player_in_post_clip(clip);

    }
  }

  clip Solid();
}

debug_player_in_post_clip(clip) {
  wait(0.1);
  player = get_player_touching(clip);
  if(isDefined(player)) {
    AssertEx(!IsAlive(player), "Player is in a clip of a destructible, but is still alive. He's either in godmode or we're doing something wrong. Player will be stuck now.");
  }

}

destructible_get_my_breakable_light(range) {
  AssertEx(!isDefined(self.breakable_light), "Tried to define my breakable light twice");

  lights = getEntArray("light_destructible", "targetname");
  if(isSP()) {
    lights2 = getEntArray("light_destructible", "script_noteworthy");
    lights = array_combine(lights, lights2);
  }
  if(!lights.size) {
    return;
  }
  shortest_distance = range * range;
  the_light = undefined;
  foreach(light in lights) {
    dist = DistanceSquared(self.origin, light.origin);
    if(dist < shortest_distance) {
      the_light = light;
      shortest_distance = dist;
    }
  }

  if(!isDefined(the_light)) {
    return;
  }
  self.breakable_light = the_light;
}

break_nearest_light(range) {
  if(!isDefined(self.breakable_light)) {
    return;
  }
  self.breakable_light SetLightIntensity(0);
}

debug_radiusdamage_circle(center, radius, maxdamage, mindamage) {
  circle_sides = 16;

  angleFrac = 360 / circle_sides;

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }
  thread debug_circle_drawlines(circlepoints, 5.0, (1, 0, 0), center);

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0];
    y = center[1] + xAdd;
    z = center[2] + yAdd;
    circlepoints[circlepoints.size] = (x, y, z);
  }
  thread debug_circle_drawlines(circlepoints, 5.0, (1, 0, 0), center);

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0] + yAdd;
    y = center[1];
    z = center[2] + xAdd;
    circlepoints[circlepoints.size] = (x, y, z);
  }
  thread debug_circle_drawlines(circlepoints, 5.0, (1, 0, 0), center);

  Print3d(center, maxdamage, (1, 1, 1), 1, 1, 100);
  Print3d(center + (radius, 0, 0), mindamage, (1, 1, 1), 1, 1, 100);
}

debug_circle_drawlines(circlepoints, duration, color, center) {
  Assert(isDefined(center));
  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];
    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread debug_line(start, end, duration, color);
    thread debug_line(center, start, duration, color);
  }
}

debug_line(start, end, duration, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  for(i = 0; i < (duration * 20); i++) {
    Line(start, end, color);
    wait 0.05;
  }
}

spotlight_tag_origin_cleanup(tag_origin) {
  tag_origin endon("death");
  level waittill("new_destructible_spotlight");
  tag_origin Delete();
}

spotlight_fizzles_out(action_v, eModel, damageType, partIndex, tag_origin) {
  level endon("new_destructible_spotlight");
  thread spotlight_tag_origin_cleanup(tag_origin);

  maxVal = action_v["spotlight_brightness"];

  wait(RandomFloatRange(2, 5));

  destructible_fx_think(action_v, eModel, damageType, partIndex);
  level.destructible_spotlight Delete();
  tag_origin Delete();
}

destructible_spotlight_think(action_v, eModel, damageType, partIndex) {
  if(!isSP()) {
    return;
  }
  if(!isDefined(self.breakable_light)) {
    return;
  }
  emodel self_func("startignoringspotLight");

  if(!isDefined(level.destructible_spotlight)) {
    level.destructible_spotlight = spawn_tag_origin();
    fx = getfx(action_v["spotlight_fx"]);
    playFXOnTag(fx, level.destructible_spotlight, "tag_origin");
  }

  level notify("new_destructible_spotlight");

  level.destructible_spotlight Unlink();

  tag_origin = spawn_tag_origin();
  tag_origin LinkTo(self, action_v["spotlight_tag"], (0, 0, 0), (0, 0, 0));

  level.destructible_spotlight.origin = self.breakable_light.origin;
  level.destructible_spotlight.angles = self.breakable_light.angles;
  level.destructible_spotlight thread spotlight_fizzles_out(action_v, eModel, damageType, partIndex, tag_origin);

  wait(0.05);
  if(isDefined(tag_origin)) {
    level.destructible_spotlight LinkTo(tag_origin);
  }

}

is_valid_damagetype(damageType, v, idx, groupNum) {
  valid_damagetype = undefined;
  if(isDefined(v["fx_valid_damagetype"])) {
    valid_damagetype = v["fx_valid_damagetype"][groupNum][idx];
  }

  if(!isDefined(valid_damagetype)) {
    return true;
  }

  return IsSubStr(valid_damagetype, damageType);
}

destructible_sound_think(action_v, eModel, damageType, groupNum) {
  if(isDefined(self.exploded)) {
    return undefined;
  }

  if(!isDefined(action_v["sound"])) {
    return undefined;
  }

  if(!isDefined(groupNum)) {
    groupNum = 0;
  }

  if(!isDefined(action_v["sound"][groupNum])) {
    return undefined;
  }

  for(i = 0; i < action_v["sound"][groupNum].size; i++) {
    validSoundCause = self isValidSoundCause("soundCause", action_v, i, damageType, groupNum);
    if(!validSoundCause) {
      continue;
    }
    soundAlias = action_v["sound"][groupNum][i];
    soundTagName = action_v["tagName"];
    eModel thread play_sound(soundAlias, soundTagName);
  }

  return groupNum;
}

destructible_fx_think(action_v, eModel, damageType, partIndex, groupNum) {
  if(!isDefined(action_v["fx"])) {
    return undefined;
  }

  if(!isDefined(groupNum)) {
    groupNum = randomInt(action_v["fx_filename"].size);
  }

  if(!isDefined(action_v["fx"][groupNum])) {
    println("^1destructible tried to use custom groupNum for FX but that group didn't exist");
    groupNum = randomInt(action_v["fx_filename"].size);
  }

  assert(isDefined(action_v["fx"][groupNum]));

  fx_size = action_v["fx_filename"][groupNum].size;

  for(idx = 0; idx < fx_size; idx++) {
    if(!is_valid_damagetype(damageType, action_v, idx, groupNum)) {
      continue;
    }
    fx = action_v["fx"][groupNum][idx];

    if(isDefined(action_v["fx_tag"][groupNum][idx])) {
      fx_tag = action_v["fx_tag"][groupNum][idx];
      self notify("FX_State_Change" + partIndex);

      if(action_v["fx_useTagAngles"][groupNum][idx]) {
        playFXOnTag(fx, eModel, fx_tag);
      } else {
        fxOrigin = eModel GetTagOrigin(fx_tag);
        forward = (fxOrigin + (0, 0, 100)) - fxOrigin;
        playFX(fx, fxOrigin, forward);
      }
    } else {
      fxOrigin = eModel.origin;
      forward = (fxOrigin + (0, 0, 100)) - fxOrigin;
      playFX(fx, fxOrigin, forward);
    }
  }

  return groupNum;
}

destructible_animation_think(action_v, eModel, damageType, partIndex) {
  if(isDefined(self.exploded)) {
    return undefined;
  }

  if(!isDefined(action_v["animation"])) {
    return undefined;
  }

  if(isDefined(self.no_destructible_animation)) {
    return undefined;
  }

  if(isDefined(action_v["randomly_flip"]) && !isDefined(self.script_noflip)) {
    if(cointoss()) {
      self.angles += (0, 180, 0);
    }
  }

  if(isDefined(action_v["spotlight_tag"])) {
    thread destructible_spotlight_think(action_v, eModel, damageType, partIndex);
    wait(0.05);
  }

  array = random(action_v["animation"]);

  animName = array["anim"];
  animTree = array["animTree"];
  groupNum = array["groupNum"];
  mpAnim = array["mpAnim"];

  maxStartDelay = array["maxStartDelay"];
  animRateMin = array["animRateMin"];
  animRateMax = array["animRateMax"];

  if(!isDefined(animRateMin)) {
    animRateMin = 1.0;
  }
  if(!isDefined(animRateMax)) {
    animRateMax = 1.0;
  }
  if(animRateMin == animRateMax) {
    animRate = animRateMin;
  } else {
    animRate = RandomFloatRange(animRateMin, animRateMax);
  }

  vehicle_dodge_part_animation = array["vehicle_exclude_anim"];

  if(self.code_classname == "script_vehicle" && vehicle_dodge_part_animation) {
    return undefined;
  }

  eModel self_func("useanimtree", animTree);

  animType = array["animType"];

  if(!isDefined(self.animsApplied)) {
    self.animsApplied = [];
  }
  self.animsApplied[self.animsApplied.size] = animName;

  if(isDefined(self.exploding)) {
    self clear_anims(eModel);
  }

  if(isDefined(maxStartDelay) && maxStartDelay > 0) {
    wait RandomFloat(maxStartDelay);
  }

  if(!isSP()) {
    if(isDefined(mpAnim)) {
      self self_func("scriptModelPlayAnim", mpAnim);
    }
    return groupNum;
  }

  if(animType == "setanim") {
    eModel self_func("setanim", animName, 1.0, 1.0, animRate);
    return groupNum;
  }

  if(animType == "setanimknob") {
    eModel self_func("setanimknob", animName, 1.0, 0, animRate);
    return groupNum;
  }

  AssertMsg("Tried to play an animation on a destructible with an invalid animType: " + animType);
  return undefined;
}

clear_anims(eModel) {
  if(isDefined(self.animsApplied)) {
    foreach(animation in self.animsApplied) {
      if(isSP()) {
        eModel self_func("clearanim", animation, 0);
      } else {
        eModel self_func("scriptModelClearAnim");
      }
    }
  }
}

init_destroyed_count() {
  level.destroyedCount = 0;
  level.destroyedCountTimeout = 0.5;

  if(isSP()) {
    level.maxDestructions = 20;
  } else {
    level.maxDestructions = 2;
  }
}

add_to_destroyed_count() {
  level.destroyedCount++;

  wait(level.destroyedCountTimeout);

  level.destroyedCount--;

  Assert(level.destroyedCount >= 0);
}

get_destroyed_count() {
  return (level.destroyedCount);
}

get_max_destroyed_count() {
  return (level.maxDestructions);
}

init_destructible_frame_queue() {
  level.destructibleFrameQueue = [];
}

add_destructible_to_frame_queue(destructible, partInfo, damage) {
  entNum = self GetEntityNumber();

  if(!isDefined(level.destructibleFrameQueue[entNum])) {
    level.destructibleFrameQueue[entNum] = spawnStruct();
    level.destructibleFrameQueue[entNum].entNum = entNum;
    level.destructibleFrameQueue[entNum].destructible = destructible;
    level.destructibleFrameQueue[entNum].totalDamage = 0;
    level.destructibleFrameQueue[entNum].nearDistance = 9999999;
    level.destructibleFrameQueue[entNum].fxCost = 0;
  }

  level.destructibleFrameQueue[entNum].fxCost += partInfo.v["fxcost"];

  level.destructibleFrameQueue[entNum].totalDamage += damage;
  if(partInfo.v["distance"] < level.destructibleFrameQueue[entNum].nearDistance) {
    level.destructibleFrameQueue[entNum].nearDistance = partInfo.v["distance"];
  }

  thread handle_destructible_frame_queue();
}

handle_destructible_frame_queue() {
  level notify("handle_destructible_frame_queue");
  level endon("handle_destructible_frame_queue");

  wait(0.05);

  currentQueue = level.destructibleFrameQueue;
  level.destructibleFrameQueue = [];

  sortedQueue = sort_destructible_frame_queue(currentQueue);

  for(i = 0; i < sortedQueue.size; i++) {
    if(get_destroyed_count() < get_max_destroyed_count()) {
      if(sortedQueue[i].fxCost) {
        thread add_to_destroyed_count();
      }

      sortedQueue[i].destructible notify("queue_processed", true);
    } else {
      sortedQueue[i].destructible notify("queue_processed", false);
    }
  }
}

sort_destructible_frame_queue(unsortedQueue) {
  sortedQueue = [];
  foreach(destructibleInfo in unsortedQueue) {
    sortedQueue[sortedQueue.size] = destructibleInfo;
  }

  for(i = 1; i < sortedQueue.size; i++) {
    queueStruct = sortedQueue[i];

    for(j = i - 1; j >= 0 && get_better_destructible(queueStruct, sortedQueue[j]) == queueStruct; j--) {
      sortedQueue[j + 1] = sortedQueue[j];
    }

    sortedQueue[j + 1] = queueStruct;
  }

  return sortedQueue;
}

get_better_destructible(destructibleInfo1, destructibleInfo2) {
  if(destructibleInfo1.totalDamage > destructibleInfo2.totalDamage) {
    return destructibleInfo1;
  } else {
    return destructibleInfo2;
  }
}

get_part_FX_cost_for_action_state(partIndex, actionStateIndex) {
  fxCost = 0;

  if(!isDefined(level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex])) {
    return fxCost;
  }

  action_v = level.destructible_type[self.destructibleInfo].parts[partIndex][actionStateIndex].v;

  if(isDefined(action_v["fx"])) {
    foreach(fxCostObj in action_v["fx_cost"]) {
      foreach(fxCostVal in fxCostObj) {
        fxCost += fxCostVal;
      }
    }
  }

  return fxCost;
}

/

setDOT_origin(origin) {
  AssertEx(isDefined(origin), "Must specify a origin");

  self.origin = origin;
}

setDOT_radius(minRadius, maxRadius) {
  if(isDefined(self.classname) && self.classname != "trigger_radius") {
    AssertMsg("You can only use setDOT_radius on trigger_radius");
  }

  AssertEx(isDefined(minRadius), "Must define minRadius");

  if(!isDefined(maxRadius)) {
    maxRadius = minRadius;
  }

  AssertEx(maxRadius >= minRadius, "maxRadius must be greater than minRadius");
  AssertEx(self.radius >= maxRadius, "radius on trigger must be greater than or equal to maxRadius");

  self.minRadius = minRadius;
  self.maxRadius = maxRadius;
}

setDOT_height(minHeight, maxHeight) {
  if(isDefined(self.classname) && IsSubStr(self.classname, "trigger")) {
    AssertMsg("You can only use setDOT_height on triggers");
  }
}

setDOT_onTick(delay, interval, duration, minDamage, maxDamage, falloff, type, affected) {
  if(isDefined(delay)) {
    AssertEx(delay >= 0, "Must specify a delay >= 0");
  } else {
    delay = 0;
  }
  AssertEx(isDefined(interval) && interval > 0, "Must specify an interval > 0");
  AssertEx(isDefined(duration) && duration > 0, "Must specify a duration > 0");
  AssertEx(duration > interval, "duration must be > interval");
  AssertEx(isDefined(minDamage) && minDamage >= 0, "Must specify a minDamage >= 0");
  AssertEx(isDefined(maxDamage) && maxDamage > 0, "Must specify a maxDamage > 0");
  AssertEx(isDefined(falloff), "Must specify a falloff of 0 or 1");
  AssertEx(isDefined(type), "Must specify a type of 'normal' or 'poison'");
  AssertEx(isDefined(affected), "Must specify a type of 'player'");

  type = ToLower(type);
  affected = ToLower(affected);

  index = self.ticks.size;

  self.ticks[index] = spawnStruct();
  self.ticks[index].enable = 0;
  self.ticks[index].delay = delay;
  self.ticks[index].interval = interval;
  self.ticks[index].duration = duration;
  self.ticks[index].minDamage = minDamage;
  self.ticks[index].maxDamage = maxDamage;

  switch (falloff) {
    case 0:
    case 1:
      break;
    default:
      AssertMsg("Must specify a falloff of 0 or 1");
  }

  self.ticks[index].falloff = falloff;
  self.ticks[index].startTime = 0;

  switch (type) {
    case "normal":
      break;
    case "poison":
      switch (affected) {
        case "player":
          self.ticks[index].type = type;
          self.ticks[index].affected = affected;
          self.ticks[index].onEnterFunc = ::onEnterDOT_poisonDamagePlayer;
          self.ticks[index].onExitFunc = ::onExitDOT_poisonDamagePlayer;
          self.ticks[index].onDeathFunc = ::onDeathDOT_poisonDamagePlayer;
          break;
        default:
          AssertMsg("Must specify the affected. Valid types are 'player'");
      }
      break;
    default:
      AssertMsg("Must specify a type. Valid types are 'normal' or 'poision'");
  }
}

buildDOT_onTick(duration, affected) {
  AssertEx(isDefined(duration), "Must specify a duration > 0");
  AssertEx(isDefined(affected), "Must specify a type of 'player'");

  affected = ToLower(affected);

  index = self.ticks.size;

  self.ticks[index] = spawnStruct();
  self.ticks[index].duration = duration;
  self.ticks[index].delay = 0;
  self.ticks[index].onEnterFunc = ::onEnterDOT_buildFunc;
  self.ticks[index].onExitFunc = ::onExitDOT_buildFunc;
  self.ticks[index].onDeathFunc = ::onDeathDOT_buildFunc;

  switch (affected) {
    case "player":
      self.ticks[index].affected = affected;
      break;
    default:
      AssertMsg("Must specify the affected. Valid types are 'player'");
  }
}

buildDOT_startLoop(count) {
  AssertEx(isDefined(count), "Must specify a count >= 0");
  AssertEx(isDefined(self.ticks) && self.ticks.size >= 0, "Must call buildDOT_onTick first");

  index = self.ticks.size - 1;

  if(!isDefined(self.ticks[index].statements)) {
    self.ticks[index].statements = [];
  }

  statementIndex = self.ticks[index].statements.size;

  self.ticks[index].statements = [];
  self.ticks[index].statements["vars"] = [];
  self.ticks[index].statements["vars"]["count"] = count;
}

buildDOT_damage(minDamage, maxDamage, falloff, damageFlag, meansOfDeath, weapon) {
  AssertEx(isDefined(minDamage), "");
  AssertEx(isDefined(maxDamage), "");
  AssertEx(isDefined(falloff), "");
  AssertEx(isDefined(damageFlag), "");
  AssertEx(isDefined(meansOfDeath), "");
  AssertEx(isDefined(weapon), "");
  AssertEx(isDefined(self.ticks), "Must call buildDOT_startLoop first");

  tickIndex = self.ticks.size - 1;

  AssertEx(isDefined(self.ticks[tickIndex]) &&
    isDefined(self.ticks[tickIndex].statements), "Must call buildDOT_startLoop first");

  if(!isDefined(self.ticks[tickIndex].statements["actions"])) {
    self.ticks[tickIndex].statements["actions"] = [];
  }

  actionIndex = self.ticks[tickIndex].statements["actions"].size;

  self.ticks[tickIndex].statements["actions"][actionIndex] = [];
  self.ticks[tickIndex].statements["actions"][actionIndex]["vars"] = [minDamage, maxDamage, falloff, damageFlag, meansOfDeath, weapon];
  self.ticks[tickIndex].statements["actions"][actionIndex]["func"] = ::doBuildDOT_damage;
}

buildDOT_wait(time) {
  AssertEx(isDefined(time), "Must specify time >= 0");
  AssertEx(isDefined(self.ticks), "Must call buildDOT_startLoop first");

  tickIndex = self.ticks.size - 1;

  AssertEx(isDefined(self.ticks[tickIndex]) &&
    isDefined(self.ticks[tickIndex].statements), "Must call buildDOT_startLoop first");

  if(!isDefined(self.ticks[tickIndex].statements["actions"])) {
    self.ticks[tickIndex].statements["actions"] = [];
  }

  actionIndex = self.ticks[tickIndex].statements["actions"].size;

  self.ticks[tickIndex].statements["actions"][actionIndex] = [];
  self.ticks[tickIndex].statements["actions"][actionIndex]["vars"] = [time];
  self.ticks[tickIndex].statements["actions"][actionIndex]["func"] = ::doBuildDOT_wait;
}

onEnterDOT_buildFunc(idx, trigger) {
  AssertEx(isDefined(idx), "Must specify an index for this function");
  AssertEx(isDefined(trigger), "trying to run tick function on DOT that has been removed or is undefined");

  entNum = trigger GetEntityNumber();

  trigger endon("death");
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum);

  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + entNum);

  entNum = undefined;
  statements = trigger.ticks[idx].statements;

  if(!isDefined(statements) ||
    !isDefined(statements["vars"]) ||
    !isDefined(statements["vars"]["count"]) ||
    !isDefined(statements["actions"])) {
    return;
  }
  count = statements["vars"]["count"];
  actions = statements["actions"];
  statements = undefined;

  for(i = 1; i <= count || count == 0; i--) {
    foreach(action in actions) {
      vars = action["vars"];
      func = action["func"];

      self[[func]](idx, trigger, vars);
    }
  }
}

onExitDOT_buildFunc(idx, trigger) {
  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();

  trigger notify("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);
}

onDeathDOT_buildFunc(idx, trigger) {}

doBuildDOT_damage(idx, trigger, vars) {
  AssertEx(isDefined(idx), "Must specify an index >= 0");
  AssertEx(isDefined(trigger), "Must specify a trigger");
  AssertEx(isDefined(vars), "Must specify vars");

  minDamage = vars[0];
  maxDamage = vars[1];
  falloff = vars[2];
  damageFlag = vars[3];
  meansOfDeath = vars[4];
  weapon = vars[5];

  self thread[[level.callbackPlayerDamage]](
    trigger,
    trigger,
    maxDamage,
    damageFlag,
    meansOfDeath,
    weapon,
    trigger.origin,
    (0, 0, 0) - trigger.origin,
    "none",
    0
  );
}

doBuildDOT_wait(idx, trigger, vars) {
  AssertEx(isDefined(idx), "Must specify an index >= 0");
  AssertEx(isDefined(trigger), "Must specify a trigger");
  AssertEx(isDefined(vars), "Must specify vars");

  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();

  trigger endon("death");
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum);
  trigger notify("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);

  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + entNum);

  entNum = undefined;
  playerNum = undefined;

  wait vars[0];
}

startDOT_group(dots) {
  AssertEx(isDefined(dots), "Must specify an array of dots to start");

  triggers = [];

  foreach(dot in dots) {
    trigger = undefined;

    switch (dot.type) {
      case "trigger_radius":
        trigger = spawn("trigger_radius", dot.origin, dot.spawnflags, dot.radius, dot.height);
        AssertEx(isDefined(trigger), "Could not spawn a trigger, too many entities");

        trigger.minRadius = dot.minRadius;
        trigger.maxRadius = dot.maxRadius;
        trigger.ticks = dot.ticks;
        triggers[triggers.size] = trigger;
        break;
      default:
        AssertMsg(".type for DOT is not supported");
    }

    if(isDefined(dot.parent)) {
      trigger LinkTo(dot.parent);
      dot.parent.dot = trigger;
    }

    ticks = trigger.ticks;

    foreach(tick in ticks) {
      tick.startTime = GetTime();
    }

    foreach(tick in ticks) {
      if(!tick.delay)
    }
    tick.enable = 1;

    foreach(tick in ticks) {
      if(IsSubStr(tick.affected, "player")) {
        trigger.onPlayer = 1;
        break;
      }
    }
  }

  foreach(trigger in triggers) {
    trigger.DOT_group = [];

    foreach(_trigger in triggers) {
      if(trigger == _trigger) {
        continue;
      }
      trigger.DOT_group[trigger.DOT_group.size] = _trigger;
    }
  }

  foreach(trigger in triggers) {
    if(trigger.onPlayer)
  }
  trigger thread startDOT_player();

  foreach(trigger in triggers) {
    trigger thread monitorDOT();
  }
}

startDOT_player() {
  self thread triggerTouchThink(::onEnterDOT_player, ::onExitDOT_player);
}

monitorDOT() {
  startTime = GetTime();

  for(; isDefined(self); wait 0.05) {
    foreach(i, tick in self.ticks) {
      if(isDefined(tick) && GetTime() - startTime >= tick.duration * 1000) {
        entNum = self GetEntityNumber();
        self notify("LISTEN_kill_tick_" + i + "_" + entNum);
        self.ticks[i] = undefined;
      }
    }

    if(!self.ticks.size) {
      break;
    }
  }

  if(isDefined(self)) {
    foreach(tick in self.ticks) {
      self[[tick.onDeathFunc]]();
    }

    self notify("death");
    self Delete();
  }
}

onEnterDOT_player(trigger) {
  Assert(isDefined(trigger));

  entNum = trigger GetEntityNumber();

  self notify("LISTEN_enter_dot_" + entNum);

  foreach(i, tick in trigger.ticks) {
    if(!tick.enable)
  }
  self thread doDOT_delayFunc(i, trigger, tick.delay, tick.onEnterFunc);

  foreach(i, tick in trigger.ticks) {
    if(tick.enable && tick.affected == "player")
  }
  self thread[[tick.onEnterFunc]](i, trigger);
}

onExitDOT_player(trigger) {
  Assert(isDefined(trigger));

  entNum = trigger GetEntityNumber();

  self notify("LISTEN_exit_dot_" + entNum);

  foreach(i, tick in trigger.ticks) {
    if(tick.enable && tick.affected == "player")
  }
  self thread[[tick.onExitFunc]](i, trigger);
}

doDOT_delayFunc(idx, trigger, delay, func) {
  Assert(isDefined(trigger));

  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();

  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);

  self endon("disconnect");
  self endon("game_ended");
  self endon("death");

  self notify("LISTEN_exit_dot_" + entNum);

  entNum = undefined;
  playerNum = undefined;

  wait delay;

  self thread[[func]](idx, trigger);
}

onEnterDOT_poisonDamagePlayer(idx, trigger) {
  AssertEx(isDefined(idx), "Must specify an index for this function");
  AssertEx(isDefined(trigger), "trying to run tick function on DOT that has been removed or is undefined");

  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();

  trigger endon("death");
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum);
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);

  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + entNum);

  if(!isDefined(self.onEnterDOT_poisonDamageCount)) {
    self.onEnterDOT_poisonDamageCount = [];
  }
  if(!isDefined(self.onEnterDOT_poisonDamageCount[idx])) {
    self.onEnterDOT_poisonDamageCount[idx] = [];
  }
  self.onEnterDOT_poisonDamageCount[idx][entNum] = 0;

  damageMultiplier = ter_op(isSP(), 1.5, 1);

  for(; isDefined(trigger) && isDefined(trigger.ticks[idx]); wait trigger.ticks[idx].interval) {
    self.onEnterDOT_poisonDamageCount[idx][entNum]++;

    switch (self.onEnterDOT_poisonDamageCount[idx][entNum]) {
      case 1:
        self ViewKick(1, self.origin);
        break;
      case 3:
        self ShellShock("mp_radiation_low", 4);

        self doDOT_poisonDamage(trigger, damageMultiplier * 2);
        break;
      case 4:
        self ShellShock("mp_radiation_med", 5);

        self thread doDOT_poisonBlackout(idx, trigger);
        self doDOT_poisonDamage(trigger, damageMultiplier * 2);
        break;
      case 6:
        self ShellShock("mp_radiation_high", 5);

        self doDOT_poisonDamage(trigger, damageMultiplier * 2);
        break;
      case 8:
        self ShellShock("mp_radiation_high", 5);

        self doDOT_poisonDamage(trigger, damageMultiplier * 500);
        break;
    }
  }
}

onExitDOT_poisonDamagePlayer(idx, trigger) {
  AssertEx(isDefined(idx), "Must specify an index for this function");
  AssertEx(isDefined(trigger), "trying to run tick function on DOT that has been removed or is undefined");

  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();
  overlays = self.onEnterDOT_poisonDamageOverlay;

  if(isDefined(overlays)) {
    foreach(i, _ in overlays) {
      if(isDefined(overlays[i]) &&
        isDefined(overlays[i][entNum])) {
        overlays[i][entNum] thread doDOT_fadeOutBlackOut(0.1, 0);
      }
    }
  }
  trigger notify("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);
}

onDeathDOT_poisonDamagePlayer() {
  entNum = self GetEntityNumber();

  foreach(player in level.players) {
    overlays = player.onEnterDOT_poisonDamageOverlay;

    if(isDefined(overlays)) {
      foreach(i, _ in overlays) {
        if(isDefined(overlays[i]) &&
          isDefined(overlays[i][entNum])) {
          overlays[i][entNum] thread doDOT_fadeOutBlackOutAndDestroy();
        }
      }
    }
  }
}

doDOT_poisonDamage(trigger, damage) {
  if(isSP()) {} else {
    self thread[[level.callbackPlayerDamage]](
      trigger,
      trigger,
      damage,
      0,
      "MOD_SUICIDE",
      "claymore_mp",
      trigger.origin,
      (0, 0, 0) - trigger.origin,
      "none",
      0
    );
  }
}

doDOT_poisonBlackout(idx, trigger) {
  AssertEx(isDefined(idx), "Must specify an index for this function");
  AssertEx(isDefined(trigger), "trying to run tick function on DOT that has been removed or is undefined");

  entNum = trigger GetEntityNumber();
  playerNum = self GetEntityNumber();

  trigger endon("death");
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum);
  trigger endon("LISTEN_kill_tick_" + idx + "_" + entNum + "_" + playerNum);

  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + entNum);

  if(!isDefined(self.onEnterDOT_poisonDamageOverlay)) {
    self.onEnterDOT_poisonDamageOverlay = [];
  }
  if(!isDefined(self.onEnterDOT_poisonDamageOverlay[idx])) {
    self.onEnterDOT_poisonDamageOverlay[idx] = [];
  }

  if(!isDefined(self.onEnterDOT_poisonDamageOverlay[idx][entNum])) {
    overlay = NewClientHudElem(self);
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignX = "left";
    overlay.alignY = "top";
    overlay.horzAlign = "fullscreen";
    overlay.vertAlign = "fullscreen";
    overlay.alpha = 0;
    overlay SetShader("black", 640, 480);

    self.onEnterDOT_poisonDamageOverlay[idx][entNum] = overlay;
  }

  overlay = self.onEnterDOT_poisonDamageOverlay[idx][entNum];

  min_length = 1;
  max_length = 2;
  min_alpha = .25;
  max_alpha = 1;

  min_percent = 5;
  max_percent = 100;

  fraction = 0;

  for(;;) {
    while(self.onEnterDOT_poisonDamageCount[idx][entNum] > 1) {
      percent_range = max_percent - min_percent;
      fraction = (self.onEnterDOT_poisonDamageCount[idx][entNum] - min_percent) / percent_range;

      if(fraction < 0) {
        fraction = 0;
      } else if(fraction > 1) {
        fraction = 1;
      }

      length_range = max_length - min_length;
      length = min_length + (length_range * (1 - fraction));

      alpha_range = max_alpha - min_alpha;
      alpha = min_alpha + (alpha_range * fraction);

      end_alpha = fraction * 0.5;

      if(fraction == 1) {
        break;
      }

      duration = length / 2;

      overlay doDOT_fadeInBlackOut(duration, alpha);
      overlay doDOT_fadeOutBlackOut(duration, end_alpha);

      wait(fraction * 0.5);
    }

    if(fraction == 1) {
      break;
    }

    if(overlay.alpha != 0) {
      overlay doDOT_fadeOutBlackOut(1, 0);
    }

    wait 0.05;
  }
  overlay doDOT_fadeInBlackOut(2, 0);
}

doDOT_fadeInBlackOut(duration, alpha) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  alpha = undefined;
  wait duration;
}

doDOT_fadeOutBlackOut(duration, alpha) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  alpha = undefined;
  wait duration;
}

doDOT_fadeOutBlackOutAndDestroy(duration, alpha) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  alpha = undefined;
  wait duration;
  self Destroy();
}

triggerTouchThink(enterFunc, exitFunc) {
  level endon("game_ended");
  self endon("death");

  self.entNum = self GetEntityNumber();

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player) && !isDefined(player.finished_spawning)) {
      continue;
    }
    if(!isAlive(player)) {
      continue;
    }
    if(!isDefined(player.touchTriggers[self.entNum])) {
      player thread playerTouchTriggerThink(self, enterFunc, exitFunc);
    }
  }
}

playerTouchTriggerThink(trigger, enterFunc, exitFunc) {
  trigger endon("death");

  if(!isPlayer(self)) {
    self endon("death");
  }

  if(!isSP()) {
    touchName = self.guid;
  } else {
    touchName = "player" + gettime();
  }

  trigger.touchList[touchName] = self;
  if(isDefined(trigger.moveTracker)) {
    self.moveTrackers++;
  }

  trigger notify("trigger_enter", self);
  self notify("trigger_enter", trigger);

  doEnterExitFunc = true;

  foreach(trig in trigger.DOT_group) {
    foreach(_trig in self.touchTriggers)
  }
  if(trig == _trig) {
    doEnterExitFunc = false;
  }

  if(doEnterExitFunc && isDefined(enterFunc)) {
    self thread[[enterFunc]](trigger);
  }

  self.touchTriggers[trigger.entNum] = trigger;

  while(IsAlive(self) && (isSP() || !level.gameEnded)) {
    touchingTrigger = true;

    if(self IsTouching(trigger)) {
      wait 0.05;
    } else {
      if(!trigger.DOT_group.size) {
        touchingTrigger = false;
      }

      foreach(trig in trigger.DOT_group) {
        if(self IsTouching(trig)) {
          wait 0.05;
          break;
        } else {
          touchingTrigger = false;
        }
      }
    }

    if(!touchingTrigger) {
      break;
    }
  }

  if(isDefined(self)) {
    self.touchTriggers[trigger.entNum] = undefined;
    if(isDefined(trigger.moveTracker)) {
      self.moveTrackers--;
    }

    self notify("trigger_leave", trigger);

    if(doEnterExitFunc && isDefined(exitFunc)) {
      self thread[[exitFunc]](trigger);
    }
  }

  if(!isSP() && level.gameEnded) {
    return;
  }
  trigger.touchList[touchName] = undefined;
  trigger notify("trigger_leave", self);

  if(!anythingTouchingTrigger(trigger)) {
    trigger notify("trigger_empty");
  }
}

anythingTouchingTrigger(trigger) {
  return (trigger.touchList.size);
}

get_precached_anim(animname) {
  println(animname);
  assertEX(isDefined(level._destructible_preanims) && isDefined(level._destructible_preanims[animname]), "Can't find destructible anim: " + animname + " check the Build Precache Scripts and Repackage Zone boxes In launcher when you compile your map. ");
  return level._destructible_preanims[animname];
}

get_precached_animtree(animname) {
  println(animname);
  AssertEX(isDefined(level._destructible_preanimtree) && isDefined(level._destructible_preanimtree[animname]), "Can't find destructible anim tree: " + animname + " check the Build Precache Scripts and Repackage Zone boxes In launcher when you compile your map. ");
  return level._destructible_preanimtree[animname];
}