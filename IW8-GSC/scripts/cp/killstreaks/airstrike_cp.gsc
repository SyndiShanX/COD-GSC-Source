/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airstrike_cp.gsc
***************************************************/

function getmapselectweapon() {
  return "ks_remote_map_cp";
}

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "airstrike_params", &init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "getSelectMapPoint", &airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "showErrorMessage", &airstrike_showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "startMapSelectSequence", &airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "addSpawnDangerZone", &airstrike_addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "munitionUsed", &airstrike_munitionused);
}

function init_airstrike_params() {
  level.airstrikesettings = [];
  level.airstrikesettings["precision_airstrike"] = spawnStruct();
  level.airstrikesettings["precision_airstrike"].streakname = "precision_airstrike";
  level.airstrikesettings["precision_airstrike"].modelbase = "veh8_mil_air_alfa10";
  level.airstrikesettings["precision_airstrike"].modelbasealt = "veh8_mil_air_alfa10_east";
  level.airstrikesettings["multi_airstrike"] = spawnStruct();
  level.airstrikesettings["multi_airstrike"].streakname = "multi_airstrike";
  level.airstrikesettings["multi_airstrike"].modelbase = "veh8_mil_air_alfa10";
  level.airstrikesettings["fuel_airstrike"] = spawnStruct();
  level.airstrikesettings["fuel_airstrike"].streakname = "fuel_airstrike";
  level.airstrikesettings["fuel_airstrike"].modelbase = "veh8_mil_air_suniform25";
  level.eairstrikeheight = getEnt("airstrikeheight", "targetname");

  if(!isDefined(level.eairstrikeheight)) {
    var_0 = (-16, 0, 2576);
    level.eairstrikeheight = spawn("script_origin", var_0);
    level.eairstrikeheight.targetname = "airstrikeheight";
  }

  if(getdvarint("LLQQOPKTKM", 0) == 1) {
    return;
  } else {
    wait 10;
  }

  level.airstrikesettings["precision_airstrike"].deployweaponobj = getcompleteweaponname("iw8_spotter_scope_mp", ["spotterscope"]);
  level.airstrikesettings["multi_airstrike"].deployweaponobj = getcompleteweaponname("ks_remote_map_cp");
  level.airstrikesettings["fuel_airstrike"].deployweaponobj = getcompleteweaponname("ks_remote_map_cp");

  if(level.script == "cp_so_embassy") {
    level.airstrikesettings["precision_airstrike"].deployweaponobj = getcompleteweaponname("iw8_spotter_scope_mp", ["spotterscope_hybrid_thermal"]);
    return;
  }
}

function airstrike_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\cp\cp_mapselect::getselectmappoint(var_0, var_1, var_2);
}

function airstrike_showerrormessage(var_0) {}

function airstrike_startmapselectsequence(var_0, var_1, var_2) {
  scripts\cp\cp_mapselect::startmapselectsequence(var_0, var_1, var_2);
}

function airstrike_addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

function airstrike_munitionused(var_0, var_1) {
  self notify("munitions_used", "precision_airstrike");

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\cp_hud_message::showsplash("cp_used_precision_airstrike", undefined, self);
  }
}