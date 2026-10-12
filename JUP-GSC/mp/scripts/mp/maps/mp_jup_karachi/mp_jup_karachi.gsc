/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_karachi\mp_jup_karachi.gsc
*************************************************************/

#using script_30fbbeb9a6251e9a;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_karachi\gen\mp_jup_karachi_art;
#using scripts\mp\maps\mp_jup_karachi\mp_jup_karachi_fx;
#using scripts\mp\maps\mp_jup_karachi\mp_jup_karachi_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#using scripts\stealth\enemy;
#namespace mp_jup_karachi;

function main() {
  scripts\mp\maps\mp_jup_karachi\gen\mp_jup_karachi_art::main();
  scripts\mp\maps\mp_jup_karachi\mp_jup_karachi_fx::main();
  scripts\mp\maps\mp_jup_karachi\mp_jup_karachi_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_karachi");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_31dc060e85f4a689();
  function_e06c6de255dd9770();
  wait 0.05;
}

function function_1682cf22619a5e55() {
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}

function function_e06c6de255dd9770() {
  if(!function_d86d387e8205b87f()) {
    return;
  }

  level.var_648cfe8e093ab1e = &function_f4c47c36c9a0f0d;
  setDvar(@ "scr_starsystem", 0);
}

function function_f4c47c36c9a0f0d(player) {
  player endon("death");
  player endon("disconnect");

  if(!function_d86d387e8205b87f()) {
    return;
  }

  offsets = [];
  offsets[0] = (0, 0, 0);
  offsets[1] = (0, 85, 250);
  offsets[2] = (85, 0, 500);
  team = player.pers["team"];

  if(getdvarint(@ "hash_8d1e4d803cf510c4", 0)) {
    team = getotherteam(team)[0];
  }

  for(i = 0; i < 3; i++) {
    x = offsets[i][0];
    y = offsets[i][1];
    z = 0;
    up = anglestoup((0, 0, 0));
    safeorigin = getclosestpointonnavmesh(player.origin + (x, y, z), up);

    if(getnumactiveagents("actor_jup_enemy_mp_ar_gl") >= getdvarint(@ "hash_6bd2368eb9f278c6", 9)) {
      return;
    }

    ai = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent("actor_jup_enemy_mp_ar_gl", safeorigin, undefined, "high", "everybody", undefined, undefined, team);
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    ai endon("death");
    waitframe();
    ai thread namespace_30bebe2c8fdd4f94::function_c789cc0bd60384c2(safeorigin + (0, 0, 1000 + offsets[i][2]), safeorigin);
    ai scripts\stealth\enemy::bt_set_stealth_state("combat");
  }
}

function function_d86d387e8205b87f() {
  return getdvarint(@ "hash_969da081cdd3cead", 0);
}

function function_31dc060e85f4a689() {
  spawns = [];

  switch (getbasegametype()) {
    case #"hash_25397d96e5bc8403":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_xfire_spawn_axis_start", (288, 2380, 16), (0, 270, 0), undefined, undefined);
      break;
    case #"hash_1a5d186c17c00d3c":
      break;
    case #"hash_a1313b745c17c07e":
      break;
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      break;
    case #"hash_2fcf99fb5dbdcffb":
    case #"hash_3a17de6e294210d2":
    case #"hash_515260130b210bff":
    case #"hash_7485fa6c474ec865":
    case #"hash_973d1db8b6644466":
    case #"hash_b0eb18371d980895":
    case #"hash_b9458959b10637f8":
    case #"hash_c3668076a0827ce0":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ddd385f0a27d71bb":
    case #"hash_ea061d29bbd1f237":
    case #"hash_ec24570718a340f5":
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (274, 2426, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (234, 2486, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (150, 2486, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (308, 2540, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (192, 2562, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (98, 2554, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (254, 2598, 16), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (204, -3296, 21.7892), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (440, -3310, 19.3387), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (524, -3306, 17.5416), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (402, -3390, 16), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (488, -3392, 16.2038), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (566, -3390, 20.1409), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1070, 102, 16), (0, 270, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1622, 54, 32), (0, 209, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1808, 134, 32), (0, 219, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2098, 908, 34), (0, 259, 0), undefined, "3");
      break;
    case #"hash_c51506c10984515":
    case #"hash_21eed743fb721f4a":
    case #"hash_31104ebc01bd9ba9":
    case #"hash_3696c16c262a0862":
    case #"hash_77eb1179a728005e":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      break;
    case #"hash_f4a9126c03d3385b":
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}