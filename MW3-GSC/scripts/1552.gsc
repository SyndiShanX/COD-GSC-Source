/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1552.gsc
**************************************/

_id_3B6D(var_0) {
  if(!common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_init("squad_spawning");
  }
  level._id_3B6E = 1;
  level._id_3B6F = 3;
  level._id_3B70 = [];

  if(isDefined(var_0) && var_0) {
    var_1 = common_scripts\utility::getStructArray("leader", "script_noteworthy");
  } else {
    var_1 = getEntArray("leader", "script_noteworthy");
  }
  foreach(var_3 in var_1) {
    if(isDefined(var_3.targetname) && issubstr(var_3.targetname, "protector")) {
      var_1 = common_scripts\utility::array_remove(var_1, var_3);
    }
  }

  level._id_3B71 = ::_id_3B8B;
  thread _id_3B80();
  thread _id_3B7E();
  thread _id_3B99();
  return var_1;
}

_id_3B72(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  if(common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_waitopen("squad_spawning");
  }
  level notify("squad_disband");
  level._id_3B70 = [];

  if(isDefined(var_1)) {
    var_3 = getaiarray("axis");

    foreach(var_5 in var_3) {
      var_5 notify("ai_behavior_change");
      var_5._id_3B73 = undefined;
      var_5._id_3B74 = undefined;

      if(isDefined(var_5._id_3B75) && var_5._id_3B75) {
        if(isDefined(var_2)) {
          var_5 thread[[var_1]](var_2);
        } else {
          var_5 thread[[var_1]]();
        }
      }

      var_5._id_3B75 = 0;
    }
  }
}

_id_3B76(var_0, var_1) {
  level endon("challenge_success");
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_init("squad_spawning");
  }
  var_2 = var_0 common_scripts\utility::get_links();
  var_3 = [];

  foreach(var_5 in var_2) {}
  var_3[var_3.size] = getent(var_5, "script_linkname");

  var_0 thread _id_3B95();
  var_0 waittill("trigger");

  if(getaiarray("axis").size > 1) {
    level._id_3B77 = 1;
    _id_3B7C();
    wait 2.02;
  } else {
    level._id_3B77 = 0;
  }
  if(level._id_3B70.size + var_1 > level._id_3B78) {
    var_1 = level._id_3B78 - level._id_3B70.size;
  }
  for(var_7 = 0; var_7 < var_1; var_7++) {
    _id_3B7B(var_3, undefined, undefined, undefined);
  }
  wait 1;
  level._id_3B77 = 0;
  level notify("clean_up_done");
  level notify("zone_spawn_complete");
}

_id_3B79(var_0) {
  level endon("challenge_success");
  level endon("special_op_terminated");
  var_1 = _id_3B6D();

  if(!isDefined(level._id_3B78)) {
    level._id_3B78 = 4;
  } else {
    var_2 = "Must have at least 4 squad leader spawners in level";
  }
  if(isDefined(level._id_3B7A) && level._id_3B7A) {
    var_3 = getEntArray("zone_trig", "targetname");

    foreach(var_5 in var_3) {}
    thread _id_3B76(var_5, int(var_5.script_noteworthy));

    level waittill("zone_spawn_complete");
  }

  for(;;) {
    wait 0.15;

    if(isDefined(level._id_3B77) && level._id_3B77) {
      level waittill("clean_up_done");
    }
    if(level._id_3B70.size < level._id_3B78) {
      _id_3B7B(var_1, undefined, undefined, var_0);
    }
  }
}

_id_3B7B(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[var_4.size] = level.player;

  if(maps\_utility::_id_12C1()) {
    var_4[var_4.size] = level.players[1];
  }
  foreach(var_6 in level._id_3B70) {}
  var_4[var_4.size] = var_6;

  var_8 = undefined;

  while(var_0.size > 1) {
    foreach(var_10 in var_4) {
      var_8 = maps\_utility::_id_0AE9(var_10.origin, var_0);
      var_0 = common_scripts\utility::array_remove(var_0, var_8);

      if(var_0.size == 1) {
        break;
      }
    }
  }

  var_8 = var_0[0];
  thread _id_3B9A(var_8.origin, (1, 1, 1));

  if(isspawner(var_0[0])) {
    var_12 = getEntArray(var_8.target, "targetname");
  } else {
    var_12 = common_scripts\utility::getStructArray(var_8.target, "targetname");
  }
  var_12[var_12.size] = var_8;

  foreach(var_14 in var_12) {
    if(!isDefined(var_14.script_noteworthy)) {
      var_14.script_noteworthy = "follower";
    }
  }

  common_scripts\utility::flag_set("squad_spawning");
  var_16 = [];
  var_16 = _id_3B81(var_12, var_1, var_2, var_3);
  common_scripts\utility::flag_clear("squad_spawning");
  wait 0.05;
  return var_16;
}

