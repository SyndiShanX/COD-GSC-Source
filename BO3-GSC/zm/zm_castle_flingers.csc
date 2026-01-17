/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_flingers.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#namespace zm_castle_flingers;

function main() {
  register_clientfields();
  level._effect["flinger_launch"] = "dlc1/castle/fx_elec_jumppad";
  level._effect["flinger_land"] = "dlc1/castle/fx_dust_landingpad";
  level._effect["flinger_trail"] = "dlc1/castle/fx_elec_jumppad_player_trail";
  level._effect["landing_pad_glow"] = "dlc1/castle/fx_elec_landingpad_glow";
}

function register_clientfields() {
  clientfield::register("toplayer", "flinger_flying_postfx", 1, 1, "int", &flinger_flying_postfx, 0, 0);
  clientfield::register("toplayer", "flinger_land_smash", 1, 1, "counter", &flinger_land_smash, 0, 0);
  clientfield::register("scriptmover", "player_visibility", 1, 1, "int", &function_a0a5829, 0, 0);
  clientfield::register("scriptmover", "flinger_launch_fx", 1, 1, "counter", &function_3762396c, 0, 0);
  clientfield::register("scriptmover", "flinger_pad_active_fx", 1, 1, "int", &flinger_pad_active_fx, 0, 0);
}

function flinger_flying_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_6f6f69f0 = playFXOnTag(localclientnum, level._effect["flinger_trail"], self, "tag_origin");
    self.var_bb0de733 = self playLoopSound("zmb_fling_windwhoosh_2d");
    self thread postfx::playpostfxbundle("pstfx_zm_screen_warp");
  } else {
    if(isDefined(self.var_6f6f69f0)) {
      deletefx(localclientnum, self.var_6f6f69f0, 1);
      self.var_6f6f69f0 = undefined;
    }
    if(isDefined(self.var_bb0de733)) {
      self stoploopsound(self.var_bb0de733, 0.75);
      self.var_bb0de733 = undefined;
    }
    self thread postfx::exitpostfxbundle();
  }
}

function flinger_pad_active_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_c64ddf2c = playFXOnTag(localclientnum, level._effect["landing_pad_glow"], self, "tag_origin");
  } else if(isDefined(self.var_c64ddf2c)) {
    deletefx(localclientnum, self.var_c64ddf2c, 1);
    self.var_c64ddf2c = undefined;
  }
}

function flinger_land_smash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["flinger_land"], self, "tag_origin");
}

function function_3762396c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["flinger_launch"], self, "tag_origin");
}

function function_a0a5829(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self.owner == getlocalplayer(localclientnum)) {
      self thread function_7bd5b92f(localclientnum);
    }
  }
}

function function_7bd5b92f(localclientnum) {
  player = getlocalplayer(localclientnum);
  if(isDefined(player)) {
    if(isthirdperson(localclientnum)) {
      self show();
      player hide();
    } else {
      self hide();
    }
  }
}