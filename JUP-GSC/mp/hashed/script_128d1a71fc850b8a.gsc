/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_128d1a71fc850b8a.gsc
*************************************************/

#using script_15074130da8a935c;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\objidpoolmanager;
#namespace namespace_550d8f4896d02349;

function init() {
  level.brgametype.var_d5c773afd22da0c5 = getdvarint(@ "hash_158f6c01ccefb107", 0) == 1;

  if(!istrue(level.brgametype.var_d5c773afd22da0c5)) {
    return;
  }

  level.brgametype.var_d03527ff0e6315 = getdvarint(@ "hash_beef8246b709c849", 5);
  level.brgametype.var_3f4c679970c59455 = getdvarint(@ "hash_ec1144da8d0ebb36", 4);
  level.brgametype.var_4b58204f3c5987d8 = getdvarint(@ "hash_ba144c4a820cd8f9", 1);
  level.brgametype.var_cc07ca7d5aeb1f87 = getdvarint(@ "hash_e2660ec466d23bf9", 100);
  level.brgametype.var_6d7eb4b39f6fea2d = pow(getdvarint(@ "hash_7000264c08e7ac45", 500), 2);
  level.brgametype.var_d0adfb51398bdf71 = getdvarint(@ "hash_3a8f51b0eaa8b895", 3);
  level.brgametype.var_5fca7073368d1eeb = getdvarint(@ "hash_22c52597541ec14c", 100);
  var_6269246106806189 = getStructArray("racket", "targetname");

  if(var_6269246106806189.size == 0 || level.brgametype.var_d03527ff0e6315 == 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(var_6269246106806189.size < level.brgametype.var_d03527ff0e6315) {
    assertmsg("<dev string:x56>");
    level.brgametype.var_d03527ff0e6315 = var_6269246106806189.size;
  }

  var_6269246106806189 = array_randomize(var_6269246106806189);

  foreach(racket in var_6269246106806189) {
    function_719e6e9e78eec15f(racket);
  }

  level.brgametype.var_74cbed034a36dbaa = [];

  for(i = 0; i < level.brgametype.var_d03527ff0e6315; i++) {
    racket = var_6269246106806189[i];
    level.brgametype.var_74cbed034a36dbaa[level.brgametype.var_74cbed034a36dbaa.size] = racket;
    thread function_eb74659878a99a6c(racket);
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\ai_mp_controller::function_ba4022744dce59f6("racket");

  foreach(racket in level.brgametype.var_74cbed034a36dbaa) {
    thread function_73572d13bc47f601(racket);
  }
}

function function_719e6e9e78eec15f(racket) {
  racket.guardnodes = [];
  racket.cachenodes = [];
  racket.flagnodes = [];
  var_b5c3a12c64229f24 = getStructArray(racket.target, "targetname");

  foreach(node in var_b5c3a12c64229f24) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }

    script_noteworthy = tolower(node.script_noteworthy);

    switch (script_noteworthy) {
      case #"hash_7df245010bdec44e":
        racket.guardnodes[racket.guardnodes.size] = node;
        break;
      case #"hash_dc0a55772fe305c5":
        racket.cachenodes[racket.cachenodes.size] = node;
        break;
      case #"hash_f4cfb31523436f37":
        racket.flagnodes[racket.flagnodes.size] = node;
        break;
      default:
        break;
    }
  }
}

function function_eb74659878a99a6c(racket) {
  var_b006c818269d9e9c = function_a33799270d64c339(racket);

  if(isDefined(var_b006c818269d9e9c)) {
    var_b006c818269d9e9c = "brstageditems:" + var_b006c818269d9e9c;
    thread namespace_76ebb832f1cbeaa::init(var_b006c818269d9e9c, undefined, 1);
  }
}

function function_73572d13bc47f601(racket) {
  level endon("game_ended");
  racket.agents = [];
  racket.guardnodes = array_randomize(racket.guardnodes);
  function_675517b7c4c0de3d(racket, level.brgametype.var_3f4c679970c59455, 1);
  function_675517b7c4c0de3d(racket, level.brgametype.var_4b58204f3c5987d8, 2);
  scripts\mp\ai_mp_controller::function_35bae74232ff8b77(0);
  racket.cachenodes = array_randomize(racket.cachenodes);
  function_625fd0eb153c43b0(racket);
  function_c851837194379726(racket);
  function_d34497ae5051ab11(racket);
  thread function_3d9918f00f98b775(racket);
}

