/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\apc_rus.gsc
***********************************************/

function apc_rus_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("apc_russian", 1);
  var_0.ref_13fca = &c4_crate_player_at_max_ammo;
  var_0.destroycallback = &apc_rus_explode;
  apc_rus_initoccupancy();
  apc_rus_initinteract();
  c130deliveriesinprogress();
  c130airdrop_startdelivery();
  c130airdrop_spawn();
  apc_rus_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "init")]]();
  }

  apc_rus_initspawning();
  apc_rus_initlate();
}

function apc_rus_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "initLate")]]();
    return;
  }
}

function apc_rus_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("apc_russian", 1);
  var_0.enterendcallback = &apc_rus_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &apc_rus_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var_0.exitextents["front"] = 136;
  var_0.exitextents["back"] = 129;
  var_0.exitextents["left"] = 68;
  var_0.exitextents["right"] = 68;
  var_0.exitextents["top"] = 87;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (100, 0, 65);
  var_0.exitdirections[var_1] = "right";
  var_1 = "middle_left";
  var_0.exitoffsets[var_1] = (-31, 14, 65);
  var_0.exitdirections[var_1] = "left";
  var_1 = "middle_right";
  var_0.exitoffsets[var_1] = (-31, -20, 65);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-90, 35, 65);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-90, -35, 65);
  var_0.exitdirections[var_1] = "back";
  var_0.damagemodifier = 0;
  var_0.hideoccupant = 1;
  var_0.camera = "cam_vindia_passenger";
  var_0.damagefeedbackgrouplight = "all";
  var_0.damagefeedbackgroupheavy = "all";
  var_2 = ["driver", "front_right", "back_right", "back", "back_left", "front_left"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "middle_left", "back_left", "middle_right", "front"];
  var_0.exitoffsets[var_3] = (80, 14, 65);
  var_0.exitdirections[var_3] = "left";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.restrictions = scripts\engine\utility::array_remove(var_4.restrictions, "fire");
  var_4.viewclamps["top"] = 30;
  var_4.viewclamps["bottom"] = 10;
  var_4.viewclamps["left"] = 180;
  var_4.viewclamps["right"] = 180;
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4.ref_13e8a = getcompleteweaponname("tur_apc_rus_mp");
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "front_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["driver", "middle_left", "back_left", "middle_right", "front"];
  var_4.animtag = "tag_seat_1";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "front_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_right", "back_right", "middle_left", "front"];
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_left";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_left", "back_left", "middle_right", "front"];
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back_right";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_right", "back_right", "middle_left", "front"];
  var_4.animtag = "tag_seat_4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "back";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "back_right", "middle_left", "middle_right", "front"];
  var_4.animtag = "tag_seat_5";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
}

function apc_rus_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("apc_russian", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("apc_russian", "single", ["driver", "front_right", "back_right", "back", "back_left", "front_left"]);
}

