/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cop_car.gsc
***********************************************/

function cop_car_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cop_car", 1);
  var_0.destroycallback = &cop_car_explode;
  cop_car_initoccupancy();
  cop_car_initinteract();
  ignoreattractions();
  ignoreafkcheck();
  cop_car_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "init")]]();
  }

  cop_car_initspawning();
  cop_car_initlate();
}

function cop_car_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "initLate")]]();
    return;
  }
}

function cop_car_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cop_car", 1);
  var_0.enterendcallback = &cop_car_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &cop_car_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var_0.exitextents["front"] = 103;
  var_0.exitextents["back"] = 103;
  var_0.exitextents["left"] = 40;
  var_0.exitextents["right"] = 40;
  var_0.exitextents["top"] = 60;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (75, 0, 48);
  var_0.exitdirections[var_1] = "front";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-75, 0, 48);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "fr", "br", "bl"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "bl", "back", "fr", "front"];
  var_0.exitoffsets[var_3] = (7, 14, 48);
  var_0.exitdirections[var_3] = "left";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "fr";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "br", "back", "driver", "front"];
  var_0.exitoffsets[var_3] = (7, -14, 48);
  var_0.exitdirections[var_3] = "right";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "tag_seat_1";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "bl";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "driver", "back", "br", "front"];
  var_0.exitoffsets[var_3] = (-28, 14, 48);
  var_0.exitdirections[var_3] = "left";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "br";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "fr", "back", "bl", "front"];
  var_0.exitoffsets[var_3] = (-28, -14, 48);
  var_0.exitdirections[var_3] = "right";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
}

function cop_car_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cop_car", 1);
  var_0.seatenterarrays["driver"] = ["driver"];
  var_0.seatenterarrays["fr"] = ["fr"];
  var_0.seatenterarrays["bl"] = ["bl"];
  var_0.seatenterarrays["br"] = ["br"];
}

function ignoreattractions() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cop_car", 1);
  var_0.id = 6;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fr"] = 1;
  var_0.seatids["bl"] = 2;
  var_0.seatids["br"] = 3;
}

function ignoreafkcheck() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cop_car", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cop_car");
  var_0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cop_car");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cop_car", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cop_car", &cop_car_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cop_car_mp", 3);
}

function cop_car_initfx() {
  level._effect["cop_car_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function cop_car_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_skilo_rus_police_physics_mp";
  var_0.targetname = "cop_car";
  var_0.vehicletype = "skilo_police_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "cop_car", var_0);
  var_2.objweapon = getcompleteweaponname("cop_car_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "create")]](var_2);
  }

  return var_2;
}

function cop_car_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cop_car_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cop_car_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cop_car_mp");
    playFX(scripts\engine\utility::getfx("cop_car_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function cop_car_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function cop_car_deathcallback(var_0) {
  thread cop_car_explode(var_0);
  return true;
}

function cop_car_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    cop_car_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function cop_car_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function cop_car_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    cop_car_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function cop_car_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function cop_car_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &cop_car_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "spawnCallback");
  var_0.clearancecheckradius = 100;
  var_0.clearancecheckheight = 60;
  var_0.clearancecheckminradius = 100;
}

function cop_car_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("copcar_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}