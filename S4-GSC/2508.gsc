/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2508.gsc
*************************************************/

_id_1988() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("apc_russian", 1);
  var_0._id_FC21 = ::_id_199E;
  var_0._id_4841 = ::_id_1986;
  _id_198D();
  _id_198B();
  _id_198E();
  _id_1989();
  _id_198A();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "init")]]();
  }

  _id_198F();
  _id_198C();
}

_id_198C() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "initLate")]]();
  }
}

_id_198D() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("apc_russian", 1);
  var_0._id_54D6 = ::_id_1981;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_1984;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A7();
  var_0._id_577C["front"] = 136;
  var_0._id_577C["back"] = 129;
  var_0._id_577C["left"] = 68;
  var_0._id_577C["right"] = 68;
  var_0._id_577C["top"] = 87;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (100, 0, 65);
  var_0._id_5778[var_1] = "right";
  var_1 = "middle_left";
  var_0._id_5788[var_1] = (-31, 14, 65);
  var_0._id_5778[var_1] = "left";
  var_1 = "middle_right";
  var_0._id_5788[var_1] = (-31, -20, 65);
  var_0._id_5778[var_1] = "right";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-90, 35, 65);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-90, -35, 65);
  var_0._id_5778[var_1] = "back";
  var_0._id_430F = 0;
  var_0._id_790C = 1;
  var_0._id_2FF8 = "cam_vindia_passenger";
  var_0._id_4300 = "all";
  var_0._id_42FF = "all";
  var_2 = ["driver", "front_right", "back_right", "back", "back_left", "front_left"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "middle_left", "back_left", "middle_right", "front"];
  var_0._id_5788[var_3] = (80, 14, 65);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_C725 = scripts\engine\utility::array_remove(var_4._id_C725, "fire");
  var_4._id_103D2["top"] = 30;
  var_4._id_103D2["bottom"] = 10;
  var_4._id_103D2["left"] = 180;
  var_4._id_103D2["right"] = 180;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_F88B = makeweapon("tur_apc_rus_mp");
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "front_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["driver", "middle_left", "back_left", "middle_right", "front"];
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "front_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["middle_right", "back_right", "middle_left", "front"];
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["middle_left", "back_left", "middle_right", "front"];
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["middle_right", "back_right", "middle_left", "front"];
  var_4._id_18F2 = "tag_seat_4";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("apc_russian", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["back_left", "back_right", "middle_left", "middle_right", "front"];
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_198B() {
  var_0 = _id_09E1::_id_100EF("apc_russian", 1);
  var_0._id_CFC0["single"] = ["driver", "front_right", "back_right", "back", "back_left", "front_left"];
}

_id_198E() {
  var_0 = _id_09CA::_id_10373("apc_russian", 1);
  var_0._id_7C8C = 15;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["front_left"] = 1;
  var_0._id_CFC3["front_right"] = 2;
  var_0._id_CFC3["back_right"] = 4;
  var_0._id_CFC3["back_left"] = 3;
  var_0._id_CFC3["back"] = 5;
  var_0._id_171A["driverTurret"] = 0;
  var_0._id_C930["chassis"] = 0;
  var_0._id_C930["turret"] = 1;
  var_0._id_C931["driver"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["driver"]["tur_apc_rus_mp"] = "turret";
  var_0._id_C931["front_left"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["front_left"]["tur_apc_rus_mp"] = "turret";
  var_0._id_C931["front_right"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["front_right"]["tur_apc_rus_mp"] = "turret";
  var_0._id_C931["back_right"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["back_right"]["tur_apc_rus_mp"] = "turret";
  var_0._id_C931["back_left"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["back_left"]["tur_apc_rus_mp"] = "turret";
  var_0._id_C931["back"]["apc_rus_mp"] = "chassis";
  var_0._id_C931["back"]["tur_apc_rus_mp"] = "turret";
}

_id_1989() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("apc_russian", 2000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("apc_russian");
  var_0.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("apc_russian");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("apc_russian", 18);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10071("apc_russian", ::_id_199D);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10070("apc_russian", ::_id_199C);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("apc_russian", ::_id_197E);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("tur_apc_rus_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("apc_rus_mp", 5);
}

_id_198A() {
  level._effect["apc_rus_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_exp.vfx");
  level._effect["apc_rus_explode_alt"] = loadfx("vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_west_exp.vfx");
}

_id_197B(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(istrue(var_0._id_FE22)) {
    var_0.modelname = "veh8_mil_lnd_vindia_a1_west_physics_mp";
  } else {
    var_0.modelname = "veh8_mil_lnd_vindia_a1_physics_mp";
  }

  var_0._id_0481 = "apc_russian";
  var_0._id_04DE = "vindia_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = _id_197C(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::_id_10240(var_2, var_3, makeweapon("tur_apc_rus_mp"), 1);
  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "apc_russian", var_0);
  var_2.objweapon = makeweapon("apc_rus_mp");
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003E(var_2, 1);
  var_4._id_4861 = "none";
  var_4._id_483F = "kill_apc_rus";
  var_4._id_4840 = 1;
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);
  var_2 thread _id_1991();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "create")]](var_2);
  }

  return var_2;
}

_id_197C(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_apc_rus_mp", 0);
  var_2.angles = var_0 gettagangles("tag_turret");
  var_2 linkto(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1._id_FE22)) {
    var_2 setModel("veh8_mil_lnd_vindia_a1_turret_west_mp");
  } else {
    var_2 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  }

  var_2 setmode("sentry_offline");
  var_2 setsentryowner(undefined);
  var_2 makeunusable();
  var_2 setdefaultdroppitch(0);
  var_2 _meth_839D(1);
  var_2.vehicle = var_0;
  return var_2;
}

