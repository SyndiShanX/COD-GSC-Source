/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_62c40d9a3acec9b1.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_58949729;

function private autoexec __init__system__() {
  system::register(#"hash_5f19cd68b4607f52", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("scriptmover", "reward_chest_fx", 1, 2, "int", &reward_chest_fx, 0, 0);
}

function reward_chest_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      if(isDefined(self.n_fx_id)) {
        stopfx(fieldname, self.n_fx_id);
      }

      if(isDefined(self.var_b3673abf)) {
        self stoploopsound(self.var_b3673abf);
      }

      break;
    case 1:
      self.n_fx_id = util::playFXOnTag(fieldname, "sr/fx9_chest_explore_amb_sm", self, "tag_origin");
      self.var_b3673abf = self playLoopSound(#"evt_sr_chest_rarity_low_lp", undefined, (0, 0, 40));
      break;
    case 2:
      self.n_fx_id = util::playFXOnTag(fieldname, "sr/fx9_chest_explore_amb_md", self, "tag_origin");
      self.var_b3673abf = self playLoopSound(#"evt_sr_chest_rarity_med_lp", undefined, (0, 0, 40));
      break;
    case 3:
      if(self.model === #"wpn_t9_streak_care_package_halloween_normal_world") {} else {
        self.n_fx_id = util::playFXOnTag(fieldname, "sr/fx9_chest_explore_amb_lg", self, "tag_origin");
      }

      self.var_b3673abf = self playLoopSound(#"evt_sr_chest_rarity_high_lp", undefined, (0, 0, 40));
      break;
  }
}