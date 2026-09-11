/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\apc_rus.gsc
***********************************************/

function apc_rus_init() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("apc_russian", 1);
  var0.ref_13fca = &c4_crate_player_at_max_ammo;
  var0.destroycallback = &apc_rus_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("apc_russian", 1);
  var0.enterendcallback = &apc_rus_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &apc_rus_exitend;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var0.exitextents["front"] = 136;
  var0.exitextents["back"] = 129;
  var0.exitextents["left"] = 68;
  var0.exitextents["right"] = 68;
  var0.exitextents["top"] = 87;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (100, 0, 65);
  var0.exitdirections[var1] = "right";
  var1 = "middle_left";
  var0.exitoffsets[var1] = (-31, 14, 65);
  var0.exitdirections[var1] = "left";
  var1 = "middle_right";
  var0.exitoffsets[var1] = (-31, -20, 65);
  var0.exitdirections[var1] = "right";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-90, 35, 65);
  var0.exitdirections[var1] = "back";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-90, -35, 65);
  var0.exitdirections[var1] = "back";
  var0.damagemodifier = 0;
  var0.hideoccupant = 1;
  var0.camera = "cam_vindia_passenger";
  var0.damagefeedbackgrouplight = "all";
  var0.damagefeedbackgroupheavy = "all";
  var2 = ["driver", "front_right", "back_right", "back", "back_left", "front_left"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "middle_left", "back_left", "middle_right", "front"];
  var0.exitoffsets[var3] = (80, 14, 65);
  var0.exitdirections[var3] = "left";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.restrictions = scripts\engine\utility::array_remove(var4.restrictions, "fire");
  var4.viewclamps["top"] = 30;
  var4.viewclamps["bottom"] = 10;
  var4.viewclamps["left"] = 180;
  var4.viewclamps["right"] = 180;
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.spawnpriority = 10;
  var4.ref_13e8a = getcompleteweaponname("tur_apc_rus_mp");
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "front_left";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["driver", "middle_left", "back_left", "middle_right", "front"];
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "front_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_right", "back_right", "middle_left", "front"];
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_left";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_left", "back_left", "middle_right", "front"];
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back_right";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_right", "back_right", "middle_left", "front"];
  var4.animtag = "tag_seat_4";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "back";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("apc_russian", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back_left", "back_right", "middle_left", "middle_right", "front"];
  var4.animtag = "tag_seat_5";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
}

function apc_rus_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("apc_russian", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("apc_russian", "single", ["driver", "front_right", "back_right", "back", "back_left", "front_left"]);
}

function c130airdrop_spawn() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("apc_russian", 1);
  var0.challengeevaluator = 2.33333;
  var0.keycardlocs_chosen = 0.66666;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 2.5;
  var0.isallowedweapon = 10;
  var0.isakimbo = 20;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function c130deliveriesinprogress() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("apc_russian", 1);
  var0.id = 15;
  var0.seatids["driver"] = 0;
  var0.seatids["front_left"] = 1;
  var0.seatids["front_right"] = 2;
  var0.seatids["back_right"] = 4;
  var0.seatids["back_left"] = 3;
  var0.seatids["back"] = 5;
  var0.brtruck_initdialog["driverTurret"] = 0;
  var0.ref_12da2["chassis"] = 0;
  var0.ref_12da2["turret"] = 1;
  var0.ref_12da3["driver"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["driver"]["tur_apc_rus_mp"] = "turret";
  var0.ref_12da3["front_left"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["front_left"]["tur_apc_rus_mp"] = "turret";
  var0.ref_12da3["front_right"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["front_right"]["tur_apc_rus_mp"] = "turret";
  var0.ref_12da3["back_right"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["back_right"]["tur_apc_rus_mp"] = "turret";
  var0.ref_12da3["back_left"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["back_left"]["tur_apc_rus_mp"] = "turret";
  var0.ref_12da3["back"]["apc_rus_mp"] = "chassis";
  var0.ref_12da3["back"]["tur_apc_rus_mp"] = "turret";
}

function c130airdrop_startdelivery() {
  var0 = getdvarint("scr_gw_apc_health_override", 4000);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("apc_russian", var0);
  var1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("apc_russian");
  var1.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("apc_russian");
  var2 = getdvarint("scr_gw_apc_hits_override", 18);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("apc_russian", var2);
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

function apc_rus_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(istrue(var0.usealtmodel)) {
    var0.modelname = "veh8_mil_lnd_vindia_a1_west_physics_mp";
  } else {
    var0.modelname = "veh8_mil_lnd_vindia_a1_physics_mp";
  }

  var0.targetname = "apc_russian";
  var0.vehicletype = "vindia_physics_mp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var3 = apc_rus_createturret(var2, var0);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var3, getcompleteweaponname("tur_apc_rus_mp"), 1);
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "apc_russian", var0);
  var2.objweapon = getcompleteweaponname("apc_rus_mp");
  var4 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414c(var2, 1);
  var4.lb_mg_impulse_dmg_threshold_low = "none";
  var4.lb_mg_dmg_factor_landing_gear = "kill_apc_rus";
  var4.lb_mg_dmg_factor_main_rotor = 1;
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  thread c130deliverydirection();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "create")]](var2);
  }

  return var2;
}

