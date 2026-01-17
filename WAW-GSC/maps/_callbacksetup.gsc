/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_callbacksetup.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;

CodeCallback_StartGameType() {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackStartGameType]]();
    level.gametypestarted = true;
  }
}

CodeCallback_PlayerConnect() {
  self endon("disconnect");
  println("****Coop CodeCallback_PlayerConnect****");
  if(GetDvar("r_reflectionProbeGenerate") == "1") {
    maps\_callbackglobal::Callback_PlayerConnect();
    return;
  }
  if(!isDefined(level.callbackPlayerConnect)) {
    println("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::Callback_PlayerConnect();
    return;
  }
  [[level.callbackPlayerConnect]]();
}

CodeCallback_PlayerDisconnect() {
  self notify("disconnect");
  level notify("player_disconnected");
  client_num = self getentitynumber();
  maps\_ambientpackage::tidyup_triggers(client_num);
  println("****Coop CodeCallback_PlayerDisconnect****");
  if(!isDefined(level.callbackPlayerDisconnect)) {
    println("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::Callback_PlayerDisconnect();
    return;
  }
  [[level.callbackPlayerDisconnect]]();
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, iModelIndex, timeOffset) {
  self endon("disconnect");
  println("****Coop CodeCallback_PlayerDamage****");
  if(!isDefined(level.callbackPlayerDamage)) {
    println("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::Callback_PlayerDamage();
    return;
  }
  [[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, iModelIndex, timeOffset);
}

CodeCallback_PlayerRevive() {
  self endon("disconnect");
  [[level.callbackPlayerRevive]]();
}

CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self endon("disconnect");
  [[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
}

CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self endon("disconnect");
  println("****Coop CodeCallback_PlayerKilled****");
  println("----> Spawn 2 ");
  if(!isDefined(level.callbackPlayerKilled)) {
    println("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::Callback_PlayerKilled();
    return;
  }
  [[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_SaveRestored() {
  self endon("disconnect");
  println("****Coop CodeCallback_SaveRestored****");
  if(!isDefined(level.callbackSaveRestored)) {
    println("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::Callback_SaveRestored();
    return;
  }
  [[level.callbackSaveRestored]]();
}

CodeCallback_DisconnectedDuringLoad(name) {
  if(!isDefined(level._disconnected_clients)) {
    level._disconnected_clients = [];
  }
  level._disconnected_clients[level._disconnected_clients.size] = name;
}

CodeCallback_LevelNotify(level_notify) {
  level notify(level_notify);
}

SetupCallbacks() {
  thread maps\_callbackglobal::SetupCallbacks();
  SetDefaultCallbacks();
  level.iDFLAGS_RADIUS = 1;
  level.iDFLAGS_NO_ARMOR = 2;
  level.iDFLAGS_NO_KNOCKBACK = 4;
  level.iDFLAGS_NO_TEAM_PROTECTION = 8;
  level.iDFLAGS_NO_PROTECTION = 16;
  level.iDFLAGS_PASSTHRU = 32;
}

SetDefaultCallbacks() {
  level.callbackStartGameType = maps\_callbackglobal::Callback_StartGameType;
  level.callbackSaveRestored = maps\_callbackglobal::Callback_SaveRestored;
  level.callbackPlayerConnect = maps\_callbackglobal::Callback_PlayerConnect;
  level.callbackPlayerDisconnect = maps\_callbackglobal::Callback_PlayerDisconnect;
  level.callbackPlayerDamage = maps\_callbackglobal::Callback_PlayerDamage;
  level.callbackPlayerKilled = maps\_callbackglobal::Callback_PlayerKilled;
  level.callbackPlayerLastStand = maps\_callbackglobal::Callback_PlayerLastStand;
}

AbortLevel() {
  println("Aborting level - gametype is not supported");
  level.callbackSaveRestored = ::callbackVoid;
  level.callbackStartGameType = ::callbackVoid;
  level.callbackPlayerConnect = ::callbackVoid;
  level.callbackPlayerDisconnect = ::callbackVoid;
  level.callbackPlayerDamage = ::callbackVoid;
  level.callbackPlayerKilled = ::callbackVoid;
  level.callbackPlayerRevive = ::callbackVoid;
  level.callbackPlayerLastStand = ::callbackVoid;
  setdvar("g_gametype", "dm");
}

callbackVoid() {}