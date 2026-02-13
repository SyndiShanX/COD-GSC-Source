/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\s4_tank.gsc
*************************************************/

s4_tank_init() {
  level.vehicle.s4tank = spawnStruct();
  level.vehicle.s4tank._id_3146 = 1;
  level.vehicle.s4tank._id_1F25 = 11;
  level.vehicle.s4tank._id_31F7 = 1;
  level.vehicle.s4tank._id_F230 = 165;
  level.vehicle.s4tank._id_31F0 = 1;
  level.vehicle.s4tank._id_DCB0 = 1;
  level.vehicle.s4tank._id_DCB1 = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("s4_tank", 1);
  var_0._id_FC21 = ::s4_tank_update;
  var_0._id_4841 = ::s4_tank_explode;
  s4_tank_initoccupancy();
  s4_tank_initinteract();
  s4_tank_initomnvars();
  s4_tank_initdamage();
  s4_tank_initentranceanimations();
  s4_tank_initfx();
  s4_tank_initspawns();
  s4_tank_initvo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("s4_tank", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "init")]]();
  }

  s4_tank_initspawning();
  thread s4_tank_initlate();
}

s4_tank_initlate() {
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("s4_tank", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "initLate")]]();
  }
}

s4_tank_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("s4_tank", 1);
  var_0._id_54E3 = ::s4_tank_enterstart;
  var_0._id_54D6 = ::s4_tank_enterend;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::s4_tank_exitend;
  var_0._id_C187 = ::s4_tank_reenter;
  var_0._id_FD57 = ::s4_tank_updateteam;
  var_0._id_FCE4 = ::s4_tank_updateowner;
  var_0._id_577C["front"] = 125;
  var_0._id_577C["back"] = 115;
  var_0._id_577C["left"] = 70;
  var_0._id_577C["right"] = 70;
  var_0._id_577C["top"] = 130;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (90, 0, 75);
  var_0._id_5778[var_1] = "front";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-90, 30, 60);
  var_0._id_5778[var_1] = "left";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-90, -30, 60);
  var_0._id_5778[var_1] = "right";
  var_1 = "back";
  var_0._id_5788[var_1] = (-90, -12, 60);
  var_0._id_5778[var_1] = "back";

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_2 = ["tag_seat_0", "tag_seat_1"];
  } else {
    var_2 = ["tag_seat_0"];
  }

  var_3 = "tag_seat_0";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("s4_tank", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "tag_seat_1", "back_left", "back_right", "front"];
  var_0._id_5788[var_3] = (35, 15, 60);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_C725 = scripts\engine\utility::array_remove(var_4._id_C725, "fire");
  var_4._id_790C = 1;
  var_4._id_430F = 0;
  var_4._id_103D2["top"] = 13;
  var_4._id_103D2["bottom"] = 13;
  var_4._id_103D2["left"] = 180;
  var_4._id_103D2["right"] = 180;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_E354 = 10;
  var_4._id_F88B = makeweapon("s4_tur_main_tank_mike4_mp");
  var_4._id_AAC6 = "ping_vehicle_driver";

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_3 = "tag_seat_1";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("s4_tank", var_3, 1);
    var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
    var_4._id_18F2 = "tag_seat_1";
    var_4._id_5780 = [var_3, "back_left", "back_right", "tag_seat_0", "front"];
    var_0._id_5788[var_3] = (-90, -12, 60);
    var_0._id_5778[var_3] = "back";
    var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AF();
    var_4._id_103D2["top"] = 23;
    var_4._id_103D2["bottom"] = 23;
    var_4._id_103D2["left"] = 180;
    var_4._id_103D2["right"] = 180;
    var_4._id_F88B = makeweapon("s4_tur_mg_gun_tank_mp");
    var_4._id_AAC6 = "ping_vehicle_gunner";
  }
}

s4_tank_initinteract() {
  var_0 = _id_09E1::_id_100EF("s4_tank", 1);

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_0._id_CFC0["single"] = ["tag_seat_0", "tag_seat_1"];
  } else {
    var_0._id_CFC0["single"] = ["tag_seat_0"];
  }
}

