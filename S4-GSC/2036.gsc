/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2036.gsc
*************************************************/

_id_8224() {
  _id_C623();
}

_id_C623() {
  self._id_9F75 = undefined;
  self._id_9F76 = undefined;
  self._id_9F73 = undefined;
  self._id_9F74 = undefined;
}

_id_C621() {
  if(!isDefined(self._id_9F79)) {
    return;
  }
  self._id_9F79 = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("missileLauncher_lock_lost");
  self _meth_8459();
  self _meth_83EF("maaws_reticle_tracking");
  self _meth_83EF("maaws_reticle_locked");

  if(isDefined(self._id_9F76)) {
    scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_9F76, self);
  }

  _id_C623();
}

_id_C622() {
  self endon("disconnect");
  self notify("ResetMissileLauncherLockingOnDeath");
  self endon("ResetMissileLauncherLockingOnDeath");
  self endon("end_launcher");

  for(;;) {
    self waittill("death");
    _id_C621();
  }
}

_id_9842() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level._id_3643) && isDefined(level._id_3643._id_72B3) && isDefined(self._id_9F76) && self._id_9F76 == level._id_3643._id_72B3) {
      level._id_731C playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level._id_731C) && isDefined(self._id_9F76) && self._id_9F76 == level._id_72C7._id_B18E) {
      level._id_731C playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.6;
  }
}

_id_9841() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locked_feedback");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level._id_3643) && isDefined(level._id_3643._id_72B3) && isDefined(self._id_9F76) && self._id_9F76 == level._id_3643._id_72B3) {
      level._id_731C playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level._id_731C) && isDefined(self._id_9F76) && self._id_9F76 == level._id_72C7._id_B18E) {
      level._id_731C playlocalsound("maaws_incoming_lp");
    }

    self playrumbleonentity("ac130_25mm_fire");
    wait 0.25;
  }
}

_id_DFEE(var_0) {
  var_1 = 500;

  if(var_0 _id_E866()) {
    self._id_9F74 = 0;
    return 1;
  }

  if(self._id_9F74 == 0) {
    self._id_9F74 = gettime();
  }

  var_2 = gettime() - self._id_9F74;

  if(var_2 >= var_1) {
    _id_C621();
    return 0;
  }

  return 1;
}

