/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_sleight_of_hand.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_sleight_of_hand;

function private autoexec __init__system__() {
  system::register(#"zm_perk_sleight_of_hand", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  enable_sleight_of_hand_perk_for_level();
}

function enable_sleight_of_hand_perk_for_level() {
  zm_perks::register_perk_basic_info(#"talent_speedcola", #"perk_sleight_of_hand", 3000, #"hash_1fe685096c4f7bd2", getweapon("zombie_perk_bottle_sleight"), undefined, #"zmperksspeed");
  zm_perks::register_perk_precache_func(#"talent_speedcola", &sleight_of_hand_precache);
  zm_perks::register_perk_clientfields(#"talent_speedcola", &sleight_of_hand_register_clientfield, &sleight_of_hand_set_clientfield);
  zm_perks::register_perk_machine(#"talent_speedcola", &sleight_of_hand_perk_machine_setup, undefined, "p9_fxanim_zm_gp_speed_cola_bundle");
  zm_perks::register_perk_host_migration_params(#"talent_speedcola", "vending_sleight", "sleight_light");
}

function sleight_of_hand_precache() {
  if(isDefined(level.sleight_of_hand_precache_override_func)) {
    [[level.sleight_of_hand_precache_override_func]]();
    return;
  }

  level._effect[#"sleight_light"] = "zombie/fx_perk_speedcola_ndu";
  level.machine_assets[#"talent_speedcola"] = spawnStruct();
  level.machine_assets[#"talent_speedcola"].weapon = getweapon("zombie_perk_bottle_sleight");
  level.machine_assets[#"talent_speedcola"].off_model = "p9_sur_machine_speed_cola_off";
  level.machine_assets[#"talent_speedcola"].on_model = "p9_sur_machine_speed_cola";
}

function sleight_of_hand_register_clientfield() {}

function sleight_of_hand_set_clientfield(state) {}

function sleight_of_hand_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_speed_jingle";
  perk_machine.script_string = "speedcola_perk";
  perk_machine.script_label = "mus_perks_speed_sting";
  perk_machine.target = "vending_sleight";
  bump_trigger.script_string = "speedcola_perk";
  bump_trigger.targetname = "vending_sleight";

  if(isDefined(collision)) {
    collision.script_string = "speedcola_perk";
  }
}