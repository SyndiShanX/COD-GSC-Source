/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter_guard.gsc
********************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("littlebird_support", ::func_128EE);
  level.heliheight = [];
  level.heliheight["littlebird_support"] = spawnStruct();
  level.heliheight["littlebird_support"].timeout = 60;
  level.heliheight["littlebird_support"].health = 999999;
  level.heliheight["littlebird_support"].maxhealth = 2000;
  level.heliheight["littlebird_support"].streakname = "littlebird_support";
  level.heliheight["littlebird_support"].vehicleinfo = "attack_littlebird_mp";
  level.heliheight["littlebird_support"].weaponinfo = "littlebird_guard_minigun_mp";
  level.heliheight["littlebird_support"].var_13CA9 = "vehicle_little_bird_minigun_left";
  level.heliheight["littlebird_support"].var_13CAA = "vehicle_little_bird_minigun_right";
  level.heliheight["littlebird_support"].weaponswitchendedsupportbox = "tag_flash";
  level.heliheight["littlebird_support"].weaponswitchendedtomastrike = "tag_flash_2";
  level.heliheight["littlebird_support"].sentrymode = "auto_nonai";
  level.heliheight["littlebird_support"].modelbase = "vehicle_aas_72x_killstreak";
  level.heliheight["littlebird_support"].teamsplash = "used_littlebird_support";
  func_AADA();
  func_AAD8();
}

