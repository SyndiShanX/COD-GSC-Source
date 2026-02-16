/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2512.gsc
*************************************************/

_id_3283() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("cargo_truck", 1);
  var_0._id_4841 = ::_id_3281;
  _id_3288();
  _id_3286();
  _id_3289();
  _id_3284();
  _id_3285();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "init")]]();
  }

  _id_328A();
  _id_3287();
}

_id_3287() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "initLate")]]();
  }
}

_id_3288() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("cargo_truck", 1);
  var_0._id_54D6 = ::_id_327D;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_327F;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_0._id_577C["front"] = 175;
  var_0._id_577C["back"] = 180;
  var_0._id_577C["left"] = 68;
  var_0._id_577C["right"] = 68;
  var_0._id_577C["top"] = 138;
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
  var_2 = "driver";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("cargo_truck", var_2, 1);
  var_3._id_5780 = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_3._id_18F2 = "tag_seat_0";
  var_3._id_AAC6 = "ping_vehicle_driver";
}

_id_3286() {
  var_0 = _id_09E1::_id_100EF("cargo_truck", 1);
  var_0._id_CFC0["single"] = ["driver"];
}

_id_3289() {
  var_0 = _id_09CA::_id_10373("cargo_truck", 1);
  var_0._id_7C8C = 8;
  var_0._id_CFC3["driver"] = 0;
}

_id_3284() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("cargo_truck", 1800);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("cargo_truck");
  var_0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("cargo_truck");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("cargo_truck", 20);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("cargo_truck", ::_id_327B);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("cargo_truck_mp", 5);
}

_id_3285() {
  level._effect["cargo_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

_id_327A(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  var_0._id_0481 = "cargo_truck";
  var_0._id_04DE = "mkilo_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "cargo_truck", var_0);
  var_2.objweapon = makeweapon("cargo_truck_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "create")]](var_2);
  }

  return var_2;
}

_id_3281(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_327C();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_327C() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_327B(var_0) {
  thread _id_3281(var_0);
  return 1;
}

_id_327D(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_327E(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_327E(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(var_3);
  var_0 setentityowner(var_3);
  var_3 _meth_8094(var_0);
  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
}

_id_327F(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    _id_3280(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_3280(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(undefined);
  var_0 setentityowner(undefined);

  if(!istrue(var_4._id_B695)) {
    var_3 _meth_8095();
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

_id_328A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_3282;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "spawnCallback");
  var_0._id_3923 = 185;
  var_0._id_391F = 138;
  var_0._id_3921 = 185;
}

_id_3282() {
  var_0 = scripts\engine\utility::getStructArray("cargotruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}