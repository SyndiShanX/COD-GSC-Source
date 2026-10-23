/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_binoculars.gsc
*******************************************/

_id_175E() {
  thread stingerm7_targeting();
  thread stingerm7_monitor_fire();
}

stingerm7_targeting() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self.stingerm7_info = spawnStruct();
  self.stingerm7_info.locked_targets = [];
  self.stingerm7_info.locking_time = 0;
  var_0 = 0;

  for(;;) {
    if(issubstr(self getcurrentweapon(), "binoculars") && self playerads() > 0.99) {
      var_0 = 1;

      if(self.stingerm7_info.locked_targets.size > 0) {
        remove_invalid_locks();
      }

      self.stingerm7_info.locked_targets = _id_0F95(common_scripts\utility::_id_0FA0(self.stingerm7_info.locked_targets));

      if(isDefined(self.stingerm7_info.locking_target)) {
        if(!locking_target_still_valid(self.stingerm7_info.locking_target)) {
          self.stingerm7_info.locking_target = undefined;
          self notify("stop_javelin_locking_feedback");
        }
      }

      if(isDefined(self.stingerm7_info.locking_target)) {
        self.stingerm7_info.locking_time = self.stingerm7_info.locking_time + 0.05;
      } else {
        self.stingerm7_info.locking_time = 0;

        if(self.stingerm7_info.locked_targets.size < 1) {
          self.stingerm7_info.locking_target = get_best_locking_target();

          if(isDefined(self.stingerm7_info.locking_target)) {
            thread locking_feedback();
          }
        }
      }

      if(self.stingerm7_info.locking_time >= 1 && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locked_targets.size < 1) {
        self notify("stop_javelin_locking_feedback");
        self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;
        thread locked_feedback();
        self.stingerm7_info.locking_target = undefined;
      }

      if(self.stingerm7_info.locked_targets.size > 0) {
        self weaponlockfinalize(self.stingerm7_info.locked_targets[0]);
      } else {
        self weaponlockfree();
        self notify("stop_javelin_locked_feedback");
      }
    } else if(var_0 == 1) {
      var_0 = 0;
      self weaponlockfree();
      self notify("stop_javelin_locking_feedback");
      self notify("stop_javelin_locked_feedback");
      self.stingerm7_info.locked_targets = [];

      if(isDefined(self.stingerm7_info.locking_target)) {
        self.stingerm7_info.locking_target = undefined;
      }

      self.stingerm7_info.locking_time = 0;
    }

    waitframe();
  }
}

stingerm7_monitor_fire() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(issubstr(var_1, "binoculars")) {
      thread stinger_fire(self, var_0, var_1);
    }
  }
}

stinger_fire(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_3 = var_1.origin;
    var_4 = var_1.angles;
    var_1 delete();
  } else
    return;

  var_0.stingerm7_info.locked_targets = _id_0F95(common_scripts\utility::_id_0FA0(self.stingerm7_info.locked_targets));
  var_5 = [];

  for(var_6 = 0; var_6 < 1; var_6++) {
    var_7 = var_4 + random_vector(20, 20, 20);
    var_8 = anglesToForward(var_7);
    var_9 = _magicbullet(var_2, var_3, var_3 + var_8, var_0);
    var_9._id_0117 = var_0;

    if(var_0.stingerm7_info.locked_targets.size > 0) {
      var_10 = undefined;

      if(var_6 < var_0.stingerm7_info.locked_targets.size) {
        var_10 = var_0.stingerm7_info.locked_targets[var_6];
      } else {
        var_10 = var_0.stingerm7_info.locked_targets[randomint(var_0.stingerm7_info.locked_targets.size)];
      }

      var_9 missile_settargetEnt(var_10, stingerm7_get_target_offset(var_10));
      var_9.lockedstingertarget = var_10;
    }

    var_5[var_5.size] = var_9;
  }

  level notify("stinger_fired", var_0, var_5);
  thread _id_49F2(var_5[0].lockedstingertarget, var_5[0]);
  var_0 setweaponammoclip(var_2, 0);
}

_id_49F2(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 endon("death");
  var_2 = "orbitalsupport_exp_40mm";
  wait(_randomfloatrange(0.5, 1.0));

  while(1 && isDefined(var_0)) {
    var_3 = _randomintrange(-50, 50);
    var_4 = _randomintrange(-100, 100);
    var_5 = _randomintrange(-200, 200);

    foreach(var_7 in level.players) {
      var_7 playfx(common_scripts\utility::getfx("flak_gun_explosion"), var_0.origin + (var_3, var_4, var_5));
      var_7 playSound(var_2);
    }

    wait(_randomfloatrange(0.05, 1.0));
  }
}

_id_0F12(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.lockedstingertarget) && var_3.lockedstingertarget == var_1) {
      return 1;
    }
  }

  return 0;
}

