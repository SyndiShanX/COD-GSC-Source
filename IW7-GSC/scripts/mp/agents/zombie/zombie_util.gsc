/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie\zombie_util.gsc
****************************************************/

func_38C2(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 6;
  }

  var_03 = (0, 0, 1) * param_02;
  var_04 = param_00 + var_03;
  var_05 = param_01 + var_03;
  return capsuletracepassed(var_04, self.fgetarg, self.height - param_02, self, 1, 0, 0, var_05);
}

allowmelee() {
  return 8;
}

func_7FA8() {
  return 360 / allowmelee();
}

func_B63F(param_00, param_01, param_02) {
  var_03 = param_01 * func_7FA8() - 180;
  var_04 = param_00 + anglesToForward((0, var_03, 0)) * param_02;
  return var_04;
}

func_7FB0(param_00) {
  return self.var_B63E[param_00];
}

func_13141(param_00) {
  if(!isDefined(self.var_B63E)) {
    self.var_B63E = [];
  }

  if(!isDefined(self.var_B63E[param_00])) {
    self.var_B63E[param_00] = [];
    for(var_01 = 0; var_01 < allowmelee(); var_01++) {
      self.var_B63E[param_00][var_01] = spawnStruct();
      self.var_B63E[param_00][var_01].var_11931 = 0;
      self.var_B63E[param_00][var_01].var_3FF6 = undefined;
      self.var_B63E[param_00][var_01].origin = undefined;
      self.var_B63E[param_00][var_01].var_C1D5 = var_01;
    }
  }
}

blendlinktoplayerviewmotion(param_00) {
  var_01 = param_00.origin;
  if(isDefined(param_00.var_864C)) {
    var_01 = param_00.var_864C;
    if(isDefined(self.var_5719) && param_00 == self.var_5719 && func_8BDA()) {
      var_02 = func_7FDE();
      if(isDefined(var_02)) {
        var_01 = var_02.origin;
      }
    }
  } else if(isplayer(param_00) && param_00 isjumping() || param_00 ishighjumping()) {
    if(!isDefined(param_00.var_D399)) {
      param_00.var_D399 = 0;
    }

    if(gettime() > param_00.var_D399) {
      param_00.var_D398 = getgroundposition(param_00.origin, 15);
      param_00.var_D399 = gettime();
    }

    if(isDefined(param_00.var_D398)) {
      var_01 = param_00.var_D398;
    }
  }

  return var_01;
}

func_8C39(param_00, param_01) {
  for(var_02 = 0; var_02 < allowmelee(); var_02++) {
    var_03 = param_00 func_7FB0(param_01);
    var_04 = var_03[var_02];
    if(isDefined(var_04.origin)) {
      return 1;
    }
  }

  return 0;
}

func_3717() {
  var_00 = self getnearestnode();
}

func_8BDA() {
  var_00 = self getnearestnode();
  if(isDefined(var_00) && isDefined(self.var_5719.var_BE81)) {
    var_01 = self.var_5719.var_BE81["0"];
    if(isDefined(var_01)) {
      return 1;
    }
  }

  return 0;
}

func_7FDE() {
  var_00 = self getnearestnode();
  var_01 = self.var_5719.var_BE81["0"];
  if(!isnumber(var_01)) {
    return var_01;
  }

  return undefined;
}

func_100AB() {
  if(func_8BDA()) {
    var_00 = func_7FDE();
    if(!isDefined(var_00)) {
      return 0;
    }
  }

  return 1;
}

func_9DE1(param_00) {
  if(isDefined(self.var_5719) && param_00 == self.var_5719) {
    if(self.var_571A > 5) {
      return 1;
    }
  }

  return 0;
}

