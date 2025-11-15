/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_killhouse.gsc
********************************/

main() {
  maps\mp\mp_killhouse_precache::main();
  maps\mp\mp_killhouse_fx::main();
  maps\createart\mp_killhouse_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_killhouse");
  game["allies"] = "sas";
  game["axis"] = "russian";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
  setdvar("compassmaxrange", "2200");

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_w_mid";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_mid";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_w_mid";
  }
}