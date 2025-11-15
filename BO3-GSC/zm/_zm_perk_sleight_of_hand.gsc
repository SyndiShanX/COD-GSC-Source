/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_sleight_of_hand.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_perk_sleight_of_hand;

function autoexec __init__sytem__() {
  system::register("zm_perk_sleight_of_hand", & __init__, undefined, undefined);
}

function __init__() {
  enable_sleight_of_hand_perk_for_level();
}

function enable_sleight_of_hand_perk_for_level() {
  zm_perks::register_perk_basic_info("specialty_fastreload", "sleight", 3000, & "ZOMBIE_PERK_FASTRELOAD", getweapon("zombie_perk_bottle_sleight"));
  zm_perks::register_perk_precache_func("specialty_fastreload", & sleight_of_hand_precache);
  zm_perks::register_perk_clientfields("specialty_fastreload", & sleight_of_hand_register_clientfield, & sleight_of_hand_set_clientfield);
  zm_perks::register_perk_machine("specialty_fastreload", & sleight_of_hand_perk_machine_setup);
  zm_perks::register_perk_host_migration_params("specialty_fastreload", "vending_sleight", "sleight_light");
}

function sleight_of_hand_precache() {
  if(isDefined(level.sleight_of_hand_precache_override_func)) {
    [[level.sleight_of_hand_precache_override_func]]();
    return;
  }
  level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_zmb";
  level.machine_assets["specialty_fastreload"] = spawnStruct();
  level.machine_assets["specialty_fastreload"].weapon = getweapon("zombie_perk_bottle_sleight");
  level.machine_assets["specialty_fastreload"].off_model = "p7_zm_vending_sleight";
  level.machine_assets["specialty_fastreload"].on_model = "p7_zm_vending_sleight";
}

function sleight_of_hand_register_clientfield() {
  clientfield::register("clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int");
}

function sleight_of_hand_set_clientfield(state) {
  self clientfield::set_player_uimodel("hudItems.perks.sleight_of_hand", state);
}

function sleight_of_hand_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_speed_jingle";
  use_trigger.script_string = "speedcola_perk";
  use_trigger.script_label = "mus_perks_speed_sting";
  use_trigger.target = "vending_sleight";
  perk_machine.script_string = "speedcola_perk";
  perk_machine.targetname = "vending_sleight";
  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "speedcola_perk";
  }
}