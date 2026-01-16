/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_takeo_fixup.csc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_takeo_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_takeo_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"takeo_unlock", #"hash_36157750ed7c6584", #"cu18_item", &function_d95e620c, #"hash_56b5eb94fb75cbed", #"hash_56b5e894fb75c6d4");
}

function_d95e620c() {
  var_913db062 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_26186b4e5dc9bb6f")) ? getgametypesetting(#"hash_26186b4e5dc9bb6f") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
  return var_913db062;
}