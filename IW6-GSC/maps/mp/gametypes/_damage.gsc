/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_damage.gsc
*****************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\perks\_perkfunctions;

NUM_KILLS_GIVE_NUKE = 25;

isSwitchingTeams() {
  if(isDefined(self.switching_teams))
    return true;

  return false;
}

isTeamSwitchBalanced() {
  playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
  playerCounts[self.leaving_team]--;
  playerCounts[self.joining_team]++;

  return ((playerCounts[self.joining_team] - playerCounts[self.leaving_team]) < 2);
}

isFriendlyFire(victim, attacker) {
  if(!level.teamBased)
    return false;

  if(!isDefined(attacker))
    return false;

  if(!IsPlayer(attacker) && !isDefined(attacker.team))
    return false;

  if(victim.team != attacker.team)
    return false;

  if(victim == attacker)
    return false;

  return true;
}

killedSelf(attacker) {
  if(!IsPlayer(attacker))
    return false;

  if(attacker != self)
    return false;

  return true;
}

handleTeamChangeDeath() {
  if(!level.teamBased) {
    return;
  }
  assert(self.leaving_team != self.joining_team);

  if(self.joining_team == "spectator" || !isTeamSwitchBalanced()) {
    self thread[[level.onXPEvent]]("suicide");
    self incPersStat("suicides", 1);
    self.suicides = self getPersStat("suicides");
  }

  if(isDefined(level.onTeamChangeDeath))
    [[level.onTeamChangeDeath]](self);
}

handleWorldDeath(attacker, lifeId, sMeansOfDeath, sHitLoc) {
  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(attacker.team)) {
    handleSuicideDeath(sMeansOfDeath, sHitLoc);
    return;
  }

  assert(attacker.team == "axis" || attacker.team == "allies");

  if((level.teamBased && attacker.team != self.team) || !level.teamBased) {
    if(isDefined(level.onNormalDeath) && (IsPlayer(attacker) || IsAgent(attacker)) && attacker.team != "spectator")
      [[level.onNormalDeath]](self, attacker, lifeId);
  }
}

handleSuicideDeath(sMeansOfDeath, sHitLoc) {
  self thread[[level.onXPEvent]]("suicide");
  self incPersStat("suicides", 1);
  self.suicides = self getPersStat("suicides");

  if(!matchMakingGame())
    self incPlayerStat("suicides", 1);

  scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "suicidepointloss");
  maps\mp\gametypes\_gamescore::_setPlayerScore(self, maps\mp\gametypes\_gamescore::_getPlayerScore(self) - scoreSub);

  if(sMeansOfDeath == "MOD_SUICIDE" && sHitLoc == "none" && isDefined(self.throwingGrenade))
    self.lastGrenadeSuicideTime = gettime();

  if(isDefined(level.onSuicideDeath))
    [[level.onSuicideDeath]](self);

  if(isDefined(self.friendlydamage))
    self iPrintLnBold(&"MP_FRIENDLY_FIRE_WILL_NOT");
}

handleFriendlyFireDeath(attacker) {
  attacker thread[[level.onXPEvent]]("teamkill");
  attacker.pers["teamkills"] += 1.0;

  attacker.teamkillsThisRound++;

  if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillpointloss")) {
    scoreSub = maps\mp\gametypes\_rank::getScoreInfoValue("kill");
    maps\mp\gametypes\_gamescore::_setPlayerScore(attacker, maps\mp\gametypes\_gamescore::_getPlayerScore(attacker) - scoreSub);
  }

  if(level.maxAllowedTeamkills < 0) {
    return;
  }
  if(level.inGracePeriod) {
    teamKillDelay = 1;
    attacker.pers["teamkills"] += level.maxAllowedTeamkills;
  } else if(attacker.pers["teamkills"] > 1 && getTimePassed() < ((level.gracePeriod * 1000) + 8000 + (attacker.pers["teamkills"] * 1000))) {
    teamKillDelay = 1;
    attacker.pers["teamkills"] += level.maxAllowedTeamkills;
  } else {
    teamKillDelay = attacker maps\mp\gametypes\_playerlogic::TeamKillDelay();
  }

  if(teamKillDelay > 0) {
    attacker.pers["teamKillPunish"] = true;
    attacker _suicide();
  }
}

handleNormalDeath(lifeId, attacker, eInflictor, sWeapon, sMeansOfDeath) {
  attacker thread maps\mp\_events::killedPlayer(lifeId, self, sWeapon, sMeansOfDeath);

  if(sMeansOfDeath == "MOD_HEAD_SHOT") {
    attacker incPersStat("headshots", 1);
    attacker.headshots = attacker getPersStat("headshots");
    attacker incPlayerStat("headshots", 1);

    if(isDefined(attacker.lastStand))
      value = maps\mp\gametypes\_rank::getScoreInfoValue("kill") * 2;
    else
      value = undefined;

    attacker PlayLocalSound("bullet_impact_headshot_plr");
    self playSound("bullet_impact_headshot");
  } else {
    if(isDefined(attacker.lastStand))
      value = maps\mp\gametypes\_rank::getScoreInfoValue("kill") * 2;
    else
      value = undefined;
  }

  killCreditTo = attacker;
  if(isDefined(attacker.commanding_bot)) {
    killCreditTo = attacker.commanding_bot;
  }

  dontStoreKillsValue = false;
  if(IsSquadsMode())
    dontStoreKillsValue = true;

  killCreditTo incPersStat("kills", 1, dontStoreKillsValue);
  killCreditTo.kills = killCreditTo getPersStat("kills");
  killCreditTo updatePersRatio("kdRatio", "kills", "deaths");
  killCreditTo maps\mp\gametypes\_persistence::statSetChild("round", "kills", killCreditTo.kills);
  killCreditTo incPlayerStat("kills", 1);

  if(isFlankKill(self, attacker)) {
    killCreditTo incPlayerStat("flankkills", 1);

    self incPlayerStat("flankdeaths", 1);
  }

  lastKillStreak = attacker.pers["cur_kill_streak"];

  if(isAlive(attacker) || attacker.streakType == "support") {
    if((sMeansOfDeath == "MOD_MELEE" && !attacker isJuggernaut()) || attacker killShouldAddToKillstreak(sWeapon)) {
      attacker registerKill(sWeapon, true);
    }

    attacker setPlayerStatIfGreater("killstreak", attacker.pers["cur_kill_streak"]);

    if(attacker.pers["cur_kill_streak"] > attacker getPersStat("longestStreak"))
      attacker setPersStat("longestStreak", attacker.pers["cur_kill_streak"]);
  }

  attacker.pers["cur_death_streak"] = 0;

  attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", value, sWeapon, sMeansOfDeath, undefined, self);

  if(attacker.pers["cur_kill_streak"] > attacker maps\mp\gametypes\_persistence::statGetChild("round", "killStreak")) {
    attacker maps\mp\gametypes\_persistence::statSetChild("round", "killStreak", attacker.pers["cur_kill_streak"]);
  }

  if(attacker rankingEnabled()) {
    if(attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
      if(!IsSquadsMode()) {
        attacker maps\mp\gametypes\_persistence::statSet("killStreak", attacker.pers["cur_kill_streak"]);
      }
      attacker.kill_streak = attacker.pers["cur_kill_streak"];
    }
  }

  maps\mp\gametypes\_gamescore::givePlayerScore("kill", attacker, self);

  scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "deathpointloss");
  maps\mp\gametypes\_gamescore::_setPlayerScore(self, maps\mp\gametypes\_gamescore::_getPlayerScore(self) - scoreSub);

  if(isDefined(level.ac130player) && level.ac130player == attacker)
    level notify("ai_killed", self);

  if(isDefined(attacker.odin))
    level notify("odin_killed_player", self);

  level notify("player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker);
  attacker notify("got_killstreak", attacker.pers["cur_kill_streak"]);

  attacker notify("killed_enemy", self, sWeapon, sMeansOfDeath);

  if(isDefined(self.motionSensorMarkedBy)) {
    if(self.motionSensorMarkedBy != attacker)
      self.motionSensorMarkedBy thread maps\mp\gametypes\_weapons::motionSensor_processTaggedAssist(self);
    self.motionSensorMarkedBy = undefined;
  }

  if(isDefined(level.onNormalDeath) && attacker.pers["team"] != "spectator")
    [[level.onNormalDeath]](self, attacker, lifeId);

  if(!level.teamBased) {
    self.attackers = [];
    return;
  }

  level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed(attacker, "kill", 0.75);

  if(isDefined(self.lastAttackedShieldPlayer) && isDefined(self.lastAttackedShieldTime) && self.lastAttackedShieldPlayer != attacker) {
    if(getTime() - self.lastAttackedShieldTime < 2500) {
      self.lastAttackedShieldPlayer thread maps\mp\gametypes\_gamescore::processShieldAssist(self);

      if(self.lastAttackedShieldPlayer _hasPerk("specialty_assists")) {
        self.lastAttackedShieldPlayer.pers["assistsToKill"]++;

        if(!(self.lastAttackedShieldPlayer.pers["assistsToKill"] % 2)) {
          self.lastAttackedShieldPlayer maps\mp\gametypes\_missions::processChallenge("ch_hardlineassists");
          self.lastAttackedShieldPlayer maps\mp\killstreaks\_killstreaks::giveAdrenaline("kill");
          self.lastAttackedShieldPlayer.pers["cur_kill_streak"]++;
        }
      } else {
        self.lastAttackedShieldPlayer.pers["assistsToKill"] = 0;
      }
    } else if(isAlive(self.lastAttackedShieldPlayer) && getTime() - self.lastAttackedShieldTime < 5000) {
      forwardVec = vectorNormalize(anglesToForward(self.angles));
      shieldVec = vectorNormalize(self.lastAttackedShieldPlayer.origin - self.origin);

      if(vectorDot(shieldVec, forwardVec) > 0.925) {
        self.lastAttackedShieldPlayer thread maps\mp\gametypes\_gamescore::processShieldAssist(self);

        if(self.lastAttackedShieldPlayer _hasPerk("specialty_assists")) {
          self.lastAttackedShieldPlayer.pers["assistsToKill"]++;

          if(!(self.lastAttackedShieldPlayer.pers["assistsToKill"] % 2)) {
            self.lastAttackedShieldPlayer maps\mp\gametypes\_missions::processChallenge("ch_hardlineassists");
            self.lastAttackedShieldPlayer maps\mp\killstreaks\_killstreaks::giveAdrenaline("kill");
            self.lastAttackedShieldPlayer.pers["cur_kill_streak"]++;
          }
        } else {
          self.lastAttackedShieldPlayer.pers["assistsToKill"] = 0;
        }
      }
    }
  }

  if(isDefined(self.attackers)) {
    foreach(player in self.attackers) {
      if(!isDefined(_validateAttacker(player))) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      if(self == player) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      player thread maps\mp\gametypes\_gamescore::processAssist(self);

      if(player _hasPerk("specialty_assists")) {
        player.pers["assistsToKill"]++;

        if(!(player.pers["assistsToKill"] % 2)) {
          player maps\mp\gametypes\_missions::processChallenge("ch_hardlineassists");
          player registerKill(sWeapon, false);
        }
      } else {
        player.pers["assistsToKill"] = 0;
      }
    }

    self.attackers = [];
  }
}

IsPlayerWeapon(weaponName) {
  if(weaponClass(weaponName) == "non-player")
    return false;

  if(weaponClass(weaponName) == "turret")
    return false;

  if(weaponInventoryType(weaponName) == "primary" || weaponInventoryType(weaponName) == "altmode")
    return true;

  return false;
}

waitSkipKillcamButtonDuringDeathTimer() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");

  self NotifyOnPlayerCommand("death_respawn", "+usereload");
  self NotifyOnPlayerCommand("death_respawn", "+activate");

  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

waitSkipKillCamDuringDeathTimer(waitTime) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");

  wait(waitTime);
  self notify("killcam_death_done_waiting");
}

