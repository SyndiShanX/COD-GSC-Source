/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_water.gsc
*********************************************/

func_00D5() {
  if(isDefined(level.water_wake)) {
    level.var_0611["water_wake"] = loadfx(level.water_wake);
  } else {
    level.var_0611["water_wake"] = loadfx("vfx/treadfx/body_wake_water");
  }

  if(isDefined(level.water_wake_stationary)) {
    level.var_0611["water_wake_stationary"] = loadfx(level.water_wake_stationary);
  } else {
    level.var_0611["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");
  }

  if(isDefined(level.water_splash_emerge)) {
    level.var_0611["water_splash_emerge"] = loadfx(level.water_splash_emerge);
  } else {
    level.var_0611["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");
  }

  if(isDefined(level.water_splash_enter)) {
    level.var_0611["water_splash_enter"] = loadfx(level.water_splash_enter);
  } else {
    level.var_0611["water_splash_enter"] = loadfx("vfx/water/body_splash");
  }

  precacheshellshock("underwater");
  if(!isDefined(level.var_A968)) {
    level.var_A968 = [];
  }

  if(!isDefined(level.var_A969)) {
    level.var_A969 = 0;
  }

  if(!isDefined(level.var_8ACF)) {
    if(isDefined(level.var_585D) && level.var_585D) {
      func_8720("shovel_zm");
    } else {
      func_8720("iw5_underwater_mp");
    }
  }

  if(!isDefined(level.var_2B7C)) {
    func_865D("iw5_underwater_mp");
  }

  if(!isDefined(level.var_0C19)) {
    level.var_0C19 = 1;
  }

  if(level.var_2B7C == level.var_8ACF) {
    level.var_0C19 = 0;
  }

  if(!isDefined(level.var_9545)) {
    level.var_9545 = 48;
  }

  var_00 = getEntArray("trigger_underwater", "targetname");
  level.var_A964 = var_00;
  foreach(var_02 in var_00) {
    var_02 func_278A();
    var_02 thread func_A935();
  }

  level thread func_2415(var_00);
  level thread func_6B6E();
  setDvar("scr_ball_water_drop_delay", 10);
}

func_7320(param_00) {
  if(param_00) {
    self.var_5525 = 1;
    return;
  }

  self.var_5525 = undefined;
}

func_A90E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("player_migrated");
    foreach(var_01 in level.var_A968) {
      self initwaterclienttrigger(var_01.var_0165, var_01);
    }
  }
}

func_6B6E() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_A90E();
    foreach(var_02 in level.var_A968) {
      var_00 initwaterclienttrigger(var_02.var_0165, var_02);
    }
  }
}

func_278A() {
  var_00 = common_scripts\utility::func_46B5(self.var_01A2, "targetname");
  var_00.var_0116 = var_00.var_0116 + (0, 0, level.var_A969);
  var_01 = var_00 common_scripts\utility::func_8FFC();
  var_01 method_805B();
  if(isDefined(self.var_0165)) {
    var_01.var_0165 = self.var_0165;
    level.var_A968 = common_scripts\utility::func_0F6F(level.var_A968, var_01);
  }
}

func_2415(param_00) {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_01);
    var_02 = 0;
    foreach(var_04 in param_00) {
      if(var_01 istouching(var_04)) {
        var_02 = 1;
        break;
      }
    }

    if(!var_02) {
      var_01 func_7320(0);
      var_01.var_A019 = undefined;
      var_01.var_542A = undefined;
      var_01 method_86C7();
      var_01.var_57F2 = undefined;
      var_01.var_5849 = undefined;
      var_01.var_A95F = undefined;
      var_01.watermovespeedscale = 1;
      var_01.var_57C9 = undefined;
      var_01 notify("out_of_water");
    }
  }
}

func_A935() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00) && !isai(var_00)) {
      continue;
    }

    if(!isalive(var_00)) {
      continue;
    }

    if(var_00 common_scripts\_plant_weapon::func_5855()) {
      continue;
    }

    if(!isDefined(var_00.var_5525)) {
      var_00 func_7320(1);
      var_00 thread func_740D(self);
    }
  }
}

