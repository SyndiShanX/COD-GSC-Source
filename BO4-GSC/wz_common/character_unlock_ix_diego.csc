/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_diego.csc
***************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_diego;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_diego", &__init__, undefined, #"character_unlock_ix_diego_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ix_diego_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"zombie_supply_stash_cu29", 3);
      return;
    }

    item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"zombie_supply_stash_cu29", 6);
  }
}