/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_prophet_fixup.csc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_prophet_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_prophet_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"prophet_unlock", #"hash_62361c68e083d401", #"cu10_item", &function_d95e620c, #"hash_63b7bd67a959fc47", #"hash_63b7be67a959fdfa");
}

function_d95e620c() {
  var_53490e75 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_7cf82cc41c0f0d5")) ? getgametypesetting(#"hash_7cf82cc41c0f0d5") : 0);
  return var_53490e75;
}