skipKillcamDuringDeathTimer(waitTime) {
  self endon("disconnect");

  if(level.showingFinalKillcam)
    return false;

  if(!IsAI(self)) {
    self thread waitSkipKillcamButtonDuringDeathTimer();
    self thread waitSkipKillCamDuringDeathTimer(waitTime);

    result = waittill_any_return("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(result == "killcam_death_done_waiting")
      return false;
    else
      return true;
  }

  return false;
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  PlayerKilled_internal(eInflictor, attacker, self, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, false);
}

QueueShieldForRemoval(shield) {
  MY_MAX_SHIELDS_AT_A_TIME = 5;

  if(!isDefined(level.shieldTrashArray))
    level.shieldTrashArray = [];

  if(level.shieldTrashArray.size >= MY_MAX_SHIELDS_AT_A_TIME) {
    idxMax = (level.shieldTrashArray.size - 1);
    level.shieldTrashArray[0] delete();
    for(idx = 0; idx < idxMax; idx++)
      level.shieldTrashArray[idx] = level.shieldTrashArray[idx + 1];
    level.shieldTrashArray[idxMax] = undefined;
  }

  level.shieldTrashArray[level.shieldTrashArray.size] = shield;
}

LaunchShield(damage, meansOfDeath) {
  if(isDefined(self.hasRiotShieldEquipped) && self.hasRiotShieldEquipped) {
    if(isDefined(self.riotShieldModel)) {
      self riotShield_detach(true);
    } else if(isDefined(self.riotShieldModelStowed)) {
      self riotShield_detach(false);
    }
  }
}

PlayerKilled_internal(eInflictor, attacker, victim, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, isFauxDeath) {
  prof_begin(" PlayerKilled_1");

  victim endon("spawned");
  victim notify("killed_player");

  victim maps\mp\gametypes\_playerlogic::resetUIDvarsOnDeath();

  victim.abilityChosen = false;
  victim.perkOutlined = false;

  if(gameHasNeutralCrateOwner(level.gameType)) {
    if(victim != attacker && sMeansOfDeath == "MOD_CRUSH") {
      eInflictor = victim;
      attacker = victim;
      sMeansofDeath = "MOD_SUICIDE";
      sWeapon = "none";
      sHitLoc = "none";
      victim.attackers = [];
    }
  }

  assert(victim.sessionteam != "spectator");

  attacker = _validateAttacker(attacker);

  if(isDefined(attacker))
    attacker.assistedSuicide = undefined;

  if(!isDefined(victim.idFlags)) {
    if(sMeansOfDeath == "MOD_SUICIDE")
      victim.idFlags = 0;
    else if(sMeansOfDeath == "MOD_GRENADE")
      if((IsSubStr(sWeapon, "frag_grenade") || IsSubStr(sWeapon, "thermobaric_grenade") || IsSubStr(sWeapon, "mortar_shell")) && iDamage == 100000)
        victim.idFlags = 0;
      else if(sWeapon == "nuke_mp")
      victim.idFlags = 0;
    else if(level.friendlyfire >= 2)
      victim.idFlags = 0;
    else
      assertEx(0, "Victims ID flags not set, sMeansOfDeath == " + sMeansOfDeath);
  }

  if(isDefined(victim.hasRiotShieldEquipped) && victim.hasRiotShieldEquipped)
    victim LaunchShield(iDamage, sMeansofDeath);

  victim riotShield_clear();

  maps\mp\gametypes\_weapons::recordToggleScopeStates();

  if(!isFauxDeath) {
    if(isDefined(victim.endGame)) {
      self restoreBaseVisionSet(2);
    } else {
      self restoreBaseVisionSet(0);
      victim ThermalVisionOff();
    }
  } else {
    victim.fauxDead = true;
    self notify("death");
  }

  if(game["state"] == "postgame") {
    prof_end("PlayerKilled");
    return;
  }

  maps\mp\perks\_perks::updateActivePerks(eInflictor, attacker, victim, iDamage, sMeansOfDeath);

  deathTimeOffset = 0;

  if(!IsPlayer(eInflictor) && isDefined(eInflictor.primaryWeapon)) {
    sPrimaryWeapon = eInflictor.primaryWeapon;
  } else if(isDefined(attacker) && IsPlayer(attacker) && attacker getCurrentPrimaryWeapon() != "none") {
    sPrimaryWeapon = attacker getCurrentPrimaryWeapon();
  } else {
    if(isSubStr(sWeapon, "alt_")) {
      sPrimaryWeapon = GetSubStr(sWeapon, 4, sWeapon.size);
    } else {
      sPrimaryWeapon = undefined;
    }
  }

  if(isDefined(victim.useLastStandParams) || (isDefined(victim.lastStandParams) && sMeansOfDeath == "MOD_SUICIDE")) {
    victim ensureLastStandParamsValidity();
    victim.useLastStandParams = undefined;

    assert(isDefined(victim.lastStandParams));

    eInflictor = victim.lastStandParams.eInflictor;
    attacker = victim.lastStandParams.attacker;
    iDamage = victim.lastStandParams.iDamage;
    sMeansOfDeath = victim.lastStandParams.sMeansOfDeath;
    sWeapon = victim.lastStandParams.sWeapon;
    sPrimaryWeapon = victim.lastStandParams.sPrimaryWeapon;
    vDir = victim.lastStandParams.vDir;
    sHitLoc = victim.lastStandParams.sHitLoc;

    deathTimeOffset = (gettime() - victim.lastStandParams.lastStandStartTime) / 1000;
    victim.lastStandParams = undefined;

    attacker = _validateAttacker(attacker);
  }

  prof_end(" PlayerKilled_1");
  prof_begin(" PlayerKilled_2");

  if((!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == victim) && isDefined(self.attackers)) {
    bestPlayer = undefined;

    foreach(player in self.attackers) {
      if(!isDefined(_validateAttacker(player))) {
        continue;
      }
      if(!isDefined(victim.attackerData[player.guid].damage)) {
        continue;
      }
      if(player == victim || (level.teamBased && player.team == victim.team)) {
        continue;
      }
      if(victim.attackerData[player.guid].lasttimedamaged + 2500 < getTime() && (attacker != victim && (isDefined(victim.lastStand) && victim.lastStand))) {
        continue;
      }
      if(victim.attackerData[player.guid].damage > 1 && !isDefined(bestPlayer))
        bestPlayer = player;
      else if(isDefined(bestPlayer) && victim.attackerData[player.guid].damage > victim.attackerData[bestPlayer.guid].damage)
        bestPlayer = player;
    }

    if(isDefined(bestPlayer)) {
      attacker = bestPlayer;
      attacker.assistedSuicide = true;
      sWeapon = victim.attackerData[bestPlayer.guid].weapon;
      vDir = victim.attackerData[bestPlayer.guid].vDir;
      sHitLoc = victim.attackerData[bestPlayer.guid].sHitLoc;
      psOffsetTime = victim.attackerData[bestPlayer.guid].psOffsetTime;
      sMeansOfDeath = victim.attackerData[bestPlayer.guid].sMeansOfDeath;
      iDamage = victim.attackerData[bestPlayer.guid].damage;
      sPrimaryWeapon = victim.attackerData[bestPlayer.guid].sPrimaryWeapon;
      eInflictor = attacker;
    }
  } else {
    if(isDefined(attacker))
      attacker.assistedSuicide = undefined;
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, attacker))
    sMeansOfDeath = "MOD_HEAD_SHOT";
  else if(!isDefined(victim.nuked)) {
    if(isDefined(level.custom_death_sound))
      [[level.custom_death_sound]](victim, sMeansOfDeath, eInflictor);
    else if(sMeansOfDeath != "MOD_MELEE")
      victim playDeathSound();
  }

  if(isDefined(level.custom_death_effect))
    [[level.custom_death_effect]](victim, sMeansOfDeath, eInflictor);

  friendlyFire = isFriendlyFire(victim, attacker);

  if(isDefined(attacker)) {
    if(attacker.code_classname == "script_vehicle" && isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(attacker.code_classname == "misc_turret" && isDefined(attacker.owner)) {
      if(isDefined(attacker.vehicle))
        attacker.vehicle notify("killedPlayer", victim);

      attacker = attacker.owner;
    }

    if(IsAgent(attacker)) {
      sWeapon = "agent_mp";
      sMeansOfDeath = "MOD_RIFLE_BULLET";

      if(isDefined(attacker.agent_type)) {
        if(attacker.agent_type == "dog")
          sWeapon = "guard_dog_mp";
        else if(attacker.agent_type == "squadmate")
          sWeapon = "agent_support_mp";
        else if(attacker.agent_type == "pirate")
          sWeapon = "pirate_agent_mp";
        else if(attacker.agent_type == "wolf")
          sWeapon = "killstreak_wolfpack_mp";
        else if(attacker.agent_type == "beastmen")
          sWeapon = "beast_agent_mp";
      }

      if(isDefined(attacker.owner))
        attacker = attacker.owner;
    }

    if(attacker.code_classname == "script_model" && isDefined(attacker.owner)) {
      attacker = attacker.owner;

      if(!isFriendlyFire(victim, attacker) && attacker != victim)
        attacker notify("crushed_enemy");
    }
  }

  if((sMeansOfDeath != "MOD_SUICIDE") && (IsAIGameParticipant(victim) || IsAIGameParticipant(attacker)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    killing_entity = [[level.bot_funcs["get_attacker_ent"]]](attacker, eInflictor);
    if(isDefined(killing_entity)) {
      if(IsAIGameParticipant(victim)) {
        Assert(killing_entity.classname != "worldspawn" && killing_entity.classname != "trigger_hurt");
        victim BotMemoryEvent("death", sWeapon, killing_entity.origin, victim.origin, killing_entity);
      }

      if(IsAIGameParticipant(attacker)) {
        should_record_kill = true;
        if((killing_entity.classname == "script_vehicle" && isDefined(killing_entity.helitype)) || killing_entity.classname == "rocket" || killing_entity.classname == "misc_turret")
          should_record_kill = false;

        if(should_record_kill)
          attacker BotMemoryEvent("kill", sWeapon, killing_entity.origin, victim.origin, victim);
      }
    }
  }

  prof_end(" PlayerKilled_2");
  prof_begin(" PlayerKilled_3");

  prof_begin(" PlayerKilled_3_drop");

  victim maps\mp\gametypes\_weapons::dropScavengerForDeath(attacker);
  victim[[level.weaponDropFunction]](attacker, sMeansOfDeath);
  prof_end(" PlayerKilled_3_drop");

  if(!isFauxDeath) {
    victim updateSessionState("dead", "hud_status_dead");
  }

  switching_teams_while_already_dead = isDefined(victim.fauxDead) && victim.fauxDead && isDefined(victim.switching_teams) && victim.switching_teams;
  if(!switching_teams_while_already_dead)
    victim maps\mp\gametypes\_playerlogic::removeFromAliveCount();

  if(!isDefined(victim.switching_teams)) {
    deathDebitTo = victim;
    if(isDefined(victim.commanding_bot)) {
      deathDebitTo = victim.commanding_bot;
    }

    if(isDefined(level.isHorde)) {
      deathDebitTo.deaths++;
    } else {
      dontStoreKillsValue = false;
      if(IsSquadsMode())
        dontStoreKillsValue = true;

      deathDebitTo incPersStat("deaths", 1, dontStoreKillsValue);
      deathDebitTo.deaths = deathDebitTo getPersStat("deaths");
      deathDebitTo updatePersRatio("kdRatio", "kills", "deaths");
      deathDebitTo maps\mp\gametypes\_persistence::statSetChild("round", "deaths", deathDebitTo.deaths);
      deathDebitTo incPlayerStat("deaths", 1);
    }
  }

  if(isDefined(attacker) && IsPlayer(attacker))
    attacker checkKillSteal(victim);

  obituary(victim, attacker, sWeapon, sMeansOfDeath);

  doKillcam = false;

  lifeId = victim maps\mp\_matchdata::logPlayerLife();
  victim maps\mp\_matchdata::logPlayerDeath(lifeId, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc);

  if(IsPlayer(attacker)) {
    if((sMeansOfDeath == "MOD_MELEE")) {
      if(maps\mp\gametypes\_weapons::isRiotShield(sWeapon)) {
        attacker incPlayerStat("shieldkills", 1);

        if(!matchMakingGame())
          victim incPlayerStat("shielddeaths", 1);
      } else {
        attacker incPlayerStat("knifekills", 1);
      }

      addAttacker(victim, attacker, eInflictor, sWeapon, iDamage, (0, 0, 0), vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
    }
  }

  prof_end(" PlayerKilled_3");
  prof_begin(" PlayerKilled_4");

  if(victim isSwitchingTeams()) {
    handleTeamChangeDeath();
  } else if(!IsPlayer(attacker) || (IsPlayer(attacker) && sMeansOfDeath == "MOD_FALLING")) {
    handleWorldDeath(attacker, lifeId, sMeansOfDeath, sHitLoc);

    if(IsAgent(attacker))
      doKillcam = true;
  } else if(attacker == victim) {
    handleSuicideDeath(sMeansOfDeath, sHitLoc);
  } else if(friendlyFire) {
    if(!(isDefined(victim.nuked) || sWeapon == "bomb_site_mp")) {
      handleFriendlyFireDeath(attacker);
    }
  } else {
    if((sMeansOfDeath == "MOD_GRENADE" && eInflictor == attacker))
      addAttacker(victim, attacker, eInflictor, sWeapon, iDamage, (0, 0, 0), vDir, sHitLoc, psOffsetTime, sMeansOfDeath);

    doKillcam = true;
    if(IsAI(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"]))
      doKillcam = victim[[level.bot_funcs["should_do_killcam"]]]();

    if(isDefined(level.disable_killcam) && level.disable_killcam)
      doKillcam = false;

    handleNormalDeath(lifeId, attacker, eInflictor, sWeapon, sMeansOfDeath);
    victim thread maps\mp\gametypes\_missions::playerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc, attacker.modifiers);

    victim.pers["cur_death_streak"]++;

    if(IsPlayer(attacker) && victim isJuggernaut()) {
      if(isDefined(victim.isJuggernautManiac) && victim.isJuggernautManiac) {
        attacker thread teamPlayerCardSplash("callout_killed_maniac", attacker);

        if(sMeansOfDeath == "MOD_MELEE") {
          attacker maps\mp\gametypes\_missions::processChallenge("ch_thisisaknife");
        }
      } else if(isDefined(victim.isJuggernautLevelCustom) && victim.isJuggernautLevelCustom) {
        AssertEx(isDefined(level.mapCustomJuggKilledSplash), "level.mapCustomJuggKilledSplash must be defined for custom juggernaut!");
        attacker thread teamPlayerCardSplash(level.mapCustomJuggKilledSplash, attacker);
      } else {
        attacker thread teamPlayerCardSplash("callout_killed_juggernaut", attacker);
      }
    }
  }

  wasInLastStand = false;
  lastWeaponBeforeDroppingIntoLastStand = undefined;
  if(isDefined(self.previousPrimary)) {
    wasInLastStand = true;
    lastWeaponBeforeDroppingIntoLastStand = self.previousPrimary;
    self.previousprimary = undefined;
  }

  if(IsPlayer(attacker) && attacker != self && (!level.teamBased || (level.teamBased && self.team != attacker.team))) {
    if(wasInLastStand && isDefined(lastWeaponBeforeDroppingIntoLastStand))
      weaponName = lastWeaponBeforeDroppingIntoLastStand;
    else
      weaponName = self.lastdroppableweapon;

    weaponName = weaponMap(weaponName);

    self threadmaps\mp\gametypes\_gamelogic::trackLeaderBoardDeathStats(weaponName, sMeansOfDeath);

    attacker threadmaps\mp\gametypes\_gamelogic::trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath);
  }

  if(isDefined(attacker) && isDefined(victim)) {
    bbprint("kills", "attackername %s attackerteam %s attackerx %f attackery %f attackerz %f attackerweapon %s victimx %f victimy %f victimz %f victimname %s victimteam %s damage %i damagetype %s damagelocation %s attackerisbot %i victimisbot %i timesincespawn %f", attacker.name, attacker.team, attacker.origin[0], attacker.origin[1], attacker.origin[2], sWeapon, victim.origin[0], victim.origin[1], victim.origin[2], victim.name, victim.team, iDamage, sMeansOfDeath, sHitLoc, IsAI(attacker), IsAI(victim), ((getTime() - victim.lastSpawnTime) / 1000));
  }

  prof_end(" PlayerKilled_4");
  prof_begin(" PlayerKilled_5");

  victim.wasSwitchingTeamsForOnPlayerKilled = undefined;
  if(isDefined(victim.switching_teams))
    victim.wasSwitchingTeamsForOnPlayerKilled = true;

  victim resetPlayerVariables();
  victim.lastAttacker = attacker;
  victim.lastDeathPos = victim.origin;
  victim.deathTime = getTime();
  victim.wantSafeSpawn = false;
  victim.revived = false;
  victim.sameShotDamage = 0;

  if(maps\mp\killstreaks\_killstreaks::streakTypeResetsOnDeath(victim.streakType))
    victim maps\mp\killstreaks\_killstreaks::resetAdrenaline();

  killcamentity = undefined;
  if(self isRocketCorpse()) {
    doKillcam = true;
    isFauxDeath = false;
    killcamentity = self.killCamEnt;
    self waittill("final_rocket_corpse_death");
  } else {
    if(isFauxDeath) {
      doKillcam = false;
      deathAnimDuration = (victim PlayerForceDeathAnim(eInflictor, sMeansOfDeath, sWeapon, sHitLoc, vDir));
    }

    victim.body = victim clonePlayer(deathAnimDuration);
    victim.body.targetname = "player_corpse";

    if(isFauxDeath)
      victim PlayerHide();

    if(victim isOnLadder() || victim isMantling() || !victim isOnGround() || isDefined(victim.nuked) || isDefined(victim.customDeath)) {
      skipInstantRagdoll = false;

      if(sMeansOfDeath == "MOD_MELEE") {
        if((isDefined(victim.isPlanting) && victim.isPlanting) || isDefined(victim.nuked))
          skipInstantRagdoll = true;
      }

      if(!skipInstantRagdoll) {
        victim.body startRagDoll();
        victim notify("start_instant_ragdoll", sMeansOfDeath, eInflictor);
      }
    }

    if(!isDefined(victim.switching_teams)) {
      if(isDefined(attacker) && isPlayer(attacker) && !attacker _hasPerk("specialty_silentkill"))
        thread maps\mp\gametypes\_deathicons::addDeathicon(victim.body, victim, victim.team, 5.0);
    }
    thread delayStartRagdoll(victim.body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath);
  }

  victim thread[[level.onPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, lifeId);

  if(IsAI(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"]))
    victim thread[[level.bot_funcs["on_killed"]]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, lifeId);

  if(IsGameParticipant(attacker))
    attackerNum = attacker getEntityNumber();
  else
    attackerNum = -1;

  if(!isDefined(killcamentity))
    killcamentity = victim getKillcamEntity(attacker, eInflictor, sWeapon);

  killcamentityindex = -1;
  killcamentitystarttime = 0;

  if(isDefined(killcamentity)) {
    killcamentityindex = killcamentity getEntityNumber();
    killcamentitystarttime = killcamentity.birthtime;
    if(!isDefined(killcamentitystarttime))
      killcamentitystarttime = 0;
  }

  if(getDvarInt("scr_forcekillcam") != 0)
    doKillcam = true;

  prof_end(" PlayerKilled_5");
  prof_begin(" PlayerKilled_6");

  if((!isDefined(level.disable_killcam) || !level.disable_killcam) && sMeansOfDeath != "MOD_SUICIDE" && !(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == victim)) {
    recordFinalKillCam(5.0, victim, attacker, attackerNum, eInflictor, killcamentityindex, killcamentitystarttime, sWeapon, deathTimeOffset, psOffsetTime, sMeansOfDeath);
  }

  victim SetCommonPlayerData("killCamHowKilled", 0);
  switch (sMeansOfDeath) {
    case "MOD_HEAD_SHOT":
      victim SetCommonPlayerData("killCamHowKilled", 1);
      break;

    default:
      break;
  }

  inflictorAgentInfo = undefined;

  if(doKillcam) {
    victim maps\mp\gametypes\_killcam::preKillcamNotify(eInflictor, attacker);

    if(isDefined(eInflictor) && IsAgent(eInflictor)) {
      inflictorAgentInfo = spawnStruct();
      inflictorAgentInfo.agent_type = eInflictor.agent_type;
      inflictorAgentInfo.lastSpawnTime = eInflictor.lastSpawnTime;
    }
  }

  if(!isFauxDeath) {
    self.respawnTimerStartTime = gettime() + 1000;
    timeUntilSpawn = maps\mp\gametypes\_playerlogic::TimeUntilspawn(true);
    if(timeUntilSpawn < 1)
      timeUntilSpawn = 1;
    victim thread maps\mp\gametypes\_playerlogic::predictAboutToSpawnPlayerOverTime(timeUntilSpawn);

    wait(1.0);

    if(doKillcam) {
      doKillcam = !skipKillcamDuringDeathTimer(0.5);
    }

    victim notify("death_delay_finished");
  }

  postDeathDelay = (getTime() - victim.deathTime) / 1000;
  self.respawnTimerStartTime = gettime();

  doKillcam = doKillcam && !(victim maps\mp\gametypes\_battlebuddy::canBuddyspawn());

  if(!(isDefined(victim.cancelKillcam) && victim.cancelKillcam) && doKillcam && level.killcam && game["state"] == "playing" && !victim isUsingRemote() && !level.showingFinalKillcam) {
    livesLeft = !(getGametypeNumLives() && !victim.pers["lives"]);
    timeUntilSpawn = maps\mp\gametypes\_playerlogic::TimeUntilspawn(true);
    willRespawnImmediately = livesLeft && (timeUntilSpawn <= 0);

    if(!livesLeft) {
      timeUntilSpawn = -1;
      level notify("player_eliminated", victim);
    }

    victim maps\mp\gametypes\_killcam::killcam(eInflictor, inflictorAgentInfo, attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, timeUntilSpawn, maps\mp\gametypes\_gamelogic::timeUntilRoundEnd(), attacker, victim, sMeansOfDeath);
  }

  prof_end(" PlayerKilled_6");
  prof_begin(" PlayerKilled_7");

  if(game["state"] != "playing") {
    if(!level.showingFinalKillcam) {
      victim updateSessionState("dead");
      victim ClearKillcamState();
    }

    prof_end(" PlayerKilled_7");
    prof_end("PlayerKilled");
    return;
  }

  gameTypeLives = getGametypeNumLives();
  playerLives = self.pers["lives"];

  if(self == victim && isDefined(victim.battleBuddy) && isReallyAlive(victim.battleBuddy) && (!getGametypeNumLives() || self.pers["lives"]) && !victim isUsingRemote()) {
    self maps\mp\gametypes\_battlebuddy::waitForPlayerRespawnChoice();
  }

  if(isValidClass(victim.class)) {
    victim thread maps\mp\gametypes\_playerlogic::spawnClient();
  }

  prof_end(" PlayerKilled_7");
}

checkForceBleedout() {
  if(level.dieHardMode != 1)
    return false;

  if(!getGametypeNumLives())
    return false;

  if(level.livesCount[self.team] > 0)
    return false;

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }
    if(player.team != self.team) {
      continue;
    }
    if(player == self) {
      continue;
    }
    if(!player.inLastStand)
      return false;
  }

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }
    if(player.team != self.team) {
      continue;
    }
    if(player.inLastStand && player != self)
      player lastStandBleedOut(false);
  }

  return true;
}

checkKillSteal(vic) {
  if(matchMakingGame()) {
    return;
  }
  greatestDamage = 0;
  greatestAttacker = undefined;

  if(isDefined(vic.attackerdata) && vic.attackerdata.size > 1) {
    foreach(attacker in vic.attackerdata) {
      if(attacker.damage > greatestDamage) {
        greatestDamage = attacker.damage;
        greatestAttacker = attacker.attackerEnt;
      }
    }

    if(isDefined(greatestAttacker) && greatestAttacker != self)
      self incPlayerStat("killsteals", 1);
  }
}

initFinalKillCam() {
  level.finalKillCam_delay = [];
  level.finalKillCam_victim = [];
  level.finalKillCam_attacker = [];
  level.finalKillCam_attackerNum = [];
  level.finalKillCam_inflictor = [];
  level.finalKillCam_inflictor_agent_type = [];
  level.finalKillCam_inflictor_lastSpawnTime = [];
  level.finalKillCam_killCamEntityIndex = [];
  level.finalKillCam_killCamEntityStartTime = [];
  level.finalKillCam_sWeapon = [];
  level.finalKillCam_deathTimeOffset = [];
  level.finalKillCam_psOffsetTime = [];
  level.finalKillCam_timeRecorded = [];
  level.finalKillCam_timeGameEnded = [];
  level.finalKillCam_sMeansOfDeath = [];

  if(level.multiTeamBased) {
    foreach(teamName in level.teamNameList) {
      level.finalKillCam_delay[teamName] = undefined;
      level.finalKillCam_victim[teamName] = undefined;
      level.finalKillCam_attacker[teamName] = undefined;
      level.finalKillCam_attackerNum[teamName] = undefined;
      level.finalKillCam_inflictor[teamName] = undefined;
      level.finalKillCam_inflictor_agent_type[teamName] = undefined;
      level.finalKillCam_inflictor_lastSpawnTime[teamName] = undefined;
      level.finalKillCam_killCamEntityIndex[teamName] = undefined;
      level.finalKillCam_killCamEntityStartTime[teamName] = undefined;
      level.finalKillCam_sWeapon[teamName] = undefined;
      level.finalKillCam_deathTimeOffset[teamName] = undefined;
      level.finalKillCam_psOffsetTime[teamName] = undefined;
      level.finalKillCam_timeRecorded[teamName] = undefined;
      level.finalKillCam_timeGameEnded[teamName] = undefined;
      level.finalKillCam_sMeansOfDeath[teamName] = undefined;
    }
  } else {
    level.finalKillCam_delay["axis"] = undefined;
    level.finalKillCam_victim["axis"] = undefined;
    level.finalKillCam_attacker["axis"] = undefined;
    level.finalKillCam_attackerNum["axis"] = undefined;
    level.finalKillCam_inflictor["axis"] = undefined;
    level.finalKillCam_inflictor_agent_type["axis"] = undefined;
    level.finalKillCam_inflictor_lastSpawnTime["axis"] = undefined;
    level.finalKillCam_killCamEntityIndex["axis"] = undefined;
    level.finalKillCam_killCamEntityStartTime["axis"] = undefined;
    level.finalKillCam_sWeapon["axis"] = undefined;
    level.finalKillCam_deathTimeOffset["axis"] = undefined;
    level.finalKillCam_psOffsetTime["axis"] = undefined;
    level.finalKillCam_timeRecorded["axis"] = undefined;
    level.finalKillCam_timeGameEnded["axis"] = undefined;
    level.finalKillCam_sMeansOfDeath["axis"] = undefined;

    level.finalKillCam_delay["allies"] = undefined;
    level.finalKillCam_victim["allies"] = undefined;
    level.finalKillCam_attacker["allies"] = undefined;
    level.finalKillCam_attackerNum["allies"] = undefined;
    level.finalKillCam_inflictor["allies"] = undefined;
    level.finalKillCam_inflictor_agent_type["allies"] = undefined;
    level.finalKillCam_inflictor_lastSpawnTime["allies"] = undefined;
    level.finalKillCam_killCamEntityIndex["allies"] = undefined;
    level.finalKillCam_killCamEntityStartTime["allies"] = undefined;
    level.finalKillCam_sWeapon["allies"] = undefined;
    level.finalKillCam_deathTimeOffset["allies"] = undefined;
    level.finalKillCam_psOffsetTime["allies"] = undefined;
    level.finalKillCam_timeRecorded["allies"] = undefined;
    level.finalKillCam_timeGameEnded["allies"] = undefined;
    level.finalKillCam_sMeansOfDeath["allies"] = undefined;
  }

  level.finalKillCam_delay["none"] = undefined;
  level.finalKillCam_victim["none"] = undefined;
  level.finalKillCam_attacker["none"] = undefined;
  level.finalKillCam_attackerNum["none"] = undefined;
  level.finalKillCam_inflictor["none"] = undefined;
  level.finalKillCam_inflictor_agent_type["none"] = undefined;
  level.finalKillCam_inflictor_lastSpawnTime["none"] = undefined;
  level.finalKillCam_killCamEntityIndex["none"] = undefined;
  level.finalKillCam_killCamEntityStartTime["none"] = undefined;
  level.finalKillCam_sWeapon["none"] = undefined;
  level.finalKillCam_deathTimeOffset["none"] = undefined;
  level.finalKillCam_psOffsetTime["none"] = undefined;
  level.finalKillCam_timeRecorded["none"] = undefined;
  level.finalKillCam_timeGameEnded["none"] = undefined;
  level.finalKillCam_sMeansOfDeath["none"] = undefined;

  level.finalKillCam_winner = undefined;
}

recordFinalKillCam(delay, victim, attacker, attackerNum, eInflictor, killCamEntityIndex, killCamEntityStartTime, sWeapon, deathTimeOffset, psOffsetTime, sMeansOfDeath) {
  if(level.teambased && isDefined(attacker.team)) {
    level.finalKillCam_delay[attacker.team] = delay;
    level.finalKillCam_victim[attacker.team] = victim;
    level.finalKillCam_attacker[attacker.team] = attacker;
    level.finalKillCam_attackerNum[attacker.team] = attackerNum;
    level.finalKillCam_inflictor[attacker.team] = eInflictor;
    level.finalKillCam_killCamEntityIndex[attacker.team] = killCamEntityIndex;
    level.finalKillCam_killCamEntityStartTime[attacker.team] = killCamEntityStartTime;
    level.finalKillCam_sWeapon[attacker.team] = sWeapon;
    level.finalKillCam_deathTimeOffset[attacker.team] = deathTimeOffset;
    level.finalKillCam_psOffsetTime[attacker.team] = psOffsetTime;
    level.finalKillCam_timeRecorded[attacker.team] = getSecondsPassed();
    level.finalKillCam_timeGameEnded[attacker.team] = getSecondsPassed();
    level.finalKillCam_sMeansOfDeath[attacker.team] = sMeansOfDeath;

    if(isDefined(eInflictor) && IsAgent(eInflictor)) {
      level.finalKillCam_inflictor_agent_type[attacker.team] = eInflictor.agent_type;
      level.finalKillCam_inflictor_lastSpawnTime[attacker.team] = eInflictor.lastSpawnTime;
    } else {
      level.finalKillCam_inflictor_agent_type[attacker.team] = undefined;
      level.finalKillCam_inflictor_lastSpawnTime[attacker.team] = undefined;
    }
  }

  level.finalKillCam_delay["none"] = delay;
  level.finalKillCam_victim["none"] = victim;
  level.finalKillCam_attacker["none"] = attacker;
  level.finalKillCam_attackerNum["none"] = attackerNum;
  level.finalKillCam_inflictor["none"] = eInflictor;
  level.finalKillCam_killCamEntityIndex["none"] = killCamEntityIndex;
  level.finalKillCam_killCamEntityStartTime["none"] = killCamEntityStartTime;
  level.finalKillCam_sWeapon["none"] = sWeapon;
  level.finalKillCam_deathTimeOffset["none"] = deathTimeOffset;
  level.finalKillCam_psOffsetTime["none"] = psOffsetTime;
  level.finalKillCam_timeRecorded["none"] = getSecondsPassed();
  level.finalKillCam_timeGameEnded["none"] = getSecondsPassed();
  level.finalKillCam_timeGameEnded["none"] = getSecondsPassed();
  level.finalKillCam_sMeansOfDeath["none"] = sMeansOfDeath;

  if(isDefined(eInflictor) && IsAgent(eInflictor)) {
    level.finalKillCam_inflictor_agent_type["none"] = eInflictor.agent_type;
    level.finalKillCam_inflictor_lastSpawnTime["none"] = eInflictor.lastSpawnTime;
  } else {
    level.finalKillCam_inflictor_agent_type["none"] = undefined;
    level.finalKillCam_inflictor_lastSpawnTime["none"] = undefined;
  }
}

eraseFinalKillCam() {
  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      level.finalKillCam_delay[level.teamNameList[i]] = undefined;
      level.finalKillCam_victim[level.teamNameList[i]] = undefined;
      level.finalKillCam_attacker[level.teamNameList[i]] = undefined;
      level.finalKillCam_attackerNum[level.teamNameList[i]] = undefined;
      level.finalKillCam_inflictor[level.teamNameList[i]] = undefined;
      level.finalKillCam_inflictor_agent_type[level.teamNameList[i]] = undefined;
      level.finalKillCam_inflictor_lastSpawnTime[level.teamNameList[i]] = undefined;
      level.finalKillCam_killCamEntityIndex[level.teamNameList[i]] = undefined;
      level.finalKillCam_killCamEntityStartTime[level.teamNameList[i]] = undefined;
      level.finalKillCam_sWeapon[level.teamNameList[i]] = undefined;
      level.finalKillCam_deathTimeOffset[level.teamNameList[i]] = undefined;
      level.finalKillCam_psOffsetTime[level.teamNameList[i]] = undefined;
      level.finalKillCam_timeRecorded[level.teamNameList[i]] = undefined;
      level.finalKillCam_timeGameEnded[level.teamNameList[i]] = undefined;
      level.finalKillCam_sMeansOfDeath[level.teamNameList[i]] = undefined;
    }
  } else {
    level.finalKillCam_delay["axis"] = undefined;
    level.finalKillCam_victim["axis"] = undefined;
    level.finalKillCam_attacker["axis"] = undefined;
    level.finalKillCam_attackerNum["axis"] = undefined;
    level.finalKillCam_inflictor["axis"] = undefined;
    level.finalKillCam_inflictor_agent_type["axis"] = undefined;
    level.finalKillCam_inflictor_lastSpawnTime["axis"] = undefined;
    level.finalKillCam_killCamEntityIndex["axis"] = undefined;
    level.finalKillCam_killCamEntityStartTime["axis"] = undefined;
    level.finalKillCam_sWeapon["axis"] = undefined;
    level.finalKillCam_deathTimeOffset["axis"] = undefined;
    level.finalKillCam_psOffsetTime["axis"] = undefined;
    level.finalKillCam_timeRecorded["axis"] = undefined;
    level.finalKillCam_timeGameEnded["axis"] = undefined;
    level.finalKillCam_sMeansOfDeath["axis"] = undefined;

    level.finalKillCam_delay["allies"] = undefined;
    level.finalKillCam_victim["allies"] = undefined;
    level.finalKillCam_attacker["allies"] = undefined;
    level.finalKillCam_attackerNum["allies"] = undefined;
    level.finalKillCam_inflictor["allies"] = undefined;
    level.finalKillCam_inflictor_agent_type["allies"] = undefined;
    level.finalKillCam_inflictor_lastSpawnTime["allies"] = undefined;
    level.finalKillCam_killCamEntityIndex["allies"] = undefined;
    level.finalKillCam_killCamEntityStartTime["allies"] = undefined;
    level.finalKillCam_sWeapon["allies"] = undefined;
    level.finalKillCam_deathTimeOffset["allies"] = undefined;
    level.finalKillCam_psOffsetTime["allies"] = undefined;
    level.finalKillCam_timeRecorded["allies"] = undefined;
    level.finalKillCam_timeGameEnded["allies"] = undefined;
    level.finalKillCam_sMeansOfDeath["allies"] = undefined;
  }

  level.finalKillCam_delay["none"] = undefined;
  level.finalKillCam_victim["none"] = undefined;
  level.finalKillCam_attacker["none"] = undefined;
  level.finalKillCam_attackerNum["none"] = undefined;
  level.finalKillCam_inflictor["none"] = undefined;
  level.finalKillCam_inflictor_agent_type["none"] = undefined;
  level.finalKillCam_inflictor_lastSpawnTime["none"] = undefined;
  level.finalKillCam_killCamEntityIndex["none"] = undefined;
  level.finalKillCam_killCamEntityStartTime["none"] = undefined;
  level.finalKillCam_sWeapon["none"] = undefined;
  level.finalKillCam_deathTimeOffset["none"] = undefined;
  level.finalKillCam_psOffsetTime["none"] = undefined;
  level.finalKillCam_timeRecorded["none"] = undefined;
  level.finalKillCam_timeGameEnded["none"] = undefined;
  level.finalKillCam_sMeansOfDeath["none"] = undefined;

  level.finalKillCam_winner = undefined;
}

