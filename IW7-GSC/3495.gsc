/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3495.gsc
***************************************/

func_2A6B(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_support_drop")) {
    var_4 = scripts\mp\killstreaks\target_marker::_meth_819B(var_3);

    if(!isDefined(var_4.location)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level.var_A22D) || level.jackals.size > 0) {
      if(isDefined(var_4.var_1349C)) {
        var_4.var_1349C delete();
      }

      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

      if(isDefined(var_3.weapon) && var_3.weapon != "none") {
        self notify("killstreak_finished_with_weapon_" + var_3.weapon);
      }

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level.var_A22D = 1;
  var_5 = getent("airstrikeheight", "targetname");

  if(isDefined(var_5)) {
    var_6 = var_5.origin[2] + 100;
  } else if(isDefined(level.airstrikeheightscale)) {
    var_6 = 850 * level.airstrikeheightscale;
  } else {
    var_6 = 850;
  }

  if(isDefined(var_4) && isDefined(var_4.location)) {
    var_2 = var_4.location;
  }

  var_2 = var_2 * (1, 1, 0);
  var_7 = var_2 + (0, 0, var_6);
  var_8 = func_108DE(var_0, self, var_1, var_7, var_3);
  var_9 = var_7;
  var_10 = var_7 + anglestoright(self.angles) * 2000;
  var_11 = var_7 - anglestoright(self.angles) * 2000;
  var_12 = [var_9, var_10, var_11];

  foreach(var_14 in var_12) {
    if(!jackalcanseelocation(var_8, var_14)) {
      continue;
    }
    var_7 = var_14;
    break;
  }

  var_8.var_C96C = var_7;
  thread func_5088(var_8, var_4);
  self.pers["wardenKSCount"]++;

  if(self.pers["wardenKSCount"] % 2 == 0) {
    scripts\mp\missions::func_D991("ch_warden_double");
  }
}

