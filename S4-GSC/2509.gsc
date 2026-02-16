/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2509.gsc
*************************************************/

_id_1E4F() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("atv", 1);
  var_0._id_4841 = ::_id_1E49;
  _id_1E54();
  _id_1E52();
  _id_1E55();
  _id_1E50();
  _id_1E51();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "init")]]();
  }

  _id_1E56();
  _id_1E53();
}

_id_1E53() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "initLate")]]();
  }
}

_id_1E54() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("atv", 1);
  var_0._id_54D6 = ::_id_1E45;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_1E47;
  var_0._id_577C["front"] = 45;
  var_0._id_577C["back"] = 45;
  var_0._id_577C["left"] = 28;
  var_0._id_577C["right"] = 28;
  var_0._id_577C["top"] = 45;
  var_0._id_577C["bottom"] = 0;
  var_0._id_5796 = 40;
  var_1 = "left";
  var_0._id_5788[var_1] = (-5, 0, 55);
  var_0._id_5778[var_1] = "left";
  var_1 = "right";
  var_0._id_5788[var_1] = (-5, 0, 55);
  var_0._id_5778[var_1] = "right";
  var_1 = "front";
  var_0._id_5788[var_1] = (29, 0, 55);
  var_0._id_5778[var_1] = "front";
  var_1 = "back";
  var_0._id_5788[var_1] = (-35, 0, 45);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("atv", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["left", "right", "back", "front"];
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_4._id_DC8E = 1;
  var_3 = "rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("atv", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["back", "right", "right", "front"];
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_4._id_DC8E = 1;
}

_id_1E52() {
  var_0 = _id_09E1::_id_100EF("atv", 1);
  var_0._id_CFC0["single"] = ["driver", "rear"];
}

_id_1E55() {
  var_0 = _id_09CA::_id_10373("atv", 1);
  var_0._id_7C8C = 4;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["rear"] = 1;
}

_id_1E50() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("atv", 500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("atv");
  var_0.class = "super_light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("atv");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("atv", 4);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("atv", ::_id_1E40);
}

_id_1E51() {
  level._effect["atv_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_atv.vfx");
}

_id_1E3E(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_atango_physics_mp";
  var_0._id_0481 = "atv";
  var_0._id_04DE = "atango_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "atv", var_0);
  var_2.objweapon = makeweapon("atv_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "create")]](var_2);
  }

  return var_2;
}

_id_1E49(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "atv_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_1E43();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "atv_mp");
    playFX(scripts\engine\utility::getfx("atv_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "small_car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_1E43() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_1E40(var_0) {
  thread _id_1E49(var_0);
  return 1;
}

_id_1E45(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_1E46(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_1E46(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_1E47(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_1E48(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_1E48(var_0, var_1, var_2, var_3, var_4) {
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

_id_1E56() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("atv", 1);
  var_0._id_9C7B = 4;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_1E4D;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "spawnCallback");
  var_0._id_3923 = 55;
  var_0._id_391F = 45;
  var_0._id_3921 = 55;
}

_id_1E4D() {
  var_0 = scripts\engine\utility::getStructArray("atv_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}