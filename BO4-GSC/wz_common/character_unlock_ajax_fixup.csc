/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ajax_fixup.csc
*****************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ajax_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ajax_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ajax_unlock", #"hash_69bbe1ec48f79df5", #"cu01_item", &function_d95e620c, #"hash_6e5a10ffa958d875");
}

function_d95e620c() {
  var_db4d099d = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_d084b5063bb0c55")) ? getgametypesetting(#"hash_d084b5063bb0c55") : 0);
  return var_db4d099d;
}