/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_diego_fixup.csc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_diego_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_diego_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"diego_unlock", #"hash_7fc15da2c5864d3c", #"cu12_item", &function_d95e620c, #"hash_7d0b41a17f2e9a9");
}

function_d95e620c() {
  var_32ce41fd = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_7fc2867a4b8594bf")) ? getgametypesetting(#"hash_7fc2867a4b8594bf") : 0);
  return var_32ce41fd;
}