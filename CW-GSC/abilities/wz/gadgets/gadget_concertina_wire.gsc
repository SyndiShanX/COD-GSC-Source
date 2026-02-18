/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\wz\gadgets\gadget_concertina_wire.gsc
***********************************************************/

#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;
#namespace concertina_wire;

function private autoexec __init__system__() {
  system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, #"weapons");
}

function private preinit() {
  init_shared("concertina_wire_settings_wz");
  function_c5f0b9e7(&onconcertinawireplaced);
}

function onconcertinawireplaced(concertinawire) {}