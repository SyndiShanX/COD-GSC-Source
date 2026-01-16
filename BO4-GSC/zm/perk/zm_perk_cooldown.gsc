/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_cooldown.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_cooldown;

autoexec __init__system__() {
  system::register(#"zm_perk_cooldown", &__init__, &__main__, undefined);
}

__init__() {
  enable_cooldown_perk_for_level();
}

__main__() {}

enable_cooldown_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_cooldown", #"perk_cooldown", 1500, #"hash_1bf5482d3d2bee30", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"zmperkscooldown");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_cooldown", #"perk_cooldown", 1500, #"zombie/perk_cooldown", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"zmperkscooldown");
  }

  zm_perks::register_perk_precache_func(#"specialty_cooldown", &function_14afd300);
  zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_eaa4f1a1, &function_bfc02d23);
  zm_perks::register_perk_machine(#"specialty_cooldown", &function_cf203b00, &init_cooldown);
  zm_perks::register_perk_host_migration_params(#"specialty_cooldown", "p7_zm_vending_nuke", "divetonuke_light");
  zm_perks::register_perk_threads(#"specialty_cooldown", &function_44cf89d3, &function_d0623d8c);
}

init_cooldown() {}

function_14afd300() {
  if(isDefined(level.var_8ba0e035)) {
    [[level.var_8ba0e035]]();
    return;
  }

  level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
  level.machine_assets[#"specialty_cooldown"] = spawnStruct();
  level.machine_assets[#"specialty_cooldown"].weapon = getweapon("zombie_perk_bottle_cooldown");
  level.machine_assets[#"specialty_cooldown"].off_model = "p7_zm_vending_nuke";
  level.machine_assets[#"specialty_cooldown"].on_model = "p7_zm_vending_nuke";
}

function_eaa4f1a1() {}

function_bfc02d23(state) {}

function_cf203b00(use_trigger, perk_machine, bump_trigger, collision) {
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

function_8ba0e035() {
  level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
}

function_44cf89d3() {}

function_d0623d8c(b_pause, str_perk, str_result, n_slot) {}