doFinalKillcam() {
  level waittill("round_end_finished");

  level.showingFinalKillcam = true;

  winner = "none";
  if(isDefined(level.finalKillCam_winner)) {
    winner = level.finalKillCam_winner;

  }

  delay = level.finalKillCam_delay[winner];
  victim = level.finalKillCam_victim[winner];
  attacker = level.finalKillCam_attacker[winner];
  attackerNum = level.finalKillCam_attackerNum[winner];
  eInflictor = level.finalKillCam_inflictor[winner];
  inflictor_agent_type = level.finalKillCam_inflictor_agent_type[winner];
  inflictor_lastSpawnTime = level.finalKillCam_inflictor_lastSpawnTime[winner];
  killCamEntityIndex = level.finalKillCam_killCamEntityIndex[winner];
  killCamEntityStartTime = level.finalKillCam_killCamEntityStartTime[winner];
  sWeapon = level.finalKillCam_sWeapon[winner];
  deathTimeOffset = level.finalKillCam_deathTimeOffset[winner];
  psOffsetTime = level.finalKillCam_psOffsetTime[winner];
  timeRecorded = level.finalKillCam_timeRecorded[winner];
  timeGameEnded = level.finalKillCam_timeGameEnded[winner];
  sMeansOfDeath = level.finalKillCam_sMeansOfDeath[winner];

  if(!isDefined(victim) ||
    !isDefined(attacker)) {
    level.showingFinalKillcam = false;
    level notify("final_killcam_done");
    return;
  }

  killCamBufferTime = 15;
  killCamOffsetTime = timeGameEnded - timeRecorded;
  if(killCamOffsetTime > killCamBufferTime) {
    level.showingFinalKillcam = false;
    level notify("final_killcam_done");
    return;
  }

  if(isDefined(attacker)) {
    attacker.finalKill = true;

    killCamTeam = "none";
    if(level.teamBased)
      killCamTeam = attacker.team;

    if(isDefined(level.finalKillCam_attacker[killCamTeam]) && level.finalKillCam_attacker[killCamTeam] == attacker) {
      maps\mp\gametypes\_missions::processFinalKillChallenges(attacker, victim);
    }
  }

  inflictorAgentInfo = spawnStruct();
  inflictorAgentInfo.agent_type = inflictor_agent_type;
  inflictorAgentInfo.lastSpawnTime = inflictor_lastSpawnTime;

  postDeathDelay = ((getTime() - victim.deathTime) / 1000);

  foreach(player in level.players) {
    player restoreBaseVisionSet(0);
    player.killcamentitylookat = victim getEntityNumber();

    player thread maps\mp\gametypes\_killcam::killcam(eInflictor, inflictorAgentInfo, attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, 0, 12, attacker, victim, sMeansOfDeath);
  }

  wait(0.1);

  while(anyPlayersInKillcam())
    wait(0.05);

  level notify("final_killcam_done");
  level.showingFinalKillcam = false;
}

