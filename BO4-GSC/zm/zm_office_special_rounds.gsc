/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_special_rounds.gsc
***********************************************/

#include script_174ebb9642933bf7;
#include script_59a783d756554a80;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_office_floors;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_office_special_rounds;

init() {
  if(zm_utility::is_classic()) {
    zombie_dog_util::dog_enable_rounds(0);
    level.var_2f14be05 = 15;
    level.var_35a23da4 = 25;
    zm_round_spawning::function_376e51ef(#"nova_crawler");
    zm_round_spawning::function_376e51ef(#"zombie_dog", level.var_2f14be05);
    level.var_819e7dfd[#"zombie_dog"].var_87ed2709 = &function_6fa16bd2;
  } else if(zm_utility::is_trials()) {
    level.var_2f14be05 = 10;
    level.var_35a23da4 = 11;
    zm_round_spawning::function_376e51ef(#"nova_crawler");
    zm_round_spawning::function_376e51ef(#"zombie_dog", level.var_2f14be05);
    level.dog_round_track_override = &zombie_dog_util::function_246a0760;
    zombie_dog_util::dog_enable_rounds(0);
    level.var_807ffa2e = &namespace_df88241c::function_5b0522fa;
    namespace_df88241c::function_c44636f2(0);
    zm_round_spawning::function_df803678(&zombie_dog_util::function_ed67c5e7);
  } else if(zm_utility::is_standard()) {
    level.var_2f14be05 = 10;
    level.var_35a23da4 = 15;
  }

  level.var_819e7dfd[#"nova_crawler"].var_ef500cb7 = &crawler_round_spawn;
  level.var_819e7dfd[#"nova_crawler"].var_87ed2709 = &function_dd836251;
  level flag::init(#"nova_crawlers_round");
  level flag::init(#"hash_2a1fc2e349c48462");
  callback::on_round_end(&function_5b22eecf);

  if(zm_utility::is_trials()) {
    zm_round_spawning::function_2876740e(#"nova_crawler", &function_6f502b52);
    return;
  }

  zm_round_spawning::function_2876740e(#"nova_crawler", &function_f3f325cb);
}

function_f3f325cb(var_148cc603) {
  return int(0.3 * level.var_38b15968);
}

function_6f502b52(var_148cc603) {
  if(level.round_number === 12) {
    return int(0.75 * level.var_38b15968);
  }

  return int(0.3 * level.var_38b15968);
}

function_6fa16bd2(b_force_spawn = 0, var_eb3a8721) {
  if(level flag::get(#"nova_crawlers_round")) {
    b_result = function_fe3507a6();
  } else {
    b_result = zombie_dog_util::function_62db7b1c(b_force_spawn, var_eb3a8721);
  }

  return b_result;
}

function_a409c2a7(e_target) {
  if(namespace_df88241c::function_4748fb49() >= namespace_df88241c::function_59257d57()) {
    return undefined;
  }

  if(level.zm_loc_types[#"dog_location"].size > 0) {
    zone_tag = e_target zm_zonemgr::get_player_zone();

    if(!isDefined(zone_tag)) {
      return undefined;
    }

    target_zone = level.zones[zone_tag];
    adj_zone_names = getarraykeys(target_zone.adjacent_zones);
    var_2057a8c1 = array(target_zone.name);

    foreach(zone_name in adj_zone_names) {
      if(target_zone.adjacent_zones[zone_name].is_connected) {
        if(!isDefined(var_2057a8c1)) {
          var_2057a8c1 = [];
        } else if(!isarray(var_2057a8c1)) {
          var_2057a8c1 = array(var_2057a8c1);
        }

        var_2057a8c1[var_2057a8c1.size] = level.zones[zone_name].name;
      }
    }

    var_905a9429 = [];
    var_51fb0ec7 = [];

    foreach(loc in level.zm_loc_types[#"dog_location"]) {
      if(array::contains(var_2057a8c1, loc.zone_name)) {
        sqr_dist = distancesquared(loc.origin, e_target.origin);

        if(sqr_dist < 9000000) {
          if(sqr_dist > 250000) {
            if(!isDefined(var_905a9429)) {
              var_905a9429 = [];
            } else if(!isarray(var_905a9429)) {
              var_905a9429 = array(var_905a9429);
            }

            var_905a9429[var_905a9429.size] = loc;
            continue;
          }

          if(sqr_dist > 10000) {
            if(!isDefined(var_51fb0ec7)) {
              var_51fb0ec7 = [];
            } else if(!isarray(var_51fb0ec7)) {
              var_51fb0ec7 = array(var_51fb0ec7);
            }

            var_51fb0ec7[var_51fb0ec7.size] = loc;
          }
        }
      }
    }

    if(var_905a9429.size < 3) {
      var_905a9429 = arraycombine(var_905a9429, var_51fb0ec7, 0, 0);
    }

    s_spawn_loc = array::random(var_905a9429);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = zombie_utility::spawn_zombie(level.nova_crawler_spawner);

  if(isDefined(ai)) {
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    ai ghost();
    s_spawn_loc thread function_13f107c4(ai, s_spawn_loc);
    ai.favoriteenemy = e_target;
  }

  return ai;
}

function_13f107c4(ai, ent) {
  ai endon(#"death");
  ai val::set(#"crawler_spawn", "allowdeath", 0);
  ai setfreecameralockonallowed(0);
  wait 1;
  ai clientfield::increment("crawler_portal_spawn_fx");
  wait 1.5;
  playsoundatposition(#"evt_teleporter_go", ent.origin);

  if(isDefined(ai.favoriteenemy)) {
    angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
    angles = (ai.angles[0], angle[1], ai.angles[2]);
  } else {
    angles = ent.angles;
  }

  ai dontinterpolate();
  ai forceteleport(ent.origin, angles);
  assert(isDefined(ai), "<dev string:x38>");
  assert(isalive(ai), "<dev string:x4d>");
  ai val::reset(#"crawler_spawn", "allowdeath");
  wait 0.1;
  ai show();
  ai setfreecameralockonallowed(1);
  ai val::reset(#"crawler_spawn", "ignoreme");
  ai notify(#"spawn_complete");
  ai notify(#"visible");
}

function_6b3512d() {
  level.var_4b9c09fd = 40;
  level.var_a3e1adc4 = 40;
  level flag::set(#"nova_crawlers_round");
  level flag::set(#"hash_2a1fc2e349c48462");
  level flag::init(#"hash_429b6157c77015a2");

  while(isDefined(level.intermission) && level.intermission) {
    wait 1;
  }

  wait 0.1;
  level.zombie_total += 40;

  if(isDefined(level.var_e2aef122)) {
    level.var_e2aef122 += 40;
  }

  level.var_dc22f98 = level.fn_custom_round_ai_spawn;
  level.fn_custom_round_ai_spawn = &function_fe02a12f;
  callback::on_ai_killed(&function_9fb978f);
  level thread function_2ce54724();
  callback::on_ai_killed(&function_8c040be2);
  level flag::wait_till_clear(#"nova_crawlers_round");
  level.fn_custom_round_ai_spawn = level.var_dc22f98;
  callback::remove_on_ai_killed(&function_9fb978f);

  if(level.round_number < level.var_35a23da4) {
    level flag::clear(#"hash_2a1fc2e349c48462");
  }

  level flag::wait_till(#"hash_429b6157c77015a2");
  callback::remove_on_ai_killed(&function_8c040be2);
  e_player = namespace_8f53e87b::function_d62aaf66();

  if(isDefined(e_player)) {
    e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
  }
}

function_dd836251() {
  e_target = namespace_df88241c::function_a5abd591();

  if(isDefined(e_target) && level flag::get(#"hash_2a1fc2e349c48462")) {
    if(zm_office_floors::function_35babccd(e_target) < 3) {
      ai = function_a409c2a7(e_target);
    } else {
      ai = namespace_df88241c::function_87348a88(e_target);
    }
  } else {
    ai = namespace_df88241c::spawn_nova_crawler();
  }

  return ai;
}

crawler_round_spawn() {
  ai = function_dd836251();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_5b22eecf() {
  if(level.round_number > level.var_35a23da4 - 2) {
    level flag::set(#"hash_2a1fc2e349c48462");
    callback::remove_on_round_end(&function_5b22eecf);
  }
}

function_fe3507a6() {
  ai = function_dd836251();

  if(isDefined(ai)) {
    ai.var_faab7250 = 1;
    ai._starting_round_number += 15;
    level.var_4b9c09fd--;
  }

  return ai;
}

function_fe02a12f() {
  ai = function_fe3507a6();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_2ce54724() {
  while(level.var_4b9c09fd > 0) {
    level flag::wait_till_clear(#"hash_26e9fe6561459de3");
    wait 0.1;
  }

  level flag::clear(#"nova_crawlers_round");
}

function_9fb978f(s_params) {
  if(self.b_cleaned_up === 1 && self.archetype === #"nova_crawler" && isDefined(self.var_faab7250) && self.var_faab7250) {
    level.var_4b9c09fd++;
  }
}

function_8c040be2(s_params) {
  if(!isDefined(self.b_cleaned_up) && self.archetype === #"nova_crawler" && isDefined(self.var_faab7250) && self.var_faab7250) {
    level.var_a3e1adc4--;

    if(level.var_a3e1adc4 <= 0) {
      level flag::set(#"hash_429b6157c77015a2");
    }
  }
}