/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\airstrike_cp.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_mapselect;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace airstrike_cp;

function getmapselectweapon() {
  return "ks_remote_map_cp";
}

function init() {
  scripts\engine\utility::registersharedfunc("airstrike", "airstrike_params", &init_airstrike_params);
  scripts\engine\utility::registersharedfunc("airstrike", "getSelectMapPoint", &airstrike_getmapselectpoint);
  scripts\engine\utility::registersharedfunc("airstrike", "showErrorMessage", &airstrike_showerrormessage);
  scripts\engine\utility::registersharedfunc("airstrike", "startMapSelectSequence", &airstrike_startmapselectsequence);
  scripts\engine\utility::registersharedfunc("airstrike", "addSpawnDangerZone", &airstrike_addspawndangerzone);
  scripts\engine\utility::registersharedfunc("airstrike", "munitionUsed", &airstrike_munitionused);
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
  level.eairstrikeheight = getEntArray("airstrikeheight", "targetname")[0];

  if(!isDefined(level.eairstrikeheight)) {
    org = (-16, 0, 2576);
    level.eairstrikeheight = spawn("script_origin", org);
    level.eairstrikeheight.targetname = "airstrikeheight";
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return;
  } else {
    wait 10;
  }

  level.airstrikesettings["precision_airstrike"].deployweaponobj = makeweapon("iw8_spotter_scope_mp", ["spotterscope"]);
  level.airstrikesettings["multi_airstrike"].deployweaponobj = makeweapon("ks_remote_map_cp");
  level.airstrikesettings["fuel_airstrike"].deployweaponobj = makeweapon("ks_remote_map_cp");

  if(level.script == "cp_so_embassy") {
    level.airstrikesettings["precision_airstrike"].deployweaponobj = makeweapon("iw8_spotter_scope_mp", ["spotterscope_hybrid_thermal"]);
  }
}

function airstrike_getmapselectpoint(streakinfo, selectnum, directionalselection) {
  return scripts\cp\cp_mapselect::getselectmappoint(streakinfo, selectnum, directionalselection);
}

function airstrike_showerrormessage(string_ref) {}

function airstrike_startmapselectsequence(navmesh, directionalselection, directionaltype, streakinfo) {
  scripts\cp\cp_mapselect::startmapselectsequence(navmesh, directionalselection, directionaltype);
}

function airstrike_addspawndangerzone(pos, radius, height, friendlyteam, lifetime, playerowner, var_d4a6ace0dec22bae, parentent, var_41171640c23ae1c1) {}

function airstrike_munitionused(streakinfo, ignorecancel) {
  self notify("munitions_used", "precision_airstrike");

  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::showsplash("cp_used_precision_airstrike", undefined, self);
  }

  level.var_e4d9fc637e9f7d6b = streakinfo;
}