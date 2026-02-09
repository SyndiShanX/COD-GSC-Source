/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie\zombie_util.gsc
****************************************************/

func_38C2(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.fgetarg, self.height - var_2, self, 1, 0, 0, var_5);
}

allowmelee() {
  return 8;
}

func_7FA8() {
  return 360 / allowmelee();
}

func_B63F(var_0, var_1, var_2) {
  var_3 = var_1 * func_7FA8() - 180;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

func_7FB0(var_0) {
  return self.var_B63E[var_0];
}

func_13141(var_0) {
  if(!isDefined(self.var_B63E)) {
    self.var_B63E = [];
  }

  if(!isDefined(self.var_B63E[var_0])) {
    self.var_B63E[var_0] = [];
    for(var_1 = 0; var_1 < allowmelee(); var_1++) {
      self.var_B63E[var_0][var_1] = spawnStruct();
      self.var_B63E[var_0][var_1].var_11931 = 0;
      self.var_B63E[var_0][var_1].var_3FF6 = undefined;
      self.var_B63E[var_0][var_1].origin = undefined;
      self.var_B63E[var_0][var_1].var_C1D5 = var_1;
    }
  }
}

blendlinktoplayerviewmotion(var_0) {
  var_1 = var_0.origin;
  if(isDefined(var_0.var_864C)) {
    var_1 = var_0.var_864C;
    if(isDefined(self.var_5719) && var_0 == self.var_5719 && func_8BDA()) {
      var_2 = func_7FDE();
      if(isDefined(var_2)) {
        var_1 = var_2.origin;
      }
    }
  } else if(isPlayer(var_0) && var_0 isjumping() || var_0 ishighjumping()) {
    if(!isDefined(var_0.var_D399)) {
      var_0.var_D399 = 0;
    }

    if(gettime() > var_0.var_D399) {
      var_0.var_D398 = getgroundposition(var_0.origin, 15);
      var_0.var_D399 = gettime();
    }

    if(isDefined(var_0.var_D398)) {
      var_1 = var_0.var_D398;
    }
  }

  return var_1;
}

func_8C39(var_0, var_1) {
  for(var_2 = 0; var_2 < allowmelee(); var_2++) {
    var_3 = var_0 func_7FB0(var_1);
    var_4 = var_3[var_2];
    if(isDefined(var_4.origin)) {
      return 1;
    }
  }

  return 0;
}

func_3717() {
  var_0 = self getnearestnode();
}

func_8BDA() {
  var_0 = self getnearestnode();
  if(isDefined(var_0) && isDefined(self.var_5719.var_BE81)) {
    var_1 = self.var_5719.var_BE81["0"];
    if(isDefined(var_1)) {
      return 1;
    }
  }

  return 0;
}

func_7FDE() {
  var_0 = self getnearestnode();
  var_1 = self.var_5719.var_BE81["0"];
  if(!isnumber(var_1)) {
    return var_1;
  }

  return undefined;
}

func_100AB() {
  if(func_8BDA()) {
    var_0 = func_7FDE();
    if(!isDefined(var_0)) {
      return 0;
    }
  }

  return 1;
}

func_9DE1(var_0) {
  if(isDefined(self.var_5719) && var_0 == self.var_5719) {
    if(self.var_571A > 5) {
      return 1;
    }
  }

  return 0;
}

func_7FB1(var_0, var_1) {
  var_0 func_13141(self.var_B640);
  var_2 = var_0 func_7FB0(self.var_B640);
  var_3 = var_1;
  var_4 = self.origin - var_3;
  var_5 = lengthsquared(var_4);
  if(var_5 < 256) {
    var_6 = -1;
    for(var_7 = 0; var_7 < allowmelee(); var_7++) {
      var_8 = var_2[var_7];
      if(isDefined(var_8.var_3FF6) && var_8.var_3FF6 == self) {
        var_6 = var_8.var_C1D5;
      }
    }

    if(var_6 < 0) {
      var_6 = self getentitynumber() % allowmelee();
    }

    var_9 = var_6;
  } else {
    var_10 = angleclamp180(vectortoyaw(var_6)) + 180;
    var_9 = var_10 / func_7FA8();
    var_6 = int(var_9 + 0.5);
  }

  var_11 = undefined;
  var_12 = -1;
  var_13 = 3;
  var_14 = 2;
  if(var_9 > var_6) {
    var_12 = var_12 * -1;
    var_13 = var_13 * -1;
    var_14 = var_14 * -1;
  }

  var_15 = allowmelee();
  for(var_10 = 0; var_10 < var_15 / 2 + 1; var_10++) {
    for(var_11 = var_12; var_11 != var_13; var_11 = var_11 + var_14) {
      var_12 = var_6 + var_10 * var_11;
      if(var_12 >= var_15) {
        var_12 = var_12 - var_15;
      } else if(var_12 < 0) {
        var_12 = var_12 + var_15;
      }

      var_8 = var_2[var_12];
      if(!isDefined(var_11) && gettime() - var_8.var_11931 >= self.var_B641) {
        if(isDefined(level.var_12892) && isDefined(level.var_12892[self.agent_type])) {
          [[level.var_12892[self.agent_type]]](var_8, var_3, self.var_252B, self.fgetarg);
        } else {
          func_12892(var_8, var_3, self.var_252B, self.fgetarg);
        }
      }

      if(!isDefined(var_11) && isDefined(var_8.origin)) {
        var_13 = getclosestpointonnavmesh(var_0.origin, self);
        var_14 = navtrace(var_8.origin, var_13, self, 1);
        if(var_14["fraction"] < 0.95) {
          continue;
        }

        var_15 = 0;
        if(isDefined(var_8.var_3FF6) && var_8.var_3FF6 != self) {
          var_16 = vectornormalize(var_3 - var_8.var_3FF6.origin) * self.fgetarg * 2;
          var_15 = distancesquared(var_8.var_3FF6.origin + var_16, var_3);
        }

        if(!isalive(var_8.var_3FF6) || !isDefined(var_8.var_3FF6.curmeleetarget) || var_8.var_3FF6.curmeleetarget != var_0 || var_8.var_3FF6 == self || var_5 < var_15) {
          if(isalive(var_8.var_3FF6) && var_8.var_3FF6 != self) {
            var_8.var_3FF6 notify("lostSectorClaim");
            var_8.var_3FF6.var_F0D4 = undefined;
          }

          if(isDefined(self.var_F0D4) && self.var_F0D4 != var_8) {
            self.var_F0D4.var_3FF6 = undefined;
          }

          self.var_F0D4 = var_8;
          var_8.var_3FF6 = self;
          var_11 = var_8.origin;
          thread func_BA13(var_8);
        }
      }

      if(var_10 == 0) {
        break;
      }
    }
  }

  return var_11;
}

func_BA13(var_0) {
  level endon("game_ended");
  self notify("monitorSectorClaim");
  self endon("monitorSectorClaim");
  self endon("lostSectorClaim");
  scripts\engine\utility::waittill_any("death", "disconnect");
  var_0.var_3FF6 = undefined;
}

func_12892(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0.var_11931 >= 50) {
    var_0.origin = func_B63F(var_1, var_0.var_C1D5, var_2);
    var_0.origin = func_5D54(var_0.origin, var_3, 55);
    var_0.var_11931 = gettime();
  }
}

