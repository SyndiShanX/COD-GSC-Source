/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\scriptable.gsc
***********************************************/

scriptable_initialize() {
  scripts\engine\scriptable::scriptable_engineinitialize();
}

scriptable_post_initialize() {
  scripts\engine\scriptable::scriptable_enginepostinitialize();
}

scriptable_used(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\scriptable::scriptable_engineused(var_0, var_1, var_2, var_3, var_4, var_5);
}

riotshield_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\engine\scriptable::_id_12F69(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

scriptable_touched(var_0, var_1, var_2, var_3) {
  scripts\engine\scriptable::scriptable_enginetouched(var_0, var_1, var_2, var_3);
}

scriptable_notify_callback(var_0, var_1, var_2) {
  scripts\engine\scriptable::scriptable_enginenotifycallback(var_0, var_1, var_2);
}