/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chill_common.gsc
***************************************************/

function chill_init() {
  var_0 = spawnStruct();
  var_0.blindparts = [];
  var_0.blindstates = [];
  var_0.blinddurations = [];
  var_0.blindparts[0] = "chilledInit";
  var_0.blindstates[0] = "activeWeak";
  var_0.blinddurations[0] = 2;
  var_0.blindparts[1] = "chilledInit";
  var_0.blindstates[1] = "active";
  var_0.blinddurations[1] = 2;
  level.chill_data = var_0;
}

function chill(var_0, var_1) {
  if(!isDefined(self.chill_data)) {
    self.chill_data = spawnStruct();
  }

  var_2 = self.chill_data;
  thread chill_blind();

  if(!isDefined(var_2.active)) {
    self notify("chill");
    var_2.active = 1;
    var_2.speedmod = 0;
    var_2.times = [];
    var_1 *= 1000;
    var_3 = gettime();
    var_4 = var_3 + var_1;
    var_2.times[var_0] = (var_3, var_4, var_1);
    chill_impair();
    self setscriptablepartstate("chilled", "active", 0);
    thread chill_update();
    return;
  }

  if(!isDefined(var_4.times[var_2])) {
    var_4.active++;
  }

  var_3 *= 1000;
  var_3 = gettime();
  var_4 = var_3 + var_3;
  var_4.times[var_2] = (var_3, var_4, var_3);
}

function chillend(var_0) {
  var_1 = self.chill_data;
  var_1.active--;
  var_1.times[var_0] = undefined;

  if(var_1.active == 0) {
    self notify("chillEnd");
    chill_impairend();
    self setscriptablepartstate("chilled", "neutral", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function ischilled() {
  var_0 = self.chill_data;
  return isDefined(var_0) && isDefined(var_0.active);
}

function chill_resetdata() {
  self notify("chillReset");
  self.chill_data = undefined;
}

function chill_resetscriptable() {
  self setscriptablepartstate("chilled", "neutral", 0);

  foreach(var_1 in level.chill_data.blindparts) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }
}

function chill_impair() {
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_slide(0);
  scripts\common\utility::allow_wallrun(0);
  scripts\common\utility::allow_mantle(0);
}

function chill_impairend() {
  scripts\common\utility::allow_sprint(1);
  scripts\common\utility::allow_slide(1);
  scripts\common\utility::allow_wallrun(1);
  scripts\common\utility::allow_mantle(1);
}

function chill_blind() {
  self endon("death_or_disconnect");
  var_0 = self.chill_data;
  var_1 = level.chill_data;
  var_2 = var_0.blindid;
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance"), 0, 1);
  var_4 = var_1.blindparts[var_3];
  var_5 = var_1.blindstates[var_3];
  var_6 = var_1.blinddurations[var_3];

  if(!isDefined(var_2)) {
    self setscriptablepartstate(var_4, var_5, 0);
    var_0.blindid = var_3;
  } else {
    if(var_2 > var_3) {
      return;
    }

    var_7 = var_1.blindparts[var_2];

    if(var_7 != var_4) {
      self setscriptablepartstate(var_7, "neutral", 0);
    }

    self setscriptablepartstate(var_4, var_5, 0);
    var_0.blindid = var_3;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::ref_143B9(var_6, "chillEnd");
  self setscriptablepartstate(var_4, "neutral", 0);
  var_0.blindid = undefined;
}

function chill_update() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  var_0 = self.chill_data;

  for(;;) {
    var_1 = gettime();
    var_2 = 0;

    foreach(var_4 in var_0.times) {
      var_5 = var_4[0];
      var_6 = var_4[1];
      var_7 = var_4[2];

      if(var_1 < var_6) {
        var_8 = var_1 - var_5;
        var_9 = 1 - var_8 / var_7;

        if(var_9 > var_2) {
          var_2 = var_9;
        }

        continue;
      }

      thread chillend(var_10);
    }

    var_0.speedmod = var_2 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}