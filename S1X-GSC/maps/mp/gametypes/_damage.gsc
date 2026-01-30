/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_damage.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\perks\_perkfunctions;

NUM_KILLS_GIVE_NUKE = 30;

isSwitchingTeams() {
  if(isDefined(self.switching_teams)) {
    return true;
  }

  return false;
}

isTeamSwitchBalanced() {
  playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
  playerCounts[self.leaving_team]--;
  playerCounts[self.joining_team]++;

  return ((playerCounts[self.joining_team] - playerCounts[self.leaving_team]) < 2);
}

isFriendlyFire(victim, attacker) {
  if(!level.teamBased) {
    return false;
  }

  if(!isDefined(attacker)) {
    return false;
  }

  if(!IsPlayer(attacker) && !isDefined(attacker.team)) {
    return false;
  }

  if(victim.team != attacker.team) {
    return false;
  }

  if(victim == attacker) {
    return false;
  }

  return true;
}

killedSelf(attacker) {
  if(!IsPlayer(attacker)) {
    return false;
  }

  if(attacker != self) {
    return false;
  }

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
    if(isDefined(level.onNormalDeath) && (IsPlayer(attacker) || IsAgent(attacker)) && attacker.team != "spectator") {
      [[level.onNormalDeath]](self, attacker, lifeId);
    }
  }
}

giveScoreLoss(value) {
  newScore = int(max(0, maps\mp\gametypes\_gamescore::_getPlayerScore(self) - value));
  maps\mp\gametypes\_gamescore::_setPlayerScore(self, newScore);
}

handleSuicideDeath(sMeansOfDeath, sHitLoc) {
  self thread[[level.onXPEvent]]("suicide");
  self incPersStat("suicides", 1);
  self.suicides = self getPersStat("suicides");

  scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "suicidepointloss");
  self giveScoreLoss(scoreSub);

  if(sMeansOfDeath == "MOD_SUICIDE" && sHitLoc == "none" && isDefined(self.throwingGrenade)) {
    self.lastGrenadeSuicideTime = gettime();
  }

  if(isDefined(level.onSuicideDeath)) {
    [[level.onSuicideDeath]](self);
  }

  if(isDefined(self.friendlydamage)) {
    self iPrintLnBold(&"MP_FRIENDLY_FIRE_WILL_NOT");
  }

  self.pers["suicideSpawnDelay"] = maps\mp\gametypes\_tweakables::getTweakableValue("game", "suicidespawndelay");
}

handleFriendlyFireDeath(attacker) {
  attacker thread[[level.onXPEvent]]("teamkill");
  attacker.pers["teamkills"] += 1.0;
  attacker.pers["totalTeamKills"] += 1.0;

  attacker.teamkillsThisRound++;

  if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillpointloss")) {
    scoreSub = maps\mp\gametypes\_rank::getScoreInfoValue("kill");
    attacker giveScoreLoss(scoreSub);
  }

  teamKillDelay = attacker maps\mp\gametypes\_playerlogic::TeamKillDelay();

  if(teamKillDelay > 0) {
    attacker.pers["teamKillPunish"] = true;
    attacker _suicide();
  }

  teamKillKickLimit = maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillkicklimit");
  if(teamKillKickLimit > 0) {
    totalTeamKills = attacker.pers["totalTeamKills"];
    if(totalTeamKills >= teamKillKickLimit) {
      thread friendlyFireKick(attacker);
    }
  }
}

friendlyFireKick(attacker) {
  waittillframeend;
  Kick(attacker GetEntityNumber(), "EXE_PLAYERKICKED_TEAMKILL");
  level thread maps\mp\gametypes\_gamelogic::updateGameEvents();
}

