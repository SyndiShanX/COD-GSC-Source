/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58239.gsc
***********************************************/

function ref_120d2() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("open_jeep_carpoc", 1);
  var0.destroycallback = &ref_120cb;
  ref_120d8();
  ref_120d6();
  ref_120d9();
  ref_120d4();
  ref_120d3();
  ref_120d5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep_carpoc", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep_carpoc", "init")]]();
  }

  ref_120da();
  ref_120d7();
}

function ref_120d7() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep_carpoc", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep_carpoc", "initLate")]]();
    return;
  }
}

function ref_120d8() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("open_jeep_carpoc", 1);
  var0.enterstartcallback = &ref_120c8;
  var0.enterendcallback = &ref_120c6;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &ref_120c9;
  var0.reentercallback = &ref_120e7;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var0.exitextents["front"] = 105;
  var0.exitextents["back"] = 105;
  var0.exitextents["left"] = 44;
  var0.exitextents["right"] = 44;
  var0.exitextents["top"] = 90;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (75, 0, 65);
  var0.exitdirections[var1] = "front";
  var1 = "back";
  var0.exitoffsets[var1] = (-90, 0, 65);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "front_right", "back_left", "back_right"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("open_jeep_carpoc", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_right", "back", "front_right", "front"];
  var0.exitoffsets[var3] = (17, 19, 65);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_driver";
  var4.spawnpriority = 4;
  var3 = "front_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("open_jeep_carpoc", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left", "back", "driver", "front"];
  var0.exitoffsets[var3] = (17, -19, 65);
  var0.exitdirections[var3] = "right";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.ref_13e8a = getcompleteweaponname("tur_gun_carpoc_mp_pass");
  var4.ref_13e92 = "tur_gun_carpoc_mp_pass";
  var4.ref_12023 = "ping_vehicle_rider";
  var4.spawnpriority = 3;
  var3 = "back_left";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("open_jeep_carpoc", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "front_right", "back", "back_right", "front"];
  var0.exitoffsets[var3] = (-24, -19, 65);
  var0.exitdirections[var3] = "right";
  var4.viewclamps["top"] = 45;
  var4.viewclamps["bottom"] = 25;
  var4.viewclamps["left"] = 120;
  var4.viewclamps["right"] = 120;
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.hidestowedweapon = 1;
  var4.ref_12023 = "ping_vehicle_rider";
  var4.spawnpriority = 2;
  var3 = "back_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("open_jeep_carpoc", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left", "back", "driver", "front"];
  var0.exitoffsets[var3] = (-40, 0, 65);
  var0.exitdirections[var3] = "back";
  var4.viewclamps["top"] = 45;
  var4.viewclamps["bottom"] = 25;
  var4.viewclamps["left"] = 120;
  var4.viewclamps["right"] = 120;
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.hidestowedweapon = 1;
  var4.ref_12023 = "ping_vehicle_rider";
  var4.spawnpriority = 1;
}

function ref_120d6() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("open_jeep_carpoc", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("open_jeep_carpoc", "single", ["driver", "front_right", "back_left", "back_right"]);
}

function ref_120d9() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("open_jeep_carpoc", 1);
  var0.id = 25;
  var0.seatids["driver"] = 0;
  var0.seatids["front_right"] = 1;
  var0.seatids["back_left"] = 2;
  var0.seatids["back_right"] = 3;
  var0.ref_12da2[0] = 0;
  var0.ref_12da2[1] = 1;
  var0.ref_12da3["driver"]["open_jeep_carpoc_mp"] = 0;
  var0.ref_12da3["driver"]["tur_gun_carpoc_mp_pass"] = 1;
  var0.ref_12da3["front_right"]["open_jeep_carpoc_mp"] = 0;
  var0.ref_12da3["front_right"]["tur_gun_carpoc_mp_pass"] = 1;
  var0.ref_12da3["back_left"]["open_jeep_carpoc_mp"] = 0;
  var0.ref_12da3["back_left"]["tur_gun_carpoc_mp_pass"] = 1;
  var0.ref_12da3["back_right"]["open_jeep_carpoc_mp"] = 0;
  var0.ref_12da3["back_right"]["tur_gun_carpoc_mp_pass"] = 1;
}

