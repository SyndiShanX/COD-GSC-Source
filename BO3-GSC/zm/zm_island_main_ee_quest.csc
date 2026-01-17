/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_main_ee_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using_animtree("generic");
#namespace zm_island_main_ee_quest;

function function_30d4f164() {
  clientfield::register("vehicle", "plane_hit_by_aa_gun", 9000, 1, "int", &function_3b831537, 0, 0);
  clientfield::register("scriptmover", "zipline_lightning_fx", 9000, 1, "int", &zipline_lightning_fx, 0, 0);
  clientfield::register("allplayers", "lightning_shield_fx", 9000, 1, "int", &lightning_shield_fx, 1, 1);
  clientfield::register("scriptmover", "smoke_trail_fx", 9000, 1, "int", &smoke_trail_fx, 0, 0);
  clientfield::register("scriptmover", "smoke_smolder_fx", 9000, 1, "int", &function_67a61c, 0, 0);
  clientfield::register("zbarrier", "bgb_lightning_fx", 9000, 1, "int", &bgb_lightning_fx, 0, 0);
  clientfield::register("scriptmover", "perk_lightning_fx", 9000, getminbitcountfornum(6), "int", &perk_lightning_fx, 0, 0);
  clientfield::register("world", "umbra_tome_outro_igc", 9000, 1, "int", &umbra_tome_outro_igc, 0, 0);
}

function function_f0e89ab2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["glow_formula_piece"], self, "j_spineupper");
}

function function_e9572f40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["glow_formula_piece"], self, "j_spineupper");
}

function function_3b831537(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_563d869a = playFXOnTag(localclientnum, level._effect["bomber_explode"], self, "tag_engine_inner_left");
    wait(1);
    self.var_303b0c31 = playFXOnTag(localclientnum, level._effect["bomber_fire_trail"], self, "tag_engine_inner_right");
  } else {
    if(isDefined(self.var_563d869a)) {
      deletefx(localclientnum, self.var_a1d64192);
    }
    if(isDefined(self.var_303b0c31)) {
      deletefx(localclientnum, self.var_a1d64192);
    }
  }
}

function zipline_lightning_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_1f5ac1dc[localclientnum] = playFXOnTag(localclientnum, level._effect["lightning_shield_control_panel"], self, "tag_origin");
  } else if(isDefined(self.var_1f5ac1dc)) {
    a_keys = getarraykeys(self.var_1f5ac1dc);
    if(isinarray(a_keys, localclientnum)) {
      deletefx(localclientnum, self.var_1f5ac1dc[localclientnum], 0);
    }
  }
}

function lightning_shield_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  var_ae6a34c0 = player getlocalclientnumber();
  if(newval == 1) {
    self.var_257ef9e4 = [];
    self.var_42ad0d0c = [];
    if(!isspectating(localclientnum)) {
      if(player === self) {
        self.lightning_shield_fx = playviewmodelfx(localclientnum, level._effect["lightning_shield_1p"], "tag_shield_lightning_fx");
      } else {
        self.var_42ad0d0c[var_ae6a34c0] = undefined;
        self.var_257ef9e4[var_ae6a34c0] = playFXOnTag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
      }
      self thread function_7ddd182c(localclientnum);
    }
  } else {
    self notify("hash_1a229bcb");
    if(!isspectating(localclientnum)) {
      if(player === self) {
        if(isDefined(self.lightning_shield_fx)) {
          deletefx(localclientnum, self.lightning_shield_fx);
          self.lightning_shield_fx = undefined;
        }
      } else {
        if(isDefined(self.var_257ef9e4) && isDefined(self.var_257ef9e4[var_ae6a34c0])) {
          deletefx(var_ae6a34c0, self.var_257ef9e4[var_ae6a34c0]);
          self.var_257ef9e4[var_ae6a34c0] = undefined;
        }
        if(isDefined(self.var_42ad0d0c) && isDefined(self.var_42ad0d0c[var_ae6a34c0])) {
          deletefx(var_ae6a34c0, self.var_42ad0d0c[var_ae6a34c0]);
          self.var_42ad0d0c[var_ae6a34c0] = undefined;
        }
      }
    }
  }
}

