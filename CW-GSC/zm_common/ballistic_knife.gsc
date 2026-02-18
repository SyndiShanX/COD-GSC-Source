/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\ballistic_knife.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\ballistic_knife;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;
#namespace ballistic_knife;

function private autoexec __init__system__() {
  system::register(#"ballistic_knife", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}