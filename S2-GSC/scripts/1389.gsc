/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1389.gsc
**************************************/

init() {
  while(!isDefined(level._id_947C))
    waittillframeend;

  if(!isDefined(level._id_AC4F))
    level._id_AC4F = [];

  level._id_AC11 = 0;
  level._id_4699 = [];
  level._id_1F4F = [];
  level._id_7F22 = [];
  level._id_7F18 = [];
  level._id_6889 = [];
  level._id_65C9 = [];
  level._id_64B7 = [];
  level._id_64C3 = [];
  level._id_672E = [];
  level._id_9D0E = [];
  _id_52B5();
  level._id_ABEC = maps\mp\_utility::_id_5DC8();
  level._id_ABED = maps\mp\_utility::_id_5DC8();
  level._id_AC12 = maps\mp\_utility::_id_5DC8();
  run_post_launch_optional_spawner_params_override();
}

run_post_launch_optional_spawner_params_override() {
  var_0 = common_scripts\utility::_id_46B7("zmb_addon_script_parameters_override", "targetname");
  var_1 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = common_scripts\utility::_id_4461(var_4.origin, var_1);
    var_5.setlookatent = var_4.setlookatent;
    var_6 = strtok(var_5.setlookatent, " ,");

    foreach(var_8 in var_6) {
      if(var_8 == "requireNavmesh_no")
        var_5.requirenavmesh = 0;
    }
  }
}

_id_52B5() {
  var_0 = "mp/zombieEnemyWaves.csv";

  if(isDefined(level._id_2986))
    var_0 = level._id_2986;

  var_1 = _tablegetrowcount(var_0);
  var_2 = _tablegetcolumncount(var_0);
  var_3 = var_2 - 2;
  level._id_3774 = [];

  for(var_4 = 1; var_4 <= 4; var_4++) {
    level._id_3774[var_4] = [];

    for(var_5 = 1; var_5 <= var_3; var_5++)
      level._id_3774[var_4][var_5] = [];
  }

  for(var_5 = 1; var_5 <= var_3; var_5++) {
    for(var_6 = 0; var_6 < var_1; var_6++) {
      var_7 = _tablelookupbyrow(var_0, var_6, 1);

      if(isDefined(level.wavetabletypestoexclude)) {
        if(_isarray(level.wavetabletypestoexclude) && common_scripts\utility::_id_0F79(level.wavetabletypestoexclude, var_7))
          continue;
      }

      var_4 = _id_0547::_id_9470(_tablelookupbyrow(var_0, var_6, 0));
      var_8 = _id_0547::_id_9470(_tablelookupbyrow(var_0, var_6, var_5 + 1));

      if(var_8 > 0) {
        if(isDefined(level._id_3774[var_4][var_5][var_7])) {
          level._id_3774[var_4][var_5][var_7] = level._id_3774[var_4][var_5][var_7] + var_8;
          continue;
        }

        level._id_3774[var_4][var_5][var_7] = var_8;
      }
    }
  }

  level._id_3775 = var_3;
}

_id_4743(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = level._id_A980;

  if(!isDefined(var_1))
    var_1 = level.players.size;

  return level._id_3774[var_1][int(_min(var_0, level._id_3775))];
}

_id_468C() {
  return 2;
}

_id_1E51(var_0) {
  if(isDefined(level._id_6893) && isDefined(level._id_6893[level._id_7F2A]))
    return [[level._id_6893[level._id_7F2A]]](var_0);

  return var_0;
}

_id_A78F() {
  var_0 = 0;

  while(var_0 == 0) {
    var_0 = 1;

    if(_id_0547::_id_585E()) {
      var_0 = 0;
      waitframe();
    }

    while(_id_5867()) {
      var_0 = 0;
      wait 0.1;
    }

    while(maps\mp\agents\_agent_utility::_id_45BB() >= _id_4577()) {
      var_0 = 0;
      wait 0.1;
    }

    while(isDefined(level._id_ABE3) && level._id_ABE3 > 0) {
      var_0 = 0;
      wait 0.1;
    }
  }
}

_id_8A6E(var_0) {
  level._id_ABE2 = var_0;
}

_id_5867() {
  return common_scripts\utility::_id_562E(level._id_ABE2);
}

_id_76A8(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in _id_4743(var_0)) {
    for(var_4 = 0; var_4 < var_3; var_4++)
      var_1[var_1.size] = var_5;
  }

  var_1 = common_scripts\utility::array_randomize(var_1);
  return var_1;
}

_id_5A86() {
  if(isDefined(self.customrecyclehandling)) {
    [[self.customrecyclehandling]]();
    return;
  }

  var_0 = spawnStruct();
  var_0._id_AC0B = self._id_0A4B;
  var_0._id_A97C = self._id_901F;
  var_0._id_3EEC = 1;
  var_0._id_6A37 = self.health;

  if(self._id_0A4B == "zombie_generic") {
    if(isDefined(self._id_3C70))
      var_0._id_3C70 = self._id_3C70;
    else
      var_0._id_3C70 = self._id_90AB;

    var_0._id_6A3D = self._id_0108;
    var_0._id_6A3C = self._id_6481;
    var_0._id_6A3F = self._id_A978;

    if(isDefined(self._id_1CF1))
      var_0._id_6A2C = self._id_1CF1;
  }

  if(maps\mp\_utility::_id_585F()) {
    if(common_scripts\utility::_id_3794("zombie_passive"))
      level._id_ABED maps\mp\_utility::_id_5DC6(var_0);
    else
      level._id_ABEC maps\mp\_utility::_id_5DC6(var_0);
  }

  self._id_6734 = 1;
  self._id_AC10 = 1;
  self suicide();
}

