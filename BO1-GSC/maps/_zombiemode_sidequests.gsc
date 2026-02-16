/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_sidequests.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init_sidequests() {
  level._sidequest_icons_base_x = -225;
  level._zombie_sidequests = [];
}
damager_trigger_thread(dam_types, trigger_func) {
  while(1) {
    self waittill("damage", amount, attacker, dir, point, type);
    self.dam_amount = amount;
    self.attacker = attacker;
    self.dam_dir = dir;
    self.dam_point = point;
    self.dam_type = type;
    for(i = 0; i < dam_types.size; i++) {
      if(type == dam_types[i]) {
        break;
      }
    }
  }
  if(isDefined(trigger_func)) {
    self[[trigger_func]]();
  }
  self notify("triggered");
}
damage_trigger_thread() {
  self endon("death");
  while(1) {
    self waittill("damage");
    self.owner_ent notify("triggered");
  }
}
sidequest_uses_teleportation(name) {
  level._zombie_sidequests[name].uses_teleportation = true;
}
declare_sidequest_icon(sidequest_name, icon_name, shader_name) {
  sidequest = level._zombie_sidequests[sidequest_name];
  sidequest.icons[icon_name] = shader_name;
}
create_icon(shader_name, x) {
  icon = create_simple_hud(self);
  icon.foreground = true;
  icon.sort = 2;
  icon.hidewheninmenu = false;
  icon.alignX = "center";
  icon.alignY = "bottom";
  icon.horzAlign = "user_right";
  icon.vertAlign = "user_bottom";
  icon.x = x;
  icon.y = 0;
  icon.alpha = 1;
  icon setshader(shader_name, 32, 32);
  return (icon);
}
add_sidequest_icon(sidequest_name, icon_name) {
  if(!isDefined(self.sidequest_icons)) {
    self.sidequest_icons = [];
  }
  if(isDefined(self.sidequest_icons[icon_name])) {
    return;
  }
  sq = level._zombie_sidequests[sidequest_name];
  base_x = level._sidequest_icons_base_x;
  if(isDefined(level._zombiemode_sidequest_icon_offset)) {
    base_x += level._zombiemode_sidequest_icon_offset;
  }
  self.sidequest_icons[icon_name] = self create_icon(sq.icons[icon_name], base_x + (self.sidequest_icons.size * 34));
}
remove_sidequest_icon(sidequest_name, icon_name) {
  if(!isDefined(self.sidequest_icons)) {
    return;
  }
  if(!isDefined(self.sidequest_icons[icon_name])) {
    return;
  }
  icon = self.sidequest_icons[icon_name];
  new_array = [];
  keys = GetArrayKeys(self.sidequest_icons);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] != icon_name) {
      new_array[keys[i]] = self.sidequest_icons[keys[i]];
    }
  }
  self.sidequest_icons = new_array;
  icon Destroy();
  keys = GetArrayKeys(self.sidequest_icons);
  base_x = level._sidequest_icons_base_x;
  if(isDefined(level._zombiemode_sidequest_icon_offset)) {
    base_x += level._zombiemode_sidequest_icon_offset;
  }
  for(i = 0; i < keys.size; i++) {
    self.sidequest_icons[keys[i]].x = base_x + (i * 34);
  }
}
declare_sidequest(name, init_func, logic_func, complete_func, generic_stage_start_func, generic_stage_end_func) {
  if(!isDefined(level._zombie_sidequests)) {
    init_sidequests();
  }
  sq = spawnStruct();
  sq.name = name;
  sq.stages = [];
  sq.last_completed_stage = -1;
  sq.active_stage = -1;
  sq.sidequest_complete = false;
  sq.init_func = init_func;
  sq.logic_func = logic_func;
  sq.complete_func = complete_func;
  sq.generic_stage_start_func = generic_stage_start_func;
  sq.generic_stage_end_func = generic_stage_end_func;
  sq.assets = [];
  sq.uses_teleportation = false;
  sq.active_assets = [];
  sq.icons = [];
  sq.num_reps = 0;
  level._zombie_sidequests[name] = sq;
}
declare_sidequest_stage(sidequest_name, stage_name, init_func, logic_func, exit_func) {
  stage = spawnStruct();
  stage.name = stage_name;
  stage.stage_number = level._zombie_sidequests[sidequest_name].stages.size;
  stage.assets = [];
  stage.active_assets = [];
  stage.logic_func = logic_func;
  stage.init_func = init_func;
  stage.exit_func = exit_func;
  stage.completed = false;
  stage.time_limit = 0;
  level._zombie_sidequests[sidequest_name].stages[stage_name] = stage;
}
set_stage_time_limit(sidequest_name, stage_name, time_limit, timer_func) {
  level._zombie_sidequests[sidequest_name].stages[stage_name].time_limit = time_limit;
  level._zombie_sidequests[sidequest_name].stages[stage_name].time_limit_func = timer_func;
}
declare_stage_asset_from_struct(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {
  structs = getStructArray(target_name, "targetname");
  for(i = 0; i < structs.size; i++) {
    asset = spawnStruct();
    asset.type = "struct";
    asset.struct = structs[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].stages[stage_name].assets[level._zombie_sidequests[sidequest_name].stages[stage_name].assets.size] = asset;
  }
}
declare_stage_title(sidequest_name, stage_name, title) {
  level._zombie_sidequests[sidequest_name].stages[stage_name].title = title;
}
declare_stage_asset(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {
  ents = getEntArray(target_name, "targetname");
  for(i = 0; i < ents.size; i++) {
    asset = spawnStruct();
    asset.type = "entity";
    asset.ent = ents[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].stages[stage_name].assets[level._zombie_sidequests[sidequest_name].stages[stage_name].assets.size] = asset;
  }
}
declare_sidequest_asset(sidequest_name, target_name, thread_func, trigger_thread_func) {
  ents = getEntArray(target_name, "targetname");
  for(i = 0; i < ents.size; i++) {
    asset = spawnStruct();
    asset.type = "entity";
    asset.ent = ents[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    asset.ent.thread_func = thread_func;
    asset.ent.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].assets[level._zombie_sidequests[sidequest_name].assets.size] = asset;
  }
}
declare_sidequest_asset_from_struct(sidequest_name, target_name, thread_func, trigger_thread_func) {
  structs = getStructArray(target_name, "targetname");
  for(i = 0; i < structs.size; i++) {
    asset = spawnStruct();
    asset.type = "struct";
    asset.struct = structs[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].assets[level._zombie_sidequests[sidequest_name].assets.size] = asset;
  }
}
build_asset_from_struct(asset, parent_struct) {
  ent = spawn("script_model", asset.origin);
  if(isDefined(asset.model)) {
    ent setModel(asset.model);
  }
  if(isDefined(asset.angles)) {
    ent.angles = asset.angles;
  }
  ent.script_noteworthy = asset.script_noteworthy;
  ent.type = "struct";
  ent.radius = asset.radius;
  ent.thread_func = parent_struct.thread_func;
  ent.trigger_thread_func = parent_struct.trigger_thread_func;
  ent.script_vector = parent_struct.script_vector;
  asset.trigger_thread_func = parent_struct.trigger_thread_func;
  asset.script_vector = parent_struct.script_vector;
  ent.target = asset.target;
  ent.script_float = asset.script_float;
  ent.script_int = asset.script_int;
  ent.script_trigger_spawnflags = asset.script_trigger_spawnflags;
  ent.targetname = asset.targetname;
  return ent;
}
delete_stage_assets() {
  for(i = 0; i < self.active_assets.size; i++) {
    asset = self.active_assets[i];
    switch (asset.type) {
      case "struct":
        if(isDefined(asset.trigger)) {
          PrintLn("Deleting trigger from struct type asset.");
          asset.trigger Delete();
          asset.trigger = undefined;
        }
        asset Delete();
        break;
      case "entity":
        if(isDefined(asset.trigger)) {
          PrintLn("Deleting trigger from ent type asset.");
          asset.trigger Delete();
          asset.trigger = undefined;
        }
        break;
    }
  }
  remaining_assets = [];
  for(i = 0; i < self.active_assets.size; i++) {
    if(isDefined(self.active_assets[i])) {
      remaining_assets[remaining_assets.size] = self.active_assets[i];
    }
  }
  self.active_assets = remaining_assets;
}
build_assets() {
  for(i = 0; i < self.assets.size; i++) {
    asset = undefined;
    switch (self.assets[i].type) {
      case "struct":
        asset = self.assets[i].struct;
        self.active_assets[self.active_assets.size] = build_asset_from_struct(asset, self.assets[i]);
        break;
      case "entity":
        for(j = 0; j < self.active_assets.size; j++) {
          if(self.active_assets[j] == self.assets[i].ent) {
            asset = self.active_assets[j];
            break;
          }
        }
        asset = self.assets[i].ent;
        asset.type = "entity";
        self.active_assets[self.active_assets.size] = asset;
        break;
      default:
        PrintLn("*** ERROR: Don't know how to build asset of type " + self.assets.type);
        break;
    }
    if((isDefined(asset.script_noteworthy) && (self.assets[i].type == "entity" && !isDefined(asset.trigger))) || isDefined(asset.script_noteworthy)) {
      trigger_radius = 15;
      trigger_height = 72;
      if(isDefined(asset.radius)) {
        trigger_radius = asset.radius;
      }
      if(isDefined(asset.height)) {
        trigger_height = asset.height;
      }
      trigger_spawnflags = 0;
      if(isDefined(asset.script_trigger_spawnflags)) {
        trigger_spawnflags = asset.script_trigger_spawnflags;
      }
      trigger_offset = (0, 0, 0);
      if(isDefined(asset.script_vector)) {
        trigger_offset = asset.script_vector;
      }
      switch (asset.script_noteworthy) {
        case "trigger_radius_use":
          use_trigger = spawn("trigger_radius_use", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height);
          use_trigger SetCursorHint("HINT_NOICON");
          if(isDefined(asset.radius)) {
            use_trigger.radius = asset.radius;
          }
          use_trigger.owner_ent = self.active_assets[self.active_assets.size - 1];
          if(isDefined(asset.trigger_thread_func)) {
            use_trigger thread[[asset.trigger_thread_func]]();
          } else {
            use_trigger thread use_trigger_thread();
          }
          self.active_assets[self.active_assets.size - 1].trigger = use_trigger;
          break;
        case "trigger_radius_damage":
          damage_trigger = spawn("trigger_damage", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height);
          if(isDefined(asset.radius)) {
            damage_trigger.radius = asset.radius;
          }
          damage_trigger.owner_ent = self.active_assets[self.active_assets.size - 1];
          if(isDefined(asset.trigger_thread_func)) {
            damage_trigger thread[[asset.trigger_thread_func]]();
          } else {
            damage_trigger thread damage_trigger_thread();
          }
          self.active_assets[self.active_assets.size - 1].trigger = damage_trigger;
          break;
        case "trigger_radius":
          radius_trigger = spawn("trigger_radius", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height);
          if(isDefined(asset.radius)) {
            radius_trigger.radius = asset.radius;
          }
          radius_trigger.owner_ent = self.active_assets[self.active_assets.size - 1];
          if(isDefined(asset.trigger_thread_func)) {
            radius_trigger thread[[asset.trigger_thread_func]]();
          } else {
            radius_trigger thread radius_trigger_thread();
          }
          self.active_assets[self.active_assets.size - 1].trigger = radius_trigger;
          break;
      }
    }
    if(isDefined(self.assets[i].thread_func) && !isDefined(self.active_assets[self.active_assets.size - 1].dont_rethread)) {
      self.active_assets[self.active_assets.size - 1] thread[[self.assets[i].thread_func]]();
    }
    if(i % 2 == 0) {
      wait_network_frame();
    }
  }
}
radius_trigger_thread() {
  self endon("death");
  while(1) {
    self waittill("trigger", player);
    if(!isPlayer(player)) {
      continue;
    }
    self.owner_ent notify("triggered");
    while(player IsTouching(self)) {
      wait(0.05);
    }
    self.owner_ent notify("untriggered");
  }
}
thread_on_assets(target_name, thread_func) {
  for(i = 0; i < self.active_assets.size; i++) {
    if(self.active_assets[i].targetname == target_name) {
      self.active_assets[i] thread[[thread_func]]();
    }
  }
}
stage_logic_func_wrapper(sidequest, stage) {
  if(isDefined(stage.logic_func)) {
    level endon(sidequest.name + "_" + stage.name + "_over");
    stage[[stage.logic_func]]();
  }
}
sidequest_start(sidequest_name) {
  sidequest = level._zombie_sidequests[sidequest_name];
  sidequest build_assets();
  if(isDefined(sidequest.init_func)) {
    sidequest[[sidequest.init_func]]();
  }
  if(isDefined(sidequest.logic_func)) {
    sidequest thread[[sidequest.logic_func]]();
  }
}
stage_start(sidequest, stage) {
  if(IsString(sidequest)) {
    sidequest = level._zombie_sidequests[sidequest];
  }
  if(IsString(stage)) {
    stage = sidequest.stages[stage];
  }
  stage build_assets();
  sidequest.active_stage = stage.stage_number;
  level notify(sidequest.name + "_" + stage.name + "_started");
  stage.completed = false;
  if(isDefined(sidequest.generic_stage_start_func)) {
    stage[[sidequest.generic_stage_start_func]]();
  }
  if(isDefined(stage.init_func)) {
    stage[[stage.init_func]]();
  }
  level._last_stage_started = stage.name;
  level thread stage_logic_func_wrapper(sidequest, stage);
  if(stage.time_limit > 0) {
    stage thread time_limited_stage(sidequest);
  }
  if(isDefined(stage.title)) {
    stage thread display_stage_title(sidequest.uses_teleportation);
  }
}
display_stage_title(wait_for_teleport_done_notify) {
  if(wait_for_teleport_done_notify) {
    level waittill("teleport_done");
    wait(2.0);
  }
  stage_text = NewHudElem();
  stage_text.location = 0;
  stage_text.alignX = "center";
  stage_text.alignY = "middle";
  stage_text.foreground = 1;
  stage_text.fontScale = 1.6;
  stage_text.sort = 20;
  stage_text.x = 320;
  stage_text.y = 300;
  stage_text.og_scale = 1;
  stage_text.color = (128, 0, 0);
  stage_text.alpha = 0;
  stage_text.fontstyle3d = "shadowedmore";
  stage_text SetText(self.title);
  stage_text FadeOverTime(0.5);
  stage_text.alpha = 1;
  wait(5.0);
  stage_text FadeOverTime(1.0);
  stage_text.alpha = 0;
  wait(1.0);
  stage_text Destroy();
}
time_limited_stage(sidequest) {
  level endon(sidequest.name + "_" + self.name + "_over");
  level endon("suspend_timer");
  level endon("end_game");
  time_limit = undefined;
  if(isDefined(self.time_limit_func)) {
    time_limit = [[self.time_limit_func]]() * 0.25;
  } else {
    time_limit = self.time_limit * 0.25;
  }
  wait(time_limit);
  level notify("timed_stage_75_percent");
  wait(time_limit);
  level notify("timed_stage_50_percent");
  wait(time_limit);
  level notify("timed_stage_25_percent");
  wait(time_limit - 10);
  level notify("timed_stage_10_seconds_to_go");
  wait(10);
  stage_failed(sidequest, self);
}
sidequest_println(str) {}
precache_sidequest_assets() {
  sidequest_names = GetArrayKeys(level._zombie_sidequests);
  for(i = 0; i < sidequest_names.size; i++) {
    sq = level._zombie_sidequests[sidequest_names[i]];
    icon_keys = GetArrayKeys(sq.icons);
    for(j = 0; j < icon_keys.size; j++) {
      PreCacheShader(sq.icons[icon_keys[j]]);
    }
    stage_names = GetArrayKeys(sq.stages);
    for(j = 0; j < stage_names.size; j++) {
      stage = sq.stages[stage_names[j]];
      for(k = 0; k < stage.assets.size; k++) {
        asset = stage.assets[k];
        if(isDefined(asset.type) && asset.type == "struct") {
          if(isDefined(asset.model)) {
            PreCacheModel(asset.model);
          }
        }
      }
    }
  }
}
sidequest_complete(sidequest_name) {
  return (level._zombie_sidequests[sidequest_name].sidequest_complete);
}
stage_completed(sidequest_name, stage_name) {
  PrintLn("*** stage completed called.");
  sidequest = level._zombie_sidequests[sidequest_name];
  stage = sidequest.stages[stage_name];
  level thread stage_completed_internal(sidequest, stage);
}
stage_completed_internal(sidequest, stage) {
  level notify(sidequest.name + "_" + stage.name + "_over");
  level notify(sidequest.name + "_" + stage.name + "_completed");
  if(isDefined(sidequest.generic_stage_end_func)) {
    PrintLn("Calling generic end func.");
    stage[[sidequest.generic_stage_end_func]]();
  }
  if(isDefined(stage.exit_func)) {
    PrintLn("Calling stage end func.");
    stage[[stage.exit_func]](true);
  }
  stage.completed = true;
  sidequest.last_completed_stage = sidequest.active_stage;
  sidequest.active_stage = -1;
  stage delete_stage_assets();
  all_complete = true;
  stage_names = GetArrayKeys(sidequest.stages);
  for(i = 0; i < stage_names.size; i++) {
    if(sidequest.stages[stage_names[i]].completed == false) {
      all_complete = false;
      break;
    }
  }
  if(all_complete == true) {
    if(isDefined(sidequest.complete_func)) {
      sidequest thread[[sidequest.complete_func]]();
    }
    level notify("sidequest_" + sidequest.name + "_complete");
    sidequest.sidequest_completed = true;
  }
}
stage_failed_internal(sidequest, stage) {
  level notify(sidequest.name + "_" + stage.name + "_over");
  level notify(sidequest.name + "_" + stage.name + "_failed");
  if(isDefined(sidequest.generic_stage_end_func)) {
    stage[[sidequest.generic_stage_end_func]]();
  }
  if(isDefined(stage.exit_func)) {
    stage[[stage.exit_func]](false);
  }
  sidequest.active_stage = -1;
  stage delete_stage_assets();
}
stage_failed(sidequest, stage) {
  PrintLn("*** Stage failed called.");
  if(IsString(sidequest)) {
    sidequest = level._zombie_sidequests[sidequest];
  }
  if(IsString(stage)) {
    stage = sidequest.stages[stage];
  }
  level thread stage_failed_internal(sidequest, stage);
}
get_sidequest_stage(sidequest, stage_number) {
  stage = undefined;
  stage_names = GetArrayKeys(sidequest.stages);
  for(i = 0; i < stage_names.size; i++) {
    if(sidequest.stages[stage_names[i]].stage_number == stage_number) {
      stage = sidequest.stages[stage_names[i]];
      break;
    }
  }
  return stage;
}
get_damage_trigger(radius, origin, damage_types) {
  trig = spawn("trigger_damage", origin, 0, radius, 72);
  trig thread dam_trigger_thread(damage_types);
  return trig;
}
dam_trigger_thread(damage_types) {
  self endon("death");
  damage_type = "NONE";
  while(1) {
    self waittill("damage", amount, attacker, dir, point, mod);
    for(i = 0; i < damage_types.size; i++) {
      if(mod == damage_types[i]) {
        self notify("triggered");
      }
    }
  }
}
use_trigger_thread() {
  self endon("death");
  while(1) {
    self waittill("trigger", player);
    self.owner_ent notify("triggered", player);
    wait(0.1);
  }
}
sidequest_stage_active(sidequest_name, stage_name) {
  sidequest = level._zombie_sidequests[sidequest_name];
  stage = sidequest.stages[stage_name];
  if(sidequest.active_stage == stage.stage_number) {
    return true;
  } else {
    return false;
  }
}
sidequest_start_next_stage(sidequest_name) {
  sidequest = level._zombie_sidequests[sidequest_name];
  if(sidequest.sidequest_complete == true) {
    return;
  }
  last_completed = sidequest.last_completed_stage;
  if(last_completed == -1) {
    last_completed = 0;
  } else {
    last_completed++;
  }
  stage = get_sidequest_stage(sidequest, last_completed);
  if(!isDefined(stage)) {
    return;
  }
  stage_start(sidequest, stage);
  return (stage);
}
main() {}
is_facing(facee) {
  orientation = self getPlayerAngles();
  forwardVec = anglesToForward(orientation);
  forwardVec2D = (forwardVec[0], forwardVec[1], 0);
  unitForwardVec2D = VectorNormalize(forwardVec2D);
  toFaceeVec = facee.origin - self.origin;
  toFaceeVec2D = (toFaceeVec[0], toFaceeVec[1], 0);
  unitToFaceeVec2D = VectorNormalize(toFaceeVec2D);
  dotProduct = VectorDot(unitForwardVec2D, unitToFaceeVec2D);
  return (dotProduct > 0.9);
}
fake_use(notify_string, qualifier_func) {
  waittillframeend;
  while(1) {
    if(!isDefined(self)) {
      return;
    }
    players = get_players();
    for(i = 0; i < players.size; i++) {
      qualifier_passed = true;
      if(isDefined(qualifier_func)) {
        qualifier_passed = players[i][[qualifier_func]]();
      }
      if(qualifier_passed && (DistanceSquared(self.origin, players[i].origin) < 64 * 64)) {
        if(players[i] is_facing(self)) {
          if(players[i] useButtonPressed()) {
            self notify(notify_string, players[i]);
            return;
          }
        }
      }
    }
    wait(0.1);
  }
}