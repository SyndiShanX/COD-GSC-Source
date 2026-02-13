/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cargo_truck_susp.gsc
*******************************************************/

cargo_truck_susp_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("cargo_truck_susp", 1);
  var_0._id_4841 = ::cargo_truck_susp_explode;
  cargo_truck_susp_initoccupancy();
  cargo_truck_susp_initinteract();
  cargo_truck_susp_initomnvars();
  cargo_truck_susp_initdamage();
  cargo_truck_susp_initcollision();
  cargo_truck_susp_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "init")]]();
  }

  cargo_truck_susp_initspawning();
  cargo_truck_susp_initlate();
}

cargo_truck_susp_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "initLate")]]();
  }
}

cargo_truck_susp_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("cargo_truck_susp", 1);
  var_0._id_54D6 = ::cargo_truck_susp_enterend;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::cargo_truck_susp_exitend;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_0._id_577C["front"] = 110;
  var_0._id_577C["back"] = 135;
  var_0._id_577C["left"] = 48;
  var_0._id_577C["right"] = 48;
  var_0._id_577C["top"] = 100;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (140, 0, 115);
  var_0._id_5778[var_1] = "front";
  var_1 = "front_right";
  var_0._id_5788[var_1] = (65, 23, 115);
  var_0._id_5778[var_1] = "right";
  var_1 = "front_left";
  var_0._id_5788[var_1] = (65, 23, 115);
  var_0._id_5778[var_1] = "left";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-152, 36, 115);
  var_0._id_5778[var_1] = "back";
  var_1 = "side_left";
  var_0._id_5788[var_1] = (-109, 36, 115);
  var_0._id_5778[var_1] = "left";
  var_2 = ["driver", "passenger"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cargo_truck_susp", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "passenger";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cargo_truck_susp", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["front_right", "front", "front_left", "side_left", "back_left"];
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
}

cargo_truck_susp_initinteract() {
  var_0 = _id_09E1::_id_100EF("cargo_truck_susp", 1);
  var_0._id_CFC0["single"] = ["driver", "passenger"];
}

cargo_truck_susp_initomnvars() {
  var_0 = _id_09CA::_id_10373("cargo_truck_susp", 1);
  var_0._id_7C8C = 4;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["passenger"] = 1;
}

cargo_truck_susp_initdamage() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("cargo_truck_susp", 2300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("cargo_truck_susp");
  var_0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("cargo_truck_susp");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("cargo_truck_susp", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("cargo_truck_susp", ::cargo_truck_susp_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("cargo_truck_mp", 5);
}

cargo_truck_susp_initcollision() {}

cargo_truck_susp_initfx() {
  level._effect["cargo_truck_susp_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_ct_death_exp.vfx");
}

cargo_truck_susp_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_lnd_truck_opapa40_wz";
  var_0._id_0481 = "cargo_truck_susp";
  var_0._id_04DE = "cargo_truck_susp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "cargo_truck_susp", var_0);
  var_2.objweapon = makeweapon("cargo_truck_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "create")]](var_2);
  }

  return var_2;
}

cargo_truck_susp_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread cargo_truck_susp_deletenextframe();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_susp_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

cargo_truck_susp_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

cargo_truck_susp_deathcallback(var_0) {
  thread cargo_truck_susp_explode(var_0);
  return 1;
}

cargo_truck_susp_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    cargo_truck_susp_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

cargo_truck_susp_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

cargo_truck_susp_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    cargo_truck_susp_exitendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

cargo_truck_susp_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

cargo_truck_susp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::cargo_truck_susp_getspawnstructscallback;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "spawnCallback");
  var_0._id_3923 = 185;
  var_0._id_391F = 138;
  var_0._id_3921 = 185;
}

cargo_truck_susp_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getstructarray("cargotrucksusp_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}