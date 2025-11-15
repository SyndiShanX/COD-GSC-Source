/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_emp_common.gsc
**************************************************/

func_20C3() {
  self notify("apply_player_emp");
  self.var_619B = scripts\engine\utility::ter_op(isDefined(self.var_619B), self.var_619B, 0);
  var_00 = self.var_619B;
  self.var_619B++;
  self playLoopSound("emp_nade_lp");
  thread func_5AA9();
  if(var_00 == 0) {
    thread func_1181();
  }
}

func_E0F3() {
  self.var_619B--;
  if(self.var_619B == 0) {
    thread func_13B5();
  }
}

func_1181() {
  if(scripts\mp\utility::_hasperk("specialty_localjammer")) {
    self clearscrambler();
  }

  self give_infinite_grenade(1);
  scripts\engine\utility::allow_usability(0);
  thread func_10D95();
}

func_13B5() {
  if(scripts\mp\utility::_hasperk("specialty_localjammer")) {
    self makescrambler();
  }

  self give_infinite_grenade(0);
  scripts\engine\utility::allow_usability(1);
  if(scripts\mp\utility::isreallyalive(self)) {
    thread func_1106A();
  } else {
    thread func_1106B();
  }

  self notify("emp_stop_vfx");
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

isemped() {
  return isDefined(self.var_619B) && self.var_619B > 0;
}

func_FFC5() {
  if(scripts\mp\utility::_hasperk("specialty_empimmune") || !scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  if(scripts\mp\utility::func_9EF0(self)) {
    return 0;
  }

  return 1;
}

func_20CD() {
  visionsetnaked("coup_sunblind", 0.05);
  wait(0.05);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

func_10D95() {
  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("disconnect");
  self.var_2B12 = 1;
  thread func_5823();
  wait(1);
  self setclientomnvar("ui_hud_static", 2);
  wait(0.5);
  self notify("emp_stop_artifact");
  self setclientomnvar("ui_hud_emp_artifact", 0);
  for(;;) {
    self setclientomnvar("ui_hud_static", 3);
    var_00 = randomfloatrange(0.25, 1.25);
    wait(var_00);
    self setclientomnvar("ui_hud_static", 2);
    wait(0.5);
  }
}

func_1106A() {
  level endon("game_ended");
  self notify("emp_stop_effect");
  self endon("disconnect");
  if(isDefined(self.var_2B12)) {
    self.var_2B12 = undefined;
    self setclientomnvar("ui_hud_static", 0);
    for(var_00 = 0; var_00 < 3; var_00++) {
      self setclientomnvar("ui_hud_emp_artifact", 1);
      wait(0.5);
    }

    self setclientomnvar("ui_hud_emp_artifact", 0);
    self.var_D2DB = 0;
  }
}

func_1106B() {
  self notify("emp_stop_effect");
  if(isDefined(self.var_2B12) || isDefined(self.var_D2DB)) {
    self.var_2B12 = undefined;
    self.var_D2DB = 0;
    self setclientomnvar("ui_hud_static", 0);
    self setclientomnvar("ui_hud_emp_artifact", 0);
  }
}

func_5823() {
  self notify("emp_stop_artifact");
  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("emp_stop_artifact");
  self endon("disconnect");
  self endon("joined_spectators");
  for(;;) {
    self setclientomnvar("ui_hud_emp_artifact", 1);
    var_00 = randomfloatrange(0.375, 0.5);
    wait(var_00);
  }
}

func_5826(param_00) {
  self notify("emp_stop_static");
  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("emp_stop_static");
  self endon("disconnect");
  self endon("joined_spectators");
  var_01 = 1;
  var_02 = 2;
  if(param_00 == 2) {
    var_01 = 0.5;
    var_02 = 0.75;
  }

  for(;;) {
    self setclientomnvar("ui_hud_static", 2);
    var_03 = randomfloatrange(var_01, var_02);
    wait(var_03);
  }
}

func_10E4A() {
  self.var_D2DB = 0;
}

func_10E4B(param_00) {
  if(self.var_D2DB != param_00 && isalive(self) && !isemped()) {
    self.var_D2DB = param_00;
    switch (param_00) {
      case 0:
        func_1106A();
        break;

      case 1:
        self.var_2B12 = 1;
        self notify("emp_stop_static");
        thread func_5823();
        thread func_5826(1);
        break;

      case 2:
        self.var_2B12 = 1;
        self notify("emp_stop_static");
        self notify("emp_stop_artifact");
        thread func_5826(2);
        break;
    }
  }
}

func_10E49() {
  return self.var_D2DB;
}

func_5AA9() {
  self endon("disconnect");
  self notify("doShockEffects");
  self endon("doShockEffects");
  self setscriptablepartstate("emped", "active", 0);
  scripts\engine\utility::waittill_any_3("death", "emp_stop_vfx", "game_ended");
  self setscriptablepartstate("emped", "neutral", 0);
}

func_20C7(param_00) {
  thread func_20C8(param_00);
}

func_20C8(param_00) {
  self endon("death");
  self endon("disconnect");
  func_20C3();
  wait(param_00);
  func_E0F3();
}

func_E24E() {
  self.var_619B = undefined;
  func_1106B();
  self notify("emp_stop_vfx");
  self stoploopsound("emp_nade_lp");
  self give_infinite_grenade(0);
}

func_61A2() {
  if(!isDefined(level.var_61A1)) {
    func_61C1();
  }

  return level.var_61A1;
}

func_61C1(param_00) {
  var_01 = [];
  foreach(var_03 in level.mines) {
    if(isDefined(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  var_05 = getEntArray("misc_turret", "classname");
  foreach(var_07 in var_05) {
    if(isDefined(var_07)) {
      var_01[var_01.size] = var_07;
    }
  }

  foreach(var_0A in level.uplinks) {
    if(isDefined(var_0A)) {
      var_01[var_01.size] = var_0A;
    }
  }

  foreach(var_0D in level.remote_uav) {
    if(isDefined(var_0D)) {
      var_01[var_01.size] = var_0D;
    }
  }

  foreach(var_10 in level.balldrones) {
    if(isDefined(var_10)) {
      var_01[var_01.size] = var_10;
    }
  }

  foreach(var_13 in level.placedims) {
    if(isDefined(var_13)) {
      var_01[var_01.size] = var_13;
    }
  }

  foreach(param_00 in level.players) {
    if(isDefined(param_00) && scripts\mp\utility::func_9EF0(param_00)) {
      var_01[var_01.size] = param_00;
    }
  }

  level.var_61A1 = var_01;
  thread empscramblelevels();
}

empscramblelevels() {
  waittillframeend;
  level.var_61A1 = undefined;
}