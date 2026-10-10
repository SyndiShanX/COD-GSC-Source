/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\emp_drone_targeted_mp.gsc
***************************************************************/

#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\mapselect;
#namespace emp_drone_targeted_mp;

function init() {
  scripts\engine\utility::registersharedfunc("empDroneTargeted", "getSelectMapPoint", &emp_drone_targeted_getmapselectpoint);
  scripts\engine\utility::registersharedfunc("empDroneTargeted", "startMapSelectSequence", &emp_drone_targeted_startmapselectsequence);
  scripts\engine\utility::registersharedfunc("empDroneTargeted", "monitorDamage", &emp_drone_targeted_monitordamage);
}

function emp_drone_targeted_getmapselectpoint(streakinfo, selectnum, directionalselection) {
  return scripts\mp\killstreaks\mapselect::function_a5839924b6723eac(streakinfo, selectnum, directionalselection);
}

function emp_drone_targeted_startmapselectsequence(navmesh, directionalselection, directionaltype, selectortype) {
  scripts\mp\killstreaks\mapselect::function_90f093ca8576232f(navmesh, directionalselection, directionaltype, selectortype);
}

function emp_drone_targeted_monitordamage(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken);
}