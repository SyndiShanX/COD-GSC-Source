/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\large_transport.gsc
******************************************************/

function large_transport_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("large_transport", 1);
  var0.destroycallback = &large_transport_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("large_transport", 1);
  var0.enterendcallback = &large_transport_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &large_transport_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 118;
  var0.exitextents["back"] = 135;
  var0.exitextents["left"] = 57;
  var0.exitextents["right"] = 57;
  var0.exitextents["top"] = 127;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (100, 0, 75);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (55, 22, 90);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-109, 22, 90);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-109, -22, 90);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "fr_rear", "mr_rear", "br_rear", "bl_rear", "ml_rear", "fl_rear"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "ml_rear", "back_left", "front_right", "front"];
  var0.exitoffsets[var3] = (55, 22, 90);
  var0.exitdirections[var3] = "left";
  var4.damagemodifier = 0.5;
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "fl_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "bl_rear", "back_left", "fr_rear", "front"];
  var0.exitoffsets[var3] = (-42, 22, 90);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_5";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "fr_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "br_rear", "back_right", "fl_rear", "front"];
  var0.exitoffsets[var3] = (-42, -22, 90);
  var0.exitdirections[var3] = "right";
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "ml_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "bl_rear", "back_left", "mr_rear", "front"];
  var0.exitoffsets[var3] = (-76, 22, 90);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_6";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "mr_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "br_rear", "back_right", "ml_rear", "front"];
  var0.exitoffsets[var3] = (-76, -22, 90);
  var0.exitdirections[var3] = "right";
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "bl_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "fl_rear", "back_left", "br_rear", "front"];
  var0.exitoffsets[var3] = (-109, 22, 90);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_7";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "br_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("large_transport", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "fr_rear", "back_right", "bl_rear", "front"];
  var0.exitoffsets[var3] = (-109, -22, 90);
  var0.exitdirections[var3] = "right";
  var4.animtag = "tag_seat_4";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
}

function large_transport_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("large_transport", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["fl_rear"] = ["fl_rear"];
  var0.seatenterarrays["fr_rear"] = ["fr_rear"];
  var0.seatenterarrays["ml_rear"] = ["ml_rear"];
  var0.seatenterarrays["mr_rear"] = ["mr_rear"];
  var0.seatenterarrays["bl_rear"] = ["bl_rear"];
  var0.seatenterarrays["br_rear"] = ["br_rear"];
}

function waitthenrespawnsnowballs() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("large_transport", 1);
  var0.id = 5;
  var0.seatids["driver"] = 0;
  var0.seatids["fl_rear"] = 6;
  var0.seatids["fr_rear"] = 1;
  var0.seatids["ml_rear"] = 5;
  var0.seatids["mr_rear"] = 2;
  var0.seatids["bl_rear"] = 4;
  var0.seatids["br_rear"] = 3;
}

function waitthencheckendgame() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("large_transport", 2000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("large_transport");
  var0.class = "medium_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("large_transport");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("large_transport", 10);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("large_transport", &large_transport_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("large_transport_mp", 3);
}

function large_transport_initfx() {
  level._effect["large_transport_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function large_transport_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_lnd_umike_infil_physics_mp";
  var0.targetname = "large_transport";
  var0.vehicletype = "umike_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "large_transport", var0);
  var2.objweapon = getcompleteweaponname("large_transport_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("large_transport", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "create")]](var2);
  }

  return var2;
}

function large_transport_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "large_transport_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread large_transport_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "large_transport_mp");
    playFX(scripts\engine\utility::getfx("large_transport_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function large_transport_deathcallback(var0) {
  thread large_transport_explode(var0);
  return true;
}

function large_transport_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    large_transport_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function large_transport_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function large_transport_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    large_transport_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function large_transport_exitendinternal(var0, var1, var2, var3, var4) {
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

function large_transport_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &large_transport_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("large_transport", "spawnCallback");
  var0.clearancecheckradius = 150;
  var0.clearancecheckheight = 130;
  var0.clearancecheckminradius = 150;
}

function large_transport_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("largetransport_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}