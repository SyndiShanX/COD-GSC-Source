/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_menendez_fixup.csc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_menendez_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_menendez_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"menendez_unlock", #"hash_77118b5dbb73e0b6", #"cu20_item", &function_d95e620c, #"hash_4bc3134998048aa7");
}

function_d95e620c() {
  var_e9462a7e = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_1d50c09e8021ab1")) ? getgametypesetting(#"hash_1d50c09e8021ab1") : 0);
  return var_e9462a7e;
}