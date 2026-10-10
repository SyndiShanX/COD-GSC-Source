/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f4866552f0ba818.gsc
*************************************************/

#using script_53da3333b83b3527;
#using script_640cf1641c03e2a0;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dmz_ai;
#using scripts\mp\utility\teams;
#using scripts\stealth\enemy;
#namespace namespace_eb6ac52b0efdfdcf;

function function_5a426c120b990e2c() {
  level.var_8abd2c3c0748dfdd = getdvarint(@ "hash_298cc7147ef3f50b", 0);
  scripts\mp\ai_mp_controller::init();

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  while(!isDefined(level.agentarray)) {
    waitframe();
  }

  setDvar(@ "hash_d3907cde9245b595", 0);
  level.var_b747ee617515989a = getdvarint(@ "hash_dc995ffe71bb3262", 256);
  level.var_72e8a99508b7be1b = getdvarint(@ "hash_80dab21524b4b344", 32);
  level.var_33bf1309ab913bea = getdvarint(@ "hash_23d2d501004ed790", 2);
  level.var_3881c7ea72921771 = getdvarint(@ "hash_6d3496529af637a1", 6);
  level.var_9d28d5b70aa9f5e4 = &function_f83373ec853727e4;
  wait 1;
  level.var_830f45e2e1a72fe9 = [];

  foreach(objective in level.objectives) {
    objective.var_99669e1e71dbd643 = [];
  }

  hqorigin = level.gw_objstruct.axishqloc.trigger.origin;
  function_f0e061bc5d7df499("axis", hqorigin);
  hqorigin = level.gw_objstruct.allieshqloc.trigger.origin;
  function_f0e061bc5d7df499("allies", hqorigin);

  while(!isDefined(level.gameskill) || !isDefined(level.difficultytype)) {
    waitframe();
  }

  level thread function_5d5756b4f3ad6727("axis");
  level thread function_5d5756b4f3ad6727("allies");
  var_cfde0d78a0770ce5 = [];

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    tempstruct = spawnStruct();
    tempstruct.origin = objective.trigger.origin;
    var_cfde0d78a0770ce5[var_cfde0d78a0770ce5.size] = tempstruct;
  }

  scripts\mp\ai_heli_reinforce::function_16c5ca10b4c664a7(var_cfde0d78a0770ce5, 1);
  scripts\mp\ai_heli_reinforce::function_bf8ab11dd9e76f93(&function_a23016f4e8d27ad9);
}

function function_f0e061bc5d7df499(team, hqorigin) {
  var_1107cd549b74476c = [];

  if(!isDefined(level.var_17a9ec1f2cb3d31c)) {
    level.var_17a9ec1f2cb3d31c = [];
  }

  level.var_17a9ec1f2cb3d31c[team] = [];

  foreach(objective in level.objectives) {
    objective.var_99669e1e71dbd643[team] = [];
  }

  foreach(objective in level.objectives) {
    var_1107cd549b74476c[objective.objectivekey] = distance(hqorigin, objective.origin);
  }

  var_7c0082df0c8d0198 = sortbydistance(level.objectives, hqorigin);
  var_b866b4302e49723d = 0;
  var_da8ad15a62b1f458 = undefined;

  foreach(objective in var_7c0082df0c8d0198) {
    if(level.var_17a9ec1f2cb3d31c[team].size == 0) {
      level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d] = [];
      level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d][0] = objective;
      var_da8ad15a62b1f458 = var_1107cd549b74476c[objective.objectivekey];
      continue;
    }

    if(abs(var_da8ad15a62b1f458 - var_1107cd549b74476c[objective.objectivekey]) < 2048) {
      level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d][level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d].size] = objective;
      var_da8ad15a62b1f458 = var_1107cd549b74476c[objective.objectivekey];
      continue;
    }

    var_b866b4302e49723d++;
    level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d] = [];
    level.var_17a9ec1f2cb3d31c[team][var_b866b4302e49723d][0] = objective;
    var_da8ad15a62b1f458 = var_1107cd549b74476c[objective.objectivekey];
  }
}

