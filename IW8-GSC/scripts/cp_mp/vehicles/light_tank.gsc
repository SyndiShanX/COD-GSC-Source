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
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("light_tank", 1);
  var0.ref_13fca = &wheelson_tank_death;
  var0.destroycallback = &light_tank_explode;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("light_tank", 1);
  var0.enterstartcallback = &light_tank_enterstart;
  var0.enterendcallback = &light_tank_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &light_tank_exitend;
  var0.reentercallback = &light_tank_reenter;
  var0.updateteamcallback = &light_tank_updateteam;
  var0.updateownercallback = &light_tank_updateowner;
  var0.threatbiasgroup = "Killstreak_Ground";
  var0.exitextents["front"] = 125;
  var0.exitextents["back"] = 115;
  var0.exitextents["left"] = 70;
  var0.exitextents["right"] = 70;
  var0.exitextents["top"] = 130;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (90, 0, 75);
  var0.exitdirections[var1] = "front";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-90, 30, 60);
  var0.exitdirections[var1] = "left";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-90, -30, 60);
  var0.exitdirections[var1] = "right";
  var1 = "back";
  var0.exitoffsets[var1] = (-90, -12, 60);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "gunner"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("light_tank", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "gunner", "back_left", "back_right", "front"];
  var0.exitoffsets[var3] = (35, 15, 60);
  var0.exitdirections[var3] = "left";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.restrictions = scripts\engine\utility::array_remove(var4.restrictions, "fire");
  var4.hideoccupant = 1;
  var4.damagemodifier = 0;
  var4.viewclamps["top"] = 30;
  var4.viewclamps["bottom"] = 35;
  var4.viewclamps["left"] = 180;
  var4.viewclamps["right"] = 180;
  var4.animtag = "tag_seat_0";
  var4.spawnpriority = 10;
  var4.ref_13e8a = getcompleteweaponname("tur_bradley_mp");
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("light_tank", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "back_left", "back_right", "driver", "front"];
  var0.exitoffsets[var3] = (-90, -12, 60);
  var0.exitdirections[var3] = "back";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.ref_13e8a = getcompleteweaponname("tur_gun_lighttank_mp");
  var4.ref_12023 = "ping_vehicle_gunner";
}

function wheelson_build_path() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("light_tank", 1);
  var0.challengeevaluator = 2.5;
  var0.keycardlocs_chosen = 0.625;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 1.25;
  var0.isallowedweapon = 5;
  var0.isakimbo = 10;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function light_tank_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("light_tank", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("light_tank", "single", ["driver", "gunner"]);
}

function wheelson_delay_allow_attack() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("light_tank", 1);
  var0.id = 1;
  var0.seatids["driver"] = 0;
  var0.seatids["gunner"] = 1;
  var0.brtruck_initdialog["turret"] = 0;
  var0.brtruck_initdialog["missile"] = 1;
  var0.brtruck_initdialog["smoke"] = 2;
  var0.ref_12da2[0] = 0;
  var0.ref_12da2[1] = 1;
  var0.ref_12da3["driver"]["lighttank_mp"] = 0;
  var0.ref_12da3["driver"]["tur_gun_lighttank_mp"] = 1;
  var0.ref_12da3["driver"]["tur_gun_lighttank_ks_mp"] = 1;
  var0.ref_12da3["gunner"]["tur_bradley_mp"] = 0;
  var0.ref_12da3["gunner"]["tur_bradley_ks_mp"] = 0;
  var0.ref_12da3["gunner"]["tur_gun_lighttank_mp"] = 1;
  var0.ref_12da3["driver"]["tur_gun_lighttank_ks_mp"] = 1;
}

function wheelson_damage_monitor() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("light_tank", 3000);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("light_tank");
  var0.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("light_tank");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("light_tank", 15);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14176("light_tank", &light_tank_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("light_tank", &light_tank_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("light_tank", &light_tank_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("lighttank_tur_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("lighttank_tur_ks_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("bradley_tow_proj_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("bradley_tow_proj_ks_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("lighttank_mp", 5);
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
  var0 = light_tank_getleveldata();
  var0.dropspawns = scripts\engine\utility::getStructArray("lighttank_drop", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "filterDropSpawns")) {
    var0.dropspawns = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "filterDropSpawns")]](var0.dropspawns);
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

function light_tank_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(wheelson_thermite_damage_over_time(var0)) {
    var0.modelname = "veh8_mil_lnd_coscar_east";
  } else {
    var0.modelname = "veh8_mil_lnd_coscar_west";
  }

  var0.targetname = "light_tank";
  var0.vehicletype = "veh_bradley_mp";
  var0.cannotbesuspended = 1;
  var0.startsuspended = 0;
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var2.unset_relic_explodedmg = var0.spawntype == "KILLSTREAK";
  var3 = light_tank_createdriverturret(var2, var0);
  var3.missilesleft = 2;
  var3.lastmissilefired = 0;
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var3, getcompleteweaponname("tur_bradley_mp"), 1);
  var3 = light_tank_creategunnerturret(var2, var0);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var3, getcompleteweaponname("tur_gun_lighttank_mp"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "light_tank", var0);
  var2.objweapon = getcompleteweaponname("lighttank_mp");
  light_tank_updateheadicon(var2);
  var4 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414c(var2, 1);
  var4.lb_mg_impulse_dmg_threshold_low = "none";

  if(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(var2)) {
    var2 scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var2, 0);
  }

  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  var2 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowsentient(0);
  var2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &light_tank_flippedendcallback, "flipped_end");
  thread light_tank_monitordriverturretfire();
  thread wheelson_fire_thermite();
  thread wheelson_molotov_damage_over_time();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "create")]](var2);
  }

  return var2;
}

