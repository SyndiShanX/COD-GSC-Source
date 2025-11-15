/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_jackal.gsc
**********************************************/

func_2A6B(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_support_drop")) {
    var_04 = scripts\mp\killstreaks\_target_marker::_meth_819B(param_03);
    if(!isDefined(var_04.location)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level.var_A22D) || level.jackals.size > 0) {
      if(isDefined(var_04.var_1349C)) {
        var_04.var_1349C delete();
      }

      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      if(isDefined(param_03.var_394) && param_03.var_394 != "none") {
        self notify("killstreak_finished_with_weapon_" + param_03.var_394);
      }

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level.var_A22D = 1;
  var_05 = getent("airstrikeheight", "targetname");
  if(isDefined(var_05)) {
    var_06 = var_05.origin[2] + 100;
  } else if(isDefined(level.airstrikeheightscale)) {
    var_06 = 850 * level.airstrikeheightscale;
  } else {
    var_06 = 850;
  }

  if(isDefined(var_04) && isDefined(var_04.location)) {
    param_02 = var_04.location;
  }

  param_02 = param_02 * (1, 1, 0);
  var_07 = param_02 + (0, 0, var_06);
  var_08 = func_108DE(param_00, self, param_01, var_07, param_03);
  var_09 = var_07;
  var_0A = var_07 + anglestoright(self.angles) * 2000;
  var_0B = var_07 - anglestoright(self.angles) * 2000;
  var_0C = [var_09, var_0A, var_0B];
  foreach(var_0E in var_0C) {
    if(!jackalcanseelocation(var_08, var_0E)) {
      continue;
    }

    var_07 = var_0E;
    break;
  }

  var_08.var_C96C = var_07;
  thread func_5088(var_08, var_04);
  self.pers["wardenKSCount"]++;
  if(self.pers["wardenKSCount"] % 2 == 0) {
    scripts\mp\missions::func_D991("ch_warden_double");
  }
}

func_108DE(param_00, param_01, param_02, param_03, param_04) {
  var_05 = vectortoangles(param_03 - param_02);
  var_06 = "veh_mil_air_ca_dropship_mp";
  var_07 = 1;
  var_08 = "jackal_turret_mp";
  var_09 = "veh_mil_air_ca_dropship_mp_turret";
  var_0A = 1;
  var_0B = "jackal_cannon_mp";
  var_0C = "veh_mil_air_ca_dropship_turret_missile";
  var_0D = 1;
  var_0E = 250;
  var_0F = 175;
  var_10 = 3000;
  var_11 = & "KILLSTREAKS_HINTS_JACKAL_GUARD";
  var_12 = "follow_player";
  var_13 = scripts\mp\killstreak_loot::getrarityforlootitem(param_04.variantid);
  if(var_13 != "") {
    var_06 = var_06 + "_" + var_13;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_extra_flare")) {
    var_07 = var_07 + 1;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_moving_fortress")) {
    var_0B = "jackal_turret_mp";
    var_0C = "veh_mil_air_ca_dropship_mp_turret";
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_support_drop")) {
    var_12 = "guard_location";
  }

  var_14 = spawnhelicopter(param_01, param_02, var_05, "veh_jackal_mp", var_06);
  if(!isDefined(var_14)) {
    return;
  }

  var_14 thread func_8992();
  var_14.damagecallback = ::func_3758;
  var_14.getclosestpointonnavmesh3d = var_0E;
  var_14.var_1545 = var_0F;
  var_14.health = var_10;
  var_14.maxhealth = var_14.health;
  var_14.team = param_01.team;
  var_14.triggerportableradarping = param_01;
  var_14 setCanDamage(1);
  var_14.defendloc = param_03;
  var_14.lifeid = param_00;
  var_14.var_A056 = 1;
  var_14.streakinfo = param_04;
  var_14.streakname = param_04.streakname;
  var_14.evasivemaneuvers = 0;
  var_14.var_BC = var_12;
  var_14.var_4C08 = var_11;
  var_14.streakinfo = param_04;
  var_14.flaresreservecount = var_07;
  var_14.turreton = var_0A;
  var_14.turretweapon = var_08;
  var_14.cannonweapon = var_0B;
  var_14.cannonon = var_0D;
  var_14 scripts\mp\killstreaks\_utility::func_1843(param_04.streakname, "Killstreak_Air", param_01, 1);
  var_14 setmaxpitchroll(0, 90);
  var_14 vehicle_setspeed(var_14.getclosestpointonnavmesh3d, var_14.var_1545);
  var_14 sethoverparams(50, 100, 50);
  var_14 setturningability(0.05);
  var_14 givelastonteamwarning(45, 25, 25, 0.5);
  var_14 setotherent(param_01);
  var_15 = anglesToForward(var_14.angles);
  var_14.turret = spawnturret("misc_turret", var_14 gettagorigin("tag_turret"), var_08);
  var_14.turret setModel(var_09);
  var_14.turret.triggerportableradarping = param_01;
  var_14.turret.team = param_01.team;
  var_14.turret.angles = var_14.angles;
  var_14.turret.type = "Machine_Gun";
  var_14.turret.streakinfo = param_04;
  var_14.turret linkto(var_14, "tag_turret");
  var_14.turret setturretmodechangewait(0);
  var_14.turret give_player_session_tokens("manual_target");
  var_14.turret setsentryowner(param_01);
  var_14.cannon = spawnturret("misc_turret", var_14 gettagorigin("tag_origin"), var_0B);
  var_14.cannon setModel(var_0C);
  var_14.cannon.triggerportableradarping = param_01;
  var_14.cannon.team = param_01.team;
  var_14.cannon.angles = var_14.angles;
  var_14.cannon.type = "Cannon";
  var_14.cannon.streakinfo = param_04;
  var_14.cannon linkto(var_14, "tag_origin", (-300, 0, 30), (0, 0, 0));
  var_14.cannon setturretmodechangewait(0);
  var_14.cannon give_player_session_tokens("manual_target");
  var_14.cannon setsentryowner(param_01);
  var_14.useobj = spawn("script_model", var_14 gettagorigin("tag_origin"));
  var_14.useobj linkto(var_14, "tag_origin");
  level.jackals[level.jackals.size] = var_14;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.var_A22D = undefined;
  var_14 _meth_84BE("killstreak_jackal_mp");
  var_14 thread scripts\mp\killstreaks\_flares::func_6EAB(undefined, "j_body");
  var_14 thread func_A3BD();
  var_14 thread delayjackalloopsfx(0.05, "dropship_enemy_hover_world_grnd");
  var_14 thread func_50BE();
  var_14 thread scripts\mp\killstreaks\_flares::flares_monitor(var_14.flaresreservecount);
  var_14.turret.vehicle_fired_from = var_14;
  var_14.cannon.vehicle_fired_from = var_14;
  var_16 = anglesToForward(var_14.angles);
  var_14.turret.vehicle_fired_from.killcament = spawn("script_model", var_14 gettagorigin("tag_turret_front"));
  var_14.turret.vehicle_fired_from.killcament linkto(var_14, "tag_turret_front");
  var_14.cannon.vehicle_fired_from.killcament = var_14.turret.vehicle_fired_from.killcament;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_moving_fortress")) {
    var_14.cannon.vehicle_fired_from.killcament linkto(var_14, "tag_turret_rear");
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_support_drop")) {
    var_17 = -120;
    var_18 = "jackaldrop";
    var_14.dropcrates = [];
    for(var_19 = 0; var_19 < 3; var_19++) {
      var_1A = scripts\mp\killstreaks\_airdrop::getcratetypefordroptype(var_18);
      var_1B = var_14 scripts\mp\killstreaks\_airdrop::createairdropcrate(param_01, var_18, var_1A, var_14.origin);
      var_1B linkto(var_14, "tag_origin", (var_17, 0, 0), (0, 0, 0));
      var_14.dropcrates[var_14.dropcrates.size] = var_1B;
      var_17 = var_17 + 60;
    }
  }

  var_14 setscriptablepartstate("thrusters", "fly", 0);
  return var_14;
}

