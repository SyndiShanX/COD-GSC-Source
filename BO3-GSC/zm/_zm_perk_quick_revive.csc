/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_quick_revive.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_quick_revive;

function autoexec __init__sytem__() {
  system::register("zm_perk_quick_revive", &__init__, undefined, undefined);
}

function __init__() {
  enable_quick_revive_perk_for_level();
}

function enable_quick_revive_perk_for_level() {
  zm_perks::register_perk_clientfields("specialty_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
  zm_perks::register_perk_effects("specialty_quickrevive", "revive_light");
  zm_perks::register_perk_init_thread("specialty_quickrevive", &init_quick_revive);
}

function init_quick_revive() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect["revive_light"] = "zombie/fx_perk_quick_revive_zmb";
  }
}

function quick_revive_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.quick_revive", 1, 2, "int", undefined, 0, 1);
}

function quick_revive_callback_func() {}