/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_smart_cover.csc
*******************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_power;
#include scripts\abilities\ability_util;
#include scripts\abilities\gadgets\gadget_smart_cover;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace smart_cover;

autoexec __init__system__() {
  system::register(#"gadget_smart_cover", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}