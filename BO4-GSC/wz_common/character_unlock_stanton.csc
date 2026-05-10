/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_stanton.csc
**************************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;
#namespace character_unlock_stanton;

autoexec __init__system__() {
  system::register(#"character_unlock_stanton", &__init__, undefined, #"character_unlock_stanton_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"stanton_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    item_world_fixup::function_2749fcc3(#"zombie_supply_stash_boxinggym_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"zombie_supply_stash_diner_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"zombie_supply_stash_lighthouse_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"hash_183c9fe8af52fac7", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"zombie_supply_stash_crater_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"hospital_stash_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
    item_world_fixup::function_2749fcc3(#"zombie_supply_stash_buried_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu14", 2);
  }
}