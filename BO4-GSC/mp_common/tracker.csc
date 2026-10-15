/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\tracker.csc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\tracker_shared;
#include scripts\core_common\util_shared;

#namespace tracker;

autoexec __init__system__() {
  system::register(#"tracker", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}