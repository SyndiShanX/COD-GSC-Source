/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2519.gsc
*************************************************/

_id_9571() {
  level._id_9108 = getdvarfloat("#x3be736f5bd213f9f7", 1.0);
  level._id_910C = getdvarfloat("#x3b1d2e0a6ce6d4b89", 1.0);
  level._id_910A = getdvarfloat("#x36866bce40296fd33", 1.2);
  level._id_910B = getdvarfloat("#x3f4b1da805a3de290", 1.0);
  level._id_9109 = getdvarfloat("#x32a78f70adfed1c72", 0.5);
  level._id_9107 = getdvarfloat("#x3a07e1b2ccea17839", 3.0);
  level._id_9113 = getdvarfloat("#x3ff46485c6c982977", 0.9);
  level._id_9112 = getdvarfloat("#x32c68973c7ef2bcf", 0.9);
  level._id_9111 = getdvarfloat("#x3101db373d148c7bb", 0.1);
  level._id_910E = getdvarfloat("#x3a1160155aa30830d", 0.1);
  level._id_9110 = getdvarfloat("#x34c4567d986080778", 0.2);
  level._id_910F = getdvarfloat("#x3d9cf950176ad473a", 0.75);
  level._id_911B = getdvarfloat("#x35fbe8ef546bc7dab", 55.0);
  level._id_911A = getdvarfloat("#x3da85307929e25ddb", 10.0);
  level._id_911F = getdvarfloat("#x311926899d6765690", 0.6);
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("little_bird", 1);
  var_0._id_4841 = ::_id_956D;
  var_0._id_3183 = 1;
  _id_9576();
  _id_9574();
  _id_9577();
  _id_9572();
  _id_9573();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "init")]]();
  }

  _id_9578();
  _id_9575();
}

_id_9575() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "initLate")]]();
  }
}

_id_9576() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("little_bird", 1);
  var_0._id_54E3 = ::_id_956A;
  var_0._id_54D6 = ::_id_9568;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_956B;
  var_0._id_C187 = ::_id_9585;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 95;
  var_0._id_577C["back"] = 195;
  var_0._id_577C["left"] = 55;
  var_0._id_577C["right"] = 55;
  var_0._id_577C["top"] = -5;
  var_0._id_577C["bottom"] = 117;
  var_0._id_1597 = 1;
  var_1 = "front";
  var_0._id_5788[var_1] = (85, 0, -40);
  var_0._id_5778[var_1] = "front";
  var_1 = "front_right";
  var_0._id_5788[var_1] = (40, -17, -40);
  var_0._id_5778[var_1] = "right";
  var_1 = "middle_left";
  var_0._id_5788[var_1] = (0, 17, -45);
  var_0._id_5778[var_1] = "left";
  var_1 = "middle_right";
  var_0._id_5788[var_1] = (0, -17, -45);
  var_0._id_5778[var_1] = "right";
  var_1 = "back";
  var_0._id_5788[var_1] = (-85, 0, -65);
  var_0._id_5778[var_1] = "back";
  var_2 = [];

  if(0) {
    var_2 = ["pilot", "gunner", "bl_platform", "fl_platform"];
  } else {
    var_2 = ["pilot", "fr_platform", "br_platform", "bl_platform", "fl_platform"];
  }

  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "middle_left", "front_right", "front", "back"];
  var_0._id_5788[var_3] = (40, 17, -40);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_pilot";
  var_3 = "fl_platform";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["middle_left", "pilot", "middle_right", "front", "back"];
  var_4._id_103D2["top"] = 180;
  var_4._id_103D2["bottom"] = 180;
  var_4._id_103D2["left"] = 110;
  var_4._id_103D2["right"] = 125;
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "bl_platform";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["middle_left", "pilot", "middle_right", "front", "back"];
  var_4._id_103D2["top"] = 180;
  var_4._id_103D2["bottom"] = 180;
  var_4._id_103D2["left"] = 120;
  var_4._id_103D2["right"] = 105;
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "fr_platform";

  if(!0) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
    var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
    var_4._id_5780 = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4._id_103D2["top"] = 180;
    var_4._id_103D2["bottom"] = 180;
    var_4._id_103D2["left"] = 125;
    var_4._id_103D2["right"] = 110;
    var_4._id_18F2 = "tag_seat_4";
    var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
    var_4._id_AAC6 = "ping_vehicle_rider";
  }

  var_3 = "br_platform";

  if(!0) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
    var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
    var_4._id_5780 = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4._id_103D2["top"] = 180;
    var_4._id_103D2["bottom"] = 180;
    var_4._id_103D2["left"] = 105;
    var_4._id_103D2["right"] = 120;
    var_4._id_18F2 = "tag_seat_5";
    var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
    var_4._id_AAC6 = "ping_vehicle_rider";
  }

  var_3 = "gunner";

  if(0) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("little_bird", var_3, 1);
    var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
    var_4._id_5780 = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4._id_AAC6 = "ping_vehicle_gunner";
  }
}

