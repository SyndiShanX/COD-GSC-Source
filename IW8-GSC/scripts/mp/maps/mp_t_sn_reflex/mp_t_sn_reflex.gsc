/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_sn_reflex\mp_t_sn_reflex.gsc
*************************************************************/

function main() {
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  level.ref_13d50 = 1;
  scripts\mp\maps\mp_t_sn_reflex\mp_t_sn_reflex_precache::main();
  scripts\mp\maps\mp_t_sn_reflex\gen\mp_t_sn_reflex_art::main();
  scripts\mp\maps\mp_t_sn_reflex\mp_t_sn_reflex_fx::main();
  scripts\mp\maps\mp_t_sn_reflex\mp_t_sn_reflex_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  var0 = spawn("script_model", (1987, 830.5, 55));
  var0 setModel("mout_catwalk_support_brace_ibeam_96");
  var0.angles = (270, 0, 0);
  var1 = spawn("script_model", (1987, 830.5, 151));
  var1 setModel("mout_catwalk_support_brace_ibeam_96");
  var1.angles = (270, 0, 0);
  var2 = spawn("script_model", (1970.5, 1401.5, -17.5));
  var2 setModel("player128x128x8");
  var2.angles = (270, 0, 0);
  var3 = spawn("script_model", (1776, 822, 73));
  var3.angles = (0, 0, 90);
  var4 = getEnt("clip128x128x8", "targetname");
  var3 clonebrushmodeltoscriptmodel(var4);
  thread clearsplashqueue();
}

function clearsplashqueue() {
  for(;;) {
    level waittill("wave_ended", var0);

    if(var0 == 2) {
      open_big_doors();
    }
  }
}

function open_big_doors() {
  if(istrue(level.big_doors_are_open)) {
    return;
  }

  level.big_doors_are_open = 1;
  level.big_door_l = getentitylessscriptablearrayinradius("big_door_l", "targetname");
  level.big_door_r = getentitylessscriptablearrayinradius("big_door_r", "targetname");
  level.big_door_l[0] setscriptablepartstate("base", "move_l");
  level.big_door_r[0] setscriptablepartstate("base", "move_r");
  scripts\engine\utility::exploder("door_open");
}