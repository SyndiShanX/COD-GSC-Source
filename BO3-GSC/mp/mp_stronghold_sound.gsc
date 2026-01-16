/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_stronghold_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace mp_stronghold_sound;

function main() {
  level thread snd_dmg_chant();
}

function snd_dmg_chant() {
  trigger = getent("snd_chant", "targetname");
  if(!isdefined(trigger)) {
    return;
  }
  while (true) {
    trigger waittill("trigger", who);
    if(isplayer(who)) {
      trigger playsound("amb_monk_chant");
    }
  }
}