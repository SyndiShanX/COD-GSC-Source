/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agent_utility.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

agentFunc(func_name) {
  assert(IsAgent(self));
  assert(isDefined(func_name));
  assert(isDefined(self.agent_type));
  assert(isDefined(level.agent_funcs[self.agent_type]));
  assert(isDefined(level.agent_funcs[self.agent_type][func_name]));

  return level.agent_funcs[self.agent_type][func_name];
}

set_agent_team(team, optional_owner) {
  self.team = team;
  self.agentteam = team;
  self.pers["team"] = team;

  self.owner = optional_owner;
  self SetOtherEnt(optional_owner);
  self SetEntityOwner(optional_owner);
}

initAgentScriptVariables() {
  self.agent_type = "player";
  self.pers = [];
  self.hasDied = false;
  self.isActive = false;
  self.isAgent = true;
  self.wasTI = false;
  self.isSniper = false;
  self.spawnTime = 0;
  self.entity_number = self GetEntityNumber();
  self.agent_teamParticipant = false;
  self.agent_gameParticipant = false;
  self.canPerformClientTraces = false;
  self.agentname = undefined;

  self DetachAll();

  self initPlayerScriptVariables(false);
}

initPlayerScriptVariables(asPlayer) {
  if(!asPlayer) {
    self.class = undefined;
    self.lastClass = undefined;
    self.moveSpeedScaler = undefined;
    self.avoidKillstreakOnSpawnTimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.saved_actionSlotData = undefined;
    self.perks = undefined;
    self.weaponList = undefined;
    self.omaClassChanged = undefined;
    self.objectiveScaler = undefined;
    self.touchTriggers = undefined;
    self.carryObject = undefined;
    self.claimTrigger = undefined;
    self.canPickupObject = undefined;
    self.killedInUse = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    self.lastSpawnTime = undefined;
    self.lastspawnpoint = undefined;
    self.disabledWeapon = undefined;
    self.disabledWeaponSwitch = undefined;
    self.disabledOffhandWeapons = undefined;
    self.disabledUsability = undefined;
    self.shieldDamage = undefined;
    self.shieldBulletHits = undefined;
    self.recentShieldXP = undefined;
  } else {
    self.moveSpeedScaler = 1;
    self.avoidKillstreakOnSpawnTimer = 5;
    self.guid = self getUniqueId();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.shieldDamage = 0;
    self.shieldBulletHits = 0;
    self.recentShieldXP = 0;
    self.agent_gameParticipant = true;

    self maps\mp\gametypes\_playerlogic::setupSavedActionSlots();
    self thread maps\mp\perks\_perks::onPlayerSpawned();

    if(IsGameParticipant(self)) {
      self.objectiveScaler = 1;
      self maps\mp\gametypes\_gameobjects::init_player_gameobjects();
      self.disabledWeapon = 0;
      self.disabledWeaponSwitch = 0;
      self.disabledOffhandWeapons = 0;
    }
  }

  self.disabledUsability = 1;
}

getFreeAgent(agent_type) {
  freeAgent = undefined;

  if(isDefined(level.agentArray)) {
    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive) || !agent.isActive) {
        if(isDefined(agent.waitingToDeactivate) && agent.waitingToDeactivate) {
          continue;
        }
        freeAgent = agent;

        freeAgent initAgentScriptVariables();

        if(isDefined(agent_type)) {
          freeAgent.agent_type = agent_type;
        }

        break;
      }
    }
  }

  return freeAgent;
}

activateAgent() {
  if(!self.isActive) {
    AssertEx(self.connectTime == GetTime(), "Agent spawn took too long - there should be no waits in between connectNewAgent and spawning the agent");
  }

  self.isActive = true;
}

deactivateAgent() {
  self thread deactivateAgentDelayed();
}

deactivateAgentDelayed() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(IsGameParticipant(self)) {
    self maps\mp\gametypes\_spawnlogic::removeFromParticipantsArray();
  }

  self maps\mp\gametypes\_spawnlogic::removeFromCharactersArray();

  wait 0.05;

  self.isActive = false;
  self.hasDied = false;
  self.owner = undefined;
  self.connectTime = undefined;
  self.waitingToDeactivate = undefined;

  foreach(character in level.characters) {
    if(isDefined(character.attackers)) {
      foreach(index, attacker in character.attackers) {
        if(attacker == self) {
          character.attackers[index] = undefined;
        }
      }
    }
  }

  if(isDefined(self.headModel)) {
    self Detach(self.headModel);
    self.headModel = undefined;
  }

  self notify("disconnect");
}

getNumActiveAgents(type) {
  if(!isDefined(type)) {
    type = "all";
  }

  agents = getActiveAgentsOfType(type);
  return agents.size;
}

