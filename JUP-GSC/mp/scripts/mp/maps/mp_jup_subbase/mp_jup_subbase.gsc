/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_subbase\mp_jup_subbase.gsc
*************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_subbase\gen\mp_jup_subbase_art;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_lighting;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_precache;
#using scripts\mp\utility\game;
#namespace mp_jup_subbase;

function main() {
  scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx::main();
  scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_lighting::main();
  scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_precache::main();
  scripts\mp\maps\mp_jup_subbase\gen\mp_jup_subbase_art::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_subbase");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 1024);
  setDvar(@ "hash_71fe8b216d50a24c", 0.68);
  setDvar(@ "hash_402173c7dbee15d9", 3);
  setDvar(@ "hash_656131a98e0d2c9d", 100);
  setDvar(@ "hash_6a4705943fd574b8", 0.4);
  setDvar(@ "hash_d0658156fb7f2311", 2);
  setDvar(@ "hash_595f2292597ec0c7", (0.3, -1, 0));
  setDvar(@ "r_dof_tweak", 1);
  setDvar(@ "hash_a7d3d16432fa5feb", 1);
  setDvar(@ "hash_ed0c0ee0926e1d16", 1500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_b1262e3cb659add1();
  thread function_79d4df95607e117();
  thread scripts\mp\animation_suite::animationsuite();
}

function function_b1262e3cb659add1() {
  level waittill("infil_setup_complete");
  var_ee23f0b1f42da962 = getEnt("static_infil_rhib", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_ee23f0b1f42da962)) {
    var_ee23f0b1f42da962 hide();
    level waittill("prematch_over");
    var_ee23f0b1f42da962 show();
    setDvar(@ "r_dof_tweak", 1);
    setDvar(@ "hash_ed0c0ee0926e1d16", 29.31);
    setDvar(@ "hash_a7d3d16432fa5feb", 22);
  }
}

function function_79d4df95607e117() {
  trigger_1 = spawn("trigger_box", (3980, -5556, -232), 0, (2048, 2048, 1024), (2048, 2048, 1024) + (1, 1, 1));
  trigger_1.targetname = "OutOfBounds";
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger_1;
}