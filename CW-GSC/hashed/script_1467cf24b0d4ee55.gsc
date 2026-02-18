/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1467cf24b0d4ee55.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#namespace namespace_ce472ff1;

function private autoexec __init__system__() {
  system::register(#"hash_788b2cd49344cd51", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(level.var_f2814a96 !== 1 && level.var_f2814a96 !== 2) {
    return;
  }
}

function on_spawn_player(predictedspawn) {
  if(isDefined(level.on_spawn_player)) {
    [[level.on_spawn_player]](predictedspawn);
    return;
  }

  spawning::onspawnplayer(undefined);
}