/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_firebreak_fixup.gsc
**********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_firebreak_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_firebreak_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"firebreak_unlock", #"hash_8596bc069593313", #"cu06_item", &function_d95e620c, #"hash_48b3b84fe88578f2");
}

function_d95e620c() {
  var_711ddc0f = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_75370c9c920502fc")) ? getgametypesetting(#"hash_75370c9c920502fc") : 0);
  return var_711ddc0f;
}