func_108DE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vectortoangles(var_3 - var_2);
  var_6 = "veh_mil_air_ca_dropship_mp";
  var_7 = 1;
  var_8 = "jackal_turret_mp";
  var_9 = "veh_mil_air_ca_dropship_mp_turret";
  var_10 = 1;
  var_11 = "jackal_cannon_mp";
  var_12 = "veh_mil_air_ca_dropship_turret_missile";
  var_13 = 1;
  var_14 = 250;
  var_15 = 175;
  var_16 = 3000;
  var_17 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
  var_18 = "follow_player";
  var_19 = scripts\mp\killstreak_loot::getrarityforlootitem(var_4.variantid);

  if(var_19 != "") {
    var_6 = var_6 + "_" + var_19;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_extra_flare")) {
    var_7 = var_7 + 1;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_moving_fortress")) {
    var_11 = "jackal_turret_mp";
    var_12 = "veh_mil_air_ca_dropship_mp_turret";
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_support_drop")) {
    var_18 = "guard_location";
  }

  var_20 = spawnhelicopter(var_1, var_2, var_5, "veh_jackal_mp", var_6);

  if(!isDefined(var_20)) {
    return;
  }
  var_20 thread func_8992();
  var_20.damagecallback = ::func_3758;
  var_20.speed = var_14;
  var_20.var_1545 = var_15;
  var_20.health = var_16;
  var_20.maxhealth = var_20.health;
  var_20.team = var_1.team;
  var_20.owner = var_1;
  var_20 setCanDamage(1);
  var_20.defendloc = var_3;
  var_20.lifeid = var_0;
  var_20.var_A056 = 1;
  var_20.streakinfo = var_4;
  var_20.streakname = var_4.streakname;
  var_20.evasivemaneuvers = 0;
  var_20.combatmode = var_18;
  var_20.var_4C08 = var_17;
  var_20.streakinfo = var_4;
  var_20.flaresreservecount = var_7;
  var_20.turreton = var_10;
  var_20.turretweapon = var_8;
  var_20.cannonweapon = var_11;
  var_20.cannonon = var_13;
  var_20 scripts\mp\killstreaks\utility::func_1843(var_4.streakname, "Killstreak_Air", var_1, 1);
  var_20 setmaxpitchroll(0, 90);
  var_20 vehicle_setspeed(var_20.speed, var_20.var_1545);
  var_20 sethoverparams(50, 100, 50);
  var_20 setturningability(0.05);
  var_20 setyawspeed(45, 25, 25, 0.5);
  var_20 setotherent(var_1);
  var_21 = anglesToForward(var_20.angles);
  var_20.turret = spawnturret("misc_turret", var_20 gettagorigin("tag_turret"), var_8);
  var_20.turret setModel(var_9);
  var_20.turret.owner = var_1;
  var_20.turret.team = var_1.team;
  var_20.turret.angles = var_20.angles;
  var_20.turret.type = "Machine_Gun";
  var_20.turret.streakinfo = var_4;
  var_20.turret linkto(var_20, "tag_turret");
  var_20.turret setturretmodechangewait(0);
  var_20.turret give_player_session_tokens("manual_target");
  var_20.turret setsentryowner(var_1);
  var_20.cannon = spawnturret("misc_turret", var_20 gettagorigin("tag_origin"), var_11);
  var_20.cannon setModel(var_12);
  var_20.cannon.owner = var_1;
  var_20.cannon.team = var_1.team;
  var_20.cannon.angles = var_20.angles;
  var_20.cannon.type = "Cannon";
  var_20.cannon.streakinfo = var_4;
  var_20.cannon linkto(var_20, "tag_origin", (-300, 0, 30), (0, 0, 0));
  var_20.cannon setturretmodechangewait(0);
  var_20.cannon give_player_session_tokens("manual_target");
  var_20.cannon setsentryowner(var_1);
  var_20.useobj = spawn("script_model", var_20 gettagorigin("tag_origin"));
  var_20.useobj linkto(var_20, "tag_origin");
  level.jackals[level.jackals.size] = var_20;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.var_A22D = undefined;
  var_20 _meth_84BE("killstreak_jackal_mp");
  var_20 thread scripts\mp\killstreaks\flares::func_6EAB(undefined, "j_body");
  var_20 thread func_A3BD();
  var_20 thread delayjackalloopsfx(0.05, "dropship_enemy_hover_world_grnd");
  var_20 thread func_50BE();
  var_20 thread scripts\mp\killstreaks\flares::flares_monitor(var_20.flaresreservecount);
  var_20.turret.vehicle_fired_from = var_20;
  var_20.cannon.vehicle_fired_from = var_20;
  var_22 = anglesToForward(var_20.angles);
  var_20.turret.vehicle_fired_from.killcament = spawn("script_model", var_20 gettagorigin("tag_turret_front"));
  var_20.turret.vehicle_fired_from.killcament linkto(var_20, "tag_turret_front");
  var_20.cannon.vehicle_fired_from.killcament = var_20.turret.vehicle_fired_from.killcament;

  if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_moving_fortress")) {
    var_20.cannon.vehicle_fired_from.killcament linkto(var_20, "tag_turret_rear");
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_support_drop")) {
    var_23 = -120;
    var_24 = "jackaldrop";
    var_20.dropcrates = [];

    for(var_25 = 0; var_25 < 3; var_25++) {
      var_26 = scripts\mp\killstreaks\airdrop::getcratetypefordroptype(var_24);
      var_27 = var_20 scripts\mp\killstreaks\airdrop::createairdropcrate(var_1, var_24, var_26, var_20.origin);
      var_27 linkto(var_20, "tag_origin", (var_23, 0, 0), (0, 0, 0));
      var_20.dropcrates[var_20.dropcrates.size] = var_27;
      var_23 = var_23 + 60;
    }
  }

  var_20 setscriptablepartstate("thrusters", "fly", 0);
  return var_20;
}

getnumownedjackals(var_0) {
  var_1 = 0;

  if(level.teambased) {
    foreach(var_3 in level.jackals) {
      if(var_3.team != var_0.team) {
        continue;
      }
      var_1++;
    }
  } else {
    foreach(var_3 in level.jackals) {
      if(var_3.owner != var_0) {
        continue;
      }
      var_1++;
    }
  }

  return var_1;
}

func_50BE() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
  self playsoundonmovingent("dropship_killstreak_flyby");
}