function apc_rus_createturret(var0, var1) {
  var2 = spawnturret("misc_turret", var0 gettagorigin("tag_turret"), "tur_apc_rus_mp", 0);
  var2.angles = var0 gettagangles("tag_turret");
  var2 linkTo(var0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(istrue(var1.usealtmodel)) {
    var2 setModel("veh8_mil_lnd_vindia_a1_turret_west_mp");
  } else {
    var2 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  }

  var2 setmode("sentry_offline");
  var2 setsentryowner(undefined);
  var2 makeunusable();
  var2 setdefaultdroppitch(0);
  var2 setturretmodechangewait(1);
  var2.vehicle = var0;
  return var2;
}

function apc_rus_explode(var0, var1) {
  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "processScrapAssist")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "processScrapAssist")]](var0.attacker);
    }
  } else {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "apc_rus_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread apc_rus_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "apc_rus_mp");
    var4 = scripts\engine\utility::ter_op(istrue(self.spawndata.usealtmodel), "apc_rus_explode_alt", "apc_rus_explode");
    playFX(scripts\engine\utility::getfx(var4), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "veh_bradley_expl_destr");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function apc_rus_premoddamagecallback(var0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var0)) {
    return false;
  }

  var1 = self.origin - var0.point;
  var2 = anglestoup(self.angles);
  var3 = vectordot(var1, var2);
  var4 = var0.point + var2 * var3;
  var5 = vectorNormalize(var4 - self.origin);
  var6 = anglesToForward(self.angles);
  var7 = anglestoright(self.angles);
  var8 = getdvarfloat("scr_vehicleCriticalRearDot", -0.892);

  if(vectordot(var5, var6) < var8) {
    var0.use_aitype = c130airdrop_managedrop(var0);
  }

  return true;
}

function c4_charge_detonate_think(var0) {
  if(istrue(var0.use_aitype)) {
    var0.damage = int(var0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var0.attacker, var0.damage);
  }

  return true;
}

function apc_rus_deathcallback(var0) {
  thread apc_rus_explode(var0);
  return true;
}

function c130airdrop_managedrop(var0) {
  if(isDefined(var0.inflictor) && isDefined(var0.inflictor.weapon_name) && var0.inflictor.weapon_name == "gl") {
    return (isDefined(var0.meansofdeath) && var0.meansofdeath == "MOD_GRENADE");
  }

  if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename)) {
    switch (var0.objweapon.basename) {
      case "lighttank_tur_ks_mp":
      case "lighttank_tur_mp":
        return (isDefined(var0.meansofdeath) && (var0.meansofdeath == "MOD_PROJECTILE" || var0.meansofdeath == "MOD_RIFLE_BULLET"));
      case "iw8_la_t9freefire_mp":
      case "tur_apc_rus_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_t9standard_mp":
        return (isDefined(var0.meansofdeath) && var0.meansofdeath == "MOD_PROJECTILE");
      case "iw8_la_kgolf_mp":
        return (isDefined(var0.meansofdeath) && var0.meansofdeath == "MOD_GRENADE");
    }
  }

  return false;
}

function apc_rus_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    apc_rus_enterendinternal(var0, var1, var2, var3, var4);
  }

  if(istrue(var0.israllypointvehicle)) {
    foreach(var6 in level.players) {
      if(istrue(var0.revealed) || var6.team == var0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var6);
      }
    }

    foreach(var9 in var0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var3);
    return;
  }
}

