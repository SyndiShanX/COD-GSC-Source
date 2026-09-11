/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle.gsc
***********************************************/

function vehicle_init() {
  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

  level.vehicle.vehicledata = [];
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "init")]]();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_init();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_init();
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
  scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_init();
  _calloutmarkerping_predicted_timeout::ref_14125();
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
  _calloutmarkerping_predicted_log::ref_14114();
  scripts\cp_mp\vehicles\apc_rus::apc_rus_init();
  scripts\cp_mp\vehicles\atv::atv_init();
  scripts\cp_mp\vehicles\cargo_truck::cargo_truck_init();
  _calloutmarkerping_isdropcrate::get_intel_location_vo();
  scripts\cp_mp\vehicles\cop_car::cop_car_init();
  scripts\cp_mp\vehicles\hoopty::hoopty_init();
  scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_init();
  scripts\cp_mp\vehicles\technical::technical_init();
  scripts\cp_mp\vehicles\light_tank::light_tank_init();
  scripts\cp_mp\vehicles\little_bird::little_bird_init();
  _calloutmarkerping_poolidisdanger::x1stash_removequestinstance();
  scripts\cp_mp\vehicles\tac_rover::tac_rover_init();
  scripts\cp_mp\vehicles\large_transport::large_transport_init();
  scripts\cp_mp\vehicles\pickup_truck::pickup_truck_init();
  scripts\cp_mp\vehicles\jeep::jeep_init();
  scripts\cp_mp\vehicles\med_transport::med_transport_init();
  scripts\cp_mp\vehicles\van::van_init();
  _calloutmarkerping_poolidisentity::ref_11d60();
  _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gulag_think();
  _calloutmarkerping_handleluinotify_mappingdeletemarker::bomber_init();
  _calloutmarkerping_isenemy::get_priority_player();
  _calloutmarkerping_iskiosk::get_num_of_wire_to_cut();
  _calloutmarkerping_poolidisloot::ref_12102();
  _calloutmarkerping_predicted_isanypingactive::ref_120d2();
  _calloutmarkerping_isplunderextract::hvi_vehicle_rider_special_setup();
  _calloutmarkerping_onpingchallenge::startarmsracedef2obj();
}

function isvehicle() {
  return isDefined(self.vehiclename);
}

function isvehicledestroyed() {
  return istrue(self.isdestroyed);
}

function vehiclecanfly() {
  var0 = vehicle_getleveldataforvehicle(self.vehiclename);

  if(isDefined(var0)) {
    return istrue(var0.canfly);
  }

  return undefined;
}

function vehicle_getleveldataforvehicle(var0, var1) {
  var2 = level.vehicle.vehicledata[var0];

  if(!isDefined(var2)) {
    if(istrue(var1)) {
      var2 = spawnStruct();
      level.vehicle.vehicledata[var0] = var2;
      var2.ref_13fca = undefined;
      var2.destroycallback = undefined;
      var2.canfly = undefined;
    }
  }

  return var2;
}

function ref_14138(var0, var1, var2) {
  var0.maxhealth = 2147483647;
  var0.health = var0.maxhealth;
  var0.vehiclename = var1;
  var0 setnodeploy(1);
  var0 makeunusable();

  if(isDefined(var2.owner)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setoriginalowner(var0, var2.owner);
  }

  if(isDefined(var2.team)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var0, var2.team);
  } else {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var0, "neutral");
  }

  var0 scripts\cp_mp\emp_debuff::set_start_emp_callback(&vehicle_empstartcallback);
  var0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&vehicle_empclearcallback);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var0, &vehicle_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var0, &vehicle_lockedonremovedcallback);
  scripts\cp_mp\utility\weapon_utility::ref_13162(var0, &ref_1419a);
  scripts\cp_mp\utility\weapon_utility::ref_13163(var0, &ref_1419b);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var0);

  if(!scripts\common\utility::iscp() || !istrue(var2.disableusabilityatspawn)) {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "create")]](var0, var2);
  }

  thread ref_14226(var0);
}

