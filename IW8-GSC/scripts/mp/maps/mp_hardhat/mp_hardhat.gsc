/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hardhat\mp_hardhat.gsc
*****************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_hardhat\mp_hardhat_precache::main();
  scripts\mp\maps\mp_hardhat\gen\mp_hardhat_art::main();
  scripts\mp\maps\mp_hardhat\mp_hardhat_fx::main();
  scripts\mp\maps\mp_hardhat\mp_hardhat_lighting::main();
  scripts\mp\load::main();
  level.music_style = "england";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hardhat", "codcaster_compass_map_mp_hardhat");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 1);
  setDvar("r_tessellationFactor", 30);
  setDvar("r_tessellationCutoffFalloff", 256);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}