s4_tank_initomnvars() {
  var_0 = _id_09CA::_id_10373("s4_tank", 1);
  var_0._id_7C8C = 1;
  var_0._id_CFC3["tag_seat_0"] = 0;
  var_0._id_171A["turret"] = 0;
  var_0._id_C930[0] = 0;
  var_0._id_C931["tag_seat_0"]["s4_tank_mp"] = 0;
  var_0._id_C931["tag_seat_1"]["s4_tur_main_tank_mike4_mp"] = 0;

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_0._id_CFC3["tag_seat_1"] = 1;
    var_0._id_C930[1] = 1;
    var_0._id_C931["tag_seat_0"]["s4_tur_mg_gun_tank_mp"] = 1;
    var_0._id_C931["tag_seat_1"]["s4_tur_mg_gun_tank_mp"] = 1;
  }
}

s4_tank_initdamage() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("s4_tank", 2800);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("s4_tank");
  var_0.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("s4_tank");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("s4_tank", 10);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10071("s4_tank", ::s4_tank_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10070("s4_tank", ::s4_tank_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("s4_tank", ::s4_tank_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("s4_tank_tur_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("s4_tank_mp", 2);
}

#using_animtree("script_model");

s4_tank_initentranceanimations() {
  level._id_CC34["ac130"] = #animtree;
  level._id_CC31["ac130"]["s4_tank_drop"] = % mp_bromeo_drop_acharlie130;
  level._id_CC32["ac130"]["s4_tank_drop"] = "mp_bromeo_drop_acharlie130";
  level._id_CC34["parachute"] = #animtree;
  level._id_CC31["parachute"]["s4_tank_drop"] = % mp_bromeo_drop_parachute;
  level._id_CC32["parachute"]["s4_tank_drop"] = "mp_bromeo_drop_parachute";
  s4_tank_initvehicleentranceanimations();
}

#using_animtree("mp_vehicles_always_loaded");

s4_tank_initvehicleentranceanimations() {
  level._id_CC34["s4_tank"] = #animtree;
  level._id_CC31["s4_tank"]["s4_tank_drop"] = % mp_bromeo_drop_bromeo;
}

s4_tank_initfx() {
  level._effect["s4_tank_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
  level._effect["s4_tank_explode"] = loadfx("vfx/s4/vehicle/scriptables/veh_explosion_ar_tank_mike04");
  level._effect["s4_tank_explode_alt"] = loadfx("vfx/s4/vehicle/scriptables/veh_explosion_ar_tank_mike04");
  level._effect["s4_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

s4_tank_initspawns() {
  var_0 = s4_tank_getleveldata();
}

s4_tank_initvo() {
  game["dialog"]["s4_tank_low_fuel"] = "s4_tank_timeout_reminder";
  game["dialog"]["s4_tank_destruct"] = "s4_tank_self_destruct";
  game["dialog"]["s4_tank_entry"] = "s4_tank_chatter_01";
  game["dialog"]["s4_tank_chatter_01"] = "s4_tank_chatter_02";
  game["dialog"]["s4_tank_chatter_02"] = "s4_tank_chatter_03";
}

s4_tank_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "tank_mike4_ar_00_physics";
  var_0._id_0481 = "s4_tank";
  var_0._id_04DE = "tank_mike4_physics_mp";
  var_0._id_31A0 = 1;
  var_0._id_E728 = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = s4_tank_createdriverturret(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::_id_10240(var_2, var_3, makeweapon("s4_tur_main_tank_mike4_mp"), 1);

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_3 = s4_tank_creategunnerturret(var_2, var_0);
    scripts\cp_mp\vehicles\vehicle::_id_10240(var_2, var_3, makeweapon("s4_tur_mg_gun_tank_mp"));
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "s4_tank", var_0);
  var_2.objweapon = makeweapon("s4_tank_mp");
  var_2 s4_tank_updateheadicon();
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003E(var_2, 1);
  var_4._id_4861 = "none";

  if(_id_09E1::_id_100F8(var_2)) {
    var_2 _id_09E1::_id_100E5(var_2, 0);
  }

  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  var_2 thread tank_watch_damage_states();
  var_2 scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015D(0);
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, ::s4_tank_flippedendcallback, "flipped_end");
  var_2 thread s4_tank_monitordriverturretfire();
  var_2 thread s4_tank_monitordriverturretprojectilefire();

  if(getdvarint("#x3b8c059a8eabc382a", 0)) {
    var_2 thread s4_tank_monitorgunnerturretfire();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("s4_tank", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "create")]](var_2);
  }

  return var_2;
}

s4_tank_createdriverturret(var_0, var_1) {
  var_2 = s4_tank_getleveldata();
  var_3 = "s4_tur_main_tank_mike4_mp";
  var_4 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), var_3, 0);
  var_4 linkto(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1._id_FE22)) {
    var_4 setModel("tank_mike4_tur_main_01");
  } else {
    var_4 setModel("tank_mike4_tur_main_00_ar");
  }

  var_4 setmode("sentry_offline");
  var_4 setsentryowner(undefined);
  var_4 makeunusable();
  var_4 setdefaultdroppitch(0);
  var_4 _meth_839D(1);
  var_4.angles = var_0.angles;
  var_4.vehicle = var_0;
  return var_4;
}

