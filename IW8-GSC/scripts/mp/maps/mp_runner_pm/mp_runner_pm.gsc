/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_runner_pm\mp_runner_pm.gsc
*********************************************************/

function main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "eastern_europe";
  scripts\mp\maps\mp_runner_pm\mp_runner_pm_precache::main();
  scripts\mp\maps\mp_runner_pm\gen\mp_runner_pm_art::main();
  scripts\mp\maps\mp_runner_pm\mp_runner_pm_fx::main();
  scripts\mp\maps\mp_runner_pm\mp_runner_pm_lighting::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("nvg_base_mp_runner_pm");
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_runner_pm", "codcaster_compass_map_mp_runner_pm");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("NKLMONNPNN", 512);
  setDvar("PKKMTTRQO", 8);
  setDvar("NOSQLKNSQO", 45);
  setDvar("LKOLRONRNQ", 1500);
  setDvar("NSSMQLPRNT", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\motiondetectors::init();
  thread scripts\mp\animation_suite::animationsuite();
  game["allies"] = "SAS";
  game["axis"] = "RUSF";
  thread scripts\mp\secrethunt::secrethunt("bear_hidden");
  thread managegate();
  thread ref_12f8e();
  thread player_exfil_struct();
}

function player_exfil_struct() {
  var_0 = getEnt("player256x256x8", "targetname");
  var_1 = spawn("script_model", (-8, 248, 440));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

#using_animtree("");

function managegate() {
  level waittill("infil_setup_complete");

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  level.scr_animtree["gate_left"] = #animtree;
  level.scr_anim["gate_left"]["close"] = $mp_trainyard_gatel_close;
  level.scr_animname["gate_left"]["close"] = "mp_trainyard_gateL_close";
  level.scr_anim["gate_left"]["open"] = % mp_trainyard_gatel_open;
  level.scr_animname["gate_left"]["open"] = "mp_trainyard_gateL_open";
  level.scr_animtree["gate_right"] = #animtree;
  level.scr_anim["gate_right"]["close"] = % mp_trainyard_gater_close;
  level.scr_animname["gate_right"]["close"] = "mp_trainyard_gateR_close";
  level.scr_anim["gate_right"]["open"] = % mp_trainyard_gater_open;
  level.scr_animname["gate_right"]["open"] = "mp_trainyard_gateR_open";
  var_0 = getEnt("infil_door_left", "targetname");
  var_1 = getEnt("infil_door_right", "targetname");
  var_2 = getEnt("infil_door_chain", "targetname");
  var_0.animname = "gate_left";
  var_0 scripts\common\anim::setanimtree();
  var_1.animname = "gate_right";
  var_1 scripts\common\anim::setanimtree();
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "open");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "open");
  var_2 hide();
  level waittill("prematch_countdown");
  wait 4;
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "close");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function ref_12f8e() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "tjugg":
    case "cranked":
    case "infect":
    case "tdef":
    case "grnd":
    case "grind":
    case "conf":
    case "war":
    case "sr":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (203, -1478, 272), (0, 110, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (203, -1478, 272), (0, 110, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}