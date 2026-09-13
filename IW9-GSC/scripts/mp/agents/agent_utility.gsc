/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_utility.gsc
***********************************************/

agentfunc(_id_4E90A313EA35F4B7) {
  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype][_id_4E90A313EA35F4B7]))
    return level.agent_funcs[self.unittype][_id_4E90A313EA35F4B7];

  return level.agent_funcs[self.agent_type][_id_4E90A313EA35F4B7];
}

set_agent_team(team, _id_123F05CF9530A069) {
  self.team = team;
  self.agentteam = team;
  self.pers["team"] = team;
  self.owner = _id_123F05CF9530A069;
  self setotherent(_id_123F05CF9530A069);
  self setentityowner(_id_123F05CF9530A069);
}

initagentscriptvariables() {
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
  self.ignoreall = istrue(level._id_BDB4D0CD41B1C39D);
  self.ignoreme = 0;
  self detachall();
  initplayerscriptvariables(0);
}

initplayerscriptvariables(_id_FD0B76EB4612B2A4) {
  if(!_id_FD0B76EB4612B2A4) {
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
    _id_3B64EB40368C1450::nuke("weapon");
    _id_3B64EB40368C1450::nuke("weapon_switch");
    _id_3B64EB40368C1450::nuke("offhand_weapons");
    _id_3B64EB40368C1450::nuke("usability");
    self.shieldbullethits = undefined;
    self.recentshieldxp = undefined;
  } else {
    self.movespeedscaler = 1;
    self.avoidkillstreakonspawntimer = 5;
    self.guid = scripts\mp\utility\player::getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;
    self.objectivescaler = 1;
    scripts\mp\gameobjects::init_player_gameobjects();
  }
}

getfreeagent(agent_type) {
  _id_7818398CDD97FE84 = undefined;

  if(isDefined(level.agentarray)) {
    _id_7818398CDD97FE84 = _func_76B285B4BAE7356C();

    if(isDefined(_id_7818398CDD97FE84)) {
      _id_7818398CDD97FE84 initagentscriptvariables();

      if(isDefined(agent_type))
        _id_7818398CDD97FE84.agent_type = agent_type;
    }
  }

  return _id_7818398CDD97FE84;
}

activateagent() {
  self.isactive = 1;
}

deactivateagent() {
  thread deactivateagentdelayed();
}

deactivateagentdelayed() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self))
    scripts\cp_mp\utility\game_utility::removefromparticipantsarray();

  scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  wait 0.05;
  self.isactive = 0;
  self.hasdied = 0;
  self.owner = undefined;
  self.connecttime = undefined;

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(isDefined(_id_7DC3241E7F3C6B24.attackers)) {
      foreach(index, attacker in _id_7DC3241E7F3C6B24.attackers) {
        if(attacker == self)
          _id_7DC3241E7F3C6B24.attackers[index] = undefined;
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  self notify("disconnect");
}

getnumactiveagents(type) {
  if(!isDefined(type))
    type = "all";

  agents = getactiveagentsoftype(type);
  return agents.size;
}

getactiveagentsoftype(type) {
  agents = [];

  if(!isDefined(level.agentarray))
    return agents;

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(type == "all" || agent.agent_type == type)
        agents[agents.size] = agent;
    }
  }

  return agents;
}

getnumownedactiveagents(player) {
  return getnumownedactiveagentsbytype(player, "all");
}

getnumownedactiveagentsbytype(player, type) {
  _id_B766E199310ED9AC = 0;

  if(!isDefined(level.agentarray))
    return _id_B766E199310ED9AC;

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(isDefined(agent.owner) && agent.owner == player) {
        if(type == "all" && agent.agent_type != "alien" || agent.agent_type == type)
          _id_B766E199310ED9AC++;
      }
    }
  }

  return _id_B766E199310ED9AC;
}

getnumownedagentsonteambytype(team, type) {
  _id_B766E199310ED9AC = 0;

  if(!isDefined(level.agentarray))
    return _id_B766E199310ED9AC;

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(isDefined(agent.team) && agent.team == team) {
        if(type == "all" && agent.agent_type != "alien" || agent.agent_type == type)
          _id_B766E199310ED9AC++;
      }
    }
  }

  return _id_B766E199310ED9AC;
}

