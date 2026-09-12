/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\technical.gsc
************************************************/

function technical_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("technical", 1);
  var_0.destroycallback = &technical_explode;
  technical_initoccupancy();
  technical_initinteract();
  ref_13AD7();
  ref_13AD6();
  ref_13AD5();
  technical_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "init")]]();
  }

  technical_initspawning();
  technical_initlate();
}

function technical_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "initLate")]]();
    return;
  }
}

function technical_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("technical", 1);
  var_0.enterstartcallback = &technical_enterstart;
  var_0.enterendcallback = &technical_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &technical_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 95;
  var_0.exitextents["back"] = 115;
  var_0.exitextents["left"] = 38;
  var_0.exitextents["right"] = 38;
  var_0.exitextents["top"] = 73;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (5, -14, 55);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-90, 14, 55);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-90, -14, 55);
  var_0.exitdirections[var_1] = "back";
  var_1 = "front";
  var_0.exitoffsets[var_1] = (65, 0, 55);
  var_0.exitdirections[var_1] = "front";
  var_2 = ["driver", "fr_rear", "br_rear", "bl_rear", "fl_rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.exitids = [var_3, "fl_rear", "back_left", "front_right", "front"];
  var_0.exitoffsets[var_3] = (5, 14, 55);
  var_0.exitdirections[var_3] = "left";
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "fl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "tag_seat_2";
  var_4.exitids = [var_3, "bl_rear", "back_left", "fr_rear", "front"];
  var_0.exitoffsets[var_3] = (-60, 14, 55);
  var_0.exitdirections[var_3] = "left";
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "fr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "tag_seat_4";
  var_4.exitids = [var_3, "br_rear", "back_right", "fl_rear", "front"];
  var_0.exitoffsets[var_3] = (-60, -14, 55);
  var_0.exitdirections[var_3] = "right";
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "bl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "tag_seat_3";
  var_4.exitids = [var_3, "back_left", "fl_rear", "br_rear", "front"];
  var_0.exitoffsets[var_3] = (-90, 14, 55);
  var_0.exitdirections[var_3] = "left";
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "br_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "tag_seat_5";
  var_4.exitids = [var_3, "back_right", "fr_rear", "bl_rear", "front"];
  var_0.exitoffsets[var_3] = (-90, -14, 55);
  var_0.exitdirections[var_3] = "right";
  var_4.ref_12023 = "ping_vehicle_rider";
}

function technical_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("technical", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("technical", "single", ["driver", "fl_rear", "fr_rear", "bl_rear", "br_rear"]);
}

function ref_13AD7() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("technical", 1);
  var_0.id = 0;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fl_rear"] = 1;
  var_0.seatids["fr_rear"] = 2;
  var_0.seatids["bl_rear"] = 3;
  var_0.seatids["br_rear"] = 4;
}

function ref_13AD5() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("technical", 1);
  var_0.challengeevaluator = 1.16666;
  var_0.keycardlocs_chosen = 0.95833;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 11.25;
  var_0.isallowedweapon = 45;
  var_0.isakimbo = 90;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function ref_13AD6() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("technical", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("technical");
  var_0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("technical");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("technical", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("technical", &technical_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("technical_mp", 3);
}

function technical_initfx() {
  level._effect["technical_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_technical_mp_death_exp.vfx");
}

function technical_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_civ_lnd_hindia_physics_mp";
  var_0.targetname = "technical";
  var_0.vehicletype = "hindia_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "technical", var_0);
  var_2.objweapon = getcompleteweaponname("technical_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "create")]](var_2);
  }

  return var_2;
}

function technical_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "technical_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread technical_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_body_animate");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "technical_mp");
    playFX(scripts\engine\utility::getfx("technical_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function technical_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function technical_deathcallback(var_0) {
  thread technical_explode(var_0);
  return true;
}

function technical_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
      }
    }

    foreach(var_9 in var_0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
  }

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3.x1circletime)) {
    var_3.x1circletime hide();
    return;
  }
}

function technical_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    technical_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function technical_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function technical_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    technical_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function technical_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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
    } else if(istrue(var_0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
    }
  }

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3.x1circletime)) {
    var_3.x1circletime show();
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function technical_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("technical", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = &technical_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "spawnCallback");
  var_0.clearancecheckradius = 121;
  var_0.clearancecheckheight = 73;
  var_0.clearancecheckminradius = 121;
}

function technical_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("technical_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}