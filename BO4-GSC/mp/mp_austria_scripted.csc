/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_austria_scripted.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_austria_scripted;

autoexec __init__system__() {
  system::register(#"mp_austria_scripted", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "flip_skybox", 8000, 1, "int", &flip_skybox, 0, 0);
  clientfield::register("scriptmover", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 0);
  level._effect[#"hash_61fce653578d7f82"] = #"zm_ai/fx8_zombie_eye_glow_orange";
}

flip_skybox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setdvar(#"r_skytransition", 1);
  }
}

zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.eye_rob)) {
    self stoprenderoverridebundle(self.eye_rob, "j_head");
  }

  if(isDefined(self.var_3231a850)) {
    stopfx(localclientnum, self.var_3231a850);
    self.var_3231a850 = undefined;
  }

  if(newval) {
    self.eye_rob = "rob_zm_eyes_red";
    var_d40cd873 = "eye_glow";
    self playrenderoverridebundle(self.eye_rob, "j_head");
    self.var_3231a850 = util::playFXOnTag(localclientnum, level._effect[#"hash_61fce653578d7f82"], self, "j_eyeball_le");
  }
}