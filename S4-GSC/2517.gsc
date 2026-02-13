/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2517.gsc
*************************************************/

_id_8ED0() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("large_transport", 1);
  var_0._id_4841 = ::_id_8ECE;
  _id_8ED5();
  _id_8ED3();
  _id_8ED6();
  _id_8ED1();
  _id_8ED2();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "init")]]();
  }

  _id_8ED7();
  _id_8ED4();
}

_id_8ED4() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "initLate")]]();
  }
}

_id_8ED5() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("large_transport", 1);
  var_0._id_54D6 = ::_id_8ECA;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_8ECC;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 118;
  var_0._id_577C["back"] = 135;
  var_0._id_577C["left"] = 57;
  var_0._id_577C["right"] = 57;
  var_0._id_577C["top"] = 127;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (100, 0, 75);
  var_0._id_5778[var_1] = "front";
  var_1 = "front_right";
  var_0._id_5788[var_1] = (55, 22, 90);
  var_0._id_5778[var_1] = "right";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-109, 22, 90);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-109, -22, 90);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "fr_rear", "mr_rear", "br_rear", "bl_rear", "ml_rear", "fl_rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "ml_rear", "back_left", "front_right", "front"];
  var_0._id_5788[var_3] = (55, 22, 90);
  var_0._id_5778[var_3] = "left";
  var_4._id_430F = 0.5;
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "fl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "bl_rear", "back_left", "fr_rear", "front"];
  var_0._id_5788[var_3] = (-42, 22, 90);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "fr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "br_rear", "back_right", "fl_rear", "front"];
  var_0._id_5788[var_3] = (-42, -22, 90);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "ml_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "bl_rear", "back_left", "mr_rear", "front"];
  var_0._id_5788[var_3] = (-76, 22, 90);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_6";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "mr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "br_rear", "back_right", "ml_rear", "front"];
  var_0._id_5788[var_3] = (-76, -22, 90);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "bl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "fl_rear", "back_left", "br_rear", "front"];
  var_0._id_5788[var_3] = (-109, 22, 90);
  var_0._id_5778[var_3] = "left";
  var_4._id_18F2 = "tag_seat_7";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "br_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("large_transport", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "fr_rear", "back_right", "bl_rear", "front"];
  var_0._id_5788[var_3] = (-109, -22, 90);
  var_0._id_5778[var_3] = "right";
  var_4._id_18F2 = "tag_seat_4";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_8ED3() {
  var_0 = _id_09E1::_id_100EF("large_transport", 1);
  var_0._id_CFC0["driver"] = ["driver"];
  var_0._id_CFC0["fl_rear"] = ["fl_rear"];
  var_0._id_CFC0["fr_rear"] = ["fr_rear"];
  var_0._id_CFC0["ml_rear"] = ["ml_rear"];
  var_0._id_CFC0["mr_rear"] = ["mr_rear"];
  var_0._id_CFC0["bl_rear"] = ["bl_rear"];
  var_0._id_CFC0["br_rear"] = ["br_rear"];
}

_id_8ED6() {
  var_0 = _id_09CA::_id_10373("large_transport", 1);
  var_0._id_7C8C = 5;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fl_rear"] = 6;
  var_0._id_CFC3["fr_rear"] = 1;
  var_0._id_CFC3["ml_rear"] = 5;
  var_0._id_CFC3["mr_rear"] = 2;
  var_0._id_CFC3["bl_rear"] = 4;
  var_0._id_CFC3["br_rear"] = 3;
}

_id_8ED1() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("large_transport", 2000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("large_transport");
  var_0.class = "medium_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("large_transport");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("large_transport", 10);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("large_transport", ::_id_8EC8);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("large_transport_mp", 3);
}

_id_8ED2() {
  level._effect["large_transport_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

_id_8EC7(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_umike_infil_physics_mp";
  var_0._id_0481 = "large_transport";
  var_0._id_04DE = "umike_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "large_transport", var_0);
  var_2.objweapon = makeweapon("large_transport_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "create")]](var_2);
  }

  return var_2;
}

_id_8ECE(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "large_transport_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_8EC9();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "large_transport_mp");
    playFX(scripts\engine\utility::getfx("large_transport_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_8EC9() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_8EC8(var_0) {
  thread _id_8ECE(var_0);
  return 1;
}

_id_8ECA(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_8ECB(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_8ECB(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_8ECC(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_8ECD(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_8ECD(var_0, var_1, var_2, var_3, var_4) {
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

_id_8ED7() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_8ECF;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "spawnCallback");
  var_0._id_3923 = 150;
  var_0._id_391F = 130;
  var_0._id_3921 = 150;
}

_id_8ECF() {
  var_0 = scripts\engine\utility::getstructarray("largetransport_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}