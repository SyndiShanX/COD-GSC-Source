/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\elvira\elvira_tunedata.gsc
********************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["elvira"] = spawnStruct();
  setupmytunedata(level.agenttunedata["elvira"]);
}

setupmytunedata(param_00) {
  param_00.revive_right_offset = 32;
  param_00.revive_forward_offset = 60;
  param_00.max_revive_snapp_2d_dist_sq = 64;
  param_00.max_revive_snap_z_dist = 32;
  param_00.max_revive_search_dist_sq = 2250000;
  param_00.revive_wait_time = 2;
  param_00.min_time_between_revivals = 5000;
  param_00.min_time_between_revivals_solo = 10000;
  param_00.max_dist_to_revive_player_sq = 10000;
  param_00.melee_max_z_diff = 60;
  param_00.melee_attack_range_sq = 30625;
  param_00.desiredenemydistmax = 500;
  param_00.desiredenemydistmin = 400;
  param_00.maxtimetostrafewithoutlos = 3000;
  param_00.strafeifwithindist = param_00.desiredenemydistmax + 100;
  param_00.backawayenemydist = param_00.desiredenemydistmin - 100;
  param_00.backupdist = 100;
  param_00.max_dist_from_closest_player_in_combat_sq = 250000;
  param_00.max_dist_from_closest_player_sq = 16384;
  param_00.return_to_closest_player_dist_in_combat_sq = 90000;
  param_00.return_to_closest_player_dist_sq = 12100;
  param_00.check_for_closest_player_interval_ms = 1000;
  param_00.max_dist_for_spell_cast_sq = 562500;
  param_00.init_spellcast_delay = 10000;
  param_00.spellcast_interval = 15000;
  param_00.max_enemy_spell_radius_sq = 262144;
  param_00.min_enemies_for_spellcast = 1;
  param_00.lifespan = 120000;
  param_00.max_teleport_lookahead_dist = 600;
}

gettunedata() {
  return level.agenttunedata["elvira"];
}