/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\pausemenu.gsc
**************************************/

#namespace pausemenu;

function main() {
  thread pausemenu_think();
}

function pausemenu_think() {
  while(true) {
    level.player waittill("t\xee\xe0\xb8\x14\xfb\\\x7foP\xbf7\xa4\x94");
    restartmission();
  }
}

function restartmission() {
  version = getbuildversion();

  if(version == "\xae\xa5\x7f\x9a\xd8\xd9\f" || version == "{.\xc8\xc0") {
    map_restart();
    return;
  }

  map_restart();
  return;

  level.player enableinvulnerability();
  map_restart();
}