function light_tank_createdriverturret(var0, var1) {
  var2 = light_tank_getleveldata();
  var3 = undefined;

  if(var0.unset_relic_explodedmg) {
    var3 = "tur_bradley_ks_mp";
  } else {
    var3 = "tur_bradley_mp";
  }

  var4 = spawnturret("misc_turret", var0 gettagorigin("tag_turret"), var3, 0);
  var4 linkTo(var0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var1)) {
    var4 setModel("veh8_mil_lnd_coscar_east_turret");
  } else {
    var4 setModel("veh8_mil_lnd_coscar_west_turret");
  }

  var4 setmode("sentry_offline");
  var4 setsentryowner(undefined);
  var4 makeunusable();
  var4 setdefaultdroppitch(0);
  var4 setturretmodechangewait(1);
  var4.angles = var0.angles;
  var4.vehicle = var0;
  return var4;
}

function light_tank_creategunnerturret(var0, var1) {
  var2 = light_tank_getleveldata();
  var3 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
  var4 = undefined;

  if(var0.unset_relic_explodedmg) {
    var4 = "tur_gun_lighttank_ks_mp";
  } else {
    var4 = "tur_gun_lighttank_mp";
  }

  var5 = spawnturret("misc_turret", var3 gettagorigin("turret_animate_jnt"), var4, 0);
  var5 linkTo(var3, "turret_animate_jnt", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var1)) {
    var5 setModel("veh8_mil_lnd_coscar_east_turret_gun");
  } else {
    var5 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  }

  var5 setmode("sentry_offline");
  var5 setsentryowner(undefined);
  var5 makeunusable();
  var5 setdefaultdroppitch(0);
  var5 setturretmodechangewait(1);
  var5.angles = var0.angles;
  var5.vehicle = var0;
  return var5;
}

function light_tank_activate() {
  if(istrue(self.isactivated)) {
    return;
  }

  self.isactivated = 1;
  var0 = light_tank_getleveldata();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var1 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var1 = 0;
  } else if(isDefined(self.spawndata.showheadicon)) {
    var1 = self.spawndata.showheadicon;
  } else {
    var1 = var0.showheadicon;
  }

  if(var1) {
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

function light_tank_explode(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var0)) {
    var4 = var0.inflictor;
    var6 = var0.meansofdeath;
    var7 = "bradley";
    var3 = var0.attacker;
    var5 = var0.objweapon;
    var8 = undefined;
    var9 = var0.damage;
    var10 = "destroyed_" + var7;
    var11 = var7 + "_destroyed";
    var12 = "callout_destroyed_" + var7;
    var13 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
      var14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var7, var3, var5, var8, var9, var10, var11, var12, var13);
    }
  } else {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "lighttank_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(isDefined(self.owner) && isDefined(self.streakinfo)) {
    self.streakinfo.onspray = 1;

    if(!istrue(self.ref_12aa4)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread light_tank_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var15 = self gettagorigin("body_animate_jnt");

    if(!isDefined(var3)) {
      var3 = self;
    }

    self radiusdamage(var15, 256, 140, 70, var3, "MOD_EXPLOSIVE", "lighttank_mp");
    var16 = self gettagorigin("tag_origin");
    var17 = undefined;

    if(wheelson_thermite_damage_over_time(self.spawndata)) {
      var17 = "light_tank_explode_alt";
    } else {
      var17 = "light_tank_explode";
    }

    playFX(scripts\engine\utility::getfx(var17), var16, anglesToForward(self.angles));
    playsoundatpos(var16, "veh_bradley_expl_destr");
    earthquake(0.4, 0.7, var16, 800);
    playrumbleonposition("grenade_rumble", var16);
    physicsexplosionsphere(var16, 500, 200, 1);
    return;
  }
}

function wheelson_thermite_damage_over_time(var0) {
  return istrue(var0.usealtmodel);
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

function light_tank_land(var0, var1) {
  playFX(scripts\engine\utility::getfx("light_tank_land"), var0, anglesToForward(var1));
  playsoundatpos(var0, "iw8_bradley_drop_bradley");
  earthquake(0.3, 0.7, var0, 800);
  playrumbleonposition("grenade_rumble", var0);
  physicsexplosionsphere(var0, 800, 400, 0.5);
}

function light_tank_initializespawndata(var0) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
  }

  if(!isDefined(var0.spawnmethod)) {
    var0.spawnmethod = "airdrop_at_position_unsafe";
  }

  if(!isDefined(var0.cancapture)) {
    var0.cancapture = 0;
  }

  if(!isDefined(var0.cancaptureimmediately)) {
    var0.cancaptureimmediately = 0;
  }

  if(!isDefined(var0.activateimmediately)) {
    var0.activateimmediately = 1;
  }

  if(!isDefined(var0.faceawayfromowner)) {
    var0.faceawayfromowner = 0;
  }

  return var0;
}

function light_tank_copyspawndata(var0, var1) {
  var1.spawnmethod = var0.spawnmethod;
  var1.cancapture = var0.cancapture;
  var1.cancaptureimmediately = var0.cancaptureimmediately;
  var1.activateimmediately = var0.activateimmediately;
  var1.faceawayfromowner = var0.faceawayfromowner;
  var1.cantimeout = var0.cantimeout;
  var1.showheadicon = var0.showheadicon;
}

