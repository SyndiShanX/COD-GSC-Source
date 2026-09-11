/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gxp_challenges.gsc
***************************************************************/

function ref_11fef(var_0) {
  ref_12c3a(var_0, "t9_ch_common_season_6_wz_event_challenge_6");
}

function ref_11ff1(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_1) || !isDefined(var_2)) {
    return;
  }

  if(!isPlayer(var_2)) {
    return;
  }

  if(var_1.team == var_2.team) {
    return;
  }

  var_3 = var_1 scripts\mp\gametypes\br_public::ref_125ec();
  var_4 = var_2 scripts\mp\gametypes\br_public::ref_125ec();

  if(!var_4 && !var_3) {
    ref_12c3a(var_2, "t9_ch_common_season_6_wz_event_challenge_4");
    return;
  }

  if(!var_4 && var_3) {
    ref_12c3a(var_2, "t9_ch_common_season_6_wz_event_challenge_3");
    return;
  }

  if(var_4 && !var_3) {
    ref_12c3a(var_2, "t9_ch_common_season_6_wz_event_challenge_5");
    return;
  }
}

function ref_11ff0(var_0, var_1) {
  var_2 = level.disable_super_in_turret.setsuperisinuse[0].ref_13db4;
  var_3 = var_0 scripts\mp\gametypes\br_gxp_fear::remove_flag_trig();

  if(var_3 < var_2) {
    return;
  }

  ref_12c3a(var_0, "t9_ch_common_season_6_wz_event_challenge_9");
}

function ref_11fee(var_0, var_1) {
  if(!isDefined(var_1.id)) {
    return;
  }

  if(!isDefined(var_0.ref_12e77)) {
    var_0.ref_12e77 = [];
  }

  foreach(var_3 in var_0.ref_12e77) {
    if(var_3 == var_1.id) {
      return;
    }
  }

  var_0.ref_12e77[var_0.ref_12e77.size] = var_1.id;
  ref_12c3a(var_0, "t9_ch_common_season_6_wz_event_challenge_7");
}

function ref_11fd2(var_0) {
  ref_12c3a(var_0, "t9_ch_common_season_6_wz_event_challenge_8");
}

function ref_12c3a(var_0, var_1) {
  if(!isDefined(level.getallactivequestsforteam) || level.getallactivequestsforteam < 12) {
    return;
  }

  if(!var_0 scripts\cp\vehicles\vehicle_compass_cp::challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.name) || level.disable_super_in_turret.name != "gxp") {
    return;
  }

  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f(var_1, 1);
}