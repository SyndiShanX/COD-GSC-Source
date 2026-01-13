/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2909.gsc
************************/

main() {
  thread pausemenu_think();
}

pausemenu_think() {
  for(;;) {
    level.player waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "restartMission") {
      func_E2B3();
    }
  }
}

func_E2B3() {
  var_0 = getdvar("version");
  if(var_0 != "" && issubstr(var_0, "IW7_PROFILE") || issubstr(var_0, "IW7_DEMO")) {
    map_restart();
    return;
  }

  level.player getrankinfoxpamt();
  var_1 = scripts\sp\endmission::fireweapon(level.script);
  if(isDefined(var_1)) {
    changelevel(var_1, 0, 0);
    return;
  }

  map_restart();
}