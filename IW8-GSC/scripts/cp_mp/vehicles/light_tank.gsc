/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\light_tank.gsc
*************************************************/

function light_tank_init() {
  level.vehicle.lighttank = spawnStruct();
  level.vehicle.lighttank.canautodestruct = 1;
  level.vehicle.lighttank.autodestructdamagepercent = 11;
  level.vehicle.lighttank.cantimeout = 1;
  level.vehicle.lighttank.timeoutduration = 165;
  level.vehicle.lighttank.cantakedamageduringcapture = 1;
  level.vehicle.lighttank.showheadicon = 1;
  level.vehicle.lighttank.showheadicontoenemy = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("light_tank", 1);
  var_0.ref_13FCA = &wheelson_tank_death;
  var_0.destroycallback = &light_tank_explode;
  light_tank_initoccupancy();
  light_tank_initinteract();
  wheelson_delay_allow_attack();
  wheelson_damage_monitor();
  wheelson_build_path();
  light_tank_initentranceanimations();
  light_tank_initfx();
  light_tank_initspawns();
  light_tank_initvo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "init")]]();
  }

  light_tank_initspawning();
  thread light_tank_initlate();
}

function light_tank_initlate() {
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initLate")]]();
    return;
  }
}

function light_tank_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("light_tank", 1);
  var_0.enterstartcallback = &light_tank_enterstart;
  var_0.enterendcallback = &light_tank_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &light_tank_exitend;
  var_0.reentercallback = &light_tank_reenter;
  var_0.updateteamcallback = &light_tank_updateteam;
  var_0.updateownercallback = &light_tank_updateowner;
  var_0.threatbiasgroup = "Killstreak_Ground";
  var_0.exitextents["front"] = 125;
  var_0.exitextents["back"] = 115;
  var_0.exitextents["left"] = 70;
  var_0.exitextents["right"] = 70;
  var_0.exitextents["top"] = 130;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (90, 0, 75);
  var_0.exitdirections[var_1] = "front";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-90, 30, 60);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-90, -30, 60);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-90, -12, 60);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "gunner"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("light_tank", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "gunner", "back_left", "back_right", "front"];
  var_0.exitoffsets[var_3] = (35, 15, 60);
  var_0.exitdirections[var_3] = "left";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.restrictions = scripts\engine\utility::array_remove(var_4.restrictions, "fire");
  var_4.hideoccupant = 1;
  var_4.damagemodifier = 0;
  var_4.viewclamps["top"] = 30;
  var_4.viewclamps["bottom"] = 35;
  var_4.viewclamps["left"] = 180;
  var_4.viewclamps["right"] = 180;
  var_4.animtag = "tag_seat_0";
  var_4.spawnpriority = 10;
  var_4.ref_13E8A = getcompleteweaponname("tur_bradley_mp");
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("light_tank", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "back_left", "back_right", "driver", "front"];
  var_0.exitoffsets[var_3] = (-90, -12, 60);
  var_0.exitdirections[var_3] = "back";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_lighttank_mp");
  var_4.ref_12023 = "ping_vehicle_gunner";
}

function wheelson_build_path() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("light_tank", 1);
  var_0.challengeevaluator = 2.5;
  var_0.keycardlocs_chosen = 0.625;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 1.25;
  var_0.isallowedweapon = 5;
  var_0.isakimbo = 10;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function light_tank_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("light_tank", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("light_tank", "single", ["driver", "gunner"]);
}

function wheelson_delay_allow_attack() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("light_tank", 1);
  var_0.id = 1;
  var_0.seatids["driver"] = 0;
  var_0.seatids["gunner"] = 1;
  var_0.brtruck_initdialog["turret"] = 0;
  var_0.brtruck_initdialog["missile"] = 1;
  var_0.brtruck_initdialog["smoke"] = 2;
  var_0.ref_12DA2[0] = 0;
  var_0.ref_12DA2[1] = 1;
  var_0.ref_12DA3["driver"]["lighttank_mp"] = 0;
  var_0.ref_12DA3["driver"]["tur_gun_lighttank_mp"] = 1;
  var_0.ref_12DA3["driver"]["tur_gun_lighttank_ks_mp"] = 1;
  var_0.ref_12DA3["gunner"]["tur_bradley_mp"] = 0;
  var_0.ref_12DA3["gunner"]["tur_bradley_ks_mp"] = 0;
  var_0.ref_12DA3["gunner"]["tur_gun_lighttank_mp"] = 1;
  var_0.ref_12DA3["driver"]["tur_gun_lighttank_ks_mp"] = 1;
}