delayjackalloopsfx(var_0, var_1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

func_5088(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0.var_C96C, 1);
  var_0 playsoundonmovingent("dropship_killstreak_thrust_change");
  var_0 thread closetogoalcheck(var_0.var_C96C);
  var_0 thread monitorowner();

  if(isDefined(var_0.dropcrates)) {
    var_0 thread watchdropcratesearly(var_1);
  }

  var_0 waittill("goal");

  if(isDefined(var_1) && isDefined(var_0.dropcrates)) {
    var_0 thread func_A426();
    var_0 thread watchgameendleave();
    var_0 thread func_658F();
    var_0 thread func_6590();
    var_0 setscriptablepartstate("thrusters", "slow", 0);
    var_0 vehicle_setspeed(var_0.speed - 215, var_0.var_1545 - 160);
    var_0 jackalmovetolocation(var_1.location);
    var_0 thread dropcrates(var_0.dropcrates, var_1);
    var_0 thread watchjackalcratepickup();
    var_0 scripts\engine\utility::waittill_any_timeout(10, "all_crates_gone");
    var_0.combatmode = "follow_player";
  } else {
    var_0 thread func_A426();
    var_0 thread watchgameendleave();
    var_0 thread func_658F();
    var_0 thread func_6590();
  }

  var_0.useobj scripts\mp\killstreaks\utility::func_F774(var_0.owner, var_0.var_4C08, 360, 360, 30000, 30000, 2);
  var_0 thread patrolfield();
  var_0 thread func_13AD6(getothermode(var_0.combatmode), var_0.var_4C08);
}

func_658F() {
  self notify("engagePrimary");
  self endon("engagePrimary");
  self endon("leaving");
  self endon("death");
  self.lastaction = undefined;

  if(scripts\mp\utility\game::istrue(self.turreton)) {
    for(;;) {
      var_0 = jackalgettargets();

      if(isDefined(var_0) && var_0.size > 0) {
        acquireturrettarget(var_0);
        self.turret waittill("stop_firing");

        if(self.combatmode == "follow_player") {
          thread patrolfield();
        }
      } else
        self.lastaction = "noTargetsFound";

      wait 0.05;
    }
  }
}

func_6590() {
  self notify("engageSecondary");
  self endon("engageSecondary");
  self endon("leaving");
  self endon("death");
  var_0 = weaponfiretime(self.cannonweapon);

  if(scripts\mp\utility\game::istrue(self.cannonon)) {
    for(;;) {
      var_1 = jackalgettargets();

      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
        if(isDefined(var_1) && var_1.size > 0) {
          acquirecannontarget(var_1);

          if(isDefined(self.cannontarget)) {
            self.cannon waittill("stop_firing");
          }
        }

        wait 0.05;
        continue;
      }

      if(!isDefined(var_1) || var_1.size < 2) {
        wait 0.05;
        continue;
      }

      acquirecannontarget(var_1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    }
  }
}

func_7246() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self notify("following_player");
  self vehicle_setspeed(self.speed - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);

  for(;;) {
    var_0 = undefined;

    if(scripts\mp\utility\game::istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    } else {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_5 = getcorrectheight(var_1, var_2, 20);
      var_0 = (var_1, var_2, var_5);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(var_0, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::waittill_any("goal", "begin_evasive_maneuvers");
    self getplayerkillstreakcombatmode();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

guardposition(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(self.speed - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);
  var_1 = undefined;

  if(scripts\mp\utility\game::istrue(self.evasivemaneuvers)) {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_6 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_6);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(var_1, 1);
  self.lastaction = "following_player";
  scripts\engine\utility::waittill_any("goal", "begin_evasive_maneuvers");
  self getplayerkillstreakcombatmode();
}

patrolfield() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(self.speed - 215, self.var_1545 - 160);
  self setscriptablepartstate("thrusters", "slow", 0);

  for(;;) {
    var_0 = undefined;

    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isplayer(self.patroltarget) && !self.patroltarget _meth_8181("specialty_blindeye")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304) {
        jackalmovetoenemy(self.patroltarget);
      }
    } else {
      var_1 = jackalfindclosestenemy();

      if(isDefined(var_1)) {
        self.patroltarget = var_1;
        thread watchpatroltarget();
        jackalmovetoenemy(var_1);
      } else {
        self.patroltarget = undefined;
        var_2 = jackalfindfirstopenpoint();

        if(isDefined(var_2)) {
          jackalmovetolocation(var_2.origin);
        }
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

jackalfindfirstopenpoint() {
  var_0 = undefined;

  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(var_2 in level.carepackagedropnodes) {
      if(isDefined(var_2.free) && !var_2.free) {
        continue;
      }
      if(!jackalcanseelocation(self, var_2.origin)) {
        continue;
      }
      var_2.free = 0;
      var_0 = var_2;

      if(!isDefined(self.initialpatrolpoint)) {
        self.initialpatrolpoint = var_0;
      }

      break;
    }

    if(!isDefined(var_0)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(var_2 in level.carepackagedropnodes) {
          if(var_2 != self.initialpatrolpoint) {
            var_2.free = undefined;
          }
        }

        var_0 = self.initialpatrolpoint;
      }
    }
  }

  return var_0;
}

jackalcanseelocation(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1, var_0, var_3)) {
    var_2 = 1;
  }

  return var_2;
}

