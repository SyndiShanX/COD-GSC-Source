/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\blackout_grenade.gsc
*****************************************************/

func_10D6F(param_00, param_01, param_02) {
  if(!func_13151(param_00, param_01)) {
    return;
  }

  if(isDefined(self.var_2B4B)) {
    self.var_2B4B thread func_6310(0, 1, 1);
  }

  var_03 = spawnStruct();
  self.var_2B4B = var_03;
  var_03.victim = self;
  var_03.var_4F = param_00;
  var_03.starttime = gettime();
  if(!isDefined(param_02)) {
    param_02 = func_7F68(max(0, getweightedchanceroll(param_01, self) + getwholescenedurationmin(param_00)));
  }

  switch (param_02) {
    case 4:
      var_03.var_5FEB = 4;
      var_03.refreshwindowms = 3000;
      var_03.var_10475 = "blackout_grenade_drone_lr";
      var_03.blurstrength = 7;
      var_03.blursnapstrength = 12;
      var_03.blurindur = 0.2;
      var_03.blurdur = 1.9;
      var_03.bluroutdur = 3.2;
      var_03.overlayinalpha = 1;
      var_03.overlayindur = 0.2;
      var_03.overlaydur = 0.35;
      var_03.overlayoutalpha = 0.3;
      var_03.overlayoutdur = 0.4;
      var_03.useoverlay2 = 1;
      var_03.overlay2delay = 0.15;
      var_03.overlay2inalpha = 1;
      var_03.overlay2indur = 0.65;
      var_03.overlay2dur = 0.35;
      var_03.overlay2outalpha = 0;
      var_03.overlay2outdur = 3.2;
      var_03.shockdelay = 0.55;
      var_03.shockdur = 1;
      var_03.shock2delay = 0.35;
      var_03.shock2dur = 2;
      break;

    case 3:
      var_03.var_5FEB = 3;
      var_03.refreshwindowms = 2000;
      var_03.var_10475 = "blackout_grenade_drone_lr";
      var_03.blurstrength = 7;
      var_03.blursnapstrength = 12;
      var_03.blurindur = 0.2;
      var_03.blurdur = 1.9;
      var_03.bluroutdur = 2.2;
      var_03.overlayinalpha = 1;
      var_03.overlayindur = 0.2;
      var_03.overlaydur = 0.35;
      var_03.overlayoutalpha = 0.3;
      var_03.overlayoutdur = 0.4;
      var_03.useoverlay2 = 1;
      var_03.overlay2delay = 0.15;
      var_03.overlay2inalpha = 1;
      var_03.overlay2indur = 0.65;
      var_03.overlay2dur = 0.35;
      var_03.overlay2outalpha = 0;
      var_03.overlay2outdur = 2.2;
      var_03.shockdelay = 0.55;
      var_03.shockdur = 1;
      var_03.shock2delay = 0.35;
      var_03.shock2dur = 2;
      break;

    case 2:
      var_03.var_5FEB = 2;
      var_03.refreshwindowms = 1000;
      var_03.var_10475 = "blackout_grenade_drone_lr";
      var_03.blurstrength = 7;
      var_03.blursnapstrength = 12;
      var_03.blurindur = 0.2;
      var_03.blurdur = 1.9;
      var_03.bluroutdur = 1.2;
      var_03.overlayinalpha = 1;
      var_03.overlayindur = 0.2;
      var_03.overlaydur = 0.35;
      var_03.overlayoutalpha = 0.3;
      var_03.overlayoutdur = 0.4;
      var_03.useoverlay2 = 1;
      var_03.overlay2delay = 0.15;
      var_03.overlay2inalpha = 1;
      var_03.overlay2indur = 0.65;
      var_03.overlay2dur = 0.35;
      var_03.overlay2outalpha = 0;
      var_03.overlay2outdur = 1.2;
      var_03.shockdelay = 0.55;
      var_03.shockdur = 1;
      var_03.shock2delay = 0.35;
      var_03.shock2dur = 1.6;
      break;

    case 1:
      var_03.var_5FEB = 1;
      var_03.refreshwindowms = 1000;
      var_03.var_10475 = "blackout_grenade_drone_short_lr";
      var_03.blurstrength = 7;
      var_03.blursnapstrength = 12;
      var_03.blurindur = 0.2;
      var_03.blurdur = 0.35;
      var_03.bluroutdur = 1.2;
      var_03.overlayinalpha = 1;
      var_03.overlayindur = 0.2;
      var_03.overlaydur = 0.35;
      var_03.overlayoutalpha = 0;
      var_03.overlayoutdur = 1.2;
      var_03.useoverlay2 = 0;
      var_03.overlay2delay = 0;
      var_03.overlay2inalpha = 0;
      var_03.overlay2indur = 0;
      var_03.overlay2dur = 0;
      var_03.overlay2outalpha = 0;
      var_03.overlay2outdur = 0;
      var_03.shockdelay = 0.55;
      var_03.shockdur = 1.6;
      var_03.shock2delay = 0;
      var_03.shock2dur = 0;
      break;
  }

  var_03.blurdurtotal = var_03.blurindur + var_03.blurdur + var_03.bluroutdur;
  var_03.overlaydurtotal = var_03.overlayindur + var_03.overlaydur + var_03.overlayoutdur;
  if(var_03.useoverlay2) {
    var_03.overlaydurtotal = var_03.overlaydurtotal + var_03.overlay2delay + var_03.overlay2indur + var_03.overlay2dur + var_03.overlay2outdur;
  }

  var_03.durtotal = max(var_03.blurdurtotal, var_03.overlaydurtotal);
  var_04 = newclienthudelem(self);
  var_04.x = 0;
  var_04.y = 0;
  var_04.alignx = "left";
  var_04.aligny = "top";
  var_04.sort = 1;
  var_04.horzalign = "fullscreen";
  var_04.vertalign = "fullscreen";
  var_04.alpha = 0;
  var_04.foreground = 1;
  var_04 setshader("black", 640, 480);
  var_03.var_C7FD = var_04;
  var_03 thread func_B9BB();
  param_00 scripts\mp\damage::combatrecordtacticalstat("power_blackoutGrenade");
}

