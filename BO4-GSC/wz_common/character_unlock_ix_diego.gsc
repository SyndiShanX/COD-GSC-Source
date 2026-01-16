/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_diego.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_diego;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_diego", &__init__, undefined, #"character_unlock_ix_diego_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ix_diego_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);

    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"zombie_supply_stash_cu29", 3);
      return;
    }

    item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"zombie_supply_stash_cu29", 6);
  }
}

on_player_killed() {
  params = self.var_a1d415ee;

  if(!isDefined(params)) {
    if(!isDefined(self.laststandparams) || isDefined(self.laststandparams.bledout) && self.laststandparams.bledout) {
      return;
    }

    params = self.laststandparams;
  }

  attacker = params.attacker;
  weapon = params.sweapon;

  if(!isDefined(params.attacker)) {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(weapon.name != #"melee_bowie" && weapon.name != #"melee_bowie_bloody") {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"ix_diego_unlock")) {
    return;
  }

  attacker character_unlock::function_c8beca5e(#"ix_diego_unlock", #"hash_374df23cda9c79ed", 1);
}