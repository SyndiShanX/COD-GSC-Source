/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\wz\gadgets\gadget_concertina_wire.csc
***********************************************************/

#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;
#namespace concertina_wire;

function private autoexec __init__system__() {
  system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared("concertina_wire_settings_wz");
}