s4_tank_creategunnerturret(var_0, var_1) {
  var_2 = s4_tank_getleveldata();
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_main_tank_mike4_mp");
  var_4 = "s4_tur_mg_gun_tank_mp";
  var_5 = spawnturret("misc_turret", var_3 gettagorigin("TAG_TURRET_ATTACH"), var_4, 0);
  var_5 linkto(var_3, "TAG_TURRET_ATTACH", (0, 0, 0), (0, 0, 0));
  var_5 setModel("tur_mgolf42_spindle_00");
  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 _meth_839D(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  return var_5;
}

s4_tank_activate() {
  if(istrue(self._id_872F)) {
    return;
  }
  self._id_872F = 1;
  var_0 = s4_tank_getleveldata();
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(1);
  var_1 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_1 = 0;
  } else if(isDefined(self._id_E293._id_DCB0)) {
    var_1 = self._id_E293._id_DCB0;
  } else {
    var_1 = var_0._id_DCB0;
  }

  if(var_1) {
    s4_tank_createheadicon();
    s4_tank_updateheadicon();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015D(1);
  _id_09E1::_id_100E5(self, 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("s4_tank", "activate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "activate")]](self);
  }
}

s4_tank_explode(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_0.inflictor;
    var_6 = var_0._id_9CD6;
    var_3 = var_0.attacker;
    var_5 = var_0.objweapon;
    var_7 = undefined;
    var_8 = var_0.damage;
    var_9 = 1;
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "s4_tank_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread s4_tank_deletenextframe();

  if(!istrue(level._id_EBC3)) {
    var_10 = self gettagorigin("tag_origin");

    if(!isDefined(var_3)) {
      var_3 = self;
    }

    self radiusdamage(var_10, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "s4_tank_mp");
    self radiusdamage(var_10, 120, 200, 200, var_3, "MOD_EXPLOSIVE", "s4_tank_mp", 0, 0);
    var_11 = self gettagorigin("tag_origin");
    var_12 = undefined;

    if(istrue(self._id_E293._id_FE22)) {
      var_12 = "s4_tank_explode_alt";
    } else {
      var_12 = "s4_tank_explode";
    }

    playFX(scripts\engine\utility::getfx(var_12), var_11, anglesToForward(self.angles));
    thread tank_explosion_sound();
    earthquake(0.4, 0.7, var_11, 800);
    playrumbleonposition("grenade_rumble", var_11);
    physicsexplosionsphere(var_11, 500, 200, 1);
  }
}

s4_tank_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(istrue(self._id_7EAB)) {
    self _meth_84FD();
    self._id_7EAB = undefined;
  }

  s4_tank_destroyheadicon();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("s4_tank", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

s4_tank_land(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("light_tank_land"), var_0, anglesToForward(var_1));
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("grenade_rumble", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

s4_tank_initializespawndata(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(!isDefined(var_0._id_E325)) {
    var_0._id_E325 = "place_at_position";
  }

  if(!isDefined(var_0._id_3151)) {
    var_0._id_3151 = 0;
  }

  if(!isDefined(var_0._id_3152)) {
    var_0._id_3152 = 1;
  }

  if(!isDefined(var_0._id_0EF4)) {
    var_0._id_0EF4 = 1;
  }

  return var_0;
}

s4_tank_copyspawndata(var_0, var_1) {
  var_1._id_E325 = var_0._id_E325;
  var_1._id_3151 = var_0._id_3151;
  var_1._id_3152 = var_0._id_3152;
  var_1._id_0EF4 = var_0._id_0EF4;
  var_1._id_587C = var_0._id_587C;
  var_1._id_31F7 = var_0._id_31F7;
  var_1._id_DCB0 = var_0._id_DCB0;
}

s4_tank_spawn(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_0 = s4_tank_initializespawndata(var_0);
  var_6 = issubstr(var_0._id_E325, "_unsafe");
  var_2 = var_0.origin;
  var_3 = var_0.angles;

  if(!isDefined(var_3)) {
    var_3 = (0, randomint(360), 0);
  } else {
    var_3 = var_3 * (0, 1, 0);
  }

  var_7 = s4_tank_place(var_2, var_3, var_0, var_1);
  return var_7;
}

s4_tank_place(var_0, var_1, var_2, var_3) {
  var_4 = var_2.origin;
  var_5 = var_2.angles;
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_6 = s4_tank_create(var_2, var_3);
  var_2.origin = var_4;
  var_2.angles = var_5;

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(var_2._id_0EF4) {
    var_6 thread s4_tank_activate();
  }

  return var_6;
}

s4_tank_getdesiredspawnpositionfromplayer(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = max(-5, min(_func_000B(var_2[0]), 45));
  var_2 = (_func_000A(var_3), var_2[1], var_2[2]);
  var_4 = anglesToForward(var_2);
  var_5 = anglesToForward(var_2 * (0, 1, 0));
  var_6 = var_1;
  var_7 = var_1 + var_4 * 1800;
  var_8 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_9 = _func_02C1(var_6, var_7, var_8, undefined, 0, "physicsquery_closest", 1);

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

s4_tank_update(var_0) {
  if(scripts\cp_mp\vehicles\vehicle::_id_8AF7()) {
    return;
  }
  s4_tank_updatetimeout();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1020B("tag_seat_0");
}

s4_tank_monitordriverturretfire() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
  var_0 endon("death");
  var_0._id_DA6A = 8;
  s4_tank_updatedriverturretammoui();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_10897("turret_fire", "turret_reload");

    if(var_1 == "turret_reload") {
      var_0._id_DA6A = 0;
      s4_tank_updatedriverturretammoui();
      s4_tank_driverturretreload();
      continue;
    }

    s4_tank_turretdustkickup();
    s4_tank_adjustdriverturretammo(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "tag_seat_0");

    if(var_0._id_DA6A <= 0) {
      s4_tank_driverturretreload();
    }
  }
}

s4_tank_monitordriverturretprojectilefire() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("turret_fire", var_1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "tag_seat_0");
    var_1 thread s4_tank_watchprojectileexplosion(var_2);
  }
}

s4_tank_watchprojectileexplosion(var_0) {
  level endon("game_ended");
  self waittill("explode", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1, 175, 175, var_0.team, 1, var_0, 1);
  }
}

