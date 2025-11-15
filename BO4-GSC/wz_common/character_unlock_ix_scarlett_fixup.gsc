/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_scarlett_fixup.gsc
************************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_scarlett_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_scarlett_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ix_scarlett_unlock", #"hash_63c7568898cd4fec", #"cu30_item", &function_d95e620c, #"hash_74fceff1a255277d");
}

function_d95e620c() {
  var_d0df1180 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_2b0f9caa00363ee8")) ? getgametypesetting(#"hash_2b0f9caa00363ee8") : 0);
  return var_d0df1180;
}