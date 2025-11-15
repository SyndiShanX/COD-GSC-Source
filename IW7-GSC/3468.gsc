/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3468.gsc
***************************************/

chill_init() {
  var_00 = spawnStruct();
  var_0.blindparts = [];
  var_0.blindstates = [];
  var_0.blinddurations = [];
  var_0.blindparts[0] = "chilledInit";
  var_0.blindstates[0] = "activeWeak";
  var_0.blinddurations[0] = 2;
  var_0.blindparts[1] = "chilledInit";
  var_0.blindstates[1] = "active";
  var_0.blinddurations[1] = 2;
  level.chill_data = var_00;
}

chill(var_00, var_01) {
  if(!isDefined(self.chill_data))
    self.chill_data = spawnStruct();

  var_02 = self.chill_data;
  thread chill_blind();

  if(!isDefined(var_2.active)) {
    self notify("chill");
    var_2.active = 1;
    var_2.speedmod = 0;
    var_2.times = [];
    var_01 = var_01 * 1000;
    var_03 = gettime();
    var_04 = var_03 + var_01;
    var_2.times[var_00] = (var_03, var_04, var_01);
    chill_impair();
    self setscriptablepartstate("chilled", "active", 0);
    thread chill_update();
  } else {
    if(!isDefined(var_2.times[var_00]))
      var_2.active++;

    var_01 = var_01 * 1000;
    var_03 = gettime();
    var_04 = var_03 + var_01;
    var_2.times[var_00] = (var_03, var_04, var_01);
  }
}

chillend(var_00) {
  var_01 = self.chill_data;
  var_1.active--;
  var_1.times[var_00] = undefined;

  if(var_1.active == 0) {
    self notify("chillEnd");
    chill_impairend();
    self setscriptablepartstate("chilled", "neutral", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

ischilled() {
  var_00 = self.chill_data;
  return isDefined(var_00) && isDefined(var_0.active);
}

chill_resetdata() {
  self notify("chillReset");
  self.chill_data = undefined;
}

chill_resetscriptable() {
  self setscriptablepartstate("chilled", "neutral", 0);

  foreach(var_01 in level.chill_data.blindparts)
  self setscriptablepartstate(var_01, "neutral", 0);
}

chill_impair() {
  scripts\engine\utility::allow_sprint(0);
  scripts\engine\utility::allow_slide(0);
  scripts\engine\utility::allow_wallrun(0);

  if(!level.tactical)
    scripts\engine\utility::allow_doublejump(0);

  scripts\engine\utility::allow_mantle(0);
}

chill_impairend() {
  scripts\engine\utility::allow_sprint(1);
  scripts\engine\utility::allow_slide(1);
  scripts\engine\utility::allow_wallrun(1);

  if(!level.tactical)
    scripts\engine\utility::allow_doublejump(1);

  scripts\engine\utility::allow_mantle(1);
}

chill_blind() {
  self endon("death");
  self endon("disconnect");
  var_00 = self.chill_data;
  var_01 = level.chill_data;
  var_02 = var_0.func_2B9B;
  var_03 = scripts\engine\utility::ter_op(scripts\mp\utility\game::_hasperk("specialty_stun_resistance"), 0, 1);
  var_04 = var_1.blindparts[var_03];
  var_05 = var_1.blindstates[var_03];
  var_06 = var_1.blinddurations[var_03];

  if(!isDefined(var_02)) {
    self setscriptablepartstate(var_04, var_05, 0);
    var_0.func_2B9B = var_03;
  } else {
    if(var_02 > var_03) {
      return;
    }
    var_07 = var_1.blindparts[var_02];

    if(var_07 != var_04)
      self setscriptablepartstate(var_07, "neutral", 0);

    self setscriptablepartstate(var_04, var_05, 0);
    var_0.func_2B9B = var_03;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::waittill_any_timeout(var_06, "chillEnd");
  self setscriptablepartstate(var_04, "neutral", 0);
  var_0.func_2B9B = undefined;
}

chill_update() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  var_00 = self.chill_data;

  for(;;) {
    var_01 = gettime();
    var_02 = 0;

    foreach(var_10, var_04 in var_0.times) {
      var_05 = var_4[0];
      var_06 = var_4[1];
      var_07 = var_4[2];

      if(var_01 < var_06) {
        var_08 = var_01 - var_05;
        var_09 = 1 - var_08 / var_07;

        if(var_09 > var_02)
          var_02 = var_09;

        continue;
      }

      thread chillend(var_10);
    }

    var_0.speedmod = var_02 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}