function function_5d5756b4f3ad6727(team) {
  level endon("game_ended");
  hqstring = "gw_fob_" + team + "HQ";
  var_fd5ea9cb37c309d3 = level.spawnselectionlocations[hqstring][team].spawnpoints;
  var_b5b1784d5a1327c7 = "spawnHQ_" + team;
  function_ba4022744dce59f6(var_b5b1784d5a1327c7, level.var_72e8a99508b7be1b);
  level thread function_42e3cac95300f3b6();

  while(true) {
    totalspawned = function_9368fb9261e4cd0a(var_b5b1784d5a1327c7);
    var_a678c8eea807690 = level.var_72e8a99508b7be1b - totalspawned;

    if(var_a678c8eea807690 > level.var_33bf1309ab913bea) {
      var_a678c8eea807690 = level.var_33bf1309ab913bea;
    }

    var_fd5ea9cb37c309d3 = array_randomize(var_fd5ea9cb37c309d3);

    for(i = 0; i < var_a678c8eea807690; i++) {
      aitype = function_d5bc07eabf352abb();
      agent = ai_mp_requestspawnagent(aitype, var_fd5ea9cb37c309d3[i].origin, var_fd5ea9cb37c309d3[i].angles, "medium", var_b5b1784d5a1327c7, undefined, var_b5b1784d5a1327c7, team);

      if(isDefined(agent)) {
        agent thread function_8f5702c79710b342(agent, team);
        objectivetarget = function_b2b5de3c80ebceb4(agent);
        origin = getclosestpointonnavmesh(objectivetarget.origin + (randomfloatrange(level.var_b747ee617515989a * -1, level.var_b747ee617515989a), randomfloatrange(level.var_b747ee617515989a * -1, level.var_b747ee617515989a), 0));
        agent thread function_a5117518725da028(agent, origin);
      }
    }

    wait 20;
  }
}

function function_8f5702c79710b342(agent, team) {
  waitframe();
  agent.gameskill = namespace_310bdaa3cf041c47::get_gameskill();
  agent namespace_310bdaa3cf041c47::apply_difficulty_settings(1);
  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "team", team);
  function_2e6f8aa8306432ed(agent);
}

function function_b2b5de3c80ebceb4(agent) {
  if(isDefined(agent.objectivetarget) && agent.objectivetarget.ownerteam == "neutral") {
    return agent.objectivetarget;
  }

  foreach(index, group in level.var_17a9ec1f2cb3d31c[agent.team]) {
    if(isDefined(agent.var_b866b4302e49723d) && index <= agent.var_b866b4302e49723d) {
      continue;
    }

    tempgroup = array_randomize(group);

    foreach(objective in tempgroup) {
      if(objective.var_99669e1e71dbd643[agent.team].size < level.var_3881c7ea72921771 && (objective.ownerteam == agent.team || objective.ownerteam == "neutral")) {
        agent.objectivetarget = objective;
        agent.var_b866b4302e49723d = index;
        scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "assignedObjective", objective);
        objective.var_99669e1e71dbd643[agent.team][objective.var_99669e1e71dbd643[agent.team].size] = agent;
        return objective;
      }
    }
  }

  if(!isDefined(agent.objectivetarget)) {
    keys = getarraykeys(level.var_17a9ec1f2cb3d31c[agent.team]);
    var_ffea19dcb2194908 = random(keys);
    randomgroup = level.var_17a9ec1f2cb3d31c[agent.team][var_ffea19dcb2194908];
    objective = random(randomgroup);
    agent.objectivetarget = objective;
    agent.var_b866b4302e49723d = var_ffea19dcb2194908;
    scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "assignedObjective", objective);
    objective.var_99669e1e71dbd643[agent.team][objective.var_99669e1e71dbd643[agent.team].size] = agent;
    return objective;
  }

  return agent.objectivetarget;
}

function function_42e3cac95300f3b6() {
  level endon("game_ended");

  while(true) {
    foreach(agent in level.agentarray) {
      if(isalive(agent) && isDefined(agent.objectivetarget)) {
        objectivetarget = function_b2b5de3c80ebceb4(agent);
        origin = getclosestpointonnavmesh(objectivetarget.origin + (randomfloatrange(level.var_b747ee617515989a * -1, level.var_b747ee617515989a), randomfloatrange(level.var_b747ee617515989a * -1, level.var_b747ee617515989a), 0));
        agent thread function_a5117518725da028(agent, origin);
      }
    }

    wait 20;
  }
}

