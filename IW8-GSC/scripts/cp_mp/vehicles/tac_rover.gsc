/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\tac_rover.gsc
************************************************/

function tac_rover_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("tac_rover", 1);
  var_0.destroycallback = &tac_rover_explode;
  tac_rover_initoccupancy();
  tac_rover_initinteract();
  ref_139fb();
  ref_139fa();
  ref_139f9();
  tac_rover_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "init")]]();
  }

  tac_rover_initspawning();
  tac_rover_initlate();
}

function tac_rover_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "initLate")]]();
    return;
  }
}

function tac_rover_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("tac_rover", 1);
  var_0.enterendcallback = &tac_rover_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &tac_rover_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 85;
  var_0.exitextents["back"] = 82;
  var_0.exitextents["left"] = 34;
  var_0.exitextents["right"] = 34;
  var_0.exitextents["top"] = 82;
  var_0.exitextents["bottom"] = 0;
  var_0.exitoffsets["front"] = (58, 0, 55);
  var_0.exitdirections["front"] = "front";
  var_0.exitoffsets["back"] = (-65, 0, 65);
  var_0.exitdirections["back"] = "back";
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "driver");
}

function tac_rover_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("tac_rover", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("tac_rover", "single", ["driver", "fr_passenger", "bl_passenger", "br_passenger"]);
}

function ref_139fb() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("tac_rover", 1);
  var_0.id = 3;
  var_0.seatids["driver"] = 0;
  var_0.seatids["fr_passenger"] = 1;
  var_0.seatids["bl_passenger"] = 2;
  var_0.seatids["br_passenger"] = 3;
}

function ref_139fa() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("tac_rover", 750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("tac_rover");
  var_0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("tac_rover");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("tac_rover", 5);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("tac_rover", 8, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("tac_rover", &tac_rover_deathcallback);
}

function ref_139f9() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("tac_rover", 1);
  var_0.challengeevaluator = 1.83333;
  var_0.keycardlocs_chosen = 0.79166;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 6.25;
  var_0.isallowedweapon = 25;
  var_0.isakimbo = 50;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function tac_rover_initfx() {
  level._effect["tac_rover_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_tromeo_mp_death_exp.vfx");
}

function tac_rover_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

  if(var_2) {
    var_0.modelname = "veh8_mil_lnd_tromeo_opt_mp";
  } else {
    var_0.modelname = "veh8_mil_lnd_tromeo_physics_mp";
  }

  var_0.targetname = "tac_rover";
  var_0.vehicletype = "tromeo_physics_mp";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_3, "tac_rover", var_0);
  var_3.objweapon = getcompleteweaponname("tac_rover_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "create")]](var_3);
  }

  return var_3;
}

function tac_rover_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "tac_rover_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread tac_rover_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "tac_rover_mp");
    playFX(scripts\engine\utility::getfx("tac_rover_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function tac_rover_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function tac_rover_deathcallback(var_0) {
  thread tac_rover_explode(var_0);
  return true;
}

function tac_rover_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    tac_rover_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function tac_rover_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function tac_rover_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    tac_rover_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function tac_rover_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(var_1 == "driver") {
      var_3 controlsunlink();
    }

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

function tac_rover_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &tac_rover_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "spawnCallback");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 82;
  var_0.clearancecheckminradius = 120;
}

function tac_rover_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("tacrover_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}