function wheelson_damage_monitor() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("light_tank", 3000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("light_tank");
  var_0.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("light_tank");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("light_tank", 15);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14176("light_tank", &light_tank_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("light_tank", &light_tank_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("light_tank", &light_tank_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("lighttank_tur_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("lighttank_tur_ks_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("bradley_tow_proj_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("bradley_tow_proj_ks_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("lighttank_mp", 5);
}

#using_animtree("");

function light_tank_initentranceanimations() {
  level.scr_animtree["ac130"] = #animtree;
  level.scr_anim["ac130"]["light_tank_drop"] = $mp_bromeo_drop_acharlie130;
  level.scr_animname["ac130"]["light_tank_drop"] = "mp_bromeo_drop_acharlie130";
  level.scr_animtree["parachute"] = #animtree;
  level.scr_anim["parachute"]["light_tank_drop"] = % mp_bromeo_drop_parachute;
  level.scr_animname["parachute"]["light_tank_drop"] = "mp_bromeo_drop_parachute";
  light_tank_initvehicleentranceanimations();
}

function light_tank_initvehicleentranceanimations() {
  level.scr_animtree["light_tank"] = #animtree;
  level.scr_anim["light_tank"]["light_tank_drop"] = $mp_bromeo_drop_bromeo;
}

function light_tank_initfx() {
  level._effect["light_tank_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
  level._effect["light_tank_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp.vfx");
  level._effect["light_tank_explode_alt"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp_east.vfx");
  level._effect["light_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

function light_tank_initspawns() {
  var_0 = light_tank_getleveldata();
  var_0.dropspawns = scripts\engine\utility::getStructArray("lighttank_drop", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "filterDropSpawns")) {
    var_0.dropspawns = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "filterDropSpawns")]](var_0.dropspawns);
    return;
  }
}

function light_tank_initvo() {
  game["dialog"]["light_tank_low_fuel"] = "light_tank_timeout_reminder";
  game["dialog"]["light_tank_destruct"] = "light_tank_self_destruct";
  game["dialog"]["light_tank_entry"] = "light_tank_chatter_01";
  game["dialog"]["light_tank_chatter_01"] = "light_tank_chatter_02";
  game["dialog"]["light_tank_chatter_02"] = "light_tank_chatter_03";
}

function light_tank_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(wheelson_thermite_damage_over_time(var_0)) {
    var_0.modelname = "veh8_mil_lnd_coscar_east";
  } else {
    var_0.modelname = "veh8_mil_lnd_coscar_west";
  }

  var_0.targetname = "light_tank";
  var_0.vehicletype = "veh_bradley_mp";
  var_0.cannotbesuspended = 1;
  var_0.startsuspended = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.unset_relic_explodedmg = var_0.spawntype == "KILLSTREAK";
  var_3 = light_tank_createdriverturret(var_2, var_0);
  var_3.missilesleft = 2;
  var_3.lastmissilefired = 0;
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_3, getcompleteweaponname("tur_bradley_mp"), 1);
  var_3 = light_tank_creategunnerturret(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_3, getcompleteweaponname("tur_gun_lighttank_mp"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "light_tank", var_0);
  var_2.objweapon = getcompleteweaponname("lighttank_mp");
  light_tank_updateheadicon(var_2);
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414C(var_2, 1);
  var_4.lb_mg_impulse_dmg_threshold_low = "none";

  if(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(var_2)) {
    var_2 scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_2, 0);
  }

  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  var_2 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowsentient(0);
  var_2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &light_tank_flippedendcallback, "flipped_end");
  thread light_tank_monitordriverturretfire();
  thread wheelson_fire_thermite();
  thread wheelson_molotov_damage_over_time();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "create")]](var_2);
  }

  return var_2;
}

function light_tank_createdriverturret(var_0, var_1) {
  var_2 = light_tank_getleveldata();
  var_3 = undefined;

  if(var_0.unset_relic_explodedmg) {
    var_3 = "tur_bradley_ks_mp";
  } else {
    var_3 = "tur_bradley_mp";
  }

  var_4 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), var_3, 0);
  var_4 linkTo(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var_1)) {
    var_4 setModel("veh8_mil_lnd_coscar_east_turret");
  } else {
    var_4 setModel("veh8_mil_lnd_coscar_west_turret");
  }

  var_4 setmode("sentry_offline");
  var_4 setsentryowner(undefined);
  var_4 makeunusable();
  var_4 setdefaultdroppitch(0);
  var_4 setturretmodechangewait(1);
  var_4.angles = var_0.angles;
  var_4.vehicle = var_0;
  return var_4;
}

function light_tank_creategunnerturret(var_0, var_1) {
  var_2 = light_tank_getleveldata();
  var_3 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
  var_4 = undefined;

  if(var_0.unset_relic_explodedmg) {
    var_4 = "tur_gun_lighttank_ks_mp";
  } else {
    var_4 = "tur_gun_lighttank_mp";
  }

  var_5 = spawnturret("misc_turret", var_3 gettagorigin("turret_animate_jnt"), var_4, 0);
  var_5 linkTo(var_3, "turret_animate_jnt", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var_1)) {
    var_5 setModel("veh8_mil_lnd_coscar_east_turret_gun");
  } else {
    var_5 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  }

  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  return var_5;
}

function light_tank_activate() {
  if(istrue(self.isactivated)) {
    return;
  }

  self.isactivated = 1;
  var_0 = light_tank_getleveldata();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var_1 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_1 = 0;
  } else if(isDefined(self.spawndata.showheadicon)) {
    var_1 = self.spawndata.showheadicon;
  } else {
    var_1 = var_0.showheadicon;
  }

  if(var_1) {
    light_tank_createheadicon();
    light_tank_updateheadicon();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowsentient(1);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "activate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "activate")]](self);
    return;
  }
}

function light_tank_explode(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_0.inflictor;
    var_6 = var_0.meansofdeath;
    var_7 = "bradley";
    var_3 = var_0.attacker;
    var_5 = var_0.objweapon;
    var_8 = undefined;
    var_9 = var_0.damage;
    var_10 = "destroyed_" + var_7;
    var_11 = var_7 + "_destroyed";
    var_12 = "callout_destroyed_" + var_7;
    var_13 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
      var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_7, var_3, var_5, var_8, var_9, var_10, var_11, var_12, var_13);
    }
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "lighttank_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(isDefined(self.owner) && isDefined(self.streakinfo)) {
    self.streakinfo.onspray = 1;

    if(!istrue(self.ref_12AA4)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread light_tank_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_15 = self gettagorigin("body_animate_jnt");

    if(!isDefined(var_3)) {
      var_3 = self;
    }

    self radiusdamage(var_15, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "lighttank_mp");
    var_16 = self gettagorigin("tag_origin");
    var_17 = undefined;

    if(wheelson_thermite_damage_over_time(self.spawndata)) {
      var_17 = "light_tank_explode_alt";
    } else {
      var_17 = "light_tank_explode";
    }

    playFX(scripts\engine\utility::getfx(var_17), var_16, anglesToForward(self.angles));
    playsoundatpos(var_16, "veh_bradley_expl_destr");
    earthquake(0.4, 0.7, var_16, 800);
    playrumbleonposition("grenade_rumble", var_16);
    physicsexplosionsphere(var_16, 500, 200, 1);
    return;
  }
}

