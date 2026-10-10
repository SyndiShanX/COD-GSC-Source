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
  character_unlock_fixup::register_character_unlock(#"hash_178221dd8299137b", #"loot_tags_halloweenevent_jack_final", #"hw_event_item_jk", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_263de5e9fa6d16ea", #"loot_tags_halloweenevent_phantasm", #"hw_event_item_tod", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_8c7045e78561cf4", #"loot_tags_halloweenevent_monster", #"hw_event_item_kk", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_74709eb5a08139fb", #"loot_tags_halloweenevent_monster_6", #"hw_event_item_wb", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_517bb26004a9c12b", #"loot_tags_halloweenevent_werewolf", #"hw_event_item_th", &function_d95e620c, undefined);
  character_unlock_fixup::register_character_unlock(#"hash_3532d912b12917c9", #"loot_tags_halloweenevent_monster_1", #"hw_event_item_mc", &function_d95e620c, undefined);
}

function_d95e620c() {
  var_be67b2be = isDefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0;
  return var_be67b2be;
}