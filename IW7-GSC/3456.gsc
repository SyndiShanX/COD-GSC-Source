/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3456.gsc
***************************************/

init() {
  precacheitem("aamissile_projectile_mp");
  precacheshader("ac130_overlay_grain");
  level.aamissilelaunchvert = 14000;
  level.aamissilelaunchhorz = 30000;
  level.aamissilelaunchtargetdist = 1500;
  level.rockets = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("aamissile", ::tryuseaamissile);
}

tryuseaamissile(var_00, var_01) {
  scripts\mp\utility\game::setusingremote("aamissile");
  var_02 = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var_02 != "success") {
    if(var_02 != "disconnect") {
      scripts\mp\utility\game::clearusingremote();
    }

    return 0;
  }

  level thread aa_missile_fire(var_00, self);
  return 1;
}

gettargets() {
  var_00 = [];
  var_01 = [];

  if(isDefined(level.littlebirds) && level.littlebirds.size) {
    foreach(var_03 in level.littlebirds) {
      if(var_3.team != self.team) {
        var_0[var_0.size] = var_03;
      }
    }
  }

  if(isDefined(level.helis) && level.helis.size) {
    foreach(var_06 in level.helis) {
      if(var_6.team != self.team) {
        var_1[var_1.size] = var_06;
      }
    }
  }

  if(isDefined(var_01) && var_1.size) {
    return var_1[0];
  }
  else if(isDefined(var_00) && var_0.size) {
    return var_0[0];
  }
}

aa_missile_fire(var_00, var_01) {
  var_02 = undefined;
  var_03 = (0, 0, level.aamissilelaunchvert);
  var_04 = level.aamissilelaunchhorz;
  var_05 = level.aammissilelaunchtargetdist;
  var_06 = var_01 gettargets();

  if(!isDefined(var_06)) {
    var_07 = (0, 0, 0);
  }
  else {
    var_07 = var_6.origin;
    var_03 = (0, 0, 1) * var_07 + (0, 0, 1000);
  }

  var_08 = anglesToForward(var_1.angles);
  var_09 = var_1.origin + var_03 + var_08 * var_04 * -1;
  var_10 = scripts\mp\utility\game::_magicbullet("aamissile_projectile_mp", var_09, var_07, var_01);

  if(!isDefined(var_10)) {
    var_01 scripts\mp\utility\game::clearusingremote();
    return;
  }

  var_10.lifeid = var_00;
  var_10.type = "remote";
  missileeyes(var_01, var_10);
}

missileeyes(var_00, var_01) {
  var_00 endon("joined_team");
  var_00 endon("joined_spectators");
  var_01 thread rocket_cleanupondeath();
  var_00 thread player_cleanupongameended(var_01);
  var_00 thread player_cleanuponteamchange(var_01);
  var_00 visionsetmissilecamforplayer("black_bw", 0);
  var_00 endon("disconnect");

  if(isDefined(var_01)) {
    var_00 visionsetmissilecamforplayer(game["thermal_vision"], 1.0);
    var_00 thread delayedfofoverlay();
    var_00 cameralinkto(var_01, "tag_origin");
    var_00 controlslinkto(var_01);

    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility\game::setthirdpersondof(0);
    }

    var_01 waittill("death");

    if(isDefined(var_01)) {
      var_00 scripts\mp\matchdata::logkillstreakevent("predator_missile", var_1.origin);
    }

    var_00 controlsunlink();
    var_00 scripts\mp\utility\game::freezecontrolswrapper(1);

    if(!level.gameended) {
      var_00 thread staticeffect(0.5);
    }

    wait 0.5;
    var_00 thermalvisionfofoverlayoff();
    var_00 cameraunlink();

    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility\game::setthirdpersondof(1);
    }
  }

  var_00 scripts\mp\utility\game::clearusingremote();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.15;
  self thermalvisionfofoverlayon();
}

staticeffect(var_00) {
  self endon("disconnect");
  var_01 = newclienthudelem(self);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_01 setshader("white", 640, 480);
  var_1.archive = 1;
  var_1.sort = 10;
  var_02 = newclienthudelem(self);
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_02 setshader("ac130_overlay_grain", 640, 480);
  var_2.archive = 1;
  var_2.sort = 20;
  wait(var_00);
  var_02 destroy();
  var_01 destroy();
}

player_cleanuponteamchange(var_00) {
  var_00 endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\game::setthirdpersondof(1);
    }
  }

  scripts\mp\utility\game::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_00 = self getentitynumber();
  level.rockets[var_00] = self;
  self waittill("death");
  level.rockets[var_00] = undefined;
}

player_cleanupongameended(var_00) {
  var_00 endon("death");
  self endon("death");
  level waittill("game_ended");
  self thermalvisionfofoverlayoff();
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(1);
  }
}