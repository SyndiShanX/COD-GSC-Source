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
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(isPlayer(who)) {
      trigger playSound("amb_monk_chant");
    }
  }
}