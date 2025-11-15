/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_magicbox.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace tomb_magicbox;

function autoexec __init__sytem__() {
  system::register("tomb_magicbox", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("zbarrier", "magicbox_initial_fx", 21000, 1, "int", & magicbox_initial_closed_fx, 0, 0);
  clientfield::register("zbarrier", "magicbox_amb_fx", 21000, 2, "int", & magicbox_ambient_fx, 0, 0);
  clientfield::register("zbarrier", "magicbox_open_fx", 21000, 1, "int", & magicbox_open_fx, 0, 0);
  clientfield::register("zbarrier", "magicbox_leaving_fx", 21000, 1, "int", & magicbox_leaving_fx, 0, 0);
}

function magicbox_leaving_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = spawn(localclientnum, self.origin, "script_model");
    self.fx_obj.angles = self.angles;
    self.fx_obj setModel("tag_origin");
  }
  if(newval == 1) {
    self.fx_obj.curr_leaving_fx = playFXOnTag(localclientnum, level._effect["box_is_leaving"], self.fx_obj, "tag_origin");
  }
}

function magicbox_open_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = spawn(localclientnum, self.origin, "script_model");
    self.fx_obj.angles = self.angles;
    self.fx_obj setModel("tag_origin");
  }
  if(!isDefined(self.fx_obj_2)) {
    self.fx_obj_2 = spawn(localclientnum, self.origin, "script_model");
    self.fx_obj_2.angles = self.angles;
    self.fx_obj_2 setModel("tag_origin");
  }
  if(newval == 0) {
    stopfx(localclientnum, self.fx_obj.curr_open_fx);
    self.fx_obj_2 stoploopsound(1);
    self notify("magicbox_portal_finished");
  } else if(newval == 1) {
    self.fx_obj.curr_open_fx = playFXOnTag(localclientnum, level._effect["box_is_open"], self.fx_obj, "tag_origin");
    self.fx_obj_2 playLoopSound("zmb_hellbox_open_effect");
    self thread fx_magicbox_portal(localclientnum);
  }
}

function fx_magicbox_portal(localclientnum) {
  wait(0.5);
  self.fx_obj_2.curr_portal_fx = playFXOnTag(localclientnum, level._effect["box_portal"], self.fx_obj_2, "tag_origin");
  self waittill("magicbox_portal_finished");
  stopfx(localclientnum, self.fx_obj_2.curr_portal_fx);
}

function magicbox_initial_closed_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = spawn(localclientnum, self.origin, "script_model");
    self.fx_obj.angles = self.angles;
    self.fx_obj setModel("tag_origin");
  } else {
    return;
  }
  if(newval == 1) {
    self.fx_obj playLoopSound("zmb_hellbox_amb_low");
  }
}

function magicbox_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = spawn(localclientnum, self.origin, "script_model");
    self.fx_obj.angles = self.angles;
    self.fx_obj setModel("tag_origin");
  }
  if(isDefined(self.fx_obj.curr_amb_fx)) {
    stopfx(localclientnum, self.fx_obj.curr_amb_fx);
  }
  if(isDefined(self.fx_obj.curr_amb_fx_power)) {
    stopfx(localclientnum, self.fx_obj.curr_amb_fx_power);
  }
  if(newval == 0) {
    self.fx_obj playLoopSound("zmb_hellbox_amb_low");
    playSound(0, "zmb_hellbox_leave", self.fx_obj.origin);
    stopfx(localclientnum, self.fx_obj.curr_amb_fx);
  } else {
    if(newval == 1) {
      self.fx_obj.curr_amb_fx_power = playFXOnTag(localclientnum, level._effect["box_unpowered"], self.fx_obj, "tag_origin");
      self.fx_obj.curr_amb_fx = playFXOnTag(localclientnum, level._effect["box_here_ambient"], self.fx_obj, "tag_origin");
      self.fx_obj playLoopSound("zmb_hellbox_amb_low");
      playSound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
    } else {
      if(newval == 2) {
        self.fx_obj.curr_amb_fx_power = playFXOnTag(localclientnum, level._effect["box_powered"], self.fx_obj, "tag_origin");
        self.fx_obj.curr_amb_fx = playFXOnTag(localclientnum, level._effect["box_here_ambient"], self.fx_obj, "tag_origin");
        self.fx_obj playLoopSound("zmb_hellbox_amb_high");
        playSound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
      } else if(newval == 3) {
        self.fx_obj.curr_amb_fx_power = playFXOnTag(localclientnum, level._effect["box_unpowered"], self.fx_obj, "tag_origin");
        self.fx_obj.curr_amb_fx = playFXOnTag(localclientnum, level._effect["box_gone_ambient"], self.fx_obj, "tag_origin");
        self.fx_obj playLoopSound("zmb_hellbox_amb_high");
        playSound(0, "zmb_hellbox_leave", self.fx_obj.origin);
      }
    }
  }
}