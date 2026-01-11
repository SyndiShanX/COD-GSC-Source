/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_nuke.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level.nukeVisionSet = "alien_nuke";
  level.nukeVisionSetFailed = "alien_nuke_blast";

  if(level.script == "mp_alien_last") {
    level._effect["nuke_flash"] = loadfx("vfx/moments/alien/player_nuke_flash_alien_last");
  } else {
    level._effect["nuke_flash"] = loadfx("fx/explosions/player_death_nuke_flash_alien");
  }

  SetDvarIfUninitialized("scr_nukeTimer", 10);
  SetDvarIfUninitialized("scr_nukeCancelMode", 0);

  level.nukeTimer = getDvarInt("scr_nukeTimer");
  level.cancelMode = getDvarInt("scr_nukeCancelMode");

  level.nukeInfo = spawnStruct();
  level.nukeInfo.xpScalar = 2;
  level.nukeDetonated = undefined;

  level thread onPlayerConnect();
}

delaythread_nuke(delay, func) {
  level endon("nuke_cancelled");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delay);

  thread[[func]]();
}

doNukeSimple() {
  level.nukeInfo.player = self;
  level.nukeInfo.team = self.pers["team"];
  level.nukeIncoming = true;

  level thread delaythread_nuke((level.nukeTimer - 3.3), ::nukeSoundIncoming);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSoundExplosion);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSlowMo);
  level thread delaythread_nuke(level.nukeTimer, ::nukeEffects);
  level thread delaythread_nuke((level.nukeTimer + 0.25), ::nukeVision);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeDeath);

  if(!isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject = spawn("script_origin", (0, 0, 1));
    level.nuke_soundObject hide();
  }
}

nukeDeath() {
  level notify("nuke_death");
}

nukeSoundIncoming() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject playSound("nuke_incoming");
  }
}

nukeSoundExplosion() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject playSound("nuke_explosion");
    level.nuke_soundObject playSound("nuke_wave");
  }
}

nukeEffects() {
  level endon("nuke_cancelled");

  level.nukeDetonated = true;

  foreach(player in level.players) {
    playerForward = anglesToForward(player.angles);
    playerForward = (playerForward[0], playerForward[1], 0);
    playerForward = VectorNormalize(playerForward);

    nukeDistance = 5000;

    nukeLoc = player.origin + (playerForward * nukeDistance);

    if(isDefined(level.nukeLoc)) {
      nukeLoc = level.nukeLoc;
    }

    nukeAngles = (0, (player.angles[1] + 180), 90);

    if(isDefined(level.nukeAngles)) {
      nukeAngles = level.nukeAngles;
    }

    nukeEnt = spawn("script_model", nukeLoc);
    nukeEnt setModel("tag_origin");
    nukeEnt.angles = nukeAngles;

    nukeEnt thread nukeEffect(player);
  }
}

nukeEffect(player) {
  level endon("nuke_cancelled");

  player endon("disconnect");

  waitframe();
  PlayFXOnTagForClients(level._effect["nuke_flash"], self, "tag_origin", player);
}

nukeSlowMo() {
  level endon("nuke_cancelled");

  SetSlowMotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  SetSlowMotion(0.25, 1, 2.0);
}

nukeVision() {
  level endon("nuke_cancelled");

  level.nukeVisionInProgress = true;

  transition_time = 0.75;
  foreach(player in level.players) {
    if(isDefined(player.sessionstate) && player.sessionstate == "spectator") {
      spectated_player = player GetSpectatingPlayer();
      if(isDefined(spectated_player)) {
        if((isDefined(spectated_player.nuke_escaped) && spectated_player.nuke_escaped)) {
          player set_vision_for_nuke_escaped(transition_time);
        } else {
          player set_vision_for_nuke_failed(transition_time);
        }
      } else {
        player set_vision_for_nuke_failed(transition_time);
      }
    } else {
      if((isDefined(player.nuke_escaped) && player.nuke_escaped)) {
        player set_vision_for_nuke_escaped(transition_time);
      } else {
        player set_vision_for_nuke_failed(transition_time);
      }
    }
  }

  fog_nuke(transition_time);
}

set_vision_for_nuke_escaped(transition_time) {
  self VisionSetNakedForPlayer(level.nukeVisionSet, transition_time);
  self VisionSetPainForPlayer(level.nukeVisionSet);
}

set_vision_for_nuke_failed(transition_time) {
  PlayFXOnTagForClients(level._effect["vfx/moments/alien/nuke_fail_screen_flash"], self, "tag_eye", self);
  self VisionSetNakedForPlayer(level.nukeVisionSetFailed, transition_time);
  self VisionSetPainForPlayer(level.nukeVisionSetFailed);
}

fog_nuke(transition_time) {
  if(!isDefined(level.nuke_fog_setting)) {
    return;
  }
  ent = level.nuke_fog_setting;

  SetExpFog(
    ent.startDist,
    ent.halfwayDist,
    ent.red,
    ent.green,
    ent.blue,
    ent.HDRColorIntensity,
    ent.maxOpacity,
    transition_time,
    ent.sunRed,
    ent.sunGreen,
    ent.sunBlue,
    ent.HDRSunColorIntensity,
    ent.sunDir,
    ent.sunBeginFadeAngle,
    ent.sunEndFadeAngle,
    ent.normalFogScale,
    ent.skyFogIntensity,
    ent.skyFogMinAngle,
    ent.skyFogMaxAngle);
}

restore_fog(transition_time) {
  if(!isDefined(level.restore_fog_setting)) {
    return;
  }
  ent = level.restore_fog_setting;

  SetExpFog(
    ent.startDist,
    ent.halfwayDist,
    ent.red,
    ent.green,
    ent.blue,
    ent.HDRColorIntensity,
    ent.maxOpacity,
    transition_time,
    ent.sunRed,
    ent.sunGreen,
    ent.sunBlue,
    ent.HDRSunColorIntensity,
    ent.sunDir,
    ent.sunBeginFadeAngle,
    ent.sunEndFadeAngle,
    ent.normalFogScale,
    ent.skyFogIntensity,
    ent.skyFogMinAngle,
    ent.skyFogMaxAngle);
}

nukeEarthquake() {
  level endon("nuke_cancelled");

  level waittill("nuke_death");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(level.nukeDetonated)) {
      self VisionSetNakedForPlayer(level.nukeVisionSet, 0);
    }
  }
}