_id_1986(var_0, var_1) {
  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "processScrapAssist")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "processScrapAssist")]](var_0.attacker);
    }
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "apc_rus_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_197F();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "apc_rus_mp");
    var_4 = scripts\engine\utility::ter_op(istrue(self._id_E293._id_FE22), "apc_rus_explode_alt", "apc_rus_explode");
    playFX(scripts\engine\utility::getfx(var_4), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_bradley_expl_destr");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_197F() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_199D(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::_id_10054(self, var_0)) {
    return 0;
  }

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectornormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = getdvarfloat("#x3d51985d011d9401b", -0.892);

  if(vectordot(var_5, var_6) < var_8) {
    var_0._id_89EE = _id_197D(var_0);
  }

  return 1;
}

_id_199C(var_0) {
  if(istrue(var_0._id_89EE)) {
    var_0.damage = int(var_0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var_0.attacker, var_0.damage);
  }

  return 1;
}

_id_197E(var_0) {
  thread _id_1986(var_0);
  return 1;
}

_id_197D(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "gl") {
    return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
  }

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "lighttank_tur_mp":
      case "lighttank_tur_ks_mp":
        return isDefined(var_0._id_9CD6) && (var_0._id_9CD6 == "MOD_PROJECTILE" || var_0._id_9CD6 == "MOD_RIFLE_BULLET");
      case "iw8_la_rpapa7_mp":
      case "tur_apc_rus_mp":
      case "iw8_la_gromeo_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_gromeoks_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_PROJECTILE";
      case "iw8_la_kgolf_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
    }
  }

  return 0;
}

_id_1981(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_1982(var_0, var_1, var_2, var_3, var_4);
  }

  if(istrue(var_0._id_89D9)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectivePlayerMaskAddShowPlayer")) {
      foreach(var_6 in level.players) {
        if(istrue(var_0._id_C7B0) || var_6.team == var_0.team) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskAddShowPlayer")]](var_0._id_9B4D._id_A908, var_6);
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectivePlayerMaskHideFrom")) {
      foreach(var_9 in var_0._id_A924)[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskHideFrom")]](var_0._id_9B4D._id_A908, var_9);

      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskHideFrom")]](var_0._id_9B4D._id_A908, var_3);
    }
  }
}

