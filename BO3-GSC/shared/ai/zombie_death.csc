/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie_death.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#namespace zombie_death;

function autoexec init_fire_fx() {
  wait(0.016);
  if(!isDefined(level._effect)) {
    level._effect = [];
  }
  level._effect["character_fire_death_sm"] = "zombie/fx_fire_torso_zmb";
  level._effect["character_fire_death_torso"] = "zombie/fx_fire_torso_zmb";
}

function on_fire_timeout(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  wait(12);
  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = 0;
    self notify("stop_flame_damage");
  }
}

function flame_death_fx(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }
  self.is_on_fire = 1;
  self thread on_fire_timeout();
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_torso"])) {
    fire_tag = "j_spinelower";
    if(!isDefined(self gettagorigin(fire_tag))) {
      fire_tag = "tag_origin";
    }
    if(!isDefined(self.isdog) || !self.isdog) {
      playFXOnTag(localclientnum, level._effect["character_fire_death_torso"], self, fire_tag);
    }
  } else {
    println("");
  }
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_sm"])) {
    if(self.archetype !== "parasite" && self.archetype !== "raps") {
      wait(1);
      tagarray = [];
      tagarray[0] = "J_Elbow_LE";
      tagarray[1] = "J_Elbow_RI";
      tagarray[2] = "J_Knee_RI";
      tagarray[3] = "J_Knee_LE";
      tagarray = randomize_array(tagarray);
      playFXOnTag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
      wait(1);
      tagarray[0] = "J_Wrist_RI";
      tagarray[1] = "J_Wrist_LE";
      if(!(isDefined(self.missinglegs) && self.missinglegs)) {
        tagarray[2] = "J_Ankle_RI";
        tagarray[3] = "J_Ankle_LE";
      }
      tagarray = randomize_array(tagarray);
      playFXOnTag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
      playFXOnTag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[1]);
    }
  } else {
    println("");
  }
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