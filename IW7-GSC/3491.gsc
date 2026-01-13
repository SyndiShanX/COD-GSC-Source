/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3491.gsc
**************************************/

init() {
  scripts\mp\killstreaks\helicopter_guard::func_AADA();
  scripts\mp\killstreaks\helicopter_guard::func_AAD8();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("heli_sniper", ::func_128E8);
  var_0 = spawnStruct();
  var_0.scorepopup = "destroyed_helo_scout";
  var_0.callout = "callout_destroyed_helo_scout";
  var_0.samdamagescale = 0.09;
  var_0.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_sniper"] = var_0;
}

func_128E8(var_0, var_1) {
  var_2 = func_7E37(self.origin);
  var_3 = func_7E34(self.origin);
  var_4 = vectortoangles(var_3.origin - var_2.origin);

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1) {
    return 0;
  } else if(!isDefined(level.var_1A66) || !isDefined(var_2) || !isDefined(var_3)) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  var_5 = 1;

  if(func_68C2()) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_5 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(isDefined(self.iscapturingcrate) && self.iscapturingcrate) {
    return 0;
  }

  if(isDefined(self.isreviving) && self.isreviving) {
    return 0;
  }

  var_6 = func_49D1(self, var_2, var_3, var_4, var_1, var_0);

  if(!isDefined(var_6)) {
    return 0;
  }

  var_7 = helipathmemory(var_6, var_1);

  if(isDefined(var_7) && var_7 == "fail") {
    return 0;
  }

  return 1;
}

func_68C2() {
  return isDefined(level.lbsniper);
}

func_7E37(var_0) {
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

func_49D1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = var_2.origin;
  var_8 = anglesToForward(var_3);
  var_9 = var_1.origin;
  var_10 = spawnhelicopter(var_0, var_9, var_8, "attack_littlebird_mp", "vehicle_aas_72x_killstreak");

  if(!isDefined(var_10)) {
    return;
  }
  var_11 = scripts\mp\utility\game::gethelipilottraceoffset();
  var_12 = var_7 + (scripts\mp\utility\game::gethelipilotmeshoffset() + var_11);
  var_13 = var_7 + (scripts\mp\utility\game::gethelipilotmeshoffset() - var_11);
  var_14 = bulletTrace(var_12, var_13, 0, 0, 0, 0, 1);

  if(isDefined(var_14["entity"]) && var_14["normal"][2] > 0.1) {
    var_7 = var_14["position"] - scripts\mp\utility\game::gethelipilotmeshoffset() + (0, 0, 384);
  }

  var_10 scripts\mp\killstreaks\helicopter::addtolittlebirdlist("lbSniper");
  var_10 thread scripts\mp\killstreaks\helicopter::func_E111();
  var_10 thread func_136B6();
  var_10.lifeid = var_5;
  var_10.forward = var_8;
  var_10.var_C973 = var_9;
  var_10.var_C96C = var_7;
  var_10.var_C96B = var_1.origin;
  var_10.var_7003 = var_7[2];
  var_10.maxheight = var_6.origin;
  var_10.var_C537 = var_1.origin;
  var_10.var_CB45 = var_10.var_C537 + (0, 0, 300);
  var_10.var_90F1 = var_10.var_C537 + (0, 0, 600);
  var_10.var_7338 = var_8[1];
  var_10.var_273E = var_8[1] + 180;

  if(var_10.var_273E > 360) {
    var_10.var_273E = var_10.var_273E - 360;
  }

  var_10.helitype = "littlebird";
  var_10.var_8DA0 = "littlebird";
  var_10.var_AED3 = var_1.var_C6F9;
  var_10.var_1CA6 = 1;
  var_10.attractor = missile_createattractorent(var_10, level.var_8D2E, level.var_8D2D);
  var_10.isdeserteagle = 0;
  var_10.maxhealth = level.var_8D73;
  var_10 thread scripts\mp\killstreaks\flares::flares_monitor(1);
  var_10 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("heli_sniper", 1);
  var_10 thread func_8DB4(var_4);
  var_10.owner = var_0;
  var_10.team = var_0.team;
  var_10 thread func_AB2F();
  var_10.speed = 100;
  var_10.var_1E2D = 100;
  var_10.followspeed = 40;
  var_10 setCanDamage(1);
  var_10 setmaxpitchroll(45, 45);
  var_10 vehicle_setspeed(var_10.speed, 100, 40);
  var_10 setyawspeed(120, 60);
  var_10 sethoverparams(10, 10, 60);
  var_10 setneargoalnotifydist(512);
  var_10.var_A644 = 0;
  var_10.streakname = "heli_sniper";
  var_10.var_1C79 = 0;
  var_10.var_C834 = 0;
  var_10 hidepart("tag_wings");
  return var_10;
}

