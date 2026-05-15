/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agent_common.gsc
********************************************/

#include maps\mp\agents\_agent_utility;
#include common_scripts\utility;
#include maps\mp\_utility;

CodeCallback_AgentAdded() {
  self initAgentScriptVariables();

  agentTeam = "axis";

  if((level.numagents % 2) == 0) {
    agentTeam = "allies";
  }

  level.numagents++;
  self set_agent_team(agentTeam);

  level.agentArray[level.agentArray.size] = self;
}

CodeCallback_AgentDamaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  eAttacker = _validateAttacker(eAttacker);

  self[[self agentFunc("on_damaged")]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

CodeCallback_AgentKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  eAttacker = _validateAttacker(eAttacker);

  self thread[[self agentFunc("on_killed")]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

init() {
  initAgentLevelVariables();

  level thread add_agents_to_game();
}

connectNewAgent(agent_type, team, class) {
  agent = getFreeAgent(agent_type);

  if(isDefined(agent)) {
    agent.connectTime = GetTime();

    if(isDefined(team)) {
      agent set_agent_team(team);
    } else {
      agent set_agent_team(agent.team);
    }

    if(isDefined(class)) {
      agent.class_override = class;
    }

    if(isDefined(level.agent_funcs[agent_type]["onAIConnect"])) {
      agent[[agent agentFunc("onAIConnect")]]();
    }

    agent maps\mp\gametypes\_spawnlogic::addToCharactersArray();

    AssertEx(agent.connectTime == GetTime(), "Agent spawn took too long - there should be no waits in connectNewAgent");
  }

  return agent;
}

initAgentLevelVariables() {
  level.agentArray = [];
  level.numagents = 0;
}

add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", player);

  maxagents = GetMaxAgents();

  while(level.agentArray.size < maxagents) {
    agent = AddAgent();

    if(!isDefined(agent)) {
      waitframe();
      continue;
    }
  }
}

set_agent_health(health) {
  self.agenthealth = health;
  self.health = health;
  self.maxhealth = health;
}