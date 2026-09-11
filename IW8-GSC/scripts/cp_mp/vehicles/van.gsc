/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\van.gsc
***********************************************/

function van_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("van", 1);
  var0.destroycallback = &van_explode;
  van_initoccupancy();
  van_initinteract();
  ref_140e7();
  ref_140e6();
  van_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "init")]]();
  }

  van_initspawning();
  van_initlate();
}

function van_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "initLate")]]();
    return;
  }
}

function van_initoccupancy() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("van", 1);
  var0.enterendcallback = &van_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &van_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 130;
  var0.exitextents["back"] = 117;
  var0.exitextents["left"] = 55;
  var0.exitextents["right"] = 55;
  var0.exitextents["top"] = 105;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (98, 0, 65);
  var0.exitdirections[var1] = "front";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-64, 20, 78);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-64, -20, 78);
  var0.exitdirections[var1] = "back";
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "driver");
}

function van_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("van", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["front_right"] = ["front_right"];
  var0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function ref_140e7() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("van", 1);
  var0.id = 13;
  var0.seatids["driver"] = 0;
  var0.seatids["front_right"] = 1;
  var0.seatids["front_left_rear"] = 2;
  var0.seatids["front_right_rear"] = 3;
  var0.seatids["back_left_rear"] = 4;
  var0.seatids["back_right_rear"] = 5;
}

function ref_140e6() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("van", 1350);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("van");
  var0.class = "medium";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("van");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("van", 8);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("van", &van_deathcallback);
}

function van_initfx() {
  level._effect["van_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function van_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_civ_lnd_palfa_windows_east_physics_tan_mp";
  var0.targetname = "van";
  var0.vehicletype = "palfa_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "van", var0);
  var2.objweapon = getcompleteweaponname("van_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "create")]](var2);
  }

  return var2;
}

function van_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "van_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread van_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "van_mp");
    playFX(scripts\engine\utility::getfx("van_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function van_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("van", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("van", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function van_deathcallback(var0) {
  thread van_explode(var0);
  return true;
}

function van_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    van_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function van_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function van_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    van_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function van_exitendinternal(var0, var1, var2, var3, var4) {
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

function van_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &van_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("van", "spawnCallback");
  var0.clearancecheckradius = 130;
  var0.clearancecheckheight = 105;
  var0.clearancecheckminradius = 130;
}

function van_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("van_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}