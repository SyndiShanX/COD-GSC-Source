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
    level.player waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "restartMission") {
      func_E2B3();
    }
  }
}

func_E2B3() {
  var_00 = getdvar("version");
  if(var_00 != "" && issubstr(var_00, "IW7_PROFILE") || issubstr(var_00, "IW7_DEMO")) {
    map_restart();
    return;
  }

  level.player getrankinfoxpamt();
  var_01 = scripts\sp\endmission::fireweapon(level.script);
  if(isDefined(var_01)) {
    changelevel(var_01, 0, 0);
    return;
  }

  map_restart();
}