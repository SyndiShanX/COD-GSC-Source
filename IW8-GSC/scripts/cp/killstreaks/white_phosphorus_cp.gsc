/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\white_phosphorus_cp.gsc
**********************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", &white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPoint", &white_phosphorus_getmapselectpoint);
}

function white_phosphorus_startmapselectsequence(var0, var1, var2, var3) {
  scripts\cp\cp_mapselect::startmapselectsequence(var0, var1, var2);
}

function white_phosphorus_getmapselectpoint(var0, var1, var2) {
  return scripts\cp\cp_mapselect::getselectmappoint(var0, var1, var2);
}