_id_3B7C() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_3B7D)) {
      var_0 = common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  thread maps\_utility::_id_2756(var_0, 1300);
}

_id_3B7E() {
  level endon("challenge_success");
  level endon("special_op_terminated");

  for(;;) {
    wait 1;

    if(!isDefined(level._id_3B70)) {
      continue;
    }
    if(level._id_3B70.size < 2) {
      continue;
    }
    foreach(var_1 in level._id_3B70) {
      if(!isDefined(var_1._id_3B74) || var_1._id_3B74.size < 2) {
        continue;
      }
      foreach(var_3 in level._id_3B70) {
        if(var_3 == var_1) {
          continue;
        }
        if(!isDefined(var_3._id_3B74) || var_3._id_3B74.size < 2) {
          continue;
        }
        if(distance(var_1.origin, var_3.origin) < 600) {
          foreach(var_5 in var_3._id_3B74) {
            if(isDefined(var_5._id_3B7F) && var_5._id_3B7F) {
              var_5.goalradius = 800;
            }
          }

          continue;
        }

        foreach(var_5 in var_3._id_3B74) {
          if(isDefined(var_5._id_3B7F) && var_5._id_3B7F) {
            var_5.goalradius = 600;
          }
        }
      }
    }
  }
}

_id_3B80() {
  level endon("challenge_success");
  level endon("special_op_terminated");

  for(;;) {
    wait 2;

    if(!isDefined(level._id_3B70)) {
      continue;
    }
    if(level._id_3B70.size < 2) {
      continue;
    }
    var_0 = level._id_3B70[0];

    foreach(var_2 in level._id_3B70) {
      if(var_0._id_3B74.size > var_2._id_3B74.size) {
        var_0 = var_2;
      }
    }

    var_4 = common_scripts\utility::array_remove(level._id_3B70, var_0);
    var_5 = var_4[0];

    foreach(var_2 in var_4) {
      if(var_5._id_3B74.size > var_2._id_3B74.size) {
        var_5 = var_2;
      }
    }

    var_8 = var_0._id_3B74.size + var_5._id_3B74.size + 2;

    if(var_8 <= 3) {
      level._id_3B70 = common_scripts\utility::array_remove(level._id_3B70, var_0);
      var_0 notify("demotion");
      var_9 = common_scripts\utility::array_combine(var_0._id_3B74, var_5._id_3B74);
      var_9[var_9.size] = var_0;
      var_9[var_9.size] = var_5;
      var_5 thread _id_3B84(var_9);
      var_10 = common_scripts\utility::array_remove(var_9, var_5);

      foreach(var_12 in var_10) {
        if(isalive(var_12)) {
          var_12 thread _id_3B88(var_5);
        }
      }
    }
  }
}

