/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\entityheadicons.gsc
***********************************************/

#include scripts\core_common\entityheadicons_shared;
#include scripts\core_common\system_shared;

#namespace entityheadicons;

autoexec __init__system__() {
  system::register(#"entityheadicons", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}