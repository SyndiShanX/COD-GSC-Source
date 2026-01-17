/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\craftables\_zm_craft_shield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_powerup_shield_charge;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\craftables\_zm_craftables;
#namespace zm_craft_shield;

function autoexec __init__sytem__() {
  system::register("zm_craft_shield", &__init__, undefined, undefined);
}

function __init__() {
  zm_craftables::include_zombie_craftable("craft_shield_zm");
  zm_craftables::add_zombie_craftable("craft_shield_zm");
  registerclientfield("world", "piece_riotshield_dolly", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
  registerclientfield("world", "piece_riotshield_door", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
  registerclientfield("world", "piece_riotshield_clamp", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
  clientfield::register("toplayer", "ZMUI_SHIELD_PART_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("toplayer", "ZMUI_SHIELD_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
}