/*********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skidrow_alt\mp_jup_skidrow_alt_lighting.gsc
*********************************************************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_skidrow_alt_lighting;

function main() {
  thread neon_hide();
  thread open_doors();
  level.gunshipvisionset = "mp_jup_skidrow_alt_killstreak_gunship";
  level.choppervisionset = "mp_jup_skidrow_alt_cruise_color_mp";
  level.var_6d129920246627ba = "mp_jup_skidrow_alt_assault_drone_color_mp";
  level.var_61b254009a0951a6 = "mp_jup_skidrow_alt_assault_drone_color_dark_mp";
  level.var_638c653eda9d1cd3 = "mp_jup_skidrow_alt_cruise_color_mp";
  level.var_81d39c829ea8e68f = "mp_jup_skidrow_alt_cruise_color_mp";
  level.var_49071332a2a99c1e = "mp_jup_skidrow_alt_killstreak_thermal";
}

function lighting_dvars() {
  wait 0.5;
}

function neon_hide() {
  wait 0.05;
  neon_hide = getEntArray("neon_hide", "targetname");

  foreach(object in neon_hide) {
    object hide();
  }
}

function open_doors() {
  wait 10;
  open_door_left = getentitylessscriptablearray("open_door_left", "script_noteworthy");

  foreach(door in open_door_left) {
    wait 0.1;
    door scriptabledooropen("left");
  }
}