anyPlayersInKillcam() {
  foreach(player in level.players) {
    if(isDefined(player.killcam))
      return true;
  }

  return false;
}

resetPlayerVariables() {
  self.killedPlayersCurrent = [];
  self.ch_extremeCrueltyComplete = false;
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;

  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;

  self maps\mp\gametypes\_gameobjects::detachUseModels();
}

getKillcamEntity(attacker, eInflictor, sWeapon) {
  if(!isDefined(attacker) || !isDefined(eInflictor) || ((attacker == eInflictor) && !isAgent(attacker)))
    return undefined;

  switch (sWeapon) {
    case "bomb_site_mp":
    case "trophy_mp":
    case "heli_pilot_turret_mp":
    case "proximity_explosive_mp":
    case "hashima_missiles_mp":
    case "sentry_minigun_mp":
      return eInflictor.killCamEnt;
    case "aamissile_projectile_mp":
    case "remote_tank_projectile_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
      if(isDefined(eInflictor.vehicle_fired_from) && isDefined(eInflictor.vehicle_fired_from.killCamEnt))
        return eInflictor.vehicle_fired_from.killCamEnt;
      else if(isDefined(eInflictor.vehicle_fired_from))
        return eInflictor.vehicle_fired_from;
      break;
    case "sam_projectile_mp":
      if(isDefined(eInflictor.samTurret) && isDefined(eInflictor.samTurret.killCamEnt))
        return eInflictor.samTurret.killCamEnt;
      break;

    case "ims_projectile_mp":
      if(isDefined(attacker) && isDefined(attacker.imsKillCamEnt))
        return attacker.imsKillCamEnt;
      break;

    case "ball_drone_gun_mp":
    case "ball_drone_projectile_mp":
      if(IsPlayer(attacker) && isDefined(attacker.ballDrone) && isDefined(attacker.ballDrone.turret) && isDefined(attacker.ballDrone.turret.killCamEnt))
        return attacker.ballDrone.turret.killCamEnt;
      break;

    case "artillery_mp":
    case "none":
      if((isDefined(eInflictor.targetname) && eInflictor.targetname == "care_package") || (isDefined(eInflictor.killCamEnt) && ((eInflictor.classname == "script_brushmodel") || (eInflictor.classname == "trigger_multiple") || (eInflictor.classname == "script_model"))))
        return eInflictor.killCamEnt;
      break;

    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
    case "remotemissile_projectile_mp":
    case "osprey_player_minigun_mp":
    case "ugv_turret_mp":
    case "remote_turret_mp":
      return undefined;
  }

  if(isDestructibleWeapon(sWeapon) || isBombSiteWeapon(sWeapon)) {
    if(isDefined(eInflictor.killCamEnt) && !attacker attackerInRemoteKillstreak())
      return eInflictor.killCamEnt;
    else
      return undefined;
  }

  return eInflictor;
}

