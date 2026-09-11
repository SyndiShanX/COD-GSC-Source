/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58238.gsc
***********************************************/

function ref_12102() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("open_jeep", 1);
  var_0.destroycallback = &ref_12100;
  ref_12108();
  ref_12106();
  ref_12109();
  ref_12104();
  ref_12103();
  ref_12105();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "init")]]();
  }

  ref_1210a();
  ref_12107();
}

function ref_12107() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "initLate")]]();
    return;
  }
}

function ref_12108() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("open_jeep", 1);
  var_0.enterendcallback = &ref_120fc;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &ref_120fe;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 85;
  var_0.exitextents["back"] = 82;
  var_0.exitextents["left"] = 34;
  var_0.exitextents["right"] = 34;
  var_0.exitextents["top"] = 82;
  var_0.exitextents["bottom"] = 0;
  var_0.exitoffsets["front"] = (58, 0, 55);
  var_0.exitdirections["front"] = "front";
  var_0.exitoffsets["back"] = (-65, 0, 65);
  var_0.exitdirections["back"] = "back";
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "driver");
}

function ref_12106() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("open_jeep", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("open_jeep", "single", ["driver", "fr_passenger", "bl_passenger", "br_passenger"]);
}

function ref_12109() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("open_jeep", 1);
  var_0.id = 22;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fr_passenger"] = 1;
  var_0.seatids["bl_passenger"] = 2;
  var_0.seatids["br_passenger"] = 3;
}

function ref_12104() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("open_jeep", 750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("open_jeep");
  var_0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("open_jeep");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("open_jeep", 5);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("open_jeep", 8, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("open_jeep", &ref_120fa);
}

function ref_12103() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("open_jeep", 1);
  var_0.challengeevaluator = 1.83333;
  var_0.keycardlocs_chosen = 0.79166;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 6.25;
  var_0.isallowedweapon = 25;
  var_0.isakimbo = 50;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function ref_12105() {
  level._effect["open_jeep_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_jo_death_exp.vfx");
}

function ref_120f9(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_lnd_m151";
  var_0.targetname = "open_jeep";
  var_0.vehicletype = "open_jeep_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "open_jeep", var_0);
  var_2.objweapon = getcompleteweaponname("open_jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread ref_12110(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "create")]](var_2);
  }

  return var_2;
}

function ref_12110(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  level endon("game_ended");

  if(isDefined(var_3)) {
    var_0 endon(var_3);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      if(!isDefined(var_5)) {
        var_5 = gettime() + 3000;
      }

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var_0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1)) {
        GscBinSkip1(0x74, var_1, var_0);
      }

      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var_0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2)) {
        GscBinSkip1(0x74, var_2, var_0, var_9);
      }
    }

    waitframe();
  }
}

function ref_12100(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "open_jeep_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread ref_120fb();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "open_jeep_mp");
    playFX(scripts\engine\utility::getfx("open_jeep_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function ref_120fb() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function ref_120fa(var_0) {
  thread ref_12100(var_0);
  return true;
}

function ref_120fc(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    ref_120fd(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function ref_120fd(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function ref_120fe(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    ref_120ff(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function ref_120ff(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(var_1 == "driver") {
      var_3 controlsunlink();
    }

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

function ref_1210a() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &ref_12101;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "spawnCallback");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 82;
  var_0.clearancecheckminradius = 120;
}

function ref_12101() {
  var_0 = scripts\engine\utility::getStructArray("openjeep_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}