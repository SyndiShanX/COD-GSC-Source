/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun_mk2v.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_ray_gun_mk2v;

autoexec __init__system__() {
  system::register(#"ray_gun_mk2v", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_115fbee47e748af2"] = #"hash_26ac45625e745ea8";
  level._effect[#"hash_1158b2e47e6e57e0"] = #"hash_26ac45625e745ea8";
  level._effect[#"ray_gun_mk2v_stun_arc"] = #"hash_137c5ba31b8e6395";
  level._effect[#"ray_gun_mk2v_stun_zap"] = #"zm_weapons/fx8_aat_elec_torso";
  level._effect[#"hash_670449447f448da"] = #"zm_weapons/fx8_aat_elec_eye";
  level._effect[#"hash_66d2b9447f1e888"] = #"zm_weapons/fx8_aat_elec_exp";
  level._effect[#"ray_gun_mk2v_death"] = #"hash_4b0f5fb2f910fe94";
  clientfield::register("allplayers", "" + #"ray_gun_mk2v_beam_fire", 20000, 2, "int", &beam_fire, 0, 1);
  clientfield::register("allplayers", "" + #"ray_gun_mk2v_beam_flash", 20000, 1, "int", &flash_fx, 0, 0);
  clientfield::register("actor", "" + #"hash_784061e6c2684e58", 20000, 1, "int", &function_84a63db9, 0, 0);
  clientfield::register("actor", "" + #"hash_3b193ae69f9f4fac", 20000, 1, "counter", &function_97482bc3, 0, 0);
  clientfield::register("actor", "" + #"ray_gun_mk2v_death", 20000, 1, "int", &death_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"ray_gun_mk2v_stun_arc", 20000, 1, "int", &function_4013653a, 0, 0);
}

beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");
  self function_efbf12ac(localclientnum);

  if(newval > 0) {
    self thread function_e7a7ac96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function_efbf12ac(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_5423f6c5db580daa");

  if(isDefined(self.var_21553ca5)) {
    beamkill(localclientnum, self.var_21553ca5);
    self.var_21553ca5 = undefined;
  }

  if(isDefined(self.var_d1f92a1c)) {
    self.var_d1f92a1c delete();
    self.var_d1f92a1c = undefined;
  }
}

function_e7a7ac96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_5423f6c5db580daa");
  self.var_d1f92a1c = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, 4000));
  str_beam = "beam8_zm_raygun2v_elec";

  if(newval > 1) {
    str_beam = "beam8_zm_raygun2v_ug_elec";
  }

  self.var_21553ca5 = level beam::function_cfb2f62a(localclientnum, self, "tag_flash", self.var_d1f92a1c, "tag_origin", str_beam);
}

flash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(!self hasdobj(localclientnum)) {
    return;
  }

  if(isDefined(self.fx_muzzle_flash)) {
    deletefx(localclientnum, self.fx_muzzle_flash);
    self.fx_muzzle_flash = undefined;
  }

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(newval > 0) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[#"hash_115fbee47e748af2"], "tag_flash");
      }

      return;
    }

    if(isDefined(self gettagorigin("tag_flash"))) {
      self.fx_muzzle_flash = util::playFXOnTag(localclientnum, level._effect[#"hash_1158b2e47e6e57e0"], self, "tag_flash");
    }
  }
}

function_84a63db9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_fx_tag = self zm_utility::function_467efa7b(1);

    if(!isDefined(str_fx_tag)) {
      str_fx_tag = "tag_origin";
    }

    self.var_d4f84669 = util::playFXOnTag(localclientnum, level._effect[#"ray_gun_mk2v_stun_zap"], self, str_fx_tag);
    self.var_38e2508e = util::playFXOnTag(localclientnum, level._effect[#"hash_670449447f448da"], self, "j_eyeball_le");

    if(!isDefined(self.var_12941c1d)) {
      self.var_12941c1d = self playLoopSound("zmb_aat_kilowatt_stunned_lp");
    }

    return;
  }

  if(isDefined(self.var_d4f84669)) {
    stopfx(localclientnum, self.var_d4f84669);
    self.var_d4f84669 = undefined;
    stopfx(localclientnum, self.var_38e2508e);
    self.var_38e2508e = undefined;

    if(isDefined(self.var_12941c1d)) {
      self stoploopsound(self.var_12941c1d);
      self.var_12941c1d = undefined;
    }
  }
}

function_97482bc3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));

    if(!isDefined(v_fx_origin)) {
      v_fx_origin = self.origin;
    }

    playFX(localclientnum, level._effect[#"hash_66d2b9447f1e888"], v_fx_origin);
    self playSound(localclientnum, #"zmb_aat_kilowatt_explode");
  }
}

function_4013653a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"ray_gun_mk2v_stun_arc"], self, "tag_origin");
}

death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    str_tag = self zm_utility::function_467efa7b(1);
    util::playFXOnTag(localclientnum, level._effect[#"ray_gun_mk2v_death"], self, str_tag);
  }
}