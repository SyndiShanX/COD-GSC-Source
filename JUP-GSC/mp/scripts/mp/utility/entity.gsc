/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\entity.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace entity;

function getaverageorigin(ent_array) {
  avg_origin = (0, 0, 0);

  if(!ent_array.size) {
    return undefined;
  }

  foreach(ent in ent_array) {
    avg_origin += ent.origin;
  }

  avg_x = int(avg_origin[0] / ent_array.size);
  avg_y = int(avg_origin[1] / ent_array.size);
  avg_z = int(avg_origin[2] / ent_array.size);
  avg_origin = (avg_x, avg_y, avg_z);
  return avg_origin;
}

function touchingbadtrigger() {
  killtriggers = getEntArray("trigger_hurt", "classname");

  foreach(trigger in killtriggers) {
    if(self istouching(trigger)) {
      return true;
    }
  }

  radtriggers = getEntArray("radiation", "targetname");

  foreach(trigger in radtriggers) {
    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function touchingoobtrigger() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.outofboundstriggers)) {
    return false;
  }

  foreach(trigger in level.outofboundstriggers) {
    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size)) {
    return false;
  }

  self.allowedintrigger = 0;

  foreach(trigger in level.ballallowedtriggers) {
    if(self istouching(trigger)) {
      self.allowedintrigger = 1;
      return true;
    }
  }

  return false;
}

function touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size)) {
    return false;
  }

  self.allowedintrigger = 0;

  foreach(trigger in level.playerallowedtriggers) {
    if(self istouching(trigger)) {
      self.allowedintrigger = 1;
      return true;
    }
  }

  return false;
}

function findisfacing(ent1, ent2, tolerance) {
  facingcosine = cos(tolerance);
  ent1forwardvector = anglesToForward(ent1.angles);
  var_39166b57b87f75d = ent2.origin - ent1.origin;
  ent1forwardvector *= (1, 1, 0);
  var_39166b57b87f75d *= (1, 1, 0);
  var_39166b57b87f75d = vectorNormalize(var_39166b57b87f75d);
  ent1forwardvector = vectorNormalize(ent1forwardvector);
  targetcosine = vectordot(var_39166b57b87f75d, ent1forwardvector);

  if(targetcosine >= facingcosine) {
    return 1;
  }

  return 0;
}

function isaiteamparticipant(ent) {
  if(isagent(ent) && ent.agent_teamparticipant == 1) {
    return true;
  }

  if(isbot(ent)) {
    return true;
  }

  return false;
}

function isteamparticipant(ent) {
  if(isaiteamparticipant(ent)) {
    return true;
  }

  if(isPlayer(ent)) {
    return true;
  }

  return false;
}

function isvalidteamtarget(attacker, victimteam, target) {
  return isDefined(target.team) && target.team == victimteam;
}

function isvalidffatarget(attacker, victimteam, target) {
  return true;
}

function getlinknamenodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = strtok(self.script_linkto, " ");

    for(i = 0; i < linknames.size; i++) {
      ent = getnode(linknames[i], "script_linkname");

      if(isDefined(ent)) {
        array[array.size] = ent;
      }
    }
  }

  return array;
}

function function_d9ce8fb00f0e5fa1(origin, radius, desiredteam, excludeent) {
  return getentitiesinradius(origin, radius, desiredteam, excludeent, scripts\engine\trace::create_character_contents());
}

function getentitiesinradius(origin, radius, desiredteam, excludeent, physicscontents) {
  if(radius <= 0) {
    return [];
  }

  excludearray = undefined;

  if(isDefined(excludeent)) {
    if(isarray(excludeent)) {
      excludearray = excludeent;
    } else {
      excludearray = [excludeent];
    }
  }

  results = physics_querypoint(origin, radius, physicscontents, excludearray, "physicsquery_all");
  filteredresults = [];

  if(!isDefined(desiredteam)) {
    foreach(result in results) {
      e = result["entity"];

      if(isDefined(e)) {
        filteredresults[filteredresults.size] = e;
      }
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isDefined(e) && isDefined(e.team) && e.team == desiredteam) {
        filteredresults[filteredresults.size] = e;
      }
    }
  }

  if(getdvarint(@ "hash_9bb67ce9f0ab24e0", 0) > 0) {
    debugduration = 60;
    sphere(origin, radius, (1, 1, 1), 0, debugduration);

    foreach(entity in filteredresults) {
      sphere(entity.origin, 10, (1, 0, 0), 1, debugduration);
    }
  }

  return filteredresults;
}

function watchentitiesinradius(radiusrange, triggernotify, var_ecea6cda97e5f7ae, checkvisibility, playersonly) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    entitiesfound = undefined;

    if(playersonly) {
      entitiesfound = getplayersinradius(self.origin, radiusrange);
    } else {
      entitiesfound = getentitiesinradius(self.origin, radiusrange);
    }

    if(entitiesfound.size > 0) {
      if(!checkvisibility) {
        self notify(triggernotify, entitiesfound);
      } else {
        entities = [];

        foreach(entityfound in entitiesfound) {
          sourceposition = self getorigin();
          targetposition = ter_op(playersonly, entityfound getEye(), entityfound.origin);
          var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
          var_97db5d48f2509e02 = physics_raycast(sourceposition, targetposition, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest");

          if(var_97db5d48f2509e02.size <= 0) {
            entities[entities.size] = entityfound;
          }
        }

        self notify(triggernotify, entities);
      }
    }

    wait var_ecea6cda97e5f7ae;
  }
}

