/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\jeep.gsc
***********************************************/

function jeep_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("jeep", 1);
  var_0.destroycallback = &jeep_explode;
  jeep_initoccupancy();
  jeep_initinteract();
  vehicle_damage_getheavystatemaxhealth();
  vehicle_damage_getheavystatehealthadd();
  vehicle_damage_getburndowntime();
  jeep_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "init")]]();
  }

  jeep_initspawning();
  jeep_initlate();
}

function jeep_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "initLate")]]();
    return;
  }
}

function jeep_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("jeep", 1);
  var_0.enterendcallback = &jeep_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &jeep_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var_0.exitextents["front"] = 105;
  var_0.exitextents["back"] = 105;
  var_0.exitextents["left"] = 44;
  var_0.exitextents["right"] = 44;
  var_0.exitextents["top"] = 90;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (75, 0, 65);
  var_0.exitdirections[var_1] = "front";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-90, 0, 65);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "front_right", "back_right", "back_left"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_left", "back", "front_right", "front"];
  var_0.exitoffsets[var_3] = (17, 19, 65);
  var_0.exitdirections[var_3] = "left";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "front_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_right", "back", "driver", "front"];
  var_0.exitoffsets[var_3] = (17, -19, 65);
  var_0.exitdirections[var_3] = "right";
  var_4.viewclamps["top"] = 27;
  var_4.viewclamps["bottom"] = 42;
  var_4.viewclamps["left"] = 105;
  var_4.viewclamps["right"] = 117;
  var_4.animtag = "tag_seat_1";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "front_right", "back", "back_left", "front"];
  var_0.exitoffsets[var_3] = (-24, -19, 65);
  var_0.exitdirections[var_3] = "right";
  var_4.viewclamps["top"] = 27;
  var_4.viewclamps["bottom"] = 42;
  var_4.viewclamps["left"] = 101;
  var_4.viewclamps["right"] = 122;
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "driver", "back", "back_right", "front"];
  var_0.exitoffsets[var_3] = (-24, 19, 65);
  var_0.exitdirections[var_3] = "left";
  var_4.viewclamps["top"] = 27;
  var_4.viewclamps["bottom"] = 42;
  var_4.viewclamps["left"] = 122;
  var_4.viewclamps["right"] = 101;
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4.ref_12023 = "ping_vehicle_rider";
}

function jeep_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("jeep", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("jeep", "single", ["driver", "front_right", "back_left", "back_right"]);
}

function vehicle_damage_getheavystatemaxhealth() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("jeep", 1);
  var_0.id = 10;
  var_0.seatids["driver"] = 0;
  var_0.seatids["front_right"] = 1;
  var_0.seatids["back_left"] = 2;
  var_0.seatids["back_right"] = 3;
}

function vehicle_damage_getheavystatehealthadd() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("jeep", 1500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("jeep");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("jeep");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("jeep", 9);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("jeep", &jeep_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("jeep_mp", 3);
}

function vehicle_damage_getburndowntime() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("jeep", 1);
  var_0.challengeevaluator = 1.33333;
  var_0.keycardlocs_chosen = 0.91666;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 10;
  var_0.isallowedweapon = 40;
  var_0.isakimbo = 80;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function jeep_initfx() {
  level._effect["jeep_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");
}

function jeep_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = scripts\cp_mp\utility\script_utility::ref_140DE("game", "isGameTypeBR", 0);

  if(var_2) {
    var_0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp_wz";
  } else {
    var_0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
  }

  var_0.targetname = "jeep";
  var_0.vehicletype = "decho_physics_mp";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_3, "jeep", var_0);
  var_3.objweapon = getcompleteweaponname("jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "create")]](var_3);
  }

  return var_3;
}

function vehicle_damage_enginevisualcallback(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
  var_0.targetname = "jeep";
  var_0.vehicletype = "decho_physics_nitrous_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "jeep", var_0);
  var_2.objweapon = getcompleteweaponname("jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "create")]](var_2);
  }

  return var_2;
}

function jeep_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "jeep_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread jeep_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "jeep_mp");
    playFX(scripts\engine\utility::getfx("jeep_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function jeep_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function jeep_deathcallback(var_0) {
  thread jeep_explode(var_0);
  return true;
}

function jeep_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function jeep_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function jeep_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &jeep_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "spawnCallback");
  var_0.clearancecheckradius = 105;
  var_0.clearancecheckheight = 90;
  var_0.clearancecheckminradius = 105;
}

function jeep_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("jeep_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}