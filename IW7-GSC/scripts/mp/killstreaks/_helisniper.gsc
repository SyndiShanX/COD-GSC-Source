/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helisniper.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\_helicopter_guard::func_AADA();
  scripts\mp\killstreaks\_helicopter_guard::func_AAD8();
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("heli_sniper", ::func_128E8);
  var_00 = spawnStruct();
  var_00.scorepopup = "destroyed_helo_scout";
  var_00.callout = "callout_destroyed_helo_scout";
  var_00.samdamagescale = 0.09;
  var_00.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_sniper"] = var_00;
}

func_128E8(param_00, param_01) {
  var_02 = func_7E37(self.origin);
  var_03 = func_7E34(self.origin);
  var_04 = vectortoangles(var_03.origin - var_02.origin);
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1) {
    return 0;
  } else if(!isDefined(level.var_1A66) || !isDefined(var_02) || !isDefined(var_03)) {
    self iprintlnbold( & "KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  var_05 = 1;
  if(func_68C2()) {
    self iprintlnbold( & "KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_05 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(isDefined(self.iscapturingcrate) && self.iscapturingcrate) {
    return 0;
  }

  if(isDefined(self.isreviving) && self.isreviving) {
    return 0;
  }

  var_06 = func_49D1(self, var_02, var_03, var_04, param_01, param_00);
  if(!isDefined(var_06)) {
    return 0;
  }

  var_07 = helipathmemory(var_06, param_01);
  if(isDefined(var_07) && var_07 == "fail") {
    return 0;
  }

  return 1;
}

func_68C2() {
  return isDefined(level.lbsniper);
}

func_7E37(param_00) {
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

func_49D1(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getent("airstrikeheight", "targetname");
  var_07 = param_02.origin;
  var_08 = anglesToForward(param_03);
  var_09 = param_01.origin;
  var_0A = spawnhelicopter(param_00, var_09, var_08, "attack_littlebird_mp", "vehicle_aas_72x_killstreak");
  if(!isDefined(var_0A)) {
    return;
  }

  var_0B = scripts\mp\utility::gethelipilottraceoffset();
  var_0C = var_07 + scripts\mp\utility::gethelipilotmeshoffset() + var_0B;
  var_0D = var_07 + scripts\mp\utility::gethelipilotmeshoffset() - var_0B;
  var_0E = bulletTrace(var_0C, var_0D, 0, 0, 0, 0, 1);
  if(isDefined(var_0E["entity"]) && var_0E["normal"][2] > 0.1) {
    var_07 = var_0E["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, 384);
  }

  var_0A scripts\mp\killstreaks\_helicopter::addtolittlebirdlist("lbSniper");
  var_0A thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_0A thread func_136B6();
  var_0A.lifeid = param_05;
  var_0A.missionfailed = var_08;
  var_0A.var_C973 = var_09;
  var_0A.var_C96C = var_07;
  var_0A.var_C96B = param_01.origin;
  var_0A.var_7003 = var_07[2];
  var_0A.maxheight = var_06.origin;
  var_0A.var_C537 = param_01.origin;
  var_0A.var_CB45 = var_0A.var_C537 + (0, 0, 300);
  var_0A.var_90F1 = var_0A.var_C537 + (0, 0, 600);
  var_0A.var_7338 = var_08[1];
  var_0A.var_273E = var_08[1] + 180;
  if(var_0A.var_273E > 360) {
    var_0A.var_273E = var_0A.var_273E - 360;
  }

  var_0A.helitype = "littlebird";
  var_0A.var_8DA0 = "littlebird";
  var_0A.var_AED3 = param_01.var_C6F9;
  var_0A.var_1CA6 = 1;
  var_0A.attractor = missile_createattractorent(var_0A, level.var_8D2E, level.var_8D2D);
  var_0A.isdeserteagle = 0;
  var_0A.maxhealth = level.var_8D73;
  var_0A thread scripts\mp\killstreaks\_flares::flares_monitor(1);
  var_0A thread scripts\mp\killstreaks\_helicopter::heli_damage_monitor("heli_sniper", 1);
  var_0A thread func_8DB4(param_04);
  var_0A.triggerportableradarping = param_00;
  var_0A.team = param_00.team;
  var_0A thread func_AB2F();
  var_0A.getclosestpointonnavmesh3d = 100;
  var_0A.var_1E2D = 100;
  var_0A.followspeed = 40;
  var_0A setCanDamage(1);
  var_0A setmaxpitchroll(45, 45);
  var_0A vehicle_setspeed(var_0A.getclosestpointonnavmesh3d, 100, 40);
  var_0A givelastonteamwarning(120, 60);
  var_0A sethoverparams(10, 10, 60);
  var_0A setneargoalnotifydist(512);
  var_0A.var_A644 = 0;
  var_0A.streakname = "heli_sniper";
  var_0A.var_1C79 = 0;
  var_0A.var_C834 = 0;
  var_0A hidepart("tag_wings");
  return var_0A;
}

func_7DFC(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("helicopter_removed");
  self endon("heightReturned");
  var_01 = getent("airstrikeheight", "targetname");
  if(isDefined(var_01)) {
    var_02 = var_01.origin[2];
  } else if(isDefined(level.airstrikeheightscale)) {
    var_02 = 850 * level.airstrikeheightscale;
  } else {
    var_02 = 850;
  }

  var_03 = bulletTrace(param_00, param_00 - (0, 0, 10000), 0, self, 0, 0, 0, 0);
  var_04 = var_03["position"][2];
  var_05 = 0;
  var_06 = 0;
  for(var_07 = 0; var_07 < 30; var_07++) {
    wait(0.05);
    var_08 = var_07 % 8;
    var_09 = var_07 * 7;
    switch (var_08) {
      case 0:
        var_05 = var_09;
        var_06 = var_09;
        break;

      case 1:
        var_05 = var_09 * -1;
        var_06 = var_09 * -1;
        break;

      case 2:
        var_05 = var_09 * -1;
        var_06 = var_09;
        break;

      case 3:
        var_05 = var_09;
        var_06 = var_09 * -1;
        break;

      case 4:
        var_05 = 0;
        var_06 = var_09 * -1;
        break;

      case 5:
        var_05 = var_09 * -1;
        var_06 = 0;
        break;

      case 6:
        var_05 = var_09;
        var_06 = 0;
        break;

      case 7:
        var_05 = 0;
        var_06 = var_09;
        break;

      default:
        break;
    }

    var_0A = bulletTrace(param_00 + (var_05, var_06, 1000), param_00 - (var_05, var_06, 10000), 0, self, 0, 0, 0, 0, 0);
    if(isDefined(var_0A["entity"])) {
      continue;
    }

    if(var_0A["position"][2] + 145 > var_04) {
      var_04 = var_0A["position"][2] + 145;
    }
  }

  return var_04;
}

helipathmemory(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("crashing");
  param_00 endon("owner_disconnected");
  param_00 endon("killstreakExit");
  var_02 = func_7E37(self.origin);
  level thread scripts\mp\utility::teamplayercardsplash("used_heli_sniper", self, self.team);
  if(isDefined(var_02.angles)) {
    var_03 = var_02.angles;
  } else {
    var_03 = (0, 0, 0);
  }

  scripts\engine\utility::allow_usability(0);
  var_04 = param_00.var_7003;
  if(isDefined(var_02.neighbors[0])) {
    var_05 = var_02.neighbors[0];
  } else {
    var_05 = func_7E34(self.origin);
  }

  var_06 = anglesToForward(self.angles);
  var_07 = var_05.origin * (1, 1, 0) + (0, 0, 1) * var_04 + var_06 * -100;
  param_00.targetpos = var_07;
  param_00.var_4BF7 = var_05;
  var_08 = func_BCD7(param_00);
  if(isDefined(var_08) && var_08 == "fail") {
    param_00 thread heliisfacing();
    return var_08;
  }

  thread func_C53A(param_00);
  return var_08;
}

func_C53A(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("crashing");
  param_00 endon("owner_disconnected");
  param_00 endon("killstreakExit");
  if(isDefined(self.var_9382)) {
    func_52CD();
  }

  param_00 thread setturrettargetvec();
  param_00 givelastonteamwarning(1, 1, 1, 0.1);
  param_00 notify("picked_up_passenger");
  scripts\engine\utility::allow_usability(1);
  param_00 vehicle_setspeed(param_00.getclosestpointonnavmesh3d, 100, 40);
  self.onhelisniper = 1;
  self.var_8DD6 = param_00;
  param_00 endon("owner_death");
  param_00 thread func_DB16();
  param_00 thread func_AB2E();
  param_00 setvehgoalpos(param_00.targetpos, 1);
  param_00 thread func_8DB3();
  param_00 waittill("near_goal");
  param_00 thread helimakedepotwait();
  thread watchearlyexit(param_00);
  wait(45);
  self notify("heli_sniper_timeout");
  func_5820(param_00);
}

func_5820(param_00) {
  param_00 notify("dropping");
  param_00 thread func_8DD1();
  param_00 waittill("at_dropoff");
  param_00 vehicle_setspeed(60);
  param_00 givelastonteamwarning(180, 180, 180, 0.3);
  wait(1);
  if(!scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  thread func_F881();
  self stopridingvehicle();
  self allowjump(1);
  self setstance("stand");
  self.onhelisniper = 0;
  self.var_8DD6 = undefined;
  param_00.var_C834 = 0;
  scripts\mp\utility::_takeweapon("iw6_gm6helisnipe_mp_gm6scope");
  self enableweaponswitch();
  scripts\mp\utility::setrecoilscale();
  var_01 = scripts\engine\utility::getlastweapon();
  if(!self hasweapon(var_01)) {
    var_01 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
  }

  scripts\mp\utility::func_1136C(var_01);
  wait(1);
  if(isDefined(param_00)) {
    param_00 thread heliisfacing();
  }
}

watchearlyexit(param_00) {
  self endon("heli_sniper_timeout");
  param_00 thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit("dropping");
  param_00 waittill("killstreakExit");
  func_5820(param_00);
}

func_BCD7(param_00) {
  self endon("disconnect");
  self visionsetnakedforplayer("black_bw", 0.5);
  scripts\mp\utility::set_visionset_for_watching_players("black_bw", 0.5, 1);
  var_01 = scripts\engine\utility::waittill_any_timeout_1(0.5, "death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_01 == "death") {
    thread scripts\mp\killstreaks\_killstreaks::clearrideintro(1);
    return "fail";
  }

  self cancelmantle();
  if(var_01 != "disconnect") {
    thread scripts\mp\killstreaks\_killstreaks::clearrideintro(1, 0.75);
    if(self.team == "spectator") {
      return "fail";
    }
  }

  param_00 func_24A6();
  if(!isalive(self)) {
    return "fail";
  }

  level.var_8DD7 = param_00;
  level notify("update_uplink");
}

func_52CD() {
  foreach(var_01 in self.var_9382) {
    if(isDefined(var_01.carriedby) && var_01.carriedby == self) {
      self getrigindexfromarchetyperef();
      self.iscarrying = undefined;
      self.carrieditem = undefined;
      if(isDefined(var_01.bombsquadmodel)) {
        var_01.bombsquadmodel delete();
      }

      var_01 delete();
      self enableweapons();
    }
  }
}

func_8DB3() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.triggerportableradarping endon("death");
  var_00 = self.origin + anglestoright(self.triggerportableradarping.angles) * 1000;
  self.var_B00E = spawn("script_origin", var_00);
  self setlookatent(self.var_B00E);
  self givelastonteamwarning(360, 120);
  for(;;) {
    wait(0.25);
    var_00 = self.origin + anglestoright(self.triggerportableradarping.angles) * 1000;
    self.var_B00E.origin = var_00;
  }
}

func_24A6() {
  self.triggerportableradarping notify("force_cancel_sentry");
  self.triggerportableradarping notify("force_cancel_ims");
  self.triggerportableradarping notify("force_cancel_placement");
  self.triggerportableradarping notify("cancel_carryRemoteUAV");
  self.triggerportableradarping setplayerangles(self gettagangles("TAG_RIDER"));
  self.triggerportableradarping ridevehicle(self, 40, 70, 10, 70, 1);
  self.triggerportableradarping setstance("crouch");
  self.triggerportableradarping allowjump(0);
  thread func_DE3E();
  self.var_C834 = 1;
  self notify("boarded");
  self.triggerportableradarping.chopper = self;
}

func_8DD1() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("owner_disconnected");
  self endon("owner_death");
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = 0;
  foreach(var_05 in level.var_1A66) {
    if(!isDefined(var_05.script_parameters) || !issubstr(var_05.script_parameters, "pickupNode")) {
      continue;
    }

    var_06 = distancesquared(var_05.origin, self.origin);
    if(!isDefined(var_02) || var_06 < var_02) {
      var_01 = var_05;
      var_02 = var_06;
      if(var_05.script_parameters == "pickupNodehigh") {
        var_03 = 1;
        continue;
      }

      var_03 = 0;
    }
  }

  if(scripts\mp\utility::getmapname() == "mp_chasm") {
    if(var_01.origin == (-224, -1056, 2376)) {
      var_01.origin = (-304, -896, 2376);
    }
  }

  if(var_03 && !bullettracepassed(self.origin, var_01.origin, 0, self)) {
    self setvehgoalpos(self.origin + (0, 0, 2300), 1);
    func_137AB("near_goal", "goal", 5);
    var_08 = var_01.origin;
    var_08 = var_08 + (0, 0, 1500);
  } else if(var_02.origin[2] > self.origin[2]) {
    var_08 = var_02.origin;
  } else {
    var_08 = var_02.origin * (1, 1, 0);
    var_08 = var_08 + (0, 0, self.origin[2]);
  }

  self setvehgoalpos(var_08, 1);
  var_09 = func_7DFC(var_08);
  var_0A = var_08 * (1, 1, 0);
  var_0B = var_0A + (0, 0, var_09);
  func_137AB("near_goal", "goal", 5);
  self.var_BCB4 = 0;
  self setvehgoalpos(var_0B + (0, 0, 200), 1);
  self.var_5D43 = 1;
  func_137AB("near_goal", "goal", 5);
  self.var_BCB4 = 1;
  self notify("at_dropoff");
}

func_137AB(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon(param_00);
  self endon(param_01);
  wait(param_02);
}

helimakedepotwait() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("dropping");
  self vehicle_setspeed(60, 45, 20);
  self setneargoalnotifydist(8);
  for(;;) {
    var_00 = self.triggerportableradarping getnormalizedmovement();
    if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15) {
      thread func_B31F(var_00);
    }

    wait(0.05);
  }
}

func_8DB8() {
  self vehicle_setspeed(80, 60, 20);
  self setneargoalnotifydist(8);
  for(;;) {
    var_00 = self.triggerportableradarping getnormalizedmovement();
    if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15) {
      thread func_B320(var_00);
    }

    wait(0.05);
  }
}