function function_2e6f8aa8306432ed(agent) {
  if(agent.team == "axis") {
    body = "body_spetsnaz_cqc";
    head = "head_spetsnaz_cqc";
  } else {
    body = "body_mp_eastern_geist_1_1_lod1";
    head = "head_mp_eastern_bale_1_1";
  }

  weapon = undefined;
  grenade_type = scripts\cp_mp\agents\agent_utils::function_ba0801276542946b();
  grenadeammo = getdvarint(@ "hash_2e7cc22bee3354df", 0);
  armor = 0;
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor);
  agent.baseaccuracy = getdvarfloat(@ "hash_949a1d9903e71c7a", 0.4);
}

function function_f83373ec853727e4(agent, var_772edbdcfe906c73) {
  if(!isDefined(agent.objectivetarget)) {
    objectivetarget = function_b2b5de3c80ebceb4(agent);
  }

  var_1f48f987ba8392d0 = level.var_b747ee617515989a * 3;
  origin = getclosestpointonnavmesh(agent.objectivetarget.origin + (randomfloatrange(var_1f48f987ba8392d0 * -1, var_1f48f987ba8392d0), randomfloatrange(var_1f48f987ba8392d0 * -1, var_1f48f987ba8392d0), 0));
  agent thread function_a5117518725da028(agent, origin);
}

function function_359ea987396492db() {
  var_ccff9574f6a53859 = getdvarint(@ "hash_f4b8192392c987fc", 25);
  var_b60a2ad1b8eb2369 = getdvarint(@ "hash_8eec5964fbfe4a41", 5);

  if(istrue(level.var_8abd2c3c0748dfdd)) {
    println("<dev string:x1c>");
    println("<dev string:x45>");
    println("<dev string:x66>" + var_ccff9574f6a53859);
    println("<dev string:x80>" + var_b60a2ad1b8eb2369);
    println("<dev string:x95>" + level.agentarray.size);
    println("<dev string:xa9>" + isDefined(level.stealth));
    println("<dev string:x1c>");
  }

  possiblelocations = [];

  foreach(key, data in level.spawnselectionlocations) {
    if(issubstr(key, "_hq_")) {
      continue;
    }

    possiblelocations[key] = data;
  }

  var_6c95bb29db70af0c = possiblelocations.size * var_ccff9574f6a53859 / 100;
  objkeys = array_randomize(getarraykeys(possiblelocations));

  for(i = 0; i < var_6c95bb29db70af0c; i++) {
    function_95d5ae2b8159b521(var_b60a2ad1b8eb2369, objkeys[i], "team_six", 1);
  }
}

function function_95d5ae2b8159b521(numagents, objectivename, team, var_fd9831032cddaa89) {
  var_fd5ea9cb37c309d3 = [];

  if(istrue(var_fd9831032cddaa89)) {
    foreach(team in level.spawnselectionlocations[objectivename]) {
      var_fd5ea9cb37c309d3 = array_combine(var_fd5ea9cb37c309d3, team.spawnpoints);
    }
  }

  agents = [];

  for(i = 0; i < numagents; i++) {
    loc = random(var_fd5ea9cb37c309d3);
    agent = undefined;

    if(isDefined(loc) && isDefined(loc.origin) && isDefined(loc.angles) && isDefined(objectivename)) {
      aitype = function_d5bc07eabf352abb();
      agent = ai_mp_requestspawnagent(aitype, loc.origin, loc.angles, "medium", "everybody", "objective", objectivename);

      if(!isDefined(agent) && istrue(level.var_8abd2c3c0748dfdd)) {
        println("<dev string:x1c>");
        println("<dev string:xbd>");
        println("<dev string:xdf>" + aitype);
        println("<dev string:xeb>" + loc.origin);
        println("<dev string:xf6>" + loc.angles);
        println("<dev string:x1c>");
      }
    }

    agents[agents.size] = agent;
  }

  objectiveorigin = undefined;

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    if(objective.name == objectivename) {
      objectiveorigin = objective.trigger.origin;
      break;
    }
  }

  foreach(agent in agents) {
    if(isalive(agent) && isDefined(agent)) {
      if(isDefined(objectiveorigin)) {
        agent function_304da84d9a815c01(getclosestpointonnavmesh(objectiveorigin), 1024);
      }

      agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
      agent.stealth.script_nexthuntpos = objectiveorigin;
    }
  }
}

