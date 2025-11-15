/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hand_gaia.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_hand_gaia;

autoexec __init__system__() {
  system::register(#"zm_weap_hand_gaia", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "" + #"gaia_impact_zombie", 16000, 1, "counter", &gaia_impact_zombie_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_shoot", 16000, 1, "counter", &mostmost_mo, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_impact", 16000, 1, "counter", &gaia_impact_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"spike_explode", 16000, 1, "counter", &function_10485953, 0, 0);
  clientfield::register("scriptmover", "" + #"spike_spawn", 16000, 1, "counter", &function_3672d8a5, 0, 0);
  level._effect[#"gaia_projectile_trail"] = #"hash_5873b3e8eed6eece";
  level._effect[#"gaia_projectile_impact"] = #"hash_d2b136a3d2607a0";
  level._effect[#"gaia_spikes_reveal"] = #"hash_13b6231a05889663";
  level._effect[#"gaia_spikes_crumble"] = #"hash_224a2a7d7295284";
}

gaia_impact_zombie_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(isDefined(self) && isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else if(isDefined(self)) {
    str_tag = self zm_utility::function_467efa7b();

    if(!isDefined(str_tag)) {
      v_org = self.origin;
    } else {
      v_org = self gettagorigin(str_tag);
    }
  }

  if(!isDefined(v_org)) {
    return;
  }

  playFX(localclientnum, level._effect[#"gaia_projectile_impact"], v_org, anglesToForward(self.angles));
  self playSound(localclientnum, #"hash_3efca867dc76b512");
}

mostmost_mo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"gaia_projectile_trail"], self, "tag_origin");

  if(!isDefined(self.n_sfx)) {
    self.n_sfx = self playLoopSound(#"hash_bc432b7cd09e11d");
  }
}

gaia_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
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

  playFX(localclientnum, level._effect[#"gaia_projectile_impact"], v_org, v_ang);
  playSound(localclientnum, #"hash_3bf3dbe329c0568b", self.origin);
}

function_10485953(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"gaia_spikes_crumble"], self, "tag_origin");
}

function_3672d8a5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"gaia_spikes_reveal"], self, "tag_origin");
}