jackalcanseeenemy(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

jackalmovetoenemy(var_0) {
  if(isDefined(self.patroltarget)) {
    var_0 = self.patroltarget;
  }

  if(jackalcanseeenemy(var_0)) {
    self setlookatent(var_0);
  }

  var_1 = undefined;

  if(scripts\mp\utility\game::istrue(self.evasivemaneuvers)) {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_6 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_6);
  }

  var_7 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_8 = scripts\engine\trace::ray_trace(self.origin, var_1, level.characters, var_7);

  if(var_8["hittype"] != "hittype_none") {
    var_9 = getcorrectheight(var_8["position"][0], var_8["position"][1], 20);
    var_1 = (var_8["position"][0], var_8["position"][1], var_9);
  }

  self setvehgoalpos(var_1, 2);
  self.lastaction = "patrol";
  scripts\engine\utility::waittill_any("goal", "begin_evasive_maneuvers");
  self getplayerkillstreakcombatmode();
}

jackalfindclosestenemy() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level.teambased) && isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }
    if(var_2 _meth_8181("specialty_blindeye")) {
      continue;
    }
    if(var_2 isjackalenemyindoors()) {
      continue;
    }
    var_0[var_0.size] = var_2;
    scripts\engine\utility::waitframe();
  }

  var_4 = undefined;

  if(var_0.size > 0) {
    var_4 = sortbydistance(var_0, self.origin);
  }

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0];
  }

  return undefined;
}

isjackalenemyindoors() {
  var_0 = 0;
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var_1)) {
    var_0 = 1;
  }

  return var_0;
}

watchpatroltarget() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  var_0 = self.patroltarget scripts\engine\utility::waittill_any_timeout(5, "death", "disconnect");
  self.patroltarget = undefined;
}

jackalmovetolocation(var_0) {
  var_1 = undefined;

  if(scripts\mp\utility\game::istrue(self.evasivemaneuvers)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_6 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_6);
  }

  self getplayerkillstreakcombatmode();
  self setvehgoalpos(var_1, 10);
  scripts\engine\utility::waittill_any("goal", "begin_evasive_maneuvers");
}

jackalleave() {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self getplayerkillstreakcombatmode();
  self.turret setsentryowner(undefined);

  if(isDefined(self.turrettarget) && isDefined(self.var_11576)) {
    scripts\mp\utility\game::outlinedisable(self.var_11576, self.turrettarget);
  }

  self vehicle_setspeed(self.speed - 215, self.var_1545 - 150);
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 = var_0 + (0, 0, 1000);
  self setscriptablepartstate("thrusters", "fast", 0);

  if(!scripts\mp\utility\game::istrue(level.gameended)) {
    self playsoundonmovingent("dropship_killstreak_flyby");
  }

  self setvehgoalpos(var_0, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  self setscriptablepartstate("thrusters", "fly", 0);
  var_1 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_1, 1);

  if(!scripts\mp\utility\game::istrue(level.gameended)) {
    self playsoundonmovingent("dropship_killstreak_flyby");
  }

  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");
  thread jackaldelete();
}

jackaldelete() {
  scripts\mp\utility\game::printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(var_1 in level.carepackagedropnodes) {
    var_1.free = undefined;
  }

  self delete();
}