function light_tank_spawn(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var0 = light_tank_initializespawndata(var0);
  var8 = issubstr(var0.spawnmethod, "_unsafe");
  var9 = issubstr(var0.spawnmethod, "airdrop_");

  if(var8) {
    var3 = var0.origin;
    var4 = var0.angles;

    if(isDefined(var0.owner) && istrue(var0.faceawayfromowner)) {
      var10 = var3 - var0.owner.origin;

      if(length2dsquared(var10) > 0) {
        var4 = vectortoangles(var3 - var0.owner.origin);
      } else {
        var4 = var0.owner getplayerangles(1);
      }
    }
  } else {
    if(isDefined(var0.owner) && var0.spawnmethod == "airdrop_from_player") {
      var3 = light_tank_getdesiredspawnpositionfromplayer(var0.owner);
    } else {
      var3 = var0.origin;
    }

    var7 = light_tank_getdropspawn(var3, var0);

    if(isDefined(var7)) {
      if(!isDefined(var7.angles)) {
        var7.angles = (0, 0, 0);
      }

      var3 = var7.origin;
      var5 = var7.origin;
      var6 = anglestoup(var7.angles);

      if(isDefined(var0.owner) && istrue(var0.faceawayfromowner)) {
        var10 = var3 - var0.owner.origin;

        if(length2dsquared(var10) > 0) {
          var4 = vectortoangles(var3 - var0.owner.origin);
        } else {
          var4 = var0.owner getplayerangles(1);
        }
      }

      var4 = light_tank_getdropspawnangles(var4, var7);

      if(var9) {
        var3 += (0, 0, 150);
      } else {
        var3 += (0, 0, 60);
      }
    } else {
      if(isDefined(var1)) {
        var1.fail = "no_spawns_found";
      }

      return undefined;
    }
  }

  if(!isDefined(var4)) {
    var4 = (0, randomint(360), 0);
  } else {
    var4 *= (0, 1, 0);
  }

  var11 = undefined;

  if(var9) {
    var11 = light_tank_airdrop(var3, var4, var5, var6, var0, var1);

    if(isDefined(var11) && isDefined(var7)) {
      var11.dropspawn = var7;
      var7.isdisabled = 1;
    }
  } else {
    var11 = light_tank_place(var3, var4, var0, var1);
  }

  if(isDefined(var11) && isDefined(var0.owner) && isDefined(var2)) {
    var11.streakinfo = var2;
    var12 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var0.owner, var2.streakname);
      var12 = 2;
    }

    var0.owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_bradley", 1, var12);
  }

  return var11;
}

function light_tank_place(var0, var1, var2, var3) {
  var4 = var2.origin;
  var5 = var2.angles;
  var2.origin = var0;
  var2.angles = var1;
  var6 = light_tank_create(var2, var3);
  var2.origin = var4;
  var2.angles = var5;

  if(!isDefined(var6)) {
    return undefined;
  }

  if(var2.cancapture) {
    if(var2.cancaptureimmediately) {
      thread light_tank_startcapture(var6, var2.owner, var2.team);
    }
  } else if(var2.activateimmediately) {
    thread light_tank_activate();
  }

  return var6;
}

function light_tank_getdesiredspawnpositionfromplayer(var0) {
  var1 = var0 getEye();
  var2 = var0 getplayerangles();
  var3 = max(-5, min(angleclamp180(var2[0]), 45));
  var2 = (angleclamp(var3), var2[1], var2[2]);
  var4 = anglesToForward(var2);
  var5 = anglesToForward(var2 * (0, 1, 0));
  var6 = var1;
  var7 = var1 + var4 * 1800;
  var8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var9 = physics_raycast(var6, var7, var8, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var9) && var9.size > 0) {
    var7 = var9[0]["position"];
  }

  var10 = vectordot(var7 - var6, var5);

  if(var10 < 400) {
    var10 = 400;
  }

  var7 = var6 + var5 * var10;
  return var7;
}

function light_tank_airdrop(var0, var1, var2, var3, var4, var5) {
  var6 = var4.origin;
  var7 = var4.angles;
  var4.origin = var0;
  var4.angles = var1;
  var8 = light_tank_create(var4, var5);
  var4.origin = var6;
  var4.angles = var7;

  if(!isDefined(var8)) {
    return undefined;
  }

  var8.animname = "light_tank";
  var8 vehphys_forcekeyframedmotion();
  var8 hide();
  var9 = scripts\cp_mp\vehicles\vehicle::ref_14193(var8);

  foreach(var11 in var9) {
    var11 hide();
  }

  var13 = spawn("script_model", var0);
  var13.angles = var1;
  var13 setModel("tag_origin");
  var14 = undefined;

  if(isDefined(var2)) {
    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var14 = light_tank_createobjective(var2, var3, var4);
      var8.objent = var14;
    }
  }

  var15 = spawn("script_model", var0);
  var15.angles = var1;
  var15.animname = "parachute";
  var15 setModel("veh8_mil_lnd_bromeo_parachute");
  var15 scripts\common\anim::setanimtree();
  var15 hide();
  var16 = spawn("script_model", var0);
  var16.angles = var1;
  var16.animname = "ac130";
  var16 setModel("veh8_mil_air_acharlie130_ks_carrier");
  var16 scripts\common\anim::setanimtree();
  var16 hide();
  var13.vehicle = var8;
  var13.parachute = var15;
  var13.carrier = var16;
  var13.objent = var14;
  var17 = gettime() + level.frameduration;
  var13.endtime = gettime();
  var13.vehicleendtime = var17 + getanimlength(level.scr_anim["light_tank"]["light_tank_drop"]) * 1000;

  if(var13.vehicleendtime > var13.endtime) {
    var13.endtime = var13.vehicleendtime;
  }

  var13.parachuteendtime = var17 + getanimlength(level.scr_anim["parachute"]["light_tank_drop"]) * 1000;

  if(var13.parachuteendtime > var13.endtime) {
    var13.endtime = var13.parachuteendtime;
  }

  var13.carrierendtime = var17 + getanimlength(level.scr_anim["ac130"]["light_tank_drop"]) * 1000;

  if(var13.carrierendtime > var13.endtime) {
    var13.endtime = var13.carrierendtime;
  }

  thread light_tank_airdropinternal();
  return var8;
}