func_128EE(var_0, var_1) {
  var_2 = "littlebird_support";
  var_3 = 1;
  if(isDefined(level.var_AD89) || scripts\mp\killstreaks\_helicopter::exceededmaxlittlebirds(var_2)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(!level.var_1A66.size) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_4 = func_49E1(var_2);
  if(!isDefined(var_4)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  thread func_10DBE(var_4);
  level thread scripts\mp\utility::teamplayercardsplash(level.heliheight[var_2].teamsplash, self, self.team);
  return 1;
}

func_49E1(var_0) {
  var_1 = func_AAD2(self.origin);
  if(isDefined(var_1.angles)) {
    var_2 = var_1.angles;
  } else {
    var_2 = (0, 0, 0);
  }

  var_3 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_4 = func_AAD1(self.origin);
  var_5 = anglesToForward(self.angles);
  var_6 = var_4.origin * (1, 1, 0) + (0, 0, 1) * var_3 + var_5 * -100;
  var_7 = var_1.origin;
  var_8 = spawnhelicopter(self, var_7, var_2, level.heliheight[var_0].vehicleinfo, level.heliheight[var_0].modelbase);
  if(!isDefined(var_8)) {
    return;
  }

  var_8 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_8 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_8.health = level.heliheight[var_0].health;
  var_8.maxhealth = level.heliheight[var_0].maxhealth;
  var_8.var_E1 = 0;
  var_8.getclosestpointonnavmesh3d = 100;
  var_8.followspeed = 40;
  var_8.owner = self;
  var_8 setotherent(self);
  var_8.team = self.team;
  var_8 setmaxpitchroll(45, 45);
  var_8 vehicle_setspeed(var_8.getclosestpointonnavmesh3d, 100, 40);
  var_8 givelastonteamwarning(120, 60);
  var_8 setneargoalnotifydist(512);
  var_8.var_A644 = 0;
  var_8.helitype = "littlebird";
  var_8.heliheightoffset = "littlebird_support";
  var_8.var_11587 = 2000;
  var_8 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_8.targetpos = var_6;
  var_8.var_4BF7 = var_4;
  var_9 = spawnturret("misc_turret", var_8.origin, level.heliheight[var_0].weaponinfo);
  var_9 linkto(var_8, level.heliheight[var_0].weaponswitchendedsupportbox, (0, 0, 0), (0, 0, 0));
  var_9 setModel(level.heliheight[var_0].var_13CA9);
  var_9.angles = var_8.angles;
  var_9.owner = var_8.owner;
  var_9.team = self.team;
  var_9 getvalidattachments();
  var_9.vehicle = var_8;
  var_8.mgturretleft = var_9;
  var_8.mgturretleft setdefaultdroppitch(0);
  var_10 = var_8.origin + anglesToForward(var_8.angles) * -100 + anglestoright(var_8.angles) * -100 + (0, 0, 50);
  var_9.killcament = spawn("script_model", var_10);
  var_9.killcament setscriptmoverkillcam("explosive");
  var_9.killcament linkto(var_8, "tag_origin");
  var_9 = spawnturret("misc_turret", var_8.origin, level.heliheight[var_0].weaponinfo);
  var_9 linkto(var_8, level.heliheight[var_0].weaponswitchendedtomastrike, (0, 0, 0), (0, 0, 0));
  var_9 setModel(level.heliheight[var_0].var_13CAA);
  var_9.angles = var_8.angles;
  var_9.owner = var_8.owner;
  var_9.team = self.team;
  var_9 getvalidattachments();
  var_9.vehicle = var_8;
  var_8.mgturretright = var_9;
  var_8.mgturretright setdefaultdroppitch(0);
  var_10 = var_8.origin + anglesToForward(var_8.angles) * -100 + anglestoright(var_8.angles) * 100 + (0, 0, 50);
  var_9.killcament = spawn("script_model", var_10);
  var_9.killcament setscriptmoverkillcam("explosive");
  var_9.killcament linkto(var_8, "tag_origin");
  if(level.teambased) {
    var_8.mgturretleft setturretteam(self.team);
    var_8.mgturretright setturretteam(self.team);
  }

  var_8.mgturretleft give_player_session_tokens(level.heliheight[var_0].sentrymode);
  var_8.mgturretright give_player_session_tokens(level.heliheight[var_0].sentrymode);
  var_8.mgturretleft setsentryowner(self);
  var_8.mgturretright setsentryowner(self);
  var_8.mgturretleft thread func_AACB();
  var_8.mgturretright thread func_AACB();
  var_8.attract_strength = 10000;
  var_8.attract_range = 150;
  var_8.attractor = missile_createattractorent(var_8, var_8.attract_strength, var_8.attract_range);
  var_8.hasdodged = 0;
  var_8.empgrenaded = 0;
  var_8 thread func_AAD4();
  var_8 thread func_AADB();
  var_8 thread func_AAE1();
  var_8 thread func_AADD();
  var_8 thread func_AADC();
  var_8 thread func_AADE();
  var_8 thread func_AAD6();
  level.var_AD89 = var_8;
  var_8.owner scripts\mp\matchdata::logkillstreakevent(level.heliheight[var_8.heliheightoffset].streakname, var_8.targetpos);
  return var_8;
}

func_AAD6() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

func_10DBE(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 setlookatent(self);
  var_0 setvehgoalpos(var_0.targetpos);
  var_0 waittill("near_goal");
  var_0 vehicle_setspeed(var_0.getclosestpointonnavmesh3d, 60, 30);
  var_0 waittill("goal");
  var_0 setvehgoalpos(var_0.var_4BF7.origin, 1);
  var_0 waittill("goal");
  var_0 thread func_AACF();
  var_0 thread scripts\mp\killstreaks\_flares::func_6EAA(::func_AADF);
  var_0 thread scripts\mp\killstreaks\_flares::func_6EAB(::func_AAE0);
}

func_AACF() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  if(!isDefined(self.owner)) {
    thread func_AAD5();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");
  self vehicle_setspeed(self.followspeed, 20, 20);
  for(;;) {
    if(isDefined(self.owner) && isalive(self.owner)) {
      var_0 = func_AAD0(self.owner.origin);
      if(isDefined(var_0) && var_0 != self.var_4BF7) {
        self.var_4BF7 = var_0;
        func_AAD7();
        continue;
      }
    }

    wait(1);
  }
}

func_AAD7() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("lbSupport_moveToPlayer");
  self endon("lbSupport_moveToPlayer");
  self.intransit = 1;
  self setvehgoalpos(self.var_4BF7.origin + (0, 0, 100), 1);
  self waittill("goal");
  self.intransit = 0;
  self notify("hit_goal");
}

func_AADB() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
}

func_AAE1() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level.heliheight[self.heliheightoffset].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread func_AAD5();
}

func_AADD() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner waittill("killstreak_disowned");
  self notify("owner_gone");
  thread func_AAD5();
}

