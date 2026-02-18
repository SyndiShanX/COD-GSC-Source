/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\manager.gsc
***********************************************/

#using script_6f8610e78fdd3440;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\init;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#namespace manager;

function scalevolume(ent, vol) {}

#namespace stealth_manager;

function function_f9682fd() {
  if(isDefined(level.stealth)) {
    return;
  }

  init();
  callback::on_spawned(&on_player_spawned);
  callback::on_ai_spawned(&on_ai_spawned);
  level thread manager_thread();
  level thread teams_thread();
  level thread hunt_thread();
  level thread function_807b87bc();

  if(getdvarint(#"hash_4e997f8f5fb7bc59", 0)) {
    stealth_suspicious_doors_init();
  }

  level.var_8bca2033 = &namespace_979752dc::function_2baa2568;

  thread stealth_debug::debug_manager();
}

function on_player_spawned() {
  if(!isDefined(self.stealth)) {
    stealth_init::set_stealth_mode(level flag::get("stealth_enabled"));
  }

  self thread update_stealth_spotted_thread();
}

function on_ai_spawned() {
  if(isDefined(self.var_de6a9e87) && self.var_de6a9e87) {
    self thread namespace_979752dc::ignore_corpse();
  }
}

function init() {
  level flag::init("stealth_enabled", 1);
  level flag::init("stealth_spotted");
  level.stealth = spawnStruct();
  level.stealth.detect = spawnStruct();
  level.stealth.save = spawnStruct();
  level.stealth.sentientevents = "sentientevents_stealth";

  level.stealth.debug = spawnStruct();
  level.stealth.debug.screen = [];

  level.stealth.ai_event = [];
  level.stealth.funcs = [];
  level.stealth.detect.state = "hidden";
  level.stealth.detect.range = [];
  level.stealth.detect.range[# "hidden"] = [];
  level.stealth.detect.range[# "spotted"] = [];
  level.stealth.detect.minrangedarkness[# "hidden"] = [];
  level.stealth.detect.minrangedarkness[# "spotted"] = [];
  level.stealth.detect.timeout = 5;
  namespace_cc4354b9::corpse_init_level();
  stealth_event::event_init_level();
  level.stealth.next_sound_wait = 3000;
  level.stealth.head_shot_dist = 20;
  level.stealth.group = spawnStruct();
  level.stealth.group.flags = [];
  level.stealth.group.groups = [];
  level.stealth.group.ally_groups = [];
  level.stealth.group.death_alert_timeout = [];
  level.stealth.hunting_groups = [];
  set_default_settings();
  init_stealth_volumes();
  namespace_5cd4acd8::init_hunt_regions();
  init_save();
  namespace_979752dc::alertlevel_init_map();

  if(!isDefined(level.default_goalradius)) {
    level.default_goalradius = 2048;
  }

  level.stealth.min_alert_level_duration = 1;
  level.var_a8072505 = &namespace_979752dc::function_7211414e;
  setup_stealth_funcs();
}

function setup_stealth_funcs() {
  level namespace_979752dc::set_stealth_func("do_stealth", &namespace_979752dc::do_stealth);
  stealth_enemy::set_default_stealth_funcs();
  level.stealth.fngroupspottedflag = &namespace_979752dc::group_spotted_flag;
  level.stealth.fninitenemygame = undefined;
  level.stealth.fnsetdisguised = &namespace_979752dc::set_disguised_default;
}

function set_default_settings(isnight) {
  stealth_hidden = [];

  if(is_true(isnight)) {
    stealth_hidden[# "prone"] = 150;
    stealth_hidden[# "crouch"] = 350;
    stealth_hidden[# "stand"] = 600;
  } else {
    stealth_hidden[# "prone"] = 400;
    stealth_hidden[# "crouch"] = 800;
    stealth_hidden[# "stand"] = 1500;
  }

  stealth_spotted = [];
  stealth_spotted[# "prone"] = 8192;
  stealth_spotted[# "crouch"] = 8192;
  stealth_spotted[# "stand"] = 8192;
  namespace_979752dc::set_detect_ranges(stealth_hidden, stealth_spotted);
  var_90bb9561 = [];
  var_90bb9561[# "prone"] = 130;
  var_90bb9561[# "crouch"] = 215;
  var_90bb9561[# "stand"] = 300;
  var_a8964800 = [];
  var_a8964800[# "prone"] = 300;
  var_a8964800[# "crouch"] = 375;
  var_a8964800[# "stand"] = 450;
  namespace_979752dc::set_min_detect_range_darkness(var_90bb9561, var_a8964800);
  namespace_cc4354b9::set_corpse_ranges_default();
  namespace_979752dc::set_disguised(0);
  event_change("hidden");
}

function set_detect_ranges_internal(hidden, spotted) {
  var_250a510c = 0.25;

  if(isDefined(hidden)) {
    level.stealth.detect.range[# "hidden"][# "prone"] = hidden[# "prone"];
    level.stealth.detect.range[# "hidden"][# "crouch"] = hidden[# "crouch"];
    level.stealth.detect.range[# "hidden"][# "stand"] = hidden[# "stand"];

    if(!isDefined(hidden[# "shadow"])) {
      hidden[# "shadow"] = var_250a510c;
    }

    level.stealth.detect.range[# "hidden"][# "shadow"] = hidden[# "shadow"];
  }

  if(isDefined(spotted)) {
    level.stealth.detect.range[# "spotted"][# "prone"] = spotted[# "prone"];
    level.stealth.detect.range[# "spotted"][# "crouch"] = spotted[# "crouch"];
    level.stealth.detect.range[# "spotted"][# "stand"] = spotted[# "stand"];

    if(!isDefined(spotted[# "shadow"])) {
      spotted[# "shadow"] = var_250a510c;
    }

    level.stealth.detect.range[# "spotted"][# "shadow"] = spotted[# "shadow"];
  }
}

function manager_thread() {
  while(true) {
    level flag::wait_till("stealth_enabled");
    stealth_threat_sight::threat_sight_set_dvar(1);
    level flag::wait_till("stealth_spotted");

    if(!level flag::get("stealth_enabled")) {
      continue;
    }

    event_change("spotted");
    level flag::wait_till_clear("stealth_spotted");

    if(!level flag::get("stealth_enabled")) {
      continue;
    }

    event_change("hidden");
    waittillframeend();
  }
}

function anyone_in_combat() {
  if(isDefined(level.stealth.groupdata)) {
    foreach(group in level.stealth.groupdata.groups) {
      if(stealth_group::group_anyoneincombat(group.name)) {
        return true;
      }
    }
  }

  ais = getactorteamarray("axis", "team3");

  foreach(guy in ais) {
    if(!isDefined(guy.stealth) && isDefined(guy.finished_spawning) && isDefined(guy.enemy) && guy.enemy == self) {
      return true;
    }
  }

  return false;
}

function update_stealth_spotted_thread() {
  waitframe(1);
  wasspotted = 0;

  while(true) {
    if(level flag::get("stealth_enabled")) {
      bspotted = anyone_in_combat();

      if(bspotted) {
        if(!wasspotted && isDefined(level.stealth.stealth_spotted_delay)) {
          wait level.stealth.stealth_spotted_delay;

          if(!anyone_in_combat()) {
            waitframe(1);
            continue;
          }
        }

        if(!level flag::get("stealth_spotted")) {
          level flag::set("stealth_spotted");

          if(isDefined(self.stealth)) {
            var_1dd006fc = self namespace_979752dc::get_group_flagname("stealth_spotted");
            level flag::set(var_1dd006fc);
          }
        }
      } else if(level flag::get("stealth_spotted")) {
        namespace_979752dc::function_740dbf99();

        if(isDefined(self.stealth)) {
          var_1dd006fc = self namespace_979752dc::get_group_flagname("stealth_spotted");
          level flag::clear(var_1dd006fc);
        }
      }

      wasspotted = bspotted;
    }

    waitframe(1);
  }
}

function teams_thread() {
  level.stealth.enemies[# "axis"] = [];
  level.stealth.enemies[# "allies"] = [];

  while(true) {
    level flag::wait_till("stealth_enabled");
    level.stealth.enemies[# "axis"] = getplayers();
    level.stealth.enemies[# "allies"] = getactorteamarray("axis");
    wait 0.05;
  }
}

function hunt_thread() {
  while(true) {
    level flag::wait_till("stealth_enabled");

    if(isDefined(level.stealth.hunt_stealth_group_region_sets) && level.stealth.hunt_stealth_group_region_sets.size != 0) {
      foreach(group, group_data in level.stealth.hunt_stealth_group_region_sets) {
        namespace_5cd4acd8::huntcomputeaiindependentregionscores(group, group_data);
        wait 0.2;
      }

      continue;
    }

    wait 0.5;
  }
}

function function_807b87bc() {
  while(true) {
    level flag::wait_till("stealth_enabled");
    level.stealth.var_69fc8bf2 = 0;
    wait 0.05;
  }
}

function event_change(name) {
  level.stealth.detect.state = name;

  if(name == "spotted") {
    loadsentienteventparameters("sentientevents");
    return;
  }

  loadsentienteventparameters(level.stealth.sentientevents);
}

function init_save() {
  level flag::init("stealth_player_nade");
  level.stealth.save.player_nades = 0;
  array::thread_all(getplayers(), &player_grenade_check);
}

function player_grenade_check() {
  while(true) {
    self waittill(#"grenade_pullback");
    level flag::set("stealth_player_nade");
    waitresult = self waittill(#"grenade_fire");
    thread player_grenade_check_dieout(waitresult.projectile);
  }
}

function player_grenade_check_dieout(grenade) {
  level.stealth.save.player_nades++;
  grenade waittilltimeout(10, #"death");
  level.stealth.save.player_nades--;
  waittillframeend();

  if(!level.stealth.save.player_nades) {
    level flag::clear("stealth_player_nade");
  }
}

function stealth_suspicious_doors_init() {
  if(is_true(level.ship_assault)) {
    return;
  }

  if(isDefined(level.stealth)) {
    if(!isDefined(level.stealth.suspicious_door)) {
      level.stealth.suspicious_door = spawnStruct();
      level.stealth.suspicious_door.doors = [];
      level.stealth.suspicious_door.reset_time = 30;
      level.stealth.suspicious_door.sight_distsqrd = sqr(600);
      level.stealth.suspicious_door.detect_distsqrd = sqr(500);
      level.stealth.suspicious_door.found_distsqrd = sqr(300);
    }

    level namespace_979752dc::set_stealth_func("suspicious_door", &namespace_cc4354b9::suspicious_door_found);
    level stealth_event::event_severity_set("investigate", "suspicious_door", 20);
  }
}

function init_stealth_volumes() {
  level.stealth.combat_volumes = [];
  level.stealth.hunt_volumes = [];
  level.stealth.investigate_volumes = [];
  allvolumes = getEntArray("info_volume_stealth_all", "variantname");
  volumes = getEntArray("info_volume_stealth_combat", "variantname");
  volumes = arraycombine(volumes, allvolumes);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      assert(isDefined(vol.script_stealthgroup), "<dev string:x38>" + vol.origin);
      assert(vol.script_stealthgroup != "<dev string:x68>" && vol.script_stealthgroup != "<dev string:x6e>", "<dev string:x72>" + vol.origin);
      groups = strtok(vol.script_stealthgroup, " ");

      foreach(group in groups) {
        if(isDefined(level.stealth.combat_volumes[group])) {
          iprintln("<dev string:xb8>" + group + "<dev string:xca>" + vol.origin + "<dev string:xf7>" + level.stealth.combat_volumes[group].origin);
        }

        level.stealth.combat_volumes[group] = vol;
      }
    }
  }

  volumes = getEntArray("info_volume_stealth_hunt", "variantname");
  volumes = arraycombine(volumes, allvolumes);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      assert(isDefined(vol.script_stealthgroup), "<dev string:xfc>" + vol.origin);
      assert(vol.script_stealthgroup != "<dev string:x68>" && vol.script_stealthgroup != "<dev string:x6e>", "<dev string:x12a>" + vol.origin);
      groups = strtok(vol.script_stealthgroup, " ");

      foreach(group in groups) {
        if(isDefined(level.stealth.hunt_volumes[group])) {
          iprintln("<dev string:xb8>" + group + "<dev string:x16e>" + vol.origin + "<dev string:xf7>" + level.stealth.hunt_volumes[group].origin);
        }

        level.stealth.hunt_volumes[group] = vol;
      }
    }
  }

  volumes = getEntArray("info_volume_stealth_investigate", "variantname");
  volumes = arraycombine(volumes, allvolumes, 0, 0);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      assert(isDefined(vol.script_stealthgroup), "<dev string:x199>" + vol.origin);
      assert(vol.script_stealthgroup != "<dev string:x68>" && vol.script_stealthgroup != "<dev string:x6e>", "<dev string:x1ce>" + vol.origin);
      groups = strtok(vol.script_stealthgroup, " ");

      foreach(group in groups) {
        if(isDefined(level.stealth.investigate_volumes[group])) {
          iprintln("<dev string:xb8>" + group + "<dev string:x219>" + vol.origin + "<dev string:xf7>" + level.stealth.investigate_volumes[group].origin);
        }

        level.stealth.investigate_volumes[group] = vol;
      }
    }
  }

  thread function_e1ee46bb("trigger_multiple_stealth_shadow", "stealth_in_shadow", 1);
  thread function_e1ee46bb("trigger_multiple_stealth_flashlight_on", "flashlight_on", 0);
  thread function_e1ee46bb("trigger_multiple_stealth_flashlight_off", "flashlight_off", 0);
}

function playerlootenabled() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnplayerlootenabled)) {
    return [[level.stealth.fnplayerlootenabled]]();
  }

  return 0;
}

function private function_e1ee46bb(targetname, the_flag, var_1910605e) {
  triggers = getEntArray(targetname, "targetname");

  foreach(trig in triggers) {
    trig thread function_5ca45f26(trig, the_flag, var_1910605e);
  }
}

function private function_5ca45f26(trigger, the_flag, var_1910605e) {
  trigger endon(#"death");

  if(is_true(var_1910605e)) {
    if(!isDefined(level.var_5ca45f26)) {
      level.var_5ca45f26 = [];
    }

    if(!isDefined(level.var_5ca45f26[the_flag])) {
      level.var_5ca45f26[the_flag] = [];
    }

    level.var_5ca45f26[the_flag][level.var_5ca45f26[the_flag].size] = trigger;
  }

  while(true) {
    waitresult = trigger waittill(#"trigger");
    other = waitresult.activator;

    if(other flag::get(the_flag)) {
      continue;
    }

    other thread function_5e5e064d(trigger, the_flag);
    waitframe(1);
  }
}

function private function_5e5e064d(volume, the_flag) {
  self endon(#"death");
  self flag::set(the_flag);

  while(isDefined(volume) && self istouching(volume)) {
    waitframe(1);
  }

  self flag::clear(the_flag);
}