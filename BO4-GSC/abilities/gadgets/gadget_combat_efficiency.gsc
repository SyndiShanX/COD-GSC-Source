/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_combat_efficiency.gsc
**********************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_util;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;

#namespace gadget_combat_efficiency;

autoexec __init__system__() {
  system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

__init__() {
  ability_player::register_gadget_activation_callbacks(12, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
  ability_player::register_gadget_is_inuse_callbacks(12, &gadget_combat_efficiency_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(12, &gadget_combat_efficiency_is_flickering);
  ability_player::register_gadget_ready_callbacks(12, &gadget_combat_efficiency_ready);
  clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int");
}

gadget_combat_efficiency_is_inuse(slot) {
  return self gadgetisactive(slot);
}

gadget_combat_efficiency_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function_5bfd1343(attacker, var_f231d134, var_6ba675bd, capturedobjective, var_77cc3ee4) {
  if(!isDefined(attacker) || !isDefined(var_f231d134) || !isDefined(var_77cc3ee4) || !isDefined(attacker.var_649d2b1f)) {
    return;
  }

  if(function_db4ccff2(attacker, undefined, var_f231d134) && isDefined(attacker.var_bc9d778c) && attacker.var_bc9d778c && attacker != attacker.var_649d2b1f) {
    scoreevents::processscoreevent(#"stim_vanguard", attacker.var_649d2b1f, undefined, var_77cc3ee4);
  }
}

function_57b485b3(attacker, time, var_f231d134, var_77cc3ee4, objectivekill) {
  if(!isDefined(attacker) || !isDefined(var_f231d134) || !isDefined(var_77cc3ee4) || !isDefined(attacker.var_649d2b1f) || !isDefined(objectivekill)) {
    return;
  }

  if(function_db4ccff2(attacker, undefined, var_f231d134)) {
    if(objectivekill) {
      scoreevents::processscoreevent(#"battle_command_ultimate_command", attacker, undefined, var_77cc3ee4);
      return;
    }

    if(attacker == attacker.var_649d2b1f) {
      scoreevents::processscoreevent(#"hash_1c12195e708977c5", attacker, undefined, var_77cc3ee4);
    }
  }
}

function_a30493ef(attacker, lastkilltime, var_f231d134, var_77cc3ee4) {
  if(!isDefined(attacker) || !isDefined(var_f231d134) || !isDefined(var_77cc3ee4) || !isDefined(attacker.var_649d2b1f)) {
    return;
  }

  if(function_db4ccff2(attacker, undefined, var_f231d134) && isDefined(attacker.var_bc9d778c) && attacker.var_bc9d778c) {
    scoreevents::processscoreevent(#"hash_3d7b27350807786b", attacker.var_649d2b1f, undefined, var_77cc3ee4);
  }
}

function_db4ccff2(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(weapon)) {
    return false;
  }

  if(isDefined(attacker.playerrole) && isDefined(attacker.playerrole.ultimateweapon)) {
    ultweapon = getweapon(attacker.playerrole.ultimateweapon);

    if(attacker ability_util::function_43cda488() && weapon == ultweapon) {
      return true;
    }
  }

  return false;
}

function_92308e92(attacker, victim, weapon, attackerweapon) {
  if(!isDefined(attacker)) {
    return false;
  }

  attacker.var_bc9d778c = attacker ability_util::function_43cda488();
  return function_db4ccff2(attacker, victim, weapon, attackerweapon);
}

gadget_combat_efficiency_on_activate(slot, weapon) {
  self._gadget_combat_efficiency = 1;
  self._gadget_combat_efficiency_success = 0;
  self.scorestreaksearnedperuse = 0;
  self.combatefficiencylastontime = gettime();
  self function_f53ac86e();
  self thread function_6a9d7105(slot, weapon);
  result = self gestures::function_56e00fbf(#"gestable_battle_cry", undefined, 0);
}

gadget_combat_efficiency_on_off(slot, weapon) {
  self._gadget_combat_efficiency = 0;
  self.combatefficiencylastontime = gettime();
  self function_f53ac86e();
  self stats::function_e24eec31(self.heroability, #"scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
  self stats::function_e24eec31(self.heroability, #"scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));

  if(isalive(self) && isDefined(level.playgadgetsuccess)) {
    self[[level.playgadgetsuccess]](weapon);
  }
}

function_6a9d7105(slot, weapon) {
  if(self function_91224c49() == 0) {
    return;
  }

  self notify("1da58f971e958838");
  self endon("1da58f971e958838");
  self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  var_122b9df7 = weapon.gadget_power_usage_rate * 0.5 * float(function_60d95f53()) / 1000;

  do {
    current_power = self gadgetpowerget(slot);
    self gadgetpowerset(slot, min(current_power + var_122b9df7, 100));
    waitframe(1);
  }
  while(self._gadget_combat_efficiency);
}

gadget_combat_efficiency_ready(slot, weapon) {}

set_gadget_combat_efficiency_status(weapon, status, time) {
  timestr = "";

  if(isDefined(time)) {
    timestr = "^3" + ", time: " + time;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold("<dev string:x38>" + weapon.name + "<dev string:x54>" + status + timestr);
  }

}

function_f53ac86e() {
  enabled = self ability_util::function_43cda488();

  if(isDefined(self.team)) {
    teammates = getplayers(self.team);

    foreach(player in teammates) {
      player clientfield::set_player_uimodel("hudItems.combatEfficiencyActive", enabled);

      if(enabled) {
        player.var_649d2b1f = self;
        continue;
      }

      player.var_649d2b1f = undefined;
    }
  }
}