/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_crash_fixup.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_crash_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_crash_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"crash_unlock", #"hash_7a9842f6bec0e568", #"cu03_item", &function_d95e620c, #"hash_7ccc9c0240fd010e", #"hash_7ccc9b0240fcff5b");
}

function_d95e620c() {
  var_da8a21a0 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_4c66b817adba935c")) ? getgametypesetting(#"hash_4c66b817adba935c") : 0);
  return var_da8a21a0;
}