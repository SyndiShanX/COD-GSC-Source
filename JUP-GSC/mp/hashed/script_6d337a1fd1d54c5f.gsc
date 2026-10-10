/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d337a1fd1d54c5f.gsc
*************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_bounty;
#using scripts\mp\poi;
#using scripts\mp\utility\player;
#namespace namespace_2e202f9e22e98e2c;

function function_9c85640063aa1a62() {
  if(getdvarint(@ "hash_6e8e023ec4104c6b", 1) == 0) {
    return;
  }

  level.huntsquads = spawnStruct();
  level.huntsquads.var_5c0db4ae53d9c085 = [];
  level.huntsquads.huntedteams = [];
  level.huntsquads.squads = [];
  level.huntsquads.var_9dd6b3d4501d8c85 = 36000000;
  level.huntsquads.activationscore = getdvarint(@ "hash_5a55c9e713f5a065", 4);
  level.huntsquads.var_5d9ed7eb019f5547 = getdvarint(@ "hash_ea5ca0afeab8e384", 3);
  level.huntsquads.var_5f8899c94cc60197 = getdvarint(@ "hash_8dfdc1bd2a887ac2", 6);
  level.huntsquads.var_2d6a23db056a0ec0 = getdvarint(@ "hash_cb63f8cb9e4e1def", 300) * 1000;
  level.huntsquads.var_85324a1062e736ba = getdvarint(@ "hash_b5d7e9e85ab3c104", 3);
  level.huntsquads.var_22d3a45413cea3ac = getdvarint(@ "hash_2b11b9aca19ce8cb", 500);
  level.huntsquads.var_55a75ba6640b59f4 = getdvarint(@ "hash_21134403816f9c13", 3000);
  level.huntsquads.var_9fe72f3581fc4d1 = getdvarint(@ "hash_af4ffd6ef7ff488c", 8000);
  level waittill("matchStartTimer_done");
  level thread function_c346d1c9ac9f157b();
}

function function_c346d1c9ac9f157b() {
  level endon("game_ended");

  while(true) {
    foreach(teamname, team in level.teamdata) {
      if(team["players"].size >= level.huntsquads.var_85324a1062e736ba) {
        if(!array_contains(level.huntsquads.var_5c0db4ae53d9c085, teamname)) {
          level.huntsquads.var_5c0db4ae53d9c085[level.huntsquads.var_5c0db4ae53d9c085.size] = teamname;
        }

        continue;
      }

      if(array_contains(level.huntsquads.var_5c0db4ae53d9c085, teamname)) {
        level.huntsquads.var_5c0db4ae53d9c085 = array_remove(level.huntsquads.var_5c0db4ae53d9c085, teamname);
      }
    }

    foreach(teamname in level.huntsquads.var_5c0db4ae53d9c085) {
      var_e4736e9e5d3b8721 = 0;

      foreach(player in level.teamdata[teamname]["players"]) {
        var_e5aeb68208944793 = scripts\mp\gametypes\dmz_bounty::function_f59bb0593a8f98a9(player);
        var_e4736e9e5d3b8721 += var_e5aeb68208944793;
      }

      var_5b7bb441a2c90a7e = var_e4736e9e5d3b8721 / level.teamdata[teamname]["players"].size;

      if(var_5b7bb441a2c90a7e > level.huntsquads.activationscore && !array_contains(level.huntsquads.huntedteams, teamname)) {
        level.huntsquads.huntedteams[level.huntsquads.huntedteams.size] = teamname;
      }
    }

    foreach(teamname in level.huntsquads.huntedteams) {
      if(!isDefined(level.huntsquads.squads[teamname]) || isDefined(level.huntsquads.squads[teamname]) && level.huntsquads.squads[teamname].agents.size == 0 && level.huntsquads.squads[teamname].lastendtime + level.huntsquads.var_2d6a23db056a0ec0 < gettime()) {
        [agents, targetplayer] = function_5ce5c9510bd3966f(teamname);

        if(isDefined(agents) && agents.size > 0) {
          var_36aab17d28116d3f = spawnStruct();
          var_36aab17d28116d3f.agents = agents;
          var_36aab17d28116d3f.lastspawntime = gettime();
          var_36aab17d28116d3f.lastendtime = undefined;
          var_36aab17d28116d3f.targetplayer = targetplayer;
          var_36aab17d28116d3f.huntedteam = teamname;
          var_36aab17d28116d3f.var_a2af1cbf7d514616 = gettime() + getdvarint(@ "hash_8f091e5825453d52", 300) * 1000;
          var_36aab17d28116d3f.endhunt = 0;
          task = spawnStruct();
          task.taskended = 0;
          task.targetteam = teamname;
          var_36aab17d28116d3f.task = task;
          level.huntsquads.squads[teamname] = var_36aab17d28116d3f;
          level thread function_e5eb00bff9a93501(var_36aab17d28116d3f);
          level thread function_dd936ebce491512c(var_36aab17d28116d3f);
          function_747765fe20e9955f(var_36aab17d28116d3f);
          level thread function_5a859e557f811744(var_36aab17d28116d3f);
        }
      }
    }

    foreach(teamname, var_36aab17d28116d3f in level.huntsquads.squads) {
      if(var_36aab17d28116d3f.agents.size == 0) {
        level.huntsquads.huntedteams = array_remove(level.huntsquads.huntedteams, teamname);
      }
    }

    wait 5;
  }
}

