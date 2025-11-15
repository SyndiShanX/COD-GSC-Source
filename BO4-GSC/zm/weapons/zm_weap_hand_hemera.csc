/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hand_hemera.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_hand_hemera;

autoexec __init__system__() {
  system::register(#"zm_weap_hand_hemera", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "hemera_shoot", 16000, 1, "counter", &hemera_shoot_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hemera_beam", 16000, 1, "int", &function_70e72eac, 0, 0);
  clientfield::register("scriptmover", "" + #"hemera_impact", 16000, 1, "counter", &hemera_impact_fx, 0, 0);
  clientfield::register("allplayers", "hemera_proj_flash", 16000, 1, "int", &function_c6d1bdb0, 0, 0);
  clientfield::register("allplayers", "hemera_beam_flash", 16000, 1, "int", &function_68e9fdbb, 0, 0);
  clientfield::register("actor", "hemera_proj_death", 16000, 1, "int", &function_ab086ad8, 0, 0);
  clientfield::register("actor", "" + #"hemera_beam_death", 16000, 1, "int", &function_3fd7be85, 0, 0);
  level._effect[#"hemera_shoot"] = #"hash_520fd2427c5fcea3";
  level._effect[#"hash_b9d4268e0a3bccc"] = #"hash_2de436091e3fa43c";
  level._effect[#"hash_ba44e68e0a9efde"] = #"hash_2deb42091e45d74e";
  level._effect[#"hemera_proj_death_head"] = #"hash_57ff7c670774f7d";
  level._effect[#"hash_209c29b7e6706274"] = #"hash_47fe9ffe78c83012";
  level._effect[#"hash_1c1dafe5ebd971f8"] = #"hash_6400b8e89418b50e";
  level._effect[#"hemera_proj_impact"] = #"hash_5493d96403f608c6";
  level._effect[#"hash_3115c2658b6e4e0"] = #"hash_3b0b9cc4cdb70c89";
  level._effect[#"hash_318682658bd17f2"] = #"hash_3b12a8c4cdbd3f9b";
  level._effect[#"hemera_beam_death"] = #"hash_cb5ab216f90ba29";
}

hemera_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self gettagorigin("j_wingulna_le"))) {
    v_org = self gettagorigin("j_h_neck_lower");
  } else if(isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else {
    v_org = self.origin;
  }

  v_forward = anglesToForward(self.angles) * 1000 + self.origin;
  v_back = anglesToForward(self.angles) * -100 + self.origin;
  a_trace = bulletTrace(v_back, v_forward, 0, self);

  if(isDefined(a_trace[#"normal"])) {
    v_ang = a_trace[#"normal"];
  } else {
    v_ang = anglesToForward(self.angles) * -1;
  }

  playFX(localclientnum, level._effect[#"hemera_proj_impact"], v_org, v_ang);
  playSound(localclientnum, #"hash_6e5604c8cf7c55c0", self.origin);
}

function_ab086ad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self gettagorigin("j_spine4"))) {
      self.var_d3316606 = util::playFXOnTag(localclientnum, level._effect[#"hash_209c29b7e6706274"], self, "j_spine4");
    } else {
      self.var_d3316606 = util::playFXOnTag(localclientnum, level._effect[#"hash_209c29b7e6706274"], self, zm_utility::function_467efa7b());
    }

    if(isDefined(self gettagorigin("j_eyeball_le"))) {
      self.var_1550c80f = util::playFXOnTag(localclientnum, level._effect[#"hemera_proj_death_head"], self, "j_eyeball_le");
    }

    self playSound(localclientnum, #"hash_70717b71f19db790");
    return;
  }

  if(isDefined(self) && isDefined(self.var_d3316606)) {
    deletefx(localclientnum, self.var_d3316606);
    self.var_d3316606 = undefined;
  }

  if(isDefined(self) && isDefined(self.var_1550c80f)) {
    deletefx(localclientnum, self.var_1550c80f);
    self.var_1550c80f = undefined;
  }

  if(isDefined(self)) {
    self playSound(localclientnum, #"hash_3fbc22745dc90009");

    if(isDefined(self gettagorigin("j_spine4"))) {
      util::playFXOnTag(localclientnum, level._effect[#"hash_1c1dafe5ebd971f8"], self, "j_spine4");
      return;
    }

    util::playFXOnTag(localclientnum, level._effect[#"hash_1c1dafe5ebd971f8"], self, zm_utility::function_467efa7b());
  }
}

hemera_shoot_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"hemera_shoot"], self, "tag_origin");

  if(!isDefined(self.sndlooper)) {
    self.sndlooper = self playLoopSound(#"hash_3f6858ef82b8b066");
  }
}

function_c6d1bdb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(!self hasdobj(localclientnum)) {
    return;
  }

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(newval == 1) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        playviewmodelfx(localclientnum, level._effect[#"hash_b9d4268e0a3bccc"], "tag_flash");
      }

      return;
    }

    if(isDefined(self gettagorigin("tag_flash"))) {
      util::playFXOnTag(localclientnum, level._effect[#"hash_ba44e68e0a9efde"], self, "tag_flash");
    }
  }
}

function_68e9fdbb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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

  if(newval == 1) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[#"hash_3115c2658b6e4e0"], "tag_flash");
      }

      return;
    }

    if(isDefined(self gettagorigin("tag_flash"))) {
      self.fx_muzzle_flash = util::playFXOnTag(localclientnum, level._effect[#"hash_318682658bd17f2"], self, "tag_flash");
    }
  }
}

function_70e72eac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");
  self function_f1f34b1b(localclientnum);

  if(newval > 0) {
    self thread function_4662df7a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function_f1f34b1b(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_3cbfa1076dfa868b");

  if(isDefined(self.var_d559073)) {
    beamkill(localclientnum, self.var_d559073);
    self.var_d559073 = undefined;
  }

  if(isDefined(self.var_76385ab5)) {
    self.var_76385ab5 delete();
    self.var_76385ab5 = undefined;
  }

  if(isDefined(self.var_4cd8e6cb)) {
    self stoploopsound(self.var_4cd8e6cb);
    self.var_4cd8e6cb = undefined;
  }
}

function_4662df7a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_3cbfa1076dfa868b");

  if(!isDefined(self.var_4cd8e6cb)) {
    self.var_4cd8e6cb = self playLoopSound(#"hash_289b15dba7547241");
  }

  v_trace = bulletTrace(self.origin, self.origin + (0, 0, 4000), 0, self)[#"position"];
  self.var_76385ab5 = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, 4000));
  self.var_76385ab5 linkto(self);
  self.var_f53452ad = level beam::function_cfb2f62a(localclientnum, self.var_76385ab5, "tag_origin", self, "tag_origin", "beam8_zm_ww_hemera_ray");
}

function_3fd7be85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self gettagorigin("j_wingulna_le"))) {
    v_org = self gettagorigin("j_h_neck_lower");
  } else if(isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else {
    v_org = self.origin;
  }

  playFX(localclientnum, level._effect[#"hemera_beam_death"], v_org, anglesToForward(self.angles));
}