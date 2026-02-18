/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\weapons\trophy_system;
#namespace trophy_system;

function private autoexec __init__system__() {
  system::register(#"trophy_system", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  function_720ddf7f(&function_ccfcde75);
}

function function_ccfcde75(trophy, grenade) {
  self battlechatter::function_fc82b10(trophy.weapon, grenade.origin, trophy);
  self contracts::increment_contract(#"hash_5d75f7e385889afa");

  if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
    self[[level.var_b7bc3c75.var_fbbc4c75]](trophy);
  }
}