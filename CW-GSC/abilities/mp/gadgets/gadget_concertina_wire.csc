/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_concertina_wire.csc
***********************************************************/

#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace concertina_wire;

function private autoexec __init__system__() {
  system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared("concertina_wire_settings");
}