/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_chaos_utility.gsc
********************************************/

init_chaos_score_components() {
  level.combo_counter = 0;
  level.score_streak = 0;
  level.running_score_base = 0;
  level.total_score = 0;
}

calculate_total_score() {
  level.total_score = level.running_score_base + level.combo_counter * level.score_streak;
  maps\mp\alien\_hud::set_total_score(level.total_score);
  return level.total_score;
}

keep_running_score() {
  level.running_score_base += get_combo_counter() * get_score_streak();
}

reset_combo_counter() {
  level.combo_counter = 0;
}
add_combo_counter(increment) {
  level.combo_counter += increment;
}
add_score_streak(increment) {
  level.score_streak += increment;
}
get_combo_counter() {
  return level.combo_counter;
}
get_score_streak() {
  return level.score_streak;
}
get_total_score() {
  return level.total_score;
}

TABLE_INDEX_COLUMN = 0;

CHAOS_EVENT_TABLE = "mp/alien/chaos_events.csv";
GSC_ID_COLUMN = 1;
LUA_EVENT_ID_COLUMN = 2;
COMBO_INC_COLUMN = 4;
SCORE_INC_COLUMN = 5;
MAX_EVENT_INDEX = 100;

register_chaos_events() {
  level.chaos_events = [];

  for(entryIndex = 1; entryIndex <= MAX_EVENT_INDEX; entryIndex++) {
    event_ID = table_look_up(CHAOS_EVENT_TABLE, entryIndex, GSC_ID_COLUMN);
    if(maps\mp\agents\alien\_alien_agents::is_empty_string(event_ID)) {
      break;
    }

    event_info = [];
    event_info["LUA_event_ID"] = int(table_look_up(CHAOS_EVENT_TABLE, entryIndex, LUA_EVENT_ID_COLUMN));
    event_info["combo_inc"] = int(table_look_up(CHAOS_EVENT_TABLE, entryIndex, COMBO_INC_COLUMN));
    event_info["score_inc"] = int(table_look_up(CHAOS_EVENT_TABLE, entryIndex, SCORE_INC_COLUMN));

    level.chaos_events[event_ID] = event_info;
  }
}

WEAPON_START_INDEX = 1000;
WEAPON_END_INDEX = 1099;

add_chaos_weapon(world_item_list) {
  for(index = WEAPON_START_INDEX; index <= WEAPON_END_INDEX; index++) {
    if(is_empty_value(index)) {
      break;
    }

    weapon_struct = make_weapon_struct(index);
    world_item_list[world_item_list.size] = weapon_struct;
  }

  return world_item_list;
}

make_weapon_struct(index) {
  weapon_struct = spawnStruct();

  weapon_struct.script_noteworthy = get_weapon_ref(index);
  weapon_struct.origin = get_weapon_origin(index);
  weapon_struct.angles = get_weapon_angles(index);

  return weapon_struct;
}

WEAPON_REF_COLUMN = 1;
WEAPON_ORIGIN_COLUMN = 2;
WEAPON_ANGLES_COLUMN = 3;

is_empty_value(index) {
  return (table_look_up(level.alien_cycle_table, index, WEAPON_REF_COLUMN) == "");
}
get_weapon_ref(index) {
  return get_weapon_info(index, WEAPON_REF_COLUMN);
}
get_weapon_origin(index) {
  return transform_to_coordinate(get_weapon_info(index, WEAPON_ORIGIN_COLUMN));
}
get_weapon_angles(index) {
  return transform_to_coordinate(get_weapon_info(index, WEAPON_ANGLES_COLUMN));
}
get_weapon_info(index, column) {
  return table_look_up(level.alien_cycle_table, index, column);
}

register_perk(perk_ref, activate_func, deactivate_func) {
  perk_info = [];
  perk_info["perk_ref"] = perk_ref;
  perk_info["activate_func"] = activate_func;
  perk_info["deactivate_func"] = deactivate_func;
  perk_info["LUA_perk_ID"] = get_LUA_perk_ID(perk_ref);
  perk_info["is_activated"] = false;

  level.perk_progression[get_activation_level(perk_ref)] = perk_info;
}