getnumownedjackals(param_00) {
  var_01 = 0;
  if(level.teambased) {
    foreach(var_03 in level.jackals) {
      if(var_03.team != param_00.team) {
        continue;
      }

      var_01++;
    }
  } else {
    foreach(var_03 in level.jackals) {
      if(var_03.triggerportableradarping != param_00) {
        continue;
      }

      var_01++;
    }
  }

  return var_01;
}

func_50BE() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
  self playsoundonmovingent("dropship_killstreak_flyby");
}

delayjackalloopsfx(param_00, param_01) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  self playLoopSound(param_01);
}

func_5088(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("leaving");
  param_00 setvehgoalpos(param_00.var_C96C, 1);
  param_00 playsoundonmovingent("dropship_killstreak_thrust_change");
  param_00 thread closetogoalcheck(param_00.var_C96C);
  param_00 thread monitorowner();
  if(isDefined(param_00.dropcrates)) {
    param_00 thread watchdropcratesearly(param_01);
  }

  param_00 waittill("goal");
  if(isDefined(param_01) && isDefined(param_00.dropcrates)) {
    param_00 thread func_A426();
    param_00 thread watchgameendleave();
    param_00 thread func_658F();
    param_00 thread func_6590();
    param_00 setscriptablepartstate("thrusters", "slow", 0);
    param_00 vehicle_setspeed(param_00.getclosestpointonnavmesh3d - 215, param_00.var_1545 - 160);
    param_00 jackalmovetolocation(param_01.location);
    param_00 thread dropcrates(param_00.dropcrates, param_01);
    param_00 thread watchjackalcratepickup();
    param_00 scripts\engine\utility::waittill_any_timeout_1(10, "all_crates_gone");
    param_00.var_BC = "follow_player";
  } else {
    param_00 thread func_A426();
    param_00 thread watchgameendleave();
    param_00 thread func_658F();
    param_00 thread func_6590();
  }

  param_00.useobj scripts\mp\killstreaks\_utility::func_F774(param_00.triggerportableradarping, param_00.var_4C08, 360, 360, 30000, 30000, 2);
  param_00 thread patrolfield();
  param_00 thread func_13AD6(getothermode(param_00.var_BC), param_00.var_4C08);
}

func_658F() {
  self notify("engagePrimary");
  self endon("engagePrimary");
  self endon("leaving");
  self endon("death");
  self.lastaction = undefined;
  if(scripts\mp\utility::istrue(self.turreton)) {
    for(;;) {
      var_00 = jackalgettargets();
      if(isDefined(var_00) && var_00.size > 0) {
        acquireturrettarget(var_00);
        self.turret waittill("stop_firing");
        if(self.var_BC == "follow_player") {
          thread patrolfield();
        }

        continue;
      }

      self.lastaction = "noTargetsFound";
      wait(0.05);
    }
  }
}