function light_tank_airdropinternal() {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, "light_tank_drop");
  scripts\common\anim::anim_first_frame_solo(self.parachute, "light_tank_drop");
  scripts\common\anim::anim_first_frame_solo(self.carrier, "light_tank_drop");
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    var0 = scripts\cp_mp\vehicles\vehicle::ref_14193(self.vehicle);

    foreach(var2 in var0) {
      var2 show();
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

function light_tank_detachvehiclefromairdropsequence(var0) {
  self.vehicle = undefined;

  if(isDefined(var0)) {
    var0 vehphys_setdefaultmotion();
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
  var0 = gettime() + 5000;
  var1 = undefined;
  var2 = undefined;

  while(gettime() < var0) {
    if(!isDefined(var1)) {
      var1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    } else {
      var3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var4 = (var3 - var1) / level.framedurationseconds;

      if(isDefined(var2)) {
        if(var2 - var4 >= 300) {
          light_tank_land(self.origin, self.angles);
          break;
        }
      }

      <
      error > = var1;
      var0 = var2;
    }

    waitframe();
  }

  self.infreefall = undefined;
  self physics_unregisterforcollisioncallback();

  while(lengthsquared(self vehicle_getvelocity()) > 400) {
    waitframe();
  }

  var5 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(self.dropspawn)) {
    self.dropspawn.isdisabled = undefined;
    self.dropspawn = undefined;
  }

  if(var5.cancapture) {
    if(var5.cancaptureimmediately) {
      thread light_tank_startcapture(self, self.owner, self.team);
      return;
    }

    return;
  }

  if(var5.activateimmediately) {
    thread light_tank_activate();
    return;
  }
}

function light_tank_createobjective(var0, var1, var2) {
  var3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  var4 = spawn("script_model", var0);
  var4 setModel("ks_airstrike_marker_mp");
  var5 = (1, 0, 0);
  var6 = vectorcross(var5, var1);
  var5 = vectorcross(var1, var6);
  var7 = axistoangles(var5, var6, var1);
  var4.angles = var7;

  if(var3 != -1) {
    var4.objid = var3;
    objective_onentity(var3, var4);
    objective_icon(var3, "icon_waypoint_tank");
    objective_setzoffset(var3, 55);
    objective_setplayintro(var3, 0);
    objective_setplayoutro(var3, 0);
    objective_setbackground(var3, 1);
    objective_showtoplayersinmask(var3);
    objective_state(var3, "current");

    if(level.teambased) {
      var8 = var2.team;

      if(!isDefined(var8) || var8 == "neutral") {
        if(isDefined(var2.owner)) {
          var8 = var2.owner.team;
        }
      }

      if(!isDefined(var8) || var8 == "neutral") {
        objective_addalltomask(var3);
        var4 setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        objective_addteamtomask(var3, var8);
        light_tank_setteamotherent(var4, var8);
        var4 setscriptablepartstate("marker_placed", "onTeam", 0);
      }
    } else if(!isDefined(var2.owner)) {
      objective_addalltomask(var3);
      var4 setscriptablepartstate("marker_placed", "onEveryone", 0);
    } else {
      objective_setownerclient(var3, var2.owner);
      objective_addclienttomask(var3, var2.owner);
      var4 setotherent(var2.owner);
      var4 setscriptablepartstate("marker_placed", "on", 0);
    }
  }

  return var4;
}

function light_tank_destroyobjective(var0) {
  if(isDefined(var0.objid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var0.objid);
  }

  var0 delete();
}

function light_tank_setteamotherent(var0, var1) {
  var0 notify("light_tank_setTeamOtherEnt");
  var0 endon("light_tank_setTeamOtherEnt");
  var2 = undefined;

  foreach(var4 in level.players) {
    if(var4.team == var1) {
      var2 = var4;
      break;
    }
  }

  if(isDefined(var2)) {
    var0 setotherent(var2);
    GscBinSkip4(0x35, var0, var2);
  }
}

function light_tank_monitorotherentjoined(var0, var1) {
  var0 endon("death");
  var2 = var1.team;
  var1 scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  thread light_tank_setteamotherent(var0, var2);
}

function light_tank_monitorotherentdisconnect(var0, var1) {
  var2 = var1.team;
  var1 waittill("disconnect");
  thread light_tank_setteamotherent(var0, var2);
}

function light_tank_startcapture(var0, var1, var2) {
  var3 = light_tank_getleveldata();

  if(var3.cantakedamageduringcapture) {
    var0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  }

  var4 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var4 = 0;
  } else if(isDefined(var0.spawndata.showheadicon)) {
    var4 = var0.spawndata.showheadicon;
  } else {
    var4 = var3.showheadicon;
  }

  if(var4) {
    light_tank_createheadicon(var0, 1);
    light_tank_updateheadicon(var0, var1, var2);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "startCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "startCapture")]](var0, var1, var2);
    return;
  }
}

