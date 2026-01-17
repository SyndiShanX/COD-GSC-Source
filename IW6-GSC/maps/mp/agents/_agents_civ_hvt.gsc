/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_civ_hvt.gsc
**********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\gametypes\_damage;
#include maps\mp\agents\_agent_utility;

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["civ_hvt"] = [];

  level.agent_funcs["civ_hvt"]["spawn"] = ::onSpawn;
  level.agent_funcs["civ_hvt"]["think"] = ::agentThink;
  level.agent_funcs["civ_hvt"]["on_killed"] = ::onAgentKilled;
  level.agent_funcs["civ_hvt"]["on_damaged"] = maps\mp\agents\_agents::on_agent_player_damaged;
  level.agent_funcs["civ_hvt"]["on_damaged_finished"] = maps\mp\agents\_agents::agent_damage_finished;
}

onspawn(optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty) {
  self.hvtIsFollowing = false;

  self maps\mp\agents\_agents::spawn_agent_player(optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty);

  self thread handlePlayerUse();
}

onAgentKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self.defendNode = undefined;
  self.hvtTrigger MakeUnusable();
  self.hvtTrigger = undefined;

  self.body = self CloneAgent(deathAnimDuration);
  thread delayStartRagdoll(self.body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath);

  if(isDefined(self.onKilledCallback)) {
    self[[self.onKilledCallback]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
  }

  self maps\mp\agents\_agent_utility::deactivateAgent();

  self.owner notify("hvt_killed");
}

agentThink() {
  self notify("agent_think");
  self endon("agent_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(true) {
    if(self.hvtIsFollowing) {
      self followThink();
    } else {
      self waitThink(150);
    }
  }
}

waitThink(radius) {
  self BotSetStance("none");
  self BotClearScriptGoal();
  self bot_disable_tactical_goals();

  defendNode = self.owner getValidSpawnPathNodeNearPlayer();

  self.cur_defend_node = undefined;
  self.bot_defending = true;
  self.bot_defending_center = defendNode.origin;
  self.bot_defending_radius = radius;
  self.cur_defend_stance = "crouch";
  self.bot_defending_type = "protect";

  result = "";
  while(result != "goal") {
    self.cur_defend_node = defendNode;

    self BotSetScriptGoalNode(self.cur_defend_node, "tactical");
    result = self waittill_any_return("goal", "bad_path");

    self.node_closest_to_defend_center = defendNode;

    self.cur_defend_node = undefined;
  }

  self childthread defense_watch_entrances_at_goal();

  self waittill("hvt_toggle");
}

followThink() {
  self BotClearScriptGoal();
  self bot_disable_tactical_goals();

  if(!self bot_is_guarding_player(self.owner)) {
    self bot_guard_player(self.owner, 250);
  }

  self waittill("hvt_toggle");
}

handlePlayerUse() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self.hvtTrigger)) {
    self.hvtTrigger = spawn("script_model", self.origin);
    self.hvtTrigger LinkTo(self);
  }

  self.hvtTrigger MakeUsable();
  foreach(player in level.players) {
    if(player != self.owner) {
      self.hvtTrigger DisablePlayerUse(player);
    } else {
      self.hvtTrigger EnablePlayerUse(player);
    }
  }

  self thread waitForPlayerConnect();

  while(true) {
    self setFollowerHintString();

    self.hvtTrigger waittill("trigger", player);

    assert(player == self.owner);

    self.hvtIsFollowing = !self.hvtIsFollowing;

    print("Is Following: " + self.hvtIsFollowing);

    self notify("hvt_toggle");
  }
}

setFollowerHintString() {
  hintString = &"MP_HVT_FOLLOW";
  if(self.hvtIsFollowing) {
    hintString = &"MP_HVT_WAIT";
  }
  self.hvtTrigger setHintString(hintString);
}

waitForPlayerConnect() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    level waittill("connected", player);

    self.hvtTrigger disablePlayerUse(player);
  }
}