func_7FB1(param_00, param_01) {
  param_00 func_13141(self.var_B640);
  var_02 = param_00 func_7FB0(self.var_B640);
  var_03 = param_01;
  var_04 = self.origin - var_03;
  var_05 = lengthsquared(var_04);
  if(var_05 < 256) {
    var_06 = -1;
    for(var_07 = 0; var_07 < allowmelee(); var_07++) {
      var_08 = var_02[var_07];
      if(isDefined(var_08.var_3FF6) && var_08.var_3FF6 == self) {
        var_06 = var_08.var_C1D5;
      }
    }

    if(var_06 < 0) {
      var_06 = self getentitynumber() % allowmelee();
    }

    var_09 = var_06;
  } else {
    var_0A = angleclamp180(vectortoyaw(var_06)) + 180;
    var_09 = var_0A / func_7FA8();
    var_06 = int(var_09 + 0.5);
  }

  var_0B = undefined;
  var_0C = -1;
  var_0D = 3;
  var_0E = 2;
  if(var_09 > var_06) {
    var_0C = var_0C * -1;
    var_0D = var_0D * -1;
    var_0E = var_0E * -1;
  }

  var_0F = allowmelee();
  for(var_10 = 0; var_10 < var_0F / 2 + 1; var_10++) {
    for(var_11 = var_0C; var_11 != var_0D; var_11 = var_11 + var_0E) {
      var_12 = var_06 + var_10 * var_11;
      if(var_12 >= var_0F) {
        var_12 = var_12 - var_0F;
      } else if(var_12 < 0) {
        var_12 = var_12 + var_0F;
      }

      var_08 = var_02[var_12];
      if(!isDefined(var_0B) && gettime() - var_08.var_11931 >= self.var_B641) {
        if(isDefined(level.var_12892) && isDefined(level.var_12892[self.agent_type])) {
          [
            [level.var_12892[self.agent_type]]
          ](var_08, var_03, self.var_252B, self.fgetarg);
        } else {
          func_12892(var_08, var_03, self.var_252B, self.fgetarg);
        }
      }

      if(!isDefined(var_0B) && isDefined(var_08.origin)) {
        var_13 = getclosestpointonnavmesh(param_00.origin, self);
        var_14 = navtrace(var_08.origin, var_13, self, 1);
        if(var_14["fraction"] < 0.95) {
          continue;
        }

        var_15 = 0;
        if(isDefined(var_08.var_3FF6) && var_08.var_3FF6 != self) {
          var_16 = vectornormalize(var_03 - var_08.var_3FF6.origin) * self.fgetarg * 2;
          var_15 = distancesquared(var_08.var_3FF6.origin + var_16, var_03);
        }

        if(!isalive(var_08.var_3FF6) || !isDefined(var_08.var_3FF6.curmeleetarget) || var_08.var_3FF6.curmeleetarget != param_00 || var_08.var_3FF6 == self || var_05 < var_15) {
          if(isalive(var_08.var_3FF6) && var_08.var_3FF6 != self) {
            var_08.var_3FF6 notify("lostSectorClaim");
            var_08.var_3FF6.var_F0D4 = undefined;
          }

          if(isDefined(self.var_F0D4) && self.var_F0D4 != var_08) {
            self.var_F0D4.var_3FF6 = undefined;
          }

          self.var_F0D4 = var_08;
          var_08.var_3FF6 = self;
          var_0B = var_08.origin;
          thread func_BA13(var_08);
        }
      }

      if(var_10 == 0) {
        break;
      }
    }
  }

  return var_0B;
}

func_BA13(param_00) {
  level endon("game_ended");
  self notify("monitorSectorClaim");
  self endon("monitorSectorClaim");
  self endon("lostSectorClaim");
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  param_00.var_3FF6 = undefined;
}

func_12892(param_00, param_01, param_02, param_03) {
  if(gettime() - param_00.var_11931 >= 50) {
    param_00.origin = func_B63F(param_01, param_00.var_C1D5, param_02);
    param_00.origin = func_5D54(param_00.origin, param_03, 55);
    param_00.var_11931 = gettime();
  }
}

func_5D54(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 18;
  }

  var_04 = param_00 + (0, 0, param_03);
  var_05 = param_00 + (0, 0, param_03 * -1);
  var_06 = self aiphysicstrace(var_04, var_05, param_01, param_02, 1);
  if(abs(var_06[2] - var_04[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_06[2] - var_05[2]) < 0.1) {
    return undefined;
  }

  return var_06;
}

iscrawling() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

