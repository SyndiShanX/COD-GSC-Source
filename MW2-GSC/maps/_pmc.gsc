/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_pmc.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_hud_util;
#include maps\_specialops;

DEFEND_ENEMY_BUILDUP_COUNT_FRACTION = 0.9;
MIN_SPAWN_DISTANCE = 1024;
DEFAULT_ENEMY_GOAL_RADIUS_MIN = 512;
DEFAULT_ENEMY_GOAL_RADIUS_MAX = 2500;
DEFAULT_ENEMY_GOAL_HEIGHT = 128;
DEFAULT_ENEMY_GOAL_HEIGHT_JUGGERNAUT = 81;
DEFAULT_ENEMY_GOAL_HEIGHT_SNIPER = 640;
ENEMY_GOAL_RADIUS_SEEK_PLAYER_MIN = 1200;
ENEMY_GOAL_RADIUS_SEEK_PLAYER_MAX = 1600;
SEEK_PLAYERS_ENEMY_COUNT = 6;
TIME_REMAINING_FLASH_WAYPOINT = 2 * 60;
AI_INSIDE_TRANSPORT_CHOPPER = 6;
MAX_ENEMIES_ALIVE_ELIMINATION = 25;
DEFEND_SETUP_TIME = 180;
DEFEND_TIME = 5 * 60;
JUGGERNAUT_ENEMY_VISIBLE_TIMEOUT = 20;

preLoad() {
  level.pmc_match = true;
  level.teambased = false;
  maps\_juggernaut::main();
  level._effect["extraction_smoke"] = loadfx("smoke/signal_smoke_green");
}

main() {
  assert(isDefined(level.pmc_gametype));
  assert(isDefined(level.pmc_enemies));
  assert(level.pmc_enemies > 0);
  if(isDefined(level.pmc_enemies_alive)) {
    assert(level.pmc_enemies_alive > 0);
  }

  if(isDefendMatch()) {
    assert(isDefined(level.pmc_defend_enemy_count));
    assert(level.pmc_defend_enemy_count > 0);
  }

  if(!isDefined(level.pmc_alljuggernauts)) {
    level.pmc_alljuggernauts = false;
  }

  if(!is_specialop()) {
    maps\_specialops_code::pick_starting_location_pmc();
  }
  initialize_gametype();

  start_pmc_gametype();
}

initialize_gametype() {
  juggernaut_setup();

  precacheString(&"PMC_DEBUG_ENEMY_COUNT");

  precacheString(&"PMC_DEBUG_VEHICLE_COUNT");

  precacheString(&"PMC_DEBUG_SPAWNER_COUNT");

  precacheString(&"PMC_ENEMIES_REMAINING");

  precacheString(&"PMC_TIME_REMAINING");

  precacheString(&"PMC_OBJECTIVE_KILL_ENEMIES");

  precacheString(&"PMC_OBJECTIVE_KILL_ENEMIES_REMAINING");

  precacheString(&"PMC_OBJECTIVE_ABORT_CODES");

  precacheString(&"PMC_OBJECTIVE_FAILED");

  precacheString(&"PMC_SPECTATING");

  precacheString(&"PMC_OBJECTIVE_EXTRACT");

  precacheString(&"PMC_HINT_USELAPTOP");

  precacheString(&"PMC_OBJECTIVE_SETUP_DEFENSES");

  precacheString(&"PMC_TIME_UNTIL_ATTACK");

  precacheString(&"PMC_OBJECTIVE_DEFEND");

  precacheString(&"PMC_START_ATTACK_USE_HINT");

  precacheString(&"PMC_START_ATTACK_HINT");

  precacheString(&"PMC_HQ_DAMAGE");

  precacheString(&"PMC_HQ_RECOVERING_INTEL");

  precacheModel("com_laptop_2_open_obj");

  precacheShader("waypoint_ammo");
  precacheShader("waypoint_target");
  precacheShader("waypoint_extraction");
  precacheShader("waypoint_defend");

  setDvarIfUninitialized("pmc_debug_forcechopper", "0");

  level.pmc = spawnStruct();
  level.pmc.hud = spawnStruct();
  level.pmc.sound = [];

  level.pmc.defendSetupTime = DEFEND_SETUP_TIME;
  level.pmc.defendTime = DEFEND_TIME;

  if(isDefined(level.pmc_enemies_alive)) {
    level.pmc.max_ai_alive = level.pmc_enemies_alive;
  } else {
    level.pmc.max_ai_alive = MAX_ENEMIES_ALIVE_ELIMINATION;
  }

  level.pmc.enemy_goal_radius_min = DEFAULT_ENEMY_GOAL_RADIUS_MIN;
  level.pmc.enemy_goal_radius_max = DEFAULT_ENEMY_GOAL_RADIUS_MAX;

  level.pmc.sound["exfiltrate"] = "pmc_exfiltrate_area";
  level.pmc.sound["obj_win"] = "pmc_outta_here";
  level.pmc.sound["obj_fail"] = "pmc_mission_failed";
  level.pmc.sound["minutes_6"] = "pmc_6_minutes";
  level.pmc.sound["minutes_4"] = "pmc_4_minutes";
  level.pmc.sound["minutes_3"] = "pmc_3_minutes";
  level.pmc.sound["minutes_2"] = "pmc_2_minutes";
  level.pmc.sound["minutes_1"] = "pmc_1_minute";
  level.pmc.sound["minutes_30sec"][0] = "pmc_time_almost_up";
  level.pmc.sound["minutes_30sec"][1] = "pmc_running_out_of_time";
  level.pmc.sound["timer_tick"] = "pmc_timer_tick";

  flag_init("objective_complete");
  flag_init("extraction_complete");
  flag_init("defend_started");
  flag_init("pmc_defend_setup_time_finished");
  flag_init("defend_failed");
  flag_init("remove_caches");
  flag_init("exfiltrate_music_playing");
  flag_init("mission_complete");
  flag_init("mission_start");

  flag_init("staged_pacing_used");
  flag_init("pacing_stage_2");
  flag_init("pacing_stage_3");

  run_thread_on_noteworthy("hostage_only", ::self_delete);

  run_thread_on_noteworthy("pmc_spawner", ::add_spawn_function, ::room_breach_spawned);

  level.pmc.helicopter_exists = false;
  level.pmc.helicopter_queuing = false;
  level.pmc.helicopter_transport_last = undefined;
  level.pmc.helicopter_transport_min_time = 90 * 1000;
  level.pmc.helicopter_attack_last = undefined;
  level.pmc.helicopter_attack_min_time = 90 * 1000;

  level.pmc.enemy_vehicles_alive = 0;

  level.sentry_pickups = getEntArray("script_model_pickup_sentry_gun", "classname");
  level.sentry_pickups = array_combine(level.sentry_pickups, getEntArray("script_model_pickup_sentry_minigun", "classname"));

  level.pmc.send_in_juggernaut = false;
  level.pmc.juggernauts_spawned = 0;
  level.pmc.juggernauts_killed = 0;
  level.pmc.spawned_juggernaut_at_game_start = false;
  level.pmc.spawned_juggernaut_at_game_start_counter = 5;
}

