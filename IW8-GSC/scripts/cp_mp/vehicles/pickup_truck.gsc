/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\pickup_truck.gsc
***************************************************/

function pickup_truck_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("pickup_truck", 1);
  var_0.destroycallback = &pickup_truck_explode;
  pickup_truck_initoccupancy();
  pickup_truck_initinteract();
  ref_12354();
  ref_12353();
  pickup_truck_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "init")]]();
  }

  pickup_truck_initspawning();
  pickup_truck_initlate();
}

function pickup_truck_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "initLate")]]();
    return;
  }
}

function pickup_truck_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("pickup_truck", 1);
  var_0.enterendcallback = &pickup_truck_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &pickup_truck_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 120;
  var_0.exitextents["back"] = 120;
  var_0.exitextents["left"] = 45;
  var_0.exitextents["right"] = 45;
  var_0.exitextents["top"] = 90;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (90, 20, 72);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (24, -20, 75);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-90, 27, 75);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-90, 27, 75);
  var_0.exitdirections[var_1] = "back";
  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "driver");
}

function pickup_truck_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("pickup_truck", 1);
  var_0.seatenterarrays["driver"] = ["driver"];
  var_0.seatenterarrays["bl_rear"] = ["bl_rear"];
  var_0.seatenterarrays["br_rear"] = ["br_rear"];
}

function ref_12354() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("pickup_truck", 1);
  var_0.id = 7;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fr"] = 1;
  var_0.seatids["fl_rear"] = 2;
  var_0.seatids["fr_rear"] = 3;
  var_0.seatids["bl_rear"] = 4;
  var_0.seatids["br_rear"] = 5;
}

function ref_12353() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("pickup_truck", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("pickup_truck");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("pickup_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("pickup_truck", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("pickup_truck", &pickup_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("pickup_truck_mp", 3);
}

function pickup_truck_initfx() {
  level._effect["pickup_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_pickup_mp_death_exp.vfx");
}

function pickup_truck_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_techo_physics_mp";
  var_0.targetname = "pickup_truck";
  var_0.vehicletype = "techo_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "pickup_truck", var_0);
  var_2.objweapon = getcompleteweaponname("pickup_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "create")]](var_2);
  }

  return var_2;
}

function pickup_truck_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "pickup_truck_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread pickup_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "pickup_truck_mp");
    playFX(scripts\engine\utility::getfx("pickup_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function pickup_truck_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function pickup_truck_deathcallback(var_0) {
  thread pickup_truck_explode(var_0);
  return true;
}

function pickup_truck_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    pickup_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function pickup_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function pickup_truck_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    pickup_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function pickup_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 controlsunlink();
    }
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function pickup_truck_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &pickup_truck_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "spawnCallback");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 90;
  var_0.clearancecheckminradius = 120;
}

function pickup_truck_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("pickuptruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}