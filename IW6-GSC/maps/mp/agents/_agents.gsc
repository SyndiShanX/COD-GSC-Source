/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\agents\_agent_utility;

main() {
  if(isDefined(level.createFX_enabled) && level.createFX_enabled) {
    return;
  }
  setup_callbacks();

  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;

  level thread monitor_scr_agent_players();

  level thread maps\mp\agents\_agent_common::init();
  level thread maps\mp\killstreaks\_agent_killstreak::init();
  level thread maps\mp\killstreaks\_dog_killstreak::init();
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.agent_funcs["player"] = [];

  level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
  level.agent_funcs["player"]["think"] = maps\mp\bots\_bots_gametype_war::bot_war_think;
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
  level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;

  maps\mp\killstreaks\_agent_killstreak::setup_callbacks();
  maps\mp\killstreaks\_dog_killstreak::setup_callbacks();
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs)) {
    wait(0.05);
  }
}

new_scr_agent_team() {
  teamCounts = [];
  teamCounts["allies"] = 0;
  teamCounts["axis"] = 0;
  minTeam = undefined;
  foreach(player in level.participants) {
    if(!isDefined(teamCounts[player.team])) {
      teamCounts[player.team] = 0;
    }
    if(IsTeamParticipant(player)) {
      teamCounts[player.team]++;
    }
  }
  foreach(team, count in teamCounts) {
    if((team != "spectator") && (!isDefined(minTeam) || teamCounts[minTeam] > count)) {
      minTeam = team;
    }
  }

  return minTeam;
}

monitor_scr_agent_players() {
  SetDevDvarIfUninitialized("scr_agent_players_add", "0");
  SetDevDvarIfUninitialized("scr_agent_players_drop", "0");

  while(level.players.size == 0) {
    wait(0.05);
  }

  for(;;) {
    wait(0.1);

    add_agent_players = getdvarInt("scr_agent_players_add");
    drop_agent_players = getdvarInt("scr_agent_players_drop");

    if(add_agent_players != 0) {
      SetDevDvar("scr_agent_players_add", 0);
    }

    if(drop_agent_players != 0) {
      SetDevDvar("scr_agent_players_drop", 0);
    }

    for(i = 0; i < add_agent_players; i++) {
      agent = add_humanoid_agent("player", new_scr_agent_team(), undefined, undefined, undefined, undefined, true, true);
      if(isDefined(agent)) {
        agent.agent_teamParticipant = true;
      }
    }

    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive)) {
        continue;
      }
      if(isDefined(agent.isActive) && agent.isActive && agent.agent_type == "player") {
        if(drop_agent_players > 0) {
          agent maps\mp\agents\_agent_utility::deactivateAgent();
          agent Suicide();
          drop_agent_players--;
        }
      }
    }
  }
}

add_humanoid_agent(agent_type, team, class, optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty) {
  agent = maps\mp\agents\_agent_common::connectNewAgent(agent_type, team, class);

  if(isDefined(agent)) {
    agent thread[[agent agentFunc("spawn")]](optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty);
  }

  return agent;
}

