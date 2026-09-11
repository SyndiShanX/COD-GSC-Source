/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gxp_challenges.gsc
***************************************************************/

function ref_11fef(var0) {
  ref_12c3a(var0, "t9_ch_common_season_6_wz_event_challenge_6");
}

function ref_11ff1(var0) {
  var1 = var0.victim;
  var2 = var0.attacker;

  if(!isDefined(var1) || !isDefined(var2)) {
    return;
  }

  if(!isPlayer(var2)) {
    return;
  }

  if(var1.team == var2.team) {
    return;
  }

  var3 = var1 scripts\mp\gametypes\br_public::ref_125ec();
  var4 = var2 scripts\mp\gametypes\br_public::ref_125ec();

  if(!var4 && !var3) {
    ref_12c3a(var2, "t9_ch_common_season_6_wz_event_challenge_4");
    return;
  }

  if(!var4 && var3) {
    ref_12c3a(var2, "t9_ch_common_season_6_wz_event_challenge_3");
    return;
  }

  if(var4 && !var3) {
    ref_12c3a(var2, "t9_ch_common_season_6_wz_event_challenge_5");
    return;
  }
}

function ref_11ff0(var0, var1) {
  var2 = level.disable_super_in_turret.setsuperisinuse[0].ref_13db4;
  var3 = var0 scripts\mp\gametypes\br_gxp_fear::remove_flag_trig();

  if(var3 < var2) {
    return;
  }

  ref_12c3a(var0, "t9_ch_common_season_6_wz_event_challenge_9");
}

function ref_11fee(var0, var1) {
  if(!isDefined(var1.id)) {
    return;
  }

  if(!isDefined(var0.ref_12e77)) {
    var0.ref_12e77 = [];
  }

  foreach(var3 in var0.ref_12e77) {
    if(var3 == var1.id) {
      return;
    }
  }

  var0.ref_12e77[var0.ref_12e77.size] = var1.id;
  ref_12c3a(var0, "t9_ch_common_season_6_wz_event_challenge_7");
}

function ref_11fd2(var0) {
  ref_12c3a(var0, "t9_ch_common_season_6_wz_event_challenge_8");
}

function ref_12c3a(var0, var1) {
  if(!isDefined(level.getallactivequestsforteam) || level.getallactivequestsforteam < 12) {
    return;
  }

  if(!var0 scripts\cp\vehicles\vehicle_compass_cp::challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.name) || level.disable_super_in_turret.name != "gxp") {
    return;
  }

  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f(var1, 1);
}