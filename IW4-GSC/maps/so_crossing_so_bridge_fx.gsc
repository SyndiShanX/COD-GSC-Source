/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_crossing_so_bridge_fx.gsc
********************************************************/

main() {
  level._effect["objective_smoke"] = loadfx("smoke/signal_smoke_green");
  maps\createfx\so_crossing_so_bridge_fx::main();
}