start_pmc_gametype() {
  set_gametype_vars();

  thread fade_challenge_in();
  thread fade_challenge_out("mission_complete");

  if(!is_specialop()) {
    maps\_autosave::_autosave_game_now_nochecks();
    wait 0.05;
  }

  level.sentry_enemies = getEntArray("sentry_gun", "targetname");
  level.sentry_enemies = array_combine(level.sentry_enemies, getEntArray("sentry_minigun", "targetname"));

  if(isDefendMatch()) {
    array_thread(level.sentry_enemies, common_scripts\_sentry::delete_sentry_turret);
  }

  level.pmc.populate_enemies_func = ::populate_enemies;
  level.pmc.get_spawnlist_func = ::get_spawnlist;
  level.pmc.set_goal_func = ::enemy_set_goal_when_player_spotted;
  level.pmc.limitRespawns = true;
  if(isDefendMatch()) {
    level.pmc.enemy_spawn_position_func = ::pick_enemy_spawn_positions_defend;
    level.pmc.populate_enemies_func = ::populate_enemies;
    level.pmc.get_spawnlist_func = ::get_spawnlist_defend;
    level.pmc.set_goal_func = ::enemy_seek_objective_in_stages;
    level.pmc.limitRespawns = false;
  } else
    thread staged_pacing_system();

  assert(isDefined(level.pmc.enemy_spawn_position_func));
  assert(isDefined(level.pmc.populate_enemies_func));
  assert(isDefined(level.pmc.get_spawnlist_func));
  assert(isDefined(level.pmc.set_goal_func));

  level.pmc.enemy_spawners_full_list = getEntArray("pmc_spawner", "targetname");
  assertEx(level.pmc.enemy_spawners_full_list.size >= level.pmc_enemies, "There aren't enough enemy spawners in the level.");

  [[level.pmc.enemy_spawn_position_func]]();

  assert(isDefined(level.pmc.enemy_spawners));
  assert(level.pmc.enemy_spawners.size > 0);
  assert(isDefined(level.pmc.enemy_spawners_full_list));
  assert(level.pmc.enemy_spawners_full_list.size > 0);

  debug_print("Found " + level.pmc.enemy_spawners.size + " enemy spawners");
  assertEx(level.pmc.enemy_spawners.size >= level.pmc.enemies_kills_to_win, "There aren't enough enemy spawners in the level to hunt down " + level.pmc.enemies_kills_to_win + " enemies.");
  level.pmc.enemies_remaining = level.pmc.enemies_kills_to_win;

  level.pmc._re_populating_enemies = false;
  gametype_setup();
  setup_objective_entities();
  add_player_objectives();

  thread[[level.pmc.populate_enemies_func]]();

  thread debug_show_enemy_spawners_count();
  thread debug_show_enemies_alive_count();
  thread debug_show_vehicles_alive_count();
}

if(!is_specialop()) {
  wait 0.05;
  flag_set("disable_autosaves");
}
}

set_gametype_vars() {
  switch (level.pmc_gametype) {
    case "mode_elimination":
      debug_print("Gametype: Elimination");
      break;
    case "mode_objective":
      debug_print("Gametype: Objective");
      break;
    case "mode_defend":
      debug_print("Gametype: Defend");
      break;
    default:
      assertMsg("Error selecting gametype");
  }

  level.pmc.enemies_kills_to_win = level.pmc_enemies;
  assert(level.pmc.enemies_kills_to_win > 0);

  if(isDefendMatch()) {
    level.pmc.max_ai_alive = level.pmc_defend_enemy_count;
  }
}

pick_enemy_spawn_positions_defend() {
  level.pmc.enemy_spawners = level.pmc.enemy_spawners_full_list;
}

