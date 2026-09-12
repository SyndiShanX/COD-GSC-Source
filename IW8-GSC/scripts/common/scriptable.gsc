/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\scriptable.gsc
***********************************************/

function scriptable_initialize() {
  scripts\engine\scriptable::scriptable_engineinitialize();
}

function scriptable_post_initialize() {
  scripts\engine\scriptable::scriptable_enginepostinitialize();
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\scriptable::scriptable_engineused(var_0, var_1, var_2, var_3, var_4, var_5);
}

function riotshield_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\engine\scriptable::ref_12F69(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

function scriptable_touched(var_0, var_1, var_2, var_3) {
  scripts\engine\scriptable::scriptable_enginetouched(var_0, var_1, var_2, var_3);
}

function scriptable_notify_callback(var_0, var_1, var_2) {
  scripts\engine\scriptable::scriptable_enginenotifycallback(var_0, var_1, var_2);
}