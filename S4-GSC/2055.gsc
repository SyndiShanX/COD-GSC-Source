/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2055.gsc
*************************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_A76C = 0;
  }
}

_id_B6A0(var_0) {
  self._id_A76C++;

  if(self._id_A76C == 1) {
    _id_BF1D();
  }
}

_id_B709(var_0) {
  self._id_A76C--;

  if(self._id_A76C != 0) {
    return;
  }
  self._id_B9C4 = 0;
  self notify("leftTrigger");

  if(isDefined(self._id_BF1E)) {
    self._id_BF1E _id_58BB(0.1, 0);
  }
}

_id_E06C(var_0) {
  scripts\engine\utility::waittill_any_2("death", "leftTrigger");
  self stoploopsound();
}

_id_BF1D() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");
  self._id_B9C4 = 0;
  thread _id_E06C(self);

  for(;;) {
    self._id_B9C4++;

    switch (self._id_B9C4) {
      case 1:
        self._id_BF1F = "item_geigercouner_level2";
        self playLoopSound(self._id_BF1F);
        self _meth_844C(1, self.origin);
        break;
      case 3:
        self._id_BF1F = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self._id_BF1F);
        self _meth_844C(3, self.origin);
        _id_4E6A(15);
        break;
      case 4:
        self._id_BF1F = "item_geigercouner_level3";
        self stoploopsound();
        self playLoopSound(self._id_BF1F);
        self _meth_844C(15, self.origin);
        thread _id_2537();
        _id_4E6A(25);
        break;
      case 6:
        self._id_BF1F = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self._id_BF1F);
        self _meth_844C(75, self.origin);
        _id_4E6A(45);
        break;
      case 8:
        self._id_BF1F = "item_geigercouner_level4";
        self stoploopsound();
        self playLoopSound(self._id_BF1F);
        self _meth_844C(127, self.origin);
        _id_4E6A(175);
        break;
    }

    wait 1;
  }

  wait 5;
}

_id_2537() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");

  if(!isDefined(self._id_BF1E)) {
    self._id_BF1E = newclienthudelem(self);
    self._id_BF1E.x = 0;
    self._id_BF1E.y = 0;
    self._id_BF1E setshader("black", 640, 480);
    self._id_BF1E.alignx = "left";
    self._id_BF1E.aligny = "top";
    self._id_BF1E.horzalign = "fullscreen";
    self._id_BF1E.vertalign = "fullscreen";
    self._id_BF1E.alpha = 0;
  }

  var_0 = 1;
  var_1 = 2;
  var_2 = 0.25;
  var_3 = 1;
  var_4 = 5;
  var_5 = 100;
  var_6 = 0;

  for(;;) {
    while(self._id_B9C4 > 1) {
      var_7 = var_5 - var_4;
      var_6 = (self._id_B9C4 - var_4) / var_7;

      if(var_6 < 0) {
        var_6 = 0;
      } else if(var_6 > 1) {
        var_6 = 1;
      }

      var_8 = var_1 - var_0;
      var_9 = var_0 + var_8 * (1 - var_6);
      var_10 = var_3 - var_2;
      var_11 = var_2 + var_10 * var_6;
      var_12 = var_6 * 0.5;

      if(var_6 == 1) {
        break;
      }

      var_13 = var_9 / 2;
      self._id_BF1E _id_58B5(var_13, var_11);
      self._id_BF1E _id_58BB(var_13, var_12);
      wait(var_6 * 0.5);
    }

    if(var_6 == 1) {
      break;
    }

    if(self._id_BF1E.alpha != 0) {
      self._id_BF1E _id_58BB(1, 0);
    }

    wait 0.05;
  }

  self._id_BF1E _id_58B5(2, 0);
}

_id_4E6A(var_0) {
  self thread[[level._id_2F4C]](self, self, var_0, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0, 0, 0) - self.origin, "none", 0);
}

_id_58B5(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}

_id_58BB(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  wait(var_0);
}