func_7DFC(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("helicopter_removed");
  self endon("heightReturned");
  var_1 = getent("airstrikeheight", "targetname");

  if(isDefined(var_1)) {
    var_2 = var_1.origin[2];
  } else if(isDefined(level.airstrikeheightscale)) {
    var_2 = 850 * level.airstrikeheightscale;
  } else {
    var_2 = 850;
  }

  var_3 = bulletTrace(var_0, var_0 - (0, 0, 10000), 0, self, 0, 0, 0, 0);
  var_4 = var_3["position"][2];
  var_5 = 0;
  var_6 = 0;

  for(var_7 = 0; var_7 < 30; var_7++) {
    wait 0.05;
    var_8 = var_7 % 8;
    var_9 = var_7 * 7;

    switch (var_8) {
      case 0:
        var_5 = var_9;
        var_6 = var_9;
        break;
      case 1:
        var_5 = var_9 * -1;
        var_6 = var_9 * -1;
        break;
      case 2:
        var_5 = var_9 * -1;
        var_6 = var_9;
        break;
      case 3:
        var_5 = var_9;
        var_6 = var_9 * -1;
        break;
      case 4:
        var_5 = 0;
        var_6 = var_9 * -1;
        break;
      case 5:
        var_5 = var_9 * -1;
        var_6 = 0;
        break;
      case 6:
        var_5 = var_9;
        var_6 = 0;
        break;
      case 7:
        var_5 = 0;
        var_6 = var_9;
        break;
      default:
        break;
    }

    var_10 = bulletTrace(var_0 + (var_5, var_6, 1000), var_0 - (var_5, var_6, 10000), 0, self, 0, 0, 0, 0, 0);

    if(isDefined(var_10["entity"])) {
      continue;
    }
    if(var_10["position"][2] + 145 > var_4) {
      var_4 = var_10["position"][2] + 145;
    }
  }

  return var_4;
}

