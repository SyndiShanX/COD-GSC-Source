/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_invasion\mp_jup_invasion.gsc
***************************************************************/

#using script_3d2770dc09c1243;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\robj;
#using scripts\mp\gametypes\xfire;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_invasion\gen\mp_jup_invasion_art;
#using scripts\mp\maps\mp_jup_invasion\mp_jup_invasion_fx;
#using scripts\mp\maps\mp_jup_invasion\mp_jup_invasion_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_invasion;

function main() {
  scripts\mp\maps\mp_jup_invasion\gen\mp_jup_invasion_art::main();
  scripts\mp\maps\mp_jup_invasion\mp_jup_invasion_fx::main();
  scripts\mp\maps\mp_jup_invasion\mp_jup_invasion_lighting::main();
  scripts\mp\load::main();
  level.var_3ac8a33643641ede = &scripts\mp\gametypes\robj::main;
  var_18fd95d2dc389573 = &scripts\mp\gametypes\xfire::main;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap();
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "hash_52e4ca82ec45d480", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_31dc060e85f4a689();

  if(namespace_ef54497d29a56093::function_5a60778277d6ae4b()) {
    setDvar(@ "hash_a7c59e9830aa5637", 0);
    setDvar(@ "hash_f7910830506b8974", 0);
    setDvar(@ "hash_27572078d01a0677", 50);
    setDvar(@ "hash_f6297cf726b2f395", 100);
  }

  level thread function_cfd48b8366991570();
}

function function_cfd48b8366991570() {
  gametype = getbasegametype();

  if(gametype == "war" || gametype == "cmd" || gametype == "cyber" || gametype == "tdm" || gametype == "dom" || gametype == "koth" || gametype == "war") {
    level waittill("infil_setup_complete");

    if(!gameflag("infil_will_run")) {
      spawnpos = (642.704, 1711.66, 293.748);
      spawnang = (359.859, 307.737, 0.677918);
      jltv_husk = spawn_model("veh9_mil_lnd_jltv_x_vehphys_hsk_mp", spawnpos, spawnang);
    }

    return;
  }

  spawnpos = (642.704, 1711.66, 293.748);
  spawnang = (359.859, 307.737, 0.677918);
  jltv_husk = spawn_model("veh9_mil_lnd_jltv_x_vehphys_hsk_mp", spawnpos, spawnang);
}

function function_c0a71bc2608541e0() {
  if(gameflag("infil_will_run")) {
    wait 1;
    var_2b7c88f7a725417f = (0, 0, -2000);
    var_b35d3d157748cb4 = getEntArray("jltv_infil_clip", "targetname");
    level.var_b35d3d157748cb4 = var_b35d3d157748cb4;

    foreach(clip in var_b35d3d157748cb4) {
      clip.originalpos = clip.origin;
      waitframe();
      clip.origin += var_2b7c88f7a725417f;
    }

    level waittill("prematch_over");
    waitframe();

    foreach(clip in var_b35d3d157748cb4) {
      clip dontinterpolate();
      clip.origin = clip.originalpos;
    }
  }
}

function function_31dc060e85f4a689() {
  spawns = [];

  switch (getbasegametype()) {
    case #"hash_1a5d186c17c00d3c":
      level.modifiedspawnpoints["-948 1786"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-799 1683"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-467 1843"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["466 3062"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["292 1212"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-750 1712"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-230 -1480"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["421 -1400"]["mp_ctf_spawn"]["remove"] = 1;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (1227, 1286, 288), (0, 285, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (1403, 1270, 275), (0, 240, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2768, 744, 304), (0, 240, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2880, 680, 304), (0, 195, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2871, 291, 304), (0, 195, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2927, 99, 304), (0, 195, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2472, -324, 297), (0, 240, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2366, -452, 305), (0, 135, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-1920, -1504, 273), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2696, -720, 272), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2752, -88, 280), (0, 315, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2624, -88, 280), (0, 315, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2688, 256, 273), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2584, 584, 272), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2728, 904, 271), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2728, 1088, 271), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2240, 1728, 272), (0, 315, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2048, 1664, 272), (0, 285, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (1864, -376, 320), (0, 225, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (1912, -440, 320), (0, 210, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (2664, 1035, 312), (0, 240, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2321, 1093, 274), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2329, 917, 274), (0, 345, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2091, -8, 280), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2068, -232, 280), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-2072, 108, 280), (0, 360, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (-1480, 400, 280), (0, 315, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_ctf_spawn", (234, 1207, 317), (0, 120, 0), undefined, undefined);
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
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2444, 1288, 320), (0, 193, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2428, 682, 306), (0, 236, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2374, 610, 306), (0, 236, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2656, 1032, 468), (0, 158, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (2014, 1834, 480), (0, 236, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (2150, 1650, 320), (0, 240, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (2358, 1628, 320), (0, 240, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (2828, 1262, 320), (0, 235, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (2582, 922, 320), (0, 235, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-1326, 220, 292), (0, 103, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-1262, -704, 288), (0, 92, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-1626, -840, 310), (0, 92, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-2010, -356, 282), (0, 92, 0), undefined, "3");
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