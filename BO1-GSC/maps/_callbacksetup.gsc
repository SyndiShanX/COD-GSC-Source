/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_callbacksetup.gsc
**************************************/

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
  println("**Coop CodeCallback_PlayerConnect**");
  if(getDvar(#"r_reflectionProbeGenerate") == "1") {
    maps\_callbackglobal::Callback_PlayerConnect();
    return;
  }
  [[level.callbackPlayerConnect]]();
  if(isDefined(level._gamemode_playerconnect)) {
    self thread[[level._gamemode_playerconnect]]();
  }
}

CodeCallback_PlayerDisconnect() {
  self notify("disconnect");
  level notify("player_disconnected");
  client_num = self getEntityNumber();
  println("**Coop CodeCallback_PlayerDisconnect**");
  [[level.callbackPlayerDisconnect]]();
}

CodeCallback_ActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, iModelIndex, timeOffset) {
  self endon("disconnect");
  [[level.callbackActorDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, iModelIndex, timeOffset);
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, iModelIndex, timeOffset) {
  self endon("disconnect");
  println("**Coop CodeCallback_PlayerDamage**");
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
  println("**Coop CodeCallback_PlayerKilled**");
  if(!isDefined(level.zombietron_mode)) {
    SetSavedDvar("hud_missionFailed", 1);
    screen_message_delete();
  }
  [[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

CodeCallback_ActorKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset) {
  self endon("disconnect");
  [[level.callbackActorKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset);
}

CodeCallback_VehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName) {
  [[level.callbackVehicleDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName);
}

CodeCallback_SaveRestored() {
  self endon("disconnect");
  println("**Coop CodeCallback_SaveRestored**");
  [[level.callbackSaveRestored]]();
}

CodeCallback_DisconnectedDuringLoad(name) {
  if(!isDefined(level._disconnected_clients)) {
    level._disconnected_clients = [];
  }
  level._disconnected_clients[level._disconnected_clients.size] = name;
}

CodeCallback_LevelNotify(level_notify, param1, param2) {
  if(isDefined(param1) && isDefined(param2)) {
    level notify(level_notify, param1, param2);
  } else if(isDefined(param1)) {
    level notify(level_notify, param1);
  } else {
    level notify(level_notify);
  }
}

CodeCallback_FaceEventNotify(notify_msg, ent) {
  if(isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims) {
    if(isDefined(level.face_event_handler) && isDefined(level.face_event_handler.events[notify_msg])) {
      ent SendFaceEvent(level.face_event_handler.events[notify_msg]);
    }
  }
}

CodeCallback_MenuMessage(param1, param2) {
  [[level.onMenuMessage]](param1, param2);
}

CodeCallback_Dec20Message(param1) {
  [[level.onDec20Message]](param1);
}

CodeCallback_ActorShouldReact() {
  self endon("disconnect");
  if(self call_overloaded_func("animscripts\react", "shouldReact")) {
    self startactorreact();
  }
}

SetupCallbacks() {
  thread maps\_callbackglobal::SetupCallbacks();
  SetDefaultCallbacks();
  level.iDFLAGS_RADIUS = 1;
  level.iDFLAGS_NO_ARMOR = 2;
  level.iDFLAGS_NO_KNOCKBACK = 4;
  level.iDFLAGS_PENETRATION = 8;
  level.iDFLAGS_NO_TEAM_PROTECTION = 16;
  level.iDFLAGS_NO_PROTECTION = 32;
  level.iDFLAGS_PASSTHRU = 64;
}

CodeCallback_GlassSmash(pos, dir) {
  level notify("glass_smash", pos, dir);
}

SetDefaultCallbacks() {
  level.callbackStartGameType = maps\_callbackglobal::Callback_StartGameType;
  level.callbackSaveRestored = maps\_callbackglobal::Callback_SaveRestored;
  level.callbackPlayerConnect = maps\_callbackglobal::Callback_PlayerConnect;
  level.callbackPlayerDisconnect = maps\_callbackglobal::Callback_PlayerDisconnect;
  level.callbackPlayerDamage = maps\_callbackglobal::Callback_PlayerDamage;
  level.callbackActorDamage = maps\_callbackglobal::Callback_ActorDamage;
  level.callbackVehicleDamage = maps\_callbackglobal::Callback_VehicleDamage;
  level.callbackPlayerKilled = maps\_callbackglobal::Callback_PlayerKilled;
  level.callbackActorKilled = maps\_callbackglobal::Callback_ActorKilled;
  level.callbackPlayerLastStand = maps\_callbackglobal::Callback_PlayerLastStand;
}

callbackVoid() {}