func_A426() {
  self endon("death");
  level endon("game_ended");
  var_0 = 60;

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_extra_flare")) {
    var_0 = var_0 - 10;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility\game::playkillstreakdialogonplayer("jackal_end", undefined, undefined, self.owner.origin);
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
  var_0 = self.defendloc;
  var_1 = getrandompoint(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\mp\utility\game::drawline(self.origin, var_1, 5, (1, 0, 1));
  self waittill("goal");
}

getrandompoint(var_0) {
  self getplayerkillstreakcombatmode();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = getcorrectheight(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  } else {
    var_5 = self.angles[1];
    var_6 = int(var_5 - 60);
    var_7 = int(var_5 + 60);
    var_8 = randomintrange(var_6, var_7);
    var_9 = (0, var_8, 0);
    var_10 = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_13 = getcorrectheight(var_11, var_12, 20);
    var_14 = tracenewpoint(var_11, var_12, var_13);

    if(var_14 != 0) {
      return var_14;
    }

    var_11 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_12 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_15 = (var_11, var_12, var_13);
    return var_15;
  }
}

getnewpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(!level.teambased || var_4.team != self.team) {
      var_2[var_2.size] = var_4.origin;
    }
  }

  if(var_2.size > 0) {
    var_6 = averagepoint(var_2);
    var_7 = var_6[0];
    var_8 = var_6[1];
  } else {
    var_9 = level.mapcenter;
    var_10 = level.mapsize / 4;
    var_7 = randomfloatrange(var_9[0] - var_10, var_9[0] + var_10);
    var_8 = randomfloatrange(var_9[1] - var_10, var_9[1] + var_10);
  }

  var_11 = getcorrectheight(var_7, var_8, 20);
  var_12 = tracenewpoint(var_7, var_8, var_11);

  if(var_12 != 0) {
    return var_12;
  }

  var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
  var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
  var_11 = getcorrectheight(var_7, var_8, 20);
  var_13 = (var_7, var_8, var_11);
  return var_13;
}

getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_2);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

fireonturrettarget(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");

  if(scripts\mp\utility\game::istrue(var_0) && scripts\mp\utility\game::isreallyalive(self.owner) && (!isDefined(self.var_A987) || self.var_A987 + 10000 <= gettime())) {
    self.owner scripts\mp\utility\game::func_C638("jackal_fire");
    self.var_A987 = gettime();
  }

  var_1 = scripts\mp\utility\game::outlineenableforplayer(self.turrettarget, "orange", self.owner, 1, 0, "killstreak_personal");
  self.var_11576 = var_1;
  var_2 = 3;
  thread func_13A4B(self.turret, self.turrettarget, "target_timeout", var_2);
  self.turret waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "plr_killstreak_target");
  self.turret notify("start_firing");
  var_3 = weaponfiretime(self.turretweapon);

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    var_3 = var_3 + 0.13;
  }

  while(isDefined(self.turrettarget) && scripts\mp\utility\game::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }
}

fireoncannontarget(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  var_1 = 3;
  thread func_13A4B(self.cannon, self.cannontarget, "target_cannon_timeout", var_1);
  self.cannon waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "plr_killstreak_target");

  if(!scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    thread setmissilekillcament();
  }

  self.cannon notify("start_firing");
  var_2 = weaponfiretime(self.cannonweapon);

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    var_2 = var_2 + 0.13;

    while(isDefined(self.cannontarget) && scripts\mp\utility\game::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
      self.cannon shootturret();
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
    }
  } else if(isDefined(self.cannontarget) && scripts\mp\utility\game::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    self.cannon thread watchmissilelaunch();
    self.cannon shootturret();
  }
}

watchmissilelaunch() {
  self endon("death");
  self waittill("missile_fire", var_0);
  var_0.streakinfo = self.streakinfo;
}

setmissilekillcament() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self.cannon waittill("missile_fire", var_0);
  var_0.vehicle_fired_from = self;
  var_0.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

func_13A4B(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");
  var_0 endon("stop_firing");
  var_4 = self.var_11576;
  var_5 = var_1 scripts\engine\utility::waittill_any_timeout(var_3, "death", "disconnect");

  if(var_5 == "timeout") {
    self notify(var_2);
  }

  if(var_0.type == "Machine_Gun") {
    if(isDefined(var_4) && isDefined(var_1)) {
      scripts\mp\utility\game::outlinedisable(var_4, var_1);
    }

    self getplayerkillstreakcombatmode();
  }

  var_0 cleartargetentity();
  var_0 notify("stop_firing");
}

isreadytofire(var_0) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.turrettarget.origin - self.origin;
  var_1 = var_1 * (1, 1, 0);
  var_2 = var_2 * (1, 1, 0);
  var_2 = vectornormalize(var_2);
  var_1 = vectornormalize(var_1);
  var_3 = vectordot(var_2, var_1);
  var_4 = cos(var_0);

  if(var_3 >= var_4) {
    return 1;
  } else {
    return 0;
  }
}