function ref_120d4() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("open_jeep_carpoc", 2750);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("open_jeep_carpoc");
  var0.class = "medium_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("open_jeep_carpoc");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("open_jeep_carpoc", 9);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14176("open_jeep_carpoc", &ref_120e4);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("open_jeep_carpoc", &ref_120e3);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("open_jeep_carpoc", &ref_120c4);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("open_jeep_carpoc_mp", 5);
}

function ref_120d3() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("open_jeep_carpoc", 1);
  var0.challengeevaluator = 1.33333;
  var0.keycardlocs_chosen = 0.91666;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 10;
  var0.isallowedweapon = 40;
  var0.isakimbo = 80;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;

  if(getdvarint("PNPLTTTNN", 0)) {
    var0.setup_techo_lmgs = &ref_120f1;
    return;
  }
}

function ref_120d5() {
  level._effect["open_jeep_carpoc_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");

  if(getdvarint("PNPLTTTNN", 0)) {
    level._effect["open_jeep_carpoc_ramming_sparks"] = loadfx("vfx/iw8_mp/vehicle/vfx_tromeo_mp_dmg_sparks.vfx");
    return;
  }
}

function ref_120c2(var0) {
  var1 = "tag_gunner_turret2_rot";
  var2 = (0, 0, 0);
  var3 = spawnturret("misc_turret", var0 gettagorigin(var1), "tur_gun_carpoc_mp_pass", 0);
  var3 linkTo(var0, var1, var2, (0, 0, 0));
  var3 setModel("veh_s4_mil_ratrace_suv_turret_wz");
  var3 setmode("sentry_offline");
  var3 setsentryowner(undefined);
  var3 makeunusable();
  var3 setdefaultdroppitch(0);
  var3 setturretmodechangewait(1);
  var3.angles = var0.angles;
  var3.vehicle = var0;
  scripts\cp_mp\vehicles\vehicle::ref_14207(var0, var3, getcompleteweaponname("tur_gun_carpoc_mp_pass"));
}

function ref_120c1(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = getdvarint("scr_open_jeep_carpoc_use_alt_vehicle_type", 0);
  var0.modelname = "veh_s4_mil_ratrace_suv_wz";
  var0.targetname = "open_jeep_carpoc";
  var0.vehicletype = "open_jeep_physics_carpoc_mp";

  if(var2 == 1) {} else if(var2 == 2) {}

  var3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var3, "open_jeep_carpoc", var0);
  ref_120c2(var3);
  var3.objweapon = getcompleteweaponname("open_jeep_carpoc_mp");
  var4 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414c(var3, 1);
  var4.wind_trigger_toggle = "br_light_vehicle_damage";
  var4.ref_11bae = "br_medium_vehicle_damage";
  _calloutmarkerping_predicted_timeout::ref_1412b(var3);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var3, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var3, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep_carpoc", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep_carpoc", "create")]](var3);
  }

  return var3;
}

function ref_120cb(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "open_jeep_carpoc_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread ref_120c5();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "open_jeep_carpoc_mp");
    playFX(scripts\engine\utility::getfx("open_jeep_carpoc_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function ref_120c5() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep_carpoc", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep_carpoc", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function ref_120e4(var0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var0)) {
    return false;
  }

  return true;
}

function ref_120e3(var0) {
  if(isDefined(var0.damage) && var0.damage > 0) {
    self notify("damage_taken", var0);
  }

  return true;
}

function ref_120c4(var0) {
  thread ref_120cb(var0);
  return true;
}

function ref_120c8(var0, var1, var2, var3, var4) {
  if(var1 == "front_right") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_carpoc_mp_pass", var4, 1);
    return;
  }
}

