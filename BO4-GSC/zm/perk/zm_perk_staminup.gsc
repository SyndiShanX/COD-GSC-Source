/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_staminup.gsc
***********************************************/

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

#namespace zm_perk_staminup;

autoexec __init__system__() {
  system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

__init__() {
  enable_staminup_perk_for_level();
}

enable_staminup_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_staminup", #"perk_staminup", 2000, #"hash_26af21c3b4413875", getweapon("zombie_perk_bottle_marathon"), getweapon("zombie_perk_totem_staminup"), #"zmperksstaminup");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_staminup", #"perk_staminup", 2000, #"zombie/perk_marathon", getweapon("zombie_perk_bottle_marathon"), getweapon("zombie_perk_totem_staminup"), #"zmperksstaminup");
  }

  zm_perks::register_perk_precache_func(#"specialty_staminup", &staminup_precache);
  zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
  zm_perks::register_perk_machine(#"specialty_staminup", &staminup_perk_machine_setup);
  zm_perks::register_perk_host_migration_params(#"specialty_staminup", "vending_marathon", "marathon_light");
}

staminup_precache() {
  if(isDefined(level.var_cf57ff63)) {
    [[level.var_cf57ff63]]();
    return;
  }

  level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
  level.machine_assets[#"specialty_staminup"] = spawnStruct();
  level.machine_assets[#"specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
  level.machine_assets[#"specialty_staminup"].off_model = "p7_zm_vending_marathon";
  level.machine_assets[#"specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

staminup_register_clientfield() {}

staminup_set_clientfield(state) {}

staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_stamin_jingle";
  use_trigger.script_string = "marathon_perk";
  use_trigger.script_label = "mus_perks_stamin_sting";
  use_trigger.target = "vending_marathon";
  perk_machine.script_string = "marathon_perk";
  perk_machine.targetname = "vending_marathon";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "marathon_perk";
  }
}