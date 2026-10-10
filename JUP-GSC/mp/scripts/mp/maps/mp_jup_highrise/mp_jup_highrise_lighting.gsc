/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_highrise\mp_jup_highrise_lighting.gsc
***************************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_highrise_lighting;

function main() {
  level thread function_6b1ff277b8322675();
  level.gunshipvisionset = "mp_jup_highrise_killstreak_gunship";
  level.choppervisionset = "mp_jup_highrise_killstreak_gunship";
  level.var_6d129920246627ba = "mp_jup_highrise_assault_drone_color_mp";
  level.var_61b254009a0951a6 = "mp_jup_highrise_assault_drone_color_dark_mp";
  level.var_638c653eda9d1cd3 = "mp_jup_highrise_cruise_color_mp";
  level.var_81d39c829ea8e68f = "mp_jup_highrise_cruise_color_mp";
}

function function_6b1ff277b8322675() {
  wait 0.5;
  level waittill("infil_setup_complete");
  mover = getEnt("building_saba_elevator_set", "targetname");
  probe = getEnt("highrise_elevator_intro_lgt", "targetname");
  probe linkTo(mover, "j_elevator_door_ext_left", (3310, 735, 2899.35), (0, 0, 0));
  wait 0.5;
  level waittill("infil_setup_complete");
  mover = getEnt("building_saba_elevator_set02", "targetname");
  probe = getEnt("highrise_elevator_intro_lgt02", "targetname");
  probe linkTo(mover, "j_elevator_door_ext_left", (3313.73, 1335.42, 2907.1), (0, 0, 0));
  wait 0.5;
  level waittill("infil_setup_complete");
  mover = getEnt("building_saba_elevator_set03", "targetname");
  probe = getEnt("highrise_elevator_intro_lgt03", "targetname");
  probe linkTo(mover, "j_elevator_door_ext_left", (-2743.83, -810.951, 2893.72), (0, 0, 0));
  wait 0.5;
  level waittill("infil_setup_complete");
  mover = getEnt("building_saba_elevator_set04", "targetname");
  probe = getEnt("highrise_elevator_intro_lgt04", "targetname");
  probe linkTo(mover, "j_elevator_door_ext_left", (-2747.04, -1405.97, 2906.88), (0, 0, 0));
}