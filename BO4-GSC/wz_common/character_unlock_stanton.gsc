/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_stanton.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock;
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
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
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

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu14_item") {
    self function_895b40e4();
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  weapon = self.laststandparams.sweapon;

  if(!isPlayer(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name != #"eq_acid_bomb" && weapon.name != #"wraith_fire_fire" && weapon.name != #"eq_wraith_fire") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"stanton_unlock")) {
    return;
  }

  if(!isDefined(attacker.var_bd8f4916)) {
    attacker.var_bd8f4916 = 0;
  }

  attacker.var_bd8f4916++;

  if(attacker.var_bd8f4916 == 2) {
    attacker character_unlock::function_c8beca5e(#"stanton_unlock", #"hash_5495584ec5e9f348", 1);
  }
}

function_895b40e4() {
  self playsoundtoplayer(#"hash_70c9b45d9474b631", self);
}