spawn_agent_player(optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty) {
  self endon("disconnect");

  while(!isDefined(level.getSpawnPoint)) {
    waitframe();
  }

  if(self.hasDied) {
    wait(RandomIntRange(6, 10));
  }

  self initPlayerScriptVariables(true);

  if(isDefined(optional_spawnOrigin) && isDefined(optional_spawnAngles)) {
    spawnOrigin = optional_spawnOrigin;
    spawnAngles = optional_spawnAngles;

    self.lastSpawnPoint = spawnStruct();
    self.lastSpawnPoint.origin = spawnOrigin;
    self.lastSpawnPoint.angles = spawnAngles;
  } else {
    spawnPoint = self[[level.getSpawnPoint]]();
    spawnOrigin = spawnpoint.origin;
    spawnAngles = spawnpoint.angles;

    self.lastSpawnPoint = spawnpoint;
  }
  self activateAgent();
  self.lastSpawnTime = GetTime();
  self.spawnTime = GetTime();

  phys_trace_start = spawnOrigin + (0, 0, 25);
  phys_trace_end = spawnOrigin;
  newSpawnOrigin = PlayerPhysicsTrace(phys_trace_start, phys_trace_end);
  if(DistanceSquared(newSpawnOrigin, phys_trace_start) > 1) {
    spawnOrigin = newSpawnOrigin;
  }

  self SpawnAgent(spawnOrigin, spawnAngles);

  if(isDefined(use_randomized_personality) && use_randomized_personality) {
    self maps\mp\bots\_bots::bot_set_personality_from_dev_dvar();

    self maps\mp\bots\_bots_personality::bot_assign_personality_functions();
  } else {
    self maps\mp\bots\_bots_util::bot_set_personality("default");
  }

  if(isDefined(difficulty)) {
    self maps\mp\bots\_bots_util::bot_set_difficulty(difficulty);
  }

  self initPlayerClass();

  self maps\mp\agents\_agent_common::set_agent_health(100);
  if(isDefined(respawn_on_death) && respawn_on_death) {
    self.respawn_on_death = true;
  }

  if(isDefined(optional_owner)) {
    self set_agent_team(optional_owner.team, optional_owner);
  }

  if(isDefined(self.owner)) {
    self thread destroyOnOwnerDisconnect(self.owner);
  }

  self thread maps\mp\_flashgrenades::monitorFlash();

  self EnableAnimState(false);

  self[[level.onSpawnPlayer]]();
  self maps\mp\gametypes\_class::giveLoadout(self.team, self.class, true);

  self thread maps\mp\bots\_bots::bot_think_watch_enemy(true);
  self thread maps\mp\bots\_bots::bot_think_crate();
  if(self.agent_type == "player") {
    self thread maps\mp\bots\_bots::bot_think_level_actions();
  } else if(self.agent_type == "odin_juggernaut") {
    self thread maps\mp\bots\_bots::bot_think_level_actions(128);
  }
  self thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[self agentFunc("think")]]();

  if(!self.hasDied) {
    self maps\mp\gametypes\_spawnlogic::addToParticipantsArray();
  }

  self.hasDied = false;

  self thread maps\mp\gametypes\_weapons::onPlayerSpawned();
  self thread maps\mp\gametypes\_healthoverlay::playerHealthRegen();
  self thread maps\mp\gametypes\_battlechatter_mp::onPlayerSpawned();

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

destroyOnOwnerDisconnect(owner) {
  self endon("death");

  owner waittill("killstreak_disowned");

  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone()) {
    wait 0.05;
  }

  self Suicide();
}

agent_damage_finished(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(isDefined(eInflictor) || isDefined(eAttacker)) {
    if(!isDefined(eInflictor)) {
      eInflictor = eAttacker;
    }

    if(isDefined(self.allowVehicleDamage) && !self.allowVehicleDamage) {
      if(isDefined(eInflictor.classname) && eInflictor.classname == "script_vehicle") {
        return false;
      }
    }

    if(isDefined(eInflictor.classname) && eInflictor.classname == "auto_turret") {
      eAttacker = eInflictor;
    }

    if(isDefined(eAttacker) && sMeansOfDeath != "MOD_FALLING" && sMeansOfDeath != "MOD_SUICIDE") {
      if(level.teamBased) {
        if(isDefined(eAttacker.team) && eAttacker.team != self.team) {
          self SetAgentAttacker(eAttacker);
        }
      } else {
        self SetAgentAttacker(eAttacker);
      }
    }
  }

  Assert(isDefined(self.isActive) && self.isActive);
  self FinishAgentDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, 0.0);
  if(!isDefined(self.isActive)) {
    self.waitingToDeactivate = true;
  }
  return true;
}

