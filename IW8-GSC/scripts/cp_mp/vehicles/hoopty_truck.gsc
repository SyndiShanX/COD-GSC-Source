/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\hoopty_truck.gsc
***************************************************/

function hoopty_truck_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("hoopty_truck", 1);
  var0.destroycallback = &hoopty_truck_explode;
  hoopty_truck_initoccupancy();
  hoopty_truck_initinteract();
  spawn_ml_p2_player_heli();
  spawn_ml_p1_sentries();
  hoopty_truck_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "init")]]();
  }

  hoopty_truck_initspawning();
  hoopty_truck_initlate();
}

function hoopty_truck_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "initLate")]]();
    return;
  }
}

function hoopty_truck_initoccupancy() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("hoopty_truck", 1);
  var0.enterendcallback = &hoopty_truck_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &hoopty_truck_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 75;
  var0.exitextents["back"] = 105;
  var0.exitextents["left"] = 35;
  var0.exitextents["right"] = 35;
  var0.exitextents["top"] = 87;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (58, 0, 55);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (17, 16, 73);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-78, 16, 73);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-78, -16, 73);
  var0.exitdirections[var1] = "back";
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "driver");
}

function hoopty_truck_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("hoopty_truck", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function spawn_ml_p2_player_heli() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("hoopty_truck", 1);
  var0.id = 12;
  var0.seatids["driver"] = 0;
  var0.seatids["front_right"] = 1;
  var0.seatids["front_left_rear"] = 2;
  var0.seatids["front_right_rear"] = 3;
  var0.seatids["back_left_rear"] = 4;
  var0.seatids["back_right_rear"] = 5;
}

function spawn_ml_p1_sentries() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("hoopty_truck", 1000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("hoopty_truck");
  var0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("hoopty_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("hoopty_truck", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("hoopty_truck", &hoopty_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("hoopty_truck_mp", 3);
}

function hoopty_truck_initfx() {
  level._effect["hoopty_truck_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function hoopty_truck_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_zuniform_physics";
  var0.targetname = "hoopty_truck";
  var0.vehicletype = "zuniform_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "hoopty_truck", var0);
  var2.objweapon = getcompleteweaponname("hoopty_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "create")]](var2);
  }

  return var2;
}

function hoopty_truck_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "hoopty_truck_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hoopty_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "hoopty_truck_mp");
    playFX(scripts\engine\utility::getfx("hoopty_truck_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function hoopty_truck_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function hoopty_truck_deathcallback(var0) {
  thread hoopty_truck_explode(var0);
  return true;
}

function hoopty_truck_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    hoopty_truck_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function hoopty_truck_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function hoopty_truck_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    hoopty_truck_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function hoopty_truck_exitendinternal(var0, var1, var2, var3, var4) {
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

function hoopty_truck_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty_truck", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &hoopty_truck_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty_truck", "spawnCallback");
  var0.clearancecheckradius = 110;
  var0.clearancecheckheight = 90;
  var0.clearancecheckminradius = 110;
}

function hoopty_truck_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("hooptytruck_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}