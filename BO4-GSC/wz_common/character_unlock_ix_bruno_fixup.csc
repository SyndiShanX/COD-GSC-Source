/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_bruno_fixup.csc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_bruno_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_bruno_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ix_bruno_unlock", #"hash_677a722d85cbd06", #"cu28_item", &function_d95e620c, #"hash_1493c49bbdfb17ad");
}

function_d95e620c() {
  var_bda4e460 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_4547b7ecb49469f0")) ? getgametypesetting(#"hash_4547b7ecb49469f0") : 0);
  return var_bda4e460;
}