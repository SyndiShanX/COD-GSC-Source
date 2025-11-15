/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_radiation_field.gsc
***********************************************************/

#include scripts\abilities\gadgets\gadget_radiation_field;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\util;

#namespace gadget_radiation_field;

autoexec __init__system__() {
  system::register(#"gadget_radiation_field", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  function_6ca75924(&function_4a9c8bba);
}

function_4a9c8bba(var_d90c942a) {
  self battlechatter::function_bd715920(var_d90c942a, undefined, self getEye(), self);
}