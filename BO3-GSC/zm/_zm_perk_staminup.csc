/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_staminup.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_staminup;

function autoexec __init__sytem__() {
  system::register("zm_perk_staminup", & __init__, undefined, undefined);
}

function __init__() {
  enable_staminup_perk_for_level();
}

function enable_staminup_perk_for_level() {
  zm_perks::register_perk_clientfields("specialty_staminup", & staminup_client_field_func, & staminup_callback_func);
  zm_perks::register_perk_effects("specialty_staminup", "marathon_light");
  zm_perks::register_perk_init_thread("specialty_staminup", & init_staminup);
}

function init_staminup() {
  if(isdefined(level.enable_magic) && level.enable_magic) {
    level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
  }
}

function staminup_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int", undefined, 0, 1);
}

function staminup_callback_func() {}