/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_flashgrenades.gsc
**********************************************/

main() {
  _precacheshellshock("flashbang_mp");
}

_id_92E8() {
  thread _id_6394();
}

_id_940E(var_0) {
  self notify("stop_monitoring_flash");
}

_id_3D58(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    waitframe();
  }
}

_id_6394() {
  self endon("disconnect");
  self notify("monitorFlash");
  self endon("monitorFlash");
  self._id_3D48 = 0;
  self._id_8C5E = 0;
  var_0 = 2.5;

  for(;;) {
    self waittill("flashbang", var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isalive(self)) {
      break;
    }

    if(isDefined(self.usingremote)) {
      continue;
    }
    if(!isDefined(var_6))
      var_6 = 0;

    var_7 = 0;
    var_8 = 1;

    if(var_3 < 0.25)
      var_3 = 0.25;
    else if(var_3 > 0.8)
      var_3 = 1;

    var_9 = var_2 * var_3 * var_0;
    var_9 = var_9 + var_6;
    var_10 = 0;

    if(isDefined(self._id_94BE)) {
      var_9 = var_9 * self._id_94BE;

      if(self._id_94BE == 0.1)
        var_10 = 1;
    }

    if(var_9 < 0.25) {
      continue;
    }
    var_11 = undefined;

    if(var_9 > 2)
      var_11 = 0.75;
    else
      var_11 = 0.25;

    if(level.teambased && isDefined(var_4) && isDefined(var_4.team) && var_4.team == self.team && var_4 != self) {
      if(level._id_3EC4 == 0)
        continue;
      else if(level._id_3EC4 == 1) {} else if(level._id_3EC4 == 2) {
        var_9 = var_9 * 0.5;
        var_11 = var_11 * 0.5;
        var_8 = 0;
        var_7 = 1;
      } else if(level._id_3EC4 == 3) {
        var_9 = var_9 * 0.5;
        var_11 = var_11 * 0.5;
        var_7 = 1;
      }
    } else if(isDefined(var_4)) {
      if(var_4 != self)
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_indecentexposure");
    }

    if(var_8 && isDefined(self)) {
      thread _id_0F33(var_9, var_11, var_10);

      if(isDefined(var_4) && var_4 != self) {
        var_4 thread _id_04C7::_id_A102("flash");
        var_12 = self;

        if(isPlayer(var_4) && var_4 maps\mp\_utility::_hasperk("specialty_paint"))
          var_12 thread _id_052C::_id_86ED(var_4, 0);
      }
    }

    if(var_7 && isDefined(var_4))
      var_4 thread _id_0F33(var_9, var_11);
  }
}

_id_0F33(var_0, var_1, var_2) {
  if(!isDefined(self._id_3D46) || var_0 > self._id_3D46)
    self._id_3D46 = var_0;

  if(!isDefined(self._id_3D57) || var_1 > self._id_3D57)
    self._id_3D57 = var_1;

  waitframe();

  if(isDefined(self._id_3D46)) {
    self shellshock("flashbang_mp", self._id_3D46);
    self._id_3D48 = gettime() + self._id_3D46 * 1000;

    if(var_2) {
      self._id_8C5C = self._id_3D46 * 10;
      self._id_8C5E = gettime() + self._id_8C5C * 1000;
    }
  }

  if(isDefined(self._id_3D57))
    thread _id_3D58(self._id_3D57);

  self._id_3D46 = undefined;
  self._id_3D57 = undefined;
}

isflashbanged() {
  return isDefined(self._id_3D48) && gettime() < self._id_3D48;
}