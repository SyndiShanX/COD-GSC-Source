/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_jammer_drone.gsc
****************************************************/

init() {
  level.teamemped["allies"] = 0;
  level.teamemped["axis"] = 0;
  level.empplayer = undefined;
  level.empstuntime = 10;
  level.emptriggerholdonuse = int(level.empstuntime);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("jammer", ::func_618B);
  level.var_A434["air_patrol"] = spawnStruct();
  level.var_A434["air_patrol"].var_AC75 = 60;
  level.var_A434["air_patrol"].health = 99999;
  level.var_A434["air_patrol"].maxhealth = 1000;
  level.var_A434["air_patrol"].streakname = "jammer";
  level.var_A434["air_patrol"].vehicleinfo = "veh_jammer_drone_mp";
  level.var_A434["air_patrol"].sentrymodeoff = "sentry_offline";
  level.var_A434["air_patrol"].modelbase = "veh_jammer_drone_model";
  level.var_A434["air_patrol"].var_A84D = "killstreak_remote_tank_laptop_mp";
  level.var_A434["air_patrol"].remotedetonatethink = "killstreak_remote_tank_remote_mp";
  level.var_A434["air_patrol"].var_12A72 = "sentry_shock_mp";
  level._effect["jammer_drone_explode"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_explosion");
  level._effect["jammer_drone_spark"] = loadfx("vfx\core\impacts\large_metal_painted_hit");
  level._effect["jammer_drone_pulse"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_pulse");
  level._effect["jammer_drone_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_charge");
  level._effect["jammer_drone_shockwave"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_shockwave");
  func_F764();
  func_F765();
}

func_F764() {
  level.var_A433 = scripts\engine\utility::getstructarray("jammer_drone_start", "targetname");
}

func_F765() {
  level.var_A432 = scripts\engine\utility::getstructarray("jammer_drone_emp", "script_noteworthy");
}

func_618B(var_0) {
  var_1 = 1;
  var_2 = func_7E37(self.origin);
  var_3 = func_6CBF(var_2);
  var_4 = vectortoangles(var_3.origin - var_2.origin);
  if(!isDefined(level.var_A433) || !isDefined(var_2) || !isDefined(var_3)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_5 = func_49DE(self, var_2, var_3, var_4, "air_patrol", var_0.streakname, var_0.lifeid);
  if(!isDefined(var_5)) {
    return 0;
  }

  thread func_376F(var_5);
  return 1;
}

func_49DE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getent("airstrikeheight", "targetname");
  var_8 = var_2.origin;
  var_9 = anglesToForward(var_3);
  var_0A = var_1.origin;
  var_0B = spawnhelicopter(var_0, var_0A, var_9, level.var_A434[var_4].vehicleinfo, level.var_A434[var_4].modelbase);
  if(!isDefined(var_0B)) {
    return;
  }

  var_0B getrandomweaponfromcategory();
  var_0B getvalidpointtopointmovelocation(1);
  var_0B.health = level.var_A434[var_4].health;
  var_0B.maxhealth = level.var_A434[var_4].maxhealth;
  var_0B.var_E1 = 0;
  var_0B.var_10955 = ::func_3758;
  var_0B.lifeid = var_6;
  var_0B.getclosestpointonnavmesh3d = 200;
  var_0B.triggerportableradarping = var_0;
  var_0B.team = var_0.team;
  var_0B.var_52D0 = 0;
  var_0B.var_A436 = var_4;
  var_0B.streakname = var_5;
  var_0B.empgrenaded = 0;
  var_0B.missionfailed = var_9;
  var_0B.var_C973 = var_0A;
  var_0B.var_C96C = var_8;
  var_0B.var_4BF7 = var_2;
  var_0B.var_A435 = 0;
  var_0B scripts\mp\killstreaks\_utility::func_1843(var_5, "Killstreak_Air", var_0, 1);
  var_0B vehicle_setspeed(var_0B.getclosestpointonnavmesh3d, 70, 50);
  var_0B givelastonteamwarning(120, 90);
  var_0B setneargoalnotifydist(150);
  var_0B sethoverparams(20, 10, 5);
  var_0B setotherent(var_0);
  var_0B setCanDamage(1);
  var_0B scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0);
  var_0B thread func_5C29();
  var_0B thread func_5C2A();
  var_0B thread func_5C26();
  var_0B thread func_5C28();
  var_0B thread func_5C2B();
  var_0B thread func_5C27();
  return var_0B;
}

func_376F(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 1;
  var_2 = undefined;
  thread scripts\mp\utility::teamplayercardsplash("used_jammer", self);
  for(;;) {
    if(var_0.var_A435 && !isDefined(var_2)) {
      playFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), var_0, "tag_origin");
      var_2 = 1;
    } else if(!var_0.var_A435 && isDefined(var_2)) {
      stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), var_0, "tag_origin");
      var_2 = undefined;
    }

    var_0 setvehgoalpos(var_0.var_C96C, var_1);
    var_0 waittill("near_goal");
    if(func_9DD5(var_0.var_4BF7) && !var_0.var_A435) {
      var_0 waittill("goal");
    }

    if(!isDefined(var_0.var_DD1C)) {
      var_0 vehicle_setspeed(10, 5, 500);
      var_0.var_DD1C = 1;
    }

    if(func_9DD5(var_0.var_4BF7) && !var_0.var_A435) {
      var_0 thread func_5C83(self);
      var_0 waittill("finished_emp_pulse");
    }

    var_0.var_4BF7 = func_6CBF(var_0.var_4BF7);
    var_0.var_C96C = var_0.var_4BF7.origin;
    if(func_9DD5(var_0.var_4BF7) && !var_0.var_A435) {
      var_1 = 1;
      continue;
    }

    var_1 = 0;
  }
}

