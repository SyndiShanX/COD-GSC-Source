/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system.gsc
***********************************************/

#include scripts\core_common\contracts_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\weapons\trophy_system;

#namespace trophy_system;

autoexec __init__system__() {
  system::register(#"trophy_system", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  function_720ddf7f(&function_ccfcde75);
}

function_ccfcde75(trophy, grenade) {
  self battlechatter::function_bd715920(trophy.weapon, grenade.owner, grenade.origin, trophy);
  self contracts::increment_contract(#"hash_369e3fd5caa5145b");
}