_id_9F77() {
  var_0 = getdvarint("#x3f2fe94fa15345e1e", 625000000);
  var_1 = 0;

  if(self playerads() < 0.95) {
    _id_C621();
    return;
  }

  self._id_9F79 = 1;

  if(!isDefined(self._id_9F75)) {
    self._id_9F75 = 0;
  }

  if(self._id_9F75 == 0) {
    var_2 = scripts\mp\weapons::_id_96FE(0);

    if(var_2.size == 0) {
      return;
    }
    var_2 = _func_0204(var_2, self.origin);
    var_3 = undefined;
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_3 = _id_E861(self, var_6);
      var_3 _id_E864();
      var_3 _id_E865();
      var_3 _id_E863();

      if(var_3 _id_E867()) {
        if(distancesquared(var_6.origin, self.origin) > var_0) {
          break;
        }

        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      return;
    }
    var_3 _id_E862();

    if(!var_3 _id_E866()) {
      return;
    }
    self._id_9F76 = var_3.target;
    self._id_9F73 = gettime();
    self._id_9F75 = 1;
    self._id_9F74 = 0;

    if(isDefined(self._id_9F76)) {
      scripts\cp_mp\utility\weapon_utility::_id_10E5(self._id_9F76, self);
    }

    thread _id_9842();
  }

  if(self._id_9F75 == 1) {
    if(!isDefined(self._id_9F76)) {
      _id_C621();
      return;
    }

    if(!var_1 && (self._id_9F76 scripts\cp_mp\vehicles\vehicle::_id_8AF5() && scripts\cp_mp\vehicles\vehicle::_id_10124(self._id_9F76, self))) {
      _id_C621();
      return;
    }

    var_3 = _id_E861(self, self._id_9F76);
    var_3 _id_E864();
    var_3 _id_E865();
    var_3 _id_E863();

    if(!var_3 _id_E867()) {
      _id_C621();
      return;
    }

    var_3 _id_E862();

    if(!_id_DFEE(var_3)) {
      return;
    }
    var_8 = gettime() - self._id_9F73;

    if(scripts\mp\utility\perk::_hasperk("specialty_fasterlockon")) {
      if(var_8 < 250.0) {
        return;
      }
    } else if(var_8 < 500) {
      return;
    }
    self notify("stop_javelin_locking_feedback");
    thread _id_9841();
    var_9 = undefined;
    _id_9F72(var_3);

    if(isDefined(level._id_0F4C)) {
      if(scripts\engine\utility::array_contains(level._id_0F4C, self._id_9F76)) {
        thread scripts\mp\battlechatter_mp::_id_8DDC(self._id_9F76.streakname);
      }
    }

    self._id_9F75 = 2;
  }

  if(self._id_9F75 == 2) {
    if(!isDefined(self._id_9F76)) {
      _id_C621();
      return;
    }

    if(!var_1 && (self._id_9F76 scripts\cp_mp\vehicles\vehicle::_id_8AF5() && scripts\cp_mp\vehicles\vehicle::_id_10124(self._id_9F76, self))) {
      _id_C621();
      return;
    }

    var_3 = _id_E861(self, self._id_9F76);
    var_3 _id_E864();
    var_3 _id_E865();
    var_3 _id_E863();
    var_3 _id_E862();

    if(!_id_DFEE(var_3)) {
      return;
    } else {
      _id_9F72(var_3);
    }

    if(!var_3 _id_E867()) {
      _id_C621();
      return;
    }
  }
}

_id_9F78() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  thread _id_C622();

  for(;;) {
    wait 0.05;
    _id_9F77();
  }
}

_id_9F72(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target) && isDefined(var_0.target._id_1031E) && var_0.target._id_1031E == "light_tank") {
    var_1 = (0, 0, 75);
  } else if(isDefined(var_0._id_82C8)) {
    var_1 = var_0._id_A982[var_0._id_82C8];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else
    var_1 = (0, 0, 0);

  self _meth_8458(self._id_9F76, var_1);
}

_id_10BC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(isDefined(var_0.owner) && !scripts\mp\utility\killstreak::_id_8992(var_0)) {
    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
}

_id_C4D1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(!scripts\mp\utility\killstreak::_id_8992(var_0)) {
    if(!isDefined(var_0.owner)) {
      return;
    }
    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
}

_id_E861(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_2.target = var_1;
  var_2._id_A982 = [];
  var_2._id_AC95 = [];
  var_2._id_82E2 = [];
  var_2._id_82E3 = [];
  var_2._id_82C8 = undefined;
  var_2._id_FE99 = 1;
  return var_2;
}

_id_E864() {
  self._id_A982 = [];

  if(scripts\mp\utility\entity::_id_87AE(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, -50);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_8A80(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, -100);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_8889(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, 50);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_87B4(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, 40);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_8AB6(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, 42);
    self._id_A982[self._id_A982.size] = (0, 0, 5);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_89D2(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, 10);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_8A1A(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, 15);
    self._id_FE99 = 0;
  } else if(scripts\mp\utility\entity::_id_89D3(self.target)) {
    self._id_A982[self._id_A982.size] = (0, 0, -30);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "light_tank") {
    self._id_A982[self._id_A982.size] = (0, 0, 72);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "apc_russian") {
    self._id_A982[self._id_A982.size] = (0, 0, 60);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "cargo_truck") {
    self._id_A982[self._id_A982.size] = (0, 0, 60);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "large_transport") {
    self._id_A982[self._id_A982.size] = (0, 0, 65);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "medium_transport") {
    self._id_A982[self._id_A982.size] = (0, 0, 60);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && (self.target._id_1031E == "pickup_truck" || self.target._id_1031E == "technical")) {
    self._id_A982[self._id_A982.size] = (0, 0, 55);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "atv") {
    self._id_A982[self._id_A982.size] = (0, 0, 30);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && (self.target._id_1031E == "jeep" || self.target._id_1031E == "tac_rover")) {
    self._id_A982[self._id_A982.size] = (0, 0, 50);
    self._id_FE99 = 0;
  } else if(isDefined(self.target._id_1031E) && self.target._id_1031E == "loot_chopper") {
    self._id_A982[self._id_A982.size] = (0, 0, -100);
    self._id_FE99 = 0;
  } else
    self._id_A982[self._id_A982.size] = (0, 0, 0);
}

