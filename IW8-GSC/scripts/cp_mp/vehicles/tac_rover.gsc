/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\tac_rover.gsc
************************************************/

function tac_rover_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("tac_rover", 1);
  var0.destroycallback = &tac_rover_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("tac_rover", 1);
  var0.enterendcallback = &tac_rover_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &tac_rover_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 85;
  var0.exitextents["back"] = 82;
  var0.exitextents["left"] = 34;
  var0.exitextents["right"] = 34;
  var0.exitextents["top"] = 82;
  var0.exitextents["bottom"] = 0;
  var0.exitoffsets["front"] = (58, 0, 55);
  var0.exitdirections["front"] = "front";
  var0.exitoffsets["back"] = (-65, 0, 65);
  var0.exitdirections["back"] = "back";
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "driver");
}

function tac_rover_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("tac_rover", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("tac_rover", "single", ["driver", "fr_passenger", "bl_passenger", "br_passenger"]);
}

function ref_139fb() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("tac_rover", 1);
  var0.id = 3;
  var0.seatids["driver"] = 0;
  var0.seatids["fr_passenger"] = 1;
  var0.seatids["bl_passenger"] = 2;
  var0.seatids["br_passenger"] = 3;
}

function ref_139fa() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("tac_rover", 750);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("tac_rover");
  var0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("tac_rover");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("tac_rover", 5);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("tac_rover", 8, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("tac_rover", &tac_rover_deathcallback);
}

function ref_139f9() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("tac_rover", 1);
  var0.challengeevaluator = 1.83333;
  var0.keycardlocs_chosen = 0.79166;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 6.25;
  var0.isallowedweapon = 25;
  var0.isakimbo = 50;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function tac_rover_initfx() {
  level._effect["tac_rover_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_tromeo_mp_death_exp.vfx");
}

function tac_rover_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

  if(var2) {
    var0.modelname = "veh8_mil_lnd_tromeo_opt_mp";
  } else {
    var0.modelname = "veh8_mil_lnd_tromeo_physics_mp";
  }

  var0.targetname = "tac_rover";
  var0.vehicletype = "tromeo_physics_mp";
  var3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var3, "tac_rover", var0);
  var3.objweapon = getcompleteweaponname("tac_rover_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var3, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("tac_rover", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "create")]](var3);
  }

  return var3;
}

function tac_rover_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "tac_rover_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread tac_rover_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "tac_rover_mp");
    playFX(scripts\engine\utility::getfx("tac_rover_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function tac_rover_deathcallback(var0) {
  thread tac_rover_explode(var0);
  return true;
}

function tac_rover_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    tac_rover_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function tac_rover_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function tac_rover_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    tac_rover_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function tac_rover_exitendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);
  }

  if(!istrue(var4.playerdisconnect)) {
    if(var1 == "driver") {
      var3 controlsunlink();
    }

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

function tac_rover_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &tac_rover_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("tac_rover", "spawnCallback");
  var0.clearancecheckradius = 120;
  var0.clearancecheckheight = 82;
  var0.clearancecheckminradius = 120;
}

function tac_rover_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("tacrover_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}