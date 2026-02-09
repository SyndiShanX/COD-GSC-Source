/*****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_agent_killstreak.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_GAME = 5;
CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER = 2;

init() {
  level.killStreakFuncs["agent"] = ::tryUseSquadmate;
  level.killStreakFuncs["recon_agent"] = ::tryUseReconSquadmate;
}

setup_callbacks() {
  level.agent_funcs["squadmate"] = level.agent_funcs["player"];

  level.agent_funcs["squadmate"]["think"] = ::squadmate_agent_think;
  level.agent_funcs["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
  level.agent_funcs["squadmate"]["on_damaged"] = maps\mp\agents\_agents::on_agent_player_damaged;
  level.agent_funcs["squadmate"]["gametype_update"] = ::no_gametype_update;
}

no_gametype_update() {
  return false;
}

tryUseSquadmate(lifeId, streakName) {
  return useSquadmate("agent");
}

tryUseReconSquadmate(lifeId, streakName) {
  return useSquadmate("reconAgent");
}

useSquadmate(killStreakType) {
  if(getNumActiveAgents("squadmate") >= CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_GAME) {
    self iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
    return false;
  }

  if(getNumOwnedActiveAgents(self) >= CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER) {
    self iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
    return false;
  }

  nearestPathNode = self getValidSpawnPathNodeNearPlayer(false, true);

  if(!isDefined(nearestPathNode)) {
    return false;
  }

  if(!isReallyAlive(self)) {
    return false;
  }

  spawnOrigin = nearestPathNode.origin;
  spawnAngles = VectorToAngles(self.origin - nearestPathNode.origin);

  agent = maps\mp\agents\_agents::add_humanoid_agent("squadmate", self.team, undefined, spawnOrigin, spawnAngles, self, false, false, "veteran");
  if(!isDefined(agent)) {
    self iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
    return false;
  }

  agent.killStreakType = killStreakType;

  if(agent.killStreakType == "reconAgent") {
    agent thread sendAgentWeaponNotify("iw6_riotshield_mp");
    agent thread finishReconAgentLoadout();
    agent thread maps\mp\gametypes\_class::giveAndApplyLoadout(self.pers["team"], "reconAgent", false);
    agent maps\mp\agents\_agent_common::set_agent_health(250);
    agent maps\mp\perks\_perkfunctions::setLightArmor();
  } else {
    agent maps\mp\perks\_perkfunctions::setLightArmor();
  }

  agent _setNameplateMaterial("player_name_bg_green_agent", "player_name_bg_red_agent");

  return true;
}

finishReconAgentLoadout() {
  selfendon("death");
  selfendon("disconnect");
  level endon("game_ended");

  self waittill("applyLoadout");

  self maps\mp\perks\_perkfunctions::setLightArmor();
  self givePerk("specialty_quickswap", false);
  self givePerk("specialty_regenfaster", false);
}

sendAgentWeaponNotify(weaponName) {
  selfendon("death");
  selfendon("disconnect");
  level endon("game_ended");

  self waittill("applyLoadout");

  if(!isDefined(weaponName)) {
    weaponName = "iw6_riotshield_mp";
  }

  self notify("weapon_change", weaponName);
}

squadmate_agent_think() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");

  level endon("game_ended");

  while(1) {
    self BotSetFlag("prefer_shield_out", true);

    handled_by_gametype = self[[self agentFunc("gametype_update")]]();
    if(!handled_by_gametype) {
      if(!self bot_is_guarding_player(self.owner)) {
        self bot_guard_player(self.owner, 350);
      }
    }

    wait(0.05);
  }
}

on_agent_squadmate_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self maps\mp\agents\_agents::on_humanoid_agent_killed_common(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration, false);

  if(isPlayer(eAttacker) && isDefined(self.owner) && eAttacker != self.owner) {
    self.owner leaderDialogOnPlayer("squad_killed");
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_squad_mate");
  }

  self maps\mp\agents\_agent_utility::deactivateAgent();
}