s4_tank_monitordriverturretreload(var_0) {
  self endon("death");
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");

  if(isDefined(var_0)) {
    var_0 endon("vehicle_change_seat");
    var_0 endon("vehicle_seat_exit");
    var_0 endon("death_or_disconnect");

    while(var_0 reloadbuttonpressed()) {
      waitframe();
    }

    var_2 = getdvarint("#x374b6dca2a5ac069b", 250) / 1000;

    for(;;) {
      var_3 = 0.0;
      var_4 = var_0 _meth_874B();

      while(var_0 reloadbuttonpressed()) {
        if(!var_0 usinggamepad() && var_1._id_DA6A < 8) {
          var_1 notify("turret_reload");
          break;
        } else {
          if(var_1._id_DA6A < 8 && var_4 > 0 && var_3 >= var_2) {
            var_1 notify("turret_reload");
          }

          var_3 = var_3 + level._id_5F3A;
          waitframe();
        }
      }

      if(var_0 usinggamepad() && var_1._id_DA6A < 8 && (var_4 == 0 && var_3 > 0.0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2)) {
        var_1 notify("turret_reload");
      }

      waitframe();
    }
  }
}

s4_tank_adjustdriverturretammo(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
  var_1._id_DA6A = var_1._id_DA6A + var_0;
  var_1._id_DA6A = int(clamp(var_1._id_DA6A, 0, 8));
  s4_tank_updatedriverturretammoui();
}

s4_tank_updatedriverturretammoui() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "tag_seat_0");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
    _id_09CA::_id_10382("s4_tank", "turret", var_1._id_DA6A, var_0);
  }
}

s4_tank_driverturretreload() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
  var_0 _meth_8410();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "tag_seat_0");

  if(isDefined(var_1)) {
    thread s4_tank_driverturretreloadsfx(var_1, "weap_bradley_reload_plr", "weap_bradley_reload_npc");
  }

  wait 2.7;
  s4_tank_adjustdriverturretammo(8);
  wait 0.15;
  var_0 _meth_8411();
}

s4_tank_driverturretreloadsfx(var_0, var_1, var_2) {}

