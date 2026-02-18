/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\planemortar.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  killstreaks::register_killstreak("killstreak_planemortar" + "_cp", &usekillstreakplanemortar);
}