attackerInRemoteKillstreak() {
  if(!isDefined(self))
    return false;
  if(isDefined(level.ac130player) && self == level.ac130player)
    return true;
  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner)
    return true;
  if(isDefined(level.remote_mortar) && isDefined(level.remote_mortar.owner) && self == level.remote_mortar.owner)
    return true;
  if(isDefined(self.using_remote_turret) && self.using_remote_turret)
    return true;
  if(isDefined(self.using_remote_tank) && self.using_remote_tank)
    return true;
  else if(isDefined(self.using_remote_a10)) {
    return true;
  }

  return false;
}

HitlocDebug(attacker, victim, damage, hitloc, dflags) {
  colors = [];
  colors[0] = 2;
  colors[1] = 3;
  colors[2] = 5;
  colors[3] = 7;

  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }
  if(!isDefined(attacker.hitlocInited)) {
    for(i = 0; i < 6; i++) {
      attacker setClientDvar("ui_hitloc_" + i, "");
    }
    attacker.hitlocInited = true;
  }

  if(level.splitscreen || !isPLayer(attacker)) {
    return;
  }
  elemcount = 6;
  if(!isDefined(attacker.damageInfo)) {
    attacker.damageInfo = [];
    for(i = 0; i < elemcount; i++) {
      attacker.damageInfo[i] = spawnStruct();
      attacker.damageInfo[i].damage = 0;
      attacker.damageInfo[i].hitloc = "";
      attacker.damageInfo[i].bp = false;
      attacker.damageInfo[i].jugg = false;
      attacker.damageInfo[i].colorIndex = 0;
    }
    attacker.damageInfoColorIndex = 0;
    attacker.damageInfoVictim = undefined;
  }

  for(i = elemcount - 1; i > 0; i--) {
    attacker.damageInfo[i].damage = attacker.damageInfo[i - 1].damage;
    attacker.damageInfo[i].hitloc = attacker.damageInfo[i - 1].hitloc;
    attacker.damageInfo[i].bp = attacker.damageInfo[i - 1].bp;
    attacker.damageInfo[i].jugg = attacker.damageInfo[i - 1].jugg;
    attacker.damageInfo[i].colorIndex = attacker.damageInfo[i - 1].colorIndex;
  }
  attacker.damageInfo[0].damage = damage;
  attacker.damageInfo[0].hitloc = hitloc;
  attacker.damageInfo[0].bp = (dflags & level.iDFLAGS_PENETRATION);
  attacker.damageInfo[0].jugg = victim isJuggernaut();
  if(isDefined(attacker.damageInfoVictim) && (attacker.damageInfoVictim != victim)) {
    attacker.damageInfoColorIndex++;
    if(attacker.damageInfoColorIndex == colors.size)
      attacker.damageInfoColorIndex = 0;
  }
  attacker.damageInfoVictim = victim;
  attacker.damageInfo[0].colorIndex = attacker.damageInfoColorIndex;

  for(i = 0; i < elemcount; i++) {
    color = "^" + colors[attacker.damageInfo[i].colorIndex];
    if(attacker.damageInfo[i].hitloc != "") {
      val = color + attacker.damageInfo[i].hitloc;
      if(attacker.damageInfo[i].bp)
        val += " (BP)";
      if(attacker.damageInfo[i].jugg)
        val += " (Jugg)";
      attacker setClientDvar("ui_hitloc_" + i, val);
    }
    attacker setClientDvar("ui_hitloc_damage_" + i, color + attacker.damageInfo[i].damage);
  }
}

giveRecentShieldXP() {
  self endon("death");
  self endon("disconnect");

  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");

  self.recentShieldXP++;

  wait(20.0);

  self.recentShieldXP = 0;
}

updateInflictorStat(eInflictor, eAttacker, sWeapon) {
  if(
    !isDefined(eInflictor) ||
    !isDefined(eInflictor.alreadyHit) ||
    !eInflictor.alreadyHit ||
    !isSingleHitWeapon(sWeapon)
  ) {
    self maps\mp\gametypes\_gamelogic::setInflictorStat(eInflictor, eAttacker, sWeapon);
  }

  if(isDefined(eInflictor)) {
    eInflictor.alreadyHit = true;
  }
}

