/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3486.gsc
**************************************/

func_2A6A(var_0, var_1, var_2) {
  var_3 = getent("airstrikeheight", "targetname");

  if(isDefined(var_3)) {
    var_4 = var_3.origin[2];
  } else if(isDefined(level.airstrikeheightscale)) {
    var_4 = 850 * level.airstrikeheightscale;
  } else {
    var_4 = 850;
  }

  var_2 = var_2 * (1, 1, 0);
  var_5 = var_2 + (0, 0, var_4);
  var_6 = func_10845(var_0, self, var_1, var_5);
  var_6.var_C96C = var_5;
  return var_6;
}

getcorrectheight(var_0, var_1, var_2) {
  var_3 = 1200;
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;

  if(isDefined(level.airstrikeheightscale) && var_5 < 850 * level.airstrikeheightscale) {
    var_5 = 950 * level.airstrikeheightscale;
  }

  var_5 = var_5 + randomint(var_2);
  return var_5;
}

func_10845(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_3 - var_2);
  var_5 = spawnhelicopter(var_1, var_2, var_4, "harrier_mp", "vehicle_av8b_harrier_jet_mp");

  if(!isDefined(var_5)) {
    return;
  }
  var_5 func_184E();
  var_5 thread func_E10A();
  var_5 thread func_8992();
  var_5.speed = 250;
  var_5.var_1545 = 175;
  var_5.health = 2500;
  var_5.maxhealth = var_5.health;
  var_5.team = var_1.team;
  var_5.owner = var_1;
  var_5 setCanDamage(1);
  var_5.owner = var_1;
  var_5 thread func_8B5B();
  var_5 setmaxpitchroll(0, 90);
  var_5 vehicle_setspeed(var_5.speed, var_5.var_1545);
  var_5 thread func_D494();
  var_5 give_fwoosh_perk(3);
  var_5.missiles = 6;
  var_5.pers["team"] = var_5.team;
  var_5 sethoverparams(50, 100, 50);
  var_5 setturningability(0.05);
  var_5 setyawspeed(45, 25, 25, 0.5);
  var_5.defendloc = var_3;
  var_5.lifeid = var_0;
  var_5.allowmonitoreddamage = 1;
  var_5.var_9E20 = 1;
  var_5.damagecallback = ::func_3758;
  level.var_8B5F = scripts\engine\utility::array_removeundefined(level.var_8B5F);
  level.var_8B5F[level.var_8B5F.size] = var_5;
  level.harrier_incoming = undefined;
  return var_5;
}

func_5088(var_0) {
  var_0 endon("death");
  var_0 thread func_8B61();
  var_0 setvehgoalpos(var_0.var_C96C, 1);
  var_0 thread closetogoalcheck(var_0.var_C96C);
  var_0 waittill("goal");
  var_0 func_11075();
  var_0 func_658C();
  var_0 thread monitorowner();
}

closetogoalcheck(var_0) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(45, 25);
      break;
    }

    wait 0.05;
  }
}

func_658C() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  thread func_8B5D();
  thread func_DCB0();
  var_0 = self.defendloc;
  self vehicle_setspeed(15, 5);
  self setvehgoalpos(var_0, 1);
  self waittill("goal");
}

func_8B5E() {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  func_2FC0(1);
  self notify("stopRand");

  for(;;) {
    self vehicle_setspeed(35, 25);
    var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    var_0 = var_0 + (0, 0, 900);
    var_1 = bulletTrace(self.origin, self.origin + (0, 0, 900), 0, self);

    if(var_1["surfacetype"] == "none") {
      break;
    }
    wait 0.1;
  }

  self setvehgoalpos(var_0, 1);
  thread func_10DA1();
  self waittill("goal");
  self playsoundonmovingent("harrier_fly_away");
  var_2 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_2, 1);
  self waittill("goal");
  level.var_8B5F[level.var_8B5F.size - 1] = undefined;
  self notify("harrier_gone");
  thread func_8B5A();
}

func_8B5A() {
  self delete();
}

func_8B61() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(90);
  func_8B5E();
}

func_DCB0() {
  self notify("randomHarrierMovement");
  self endon("randomHarrierMovement");
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_0 = self.defendloc;

  for(;;) {
    var_1 = getnewpoint(self.origin);
    self setvehgoalpos(var_1, 1);
    self waittill("goal");
    wait(randomintrange(1, 2));
    self notify("randMove");
  }
}

