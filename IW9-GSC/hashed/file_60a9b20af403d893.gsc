/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_60a9b20af403d893.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_0BB848A1122EC21B() {
  switch (self.start) {
    case "support_heli_monument":
      level thread _id_9E10A8CCA3D36B8D();
      break;
    case "support_heli_house":
      level thread _id_E4C00EEFAFF67902();
      break;
    case "support_heli_mid":
      break;
    case "support_heli_gasstaation":
      level thread _id_F7F3CE6AE1E4CA8B();
      break;
    case "support_heli_blueroof":
      level thread _id_61331B73B6301606();
      break;
    case "support_heli_escape":
    case "support_heli_culdesac":
      level thread _id_EA9B50FEF7A93398();
      break;
    case "support_heli_profile":
      level thread _id_DEF2D42F192BA7EB();
      break;
    default:
      break;
  }
}

_id_9E10A8CCA3D36B8D() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 3;
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_monument");
}

_id_E4C00EEFAFF67902() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 3;
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_house");
}

_id_F7F3CE6AE1E4CA8B() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 3;
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_gasstaation");
}

_id_61331B73B6301606() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 3;
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_blueroof");
}

_id_EA9B50FEF7A93398() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 3;
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_culdesac");
}

_id_DEF2D42F192BA7EB() {
  while(level.players.size <= 0)
    waitframe();

  player = level.players[0];
  scripts\engine\utility::flag_set("cp_heli_escort_cs");
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  level waittill("player_spawned_with_loadout");
  thread _id_4C2E15BC834E979B::_id_A0B7EBEEA70BC3C2();
  wait 2;
  thread _id_4C2E15BC834E979B::_id_853250DD0C223884(player);
  level waittill("forever");
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