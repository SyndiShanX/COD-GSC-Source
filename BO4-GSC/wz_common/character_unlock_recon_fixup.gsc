/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_recon_fixup.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_recon_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_recon_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"recon_unlock", #"hash_78c357c8a5680d67", #"cu04_item", &function_d95e620c, #"hash_91d5ea7b26a8aca", #"hash_91d5da7b26a8917");
}

function_d95e620c() {
  var_4bbd2b8a = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_34ea44c91776e52c")) ? getgametypesetting(#"hash_34ea44c91776e52c") : 0);
  return var_4bbd2b8a;
}