function light_tank_endcapture(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "endCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "endCapture")]](var0);
    return;
  }
}

function light_tank_capture(var0, var1) {
  thread light_tank_endcapture(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var0, var1.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setowner(var0, var1);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var0, "driver", var1);
  thread light_tank_activate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](var1, var0);
    return;
  }
}

function wheelson_tank_death(var0) {
  if(scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return;
  }

  light_tank_updatetimeout();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

function light_tank_monitordriverturretfire() {
  self endon("death");
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var0 endon("death");
  var0.shotsleft = 8;
  light_tank_updatedriverturretammoui();
  light_tank_updatemissileammoui();

  for(;;) {
    var1 = var0 scripts\engine\utility::ref_143ad("turret_fire", "turret_reload");

    if(var1 == "turret_reload") {
      var0.shotsleft = 0;
      light_tank_updatedriverturretammoui();
      light_tank_driverturretreload();
      continue;
    }

    light_tank_turretdustkickup();
    light_tank_adjustdriverturretammo(-1);
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(var0.shotsleft <= 0) {
      light_tank_driverturretreload();
    }
  }
}

function wheelson_fire_thermite() {
  self endon("death");
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var0 endon("death");

  for(;;) {
    var0 waittill("turret_fire", var1);
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");
    thread whistlestarttimer_internal(var1);

    if(isDefined(self.streakinfo)) {
      var1.streakinfo = self.streakinfo;
      self.streakinfo.shots_fired++;
    }
  }
}

function whistlestarttimer_internal(var0) {
  level endon("game_ended");
  self waittill("explode", var1);

  if(!isDefined(var0)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1, 175, 175, var0.team, 1, var0, 1);
    return;
  }
}

function light_tank_monitordriverturretreload(var0) {
  self endon("death");
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");

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
        if(!var0 usinggamepad() && var1.shotsleft < 8) {
          var1 notify("turret_reload");
          break;
        }

        if(var1.shotsleft < 8 && var4 > 0 && var3 >= var2) {
          var1 notify("turret_reload");
        }

        var3 += level.framedurationseconds;
        waitframe();
      }

      if(var0 usinggamepad() && var1.shotsleft < 8 && (var4 == 0 && var3 > 0 && var3 < 0.2 || var4 > 0 && var3 >= var2)) {
        var1 notify("turret_reload");
      }

      waitframe();
    }

    return;
  }
}

function light_tank_adjustdriverturretammo(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var1.shotsleft += var0;
  var1.shotsleft = int(clamp(var1.shotsleft, 0, 8));
  light_tank_updatedriverturretammoui();
}

function light_tank_updatedriverturretammoui() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "turret", var1.shotsleft, var0);
    return;
  }
}

function light_tank_driverturretreload() {
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var0 turretfiredisable();
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var1)) {
    thread scripts\mp\utility\sound::playplayerandnpcsounds(var1, "weap_bradley_reload_plr", "weap_bradley_reload_npc");
  }

  wait 2.7;
  light_tank_adjustdriverturretammo(8);
  wait 0.15;
  var0 turretfireenable();
}

