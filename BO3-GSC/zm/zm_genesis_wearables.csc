/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_wearables.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_utility;
#namespace zm_genesis_wearables;

function function_ad78a144() {
  for (i = 0; i < 4; i++) {
    registerclientfield("world", ("player" + i) + "wearableItem", 15000, 4, "int", & zm_utility::setsharedinventoryuimodels, 0);
  }
  clientfield::register("clientuimodel", "zmInventory.wearable_perk_icons", 15000, 2, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "battery_fx", 15000, 2, "int", & function_f51349bf, 0, 0);
}

function function_f51349bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isdefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playfx(localclientnum, level._effect["battery_uncharged"], self.origin, anglestoforward(self.angles), (0, 0, 1));
  } else {
    if(newval == 2) {
      if(isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
      }
      self.n_fx_id = playfx(localclientnum, level._effect["battery_charged"], self.origin, anglestoforward(self.angles), (0, 0, 1));
    } else if(isdefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
  }
}