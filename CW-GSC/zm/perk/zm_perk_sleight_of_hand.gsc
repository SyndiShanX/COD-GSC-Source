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
  function_a8fdd433();
}

function function_a8fdd433() {
  zm_perks::register_perk_basic_info(#"talent_speedcola", #"perk_sleight_of_hand", 3000, #"hash_1fe685096c4f7bd2", getweapon("zombie_perk_bottle_sleight"), undefined, #"zmperksspeed");
  zm_perks::register_perk_precache_func(#"talent_speedcola", &function_2ae165ac);
  zm_perks::register_perk_clientfields(#"talent_speedcola", &function_dbaed146, &function_c6ce3670);
  zm_perks::register_perk_machine(#"talent_speedcola", &function_e5c86da9, undefined, "p9_fxanim_zm_gp_speed_cola_bundle");
  zm_perks::register_perk_host_migration_params(#"talent_speedcola", "vending_sleight", "sleight_light");
}

function function_2ae165ac() {
  if(isDefined(level.var_f3775b53)) {
    [[level.var_f3775b53]]();
    return;
  }

  level._effect[#"sleight_light"] = "zombie/fx_perk_speedcola_ndu";
  level.machine_assets[#"talent_speedcola"] = spawnStruct();
  level.machine_assets[#"talent_speedcola"].weapon = getweapon("zombie_perk_bottle_sleight");
  level.machine_assets[#"talent_speedcola"].off_model = "p9_sur_machine_speed_cola_off";
  level.machine_assets[#"talent_speedcola"].on_model = "p9_sur_machine_speed_cola";
}

function function_dbaed146() {}

function function_c6ce3670(state) {}

function function_e5c86da9(use_trigger, perk_machine, bump_trigger, collision) {
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