s4_tank_monitorgunnerturretfire() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_mg_gun_tank_mp");

  for(;;) {
    var_0 waittill("turret_fire");
  }
}

s4_tank_updateautodestructui(var_0) {
  var_1 = s4_tank_getleveldata();

  if(var_1._id_3146) {
    if(istrue(self._id_1F24)) {
      _id_09CA::_id_10390("burningDown", var_0, "s4_tank");
    } else {
      _id_09CA::_id_1037B("burningDown", var_0, "s4_tank");
    }
  } else
    _id_09CA::_id_1037B("burningDown", var_0, "s4_tank");
}

s4_tank_updatetimeoutui(var_0, var_1) {
  var_2 = s4_tank_getleveldata();

  if(s4_tank_cantimeout()) {
    if(!isDefined(var_1)) {
      var_1 = (var_2._id_F230 - self._id_F20D) / var_2._id_F230;
      var_1 = clamp(var_1, 0, 1);
    }

    _id_09CA::_id_10389(var_1, var_0);
    _id_09CA::_id_1038F(var_0);
  } else {
    _id_09CA::_id_1036C(var_0);
    _id_09CA::_id_1037A(var_0);
  }
}

s4_tank_updatetimeout() {
  if(s4_tank_cantimeout()) {
    if(!isDefined(self._id_F20D)) {
      self._id_F20D = 0;
    }

    if(istrue(self._id_872F)) {
      self._id_F20D = self._id_F20D + level._id_5F3A;
      var_0 = s4_tank_getleveldata();
      var_1 = (var_0._id_F230 - self._id_F20D) / var_0._id_F230;
      var_1 = int(_func_0037(clamp(var_1, 0, 1) * 100));

      if(self._id_F20D >= var_0._id_F230) {
        thread s4_tank_timeout();
        return;
      }

      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        s4_tank_updatetimeoutui(var_4, var_1);
      }

      return;
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        s4_tank_updatetimeoutui(var_4, 1);
      }
    }
  } else
    self._id_F20D = undefined;
}

s4_tank_timeout() {
  if(s4_tank_canautodestruct()) {
    thread s4_tank_autodestruct();
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

    foreach(var_2 in var_0) {
      s4_tank_updatetimeoutui(var_2, undefined);
    }
  } else
    thread s4_tank_explode(undefined, 0, 1);
}

s4_tank_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "tag_seat_1") {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_101B3(var_3, "s4_tur_mg_gun_tank_mp", var_4, 1);
  }
}

s4_tank_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    thread s4_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  } else if(!istrue(var_4._id_B695) && !istrue(var_4._id_B68D)) {
    if(var_1 == "tag_seat_1") {
      s4_tank_removegunnerdamagemod(var_3);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "s4_tur_mg_gun_tank_mp", var_4, 1);
    }
  }
}

s4_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "tag_seat_0") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017C(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_main_tank_mike4_mp");
    var_5.owner = var_3;
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_main_tank_mike4_mp");
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 _meth_828F(var_5);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  } else if(var_1 == "tag_seat_1") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017C(var_3, 0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_mg_gun_tank_mp");
    var_5.owner = var_3;
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 _meth_80AF();
    var_3 controlturreton(var_5);
    s4_tank_addgunnerdamagemod(var_3);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  }

  if(!isDefined(var_2)) {
    var_0 s4_tank_updateheadiconforplayer(var_3);
  }

  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
  s4_tank_updateplayeromnvarsonenter(var_0, var_2, var_1, var_3);

  if(var_1 == "tag_seat_0") {
    var_0 thread s4_tank_monitordriverturretreload(var_3);
  }

  var_0 notify("vehicle_enter_exit");
  var_0 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "enter");

  foreach(var_5 in var_0._id_F897) {
    var_5 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "enter", 1);
  }

  if(!isDefined(var_2)) {
    var_0 thread scripts\mp\teams::outlinefriendlyvehicle_occupantupdate(var_3, "enter");
  }
}

s4_tank_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    thread s4_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