pick_enemy_spawn_positions() {
  color_gray = (0.3, 0.3, 0.3);
  color_red = (1, 0, 0);
  color_white = (1, 1, 1);
  color_blue = (0, 0, 1);
  color_green = (0, 1, 0);

  x_min = level.pmc.enemy_spawners_full_list[0].origin[0];
  x_max = level.pmc.enemy_spawners_full_list[0].origin[0];
  y_min = level.pmc.enemy_spawners_full_list[0].origin[1];
  y_max = level.pmc.enemy_spawners_full_list[0].origin[1];

  foreach(spawner in level.pmc.enemy_spawners_full_list) {
    if(spawner.origin[0] < x_min) {
      x_min = spawner.origin[0];
    }
    if(spawner.origin[0] > x_max) {
      x_max = spawner.origin[0];
    }
    if(spawner.origin[1] < y_min) {
      y_min = spawner.origin[1];
    }
    if(spawner.origin[1] > y_max) {
      y_max = spawner.origin[1];
    }
  }

  x_min -= 250;
  x_max += 250;
  y_min -= 250;
  y_max += 250;

  wait 0.05;

  if(getDvar("pmc_debug") == "1") {
    topLeft = (x_min - 50, y_max + 50, 0);
    topRight = (x_max + 50, y_max + 50, 0);
    bottomLeft = (x_min - 50, y_min - 50, 0);
    bottomRight = (x_max + 50, y_min - 50, 0);
    thread draw_line(topLeft, topRight, 1, 0, 0);
    thread draw_line(topRight, bottomRight, 1, 0, 0);
    thread draw_line(bottomRight, bottomLeft, 1, 0, 0);
    thread draw_line(bottomLeft, topLeft, 1, 0, 0);
  }

  number_of_divisions = 5;

  width_x = abs(x_max - x_min);
  width_y = abs(y_max - y_min);
  division_spacing_x = width_x / number_of_divisions;
  division_spacing_y = width_y / number_of_divisions;

  averageQuadRadius = (division_spacing_x + division_spacing_y) / 4;
  level.pmc.enemy_goal_radius_min = int(averageQuadRadius * 0.8);
  level.pmc.enemy_goal_radius_max = int(averageQuadRadius * 1.2);

  numQuads = number_of_divisions * number_of_divisions;
  level.quads = [];
  curent_division_x = 0;
  curent_division_y = 0;
  for(i = 0; i < numQuads; i++) {
    level.quads[i] = spawnStruct();
    level.quads[i].number = i;
    level.quads[i].containsSpawners = false;
    level.quads[i].enemiesInQuad = 0;

    level.quads[i].min_x = x_min + (division_spacing_x * curent_division_x);
    level.quads[i].max_x = level.quads[i].min_x + division_spacing_x;

    level.quads[i].min_y = y_max - (division_spacing_y * curent_division_y);
    level.quads[i].max_y = level.quads[i].min_y - division_spacing_y;

    curent_division_x++;
    if(curent_division_x >= number_of_divisions) {
      curent_division_x = 0;
      curent_division_y++;
    }
  }

  foreach(spawner in level.pmc.enemy_spawners_full_list) {
    if(distance(getAveragePlayerOrigin(), spawner.origin) <= MIN_SPAWN_DISTANCE) {
      continue;
    }
    quadIndex = spawner get_quad_index();
    level.quads[quadIndex].containsSpawners = true;
  }

  wait 0.05;

  if(getDvar("pmc_debug") == "1") {
    foreach(quad in level.quads) {
      topLeft = (quad.min_x, quad.max_y, 0);
      topRight = (quad.max_x, quad.max_y, 0);
      bottomLeft = (quad.min_x, quad.min_y, 0);
      bottomRight = (quad.max_x, quad.min_y, 0);

      textOrgX = quad.min_x + (division_spacing_x / 2);
      textOrgY = quad.min_y - (division_spacing_y / 2);

      lineColor = color_blue;
      textColor = color_white;

      if(!quad.containsSpawners) {
        continue;
      }
      thread draw_line(topLeft, topRight, lineColor[0], lineColor[1], lineColor[2]);
      thread draw_line(topRight, bottomRight, lineColor[0], lineColor[1], lineColor[2]);
      thread draw_line(bottomRight, bottomLeft, lineColor[0], lineColor[1], lineColor[2]);
      thread draw_line(bottomLeft, topLeft, lineColor[0], lineColor[1], lineColor[2]);
      print3d((textOrgX, textOrgY, 0), string(quad.number), textColor, 1.0, 5.0, 100000);
    }
  }

  randomized = undefined;

  if(level.pmc.enemies_kills_to_win >= (level.pmc.enemy_spawners_full_list.size / 1.2)) {
    spawnsToUse = level.pmc.enemy_spawners_full_list;
    debug_print("Using all spawners placed in the map as possible enemy locations because we're using almost all of the spawners!");
  } else {
    randomized = array_randomize(level.pmc.enemy_spawners_full_list);
    spawnsToUse = [];
    allowedSpawnersPerQuad = 1;
    loopCount = 0;
    for(;;) {
      loopCount = 0;
      foreach(spawner in randomized) {
        if(distance(getAveragePlayerOrigin(), spawner.origin) <= MIN_SPAWN_DISTANCE) {
          continue;
        }
        quadIndex = spawner get_quad_index();
        assert(level.quads[quadIndex].containsSpawners);
        assert(isDefined(level.quads[quadIndex].enemiesInQuad));

        if(level.quads[quadIndex].enemiesInQuad >= allowedSpawnersPerQuad) {
          continue;
        }

        level.quads[quadIndex].enemiesInQuad++;

        spawnsToUse[spawnsToUse.size] = spawner;
        randomized = array_remove(randomized, spawner);

        if(spawnsToUse.size >= level.pmc.enemies_kills_to_win) {
          break;
        }

        loopCount++;
        if(loopCount > 50) {
          loopCount = 0;

          wait 0.05;
        }
      }
      allowedSpawnersPerQuad++;
      if(spawnsToUse.size >= level.pmc.enemies_kills_to_win) {
        break;
      }
      debug_print("Still need more spawners");
    }
    assert(spawnsToUse.size > 0);
    assert(spawnsToUse.size <= level.pmc.enemies_kills_to_win);
    assert((spawnsToUse.size + randomized.size) == level.pmc.enemy_spawners_full_list.size);
    randomized = undefined;
  }
  debug_print("All spawners are ready");

  if(getDvar("pmc_debug") == "1") {
    foreach(spawner in spawnsToUse) {
      thread draw_line(spawner.origin, spawner.origin + (0, 0, 250), color_green[0], color_green[1], color_green[2]);
    }
    if(isDefined(randomized)) {
      foreach(spawner in randomized) {
        thread draw_line(spawner.origin, spawner.origin + (0, 0, 50), color_red[0], color_red[1], color_red[2]);
      }
    }
  }

  level.pmc.enemy_spawners = spawnsToUse;
}

get_quad_index() {
  org_x = self.origin[0];
  org_y = self.origin[1];

  quadIndex = undefined;
  foreach(quad in level.quads) {
    assert(isDefined(quad.number));
    if((org_x >= quad.min_x) && (org_x <= quad.max_x) && (org_y >= quad.max_y) && (org_y <= quad.min_y)) {
      assert(quad.number >= 0);
      assert(quad.number < level.quads.size);
      return quad.number;
    }
  }
  assertMsg("Quad wasn't found in get_quad_index()");
}

populate_enemies() {
  if(is_specialop()) {
    flag_wait("mission_start");
  }

  return;
  level.pmc._populating_enemies = true;

  if(isDefendMatch()) {
    flag_wait("pmc_defend_setup_time_finished");
  }

  prof_begin("populate_enemies");

  debug_print("Populating enemies");

  aliveEnemies = getaiarray("axis");
  assert(isDefined(aliveEnemies));
  assert(aliveEnemies.size + level.pmc.enemy_vehicles_alive <= level.pmc.max_ai_alive);
  if(level.pmc.limitRespawns) {
    assert(aliveEnemies.size + level.pmc.enemy_vehicles_alive <= level.pmc.enemies_remaining);
  }

  if(level.pmc.limitRespawns) {
    if(aliveEnemies.size + level.pmc.enemy_vehicles_alive >= level.pmc.enemies_remaining) {
      level.pmc._populating_enemies = false;
      return;
    }
  }

  if(aliveEnemies.size + level.pmc.enemy_vehicles_alive >= level.pmc.max_ai_alive) {
    level.pmc._populating_enemies = false;
    return;
  }

  numberToSpawn = level.pmc.max_ai_alive - (aliveEnemies.size + level.pmc.enemy_vehicles_alive);
  freeAISlots = getFreeAICount();
  if(numberToSpawn > freeAISlots) {
    numberToSpawn = freeAISlots;
  }

  assert(numberToSpawn > 0);

  if(isDefendMatch()) {
    if((numberToSpawn + AI_INSIDE_TRANSPORT_CHOPPER) < (level.pmc.max_ai_alive * DEFEND_ENEMY_BUILDUP_COUNT_FRACTION)) {
      level.pmc._populating_enemies = false;
      return;
    }
  }

  if(level.pmc.limitRespawns) {
    if(aliveEnemies.size + level.pmc.enemy_vehicles_alive + numberToSpawn > level.pmc.enemies_remaining) {
      numberToSpawn = level.pmc.enemies_remaining - (aliveEnemies.size + level.pmc.enemy_vehicles_alive);
    }
    assert(numberToSpawn > 0);
  }

  if(level.pmc.helicopter_queuing) {
    if(numberToSpawn >= AI_INSIDE_TRANSPORT_CHOPPER) {
      level notify("spawn_chopper");
    }
    level.pmc._populating_enemies = false;
    debug_print(numberToSpawn + " AI are in chopper queue");
    return;
  }

  spawnList = [[level.pmc.get_spawnlist_func]]();

  spawn_more_enemies(spawnList, numberToSpawn);

  prof_end("populate_enemies");

  level.pmc._populating_enemies = false;
}

