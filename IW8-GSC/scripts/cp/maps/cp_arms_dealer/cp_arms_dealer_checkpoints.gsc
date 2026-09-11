/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_arms_dealer\cp_arms_dealer_checkpoints.gsc
*************************************************************************/

function ref_131ed() {
  level.getplunderextractionsites = &getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = &getnexthelimodule;
}

function getplatformweaponrankxpmultiplier() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, scripts\mp\brclientmatchdata::getnearbyaliveplayer("apce_p1", (-16234.3, 69.74, -319.609), (0, 360, 0)));
}

function getnexthelimodule() {
  var0 = scripts\mp\brclientmatchdata::getminigundamagescale("paladin", (-18402.5, 1317.09, -147.93), (0, 35.649, 0));
  var1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("apce_p1", (-16072, 64, -320.674), (0, 30, 0));
  var2 = scripts\mp\brclientmatchdata::getminigundamagescale("apce_p1", (-15932, 144, -320.674), (0, 200, 0));
  var3 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("arms_race_p1", (-2924.43, 10589.4, 43.8749), (0, 95.9991, 0));
  var4 = scripts\mp\brclientmatchdata::getminigundamagescale("arms_race_p1", (-3096.43, 10571.4, 43), (0, 107, 0));
  var5 = scripts\mp\brclientmatchdata::getminigundamagescale("crosswind", (-18692.5, 8453.77, -272.01), (0, 180, 0));
  return [var0, var1, var2, var3, var4, var5];
}

function c4_obj_and_progress() {
  if(!scripts\engine\utility::flag_exist("cp_payloadobjective_cs_completed")) {
    scripts\engine\utility::flag_init("cp_payloadobjective_cs_completed");
  }

  scripts\engine\utility::flag_wait("objectives_registered");

  while(!scripts\engine\utility::flag_exist("cp_payloadobjective_cs")) {
    waitframe();
  }

  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  thread scripts\cp\cp_objectives::run_objective("obj_payload", "primary");
}

function camera_loadout_showcase_preview_large_sticker_alt2() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("obj_armsrace", "primary");
}

function ref_11c5c() {}