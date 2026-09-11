/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\med_transport.gsc
****************************************************/

function med_transport_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("medium_transport", 1);
  var0.destroycallback = &med_transport_explode;
  med_transport_initoccupancy();
  med_transport_initinteract();
  ref_11baa();
  ref_11ba9();
  med_transport_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("medium_transport", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("medium_transport", "init")]]();
  }

  med_transport_initspawning();
  med_transport_initlate();
}

function med_transport_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("medium_transport", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("medium_transport", "initLate")]]();
    return;
  }
}

function med_transport_initoccupancy() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("medium_transport", 1);
  var0.enterendcallback = &med_transport_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &med_transport_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var0.exitextents["front"] = 115;
  var0.exitextents["back"] = 115;
  var0.exitextents["left"] = 53;
  var0.exitextents["right"] = 53;
  var0.exitextents["top"] = 103;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (80, 0, 70);
  var0.exitdirections[var1] = "front";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-85, 22, 89);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-85, -22, 89);
  var0.exitdirections[var1] = "back";
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "driver");
}

function med_transport_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("medium_transport", 1);
  var0.seatenterarrays["driver"] = ["driver"];
  var0.seatenterarrays["front_left"] = ["front_left"];
  var0.seatenterarrays["front_left_rear"] = ["front_left_rear"];
  var0.seatenterarrays["front_right_rear"] = ["front_right_rear"];
  var0.seatenterarrays["back_left_rear"] = ["back_left_rear"];
  var0.seatenterarrays["back_right_rear"] = ["back_right_rear"];
}

function ref_11baa() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("medium_transport", 1);
  var0.id = 11;
  var0.seatids["driver"] = 0;
  var0.seatids["front_left"] = 1;
  var0.seatids["front_left_rear"] = 2;
  var0.seatids["front_right_rear"] = 3;
  var0.seatids["back_left_rear"] = 4;
  var0.seatids["back_right_rear"] = 5;
}

function ref_11ba9() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("medium_transport", 2000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("medium_transport");
  var0.class = "medium_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("medium_transport");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("medium_transport", 13);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("medium_transport", &med_transport_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("med_transport_mp", 3);
}

function med_transport_initfx() {
  level._effect["med_transport_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx");
}

function med_transport_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_lnd_asierra_physics_mp";
  var0.targetname = "medium_transport";
  var0.vehicletype = "asierra_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "medium_transport", var0);
  var2.objweapon = getcompleteweaponname("med_transport_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("medium_transport", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("medium_transport", "create")]](var2);
  }

  return var2;
}

function med_transport_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "med_transport_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread med_transport_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "med_transport_mp");
    playFX(scripts\engine\utility::getfx("med_transport_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function med_transport_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("medium_transport", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("medium_transport", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function med_transport_deathcallback(var0) {
  thread med_transport_explode(var0);
  return true;
}

function med_transport_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    med_transport_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function med_transport_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function med_transport_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    med_transport_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function med_transport_exitendinternal(var0, var1, var2, var3, var4) {
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

function med_transport_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("medium_transport", 1);
  var0.maxinstancecount = 30;
  var0.priority = 50;
  var0.getspawnstructscallback = &med_transport_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("medium_transport", "spawnCallback");
  var0.clearancecheckradius = 110;
  var0.clearancecheckheight = 110;
  var0.clearancecheckminradius = 110;
}

function med_transport_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("mediumtransport_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}