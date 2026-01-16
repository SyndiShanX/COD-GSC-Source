/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_spawn_director.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\alien\_utility;

CYCLE_TABLE = "mp/alien/default_cycle_spawn.csv";
CYCLE_TABLE_HARDCORE = "mp/alien/default_cycle_spawn_hardcore.csv";
TABLE_CYCLE_DEF_INDEX = 399;

TABLE_INDEX = 0;
TABLE_CYCLE = 1;
TABLE_INTENSITY = 2;
TABLE_INTENSITY_THRESHOLD = 3;
TABLE_RESPAWN_THRESHOLD = 4;
TABLE_RESPAWN_DELAY = 5;
TABLE_LANES = 6;
TABLE_TYPES1 = 7;
TABLE_COUNT1 = 8;
TABLE_TYPES2 = 9;
TABLE_COUNT2 = 10;
TABLE_TYPES3 = 11;
TABLE_COUNT3 = 12;
TABLE_TYPES4 = 13;
TABLE_COUNT4 = 14;
TABLE_TYPES5 = 15;
TABLE_COUNT5 = 16;
TABLE_TYPES6 = 17;
TABLE_COUNT6 = 18;
TABLE_TYPES7 = 19;
TABLE_COUNT7 = 20;
TABLE_TYPES8 = 21;
TABLE_COUNT8 = 22;
TABLE_TYPES9 = 23;
TABLE_COUNT9 = 24;

TABLE_SPAWN_EVENT_START_INDEX = 2000;
TABLE_SPAWN_EVENT_END_INDEX = 2099;
TABLE_SPAWN_EVENT_CYCLE = 1;
TABLE_SPAWN_EVENT_NOTIFY = 2;
TABLE_SPAWN_EVENT_ID = 3;
TABLE_SPAWN_EVENT_TIME_LIMIT = 4;
TABLE_SPAWN_EVENT_LANES = 5;

TABLE_SPAWN_EVENT_WAVE_START_INDEX = 3000;
TABLE_SPAWN_EVENT_WAVE_END_INDEX = 3099;
TABLE_SPAWN_EVENT_WAVE_ID = 1;
TABLE_SPAWN_EVENT_WAVE_BLOCKING = 2;
TABLE_SPAWN_EVENT_WAVE_SPAWN_DELAY = 3;
TABLE_SPAWN_EVENT_WAVE_TYPE1 = 4;
TABLE_SPAWN_EVENT_WAVE_COUNT1 = 5;
TABLE_SPAWN_EVENT_WAVE_TYPE2 = 6;
TABLE_SPAWN_EVENT_WAVE_COUNT2 = 7;
TABLE_SPAWN_EVENT_WAVE_TYPE3 = 8;
TABLE_SPAWN_EVENT_WAVE_COUNT3 = 9;
TABLE_SPAWN_EVENT_WAVE_TYPE4 = 10;
TABLE_SPAWN_EVENT_WAVE_COUNT4 = 11;
TABLE_SPAWN_EVENT_WAVE_TYPE5 = 12;
TABLE_SPAWN_EVENT_WAVE_COUNT5 = 13;

TABLE_MIN_SPAWN_INTERVAL = 400;
TABLE_SAFE_SPAWN_DISTANCE = 401;
TABLE_SPAWN_POINT_LAST_USED_DURATION = 402;
TABLE_GROUP_BREAK_AWAY_DISTANCE = 403;
TABLE_PLAYER_IN_ZONE_SCORE = 404;
TABLE_CURRENT_ATTACKER_ZONE_SCORE = 405;
TABLE_RECENTLY_SPAWNED_ZONE_MODIFIER = 406;
TABLE_MAX_BREAK_AWAY_SCORE_INCREASE = 407;
TABLE_SPAWN_EVENT_MIN_ACTIVATION_TIME = 408;
TABLE_SPAWN_EVENT_PER_ALIEN_ACTIVATION_INCREASE = 409;
TABLE_SPAWN_EVENT_MAX_ACTIVATION_TIME = 410;
TABLE_VARIABLE_COLUMN = 2;

TABLE_CYCLE_SCALAR_START_INDEX = 500;
TABLE_CYCLE_SCALAR_END_INDEX = 599;
TABLE_CYCLE_SCALAR_CYCLE = 1;
TABLE_CYCLE_SCALAR_HEALTH = 2;
TABLE_CYCLE_SCALAR_DAMAGE = 3;
TABLE_CYCLE_SCALAR_REWARD = 4;
TABLE_CYCLE_SCALAR_SCORE = 5;

TABLE_CYCLE_DRILL_LAYER_START_INDEX = 600;
TABLE_CYCLE_DRILL_LAYER_END_INDEX = 699;
TABLE_CYCLE_DRILL_LAYER_CYCLE = 1;
TABLE_CYCLE_DRILL_LAYERS = 2;
TABLE_CYCLE_DRILL_DELAY = 3;

TABLE_LANES_START_INDEX = 700;
TABLE_LANES_END_INDEX = 799;
TABLE_LANES_ENCOUNTER = 1;
TABLE_LANES_ACTIVATION_TIME = 2;
TABLE_LANES_NAMES = 3;

TABLE_1000_CYCLE_START_IDX = 1000;
TABLE_1000_CYCLE_END_IDX = 1999;

TABLE_RANDOM_HIVES_START_INDEX = 900;
TABLE_RANDOM_HIVES_END_INDEX = 999;
TABLE_RANDOM_HIVES_NUM_SPAWNED = 1;
TABLE_RANDOM_HIVES_HIVE_LIST = 2;

SPAWN_NODE_INFO_TABLE = "mp/alien/spawn_node_info.csv";

TABLE_SPAWN_NODE_KEY = 1;
TABLE_SPAWN_VALID_ALIEN_TYPE = 2;
TABLE_ONE_OFF_SCRIPTABLE = 3;
TABLE_GOON_VIGNETTE_STATE = 4;
TABLE_GOON_VIGNETTE_INDEX_ARRAY = 5;
TABLE_GOON_VIGNETTE_LABEL = 6;
TABLE_GOON_VIGNETTE_END_NOTETRACK = 7;
TABLE_GOON_VIGNETTE_FX = 8;
TABLE_GOON_VIGNETTE_SCRIPTABLE = 9;
TABLE_GOON_VIGNETTE_SCRIPTABLE_STATE = 10;
TABLE_BRUTE_VIGNETTE_STATE = 11;
TABLE_BRUTE_VIGNETTE_INDEX_ARRAY = 12;
TABLE_BRUTE_VIGNETTE_LABEL = 13;
TABLE_BRUTE_VIGNETTE_END_NOTETRACK = 14;
TABLE_BRUTE_VIGNETTE_FX = 15;
TABLE_BRUTE_VIGNETTE_SCRIPTABLE = 16;
TABLE_BRUTE_VIGNETTE_SCRIPTABLE_STATE = 17;
TABLE_SPITTER_VIGNETTE_STATE = 18;
TABLE_SPITTER_VIGNETTE_INDEX_ARRAY = 19;
TABLE_SPITTER_VIGNETTE_LABEL = 20;
TABLE_SPITTER_VIGNETTE_END_NOTETRACK = 21;
TABLE_SPITTER_VIGNETTE_FX = 22;
TABLE_SPITTER_VIGNETTE_SCRIPTABLE = 23;
TABLE_SPITTER_VIGNETTE_SCRIPTABLE_STATE = 24;
TABLE_ELITE_VIGNETTE_STATE = 25;
TABLE_ELITE_VIGNETTE_INDEX_ARRAY = 26;
TABLE_ELITE_VIGNETTE_LABEL = 27;
TABLE_ELITE_VIGNETTE_END_NOTETRACK = 28;
TABLE_ELITE_VIGNETTE_FX = 29;
TABLE_ELITE_VIGNETTE_SCRIPTABLE = 30;
TABLE_ELITE_VIGNETTE_SCRIPTABLE_STATE = 31;
TABLE_MINION_VIGNETTE_STATE = 32;
TABLE_MINION_VIGNETTE_INDEX_ARRAY = 33;
TABLE_MINION_VIGNETTE_LABEL = 34;
TABLE_MINION_VIGNETTE_END_NOTETRACK = 35;
TABLE_MINION_VIGNETTE_FX = 36;
TABLE_MINION_VIGNETTE_SCRIPTABLE = 37;
TABLE_MINION_VIGNETTE_SCRIPTABLE_STATE = 38;

TABLE_SPAWN_NODE_INFO_START_INDEX = 1;
TABLE_SPAWN_NODE_INFO_MAX_INDEX = 100;

BASE_PLAYER_COUNT_MULTIPLIER = 0.49;
ADDITIONAL_PLAYER_COUNT_MULTIPLIER = 0.17;
MAX_ALIEN_COUNT = 18;

MIN_SPAWN_INTERVAL = 1.0;
SAFE_SPAWN_DISTANCE = 500.0;
LAST_USED_TIME_DURATION = 5000.0;

GROUP_BREAK_AWAY_DISTANCE = 1500;
PLAYER_IN_ZONE_SCORE = 0.75;
CURRENT_ATTACKER_FOR_ZONE_SCALE = 0.25;
RECENTLY_SPAWNED_ZONE_MODIFIER = 0.25;
MAX_BREAK_AWAY_SCORE_INCREASE = 2.5;

LANE_CHANGE_SPAWN_SOUND = "alien_distant";

init() {
  if(!isDefined(level.alien_cycle_table))
    level.alien_cycle_table = CYCLE_TABLE;

  if(!isDefined(level.alien_cycle_table_hardcore))
    level.alien_cycle_table_hardcore = CYCLE_TABLE_HARDCORE;

  if(is_hardcore_mode())
    level.alien_cycle_table = level.alien_cycle_table_hardcore;

  if(!isDefined(level.base_player_count_multiplier)) {
    level.base_player_count_multiplier = BASE_PLAYER_COUNT_MULTIPLIER;
    level.additional_player_count_multiplier = ADDITIONAL_PLAYER_COUNT_MULTIPLIER;
  }

  if(!isDefined(level.hardcore_spawn_multiplier))
    level.hardcore_spawn_multiplier = 1.0;

  if(!isDefined(level.hardcore_damage_scalar))
    level.hardcore_damage_scalar = 1.0;

  if(!isDefined(level.hardcore_health_scalar))
    level.hardcore_health_scalar = 1.0;

  if(!isDefined(level.hardcore_reward_scalar))
    level.hardcore_reward_scalar = 1.0;

  if(!isDefined(level.hardcore_score_scalar))
    level.hardcore_score_scalar = 1.0;

  if(!isDefined(level.casual_spawn_multiplier))
    level.casual_spawn_multiplier = 1.0;

  if(!isDefined(level.casual_damage_scalar))
    level.casual_damage_scalar = 0.5;

  if(!isDefined(level.casual_health_scalar))
    level.casual_health_scalar = 0.5;

  if(!isDefined(level.casual_reward_scalar))
    level.casual_reward_scalar = 1.0;

  if(!isDefined(level.casual_score_scalar))
    level.casual_score_scalar = 0.5;

  level.cycle_data = spawnStruct();
  level.lanes = [];

  load_cycles_from_table(level.cycle_data);
  init_spawn_node_info(level.cycle_data);
  build_spawn_zones(level.cycle_data);
  load_spawn_events_from_table(level.cycle_data);
  load_variables_from_table(level.cycle_data);
  load_cycle_scalars_from_table(level.cycle_data);
  load_cycle_drill_layer_from_table(level.cycle_data);
  load_random_hives_from_table();
  load_encounter_lanes_from_table();
  populate_lane_spawners();

  level.cycle_data.current_wave_types = create_wave_types_array();
  level.cycle_data.current_spawn_event_wave_types = create_wave_types_array();

  level thread spawn_type_vo_monitor();
  level thread monitor_meteor_spawn();
  level thread monitor_ground_spawn();

  level.pending_meteor_spawns = 0;
  level.pending_ground_spawns = 0;
  level.pending_custom_spawns = 0;
  level.cycle_spawning_active = false;

  if(isPlayingSolo())
    level.cycle_data.max_alien_count = int(ceil(MAX_ALIEN_COUNT * level.base_player_count_multiplier));
  else
    level.cycle_data.max_alien_count = MAX_ALIEN_COUNT;

  level thread monitor_debug_dvar();
}

