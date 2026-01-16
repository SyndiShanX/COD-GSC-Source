/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_lightning_chain.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_weapons;

#namespace lightning_chain;

autoexec __init__system__() {
  system::register(#"lightning_chain", &init, undefined, undefined);
}

init() {
  clientfield::register("actor", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 1);
  clientfield::register("vehicle", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 0);
  clientfield::register("actor", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
  clientfield::register("vehicle", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
}

lc_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(newval) {
    if(!isDefined(self.lc_shock_fx)) {
      str_tag = "J_SpineUpper";
      str_fx = "zm_ai/fx8_elec_shock";

      if(!self isai()) {
        str_tag = "tag_origin";
      }

      if(newval > 1) {
        str_fx = "zm_ai/fx8_elec_bolt";
      }

      self.lc_shock_fx = util::playFXOnTag(localclientnum, str_fx, self, str_tag);

      if(!isDefined(self.var_b3a6c3f7)) {
        self.var_b3a6c3f7 = self playLoopSound(#"hash_536f193a75e9cec9", 1);
      }

      self playSound(0, #"hash_63d588d1f28ecdc1");
    }

    return;
  }

  if(isDefined(self.lc_shock_fx)) {
    stopfx(localclientnum, self.lc_shock_fx);
    self.lc_shock_fx = undefined;
  }

  if(isDefined(self.var_b3a6c3f7)) {
    self stoploopsound(self.var_b3a6c3f7);
    self.var_b3a6c3f7 = undefined;
  }
}

lc_play_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  str_tag = "J_SpineUpper";

  if(isDefined(self.isdog) && self.isdog) {
    str_tag = "J_Spine1";
  }

  if(!(self.archetype === #"zombie")) {
    tag = "tag_origin";
  }

  switch (newval) {
    case 2:
      str_fx = "zm_ai/fx8_elec_bolt";
      break;
    case 3:
      str_fx = "zm_ai/fx8_elec_shock_os";
      break;
    default:
      str_fx = "zm_ai/fx8_elec_shock";
      break;
  }

  util::playFXOnTag(localclientnum, str_fx, self, str_tag);
}