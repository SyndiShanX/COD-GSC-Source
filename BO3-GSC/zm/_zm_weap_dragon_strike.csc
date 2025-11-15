/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_strike.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace dragon_strike;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragon_strike", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "dragon_strike_spawn_fx", 12000, 1, "int", & dragon_strike_spawn_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_on", 12000, 1, "int", & dragon_strike_marker_on, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_fx", 12000, 1, "counter", & dragon_strike_marker_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx", 12000, 1, "counter", & dragon_strike_marker_upgraded_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_invalid_fx", 12000, 1, "counter", & dragon_strike_marker_invalid_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_invalid_fx", 12000, 1, "counter", & dragon_strike_marker_upgraded_invalid_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_flare_fx", 12000, 1, "int", & dragon_strike_flare_fx, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_fx_fadeout", 12000, 1, "counter", & dragon_strike_marker_fx_fadeout, 0, 0);
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx_fadeout", 12000, 1, "counter", & dragon_strike_marker_upgraded_fx_fadeout, 0, 0);
  clientfield::register("actor", "dragon_strike_zombie_fire", 12000, 2, "int", & dragon_strike_zombie_fire, 0, 0);
  clientfield::register("vehicle", "dragon_strike_zombie_fire", 12000, 2, "int", & dragon_strike_zombie_fire, 0, 0);
  clientfield::register("clientuimodel", "dragon_strike_invalid_use", 12000, 1, "counter", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.showDpadRight_DragonStrike", 12000, 1, "int", undefined, 0, 0);
  level._effect["dragon_strike_portal"] = "dlc3/stalingrad/fx_dragonstrike_portal_flash";
  level._effect["dragon_strike_beacon"] = "dlc3/stalingrad/fx_light_flare_sky_marker_red";
  level._effect["dragon_strike_zombie_fire"] = "dlc3/stalingrad/fx_fire_torso_zmb_green";
  level._effect["dragon_strike_mouth"] = "dlc3/stalingrad/fx_dragon_mouth_drips_boss";
  level._effect["dragon_strike_tongue"] = "dlc3/stalingrad/fx_dragon_mouth_drips_tongue_boss";
}

function dragon_strike_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["dragon_strike_portal"], self, "tag_neck_fx");
    playFXOnTag(localclientnum, level._effect["dragon_strike_mouth"], self, "tag_throat_fx");
    playFXOnTag(localclientnum, level._effect["dragon_strike_tongue"], self, "tag_mouth_floor_fx");
  }
}

function dragon_strike_marker_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self dragonstrike_enable(1);
    self thread function_778495b0(localclientnum);
  } else {
    self notify("hash_e98f7ec4");
    self dragonstrike_enable(0);
  }
}

function function_778495b0(localclientnum) {
  self endon("hash_e98f7ec4");
  self endon("entityshutdown");
  while(isDefined(self)) {
    self dragonstrike_setposition(self.origin);
    wait(0.016);
  }
}

function dragon_strike_marker_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self dragonstrike_setcolorradiusspinpulse(0.25, 3, 0.25, 128, 0.5, 0);
}

function dragon_strike_marker_upgraded_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self dragonstrike_setcolorradiusspinpulse(0.15, 3, 0.15, 128, 0.75, 0);
}

function dragon_strike_marker_invalid_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.5, 0);
}

function dragon_strike_marker_upgraded_invalid_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.75, 0);
}

function dragon_strike_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.fx_flare = playFX(localclientnum, level._effect["dragon_strike_beacon"], self.origin);
  } else if(isDefined(self.fx_flare)) {
    deletefx(localclientnum, self.fx_flare, 1);
    self.fx_flare = undefined;
  }
}

function dragon_strike_marker_fx_fadeout(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_1ba92b11(0.25, 3, 0.25, 0.5);
}

function dragon_strike_marker_upgraded_fx_fadeout(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_1ba92b11(0.15, 3, 0.15, 0.75);
}

function function_1ba92b11(var_6d056a0e, var_9ad65443, var_cddc37e, var_76d07324) {
  var_e0a873d1 = var_6d056a0e / 16;
  var_24ce51da = var_9ad65443 / 16;
  var_1e73d761 = var_cddc37e / 16;
  for(i = 0; i < 16; i++) {
    var_6d056a0e = var_6d056a0e - var_e0a873d1;
    var_9ad65443 = var_9ad65443 - var_24ce51da;
    var_cddc37e = var_cddc37e - var_1e73d761;
    self dragonstrike_setcolorradiusspinpulse(var_6d056a0e, var_9ad65443, var_cddc37e, 128, var_76d07324, 0);
    wait(0.016);
  }
}

function dragon_strike_zombie_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 2) {
    self zombie_death::flame_death_fx(localclientnum);
  } else {
    str_tag = "j_spinelower";
    v_tag = self gettagorigin(str_tag);
    if(!isDefined(v_tag)) {
      str_tag = "tag_origin";
    }
    self.var_9f5c18b = 1;
    if(isDefined(self)) {
      self.dragon_strike_zombie_fire = playFXOnTag(localclientnum, level._effect["dragon_strike_zombie_fire"], self, str_tag);
      self thread function_3cc1555d(localclientnum);
    }
  }
}

function function_3cc1555d(localclientnum) {
  self endon("entityshutdown");
  wait(12);
  if(isDefined(self) && isalive(self)) {
    stopfx(localclientnum, self.dragon_strike_zombie_fire);
    self.var_9f5c18b = 0;
  }
}