/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_callbacksetup.gsc
***************************************************/

CodeCallback_StartGameType() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackStartGameType]]();

    level.gametypestarted = true;
  }
}

CodeCallback_PlayerConnect() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackPlayerConnect]]();
}

CodeCallback_PlayerDisconnect(reason) {
  self notify("disconnect");
  [[level.callbackPlayerDisconnect]](reason);
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  self endon("disconnect");
  [[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self endon("disconnect");
  [[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_PlayerGrenadeSuicide(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset) {
  self endon("disconnect");
  [[level.callbackPlayerGrenadeSuicide]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset);
}

CodeCallback_EntityOutOfWorld() {
  self endon("disconnect");
  [[level.callbackEntityOutOfWorld]]();
}

CodeCallback_BulletHitEntity(weapon, hit_pos, hit_normal, hit_ent, dir, part_name) {
  self endon("disconnect");
  if(isDefined(self.bulletHitCallback)) {
    [[self.bulletHitCallback]](weapon, hit_pos, hit_normal, hit_ent, dir, part_name);
  }
}

CodeCallback_VehicleDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  if(isDefined(self.damageCallback)) {
    self[[self.damageCallback]](inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
  } else {
    self Vehicle_FinishDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
  }
}

CodeCallback_EntityDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  if(isDefined(self.damageCallback)) {
    self[[self.damageCallback]](inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
  } else {
    self FinishEntityDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
  }
}

CodeCallback_CodeEndGame() {
  self endon("disconnect");
  [[level.callbackCodeEndGame]]();
}

CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self endon("disconnect");
  [[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_PlayerMigrated() {
  self endon("disconnect");
  [[level.callbackPlayerMigrated]]();
}

CodeCallback_HostMigration() {
  [[level.callbackHostMigration]]();
}

CodeCallback_GiveKillstreak(player, streakName) {
  if(IsBot(player) || IsTestClient(player) || player.team == "spectator" || player.sessionstate == "spectator") {
    return;
  }

  if((isDefined(level.killstreakFuncs[streakName]) && tableLookup("mp/killstreakTable.csv", 1, streakName, 0) != "") || IsSubStr(streakName, "turrethead")) {
    if(IsSubStr(streakName, "turrethead")) {
      player thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead(streakName);
      PrintLn("Player " + player GetEntityNumber() + ": given scorestreak - ripped_turret:" + streakName);
    } else {
      streakVal = player maps\mp\killstreaks\_killstreaks::getStreakCost(streakName);
      streakModules = player maps\mp\killstreaks\_killstreaks::getKillStreakModules(player, streakName);

      slotIndex = player maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex(streakName);
      player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal, undefined, streakModules, slotIndex);
      player maps\mp\killstreaks\_killstreaks::giveKillstreak(streakName);
      PrintLn("Player " + player GetEntityNumber() + ": given scorestreak - " + streakName);
    }
  }
}

CodeCallback_GiveKillstreakModule(player, moduleName) {
  if(IsBot(player) || IsTestClient(player) || player.team == "spectator" || player.sessionstate == "spectator") {
    return;
  }

  baseStreak = maps\mp\killstreaks\_killstreaks::getStreakModuleBaseKillstreak(moduleName);
  if(isDefined(baseStreak) && baseStreak != "") {
    if(!isDefined(player.killStreakModules[moduleName])) {
      cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(moduleName);
      player.killStreakModules[moduleName] = cost;
      PrintLn("Player " + player GetEntityNumber() + ": module - " + moduleName + " ON");
    } else {
      player.killStreakModules[moduleName] = undefined;
      PrintLn("Player " + player GetEntityNumber() + ": module - " + moduleName + " OFF");
    }
  }
}

CodeCallback_PartyMembers(loadouts) {
  if(isDefined(level.PartyMembers_cb)) {
    [[level.PartyMembers_cb]](loadouts);
  }
}

SetupDamageFlags() {
  level.iDFLAGS_RADIUS = 1;
  level.iDFLAGS_NO_ARMOR = 2;
  level.iDFLAGS_NO_KNOCKBACK = 4;
  level.iDFLAGS_PENETRATION = 8;
  level.iDFLAGS_STUN = 16;
  level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT = 32;
  level.iDFLAGS_SHIELD_EXPLOSIVE_IMPACT_HUGE = 64;
  level.iDFLAGS_SHIELD_EXPLOSIVE_SPLASH = 128;

  level.iDFLAGS_NO_TEAM_PROTECTION = 256;
  level.iDFLAGS_NO_PROTECTION = 512;
  level.iDFLAGS_PASSTHRU = 1024;
}

SetupCallbacks() {
  SetDefaultCallbacks();
  SetupDamageFlags();
}

SetDefaultCallbacks() {
  level.callbackStartGameType = maps\mp\gametypes\_gamelogic::Callback_StartGameType;
  level.callbackPlayerConnect = maps\mp\gametypes\_playerlogic::Callback_PlayerConnect;
  level.callbackPlayerDisconnect = maps\mp\gametypes\_playerlogic::Callback_PlayerDisconnect;
  level.callbackPlayerDamage = maps\mp\gametypes\_damage::Callback_PlayerDamage;
  level.callbackPlayerKilled = maps\mp\gametypes\_damage::Callback_PlayerKilled;
  level.callbackEntityOutOfWorld = maps\mp\gametypes\_damage::Callback_EntityOutOfWorld;
  level.callbackPlayerGrenadeSuicide = maps\mp\gametypes\_damage::Callback_PlayerGrenadeSuicide;
  level.callbackCodeEndGame = maps\mp\gametypes\_gamelogic::Callback_CodeEndGame;
  level.callbackPlayerLastStand = maps\mp\gametypes\_damage::Callback_PlayerLastStand;
  level.callbackPlayerMigrated = maps\mp\gametypes\_playerlogic::Callback_PlayerMigrated;
  level.callbackHostMigration = maps\mp\gametypes\_hostmigration::Callback_HostMigration;
}

AbortLevel() {
  println("Aborting level - gametype is not supported");

  level.callbackStartGameType = ::callbackVoid;
  level.callbackPlayerConnect = ::callbackVoid;
  level.callbackPlayerDisconnect = ::callbackVoid;
  level.callbackPlayerDamage = ::callbackVoid;
  level.callbackPlayerKilled = ::callbackVoid;
  level.callbackEntityOutOfWorld = ::callbackVoid;
  level.callbackPlayerGrenadeSuicide = ::callbackVoid;
  level.callbackCodeEndGame = ::callbackVoid;
  level.callbackPlayerLastStand = ::callbackVoid;
  level.callbackPlayerMigrated = ::callbackVoid;
  level.callbackHostMigration = ::callbackVoid;

  setDvar("g_gametype", "dm");

  exitLevel(false);
}

callbackVoid() {}