func_6590() {
  self notify("engageSecondary");
  self endon("engageSecondary");
  self endon("leaving");
  self endon("death");
  var_00 = weaponfiretime(self.cannonweapon);
  if(scripts\mp\utility::istrue(self.cannonon)) {
    for(;;) {
      var_01 = jackalgettargets();
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
        if(isDefined(var_01) && var_01.size > 0) {
          acquirecannontarget(var_01);
          if(isDefined(self.cannontarget)) {
            self.cannon waittill("stop_firing");
          }
        }

        wait(0.05);
        continue;
      }

      if(!isDefined(var_01) || var_01.size < 2) {
        wait(0.05);
        continue;
      }

      acquirecannontarget(var_01);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
    }
  }
}

func_7246() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.triggerportableradarping endon("disconnect");
  self notify("following_player");
  self vehicle_setspeed(self.getclosestpointonnavmesh3d - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);
  for(;;) {
    var_00 = undefined;
    if(scripts\mp\utility::istrue(self.evasivemaneuvers)) {
      var_01 = self.triggerportableradarping.origin[0];
      var_02 = self.triggerportableradarping.origin[1];
      var_03 = var_01 + randomintrange(-500, 500);
      var_04 = var_02 + randomintrange(-500, 500);
      var_05 = getcorrectheight(var_03, var_04, 350);
      var_00 = (var_03, var_04, var_05);
    } else {
      var_01 = self.triggerportableradarping.origin[0];
      var_02 = self.triggerportableradarping.origin[1];
      var_05 = getcorrectheight(var_01, var_02, 20);
      var_00 = (var_01, var_02, var_05);
    }

    self setlookatent(self.triggerportableradarping);
    self setvehgoalpos(var_00, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::waittill_any_3("goal", "begin_evasive_maneuvers");
    self getplayerkillstreakcombatmode();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

guardposition(param_00) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.triggerportableradarping endon("disconnect");
  self vehicle_setspeed(self.getclosestpointonnavmesh3d - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);
  var_01 = undefined;
  if(scripts\mp\utility::istrue(self.evasivemaneuvers)) {
    var_02 = self.triggerportableradarping.origin[0];
    var_03 = self.triggerportableradarping.origin[1];
    var_04 = var_02 + randomintrange(-500, 500);
    var_05 = var_03 + randomintrange(-500, 500);
    var_06 = getcorrectheight(var_04, var_05, 350);
    var_01 = (var_04, var_05, var_06);
  } else {
    var_02 = self.triggerportableradarping.origin[0];
    var_03 = self.triggerportableradarping.origin[1];
    var_06 = getcorrectheight(var_03, var_06, 20);
    var_01 = (var_02, var_03, var_06);
  }

  self setlookatent(self.triggerportableradarping);
  self setvehgoalpos(var_01, 1);
  self.lastaction = "following_player";
  scripts\engine\utility::waittill_any_3("goal", "begin_evasive_maneuvers");
  self getplayerkillstreakcombatmode();
}

patrolfield() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.triggerportableradarping endon("disconnect");
  self vehicle_setspeed(self.getclosestpointonnavmesh3d - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);
  for(;;) {
    var_00 = undefined;
    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isplayer(self.patroltarget) && !self.patroltarget _meth_8181("specialty_blindeye")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304) {
        jackalmovetoenemy(self.patroltarget);
      }
    } else {
      var_01 = jackalfindclosestenemy();
      if(isDefined(var_01)) {
        self.patroltarget = var_01;
        thread watchpatroltarget();
        jackalmovetoenemy(var_01);
      } else {
        self.patroltarget = undefined;
        var_02 = jackalfindfirstopenpoint();
        if(isDefined(var_02)) {
          jackalmovetolocation(var_02.origin);
        }
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

jackalfindfirstopenpoint() {
  var_00 = undefined;
  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(var_02 in level.carepackagedropnodes) {
      if(isDefined(var_02.nodeexposedtosky) && !var_02.nodeexposedtosky) {
        continue;
      }

      if(!jackalcanseelocation(self, var_02.origin)) {
        continue;
      }

      var_02.nodeexposedtosky = 0;
      var_00 = var_02;
      if(!isDefined(self.initialpatrolpoint)) {
        self.initialpatrolpoint = var_00;
      }

      break;
    }

    if(!isDefined(var_00)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(var_02 in level.carepackagedropnodes) {
          if(var_02 != self.initialpatrolpoint) {
            var_02.nodeexposedtosky = undefined;
          }
        }

        var_00 = self.initialpatrolpoint;
      }
    }
  }

  return var_00;
}

jackalcanseelocation(param_00, param_01) {
  var_02 = 0;
  var_03 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  if(scripts\common\trace::ray_trace_passed(param_00.origin, param_01, param_00, var_03)) {
    var_02 = 1;
  }

  return var_02;
}

