/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_dubai\mp_jup_dubai_lighting.gsc
******************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_dubai_lighting;

function main() {}

function function_a02892b0e7f1f595() {
  wait 15;
  elevator_intro = getEnt("elevate_plate_1", "targetname");
  elevator_intro hide();
}