Callback_PlayerDamage_internal(eInflictor, eAttacker, victim, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  eAttacker = _validateAttacker(eAttacker);

  gametype = GetDvar("g_gametype");

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_CRUSH" &&
    isDefined(eInflictor) && isDefined(eInflictor.classname) && eInflictor.classname == "script_vehicle")
    return "crushed";

  if(!isReallyAlive(victim))
    return "!isReallyAlive( victim )";

  if(sWeapon == "hind_bomb_mp" || sWeapon == "hind_missile_mp") {
    if(isDefined(eAttacker) && victim == eAttacker)
      return 0;
  }

  if(isDefined(eAttacker) && eAttacker.classname == "script_origin" && isDefined(eAttacker.type) && eAttacker.type == "soft_landing")
    return "soft_landing";

  if(sWeapon == "killstreak_emp_mp")
    return "sWeapon == killstreak_emp_mp";

  if(sWeapon == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::mineDamageHeightPassed(eInflictor, victim))
    return "mineDamageHeightPassed";

  if(sWeapon == "bouncingbetty_mp" && (victim GetStance() == "crouch" || victim GetStance() == "prone"))
    iDamage = Int(iDamage / 2);

  if(sWeapon == "emp_grenade_mp" && sMeansOfDeath != "MOD_IMPACT")
    victim notify("emp_damage", eAttacker);

  if(isDefined(level.hostMigrationTimer))
    return "level.hostMigrationTimer";

  if(sMeansOfDeath == "MOD_FALLING")
    victim thread emitFallDamage(iDamage);

  if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && iDamage != 1) {
    iDamage *= getDvarFloat("scr_explBulletMod");
    iDamage = int(iDamage);
  }

  if(isDefined(eAttacker) && eAttacker.classname == "worldspawn")
    eAttacker = undefined;

  if(isDefined(eAttacker) && isDefined(eAttacker.gunner))
    eAttacker = eAttacker.gunner;

  if(isDefined(eInflictor) && isDefined(eInflictor.damagedBy))
    eAttacker = eInflictor.damagedBy;

  attackerIsNPC = isDefined(eAttacker) && !isDefined(eAttacker.gunner) && (eAttacker.classname == "script_vehicle" || eAttacker.classname == "misc_turret" || eAttacker.classname == "script_model");
  attackerIsHittingTeammate = attackerIsHittingTeam(victim, eAttacker);

  attackerIsInflictorVictim = isDefined(eAttacker) && isDefined(eInflictor) && isDefined(victim) &&
    IsPlayer(eAttacker) && (eAttacker == eInflictor) && (eAttacker == victim) &&
    !isDefined(eInflictor.poison);

  if(attackerIsInflictorVictim)
    return "attackerIsInflictorVictim";

  stunFraction = 0.0;

  if(iDFlags & level.iDFLAGS_STUN) {
    stunFraction = 0.0;

    iDamage = 0.0;
  } else if(sHitLoc == "shield") {
    if(attackerIsHittingTeammate && level.friendlyfire == 0)
      return "attackerIsHittingTeammate";

    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && !attackerIsHittingTeammate) {
      if(IsPlayer(eAttacker)) {
        if(isDefined(victim.owner))
          victim = victim.owner;

        eAttacker.lastAttackedShieldPlayer = victim;
        eAttacker.lastAttackedShieldTime = getTime();
      }
      victim notify("shield_blocked");

      if(isEnvironmentWeapon(sWeapon))
        shieldDamage = 25;
      else
        shieldDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

      victim.shieldDamage += shieldDamage;

      if(!isEnvironmentWeapon(sWeapon) || cointoss())
        victim.shieldBulletHits++;

      if(victim.shieldBulletHits >= level.riotShieldXPBullets) {
        if(self.recentShieldXP > 4)
          xpVal = int(50 / self.recentShieldXP);
        else
          xpVal = 50;

        victim thread maps\mp\gametypes\_rank::giveRankXP("shield_damage", xpVal);
        victim thread giveRecentShieldXP();

        victim thread maps\mp\gametypes\_missions::genericChallenge("shield_damage", victim.shieldDamage);

        victim thread maps\mp\gametypes\_missions::genericChallenge("shield_bullet_hits", victim.shieldBulletHits);

        victim.shieldDamage = 0;
        victim.shieldBulletHits = 0;
      }
    }

    if(iDFlags & level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT) {
      if(!attackerIsHittingTeammate)
        victim thread maps\mp\gametypes\_missions::genericChallenge("shield_explosive_hits", 1);

      sHitLoc = "none";
      if(!(iDFlags & level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT_HUGE))
        iDamage *= 0.0;
    } else if(iDFlags & level.iDFLAGS_SHIELD_EXPLOSIVE_SPLASH) {
      if(isDefined(eInflictor) && isDefined(eInflictor.stuckEnemyEntity) && eInflictor.stuckEnemyEntity == victim)
        iDamage = 151;

      victim thread maps\mp\gametypes\_missions::genericChallenge("shield_explosive_hits", 1);
      sHitLoc = "none";
    } else {
      return "hit shield";
    }
  } else if((smeansofdeath == "MOD_MELEE") && maps\mp\gametypes\_weapons::isRiotShield(sweapon)) {
    if(!(attackerIsHittingTeammate && (level.friendlyfire == 0))) {
      stunFraction = 0.0;
      victim StunPlayer(0.0);
    }
  }

  if(isDefined(eInflictor) && isDefined(eInflictor.stuckEnemyEntity) && eInflictor.stuckEnemyEntity == victim)
    iDamage = 151;

  if(!attackerIsHittingTeammate) {
    if(self _hasPerk("specialty_moredamage"))
      self _unsetPerk("specialty_moredamage");

    if(isBulletDamage(sMeansOfDeath) && eAttacker _hasPerk("specialty_deadeye")) {
      eAttacker maps\mp\perks\_perkfunctions::setDeadeyeInternal();
    }

    iDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, eInflictor);

    if(IsPlayer(eAttacker) && (sWeapon == "smoke_grenade_mp" || sWeapon == "throwingknife_mp"))
      eAttacker thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName(sWeapon, 1, "hits");
  }

  if(isDefined(level.modifyPlayerDamage))
    iDamage = [[level.modifyPlayerDamage]](victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

  if(!iDamage)
    return "!iDamage";

  victim.iDFlags = iDFlags;
  victim.iDFlagsTime = getTime();

  if(game["state"] == "postgame")
    return "game[ state ] == postgame";
  if(victim.sessionteam == "spectator")
    return "victim.sessionteam == spectator";
  if(isDefined(victim.canDoCombat) && !victim.canDoCombat)
    return "!victim.canDoCombat";
  if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat)
    return "!eAttacker.canDoCombat";

  if(attackerIsNPC && attackerIsHittingTeammate) {
    if(sMeansOfDeath == "MOD_CRUSH") {
      victim _suicide();
      return "suicide crush";
    }

    if(!level.friendlyfire)
      return "!level.friendlyfire";
  }

  if(IsAI(self)) {
    assert(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_damaged"]));
    self[[level.bot_funcs["on_damaged"]]](eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor, sHitLoc);
  }

  prof_begin("PlayerDamage flags/tweaks");

  if(!isDefined(vDir))
    iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

  friendly = false;

  if((victim.health == victim.maxhealth && (!isDefined(victim.lastStand) || !victim.lastStand)) || !isDefined(victim.attackers) && !isDefined(victim.lastStand)) {
    victim resetAttackerList_Internal();
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, eAttacker))
    sMeansOfDeath = "MOD_HEAD_SHOT";

  if(maps\mp\gametypes\_tweakables::getTweakableValue("game", "onlyheadshots")) {
    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_EXPLOSIVE_BULLET")
      return "getTweakableValue( game, onlyheadshots )";
    else if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      if(victim isJuggernaut())
        iDamage = 75;
      else
        iDamage = 150;
    }
  }

  if(sWeapon == "destructible_toy" && isDefined(eInflictor))
    sWeapon = "destructible_car";

  if(getTime() < (victim.spawnTime + level.killstreakSpawnShield)) {
    damageLimit = int(max((victim.health / 4), 1));
    if((iDamage >= damageLimit) && isKillstreakWeapon(sWeapon) && sMeansOfDeath != "MOD_MELEE") {
      iDamage = damageLimit;
    }
  }

  prof_end("PlayerDamage flags/tweaks");

  if(!(iDFlags & level.iDFLAGS_NO_PROTECTION)) {
    if(!level.teamBased && attackerIsNPC && isDefined(eAttacker.owner) && eAttacker.owner == victim) {
      prof_end("PlayerDamage player");

      if(sMeansOfDeath == "MOD_CRUSH")
        victim _suicide();

      return "ffa suicide";
    }

    if((isSubStr(sMeansOfDeath, "MOD_GRENADE") || isSubStr(sMeansOfDeath, "MOD_EXPLOSIVE") || isSubStr(sMeansOfDeath, "MOD_PROJECTILE")) && isDefined(eInflictor) && isDefined(eAttacker)) {
      if(victim != eAttacker && eInflictor.classname == "grenade" && (victim.lastSpawnTime + 3500) > getTime() && isDefined(victim.lastSpawnPoint) && distance(eInflictor.origin, victim.lastSpawnPoint.origin) < 500) {
        prof_end("PlayerDamage player");
        return "spawnkill grenade protection";
      }

      victim.explosiveInfo = [];
      victim.explosiveInfo["damageTime"] = getTime();
      victim.explosiveInfo["damageId"] = eInflictor getEntityNumber();
      victim.explosiveInfo["returnToSender"] = false;
      victim.explosiveInfo["counterKill"] = false;
      victim.explosiveInfo["chainKill"] = false;
      victim.explosiveInfo["cookedKill"] = false;
      victim.explosiveInfo["throwbackKill"] = false;
      victim.explosiveInfo["suicideGrenadeKill"] = false;
      victim.explosiveInfo["weapon"] = sWeapon;

      isFrag = isSubStr(sWeapon, "frag_");

      if(eAttacker != victim) {
        if((isSubStr(sWeapon, "c4_") || isSubStr(sWeapon, "proximity_explosive_") || isSubStr(sWeapon, "claymore_")) && isDefined(eInflictor.owner)) {
          victim.explosiveInfo["returnToSender"] = (eInflictor.owner == victim);
          victim.explosiveInfo["counterKill"] = isDefined(eInflictor.wasDamaged);
          victim.explosiveInfo["chainKill"] = isDefined(eInflictor.wasChained);
          victim.explosiveInfo["bulletPenetrationKill"] = isDefined(eInflictor.wasDamagedFromBulletPenetration);
          victim.explosiveInfo["cookedKill"] = false;
        }

        if(isDefined(eAttacker.lastGrenadeSuicideTime) && eAttacker.lastGrenadeSuicideTime >= gettime() - 50 && isFrag)
          victim.explosiveInfo["suicideGrenadeKill"] = true;
      }

      if(isFrag) {
        victim.explosiveInfo["cookedKill"] = isDefined(eInflictor.isCooked);
        victim.explosiveInfo["throwbackKill"] = isDefined(eInflictor.threwBack);
      }

      victim.explosiveInfo["stickKill"] = isDefined(eInflictor.isStuck) && eInflictor.isStuck == "enemy";
      victim.explosiveInfo["stickFriendlyKill"] = isDefined(eInflictor.isStuck) && eInflictor.isStuck == "friendly";

      if(IsPlayer(eAttacker) && eAttacker != self && gametype != "aliens") {
        self updateInflictorStat(eInflictor, eAttacker, sWeapon);
      }
    }

    if(IsSubStr(sMeansOfDeath, "MOD_IMPACT") && sWeapon == "iw6_rgm_mp") {
      if(IsPlayer(eAttacker) && eAttacker != self && gametype != "aliens") {
        self updateInflictorStat(eInflictor, eAttacker, sWeapon);
      }
    }

    if(IsPlayer(eAttacker) && isDefined(eAttacker.pers["participation"]))
      eAttacker.pers["participation"]++;
    else if(IsPlayer(eAttacker))
      eAttacker.pers["participation"] = 1;

    prevHealthRatio = victim.health / victim.maxhealth;

    if(attackerIsHittingTeammate) {
      if(!matchMakingGame() && IsPlayer(eAttacker))
        eAttacker incPlayerStat("mostff", 1);

      prof_begin("PlayerDamage player");
      if(level.friendlyfire == 0 || (!IsPlayer(eAttacker) && level.friendlyfire != 1) || sWeapon == "bomb_site_mp") {
        if(sWeapon == "artillery_mp" || sWeapon == "stealth_bomb_mp")
          victim damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage, iDFlags, eAttacker);
        return "friendly fire";
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1)
          iDamage = 1;

        if(victim isJuggernaut())
          iDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

        victim.lastDamageWasFromEnemy = false;

        victim finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
      } else if((level.friendlyfire == 2) && isReallyAlive(eAttacker)) {
        iDamage = int(iDamage * .5);
        if(iDamage < 1)
          iDamage = 1;

        eAttacker.lastDamageWasFromEnemy = false;

        eAttacker.friendlydamage = true;
        eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
        eAttacker.friendlydamage = undefined;
      } else if(level.friendlyfire == 3 && isReallyAlive(eAttacker)) {
        iDamage = int(iDamage * .5);
        if(iDamage < 1)
          iDamage = 1;

        victim.lastDamageWasFromEnemy = false;
        eAttacker.lastDamageWasFromEnemy = false;

        victim finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
        if(isReallyAlive(eAttacker)) {
          eAttacker.friendlydamage = true;
          eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
          eAttacker.friendlydamage = undefined;
        }
      }

      friendly = true;

    } else {
      prof_begin("PlayerDamage world");

      if(iDamage < 1)
        iDamage = 1;

      if(isDefined(eAttacker) && IsPlayer(eAttacker))
        addAttacker(victim, eAttacker, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);

      if(isDefined(eAttacker) && !IsPlayer(eAttacker) && isDefined(eAttacker.owner) && (!isDefined(eAttacker.scrambled) || !eAttacker.scrambled))
        addAttacker(victim, eAttacker.owner, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
      else if(isDefined(eAttacker) && !IsPlayer(eAttacker) && isDefined(eAttacker.secondOwner) && isDefined(eAttacker.scrambled) && eAttacker.scrambled)
        addAttacker(victim, eAttacker.secondOwner, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);

      if(sMeansOfDeath == "MOD_EXPLOSIVE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" && iDamage < victim.health)
        victim notify("survived_explosion", eAttacker);

      if(isDefined(eAttacker))
        level.lastLegitimateAttacker = eAttacker;

      if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(sWeapon))
        eAttacker thread maps\mp\gametypes\_weapons::checkHit(sWeapon, victim);

      if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(sWeapon) && eAttacker != victim) {
        eAttacker thread maps\mp\_events::damagedPlayer(self, iDamage, sWeapon);
        victim.attackerPosition = eAttacker.origin;
      } else {
        victim.attackerPosition = undefined;
      }

      if(issubstr(sMeansOfDeath, "MOD_GRENADE") && isDefined(eInflictor.isCooked))
        victim.wasCooked = getTime();
      else
        victim.wasCooked = undefined;

      victim.lastDamageWasFromEnemy = (isDefined(eAttacker) && (eAttacker != victim));

      if(victim.lastDamageWasFromEnemy) {
        timeStamp = getTime();
        eAttacker.damagedPlayers[victim.guid] = timeStamp;

        victim.lastDamagedTime = timeStamp;
      }

      victim finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);

      if(isDefined(level.ac130player) && isDefined(eAttacker) && (level.ac130player == eAttacker))
        level notify("ai_pain", victim);

      victim thread maps\mp\gametypes\_missions::playerDamaged(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc);

      prof_end("PlayerDamage world");

    }

    if(attackerIsNPC && isDefined(eAttacker.gunner))
      damager = eAttacker.gunner;
    else
      damager = eAttacker;

    if(isDefined(damager) && damager != victim && iDamage > 0 && (!isDefined(sHitLoc) || sHitLoc != "shield")) {
      wasKilled = !isReallyAlive(victim) || (IsAgent(victim) && iDamage >= victim.health);

      if(iDFlags & level.iDFLAGS_STUN)
        typeHit = "stun";
      else if(IsExplosiveDamageMOD(sMeansOfDeath) && (isDefined(victim.thermoDebuffed) && victim.thermoDebuffed))
        typeHit = ter_op(wasKilled, "thermodebuff_kill", "thermobaric_debuff");

      else if(IsExplosiveDamageMOD(sMeansOfDeath) && victim _hasPerk("_specialty_blastshield") && !weaponIgnoresBlastShield(sWeapon))
        typeHit = ter_op(wasKilled, "hitkillblast", "hitblastshield");
      else if(victim _hasPerk("specialty_combathigh"))
        typeHit = "hitendgame";
      else if(isDefined(victim.lightArmorHP) && sMeansOfDeath != "MOD_HEAD_SHOT" && !isFMJDamage(sWeapon, sMeansOfDeath, eAttacker))
        typeHit = "hitlightarmor";
      else if(hasHeavyArmor(victim))
        typeHit = "hitlightarmor";

      else if(victim isJuggernaut())
        typeHit = ter_op(wasKilled, "hitkilljugg", "hitjuggernaut");
      else if(victim _hasPerk("specialty_moreHealth"))
        typeHit = "hitmorehealth";

      else if(damager _hasPerk("specialty_moredamage")) {
        typeHit = ter_op(wasKilled, "hitdeadeyekill", "hitcritical");
        damager _unsetPerk("specialty_moredamage");
      } else if(!shouldWeaponFeedback(sWeapon))
        typeHit = "none";

      else
        typeHit = ter_op(wasKilled, "hitkill", "standard");

      damager thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(typeHit);
    }

    maps\mp\gametypes\_gamelogic::setHasDoneCombat(victim, true);
  }

  if(isDefined(eAttacker) && (eAttacker != victim) && !friendly)
    level.useStartSpawns = false;

  if(iDamage > 10 && isDefined(eInflictor) && !victim isUsingRemote() && isPlayer(victim)) {
    victim thread maps\mp\gametypes\_shellshock::bloodEffect(eInflictor.origin);

    if(IsPlayer(eInflictor) && sMeansOfDeath == "MOD_MELEE")
      eInflictor thread maps\mp\gametypes\_shellshock::bloodMeleeEffect();
  }

  prof_begin("PlayerDamage log");

  if(getDvarInt("g_debugDamage")) {
    PrintLn("client:" + victim GetEntityNumber() + " health:" + victim.health + " attacker:" + eAttacker GetEntityNumber() + " inflictor is player:" + IsPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc + " range:" + Distance(eAttacker.origin, victim.origin));
  }

  HitlocDebug(eAttacker, victim, iDamage, sHitLoc, iDFlags);

  if(isDefined(eAttacker) && eAttacker != victim) {
    if(IsPlayer(eAttacker))
      eAttacker incPlayerStat("damagedone", iDamage);

    victim incPlayerStat("damagetaken", iDamage);
  }

  if(IsAgent(self)) {
    self[[self agentFunc("on_damaged_finished")]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
  }

  prof_end("PlayerDamage log");

  return "finished";
}

shouldWeaponFeedback(sWeapon) {
  switch (sWeapon) {
    case "stealth_bomb_mp":
    case "artillery_mp":
      return false;
  }

  return true;
}

checkVictimStutter(victim, eAttacker, vDir, sWeapon, sMeansOfDeath) {
  if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_HEAD_SHOT") {
    if(Distance(victim.origin, eAttacker.origin) > 256) {
      return;
    }
    vicVelocity = victim getVelocity();

    if(LengthSquared(vicVelocity) < 10) {
      return;
    }
    facing = findIsFacing(victim, eAttacker, 25);

    if(facing) {
      victim thread stutterStep();
    }
  }
}

stutterStep(enterScale) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self.inStutter = true;

  self.moveSpeedScaler = 0.05;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  wait(.5);

  self.moveSpeedScaler = 1;
  if(self _hasPerk("specialty_lightweight"))
    self.moveSpeedScaler = lightWeightScalar();

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self.inStutter = false;
}

addAttacker(victim, eAttacker, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath) {
  if(!isDefined(victim.attackerData))
    victim.attackerData = [];

  if(!isDefined(victim.attackerData[eAttacker.guid])) {
    victim.attackers[eAttacker.guid] = eAttacker;

    victim.attackerData[eAttacker.guid] = spawnStruct();
    victim.attackerData[eAttacker.guid].damage = 0;
    victim.attackerData[eAttacker.guid].attackerEnt = eAttacker;
    victim.attackerData[eAttacker.guid].firstTimeDamaged = getTime();
  }
  if(maps\mp\gametypes\_weapons::isPrimaryWeapon(sWeapon) && !maps\mp\gametypes\_weapons::isSideArm(sWeapon))
    victim.attackerData[eAttacker.guid].isPrimary = true;

  victim.attackerData[eAttacker.guid].damage += iDamage;
  victim.attackerData[eAttacker.guid].weapon = sWeapon;
  victim.attackerData[eAttacker.guid].vPoint = vPoint;
  victim.attackerData[eAttacker.guid].vDir = vDir;
  victim.attackerData[eAttacker.guid].sHitLoc = sHitLoc;
  victim.attackerData[eAttacker.guid].psOffsetTime = psOffsetTime;
  victim.attackerData[eAttacker.guid].sMeansOfDeath = sMeansOfDeath;
  victim.attackerData[eAttacker.guid].attackerEnt = eAttacker;
  victim.attackerData[eAttacker.guid].lasttimeDamaged = getTime();

  if(isDefined(eInflictor) && !IsPlayer(eInflictor) && isDefined(eInflictor.primaryWeapon))
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = eInflictor.primaryWeapon;
  else if(isDefined(eAttacker) && IsPlayer(eAttacker) && eAttacker getCurrentPrimaryWeapon() != "none")
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = eAttacker getCurrentPrimaryWeapon();
  else
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = undefined;
}

resetAttackerList(noWait) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  wait(1.75);

  self resetAttackerList_Internal();
}

resetAttackerList_Internal() {
  self.attackers = [];
  self.attackerData = [];
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  result = Callback_PlayerDamage_internal(eInflictor, eAttacker, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}

finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction) {
  if((self isUsingRemote() && (iDamage >= self.health) && !(iDFlags & level.iDFLAGS_STUN) && allowFauxDeath()) || self isRocketCorpse()) {
    if(!isDefined(vDir))
      vDir = (0, 0, 0);

    if(!isDefined(eAttacker) && !isDefined(eInflictor)) {
      eAttacker = self;
      eInflictor = eAttacker;
    }

    assert(isDefined(eAttacker));
    assert(isDefined(eInflictor));

    PlayerKilled_internal(eInflictor, eAttacker, self, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, 0, true);
  } else {
    if(!self Callback_KillingBlow(eInflictor, eAttacker, iDamage - (iDamage * stunFraction), iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)) {
      return;
    }
    if(!isAlive(self)) {
      return;
    }
    if(isPlayer(self))
      self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
  }

  if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && !is_aliens())
    self shellShock("damage_mp", getDvarFloat("scr_csmode"));

  self damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage, iDFlags, eAttacker);
}