load_variables_from_table(cycle_data) {
  cycle_data.min_spawn_interval = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_MIN_SPAWN_INTERVAL, TABLE_VARIABLE_COLUMN));

  safeSpawnDistanceValue = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_SAFE_SPAWN_DISTANCE, TABLE_VARIABLE_COLUMN));
  cycle_data.safe_spawn_distance_sq = safeSpawnDistanceValue * safeSpawnDistanceValue;

  cycle_data.spawn_point_last_used_duration = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_SPAWN_POINT_LAST_USED_DURATION, TABLE_VARIABLE_COLUMN)) * 1000.0;

  breakAwayDistance = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_GROUP_BREAK_AWAY_DISTANCE, TABLE_VARIABLE_COLUMN));
  cycle_data.group_break_away_distance_sq = breakAwayDistance * breakAwayDistance;

  cycle_data.player_in_zone_score_modifier = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_PLAYER_IN_ZONE_SCORE, TABLE_VARIABLE_COLUMN));
  cycle_data.current_attacker_in_zone_score_modifier = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_CURRENT_ATTACKER_ZONE_SCORE, TABLE_VARIABLE_COLUMN));
  cycle_data.recently_used_spawn_zone_score_modifier = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_RECENTLY_SPAWNED_ZONE_MODIFIER, TABLE_VARIABLE_COLUMN));
  cycle_data.max_break_away_zone_score_increase = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_MAX_BREAK_AWAY_SCORE_INCREASE, TABLE_VARIABLE_COLUMN));

  cycle_data.spawn_event_min_activation_time = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_SPAWN_EVENT_MIN_ACTIVATION_TIME, TABLE_VARIABLE_COLUMN));
  cycle_data.spawn_event_per_alien_activation_increase = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_SPAWN_EVENT_PER_ALIEN_ACTIVATION_INCREASE, TABLE_VARIABLE_COLUMN));
  cycle_data.spawn_event_max_activation_increase = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, TABLE_SPAWN_EVENT_MAX_ACTIVATION_TIME, TABLE_VARIABLE_COLUMN));
}

load_encounter_lanes_from_table() {
  level.encounter_lanes = [];

  for(entryIndex = TABLE_LANES_START_INDEX; entryIndex <= TABLE_LANES_END_INDEX; entryIndex++) {
    encounter = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_LANES_ENCOUNTER);
    if(encounter == "") {
      break;
    }

    if(!isDefined(level.encounter_lanes[encounter]))
      level.encounter_lanes[encounter] = [];

    activationTimes = strtok(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_LANES_ACTIVATION_TIME), ", ");
    names = strTok(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_LANES_NAMES), " ,()");
    lanes = get_lanes_from_names(names);
    isRandomSequence = (ToLower(names[0]) == "random_sequence" && names.size > 1);

    currentIndex = 0;
    foreach(time in activationTimes) {
      newLanes = [];
      if(isRandomSequence) {
        newLanes[0] = lanes[currentIndex];
        currentIndex++;
        if(currentIndex >= lanes.size)
          currentIndex = 0;
      } else {
        newLanes = lanes;
      }

      add_new_encounter_lane(encounter, newLanes, time);
    }

    foreach(laneName in lanes) {
      if(isDefined(level.lanes[laneName])) {
        continue;
      }
      level.lanes[laneName] = [];
    }
  }

  foreach(index, encounterLane in level.encounter_lanes)
  level.encounter_lanes[index] = sort_array(level.encounter_lanes[index], ::sort_encounter_level_activation_time_func);
}

add_new_encounter_lane(encounter, lanes, time) {
  encounterLane = spawnStruct();
  encounterLane.lanes = lanes;
  encounterLane.activation_time = int(time) * 1000.0;

  laneIndex = level.encounter_lanes[encounter].size;
  level.encounter_lanes[encounter][laneIndex] = encounterLane;
}

get_lanes_from_names(lane_names) {
  isRandomSequence = (ToLower(lane_names[0]) == "random_sequence" && lane_names.size > 1);
  isRandom = (ToLower(lane_names[0]) == "random" && lane_names.size > 1);
  lanes = [];

  if(isRandomSequence) {
    lanes = array_remove_index(lane_names, 0);
    lanes = array_randomize(lanes);
  } else if(isRandom) {
    randomIndex = RandomIntRange(1, lane_names.size);
    lanes[0] = lane_names[randomIndex];
  } else {
    lanes = lane_names;
  }

  return lanes;
}

populate_lane_spawners() {
  foreach(index, lane in level.lanes) {
    laneStruct = getstruct(index, "targetname");

    /# AssertEx( isDefined( laneStruct), "Can't find struct in level for lane: " + index ); #/ /
    # AssertEx(isDefined(laneStruct.script_linkTo), "Missing script_linkTo KVP for lane: " + index);

    linkedSpawners = laneStruct get_links();

    /# AssertEx( linkedSpawners.size > 0, "No attached spawners for lane: " + index );

    foreach(spawnerName in linkedSpawners) {
      spawners = find_spawners_by_script_name(spawnerName);
      level.lanes[index] = array_combine(level.lanes[index], spawners);
    }
  }
}

find_spawners_by_script_name(script_name) {
  spawners = [];

  for(spawnIndex = 0; spawnIndex < level.cycle_data.spawner_list.size; spawnIndex++) {
    if(!isDefined(level.cycle_data.spawner_list[spawnIndex]["location"].script_linkname)) {
      continue;
    }
    if(level.cycle_data.spawner_list[spawnIndex]["location"].script_linkname == script_name)
      spawners[spawners.size] = spawnIndex;
  }

  return spawners;
}

load_spawn_events_from_table(cycle_data) {
  cycle_data.generic_spawn_events = [];

  for(entryIndex = TABLE_SPAWN_EVENT_START_INDEX; entryIndex <= TABLE_SPAWN_EVENT_END_INDEX; entryIndex++) {
    cycle = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_CYCLE);
    if(cycle == "") {
      break;
    }

    cycleNum = int(cycle) - 1;
    /# AssertEx( cycleNum >= -1 && cycleNum < level.cycle_data.spawn_cycles.size, "Spawn event cycle " + cycle + " references non-existent cycle!" );

    spawnEvent = spawnStruct();
    spawnEvent.activation_notify = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_NOTIFY);
    spawnEvent.id = strtok(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_ID), " ,");
    spawnEvent.time_limit = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_TIME_LIMIT));
    lane_names = strTok(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_LANES), " ,");
    if(lane_names.size > 0) {
      lanes = get_lanes_from_names(lane_names);
      spawnEvent.lanes = lanes;
      foreach(laneName in lanes) {
        if(isDefined(level.lanes[laneName])) {
          continue;
        }
        level.lanes[laneName] = [];
      }
    }

    if(cycleNum == -1) {
      spawnEvent.allow_initial_delay = false;
      newIndex = cycle_data.generic_spawn_events.size;
      cycle_data.generic_spawn_events[newIndex] = spawnEvent;
    } else {
      spawnEvent.allow_initial_delay = true;
      newIndex = cycle_data.spawn_cycles[cycleNum].spawn_events.size;
      cycle_data.spawn_cycles[cycleNum].spawn_events[newIndex] = spawnEvent;
    }
  }

  load_spawn_event_waves_from_table();
}

load_spawn_event_waves_from_table() {
  level.spawn_event_waves = [];

  for(entryIndex = TABLE_SPAWN_EVENT_WAVE_START_INDEX; entryIndex <= TABLE_SPAWN_EVENT_WAVE_END_INDEX; entryIndex++) {
    spawnEventID = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_WAVE_ID);
    if(spawnEventID == "") {
      break;
    }

    if(!isDefined(level.spawn_event_waves[spawnEventID]))
      level.spawn_event_waves[spawnEventID] = [];

    spawnEventWave = spawnStruct();
    spawnEventWave.blocking = get_spawn_event_wave_blocking_by_index(entryIndex);
    spawnEventWave.spawn_delay = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_EVENT_ID));
    spawnEventWave.entry_index = entryIndex;

    addIndex = level.spawn_event_waves[spawnEventID].size;
    level.spawn_event_waves[spawnEventID][addIndex] = spawnEventWave;
  }
}

get_spawn_event_wave_blocking_by_index(index) {
  blocking = tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_SPAWN_EVENT_WAVE_BLOCKING);

  return blocking == "yes";
}

clear_spawn_event_wave_types() {
  foreach(waveType in level.cycle_data.current_spawn_event_wave_types) {
    waveType.type_name = undefined;
    waveType.min_spawned = undefined;
    waveType.max_spawned = undefined;
    waveType.max_of_type = undefined;
  }
}

get_spawn_event_types_array(cycle) {
  clear_spawn_event_wave_types();

  get_type_data(get_available_type_data(level.cycle_data.current_spawn_event_wave_types), cycle, TABLE_SPAWN_EVENT_WAVE_TYPE1, TABLE_SPAWN_EVENT_WAVE_COUNT1);
  get_type_data(get_available_type_data(level.cycle_data.current_spawn_event_wave_types), cycle, TABLE_SPAWN_EVENT_WAVE_TYPE2, TABLE_SPAWN_EVENT_WAVE_COUNT2);
  get_type_data(get_available_type_data(level.cycle_data.current_spawn_event_wave_types), cycle, TABLE_SPAWN_EVENT_WAVE_TYPE3, TABLE_SPAWN_EVENT_WAVE_COUNT3);
  get_type_data(get_available_type_data(level.cycle_data.current_spawn_event_wave_types), cycle, TABLE_SPAWN_EVENT_WAVE_TYPE4, TABLE_SPAWN_EVENT_WAVE_COUNT4);
  get_type_data(get_available_type_data(level.cycle_data.current_spawn_event_wave_types), cycle, TABLE_SPAWN_EVENT_WAVE_TYPE5, TABLE_SPAWN_EVENT_WAVE_COUNT5);

  level.cycle_data.current_spawn_event_wave_types = sort_array(level.cycle_data.current_spawn_event_wave_types, ::sort_priority_levels_func);

  return level.cycle_data.current_spawn_event_wave_types;
}

monitor_debug_dvar() {
  SetDevDvarIfUninitialized("debug_spawn_director", 0);
  SetDevDvarIfUninitialized("spawn_director_timed_wave_test", 1);
  SetDevDvarIfUninitialized("scr_alienwavedebug", "-1 0.0");
  SetDevDvarIfUninitialized("scr_alienspawninfo", 0);
  SetDevDvarIfUninitialized("scr_alienspawneventinfo", 0);

  level.debug_spawn_director_active = false;
  level.debug_spawn_director_spawn_index = 0;
  level.debug_spawn_director_spawn_list = [];

  level.spawn_director_debug_queue = [];
  level thread debug_queue_monitor();

  while(true) {
    waveDebugValues = strtok(GetDvar("scr_alienwavedebug", "-1 0.0"), " ");
    AssertEx(waveDebugValues.size == 2, "Invalid entry for scr_alienwavedebug dvar! Should be integer value for cycle number, and float value (0.0 - 1.0) for intensity level. ( scr_alienwavedebug \"4 0.5\" )");
    waveDebugCycle = int(waveDebugValues[0]) - 1;
    if(waveDebugCycle >= 0) {
      AssertEx(waveDebugCycle < level.cycle_data.spawn_cycles.size, "Invalid cycle entry! Should be between 1 and " + level.cycle_data.spawn_cycles.size);
      if(alien_mode_has("nogame")) {
        level.current_cycle = level.cycle_data.spawn_cycles[waveDebugCycle];
        level.current_intensity = float(waveDebugValues[1]) / (level.current_cycle.fullIntensityTime * 0.001);
        level.current_intensity_level = calculate_current_intensity_level();
        level.pending_meteor_spawns = 0;
        level.pending_ground_spawns = 0;
        level.pending_custom_spawns = 0;
        level thread monitor_meteor_spawn();
        level thread monitor_ground_spawn();
        types = get_current_wave_ai_types();
        spawn_wave(types, "debug spawn");
      } else {
        AssertMsg("Can't activate scr_alienwavedebug unless nogame mode is active!");
      }
      SetDevDvar("scr_alienwavedebug", "-1 0.0");
    }

    if(!level.debug_spawn_director_active && GetDvarInt("debug_spawn_director", 0) > 0) {
      level.debug_spawn_director_active = true;
      level notify("debug_mode_activated");
      level thread debug_respawn_monitor();

      if(isDefined(level.current_cycle)) {
        agents = maps\mp\agents\_agent_utility::getActiveAgentsOfType("alien");
        foreach(ai in agents) {
          ai Suicide();
        }
      }
    }

    if(level.debug_spawn_director_active && GetDvarInt("debug_spawn_director", 0) <= 0) {
      level notify("debug_mode_deactivated");
      level.debug_spawn_director_active = false;
      level.debug_spawn_director_spawn_index = 0;

      foreach(killAI in level.debug_spawn_director_spawn_list) {
        killAI Suicide();
      }
    }

    wait 0.05;
  }
}

