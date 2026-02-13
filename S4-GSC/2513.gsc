/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2513.gsc
*************************************************/

_id_3D38() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("cop_car", 1);
  var_0._id_4841 = ::_id_3D36;
  _id_3D3D();
  _id_3D3B();
  _id_3D3E();
  _id_3D39();
  _id_3D3A();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "init")]]();
  }

  _id_3D3F();
  _id_3D3C();
}

_id_3D3C() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "initLate")]]();
  }
}

_id_3D3D() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("cop_car", 1);
  var_0._id_54D6 = ::_id_3D32;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_3D34;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10190();
  var_0._id_577C["front"] = 103;
  var_0._id_577C["back"] = 103;
  var_0._id_577C["left"] = 40;
  var_0._id_577C["right"] = 40;
  var_0._id_577C["top"] = 60;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (75, 0, 48);
  var_0._id_5778[var_1] = "front";
  var_1 = "back";
  var_0._id_5788[var_1] = (-75, 0, 48);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "fr", "br", "bl"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cop_car", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "bl", "back", "fr", "front"];
  var_0._id_5788[var_3] = (7, 14, 48);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "fr";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cop_car", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "br", "back", "driver", "front"];
  var_0._id_5788[var_3] = (7, -14, 48);
  var_0._id_5778[var_3] = "right";
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "bl";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cop_car", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "driver", "back", "br", "front"];
  var_0._id_5788[var_3] = (-28, 14, 48);
  var_0._id_5778[var_3] = "left";
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "br";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cop_car", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "fr", "back", "bl", "front"];
  var_0._id_5788[var_3] = (-28, -14, 48);
  var_0._id_5778[var_3] = "right";
  var_4._id_430F = 0.5;
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_3D3B() {
  var_0 = _id_09E1::_id_100EF("cop_car", 1);
  var_0._id_CFC0["driver"] = ["driver"];
  var_0._id_CFC0["fr"] = ["fr"];
  var_0._id_CFC0["bl"] = ["bl"];
  var_0._id_CFC0["br"] = ["br"];
}

_id_3D3E() {
  var_0 = _id_09CA::_id_10373("cop_car", 1);
  var_0._id_7C8C = 6;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fr"] = 1;
  var_0._id_CFC3["bl"] = 2;
  var_0._id_CFC3["br"] = 3;
}

_id_3D39() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("cop_car", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("cop_car");
  var_0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("cop_car");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("cop_car", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("cop_car", ::_id_3D30);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("cop_car_mp", 3);
}

_id_3D3A() {
  level._effect["cop_car_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

_id_3D2F(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_skilo_rus_police_physics_mp";
  var_0._id_0481 = "cop_car";
  var_0._id_04DE = "skilo_police_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "cop_car", var_0);
  var_2.objweapon = makeweapon("cop_car_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "create")]](var_2);
  }

  return var_2;
}

_id_3D36(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cop_car_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_3D31();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cop_car_mp");
    playFX(scripts\engine\utility::getfx("cop_car_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_3D31() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_3D30(var_0) {
  thread _id_3D36(var_0);
  return 1;
}

_id_3D32(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_3D33(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_3D33(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_3D34(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_3D35(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_3D35(var_0, var_1, var_2, var_3, var_4) {
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

_id_3D3F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_3D37;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "spawnCallback");
  var_0._id_3923 = 100;
  var_0._id_391F = 60;
  var_0._id_3921 = 100;
}

_id_3D37() {
  var_0 = scripts\engine\utility::getstructarray("copcar_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}