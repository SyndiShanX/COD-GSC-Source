/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58238.gsc
***********************************************/

function ref_12102() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("open_jeep", 1);
  var0.destroycallback = &ref_12100;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("open_jeep", 1);
  var0.enterendcallback = &ref_120fc;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &ref_120fe;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 85;
  var0.exitextents["back"] = 82;
  var0.exitextents["left"] = 34;
  var0.exitextents["right"] = 34;
  var0.exitextents["top"] = 82;
  var0.exitextents["bottom"] = 0;
  var0.exitoffsets["front"] = (58, 0, 55);
  var0.exitdirections["front"] = "front";
  var0.exitoffsets["back"] = (-65, 0, 65);
  var0.exitdirections["back"] = "back";
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "driver");
}

function ref_12106() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("open_jeep", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("open_jeep", "single", ["driver", "fr_passenger", "bl_passenger", "br_passenger"]);
}

function ref_12109() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("open_jeep", 1);
  var0.id = 22;
  var0.seatids["driver"] = 0;
  var0.seatids["fr_passenger"] = 1;
  var0.seatids["bl_passenger"] = 2;
  var0.seatids["br_passenger"] = 3;
}

function ref_12104() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("open_jeep", 750);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("open_jeep");
  var0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("open_jeep");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("open_jeep", 5);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("open_jeep", 8, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("open_jeep", &ref_120fa);
}

function ref_12103() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("open_jeep", 1);
  var0.challengeevaluator = 1.83333;
  var0.keycardlocs_chosen = 0.79166;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 6.25;
  var0.isallowedweapon = 25;
  var0.isakimbo = 50;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function ref_12105() {
  level._effect["open_jeep_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_jo_death_exp.vfx");
}

function ref_120f9(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh_s4_mil_lnd_m151";
  var0.targetname = "open_jeep";
  var0.vehicletype = "open_jeep_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "open_jeep", var0);
  var2.objweapon = getcompleteweaponname("open_jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread ref_12110(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "create")]](var2);
  }

  return var2;
}

function ref_12110(var0, var1, var2, var3) {
  var0 endon("death");
  level endon("game_ended");

  if(isDefined(var3)) {
    var0 endon(var3);
  }

  var4 = 0;
  var5 = undefined;
  var6 = undefined;

  for(;;) {
    var7 = 0;
    var8 = anglestoup(var0.angles)[2];

    if(var8 <= 0.0872) {
      if(!isDefined(var5)) {
        var5 = gettime() + 3000;
      }

      if(gettime() > var5) {
        var7 = 1;
        var5 = undefined;
      }
    } else {
      if(var4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var0, 1);
        var4 = 0;
      }

      var7 = 0;
      var5 = undefined;
    }

    if(var7) {
      if(isDefined(var1)) {
        GscBinSkip1(0x74, var1, var0);
      }

      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var0, 0);
        var4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var0);
      var9 = 0;
      var6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var6) {
          var9 = 1;
          break;
        }

        waitframe();
      }

      var6 = undefined;

      if(isDefined(var2)) {
        GscBinSkip1(0x74, var2, var0, var9);
      }
    }

    waitframe();
  }
}

function ref_12100(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "open_jeep_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread ref_120fb();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "open_jeep_mp");
    playFX(scripts\engine\utility::getfx("open_jeep_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function ref_120fa(var0) {
  thread ref_12100(var0);
  return true;
}

function ref_120fc(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    ref_120fd(var0, var1, var2, var3, var4);
    return;
  }
}

function ref_120fd(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function ref_120fe(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    ref_120ff(var0, var1, var2, var3, var4);
    return;
  }
}

function ref_120ff(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);
  }

  if(!istrue(var4.playerdisconnect)) {
    if(var1 == "driver") {
      var3 controlsunlink();
    }

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

function ref_1210a() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &ref_12101;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "spawnCallback");
  var0.clearancecheckradius = 120;
  var0.clearancecheckheight = 82;
  var0.clearancecheckminradius = 120;
}

function ref_12101() {
  var0 = scripts\engine\utility::getStructArray("openjeep_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}