get_spawnlist() {
  return get_array_of_closest(getAveragePlayerOrigin(), level.pmc.enemy_spawners, undefined, undefined, undefined, MIN_SPAWN_DISTANCE);
}

get_spawnlist_defend() {
  all_spawners = get_array_of_closest(getAveragePlayerOrigin(), level.pmc.enemy_spawners_full_list, undefined, undefined, undefined, MIN_SPAWN_DISTANCE);
  all_spawners = array_reverse(all_spawners);

  spawners = [];
  for(i = 0; i < int(all_spawners.size / 2); i++) {
    spawners[spawners.size] = all_spawners[i];
  }

  if(getDvar("pmc_debug") == "1") {
    level notify("updated_spawn_list");
    foreach(spawner in spawners) {
      thread draw_line_until_notify(spawner.origin, spawner.origin + (0, 0, 250), 0, 1, 0, level, "updated_spawn_list");
    }
  }

  return array_randomize(spawners);
}

re_populate_enemies() {
  if(level.pmc._re_populating_enemies) {
    return;
  }
  level.pmc._re_populating_enemies = true;

  wait 3.0;

  [[level.pmc.populate_enemies_func]]();

  level.pmc._re_populating_enemies = false;
}

juggernaut_setup() {
  level.jug_spawners = undefined;
  level.juggernaut_mode = false;
  level.juggernaut_next_spawner = 0;

  jugs = getEntArray("juggernaut_spawner", "targetname");

  if(isDefined(jugs) && jugs.size > 0) {
    level.juggernaut_mode = true;
    level.jug_spawners = jugs;
  }
}

spawn_juggernaut(reg_spawner) {
  jug_spawner = level.jug_spawners[level.juggernaut_next_spawner];

  level.juggernaut_next_spawner++;
  if(level.juggernaut_next_spawner >= level.jug_spawners.size) {
    wait 0.05;
    level.juggernaut_next_spawner = 0;
  }

  jug_spawner.origin = reg_spawner.origin;
  jug_spawner.angles = reg_spawner.angles;
  jug_spawner.count = 1;
  guy = jug_spawner spawn_ai();
  return guy;
}

init_enemy_combat_mode(spawnerIndex) {
  if(isDefendMatch()) {
    return;
  }

  if(getDvar("scr_force_ai_combat_mode") != "0") {
    return;
  }

  if(self animscripts\combat_utility::isLongRangeAI()) {
    return;
  }
  if(self animscripts\combat_utility::isShotgunAI()) {
    return;
  }
  if(spawnerIndex % 3) {
    self.combatMode = "ambush";
  }
}

spawn_more_enemies(spawnList, numberToSpawn) {
  debug_print("Trying to spawn " + numberToSpawn + " enemies");

  numberSpawnedCorrectly = 0;
  numberSpawnedCorrectly = spawn_more_enemies_from_array(spawnList, numberToSpawn);

  numberSpawnedIncorrectly = 0;
  if(numberSpawnedCorrectly < numberToSpawn) {
    numberSpawnedIncorrectly = spawn_more_enemies_from_array(level.pmc.enemy_spawners_full_list, numberToSpawn - numberSpawnedCorrectly, false);
  }

  assertEx(numberSpawnedCorrectly + numberSpawnedIncorrectly == numberToSpawn, "There are enough spawn locations in the level, but none of them could be used for spawning");

  debug_print("Successfully spawned " + (numberSpawnedCorrectly + numberSpawnedIncorrectly) + " enemies, after retrying " + numberSpawnedIncorrectly + " failed attempts.");
  debug_print("Possible spawners remaining: " + level.pmc.enemy_spawners.size);
}

spawn_more_enemies_from_array(spawnList, numberToSpawn, removeSpawnedFromArray) {
  if(!isDefined(removeSpawnedFromArray)) {
    removeSpawnedFromArray = true;
  }
  if(isDefendMatch()) {
    removeSpawnedFromArray = false;
  }

  spawnersUsed = [];
  numberFailedAttempts = 0;
  numberToSpawnRemaining = numberToSpawn;
  for(i = 0; i < spawnList.size; i++) {
    isjuggernaut = false;
    spawnList[i].count = 1;
    if(should_spawn_juggernaut()) {
      guy = spawn_juggernaut(spawnList[i]);
      isjuggernaut = true;
    } else {
      guy = spawnList[i] spawn_ai();
    }

    if((spawn_failed(guy)) || (!isAlive(guy)) || (!isDefined(guy))) {
      numberFailedAttempts++;
      continue;
    }
    spawnersUsed[spawnersUsed.size] = spawnList[i];
    if(isjuggernaut) {
      level.pmc.juggernauts_spawned++;
      if(level.pmc.send_in_juggernaut) {
        guy thread juggernaut_hunt_immediately_behavior();
        level.pmc.send_in_juggernaut = false;
      } else
        guy thread[[level.pmc.set_goal_func]]();
    } else {
      guy init_enemy_combat_mode(i);
      guy thread[[level.pmc.set_goal_func]]();
    }

    guy thread enemy_death_wait();
    guy thread enemy_seek_player_wait();

    numberToSpawnRemaining--;
    assert(numberToSpawnRemaining >= 0);
    if(numberToSpawnRemaining == 0) {
      break;
    }
  }

  if(removeSpawnedFromArray) {
    enemy_spawner_count_before = level.pmc.enemy_spawners.size;
    level.pmc.enemy_spawners = array_exclude(level.pmc.enemy_spawners, spawnersUsed);
    assert(level.pmc.enemy_spawners.size == enemy_spawner_count_before - spawnersUsed.size);
  }

  return spawnersUsed.size;
}

enemy_update_goal_on_jumpout() {
  self endon("death");
  self waittill("jumpedout");
  waittillframeend;
  self[[level.pmc.set_goal_func]]();
}

enemy_set_goal_when_player_spotted() {
  self endon("death");

  if(!isAI(self)) {
    return;
  }
  if(!isAlive(self)) {
    return;
  }

  self.goalradius = 450;
  self set_goal_height();

  if(isDefined(self.juggernaut)) {
    self wait_for_notify_or_timeout("enemy_visible", JUGGERNAUT_ENEMY_VISIBLE_TIMEOUT);
    juggernaut_set_goal_when_player_spotted_loop();
    return;
  }

  self waittill("enemy_visible");

  if(self animscripts\combat_utility::isShotgunAI() || (randomint(3) == 0)) {
    enemy_set_goal_when_player_spotted_loop();
  }
}

