/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\white_phosphorus_cp.gsc
**********************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", &white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPoint", &white_phosphorus_getmapselectpoint);
}

function white_phosphorus_startmapselectsequence(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_mapselect::startmapselectsequence(var_0, var_1, var_2);
}

function white_phosphorus_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\cp\cp_mapselect::getselectmappoint(var_0, var_1, var_2);
}