func_6310(param_00, param_01, param_02) {
  self notify("blackoutEnded");
  var_03 = self.var_4F;
  var_04 = self.victim;
  if(isDefined(var_04)) {
    var_04.var_2B4B = undefined;
    if(!param_00) {
      if(param_02) {
        thread endblackoutsfx();
      } else {
        thread endblackoutsfx(2);
      }

      if(param_01) {
        var_04 setblurforplayer(0, 0.05);
      }

      if(isDefined(var_03)) {
        scripts\mp\gamescore::untrackdebuffassist(var_03, var_04, "blackout_grenade_mp");
      }

      var_04 scripts\mp\weapons::func_F7FF();
      var_04 scripts\mp\utility::func_8EC4();
    } else {
      thread endblackoutsfx();
    }
  }

  self.var_C7FD destroy();
}

endblackoutsfx(param_00) {
  self.victim endon("disconnect");
  self notify("endBlackoutSfx");
  self endon("endBlackoutSfx");
  if(isDefined(param_00)) {
    wait(param_00);
  }

  self.victim stoplocalsound("blackout_grenade_drone_lr");
  self.victim stoplocalsound("blackout_grenade_drone_lsrs");
  self.victim stoplocalsound("blackout_grenade_drone_short_lr");
  self.victim stoplocalsound("blackout_grenade_drone_short_lsrs");
}

func_B9BB() {
  var_00 = self.victim;
  var_00 endon("disconnect");
  self endon("blackoutEnded");
  var_01 = self.var_4F;
  var_02 = self.var_10475;
  var_03 = self.durtotal;
  var_00 shellshock("blackout_grenade_mp", 1);
  var_00 playlocalsound(var_02);
  var_00 scripts\mp\weapons::func_F7EE();
  var_00 scripts\mp\utility::func_8EC6();
  if(isDefined(self.var_4F)) {
    scripts\mp\gamescore::func_11ACE(var_01, var_00, "blackout_grenade_mp");
  }

  thread monitorvictimdeathdisconnect();
  childthread monitorblur();
  childthread monitoroverlay();
  childthread monitorshock();
  childthread monitorgameended();
  wait(var_03 + 0.05);
  thread func_6310(0, 0, 0);
}

monitorblur() {
  var_00 = self.victim;
  var_00 endon("disconnect");
  self endon("blackoutEnded");
  var_01 = self.blurstrength;
  var_02 = self.blursnapstrength;
  var_03 = self.blurindur;
  var_04 = self.blurdur;
  var_05 = self.bluroutdur;
  var_00 setblurforplayer(var_01, var_03);
  if(var_02 != var_01 && var_04 > 0.1) {
    wait(var_03 + var_04 - 0.1);
    var_00 setblurforplayer(var_02, 0.05);
    wait(0.1);
  } else {
    wait(var_03 + var_04);
  }

  var_00 setblurforplayer(0, var_05);
}