function wheelson_thermite_damage_over_time(var_0) {
  return istrue(var_0.usealtmodel);
}

function light_tank_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(istrue(self.infreefall)) {
    self physics_unregisterforcollisioncallback();
    self.infreefall = undefined;
  }

  thread light_tank_endcapture(self);
  light_tank_destroyheadicon();

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }

  if(isDefined(self.streakinfo) && isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "delete")]](self);
  }

  waitframe();

  if(isDefined(self.dropspawn)) {
    self.dropspawn.isdisabled = undefined;
    self.dropspawn = undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function light_tank_land(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("light_tank_land"), var_0, anglesToForward(var_1));
  playsoundatpos(var_0, "iw8_bradley_drop_bradley");
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("grenade_rumble", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

function light_tank_initializespawndata(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(!isDefined(var_0.spawnmethod)) {
    var_0.spawnmethod = "airdrop_at_position_unsafe";
  }

  if(!isDefined(var_0.cancapture)) {
    var_0.cancapture = 0;
  }

  if(!isDefined(var_0.cancaptureimmediately)) {
    var_0.cancaptureimmediately = 0;
  }

  if(!isDefined(var_0.activateimmediately)) {
    var_0.activateimmediately = 1;
  }

  if(!isDefined(var_0.faceawayfromowner)) {
    var_0.faceawayfromowner = 0;
  }

  return var_0;
}

function light_tank_copyspawndata(var_0, var_1) {
  var_1.spawnmethod = var_0.spawnmethod;
  var_1.cancapture = var_0.cancapture;
  var_1.cancaptureimmediately = var_0.cancaptureimmediately;
  var_1.activateimmediately = var_0.activateimmediately;
  var_1.faceawayfromowner = var_0.faceawayfromowner;
  var_1.cantimeout = var_0.cantimeout;
  var_1.showheadicon = var_0.showheadicon;
}

function light_tank_spawn(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_0 = light_tank_initializespawndata(var_0);
  var_8 = issubstr(var_0.spawnmethod, "_unsafe");
  var_9 = issubstr(var_0.spawnmethod, "airdrop_");

  if(var_8) {
    var_3 = var_0.origin;
    var_4 = var_0.angles;

    if(isDefined(var_0.owner) && istrue(var_0.faceawayfromowner)) {
      var_10 = var_3 - var_0.owner.origin;

      if(length2dsquared(var_10) > 0) {
        var_4 = vectortoangles(var_3 - var_0.owner.origin);
      } else {
        var_4 = var_0.owner getplayerangles(1);
      }
    }
  } else {
    if(isDefined(var_0.owner) && var_0.spawnmethod == "airdrop_from_player") {
      var_3 = light_tank_getdesiredspawnpositionfromplayer(var_0.owner);
    } else {
      var_3 = var_0.origin;
    }

    var_7 = light_tank_getdropspawn(var_3, var_0);

    if(isDefined(var_7)) {
      if(!isDefined(var_7.angles)) {
        var_7.angles = (0, 0, 0);
      }

      var_3 = var_7.origin;
      var_5 = var_7.origin;
      var_6 = anglestoup(var_7.angles);

      if(isDefined(var_0.owner) && istrue(var_0.faceawayfromowner)) {
        var_10 = var_3 - var_0.owner.origin;

        if(length2dsquared(var_10) > 0) {
          var_4 = vectortoangles(var_3 - var_0.owner.origin);
        } else {
          var_4 = var_0.owner getplayerangles(1);
        }
      }

      var_4 = light_tank_getdropspawnangles(var_4, var_7);

      if(var_9) {
        var_3 += (0, 0, 150);
      } else {
        var_3 += (0, 0, 60);
      }
    } else {
      if(isDefined(var_1)) {
        var_1.fail = "no_spawns_found";
      }

      return undefined;
    }
  }

  if(!isDefined(var_4)) {
    var_4 = (0, randomint(360), 0);
  } else {
    var_4 *= (0, 1, 0);
  }

  var_11 = undefined;

  if(var_9) {
    var_11 = light_tank_airdrop(var_3, var_4, var_5, var_6, var_0, var_1);

    if(isDefined(var_11) && isDefined(var_7)) {
      var_11.dropspawn = var_7;
      var_7.isdisabled = 1;
    }
  } else {
    var_11 = light_tank_place(var_3, var_4, var_0, var_1);
  }

  if(isDefined(var_11) && isDefined(var_0.owner) && isDefined(var_2)) {
    var_11.streakinfo = var_2;
    var_12 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0.owner, var_2.streakname);
      var_12 = 2;
    }

    var_0.owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_bradley", 1, var_12);
  }

  return var_11;
}

function light_tank_place(var_0, var_1, var_2, var_3) {
  var_4 = var_2.origin;
  var_5 = var_2.angles;
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_6 = light_tank_create(var_2, var_3);
  var_2.origin = var_4;
  var_2.angles = var_5;

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(var_2.cancapture) {
    if(var_2.cancaptureimmediately) {
      thread light_tank_startcapture(var_6, var_2.owner, var_2.team);
    }
  } else if(var_2.activateimmediately) {
    thread light_tank_activate();
  }

  return var_6;
}

function light_tank_getdesiredspawnpositionfromplayer(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = max(-5, min(angleclamp180(var_2[0]), 45));
  var_2 = (angleclamp(var_3), var_2[1], var_2[2]);
  var_4 = anglesToForward(var_2);
  var_5 = anglesToForward(var_2 * (0, 1, 0));
  var_6 = var_1;
  var_7 = var_1 + var_4 * 1800;
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_9 = physics_raycast(var_6, var_7, var_8, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_9) && var_9.size > 0) {
    var_7 = var_9[0]["position"];
  }

  var_10 = vectordot(var_7 - var_6, var_5);

  if(var_10 < 400) {
    var_10 = 400;
  }

  var_7 = var_6 + var_5 * var_10;
  return var_7;
}

