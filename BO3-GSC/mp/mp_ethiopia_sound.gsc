/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_ethiopia_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#namespace mp_ethiopia_sound;

function main() {
  level thread snd_dmg_monk();
  level thread snd_dmg_cheet();
  level thread snd_dmg_boar();
}

function snd_dmg_monk() {
  trigger = getent("snd_monkey", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(isplayer(who)) {
      trigger playSound("amb_monkey_shot");
      wait(15);
    }
  }
}

function snd_dmg_cheet() {
  trigger = getent("snd_cheet", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(isplayer(who)) {
      trigger playSound("amb_cheeta_shot");
      wait(15);
    }
  }
}

function snd_dmg_boar() {
  trigger = getent("snd_boar", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(isplayer(who)) {
      trigger playSound("amb_boar_shot");
      wait(15);
    }
  }
}