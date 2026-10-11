/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_lighting.gsc
*****************************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_drivethru_lighting;

function main() {
  level.gunshipvisionset = "mp_jup_drivethru_killstreak_gunship";
  level.choppervisionset = "mp_jup_drivethru_killstreak_gunship";
  level.killstreakthermalvisionset = "mp_jup_drivethru_killstreak_thermal";
  level.var_638c653eda9d1cd3 = "mp_jup_drivethru_killstreak_cruise_color_mp";
}