function function_5a859e557f811744(var_36aab17d28116d3f) {
  level endon("game_ended");
  continuetracking = 1;

  while(continuetracking) {
    if(istrue(var_36aab17d28116d3f.endhunt)) {
      return;
    }

    if(gettime() >= var_36aab17d28116d3f.var_a2af1cbf7d514616) {
      break;
    }

    wait 1;
  }

  function_dc92e2d675b5c228(var_36aab17d28116d3f);
}

function function_dd936ebce491512c(var_36aab17d28116d3f) {
  foreach(agent in var_36aab17d28116d3f.agents) {
    level thread function_14f434eeea1ea747(agent, var_36aab17d28116d3f);
  }
}

function function_afb28615a07de8be(var_36aab17d28116d3f) {
  level endon("game_ended");
  var_92d22dd457ed9c95 = 1;

  while(var_92d22dd457ed9c95) {
    if(istrue(var_36aab17d28116d3f.endhunt)) {
      return;
    }

    players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];
    var_92d22dd457ed9c95 = 0;

    foreach(player in players) {
      if(isalive(player)) {
        var_92d22dd457ed9c95 = 1;
        break;
      }
    }

    waitframe();
  }

  function_dc92e2d675b5c228(var_36aab17d28116d3f);
}

function function_dc92e2d675b5c228(var_36aab17d28116d3f) {
  var_36aab17d28116d3f.endhunt = 1;
  var_36aab17d28116d3f.lastendtime = gettime();
  players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];

  if(var_36aab17d28116d3f.agents.size > 0) {
    level thread function_2678f4f9c8f29e17(var_36aab17d28116d3f);
  }

  foreach(player in players) {
    player.aq_targethudenabled = 0;
    player setclientomnvar("ui_br_assassination_target", 0);
  }

  var_36aab17d28116d3f.task.taskended = 1;
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hunt_target_survived", players);
  function_c1fd3441ccfba6f8(var_36aab17d28116d3f.huntedteam, "dmz_activity_win", 1);
}

function function_14f434eeea1ea747(agent, var_36aab17d28116d3f) {
  agent waittill("death");
  var_36aab17d28116d3f.agents = array_remove(var_36aab17d28116d3f.agents, agent);

  if(var_36aab17d28116d3f.agents.size == 0) {
    function_dc92e2d675b5c228(var_36aab17d28116d3f);
  }
}

function function_5ce5c9510bd3966f(playerteamname) {
  var_9b71757c091ff3a8 = function_d1f2fac85d1d53ec(playerteamname);
  var_246027a1b24dd32f = ["ar", "sniper", "lmg", "sniper", "sniper", "lmg", "ar", "lmg"];
  agentrequests = [];

  foreach(reinforcementtype in var_246027a1b24dd32f) {
    agentrequests[agentrequests.size] = scripts\mp\ai_mp_controller::function_de59d7cb310c1aff(reinforcementtype, 3);
  }

  var_ec862c2c00c7ab5d = scripts\mp\ai_mp_controller::function_b9d78fce07834c95(agentrequests);
  team = level.var_4b195d3dd0024b9c;
  agents = scripts\mp\ai_mp_controller::function_2f3b04fc531b4115(level.huntsquads.var_5f8899c94cc60197, var_9b71757c091ff3a8.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "closet", undefined, undefined, var_ec862c2c00c7ab5d);

  if(!isDefined(agents) || agents.size == 0) {
    agents = scripts\mp\ai_mp_controller::function_2f3b04fc531b4115(level.huntsquads.var_5f8899c94cc60197, var_9b71757c091ff3a8.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "heli", undefined, undefined, var_ec862c2c00c7ab5d);
  }

  if(!isDefined(agents) || agents.size == 0) {
    return [];
  }

  foreach(agent in agents) {
    if(isDefined(agent) && !isint(agent) && isalive(agent)) {
      agent thread hsquad_overrideagent(agent);
      scripts\cp_mp\agents\agent_utils::function_58aab2edaec2599f(agent, "hSquad_overrideAgent", &hsquad_overrideagent);
    }
  }

  return [agents, var_9b71757c091ff3a8];
}

