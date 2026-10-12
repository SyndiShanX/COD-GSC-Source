/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_utility.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#namespace agent_utility;

function agentfunc(func_name) {
  assert(isagent(self));
  assert(isDefined(func_name));
  assert(isDefined(self.agent_type));
  assert(isDefined(level.agent_funcs[self.agent_type]));
  assert(isDefined(level.agent_funcs[self.agent_type][func_name]));

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype][func_name])) {
    return level.agent_funcs[self.unittype][func_name];
  }

  return level.agent_funcs[self.agent_type][func_name];
}

function set_agent_team(team, optional_owner) {
  self.team = team;
  self.agentteam = team;
  self.pers["team"] = team;
  self.owner = optional_owner;
  self setotherent(optional_owner);
  self setentityowner(optional_owner);
}

function initagentscriptvariables() {
  self.agent_type = "player";
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.wasti = 0;
  self.entity_number = self getentitynumber();
  self.agent_teamparticipant = 0;
  self.agent_gameparticipant = 0;
  self.agentname = undefined;
  self.ignoreall = istrue(level.var_bdb4d0cd41b1c39d);
  self.ignoreme = 0;
  self detachall();
  initplayerscriptvariables(0);
}

function initplayerscriptvariables(asplayer) {
  if(!asplayer) {
    self.class = undefined;
    self.lastclass = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.touchtriggers = undefined;
    self.carryobject = undefined;
    self.canpickupobject = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    self.lastspawntime = undefined;
    self.lastspawnpoint = undefined;
    val::nuke("weapon");
    val::nuke("weapon_switch");
    val::nuke("offhand_weapons");
    val::nuke("usability");
    self.shieldbullethits = undefined;
    self.recentshieldxp = undefined;
    return;
  }

  self.movespeedscaler = 1;
  self.avoidkillstreakonspawntimer = 5;
  self.guid = getuniqueid();
  self.name = self.guid;
  self.sessionteam = self.team;
  self.sessionstate = "playing";
  self.shieldbullethits = 0;
  self.recentshieldxp = 0;
  self.agent_gameparticipant = 1;
  self.objectivescaler = 1;
  scripts\mp\gameobjects::init_player_gameobjects();
}

function getfreeagent(agent_type) {
  freeagent = undefined;

  if(isDefined(level.agentarray)) {
    freeagent = function_76b285b4bae7356c();

    if(isDefined(freeagent)) {
      freeagent initagentscriptvariables();

      if(isDefined(agent_type)) {
        freeagent.agent_type = agent_type;
      }
    }
  }

  return freeagent;
}

function activateagent() {
  if(!self.isactive) {
    assertex(self.connecttime == gettime(), "<dev string:x1c>");
  }

  self.isactive = 1;
}

function deactivateagent() {
  thread deactivateagentdelayed();
}

function deactivateagentdelayed() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self)) {
    scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
  }

  scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  wait 0.05;
  self.isactive = 0;
  self.hasdied = 0;
  self.owner = undefined;
  self.connecttime = undefined;

  foreach(character in level.characters) {
    if(isDefined(character.attackers)) {
      foreach(index, attacker in character.attackers) {
        if(attacker == self) {
          character.attackers[index] = undefined;
        }
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  self notify("disconnect");
}

function getnumactiveagents(type) {
  if(!isDefined(type)) {
    type = "all";
  }

  agents = getactiveagentsoftype(type);
  return agents.size;
}

function getactiveagentsoftype(type) {
  assert(isDefined(type));
  agents = [];

  if(!isDefined(level.agentarray)) {
    return agents;
  }

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(type == "all" || agent.agent_type == type) {
        agents[agents.size] = agent;
      }
    }
  }

  return agents;
}

function getnumownedactiveagents(player) {
  return getnumownedactiveagentsbytype(player, "all");
}

function getnumownedactiveagentsbytype(player, type) {
  assert(isDefined(type));
  numownedactiveagents = 0;

  if(!isDefined(level.agentarray)) {
    return numownedactiveagents;
  }

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(isDefined(agent.owner) && agent.owner == player) {
        if(type == "all" && agent.agent_type != "alien" || agent.agent_type == type) {
          numownedactiveagents++;
        }
      }
    }
  }

  return numownedactiveagents;
}

function getnumownedagentsonteambytype(team, type) {
  assert(isDefined(team) && isDefined(type));
  numownedactiveagents = 0;

  if(!isDefined(level.agentarray)) {
    return numownedactiveagents;
  }

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(isDefined(agent.team) && agent.team == team) {
        if(type == "all" && agent.agent_type != "alien" || agent.agent_type == type) {
          numownedactiveagents++;
        }
      }
    }
  }

  return numownedactiveagents;
}

