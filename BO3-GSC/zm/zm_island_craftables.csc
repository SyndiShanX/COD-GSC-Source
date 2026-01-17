/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_craftables.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#namespace zm_island_craftables;

function init_craftables() {
  register_clientfields();
  zm_craftables::add_zombie_craftable("gasmask");
  level thread zm_craftables::set_clientfield_craftables_code_callbacks();
}

function include_craftables() {
  zm_craftables::include_zombie_craftable("gasmask");
}

function register_clientfields() {
  shared_bits = 1;
  registerclientfield("world", ("gasmask" + "_") + "part_visor", 9000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", ("gasmask" + "_") + "part_filter", 9000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", ("gasmask" + "_") + "part_strap", 9000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 9000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 9000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
}