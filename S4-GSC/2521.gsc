/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2521.gsc
*************************************************/

_id_B095() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("pickup_truck", 1);
  var_0._id_4841 = ::_id_B093;
  _id_B09A();
  _id_B098();
  _id_B09B();
  _id_B096();
  _id_B097();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "init")]]();
  }

  _id_B09C();
  _id_B099();
}

_id_B099() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "initLate")]]();
  }
}

_id_B09A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("pickup_truck", 1);
  var_0._id_54D6 = ::_id_B08F;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_B091;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 120;
  var_0._id_577C["back"] = 120;
  var_0._id_577C["left"] = 45;
  var_0._id_577C["right"] = 45;
  var_0._id_577C["top"] = 90;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (90, 20, 72);
  var_0._id_5778[var_1] = "front";
  var_1 = "front_right";
  var_0._id_5788[var_1] = (24, -20, 75);
  var_0._id_5778[var_1] = "right";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-90, 27, 75);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-90, 27, 75);
  var_0._id_5778[var_1] = "back";
  var_2 = [];
  var_2[var_2.size] = "driver";
  var_2[var_2.size] = "br_rear";
  var_2[var_2.size] = "bl_rear";
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("pickup_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "bl_rear", "back_left", "front_right", "front"];
  var_0._id_5788[var_3] = (24, 20, 75);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "bl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("pickup_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "driver", "back_left", "br_rear", "front"];
  var_0._id_5788[var_3] = (-66, 27, 75);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "br_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("pickup_truck", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "front_right", "back_right", "bl_rear", "front"];
  var_0._id_5788[var_3] = (-66, -27, 75);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_B098() {
  var_0 = _id_09E1::_id_100EF("pickup_truck", 1);
  var_0._id_CFC0["driver"] = ["driver"];
  var_0._id_CFC0["bl_rear"] = ["bl_rear"];
  var_0._id_CFC0["br_rear"] = ["br_rear"];
}

_id_B09B() {
  var_0 = _id_09CA::_id_10373("pickup_truck", 1);
  var_0._id_7C8C = 7;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fr"] = 1;
  var_0._id_CFC3["fl_rear"] = 2;
  var_0._id_CFC3["fr_rear"] = 3;
  var_0._id_CFC3["bl_rear"] = 4;
  var_0._id_CFC3["br_rear"] = 5;
}

_id_B096() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("pickup_truck", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("pickup_truck");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("pickup_truck");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("pickup_truck", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("pickup_truck", ::_id_B08D);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("pickup_truck_mp", 3);
}

_id_B097() {
  level._effect["pickup_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_pickup_mp_death_exp.vfx");
}

_id_B08C(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_techo_physics_mp";
  var_0._id_0481 = "pickup_truck";
  var_0._id_04DE = "techo_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "pickup_truck", var_0);
  var_2.objweapon = makeweapon("pickup_truck_mp");
  _id_09DE::_id_10018(var_2);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "create")]](var_2);
  }

  return var_2;
}

_id_B093(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "pickup_truck_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_B08E();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "pickup_truck_mp");
    playFX(scripts\engine\utility::getfx("pickup_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_B08E() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_B08D(var_0) {
  thread _id_B093(var_0);
  return 1;
}

_id_B08F(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_B090(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_B090(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_B091(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_B092(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_B092(var_0, var_1, var_2, var_3, var_4) {
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

_id_B09C() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_B094;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "spawnCallback");
  var_0._id_3923 = 120;
  var_0._id_391F = 90;
  var_0._id_3921 = 120;
}

_id_B094() {
  var_0 = scripts\engine\utility::getStructArray("pickuptruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}