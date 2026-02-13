/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2524.gsc
*************************************************/

_id_FF9A() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("van", 1);
  var_0._id_4841 = ::_id_FF8B;
  _id_FF9F();
  _id_FF9D();
  _id_FFA0();
  _id_FF9B();
  _id_FF9C();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "init")]]();
  }

  _id_FFA1();
  _id_FF9E();
}

_id_FF9E() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "initLate")]]();
  }
}

_id_FF9F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("van", 1);
  var_0._id_54D6 = ::_id_FF87;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_FF89;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 130;
  var_0._id_577C["back"] = 117;
  var_0._id_577C["left"] = 55;
  var_0._id_577C["right"] = 55;
  var_0._id_577C["top"] = 105;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (98, 0, 65);
  var_0._id_5778[var_1] = "front";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-64, 20, 78);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-64, -20, 78);
  var_0._id_5778[var_1] = "back";
  var_2 = [];
  var_2[var_2.size] = "driver";
  var_2[var_2.size] = "front_right";
  var_2[var_2.size] = "front_right_rear";
  var_2[var_2.size] = "back_right_rear";
  var_2[var_2.size] = "back_left_rear";
  var_2[var_2.size] = "front_left_rear";
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left_rear", "back_left", "front_right", "front"];
  var_0._id_5788[var_3] = (36, 20, 78);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "front_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_right_rear", "back_right", "driver", "front"];
  var_0._id_5788[var_3] = (36, -20, 78);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "front_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left_rear", "back_left", "front_right_rear", "front"];
  var_0._id_5788[var_3] = (-8, 20, 78);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "front_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_right_rear", "back_right", "front_left_rear", "front"];
  var_0._id_5788[var_3] = (-8, -20, 78);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_4";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "driver", "back_left", "back_right_rear", "front"];
  var_0._id_5788[var_3] = (-64, 20, 78);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "back_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("van", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "front_right", "back_right", "back_left_rear", "front"];
  var_0._id_5788[var_3] = (-64, -20, 78);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_FF9D() {
  var_0 = _id_09E1::_id_100EF("van", 1);
  var_0._id_CFC0["driver"] = ["driver"];
  var_0._id_CFC0["front_right"] = ["front_right"];
  var_0._id_CFC0["front_left_rear"] = ["front_left_rear"];
  var_0._id_CFC0["front_right_rear"] = ["front_right_rear"];
  var_0._id_CFC0["back_left_rear"] = ["back_left_rear"];
  var_0._id_CFC0["back_right_rear"] = ["back_right_rear"];
}

_id_FFA0() {
  var_0 = _id_09CA::_id_10373("van", 1);
  var_0._id_7C8C = 13;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["front_right"] = 1;
  var_0._id_CFC3["front_left_rear"] = 2;
  var_0._id_CFC3["front_right_rear"] = 3;
  var_0._id_CFC3["back_left_rear"] = 4;
  var_0._id_CFC3["back_right_rear"] = 5;
}

_id_FF9B() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("van", 1350);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("van");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("van");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("van", 8);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("van", ::_id_FF85);
}

_id_FF9C() {
  level._effect["van_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

_id_FF81(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_palfa_windows_east_physics_tan_mp";
  var_0._id_0481 = "van";
  var_0._id_04DE = "palfa_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "van", var_0);
  var_2.objweapon = makeweapon("van_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "create")]](var_2);
  }

  return var_2;
}

_id_FF8B(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "van_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_FF86();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "van_mp");
    playFX(scripts\engine\utility::getfx("van_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_FF86() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_FF85(var_0) {
  thread _id_FF8B(var_0);
  return 1;
}

_id_FF87(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_FF88(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_FF88(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_FF89(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_FF8A(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_FF8A(var_0, var_1, var_2, var_3, var_4) {
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

_id_FFA1() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_FF8D;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("van", "spawnCallback");
  var_0._id_3923 = 130;
  var_0._id_391F = 105;
  var_0._id_3921 = 130;
}

_id_FF8D() {
  var_0 = scripts\engine\utility::getstructarray("van_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}