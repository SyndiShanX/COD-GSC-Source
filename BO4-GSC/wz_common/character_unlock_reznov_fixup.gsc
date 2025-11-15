/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_reznov_fixup.gsc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_reznov_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_reznov_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"reznov_unlock", #"hash_44599132bf7320e8", #"cu21_item", &function_d95e620c, #"hash_1cd3eb5d2d22f647", #"hash_1cd3ec5d2d22f7fa");
}

function_d95e620c() {
  var_a4904ac0 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_47242abeaa29479b")) ? getgametypesetting(#"hash_47242abeaa29479b") : 0);
  return var_a4904ac0;
}