function whistlestarttimer() {
  self notify("watch_missile_input_change");
  self endon("watch_missile_input_change");

  for(;;) {
    var0 = weight_spawners_closest_to_forward();
    self notifyonplayercommand("light_tank_missile", var0);
    var1 = scripts\engine\utility::ref_143b4("input_type_changed", "missile_handling_ended");
    self notifyonplayercommandremove("light_tank_missile", var0);

    if(!isDefined(var1) || var1 == "missile_handling_ended") {
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

function light_tank_monitordrivermissilefire(var0) {
  self endon("death");
  self endon("light_tank_driver_exit");

  for(;;) {
    var0 waittill("light_tank_missile");
    var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");

    if(gettime() - var1.lastmissilefired >= 1330) {
      if(var1.missilesleft > 0) {
        var1.lastmissilefired = gettime();
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d2(var0);
        light_tank_firemissile(var0, var0.stingertarget);
        light_tank_adjustmissileammo(-1);
      }
    }
  }
}

function light_tank_firemissile(var0, var1) {
  wait 0.33;
  var2 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var3 = var2 gettagorigin("tag_flash");
  var4 = var2 gettagangles("tag_flash");
  var5 = var3 + anglesToForward(var4);
  GscBinSkip4(0x6e, var0);
}

function light_tank_adjustmissileammo(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
  var1.missilesleft += var0;
  var1.missilesleft = int(clamp(var1.missilesleft, 0, 2));
  light_tank_updatemissileammoui();
}

function light_tank_updatemissileammoui() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "missile", var1.missilesleft, var0);
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

function light_tank_endmissilefireplayerfx(var0) {
  if(!istrue(var0)) {
    self setblurforplayer(0, 0.1);
    return;
  }

  self setblurforplayer(0, 0);
}

function wheelson_molotov_damage_over_time() {
  self endon("death");
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_gun_lighttank_mp");

  for(;;) {
    var0 waittill("turret_fire");

    if(isDefined(self.streakinfo)) {
      self.streakinfo.shots_fired++;
    }
  }
}

function light_tank_updateautodestructui(var0) {
  var1 = light_tank_getleveldata();

  if(var1.canautodestruct) {
    if(istrue(self.autodestructactivated)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", var0, "light_tank");
      return;
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var0, "light_tank");
    return;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var0, "light_tank");
}

function light_tank_updatetimeoutui(var0, var1) {
  var2 = light_tank_getleveldata();

  if(light_tank_cantimeout()) {
    if(!isDefined(var1)) {
      var1 = (var2.timeoutduration - self.timeelapsed) / var2.timeoutduration;
      var1 = clamp(var1, 0, 1);
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_settimepercent(var1, var0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showtime(var0);
    return;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_cleartimepercent(var0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidetime(var0);
}

function light_tank_updatetimeout() {
  if(light_tank_cantimeout()) {
    if(!isDefined(self.timeelapsed)) {
      self.timeelapsed = 0;
    }

    if(istrue(self.isactivated)) {
      self.timeelapsed += level.framedurationseconds;
      var0 = light_tank_getleveldata();
      var1 = (var0.timeoutduration - self.timeelapsed) / var0.timeoutduration;
      var1 = int(ceil(clamp(var1, 0, 1) * 100));

      if(self.timeelapsed >= var0.timeoutduration) {
        thread light_tank_timeout();
        return;
      }

      var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(var4 in var2) {
        light_tank_updatetimeoutui(var4, var1);
      }

      return;
    }

    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var4 in var2) {
      light_tank_updatetimeoutui(var4, 1);
    }

    return;
  }

  self.timeelapsed = undefined;
}

function light_tank_timeout() {
  if(light_tank_canautodestruct()) {
    thread light_tank_autodestruct();
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var2 in var0) {
      light_tank_updatetimeoutui(var2, undefined);
    }

    return;
  }

  thread light_tank_explode(undefined, 0, 1);
}

function light_tank_enterstart(var0, var1, var2, var3, var4) {
  if(var1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_lighttank_mp", var4, 1);
    return;
  }
}

function light_tank_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    thread light_tank_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }

  if(!istrue(var4.playerdisconnect) && !istrue(var4.playerdeath)) {
    if(var1 == "gunner") {
      wheelson_remote_tank_follow_path(var3);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_lighttank_mp", var4, 1);
      return;
    }

    return;
  }
}

function light_tank_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0.1);
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
    var5.owner = var3;
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
    var5 setotherent(var3);
    var5 setentityowner(var3);
    var5 setsentryowner(var3);
    var3 remotecontrolturret(var5);
    thread whistlestarttimer();
    thread light_tank_monitordrivermissilefire(var0);
    var3 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  } else if(var1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0);
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_gun_lighttank_mp");
    var5.owner = var3;
    var5 setotherent(var3);
    var5 setentityowner(var3);
    var5 setsentryowner(var3);
    var3 disableturretdismount();
    var3 controlturreton(var5);
    week(var3);
  }

  if(!isDefined(var2)) {
    light_tank_updateheadiconforplayer(var0, var3);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
  light_tank_updateplayeromnvarsonenter(var0, var2, var1, var3);

  if(var1 == "driver") {
    thread light_tank_monitordriverturretreload(var0);
    return;
  }
}

function light_tank_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    thread light_tank_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function light_tank_exitendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 notify("light_tank_driver_exit");
    wheelson_remote_tank_think();
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
    var5.owner = undefined;
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var5 setturretdismountorg(var3.origin);
      var3 remotecontrolturretoff(var5);
      var3 controlsunlink();

      if(!istrue(var4.playerdeath)) {
        light_tank_endmissilefireplayerfx(var3, 1);
      }

      var3 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    }

    var5 setotherent(undefined);
    var5 setentityowner(undefined);
    var5 setsentryowner(undefined);
  } else if(var1 == "gunner") {
    var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_gun_lighttank_mp");

    if(!istrue(var4.playerdisconnect)) {
      var3 enableturretdismount();
      var3 controlturretoff(var5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var3, var4.playerdeath);

      if(!istrue(var4.playerdeath)) {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_lighttank_mp", var4, 1);
      }
    }

    var5.owner = undefined;
    var5 setotherent(undefined);
    var5 setentityowner(undefined);
    var5 setsentryowner(undefined);
    wheelson_remote_tank_follow_path(var3);
  }

  if(!istrue(var4.playerdisconnect)) {
    if(!isDefined(var2)) {
      light_tank_updateheadiconforplayer(var0, var3);
    }

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

function light_tank_reenter(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    thread light_tank_monitordrivermissilefire(var0);
  }

  if(isDefined(var2) && var2 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_lighttank_mp", var4, 1);
    return;
  }
}

function week(var0) {
  if(isDefined(var0.set_thirdperson)) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, &wheels_fx);
}

function wheelson_remote_tank_follow_path(var0) {
  if(!isDefined(var0.set_thirdperson)) {
    return;
  }

  var0.set_thirdperson = undefined;
  var0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

function wheels_fx(var0, var1, var2, var3, var4, var5, var6) {
  if(var4 != "MOD_PROJECTILE_SPLASH" && var4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var5)) {
    return 1;
  }

  switch (var5.basename) {
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

function whistlestarttime(var0) {
  self endon("death");
  self.owner endon("disconnect");
  level waittill("game_ended");
  self.ref_12aa4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
}

function light_tank_premoddamagecallback(var0) {
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

  if(vectordot(var5, var6) < -0.83) {
    var0.use_aitype = canweapondealcriticaldamage(var0);
  }

  return true;
}

function canweapondealcriticaldamage(var0) {
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

function light_tank_postmoddamagecallback(var0) {
  if(istrue(var0.use_aitype)) {
    var0.damage = int(var0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var0.attacker, var0.damage);
  }

  return true;
}

function light_tank_deathcallback(var0) {
  thread light_tank_explode(var0);
  return true;
}

function light_tank_autodestruct(var0) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!scripts\common\utility::iscp()) {
      var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414b(self);
      self.health = int(min(self.health, var1));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      scripts\cp_mp\vehicles\vehicle_damage::ref_1417f();
      return;
    }

    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var4 in var2) {
      light_tank_updateautodestructui(var4);
    }

    wait 5.5;
    thread light_tank_explode(undefined, undefined, 1);
    return;
  }
}

