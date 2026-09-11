/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airstrike_mp.gsc
***************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("precision_airstrike", &scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("multi_airstrike", &scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("fuel_airstrike", &scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "airstrike_params", &init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "getSelectMapPoint", &airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "startMapSelectSequence", &airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "addSpawnDangerZone", &airstrike_addspawndangerzone);
}

function init_airstrike_params() {
  level.airstrikesettings = [];
  var0 = "veh8_mil_air_alfa10";
  var1 = "veh8_mil_air_alfa10_east";

  if(scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var0 = "plane_juniform87";
    var1 = "plane_juniform87";
  }

  level.airstrikesettings["precision_airstrike"] = spawnStruct();
  level.airstrikesettings["precision_airstrike"].streakname = "precision_airstrike";
  level.airstrikesettings["precision_airstrike"].modelbase = var0;
  level.airstrikesettings["precision_airstrike"].modelbasealt = var1;
  var2 = "iw8_spotter_scope_mp";

  if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
    var2 = "iw8_spotter_scope_mp_ch3";
  }

  level.airstrikesettings["precision_airstrike"].deployweaponobj = getcompleteweaponname(var2, ["spotterscope"]);
  level.airstrikesettings["multi_airstrike"] = spawnStruct();
  level.airstrikesettings["multi_airstrike"].streakname = "multi_airstrike";
  level.airstrikesettings["multi_airstrike"].modelbase = "veh8_mil_air_alfa10";
  level.airstrikesettings["multi_airstrike"].deployweaponobj = getcompleteweaponname(scripts\mp\killstreaks\mapselect::getmapselectweapon());
  level.airstrikesettings["fuel_airstrike"] = spawnStruct();
  level.airstrikesettings["fuel_airstrike"].streakname = "fuel_airstrike";
  level.airstrikesettings["fuel_airstrike"].modelbase = "veh8_mil_air_suniform25";
  level.airstrikesettings["fuel_airstrike"].deployweaponobj = getcompleteweaponname(scripts\mp\killstreaks\mapselect::getmapselectweapon());
}

function airstrike_getmapselectpoint(var0, var1, var2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var0, var1, var2);
}

function airstrike_startmapselectsequence(var0, var1, var2) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var0, var1, var2);
}

function airstrike_addspawndangerzone(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  scripts\mp\spawnlogic::addspawndangerzone(var0, var1, var2, var3, var4, var5, var6, var7, var8);
}