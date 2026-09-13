/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_19d6d03a1ee045c1.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_pipe_room", ::_id_B62A27C699168DD0);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_gauntlet_approach", ::_id_299878110527868B);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_vtol_spawned", ::_id_94097F0D4D9FF454);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_B62A27C699168DD0() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level._id_AD9B99883D277045 = "pipe_room";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid1test_create_script");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script_completed");
  scripts\engine\utility::flag_set("cp_raid1test_create_script2");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script2_completed");
  scripts\engine\utility::flag_set("cp_raid1_pipes_create_script");
  scripts\engine\utility::flag_wait("cp_raid1_pipes_create_script_completed");
  level thread scripts\cp\cp_objectives::run_objective("pipe_room");
}

_id_299878110527868B() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level._id_AD9B99883D277045 = "gauntlet_approach";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid1test_create_script");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script_completed");
  scripts\engine\utility::flag_set("cp_raid1test_create_script2");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script2_completed");
  level thread scripts\cp\cp_objectives::run_objective("get_to_roof");
}

_id_94097F0D4D9FF454() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level._id_AD9B99883D277045 = "vtol_fight";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid1test_create_script");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script_completed");
  scripts\engine\utility::flag_set("cp_raid1test_create_script2");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script2_completed");
  level thread scripts\cp\cp_objectives::run_objective("kill_harrier");
}

checkpoint_player_spawns() {
  spawnpoints = [];
  _id_BCA7AE9B319C8C9A = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  foreach(struct in _id_BCA7AE9B319C8C9A) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_gauntlet_approach", og, angles);
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_vtol_spawned", og, angles);
  }

  return spawnpoints;
}

checkpoint_carepkg_spawns() {
  _id_03B819B9C304F403 = scripts\engine\utility::getStruct("test_loadout", "script_noteworthy");
  _id_20C5609F18D45157 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage_munitions("checkpoint_gauntlet_approach", _id_03B819B9C304F403, (0, 0, 0));
  return [_id_20C5609F18D45157];
}