getnewpoint(var_0, var_1) {
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
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
  } else if(scripts\engine\utility::cointoss()) {
    var_12 = self.origin - self.besttarget.origin;
    var_7 = var_12[0];
    var_8 = var_12[1] * -1;
    var_11 = getcorrectheight(var_7, var_8, 20);
    var_13 = (var_8, var_7, var_11);

    if(distance2d(self.origin, var_13) > 1200) {
      var_8 = var_8 * 0.5;
      var_7 = var_7 * 0.5;
      var_13 = (var_8, var_7, var_11);
    }
  } else {
    if(distance2d(self.origin, self.besttarget.origin) < 200) {
      return;
    }
    var_14 = self.angles[1];
    var_15 = (0, var_14, 0);
    var_16 = self.origin + anglesToForward(var_15) * randomintrange(200, 400);
    var_11 = getcorrectheight(var_16[0], var_16[1], 20);
    var_7 = var_16[0];
    var_8 = var_16[1];
  }

  for(;;) {
    var_17 = tracenewpoint(var_7, var_8, var_11);

    if(var_17 != 0) {
      return var_17;
    }

    var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_11 = getcorrectheight(var_7, var_8, 20);
  }
}

tracenewpoint(var_0, var_1, var_2) {
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");

  for(var_3 = 1; var_3 <= 10; var_3++) {
    switch (var_3) {
      case 1:
        var_4 = bulletTrace(self.origin, (var_0, var_1, var_2), 0, self);
        break;
      case 2:
        var_4 = bulletTrace(self gettagorigin("tag_left_wingtip"), (var_0, var_1, var_2), 0, self);
        break;
      case 3:
        var_4 = bulletTrace(self gettagorigin("tag_right_wingtip"), (var_0, var_1, var_2), 0, self);
        break;
      case 4:
        var_4 = bulletTrace(self gettagorigin("tag_engine_left2"), (var_0, var_1, var_2), 0, self);
        break;
      case 5:
        var_4 = bulletTrace(self gettagorigin("tag_engine_right2"), (var_0, var_1, var_2), 0, self);
        break;
      case 6:
        var_4 = bulletTrace(self gettagorigin("tag_right_alamo_missile"), (var_0, var_1, var_2), 0, self);
        break;
      case 7:
        var_4 = bulletTrace(self gettagorigin("tag_left_alamo_missile"), (var_0, var_1, var_2), 0, self);
        break;
      case 8:
        var_4 = bulletTrace(self gettagorigin("tag_right_archer_missile"), (var_0, var_1, var_2), 0, self);
        break;
      case 9:
        var_4 = bulletTrace(self gettagorigin("tag_left_archer_missile"), (var_0, var_1, var_2), 0, self);
        break;
      case 10:
        var_4 = bulletTrace(self gettagorigin("tag_light_tail"), (var_0, var_1, var_2), 0, self);
        break;
      default:
        var_4 = bulletTrace(self.origin, (var_0, var_1, var_2), 0, self);
    }

    if(var_4["surfacetype"] != "none") {
      return 0;
    }

    wait 0.05;
  }

  var_5 = (var_0, var_1, var_2);
  return var_5;
}

tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -9999999;
  var_3 = 9999999;
  var_4 = -9999999;
  var_5 = self.origin[2];
  var_6 = undefined;
  var_7 = undefined;

  for(var_8 = 1; var_8 <= 5; var_8++) {
    switch (var_8) {
      case 1:
        var_9 = bulletTrace((var_0, var_1, var_5), (var_0, var_1, var_4), 0, self);
        break;
      case 2:
        var_9 = bulletTrace((var_0 + 20, var_1 + 20, var_5), (var_0 + 20, var_1 + 20, var_4), 0, self);
        break;
      case 3:
        var_9 = bulletTrace((var_0 - 20, var_1 - 20, var_5), (var_0 - 20, var_1 - 20, var_4), 0, self);
        break;
      case 4:
        var_9 = bulletTrace((var_0 + 20, var_1 - 20, var_5), (var_0 + 20, var_1 - 20, var_4), 0, self);
        break;
      case 5:
        var_9 = bulletTrace((var_0 - 20, var_1 + 20, var_5), (var_0 - 20, var_1 + 20, var_4), 0, self);
        break;
      default:
        var_9 = bulletTrace(self.origin, (var_0, var_1, var_4), 0, self);
    }

    if(var_9["position"][2] > var_2) {
      var_2 = var_9["position"][2];
      var_6 = var_9;
    } else if(var_9["position"][2] < var_3) {
      var_3 = var_9["position"][2];
      var_7 = var_9;
    }

    wait 0.05;
  }

  return var_2;
}