acquireturrettarget(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");

  if(isDefined(self.outlinedent) && isDefined(self.turrettarget)) {
    scripts\mp\utility\game::outlinedisable(self.outlinedent, self.turrettarget);
  }

  if(var_0.size == 1) {
    self.turrettarget = var_0[0];
  } else {
    self.turrettarget = getbesttarget(var_0);
  }

  if(isDefined(self.turrettarget)) {
    self getplayerkillstreakcombatmode();
    self setlookatent(self.turrettarget);
    self.turret settargetentity(self.turrettarget);
    self.lastaction = "attackTarget";
    thread fireonturrettarget(1);
  }
}

acquirecannontarget(var_0) {
  self endon("death");
  self endon("leaving");
  self.cannontarget = getbesttarget(var_0);

  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
  }
}

jackalgettargets() {
  self endon("death");
  self endon("leaving");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(istarget(var_3)) {
      if(isDefined(var_1[var_2])) {
        var_0[var_0.size] = var_1[var_2];
      }
    } else
      continue;

    wait 0.05;
  }

  return var_0;
}

istarget(var_0) {
  self endon("death");

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return 0;
  }

  if(var_0.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(var_0 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distance2dsquared(self.origin, var_0.origin) > 4194304) {
    return 0;
  }

  var_1 = (0, 0, 35);
  var_2 = var_0.origin + rotatevector(var_1, var_0 getworldupreferenceangles());
  var_3 = [self];
  var_4 = scripts\engine\trace::ray_trace(self.origin, var_2, var_3, undefined, 1);

  if(!isDefined(var_4["entity"])) {
    return 0;
  }

  return 1;
}

getbesttarget(var_0) {
  self endon("death");
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(self.turrettarget) && self.turrettarget == var_4) {
      continue;
    }
    var_5 = abs(vectortoangles(var_4.origin - self.origin)[1]);
    var_6 = abs(self gettagangles("tag_origin")[1]);
    var_5 = abs(var_5 - var_6);
    var_7 = var_4 getweaponlistitems();

    foreach(var_9 in var_7) {
      if(issubstr(var_9, "chargeshot") || issubstr(var_9, "lockon")) {
        var_5 = var_5 - 40;
      }
    }

    if(distance(self.origin, var_4.origin) > 4000) {
      var_5 = var_5 + 40;
    }

    if(!isDefined(var_1)) {
      var_1 = var_5;
      var_2 = var_4;
      continue;
    }

    if(var_1 > var_5) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_moving_fortress")) {
    if(!isDefined(var_2) && isDefined(self.turrettarget)) {
      var_2 = self.turrettarget;
    }
  }

  return var_2;
}

func_8992() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\game::func_13CA1(var_9, var_13);

    if((var_9 == "aamissile_projectile_mp" || var_9 == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      func_3758(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, var_5);

  if(self.health <= var_2) {
    if(isplayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      var_12 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
      var_13 = "callout_destroyed_harrier";

      if(var_12 != "") {
        var_13 = var_13 + "_" + var_12;
      }

      scripts\mp\damage::onkillstreakkilled("jackal", var_1, var_5, var_4, var_2, "destroyed_jackal", "jackal_destroyed", var_13);
    }
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.var_1037E) || !self.var_1037E)) {
    self.var_1037E = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

getcorrectheight(var_0, var_1, var_2) {
  var_3 = 600;
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 = var_5 + randomint(var_2);
  return var_5;
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
  var_0 = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.var_11576)) {
    scripts\mp\utility\game::outlinedisable(self.var_11576, self.turrettarget);
  }

  if(!isDefined(self)) {
    return;
  }
  self.owner scripts\mp\utility\game::clearlowermessage(getothermode(self.combatmode));

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
  wait 0.35;
  thread jackaldelete();
}

func_A3B8(var_0) {
  self endon("explode");
  self getplayerkillstreakcombatmode();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  self setscriptablepartstate("engine", "explode", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

tracenewpoint(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_3 = scripts\engine\trace::sphere_trace(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_7 in self.dropcrates) {
      var_5[var_5.size] = var_7;
    }
  }

  var_9 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_9["position"][2] < var_4) {
    var_10 = var_4;
  } else {
    var_10 = var_9["position"][2];
  }

  return var_10;
}

closetogoalcheck(var_0) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread jackalexplode();
    return;
  }

  self.owner scripts\engine\utility::waittill_any("joined_team", "disconnect");
  jackalexplode();
}

