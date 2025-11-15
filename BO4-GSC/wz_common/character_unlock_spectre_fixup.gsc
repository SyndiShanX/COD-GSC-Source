/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_spectre_fixup.gsc
********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_spectre_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_spectre_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"spectre_unlock", #"hash_1ee2659e8dff07d8", #"cu34_item", &function_d95e620c, #"hash_27023afb3f91aba5");
}

function_d95e620c() {
  var_4c72e3da = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_6fe34e77ba14d86f")) ? getgametypesetting(#"hash_6fe34e77ba14d86f") : 0);
  return var_4c72e3da;
}