set_goal_height() {
  if(isDefined(self.juggernaut)) {
    self.goalheight = DEFAULT_ENEMY_GOAL_HEIGHT_JUGGERNAUT;
  } else if(self animscripts\combat_utility::isSniper()) {
    self.goalheight = DEFAULT_ENEMY_GOAL_HEIGHT_SNIPER;
  } else {
    self.goalheight = DEFAULT_ENEMY_GOAL_HEIGHT;
  }
}

juggernaut_set_goal_when_player_spotted_loop() {
  self endon("death");

  self.useChokePoints = false;

  while(1) {
    self.goalradius = 32;
    self set_goal_height();
    if(isDefined(self.enemy)) {
      self setgoalpos(self.enemy.origin);
    } else {
      self setgoalpos(level.player.origin);
    }
    wait 4;
  }
}

enemy_set_goal_when_player_spotted_loop() {
  self endon("death");

  while(1) {
    if(self.doingAmbush) {
      self.goalradius = 2048;
    } else if(self animscripts\combat_utility::isSniper()) {
      self.goalradius = 5000;
    } else {
      self.goalradius = randomintrange(1200, 1600);
    }

    if(isDefined(self.enemy)) {
      self setgoalpos(self.enemy.origin);
    } else {
      self setgoalpos(level.player.origin);
    }

    wait 45;
  }
}

enemy_set_goalradius() {
  if(!isAI(self)) {
    return;
  }
  if(!isAlive(self)) {
    return;
  }
  self.goalradius = randomintrange(level.pmc.enemy_goal_radius_min, level.pmc.enemy_goal_radius_max);
  self set_goal_height();
}

enemy_seek_player_wait() {
  self endon("death");
  flag_wait("enemies_seek_players");

  debug_print("AI is seeking out player!");

  self enemy_seek_player();
}

enemy_seek_player(modScale) {
  self endon("death");
  self.accuracy = 50;
  self.combatMode = "cover";
  while(1) {
    self.goalradius = randomintrange(1200, 1600);
    self set_goal_height();
    if(isDefined(self.enemy) && self.enemy.classname == "player") {
      self setgoalpos(self.enemy.origin);
    } else {
      self setgoalpos(level.players[randomint(level.players.size)].origin);
    }
    wait 45;
  }
}

enemy_seek_objective_in_stages() {
  self endon("death");
  self.goalradius = 1600;
  self setGoalPos(level.pmc.defend_obj_origin);
  wait 45;
  self.goalradius = 1100;
  wait 45;
  self.goalradius = 600;
}

enemy_seek_player_in_stages() {
  self endon("death");
  modScale = 3;
  for(;;) {
    self.goalradius = randomintrange(ENEMY_GOAL_RADIUS_SEEK_PLAYER_MIN, ENEMY_GOAL_RADIUS_SEEK_PLAYER_MAX) * modScale;
    self set_goal_height();
    self setGoalEntity(random(level.players));
    modScale--;
    if(modScale <= 0) {
      break;
    }
    wait 45;
  }
}

enemy_death_wait() {
  self thread enemy_wait_death();
  self thread enemy_wait_damagenotdone();
}

enemy_wait_death() {
  self endon("cancel_enemy_death_wait");

  self waittill("death", attacker);
  thread enemy_died(attacker);

  self notify("cancel_enemy_death_wait");
}

enemy_wait_damagenotdone() {
  self endon("cancel_enemy_death_wait");

  self waittill("damage_notdone", damage, attacker);
  thread enemy_died(attacker);

  self notify("cancel_enemy_death_wait");
}

enemy_died(attacker) {
  if(flag_exist("special_op_terminated") && flag("special_op_terminated")) {
    return;
  }

  if(level.pmc.limitRespawns) {
    level.pmc.enemies_remaining--;
  }

  assert(level.pmc.enemies_remaining >= 0);

  level notify("enemy_died");
  level notify("update_enemies_remaining_count");
  thread re_populate_enemies();

  if(level.pmc.enemies_remaining <= SEEK_PLAYERS_ENEMY_COUNT) {
    flag_set("enemies_seek_players");
  }

  if((level.pmc.limitRespawns) && (level.pmc.enemies_remaining == 0)) {
    if(isObjectiveMatch()) {
      flag_wait("objective_complete");
    }

    if(isDefined(level.pmc.objective_enemies_index)) {
      objective_state(level.pmc.objective_enemies_index, "done");
    }

    if(!isObjectiveMatch()) {
      thread mission_complete();
    }
  }
}

isEliminationMatch() {
  return (level.pmc_gametype == "mode_elimination");
}

isObjectiveMatch() {
  return (level.pmc_gametype == "mode_objective");
}

isDefendMatch() {
  return (level.pmc_gametype == "mode_defend");
}

setup_objective_entities() {
  objectiveLocations = [];

  objectiveEnt = getEntArray("pmc_objective", "targetname");
  objectiveEnt = get_array_of_closest(getAveragePlayerOrigin(), objectiveEnt);

  foreach(i, ent in objectiveEnt) {
    objectiveLocations[i] = spawnStruct();
    objectiveLocations[i].laptop = ent;
    assert(isDefined(ent.target));
    objectiveLocations[i].trigger = getent(ent.target, "targetname");
    assert(isDefined(objectiveLocations[i].trigger));
    assert(objectiveLocations[i].trigger.classname == "trigger_use");
    objectiveLocations[i].laptop hide();
    objectiveLocations[i].trigger trigger_off();
  }

  if(isDefendMatch()) {
    defend_volumes = getEntArray("info_volume_pmcDefend", "classname");
    defend_volume = getClosest(getAveragePlayerOrigin(), defend_volumes);

    obj_index = get_closest_index(defend_volume.origin, objectiveEnt);
    defend_obj = objectiveLocations[obj_index];

    objectiveLocations = array_remove(objectiveLocations, defend_obj);
    level.pmc.defend_obj_origin = defend_obj.laptop.origin;
    assertEx(isDefined(level.pmc.defend_obj_origin), "Undefined defend location origin.");
    thread set_up_defend_location(defend_obj, defend_volume);
  }

  if(isObjectiveMatch()) {
    randomLocation = randomint(objectiveLocations.size);
    level.pmc.objective = objectiveLocations[randomLocation];

    level.pmc.objective.laptop_obj = spawn("script_model", level.pmc.objective.laptop.origin);
    level.pmc.objective.laptop_obj.angles = level.pmc.objective.laptop.angles;
    level.pmc.objective.laptop_obj setModel("com_laptop_2_open_obj");

    objectiveLocations = array_remove(objectiveLocations, objectiveLocations[randomLocation]);
  }

  foreach(location in objectiveLocations) {
    location.trigger delete();
  }
}

delete_sentry_pickup() {
  waittillframeend;
  self thread common_scripts\_sentry::delete_sentry_turret();
}

set_up_defend_location(defend_obj, defend_volume) {
  defend_volume thread defend_think(80);
  thread defend_setup_time_think(defend_obj);

  foreach(gun in level.sentry_pickups) {
    d = distance(gun.origin, defend_obj.trigger.origin);
    if(d <= 300) {
      continue;
    }
    gun thread delete_sentry_pickup();
  }
}