function light_tank_airdrop(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4.origin;
  var_7 = var_4.angles;
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_8 = light_tank_create(var_4, var_5);
  var_4.origin = var_6;
  var_4.angles = var_7;

  if(!isDefined(var_8)) {
    return undefined;
  }

  var_8.animname = "light_tank";
  var_8 vehphys_forcekeyframedmotion();
  var_8 hide();
  var_9 = scripts\cp_mp\vehicles\vehicle::ref_14193(var_8);

  foreach(var_11 in var_9) {
    var_11 hide();
  }

  var_13 = spawn("script_model", var_0);
  var_13.angles = var_1;
  var_13 setModel("tag_origin");
  var_14 = undefined;

  if(isDefined(var_2)) {
    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_14 = light_tank_createobjective(var_2, var_3, var_4);
      var_8.objent = var_14;
    }
  }

  var_15 = spawn("script_model", var_0);
  var_15.angles = var_1;
  var_15.animname = "parachute";
  var_15 setModel("veh8_mil_lnd_bromeo_parachute");
  var_15 scripts\common\anim::setanimtree();
  var_15 hide();
  var_16 = spawn("script_model", var_0);
  var_16.angles = var_1;
  var_16.animname = "ac130";
  var_16 setModel("veh8_mil_air_acharlie130_ks_carrier");
  var_16 scripts\common\anim::setanimtree();
  var_16 hide();
  var_13.vehicle = var_8;
  var_13.parachute = var_15;
  var_13.carrier = var_16;
  var_13.objent = var_14;
  var_17 = gettime() + level.frameduration;
  var_13.endtime = gettime();
  var_13.vehicleendtime = var_17 + getanimlength(level.scr_anim["light_tank"]["light_tank_drop"]) * 1000;

  if(var_13.vehicleendtime > var_13.endtime) {
    var_13.endtime = var_13.vehicleendtime;
  }

  var_13.parachuteendtime = var_17 + getanimlength(level.scr_anim["parachute"]["light_tank_drop"]) * 1000;

  if(var_13.parachuteendtime > var_13.endtime) {
    var_13.endtime = var_13.parachuteendtime;
  }

  var_13.carrierendtime = var_17 + getanimlength(level.scr_anim["ac130"]["light_tank_drop"]) * 1000;

  if(var_13.carrierendtime > var_13.endtime) {
    var_13.endtime = var_13.carrierendtime;
  }

  thread light_tank_airdropinternal();
  return var_8;
}

function light_tank_airdropinternal() {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, "light_tank_drop");
  scripts\common\anim::anim_first_frame_solo(self.parachute, "light_tank_drop");
  scripts\common\anim::anim_first_frame_solo(self.carrier, "light_tank_drop");
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    var_0 = scripts\cp_mp\vehicles\vehicle::ref_14193(self.vehicle);

    foreach(var_2 in var_0) {
      var_2 show();
    }

    thread scripts\common\anim::anim_single_solo(self.vehicle, "light_tank_drop");
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, "light_tank_drop");
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("iw8_bradley_drop_c130");
    self.carrier setscriptablepartstate("lights2", "on", 0);
    self.carrier setscriptablepartstate("contrails", "on", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, "light_tank_drop");
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime) {
      thread light_tank_detachvehiclefromairdropsequence(self.vehicle);
    }

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime) {
      self.parachute delete();
    }

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime) {
      self.carrier delete();
    }

    waitframe();
  }

  thread light_tank_detachvehiclefromairdropsequence(self.vehicle);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function light_tank_detachvehiclefromairdropsequence(var_0) {
  self.vehicle = undefined;

  if(isDefined(var_0)) {
    var_0 vehphys_setdefaultmotion();
    thread light_tank_startfreefall();
  }

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
    return;
  }
}

function light_tank_startfreefall() {
  self endon("death");
  self.infreefall = 1;
  self physics_registerforcollisioncallback();
  waitframe();
  var_0 = gettime() + 5000;
  var_1 = undefined;
  var_2 = undefined;

  while(gettime() < var_0) {
    if(!isDefined(var_1)) {
      var_1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    } else {
      var_3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var_4 = (var_3 - var_1) / level.framedurationseconds;

      if(isDefined(var_2)) {
        if(var_2 - var_4 >= 300) {
          light_tank_land(self.origin, self.angles);
          break;
        }
      }

      <
      error > = var_1;
      var_0 = var_2;
    }

    waitframe();
  }

  self.infreefall = undefined;
  self physics_unregisterforcollisioncallback();

  while(lengthsquared(self vehicle_getvelocity()) > 400) {
    waitframe();
  }

  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(self.dropspawn)) {
    self.dropspawn.isdisabled = undefined;
    self.dropspawn = undefined;
  }

  if(var_5.cancapture) {
    if(var_5.cancaptureimmediately) {
      thread light_tank_startcapture(self, self.owner, self.team);
      return;
    }

    return;
  }

  if(var_5.activateimmediately) {
    thread light_tank_activate();
    return;
  }
}

function light_tank_createobjective(var_0, var_1, var_2) {
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  var_4 = spawn("script_model", var_0);
  var_4 setModel("ks_airstrike_marker_mp");
  var_5 = (1, 0, 0);
  var_6 = vectorcross(var_5, var_1);
  var_5 = vectorcross(var_1, var_6);
  var_7 = axistoangles(var_5, var_6, var_1);
  var_4.angles = var_7;

  if(var_3 != -1) {
    var_4.objid = var_3;
    objective_onentity(var_3, var_4);
    objective_icon(var_3, "icon_waypoint_tank");
    objective_setzoffset(var_3, 55);
    objective_setplayintro(var_3, 0);
    objective_setplayoutro(var_3, 0);
    objective_setbackground(var_3, 1);
    objective_showtoplayersinmask(var_3);
    objective_state(var_3, "current");

    if(level.teambased) {
      var_8 = var_2.team;

      if(!isDefined(var_8) || var_8 == "neutral") {
        if(isDefined(var_2.owner)) {
          var_8 = var_2.owner.team;
        }
      }

      if(!isDefined(var_8) || var_8 == "neutral") {
        objective_addalltomask(var_3);
        var_4 setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        objective_addteamtomask(var_3, var_8);
        light_tank_setteamotherent(var_4, var_8);
        var_4 setscriptablepartstate("marker_placed", "onTeam", 0);
      }
    } else if(!isDefined(var_2.owner)) {
      objective_addalltomask(var_3);
      var_4 setscriptablepartstate("marker_placed", "onEveryone", 0);
    } else {
      objective_setownerclient(var_3, var_2.owner);
      objective_addclienttomask(var_3, var_2.owner);
      var_4 setotherent(var_2.owner);
      var_4 setscriptablepartstate("marker_placed", "on", 0);
    }
  }

  return var_4;
}