s4_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "tag_seat_0") {
    var_0 notify("s4_tank_driver_exit");
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_main_tank_mike4_mp");
    var_5.owner = undefined;
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      var_5 _meth_8399(var_3.origin);
      var_3 _meth_8290(var_5);
      var_3 _meth_8095();
    }

    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
  } else if(var_1 == "tag_seat_1") {
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "s4_tur_mg_gun_tank_mp");

    if(!istrue(var_4._id_B695)) {
      var_3 _meth_80E2();
      var_3 _meth_8292(var_5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1016A(var_3, var_4._id_B68D);

      if(!istrue(var_4._id_B68D)) {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "s4_tur_mg_gun_tank_mp", var_4, 1);
      }
    }

    var_5.owner = undefined;
    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
    s4_tank_removegunnerdamagemod(var_3);
  }

  if(!istrue(var_4._id_B695)) {
    if(!isDefined(var_2)) {
      var_0 s4_tank_updateheadiconforplayer(var_3);
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D2(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
  var_0 notify("vehicle_enter_exit");
  var_0 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "exit");

  foreach(var_5 in var_0._id_F897) {
    var_5 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "exit", 1);
  }

  if(!isDefined(var_2)) {
    var_0 thread scripts\mp\teams::outlinefriendlyvehicle_occupantupdate(var_3, "exit");
  }
}

s4_tank_reenter(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "tag_seat_1") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "s4_tur_mg_gun_tank_mp", var_4, 1);
  }
}

s4_tank_addgunnerdamagemod(var_0) {
  if(isDefined(var_0._id_72BF)) {
    return;
  }
}

s4_tank_removegunnerdamagemod(var_0) {
  if(!isDefined(var_0._id_72BF)) {
    return;
  }
  var_0._id_72BF = undefined;
}

s4_tank_gunnerdamagemodignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "s4_la_walpha2_mp":
    case "s4_tank_tur_mp":
    case "s4_tur_main_tank_mike4_mp":
      return 0;
    default:
      return 1;
  }
}

s4_tank_premoddamagecallback(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::_id_10054(self, var_0)) {
    return 0;
  }

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectornormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);

  if(vectordot(var_5, var_6) < -0.83) {
    var_0._id_89EE = _id_320D(var_0);
  }

  return 1;
}

_id_320D(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "gl") {
    return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
  }

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "s4_tank_tur_mp":
        return isDefined(var_0._id_9CD6) && (var_0._id_9CD6 == "MOD_PROJECTILE" || var_0._id_9CD6 == "MOD_RIFLE_BULLET");
      case "iw8_la_rpapa7_mp":
      case "tur_apc_rus_mp":
      case "iw8_la_gromeo_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_gromeoks_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_PROJECTILE";
      case "iw8_la_kgolf_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
    }
  }

  return 0;
}

s4_tank_postmoddamagecallback(var_0) {
  return 1;
}

s4_tank_deathcallback(var_0) {
  thread s4_tank_explode(var_0);
  return 1;
}

s4_tank_autodestruct(var_0) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self._id_1F24)) {
    self._id_1F24 = 1;

    if(!scripts\common\utility::iscp()) {
      var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003D(self);
      self.health = int(min(self.health, var_1));
      _id_09CA::_id_10392(self);
      scripts\cp_mp\vehicles\vehicle_damage::_id_10079();
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        s4_tank_updateautodestructui(var_4);
      }

      wait 5.5;
      thread s4_tank_explode(undefined, undefined, 1);
    }
  }
}

s4_tank_turretdustkickup() {
  var_0 = physics_createcontents(["physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  var_1 = self _meth_8150();

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_1[var_1.size] = self;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
  var_3 = var_2 gettagorigin("tag_flash");
  var_4 = var_3 + (-0, -0, -200);
  var_5 = _func_02C1(var_3, var_4, var_0, var_1, 0, "physicsquery_closest", 1);

  if(!isDefined(var_5) || !var_5.size) {
    return;
  }
  var_6 = anglesToForward(var_2 gettagangles("tag_flash") * (0, 1, 0));
  var_7 = var_5[0]["normal"];
  var_8 = _func_025B(var_6, var_7);
  var_7 = _func_025B(var_8, var_6);
  var_9 = _func_0017(var_6, var_8, var_7);
  playFX(scripts\engine\utility::getfx("light_tank_cannon_dust"), var_5[0]["position"], anglesToForward(var_9), anglestoup(var_9));
}

s4_tank_createheadicon(var_0) {
  var_1 = self._id_75E9;

  if(!isDefined(var_1)) {
    var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "s4_tur_main_tank_mike4_mp");
    var_1 = var_2 _id_078F::_id_D592();

    if(!isDefined(var_1)) {
      return 0;
    }

    self._id_75E9 = var_1;
    _func_035D(var_1, 55);
  }

  self._id_75F1 = istrue(var_0);
  var_3 = scripts\engine\utility::ter_op(istrue(var_0), 0, 0);
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), 2250, 2250);
  var_5 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  var_6 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  _func_0359(var_1, var_3);
  _func_035A(var_1, var_4);
  _func_035C(var_1, var_5);
  _func_035B(var_1, var_6);
}

