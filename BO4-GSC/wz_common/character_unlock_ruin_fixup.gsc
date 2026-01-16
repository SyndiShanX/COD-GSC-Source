/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ruin_fixup.gsc
*****************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ruin_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ruin_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ruin_unlock", #"hash_63b894fa4d634238", #"cu08_item", &function_d95e620c, #"hash_4e9ba934add76371");
}

function_d95e620c() {
  var_e2bea9cf = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_4f0a6d1e98cdbf81")) ? getgametypesetting(#"hash_4f0a6d1e98cdbf81") : 0);
  return var_e2bea9cf;
}