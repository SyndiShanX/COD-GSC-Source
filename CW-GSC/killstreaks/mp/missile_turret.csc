/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\missile_turret.csc
***********************************************/

#using script_2f272fb57a31d81c;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_vehicle;
#namespace missile_turret;

function private autoexec __init__system__() {
  system::register(#"missile_turret", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  bundle = getscriptbundle("killstreak_missile_turret");
  killstreak_vehicle::init_killstreak(bundle);
}