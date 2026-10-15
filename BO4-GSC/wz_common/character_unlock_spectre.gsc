/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_spectre.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_spectre;

autoexec __init__system__() {
  system::register(#"character_unlock_spectre", &__init__, undefined, #"character_unlock_spectre_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"spectre_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_453c77a41df1963c", &function_27709af9);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu34_item") {
    if(self character_unlock::function_f0406288(#"spectre_unlock")) {
      if(self stats::get_stat_global(#"hash_41f134c3e727d877") >= 20) {
        self character_unlock::function_c8beca5e(#"spectre_unlock", #"hash_27023afb3f91aba5", 1);
      }
    }
  }
}

function_27709af9() {
  if(self character_unlock::function_f0406288(#"spectre_unlock")) {
    if(self stats::get_stat_global(#"hash_41f134c3e727d877") >= 20) {
      self character_unlock::function_c8beca5e(#"spectre_unlock", #"hash_27023afb3f91aba5", 1);
    }
  }
}