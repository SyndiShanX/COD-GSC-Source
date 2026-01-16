/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_bruno.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_bruno;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_bruno", &__init__, undefined, #"character_unlock_ix_bruno_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ix_bruno_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    item_world_fixup::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_33f7121f70c3065f", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_2b546c0315159617", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_183c9fe8af52fac7", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_49e8a607ea22e650", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_ca8b234ad1fea38", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
    item_world_fixup::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu28", 2);
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  weapon = self.laststandparams.sweapon;

  if(!isplayer(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name != #"hatchet") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"ix_bruno_unlock")) {
    return;
  }

  attacker character_unlock::function_c8beca5e(#"ix_bruno_unlock", #"hash_1493c49bbdfb17ad", 1);
}