helipathmemory(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("owner_disconnected");
  var_0 endon("killstreakExit");
  var_2 = func_7E37(self.origin);
  level thread scripts\mp\utility\game::teamplayercardsplash("used_heli_sniper", self, self.team);

  if(isDefined(var_2.angles)) {
    var_3 = var_2.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  scripts\engine\utility::allow_usability(0);
  var_4 = var_0.var_7003;

  if(isDefined(var_2.neighbors[0])) {
    var_5 = var_2.neighbors[0];
  } else {
    var_5 = func_7E34(self.origin);
  }

  var_6 = anglesToForward(self.angles);
  var_7 = var_5.origin * (1, 1, 0) + (0, 0, 1) * var_4 + var_6 * -100;
  var_0.targetpos = var_7;
  var_0.var_4BF7 = var_5;
  var_8 = func_BCD7(var_0);

  if(isDefined(var_8) && var_8 == "fail") {
    var_0 thread heliisfacing();
    return var_8;
  } else {
    thread func_C53A(var_0);
    return var_8;
  }
}

func_C53A(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("owner_disconnected");
  var_0 endon("killstreakExit");

  if(isDefined(self.var_9382)) {
    func_52CD();
  }

  var_0 thread setturrettargetvec();
  var_0 setyawspeed(1, 1, 1, 0.1);
  var_0 notify("picked_up_passenger");
  scripts\engine\utility::allow_usability(1);
  var_0 vehicle_setspeed(var_0.speed, 100, 40);
  self.onhelisniper = 1;
  self.var_8DD6 = var_0;
  var_0 endon("owner_death");
  var_0 thread func_DB16();
  var_0 thread func_AB2E();
  var_0 setvehgoalpos(var_0.targetpos, 1);
  var_0 thread func_8DB3();
  var_0 waittill("near_goal");
  var_0 thread helimakedepotwait();
  thread watchearlyexit(var_0);
  wait 45;
  self notify("heli_sniper_timeout");
  func_5820(var_0);
}

func_5820(var_0) {
  var_0 notify("dropping");
  var_0 thread func_8DD1();
  var_0 waittill("at_dropoff");
  var_0 vehicle_setspeed(60);
  var_0 setyawspeed(180, 180, 180, 0.3);
  wait 1;

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  thread func_F881();
  self stopridingvehicle();
  self allowjump(1);
  self setstance("stand");
  self.onhelisniper = 0;
  self.var_8DD6 = undefined;
  var_0.var_C834 = 0;
  scripts\mp\utility\game::_takeweapon("iw6_gm6helisnipe_mp_gm6scope");
  self enableweaponswitch();
  scripts\mp\utility\game::setrecoilscale();
  var_1 = scripts\engine\utility::getlastweapon();

  if(!self hasweapon(var_1)) {
    var_1 = scripts\mp\killstreaks\utility::getfirstprimaryweapon();
  }

  scripts\mp\utility\game::func_1136C(var_1);
  wait 1;

  if(isDefined(var_0)) {
    var_0 thread heliisfacing();
  }
}

watchearlyexit(var_0) {
  self endon("heli_sniper_timeout");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("dropping");
  var_0 waittill("killstreakExit");
  func_5820(var_0);
}

func_BCD7(var_0) {
  self endon("disconnect");
  self visionsetnakedforplayer("black_bw", 0.5);
  scripts\mp\utility\game::set_visionset_for_watching_players("black_bw", 0.5, 1.0);
  var_1 = scripts\engine\utility::waittill_any_timeout(0.5, "death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 == "death") {
    thread scripts\mp\killstreaks\killstreaks::clearrideintro(1.0);
    return "fail";
  }

  self cancelmantle();

  if(var_1 != "disconnect") {
    thread scripts\mp\killstreaks\killstreaks::clearrideintro(1.0, 0.75);

    if(self.team == "spectator") {
      return "fail";
    }
  }

  var_0 func_24A6();

  if(!isalive(self)) {
    return "fail";
  }

  level.var_8DD7 = var_0;
  level notify("update_uplink");
}

func_52CD() {
  foreach(var_1 in self.var_9382) {
    if(isDefined(var_1.carriedby) && var_1.carriedby == self) {
      self getrigindexfromarchetyperef();
      self.iscarrying = undefined;
      self.carrieditem = undefined;

      if(isDefined(var_1.bombsquadmodel)) {
        var_1.bombsquadmodel delete();
      }

      var_1 delete();
      self enableweapons();
    }
  }
}

func_8DB3() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.owner endon("death");
  var_0 = self.origin + anglestoright(self.owner.angles) * 1000;
  self.var_B00E = spawn("script_origin", var_0);
  self setlookatent(self.var_B00E);
  self setyawspeed(360, 120);

  for(;;) {
    wait 0.25;
    var_0 = self.origin + anglestoright(self.owner.angles) * 1000;
    self.var_B00E.origin = var_0;
  }
}

func_24A6() {
  self.owner notify("force_cancel_sentry");
  self.owner notify("force_cancel_ims");
  self.owner notify("force_cancel_placement");
  self.owner notify("cancel_carryRemoteUAV");
  self.owner setplayerangles(self gettagangles("TAG_RIDER"));
  self.owner ridevehicle(self, 40, 70, 10, 70, 1);
  self.owner setstance("crouch");
  self.owner allowjump(0);
  thread func_DE3E();
  self.var_C834 = 1;
  self notify("boarded");
  self.owner.chopper = self;
}

