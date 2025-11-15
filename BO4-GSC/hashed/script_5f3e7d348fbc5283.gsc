/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_5f3e7d348fbc5283.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace namespace_6fec3d63;

autoexec __init__system__() {
  system::register(#"hash_32ef71953f1186eb", &__init__, undefined, undefined);
}

__init__() {
  level.var_522db246 = isDefined(getgametypesetting(#"hash_507a891c5b5e7599")) ? getgametypesetting(#"hash_507a891c5b5e7599") : 0;
  customgame = gamemodeismode(1) || gamemodeismode(7);

  if(customgame || !level.var_522db246) {
    level thread function_7e4aeb0b();
  }
}

private function_7e4aeb0b() {
  item_world::function_4de3ca98();
  var_595e1a69 = getdynentarray(#"hash_37a64c24861c7172");

  foreach(var_534542fd in var_595e1a69) {
    item_world::function_160294c7(var_534542fd);
  }

  var_595e1a69 = getdynentarray(#"hash_7d60590fc39ccb98");

  foreach(var_534542fd in var_595e1a69) {
    item_world::function_160294c7(var_534542fd);
  }
}