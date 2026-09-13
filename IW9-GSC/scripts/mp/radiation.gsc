/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\radiation.gsc
***********************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.numareas = 0;
  }
}

playerenterarea(trigger) {
  self.numareas++;

  if(self.numareas == 1)
    radiationeffect();
}

playerleavearea(trigger) {
  self.numareas--;

  if(self.numareas != 0) {
    return;
  }
  self.poison = 0;
  self notify("leftTrigger");

  if(isDefined(self.radiationoverlay))
    self.radiationoverlay fadeoutblackout(0.1, 0);
}

soundwatcher(_id_4CF58793CC4F1AD6) {
  scripts\engine\utility::waittill_any_2("death", "leftTrigger");
  self stoploopsound();
}

radiationeffect() {
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

blackout() {
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

  _id_9D575B46AA2771B0 = 1;
  _id_EA06B331E1F4081A = 2;
  _id_8237EACF859DFB80 = 0.25;
  _id_0488CF627600F486 = 1;
  _id_387334F9BF4CD1C5 = 5;
  _id_E2209E013BA9B457 = 100;
  fraction = 0;

  for(;;) {
    while(self.poison > 1) {
      _id_67FEC5F745DE9AE8 = _id_E2209E013BA9B457 - _id_387334F9BF4CD1C5;
      fraction = (self.poison - _id_387334F9BF4CD1C5) / _id_67FEC5F745DE9AE8;

      if(fraction < 0)
        fraction = 0;
      else if(fraction > 1)
        fraction = 1;

      _id_61627E6F9FF7862F = _id_EA06B331E1F4081A - _id_9D575B46AA2771B0;
      length = _id_9D575B46AA2771B0 + _id_61627E6F9FF7862F * (1 - fraction);
      _id_58373CC29306836D = _id_0488CF627600F486 - _id_8237EACF859DFB80;
      alpha = _id_8237EACF859DFB80 + _id_58373CC29306836D * fraction;
      _id_A8C0283B948A1EBD = fraction * 0.5;

      if(fraction == 1) {
        break;
      }

      duration = length / 2;
      self.radiationoverlay fadeinblackout(duration, alpha);
      self.radiationoverlay fadeoutblackout(duration, _id_A8C0283B948A1EBD);
      wait(fraction * 0.5);
    }

    if(fraction == 1) {
      break;
    }

    if(self.radiationoverlay.alpha != 0)
      self.radiationoverlay fadeoutblackout(1, 0);

    wait 0.05;
  }

  self.radiationoverlay fadeinblackout(2, 0);
}

doradiationdamage(idamage) {
  self thread[[level.callbackplayerdamage]](self, self, idamage, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0, 0, 0) - self.origin, "none", 0);
}

fadeinblackout(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

fadeoutblackout(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}