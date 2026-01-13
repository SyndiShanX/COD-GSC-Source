/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\mg_penetration.gsc
*********************************************/

func_8715(var_0) {
  if(!isDefined(level.var_FC5D)) {
    level.var_FC5D = [];
  }

  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.var_381C = 1;
  self.var_138DC = 0;
  if(!scripts\sp\mgturret::func_13030(var_0)) {
    self notify("continue_cover_script");
    return;
  }

  self.var_A8BB = undefined;
  thread func_DDE5();
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawn("script_origin", (0, 0, 0));
  thread func_11513(var_2);
  var_2.origin = var_0.origin + var_1 * 500;
  if(isDefined(self.var_A8BB)) {
    var_2.origin = self.var_A8BB;
  }

  var_0 settargetentity(var_2);
  var_3 = undefined;
  for(;;) {
    if(!isalive(self.var_4B6D)) {
      stop_firing_turret();
      self waittill("new_enemy");
    }

    func_10C4E();
    func_FE5E(var_2);
    if(!isalive(self.var_4B6D)) {
      continue;
    }

    if(self getpersstat(self.var_4B6D)) {
      continue;
    }

    self waittill("saw_enemy");
  }
}

func_11513(var_0) {
  scripts\engine\utility::waittill_either("death", "end_mg_behavior");
  var_0 delete();
}

func_FE5E(var_0) {
  self endon("death");
  self endon("new_enemy");
  self.var_4B6D endon("death");
  var_1 = self.var_4B6D;
  while(self getpersstat(var_1)) {
    var_2 = vectortoangles(var_1 getEye() - var_0.origin);
    var_2 = anglesToForward(var_2);
    var_0 moveto(var_0.origin + var_2 * 12, 0.1);
    wait(0.1);
  }

  if(isplayer(var_1)) {
    self endon("saw_enemy");
    var_3 = var_1 getEye();
    var_2 = vectortoangles(var_3 - var_0.origin);
    var_2 = anglesToForward(var_2);
    var_4 = 150;
    var_5 = distance(var_0.origin, self.var_A8BB) / var_4;
    if(var_5 > 0) {
      var_0 moveto(self.var_A8BB, var_5);
      wait(var_5);
    }

    var_6 = var_0.origin + var_2 * 180;
    var_7 = func_7CC5(self getEye(), var_0.origin, var_6);
    if(!isDefined(var_7)) {
      var_7 = var_0.origin;
    }

    var_0 moveto(var_0.origin + var_2 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait(3.5);
    var_0 moveto(var_7 + var_2 * -20, 3, 1, 1);
  }

  wait(randomfloatrange(2.5, 4));
  stop_firing_turret();
}

func_F39D(var_0) {
  if(var_0) {
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
  var_0 = spawnStruct();
  scripts\engine\utility::array_thread(level.var_B6B2, ::func_B6B1, var_0);
  var_1 = level.var_B6B2;
  level.var_B6B2 = undefined;
  var_0 waittill("gunner_died");
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2])) {
      continue;
    }

    var_1[var_2] notify("stop_using_built_in_burst_fire");
    var_1[var_2] thread func_103FD();
  }
}

func_B6B1(var_0) {
  self waittill("death");
  var_0 notify("gunner_died");
}

func_103FE(var_0) {
  var_1 = undefined;
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isalive(var_0[var_2])) {
      continue;
    }

    var_1 = var_0[var_2];
    break;
  }

  if(!isDefined(var_1)) {}
}

func_103FD() {
  self endon("death");
  for(;;) {
    self.turret func_8398();
    wait(randomfloatrange(0.3, 0.7));
    self.turret givesentry();
    wait(randomfloatrange(0.1, 1.1));
  }
}

func_5F0C(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] endon("death");
  }

  var_2 = 0;
  var_3 = 1;
  for(;;) {
    if(isalive(var_0[var_2])) {
      var_0[var_2] func_F39D(1);
    }

    if(isalive(var_0[var_3])) {
      var_0[var_3] func_F39D(0);
    }

    var_4 = var_2;
    var_2 = var_3;
    var_3 = var_4;
    wait(randomfloatrange(2.3, 3.5));
  }
}

func_7CC5(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2) * 0.05;
  if(var_3 < 5) {
    var_3 = 5;
  }

  if(var_3 > 20) {
    var_3 = 20;
  }

  var_4 = var_2 - var_1;
  var_4 = (var_4[0] / var_3, var_4[1] / var_3, var_4[2] / var_3);
  var_5 = (0, 0, 0);
  var_6 = undefined;
  for(var_7 = 0; var_7 < var_3 + 2; var_7++) {
    var_8 = bulletTrace(var_0, var_1 + var_5, 0, undefined);
    if(var_8["fraction"] < 1) {
      var_6 = var_8["position"];
      break;
    }

    var_5 = var_5 + var_4;
  }

  return var_6;
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