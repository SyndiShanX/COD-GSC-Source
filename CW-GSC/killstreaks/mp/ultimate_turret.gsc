/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ultimate_turret.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\ultimate_turret_shared;
#namespace ultimate_turret;

function private autoexec __init__system__() {
  system::register(#"ultimate_turret", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  level.var_729a0937 = &function_4b645b3f;
  level.var_bbc796bf = &turret_destroyed;
  init_shared();
}

function function_4b645b3f(killstreaktype) {
  self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

function turret_destroyed(attacker, weapon) {
  profilestart();

  if(isDefined(attacker)) {
    attacker battlechatter::function_eebf94f6("ultimate_turret");
    attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    attacker stats::function_a431be09(weapon);
  }

  profilestop();
}