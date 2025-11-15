/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_sidequests.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#namespace zm_sidequests;

function init_sidequests() {
  level._zombie_sidequests = [];
  level thread sidequest_debug();
}

function is_sidequest_allowed(a_gametypes) {
  if(isDefined(level.gamedifficulty) && level.gamedifficulty == 0) {
    return 0;
  }
  b_is_gametype_active = 0;
  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }
  for(i = 0; i < a_gametypes.size; i++) {
    if(getdvarstring("g_gametype") == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }
  return b_is_gametype_active;
}

function sidequest_debug() {
  if(getdvarstring("") != "") {
    return;
  }
  while(true) {
    wait(1);
  }
}

function damager_trigger_thread(dam_types, trigger_func) {
  while(true) {
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

function damage_trigger_thread() {
  self endon("death");
  while(true) {
    self waittill("damage");
    self.owner_ent notify("triggered");
  }
}

function entity_damage_thread() {
  self endon("death");
  while(true) {
    self waittill("damage");
    self.owner_ent notify("triggered");
  }
}

function sidequest_uses_teleportation(name) {
  level._zombie_sidequests[name].uses_teleportation = 1;
}

function register_sidequest_icon(icon_name, version_number) {
  clientfieldprefix = ("sidequestIcons." + icon_name) + ".";
  clientfield::register("clientuimodel", clientfieldprefix + "icon", version_number, 1, "int");
  clientfield::register("clientuimodel", clientfieldprefix + "notification", version_number, 1, "int");
}

function add_sidequest_icon(sidequest_name, icon_name, var_275b4f28 = 1) {
  clientfield::set_player_uimodel(("sidequestIcons." + icon_name) + ".icon", 1);
  if(isDefined(var_275b4f28) && var_275b4f28) {
    clientfield::set_player_uimodel(("sidequestIcons." + icon_name) + ".notification", 1);
  }
}

function remove_sidequest_icon(sidequest_name, icon_name) {
  clientfield::set_player_uimodel(("sidequestIcons." + icon_name) + ".icon", 0);
  clientfield::set_player_uimodel(("sidequestIcons." + icon_name) + ".notification", 0);
}

function declare_sidequest(name, init_func, logic_func, complete_func, generic_stage_start_func, generic_stage_end_func) {
  if(!isDefined(level._zombie_sidequests)) {
    init_sidequests();
  }
  if(isDefined(level._zombie_sidequests[name])) {
    println("" + name);
    return;
  }
  sq = spawnStruct();
  sq.name = name;
  sq.stages = [];
  sq.last_completed_stage = -1;
  sq.active_stage = -1;
  sq.sidequest_complete = 0;
  sq.init_func = init_func;
  sq.logic_func = logic_func;
  sq.complete_func = complete_func;
  sq.generic_stage_start_func = generic_stage_start_func;
  sq.generic_stage_end_func = generic_stage_end_func;
  sq.assets = [];
  sq.uses_teleportation = 0;
  sq.active_assets = [];
  sq.icons = [];
  sq.num_reps = 0;
  level._zombie_sidequests[name] = sq;
}

function declare_sidequest_stage(sidequest_name, stage_name, init_func, logic_func, exit_func) {
  if(!isDefined(level._zombie_sidequests)) {
    println("");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + stage_name) + "") + sidequest_name) + "");
    return;
  }
  if(isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println((("" + sidequest_name) + "") + stage_name);
    return;
  }
  stage = spawnStruct();
  stage.name = stage_name;
  stage.stage_number = level._zombie_sidequests[sidequest_name].stages.size;
  stage.assets = [];
  stage.active_assets = [];
  stage.logic_func = logic_func;
  stage.init_func = init_func;
  stage.exit_func = exit_func;
  stage.completed = 0;
  stage.time_limit = 0;
  level._zombie_sidequests[sidequest_name].stages[stage_name] = stage;
}

function set_stage_time_limit(sidequest_name, stage_name, time_limit, timer_func) {
  if(!isDefined(level._zombie_sidequests)) {
    println("");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + stage_name) + "") + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println(((("" + stage_name) + "") + sidequest_name) + "");
    return;
  }
  level._zombie_sidequests[sidequest_name].stages[stage_name].time_limit = time_limit;
  level._zombie_sidequests[sidequest_name].stages[stage_name].time_limit_func = timer_func;
}

