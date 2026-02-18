/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\zm\weaponobjects.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\util;
#namespace weaponobjects;

function private autoexec __init__system__() {
  system::register(#"weaponobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}