getActiveAgentsOfType(type) {
  Assert(isDefined(type));
  agents = [];

  if(!isDefined(level.agentArray)) {
    return agents;
  }

  foreach(agent in level.agentArray) {
    if(isDefined(agent.isActive) && agent.isActive) {
      if(type == "all" || agent.agent_type == type) {
        agents[agents.size] = agent;
      }
    }
  }

  return agents;
}

getNumOwnedActiveAgents(player) {
  return getNumOwnedActiveAgentsByType(player, "all");
}

getNumOwnedActiveAgentsByType(player, type) {
  Assert(isDefined(type));
  numOwnedActiveAgents = 0;

  if(!isDefined(level.agentArray)) {
    return numOwnedActiveAgents;
  }

  foreach(agent in level.agentArray) {
    if(isDefined(agent.isActive) && agent.isActive) {
      if(isDefined(agent.owner) && (agent.owner == player)) {
        if((type == "all" && agent.agent_type != "alien") || agent.agent_type == type) {
          numOwnedActiveAgents++;
        }
      }
    }
  }

  return numOwnedActiveAgents;
}

getValidSpawnPathNodeNearPlayer(bDoPhysicsTraceToPlayer, bDoPhysicsTraceToValidateNode) {
  assert(isPlayer(self));

  nodeArray = GetNodesInRadius(self.origin, 350, 64, 128, "Path");

  if(!isDefined(nodeArray) || (nodeArray.size == 0)) {
    return undefined;
  }

  if(isDefined(level.waterDeleteZ) && isDefined(level.trigUnderWater)) {
    nodeArrayOld = nodeArray;
    nodeArray = [];
    foreach(node in nodeArrayOld) {
      if(node.origin[2] > level.waterDeleteZ || !IsPointInVolume(node.origin, level.trigUnderWater)) {
        nodeArray[nodeArray.size] = node;
      }
    }
  }

  playerDirection = anglesToForward(self.angles);
  bestDot = -10;

  playerHeight = maps\mp\gametypes\_spawnlogic::getPlayerTraceHeight(self);
  zOffset = (0, 0, playerHeight);

  if(!isDefined(bDoPhysicsTraceToPlayer)) {
    bDoPhysicsTraceToPlayer = false;
  }

  if(!isDefined(bDoPhysicsTraceToValidateNode)) {
    bDoPhysicsTraceToValidateNode = false;
  }

  pathNodeSortedByDot = [];
  pathNodeDotValues = [];
  foreach(pathNode in nodeArray) {
    if(!pathNode DoesNodeAllowStance("stand") || isDefined(pathnode.no_agent_spawn)) {
      continue;
    }
    directionToNode = VectorNormalize(pathNode.origin - self.origin);
    dot = VectorDot(playerDirection, directionToNode);

    i = 0;
    for(; i < pathNodeDotValues.size; i++) {
      if(dot > pathNodeDotValues[i]) {
        for(j = pathNodeDotValues.size; j > i; j--) {
          pathNodeDotValues[j] = pathNodeDotValues[j - 1];
          pathNodeSortedByDot[j] = pathNodeSortedByDot[j - 1];
        }
        break;
      }
    }
    pathNodeSortedByDot[i] = pathNode;
    pathNodeDotValues[i] = dot;
  }

  for(i = 0; i < pathNodeSortedByDot.size; i++) {
    pathNode = pathNodeSortedByDot[i];

    traceStart = self.origin + zOffset;
    traceEnd = pathNode.origin + zOffset;

    if(i > 0) {
      wait(0.05);
    }

    if(!SightTracePassed(traceStart, traceEnd, false, self)) {
      continue;
    }

    if(bDoPhysicsTraceToValidateNode) {
      if(i > 0) {
        wait(0.05);
      }

      hitPos = PlayerPhysicsTrace(pathNode.origin + zOffset, pathNode.origin);
      if(DistanceSquared(hitPos, pathNode.origin) > 1) {
        continue;
      }
    }

    if(bDoPhysicsTraceToPlayer) {
      if(i > 0) {
        wait(0.05);
      }

      hitPos = PhysicsTrace(traceStart, traceEnd);
      if(DistanceSquared(hitPos, traceEnd) > 1) {
        continue;
      }
    }

    return pathNode;
  }

  if((pathNodeSortedByDot.size > 0) && isDefined(level.isHorde)) {
    return pathNodeSortedByDot[0];
  }
}

killAgent(agent) {
  agent DoDamage(agent.health + 500000, agent.origin);
}

killDog() {
  self[[self agentFunc("on_damaged")]](
    level,
    undefined,
    self.health + 1,
    0,
    "MOD_CRUSH",
    "none",
    (0, 0, 0),
    (0, 0, 0),
    "none",
    0
  );
}