_id_3B81(var_0, var_1, var_2, var_3) {
  level endon("challenge_success");
  level endon("special_op_terminated");
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = 1;
  }
  if(!isDefined(level._id_3B70)) {
    level._id_3B70 = [];
  }
  if(!isDefined(var_3)) {
    var_3 = var_0.size - 1;
  } else {
    var_3 = int(min(var_0.size - 1, var_3));
  }
  var_5 = "Trying to spawn " + var_3 + " followers but only " + (var_0.size - 1) + " spawners are available!";

  if(var_4 || !isspawner(var_0[0])) {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = getspawnerarray();

    foreach(var_10 in var_8) {
      if(var_10.classname == var_1) {
        var_6 = var_10;
      }
      if(var_10.classname == var_2) {
        var_7 = var_10;
      }
    }

    var_12 = 0;
    var_13 = [];

    foreach(var_15 in var_0) {
      wait 0.05;

      if(var_15.script_noteworthy == "leader") {
        var_6.script_noteworthy = "leader";
        var_6.count = 1;
        var_6.origin = var_15.origin;
        var_6.angles = var_15.angles;
        var_16 = var_6 maps\_utility::_id_166F(1);
        var_13[var_13.size] = var_16;
      }

      if(var_15.script_noteworthy == "follower") {
        if(var_12 >= var_3) {
          continue;
        }
        var_12++;
        var_7.script_noteworthy = "follower";
        var_7.count = 1;
        var_7.origin = var_15.origin;
        var_7.angles = var_15.angles;
        var_16 = var_7 maps\_utility::_id_166F(1);
        var_13[var_13.size] = var_16;
      }
    }
  } else {
    var_12 = 0;
    var_13 = [];

    foreach(var_15 in var_0) {
      if(var_15.script_noteworthy == "follower") {
        var_12++;
      }
      if(var_12 >= var_3) {
        continue;
      }
      var_15.count = 1;
      var_16 = var_15 maps\_utility::_id_166F(1);
      var_13[var_13.size] = var_16;
    }
  }

  if(!var_13.size) {
    return undefined;
  }
  var_20 = [];

  foreach(var_16 in var_13) {
    var_16._id_3B75 = 1;

    if(isalive(var_16)) {
      var_20[var_20.size] = var_16;
    }
  }

  var_13 = var_20;
  var_23 = undefined;

  foreach(var_16 in var_13) {
    if(var_16.script_noteworthy == "leader") {
      var_23 = var_16;
      var_23._id_3B82["left"] = 0;
      var_23._id_3B82["right"] = 0;
      var_23 thread _id_3B84(var_13);
    }
  }

  if(var_13.size < var_0.size && !isDefined(var_23)) {
    var_23 = var_13[randomint(var_13.size)];
    var_23.script_noteworthy = "leader";
    var_23 thread _id_3B84(var_13);
  }

  foreach(var_16 in var_13) {
    if(isDefined(level._id_3B83)) {
      var_27 = randomfloat(1);

      if(var_27 > level._id_3B83) {
        var_16.dropweapon = 0;
      }
    }

    if(var_16.script_noteworthy == "follower") {
      var_16 thread _id_3B88(var_23);
    }
  }

  return var_13;
}

_id_3B84(var_0) {
  level endon("squad_disband");
  self notify("new_leader");
  self endon("new_leader");
  self endon("demotion");
  self._id_3B74 = [];
  self._id_3B73 = undefined;

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      var_0 common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  if(!isDefined(level._id_3B6E) || level._id_3B6E == 0) {
    if(var_0.size == 1 && level._id_3B70.size > 0) {
      var_4 = level._id_3B70[0];

      if(level._id_3B70.size > 1) {
        var_4 = maps\_utility::_id_2605(self.origin, level._id_3B70);
      }
      _id_3B88(var_4);
      return;
    }
  }

  if(!maps\_utility::is_in_array(level._id_3B70, self)) {
    level._id_3B70[level._id_3B70.size] = self;
  }
  if(isDefined(level._id_3B85)) {
    self thread[[level._id_3B85]]();
  } else {
    self.goalradius = 2048;
    var_5 = maps\_utility::_id_0AE9(self.origin, level.players);
    self.favoriteenemy = var_5;
    self setgoalentity(var_5);
    self setengagementmindist(300, 200);
    self setengagementmaxdist(512, 720);
  }

  thread _id_3B87();
  thread _id_3B86();

  if(!isDefined(level._id_3B6E) || level._id_3B6E == 0) {
    thread _id_3B98(var_0);
  }
  self waittill("death");
  var_6 = [];

  foreach(var_4 in level._id_3B70) {
    if(isDefined(var_4) && isalive(var_4)) {
      var_6[var_6.size] = var_4;
    }
  }

  level._id_3B70 = var_6;
  var_4 = undefined;

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      if(!isDefined(var_4)) {
        var_4 = var_2;
        var_2 notify("promotion");
        var_2 thread _id_3B84(var_0);
        continue;
      }

      var_2 thread _id_3B88(var_4);
    }
  }
}

