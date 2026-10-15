/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ultimate_turret.gsc
***********************************************/

#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\ultimate_turret_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;

#namespace ultimate_turret;

autoexec __init__system__() {
  system::register(#"ultimate_turret", &__init__, undefined, #"killstreaks");
}

__init__() {
  level.var_729a0937 = &function_4b645b3f;
  level.var_bbc796bf = &turret_destroyed;
  init_shared();
}

function_4b645b3f(killstreaktype) {
  self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

turret_destroyed(attacker, weapon) {
  profilestart();

  if(isDefined(attacker)) {
    attacker battlechatter::function_dd6a6012("ultimate_turret", weapon);
    attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
  }

  profilestop();
}