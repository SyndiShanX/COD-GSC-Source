/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow_storm.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_elemental_bow;
#namespace _zm_weap_elemental_bow_storm;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow_storm", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "elemental_bow_storm" + "_ambient_bow_fx", 5000, 1, "int", &function_e73829fb, 0, 0);
  clientfield::register("missile", "elemental_bow_storm" + "_arrow_impact_fx", 5000, 1, "int", &function_93740776, 0, 0);
  clientfield::register("missile", "elemental_bow_storm4" + "_arrow_impact_fx", 5000, 1, "int", &function_c50a03db, 0, 0);
  clientfield::register("scriptmover", "elem_storm_fx", 5000, 1, "int", &elem_storm_fx, 0, 0);
  clientfield::register("toplayer", "elem_storm_whirlwind_rumble", 1, 1, "int", &elem_storm_whirlwind_rumble, 0, 0);
  clientfield::register("scriptmover", "elem_storm_bolt_fx", 5000, 1, "int", &elem_storm_bolt_fx, 0, 0);
  clientfield::register("scriptmover", "elem_storm_zap_ambient", 5000, 1, "int", &elem_storm_zap_ambient, 0, 0);
  clientfield::register("actor", "elem_storm_shock_fx", 5000, 2, "int", &elem_storm_shock_fx, 0, 0);
  level._effect["elem_storm_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_storm_ambient_1p_zmb";
  level._effect["elem_storm_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_storm_impact_zmb";
  level._effect["elem_storm_arrow_charged_impact"] = "dlc1/zmb_weapon/fx_bow_storm_impact_ug_zmb";
  level._effect["elem_storm_whirlwind_loop"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_loop_zmb";
  level._effect["elem_storm_whirlwind_end"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_end_zmb";
  level._effect["elem_storm_zap_ambient"] = "dlc1/zmb_weapon/fx_bow_storm_orb_zmb";
  level._effect["elem_storm_zap_bolt"] = "dlc1/zmb_weapon/fx_bow_storm_bolt_zap_zmb";
  level._effect["elem_storm_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
  level._effect["elem_storm_shock"] = "zombie/fx_tesla_shock_zmb";
  level._effect["elem_storm_shock_nonfatal"] = "zombie/fx_bmode_shock_os_zod_zmb";
}

function function_e73829fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zm_weap_elemental_bow::function_3158b481(localclientnum, newval, "elem_storm_ambient_bow");
}

function function_93740776(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["elem_storm_arrow_impact"], self.origin);
  }
}

function function_c50a03db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["elem_storm_arrow_charged_impact"], self.origin);
  }
}

function elem_storm_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval) {
    self.var_53f7dac0 = playFXOnTag(localclientnum, level._effect["elem_storm_whirlwind_loop"], self, "tag_origin");
  } else {
    if(isDefined(self.var_53f7dac0)) {
      deletefx(localclientnum, self.var_53f7dac0, 0);
      self.var_53f7dac0 = undefined;
    }
    wait(0.4);
    playFX(localclientnum, level._effect["elem_storm_whirlwind_end"], self.origin);
  }
}

function elem_storm_whirlwind_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_4d18057(localclientnum);
  } else {
    self notify("hash_171d986a");
  }
}

function function_4d18057(localclientnum) {
  level endon("demo_jump");
  self endon("hash_171d986a");
  self endon("death");
  while(isDefined(self)) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
    wait(0.075);
  }
}

function elem_storm_bolt_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.var_ca6ae14c)) {
      deletefx(localclientnum, self.var_ca6ae14c, 0);
      self.var_ca6ae14c = undefined;
    }
    v_forward = anglesToForward(self.angles);
    v_up = anglestoup(self.angles);
    self.var_ca6ae14c = playFXOnTag(localclientnum, level._effect["elem_storm_zap_bolt"], self, "tag_origin");
  }
}

function elem_storm_zap_ambient(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_dab5ed7 = playFXOnTag(localclientnum, level._effect["elem_storm_zap_ambient"], self, "tag_origin");
  } else {
    deletefx(localclientnum, self.var_dab5ed7, 0);
    self.var_dab5ed7 = undefined;
  }
}

function elem_storm_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  tag = (self isai() ? "J_SpineUpper" : "tag_origin");
  switch (newval) {
    case 0: {
      if(isDefined(self.var_a9b1ee1b)) {
        deletefx(localclientnum, self.var_a9b1ee1b, 1);
      }
      if(isDefined(self.var_ae1320f9)) {
        deletefx(localclientnum, self.var_ae1320f9, 1);
      }
      if(isDefined(self.var_523596b1)) {
        deletefx(localclientnum, self.var_523596b1, 1);
      }
      self.var_a9b1ee1b = undefined;
      self.var_ae1320f9 = undefined;
      self.var_bb955880 = undefined;
      break;
    }
    case 1: {
      if(!isDefined(self.var_ae1320f9)) {
        self.var_ae1320f9 = playFXOnTag(localclientnum, level._effect["elem_storm_shock"], self, tag);
      }
      break;
    }
    case 2: {
      if(!isDefined(self.var_a9b1ee1b)) {
        self.var_111812ed = playFXOnTag(localclientnum, level._effect["elem_storm_shock_eyes"], self, "J_Eyeball_LE");
      }
      if(!isDefined(self.var_ae1320f9)) {
        self.var_ae1320f9 = playFXOnTag(localclientnum, level._effect["elem_storm_shock"], self, tag);
      }
      if(!isDefined(self.var_523596b1)) {
        self.var_523596b1 = playFXOnTag(localclientnum, level._effect["elem_storm_shock_nonfatal"], self, tag);
      }
      break;
    }
  }
}