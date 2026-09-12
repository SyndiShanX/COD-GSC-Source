/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\large_transport.gsc
******************************************************/

function large_transport_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("large_transport", 1);
  var_0.destroycallback = &large_transport_explode;
  large_transport_initoccupancy();
  large_transport_initinteract();
  waitthenrespawnsnowballs();
  waitthencheckendgame();
  large_transport_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "init")]]();
  }

  large_transport_initspawning();
  large_transport_initlate();
}

function large_transport_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "initLate")]]();
    return;
  }
}

function large_transport_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("large_transport", 1);
  var_0.enterendcallback = &large_transport_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &large_transport_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 118;
  var_0.exitextents["back"] = 135;
  var_0.exitextents["left"] = 57;
  var_0.exitextents["right"] = 57;
  var_0.exitextents["top"] = 127;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (100, 0, 75);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (55, 22, 90);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-109, 22, 90);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-109, -22, 90);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "fr_rear", "mr_rear", "br_rear", "bl_rear", "ml_rear", "fl_rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "ml_rear", "back_left", "front_right", "front"];
  var_0.exitoffsets[var_3] = (55, 22, 90);
  var_0.exitdirections[var_3] = "left";
  var_4.damagemodifier = 0.5;
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "fl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "bl_rear", "back_left", "fr_rear", "front"];
  var_0.exitoffsets[var_3] = (-42, 22, 90);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_5";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "fr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "br_rear", "back_right", "fl_rear", "front"];
  var_0.exitoffsets[var_3] = (-42, -22, 90);
  var_0.exitdirections[var_3] = "right";
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "ml_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "bl_rear", "back_left", "mr_rear", "front"];
  var_0.exitoffsets[var_3] = (-76, 22, 90);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_6";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "mr_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "br_rear", "back_right", "ml_rear", "front"];
  var_0.exitoffsets[var_3] = (-76, -22, 90);
  var_0.exitdirections[var_3] = "right";
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "bl_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "fl_rear", "back_left", "br_rear", "front"];
  var_0.exitoffsets[var_3] = (-109, 22, 90);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_7";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "br_rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "fr_rear", "back_right", "bl_rear", "front"];
  var_0.exitoffsets[var_3] = (-109, -22, 90);
  var_0.exitdirections[var_3] = "right";
  var_4.animtag = "tag_seat_4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
}

function large_transport_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("large_transport", 1);
  var_0.seatenterarrays["driver"] = ["driver"];
  var_0.seatenterarrays["fl_rear"] = ["fl_rear"];
  var_0.seatenterarrays["fr_rear"] = ["fr_rear"];
  var_0.seatenterarrays["ml_rear"] = ["ml_rear"];
  var_0.seatenterarrays["mr_rear"] = ["mr_rear"];
  var_0.seatenterarrays["bl_rear"] = ["bl_rear"];
  var_0.seatenterarrays["br_rear"] = ["br_rear"];
}

function waitthenrespawnsnowballs() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("large_transport", 1);
  var_0.id = 5;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fl_rear"] = 6;
  var_0.seatids["fr_rear"] = 1;
  var_0.seatids["ml_rear"] = 5;
  var_0.seatids["mr_rear"] = 2;
  var_0.seatids["bl_rear"] = 4;
  var_0.seatids["br_rear"] = 3;
}

function waitthencheckendgame() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("large_transport", 2000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("large_transport");
  var_0.class = "medium_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("large_transport");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("large_transport", 10);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("large_transport", &large_transport_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("large_transport_mp", 3);
}

function large_transport_initfx() {
  level._effect["large_transport_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function large_transport_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_umike_infil_physics_mp";
  var_0.targetname = "large_transport";
  var_0.vehicletype = "umike_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "large_transport", var_0);
  var_2.objweapon = getcompleteweaponname("large_transport_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "create")]](var_2);
  }

  return var_2;
}

function large_transport_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "large_transport_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread large_transport_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "large_transport_mp");
    playFX(scripts\engine\utility::getfx("large_transport_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function large_transport_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function large_transport_deathcallback(var_0) {
  thread large_transport_explode(var_0);
  return true;
}

function large_transport_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    large_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function large_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function large_transport_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    large_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function large_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function large_transport_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &large_transport_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "spawnCallback");
  var_0.clearancecheckradius = 150;
  var_0.clearancecheckheight = 130;
  var_0.clearancecheckminradius = 150;
}

function large_transport_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("largetransport_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}