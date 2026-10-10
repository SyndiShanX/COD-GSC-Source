/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_10e910b749a22d35.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\dvars;
#using scripts\mp\weapons;
#namespace perk_staminup;

function function_e7866458a76d3194(str_currency, var_fe59c44529c721a0) {
  level thread function_f3a23df892bf82f6("specialty_staminup", str_currency, var_fe59c44529c721a0, &function_bb6c42516338413b, &function_bd187786deecd41d);
  level thread function_44f47de92eab835d();
}

function function_44f47de92eab835d() {
  waitframe();
  registerscriptperk("specialty_zombies_lightweight", &function_511c457470bcb996, &function_f48647121583369b);
}

function function_bb6c42516338413b() {
  function_7153488861bda17e();
}

function function_bd187786deecd41d(b_pause, str_perk, str_result, n_slot) {
  function_a0af73943eed3890();
}

function function_7153488861bda17e() {
  function_ab7a3ff9f75e4867("specialty_staminup");
}

function function_a0af73943eed3890() {
  function_fe0d28e6f0008329("specialty_staminup");
}

function function_511c457470bcb996() {
  perkbundle = level.perkbundles["specialty_staminup"];
  speedincrease = default_to(perkbundle.var_926b825efb2d70d2, 0.05);
  scripts\mp\weapons::addextramovespeed("specialty_staminup", speedincrease);
  scripts\mp\weapons::updatemovespeedscale();
}

function function_f48647121583369b() {
  scripts\mp\weapons::removeextramovespeed("specialty_staminup");
  scripts\mp\weapons::updatemovespeedscale();
}