print_cycle_rewards() {
  println("Cycle Rewards: ");

  foreach(index, cycle in level.cycle_data.spawn_cycles) {
    total_min = 0;
    total_max = 0;
    foreach(intensitylevel in cycle.intensitylevels) {
      aiTypes = get_types_array(intensitylevel.tableIndex);
      foreach(ai_type in aiTypes) {
        amount = level.alien_types[ai_type.type_name].attributes["reward"] * 2.0;
        total_min += amount * ai_type.min_spawned;

        if(isDefined(ai_type.max_spawned))
          total_max += amount * ai_type.max_spawned;
      }
    }

    foreach(spawn_event in cycle.spawn_events) {
      foreach(wave in spawn_event.waves) {
        foreach(ai_type in wave.types) {
          amount = level.alien_types[ai_type.type_name].attributes["reward"] * 2.0;
          total_min += amount * ai_type.min_spawned;

          if(isDefined(ai_type.max_spawned))
            total_max += amount * ai_type.max_spawned;
        }
      }
    }
    println(" Cycle " + index + ": " + total_min + " (Min), " + total_max + " (Max)");

  }
}

set_intensity(intensity) {
  level.current_intensity = clamp(intensity, 0.0, 1.0);
}

force_intensity(force_on, intensity) {
  if(force_on)
    level.forced_current_intensity = clamp(intensity, 0.0, 1.0);
  else if(isDefined(level.forced_current_intensity))
    level.forced_current_intensity = undefined;
}

load_cycles_from_table(cycle_data) {
  cycle_data.spawn_cycles = [];

  start_index = 0;
  max_index = TABLE_CYCLE_DEF_INDEX;

  if(level.script == "mp_alien_last" && !is_chaos_mode()) {
    start_index = TABLE_1000_CYCLE_START_IDX;
    max_index = TABLE_1000_CYCLE_END_IDX;
  }

  for(entryIndex = start_index; entryIndex <= max_index; entryIndex++) {
    cycleName = get_cycle_by_index(entryIndex);
    if(cycleName == "") {
      break;
    }

    cycleIndex = int(cycleName) - 1;
    if(!isDefined(cycle_data.spawn_cycles[cycleIndex])) {
      cycle = spawnStruct();
      cycle.intensityLevels = [];
      cycle.spawn_events = [];
      cycle.lanes = [];
      cycle.type_max_counts = [];
      cycle_data.spawn_cycles[cycleIndex] = cycle;
    } else {
      cycle = cycle_data.spawn_cycles[cycleIndex];
    }

    newLevel = spawnStruct();
    newLevel.intensityThreshold = get_intensity_threshold_by_index(entryIndex);
    newLevel.tableIndex = entryIndex;

    cycle.intensityLevels[cycle.intensityLevels.size] = newLevel;
  }

  foreach(cycle in cycle_data.spawn_cycles) {
    cycle.intensityLevels = sort_array(cycle.intensityLevels, ::sort_intensity_levels_func);

    if(cycle.intensityLevels.size > 0) {
      fullIntensityTime = cycle.intensityLevels[cycle.intensityLevels.size - 1].intensityThreshold;
      foreach(intensityLevel in cycle.intensityLevels) {
        if(fullIntensityTime <= 0.0) {
          intensityLevel.intensityThreshold = 0.0;
        } else {
          intensityLevel.intensityThreshold = intensityLevel.intensityThreshold / fullIntensityTime;
        }
      }
      cycle.fullIntensityTime = fullIntensityTime * 1000.0;
    }
  }

}

sort_array(array, sort_func, beginning_index, pass_through_parameter_list) {
  if(!isDefined(beginning_index))
    beginning_index = 0;

  for(i = beginning_index + 1; i < array.size; i++) {
    entry = array[i];

    for(j = i - 1; j >= beginning_index && [
        [sort_func]
      ](array[j], entry, pass_through_parameter_list); j--)
      array[j + 1] = array[j];

    array[j + 1] = entry;
  }

  return array;
}

sort_intensity_levels_func(test_entry, base_entry, pass_through_parameter_list) {
  /#Assert( isDefined( test_entry.intensityThreshold ) && isDefined( base_entry.intensityThreshold ) );
  return test_entry.intensityThreshold > base_entry.intensityThreshold;
}

sort_encounter_level_activation_time_func(test_entry, base_entry, pass_through_parameter_list) {
  /#Assert( isDefined( test_entry.activation_time ) && isDefined( base_entry.activation_time ) );

  return test_entry.activation_time > base_entry.activation_time;
}

sort_priority_levels_func(test_entry, base_entry, pass_through_parameter_list) {
  if(!isDefined(base_entry.type_name))
    return false;

  if(!isDefined(test_entry.type_name))
    return true;

  testTypeName = get_translated_ai_type(test_entry.type_name);
  baseTypeName = get_translated_ai_type(base_entry.type_name);

  testPriorityLevel = level.alien_types[testTypeName].attributes["attacker_priority"];
  basePriorityLevel = level.alien_types[baseTypeName].attributes["attacker_priority"];
  return testPriorityLevel > basePriorityLevel;
}

sort_closest_distance_to_players_func(test_entry, base_entry, pass_through_parameter_list) {
  testDistance = get_average_distance_to_players(test_entry["location"].origin);
  baseDistance = get_average_distance_to_players(base_entry["location"].origin);

  return testDistance > baseDistance;
}

sort_player_view_direction_func(test_entry, base_entry, pass_through_parameter_list) {
  player_pos = pass_through_parameter_list[0];
  player_view_dir = pass_through_parameter_list[1];

  player_to_base_dot = get_player_to_node_dot(player_pos, player_view_dir, base_entry["location"]);
  player_to_test_dot = get_player_to_node_dot(player_pos, player_view_dir, test_entry["location"]);

  return player_to_test_dot < player_to_base_dot;
}

get_player_to_node_dot(player_pos, player_view_dir, node) {
  player_to_node = vectorNormalize(node.origin - player_pos);
  return vectorDot(player_to_node, player_view_dir);
}

get_average_distance_to_players(location) {
  playerCount = level.players.size;

  if(playerCount == 0)
    return 0;

  totalDistanceSq = 0;
  foreach(player in level.players) {
    totalDistanceSq += DistanceSquared(player.origin, location);
  }

  return totalDistanceSq / playerCount;
}

debug_print(debug_string) {
  level.spawn_director_debug_queue[level.spawn_director_debug_queue.size] = debug_string;
}

debug_queue_monitor() {
  DEBUG_INTERVAL = 2.0;
  nextValidPrintTime = GetTime() - DEBUG_INTERVAL;

  while(true) {
    currentTime = GetTime();

    if(level.spawn_director_debug_queue.size > 0) {
      IPrintLnBold(level.spawn_director_debug_queue[0]);
      level.spawn_director_debug_queue = array_remove(level.spawn_director_debug_queue, level.spawn_director_debug_queue[0]);
      wait DEBUG_INTERVAL;
    } else {
      wait 0.2;
    }
  }
}

build_spawn_zones(cycle_data) {
  spawnLocations = getstructarray("alien_spawn_struct", "targetname");
  spawnZones = getEntArray("spawn_zone", "targetname");

  cycle_data.spawn_zones = [];

  foreach(zone in spawnZones) {
    /# AssertEx( !spawn_zone_exists( zone.script_linkName, cycle_data ), "Spawn zone with script_linkName of " + zone.script_linkName + " defined multiple times!" );

    zoneInfo = spawnStruct();
    zoneInfo.zone_name = zone.script_linkName;
    zoneInfo.volume = zone;
    zoneInfo.spawn_nodes = [];
    cycle_data.spawn_zones[zone.script_linkName] = zoneInfo;
  }

  cycle_data.spawner_list = [];

  put_spawnLocations_into_cycle_data(spawnLocations, cycle_data);

  foreach(zone in cycle_data.spawn_zones) {
    AssertEx(zone.spawn_nodes.size > 0, "Spawn zone " + zone.zone_name + " does not have any linked spawners!");
  }

}

put_spawnLocations_into_cycle_data(spawnLocations, cycle_data) {
  foreach(location in spawnLocations) {
    validTypes = [];

    if(isDefined(level.adjust_spawnLocation_func))
      location = [
        [level.adjust_spawnLocation_func]
      ](location);

    if(isDefined(location.script_noteworthy))
      validTypes = strtok(cycle_data.spawn_node_info[location.script_noteworthy].validType, " ");

    locationInfo = [];
    locationInfo["types"] = validTypes;
    locationInfo["location"] = location;

    cycle_data.spawner_list[cycle_data.spawner_list.size] = locationInfo;
    if(!isDefined(location.script_linkTo)) {
      continue;
    }
    linkedZones = location get_links();
    foreach(zone in linkedZones) {
      /#assertex( isDefined( cycle_data.spawn_zones[zone] ), "Invalid linked spawn zone: " + zone );
      locationIndex = cycle_data.spawn_zones[zone].spawn_nodes.size;
      cycle_data.spawn_zones[zone].spawn_nodes[locationIndex] = locationInfo;
    }
  }
}

spawn_zone_exists(zone_name, cycle_data) {
  foreach(index, zone in cycle_data.spawn_zones) {
    if(index == zone_name)
      return true;
  }

  return false;
}

can_spawn_type(ai_type) {
  if(!isDefined(level.current_cycle) || !isDefined(level.current_cycle.type_max_counts[ai_type]))
    return ((get_max_alien_count() - get_current_agent_count()) > 0);

  return (level.current_cycle.type_max_counts[ai_type] - get_current_agent_count_of_type(ai_type) > 0);
}

reserve_custom_spawn_space(space_size, allow_partial_space, reserve_type) {
  if(!isDefined(allow_partial_space))
    allow_partial_space = false;

  currentCount = get_current_agent_count();

  if(allow_partial_space) {
    if(isDefined(reserve_type) && isDefined(level.current_cycle) && isDefined(level.current_cycle.type_max_counts[reserve_type]))
      space_size = Clamp(level.current_cycle.type_max_counts[reserve_type] - get_current_agent_count_of_type(reserve_type), 0, space_size);

    availableSpace = clamp(get_max_alien_count() - currentCount, 0, space_size);
  } else if(currentCount + space_size <= get_max_alien_count()) {
    availableSpace = space_size;
  } else {
    availableSpace = 0;
  }

  level.pending_custom_spawns += availableSpace;

  return availableSpace;
}

process_custom_spawn(alien_type, spawn_point, intro_anim) {
  currentSpawned = get_current_agent_count(true, false, true);
  if(currentSpawned >= get_max_alien_count()) {
    AssertMsg("Unable to process custom spawn. Already at max spawn count! Make sure to reserve needed space.");
    alien = undefined;
  } else {
    alien = process_spawn(alien_type, spawn_point, intro_anim);
  }

  level.pending_custom_spawns = Max(0, level.pending_custom_spawns - 1);

  return alien;
}

release_custom_spawn_space(space_size) {
  level.pending_custom_spawns = Max(0, level.pending_custom_spawns - space_size);
}

get_cycle_by_index(index) {
  return tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_CYCLE);
}

get_intensity_level_by_index(index) {
  return tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_INTENSITY);
}