function declare_stage_asset_from_struct(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {
  structs = struct::get_array(target_name, "targetname");
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + target_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + target_name) + "") + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println(((((("" + target_name) + "") + sidequest_name) + "") + stage_name) + "");
    return;
  }
  if(!structs.size) {
    println(("" + target_name) + "");
    return;
  }
  for(i = 0; i < structs.size; i++) {
    asset = spawnStruct();
    asset.type = "struct";
    asset.struct = structs[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].stages[stage_name].assets[level._zombie_sidequests[sidequest_name].stages[stage_name].assets.size] = asset;
  }
}

function declare_stage_title(sidequest_name, stage_name, title) {
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + title) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + title) + "") + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println(((((("" + title) + "") + sidequest_name) + "") + stage_name) + "");
    return;
  }
  level._zombie_sidequests[sidequest_name].stages[stage_name].title = title;
}

function declare_stage_asset(sidequest_name, stage_name, target_name, thread_func, trigger_thread_func) {
  ents = getEntArray(target_name, "targetname");
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + target_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + target_name) + "") + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println(((((("" + target_name) + "") + sidequest_name) + "") + stage_name) + "");
    return;
  }
  if(!ents.size) {
    println(("" + target_name) + "");
    return;
  }
  for(i = 0; i < ents.size; i++) {
    asset = spawnStruct();
    asset.type = "entity";
    asset.ent = ents[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].stages[stage_name].assets[level._zombie_sidequests[sidequest_name].stages[stage_name].assets.size] = asset;
  }
}

function declare_sidequest_asset(sidequest_name, target_name, thread_func, trigger_thread_func) {
  ents = getEntArray(target_name, "targetname");
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + target_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + target_name) + "") + sidequest_name) + "");
    return;
  }
  if(!ents.size) {
    println(("" + target_name) + "");
    return;
  }
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

function declare_sidequest_asset_from_struct(sidequest_name, target_name, thread_func, trigger_thread_func) {
  structs = struct::get_array(target_name, "targetname");
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + target_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(((("" + target_name) + "") + sidequest_name) + "");
    return;
  }
  if(!structs.size) {
    println(("" + target_name) + "");
    return;
  }
  for(i = 0; i < structs.size; i++) {
    asset = spawnStruct();
    asset.type = "struct";
    asset.struct = structs[i];
    asset.thread_func = thread_func;
    asset.trigger_thread_func = trigger_thread_func;
    level._zombie_sidequests[sidequest_name].assets[level._zombie_sidequests[sidequest_name].assets.size] = asset;
  }
}