function function_d1f2fac85d1d53ec(playerteamname, playerlist) {
  var_9b71757c091ff3a8 = undefined;
  mostkills = 0;

  if(isDefined(playerlist)) {
    var_23c073f7e25a2123 = playerlist;
  } else {
    if(!isDefined(playerteamname)) {
      return;
    }

    var_23c073f7e25a2123 = level.teamdata[playerteamname]["players"];
  }

  foreach(player in var_23c073f7e25a2123) {
    if(!isDefined(var_9b71757c091ff3a8) || player.kills > mostkills) {
      var_9b71757c091ff3a8 = player;
      mostkills = player.kills;
    }
  }

  return var_9b71757c091ff3a8;
}

function function_937f3ece2a4cc754(playerteamname, origin) {
  var_23c073f7e25a2123 = level.teamdata[playerteamname]["players"];
  closeplayers = [];

  foreach(player in var_23c073f7e25a2123) {
    distsq = distancesquared(player.origin, origin);

    if(level.huntsquads.var_9dd6b3d4501d8c85 > distsq) {
      closeplayers[closeplayers.size] = player;
    }
  }

  return closeplayers;
}

function function_58daeffda334806b(agents) {
  agentorigins = [];

  foreach(agent in agents) {
    if(isalive(agent)) {
      agentorigins[agentorigins.size] = agent.origin;
    }
  }

  if(agentorigins.size == 0) {
    return;
  }

  return averagepoint(agentorigins);
}

function function_e5eb00bff9a93501(var_36aab17d28116d3f) {
  var_cb791416725e9bc6 = 1;
  function_c1fd3441ccfba6f8(var_36aab17d28116d3f.huntedteam, "dmz_activity_tension", 1);
  players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];

  foreach(player in players) {
    scripts\cp_mp\agents\agent_utils::function_ab491b16f8423c8e(player, "hs", 0);
    group = scripts\cp_mp\agents\agent_utils::function_ed5140c225d4f337(player);
    scripts\cp_mp\agents\agent_utils::function_ca2adce5c7865c20(player, group);
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hunt_assigned_others", [player]);
    function_bcc9e506d1dbad57(player, var_36aab17d28116d3f);
    player.var_783a508c7b030e91 = 1;
  }

  while(true) {
    if(istrue(var_36aab17d28116d3f.endhunt)) {
      return;
    }

    var_3e75268d56d4f616 = 0;

    foreach(agent in var_36aab17d28116d3f.agents) {
      if(isDefined(agent.vehicle)) {
        var_3e75268d56d4f616 = 1;
        break;
      }
    }

    if(!var_3e75268d56d4f616) {
      break;
    }

    wait 1;
  }

  level thread function_afb28615a07de8be(var_36aab17d28116d3f);

  while(var_cb791416725e9bc6) {
    if(istrue(var_36aab17d28116d3f.endhunt)) {
      return;
    }

    players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];

    foreach(player in players) {
      if(isDefined(player) && isalive(player) && istrue(player.var_783a508c7b030e91)) {
        continue;
      }

      scripts\cp_mp\agents\agent_utils::function_ab491b16f8423c8e(player, "hs", 0);
      group = scripts\cp_mp\agents\agent_utils::function_ed5140c225d4f337(player);
      scripts\cp_mp\agents\agent_utils::function_ca2adce5c7865c20(player, group);
      player.var_783a508c7b030e91 = 1;
    }

    squadorigin = function_58daeffda334806b(var_36aab17d28116d3f.agents);
    closeplayers = function_937f3ece2a4cc754(var_36aab17d28116d3f.huntedteam, squadorigin);

    if(!isDefined(closeplayers) || closeplayers.size == 0) {
      function_dc92e2d675b5c228(var_36aab17d28116d3f);
      var_cb791416725e9bc6 = 0;
      continue;
    }

    var_36aab17d28116d3f.targetplayer = function_d1f2fac85d1d53ec(var_36aab17d28116d3f.playerteamname, closeplayers);

    foreach(agent in var_36aab17d28116d3f.agents) {
      if(isDefined(agent.vehicle)) {
        continue;
      }

      disttotargetsq = distancesquared(agent.origin, var_36aab17d28116d3f.targetplayer.origin);

      if(disttotargetsq < level.huntsquads.var_9dd6b3d4501d8c85) {
        rushdist = function_700cf5f1cd29a9dc(agent.agent_type);
        agent thread scripts\mp\ai_behavior::function_a5117518725da028(agent, var_36aab17d28116d3f.targetplayer.origin, rushdist, rushdist, 32, 1);
        continue;
      }

      agent thread scripts\mp\ai_behavior::function_a5117518725da028(agent, squadorigin, 32, 32, 32, 1);
    }

    wait 10;
  }
}

