/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_seraph_fixup.csc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_seraph_fixup;

autoexec __init__system__() {
  system::register(#"character_unlock_seraph_fixup", &__init__, undefined, #"character_unlock_fixup");
}

autoexec function_f031a77f() {
  waitframe(1);
  function_f5a58e15();
}

__init__() {
  character_unlock_fixup::register_character_unlock(#"seraph_unlock", #"hash_17c02481305f0e24", #"annihilator_wz_item", &function_d95e620c, #"hash_633d185cd2140f1a", #"hash_633d175cd2140d67");
}

function_d95e620c() {
  var_e02cd092 = (isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isDefined(getgametypesetting(#"hash_183bcc0f6737224a")) ? getgametypesetting(#"hash_183bcc0f6737224a") : 0) && (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_4a035e3775089f40")) ? getgametypesetting(#"hash_4a035e3775089f40") : 0);
  return var_e02cd092;
}

private function_f5a58e15() {
  itementry = getscriptbundle(#"annihilator_wz_item");

  if(isDefined(itementry)) {
    item_world_fixup::function_96ff7b88(#"annihilator_wz_item");
  }
}