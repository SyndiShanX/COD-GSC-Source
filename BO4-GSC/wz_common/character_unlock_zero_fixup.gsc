/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_zero_fixup.gsc
*****************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_zero_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_zero_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"zero_unlock", #"hash_303d7717027a0f92", #"cu32_item", &function_d95e620c, #"hash_178b421c5b67b4d5");
}

function_d95e620c() {
  var_a703ffba = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_19c58d35b2ea8d15")) ? getgametypesetting(#"hash_19c58d35b2ea8d15") : 0);
  return var_a703ffba;
}