function function_2678f4f9c8f29e17(var_36aab17d28116d3f) {
  squadorigin = function_58daeffda334806b(var_36aab17d28116d3f.agents);
  fortress = scripts\mp\ai_mp_controller::function_9c5a68ca1385322e(squadorigin, undefined, undefined, 8000, undefined, 1);

  foreach(agent in var_36aab17d28116d3f.agents) {
    origin = undefined;

    if(isDefined(fortress)) {
      origin = random(fortress.spawnclosetnodes).origin;
      agent thread scripts\mp\ai_behavior::function_a5117518725da028(agent, origin, 32, 32, 32, 1);
    }

    agent thread function_969be422c531295a(agent, origin);
  }
}

function function_969be422c531295a(agent, origin) {
  agent endon("death");
  distsq = 225000000;

  if(isDefined(origin)) {
    distsq = distancesquared(agent.origin, origin);
  }

  targetdist = 16384;
  timepassed = 0;
  interval = 5;

  while(distsq > targetdist) {
    if(isDefined(origin)) {
      agent thread scripts\mp\ai_behavior::function_a5117518725da028(agent, origin, 32, 32, 32, 1);
    }

    wait interval;
    players = getentarrayinradius("player", "classname", agent.origin, 2056);

    if(isDefined(players) && players.size == 0) {
      break;
    }

    if(isDefined(origin)) {
      distsq = distancesquared(agent.origin, origin);
    }
  }

  agent.nocorpse = 1;
  agent.noloot = 1;
  agent.var_ad799295a6692b29 = 1;
  agent.dropweapon = 0;
  agent kill();
}

function function_700cf5f1cd29a9dc(aitype) {
  if(!isDefined(aitype)) {
    return;
  }

  if(issubstr(aitype, "_ar")) {
    return 256;
  }

  if(issubstr(aitype, "_lmg") || issubstr(aitype, "_sniper")) {
    return 768;
  }

  if(issubstr(aitype, "_smg") || issubstr(aitype, "_shotgun")) {
    return 128;
  }

  if(issubstr(aitype, "_rpg")) {
    return 512;
  }
}

function function_f35a110d69d42dc9(team) {
  if(isDefined(level.huntsquads) && isDefined(level.huntsquads.squads)) {
    foreach(struct in level.huntsquads.squads) {
      if(isDefined(struct.targetteam) && team == struct.targetteam && !istrue(struct.endhunt)) {
        return true;
      }
    }
  }

  return false;
}

function function_37b884b4df5b873() {
  wait 5;
  player = level.players[0];
  scripts\cp_mp\agents\agent_utils::function_ab491b16f8423c8e(player, "hs", 0);
  group = scripts\cp_mp\agents\agent_utils::function_ed5140c225d4f337(player);
  scripts\cp_mp\agents\agent_utils::function_ca2adce5c7865c20(player, group);
  level thread function_5ce5c9510bd3966f(player.team);
}

function function_17fa0b0f3fced1c5(agent) {
  agent endon("death");

  while(true) {
    if(!isint(agent) && isalive(agent)) {
      sphere(agent.origin, 64, (1, 0, 0));
    }

    waitframe();
  }
}