func_740D(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  thread func_5526(param_00);
  thread func_748F();
  self.var_3999 = 0;
  self.var_3997 = 0;
  for(;;) {
    if(maps\mp\_utility::func_581D()) {
      if(isDefined(self.var_A019) && isDefined(self.var_57C9)) {
        self notify("stop_water_shellshock");
        self stopshellshock();
        self method_812A(1);
        self.var_57C9 = undefined;
      }
    } else if(isDefined(self.var_A019) && !isDefined(self.var_57C9)) {
      thread playerapplyshellshock();
      self method_812A(0);
    }

    if(!self istouching(param_00)) {
      func_7320(0);
      self.var_A019 = undefined;
      self.var_542A = undefined;
      self method_86C7();
      self.var_57F2 = undefined;
      self.watermovespeedscale = 1;
      maps\mp\gametypes\_weapons::func_A13B();
      self notify("out_of_water");
      self.var_5849 = undefined;
      if(!maps\mp\_utility::func_581D()) {
        self stopshellshock();
        self method_812A(1);
        self.var_57C9 = undefined;
      }

      func_73D6();
      maps\mp\_utility::func_73AF(1);
      var_01 = distance(self getvelocity(), (0, 0, 0));
      var_02 = (self.var_0116[0], self.var_0116[1], func_471B(param_00));
      playFX(level.var_0611["water_splash_emerge"], var_02, anglesToForward((0, self.var_001D[1], 0) + (270, 180, 0)));
      break;
    }

    if(isDefined(self.var_542A) && func_53CA(param_00, 32)) {
      self.var_542A = undefined;
      self.watermovespeedscale = 1;
      maps\mp\gametypes\_weapons::func_A13B();
    }

    if(func_53CA(param_00, 32)) {
      self.var_542A = undefined;
      if(isDefined(level.var_A96A)) {
        self.watermovespeedscale = level.var_A96A;
      } else {
        self.watermovespeedscale = 1;
      }

      maps\mp\gametypes\_weapons::func_A13B();
    }

    if(!isDefined(self.var_542A) && !func_53CA(param_00, 32)) {
      self.var_542A = 1;
      self.watermovespeedscale = 0.7;
      maps\mp\gametypes\_weapons::func_A13B();
    }

    if(!isDefined(self.var_A019) && !func_565D(param_00, 0) || isunderwaterprop()) {
      if(isDefined(self.var_1561) && self.var_1561 > 0) {
        self.var_1561--;
        wait 0.05;
        continue;
      }

      self.var_A019 = 1;
      if(isDefined(level.var_A96B)) {
        self thread[[level.var_A96B]]();
      } else if(!level.var_3FDC == "prop" && self.var_01A7 != game["defenders"]) {
        thread func_73F2();
      }

      maps\mp\_utility::func_73AF(0);
      if(!maps\mp\_utility::func_581D()) {
        thread playerapplyshellshock();
        self method_812A(0);
      }

      var_03 = self getcurrentweapon();
      if(var_03 != "none") {
        var_04 = function_01D4(var_03);
        if(var_04 == "primary" || var_04 == "altmode") {
          self.var_A95F = var_03;
        } else if(maps\mp\_utility::func_5740(var_03)) {
          self.var_A95F = maps\mp\killstreaks\_killstreaks::func_73EB();
        } else if(isDefined(self.var_5BC5) && self hasweapon(self.var_5BC5)) {
          self.var_A95F = self.var_5BC5;
        }
      }

      if(isDefined(level.var_3FC9)) {
        self[[level.var_3FC9]](var_01);
      }
    }

    if(isDefined(self.var_A019) && (isDefined(self.var_57F2) || !isDefined(self.var_5849)) && func_53CA(var_02, level.var_9545) || self getstance() == "prone" || !level.var_0C19) {
      self.var_5849 = 1;
      self method_86C6();
      self.var_57F2 = undefined;
      func_73D6();
      if(isDefined(self.var_5738) && self.var_5738 == 1) {
        func_73DE("none");
        self method_812B(0);
        self method_84CB();
      } else if(!isDefined(level.var_585D) || !function_02BF(self)) {
        func_73DE("shallow");
      }
    }

    if(isDefined(self.var_A019) && (isDefined(self.var_5849) || !isDefined(self.var_57F2)) && !func_53CA(var_02, level.var_9545) && self getstance() != "prone" && level.var_0C19) {
      self method_86C6();
      self.var_57F2 = 1;
      self.var_5849 = undefined;
      func_73D6();
      if(isDefined(self.var_5738) && self.var_5738 == 1) {
        func_73DE("none");
        self method_812B(0);
        self method_84CB();
      } else if(!isDefined(level.var_585D) || !function_02BF(self)) {
        func_73DE("deep");
      }
    }

    if(isDefined(self.var_1561)) {
      self.var_1561 = getdvarint("scr_ball_water_drop_delay", 10);
    }

    if(isDefined(self.var_A019) && func_565D(var_02, 0) && !isunderwaterprop()) {
      self.var_A019 = undefined;
      self method_86C7();
      self.var_57F2 = undefined;
      self.var_5849 = undefined;
      self notify("above_water");
      var_03 = distance(self getvelocity(), (0, 0, 0));
      var_04 = (self.var_0116[0], self.var_0116[1], func_471B(var_02));
      playFX(level.var_0611["water_splash_emerge"], var_04, anglesToForward((0, self.var_001D[1], 0) + (270, 180, 0)));
      if(!maps\mp\_utility::func_581D()) {
        self stopshellshock();
        self method_812A(1);
        self.var_57C9 = undefined;
      }

      func_73D6();
      maps\mp\_utility::func_73AF(1);
    }

    wait 0.05;
  }
}