get_respawn_threshold_by_index(index) {
  respawnThreshold = tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_RESPAWN_THRESHOLD);

  if(respawnThreshold == "" || respawnThreshold == " ")
    return undefined;

  return int(respawnThreshold);
}

get_respawn_delay_by_index(index) {
  respawnDelay = tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_RESPAWN_DELAY);

  if(respawnDelay == "" || respawnDelay == " ")
    return undefined;

  return float(respawnDelay);
}

get_intensity_threshold_by_index(index) {
  return float(tablelookup(level.alien_cycle_table, TABLE_INDEX, index, TABLE_INTENSITY_THRESHOLD));
}

get_types_array(cycle) {
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES1, TABLE_COUNT1);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES2, TABLE_COUNT2);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES3, TABLE_COUNT3);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES4, TABLE_COUNT4);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES5, TABLE_COUNT5);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES6, TABLE_COUNT6);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES7, TABLE_COUNT7);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES8, TABLE_COUNT8);
  get_type_data(get_available_type_data(level.cycle_data.current_wave_types), cycle, TABLE_TYPES9, TABLE_COUNT9);

  level.cycle_data.current_wave_types = sort_array(level.cycle_data.current_wave_types, ::sort_priority_levels_func);
}

get_available_type_data(type_data_array) {
  for(typeIndex = 0; typeIndex < type_data_array.size; typeIndex++) {
    if(!isDefined(type_data_array[typeIndex].type_name))
      return type_data_array[typeIndex];
  }

  return undefined;
}

get_type_data(type_data, row_index, table_ai_type, table_count_type) {
  if(!isDefined(type_data))
    return undefined;

  typeName = tablelookup(level.alien_cycle_table, TABLE_INDEX, row_index, table_ai_type);

  if(typeName == "")
    return undefined;

  typeRange = strTok(tablelookup(level.alien_cycle_table, TABLE_INDEX, row_index, table_count_type), " ");
  assertex(typeRange.size > 0 && typeRange.size <= 3, typeName + " doesn't have valid spawn range in index " + (row_index + 1));

  type_data.type_name = typeName;
  typeRange[0] = int(typeRange[0]);
  typeRange[1] = int(typeRange[1]);

  if(typeRange.size == 0) {
    type_data.min_spawned = 0;
  } else if(typeRange.size == 1) {
    type_data.min_spawned = typeRange[0];
  } else {
    if(typeRange[0] < typeRange[1]) {
      type_data.min_spawned = typeRange[0];
      type_data.max_spawned = typeRange[1];
    } else if(typeRange[1] > typeRange[0]) {
      type_data.min_spawned = typeRange[1];
      type_data.max_spawned = typeRange[0];
    } else {
      type_data.min_spawned = typeRange[0];
    }

    if(typeRange.size == 3)
      type_data.max_of_type = int(typeRange[2]);
  }

  return type_data;
}

remove_spawn_location(spawner) {
  foreach(spawnZone in level.cycle_data.spawn_zones) {
    for(nodeIndex = 0; nodeIndex < spawnZone.spawn_nodes.size; nodeIndex++) {
      location = spawnZone.spawn_nodes[nodeIndex]["location"];
      if(!isDefined(location.script_linkName)) {
        continue;
      }
      if(location.script_linkName == spawner) {
        spawnZone.spawn_nodes = array_remove_index(spawnZone.spawn_nodes, nodeIndex);
        break;
      }
    }
  }
}

start_cycle(cycle_num) {
  AssertEx(cycle_num > 0 && cycle_num <= level.cycle_data.spawn_cycles.size, cycle_num + " is invalid cycle number");
  set_cycle_scalars(cycle_num);

  level.cycle_spawning_active = true;
  level thread spawn_director_loop(cycle_num - 1);
  level notify("alien_cycle_started");
}

end_cycle() {
  level notify("end_cycle");

  level.cycle_spawning_active = false;
  level notify("alien_cycle_ended");
}

pause_cycle(time_to_pause) {
  if(!level.cycle_spawning_active) {
    return;
  }
  level thread pause_cycle_internal(time_to_pause);
}

pause_cycle_internal(time_to_pause) {
  level.intensity_spawning_paused_count++;
  wait time_to_pause;
  level.intensity_spawning_paused_count = int(Max(0, level.intensity_spawning_paused_count - 1));
}

activate_spawn_event(event_notify, wait_for_completion) {
  if(!isDefined(wait_for_completion))
    wait_for_completion = false;

  spawnEvent = find_spawn_event(event_notify);

  if(!isDefined(spawnEvent)) {
    if(isDefined(level.current_cycle_num))
      outputCycleNum = level.current_cycle_num + 1;
    else
      outputCycleNum = 0;

    AssertMsg(event_notify + " is not a valid notify for cycle " + outputCycleNum + " and is not in the generic spawn events");
    return;
  }

  if(wait_for_completion)
    level run_spawn_event(spawnEvent, event_notify);
  else
    level thread run_spawn_event(spawnEvent, event_notify);
}

find_spawn_event(event_notify) {
  if(isDefined(level.current_cycle)) {
    foreach(spawnEvent in level.current_cycle.spawn_events) {
      if(spawnEvent.activation_notify == event_notify)
        return spawnEvent;
    }
  }

  foreach(spawnEvent in level.cycle_data.generic_spawn_events) {
    if(spawnEvent.activation_notify == event_notify)
      return spawnEvent;
  }

  return undefined;
}

wait_for_spawn_event_delay() {
  while(level.pending_meteor_spawns > 0 || level.pending_ground_spawns > 0)
    wait 0.05;

  timeToWait = level.cycle_data.spawn_event_min_activation_time + level.cycle_data.spawn_event_per_alien_activation_increase * get_current_agent_count();
  timeToWait = Min(level.cycle_data.spawn_event_max_activation_increase, timeToWait);

  if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
    debug_print("Initial Event Delay: " + timeToWait + ", Aliens alive: " + get_current_agent_count());
  }

  wait timeToWait;
}

run_spawn_event(spawn_event, event_notify) {
  level endon("end_cycle");
  level endon("nuke_went_off");
  level endon("game_ended");

  if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
    debug_print("Spawn Event Activated: " + event_notify + ", ID: " + spawn_event.id);
    debug_print("Time Limit: " + spawn_event.time_limit + ", Number of waves: " + spawn_event.waves.size);
  }

  if(level.cycle_spawning_active)
    level.intensity_spawning_paused_count++;

  if(spawn_event.allow_initial_delay)
    wait_for_spawn_event_delay();

  level thread spawn_event_time_limit_monitor(spawn_event.time_limit, spawn_event.activation_notify);
  level thread process_spawn_event_spawning(spawn_event);
  waittill_any("spawn_event_complete" + spawn_event.activation_notify, "spawn_event_time_limit_reached" + spawn_event.activation_notify);

  if(level.cycle_spawning_active) {
    level.intensity_spawning_paused_count = int(Max(0, level.intensity_spawning_paused_count - 1));
    AssertEx(level.intensity_spawning_paused_count >= 0, "Spawning pause count below zero! Tell a programmer!");
  }
}

process_spawn_event_spawning(spawn_event) {
  allEventSpawnedAliens = [];

  randomSpawnEvent = RandomInt(spawn_event.id.size);
  eventIndex = spawn_event.id[randomSpawnEvent];

  level.override_lane_index = 0;

  foreach(wave in level.spawn_event_waves[eventIndex]) {
    if(wave.spawn_delay > 0.0) {
      if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
        debug_print("Spawn event wave delay for " + wave.spawn_delay + " seconds.");
      }

      wait wave.spawn_delay;
    }

    if(isDefined(spawn_event.lanes))
      lanes = spawn_event.lanes;
    else
      lanes = undefined;

    wave.types = get_spawn_event_types_array(wave.entry_index);

    if(wave_has_delayed_spawn_type(wave))
      spawnedAliens = spawn_event_delayed_wave_spawn(wave, spawn_event.activation_notify, lanes);
    else
      spawnedAliens = spawn_event_wave_spawn(wave, spawn_event.activation_notify, lanes);

    allEventSpawnedAliens = array_combine(allEventSpawnedAliens, spawnedAliens);
  }

  wait_for_all_aliens_killed(allEventSpawnedAliens, spawn_event.activation_notify);
  level notify("spawn_event_complete" + spawn_event.activation_notify);
}

wave_has_delayed_spawn_type(wave) {
  if(wave_has_type(wave, "minion"))
    return true;

  if(wave_has_type(wave, "elite"))
    return true;

  return false;
}

wave_has_type(wave, ai_type) {
  foreach(alienType in wave.types) {
    if(!isDefined(alienType.type_name)) {
      continue;
    }
    if(alienType.type_name == ai_type)
      return true;
  }

  return false;
}

spawn_event_wave_spawn(wave, activation_notify, lanes) {
  spawnedAliens = spawn_wave(wave.types, "event", lanes);

  if(wave.blocking)
    spawn_event_wave_block(spawnedAliens, activation_notify);

  return spawnedAliens;
}

spawn_event_wave_block(spawnedAliens, activation_notify) {
  if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
    debug_print("Spawn event wave blocking");
  }

  wait_for_all_aliens_killed(spawnedAliens, activation_notify);

  if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
    debug_print("Spawn event wave finished blocking");
  }

}

spawn_event_delayed_wave_spawn(wave, activation_notify, lanes) {
  spawnedAliens = spawn_wave(wave.types, "event", lanes);

  if(level.pending_meteor_spawns > 0)
    level thread spawn_event_minion_wave_spawn();
  if(level.pending_ground_spawns > 0)
    level thread spawn_event_elite_wave_spawn();

  while(level.pending_meteor_spawns > 0 || level.pending_ground_spawns > 0) {
    level waittill("spawn_event_delayed_spawn_complete", aliens);
    spawnedAliens = array_combine(spawnedAliens, aliens);
    wait 0.05;
  }

  if(wave.blocking)
    spawn_event_wave_block(spawnedAliens, activation_notify);

  return spawnedAliens;
}

spawn_event_minion_wave_spawn() {
  spawnedAliens = [];

  while(level.pending_meteor_spawns > 0) {
    level waittill("meteor_aliens_spawned", aliens, requestedCount);
    spawnedAliens = array_combine(spawnedAliens, aliens);
    wait 0.05;
  }

  level notify("spawn_event_delayed_spawn_complete", spawnedAliens);
}

spawn_event_elite_wave_spawn() {
  spawnedAliens = [];

  while(level.pending_ground_spawns > 0) {
    level waittill("ground_alien_spawned", alien);
    spawnedAliens[spawnedAliens.size] = alien;
    wait 0.05;
  }

  level notify("spawn_event_delayed_spawn_complete", spawnedAliens);
}

spawn_event_time_limit_monitor(time_limit, activation_notify) {
  level endon("spawn_event_complete" + activation_notify);

  wait time_limit;

  if(GetDvarInt("scr_alienspawneventinfo", 0) == 1) {
    debug_print("Spawn Event Timed Out: " + activation_notify + ", Time: " + time_limit);
  }

  level notify("spawn_event_time_limit_reached" + activation_notify);
}

wait_for_all_aliens_killed(aliens, activation_notify) {
  level endon("spawn_event_complete" + activation_notify);

  while(true) {
    wait 0.05;

    anyAliveAliens = false;
    foreach(alien in aliens) {
      if(IsAlive(alien)) {
        anyAliveAliens = true;
        break;
      }
    }

    if(!anyAliveAliens) {
      break;
    }
  }
}

create_wave_types_array() {
  MAX_NUM_TYPES = 9;
  waveTypes = [];

  for(typeIndex = 0; typeIndex < MAX_NUM_TYPES; typeIndex++) {
    waveType = spawnStruct();
    waveType.type_name = undefined;
    waveTypes[waveTypes.size] = waveType;
  }

  return waveTypes;
}

