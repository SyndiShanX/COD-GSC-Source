/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_callbacksetup.gsc
*****************************************************/

CodeCallback_StartGameType() {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [
      [level.callbackStartGameType]
    ]();
    level.gametypestarted = true;
  }
}

CodeCallback_PlayerConnect() {
  self endon("disconnect");
  [[level.callbackPlayerConnect]]();
}

CodeCallback_PlayerDisconnect() {
  self notify("disconnect");
  client_num = self getentitynumber();
  maps\mp\_ambientpackage::tidyup_triggers(client_num);
  [[level.callbackPlayerDisconnect]]();
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  self endon("disconnect");
  [[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self endon("disconnect");
  [[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self endon("disconnect");
  [[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_ActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  [[level.callbackActorDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

CodeCallback_ActorKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset) {
  [[level.callbackActorKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset);
}

CodeCallback_VehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName) {
  [[level.callbackVehicleDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName);
}

CodeCallback_VehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, timeOffset) {
  [[level.callbackVehicleRadiusDamage]](eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, timeOffset);
}

SetupCallbacks() {
  SetDefaultCallbacks();
  level.iDFLAGS_RADIUS = 1;
  level.iDFLAGS_NO_ARMOR = 2;
  level.iDFLAGS_NO_KNOCKBACK = 4;
  level.iDFLAGS_PENETRATION = 8;
  level.iDFLAGS_NO_TEAM_PROTECTION = 16;
  level.iDFLAGS_NO_PROTECTION = 32;
  level.iDFLAGS_PASSTHRU = 64;
}

SetDefaultCallbacks() {
  level.callbackStartGameType = maps\mp\gametypes\_globallogic::Callback_StartGameType;
  level.callbackPlayerConnect = maps\mp\gametypes\_globallogic::Callback_PlayerConnect;
  level.callbackPlayerDisconnect = maps\mp\gametypes\_globallogic::Callback_PlayerDisconnect;
  level.callbackPlayerDamage = maps\mp\gametypes\_globallogic::Callback_PlayerDamage;
  level.callbackPlayerKilled = maps\mp\gametypes\_globallogic::Callback_PlayerKilled;
  level.callbackPlayerLastStand = maps\mp\gametypes\_globallogic::Callback_PlayerLastStand;
  level.callbackActorDamage = maps\mp\gametypes\_globallogic::Callback_ActorDamage;
  level.callbackActorKilled = maps\mp\gametypes\_globallogic::Callback_ActorKilled;
  level.callbackVehicleDamage = maps\mp\gametypes\_globallogic::Callback_VehicleDamage;
  level.callbackVehicleRadiusDamage = maps\mp\gametypes\_globallogic::Callback_VehicleRadiusDamage;
  level.callbackPlayerSpawnGenerateInfluencers = maps\mp\gametypes\_globallogic::Callback_PlayerSpawnGenerateInfluencers;
  level.callbackPlayerSpawnGenerateSpawnPointEntityBaseScore = maps\mp\gametypes\_globallogic::Callback_PlayerSpawnGenerateSpawnPointEntityBaseScore;
}

AbortLevel() {
  println("Aborting level - gametype is not supported");
  level.callbackStartGameType = ::callbackVoid;
  level.callbackPlayerConnect = ::callbackVoid;
  level.callbackPlayerDisconnect = ::callbackVoid;
  level.callbackPlayerDamage = ::callbackVoid;
  level.callbackPlayerKilled = ::callbackVoid;
  level.callbackPlayerLastStand = ::callbackVoid;
  level.callbackActorDamage = ::callbackVoid;
  level.callbackActorKilled = ::callbackVoid;
  level.callbackVehicleDamage = ::callbackVoid;
  level.callbackPlayerSpawnGenerateInfluencers = ::callbackVoid;
  level.callbackPlayerSpawnGenerateSpawnPointEntityBaseScore = ::callbackVoid;
  setdvar("g_gametype", "dm");
  exitLevel(false);
}

callbackVoid() {}