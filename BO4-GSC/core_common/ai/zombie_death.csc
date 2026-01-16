/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_death.csc
***********************************************/

#include scripts\core_common\util_shared;

#namespace zombie_death;

autoexec init_fire_fx() {
  waitframe(1);

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[#"character_fire_death_sm"] = #"hash_c9cf0acc938a7f6";
  level._effect[#"character_fire_death_torso"] = #"hash_5686def5b4c85661";
}

on_fire_timeout(localclientnum) {
  self endon(#"death");
  wait 12;

  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = 0;
    self notify(#"stop_flame_damage");
  }
}

flame_death_fx(localclientnum) {
  self notify("484eca5adcd8edcb");
  self endon("484eca5adcd8edcb");

  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }

  self.is_on_fire = 1;
  self thread on_fire_timeout();

  if(isDefined(level._effect) && isDefined(level._effect[#"character_fire_death_torso"])) {
    fire_tag = "j_spinelower";

    if(!isDefined(self gettagorigin(fire_tag))) {
      fire_tag = "tag_origin";
    }

    if(!isDefined(self.isdog) || !self.isdog) {
      util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_torso"], self, fire_tag);
    }
  } else {
    println("<dev string:x38>");
  }

  if(isDefined(level._effect) && isDefined(level._effect[#"character_fire_death_sm"])) {
    if(self.archetype !== "parasite" && self.archetype !== "raps") {
      wait 1;
      tagarray = [];
      tagarray[0] = "J_Elbow_LE";
      tagarray[1] = "J_Elbow_RI";
      tagarray[2] = "J_Knee_RI";
      tagarray[3] = "J_Knee_LE";
      tagarray = randomize_array(tagarray);
      util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[0]);
      wait 1;
      tagarray[0] = "J_Wrist_RI";
      tagarray[1] = "J_Wrist_LE";

      if(!(isDefined(self.missinglegs) && self.missinglegs)) {
        tagarray[2] = "J_Ankle_RI";
        tagarray[3] = "J_Ankle_LE";
      }

      tagarray = randomize_array(tagarray);
      util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[0]);
      util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[1]);
    }

    return;
  }

  println("<dev string:xd9>");
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}