_id_7D06(var_0) {}

_id_7B87(var_0) {
  if(level._id_AC12 maps\mp\_utility::_id_5DCB() == 0) {
    level._id_A981++;
    var_1 = level._id_A981;

    if(isDefined(var_0)) {
      var_1 = var_0;
      level._id_A981 = var_0;
    }

    var_2 = _id_76A8(var_1);

    foreach(var_4 in var_2) {
      var_5 = spawnStruct();
      var_5._id_AC0B = var_4;
      var_5._id_A97C = var_1;
      level._id_AC12 maps\mp\_utility::_id_5DC6(var_5);
    }
  }
}

_id_66D7() {
  if(level._id_ABEC maps\mp\_utility::_id_5DCB() > 0)
    return level._id_ABEC maps\mp\_utility::_id_5DC9()._id_A97C;

  if(level._id_ABED maps\mp\_utility::_id_5DCB() > 0)
    return level._id_ABED maps\mp\_utility::_id_5DC9()._id_A97C;

  _id_7B87();

  if(level._id_AC12 maps\mp\_utility::_id_5DCB() > 0)
    return level._id_AC12 maps\mp\_utility::_id_5DC9()._id_A97C;
}

_id_220F() {
  if(level._id_ABEC maps\mp\_utility::_id_5DCB() > 0)
    return level._id_ABEC maps\mp\_utility::_id_5DCA();

  if(level._id_ABED maps\mp\_utility::_id_5DCB() > 0)
    return level._id_ABED maps\mp\_utility::_id_5DCA();

  _id_7B87();

  if(level._id_AC12 maps\mp\_utility::_id_5DCB() > 0)
    return level._id_AC12 maps\mp\_utility::_id_5DCA();
}

_id_7FE1() {
  level._id_AC50 = 99999;
  waitframe();

  if(!isDefined(level._id_A981))
    level._id_A981 = 0;

  for(;;) {
    _id_A78F();
    var_0 = 1;

    if(var_0) {
      if(common_scripts\utility::_id_562E(level.iszombiesshotgun) && common_scripts\utility::_id_562E(level.zmb_is_endless_wave)) {
        if(_id_66D7() > level._id_A980) {
          level._id_AC12 maps\mp\_utility::_id_5DC7();
          _id_7B87(level._id_A980);
        }
      } else {
        while(_id_66D7() > level._id_A980)
          wait 0.2;

        _id_A78F();
      }
    }

    var_1 = _id_220F();

    if(!isDefined(var_1)) {
      wait 1;
      continue;
    }

    var_2 = 0;
    var_3 = var_1._id_AC0B;
    var_4 = undefined;

    if(isDefined(var_1._id_3EEC)) {
      var_4 = spawnStruct();
      var_4._id_6A37 = var_1._id_6A37;

      if(var_3 == "zombie_generic") {
        var_4._id_3C70 = var_1._id_3C70;
        var_4._id_6A3C = var_1._id_6A3C;
        var_4._id_6A3D = var_1._id_6A3D;
        var_4._id_6A3F = var_1._id_6A3F;

        if(isDefined(var_1._id_6A2C))
          var_4._id_6A2C = var_1._id_6A2C;
      }
    }

    if(isDefined(level._id_1CC0))
      var_3 = common_scripts\utility::random(level._id_1CC0);

    if(should_override_follower_spawn(isDefined(var_1._id_3EEC), var_3)) {
      if(maps\mp\_utility::_id_4571() == "mp_zombie_house")
        var_3 = "zombie_generic";
      else
        var_3 = common_scripts\utility::random(["zombie_exploder", "zombie_berserker", "zombie_berserker"]);
    }

    if(_id_0547::_id_0796()) {
      var_6 = 0;
      var_7 = 0;

      foreach(var_9 in level.players) {
        if(isalive(var_9) && !common_scripts\utility::_id_562E(var_9._id_5728))
          var_6++;

        if(common_scripts\utility::_id_562E(var_9._id_5579))
          var_7++;
      }

      if(var_7 == var_6 && _id_0547::_id_4254() >= 5)
        var_11 = undefined;
      else {
        var_12 = _id_0547::_id_7A37();
        var_11 = _id_055A::_id_4696(var_3, 0, 0, var_12._id_38C2);
      }
    } else if(isDefined(level.zmb_locked_spawn_zones))
      var_11 = _id_055A::_id_4696(var_3, 0, 0, common_scripts\utility::random(level.zmb_locked_spawn_zones));
    else
      var_11 = undefined;

    for(;;) {
      var_13 = _id_054D::_id_90BA(var_3, var_11, "wave system", 1, 0, 1, undefined, var_2, var_1._id_A97C, var_4);

      if(!isDefined(level.zm_shotgun_health_mod))
        level.zm_shotgun_health_mod = getdvarfloat("spv_zm_shotgun_health_mod", 1.0);

      if(isDefined(var_13) && getdvarint("spv_zm_difficulty_enabled") == 1) {
        var_14 = int(var_13.maxhealth * level.zm_shotgun_health_mod);
        var_13.maxhealth = var_14;
        var_13.health = var_13.maxhealth;
      }

      if(isDefined(var_13)) {
        break;
      } else if(isDefined(level.zmb_locked_spawn_zones))
        var_11 = _id_055A::_id_4696(var_3, 0, 0, common_scripts\utility::random(level.zmb_locked_spawn_zones));

      waitframe();
    }

    wait(_id_1E56());
  }
}

