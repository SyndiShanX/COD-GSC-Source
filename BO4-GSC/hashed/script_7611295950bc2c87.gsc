/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_7611295950bc2c87.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace namespace_518109fe;

autoexec __init__system__() {
  system::register(#"hash_502d65acd9829223", &__init__, undefined, undefined);
}

__init__() {
  level.var_bf7edb6 = (isDefined(getgametypesetting(#"wzwaterballoonsenabled")) ? getgametypesetting(#"wzwaterballoonsenabled") : 0) || (isDefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) ? getgametypesetting(#"hash_3e2d2cf6b1cc6c68") : 0);
  customgame = gamemodeismode(1) || gamemodeismode(7);

  if(customgame || !level.var_bf7edb6) {
    level thread function_5d709b7();
  }
}

private function_5d709b7() {
  item_world::function_4de3ca98();
  var_fcfd8449 = getdynentarray(#"hash_25e69fa10c944661");

  foreach(var_a3272447 in var_fcfd8449) {
    item_world::function_160294c7(var_a3272447);
  }
}