/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chill_common.gsc
***************************************************/

function chill_init() {
  var0 = spawnStruct();
  var0.blindparts = [];
  var0.blindstates = [];
  var0.blinddurations = [];
  var0.blindparts[0] = "chilledInit";
  var0.blindstates[0] = "activeWeak";
  var0.blinddurations[0] = 2;
  var0.blindparts[1] = "chilledInit";
  var0.blindstates[1] = "active";
  var0.blinddurations[1] = 2;
  level.chill_data = var0;
}

function chill(var0, var1) {
  if(!isDefined(self.chill_data)) {
    self.chill_data = spawnStruct();
  }

  var2 = self.chill_data;
  thread chill_blind();

  if(!isDefined(var2.active)) {
    self notify("chill");
    var2.active = 1;
    var2.speedmod = 0;
    var2.times = [];
    var1 *= 1000;
    var3 = gettime();
    var4 = var3 + var1;
    var2.times[var0] = (var3, var4, var1);
    chill_impair();
    self setscriptablepartstate("chilled", "active", 0);
    thread chill_update();
    return;
  }

  if(!isDefined(var4.times[var2])) {
    var4.active++;
  }

  var3 *= 1000;
  var3 = gettime();
  var4 = var3 + var3;
  var4.times[var2] = (var3, var4, var3);
}

function chillend(var0) {
  var1 = self.chill_data;
  var1.active--;
  var1.times[var0] = undefined;

  if(var1.active == 0) {
    self notify("chillEnd");
    chill_impairend();
    self setscriptablepartstate("chilled", "neutral", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function ischilled() {
  var0 = self.chill_data;
  return isDefined(var0) && isDefined(var0.active);
}

function chill_resetdata() {
  self notify("chillReset");
  self.chill_data = undefined;
}

function chill_resetscriptable() {
  self setscriptablepartstate("chilled", "neutral", 0);

  foreach(var1 in level.chill_data.blindparts) {
    self setscriptablepartstate(var1, "neutral", 0);
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
  var0 = self.chill_data;
  var1 = level.chill_data;
  var2 = var0.blindid;
  var3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance"), 0, 1);
  var4 = var1.blindparts[var3];
  var5 = var1.blindstates[var3];
  var6 = var1.blinddurations[var3];

  if(!isDefined(var2)) {
    self setscriptablepartstate(var4, var5, 0);
    var0.blindid = var3;
  } else {
    if(var2 > var3) {
      return;
    }

    var7 = var1.blindparts[var2];

    if(var7 != var4) {
      self setscriptablepartstate(var7, "neutral", 0);
    }

    self setscriptablepartstate(var4, var5, 0);
    var0.blindid = var3;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::ref_143b9(var6, "chillEnd");
  self setscriptablepartstate(var4, "neutral", 0);
  var0.blindid = undefined;
}

function chill_update() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  var0 = self.chill_data;

  for(;;) {
    var1 = gettime();
    var2 = 0;

    foreach(var4 in var0.times) {
      var5 = var4[0];
      var6 = var4[1];
      var7 = var4[2];

      if(var1 < var6) {
        var8 = var1 - var5;
        var9 = 1 - var8 / var7;

        if(var9 > var2) {
          var2 = var9;
        }

        continue;
      }

      thread chillend(var10);
    }

    var0.speedmod = var2 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}