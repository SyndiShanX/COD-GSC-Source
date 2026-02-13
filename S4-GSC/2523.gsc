/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2523.gsc
*************************************************/

_id_EFED() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("technical", 1);
  var_0._id_4841 = ::_id_EFE6;
  _id_EFF2();
  _id_EFF0();
  _id_EFF3();
  _id_EFEE();
  _id_EFEF();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "init")]]();
  }

  _id_EFF4();
  _id_EFF1();
}

_id_EFF1() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "initLate")]]();
  }
}

_id_EFF2() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("technical", 1);
  var_0._id_54E3 = ::_id_EFE3;
  var_0._id_54D6 = ::_id_EFE1;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_EFE4;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 95;
  var_0._id_577C["back"] = 115;
  var_0._id_577C["left"] = 38;
  var_0._id_577C["right"] = 38;
  var_0._id_577C["top"] = 73;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front_right";
  var_0._id_5788[var_1] = (5, -14, 55);
  var_0._id_5778[var_1] = "right";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-90, 14, 55);
  var_0._id_5778[var_1] = "back";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-90, -14, 55);
  var_0._id_5778[var_1] = "back";
  var_1 = "front";
  var_0._id_5788[var_1] = (65, 0, 55);
  var_0._id_5778[var_1] = "front";
  var_2 = ["driver", "fr_rear", "br_rear", "bl_rear", "fl_rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("technical", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5780 = [var_3, "fl_rear", "back_left", "front_right", "front"];
  var_0._id_5788[var_3] = (5, 14, 55);
  var_0._id_5778[var_3] = "left";
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "fl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("technical", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_18F2 = "tag_seat_2";
  var_4._id_5780 = [var_3, "bl_rear", "back_left", "fr_rear", "front"];
  var_0._id_5788[var_3] = (-60, 14, 55);
  var_0._id_5778[var_3] = "left";
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "fr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("technical", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_18F2 = "tag_seat_4";
  var_4._id_5780 = [var_3, "br_rear", "back_right", "fl_rear", "front"];
  var_0._id_5788[var_3] = (-60, -14, 55);
  var_0._id_5778[var_3] = "right";
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "bl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("technical", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_18F2 = "tag_seat_3";
  var_4._id_5780 = [var_3, "back_left", "fl_rear", "br_rear", "front"];
  var_0._id_5788[var_3] = (-90, 14, 55);
  var_0._id_5778[var_3] = "left";
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_3 = "br_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("technical", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_18F2 = "tag_seat_5";
  var_4._id_5780 = [var_3, "back_right", "fr_rear", "bl_rear", "front"];
  var_0._id_5788[var_3] = (-90, -14, 55);
  var_0._id_5778[var_3] = "right";
  var_4._id_AAC6 = "ping_vehicle_rider";
}

_id_EFF0() {
  var_0 = _id_09E1::_id_100EF("technical", 1);
  var_0._id_CFC0["single"] = ["driver", "fl_rear", "fr_rear", "bl_rear", "br_rear"];
}

_id_EFF3() {
  var_0 = _id_09CA::_id_10373("technical", 1);
  var_0._id_7C8C = 0;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fl_rear"] = 1;
  var_0._id_CFC3["fr_rear"] = 2;
  var_0._id_CFC3["bl_rear"] = 3;
  var_0._id_CFC3["br_rear"] = 4;
}

_id_EFEE() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("technical", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("technical");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("technical");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("technical", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("technical", ::_id_EFDD);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("technical_mp", 3);
}

_id_EFEF() {
  level._effect["technical_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_technical_mp_death_exp.vfx");
}

_id_EFD9(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_hindia_physics_mp";
  var_0._id_0481 = "technical";
  var_0._id_04DE = "hindia_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "technical", var_0);
  var_2.objweapon = makeweapon("technical_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "create")]](var_2);
  }

  return var_2;
}

_id_EFE6(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "technical_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_EFDE();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_body_animate");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "technical_mp");
    playFX(scripts\engine\utility::getfx("technical_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_EFDE() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_EFDD(var_0) {
  thread _id_EFE6(var_0);
  return 1;
}

_id_EFE3(var_0, var_1, var_2, var_3, var_4) {
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

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3._id_9509)) {
    var_3._id_9509 hide();
  }
}

_id_EFE1(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_EFE2(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_EFE2(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_EFE4(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_EFE5(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_EFE5(var_0, var_1, var_2, var_3, var_4) {
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
      var_3 suicide();
    } else if(istrue(var_0._id_89D9)) {
      _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_3);
    }
  }

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3._id_9509)) {
    var_3._id_9509 show();
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
}

_id_EFF4() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("technical", 1);
  var_0._id_9C7B = 30;
  var_0._id_BD27 = 50;
  var_0._id_6D5D = ::_id_EFE7;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "spawnCallback");
  var_0._id_3923 = 121;
  var_0._id_391F = 73;
  var_0._id_3921 = 121;
}

_id_EFE7() {
  var_0 = scripts\engine\utility::getstructarray("technical_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}