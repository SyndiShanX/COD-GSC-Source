/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\aamissile.gsc
************************************************/

init() {
  precacheitem("aamissile_projectile_mp");
  precacheshader("ac130_overlay_grain");
  level.aamissilelaunchvert = 14000;
  level.aamissilelaunchhorz = 30000;
  level.aamissilelaunchtargetdist = 1500;
  level.rockets = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("aamissile", ::tryuseaamissile);
}

tryuseaamissile(var_0, var_1) {
  scripts\mp\utility::setusingremote("aamissile");
  var_2 = scripts\mp\killstreaks\_killstreaks::initridekillstreak();
  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  level thread aa_missile_fire(var_0, self);
  return 1;
}

gettargets() {
  var_0 = [];
  var_1 = [];
  if(isDefined(level.littlebirds) && level.littlebirds.size) {
    foreach(var_3 in level.littlebirds) {
      if(var_3.team != self.team) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  if(isDefined(level.helis) && level.helis.size) {
    foreach(var_6 in level.helis) {
      if(var_6.team != self.team) {
        var_1[var_1.size] = var_6;
      }
    }
  }

  if(isDefined(var_1) && var_1.size) {
    return var_1[0];
  }

  if(isDefined(var_0) && var_0.size) {
    return var_0[0];
  }
}

aa_missile_fire(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, level.aamissilelaunchvert);
  var_4 = level.aamissilelaunchhorz;
  var_5 = level.aammissilelaunchtargetdist;
  var_6 = var_1 gettargets();
  if(!isDefined(var_6)) {
    var_7 = (0, 0, 0);
  } else {
    var_7 = var_7.origin;
    var_3 = (0, 0, 1) * var_7 + (0, 0, 1000);
  }

  var_8 = anglesToForward(var_1.angles);
  var_9 = var_1.origin + var_3 + var_8 * var_4 * -1;
  var_0A = scripts\mp\utility::_magicbullet("aamissile_projectile_mp", var_9, var_7, var_1);
  if(!isDefined(var_0A)) {
    var_1 scripts\mp\utility::clearusingremote();
    return;
  }

  var_0A.lifeid = var_0;
  var_0A.type = "remote";
  missileeyes(var_1, var_0A);
}

missileeyes(var_0, var_1) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_1 thread rocket_cleanupondeath();
  var_0 thread player_cleanupongameended(var_1);
  var_0 thread player_cleanuponteamchange(var_1);
  var_0 visionsetmissilecamforplayer("black_bw", 0);
  var_0 endon("disconnect");
  if(isDefined(var_1)) {
    var_0 visionsetmissilecamforplayer(game["thermal_vision"], 1);
    var_0 thread delayedfofoverlay();
    var_0 cameralinkto(var_1, "tag_origin");
    var_0 controlslinkto(var_1);
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(0);
    }

    var_1 waittill("death");
    if(isDefined(var_1)) {
      var_0 scripts\mp\matchdata::logkillstreakevent("predator_missile", var_1.origin);
    }

    var_0 controlsunlink();
    var_0 scripts\mp\utility::freezecontrolswrapper(1);
    if(!level.gameended) {
      var_0 thread staticeffect(0.5);
    }

    wait(0.5);
    var_0 thermalvisionfofoverlayoff();
    var_0 cameraunlink();
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(1);
    }
  }

  var_0 scripts\mp\utility::clearusingremote();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.15);
  self thermalvisionfofoverlayon();
}

staticeffect(var_0) {
  self endon("disconnect");
  var_1 = newclienthudelem(self);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1 setshader("white", 640, 480);
  var_1.archive = 1;
  var_1.sort = 10;
  var_2 = newclienthudelem(self);
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2 setshader("ac130_overlay_grain", 640, 480);
  var_2.archive = 1;
  var_2.sort = 20;
  wait(var_0);
  var_2 destroy();
  var_1 destroy();
}

player_cleanuponteamchange(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  if(self.team != "spectator") {
    self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }
  }

  scripts\mp\utility::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("death");
  level.rockets[var_0] = undefined;
}

player_cleanupongameended(var_0) {
  var_0 endon("death");
  self endon("death");
  level waittill("game_ended");
  self thermalvisionfofoverlayoff();
  self controlsunlink();
  self cameraunlink();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }
}