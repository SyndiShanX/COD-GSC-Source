/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio.gsc
**********************************************************************/

#namespace mp_jup_delayed_audio;

function main() {
  thread sfx_metal_det("sfx_metal_det", "amb_emt_delayed_metal_det", 3);
}

function sfx_metal_det(trigname, alias, timer) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  metal_triggers = getEntArray(trigname, "targetname");

  foreach(trig in metal_triggers) {
    thread function_a0912e6a103cc3a(trig, alias, timer);
  }
}

function function_a0912e6a103cc3a(trig, alias, timer) {
  while(true) {
    if(!isDefined(trig.scriptable)) {
      scriptables = getscriptablearray("scriptable_un_office_walkthrough_metal_detector_01_blink", "classname");
      trig.scriptable = sortbydistance(scriptables, trig.origin)[0];
      trig.scriptable setscriptablepartstate("Light_Part", "off");
    }

    trig waittill("trigger");
    playsoundatpos(trig.origin + (0, 0, 40), alias);
    trig.scriptable setscriptablepartstate("Light_Part", "on");
    wait timer;
    trig.scriptable setscriptablepartstate("Light_Part", "off");

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