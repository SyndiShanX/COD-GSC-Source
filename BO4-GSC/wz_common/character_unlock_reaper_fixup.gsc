/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_reaper_fixup.gsc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_reaper_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_reaper_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"reaper_unlock", #"hash_76cce42bfc9866cd", #"cu35_item", &function_d95e620c, #"hash_555c37b28c4a770c", #"hash_555c3ab28c4a7c25");
}

function_d95e620c() {
  var_17805812 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_6b1ec01fa78af670")) ? getgametypesetting(#"hash_6b1ec01fa78af670") : 0);
  return var_17805812;
}