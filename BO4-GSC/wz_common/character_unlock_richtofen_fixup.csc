/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_richtofen_fixup.csc
**********************************************************/

#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_richtofen_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_richtofen_fixup", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"richtofen_unlock", #"hash_66b69b90a30bcc88", #"cu17_item", &function_d95e620c, #"hash_418312990213bc41");
}

function_d95e620c() {
  var_5d6be844 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_19667f3338ed6b1f")) ? getgametypesetting(#"hash_19667f3338ed6b1f") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
  return var_5d6be844;
}