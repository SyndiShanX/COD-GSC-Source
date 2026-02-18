/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\missile_turret.gsc
***********************************************/

#using script_5312dbb58ee628a8;
#using scripts\core_common\battlechatter;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#namespace missile_turret;

function private autoexec __init__system__() {
  system::register(#"missile_turret", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_1c5940ad = &function_4b645b3f;
  level.var_2958ac6c = &turret_destroyed;
  init_shared();
}

function function_4b645b3f(killstreaktype) {
  self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

function turret_destroyed(attacker, weapon) {
  profilestart();

  if(isDefined(attacker)) {
    attacker battlechatter::function_eebf94f6("missile_turret", weapon);
    attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
  }

  profilestop();
}