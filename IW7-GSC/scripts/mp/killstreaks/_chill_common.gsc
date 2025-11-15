/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_chill_common.gsc
****************************************************/

chill_init() {
  var_00 = spawnStruct();
  var_00.blindparts = [];
  var_00.blindstates = [];
  var_00.blinddurations = [];
  var_00.blindparts[0] = "chilledInit";
  var_00.blindstates[0] = "activeWeak";
  var_00.blinddurations[0] = 2;
  var_00.blindparts[1] = "chilledInit";
  var_00.blindstates[1] = "active";
  var_00.blinddurations[1] = 2;
  level.chill_data = var_00;
}

chill(param_00, param_01) {
  if(!isDefined(self.chill_data)) {
    self.chill_data = spawnStruct();
  }

  var_02 = self.chill_data;
  thread chill_blind();
  if(!isDefined(var_02.var_19)) {
    self notify("chill");
    var_02.var_19 = 1;
    var_02.speedmod = 0;
    var_02.times = [];
    param_01 = param_01 * 1000;
    var_03 = gettime();
    var_04 = var_03 + param_01;
    var_02.times[param_00] = (var_03, var_04, param_01);
    chill_impair();
    self setscriptablepartstate("chilled", "active", 0);
    thread chill_update();
    return;
  }

  if(!isDefined(var_04.times[var_02])) {
    var_04.var_19++;
  }

  var_03 = var_03 * 1000;
  var_03 = gettime();
  var_04 = var_04 + var_02;
  var_02.times[param_00] = (var_03, var_04, param_01);
}

chillend(param_00) {
  var_01 = self.chill_data;
  var_01.var_19--;
  var_01.times[param_00] = undefined;
  if(var_01.var_19 == 0) {
    self notify("chillEnd");
    chill_impairend();
    self setscriptablepartstate("chilled", "neutral", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

ischilled() {
  var_00 = self.chill_data;
  return isDefined(var_00) && isDefined(var_00.var_19);
}

chill_resetdata() {
  self notify("chillReset");
  self.chill_data = undefined;
}

chill_resetscriptable() {
  self setscriptablepartstate("chilled", "neutral", 0);
  foreach(var_01 in level.chill_data.blindparts) {
    self setscriptablepartstate(var_01, "neutral", 0);
  }
}

chill_impair() {
  scripts\engine\utility::allow_sprint(0);
  scripts\engine\utility::allow_slide(0);
  scripts\engine\utility::allow_wallrun(0);
  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(0);
  }

  scripts\engine\utility::allow_mantle(0);
}

chill_impairend() {
  scripts\engine\utility::allow_sprint(1);
  scripts\engine\utility::allow_slide(1);
  scripts\engine\utility::allow_wallrun(1);
  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(1);
  }

  scripts\engine\utility::allow_mantle(1);
}

chill_blind() {
  self endon("death");
  self endon("disconnect");
  var_00 = self.chill_data;
  var_01 = level.chill_data;
  var_02 = var_00.var_2B9B;
  var_03 = scripts\engine\utility::ter_op(scripts\mp\utility::_hasperk("specialty_stun_resistance"), 0, 1);
  var_04 = var_01.blindparts[var_03];
  var_05 = var_01.blindstates[var_03];
  var_06 = var_01.blinddurations[var_03];
  if(!isDefined(var_02)) {
    self setscriptablepartstate(var_04, var_05, 0);
    var_00.var_2B9B = var_03;
  } else {
    if(var_02 > var_03) {
      return;
    }

    var_07 = var_01.blindparts[var_02];
    if(var_07 != var_04) {
      self setscriptablepartstate(var_07, "neutral", 0);
    }

    self setscriptablepartstate(var_04, var_05, 0);
    var_00.var_2B9B = var_03;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::waittill_any_timeout_1(var_06, "chillEnd");
  self setscriptablepartstate(var_04, "neutral", 0);
  var_00.var_2B9B = undefined;
}

chill_update() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  var_00 = self.chill_data;
  for(;;) {
    var_01 = gettime();
    var_02 = 0;
    foreach(var_0A, var_04 in var_00.times) {
      var_05 = var_04[0];
      var_06 = var_04[1];
      var_07 = var_04[2];
      if(var_01 < var_06) {
        var_08 = var_01 - var_05;
        var_09 = 1 - var_08 / var_07;
        if(var_09 > var_02) {
          var_02 = var_09;
        }

        continue;
      }

      thread chillend(var_0A);
    }

    var_00.speedmod = var_02 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait(0.1);
  }
}