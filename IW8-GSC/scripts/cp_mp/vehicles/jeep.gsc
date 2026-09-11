/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\jeep.gsc
***********************************************/

function jeep_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("jeep", 1);
  var0.destroycallback = &jeep_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("jeep", 1);
  var0.enterendcallback = &jeep_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &jeep_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var0.exitextents["front"] = 105;
  var0.exitextents["back"] = 105;
  var0.exitextents["left"] = 44;
  var0.exitextents["right"] = 44;
  var0.exitextents["top"] = 90;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (75, 0, 65);
  var0.exitdirections[var1] = "front";
  var1 = "back";
  var0.exitoffsets[var1] = (-90, 0, 65);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "front_right", "back_right", "back_left"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left", "back", "front_right", "front"];
  var0.exitoffsets[var3] = (17, 19, 65);
  var0.exitdirections[var3] = "left";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "front_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_right", "back", "driver", "front"];
  var0.exitoffsets[var3] = (17, -19, 65);
  var0.exitdirections[var3] = "right";
  var4.viewclamps["top"] = 27;
  var4.viewclamps["bottom"] = 42;
  var4.viewclamps["left"] = 105;
  var4.viewclamps["right"] = 117;
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.hidestowedweapon = 1;
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "front_right", "back", "back_left", "front"];
  var0.exitoffsets[var3] = (-24, -19, 65);
  var0.exitdirections[var3] = "right";
  var4.viewclamps["top"] = 27;
  var4.viewclamps["bottom"] = 42;
  var4.viewclamps["left"] = 101;
  var4.viewclamps["right"] = 122;
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.hidestowedweapon = 1;
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_left";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("jeep", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "driver", "back", "back_right", "front"];
  var0.exitoffsets[var3] = (-24, 19, 65);
  var0.exitdirections[var3] = "left";
  var4.viewclamps["top"] = 27;
  var4.viewclamps["bottom"] = 42;
  var4.viewclamps["left"] = 122;
  var4.viewclamps["right"] = 101;
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.hidestowedweapon = 1;
  var4.ref_12023 = "ping_vehicle_rider";
}

function jeep_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("jeep", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("jeep", "single", ["driver", "front_right", "back_left", "back_right"]);
}

function vehicle_damage_getheavystatemaxhealth() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("jeep", 1);
  var0.id = 10;
  var0.seatids["driver"] = 0;
  var0.seatids["front_right"] = 1;
  var0.seatids["back_left"] = 2;
  var0.seatids["back_right"] = 3;
}

function vehicle_damage_getheavystatehealthadd() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("jeep", 1500);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("jeep");
  var0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("jeep");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("jeep", 9);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("jeep", &jeep_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("jeep_mp", 3);
}

function vehicle_damage_getburndowntime() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("jeep", 1);
  var0.challengeevaluator = 1.33333;
  var0.keycardlocs_chosen = 0.91666;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 10;
  var0.isallowedweapon = 40;
  var0.isakimbo = 80;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function jeep_initfx() {
  level._effect["jeep_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");
}

function jeep_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

  if(var2) {
    var0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp_wz";
  } else {
    var0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
  }

  var0.targetname = "jeep";
  var0.vehicletype = "decho_physics_mp";
  var3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var3, "jeep", var0);
  var3.objweapon = getcompleteweaponname("jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var3, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "create")]](var3);
  }

  return var3;
}

function vehicle_damage_enginevisualcallback(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
  var0.targetname = "jeep";
  var0.vehicletype = "decho_physics_nitrous_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "jeep", var0);
  var2.objweapon = getcompleteweaponname("jeep_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "create")]](var2);
  }

  return var2;
}

function jeep_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "jeep_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread jeep_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "jeep_mp");
    playFX(scripts\engine\utility::getfx("jeep_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function jeep_deathcallback(var0) {
  thread jeep_explode(var0);
  return true;
}

function jeep_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    jeep_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function jeep_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function jeep_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    jeep_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function jeep_exitendinternal(var0, var1, var2, var3, var4) {
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

function jeep_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &jeep_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("jeep", "spawnCallback");
  var0.clearancecheckradius = 105;
  var0.clearancecheckheight = 90;
  var0.clearancecheckminradius = 105;
}

function jeep_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("jeep_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}