defend_setup_time_think(defend_obj) {
  defend_obj.trigger thread defend_setup_time_trigger();
  thread defend_setup_time_hint();

  wait level.pmc.defendSetupTime;
  flag_set("pmc_defend_setup_time_finished");

  defend_obj.trigger trigger_off();
}

defend_setup_time_hint() {
  level endon("pmc_defend_setup_time_finished");
  wait 15;

  hint_defend_setup = spawnStruct();

  hint_defend_setup.string = &"PMC_START_ATTACK_HINT";
  hint_defend_setup.timeout = 5;
  foreach(player in level.players) {
    player show_hint(hint_defend_setup);
  }

  flag_wait("pmc_defend_setup_time_finished");

  hide_hint(hint_defend_setup);
}

defend_setup_time_trigger() {
  self setHintString(&"PMC_START_ATTACK_USE_HINT");
  self waittill("trigger");
  flag_set("pmc_defend_setup_time_finished");
  self trigger_off();
}

defend_think(fill_time) {
  totalTime = fill_time;
  enemy_time = 0;
  bar_doesnt_exist = true;
  bar = undefined;

  while(1) {
    self.enemy_count = 0;
    enemies = getaiarray("axis");
    foreach(enemy in enemies) {
      if((distance(enemy.origin, self.origin)) < 600) {
        enemy setGoalPos(level.pmc.defend_obj_origin);
        if(enemy istouching(self)) {
          self.enemy_count++;
        }
      }
    }

    if(self.enemy_count > 0) {
      enemy_time = enemy_time + (self.enemy_count * .05);
      if(enemy_time > 0) {
        if(bar_doesnt_exist) {
          bar = createBar();
          bar setPoint("CENTER", undefined, 0, 75);
          bar.text = createFontString("objective", 1.4);
          bar.text setPoint("CENTER", undefined, 0, 63);

          bar.text setText(&"PMC_HQ_DAMAGE");
          bar.text.sort = -1;

          bar_doesnt_exist = false;
          bar updateBar(enemy_time / totalTime);
        } else {
          bar updateBar(enemy_time / totalTime);
        }
      }
    } else {
      foreach(player in level.players) {
        if(player istouching(self)) {
          enemy_time = enemy_time - .1;
        }
        if(enemy_time < 0) {
          enemy_time = 0;
        }
        if(bar_doesnt_exist == false) {
          bar updateBar(enemy_time / totalTime);
        }
      }
    }

    if((enemy_time == 0) && (bar_doesnt_exist == false)) {
      bar.text notify("destroying");
      bar.text destroyElem();
      bar notify("destroying");
      bar destroyElem();
      bar_doesnt_exist = true;
    }
    if(enemy_time >= fill_time) {
      setDvar("ui_deadquote", &"PMC_DEFEND_FAILED");
      maps\_utility::missionFailedWrapper();
    }
    wait .05;
  }
}

show_remaining_enemy_count() {
  self.remainingEnemyCountHudelem = so_create_hud_item(2, so_hud_ypos(), &"SPECIAL_OPS_HOSTILES", self);
  self.remainingEnemyCountHudelemNum = so_create_hud_item(2, so_hud_ypos(), "", self);
  self.remainingEnemyCountHudelemNum.alignX = "left";

  for(;;) {
    self.remainingEnemyCountHudElemNum setValue(level.pmc.enemies_remaining);
    if(isDefined(level.pmc.enemies_kills_to_win) && (level.pmc.enemies_kills_to_win > 0)) {
      thread so_dialog_counter_update(level.pmc.enemies_remaining, level.pmc_enemies);
    }

    if(isDefined(level.pmc.objective_enemies_index)) {}
    objective_String_NoMessage(level.pmc.objective_enemies_index, &"PMC_OBJECTIVE_KILL_ENEMIES_REMAINING", level.pmc.enemies_remaining);

    if(level.pmc.enemies_remaining <= 0) {
      self.remainingEnemyCountHudelem thread so_hud_pulse_success();
      self.remainingEnemyCountHudelemNum thread so_hud_pulse_success();

      break;
    }

    if(isDefined(level.pmc_low_enemy_count) && level.pmc.enemies_remaining <= level.pmc_low_enemy_count) {
      self.remainingEnemyCountHudelem thread so_hud_pulse_close();
      self.remainingEnemyCountHudelemNum thread so_hud_pulse_close();
    }

    level waittill("update_enemies_remaining_count");
  }

  flag_wait("mission_complete");
  self.remainingEnemyCountHudelem thread so_remove_hud_item();
  self.remainingEnemyCountHudelemNum thread so_remove_hud_item();
}

enemy_remaining_count_blimp() {
  level notify("enemy_remaining_count_blimp");
  level endon("enemy_remaining_count_blimp");

  scaleTimeOut = 0.1;
  scaleTimeIn = 0.4;
  scaleSize = 1.3;

  wait 0.1;

  level.pmc.hud.remainingEnemyCountHudElem changeFontScaleOverTime(scaleTimeOut);
  level.pmc.hud.remainingEnemyCountHudElem.fontscale = scaleSize;

  wait scaleTimeOut + 0.2;

  level.pmc.hud.remainingEnemyCountHudElem changeFontScaleOverTime(scaleTimeIn);
  level.pmc.hud.remainingEnemyCountHudElem.fontscale = 1.0;
}

gametype_setup() {
  if(isObjectiveMatch()) {
    array_thread(level.players, ::player_use_objective_think);
    thread wait_objective_complete();
  }
  thread enable_challenge_timer("mission_start", "mission_complete");
}

player_use_objective_think() {
  level endon("kill_objective_use_thread");

  while(!isDefined(level.pmc.objective)) {
    wait 0.05;
  }

  level.pmc.objective.trigger trigger_on();
  level.pmc.objective.laptop show();
  level.pmc.objective.trigger.active = true;
  level.pmc.objective.trigger sethintstring(&"PMC_HINT_USELAPTOP");

  for(;;) {
    wait 0.05;

    level.pmc.objective.trigger waittill("trigger", player);
    if(player != self) {
      continue;
    }
    buttonTime = 0;
    totalTime = 3.0;
    qDone = false;

    player thread freeze_controls_while_using_laptop();

    self.objective_bar = self createClientProgressBar(self, 60);
    self.objective_bar_text = self createClientFontString("default", 1.2);
    self.objective_bar_text setPoint("CENTER", undefined, 0, 45);
    self.objective_bar_text settext(&"PMC_HQ_RECOVERING_INTEL");

    while((self useButtonPressed()) && (!flag("objective_complete"))) {
      self.objective_bar updateBar(buttonTime / totalTime);

      wait 0.05;
      buttonTime += 0.05;
      if(buttonTime > totalTime) {
        qDone = true;
        break;
      }
    }

    if(isDefined(self.objective_bar)) {
      self.objective_bar destroyElem();
    }
    if(isDefined(self.objective_bar_text)) {
      self.objective_bar_text destroyElem();
    }

    player notify("remove_laptop_pickup_hud");

    if(qDone) {
      player playSound("intelligence_pickup");
      break;
    }
  }

  foreach(player in level.players) {
    player notify("remove_laptop_pickup_hud");
    if(isDefined(player.objective_bar)) {
      player.objective_bar destroyElem();
      player.objective_bar = undefined;
    }
    if(isDefined(player.objective_bar_text)) {
      player.objective_bar_text destroyElem();
      player.objective_bar_text = undefined;
    }
  }

  level.pmc.objective.trigger delete();
  level.pmc.objective.laptop_obj delete();
  level.pmc.objective.laptop delete();

  flag_set("objective_complete");
}