handleNormalDeath(lifeId, attacker, eInflictor, sWeapon, sMeansOfDeath) {
  attacker thread maps\mp\_events::killedPlayer(lifeId, self, sWeapon, sMeansOfDeath, eInflictor);

  attacker KillNotification();

  if(sMeansOfDeath == "MOD_HEAD_SHOT") {
    attacker PlayLocalSound("mp_headshot_killer");
    self playSound("mp_headshot_killed");
  }

  attacker thread maps\mp\_events::killedPlayerEvent(self, sWeapon, sMeansOfDeath);

  lastKillStreak = attacker.pers["cur_kill_streak"];

  if(isAlive(attacker)) {
    if((isMeleeMOD(sMeansOfDeath) && !attacker isJuggernaut()) || attacker killShouldAddToKillstreak(sWeapon)) {
      attacker.pers["cur_kill_streak"]++;
      attacker.killstreakCount = attacker.pers["cur_kill_streak"];
      attacker notify("kill_streak_increased");

      if(!isKillstreakWeapon(sWeapon)) {
        attacker.pers["cur_kill_streak_for_nuke"]++;
      }

      numKills = NUM_KILLS_GIVE_NUKE;
      if(attacker _hasPerk("specialty_hardline")) {
        numKills--;
      }

      if(!isKillstreakWeapon(sWeapon) && attacker.pers["cur_kill_streak_for_nuke"] == numKills) {
        slotIndex = attacker maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex("nuke", false);
        attacker thread maps\mp\killstreaks\_killstreaks::giveKillstreak("nuke", false, true, attacker);
        attacker thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("nuke", numKills, undefined, undefined, slotIndex);
      }

    }

    attacker setPlayerStatIfGreater("longestkillstreak", attacker.pers["cur_kill_streak"]);

    if(attacker.pers["cur_kill_streak"] > attacker getPersStat("longestStreak")) {
      attacker setPersStat("longestStreak", attacker.pers["cur_kill_streak"]);
    }
  }

  attacker.pers["cur_death_streak"] = 0;

  if(attacker.pers["cur_kill_streak"] > attacker maps\mp\gametypes\_persistence::statGetChild("round", "killStreak")) {
    attacker maps\mp\gametypes\_persistence::statSetChild("round", "killStreak", attacker.pers["cur_kill_streak"]);
  }

  if(attacker rankingEnabled()) {
    if(attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
      attacker maps\mp\gametypes\_persistence::statSet("killStreak", attacker.pers["cur_kill_streak"]);
      attacker.kill_streak = attacker.pers["cur_kill_streak"];
    }
  }

  scoreSub = maps\mp\gametypes\_tweakables::getTweakableValue("game", "deathpointloss");
  self giveScoreLoss(scoreSub);

  level notify("player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker);
  attacker notify("got_killstreak", attacker.pers["cur_kill_streak"]);

  attacker notify("killed_enemy");

  if(isDefined(level.onNormalDeath) && attacker.pers["team"] != "spectator") {
    [[level.onNormalDeath]](self, attacker, lifeId);
  }

  if(!level.teamBased) {
    self.attackers = [];
    return;
  }

  level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed(attacker, "kill", 0.75);

  if(isDefined(self.lastAttackedShieldPlayer) && isDefined(self.lastAttackedShieldTime) && self.lastAttackedShieldPlayer != attacker) {
    if(getTime() - self.lastAttackedShieldTime < 5000) {
      self.lastAttackedShieldPlayer thread maps\mp\_events::processAssistEvent(self, "assist_riot_shield");
    }
  }

  if(!isKillstreakWeapon(sWeapon)) {
    if(isDefined(self.is_being_tracked) && self.is_being_tracked && isDefined(self.TrackedByPlayer)) {
      if((self.TrackedByPlayer != attacker)) {
        self.TrackedByPlayer thread maps\mp\killstreaks\_marking_util::playerProcessTaggedAssist(self);
      }
    }

    onlyAwardOnceForUAV = [];

    foreach(uav in level.UAVModels[attacker.team]) {
      if(!isDefined(uav.owner) || (uav.owner == attacker)) {
        continue;
      }

      if(array_contains(onlyAwardOnceForUAV, uav.owner)) {
        continue;
      }

      onlyAwardOnceForUAV[onlyAwardOnceForUAV.size] = uav.owner;

      if(uav.assistPoints) {
        uav.owner thread maps\mp\_events::processAssistEvent(self, "assist_uav_plus");
      } else {
        uav.owner thread maps\mp\_events::processAssistEvent(self, "assist_uav");
      }

      uav.owner thread maps\mp\gametypes\_missions::processChallenge("ch_streak_uav");
    }
  }

  if(isDefined(self.tagMarkedBy)) {
    self.tagMarkedBy = undefined;
  }

  if((level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined(level.empPlayer) && level.empPlayer != self)) {
    if(isDefined(level.empOwner) && level.empAssistPoints && (level.empOwner != attacker)) {
      level.empOwner thread maps\mp\_events::processAssistEvent(self, "assist_emp");
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

      player thread maps\mp\_events::processAssistEvent(self);
    }

    self.attackers = [];
  }
}

IsPlayerWeapon(weaponName) {
  if(weaponClass(weaponName) == "non-player") {
    return false;
  }

  if(weaponClass(weaponName) == "turret") {
    return false;
  }

  if(weaponInventoryType(weaponName) == "primary" || weaponInventoryType(weaponName) == "altmode") {
    return true;
  }

  return false;
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  PlayerKilled_internal(eInflictor, attacker, self, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, false);
}

Callback_PlayerGrenadeSuicide(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime) {
  if(isDefined(level.isHorde) && level.isHorde) {
    shouldDoLastStand = false;
    if(level.players.size > 1) {
      shouldDoLastStand = true;
    } else if(self.hasSelfRevive) {
      shouldDoLastStand = true;
    }

    if(shouldDoLastStand) {
      eInflictor StartLastStand();
    }

    [[level.callbackPlayerLastStand]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, 0);
  }
}

Callback_EntityOutOfWorld() {
  self Delete();
}

LaunchShield(damage, meansOfDeath) {
  self RefreshShieldModels();

  maps\mp\_riotshield::riotshield_clear();
}

PlayerKilled_internal(eInflictor, attacker, victim, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, isFauxDeath) {
  prof_begin(" PlayerKilled_1");

  victim endon("spawned");
  victim notify("killed_player");

  if(isDefined(attacker) && IsPlayer(attacker) && isDefined(attacker.exo_ping_on) && attacker.exo_ping_on == true) {
    attacker maps\mp\gametypes\_missions::processChallenge("ch_exoability_ping");
  }

  if(isDefined(victim.preKilledFunc)) {
    victim[[victim.preKilledFunc]](eInflictor, attacker, victim, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, isFauxDeath);
  }

  victim maps\mp\gametypes\_playerlogic::resetUIDvarsOnDeath();

  victim.abilityChosen = false;
  victim.perkOutlined = false;
  victim.sensorOutlined = false;

  assert(victim.sessionteam != "spectator");

  attacker = _validateAttacker(attacker);

  if(isDefined(attacker)) {
    attacker.assistedSuicide = undefined;
  }

  if(!isDefined(victim.idFlags)) {
    if(sMeansOfDeath == "MOD_SUICIDE") {
      victim.idFlags = 0;
    } else if(sMeansOfDeath == "MOD_GRENADE") {
      if((IsSubStr(sWeapon, "frag_grenade") || IsSubStr(sWeapon, "thermobaric_grenade")) && iDamage == 100000)
    }
    victim.idFlags = 0;
    else if(sWeapon == "nuke_mp") {
      victim.idFlags = 0;
    } else if(level.friendlyfire >= 2) {
      victim.idFlags = 0;
    } else {
      assertEx(0, "Victims ID flags not set, sMeansOfDeath == " + sMeansOfDeath);
    }
  }

  if(victim maps\mp\_riotshield::hasRiotShieldEquipped()) {
    victim LaunchShield(iDamage, sMeansofDeath);
  }

  if(isMeleeMOD(sMeansOfDeath) && (IsSubStr(sWeapon, "knife") || IsSubStr(sWeapon, "tactical"))) {
    if(isDefined(getfx("exo_knife_blood"))) {
      if(isDefined(sHitLoc) && isDefined(vDir) && isDefined(getHitLocTag(sHitLoc))) {
        PlayImpactHeadFatalFX(victim getTagOrigin(getHitLocTag(sHitLoc)), vDir);
      } else {
        PlayImpactHeadFatalFX(victim getTagOrigin("j_neck"), anglesToForward(victim getTagAngles("j_neck")));
      }
    }
  }

  maps\mp\gametypes\_weapons::recordToggleScopeStates();

  if(!isFauxDeath) {
    if(isDefined(victim.endGame)) {
      self revertVisionSetForPlayer(2);
    } else {
      self revertVisionSetForPlayer(0);
      victim ThermalVisionOff();
    }
  } else {
    victim.fauxDead = true;
    self notify("death", attacker, sMeansOfDeath, sWeapon);
  }

  if(game["state"] == "postgame") {
    prof_end("PlayerKilled");
    return;
  }

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
    attacker = _validateAttacker(victim.lastStandParams.attacker);
    iDamage = victim.lastStandParams.iDamage;
    sMeansOfDeath = victim.lastStandParams.sMeansOfDeath;
    sWeapon = victim.lastStandParams.sWeapon;
    sPrimaryWeapon = victim.lastStandParams.sPrimaryWeapon;
    vDir = victim.lastStandParams.vDir;
    sHitLoc = victim.lastStandParams.sHitLoc;

    deathTimeOffset = (gettime() - victim.lastStandParams.lastStandStartTime) / 1000;
    victim.lastStandParams = undefined;
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

      if(victim.attackerData[player.guid].damage > 1 && !isDefined(bestPlayer)) {
        bestPlayer = player;
      } else if(isDefined(bestPlayer) && victim.attackerData[player.guid].damage > victim.attackerData[bestPlayer.guid].damage) {
        bestPlayer = player;
      }
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
    if(isDefined(attacker)) {
      attacker.assistedSuicide = undefined;
    }
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, attacker)) {
    sMeansOfDeath = "MOD_HEAD_SHOT";
  } else if(!isMeleeMOD(sMeansOfDeath) && !isDefined(victim.nuked)) {
    victim playDeathSound();
  }

  friendlyFire = isFriendlyFire(victim, attacker);

  if(isDefined(attacker)) {
    if(attacker.code_classname == "script_vehicle" && isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(attacker.code_classname == "misc_turret" && isDefined(attacker.owner)) {
      if(isDefined(attacker.vehicle)) {
        attacker.vehicle notify("killedPlayer", victim);
      }

      attacker = attacker.owner;
    }

    if(IsAgent(attacker) && isDefined(attacker.owner)) {
      attacker = attacker.owner;
      sWeapon = "agent_mp";
      sMeansOfDeath = "MOD_RIFLE_BULLET";
    }

    if(attacker.code_classname == "script_model" && isDefined(attacker.owner)) {
      attacker = attacker.owner;

      if(!isFriendlyFire(victim, attacker) && attacker != victim) {
        attacker notify("crushed_enemy");
      }
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
        if((killing_entity.classname == "script_vehicle" && isDefined(killing_entity.helitype)) || killing_entity.classname == "rocket" || killing_entity.classname == "misc_turret") {
          should_record_kill = false;
        }

        if(should_record_kill) {
          attacker BotMemoryEvent("kill", sWeapon, killing_entity.origin, victim.origin, victim);
        }
      }
    }
  }

  victimCurrentWeapon = victim GetCurrentWeapon();

  prof_end(" PlayerKilled_2");
  prof_begin(" PlayerKilled_3");

  prof_begin(" PlayerKilled_3_drop");

  victim thread maps\mp\gametypes\_weapons::dropScavengerForDeath(attacker);
  if(!isDefined(victim.agentBody)) {
    victim thread[[level.weaponDropFunction]](attacker, sMeansOfDeath);
  } else {
    victim.agentBody thread[[level.weaponDropFunction]](attacker, sMeansOfDeath);
  }
  prof_end(" PlayerKilled_3_drop");

  if(!isFauxDeath) {
    victim updateSessionState("dead");
  }

  switching_teams_while_already_dead = isDefined(victim.fauxDead) && victim.fauxDead && isDefined(victim.switching_teams) && victim.switching_teams;
  if(!switching_teams_while_already_dead) {
    victim maps\mp\gametypes\_playerlogic::removeFromAliveCount();
  }

  if(!isDefined(victim.switching_teams)) {
    deathDebitTo = victim;
    if(isDefined(victim.commanding_bot)) {
      deathDebitTo = victim.commanding_bot;
    }
    deathDebitTo incPersStat("deaths", 1);
    deathDebitTo.deaths = deathDebitTo getPersStat("deaths");
    deathDebitTo updatePersRatio("kdRatio", "kills", "deaths");
    deathDebitTo maps\mp\gametypes\_persistence::statSetChild("round", "deaths", deathDebitTo.deaths);
    deathDebitTo incPlayerStat("deaths", 1);
  }

  if(!practiceRoundGame()) {
    obituary(victim, attacker, sWeapon, sMeansOfDeath);
  }

  doKillcam = false;

  victim logPrintPlayerDeath(self.lifeId, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc);
  victim maps\mp\_matchdata::logPlayerLife(true);
  victim maps\mp\_matchdata::logPlayerDeath(self.lifeId, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc, victimCurrentWeapon);

  if(isMeleeMOD(sMeansOfDeath) && IsPlayer(attacker) && !IsSubStr(sWeapon, "riotshield")) {
    attacker incPlayerStat("knifekills", 1);
  }

  prof_end(" PlayerKilled_3");
  prof_begin(" PlayerKilled_4");

  if(victim isSwitchingTeams()) {
    handleTeamChangeDeath();
  } else if(!IsPlayer(attacker) || (IsPlayer(attacker) && sMeansOfDeath == "MOD_FALLING")) {
    handleWorldDeath(attacker, self.lifeId, sMeansOfDeath, sHitLoc);

    if(IsAgent(attacker)) {
      doKillcam = true;
    }
  } else if(attacker == victim && (isDefined(eInflictor) && (!isDefined(eInflictor.isOrbitalCam) || eInflictor.isOrbitalCam == false))) {
    handleSuicideDeath(sMeansOfDeath, sHitLoc);
  } else if(friendlyFire) {
    if(!isDefined(victim.nuked)) {
      handleFriendlyFireDeath(attacker);
    }
  } else {
    if((sMeansOfDeath == "MOD_GRENADE" && eInflictor == attacker) || (sMeansOfDeath == "MOD_IMPACT") || (sMeansOfDeath == "MOD_GRENADE_SPLASH") || (sMeansOfDeath == "MOD_EXPLOSIVE")) {
      addAttacker(victim, attacker, eInflictor, sWeapon, iDamage, (0, 0, 0), vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
    }

    doKillcam = true;
    if(IsAI(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
      doKillcam = victim[[level.bot_funcs["should_do_killcam"]]]();
    }

    if(isDefined(eInflictor) && (!isDefined(eInflictor.isOrbitalCam) || eInflictor.isOrbitalCam == false)) {
      handleNormalDeath(self.lifeId, attacker, eInflictor, sWeapon, sMeansOfDeath);
      victim thread maps\mp\gametypes\_missions::playerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc, attacker.modifiers);
    }

    victim.pers["cur_death_streak"]++;

    if(IsPlayer(attacker) && victim isJuggernaut()) {
      attacker thread teamPlayerCardSplash("callout_killed_juggernaut", attacker);
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
    if(wasInLastStand && isDefined(lastWeaponBeforeDroppingIntoLastStand)) {
      weaponName = lastWeaponBeforeDroppingIntoLastStand;
    } else {
      weaponName = self.lastdroppableweapon;
    }

    self threadmaps\mp\gametypes\_gamelogic::trackLeaderBoardDeathStats(weaponName, sMeansOfDeath);

    attacker threadmaps\mp\gametypes\_gamelogic::trackAttackerLeaderBoardDeathStats(sWeapon, sMeansOfDeath, eInflictor);
  }

  prof_end(" PlayerKilled_4");
  prof_begin(" PlayerKilled_5");

  victim.wasSwitchingTeamsForOnPlayerKilled = undefined;
  if(isDefined(victim.switching_teams)) {
    victim.wasSwitchingTeamsForOnPlayerKilled = true;
  }

  victim resetPlayerVariables();
  victim.lastAttacker = attacker;
  victim.lastInflictor = eInflictor;
  if(!isDefined(victim.agentBody)) {
    victim.lastDeathPos = victim.origin;
  } else {
    victim.lastDeathPos = victim.agentBody.origin;
  }
  victim.deathTime = getTime();
  victim.wantSafeSpawn = false;
  victim.revived = false;
  victim.sameShotDamage = 0;

  victim maps\mp\killstreaks\_killstreaks::resetAdrenaline(false);

  scorePerLife = maps\mp\_awards::getTotalScore(victim) - victim.scoreAtLifeStart;
  victim setPlayerStatIfGreater("mostScorePerLife", scorePerLife);

  killcamentity = undefined;
  if(self isRocketCorpse()) {
    doKillcam = true;
    isFauxDeath = false;
    killcamentity = self.killCamEnt;
    self waittill("final_rocket_corpse_death");
  } else {
    if(isFauxDeath) {
      doKillcam = false;
      if(!isDefined(victim.agentBody)) {
        deathAnimDuration = (victim PlayerForceDeathAnim(eInflictor, sMeansOfDeath, sWeapon, sHitLoc, vDir));
      }
    }

    if(isDefined(victim.hideOnDeath) && victim.hideOnDeath) {
      victim PlayerHide();
      thread maps\mp\gametypes\_deathicons::addDeathicon(victim, victim, victim.team, 5.0, attacker);
    } else if(!isDefined(victim.agentBody)) {
      victim.body = victim clonePlayer(deathAnimDuration);

      if(isFauxDeath) {
        victim PlayerHide();
      }

      if(victim isOnLadder() || victim isMantling() || !victim isOnGround() || isDefined(victim.nuked)) {
        victim.body startRagDoll();
      }

      if(!isDefined(victim.switching_teams)) {
        thread maps\mp\gametypes\_deathicons::addDeathicon(victim.body, victim, victim.team, 5.0, attacker);
      }

      thread delayStartRagdoll(victim.body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath);
    } else {
      if(!isDefined(victim.switching_teams)) {
        thread maps\mp\gametypes\_deathicons::addDeathicon(victim.agentBody, victim, victim.team, 5.0, attacker);
      }
    }
  }

  victim thread[[level.onPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, self.lifeId);

  if(IsAI(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    victim thread[[level.bot_funcs["on_killed"]]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, self.lifeId);
  }

  if(IsGameParticipant(attacker)) {
    attackerNum = attacker getEntityNumber();
  } else {
    attackerNum = -1;
  }

  if(!isDefined(killcamentity)) {
    killcamentity = victim getKillcamEntity(attacker, eInflictor, sWeapon);
  }

  killcamentityindex = -1;
  killcamentitystarttime = 0;
  useStartTime = false;

  if(isDefined(killcamentity)) {
    killcamentityindex = killcamentity getEntityNumber();
    killcamentitystarttime = killcamentity.birthtime;

    if(isDefined(killcamentity.killCamStartTime)) {
      killcamentitystarttime = killcamentity.killCamStartTime;
      useStartTime = true;
    }

    if(!isDefined(killcamentitystarttime)) {
      killcamentitystarttime = 0;
    }
  } else if(sWeapon == "orbital_laser_fov_mp" && isDefined(eInflictor) && isDefined(eInflictor.killCamStartTime)) {
    killcamentitystarttime = eInflictor.killCamStartTime;
    useStartTime = true;
  }

  if(getDvarInt("scr_forcekillcam") != 0) {
    doKillcam = true;
  }

  prof_end(" PlayerKilled_5");
  prof_begin(" PlayerKilled_6");

  if(isDefined(attacker) && isDefined(attacker.lastSpawnTime)) {
    aliveTime = (getTime() - attacker.lastSpawnTime) / 1000.0;
  } else {
    aliveTime = 0;
  }

  if(sMeansOfDeath != "MOD_SUICIDE" && !(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == victim)) {
    recordFinalKillCam(5.0, victim, attacker, attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, deathTimeOffset, psOffsetTime, sMeansOfDeath, "normal", useStartTime);
  }

  if(maps\mp\gametypes\_killcam::killcamValid(victim, doKillcam)) {
    timeUntilSpawn = maps\mp\gametypes\_playerlogic::TimeUntilspawn(true);
    timeUntilRoundEnd = maps\mp\gametypes\_gamelogic::timeUntilRoundEnd();
    camtime = maps\mp\gametypes\_killcam::killcamTime(killcamentitystarttime, sWeapon, 0, timeUntilSpawn, timeUntilRoundEnd, useStartTime, false);

    archiveTime = maps\mp\gametypes\_killcam::killCamArchiveTime(camTime, aliveTime, deathTimeOffset, psOffsetTime / 1000);

    victim maps\mp\gametypes\_killcam::preKillcamNotify(eInflictor, attacker, archiveTime, victimCurrentWeapon);
  } else if(isValidClass(victim.class)) {
    victim maps\mp\gametypes\_playerlogic::streamClassWeapons();
  }

  streamingTimeout = GetTime() + 5000;

  if(!isFauxDeath) {
    wait(0.25);
    victim thread maps\mp\gametypes\_killcam::cancelKillCamOnUse();
    wait(0.25);

    self.respawnTimerStartTime = gettime() + 1000;
    timeUntilSpawn = maps\mp\gametypes\_playerlogic::TimeUntilspawn(true);
    if(timeUntilSpawn < 1) {
      timeUntilSpawn = 1;
    }

    wait(1.0);

    if(isDefined(self.streamweapons) && self.streamweapons.size > 0) {
      while(maps\mp\gametypes\_killcam::killcamValid(victim, doKillcam) && isPlayer(self) && isPlayer(attacker) &&
        !self HasLoadedCustomizationPlayerView(attacker, self.streamweapons) && GetTime() < streamingTimeout) {
        waitframe();
      }
    }

    victim notify("death_delay_finished");
  }

  postDeathDelay = (getTime() - victim.deathTime) / 1000;
  self.respawnTimerStartTime = gettime();

  didStreamingTimeout = (GetTime() >= streamingTimeout);

  if(didStreamingTimeout) {
    victim IPrintLnBold("Error: streaming failed, killcam skipped");
  }

  if(maps\mp\gametypes\_killcam::killcamValid(victim, doKillcam) && !didStreamingTimeout) {
    livesLeft = !(getGametypeNumLives() && !victim.pers["lives"]);
    timeUntilSpawn = maps\mp\gametypes\_playerlogic::TimeUntilspawn(true);
    willRespawnImmediately = livesLeft && (timeUntilSpawn <= 0);

    if(!livesLeft) {
      timeUntilSpawn = -1;
      level notify("player_eliminated", victim);
    }

    victim maps\mp\gametypes\_killcam::killcam(eInflictor, attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, timeUntilSpawn, maps\mp\gametypes\_gamelogic::timeUntilRoundEnd(), attacker, victim, sMeansOfDeath, "normal", aliveTime, useStartTime);
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

waitTimerForspawn() {
  self endon("randomSpawnPressed");

  self.kc_teamSpawnText setText(&"PLATFORM_PRESS_TO_TEAMSPAWN");
  self.kc_teamSpawnText.alpha = 1;

  self.kc_randomSpawnText setText(&"PLATFORM_PRESS_TO_RESPAWN");
  self.kc_randomSpawnText.alpha = 1;

  self thread waitTeamSpawnButton();
  self thread waitSpawnRandomButton();

  if(isDefined(self.skippedKillCam) && self.skippedKillCam) {
    spawnPenalty = 8;
  } else {
    spawnPenalty = 9;
  }

  if(isDefined(self.timeStartedToWait)) {
    timeToWait = Int(ceil(spawnPenalty - ((getTime() - self.timeStartedToWait) / 1000)));
  } else {
    timeToWait = spawnPenalty;
  }

  self.partnerSpawning = false;

  wait(0.5);

  for(i = timeToWait; i > 0; i--) {
    self setLowerMessage("kc_info", &"MP_TIME_TILL_SPAWN", timeToWait, 1, true);
    wait 1;
  }

  self.kc_randomSpawnText.alpha = 0;
  self.kc_teamSpawnText.alpha = 0;
  self clearLowerMessage("kc_info");

  self notify("abort_fireteam_spawn");
}

waitSpawnRandomButton() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self useButtonPressed()) {
    wait .05;
  }

  while(!(self useButtonPressed())) {
    wait .05;

    if(!isReallyAlive(self.partner)) {
      break;
    }
  }
  self.partnerSpawning = false;
  self notify("randomSpawnPressed");

  self.kc_randomSpawnText.alpha = 0;
  self.kc_teamSpawnText.alpha = 0;
  self clearLowerMessage("kc_info");

  self notify("abort_fireteam_spawn");
}

waitTeamSpawnButton() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self attackButtonPressed()) {
    wait .05;
  }

  while(!(self attackButtonPressed())) {
    wait(0.05);
  }

  self.partnerSpawning = true;
  self playLocalSound("copycat_steal_class");
  self notify("teamSpawnPressed");

  self.kc_randomSpawnText.alpha = 0;
  self.kc_teamSpawnText.alpha = 0;
}

checkForceBleedout() {
  if(level.dieHardMode != 1) {
    return false;
  }

  if(!getGametypeNumLives()) {
    return false;
  }

  if(level.livesCount[self.team] > 0) {
    return false;
  }

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

    if(!player.inLastStand) {
      return false;
    }
  }

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }

    if(player.team != self.team) {
      continue;
    }

    if(player.inLastStand && player != self) {
      player lastStandBleedOut(false);
    }
  }

  return true;
}

