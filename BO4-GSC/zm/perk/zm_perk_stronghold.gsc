/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_stronghold.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_armor;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_stronghold;

autoexec __init__system__() {
  system::register(#"zm_perk_stronghold", &__init__, &__main__, undefined);
}

__init__() {
  enable_stronghold_perk_for_level();
  zm_armor::register(#"stronghold_armor", 0);
}

__main__() {}

enable_stronghold_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_camper", #"perk_stronghold", 2500, #"hash_cd87686e9c80e75", getweapon("zombie_perk_bottle_stronghold"), getweapon("zombie_perk_totem_stronghold"), #"zmperksstonecold");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_camper", #"perk_stronghold", 2500, #"zombie/perk_stronghold", getweapon("zombie_perk_bottle_stronghold"), getweapon("zombie_perk_totem_stronghold"), #"zmperksstonecold");
  }

  zm_perks::register_perk_precache_func(#"specialty_camper", &function_e03779ee);
  zm_perks::register_perk_clientfields(#"specialty_camper", &function_356a31cb, &function_721cc6dc);
  zm_perks::register_perk_machine(#"specialty_camper", &function_f15d3355, &init_stronghold);
  zm_perks::register_perk_threads(#"specialty_camper", &function_1dd08a86, &function_9a3871b7);
  zm_perks::register_actor_damage_override(#"specialty_camper", &function_11154900);
}

init_stronghold() {}

function_e03779ee() {
  if(isDefined(level.var_a51702ef)) {
    [[level.var_a51702ef]]();
    return;
  }

  level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
  level.machine_assets[#"specialty_camper"] = spawnStruct();
  level.machine_assets[#"specialty_camper"].weapon = getweapon("zombie_perk_bottle_stronghold");
  level.machine_assets[#"specialty_camper"].off_model = "p7_zm_vending_nuke";
  level.machine_assets[#"specialty_camper"].on_model = "p7_zm_vending_nuke";
}

function_356a31cb() {
  clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int");
}

function_721cc6dc(state) {}

function_f15d3355(use_trigger, perk_machine, bump_trigger, collision) {
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

function_1dd08a86() {
  self thread function_7424eebb();
}

function_9a3871b7(b_pause, str_perk, str_result, n_slot) {
  self notify(#"specialty_camper" + "_take");
  self function_7b5fc171();
}

function_7424eebb() {
  self endon(#"specialty_camper" + "_take", #"disconnect");

  while(true) {
    if(!self laststand::player_is_in_laststand() && !self util::is_spectating() && !level flag::get("round_reset")) {
      v_current = self.origin;

      if(!isDefined(self.var_3748ec02)) {
        self.var_3748ec02 = v_current;
      }

      n_dist = distance(self.var_3748ec02, v_current);

      if((n_dist <= 65 && !(isDefined(self.var_7d0e99f3) && self.var_7d0e99f3) || n_dist <= 130 && isDefined(self.var_7d0e99f3) && self.var_7d0e99f3) && !(isDefined(self.var_16735873) && self.var_16735873) && !scene::is_igc_active()) {
        if(!isDefined(self.var_7ffce6e0)) {
          self.var_7ffce6e0 = 0;
        }

        self.var_7ffce6e0++;
        self thread function_a84fcb78(self.var_7ffce6e0);
      } else {
        self function_7b5fc171();
      }
    } else {
      self function_7b5fc171();
    }

    wait 0.25;
  }
}

function_7b5fc171() {
  self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 0);
  self zm_armor::remove(#"stronghold_armor", 1);
  self.var_3748ec02 = undefined;
  self.var_807f94d7 = undefined;
  self.var_7ffce6e0 = undefined;
  self.var_7d0e99f3 = undefined;
}

function_a84fcb78(var_3a553e99) {
  var_cf385861 = int(3 / 0.25);

  if(var_3a553e99 == var_cf385861) {
    self.var_7d0e99f3 = 1;
    self.var_3748ec02 = self.origin;
    self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 1);
  }

  if(var_3a553e99 % var_cf385861 == 0) {
    self add_armor();
    self function_c25b980c();
  }
}

add_armor() {
  self zm_armor::add(#"stronghold_armor", 5, 50, #"");
}

function_c25b980c() {
  if(!isDefined(self.var_807f94d7)) {
    self.var_807f94d7 = 0;
  }

  self.var_807f94d7 += 1;
  self.var_807f94d7 = math::clamp(self.var_807f94d7, 0, 15);
}

function_11154900(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(attacker.var_807f94d7)) {
    damage += damage * attacker.var_807f94d7 / 100;
  }

  return damage;
}