func_7FAE() {
  if(!isDefined(self.var_B104) || self.var_B104) {
    return self.var_B62D;
  }

  return self.var_B62E;
}

func_7FAF() {
  if(!isDefined(self.var_B104) || self.var_B104) {
    return self.var_B630;
  }

  return self.meleeradiusbasesq;
}

func_B106(param_00, param_01, param_02, param_03, param_04, param_05) {
  self.var_B0FE = param_00 * 1000;
  self.var_B0FF = param_03;
  self.var_B0FC = isDefined(param_04) && param_04;
  self.var_B101 = param_05;
  self.var_B107 = param_02;
  self.var_B108 = squared(self.var_B107);
  func_F794(param_01);
}

func_B103() {
  if(isDefined(self.var_55D3) && self.var_55D3 > 0) {
    self.var_55D3--;
    if(self.var_55D3 > 0) {
      return;
    }
  }

  self.var_B104 = 1;
}

func_B102() {
  if(!isDefined(self.var_55D3)) {
    self.var_55D3 = 0;
  }

  self.var_55D3++;
  self.var_B104 = 0;
}

func_5811(param_00, param_01, param_02, param_03) {
  self.var_5803 = param_00 * 1000;
  self.var_5801 = param_01;
  self.var_5800 = param_02;
  self.var_57FE = ["back", "right", "left"];
  self.var_57FF = [];
  foreach(var_06, var_05 in self.var_57FE) {
    self.var_57FF[var_06] = level._effect[param_03 + var_05];
  }
}

func_5807() {
  if(isDefined(self.var_55C5) && self.var_55C5 > 0) {
    self.var_55C5--;
    if(self.var_55C5 > 0) {
      return;
    }
  }

  self.var_5808 = 1;
}

func_5806() {
  if(!isDefined(self.var_55C5)) {
    self.var_55C5 = 0;
  }

  self.var_55C5++;
  self.var_5808 = 0;
}

func_AB05(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self.var_AAF8 = param_00 * 1000;
  self.var_AAF7 = param_01 * 1000;
  self.var_AAF6 = param_02;
  self.var_AB01 = param_03;
  self.var_AB02 = squared(self.var_AB01);
  self.var_AB03 = param_04;
  self.var_AB04 = squared(self.var_AB03);
  self.var_AAFE = param_06;
  self.var_AAF5 = param_05;
  self.var_AAFF = 0;
  self.var_AB00 = 0;
}

func_AAFA() {
  if(isDefined(self.var_55D2) && self.var_55D2 > 0) {
    self.var_55D2--;
    if(self.var_55D2 > 0) {
      return;
    }
  }

  self.var_AAFB = 1;
}

func_AAF9() {
  if(!isDefined(self.var_55D2)) {
    self.var_55D2 = 0;
  }

  self.var_55D2++;
  self.var_AAFB = 0;
}

func_3C52(param_00, param_01) {
  self endon("death");
  self scragentsetscripted(1);
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "ChangeAnimClass");
  self.inplayerportableradar = 1;
  self orientmode("face angle abs", (0, self.angles[1], 0));
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::func_CED6(param_01, randomint(self getanimentrycount(param_01)), "change_anim_class");
  self _meth_82A3(param_00);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "ChangeAnimClass");
  self.inplayerportableradar = 0;
  self scragentsetscripted(0);
}

missile_setflightmodetop(param_00) {
  var_01 = 50;
  var_02 = 32;
  var_03 = 72;
  var_04 = getmovedelta(param_00);
  var_04 = rotatevector(var_04, self.angles);
  var_05 = self.origin + var_04;
  var_06 = (0, 0, var_01);
  var_07 = self aiphysicstrace(var_05 + var_06, var_05 - var_06, var_02, var_03);
  var_08 = var_07 - var_05;
  return var_08[2];
}

_meth_8088(param_00, param_01, param_02, param_03) {
  var_04 = getanimlength(param_00);
  var_05 = getmovedelta(param_00, 0, param_03 / var_04);
  var_06 = rotatevector(var_05, param_02);
  return param_01 + var_06;
}

