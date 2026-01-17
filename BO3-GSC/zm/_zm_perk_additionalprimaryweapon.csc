/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_additionalprimaryweapon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_additionalprimaryweapon;

function autoexec __init__sytem__() {
  system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

function __init__() {
  enable_additional_primary_weapon_perk_for_level();
}

function enable_additional_primary_weapon_perk_for_level() {
  zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
  zm_perks::register_perk_effects("specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
  zm_perks::register_perk_init_thread("specialty_additionalprimaryweapon", &init_additional_primary_weapon);
}

function init_additional_primary_weapon() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
  }
}

function additional_primary_weapon_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

function additional_primary_weapon_code_callback_func() {}