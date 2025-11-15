/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_proximity_grenade.csc
****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\proximity_grenade;

#namespace proximity_grenade;

autoexec __init__system__() {
  system::register(#"proximity_grenade", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}