s4_tank_destroyheadicon() {
  _id_078F::_id_D593(self._id_75E9);
  self._id_75E9 = undefined;
  self._id_75F6 = undefined;
  self._id_75F8 = undefined;
}

s4_tank_updateheadicon(var_0, var_1) {
  if(!isDefined(self._id_75E9)) {
    return;
  }
  if(isDefined(var_0)) {
    if(_func_0121(var_0) && var_0 == "none") {
      self._id_75F6 = undefined;
    } else {
      self._id_75F6 = var_0;
    }
  }

  if(isDefined(var_1)) {
    if(var_1 == "none") {
      self._id_75F8 = undefined;
    } else {
      self._id_75F8 = var_1;
    }
  }

  s4_tank_updateheadiconowner();
  s4_tank_updateheadiconteam();
  s4_tank_updateheadiconimage();

  foreach(var_3 in level.players) {
    s4_tank_updateheadiconforplayer(var_3);
  }
}

s4_tank_updateheadiconforplayer(var_0) {
  if(!isDefined(self._id_75E9)) {
    return;
  }
  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && var_1 == self) {
    _id_078F::_id_D599(self._id_75E9, var_0);
  } else {
    var_2 = undefined;

    if(isDefined(self._id_75F6)) {
      var_2 = self._id_75F6;
    } else {
      var_2 = self.owner;
    }

    var_3 = undefined;

    if(isDefined(self._id_75F8)) {
      var_3 = self._id_75F8;
    } else {
      var_3 = self.team;
    }

    var_4 = s4_tank_getleveldata();

    if(level.teambased) {
      if(var_3 == "neutral") {
        if(!isDefined(var_2)) {
          if(1) {
            _id_078F::_id_D590(self._id_75E9, var_0);
          } else {
            _id_078F::_id_D599(self._id_75E9, var_0);
          }

          return;
        } else
          var_3 = var_2.team;
      }

      if(_func_010E(var_3, var_0.team)) {
        if(istrue(var_4._id_DCB1)) {
          _id_078F::_id_D590(self._id_75E9, var_0);
        } else {
          _id_078F::_id_D599(self._id_75E9, var_0);
        }
      } else
        _id_078F::_id_D590(self._id_75E9, var_0);
    } else {
      if(!isDefined(var_2)) {
        if(1) {
          _id_078F::_id_D590(self._id_75E9, var_0);
        } else {
          _id_078F::_id_D599(self._id_75E9, var_0);
        }

        return;
      }

      if(var_0 != var_2) {
        if(var_4._id_DCB1) {
          _id_078F::_id_D590(self._id_75E9, var_0);
          return;
        }

        _id_078F::_id_D599(self._id_75E9, var_0);
        return;
        return;
      }

      _id_078F::_id_D590(self._id_75E9, var_0);
    }
  }
}

s4_tank_updateheadiconforplayeronjointeam(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("s4_tank");

  foreach(var_3 in var_1) {
    var_3 s4_tank_updateheadiconforplayer(var_0);
  }
}

s4_tank_updateheadiconowner() {
  if(level.teambased) {
    return 0;
  }

  var_0 = undefined;

  if(isDefined(self._id_75F6)) {
    var_0 = self._id_75F6;
  } else {
    var_0 = self.owner;
  }

  if(isDefined(var_0)) {
    _func_0365(self._id_75E9, var_0);
  } else {
    _func_0365(self._id_75E9, undefined);
  }

  return 1;
}

s4_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }
  var_0 = s4_tank_getheadiconteam();

  if(isDefined(var_0) && var_0 != "neutral") {
    _func_0364(self._id_75E9, var_0);
  } else {
    _func_0364(self._id_75E9, undefined);
  }
}

s4_tank_updateheadiconimage() {
  var_0 = s4_tank_getleveldata();
  var_1 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 1, 1);

  if(var_1) {
    _func_0356(self._id_75E9, level._id_5897);

    if(1) {
      _func_0358(self._id_75E9, level._id_5896);
    }

    if(var_0._id_DCB1) {
      _func_0357(self._id_75E9, level._id_5896);
    }
  } else {
    var_2 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 1, 1);
    var_3 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 0, var_0._id_DCB1);
    var_4 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
    var_5 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
    var_6 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
    _func_0356(self._id_75E9, var_4);

    if(var_2) {
      _func_0358(self._id_75E9, var_5);
    }

    if(var_3) {
      _func_0357(self._id_75E9, var_6);
    }
  }
}

