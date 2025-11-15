/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_water.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_staff_common;
#namespace zm_weap_staff_water;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_water", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "staff_blizzard_fx", 21000, 1, "int", & staff_blizzard_fx, 1, 0);
  clientfield::register("actor", "attach_bullet_model", 21000, 1, "int", & attach_model, 0, 0);
  clientfield::register("actor", "staff_shatter_fx", 21000, 1, "int", & staff_shatter_fx, 0, 0);
  level._effect["staff_water_blizzard"] = "dlc5/zmb_weapon/fx_staff_ice_impact_ug_hit";
  level._effect["staff_water_ice_shard"] = "dlc5/zmb_weapon/fx_staff_ice_trail_bolt";
  level._effect["staff_water_shatter"] = "dlc5/zmb_weapon/fx_staff_ice_exp";
  clientfield::register("actor", "anim_rate", 21000, 2, "float", undefined, 0, 0);
  setupclientfieldanimspeedcallbacks("actor", 1, "anim_rate");
  zm_weap_staff::function_4be5e665(getweapon("staff_water_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_ice_lv1");
}

function attach_model(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_69090dac)) {
      stopfx(localclientnum, self.var_69090dac);
    }
    self.var_69090dac = playFXOnTag(localclientnum, level._effect["staff_water_ice_shard"], self, "j_spine4");
    self thread function_9a8e9819(localclientnum);
    self playSound(0, "wpn_waterstaff_freeze_zombie");
  } else {
    if(isDefined(self.var_69090dac)) {
      deletefx(localclientnum, self.var_69090dac);
      self.var_69090dac = undefined;
    }
    self thread function_56ddd8d9(localclientnum);
  }
}

function function_9a8e9819(localclientnum) {
  self endon("entityshutdown");
  self endon("unfreeze");
  var_5e5728a8 = 0.9;
  rate = randomfloatrange(0.005, 0.01);
  f = 0.6;
  while(f <= var_5e5728a8) {
    self setshaderconstant(localclientnum, 0, f, 1, 0, 0);
    util::server_wait(localclientnum, 0.05);
    f = f + 0.01;
  }
}

function function_56ddd8d9(localclientnum) {
  self endon("entityshutdown");
  self notify("unfreeze");
  f = 1;
  while(f >= 0.6) {
    self setshaderconstant(localclientnum, 0, f, 1, 0, 0);
    util::server_wait(localclientnum, 0.05);
    f = f - 0.05;
  }
  self setshaderconstant(localclientnum, 0, 0, 0, 0, 0);
}

function staff_blizzard_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.var_80b4df3 = playFXOnTag(localclientnum, level._effect["staff_water_blizzard"], self, "tag_origin");
    if(!isDefined(self.sndent)) {
      self.sndent = spawn(0, self.origin, "script_origin");
      self.sndent playSound(0, "wpn_waterstaff_storm_imp");
      self.sndent.n_id = self.sndent playLoopSound("wpn_waterstaff_storm");
    }
  } else {
    if(isDefined(self.var_80b4df3)) {
      stopfx(localclientnum, self.var_80b4df3);
    }
    if(isDefined(self.sndent)) {
      self.sndent stoploopsound(self.sndent.n_id, 1.5);
      self.sndent delete();
      self.sndent = undefined;
    }
  }
}

function staff_shatter_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.var_5d11d365 = playFXOnTag(localclientnum, level._effect["staff_water_shatter"], self, "J_SpineLower");
  }
}