CHAOS_PERK_TABLE = "mp/alien/chaos_perks.csv";
ACTIVATION_LEVEL_COLUMN = 1;
LUA_PERK_ID_COLUMN = 2;

get_LUA_perk_ID(perk_ref) {
  return int(table_look_up(CHAOS_PERK_TABLE, perk_ref, LUA_PERK_ID_COLUMN));
}
get_activation_level(perk_ref) {
  return int(table_look_up(CHAOS_PERK_TABLE, perk_ref, ACTIVATION_LEVEL_COLUMN));
}

DROP_LOC_START_INDEX = 4000;
DROP_LOC_END_INDEX = 4099;
DROP_LOC_COLUMN = 1;

register_drop_locations() {
  level.chaos_bonus_loc = [];
  level.chaos_bonus_loc_used = [];

  for(index = DROP_LOC_START_INDEX; index <= DROP_LOC_END_INDEX; index++) {
    drop_loc = table_look_up(level.alien_cycle_table, index, DROP_LOC_COLUMN);

    if(maps\mp\agents\alien\_alien_agents::is_empty_string(drop_loc)) {
      break;
    }

    level.chaos_bonus_loc[level.chaos_bonus_loc.size] = transform_to_coordinate(drop_loc);
  }
}

PROGRESSION_START_INDEX = 5000;
PROGRESSION_END_INDEX = 5099;
WAIT_DURATION_COLUMN = 1;
NUM_OF_DROPS_COLUMN = 2;
GROUP_TYPE_COLUMN = 3;
GROUP_CHANCE_COLUMN = 4;
ITEM_CHANCE_COLUMN = 5;

register_bonus_progression() {
  level.chaos_bonus_progression = [];
  max_num_of_drops = 0;

  for(index = PROGRESSION_START_INDEX; index <= PROGRESSION_END_INDEX; index++) {
    wait_duration = table_look_up(level.alien_cycle_table, index, WAIT_DURATION_COLUMN);

    if(maps\mp\agents\alien\_alien_agents::is_empty_string(wait_duration)) {
      break;
    }

    bonus_info = [];
    bonus_info["wait_duration"] = int(wait_duration);
    bonus_info["num_of_drops"] = int(table_look_up(level.alien_cycle_table, index, NUM_OF_DROPS_COLUMN));
    bonus_info["package_group_type"] = strTok(table_look_up(level.alien_cycle_table, index, GROUP_TYPE_COLUMN), " ");
    bonus_info["package_group_chance"] = convert_array_to_int(strTok(table_look_up(level.alien_cycle_table, index, GROUP_CHANCE_COLUMN), " "));
    bonus_info["item_chance"] = strTok(table_look_up(level.alien_cycle_table, index, ITEM_CHANCE_COLUMN), " ");
    AssertEx(bonus_info["num_of_drops"] <= bonus_info["package_group_type"].size, "For wait duration: " + wait_duration + ", there is not enough bonus packages to support " + bonus_info["num_of_drops"] + " drops.");

    if(bonus_info["num_of_drops"] > max_num_of_drops)
      max_num_of_drops = bonus_info["num_of_drops"];

    level.chaos_bonus_progression[level.chaos_bonus_progression.size] = bonus_info;
  }

  level.chaos_max_used_loc_stored = level.chaos_bonus_loc.size - max_num_of_drops;
}

convert_array_to_int(string_array) {
  int_array = [];

  foreach(string in string_array)
  int_array[int_array.size] = int(string);

  return int_array;
}

transform_to_coordinate(text_string) {
  tokenized = StrTok(text_string, ",");
  return (int(tokenized[0]), int(tokenized[1]), int(tokenized[2]));
}

