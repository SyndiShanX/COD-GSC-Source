/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\supplydrop.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\supplydrop_shared;
#namespace supplydrop;

function private autoexec __init__system__() {
  system::register(#"supplydrop", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
}