function c130airdrop_spawn() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("apc_russian", 1);
  var_0.challengeevaluator = 2.33333;
  var_0.keycardlocs_chosen = 0.66666;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 2.5;
  var_0.isallowedweapon = 10;
  var_0.isakimbo = 20;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function c130deliveriesinprogress() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("apc_russian", 1);
  var_0.id = 15;
  var_0.seatids["driver"] = 0;
  var_0.seatids["front_left"] = 1;
  var_0.seatids["front_right"] = 2;
  var_0.seatids["back_right"] = 4;
  var_0.seatids["back_left"] = 3;
  var_0.seatids["back"] = 5;
  var_0.brtruck_initdialog["driverTurret"] = 0;
  var_0.ref_12da2["chassis"] = 0;
  var_0.ref_12da2["turret"] = 1;
  var_0.ref_12da3["driver"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["driver"]["tur_apc_rus_mp"] = "turret";
  var_0.ref_12da3["front_left"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["front_left"]["tur_apc_rus_mp"] = "turret";
  var_0.ref_12da3["front_right"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["front_right"]["tur_apc_rus_mp"] = "turret";
  var_0.ref_12da3["back_right"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["back_right"]["tur_apc_rus_mp"] = "turret";
  var_0.ref_12da3["back_left"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["back_left"]["tur_apc_rus_mp"] = "turret";
  var_0.ref_12da3["back"]["apc_rus_mp"] = "chassis";
  var_0.ref_12da3["back"]["tur_apc_rus_mp"] = "turret";
}

function c130airdrop_startdelivery() {
  var_0 = getdvarint("scr_gw_apc_health_override", 4000);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("apc_russian", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("apc_russian");
  var_1.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("apc_russian");
  var_2 = getdvarint("scr_gw_apc_hits_override", 18);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("apc_russian", var_2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14176("apc_russian", &apc_rus_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("apc_russian", &c4_charge_detonate_think);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("apc_russian", &apc_rus_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("tur_apc_rus_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("apc_rus_mp", 5);
}

function apc_rus_initfx() {
  level._effect["apc_rus_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_exp.vfx");
  level._effect["apc_rus_explode_alt"] = loadfx("vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_west_exp.vfx");
}

function apc_rus_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(istrue(var_0.usealtmodel)) {
    var_0.modelname = "veh8_mil_lnd_vindia_a1_west_physics_mp";
  } else {
    var_0.modelname = "veh8_mil_lnd_vindia_a1_physics_mp";
  }

  var_0.targetname = "apc_russian";
  var_0.vehicletype = "vindia_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = apc_rus_createturret(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_3, getcompleteweaponname("tur_apc_rus_mp"), 1);
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "apc_russian", var_0);
  var_2.objweapon = getcompleteweaponname("apc_rus_mp");
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414c(var_2, 1);
  var_4.lb_mg_impulse_dmg_threshold_low = "none";
  var_4.lb_mg_dmg_factor_landing_gear = "kill_apc_rus";
  var_4.lb_mg_dmg_factor_main_rotor = 1;
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  thread c130deliverydirection();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "create")]](var_2);
  }

  return var_2;
}

function apc_rus_createturret(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_apc_rus_mp", 0);
  var_2.angles = var_0 gettagangles("tag_turret");
  var_2 linkTo(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1.usealtmodel)) {
    var_2 setModel("veh8_mil_lnd_vindia_a1_turret_west_mp");
  } else {
    var_2 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  }

  var_2 setmode("sentry_offline");
  var_2 setsentryowner(undefined);
  var_2 makeunusable();
  var_2 setdefaultdroppitch(0);
  var_2 setturretmodechangewait(1);
  var_2.vehicle = var_0;
  return var_2;
}

function apc_rus_explode(var_0, var_1) {
  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "processScrapAssist")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "processScrapAssist")]](var_0.attacker);
    }
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "apc_rus_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread apc_rus_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "apc_rus_mp");
    var_4 = scripts\engine\utility::ter_op(istrue(self.spawndata.usealtmodel), "apc_rus_explode_alt", "apc_rus_explode");
    playFX(scripts\engine\utility::getfx(var_4), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_bradley_expl_destr");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function apc_rus_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function apc_rus_premoddamagecallback(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var_0)) {
    return false;
  }

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectorNormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = getdvarfloat("scr_vehicleCriticalRearDot", -0.892);

  if(vectordot(var_5, var_6) < var_8) {
    var_0.use_aitype = c130airdrop_managedrop(var_0);
  }

  return true;
}

function c4_charge_detonate_think(var_0) {
  if(istrue(var_0.use_aitype)) {
    var_0.damage = int(var_0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var_0.attacker, var_0.damage);
  }

  return true;
}

function apc_rus_deathcallback(var_0) {
  thread apc_rus_explode(var_0);
  return true;
}

function c130airdrop_managedrop(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "gl") {
    return (isDefined(var_0.meansofdeath) && var_0.meansofdeath == "MOD_GRENADE");
  }

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "lighttank_tur_ks_mp":
      case "lighttank_tur_mp":
        return (isDefined(var_0.meansofdeath) && (var_0.meansofdeath == "MOD_PROJECTILE" || var_0.meansofdeath == "MOD_RIFLE_BULLET"));
      case "iw8_la_t9freefire_mp":
      case "tur_apc_rus_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_t9standard_mp":
        return (isDefined(var_0.meansofdeath) && var_0.meansofdeath == "MOD_PROJECTILE");
      case "iw8_la_kgolf_mp":
        return (isDefined(var_0.meansofdeath) && var_0.meansofdeath == "MOD_GRENADE");
    }
  }

  return false;
}

