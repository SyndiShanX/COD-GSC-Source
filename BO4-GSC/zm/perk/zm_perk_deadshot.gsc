/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_deadshot.gsc
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

#namespace zm_perk_deadshot;

autoexec __init__system__() {
  system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

__init__() {
  enable_deadshot_perk_for_level();
}

enable_deadshot_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_deadshot", #"perk_dead_shot", 2000, #"hash_29881d32839ebaa1", getweapon("zombie_perk_bottle_deadshot"), getweapon("zombie_perk_totem_deadshot"), #"zmperksdeadshot");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_deadshot", #"perk_dead_shot", 2000, #"zombie/perk_deadshot", getweapon("zombie_perk_bottle_deadshot"), getweapon("zombie_perk_totem_deadshot"), #"zmperksdeadshot");
  }

  zm_perks::register_perk_precache_func(#"specialty_deadshot", &deadshot_precache);
  zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
  zm_perks::register_perk_machine(#"specialty_deadshot", &deadshot_perk_machine_setup);
  zm_perks::register_perk_threads(#"specialty_deadshot", &give_deadshot_perk, &take_deadshot_perk);
  zm_perks::register_perk_host_migration_params(#"specialty_deadshot", "vending_deadshot", "deadshot_light");
}

deadshot_precache() {
  if(isDefined(level.var_bc5f9f6a)) {
    [[level.var_bc5f9f6a]]();
    return;
  }

  level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
  level.machine_assets[#"specialty_deadshot"] = spawnStruct();
  level.machine_assets[#"specialty_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
  level.machine_assets[#"specialty_deadshot"].off_model = "p7_zm_vending_ads";
  level.machine_assets[#"specialty_deadshot"].on_model = "p7_zm_vending_ads";
}

deadshot_register_clientfield() {
  clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
}

deadshot_set_clientfield(state) {}

deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_deadshot_jingle";
  use_trigger.script_string = "deadshot_perk";
  use_trigger.script_label = "mus_perks_deadshot_sting";
  use_trigger.target = "vending_deadshot";
  perk_machine.script_string = "deadshot_vending";
  perk_machine.targetname = "vending_deadshot";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "deadshot_vending";
  }
}

give_deadshot_perk() {
  self clientfield::set_to_player("deadshot_perk", 1);
}

take_deadshot_perk(b_pause, str_perk, str_result, n_slot) {
  self clientfield::set_to_player("deadshot_perk", 0);
}