/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\pamgrier\pamgrier_tunedata.gsc
************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["pamgrier"] = spawnStruct();
  setuppamgriertunedata(level.agenttunedata["pamgrier"]);
}

setuppamgriertunedata(var_0) {
  var_0.min_time_between_attacks = 1000;
  var_0.max_time_between_attacks = 2000;
  var_0.min_chillin_time = 15000;
  var_0.max_chillin_time = 25000;
  var_0.max_non_chillin_time = 10000;
  var_0.chill_time_before_going_passive = 8;
  var_0.min_moving_pain_dist = 128;
  var_0.target_agent_types = [];
  var_0.target_agent_types[0] = "karatemaster";
  var_0.target_agent_types[1] = "generic_zombie";
  var_0.min_target_path_dist_to_goal = 100;
  var_0.teleport_behind_target_dist = 24;
  var_0.teleport_attack_dist_to_target = 50;
  var_0.telefrag_dist_sq = 1600;
  var_0.navmesh_correction_dist_sq = 16;
  var_0.player_too_close_teleport_dist_sq = 1600;
  var_0.max_teleports_per_chill = 3;
  var_0.melee_attack_range_sq = 30625;
  var_0.revive_right_offset = 32;
  var_0.revive_forward_offset = 60;
  var_0.max_revive_snapp_2d_dist_sq = 64;
  var_0.max_revive_snap_z_dist = 32;
  var_0.revive_wait_time = 2;
  var_0.min_time_between_revivals = 5000;
  var_0.min_time_between_revivals_solo = -5536;
  var_0.max_dist_to_revive_player_sq = 10000;
  var_0.max_time_to_attack_targets_when_player_needs_revive_ms = 4000;
  var_0.min_wait_time = 500;
  var_0.max_wait_time = 1000;
  var_0.min_wait_time_before_teleport = 1000;
  var_0.min_wait_for_twitch_time = 2;
  var_0.max_wait_for_twitch_time = 4.5;
}

gettunedata() {
  return level.agenttunedata["pamgrier"];
}