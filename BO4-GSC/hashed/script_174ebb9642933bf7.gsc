/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_174ebb9642933bf7.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace namespace_df88241c;

autoexec __init__system__() {
  system::register(#"hash_18c69cd2b0bf61b9", &__init__, undefined, undefined);
}

__init__() {
  level.var_f4f794bf = array(5, 7, 9, 12);
  level.nova_crawler_spawner = getent("nova_crawler_spawner", "script_noteworthy");
  spawner::add_archetype_spawn_function(#"nova_crawler", &nova_crawler_init);
  zm_round_spawning::register_archetype(#"nova_crawler", &function_c73902fd, &crawler_round_spawn, &spawn_nova_crawler, 10);
  zm_score::function_e5d6e6dd(#"nova_crawler", 60);
}

nova_crawler_init() {
  level thread zm_spawner::zombie_death_event(self);
}

function_c73902fd(var_dbce0c44) {
  if(isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return 0;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 10));
  return var_8cf00d40;
}

crawler_round_spawn() {
  ai = spawn_nova_crawler();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

spawn_nova_crawler(override_spawn_location = undefined) {
  var_d8d8ce1b = undefined;

  if(function_4748fb49() < function_59257d57() && !(isDefined(level.var_5e45f817) && level.var_5e45f817) && isDefined(level.zm_loc_types[#"nova_crawler_location"]) && level.zm_loc_types[#"nova_crawler_location"].size > 0) {
    var_d8d8ce1b = zombie_utility::spawn_zombie(level.nova_crawler_spawner);

    if(isDefined(var_d8d8ce1b)) {
      var_d8d8ce1b.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
      var_d8d8ce1b thread zombie_utility::round_spawn_failsafe();

      if(isDefined(override_spawn_location)) {
        var_d8d8ce1b function_e2bab5ec(override_spawn_location);
        override_spawn_location.spawned_timestamp = gettime();
      } else {
        spawn_location = var_d8d8ce1b function_9216fd1f();

        if(isDefined(spawn_location)) {
          var_d8d8ce1b function_e2bab5ec(spawn_location);
          spawn_location.spawned_timestamp = gettime();
        }
      }
    }
  }

  return var_d8d8ce1b;
}

function_59257d57() {
  if(level flag::exists("nova_crawlers_round") && level flag::get("nova_crawlers_round")) {
    return level.zombie_ai_limit;
  }

  if(zm_utility::is_trials()) {
    return (level.var_f4f794bf[level.players.size - 1] * 2);
  }

  return level.var_f4f794bf[level.players.size - 1];
}

function_4748fb49() {
  a_ai_crawler = getaiarchetypearray(#"nova_crawler");
  var_cc9e7e12 = a_ai_crawler.size;

  foreach(ai_crawler in a_ai_crawler) {
    if(!isalive(ai_crawler)) {
      var_cc9e7e12--;
    }
  }

  return var_cc9e7e12;
}

setup_crawler_round(n_round) {
  zm_round_spawning::function_b4a8f95a(#"nova_crawler", n_round, &crawler_round_start, &water_drop_triggerreactidgunterminate, &function_f6e748b, &function_f726e44, 0);
}

crawler_round_start() {
  level flag::set(#"hash_2a1fc2e349c48462");
  level flag::set("crawler_round");
}

water_drop_triggerreactidgunterminate(var_d25bbdd5) {
  level flag::clear(#"hash_2a1fc2e349c48462");
  level flag::clear("crawler_round");
}

function_f6e748b() {
  return 40 * (isDefined(level.var_71bc2e8f) ? level.var_71bc2e8f : 1);
}

function_f726e44(count, max) {
  wait randomfloatrange(0.25, 0.5);
}

function_a5abd591() {
  var_5935bd0e = array::randomize(level.activeplayers);
  e_target = undefined;

  foreach(e_player in var_5935bd0e) {
    if(zm_utility::is_player_valid(e_player)) {
      e_target = e_player;
      break;
    }
  }

  return e_target;
}

private function_9a898f07(e_target) {
  if(isDefined(level.zm_loc_types[#"nova_crawler_location"]) && level.zm_loc_types[#"nova_crawler_location"].size > 0) {
    var_a6c95035 = [];
    str_target_zone = e_target zm_zonemgr::get_player_zone();

    if(!isDefined(str_target_zone)) {
      return undefined;
    }

    target_zone = level.zones[str_target_zone];
    var_24f5d9f8 = array(target_zone.name);
    a_str_adj_zones = getarraykeys(target_zone.adjacent_zones);

    foreach(str_zone in a_str_adj_zones) {
      if(target_zone.adjacent_zones[str_zone].is_connected) {
        if(!isDefined(var_24f5d9f8)) {
          var_24f5d9f8 = [];
        } else if(!isarray(var_24f5d9f8)) {
          var_24f5d9f8 = array(var_24f5d9f8);
        }

        var_24f5d9f8[var_24f5d9f8.size] = str_zone;
      }
    }

    foreach(loc in level.zm_loc_types[#"nova_crawler_location"]) {
      if(array::contains(var_24f5d9f8, loc.zone_name)) {
        if(!isDefined(var_a6c95035)) {
          var_a6c95035 = [];
        } else if(!isarray(var_a6c95035)) {
          var_a6c95035 = array(var_a6c95035);
        }

        var_a6c95035[var_a6c95035.size] = loc;
      }
    }

    s_spawn_loc = array::random(var_a6c95035);
  }

  return s_spawn_loc;
}

function_87348a88(e_target) {
  override_spawn_location = function_9a898f07(e_target);
  return spawn_nova_crawler(override_spawn_location);
}

private function_9216fd1f() {
  spawn_locations = [];
  spawn_location = undefined;

  if(isDefined(level.zm_loc_types[#"nova_crawler_location"])) {
    spawn_locations = level.zm_loc_types[#"nova_crawler_location"];
  }

  if(spawn_locations.size > 0) {
    if(!isDefined(spawn_location)) {
      spawn_info = zm_spawner::function_dce9f1a6(spawn_locations);
      spawn_location = spawn_info.spot;
    }

    if(!isDefined(spawn_location)) {
      spawn_location = zm_spawner::function_65439499(spawn_locations);
    }

    if(!isDefined(spawn_location)) {
      spawn_location = array::random(spawn_locations);
    }
  }

  return spawn_location;
}

private function_e2bab5ec(spot) {
  if(isDefined(self.anchor)) {
    return;
  }

  if(isDefined(spot.script_int) && spot.script_int == 1) {
    self.custom_riseanim = "ai_t8_zm_quad_traverse_ground_crawlfast";
    self thread zm_spawner::do_zombie_rise(spot);
    self thread rise_anim_watcher();
    return;
  }

  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor thread zm_utility::anchor_delete_failsafe(self);

  if(!isDefined(spot.angles)) {
    spot.angles = (0, 0, 0);
  }

  self ghost();
  self.anchor moveto(spot.origin, 0.05);
  self.anchor waittill(#"movedone");
  target_org = zombie_utility::get_desired_origin();

  if(isDefined(target_org)) {
    anim_ang = vectortoangles(target_org - self.origin);
    self.anchor rotateto((0, anim_ang[1], 0), 0.05);
    self.anchor waittill(#"rotatedone");
  }

  if(isDefined(level.zombie_spawn_fx)) {
    playFX(level.zombie_spawn_fx, spot.origin);
  }

  self unlink();

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  if(!(isDefined(self.dontshow) && self.dontshow)) {
    self show();
  }

  self notify(#"spawn_complete");
  self notify(#"risen", {
    #find_flesh_struct_string: spot.script_string
  });
}

rise_anim_watcher() {
  self endon(#"death");
  self waittill(#"rise_anim_finished");
  self notify(#"spawn_complete");
}

function_c44636f2(b_ignore_cleanup = 1) {
  if(!zm_custom::function_901b751c(#"zmspecialroundsenabled") || isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return;
  }

  level.var_1ba6a97c = 1;
  level.var_8167b1e = b_ignore_cleanup;
  assert(isDefined(level.var_807ffa2e));
  level thread[[level.var_807ffa2e]]();
}

function_5b0522fa() {
  level.var_f5419c22 = 20;
  zm_round_spawning::function_b4a8f95a(#"nova_crawler", level.var_f5419c22, &function_9e97e0f7, &function_de265920, &function_70a8e26c, &function_d7e9e2ff, level.var_8167b1e);
  zm_utility::function_fdb0368(11);
  level flagsys::set(#"hash_2a1fc2e349c48462");
}

function_9e97e0f7() {
  level flag::set(#"hash_2a1fc2e349c48462");
}

function_de265920(var_d25bbdd5) {
  level flag::clear(#"hash_2a1fc2e349c48462");
  wait 5;
}

function_70a8e26c() {
  a_e_players = getplayers();
  n_max = zm_round_logic::get_zombie_count_for_round(level.var_f5419c22, a_e_players.size);
  return int(n_max * 0.6);
}

function_d7e9e2ff() {
  wait 0.1;
}