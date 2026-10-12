/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart.gsc
*******************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_blackheart\gen\mp_jup_blackheart_art;
#using scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_fx;
#using scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_lighting;
#namespace mp_jup_blackheart;

function main() {
  scripts\mp\maps\mp_jup_blackheart\gen\mp_jup_blackheart_art::main();
  scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_fx::main();
  scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_blackheart");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  scripts\cp_mp\utility\game_utility::registersmallmap();
  thread crusher();
  thread shredder();
}

function crusher() {
  level endon("game_ended");
  button = getEnt("crusher_button", "targetname");
  killtrig = getEnt("crusher_kill", "targetname");

  if(!isDefined(killtrig)) {
    return;
  }

  killtrig trigger_off();
  msg = "crusher";
  thread show_label(button, msg);

  while(true) {
    button waittill("trigger", player);
    crush(killtrig);
  }
}

function shredder() {
  level endon("game_ended");
  button = getEnt("shredder_button", "targetname");
  killtrig = getEnt("shredder_kill", "targetname");

  if(!isDefined(killtrig)) {
    return;
  }

  killtrig trigger_off();
  msg = "shredder";
  thread show_label(button, msg);

  while(true) {
    button waittill("trigger", player);
    shred(killtrig);
  }
}

function show_label(trig, machine) {
  level endon("game_ended");

  while(true) {
    pos = trig.origin + (0, 0, 4);
    msg = "Press F to activate " + machine;

    print3d(pos, msg, (0.9, 0.9, 0.9), 1, 0.2, 1, 1);

    waitframe();
  }
}

function crush(trig) {
  crusher = getEnt("crusher", "targetname");
  crusher movez(-128, 8, 1, 1);
  wait 8;
  time = 6;
  function_8b45da99e2a6da1c(trig, time);
  crusher movez(128, 7, 1, 1);
  wait 7;
}

function shred(trig) {
  var_7105bdb05a2247b0 = getEnt("shredder_one", "targetname");
  var_a45b04b13c657546 = getEnt("shredder_two", "targetname");
  var_d1030d895bd655a = getEnt("shredder_one_col", "targetname");
  var_59b0e90096e2b534 = getEnt("shredder_two_col", "targetname");
  time = 6;
  thread function_8b45da99e2a6da1c(trig, time);
  var_7105bdb05a2247b0 rotateby((0, 0, -360), time, 1, 1);
  var_a45b04b13c657546 rotateby((0, 0, -360), time, 1, 1);
  var_d1030d895bd655a rotateby((0, 0, 360), time, 1, 1);
  var_59b0e90096e2b534 rotateby((0, 0, -360), time, 1, 1);
  wait time;
}

function function_8b45da99e2a6da1c(trig, time) {
  trig trigger_on();
  wait time;
  trig trigger_off();
}