func_9DD5(var_0) {
  var_1 = 0;
  foreach(var_3 in level.var_A432) {
    if(var_0 == var_3) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

func_6CBF(var_0) {
  var_1 = var_0.target;
  var_2 = scripts\engine\utility::getstruct(var_1, "targetname");
  return var_2;
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
  if(isDefined(var_0C.var_1D41) && var_0C.var_1D41) {
    return;
  }

  if(!scripts\mp\weapons::friendlyfirecheck(var_0C.triggerportableradarping, var_1)) {
    return;
  }

  if(isDefined(var_3) && var_3 &level.idflags_penetration) {
    var_0C.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_3) && var_3 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  var_0C.wasdamaged = 1;
  if(isDefined(var_5)) {
    switch (var_5) {
      case "precision_airstrike_mp":
        var_2 = var_2 * 4;
        break;
    }
  }

  if(var_4 == "MOD_MELEE") {
    var_2 = var_0C.maxhealth * 0.5;
  }

  var_0D = var_2;
  if(isplayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
      if(var_1 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0D = var_0D + var_2 * level.armorpiercingmod;
      }
    }

    if(isexplosivedamagemod(var_4)) {
      var_0D = var_0D + var_2;
    }
  }

  if(isexplosivedamagemod(var_4) && isDefined(var_5) && var_5 == "destructible_car") {
    var_0D = var_0C.maxhealth;
  }

  if(isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
    var_1.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("");
  }

  if(isDefined(var_5)) {
    switch (var_5) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        var_0C.largeprojectiledamage = 1;
        var_0D = var_0C.maxhealth + 1;
        break;

      case "stealth_bomb_mp":
      case "artillery_mp":
        var_0C.largeprojectiledamage = 0;
        var_0D = var_0C.maxhealth * 0.5;
        break;

      case "bomb_site_mp":
        var_0C.largeprojectiledamage = 0;
        var_0D = var_0C.maxhealth + 1;
        break;

      case "emp_grenade_mp":
        var_0D = 0;
        break;

      case "ims_projectile_mp":
        var_0C.largeprojectiledamage = 1;
        var_0D = var_0C.maxhealth * 0.5;
        break;
    }

    scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_5, self);
  }

  var_0C.var_E1 = var_0C.var_E1 + var_0D;
  if(var_0C.var_E1 >= var_0C.maxhealth) {
    if(isplayer(var_1) && !isDefined(var_0C.triggerportableradarping) || var_1 != var_0C.triggerportableradarping) {
      var_0C.var_1D41 = 1;
      var_0C scripts\mp\damage::onkillstreakkilled("jammer", var_1, var_5, var_4, var_2, "destroyed_" + var_0C.streakname, var_0C.streakname + "_destroyed", "callout_destroyed_" + var_0C.streakname, 1);
    }

    var_0C notify("death");
  }
}

func_5C29() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self notify("death");
}

func_5C2A() {
  self endon("death");
  self.triggerportableradarping waittill("stop_using_remote");
  self notify("death");
}

func_5C26() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  self notify("death");
}

func_5C2B() {
  self endon("death");
  var_0 = level.var_A434[self.var_A436].var_AC75;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death");
}

func_5C27() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(self.var_10955)) {
      self[[self.var_10955]](undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7);
    }
  }
}

