/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_attachments.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_attachments;

autoexec __init__system__() {
  system::register(#"zm_attachments", &__init__, undefined, undefined);
}

__init__() {
  namespace_9ff9f642::register_burn(#"hash_72a155025f3da562", 100, 3);
  namespace_9ff9f642::register_slowdown(#"hash_1c9af7bb427952d", 0.85, 1);
  namespace_9ff9f642::register_slowdown(#"hash_1d07249a2211a81d", 0.9, 1);
  namespace_9ff9f642::register_slowdown(#"hash_721bfbe781c0d680", 0.95, 1);
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isplayer(attacker) && isDefined(weapon) && meansofdeath !== "MOD_UNKNOWN") {
    if(weaponhasattachment(weapon, "uber")) {
      switch (weapon.rootweapon.name) {
        case #"lmg_standard_t8_upgraded":
        case #"lmg_standard_t8":
          self function_9f8d8c38();
          break;
        case #"shotgun_pump_t8_upgraded":
        case #"shotgun_pump_t8":
          if(meansofdeath !== "MOD_BURNED") {
            damage = self dragons_breath(attacker, damage, weapon);
          }

          break;
        case #"shotgun_semiauto_t8":
        case #"shotgun_semiauto_t8_upgraded":
          self function_82bca1c7(attacker);
          break;
      }
    }
  }

  return damage;
}

function_9f8d8c38() {
  if(isDefined(self.zm_ai_category)) {
    switch (self.zm_ai_category) {
      case #"popcorn":
      case #"basic":
      case #"enhanced":
        var_3e5502b5 = #"hash_1c9af7bb427952d";
        break;
      case #"heavy":
        var_3e5502b5 = #"hash_1d07249a2211a81d";
        break;
      case #"miniboss":
        var_3e5502b5 = #"hash_721bfbe781c0d680";
        break;
    }

    if(isDefined(var_3e5502b5)) {
      self thread namespace_9ff9f642::slowdown(var_3e5502b5);
    }
  }
}

dragons_breath(e_attacker, n_damage, weapon) {
  if(!isDefined(self.var_f6291271)) {
    self.var_f6291271 = [];
  } else if(!isarray(self.var_f6291271)) {
    self.var_f6291271 = array(self.var_f6291271);
  }

  if(isinarray(self.var_f6291271, e_attacker)) {
    if(self.archetype === #"zombie" && n_damage > self.health) {
      self.var_b364c165 = 1;
    }

    return n_damage;
  }

  if(!isDefined(self.var_f6291271)) {
    self.var_f6291271 = [];
  } else if(!isarray(self.var_f6291271)) {
    self.var_f6291271 = array(self.var_f6291271);
  }

  self.var_f6291271[self.var_f6291271.size] = e_attacker;
  self thread function_ddda26e(e_attacker);

  if(self.archetype === #"zombie") {
    n_damage += 100;

    if(n_damage < self.health) {
      self namespace_9ff9f642::burn(#"hash_72a155025f3da562", e_attacker, weapon);
    } else {
      self.var_b364c165 = 1;
    }
  } else {
    n_damage += 200;
  }

  return n_damage;
}

private function_ddda26e(e_attacker) {
  self endon(#"death");
  waitframe(5);
  arrayremovevalue(self.var_f6291271, e_attacker);
}

function_82bca1c7(e_attacker) {
  if(e_attacker playerads() == 1) {
    if((self.zm_ai_category === #"basic" || self.zm_ai_category === #"enhanced") && math::cointoss(10) && distancesquared(self.origin, e_attacker.origin) < 40000) {
      self ai::stun(2);
    }
  }
}