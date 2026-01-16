/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_dempsey_fixup.csc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_dempsey_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_dempsey_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"dempsey_unlock", #"hash_23d5f8566508f9f5", #"cu15_item", &function_d95e620c, #"hash_557b228047615fb0");
}

function_d95e620c() {
  var_182a6f93 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_1d4c395693ce04fe")) ? getgametypesetting(#"hash_1d4c395693ce04fe") : 0);
  return var_182a6f93;
}