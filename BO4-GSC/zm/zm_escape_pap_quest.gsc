/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_pap_quest.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_escape;
#include scripts\zm\zm_escape_util;
#include scripts\zm\zm_escape_vo_hooks;
#include scripts\zm_common\util\ai_brutus_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace pap_quest;

autoexec __init__system__() {
  system::register(#"pap_quest", &__init__, &__main__, undefined);
}

__init__() {
  level.pack_a_punch.custom_power_think = &function_124362b5;
  level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
  level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
  level flag::init(#"pap_quest_completed");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts", &function_26cff57, "play");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_b64", &function_f7af87b9, "play");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_power_house", &function_cf48a8f2, "play");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_remove", &function_86f1ed70, "play");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_remove_b64", &function_8d3078dc, "play");
  scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_remove_power_house", &function_a340ee90, "play");
  init_clientfield();
}

private init_clientfield() {
  clientfield::register("world", "" + #"lightning_far", 1, 1, "counter");
  clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter");
}

__main__() {
  if(zm_custom::function_901b751c(#"zmpapenabled") == 1) {
    level thread function_1ab4e68();
  } else if(zm_custom::function_901b751c(#"zmpapenabled") == 0) {
    a_e_zbarriers = getEntArray("zm_pack_a_punch", "targetname");

    foreach(e_zbarrier in a_e_zbarriers) {
      e_zbarrier zm_pack_a_punch::set_state_initial();
      e_zbarrier zm_pack_a_punch::set_state_hidden();
    }
  }

  level thread function_ccb1f009();

  if(zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    level thread function_62933c32();
  }
}

function_62933c32() {
  level flag::wait_till("start_zombie_round_logic");
  a_e_pack = getEntArray("zm_pack_a_punch", "targetname");

  foreach(e_pack in a_e_pack) {
    e_pack zm_pack_a_punch::function_bb629351(1);
    pap_debris(0, e_pack.script_string);
  }

  level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 1);
  level flag::set(#"pap_quest_completed");
}

function_124362b5(is_powered) {
  level flag::wait_till("start_zombie_round_logic");

  switch (zm_custom::function_901b751c(#"zmpapenabled")) {
    case 1:
      self zm_pack_a_punch::set_state_hidden();

      if(self.script_string == "roof") {
        level flag::wait_till("power_on1");
        var_a8d69fbd = getent("pap_shock_box", "script_string");

        for(var_24c740a5 = 0; !var_24c740a5; var_24c740a5 = 1) {
          s_result = var_a8d69fbd waittill(#"hash_7e1d78666f0be68b");

          if(isalive(s_result.e_player)) {
            str_zone = s_result.e_player zm_zonemgr::get_player_zone();

            if(isDefined(str_zone) && (str_zone == "zone_roof" || str_zone == "zone_roof_infirmary")) {
              var_24c740a5 = 1;
            } else {
              var_a8d69fbd notify(#"turn_off");
            }

            continue;
          }
        }

        var_a8d69fbd playSound(#"hash_3a18ced95ae72103");
        var_a8d69fbd playLoopSound(#"hash_3a1bb2d95ae92746");
        var_a8d69fbd notify(#"hash_7f8e7011812dff48");
        wait 2;
        e_player = zm_utility::get_closest_player(var_a8d69fbd.origin);
        e_player thread zm_audio::create_and_play_dialog(#"pap", #"build", undefined, 1);
        scene::play(#"aib_vign_zm_mob_pap_ghosts");
        self zm_pack_a_punch::function_bb629351(1);
        self thread function_c0bc0375();
        level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 1);
        level flag::set(#"pap_quest_completed");
        util::delay(30, "game_over", &function_3357bedc);
      }

      break;
  }
}

function_3357bedc() {
  level thread zm_audio::function_8557c25d(#"hash_676a058bfe70473", 1);
}

private function_26cff57(a_ents) {
  a_ents[#"pap"] thread function_59093304("roof", 1);

  if(!level flag::get(#"pap_quest_completed")) {
    s_lightning_bridge = struct::get("lightning_bridge");
    level clientfield::increment("" + #"lightning_far");
    playsoundatposition(#"hash_7804a63a2ff82145", s_lightning_bridge.origin);
    a_ents[#"pap"] waittill(#"fade_in_end");
    s_lightning_near = struct::get("lightning_near");
    wait 1;
    e_player = zm_utility::get_closest_player(s_lightning_near.origin);
    e_player zm_audio::create_and_play_dialog(#"pap", #"react", undefined, 1);
  }
}

private function_f7af87b9(a_ents) {
  a_ents[#"pap"] thread function_59093304("building_64");
}

private function_cf48a8f2(a_ents) {
  a_ents[#"pap"] thread function_59093304("power_house");
}

private function_59093304(str_zone, var_e07ad59f = 0) {
  self ghost();
  self waittill(#"fade_in_start");
  self show();
  self clientfield::set("" + #"hash_504d26c38b96651c", 1);

  if(var_e07ad59f) {
    s_lightning_near = struct::get("lightning_near");
    playsoundatposition(#"hash_6c4553b9c8847808", s_lightning_near.origin);
  } else {
    playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
  }

  self waittill(#"fade_in_end");
  self clientfield::increment("" + #"lightning_near");
  self waittill(#"debris_disappear");
  pap_debris(0, str_zone);
}

private function_86f1ed70(a_ents) {
  a_ents[#"pap"] thread function_25adf2e0("roof", #"hash_79b5f8e539d36a49");
  a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

private function_8d3078dc(a_ents) {
  a_ents[#"pap"] thread function_25adf2e0("building_64", #"hash_1fc69d74f13da62e");
  a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

private function_a340ee90(a_ents) {
  a_ents[#"pap"] thread function_25adf2e0("power_house", #"hash_6d668f3614ed2393");
  a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

private function_25adf2e0(str_zone, var_410775ce) {
  self ghost();
  self waittill(#"fade_in_start");
  self show();
  self clientfield::increment("" + #"lightning_near");
  playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
  self waittill(#"debris_appear");
  pap_debris(1, str_zone);
  level notify(var_410775ce);
  self ghost();
}

pap_debris(b_show, str_area) {
  a_mdl_debris = getEntArray("debris_pap_" + str_area, "targetname");

  if(b_show) {
    foreach(mdl_debris in a_mdl_debris) {
      mdl_debris solid();
      mdl_debris show();
    }

    return;
  }

  foreach(mdl_debris in a_mdl_debris) {
    mdl_debris notsolid();
    mdl_debris hide();
  }
}

function_1ab4e68() {
  if(zm_custom::function_901b751c(#"zmpowerstate") == 1) {
    level flag::wait_till("power_on1");

    if(!level flag::get("power_on")) {
      level thread zombie_brutus_util::attempt_brutus_spawn(1, "zone_studio");
    }
  }

  level waittill(#"hash_222aa78f79091e7");

  if(zm_custom::function_901b751c(#"zmpapenabled") != 2 && !(isDefined(level.var_af325495) && level.var_af325495)) {
    level thread zombie_brutus_util::attempt_brutus_spawn(1, "zone_roof");
  }
}

function_ccb1f009() {
  level endon(#"power_on1");
  var_5ae7f356 = getEntArray("building_64_switches", "script_noteworthy");
  var_bfcb0a68 = [];
  var_50684754 = randomintrange(0, var_5ae7f356.size) + 1;
  var_e60e71b7 = getEntArray("building_64_switch_" + var_50684754, "script_string");

  foreach(var_9f5d5d73 in var_e60e71b7) {
    if(array::contains(var_5ae7f356, var_9f5d5d73)) {
      var_bb6e9418 = var_9f5d5d73;
      var_bb6e9418 thread zm_escape_vo_hooks::function_350029c6();
    }
  }

  var_d40e1ced = 0.1;

  foreach(var_74afc0d5 in var_5ae7f356) {
    if(var_74afc0d5 != var_bb6e9418) {
      var_74afc0d5 thread function_1f54733b(var_d40e1ced);

      if(!isDefined(var_bfcb0a68)) {
        var_bfcb0a68 = [];
      } else if(!isarray(var_bfcb0a68)) {
        var_bfcb0a68 = array(var_bfcb0a68);
      }

      var_bfcb0a68[var_bfcb0a68.size] = var_74afc0d5;
    }

    var_d40e1ced += 0.1;
  }

  level thread function_2d70fe2b(var_bfcb0a68);
}

function_1f54733b(var_d40e1ced = 0) {
  level endon(#"power_on1");
  self setinvisibletoall();
  a_e_parts = getEntArray(self.target, "targetname");

  foreach(e_part in a_e_parts) {
    if(isDefined(e_part.script_noteworthy)) {
      self thread function_1106e7e8(e_part, var_d40e1ced);
      var_d40e1ced += 0.1;
    }
  }

  self notify(#"hash_21e36726a7f30458");
}

function_1106e7e8(master_switch, n_delay = 0) {
  level flag::wait_till("start_zombie_round_logic");
  wait n_delay;
  zm_escape::function_9738dcda(master_switch);
  level flag::wait_till("power_on1");
  wait n_delay;
  zm_escape::function_3fcd201d(master_switch);
}

function_2d70fe2b(var_bfcb0a68) {
  level flag::wait_till("power_on1");
  array::delete_all(var_bfcb0a68);
}

function_c0bc0375() {
  if(zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    return 0;
  }

  self endon(#"hash_168e8f0e18a79cf8");

  switch (self.script_string) {
    case #"roof":
      var_45827936 = "lgtexp_pap_rooftops_on";
      break;
    case #"building_64":
      var_45827936 = "lgtexp_pap_b64_on";
      break;
    case #"power_house":
      var_45827936 = "lgtexp_pap_powerhouse_on";
      break;
  }

  exploder::exploder(var_45827936);

  if(isDefined(level.var_a929ea7f) && level.var_a929ea7f) {
    level.var_2ba5b206 = level.round_number + 1;
  } else {
    level.var_2ba5b206 = level.round_number + randomintrangeinclusive(2, 4);
  }

  while(true) {
    level waittill(#"end_of_round");

    if(level.round_number >= level.var_2ba5b206 && !zm_utility::is_standard()) {
      exploder::stop_exploder(var_45827936);
      self zm_pack_a_punch::function_bb629351(0);

      switch (self.script_string) {
        case #"roof":
          level thread scene::play(#"aib_vign_zm_mob_pap_ghosts_remove");
          break;
        case #"building_64":
          level thread scene::play(#"aib_vign_zm_mob_pap_ghosts_remove_b64");
          break;
        case #"power_house":
          level thread scene::play(#"aib_vign_zm_mob_pap_ghosts_remove_power_house");
          break;
      }

      level waittill(#"hide_p");
      self zm_pack_a_punch::function_bb629351(0, "hidden");
      self zm_pack_a_punch::set_state_hidden();
      level waittill(#"hash_79b5f8e539d36a49", #"hash_1fc69d74f13da62e", #"hash_6d668f3614ed2393");
      a_e_pack = getEntArray("zm_pack_a_punch", "targetname");

      for(e_pack = self; self == e_pack; e_pack = array::random(a_e_pack)) {}

      wait 5;

      switch (e_pack.script_string) {
        case #"roof":
          level scene::play(#"aib_vign_zm_mob_pap_ghosts");
          break;
        case #"building_64":
          level scene::play(#"aib_vign_zm_mob_pap_ghosts_b64");
          break;
        case #"power_house":
          level scene::play(#"aib_vign_zm_mob_pap_ghosts_power_house");
          break;
      }

      e_pack zm_pack_a_punch::function_bb629351(1);
      pap_debris(0, e_pack.script_string);
      e_pack thread function_c0bc0375();
      self notify(#"hash_168e8f0e18a79cf8");
    }
  }
}