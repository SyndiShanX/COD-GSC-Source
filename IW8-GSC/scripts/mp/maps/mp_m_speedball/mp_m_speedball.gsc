/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_speedball\mp_m_speedball.gsc
*************************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_m_speedball\mp_m_speedball_precache::main();
  scripts\mp\maps\mp_m_speedball\gen\mp_m_speedball_art::main();
  scripts\mp\maps\mp_m_speedball\mp_m_speedball_fx::main();
  scripts\mp\maps\mp_m_speedball\mp_m_speedball_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_speedball", "codcaster_compass_map_mp_m_speedball");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("NQTLPTNSSO", 500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread signallightsthink();

  if(false) {
    scripts\mp\gametypes\trial::main();
    return;
  }
}

function signallightsthink() {
  wait 2;
  var0 = getscriptablearray("scriptable_stationary_trainyard_signal_lights_01_spdball", "classname");

  if(var0.size == 0) {
    return;
  }

  foreach(var2 in var0) {
    var2 setscriptablepartstate("light", "light_red");
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\mp\flags::gameflagwait("prematch_done");
  }

  foreach(var2 in var0) {
    var2 setscriptablepartstate("light", "light_green");
  }

  wait 3;

  foreach(var2 in var0) {
    var2 setscriptablepartstate("light", "light_red");
  }
}