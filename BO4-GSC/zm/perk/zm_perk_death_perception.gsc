/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_death_perception.gsc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_death_perception;

autoexec __init__system__() {
  system::register(#"zm_perk_death_perception", &__init__, &__main__, undefined);
}

__init__() {
  enable_death_perception_perk_for_level();
}

__main__() {}

enable_death_perception_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_awareness", #"perk_death_perception", 2000, #"hash_237b1e920f98800b", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"zmperksdeathperception");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_awareness", #"perk_death_perception", 2000, #"hash_44056ea72a6d4fd5", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"zmperksdeathperception");
  }

  zm_perks::register_perk_precache_func(#"specialty_awareness", &function_f9d745da);
  zm_perks::register_perk_clientfields(#"specialty_awareness", &function_14ab8b5c, &function_a19424cd);
  zm_perks::register_perk_machine(#"specialty_awareness", &function_6bdb193c, &function_9b484511);
  zm_perks::register_perk_host_migration_params(#"specialty_awareness", "p7_zm_vending_nuke", "divetonuke_light");
  zm_perks::register_perk_threads(#"specialty_awareness", &function_79d54e51, &function_86a6368e);
}

function_9b484511() {}

function_f9d745da() {
  level.machine_assets[#"specialty_awareness"] = spawnStruct();
  level.machine_assets[#"specialty_awareness"].weapon = getweapon("zombie_perk_bottle_death_perception");
  level.machine_assets[#"specialty_awareness"].off_model = "p7_zm_vending_nuke";
  level.machine_assets[#"specialty_awareness"].on_model = "p7_zm_vending_nuke";
}

function_14ab8b5c() {
  clientfield::register("toplayer", "perk_death_perception_visuals", 1, 1, "int");
}

function_a19424cd(state) {}

function_6bdb193c(use_trigger, perk_machine, bump_trigger, collision) {
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

function_79d54e51() {
  self clientfield::set_to_player("perk_death_perception_visuals", 1);
}

function_86a6368e(b_pause, str_perk, str_result, n_slot) {
  self clientfield::set_to_player("perk_death_perception_visuals", 0);
}