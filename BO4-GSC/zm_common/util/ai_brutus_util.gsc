/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_brutus_util.gsc
***********************************************/

#include scripts\core_common\ai\archetype_brutus;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\ai\zm_ai_brutus;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zombie_brutus_util;

autoexec __init__system__() {
  system::register(#"zombie_brutus_util", &__init__, &__main__, #"zm_ai_brutus");
}

__init__() {
  clientfield::register("actor", "brutus_lock_down", 1, 1, "int");
  level.var_d668eae7 = getEntArray("brutus_zombie_spawner", "script_noteworthy");

  if(level.var_d668eae7.size == 0) {
    assertmsg("<dev string:x38>");
    return;
  }

  thread function_60f8374c();

    level flag::init("brutus_setup_complete");
}

__main__() {
  level thread enable_brutus();
}

enable_brutus() {
  array::thread_all(level.var_d668eae7, &spawner::add_spawn_function, &brutus_prespawn);

  for(i = 0; i < level.var_d668eae7.size; i++) {
    level.var_d668eae7[i].is_enabled = 1;
    level.var_d668eae7[i].script_forcespawn = 1;
  }

  level.var_57d61da9 = struct::get_array("brutus_location", "script_noteworthy");
  level.var_361ec6d1 = 0;
  level.var_bedcc65f = 500;
  level.brutus_round_count = 0;
  level.var_152c591 = 1;
  level.brutus_last_spawn_round = 0;
  level.brutus_count = 0;
  level.brutus_max_count = 4;
  level.brutus_damage_percent = 0.1;
  level.var_8e570217 = 500;
  level.var_b0b1d70a = 250;
  level.brutus_points_for_helmet = 250;
  level.var_cc879537 = 100;
  level.var_e56a97ab = 100;
  level.var_5ade4e2f = 10;
  level.var_49efbc6d = 200;
  level.var_deee7afe = 4;
  level.var_66ff42da = 7;

  if(zm_utility::is_standard()) {
    level.var_deee7afe = 8;
    level.var_66ff42da = 12;
  }

  level.var_55b6e02f = 1;
  level.var_549a1590 = 120;
  level.var_a33d6e46 = 0;
  level.var_87dac1c6 = 4;
  level.var_391991e0 = 600;
  level.var_8d201cbe = 4;
  level.brutus_do_prologue = 1;
  level.var_dc8fa5e1 = 10;
  level.var_63a02bd7 = 60;
  level.var_9b5c03bf = 1;
  level.var_4d04bf1 = 0;

  if(level.scr_zm_ui_gametype == "zgrief") {
    level.var_4d04bf1 = 1;
  }

  level.var_ecaf813c = 48;
  level thread brutus_spawning_logic();

  if(!level.var_4d04bf1) {
    level.custom_perk_validation = &check_perk_machine_valid;
    level.var_1c4fa781 = &check_craftable_table_valid;
  }
}

brutus_prespawn() {}

brutus_spawning_logic() {
  if(level.var_4d04bf1 || isDefined(level.var_153e9058) && level.var_153e9058 || isDefined(level.var_a2831281) && level.var_a2831281) {
    return;
  }

  level thread enable_brutus_rounds();
  level thread function_6340fe2();

  while(true) {
    s_result = level waittill(#"spawn_brutus");
    n_spawn = s_result.n_spawn;

    if(n_spawn > 1) {
      level thread function_f332f2b7(n_spawn, s_result.str_zone_name, s_result.var_dde9ff11, s_result.var_68ffecfb);
      continue;
    }

    ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);

    if(isalive(ai_brutus)) {
      if(isDefined(s_result.var_68ffecfb) && s_result.var_68ffecfb) {
        var_1a8c05ae = thread function_9398e511();

        if(isDefined(var_1a8c05ae)) {
          ai_brutus thread brutus_spawn(var_1a8c05ae.n_health, var_1a8c05ae.var_37d3fab9, var_1a8c05ae.var_1e1ce722, var_1a8c05ae.var_72275733, s_result.str_zone_name);
        }
      } else {
        ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, s_result.str_zone_name);
      }

      if(!(isDefined(s_result.var_dde9ff11) && s_result.var_dde9ff11) && !(isDefined(level.var_779eb5f5) && level.var_779eb5f5) && isalive(ai_brutus)) {
        ai_brutus playSound(#"zmb_ai_brutus_spawn_2d");
      }
    }
  }
}

private function_f332f2b7(n_spawn, str_zone_name, var_dde9ff11, var_68ffecfb) {
  level endon(#"end_of_round", #"end_game");
  var_33882d9b = 0;

  while(var_33882d9b < n_spawn) {
    ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);

    if(isDefined(ai_brutus)) {
      if(isDefined(var_68ffecfb) && var_68ffecfb) {
        var_1a8c05ae = thread function_9398e511();

        if(isDefined(var_1a8c05ae)) {
          ai_brutus thread brutus_spawn(var_1a8c05ae.n_health, var_1a8c05ae.var_37d3fab9, var_1a8c05ae.var_1e1ce722, var_1a8c05ae.var_72275733, str_zone_name);
        }
      } else {
        ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, str_zone_name);
      }

      if(!(isDefined(var_dde9ff11) && var_dde9ff11)) {
        playsoundatposition(#"zmb_ai_brutus_spawn_2d", (0, 0, 0));
      }

      var_33882d9b++;
    }

    if(isDefined(level.var_152c591) && level.var_152c591 && !(isDefined(level.var_a2831281) && level.var_a2831281)) {
      wait randomfloatrange(15, 45);
    }

    util::wait_network_frame();
  }
}

zombie_setup_attack_properties() {
  self val::reset(#"attack_properties", "ignoreall");
  self.meleeattackdist = 64;
  self.maxsightdistsqrd = 16384;
  self.disablearrivals = 1;
  self.disableexits = 1;
}

brutus_spawn(starting_health, has_helmet, var_21b0fc34, var_7f2b0069, zone_name) {
  self endon(#"death");
  level.var_a33d6e46 = 0;
  self.has_helmet = isDefined(has_helmet) ? has_helmet : 1;
  self.var_21b0fc34 = isDefined(var_21b0fc34) ? var_21b0fc34 : 0;
  self.var_7f2b0069 = isDefined(var_7f2b0069) ? var_7f2b0069 : 0;

  if(isDefined(starting_health)) {
    self.starting_health = starting_health;
    self.health = starting_health;
    self.maxhealth = starting_health;
  }

  self.no_damage_points = 1;
  self.no_powerups = 1;
  self endon(#"death");
  level endon(#"intermission");
  self.animname = "brutus_zombie";
  self.var_9d6e31d4 = "brutus";
  self.has_legs = 1;
  self.is_brutus = 1;

  if(!(isDefined(level.var_f300b600) && level.var_f300b600)) {
    self.ignore_enemy_count = 1;
  }

  self.var_db8b3627 = 0;
  self.var_1fdb8f4e = 1000;
  self.var_41455ab0 = 0;
  self setphysparams(20, 0, 60);
  self.zombie_init_done = 1;
  self notify(#"zombie_init_done");
  self.allowpain = 0;
  self animmode("normal");
  self orientmode("face enemy");
  self zombie_setup_attack_properties();
  self setfreecameralockonallowed(0);
  level thread zm_spawner::zombie_death_event(self);
  self.deathfunction = &zm_spawner::zombie_death_animscript;

  if(!isDefined(zone_name)) {
    a_str_active_zones = zm_zonemgr::get_active_zone_names();

    foreach(str_zone in a_str_active_zones) {
      spawn_pos = get_best_brutus_spawn_pos(str_zone);

      if(isDefined(spawn_pos)) {
        zone_name = str_zone;
        break;
      }
    }
  } else {
    spawn_pos = get_best_brutus_spawn_pos(zone_name);

    if(!isDefined(spawn_pos)) {
      a_str_active_zones = zm_zonemgr::get_active_zone_names();

      foreach(str_zone in a_str_active_zones) {
        spawn_pos = get_best_brutus_spawn_pos(str_zone);

        if(isDefined(spawn_pos)) {
          break;
        }
      }
    }
  }

  if(!isDefined(spawn_pos)) {
    if(!isDefined(zone_name)) {
      zone_name = "undefined zone";
    }

    self delete();
    level notify(#"brutus_spawn_failed");
    return;
  }

  if(!isDefined(spawn_pos.angles)) {
    spawn_pos.angles = (0, 0, 0);
  }

  if(isDefined(level.brutus_do_prologue) && level.brutus_do_prologue) {
    self brutus_spawn_prologue(spawn_pos);
  }

  if(!self.has_helmet) {
    self detach("c_t8_zmb_mob_brutus_helmet");
  }

  level.brutus_count++;
  self thread brutus_death();
  self thread brutus_check_zone();
  self thread brutus_watch_enemy();
  self forceteleport(spawn_pos.origin, spawn_pos.angles);
  self thread brutus_lockdown_client_effects(0.5);
  self thread zombie_utility::delayed_zombie_eye_glow();
  level notify(#"brutus_spawned", {
    #ai_brutus: self
  });
  util::wait_network_frame();
  self callback::callback(#"hash_6f9c2499f805be2f");

  if(isDefined(level.var_779eb5f5) && level.var_779eb5f5) {
    return;
  }
}

get_best_brutus_spawn_pos(zone_name) {
  val = 0;

  for(i = 0; i < level.var_57d61da9.size; i++) {
    if(isDefined(zone_name) && level.var_57d61da9[i].zone_name != zone_name) {
      a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);

      if(a_players_in_zone.size) {
        continue;
      }
    }

    if(isDefined(level.var_8b4ac110)) {
      var_2a291abf = level.var_8b4ac110;
    } else {
      var_2a291abf = 412;
    }

    e_player_closest = arraygetclosest(level.var_57d61da9[i].origin, level.players, var_2a291abf);

    if(isDefined(e_player_closest)) {
      continue;
    }

    newval = get_brutus_spawn_pos_val(level.var_57d61da9[i]);

    if(newval > val) {
      val = newval;
      pos_idx = i;
    }
  }

  if(isDefined(pos_idx)) {
    return level.var_57d61da9[pos_idx];
  }

  return undefined;
}

get_brutus_spawn_pos_val(var_ed72e56b) {
  n_score = 0;
  zone_name = var_ed72e56b.zone_name;

  if(!zm_zonemgr::zone_is_enabled(zone_name)) {
    return 0;
  }

  if(!level.zones[zone_name].is_active) {
    return 0;
  }

  a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);
  n_score_addition = 1;

  for(i = 0; i < a_players_in_zone.size; i++) {
    if(self findpath(var_ed72e56b.origin, a_players_in_zone[i].origin, 0, 0)) {
      n_dist = distance2d(var_ed72e56b.origin, a_players_in_zone[i].origin);
      n_score_addition += math::linear_map(n_dist, 128, 4016, 0, level.var_549a1590);
    }
  }

  if(n_score_addition > level.var_549a1590) {
    n_score_addition = level.var_549a1590;
  }

  n_score += n_score_addition;
  return n_score;
}

brutus_spawn_prologue(spawn_pos) {
  playsoundatposition(#"zmb_ai_brutus_prespawn", spawn_pos.origin);
  wait 3;
}

function_6340fe2() {
  level flag::wait_till("start_zombie_round_logic");

  if(isDefined(level.chests)) {
    for(i = 0; i < level.chests.size; i++) {
      level.chests[i] thread wait_on_box_alarm();
    }
  }
}

enable_brutus_rounds() {
  level.var_fa6f7e27 = 1;
  level flag::init("brutus_round");
  level thread brutus_round_tracker();
}

brutus_round_tracker() {
  level.var_33be9958 = level.round_number + randomintrange(level.var_deee7afe, level.var_66ff42da);
  old_spawn_func = level.round_spawn_func;
  old_wait_func = level.round_wait_func;

  while(true) {
    level waittill(#"between_round_over");
    players = getplayers();

    if(isDefined(level.next_dog_round) && level.next_dog_round == level.var_33be9958) {
      level.var_33be9958 += 2;
    }

    if(level.round_number < 6 && isDefined(level.is_forever_solo_game) && level.is_forever_solo_game && !(isDefined(level.var_cab8d080) && level.var_cab8d080)) {
      if(level.var_33be9958 < 6) {
        level.var_33be9958 = 6;
      }

      continue;
    }

    if(zm_utility::is_standard() && !(isDefined(level.var_42cd50b3) && level.var_42cd50b3) && !(isDefined(level.var_cab8d080) && level.var_cab8d080)) {
      continue;
    }

    if(level.var_33be9958 <= level.round_number) {
      if(isDefined(level.var_cab8d080) && level.var_cab8d080) {
        level.var_cab8d080 = undefined;
      } else {
        wait randomfloatrange(level.var_dc8fa5e1, level.var_63a02bd7);
      }

      if(attempt_brutus_spawn(function_7265bed3())) {
        level.var_6e1b47ab = 1;
        level.var_33be9958 = level.round_number + randomintrange(level.var_deee7afe, level.var_66ff42da);
      }
    }
  }
}

private function_7265bed3() {
  if(level.round_number >= 30) {
    level.var_55b6e02f = 4;
  } else if(level.round_number >= 25) {
    level.var_55b6e02f = 3;
  } else if(level.round_number >= 17) {
    level.var_55b6e02f = 2;
  }

  return level.var_55b6e02f;
}

brutus_round_spawn_failsafe_respawn() {
  while(true) {
    wait 2;

    if(attempt_brutus_spawn(1)) {
      break;
    }
  }
}

attempt_brutus_spawn(var_d8206b1d, str_zone_name, var_dde9ff11 = 0, var_68ffecfb = 0) {
  if(level.brutus_count + var_d8206b1d > level.brutus_max_count && !(isDefined(level.var_a2831281) && level.var_a2831281) || isDefined(level.var_153e9058) && level.var_153e9058) {

    iprintln("<dev string:x82>");

      level thread function_5e4d2f31();
    return false;
  }

  level notify(#"spawn_brutus", {
    #n_spawn: var_d8206b1d, 
    #str_zone_name: str_zone_name, 
    #var_dde9ff11: var_dde9ff11, 
    #var_68ffecfb: var_68ffecfb
  });
  return true;
}

function_5e4d2f31() {
  waitframe(1);
  level notify(#"brutus_spawn_failed");
}

brutus_death() {
  self endon(#"brutus_cleanup");
  self thread brutus_cleanup();

  if(level.var_4d04bf1) {
    self thread brutus_cleanup_at_end_of_grief_round();
  }

  s_result = self waittill(#"death");

  if(isDefined(s_result.weapon) && (s_result.weapon == getweapon(#"ww_blundergat_t8") || s_result.weapon == getweapon(#"ww_blundergat_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded") || s_result.weapon == getweapon(#"hash_494f5501b3f8e1e9")) && isplayer(s_result.attacker)) {
    s_result.attacker notify(#"hash_2e36f5f4d9622bb3", {
      #weapon: s_result.weapon
    });
  }

  level.brutus_count--;

  if(zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
    level.var_5726b2fa = self.origin;
    level notify(#"last_brutus_down");

    if(isDefined(self.var_37aafb5) && self.var_37aafb5) {
      level.var_33be9958 = level.round_number + 1;
    }
  } else if(isDefined(self.var_37aafb5) && self.var_37aafb5) {
    level.zombie_total++;
    level.zombie_total_subtract++;
    level thread brutus_round_spawn_failsafe_respawn();
  }

  var_1982af82 = 0;
  a_s_blueprints = zm_crafting::function_31d883d7();

  foreach(s_blueprint in a_s_blueprints) {
    if(s_blueprint.var_54a97edd == getweapon(#"zhield_spectral_dw")) {
      var_1982af82 = 1;
      break;
    }
  }

  if(isDefined(level.crafting_components[#"zitem_spectral_shield_part_3"]) && !(isDefined(var_1982af82) && var_1982af82)) {
    w_component = zm_crafting::get_component(#"zitem_spectral_shield_part_3");

    if(!zm_items::player_has(level.players[0], w_component) && !(isDefined(self.var_eebea220) && self.var_eebea220) && !level flag::get("round_reset")) {
      self.var_db8b3627 = 1;
      self thread function_4621cb04(w_component);
    }
  }

  if(!(isDefined(self.var_db8b3627) && self.var_db8b3627)) {
    if(!(isDefined(level.var_7fd2edf6) && level.var_7fd2edf6)) {
      if(level.powerup_drop_count >= level.zombie_vars[#"zombie_powerup_drop_max_per_round"]) {
        level.powerup_drop_count = level.zombie_vars[#"zombie_powerup_drop_max_per_round"] - 1;
      }

      var_1f8ae158 = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
      level thread zm_powerups::powerup_drop(var_1f8ae158, undefined, 0);
    }
  }

  if(isplayer(self.attacker)) {
    event = "death";

    if(level.var_4d04bf1) {
      team_points = level.var_8e570217;
      player_points = level.var_b0b1d70a;
      a_players = getplayers(self.team);
    } else {
      multiplier = zm_score::get_points_multiplier(self.attacker);
      team_points = multiplier * zm_utility::round_up_score(level.var_8e570217, 5);
      player_points = multiplier * zm_utility::round_up_score(level.var_b0b1d70a, 5);
      a_players = getplayers();
    }

    foreach(player in a_players) {
      if(!zm_utility::is_player_valid(player)) {
        continue;
      }

      player zm_score::add_to_player_score(team_points);

      if(player == self.attacker) {
        player zm_score::add_to_player_score(player_points);
        level notify(#"brutus_killed", {
          #player: player
        });
      }

      player.pers[#"score"] = player.score;
      player zm_stats::increment_client_stat("prison_brutus_killed", 0);
    }
  }

  self notify(#"brutus_cleanup");
}

function_4621cb04(w_component) {
  var_70f6878b = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
  mdl_key = util::spawn_model(w_component.worldmodel, var_70f6878b + (0, 0, 36), self.angles);
  mdl_key endon(#"death");
  w_item = zm_items::spawn_item(w_component, var_70f6878b + (0, 0, 12), self.angles);
  w_item ghost();
  mdl_key thread function_f57a7d55(w_item);
  mdl_key thread function_69740610(w_item);

  while(isDefined(w_item)) {
    wait 0.25;
  }

  mdl_key delete();
}

function_f57a7d55(w_item) {
  self endon(#"death");
  self clientfield::set("powerup_fx", 2);

  while(isDefined(w_item)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = math::clamp(randomint(360), 60, 300);
    yaw = self.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
    self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
  }
}

function_69740610(w_item) {
  self endon(#"death");
  wait 15;

  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self ghost();
    } else {
      self show();
    }

    if(i < 15) {
      wait 0.5;
      continue;
    }

    if(i < 25) {
      wait 0.25;
      continue;
    }

    wait 0.1;
  }

  self clientfield::set("powerup_grabbed_fx", 2);
  util::wait_network_frame();

  if(isDefined(w_item)) {
    w_item delete();
  }
}

brutus_cleanup() {
  self waittill(#"brutus_cleanup");
  level.var_361ec6d1 = 0;

  if(isDefined(self.var_cc9c93ed)) {
    self.var_cc9c93ed delete();
    self.var_cc9c93ed = undefined;
  }

  a_ai_brutus = getaiarchetypearray(#"brutus");

  if(a_ai_brutus.size) {
    level.brutus_count = a_ai_brutus.size;
    return;
  }

  level.brutus_count = 0;
}

brutus_cleanup_at_end_of_grief_round() {
  self endon(#"death", #"brutus_cleanup");
  level waittill(#"keep_griefing", #"game_module_ended");
  self notify(#"brutus_cleanup");
  self delete();
}

wait_on_box_alarm() {
  while(true) {
    self.zbarrier waittill(#"randomization_done");
    level.var_a33d6e46++;

    if(level.var_4d04bf1) {
      level.var_87dac1c6 = randomintrange(7, 10);
    }

    if(level.var_a33d6e46 >= level.var_87dac1c6) {
      rand = randomint(500);

      if(level.var_4d04bf1) {
        attempt_brutus_spawn(1);
        continue;
      }

      if(rand <= level.var_cc879537) {
        if(level flag::get("moving_chest_now")) {
          continue;
        }

        if(attempt_brutus_spawn(1)) {
          if(level.var_33be9958 == level.round_number + 1) {
            level.var_33be9958++;
          }

          level.var_cc879537 = level.var_e56a97ab;
        }

        continue;
      }

      if(level.var_cc879537 < level.var_49efbc6d) {
        level.var_cc879537 += level.var_5ade4e2f;
      }
    }
  }
}

check_perk_machine_valid(player) {
  if(isDefined(self.is_locked) && self.is_locked) {
    if(player zm_score::can_player_purchase(self.var_9c6a6ebb)) {
      player zm_score::minus_to_player_score(self.var_9c6a6ebb);
      self.is_locked = 0;
      self.var_9c6a6ebb = undefined;
      self.var_58a5f973 delete();
      self zm_perks::reset_vending_hint_string();
    }

    return false;
  }

  return true;
}

check_craftable_table_valid(player) {
  if(!isDefined(self.stub) && isDefined(self.is_locked) && self.is_locked) {
    if(player zm_score::can_player_purchase(self.var_9c6a6ebb)) {
      player zm_score::minus_to_player_score(self.var_9c6a6ebb);
      self.is_locked = 0;
      self.var_9c6a6ebb = undefined;
      self.var_58a5f973 delete();
    }

    return false;
  } else if(isDefined(self.stub) && isDefined(self.stub.is_locked) && self.stub.is_locked) {
    if(player zm_score::can_player_purchase(self.stub.var_9c6a6ebb)) {
      player zm_score::minus_to_player_score(self.stub.var_9c6a6ebb);
      self.stub.is_locked = 0;
      self.stub.var_9c6a6ebb = undefined;
      self.stub.var_58a5f973 delete();
      self sethintstring(self.stub.hint_string);
    }

    return false;
  }

  return true;
}

brutus_check_zone() {
  self endon(#"death", #"brutus_cleanup");
  self.var_8d6b1f59 = 0;

  while(true) {
    self.var_8d6b1f59 = 0;

    foreach(zone in level.zones) {
      if(!isDefined(zone.volumes) || zone.volumes.size == 0) {
        continue;
      }

      zone_name = zone.volumes[0].targetname;

      if(self zm_zonemgr::entity_in_zone(zone_name)) {
        if(isDefined(zone.is_occupied) && zone.is_occupied) {
          self.var_8d6b1f59 = 1;
          break;
        }
      }
    }

    wait 0.2;
  }
}

brutus_watch_enemy() {
  self endon(#"death", #"brutus_cleanup");
  level endon(#"end_game");

  while(true) {
    if(!zm_utility::is_player_valid(self.favoriteenemy)) {
      var_1cc3df76 = util::get_active_players();

      if(var_1cc3df76.size) {
        self.favoriteenemy = function_9a78baba(var_1cc3df76);
      }
    }

    wait 0.2;
  }
}

private function_9a78baba(var_1cc3df76) {
  least_hunted = var_1cc3df76[0];

  for(i = 0; i < var_1cc3df76.size; i++) {
    if(isDefined(var_1cc3df76[i]) && !isDefined(var_1cc3df76[i].hunted_by)) {
      var_1cc3df76[i].hunted_by = 0;
    }

    if(!zm_utility::is_player_valid(var_1cc3df76[i])) {
      continue;
    }

    if(!zm_utility::is_player_valid(least_hunted)) {
      least_hunted = var_1cc3df76[i];
    }

    if(var_1cc3df76[i].hunted_by < least_hunted.hunted_by) {
      least_hunted = var_1cc3df76[i];
    }
  }

  least_hunted.hunted_by += 1;
  return least_hunted;
}

brutus_lockdown_client_effects(delay) {
  self endon(#"death", #"brutus_cleanup");

  if(isDefined(delay)) {
    wait delay;
  }

  if(self.var_41455ab0) {
    self.var_41455ab0 = 0;
    self clientfield::set("brutus_lock_down", 0);
    return;
  }

  self.var_41455ab0 = 1;
  self clientfield::set("brutus_lock_down", 1);
}

private function_61263ebc() {
  trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(trace[#"entity"])) {
    entity = trace[#"entity"];

    if(entity ismovingplatform()) {
      return true;
    }
  }

  return false;
}

function_b02aec83() {
  self endon(#"death", #"brutus_cleanup", #"ignore_cleanup");

  while(true) {
    if(isDefined(self.favoriteenemy)) {
      break;
    }

    waitframe(1);
  }

  while(true) {
    if(!isDefined(self.favoriteenemy) && !self function_61263ebc()) {
      level thread function_ba497d2d(self);
      return;
    }

    waitframe(2);
  }
}

function_ba497d2d(e_brutus) {
  self endon(#"end_game");
  e_brutus clientfield::set("brutus_spawn_clientfield", 0);
  waitframe(1);

  if(isDefined(e_brutus) && isalive(e_brutus)) {
    var_1a8c05ae = {
      #n_health: e_brutus.health, 
      #var_37d3fab9: e_brutus.has_helmet, 
      #var_1e1ce722: e_brutus.var_21b0fc34, 
      #var_72275733: e_brutus.var_7f2b0069
    };

    if(!isDefined(level.var_f158b05c)) {
      level.var_f158b05c = [];
    } else if(!isarray(level.var_f158b05c)) {
      level.var_f158b05c = array(level.var_f158b05c);
    }

    level.var_f158b05c[level.var_f158b05c.size] = var_1a8c05ae;
    e_brutus notify(#"zombie_delete");
    e_brutus notify(#"brutus_cleanup");
    e_brutus delete();
  }

  found_target = 0;

  while(!found_target) {
    var_1cc3df76 = util::get_active_players();

    foreach(e_target in var_1cc3df76) {
      if(zombie_utility::is_player_valid(e_target, 1)) {
        found_target = 1;
        break;
      }
    }

    waitframe(1);
  }

  attempt_brutus_spawn(1, undefined, 0, 1);
}

private function_9398e511() {
  if(isDefined(level.var_f158b05c) && level.var_f158b05c.size > 0) {
    var_1a8c05ae = level.var_f158b05c[0];
    arrayremovevalue(level.var_f158b05c, var_1a8c05ae);
    return var_1a8c05ae;
  }

  return undefined;
}

function_60f8374c() {
  zm_devgui::add_custom_devgui_callback(&function_2e0d129b);
  adddebugcommand("<dev string:xc0>");
}

function_2e0d129b(cmd) {
  switch (cmd) {
    case #"hash_4d20b9f9a8da7a33":
      level.var_cab8d080 = 1;

      if(isDefined(level.var_33be9958)) {
        zm_devgui::zombie_devgui_goto_round(level.var_33be9958);
      }

      break;
  }
}

