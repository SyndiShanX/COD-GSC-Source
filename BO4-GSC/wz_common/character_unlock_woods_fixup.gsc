/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_woods_fixup.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_woods_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_woods_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"woods_unlock", #"hash_3f01badbd66b2962", #"cu22_item", &function_d95e620c, #"hash_17a4baf5ec553be7", #"hash_17a4bbf5ec553d9a");
}

function_d95e620c() {
  var_fca3d7af = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_265bdda9362c5a35")) ? getgametypesetting(#"hash_265bdda9362c5a35") : 0);
  return var_fca3d7af;
}