func_D494() {
  self endon("death");
  wait 0.2;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait 0.2;
  playFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right");
  playFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left");
  wait 0.2;
  playFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right2");
  playFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left2");
  wait 0.2;
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait 0.2;
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait 0.2;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.2;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

func_11075() {
  stopFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  stopFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

func_10DA1() {
  wait 3.0;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = 850;
  var_4 = randomfloat(360);
  var_5 = (0, var_4, 0);
  var_6 = var_0 + anglesToForward(var_5) * (-1 * var_2);
  var_6 = var_6 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_6;
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = 850;
  var_3 = self.angles[1];
  var_4 = (0, var_3, 0);
  var_5 = self.origin + anglesToForward(var_4) * var_1;
  return var_5;
}

fireontarget(var_0, var_1) {
  self endon("leaving");
  self endon("stopfiring");
  self endon("explode");
  self endon("death");
  self.besttarget endon("death");
  self.besttarget endon("disconnect");
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 0;
  self giveflagassistedcapturepoints("harrier_20mm_mp");

  if(!isDefined(var_1)) {
    var_1 = 50;
  }

  for(;;) {
    if(isreadytofire(var_0)) {
      break;
    } else {
      wait 0.25;
    }
  }

  self setturrettargetent(self.besttarget, (0, 0, 50));
  var_5 = 25;

  for(;;) {
    if(var_5 == 25) {
      self playLoopSound("weap_hind_20mm_fire_npc");
    }

    var_5--;
    self fireweapon("tag_flash", self.besttarget, (0, 0, 0), 0.05);
    wait 0.1;

    if(var_5 <= 0) {
      self stoploopsound();
      wait 1;
      var_5 = 25;
    }
  }
}

isreadytofire(var_0) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.besttarget.origin - self.origin;
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

func_1570(var_0) {
  self endon("death");
  self endon("leaving");

  if(var_0.size == 1) {
    self.besttarget = var_0[0];
  } else {
    self.besttarget = getbesttarget(var_0);
  }

  func_2737(0);
  self notify("acquiringTarget");
  self setturrettargetent(self.besttarget);
  self setlookatent(self.besttarget);
  var_1 = getnewpoint(self.origin, 1);

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  self setvehgoalpos(var_1, 1);
  thread func_13B74();
  thread func_13B77();
  self giveflagassistedcapturepoints("harrier_20mm_mp");
  thread fireontarget();
}

func_2737(var_0) {
  self setvehgoalpos(self.defendloc, 1);

  if(isDefined(var_0) && var_0) {
    self waittill("goal");
  }
}

func_13DCF(var_0) {
  var_1 = bulletTrace(self.origin, var_0, 1, self);

  if(var_1["position"] == var_0) {
    return 0;
  } else {
    return 1;
  }
}

func_13B74() {
  self notify("watchTargetDeath");
  self endon("watchTargetDeath");
  self endon("newTarget");
  self endon("death");
  self endon("leaving");
  self.besttarget waittill("death");
  thread func_2FC0();
}

func_13B77(var_0) {
  self endon("death");
  self.besttarget endon("death");
  self.besttarget endon("disconnect");
  self endon("leaving");
  self endon("newTarget");
  var_1 = undefined;

  if(!isDefined(var_0)) {
    var_0 = 1000;
  }

  for(;;) {
    if(!istarget(self.besttarget)) {
      thread func_2FC0();
      return;
    }

    if(!isDefined(self.besttarget)) {
      thread func_2FC0();
      return;
    }

    if(self.besttarget sightconetrace(self.origin, self) < 1) {
      if(!isDefined(var_1)) {
        var_1 = gettime();
      }

      if(gettime() - var_1 > var_0) {
        thread func_2FC0();
        return;
      }
    } else {
      var_1 = undefined;
    }

    wait 0.25;
  }
}

func_2FC0(var_0) {
  self endon("death");
  self getplayerkillstreakcombatmode();
  self stoploopsound();
  self notify("stopfiring");

  if(isDefined(var_0) && var_0) {
    return;
  }
  thread func_DCB0();
  self notify("newTarget");
  thread func_8B5D();
}

func_8B5D() {
  self notify("harrierGetTargets");
  self endon("harrierGetTargets");
  self endon("death");
  self endon("leaving");
  var_0 = [];

  for(;;) {
    var_0 = [];
    var_1 = level.players;

    if(isDefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper)) {
      if(!isDefined(level.chopper.var_C084) || isDefined(level.chopper.var_C084) && !level.chopper.var_C084) {
        thread func_6591(level.chopper);
        return;
      } else {
        func_2737(1);
      }
    }

    if(isDefined(level.littlebirds)) {
      foreach(var_3 in level.littlebirds) {
        if(isDefined(var_3) && var_3.team != self.team && (isDefined(var_3.helipilottype) && var_3.helipilottype == "heli_pilot")) {
          thread func_6591(var_3);
          return;
        }
      }
    }

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_6 = var_1[var_5];

      if(istarget(var_6)) {
        if(isDefined(var_1[var_5])) {
          var_0[var_0.size] = var_1[var_5];
        }
      } else {
        continue;
      }

      wait 0.05;
    }

    if(var_0.size > 0) {
      func_1570(var_0);
      return;
    }

    wait 1;
  }
}