allowFauxDeath() {
  if(!isDefined(level.allowFauxDeath))
    level.allowFauxDeath = true;

  return (level.allowFauxDeath);
}

Callback_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  lastStandParams = spawnStruct();
  lastStandParams.eInflictor = eInflictor;
  lastStandParams.attacker = attacker;
  lastStandParams.iDamage = iDamage;
  lastStandParams.attackerPosition = attacker.origin;
  if(attacker == self)
    lastStandParams.sMeansOfDeath = "MOD_SUICIDE";
  else
    lastStandParams.sMeansOfDeath = sMeansOfDeath;

  lastStandParams.sWeapon = sWeapon;
  if(isDefined(attacker) && IsPlayer(attacker) && attacker getCurrentPrimaryWeapon() != "none")
    lastStandParams.sPrimaryWeapon = attacker getCurrentPrimaryWeapon();
  else
    lastStandParams.sPrimaryWeapon = undefined;
  lastStandParams.vDir = vDir;
  lastStandParams.sHitLoc = sHitLoc;
  lastStandParams.lastStandStartTime = getTime();

  mayDoLastStand = mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc);

  if(isDefined(self.endGame))
    mayDoLastStand = false;

  if(level.teamBased && isDefined(attacker.team) && attacker.team == self.team)
    mayDoLastStand = false;

  if(level.dieHardMode) {
    if(level.teamCount[self.team] <= 1) {
      mayDoLastStand = false;
    } else if(self isTeamInLastStand()) {
      mayDoLastStand = false;
      killTeamInLastStand(self.team);
    }

  }

  if(getdvar("scr_forcelaststand") == "1")
    mayDoLastStand = true;

  if(!mayDoLastStand) {
    self.lastStandParams = lastStandParams;
    self.useLastStandParams = true;
    self _suicide();
    return;
  }

  self.inLastStand = true;

  notifyData = spawnStruct();
  if(self _hasPerk("specialty_finalstand")) {
    notifyData.titleText = game["strings"]["final_stand"];
    notifyData.iconName = "specialty_finalstand";
  } else if(self _hasPerk("specialty_c4death")) {
    notifyData.titleText = game["strings"]["c4_death"];
    notifyData.iconName = "specialty_c4death";
  } else {
    notifyData.titleText = game["strings"]["last_stand"];
    notifyData.iconName = "specialty_finalstand";
  }
  notifyData.glowColor = (1, 0, 0);
  notifyData.sound = "mp_last_stand";
  notifyData.duration = 2.0;

  self.health = 1;

  self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);

  grenadeTypePrimary = "frag_grenade_mp";

  if(isDefined(level.ac130player) && isDefined(attacker) && level.ac130player == attacker)
    level notify("ai_crawling", self);

  if(self _hasPerk("specialty_finalstand")) {
    self.lastStandParams = lastStandParams;
    self.inFinalStand = true;

    weaponList = self GetWeaponsListExclusives();
    foreach(weapon in weaponList)
    self takeWeapon(weapon);

    self _disableUsability();

    self thread enableLastStandWeapons();
    self thread lastStandTimer(20, true);
  } else if(self _hasPerk("specialty_c4death")) {
    self.previousPrimary = self.lastdroppableweapon;
    self.lastStandParams = lastStandParams;

    self takeAllWeapons();
    self giveWeapon("c4death_mp", 0, false);
    self switchToWeapon("c4death_mp");
    self _disableUsability();
    self.inC4Death = true;

    self thread lastStandTimer(20, false);
    self thread detonateOnUse();
    self thread detonateOnDeath();
  } else if(level.dieHardMode) {
    attacker maps\mp\gametypes\_rank::giveRankXP("kill", 100, sWeapon, sMeansOfDeath);
    self.lastStandParams = lastStandParams;

    self _DisableWeapon();

    self thread lastStandTimer(20, false);
    self _disableUsability();
  } else {
    self.lastStandParams = lastStandParams;

    pistolWeapon = undefined;

    weaponsList = self GetWeaponsListPrimaries();
    foreach(weapon in weaponsList) {
      if(maps\mp\gametypes\_weapons::isSideArm(weapon))
        pistolWeapon = weapon;
    }

    if(!isDefined(pistolWeapon)) {
      pistolWeapon = "iw6_p226_mp";
      self _giveWeapon(pistolWeapon);
    }

    self giveMaxAmmo(pistolWeapon);
    self DisableWeaponSwitch();
    self _disableUsability();

    if(!self _hasPerk("specialty_laststandoffhand"))
      self DisableOffhandWeapons();

    self switchToWeapon(pistolWeapon);

    self thread lastStandTimer(10, false);
  }
}

dieAfterTime(time) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  wait(time);
  self.useLastStandParams = true;
  self _suicide();
}

detonateOnUse() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  self waittill("detonate");
  self.useLastStandParams = true;
  self c4DeathDetonate();
}

detonateOnDeath() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  self waittill("death");
  self c4DeathDetonate();
}

c4DeathDetonate() {
  self playSound("detpack_explo_default");

  RadiusDamage(self.origin, 312, 100, 100, self);

  if(isAlive(self))
    self _suicide();
}

enableLastStandWeapons() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait .30;

  self freezeControlsWrapper(false);
}

lastStandTimer(delay, isFinalStand) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  level notify("player_last_stand");

  self thread lastStandWaittillDeath();

  self.lastStand = true;

  if(!isFinalStand && (!isDefined(self.inC4Death) || !self.inC4Death)) {
    self thread lastStandAllowSuicide();
    self setLowerMessage("last_stand", & "PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, true);
    self thread lastStandKeepOverlay();
  }

  if(level.dieHardMode == 1 && level.dieHardMode != 2) {
    reviveEnt = spawn("script_model", self.origin);
    reviveEnt setModel("tag_origin");
    reviveEnt setCursorHint("HINT_NOICON");
    reviveEnt setHintString(&"PLATFORM_REVIVE");

    reviveEnt reviveSetup(self);
    reviveEnt endon("death");

    reviveIcon = newTeamHudElem(self.team);
    reviveIcon setShader("waypoint_revive", 8, 8);
    reviveIcon setWaypoint(true, true);
    reviveIcon SetTargetEnt(self);
    reviveIcon thread destroyOnReviveEntDeath(reviveEnt);

    reviveIcon.color = (0.33, 0.75, 0.24);
    self playDeathSound();

    if(isFinalStand) {
      wait(delay);

      if(self.inFinalStand)
        self thread lastStandBleedOut(isFinalStand, reviveEnt);
    }

    return;
  } else if(level.dieHardMode == 2) {
    self thread lastStandKeepOverlay();
    reviveEnt = spawn("script_model", self.origin);
    reviveEnt setModel("tag_origin");
    reviveEnt setCursorHint("HINT_NOICON");
    reviveEnt setHintString(&"PLATFORM_REVIVE");

    reviveEnt reviveSetup(self);
    reviveEnt endon("death");

    reviveIcon = newTeamHudElem(self.team);
    reviveIcon setShader("waypoint_revive", 8, 8);
    reviveIcon setWaypoint(true, true);
    reviveIcon SetTargetEnt(self);
    reviveIcon thread destroyOnReviveEntDeath(reviveEnt);

    reviveIcon.color = (0.33, 0.75, 0.24);
    self playDeathSound();

    if(isFinalStand) {
      wait(delay);

      if(self.inFinalStand)
        self thread lastStandBleedOut(isFinalStand, reviveEnt);
    }

    wait delay / 3;
    reviveIcon.color = (1.0, 0.64, 0.0);

    while(reviveEnt.inUse)
      wait(0.05);

    self playDeathSound();
    wait delay / 3;
    reviveIcon.color = (1.0, 0.0, 0.0);

    while(reviveEnt.inUse)
      wait(0.05);

    self playDeathSound();
    wait delay / 3;

    while(reviveEnt.inUse)
      wait(0.05);

    wait(0.05);
    self thread lastStandBleedOut(isFinalStand);
    return;
  }

  self thread lastStandKeepOverlay();
  wait(delay);
  self thread lastStandBleedout(isFinalStand);
}

maxHealthOverlay(maxHealth, refresh) {
  self endon("stop_maxHealthOverlay");
  self endon("revive");
  self endon("death");

  for(;;) {
    self.health -= 1;
    self.maxHealth = maxHealth;
    wait(.05);
    self.maxHealth = 50;
    self.health += 1;

    wait(.50);
  }
}

lastStandBleedOut(reviveOnBleedOut, reviveEnt) {
  if(reviveOnBleedOut) {
    self.lastStand = undefined;
    self.inFinalStand = false;
    self notify("revive");
    self clearLowerMessage("last_stand");
    maps\mp\gametypes\_playerlogic::lastStandRespawnPlayer();

    if(isDefined(reviveEnt))
      reviveEnt Delete();
  } else {
    self.useLastStandParams = true;
    self.beingRevived = false;
    self _suicide();
  }
}

lastStandAllowSuicide() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("revive");

  while(1) {
    if(self useButtonPressed()) {
      pressStartTime = gettime();
      while(self useButtonPressed()) {
        wait .05;
        if(gettime() - pressStartTime > 700) {
          break;
        }
      }
      if(gettime() - pressStartTime > 700) {
        break;
      }
    }
    wait .05;
  }

  self thread lastStandBleedOut(false);
}

lastStandKeepOverlay() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("revive");

  while(!level.gameEnded) {
    self.health = 2;
    wait .05;
    self.health = 1;
    wait .5;
  }

  self.health = self.maxhealth;
}

lastStandWaittillDeath() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");

  self clearLowerMessage("last_stand");
  self.lastStand = undefined;
}

mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc) {
  if(sMeansOfDeath == "MOD_TRIGGER_HURT")
    return false;

  if(sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_FALLING" && sMeansOfDeath != "MOD_EXPLOSIVE_BULLET")
    return false;

  if(sMeansOfDeath == "MOD_IMPACT" && maps\mp\gametypes\_weapons::isThrowingKnife(sWeapon))
    return false;

  if(sMeansOfDeath == "MOD_IMPACT" && (sWeapon == "m79_mp" || isSubStr(sWeapon, "gl_")))
    return false;

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath))
    return false;

  if(self isUsingRemote())
    return false;

  return true;
}

ensureLastStandParamsValidity() {
  if(!isDefined(self.lastStandParams.attacker))
    self.lastStandParams.attacker = self;
}

getHitLocHeight(sHitLoc) {
  switch (sHitLoc) {
    case "helmet":
    case "head":
    case "neck":
      return 60;
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_upper":
    case "right_arm_lower":
    case "left_arm_lower":
    case "right_hand":
    case "left_hand":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "right_leg_upper":
    case "left_leg_upper":
      return 32;
    case "right_leg_lower":
    case "left_leg_lower":
      return 10;
    case "right_foot":
    case "left_foot":
      return 5;
  }
  return 48;
}

delayStartRagdoll(ent, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath) {
  if(isDefined(ent)) {
    deathAnim = ent getCorpseAnim();
    if(animhasnotetrack(deathAnim, "ignore_ragdoll"))
      return;
  }

  if(isDefined(level.noRagdollEnts) && level.noRagdollEnts.size) {
    foreach(noRag in level.noRagdollEnts) {
      if(distanceSquared(ent.origin, noRag.origin) < 65536)
        return;
    }
  }

  wait(0.2);

  if(!isDefined(ent)) {
    return;
  }
  if(ent isRagDoll()) {
    return;
  }
  deathAnim = ent getcorpseanim();

  startFrac = 0.35;

  if(animhasnotetrack(deathAnim, "start_ragdoll")) {
    times = getnotetracktimes(deathAnim, "start_ragdoll");
    if(isDefined(times))
      startFrac = times[0];
  }

  waitTime = startFrac * getanimlength(deathAnim);
  wait(waitTime);

  if(isDefined(ent)) {
    ent startragdoll();
  }
}

getMostKilledBy() {
  mostKilledBy = "";
  killCount = 0;

  killedByNames = getArrayKeys(self.killedBy);

  for(index = 0; index < killedByNames.size; index++) {
    killedByName = killedByNames[index];
    if(self.killedBy[killedByName] <= killCount) {
      continue;
    }
    killCount = self.killedBy[killedByName];
    mostKilleBy = killedByName;
  }

  return mostKilledBy;
}

getMostKilled() {
  mostKilled = "";
  killCount = 0;

  killedNames = getArrayKeys(self.killedPlayers);

  for(index = 0; index < killedNames.size; index++) {
    killedName = killedNames[index];
    if(self.killedPlayers[killedName] <= killCount) {
      continue;
    }
    killCount = self.killedPlayers[killedName];
    mostKilled = killedName;
  }

  return mostKilled;
}

damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage, iDFlags, eAttacker) {
  self thread maps\mp\gametypes\_weapons::onWeaponDamage(eInflictor, sWeapon, sMeansOfDeath, iDamage, eAttacker);

  if(!IsAI(self))
    self PlayRumbleOnEntity("damage_heavy");
}

reviveSetup(owner) {
  team = owner.team;

  self linkTo(owner, "tag_origin");

  self.owner = owner;
  self.inUse = false;
  self makeUsable();
  self updateUsableByTeam(team);
  self thread trackTeamChanges(team);

  self thread reviveTriggerThink(team);

  self thread deleteOnReviveOrDeathOrDisconnect();
}