function ref_120c6(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    thread ref_120c7(var0, var1, var2, var3, var4);
    return;
  }

  if(!istrue(var4.playerdisconnect) && !istrue(var4.playerdeath)) {
    if(var1 == "front_right") {
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_carpoc_mp_pass", var4, 1);
      return;
    }

    return;
  }
}

function ref_120c7(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
    var5 = var0 method_87e6();

    if(var5) {
      var3 setclientomnvar("ui_veh_show_time", 1);
      thread open_jeep_carpoc_monitor_speed_boost(var0, var3, var1, var4);
      thread open_jeep_carpoc_speed_boost_cleanup_monitor(var0, var3);
    }
  } else if(var1 == "front_right") {
    var6 = 2350;
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, var6);
    var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_gun_carpoc_mp_pass");
    var7.owner = var3;
    var7 setotherent(var3);
    var7 setentityowner(var3);
    var7 setsentryowner(var3);
    var3 disableturretdismount();
    var3 controlturreton(var7);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function ref_120c9(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    ref_120ca(var0, var1, var2, var3, var4);
    return;
  }
}

function ref_120ca(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 notify("open_jeep_carpoc_driver_exit");
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var3 controlsunlink();
    }
  } else if(var1 == "front_right") {
    var0 notify("open_jeep_carpoc_gunner_exit");
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_gun_carpoc_mp_pass");
    var5.owner = undefined;

    if(!istrue(var4.playerdisconnect)) {
      var3 enableturretdismount();
      var3 controlturretoff(var5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var3, var4.playerdeath);

      if(!istrue(var4.playerdeath)) {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_carpoc_mp_pass", var4, 1);
      }
    }

    var5 setotherent(undefined);
    var5 setentityowner(undefined);
    var5 setsentryowner(undefined);
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function ref_120e7(var0, var1, var2, var3, var4) {
  if(isDefined(var2) && var2 == "front_right") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_carpoc_mp_pass", var4, 1);
    return;
  }
}

function ref_120da() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep_carpoc", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &ref_120cf;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep_carpoc", "spawnCallback")) {
    var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep_carpoc", "spawnCallback");
  }

  var0.clearancecheckradius = 105;
  var0.clearancecheckheight = 90;
  var0.clearancecheckminradius = 105;
}

function ref_120cf() {
  if(isDefined(level.ref_1218b)) {
    var0 = level.ref_1218b;
  } else {
    var0 = scripts\engine\utility::getStructArray("open_jeep_carpoc_spawn", "targetname");
  }

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}

function activate_timed_laser_traps() {}

function ref_120ee(var0, var1) {
  if(!getdvarint("scr_open_jeep_carpoc_update_upgrade_team", 1)) {
    return;
  }

  var2 = ref_120e2(var0);
  var3 = ref_120cd(var0, var2, var1);

  if(var3 == "neutral") {
    return;
  }

  if(!isDefined(var0.ref_13df6)) {
    var0.ref_13df6 = var3;
  }

  if(var0.ref_13df6 == var3) {
    return;
  }

  var0.ref_13df6 = var3;
  var4 = ref_120e5(var0, var1);
  ref_120e6(var0, var0, var4);
}

function ref_120e2(var0) {
  var1 = var0.occupants["driver"];

  if(isDefined(var1)) {
    return var1.team;
  }

  var2 = var0.occupants["front_right"];

  if(isDefined(var2)) {
    return var2.team;
  }

  return "neutral";
}

function ref_120cd(var0, var1, var2) {
  if(var1 != "neutral") {
    return var1;
  }

  if(isDefined(var2)) {
    return var2.team;
  }

  return var0.team;
}

