/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2787.gsc
***************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.numareas = 0;
  }
}

playerenterarea(var_00) {
  self.numareas++;

  if(self.numareas == 1) {
    radiationeffect();
  }
}

playerleavearea(var_00) {
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

soundwatcher(var_00) {
  scripts\engine\utility::waittill_any("death", "leftTrigger");
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
        self.func_DBEA = "item_geigercouner_level2";
        self playLoopSound(self.func_DBEA);
        self viewkick(1, self.origin);
        break;
      case 3:
        self shellshock("mp_radiation_low", 4);
        self.func_DBEA = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.func_DBEA);
        self viewkick(3, self.origin);
        doradiationdamage(15);
        break;
      case 4:
        self shellshock("mp_radiation_med", 5);
        self.func_DBEA = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self.func_DBEA);
        self viewkick(15, self.origin);
        thread func_2B48();
        doradiationdamage(25);
        break;
      case 6:
        self shellshock("mp_radiation_high", 5);
        self.func_DBEA = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.func_DBEA);
        self viewkick(75, self.origin);
        doradiationdamage(45);
        break;
      case 8:
        self shellshock("mp_radiation_high", 5);
        self.func_DBEA = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self.func_DBEA);
        self viewkick(127, self.origin);
        doradiationdamage(175);
        break;
    }

    wait 1;
  }

  wait 5;
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

  var_00 = 1;
  var_01 = 2;
  var_02 = 0.25;
  var_03 = 1;
  var_04 = 5;
  var_05 = 100;
  var_06 = 0;

  for(;;) {
    while(self.poison > 1) {
      var_07 = var_05 - var_04;
      var_06 = (self.poison - var_04) / var_07;

      if(var_06 < 0) {
        var_06 = 0;
      }
      else if(var_06 > 1) {
        var_06 = 1;
      }

      var_08 = var_01 - var_00;
      var_09 = var_00 + var_08 * (1 - var_06);
      var_10 = var_03 - var_02;
      var_11 = var_02 + var_10 * var_06;
      var_12 = var_06 * 0.5;

      if(var_06 == 1) {
        break;
      }
      var_13 = var_09 / 2;
      self.radiationoverlay func_6AB7(var_13, var_11);
      self.radiationoverlay fadeoutblackout(var_13, var_12);
      wait(var_06 * 0.5);
    }

    if(var_06 == 1) {
      break;
    }
    if(self.radiationoverlay.alpha != 0) {
      self.radiationoverlay fadeoutblackout(1, 0);
    }

    wait 0.05;
  }

  self.radiationoverlay func_6AB7(2, 0);
}

doradiationdamage(var_00) {
  self thread[[level.callbackplayerdamage]](self, self, var_00, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0, 0, 0) - self.origin, "none", 0);
}

func_6AB7(var_00, var_01) {
  self fadeovertime(var_00);
  self.alpha = var_01;
  wait(var_00);
}

fadeoutblackout(var_00, var_01) {
  self fadeovertime(var_00);
  self.alpha = var_01;
  wait(var_00);
}