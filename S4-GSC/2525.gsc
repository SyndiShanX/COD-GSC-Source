/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2525.gsc
*************************************************/

_id_100E0() {
  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

  level.vehicle._id_102F6 = [];
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "init")]]();
  _id_09E1::_id_100F6();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101B9();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C0();
  _id_09E2::_id_10147();
  scripts\cp_mp\vehicles\vehicle_damage::_id_1004D();
  scripts\cp_mp\vehicles\vehicle_spawn::_id_10277();
  _id_09E0::_id_1009C();
  _id_09DE::_id_10012();
  _id_09CA::_id_1037C();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "initVehicles")]]();
}

_id_8AF5() {
  return isDefined(self._id_1031E);
}

_id_8AF7() {
  return istrue(self._id_87FB);
}

_id_102EE() {
  var_0 = _id_100C1(self._id_1031E);

  if(isDefined(var_0)) {
    return istrue(var_0._id_3183);
  }

  return undefined;
}

_id_100C1(var_0, var_1) {
  var_2 = level.vehicle._id_102F6[var_0];

  if(!isDefined(var_2)) {
    if(istrue(var_1)) {
      var_2 = spawnStruct();
      level.vehicle._id_102F6[var_0] = var_2;
      var_2._id_FC21 = undefined;
      var_2._id_4841 = undefined;
      var_2._id_3183 = undefined;
    }
  }

  return var_2;
}

vehicle_create(var_0, var_1, var_2) {
  var_0.maxhealth = 2147483647;
  var_0.health = var_0.maxhealth;
  var_0._id_1031E = var_1;
  var_0 setnodeploy(1);
  var_0 makeunusable();

  if(isDefined(var_2.owner)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_101FA(var_0, var_2.owner);
  }

  if(isDefined(var_2.team)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_101FC(var_0, var_2.team);
  } else {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_101FC(var_0, "neutral");
  }

  var_0 _id_078D::_id_D3BA(::_id_100A4);
  var_0 _id_078D::_id_D189(::_id_100A3);
  scripts\cp_mp\utility\weapon_utility::_id_D5E7(var_0, ::_id_1013C);
  scripts\cp_mp\utility\weapon_utility::_id_D5E8(var_0, ::_id_1013D);
  scripts\cp_mp\utility\weapon_utility::_id_D5B5(var_0, ::_id_100DD);
  scripts\cp_mp\utility\weapon_utility::_id_D5B6(var_0, ::_id_100DE);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101F2(var_0);

  if(!scripts\common\utility::iscp() || !istrue(var_2._id_4AFA)) {
    _id_09E1::_id_10107(var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "create")]](var_0, var_2);
  }

  thread _id_102D1(var_0);
}

_id_10028(var_0, var_1) {
  var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(1);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(var_0, var_1.owner, var_1.team);
  _id_09E0::_id_1009D(var_0, var_1.spawntype);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "createLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "createLate")]](var_0, var_1);
  }
}

_id_1008F(var_0) {
  if(istrue(var_0._id_87FB)) {
    return;
  }
  var_0 notify("death");
  var_0._id_87FB = 1;

  if(isDefined(var_0._id_AAA9) && !istrue(var_0._id_A72E)) {
    var_0 thread[[var_0._id_AAA9]]();
  }

  var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(0);
  var_0 _meth_8359(1);
  scripts\cp_mp\utility\weapon_utility::_id_3954(var_0);
  var_0 _id_078D::_id_38CB(1);
  _id_09DE::_id_10011(var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10033(var_0);
  _id_09E1::_id_100EA(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102BB(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrame")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrame")]](var_0);
  }
}

_id_10090(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017A(var_0);
  scripts\cp_mp\vehicles\vehicle_spawn::_id_1026F(var_0._id_1031E, var_0 getentitynumber());

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrameLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrameLate")]](var_0);
  }

  var_1 = _id_100CD(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_3 delete();
    }
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(var_0);
}

_id_102D1(var_0) {
  level endon("game_ended");
  var_1 = _id_100C1(var_0._id_1031E);

  while(isDefined(var_0)) {
    var_2 = spawnStruct();
    _id_09CA::_id_10395(var_0);

    if(isDefined(var_1._id_FC21)) {
      var_0[[var_1._id_FC21]](var_2);
    }

    waitframe();
  }
}

_id_10240(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1.objweapon)) {
    var_1.objweapon = var_2;
  }

  if(!isDefined(var_0._id_F897)) {
    var_0._id_F897 = [];
  }

  var_4 = undefined;

  if(_func_0121(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = var_2.basename;
  }

  var_0._id_F897[var_4] = var_1;
  var_5 = var_0._id_357A;

  if(!isDefined(var_5)) {
    var_5 = [var_0];
  }

  if(!scripts\engine\utility::array_contains(var_5, var_1)) {
    var_5 = scripts\engine\utility::array_add(var_5, var_1);
  }

  var_0._id_357A = var_5;

  if(istrue(var_3)) {
    thread _id_102C6(var_0, var_1);
  }
}

