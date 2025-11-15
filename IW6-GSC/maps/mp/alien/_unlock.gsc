/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_unlock.gsc
*****************************************************/

ALIEN_UNLOCK_TABLE = "mp/alien/unlocktable.csv";

TABLE_STARTING_ROW_INDEX = 100;
TABLE_END_ROW_INDEX = 110;

TABLE_INDEX = 0;
COLUMN_UNLOCK_ITEM = 1;
COLUMN_UNLOCK_TYPE = 3;

GOAL_ESCAPE = 1;
GOAL_ESCAPE_10_TIMES = 10;
GOAL_ESCAPE_20_TIMES = 20;
GOAL_ESCAPE_50_TIMES = 50;

init_unlock() {
  load_unlock_from_table();
}

init_player_unlock() {
  self.unlock_list = [];

  if(isDefined(level.unlock_registration_func))
    [[level.unlock_registration_func]]();

  if(maps\mp\alien\_utility::is_true(level.include_default_unlocks))
    register_default_unlocks();
}

register_default_unlocks() {
  register_unlock("UNLOCK_ESCAPE", 1, GOAL_ESCAPE, ::default_init);
  register_unlock("UNLOCK_ESCAPE_10_TIMES", 2, GOAL_ESCAPE_10_TIMES, ::default_init);
  register_unlock("UNLOCK_ESCAPE_20_TIMES", 3, GOAL_ESCAPE_20_TIMES, ::default_init);
  register_unlock("UNLOCK_ESCAPE_50_TIMES", 4, GOAL_ESCAPE_50_TIMES, ::default_init);
}

register_unlock(reference, index_map, goal, init_func) {
  unlock = spawnStruct();
  unlock[[init_func]](index_map, goal);
  self.unlock_list[reference] = unlock;
}

default_init(index_map, goal) {
  self.progress = 0;
  self.index_map = index_map;
  self.goal = goal;
}

update_progress(progress_amount) {
  self.progress += progress_amount;
}

is_goal_achieved() {
  return (self.progress >= self.goal);
}

is_valid_unlock(unlock) {
  return (isDefined(unlock));
}

update_unlock(reference, progress_amt) {
  unlock = self.unlock_list[reference];

  if(!is_valid_unlock(unlock)) {
    return;
  }
  unlock update_progress(progress_amt);

  if(unlock is_goal_achieved()) {
    unlock_item_info = level.alien_unlock_data[unlock.index_map];

    maps\mp\alien\_debug::debug_print_item_unlocked(unlock_item_info.item, unlock_item_info.type);

  }
}

update_escape_item_unlock(players_escaped) {
  foreach(player in players_escaped) {
    times_escaped = player maps\mp\alien\_persistence::get_player_escaped();
    player update_personal_escape_item_unlock(times_escaped);

    num_nerf_selected = player maps\mp\alien\_prestige::get_num_nerf_selected();
    most_nerfs_escaped_with = player maps\mp\alien\_persistence::get_player_highest_nerf_escape_count();

    if(num_nerf_selected > most_nerfs_escaped_with) {
      player SetCoopPlayerData("alienPlayerStats", "headShots", num_nerf_selected);
    }
  }
}

update_personal_escape_item_unlock(times_escaped) {
  update_unlock("UNLOCK_ESCAPE", 1);
  update_unlock("UNLOCK_ESCAPE_10_TIMES", times_escaped);
  update_unlock("UNLOCK_ESCAPE_20_TIMES", times_escaped);
  update_unlock("UNLOCK_ESCAPE_50_TIMES", times_escaped);
}

load_unlock_from_table() {
  level.alien_unlock_data = [];

  if(isDefined(level.alien_unlock_table))
    unlock_table = level.alien_unlock_table;
  else
    unlock_table = ALIEN_UNLOCK_TABLE;

  for(rowIndex = TABLE_STARTING_ROW_INDEX; rowIndex <= TABLE_END_ROW_INDEX; rowIndex++) {
    unlock_item = tableLookup(unlock_table, TABLE_INDEX, rowIndex, COLUMN_UNLOCK_ITEM);

    if(unlock_item == "") {
      break;
    }

    unlock_type = tableLookup(unlock_table, TABLE_INDEX, rowIndex, COLUMN_UNLOCK_TYPE);

    unlock_item_info = spawnStruct();
    unlock_item_info.item = unlock_item;
    unlock_item_info.type = unlock_type;

    level.alien_unlock_data[level.alien_unlock_data.size] = unlock_item_info;
  }
}