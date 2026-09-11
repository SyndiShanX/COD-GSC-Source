/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\atv.gsc
***********************************************/

function atv_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("atv", 1);
  var0.destroycallback = &atv_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("atv", 1);
  var0.enterendcallback = &atv_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &atv_exitend;
  var0.exitextents["front"] = 45;
  var0.exitextents["back"] = 45;
  var0.exitextents["left"] = 28;
  var0.exitextents["right"] = 28;
  var0.exitextents["top"] = 45;
  var0.exitextents["bottom"] = 0;
  var0.exittopcastoffset = 40;
  var1 = "left";
  var0.exitoffsets[var1] = (-5, 0, 55);
  var0.exitdirections[var1] = "left";
  var1 = "right";
  var0.exitoffsets[var1] = (-5, 0, 55);
  var0.exitdirections[var1] = "right";
  var1 = "front";
  var0.exitoffsets[var1] = (29, 0, 55);
  var0.exitdirections[var1] = "front";
  var1 = "back";
  var0.exitoffsets[var1] = (-35, 0, 45);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "rear"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("atv", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["left", "right", "back", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var4.ref_13345 = 1;
  var3 = "rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("atv", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back", "right", "left", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var4.ref_13345 = 1;
}

function atv_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("atv", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("atv", "single", ["driver", "rear"]);
}

function check_dropped_locations_and_offset() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("atv", 1);
  var0.id = 4;
  var0.seatids["driver"] = 0;
  var0.seatids["rear"] = 1;
}

function check_digit_models_to_create() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("atv", 500);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("atv");
  var0.class = "super_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("atv");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("atv", 4);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("atv", 6, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("atv", &atv_deathcallback);
}

function check_crate_unreachable() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("atv", 1);
  var0.challengeevaluator = 1;
  var0.keycardlocs_chosen = 1;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 12.5;
  var0.isallowedweapon = 50;
  var0.isakimbo = 100;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 1;
  var1 = _calloutmarkerping_predicted_log::ref_1410e();
  var1.keycardlocs_chosen["atv"] = [];
  var1.keycardlocs_chosen["atv"]["cargo_truck"] = 2;
}

function atv_initfx() {
  level._effect["atv_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_atv.vfx");
}

function atv_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_lnd_atango_physics_mp";
  var0.targetname = "atv";
  var0.vehicletype = "atango_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "atv", var0);
  var2.objweapon = getcompleteweaponname("atv_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("atv", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "create")]](var2);
  }

  return var2;
}

function atv_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "atv_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread atv_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "atv_mp");
    playFX(scripts\engine\utility::getfx("atv_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "small_car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function atv_deathcallback(var0) {
  thread atv_explode(var0);
  return true;
}

function atv_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    atv_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function atv_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function atv_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    atv_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function atv_exitendinternal(var0, var1, var2, var3, var4) {
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

function atv_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("atv", 1);
  var0.maxinstancecount = 4;
  var0.priority = 75;
  var0.getspawnstructscallback = &atv_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("atv", "spawnCallback");
  var0.clearancecheckradius = 55;
  var0.clearancecheckheight = 45;
  var0.clearancecheckminradius = 55;
}

function atv_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("atv_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}