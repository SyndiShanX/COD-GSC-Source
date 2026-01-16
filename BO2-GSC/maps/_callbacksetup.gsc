/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_callbacksetup.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_callbackglobal;
#include maps\_spawner;
#include animscripts\react;

codecallback_startgametype() {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [
      [level.callbackstartgametype]
    ]();
    level.gametypestarted = 1;
  }
}

codecallback_playerconnect() {
  self endon("disconnect");

  println("****Coop CodeCallback_PlayerConnect****");

  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    maps\_callbackglobal::callback_playerconnect();
    return;
  }

  if(!isDefined(level.callbackplayerconnect)) {
    iprintlnbold("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::callback_playerconnect();

    if(isDefined(level._gamemode_playerconnect))
      [[level._gamemode_playerconnect]]();

    return;
  }

  [[level.callbackplayerconnect]]();

  if(isDefined(level._gamemode_playerconnect))
    self thread[[level._gamemode_playerconnect]]();
}

codecallback_playerdisconnect() {
  self notify("disconnect");
  level notify("player_disconnected");
  client_num = self getentitynumber();

  println("****Coop CodeCallback_PlayerDisconnect****");

  if(!isDefined(level.callbackplayerdisconnect)) {
    iprintlnbold("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::callback_playerdisconnect();
    return;
  }

  [[level.callbackplayerdisconnect]]();
}

codecallback_actorspawned(spawn) {
  spawn thread maps\_spawner::spawn_think(self);
}

codecallback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset, bonename) {
  self endon("disconnect");

  if(!isDefined(level.callbackactordamage)) {
    iprintlnbold("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset, bonename);
    return;
  }

  [[level.callbackactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset, bonename);
}

codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset) {
  self endon("disconnect");

  if(!isDefined(level.callbackplayerdamage)) {
    iprintlnbold("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset);
    return;
  }

  [[level.callbackplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, imodelindex, timeoffset);
}

codecallback_playerrevive() {
  self endon("disconnect");
  [[level.callbackplayerrevive]]();
}

codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self endon("disconnect");
  [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);
}

codecallback_playerkilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  println("****Coop CodeCallback_PlayerKilled****");

  setsaveddvar("hud_missionFailed", 1);
  screen_message_delete();
}

codecallback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset) {
  self endon("disconnect");
  [[level.callbackactorkilled]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset);
}

codecallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, damagefromunderneath, modelindex, partname) {
  [[level.callbackvehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, damagefromunderneath, modelindex, partname);
}

codecallback_saverestored() {
  self endon("disconnect");

  println("****Coop CodeCallback_SaveRestored****");

  if(!isDefined(level.callbacksaverestored)) {
    iprintlnbold("_callbacksetup::SetupCallbacks() needs to be called in your main level function.");
    maps\_callbackglobal::callback_saverestored();
    return;
  }

  [[level.callbacksaverestored]]();
}

codecallback_disconnectedduringload(name) {
  if(!isDefined(level._disconnected_clients))
    level._disconnected_clients = [];

  level._disconnected_clients[level._disconnected_clients.size] = name;
}

codecallback_faceeventnotify(notify_msg, ent) {
  if(isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims) {
    if(isDefined(level.face_event_handler) && isDefined(level.face_event_handler.events[notify_msg])) {
      forced = 0;

      if(isDefined(level.face_event_handler.forced[notify_msg]))
        forced = level.face_event_handler.forced[notify_msg];

      ent sendfaceevent(level.face_event_handler.events[notify_msg], forced);
    }
  }
}

codecallback_actorshouldreact() {
  self endon("disconnect");

  if(self animscripts\react::shouldreact())
    self startactorreact();
}

codecallback_menuresponse(action, arg) {
  if(!isDefined(level.menuresponsequeue)) {
    level.menuresponsequeue = [];
    level thread menuresponsequeuepump();
  }

  index = level.menuresponsequeue.size;
  level.menuresponsequeue[index] = spawnstruct();
  level.menuresponsequeue[index].action = action;
  level.menuresponsequeue[index].arg = arg;
  level.menuresponsequeue[index].ent = self;
  level notify("menuresponse_queue");
}

menuresponsequeuepump() {
  while(true) {
    level waittill("menuresponse_queue");

    do {
      level.menuresponsequeue[0].ent notify("menuresponse", level.menuresponsequeue[0].action, level.menuresponsequeue[0].arg);
      arrayremoveindex(level.menuresponsequeue, 0, 0);
      wait 0.05;
    }
    while(level.menuresponsequeue.size > 0);
  }
}

setupcallbacks() {
  thread maps\_callbackglobal::setupcallbacks();
  setdefaultcallbacks();
  level.idflags_radius = 1;
  level.idflags_no_armor = 2;
  level.idflags_no_knockback = 4;
  level.idflags_penetration = 8;
  level.idflags_destructible_entity = 16;
  level.idflags_shield_explosive_impact = 32;
  level.idflags_shield_explosive_impact_huge = 64;
  level.idflags_shield_explosive_splash = 128;
  level.idflags_no_team_protection = 256;
  level.idflags_no_protection = 512;
  level.idflags_passthru = 1024;
}

codecallback_glasssmash(pos, dir) {
  level notify("glass_smash", pos, dir);
}

setdefaultcallbacks() {
  level.callbackstartgametype = maps\_callbackglobal::callback_startgametype;
  level.callbacksaverestored = maps\_callbackglobal::callback_saverestored;
  level.callbackplayerconnect = maps\_callbackglobal::callback_playerconnect;
  level.callbackplayerdisconnect = maps\_callbackglobal::callback_playerdisconnect;
  level.callbackplayerdamage = maps\_callbackglobal::callback_playerdamage;
  level.callbackactordamage = maps\_callbackglobal::callback_actordamage;
  level.callbackvehicledamage = maps\_callbackglobal::callback_vehicledamage;
  level.callbackplayerkilled = maps\_callbackglobal::callback_playerkilled;
  level.callbackactorkilled = maps\_callbackglobal::callback_actorkilled;
  level.callbackplayerlaststand = maps\_callbackglobal::callback_playerlaststand;
}

callbackvoid() {
}