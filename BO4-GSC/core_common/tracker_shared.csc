/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\tracker_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace tracker;

init_shared() {
  registerclientfields();
}

private registerclientfields() {
  clientfield::register("clientuimodel", "huditems.isExposedOnMinimap", 1, 1, "int", undefined, 0, 0);
}