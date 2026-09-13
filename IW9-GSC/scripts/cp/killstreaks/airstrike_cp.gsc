/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airstrike_cp.gsc
***************************************************/

getmapselectweapon() {
  return "ks_remote_map_cp";
}

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "airstrike_params", ::init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "getSelectMapPoint", ::airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "showErrorMessage", ::airstrike_showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "startMapSelectSequence", ::airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "addSpawnDangerZone", ::airstrike_addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "munitionUsed", ::airstrike_munitionused);
}

init_airstrike_params() {
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
    org = (-16, 0, 2576);
    level.eairstrikeheight = spawn("script_origin", org);
    level.eairstrikeheight.targetname = "airstrikeheight";
  }

  if(getdvarint("r_reflectionprobegenerate", 0) == 1)
    return;
  else
    wait 10;

  level.airstrikesettings["precision_airstrike"].deployweaponobj = makeweapon("iw8_spotter_scope_mp", ["spotterscope"]);
  level.airstrikesettings["multi_airstrike"].deployweaponobj = makeweapon("ks_remote_map_cp");
  level.airstrikesettings["fuel_airstrike"].deployweaponobj = makeweapon("ks_remote_map_cp");

  if(level.script == "cp_so_embassy")
    level.airstrikesettings["precision_airstrike"].deployweaponobj = makeweapon("iw8_spotter_scope_mp", ["spotterscope_hybrid_thermal"]);
}

airstrike_getmapselectpoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  return scripts\cp\cp_mapselect::getselectmappoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);
}

airstrike_showerrormessage(_id_162260368C7D30DE) {}

airstrike_startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, streakinfo) {
  scripts\cp\cp_mapselect::startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3);
}

airstrike_addspawndangerzone(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_D4A6ACE0DEC22BAE, _id_539C2DCC0A467746, _id_41171640C23AE1C1) {}

airstrike_munitionused(streakinfo, _id_6152D24062D26039) {
  self notify("munitions_used", "precision_airstrike");

  foreach(player in level.players)
  player thread scripts\cp\cp_hud_message::showsplash("cp_used_precision_airstrike", undefined, self);
}