function ref_14139(var0, var1) {
  var0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var0, var1.owner, var1.team);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var0, var1.spawntype);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "createLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "createLate")]](var0, var1);
    return;
  }
}

function ref_14185(var0) {
  if(isDefined(var0) && istrue(var0.isdestroyed)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(level.ref_1425a) && isDefined(var0.ref_12970)) {
    GscBinSkip1(0x74, level.ref_1425a, var0, var0.ref_12970);
  }

  var0 notify("death");
  var0.isdestroyed = 1;

  if(isDefined(var0.ondeathrespawn)) {
    var0 thread[[var0.ondeathrespawn]]();
  }

  var0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var0 setnonstick(1);
  scripts\cp_mp\utility\weapon_utility::clearlockedon(var0);
  var0 scripts\cp_mp\emp_debuff::clear_emp(1);
  _calloutmarkerping_predicted_timeout::ref_14123(var0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14141(var0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var0);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrame")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrame")]](var0);
    return;
  }
}

function ref_14186(var0) {
  if(!isDefined(var0)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(var0);
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_deregisterinstance(var0.vehiclename, var0 getentitynumber());

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrameLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrameLate")]](var0);
  }

  var1 = ref_14193(var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var3 delete();
    }
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var0);
}

function ref_14197(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "hide")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "hide")]](var0);
  }

  var1 = ref_14193(var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var3 hide();
    }
  }

  var0 hide();
}

function ref_14226(var0) {
  level endon("game_ended");
  var1 = vehicle_getleveldataforvehicle(var0.vehiclename);
  thread _calloutmarkerping_predicted_log::ref_1411b(var0);

  while(isDefined(var0)) {
    var2 = spawnStruct();
    scripts\cp_mp\utility\vehicle_omnvar_utility::ref_14282(var0);
    ref_14103(var0);

    if(isDefined(var1.ref_13fca)) {
      var0[[var1.ref_13fca]](var2);
    }

    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_1424b();
    waitframe();
  }
}

function ref_14105(var0) {
  if(isDefined(var0.ref_1426c)) {
    if(var0.ref_1426c != "") {
      var1 = var0 vehicle_getvelocity();
      var2 = anglesToForward(var0.angles);

      if(vectordot(var1, var2) >= 0) {
        if(var0 getscriptableparthasstate("trail", var0.ref_1426c)) {
          var0 setscriptablepartstate("trail", var0.ref_1426c);
          return;
        }

        return;
      }

      if(var0 getscriptableparthasstate("trail", var0.ref_1426c + "_idle")) {
        var0 setscriptablepartstate("trail", var0.ref_1426c + "_idle");
        return;
      }

      return;
    }

    return;
  }
}

function ref_14103(var0) {
  if(!var0 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !istrue(vehiclecanfly(var0)) && !var0 vehicle_isonground()) {
    var1 = var0 vehicle_getvelocity();

    if(var1[2] >= 75 && length2dsquared(var1) <= 100) {
      if(!isDefined(var0.ref_12289)) {
        var0.ref_12289 = gettime();
      }

      if(gettime() - var0.ref_12289 >= 650) {
        var2 = (128, 128, 128);
        var3 = var0.origin - var2;
        var4 = var0.origin + var2;
        var5 = physics_aabbbroadphasequery(var3, var4, physics_createcontents(["physicscontents_vehicle"]), var0);

        foreach(var7 in var5) {
          if(isDefined(var7) && var7 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks() && !istrue(var7.isdestroyed)) {
            var7 thread scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
            var0.ref_12289 = undefined;
          }
        }

        return;
      }

      return;
    }

    var7.ref_12289 = undefined;
    return;
  }

  var7.ref_12289 = undefined;
}

