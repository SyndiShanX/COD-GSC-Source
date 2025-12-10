/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_lightning.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_staff_common;
#namespace zm_weap_staff_lightning;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_lightning", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["lightning_miss"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_miss";
  level._effect["lightning_arc"] = "dlc5/zmb_weapon/fx_staff_elec_trail_bolt_cheap";
  level._effect["lightning_impact"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_hit_torso";
  level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
  clientfield::register("actor", "lightning_impact_fx", 21000, 1, "int", &function_41819534, 0, 0);
  clientfield::register("scriptmover", "lightning_miss_fx", 21000, 1, "int", &function_6a2c832a, 0, 0);
  clientfield::register("actor", "lightning_arc_fx", 21000, 1, "int", &function_fb3ed342, 0, 0);
  level.var_1d5f245c = [];
  zm_weap_staff::function_4be5e665(getweapon("staff_lightning_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_elec_lv1");
}

function function_41819534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["lightning_impact"], self, "J_SpineUpper");
    self playSound(0, "wpn_imp_lightningstaff");
  }
}

function function_6a2c832a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["lightning_miss"], self, "tag_origin");
    level.var_1d5f245c[localclientnum] = self;
    ent = spawn(0, self.origin, "script_origin");
    ent linkto(self);
    self thread function_80209369(localclientnum, ent);
    level notify("lightning_ball_created");
  }
}

function function_80209369(localclientnum, ent) {
  self waittill("entityshutdown");
  ent delete();
  level.var_1d5f245c[localclientnum] = undefined;
}

function function_749acb79(localclientnum) {
  self endon("entityshutdown");
  self endon("hash_7a8f9f49");
  if(!isDefined(level.var_1d5f245c[localclientnum])) {
    level waittill("lightning_ball_created");
  }
  var_46352a82 = level.var_1d5f245c[localclientnum];
  var_46352a82 endon("entityshutdown");
  util::server_wait(localclientnum, randomfloatrange(0.1, 0.5));
  self.e_fx = spawn(localclientnum, var_46352a82.origin, "script_model");
  self.e_fx setModel("tag_origin");
  self.fx_arc = playFXOnTag(localclientnum, level._effect["lightning_arc"], self.e_fx, "tag_origin");
  while(true) {
    var_8d0b58f1 = self gettagorigin("J_SpineUpper");
    self.e_fx moveto(var_8d0b58f1, 0.1);
    util::server_wait(localclientnum, 0.5);
    self.e_fx moveto(var_46352a82.origin, 0.1);
    util::server_wait(localclientnum, 0.5);
  }
}

function function_fb3ed342(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread function_749acb79(localclientnum);
  } else {
    self notify("hash_7a8f9f49");
    if(isDefined(self.fx_arc)) {
      stopfx(localclientnum, self.fx_arc);
      self.fx_arc = undefined;
    }
    if(isDefined(self.e_fx)) {
      self.e_fx delete();
      self.e_fx = undefined;
    }
  }
}