func_B320(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("dropping");
  self notify("manualMove");
  self endon("manualMove");
  var_01 = anglesToForward(self.triggerportableradarping.angles) * 350 * param_00[0];
  var_02 = anglestoright(self.triggerportableradarping.angles) * 250 * param_00[1];
  var_03 = var_01 + var_02;
  var_04 = self.origin + var_03;
  var_04 = var_04 * (1, 1, 0);
  var_04 = var_04 + (0, 0, self.maxheight[2]);
  if(distance2dsquared((0, 0, 0), var_04) > 8000000) {
    return;
  }

  self setvehgoalpos(var_04, 1);
  self waittill("goal");
}

func_B31F(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("dropping");
  self notify("manualMove");
  self endon("manualMove");
  var_01 = anglesToForward(self.triggerportableradarping.angles) * 250 * param_00[0];
  var_02 = anglestoright(self.triggerportableradarping.angles) * 250 * param_00[1];
  var_03 = var_01 + var_02;
  var_04 = 256;
  var_05 = self.origin + var_03;
  var_06 = scripts\mp\utility::gethelipilottraceoffset();
  var_07 = var_05 + scripts\mp\utility::gethelipilotmeshoffset() + var_06;
  var_08 = var_05 + scripts\mp\utility::gethelipilotmeshoffset() - var_06;
  var_09 = bulletTrace(var_07, var_08, 0, 0, 0, 0, 1);
  if(isDefined(var_09["entity"]) && var_09["normal"][2] > 0.1) {
    var_05 = var_09["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, var_04);
    var_0A = var_05[2] - self.origin[2];
    if(var_0A > 1000) {
      return;
    }

    self setvehgoalpos(var_05, 1);
    self waittill("goal");
  }
}

heliisfacing() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self notify("end_disconnect_check");
  self notify("end_death_check");
  self notify("leaving");
  if(isDefined(self.var_A79F)) {
    self.var_A79F delete();
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.var_BD6D)) {
    self.var_BD6D scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.var_1137A)) {
    self.var_1137A scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.var_BCCF)) {
    self.var_BCCF scripts\mp\hud_util::destroyelem();
  }

  self getplayerkillstreakcombatmode();
  level.var_8DD7 = undefined;
  level notify("update_uplink");
  self givelastonteamwarning(220, 220, 220, 0.3);
  self vehicle_setspeed(120, 60);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  self waittill("goal");
  var_00 = self.var_C96B - self.var_C96C * 5000;
  self setvehgoalpos(var_00, 1);
  self vehicle_setspeed(300, 75);
  self.var_AB32 = 1;
  scripts\engine\utility::waittill_any_timeout_1(5, "goal");
  if(isDefined(level.lbsniper) && level.lbsniper == self) {
    level.lbsniper = undefined;
  }

  self notify("delete");
  self delete();
}

