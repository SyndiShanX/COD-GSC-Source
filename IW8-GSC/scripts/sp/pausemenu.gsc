/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\pausemenu.gsc
***********************************************/

function main() {
  thread pausemenu_think();
}

function pausemenu_think() {
  for(;;) {
    level.player waittill("luinotifyserver", var0, var1);

    if(var0 == "restartMission") {
      restartmission();
    }
  }
}

function restartmission() {
  var0 = getbuildversion();

  if(var0 != "" && (var0 == "IW8_PROFILE" || var0 == "IW8_DEMO")) {
    map_restart();
    return;
  }

  level.player enableinvulnerability();
  var1 = scripts\sp\endmission::getrestartlevel(level.script);

  if(isDefined(var1)) {
    changelevel(var1, 0, 0);
    return;
  }

  map_restart();
}