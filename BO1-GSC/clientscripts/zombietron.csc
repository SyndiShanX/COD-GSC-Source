/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombietron.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_music;

main() {
  clientscripts\zombietron_fx::main();
  clientscripts\_zombietron::main();
  thread clientscripts\zombietron_amb::main();
  level._client_flagasval_callbacks["player"] = ::menu_handler;
  thread waitforclient(0);
  register_zombie_types();
}
register_zombie_types() {
  character\clientscripts\c_ger_honorguard_zombietron::register_gibs();
}
menu_handler(localClientNum, val) {
  if(val < 8) {
    ForceGameModeMappings(localClientNum, "zombietron");
    self mapshaderconstant(localClientNum, 0, "scriptVector0", 1.0, -1.0, 0.0, 0.0);
  }
}