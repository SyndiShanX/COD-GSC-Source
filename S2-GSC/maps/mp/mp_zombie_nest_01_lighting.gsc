/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_01_lighting.gsc
**************************************************/

main() {
  func_84F8();
  xbox_optimizations();
  level thread maps\mp\_utility::func_6F74(::onplayerspawned);
}

onplayerspawned() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(0.5);
  var_00 vignettesetparams(0.45, 1.7, 1.2, 1.2, 0);
}

xbox_optimizations() {
  if(level.var_1D4 && getDvar("2695") != "true") {
    setDvar("5153", 0);
    setDvar("1578", 0);
    setDvar("5156", 0);
    return;
  }

  setDvar("5153", 1);
  setDvar("1578", 2);
  setDvar("5156", 1);
}

func_84F8() {
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

func_6504(param_00, param_01) {
  if(!isDefined(self.var_A2BF)) {
    self.var_A2BF = newhudelem();
    self.var_A2BF.x = 0;
    self.var_A2BF.y = 0;
    self.var_A2BF setshader(param_01, 640, 480);
    self.var_A2BF.alignx = "left";
    self.var_A2BF.aligny = "top";
    self.var_A2BF.horzalign = "fullscreen";
    self.var_A2BF.vertalign = "fullscreen";
    self.var_A2BF.alpha = param_00;
  }

  if(isDefined(self.var_A2BF) && self.var_A2BF.alpha > 0 && param_00 == 0) {
    self.var_A2BF setshader(param_01, 640, 480);
    self.var_A2BF.alpha = 0;
  }

  if(isDefined(self.var_A2BF) && self.var_A2BF.alpha < 1 && param_00 == 1) {
    self.var_A2BF setshader(param_01, 640, 480);
    self.var_A2BF.alpha = 1;
  }
}

func_80E4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = newhudelem();
  var_08.x = 0;
  var_08.y = 0;
  var_08.var_910A = 1;
  var_08.alignx = "left";
  var_08.aligny = "top";
  var_08.sort = 1;
  var_08.foreground = 0;
  var_08.horzalign = "fullscreen";
  var_08.vertalign = "fullscreen";
  var_08.alpha = param_04;
  var_08 thread func_236B();
  if(isDefined(param_05)) {
    var_08.x = param_05;
  }

  if(isDefined(param_06)) {
    var_08.y = param_06;
  }

  if(isDefined(param_07)) {
    var_08.sort = param_07;
  }

  if(isarray(param_01)) {
    foreach(var_0A in param_01) {
      var_08 setshader(var_0A, 640, 480);
    }
  } else {
    var_08 setshader(param_01, 640, 480);
  }

  if(param_00 > 0) {
    var_08.alpha = 0;
    var_0C = 1;
    if(isDefined(param_02)) {
      var_0C = param_02;
    }

    var_0D = 1;
    if(isDefined(param_03)) {
      var_0D = param_03;
    }

    var_0E = 1;
    if(isDefined(param_04)) {
      var_0E = clamp(param_04, 0, 1);
    }

    var_0F = 0.05;
    if(var_0C > 0) {
      var_10 = 0;
      var_11 = var_0E / var_0C / var_0F;
      while(var_10 < var_0E) {
        var_08.alpha = var_10;
        var_10 = var_10 + var_11;
        wait(var_0F);
      }
    }

    var_08.alpha = var_0E;
    wait(param_00 - var_0C + var_0D);
    if(var_0D > 0) {
      var_10 = var_0E;
      var_12 = var_0E / var_0D / var_0F;
      while(var_10 > 0) {
        var_08.alpha = var_10;
        var_10 = var_10 - var_12;
        wait(var_0F);
      }
    }

    var_08.alpha = 0;
    var_08 destroy();
  }

  level.var_6CA4 = var_08;
  return level.var_6CA4;
}

func_236B() {
  level waittill("end_screen_effect");
  self destroy();
}