jackalcanseeenemy(param_00) {
  var_01 = 0;
  var_02 = scripts\common\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_03 = [param_00 gettagorigin("j_head"), param_00 gettagorigin("j_mainroot"), param_00 gettagorigin("tag_origin")];
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(!scripts\common\trace::ray_trace_passed(self.origin, var_03[var_04], self, var_02)) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

jackalmovetoenemy(param_00) {
  if(isDefined(self.patroltarget)) {
    param_00 = self.patroltarget;
  }

  if(jackalcanseeenemy(param_00)) {
    self setlookatent(param_00);
  }

  var_01 = undefined;
  if(scripts\mp\utility::istrue(self.evasivemaneuvers)) {
    var_02 = param_00.origin[0];
    var_03 = param_00.origin[1];
    var_04 = var_02 + randomintrange(-500, 500);
    var_05 = var_03 + randomintrange(-500, 500);
    var_06 = getcorrectheight(var_04, var_05, 350);
    var_01 = (var_04, var_05, var_06);
  } else {
    var_02 = var_03.origin[0];
    var_03 = var_02.origin[1];
    var_06 = getcorrectheight(var_03, var_06, 20);
    var_01 = (var_02, var_03, var_06);
  }

  var_07 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_08 = scripts\common\trace::ray_trace(self.origin, var_01, level.characters, var_07);
  if(var_08["hittype"] != "hittype_none") {
    var_09 = getcorrectheight(var_08["position"][0], var_08["position"][1], 20);
    var_01 = (var_08["position"][0], var_08["position"][1], var_09);
  }

  self setvehgoalpos(var_01, 2);
  self.lastaction = "patrol";
  scripts\engine\utility::waittill_any_3("goal", "begin_evasive_maneuvers");
  self getplayerkillstreakcombatmode();
}

jackalfindclosestenemy() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(var_02.ignoreme || isDefined(var_02.triggerportableradarping) && var_02.triggerportableradarping.ignoreme) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    if(isDefined(level.teambased) && isDefined(var_02.team) && self.team == var_02.team) {
      continue;
    }

    if(var_02 _meth_8181("specialty_blindeye")) {
      continue;
    }

    if(var_02 isjackalenemyindoors()) {
      continue;
    }

    var_00[var_00.size] = var_02;
    scripts\engine\utility::waitframe();
  }

  var_04 = undefined;
  if(var_00.size > 0) {
    var_04 = sortbydistance(var_00, self.origin);
  }

  if(isDefined(var_04) && var_04.size > 0) {
    return var_04[0];
  }

  return undefined;
}

isjackalenemyindoors() {
  var_00 = 0;
  var_01 = scripts\common\trace::create_contents(0, 1, 0, 1, 1, 0);
  if(!scripts\common\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var_01)) {
    var_00 = 1;
  }

  return var_00;
}

watchpatroltarget() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.patroltarget scripts\engine\utility::waittill_any_timeout_1(5, "death", "disconnect");
  self.patroltarget = undefined;
}

jackalmovetolocation(param_00) {
  var_01 = undefined;
  if(scripts\mp\utility::istrue(self.evasivemaneuvers)) {
    var_02 = param_00[0];
    var_03 = param_00[1];
    var_04 = var_02 + randomintrange(-500, 500);
    var_05 = var_03 + randomintrange(-500, 500);
    var_06 = getcorrectheight(var_04, var_05, 350);
    var_01 = (var_04, var_05, var_06);
  } else {
    var_02 = var_03[0];
    var_03 = var_02[1];
    var_06 = getcorrectheight(var_03, var_06, 20);
    var_01 = (var_02, var_03, var_06);
  }

  self getplayerkillstreakcombatmode();
  self setvehgoalpos(var_01, 10);
  scripts\engine\utility::waittill_any_3("goal", "begin_evasive_maneuvers");
}

jackalleave() {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self getplayerkillstreakcombatmode();
  self.turret setsentryowner(undefined);
  if(isDefined(self.turrettarget) && isDefined(self.var_11576)) {
    scripts\mp\utility::outlinedisable(self.var_11576, self.turrettarget);
  }

  self vehicle_setspeed(self.getclosestpointonnavmesh3d - 215, self.var_1545 - 150);
  var_00 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_00 = var_00 + (0, 0, 1000);
  self setscriptablepartstate("thrusters", "fast", 0);
  if(!scripts\mp\utility::istrue(level.gameended)) {
    self playsoundonmovingent("dropship_killstreak_flyby");
  }

  self setvehgoalpos(var_00, 1);
  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  self setscriptablepartstate("thrusters", "fly", 0);
  var_01 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_01, 1);
  if(!scripts\mp\utility::istrue(level.gameended)) {
    self playsoundonmovingent("dropship_killstreak_flyby");
  }

  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");
  thread jackaldelete();
}

jackaldelete() {
  scripts\mp\utility::printgameaction("killstreak ended - jackal", self.triggerportableradarping);
  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(var_01 in level.carepackagedropnodes) {
    var_01.nodeexposedtosky = undefined;
  }

  self delete();
}

func_A426() {
  self endon("death");
  level endon("game_ended");
  var_00 = 60;
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_extra_flare")) {
    var_00 = var_00 - 10;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer("jackal_end", undefined, undefined, self.triggerportableradarping.origin);
  }

  thread jackalleave();
}

watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread jackalleave();
}

randomjackalmovement() {
  self notify("randomJackalMovement");
  self endon("randomJackalMovement");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  var_00 = self.defendloc;
  var_01 = getrandompoint(self.origin);
  self setvehgoalpos(var_01, 1);
  thread scripts\mp\utility::drawline(self.origin, var_01, 5, (1, 0, 1));
  self waittill("goal");
}