function apc_rus_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 cameradefault();
    var3 controlslinkTo(var0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0.1);
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_apc_rus_mp");

    if(isDefined(var5)) {
      var5.owner = var3;
      var5 setotherent(var3);
      var5 setentityowner(var3);
      var5 setsentryowner(var3);
      var3 remotecontrolturret(var5);
    }
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
  apc_rus_updateomnvarsonseatenter(var0, var2, var1, var3);

  if(var1 == "driver") {
    thread c130successfulairdrops(var0);
    return;
  }
}

function apc_rus_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    apc_rus_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function apc_rus_exitendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_apc_rus_mp");

    if(isDefined(var5)) {
      var5.owner = undefined;
    }

    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      if(isDefined(var5)) {
        var5 setturretdismountorg(var3.origin);
        var3 remotecontrolturretoff(var5);
      }

      var3 controlsunlink();
    }

    if(isDefined(var5)) {
      var5 setotherent(undefined);
      var5 setentityowner(undefined);
      var5 setsentryowner(undefined);
    }
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
    } else if(istrue(var0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var3);
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function apc_rus_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("apc_russian", 1);
  var0.maxinstancecount = 30;
  var0.priority = 50;
  var0.getspawnstructscallback = &apc_rus_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "spawnCallback");
  var0.clearancecheckradius = 150;
  var0.clearancecheckheight = 135;
  var0.clearancecheckminradius = 150;
}

function apc_rus_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("apcrussian_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}

function c4_crate_player_at_max_ammo(var0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

function c130deliverydirection() {
  self endon("death");
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var0 endon("death");
  var0.shotsleft = 14;
  c4_crate_spawn();

  for(;;) {
    var1 = var0 scripts\engine\utility::ref_143ad("turret_fire", "turret_reload");

    if(var1 == "turret_reload") {
      var0.shotsleft = 0;
      c4_crate_spawn();
      c130airdrop_oncrateuse();
      continue;
    }

    c130airdrop_isnearotherdrop(-1);
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(var0.shotsleft <= 0) {
      c130airdrop_oncrateuse();
    }
  }
}

function c130airdrop_oncrateuse() {
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var0 turretfiredisable();
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var1)) {
    var1 playlocalsound("weap_bradley_reload_plr");
  }

  foreach(var3 in level.teamnamelist) {
    self playsoundtoteam("weap_bradley_reload_npc", var3, var1);
  }

  wait 2.7;
  c130airdrop_isnearotherdrop(14);
  wait 0.15;
  var0 turretfireenable();
}

function c130successfulairdrops(var0) {
  self endon("death");
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");

  if(isDefined(var0)) {
    var0 endon("vehicle_change_seat");
    var0 endon("vehicle_seat_exit");
    var0 endon("death_or_disconnect");

    while(var0 isbnetkr15player()) {
      waitframe();
    }

    var2 = getdvarint("MQTOLLKKLQ", 250) / 1000;

    for(;;) {
      var3 = 0;
      var4 = var0 ismlgfreecamenabled();

      while(var0 isbnetkr15player()) {
        if(!var0 usinggamepad() && var1.shotsleft < 14) {
          var1 notify("turret_reload");
          break;
        }

        if(var1.shotsleft < 14 && var4 > 0 && var3 >= var2) {
          var1 notify("turret_reload");
        }

        var3 += level.framedurationseconds;
        waitframe();
      }

      if(var0 usinggamepad() && var1.shotsleft < 14 && (var4 == 0 && var3 > 0 && var3 < 0.2 || var4 > 0 && var3 >= var2)) {
        var1 notify("turret_reload");
      }

      waitframe();
    }

    return;
  }
}

function c130airdrop_isnearotherdrop(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var1.shotsleft += var0;
  var1.shotsleft = int(clamp(var1.shotsleft, 0, 14));
  c4_crate_spawn();
}

function apc_rus_updateomnvarsonseatenter(var0, var1, var2, var3) {
  if(var2 == "driver") {
    c4_crate_spawn(var0);
    return;
  }
}

function c4_crate_spawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("apc_russian", "driverTurret", var1.shotsleft, var0);
    return;
  }
}