function hsquad_overrideagent(agent) {
  agent thread scripts\cp_mp\agents\agent_utils::function_9ca698cdffe22968(agent, 1);
  wait 1;
  helmet = level.var_6855c201495094b6["tier3"];
  agent function_cbc1621bbd0bb42d(1);
  scripts\cp_mp\agents\agent_utils::function_58203c3739d2d0c6(agent, "huntSquad");
  agent.var_b582b10663b5b2a9 = 0;

  if(cointoss()) {
    body = "body_mp_koenig_iw9_7_1";
    head = "head_mp_koenig_iw9_7_1";
  } else {
    body = "body_mp_stiletto_iw9_8_1";
    head = "head_mp_stiletto_iw9_8_1";
  }

  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(body, head, undefined, undefined, undefined, level.huntsquads.var_22d3a45413cea3ac, helmet, 1);
  agent.baseaccuracy = getdvarfloat(@ "hash_c7631ad6f642733b", 2.2);
  agent.var_cbd87a0bc497b778 = 1;
  agent.var_8e3405ac46c40e0f = 1;
  agent.var_d5e499e7fe2c490b = 1;
  agent.revive_bleedouttime = 12000;
  agent.var_98add129a7ecb962 = 1;
  agent.forcelongdeath = 1;
  agent setengagementmindist(1024, 256);
  agent setengagementmaxdist(6000, 9000);
  agent function_9215ce6fc83759b9(4500);
  agent thread function_17fa0b0f3fced1c5(agent);
}

function function_747765fe20e9955f(var_36aab17d28116d3f) {
  players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hunt_assigned_others", players);

  foreach(player in players) {
    function_bcc9e506d1dbad57(player, var_36aab17d28116d3f);
  }
}

function function_bcc9e506d1dbad57(player, var_36aab17d28116d3f) {
  player setclientomnvar("ui_br_assassination_target_timer", var_36aab17d28116d3f.var_a2af1cbf7d514616);
  player.aq_targethudenabled = 1;
  player thread function_602d8934e5324a2d(var_36aab17d28116d3f);
}

function function_602d8934e5324a2d(var_36aab17d28116d3f) {
  while(true) {
    if(istrue(var_36aab17d28116d3f.endhunt)) {
      return;
    }

    players = level.teamdata[var_36aab17d28116d3f.huntedteam]["players"];

    if(!isDefined(var_36aab17d28116d3f.lastthreatlevel)) {
      var_36aab17d28116d3f.lastthreatlevel = [];
    }

    threatlevel = undefined;

    if(!isDefined(var_36aab17d28116d3f.targetplayer)) {
      squadorigin = function_58daeffda334806b(var_36aab17d28116d3f.agents);
      closeplayers = function_937f3ece2a4cc754(var_36aab17d28116d3f.huntedteam, squadorigin);
      var_36aab17d28116d3f.targetplayer = function_d1f2fac85d1d53ec(var_36aab17d28116d3f.playerteamname, closeplayers);
    }

    dist = distance(var_36aab17d28116d3f.targetplayer.origin, function_58daeffda334806b(var_36aab17d28116d3f.agents));
    threatlevel = 0;

    if(dist > level.huntsquads.var_9fe72f3581fc4d1) {
      threatlevel = 0;
    } else if(dist > level.huntsquads.var_55a75ba6640b59f4) {
      threatlevel = 1;
      function_c1fd3441ccfba6f8(var_36aab17d28116d3f.huntedteam, "dmz_activity_tension", 0, "dmz_activity_tension_classic");
    } else {
      threatlevel = 2;
    }

    foreach(player in players) {
      playerid = player scripts\mp\utility\player::getuniqueid();

      if(!isDefined(var_36aab17d28116d3f.lastthreatlevel[playerid])) {
        var_36aab17d28116d3f.lastthreatlevel[playerid] = 0;
      }

      if(!isDefined(threatlevel)) {
        threatlevel = var_36aab17d28116d3f.lastthreatlevel[playerid];
      }

      var_36aab17d28116d3f.lastthreatlevel[playerid] = threatlevel;
      player namespace_1eb3c4e0e28fac71::function_19582ba0dbcc0ab0(player, threatlevel);
    }

    wait 2;
  }
}