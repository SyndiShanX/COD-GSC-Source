/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_stanton_fixup.csc
***********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_stanton_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_stanton_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ix_stanton_unlock", #"hash_8bb7d93747987a1", #"cu31_item", &function_d95e620c, #"hash_9eef158b72b6ff4", #"hash_9eef458b72b750d");
}

function_d95e620c() {
  var_a6df6d8d = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_1ec2d38a40e97c55")) ? getgametypesetting(#"hash_1ec2d38a40e97c55") : 0);
  return var_a6df6d8d;
}