isunderwaterprop() {
  var_00 = level.var_3FDC == "prop";
  var_01 = self.var_01A7 == game["defenders"];
  var_02 = maps\mp\_utility::func_4571() != "mp_wolfslair";
  return var_00 && var_01 && var_02;
}

playerapplyshellshock() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_water_shellshock");
  self endon("out_of_water");
  self endon("above_water");
  self.var_57C9 = 1;
  for(;;) {
    self shellshock("underwater", 19, undefined, 0);
    wait(19);
  }
}

func_5660(param_00) {
  if(isDefined(param_00.var_5A69)) {
    var_01 = self.var_012C["killstreaks"][self.var_5A69].var_944C;
    if(isDefined(var_01)) {
      if(issubstr(var_01, "turret") || issubstr(var_01, "sentry")) {
        return 1;
      }
    }
  }

  return 0;
}

func_748F() {
  var_00 = common_scripts\utility::func_A715("death", "out_of_water");
  if(isDefined(self)) {
    self.var_A01A = undefined;
    self.var_3236 = undefined;
    func_7320(0);
    self.var_A019 = undefined;
    self.var_542A = undefined;
    self.var_A95F = undefined;
    self.watermovespeedscale = 1;
    maps\mp\gametypes\_weapons::func_A13B();
  }
}

inwaterwakevfxcleanup() {
  self endon("inWaterWakeVFXCleanup");
  if(function_01EF(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentwake);
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentstationary);
  }

  if(!isDefined(self.waterwakevfxdeletefunc)) {
    self.waterwakevfxdeletefunc = ::waterwakevfxdelete;
  }

  common_scripts\utility::func_A70C(self, "death", level, "game_ended", self, "disconnect", self, "out_of_water", self.fxentwake, "entitydeleted", self.fxentstationary, "entitydeleted");
  thread waterwakevfxdelete();
}

waterwakevfxdelete() {
  self notify("inWaterWakeVFXCleanup");
  self notify("out_of_water");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.fxentwake)) {
    self.fxentwake delete();
  }

  if(isDefined(self.fxentstationary)) {
    self.fxentstationary delete();
  }

  if(isDefined(self.waterwakevfxdeletefunc)) {
    self.waterwakevfxdeletefunc = undefined;
  }
}

func_5526(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");
  var_01 = distance(self getvelocity(), (0, 0, 0));
  if(var_01 > 90) {
    var_02 = (self.var_0116[0], self.var_0116[1], func_471B(param_00));
    playFX(level.var_0611["water_splash_enter"], var_02, anglesToForward((0, self.var_001D[1], 0) + (270, 180, 0)));
  }

  var_03 = spawnlinkedfx(common_scripts\utility::func_44F5("water_wake"), self, "tag_origin");
  var_04 = spawnlinkedfx(common_scripts\utility::func_44F5("water_wake_stationary"), self, "tag_origin");
  self.fxentwake = var_03;
  self.fxentstationary = var_04;
  thread inwaterwakevfxcleanup();
  triggerfx(var_03);
  triggerfx(var_04);
  var_05 = 0;
  var_06 = 4000;
  for(;;) {
    var_07 = self getvelocity();
    var_01 = distance(var_07, (0, 0, 0));
    if(var_01 > 0) {
      wait(max(1 - var_01 / 120, 0.1));
    } else {
      wait(0.3);
    }

    var_08 = func_471B(param_00) - self.var_0116[2];
    if(self getstance() == "prone" && var_08 > 24 == 0) {
      if(var_01 > 5) {
        triggerfx(var_03);
        continue;
      }

      triggerfx(var_04);
    }
  }
}