function cancelentitiesinradius() {
  self notify("end_entities_in_radius");
}

function placeequipmentfailed(weapon, showfx, position, angles) {
  assert(isDefined(showfx) && isDefined(position) || !isDefined(showfx) && !isDefined(position));
  self playlocalsound("scavenger_pack_pickup");

  if(istrue(showfx)) {
    fxent = undefined;

    if(isDefined(angles)) {
      fxent = spawnfxforclient(getfx("placeEquipmentFailed"), position, self, anglesToForward(angles), anglestoup(angles));
    } else {
      fxent = spawnfxforclient(getfx("placeEquipmentFailed"), position, self);
    }

    triggerfx(fxent);
    thread placeequipmentfailedcleanup(fxent);
  }

  switch (weapon) {
    case #"hash_36d0be2b0f1c99e":
    case #"hash_523f0c8fe1ead306":
    case #"hash_5e3fa526a48eaaa5":
    case #"hash_d059dcc3a7f1308a":
    case #"hash_eec4a41906598dfc":
      if(isPlayer(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
        self iprintlnbold("Placement Failed");
      }

      break;
  }
}

function placeequipmentfailedinit() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
}

function placeequipmentfailedcleanup(fxent) {
  wait 2;
  fxent delete();
}

function isspidergrenade(ent) {
  return istrue(ent.isspidergrenade);
}

function issupertrophy(ent) {
  entnum = ent getentitynumber();

  if(!isDefined(level.supertrophy)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies[entnum])) {
    return false;
  }

  return level.supertrophy.trophies[entnum] == ent;
}

function ismicroturret(ent) {
  entnum = ent getentitynumber();

  if(!isDefined(level.microturrets)) {
    return false;
  }

  if(!isDefined(level.microturrets[entnum])) {
    return false;
  }

  return level.microturrets[entnum] == ent;
}

function ischoppergunner(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  ischopper = ent.streakinfo.streakname == "chopper_gunner";
  return ischopper;
}

function issupporthelo(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  ischopper = ent.streakinfo.streakname == "chopper_support";
  return ischopper;
}

function isclusterstrike(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  var_30c3ced8e8637755 = ent.streakinfo.streakname == "toma_strike";
  return var_30c3ced8e8637755;
}

function isuav(ent) {
  if(!isDefined(ent.streakinfo)) {
    return false;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return false;
  }

  if(ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isgunship(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  var_f930e97582eaea73 = ent.streakinfo.streakname == "gunship";
  return var_f930e97582eaea73;
}

function isradardrone(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isradar = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon";
  return isradar;
}

function isscramblerdrone(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isscrambler = ent.streakinfo.streakname == "scrambler_drone_guard" || ent.streakinfo.streakname == "counter_uav";
  return isscrambler;
}

function isradarhelicopter(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isradar = ent.streakinfo.streakname == "radar_drone_overwatch";
  return isradar;
}

function isassaultdrone(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isradar = ent.streakinfo.streakname == "assault_drone";
  return isradar;
}

function isturret(ent) {
  return isDefined(ent.classname) && ent.classname == "misc_turret";
}

function isdronepackage(ent) {
  return isDefined(ent.cratetype);
}

function _enableequipdeployvfx() {
  if(!isDefined(self.enabledequipdeployvfx)) {
    self.enabledequipdeployvfx = 0;
  }

  if(self.enabledequipdeployvfx == 0) {
    self enableequipdeployvfx(1);
  }

  self.enabledequipdeployvfx++;
}

function _disableequipdeployvfx() {
  assert(isDefined(self.enabledequipdeployvfx) && self.enabledequipdeployvfx > 0, "<dev string:x1c>");

  if(self.enabledequipdeployvfx == 1) {
    self enableequipdeployvfx(0);
  }

  self.enabledequipdeployvfx--;
}

function register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);
    level notify("physSnd", self, body0, body1, flag0, flag1, position, normal, impulse, ent);
  }
}

function global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  while(true) {
    level waittill("physSnd", var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d);

    if(isDefined(var_c92ef281c1d335fc) && isDefined(var_c92ef281c1d335fc.phys_sound_func)) {
      level thread[[var_c92ef281c1d335fc.phys_sound_func]](var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d);
    }
  }
}

function register_physics_collision_func(entity, function_name) {
  entity.phys_sound_func = function_name;
}

function istouchingboundstrigger(ent) {
  return istrue(ent.alreadytouchingtrigger);
}

function istouchingboundsnullify(ent) {
  var_5c40098b82789b9 = 0;

  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(patch in level.outofboundstriggerpatches) {
      if(ent istouching(patch)) {
        var_5c40098b82789b9 = 1;
        break;
      }
    }
  }

  return var_5c40098b82789b9;
}

function deleteonplayerdeathdisconnect(player) {
  self endon("death");
  player waittill("death_or_disconnect");
  self delete();
}

function deleteatframeend() {
  self endon("death");
  waittillframeend();
  self delete();
}