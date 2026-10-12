/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_door.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace scriptable_door;

function system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }

  level.scriptable_door_initialized = 1;
}

function function_29ba88e5ce21f3fd(var_8886a1f80d549ed) {
  level.var_be09cad9b5d91063 = var_8886a1f80d549ed;
}

function function_e37078f3d00ef312(canunlockcallback) {
  level.var_d9a4b8ae6fa68979 = canunlockcallback;
}

function function_87d7be37d61cbae3(unlockedcallback) {
  level.door_unlocked = unlockedcallback;
}

function function_9f2d576809f96d2e(instance, player) {
  if(isDefined(level.var_be09cad9b5d91063)) {
    return [[level.var_be09cad9b5d91063]](instance, player);
  }

  return &"";
}

function function_47a1e5b6a230d71f(instance, player, var_85e3240d30e184e7) {
  if(isDefined(level.var_d9a4b8ae6fa68979)) {
    return [[level.var_d9a4b8ae6fa68979]](instance, player, var_85e3240d30e184e7);
  }

  return 0;
}

function function_7e3b4de29e022cea(instance, player) {
  if(isDefined(level.door_unlocked)) {
    [[level.door_unlocked]](instance, player);
  }
}