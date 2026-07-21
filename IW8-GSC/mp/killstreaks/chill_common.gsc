/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\chill_common.gsc
***********************************************/

chill_init() {
  var_0 = spawnStruct();
  var_0.blindparts = [];
  var_0.blindstates = [];
  var_0.blinddurations = [];
  var_0.blindparts[0] = "_encstr_88BD0CFBB88A6119E0E121F59313";
  var_0.blindstates[0] = "_encstr_A58F0B0AE2E9E98B80AC2537CF";
  var_0.blinddurations[0] = 2;
  var_0.blindparts[1] = "_encstr_88BD0CFBB88A6119E0E121F59313";
  var_0.blindstates[1] = "_encstr_930B07BB1B6B3854FF";
  var_0.blinddurations[1] = 2;
  level.chill_data = var_0;
}

chill(var_0, var_1) {
  if(!isDefined(self.chill_data))
    self.chill_data = spawnStruct();

  var_2 = self.chill_data;
  thread chill_blind();

  if(!isDefined(var_2.active)) {
    self notify("_encstr_837606D843D263D8");
    var_2.active = 1;
    var_2.speedmod = 0;
    var_2.times = [];
    var_1 = var_1 * 1000;
    var_3 = gettime();
    var_4 = var_3 + var_1;
    var_2.times[var_0] = (var_3, var_4, var_1);
    chill_impair();
    self setscriptablepartstate("_encstr_82BB0889FC8188D9A26B", "_encstr_930B07BB1B6B3854FF", 0);
    thread chill_update();
  } else {
    if(!isDefined(var_2.times[var_0]))
      var_2.active++;

    var_1 = var_1 * 1000;
    var_3 = gettime();
    var_4 = var_3 + var_1;
    var_2.times[var_0] = (var_3, var_4, var_1);
  }
}

chillend(var_0) {
  var_1 = self.chill_data;
  var_1.active--;
  var_1.times[var_0] = undefined;

  if(var_1.active == 0) {
    self notify("_encstr_86C409AE9C301A01AFFA49");
    chill_impairend();
    self setscriptablepartstate("_encstr_82BB0889FC8188D9A26B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

ischilled() {
  var_0 = self.chill_data;
  return isDefined(var_0) && isDefined(var_0.active);
}

chill_resetdata() {
  self notify("_encstr_A3820BC60D2D631B94B2DCAC1D");
  self.chill_data = undefined;
}

chill_resetscriptable() {
  self setscriptablepartstate("_encstr_82BB0889FC8188D9A26B", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  foreach(var_1 in level.chill_data.blindparts)
  self setscriptablepartstate(var_1, "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

chill_impair() {
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_slide(0);
  scripts\common\utility::allow_wallrun(0);
  scripts\common\utility::allow_mantle(0);
}

chill_impairend() {
  scripts\common\utility::allow_sprint(1);
  scripts\common\utility::allow_slide(1);
  scripts\common\utility::allow_wallrun(1);
  scripts\common\utility::allow_mantle(1);
}

chill_blind() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = self.chill_data;
  var_1 = level.chill_data;
  var_2 = var_0.blindid;
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA"), 0, 1);
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

    if(var_7 != var_4)
      self setscriptablepartstate(var_7, "_encstr_A7A408B9CA5D1D4E2C63", 0);

    self setscriptablepartstate(var_4, var_5, 0);
    var_0.blindid = var_3;
  }

  self notify("_encstr_8C3B0B76A06F4009461AA898B2");
  self endon("_encstr_8C3B0B76A06F4009461AA898B2");
  scripts\engine\utility::_id_143B9(var_6, "_encstr_86C409AE9C301A01AFFA49");
  self setscriptablepartstate(var_4, "_encstr_A7A408B9CA5D1D4E2C63", 0);
  var_0.blindid = undefined;
}

chill_update() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3820BC60D2D631B94B2DCAC1D");
  self endon("_encstr_86C409AE9C301A01AFFA49");
  var_0 = self.chill_data;

  for(;;) {
    var_1 = gettime();
    var_2 = 0;

    foreach(var_10, var_4 in var_0.times) {
      var_5 = var_4[0];
      var_6 = var_4[1];
      var_7 = var_4[2];

      if(var_1 < var_6) {
        var_8 = var_1 - var_5;
        var_9 = 1 - var_8 / var_7;

        if(var_9 > var_2)
          var_2 = var_9;

        continue;
      }

      thread chillend(var_10);
    }

    var_0.speedmod = var_2 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}