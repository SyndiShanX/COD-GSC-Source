/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints.gsc
*********************************************************************/

function ref_131ED() {
  level.getplunderextractionsites = &getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = &getnexthelimodule;
}

function getplatformweaponrankxpmultiplier() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, scripts\mp\brclientmatchdata::getnearbyaliveplayer("ml_p1", (20185.7, -9432.83, -351.636), (0, 55, 0)));
}

function getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("justreward", (19303.5, -21674, -16.25), (0, 314.408, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("ml_p1", (20106.7, -9039.42, -360), (0, 45, 0));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("ml_p1", (20053.7, -9080.83, -360), (0, 135, 0));
  var_3 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("ml_p2", (27296, -5870.12, -456), (0, 135, 0));
  var_4 = scripts\mp\brclientmatchdata::getminigundamagescale("ml_p2", (27192, -5800.12, -456), (0, 73, 0));
  var_5 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("ml_p3", (19151.4, -10911.9, -355.274), (0, 135, 0));
  var_6 = scripts\mp\brclientmatchdata::getminigundamagescale("ml_p3", (18961.4, -11083.9, -344.274), (358.035, 178.999, 2.035));
  var_7 = scripts\mp\brclientmatchdata::getminigundamagescale("strongbox", (30192.3, -8168.76, -423), (0, 20, 0));
  return [var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7];
}

function ref_11C58() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("ml_p2_get_heli", "primary");
}

function ref_11C5B() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  level.getoverridedvarexceptmatchrulesvalues = "ml_p2_secure_loc";
  thread scripts\cp\cp_objectives::run_objective("ml_p2_secure_loc", "primary");
}

function ref_11C5C() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("ml_p3_intel", "primary");
}