function function_e7ad80f4a663b94b(objectivekey, numagents, team) {
  if(!isDefined(team)) {
    return undefined;
  }

  objectiveorigin = level.objectives[objectivekey].trigger.origin;
  agents = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65(numagents, objectiveorigin, "medium", "everybody", "heli", objectivekey, team);
  return agents;
}

function function_cde31646bdb6a9d1(objectivekey, numagents, team) {
  if(!isDefined(team)) {
    return undefined;
  }

  objectiveorigin = level.objectives[objectivekey].trigger.origin;
  agents = namespace_885300a47c2b51e6::function_55ab9c6da96226e7(numagents, objectiveorigin, objectiveorigin[2] + 5000, undefined, "medium", "everybody", "paratroopers", team);
  return agents;
}

function function_a23016f4e8d27ad9(desired_origin, var_93390a6953905fef, team) {
  org_struct = spawnStruct();
  org_struct.origin = desired_origin;
  unload_locs = sortbydistance(level.helireinforcestruct.unload_locs, org_struct.origin);
  pathnode = scripts\mp\ai_heli_reinforce::function_321665dcdcbf401e(unload_locs, desired_origin);

  if(isDefined(pathnode)) {
    return pathnode;
  }

  return undefined;
}

function function_e86ea43131be76c() {
  level thread scripts\mp\gametypes\dmz_ai::init();
  scripts\mp\ai_mp_controller::init();
  function_ba4022744dce59f6("everybody", 100);
  level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
  level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();

  while(!istrue(level.var_aa5583d4cbbfd72e)) {
    waitframe();
  }

  level thread function_848d0782943b416d();
  function_2fc80954fa70d153();

  foreach(key, obj in level.objectives) {
    numagents = getdvarint(@ "hash_c9a6b9ed9529aead", 15);
    var_40e875a042b82875 = getdvarint(@ "hash_fa7168124c5a98ed", 0);
    level thread function_a30a48f0c1a403ec(key, "team_hundred_ninety_five", numagents, var_40e875a042b82875, 1);
  }
}

function function_a30a48f0c1a403ec(objectivekey, team, numagents, var_40e875a042b82875, spawninplace) {
  obj = level.objectives[objectivekey];
  groupname = function_78759441c259f58a(obj.trigger.origin);
  cqbstruct = function_2e33f8e46f95167c(obj.trigger.origin, 1024, 1);
  cqbnodes = array_combine(cqbstruct.var_e67f0b2ea7ae69ed, cqbstruct.var_8a055a821dda7da0, cqbstruct.var_3288c473e8336ab4);

  if(!isDefined(numagents)) {
    numagents = getdvarint(@ "hash_32626c81a7c27e96", 5);
  }

  if(numagents > 0) {
    if(!istrue(spawninplace)) {
      var_b58631347b6ab04 = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65(numagents, obj.trigger.origin, "medium", "everybody", "captureAgents", groupname, team, 1, undefined, undefined, undefined, undefined, 1);

      foreach(agent in var_b58631347b6ab04) {
        if(isDefined(obj.aivolume)) {
          agent setgoalvolumeauto(obj.aivolume);
        }

        agent.objectivekey = objectivekey;

        if(scripts\mp\utility\teams::isgameplayteam(team)) {
          level.objectivereinforcements[objectivekey][team].agents[level.objectivereinforcements[objectivekey][team].agents.size] = agent;
        }
      }
    } else {
      for(i = 0; i < numagents; i++) {
        aitype = function_d5bc07eabf352abb();
        var_924b776d91e77572 = undefined;

        if(cqbnodes.size > 0) {
          potentialnodes = function_3a17f0ccddc999b4(obj.trigger.origin, cqbnodes, 3, 256, 0);
          potentialnodes = array_randomize(potentialnodes);

          if(potentialnodes.size > 0) {
            var_924b776d91e77572 = potentialnodes;
          }
        }

        spawnorigin = obj.trigger.origin;

        if(isDefined(var_924b776d91e77572)) {
          spawnorigin = var_924b776d91e77572[0].origin;
        }

        agent = ai_mp_requestspawnagent(aitype, obj.trigger.origin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, team, undefined, undefined, 1);

        if(isDefined(agent)) {
          scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");

          if(isDefined(var_924b776d91e77572)) {
            function_2b26d000f2ccfc11(agent, var_924b776d91e77572[0]);
          } else {
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
          }

          if(isDefined(obj.aivolume)) {
            agent setgoalvolumeauto(obj.aivolume);
          }

          agent.objectivekey = objectivekey;

          if(scripts\mp\utility\teams::isgameplayteam(team)) {
            level.objectivereinforcements[objectivekey][team].agents[level.objectivereinforcements[objectivekey][team].agents.size] = agent;
          }
        }
      }
    }
  }

  if(!isDefined(var_40e875a042b82875)) {
    var_40e875a042b82875 = getdvarint(@ "hash_ff335488d9d13e7c", 0);
  }

  if(var_40e875a042b82875 > 0) {
    for(i = 0; i < var_40e875a042b82875; i++) {
      var_ef178bb38661ff1b = undefined;

      if(cqbnodes.size > 0) {
        potentialnodes = function_3a17f0ccddc999b4(obj.trigger.origin, cqbnodes, cqbnodes.size, 256, 0);
        potentialnodes = array_randomize(potentialnodes);

        if(potentialnodes.size > 0) {
          var_ef178bb38661ff1b = potentialnodes[0];
        }
      }

      spawnorigin = obj.trigger.origin;

      if(isDefined(var_ef178bb38661ff1b)) {
        spawnorigin = var_ef178bb38661ff1b.origin;
      }

      agent = ai_mp_requestspawnagent("actor_enemy_mp_jugg_aq", spawnorigin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, undefined, undefined, undefined, 1);

      if(isDefined(agent)) {
        scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418(agent);

        if(isDefined(var_ef178bb38661ff1b)) {
          function_2b26d000f2ccfc11(agent, var_ef178bb38661ff1b);
        } else {
          agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
        }

        if(isDefined(obj.aivolume)) {
          agent setgoalvolumeauto(obj.aivolume);
        }
      }
    }
  }
}

