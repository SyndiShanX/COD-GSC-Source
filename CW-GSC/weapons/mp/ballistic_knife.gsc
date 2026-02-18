/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\ballistic_knife.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\ballistic_knife;
#namespace ballistic_knife;

function private autoexec __init__system__() {
  system::register(#"ballistic_knife", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}