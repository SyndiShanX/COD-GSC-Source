/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_bloc.gsc
********************************/

main() {
  maps\mp\mp_bloc_precache::main();
  maps\mp\mp_bloc_fx::main();
  maps\createart\mp_bloc_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_bloc");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
  setdvar("compassmaxrange", "2000");

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_blue_blocb";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_blocb";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_blocb";
  }

  level.airstrikeheightscale = 1.8;
  maps\mp\_utility::demolitionsitemove("_b", (1005, -6128.5, -14), (0, 180, 0));
}