spawn_director_loop(cycle_num) {
  level endon("end_cycle");
  level endon("nuke_went_off");
  level endon("game_ended");

  level.spawn_node_traces_this_frame = 0;
  level.spawn_node_traces_frame_time = GetTime();
  level.intensity_spawning_paused_count = 0;

  level.current_cycle_num = cycle_num;
  level.current_cycle = level.cycle_data.spawn_cycles[cycle_num];
  cycle_begin_intensity_monitor();
  level.pending_meteor_spawns = 0;
  level.pending_ground_spawns = 0;

  activate_current_lane_monitor();

  if(!isDefined(level.debug_spawn_director_active) || !level.debug_spawn_director_active)
    initial_spawn();

  while(true) {
    while(level.debug_spawn_director_active)
      wait 0.05;

    respawnActive = respawn_threshold_monitor();

    if(level.debug_spawn_director_active) {
      continue;
    }
    respawn(respawnActive);
  }
}

activate_current_lane_monitor() {
  if(is_chaos_mode()) {
    return;
  }
  level thread current_lane_monitor();
}

INTENSITY_MONITOR_FREQUENCY = 0.1;

cycle_begin_intensity_monitor() {
  level.current_intensity_level = -1;
  level.current_intensity = 0.0;

  level thread intensity_monitor_update_loop();
}

intensity_monitor_update_loop() {
  level endon("end_cycle");
  level endon("nuke_went_off");
  level endon("game_ended");

  last_intensity_update_time = GetTime();

  while(true) {
    currentTime = GetTime();

    if(level.intensity_spawning_paused_count == 0) {
      if(isDefined(level.forced_current_intensity)) {
        level.current_intensity = level.forced_current_intensity;
      } else if(level.current_cycle.fullIntensityTime == 0.0) {
        level.current_intensity = 1.0;
      } else {
        intensityIncrease = (currentTime - last_intensity_update_time) / level.current_cycle.fullIntensityTime;
        level.current_intensity = clamp(level.current_intensity + intensityIncrease, 0.0, 1.0);
      }

      last_intensity_update_time = currentTime;
      intensityLevel = calculate_current_intensity_level();

      if(level.current_intensity_level != intensityLevel)
        level notify("intensity_level_changed");

      level.current_intensity_level = intensityLevel;

    } else {
      last_intensity_update_time = currentTime;
    }

    wait INTENSITY_MONITOR_FREQUENCY;
  }
}

current_lane_monitor() {
  level endon("end_cycle");
  level endon("nuke_went_off");
  level endon("game_ended");
  level.cycle_data.current_lane = undefined;

  currentEncounter = get_current_encounter();

  while(!isDefined(currentEncounter)) {
    wait 0.2;
    currentEncounter = get_current_encounter();
  }

  if(!isDefined(level.encounter_lanes[currentEncounter]) || level.encounter_lanes[currentEncounter].size == 0) {
    return;
  }
  while(true) {
    endIndex = undefined;
    foreach(index, lane in level.encounter_lanes[currentEncounter]) {
      laneIntensityThreshold = lane.activation_time / level.current_cycle.fullIntensityTime;
      if(laneIntensityThreshold > level.current_intensity) {
        break;
      }

      endIndex = index;
    }

    if(isDefined(endIndex)) {
      currentLane = level.encounter_lanes[currentEncounter][endIndex];

      if(!isDefined(level.cycle_data.current_lane) || currentLane != level.cycle_data.current_lane) {
        level.cycle_data.current_lane = currentLane;
        play_lane_change_sound();
      }
    }

    wait 0.5;
  }
}

play_lane_change_sound() {
  laneIndex = get_random_entry(level.cycle_data.current_lane.lanes);
  spawnIndex = level.lanes[laneIndex][RandomInt(level.lanes[laneIndex].size)];
  audioLocation = level.cycle_data.spawner_list[spawnIndex]["location"].origin;
  playSoundAtPos(audioLocation, LANE_CHANGE_SPAWN_SOUND);
}

calculate_current_intensity_level() {
  for(intensityIndex = 0; intensityIndex < level.current_cycle.intensityLevels.size; intensityIndex++) {
    if(level.current_cycle.intensityLevels[intensityIndex].intensityThreshold > level.current_intensity) {
      break;
    }
  }

  return intensityIndex - 1;
}

initial_spawn() {
  while(level.current_intensity_level < 0)
    wait 0.05;

  types = get_current_wave_ai_types();
  spawn_wave(types, "spawn");
}

get_current_wave_ai_types() {
  foreach(waveType in level.cycle_data.current_wave_types) {
    waveType.type_name = undefined;
    waveType.max_of_type = undefined;
    waveType.min_spawned = undefined;
    waveType.max_spawned = undefined;
  }

  tableIndex = level.current_cycle.intensityLevels[level.current_intensity_level].tableIndex;

  get_types_array(tableIndex);
  level.cycle_data.current_respawn_threshold = get_respawn_threshold_by_index(tableIndex);
  level.cycle_data.current_respawn_delay = get_respawn_delay_by_index(tableIndex);

  return level.cycle_data.current_wave_types;
}

respawn(respawnActive) {
  if(isDefined(respawnActive) && respawnActive) {
    types = level.cycle_data.current_wave_types;
    spawnMethod = "respawn";
  } else {
    types = get_current_wave_ai_types();
    spawnMethod = "spawn";
  }
  spawn_wave(types, spawnMethod);
}

spawn_wave(types, spawn_method, override_lanes) {
  spawnedAliens = [];

  for(typesIndex = 0; typesIndex < types.size; typesIndex++) {
    if(isDefined(types[typesIndex].type_name))
      spawnedAliens = array_combine(spawn_type(types[typesIndex], spawn_method, override_lanes), spawnedAliens);
  }

  return spawnedAliens;
}

debug_respawn_monitor() {
  level endon("debug_mode_deactivated");

  level.debug_spawn_director_spawn_list = [];

  while(true) {
    while(!isDefined(level.current_intensity_level) || level.current_intensity_level < 0)
      wait 0.05;

    desiredTotalAI = GetDvarInt("debug_spawn_director", 0);
    currentlyAlive = [];
    foreach(testAI in level.debug_spawn_director_spawn_list) {
      if(IsAlive(testAi))
        currentlyAlive[currentlyAlive.size] = testAI;
    }
    level.debug_spawn_director_spawn_list = currentlyAlive;

    for(spawnIndex = level.debug_spawn_director_spawn_list.size; spawnIndex < desiredTotalAI; spawnIndex++) {
      alien = spawn_alien(get_random_type_from_current_intensity());

      listIndex = level.debug_spawn_director_spawn_list.size;
      level.debug_spawn_director_spawn_list[listIndex] = alien;
      wait level.cycle_data.min_spawn_interval;
    }

    wait 0.05;
  }
}

get_random_type_from_current_intensity() {
  aiTypes = get_current_wave_ai_types();
  randomTypeIndex = RandomInt(aiTypes.size);

  return aiTypes[randomTypeIndex].type_name;
}

respawn_threshold_monitor() {
  level endon("end cycle");
  level endon("intensity_level_changed");
  /#level endon( "debug_mode_activated" );

  while(true) {
    if(level.current_intensity_level >= 0 && level.intensity_spawning_paused_count == 0) {
      if(isDefined(level.cycle_data.current_respawn_threshold) && level.cycle_data.current_respawn_threshold >= 0) {
        currentAITotal = get_current_agent_count();
        respawnThreshold = get_scaled_alien_amount(level.cycle_data.current_respawn_threshold);

        if(currentAITotal <= respawnThreshold) {
          break;
        }
      }
    }

    wait 0.1;
  }

  if(isDefined(level.cycle_data.current_respawn_delay)) {
    if(level.current_intensity_level >= 0 && level.cycle_data.current_respawn_delay >= 0)
      wait level.cycle_data.current_respawn_delay * get_current_spawn_count_multiplier();
  }

  return true;
}

get_current_spawn_count_multiplier() {
  multiplier = level.base_player_count_multiplier + (level.additional_player_count_multiplier * (level.players.size - 1));
  if(is_hardcore_mode()) {
    multiplier *= level.hardcore_spawn_multiplier;
  }

  return multiplier;
}

spawn_type_vo_monitor() {
  level endon("game_ended");
  level endon("nuke_went_off");

  currentTime = GetTime();
  nextValidSpitterVOTime = currentTime;
  nextValidQueenVOTime = currentTime;

  spitterVOInterval = 40000;
  queenVOInterval = 30000;

  while(true) {
    level waittill("spawned_alien", alien);

    if(!isDefined(alien.alien_type)) {
      continue;
    }
    if(flag_exist("escape_conditions_met") && flag("escape_conditions_met")) {
      return;
    }
    switch (alien.alien_type) {
      case "spitter":
        currentTime = GetTime();
        if(currentTime >= nextValidSpitterVOTime) {
          level thread maps\mp\alien\_music_and_dialog::playVOForSpitterspawn(alien);
          nextValidSpitterVOTime = currentTime + spitterVOInterval;
        }
        break;

      case "elite":
        currentTime = GetTime();
        if(currentTime >= nextValidQueenVOTime) {
          level thread maps\mp\alien\_music_and_dialog::playVOForQueenspawn(alien);
          nextValidQueenVOTime = currentTime + queenVOInterval;
        }
        break;
      case "seeder":
        level notify("dlc_vo_notify", "inbound_seeder", alien);
        break;

      case "brute":
        level notify("dlc_vo_notify", "inbound_brute", alien);
        break;

      case "mammoth":
        level notify("dlc_vo_notify", "inbound_mammoth", alien);
        break;

      case "gargoyle":
        level notify("dlc_vo_notify", "inbound_gargoyle", alien);
        break;

      case "bomber":
        level notify("dlc_vo_notify", "inbound_bomber", alien);
        break;

      default:
        break;
    }
  }
}

debug_spawn_info(spawn_time, spawn_method, requested_amount, modified_amount, spawn_type, actual_amount) {
  if(isDefined(spawn_method))
    spawnTypeDebug = spawn_method + "=";
  else
    spawnTypeDebug = "Spawn=";

  msg = spawnTypeDebug + requested_amount + " " + spawn_type + " Modify=" + modified_amount;
  if(isDefined(spawn_time))
    msg = msg + " Time=" + spawn_time;

  if(isDefined(actual_amount))
    msg = msg + " Spawned=" + actual_amount;

  totalSpawned = get_current_agent_count() - level.pending_meteor_spawns - level.pending_ground_spawns - level.pending_custom_spawns;
  msg = msg + " Total=" + totalSpawned;

  debug_print(msg);
}

get_scaled_alien_amount(desired_amount) {
  scaledAmount = desired_amount * get_current_spawn_count_multiplier();

  return max(1, int(scaledAmount + 0.5));
}

get_modified_alien_amount(desired_amount, ai_type, spawn_method) {
  scaledAmount = get_scaled_alien_amount(desired_amount);

  return get_max_type_count(ai_type, scaledAmount);
}

spawn_type(ai_type, spawn_method, override_lanes) {
  if(!isDefined(ai_type.max_spawned))
    desiredSpawnAmount = ai_type.min_spawned;
  else
    desiredSpawnAmount = RandomIntRange(ai_type.min_spawned, ai_type.max_spawned);
  modifiedDesiredSpawnAmount = get_modified_alien_amount(desiredSpawnAmount, ai_type, spawn_method);

  spawnedAliens = [];

  if(!isDefined(level.cycle_data.current_lane) && !isDefined(level.cycle_data.non_lane_spawn_started)) {
    level thread maps\mp\alien\_music_and_dialog::play2DSpawnSound();
    level.cycle_data.non_lane_spawn_started = true;
  }

  switch (ai_type.type_name) {
    case "minion":
      spawn_minions(modifiedDesiredSpawnAmount);
      break;
    case "elite":
      spawn_elite(modifiedDesiredSpawnAmount);
      break;
    default:
      spawnedAliens = spawn_aliens(modifiedDesiredSpawnAmount, ai_type.type_name, override_lanes);
      break;
  }

  if(is_spawn_debug_info_requested()) {
    if(isDefined(level.current_cycle))
      spawnTime = int(level.current_intensity * level.current_cycle.fullIntensityTime * 0.001);
    else
      spawnTime = undefined;

    debug_spawn_info(spawnTime, spawn_method, desiredSpawnAmount, modifiedDesiredSpawnAmount, ai_type.type_name, spawnedAliens.size);
  }

  return spawnedAliens;
}

get_max_alien_count() {
  return level.cycle_data.max_alien_count;
}