initFinalKillCam() {
  level.finalKillCam_delay = [];
  level.finalKillCam_victim = [];
  level.finalKillCam_attacker = [];
  level.finalKillCam_attackerNum = [];
  level.finalKillCam_killCamEntityIndex = [];
  level.finalKillCam_killCamEntityStartTime = [];
  level.finalKillCam_sWeapon = [];
  level.finalKillCam_deathTimeOffset = [];
  level.finalKillCam_psOffsetTime = [];
  level.finalKillCam_timeRecorded = [];
  level.finalKillCam_timeGameEnded = [];
  level.finalKillCam_sMeansOfDeath = [];
  level.finalKillCam_type = [];
  level.finalKillCam_useStartTime = [];

  if(level.multiTeamBased) {
    foreach(teamName in level.teamNameList) {
      level.finalKillCam_delay[teamName] = undefined;
      level.finalKillCam_victim[teamName] = undefined;
      level.finalKillCam_attacker[teamName] = undefined;
      level.finalKillCam_attackerNum[teamName] = undefined;
      level.finalKillCam_killCamEntityIndex[teamName] = undefined;
      level.finalKillCam_killCamEntityStartTime[teamName] = undefined;
      level.finalKillCam_sWeapon[teamName] = undefined;
      level.finalKillCam_deathTimeOffset[teamName] = undefined;
      level.finalKillCam_psOffsetTime[teamName] = undefined;
      level.finalKillCam_timeRecorded[teamName] = undefined;
      level.finalKillCam_timeGameEnded[teamName] = undefined;
      level.finalKillCam_sMeansOfDeath[teamName] = undefined;
      level.finalKillCam_type[teamName] = undefined;
      level.finalKillCam_useStartTime[teamName] = undefined;
    }
  } else {
    level.finalKillCam_delay["axis"] = undefined;
    level.finalKillCam_victim["axis"] = undefined;
    level.finalKillCam_attacker["axis"] = undefined;
    level.finalKillCam_attackerNum["axis"] = undefined;
    level.finalKillCam_killCamEntityIndex["axis"] = undefined;
    level.finalKillCam_killCamEntityStartTime["axis"] = undefined;
    level.finalKillCam_sWeapon["axis"] = undefined;
    level.finalKillCam_deathTimeOffset["axis"] = undefined;
    level.finalKillCam_psOffsetTime["axis"] = undefined;
    level.finalKillCam_timeRecorded["axis"] = undefined;
    level.finalKillCam_timeGameEnded["axis"] = undefined;
    level.finalKillCam_sMeansOfDeath["axis"] = undefined;
    level.finalKillCam_type["axis"] = undefined;
    level.finalKillCam_useStartTime["axis"] = undefined;

    level.finalKillCam_delay["allies"] = undefined;
    level.finalKillCam_victim["allies"] = undefined;
    level.finalKillCam_attacker["allies"] = undefined;
    level.finalKillCam_attackerNum["allies"] = undefined;
    level.finalKillCam_killCamEntityIndex["allies"] = undefined;
    level.finalKillCam_killCamEntityStartTime["allies"] = undefined;
    level.finalKillCam_sWeapon["allies"] = undefined;
    level.finalKillCam_deathTimeOffset["allies"] = undefined;
    level.finalKillCam_psOffsetTime["allies"] = undefined;
    level.finalKillCam_timeRecorded["allies"] = undefined;
    level.finalKillCam_timeGameEnded["allies"] = undefined;
    level.finalKillCam_sMeansOfDeath["allies"] = undefined;
    level.finalKillCam_type["allies"] = undefined;
    level.finalKillCam_useStartTime["allies"] = undefined;
  }

  level.finalKillCam_delay["none"] = undefined;
  level.finalKillCam_victim["none"] = undefined;
  level.finalKillCam_attacker["none"] = undefined;
  level.finalKillCam_attackerNum["none"] = undefined;
  level.finalKillCam_killCamEntityIndex["none"] = undefined;
  level.finalKillCam_killCamEntityStartTime["none"] = undefined;
  level.finalKillCam_sWeapon["none"] = undefined;
  level.finalKillCam_deathTimeOffset["none"] = undefined;
  level.finalKillCam_psOffsetTime["none"] = undefined;
  level.finalKillCam_timeRecorded["none"] = undefined;
  level.finalKillCam_timeGameEnded["none"] = undefined;
  level.finalKillCam_sMeansOfDeath["none"] = undefined;
  level.finalKillCam_type["none"] = undefined;
  level.finalKillCam_useStartTime["none"] = undefined;

  level.finalKillCam_winner = undefined;
}

recordFinalKillCam(delay, victim, attacker, attackerNum, killCamEntityIndex, killCamEntityStartTime, sWeapon, deathTimeOffset, psOffsetTime, sMeansOfDeath, type, useStartTime) {
  if(level.teambased && isDefined(attacker.team)) {
    level.finalKillCam_delay[attacker.team] = delay;
    level.finalKillCam_victim[attacker.team] = victim;
    level.finalKillCam_attacker[attacker.team] = attacker;
    level.finalKillCam_attackerNum[attacker.team] = attackerNum;
    level.finalKillCam_killCamEntityIndex[attacker.team] = killCamEntityIndex;
    level.finalKillCam_killCamEntityStartTime[attacker.team] = killCamEntityStartTime;
    level.finalKillCam_sWeapon[attacker.team] = sWeapon;
    level.finalKillCam_deathTimeOffset[attacker.team] = deathTimeOffset;
    level.finalKillCam_psOffsetTime[attacker.team] = psOffsetTime;
    level.finalKillCam_timeRecorded[attacker.team] = getSecondsPassed();
    level.finalKillCam_timeGameEnded[attacker.team] = getSecondsPassed();
    level.finalKillCam_sMeansOfDeath[attacker.team] = sMeansOfDeath;
    level.finalKillCam_type[attacker.team] = type;
    level.finalKillCam_useStartTime[attacker.team] = isDefined(useStartTime) && useStartTime;
  }

  level.finalKillCam_delay["none"] = delay;
  level.finalKillCam_victim["none"] = victim;
  level.finalKillCam_attacker["none"] = attacker;
  level.finalKillCam_attackerNum["none"] = attackerNum;
  level.finalKillCam_killCamEntityIndex["none"] = killCamEntityIndex;
  level.finalKillCam_killCamEntityStartTime["none"] = killCamEntityStartTime;
  level.finalKillCam_sWeapon["none"] = sWeapon;
  level.finalKillCam_deathTimeOffset["none"] = deathTimeOffset;
  level.finalKillCam_psOffsetTime["none"] = psOffsetTime;
  level.finalKillCam_timeRecorded["none"] = getSecondsPassed();
  level.finalKillCam_timeGameEnded["none"] = getSecondsPassed();
  level.finalKillCam_timeGameEnded["none"] = getSecondsPassed();
  level.finalKillCam_sMeansOfDeath["none"] = sMeansOfDeath;
  level.finalKillCam_type["none"] = type;
  level.finalKillCam_useStartTime["none"] = isDefined(useStartTime) && useStartTime;
}