on_agent_generic_damaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  attckerIsOwner = isDefined(eAttacker) && isDefined(self.owner) && (self.owner == eAttacker);
  attackerIsTeammate = attackerIsHittingTeam(self.owner, eAttacker) || attckerIsOwner;

  if(level.teambased && attackerIsTeammate && !level.friendlyfire) {
    return false;
  }

  if(!level.teambased && attckerIsOwner) {
    return false;
  }

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_CRUSH" && isDefined(eInflictor) && isDefined(eInflictor.classname) && eInflictor.classname == "script_vehicle") {
    return false;
  }

  if(!isDefined(self) || !isReallyAlive(self)) {
    return false;
  }

  if(isDefined(eAttacker) && eAttacker.classname == "script_origin" && isDefined(eAttacker.type) && eAttacker.type == "soft_landing") {
    return false;
  }

  if(sWeapon == "killstreak_emp_mp") {
    return false;
  }

  if(sWeapon == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::mineDamageHeightPassed(eInflictor, self)) {
    return false;
  }

  if((sWeapon == "throwingknife_mp" || sWeapon == "throwingknifejugg_mp") && sMeansOfDeath == "MOD_IMPACT") {
    iDamage = self.health + 1;
  }

  if(isDefined(eInflictor) && isDefined(eInflictor.stuckEnemyEntity) && eInflictor.stuckEnemyEntity == self) {
    iDamage = self.health + 1;
  }

  if(iDamage <= 0) {
    return false;
  }

  if(isDefined(eAttacker) && eAttacker != self && iDamage > 0 && (!isDefined(sHitLoc) || sHitLoc != "shield")) {
    if(iDFlags &level.iDFLAGS_STUN) {
      typeHit = "stun";
    } else if(!shouldWeaponFeedback(sWeapon)) {
      typeHit = "none";
    } else {
      typeHit = ter_op(iDamage >= self.health, "hitkill", "standard");
    }

    eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(typeHit);
  }

  if(isDefined(level.modifyPlayerDamage)) {
    iDamage = [[level.modifyPlayerDamage]](self, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
  }

  return self[[self agentFunc("on_damaged_finished")]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

on_agent_player_damaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  attckerIsOwner = isDefined(eAttacker) && isDefined(self.owner) && (self.owner == eAttacker);

  if(!level.teambased && attckerIsOwner) {
    return false;
  }

  Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

on_agent_player_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self on_humanoid_agent_killed_common(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration, true);

  if(isPlayer(eAttacker) && (!isDefined(self.owner) || eAttacker != self.owner)) {
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_squad_mate");
  }

  self maps\mp\gametypes\_weapons::dropScavengerForDeath(eAttacker);

  if(self.isActive) {
    self.hasDied = true;

    if(getGametypeNumLives() != 1 && (isDefined(self.respawn_on_death) && self.respawn_on_death)) {
      self thread[[self agentFunc("spawn")]]();
    } else {
      self deactivateAgent();
    }
  }
}

on_humanoid_agent_killed_common(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration, dropWeapons) {
  if(self.hasRiotShieldEquipped) {
    self LaunchShield(iDamage, sMeansofDeath);

    if(!dropWeapons) {
      item = self dropItem(self GetCurrentWeapon());

      if(isDefined(item)) {
        item thread maps\mp\gametypes\_weapons::deletePickupAfterAWhile();
        item.owner = self;
        item.ownersattacker = eAttacker;
        item MakeUnusable();
      }
    }
  }

  if(dropWeapons) {
    self[[level.weaponDropFunction]](eAttacker, sMeansOfDeath);
  }

  self.body = self CloneAgent(deathAnimDuration);
  thread delayStartRagdoll(self.body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath);

  self riotShield_clear();
}

initPlayerClass() {
  if(isDefined(self.class_override)) {
    self.class = self.class_override;
  } else {
    if(self maps\mp\bots\_bots_loadout::bot_setup_loadout_callback()) {
      self.class = "callback";
    } else {
      self.class = "class1";
    }
  }
}