func_8DB4(param_00) {
  level endon("game_ended");
  self endon("leaving");
  self waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
  if(isDefined(self.var_A79F)) {
    self.var_A79F delete();
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.var_BD6D)) {
    self.var_BD6D scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.var_1137A)) {
    self.var_1137A scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.var_BCCF)) {
    self.var_BCCF scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.triggerportableradarping) && isalive(self.triggerportableradarping) && self.var_C834 == 1) {
    self.triggerportableradarping stopridingvehicle();
    var_01 = undefined;
    var_02 = undefined;
    if(isDefined(self.attackers)) {
      var_03 = 0;
      foreach(var_06, var_05 in self.attackers) {
        if(var_05 >= var_03) {
          var_03 = var_05;
          var_01 = var_06;
        }
      }
    }

    if(isDefined(var_01)) {
      foreach(var_08 in level.participants) {
        if(var_08 scripts\mp\utility::getuniqueid() == var_01) {
          var_02 = var_08;
        }
      }
    }

    var_0A = getdvarint("scr_team_fftype");
    if(isDefined(self.var_A667) && isDefined(self.var_A667.var_9E20)) {
      self.var_A667 radiusdamage(self.triggerportableradarping.origin, 200, 2600, 2600, self.var_A667);
    } else if(isDefined(var_02) && var_0A != 2) {
      radiusdamage(self.triggerportableradarping.origin, 200, 2600, 2600, var_02);
    } else if(var_0A == 2 && isDefined(var_02) && scripts\mp\utility::attackerishittingteam(var_02, self.triggerportableradarping)) {
      radiusdamage(self.triggerportableradarping.origin, 200, 2600, 2600, var_02);
      radiusdamage(self.triggerportableradarping.origin, 200, 2600, 2600);
    } else {
      radiusdamage(self.triggerportableradarping.origin, 200, 2600, 2600);
    }

    self.triggerportableradarping.onhelisniper = 0;
    self.triggerportableradarping.var_8DD6 = undefined;
  }
}

