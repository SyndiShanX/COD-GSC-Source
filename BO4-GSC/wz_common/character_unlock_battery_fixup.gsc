/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_battery_fixup.gsc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_battery_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_battery_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"battery_unlock", #"hash_7f410b145dce17bd", #"warmachine_wz_item", &function_d95e620c, #"hash_c5713430b8fb888");
}

function_d95e620c() {
  var_7801126f = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_2cd26947d8f311fa")) ? getgametypesetting(#"hash_2cd26947d8f311fa") : 0);
  return var_7801126f;
}