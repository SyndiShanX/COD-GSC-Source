/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_1793e0dffb81a6c8.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace namespace_841de7df;

autoexec __init__system__() {
  system::register(#"hash_4ef9c479ac8da304", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  clientfield::register("zbarrier", "" + #"hash_100f180bf5d2a517", 14000, 1, "int", &function_b245db69, 0, 0);
  level._effect[#"hash_1d15a2dad558ac8c"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
  level._effect[#"hash_1d15a5dad558b1a5"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
  zm_trial::register_challenge(#"hash_28d1b9857e2ca681", &on_begin, &on_end);
}

private on_begin(localclientnum, a_params) {}

private on_end(localclientnum) {}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_28d1b9857e2ca681");
  return isDefined(challenge);
}

private function_b245db69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.var_18f8b30b)) {
      self.var_18f8b30b delete();
    }

    if(isDefined(self.var_3b071bba)) {
      deletefx(localclientnum, self.var_3b071bba);
      self.var_3b071bba = undefined;
    }

    if(zm_utility::get_story() == 1) {
      self.var_18f8b30b = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
      self.var_3b071bba = util::playFXOnTag(localclientnum, level._effect[#"hash_1d15a2dad558ac8c"], self.var_18f8b30b, "tag_origin");
    } else {
      self.var_18f8b30b = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
      self.var_3b071bba = util::playFXOnTag(localclientnum, level._effect[#"hash_1d15a5dad558b1a5"], self.var_18f8b30b, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_3b071bba)) {
    deletefx(localclientnum, self.var_3b071bba);
    self.var_3b071bba = undefined;
  }

  if(isDefined(self.var_18f8b30b)) {
    self.var_18f8b30b delete();
  }
}