/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2691.gsc
***************************************/

init() {
  if(getdvarint("prototype_adrenaline_enabled") == 1 && level.rankedmatch) {
    func_97BF();
    level thread onplayerconnect();
  } else {}
}

func_97BF() {
  precacheshader("combathigh_overlay");
}

func_7D9E() {
  return getdvarfloat("adrenaline_winddown_time_sec", 30);
}

func_7D9F() {
  return getdvarint("adrenaline_xp_multiplier", 4);
}

func_7D9D() {
  return getdvarint("adrenaline_min_spm_threshold", 80);
}

func_7D9C() {
  return getdvarfloat("adrenaline_history_mins", 3);
}

func_1892() {
  return getdvarint("adrenaline_debugging", 0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  for(;;) {
    if(func_1892()) {}

    self waittill("spawned_player");
    func_FA89();
    thread func_18AB();
    thread func_18B1();
    thread func_18AF();
    thread func_18B0();
  }
}

func_18AB() {
  self endon("disconnect");
  self endon("death");
  var_00 = 0;

  for(;;) {
    func_1891();
    var_01 = func_18A9();
    var_02 = self.func_115B;

    if(func_1892() && var_01 > 0 && var_01 != var_00) {}

    if(var_00 < var_01 && func_181E() <= var_01) {
      self.func_115B = func_7D9E();
      self notify("adrenaline_update");
    }

    var_00 = var_01;
    wait 0.3;
  }
}

func_1896() {
  var_00 = (self.func_115B - 5.0) / (func_7D9E() - 5.0) * 0.5;
  var_00 = var_00 + 0.5;

  if(var_00 > 1.0)
    var_00 = 1.0;

  return var_00;
}

func_1891() {
  for(var_00 = 0; var_00 < self.func_115E.size; var_0++) {
    if(gettime() - self.func_115E[var_00] > func_7D9C() * 60 * 1000) {
      self.func_115E[var_00] = undefined;
      self.func_115D[var_00] = undefined;
    }
  }

  self.func_115E = scripts\engine\utility::array_removeundefined(self.func_115E);
  self.func_115D = scripts\engine\utility::array_removeundefined(self.func_115D);
}

func_18A9() {
  var_00 = 0;

  foreach(var_02 in self.func_115D)
  var_00 = var_00 + var_02;

  return var_00 / (func_7D9C() * 1.0);
}

func_181E() {
  var_00 = scripts\mp\persistence::statget("score");
  var_01 = scripts\mp\persistence::statgetbuffered("timePlayedTotal");

  if(var_01 > 0)
    var_02 = var_00 / (var_01 / 60) + 34;
  else
    var_02 = func_7D9D();

  if(var_02 < func_7D9D())
    var_02 = func_7D9D();

  if(func_1892()) {}

  return var_02;
}

func_1890(var_00) {
  if(func_1892()) {}

  if(isDefined(self.func_115A)) {
    self.func_115E[self.func_115E.size] = gettime();
    self.func_115D[self.func_115D.size] = var_00;
  }
}

func_1897() {
  var_00 = 0;

  if(isDefined(self.func_115A) && self.func_115A)
    var_00 = func_7D9F();

  return var_00;
}

func_FA89() {
  self.func_115B = 0;
  self.func_115E = [];
  self.func_115D = [];
  self.func_115A = 0;
  self.func_115C = 0;
  self.func_18A8 = undefined;
}

func_18AA() {
  self.func_115C = 1;
}

func_1893() {
  var_00 = 0;

  if(getdvarint("prototype_adrenaline_enabled") == 1)
    var_00 = self.func_115C;

  return var_00;
}

func_1898() {
  var_00 = 0;

  if(getdvarint("prototype_adrenaline_enabled") == 1 && isDefined(self.func_115A))
    var_00 = self.func_115A;

  return var_00;
}

func_18AE(var_00) {
  if(var_00 func_1898()) {
    if(var_00 func_1893())
      thread scripts\mp\hud_message::showsplash("adrenaline_mood_killer", 0);
    else
      thread scripts\mp\hud_message::showsplash("adrenaline_iced", 0);
  }
}

func_661F() {
  if(!self.func_115A) {
    self.func_18A8 = newclienthudelem(self);
    self.func_18A8.x = 0;
    self.func_18A8.y = 0;
    self.func_18A8.alignx = "left";
    self.func_18A8.aligny = "top";
    self.func_18A8.horzalign = "fullscreen";
    self.func_18A8.vertalign = "fullscreen";
    self.func_18A8 setshader("combathigh_overlay", 640, 480);
    self.func_18A8.sort = -10;
    self.func_18A8.archived = 1;
    self.func_18A8.alpha = 0;
    self.func_115A = 1;
  }
}

func_18AF() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("adrenaline_update");

    if(!self.func_115A) {
      wait 0.05;

      if(func_1892()) {}

      func_661F();
      thread scripts\mp\hud_message::showsplash("adrenaline_enter", func_7D9F());
    }

    self.func_18A8 fadeovertime(0.3);
    self.func_18A8.alpha = 1;
    wait 0.3;
    thread func_18AC();
  }
}

func_18AC() {
  self endon("adrenaline_update");
  self endon("death");
  self endon("disconnect");

  while(self.func_115B > 5.0) {
    var_00 = func_1896();

    if(func_1892()) {}

    self.func_18A8 fadeovertime(0.3);
    self.func_18A8.alpha = var_00;
    wait 0.3;
    self.func_115B = self.func_115B - 0.3;
  }

  var_01 = 40;

  for(var_02 = 40; self.func_115B > 0; self.func_115B = self.func_115B - 1) {
    self.func_18A8 fadeovertime(0.1);
    self.func_18A8.alpha = 1;
    wait 0.05;
    self.func_18A8 fadeovertime(0.1);
    self.func_18A8.alpha = 0.5;
    wait 0.9;
  }

  self.func_18A8 fadeovertime(0.3);
  self.func_18A8.alpha = 0;
  wait 0.3;
  self notify("adrenaline_cleanup");
}

func_18B0() {
  for(;;) {
    scripts\engine\utility::waittill_any_return("adrenaline_cleanup", "death", "disconnect");

    if(self.func_115A) {
      self.func_115A = 0;
      self.func_18A8 destroy();
      self.func_18A8 = undefined;
    }
  }
}

func_18B1() {
  self waittill("death");
  self notify("adrenaline_cleanup");
}