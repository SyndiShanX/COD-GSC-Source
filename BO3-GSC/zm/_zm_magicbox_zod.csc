/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_magicbox_zod.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_magicbox_zod;

function init() {
  level._effect["box_open"] = "zombie/fx_weapon_box_open_zod_zmb";
  level._effect["box_closed"] = "zombie/fx_weapon_box_closed_zod_zmb";
  registerclientfield("zbarrier", "magicbox_initial_fx", 1, 1, "int", &magicbox_initial_closed_fx);
  registerclientfield("zbarrier", "magicbox_amb_sound", 1, 1, "int", &magicbox_ambient_sound);
  registerclientfield("zbarrier", "magicbox_open_fx", 1, 2, "int", &magicbox_open_fx);
}

function magicbox_open_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
  }
  if(!isDefined(self.fx_obj_2)) {
    self.fx_obj_2 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
  }
  switch (newval) {
    case 0:
    case 3: {
      if(isDefined(self.fx_obj.curr_open_fx)) {
        stopfx(localclientnum, self.fx_obj.curr_open_fx);
      }
      self.fx_obj.curr_amb_fx = playFXOnTag(localclientnum, level._effect["box_closed"], self.fx_obj, "tag_origin");
      self.fx_obj_2 stopallloopsounds(1);
      self notify("magicbox_portal_finished");
      break;
    }
    case 1: {
      if(isDefined(self.fx_obj.curr_amb_fx)) {
        stopfx(localclientnum, self.fx_obj.curr_amb_fx);
      }
      self.fx_obj.curr_open_fx = playFXOnTag(localclientnum, level._effect["box_open"], self.fx_obj, "tag_origin");
      self.fx_obj_2 playLoopSound("zmb_hellbox_open_effect");
      break;
    }
    case 2: {
      self.fx_obj delete();
      self.fx_obj_2 delete();
      break;
    }
  }
}

function magicbox_initial_closed_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
  } else {
    return;
  }
  if(newval == 1) {
    self.fx_obj playLoopSound("zmb_hellbox_amb_low");
  }
}

function magicbox_ambient_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.fx_obj)) {
    self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
  }
  if(isDefined(self.fx_obj.curr_amb_fx)) {
    stopfx(localclientnum, self.fx_obj.curr_amb_fx);
  }
  if(newval == 0) {
    self.fx_obj playLoopSound("zmb_hellbox_amb_low");
    playSound(0, "zmb_hellbox_leave", self.fx_obj.origin);
  } else if(newval == 1) {
    self.fx_obj playLoopSound("zmb_hellbox_amb_low");
    playSound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
  }
}