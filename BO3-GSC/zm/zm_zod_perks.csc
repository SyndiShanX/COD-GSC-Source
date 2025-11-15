/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_perks.csc
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
#namespace zm_zod_perks;

function init() {
  level._effect["bottle_jugg"] = "zombie/fx_bottle_break_glow_jugg_zmb";
  level._effect["bottle_dtap"] = "zombie/fx_bottle_break_glow_dtap_zmb";
  level._effect["bottle_speed"] = "zombie/fx_bottle_break_glow_speed_zmb";
  clientfield::register("world", "perk_light_speed_cola", 1, 2, "int", & perk_light_speed_cola, 0, 0);
  clientfield::register("world", "perk_light_juggernog", 1, 2, "int", & perk_light_juggernog, 0, 0);
  clientfield::register("world", "perk_light_doubletap", 1, 2, "int", & perk_light_doubletap, 0, 0);
  clientfield::register("world", "perk_light_quick_revive", 1, 1, "int", & perk_light_quick_revive, 0, 0);
  clientfield::register("world", "perk_light_widows_wine", 1, 1, "int", & perk_light_widows_wine, 0, 0);
  clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", & perk_light_mule_kick, 0, 0);
  clientfield::register("world", "perk_light_staminup", 1, 1, "int", & perk_light_staminup, 0, 0);
  clientfield::register("scriptmover", "perk_bottle_speed_cola_fx", 1, 1, "int", & perk_bottle_speed_cola_fx, 0, 0);
  clientfield::register("scriptmover", "perk_bottle_juggernog_fx", 1, 1, "int", & perk_bottle_juggernog_fx, 0, 0);
  clientfield::register("scriptmover", "perk_bottle_doubletap_fx", 1, 1, "int", & perk_bottle_doubletap_fx, 0, 0);
}

function perk_light_speed_cola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level.var_320cd7b4 = ("lgt_vending_speed_" + newval) + "_on";
    exploder::exploder(level.var_320cd7b4);
  } else if(isDefined(level.var_320cd7b4)) {
    exploder::stop_exploder(level.var_320cd7b4);
  }
}

function perk_light_juggernog(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level.var_d1316ad = ("lgt_vending_jugg_" + newval) + "_on";
    exploder::exploder(level.var_d1316ad);
  } else if(isDefined(level.var_d1316ad)) {
    exploder::stop_exploder(level.var_d1316ad);
  }
}

function perk_light_doubletap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level.var_c09154cb = ("lgt_vending_tap_" + newval) + "_on";
    exploder::exploder(level.var_c09154cb);
  } else if(isDefined(level.var_c09154cb)) {
    exploder::stop_exploder(level.var_c09154cb);
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
    exploder::exploder("lgt_vending_stamina_up");
  } else {
    exploder::stop_exploder("lgt_vending_stamina_up");
  }
}

function perk_bottle_speed_cola_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["bottle_speed"], self, "tag_origin");
}

function perk_bottle_juggernog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["bottle_jugg"], self, "tag_origin");
}

function perk_bottle_doubletap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["bottle_dtap"], self, "tag_origin");
}