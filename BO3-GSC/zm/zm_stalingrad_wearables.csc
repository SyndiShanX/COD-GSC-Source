/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_wearables.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_utility;
#namespace zm_stalingrad_wearables;

function function_ad78a144() {
  clientfield::register("scriptmover", "show_wearable", 12000, 1, "int", & show_wearable, 0, 0);
  for(i = 0; i < 4; i++) {
    registerclientfield("world", ("player" + i) + "wearableItem", 12000, 2, "int", & zm_utility::setsharedinventoryuimodels, 0);
  }
}

function show_wearable(localclientnum, oldval, newval) {
  if(newval) {
    self show();
  } else {
    self hide();
  }
}