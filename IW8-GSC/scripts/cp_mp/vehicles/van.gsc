/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\van.gsc
***********************************************/

function van_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("van", 1);
  var_0.destroycallback = &van_explode;
  van_initoccupancy();
  van_initinteract();
  ref_140e7();
  ref_140e6();
  van_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "init")]]();
  }

  van_initspawning();
  van_initlate();
}

function van_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "initLate")]]();
    return;
  }
}

function van_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("van", 1);
  var_0.enterendcallback = &van_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &van_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 130;
  var_0.exitextents["back"] = 117;
  var_0.exitextents["left"] = 55;
  var_0.exitextents["right"] = 55;
  var_0.exitextents["top"] = 105;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (98, 0, 65);
  var_0.exitdirections[var_1] = "front";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-64, 20, 78);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-64, -20, 78);
  var_0.exitdirections[var_1] = "back";
  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "driver");
}

function van_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("van", 1);
  var_0.seatenterarrays["driver"] = ["driver"];
  var_0.seatenterarrays["front_right"] = ["front_right"];
  var_0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var_0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var_0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var_0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function ref_140e7() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("van", 1);
  var_0.id = 13;
  var_0.seatids["driver"] = 0;
  var_0.seatids["front_right"] = 1;
  var_0.seatids["front_left_rear"] = 2;
  var_0.seatids["front_right_rear"] = 3;
  var_0.seatids["back_left_rear"] = 4;
  var_0.seatids["back_right_rear"] = 5;
}

function ref_140e6() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("van", 1350);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("van");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("van");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("van", 8);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("van", &van_deathcallback);
}

function van_initfx() {
  level._effect["van_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function van_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_palfa_windows_east_physics_tan_mp";
  var_0.targetname = "van";
  var_0.vehicletype = "palfa_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "van", var_0);
  var_2.objweapon = getcompleteweaponname("van_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "create")]](var_2);
  }

  return var_2;
}

function van_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "van_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread van_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "van_mp");
    playFX(scripts\engine\utility::getfx("van_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function van_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function van_deathcallback(var_0) {
  thread van_explode(var_0);
  return true;
}

function van_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    van_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function van_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function van_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    van_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function van_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function van_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &van_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("van", "spawnCallback");
  var_0.clearancecheckradius = 130;
  var_0.clearancecheckheight = 105;
  var_0.clearancecheckminradius = 130;
}

function van_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("van_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}