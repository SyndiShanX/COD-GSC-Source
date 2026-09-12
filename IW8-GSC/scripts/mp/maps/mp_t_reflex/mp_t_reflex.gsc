/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_reflex\mp_t_reflex.gsc
*******************************************************/

function main() {
  _start_rooftop_raid_sats::keypad_check_levelinput();
  _redbuttonused_internal::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  level.ref_13d50 = 1;
  scripts\mp\maps\mp_t_reflex\mp_t_reflex_precache::main();
  scripts\mp\maps\mp_t_reflex\gen\mp_t_reflex_art::main();
  scripts\mp\maps\mp_t_reflex\mp_t_reflex_fx::main();
  scripts\mp\maps\mp_t_reflex\mp_t_reflex_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_t_reflex");
  setDvar("r_umbraMinObjectContribution", 8);
  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  var_0 = spawn("script_model", (1987, 830.5, 55));
  var_0 setModel("mout_catwalk_support_brace_ibeam_96");
  var_0.angles = (270, 0, 0);
  var_1 = spawn("script_model", (1987, 830.5, 151));
  var_1 setModel("mout_catwalk_support_brace_ibeam_96");
  var_1.angles = (270, 0, 0);
  var_2 = spawn("script_model", (1970.5, 1401.5, -17.5));
  var_2 setModel("player128x128x8");
  var_2.angles = (270, 0, 0);
  var_3 = spawn("script_model", (1776, 822, 73));
  var_3.angles = (0, 0, 90);
  var_4 = getEnt("clip128x128x8", "targetname");
  var_3 clonebrushmodeltoscriptmodel(var_4);
}