/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\radiation.gsc
***********************************************/

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    var0.numareas = 0;
  }
}

function playerenterarea(var0) {
  self.numareas++;

  if(self.numareas == 1) {
    radiationeffect();
    return;
  }
}

function playerleavearea(var0) {
  self.numareas--;

  if(self.numareas != 0) {
    return;
  }

  self.poison = 0;
  self notify("leftTrigger");

  if(isDefined(self.radiationoverlay)) {
    fadeoutblackout(self.radiationoverlay, 0.1, 0);
    return;
  }
}

function soundwatcher(var0) {
  scripts\engine\utility::ref_143a5("death", "leftTrigger");
  self stoploopsound();
}

function radiationeffect() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");
  self.poison = 0;
  thread soundwatcher(self);

  for(;;) {
    self.poison++;

    switch (self.poison) {
      case 1:
        self.radiationsound = "item_geigercouner_level2";
        self playLoopSound(self.radiationsound);
        self viewkick(1, self.origin);
        break;
      case 3:
        self.radiationsound = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(3, self.origin);
        doradiationdamage(15);
        break;
      case 4:
        self.radiationsound = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(15, self.origin);
        thread blackout();
        doradiationdamage(25);
        break;
      case 6:
        self.radiationsound = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(75, self.origin);
        doradiationdamage(45);
        break;
      case 8:
        self.radiationsound = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(127, self.origin);
        doradiationdamage(175);
        break;
    }

    wait 1;
  }

  wait 5;
}

function blackout() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");

  if(!isDefined(self.radiationoverlay)) {
    self.radiationoverlay = newclienthudelem(self);
    self.radiationoverlay.x = 0;
    self.radiationoverlay.y = 0;
    self.radiationoverlay setshader("black", 640, 480);
    self.radiationoverlay.alignx = "left";
    self.radiationoverlay.aligny = "top";
    self.radiationoverlay.horzalign = "fullscreen";
    self.radiationoverlay.vertalign = "fullscreen";
    self.radiationoverlay.alpha = 0;
  }

  var0 = 1;
  var1 = 2;
  var2 = 0.25;
  var3 = 1;
  var4 = 5;
  var5 = 100;
  var6 = 0;

  for(;;) {
    while(self.poison > 1) {
      var7 = var5 - var4;
      var6 = (self.poison - var4) / var7;

      if(var6 < 0) {
        var6 = 0;
      } else if(var6 > 1) {
        var6 = 1;
      }

      var8 = var1 - var0;
      var9 = var0 + var8 * (1 - var6);
      var10 = var3 - var2;
      var11 = var2 + var10 * var6;
      var12 = var6 * 0.5;

      if(var6 == 1) {
        break;
      }

      var13 = var9 / 2;
      fadeinblackout(self.radiationoverlay, var13, var11);
      fadeoutblackout(self.radiationoverlay, var13, var12);
      wait var6 * 0.5;
    }

    if(var6 == 1) {
      break;
    }

    if(self.radiationoverlay.alpha != 0) {
      fadeoutblackout(self.radiationoverlay, 1, 0);
    }

    wait 0.05;
  }

  fadeinblackout(self.radiationoverlay, 2, 0);
}

function doradiationdamage(var0) {
  self thread[[level.callbackplayerdamage]](self, self, var0, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0, 0, 0) - self.origin, "none", 0);
}

function fadeinblackout(var0, var1) {
  self fadeovertime(var0);
  self.alpha = var1;
  wait var0;
}

function fadeoutblackout(var0, var1) {
  self fadeovertime(var0);
  self.alpha = var1;
  wait var0;
}