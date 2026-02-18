/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\spy_wanted_order.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace spy_wanted_order;

function private autoexec __init__system__() {
  system::register(#"spy_wanted_order", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {}