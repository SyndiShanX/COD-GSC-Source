/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58237.gsc
***********************************************/

function ref_11d60() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("motorcycle", 1);
  var0.destroycallback = &ref_11d5d;
  ref_11d67();
  ref_11d65();
  ref_11d68();
  ref_11d63();
  ref_11d62();
  ref_11d64();
  ref_11d61();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "init")]]();
  }

  ref_11d69();
  ref_11d66();
}

function ref_11d66() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "initLate")]]();
    return;
  }
}

function ref_11d67() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("motorcycle", 1);
  var0.enterendcallback = &ref_11d59;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &ref_11d5b;
  var0.exitextents["front"] = 45;
  var0.exitextents["back"] = 45;
  var0.exitextents["left"] = 28;
  var0.exitextents["right"] = 28;
  var0.exitextents["top"] = 45;
  var0.exitextents["bottom"] = 0;
  var0.exittopcastoffset = 40;
  var0.onprematchstarted2 = getdvarint("scr_motorcycleUseExitFallback", 1);
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
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("motorcycle", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["left", "right", "back", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "rear";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("motorcycle", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back", "right", "left", "front"];
  var4.viewclamps["top"] = 180;
  var4.viewclamps["bottom"] = 180;
  var4.viewclamps["left"] = 120;
  var4.viewclamps["right"] = 120;
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var4.ref_13345 = 1;
}

function ref_11d65() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("motorcycle", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("motorcycle", "single", ["driver", "rear"]);
}

function ref_11d68() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("motorcycle", 1);
  var0.id = 18;
  var0.seatids["driver"] = 0;
  var0.seatids["rear"] = 1;
}

function ref_11d63() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("motorcycle", 500);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("motorcycle");
  var0.class = "super_light";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("motorcycle");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("motorcycle", 4);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::ref_14179("motorcycle", 6, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("motorcycle", &ref_11d57);
}

function ref_11d62() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("motorcycle", 1);
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
  var1.keycardlocs_chosen["motorcycle"] = [];
  var1.keycardlocs_chosen["motorcycle"]["cargo_truck"] = 2;
}

function ref_11d64() {
  level._effect["motorcycle_explode"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_motorcycle.vfx");
}

#using_animtree("");

function ref_11d61() {
  level.scr_anim["motorcycle"]["pickup_right"] = % sdr_mp_veh_motorcycle_pickup_right;
  level.scr_anim["motorcycle"]["pickup_left"] = $sdr_mp_veh_motorcycle_pickup_left;
}

function ref_11d56(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh_t9_mil_lnd_motorcycle_wz";
  var0.targetname = "motorcycle";
  var0.vehicletype = "motorcycle_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);
  var2.vehicletype = "motorcycle_physics_mp";

  if(!isDefined(var2)) {
    return undefined;
  }

  if(getdvarint("scr_motorcycleUseExitFallback", 1)) {
    var2.play_incoming_rpg_vo = 1;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "motorcycle", var0);
  var2.objweapon = getcompleteweaponname("motorcycle_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread ref_11d72();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "create")]](var2);
  }

  return var2;
}

function ref_11d72() {
  self endon("death");
  level endon("game_ended");
  jumpiftrue(self getscriptablehaspart("stability")) LOC_0000001c;
  return;
}

function ref_11d5d(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "motorcycle_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread ref_11d58();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "motorcycle_mp");
    playFX(scripts\engine\utility::getfx("motorcycle_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function ref_11d58() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function ref_11d57(var0) {
  thread ref_11d5d(var0);
  return true;
}

function ref_11d4e(var0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  self method_87c6();
}

function ref_11d59(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    ref_11d5a(var0, var1, var2, var3, var4);
    return;
  }
}

function ref_11d5a(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);

    if(getdvarint("LTTOPOMRKP", 0) == 1) {
      if(!isDefined(var2)) {
        var5 = undefined;

        if(var0.angles[2] < -20) {
          var5 = level.scr_anim["motorcycle"]["pickup_left"];
        } else if(var0.angles[2] > 20) {
          var5 = level.scr_anim["motorcycle"]["pickup_right"];
        }

        if(isDefined(var5)) {
          var0 vehicleplayanim(var5);
          thread ref_11d4e(var0);
        }
      }
    }
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function ref_11d5b(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    ref_11d5c(var0, var1, var2, var3, var4);
    return;
  }
}

function ref_11d5c(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);
    var0 method_87c6();

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

function ref_11d69() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("motorcycle", 1);
  var0.maxinstancecount = 4;
  var0.priority = 75;
  var0.getspawnstructscallback = &ref_11d5e;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "spawnCallback");
  var0.clearancecheckradius = 55;
  var0.clearancecheckheight = 45;
  var0.clearancecheckminradius = 55;
}

function ref_11d5e() {
  var0 = scripts\engine\utility::getStructArray("motorcycle_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}