get_max_type_count(ai_type, desiredAmount) {
  if(!isDefined(level.current_cycle))
    return desiredAmount;

  typeName = get_translated_ai_type(ai_type.type_name);

  if(isDefined(ai_type.max_of_type)) {
    if(ai_type.max_of_type <= 0)
      level.current_cycle.type_max_counts[typeName] = undefined;
    else
      level.current_cycle.type_max_counts[typeName] = ai_type.max_of_type;
  }

  if(!isDefined(level.current_cycle.type_max_counts[typeName]))
    return desiredAmount;

  currentAllowedCount = get_scaled_alien_amount(level.current_cycle.type_max_counts[typeName]);
  currentAllowedCount = Max(0, currentAllowedCount - get_current_agent_count_of_type(typeName));

  return Min(desiredAmount, currentAllowedCount);
}

at_max_alien_count() {
  return (get_current_agent_count() >= get_max_alien_count());
}

get_translated_ai_type(ai_type) {
  switch (ai_type) {
    case "minion_nometeor":
      return "minion";
  }

  return ai_type;
}

spawn_aliens(desired_amount, ai_type, override_lanes) {
  ai_type = get_translated_ai_type(ai_type);
  spawnedAliens = [];
  for(spawnIndex = 0; spawnIndex < desired_amount; spawnIndex++) {
    if(at_max_alien_count()) {
      if(is_spawn_debug_info_requested()) {
        numNotSpawned = desired_amount - spawnIndex;
        debug_print("Max alien count hit. " + numNotSpawned + " " + ai_type + " not spawned.");
      }

      break;
    }

    sort_func = undefined;

    if(is_chaos_mode())
      sort_func = ::sort_player_view_direction;

    alien = spawn_alien(ai_type, override_lanes, undefined, sort_func);

    spawnedAliens[spawnedAliens.size] = alien;

    wait level.cycle_data.min_spawn_interval;
  }

  return spawnedAliens;
}

spawn_minions(desired_amount) {
  level thread spawn_meteor_aliens(desired_amount, "minion");
  wait level.cycle_data.min_spawn_interval;
}

spawn_elite(desired_amount) {
  level thread spawn_ground_aliens(desired_amount, "elite", ::elite_monitor);
  wait level.cycle_data.min_spawn_interval;
}

elite_monitor() {
  if(!isDefined(level.cycle_data.elite_count) || level.cycle_data.elite_count == 0) {
    level thread maps\mp\alien\_music_and_dialog::handleFirstEliteArrival(self);
    level.cycle_data.elite_count = 1;
  } else {
    level.cycle_data.elite_count++;
  }

  self waittill("death");
  level.cycle_data.elite_count--;

  if(level.cycle_data.elite_count == 0)
    level thread maps\mp\alien\_music_and_dialog::handleLastEliteDeath(self);
}

is_spawn_debug_info_requested() {
  return GetDvarInt("scr_alienspawninfo", 0) == 1 || GetDvarInt("scr_alienspawneventinfo") == 1;
}

spawn_meteor_aliens(desired_spawn_amount, alien_type) {
  level endon("game_ended");
  level endon("nuke_went_off");

  if(desired_spawn_amount >= 9)
    alien_per_meteoroid = int(desired_spawn_amount / 3);
  else
    alien_per_meteoroid = 4;

  level.pending_meteor_spawns += desired_spawn_amount;

  while(desired_spawn_amount > 0) {
    count = alien_per_meteoroid;
    if(desired_spawn_amount < alien_per_meteoroid)
      count = desired_spawn_amount;

    earlyFail = level thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid(alien_type, count);
    if(isDefined(earlyFail)) {
      if(is_spawn_debug_info_requested()) {
        debug_print("Meteor creation failed! " + desired_spawn_amount + " minions not spawned!");
      }

      level.pending_meteor_spawns -= desired_spawn_amount;
      return;
    }

    desired_spawn_amount -= count;

    wait RandomIntRange(5, 10);
    level thread maps\mp\alien\_music_and_dialog::playVOForMinions();
  }
}

spawn_ground_aliens(desired_spawn_amount, alien_type, spawn_notify_func) {
  level endon("game_ended");
  level endon("nuke_went_off");

  MIN_INTERVAL = 2.0;
  MAX_INTERVAL = 3.5;

  while(desired_spawn_amount > 0) {
    earlyFail = level thread spawn_ground_alien(alien_type, 1, spawn_notify_func);
    if(isDefined(earlyFail)) {
      if(is_spawn_debug_info_requested()) {
        debug_print("Ground spawn point failed! " + desired_spawn_amount + " queens not spawned!");
      }

      return;
    }

    level.pending_ground_spawns++;
    desired_spawn_amount -= 1;

    wait RandomFloatRange(MIN_INTERVAL, MAX_INTERVAL);

  }
}

spawn_ground_alien(alien_type, spawn_count, spawn_notify_func) {
  GROUND_ALIEN_LAST_USED_DURATION = 10000;
  overrideLanes = [];

  alien = spawn_alien(alien_type, overrideLanes, GROUND_ALIEN_LAST_USED_DURATION, ::sort_closest_to_players);
  alien thread[[spawn_notify_func]]();

  level notify("ground_alien_spawned", alien);
}

monitor_meteor_spawn() {
  level endon("game_ended");
  level endon("nuke_went_off");

  while(true) {
    level waittill("meteor_aliens_spawned", aliens, requestedCount);

    if(is_spawn_debug_info_requested()) {
      totalSpawned = get_current_agent_count() - level.pending_meteor_spawns - level.pending_ground_spawns + aliens.size;
      debug_print(aliens.size + " minions spawned! " + totalSpawned + " alive aliens total.");
    }

    level.pending_meteor_spawns -= requestedCount;
    if(level.pending_meteor_spawns < 0)
      level.pending_meteor_spawns = 0;
  }
}

monitor_ground_spawn() {
  level endon("game_ended");
  level endon("nuke_went_off");

  while(true) {
    level waittill("ground_alien_spawned", alien);
    alienType = alien maps\mp\alien\_utility::get_alien_type();

    if(is_spawn_debug_info_requested()) {
      totalSpawned = get_current_agent_count() - level.pending_meteor_spawns - level.pending_ground_spawns + 1;
      debug_print(1 + " " + alienType + " spawned! " + totalSpawned + " alive aliens total.");
    }

    if(!IsAlive(alien)) {
      continue;
    }
    level.pending_ground_spawns--;
    if(level.pending_ground_spawns < 0)
      level.pending_ground_spawns = 0;
  }
}

get_current_agent_count(exclude_meteor, exclude_ground, exclude_pending) {
  currentCount = maps\mp\agents\_agent_utility::getNumActiveAgents();

  if(!isDefined(exclude_meteor) || !exclude_meteor)
    currentCount += level.pending_meteor_spawns;

  if(!isDefined(exclude_ground) || !exclude_ground)
    currentCount += level.pending_ground_spawns;

  if(!isDefined(exclude_pending) || !exclude_pending)
    currentCount += level.pending_custom_spawns;

  return currentCount;
}

get_current_agent_count_of_type(alien_type) {
  agents = maps\mp\agents\_agent_utility::getActiveAgentsOfType("alien");
  typeCount = 0;

  foreach(ai in agents) {
    if(isDefined(ai.pet) && ai.pet) {
      continue;
    }
    if(ai get_alien_type() == alien_type)
      typeCount++;
  }

  return typeCount;
}

spawn_alien(ai_type, override_lanes, override_last_time_used_duration, override_sort_func) {
  spawnPointInfo = find_safe_spawn_point_info(ai_type, override_lanes, override_last_time_used_duration, override_sort_func);
  spawnPoint = spawnPointInfo["node"];

  new_alien_to_attack_the_chopper = false;
  if(ai_type == "spitter" && isDefined(level.hive_heli) && level.hive_heli.health > 0 && ThreatBiasGroupExists("spitters")) {
    against_players = 0;
    against_chopper = 0;
    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive) || !agent.isActive || !isalive(agent) || !isDefined(agent.alien_type) || agent.alien_type != "spitter") {
        continue;
      }
      if(agent GetThreatBiasGroup() == "spitters")
        against_chopper++;
      else
        against_players++;
    }

    total = int(max(1, against_chopper + against_players));
    level.spitters_against_players_ratio = against_players / total;

    total_dist = 0;
    foreach(player in level.players)
    total_dist += distance2D(player.origin, level.hive_heli.origin);

    avg_dist = total_dist / int(min(1, level.players.size));

    chance = 0.32;
    if(avg_dist > 1500)
      chance = 0.1;

    if(level.spitters_against_players_ratio >= chance)
      new_alien_to_attack_the_chopper = true;
  }

  intro_vignette_ai_type = process_intro_vignette_ai_type(ai_type);

  if(isDefined(spawnPoint.script_noteworthy))
    introVignetteAnim = level.cycle_data.spawn_node_info[spawnPoint.script_noteworthy].vignetteInfo[intro_vignette_ai_type];
  else
    introVignetteAnim = undefined;

  alien = process_spawn(ai_type, spawnPoint, introVignetteAnim);

  if((ai_type == "spitter" || ai_type == "seeder") && isDefined(level.hive_heli) && level.hive_heli.health > 0 && ThreatBiasGroupExists("spitters")) {
    if(new_alien_to_attack_the_chopper)
      alien maps\mp\alien\_spawnlogic::make_spitter_attack_chopper(true);
    else
      alien maps\mp\alien\_spawnlogic::make_spitter_attack_chopper(false);
  }

  if((ai_type == "spitter" || ai_type == "seeder" || ai_type == "gargoyle") && flag_exist("player_using_vanguard") && flag("player_using_vanguard") && ThreatBiasGroupExists("spitters")) {
    alien SetThreatBiasGroup("spitters");
    alien.favoriteenemy = level.alien_vanguard;
  }

  if(isDefined(spawnPoint.script_noteworthy)) {
    if(IsSubStr(spawnPoint.script_noteworthy, "vent"))
      level notify("dlc_vo_notify", "direction_vo", "spawn_vent");
    if(IsSubStr(spawnPoint.script_noteworthy, "duct"))
      level notify("dlc_vo_notify", "direction_vo", "spawn_vent");
    if(IsSubStr(spawnPoint.script_noteworthy, "grate"))
      level notify("dlc_vo_notify", "direction_vo", "spawn_grate");
  }

  level notify("spawned_alien", alien);
  return alien;
}

process_intro_vignette_ai_type(ai_type) {
  switch (ai_type) {
    case "leper":
    case "locust":
      return "brute";

    case "mammoth":
      return "elite";
  }

  return ai_type;
}

process_spawn(spawn_type, spawn_point, intro_vignette_anim) {
  spawnAngles = (0, 0, 0);
  if(isDefined(spawn_point.angles))
    spawnAngles = spawn_point.angles;

  spawn_point.last_used_time = GetTime();

  spawnType = "wave" + " " + spawn_type;
  alien = maps\mp\gametypes\aliens::addAlienAgent("axis", spawn_point.origin, spawnAngles, spawnType, intro_vignette_anim);

  return alien;
}

find_safe_spawn_point_info(type_name, override_lanes, override_last_time_used_duration, override_sort_func) {
  if(should_lane_spawn(override_lanes, type_name))
    return find_lane_spawn_node(override_lanes);

  playerVolumes = get_current_player_volumes();

  if(playerVolumes.size == 0) {
    spawnLocationInfo = find_random_spawn_node(level.cycle_data.spawner_list, type_name, override_last_time_used_duration, ::filter_spawn_point_by_distance_from_player, undefined, override_sort_func);
    return spawnLocationInfo;
  } else if(playerVolumes.size == 1) {
    foreach(index, player in playerVolumes) {
      if(level.cycle_data.spawn_zones[index].spawn_nodes.size == 0) {
        continue;
      }
      spawnLocationInfo = find_random_spawn_node(level.cycle_data.spawn_zones[index].spawn_nodes, type_name, override_last_time_used_duration, undefined, undefined, override_sort_func);
      return spawnLocationInfo;
    }
  }

  return find_safe_spawn_spot_with_volumes(playerVolumes, type_name, override_last_time_used_duration, override_sort_func);
}

get_current_encounter() {
  return level.encounter_name;
}