func_73F2() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  thread func_6B74();
  wait(13);
  for(;;) {
    if(!isDefined(self.var_5738) || self.var_5738 == 0) {
      self dodamage(20, self.var_0116 + anglesToForward(self.var_001D) * 5, undefined, undefined, "MOD_TRIGGER_HURT");
    }

    wait(1);
  }
}

func_6B74() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  self waittill("death");
  func_7320(0);
  self.var_A019 = undefined;
  self.var_542A = undefined;
  self method_86C7();
  self.var_57F2 = undefined;
  self.var_5849 = undefined;
  self.var_A95F = undefined;
  self.var_A01A = undefined;
  self.var_3997 = 0;
  self.var_3999 = 0;
}

func_53CA(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 32;
  }

  if(level func_471B(param_00) - self.var_0116[2] <= param_01) {
    return 1;
  }

  return 0;
}

func_565D(param_00, param_01) {
  if(func_4620() + param_01 >= level func_471B(param_00)) {
    return 1;
  }

  return 0;
}

func_4620() {
  var_00 = self getEye();
  self.var_3997 = var_00[2] - self.var_3999;
  self.var_3999 = var_00[2];
  return var_00[2];
}

func_471B(param_00) {
  var_01 = common_scripts\utility::func_46B5(param_00.var_01A2, "targetname");
  var_02 = var_01.var_0116[2];
  return var_02;
}

func_5728() {
  return isDefined(self.var_5378) && self.var_5378;
}

func_73DE(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("end_swimming");
  if(!isDefined(param_00)) {
    param_00 = "shallow";
  }

  if((param_00 == "shallow" && self hasweapon(level.var_8ACF)) || (param_00 == "deep" && self hasweapon(level.var_2B7C)) || isDefined(level.var_2F6B)) {
    self.var_3236 = 1;
  }

  switch (param_00) {
    case "deep":
      func_476D(level.var_2B7C);
      if(!func_5728()) {
        self switchtoweaponimmediate(level.var_2B7C);
      }

      self.var_A01A = "deep";
      break;

    case "shallow":
      func_476D(level.var_8ACF);
      if(!func_5728()) {
        self switchtoweaponimmediate(level.var_8ACF);
      }

      self.var_A01A = "shallow";
      break;

    case "none":
      self.var_A01A = "none";
      break;

    default:
      func_476D(level.var_8ACF);
      if(!func_5728()) {
        self switchtoweaponimmediate(level.var_8ACF);
      }

      self.var_A01A = "shallow";
      break;
  }

  self method_82CD();
  common_scripts\utility::func_0603();
  common_scripts\utility::func_0600();
}

func_73D6() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  if(isDefined(self.var_A01A)) {
    var_00 = self.var_A01A;
    self notify("end_swimming");
    self method_82CE();
    common_scripts\utility::func_0617();
    common_scripts\utility::func_0614();
    if(isDefined(self.var_5738) && self.var_5738 == 1 && isDefined(self.var_4C26)) {
      self method_812B(1);
      if(!isDefined(self.var_4C26.var_4B77) || self.var_4C26.var_4B77 == 0) {
        self method_8324();
      }

      if(!isDefined(self.var_4C26.var_4B8E) || self.var_4C26.var_4B8E == 0) {
        self method_84CB();
      } else {
        self method_84CC();
      }
    } else if(isDefined(self.var_A95F)) {
      if(!func_5728()) {
        maps\mp\_utility::func_955C(self.var_A95F);
      }
    }

    switch (var_00) {
      case "deep":
        func_95CF(level.var_2B7C);
        break;

      case "shallow":
        func_95CF(level.var_8ACF);
        break;

      case "none":
        break;

      default:
        func_95CF(level.var_8ACF);
        break;
    }

    self.var_A01A = undefined;
    self.var_3236 = undefined;
  }
}

func_476D(param_00) {
  if(!isDefined(self.var_3236) || !self.var_3236) {
    self giveweapon(param_00);
  }
}

func_95CF(param_00) {
  if(!isDefined(self.var_3236) || !self.var_3236) {
    self takeweapon(param_00);
  }
}

func_8720(param_00) {
  level.var_8ACF = param_00;
}

func_865D(param_00) {
  level.var_2B7C = param_00;
}

func_5840(param_00) {
  switch (param_00) {
    case "iw5_underwater_mp":
    case "boxing_gloves_mp":
    case "baseballbat_mp":
    case "trenchknife_mp":
    case "combatknife_mp":
    case "icepick_mp":
    case "shovel_mp":
    case "combatknife_zm":
    case "shovel_zm":
    case "none":
      return 1;

    default:
      return 0;
  }
}