function function_3b97b97e14948c02(desired_origin, var_93390a6953905fef) {
  org_struct = spawnStruct();
  org_struct.origin = desired_origin;
  unload_locs = sortbydistance(level.helireinforcestruct.unload_locs, org_struct.origin);
  pathnode = scripts\mp\ai_heli_reinforce::function_321665dcdcbf401e(unload_locs, desired_origin);

  if(isDefined(pathnode)) {
    return pathnode;
  }

  return undefined;
}

function function_5cd456d9b2cdc538(agent, killer) {
  if(!isDefined(agent.objectivekey) || !scripts\mp\utility\teams::isgameplayteam(agent.team)) {
    return;
  }

  level.objectivereinforcements[agent.objectivekey][agent.team].agents = array_remove(level.objectivereinforcements[agent.objectivekey][agent.team].agents, agent);
}

function function_848d0782943b416d() {
  scripts\mp\ai_mp_controller::function_93add0b65db9f722(&function_5cd456d9b2cdc538, level);
  desiredcount = getdvarint(@ "hash_32626c81a7c27e96", 5);
  var_fde40312bd18ae9e = getdvarint(@ "hash_9780788ca9cfa05b", 2);
  var_68299821ad1626e0 = getdvarint(@ "hash_dce73a817d63d040", 30) * 1000;
  level.objectivereinforcements = [];

  foreach(key, obj in level.objectives) {
    level.objectivereinforcements[key] = [];

    foreach(team in level.teamnamelist) {
      data = spawnStruct();
      data.agents = [];
      data.var_8e55c5943a080a2e = 0;
      level.objectivereinforcements[key][team] = data;
    }
  }

  while(true) {
    foreach(key, obj in level.objectives) {
      wait 1;
      team = obj.ownerteam;

      if(team == "neutral") {
        continue;
      }

      currenttime = gettime();

      if(currenttime < level.objectivereinforcements[key][team].var_8e55c5943a080a2e + var_68299821ad1626e0) {
        continue;
      }

      var_9cc5be111b6fa65c = [];

      foreach(agent in level.objectivereinforcements[key][team].agents) {
        if(agent.health > 0) {
          var_9cc5be111b6fa65c[var_9cc5be111b6fa65c.size] = agent;
        }
      }

      level.objectivereinforcements[key][team].agents = var_9cc5be111b6fa65c;
      currentcount = level.objectivereinforcements[key][team].agents.size;

      if(currentcount <= var_fde40312bd18ae9e) {
        level thread function_a30a48f0c1a403ec(key, team, desiredcount - currentcount, 0);
        level.objectivereinforcements[key][team].var_8e55c5943a080a2e = currenttime;
      }
    }
  }
}