/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_weap_bouncingbetty.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\bouncingbetty;
#namespace bouncingbetty;

function private autoexec __init__system__() {
  system::register(#"bouncingbetty", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}