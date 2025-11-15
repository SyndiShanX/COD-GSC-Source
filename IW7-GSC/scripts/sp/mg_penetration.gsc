/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\mg_penetration.gsc
*****************************************/

func_8715(param_00) {
  if(!isDefined(level.var_FC5D)) {
    level.var_FC5D = [];
  }

  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.var_381C = 1;
  self.var_138DC = 0;
  if(!scripts\sp\mgturret::func_13030(param_00)) {
    self notify("continue_cover_script");
    return;
  }

  self.var_A8BB = undefined;
  thread func_DDE5();
  var_01 = anglesToForward(param_00.angles);
  var_02 = spawn("script_origin", (0, 0, 0));
  thread func_11513(var_02);
  var_02.origin = param_00.origin + var_01 * 500;
  if(isDefined(self.var_A8BB)) {
    var_02.origin = self.var_A8BB;
  }

  param_00 settargetentity(var_02);
  var_03 = undefined;
  for(;;) {
    if(!isalive(self.var_4B6D)) {
      stop_firing_turret();
      self waittill("new_enemy");
    }

    func_10C4E();
    func_FE5E(var_02);
    if(!isalive(self.var_4B6D)) {
      continue;
    }

    if(self getpersstat(self.var_4B6D)) {
      continue;
    }

    self waittill("saw_enemy");
  }
}

func_11513(param_00) {
  scripts\engine\utility::waittill_either("death", "end_mg_behavior");
  param_00 delete();
}

func_FE5E(param_00) {
  self endon("death");
  self endon("new_enemy");
  self.var_4B6D endon("death");
  var_01 = self.var_4B6D;
  while(self getpersstat(var_01)) {
    var_02 = vectortoangles(var_01 getEye() - param_00.origin);
    var_02 = anglesToForward(var_02);
    param_00 moveto(param_00.origin + var_02 * 12, 0.1);
    wait(0.1);
  }

  if(isplayer(var_01)) {
    self endon("saw_enemy");
    var_03 = var_01 getEye();
    var_02 = vectortoangles(var_03 - param_00.origin);
    var_02 = anglesToForward(var_02);
    var_04 = 150;
    var_05 = distance(param_00.origin, self.var_A8BB) / var_04;
    if(var_05 > 0) {
      param_00 moveto(self.var_A8BB, var_05);
      wait(var_05);
    }

    var_06 = param_00.origin + var_02 * 180;
    var_07 = func_7CC5(self getEye(), param_00.origin, var_06);
    if(!isDefined(var_07)) {
      var_07 = param_00.origin;
    }

    param_00 moveto(param_00.origin + var_02 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait(3.5);
    param_00 moveto(var_07 + var_02 * -20, 3, 1, 1);
  }

  wait(randomfloatrange(2.5, 4));
  stop_firing_turret();
}

func_F39D(param_00) {
  if(param_00) {
    self.var_381C = 1;
    if(self.var_138DC) {
      self.turret notify("startfiring");
      return;
    }

    return;
  }

  self.var_381C = 0;
  self.turret notify("stopfiring");
}

stop_firing_turret() {
  self.var_138DC = 0;
  self.turret notify("stopfiring");
}

func_10C4E() {
  self.var_138DC = 1;
  if(self.var_381C) {
    self.turret notify("startfiring");
  }
}

func_491C() {
  if(isDefined(level.var_B6B2)) {
    level.var_B6B2[level.var_B6B2.size] = self;
    return;
  }

  level.var_B6B2 = [];
  level.var_B6B2[level.var_B6B2.size] = self;
  waittillframeend;
  var_00 = spawnStruct();
  scripts\engine\utility::array_thread(level.var_B6B2, ::func_B6B1, var_00);
  var_01 = level.var_B6B2;
  level.var_B6B2 = undefined;
  var_00 waittill("gunner_died");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(!isalive(var_01[var_02])) {
      continue;
    }

    var_01[var_02] notify("stop_using_built_in_burst_fire");
    var_01[var_02] thread func_103FD();
  }
}

func_B6B1(param_00) {
  self waittill("death");
  param_00 notify("gunner_died");
}

func_103FE(param_00) {
  var_01 = undefined;
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(!isalive(param_00[var_02])) {
      continue;
    }

    var_01 = param_00[var_02];
    break;
  }

  if(!isDefined(var_01)) {}
}

func_103FD() {
  self endon("death");
  for(;;) {
    self.turret _meth_8398();
    wait(randomfloatrange(0.3, 0.7));
    self.turret givesentry();
    wait(randomfloatrange(0.1, 1.1));
  }
}

func_5F0C(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    param_00[var_01] endon("death");
  }

  var_02 = 0;
  var_03 = 1;
  for(;;) {
    if(isalive(param_00[var_02])) {
      param_00[var_02] func_F39D(1);
    }

    if(isalive(param_00[var_03])) {
      param_00[var_03] func_F39D(0);
    }

    var_04 = var_02;
    var_02 = var_03;
    var_03 = var_04;
    wait(randomfloatrange(2.3, 3.5));
  }
}

func_7CC5(param_00, param_01, param_02) {
  var_03 = distance(param_01, param_02) * 0.05;
  if(var_03 < 5) {
    var_03 = 5;
  }

  if(var_03 > 20) {
    var_03 = 20;
  }

  var_04 = param_02 - param_01;
  var_04 = (var_04[0] / var_03, var_04[1] / var_03, var_04[2] / var_03);
  var_05 = (0, 0, 0);
  var_06 = undefined;
  for(var_07 = 0; var_07 < var_03 + 2; var_07++) {
    var_08 = bulletTrace(param_00, param_01 + var_05, 0, undefined);
    if(var_08["fraction"] < 1) {
      var_06 = var_08["position"];
      break;
    }

    var_05 = var_05 + var_04;
  }

  return var_06;
}

func_DDE5() {
  self endon("death");
  self endon("end_mg_behavior");
  self.var_4B6D = undefined;
  for(;;) {
    func_DDEB();
    wait(0.05);
  }
}

func_DDEB() {
  if(!isalive(self.isnodeoccupied)) {
    return;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    return;
  }

  self.var_A8BB = self.isnodeoccupied getEye();
  self notify("saw_enemy");
  if(!isalive(self.var_4B6D) || self.var_4B6D != self.isnodeoccupied) {
    self.var_4B6D = self.isnodeoccupied;
    self notify("new_enemy");
  }
}