_id_1982(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 cameradefault();
    var_3 _meth_8094(var_0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017C(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_apc_rus_mp");

    if(isDefined(var_5)) {
      var_5.owner = var_3;
      var_5 setotherent(var_3);
      var_5 setentityowner(var_3);
      var_5 setsentryowner(var_3);
      var_3 _meth_828F(var_5);
    }
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
  _id_19A1(var_0, var_2, var_1, var_3);

  if(var_1 == "driver") {
    var_0 thread _id_1992(var_3);
  }
}

_id_1984(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_1985(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_1985(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_apc_rus_mp");

    if(isDefined(var_5)) {
      var_5.owner = undefined;
    }

    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      if(isDefined(var_5)) {
        var_5 _meth_8399(var_3.origin);
        var_3 _meth_8290(var_5);
      }

      var_3 _meth_8095();
    }

    if(isDefined(var_5)) {
      var_5 setotherent(undefined);
      var_5 setentityowner(undefined);
      var_5 setsentryowner(undefined);
    }
  }

  if(!istrue(var_4._id_B695)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D2(var_3, var_2, var_4);

    if(!var_6) {
      var_3 suicide();
    } else if(istrue(var_0._id_89D9) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectivePlayerMaskAddShowPlayer")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskAddShowPlayer")]](var_0._id_9B4D._id_A908, var_3);
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
}

_id_198F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("apc_russian", 1);
  var_0._id_9C7B = 30;
  var_0._id_BD27 = 50;
  var_0._id_6D5D = ::_id_1987;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "spawnCallback");
  var_0._id_3923 = 150;
  var_0._id_391F = 135;
  var_0._id_3921 = 150;
}

_id_1987() {
  var_0 = scripts\engine\utility::getstructarray("apcrussian_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

_id_199E(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1020B("driver");
}

_id_1991() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_apc_rus_mp");
  var_0 endon("death");
  var_0._id_DA6A = 14;
  _id_19A0();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_10897("turret_fire", "turret_reload");

    if(var_1 == "turret_reload") {
      var_0._id_DA6A = 0;
      _id_19A0();
      _id_1980();
      continue;
    }

    _id_1970(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

    if(var_0._id_DA6A <= 0) {
      _id_1980();
    }
  }
}

_id_1980() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_apc_rus_mp");
  var_0 _meth_8410();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

  if(isDefined(var_1)) {
    var_1 playlocalsound("weap_bradley_reload_plr");
  }

  foreach(var_3 in level._id_EF89) {
    self playsoundtoteam("weap_bradley_reload_npc", var_3, var_1);
  }

  wait 2.7;
  _id_1970(14);
  wait 0.15;
  var_0 _meth_8411();
}

_id_1992(var_0) {
  self endon("death");
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_apc_rus_mp");

  if(isDefined(var_0)) {
    var_0 endon("vehicle_change_seat");
    var_0 endon("vehicle_seat_exit");
    var_0 endon("death_or_disconnect");

    while(var_0 reloadbuttonpressed()) {
      waitframe();
    }

    var_2 = getdvarint("#x374b6dca2a5ac069b", 250) / 1000;

    for(;;) {
      var_3 = 0.0;
      var_4 = var_0 _meth_874B();

      while(var_0 reloadbuttonpressed()) {
        if(!var_0 usinggamepad() && var_1._id_DA6A < 14) {
          var_1 notify("turret_reload");
          break;
        } else {
          if(var_1._id_DA6A < 14 && var_4 > 0 && var_3 >= var_2) {
            var_1 notify("turret_reload");
          }

          var_3 = var_3 + level._id_5F3A;
          waitframe();
        }
      }

      if(var_0 usinggamepad() && var_1._id_DA6A < 14 && (var_4 == 0 && var_3 > 0.0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2)) {
        var_1 notify("turret_reload");
      }

      waitframe();
    }
  }
}

_id_1970(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_apc_rus_mp");
  var_1._id_DA6A = var_1._id_DA6A + var_0;
  var_1._id_DA6A = int(clamp(var_1._id_DA6A, 0, 14));
  _id_19A0();
}

_id_19A1(var_0, var_1, var_2, var_3) {
  if(var_2 == "driver") {
    var_0 _id_19A0();
  }
}

_id_19A0() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_apc_rus_mp");
    _id_09CA::_id_10382("apc_russian", "driverTurret", var_1._id_DA6A, var_0);
  }
}