/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4f52494a6ac904e9.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_1d05befd;

autoexec __init__system__() {
  system::register(#"hash_831eacd382054cc", &__init__, undefined, undefined);
}

__init__() {
  ai::add_archetype_spawn_function(#"zombie", &function_65089f84);
  clientfield::register("actor", "zm_ai/zombie_electric_fx_clientfield", 21000, 1, "int", &zombie_electric_fx, 0, 0);
  clientfield::register("actor", "zombie_electric_burst_clientfield", 21000, 1, "counter", &function_8f477183, 0, 0);
  clientfield::register("actor", "zombie_electric_water_aoe_clientfield", 21000, 1, "counter", &function_c9f98c07, 0, 0);
  clientfield::register("actor", "zombie_electric_burst_stun_friendly_clientfield", 21000, 1, "int", &function_93585307, 0, 0);
  clientfield::register("toplayer", "zombie_electric_burst_postfx_clientfield", 21000, 1, "counter", &function_4d29fadf, 0, 0);
}

private function_65089f84(localclientnum) {
  if(isDefined(self.subarchetype) && self.subarchetype == #"zombie_electric") {}
}

private zombie_electric_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    if(newval) {
      self.var_2e07a8e7 = util::playFXOnTag(localclientnum, "zm_ai/fx8_elec_zombie_sparky_chest", self, "j_spine4");
      return;
    }

    if(isDefined(self.var_2e07a8e7)) {
      stopfx(localclientnum, self.var_2e07a8e7);
      self.var_2e07a8e7 = undefined;
    }
  }
}

private function_8f477183(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self) && newval) {
    playFX(localclientnum, "zm_ai/fx8_elec_zombie_explode", self gettagorigin("j_spine4"));
  }
}

private function_c9f98c07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self) && newval) {
    playFX(localclientnum, "zm_ai/fx8_elec_zombie_blast_area", self gettagorigin("j_spine4"));
  }
}

private function_4d29fadf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self) && newval) {
    self thread postfx::playpostfxbundle(#"hash_2083fc2cc0fee308");
  }
}

private function_93585307(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    if(newval) {
      if(!isDefined(self.var_2e07a8e7)) {
        self.var_2e07a8e7 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_elec_torso", self, "j_spine4");
      }

      if(!isDefined(self.var_d48778ce)) {
        self.var_d48778ce = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");
      }

      if(!isDefined(self.var_93ee541d)) {
        self.var_93ee541d = self playLoopSound("zmb_aat_kilowatt_stunned_lp");
      }

      return;
    }

    if(isDefined(self.var_2e07a8e7)) {
      stopfx(localclientnum, self.var_2e07a8e7);
      self.var_2e07a8e7 = undefined;
    }

    if(isDefined(self.var_d48778ce)) {
      stopfx(localclientnum, self.var_d48778ce);
      self.var_d48778ce = undefined;
    }

    if(isDefined(self.var_93ee541d)) {
      self stoploopsound(self.var_93ee541d);
      self.var_93ee541d = undefined;
    }
  }
}