func_8DD1() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("owner_disconnected");
  self endon("owner_death");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in level.var_1A66) {
    if(!isDefined(var_5.script_parameters) || !issubstr(var_5.script_parameters, "pickupNode")) {
      continue;
    }
    var_6 = distancesquared(var_5.origin, self.origin);

    if(!isDefined(var_2) || var_6 < var_2) {
      var_1 = var_5;
      var_2 = var_6;

      if(var_5.script_parameters == "pickupNodehigh") {
        var_3 = 1;
        continue;
      }

      var_3 = 0;
    }
  }

  if(scripts\mp\utility\game::getmapname() == "mp_chasm") {
    if(var_1.origin == (-224, -1056, 2376)) {
      var_1.origin = (-304, -896, 2376);
    }
  }

  if(var_3 && !bullettracepassed(self.origin, var_1.origin, 0, self)) {
    self setvehgoalpos(self.origin + (0, 0, 2300), 1);
    func_137AB("near_goal", "goal", 5);
    var_8 = var_1.origin;
    var_8 = var_8 + (0, 0, 1500);
  } else if(var_1.origin[2] > self.origin[2])
    var_8 = var_1.origin;
  else {
    var_8 = var_1.origin * (1, 1, 0);
    var_8 = var_8 + (0, 0, self.origin[2]);
  }

  self setvehgoalpos(var_8, 1);
  var_9 = func_7DFC(var_8);
  var_10 = var_8 * (1, 1, 0);
  var_11 = var_10 + (0, 0, var_9);
  func_137AB("near_goal", "goal", 5);
  self.var_BCB4 = 0;
  self setvehgoalpos(var_11 + (0, 0, 200), 1);
  self.var_5D43 = 1;
  func_137AB("near_goal", "goal", 5);
  self.var_BCB4 = 1;
  self notify("at_dropoff");
}

func_137AB(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon(var_0);
  self endon(var_1);
  wait(var_2);
}

helimakedepotwait() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("dropping");
  self vehicle_setspeed(60, 45, 20);
  self setneargoalnotifydist(8);

  for(;;) {
    var_0 = self.owner getnormalizedmovement();

    if(var_0[0] >= 0.15 || var_0[1] >= 0.15 || var_0[0] <= -0.15 || var_0[1] <= -0.15) {
      thread func_B31F(var_0);
    }

    wait 0.05;
  }
}

func_8DB8() {
  self vehicle_setspeed(80, 60, 20);
  self setneargoalnotifydist(8);

  for(;;) {
    var_0 = self.owner getnormalizedmovement();

    if(var_0[0] >= 0.15 || var_0[1] >= 0.15 || var_0[0] <= -0.15 || var_0[1] <= -0.15) {
      thread func_B320(var_0);
    }

    wait 0.05;
  }
}

func_B320(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("dropping");
  self notify("manualMove");
  self endon("manualMove");
  var_1 = anglesToForward(self.owner.angles) * (350 * var_0[0]);
  var_2 = anglestoright(self.owner.angles) * (250 * var_0[1]);
  var_3 = var_1 + var_2;
  var_4 = self.origin + var_3;
  var_4 = var_4 * (1, 1, 0);
  var_4 = var_4 + (0, 0, self.maxheight[2]);

  if(distance2dsquared((0, 0, 0), var_4) > 8000000) {
    return;
  }
  self setvehgoalpos(var_4, 1);
  self waittill("goal");
}

