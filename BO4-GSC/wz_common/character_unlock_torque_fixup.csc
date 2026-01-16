/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_torque_fixup.csc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_torque_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_torque_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"torque_unlock", #"hash_6999516e5e35a515", #"cu02_item", &function_d95e620c, #"hash_a9ec4883fd0293d", #"hash_3843c83850f09a08", #"hash_b47463756c6a60f");
}

function_d95e620c() {
  var_fb9571a = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_3d719d86f2f3f14d")) ? getgametypesetting(#"hash_3d719d86f2f3f14d") : 0);
  return var_fb9571a;
}