_id_10092(var_0, var_1) {
  if(!isDefined(var_0._id_F897)) {
    return;
  }
  var_2 = undefined;

  if(_func_0121(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = var_1.basename;
  }

  var_3 = var_0._id_F897[var_2];
  var_0._id_F897[var_2] = undefined;

  if(isDefined(var_3)) {
    var_4 = var_0._id_357A;

    if(isDefined(var_4)) {
      var_4 = scripts\engine\utility::array_remove(var_4, var_3);
      var_0._id_357A = var_4;
    }

    var_3 notify("vehicle_trackTurretProjectile");
  }
}

_id_100CC(var_0, var_1) {
  if(!isDefined(var_0._id_F897)) {
    return undefined;
  }

  var_2 = undefined;

  if(_func_0121(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = var_1.basename;
  }

  return var_0._id_F897[var_2];
}

_id_100CD(var_0) {
  var_1 = [];

  if(isDefined(var_0._id_F897)) {
    var_1 = var_0._id_F897;
  }

  return var_1;
}

_id_102C6(var_0, var_1) {
  var_1 endon("death");
  var_1 notify("vehicle_trackTurretProjectile");
  var_1 endon("vehicle_trackTurretProjectile");

  for(;;) {
    var_1 waittill("missile_fire", var_2);

    if(isDefined(var_2)) {
      var_2.vehicle = var_0;
    }
  }
}

_id_10124(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BF(var_0, var_1);
  } else if(level.teambased) {
    var_2 = var_0.team;

    if(!isDefined(var_2) || var_2 == "neutral") {
      if(isDefined(var_0.owner)) {
        var_0.team = var_0.owner.team;
      }
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    return var_0.team == var_1.team;
  } else
    return isDefined(var_0.owner) && var_0.owner == var_1;
}

_id_10122(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BD(var_0, var_1);
  } else if(level.teambased) {
    var_2 = var_0.team;

    if(!isDefined(var_2) || var_2 == "neutral") {
      if(isDefined(var_0.owner)) {
        var_0.team = var_0.owner.team;
      }
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    return var_0.team == var_1.team;
  } else
    return isDefined(var_0.owner) && var_0.owner != var_1;
}

_id_10126(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C1(var_0, var_1);
  } else if(level.teambased) {
    return (!isDefined(var_0.team) || var_0.team == "neutral") && !isDefined(var_0.owner);
  } else {
    return !isDefined(var_0.owner);
  }
}

_id_10125(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C0(var_0, var_1);
  } else {
    if(level.teambased) {
      return isDefined(var_0.team) && var_0.team != var_1;
    }

    return undefined;
  }
}

_id_10123(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BE(var_0, var_1);
  } else {
    if(level.teambased) {
      return isDefined(var_0.team) && var_0.team == var_1;
    }

    return undefined;
  }
}

_id_10127(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C2(var_0, var_1);
  } else {
    if(level.teambased) {
      return !isDefined(var_0.team) || var_0.team == "neutral";
    }

    return undefined;
  }
}

_id_100CB(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AD(var_0);
  } else {
    if(isDefined(var_0.team) && var_0.team != "neutral") {
      return var_0.team;
    }

    return undefined;
  }
}

_id_1009E(var_0, var_1) {
  if(_id_1025A(var_0, var_1)) {
    var_2 = istrue(var_1.inlaststand);
    var_3 = var_1.health;

    if(isDefined(var_0.objweapon)) {
      level._id_AD57 = "MOD_EXPLOSIVE";
    }

    var_1 dodamage(1000, var_0.origin, var_0.owner, var_0, "MOD_CRUSH", var_0.objweapon);
    level._id_AD57 = undefined;

    if(!isalive(var_1)) {
      return 1;
    }

    if(!var_2 && istrue(var_1.inlaststand)) {
      return 1;
    }

    if(var_3 > var_1.health) {
      return 1;
    }
  }

  return 0;
}

_id_1025A(var_0, var_1) {
  if(level.teambased) {
    if(level._id_5FA5 == 0) {
      if(isDefined(var_0.owner)) {
        if(var_0.owner != var_1) {
          if(var_0.owner.team == var_1.team) {
            return 0;
          }
        }
      } else if(isDefined(var_0.team) && var_0.team != "neutral") {
        if(var_0.team == var_1.team) {
          return 0;
        }
      }
    }
  }

  return 1;
}

