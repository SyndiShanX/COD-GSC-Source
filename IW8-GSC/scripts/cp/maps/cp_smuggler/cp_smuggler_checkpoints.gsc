/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_checkpoints.gsc
*******************************************************************/

function ref_131ed() {
  level.getplunderextractionsites = &getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = &getnexthelimodule;
}

function getplatformweaponrankxpmultiplier() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, scripts\mp\brclientmatchdata::getnearbyaliveplayer("tow_p1", (9492.81, 29096.4, 1147.75), (0, 44.9994, 0)));
}

function getnexthelimodule() {
  var0 = scripts\mp\brclientmatchdata::getminigundamagescale("smuggler_1", (-4170, 33407, 206), (0, 60.096, 0));
  var1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("tow_p1", (9797.73, 29319.9, 1176.06), (1.08426, 209.978, -1.1709));
  var2 = scripts\mp\brclientmatchdata::getminigundamagescale("tow_p1", (9695.73, 29341.9, 1170.06), (354.438, 337.89, 2.255));
  var3 = scripts\mp\brclientmatchdata::getminigundamagescale("smuggler_2", (22819, 29131, 1089.5), (0, 180, 0));
  var4 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("convoy4_secure_tower", (32823, 41662, 706), (1.08426, 0, -1.1709));
  var5 = scripts\mp\brclientmatchdata::getminigundamagescale("convoy4_secure_tower", (32963, 41558, 706), (0, 298, 0));
  return [var0, var1, var2, var4, var5, var3];
}

function ref_11c58() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("obj_tug_of_war", "primary");
}

function ref_11c5b() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("convoy4_secure_tower", "primary");
}

function ref_11c5c() {}