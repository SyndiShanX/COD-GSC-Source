/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\killstreaks.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}