freeze_controls_while_using_laptop() {
  self endon("death");

  self disableweapons();
  self freezeControls(true);

  self waittill("remove_laptop_pickup_hud");

  self enableweapons();
  self freezeControls(false);
}

wait_objective_complete() {
  flag_wait("objective_complete");
  wait 0.05;
  level notify("kill_objective_use_thread");

  extraction_info = get_extraction_location();

  objective_state(1, "done");

  objective_add(2, "current", &"PMC_OBJECTIVE_EXTRACT", extraction_info.script_origin.origin);
  if(!flag("exfiltrate_music_playing")) {
    flag_set("exfiltrate_music_playing");
  }
  thread play_local_sound("exfiltrate");
  playFX(getfx("extraction_smoke"), extraction_info.script_origin.origin);

  maps\_specialops_code::wait_all_players_are_touching(extraction_info.trigger);

  objective_state(2, "done");

  flag_set("extraction_complete");
  flag_set("mission_complete");
  thread mission_complete();
}

get_extraction_location() {
  extraction_info = spawnStruct();

  extraction_origins = getEntArray("extraction", "targetname");
  averageOrigin = getAveragePlayerOrigin();
  extraction_origins = get_array_of_closest(averageOrigin, extraction_origins);

  extraction_info.script_origin = extraction_origins[extraction_origins.size - 1];
  assert(isDefined(extraction_info.script_origin));

  extraction_info.trigger = getent(extraction_info.script_origin.target, "targetname");
  assert(isDefined(extraction_info.trigger));

  return extraction_info;
}

add_player_objectives() {
  if(isObjectiveMatch()) {
    objective_add_laptop(1);
  } else if(isDefendMatch()) {
    thread objective_add_defend();
  } else {
    objective_add_enemies(1);
    foreach(player in level.players) {
      player thread show_remaining_enemy_count();
    }
  }
}

objective_add_enemies(objNum) {
  if(!isDefined(objNum)) {
    objNum = 1;
  }
  level.pmc.objective_enemies_index = objNum;

  objective_add(objNum, "current", &"PMC_OBJECTIVE_KILL_ENEMIES", (0, 0, 0));

  objective_String_NoMessage(objNum, &"PMC_OBJECTIVE_KILL_ENEMIES_REMAINING", level.pmc.enemies_remaining);
}

objective_add_laptop(objNum) {
  if(!isDefined(objNum)) {
    objNum = 1;
  }
  assert(isDefined(level.pmc.objective.trigger.origin));

  while(!isDefined(level.pmc.objective.trigger.active)) {
    wait 0.05;
  }

  objective_add(objNum, "current", &"PMC_OBJECTIVE_ABORT_CODES", level.pmc.objective.trigger.origin);
}

objective_add_defend() {
  assert(isDefined(level.pmc.defendSetupTime));
  assert(isDefined(level.pmc.defendTime));

  objective_add(1, "current", &"PMC_OBJECTIVE_SETUP_DEFENSES", (0, 0, 0));
  thread show_defend_timer();

  flag_wait("pmc_defend_setup_time_finished");

  flag_set("defend_started");

  objective_state(1, "done");

  objective_add(2, "current", &"PMC_OBJECTIVE_DEFEND", (0, 0, 0));

  wait level.pmc.defendTime;

  objective_state(2, "done");
  thread mission_complete();
}

show_defend_timer() {
  level.pmc.hud.defendTimer = newHudElem();
  level.pmc.hud.defendTimer.x = 0;
  level.pmc.hud.defendTimer.y = 30;
  level.pmc.hud.defendTimer.fontScale = 2.5;
  level.pmc.hud.defendTimer.alignX = "left";
  level.pmc.hud.defendTimer.alignY = "middle";
  level.pmc.hud.defendTimer.horzAlign = "left";
  level.pmc.hud.defendTimer.vertAlign = "middle";
  level.pmc.hud.defendTimer.alpha = 1;

  level.pmc.hud.defendTimer.label = &"PMC_TIME_UNTIL_ATTACK";
  level.pmc.hud.defendTimer setTimer(level.pmc.defendSetupTime);

  flag_wait("pmc_defend_setup_time_finished");

  level.pmc.hud.defendTimer.label = &"PMC_TIME_REMAINING";
  level.pmc.hud.defendTimer setTimer(level.pmc.defendTime);
}

play_local_sound(alias, loopTime, stop_loop_notify) {
  assert(isDefined(level.pmc.sound));
  assert(isDefined(level.pmc.sound[alias]));

  if(isArray(level.pmc.sound[alias])) {
    rand = randomint(level.pmc.sound[alias].size);
    aliasToPlay = level.pmc.sound[alias][rand];
  } else {
    aliasToPlay = level.pmc.sound[alias];
  }

  if(!isDefined(loopTime)) {
    array_thread(level.players, ::playLocalSoundWrapper, aliasToPlay);
    return;
  }

  level endon("special_op_terminated");
  level endon(stop_loop_notify);
  for(;;) {
    array_thread(level.players, ::playLocalSoundWrapper, aliasToPlay);
    wait loopTime;
  }
}

mission_complete() {
  flag_set("mission_complete");
}

debug_print(string) {
  if(getDvar("pmc_debug") == "1") {
    assert(isDefined(string));
    iprintln(string);
  }
}

debug_show_enemy_spawners_count() {
  if(isDefendMatch()) {
    return;
  }
  level.pmc.hud.enemySpawnerCountHudElem = newHudElem();
  level.pmc.hud.enemySpawnerCountHudElem.x = 0;
  level.pmc.hud.enemySpawnerCountHudElem.y = -30;
  level.pmc.hud.enemySpawnerCountHudElem.fontScale = 1.5;
  level.pmc.hud.enemySpawnerCountHudElem.alignX = "left";
  level.pmc.hud.enemySpawnerCountHudElem.alignY = "bottom";
  level.pmc.hud.enemySpawnerCountHudElem.horzAlign = "left";
  level.pmc.hud.enemySpawnerCountHudElem.vertAlign = "bottom";

  level.pmc.hud.enemySpawnerCountHudElem.label = &"PMC_DEBUG_SPAWNER_COUNT";
  level.pmc.hud.enemySpawnerCountHudElem.alpha = 1;

  for(;;) {
    assert(isDefined(level.pmc.enemy_spawners));
    assert(isDefined(level.pmc.enemy_spawners.size));
    level.pmc.hud.enemySpawnerCountHudElem setValue(level.pmc.enemy_spawners.size);
    wait 0.05;
  }
}

debug_show_enemies_alive_count() {
  level.pmc.hud.enemyCountHudElem = newHudElem();
  level.pmc.hud.enemyCountHudElem.x = 0;
  level.pmc.hud.enemyCountHudElem.y = -15;
  level.pmc.hud.enemyCountHudElem.fontScale = 1.5;
  level.pmc.hud.enemyCountHudElem.alignX = "left";
  level.pmc.hud.enemyCountHudElem.alignY = "bottom";
  level.pmc.hud.enemyCountHudElem.horzAlign = "left";
  level.pmc.hud.enemyCountHudElem.vertAlign = "bottom";

  level.pmc.hud.enemyCountHudElem.label = &"PMC_DEBUG_ENEMY_COUNT";
  level.pmc.hud.enemyCountHudElem.alpha = 1;

  for(;;) {
    enemyAIAlive = getaiarray("axis");
    assert(isDefined(enemyAIAlive));
    assert(isDefined(enemyAIAlive.size));
    level.pmc.hud.enemyCountHudElem setValue(enemyAIAlive.size + level.pmc.enemy_vehicles_alive);
    wait 0.05;
  }
}

debug_show_vehicles_alive_count() {
  level.pmc.hud.enemyVehicleCountHudElem = newHudElem();
  level.pmc.hud.enemyVehicleCountHudElem.x = 0;
  level.pmc.hud.enemyVehicleCountHudElem.y = 0;
  level.pmc.hud.enemyVehicleCountHudElem.fontScale = 1.5;
  level.pmc.hud.enemyVehicleCountHudElem.alignX = "left";
  level.pmc.hud.enemyVehicleCountHudElem.alignY = "bottom";
  level.pmc.hud.enemyVehicleCountHudElem.horzAlign = "left";
  level.pmc.hud.enemyVehicleCountHudElem.vertAlign = "bottom";

  level.pmc.hud.enemyVehicleCountHudElem.label = &"PMC_DEBUG_VEHICLE_COUNT";
  level.pmc.hud.enemyVehicleCountHudElem.alpha = 1;

  for(;;) {
    level.pmc.hud.enemyVehicleCountHudElem setValue(level.pmc.enemy_vehicles_alive);
    wait 0.05;
  }
}

room_breach_spawned() {
  delete_unseen_enemy();
  self thread enemy_death_wait();
}

delete_unseen_enemy() {
  ai = get_array_of_closest(getAveragePlayerOrigin(), getaiarray("axis"));
  ai = array_reverse(ai);

  foreach(enemy in ai) {
    if(!enemy enemy_can_see_any_player()) {
      println("^3An AI was deleted to make room for a door breach spawner");
      enemy notify("cancel_enemy_death_wait");
      enemy delete();
      return;
    }
  }
}

enemy_can_see_any_player() {
  foreach(player in level.players) {
    if(self cansee(player)) {
      return true;
    }
  }
  return false;
}

staged_pacing_system() {
  one_third = int(level.pmc.enemies_kills_to_win / 3);
  two_thirds = int((level.pmc.enemies_kills_to_win * 2) / 3);
  level.pmc.max_juggernauts = int(level.pmc.enemies_kills_to_win / 7);

  thread count_dead_juggernauts();

  flag_set("staged_pacing_used");
  while(1) {
    level waittill("enemy_died");

    if(level.pmc.enemies_remaining >= two_thirds) {
      println("pacingstage 1");
      force_odds = one_third * 2;
    } else if(level.pmc.enemies_remaining >= one_third) {
      flag_set("pacing_stage_2");
      println("pacingstage 2");
      thread send_in_one_juggernaut(one_third);
    } else {
      flag_set("pacing_stage_3");
      println("pacingstage 3");

      thread send_in_multiple_juggernauts();
    }
  }

}

count_dead_juggernauts() {
  while(1) {
    level waittill("juggernaut_died");
    level.pmc.juggernauts_killed++;
  }
}

juggernaut_hunt_immediately_behavior() {
  self endon("death");

  self.useChokePoints = false;

  while(1) {
    self.goalradius = 32;
    self set_goal_height();
    if(isDefined(self.enemy)) {
      self setgoalpos(self.enemy.origin);
    } else {
      enemyPlayer = level.players[randomInt(level.players.size)];
      self setgoalpos(enemyPlayer.origin);
    }

    wait 4;
  }
}

send_in_one_juggernaut(one_third) {
  living = level.pmc.juggernauts_spawned - level.pmc.juggernauts_killed;
  allowed_for_this_stage = (level.pmc.max_juggernauts / 2);

  if(living > 0) {
    return;
  }
  if(level.pmc.juggernauts_spawned >= allowed_for_this_stage) {
    return;
  }
  println("pacingtrying for 1 juggernaut");
  odds = int((one_third / allowed_for_this_stage) / 2);

  if(randomint(odds) > 0) {
    return;
  }
  println("pacingspawning 1 juggernaut");
  delete_unseen_enemy();
  level.pmc.send_in_juggernaut = true;
}

send_in_multiple_juggernauts() {
  jugs_remaining = level.pmc.max_juggernauts - level.pmc.juggernauts_spawned;

  if(jugs_remaining < 1) {
    return;
  }
  println("pacingtrying for x juggernauts");
  odds = int(level.pmc.enemies_remaining / jugs_remaining);

  if(odds <= 0) {
    odds = 1;
  }
  if(randomint(odds) > 0) {
    return;
  }
  println("pacingspawning 1 juggernaut");
  delete_unseen_enemy();
  level.pmc.send_in_juggernaut = true;
}

should_spawn_juggernaut() {
  if(level.pmc_alljuggernauts) {
    return true;
  }
  if(!level.juggernaut_mode) {
    return false;
  }

  if(!level.pmc.spawned_juggernaut_at_game_start) {
    assert(level.pmc.spawned_juggernaut_at_game_start_counter > 0);
    chance = randomint(level.pmc.spawned_juggernaut_at_game_start_counter);
    level.pmc.spawned_juggernaut_at_game_start_counter--;
    if(chance == 0) {
      level.pmc.spawned_juggernaut_at_game_start = true;
      return true;
    }
  }

  if(flag("staged_pacing_used")) {
    if(level.pmc.send_in_juggernaut) {
      return true;
    } else {
      return false;
    }
  }
  if(randomint(10) > 0) {
    return false;
  } else {
    return true;
  }
}