/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_side_ee_good_thrasher.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_island_side_ee_good_thrasher;

function init() {
  var_b20c97f = getminbitcountfornum(7);
  var_1b7d5552 = getminbitcountfornum(3);
  clientfield::register("scriptmover", "side_ee_gt_spore_glow_fx", 9000, 1, "int", &side_ee_gt_spore_glow_fx, 0, 0);
  clientfield::register("scriptmover", "side_ee_gt_spore_cloud_fx", 9000, var_b20c97f, "int", &side_ee_gt_spore_cloud_fx, 0, 0);
  clientfield::register("actor", "side_ee_gt_spore_trail_enemy_fx", 9000, 1, "int", &function_f68bb4e3, 0, 0);
  clientfield::register("allplayers", "side_ee_gt_spore_trail_player_fx", 9000, var_1b7d5552, "int", &function_f68bb4e3, 0, 0);
  clientfield::register("actor", "good_thrasher_fx", 9000, 1, "int", &good_thrasher_fx, 0, 0);
}

function side_ee_gt_spore_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.var_a1aff3d8)) {
      stopfx(localclientnum, self.var_a1aff3d8);
    }
    self.var_a1aff3d8 = playFX(localclientnum, level._effect["SPORE_GLOW"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  } else if(isDefined(self.var_a1aff3d8)) {
    stopfx(localclientnum, self.var_a1aff3d8);
    self.var_a1aff3d8 = undefined;
  }
}

function side_ee_gt_spore_cloud_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval >= 1) {
    var_74df34f7 = arraygetclosest(self.origin, struct::get_array("s_side_ee_gt_spore_pos"));
    var_38c08794 = var_74df34f7;
    var_828d501f = var_74df34f7;
    var_a506772a = var_74df34f7;
    playFX(localclientnum, level._effect["SPORE_CLOUD_EXP_GOOD_LG"], var_74df34f7.origin, anglesToForward(var_74df34f7.angles));
    self.var_b76ed967 = playFX(localclientnum, level._effect["SPORE_CLOUD_GOOD_LG"], var_a506772a.origin, anglesToForward(var_a506772a.angles));
  } else if(isDefined(self.var_b76ed967)) {
    stopfx(localclientnum, self.var_b76ed967);
    self.var_b76ed967 = undefined;
  }
}

function function_f68bb4e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    if(isDefined(self.var_3ecc4b30)) {
      stopfx(localclientnum, self.var_3ecc4b30);
      self.var_3ecc4b30 = undefined;
    }
    self.var_3ecc4b30 = playFXOnTag(localclientnum, level._effect["SPORE_TRAIL_GOOD"], self, "j_spine4");
  } else if(isDefined(self.var_3ecc4b30)) {
    stopfx(localclientnum, self.var_3ecc4b30);
    self.var_3ecc4b30 = undefined;
  }
}

function good_thrasher_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.var_ba9281dc)) {
      foreach(fx_id in self.var_ba9281dc) {
        stopfx(localclientnum, fx_id);
      }
    }
    self.var_ba9281dc = [];
    self.var_ba9281dc["eyes"] = playFXOnTag(localclientnum, level._effect["SIDE_EE_GT_EYES"], self, "j_eyeball_le");
    self.var_ba9281dc["spine"] = playFXOnTag(localclientnum, level._effect["SIDE_EE_GT_SPINE"], self, "j_spinelower");
    self.var_ba9281dc["leg_l"] = playFXOnTag(localclientnum, level._effect["SIDE_EE_GT_LEG_L"], self, "j_hip_le");
    self.var_ba9281dc["leg_r"] = playFXOnTag(localclientnum, level._effect["SIDE_EE_GT_LEG_R"], self, "j_hip_rt");
  } else if(isDefined(self.var_ba9281dc)) {
    foreach(fx_id in self.var_ba9281dc) {
      stopfx(localclientnum, fx_id);
    }
    self.var_ba9281dc = undefined;
  }
}