/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\technical.gsc
************************************************/

function technical_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("technical", 1);
  var0.destroycallback = &technical_explode;
  technical_initoccupancy();
  technical_initinteract();
  ref_13ad7();
  ref_13ad6();
  ref_13ad5();
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("technical", 1);
  var0.enterstartcallback = &technical_enterstart;
  var0.enterendcallback = &technical_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &technical_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 95;
  var0.exitextents["back"] = 115;
  var0.exitextents["left"] = 38;
  var0.exitextents["right"] = 38;
  var0.exitextents["top"] = 73;
  var0.exitextents["bottom"] = 0;
  var1 = "front_right";
  var0.exitoffsets[var1] = (5, -14, 55);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-90, 14, 55);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-90, -14, 55);
  var0.exitdirections[var1] = "back";
  var1 = "front";
  var0.exitoffsets[var1] = (65, 0, 55);
  var0.exitdirections[var1] = "front";
  var2 = ["driver", "fr_rear", "br_rear", "bl_rear", "fl_rear"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.exitids = [var3, "fl_rear", "back_left", "front_right", "front"];
  var0.exitoffsets[var3] = (5, 14, 55);
  var0.exitdirections[var3] = "left";
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "fl_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.animtag = "tag_seat_2";
  var4.exitids = [var3, "bl_rear", "back_left", "fr_rear", "front"];
  var0.exitoffsets[var3] = (-60, 14, 55);
  var0.exitdirections[var3] = "left";
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "fr_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.animtag = "tag_seat_4";
  var4.exitids = [var3, "br_rear", "back_right", "fl_rear", "front"];
  var0.exitoffsets[var3] = (-60, -14, 55);
  var0.exitdirections[var3] = "right";
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "bl_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.animtag = "tag_seat_3";
  var4.exitids = [var3, "back_left", "fl_rear", "br_rear", "front"];
  var0.exitoffsets[var3] = (-90, 14, 55);
  var0.exitdirections[var3] = "left";
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "br_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("technical", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.animtag = "tag_seat_5";
  var4.exitids = [var3, "back_right", "fr_rear", "bl_rear", "front"];
  var0.exitoffsets[var3] = (-90, -14, 55);
  var0.exitdirections[var3] = "right";
  var4.ref_12023 = "ping_vehicle_rider";
}

function technical_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("technical", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("technical", "single", ["driver", "fl_rear", "fr_rear", "bl_rear", "br_rear"]);
}

function ref_13ad7() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("technical", 1);
  var0.id = 0;
  var0.seatids["driver"] = 0;
  var0.seatids["fl_rear"] = 1;
  var0.seatids["fr_rear"] = 2;
  var0.seatids["bl_rear"] = 3;
  var0.seatids["br_rear"] = 4;
}

function ref_13ad5() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("technical", 1);
  var0.challengeevaluator = 1.16666;
  var0.keycardlocs_chosen = 0.95833;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 11.25;
  var0.isallowedweapon = 45;
  var0.isakimbo = 90;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function ref_13ad6() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("technical", 1000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("technical");
  var0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("technical");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("technical", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("technical", &technical_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("technical_mp", 3);
}

function technical_initfx() {
  level._effect["technical_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_technical_mp_death_exp.vfx");
}

function technical_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_hindia_physics_mp";
  var0.targetname = "technical";
  var0.vehicletype = "hindia_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "technical", var0);
  var2.objweapon = getcompleteweaponname("technical_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("technical", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "create")]](var2);
  }

  return var2;
}

function technical_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "technical_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread technical_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_body_animate");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "technical_mp");
    playFX(scripts\engine\utility::getfx("technical_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function technical_deathcallback(var0) {
  thread technical_explode(var0);
  return true;
}

function technical_enterstart(var0, var1, var2, var3, var4) {
  if(istrue(var0.israllypointvehicle)) {
    foreach(var6 in level.players) {
      if(istrue(var0.revealed) || var6.team == var0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var6);
      }
    }

    foreach(var9 in var0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var3);
  }

  if(isDefined(var3) && isPlayer(var3) && isDefined(var3.x1circletime)) {
    var3.x1circletime hide();
    return;
  }
}

function technical_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    technical_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function technical_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function technical_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    technical_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function technical_exitendinternal(var0, var1, var2, var3, var4) {
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
    } else if(istrue(var0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var3);
    }
  }

  if(isDefined(var3) && isPlayer(var3) && isDefined(var3.x1circletime)) {
    var3.x1circletime show();
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function technical_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("technical", 1);
  var0.maxinstancecount = 30;
  var0.priority = 50;
  var0.getspawnstructscallback = &technical_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("technical", "spawnCallback");
  var0.clearancecheckradius = 121;
  var0.clearancecheckheight = 73;
  var0.clearancecheckminradius = 121;
}

function technical_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("technical_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}