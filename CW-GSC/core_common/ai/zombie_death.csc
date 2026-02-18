/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_death.csc
***********************************************/

#using scripts\core_common\util_shared;
#namespace zombie_death;

function autoexec init_fire_fx() {
  waitframe(1);

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[# "character_fire_death_sm"] = # "hash_c9cf0acc938a7f6";
  level._effect[# "character_fire_death_torso"] = # "hash_5686def5b4c85661";
}

function on_fire_timeout(localclientnum) {
  self endon(#"death");
  wait 12;

  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = 0;
    self notify(#"stop_flame_damage");

    if(isDefined(self.firefx)) {
      foreach(fx in self.firefx) {
        stopfx(localclientnum, fx);
      }
    }
  }
}

function flame_death_fx(localclientnum) {
  self notify("7aa92aa1140c6031");
  self endon("7aa92aa1140c6031");

  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(is_true(self.is_on_fire)) {
    return;
  }

  self.is_on_fire = 1;

  if(!isDefined(self.firefx)) {
    self.firefx = [];
  }

  self thread on_fire_timeout(localclientnum);

  if(isDefined(level._effect) && isDefined(level._effect[# "character_fire_death_torso"])) {
    fire_tag = "j_spinelower";

    if(!isDefined(self gettagorigin(fire_tag))) {
      fire_tag = "tag_origin";
    }

    if(!isDefined(self.isdog) || !self.isdog) {
      self.firefx[self.firefx.size] = util::playFXOnTag(localclientnum, level._effect[# "character_fire_death_torso"], self, fire_tag);
    }
  } else {
    println("<dev string:x38>");
  }

  if(isDefined(level._effect) && isDefined(level._effect[# "character_fire_death_sm"])) {
    if(self.archetype !== "parasite" && self.archetype !== "raps") {
      wait 1;
      tagarray = [];
      tagarray[0] = "J_Elbow_LE";
      tagarray[1] = "J_Elbow_RI";
      tagarray[2] = "J_Knee_RI";
      tagarray[3] = "J_Knee_LE";
      tagarray = randomize_array(tagarray);
      self.firefx[self.firefx.size] = util::playFXOnTag(localclientnum, level._effect[# "character_fire_death_sm"], self, tagarray[0]);
      wait 1;
      tagarray[0] = "J_Wrist_RI";
      tagarray[1] = "J_Wrist_LE";

      if(!is_true(self.missinglegs)) {
        tagarray[2] = "J_Ankle_RI";
        tagarray[3] = "J_Ankle_LE";
      }

      tagarray = randomize_array(tagarray);
      self.firefx[self.firefx.size] = util::playFXOnTag(localclientnum, level._effect[# "character_fire_death_sm"], self, tagarray[0]);
      self.firefx[self.firefx.size] = util::playFXOnTag(localclientnum, level._effect[# "character_fire_death_sm"], self, tagarray[1]);
    }

    return;
  }

  println("<dev string:xda>");
}

function randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}