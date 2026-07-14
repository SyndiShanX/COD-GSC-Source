/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\slowmo_init.gsc
**************************************/

#using scripts\engine\utility;
#namespace slowmo_init;

function slowmo_system_init() {
  if(!utility::add_init_script("?\xaf\b\xbfWt", &slowmo_system_init)) {
    return;
  }

  level.slowmo = spawnStruct();
  slowmo_system_defaults();
  notifyoncommand("]\x8f&,\xbc\xab\xa4\"\xcc\x1e \xae4\xb5JV[\xae}\xd1^1~`\xcf\xc0", "\xa8\x94\xb5Ls\x10");
  notifyoncommand("]\x8f&,\xbc\xab\xa4\"\xcc\x1e \xae4\xb5JV[\xae}\xd1^1~`\xcf\xc0", "_\x05\xd7\xb5\xed\r\xdb'<\x98\xd0\x01\xbf");
  notifyoncommand("]\x8f&,\xbc\xab\xa4\"\xcc\x1e \xae4\xb5JV[\xae}\xd1^1~`\xcf\xc0", "\x18\xf77d\x8e\\\x1fjq\xbd(");
}

function slowmo_system_defaults() {
  level.slowmo.lerp_time_in = 0;
  level.slowmo.lerp_time_out = 0.25;
  level.slowmo.speed_slow = 0.4;
  level.slowmo.speed_norm = 1;
}