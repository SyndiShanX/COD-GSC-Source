/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3496.gsc
***************************************/

init() {
  level.teamemped["allies"] = 0;
  level.teamemped["axis"] = 0;
  level.empplayer = undefined;
  level.empstuntime = 10.0;
  level.emptriggerholdonuse = int(level.empstuntime);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("jammer", ::func_618B);
  level.func_A434["air_patrol"] = spawnStruct();
  level.func_A434["air_patrol"].func_AC75 = 60;
  level.func_A434["air_patrol"].health = 99999;
  level.func_A434["air_patrol"].maxhealth = 1000;
  level.func_A434["air_patrol"].streakname = "jammer";
  level.func_A434["air_patrol"].vehicleinfo = "veh_jammer_drone_mp";
  level.func_A434["air_patrol"].sentrymodeoff = "sentry_offline";
  level.func_A434["air_patrol"].modelbase = "veh_jammer_drone_model";
  level.func_A434["air_patrol"].func_A84D = "killstreak_remote_tank_laptop_mp";
  level.func_A434["air_patrol"].remotedetonatethink = "killstreak_remote_tank_remote_mp";
  level.func_A434["air_patrol"].func_12A72 = "sentry_shock_mp";
  level._effect["jammer_drone_explode"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_explosion");
  level._effect["jammer_drone_spark"] = loadfx("vfx\core\impacts\large_metal_painted_hit");
  level._effect["jammer_drone_pulse"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_pulse");
  level._effect["jammer_drone_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_charge");
  level._effect["jammer_drone_shockwave"] = loadfx("vfx\iw7\_requests\mp\vfx_jammer_drone_emp_shockwave");
  func_F764();
  func_F765();
}

func_F764() {
  level.func_A433 = scripts\engine\utility::getstructarray("jammer_drone_start", "targetname");
}

func_F765() {
  level.func_A432 = scripts\engine\utility::getstructarray("jammer_drone_emp", "script_noteworthy");
}

func_618B(var_00) {
  var_01 = 1;
  var_02 = func_7E37(self.origin);
  var_03 = func_6CBF(var_02);
  var_04 = vectortoangles(var_3.origin - var_2.origin);

  if(!isDefined(level.func_A433) || !isDefined(var_02) || !isDefined(var_03)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_05 = func_49DE(self, var_02, var_03, var_04, "air_patrol", var_0.streakname, var_0.lifeid);

  if(!isDefined(var_05))
    return 0;

  thread func_376F(var_05);
  return 1;
}

func_49DE(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = getent("airstrikeheight", "targetname");
  var_08 = var_2.origin;
  var_09 = anglesToForward(var_03);
  var_10 = var_1.origin;
  var_11 = spawnhelicopter(var_00, var_10, var_09, level.func_A434[var_04].vehicleinfo, level.func_A434[var_04].modelbase);

  if(!isDefined(var_11)) {
    return;
  }
  var_11 getrandomweaponfromcategory();
  var_11 getvalidpointtopointmovelocation(1);
  var_11.health = level.func_A434[var_04].health;
  var_11.maxhealth = level.func_A434[var_04].maxhealth;
  var_11.damagetaken = 0;
  var_11.func_10955 = ::func_3758;
  var_11.lifeid = var_06;
  var_11.speed = 200;
  var_11.owner = var_00;
  var_11.team = var_0.team;
  var_11.func_52D0 = 0;
  var_11.func_A436 = var_04;
  var_11.streakname = var_05;
  var_11.empgrenaded = 0;
  var_11.forward = var_09;
  var_11.func_C973 = var_10;
  var_11.func_C96C = var_08;
  var_11.func_4BF7 = var_02;
  var_11.func_A435 = 0;
  var_11 scripts\mp\killstreaks\utility::func_1843(var_05, "Killstreak_Air", var_00, 1);
  var_11 vehicle_setspeed(var_11.speed, 70, 50);
  var_11 setyawspeed(120, 90);
  var_11 setneargoalnotifydist(150);
  var_11 sethoverparams(20, 10, 5);
  var_11 setotherent(var_00);
  var_11 setCanDamage(1);
  var_11 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_00);
  var_11 thread func_5C29();
  var_11 thread func_5C2A();
  var_11 thread func_5C26();
  var_11 thread func_5C28();
  var_11 thread func_5C2B();
  var_11 thread func_5C27();
  return var_11;
}

func_376F(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  var_01 = 1;
  var_02 = undefined;
  thread scripts\mp\utility\game::teamplayercardsplash("used_jammer", self);

  for(;;) {
    if(var_0.func_A435 && !isDefined(var_02)) {
      playFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), var_00, "tag_origin");
      var_02 = 1;
    } else if(!var_0.func_A435 && isDefined(var_02)) {
      stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_pulse"), var_00, "tag_origin");
      var_02 = undefined;
    }

    var_00 setvehgoalpos(var_0.func_C96C, var_01);
    var_00 waittill("near_goal");

    if(func_9DD5(var_0.func_4BF7) && !var_0.func_A435)
      var_00 waittill("goal");

    if(!isDefined(var_0.func_DD1C)) {
      var_00 vehicle_setspeed(10, 5, 500);
      var_0.func_DD1C = 1;
    }

    if(func_9DD5(var_0.func_4BF7) && !var_0.func_A435) {
      var_00 thread func_5C83(self);
      var_00 waittill("finished_emp_pulse");
    }

    var_0.func_4BF7 = func_6CBF(var_0.func_4BF7);
    var_0.func_C96C = var_0.func_4BF7.origin;

    if(func_9DD5(var_0.func_4BF7) && !var_0.func_A435) {
      var_01 = 1;
      continue;
    }

    var_01 = 0;
  }
}