_id_9574() {
  var_0 = _id_09E1::_id_100EF("little_bird", 1);
  var_0._id_CFC0["single"] = ["pilot", "fl_platform", "fr_platform", "bl_platform", "br_platform"];
}

_id_9577() {
  var_0 = _id_09CA::_id_10373("little_bird", 1);
  var_0._id_171A["flares"] = 1;
  var_0._id_7C8C = 2;

  if(!0) {
    var_0._id_CFC3["pilot"] = 0;
    var_0._id_CFC3["fl_platform"] = 1;
    var_0._id_CFC3["bl_platform"] = 3;
    var_0._id_CFC3["fr_platform"] = 2;
    var_0._id_CFC3["br_platform"] = 4;
  } else {
    var_0._id_CFC3["pilot"] = 0;
    var_0._id_CFC3["fl_platform"] = 1;
    var_0._id_CFC3["bl_platform"] = 3;
    var_0._id_CFC3["gunner"] = 5;
  }
}

_id_9572() {
  if(level.gametype == "br") {
    var_0 = 3000;
  } else {
    var_0 = 2500;
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("little_bird", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("little_bird");
  var_1.class = "medium_heavy";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::_id_10040("little_bird", "heavy");
  var_2._id_AAC7 = ::_id_9583;
  var_2._id_AADD = ::_id_9584;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("little_bird");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("little_bird", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("little_bird", ::_id_9565);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("little_bird_mp", 5);
}

_id_9573() {
  level._effect["little_bird_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

_id_9563(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_air_lbravo_personnel_mp_flyable";
  var_0._id_0481 = "little_bird";
  var_0._id_04DE = "lbravo_physics_mp";
  var_0._id_31A0 = 1;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2._id_26C6 = gettime();
  var_2._id_5C89 = [];
  var_2._id_5C72 = 1;

  if(level.gametype == "br") {
    var_2._id_5C6D = 35;
  } else {
    var_2._id_5C6D = 10;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "little_bird", var_0);
  var_2.objweapon = makeweapon("little_bird_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "create")]](var_2);
  }

  var_2 thread _id_100D2();
  var_2 thread _id_3A62();
  return var_2;
}

_id_3A62() {
  self endon("death");
  self _meth_8654(1);

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(gettime() - self._id_26C6 < 5000) {
      continue;
    }
    if(isDefined(var_7) && isDefined(var_7._id_786F) && var_7._id_786F == "radar_drone_recon") {
      continue;
    }
    var_9 = 1.0;

    switch (var_8) {
      case 0:
        var_9 = level._id_9108;
        break;
      case 1:
        var_9 = level._id_910C;
        break;
      case 2:
        var_9 = level._id_910A;
        break;
      case 3:
        var_9 = level._id_910B;
        break;
      case 4:
        var_9 = level._id_9109;
        break;
    }

    var_10 = var_6 * var_9;
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10193(self);

    if(!isDefined(var_11)) {
      var_10 = var_10 * level._id_9107;
    }

    var_12 = self.angles[0];

    if(var_12 > 180) {
      var_12 = var_12 - 360;
    }

    if(abs(var_12 > level._id_911B)) {
      var_10 = var_10 * level._id_911A;
    }

    var_13 = self.angles[2];

    if(var_13 > 180) {
      var_13 = var_13 - 360;
    }

    if(abs(var_13 > level._id_911B)) {
      var_10 = var_10 * level._id_911A;
    }

    var_14 = 0;

    if(var_10 > level._id_9113) {
      var_14 = self.maxhealth;
    } else if(var_10 > level._id_9112) {
      var_15 = level._id_9113 - level._id_9112;
      var_16 = (var_10 - level._id_9112) / var_15;
      var_17 = self.maxhealth * level._id_9110;
      var_18 = self.maxhealth * level._id_910F;
      var_14 = scripts\engine\math::_id_91A9(var_17, var_18, var_16);
    } else if(var_10 > level._id_9111)
      var_14 = self.maxhealth * level._id_910E;

    if(var_14 > 0) {
      if(isDefined(var_11) && var_3 == 11534336) {
        var_14 = var_14 * level._id_911F;
      }

      scripts\cp_mp\vehicles\vehicle_damage::_id_10035(1);
      self dodamage(var_14, var_4, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::_id_10035(0);
    }

    wait 0.5;
  }
}

_id_9564(var_0) {
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_origin"), "tur_gun_lighttank_mp", 0);
  var_1 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 _meth_839D(1);
  var_1.angles = var_0.angles;
  var_1.vehicle = var_0;
  var_1.maxhealth = 999999;
  var_1.health = var_1.maxhealth;
  return var_1;
}

_id_956D(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "little_bird_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_9566();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_detach");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "little_bird_mp");
    playFX(scripts\engine\utility::getfx("little_bird_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_lbravo_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_9566() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_9565(var_0) {
  thread _id_956D(var_0);
  return 1;
}

_id_9583(var_0, var_1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10061(var_0, var_1);
}

_id_9584(var_0, var_1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10065(var_0, var_1);
}

_id_956A(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    var_3 _id_956F(var_0, var_4, 1);
  }

  if(istrue(var_0._id_89D9)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0._id_C7B0) || var_6.team == var_0.team) {
        _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_6);
      }
    }

    foreach(var_9 in var_0._id_A924) {
      _id_07F9::_id_A89E(var_0._id_9B4D._id_A908, var_9);
    }

    _id_07F9::_id_A89E(var_0._id_9B4D._id_A908, var_3);
  }
}

