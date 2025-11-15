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

func_618B(param_00) {
  var_01 = 1;
  var_02 = func_7E37(self.origin);
  var_03 = func_6CBF(var_02);
  var_04 = vectortoangles(var_03.origin - var_02.origin);
  if(!isDefined(level.var_A433) || !isDefined(var_02) || !isDefined(var_03)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_05 = func_49DE(self, var_02, var_03, var_04, "air_patrol", param_00.streakname, param_00.lifeid);
  if(!isDefined(var_05)) {
    return 0;
  }

  thread func_376F(var_05);
  return 1;
}

func_49DE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = getent("airstrikeheight", "targetname");
  var_08 = param_02.origin;
  var_09 = anglesToForward(param_03);
  var_0A = param_01.origin;
  var_0B = spawnhelicopter(param_00, var_0A, var_09, level.var_A434[param_04].vehicleinfo, level.var_A434[param_04].modelbase);
  if(!isDefined(var_0B)) {
    return;
  }

  var_0B getrandomweaponfromcategory();
  var_0B getvalidpointtopointmovelocation(1);
  var_0B.health = level.var_A434[param_04].health;
  var_0B.maxhealth = level.var_A434[param_04].maxhealth;
  var_0B.var_E1 = 0;
  var_0B.var_10955 = ::func_3758;
  var_0B.lifeid = param_06;
  var_0B.getclosestpointonnavmesh3d = 200;
  var_0B.triggerportableradarping = param_00;
  var_0B.team = param_00.team;
  var_0B.var_52D0 = 0;
  var_0B.var_A436 = param_04;
  var_0B.streakname = param_05;
  var_0B.empgrenaded = 0;
  var_0B.missionfailed = var_09;
  var_0B.var_C973 = var_0A;
  var_0B.var_C96C = var_08;
  var_0B.var_4BF7 = param_02;
  var_0B.var_A435 = 0;
  var_0B scripts\mp\killstreaks\_utility::func_1843(param_05, "Killstreak_Air", param_00, 1);
  var_0B vehicle_setspeed(var_0B.getclosestpointonnavmesh3d, 70, 50);
  var_0B givelastonteamwarning(120, 90);
  var_0B setneargoalnotifydist(150);
  var_0B sethoverparams(20, 10, 5);
  var_0B setotherent(param_00);
  var_0B setCanDamage(1);
  var_0B scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", param_00);
  var_0B thread func_5C29();
  var_0B thread func_5C2A();
  var_0B thread func_5C26();
  var_0B thread func_5C28();
  var_0B thread func_5C2B();
  var_0B thread func_5C27();
  return var_0B;
}

func_376F(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_01 = 1;
  var_02 = undefined;
  thread scripts\mp\utility::teamplayercardsplash("used_jammer", self);
  for(;;) {
    if(param_00.var_A435 && !isDefined(var_02)) {
      playFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), param_00, "tag_origin");
      var_02 = 1;
    } else if(!param_00.var_A435 && isDefined(var_02)) {
      stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), param_00, "tag_origin");
      var_02 = undefined;
    }

    param_00 setvehgoalpos(param_00.var_C96C, var_01);
    param_00 waittill("near_goal");
    if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435) {
      param_00 waittill("goal");
    }

    if(!isDefined(param_00.var_DD1C)) {
      param_00 vehicle_setspeed(10, 5, 500);
      param_00.var_DD1C = 1;
    }

    if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435) {
      param_00 thread func_5C83(self);
      param_00 waittill("finished_emp_pulse");
    }

    param_00.var_4BF7 = func_6CBF(param_00.var_4BF7);
    param_00.var_C96C = param_00.var_4BF7.origin;
    if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435) {
      var_01 = 1;
      continue;
    }

    var_01 = 0;
  }
}

func_9DD5(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_A432) {
    if(param_00 == var_03) {
      var_01 = 1;
      break;
    }
  }

  return var_01;
}

func_6CBF(param_00) {
  var_01 = param_00.target;
  var_02 = scripts\engine\utility::getstruct(var_01, "targetname");
  return var_02;
}