func_F881() {
  if(!scripts\mp\utility::_hasperk("specialty_falldamage")) {
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    scripts\mp\utility::giveperk("specialty_falldamage");
    wait(2);
    scripts\mp\utility::removeperk("specialty_falldamage");
  }
}

func_DE3E() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("dropping");
  var_00 = 0;
  for(;;) {
    wait(0.05);
    if(!isDefined(self.triggerportableradarping.lightarmorhp) && !self.triggerportableradarping scripts\mp\utility::isjuggernaut()) {
      self.triggerportableradarping scripts\mp\perks\_perkfunctions::setlightarmor();
      var_00++;
      if(var_00 >= 2) {
        break;
      }
    }
  }
}

func_A576() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("dropping");
  for(;;) {
    if(self.triggerportableradarping getstance() != "crouch") {
      self.triggerportableradarping setstance("crouch");
    }

    wait(0.05);
  }
}

setturrettargetvec() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("dropping");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    if(!isalive(self.triggerportableradarping)) {
      return "fail";
    }

    if(self.triggerportableradarping getcurrentprimaryweapon() != "iw6_gm6helisnipe_mp_gm6scope") {
      self.triggerportableradarping giveweapon("iw6_gm6helisnipe_mp_gm6scope");
      self.triggerportableradarping scripts\mp\utility::_switchtoweaponimmediate("iw6_gm6helisnipe_mp_gm6scope");
      self.triggerportableradarping getraidspawnpoint();
      self.triggerportableradarping scripts\mp\utility::setrecoilscale(0, 100);
      self.triggerportableradarping givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
    } else {
      return;
    }

    wait(0.05);
  }
}

func_E2B9() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("dropping");
  for(;;) {
    self.triggerportableradarping waittill("weapon_fired");
    self.triggerportableradarping givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
  }
}

func_DB16() {
  level endon("game_ended");
  self.triggerportableradarping endon("disconnect");
  self endon("death");
  self endon("crashing");
  self.triggerportableradarping waittill("death");
  self.triggerportableradarping.onhelisniper = 0;
  self.triggerportableradarping.var_8DD6 = undefined;
  self.var_C834 = 0;
  if(isDefined(self.origin)) {
    physicsexplosionsphere(self.origin, 200, 200, 1);
  }
}

func_AB2F() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("end_disconnect_check");
  self.triggerportableradarping waittill("disconnect");
  self notify("owner_disconnected");
  thread heliisfacing();
}

func_AB2E() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("end_death_check");
  self.triggerportableradarping waittill("death");
  self notify("owner_death");
  thread heliisfacing();
}

func_7E34(param_00) {
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

func_136B6() {
  var_00 = self getentitynumber();
  self waittill("death");
  level.lbsniper = undefined;
  if(isDefined(level.var_8DD7)) {
    level.var_8DD7 = undefined;
    level notify("update_uplink");
  }
}