func_AADC() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  for(;;) {
    self.owner waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility::func_13CA1(var_9, var_13);
    if(isPlayer(var_1)) {
      if(var_1 != self.owner && distance2d(var_1.origin, self.origin) <= self.var_11587 && !var_1 scripts\mp\utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_1.team == self.team) {
        self setlookatent(var_1);
        if(isDefined(self.mgturretleft)) {
          self.mgturretleft settargetentity(var_1);
        }

        if(isDefined(self.mgturretright)) {
          self.mgturretright settargetentity(var_1);
        }
      }
    }
  }
}

func_AADE() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  thread func_AAD5();
}

func_AAD5() {
  self endon("death");
  self notify("leaving");
  level.var_AD89 = undefined;
  self getplayerkillstreakcombatmode();
  var_0 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_1 = self.origin + (0, 0, var_0);
  self vehicle_setspeed(self.getclosestpointonnavmesh3d, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_1);
  self waittill("goal");
  var_1 = var_1 + anglesToForward(self.angles) * 15000;
  var_2 = spawn("script_origin", var_1);
  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread wait_and_delete(3);
  }

  self setvehgoalpos(var_1);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\_helicopter::removelittlebird();
}

wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

func_AAD4() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility::func_13CA1(var_9, var_13);
    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var_1)) {
      continue;
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_8) && var_8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    var_14 = var_0;
    if(isPlayer(var_1)) {
      if(var_1 != self.owner && distance2d(var_1.origin, self.origin) <= self.var_11587 && !var_1 scripts\mp\utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_1.team == self.team) {
        self setlookatent(var_1);
        if(isDefined(self.mgturretleft)) {
          self.mgturretleft settargetentity(var_1);
        }

        if(isDefined(self.mgturretright)) {
          self.mgturretright settargetentity(var_1);
        }
      }

      var_1 scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
      if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
        if(var_1 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
          var_14 = var_14 + var_0 * level.armorpiercingmod;
        }
      }
    }

    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
    }

    if(isDefined(var_9)) {
      switch (var_9) {
        case "remotemissile_projectile_mp":
        case "javelin_mp":
        case "remote_mortar_missile_mp":
        case "stinger_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          self.largeprojectiledamage = 1;
          var_14 = self.maxhealth + 1;
          break;

        case "sam_projectile_mp":
          self.largeprojectiledamage = 1;
          var_14 = self.maxhealth * 0.25;
          break;

        case "emp_grenade_mp":
          var_14 = 0;
          thread func_AACE();
          break;

        case "osprey_player_minigun_mp":
          self.largeprojectiledamage = 0;
          var_14 = var_14 * 2;
          break;
      }

      scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_9, self);
    }

    self.var_E1 = self.var_E1 + var_14;
    if(self.var_E1 >= self.maxhealth) {
      if(isPlayer(var_1) && !isDefined(self.owner) || var_1 != self.owner) {
        var_1 notify("destroyed_helicopter");
        var_1 notify("destroyed_killstreak", var_9);
        thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_little_bird", var_1);
        var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_9, 300);
        var_1 thread scripts\mp\rank::scoreeventpopup("destroyed_little_bird");
      }

      if(isDefined(self.owner)) {
        self.owner thread scripts\mp\utility::leaderdialogonplayer("lbguard_destroyed");
      }

      self notify("death");
      return;
    }
  }
}

func_AACE() {
  self notify("lbSupport_EMPGrenaded");
  self endon("lbSupport_EMPGrenaded");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;
  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(level._effect["ims_sensor_explode"])) {
    if(isDefined(self.mgturretright)) {
      playFXOnTag(scripts\engine\utility::getfx("ims_sensor_explode"), self.mgturretright, "tag_aim");
    }

    if(isDefined(self.mgturretleft)) {
      playFXOnTag(scripts\engine\utility::getfx("ims_sensor_explode"), self.mgturretleft, "tag_aim");
    }
  }

  wait(3.5);
  self.empgrenaded = 0;
  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("turretstatechange");
  }

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("turretstatechange");
  }
}

func_AADF(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("death");
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(var_3[var_4]) && !var_2.hasdodged) {
      var_2.hasdodged = 1;
      var_5 = spawn("script_origin", var_2.origin);
      var_5.angles = var_2.angles;
      var_5 movegravity(anglestoright(var_3[var_4].angles) * -1000, 0.05);
      var_5 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
      for(var_6 = 0; var_6 < var_3.size; var_6++) {
        if(isDefined(var_3[var_6])) {
          var_3[var_6] missile_settargetent(var_5);
        }
      }

      var_7 = var_2.origin + anglestoright(var_3[var_4].angles) * 200;
      var_2 vehicle_setspeed(var_2.getclosestpointonnavmesh3d, 100, 40);
      var_2 setvehgoalpos(var_7, 1);
      wait(2);
      var_2 vehicle_setspeed(var_2.followspeed, 20, 20);
      break;
    }
  }
}

