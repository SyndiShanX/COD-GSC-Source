/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\satchel_charge.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\satchel_charge;
#namespace satchel_charge;

function private autoexec __init__system__() {
  system::register(#"satchel_charge", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}