istarget(var_0) {
  self endon("death");

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return 0;
  }

  if(distance(var_0.origin, self.origin) > 8192) {
    return 0;
  }

  if(distance2d(var_0.origin, self.origin) < 150) {
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

  var_1 = self.origin + (0, 0, -160);
  var_2 = anglesToForward(self.angles);
  var_3 = var_1 + 144 * var_2;
  var_4 = var_0 sightconetrace(self.origin, self);

  if(var_4 < 1) {
    return 0;
  }

  return 1;
}

getbesttarget(var_0) {
  self endon("death");
  var_1 = self gettagorigin("tag_flash");
  var_2 = self.origin;
  var_3 = anglesToForward(self.angles);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = abs(vectortoangles(var_8.origin - self.origin)[1]);
    var_10 = abs(self gettagangles("tag_flash")[1]);
    var_9 = abs(var_9 - var_10);
    var_11 = var_8 getweaponlistitems();

    foreach(var_13 in var_11) {
      if(issubstr(var_13, "at4") || issubstr(var_13, "stinger") || issubstr(var_13, "jav")) {
        var_9 = var_9 - 40;
      }
    }

    if(distance(self.origin, var_8.origin) > 2000) {
      var_9 = var_9 + 40;
    }

    if(!isDefined(var_4)) {
      var_4 = var_9;
      var_5 = var_8;
      continue;
    }

    if(var_4 > var_9) {
      var_4 = var_9;
      var_5 = var_8;
    }
  }

  return var_5;
}

firemissile(var_0) {
  self endon("death");
  self endon("leaving");

  if(self.missiles <= 0) {
    return;
  }
  var_1 = func_3E13(var_0, 256);

  if(!isDefined(var_0)) {
    return;
  }
  if(distance2d(self.origin, var_0.origin) < 512) {
    return;
  }
  if(isDefined(var_1) && var_1) {
    return;
  }
  self.missiles--;
  self giveflagassistedcapturepoints("aamissile_projectile_mp");

  if(isDefined(var_0.var_1155F)) {
    var_2 = self fireweapon("tag_flash", var_0.var_1155F, (0, 0, -250));
  } else {
    var_2 = self fireweapon("tag_flash", var_0, (0, 0, -250));
  }

  var_2 missile_setflightmodedirect();
  var_2 missile_settargetent(var_0);
}

func_3E13(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  var_2 = [];
  var_3 = level.players;
  var_4 = var_0.origin;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(var_6.team != self.team) {
      continue;
    }
    var_7 = var_6.origin;

    if(distance2d(var_7, var_4) < 512) {
      return 1;
    }
  }

  return 0;
}