func_B31F(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("dropping");
  self notify("manualMove");
  self endon("manualMove");
  var_1 = anglesToForward(self.owner.angles) * (250 * var_0[0]);
  var_2 = anglestoright(self.owner.angles) * (250 * var_0[1]);
  var_3 = var_1 + var_2;
  var_4 = 256;
  var_5 = self.origin + var_3;
  var_6 = scripts\mp\utility\game::gethelipilottraceoffset();
  var_7 = var_5 + (scripts\mp\utility\game::gethelipilotmeshoffset() + var_6);
  var_8 = var_5 + (scripts\mp\utility\game::gethelipilotmeshoffset() - var_6);
  var_9 = bulletTrace(var_7, var_8, 0, 0, 0, 0, 1);

  if(isDefined(var_9["entity"]) && var_9["normal"][2] > 0.1) {
    var_5 = var_9["position"] - scripts\mp\utility\game::gethelipilotmeshoffset() + (0, 0, var_4);
    var_10 = var_5[2] - self.origin[2];

    if(var_10 > 1000) {
      return;
    }
    self setvehgoalpos(var_5, 1);
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
  self setyawspeed(220, 220, 220, 0.3);
  self vehicle_setspeed(120, 60);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  self waittill("goal");
  var_0 = (self.var_C96B - self.var_C96C) * 5000;
  self setvehgoalpos(var_0, 1);
  self vehicle_setspeed(300, 75);
  self.var_AB32 = 1;
  scripts\engine\utility::waittill_any_timeout(5, "goal");

  if(isDefined(level.lbsniper) && level.lbsniper == self) {
    level.lbsniper = undefined;
  }

  self notify("delete");
  self delete();
}

func_8DB4(var_0) {
  level endon("game_ended");
  self endon("leaving");
  self waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  thread scripts\mp\killstreaks\helicopter::lbonkilled();

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

  if(isDefined(self.owner) && isalive(self.owner) && self.var_C834 == 1) {
    self.owner stopridingvehicle();
    var_1 = undefined;
    var_2 = undefined;

    if(isDefined(self.attackers)) {
      var_3 = 0;

      foreach(var_6, var_5 in self.attackers) {
        if(var_5 >= var_3) {
          var_3 = var_5;
          var_1 = var_6;
        }
      }
    }

    if(isDefined(var_1)) {
      foreach(var_8 in level.participants) {
        if(var_8 scripts\mp\utility\game::getuniqueid() == var_1) {
          var_2 = var_8;
        }
      }
    }

    var_10 = getdvarint("scr_team_fftype");

    if(isDefined(self.var_A667) && isDefined(self.var_A667.var_9E20)) {
      self.var_A667 radiusdamage(self.owner.origin, 200, 2600, 2600, self.var_A667);
    } else if(isDefined(var_2) && var_10 != 2) {
      radiusdamage(self.owner.origin, 200, 2600, 2600, var_2);
    } else if(var_10 == 2 && isDefined(var_2) && scripts\mp\utility\game::attackerishittingteam(var_2, self.owner)) {
      radiusdamage(self.owner.origin, 200, 2600, 2600, var_2);
      radiusdamage(self.owner.origin, 200, 2600, 2600);
    } else
      radiusdamage(self.owner.origin, 200, 2600, 2600);

    self.owner.onhelisniper = 0;
    self.owner.var_8DD6 = undefined;
  }
}

func_F881() {
  if(!scripts\mp\utility\game::_hasperk("specialty_falldamage")) {
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    scripts\mp\utility\game::giveperk("specialty_falldamage");
    wait 2;
    scripts\mp\utility\game::removeperk("specialty_falldamage");
  }
}

func_DE3E() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("dropping");
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.owner.lightarmorhp) && !self.owner scripts\mp\utility\game::isjuggernaut()) {
      self.owner scripts\mp\perks\perkfunctions::setlightarmor();
      var_0++;

      if(var_0 >= 2) {
        break;
      }
    }
  }
}

func_A576() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("dropping");

  for(;;) {
    if(self.owner getstance() != "crouch") {
      self.owner setstance("crouch");
    }

    wait 0.05;
  }
}

setturrettargetvec() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("dropping");
  self.owner endon("disconnect");

  for(;;) {
    if(!isalive(self.owner)) {
      return "fail";
    }

    if(self.owner getcurrentprimaryweapon() != "iw6_gm6helisnipe_mp_gm6scope") {
      self.owner giveweapon("iw6_gm6helisnipe_mp_gm6scope");
      self.owner scripts\mp\utility\game::_switchtoweaponimmediate("iw6_gm6helisnipe_mp_gm6scope");
      self.owner getraidspawnpoint();
      self.owner scripts\mp\utility\game::setrecoilscale(0, 100);
      self.owner givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
    } else
      return;

    wait 0.05;
  }
}

func_E2B9() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("dropping");

  for(;;) {
    self.owner waittill("weapon_fired");
    self.owner givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
  }
}

func_DB16() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self.owner waittill("death");
  self.owner.onhelisniper = 0;
  self.owner.var_8DD6 = undefined;
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
  self.owner waittill("disconnect");
  self notify("owner_disconnected");
  thread heliisfacing();
}

func_AB2E() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("end_death_check");
  self.owner waittill("death");
  self notify("owner_death");
  thread heliisfacing();
}

func_7E34(var_0) {
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

func_136B6() {
  var_0 = self getentitynumber();
  self waittill("death");
  level.lbsniper = undefined;

  if(isDefined(level.var_8DD7)) {
    level.var_8DD7 = undefined;
    level notify("update_uplink");
  }
}