/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium.gsc
**********************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_zooquarium\gen\mp_jup_zooquarium_art;
#using scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_fx;
#using scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_lighting;
#using scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_precache;
#using scripts\mp\utility\game;
#namespace mp_jup_zooquarium;

function main() {
  scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_precache::main();
  scripts\mp\maps\mp_jup_zooquarium\gen\mp_jup_zooquarium_art::main();
  scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_fx::main();
  scripts\mp\maps\mp_jup_zooquarium\mp_jup_zooquarium_lighting::main();
  scripts\mp\load::main();
  level.var_ca0420748e3190ed = getStructArray("dcover_invalid_struct", "targetname");
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_zooquarium");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_713f089988ee955e();
  thread function_79d4df95607e117();
}

function function_713f089988ee955e() {
  level endon("game_ended");
  axle = getEnt("delta_windmill_01_axle", "targetname");
  parts = getEntArray("delta_windmill_01_part", "targetname");
  axle forcenetfieldhighlod(1);

  foreach(part in parts) {
    part linkTo(axle);
    part forcenetfieldhighlod(1);
  }

  while(true) {
    axle rotateroll(360, 60);
    wait 60;
  }
}

function function_79d4df95607e117() {
  trigger_1 = spawn("trigger_radius", (-3832, -7082, -4), 0, 512, 1024);
  trigger_1.targetname = "OutOfBounds";
  var_b1a2a4451f616e1e = spawn("trigger_radius", (-4466, -8168, -4), 0, 512, 1024);
  var_b1a2a4451f616e1e.targetname = "OutOfBounds";
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger_1;
  level.outofboundstriggers[level.outofboundstriggers.size] = var_b1a2a4451f616e1e;
}