function light_tank_destroyobjective(var_0) {
  if(isDefined(var_0.objid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.objid);
  }

  var_0 delete();
}

function light_tank_setteamotherent(var_0, var_1) {
  var_0 notify("light_tank_setTeamOtherEnt");
  var_0 endon("light_tank_setTeamOtherEnt");
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4.team == var_1) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_0 setotherent(var_2);
    GscBinSkip4(0x35, var_0, var_2);
  }
}

function light_tank_monitorotherentjoined(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_1.team;
  var_1 scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");
  thread light_tank_setteamotherent(var_0, var_2);
}

function light_tank_monitorotherentdisconnect(var_0, var_1) {
  var_2 = var_1.team;
  var_1 waittill("disconnect");
  thread light_tank_setteamotherent(var_0, var_2);
}

function light_tank_startcapture(var_0, var_1, var_2) {
  var_3 = light_tank_getleveldata();

  if(var_3.cantakedamageduringcapture) {
    var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_4 = 0;
  } else if(isDefined(var_0.spawndata.showheadicon)) {
    var_4 = var_0.spawndata.showheadicon;
  } else {
    var_4 = var_3.showheadicon;
  }

  if(var_4) {
    light_tank_createheadicon(var_0, 1);
    light_tank_updateheadicon(var_0, var_1, var_2);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "startCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "startCapture")]](var_0, var_1, var_2);
    return;
  }
}

function light_tank_endcapture(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "endCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "endCapture")]](var_0);
    return;
  }
}

function light_tank_capture(var_0, var_1) {
  thread light_tank_endcapture(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, var_1.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setowner(var_0, var_1);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_0, "driver", var_1);
  thread light_tank_activate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](var_1, var_0);
    return;
  }
}

function wheelson_tank_death(var_0) {
  if(scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return;
  }

  light_tank_updatetimeout();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

function light_tank_monitordriverturretfire() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_0 endon("death");
  var_0.shotsleft = 8;
  light_tank_updatedriverturretammoui();
  light_tank_updatemissileammoui();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::ref_143AD("turret_fire", "turret_reload");

    if(var_1 == "turret_reload") {
      var_0.shotsleft = 0;
      light_tank_updatedriverturretammoui();
      light_tank_driverturretreload();
      continue;
    }

    light_tank_turretdustkickup();
    light_tank_adjustdriverturretammo(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(var_0.shotsleft <= 0) {
      light_tank_driverturretreload();
    }
  }
}

function wheelson_fire_thermite() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("turret_fire", var_1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");
    thread whistlestarttimer_internal(var_1);

    if(isDefined(self.streakinfo)) {
      var_1.streakinfo = self.streakinfo;
      self.streakinfo.shots_fired++;
    }
  }
}

function whistlestarttimer_internal(var_0) {
  level endon("game_ended");
  self waittill("explode", var_1);

  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1, 175, 175, var_0.team, 1, var_0, 1);
    return;
  }
}

function light_tank_monitordriverturretreload(var_0) {
  self endon("death");
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");

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
        if(!var_0 usinggamepad() && var_1.shotsleft < 8) {
          var_1 notify("turret_reload");
          break;
        }

        if(var_1.shotsleft < 8 && var_4 > 0 && var_3 >= var_2) {
          var_1 notify("turret_reload");
        }

        var_3 += level.framedurationseconds;
        waitframe();
      }

      if(var_0 usinggamepad() && var_1.shotsleft < 8 && (var_4 == 0 && var_3 > 0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2)) {
        var_1 notify("turret_reload");
      }

      waitframe();
    }

    return;
  }
}

function light_tank_adjustdriverturretammo(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_1.shotsleft += var_0;
  var_1.shotsleft = int(clamp(var_1.shotsleft, 0, 8));
  light_tank_updatedriverturretammoui();
}

function light_tank_updatedriverturretammoui() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "turret", var_1.shotsleft, var_0);
    return;
  }
}

function light_tank_driverturretreload() {
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_0 turretfiredisable();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var_1)) {
    thread scripts\mp\utility\sound::playplayerandnpcsounds(var_1, "weap_bradley_reload_plr", "weap_bradley_reload_npc");
  }

  wait 2.7;
  light_tank_adjustdriverturretammo(8);
  wait 0.15;
  var_0 turretfireenable();
}

function whistlestarttimer() {
  self notify("watch_missile_input_change");
  self endon("watch_missile_input_change");

  for(;;) {
    var_0 = weight_spawners_closest_to_forward();
    self notifyonplayercommand("light_tank_missile", var_0);
    var_1 = scripts\engine\utility::ref_143B4("input_type_changed", "missile_handling_ended");
    self notifyonplayercommandremove("light_tank_missile", var_0);

    if(!isDefined(var_1) || var_1 == "missile_handling_ended") {
      break;
    }
  }
}

function wheelson_remote_tank_think() {
  self notify("missile_handling_ended");
}

function weight_spawners_closest_to_forward() {
  return "+frag";
}

function light_tank_monitordrivermissilefire(var_0) {
  self endon("death");
  self endon("light_tank_driver_exit");

  for(;;) {
    var_0 waittill("light_tank_missile");
    var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");

    if(gettime() - var_1.lastmissilefired >= 1330) {
      if(var_1.missilesleft > 0) {
        var_1.lastmissilefired = gettime();
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D2(var_0);
        light_tank_firemissile(var_0, var_0.stingertarget);
        light_tank_adjustmissileammo(-1);
      }
    }
  }
}