func_8992() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_9 == "aamissile_projectile_mp" && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
    func_3758(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
  }
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\damage::handleapdamage(var_5, var_4, var_2);

  switch (var_5) {
    case "iw6_rocketmutli_mp":
    case "iw6_rocketplyr_mp":
    case "remotemissile_projectile_mp":
    case "odin_projectile_large_rod_mp":
    case "javelin_mp":
    case "stinger_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
      self.largeprojectiledamage = 1;
      var_2 = self.maxhealth + 1;
      break;
    case "at4_mp":
    case "rpg_mp":
      self.largeprojectiledamage = 1;
      var_2 = self.maxhealth - 900;
      break;
    case "odin_projectile_small_rod_mp":
    case "remote_tank_projectile_mp":
      var_2 = int(self.maxhealth * 0.34);
      self.largeprojectiledamage = 1;
      break;
    case "iw6_panzerfaust3_mp":
    case "switch_blade_child_mp":
    case "drone_hive_projectile_mp":
      var_2 = int(self.maxhealth * 0.25);
      self.largeprojectiledamage = 1;
      break;
    default:
      if(var_5 != "none") {
        var_2 = int(var_2 / 2);
      }

      self.largeprojectiledamage = 0;
      break;
  }

  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(isplayer(var_1) && var_1 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
    var_12 = int(var_2 * level.armorpiercingmod);
    var_2 = var_2 + var_12;
  }

  if(self.health <= var_2) {
    if(isplayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_harrier", var_1);
      var_1 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_5);
      var_1 notify("destroyed_killstreak");
    }

    if(var_5 == "heli_pilot_turret_mp") {
      var_1 scripts\mp\missions::processchallenge("ch_enemy_down");
    }

    scripts\mp\missions::func_3DE3(var_1, self, var_5);
    self notify("death");
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.var_1037E) || !self.var_1037E)) {
    thread playdamageefx();
    self.var_1037E = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

playdamageefx() {
  self endon("death");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right");
  wait 0.15;
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left2");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right2");
  playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
}

func_8B5B() {
  self endon("harrier_gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread func_8B60(randomintrange(180, 220));
    wait(randomfloatrange(0.5, 1.5));
  }

  func_8B5C();
}

func_8B5C() {
  self playSound("harrier_jet_crash");
  level.var_8B5F[level.var_8B5F.size - 1] = undefined;
  var_0 = self gettagangles("tag_deathfx");
  playFX(level.harrier_deathfx, self gettagorigin("tag_deathfx"), anglesToForward(var_0), anglestoup(var_0));
  self notify("explode");
  wait 0.05;
  thread func_8B5A();
}

func_8B60(var_0) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tag_origin");
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

func_6591(var_0) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 endon("crashing");
  self endon("death");
  func_1574(var_0);
  thread func_6D7C();
}

func_6D7C() {
  self endon("leaving");
  self endon("stopfiring");
  self endon("explode");
  self.besttarget endon("crashing");
  self.besttarget endon("leaving");
  self.besttarget endon("death");
  var_0 = gettime();

  if(isDefined(self.besttarget) && self.besttarget.classname == "script_vehicle") {
    self setturrettargetent(self.besttarget);

    for(;;) {
      var_1 = distance2d(self.origin, self.besttarget.origin);

      if(gettime() - var_0 > 2500 && var_1 > 1000) {
        firemissile(self.besttarget);
        var_0 = gettime();
      }

      wait 0.1;
    }
  }
}

func_1574(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("newTarget");
  self.besttarget = var_0;
  self notify("acquiringVehTarget");
  self setlookatent(self.besttarget);
  thread func_13B9E();
  thread func_13B9D();
  self setturrettargetent(self.besttarget);
}

func_13B9D() {
  self endon("death");
  self endon("leaving");
  self.besttarget endon("death");
  self.besttarget endon("drop_crate");
  self.besttarget waittill("crashing");
  func_2FC1();
}

func_13B9E() {
  self endon("death");
  self endon("leaving");
  self.besttarget endon("crashing");
  self.besttarget endon("drop_crate");
  self.besttarget waittill("death");
  func_2FC1();
}

func_2FC1() {
  self getplayerkillstreakcombatmode();

  if(isDefined(self.besttarget) && !isDefined(self.besttarget.var_C084)) {
    self.besttarget.var_C084 = 1;
  }

  self notify("stopfiring");
  self notify("newTarget");
  thread func_11075();
  thread func_658C();
}

func_67E4() {
  self setmaxpitchroll(15, 80);
  self vehicle_setspeed(50, 100);
  self setyawspeed(90, 30, 30, 0.5);
  var_0 = self.origin;
  var_1 = self.angles[1];

  if(scripts\engine\utility::cointoss()) {
    var_2 = (0, var_1 + 90, 0);
  } else {
    var_2 = (0, var_1 - 90, 0);
  }

  var_3 = self.origin + anglesToForward(var_2) * 500;
  self setvehgoalpos(var_3, 1);
  self waittill("goal");
}

func_184E() {
  level.helis[self getentitynumber()] = self;
}

func_E10A() {
  var_0 = self getentitynumber();
  self waittill("death");
  level.helis[var_0] = undefined;
}

monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread func_8B5E();
    return;
  }

  self.owner scripts\engine\utility::waittill_any("joined_team", "disconnect");
  thread func_8B5E();
}