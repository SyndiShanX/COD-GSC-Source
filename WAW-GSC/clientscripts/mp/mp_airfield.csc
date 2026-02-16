/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_airfield.csc
********************************************/

#include clientscripts\mp\_utility;

main() {
  level.allies_team = "marines";
  level.axis_team = "japanese";

  clientscripts\mp\_load::main();

  clientscripts\mp\mp_airfield_fx::main();

  thread clientscripts\mp\_fx::fx_init(0);
  thread clientscripts\mp\_audio::audio_init(0);

  thread clientscripts\mp\mp_airfield_amb::main();

  thread waitforclient(0);

  println("*** Client : mp_airfield running...");

  clientscripts\mp\_mortar::set_mortar_delays("mortar_point", 1, 4, 0.4, 1.25);
  clientscripts\mp\_mortar::set_mortar_range("mortar_point", 200, 10000);
  clientscripts\mp\_mortar::set_mortar_quake("mortar_point", 0.32, 3, 10);
  clientscripts\mp\_mortar::set_mortar_dust("mortar_point", "bunker_dust", 512);

  clientscripts\mp\_mortar::set_mortar_delays("mortar_sw_hills", 1, 2, 0.2, 0.5);
  clientscripts\mp\_mortar::set_mortar_range("mortar_sw_hills", 200, 15000);
  clientscripts\mp\_mortar::set_mortar_quake("mortar_sw_hills", 0.32, 3, 10);
  clientscripts\mp\_mortar::set_mortar_dust("mortar_sw_hills", "bunker_dust", 512);

  clientscripts\mp\_mortar::set_mortar_delays("mortar_east_hill", 1, 3, 0.5, 1);
  clientscripts\mp\_mortar::set_mortar_range("mortar_east_hill", 200, 15000);
  clientscripts\mp\_mortar::set_mortar_quake("mortar_east_hill", 0.32, 3, 10);
  clientscripts\mp\_mortar::set_mortar_dust("mortar_east_hill", "bunker_dust", 512);

  level thread clientscripts\mp\_mortar::mortar_loop("mortar_point", 4);
  level thread clientscripts\mp\_mortar::mortar_loop("mortar_sw_hills", 10);
  level thread clientscripts\mp\_mortar::mortar_loop("mortar_east_hill", 6);
}