should_override_follower_spawn(var_0, var_1) {
  if(level.players.size == 1)
    var_2 = 2;
  else if(level.players.size == 2)
    var_2 = 3;
  else
    var_2 = 4;

  if(var_0)
    return 0;

  if(_id_0547::_id_4090("zombie_heavy").size < var_2)
    return 0;

  if(!_id_0547::_id_5565(var_1, "zombie_heavy"))
    return 0;

  return 1;
}

_id_4577() {
  var_0 = 24;
  var_1 = 18;
  return var_1;
}

_id_A6DC(var_0) {
  while(!_id_584C(var_0))
    wait 0.5;
}

_id_584C(var_0) {
  if(_id_0547::_id_585E())
    return 0;

  if(isDefined(level.zmb_force_ended_wave)) {
    if(level.zmb_force_ended_wave != var_0) {
      level.zmb_force_ended_wave = undefined;
      return 0;
    } else {
      level.zmb_force_ended_wave = undefined;
      return 1;
    }
  }

  if(common_scripts\utility::_id_562E(level.zmb_is_endless_wave))
    return 0;

  if(level._id_6F43 > 0)
    return 0;

  if(!isDefined(level._id_A981) || level._id_A981 <= var_0)
    return 0;

  foreach(var_2 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
    if(common_scripts\utility::_id_562E(var_2._id_6816)) {
      continue;
    }
    if(var_2._id_901F <= var_0)
      return 0;
  }

  foreach(var_5 in level._id_ABEC maps\mp\_utility::_id_5DCC()) {
    if(var_5._id_A97C <= var_0)
      return 0;
  }

  foreach(var_5 in level._id_ABED maps\mp\_utility::_id_5DCC()) {
    if(var_5._id_A97C <= var_0)
      return 0;
  }

  level.zmb_force_ended_wave = undefined;
  return 1;
}

_id_45C2() {
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3.team == level._id_3772)
      var_1++;
  }

  return var_1;
}

_id_1E56() {
  if(isDefined(level.overridespawndelay))
    return level.overridespawndelay;

  if(isDefined(level.zombieslevelspawndelayfunc))
    return [[level.zombieslevelspawndelayfunc]](level._id_A980);
  else
    return _id_957F(level._id_A980);
}

_id_957C(var_0) {
  if(var_0 <= 11)
    return 0;

  if(var_0 > 30)
    return 0.05;
  else if(var_0 > 25)
    return 0.04;
  else if(var_0 > 15)
    return 0.03;
  else
    return 0.02;

  return 0;
}

_id_957B(var_0, var_1) {
  var_2 = var_0;

  if(var_1 < 2)
    var_2 = int(var_0 * 0.25);
  else if(var_1 < 3)
    var_2 = int(var_0 * 0.3);
  else if(var_1 < 4)
    var_2 = int(var_0 * 0.5);
  else if(var_1 < 5)
    var_2 = int(var_0 * 0.7);
  else if(var_1 < 6)
    var_2 = int(var_0 * 0.9);

  return var_2;
}

_id_957D(var_0, var_1) {
  var_2 = 24;
  var_3 = 6;
  var_4 = var_0 / 5;

  if(var_4 < 1)
    var_4 = 1;

  if(var_0 >= 10)
    var_4 = var_4 * (var_0 * 0.15);

  if(var_1 == 1)
    var_2 = var_2 + int(0.5 * var_3 * var_4);
  else
    var_2 = var_2 + int((var_1 - 1) * var_3 * var_4);

  var_5 = _id_957B(var_2, var_0);
  return var_5;
}

_id_957F(var_0) {
  if(var_0 < 2)
    return 3.0;

  if(var_0 < 5)
    return 2.0;

  if(var_0 > 60)
    var_0 = 60;

  var_1 = 0.95;
  var_2 = 0;

  switch (level.players.size) {
    case 1:
      var_2 = 2.0;
      break;
    case 2:
      var_2 = 1.5;
      break;
    case 3:
      var_2 = 0.89;
      break;
    case 4:
      var_2 = 0.67;
      break;
  }

  for(var_3 = 1; var_3 < var_0; var_3++) {
    var_2 = var_2 * var_1;

    if(var_2 <= 0.1) {
      var_2 = 0.1;
      break;
    }
  }

  return var_2;
}