_id_3B86() {
  level endon("squad_disband");
  self endon("new_leader");
  self endon("demotion");
  self endon("death");
  self waittill("enemy_visible");

  if(isDefined(self._id_3B74) && self._id_3B74.size) {
    foreach(var_1 in self._id_3B74) {}
    var_1 notify("leader_saw_player");
  }
}

_id_3B87() {
  level endon("squad_disband");
  self endon("new_leader");
  self endon("demotion");
  self endon("death");
  var_0 = self._id_0FC6;

  for(;;) {
    wait 2;

    if(isDefined(self._id_3B74) && self._id_3B74.size) {
      var_1 = maps\_utility::_id_2605(self.origin, self._id_3B74);

      if(isDefined(var_1) && distance(var_1.origin, self.origin) > 256) {
        self._id_0FC6 = 0.85 * var_0;
      } else {
        self._id_0FC6 = var_0;
      }
    }
  }
}

_id_3B88(var_0) {
  level endon("squad_disband");
  self notify("assigned_new_leader");
  self endon("assigned_new_leader");
  self endon("death");
  self endon("promotion");
  self._id_3B74 = undefined;
  self._id_3B73 = var_0;
  thread _id_3B8A(var_0);

  if(isDefined(level._id_3B89)) {
    self[[level._id_3B89]]();
  }
  if(isDefined(level._id_3B71)) {
    self[[level._id_3B71]](var_0);
  } else {
    thread _id_3B8E(var_0);
  }
}

_id_3B8A(var_0) {
  level endon("squad_disband");
  self endon("assigned_new_leader");
  var_0 endon("death");
  var_0._id_3B74[var_0._id_3B74.size] = self;
  self waittill("death");

  if(!isDefined(self._id_3B73)) {
    return;
  }
  if(isalive(self._id_3B73) && isDefined(self._id_3B73._id_3B74) && self._id_3B73._id_3B74.size > 0) {
    var_1 = [];

    foreach(var_3 in var_0._id_3B74) {
      if(isalive(var_3)) {
        var_1[var_1.size] = var_3;
      }
    }

    var_0._id_3B74 = var_1;
  }
}

_id_3B8B(var_0) {
  if(_id_3B97(var_0)) {
    var_0.goalradius = 1300;
    var_1 = undefined;

    if(!var_0._id_3B82["right"] && !var_0._id_3B82["left"]) {
      if(common_scripts\utility::cointoss()) {
        _id_3B8C("left");
      } else {
        _id_3B8C("right");
      }
      return;
    }

    if(var_0._id_3B82["right"] && var_0._id_3B82["left"]) {
      _id_3B8E();
      return;
    }

    if(!var_0._id_3B82["right"] && var_0._id_3B82["left"]) {
      _id_3B8C("right");
      return;
    }

    if(var_0._id_3B82["right"] && !var_0._id_3B82["left"]) {
      _id_3B8C("left");
      return;
      return;
    }
  } else {
    _id_3B8E();
  }
}

_id_3B8C(var_0) {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 128;
  self.pathenemyfightdist = 192;
  self.pathenemylookahead = 192;
  self.favoriteenemy = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 720);
  self._id_3B73._id_3B82[var_0] = 1;
  self._id_3B8D = var_0;
  thread _id_3B92();

  for(;;) {
    var_1 = self._id_3B73 _id_3B93(var_0, 0);

    if(!isDefined(var_1)) {
      _id_3B8E();
      return;
    }

    var_2 = self._id_3B73.origin;
    wait 0.2;

    while(isDefined(self._id_3B73) && isalive(self._id_3B73) && distance(self._id_3B73.origin, var_2) < 2) {
      var_2 = self._id_3B73.origin;
      wait 0.2;
    }

    if(!isalive(self._id_3B73) || !isDefined(var_1)) {
      self setgoalpos(self.origin);
      continue;
    }

    self setgoalpos(var_1);
  }
}

_id_3B8E() {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 128;
  self.pathenemyfightdist = 192;
  self.pathenemylookahead = 192;
  self.favoriteenemy = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 720);
  thread _id_3B91();

  for(;;) {
    wait 0.2;

    if(!isalive(self._id_3B73)) {
      self setgoalpos(self.origin);
      continue;
    }

    self setgoalpos(self._id_3B73.origin);
  }
}