_id_9568(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    var_3 _id_0797::_id_AE27();
    _id_9569(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_9569(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
    var_0 thread _id_100D1(var_3);
  } else if(var_1 == "gunner") {
    var_0._id_72C1.owner = var_3;
    var_0._id_72C1 setotherent(var_3);
    var_0._id_72C1 setentityowner(var_3);
    var_0._id_72C1 setsentryowner(var_3);
    var_3 _meth_80AF();
    var_3 controlturreton(var_0._id_72C1);
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
  } else
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);

  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "endEnterInternal")]](var_0, var_1, var_2, var_3, var_4);
  }
}

_id_956B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_956C(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_956C(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "pilot") {
    var_0 notify("little_bird_driver_exit");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      var_3 _meth_8095();
    }
  }

  if(var_1 == "gunner") {
    if(!istrue(var_4._id_B695)) {
      var_3 _meth_80E2();
      var_3 _meth_8292(var_0._id_72C1);

      if(!istrue(var_4._id_B68D)) {
        var_3 thread _id_9587(var_0, var_4, 1);
      }
    }

    var_0._id_72C1.owner = undefined;
    var_0._id_72C1 setotherent(undefined);
    var_0._id_72C1 setentityowner(undefined);
    var_0._id_72C1 setsentryowner(undefined);
  }

  if(!istrue(var_4._id_B695)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D2(var_3, var_2, var_4);

    if(!var_5) {
      var_3 suicide();
    } else if(istrue(var_0._id_89D9)) {
      _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_3);
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
}

_id_9585(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "gunner") {
    var_3 thread _id_9587(var_0, var_4, 1);
  }
}