_id_1023B(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 notify("vehicle_preventCollisionDamageForTimeAfterExit");
  var_1 endon("vehicle_preventCollisionDamageForTimeAfterExit");
  var_1._id_102F2 = [];
  var_1._id_102F2["inflictor"] = var_0;
  var_1._id_102F2["objWeapon"] = var_0.objweapon;
  var_1._id_102F2["meansOfDeath"] = "MOD_CRUSH";
  _id_1023C(var_1);
  thread _id_1000A(var_1);
}

_id_1023C(var_0) {
  var_0 endon("death");
  wait 2;
}

_id_1000A(var_0) {
  var_0 notify("vehicle_preventCollisionDamageForTimeAfterExit");
  var_0._id_102F2 = undefined;
}

_id_1025D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1._id_102F2)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 != var_1._id_102F2["inflictor"]) {
    return 0;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  if(!scripts\common\utility::iscp()) {
    if(var_3 != var_1._id_102F2["objWeapon"]) {
      return 0;
    }
  }

  if(var_2 != var_1._id_102F2["meansOfDeath"]) {
    return 0;
  }

  return 1;
}

_id_10007(var_0) {
  if(!isDefined(var_0._id_9CD6) || var_0._id_9CD6 != "MOD_CRUSH") {
    return 0;
  }

  if(!isDefined(var_0.inflictor) || !var_0.inflictor _id_8AF5()) {
    return 0;
  }

  return 1;
}

_id_10235(var_0) {
  if(!_id_10007(var_0)) {
    return;
  }
  if(var_0.inflictor._id_1031E == "little_bird" || var_0.inflictor._id_1031E == "loot_chopper" || var_0.inflictor._id_1031E == "magma_plunder_chopper") {
    thread _id_10236(var_0._id_103C2);
  } else {
    playsoundatpos(var_0._id_103C2.origin, "kstreak_goliath_imp_default_med");
  }
}

_id_10236(var_0) {
  var_1 = 35;
  var_0._id_A546 = 1;
  playsoundatpos(var_0.origin, "kstreak_goliath_imp_default_med");
  var_2 = scripts\cp_mp\utility\player_utility::_id_69E4();

  if(var_2.size < var_1) {
    var_3 = spawn("script_model", var_0 gettagorigin("j_mainroot"));
    var_3.angles = var_0.angles;
    var_3 setModel("player_death_fx");
    var_3 setscriptablepartstate("effects", "gib", 0);

    foreach(var_5 in var_2) {
      var_3 hidefromplayer(var_5);
    }

    wait 0.5;
    var_3 delete();
  }
}

_id_102E2(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  level endon("game_ended");

  if(isDefined(var_3)) {
    var_0 endon(var_3);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      var_7 = 1;
      var_5 = undefined;
    } else if(var_8 <= 0.5736) {
      if(!isDefined(var_5)) {
        var_5 = gettime() + 3000;
      }

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }

      if(scripts\engine\utility::is_equal(var_0._id_1031E, "motorcycle") && !isDefined(scripts\cp_mp\vehicles\vehicle_occupancy::_id_10193(var_0))) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        _id_09E1::_id_100E5(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1)) {
        thread[[var_1]](var_0);
      }

      if(!var_4 && !scripts\engine\utility::is_equal(var_0._id_1031E, "motorcycle")) {
        _id_09E1::_id_100E5(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017D(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(vectordot(anglestoup(var_0.angles), (0, 0, 1)) > 0.0872) {
          break;
        }

        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2)) {
        thread[[var_2]](var_0, var_9);
      }
    }

    waitframe();
  }
}

_id_100AA(var_0, var_1) {
  if(var_1) {
    var_2 = _id_100C1(var_0._id_1031E);

    if(isDefined(var_2._id_4841)) {
      var_0[[var_2._id_4841]]();
    }
  }
}

_id_1008E() {
  level notify("vehicle_deleteCollmapVehicles");
  level endon("vehicle_deleteCollmapVehicles");
  wait 1;
  var_0 = getEntArray("delete_me", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    for(var_1 = var_0.size - 1; var_1 >= 0; var_1--) {
      var_0[var_1] delete();
    }
  }
}

_id_1013C() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);
  _id_09CA::_id_10390("missileLocking", var_0, self._id_1031E);
}

_id_1013D() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);
  _id_09CA::_id_1037B("missileLocking", var_0, self._id_1031E);
}

_id_100DD() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);
  _id_09CA::_id_10390("missileIncoming", var_0, self._id_1031E);
}

_id_100DE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);
  _id_09CA::_id_1037B("missileIncoming", var_0, self._id_1031E);
}

_id_100A4(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onVehicleEMPed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onVehicleEMPed")]](var_0);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015B(self, 0);
}

_id_100A3(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015B(self, 1);
}