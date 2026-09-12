/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\hoopty.gsc
***********************************************/

function hoopty_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("hoopty", 1);
  var_0.destroycallback = &hoopty_explode;
  hoopty_initoccupancy();
  hoopty_initinteract();
  spawn_mindia_juggs();
  spawn_manual_turret();
  hoopty_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "init")]]();
  }

  hoopty_initspawning();
  hoopty_initlate();
}

function hoopty_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "initLate")]]();
    return;
  }
}

function hoopty_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("hoopty", 1);
  var_0.enterendcallback = &hoopty_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &hoopty_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 95;
  var_0.exitextents["back"] = 115;
  var_0.exitextents["left"] = 38;
  var_0.exitextents["right"] = 38;
  var_0.exitextents["top"] = 73;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (90, 0, 54);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (17, -19, 54);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-84, 19, 54);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-84, -19, 54);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "front_right_rear", "back_right_rear", "back_left_rear", "front_left_rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_left_rear", "back_left", "front_right", "front"];
  var_0.exitoffsets[var_3] = (17, 19, 54);
  var_0.exitdirections[var_3] = "left";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_3 = "front_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_left_rear", "back_left", "front_right_rear", "front"];
  var_0.exitoffsets[var_3] = (-42, 19, 54);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "front_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_right_rear", "back_right", "front_left_rear", "front"];
  var_0.exitoffsets[var_3] = (-84, -19, 54);
  var_0.exitdirections[var_3] = "right";
  var_4.animtag = "tag_seat_4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_left_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "driver", "back_left", "back_right_rear", "front"];
  var_0.exitoffsets[var_3] = (-84, 19, 54);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_right_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "front_right", "back_right", "back_left_rear", "front"];
  var_0.exitoffsets[var_3] = (-84, -19, 54);
  var_0.exitdirections[var_3] = "right";
  var_4.animtag = "tag_seat_5";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
}

function hoopty_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("hoopty", 1);
  var_0.seatenterarrays["driver"] = ["driver"];
  var_0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var_0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var_0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var_0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function spawn_mindia_juggs() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("hoopty", 1);
  var_0.id = 9;
  var_0.seatids["driver"] = 0;
  var_0.seatids["front_right"] = 1;
  var_0.seatids["front_left_rear"] = 2;
  var_0.seatids["front_right_rear"] = 3;
  var_0.seatids["back_left_rear"] = 4;
  var_0.seatids["back_right_rear"] = 5;
}

function spawn_manual_turret() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("hoopty", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("hoopty");
  var_0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("hoopty");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("hoopty", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("hoopty", &hoopty_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("hoopty_mp", 3);
}

function hoopty_initfx() {
  level._effect["hoopty_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function hoopty_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_pindia_1seat_red_physics_mp";
  var_0.targetname = "hoopty";
  var_0.vehicletype = "pindia_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "hoopty", var_0);
  var_2.objweapon = getcompleteweaponname("hoopty_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "create")]](var_2);
  }

  return var_2;
}

function hoopty_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "hoopty_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hoopty_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "hoopty_mp");
    playFX(scripts\engine\utility::getfx("hoopty_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function hoopty_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function hoopty_deathcallback(var_0) {
  thread hoopty_explode(var_0);
  return true;
}

function hoopty_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    hoopty_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function hoopty_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function hoopty_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    hoopty_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function hoopty_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function hoopty_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = &hoopty_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "spawnCallback");
  var_0.clearancecheckradius = 118;
  var_0.clearancecheckheight = 70;
  var_0.clearancecheckminradius = 118;
}

function hoopty_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("hoopty_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}