getrandompoint(param_00) {
  self getplayerkillstreakcombatmode();
  if(distance2dsquared(self.origin, self.triggerportableradarping.origin) > 4194304) {
    var_01 = self.triggerportableradarping.origin[0];
    var_02 = self.triggerportableradarping.origin[1];
    var_03 = getcorrectheight(var_01, var_02, 20);
    var_04 = (var_01, var_02, var_03);
    self setlookatent(self.triggerportableradarping);
    return var_04;
  }

  var_05 = self.angles[1];
  var_06 = int(var_05 - 60);
  var_07 = int(var_05 + 60);
  var_08 = randomintrange(var_06, var_07);
  var_09 = (0, var_08, 0);
  var_0A = self.origin + anglesToForward(var_09) * randomintrange(400, 800);
  var_0B = var_0A[0];
  var_0C = var_0A[1];
  var_0D = getcorrectheight(var_0B, var_0C, 20);
  var_0E = tracenewpoint(var_0B, var_0C, var_0D);
  if(var_0E != 0) {
    return var_0E;
  }

  var_0B = randomfloatrange(var_04[0] - 1200, var_04[0] + 1200);
  var_0C = randomfloatrange(var_04[1] - 1200, var_04[1] + 1200);
  var_0F = (var_0B, var_0C, var_0D);
  return var_0F;
}

getnewpoint(param_00, param_01) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  if(!isDefined(param_01)) {
    return;
  }

  var_02 = [];
  foreach(var_04 in level.players) {
    if(var_04 == self) {
      continue;
    }

    if(!level.teambased || var_04.team != self.team) {
      var_02[var_02.size] = var_04.origin;
    }
  }

  if(var_02.size > 0) {
    var_06 = averagepoint(var_02);
    var_07 = var_06[0];
    var_08 = var_06[1];
  } else {
    var_09 = level.mapcenter;
    var_0A = level.mapsize / 4;
    var_07 = randomfloatrange(var_09[0] - var_0A, var_09[0] + var_0A);
    var_08 = randomfloatrange(var_09[1] - var_0A, var_09[1] + var_0A);
  }

  var_0B = getcorrectheight(var_07, var_08, 20);
  var_0C = tracenewpoint(var_07, var_08, var_0B);
  if(var_0C != 0) {
    return var_0C;
  }

  var_07 = randomfloatrange(param_00[0] - 1200, param_00[0] + 1200);
  var_08 = randomfloatrange(param_00[1] - 1200, param_00[1] + 1200);
  var_0B = getcorrectheight(var_07, var_08, 20);
  var_0D = (var_07, var_08, var_0B);
  return var_0D;
}

getpathstart(param_00) {
  var_01 = 100;
  var_02 = 15000;
  var_03 = randomfloat(360);
  var_04 = (0, var_03, 0);
  var_05 = param_00 + anglesToForward(var_04) * -1 * var_02;
  var_05 = var_05 + (randomfloat(2) - 1 * var_01, randomfloat(2) - 1 * var_01, 0);
  return var_05;
}

getpathend() {
  var_00 = 150;
  var_01 = 15000;
  var_02 = self.angles[1];
  var_03 = (0, var_02, 0);
  var_04 = self.origin + anglesToForward(var_03) * var_01;
  return var_04;
}

fireonturrettarget(param_00) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");
  if(scripts\mp\utility::istrue(param_00) && scripts\mp\utility::isreallyalive(self.triggerportableradarping) && !isDefined(self.var_A987) || self.var_A987 + 10000 <= gettime()) {
    self.triggerportableradarping scripts\mp\utility::func_C638("jackal_fire");
    self.var_A987 = gettime();
  }

  var_01 = scripts\mp\utility::outlineenableforplayer(self.turrettarget, "orange", self.triggerportableradarping, 1, 0, "killstreak_personal");
  self.var_11576 = var_01;
  var_02 = 3;
  thread func_13A4B(self.turret, self.turrettarget, "target_timeout", var_02);
  self.turret waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "plr_killstreak_target");
  self.turret notify("start_firing");
  var_03 = weaponfiretime(self.turretweapon);
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    var_03 = var_03 + 0.13;
  }

  while(isDefined(self.turrettarget) && scripts\mp\utility::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);
  }
}

fireoncannontarget(param_00) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  var_01 = 3;
  thread func_13A4B(self.cannon, self.cannontarget, "target_cannon_timeout", var_01);
  self.cannon waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "plr_killstreak_target");
  if(!scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    thread setmissilekillcament();
  }

  self.cannon notify("start_firing");
  var_02 = weaponfiretime(self.cannonweapon);
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    var_02 = var_02 + 0.13;
    while(isDefined(self.cannontarget) && scripts\mp\utility::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
      self.cannon shootturret();
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
    }

    return;
  }

  if(isDefined(self.cannontarget) && scripts\mp\utility::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    self.cannon thread watchmissilelaunch();
    self.cannon shootturret();
  }
}

watchmissilelaunch() {
  self endon("death");
  self waittill("missile_fire", var_00);
  var_00.streakinfo = self.streakinfo;
}

setmissilekillcament() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self.cannon waittill("missile_fire", var_00);
  var_00.vehicle_fired_from = self;
  var_00.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

