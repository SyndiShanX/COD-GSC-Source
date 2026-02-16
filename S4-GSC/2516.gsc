/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2516.gsc
*************************************************/

_id_8BB9() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("jeep", 1);
  var_0._id_4841 = ::_id_8BB7;
  _id_8BBE();
  _id_8BBC();
  _id_8BBF();
  _id_8BBA();
  _id_8BBB();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "init")]]();
  }

  _id_8BC0();
  _id_8BBD();
}

_id_8BBD() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "initLate")]]();
  }
}

_id_8BBE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("jeep", 1);
  var_0._id_54D6 = ::_id_8BB3;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_8BB5;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10190();
  var_0._id_577C["front"] = 105;
  var_0._id_577C["back"] = 105;
  var_0._id_577C["left"] = 44;
  var_0._id_577C["right"] = 44;
  var_0._id_577C["top"] = 90;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (75, 0, 65);
  var_0._id_5778[var_1] = "front";
  var_1 = "back";
  var_0._id_5788[var_1] = (-90, 0, 65);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "front_right", "back_right", "back_left"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("jeep", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left", "back", "front_right", "front"];
  var_0._id_5788[var_3] = (17, 19, 65);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "front_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("jeep", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_right", "back", "driver", "front"];
  var_0._id_5788[var_3] = (17, -19, 65);
  var_0._id_5778[var_3] = "right";
  var_4._id_103D2["top"] = 27;
  var_4._id_103D2["bottom"] = 42;
  var_4._id_103D2["left"] = 105;
  var_4._id_103D2["right"] = 117;
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_7917 = 1;
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("jeep", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "front_right", "back", "back_left", "front"];
  var_0._id_5788[var_3] = (-24, -19, 65);
  var_0._id_5778[var_3] = "right";
  var_4._id_103D2["top"] = 27;
  var_4._id_103D2["bottom"] = 42;
  var_4._id_103D2["left"] = 101;
  var_4._id_103D2["right"] = 122;
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_7917 = 1;
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("jeep", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "driver", "back", "back_right", "front"];
  var_0._id_5788[var_3] = (-24, 19, 65);
  var_0._id_5778[var_3] = "left";
  var_4._id_103D2["top"] = 27;
  var_4._id_103D2["bottom"] = 42;
  var_4._id_103D2["left"] = 122;
  var_4._id_103D2["right"] = 101;
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_7917 = 1;
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_8BBC() {
  var_0 = _id_09E1::_id_100EF("jeep", 1);
  var_0._id_CFC0["single"] = ["driver", "front_right", "back_left", "back_right"];
}

_id_8BBF() {
  var_0 = _id_09CA::_id_10373("jeep", 1);
  var_0._id_7C8C = 10;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["front_right"] = 1;
  var_0._id_CFC3["back_left"] = 2;
  var_0._id_CFC3["back_right"] = 3;
}

_id_8BBA() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("jeep", 800);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("jeep");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("jeep");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("jeep", 9);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("jeep", ::_id_8BB1);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("jeep_mp", 3);
}

_id_8BBB() {
  level._effect["jeep_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");
}

_id_8BB0(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
  var_0._id_0481 = "jeep";
  var_0._id_04DE = "decho_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "jeep", var_0);
  var_2.objweapon = makeweapon("jeep_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "create")]](var_2);
  }

  return var_2;
}

_id_8BB7(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "jeep_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_8BB2();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "jeep_mp");
    playFX(scripts\engine\utility::getfx("jeep_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_8BB2() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_8BB1(var_0) {
  thread _id_8BB7(var_0);
  return 1;
}

_id_8BB3(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_8BB4(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_8BB4(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_8BB5(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_8BB6(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_8BB6(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
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
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
}

_id_8BC0() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_8BB8;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "spawnCallback");
  var_0._id_3923 = 105;
  var_0._id_391F = 90;
  var_0._id_3921 = 105;
}

_id_8BB8() {
  var_0 = scripts\engine\utility::getStructArray("jeep_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}