eraseFinalKillCam() {
  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      level.finalKillCam_delay[level.teamNameList[i]] = undefined;
      level.finalKillCam_victim[level.teamNameList[i]] = undefined;
      level.finalKillCam_attacker[level.teamNameList[i]] = undefined;
      level.finalKillCam_attackerNum[level.teamNameList[i]] = undefined;
      level.finalKillCam_killCamEntityIndex[level.teamNameList[i]] = undefined;
      level.finalKillCam_killCamEntityStartTime[level.teamNameList[i]] = undefined;
      level.finalKillCam_sWeapon[level.teamNameList[i]] = undefined;
      level.finalKillCam_deathTimeOffset[level.teamNameList[i]] = undefined;
      level.finalKillCam_psOffsetTime[level.teamNameList[i]] = undefined;
      level.finalKillCam_timeRecorded[level.teamNameList[i]] = undefined;
      level.finalKillCam_timeGameEnded[level.teamNameList[i]] = undefined;
      level.finalKillCam_sMeansOfDeath[level.teamNameList[i]] = undefined;
      level.finalKillCam_type[level.teamNameList[i]] = undefined;
      level.finalKillCam_useStartTime[level.teamNameList[i]] = undefined;
    }
  } else {
    level.finalKillCam_delay["axis"] = undefined;
    level.finalKillCam_victim["axis"] = undefined;
    level.finalKillCam_attacker["axis"] = undefined;
    level.finalKillCam_attackerNum["axis"] = undefined;
    level.finalKillCam_killCamEntityIndex["axis"] = undefined;
    level.finalKillCam_killCamEntityStartTime["axis"] = undefined;
    level.finalKillCam_sWeapon["axis"] = undefined;
    level.finalKillCam_deathTimeOffset["axis"] = undefined;
    level.finalKillCam_psOffsetTime["axis"] = undefined;
    level.finalKillCam_timeRecorded["axis"] = undefined;
    level.finalKillCam_timeGameEnded["axis"] = undefined;
    level.finalKillCam_sMeansOfDeath["axis"] = undefined;
    level.finalKillCam_type["axis"] = undefined;
    level.finalKillCam_useStartTime["axis"] = undefined;

    level.finalKillCam_delay["allies"] = undefined;
    level.finalKillCam_victim["allies"] = undefined;
    level.finalKillCam_attacker["allies"] = undefined;
    level.finalKillCam_attackerNum["allies"] = undefined;
    level.finalKillCam_killCamEntityIndex["allies"] = undefined;
    level.finalKillCam_killCamEntityStartTime["allies"] = undefined;
    level.finalKillCam_sWeapon["allies"] = undefined;
    level.finalKillCam_deathTimeOffset["allies"] = undefined;
    level.finalKillCam_psOffsetTime["allies"] = undefined;
    level.finalKillCam_timeRecorded["allies"] = undefined;
    level.finalKillCam_timeGameEnded["allies"] = undefined;
    level.finalKillCam_sMeansOfDeath["allies"] = undefined;
    level.finalKillCam_type["allies"] = undefined;
    level.finalKillCam_useStartTime["allies"] = undefined;
  }

  level.finalKillCam_delay["none"] = undefined;
  level.finalKillCam_victim["none"] = undefined;
  level.finalKillCam_attacker["none"] = undefined;
  level.finalKillCam_attackerNum["none"] = undefined;
  level.finalKillCam_killCamEntityIndex["none"] = undefined;
  level.finalKillCam_killCamEntityStartTime["none"] = undefined;
  level.finalKillCam_sWeapon["none"] = undefined;
  level.finalKillCam_deathTimeOffset["none"] = undefined;
  level.finalKillCam_psOffsetTime["none"] = undefined;
  level.finalKillCam_timeRecorded["none"] = undefined;
  level.finalKillCam_timeGameEnded["none"] = undefined;
  level.finalKillCam_sMeansOfDeath["none"] = undefined;
  level.finalKillCam_type["none"] = undefined;
  level.finalKillCam_useStartTime["none"] = undefined;

  level.finalKillCam_winner = undefined;
}

streamFinalKillcam() {
  if(IsAI(self)) {
    return;
  }

  winner = "none";
  if(isDefined(level.finalKillCam_winner)) {
    winner = level.finalKillCam_winner;
  }

  victim = level.finalKillCam_victim[winner];
  attacker = level.finalKillCam_attacker[winner];
  timeGameEnded = level.finalKillCam_timeGameEnded[winner];
  timeRecorded = level.finalKillCam_timeRecorded[winner];

  if(!finalKillcamValid(victim, attacker, timeGameEnded, timeRecorded)) {
    return;
  }

  killCamEntityStartTime = level.finalKillCam_killCamEntityStartTime[winner];
  sWeapon = level.finalKillCam_sWeapon[winner];
  useStartTime = level.finalKillCam_useStartTime[winner];
  psOffsetTime = level.finalKillCam_psOffsetTime[winner];

  deathTimeOffset = level.finalKillCam_deathTimeOffset[winner];
  postDeathDelay = ((getTime() - victim.deathTime) / 1000);
  preDelay = postDeathDelay + deathTimeOffset;

  camtime = maps\mp\gametypes\_killcam::killcamTime(killcamentitystarttime, sWeapon, preDelay, 0, getKillcamBufferTime(), useStartTime, true);

  archiveTime = camTime + preDelay + psOffsetTime / 1000;

  self OnlyStreamActiveWeapon(true);
  self thread maps\mp\gametypes\_killcam::preKillcamNotify(level.finalKillCam_attacker[winner], level.finalKillCam_attacker[winner], archiveTime, "none");
}

streamCheck(attacker) {
  level endon("stream_end");

  foreach(player in level.players) {
    if(IsAI(player)) {
      continue;
    }

    if(isDefined(player.streamweapons) && player.streamweapons.size > 0) {
      while(isPlayer(player) && isPlayer(attacker) &&
        !player HasLoadedCustomizationPlayerView(attacker, player.streamweapons[0])) {
        waitframe();
      }
    }
  }

  level notify("stream_end");
}

resetOnlyStreamActive() {
  foreach(player in level.players) {
    if(!IsAI(player)) {
      player OnlyStreamActiveWeapon(false);
    }
  }
}

streamTimeout(time) {
  level endon("stream_end");

  wait(time);

  level notify("stream_end");
}

waitForStream(attacker) {
  thread streamTimeout(5.0);
  streamCheck(attacker);
}

getKillcamBufferTime() {
  return 15;
}

finalKillcamValid(victim, attacker, timeGameEnded, timeRecorded) {
  valid = isDefined(victim) && isDefined(attacker) && !practiceRoundGame();

  if(valid) {
    killCamBufferTime = getKillcamBufferTime();
    killCamOffsetTime = timeGameEnded - timeRecorded;

    if(killCamOffsetTime <= killCamBufferTime) {
      return true;
    }
  }

  return false;
}

endFinalKillcam() {
  resetOnlyStreamActive();

  level.showingFinalKillcam = false;
  level notify("final_killcam_done");
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
  killCamEntityIndex = level.finalKillCam_killCamEntityIndex[winner];
  killCamEntityStartTime = level.finalKillCam_killCamEntityStartTime[winner];
  useStartTime = level.finalKillCam_useStartTime[winner];
  sWeapon = level.finalKillCam_sWeapon[winner];
  deathTimeOffset = level.finalKillCam_deathTimeOffset[winner];
  psOffsetTime = level.finalKillCam_psOffsetTime[winner];
  timeRecorded = level.finalKillCam_timeRecorded[winner];
  timeGameEnded = level.finalKillCam_timeGameEnded[winner];
  sMeansOfDeath = level.finalKillCam_sMeansOfDeath[winner];
  type = level.finalKillCam_type[winner];

  if(!finalKillcamValid(victim, attacker, timeGameEnded, timeRecorded)) {
    endFinalKillcam();
    return;
  }

  if(isDefined(attacker)) {
    attacker.finalKill = true;

    if(level.gametype == "conf" && isDefined(level.finalKillCam_attacker[attacker.team]) && level.finalKillCam_attacker[attacker.team] == attacker) {
      attacker maps\mp\gametypes\_missions::processChallenge("ch_theedge");

      if(isDefined(attacker.modifiers["revenge"])) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_moneyshot");
      }

      if(isDefined(attacker.inFinalStand) && attacker.inFinalStand) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_lastresort");
      }

      if(isDefined(victim) && isDefined(victim.explosiveInfo) && isDefined(victim.explosiveInfo["stickKill"]) && victim.explosiveInfo["stickKill"]) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_stickman");
      }

      if(isDefined(victim.attackerData[attacker.guid]) &&
        isDefined(victim.attackerData[attacker.guid].sMeansOfDeath) &&
        isDefined(victim.attackerData[attacker.guid].weapon) &&
        isSubStr(victim.attackerData[attacker.guid].sMeansOfDeath, "MOD_MELEE") &&
        isSubStr(victim.attackerData[attacker.guid].weapon, "riotshield_mp")) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_owned");
      }

      switch (level.finalKillCam_sWeapon[attacker.team]) {
        case "artillery_mp":
          attacker maps\mp\gametypes\_missions::processChallenge("ch_finishingtouch");
          break;

        case "stealth_bomb_mp":
          attacker maps\mp\gametypes\_missions::processChallenge("ch_technokiller");
          break;

        case "sentry_minigun_mp":
          attacker maps\mp\gametypes\_missions::processChallenge("ch_absentee");
          break;

        case "ac130_105mm_mp":
        case "ac130_40mm_mp":
        case "ac130_25mm_mp":
          attacker maps\mp\gametypes\_missions::processChallenge("ch_deathfromabove");
          break;

        case "remotemissile_projectile_mp":
          attacker maps\mp\gametypes\_missions::processChallenge("ch_dronekiller");
          break;

        default:
          break;
      }
    }
  }

  waitForStream(attacker);

  postDeathDelay = ((getTime() - victim.deathTime) / 1000);

  foreach(player in level.players) {
    player revertVisionSetForPlayer(0);
    player setblurforplayer(0, 0);
    player.killcamentitylookat = victim getEntityNumber();
    if(isDefined(attacker) && isDefined(attacker.lastSpawnTime)) {
      aliveTime = (getTime() - attacker.lastSpawnTime) / 1000.0;
    } else {
      aliveTime = 0;
    }

    player thread maps\mp\gametypes\_killcam::killcam(attacker, attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, 0, getKillcamBufferTime(), attacker, victim, sMeansOfDeath, type, aliveTime, useStartTime);
  }

  wait(0.1);

  while(anyPlayersInKillcam()) {
    wait(0.05);
  }

  endFinalKillcam();
}

anyPlayersInKillcam() {
  foreach(player in level.players) {
    if(isDefined(player.killcam)) {
      return true;
    }
  }

  return false;
}

resetPlayerVariables() {
  self.killedPlayersCurrent = [];
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;

  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.killstreakCount = 0;

  self maps\mp\gametypes\_gameobjects::detachUseModels();
}

getKillcamEntity(attacker, eInflictor, sWeapon) {
  if(isDefined(attacker.didTurretExplosion) && attacker.didTurretExplosion && isDefined(attacker.turret)) {
    attacker.didTurretExplosion = undefined;
    return attacker.turret.killcamEnt;
  }

  switch (sWeapon) {
    case "boost_slam_mp":
      return eInflictor;

    case "bouncingbetty_mp":
    case "artillery_mp":
    case "stealth_bomb_mp":
    case "bomb_site_mp":
    case "agent_mp":
    case "refraction_turret_mp":
    case "explosive_drone_mp":
    case "orbital_carepackage_pod_mp":
    case "orbital_carepackage_droppod_mp":
    case "orbital_carepackage_pod_plane_mp":
    case "remotemissile_projectile_cluster_child_mp":
      return eInflictor.killCamEnt;

    case "killstreak_laser2_mp":
      if(isDefined(eInflictor.samTurret) && isDefined(eInflictor.samTurret.killCamEnt)) {
        return eInflictor.samTurret.killCamEnt;
      }
      break;

    case "ball_drone_gun_mp":
    case "ball_drone_projectile_mp":
      if(IsPlayer(attacker) && isDefined(attacker.ballDrone) && isDefined(attacker.ballDrone.turret) && isDefined(attacker.ballDrone.turret.killCamEnt)) {
        return attacker.ballDrone.turret.killCamEnt;
      }
      break;

    case "ugv_missile_mp":
    case "drone_assault_remote_turret_mp":
      if(isDefined(eInflictor.killCamEnt)) {
        return eInflictor.killCamEnt;
      } else {
        return undefined;
      }
    case "assaultdrone_c4_mp":
      if(isDefined(eInflictor.hasAIOption) && eInflictor.hasAIOption) {
        return eInflictor;
      } else {
        return undefined;
      }

    case "killstreak_solar_mp":
    case "dam_turret_mp":
    case "warbird_missile_mp":
      if(isDefined(eInflictor) && isDefined(eInflictor.killCamEnt)) {
        return eInflictor.killCamEnt;
      }
      break;

    case "warbird_remote_turret_mp":
      if(isDefined(eInflictor) && isDefined(eInflictor.killCamEnt)) {
        return eInflictor.killCamEnt;
      } else {
        return undefined;
      }

    case "orbital_laser_fov_mp":
      return undefined;

    case "remote_energy_turret_mp":
    case "sentry_minigun_mp":
    case "killstreakmahem_mp":
      if(isDefined(eInflictor) && isDefined(eInflictor.remoteControlled)) {
        return undefined;
      }
      break;

    case "none":
      if(isDefined(eInflictor.targetname) && eInflictor.targetname == "care_package") {
        return eInflictor.killCamEnt;
      }
      break;

    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
    case "ugv_turret_mp":
    case "remote_turret_mp":
    case "detroit_tram_turret_mp":
    case "killstreak_terrace_mp":
      return undefined;
  }

  if(isDestructibleWeapon(sWeapon) || isBombSiteWeapon(sWeapon)) {
    if(isDefined(eInflictor.killCamEnt) && !attacker attackerInRemoteKillstreak()) {
      return eInflictor.killCamEnt;
    } else {
      return undefined;
    }
  }

  if(!isDefined(eInflictor) || ((attacker == eInflictor) && !isAgent(attacker))) {
    return undefined;
  }

  return eInflictor;
}