function function_7ddd182c(localclientnum) {
  self endon("disconnect");
  self endon("hash_1a229bcb");
  player = getlocalplayer(localclientnum);
  var_ae6a34c0 = player getlocalclientnumber();
  while(true) {
    self waittill("weapon_change");
    currentweapon = getcurrentweapon(localclientnum);
    if(!isspectating(localclientnum)) {
      if(isDefined(currentweapon.isriotshield) && currentweapon.isriotshield) {
        if(player === self) {
          if(!isDefined(self.lightning_shield_fx)) {
            self.lightning_shield_fx = playviewmodelfx(localclientnum, level._effect["lightning_shield_1p"], "tag_shield_lightning_fx");
          }
        } else {
          if(isDefined(self.var_42ad0d0c) && isDefined(self.var_42ad0d0c[var_ae6a34c0])) {
            deletefx(var_ae6a34c0, self.var_42ad0d0c[var_ae6a34c0]);
            self.var_42ad0d0c[var_ae6a34c0] = undefined;
          }
          var_68b2abba = self.var_257ef9e4[var_ae6a34c0];
          if(!isDefined(var_68b2abba)) {
            self.var_257ef9e4[var_ae6a34c0] = playFXOnTag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
          }
        }
      } else if(!isspectating(localclientnum)) {
        if(player === self) {
          if(isDefined(self.lightning_shield_fx)) {
            deletefx(localclientnum, self.lightning_shield_fx);
            self.lightning_shield_fx = undefined;
          }
        } else {
          if(isDefined(self.var_257ef9e4) && isDefined(self.var_257ef9e4[var_ae6a34c0])) {
            deletefx(var_ae6a34c0, self.var_257ef9e4[var_ae6a34c0]);
            self.var_257ef9e4[var_ae6a34c0] = undefined;
          }
          var_14c202b4 = self.var_42ad0d0c[var_ae6a34c0];
          if(!isDefined(var_14c202b4)) {
            self.var_42ad0d0c[var_ae6a34c0] = playFXOnTag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
          }
        }
      }
    }
  }
}

function smoke_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_43991df3 = playFXOnTag(localclientnum, level._effect["gear_smoke_trail"], self, "tag_origin");
  } else if(isDefined(self.var_43991df3)) {
    stopfx(localclientnum, self.var_43991df3);
  }
}

function function_67a61c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_e05c9faa = playFXOnTag(localclientnum, level._effect["gear_smoke_smolder"], self, "tag_origin");
  } else if(isDefined(self.var_e05c9faa)) {
    stopfx(localclientnum, self.var_e05c9faa);
  }
}

function perk_lightning_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0: {
      if(isDefined(self.var_99de3d90)) {
        stopfx(localclientnum, self.var_99de3d90);
      }
      break;
    }
    case 1: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_dbltap"], self, "tag_origin");
      break;
    }
    case 2: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_jugg"], self, "tag_origin");
      break;
    }
    case 3: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_revive"], self, "tag_origin");
      break;
    }
    case 4: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_speed"], self, "tag_origin");
      break;
    }
    case 5: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_staminup"], self, "tag_origin");
      break;
    }
    case 6: {
      self.var_99de3d90 = playFXOnTag(localclientnum, level._effect["perk_lightning_fx_mulekick"], self, "tag_origin");
      break;
    }
  }
}

function bgb_lightning_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_543f3d1d = playFXOnTag(localclientnum, level._effect["bgb_lightning_fx"], self zbarriergetpiece(5), "tag_origin");
  } else if(isDefined(self.var_543f3d1d)) {
    stopfx(localclientnum, self.var_543f3d1d);
  }
}

function umbra_tome_outro_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    umbra_settometrigger(localclientnum, "bunker_armory_tome");
  }
}