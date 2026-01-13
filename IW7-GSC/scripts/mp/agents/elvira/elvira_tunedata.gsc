/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\elvira\elvira_tunedata.gsc
********************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["elvira"] = spawnStruct();
  setupmytunedata(level.agenttunedata["elvira"]);
}

setupmytunedata(var_0) {
  var_0.revive_right_offset = 32;
  var_0.revive_forward_offset = 60;
  var_0.max_revive_snapp_2d_dist_sq = 64;
  var_0.max_revive_snap_z_dist = 32;
  var_0.max_revive_search_dist_sq = 2250000;
  var_0.revive_wait_time = 2;
  var_0.min_time_between_revivals = 5000;
  var_0.min_time_between_revivals_solo = 10000;
  var_0.max_dist_to_revive_player_sq = 10000;
  var_0.melee_max_z_diff = 60;
  var_0.melee_attack_range_sq = 30625;
  var_0.desiredenemydistmax = 500;
  var_0.desiredenemydistmin = 400;
  var_0.maxtimetostrafewithoutlos = 3000;
  var_0.strafeifwithindist = var_0.desiredenemydistmax + 100;
  var_0.backawayenemydist = var_0.desiredenemydistmin - 100;
  var_0.backupdist = 100;
  var_0.max_dist_from_closest_player_in_combat_sq = 250000;
  var_0.max_dist_from_closest_player_sq = 16384;
  var_0.return_to_closest_player_dist_in_combat_sq = 90000;
  var_0.return_to_closest_player_dist_sq = 12100;
  var_0.check_for_closest_player_interval_ms = 1000;
  var_0.max_dist_for_spell_cast_sq = 562500;
  var_0.init_spellcast_delay = 10000;
  var_0.spellcast_interval = 15000;
  var_0.max_enemy_spell_radius_sq = 262144;
  var_0.min_enemies_for_spellcast = 1;
  var_0.lifespan = 120000;
  var_0.max_teleport_lookahead_dist = 600;
}

gettunedata() {
  return level.agenttunedata["elvira"];
}