attackerInRemoteKillstreak() {
  if(!isDefined(self)) {
    return false;
  }
  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner) {
    return true;
  }
  if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
    return true;
  }
  if(isDefined(self.using_remote_tank) && self.using_remote_tank) {
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
  attacker.damageInfo[0].bp = (dflags &level.iDFLAGS_PENETRATION);
  attacker.damageInfo[0].jugg = victim isJuggernaut();
  if(isDefined(attacker.damageInfoVictim) && (attacker.damageInfoVictim != victim)) {
    attacker.damageInfoColorIndex++;
    if(attacker.damageInfoColorIndex == colors.size) {
      attacker.damageInfoColorIndex = 0;
    }
  }
  attacker.damageInfoVictim = victim;
  attacker.damageInfo[0].colorIndex = attacker.damageInfoColorIndex;

  for(i = 0; i < elemcount; i++) {
    color = "^" + colors[attacker.damageInfo[i].colorIndex];
    if(attacker.damageInfo[i].hitloc != "") {
      val = color + attacker.damageInfo[i].hitloc;
      if(attacker.damageInfo[i].bp) {
        val += " (BP)";
      }
      if(attacker.damageInfo[i].jugg) {
        val += " (Jugg)";
      }
      attacker setClientDvar("ui_hitloc_" + i, val);
    }
    attacker setClientDvar("ui_hitloc_damage_" + i, color + attacker.damageInfo[i].damage);
  }
}

isHardWrireProtected(sWeapon) {
  if(!self _hasPerk("specialty_stun_resistance")) {
    return false;
  }

  switch (sWeapon) {
    case "killstreak_strike_missile_gas_mp":
    case "mp_lab_gas":
      return true;
  }

  return false;
}

