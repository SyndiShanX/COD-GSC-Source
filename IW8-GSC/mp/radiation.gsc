/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\radiation.gsc
***********************************************/

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.numareas = 0;
  }
}

playerenterarea(var_0) {
  self.numareas++;

  if(self.numareas == 1)
    radiationeffect();
}

playerleavearea(var_0) {
  self.numareas--;

  if(self.numareas != 0) {
    return;
  }
  self.poison = 0;
  self notify("_encstr_82130C8DACCC3A51395AECB39527");

  if(isDefined(self.radiationoverlay))
    self.radiationoverlay fadeoutblackout(0.1, 0);
}

soundwatcher(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_82130C8DACCC3A51395AECB39527");
  self stoploopsound();
}

radiationeffect() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_82130C8DACCC3A51395AECB39527");
  self.poison = 0;
  thread soundwatcher(self);

  for(;;) {
    self.poison++;

    switch (self.poison) {
      case 1:
        self.radiationsound = "_encstr_8CE919A5D1CAADD73B56B4B3B29336ED5DB9AC93FA1B56D95963C8";
        self playLoopSound(self.radiationsound);
        self viewkick(1, self.origin);
        break;
      case 3:
        self.radiationsound = "_encstr_9AE91960FB4D889F6A4FBBB4A7D32F30A57B9830EFECC1B512358E";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(3, self.origin);
        doradiationdamage(15);
        break;
      case 4:
        self.radiationsound = "_encstr_9AE91960FB4D889F6A4FBBB4A7D32F30A57B9830EFECC1B512358E";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(15, self.origin);
        thread blackout();
        doradiationdamage(25);
        break;
      case 6:
        self.radiationsound = "_encstr_AFE9194B4756DAF5CE2B4B3B9539C6BD5D37569CF5C62BECCAB11A";
        self stoploopsound();
        self playLoopSound(self.radiationsound);
        self viewkick(75, self.origin);
        doradiationdamage(45);
        break;
      case 8:
        self.radiationsound = "_encstr_AFE9194B4756DAF5CE2B4B3B9539C6BD5D37569CF5C62BECCAB11A";
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
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_82130C8DACCC3A51395AECB39527");

  if(!isDefined(self.radiationoverlay)) {
    self.radiationoverlay = newclienthudelem(self);
    self.radiationoverlay.x = 0;
    self.radiationoverlay.y = 0;
    self.radiationoverlay setshader("_encstr_83AB065EE1391A7B", 640, 480);
    self.radiationoverlay.alignx = "_encstr_A5AD056A019C63";
    self.radiationoverlay.aligny = "_encstr_AC190479FF92";
    self.radiationoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    self.radiationoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
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
      var_6 = (self.poison - var_4) / var_7;

      if(var_6 < 0)
        var_6 = 0;
      else if(var_6 > 1)
        var_6 = 1;

      var_8 = var_1 - var_0;
      var_9 = var_0 + var_8 * (1 - var_6);
      var_10 = var_3 - var_2;
      var_11 = var_2 + var_10 * var_6;
      var_12 = var_6 * 0.5;

      if(var_6 == 1) {
        break;
      }

      var_13 = var_9 / 2;
      self.radiationoverlay fadeinblackout(var_13, var_11);
      self.radiationoverlay fadeoutblackout(var_13, var_12);
      wait(var_6 * 0.5);
    }

    if(var_6 == 1) {
      break;
    }

    if(self.radiationoverlay.alpha != 0)
      self.radiationoverlay fadeoutblackout(1, 0);

    wait 0.05;
  }

  self.radiationoverlay fadeinblackout(2, 0);
}

doradiationdamage(var_0) {
  self thread[[level.callbackplayerdamage]](self, self, var_0, 0, "_encstr_AB590C99ED78875F650F3951034D", "_encstr_ACC40CC1F8A321601715CFBFE0EA", self.origin, (0, 0, 0) - self.origin, "_encstr_8BBA05185F8B99", 0);
}

fadeinblackout(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}

fadeoutblackout(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}