func_7F66(param_00) {
  var_01 = 0.2;
  var_02 = getanimlength(param_00);
  return min(var_01, var_02);
}

func_CA1D(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  self ghostexplode(self.origin, param_00, param_01);
  wait(param_01);
  self ghostlaunched("anim deltas");
}

botmemoryevent(param_00, param_01) {
  var_02 = 0;
  if(param_01 > 1) {
    var_03 = int(param_01 * 0.5);
    var_04 = var_03 + param_01 % 2;
    if(param_00 < 0) {
      var_02 = randomint(var_04);
    } else {
      var_02 = var_03 + randomint(var_04);
    }
  }

  return var_02;
}

func_9DE0(param_00) {
  var_01 = self.origin[2] + self.height;
  if(param_00.origin[2] < var_01) {
    return 0;
  }

  var_02 = self.origin[2] + self.height + 2 * self.fgetarg;
  if(param_00.origin[2] > var_02) {
    return 0;
  }

  if(isplayer(param_00)) {
    var_03 = param_00 getvelocity()[2];
    if(abs(var_03) > 12) {
      return 0;
    }
  }

  var_04 = 15;
  if(isDefined(param_00.fgetarg)) {
    var_04 = param_00.fgetarg;
  }

  var_05 = self.fgetarg + var_04;
  var_05 = var_05 * var_05;
  if(distance2dsquared(self.origin, param_00.origin) > var_05) {
    return 0;
  }

  return 1;
}

func_F702(param_00) {
  self.loadstartpointtransients = param_00;
}

func_4D52(param_00, param_01) {
  var_02 = 0;
  if(isDefined(param_00)) {
    var_03 = param_00 - self gettagorigin("J_SpineLower");
    var_03 = (var_03[0], var_03[1], 0);
    var_04 = vectortoangles(vectornormalize(var_03));
    var_02 = var_04[1];
  } else if(isDefined(param_01)) {
    var_04 = vectortoangles(param_01);
    var_02 = var_04[1] - 180;
  }

  return var_02;
}

func_5539() {
  if(!isDefined(self.var_55CC)) {
    self.var_55CC = 0;
  }

  self.var_55CC++;
  func_553A();
  func_553B();
}

func_8B84() {
  return scripts\engine\utility::istrue(self.var_8C00);
}

func_6202() {
  if(isDefined(level.disable_zombie_exo_abilities) && level.disable_zombie_exo_abilities) {
    return;
  }

  if(isDefined(self.var_55CC) && self.var_55CC > 0) {
    self.var_55CC--;
    if(self.var_55CC > 0) {
      return;
    }
  }

  self.var_8C00 = 1;
  func_6204();
  func_F9A2();
  func_6203();
}

func_6204() {}

func_553B() {}