function light_tank_firemissile(var_0, var_1) {
  wait 0.33;
  var_2 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_3 = var_2 gettagorigin("tag_flash");
  var_4 = var_2 gettagangles("tag_flash");
  var_5 = var_3 + anglesToForward(var_4);
  GscBinSkip4(0x6e, var_0);
}

function light_tank_adjustmissileammo(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var_1.missilesleft += var_0;
  var_1.missilesleft = int(clamp(var_1.missilesleft, 0, 2));
  light_tank_updatemissileammoui();
}

function light_tank_updatemissileammoui() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "missile", var_1.missilesleft, var_0);
    return;
  }
}

function light_tank_playmissilefireplayerfx() {
  self endon("disconnect");
  self setblurforplayer(0.333, 0.1);
  wait 0.15;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_heavydamagefeedbackforplayer();
  wait 0.35;
  light_tank_endmissilefireplayerfx();
}

function light_tank_endmissilefireplayerfx(var_0) {
  if(!istrue(var_0)) {
    self setblurforplayer(0, 0.1);
    return;
  }

  self setblurforplayer(0, 0);
}

function wheelson_molotov_damage_over_time() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_gun_lighttank_mp");

  for(;;) {
    var_0 waittill("turret_fire");

    if(isDefined(self.streakinfo)) {
      self.streakinfo.shots_fired++;
    }
  }
}

function light_tank_updateautodestructui(var_0) {
  var_1 = light_tank_getleveldata();

  if(var_1.canautodestruct) {
    if(istrue(self.autodestructactivated)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", var_0, "light_tank");
      return;
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var_0, "light_tank");
    return;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var_0, "light_tank");
}

function light_tank_updatetimeoutui(var_0, var_1) {
  var_2 = light_tank_getleveldata();

  if(light_tank_cantimeout()) {
    if(!isDefined(var_1)) {
      var_1 = (var_2.timeoutduration - self.timeelapsed) / var_2.timeoutduration;
      var_1 = clamp(var_1, 0, 1);
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_settimepercent(var_1, var_0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showtime(var_0);
    return;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_cleartimepercent(var_0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidetime(var_0);
}

function light_tank_updatetimeout() {
  if(light_tank_cantimeout()) {
    if(!isDefined(self.timeelapsed)) {
      self.timeelapsed = 0;
    }

    if(istrue(self.isactivated)) {
      self.timeelapsed += level.framedurationseconds;
      var_0 = light_tank_getleveldata();
      var_1 = (var_0.timeoutduration - self.timeelapsed) / var_0.timeoutduration;
      var_1 = int(ceil(clamp(var_1, 0, 1) * 100));

      if(self.timeelapsed >= var_0.timeoutduration) {
        thread light_tank_timeout();
        return;
      }

      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(var_4 in var_2) {
        light_tank_updatetimeoutui(var_4, var_1);
      }

      return;
    }

    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var_4 in var_2) {
      light_tank_updatetimeoutui(var_4, 1);
    }

    return;
  }

  self.timeelapsed = undefined;
}

function light_tank_timeout() {
  if(light_tank_canautodestruct()) {
    thread light_tank_autodestruct();
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var_2 in var_0) {
      light_tank_updatetimeoutui(var_2, undefined);
    }

    return;
  }

  thread light_tank_explode(undefined, 0, 1);
}

function light_tank_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_lighttank_mp", var_4, 1);
    return;
  }
}

function light_tank_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread light_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "gunner") {
      wheelson_remote_tank_follow_path(var_3);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
      return;
    }

    return;
  }
}

function light_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
    var_5.owner = var_3;
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 remotecontrolturret(var_5);
    thread whistlestarttimer();
    thread light_tank_monitordrivermissilefire(var_0);
    var_3 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  } else if(var_1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_gun_lighttank_mp");
    var_5.owner = var_3;
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_5);
    week(var_3);
  }

  if(!isDefined(var_2)) {
    light_tank_updateheadiconforplayer(var_0, var_3);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  light_tank_updateplayeromnvarsonenter(var_0, var_2, var_1, var_3);

  if(var_1 == "driver") {
    thread light_tank_monitordriverturretreload(var_0);
    return;
  }
}

function light_tank_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread light_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function light_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 notify("light_tank_driver_exit");
    wheelson_remote_tank_think();
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
    var_5.owner = undefined;
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_5 setturretdismountorg(var_3.origin);
      var_3 remotecontrolturretoff(var_5);
      var_3 controlsunlink();

      if(!istrue(var_4.playerdeath)) {
        light_tank_endmissilefireplayerfx(var_3, 1);
      }

      var_3 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    }

    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
  } else if(var_1 == "gunner") {
    var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_gun_lighttank_mp");

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);

      if(!istrue(var_4.playerdeath)) {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
      }
    }

    var_5.owner = undefined;
    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
    wheelson_remote_tank_follow_path(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(!isDefined(var_2)) {
      light_tank_updateheadiconforplayer(var_0, var_3);
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function light_tank_reenter(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    thread light_tank_monitordrivermissilefire(var_0);
  }

  if(isDefined(var_2) && var_2 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
    return;
  }
}

function week(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, &wheels_fx);
}

function wheelson_remote_tank_follow_path(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = undefined;
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

function wheels_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "iw8_la_t9launcher_mp":
    case "tur_bradley_ks_mp":
    case "tur_bradley_mp":
    case "iw8_la_t9freefire_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
    case "tur_apc_rus_mp":
    case "bradley_tow_proj_ks_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_t9standard_mp":
      return 0;
    default:
      return 1;
  }
}

function whistlestarttime(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  level waittill("game_ended");
  self.ref_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_0);
}

