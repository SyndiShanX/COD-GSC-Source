/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_greece\mp_jup_greece.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_greece\gen\mp_jup_greece_art;
#using scripts\mp\maps\mp_jup_greece\mp_jup_greece_fx;
#using scripts\mp\maps\mp_jup_greece\mp_jup_greece_lighting;
#using scripts\mp\outofbounds;
#namespace mp_jup_greece;

function main() {
  scripts\mp\maps\mp_jup_greece\gen\mp_jup_greece_art::main();
  scripts\mp\maps\mp_jup_greece\mp_jup_greece_fx::main();
  scripts\mp\maps\mp_jup_greece\mp_jup_greece_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  initoob();
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_greece");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}

function initoob() {
  if(scripts\cp_mp\utility\game_utility::getgametype() == "escort") {
    trigger_origin = (-1920, -1408, 0);
    size_min = (1128, 474, 138);
    size_max = (120, 96, 896);
    trigger = spawn("trigger_box", trigger_origin, 0, size_min, size_max);
    trigger.targetname = "OutOfBounds";
    trigger.script_team = "defenders";
    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
    thread scripts\mp\outofbounds::watchoobtrigger(trigger);
  }
}