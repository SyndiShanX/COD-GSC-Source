/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cargo_truck.gsc
**************************************************/

function cargo_truck_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck", 1);
  var_0.destroycallback = &cargo_truck_explode;
  cargo_truck_initoccupancy();
  cargo_truck_initinteract();
  get_focus_fire_icon_image();
  get_focus_fire_damage_multiplier();
  get_farthest_living_player_not_in_laststand();
  cargo_truck_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "init")]]();
  }

  cargo_truck_initspawning();
  cargo_truck_initlate();
}

function cargo_truck_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "initLate")]]();
    return;
  }
}

function cargo_truck_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck", 1);
  var_0.enterendcallback = &cargo_truck_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &cargo_truck_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 175;
  var_0.exitextents["back"] = 180;
  var_0.exitextents["left"] = 68;
  var_0.exitextents["right"] = 68;
  var_0.exitextents["top"] = 138;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "right";
  var_1 = "front_left";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "back";
  var_1 = "side_left";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
  var_0.exitdirections[var_1] = "left";
  var_2 = "driver";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck", var_2, 1);
  var_3.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_3.animtag = "tag_seat_0";
  var_3.ref_12023 = "ping_vehicle_driver";
}

function cargo_truck_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck", "single", ["driver"]);
}

function get_focus_fire_icon_image() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck", 1);
  var_0.id = 8;
  var_0.seatids["driver"] = 0;
}

function get_focus_fire_damage_multiplier() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck", 3500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck");
  var_0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck", 20);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck", &cargo_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mp", 5);
}

function get_farthest_living_player_not_in_laststand() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function cargo_truck_initfx() {
  level._effect["cargo_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function cargo_truck_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

  if(var_2) {
    var_0.modelname = "veh8_mil_lnd_mkilo23_physics_opt_mp";
  } else {
    var_0.modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  }

  var_0.targetname = "cargo_truck";
  var_0.vehicletype = "mkilo_physics_mp";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_3, "cargo_truck", var_0);
  var_3.objweapon = getcompleteweaponname("cargo_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "create")]](var_3);
  }

  return var_3;
}

function cargo_truck_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cargo_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function cargo_truck_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function cargo_truck_deathcallback(var_0) {
  thread cargo_truck_explode(var_0);
  return true;
}

function cargo_truck_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    cargo_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function cargo_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(var_3);
  var_0 setentityowner(var_3);
  var_3 controlslinkTo(var_0);
  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function cargo_truck_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    cargo_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function cargo_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(undefined);
  var_0 setentityowner(undefined);

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();
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

function cargo_truck_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &cargo_truck_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function cargo_truck_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("cargotruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}