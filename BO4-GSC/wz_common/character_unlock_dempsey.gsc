/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_dempsey.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_dempsey;

autoexec __init__system__() {
  system::register(#"character_unlock_dempsey", &__init__, undefined, #"character_unlock_dempsey_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"dempsey_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_3b891b6daa75c782", &function_1c4b5097);
    item_world_fixup::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_33f7121f70c3065f", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_2b546c0315159617", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_183c9fe8af52fac7", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_49e8a607ea22e650", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_quest", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_ca8b234ad1fea38", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
    item_world_fixup::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"zombie_supply_stash_quest_parent", #"zombie_supply_stash_cu15", 2);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu15_item") {
    self thread function_895b40e4();
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  mod = self.laststandparams.smeansofdeath;

  if(!isplayer(attacker)) {
    return;
  }

  if(mod != "MOD_GRENADE" && mod != "MOD_GRENADE_SPLASH") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"dempsey_unlock")) {
    return;
  }

  attacker character_unlock::function_c8beca5e(#"dempsey_unlock", #"hash_557b228047615fb0", 1);
}

private function_895b40e4() {
  self playsoundtoplayer(#"hash_40bb133320e319b6", self);
}