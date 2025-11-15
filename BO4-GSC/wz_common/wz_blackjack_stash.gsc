/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_blackjack_stash.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace wz_stash_blackjack;

autoexec __init__system__() {
  system::register(#"wz_stash_blackjack", &__init__, undefined, undefined);
}

__init__() {
  level.blackjackstash = isDefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0;
  customgame = gamemodeismode(1) || gamemodeismode(7);

  if(customgame || !level.blackjackstash) {
    level thread function_e973becc();
  }
}

private function_e973becc() {
  item_world::function_4de3ca98();
  var_14957968 = getdynentarray(#"wz_stash_blackjack");

  foreach(var_2e01d28f in var_14957968) {
    item_world::function_160294c7(var_2e01d28f);
  }
}