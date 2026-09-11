/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\subway_fast_travel\subway_car.gsc
********************************************************/

function init() {
  thread supply_crate_vo_when_used();
  scripts\mp\utility\sound::besttime("mp_wz_ch3_morse_code");
}

function supply_crate_vo_when_used() {
  level waittill("player_spawned");
  var0 = getentitylessscriptablearrayinradius("scriptable_morse_code_sfx", "classname");

  foreach(var2 in var0) {
    thread ref_11d28();
  }
}

function ref_11d28() {
  if(isDefined(self.script_noteworthy)) {
    for(;;) {
      self setscriptablepartstate("morse_code_sfx", self.script_noteworthy);
      wait 32.5;
      self setscriptablepartstate("morse_code_sfx", "off");
      wait 32.5;
    }

    return;
  }
}