func_9DD5(var_00) {
  var_01 = 0;

  foreach(var_03 in level.func_A432) {
    if(var_00 == var_03) {
      var_01 = 1;
      break;
    }
  }

  return var_01;
}

func_6CBF(var_00) {
  var_01 = var_0.target;
  var_02 = scripts\engine\utility::getstruct(var_01, "targetname");
  return var_02;
}

func_3758(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self;

  if(isDefined(var_12.func_1D41) && var_12.func_1D41) {
    return;
  }
  if(!scripts\mp\weapons::friendlyfirecheck(var_12.owner, var_01)) {
    return;
  }
  if(isDefined(var_03) && var_03 &level.idflags_penetration)
    var_12.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_03) && var_03 &level.idflags_no_team_protection)
    self.wasdamagedfrombulletricochet = 1;

  var_12.wasdamaged = 1;

  if(isDefined(var_05)) {
    switch (var_05) {
      case "precision_airstrike_mp":
        var_02 = var_02 * 4;
        break;
    }
  }

  if(var_04 == "MOD_MELEE")
    var_02 = var_12.maxhealth * 0.5;

  var_13 = var_02;

  if(isplayer(var_01)) {
    var_01 scripts\mp\damagefeedback::updatedamagefeedback("");

    if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
      if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing"))
        var_13 = var_13 + var_02 * level.armorpiercingmod;
    }

    if(isexplosivedamagemod(var_04))
      var_13 = var_13 + var_02;
  }

  if(isexplosivedamagemod(var_04) && (isDefined(var_05) && var_05 == "destructible_car"))
    var_13 = var_12.maxhealth;

  if(isDefined(var_1.owner) && isplayer(var_1.owner))
    var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("");

  if(isDefined(var_05)) {
    switch (var_05) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        var_12.largeprojectiledamage = 1;
        var_13 = var_12.maxhealth + 1;
        break;
      case "stealth_bomb_mp":
      case "artillery_mp":
        var_12.largeprojectiledamage = 0;
        var_13 = var_12.maxhealth * 0.5;
        break;
      case "bomb_site_mp":
        var_12.largeprojectiledamage = 0;
        var_13 = var_12.maxhealth + 1;
        break;
      case "emp_grenade_mp":
        var_13 = 0;
        break;
      case "ims_projectile_mp":
        var_12.largeprojectiledamage = 1;
        var_13 = var_12.maxhealth * 0.5;
        break;
    }

    scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_05, self);
  }

  var_12.damagetaken = var_12.damagetaken + var_13;

  if(var_12.damagetaken >= var_12.maxhealth) {
    if(isplayer(var_01) && (!isDefined(var_12.owner) || var_01 != var_12.owner)) {
      var_12.func_1D41 = 1;
      var_12 scripts\mp\damage::onkillstreakkilled("jammer", var_01, var_05, var_04, var_02, "destroyed_" + var_12.streakname, var_12.streakname + "_destroyed", "callout_destroyed_" + var_12.streakname, 1);
    }

    var_12 notify("death");
  }
}

func_5C29() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

func_5C2A() {
  self endon("death");
  self.owner waittill("stop_using_remote");
  self notify("death");
}

func_5C26() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  self notify("death");
}

func_5C2B() {
  self endon("death");
  var_00 = level.func_A434[self.func_A436].func_AC75;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death");
}