function light_tank_turretdustkickup() {
  var0 = physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  var1 = self getlinkedchildren();

  if(!isDefined(var1)) {
    var1 = [];
  }

  GscBinSkip0(0x2e, var1.size, self);
}

function light_tank_createheadicon(var0) {
  var1 = self.headicon;

  if(!isDefined(var1)) {
    var2 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_bradley_mp");
    var1 = var2 scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(var1)) {
      return 0;
    }

    self.headicon = var1;
    addclienttoheadiconmask(var1, 55);
  }

  self.headiconforcapture = istrue(var0);
  var3 = scripts\engine\utility::ter_op(istrue(var0), 0, 0);
  var4 = scripts\engine\utility::ter_op(istrue(var0), 2250, 2250);
  var5 = scripts\engine\utility::ter_op(istrue(var0), 1, 0);
  var6 = scripts\engine\utility::ter_op(istrue(var0), 1, 0);
  setheadiconmaxdistance(var1, var3);
  setheadiconsnaptoedges(var1, var4);
  setheadiconzoffset(var1, var5);
  setheadicondrawthroughgeo(var1, var6);
}

function light_tank_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

function light_tank_updateheadicon(var0, var1) {
  if(!isDefined(self.headicon)) {
    return;
  }

  if(isDefined(var0)) {
    if(isstring(var0) && var0 == "none") {
      self.headiconowneroverride = undefined;
    } else {
      self.headiconowneroverride = var0;
    }
  }

  if(isDefined(var1)) {
    if(var1 == "none") {
      self.headiconteamoverride = undefined;
    } else {
      self.headiconteamoverride = var1;
    }
  }

  light_tank_updateheadiconowner();
  light_tank_updateheadiconteam();
  light_tank_updateheadiconimage();

  foreach(var3 in level.players) {
    light_tank_updateheadiconforplayer(var3);
  }
}

function light_tank_updateheadiconforplayer(var0) {
  if(!isDefined(self.headicon)) {
    return;
  }

  var1 = var0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var1) && var1 == self) {
    scripts\cp_mp\entityheadicons::ref_1315e(self.headicon, var0);
    return;
  }

  var2 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var2 = self.headiconowneroverride;
  } else {
    var2 = self.owner;
  }

  var3 = undefined;

  if(isDefined(self.headiconteamoverride)) {
    var3 = self.headiconteamoverride;
  } else {
    var3 = self.team;
  }

  var4 = light_tank_getleveldata();

  if(level.teambased) {
    if(var3 == "neutral") {
      if(!isDefined(var2)) {
        if(true) {
          scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
          return;
        }

        scripts\cp_mp\entityheadicons::ref_1315e(self.headicon, var0);
        return;
      } else {
        var3 = var2.team;
      }
    }

    if(isenemyteam(var3, var0.team)) {
      if(istrue(var4.showheadicontoenemy)) {
        scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
        return;
      }

      scripts\cp_mp\entityheadicons::ref_1315e(self.headicon, var0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
    return;
  }

  if(!isDefined(var2)) {
    if(true) {
      scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315e(self.headicon, var0);
    return;
  }

  if(var0 != var2) {
    if(var4.showheadicontoenemy) {
      scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315e(self.headicon, var0);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315d(self.headicon, var0);
}

function light_tank_updateheadiconforplayeronjointeam(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

  foreach(var3 in var1) {
    light_tank_updateheadiconforplayer(var3, var0);
  }
}

function light_tank_updateheadiconowner() {
  if(level.teambased) {
    return false;
  }

  var0 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var0 = self.headiconowneroverride;
  } else {
    var0 = self.owner;
  }

  if(isDefined(var0)) {
    createtargetmarkergroup(self.headicon, var0);
  } else {
    createtargetmarkergroup(self.headicon, undefined);
  }

  return true;
}

function light_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }

  var0 = light_tank_getheadiconteam();

  if(isDefined(var0) && var0 != "neutral") {
    setheadiconowner(self.headicon, var0);
    return;
  }

  setheadiconowner(self.headicon, undefined);
}

function light_tank_updateheadiconimage() {
  var0 = light_tank_getleveldata();
  var1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(var1) {
    setheadiconenemyimage(self.headicon, level.factionfriendlyheadicon);

    if(true) {
      setheadiconnaturaldistance(self.headicon, level.factionenemyheadicon);
    }

    if(var0.showheadicontoenemy) {
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);
      return;
    }

    return;
  }

  var2 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
  var3 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, var0.showheadicontoenemy);
  var4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
  var5 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
  var6 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
  setheadiconenemyimage(self.headicon, var4);

  if(var2) {
    setheadiconnaturaldistance(self.headicon, var5);
  }

  if(var3) {
    setheadiconneutralimage(self.headicon, var6);
    return;
  }
}

function light_tank_getheadiconteam() {
  var0 = undefined;

  if(isDefined(self.headiconowneroverride)) {
    var0 = self.headiconowneroverride;
  } else {
    var0 = self.owner;
  }

  var1 = undefined;

  if(isDefined(self.headiconteamoverride)) {
    var1 = self.headiconteamoverride;
  } else {
    var1 = self.team;
  }

  var2 = var1;

  if(!isDefined(var2) || var1 == "neutral") {
    if(isDefined(var0)) {
      var2 = var0.team;
    }
  }

  return var2;
}

