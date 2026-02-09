/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_metro.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_metro_fx;
#using scripts\mp\mp_metro_sound;
#using scripts\mp\mp_metro_train;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_metro;

function main() {
  precache();
  setDvar("phys_buoyancy", 1);
  clientfield::register("scriptmover", "mp_metro_train_timer", 1, 1, "int");
  mp_metro_fx::main();
  mp_metro_sound::main();
  load::main();
  compass::setupminimap("compass_map_mp_metro");
  setDvar("compassmaxrange", "2100");
  level.cleandepositpoints = array((-399.059, 1.39783, -47.875), (-1539.2, -239.678, -207.875), (878.216, -0.543464, -47.875), (69.9086, 1382.49, 0.125));
  if(getgametypesetting("allowMapScripting")) {
    level thread mp_metro_train::init();
  }
  level thread devgui_metro();
  execdevgui("");
}

function precache() {}

function devgui_metro() {
  setDvar("", "");
  for(;;) {
    wait(0.5);
    devgui_string = getdvarstring("");
    switch (devgui_string) {
      case "": {
        break;
      }
      case "": {
        level notify("train_start_1");
        break;
      }
      case "": {
        level notify("train_start_2");
        break;
      }
      default: {
        break;
      }
    }
    if(getdvarstring("") != "") {
      setDvar("", "");
    }
  }
}