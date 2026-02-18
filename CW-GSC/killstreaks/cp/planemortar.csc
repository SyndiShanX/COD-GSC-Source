/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\planemortar.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\planemortar_shared;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
}