init_chaos_deployable(boxType, iconName, onUseCallback) {
  boxConfig = spawnStruct();
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = &"ALIEN_CHAOS_BONUS_PICKUP";
  boxConfig.capturingString = &"ALIEN_CHAOS_BONUS_TAKING";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = onUseCallback;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.maxUses = 1;
  boxConfig.icon_name = iconName;

  add_to_chaos_bonus_package_type(boxType);
  maps\mp\alien\_deployablebox::init_deployable(boxType, boxConfig);
}

get_random_player() {
  return level.players[randomint(level.players.size)];
}
table_look_up(table, index, target_column) {
  return tableLookup(table, TABLE_INDEX_COLUMN, index, target_column);
}

get_drop_location_rated(desired_dir, base_pos) {
  MIN_DIST_SQD_FROM_ALL_PLAYER = 22500;
  MAX_DIST_SQD_FROM_ALL_PLAYER = 90000;

  DIST_FROM_ALL_PLAYER_WEIGHT = 1.0;
  DESIRED_DIR_WEIGHT = 1.0;
  RANDOM_WEIGHT = 2.0;

  best_location_rating = -1000.0;
  best_location = (0, 0, 0);

  foreach(location in level.chaos_bonus_loc) {
    if(location_recently_used(location)) {
      continue;
    }
    rating = 0.0;

    foreach(player in level.players) {
      player_to_location_distanceSquared = DistanceSquared(player.origin, location);

      if(player_to_location_distanceSquared > MIN_DIST_SQD_FROM_ALL_PLAYER)
        rating += DIST_FROM_ALL_PLAYER_WEIGHT;

      if(player_to_location_distanceSquared < MAX_DIST_SQD_FROM_ALL_PLAYER)
        rating += DIST_FROM_ALL_PLAYER_WEIGHT;
    }

    base_pos_to_location = vectorNormalize((0, vectorToYaw(location - base_pos), 0));
    rating += VectorDot(base_pos_to_location, desired_dir) * DESIRED_DIR_WEIGHT;

    rating += randomFloat(RANDOM_WEIGHT);

    if(rating > best_location_rating) {
      best_location_rating = rating;
      best_location = location;
    }
  }

  register_location(best_location);
  return best_location;
}

register_location(location) {
  if(level.chaos_bonus_loc_used.size == level.chaos_max_used_loc_stored) {
    for(i = 0; i < level.chaos_max_used_loc_stored - 1; i++)
      level.chaos_bonus_loc_used[i] = level.chaos_bonus_loc_used[i + 1];

    level.chaos_bonus_loc_used[level.chaos_max_used_loc_stored - 1] = location;
  } else {
    level.chaos_bonus_loc_used[level.chaos_bonus_loc_used.size] = location;
  }
}

location_recently_used(location) {
  return common_scripts\utility::array_contains(level.chaos_bonus_loc_used, location);
}

reset_alien_kill_streak() {
  level.current_alien_kill_streak = 0;
}
inc_alien_kill_streak() {
  level.current_alien_kill_streak++;
}
get_alien_kill_streak() {
  return level.current_alien_kill_streak;
}

play_FX_on_package(package_loc, owner_angles) {
  CONST_XY_OFFSET = (-0.5, 5.6, 0);
  CONST_Z_OFFSET = (0, 0, 5);

  XY_offset = RotateVector(CONST_XY_OFFSET, owner_angles);
  FX_loc = package_loc + XY_offset;
  FX_loc += CONST_Z_OFFSET;
  fx = SpawnFX(common_scripts\utility::getfx("chaos_pre_bonus_drop"), FX_loc);
  TriggerFx(fx);

  return fx;
}

clean_up_monitor(fx, box) {
  box waittill("death");
  fx delete();
}

init_highest_combo() {
  level.highest_combo = 0;
}

record_highest_combo(combo_counter) {
  if(combo_counter <= level.highest_combo) {
    return;
  }
  level.highest_combo = combo_counter;
  foreach(player in level.players)
  player maps\mp\alien\_persistence::LB_player_update_stat("hits", combo_counter, true);
}

