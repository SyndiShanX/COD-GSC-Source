/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_stanton_fixup.csc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_stanton_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_stanton_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"stanton_unlock", #"hash_4f0c567012b33fd9", #"cu14_item", &function_d95e620c, #"hash_5495584ec5e9f348");
}

function_d95e620c() {
  var_8d597b54 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_5ea56d63c68b4396")) ? getgametypesetting(#"hash_5ea56d63c68b4396") : 0);
  return var_8d597b54;
}