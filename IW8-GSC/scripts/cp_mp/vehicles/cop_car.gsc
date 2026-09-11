/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cop_car.gsc
***********************************************/

function cop_car_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cop_car", 1);
  var0.destroycallback = &cop_car_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cop_car", 1);
  var0.enterendcallback = &cop_car_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &cop_car_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var0.exitextents["front"] = 103;
  var0.exitextents["back"] = 103;
  var0.exitextents["left"] = 40;
  var0.exitextents["right"] = 40;
  var0.exitextents["top"] = 60;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (75, 0, 48);
  var0.exitdirections[var1] = "front";
  var1 = "back";
  var0.exitoffsets[var1] = (-75, 0, 48);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "fr", "br", "bl"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "bl", "back", "fr", "front"];
  var0.exitoffsets[var3] = (7, 14, 48);
  var0.exitdirections[var3] = "left";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.damagemodifier = 0.5;
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "fr";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "br", "back", "driver", "front"];
  var0.exitoffsets[var3] = (7, -14, 48);
  var0.exitdirections[var3] = "right";
  var4.damagemodifier = 0.5;
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "bl";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "driver", "back", "br", "front"];
  var0.exitoffsets[var3] = (-28, 14, 48);
  var0.exitdirections[var3] = "left";
  var4.damagemodifier = 0.5;
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "br";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cop_car", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "fr", "back", "bl", "front"];
  var0.exitoffsets[var3] = (-28, -14, 48);
  var0.exitdirections[var3] = "right";
  var4.damagemodifier = 0.5;
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
}

function cop_car_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cop_car", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["fr"] = ["fr"];
  var0.seatenterarrays["bl"] = ["bl"];
  var0.seatenterarrays["br"] = ["br"];
}

function ignoreattractions() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cop_car", 1);
  var0.id = 6;
  var0.seatids["driver"] = 0;
  var0.seatids["fr"] = 1;
  var0.seatids["bl"] = 2;
  var0.seatids["br"] = 3;
}

function ignoreafkcheck() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cop_car", 1000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cop_car");
  var0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cop_car");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cop_car", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cop_car", &cop_car_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cop_car_mp", 3);
}

function cop_car_initfx() {
  level._effect["cop_car_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function cop_car_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_skilo_rus_police_physics_mp";
  var0.targetname = "cop_car";
  var0.vehicletype = "skilo_police_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "cop_car", var0);
  var2.objweapon = getcompleteweaponname("cop_car_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cop_car", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "create")]](var2);
  }

  return var2;
}

function cop_car_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "cop_car_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cop_car_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "cop_car_mp");
    playFX(scripts\engine\utility::getfx("cop_car_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function cop_car_deathcallback(var0) {
  thread cop_car_explode(var0);
  return true;
}

function cop_car_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    cop_car_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function cop_car_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function cop_car_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    cop_car_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function cop_car_exitendinternal(var0, var1, var2, var3, var4) {
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

function cop_car_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &cop_car_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cop_car", "spawnCallback");
  var0.clearancecheckradius = 100;
  var0.clearancecheckheight = 60;
  var0.clearancecheckminradius = 100;
}

function cop_car_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("copcar_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}