function light_tank_premoddamagecallback(var_0) {
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

  if(vectordot(var_5, var_6) < -0.83) {
    var_0.use_aitype = canweapondealcriticaldamage(var_0);
  }

  return true;
}

function canweapondealcriticaldamage(var_0) {
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

function light_tank_postmoddamagecallback(var_0) {
  if(istrue(var_0.use_aitype)) {
    var_0.damage = int(var_0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var_0.attacker, var_0.damage);
  }

  return true;
}

function light_tank_deathcallback(var_0) {
  thread light_tank_explode(var_0);
  return true;
}

function light_tank_autodestruct(var_0) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!scripts\common\utility::iscp()) {
      var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414B(self);
      self.health = int(min(self.health, var_1));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      scripts\cp_mp\vehicles\vehicle_damage::ref_1417F();
      return;
    }

    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var_4 in var_2) {
      light_tank_updateautodestructui(var_4);
    }

    wait 5.5;
    thread light_tank_explode(undefined, undefined, 1);
    return;
  }
}

function light_tank_turretdustkickup() {
  var_0 = physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  var_1 = self getlinkedchildren();

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  GscBinSkip0(0x2e, var_1.size, self);
}

function light_tank_createheadicon(var_0) {
  var_1 = self.headicon;

  if(!isDefined(var_1)) {
    var_2 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    var_1 = var_2 scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(var_1)) {
      return 0;
    }

    self.headicon = var_1;
    addclienttoheadiconmask(var_1, 55);
  }

  self.headiconforcapture = istrue(var_0);
  var_3 = scripts\engine\utility::ter_op(istrue(var_0), 0, 0);
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), 2250, 2250);
  var_5 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  var_6 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  setheadiconmaxdistance(var_1, var_3);
  setheadiconsnaptoedges(var_1, var_4);
  setheadiconzoffset(var_1, var_5);
  setheadicondrawthroughgeo(var_1, var_6);
}

function light_tank_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

function light_tank_updateheadicon(var_0, var_1) {
  if(!isDefined(self.headicon)) {
    return;
  }

  if(isDefined(var_0)) {
    if(isstring(var_0) && var_0 == "none") {
      self.headiconowneroverride = undefined;
    } else {
      self.headiconowneroverride = var_0;
    }
  }

  if(isDefined(var_1)) {
    if(var_1 == "none") {
      self.headiconteamoverride = undefined;
    } else {
      self.headiconteamoverride = var_1;
    }
  }

  light_tank_updateheadiconowner();
  light_tank_updateheadiconteam();
  light_tank_updateheadiconimage();

  foreach(var_3 in level.players) {
    light_tank_updateheadiconforplayer(var_3);
  }
}

function light_tank_updateheadiconforplayer(var_0) {
  if(!isDefined(self.headicon)) {
    return;
  }

  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && var_1 == self) {
    scripts\cp_mp\entityheadicons::ref_1315E(self.headicon, var_0);
    return;
  }

  var_2 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var_2 = self.headiconowneroverride;
  } else {
    var_2 = self.owner;
  }

  var_3 = undefined;

  if(isDefined(self.headiconteamoverride)) {
    var_3 = self.headiconteamoverride;
  } else {
    var_3 = self.team;
  }

  var_4 = light_tank_getleveldata();

  if(level.teambased) {
    if(var_3 == "neutral") {
      if(!isDefined(var_2)) {
        if(true) {
          scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
          return;
        }

        scripts\cp_mp\entityheadicons::ref_1315E(self.headicon, var_0);
        return;
      } else {
        var_3 = var_2.team;
      }
    }

    if(isenemyteam(var_3, var_0.team)) {
      if(istrue(var_4.showheadicontoenemy)) {
        scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
        return;
      }

      scripts\cp_mp\entityheadicons::ref_1315E(self.headicon, var_0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
    return;
  }

  if(!isDefined(var_2)) {
    if(true) {
      scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315E(self.headicon, var_0);
    return;
  }

  if(var_0 != var_2) {
    if(var_4.showheadicontoenemy) {
      scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315E(self.headicon, var_0);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315D(self.headicon, var_0);
}

function light_tank_updateheadiconforplayeronjointeam(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

  foreach(var_3 in var_1) {
    light_tank_updateheadiconforplayer(var_3, var_0);
  }
}

function light_tank_updateheadiconowner() {
  if(level.teambased) {
    return false;
  }

  var_0 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var_0 = self.headiconowneroverride;
  } else {
    var_0 = self.owner;
  }

  if(isDefined(var_0)) {
    createtargetmarkergroup(self.headicon, var_0);
  } else {
    createtargetmarkergroup(self.headicon, undefined);
  }

  return true;
}

function light_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }

  var_0 = light_tank_getheadiconteam();

  if(isDefined(var_0) && var_0 != "neutral") {
    setheadiconowner(self.headicon, var_0);
    return;
  }

  setheadiconowner(self.headicon, undefined);
}

function light_tank_updateheadiconimage() {
  var_0 = light_tank_getleveldata();
  var_1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(var_1) {
    setheadiconenemyimage(self.headicon, level.factionfriendlyheadicon);

    if(true) {
      setheadiconnaturaldistance(self.headicon, level.factionenemyheadicon);
    }

    if(var_0.showheadicontoenemy) {
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);
      return;
    }

    return;
  }

  var_2 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
  var_3 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, var_0.showheadicontoenemy);
  var_4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
  var_5 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
  var_6 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
  setheadiconenemyimage(self.headicon, var_4);

  if(var_2) {
    setheadiconnaturaldistance(self.headicon, var_5);
  }

  if(var_3) {
    setheadiconneutralimage(self.headicon, var_6);
    return;
  }
}

function light_tank_getheadiconteam() {
  var_0 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var_0 = self.headiconowneroverride;
  } else {
    var_0 = self.owner;
  }

  var_1 = undefined;

  if(isDefined(self.headiconteamoverride)) {
    var_1 = self.headiconteamoverride;
  } else {
    var_1 = self.team;
  }

  var_2 = var_1;

  if(!isDefined(var_2) || var_1 == "neutral") {
    if(isDefined(var_0)) {
      var_2 = var_0.team;
    }
  }

  return var_2;
}

