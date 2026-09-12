/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\atv.gsc
***********************************************/

function atv_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("atv", 1);
  var_0.destroycallback = &atv_explode;
  atv_initoccupancy();
  atv_initinteract();
  check_dropped_locations_and_offset();
  check_digit_models_to_create();
  check_crate_unreachable();
  atv_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "init")]]();
  }

  atv_initspawning();
  atv_initlate();
}

function atv_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "initLate")]]();
    return;
  }
}

function atv_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("atv", 1);
  var_0.enterendcallback = &atv_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &atv_exitend;
  var_0.exitextents["front"] = 45;
  var_0.exitextents["back"] = 45;
  var_0.exitextents["left"] = 28;
  var_0.exitextents["right"] = 28;
  var_0.exitextents["top"] = 45;
  var_0.exitextents["bottom"] = 0;
  var_0.exittopcastoffset = 40;
  var_1 = "left";
  var_0.exitoffsets[var_1] = (-5, 0, 55);
  var_0.exitdirections[var_1] = "left";
  var_1 = "right";
  var_0.exitoffsets[var_1] = (-5, 0, 55);
  var_0.exitdirections[var_1] = "right";
  var_1 = "front";
  var_0.exitoffsets[var_1] = (29, 0, 55);
  var_0.exitdirections[var_1] = "front";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-35, 0, 45);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("atv", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["left", "right", "back", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_driver";
  var_4.ref_13345 = 1;
  var_3 = "rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("atv", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back", "right", "left", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_4.ref_13345 = 1;
}

function atv_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("atv", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("atv", "single", ["driver", "rear"]);
}

function check_dropped_locations_and_offset() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("atv", 1);
  var_0.id = 4;
  var_0.seatids["driver"] = 0;
  var_0.seatids["rear"] = 1;
}

function check_digit_models_to_create() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("atv", 500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("atv");
  var_0.class = "super_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("atv");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("atv", 4);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("atv", 6, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("atv", &atv_deathcallback);
}

function check_crate_unreachable() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("atv", 1);
  var_0.challengeevaluator = 1;
  var_0.keycardlocs_chosen = 1;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 12.5;
  var_0.isallowedweapon = 50;
  var_0.isakimbo = 100;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 1;
  var_1 = _calloutmarkerping_predicted_log::ref_1410E();
  var_1.keycardlocs_chosen["atv"] = [];
  var_1.keycardlocs_chosen["atv"]["cargo_truck"] = 2;
}

function atv_initfx() {
  level._effect["atv_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_atv.vfx");
}

function atv_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_lnd_atango_physics_mp";
  var_0.targetname = "atv";
  var_0.vehicletype = "atango_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "atv", var_0);
  var_2.objweapon = getcompleteweaponname("atv_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "create")]](var_2);
  }

  return var_2;
}

function atv_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "atv_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread atv_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "atv_mp");
    playFX(scripts\engine\utility::getfx("atv_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "small_car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function atv_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function atv_deathcallback(var_0) {
  thread atv_explode(var_0);
  return true;
}

function atv_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    atv_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function atv_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function atv_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    atv_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function atv_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

function atv_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("atv", 1);
  var_0.maxinstancecount = 4;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &atv_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "spawnCallback");
  var_0.clearancecheckradius = 55;
  var_0.clearancecheckheight = 45;
  var_0.clearancecheckminradius = 55;
}

function atv_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("atv_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}