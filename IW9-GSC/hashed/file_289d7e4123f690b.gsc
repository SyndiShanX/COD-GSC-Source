/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_289d7e4123f690b.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_nums_ready_puzzle", ::_id_966127732A6AD320);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_nums_ready_finale", ::_id_7636EFE8AA8905A1);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_966127732A6AD320() {
  level._id_E13D1DE65E306886 = 1;
}

_id_7636EFE8AA8905A1() {
  level._id_E13D1DE65E306886 = 1;
  level._id_922A06644812D5DE = 1;
}

checkpoint_player_spawns() {
  return [];
}

checkpoint_carepkg_spawns() {
  return [];
}