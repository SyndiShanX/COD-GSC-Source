/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_elevation_sound.gsc
***********************************************/

#namespace mp_elevation_sound;

main() {
  level thread function_14f3a3c2();
}

function_14f3a3c2() {
  trigger = getent("snd_bell", "targetname");

  if(!isDefined(trigger)) {
    return;
  }

  while(true) {
    waitresult = trigger waittill(#"trigger");

    if(isplayer(waitresult.activator)) {
      trigger playSound("amb_dmg_bell");
    }
  }
}