func_AAE0(var_0, var_1, var_2) {
  level endon("game_ended");
  var_2 endon("death");
  if(isDefined(self) && !var_2.hasdodged) {
    var_2.hasdodged = 1;
    var_3 = spawn("script_origin", var_2.origin);
    var_3.angles = var_2.angles;
    var_3 movegravity(anglestoright(self.angles) * -1000, 0.05);
    var_3 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
    self missile_settargetent(var_3);
    var_4 = var_2.origin + anglestoright(self.angles) * 200;
    var_2 vehicle_setspeed(var_2.getclosestpointonnavmesh3d, 100, 40);
    var_2 setvehgoalpos(var_4, 1);
    wait(2);
    var_2 vehicle_setspeed(var_2.followspeed, 20, 20);
  }
}

func_AAD2(var_0) {
  var_1 = undefined;
  var_2 = 999999;
  foreach(var_4 in level.air_start_nodes) {
    var_5 = distance(var_4.origin, var_0);
    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

func_AAD1(var_0) {
  var_1 = undefined;
  var_2 = 999999;
  foreach(var_4 in level.var_1A66) {
    var_5 = distance(var_4.origin, var_0);
    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

func_AAD0(var_0) {
  var_1 = undefined;
  var_2 = distance2d(self.var_4BF7.origin, var_0);
  var_3 = var_2;
  foreach(var_5 in self.var_4BF7.neighbors) {
    var_6 = distance2d(var_5.origin, var_0);
    if(var_6 < var_2 && var_6 < var_3) {
      var_1 = var_5;
      var_3 = var_6;
    }
  }

  return var_1;
}

func_AACA(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_AAD3() {
  var_0 = [];
  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getstruct(var_1[var_2], "script_linkname");
      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

func_AADA() {
  level.air_start_nodes = scripts\engine\utility::getstructarray("chopper_boss_path_start", "targetname");
  foreach(var_1 in level.air_start_nodes) {
    var_1.neighbors = var_1 func_AAD3();
  }
}

func_AAD9() {
  level.var_1A67 = scripts\engine\utility::getstructarray("chopper_boss_path", "targetname");
  foreach(var_1 in level.var_1A67) {
    var_1.neighbors = var_1 func_AAD3();
  }
}

func_AAD8() {
  level.var_1A66 = scripts\engine\utility::getstructarray("so_chopper_boss_path_struct", "script_noteworthy");
  foreach(var_1 in level.var_1A66) {
    var_1.neighbors = var_1 func_AAD3();
    foreach(var_3 in level.var_1A66) {
      if(var_1 == var_3) {
        continue;
      }

      if(!func_AACA(var_1.neighbors, var_3) && func_AACA(var_3 func_AAD3(), var_1)) {
        var_1.neighbors[var_1.neighbors.size] = var_3;
      }
    }
  }
}

func_AACB() {
  self.vehicle endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("turretstatechange");
    if(self getteamarray() && !self.vehicle.empgrenaded) {
      thread func_AACC();
      continue;
    }

    thread func_AACD();
  }
}

func_AACC() {
  self.vehicle endon("death");
  self.vehicle endon("leaving");
  self endon("stop_shooting");
  level endon("game_ended");
  var_0 = 0.1;
  var_1 = 40;
  var_2 = 80;
  var_3 = 1;
  var_4 = 2;
  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);
    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_7 = self getturrettarget(0);
      if(isDefined(var_7) && !isDefined(var_7.spawntime) || gettime() - var_7.spawntime / 1000 > 5 && isDefined(var_7.team) && var_7.team != "spectator" && scripts\mp\utility::isreallyalive(var_7)) {
        self.vehicle setlookatent(var_7);
        self shootturret();
      }

      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

func_AACD() {
  self notify("stop_shooting");
  if(isDefined(self.vehicle.owner)) {
    self.vehicle setlookatent(self.vehicle.owner);
  }
}