/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp_drone_targeted_mp.gsc
************************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "getSelectMapPoint", &emp_drone_targeted_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "startMapSelectSequence", &emp_drone_targeted_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "monitorDamage", &emp_drone_targeted_monitordamage);
}

function emp_drone_targeted_getmapselectpoint(var0, var1, var2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var0, var1, var2);
}

function emp_drone_targeted_startmapselectsequence(var0, var1, var2, var3) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var0, var1, var2, var3);
}

function emp_drone_targeted_monitordamage(var0, var1, var2, var3, var4, var5, var6) {
  scripts\mp\damage::monitordamage(var0, var1, var2, var3, var4, var5, var6);
}