function light_tank_tryuse() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("bradley", self);
  return light_tank_tryusefromstruct(var0);
}

function light_tank_tryusefromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = getcompleteweaponname("ks_gesture_generic_mp");
  var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, var1);

  if(!istrue(var2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit("light_tank", self, self.team)) {
    return false;
  }

  var3 = spawnStruct();
  light_tank_initializespawndata(var3);
  var3.spawnmethod = "airdrop_from_player";
  var3.faceawayfromowner = 1;
  var3.cancapture = 1;
  var3.cancaptureimmediately = 1;
  var3.team = self.team;
  var3.owner = self;
  var3.spawntype = "KILLSTREAK";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) == 1) {
    var3.usealtmodel = 1;
  }

  var4 = spawnStruct();
  var5 = light_tank_spawn(var3, var4, var0);

  if(!isDefined(var5)) {
    if(isDefined(var4.fail)) {
      switch (var4.fail) {
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

  if(isDefined(var0)) {
    var5.streakinfo = var0;
    var6 = scripts\cp_mp\vehicles\vehicle::ref_14193(var5);

    foreach(var8 in var6) {
      var8.streakinfo = var0;
    }

    thread whistlestarttime(var5);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(var5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("bradley", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_bradley", self);
  }

  return true;
}

function light_tank_hasdropspawns() {
  var0 = light_tank_getleveldata();

  if(isDefined(var0)) {
    return (var0.dropspawns.size > 0);
  }

  return undefined;
}

function light_tank_getdropspawn(var0, var1) {
  var2 = light_tank_getleveldata();

  if(var2.dropspawns.size > 0) {
    var3 = sortbydistance(var2.dropspawns, var0);
    var4 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "getDropSpawnIgnoreList")) {
      var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "getDropSpawnIgnoreList")]](var4);
    }

    foreach(var6 in var3) {
      if(istrue(var6.isdisabled)) {
        continue;
      }

      var7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(var6.origin, "light_tank", undefined, var4);

      if(var7) {
        return var6;
      }
    }
  }

  return undefined;
}

function light_tank_getdropspawnangles(var0, var1) {
  var0 *= (0, 1, 0);

  if(!isDefined(var1.spawnflags) || var1.spawnflags & 0) {
    var2 = var1.angles * (0, 1, 0);
    var3 = vectordot(anglesToForward(var0), anglesToForward(var2));

    if(var3 < 0) {
      var0 = (0, angleclamp180(var2[1] + 180), 0);
    }
  }

  return var0;
}

function light_tank_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var0.maxinstancecount = 4;
  var0.priority = 75;
  var0.getspawnstructscallback = &light_tank_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "spawnCallback");
  var0.clearancecheckradius = 130;
  var0.clearancecheckheight = 1000;
  var0.clearancecheckminradius = 130;
}

function light_tank_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("lighttank_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}

function light_tank_getleveldata() {
  return level.vehicle.lighttank;
}

function light_tank_updateteam(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle::ref_14193(var0);

  foreach(var5 in var3) {
    var5.team = var1;
  }

  if(isDefined(var0.headicon)) {
    if(var2) {
      light_tank_updateheadiconteam(var0);
      light_tank_updateheadiconimage(var0);

      foreach(var8 in level.players) {
        light_tank_updateheadiconforplayer(var0, var8);
      }

      return;
    }

    return;
  }
}

function light_tank_updateowner(var0, var1, var2, var3) {
  if(isDefined(var0.headicon)) {
    if(var2) {
      light_tank_updateheadiconowner(var0);
    }

    if(var3) {
      light_tank_updateheadiconteam(var0);
      light_tank_updateheadiconimage(var0);
    }

    if(var2 || var3) {
      foreach(var5 in level.players) {
        light_tank_updateheadiconforplayer(var0, var5);
      }

      return;
    }

    return;
  }
}

function light_tank_shouldautodestructfromdamage(var0) {
  if(!light_tank_canautodestruct()) {
    return 0;
  }

  var1 = light_tank_getleveldata();

  if(var1.autodestructdamagepercent > 0) {
    var2 = max(self.health - var0.damage, 0);
    return (floor(var2 / self.maxhealth * 100) <= var1.autodestructdamagepercent);
  }

  return 0;
}

function light_tank_canautodestruct() {
  if(istrue(self.autodestructactivated)) {
    return false;
  }

  var0 = light_tank_getleveldata();

  if(!var0.canautodestruct) {
    return false;
  }

  return true;
}

function light_tank_cantimeout() {
  if(!light_tank_cantimeoutinternal()) {
    return false;
  }

  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(var0.cantimeout) && var0.cantimeout == 0) {
    return false;
  }

  var1 = light_tank_getleveldata();

  if(!var1.cantimeout) {
    return false;
  }

  if(var1.timeoutduration <= 0) {
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

function light_tank_supported(var0) {
  return light_tank_hasdropspawns();
}

function light_tank_updateplayeromnvarsonenter(var0, var1, var2, var3) {
  if(var2 == "driver") {
    light_tank_updatedriverturretammoui(var0);
    light_tank_updatemissileammoui(var0);
  }

  light_tank_updatetimeoutui(var0, var3);
  light_tank_updateautodestructui(var0, var3);
}

function light_tank_flippedendcallback(var0, var1) {
  if(var1) {
    light_tank_timeout(var0);
    return;
  }
}