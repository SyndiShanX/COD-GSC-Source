/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_outrider.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_outrider;

autoexec __init__system__() {
  system::register(#"character_unlock_outrider", &__init__, undefined, #"character_unlock_outrider_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"outrider_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_7a9bdd3ee0ae95af", &function_c915e2a7);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu33_item") {
    if(self character_unlock::function_f0406288(#"outrider_unlock")) {
      if(self stats::get_stat_global(#"hash_35020c395a89befb") >= 25) {
        self character_unlock::function_c8beca5e(#"outrider_unlock", #"hash_28966e441535b733", 1);
      }
    }
  }
}

function_c915e2a7() {
  if(self character_unlock::function_f0406288(#"outrider_unlock")) {
    if(self stats::get_stat_global(#"hash_35020c395a89befb") >= 25) {
      self character_unlock::function_c8beca5e(#"outrider_unlock", #"hash_28966e441535b733", 1);
    }
  }
}