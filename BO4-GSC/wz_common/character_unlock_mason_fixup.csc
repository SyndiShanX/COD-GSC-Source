/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_mason_fixup.csc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_mason_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_mason_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"mason_unlock", #"hash_72350169be9133ae", #"cu19_item", &function_d95e620c, #"hash_7334970069e5e147", #"hash_7334980069e5e2fa");
}

function_d95e620c() {
  var_2fcdec4f = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_20f3ff8fbb8d8295")) ? getgametypesetting(#"hash_20f3ff8fbb8d8295") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);
  return var_2fcdec4f;
}