func_5D54(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 18;
  }

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, var_1, var_2, 1);
  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
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

func_B106(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.var_B0FE = var_0 * 1000;
  self.var_B0FF = var_3;
  self.var_B0FC = isDefined(var_4) && var_4;
  self.var_B101 = var_5;
  self.var_B107 = var_2;
  self.var_B108 = squared(self.var_B107);
  func_F794(var_1);
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

func_5811(var_0, var_1, var_2, var_3) {
  self.var_5803 = var_0 * 1000;
  self.var_5801 = var_1;
  self.var_5800 = var_2;
  self.var_57FE = ["back", "right", "left"];
  self.var_57FF = [];
  foreach(var_6, var_5 in self.var_57FE) {
    self.var_57FF[var_6] = level._effect[var_3 + var_5];
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

func_AB05(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.var_AAF8 = var_0 * 1000;
  self.var_AAF7 = var_1 * 1000;
  self.var_AAF6 = var_2;
  self.var_AB01 = var_3;
  self.var_AB02 = squared(self.var_AB01);
  self.var_AB03 = var_4;
  self.var_AB04 = squared(self.var_AB03);
  self.var_AAFE = var_6;
  self.var_AAF5 = var_5;
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

func_3C52(var_0, var_1) {
  self endon("death");
  self scragentsetscripted(1);
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "ChangeAnimClass");
  self.inplayerportableradar = 1;
  self orientmode("face angle abs", (0, self.angles[1], 0));
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::func_CED6(var_1, randomint(self getanimentrycount(var_1)), "change_anim_class");
  self func_82A3(var_0);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "ChangeAnimClass");
  self.inplayerportableradar = 0;
  self scragentsetscripted(0);
}

missile_setflightmodetop(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = getmovedelta(var_0);
  var_4 = rotatevector(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self aiphysicstrace(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

func_8088(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_0);
  var_5 = getmovedelta(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

func_7F66(var_0) {
  var_1 = 0.2;
  var_2 = getanimlength(var_0);
  return min(var_1, var_2);
}

func_CA1D(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self ghostexplode(self.origin, var_0, var_1);
  wait(var_1);
  self ghostlaunched("anim deltas");
}

botmemoryevent(var_0, var_1) {
  var_2 = 0;
  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;
    if(var_0 < 0) {
      var_2 = randomint(var_4);
    } else {
      var_2 = var_3 + randomint(var_4);
    }
  }

  return var_2;
}

func_9DE0(var_0) {
  var_1 = self.origin[2] + self.height;
  if(var_0.origin[2] < var_1) {
    return 0;
  }

  var_2 = self.origin[2] + self.height + 2 * self.fgetarg;
  if(var_0.origin[2] > var_2) {
    return 0;
  }

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];
    if(abs(var_3) > 12) {
      return 0;
    }
  }

  var_4 = 15;
  if(isDefined(var_0.fgetarg)) {
    var_4 = var_0.fgetarg;
  }

  var_5 = self.fgetarg + var_4;
  var_5 = var_5 * var_5;
  if(distance2dsquared(self.origin, var_0.origin) > var_5) {
    return 0;
  }

  return 1;
}

func_F702(var_0) {
  self.loadstartpointtransients = var_0;
}

func_4D52(var_0, var_1) {
  var_2 = 0;
  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectornormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
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
  var_0 = clamp(level.var_13BDC / 20, 0, 1);
  var_1 = func_AB6F(var_0, 0.35, 0.55);
  var_2 = func_AB6F(var_0, 0.06, 0.12);
  func_B106(5, self.var_B62E * 2, self.var_B62E * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  func_5811(5, var_1, "dodge_boost", "boost_dodge_");
  func_AB05(10, 2, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

func_6203() {
  func_B103();
  func_5807();
  func_AAFA();
}

func_AB6F(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

func_553A() {
  func_B102();
  func_5806();
  func_AAF9();
}

func_CCAB(var_0) {
  if(!isDefined(self.var_2CCC)) {
    return;
  }

  if(self.var_2CCC != "no_boost_fx") {
    playFXOnTag(var_0, self, self.var_2CCC);
  }
}

player_in_laststand(var_0) {
  return var_0.inlaststand;
}

func_6CA8(var_0) {
  var_1 = [];
  foreach(var_3 in level.players) {
    if(player_in_laststand(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = [];
  foreach(var_7 in var_0) {
    if(func_C04C(var_7)) {
      continue;
    }

    var_8 = 0;
    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }

    var_5[var_5.size] = var_7;
  }

  return var_5;
}

func_13D9C() {
  var_0 = self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh;
  return distancesquared(self.origin, self.curmeleetarget.origin) <= var_0;
}

func_13D9A() {
  if(func_7FAE() == self.var_B62E) {
    return func_13D9B();
  }

  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= func_7FAF();
  return var_0;
}

func_13D9B() {
  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq;
  if(!var_0 && isPlayer(self.curmeleetarget) || isagent(self.curmeleetarget)) {
    var_1 = undefined;
    var_1 = self.curmeleetarget func_845B();
    if(isDefined(var_1) && isDefined(var_1.var_336) && var_1.var_336 == "care_package") {
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  if(!var_0 && isPlayer(self.curmeleetarget) && scripts\engine\utility::istrue(self.curmeleetarget.var_9E46)) {
    if(length(self getvelocity()) < 5) {
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  return var_0;
}

func_F794(var_0) {
  self.var_B62D = var_0;
  self.var_B630 = var_0 * var_0;
}

func_C04C(var_0) {
  return !isDefined(var_0.var_13FAA);
}

func_8252() {
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

func_A00D(var_0) {
  var_1 = 0;
  var_2 = var_0[2] - self.origin[2];
  var_1 = var_2 <= self.var_2539 && var_2 >= self.var_253A;
  if(!var_1 && isPlayer(self.curmeleetarget) && scripts\engine\utility::istrue(self.curmeleetarget.var_9E46)) {
    if(length(self getvelocity()) < 5) {
      var_1 = var_2 <= self.var_2539 * 2 && var_2 >= self.var_253A;
    }
  }

  return var_1;
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
  var_0 = self.origin + (0, 0, self.var_B5F9);
  var_1 = self.curmeleetarget.origin + (0, 0, self.var_B5F9);
  if(!isPlayer(self.curmeleetarget) && !isai(self.curmeleetarget)) {
    return 0;
  }

  if(isPlayer(self.curmeleetarget)) {
    if(self.curmeleetarget isusingturret()) {
      return 0;
    }
  }

  var_2 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  if(scripts\common\trace::ray_trace_passed(var_0, var_1, self.curmeleetarget, var_2)) {
    return 0;
  }

  return 1;
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdeath)) {
    return 1;
  }

  return 0;
}

func_DD7C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
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

    if(var_0 == "offmesh" && !func_13D9C()) {
      return 0;
    }

    if(var_0 == "normal" && !func_13D9A()) {
      return 0;
    } else if(var_0 == "base" && !func_13D9B()) {
      return 0;
    }
  }

  if(var_1 && func_9E97()) {
    return 0;
  }

  return 1;
}

func_7FAA(var_0) {
  if(!isDefined(self.var_B5E0)) {
    self.var_B5E0 = spawnStruct();
  }

  if(func_9DE1(var_0) && !func_8BDA()) {
    func_3717();
  }

  var_1 = blendlinktoplayerviewmotion(var_0);
  self.var_B5E0.var_656D = var_1;
  var_2 = func_7FB1(var_0, var_1);
  if(isDefined(var_2)) {
    self.var_B5E0.var_1312B = 1;
    self.var_B5E0.origin = var_2;
  } else {
    self.var_B5E0.var_1312B = 0;
    self.var_B5E0.origin = var_1;
    if(isDefined(self.var_5719)) {
      if(!isDefined(func_5D54(self.var_B5E0.origin, 15, 55))) {
        if(!isDefined(self.var_DC9A)) {
          self.var_DC9A = [];
          for(var_3 = 0; var_3 < allowmelee(); var_3++) {
            self.var_DC9A[self.var_DC9A.size] = var_3;
          }

          self.var_DC9A = scripts\engine\utility::array_randomize(self.var_DC9A);
        }

        foreach(var_5 in self.var_DC9A) {
          var_6 = var_0 func_7FB0(self.var_B640);
          var_7 = var_6[var_5];
          if(isDefined(var_7.origin)) {
            self.var_B5E0.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self.var_B5E0;
}

shouldignoreent(var_0) {
  if(scripts\engine\utility::istrue(player_in_laststand(var_0))) {
    return 1;
  }

  if(isDefined(var_0.team) && isDefined(self.team) && self.team == var_0.team) {
    return 1;
  }

  if(isplayerteleporting(var_0)) {
    return 1;
  }

  if(isDefined(level.killingtimevalidationcheck)) {
    if(![[level.killingtimevalidationcheck]](self, var_0)) {
      return 0;
    }
  }

  if(isDefined(var_0.killing_time)) {
    return 1;
  }

  if(isDefined(level.var_1002D)) {
    if([[level.var_1002D]](var_0)) {
      return 1;
    }
  }

  return 0;
}

isplayerteleporting(var_0) {
  return isDefined(var_0.var_9987) && var_0.var_9987;
}

func_38D1(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.fgetarg, self.height - var_2, self, 1, 0, 0, var_5);
}

func_7E79() {
  if(scripts\mp\agents\zombie\zmb_zombie_agent::func_3DE4("exo")) {
    return "dismemberExoSound";
  }

  return "dismemberSound";
}

func_7E59(var_0, var_1) {
  var_2 = self.agent_type;
  var_3 = level.var_1BA4[var_2].var_2552["heavy_damage_threshold"];
  if(var_0 < var_3 && !var_1) {
    return "light";
  }

  return "heavy";
}

func_4E0C(var_0) {
  return level.var_1BBA.var_4E2D["hitLoc"][var_0];
}

func_4E0D(var_0) {
  var_1 = scripts\mp\agents\_scriptedagents::func_7DBD(var_0);
  return level.var_1BBA.var_4E2D["hitDirection"][var_1];
}

botnodepickmultiple(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = var_3[var_0][var_1][var_2];
  } else {
    var_4 = var_4[var_1][var_2];
  }

  return var_4[randomint(var_4.size)];
}