/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting.gsc
**********************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_incline_lighting;

function main() {
  thread function_d2b21d3eeb9a5054();
}

function function_d2b21d3eeb9a5054() {
  light = getEnt("lgt_rescue_light", "targetname");
  light rotatevelocity((0, 1000, 0), 50000);
}