func_13A4B(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("leaving");
  param_00 endon("stop_firing");
  var_04 = self.var_11576;
  var_05 = param_01 scripts\engine\utility::waittill_any_timeout_1(param_03, "death", "disconnect");
  if(var_05 == "timeout") {
    self notify(param_02);
  }

  if(param_00.type == "Machine_Gun") {
    if(isDefined(var_04) && isDefined(param_01)) {
      scripts\mp\utility::outlinedisable(var_04, param_01);
    }

    self getplayerkillstreakcombatmode();
  }

  param_00 cleartargetentity();
  param_00 notify("stop_firing");
}

isreadytofire(param_00) {
  self endon("death");
  self endon("leaving");
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  var_01 = anglesToForward(self.angles);
  var_02 = self.turrettarget.origin - self.origin;
  var_01 = var_01 * (1, 1, 0);
  var_02 = var_02 * (1, 1, 0);
  var_02 = vectornormalize(var_02);
  var_01 = vectornormalize(var_01);
  var_03 = vectordot(var_02, var_01);
  var_04 = cos(param_00);
  if(var_03 >= var_04) {
    return 1;
  }

  return 0;
}

acquireturrettarget(param_00) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");
  if(isDefined(self.outlinedent) && isDefined(self.turrettarget)) {
    scripts\mp\utility::outlinedisable(self.outlinedent, self.turrettarget);
  }

  if(param_00.size == 1) {
    self.turrettarget = param_00[0];
  } else {
    self.turrettarget = getbesttarget(param_00);
  }

  if(isDefined(self.turrettarget)) {
    self getplayerkillstreakcombatmode();
    self setlookatent(self.turrettarget);
    self.turret settargetentity(self.turrettarget);
    self.lastaction = "attackTarget";
    thread fireonturrettarget(1);
  }
}

acquirecannontarget(param_00) {
  self endon("death");
  self endon("leaving");
  self.cannontarget = getbesttarget(param_00);
  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
  }
}

jackalgettargets() {
  self endon("death");
  self endon("leaving");
  var_00 = [];
  var_01 = level.players;
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(istarget(var_03)) {
      if(isDefined(var_01[var_02])) {
        var_00[var_00.size] = var_01[var_02];
      }
    } else {
      continue;
    }

    wait(0.05);
  }

  return var_00;
}

istarget(param_00) {
  self endon("death");
  if(!isalive(param_00) || param_00.sessionstate != "playing") {
    return 0;
  }

  if(isDefined(self.triggerportableradarping) && param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(!isDefined(param_00.pers["team"])) {
    return 0;
  }

  if(level.teambased && param_00.pers["team"] == self.team) {
    return 0;
  }

  if(param_00.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5) {
    return 0;
  }

  if(param_00 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distance2dsquared(self.origin, param_00.origin) > 4194304) {
    return 0;
  }

  var_01 = (0, 0, 35);
  var_02 = param_00.origin + rotatevector(var_01, param_00 getworldupreferenceangles());
  var_03 = [self];
  var_04 = scripts\common\trace::ray_trace(self.origin, var_02, var_03, undefined, 1);
  if(!isDefined(var_04["entity"])) {
    return 0;
  }

  return 1;
}

getbesttarget(param_00) {
  self endon("death");
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in param_00) {
    if(isDefined(self.turrettarget) && self.turrettarget == var_04) {
      continue;
    }

    var_05 = abs(vectortoangles(var_04.origin - self.origin)[1]);
    var_06 = abs(self gettagangles("tag_origin")[1]);
    var_05 = abs(var_05 - var_06);
    var_07 = var_04 getweaponslistitems();
    foreach(var_09 in var_07) {
      if(issubstr(var_09, "chargeshot") || issubstr(var_09, "lockon")) {
        var_05 = var_05 - 40;
      }
    }

    if(distance(self.origin, var_04.origin) > 4000) {
      var_05 = var_05 + 40;
    }

    if(!isDefined(var_01)) {
      var_01 = var_05;
      var_02 = var_04;
      continue;
    }

    if(var_01 > var_05) {
      var_01 = var_05;
      var_02 = var_04;
    }
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    if(!isDefined(var_02) && isDefined(self.turrettarget)) {
      var_02 = self.turrettarget;
    }
  }

  return var_02;
}

func_8992() {
  self endon("death");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if((var_09 == "aamissile_projectile_mp" || var_09 == "nuke_mp") && var_04 == "MOD_EXPLOSIVE" && var_00 >= self.health) {
      func_3758(var_01, var_01, 9001, 0, var_04, var_09, var_03, var_02, var_03, 0, 0, var_07);
    }
  }
}

func_3758(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(param_01)) {
    if(isDefined(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
    }
  }

  if((param_01 == self || isDefined(param_01.pers) && param_01.pers["team"] == self.team && !level.friendlyfire && level.teambased) && param_01 != self.triggerportableradarping) {
    return;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_01)) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  param_02 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(param_01, param_05, param_04, param_02, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\_killstreaks::killstreakhit(param_01, param_05, self, param_04);
  param_01 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, param_02, param_01, param_07, param_06, param_04, param_0A, undefined, param_0B, param_03, param_05);
  if(self.health <= param_02) {
    if(isplayer(param_01) && !isDefined(self.triggerportableradarping) || param_01 != self.triggerportableradarping) {
      var_0C = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
      var_0D = "callout_destroyed_harrier";
      if(var_0C != "") {
        var_0D = var_0D + "_" + var_0C;
      }

      scripts\mp\damage::onkillstreakkilled("jackal", param_01, param_05, param_04, param_02, "destroyed_jackal", "jackal_destroyed", var_0D);
    }
  }

  if(self.health - param_02 <= 900 && !isDefined(self.var_1037E) || !self.var_1037E) {
    self.var_1037E = 1;
  }

  self vehicle_finishdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

