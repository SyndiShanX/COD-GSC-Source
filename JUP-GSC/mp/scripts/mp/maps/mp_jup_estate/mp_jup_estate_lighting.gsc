/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_estate\mp_jup_estate_lighting.gsc
***********************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace mp_jup_estate_lighting;

function main() {
  thread function_15ac91b5e59a6c86();
}

function function_15ac91b5e59a6c86() {
  wait 1;
  gameflagwait("infil_started");
  mover = getEnt("bravo", "targetname");
  probe = getEnt("helicopter_reflection_probe", "targetname");
  probe linkTo(mover, "tag_light_interior_01", (120, 3, -50), (0, 0, 0));
  mover setscriptablepartstate("infil_lights", "on_estate", 0);
}