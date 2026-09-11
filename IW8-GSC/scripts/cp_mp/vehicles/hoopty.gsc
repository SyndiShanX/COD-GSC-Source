/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\hoopty.gsc
***********************************************/

function hoopty_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("hoopty", 1);
  var0.destroycallback = &hoopty_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("hoopty", 1);
  var0.enterendcallback = &hoopty_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &hoopty_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 95;
  var0.exitextents["back"] = 115;
  var0.exitextents["left"] = 38;
  var0.exitextents["right"] = 38;
  var0.exitextents["top"] = 73;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (90, 0, 54);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (17, -19, 54);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-84, 19, 54);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-84, -19, 54);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "front_right_rear", "back_right_rear", "back_left_rear", "front_left_rear"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left_rear", "back_left", "front_right", "front"];
  var0.exitoffsets[var3] = (17, 19, 54);
  var0.exitdirections[var3] = "left";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.damagemodifier = 0.5;
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var3 = "front_left_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left_rear", "back_left", "front_right_rear", "front"];
  var0.exitoffsets[var3] = (-42, 19, 54);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "front_right_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_right_rear", "back_right", "front_left_rear", "front"];
  var0.exitoffsets[var3] = (-84, -19, 54);
  var0.exitdirections[var3] = "right";
  var4.animtag = "tag_seat_4";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_left_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "driver", "back_left", "back_right_rear", "front"];
  var0.exitoffsets[var3] = (-84, 19, 54);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_right_rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("hoopty", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "front_right", "back_right", "back_left_rear", "front"];
  var0.exitoffsets[var3] = (-84, -19, 54);
  var0.exitdirections[var3] = "right";
  var4.animtag = "tag_seat_5";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
}

function hoopty_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("hoopty", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function spawn_mindia_juggs() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("hoopty", 1);
  var0.id = 9;
  var0.seatids["driver"] = 0;
  var0.seatids["front_right"] = 1;
  var0.seatids["front_left_rear"] = 2;
  var0.seatids["front_right_rear"] = 3;
  var0.seatids["back_left_rear"] = 4;
  var0.seatids["back_right_rear"] = 5;
}

function spawn_manual_turret() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("hoopty", 1000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("hoopty");
  var0.class = "medium_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("hoopty");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("hoopty", 6);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("hoopty", &hoopty_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("hoopty_mp", 3);
}

function hoopty_initfx() {
  level._effect["hoopty_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function hoopty_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_lnd_pindia_1seat_red_physics_mp";
  var0.targetname = "hoopty";
  var0.vehicletype = "pindia_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "hoopty", var0);
  var2.objweapon = getcompleteweaponname("hoopty_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hoopty", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "create")]](var2);
  }

  return var2;
}

function hoopty_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "hoopty_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hoopty_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "hoopty_mp");
    playFX(scripts\engine\utility::getfx("hoopty_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function hoopty_deathcallback(var0) {
  thread hoopty_explode(var0);
  return true;
}

function hoopty_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    hoopty_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function hoopty_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function hoopty_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    hoopty_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function hoopty_exitendinternal(var0, var1, var2, var3, var4) {
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

function hoopty_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty", 1);
  var0.maxinstancecount = 30;
  var0.priority = 50;
  var0.getspawnstructscallback = &hoopty_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("hoopty", "spawnCallback");
  var0.clearancecheckradius = 118;
  var0.clearancecheckheight = 70;
  var0.clearancecheckminradius = 118;
}

function hoopty_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("hoopty_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}