_id_E865() {
  var_0 = self.target.origin;
  var_1 = self.target.angles;
  var_2 = anglesToForward(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglestoup(var_1);

  for(var_5 = 0; var_5 < self._id_A982.size; var_5++) {
    var_6 = self._id_A982[var_5];
    self._id_AC95[var_5] = var_0 + var_3 * var_6[0] + var_2 * var_6[1] + var_4 * var_6[2];
  }
}

_id_E863() {
  foreach(var_5, var_1 in self._id_AC95) {
    for(var_2 = 0; var_2 < self._id_AC95.size; var_2++) {
      var_3 = self.player _meth_8460(self._id_AC95[var_2], 65);

      if(isDefined(var_3)) {
        var_4 = _func_0134(var_3);

        if(var_4 <= 2916) {
          self._id_82E3[self._id_82E3.size] = var_2;
          self._id_82E2[var_2] = var_4;
        }
      }
    }
  }

  if(self._id_82E3.size > 1) {
    for(var_2 = 0; var_2 < self._id_82E3.size; var_2++) {
      for(var_6 = var_2 + 1; var_6 < self._id_82E3.size; var_6++) {
        var_7 = self._id_82E3[var_2];
        var_8 = self._id_82E3[var_6];
        var_9 = self._id_82E2[var_7];
        var_10 = self._id_82E2[var_8];

        if(var_10 < var_9) {
          var_11 = var_7;
          self._id_82E3[var_2] = var_8;
          self._id_82E3[var_6] = var_11;
        }
      }
    }
  }
}

_id_E862() {
  var_0 = self.player getEye();
  var_1 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item", "physicscontents_playernosight"]);
  var_2 = [self.player, self.target];
  var_3 = self.target _meth_8150();

  if(isDefined(var_3) && var_3.size > 0) {
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(!self._id_FE99) {
    for(var_4 = 0; var_4 < self._id_82E3.size; var_4++) {
      var_5 = self._id_82E3[var_4];
      var_6 = self._id_AC95[var_5];
      var_7 = _func_02C1(var_0, var_6, var_1, var_2, 0, "physicsquery_closest", 1);

      if(!isDefined(var_7) || var_7.size == 0) {
        self._id_82C8 = var_5;
        return;
      }
    }
  } else {
    var_8 = self.target _meth_8174(0, 0, 1);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_8, var_2, var_1, 0);

    if(var_9["fraction"] == 1) {
      self._id_82C8 = 0;
      return;
    }

    var_18 = self.target _meth_8174(1, 0, 0);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_18, var_2, var_1, 0);

    if(var_9["fraction"] == 1) {
      self._id_82C8 = 0;
      return;
    }

    var_19 = self.target _meth_8174(-1, 0, 0);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_19, var_2, var_1, 0);

    if(var_9["fraction"] == 1) {
      self._id_82C8 = 0;
      return;
    }
  }
}

_id_E867() {
  return self._id_82E3.size > 0;
}

_id_E866() {
  return isDefined(self._id_82C8);
}