/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\radiation.gsc
*********************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.numareas = 0;
  }
}

playerenterarea(var_0) {
  self.numareas++;
  if(self.numareas == 1) {
    radiationeffect();
  }
}

playerleavearea(var_0) {
  self.numareas--;
  if(self.numareas != 0) {
    return;
  }

  self.poison = 0;
  self notify("leftTrigger");
  if(isDefined(self.radiationoverlay)) {
    self.radiationoverlay fadeoutblackout(0.1, 0);
  }
}

soundwatcher(var_0) {
  scripts\engine\utility::waittill_any_3("death", "leftTrigger");
  self stoploopsound();
}

radiationeffect() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("leftTrigger");
  self.poison = 0;
  thread soundwatcher(self);
  for(;;) {
    self.poison++;
    switch (self.poison) {
      case 1:
        self.var_DBEA = "item_geigercouner_level2";
        self playLoopSound(self.var_DBEA);
        self viewkick(1, self.origin);
        break;

      case 3:
        self shellshock("mp_radiation_low", 4);
        self.var_DBEA = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.var_DBEA);
        self viewkick(3, self.origin);
        doradiationdamage(15);
        break;

      case 4:
        self shellshock("mp_radiation_med", 5);
        self.var_DBEA = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.var_DBEA);
        self viewkick(15, self.origin);
        thread func_2B48();
        doradiationdamage(25);
        break;

      case 6:
        self shellshock("mp_radiation_high", 5);
        self.var_DBEA = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.var_DBEA);
        self viewkick(75, self.origin);
        doradiationdamage(45);
        break;

      case 8:
        self shellshock("mp_radiation_high", 5);
        self.var_DBEA = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.var_DBEA);
        self viewkick(127, self.origin);
        doradiationdamage(175);
        break;
    }

    wait(1);
  }

  wait(5);
}

func_2B48() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
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

  var_0 = 1;
  var_1 = 2;
  var_2 = 0.25;
  var_3 = 1;
  var_4 = 5;
  var_5 = 100;
  var_6 = 0;
  for(;;) {
    while(self.poison > 1) {
      var_7 = var_5 - var_4;
      var_6 = self.poison - var_4 / var_7;
      if(var_6 < 0) {
        var_6 = 0;
      } else if(var_6 > 1) {
        var_6 = 1;
      }

      var_8 = var_1 - var_0;
      var_9 = var_0 + var_8 * 1 - var_6;
      var_0A = var_3 - var_2;
      var_0B = var_2 + var_0A * var_6;
      var_0C = var_6 * 0.5;
      if(var_6 == 1) {
        break;
      }

      var_0D = var_9 / 2;
      self.radiationoverlay func_6AB7(var_0D, var_0B);
      self.radiationoverlay fadeoutblackout(var_0D, var_0C);
      wait(var_6 * 0.5);
    }

    if(var_6 == 1) {
      break;
    }

    if(self.radiationoverlay.alpha != 0) {
      self.radiationoverlay fadeoutblackout(1, 0);
    }

    wait(0.05);
  }

  self.radiationoverlay func_6AB7(2, 0);
}

doradiationdamage(var_0) {
  self thread[[level.callbackplayerdamage]](self, self, var_0, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0, 0, 0) - self.origin, "none", 0);
}

func_6AB7(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}

fadeoutblackout(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}