_id_956F(var_0, var_1, var_2) {
  if(isDefined(var_1._id_BF06)) {
    var_1 endon(var_1._id_BF06);
  }

  if(istrue(var_2)) {
    childthread _id_9570(var_1, 1.5);
  }

  if(!self hasweapon("tur_gun_lighttank_mp")) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon("tur_gun_lighttank_mp");
  }

  var_3 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::_id_87E0("tur_gun_lighttank_mp")) {
    var_3 = 1;
  } else {
    var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("tur_gun_lighttank_mp", 1);
  }

  if(isDefined(var_1) && isDefined(var_3) && !var_3) {
    var_1._id_EACB = 0;
    var_1 notify(var_1._id_BF05);
  }
}

_id_9587(var_0, var_1, var_2) {
  if(isDefined(var_1._id_BF06)) {
    var_1 endon(var_1._id_BF06);
  }

  if(istrue(var_2)) {
    childthread _id_9570(var_1, 1.5);
  }

  if(self hasweapon("tur_gun_lighttank_mp")) {
    var_3 = undefined;

    if(scripts\cp_mp\utility\inventory_utility::_id_8A86("tur_gun_lighttank_mp")) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C("tur_gun_lighttank_mp");
      var_3 = 1;
    } else {
      if(isDefined(var_0._id_72C1)) {
        self _meth_8292(var_0._id_72C1);
      }

      if(self hasweapon("tur_gun_lighttank_mp")) {
        var_4 = scripts\cp_mp\utility\inventory_utility::_id_87E0("tur_gun_lighttank_mp");

        if(var_4) {
          scripts\cp_mp\utility\inventory_utility::_takeweapon("tur_gun_lighttank_mp");
          thread scripts\cp_mp\utility\inventory_utility::_id_5ED6();
        } else
          thread scripts\cp_mp\utility\inventory_utility::_id_6CF7("tur_gun_lighttank_mp", 1);
      }

      var_3 = 1;
    }

    if(isDefined(var_3) && !var_3) {
      var_1._id_EACB = 0;
      var_1 notify(var_1._id_BF05);
    }
  }
}

_id_9570(var_0, var_1) {
  wait(var_1);
  var_0._id_EACB = 0;
  var_0 notify(var_0._id_BF05);
}

_id_100D2() {
  self endon("death");

  for(;;) {
    if(!self._id_5C72) {
      wait(self._id_5C6D);
      self._id_5C72 = 1;
      var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10193(self);

      if(isDefined(var_0)) {
        _id_09CA::_id_10382("little_bird", "flares", 1, var_0);
      }
    }

    waitframe();
  }
}

_id_100D1(var_0) {
  self endon("death");
  self endon("little_bird_driver_exit");
  var_0 endon("death_or_disconnect");
  var_0 endon("vehicle_exit");
  var_0 notifyonplayercommand("shoot_flare", "+attack");
  _id_09CA::_id_10382("little_bird", "flares", scripts\engine\utility::ter_op(self._id_5C72, 1, 0), var_0);

  for(;;) {
    var_0 waittill("shoot_flare");

    if(!self._id_5C72) {
      self playsoundtoplayer("lbravo_noflares_warning", var_0);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]();
    }

    var_1 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
      var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
    }

    if(isDefined(level._id_9F7E)) {
      foreach(var_3 in level._id_9F7E) {
        if(!isDefined(var_3._id_9701) || var_3._id_9701 != self) {
          continue;
        }
        var_4 = distance(self.origin, var_3.origin);

        if(var_4 < 4000) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
            var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("manual_flare_missile_redirect");
          }

          scripts\cp_mp\utility\weapon_utility::_id_3971(var_3);
          var_3 missile_settargetent(var_1);
          var_3 notify("missile_pairedWithFlare");
        }
      }
    }

    self._id_5C72 = 0;
    _id_09CA::_id_10382("little_bird", "flares", 0, var_0);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_10186(var_0);
  }
}

_id_9578() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird", 1);
  var_0._id_9C7B = 5;
  var_0._id_BD27 = 100;
  var_0._id_6D5D = ::_id_956E;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "spawnCallback");
  var_0._id_3923 = 185;
  var_0._id_391F = 100;
  var_0._id_3922 = -100;
  var_0._id_3921 = 185;
}

_id_956E() {
  var_0 = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}