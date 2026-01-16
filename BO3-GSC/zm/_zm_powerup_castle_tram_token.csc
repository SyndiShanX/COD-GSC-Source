/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_castle_tram_token.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_powerup_castle_tram_token;

function autoexec __init__sytem__() {
  system::register("zm_powerup_castle_tram_token", & __init__, undefined, undefined);
}

function __init__() {
  register_clientfields();
  zm_powerups::include_zombie_powerup("castle_tram_token");
  zm_powerups::add_zombie_powerup("castle_tram_token");
  level._effect["fuse_pickup_fx"] = "dlc1/castle/fx_glow_115_fuse_pickup_castle";
}

function register_clientfields() {
  clientfield::register("toplayer", "has_castle_tram_token", 1, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "ZM_CASTLE_TRAM_TOKEN_ACQUIRED", 1, 1, "int", & zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("scriptmover", "powerup_fuse_fx", 1, 1, "int", & function_4f546258, 0, 0);
  for (i = 0; i < 4; i++) {
    registerclientfield("world", ("player" + i) + "hasItem", 1, 1, "int", & zm_utility::setsharedinventoryuimodels, 0);
  }
  clientfield::register("clientuimodel", "zmInventory.player_using_sprayer", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_sprayer", 1, 1, "int", undefined, 0, 0);
}

function function_4f546258(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.powerup_fuse_fx = playfxontag(localclientnum, level._effect["fuse_pickup_fx"], self, "j_fuse_main");
  }
}