/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\pausemenu.gsc
***********************************************/



#using scripts\sp\endmission;
#namespace pausemenu;

function main() {
  thread pausemenu_think();
}

function pausemenu_think() {
  while(true) {
    level.player waittill("restartmission");
    restartmission();
  }
}

function restartmission() {
  version = getbuildversion();

  if(version == "PROFILE" || version == "DEMO") {
    map_restart();
    return;
  }

  if(getdvarint(@ "hash_893e98eb981706e2") > 0) {
    map_restart();
    return;
  }

  level.player enableinvulnerability();
  map = scripts\sp\endmission::getrestartlevel(level.script);

  if(isDefined(map)) {
    changelevel(map, 0, 0);
    return;
  }

  map_restart();
}