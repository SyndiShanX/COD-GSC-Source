/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2894.gsc
***************************************/

func_8715(var_00) {
  if(!isDefined(level.func_FC5D)) {
    level.func_FC5D = [];
  }

  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.func_381C = 1;
  self.func_138DC = 0;

  if(!scripts\sp\mgturret::func_13030(var_00)) {
    self notify("continue_cover_script");
    return;
  }

  self.func_A8BB = undefined;
  thread func_DDE5();
  var_01 = anglesToForward(var_0.angles);
  var_02 = spawn("script_origin", (0, 0, 0));
  thread func_11513(var_02);
  var_2.origin = var_0.origin + var_01 * 500;

  if(isDefined(self.func_A8BB)) {
    var_2.origin = self.func_A8BB;
  }

  var_00 settargetentity(var_02);
  var_03 = undefined;

  for(;;) {
    if(!isalive(self.func_4B6D)) {
      stop_firing_turret();
      self waittill("new_enemy");
    }

    func_10C4E();
    func_FE5E(var_02);

    if(!isalive(self.func_4B6D)) {
      continue;
    }
    if(self getpersstat(self.func_4B6D)) {
      continue;
    }
    self waittill("saw_enemy");
  }
}

func_11513(var_00) {
  scripts\engine\utility::waittill_either("death", "end_mg_behavior");
  var_00 delete();
}

func_FE5E(var_00) {
  self endon("death");
  self endon("new_enemy");
  self.func_4B6D endon("death");
  var_01 = self.func_4B6D;

  while(self getpersstat(var_01)) {
    var_02 = vectortoangles(var_01 getEye() - var_0.origin);
    var_02 = anglesToForward(var_02);
    var_00 moveto(var_0.origin + var_02 * 12, 0.1);
    wait 0.1;
  }

  if(isplayer(var_01)) {
    self endon("saw_enemy");
    var_03 = var_01 getEye();
    var_02 = vectortoangles(var_03 - var_0.origin);
    var_02 = anglesToForward(var_02);
    var_04 = 150;
    var_05 = distance(var_0.origin, self.func_A8BB) / var_04;

    if(var_05 > 0) {
      var_00 moveto(self.func_A8BB, var_05);
      wait(var_05);
    }

    var_06 = var_0.origin + var_02 * 180;
    var_07 = func_7CC5(self getEye(), var_0.origin, var_06);

    if(!isDefined(var_07)) {
      var_07 = var_0.origin;
    }

    var_00 moveto(var_0.origin + var_02 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait 3.5;
    var_00 moveto(var_07 + var_02 * -20, 3, 1, 1);
  }

  wait(randomfloatrange(2.5, 4));
  stop_firing_turret();
}

func_F39D(var_00) {
  if(var_00) {
    self.func_381C = 1;

    if(self.func_138DC) {
      self.turret notify("startfiring");
    }
  } else {
    self.func_381C = 0;
    self.turret notify("stopfiring");
  }
}

stop_firing_turret() {
  self.func_138DC = 0;
  self.turret notify("stopfiring");
}

func_10C4E() {
  self.func_138DC = 1;

  if(self.func_381C) {
    self.turret notify("startfiring");
  }
}

func_491C() {
  if(isDefined(level.func_B6B2)) {
    level.func_B6B2[level.func_B6B2.size] = self;
    return;
  }

  level.func_B6B2 = [];
  level.func_B6B2[level.func_B6B2.size] = self;
  waittillframeend;
  var_00 = spawnStruct();
  scripts\engine\utility::array_thread(level.func_B6B2, ::func_B6B1, var_00);
  var_01 = level.func_B6B2;
  level.func_B6B2 = undefined;
  var_00 waittill("gunner_died");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(!isalive(var_1[var_02])) {
      continue;
    }
    var_1[var_02] notify("stop_using_built_in_burst_fire");
    var_1[var_02] thread func_103FD();
  }
}

func_B6B1(var_00) {
  self waittill("death");
  var_00 notify("gunner_died");
}

func_103FE(var_00) {
  var_01 = undefined;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(!isalive(var_0[var_02])) {
      continue;
    }
    var_01 = var_0[var_02];
    break;
  }

  if(!isDefined(var_01)) {
    return;
  }
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

func_5F0C(var_00) {
  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_0[var_01] endon("death");
  }

  var_02 = 0;
  var_03 = 1;

  for(;;) {
    if(isalive(var_0[var_02])) {
      var_0[var_02] func_F39D(1);
    }

    if(isalive(var_0[var_03])) {
      var_0[var_03] func_F39D(0);
    }

    var_04 = var_02;
    var_02 = var_03;
    var_03 = var_04;
    wait(randomfloatrange(2.3, 3.5));
  }
}

func_7CC5(var_00, var_01, var_02) {
  var_03 = distance(var_01, var_02) * 0.05;

  if(var_03 < 5) {
    var_03 = 5;
  }

  if(var_03 > 20) {
    var_03 = 20;
  }

  var_04 = var_02 - var_01;
  var_04 = (var_4[0] / var_03, var_4[1] / var_03, var_4[2] / var_03);
  var_05 = (0, 0, 0);
  var_06 = undefined;

  for(var_07 = 0; var_07 < var_03 + 2; var_7++) {
    var_08 = bulletTrace(var_00, var_01 + var_05, 0, undefined);

    if(var_8["fraction"] < 1) {
      var_06 = var_8["position"];
      break;
    }

    var_05 = var_05 + var_04;
  }

  return var_06;
}

func_DDE5() {
  self endon("death");
  self endon("end_mg_behavior");
  self.func_4B6D = undefined;

  for(;;) {
    func_DDEB();
    wait 0.05;
  }
}

func_DDEB() {
  if(!isalive(self.enemy)) {
    return;
  }
  if(!self getpersstat(self.enemy)) {
    return;
  }
  self.func_A8BB = self.enemy getEye();
  self notify("saw_enemy");

  if(!isalive(self.func_4B6D) || self.func_4B6D != self.enemy) {
    self.func_4B6D = self.enemy;
    self notify("new_enemy");
  }
}