/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_diego_fixup.csc
*********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_diego_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_diego_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"ix_diego_unlock", #"hash_75365263415c16f2", #"cu29_item", &function_d95e620c, #"hash_374df23cda9c79ed");
}

function_d95e620c() {
  var_fb6c1efd = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_ff653cbb1438270")) ? getgametypesetting(#"hash_ff653cbb1438270") : 0);
  return var_fb6c1efd;
}