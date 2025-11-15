/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_blockers.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_blockers;

autoexec __init__system__() {
  system::register(#"zm_blockers", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"doorbuy_ambient_fx"] = "zombie/fx8_doorbuy_amb";
  level._effect[#"doorbuy_bought_fx"] = "zombie/fx8_doorbuy_death";
  level._effect[#"debrisbuy_ambient_fx"] = "zombie/fx8_debrisbuy_amb";
  level._effect[#"debrisbuy_bought_fx"] = "zombie/fx8_debrisbuy_death";
  level._effect[#"powerdoor_ambient_fx"] = "zombie/fx8_power_door_amb";
  level._effect[#"powerdoor_bought_fx"] = "zombie/fx8_power_door_death";
  level._effect[#"power_debris_ambient_fx"] = "zombie/fx8_power_debris_amb";
  level._effect[#"power_debris_bought_fx"] = "zombie/fx8_power_debris_death";
  clientfield::register("scriptmover", "doorbuy_ambient_fx", 1, 1, "int", &doorbuy_ambient_fx, 0, 0);
  clientfield::register("scriptmover", "doorbuy_bought_fx", 1, 1, "int", &doorbuy_bought_fx, 0, 0);
  clientfield::register("scriptmover", "debrisbuy_ambient_fx", 1, 1, "int", &debrisbuy_ambient_fx, 0, 0);
  clientfield::register("scriptmover", "debrisbuy_bought_fx", 1, 1, "int", &debrisbuy_bought_fx, 0, 0);
  clientfield::register("scriptmover", "power_door_ambient_fx", 1, 1, "int", &power_door_ambient_fx, 0, 0);
  clientfield::register("scriptmover", "power_door_bought_fx", 1, 1, "int", &power_door_bought_fx, 0, 0);
  clientfield::register("scriptmover", "power_debris_ambient_fx", 1, 1, "int", &power_debris_ambient_fx, 0, 0);
  clientfield::register("scriptmover", "power_debris_bought_fx", 1, 1, "int", &power_debris_bought_fx, 0, 0);
}

__main__() {}

doorbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_aa07bb71(level._effect[#"doorbuy_ambient_fx"], "zmb_blocker_door_lp", localclientnum, newval);
}

debrisbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_aa07bb71(level._effect[#"debrisbuy_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

power_door_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_aa07bb71(level._effect[#"powerdoor_ambient_fx"], "zmb_blocker_powerdoor_lp", localclientnum, newval);
}

power_debris_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_aa07bb71(level._effect[#"power_debris_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

doorbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_e6eed4fe(level._effect[#"doorbuy_bought_fx"], #"hash_21b4bf152e90fd76", localclientnum, newval);
}

debrisbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_e6eed4fe(level._effect[#"debrisbuy_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

power_door_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_e6eed4fe(level._effect[#"powerdoor_bought_fx"], #"hash_5dcb54d98c9787b1", localclientnum, newval);
}

power_debris_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_e6eed4fe(level._effect[#"power_debris_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

function_aa07bb71(str_fx_name, var_bd367366, var_6142f944, n_new_val) {
  if(n_new_val) {
    if(isDefined(self) && !isDefined(self.ambient_fx_id)) {
      self.ambient_fx_id = util::playFXOnTag(var_6142f944, str_fx_name, self, "tag_origin");
    }

    audio::playloopat(var_bd367366, self.origin);
    return;
  }

  if(isDefined(self.ambient_fx_id)) {
    killfx(var_6142f944, self.ambient_fx_id);
    self.ambient_fx_id = undefined;
  }

  audio::stoploopat(var_bd367366, self.origin);
}

function_e6eed4fe(str_fx_name, var_d34b6d2b, var_6142f944, n_new_val) {
  if(n_new_val) {
    if(!isDefined(self.var_4da473fc)) {
      var_4da473fc = util::spawn_model(var_6142f944, #"tag_origin", self.origin, self.angles);
    } else {
      var_4da473fc = self.var_4da473fc;
    }

    util::playFXOnTag(var_6142f944, str_fx_name, var_4da473fc, "tag_origin");
    playSound(var_6142f944, var_d34b6d2b, var_4da473fc.origin);
    wait 2;

    if(isDefined(var_4da473fc)) {
      var_4da473fc delete();
    }
  }
}