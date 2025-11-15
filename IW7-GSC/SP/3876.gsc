/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3876.gsc
************************/

main() {
  if(isDefined(self.var_10E6D)) {
    return;
  }

  lib_0F27::func_868B("stealth_spotted");
  scripts\sp\utility::func_65E0("stealth_enabled");
  scripts\sp\utility::func_65E1("stealth_enabled");
  scripts\sp\utility::func_65E0("stealth_in_shadow");
  self.var_10E6D = spawnStruct();
  self.var_10E6D.var_10A9D = [];
  lib_0F27::func_8682();
  thread func_13436();
}

func_13436() {
  self endon("death");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    self.setturretnode = func_7938();
    wait(0.05);
  }
}

func_7938() {
  var_00 = self getstance();
  if(lib_0F27::func_869D()) {
    var_01 = "spotted";
  } else {
    var_01 = "hidden";
  }

  var_02 = level.var_10E6D.var_53A0.var_DCCA[var_01][var_00];
  var_03 = 1;
  if(scripts\sp\utility::func_65DB("stealth_in_shadow")) {
    var_03 = var_03 * 0.5;
  }

  var_02 = var_02 * var_03;
  if(var_02 < level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"]) {
    var_02 = level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"];
  }

  return var_02;
}

func_10EE3(param_00) {
  self notify("stealth_noteworthy_thread");
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!param_00) {
    return;
  }

  self endon("stealth_noteworthy_thread");
  self endon("disconnect");
  if(!isDefined(self.var_10E6D.var_10EDF)) {
    self.var_10E6D.var_10EDF = [];
  }

  thread func_10EE1();
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    var_01 = -1;
    var_02 = undefined;
    if(self getweaponrankinfominxp() > 0.3) {
      var_03 = self getEye();
      var_04 = anglesToForward(self getplayerangles());
      var_05 = getaiarray();
      foreach(var_07 in var_05) {
        var_08 = var_07 getentitynumber();
        if(isDefined(self.var_10E6D.var_10EDF[var_08])) {
          continue;
        }

        var_09 = var_07.origin;
        if(issentient(var_07)) {
          var_09 = var_07 getEye();
        }

        var_0A = vectornormalize(var_09 - var_03);
        var_0B = vectordot(var_04, var_0A);
        if(var_0B > 0.99 && var_0B > var_01) {
          if(sighttracepassed(var_09, var_03, 0, undefined)) {
            var_01 = var_0B;
            var_02 = var_07;
          }
        }
      }

      if(isDefined(var_02)) {
        thread func_10EE0("aim", var_02);
      }

      foreach(var_08, var_0E in self.var_10E6D.var_10EDF) {
        if(!isDefined(self.var_10E6D.var_10EDF[var_08])) {
          self.var_10E6D.var_10EDF[var_08] = undefined;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_10EE1() {
  self endon("stealth_noteworthy_thread");
  self endon("disconnect");
  var_00 = 0;
  var_01 = undefined;
  for(;;) {
    var_01 = self.var_10E53["kills"];
    if(!isDefined(var_01)) {
      var_01 = 0;
    }

    var_02 = var_01;
    var_03 = gettime();
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level waittill("ai_killed", var_04, var_05, var_06, var_07);
    if(!isDefined(var_05) || var_05 != self) {
      continue;
    }

    if(!scripts\engine\utility::flag("stealth_enabled") || scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    if(isDefined(var_04) && isDefined(var_04.team) && var_04.team != "axis") {
      thread func_10EE0("civilian_kill", var_04);
    }

    var_01 = self.var_10E53["kills"];
    if(!isDefined(var_01)) {
      var_01 = 1;
    }

    var_08 = var_01 - var_02;
    if(gettime() - var_03 > 1000) {
      var_00 = 0;
    }

    var_09 = isDefined(var_07) && weapontype(var_07) == "bullet";
    if(var_08 >= 2 && var_09) {
      thread func_10EE0("good_kill_double", var_04, 1);
    }

    var_00 = var_00 + var_08;
    if(var_00 > 1) {
      thread func_10EE0("good_kill_impressive", var_04, 1);
      continue;
    }

    if(var_09) {
      thread func_10EE0("good_kill_bullet", var_04, 1);
      continue;
    }

    thread func_10EE0("good_kill", var_04, 1);
  }
}

func_10EE0(param_00, param_01, param_02) {
  var_03 = [param_01];
  if(isDefined(self.var_10E6D.var_10EDC)) {
    if(func_10EE2(self.var_10E6D.var_10EDC) > func_10EE2(param_00)) {
      return;
    }

    if(param_00 == "aim") {
      if(self.var_10E6D.var_10EDD[0] == param_01) {
        return;
      } else {
        self.var_10E6D.var_10EDD = var_03;
      }
    } else if(self.var_10E6D.var_10EDC == param_00) {
      self.var_10E6D.var_10EDD[self.var_10E6D.var_10EDD.size] = param_01;
    } else {
      self.var_10E6D.var_10EDD = var_03;
    }
  } else {
    self.var_10E6D.var_10EDC = param_00;
    self.var_10E6D.var_10EDD = var_03;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");
  if(scripts\engine\utility::istrue(param_02) && isDefined(self.var_10E6D.var_B476)) {
    self.var_10E6D.var_10EDE = self.var_10E6D.var_B476;
  }

  wait(1);
  self.var_10E6D.var_10EDD = scripts\engine\utility::array_removeundefined(self.var_10E6D.var_10EDD);
  if(scripts\engine\utility::istrue(param_02) && isDefined(self.var_10E6D.var_B476) && self.var_10E6D.var_10EDE < self.var_10E6D.var_B476) {
    self.var_10E6D.var_10EDC = undefined;
    self.var_10E6D.var_10EDD = undefined;
    return;
  }

  if(param_00 == "aim") {
    foreach(var_05 in self.var_10E6D.var_10EDD) {
      self.var_10E6D.var_10EDF[var_05 getentitynumber()] = var_05;
    }
  }

  self notify("stealth_noteworthy", param_00, self.var_10E6D.var_10EDD);
  self.var_10E6D.var_10EDC = undefined;
  self.var_10E6D.var_10EDD = undefined;
}

func_10EE2(param_00) {
  if(!isDefined(param_00)) {
    return -1;
  }

  switch (param_00) {
    case "civilian_kill":
      return 6;

    case "good_kill_double":
      return 5;

    case "good_kill_impressive":
      return 4;

    case "good_kill_bullet":
      return 3;

    case "good_kill":
      return 2;

    case "aim":
      return 1;
  }

  return 0;
}

func_1DD6(param_00) {
  if(isDefined(param_00)) {
    for(var_01 = param_00.size - 1; var_01 >= 0; var_01--) {
      var_02 = param_00[var_01];
      for(var_03 = 0; var_03 < var_02.size; var_03++) {
        if(!soundexists(var_02[var_03])) {
          for(var_04 = var_03; var_04 < var_02.size - 1; var_04++) {
            var_02[var_04] = var_02[var_04 + 1];
          }

          var_02[var_02.size - 1] = undefined;
        }
      }

      if(var_02.size == 0) {
        for(var_04 = var_01; var_04 < param_00.size - 1; var_04++) {
          param_00[var_04] = param_00[var_04 + 1];
        }

        param_00[param_00.size - 1] = undefined;
      }
    }
  }

  level.var_10E6D.var_DBED = spawnStruct();
  level.var_10E6D.var_DBED.var_AD4E = param_00;
  level.var_10E6D.var_DBED.var_CC65 = undefined;
  func_1DD8();
}

func_1DD5() {
  if(!isDefined(level.var_10E6D)) {
    return undefined;
  }

  if(!isDefined(level.var_10E6D.var_DBED)) {
    return undefined;
  }

  if(!isDefined(level.var_10E6D.var_DBED.var_AD4E)) {
    return undefined;
  }

  if(level.var_10E6D.var_DBED.var_AD4E.size == 0) {
    return undefined;
  }

  if(!isDefined(level.var_10E6D.var_DBED.var_CC65) || level.var_10E6D.var_DBED.var_CC65.size == 0) {
    level.var_10E6D.var_DBED.var_CC65 = scripts\engine\utility::array_randomize(level.var_10E6D.var_DBED.var_AD4E);
  }

  var_00 = level.var_10E6D.var_DBED.var_CC65.size - 1;
  var_01 = level.var_10E6D.var_DBED.var_CC65[var_00];
  level.var_10E6D.var_DBED.var_CC65[var_00] = undefined;
  return var_01;
}

func_1DD3() {
  self notify("ambient_player_thread");
  self endon("ambient_player_thread");
  self endon("disconnect");
  for(;;) {
    if(!isalive(self)) {
      wait(0.05);
      continue;
    }

    scripts\sp\utility::func_65E3("stealth_enabled");
    wait(randomfloatrange(10, 15));
    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    var_00 = func_1D7D(0, 1);
    var_01 = undefined;
    var_02 = func_1D7D(!isDefined(self.var_10E6D.var_DBEE), 0);
    if(var_02.size > 0 && var_00.size == 0 || randomfloat(1) > 0.5) {
      var_01 = func_1DD5();
    }

    if(isDefined(var_01)) {
      thread func_1DD7(var_01);
      continue;
    }

    if(var_00.size > 0 && !scripts\engine\utility::istrue(level.var_10E6D.var_5659)) {
      if(var_00[0].var_10E6D.var_C9A8 == "unaware") {
        var_00[0] thread lib_0F27::func_1284A("chatter");
      } else {
        var_00[0] thread lib_0F27::func_1284A("enemysweep");
      }

      var_00[0].var_10E6D.var_134F4 = gettime() + randomintrange(30000, -20536);
    }
  }
}

func_1D7D(param_00, param_01) {
  var_02 = 1000;
  var_03 = var_02 * var_02;
  var_04 = [];
  if(!param_00 && !param_01) {
    return var_04;
  }

  var_05 = level.var_10E6D.enemies[self.team];
  if(param_00) {
    var_05 = scripts\engine\utility::array_combine(var_05, getcorpsearray());
  }

  var_05 = scripts\engine\utility::array_removeundefined(var_05);
  foreach(var_07 in var_05) {
    if(!param_00 && !isalive(var_07)) {
      continue;
    }

    if(!param_00 && !isDefined(var_07.var_10E6D) || issentient(var_07) && var_07.var_28 == "combat") {
      continue;
    }

    if(issentient(var_07) && var_07.precacheleaderboards) {
      continue;
    }

    if(issentient(var_07) && !isDefined(var_07.var_10E6D) || !isDefined(var_07.var_10E6D.var_C9A8)) {
      continue;
    }

    var_08 = distancesquared(var_07.origin, self.origin);
    if(var_08 > var_03) {
      continue;
    }

    if(param_00) {
      var_04[var_04.size] = var_07;
      continue;
    }

    if(param_01 && isDefined(var_07.var_10E6D)) {
      if(isDefined(var_07.var_10E6D.var_134F4) && gettime() < var_07.var_10E6D.var_134F4) {
        continue;
      }

      if(isDefined(var_07.var_10E6D.var_A90B) && gettime() - var_07.var_10E6D.var_A90B < 10000) {
        continue;
      }

      if(isDefined(var_07.var_10E6D.var_A908) && gettime() - var_07.var_10E6D.var_A908 < 10000) {
        continue;
      }

      var_04[var_04.size] = var_07;
    }
  }

  var_04 = sortbydistance(var_04, self.origin);
  return var_04;
}

func_1DD7(param_00) {
  self notify("ambient_radio_conversation");
  self endon("ambient_radio_conversation");
  self endon("disconnect");
  self.var_10E6D.var_DBEE = param_00;
  for(var_01 = 0; isDefined(self.var_10E6D.var_DBEE) && var_01 < self.var_10E6D.var_DBEE.size; var_01 = var_01 + 1) {
    var_02 = self.var_10E6D.var_DBEE[var_01];
    var_03 = func_1D7D(1, 0);
    if(isDefined(var_03[0])) {
      if(soundexists(param_00[var_01])) {
        var_03[0] playSound(var_02, "stealth_ambient_radio", 1);
        var_03[0] waittill("stealth_ambient_radio");
      }
    }

    wait(randomfloatrange(1, 3));
  }

  self.var_10E6D.var_DBEE = undefined;
}

func_1DD8() {
  self.var_10E6D.var_DBEE = undefined;
  self notify("ambient_radio_conversation");
}

func_1DD2() {
  self notify("ambient_player_thread");
  func_1DD8();
}