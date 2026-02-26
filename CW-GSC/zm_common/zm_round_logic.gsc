/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_round_logic.gsc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_puppeteer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_ffotd;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_quick_spawning;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_round_logic;

function private autoexec __init__system__() {
  system::register(#"zm_round_logic", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level flag::init("round_reset");
  level flag::init(#"trial_failed");
  level flag::init("enable_round_timeout");
  level flag::init("pause_round_timeout");
  level flag::init(#"infinite_round_spawning");
  level flag::init(#"hold_round_end");

  if(!isDefined(level.var_54d9d726)) {
    level.var_54d9d726 = 6;
  }

  zm_trial_special_enemy::function_95c1dd81(#"zombie", &function_f5c01f5);
}

function function_d20309f1() {
  level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));

  while(true) {
    var_cdbf6ee2 = get_round_number();
    level.round_number = undefined;
    var_496beb9e = var_cdbf6ee2;

    switch (randomint(5)) {
      case 0:
        var_3b354f31 = var_cdbf6ee2;
      case 1:
        var_e516a2f5 = var_cdbf6ee2;
      case 2:
        var_d6a70616 = var_cdbf6ee2;
      case 3:
        var_82475d54 = var_cdbf6ee2;
      case 4:
        var_64ed22a0 = var_cdbf6ee2;
        break;
    }

    level.round_number = var_cdbf6ee2;
    var_cdbf6ee2 = undefined;
    var_9e0394c8 = undefined;
    var_496beb9e = undefined;
    var_3b354f31 = undefined;
    var_e516a2f5 = undefined;
    var_d6a70616 = undefined;
    var_82475d54 = undefined;
    var_64ed22a0 = undefined;
    waitframe(1);
  }
}

function set_round_number(new_round) {
  if(new_round > 935) {
    new_round = 935;
  }

  world.roundnumber = new_round ^ 115;
}

function get_round_number() {
  return world.roundnumber ^ 115;
}

function function_e6937bfa() {
  if(!isDefined(level.var_cd8b6cd0)) {
    level.var_cd8b6cd0 = 4;
  }

  if(level.round_number < level.var_cd8b6cd0) {
    return;
  }

  level endon(#"intermission", #"end_of_round", #"restart_round");

  level endon(#"kill_round");

  while(level.zombie_total > 3) {
    wait 3;
  }

  for(a_ai_zombies = zombie_utility::get_round_enemy_array(); a_ai_zombies.size > 0 || level.zombie_total > 0; a_ai_zombies = zombie_utility::get_round_enemy_array()) {
    if(a_ai_zombies.size <= 3) {
      foreach(ai_zombie in a_ai_zombies) {
        ai_zombie thread registercentrifuge_zip_doormember();
      }
    }

    wait 1;
  }
}

function private registercentrifuge_zip_doormember() {
  if(is_true(self.var_eceaa835)) {
    return;
  }

  self endon(#"death");

  if(isalive(self)) {
    if(self.archetype == # "zombie" || self.archetype == # "catalyst") {
      self.var_eceaa835 = 1;

      if(self.zombie_move_speed !== "sprint" && self.zombie_move_speed !== "super_sprint") {
        while(!isDefined(self.favoriteenemy) || distancesquared(self.favoriteenemy.origin, self.origin) < 65536) {
          wait 1;
        }

        self zombie_utility::set_zombie_run_cycle("sprint");
      }

      return;
    }

    if(self.archetype == # "tiger") {
      self.var_eceaa835 = 1;
      self ai::set_behavior_attribute("sprint", 1);
    }
  }
}

function private function_f5c01f5() {
  assert(isDefined(level.zombie_spawners));
  spawner = array::random(level.zombie_spawners);
  ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);

  if(isDefined(ai)) {
    if(level.zombie_respawns > 0) {
      level.zombie_respawns--;
      ai.var_a9b2d989 = 1;
    }

    ai thread zombie_utility::round_spawn_failsafe();
    return true;
  }

  return false;
}

function round_spawning() {
  if(level.zm_loc_types[#"zombie_location"].size < 1) {
    assertmsg("<dev string:x38>");
    return;
  }

  level.zombie_health = isDefined(level.var_41dd92fd[#"zombie"].health) ? level.var_41dd92fd[#"zombie"].health : 100;
  profilestart();
  level endon(#"intermission", #"end_of_round", #"restart_round");

  level endon(#"kill_round");

  if(level.intermission) {
    profilestop();
    return;
  }

  if(zm::cheat_enabled(2)) {
    profilestop();
    return;
  }

  if(zm_round_spawning::function_191ae5ec()) {
    profilestop();
    return;
  }

  profilestop();
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i].zombification_time = 0;
  }

  if(!(isDefined(level.kill_counter_hud) && level.zombie_total > 0)) {
    level.zombie_total = get_zombie_count_for_round(level.round_number, level.players.size);
    level.var_38b15968 = level.zombie_total;
    level.var_9427911d = level.zombie_total;
    level.var_412516cb = level.var_2125984b;
    level.zombie_respawns = level.var_2125984b;
    level.zombie_total += level.var_2125984b;
    level notify(#"zombie_total_set");
    waittillframeend();
  }

  var_8dd554ee = function_1687c93(level.round_number, level.players.size);

  if(isDefined(level.zombie_total_set_func)) {
    level thread[[level.zombie_total_set_func]]();
  }

  level thread[[level.var_d8d02d0e]]();
  zm_round_spawning::function_b2dabfc();
  old_spawn = undefined;

  while(true) {
    var_404e4288 = zombie_utility::get_current_zombie_count();
    var_3cafeff5 = 0;

    while(var_404e4288 >= level.zombie_ai_limit || level.zombie_total <= 0 && !level flag::get(#"infinite_round_spawning")) {
      wait 0.1;
      zm_quick_spawning::function_367e3573();
      var_404e4288 = zombie_utility::get_current_zombie_count();
      continue;
    }

    while(zombie_utility::get_current_actor_count() >= level.zombie_ai_limit) {
      zombie_utility::clear_all_corpses();
      wait 0.1;
    }

    if(flag::exists("world_is_paused")) {
      level flag::wait_till_clear("world_is_paused");
    }

    level flag::wait_till("spawn_zombies");

    while(level.zm_loc_types[#"zombie_location"].size <= 0) {
      wait 0.1;
    }

    run_custom_ai_spawn_checks();

    if(is_true(level.hostmigrationtimer)) {
      util::wait_network_frame();
      continue;
    }

    if(isDefined(level.var_78afc69) && [[level.var_78afc69]](var_404e4288, var_8dd554ee)) {
      util::wait_network_frame();
      var_3cafeff5 = 1;
    } else if(isDefined(level.fn_custom_round_ai_spawn) && [[level.fn_custom_round_ai_spawn]]()) {
      util::wait_network_frame();
      var_3cafeff5 = 1;
    } else if(zm_round_spawning::function_4990741c()) {
      util::wait_network_frame();
      var_3cafeff5 = 1;
    } else if(isDefined(level.zombie_spawners)) {
      var_6095c0b6 = function_4e8157cd(var_404e4288, var_8dd554ee);
      var_3cafeff5 = var_6095c0b6.var_3cafeff5;
    }

    if(var_3cafeff5) {
      wait isDefined(zombie_utility::get_zombie_var(#"zombie_spawn_delay")) ? zombie_utility::get_zombie_var(#"zombie_spawn_delay") : zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
      continue;
    }

    util::wait_network_frame();
  }
}

function function_4e8157cd(var_404e4288, var_8dd554ee) {
  var_3cafeff5 = 0;

  if(isDefined(level.fn_custom_zombie_spawner_selection)) {
    spawner = [[level.fn_custom_zombie_spawner_selection]]();
  } else if(is_true(level.use_multiple_spawns)) {
    if(isDefined(level.spawner_int) && is_true(level.zombie_spawn[level.spawner_int].size)) {
      spawner = array::random(level.zombie_spawn[level.spawner_int]);
    } else {
      spawner = array::random(level.zombie_spawners);
    }
  } else {
    spawner = array::random(level.zombie_spawners);
  }

  ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);

  if(isDefined(ai)) {
    level.zombie_total--;

    if(level.zombie_respawns > 0) {
      level.zombie_respawns--;
      ai.var_a9b2d989 = 1;
    }

    ai thread zombie_utility::round_spawn_failsafe();
    var_404e4288++;

    if(ai ai::has_behavior_attribute("can_juke")) {
      ai ai::set_behavior_attribute("can_juke", 0);
    }

    if(level.zombie_respawns > 0) {
      wait 0.1;
    } else if(var_404e4288 < var_8dd554ee) {
      wait 0.1;
    } else {
      var_3cafeff5 = 1;
    }
  }

  return {
    #ai_spawned: ai, #var_3cafeff5: var_3cafeff5
  };
}

function get_zombie_count_for_round(n_round, n_player_count) {
  n_player_count = zm_utility::function_a2541519(n_player_count);

  if(isDefined(level.var_ef1a71b3)) {
    n_zombie_count = [[level.var_ef1a71b3]](n_round, n_player_count);

    if(n_zombie_count >= 0) {
      return function_c112af8e(n_zombie_count);
    }
  }

  max = zombie_utility::get_zombie_var(#"zombie_max_ai");

  if(n_player_count == 1) {
    var_8ca3a339 = zombie_utility::get_zombie_var(#"hash_4127e6c9e8fdd112");
    var_7b4dbf22 = zombie_utility::get_zombie_var(#"hash_115c28dc9ed1e60e");
    var_f231b103 = zombie_utility::get_zombie_var(#"hash_67b3cbf79292e047");
  } else {
    var_8ca3a339 = zombie_utility::get_zombie_var(#"hash_40be0852fb086eb0");
    var_7b4dbf22 = zombie_utility::get_zombie_var(#"hash_3a53015873fb9c74");
    var_f231b103 = 0.5 + n_player_count / 2;
  }

  if(n_round < var_8ca3a339) {
    var_7b4dbf22 = zombie_utility::get_zombie_var(#"hash_607bc50072c2a386");
    multiplier = n_round / 5;

    if(multiplier < 1) {
      multiplier = 1;
    }

    multiplier *= n_round * var_7b4dbf22;
  } else {
    multiplier = n_round * var_7b4dbf22;
  }

  max += int(var_f231b103 * zombie_utility::get_zombie_var(#"zombie_ai_per_player") * multiplier);

  if(!isDefined(level.max_zombie_func)) {
    level.max_zombie_func = &zombie_utility::default_max_zombie_func;
  }

  n_zombie_count = [[level.max_zombie_func]](max, n_round);
  return function_c112af8e(n_zombie_count);
}

function function_c112af8e(n_zombie_count) {
  if(!isDefined(level.var_78afc69)) {
    return n_zombie_count;
  }

  if(is_true(level.var_d3e01096)) {
    n_zombie_count *= isDefined(level.var_397ca369) ? level.var_397ca369 : 1;
    n_zombie_count = int(max(n_zombie_count * 0.1 + 0.5, 1));
  } else if(is_true(level.var_5931f93f)) {
    n_zombie_count *= isDefined(level.var_66682370) ? level.var_66682370 : 1;
    n_zombie_count = int(max(n_zombie_count * 0.2 + 0.5, 1));
  } else if(is_true(level.var_d56511a2)) {
    n_zombie_count *= isDefined(level.var_6a9f25ba) ? level.var_6a9f25ba : 1;
    n_zombie_count = int(max(n_zombie_count, 1));
  }

  return n_zombie_count;
}

function function_1687c93(n_round, n_player_count) {
  n_player_count = zm_utility::function_a2541519(n_player_count);

  if(isDefined(level.var_76859bbd)) {
    n_zombie_count = [[level.var_76859bbd]](n_round, n_player_count);

    if(n_zombie_count >= 0) {
      return n_zombie_count;
    }
  }

  return n_player_count + 4 + int(n_round % 2);
}

function run_custom_ai_spawn_checks() {
  foreach(s in level.custom_ai_spawn_check_funcs) {
    if([[s.func_check]]()) {
      a_spawners = [[s.func_get_spawners]]();
      level.zombie_spawners = arraycombine(level.zombie_spawners, a_spawners, 0, 0);

      if(is_true(level.use_multiple_spawns)) {
        foreach(sp in a_spawners) {
          if(isDefined(sp.script_int)) {
            if(!isDefined(level.zombie_spawn[sp.script_int])) {
              level.zombie_spawn[sp.script_int] = [];
            }

            if(!isinarray(level.zombie_spawn[sp.script_int], sp)) {
              if(!isDefined(level.zombie_spawn[sp.script_int])) {
                level.zombie_spawn[sp.script_int] = [];
              } else if(!isarray(level.zombie_spawn[sp.script_int])) {
                level.zombie_spawn[sp.script_int] = array(level.zombie_spawn[sp.script_int]);
              }

              level.zombie_spawn[sp.script_int][level.zombie_spawn[sp.script_int].size] = sp;
            }
          }
        }
      }

      if(isDefined(s.func_get_locations)) {
        a_locations = [[s.func_get_locations]]();
        level.zm_loc_types[#"zombie_location"] = arraycombine(level.zm_loc_types[#"zombie_location"], a_locations, 0, 0);
      }

      continue;
    }

    a_spawners = [[s.func_get_spawners]]();

    foreach(sp in a_spawners) {
      arrayremovevalue(level.zombie_spawners, sp);
    }

    if(is_true(level.use_multiple_spawns)) {
      foreach(sp in a_spawners) {
        if(isDefined(sp.script_int) && isDefined(level.zombie_spawn[sp.script_int])) {
          arrayremovevalue(level.zombie_spawn[sp.script_int], sp);
        }
      }
    }

    if(isDefined(s.func_get_locations)) {
      a_locations = [[s.func_get_locations]]();

      foreach(s_loc in a_locations) {
        arrayremovevalue(level.zm_loc_types[#"zombie_location"], s_loc);
      }
    }
  }
}

function register_custom_ai_spawn_check(str_id, func_check, func_get_spawners, func_get_locations) {
  if(!isDefined(level.custom_ai_spawn_check_funcs[str_id])) {
    level.custom_ai_spawn_check_funcs[str_id] = spawnStruct();
  }

  level.custom_ai_spawn_check_funcs[str_id].func_check = func_check;
  level.custom_ai_spawn_check_funcs[str_id].func_get_spawners = func_get_spawners;
  level.custom_ai_spawn_check_funcs[str_id].func_get_locations = func_get_locations;
}

function round_spawning_test() {
  while(true) {
    spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
    spawner = array::random(level.zombie_spawners);
    ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
    ai waittill(#"death");
    wait 5;
  }
}

function round_start() {
  if(!isDefined(level.zombie_spawners) || level.zombie_spawners.size == 0) {
    println("<dev string:xa0>");
    level flag::set("begin_spawning");
    return;
  }

  println("<dev string:xd4>");

  if(isDefined(level.var_b2f996e6)) {
    [[level.var_b2f996e6]]();
  } else {
    n_delay = 2;

    if(isDefined(level.zombie_round_start_delay)) {
      n_delay = level.zombie_round_start_delay;
    }

    wait n_delay;
  }

  if(getdvarint(#"scr_writeconfigstrings", 0) == 1) {
    wait 5;
    exitlevel();
    return;
  }

  level flag::set("begin_spawning");

  if(!isDefined(level.var_d8d02d0e)) {
    level.var_d8d02d0e = &function_e6937bfa;
  }

  if(!isDefined(level.round_spawn_func)) {
    level.round_spawn_func = &round_spawning;
  }

  if(!isDefined(level.move_spawn_func)) {
    level.move_spawn_func = &zm_utility::move_zombie_spawn_location;
  }

  if(!isDefined(level.var_322d0819)) {
    level.var_322d0819 = &zm_quick_spawning::function_765cb1de;
  }

  if(getdvarint(#"zombie_rise_test", 0)) {
    level.round_spawn_func = &round_spawning_test;
  }

  if(!isDefined(level.round_wait_func)) {
    level.round_wait_func = &round_wait;
  }

  if(!isDefined(level.round_think_func)) {
    level.round_think_func = &round_think;
  }

  level.realm = 1;
  level.var_b48509f9 = 1;
  level thread[[level.round_think_func]]();
}

function wait_until_first_player() {
  players = getplayers();

  if(!isDefined(players[0])) {
    level waittill(#"first_player_ready");
  }
}

function round_one_up() {
  level endon(#"end_game");

  if(isDefined(level.noroundnumber) && level.noroundnumber == 1) {
    return;
  }

  if(!isDefined(level.doground_nomusic)) {
    level.doground_nomusic = 0;
  }

  if(level.first_round) {
    intro = 1;

    if(isDefined(level._custom_intro_vox)) {
      level thread[[level._custom_intro_vox]]();
    } else {
      level thread play_level_start_vox_delayed();
    }
  } else {
    intro = 0;
  }

  if(level.round_number == 5 || level.round_number == 10 || level.round_number == 20 || level.round_number == 35 || level.round_number == 50) {
    players = getplayers();
    rand = randomintrange(0, players.size);
    players[rand] thread zm_audio::create_and_play_dialog(#"general", #"round_" + level.round_number);
  }

  if(intro) {
    if(is_true(level.host_ended_game)) {
      return;
    }

    wait 6.25;
    level notify(#"intro_hud_done");
    wait 2;
  } else {
    wait 2.5;
  }

  reportmtu(level.round_number);
}

function round_over() {
  if(isDefined(level.noroundnumber) && level.noroundnumber == 1) {
    return;
  }

  time = [[level.func_get_delay_between_rounds]]();

  if(getdvarint(#"zombie_cheat", 0) > 0) {
    time = 0.1;
  }

  players = getplayers();

  for(player_index = 0; player_index < players.size; player_index++) {
    if(!isDefined(players[player_index].pers[#"previous_distance_traveled"])) {
      players[player_index].pers[#"previous_distance_traveled"] = 0;
    }

    distancethisround = int(players[player_index].pers[#"distance_traveled"] - players[player_index].pers[#"previous_distance_traveled"]);
    players[player_index].pers[#"previous_distance_traveled"] = players[player_index].pers[#"distance_traveled"];
    players[player_index] incrementplayerstat("distance_traveled", distancethisround);

    if(players[player_index].pers[#"team"] != "spectator") {
      players[player_index] recordroundendstats();
    }
  }

  recordzombieroundend();
  level flag::wait_till_any_timeout(time, array("round_reset", #"trial_failed", "end_round_start_delay"));

  foreach(player in getplayers()) {
    if(is_true(player.var_6696e200)) {
      wait level.var_54d9d726;
      break;
    }
  }
}

function get_delay_between_rounds() {
  return zombie_utility::get_zombie_var(#"zombie_between_round_time");
}

function recordplayerroundweapon(weapon, statname) {
  if(isDefined(weapon)) {
    weaponidx = getbaseweaponitemindex(weapon);

    if(isDefined(weaponidx)) {
      self incrementplayerstat(statname, weaponidx);
    }
  }
}

function recordprimaryweaponsstats(base_stat_name, max_weapons) {
  current_weapons = self getweaponslistprimaries();

  for(index = 0; index < max_weapons && index < current_weapons.size; index++) {
    recordplayerroundweapon(current_weapons[index], base_stat_name + index);
  }
}

function recordroundstartstats() {
  zonename = self zm_utility::get_current_zone();

  if(isDefined(zonename)) {
    self recordzombiezone("startingZone", zonename);
  }

  if(!isDefined(self.score)) {
    self.score = 0;
  }

  self incrementplayerstat("score", self.score);
  primaryweapon = self getcurrentweapon();
  self recordprimaryweaponsstats("roundStartPrimaryWeapon", 3);
  self recordmapevent(8, gettime(), self.origin, level.round_number);
}

function recordroundendstats() {
  zonename = self zm_utility::get_current_zone();

  if(isDefined(zonename)) {
    self recordzombiezone("endingZone", zonename);
  }

  self recordprimaryweaponsstats("roundEndPrimaryWeapon", 3);
  self recordmapevent(9, gettime(), self.origin, level.round_number);
}

function private function_89888d49() {
  foreach(player in level.players) {
    if(!player gamepadusedlast()) {
      player util::delay(5, "end_game", &zm_equipment::show_hint_text, #"hash_372a154dca05d6ba");
      continue;
    }

    player util::delay(5, "end_game", &zm_equipment::show_hint_text, #"hash_7ad0fd9b634f581a");
  }
}

function round_think(restart = 0) {
  println("<dev string:xef>");
  level endon(#"end_round_think", #"end_game");

  if(!is_true(restart)) {
    if(isDefined(level.var_12e11406)) {
      [[level.var_12e11406]]();
    }

    if(!is_true(level.host_ended_game)) {
      players = getplayers();

      foreach(player in players) {
        player zm_stats::set_global_stat("rounds", level.round_number);
      }
    }
  }

  setroundsplayed(level.round_number);
  level.var_21e22beb = gettime();
  zm_trial::function_74872db6();
  callback::callback(#"hash_6df5348c2fb9a509");

  if(level flag::exists(#"ztcm")) {
    luinotifyevent(#"hash_2f5757ad20bc3ae", 0);
    function_89888d49();
  }

  array::thread_all(getplayers(), &zm_blockers::rebuild_barrier_reward_reset);
  zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", min(500, 50 * level.round_number));

  while(true) {
    level.pro_tips_start_time = gettime();
    level.zombie_last_run_time = gettime();

    if(isDefined(level.var_fc735431)) {
      level thread zm_audio::function_4138a262();
      [[level.var_fc735431]]();
    } else {
      level thread zm_audio::function_4138a262();
      round_one_up();
    }

    zm_powerups::powerup_round_start();

    if(!is_true(level.headshots_only) && !restart) {
      level thread award_grenades_for_survivors();
    }

    println("<dev string:x10a>" + level.round_number + "<dev string:x127>" + level.players.size);
    level.round_start_time = gettime();

    while(level.zm_loc_types[#"zombie_location"].size <= 0) {
      wait 0.1;
    }

    zkeys = getarraykeys(level.zones);

    for(i = 0; i < zkeys.size; i++) {
      zonename = zkeys[i];
      level.zones[zonename].round_spawn_count = 0;
    }

    if(!is_true(level.var_ab84adee)) {
      level thread round_timeout();
    }

    level thread[[level.round_spawn_func]]();
    level notify(#"start_of_round", {
      #n_round_number: level.round_number
    });
    recordnumzombierounds(level.round_number - 1);
    recordzombieroundstart();
    players = getplayers();

    for(index = 0; index < players.size; index++) {
      players[index] recordroundstartstats();
    }

    if(isDefined(level.round_start_custom_func)) {
      [[level.round_start_custom_func]]();
    }

    [[level.round_wait_func]]();
    level thread zm_audio::function_d0f5602a();
    level.first_round = 0;
    zm_trial::on_round_end();
    callback::callback(#"on_round_end");
    level notify(#"end_of_round");

    if(!zm_trial::is_trial_mode() || !zm_utility::is_standard()) {
      playsoundatposition(#"hash_58df62ae7fa7b42b", (0, 0, 0));
    }

    if(isDefined(level.round_end_custom_logic)) {
      [[level.round_end_custom_logic]]();
    }

    if(!level flag::get("round_reset") && zm_custom::function_901b751c(#"zmroundcap") === level.round_number && level.round_number != 0) {
      level.var_458eec65 = 1;
      wait 3;
      zm_custom::function_9be9c072("zmRoundCap");
      return;
    }

    if(getdvarint(#"hash_18ba3b9b4a48b008", 0) || level.players.size != getplayers().size) {
      var_f2f19afd = [];

      foreach(player in level.players) {
        if(!isPlayer(player)) {
          var_f2f19afd[var_f2f19afd.size] = "<dev string:x13a>";
          continue;
        }

        var_f2f19afd[var_f2f19afd.size] = player.sessionstate;
      }

      var_9114f285 = [];

      foreach(player in getplayers()) {
        if(!isPlayer(player)) {
          var_9114f285[var_9114f285.size] = "<dev string:x13a>";
          continue;
        }

        var_9114f285[var_9114f285.size] = player.sessionstate;
      }

      message = "<dev string:x148>" + level.players.size + "<dev string:x160>" + getplayers().size + "<dev string:x17c>";

      foreach(state in var_f2f19afd) {
        message = message + state + "<dev string:x19d>";
      }

      message += "<dev string:x1a2>";

      foreach(state in var_9114f285) {
        message = message + state + "<dev string:x19d>";
      }

      assertmsg(message);
    }

    if(level.players.size > 1 && !level flag::get("round_reset")) {
      level thread zm_player::spectators_respawn();
    }

    if(int(level.round_number / 5) * 5 == level.round_number) {
      level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
      level clientfield::set("round_complete_num", level.round_number);
    }

    level.var_b48509f9 = int(floor(level.round_number / 5) + 1);

    if(level flag::get("round_reset")) {
      if(isDefined(level.var_495d3112)) {
        [[level.var_495d3112]]();
      }
    } else if(get_round_number() !== getgametypesetting("zmExfilRound")) {
      set_round_number(1 + get_round_number());
    }

    setroundsplayed(get_round_number());
    zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[level.func_get_zombie_spawn_delay]](get_round_number()));
    matchutctime = getutc();
    players = getplayers();

    foreach(player in players) {
      if(level.curr_gametype_affects_rank && get_round_number() > 3 + level.start_round) {
        player zm_stats::add_client_stat("weighted_rounds_played", get_round_number());
      }

      player zm_stats::set_global_stat("rounds", get_round_number());
      player zm_stats::update_playing_utc_time(matchutctime);
      player zm_stats::function_4dd876ad();

      if(!is_true(zm_custom::function_901b751c(#"zmhealthdrain")) && !player laststand::player_is_in_laststand() && is_true(player.heal.enabled)) {
        player zm_utility::set_max_health(1);
      }

      for(i = 0; i < 4; i++) {
        player.number_revives_per_round[i] = 0;
      }

      if(isalive(player) && player.sessionstate != "spectator" && !is_true(level.skip_alive_at_round_end_xp) && !level flag::get("round_reset")) {
        player zm_stats::increment_challenge_stat(#"survivalist_survive_rounds", undefined, 1);
        score_number = get_round_number() - 1;

        if(score_number < 1) {
          score_number = 1;
        } else if(score_number > 20) {
          score_number = 20;
        }

        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: player, #scoreevent: "alive_at_round_end_" + score_number
        });
      }
    }

    level.round_number = get_round_number();
    level flag::clear("round_reset");
    zm_trial::function_74872db6();
    callback::callback(#"hash_6df5348c2fb9a509");
    array::thread_all(getplayers(), &zm_blockers::rebuild_barrier_reward_reset);
    zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", min(500, 50 * level.round_number));
    level round_over();
    level notify(#"between_round_over");
    level.skip_alive_at_round_end_xp = 0;
    restart = 0;
  }
}

function round_timeout() {
  level endon(#"end_of_round", #"end_game");
  level waittill(#"zombie_total_set");
  level.var_2125984b = 0;

  if(level.round_number < 6) {
    level flag::wait_till_any(array("power_on", "enable_round_timeout"));
  }

  while(level.zombie_total > 0) {
    wait 1;
  }

  n_timeout = isDefined(level.var_2e3a6cbe) ? level.var_2e3a6cbe : 600;
  var_18836dd9 = zombie_utility::get_current_zombie_count();
  var_a456111d = var_18836dd9;
  var_1df92c7c = isDefined(level.var_589a7f02) ? level.var_589a7f02 : 20;

  while(n_timeout > 0 && var_1df92c7c > 0) {
    if(!level flag::get("pause_round_timeout")) {
      n_timeout--;

      if(is_true(level.var_d614a8b4)) {
        if(var_a456111d == var_18836dd9) {
          var_1df92c7c--;
        } else {
          var_1df92c7c = isDefined(level.var_3c91da30) ? level.var_3c91da30 : 20;
        }
      }
    }

    wait 1;
    var_18836dd9 = var_a456111d;
    var_a456111d = zombie_utility::get_current_zombie_count();
  }

  level flag::wait_till_clear("pause_round_timeout");
  level thread zm_cleanup::function_c6ad3003(1);
  level callback::on_round_end(&function_fb6aa5a3);
  level flag::set("end_round_wait");
}

function function_fb6aa5a3() {
  level flag::clear("end_round_wait");
  level callback::remove_on_round_end(&function_fb6aa5a3);
}

function award_grenades_for_survivors() {}

function get_zombie_spawn_delay(n_round) {
  if(n_round > 60) {
    n_round = 60;
  }

  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
      break;
    case 2:
      n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.75;
      break;
    case 3:
      n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.445;
      break;
    case 4:
      n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.335;
      break;
    default:
      n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.275;
      break;
  }

  for(i = 1; i < n_round; i++) {
    n_delay *= 0.95;

    if(n_delay <= 0.1) {
      n_delay = 0.1;
      break;
    }
  }

  return n_delay;
}

function round_spawn_failsafe_debug() {
  level notify(#"failsafe_debug_stop");
  level endon(#"failsafe_debug_stop");
  start = gettime();
  level.chunk_time = 0;

  while(true) {
    level.failsafe_time = gettime() - start;

    if(isDefined(self.lastchunk_destroy_time)) {
      level.chunk_time = gettime() - self.lastchunk_destroy_time;
    }

    util::wait_network_frame();
  }
}

function print_zombie_counts() {
  while(true) {
    if(getdvarint(#"zombiemode_debug_zombie_count", 0)) {
      if(!isDefined(level.debug_zombie_count_hud)) {
        level.debug_zombie_count_hud = newdebughudelem();
        level.debug_zombie_count_hud.alignx = "<dev string:x1bd>";
        level.debug_zombie_count_hud.x = 100;
        level.debug_zombie_count_hud.y = 10;
        level.debug_zombie_count_hud settext("<dev string:x1c6>");
      }

      currentcount = zombie_utility::get_current_zombie_count();
      number_to_kill = level.zombie_total;
      level.debug_zombie_count_hud settext("<dev string:x1d0>" + currentcount + "<dev string:x1da>" + number_to_kill);
    } else if(isDefined(level.debug_zombie_count_hud)) {
      level.debug_zombie_count_hud destroy();
      level.debug_zombie_count_hud = undefined;
    }

    wait 0.1;
  }
}

function round_wait() {
  level endon(#"restart_round", #"kill_round_wait");

  level endon(#"kill_round");

  if(getdvarint(#"zombie_rise_test", 0)) {
    level waittill(#"forever");
  }

  if(zm::cheat_enabled(2)) {
    level waittill(#"forever");
  }

  if(getdvarint(#"zombie_default_max", 0) == 0) {
    level waittill(#"forever");
  }

  wait 1;

  level thread print_zombie_counts();
  level thread sndmusiconkillround();

  while(true) {
    if(zombie_utility::get_current_zombie_count() == 0 && level.zombie_total <= 0 && !level.intermission && !level flag::get(#"infinite_round_spawning") && !level flag::get(#"hold_round_end")) {
      return;
    }

    if(level flag::get("end_round_wait")) {
      return;
    }

    if(level flag::get("round_reset")) {
      return;
    }

    wait 1;
  }
}

function sndmusiconkillround() {
  level endon(#"end_of_round");
  level waittill(#"kill_round");
}

function play_level_start_vox_delayed() {
  wait 3;
  players = getplayers();

  if(players.size <= 0) {
    return;
  }

  num = randomintrange(0, players.size);
  players[num] zm_audio::create_and_play_dialog(#"general", #"intro");
}

function function_f4c57bbe() {
  var_1529f18e = getdvarint(#"hash_6a8dad9b06fcd4bb", 7);
  var_6474e59d = getdvarint(#"hash_3f0689f4ecc2fbab", 0);
  var_bc57b6f5 = isDefined(self.var_a160c21d) ? self.var_a160c21d : 0;
  raw\sound\exp\ship_impact\exp_ship_impact_00.SN65.pc.snd = min(var_bc57b6f5 / 60, var_1529f18e);
  return int(var_6474e59d * raw\sound\exp\ship_impact\exp_ship_impact_00.SN65.pc.snd);
}