s4_tank_getheadiconteam() {
  var_0 = undefined;

  if(isDefined(self._id_75F6)) {
    var_0 = self._id_75F6;
  } else {
    var_0 = self.owner;
  }

  var_1 = undefined;

  if(isDefined(self._id_75F8)) {
    var_1 = self._id_75F8;
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

s4_tank_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("s4_tank", 1);
  var_0._id_9C7B = 4;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::s4_tank_getspawnstructscallback;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("s4_tank", "spawnCallback");
  var_0._id_3923 = 130;
  var_0._id_391F = 1000;
  var_0._id_3921 = 130;
}

s4_tank_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getstructarray("s4tank_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

s4_tank_getleveldata() {
  return level.vehicle.s4tank;
}

s4_tank_updateteam(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_0);

  foreach(var_5 in var_3) {
    var_5.team = var_1;
  }

  if(isDefined(var_0._id_75E9)) {
    if(var_2) {
      var_0 s4_tank_updateheadiconteam();
      var_0 s4_tank_updateheadiconimage();

      foreach(var_8 in level.players) {
        var_0 s4_tank_updateheadiconforplayer(var_8);
      }
    }
  }
}

s4_tank_updateowner(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_75E9)) {
    if(var_2) {
      var_0 s4_tank_updateheadiconowner();
    }

    if(var_3) {
      var_0 s4_tank_updateheadiconteam();
      var_0 s4_tank_updateheadiconimage();
    }

    if(var_2 || var_3) {
      foreach(var_5 in level.players) {
        var_0 s4_tank_updateheadiconforplayer(var_5);
      }
    }
  }
}

s4_tank_shouldautodestructfromdamage(var_0) {
  if(!s4_tank_canautodestruct()) {
    return 0;
  }

  var_1 = s4_tank_getleveldata();

  if(var_1._id_1F25 > 0) {
    var_2 = max(self.health - var_0.damage, 0);
    return floor(var_2 / self.maxhealth * 100) <= var_1._id_1F25;
  } else
    return 0;
}

s4_tank_canautodestruct() {
  if(istrue(self._id_1F24)) {
    return 0;
  }

  var_0 = s4_tank_getleveldata();

  if(!var_0._id_3146) {
    return 0;
  }

  return 1;
}

s4_tank_cantimeout() {
  if(!s4_tank_cantimeoutinternal()) {
    return 0;
  }

  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);

  if(isDefined(var_0._id_31F7) && var_0._id_31F7 == 0) {
    return 0;
  }

  var_1 = s4_tank_getleveldata();

  if(!var_1._id_31F7) {
    return 0;
  }

  if(var_1._id_F230 <= 0) {
    return 0;
  }

  return 1;
}

s4_tank_cantimeoutinternal() {
  if(istrue(self._id_1F24)) {
    return 0;
  }

  return 1;
}

s4_tank_updateplayeromnvarsonenter(var_0, var_1, var_2, var_3) {
  if(var_2 == "tag_seat_0") {
    var_0 s4_tank_updatedriverturretammoui();
  }

  var_0 s4_tank_updatetimeoutui(var_3);
  var_0 s4_tank_updateautodestructui(var_3);
}

s4_tank_flippedendcallback(var_0, var_1) {
  if(var_1) {
    var_0 s4_tank_timeout();
  }
}

tank_watch_damage_states() {
  self endon("death");

  for(;;) {
    var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10046();

    switch (var_0) {
      case "pristine":
        break;
      case "light":
        thread light_damage_sound();
        break;
      case "medium":
        thread med_damage_sound();
        break;
      case "heavy":
        thread heavy_damage_sound();
        break;
    }

    self waittill("damage_state_change");
  }
}

light_damage_sound() {
  self playSound("tank_damaged_grey_smoke");
  self playLoopSound("tank_damaged_grey_smoke_lp");
}

med_damage_sound() {
  self playSound("tank_damaged_black_smoke");
  self playLoopSound("tank_damaged_black_smoke_lp");
}

heavy_damage_sound() {
  self playSound("tank_damaged_flame_burst");
  self playLoopSound("tank_damaged_fire_lp");
}

tank_explosion_sound() {
  var_0 = self.origin + (0, 0, 40);
  _id_0847::_id_DF08("tank_damaged_explode_main", var_0);
}