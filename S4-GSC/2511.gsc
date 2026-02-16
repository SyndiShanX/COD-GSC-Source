/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2511.gsc
*************************************************/

_id_2C0F() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("bronco_sfps_mp", 1);
  var_0._id_4841 = ::_id_2C0D;
  var_0._id_3183 = 1;
  _id_2C14();
  _id_2C12();
  _id_2C15();
  _id_2C10();
  _id_2C11();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bronco_sfps_mp", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "init")]]();
  }

  _id_2C16();
  _id_2C13();
}

_id_2C13() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bronco_sfps_mp", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "initLate")]]();
  }
}

_id_2C14() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("bronco_sfps_mp", 1);
  var_0._id_54E3 = ::_id_2C0A;
  var_0._id_54D6 = ::_id_2C08;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_2C0B;
  var_0._id_C187 = ::_id_2C20;
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
  var_2 = ["driver"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("bronco_sfps_mp", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "middle_left", "front_right", "front", "back"];
  var_0._id_5788[var_3] = (40, 17, -40);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_pilot";
}

_id_2C12() {
  var_0 = _id_09E1::_id_100EF("bronco_sfps_mp", 1);
  var_0._id_CFC0["single"] = ["driver"];
}

_id_2C15() {
  var_0 = _id_09CA::_id_10373("bronco_sfps_mp", 1);
  var_0._id_171A["flares"] = 1;
  var_0._id_7C8C = 2;
  var_0._id_CFC3["driver"] = 0;
}

_id_2C10() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("bronco_sfps_mp", 720);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("bronco_sfps_mp");
  var_0.class = "medium_heavy";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_10040("bronco_sfps_mp", "heavy");
  var_1._id_AAC7 = ::_id_2C1E;
  var_1._id_AADD = ::_id_2C1F;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("bronco_sfps_mp");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("bronco_sfps_mp", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("bronco_sfps_mp", ::_id_2C06);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("bronco_sfps_mp", 5);
}

_id_2C11() {
  level._effect["bronco_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

_id_2C05(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  var_0._id_0481 = "bronco_sfps_mp";
  var_0._id_04DE = "bronco_mp";
  var_0._id_31A0 = 1;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2._id_26C6 = gettime();
  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "bronco_sfps_mp", var_0);
  var_2.objweapon = makeweapon("bronco_sfps_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bronco_sfps_mp", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "create")]](var_2);
  }

  var_2 thread _id_3A62();
  return var_2;
}

_id_3A62() {
  self endon("death");
  self _meth_8654(1);
}

_id_2C0D(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "bronco_sfps_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  self setscriptablepartstate("visibility", "hide", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_2C07();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "bronco_sfps_mp");
    playFX(scripts\engine\utility::getfx("bronco_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_lbravo_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_2C07() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bronco_sfps_mp", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_2C06(var_0) {
  thread _id_2C0D(var_0);
  return 1;
}

_id_2C1E(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10061(var_0, var_1);
}

_id_2C1F(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10065(var_0, var_1);
}

_id_2C0A(var_0, var_1, var_2, var_3, var_4) {
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

_id_2C08(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    var_3 _id_0797::_id_AE27();
    _id_2C09(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_2C09(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  } else
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);

  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bronco_sfps_mp", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "endEnterInternal")]](var_0, var_1, var_2, var_3, var_4);
  }
}

_id_2C0B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_2C0C(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_2C0C(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 notify("bronco_driver_exit");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      var_3 _meth_8095();
    }
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

_id_2C20(var_0, var_1, var_2, var_3, var_4) {}

_id_2C16() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("bronco_sfps_mp", 1);
  var_0._id_9C7B = 5;
  var_0._id_BD27 = 100;
  var_0._id_6D5D = ::_id_2C0E;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("bronco_sfps_mp", "spawnCallback");
  var_0._id_3923 = 185;
  var_0._id_391F = 100;
  var_0._id_3922 = -100;
  var_0._id_3921 = 185;
}

_id_2C0E() {
  var_0 = scripts\engine\utility::getStructArray("bronco_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}