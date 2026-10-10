/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_delayed\mp_jup_delayed.gsc
****************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_delayed\gen\mp_jup_delayed_art;
#using scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio;
#using scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_fx;
#using scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_lighting;
#using scripts\mp\utility\game;
#namespace mp_jup_delayed;

function main() {
  scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_audio::main();
  scripts\mp\maps\mp_jup_delayed\gen\mp_jup_delayed_art::main();
  scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_fx::main();
  scripts\mp\maps\mp_jup_delayed\mp_jup_delayed_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_delayed");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread play_movie("pic_screens_delayed");
  level thread function_2c1e7d6df0d51540();
}

function function_2c1e7d6df0d51540() {
  gametype = getbasegametype();

  if(gametype == "war" || gametype == "cmd" || gametype == "ctf" || gametype == "cyber" || gametype == "tdm" || gametype == "dom" || gametype == "koth" || gametype == "conf") {
    level waittill("infil_setup_complete");

    if(!gameflag("infil_will_run")) {
      var_590640ad61ade716 = (2920, -1128, 150);
      var_6cfce437b59d8dcc = (0, 90, 0);
      left_elevator = spawn_model("building_saba_elevator_set", var_590640ad61ade716, var_6cfce437b59d8dcc);
      var_430ac5dbe368d1f = (2920, -548, 150);
      var_ca3f58f0d52aa841 = (0, 270, 0);
      right_elevator = spawn_model("building_saba_elevator_set", var_430ac5dbe368d1f, var_ca3f58f0d52aa841);
    }

    return;
  }

  var_590640ad61ade716 = (2920, -1128, 150);
  var_6cfce437b59d8dcc = (0, 90, 0);
  left_elevator = spawn_model("building_saba_elevator_set", var_590640ad61ade716, var_6cfce437b59d8dcc);
  var_430ac5dbe368d1f = (2920, -548, 150);
  var_ca3f58f0d52aa841 = (0, 270, 0);
  right_elevator = spawn_model("building_saba_elevator_set", var_430ac5dbe368d1f, var_ca3f58f0d52aa841);
}

function play_movie(bink) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  while(true) {
    if(flag("nuke_bink_done")) {
      break;
    }

    setDvar(@ "hash_d3ee5a6578fe61de", "0");
    playcinematicforalllooping(bink);
    wait 3;
  }
}