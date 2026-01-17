/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_dragon_strike.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace namespace_19e79ea1;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_dragon_strike", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "lockbox_light_1", 12000, 2, "int", &lockbox_light_1, 0, 0);
  clientfield::register("scriptmover", "lockbox_light_2", 12000, 2, "int", &lockbox_light_2, 0, 0);
  clientfield::register("scriptmover", "lockbox_light_3", 12000, 2, "int", &lockbox_light_3, 0, 0);
  clientfield::register("scriptmover", "lockbox_light_4", 12000, 2, "int", &lockbox_light_4, 0, 0);
}

function lockbox_light_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx_light_1)) {
    stopfx(localclientnum, self.fx_light_1);
  }
  if(newval == 2) {
    self.fx_light_1 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "0");
  } else {
    self.fx_light_1 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "0");
  }
}

function lockbox_light_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx_light_2)) {
    stopfx(localclientnum, self.fx_light_2);
  }
  if(newval == 2) {
    self.fx_light_2 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "1");
  } else {
    self.fx_light_2 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "1");
  }
}

function lockbox_light_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx_light_3)) {
    stopfx(localclientnum, self.fx_light_3);
  }
  if(newval == 2) {
    self.fx_light_3 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "2");
  } else {
    self.fx_light_3 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "2");
  }
}

function lockbox_light_4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_b9f32487)) {
    stopfx(localclientnum, self.var_b9f32487);
  }
  if(newval == 2) {
    self.var_b9f32487 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "3");
  } else {
    self.var_b9f32487 = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "3");
  }
}