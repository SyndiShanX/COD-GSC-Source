/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2610.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("precision_airstrike", _id_09AB::_id_F76A);
  scripts\mp\killstreaks\killstreaks::_id_C26A("multi_airstrike", _id_09AB::_id_F76A);
  scripts\mp\killstreaks\killstreaks::_id_C26A("fuel_airstrike", _id_09AB::_id_F76A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "airstrike_params", ::_id_7EBC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "getSelectMapPoint", ::_id_13C2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "startMapSelectSequence", ::_id_13D2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "addSpawnDangerZone", ::_id_13BE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "monitorDamage", _id_07C3::_id_A0FF);
}

_id_7EBC() {
  level._id_13E3 = [];
  level._id_13E3["precision_airstrike"] = spawnStruct();
  level._id_13E3["precision_airstrike"].streakname = "precision_airstrike";
  level._id_13E3["precision_airstrike"].modelbase = "plane_wm_dalpha_articulated_01";
  level._id_13E3["precision_airstrike"]._id_9FD1 = "plane_wm_dalpha_articulated_01";
  level._id_13E3["precision_airstrike"]._id_47EE = makeweapon("s4_binoculars_mp", ["spotterscope"]);
  level._id_13E3["precision_airstrike"]._id_B18D = 600;
  level._id_13E3["precision_airstrike"]._id_10CCF = "v_ui_hud_marker_killstreak_02";
  level._id_13E3["toma_strike"] = spawnStruct();
  level._id_13E3["toma_strike"].streakname = "toma_strike";
  level._id_13E3["toma_strike"].modelbase = "bomber_hecho177_00_vista";
  level._id_13E3["toma_strike"]._id_9FD1 = "bomber_hecho177_00_vista";
  level._id_13E3["toma_strike"]._id_47EE = makeweapon("s4_binoculars_mp", ["spotterscope"]);
  level._id_13E3["toma_strike"]._id_B18D = 6000;
  level._id_13E3["toma_strike"]._id_10CCF = "v_ui_hud_marker_killstreak_01";
}

_id_13C2(var_0, var_1, var_2) {
  return _id_0A54::_id_6D1F(var_0, var_1, var_2);
}

_id_13D2(var_0, var_1, var_2) {
  _id_0A54::_id_E6E4(var_0, var_1, var_2);
}

_id_13BE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_0817::_id_1135(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}