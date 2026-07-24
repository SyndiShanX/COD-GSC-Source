/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3876.gsc
**************************************/

main() {
  if(isDefined(self._id_10E6D)) {
    return;
  }
  _id_0F27::_id_868B("stealth_spotted");
  scripts\sp\utility::_id_65E0("stealth_enabled");
  scripts\sp\utility::_id_65E1("stealth_enabled");
  scripts\sp\utility::_id_65E0("stealth_in_shadow");
  self._id_10E6D = spawnStruct();
  self._id_10E6D._id_10A9D = [];
  _id_0F27::_id_8682();
  thread _id_13436();
}

_id_13436() {
  self endon("death");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");
    self.maxvisibledist = _id_7938();
    wait 0.05;
  }
}

_id_7938() {
  var_0 = self getstance();

  if(_id_0F27::_id_869D()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level._id_10E6D._id_53A0._id_DCCA[var_1][var_0];
  var_3 = 1.0;

  if(scripts\sp\utility::_id_65DB("stealth_in_shadow")) {
    var_3 = var_3 * 0.5;
  }

  var_2 = var_2 * var_3;

  if(var_2 < level._id_10E6D._id_53A0._id_DCCA["hidden"]["prone"]) {
    var_2 = level._id_10E6D._id_53A0._id_DCCA["hidden"]["prone"];
  }

  return var_2;
}

_id_10EE3(var_0) {
  self notify("stealth_noteworthy_thread");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!var_0) {
    return;
  }
  self endon("stealth_noteworthy_thread");
  self endon("disconnect");

  if(!isDefined(self._id_10E6D._id_10EDF)) {
    self._id_10E6D._id_10EDF = [];
  }

  thread _id_10EE1();

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    var_1 = -1.0;
    var_2 = undefined;

    if(self playerads() > 0.3) {
      var_3 = self getEye();
      var_4 = anglesToForward(self getplayerangles());
      var_5 = getaiarray();

      foreach(var_7 in var_5) {
        var_8 = var_7 getentitynumber();

        if(isDefined(self._id_10E6D._id_10EDF[var_8])) {
          continue;
        }
        var_9 = var_7.origin;

        if(issentient(var_7)) {
          var_9 = var_7 getEye();
        }

        var_10 = vectorNormalize(var_9 - var_3);
        var_11 = vectordot(var_4, var_10);

        if(var_11 > 0.99 && var_11 > var_1) {
          if(sighttracepassed(var_9, var_3, 0, undefined)) {
            var_1 = var_11;
            var_2 = var_7;
          }
        }
      }

      if(isDefined(var_2)) {
        thread _id_10EE0("aim", var_2);
      }

      foreach(var_8, var_14 in self._id_10E6D._id_10EDF) {
        if(!isDefined(self._id_10E6D._id_10EDF[var_8])) {
          self._id_10E6D._id_10EDF[var_8] = undefined;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_10EE1() {
  self endon("stealth_noteworthy_thread");
  self endon("disconnect");
  var_0 = 0;
  var_1 = undefined;

  for(;;) {
    var_1 = self._id_10E53["kills"];

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
      thread _id_10EE0("civilian_kill", var_4);
    }

    var_1 = self._id_10E53["kills"];

    if(!isDefined(var_1)) {
      var_1 = 1;
    }

    var_8 = var_1 - var_2;

    if(gettime() - var_3 > 1000) {
      var_0 = 0;
    }

    var_9 = isDefined(var_7) && weapontype(var_7) == "bullet";

    if(var_8 >= 2 && var_9) {
      thread _id_10EE0("good_kill_double", var_4, 1);
    }

    var_0 = var_0 + var_8;

    if(var_0 > 1) {
      thread _id_10EE0("good_kill_impressive", var_4, 1);
      continue;
    }

    if(var_9) {
      thread _id_10EE0("good_kill_bullet", var_4, 1);
      continue;
    }

    thread _id_10EE0("good_kill", var_4, 1);
  }
}

_id_10EE0(var_0, var_1, var_2) {
  var_3 = [var_1];

  if(isDefined(self._id_10E6D._id_10EDC)) {
    if(_id_10EE2(self._id_10E6D._id_10EDC) > _id_10EE2(var_0)) {
      return;
    }
    if(var_0 == "aim") {
      if(self._id_10E6D._id_10EDD[0] == var_1) {
        return;
      } else {
        self._id_10E6D._id_10EDD = var_3;
      }
    } else if(self._id_10E6D._id_10EDC == var_0)
      self._id_10E6D._id_10EDD[self._id_10E6D._id_10EDD.size] = var_1;
    else {
      self._id_10E6D._id_10EDD = var_3;
    }
  } else {
    self._id_10E6D._id_10EDC = var_0;
    self._id_10E6D._id_10EDD = var_3;
  }

  self notify("stealth_noteworthy_delayed");
  self endon("stealth_noteworthy_delayed");
  self endon("disconnect");

  if(scripts\engine\utility::is_true(var_2) && isDefined(self._id_10E6D._id_B476)) {
    self._id_10E6D._id_10EDE = self._id_10E6D._id_B476;
  }

  wait 1.0;
  self._id_10E6D._id_10EDD = scripts\engine\utility::array_removeundefined(self._id_10E6D._id_10EDD);

  if(scripts\engine\utility::is_true(var_2) && isDefined(self._id_10E6D._id_B476) && self._id_10E6D._id_10EDE < self._id_10E6D._id_B476) {
    self._id_10E6D._id_10EDC = undefined;
    self._id_10E6D._id_10EDD = undefined;
    return;
  }

  if(var_0 == "aim") {
    foreach(var_5 in self._id_10E6D._id_10EDD) {
      self._id_10E6D._id_10EDF[var_5 getentitynumber()] = var_5;
    }
  }

  self notify("stealth_noteworthy", var_0, self._id_10E6D._id_10EDD);
  self._id_10E6D._id_10EDC = undefined;
  self._id_10E6D._id_10EDD = undefined;
}

_id_10EE2(var_0) {
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

_id_1DD6(var_0) {
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

  level._id_10E6D._id_DBED = spawnStruct();
  level._id_10E6D._id_DBED._id_AD4E = var_0;
  level._id_10E6D._id_DBED._id_CC65 = undefined;
  _id_1DD8();
}

_id_1DD5() {
  if(!isDefined(level._id_10E6D)) {
    return undefined;
  }

  if(!isDefined(level._id_10E6D._id_DBED)) {
    return undefined;
  }

  if(!isDefined(level._id_10E6D._id_DBED._id_AD4E)) {
    return undefined;
  }

  if(level._id_10E6D._id_DBED._id_AD4E.size == 0) {
    return undefined;
  }

  if(!isDefined(level._id_10E6D._id_DBED._id_CC65) || level._id_10E6D._id_DBED._id_CC65.size == 0) {
    level._id_10E6D._id_DBED._id_CC65 = scripts\engine\utility::array_randomize(level._id_10E6D._id_DBED._id_AD4E);
  }

  var_0 = level._id_10E6D._id_DBED._id_CC65.size - 1;
  var_1 = level._id_10E6D._id_DBED._id_CC65[var_0];
  level._id_10E6D._id_DBED._id_CC65[var_0] = undefined;
  return var_1;
}

_id_1DD3() {
  self notify("ambient_player_thread");
  self endon("ambient_player_thread");
  self endon("disconnect");

  for(;;) {
    if(!isalive(self)) {
      wait 0.05;
      continue;
    }

    scripts\sp\utility::_id_65E3("stealth_enabled");
    wait(randomfloatrange(10, 15));

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }
    var_0 = _id_1D7D(0, 1);
    var_1 = undefined;
    var_2 = _id_1D7D(!isDefined(self._id_10E6D._id_DBEE), 0);

    if(var_2.size > 0 && (var_0.size == 0 || randomfloat(1.0) > 0.5)) {
      var_1 = _id_1DD5();
    }

    if(isDefined(var_1)) {
      thread _id_1DD7(var_1);
      continue;
    }

    if(var_0.size > 0 && !scripts\engine\utility::is_true(level._id_10E6D._id_5659)) {
      if(var_0[0]._id_10E6D._id_C9A8 == "unaware") {
        var_0[0] thread _id_0F27::_id_1284A("chatter");
      } else {
        var_0[0] thread _id_0F27::_id_1284A("enemysweep");
      }

      var_0[0]._id_10E6D._id_134F4 = gettime() + randomintrange(30000, 45000);
    }
  }
}

_id_1D7D(var_0, var_1) {
  var_2 = 1000;
  var_3 = var_2 * var_2;
  var_4 = [];

  if(!var_0 && !var_1) {
    return var_4;
  }

  var_5 = level._id_10E6D.enemies[self.team];

  if(var_0) {
    var_5 = scripts\engine\utility::array_combine(var_5, getcorpsearray());
  }

  var_5 = scripts\engine\utility::array_removeundefined(var_5);

  foreach(var_7 in var_5) {
    if(!var_0 && !isalive(var_7)) {
      continue;
    }
    if(!var_0 && (!isDefined(var_7._id_10E6D) || issentient(var_7) && var_7.alertlevel == "combat")) {
      continue;
    }
    if(issentient(var_7) && var_7.ignoreall) {
      continue;
    }
    if(issentient(var_7) && (!isDefined(var_7._id_10E6D) || !isDefined(var_7._id_10E6D._id_C9A8))) {
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

    if(var_1 && isDefined(var_7._id_10E6D)) {
      if(isDefined(var_7._id_10E6D._id_134F4) && gettime() < var_7._id_10E6D._id_134F4) {
        continue;
      }
      if(isDefined(var_7._id_10E6D._id_A90B) && gettime() - var_7._id_10E6D._id_A90B < 10000) {
        continue;
      }
      if(isDefined(var_7._id_10E6D._id_A908) && gettime() - var_7._id_10E6D._id_A908 < 10000) {
        continue;
      }
      var_4[var_4.size] = var_7;
    }
  }

  var_4 = sortbydistance(var_4, self.origin);
  return var_4;
}

_id_1DD7(var_0) {
  self notify("ambient_radio_conversation");
  self endon("ambient_radio_conversation");
  self endon("disconnect");
  self._id_10E6D._id_DBEE = var_0;

  for(var_1 = 0; isDefined(self._id_10E6D._id_DBEE) && var_1 < self._id_10E6D._id_DBEE.size; var_1 = var_1 + 1) {
    var_2 = self._id_10E6D._id_DBEE[var_1];
    var_3 = _id_1D7D(1, 0);

    if(isDefined(var_3[0])) {
      if(soundexists(var_0[var_1])) {
        var_3[0] playSound(var_2, "stealth_ambient_radio", 1);
        var_3[0] waittill("stealth_ambient_radio");
      }
    }

    wait(randomfloatrange(1.0, 3.0));
  }

  self._id_10E6D._id_DBEE = undefined;
}

_id_1DD8() {
  self._id_10E6D._id_DBEE = undefined;
  self notify("ambient_radio_conversation");
}

_id_1DD2() {
  self notify("ambient_player_thread");
  _id_1DD8();
}