CYCLE_PARAMETER_START_INDEX = 500;
CYCLE_PARAMETER_END_INDEX = 599;
CYCLE_NUMBER_COLUMN = 1;
CYCLE_DURATION_COLUMN = 6;

register_cycle_duration() {
  level.chaos_cycle_duration = [];

  for(index = CYCLE_PARAMETER_START_INDEX; index <= CYCLE_PARAMETER_END_INDEX; index++) {
    cycle_number = table_look_up(level.alien_cycle_table, index, CYCLE_NUMBER_COLUMN);

    if(maps\mp\agents\alien\_alien_agents::is_empty_string(cycle_number)) {
      break;
    }

    level.chaos_cycle_duration[level.chaos_cycle_duration.size] = int(table_look_up(level.alien_cycle_table, index, CYCLE_DURATION_COLUMN));
  }
}

SPAWN_LOC_START_INDEX = 6000;
SPAWN_LOC_END_INDEX = 6099;
SPAWN_LOC_ORIGIN_COLUMN = 1;
SPAWN_LOC_ANGLES_COLUMN = 2;
SPAWN_LOC_LINKTO_COLUMN = 3;
SPAWN_LOC_NOTEWORTHY_COLUMN = 4;

add_extra_spawn_locations() {
  extra_spawn_locations = [];

  for(index = SPAWN_LOC_START_INDEX; index <= SPAWN_LOC_END_INDEX; index++) {
    spawn_loc_origin = table_look_up(level.alien_cycle_table, index, SPAWN_LOC_ORIGIN_COLUMN);

    if(maps\mp\agents\alien\_alien_agents::is_empty_string(spawn_loc_origin)) {
      break;
    }

    spawn_location = spawnStruct();
    spawn_location.origin = transform_to_coordinate(spawn_loc_origin);
    spawn_location.angles = transform_to_coordinate(table_look_up(level.alien_cycle_table, index, SPAWN_LOC_ANGLES_COLUMN));
    spawn_location.script_linkto = translate_to_actual_zone_name(table_look_up(level.alien_cycle_table, index, SPAWN_LOC_LINKTO_COLUMN));
    spawn_location.script_noteworthy = table_look_up(level.alien_cycle_table, index, SPAWN_LOC_NOTEWORTHY_COLUMN);

    extra_spawn_locations[extra_spawn_locations.size] = spawn_location;
  }

  maps\mp\alien\_spawn_director::put_spawnLocations_into_cycle_data(extra_spawn_locations, level.cycle_data);
}

DEFAULT_INIT_COMBO_DURATION = 4.0;

init_combo_duration() {
  if(!isDefined(level.combo_duration))
    level.combo_duration = DEFAULT_INIT_COMBO_DURATION;
}

get_combo_duration() {
  return level.combo_duration;
}
adjust_combo_duration(delta) {
  level.combo_duration += delta;
}

COMBO_DURATION_START_INDEX = 7000;
COMBO_DURATION_END_INDEX = 7099;
COMBO_DURATION_PRE_DELTA_INTERVAL_COLUMN = 1;
COMBO_DURATION_DELTA_COLUMN = 2;

register_combo_duration_schedule() {
  level.combo_duration_schedule = [];

  for(index = COMBO_DURATION_START_INDEX; index <= COMBO_DURATION_END_INDEX; index++) {
    pre_delta_interval = table_look_up(level.alien_cycle_table, index, COMBO_DURATION_PRE_DELTA_INTERVAL_COLUMN);

    if(maps\mp\agents\alien\_alien_agents::is_empty_string(pre_delta_interval)) {
      break;
    }

    duration_delta = [];
    duration_delta["pre_delta_interval"] = float(pre_delta_interval);
    duration_delta["delta"] = float(table_look_up(level.alien_cycle_table, index, COMBO_DURATION_DELTA_COLUMN));

    level.combo_duration_schedule[level.combo_duration_schedule.size] = duration_delta;
  }
}

DEFAULT_BONUS_PACKAGE_CAP = 3;

