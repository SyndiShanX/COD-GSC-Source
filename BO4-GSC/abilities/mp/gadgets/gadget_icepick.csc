/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_icepick.csc
***************************************************/

#include scripts\abilities\gadgets\gadget_icepick_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace jammer;

autoexec __init__system__() {
  system::register(#"gadget_icepick", &__init__, undefined, undefined);
}

__init__() {
  icepick::init_shared();
}