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
  var_0 = self getstance();
  if(lib_0F27::func_869D()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level.var_10E6D.var_53A0.var_DCCA[var_1][var_0];
  var_3 = 1;
  if(scripts\sp\utility::func_65DB("stealth_in_shadow")) {
    var_3 = var_3 * 0.5;
  }

  var_2 = var_2 * var_3;
  if(var_2 < level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"]) {
    var_2 = level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"];
  }

  return var_2;
}

func_10EE3(var_0) {
  self notify("stealth_noteworthy_thread");
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!var_0) {
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
    var_1 = -1;
    var_2 = undefined;
    if(self getweaponrankinfominxp() > 0.3) {
      var_3 = self getEye();
      var_4 = anglesToForward(self getplayerangles());
      var_5 = getaiarray();
      foreach(var_7 in var_5) {
        var_8 = var_7 getentitynumber();
        if(isDefined(self.var_10E6D.var_10EDF[var_8])) {
          continue;
        }

        var_9 = var_7.origin;
        if(issentient(var_7)) {
          var_9 = var_7 getEye();
        }

        var_0A = vectornormalize(var_9 - var_3);
        var_0B = vectordot(var_4, var_0A);
        if(var_0B > 0.99 && var_0B > var_1) {
          if(sighttracepassed(var_9, var_3, 0, undefined)) {
            var_1 = var_0B;
            var_2 = var_7;
          }
        }
      }

      if(isDefined(var_2)) {
        thread func_10EE0("aim", var_2);
      }

      foreach(var_8, var_0E in self.var_10E6D.var_10EDF) {
        if(!isDefined(self.var_10E6D.var_10EDF[var_8])) {
          self.var_10E6D.var_10EDF[var_8] = undefined;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_10EE1() {
  self endon("stealth_noteworthy_thread");
  self endon("disconnect");
  var_0 = 0;
  var_1 = undefined;
  for(;;) {
    var_1 = self.var_10E53["kills"];
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    var_2 = var_1;
    var_3 = gettime();
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level waittill("ai_killed", var_4, var_5, var_6, var_7);
    if(!isDefined(var_5) || var_5 != self) {
      continue;
    }

    if(!scripts\engine\utility::flag("stealth_enabled") || scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    if(isDefined(var_4) && isDefined(var_4.team) && var_4.team != "axis") {
      thread func_10EE0("civilian_kill", var_4);
    }

    var_1 = self.var_10E53["kills"];
    if(!isDefined(var_1)) {
      var_1 = 1;
    }

    var_8 = var_1 - var_2;
    if(gettime() - var_3 > 1000) {
      var_0 = 0;
    }

    var_9 = isDefined(var_7) && weapontype(var_7) == "bullet";
    if(var_8 >= 2 && var_9) {
      thread func_10EE0("good_kill_double", var_4, 1);
    }

    var_0 = var_0 + var_8;
    if(var_0 > 1) {
      thread func_10EE0("good_kill_impressive", var_4, 1);
      continue;
    }

    if(var_9) {
      thread func_10EE0("good_kill_bullet", var_4, 1);
      continue;
    }

    thread func_10EE0("good_kill", var_4, 1);
  }
}

func_10EE0(var_0, var_1, var_2) {
  var_3 = [var_1];
  if(isDefined(self.var_10E6D.var_10EDC)) {
    if(func_10EE2(self.var_10E6D.var_10EDC) > func_10EE2(var_0)) {
      return;
    }

    if(var_0 == "aim") {
      if(self.var_10E6D.var_10EDD[0] == var_1) {
        return;
      } else {
        self.var_10E6D.var_10EDD = var_3;
      }
    } else if(self.var_10E6D.var_10EDC == var_0) {
      self.var_10E6D.var_10EDD[self.var_10E6D.var_10EDD.size] = var_1;
    } else {
      self.var_10E6D.var_10EDD = var_3;
    }
  } else {
    self.var_10E6D.var_10EDC = var_0;
    self.var_10E6D.var_10EDD = var_3;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");
  if(scripts\engine\utility::istrue(var_2) && isDefined(self.var_10E6D.var_B476)) {
    self.var_10E6D.var_10EDE = self.var_10E6D.var_B476;
  }

  wait(1);
  self.var_10E6D.var_10EDD = scripts\engine\utility::array_removeundefined(self.var_10E6D.var_10EDD);
  if(scripts\engine\utility::istrue(var_2) && isDefined(self.var_10E6D.var_B476) && self.var_10E6D.var_10EDE < self.var_10E6D.var_B476) {
    self.var_10E6D.var_10EDC = undefined;
    self.var_10E6D.var_10EDD = undefined;
    return;
  }

  if(var_0 == "aim") {
    foreach(var_5 in self.var_10E6D.var_10EDD) {
      self.var_10E6D.var_10EDF[var_5 getentitynumber()] = var_5;
    }
  }

  self notify("stealth_noteworthy", var_0, self.var_10E6D.var_10EDD);
  self.var_10E6D.var_10EDC = undefined;
  self.var_10E6D.var_10EDD = undefined;
}

func_10EE2(var_0) {
  if(!isDefined(var_0)) {
    return -1;
  }

  switch (var_0) {
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

func_1DD6(var_0) {
  if(isDefined(var_0)) {
    for(var_1 = var_0.size - 1; var_1 >= 0; var_1--) {
      var_2 = var_0[var_1];
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        if(!soundexists(var_2[var_3])) {
          for(var_4 = var_3; var_4 < var_2.size - 1; var_4++) {
            var_2[var_4] = var_2[var_4 + 1];
          }

          var_2[var_2.size - 1] = undefined;
        }
      }

      if(var_2.size == 0) {
        for(var_4 = var_1; var_4 < var_0.size - 1; var_4++) {
          var_0[var_4] = var_0[var_4 + 1];
        }

        var_0[var_0.size - 1] = undefined;
      }
    }
  }

  level.var_10E6D.var_DBED = spawnStruct();
  level.var_10E6D.var_DBED.var_AD4E = var_0;
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

  var_0 = level.var_10E6D.var_DBED.var_CC65.size - 1;
  var_1 = level.var_10E6D.var_DBED.var_CC65[var_0];
  level.var_10E6D.var_DBED.var_CC65[var_0] = undefined;
  return var_1;
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

    var_0 = func_1D7D(0, 1);
    var_1 = undefined;
    var_2 = func_1D7D(!isDefined(self.var_10E6D.var_DBEE), 0);
    if(var_2.size > 0 && var_0.size == 0 || randomfloat(1) > 0.5) {
      var_1 = func_1DD5();
    }

    if(isDefined(var_1)) {
      thread func_1DD7(var_1);
      continue;
    }

    if(var_0.size > 0 && !scripts\engine\utility::istrue(level.var_10E6D.var_5659)) {
      if(var_0[0].var_10E6D.var_C9A8 == "unaware") {
        var_0[0] thread lib_0F27::func_1284A("chatter");
      } else {
        var_0[0] thread lib_0F27::func_1284A("enemysweep");
      }

      var_0[0].var_10E6D.var_134F4 = gettime() + randomintrange(30000, -20536);
    }
  }
}

func_1D7D(var_0, var_1) {
  var_2 = 1000;
  var_3 = var_2 * var_2;
  var_4 = [];
  if(!var_0 && !var_1) {
    return var_4;
  }

  var_5 = level.var_10E6D.enemies[self.team];
  if(var_0) {
    var_5 = scripts\engine\utility::array_combine(var_5, getcorpsearray());
  }

  var_5 = scripts\engine\utility::array_removeundefined(var_5);
  foreach(var_7 in var_5) {
    if(!var_0 && !isalive(var_7)) {
      continue;
    }

    if(!var_0 && !isDefined(var_7.var_10E6D) || issentient(var_7) && var_7.var_28 == "combat") {
      continue;
    }

    if(issentient(var_7) && var_7.precacheleaderboards) {
      continue;
    }

    if(issentient(var_7) && !isDefined(var_7.var_10E6D) || !isDefined(var_7.var_10E6D.var_C9A8)) {
      continue;
    }

    var_8 = distancesquared(var_7.origin, self.origin);
    if(var_8 > var_3) {
      continue;
    }

    if(var_0) {
      var_4[var_4.size] = var_7;
      continue;
    }

    if(var_1 && isDefined(var_7.var_10E6D)) {
      if(isDefined(var_7.var_10E6D.var_134F4) && gettime() < var_7.var_10E6D.var_134F4) {
        continue;
      }

      if(isDefined(var_7.var_10E6D.var_A90B) && gettime() - var_7.var_10E6D.var_A90B < 10000) {
        continue;
      }

      if(isDefined(var_7.var_10E6D.var_A908) && gettime() - var_7.var_10E6D.var_A908 < 10000) {
        continue;
      }

      var_4[var_4.size] = var_7;
    }
  }

  var_4 = sortbydistance(var_4, self.origin);
  return var_4;
}

func_1DD7(var_0) {
  self notify("ambient_radio_conversation");
  self endon("ambient_radio_conversation");
  self endon("disconnect");
  self.var_10E6D.var_DBEE = var_0;
  for(var_1 = 0; isDefined(self.var_10E6D.var_DBEE) && var_1 < self.var_10E6D.var_DBEE.size; var_1 = var_1 + 1) {
    var_2 = self.var_10E6D.var_DBEE[var_1];
    var_3 = func_1D7D(1, 0);
    if(isDefined(var_3[0])) {
      if(soundexists(var_0[var_1])) {
        var_3[0] playSound(var_2, "stealth_ambient_radio", 1);
        var_3[0] waittill("stealth_ambient_radio");
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