func_3758(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(isDefined(var_0C.var_1D41) && var_0C.var_1D41) {
    return;
  }

  if(!scripts\mp\weapons::friendlyfirecheck(var_0C.triggerportableradarping, param_01)) {
    return;
  }

  if(isDefined(param_03) && param_03 & level.idflags_penetration) {
    var_0C.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(param_03) && param_03 & level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  var_0C.wasdamaged = 1;
  if(isDefined(param_05)) {
    switch (param_05) {
      case "precision_airstrike_mp":
        param_02 = param_02 * 4;
        break;
    }
  }

  if(param_04 == "MOD_MELEE") {
    param_02 = var_0C.maxhealth * 0.5;
  }

  var_0D = param_02;
  if(isplayer(param_01)) {
    param_01 scripts\mp\damagefeedback::updatedamagefeedback("");
    if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET") {
      if(param_01 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0D = var_0D + param_02 * level.armorpiercingmod;
      }
    }

    if(isexplosivedamagemod(param_04)) {
      var_0D = var_0D + param_02;
    }
  }

  if(isexplosivedamagemod(param_04) && isDefined(param_05) && param_05 == "destructible_car") {
    var_0D = var_0C.maxhealth;
  }

  if(isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
    param_01.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("");
  }

  if(isDefined(param_05)) {
    switch (param_05) {
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

    scripts\mp\killstreaks\_killstreaks::killstreakhit(param_01, param_05, self);
  }

  var_0C.var_E1 = var_0C.var_E1 + var_0D;
  if(var_0C.var_E1 >= var_0C.maxhealth) {
    if(isplayer(param_01) && !isDefined(var_0C.triggerportableradarping) || param_01 != var_0C.triggerportableradarping) {
      var_0C.var_1D41 = 1;
      var_0C scripts\mp\damage::onkillstreakkilled("jammer", param_01, param_05, param_04, param_02, "destroyed_" + var_0C.streakname, var_0C.streakname + "_destroyed", "callout_destroyed_" + var_0C.streakname, 1);
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
  var_00 = level.var_A434[self.var_A436].var_AC75;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death");
}

func_5C27() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(isDefined(self.var_10955)) {
      self[[self.var_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
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

func_5C83(param_00) {
  self endon("death");
  self.var_A435 = 1;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait(1.5);
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");
  thread empremovecallback();
  var_01 = param_00.pers["team"];
  if(level.teambased) {
    var_02 = scripts\mp\utility::getotherteam(var_01);
    thread func_6165(var_02, param_00);
  } else {
    thread func_6164(param_00);
  }

  param_00 scripts\mp\matchdata::logkillstreakevent("jammer", self.origin);
  level notify("emp_used");
  self notify("finished_emp_pulse");
}

empremovecallback() {
  self endon("death");
  level waittill("player_spawned", var_00);
  if(level.teambased) {
    if(var_00 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_00 != self.triggerportableradarping && var_00.team != self.triggerportableradarping.team) {
      var_00 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_00 shellshock("flashbang_mp", 0.5);
      var_00 thread remotedefusecallback(self);
      return;
    }

    return;
  }

  if(var_00 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_00 != self.triggerportableradarping) {
    var_00 scripts\mp\killstreaks\_emp_common::func_20C3();
    var_00 shellshock("flashbang_mp", 0.5);
    var_00 thread remotedefusecallback(self);
  }
}

func_6165(param_00, param_01) {
  level endon("game_ended");
  wait(0.5);
  level notify("EMP_JamTeam" + param_00);
  level endon("EMP_JamTeam" + param_00);
  foreach(var_03 in level.players) {
    if(var_03 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_03 != param_01 && var_03.team != param_01.team) {
      var_03 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_03 shellshock("flashbang_mp", 0.5);
      var_03 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\_emp_common::func_20CD();
  level notify("emp_update");
  level func_52C5(param_01, param_00);
  level.teamemped[param_00] = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
  level.teamemped[param_00] = 0;
  if(isDefined(self)) {
    self.var_A435 = 0;
  }

  level notify("emp_update");
}

func_6164(param_00) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  wait(0.5);
  if(!isDefined(param_00)) {
    return;
  }

  level.empplayer = param_00;
  foreach(var_02 in level.players) {
    if(var_02 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_02 != param_00) {
      var_02 scripts\mp\killstreaks\_emp_common::func_20C3();
      var_02 shellshock("flashbang_mp", 0.5);
      var_02 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\_emp_common::func_20CD();
  level notify("emp_update");
  level.empplayer thread empradarwatcher();
  level func_52C5(param_00);
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

func_531D(param_00, param_01, param_02) {
  var_03 = "killstreak_jammer_mp";
  if(isDefined(param_02)) {
    var_03 = param_02;
  }

  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.turrets);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.placedims);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.balldrones);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.mines);
}

func_52CA(param_00, param_01, param_02) {
  var_03 = "aamissile_projectile_mp";
  if(isDefined(param_02)) {
    var_03 = param_02;
  }

  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.helis);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.littlebirds);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.remote_uav);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.planes);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.var_105EA);
  if(isDefined(param_01)) {
    scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, level.uavmodels[param_01]);
  } else {
    var_04 = [];
    foreach(var_07, var_06 in level.uavmodels) {
      if(issubstr(var_07, param_00.guid)) {
        continue;
      }

      var_04[var_04.size] = var_06;
    }

    scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, var_04);
  }

  var_08 = [];
  if(isDefined(param_01)) {
    foreach(var_0A in level.players) {
      if(var_0A.team == param_00.team) {
        continue;
      }

      if(scripts\mp\utility::func_9EF0(var_0A)) {
        var_08[var_08.size] = var_0A;
      }
    }

    scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, var_03, var_08);
  }
}

func_52C5(param_00, param_01, param_02) {
  level func_531D(param_00, param_01, param_02);
  level func_52CA(param_00, param_01, param_02);
}

func_7E37(param_00) {
  var_01 = undefined;
  var_02 = 999999;
  foreach(var_04 in level.var_A433) {
    var_05 = distance(var_04.origin, param_00);
    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

remotedefusecallback(param_00) {
  self endon("death");
  self endon("disconnect");
  param_00 waittill("death");
  scripts\mp\killstreaks\_emp_common::func_E0F3();
}