_id_3B8F(var_0, var_1) {
  level endon("squad_disband");
  self endon("death");
  self._id_3B82["left"] = 0;
  self._id_3B82["right"] = 0;
  self._id_3B90 = 1;
  self._id_3B7D = var_0;
  var_2 = common_scripts\utility::getstruct(self.target, "targetname");
  _id_3B94(var_1, var_2.origin);
  var_1 waittill("trigger");
  wait 5;
  self._id_3B90 = 0;
  self.goalradius = 512;
  var_3 = maps\_utility::_id_0AE9(self.origin, level.players);
  self.favoriteenemy = var_3;
  self setgoalentity(var_3);
}

_id_3B91() {
  common_scripts\utility::waittill_either("enemy_visible", "leader_saw_player");
  self.goalradius = 600;
  self._id_3B7F = 1;
}

_id_3B92() {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 8;
  self waittill("goal");
  var_0 = 10;
  var_1 = 5;
  var_2 = 120;

  for(;;) {
    maps\_utility::_id_26E3("on");

    if(isDefined(self._id_3B90) && self._id_3B90) {
      wait 1;
      continue;
    }

    wait 30;
    self.goalradius = 600;
    maps\_utility::_id_26E3("off");
    wait 20;
    self.goalradius = 8;
  }

  self.goalradius = 600;
  self._id_3B73._id_3B82[self._id_3B8D] = 0;
}

_id_3B93(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }
  var_2 = undefined;

  if(isDefined(var_1) && var_1) {
    if(isDefined(self.enemy) && isPlayer(self.enemy)) {
      var_2 = vectortoangles(self.enemy - self.origin);
    } else {
      return undefined;
    }
  } else {
    var_2 = self.angles;
  }
  if(var_0 == "left") {
    var_3 = (var_2[0], var_2[1] - 145, var_2[2]);
  } else {
    var_3 = (var_2[0], var_2[1] + 145, var_2[2]);
  }
  var_4 = vectornormalize(anglesToForward(var_3)) * 45;
  return self.origin + var_4;
}

_id_3B94(var_0, var_1) {
  level endon("squad_disband");
  var_0 endon("trigger");
  self endon("death");

  for(;;) {
    self.goalradius = 8;
    self setgoalpos(var_1);
    wait 0.05;
  }
}

_id_3B95() {
  self endon("trigger");
  var_0 = getent(self.target, "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::trigger_off();
}

_id_3B96(var_0) {
  return isDefined(var_0._id_3B73) && var_0._id_3B73.classname == "actor_enemy_afghan_riotshield";
}

_id_3B97(var_0) {
  if(var_0.classname == "actor_enemy_afghan_riotshield") {
    return 1;
  }
  return 0;
}

_id_3B98(var_0) {
  level endon("squad_disband");
  self endon("death");

  for(;;) {
    wait 1;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(isalive(var_3)) {
        var_1++;
      }
    }

    if(var_1 == 1 && level._id_3B70.size > 1) {
      level._id_3B70 = common_scripts\utility::array_remove(level._id_3B70, self);
      var_5 = level._id_3B70[0];

      if(level._id_3B70.size > 1) {
        var_5 = maps\_utility::_id_2605(self.origin, level._id_3B70);
      }
      thread _id_3B88(var_5);
      self notify("demotion");
      return;
    }
  }
}

_id_3B99() {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  var_0 = (1, 1, 1);

  for(;;) {
    foreach(var_2 in level._id_3B70) {
      if(isalive(var_2) && isDefined(var_2._id_3B74)) {
        foreach(var_4 in var_2._id_3B74) {
          if(isDefined(var_4) && isalive(var_4)) {}
        }
      }
    }

    wait 0.05;
  }
}

_id_3B9A(var_0, var_1) {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  for(var_2 = 0; var_2 < 40; var_2++) {
    wait 0.05;
  }
}

_id_3B9B() {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  for(;;) {
    var_0 = getaiarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_3B73)) {
        thread common_scripts\utility::draw_line_for_time(var_2.origin, var_2._id_3B73.origin, 0.5, 0.5, 1, 0.1);
      }
    }

    wait 0.1;
  }
}