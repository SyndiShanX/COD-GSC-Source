/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_global_fx.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#namespace global_fx;

function autoexec __init__sytem__() {
  system::register("global_fx", & __init__, & main, undefined);
}

function __init__() {
  wind_initial_setting();
}

function main() {
  check_for_wind_override();
}

function wind_initial_setting() {
  setsaveddvar("enable_global_wind", 0);
  setsaveddvar("wind_global_vector", "0 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 10000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

function check_for_wind_override() {
  if(isdefined(level.custom_wind_callback)) {
    level thread[[level.custom_wind_callback]]();
  }
}