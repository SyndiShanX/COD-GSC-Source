/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airstrike_mp.gsc
***************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("precision_airstrike", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("multi_airstrike", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("fuel_airstrike", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "airstrike_params", ::init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "getSelectMapPoint", ::airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "startMapSelectSequence", ::airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "addSpawnDangerZone", ::airstrike_addspawndangerzone);
}

init_airstrike_params() {
  level.airstrikesettings = [];
  level.airstrikesettings["precision_airstrike"] = spawnStruct();
  level.airstrikesettings["precision_airstrike"].streakname = "precision_airstrike";
  level.airstrikesettings["precision_airstrike"].modelbase = "veh8_mil_air_alfa10";
  level.airstrikesettings["precision_airstrike"]._id_C80E3EA2A37A7182 = "ks_airstrike_mp";
  level.airstrikesettings["precision_airstrike"].deployweaponobj = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_spotter_scope_mp");
  level.airstrikesettings["multi_airstrike"] = spawnStruct();
  level.airstrikesettings["multi_airstrike"].streakname = "multi_airstrike";
  level.airstrikesettings["multi_airstrike"].modelbase = "veh8_mil_air_alfa10";
  level.airstrikesettings["multi_airstrike"]._id_C80E3EA2A37A7182 = "ks_airstrike_mp";
  level.airstrikesettings["multi_airstrike"].deployweaponobj = makeweapon(scripts\mp\killstreaks\mapselect::_id_5D9830F341FBD83A());
  level.airstrikesettings["fuel_airstrike"] = spawnStruct();
  level.airstrikesettings["fuel_airstrike"].streakname = "fuel_airstrike";
  level.airstrikesettings["fuel_airstrike"].modelbase = "veh9_mil_air_suniform25_mp";
  level.airstrikesettings["fuel_airstrike"]._id_C80E3EA2A37A7182 = "ks_fuelstrike_mp";
  level.airstrikesettings["fuel_airstrike"].deployweaponobj = makeweapon(scripts\mp\killstreaks\mapselect::_id_5D9830F341FBD83A());
}

airstrike_getmapselectpoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  self playlocalsound("iw9_ks_tablet_ui_screen_plr");
  return scripts\mp\killstreaks\mapselect::_id_A5839924B6723EAC(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);
}

airstrike_startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8, streakinfo) {
  scripts\mp\killstreaks\mapselect::_id_90F093CA8576232F(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8, streakinfo);
}

airstrike_addspawndangerzone(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_D4A6ACE0DEC22BAE, _id_539C2DCC0A467746, _id_41171640C23AE1C1) {
  scripts\mp\spawnlogic::addspawndangerzone(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_D4A6ACE0DEC22BAE, _id_539C2DCC0A467746, _id_41171640C23AE1C1);
}