/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_01_lighting.gsc
**********************************************************/

main() {
  _id_84F8();
  xbox_optimizations();
  level thread maps\mp\_utility::_id_6F74(::onplayerspawned);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 0.5;
  var_0 _meth_806B(0.45, 1.7, 1.2, 1.2, 0);
}

xbox_optimizations() {
  if(level._id_01D4 && getDvar("2695") != "true") {
    setDvar("5153", 0);
    setDvar("1578", 0);
    setDvar("5156", 0);
  } else {
    setDvar("5153", 1);
    setDvar("1578", 2);
    setDvar("5156", 1);
  }
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("4230", 400);
  setDvar("2664", 0);
  setDvar("2387", 1);
  setDvar("5156", 1);
  setDvar("2428", 2);
  setDvar("5142", 2);
  setDvar("4087", 3);
  setDvar("935", 1);
}

_id_6504(var_0, var_1) {
  if(!isDefined(self._id_A2BF)) {
    self._id_A2BF = newhudelem();
    self._id_A2BF.x = 0;
    self._id_A2BF.y = 0;
    self._id_A2BF setshader(var_1, 640, 480);
    self._id_A2BF.alignx = "left";
    self._id_A2BF.aligny = "top";
    self._id_A2BF._id_00C6 = "fullscreen";
    self._id_A2BF._id_01CA = "fullscreen";
    self._id_A2BF.alpha = var_0;
  }

  if(isDefined(self._id_A2BF) && self._id_A2BF.alpha > 0 && var_0 == 0) {
    self._id_A2BF setshader(var_1, 640, 480);
    self._id_A2BF.alpha = 0;
  }

  if(isDefined(self._id_A2BF) && self._id_A2BF.alpha < 1 && var_0 == 1) {
    self._id_A2BF setshader(var_1, 640, 480);
    self._id_A2BF.alpha = 1;
  }
}

_id_80E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = newhudelem();
  var_8.x = 0;
  var_8.y = 0;
  var_8._id_910A = 1;
  var_8.alignx = "left";
  var_8.aligny = "top";
  var_8.sort = 1;
  var_8.foreground = 0;
  var_8._id_00C6 = "fullscreen";
  var_8._id_01CA = "fullscreen";
  var_8.alpha = var_4;
  var_8 thread _id_236B();

  if(isDefined(var_5))
    var_8.x = var_5;

  if(isDefined(var_6))
    var_8.y = var_6;

  if(isDefined(var_7))
    var_8.sort = var_7;

  if(_func_0C0(var_1)) {
    foreach(var_10 in var_1)
    var_8 setshader(var_10, 640, 480);
  } else
    var_8 setshader(var_1, 640, 480);

  if(var_0 > 0) {
    var_8.alpha = 0;
    var_12 = 1;

    if(isDefined(var_2))
      var_12 = var_2;

    var_13 = 1;

    if(isDefined(var_3))
      var_13 = var_3;

    var_14 = 1;

    if(isDefined(var_4))
      var_14 = clamp(var_4, 0.0, 1.0);

    var_15 = 0.05;

    if(var_12 > 0) {
      var_16 = 0;
      var_17 = var_14 / (var_12 / var_15);

      while(var_16 < var_14) {
        var_8.alpha = var_16;
        var_16 = var_16 + var_17;
        wait(var_15);
      }
    }

    var_8.alpha = var_14;
    wait(var_0 - (var_12 + var_13));

    if(var_13 > 0) {
      var_16 = var_14;
      var_18 = var_14 / (var_13 / var_15);

      while(var_16 > 0) {
        var_8.alpha = var_16;
        var_16 = var_16 - var_18;
        wait(var_15);
      }
    }

    var_8.alpha = 0;
    var_8 destroy();
  }

  level._id_6CA4 = var_8;
  return level._id_6CA4;
}

_id_236B() {
  level waittill("end_screen_effect");
  self destroy();
}