/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_perks.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#namespace zm_castle_perks;

function init() {
  clientfield::register("world", "perk_light_doubletap", 5000, 1, "int", & perk_light_doubletap, 0, 0);
  clientfield::register("world", "perk_light_juggernaut", 5000, 1, "int", & perk_light_juggernaut, 0, 0);
  clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", & perk_light_mule_kick, 0, 0);
  clientfield::register("world", "perk_light_quick_revive", 5000, 1, "int", & perk_light_quick_revive, 0, 0);
  clientfield::register("world", "perk_light_speed_cola", 5000, 1, "int", & perk_light_speed_cola, 0, 0);
  clientfield::register("world", "perk_light_staminup", 5000, 1, "int", & perk_light_staminup, 0, 0);
  clientfield::register("world", "perk_light_widows_wine", 5000, 1, "int", & perk_light_widows_wine, 0, 0);
}

function perk_light_speed_cola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_speed_on");
  } else {
    exploder::stop_exploder("lgt_vending_speed_on");
  }
}

function perk_light_juggernaut(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_jugg_on");
  } else {
    exploder::stop_exploder("lgt_vending_jugg_on");
  }
}

function perk_light_doubletap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_tap_on");
  } else {
    exploder::stop_exploder("lgt_vending_tap_on");
  }
}

function perk_light_quick_revive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("quick_revive_lgts");
  } else {
    exploder::stop_exploder("quick_revive_lgts");
  }
}

function perk_light_widows_wine(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_widows_wine_on");
  } else {
    exploder::stop_exploder("lgt_vending_widows_wine_on");
  }
}

function perk_light_mule_kick(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_mulekick_on");
  } else {
    exploder::stop_exploder("lgt_vending_mulekick_on");
  }
}

function perk_light_staminup(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("lgt_vending_ stamina_up");
  } else {
    exploder::stop_exploder("lgt_vending_ stamina_up");
  }
}