function ref_14207(var0, var1, var2, var3, var4) {
  if(!isDefined(var1.objweapon)) {
    var1.objweapon = var2;
  }

  if(!isDefined(var0.turrets)) {
    var0.turrets = [];
  }

  var5 = undefined;

  if(isDefined(var4)) {
    var5 = var4;
  } else if(isstring(var2)) {
    var5 = var2;
  } else {
    var5 = var2.basename;
  }

  var0.turrets[var5] = var1;
  var6 = var0.childoutlineents;

  if(!isDefined(var6)) {
    var6 = [var0];
  }

  if(!scripts\engine\utility::array_contains(var6, var1)) {
    var6 = scripts\engine\utility::array_add(var6, var1);
  }

  var0.childoutlineents = var6;

  if(istrue(var3)) {
    thread ref_14221(var0, var1);
    return;
  }
}

function ref_14188(var0, var1) {
  if(!isDefined(var0.turrets)) {
    return;
  }

  var2 = undefined;

  if(isstring(var1)) {
    var2 = var1;
  } else {
    var2 = var1.basename;
  }

  var3 = var0.turrets[var2];
  var0.turrets[var2] = undefined;

  if(isDefined(var3)) {
    var4 = var0.childoutlineents;

    if(isDefined(var4)) {
      var4 = scripts\engine\utility::array_remove(var4, var3);
      var0.childoutlineents = var4;
    }

    var3 notify("vehicle_trackTurretProjectile");
    return;
  }
}

function ref_14192(var0, var1) {
  if(!isDefined(var0.turrets)) {
    return undefined;
  }

  var2 = undefined;

  if(isstring(var1)) {
    var2 = var1;
  } else {
    var2 = var1.basename;
  }

  return var0.turrets[var2];
}

function ref_14191(var0, var1) {
  if(!isDefined(var0.turrets)) {
    return undefined;
  }

  return var0.turrets[var1];
}

function ref_14193(var0) {
  var1 = [];

  if(isDefined(var0.turrets)) {
    var1 = var0.turrets;
  }

  return var1;
}

function ref_14221(var0, var1) {
  var1 endon("death");
  var1 notify("vehicle_trackTurretProjectile");
  var1 endon("vehicle_trackTurretProjectile");

  for(;;) {
    var1 waittill("missile_fire", var2);

    if(isDefined(var2)) {
      var2.vehicle = var0;
    }
  }
}

function ref_141b9(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e2(var0, var1);
  }

  if(level.teambased) {
    var2 = var0.team;

    if(!isDefined(var2) || var2 == "neutral") {
      if(isDefined(var0.owner)) {
        var0.team = var0.owner.team;
      }
    }

    if(!isDefined(var2)) {
      return 0;
    }

    return (var0.team == var1.team);
  }

  return isDefined(var1.owner) && var1.owner == var2;
}

function ref_141b7(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e0(var0, var1);
  }

  if(level.teambased) {
    var2 = var0.team;

    if(!isDefined(var2) || var2 == "neutral") {
      if(isDefined(var0.owner)) {
        var0.team = var0.owner.team;
      }
    }

    if(!isDefined(var2)) {
      return 0;
    }

    return (var0.team == var1.team);
  }

  return isDefined(var1.owner) && var1.owner != var2;
}

function ref_141bb(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e4(var0, var1);
  }

  if(level.teambased) {
    return ((!isDefined(var0.team) || var0.team == "neutral") && !isDefined(var0.owner));
  }

  return !isDefined(var0.owner);
}

function ref_141ba(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e3(var0, var1);
  }

  if(level.teambased) {
    return (isDefined(var0.team) && var0.team == var1);
  }

  return undefined;
}

function ref_141b8(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e1(var0, var1);
  }

  if(level.teambased) {
    return (isDefined(var0.team) && var0.team != var1);
  }

  return undefined;
}

function ref_141bc(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e5(var0, var1);
  }

  if(level.teambased) {
    return (!isDefined(var0.team) || var0.team == "neutral");
  }

  return undefined;
}

function ref_14190(var0) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var0)) {
    return scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d7(var0);
  }

  if(isDefined(var0.team) && var0.team != "neutral") {
    return var0.team;
  }

  return undefined;
}

