/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_concertina_wire.csc
***********************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_power;
#include scripts\abilities\ability_util;
#include scripts\abilities\gadgets\gadget_concertina_wire;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace concertina_wire;

autoexec __init__system__() {
  system::register(#"gadget_concertina_wire", &__init__, undefined, undefined);
}

__init__() {
  init_shared("concertina_wire_settings");
}