function getvalidspawnpathnodenearplayer(var_17bb852304a6478e, var_dd84cf0c92913cb9) {
  assert(isPlayer(self));
  nodearray = getnodesinradius(self.origin, 350, 64, 128, "Path");

  if(!isDefined(nodearray) || nodearray.size == 0) {
    return undefined;
  }

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    var_22a832c83ea6f75f = nodearray;
    nodearray = [];

    foreach(node in var_22a832c83ea6f75f) {
      if(node.origin[2] > level.waterdeletez || !ispointinvolume(node.origin, level.trigunderwater)) {
        nodearray[nodearray.size] = node;
      }
    }
  }

  playerdirection = anglesToForward(self.angles);
  bestdot = -10;
  playerheight = scripts\mp\spawnlogic::getplayertraceheight(self);
  zoffset = (0, 0, playerheight);

  if(!isDefined(var_17bb852304a6478e)) {
    var_17bb852304a6478e = 0;
  }

  if(!isDefined(var_dd84cf0c92913cb9)) {
    var_dd84cf0c92913cb9 = 0;
  }

  var_154744dc373ef9 = [];
  var_4236cf84c1c222b3 = [];

  foreach(pathnode in nodearray) {
    if(!pathnode doesnodeallowstance("stand") || isDefined(pathnode.no_agent_spawn)) {
      continue;
    }

    var_644ab9fda129b92b = vectorNormalize(pathnode.origin - self.origin);
    dot = vectordot(playerdirection, var_644ab9fda129b92b);

    for(i = 0; i < var_4236cf84c1c222b3.size; i++) {
      if(dot > var_4236cf84c1c222b3[i]) {
        for(j = var_4236cf84c1c222b3.size; j > i; j--) {
          var_4236cf84c1c222b3[j] = var_4236cf84c1c222b3[j - 1];
          var_154744dc373ef9[j] = var_154744dc373ef9[j - 1];
        }

        break;
      }
    }

    var_154744dc373ef9[i] = pathnode;
    var_4236cf84c1c222b3[i] = dot;
  }

  for(i = 0; i < var_154744dc373ef9.size; i++) {
    pathnode = var_154744dc373ef9[i];
    tracestart = self.origin + zoffset;
    traceend = pathnode.origin + zoffset;

    if(i > 0) {
      wait 0.05;
    }

    if(!sighttracepassed(tracestart, traceend, 0, self)) {
      continue;
    }

    if(var_dd84cf0c92913cb9) {
      if(i > 0) {
        wait 0.05;
      }

      hitpos = playerphysicstrace(pathnode.origin + zoffset, pathnode.origin);

      if(distancesquared(hitpos, pathnode.origin) > 1) {
        continue;
      }
    }

    if(var_17bb852304a6478e) {
      if(i > 0) {
        wait 0.05;
      }

      hitpos = physicstrace(tracestart, traceend);

      if(distancesquared(hitpos, traceend) > 1) {
        continue;
      }
    }

    return pathnode;
  }
}

function function_b071e509c0fb69b0() {
  if(self getstance() == "crouch") {
    center = self.origin + 0.5 * (0, 0, 50);
  } else if(self getstance() == "prone") {
    center = self.origin + 0.5 * (0, 0, 48);
  } else {
    center = self.origin + 0.5 * (0, 0, 72);
  }

  return center;
}

function function_2e1b23386b967c10() {
  if(self getstance() == "crouch") {
    center = self.origin + (0, 0, 50);
  } else if(self getstance() == "prone") {
    center = self.origin + (0, 0, 48);
  } else {
    center = self.origin + (0, 0, 72);
  }

  return center;
}

function killagent(agent) {
  agent dodamage(agent.health + 500000, agent.origin);
}

function killdog() {
  self[[agentfunc("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}

function isspecifiedunittype(unittype) {
  return isDefined(self.unittype) && self.unittype == unittype;
}

function iscivilian(agent) {
  var_d2664652fb0cb884 = agent.category;
  return isDefined(var_d2664652fb0cb884) && var_d2664652fb0cb884 == "civilian";
}

function function_86df29145c484d9c(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type)) {
    return 0;
  }

  return issubstr(agent.agent_type, "_merc");
}

function function_17b2ecdae3a795f6(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type)) {
    return 0;
  }

  return issubstr(agent.agent_type, "_ru");
}

function istier3(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type)) {
    return 0;
  }

  return issubstr(agent.agent_type, "tier3");
}