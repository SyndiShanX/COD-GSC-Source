/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp_drone_targeted_mp.gsc
************************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "getSelectMapPoint", &emp_drone_targeted_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "startMapSelectSequence", &emp_drone_targeted_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "monitorDamage", &emp_drone_targeted_monitordamage);
}

function emp_drone_targeted_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1, var_2);
}

function emp_drone_targeted_startmapselectsequence(var_0, var_1, var_2, var_3) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var_0, var_1, var_2, var_3);
}

function emp_drone_targeted_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\mp\damage::monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}