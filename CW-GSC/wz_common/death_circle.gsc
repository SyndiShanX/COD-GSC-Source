/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\death_circle.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\wz_common\util;
#namespace death_circle;

function init_vo() {
  callback::add_callback(#"hash_7ec09c8f8151205c", &function_e8c1f9d2);
  callback::add_callback(#"hash_3ab90c4405f67276", &function_a0fd3c83);
  callback::add_callback(#"hash_77fdc4459f2f1e35", &function_465ef407);
  callback::add_callback(#"hash_3cadee0b88ef66a2", &function_1bbc8595);
  callback::add_callback(#"hash_166e273d927bf6a3", &function_dce81333);
}

function function_e8c1f9d2() {
  if(!is_true(getgametypesetting(#"hash_6873fc00b59bcd39"))) {
    util::function_8076d591("warCircleDetectedFirst");
  }
}

function function_a0fd3c83() {
  util::function_8076d591("warCircleDetectedLast");
}

function function_465ef407() {
  util::function_8076d591("warCircleDetected");
}

function function_1bbc8595() {
  util::function_8076d591("warCircleCollapseImminent");
}

function function_dce81333() {
  util::function_8076d591("warCircleCollapseOccurring");
}