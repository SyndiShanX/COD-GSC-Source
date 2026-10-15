/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_zero.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_zero;

autoexec __init__system__() {
  system::register(#"character_unlock_zero", &__init__, undefined, #"character_unlock_zero_fixup");
}

__init__() {
  callback::add_callback(#"hash_67dd51a5d529c64c", &function_2a798d57);
  character_unlock_fixup::function_90ee7a97(#"zero_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
  }
}

function_2a798d57() {
  if(self character_unlock::function_f0406288(#"zero_unlock")) {
    if(self stats::get_stat_global(#"destroy_equipment") >= 50) {
      self character_unlock::function_c8beca5e(#"zero_unlock", #"hash_178b421c5b67b4d5", 1);
    }
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu32_item") {
    if(self character_unlock::function_f0406288(#"zero_unlock")) {
      if(self stats::get_stat_global(#"destroy_equipment") >= 50) {
        self character_unlock::function_c8beca5e(#"zero_unlock", #"hash_178b421c5b67b4d5", 1);
      }
    }
  }
}