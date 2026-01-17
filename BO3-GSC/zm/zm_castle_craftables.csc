/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_craftables.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#namespace zm_castle_craftables;

function init_craftables() {
  register_clientfields();
  zm_craftables::add_zombie_craftable("gravityspike");
  level thread zm_craftables::set_clientfield_craftables_code_callbacks();
  level._effect["craftable_powerup_on"] = "dlc1/castle/fx_talon_spike_glow_castle";
  level._effect["craftable_powerup_teleport"] = "dlc1/castle/fx_castle_pap_teleport_parts";
}

function include_craftables() {
  zm_craftables::include_zombie_craftable("gravityspike");
}

function register_clientfields() {
  shared_bits = 1;
  registerclientfield("world", ("gravityspike" + "_") + "part_body", 1, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", ("gravityspike" + "_") + "part_guards", 1, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", ("gravityspike" + "_") + "part_handle", 1, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  clientfield::register("scriptmover", "craftable_powerup_fx", 1, 1, "int", &function_f1838e49, 0, 0);
  clientfield::register("scriptmover", "craftable_teleport_fx", 1, 1, "int", &function_a43a3438, 0, 0);
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("clientuimodel", "zmInventory.widget_gravityspike_parts", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.player_crafted_gravityspikes", 1, 1, "int", undefined, 0, 0);
}

function function_f1838e49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.powerup_fx = playFXOnTag(localclientnum, level._effect["craftable_powerup_on"], self, "tag_origin");
  } else if(isDefined(self.powerup_fx)) {
    deletefx(localclientnum, self.powerup_fx, 1);
    self.powerup_fx = undefined;
  }
}

function function_a43a3438(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFXOnTag(localclientnum, level._effect["craftable_powerup_teleport"], self, "tag_origin");
  }
}