/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_mannequin_ally.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_spawner;

#namespace namespace_ca8676a3;

autoexec __init__system__() {
  system::register(#"hash_217942543a3e669b", &__init__, &__main__, undefined);
}

__init__() {
  spawner::add_archetype_spawn_function(#"zod_companion", &function_10c92445);
  zm::function_84d343d(#"hash_680d9169c5e72bdc", &function_f1be5640);
  level.var_af29d768 = &function_80bc397d;
}

__main__() {}

private function_10c92445() {
  self.ignore_nuke = 1;
  self.ignore_all_poi = 1;
  self.instakill_func = &zm_powerups::function_16c2586a;
  self.var_69bfb00a = &function_188e5077;
  self.var_594b7855 = 1;

  if(isDefined(level.var_777acf92)) {
    self thread function_65ed0370(level.var_777acf92.origin, level.var_777acf92.angles);
  }
}

private function_188e5077(angles) {
  self thread animation::play("ai_t8_zm_mannequin_ally_stn_exposed_revive", self, angles, 1);
}

function_65ed0370(origin, angles) {
  self endon(#"death");
  self forceteleport(origin, angles);
  self orientmode("face default");
  self animation::play("ai_t8_zm_mannequin_ally_intro");
}

function_f1be5640(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  n_base_damage = self.maxhealth;

  if(isDefined(meansofdeath) && meansofdeath != "MOD_MELEE") {
    n_base_damage /= 4;
  }

  var_7e0e6341 = self ai::function_9139c839();

  if(isDefined(var_7e0e6341)) {
    var_b1c1c5cf = var_7e0e6341.damagescale;

    if(var_b1c1c5cf > 0 && var_b1c1c5cf < 1) {
      var_64cc5e50 = 1 / var_b1c1c5cf;
      n_base_damage *= var_64cc5e50;
    }
  }

  if(isDefined(self.zm_ai_category)) {
    switch (self.zm_ai_category) {
      case #"heavy":
        n_base_damage *= 0.2;
        break;
      case #"miniboss":
        n_base_damage *= 0.1;
        break;
      case #"boss":
        n_base_damage *= 0.05;
        break;
      default:
        break;
    }
  }

  return n_base_damage;
}

private function_80bc397d() {
  var_8f538918 = getaiarchetypearray(#"zod_companion");

  if(var_8f538918.size == 0 && (level.players.size == 1 || isDefined(self.var_20f86af4) && self.var_20f86af4)) {
    self thread zm_laststand::wait_and_revive();
    return;
  }

  self thread zm_laststand::function_3699b145();
}