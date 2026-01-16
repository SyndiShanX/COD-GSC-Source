/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_tortoise.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_restrict_loadout;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_spawner;

#namespace zm_perk_tortoise;

autoexec __init__system__() {
  system::register(#"zm_perk_tortoise", &__init__, &__main__, undefined);
}

__init__() {
  enable_tortoise_perk_for_level();
}

__main__() {}

enable_tortoise_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_shield", #"perk_tortoise", 2500, #"hash_61f2a9db3bdc745a", getweapon("zombie_perk_bottle_tortoise"), getweapon("zombie_perk_totem_tortoise"), #"zmperksvictorious");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_shield", #"perk_tortoise", 2500, #"zombie/perk_tortoise", getweapon("zombie_perk_bottle_tortoise"), getweapon("zombie_perk_totem_tortoise"), #"zmperksvictorious");
  }

  zm_perks::register_perk_precache_func(#"specialty_shield", &function_1441654f);
  zm_perks::register_perk_clientfields(#"specialty_shield", &function_2ebeec84, &function_9b64bd1b);
  zm_perks::register_perk_machine(#"specialty_shield", &function_c282add5, &function_3cc019d7);
  zm_perks::register_perk_host_migration_params(#"specialty_shield", "p7_zm_vending_nuke", "divetonuke_light");
  zm_perks::register_perk_threads(#"specialty_shield", &function_f8196ccf, &function_b754923d);
}

function_3cc019d7() {}

function_1441654f() {
  level.machine_assets[#"specialty_shield"] = spawnStruct();
  level.machine_assets[#"specialty_shield"].weapon = getweapon("zombie_perk_bottle_tortoise");
  level.machine_assets[#"specialty_shield"].off_model = "p7_zm_vending_nuke";
  level.machine_assets[#"specialty_shield"].on_model = "p7_zm_vending_nuke";
}

function_2ebeec84() {
  clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter");
}

function_9b64bd1b(state) {}

function_c282add5(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_phd_jingle";
  use_trigger.script_string = "divetonuke_perk";
  use_trigger.script_label = "mus_perks_phd_sting";
  use_trigger.target = "vending_divetonuke";
  perk_machine.script_string = "divetonuke_perk";
  perk_machine.targetname = "vending_divetonuke";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "divetonuke_perk";
  }
}

function_f8196ccf() {
  self.var_27aeb716 = &function_81058b09;
}

function_b754923d(b_pause, str_perk, str_result, n_slot) {
  self.var_27aeb716 = undefined;
}

function_81058b09(var_d92ac80e) {
  a_ai = self getenemiesinradius(self.origin, 320);
  a_ai = arraysortclosest(a_ai, self.origin);

  if(zm_trial_restrict_loadout::is_active()) {
    a_ai = [];
  }

  foreach(ai in a_ai) {
    if(ai.health <= 1200) {
      ai.marked_for_death = 1;
    }
  }

  self playSound(#"hash_14f5104610856f3e");
  self thread explosion_fx();
  v_explosion_origin = self.origin;

  foreach(ai in a_ai) {
    if(!isalive(ai)) {
      continue;
    }

    ai.var_cbfc5f6e = 1;
    ai dodamage(1200, v_explosion_origin, self, self, "none", "MOD_EXPLOSIVE", 0, var_d92ac80e);

    if(isalive(ai)) {
      if(ai.zm_ai_category === #"heavy" || ai.zm_ai_category === #"miniboss") {
        if(!(isDefined(ai.knockdown) && ai.knockdown)) {
          ai ai::stun();
        }
      } else {
        ai zombie_utility::setup_zombie_knockdown(v_explosion_origin);
      }
    } else if(isDefined(ai) && (ai.zm_ai_category === #"basic" || ai.zm_ai_category === #"enhanced")) {
      ai zm_spawner::zombie_explodes_intopieces(0);
    }

    if(isDefined(ai)) {
      ai.var_cbfc5f6e = undefined;
    }

    waitframe(1);
  }
}

explosion_fx() {
  self endon(#"death");
  wait 0.3;
  self clientfield::increment("perk_tortoise_explosion");
}