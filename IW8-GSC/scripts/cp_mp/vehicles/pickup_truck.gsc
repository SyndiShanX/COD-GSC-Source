/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\pickup_truck.gsc
***************************************************/

function pickup_truck_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("pickup_truck", 1);
  var0.destroycallback = &pickup_truck_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("pickup_truck", 1);
  var0.enterendcallback = &pickup_truck_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &pickup_truck_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 120;
  var0.exitextents["back"] = 120;
  var0.exitextents["left"] = 45;
  var0.exitextents["right"] = 45;
  var0.exitextents["top"] = 90;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (90, 20, 72);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (24, -20, 75);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-90, 27, 75);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-90, 27, 75);
  var0.exitdirections[var1] = "back";
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "driver");
}

function pickup_truck_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("pickup_truck", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["bl_rear"] = ["bl_rear"];
  var0.seatenterarrays["br_rear"] = ["br_rear"];
}

function ref_12354() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("pickup_truck", 1);
  var0.id = 7;
  var0.seatids["driver"] = 0;
  var0.seatids["fr"] = 1;
  var0.seatids["fl_rear"] = 2;
  var0.seatids["fr_rear"] = 3;
  var0.seatids["bl_rear"] = 4;
  var0.seatids["br_rear"] = 5;
}

function ref_12353() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("pickup_truck", 1000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("pickup_truck");
  var0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("pickup_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("pickup_truck", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("pickup_truck", &pickup_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("pickup_truck_mp", 3);
}

function pickup_truck_initfx() {
  level._effect["pickup_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_pickup_mp_death_exp.vfx");
}

function pickup_truck_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_techo_physics_mp";
  var0.targetname = "pickup_truck";
  var0.vehicletype = "techo_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "pickup_truck", var0);
  var2.objweapon = getcompleteweaponname("pickup_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickup_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "create")]](var2);
  }

  return var2;
}

function pickup_truck_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "pickup_truck_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread pickup_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "pickup_truck_mp");
    playFX(scripts\engine\utility::getfx("pickup_truck_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function pickup_truck_deathcallback(var0) {
  thread pickup_truck_explode(var0);
  return true;
}

function pickup_truck_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    pickup_truck_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function pickup_truck_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function pickup_truck_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    pickup_truck_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function pickup_truck_exitendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var3 controlsunlink();
    }
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function pickup_truck_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &pickup_truck_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("pickup_truck", "spawnCallback");
  var0.clearancecheckradius = 120;
  var0.clearancecheckheight = 90;
  var0.clearancecheckminradius = 120;
}

function pickup_truck_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("pickuptruck_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}