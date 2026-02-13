/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2522.gsc
*************************************************/

_id_ECD2() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("tac_rover", 1);
  var_0._id_4841 = ::_id_ECD0;
  _id_ECD7();
  _id_ECD5();
  _id_ECD8();
  _id_ECD3();
  _id_ECD4();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "init")]]();
  }

  _id_ECD9();
  _id_ECD6();
}

_id_ECD6() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "initLate")]]();
  }
}

_id_ECD7() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("tac_rover", 1);
  var_0._id_54D6 = ::_id_ECCC;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_ECCE;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 85;
  var_0._id_577C["back"] = 82;
  var_0._id_577C["left"] = 34;
  var_0._id_577C["right"] = 34;
  var_0._id_577C["top"] = 82;
  var_0._id_577C["bottom"] = 0;
  var_0._id_5788["front"] = (58, 0, 55);
  var_0._id_5778["front"] = "front";
  var_0._id_5788["back"] = (-65, 0, 65);
  var_0._id_5778["back"] = "back";
  var_1 = [];
  var_1[var_1.size] = "driver";
  var_1[var_1.size] = "fr_passenger";
  var_1[var_1.size] = "br_passenger";
  var_1[var_1.size] = "bl_passenger";
  var_2 = "driver";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("tac_rover", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_3._id_18F2 = "tag_seat_0";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_5780 = [var_2, "bl_passenger", "back", "fr_passenger", "front"];
  var_0._id_5788[var_2] = (10, 13, 48);
  var_0._id_5778[var_2] = "left";
  var_3._id_E354 = 10;
  var_3._id_AAC6 = "ping_vehicle_driver";
  var_2 = "fr_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("tac_rover", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "br_passenger", "back", "driver", "front"];
  var_0._id_5788[var_2] = (10, -13, 48);
  var_0._id_5778[var_2] = "right";
  var_3._id_103D2["top"] = 27;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 105;
  var_3._id_103D2["right"] = 111;
  var_3._id_18F2 = "tag_seat_1";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
  var_2 = "bl_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("tac_rover", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "driver", "back", "br_passenger", "front"];
  var_0._id_5788[var_2] = (-25, 13, 55);
  var_0._id_5778[var_2] = "left";
  var_3._id_103D2["top"] = 27;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 122;
  var_3._id_103D2["right"] = 101;
  var_3._id_18F2 = "tag_seat_2";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
  var_2 = "br_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("tac_rover", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "fr_passenger", "back", "bl_passenger", "front"];
  var_0._id_5788[var_2] = (-25, -13, 55);
  var_0._id_5778[var_2] = "right";
  var_3._id_103D2["top"] = 27;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 101;
  var_3._id_103D2["right"] = 122;
  var_3._id_18F2 = "tag_seat_3";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
}

_id_ECD5() {
  var_0 = _id_09E1::_id_100EF("tac_rover", 1);
  var_0._id_CFC0["single"] = ["driver", "fr_passenger", "bl_passenger", "br_passenger"];
}

_id_ECD8() {
  var_0 = _id_09CA::_id_10373("tac_rover", 1);
  var_0._id_7C8C = 3;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fr_passenger"] = 1;
  var_0._id_CFC3["bl_passenger"] = 2;
  var_0._id_CFC3["br_passenger"] = 3;
}

_id_ECD3() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("tac_rover", 750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("tac_rover");
  var_0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("tac_rover");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("tac_rover", 5);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("tac_rover", ::_id_ECCA);
}

_id_ECD4() {
  level._effect["tac_rover_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_tromeo_mp_death_exp.vfx");
}

_id_ECC9(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_tromeo_physics_mp";
  var_0._id_0481 = "tac_rover";
  var_0._id_04DE = "tromeo_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "tac_rover", var_0);
  var_2.objweapon = makeweapon("tac_rover_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "create")]](var_2);
  }

  return var_2;
}

_id_ECD0(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "tac_rover_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_ECCB();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "tac_rover_mp");
    playFX(scripts\engine\utility::getfx("tac_rover_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_ECCB() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_ECCA(var_0) {
  thread _id_ECD0(var_0);
  return 1;
}

_id_ECCC(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_ECCD(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_ECCD(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_ECCE(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_ECCF(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_ECCF(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  if(!istrue(var_4._id_B695)) {
    if(var_1 == "driver") {
      var_3 _meth_8095();
    }

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

_id_ECD9() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_ECD1;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "spawnCallback");
  var_0._id_3923 = 120;
  var_0._id_391F = 82;
  var_0._id_3921 = 120;
}

_id_ECD1() {
  var_0 = scripts\engine\utility::getstructarray("tacrover_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}