function ref_120e5(var0, var1) {
  if(isDefined(var1)) {
    return var1;
  }

  var2 = var0.occupants["driver"];

  if(isDefined(var2)) {
    return var2;
  }

  var3 = var0.occupants["front_right"];

  if(isDefined(var3)) {
    return var3;
  }

  return undefined;
}

function ref_120e6(var0, var1) {
  if(isDefined(var0.radar)) {
    var0.radar delete();
  } else if(istrue(var0.ref_129c5)) {
    var0 method_87ac();
  }

  if(istrue(var0.ref_129c5)) {
    ref_120e9(var0, var1);
    return;
  }
}

function ref_120e8(var0, var1) {
  var0 endon("death");
  var0.radar endon("death");
  var2 = var1.team;
  var1 waittill("disconnect");
  var3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var2, 0);
  var4 = undefined;

  if(isDefined(var3) && var3.size > 0) {
    var4 = var3[0];
  }

  thread ref_120e6(level, var0);
}

function ref_120e9(var0, var1) {
  var2 = getdvarint("scr_truck_mg_uav_type", 0);

  if(var2 == 0) {
    var0 method_87ab();
    return;
  }

  if(isDefined(var1)) {
    var3 = spawn("script_model", var0.origin);
    var3 setModel("tag_origin");
    var3 linkTo(var0);
    var3 makeportableradar(var1);
    var0.radar = var3;
    thread ref_120e8(level, var0);
    return;
  }
}

function ref_120f1(var0, var1) {
  var2 = var0.position[0];
  var3 = var0.ent[0];
  var4 = var0.velocity[0];

  if(isDefined(var2) && var3 method_87dc()) {
    var5 = var4 * 0.05;
    var6 = var2 + var5;
    playFX(scripts\engine\utility::getfx("open_jeep_carpoc_ramming_sparks"), var6, anglesToForward(var3.angles), anglestoup(var3.angles));
    return;
  }
}

function open_jeep_carpoc_monitor_speed_boost(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("open_jeep_carpoc_driver_exit");
  var1 endon("disconnect");
  var1 endon("death");
  var4 = 0;

  if(var2 == "driver") {
    for(;;) {
      var5 = max(0, var0 method_87df());
      var1 setclientomnvar("ui_veh_time_percent", int(var5));
      var6 = var0 method_87e7();
      var1 setclientomnvar("ui_br_veh_speed_boost_in_cooldown", var6);
      var7 = var0 method_87e0();

      if(var7) {
        if(!var4) {
          var0 setscriptablepartstate("speedBoost", "on");
          open_jeep_carpoc_handle_sound_start(var0);
          var1 setclientomnvar("ui_deadsilence_overlay", 0);
        }
      } else if(var4) {
        var0 setscriptablepartstate("speedBoost", "off");
        open_jeep_carpoc_handle_sound_stop(var0);
        var1 setclientomnvar("ui_deadsilence_overlay", 2);
      }

      var4 = var7;
      waitframe();
    }

    return;
  }
}

function open_jeep_carpoc_speed_boost_cleanup_monitor(var0, var1) {
  scripts\engine\utility::waittill_any_ents(var0, "death", var0, "open_jeep_carpoc_driver_exit", var1, "disconnect", var1, "death");
  open_jeep_carpoc_speed_boost_vfx_cleanup(var0, var1);
  var0 stoploopsound();
  var1 setclientomnvar("ui_veh_show_time", 0);
}

function open_jeep_carpoc_speed_boost_vfx_cleanup(var0, var1) {
  var0 setscriptablepartstate("speedBoost", "off");
  var1 setclientomnvar("ui_deadsilence_overlay", 2);
}

function open_jeep_carpoc_handle_sound_start(var0) {
  var0 playsoundonmovingent("veh_carpoc_nitro_strt");
  var0 playLoopSound("veh_carpoc_nitro_lp");
}

function open_jeep_carpoc_handle_sound_stop(var0) {
  var0 playsoundonmovingent("veh_carpoc_nitro_end");
  var0 stoploopsound();
}