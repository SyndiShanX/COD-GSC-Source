/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2515.gsc
*************************************************/

_id_7A21() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("hoopty_truck", 1);
  var_0._id_4841 = ::_id_7A1F;
  _id_7A26();
  _id_7A24();
  _id_7A27();
  _id_7A22();
  _id_7A23();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "init")]]();
  }

  _id_7A28();
  _id_7A25();
}

_id_7A25() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "initLate")]]();
  }
}

_id_7A26() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("hoopty_truck", 1);
  var_0._id_54D6 = ::_id_7A1B;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_7A1D;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 75;
  var_0._id_577C["back"] = 105;
  var_0._id_577C["left"] = 35;
  var_0._id_577C["right"] = 35;
  var_0._id_577C["top"] = 87;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (58, 0, 55);
  var_0._id_5778[var_1] = "front";
  var_1 = "front_right";
  var_0._id_5788[var_1] = (17, 16, 73);
  var_0._id_5778[var_1] = "right";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-78, 16, 73);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-78, -16, 73);
  var_0._id_5778[var_1] = "back";
  var_2 = [];
  var_2[var_2.size] = "driver";
  var_2[var_2.size] = "front_right_rear";
  var_2[var_2.size] = "back_right_rear";
  var_2[var_2.size] = "back_left_rear";
  var_2[var_2.size] = "front_left_rear";
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("hoopty_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left_rear", "back_left", "front_right", "front"];
  var_0._id_5788[var_3] = (17, 16, 73);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "front_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("hoopty_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left_rear", "back_left", "front_right_rear", "front"];
  var_0._id_5788[var_3] = (-23, 16, 73);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "front_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("hoopty_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_right_rear", "back_right", "front_left_rear", "front"];
  var_0._id_5788[var_3] = (-23, -16, 73);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_4";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("hoopty_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "driver", "back_left", "back_right_rear", "front"];
  var_0._id_5788[var_3] = (-78, 16, 73);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("hoopty_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "front_right", "back_right", "back_left_rear", "front"];
  var_0._id_5788[var_3] = (-78, -16, 73);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_7A24() {
  var_0 = _id_09E1::_id_100EF("hoopty_truck", 1);
  var_0._id_CFC0["driver"] = ["driver"];
  var_0._id_CFC0["front_left_rear"] = ["front_left_rear"];
  var_0._id_CFC0["front_right_rear"] = ["front_right_rear"];
  var_0._id_CFC0["back_left_rear"] = ["back_left_rear"];
  var_0._id_CFC0["back_right_rear"] = ["back_right_rear"];
}

_id_7A27() {
  var_0 = _id_09CA::_id_10373("hoopty_truck", 1);
  var_0._id_7C8C = 12;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["front_right"] = 1;
  var_0._id_CFC3["front_left_rear"] = 2;
  var_0._id_CFC3["front_right_rear"] = 3;
  var_0._id_CFC3["back_left_rear"] = 4;
  var_0._id_CFC3["back_right_rear"] = 5;
}

_id_7A22() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("hoopty_truck", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("hoopty_truck");
  var_0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("hoopty_truck");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("hoopty_truck", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("hoopty_truck", ::_id_7A19);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("hoopty_truck_mp", 3);
}

_id_7A23() {
  level._effect["hoopty_truck_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

_id_7A18(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_zuniform_physics";
  var_0._id_0481 = "hoopty_truck";
  var_0._id_04DE = "zuniform_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "hoopty_truck", var_0);
  var_2.objweapon = makeweapon("hoopty_truck_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "create")]](var_2);
  }

  return var_2;
}

_id_7A1F(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "hoopty_truck_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_7A1A();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "hoopty_truck_mp");
    playFX(scripts\engine\utility::getfx("hoopty_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_7A1A() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_7A19(var_0) {
  thread _id_7A1F(var_0);
  return 1;
}

_id_7A1B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_7A1C(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_7A1C(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_7A1D(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_7A1E(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_7A1E(var_0, var_1, var_2, var_3, var_4) {
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

_id_7A28() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty_truck", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_7A20;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "spawnCallback");
  var_0._id_3923 = 110;
  var_0._id_391F = 90;
  var_0._id_3921 = 110;
}

_id_7A20() {
  var_0 = scripts\engine\utility::getStructArray("hooptytruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}