getcorrectheight(param_00, param_01, param_02) {
  var_03 = 600;
  var_04 = tracegroundpoint(param_00, param_01);
  var_05 = var_04 + var_03;
  var_05 = var_05 + randomint(param_02);
  return var_05;
}

playdamageefx() {
  self endon("death");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.15);
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left2");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right2");
  playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
}

func_A3BD() {
  self endon("jackal_gone");
  var_00 = self.triggerportableradarping;
  self waittill("death");
  if(isDefined(self.turrettarget) && isDefined(self.var_11576)) {
    scripts\mp\utility::outlinedisable(self.var_11576, self.turrettarget);
  }

  if(!isDefined(self)) {
    return;
  }

  self.triggerportableradarping scripts\mp\utility::clearlowermessage(getothermode(self.var_BC));
  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread func_A3B8(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  jackalexplode();
}

jackalexplode() {
  self playSound("dropship_explode_mp");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("explode");
  playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "j_body");
  wait(0.35);
  thread jackaldelete();
}

func_A3B8(param_00) {
  self endon("explode");
  self getplayerkillstreakcombatmode();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  self setscriptablepartstate("engine", "explode", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self givelastonteamwarning(param_00, param_00, param_00);
  self settargetyaw(self.angles[1] + param_00 * 2.5);
}

tracenewpoint(param_00, param_01, param_02) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_03 = scripts\common\trace::sphere_trace(self.origin, (param_00, param_01, param_02), 256, self, undefined, 1);
  if(var_03["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_04 = (param_00, param_01, param_02);
  return var_04;
}

tracegroundpoint(param_00, param_01) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_02 = -99999;
  var_03 = self.origin[2] + 2000;
  var_04 = level.averagealliesz;
  var_05 = [self];
  if(isDefined(self.dropcrates)) {
    foreach(var_07 in self.dropcrates) {
      var_05[var_05.size] = var_07;
    }
  }

  var_09 = scripts\common\trace::sphere_trace((param_00, param_01, var_03), (param_00, param_01, var_02), 256, var_05, undefined, 1);
  if(var_09["position"][2] < var_04) {
    var_0A = var_04;
  } else {
    var_0A = var_0A["position"][2];
  }

  return var_0A;
}

closetogoalcheck(param_00) {
  self endon("goal");
  self endon("death");
  for(;;) {
    if(distance2d(self.origin, param_00) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait(0.05);
  }
}

monitorowner() {
  self endon("death");
  self endon("leaving");
  if(!isDefined(self.triggerportableradarping) || self.triggerportableradarping.team != self.team) {
    thread jackalexplode();
    return;
  }

  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "disconnect");
  jackalexplode();
}

func_13AD6(param_00, param_01) {
  self.triggerportableradarping endon("disconnect");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  for(;;) {
    self.useobj waittill("trigger", var_02);
    if(var_02 != self.triggerportableradarping) {
      continue;
    }

    if(self.triggerportableradarping scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(isDefined(self.triggerportableradarping.disabledusability) && self.triggerportableradarping.disabledusability > 0) {
      continue;
    }

    if(scripts\mp\utility::func_9FAE(self.triggerportableradarping)) {
      continue;
    }

    var_03 = 0;
    while(self.triggerportableradarping usebuttonpressed()) {
      var_03 = var_03 + 0.05;
      if(var_03 > 0.1) {
        var_04 = getothermode(self.var_BC);
        if(var_04 == "guard_location") {
          var_05 = self.triggerportableradarping.origin[0];
          var_06 = self.triggerportableradarping.origin[1];
          var_07 = self.origin[2];
          var_08 = (var_05, var_06, var_07);
          var_09 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
          if(!scripts\common\trace::ray_trace_passed(self.origin, var_08, self, var_09)) {
            self.triggerportableradarping scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CANNOT_BE_CALLED");
            break;
          }
        }

        self.var_BC = var_04;
        self notify(self.var_BC);
        if(self.var_BC == "guard_location") {
          param_00 = "follow_player";
          param_01 = & "KILLSTREAKS_HINTS_JACKAL_FOLLOW";
          self.triggerportableradarping scripts\mp\utility::func_C638("jackal_guard");
          self.triggerportableradarping playlocalsound("mp_killstreak_warden_switch_mode");
          thread dropship_change_thrust_sfx();
          thread guardposition(self.triggerportableradarping.origin);
        } else {
          param_00 = "guard_location";
          param_01 = & "KILLSTREAKS_HINTS_JACKAL_GUARD";
          self.triggerportableradarping playlocalsound("mp_killstreak_warden_switch_mode");
          thread patrolfield();
          thread dropship_change_thrust_sfx();
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.var_4C08 = param_01;
        self.useobj scripts\mp\killstreaks\_utility::func_F774(self.triggerportableradarping, self.var_4C08, 360, 360, 30000, 30000, 2);
        break;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

dropship_change_thrust_sfx() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self playsoundonmovingent("dropship_killstreak_thrust_change");
}

getothermode(param_00) {
  if(param_00 == "follow_player") {
    param_00 = "guard_location";
  } else {
    param_00 = "follow_player";
  }

  return param_00;
}

looptriggeredeffect(param_00, param_01) {
  level endon("game_ended");
  for(;;) {
    triggerfx(param_00);
    wait(0.05);
    if(!isDefined(param_01) || !isDefined(param_00)) {
      break;
    }
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

attacklasedtarget(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  var_04 = 6000;
  var_05 = (0, 0, var_04);
  var_06 = 3000;
  var_07 = anglesToForward(self.angles);
  var_08 = self.origin;
  var_09 = var_08 + var_05 + var_07 * var_06 * -1;
  var_0A = [self];
  var_0B = 0;
  var_0C = scripts\common\trace::ray_trace(param_00 + (0, 0, var_04), param_00);
  if(var_0C["fraction"] > 0.99) {
    var_0B = 1;
    var_09 = param_00 + (0, 0, var_04);
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (300, 0, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (300, 0, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (0, 300, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (0, 300, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (0, -300, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (0, -300, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (300, 300, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (300, 300, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (-300, 0, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (-300, 0, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (-300, -300, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (-300, -300, var_04);
    }
  }

  if(!var_0B) {
    var_0C = scripts\common\trace::ray_trace(param_00 + (300, -300, var_04), param_00);
    if(var_0C["fraction"] > 0.99) {
      var_0B = 1;
      var_09 = param_00 + (300, -300, var_04);
    }
  }

  if(!var_0B) {
    for(var_0D = 0; var_0D < 5; var_0D++) {
      var_04 = var_04 / 2;
      var_05 = (0, 0, var_04);
      var_09 = var_08 + var_05 + var_07 * var_06 * -1;
      var_0E = scripts\common\trace::ray_trace(param_00, var_09, var_0A);
      if(var_0E["fraction"] > 0.99) {
        var_0B = 1;
        break;
      }

      wait(0.05);
    }
  }

  if(!var_0B) {
    for(var_0D = 0; var_0D < 5; var_0D++) {
      var_04 = var_04 * 2.5;
      var_05 = (0, 0, var_04);
      var_09 = var_08 + var_05 + var_07 * var_06 * -1;
      var_0E = scripts\common\trace::ray_trace(param_00, var_09, var_0A);
      if(var_0E["fraction"] > 0.99) {
        var_0B = 1;
        break;
      }

      wait(0.05);
    }
  }
}

playlocksound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }

  scripts\engine\utility::play_loopsound_in_space("javelin_clu_lock", self.origin);
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoploopsound("javelin_clu_lock");
  self.playinglocksound = 0;
}

playlockerrorsound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }

  self playlocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoplocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 0;
}

beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  var_00 = scripts\engine\utility::waittill_any_timeout_1(3, "death");
  if(var_00 == "timeout") {
    self.evasivemaneuvers = 0;
  }
}

func_13A9C() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");
  for(;;) {
    var_00 = undefined;
    if(scripts\mp\utility::istrue(self.evasivemaneuvers)) {
      var_01 = self.triggerportableradarping.origin[0];
      var_02 = self.triggerportableradarping.origin[1];
      var_03 = var_01 + randomintrange(-500, 500);
      var_04 = var_02 + randomintrange(-500, 500);
      var_05 = getcorrectheight(var_03, var_04, 350);
      var_00 = (var_03, var_04, var_05);
    }

    if(isDefined(var_00)) {
      self setvehgoalpos(var_00, 1);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

watchdropcratesearly(param_00) {
  self endon("dropped_crates");
  var_01 = self.dropcrates;
  self waittill("death");
  thread dropcrates(var_01, param_00);
}

dropcrates(param_00, param_01) {
  var_02 = (0, 0, 0);
  var_03 = 1200;
  foreach(var_06, var_05 in param_00) {
    var_05 unlink();
    var_05 physicslaunchserver((0, 0, 0), var_02, var_03);
    var_05 thread scripts\mp\killstreaks\_airdrop::physicswaiter(var_05.droptype, var_05.cratetype, var_02, var_03);
    var_05 thread scripts\mp\killstreaks\_airdrop::killplayerfromcrate_fastvelocitypush();
    var_05.unresolved_collision_func = ::scripts\mp\killstreaks\_airdrop::killplayerfromcrate_dodamage;
    var_05 thread scripts\mp\killstreaks\_airdrop::handlenavobstacle();
    var_05 thread watchforcapture(self, var_06);
    wait(0.1);
  }

  if(isDefined(param_01.var_1349C)) {
    param_01.var_1349C delete();
  }

  self notify("dropped_crates");
}

watchforcapture(param_00, param_01) {
  scripts\engine\utility::waittill_any_3("captured", "death");
  param_00 notify("crate_captured_" + param_01);
}

watchjackalcratepickup() {
  self endon("death");
  self endon("leaving");
  var_00 = 0;
  for(;;) {
    scripts\engine\utility::waittill_any_3("crate_captured_0", "crate_captured_1", "crate_captured_2");
    var_00++;
    if(var_00 == self.dropcrates.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}