/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\wz\gadgets\gadget_jammer.csc
**************************************************/

#include scripts\abilities\gadgets\gadget_jammer_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace jammer;

autoexec __init__system__() {
  system::register(#"gadget_jammer", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}