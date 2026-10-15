/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_prophet.csc
**************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_prophet;

autoexec __init__system__() {
  system::register(#"character_unlock_prophet", &__init__, undefined, #"character_unlock_prophet_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"prophet_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    character_unlock::function_d2294476(#"supply_drop_stash_cu10", 2, 3);
  }
}