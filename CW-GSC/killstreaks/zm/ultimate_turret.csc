/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\ultimate_turret.csc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\ultimate_turret_shared;
#namespace ultimate_turret;

function private autoexec __init__system__() {
  system::register(#"ultimate_turret", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  bundle = getscriptbundle("killstreak_ultimate_turret_zm");
  killstreak_vehicle::init_killstreak(bundle);
}