Callback_PlayerDamage_internal(eInflictor, eAttacker, victim, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  if(GetDvarInt("virtuallobbyactive", 0)) {
    return "virtuallobbyactive";
  }

  eAttacker = _validateAttacker(eAttacker);

  shortWeapon = maps\mp\_utility::strip_suffix(sWeapon, "_lefthand");

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_CRUSH" &&
    isDefined(eInflictor) && isDefined(eInflictor.classname) && eInflictor.classname == "script_vehicle")
    return "crushed";

  if(!isReallyAlive(victim) && !isDefined(victim.inLivePlayerKillstreak)) {
    return "!isReallyAlive( victim )";
  }

  if(isDefined(eAttacker) && eAttacker.classname == "script_origin" && isDefined(eAttacker.type) && eAttacker.type == "soft_landing") {
    return "soft_landing";
  }

  if(sWeapon == "killstreak_emp_mp") {
    return "sWeapon == killstreak_emp_mp";
  }

  if(victim isHardWrireProtected(sWeapon)) {
    return "specialty_stun_resistance";
  }

  if((shortWeapon == "emp_grenade_mp" || shortWeapon == "emp_grenade_var_mp" || shortWeapon == "emp_grenade_killstreak_mp") && sMeansOfDeath != "MOD_IMPACT") {
    victim notify("emp_grenaded", eAttacker);
  }

  if(isDefined(level.hostMigrationTimer)) {
    return "level.hostMigrationTimer";
  }

  if(sMeansOfDeath == "MOD_FALLING") {
    victim thread emitFallDamage(iDamage);
  }

  if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && iDamage != 1) {
    iDamage *= getDvarFloat("scr_explBulletMod");
    iDamage = int(iDamage);
  }

  if(isDefined(eAttacker) && eAttacker.classname == "worldspawn") {
    eAttacker = undefined;
  }

  if(isDefined(eAttacker) && isDefined(eAttacker.gunner)) {
    eAttacker = eAttacker.gunner;
  }

  if(isDefined(eAttacker) && (eAttacker == victim) && (sWeapon == "killstreak_strike_missile_gas_mp")) {
    return "gasCloudOwner";
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && IsExplosiveDamageMOD(sMeansOfDeath) && IsSubStr(sWeapon, "explosive_drone") && victim _hasPerk("_specialty_blastshield") && isReallyAlive(victim)) {
    victim.explosive_drone_owner = eAttacker;
  }

  attackerIsHittingTeammate = attackerIsHittingTeam(victim, eAttacker);

  attackerIsInflictorVictim = isDefined(eAttacker) && isDefined(eInflictor) && isDefined(victim) &&
    IsPlayer(eAttacker) && (eAttacker == eInflictor) && (eAttacker == victim) &&
    !isDefined(eInflictor.poison);

  if(attackerIsInflictorVictim) {
    return "attackerIsInflictorVictim";
  }

  stunFraction = 0.0;

  damage_types = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(IsSubStr(damage_types, sMeansOfDeath) && iDamage > 0) {
    if(!isDefined(self.damage_info[eAttacker GetEntityNumber()])) {
      self.damage_info[eAttacker GetEntityNumber()] = spawnStruct();
    }

    if(!isDefined(self.damage_info[eAttacker GetEntityNumber()].num_shots)) {
      self.damage_info[eAttacker GetEntityNumber()].num_shots = 0;
    }

    self.damage_info[eAttacker GetEntityNumber()].num_shots++;
  }

  if(iDFlags &level.iDFLAGS_STUN) {
    stunFraction = 0.0;

    iDamage = 0.0;
  } else if(sHitLoc == "shield") {
    if(attackerIsHittingTeammate && level.friendlyfire == 0) {
      return "attackerIsHittingTeammate";
    }

    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && !attackerIsHittingTeammate) {
      if(IsPlayer(eAttacker)) {
        eAttacker.lastAttackedShieldPlayer = victim;
        eAttacker.lastAttackedShieldTime = getTime();
      }

      if(isEnvironmentWeapon(sWeapon)) {
        shieldDamage = 25;
      } else {
        shieldDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
      }

      victim.shieldDamage += shieldDamage;

      if(!isEnvironmentWeapon(sWeapon) || cointoss()) {
        victim.shieldBulletHits++;
        if(isDefined(victim.pers["bulletsBlockedByShield"])) {
          victim.pers["bulletsBlockedByShield"]++;
        }
      }

      if(victim.shieldBulletHits >= level.riotShieldXPBullets) {
        victim.shieldDamage = 0;
        victim.shieldBulletHits = 0;
      }
    }

    if(iDFlags &level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT) {
      sHitLoc = "none";
      if(!(iDFlags &level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT_HUGE)) {
        iDamage *= 0.0;
      }
    } else if(iDFlags &level.iDFLAGS_SHIELD_EXPLOSIVE_SPLASH) {
      if(isDefined(eInflictor) && isDefined(eInflictor.stuckEnemyEntity) && eInflictor.stuckEnemyEntity == victim) {
        iDamage = 51;
      }

      sHitLoc = "none";
    } else {
      return "hit shield";
    }
  } else if(isMeleeMOD(sMeansOfDeath) && IsSubStr(sweapon, "riotshield")) {
    if(!(attackerIsHittingTeammate && (level.friendlyfire == 0))) {
      stunFraction = 0.0;
      victim StunPlayer(0.0);
    }
  }

  if(!attackerIsHittingTeammate) {
    iDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, eInflictor);
  }

  if(isDefined(level.modifyPlayerDamage)) {
    iDamage = [[level.modifyPlayerDamage]](victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
  }

  if(victim isJuggernaut() && !isAgent(victim)) {
    iDamage = maps\mp\killstreaks\_juggernaut::juggernautModifyDamage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, eInflictor);
  }

  attackerIsNPC = isDefined(eAttacker) && !isDefined(eAttacker.gunner) && (eAttacker.classname == "script_vehicle" || eAttacker.classname == "misc_turret" || eAttacker.classname == "script_model");
  attackerIsHittingTeammate = attackerIsHittingTeam(victim, eAttacker);

  if(!iDamage) {
    return "!iDamage";
  }

  victim.iDFlags = iDFlags;
  victim.iDFlagsTime = getTime();

  if(game["state"] == "postgame") {
    return "game[ state ] == postgame";
  }
  if(victim.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }
  if(isDefined(victim.canDoCombat) && !victim.canDoCombat) {
    return "!victim.canDoCombat";
  }
  if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(eAttacker.canDoCombat) && !eAttacker.canDoCombat) {
    return "!eAttacker.canDoCombat";
  }

  if(isDefined(eAttacker) && IsAlive(eAttacker) && !isDefined(eAttacker.perkOutlined)) {
    eAttacker.perkOutlined = false;
  }

  if(attackerIsNPC && attackerIsHittingTeammate) {
    if(sMeansOfDeath == "MOD_CRUSH") {
      victim _suicide();
      return "suicide crush";
    }

    if(!level.friendlyfire) {
      return "!level.friendlyfire";
    }
  }

  if(IsAI(self)) {
    assert(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_damaged"]));
    self[[level.bot_funcs["on_damaged"]]](eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor, sHitLoc);
  }

  prof_begin("PlayerDamage flags/tweaks");

  if(!isDefined(vDir)) {
    iDFlags |= level.iDFLAGS_NO_KNOCKBACK;
  }

  friendly = false;

  if((victim.health == victim.maxhealth && (!isDefined(victim.lastStand) || !victim.lastStand)) || !isDefined(victim.attackers) && !isDefined(victim.lastStand)) {
    victim.attackers = [];
    victim.attackerData = [];
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, eAttacker)) {
    sMeansOfDeath = "MOD_HEAD_SHOT";
  }

  if(maps\mp\gametypes\_tweakables::getTweakableValue("game", "onlyheadshots")) {
    if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_EXPLOSIVE_BULLET") {
      return "getTweakableValue( game, onlyheadshots )";
    } else if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      if(victim isJuggernaut()) {
        iDamage = 75;
      } else {
        iDamage = 150;
      }
    }
  }

  if(sWeapon == "none" && isDefined(eInflictor)) {
    if(isDefined(eInflictor.destructible_type) && isSubStr(eInflictor.destructible_type, "vehicle_")) {
      sWeapon = "destructible_car";
    }
  }

  if(getTime() < (victim.spawnTime + level.killstreakSpawnShield)) {
    damageLimit = int(max((victim.health / 4), 1));
    if((iDamage >= damageLimit) && isKillstreakWeapon(sWeapon) && !isMeleeMOD(sMeansOfDeath)) {
      iDamage = damageLimit;
    }
  }

  prof_end("PlayerDamage flags/tweaks");

  if(!(iDFlags &level.iDFLAGS_NO_PROTECTION)) {
    if(!level.teamBased && attackerIsNPC && isDefined(eAttacker.owner) && eAttacker.owner == victim) {
      prof_end("PlayerDamage player");

      if(sMeansOfDeath == "MOD_CRUSH") {
        victim _suicide();
      }

      return "ffa suicide";
    }

    if((isSubStr(sMeansOfDeath, "MOD_GRENADE") || isSubStr(sMeansOfDeath, "MOD_EXPLOSIVE") || isSubStr(sMeansOfDeath, "MOD_PROJECTILE")) && isDefined(eInflictor) && isDefined(eAttacker)) {
      if(victim != eAttacker && eInflictor.classname == "grenade" && (victim.lastSpawnTime + 3500) > getTime() && isDefined(victim.lastSpawnPoint) && distance(eInflictor.origin, victim.lastSpawnPoint.origin) < 250) {
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
        if((isSubStr(sWeapon, "c4_") || isSubStr(sWeapon, "claymore_")) && isDefined(eAttacker) && isDefined(eInflictor.owner)) {
          victim.explosiveInfo["returnToSender"] = (eInflictor.owner == victim);
          victim.explosiveInfo["counterKill"] = isDefined(eInflictor.wasDamaged);
          victim.explosiveInfo["chainKill"] = isDefined(eInflictor.wasChained);
          victim.explosiveInfo["bulletPenetrationKill"] = isDefined(eInflictor.wasDamagedFromBulletPenetration);
          victim.explosiveInfo["cookedKill"] = false;
        }

        if(isDefined(eAttacker.lastGrenadeSuicideTime) && eAttacker.lastGrenadeSuicideTime >= gettime() - 50 && isFrag) {
          victim.explosiveInfo["suicideGrenadeKill"] = true;
        }
      }

      if(isFrag) {
        victim.explosiveInfo["cookedKill"] = isDefined(eInflictor.isCooked);
        victim.explosiveInfo["throwbackKill"] = isDefined(eInflictor.threwBack);
      }

      victim.explosiveInfo["stickKill"] = isDefined(eInflictor.isStuck) && eInflictor.isStuck == "enemy";
      victim.explosiveInfo["stickFriendlyKill"] = isDefined(eInflictor.isStuck) && eInflictor.isStuck == "friendly";

      if(IsPlayer(eAttacker) && eAttacker != self) {
        self maps\mp\gametypes\_gamelogic::setInflictorStat(eInflictor, eAttacker, sWeapon);
      }
    }

    if((isSubStr(sMeansOfDeath, "MOD_IMPACT")) && (sWeapon == "m320_mp" || isSubStr(sWeapon, "gl") || isSubStr(sWeapon, "gp25"))) {
      if(IsPlayer(eAttacker) && eAttacker != self) {
        self maps\mp\gametypes\_gamelogic::setInflictorStat(eInflictor, eAttacker, sWeapon);
      }
    }

    if(IsPlayer(eAttacker) && isDefined(eAttacker.pers["participation"])) {
      eAttacker.pers["participation"]++;
    } else if(IsPlayer(eAttacker)) {
      eAttacker.pers["participation"] = 1;
    }

    if(attackerIsHittingTeammate) {
      prof_begin("PlayerDamage player");
      if(level.friendlyfire == 0 || (!IsPlayer(eAttacker) && level.friendlyfire != 1)) {
        if(sWeapon == "artillery_mp" || sWeapon == "stealth_bomb_mp") {
          victim damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage, iDFlags, eAttacker);
        }
        return "friendly fire";
      } else if(level.friendlyfire == 1) {
        if(iDamage < 1) {
          iDamage = 1;
        }

        if(victim isJuggernaut()) {
          iDamage = maps\mp\perks\_perks::cac_modified_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
        }

        victim.lastDamageWasFromEnemy = false;

        victim finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
      } else if((level.friendlyfire == 2) && isReallyAlive(eAttacker)) {
        iDamage = int(iDamage * .5);
        if(iDamage < 1) {
          iDamage = 1;
        }

        eAttacker.lastDamageWasFromEnemy = false;

        eAttacker.friendlydamage = true;
        eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
        eAttacker.friendlydamage = undefined;
      } else if(level.friendlyfire == 3 && isReallyAlive(eAttacker)) {
        iDamage = int(iDamage * .5);
        if(iDamage < 1) {
          iDamage = 1;
        }

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

      if(iDamage < 1) {
        iDamage = 1;
      }

      if(isDefined(eAttacker) && IsPlayer(eAttacker)) {
        addAttacker(victim, eAttacker, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
      }

      if(isDefined(eAttacker) && !IsPlayer(eAttacker) && isDefined(eAttacker.owner) && (!isDefined(eAttacker.scrambled) || !eAttacker.scrambled)) {
        addAttacker(victim, eAttacker.owner, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
      } else if(isDefined(eAttacker) && !IsPlayer(eAttacker) && isDefined(eAttacker.secondOwner) && isDefined(eAttacker.scrambled) && eAttacker.scrambled) {
        addAttacker(victim, eAttacker.secondOwner, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath);
      }

      if(sMeansOfDeath == "MOD_EXPLOSIVE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" && iDamage < victim.health) {
        victim notify("survived_explosion", eAttacker);
      }

      if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(sWeapon)) {
        eAttacker thread maps\mp\gametypes\_weapons::checkHit(sWeapon, victim);
      }

      victim.attackerPosition = undefined;

      if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(sWeapon) && eAttacker != victim) {
        victim.attackerPosition = eAttacker.origin;
      }

      if(issubstr(sMeansOfDeath, "MOD_GRENADE") && isDefined(eInflictor) && isDefined(eInflictor.isCooked)) {
        victim.wasCooked = getTime();
      } else {
        victim.wasCooked = undefined;
      }

      if(issubstr(sMeansOfDeath, "MOD_IMPACT") && isDefined(eInflictor) && isDefined(eInflictor.recall) && eInflictor.recall) {
        victim.wasRecall = true;
      } else {
        victim.wasRecall = false;
      }

      victim.lastDamageWasFromEnemy = (isDefined(eAttacker) && (eAttacker != victim));

      if(victim.lastDamageWasFromEnemy) {
        timeStamp = getTime();
        eAttacker.damagedPlayers[victim.guid] = timeStamp;

        victim.lastDamagedTime = timeStamp;
      }

      victim finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);

      victim thread maps\mp\gametypes\_missions::playerDamaged(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc);

      prof_end("PlayerDamage world");
    }

    if(iDamage > 0 && sMeansOfDeath != "MOD_FALLING") {
      victim SetClientOmnvar("ui_damage_flash", true);
    }

    if(attackerIsNPC && isDefined(eAttacker.gunner)) {
      damager = eAttacker.gunner;
    } else {
      damager = eAttacker;
    }

    if(isDefined(damager) && ((damager != victim) || isKillstreakWeapon(sWeapon)) && (iDamage > 0) && (!isDefined(sHitLoc) || sHitLoc != "shield")) {
      if(!isReallyAlive(victim)) {
        if(sHitLoc == "head") {
          typeHit = "killshot_headshot";
        } else {
          typeHit = "killshot";
        }
      } else if(iDFlags &level.iDFLAGS_STUN) {
        typeHit = "stun";
      } else if(sHitLoc == "head") {
        typeHit = "headshot";
      } else if(isDefined(victim.exo_health_on) && victim.exo_health_on == true) {
        typeHit = "hitmorehealth";
      } else if((IsExplosiveDamageMOD(sMeansOfDeath) && victim _hasPerk("_specialty_blastshield"))) {
        typeHit = "hitblastshield";
      } else if(isDefined(victim.lightArmorHP) && sMeansOfDeath != "MOD_HEAD_SHOT" && !isFMJDamage(sWeapon, sMeansOfDeath, eAttacker)) {
        typeHit = "hitlightarmor";
      } else if(victim isJuggernaut()) {
        typeHit = "hitjuggernaut";
      } else if(!shouldWeaponFeedback(sWeapon)) {
        typeHit = "none";
      } else if(sWeapon == "killstreak_solar_mp") {
        typeHit = "mp_solar";
      } else if(sWeapon == "killstreak_laser2_mp") {
        typeHit = "laser";
      } else if(isDefined(victim.exo_health_on) && victim.exo_health_on) {
        typeHit = "hitjuggernaut";
      } else {
        typeHit = "standard";
      }

      damager thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(typeHit);
    }

    maps\mp\gametypes\_gamelogic::setHasDoneCombat(victim, true);
  }

  if(isDefined(eAttacker) && (eAttacker != victim) && !friendly) {
    level.useStartSpawns = false;
  }

  prof_begin("PlayerDamage log");

  if(getDvarInt("g_debugDamage")) {
    PrintLn("client:" + victim GetEntityNumber() + " health:" + victim.health + " attacker:" + eAttacker GetEntityNumber() + " inflictor is player:" + IsPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc + " range:" + Distance(eAttacker.origin, victim.origin));
  }

  if(victim.sessionstate != "dead") {
    lpselfnum = victim getEntityNumber();
    lpselfname = victim.name;
    lpselfteam = victim.pers["team"];
    lpselfGuid = victim.guid;
    lpattackerteam = "";

    if(IsPlayer(eAttacker)) {
      lpattacknum = eAttacker getEntityNumber();
      lpattackGuid = eAttacker.guid;
      lpattackname = eAttacker.name;
      lpattackerteam = eAttacker.pers["team"];
    } else {
      lpattacknum = -1;
      lpattackGuid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }

    if(isPlayer(eAttacker)) {
      attacker_name = eAttacker.name;
      attacker_origin = eAttacker.origin;
      attacker_life_id = eAttacker.lifeId;
    } else {
      attacker_name = "world";
      attacker_origin = victim.origin;
      attacker_life_id = -1;
    }

    gameTime = GetTime();

    if(!isAgent(victim) && isDefined(victim.spawnInfo) && isDefined(victim.spawnInfo.spawnTime)) {
      spawnToDamageReceivedTime = (gameTime - victim.spawnInfo.spawnTime) / 1000.0;

      if(spawnToDamageReceivedTime <= 3.0 && victim.spawnInfo.damageReceivedTooFast == false) {
        if(!isDefined(level.matchData)) {
          level.matchData = [];
        }

        if(!isDefined(level.matchData["badSpawnDmgReceivedCount"])) {
          level.matchData["badSpawnDmgReceivedCount"] = 1;
        } else {
          level.matchData["badSpawnDmgReceivedCount"]++;
        }

        victim.spawnInfo.damageReceivedTooFast = true;

        if(victim.spawnInfo.badSpawn == false) {
          if(!isDefined(level.matchData["badSpawnByAnyMeansCount"])) {
            level.matchData["badSpawnByAnyMeansCount"] = 1;
          } else {
            level.matchData["badSpawnByAnyMeansCount"]++;
          }

          victim.spawnInfo.badSpawn = true;
        }
      }
    } else {
      spawnToDamageReceivedTime = -1;
    }

    if(isDefined(eAttacker) && isDefined(eAttacker.spawnInfo) && isDefined(eAttacker.spawnInfo.spawnTime) && IsPlayer(eAttacker)) {
      spawnToDamageDealtTime = (gameTime - eAttacker.spawnInfo.spawnTime) / 1000.0;

      if(spawnToDamageDealtTime <= 3.0 && eAttacker.spawnInfo.damageDealtTooFast == false) {
        if(!isDefined(level.matchData)) {
          level.matchData = [];
        }

        if(!isDefined(level.matchData["badSpawnDmgDealtCount"])) {
          level.matchData["badSpawnDmgDealtCount"] = 1;
        } else {
          level.matchData["badSpawnDmgDealtCount"]++;
        }

        eAttacker.spawnInfo.damageDealtTooFast = true;

        if(eAttacker.spawnInfo.badSpawn == false) {
          if(!isDefined(level.matchData["badSpawnByAnyMeansCount"])) {
            level.matchData["badSpawnByAnyMeansCount"] = 1;
          } else {
            level.matchData["badSpawnByAnyMeansCount"]++;
          }

          eAttacker.spawnInfo.badSpawn = true;
        }
      }
    } else {
      spawnToDamageDealtTime = -1;
    }

    if(!isAgent(victim)) {
      ReconSpatialEvent(victim.origin, "script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f", victim.name, victim.angles, sHitLoc, attacker_name, attacker_origin, iDamage, sWeapon, sMeansOfDeath, gameTime, victim.lifeId, attacker_life_id, spawnToDamageReceivedTime, spawnToDamageDealtTime);
    }

    logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
  }

  HitlocDebug(eAttacker, victim, iDamage, sHitLoc, iDFlags);

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

addAttacker(victim, eAttacker, eInflictor, sWeapon, iDamage, vPoint, vDir, sHitLoc, psOffsetTime, sMeansOfDeath) {
  if(!isDefined(victim.attackerData)) {
    victim.attackerData = [];
  }

  if(!isDefined(victim.attackerData[eAttacker.guid])) {
    victim.attackers[eAttacker.guid] = eAttacker;

    victim.attackerData[eAttacker.guid] = spawnStruct();
    victim.attackerData[eAttacker.guid].damage = 0;
    victim.attackerData[eAttacker.guid].attackerEnt = eAttacker;
    victim.attackerData[eAttacker.guid].firstTimeDamaged = getTime();
  }
  if(maps\mp\gametypes\_weapons::isPrimaryWeapon(sWeapon) && !maps\mp\gametypes\_weapons::isSideArm(sWeapon)) {
    victim.attackerData[eAttacker.guid].isPrimary = true;
  }

  victim.attackerData[eAttacker.guid].damage += iDamage;
  victim.attackerData[eAttacker.guid].weapon = sWeapon;
  victim.attackerData[eAttacker.guid].vPoint = vPoint;
  victim.attackerData[eAttacker.guid].vDir = vDir;
  victim.attackerData[eAttacker.guid].sHitLoc = sHitLoc;
  victim.attackerData[eAttacker.guid].psOffsetTime = psOffsetTime;
  victim.attackerData[eAttacker.guid].sMeansOfDeath = sMeansOfDeath;
  victim.attackerData[eAttacker.guid].attackerEnt = eAttacker;
  victim.attackerData[eAttacker.guid].lasttimeDamaged = getTime();

  if(isDefined(eInflictor) && !IsPlayer(eInflictor) && isDefined(eInflictor.primaryWeapon)) {
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = eInflictor.primaryWeapon;
  } else if(isDefined(eAttacker) && IsPlayer(eAttacker) && eAttacker getCurrentPrimaryWeapon() != "none") {
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = eAttacker getCurrentPrimaryWeapon();
  } else {
    victim.attackerData[eAttacker.guid].sPrimaryWeapon = undefined;
  }

  if(!isDefined(victim.enemyHitCounts)) {
    victim.enemyHitCounts = [];
  }

  if(IsPlayer(eAttacker)) {
    if(!isDefined(victim.enemyHitCounts[eAttacker.guid])) {
      victim.enemyHitCounts[eAttacker.guid] = 0;
    }

    victim.enemyHitCounts[eAttacker.guid]++;

    victim.lastShotBy = eAttacker.clientid;
  }
}