get_best_locking_target() {
  var_0 = maps\mp\_utility::getotherteam(self.team);
  var_1 = [];

  if(0) {
    foreach(var_3 in level.players) {
      if(level.teambased && var_3.team == self.team) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_3)) {
        continue;
      }
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = _vehicle_getarray();
  var_6 = [];

  foreach(var_8 in var_5) {
    if(!isDefined(var_8._id_0117)) {
      continue;
    }
    if(level.teambased && var_8._id_0117.team == self.team) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  var_10 = _id_051E::getaerialkillstreakarray(var_0);
  var_11 = common_scripts\utility::_id_0F73(var_1, var_6);
  var_11 = common_scripts\utility::_id_0F73(var_11, var_10);

  if(isDefined(level._id_93A8)) {
    var_11 = common_scripts\utility::_id_0F73(var_11, [[level._id_93A8]](self));
  }

  var_12 = self getEye();
  var_13 = anglesToForward(self getplayerangles());
  var_14 = undefined;
  var_15 = _cos(5);

  foreach(var_17 in var_11) {
    if(!common_scripts\utility::_id_0F79(self.stingerm7_info.locked_targets, var_17)) {
      var_18 = stingerm7_get_target_pos(var_17);
      var_19 = vectordot(vectorNormalize(var_18 - var_12), var_13);

      if(var_19 > var_15) {
        var_20 = undefined;
        var_21 = !1;

        if(!var_21) {
          var_22 = _bullettracepassed(var_12, var_18, 0, var_17);

          if(var_22) {
            var_21 = 1;
          }
        }

        if(var_21) {
          var_14 = var_17;
          var_15 = var_19;
        }
      }
    }
  }

  return var_14;
}

locking_target_still_valid(var_0) {
  var_1 = self getEye();
  var_2 = anglesToForward(self getplayerangles());
  var_3 = stingerm7_get_target_pos(var_0);

  if((isPlayer(var_0) || isbot(var_0)) && !maps\mp\_utility::isreallyalive(var_0)) {
    return 0;
  }

  if(vectordot(vectorNormalize(var_3 - var_1), var_2) > _cos(5)) {
    if(!1 || _bullettracepassed(var_1, var_3, 0, var_0)) {
      return 1;
    }
  }

  return 0;
}

remove_invalid_locks() {
  for(var_0 = 0; var_0 <= self.stingerm7_info.locked_targets.size; var_0++) {
    if(isDefined(self.stingerm7_info.locked_targets[var_0]) && isDefined(self.stingerm7_info.locked_targets[var_0].origin)) {
      if(!isDefined(self.stingerm7_info.locked_targets[var_0].sight_lost_time)) {
        self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;
      }

      var_1 = (0, 0, 0);

      if(isPlayer(self.stingerm7_info.locked_targets[var_0]) || isbot(self.stingerm7_info.locked_targets[var_0])) {
        var_1 = (0, 0, 64);
      }

      if(self worldpointinreticle_rect(self.stingerm7_info.locked_targets[var_0].origin + var_1, 50, 400, 200)) {
        if(_bullettracepassed(self getEye(), self.stingerm7_info.locked_targets[var_0].origin + var_1, 0, self.stingerm7_info.locked_targets[var_0])) {
          self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;
          continue;
        }
      }

      if(self.stingerm7_info.locked_targets[var_0].sight_lost_time == -1) {
        self.stingerm7_info.locked_targets[var_0].sight_lost_time = gettime();
        continue;
      }

      if(gettime() - self.stingerm7_info.locked_targets[var_0].sight_lost_time >= 500) {
        self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;
        self.stingerm7_info.locked_targets[var_0] = undefined;
      }
    }
  }
}

stingerm7_get_target_pos(var_0) {
  if(isDefined(var_0.getstingertargetposfunc)) {
    return var_0[[var_0.getstingertargetposfunc]]();
  }

  return var_0 getpointinbounds(0, 0, 0);
}

stingerm7_get_target_offset(var_0) {
  return stingerm7_get_target_pos(var_0) - var_0.origin;
}

locking_feedback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.spawnedwarbirds)) {
      foreach(var_1 in level.spawnedwarbirds) {
        if(isDefined(var_1._id_0117) && isDefined(var_1.player) && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == var_1) {
          var_1._id_0117 playlocalsound("wpn_stingerm7_enemy_locked");
        }
      }
    }

    if(isDefined(level.orbitalsupport_player) && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == level.orbitalsupport_planemodel) {
      level.orbitalsupport_player playlocalsound("wpn_stingerm7_enemy_locked");
    }

    self playlocalsound("wpn_stingerm7_locking");
    self playRumbleOnEntity("heavygun_fire");
    wait 0.6;
  }
}

locked_feedback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level.spawnedwarbirds)) {
      foreach(var_1 in level.spawnedwarbirds) {
        if(isDefined(var_1._id_0117) && isDefined(var_1.player) && isDefined(self.stingerm7_info.locked_targets) && isinarray(self.stingerm7_info.locked_targets, var_1)) {
          var_1._id_0117 playlocalsound("wpn_stingerm7_enemy_locked");
        }
      }
    }

    if(isDefined(level.orbitalsupport_player) && isDefined(self.stingerm7_info.locked_targets) && isinarray(self.stingerm7_info.locked_targets, level.orbitalsupport_planemodel)) {
      level.orbitalsupport_player playlocalsound("wpn_stingerm7_enemy_locked");
    }

    self playlocalsound("wpn_stingerm7_locked");
    self playRumbleOnEntity("heavygun_fire");
    wait 0.25;
  }
}

_id_0F95(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

random_vector(var_0, var_1, var_2) {
  return (_randomfloat(var_0) - var_0 * 0.5, _randomfloat(var_1) - var_1 * 0.5, _randomfloat(var_2) - var_2 * 0.5);
}

isinarray(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}