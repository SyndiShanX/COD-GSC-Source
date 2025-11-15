/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_nomad_fixup.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_nomad_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_nomad_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"nomad_unlock", #"hash_4b77f84c47802222", #"cu07_item", &function_d95e620c, #"hash_7eb32c4c67ae13fe");
}

function_d95e620c() {
  var_1ff787de = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_26843909f5fdef20")) ? getgametypesetting(#"hash_26843909f5fdef20") : 0);
  return var_1ff787de;
}