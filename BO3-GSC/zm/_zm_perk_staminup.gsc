/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_staminup.gsc
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
#namespace zm_perk_staminup;

function autoexec __init__sytem__() {
  system::register("zm_perk_staminup", & __init__, undefined, undefined);
}

function __init__() {
  enable_staminup_perk_for_level();
}

function enable_staminup_perk_for_level() {
  zm_perks::register_perk_basic_info("specialty_staminup", "marathon", 2000, & "ZOMBIE_PERK_MARATHON", getweapon("zombie_perk_bottle_marathon"));
  zm_perks::register_perk_precache_func("specialty_staminup", & staminup_precache);
  zm_perks::register_perk_clientfields("specialty_staminup", & staminup_register_clientfield, & staminup_set_clientfield);
  zm_perks::register_perk_machine("specialty_staminup", & staminup_perk_machine_setup);
  zm_perks::register_perk_host_migration_params("specialty_staminup", "vending_marathon", "marathon_light");
}

function staminup_precache() {
  if(isdefined(level.staminup_precache_override_func)) {
    [
      [level.staminup_precache_override_func]
    ]();
    return;
  }
  level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
  level.machine_assets["specialty_staminup"] = spawnstruct();
  level.machine_assets["specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
  level.machine_assets["specialty_staminup"].off_model = "p7_zm_vending_marathon";
  level.machine_assets["specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

function staminup_register_clientfield() {
  clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
}

function staminup_set_clientfield(state) {
  self clientfield::set_player_uimodel("hudItems.perks.marathon", state);
}

function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_stamin_jingle";
  use_trigger.script_string = "marathon_perk";
  use_trigger.script_label = "mus_perks_stamin_sting";
  use_trigger.target = "vending_marathon";
  perk_machine.script_string = "marathon_perk";
  perk_machine.targetname = "vending_marathon";
  if(isdefined(bump_trigger)) {
    bump_trigger.script_string = "marathon_perk";
  }
}