function function_a33799270d64c339(racket) {
  var_44e91535f06b130d = racket.script_noteworthy;

  if(!isDefined(var_44e91535f06b130d)) {
    return;
  }

  mapname = level.mapname;
  var_d7eaba8bf8ff0b00 = strtok(mapname, "_");
  var_f3bbd3be79c0316e = var_d7eaba8bf8ff0b00[var_d7eaba8bf8ff0b00.size - 1];
  return "wz2_" + var_f3bbd3be79c0316e + "_staged_" + var_44e91535f06b130d;
}

function function_675517b7c4c0de3d(racket, number, tier) {
  if(racket.guardnodes.size < number) {
    msg = "Not enough guard nodes with target : " + racket.target;
    assertmsg(msg);
    number = racket.guardnodes.size;
  }

  for(i = 0; i < number; i++) {
    guardnode = racket.guardnodes[0];
    agent = function_e7ef87a1bf538dbc(racket, guardnode, tier);
    racket.agents[racket.agents.size] = agent;
    racket.guardnodes = array_remove_index(racket.guardnodes, 0);
  }
}

function function_e7ef87a1bf538dbc(racket, guardnode, tier) {
  basetype = scripts\mp\ai_mp_controller::function_6d1e55c48e2c12f();
  aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693(basetype, tier);
  spawnlocation = getclosestpointonnavmesh(guardnode.origin + (0, 0, 30));
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, spawnlocation, undefined, "absolute", "racket");

  if(isagent(agent)) {
    agent.health = level.brgametype.var_cc07ca7d5aeb1f87;
    agent.maxhealth = level.brgametype.var_cc07ca7d5aeb1f87;
    agent.combatmode = "cover";
    agent.maxsightdistsqrd = level.brgametype.var_6d7eb4b39f6fea2d;
    agent thread function_b11c1964f528574b(agent, 0, spawnlocation);
    agent thread agent_watchdeath(racket);
    return agent;
  }

  return undefined;
}

function function_625fd0eb153c43b0(racket) {
  number = level.brgametype.var_d0adfb51398bdf71;

  if(racket.cachenodes.size < number) {
    msg = "Not enough cache nodes with target : " + racket.target;
    assertmsg(msg);
    number = racket.cachenodes.size;
  }

  for(i = 0; i < number; i++) {
    node = racket.cachenodes[i];
    roll = randomint(100);
    cachetype = "br_loot_cache";

    if(roll < level.brgametype.var_5fca7073368d1eeb) {
      cachetype = "br_loot_cache_lege";
    }

    scriptable = spawnscriptable(cachetype, node.origin, node.angles);
    scriptable setscriptablepartstate("body", "closed_usable");
  }
}

function function_c851837194379726(racket) {
  if(racket.flagnodes.size < 0) {
    msg = "No flag node found with target : " + racket.target;
    assertmsg(msg);
  }

  foreach(node in racket.flagnodes) {
    spawn_model("fabric_rectangular_aq_flag_windlevel_2_konni", node.origin, node.angles);
  }
}

function function_d34497ae5051ab11(racket) {
  objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add(objidnum, "active", racket.origin, "hud_icon_objective_rackets", "icon_regular");
  objective_setbackground(objidnum, 1);
  objective_setrotateonminimap(objidnum, 1);
  objective_sethideelevation(objidnum, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objidnum);
  racket.objidnum = objidnum;
}

function function_2ccbd153c93aade1(racket) {
  objective_delete(racket.objidnum);
  scripts\mp\objidpoolmanager::returnobjectiveid(racket.objidnum);
  racket notify("cleared");
}

function function_3d9918f00f98b775(racket) {
  level endon("game_ended");
  racket endon("cleared");

  while(true) {
    if(scripts\mp\gametypes\br_circle::function_24c5a8d31ae262f(racket.origin)) {
      if(racket.agents.size != 0) {
        foreach(agent in racket.agents) {
          killagent(agent);
        }
      }
    }

    wait 1;
  }
}

function agent_watchdeath(racket) {
  level endon("game_ended");
  self waittill("death");
  racket.agents = array_remove(racket.agents, self);

  if(racket.agents.size == 0) {
    function_2ccbd153c93aade1(racket);
  }
}