should_lane_spawn(override_lanes, type_name) {
  OFFLINE_DRILL_MAX_AVERAGE_DISTANCE = 1024;

  if(is_chaos_mode())
    return false;

  if(isDefined(override_lanes) && override_lanes.size == 0)
    return false;

  if(!can_spawn_at_any_node(type_name))
    return false;

  if(isDefined(level.blocker_hive_active) && level.blocker_hive_active)
    return true;

  drillState = get_current_drill_state();

  if(!isDefined(override_lanes)) {
    if(!isDefined(level.cycle_data.current_lane))
      return false;

    if(drillState == "idle")
      return false;
  }

  if(drillState == "offline") {
    total_dist = 0;
    player_count = 0;
    foreach(player in level.players) {
      if(isDefined(player) && isalive(player)) {
        player_count++;
        total_dist += distance2D(player.origin, level.drill.origin);
      }
    }

    if(player_count > 0) {
      if(total_dist / player_count > OFFLINE_DRILL_MAX_AVERAGE_DISTANCE)
        return false;
    }
  }

  return true;
}

get_current_drill_state() {
  if(!isDefined(level.drill) || !isDefined(level.drill.state))
    return "undefined";

  return level.drill.state;
}

get_override_lane_entry(override_lanes) {
  /# Assert( override_lanes.size > 0 );

  if(!isDefined(level.override_lane_index))
    return get_random_entry(override_lanes);

  if(level.override_lane_index >= override_lanes.size)
    level.override_lane_index = 0;

  currentIndex = level.override_lane_index;
  level.override_lane_index++;

  return override_lanes[currentIndex];
}

find_lane_spawn_node(override_lanes) {
  if(isDefined(override_lanes) && override_lanes.size > 0) {
    laneIndex = get_random_entry(override_lanes);
    spawnIndex = get_override_lane_entry(level.lanes[laneIndex]);
  } else {
    laneIndex = get_random_entry(level.cycle_data.current_lane.lanes);
    spawnIndex = level.lanes[laneIndex][RandomInt(level.lanes[laneIndex].size)];
  }

  if(is_spawn_debug_info_requested())
    PrintLn("Lane spawning: " + laneIndex);

  nodeInfo = [];
  nodeInfo["node"] = level.cycle_data.spawner_list[spawnIndex]["location"];
  nodeInfo["validNode"] = true;

  return nodeInfo;
}

get_current_encounter_lane_index() {
  endIndex = undefined;
  currentEncounter = get_current_encounter();
  if(!isDefined(currentEncounter))
    return undefined;

  foreach(index, lane in level.encounter_lanes[currentEncounter]) {
    laneIntensityThreshold = lane.activation_time / level.current_cycle.fullIntensityTime;
    if(laneIntensityThreshold > level.current_intensity) {
      break;
    }

    endIndex = index;
  }

  return level.encounter_lanes[currentEncounter][endIndex];
}

get_random_entry(array) {
  entryCount = -1;
  randomEntry = RandomInt(array.size);

  foreach(index, entry in array) {
    entryCount++;
    if(entryCount == randomEntry)
      return array[index];
  }

  return undefined;
}

filter_spawn_point_by_distance_from_player(spawnNode, spawnType) {
  if(spawnType == "elite")
    return true;

  testLocation = level.players[0].origin;
  return DistanceSquared(testLocation, spawnNode.origin) > level.cycle_data.safe_spawn_distance_sq;
}

sort_closest_to_players(array) {
  return sort_array(array, ::sort_closest_distance_to_players_func, 0);
}

sort_player_view_direction(node_array) {
  random_player = level.players[randomInt(level.players.size)];
  player_view_dir = anglesToForward(random_player GetPlayerAngles());

  return sort_array(node_array, ::sort_player_view_direction_func, 0, [random_player.origin, player_view_dir]);
}

find_random_spawn_node(spawn_nodes, type_name, override_last_time_used_duration, filter_func, filter_optional_param, sort_func) {
  if(level.debug_spawn_director_active)
    return debug_find_spawn_node(spawn_nodes);

  if(isDefined(override_last_time_used_duration))
    lastUsedDuration = override_last_time_used_duration;
  else
    lastUsedDuration = level.cycle_data.spawn_point_last_used_duration;

  if(!isDefined(sort_func))
    sort_func = ::array_randomize;

  spawn_nodes = [[sort_func]](spawn_nodes);
  bestIndex = 0;
  minDesiredTimeSinceUsed = RandomFloatRange(lastUsedDuration * 0.5, lastUsedDuration * 0.75);
  bestTimeSinceUsed = 0.0;
  foundValidNode = false;

  for(nodeIndex = 0; nodeIndex < spawn_nodes.size; nodeIndex++) {
    spawnNode = spawn_nodes[nodeIndex]["location"];

    if(isDefined(filter_func) && !passes_spawn_node_filter(spawnNode, type_name, filter_func, filter_optional_param)) {
      continue;
    }
    if(isDefined(spawn_nodes[nodeIndex]["location"].script_linkName))
      spawnerName = spawn_nodes[nodeIndex]["location"].script_linkName;
    else
      spawnerName = undefined;

    if(!is_valid_spawn_node_for_type(spawn_nodes[nodeIndex]["types"], type_name, spawnerName)) {
      continue;
    }
    if(!isDefined(spawnNode.last_used_time)) {
      foundValidNode = true;
      bestIndex = nodeIndex;
      break;
    }

    timeSinceUsed = GetTime() - spawnNode.last_used_time;

    if(timeSinceUsed > minDesiredTimeSinceUsed) {
      foundValidNode = true;
      bestIndex = nodeIndex;
      break;
    }

    if(timeSinceUsed > bestTimeSinceUsed) {
      bestTimeSinceUsed = timeSinceUsed;
      bestIndex = nodeIndex;
    }
  }

  nodeInfo = [];
  nodeInfo["node"] = spawn_nodes[bestIndex]["location"];
  nodeInfo["validNode"] = foundValidNode;

  return nodeInfo;
}

debug_find_spawn_node(spawn_nodes) {
  if(level.debug_spawn_director_spawn_index >= spawn_nodes.size)
    level.debug_spawn_director_spawn_index = 0;

  nodeInfo = [];
  nodeInfo["node"] = spawn_nodes[level.debug_spawn_director_spawn_index]["location"];
  nodeInfo["validNode"] = true;
  level.debug_spawn_director_spawn_index++;

  return nodeInfo;
}

is_valid_spawn_node_for_type(valid_types, type_name, spawner_name) {
  if(valid_types.size == 0)
    return can_spawn_at_any_node(type_name);

  foreach(ai_type in valid_types) {
    if(ai_type == type_name)
      return true;
  }

  return false;
}

can_spawn_at_any_node(type_name) {
  if(isDefined(level.dlc_alien_type_node_match_override_func)) {
    canSpawnAnyNode = self[[level.dlc_alien_type_node_match_override_func]](type_name);
    if(isDefined(canSpawnAnyNode))
      return canSpawnAnyNode;
  }

  switch (type_name) {
    case "elite":
      return false;
    default:
      return true;
  }
}

passes_spawn_node_filter(spawn_node, spawn_type, filter_func, filter_optional_param) {
  if(isDefined(filter_optional_param))
    return [
      [filter_func]
    ](spawn_node, spawn_type, filter_optional_param);

  return [[filter_func]](spawn_node, spawn_type);
}

find_safe_spawn_spot_with_volumes(player_volumes, type_name, override_last_used_spawn_duration, override_sort_func) {
  sortedVolumes = score_and_sort_spawn_zones(player_volumes);

  foreach(zone in sortedVolumes) {
    if(level.cycle_data.spawn_zones[zone.name].spawn_nodes.size == 0) {
      continue;
    }
    playersToTest = [];
    foreach(index, zoneVolume in player_volumes) {
      if(index != zone.name)
        playersToTest = array_combine(playersToTest, zoneVolume.players);
    }

    spawnLocationInfo = find_random_spawn_node(level.cycle_data.spawn_zones[zone.name].spawn_nodes, type_name, override_last_used_spawn_duration, ::is_safe_spawn_location, playersToTest, override_sort_func);
    if(spawnLocationInfo["validNode"])
      return spawnLocationInfo;

  }

  spawnLocationInfo = find_random_spawn_node(level.cycle_data.spawner_list, type_name, override_last_used_spawn_duration, ::filter_spawn_point_by_distance_from_player, undefined, override_sort_func);
  return spawnLocationInfo;
}

score_and_sort_spawn_zones(spawn_zones) {
  playerProximity = calculate_player_proximity_scores();

  foreach(zone in spawn_zones) {
    zoneScore = 0.0;

    foreach(player in zone.players) {
      zoneScore += level.cycle_data.player_in_zone_score_modifier;
      if(isDefined(player.current_attackers))
        zoneScore -= player.current_attackers.size * level.cycle_data.current_attacker_in_zone_score_modifier;

      if(isDefined(playerProximity[player.name]) && (playerProximity[player.name] > level.cycle_data.group_break_away_distance_sq))
        zoneScore += min(level.cycle_data.max_break_away_zone_score_increase, playerProximity[player.name] / level.cycle_data.group_break_away_distance_sq);
    }

    zoneScore -= get_number_of_recently_used_spawn_points_in_zone(zone) * level.cycle_data.recently_used_spawn_zone_score_modifier;

    zone.zone_score = zoneScore;
  }

  indexedArray = [];
  foreach(zone in spawn_zones)
  indexedArray[indexedArray.size] = zone;

  return sort_array(indexedArray, ::sort_zone_score_func);
}

calculate_player_proximity_scores() {
  playerProximity = [];

  if(level.players.size <= 2)
    return playerProximity;

  for(playerIndex = 0; playerIndex < level.players.size; playerIndex++) {
    playerName = level.players[playerIndex].name;
    if(!isDefined(playerProximity[playerName]))
      playerProximity[playerName] = 99999999.0;

    for(closePlayerIndex = playerIndex + 1; closePlayerIndex < level.players.size; closePlayerIndex++) {
      distanceSq = DistanceSquared(level.players[playerIndex].origin, level.players[closePlayerIndex].origin);
      if(distanceSq < playerProximity[playerName])
        playerProximity[playerName] = distanceSq;

      closePlayerName = level.players[closePlayerIndex].name;
      if(!isDefined(playerProximity[closePlayerName]) || distanceSq < playerProximity[closePlayerName])
        playerProximity[closePlayerName] = distanceSq;
    }
  }

  return playerProximity;
}

get_number_of_recently_used_spawn_points_in_zone(zone) {
  recentlyUsedCount = 0;
  currentTime = GetTime();

  for(nodeIndex = 0; nodeIndex < level.cycle_data.spawn_zones[zone.name].spawn_nodes.size; nodeIndex++) {
    spawnPoint = level.cycle_data.spawn_zones[zone.name].spawn_nodes[nodeIndex]["location"];
    if(isDefined(spawnPoint.last_used_time)) {
      elapsedTime = currentTime - spawnPoint.last_used_time;
      if(elapsedTime < level.cycle_data.spawn_point_last_used_duration)
        recentlyUsedCount++;
    }
  }

  return recentlyUsedCount;
}

sort_zone_score_func(test_entry, base_entry, pass_through_parameter_list) {
  return test_entry.zone_score > base_entry.zone_score;
}

is_safe_spawn_location(spawnLocation, spawnType, playersToTest) {
  if(spawnType == "elite")
    return true;

  foreach(player in playersToTest) {
    if(DistanceSquared(spawnLocation.origin, player.origin) > level.cycle_data.safe_spawn_distance_sq) {
      continue;
    }
    if(has_line_of_sight(spawnLocation.origin, player.origin))
      return false;
  }

  return true;
}

has_line_of_sight(spawnLocation, playerLocation) {
  while(max_traces_reached())
    wait 0.05;

  level.spawn_node_traces_this_frame++;

  return BulletTracePassed(spawnLocation, playerLocation, false, undefined);
}