resetAttackerList() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  clearFirefightData();

  wait(1.75);
  self.attackers = [];
  self.attackerData = [];
}

clearFirefightData() {
  self.enemyHitCounts = [];
  self.currentFirefightShots = 0;
}

clearFirefightShotsOnInterval() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  while(1) {
    wait 3;
    if(isDefined(self.enemyHitCounts) && self.enemyHitCounts.size > 0) {
      continue;
    } else {
      self.currentFirefightShots = 0;
    }
  }
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  result = Callback_PlayerDamage_internal(eInflictor, eAttacker, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}

finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction) {
  remoteKill = false;
  if(((self isUsingRemote()) && (iDamage >= self.health) && !(iDFlags &level.iDFLAGS_STUN) && !isDefined(self.inLivePlayerKillstreak)) && !self IsGod()) {
    remoteKill = true;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    remoteKill = false;
  }

  if(remoteKill || self isRocketCorpse()) {
    if(!isDefined(vDir)) {
      vDir = (0, 0, 0);
    }

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

    if(isPlayer(self)) {
      result = self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
      if(isDefined(result)) {
        self thread FinishPlayerDamage_ImpactFXWrapper(result[0], result[1], result[2], result[3], result[4], result[5], result[6]);
      }
    }
  }

  if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET") {
    self shellShock("damage_mp", getDvarFloat("scr_csmode"));
  }

  self damageShellshockAndRumble(eInflictor, sWeapon, sMeansOfDeath, iDamage, iDFlags, eAttacker);
}

FinishPlayerDamage_ImpactFXWrapper(attacker, mod, weapon, hitloc, point, dir, localdir) {
  waittillframeend;

  if(!isDefined(self) || !isDefined(attacker)) {
    return;
  }

  self FinishPlayerDamage_ImpactFX(attacker, mod, weapon, hitloc, point, dir, localdir);
}

Callback_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  lastStandParams = spawnStruct();
  lastStandParams.eInflictor = eInflictor;
  lastStandParams.attacker = attacker;
  lastStandParams.iDamage = iDamage;
  lastStandParams.attackerPosition = attacker.origin;
  if(attacker == self) {
    lastStandParams.sMeansOfDeath = "MOD_SUICIDE";
  } else {
    lastStandParams.sMeansOfDeath = sMeansOfDeath;
  }

  lastStandParams.sWeapon = sWeapon;
  if(isDefined(attacker) && IsPlayer(attacker) && attacker getCurrentPrimaryWeapon() != "none") {
    lastStandParams.sPrimaryWeapon = attacker getCurrentPrimaryWeapon();
  } else {
    lastStandParams.sPrimaryWeapon = undefined;
  }
  lastStandParams.vDir = vDir;
  lastStandParams.sHitLoc = sHitLoc;
  lastStandParams.lastStandStartTime = getTime();

  mayDoLastStand = mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc);

  if(isDefined(self.endGame)) {
    mayDoLastStand = false;
  }

  if(level.teamBased && isDefined(attacker.team) && attacker.team == self.team) {
    mayDoLastStand = false;
  }

  if(level.dieHardMode) {
    if(level.teamCount[self.team] <= 1) {
      mayDoLastStand = false;
    } else if(self isTeamInLastStand()) {
      mayDoLastStand = false;
      killTeamInLastStand(self.team);
    }

  }

  if(getdvar("scr_forcelaststand") == "1") {
    mayDoLastStand = true;
  }

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
    notifyData.iconName = level.specialty_finalstand_icon;
  } else {
    notifyData.titleText = game["strings"]["last_stand"];
    notifyData.iconName = level.specialty_finalstand_icon;
  }
  notifyData.glowColor = (1, 0, 0);
  notifyData.sound = "mp_last_stand";
  notifyData.duration = 2.0;

  self.health = 1;

  self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);

  grenadeTypePrimary = "frag_grenade_mp";

  if(self _hasPerk("specialty_finalstand")) {
    self.lastStandParams = lastStandParams;
    self.inFinalStand = true;

    weaponList = self GetWeaponsListExclusives();
    foreach(weapon in weaponList) {
      self takeWeapon(weapon);
    }

    self _disableUsability();

    self thread enableLastStandWeapons();
    self thread lastStandTimer(20, true);
  } else if(level.dieHardMode) {
    attacker thread maps\mp\_events::killedPlayerEvent(self, sWeapon, sMeansOfDeath);
    self.lastStandParams = lastStandParams;

    self _DisableWeapon();

    self thread lastStandTimer(20, false);
    self _disableUsability();
  } else {
    self.lastStandParams = lastStandParams;

    pistolWeapon = undefined;

    weaponsList = self GetWeaponsListPrimaries();
    foreach(weapon in weaponsList) {
      if(maps\mp\gametypes\_weapons::isSideArm(weapon)) {
        pistolWeapon = weapon;
      }
    }

    if(!isDefined(pistolWeapon)) {
      pistolWeapon = "iw6_p226_mp";
      self _giveWeapon(pistolWeapon);
    }

    self giveMaxAmmo(pistolWeapon);
    self DisableWeaponSwitch();
    self _disableUsability();

    if(!self _hasPerk("specialty_laststandoffhand")) {
      self DisableOffhandWeapons();
    }

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
  self.c4DeathEffect = playFX(level.c4Death, self.origin);
  RadiusDamage(self.origin, 312, 100, 100, self);

  if(isAlive(self)) {
    self _suicide();
  }
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
    self setLowerMessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, true);
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

      if(self.inFinalStand) {
        self thread lastStandBleedOut(isFinalStand, reviveEnt);
      }
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

      if(self.inFinalStand) {
        self thread lastStandBleedOut(isFinalStand, reviveEnt);
      }
    }

    wait delay / 3;
    reviveIcon.color = (1.0, 0.64, 0.0);

    while(reviveEnt.inUse) {
      wait(0.05);
    }

    self playDeathSound();
    wait delay / 3;
    reviveIcon.color = (1.0, 0.0, 0.0);

    while(reviveEnt.inUse) {
      wait(0.05);
    }

    self playDeathSound();
    wait delay / 3;

    while(reviveEnt.inUse) {
      wait(0.05);
    }

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

    if(isDefined(reviveEnt)) {
      reviveEnt Delete();
    }
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
  if(sMeansOfDeath == "MOD_TRIGGER_HURT") {
    return false;
  }

  if(sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_FALLING" && sMeansOfDeath != "MOD_EXPLOSIVE_BULLET") {
    return false;
  }

  if(sMeansOfDeath == "MOD_IMPACT" && (sWeapon == "throwingknife_mp" || sWeapon == "throwingknifejugg_mp")) {
    return false;
  }

  if(sMeansOfDeath == "MOD_IMPACT" && (sWeapon == "m79_mp" || isSubStr(sWeapon, "gl_"))) {
    return false;
  }

  if(isHeadShot(sWeapon, sHitLoc, sMeansOfDeath)) {
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  return true;
}

