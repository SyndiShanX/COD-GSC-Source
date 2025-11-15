/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_bruno_fixup.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_bruno_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_bruno_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"bruno_unlock", #"hash_4815f130a1c1d840", #"cu11_item", &function_d95e620c, #"hash_21c5510d64c20b71");
}

function_d95e620c() {
  var_808a2a47 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_2dfb36064be05f03")) ? getgametypesetting(#"hash_2dfb36064be05f03") : 0);
  return var_808a2a47;
}