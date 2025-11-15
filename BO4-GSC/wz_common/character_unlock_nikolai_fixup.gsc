/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_nikolai_fixup.gsc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_nikolai_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_nikolai_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"nikolai_unlock", #"hash_1d718be46a94371f", #"cu16_item", &function_d95e620c, #"hash_6a5c9e02cc60e87e");
}

function_d95e620c() {
  var_bca69f36 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_2574d482086ec9d8")) ? getgametypesetting(#"hash_2574d482086ec9d8") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
  return var_bca69f36;
}