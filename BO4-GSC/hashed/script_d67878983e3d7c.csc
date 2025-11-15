/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_d67878983e3d7c.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_9ff9f642;

autoexec __init__system__() {
  system::register(#"hash_308dff40d53a7287", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "" + #"hash_419c1c8da4dc53a9", 1, 1, "int", &function_f4515ba8, 0, 0);
}

function_f4515ba8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_tag = "j_spinelower";

    if(!isDefined(self gettagorigin(str_tag))) {
      str_tag = "tag_origin";
    }

    if(isDefined(level._effect) && isDefined(level._effect[#"character_fire_death_torso"])) {
      self.var_62f2a054 = util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_torso"], self, str_tag);
    }

    self thread function_8847b8aa(localclientnum);
    self.var_2be01485 = undefined;
    return;
  }

  self notify(#"hash_395dfda1274cd506");

  if(isDefined(self.var_62f2a054)) {
    stopfx(localclientnum, self.var_62f2a054);
    self.var_62f2a054 = undefined;
  }

  if(isDefined(self.var_803e161e)) {
    foreach(n_fx_id in self.var_803e161e) {
      stopfx(localclientnum, n_fx_id);
    }

    self.var_803e161e = undefined;
  }
}

private function_8847b8aa(localclientnum) {
  self endon(#"death", #"hash_395dfda1274cd506");
  wait 1;
  a_str_tags = [];
  a_str_tags[0] = "j_elbow_le";
  a_str_tags[1] = "j_elbow_ri";
  a_str_tags[2] = "j_knee_ri";
  a_str_tags[3] = "j_knee_le";
  a_str_tags = array::randomize(a_str_tags);
  self.var_803e161e = [];
  self.var_803e161e[0] = util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
  wait 1;
  a_str_tags[0] = "j_wrist_ri";
  a_str_tags[1] = "j_wrist_le";

  if(!(isDefined(self.missinglegs) && self.missinglegs)) {
    a_str_tags[2] = "j_ankle_ri";
    a_str_tags[3] = "j_ankle_le";
  }

  a_str_tags = array::randomize(a_str_tags);
  self.var_803e161e[1] = util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
  self.var_803e161e[2] = util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[1]);
}