init_bonus_package_cap() {
  if(!isDefined(level.chaos_bonus_package_cap))
    level.chaos_bonus_package_cap = DEFAULT_BONUS_PACKAGE_CAP;
}

get_bonus_package_cap() {
  return level.chaos_bonus_package_cap;
}
init_chaos_bonus_package_type() {
  level.chaos_bonus_package_type = [];
}
add_to_chaos_bonus_package_type(package_type) {
  level.chaos_bonus_package_type[level.chaos_bonus_package_type.size] = package_type;
}

get_current_num_bonus_package() {
  result = 0;

  foreach(package_type in level.chaos_bonus_package_type)
  result += level.deployable_box[package_type].size;

  return result;
}

chaos_end_game() {
  if(chaos_should_end())
    level thread maps\mp\gametypes\aliens::AlienEndGame("axis", maps\mp\alien\_hud::get_end_game_string_index("kia"));
}

CONST_IN_HOST_MIGRATION_FLAG = "in_host_migration";

chaos_should_end() {
  if(getDvarInt("chaos_no_fail", 0) == 1)
    return false;

  if(common_scripts\utility::flag(CONST_IN_HOST_MIGRATION_FLAG))
    return false;

  return true;
}

reset_chaos_no_fail() {
  setDvar("chaos_no_fail", 0);
}

should_process_alien_killed_event(attacker) {
  return (isPlayer(attacker) || (isDefined(attacker.owner) && isPlayer(attacker.owner)) || (isDefined(attacker.team) && attacker.team == "allies"));
}

should_process_alien_damaged_event(sWeapon) {
  if(isDefined(sWeapon) && sWeapon == "alien_minion_explosion")
    return false;

  return true;
}

unset_player_perks(player) {
  foreach(perk_info in level.perk_progression) {
    if(perk_info["is_activated"])
      [[perk_info["deactivate_func"]]](player, perk_info["perk_ref"]);
  }
  player PlayLocalSound("mp_splash_screen_default");
}

give_activated_perks(player) {
  foreach(perk_info in level.perk_progression) {
    if(perk_info["is_activated"])
      [[perk_info["activate_func"]]](player, perk_info["perk_ref"]);
  }
}

set_all_perks_inactivated() {
  foreach(perk_info in level.perk_progression)
  perk_info["is_activated"] = false;
}

get_attacker_as_player(attacker) {
  if(isPlayer(attacker))
    return attacker;

  if(isDefined(attacker.owner) && isPlayer(attacker.owner))
    return attacker.owner;

  return undefined;
}

MAX_EVENT_COUNT = 18;

init_event_counts() {
  level.chaos_event_counts = [];

  for(i = 1; i <= MAX_EVENT_COUNT; i++)
    level.chaos_event_counts[i] = 0;
}

update_HUD_event_counts() {
  for(i = 1; i <= MAX_EVENT_COUNT; i++)
    maps\mp\alien\_hud::set_event_count(i, level.chaos_event_counts[i]);
}

inc_event_count(event_ID) {
  level.chaos_event_counts[event_ID]++;
}
register_pre_end_game_display_func() {
  level.pre_end_game_display_func = ::update_HUD_event_counts;
}

translate_to_actual_zone_name(zone_name_list) {
  actual_zone_name_list = [];

  zone_name_list = StrTok(zone_name_list, " ");
  foreach(zone_name in zone_name_list) {
    foreach(actual_zone_name, spawn_data in level.cycle_data.spawn_zones) {
      if(IsSubStr(actual_zone_name, zone_name))
        actual_zone_name_list[actual_zone_name_list.size] = actual_zone_name;
    }
  }

  AssertEx(actual_zone_name_list.size == zone_name_list.size, "Unable to find the actual zone name for some zones.");

  if(actual_zone_name_list.size == 0) {
    result_actual_name_string = "";
  } else {
    result_actual_name_string = actual_zone_name_list[0];

    for(i = 1; i < actual_zone_name_list.size; i++)
      result_actual_name_string = result_actual_name_string + " " + actual_zone_name_list[i];
  }

  return result_actual_name_string;
}