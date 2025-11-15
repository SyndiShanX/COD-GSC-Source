/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_shipment.gsc
********************************/

main() {
  maps\mp\mp_shipment_precache::main();
  maps\mp\mp_shipment_fx::main();
  maps\createart\mp_shipment_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_shipment");
  ambientplay("amb_mp_shipment_ext");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
  setdvar("compassmaxrange", "1400");
}