func_5C28() {
  level endon("game_ended");
  self waittill("death");
  self playSound("sentry_explode");
  playFX(level._effect["jammer_drone_explode"], self.origin);
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

func_5C83(var_0) {
  self endon("death");
  self.var_A435 = 1;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait(1.5);
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");
  thread empremovecallback();
  var_1 = var_0.pers["team"];
  if(level.teambased) {
    var_2 = scripts\mp\utility::getotherteam(var_1);
    thread func_6165(var_2, var_0);
  } else {
    thread func_6164(var_0);
  }

  var_0 scripts\mp\matchdata::logkillstreakevent("jammer", self.origin);
  level notify("emp_used");
  self notify("finished_emp_pulse");
}

empremovecallback() {
  self endon("death");
  level waittill("player_spawned", var_0);
  if(level.teambased) {
    if(var_0 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_0 != self.triggerportableradarping && var_0.team != self.triggerportableradarping.team) {
      var_0 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_0 shellshock("flashbang_mp", 0.5);
      var_0 thread remotedefusecallback(self);
      return;
    }

    return;
  }

  if(var_0 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_0 != self.triggerportableradarping) {
    var_0 scripts\mp\killstreaks\_emp_common::func_20C3();
    var_0 shellshock("flashbang_mp", 0.5);
    var_0 thread remotedefusecallback(self);
  }
}

func_6165(var_0, var_1) {
  level endon("game_ended");
  wait(0.5);
  level notify("EMP_JamTeam" + var_0);
  level endon("EMP_JamTeam" + var_0);
  foreach(var_3 in level.players) {
    if(var_3 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_3 != var_1 && var_3.team != var_1.team) {
      var_3 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_3 shellshock("flashbang_mp", 0.5);
      var_3 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\_emp_common::func_20CD();
  level notify("emp_update");
  level func_52C5(var_1, var_0);
  level.teamemped[var_0] = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
  level.teamemped[var_0] = 0;
  if(isDefined(self)) {
    self.var_A435 = 0;
  }

  level notify("emp_update");
}

func_6164(var_0) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  wait(0.5);
  if(!isDefined(var_0)) {
    return;
  }

  level.empplayer = var_0;
  foreach(var_2 in level.players) {
    if(var_2 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_2 != var_0) {
      var_2 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_2 shellshock("flashbang_mp", 0.5);
      var_2 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\_emp_common::func_20CD();
  level notify("emp_update");
  level.empplayer thread empradarwatcher();
  level func_52C5(var_0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
  if(isDefined(self)) {
    self.var_A435 = 0;
  }

  level notify("emp_update");
  level notify("emp_ended");
}

func_A577() {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");
  level endon("emp_ended");
  level.emptriggerholdonuse = int(level.empstuntime);
  while(level.emptriggerholdonuse) {
    wait(1);
    level.emptriggerholdonuse--;
  }
}

empradarwatcher() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");
  self waittill("disconnect");
  level notify("emp_update");
}

func_531D(var_0, var_1, var_2) {
  var_3 = "killstreak_jammer_mp";
  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.turrets);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.placedims);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.balldrones);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.mines);
}

func_52CA(var_0, var_1, var_2) {
  var_3 = "aamissile_projectile_mp";
  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.helis);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.littlebirds);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.remote_uav);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.planes);
  scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.var_105EA);
  if(isDefined(var_1)) {
    scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, level.uavmodels[var_1]);
  } else {
    var_4 = [];
    foreach(var_7, var_6 in level.uavmodels) {
      if(issubstr(var_7, var_0.guid)) {
        continue;
      }

      var_4[var_4.size] = var_6;
    }

    scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, var_4);
  }

  var_8 = [];
  if(isDefined(var_1)) {
    foreach(var_0A in level.players) {
      if(var_0A.team == var_0.team) {
        continue;
      }

      if(scripts\mp\utility::func_9EF0(var_0A)) {
        var_8[var_8.size] = var_0A;
      }
    }

    scripts\mp\killstreaks\_killstreaks::func_532A(var_0, var_1, var_3, var_8);
  }
}

func_52C5(var_0, var_1, var_2) {
  level func_531D(var_0, var_1, var_2);
  level func_52CA(var_0, var_1, var_2);
}

func_7E37(var_0) {
  var_1 = undefined;
  var_2 = 999999;
  foreach(var_4 in level.var_A433) {
    var_5 = distance(var_4.origin, var_0);
    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

remotedefusecallback(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 waittill("death");
  scripts\mp\killstreaks\_emp_common::func_E0F3();
}