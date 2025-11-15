/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_white_nukerun.gsc
*******************************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_white_perk_pap;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_white_nukerun;

autoexec __init__system__() {
  system::register(#"zm_trial_white_nukerun", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  level flag::init(#"hash_745ef45972843bd3");
  zm_trial::register_challenge("nukerun", &on_begin, &on_end);
}

private on_begin() {
  level.var_8c018a0e = 1;
  level.var_4f7df1ac = 1;
  level flag::clear(#"hash_745ef45972843bd3");
  callback::function_33f0ddd3(&function_33f0ddd3);
  level zm_trial::function_25ee130(1);
  level thread nuke_loop();

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_bf710271();
  }
}

nuke_loop() {
  level endon(#"hash_7646638df88a3656");
  wait 5;

  while(true) {
    wait 10;
    a_locations = struct::get_array("dog_location", "script_noteworthy");
    players = getplayers();
    valid_players = [];

    foreach(player in players) {
      if(zm_utility::is_player_valid(player)) {
        if(!isDefined(valid_players)) {
          valid_players = [];
        } else if(!isarray(valid_players)) {
          valid_players = array(valid_players);
        }

        valid_players[valid_players.size] = player;
      }
    }

    a_zones = [];

    foreach(zone in level.zones) {
      if(isDefined(zone.is_enabled) && zone.is_enabled && !(isDefined(zone.is_occupied) && zone.is_occupied) && zone.name !== "zone_security_checkpoint") {
        if(!isDefined(a_zones)) {
          a_zones = [];
        } else if(!isarray(a_zones)) {
          a_zones = array(a_zones);
        }

        if(!isinarray(a_zones, zone)) {
          a_zones[a_zones.size] = zone;
        }
      }
    }

    zone = array::random(a_zones);
    str_zone = zone.name;

    switch (str_zone) {
      case #"zone_street_start":
        str_zone = "zone_street2";
        break;
      case #"zone_street_mid":
        str_zone = "zone_street1";
        break;
    }

    var_a4cd10ea = [];

    foreach(loc in a_locations) {
      if(loc.targetname === str_zone + "_spawns") {
        if(!isDefined(var_a4cd10ea)) {
          var_a4cd10ea = [];
        } else if(!isarray(var_a4cd10ea)) {
          var_a4cd10ea = array(var_a4cd10ea);
        }

        if(!isinarray(var_a4cd10ea, loc)) {
          var_a4cd10ea[var_a4cd10ea.size] = loc;
        }
      }
    }

    loc = array::random(var_a4cd10ea);
    location = zm_utility::groundpos(loc.origin);
    level thread function_fe74909(location);
    level waittill(#"hash_4d75b8766027b0f2");
    wait 10;
  }
}

function_fe74909(drop_point) {
  playsoundatposition(#"hash_1fc67d7ad7445bbf", (-521, -1972, -82));
  playsoundatposition(#"hash_1fc67c7ad7445a0c", (-1146, -1956, -92));
  wait 3;
  level.var_dcd1e798 = getent("perk_machine_mover", "targetname");
  level.var_dcd1e798 useanimtree("generic");
  var_2379bb0e = util::spawn_model("p7_zm_power_up_nuke", drop_point);
  var_2379bb0e hide();
  level.var_dcd1e798.origin = drop_point;
  var_2379bb0e linkto(level.var_dcd1e798, "tag_animate_origin");
  level.var_dcd1e798 thread animation::play("p8_fxanim_zm_white_perk_machine_dummy_fly_in");
  waitframe(2);
  var_2379bb0e show();
  wait 3.5;
  level thread zm_white_perk_pap::function_48acb6ed(drop_point);
  playrumbleonposition("zm_white_perk_impact", drop_point);
  playrumbleonposition("zm_white_perk_aftershock", drop_point);
  level.var_7540bc25 = zm_powerups::specific_powerup_drop("nuke", drop_point, undefined, 0.1, undefined, 0);
  var_2379bb0e delete();

  if(isDefined(level.var_7540bc25)) {
    level.var_7cd7bd38 = gameobjects::get_next_obj_id();

    if(!isDefined(self.a_n_objective_ids)) {
      self.a_n_objective_ids = [];
    } else if(!isarray(self.a_n_objective_ids)) {
      self.a_n_objective_ids = array(self.a_n_objective_ids);
    }

    self.a_n_objective_ids[self.a_n_objective_ids.size] = level.var_7cd7bd38;
    objective_add(level.var_7cd7bd38, "active", level.var_7540bc25.origin, #"hash_423a75e2700a53ab");
    function_da7940a3(level.var_7cd7bd38, 1);

    while(isDefined(level.var_7540bc25) && !level flag::get(#"hash_745ef45972843bd3")) {
      waitframe(1);
    }

    objective_setinvisibletoall(level.var_7cd7bd38);
    objective_delete(level.var_7cd7bd38);
    gameobjects::release_obj_id(level.var_7cd7bd38);
    level.var_7cd7bd38 = undefined;
  }

  level notify(#"hash_4d75b8766027b0f2");
}

private on_end(round_reset) {
  level.var_8c018a0e = undefined;
  level.var_4f7df1ac = undefined;
  level flag::set(#"hash_745ef45972843bd3");
  callback::function_824d206(&function_33f0ddd3);
  level zm_trial::function_25ee130(0);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_dc0859e();
  }
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    if(!zm_loadout::function_2ff6913(s_event.weapon)) {
      self lockweapon(s_event.weapon, 1, 1);

      if(s_event.weapon.dualwieldweapon != level.weaponnone) {
        self lockweapon(s_event.weapon.dualwieldweapon, 1, 1);
      }
    }
  }
}