ensureLastStandParamsValidity() {
  if(!isDefined(self.lastStandParams.attacker)) {
    self.lastStandParams.attacker = self;
  }
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

getHitLocTag(sHitLoc) {
  switch (sHitLoc) {
    case "helmet":
      return "j_neck";
    case "head":
      return "j_neck";
    case "neck":
      return "j_neck";
    case "torso_upper":
      return "j_neck";
    case "right_arm_upper":
      return "J_Shoulder_RI";
    case "left_arm_upper":
      return "J_Shoulder_LE";
    case "right_arm_lower":
      return "J_Elbow_RI";
    case "left_arm_lower":
      return "J_Elbow_LE";
    case "right_hand":
      return "J_Wrist_RI";
    case "left_hand":
      return "J_Wrist_LE";
    case "gun":
      return "J_Wrist_RI";
    case "torso_lower":
      return "J_SpineLower";
    case "right_leg_upper":
      return "J_Hip_RI";
    case "left_leg_upper":
      return "J_Hip_LE";
    case "right_leg_lower":
      return "J_Knee_RI";
    case "left_leg_lower":
      return "J_Knee_LE";
    case "right_foot":
      return "J_Ankle_RI";
    case "left_foot":
      return "J_Ankle_LE";
  }
  return undefined;
}

delayStartRagdoll(ent, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath) {
  if(isDefined(ent)) {
    deathAnim = ent getCorpseAnim();
    if(animhasnotetrack(deathAnim, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noRagdollEnts) && level.noRagdollEnts.size) {
    foreach(noRag in level.noRagdollEnts) {
      if(distanceSquared(ent.origin, noRag.origin) < 65536) {
        return;
      }
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
    if(isDefined(times)) {
      startFrac = times[0];
    }
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
  self PlayRumbleOnEntity("sniper_fire");
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
    if(team == player.team && player != self.owner) {
      self enablePlayerUse(player);
    } else {
      self disablePlayerUse(player);
    }
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

    revived = self reviveHoldThink(player);
    self.owner.beingRevived = false;

    if(!isAlive(self.owner)) {
      self delete();
      return;
    }

    self.owner freezeControlsWrapper(false);

    if(revived) {
      level thread maps\mp\gametypes\_rank::awardGameEvent("reviver", player);

      self.owner.lastStand = undefined;
      self.owner clearLowerMessage("last_stand");

      self.owner.moveSpeedScaler = level.basePlayerMoveScale;
      if(self.owner _hasPerk("specialty_lightweight")) {
        self.owner.moveSpeedScaler = lightWeightScalar();
      }

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

reviveHoldThink(player, useTime, shouldDisableWeapons) {
  DEFAULT_USE_TIME = 3000;

  reviveSpot = spawn("script_origin", self.origin);
  reviveSpot hide();
  player playerLinkTo(reviveSpot);
  player PlayerLinkedOffsetEnable();

  if(!isDefined(shouldDisableWeapons)) {
    shouldDisableWeapons = true;
  }

  if(shouldDisableWeapons) {
    player _disableWeapon();
  }

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isDefined(useTime)) {
    self.useTime = useTime;
  } else {
    self.useTime = DEFAULT_USE_TIME;
  }

  player thread personalUseBar(self);
  self thread reviveHoldThink_cleanup(player, shouldDisableWeapons, reviveSpot);

  result = reviveHoldThinkLoop(player);

  self.inUse = false;
  reviveSpot Delete();

  if(isDefined(result) && result) {
    self.owner thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("revived", player);
    self.owner.inlaststand = false;
    return true;
  }

  return false;
}

reviveHoldThink_cleanup(player, enable_weapons, reviveSpot) {
  waittill_any_ents(self, "death", reviveSpot, "death");

  if(!IsRemovedEntity(reviveSpot)) {
    reviveSpot Delete();
  }
  if(isDefined(player) && isReallyAlive(player)) {
    player Unlink();
    if(enable_weapons) {
      player _enableWeapon();
    }
  }
}

personalUseBar(object) {
  useBar = self createPrimaryProgressBar();
  useBarText = self createPrimaryProgressBarText();
  useBarText setText(&"MPUI_REVIVING");

  objUseBar = object.owner createPrimaryProgressBar();
  objUseBarText = object.owner createPrimaryProgressBarText();
  objUseBarText setText(&"MPUI_BEING_REVIVED");

  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && object.inUse && !level.gameEnded && isDefined(self)) {
    if(lastRate != object.useRate) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }

      useBar updateBar(object.curProgress / object.useTime, (1000 / object.useTime) * object.useRate);
      objUseBar updateBar(object.curProgress / object.useTime, (1000 / object.useTime) * object.useRate);

      if(!object.useRate) {
        useBar hideElem();
        useBarText hideElem();

        objUseBar hideElem();
        objUseBarText hideElem();
      } else {
        useBar showElem();
        useBarText showElem();

        objUseBar showElem();
        objUseBarText showElem();
      }
    }
    lastRate = object.useRate;
    wait(0.05);
  }

  if(isDefined(useBar)) {
    useBar destroyElem();
  }
  if(isDefined(useBarText)) {
    useBarText destroyElem();
  }

  if(isDefined(objUseBar)) {
    objUseBar destroyElem();
  }
  if(isDefined(objUseBarText)) {
    objUseBarText destroyElem();
  }
}

reviveHoldThinkLoop(player) {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("disconnect");

  while(isReallyAlive(player) && player useButtonPressed() && self.curProgress < self.useTime && !(isDefined(player.inLastStand) && player.inLastStand)) {
    self.curProgress += (50 * self.useRate);
    self.useRate = 1;

    if(self.curProgress >= self.useTime) {
      self.inUse = false;

      return isReallyAlive(player);
    }

    wait 0.05;
  }

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

    if(isDefined(traceData["entity"]) && isDefined(traceData["entity"].targetname) && (traceData["entity"].targetname == "destructible_vehicle" || traceData["entity"].targetname == "destructible_toy")) {
      damageEnts[damageEnts.size] = traceData["entity"];
    }
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

_obituary(victim, attacker, sWeapon, sMeansOfDeath) {
  victimTeam = victim.team;

  foreach(player in level.players) {
    playerTeam = player.team;
    if(playerTeam == "spectator") {
      player iPrintLn(&"MP_OBITUARY_NEUTRAL", attacker.name, victim.name);
    } else if(playerTeam == victimTeam) {
      player iPrintLn(&"MP_OBITUARY_ENEMY", attacker.name, victim.name);
    } else {
      player iPrintLn(&"MP_OBITUARY_FRIENDLY", attacker.name, victim.name);
    }
  }
}

logPrintPlayerDeath(lifeId, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc) {
  lpselfnum = self getEntityNumber();
  lpselfname = self.name;
  lpselfteam = self.team;
  lpselfguid = self.guid;

  if(IsPlayer(attacker)) {
    lpattackGuid = attacker.guid;
    lpattackname = attacker.name;
    lpattackerteam = attacker.team;
    lpattacknum = attacker getEntityNumber();
    attackerString = attacker.xuid + "(" + lpattackname + ")";
  } else {
    lpattackGuid = "";
    lpattackname = "";
    lpattackerteam = "world";
    lpattacknum = -1;
    attackerString = "none";
  }

  logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
}

destroyOnReviveEntDeath(reviveEnt) {
  reviveEnt waittill("death");

  self destroy();
}

gamemodeModifyPlayerDamage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc) {
  if(isDefined(eAttacker) && IsPlayer(eAttacker) && isAlive(eAttacker)) {
    if(level.matchRules_damageMultiplier) {
      iDamage *= level.matchRules_damageMultiplier;
    }

    if(level.matchRules_vampirism) {
      eAttacker.health = int(min(float(eAttacker.maxHealth), float(eAttacker.health + 20)));
    }
  }

  return iDamage;
}

setEntityDamageCallback(maxHealth, damageFeedback, onDeathFunc, modifyDamageFunc, bIsKillstreak) {
  if(!isDefined(bIsKillstreak)) {
    bIsKillstreak = false;
  }

  if(!isDefined(damageFeedback)) {
    damageFeedback = "normal";
  }

  if(!isDefined(modifyDamageFunc)) {
    modifyDamageFunc = ::modifyDamage;
  }

  self setCanDamage(true);

  if(isDefined(self.classname) && (self.classname != "script_vehicle")) {
    self SetDamageCallbackOn(true);
  }

  self.health = 999999;
  self.maxHealth = maxHealth;
  self.damageTaken = 0;

  self.bIsKillstreak = bIsKillstreak;
  self.damageFeedback = damageFeedback;
  self.damageCallback = ::processDamageTaken;
  self.modifyDamageFunc = modifyDamageFunc;
  self.onDeathFunc = onDeathFunc;
  self.attackerList = [];
}

processDamageTaken(inflictor, attacker, damage, iDFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  if(!isDefined(self)) {
    return;
  }

  if(!(isDefined(level.isHorde) && level.isHorde) && !(isDefined(level.isZombieGame) && level.isZombieGame) && isDefined(attacker) && !IsGameParticipant(attacker)) {
    return;
  }

  if(isDefined(attacker) && !maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
    return;
  }

  attacker PlayRumbleOnEntity("damage_light");

  if(isDefined(self.isCrashing) && self.isCrashing) {
    return;
  }

  if(isDefined(self.isLeaving) && self.isLeaving) {
    return;
  }

  if(isDefined(self.stopDamageFunc) && self.stopDamageFunc) {
    return;
  }

  modifiedDamage = damage;

  if(isDefined(weapon)) {
    shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

    switch (shortWeapon) {
      case "paint_grenade_mp":
      case "paint_grenade_var_mp":
      case "smoke_grenade_mp":
      case "smoke_grenade_var_mp":
        return;
    }

    if(isDefined(level.isHorde) && level.isHorde) {
      self.damageloc = partName;
    }
    modifiedDamage = [[self.modifyDamageFunc]](attacker, weapon, meansOfDeath, damage);
    if(isDefined(level.isHorde) && level.isHorde) {
      self.damageloc = undefined;
    }
  }

  if(modifiedDamage < 0) {
    return true;
  }

  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
    self.wasDamagedFromBulletPenetration = true;
  }

  self.wasDamaged = true;
  self.damageTaken += modifiedDamage;

  maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);

  if(isDefined(attacker) && IsPlayer(attacker)) {
    attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(self.damageFeedback);

    if(self isNewAttacker(attacker)) {
      self.attackerList[self.attackerList.size] = attacker;
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    if(self.bIsKillstreak && IsPlayer(attacker)) {
      attacker notify("destroyed_killstreak", weapon);
    }

    if(self.classname == "script_vehicle" || self.classname == "script_model") {
      baseWeapon = getBaseWeaponName(weapon);
      if(isLootWeapon(baseWeapon)) {
        baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
      }

      weapon_class = maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);

      if(isDefined(self.model) && weapon_class == "weapon_launcher") {
        if(isSubStr(self.model, "uav")) {
          if(isDefined(level.challengeInfo["ch_uav_" + baseWeapon]))
        }
        attacker maps\mp\gametypes\_missions::processChallenge("ch_uav_" + baseWeapon);
        if(isSubStr(self.model, "warbird")) {
          if(isDefined(level.challengeInfo["ch_warbird_" + baseWeapon]))
        }
        attacker maps\mp\gametypes\_missions::processChallenge("ch_warbird_" + baseWeapon);
        if(isSubStr(self.model, "orbital_platform")) {
          if(isDefined(level.challengeInfo["ch_paladin_" + baseWeapon]))
        }
        attacker maps\mp\gametypes\_missions::processChallenge("ch_paladin_" + baseWeapon);
        if(isSubStr(self.model, "drone") && !isSubStr(self.model, "uav")) {
          if(isDefined(level.challengeInfo["ch_drone_" + baseWeapon]))
        }
        attacker maps\mp\gametypes\_missions::processChallenge("ch_drone_" + baseWeapon);
      }
    }
    self.stopDamageFunc = true;
    self thread[[self.onDeathFunc]](attacker, weapon, meansOfDeath, damage);
  }
}

isNewAttacker(attacker) {
  foreach(previousAttacker in self.attackerList) {
    if(attacker == previousAttacker) {
      return false;
    }
  }

  return true;
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleEmpDamage(weapon, type, modifiedDamage, attacker);
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleMissileDamage(weapon, damageType, damage) {
  actualDamage = damage;
  switch (weapon) {
    case "bomb_site_mp":
    case "remotemissile_projectile_mp":
    case "remotemissile_projectile_gas_mp":
    case "remotemissile_projectile_cluster_parent_mp":
    case "remotemissile_projectile_cluster_child_mp":
    case "remotemissile_projectile_cluster_child_hellfire_mp":
    case "remotemissile_projectile_secondary_mp":
    case "stinger_mp":
    case "warbird_missile_mp":
    case "stealth_bomb_mp":
    case "airstrike_missile_mp":
    case "orbitalsupport_105mm_mp":
    case "orbitalsupport_missile_mp":
    case "dam_turret_mp":
    case "orbital_carepackage_pod_mp":
    case "orbital_carepackage_droppod_mp":
    case "orbital_carepackage_pod_plane_mp":
      self.largeProjectileDamage = true;
      actualDamage = self.maxHealth + 1;
      break;
    case "killstreak_laser2_mp":
      self.largeProjectileDamage = true;
      attackers = level.sentryGun.ownerList;
      mult = 0.34;
      if(isDefined(attackers) && attackers.size > 0) {
        mod = attackers.size;
        if(attackers.size >= 3) {
          mod = 3;
        }
        mult = mult * mod;
      }
      actualDamage = self.maxHealth * mult;
      break;
    case "ugv_missile_mp":
    case "assaultdrone_c4_mp":
    case "killstreak_orbital_laser_mp":
    case "killstreakmahem_mp":
    case "turretheadrocket_mp":
      self.largeProjectileDamage = false;
      actualDamage = self.maxHealth + 1;
      break;
    case "orbitalsupport_40mm_mp":
    case "orbitalsupport_40mmbuddy_mp":
      self.largeProjectileDamage = false;
      actualDamage *= 2;
      break;
  }

  return actualDamage;
}

handleGrenadeDamage(weapon, damageType, modifiedDamage) {
  shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

  if(shortWeapon == "stun_grenade_mp" || shortWeapon == "stun_grenade_var_mp" || shortWeapon == "stun_grenade_horde_mp") {
    self notify("concussed");
    return 0;
  } else if(IsExplosiveDamageMOD(damageType)) {
    switch (shortWeapon) {
      case "explosive_drone_mp":
      case "frag_grenade_mp":
      case "semtex_mp":
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

handleMeleeDamage(weapon, damageType, damage) {
  if(isMeleeMOD(damageType)) {
    newMeleeDamage = int(self.maxHealth / 3) + 1;

    if(newMeleeDamage > damage) {
      return newMeleeDamage;
    }
  }

  return damage;
}

handleEmpDamage(weapon, damageType, damage, attacker) {
  shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

  if((shortWeapon == "emp_grenade_mp" || shortWeapon == "emp_grenade_var_mp" || shortWeapon == "emp_grenade_killstreak_mp") && (damageType == "MOD_GRENADE_SPLASH" || damageType == "MOD_GRENADE")) {
    self notify("emp_damage", attacker, 8.0);
    return 0;
  }

  return damage;
}

handleAPDamage(weapon, damageType, damage, attacker) {
  if(damageType == "MOD_RIFLE_BULLET" || damageType == "MOD_PISTOL_BULLET") {
    if(attacker _hasPerk("specialty_armorpiercing") || isFMJDamage(weapon, damageType, attacker)) {
      return damage * level.armorPiercingMod;
    }
  }

  return damage;
}

onKillstreakKilled(attacker, weapon, damageType, damage, xpEvent, leaderDialog, teamCardSplash, isVehicle) {
  validAttacker = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && IsPlayer(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(attacker == self.owner) {
      return;
    }

    if(!IsAlliedSentient(self.owner, attacker)) {
      validAttacker = attacker;
    }
  }

  if(isDefined(validAttacker)) {
    validAttacker notify("destroyed_killstreak", weapon);
    validAttacker incPlayerStat(xpEvent, 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent(xpEvent, validAttacker, weapon, undefined, damageType);

    if(isDefined(weapon) && weapon == "killstreak_laser2_mp" && isDefined(level.sentryGun) && isDefined(level.sentryGun.ownerList)) {
      foreach(owner in level.sentryGun.ownerList) {
        if(owner != validAttacker) {
          owner notify("destroyed_killstreak", weapon);
          owner incPlayerStat(xpEvent, 1);
          level thread maps\mp\gametypes\_rank::awardGameEvent(xpEvent, owner, weapon, undefined, damageType);
        }
      }
    }

    if(isDefined(teamCardSplash)) {
      level thread teamPlayerCardSplash(teamCardSplash, validAttacker);
    }

    if(isDefined(isVehicle) && isVehicle) {
      level thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, validAttacker, damage, damageType, weapon);
    }

  }

  self thread maps\mp\_events::checkVandalismMedal(validAttacker);

  if(isDefined(self.owner) && isDefined(leaderDialog)) {
    self.owner thread leaderDialogOnPlayer(leaderDialog, undefined, undefined, self.origin);
  }
}