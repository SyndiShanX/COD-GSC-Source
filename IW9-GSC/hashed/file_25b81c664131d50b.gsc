/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25b81c664131d50b.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_water_maze", ::_id_771785D27CDC39CE);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_maze_armory", ::_id_A3C823B22F04DE18);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_nums_ready_intro", ::_id_36C5D342DD86EB94);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_nums_ready_puzzle", ::_id_14333AFFFB5B92A8);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_nums_ready_finale", ::_id_0C973364A950A769);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_A3C823B22F04DE18() {
  level._id_E1F6DB0A259574B7 = 1;
  level._id_BC53C613A7E7DB4D = 1;
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "startpoint_armory", 1);
}

_id_771785D27CDC39CE() {
  level._id_E1F6DB0A259574B7 = 1;
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "startpoint_watermaze", 1);
}

_id_36C5D342DD86EB94() {
  level._id_E1F6DB0A259574B7 = 1;
  level._id_C6081A8F8E88DC09 = 1;
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_debug_start_loc", 1);
}

_id_14333AFFFB5B92A8() {
  level._id_E1F6DB0A259574B7 = 1;
  level._id_E13D1DE65E306886 = 1;
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");

  if(!isDefined(level.start_point) || level.start_point != "raid1_nums_skiptopuzzle")
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_checkpoint_debug_start_loc", 1);
}

_id_0C973364A950A769() {
  level._id_E1F6DB0A259574B7 = 1;
  level._id_E13D1DE65E306886 = 1;
  level._id_922A06644812D5DE = 1;
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");

  if(!isDefined(level.start_point))
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_checkpoint_defend_debug_start_loc", 1);
  else {
    if(level.start_point == "raid1_nums_defend" || level.start_point == "raid1_nums_outro") {
      return;
    }
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_checkpoint_defend_debug_start_loc", 1);
  }
}

checkpoint_player_spawns() {
  return [];
}

checkpoint_carepkg_spawns() {
  return [];
}