func_F9A2() {
  var_00 = clamp(level.var_13BDC / 20, 0, 1);
  var_01 = func_AB6F(var_00, 0.35, 0.55);
  var_02 = func_AB6F(var_00, 0.06, 0.12);
  func_B106(5, self.var_B62E * 2, self.var_B62E * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  func_5811(5, var_01, "dodge_boost", "boost_dodge_");
  func_AB05(10, 2, var_02, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

func_6203() {
  func_B103();
  func_5807();
  func_AAFA();
}

func_AB6F(param_00, param_01, param_02) {
  var_03 = param_02 - param_01;
  var_04 = param_00 * var_03;
  var_05 = param_01 + var_04;
  return var_05;
}

func_553A() {
  func_B102();
  func_5806();
  func_AAF9();
}

func_CCAB(param_00) {
  if(!isDefined(self.var_2CCC)) {
    return;
  }

  if(self.var_2CCC != "no_boost_fx") {
    playFXOnTag(param_00, self, self.var_2CCC);
  }
}

player_in_laststand(param_00) {
  return param_00.inlaststand;
}

func_6CA8(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(player_in_laststand(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  var_05 = [];
  foreach(var_07 in param_00) {
    if(func_C04C(var_07)) {
      continue;
    }

    var_08 = 0;
    foreach(var_03 in var_01) {
      if(distancesquared(var_07.origin, var_03.origin) < 65536) {
        var_08 = 1;
        break;
      }
    }

    if(var_08) {
      continue;
    }

    var_05[var_05.size] = var_07;
  }

  return var_05;
}

func_13D9C() {
  var_00 = self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh;
  return distancesquared(self.origin, self.curmeleetarget.origin) <= var_00;
}

func_13D9A() {
  if(func_7FAE() == self.var_B62E) {
    return func_13D9B();
  }

  var_00 = distancesquared(self.origin, self.curmeleetarget.origin) <= func_7FAF();
  return var_00;
}

func_13D9B() {
  var_00 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq;
  if(!var_00 && isplayer(self.curmeleetarget) || isagent(self.curmeleetarget)) {
    var_01 = undefined;
    var_01 = self.curmeleetarget _meth_845B();
    if(isDefined(var_01) && isDefined(var_01.var_336) && var_01.var_336 == "care_package") {
      var_00 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  if(!var_00 && isplayer(self.curmeleetarget) && scripts\engine\utility::istrue(self.curmeleetarget.var_9E46)) {
    if(length(self getvelocity()) < 5) {
      var_00 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  return var_00;
}

func_F794(param_00) {
  self.var_B62D = param_00;
  self.var_B630 = param_00 * param_00;
}

func_C04C(param_00) {
  return !isDefined(param_00.var_13FAA);
}

_meth_8252() {
  return level.zombiedlclevel;
}

func_136AA() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("bad_path");
    self.var_2AB8 = 1;
    if(isDefined(self.var_5719)) {
      self.var_571A++;
    }
  }
}

func_8B76() {
  return 1;
}

func_54BF() {
  if(isDefined(self.var_A9B7) && isDefined(self.var_A9B6) && distance2dsquared(self.curmeleetarget.origin, self.var_A9B7) < 4 && distancesquared(self.origin, self.var_A9B6) < 2500) {
    return 1;
  }

  return 0;
}

func_54BE() {
  if(isDefined(self.var_A9B4) && isDefined(self.var_A9B3) && distance2dsquared(self.curmeleetarget.origin, self.var_A9B4) < 4 && distancesquared(self.origin, self.var_A9B3) < 2500) {
    return 1;
  }

  return 0;
}

func_A00D(param_00) {
  var_01 = 0;
  var_02 = param_00[2] - self.origin[2];
  var_01 = var_02 <= self.var_2539 && var_02 >= self.var_253A;
  if(!var_01 && isplayer(self.curmeleetarget) && scripts\engine\utility::istrue(self.curmeleetarget.var_9E46)) {
    if(length(self getvelocity()) < 5) {
      var_01 = var_02 <= self.var_2539 * 2 && var_02 >= self.var_253A;
    }
  }

  return var_01;
}

func_138E7() {
  if(func_9DE0(self.curmeleetarget)) {
    return 0;
  }

  return !func_A00D(self.curmeleetarget.origin) && distance2dsquared(self.origin, self.curmeleetarget.origin) < func_7FAF() * 0.75 * 0.75;
}

func_9E97() {
  if(isDefined(level.ismeleeblocked_func)) {
    return [[level.ismeleeblocked_func]]();
  }

  return ismeleeblocked_default();
}

ismeleeblocked_default() {
  var_00 = self.origin + (0, 0, self.var_B5F9);
  var_01 = self.curmeleetarget.origin + (0, 0, self.var_B5F9);
  if(!isplayer(self.curmeleetarget) && !isai(self.curmeleetarget)) {
    return 0;
  }

  if(isplayer(self.curmeleetarget)) {
    if(self.curmeleetarget isusingturret()) {
      return 0;
    }
  }

  var_02 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  if(scripts\common\trace::ray_trace_passed(var_00, var_01, self.curmeleetarget, var_02)) {
    return 0;
  }

  return 1;
}

isreallyalive(param_00) {
  if(isalive(param_00) && !isDefined(param_00.fauxdeath)) {
    return 1;
  }

  return 0;
}

func_DD7C(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(self.curmeleetarget)) {
    return 0;
  }

  if(!isreallyalive(self.curmeleetarget)) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(!func_9DE0(self.curmeleetarget)) {
    if(!func_A00D(self.curmeleetarget.origin)) {
      return 0;
    }

    if(param_00 == "offmesh" && !func_13D9C()) {
      return 0;
    }

    if(param_00 == "normal" && !func_13D9A()) {
      return 0;
    } else if(param_00 == "base" && !func_13D9B()) {
      return 0;
    }
  }

  if(param_01 && func_9E97()) {
    return 0;
  }

  return 1;
}

func_7FAA(param_00) {
  if(!isDefined(self.var_B5E0)) {
    self.var_B5E0 = spawnStruct();
  }

  if(func_9DE1(param_00) && !func_8BDA()) {
    func_3717();
  }

  var_01 = blendlinktoplayerviewmotion(param_00);
  self.var_B5E0.var_656D = var_01;
  var_02 = func_7FB1(param_00, var_01);
  if(isDefined(var_02)) {
    self.var_B5E0.var_1312B = 1;
    self.var_B5E0.origin = var_02;
  } else {
    self.var_B5E0.var_1312B = 0;
    self.var_B5E0.origin = var_01;
    if(isDefined(self.var_5719)) {
      if(!isDefined(func_5D54(self.var_B5E0.origin, 15, 55))) {
        if(!isDefined(self.var_DC9A)) {
          self.var_DC9A = [];
          for(var_03 = 0; var_03 < allowmelee(); var_03++) {
            self.var_DC9A[self.var_DC9A.size] = var_03;
          }

          self.var_DC9A = scripts\engine\utility::array_randomize(self.var_DC9A);
        }

        foreach(var_05 in self.var_DC9A) {
          var_06 = param_00 func_7FB0(self.var_B640);
          var_07 = var_06[var_05];
          if(isDefined(var_07.origin)) {
            self.var_B5E0.origin = var_07.origin;
            break;
          }
        }
      }
    }
  }

  return self.var_B5E0;
}

shouldignoreent(param_00) {
  if(scripts\engine\utility::istrue(player_in_laststand(param_00))) {
    return 1;
  }

  if(isDefined(param_00.team) && isDefined(self.team) && self.team == param_00.team) {
    return 1;
  }

  if(isplayerteleporting(param_00)) {
    return 1;
  }

  if(isDefined(level.killingtimevalidationcheck)) {
    if(![
        [level.killingtimevalidationcheck]
      ](self, param_00)) {
      return 0;
    }
  }

  if(isDefined(param_00.killing_time)) {
    return 1;
  }

  if(isDefined(level.var_1002D)) {
    if([
        [level.var_1002D]
      ](param_00)) {
      return 1;
    }
  }

  return 0;
}

isplayerteleporting(param_00) {
  return isDefined(param_00.var_9987) && param_00.var_9987;
}

func_38D1(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 6;
  }

  var_03 = (0, 0, 1) * param_02;
  var_04 = param_00 + var_03;
  var_05 = param_01 + var_03;
  return capsuletracepassed(var_04, self.fgetarg, self.height - param_02, self, 1, 0, 0, var_05);
}

func_7E79() {
  if(scripts\mp\agents\zombie\zmb_zombie_agent::func_3DE4("exo")) {
    return "dismemberExoSound";
  }

  return "dismemberSound";
}

func_7E59(param_00, param_01) {
  var_02 = self.agent_type;
  var_03 = level.var_1BA4[var_02].var_2552["heavy_damage_threshold"];
  if(param_00 < var_03 && !param_01) {
    return "light";
  }

  return "heavy";
}

func_4E0C(param_00) {
  return level.var_1BBA.var_4E2D["hitLoc"][param_00];
}

func_4E0D(param_00) {
  var_01 = scripts\mp\agents\_scriptedagents::func_7DBD(param_00);
  return level.var_1BBA.var_4E2D["hitDirection"][var_01];
}

botnodepickmultiple(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02)) {
    var_04 = param_03[param_00][param_01][param_02];
  } else {
    var_04 = var_04[param_01][param_02];
  }

  return var_04[randomint(var_04.size)];
}