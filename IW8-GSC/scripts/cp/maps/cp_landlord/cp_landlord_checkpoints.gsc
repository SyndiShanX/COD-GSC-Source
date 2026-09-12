/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_landlord\cp_landlord_checkpoints.gsc
*******************************************************************/

function ref_131ED() {
  level.getplunderextractionsites = &getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = &getnexthelimodule;
}

function getplatformweaponrankxpmultiplier() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, scripts\mp\brclientmatchdata::getnearbyaliveplayer("tmtyl_p1", (23048, 9186, -448), (0, 313, 0)));
}

function getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("headhunter", (16013, -4376, 1616), (0, 0, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("tmtyl_p1", (23359.3, 8854.99, -452.166), (1.30863, 139.975, -1.14992));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("tmtyl_p1", (23186.3, 8711, -451.166), (0, 240, 0));
  var_3 = scripts\mp\brclientmatchdata::getminigundamagescale("airfield", (4015, 61279.5, 767), (0, 90, 0));
  return [var_0, var_1, var_2, var_3];
}

function getplatformrankxpmultiplier() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  thread scripts\cp\cp_objectives::run_objective("obj_overwatch", "primary");
}

function ref_11C5B() {}

function ref_11C5C() {}