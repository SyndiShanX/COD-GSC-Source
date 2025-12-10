/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter_guard.gsc
********************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("littlebird_support", ::func_128EE);
  level.heliheight = [];
  level.heliheight["littlebird_support"] = spawnStruct();
  level.heliheight["littlebird_support"].timeout = 60;
  level.heliheight["littlebird_support"].health = 999999;
  level.heliheight["littlebird_support"].maxhealth = 2000;
  level.heliheight["littlebird_support"].streakname = "littlebird_support";
  level.heliheight["littlebird_support"].vehicleinfo = "attack_littlebird_mp";
  level.heliheight["littlebird_support"].var_39B = "littlebird_guard_minigun_mp";
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

func_128EE(param_00, param_01) {
  var_02 = "littlebird_support";
  var_03 = 1;
  if(isDefined(level.var_AD89) || scripts\mp\killstreaks\_helicopter::exceededmaxlittlebirds(var_02)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(!level.var_1A66.size) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_04 = func_49E1(var_02);
  if(!isDefined(var_04)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  thread func_10DBE(var_04);
  level thread scripts\mp\utility::teamplayercardsplash(level.heliheight[var_02].teamsplash, self, self.team);
  return 1;
}

func_49E1(param_00) {
  var_01 = func_AAD2(self.origin);
  if(isDefined(var_01.angles)) {
    var_02 = var_01.angles;
  } else {
    var_02 = (0, 0, 0);
  }

  var_03 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_04 = func_AAD1(self.origin);
  var_05 = anglesToForward(self.angles);
  var_06 = var_04.origin * (1, 1, 0) + (0, 0, 1) * var_03 + var_05 * -100;
  var_07 = var_01.origin;
  var_08 = spawnhelicopter(self, var_07, var_02, level.heliheight[param_00].vehicleinfo, level.heliheight[param_00].modelbase);
  if(!isDefined(var_08)) {
    return;
  }

  var_08 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_08 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_08.health = level.heliheight[param_00].health;
  var_08.maxhealth = level.heliheight[param_00].maxhealth;
  var_08.var_E1 = 0;
  var_08.getclosestpointonnavmesh3d = 100;
  var_08.followspeed = 40;
  var_08.triggerportableradarping = self;
  var_08 setotherent(self);
  var_08.team = self.team;
  var_08 setmaxpitchroll(45, 45);
  var_08 vehicle_setspeed(var_08.getclosestpointonnavmesh3d, 100, 40);
  var_08 givelastonteamwarning(120, 60);
  var_08 setneargoalnotifydist(512);
  var_08.var_A644 = 0;
  var_08.helitype = "littlebird";
  var_08.heliheightoffset = "littlebird_support";
  var_08.var_11587 = 2000;
  var_08 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_08.targetpos = var_06;
  var_08.var_4BF7 = var_04;
  var_09 = spawnturret("misc_turret", var_08.origin, level.heliheight[param_00].var_39B);
  var_09 linkto(var_08, level.heliheight[param_00].weaponswitchendedsupportbox, (0, 0, 0), (0, 0, 0));
  var_09 setModel(level.heliheight[param_00].var_13CA9);
  var_09.angles = var_08.angles;
  var_09.triggerportableradarping = var_08.triggerportableradarping;
  var_09.team = self.team;
  var_09 getvalidattachments();
  var_09.vehicle = var_08;
  var_08.mgturretleft = var_09;
  var_08.mgturretleft setdefaultdroppitch(0);
  var_0A = var_08.origin + anglesToForward(var_08.angles) * -100 + anglestoright(var_08.angles) * -100 + (0, 0, 50);
  var_09.killcament = spawn("script_model", var_0A);
  var_09.killcament setscriptmoverkillcam("explosive");
  var_09.killcament linkto(var_08, "tag_origin");
  var_09 = spawnturret("misc_turret", var_08.origin, level.heliheight[param_00].var_39B);
  var_09 linkto(var_08, level.heliheight[param_00].weaponswitchendedtomastrike, (0, 0, 0), (0, 0, 0));
  var_09 setModel(level.heliheight[param_00].var_13CAA);
  var_09.angles = var_08.angles;
  var_09.triggerportableradarping = var_08.triggerportableradarping;
  var_09.team = self.team;
  var_09 getvalidattachments();
  var_09.vehicle = var_08;
  var_08.mgturretright = var_09;
  var_08.mgturretright setdefaultdroppitch(0);
  var_0A = var_08.origin + anglesToForward(var_08.angles) * -100 + anglestoright(var_08.angles) * 100 + (0, 0, 50);
  var_09.killcament = spawn("script_model", var_0A);
  var_09.killcament setscriptmoverkillcam("explosive");
  var_09.killcament linkto(var_08, "tag_origin");
  if(level.teambased) {
    var_08.mgturretleft setturretteam(self.team);
    var_08.mgturretright setturretteam(self.team);
  }

  var_08.mgturretleft give_player_session_tokens(level.heliheight[param_00].sentrymode);
  var_08.mgturretright give_player_session_tokens(level.heliheight[param_00].sentrymode);
  var_08.mgturretleft setsentryowner(self);
  var_08.mgturretright setsentryowner(self);
  var_08.mgturretleft thread func_AACB();
  var_08.mgturretright thread func_AACB();
  var_08.attract_strength = 10000;
  var_08.attract_range = 150;
  var_08.attractor = missile_createattractorent(var_08, var_08.attract_strength, var_08.attract_range);
  var_08.hasdodged = 0;
  var_08.empgrenaded = 0;
  var_08 thread func_AAD4();
  var_08 thread func_AADB();
  var_08 thread func_AAE1();
  var_08 thread func_AADD();
  var_08 thread func_AADC();
  var_08 thread func_AADE();
  var_08 thread func_AAD6();
  level.var_AD89 = var_08;
  var_08.triggerportableradarping scripts\mp\matchdata::logkillstreakevent(level.heliheight[var_08.heliheightoffset].streakname, var_08.targetpos);
  return var_08;
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

func_10DBE(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 setlookatent(self);
  param_00 setvehgoalpos(param_00.targetpos);
  param_00 waittill("near_goal");
  param_00 vehicle_setspeed(param_00.getclosestpointonnavmesh3d, 60, 30);
  param_00 waittill("goal");
  param_00 setvehgoalpos(param_00.var_4BF7.origin, 1);
  param_00 waittill("goal");
  param_00 thread func_AACF();
  param_00 thread scripts\mp\killstreaks\_flares::func_6EAA(::func_AADF);
  param_00 thread scripts\mp\killstreaks\_flares::func_6EAB(::func_AAE0);
}

func_AACF() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  if(!isDefined(self.triggerportableradarping)) {
    thread func_AAD5();
    return;
  }

  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  self vehicle_setspeed(self.followspeed, 20, 20);
  for(;;) {
    if(isDefined(self.triggerportableradarping) && isalive(self.triggerportableradarping)) {
      var_00 = func_AAD0(self.triggerportableradarping.origin);
      if(isDefined(var_00) && var_00 != self.var_4BF7) {
        self.var_4BF7 = var_00;
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
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
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
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  var_00 = level.heliheight[self.heliheightoffset].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  thread func_AAD5();
}

func_AADD() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping waittill("killstreak_disowned");
  self notify("owner_gone");
  thread func_AAD5();
}

func_AADC() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  for(;;) {
    self.triggerportableradarping waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(isplayer(var_01)) {
      if(var_01 != self.triggerportableradarping && distance2d(var_01.origin, self.origin) <= self.var_11587 && !var_01 scripts\mp\utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_01.team == self.team) {
        self setlookatent(var_01);
        if(isDefined(self.mgturretleft)) {
          self.mgturretleft settargetentity(var_01);
        }

        if(isDefined(self.mgturretright)) {
          self.mgturretright settargetentity(var_01);
        }
      }
    }
  }
}

func_AADE() {
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  thread func_AAD5();
}

func_AAD5() {
  self endon("death");
  self notify("leaving");
  level.var_AD89 = undefined;
  self getplayerkillstreakcombatmode();
  var_00 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_01 = self.origin + (0, 0, var_00);
  self vehicle_setspeed(self.getclosestpointonnavmesh3d, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_01);
  self waittill("goal");
  var_01 = var_01 + anglesToForward(self.angles) * 15000;
  var_02 = spawn("script_origin", var_01);
  if(isDefined(var_02)) {
    self setlookatent(var_02);
    var_02 thread wait_and_delete(3);
  }

  self setvehgoalpos(var_01);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\_helicopter::removelittlebird();
}

wait_and_delete(param_00) {
  self endon("death");
  level endon("game_ended");
  wait(param_00);
  self delete();
}

func_AAD4() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(!scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, var_01)) {
      continue;
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_08) && var_08 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_08) && var_08 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    var_0E = var_00;
    if(isplayer(var_01)) {
      if(var_01 != self.triggerportableradarping && distance2d(var_01.origin, self.origin) <= self.var_11587 && !var_01 scripts\mp\utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_01.team == self.team) {
        self setlookatent(var_01);
        if(isDefined(self.mgturretleft)) {
          self.mgturretleft settargetentity(var_01);
        }

        if(isDefined(self.mgturretright)) {
          self.mgturretright settargetentity(var_01);
        }
      }

      var_01 scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
      if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
        if(var_01 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
          var_0E = var_0E + var_00 * level.armorpiercingmod;
        }
      }
    }

    if(isDefined(var_01.triggerportableradarping) && isplayer(var_01.triggerportableradarping)) {
      var_01.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "remotemissile_projectile_mp":
        case "javelin_mp":
        case "remote_mortar_missile_mp":
        case "stinger_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          self.largeprojectiledamage = 1;
          var_0E = self.maxhealth + 1;
          break;

        case "sam_projectile_mp":
          self.largeprojectiledamage = 1;
          var_0E = self.maxhealth * 0.25;
          break;

        case "emp_grenade_mp":
          var_0E = 0;
          thread func_AACE();
          break;

        case "osprey_player_minigun_mp":
          self.largeprojectiledamage = 0;
          var_0E = var_0E * 2;
          break;
      }

      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_01, var_09, self);
    }

    self.var_E1 = self.var_E1 + var_0E;
    if(self.var_E1 >= self.maxhealth) {
      if(isplayer(var_01) && !isDefined(self.triggerportableradarping) || var_01 != self.triggerportableradarping) {
        var_01 notify("destroyed_helicopter");
        var_01 notify("destroyed_killstreak", var_09);
        thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_little_bird", var_01);
        var_01 thread scripts\mp\utility::giveunifiedpoints("kill", var_09, 300);
        var_01 thread scripts\mp\rank::scoreeventpopup("destroyed_little_bird");
      }

      if(isDefined(self.triggerportableradarping)) {
        self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("lbguard_destroyed");
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
  self.triggerportableradarping endon("disconnect");
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

func_AADF(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_02 endon("death");
  for(var_04 = 0; var_04 < param_03.size; var_04++) {
    if(isDefined(param_03[var_04]) && !param_02.hasdodged) {
      param_02.hasdodged = 1;
      var_05 = spawn("script_origin", param_02.origin);
      var_05.angles = param_02.angles;
      var_05 movegravity(anglestoright(param_03[var_04].angles) * -1000, 0.05);
      var_05 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
      for(var_06 = 0; var_06 < param_03.size; var_06++) {
        if(isDefined(param_03[var_06])) {
          param_03[var_06] missile_settargetent(var_05);
        }
      }

      var_07 = param_02.origin + anglestoright(param_03[var_04].angles) * 200;
      param_02 vehicle_setspeed(param_02.getclosestpointonnavmesh3d, 100, 40);
      param_02 setvehgoalpos(var_07, 1);
      wait(2);
      param_02 vehicle_setspeed(param_02.followspeed, 20, 20);
      break;
    }
  }
}

func_AAE0(param_00, param_01, param_02) {
  level endon("game_ended");
  param_02 endon("death");
  if(isDefined(self) && !param_02.hasdodged) {
    param_02.hasdodged = 1;
    var_03 = spawn("script_origin", param_02.origin);
    var_03.angles = param_02.angles;
    var_03 movegravity(anglestoright(self.angles) * -1000, 0.05);
    var_03 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
    self missile_settargetent(var_03);
    var_04 = param_02.origin + anglestoright(self.angles) * 200;
    param_02 vehicle_setspeed(param_02.getclosestpointonnavmesh3d, 100, 40);
    param_02 setvehgoalpos(var_04, 1);
    wait(2);
    param_02 vehicle_setspeed(param_02.followspeed, 20, 20);
  }
}

func_AAD2(param_00) {
  var_01 = undefined;
  var_02 = 999999;
  foreach(var_04 in level.air_start_nodes) {
    var_05 = distance(var_04.origin, param_00);
    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

func_AAD1(param_00) {
  var_01 = undefined;
  var_02 = 999999;
  foreach(var_04 in level.var_1A66) {
    var_05 = distance(var_04.origin, param_00);
    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

func_AAD0(param_00) {
  var_01 = undefined;
  var_02 = distance2d(self.var_4BF7.origin, param_00);
  var_03 = var_02;
  foreach(var_05 in self.var_4BF7.neighbors) {
    var_06 = distance2d(var_05.origin, param_00);
    if(var_06 < var_02 && var_06 < var_03) {
      var_01 = var_05;
      var_03 = var_06;
    }
  }

  return var_01;
}

func_AACA(param_00, param_01) {
  if(param_00.size <= 0) {
    return 0;
  }

  foreach(var_03 in param_00) {
    if(var_03 == param_01) {
      return 1;
    }
  }

  return 0;
}

func_AAD3() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = scripts\engine\utility::getstruct(var_01[var_02], "script_linkname");
      if(isDefined(var_03)) {
        var_00[var_00.size] = var_03;
      }
    }
  }

  return var_00;
}

func_AADA() {
  level.air_start_nodes = scripts\engine\utility::getstructarray("chopper_boss_path_start", "targetname");
  foreach(var_01 in level.air_start_nodes) {
    var_01.neighbors = var_01 func_AAD3();
  }
}

func_AAD9() {
  level.var_1A67 = scripts\engine\utility::getstructarray("chopper_boss_path", "targetname");
  foreach(var_01 in level.var_1A67) {
    var_01.neighbors = var_01 func_AAD3();
  }
}

func_AAD8() {
  level.var_1A66 = scripts\engine\utility::getstructarray("so_chopper_boss_path_struct", "script_noteworthy");
  foreach(var_01 in level.var_1A66) {
    var_01.neighbors = var_01 func_AAD3();
    foreach(var_03 in level.var_1A66) {
      if(var_01 == var_03) {
        continue;
      }

      if(!func_AACA(var_01.neighbors, var_03) && func_AACA(var_03 func_AAD3(), var_01)) {
        var_01.neighbors[var_01.neighbors.size] = var_03;
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
  var_00 = 0.1;
  var_01 = 40;
  var_02 = 80;
  var_03 = 1;
  var_04 = 2;
  for(;;) {
    var_05 = randomintrange(var_01, var_02 + 1);
    for(var_06 = 0; var_06 < var_05; var_06++) {
      var_07 = self getturrettarget(0);
      if(isDefined(var_07) && !isDefined(var_07.spawntime) || gettime() - var_07.spawntime / 1000 > 5 && isDefined(var_07.team) && var_07.team != "spectator" && scripts\mp\utility::isreallyalive(var_07)) {
        self.vehicle setlookatent(var_07);
        self shootturret();
      }

      wait(var_00);
    }

    wait(randomfloatrange(var_03, var_04));
  }
}

func_AACD() {
  self notify("stop_shooting");
  if(isDefined(self.vehicle.triggerportableradarping)) {
    self.vehicle setlookatent(self.vehicle.triggerportableradarping);
  }
}