get_current_player_volumes() {
  if(isDefined(level.dlc_get_current_player_volumes_override_func)) {
    return level[[level.dlc_get_current_player_volumes_override_func]]();
  }

  spawnZoneVolumes = [];
  currentVolumes = [];

  foreach(zone in level.cycle_data.spawn_zones) {
    spawnZoneVolumes[spawnZoneVolumes.size] = zone.volume;
  }

  foreach(player in level.players) {
    if(!isAlive(player) || player.sessionstate == "spectator") {
      continue;
    }
    playerCurrentVolumes = player GetIsTouchingEntities(spawnZoneVolumes);
    foreach(volume in playerCurrentVolumes) {
      entryIndex = 0;
      if(!isDefined(currentVolumes[volume.script_linkName])) {
        volumeName = volume.script_linkName;
        currentVolumes[volumeName] = spawnStruct();
        currentVolumes[volumeName].players = [];
        currentVolumes[volumeName].origin = volume.origin;
        currentVolumes[volumeName].name = volumeName;
      }

      entryIndex = currentVolumes[volume.script_linkName].players.size;
      currentVolumes[volume.script_linkName].players[entryIndex] = player;
    }
  }

  return currentVolumes;
}

max_traces_reached() {
  MAX_TRACE_COUNT_PER_FRAME = 5;
  if(gettime() > level.spawn_node_traces_frame_time) {
    level.spawn_node_traces_frame_time = gettime();
    level.spawn_node_traces_this_frame = 0;
  }

  return level.spawn_node_traces_this_frame >= MAX_TRACE_COUNT_PER_FRAME;
}

load_cycle_scalars_from_table(cycle_data) {
  cycle_data.cycle_scalars = [];

  if(is_casual_mode()) {
    level.cycle_health_scalar = level.casual_health_scalar;
    level.cycle_damage_scalar = level.casual_damage_scalar;
    level.cycle_reward_scalar = level.casual_reward_scalar;
    level.cycle_score_scalar = level.casual_score_scalar;
  } else if(is_hardcore_mode()) {
    level.cycle_health_scalar = level.hardcore_health_scalar;
    level.cycle_damage_scalar = level.hardcore_damage_scalar;
    level.cycle_reward_scalar = level.hardcore_reward_scalar;
    level.cycle_score_scalar = level.hardcore_score_scalar;
  } else {
    level.cycle_health_scalar = 1.0;
    level.cycle_damage_scalar = 1.0;
    level.cycle_reward_scalar = 1.0;
    level.cycle_score_scalar = 1.0;
  }

  for(entryIndex = TABLE_CYCLE_SCALAR_START_INDEX; entryIndex <= TABLE_CYCLE_SCALAR_END_INDEX; entryIndex++) {
    cycle = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_SCALAR_CYCLE);
    if(cycle == "") {
      break;
    }
    cycle = int(cycle);
    cycleScalars = spawnStruct();
    cycleScalars.health = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_SCALAR_HEALTH));
    cycleScalars.damage = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_SCALAR_DAMAGE));
    cycleScalars.reward = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_SCALAR_REWARD));
    cycleScalars.score = float(tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_SCALAR_SCORE));
    add_cycle_scalar(int(cycle), cycleScalars, cycle_data);
  }
}

add_cycle_scalar(cycle_index, scalars, cycle_data) {
  assert(!isDefined(cycle_data.cycle_scalars[cycle_index]));
  cycle_data.cycle_scalars[cycle_index] = scalars;
}

set_cycle_scalars(cycle_num) {
  if(is_hardcore_mode()) {
    level.cycle_health_scalar = level.cycle_data.cycle_scalars[cycle_num].health * level.hardcore_health_scalar;
    level.cycle_damage_scalar = level.cycle_data.cycle_scalars[cycle_num].damage * level.hardcore_damage_scalar;
    level.cycle_reward_scalar = level.cycle_data.cycle_scalars[cycle_num].reward * level.hardcore_reward_scalar;
    level.cycle_score_scalar = level.cycle_data.cycle_scalars[cycle_num].score * level.hardcore_score_scalar;
  } else if(is_casual_mode()) {
    level.cycle_health_scalar = level.cycle_data.cycle_scalars[cycle_num].health * level.casual_health_scalar;
    level.cycle_damage_scalar = level.cycle_data.cycle_scalars[cycle_num].damage * level.casual_damage_scalar;
    level.cycle_reward_scalar = level.cycle_data.cycle_scalars[cycle_num].reward * level.casual_reward_scalar;
    level.cycle_score_scalar = level.cycle_data.cycle_scalars[cycle_num].score * level.casual_score_scalar;
  } else {
    level.cycle_health_scalar = level.cycle_data.cycle_scalars[cycle_num].health;
    level.cycle_damage_scalar = level.cycle_data.cycle_scalars[cycle_num].damage;
    level.cycle_reward_scalar = level.cycle_data.cycle_scalars[cycle_num].reward;
    level.cycle_score_scalar = level.cycle_data.cycle_scalars[cycle_num].score;
  }

}

init_spawn_node_info(cycle_data) {
  cycle_data.spawn_node_info = [];

  init_spawn_node_info_from_table(cycle_data);
}

init_spawn_node_info_from_table(cycle_data) {
  if(!isDefined(level.spawn_node_info_table))
    level.spawn_node_info_table = SPAWN_NODE_INFO_TABLE;

  for(entryIndex = TABLE_SPAWN_NODE_INFO_START_INDEX; entryIndex <= TABLE_SPAWN_NODE_INFO_MAX_INDEX; entryIndex++) {
    key = tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_NODE_KEY);
    if(key == "") {
      break;
    }

    node_info = spawnStruct();

    node_info.validType = tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, TABLE_SPAWN_VALID_ALIEN_TYPE);
    node_info.scriptableStatus = getScriptableStatus(entryIndex);

    vignetteInfo = [];
    vignetteInfo["goon"] = grabVignetteInfo(key, entryIndex, TABLE_GOON_VIGNETTE_STATE, TABLE_GOON_VIGNETTE_INDEX_ARRAY, TABLE_GOON_VIGNETTE_LABEL, TABLE_GOON_VIGNETTE_END_NOTETRACK, TABLE_GOON_VIGNETTE_FX, TABLE_GOON_VIGNETTE_SCRIPTABLE, TABLE_GOON_VIGNETTE_SCRIPTABLE_STATE);
    vignetteInfo["brute"] = grabVignetteInfo(key, entryIndex, TABLE_BRUTE_VIGNETTE_STATE, TABLE_BRUTE_VIGNETTE_INDEX_ARRAY, TABLE_BRUTE_VIGNETTE_LABEL, TABLE_BRUTE_VIGNETTE_END_NOTETRACK, TABLE_BRUTE_VIGNETTE_FX, TABLE_BRUTE_VIGNETTE_SCRIPTABLE, TABLE_BRUTE_VIGNETTE_SCRIPTABLE_STATE);
    vignetteInfo["spitter"] = grabVignetteInfo(key, entryIndex, TABLE_SPITTER_VIGNETTE_STATE, TABLE_SPITTER_VIGNETTE_INDEX_ARRAY, TABLE_SPITTER_VIGNETTE_LABEL, TABLE_SPITTER_VIGNETTE_END_NOTETRACK, TABLE_SPITTER_VIGNETTE_FX, TABLE_SPITTER_VIGNETTE_SCRIPTABLE, TABLE_SPITTER_VIGNETTE_SCRIPTABLE_STATE);
    vignetteInfo["seeder"] = grabVignetteInfo(key, entryIndex, TABLE_SPITTER_VIGNETTE_STATE, TABLE_SPITTER_VIGNETTE_INDEX_ARRAY, TABLE_SPITTER_VIGNETTE_LABEL, TABLE_SPITTER_VIGNETTE_END_NOTETRACK, TABLE_SPITTER_VIGNETTE_FX, TABLE_SPITTER_VIGNETTE_SCRIPTABLE, TABLE_SPITTER_VIGNETTE_SCRIPTABLE_STATE);
    vignetteInfo["elite"] = grabVignetteInfo(key, entryIndex, TABLE_ELITE_VIGNETTE_STATE, TABLE_ELITE_VIGNETTE_INDEX_ARRAY, TABLE_ELITE_VIGNETTE_LABEL, TABLE_ELITE_VIGNETTE_END_NOTETRACK, TABLE_ELITE_VIGNETTE_FX, TABLE_ELITE_VIGNETTE_SCRIPTABLE, TABLE_ELITE_VIGNETTE_SCRIPTABLE_STATE);
    vignetteInfo["minion"] = grabVignetteInfo(key, entryIndex, TABLE_MINION_VIGNETTE_STATE, TABLE_MINION_VIGNETTE_INDEX_ARRAY, TABLE_MINION_VIGNETTE_LABEL, TABLE_MINION_VIGNETTE_END_NOTETRACK, TABLE_MINION_VIGNETTE_FX, TABLE_MINION_VIGNETTE_SCRIPTABLE, TABLE_MINION_VIGNETTE_SCRIPTABLE_STATE);

    node_info.vignetteInfo = vignetteInfo;

    cycle_data.spawn_node_info[key] = node_info;
  }
}

grabVignetteInfo(key, entryIndex, stateIndex, indexArrayIndex, labelIndex, endNotetrackIndex, FX, scriptableTargetname, scriptableState) {
  CONST_DELIMITER = ";";

  state = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, stateIndex));
  indexArray = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, indexArrayIndex));
  label = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, labelIndex));
  endNoteTrack = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, endNotetrackIndex));
  fx = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, FX));
  scriptableTargetname = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, scriptableTargetname));
  scriptableState = replaceEmptyStringWithNone(tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, scriptableState));

  return (state + CONST_DELIMITER + indexArray + CONST_DELIMITER + label + CONST_DELIMITER + endNoteTrack + CONST_DELIMITER + fx + CONST_DELIMITER + scriptableTargetname + CONST_DELIMITER + scriptableState + CONST_DELIMITER + key);
}

getScriptableStatus(entryIndex) {
  string = tablelookup(level.spawn_node_info_table, TABLE_INDEX, entryIndex, TABLE_ONE_OFF_SCRIPTABLE);

  if(maps\mp\agents\alien\_alien_agents::is_empty_string(string))
    return "always_on";
  else
    return "one_off";
}

replaceEmptyStringWithNone(string) {
  if(maps\mp\agents\alien\_alien_agents::is_empty_string(string))
    return "NONE";

  return string;
}

load_cycle_drill_layer_from_table(cycle_data) {
  cycle_data.cycle_drill_layers = [];
  cycle_data.cycle_delay_times = [];

  for(entryIndex = TABLE_CYCLE_DRILL_LAYER_START_INDEX; entryIndex <= TABLE_CYCLE_DRILL_LAYER_END_INDEX; entryIndex++) {
    cycle = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_DRILL_LAYER_CYCLE);
    if(cycle == "") {
      break;
    }

    layers = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_DRILL_LAYERS);
    layers = StrTok(layers, " ");

    for(i = 0; i < layers.size; i++)
      layers[i] = int(layers[i]);

    cycle_data.cycle_drill_layers[int(cycle)] = layers;

    delay_time = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_CYCLE_DRILL_DELAY);
    cycle_data.cycle_delay_times[int(cycle)] = float(delay_time);
  }
}

load_random_hives_from_table() {
  removed_hives = [];

  for(entryIndex = TABLE_RANDOM_HIVES_START_INDEX; entryIndex <= TABLE_RANDOM_HIVES_END_INDEX; entryIndex++) {
    num_spawned = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_RANDOM_HIVES_NUM_SPAWNED);
    if(num_spawned == "") {
      break;
    }

    hives = tablelookup(level.alien_cycle_table, TABLE_INDEX, entryIndex, TABLE_RANDOM_HIVES_HIVE_LIST);
    hives = StrTok(hives, " ");

    removed_hives = array_combine(removed_hives, get_hives_to_remove(int(num_spawned), hives));
  }

  level.removed_hives = removed_hives;
}

get_hives_to_remove(num_to_spawn, hive_array) {
  num_to_remove = hive_array.size - num_to_spawn;
  assert(num_to_remove >= 0);

  if(num_to_remove == 0)
    return [];

  hive_array = array_randomize(hive_array);
  hives_to_remove = [];
  for(i = 0; i < num_to_remove; i++) {
    hives_to_remove[hives_to_remove.size] = hive_array[i];
  }

  return hives_to_remove;
}