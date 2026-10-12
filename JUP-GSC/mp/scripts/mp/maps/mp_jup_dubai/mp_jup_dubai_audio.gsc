/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_dubai\mp_jup_dubai_audio.gsc
***************************************************************/

#namespace mp_jup_dubai_audio;

function main() {
  thread sfx_security_clearance("sfx_security_clearance", "amb_emt_dubai_security_clearance", 3);
}

function sfx_security_clearance(trigname, alias, timer) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  trig = getEnt(trigname, "targetname");

  while(true) {
    trig waittill("trigger");
    trig playSound(alias);
    wait timer;

    while(function_77e25cc10461d531(trig)) {
      waitframe();
    }
  }
}

function function_77e25cc10461d531(trig) {
  foreach(player in level.players) {
    if(player istouching(trig)) {
      return true;
    }
  }

  return false;
}