getvalidspawnpathnodenearplayer(_id_17BB852304A6478E, _id_DD84CF0C92913CB9) {
  _id_5836C6D53A5F99A2 = getnodesinradius(self.origin, 350, 64, 128, "Path");

  if(!isDefined(_id_5836C6D53A5F99A2) || _id_5836C6D53A5F99A2.size == 0)
    return undefined;

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    _id_22A832C83EA6F75F = _id_5836C6D53A5F99A2;
    _id_5836C6D53A5F99A2 = [];

    foreach(node in _id_22A832C83EA6F75F) {
      if(node.origin[2] > level.waterdeletez || !ispointinvolume(node.origin, level.trigunderwater))
        _id_5836C6D53A5F99A2[_id_5836C6D53A5F99A2.size] = node;
    }
  }

  _id_83038D49C868DB4D = anglesToForward(self.angles);
  _id_445ACA8C2C95592E = -10;
  _id_41CDD7FC4A85331F = scripts\mp\spawnlogic::getplayertraceheight(self);
  zoffset = (0, 0, _id_41CDD7FC4A85331F);

  if(!isDefined(_id_17BB852304A6478E))
    _id_17BB852304A6478E = 0;

  if(!isDefined(_id_DD84CF0C92913CB9))
    _id_DD84CF0C92913CB9 = 0;

  _id_00154744DC373EF9 = [];
  _id_4236CF84C1C222B3 = [];

  foreach(_id_29376CACC64CC4E6 in _id_5836C6D53A5F99A2) {
    if(!_id_29376CACC64CC4E6 doesnodeallowstance("stand") || isDefined(_id_29376CACC64CC4E6.no_agent_spawn)) {
      continue;
    }
    _id_644AB9FDA129B92B = vectorNormalize(_id_29376CACC64CC4E6.origin - self.origin);
    dot = vectordot(_id_83038D49C868DB4D, _id_644AB9FDA129B92B);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4236CF84C1C222B3.size; _id_AC0E594AC96AA3A8++) {
      if(dot > _id_4236CF84C1C222B3[_id_AC0E594AC96AA3A8]) {
        for(_id_AC0E5C4AC96AAA41 = _id_4236CF84C1C222B3.size; _id_AC0E5C4AC96AAA41 > _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41--) {
          _id_4236CF84C1C222B3[_id_AC0E5C4AC96AAA41] = _id_4236CF84C1C222B3[_id_AC0E5C4AC96AAA41 - 1];
          _id_00154744DC373EF9[_id_AC0E5C4AC96AAA41] = _id_00154744DC373EF9[_id_AC0E5C4AC96AAA41 - 1];
        }

        break;
      }
    }

    _id_00154744DC373EF9[_id_AC0E594AC96AA3A8] = _id_29376CACC64CC4E6;
    _id_4236CF84C1C222B3[_id_AC0E594AC96AA3A8] = dot;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_00154744DC373EF9.size; _id_AC0E594AC96AA3A8++) {
    _id_29376CACC64CC4E6 = _id_00154744DC373EF9[_id_AC0E594AC96AA3A8];
    tracestart = self.origin + zoffset;
    _id_8B39E5984DA1FFAF = _id_29376CACC64CC4E6.origin + zoffset;

    if(_id_AC0E594AC96AA3A8 > 0)
      wait 0.05;

    if(!sighttracepassed(tracestart, _id_8B39E5984DA1FFAF, 0, self)) {
      continue;
    }
    if(_id_DD84CF0C92913CB9) {
      if(_id_AC0E594AC96AA3A8 > 0)
        wait 0.05;

      _id_2E3BC21C15E7AB6C = playerphysicstrace(_id_29376CACC64CC4E6.origin + zoffset, _id_29376CACC64CC4E6.origin);

      if(distancesquared(_id_2E3BC21C15E7AB6C, _id_29376CACC64CC4E6.origin) > 1)
        continue;
    }

    if(_id_17BB852304A6478E) {
      if(_id_AC0E594AC96AA3A8 > 0)
        wait 0.05;

      _id_2E3BC21C15E7AB6C = physicstrace(tracestart, _id_8B39E5984DA1FFAF);

      if(distancesquared(_id_2E3BC21C15E7AB6C, _id_8B39E5984DA1FFAF) > 1)
        continue;
    }

    return _id_29376CACC64CC4E6;
  }
}

_id_B071E509C0FB69B0() {
  if(self getstance() == "crouch")
    center = self.origin + (0, 0, 25);
  else if(self getstance() == "prone")
    center = self.origin + (0, 0, 24);
  else
    center = self.origin + (0, 0, 36);

  return center;
}

_id_2E1B23386B967C10() {
  if(self getstance() == "crouch")
    center = self.origin + (0, 0, 50);
  else if(self getstance() == "prone")
    center = self.origin + (0, 0, 48);
  else
    center = self.origin + (0, 0, 72);

  return center;
}

killagent(agent) {
  agent dodamage(agent.health + 500000, agent.origin);
}

_id_CB7D1454840BB597(_id_9E4E5A4030545A50) {
  if(self.birthtime >= gettime())
    waitframe();

  if(!istrue(_id_9E4E5A4030545A50))
    self.nocorpse = 1;

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self kill();
}

killdog() {
  self[[agentfunc("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}

_id_7956DFD1302CDDFF(unittype) {
  return isDefined(self.unittype) && self.unittype == unittype;
}

iscivilian(agent) {
  _id_D2664652FB0CB884 = agent.category;
  return isDefined(_id_D2664652FB0CB884) && _id_D2664652FB0CB884 == "civilian";
}

_id_86DF29145C484D9C(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type))
    return 0;

  return issubstr(agent.agent_type, "_merc");
}

_id_17B2ECDAE3A795F6(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type))
    return 0;

  return issubstr(agent.agent_type, "_ru");
}

_id_35CC816ACEEEB402(agent) {
  if(!isDefined(agent) || !isDefined(agent.agent_type))
    return 0;

  return issubstr(agent.agent_type, "tier3");
}