/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_vision_pulse.csc
********************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_power;
#include scripts\abilities\ability_util;
#include scripts\abilities\gadgets\gadget_vision_pulse;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace gadget_vision_pulse;

autoexec __init__system__() {
  system::register(#"gadget_vision_pulse", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}