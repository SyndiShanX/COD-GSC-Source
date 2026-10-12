/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_karachi\mp_jup_karachi_lighting.gsc
**********************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_karachi_lighting;

function main() {}

function lighting_dvars() {
  setDvar(@ "hash_49850a75af2015bd", 1);
  level.var_6d129920246627ba = "mp_jup_karachi_assault_drone_color_mp";
  level.var_61b254009a0951a6 = "mp_jup_karachi_assault_drone_color_dark_mp";
  level.var_638c653eda9d1cd3 = "mp_jup_karachi_cruise_color_mp";
  level.hellstormmissilevisionset = "mp_jup_karachi_cruise_color_mp";
}