function ref_1418b(var0, var1) {
  if(ref_1420d(var0, var1)) {
    var2 = istrue(var1.inlaststand);
    var3 = var1.health;

    if(isDefined(var0.objweapon)) {
      level.ref_12185 = "MOD_EXPLOSIVE";
    }

    var1 dodamage(1000, var0.origin, var0.owner, var0, "MOD_CRUSH", var0.objweapon);
    level.ref_12185 = undefined;

    if(!isalive(var1)) {
      return true;
    }

    if(!var2 && istrue(var1.inlaststand)) {
      return true;
    }

    if(var3 > var1.health) {
      return true;
    }
  }

  return false;
}

function ref_1420d(var0, var1) {
  if(level.teambased) {
    if(level.friendlyfire == 0) {
      if(isDefined(var0.owner)) {
        if(var0.owner != var1) {
          if(var0.owner.team == var1.team) {
            return false;
          }
        }
      } else if(isDefined(var0.team) && var0.team != "neutral") {
        if(var0.team == var1.team) {
          return false;
        }
      }
    }
  }

  return true;
}

function ref_14203(var0, var1) {
  var1 endon("disconnect");
  var1 notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  var1 endon("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  var1.vehiclecollisionignorearray = [];
  var1.vehiclecollisionignorearray["inflictor"] = var0;
  var1.vehiclecollisionignorearray["objWeapon"] = var0.objweapon;
  var1.vehiclecollisionignorearray["meansOfDeath"] = "MOD_CRUSH";
  ref_14204(var1);
  thread ref_14106(var1);
}

function ref_14204(var0) {
  var0 endon("death");
  wait 2;
}

function ref_14106(var0) {
  var0 notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  var0.vehiclecollisionignorearray = undefined;
}

function ref_14201(var0, var1, var2, var3) {
  if(!isDefined(var1.vehiclecollisionignorearray)) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(var0 != var1.vehiclecollisionignorearray["inflictor"]) {
    return false;
  }

  if(!isDefined(var3)) {
    return false;
  }

  if(!scripts\common\utility::iscp()) {
    if(var3 != var1.vehiclecollisionignorearray["objWeapon"]) {
      return false;
    }
  }

  if(var2 != var1.vehiclecollisionignorearray["meansOfDeath"]) {
    return false;
  }

  return true;
}

function ref_14104(var0) {
  if(!isDefined(var0.meansofdeath) || var0.meansofdeath != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(var0.inflictor) || !isvehicle(var0.inflictor)) {
    return false;
  }

  return true;
}

function vehicle_playerkilledbycollision(var0) {
  if(!ref_14104(var0)) {
    return;
  }

  if(var0.inflictor.vehiclename == "little_bird" || var0.inflictor.vehiclename == "little_bird_mg" || var0.inflictor.vehiclename == "loot_chopper" || var0.inflictor.vehiclename == "magma_plunder_chopper") {
    thread ref_14200(var0.victim);
    return;
  }

  playsoundatpos(var0.victim.origin, "vehicle_body_hit");
}

function ref_14200(var0) {
  var1 = 35;
  var0.nocorpse = 1;
  playsoundatpos(var0.origin, "vehicle_body_hit");
  var2 = scripts\cp_mp\utility\player_utility::relic_nuketimer_timer();

  if(var2.size < var1) {
    var3 = spawn("script_model", var0 gettagorigin("j_mainroot"));
    var3.angles = var0.angles;
    var3 setModel("player_death_fx");
    var3 setscriptablepartstate("effects", "gib", 0);

    foreach(var5 in var2) {
      var3 hidefromplayer(var5);
    }

    wait 0.5;
    var3 delete();
    return;
  }
}

function vehicle_watchflipped(var0, var1, var2, var3) {
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
      var7 = 1;
      var5 = undefined;
    } else if(var8 <= 0.5736) {
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
        if(vectordot(anglestoup(var0.angles), (0, 0, 1)) > 0.0872) {
          break;
        }

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

function vehicle_flippedendcallback(var0, var1) {
  if(var1) {
    var2 = vehicle_getleveldataforvehicle(var0.vehiclename);

    if(isDefined(var2.destroycallback)) {
      var0[[var2.destroycallback]]();
      return;
    }

    return;
  }
}

function vehicle_deletecollmapvehicles() {
  level notify("vehicle_deleteCollmapVehicles");
  level endon("vehicle_deleteCollmapVehicles");
  wait 1;
  var0 = getEntArray("delete_me", "targetname");

  if(isDefined(var0) && var0.size > 0) {
    for(var1 = var0.size - 1; var1 >= 0; var1--) {
      var0[var1] delete();
    }

    return;
  }
}

function vehicle_lockedoncallback() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", var0, self.vehiclename);
}

function vehicle_lockedonremovedcallback() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", var0, self.vehiclename);
}

