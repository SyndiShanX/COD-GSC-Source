/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_juggernaut.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_juggernaut;

function autoexec __init__sytem__() {
  system::register("zm_perk_juggernaut", & __init__, undefined, undefined);
}

function __init__() {
  zm_perks::register_perk_clientfields("specialty_armorvest", & juggernaut_client_field_func, & juggernaut_code_callback_func);
  zm_perks::register_perk_effects("specialty_armorvest", "jugger_light");
  zm_perks::register_perk_init_thread("specialty_armorvest", & init_juggernaut);
}

function init_juggernaut() {
  if(isdefined(level.enable_magic) && level.enable_magic) {
    level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_zmb";
  }
}

function juggernaut_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.juggernaut", 1, 2, "int", undefined, 0, 1);
}

function juggernaut_code_callback_func() {}