deleteOnReviveOrDeathOrDisconnect() {
  self endon("death");

  self.owner waittill_any("death", "disconnect");

  self delete();
}

updateUsableByTeam(team) {
  foreach(player in level.players) {
    if(team == player.team && player != self.owner)
      self enablePlayerUse(player);
    else
      self disablePlayerUse(player);
  }
}

trackTeamChanges(team) {
  self endon("death");

  while(true) {
    level waittill("joined_team");

    self updateUsableByTeam(team);
  }
}

trackLastStandChanges(team) {
  self endon("death");

  while(true) {
    level waittill("player_last_stand");

    self updateUsableByTeam(team);
  }
}

reviveTriggerThink(team) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);
    self.owner.beingRevived = true;

    if(isDefined(player.beingRevived) && player.beingRevived) {
      self.owner.beingRevived = false;
      continue;
    }

    self makeUnUsable();
    self.owner freezeControlsWrapper(true);

    revived = self useHoldThink(player);
    self.owner.beingRevived = false;

    if(!isAlive(self.owner)) {
      self delete();
      return;
    }

    self.owner freezeControlsWrapper(false);

    if(revived) {
      player thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed("reviver", maps\mp\gametypes\_rank::getScoreInfoValue("reviver"));
      player thread maps\mp\gametypes\_rank::giveRankXP("reviver");

      self.owner.lastStand = undefined;
      self.owner clearLowerMessage("last_stand");

      self.owner.moveSpeedScaler = 1;
      if(self.owner _hasPerk("specialty_lightweight"))
        self.owner.moveSpeedScaler = lightWeightScalar();

      self.owner _EnableWeapon();
      self.owner.maxHealth = 100;

      self.owner maps\mp\gametypes\_weapons::updateMoveSpeedScale();
      self.owner maps\mp\gametypes\_playerlogic::lastStandRespawnPlayer();

      self.owner givePerk("specialty_pistoldeath", false);
      self.owner.beingRevived = false;

      self delete();
      return;
    }

    self makeUsable();
    self updateUsableByTeam(team);
  }
}

useHoldThink(player, useTime) {
  DEFAULT_USE_TIME = 3000;

  reviveSpot = spawn("script_origin", self.origin);
  reviveSpot hide();
  player playerLinkTo(reviveSpot);
  player PlayerLinkedOffsetEnable();

  player _disableWeapon();

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isDefined(useTime))
    self.useTime = useTime;
  else
    self.useTime = DEFAULT_USE_TIME;

  result = useHoldThinkLoop(player);

  self.inUse = false;
  reviveSpot Delete();

  if(isDefined(player) && isReallyAlive(player)) {
    player Unlink();
    player _enableWeapon();
  }

  if(isDefined(result) && result) {
    self.owner thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("revived", player);
    self.owner.inlaststand = false;
    return true;
  }

  return false;
}

useHoldThinkLoop(player) {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("disconnect");

  while(isReallyAlive(player) && player useButtonPressed() && (self.curProgress < self.useTime) && (!isDefined(player.lastStand) || !player.lastStand)) {
    self.curProgress += (50 * self.useRate);
    self.useRate = 1;

    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, true);
    self.owner maps\mp\gametypes\_gameobjects::updateUIProgress(self, true);

    if(self.curProgress >= self.useTime) {
      self.inUse = false;
      player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
      self.owner maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);

      return isReallyAlive(player);
    }

    wait 0.05;
  }

  player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
  self.owner maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
  return false;
}

Callback_KillingBlow(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  if(isDefined(self.lastDamageWasFromEnemy) && self.lastDamageWasFromEnemy && iDamage >= self.health && isDefined(self.combatHigh) && self.combatHigh == "specialty_endgame") {
    self givePerk("specialty_endgame", false);
    return false;
  }

  return true;
}

emitFallDamage(iDamage) {
  PhysicsExplosionSphere(self.origin, 64, 64, 1);

  damageEnts = [];
  for(testAngle = 0; testAngle < 360; testAngle += 30) {
    xOffset = cos(testAngle) * 16;
    yOffset = sin(testAngle) * 16;

    traceData = bulletTrace(self.origin + (xOffset, yOffset, 4), self.origin + (xOffset, yOffset, -6), true, self);

    if(isDefined(traceData["entity"]) && isDefined(traceData["entity"].targetname) && (traceData["entity"].targetname == "destructible_vehicle" || traceData["entity"].targetname == "destructible_toy"))
      damageEnts[damageEnts.size] = traceData["entity"];
  }

  if(damageEnts.size) {
    damageOwner = spawn("script_origin", self.origin);
    damageOwner hide();
    damageOwner.type = "soft_landing";
    damageOwner.destructibles = damageEnts;
    radiusDamage(self.origin, 64, 100, 100, damageOwner);

    wait(0.1);
    damageOwner delete();
  }
}

isFlankKill(victim, attacker) {
  victimForward = anglesToForward(victim.angles);
  victimForward = (victimForward[0], victimForward[1], 0);
  victimForward = VectorNormalize(victimForward);

  attackDirection = victim.origin - attacker.origin;
  attackDirection = (attackDirection[0], attackDirection[1], 0);
  attackDirection = VectorNormalize(attackDirection);

  dotProduct = VectorDot(victimForward, attackDirection);
  if(dotProduct > 0)
    return true;
  else
    return false;
}

destroyOnReviveEntDeath(reviveEnt) {
  reviveEnt waittill("death");

  self destroy();
}

gamemodeModifyPlayerDamage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc) {
  if(isDefined(eAttacker) && IsPlayer(eAttacker) && isAlive(eAttacker)) {
    if(level.matchRules_damageMultiplier)
      iDamage *= level.matchRules_damageMultiplier;

    if(level.matchRules_vampirism)
      eAttacker.health = int(min(float(eAttacker.maxHealth), float(eAttacker.health + 20)));
  }

  return iDamage;
}

registerKill(sWeapon, bNotifyIncrease) {
  self thread maps\mp\killstreaks\_killstreaks::giveAdrenaline("kill");
  self.pers["cur_kill_streak"]++;

  if(bNotifyIncrease) {
    self notify("kill_streak_increased");
  }

  bIsNotKillstreakWeapon = !isKillstreakWeapon(sWeapon);
  if(bIsNotKillstreakWeapon) {
    self.pers["cur_kill_streak_for_nuke"]++;
  }

  numKills = NUM_KILLS_GIVE_NUKE;
  if(self _hasPerk("specialty_hardline")) {
    numKills--;
  }

  if(bIsNotKillstreakWeapon && self.pers["cur_kill_streak_for_nuke"] == numKills && !isAnyMLGMatch()) {
    if(!isDefined(level.supportNuke) || level.supportNuke)
      self giveUltimateKillstreak(numKills);
  }
}

giveUltimateKillstreak(numKills) {
  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("nuke", false, true, self);
  self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("nuke", numKills);
}

monitorDamage(maxHealth, damageFeedback, onDeathFunc, modifyDamageFunc, bIsKillstreak, rumble) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(rumble))
    rumble = false;

  self setCanDamage(true);
  self.health = 999999;
  self.maxHealth = maxHealth;
  self.damageTaken = 0;

  if(!isDefined(bIsKillstreak)) {
    bIsKillstreak = false;
  }

  running = true;
  while(running) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(rumble) {
      self PlayRumbleOnEntity("damage_light");
    }

    if(isDefined(self.heliType) && self.heliType == "littlebird") {
      if(!isDefined(self.attackers))
        self.attackers = [];

      uniqueId = "";
      if(isDefined(attacker) && isPlayer(attacker))
        uniqueId = attacker getUniqueId();

      if(isDefined(self.attackers[uniqueId]))
        self.attackers[uniqueId] += damage;
      else
        self.attackers[uniqueId] = damage;
    }

    running = self monitorDamageOneShot(damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon, damageFeedback, onDeathFunc, modifyDamageFunc, bIsKillstreak);
  }
}

monitorDamageOneShot(damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon, damageFeedback, onDeathFunc, modifyDamageFunc, bIsKillstreak) {
  if(!isDefined(self))
    return false;

  if(isDefined(attacker) && !IsGameParticipant(attacker) && !isDefined(attacker.allowMonitoredDamage))
    return true;

  if(is_aliens() || (isDefined(attacker) && !maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)))
    return true;

  modifiedDamage = damage;
  if(isDefined(weapon)) {
    switch (weapon) {
      case "concussion_grenade_mp":
      case "flash_grenade_mp":
      case "smoke_grenade_mp":
      case "smoke_grenadejugg_mp":
        return true;
    }

    if(!isDefined(modifyDamageFunc)) {
      modifyDamageFunc = ::modifyDamage;
    }
    modifiedDamage = [[modifyDamageFunc]](attacker, weapon, meansOfDeath, damage);
  }

  if(modifiedDamage < 0) {
    return true;
  }

  self.wasDamaged = true;
  self.damageTaken += modifiedDamage;

  if(isDefined(iDFlags) && (iDFlags & level.iDFLAGS_PENETRATION)) {
    self.wasDamagedFromBulletPenetration = true;
  }

  if(bIsKillstreak) {
    maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
  }

  if(isDefined(attacker)) {
    if(IsPlayer(attacker)) {
      if(self.damagetaken >= self.maxhealth) {
        damageFeedback = "hitkill";
      }
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(damageFeedback);
    } else if(isDefined(attacker.owner) && IsPlayer(attacker.owner)) {
      attacker.owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback(damageFeedback);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    self thread[[onDeathFunc]](attacker, weapon, meansOfDeath, damage);
    return false;
  }

  return true;
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleEmpDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleMissileDamage(weapon, meansOfDeath, damage) {
  actualDamage = damage;
  switch (weapon) {
    case "odin_projectile_large_rod_mp":
    case "odin_projectile_small_rod_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "bomb_site_mp":
    case "drone_hive_projectile_mp":
    case "maverick_projectile_mp":
    case "aamissile_projectile_mp":
    case "iw6_maaws_mp":
    case "iw6_maawschild_mp":
    case "iw6_maawshoming_mp":
    case "iw6_panzerfaust3_mp":
      self.largeProjectileDamage = true;
      actualDamage = self.maxHealth + 1;
      break;
    case "switch_blade_child_mp":
    case "remote_tank_projectile_mp":
    case "hind_bomb_mp":
    case "hind_missile_mp":
      self.largeProjectileDamage = false;
      actualDamage = self.maxHealth + 1;
      break;

    case "a10_30mm_turret_mp":
    case "heli_pilot_turret_mp":

      self.largeProjectileDamage = false;
      actualDamage *= 2;
      break;

    case "sam_projectile_mp":
      self.largeProjectileDamage = true;
      actualDamage = damage;
      break;
  }

  return actualDamage;
}

handleGrenadeDamage(weapon, damageType, modifiedDamage) {
  if(IsExplosiveDamageMOD(damageType)) {
    switch (weapon) {
      case "c4_mp":
      case "proximity_explosive_mp":
      case "mortar_shell_mp":
      case "iw6_rgm_mp":
        modifiedDamage *= 3;
        break;

      case "frag_grenade_mp":
      case "semtex_mp":
      case "semtexproj_mp":
      case "iw6_mk32_mp":
        modifiedDamage *= 4;
        break;
      default:

        if(isStrStart(weapon, "alt_")) {
          modifiedDamage *= 3;
        }
        break;
    }
  }

  return modifiedDamage;
}

handleMeleeDamage(weapon, meansOfDeath, damage) {
  if(meansOfDeath == "MOD_MELEE") {
    return self.maxHealth + 1;
  }

  return damage;
}

handleEmpDamage(weapon, meansOfDeath, damage) {
  if(weapon == "emp_grenade_mp" && meansOfDeath == "MOD_GRENADE_SPLASH") {
    self notify("emp_damage", weapon.owner, 8.0);
    return 0;
  }

  return damage;
}

handleAPDamage(weapon, meansOfDeath, damage, attacker) {
  if(meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET") {
    if(attacker _hasPerk("specialty_armorpiercing") || isFMJDamage(weapon, meansOfDeath, attacker)) {
      return damage * level.armorPiercingMod;
    }
  }

  return damage;
}

onKillstreakKilled(attacker, weapon, damageType, damage, xpPopup, leaderDialog, cardSplash) {
  notifyFlag = false;

  validAttacker = undefined;
  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && IsPlayer(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(self.owner isEnemy(attacker)) {
      validAttacker = attacker;
    }
  }

  if(isDefined(validAttacker)) {
    validAttacker notify("destroyed_killstreak", weapon);

    xpReward = 100;
    if(isDefined(xpPopup)) {
      xpReward = maps\mp\gametypes\_rank::getScoreInfoValue(xpPopup);
      validAttacker thread maps\mp\gametypes\_rank::xpEventPopup(xpPopup);
    }
    validAttacker thread maps\mp\gametypes\_rank::giveRankXP("kill", xpReward, weapon, damageType);

    if(isDefined(cardSplash)) {
      thread teamPlayerCardSplash(cardSplash, validAttacker);
    }

    thread maps\mp\gametypes\_missions::killstreakKilled(self.owner, self, undefined, validAttacker, damage, damageType, weapon);

    notifyFlag = true;
  }

  if(isDefined(self.owner) && isDefined(leaderDialog)) {
    self.owner thread leaderDialogOnPlayer(leaderDialog, undefined, undefined, self.origin);
  }

  self notify("death");

  return notifyFlag;
}