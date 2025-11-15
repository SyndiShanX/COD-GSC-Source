/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_scarlett_fixup.gsc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_scarlett_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_scarlett_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"scarlett_unlock", #"hash_6f105a897d64112", #"cu13_item", &function_d95e620c, #"hash_698918780b4406f1");
}

function_d95e620c() {
  var_9a07aee8 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_7049c01d7ddf9b35")) ? getgametypesetting(#"hash_7049c01d7ddf9b35") : 0);
  return var_9a07aee8;
}