monitoroverlay() {
  var_00 = self.victim;
  var_00 endon("disconnect");
  self endon("blackoutEnded");
  var_01 = self.var_C7FD;
  var_02 = self.overlayinalpha;
  var_03 = self.overlayindur;
  var_04 = self.overlaydur;
  var_05 = self.overlayoutalpha;
  var_06 = self.overlayoutdur;
  var_07 = self.useoverlay2;
  var_08 = self.overlay2delay;
  var_09 = self.overlay2inalpha;
  var_0A = self.overlay2indur;
  var_0B = self.overlay2dur;
  var_0C = self.overlay2outalpha;
  var_0D = self.overlay2outdur;
  var_01 fadeovertime(var_03);
  var_01.alpha = var_02;
  wait(var_03 + var_04);
  var_01 fadeovertime(var_06);
  var_01.alpha = var_05;
  if(var_07) {
    wait(var_06 + var_08);
    var_01 fadeovertime(var_0A);
    var_01.alpha = var_09;
    wait(var_0A + var_0B);
    var_01 fadeovertime(var_0D);
    var_01.alpha = var_0C;
  }
}

monitorshock() {
  var_00 = self.victim;
  var_00 endon("disconnect");
  self endon("blackoutEnded");
  var_01 = self.shockdelay;
  var_02 = self.shockdur;
  var_03 = self.useoverlay2;
  var_04 = self.shock2delay;
  var_05 = self.shock2dur;
  wait(var_01);
  var_00 shellshock("blackout_grenade_mp", var_02, 0);
  if(var_03) {
    wait(var_02 + var_04);
    var_00 shellshock("blackout_grenade_mp", var_05, 0);
  }
}

monitorvictimdeathdisconnect() {
  self endon("blackoutEnded");
  self.victim scripts\engine\utility::waittill_any_3("death", "disconnect");
  thread func_6310(1, 0, 0);
}

monitorgameended() {
  self endon("blackoutEnded");
  level scripts\engine\utility::waittill_any_3("game_ended", "round_end_finished");
  thread func_6310(0, 1, 1);
}

getweightedchanceroll(param_00, param_01) {
  var_02 = param_00 - param_01 getEye();
  var_03 = clamp(length(var_02), 100, 512);
  var_04 = 1 - var_03 - 100 / 412 * 70;
  var_05 = anglesToForward(param_01 getplayerangles());
  var_06 = scripts\engine\utility::anglebetweenvectors(var_02, var_05);
  var_06 = clamp(var_06, 15, 60);
  var_07 = 1 - var_06 - 15 / 45 * 30;
  return var_04 + var_07;
}

func_7F68(param_00) {
  if(param_00 > 70) {
    return 4;
  }

  if(param_00 > 55) {
    return 3;
  }

  if(param_00 > 30) {
    return 2;
  }

  return 1;
}

getwholescenedurationmin(param_00) {
  if(self == param_00) {
    return -30;
  }

  return 0;
}

func_13151(param_00, param_01) {
  if(!isplayer(self)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  if(scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
    scripts\mp\perks\_perkfunctions::applystunresistence(param_00, self);
    return 0;
  }

  var_02 = func_7E09();
  var_03 = getblackoutrefreshwindowms();
  if(isDefined(var_02) && isDefined(var_03) && var_02 - gettime() > var_03) {
    return 0;
  }

  return 1;
}

func_7E09() {
  if(!isDefined(self.var_2B4B)) {
    return undefined;
  }

  return self.var_2B4B.starttime + self.var_2B4B.durtotal * 1000;
}

getblackoutrefreshwindowms() {
  if(!isDefined(self.var_2B4B)) {
    return undefined;
  }

  return self.var_2B4B.refreshwindowms;
}

func_B92C(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03) || !isDefined(param_04) || !isDefined(param_01) || !isDefined(param_02)) {
    return param_00;
  }

  if(param_04 != "blackout_grenade_mp") {
    return param_00;
  }

  if(param_01 != param_02) {
    return param_00;
  }

  if(distancesquared(param_02.origin, param_03.origin) <= 65536) {
    return param_00;
  }

  return 0;
}

debug_blackouttestlevels() {
  self endon("disconnect");
  self notifyonplayercommand("debug_startBlackout_1", "+actionslot 1");
  self notifyonplayercommand("debug_startBlackout_2", "+actionslot 4");
  self notifyonplayercommand("debug_startBlackout_3", "+actionslot 2");
  self notifyonplayercommand("debug_startBlackout_4", "+actionslot 3");
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_return_no_endon_death_3("debug_startBlackout_1", "debug_startBlackout_2", "debug_startBlackout_3", "debug_startBlackout_4");
    var_01 = strtok(var_00, "_");
    var_02 = int(var_01[2]);
    func_10D6F(self, self.origin, var_02);
    wait(0.1);
  }
}