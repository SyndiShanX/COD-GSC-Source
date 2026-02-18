/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_40859a8b9c8becd.gsc
***********************************************/

#using scripts\core_common\array_shared;
#namespace namespace_1125e192;

function function_93c5a24() {
  if(!isDefined(level.hotzones)) {
    return;
  }

  if(!getdvarint(#"hash_1429e62553e102ab", 0)) {
    if(!is_true(getgametypesetting(#"hash_34c2c463f81af043"))) {
      return;
    }

    if(randomintrangeinclusive(1, 100) > level.realm * 3) {
      return;
    }
  }

  level.var_2c56b3ec = array::random(level.hotzones);

  level thread function_ace23f69(level.var_2c56b3ec.origin);
}

function function_ace23f69(v_loc) {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(isDefined(v_loc)) {
    sphere(v_loc, 32, (1, 0, 0), undefined, undefined, undefined, 10);
    waitframe(10);
  }
}