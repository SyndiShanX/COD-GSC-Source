/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_outrider_fixup.gsc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_outrider_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_outrider_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"outrider_unlock", #"hash_1dc888eecacf65d4", #"cu33_item", &function_d95e620c, #"hash_28966e441535b733");
}

function_d95e620c() {
  var_f8bc8610 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_52d705a46da9e55f")) ? getgametypesetting(#"hash_52d705a46da9e55f") : 0);
  return var_f8bc8610;
}