/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_74d0fecab64bc3c6.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace namespace_d0919546;

autoexec __init__system__() {
  system::register(#"hash_5d70c94021e00856", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"hash_178221dd8299137b", #"hash_3c068bc5135b7df0", #"hw_event_item_jk", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_263de5e9fa6d16ea", #"hash_1c057428d4e91ae8", #"hw_event_item_tod", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_8c7045e78561cf4", #"hash_2b8f5badea243dda", #"hw_event_item_kk", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_74709eb5a08139fb", #"hash_78ae81c11d646d8b", #"hw_event_item_wb", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_517bb26004a9c12b", #"hash_1a942f2aeeccb69", #"hw_event_item_th", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_3532d912b12917c9", #"hash_78ae86c11d64760a", #"hw_event_item_mc", &function_d95e620c, undefined);
}

function_d95e620c() {
  var_be67b2be = isDefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0;
  return var_be67b2be;
}