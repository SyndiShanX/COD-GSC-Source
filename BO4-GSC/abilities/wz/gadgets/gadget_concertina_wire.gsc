/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\wz\gadgets\gadget_concertina_wire.gsc
***********************************************************/

#include scripts\abilities\gadgets\gadget_concertina_wire;
#include scripts\core_common\system_shared;

#namespace concertina_wire;

autoexec __init__system__() {
  system::register(#"concertina_wire", &__init__, undefined, #"weapons");
}

__init__() {
  init_shared("concertina_wire_settings_wz");
  function_c5f0b9e7(&onconcertinawireplaced);
}

onconcertinawireplaced(concertinawire) {}