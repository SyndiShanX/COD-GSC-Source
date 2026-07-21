/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\pausemenu.gsc
***********************************************/

main() {
  thread pausemenu_think();
}

pausemenu_think() {
  for(;;) {
    level.player waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "restartMission")
      restartmission();
  }
}

restartmission() {
  var_0 = getbuildversion();

  if(var_0 != "" && (var_0 == "IW8_PROFILE" || var_0 == "IW8_DEMO")) {
    map_restart();
    return;
  }

  level.player enableinvulnerability();
  var_1 = scripts\sp\endmission::getrestartlevel(level.script);

  if(isDefined(var_1)) {
    changelevel(var_1, 0, 0);
    return;
  }

  map_restart();
}