func_5C27() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(isDefined(self.func_10955))
      self[[self.func_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
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

func_5C83(var_00) {
  self endon("death");
  self.func_A435 = 1;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");
  thread empremovecallback();
  var_01 = var_0.pers["team"];

  if(level.teambased) {
    var_02 = scripts\mp\utility\game::getotherteam(var_01);
    thread func_6165(var_02, var_00);
  } else
    thread func_6164(var_00);

  var_00 scripts\mp\matchdata::logkillstreakevent("jammer", self.origin);
  level notify("emp_used");
  self notify("finished_emp_pulse");
}

empremovecallback() {
  self endon("death");
  level waittill("player_spawned", var_00);

  if(level.teambased) {
    if(var_00 scripts\mp\killstreaks\emp_common::func_FFC5() && var_00 != self.owner && var_0.team != self.owner.team) {
      var_00 scripts\mp\killstreaks\emp_common::func_20C3();
      var_00 shellshock("flashbang_mp", 0.5);
      var_00 thread remotedefusecallback(self);
    }
  } else if(var_00 scripts\mp\killstreaks\emp_common::func_FFC5() && var_00 != self.owner) {
    var_00 scripts\mp\killstreaks\emp_common::func_20C3();
    var_00 shellshock("flashbang_mp", 0.5);
    var_00 thread remotedefusecallback(self);
  }
}

func_6165(var_00, var_01) {
  level endon("game_ended");
  wait 0.5;
  level notify("EMP_JamTeam" + var_00);
  level endon("EMP_JamTeam" + var_00);

  foreach(var_03 in level.players) {
    if(var_03 scripts\mp\killstreaks\emp_common::func_FFC5() && var_03 != var_01 && var_3.team != var_1.team) {
      var_03 scripts\mp\killstreaks\emp_common::func_20C3();
      var_03 shellshock("flashbang_mp", 0.5);
      var_03 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\emp_common::func_20CD();
  level notify("emp_update");
  level func_52C5(var_01, var_00);
  level.teamemped[var_00] = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
  level.teamemped[var_00] = 0;

  if(isDefined(self))
    self.func_A435 = 0;

  level notify("emp_update");
}

func_6164(var_00) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  wait 0.5;

  if(!isDefined(var_00)) {
    return;
  }
  level.empplayer = var_00;

  foreach(var_02 in level.players) {
    if(var_02 scripts\mp\killstreaks\emp_common::func_FFC5() && var_02 != var_00) {
      var_02 scripts\mp\killstreaks\emp_common::func_20C3();
      var_02 shellshock("flashbang_mp", 0.5);
      var_02 thread remotedefusecallback(self);
    }
  }

  level thread scripts\mp\killstreaks\emp_common::func_20CD();
  level notify("emp_update");
  level.empplayer thread empradarwatcher();
  level func_52C5(var_00);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);

  if(isDefined(self))
    self.func_A435 = 0;

  level notify("emp_update");
  level notify("emp_ended");
}

func_A577() {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");
  level endon("emp_ended");

  for(level.emptriggerholdonuse = int(level.empstuntime); level.emptriggerholdonuse; level.emptriggerholdonuse--)
    wait 1.0;
}

empradarwatcher() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");
  self waittill("disconnect");
  level notify("emp_update");
}

func_531D(var_00, var_01, var_02) {
  var_03 = "killstreak_jammer_mp";

  if(isDefined(var_02))
    var_03 = var_02;

  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.turrets);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.placedims);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.balldrones);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.mines);
}

func_52CA(var_00, var_01, var_02) {
  var_03 = "aamissile_projectile_mp";

  if(isDefined(var_02))
    var_03 = var_02;

  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.helis);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.littlebirds);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.remote_uav);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.planes);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.func_105EA);

  if(isDefined(var_01))
    scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, level.uavmodels[var_01]);
  else {
    var_04 = [];

    foreach(var_07, var_06 in level.uavmodels) {
      if(issubstr(var_07, var_0.guid)) {
        continue;
      }
      var_4[var_4.size] = var_06;
    }

    scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, var_04);
  }

  var_08 = [];

  if(isDefined(var_01)) {
    foreach(var_10 in level.players) {
      if(var_10.team == var_0.team) {
        continue;
      }
      if(scripts\mp\utility\game::func_9EF0(var_10))
        var_8[var_8.size] = var_10;
    }

    scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, var_03, var_08);
  }
}

func_52C5(var_00, var_01, var_02) {
  level func_531D(var_00, var_01, var_02);
  level func_52CA(var_00, var_01, var_02);
}

func_7E37(var_00) {
  var_01 = undefined;
  var_02 = 999999;

  foreach(var_04 in level.func_A433) {
    var_05 = distance(var_4.origin, var_00);

    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

remotedefusecallback(var_00) {
  self endon("death");
  self endon("disconnect");
  var_00 waittill("death");
  scripts\mp\killstreaks\emp_common::func_E0F3();
}