function ref_1419a() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileIncoming", var0, self.vehiclename);
}

function ref_1419b() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileIncoming", var0, self.vehiclename);
}

function vehicle_empstartcallback(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onVehicleEMPed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onVehicleEMPed")]](var0);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);
}

function vehicle_empclearcallback(var0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
}

function ref_1418f(var0) {
  var1 = undefined;

  switch (var0) {
    case "apc_russian":
      var1 = &scripts\cp_mp\vehicles\apc_rus::apc_rus_explode;
      break;
    case "atv":
      var1 = &scripts\cp_mp\vehicles\atv::atv_explode;
      break;
    case "cargo_truck":
      var1 = &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode;
      break;
    case "cargo_truck_mg":
      var1 = &_calloutmarkerping_isdropcrate::get_gunshot_alias;
      break;
    case "cop_car":
      var1 = &scripts\cp_mp\vehicles\cop_car::cop_car_explode;
      break;
    case "hoopty":
      var1 = &scripts\cp_mp\vehicles\hoopty::hoopty_explode;
      break;
    case "hoopty_truck":
      var1 = &scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_explode;
      break;
    case "jeep":
      var1 = &scripts\cp_mp\vehicles\jeep::jeep_explode;
      break;
    case "large_transport":
      var1 = &scripts\cp_mp\vehicles\large_transport::large_transport_explode;
      break;
    case "light_tank":
      var1 = &scripts\cp_mp\vehicles\light_tank::light_tank_explode;
      break;
    case "little_bird":
      var1 = &scripts\cp_mp\vehicles\little_bird::little_bird_explode;
      break;
    case "little_bird_mg":
      var1 = &_calloutmarkerping_poolidisdanger::x1spyplane;
      break;
    case "medium_transport":
      var1 = &scripts\cp_mp\vehicles\med_transport::med_transport_explode;
      break;
    case "pickup_truck":
      var1 = &scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode;
      break;
    case "tac_rover":
      var1 = &scripts\cp_mp\vehicles\tac_rover::tac_rover_explode;
      break;
    case "technical":
      var1 = &scripts\cp_mp\vehicles\technical::technical_explode;
      break;
    case "van":
      var1 = &scripts\cp_mp\vehicles\van::van_explode;
      break;
    case "motorcycle":
      var1 = &_calloutmarkerping_poolidisentity::ref_11d5d;
      break;
    case "veh_a10fd":
      var1 = &_calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes;
      break;
    case "veh_bt":
      var1 = &_calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags;
      break;
    case "veh_indigo":
      var1 = &_calloutmarkerping_onpingchallenge::start_trap_room_combat;
      break;
    case "open_jeep":
      var1 = &_calloutmarkerping_poolidisloot::ref_12100;
      break;
    case "open_jeep_carpoc":
      var1 = &_calloutmarkerping_predicted_isanypingactive::ref_120cb;
      break;
    case "cargo_truck_susp":
      var1 = &_calloutmarkerping_isenemy::get_power_ref_from_weapon;
      break;
    case "convoy_truck":
      var1 = &_calloutmarkerping_isplunderextract::hvi_patrol_exit;
      break;
  }

  return var1;
}