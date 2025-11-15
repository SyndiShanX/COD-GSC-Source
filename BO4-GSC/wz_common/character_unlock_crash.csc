/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_crash.csc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_crash;

autoexec __init__system__() {
  system::register(#"character_unlock_crash", &__init__, undefined, #"character_unlock_crash_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"crash_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"health_stash_parent", #"health_stash_cu03", 3);
      return;
    }

    item_world_fixup::function_e70fa91c(#"health_stash_parent", #"health_stash_cu03", 10);
  }
}