func_13AD6(var_0, var_1) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    self.useobj waittill("trigger", var_2);

    if(var_2 != self.owner) {
      continue;
    }
    if(self.owner scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(isDefined(self.owner.disabledusability) && self.owner.disabledusability > 0) {
      continue;
    }
    if(scripts\mp\utility\game::func_9FAE(self.owner)) {
      continue;
    }
    var_3 = 0;

    while(self.owner usebuttonpressed()) {
      var_3 = var_3 + 0.05;

      if(var_3 > 0.1) {
        var_4 = getothermode(self.combatmode);

        if(var_4 == "guard_location") {
          var_5 = self.owner.origin[0];
          var_6 = self.owner.origin[1];
          var_7 = self.origin[2];
          var_8 = (var_5, var_6, var_7);
          var_9 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, var_8, self, var_9)) {
            self.owner scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CANNOT_BE_CALLED");
            break;
          }
        }

        self.combatmode = var_4;
        self notify(self.combatmode);

        if(self.combatmode == "guard_location") {
          var_0 = "follow_player";
          var_1 = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
          self.owner scripts\mp\utility\game::func_C638("jackal_guard");
          self.owner playlocalsound("mp_killstreak_warden_switch_mode");
          thread dropship_change_thrust_sfx();
          thread guardposition(self.owner.origin);
        } else {
          var_0 = "guard_location";
          var_1 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
          self.owner playlocalsound("mp_killstreak_warden_switch_mode");
          thread patrolfield();
          thread dropship_change_thrust_sfx();
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.var_4C08 = var_1;
        self.useobj scripts\mp\killstreaks\utility::func_F774(self.owner, self.var_4C08, 360, 360, 30000, 30000, 2);
        break;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

dropship_change_thrust_sfx() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self playsoundonmovingent("dropship_killstreak_thrust_change");
}

getothermode(var_0) {
  if(var_0 == "follow_player") {
    var_0 = "guard_location";
  } else {
    var_0 = "follow_player";
  }

  return var_0;
}

looptriggeredeffect(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    triggerfx(var_0);
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

attacklasedtarget(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 6000;
  var_5 = (0, 0, var_4);
  var_6 = 3000;
  var_7 = anglesToForward(self.angles);
  var_8 = self.origin;
  var_9 = var_8 + var_5 + var_7 * var_6 * -1;
  var_10 = [self];
  var_11 = 0;
  var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 0, var_4), var_0);

  if(var_12["fraction"] > 0.99) {
    var_11 = 1;
    var_9 = var_0 + (0, 0, var_4);
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, -300, var_4);
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 / 2;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 * 2.5;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
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
  self stopolcalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 0;
}

beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  var_0 = scripts\engine\utility::waittill_any_timeout(3.0, "death");

  if(var_0 == "timeout") {
    self.evasivemaneuvers = 0;
  }
}

func_13A9C() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");

  for(;;) {
    var_0 = undefined;

    if(scripts\mp\utility\game::istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    }

    if(isDefined(var_0)) {
      self setvehgoalpos(var_0, 1);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

watchdropcratesearly(var_0) {
  self endon("dropped_crates");
  var_1 = self.dropcrates;
  self waittill("death");
  thread dropcrates(var_1, var_0);
}

dropcrates(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = 1200;

  foreach(var_6, var_5 in var_0) {
    var_5 unlink();
    var_5 physicslaunchserver((0, 0, 0), var_2, var_3);
    var_5 thread scripts\mp\killstreaks\airdrop::physicswaiter(var_5.droptype, var_5.cratetype, var_2, var_3);
    var_5 thread scripts\mp\killstreaks\airdrop::killplayerfromcrate_fastvelocitypush();
    var_5.unresolved_collision_func = scripts\mp\killstreaks\airdrop::killplayerfromcrate_dodamage;
    var_5 thread scripts\mp\killstreaks\airdrop::handlenavobstacle();
    var_5 thread watchforcapture(self, var_6);
    wait 0.1;
  }

  if(isDefined(var_1.var_1349C)) {
    var_1.var_1349C delete();
  }

  self notify("dropped_crates");
}

watchforcapture(var_0, var_1) {
  scripts\engine\utility::waittill_any("captured", "death");
  var_0 notify("crate_captured_" + var_1);
}

watchjackalcratepickup() {
  self endon("death");
  self endon("leaving");
  var_0 = 0;

  for(;;) {
    scripts\engine\utility::waittill_any("crate_captured_0", "crate_captured_1", "crate_captured_2");
    var_0++;

    if(var_0 == self.dropcrates.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}