function light_tank_tryuse() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("bradley", self);
  return light_tank_tryusefromstruct(var_0);
}

function light_tank_tryusefromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = getcompleteweaponname("ks_gesture_generic_mp");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_1);

  if(!istrue(var_2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit("light_tank", self, self.team)) {
    return false;
  }

  var_3 = spawnStruct();
  light_tank_initializespawndata(var_3);
  var_3.spawnmethod = "airdrop_from_player";
  var_3.faceawayfromowner = 1;
  var_3.cancapture = 1;
  var_3.cancaptureimmediately = 1;
  var_3.team = self.team;
  var_3.owner = self;
  var_3.spawntype = "KILLSTREAK";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) == 1) {
    var_3.usealtmodel = 1;
  }

  var_4 = spawnStruct();
  var_5 = light_tank_spawn(var_3, var_4, var_0);

  if(!isDefined(var_5)) {
    if(isDefined(var_4.fail)) {
      switch (var_4.fail) {
        case "code":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
          }

          break;
        case "total_limit_exceeded":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
          }

          break;
        case "no_spawns_found":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
          }

          break;
        case "no_spawns_in_map":
          break;
      }
    }

    return false;
  }

  if(isDefined(var_0)) {
    var_5.streakinfo = var_0;
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14193(var_5);

    foreach(var_8 in var_6) {
      var_8.streakinfo = var_0;
    }

    thread whistlestarttime(var_5);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("bradley", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_bradley", self);
  }

  return true;
}

function light_tank_hasdropspawns() {
  var_0 = light_tank_getleveldata();

  if(isDefined(var_0)) {
    return (var_0.dropspawns.size > 0);
  }

  return undefined;
}

function light_tank_getdropspawn(var_0, var_1) {
  var_2 = light_tank_getleveldata();

  if(var_2.dropspawns.size > 0) {
    var_3 = sortbydistance(var_2.dropspawns, var_0);
    var_4 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "getDropSpawnIgnoreList")) {
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "getDropSpawnIgnoreList")]](var_4);
    }

    foreach(var_6 in var_3) {
      if(istrue(var_6.isdisabled)) {
        continue;
      }

      var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(var_6.origin, "light_tank", undefined, var_4);

      if(var_7) {
        return var_6;
      }
    }
  }

  return undefined;
}

function light_tank_getdropspawnangles(var_0, var_1) {
  var_0 *= (0, 1, 0);

  if(!isDefined(var_1.spawnflags) || var_1.spawnflags & 0) {
    var_2 = var_1.angles * (0, 1, 0);
    var_3 = vectordot(anglesToForward(var_0), anglesToForward(var_2));

    if(var_3 < 0) {
      var_0 = (0, angleclamp180(var_2[1] + 180), 0);
    }
  }

  return var_0;
}

function light_tank_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var_0.maxinstancecount = 4;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &light_tank_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "spawnCallback");
  var_0.clearancecheckradius = 130;
  var_0.clearancecheckheight = 1000;
  var_0.clearancecheckminradius = 130;
}

function light_tank_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("lighttank_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

function light_tank_getleveldata() {
  return level.vehicle.lighttank;
}

function light_tank_updateteam(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::ref_14193(var_0);

  foreach(var_5 in var_3) {
    var_5.team = var_1;
  }

  if(isDefined(var_0.headicon)) {
    if(var_2) {
      light_tank_updateheadiconteam(var_0);
      light_tank_updateheadiconimage(var_0);

      foreach(var_8 in level.players) {
        light_tank_updateheadiconforplayer(var_0, var_8);
      }

      return;
    }

    return;
  }
}

function light_tank_updateowner(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.headicon)) {
    if(var_2) {
      light_tank_updateheadiconowner(var_0);
    }

    if(var_3) {
      light_tank_updateheadiconteam(var_0);
      light_tank_updateheadiconimage(var_0);
    }

    if(var_2 || var_3) {
      foreach(var_5 in level.players) {
        light_tank_updateheadiconforplayer(var_0, var_5);
      }

      return;
    }

    return;
  }
}

function light_tank_shouldautodestructfromdamage(var_0) {
  if(!light_tank_canautodestruct()) {
    return 0;
  }

  var_1 = light_tank_getleveldata();

  if(var_1.autodestructdamagepercent > 0) {
    var_2 = max(self.health - var_0.damage, 0);
    return (floor(var_2 / self.maxhealth * 100) <= var_1.autodestructdamagepercent);
  }

  return 0;
}

function light_tank_canautodestruct() {
  if(istrue(self.autodestructactivated)) {
    return false;
  }

  var_0 = light_tank_getleveldata();

  if(!var_0.canautodestruct) {
    return false;
  }

  return true;
}

function light_tank_cantimeout() {
  if(!light_tank_cantimeoutinternal()) {
    return false;
  }

  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(var_0.cantimeout) && var_0.cantimeout == 0) {
    return false;
  }

  var_1 = light_tank_getleveldata();

  if(!var_1.cantimeout) {
    return false;
  }

  if(var_1.timeoutduration <= 0) {
    return false;
  }

  return true;
}

function light_tank_cantimeoutinternal() {
  if(istrue(self.autodestructactivated)) {
    return false;
  }

  return true;
}

function light_tank_supported(var_0) {
  return light_tank_hasdropspawns();
}

function light_tank_updateplayeromnvarsonenter(var_0, var_1, var_2, var_3) {
  if(var_2 == "driver") {
    light_tank_updatedriverturretammoui(var_0);
    light_tank_updatemissileammoui(var_0);
  }

  light_tank_updatetimeoutui(var_0, var_3);
  light_tank_updateautodestructui(var_0, var_3);
}

function light_tank_flippedendcallback(var_0, var_1) {
  if(var_1) {
    light_tank_timeout(var_0);
    return;
  }
}