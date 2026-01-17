/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_burnplayer.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#namespace burnplayer;

function initflamefx() {}

function corpseflamefx(localclientnum) {
  self util::waittill_dobj(localclientnum);
  if(!isDefined(level._effect["character_fire_death_torso"])) {
    initflamefx();
  }
  tagarray = [];
  tagarray[tagarray.size] = "J_Wrist_RI";
  tagarray[tagarray.size] = "J_Wrist_LE";
  tagarray[tagarray.size] = "J_Elbow_LE";
  tagarray[tagarray.size] = "J_Elbow_RI";
  tagarray[tagarray.size] = "J_Knee_RI";
  tagarray[tagarray.size] = "J_Knee_LE";
  tagarray[tagarray.size] = "J_Ankle_RI";
  tagarray[tagarray.size] = "J_Ankle_LE";
  if(isDefined(level._effect["character_fire_death_sm"])) {
    for(arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
      playFXOnTag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[arrayindex]);
    }
  }
  playFXOnTag(localclientnum, level._effect["character_fire_death_torso"], self, "J_SpineLower");
}