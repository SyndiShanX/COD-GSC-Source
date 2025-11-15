/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_recon.csc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_recon;

autoexec __init__system__() {
  system::register(#"character_unlock_recon", &__init__, undefined, #"character_unlock_recon_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"recon_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"wz_escape_supply_stash_parent", #"supply_stash_cu04", 1);
      return;
    }

    item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_cu04", 6);
  }
}