function build_asset_from_struct(asset, parent_struct) {
  ent = spawn("script_model", asset.origin);
  if(isDefined(asset.model)) {
    ent setModel(asset.model);
    asset.var_d0dd151f = ent;
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

function delete_stage_assets() {
  for(i = 0; i < self.active_assets.size; i++) {
    asset = self.active_assets[i];
    switch (asset.type) {
      case "struct": {
        if(isDefined(asset.trigger)) {
          println("");
          if(!(isDefined(asset.trigger.var_b82c7478) && asset.trigger.var_b82c7478)) {
            asset.trigger delete();
          }
          asset.trigger = undefined;
        }
        asset delete();
        break;
      }
      case "entity": {
        if(isDefined(asset.trigger)) {
          println("");
          asset.trigger delete();
          asset.trigger = undefined;
        }
        break;
      }
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

function build_assets() {
  for(i = 0; i < self.assets.size; i++) {
    asset = undefined;
    switch (self.assets[i].type) {
      case "struct": {
        asset = self.assets[i].struct;
        self.active_assets[self.active_assets.size] = build_asset_from_struct(asset, self.assets[i]);
        break;
      }
      case "entity": {
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
      }
      default: {
        println("" + self.assets.type);
        break;
      }
    }
    if(isDefined(asset.script_noteworthy) && (self.assets[i].type == "entity" && !isDefined(asset.trigger)) || isDefined(asset.script_noteworthy)) {
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
        case "trigger_radius_use": {
          use_trigger = spawn("trigger_radius_use", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height);
          use_trigger setcursorhint("HINT_NOICON");
          use_trigger triggerignoreteam();
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
        }
        case "trigger_radius_damage": {
          damage_trigger = spawn("trigger_damage", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height);
          damage_trigger.angles = asset.angles;
          damage_trigger.owner_ent = self.active_assets[self.active_assets.size - 1];
          if(isDefined(asset.trigger_thread_func)) {
            damage_trigger thread[[asset.trigger_thread_func]]();
          } else {
            damage_trigger thread damage_trigger_thread();
          }
          self.active_assets[self.active_assets.size - 1].trigger = damage_trigger;
          break;
        }
        case "trigger_radius": {
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
        case "entity_damage": {
          asset.var_d0dd151f setCanDamage(1);
          asset.owner_ent = self.active_assets[self.active_assets.size - 1];
          if(isDefined(asset.trigger_thread_func)) {
            asset.var_d0dd151f thread[[asset.trigger_thread_func]]();
          } else {
            asset.var_d0dd151f thread damage_trigger_thread();
          }
          break;
        }
      }
    }
    if(isDefined(self.assets[i].thread_func) && !isDefined(self.active_assets[self.active_assets.size - 1].dont_rethread)) {
      self.active_assets[self.active_assets.size - 1] thread[[self.assets[i].thread_func]]();
    }
    if((i % 2) == 0) {
      util::wait_network_frame();
    }
  }
}

function radius_trigger_thread() {
  self endon("death");
  while(true) {
    self waittill("trigger", player);
    if(!isplayer(player)) {
      continue;
    }
    self.owner_ent notify("triggered");
    while(player istouching(self)) {
      wait(0.05);
    }
    self.owner_ent notify("untriggered");
  }
}

function thread_on_assets(target_name, thread_func) {
  for(i = 0; i < self.active_assets.size; i++) {
    if(self.active_assets[i].targetname == target_name) {
      self.active_assets[i] thread[[thread_func]]();
    }
  }
}

function stage_logic_func_wrapper(sidequest, stage) {
  if(isDefined(stage.logic_func)) {
    level endon(((sidequest.name + "_") + stage.name) + "_over");
    stage[[stage.logic_func]]();
  }
}

function sidequest_start(sidequest_name) {
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(("" + sidequest_name) + "");
    return;
  }
  sidequest = level._zombie_sidequests[sidequest_name];
  sidequest build_assets();
  if(isDefined(sidequest.init_func)) {
    sidequest[[sidequest.init_func]]();
  }
  if(isDefined(sidequest.logic_func)) {
    sidequest thread[[sidequest.logic_func]]();
  }
}

function stage_start(sidequest, stage) {
  if(isstring(sidequest)) {
    sidequest = level._zombie_sidequests[sidequest];
  }
  if(isstring(stage)) {
    stage = sidequest.stages[stage];
  }
  stage build_assets();
  sidequest.active_stage = stage.stage_number;
  level notify(((sidequest.name + "_") + stage.name) + "_started");
  stage.completed = 0;
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

function display_stage_title(wait_for_teleport_done_notify) {
  if(wait_for_teleport_done_notify) {
    level waittill("teleport_done");
    wait(2);
  }
  stage_text = newhudelem();
  stage_text.location = 0;
  stage_text.alignx = "center";
  stage_text.aligny = "middle";
  stage_text.foreground = 1;
  stage_text.fontscale = 1.6;
  stage_text.sort = 20;
  stage_text.x = 320;
  stage_text.y = 300;
  stage_text.og_scale = 1;
  stage_text.color = vectorscale((1, 0, 0), 128);
  stage_text.alpha = 0;
  stage_text.fontstyle3d = "shadowedmore";
  stage_text settext(self.title);
  stage_text fadeovertime(0.5);
  stage_text.alpha = 1;
  wait(5);
  stage_text fadeovertime(1);
  stage_text.alpha = 0;
  wait(1);
  stage_text destroy();
}

function time_limited_stage(sidequest) {
  println(((((("" + sidequest.name) + "") + self.name) + "") + self.time_limit) + "");
  level endon(((sidequest.name + "_") + self.name) + "_over");
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

function sidequest_println(str) {
  if(getdvarstring("") != "") {
    return;
  }
  println(str);
}

function precache_sidequest_assets() {}

function sidequest_complete(sidequest_name) {
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(("" + sidequest_name) + "");
    return;
  }
  return level._zombie_sidequests[sidequest_name].sidequest_complete;
}

function stage_completed(sidequest_name, stage_name) {
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(("" + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name].stages[stage_name])) {
    println(((("" + sidequest_name) + "") + stage_name) + "");
    return;
  }
  println("");
  sidequest = level._zombie_sidequests[sidequest_name];
  stage = sidequest.stages[stage_name];
  level thread stage_completed_internal(sidequest, stage);
}

function stage_completed_internal(sidequest, stage) {
  level notify(((sidequest.name + "_") + stage.name) + "_over");
  level notify(((sidequest.name + "_") + stage.name) + "_completed");
  if(isDefined(sidequest.generic_stage_end_func)) {
    println("");
    stage[[sidequest.generic_stage_end_func]]();
  }
  if(isDefined(stage.exit_func)) {
    println("");
    stage[[stage.exit_func]](1);
  }
  stage.completed = 1;
  sidequest.last_completed_stage = sidequest.active_stage;
  sidequest.active_stage = -1;
  stage delete_stage_assets();
  all_complete = 1;
  stage_names = getarraykeys(sidequest.stages);
  for(i = 0; i < stage_names.size; i++) {
    if(sidequest.stages[stage_names[i]].completed == 0) {
      all_complete = 0;
      break;
    }
  }
  if(all_complete == 1) {
    if(isDefined(sidequest.complete_func)) {
      sidequest thread[[sidequest.complete_func]]();
    }
    level notify(("sidequest_" + sidequest.name) + "_complete");
    sidequest.sidequest_completed = 1;
  }
}

function stage_failed_internal(sidequest, stage) {
  level notify(((sidequest.name + "_") + stage.name) + "_over");
  level notify(((sidequest.name + "_") + stage.name) + "_failed");
  if(isDefined(sidequest.generic_stage_end_func)) {
    stage[[sidequest.generic_stage_end_func]]();
  }
  if(isDefined(stage.exit_func)) {
    stage[[stage.exit_func]](0);
  }
  sidequest.active_stage = -1;
  stage delete_stage_assets();
}

function stage_failed(sidequest, stage) {
  println("");
  if(isstring(sidequest)) {
    sidequest = level._zombie_sidequests[sidequest];
  }
  if(isstring(stage)) {
    stage = sidequest.stages[stage];
  }
  level thread stage_failed_internal(sidequest, stage);
}

function get_sidequest_stage(sidequest, stage_number) {
  stage = undefined;
  stage_names = getarraykeys(sidequest.stages);
  for(i = 0; i < stage_names.size; i++) {
    if(sidequest.stages[stage_names[i]].stage_number == stage_number) {
      stage = sidequest.stages[stage_names[i]];
      break;
    }
  }
  return stage;
}

function get_damage_trigger(radius, origin, damage_types) {
  trig = spawn("trigger_damage", origin, 0, radius, 72);
  trig thread dam_trigger_thread(damage_types);
  return trig;
}

function dam_trigger_thread(damage_types) {
  self endon("death");
  damage_type = "NONE";
  while(true) {
    self waittill("damage", amount, attacker, dir, point, mod);
    for(i = 0; i < damage_types.size; i++) {
      if(mod == damage_types[i]) {
        self notify("triggered");
      }
    }
  }
}

function use_trigger_thread() {
  self endon("death");
  while(true) {
    self waittill("trigger", player);
    self.owner_ent notify("triggered", player);
    wait(0.1);
  }
}

function sidequest_stage_active(sidequest_name, stage_name) {
  sidequest = level._zombie_sidequests[sidequest_name];
  stage = sidequest.stages[stage_name];
  if(sidequest.active_stage == stage.stage_number) {
    return true;
  }
  return false;
}

function sidequest_start_next_stage(sidequest_name) {
  if(!isDefined(level._zombie_sidequests)) {
    println(("" + sidequest_name) + "");
    return;
  }
  if(!isDefined(level._zombie_sidequests[sidequest_name])) {
    println(("" + sidequest_name) + "");
    return;
  }
  sidequest = level._zombie_sidequests[sidequest_name];
  if(sidequest.sidequest_complete == 1) {
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
    println((("" + sidequest_name) + "") + last_completed);
    return;
  }
  stage_start(sidequest, stage);
  return stage;
}

function main() {}

function is_facing(facee) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = facee.origin - self.origin;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > 0.9;
}

function fake_use(notify_string, qualifier_func) {
  waittillframeend();
  while(!(isDefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
    if(!isDefined(self)) {
      return;
    }
    print3d(self.origin, "", vectorscale((0, 1, 0), 255), 1);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      qualifier_passed = 1;
      if(isDefined(qualifier_func)) {
        qualifier_passed = players[i][
          [qualifier_func]
        ]();
      }
      if(qualifier_passed && distancesquared(self.origin, players[i].origin) < 4096) {
        if(players[i] is_facing(self)) {
          if(players[i] usebuttonpressed()) {
            self notify(notify_string, players[i]);
            return;
          }
        }
      }
    }
    wait(0.1);
  }
}