function apc_rus_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    apc_rus_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  }

  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
      }
    }

    foreach(var_9 in var_0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
    return;
  }
}

function apc_rus_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 cameradefault();
    var_3 controlslinkTo(var_0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_apc_rus_mp");

    if(isDefined(var_5)) {
      var_5.owner = var_3;
      var_5 setotherent(var_3);
      var_5 setentityowner(var_3);
      var_5 setsentryowner(var_3);
      var_3 remotecontrolturret(var_5);
    }
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  apc_rus_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(var_1 == "driver") {
    thread c130successfulairdrops(var_0);
    return;
  }
}

function apc_rus_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    apc_rus_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function apc_rus_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_apc_rus_mp");

    if(isDefined(var_5)) {
      var_5.owner = undefined;
    }

    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      if(isDefined(var_5)) {
        var_5 setturretdismountorg(var_3.origin);
        var_3 remotecontrolturretoff(var_5);
      }

      var_3 controlsunlink();
    }

    if(isDefined(var_5)) {
      var_5 setotherent(undefined);
      var_5 setentityowner(undefined);
      var_5 setsentryowner(undefined);
    }
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    } else if(istrue(var_0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function apc_rus_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("apc_russian", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = &apc_rus_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "spawnCallback");
  var_0.clearancecheckradius = 150;
  var_0.clearancecheckheight = 135;
  var_0.clearancecheckminradius = 150;
}

function apc_rus_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("apcrussian_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

function c4_crate_player_at_max_ammo(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

function c130deliverydirection() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var_0 endon("death");
  var_0.shotsleft = 14;
  c4_crate_spawn();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::ref_143ad("turret_fire", "turret_reload");

    if(var_1 == "turret_reload") {
      var_0.shotsleft = 0;
      c4_crate_spawn();
      c130airdrop_oncrateuse();
      continue;
    }

    c130airdrop_isnearotherdrop(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(var_0.shotsleft <= 0) {
      c130airdrop_oncrateuse();
    }
  }
}

function c130airdrop_oncrateuse() {
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var_0 turretfiredisable();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var_1)) {
    var_1 playlocalsound("weap_bradley_reload_plr");
  }

  foreach(var_3 in level.teamnamelist) {
    self playsoundtoteam("weap_bradley_reload_npc", var_3, var_1);
  }

  wait 2.7;
  c130airdrop_isnearotherdrop(14);
  wait 0.15;
  var_0 turretfireenable();
}

function c130successfulairdrops(var_0) {
  self endon("death");
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");

  if(isDefined(var_0)) {
    var_0 endon("vehicle_change_seat");
    var_0 endon("vehicle_seat_exit");
    var_0 endon("death_or_disconnect");

    while(var_0 isbnetkr15player()) {
      waitframe();
    }

    var_2 = getdvarint("bg_useholdtimeshort", 250) / 1000;

    for(;;) {
      var_3 = 0;
      var_4 = var_0 ismlgfreecamenabled();

      while(var_0 isbnetkr15player()) {
        if(!var_0 usinggamepad() && var_1.shotsleft < 14) {
          var_1 notify("turret_reload");
          break;
        }

        if(var_1.shotsleft < 14 && var_4 > 0 && var_3 >= var_2) {
          var_1 notify("turret_reload");
        }

        var_3 += level.framedurationseconds;
        waitframe();
      }

      if(var_0 usinggamepad() && var_1.shotsleft < 14 && (var_4 == 0 && var_3 > 0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2)) {
        var_1 notify("turret_reload");
      }

      waitframe();
    }

    return;
  }
}

function c130airdrop_isnearotherdrop(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var_1.shotsleft += var_0;
  var_1.shotsleft = int(clamp(var_1.shotsleft, 0, 14));
  c4_crate_spawn();
}

function apc_rus_updateomnvarsonseatenter(var_0, var_1, var_2, var_3) {
  if(var_2 == "driver") {
    c4_crate_spawn(var_0);
    return;
  }
}

function c4_crate_spawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("apc_russian", "driverTurret", var_1.shotsleft, var_0);
    return;
  }
}