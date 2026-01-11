/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam.gsc
*****************************************************/

#include maps\mp\gametypes\_hud_util;

init() {
  precacheString(&"PLATFORM_PRESS_TO_SKIP");
  precacheString(&"PLATFORM_PRESS_TO_RESPAWN");
  precacheShader("white");
  level.killcam = maps\mp\gametypes\_tweakables::getTweakableValue("game", "allowkillcam");
  if(level.killcam) {
    setArchive(true);
  }
}

killcam(
  attackerNum,
  killcamentity,
  killcamentityindex,
  killcamentitystarttime,
  sWeapon,
  predelay,
  offsetTime,
  respawn,
  maxtime,
  perks,
  attacker
) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  if(attackerNum < 0) {
    return;
  }
  if(getdvar("scr_killcam_time") == "") {
    if(sWeapon == "artillery_mp") {
      camtime = 2.5;
    } else if(!respawn) {
      camtime = 5.0;
    } else if(sWeapon == "frag_grenade_mp" || sWeapon == "frag_grenade_short_mp" || sWeapon == "molotov_mp" || sWeapon == "sticky_grenade_mp") {
      camtime = 4.25;
    } else
      camtime = 2.5;
  } else
    camtime = getdvarfloat("scr_killcam_time");
  if(isDefined(maxtime)) {
    if(camtime > maxtime) {
      camtime = maxtime;
    }
    if(camtime < .05) {
      camtime = .05;
    }
  }
  if(getdvar("scr_killcam_posttime") == "") {
    postdelay = 2;
  } else {
    postdelay = getdvarfloat("scr_killcam_posttime");
    if(postdelay < 0.05) {
      postdelay = 0.05;
    }
  }
  killcamlength = camtime + postdelay;
  if(isDefined(maxtime) && killcamlength > maxtime) {
    if(maxtime < 2) {
      return;
    }
    if(maxtime - camtime >= 1) {
      postdelay = maxtime - camtime;
    } else {
      postdelay = 1;
      camtime = maxtime - 1;
    }
    killcamlength = camtime + postdelay;
  }
  killcamoffset = camtime + predelay;
  self notify("begin_killcam", getTime());
  killcamstarttime = (gettime() - killcamoffset * 1000);
  self.sessionstate = "spectator";
  self.spectatorclient = attackerNum;
  self.killcamentity = -1;
  if(killcamentityindex >= 0) {
    self thread setKillCamEntity(killcamentityindex, killcamentitystarttime - killcamstarttime - 100);
  }
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = offsetTime;
  self allowSpectateTeam("allies", true);
  self allowSpectateTeam("axis", true);
  self allowSpectateTeam("freelook", true);
  self allowSpectateTeam("none", true);
  wait 0.05;
  if(self.archivetime <= predelay) {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    return;
  }
  self.killcam = true;
  if(!isDefined(self.kc_skiptext)) {
    self.kc_skiptext = newClientHudElem(self);
    self.kc_skiptext.archived = false;
    self.kc_skiptext.x = 0;
    self.kc_skiptext.alignX = "center";
    self.kc_skiptext.alignY = "middle";
    self.kc_skiptext.horzAlign = "center_safearea";
    self.kc_skiptext.vertAlign = "top";
    self.kc_skiptext.sort = 1;
    self.kc_skiptext.font = "objective";
    self.kc_skiptext.foreground = true;
    if(level.splitscreen) {
      self.kc_skiptext.y = 34;
      self.kc_skiptext.fontscale = 1.6;
    } else {
      self.kc_skiptext.y = 60;
      self.kc_skiptext.fontscale = 2;
    }
  }
  if(respawn) {
    self.kc_skiptext setText(&"PLATFORM_PRESS_TO_RESPAWN");
  } else {
    self.kc_skiptext setText(&"PLATFORM_PRESS_TO_SKIP");
  }
  self.kc_skiptext.alpha = 1;
  if(!level.splitscreen) {
    if(!isDefined(self.kc_timer)) {
      self.kc_timer = createFontString("objective", 2.0);
      if(level.console) {
        self.kc_timer setPoint("BOTTOM", undefined, 0, -80);
      } else {
        self.kc_timer setPoint("BOTTOM", undefined, 0, -60);
      }
      self.kc_timer.archived = false;
      self.kc_timer.foreground = true;
    }
    self.kc_timer.alpha = 1;
    self.kc_timer setTenthsTimer(camtime);
    self showPerk(0, perks[0], -10);
    self showPerk(1, perks[1], -10);
    self showPerk(2, perks[2], -10);
    self showPerk(3, perks[3], -10);
  }
  self thread spawnedKillcamCleanup();
  self thread endedKillcamCleanup();
  self thread waitSkipKillcamButton();
  self thread waitKillcamTime();
  self waittill("end_killcam");
  self endKillcam();
  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
}

setKillCamEntity(killcamentityindex, delayms) {
  self endon("disconnect");
  self endon("end_killcam");
  self endon("spawned");
  if(delayms > 0) {
    wait delayms / 1000;
  }
  self.killcamentity = killcamentityindex;
}

waitKillcamTime() {
  self endon("disconnect");
  self endon("end_killcam");
  wait(self.killcamlength - 0.05);
  self notify("end_killcam");
}

waitSkipKillcamButton() {
  self endon("disconnect");
  self endon("end_killcam");
  while(self useButtonPressed()) {
    wait .05;
  }
  while(!(self useButtonPressed())) {
    wait .05;
  }
  self notify("end_killcam");
}

waitSkipKillcamSafeSpawnButton() {
  self endon("disconnect");
  self endon("end_killcam");
  while(self fragButtonPressed()) {
    wait .05;
  }
  while(!(self fragButtonPressed())) {
    wait .05;
  }
  self.wantSafeSpawn = true;
  self notify("end_killcam");
}

endKillcam() {
  if(isDefined(self.kc_skiptext)) {
    self.kc_skiptext.alpha = 0;
  }
  if(isDefined(self.kc_timer)) {
    self.kc_timer.alpha = 0;
  }
  if(!level.splitscreen) {
    self hidePerk(0);
    self hidePerk(1);
    self hidePerk(2);
    self hidePerk(3);
  }
  self.killcam = undefined;
  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

spawnedKillcamCleanup() {
  self endon("end_killcam");
  self endon("disconnect");
  self waittill("spawned");
  self endKillcam();
}

spectatorKillcamCleanup(attacker) {
  self endon("end_killcam");
  self endon("disconnect");
  attacker endon("disconnect");
  attacker waittill("begin_killcam", attackerKcStartTime);
  waitTime = max(0, (attackerKcStartTime - self.deathTime) - 50);
  wait(waitTime);
  self endKillcam();
}

endedKillcamCleanup() {
  self endon("end_killcam");
  self endon("disconnect");
  level waittill("game_ended");
  self endKillcam();
}