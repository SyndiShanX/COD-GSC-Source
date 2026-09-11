/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cargo_truck.gsc
**************************************************/

function cargo_truck_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck", 1);
  var0.destroycallback = &cargo_truck_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck", 1);
  var0.enterendcallback = &cargo_truck_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &cargo_truck_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var0.exitextents["front"] = 175;
  var0.exitextents["back"] = 180;
  var0.exitextents["left"] = 68;
  var0.exitextents["right"] = 68;
  var0.exitextents["top"] = 138;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (140, 0, 115);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (65, 23, 115);
  var0.exitdirections[var1] = "right";
  var1 = "front_left";
  var0.exitoffsets[var1] = (65, 23, 115);
  var0.exitdirections[var1] = "left";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-152, 36, 115);
  var0.exitdirections[var1] = "back";
  var1 = "side_left";
  var0.exitoffsets[var1] = (-109, 36, 115);
  var0.exitdirections[var1] = "left";
  var2 = "driver";
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck", var2, 1);
  var3.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var3.animtag = "tag_seat_0";
  var3.ref_12023 = "ping_vehicle_driver";
}

function cargo_truck_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck", "single", ["driver"]);
}

function get_focus_fire_icon_image() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck", 1);
  var0.id = 8;
  var0.seatids["driver"] = 0;
}

function get_focus_fire_damage_multiplier() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck", 3500);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck");
  var0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck", 20);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck", &cargo_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mp", 5);
}

function get_farthest_living_player_not_in_laststand() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck", 1);
  var0.challengeevaluator = 2;
  var0.keycardlocs_chosen = 0.75;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 5;
  var0.isallowedweapon = 20;
  var0.isakimbo = 40;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function cargo_truck_initfx() {
  level._effect["cargo_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function cargo_truck_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

  if(var2) {
    var0.modelname = "veh8_mil_lnd_mkilo23_physics_opt_mp";
  } else {
    var0.modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  }

  var0.targetname = "cargo_truck";
  var0.vehicletype = "mkilo_physics_mp";
  var3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var3, "cargo_truck", var0);
  var3.objweapon = getcompleteweaponname("cargo_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var3, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "create")]](var3);
  }

  return var3;
}

function cargo_truck_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "cargo_truck_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cargo_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function cargo_truck_deathcallback(var0) {
  thread cargo_truck_explode(var0);
  return true;
}

function cargo_truck_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    cargo_truck_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function cargo_truck_enterendinternal(var0, var1, var2, var3, var4) {
  var0 setotherent(var3);
  var0 setentityowner(var3);
  var3 controlslinkTo(var0);
  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function cargo_truck_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    cargo_truck_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function cargo_truck_exitendinternal(var0, var1, var2, var3, var4) {
  var0 setotherent(undefined);
  var0 setentityowner(undefined);

  if(!istrue(var4.playerdisconnect)) {
    var3 controlsunlink();
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

function cargo_truck_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &cargo_truck_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function cargo_truck_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("cargotruck_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}