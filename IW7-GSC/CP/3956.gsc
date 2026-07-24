/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3956.gsc
**************************************/

_id_38C2(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

_id_800F() {
  return 8;
}

_id_7FA8() {
  return 360.0 / _id_800F();
}

_id_B63F(var_0, var_1, var_2) {
  var_3 = var_1 * _id_7FA8() - 180.0;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

_id_7FB0(var_0) {
  return self._id_B63E[var_0];
}

_id_13141(var_0) {
  if(!isDefined(self._id_B63E))
    self._id_B63E = [];

  if(!isDefined(self._id_B63E[var_0])) {
    self._id_B63E[var_0] = [];

    for(var_1 = 0; var_1 < _id_800F(); var_1++) {
      self._id_B63E[var_0][var_1] = spawnStruct();
      self._id_B63E[var_0][var_1]._id_11931 = 0;
      self._id_B63E[var_0][var_1]._id_3FF6 = undefined;
      self._id_B63E[var_0][var_1].origin = undefined;
      self._id_B63E[var_0][var_1]._id_C1D5 = var_1;
    }
  }
}

_id_8024(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0._id_864C)) {
    var_1 = var_0._id_864C;

    if(isDefined(self._id_5719) && var_0 == self._id_5719 && _id_8BDA()) {
      var_2 = _id_7FDE();

      if(isDefined(var_2))
        var_1 = var_2.origin;
    }
  } else if(isPlayer(var_0) && (var_0 isjumping() || var_0 ishighjumping())) {
    if(!isDefined(var_0._id_D399))
      var_0._id_D399 = 0;

    if(gettime() > var_0._id_D399) {
      var_0._id_D398 = getgroundposition(var_0.origin, 15);
      var_0._id_D399 = gettime();
    }

    if(isDefined(var_0._id_D398))
      var_1 = var_0._id_D398;
  }

  return var_1;
}

_id_8C39(var_0, var_1) {
  for(var_2 = 0; var_2 < _id_800F(); var_2++) {
    var_3 = var_0 _id_7FB0(var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin))
      return 1;
  }

  return 0;
}

_id_3717() {
  var_0 = self getnearestnode();
}

_id_8BDA() {
  var_0 = self getnearestnode();

  if(isDefined(var_0) && isDefined(self._id_5719._id_BE81)) {
    var_1 = self._id_5719._id_BE81["0"];

    if(isDefined(var_1))
      return 1;
  }

  return 0;
}

_id_7FDE() {
  var_0 = self getnearestnode();
  var_1 = self._id_5719._id_BE81["0"];

  if(!isnumber(var_1))
    return var_1;
  else
    return undefined;
}

_id_100AB() {
  if(_id_8BDA()) {
    var_0 = _id_7FDE();

    if(!isDefined(var_0))
      return 0;
  }

  return 1;
}

_id_9DE1(var_0) {
  if(isDefined(self._id_5719) && var_0 == self._id_5719) {
    if(self._id_571A > 5)
      return 1;
  }

  return 0;
}

_id_7FB1(var_0, var_1) {
  var_0 _id_13141(self._id_B640);
  var_2 = var_0 _id_7FB0(self._id_B640);
  var_3 = var_1;
  var_4 = self.origin - var_3;
  var_5 = lengthsquared(var_4);

  if(var_5 < 256) {
    var_6 = -1;

    for(var_7 = 0; var_7 < _id_800F(); var_7++) {
      var_8 = var_2[var_7];

      if(isDefined(var_8._id_3FF6) && var_8._id_3FF6 == self)
        var_6 = var_8._id_C1D5;
    }

    if(var_6 < 0)
      var_6 = self getentitynumber() % _id_800F();

    var_9 = var_6;
  } else {
    var_10 = angleclamp180(vectortoyaw(var_4)) + 180.0;
    var_9 = var_10 / _id_7FA8();
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

  var_15 = _id_800F();

  for(var_16 = 0; var_16 < var_15 / 2 + 1; var_16++) {
    for(var_17 = var_12; var_17 != var_13; var_17 = var_17 + var_14) {
      var_18 = var_6 + var_16 * var_17;

      if(var_18 >= var_15)
        var_18 = var_18 - var_15;
      else if(var_18 < 0)
        var_18 = var_18 + var_15;

      var_8 = var_2[var_18];

      if(!isDefined(var_11) && gettime() - var_8._id_11931 >= self._id_B641) {
        if(isDefined(level._id_12892) && isDefined(level._id_12892[self.agent_type]))
          [[level._id_12892[self.agent_type]]](var_8, var_3, self._id_252B, self.radius);
        else
          _id_12892(var_8, var_3, self._id_252B, self.radius);
      }

      if(!isDefined(var_11) && isDefined(var_8.origin)) {
        var_19 = getclosestpointonnavmesh(var_0.origin, self);
        var_20 = navtrace(var_8.origin, var_19, self, 1);

        if(var_20["fraction"] < 0.95) {
          continue;
        }
        var_21 = 0;

        if(isDefined(var_8._id_3FF6) && var_8._id_3FF6 != self) {
          var_22 = vectorNormalize(var_3 - var_8._id_3FF6.origin) * self.radius * 2;
          var_21 = distancesquared(var_8._id_3FF6.origin + var_22, var_3);
        }

        if(!isalive(var_8._id_3FF6) || !isDefined(var_8._id_3FF6.curmeleetarget) || var_8._id_3FF6.curmeleetarget != var_0 || var_8._id_3FF6 == self || var_5 < var_21) {
          if(isalive(var_8._id_3FF6) && var_8._id_3FF6 != self) {
            var_8._id_3FF6 notify("lostSectorClaim");
            var_8._id_3FF6._id_F0D4 = undefined;
          }

          if(isDefined(self._id_F0D4) && self._id_F0D4 != var_8)
            self._id_F0D4._id_3FF6 = undefined;

          self._id_F0D4 = var_8;
          var_8._id_3FF6 = self;
          var_11 = var_8.origin;
          thread _id_BA13(var_8);
        }
      }

      if(var_16 == 0) {
        break;
      }
    }
  }

  return var_11;
}

_id_BA13(var_0) {
  level endon("game_ended");
  self notify("monitorSectorClaim");
  self endon("monitorSectorClaim");
  self endon("lostSectorClaim");
  scripts\engine\utility::waittill_any("death", "disconnect");
  var_0._id_3FF6 = undefined;
}

_id_12892(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0._id_11931 >= 50) {
    var_0.origin = _id_B63F(var_1, var_0._id_C1D5, var_2);
    var_0.origin = _id_5D54(var_0.origin, var_3, 55);
    var_0._id_11931 = gettime();
  }
}

_id_5D54(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 18;

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, var_1, var_2, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1)
    return undefined;

  if(abs(var_6[2] - var_5[2]) < 0.1)
    return undefined;

  return var_6;
}

iscrawling() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

_id_7FAE() {
  if(!isDefined(self._id_B104) || self._id_B104)
    return self._id_B62D;
  else
    return self._id_B62E;
}

_id_7FAF() {
  if(!isDefined(self._id_B104) || self._id_B104)
    return self._id_B630;
  else
    return self.meleeradiusbasesq;
}

_id_B106(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_B0FE = var_0 * 1000.0;
  self._id_B0FF = var_3;
  self._id_B0FC = isDefined(var_4) && var_4;
  self._id_B101 = var_5;
  self._id_B107 = var_2;
  self._id_B108 = squared(self._id_B107);
  _id_F794(var_1);
}

_id_B103() {
  if(isDefined(self._id_55D3) && self._id_55D3 > 0) {
    self._id_55D3--;

    if(self._id_55D3 > 0)
      return;
  }

  self._id_B104 = 1;
}

_id_B102() {
  if(!isDefined(self._id_55D3))
    self._id_55D3 = 0;

  self._id_55D3++;
  self._id_B104 = 0;
}

_id_5811(var_0, var_1, var_2, var_3) {
  self._id_5803 = var_0 * 1000.0;
  self._id_5801 = var_1;
  self._id_5800 = var_2;
  self._id_57FE = ["back", "right", "left"];
  self._id_57FF = [];

  foreach(var_6, var_5 in self._id_57FE)
  self._id_57FF[var_6] = level._effect[var_3 + var_5];
}

_id_5807() {
  if(isDefined(self._id_55C5) && self._id_55C5 > 0) {
    self._id_55C5--;

    if(self._id_55C5 > 0)
      return;
  }

  self._id_5808 = 1;
}

_id_5806() {
  if(!isDefined(self._id_55C5))
    self._id_55C5 = 0;

  self._id_55C5++;
  self._id_5808 = 0;
}

_id_AB05(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self._id_AAF8 = var_0 * 1000.0;
  self._id_AAF7 = var_1 * 1000.0;
  self._id_AAF6 = var_2;
  self._id_AB01 = var_3;
  self._id_AB02 = squared(self._id_AB01);
  self._id_AB03 = var_4;
  self._id_AB04 = squared(self._id_AB03);
  self._id_AAFE = var_6;
  self._id_AAF5 = var_5;
  self._id_AAFF = 0;
  self._id_AB00 = 0;
}

_id_AAFA() {
  if(isDefined(self._id_55D2) && self._id_55D2 > 0) {
    self._id_55D2--;

    if(self._id_55D2 > 0)
      return;
  }

  self._id_AAFB = 1;
}

_id_AAF9() {
  if(!isDefined(self._id_55D2))
    self._id_55D2 = 0;

  self._id_55D2++;
  self._id_AAFB = 0;
}

_id_3C52(var_0, var_1) {
  self endon("death");
  self scragentsetscripted(1);
  scripts\anim\notetracks_mp::setstatelocked(1, "ChangeAnimClass");
  self.inplayerportableradar = 1;
  self orientmode("face angle abs", (0, self.angles[1], 0));
  self _meth_8281("anim deltas");
  self scragentsetanimscale(1, 1);
  scripts\anim\notetracks_mp::_id_CED6(var_1, randomint(self getanimentrycount(var_1)), "change_anim_class");
  self _meth_82A3(var_0);
  scripts\anim\notetracks_mp::setstatelocked(0, "ChangeAnimClass");
  self.inplayerportableradar = 0;
  self scragentsetscripted(0);
}

_id_8205(var_0) {
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

_id_8088(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_0);
  var_5 = getmovedelta(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

_id_7F66(var_0) {
  var_1 = 0.2;
  var_2 = getanimlength(var_0);
  return min(var_1, var_2);
}

_id_CA1D(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self _meth_827B(self.origin, var_0, var_1);
  wait(var_1);
  self _meth_8281("anim deltas");
}

_id_8040(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0)
      var_2 = randomint(var_4);
    else
      var_2 = var_3 + randomint(var_4);
  }

  return var_2;
}

_id_9DE0(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1)
    return 0;

  var_2 = self.origin[2] + self.height + 2 * self.radius;

  if(var_0.origin[2] > var_2)
    return 0;

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12)
      return 0;
  }

  var_4 = 15.0;

  if(isDefined(var_0.radius))
    var_4 = var_0.radius;

  var_5 = self.radius + var_4;
  var_5 = var_5 * var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5)
    return 0;

  return 1;
}

_id_F702(var_0) {
  self.favoriteenemy = var_0;
}

_id_4D52(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectorNormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

_id_5539() {
  if(!isDefined(self._id_55CC))
    self._id_55CC = 0;

  self._id_55CC++;
  _id_553A();
  _id_553B();
}

_id_8B84() {
  return scripts\engine\utility::is_true(self._id_8C00);
}

_id_6202() {
  if(isDefined(level.disable_zombie_exo_abilities) && level.disable_zombie_exo_abilities) {
    return;
  }
  if(isDefined(self._id_55CC) && self._id_55CC > 0) {
    self._id_55CC--;

    if(self._id_55CC > 0)
      return;
  }

  self._id_8C00 = 1;
  _id_6204();
  _id_F9A2();
  _id_6203();
}

_id_6204() {}

_id_553B() {}

_id_F9A2() {
  var_0 = clamp(level._id_13BDC / 20, 0.0, 1.0);
  var_1 = _id_AB6F(var_0, 0.35, 0.55);
  var_2 = _id_AB6F(var_0, 0.06, 0.12);
  _id_B106(5.0, self._id_B62E * 2, self._id_B62E * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  _id_5811(5.0, var_1, "dodge_boost", "boost_dodge_");
  _id_AB05(10.0, 2.0, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

_id_6203() {
  _id_B103();
  _id_5807();
  _id_AAFA();
}

_id_AB6F(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

_id_553A() {
  _id_B102();
  _id_5806();
  _id_AAF9();
}

_id_CCAB(var_0) {
  if(!isDefined(self._id_2CCC)) {
    return;
  }
  if(self._id_2CCC != "no_boost_fx")
    playFXOnTag(var_0, self, self._id_2CCC);
}

player_in_laststand(var_0) {
  return var_0.inlaststand;
}

_id_6CA8(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(player_in_laststand(var_3))
      var_1[var_1.size] = var_3;
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(_id_C04C(var_7)) {
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

_id_13D9C() {
  var_0 = self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh;
  return distancesquared(self.origin, self.curmeleetarget.origin) <= var_0;
}

_id_13D9A() {
  if(_id_7FAE() == self._id_B62E)
    return _id_13D9B();

  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= _id_7FAF();
  return var_0;
}

_id_13D9B() {
  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq;

  if(!var_0 && (isPlayer(self.curmeleetarget) || isagent(self.curmeleetarget))) {
    var_1 = undefined;
    var_1 = self.curmeleetarget _meth_845B();

    if(isDefined(var_1) && isDefined(var_1.targetname) && var_1.targetname == "care_package")
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
  }

  if(!var_0 && isPlayer(self.curmeleetarget) && scripts\engine\utility::is_true(self.curmeleetarget._id_9E46)) {
    if(length(self getvelocity()) < 5)
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
  }

  return var_0;
}

_id_F794(var_0) {
  self._id_B62D = var_0;
  self._id_B630 = var_0 * var_0;
}

_id_C04C(var_0) {
  return !isDefined(var_0._id_13FAA);
}

_id_8252() {
  return level.zombiedlclevel;
}

_id_136AA() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path");
    self._id_2AB8 = 1;

    if(isDefined(self._id_5719))
      self._id_571A++;
  }
}

_id_8B76() {
  return 1;
}

_id_54BF() {
  if(isDefined(self._id_A9B7) && isDefined(self._id_A9B6) && distance2dsquared(self.curmeleetarget.origin, self._id_A9B7) < 4 && distancesquared(self.origin, self._id_A9B6) < 2500)
    return 1;

  return 0;
}

_id_54BE() {
  if(isDefined(self._id_A9B4) && isDefined(self._id_A9B3) && distance2dsquared(self.curmeleetarget.origin, self._id_A9B4) < 4 && distancesquared(self.origin, self._id_A9B3) < 2500)
    return 1;

  return 0;
}

_id_A00D(var_0) {
  var_1 = 0;
  var_2 = var_0[2] - self.origin[2];
  var_1 = var_2 <= self._id_2539 && var_2 >= self._id_253A;

  if(!var_1 && isPlayer(self.curmeleetarget) && scripts\engine\utility::is_true(self.curmeleetarget._id_9E46)) {
    if(length(self getvelocity()) < 5)
      var_1 = var_2 <= self._id_2539 * 2 && var_2 >= self._id_253A;
  }

  return var_1;
}

_id_138E7() {
  if(_id_9DE0(self.curmeleetarget))
    return 0;

  return !_id_A00D(self.curmeleetarget.origin) && distance2dsquared(self.origin, self.curmeleetarget.origin) < _id_7FAF() * 0.75 * 0.75;
}

_id_9E97() {
  if(isDefined(level.ismeleeblocked_func))
    return [[level.ismeleeblocked_func]]();
  else
    return ismeleeblocked_default();
}

ismeleeblocked_default() {
  var_0 = self.origin + (0, 0, self._id_B5F9);
  var_1 = self.curmeleetarget.origin + (0, 0, self._id_B5F9);

  if(!isPlayer(self.curmeleetarget) && !isai(self.curmeleetarget))
    return 0;

  if(isPlayer(self.curmeleetarget)) {
    if(self.curmeleetarget isusingturret())
      return 0;
  }

  var_2 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);

  if(scripts\common\trace::ray_trace_passed(var_0, var_1, self.curmeleetarget, var_2))
    return 0;

  return 1;
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdeath))
    return 1;

  return 0;
}

_id_DD7C(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(self.curmeleetarget))
    return 0;

  if(!isreallyalive(self.curmeleetarget))
    return 0;

  if(self.aistate == "traverse")
    return 0;

  if(!_id_9DE0(self.curmeleetarget)) {
    if(!_id_A00D(self.curmeleetarget.origin))
      return 0;

    if(var_0 == "offmesh" && !_id_13D9C())
      return 0;

    if(var_0 == "normal" && !_id_13D9A())
      return 0;
    else if(var_0 == "base" && !_id_13D9B())
      return 0;
  }

  if(var_1 && _id_9E97())
    return 0;

  return 1;
}

_id_7FAA(var_0) {
  if(!isDefined(self._id_B5E0))
    self._id_B5E0 = spawnStruct();

  if(_id_9DE1(var_0) && !_id_8BDA())
    _id_3717();

  var_1 = _id_8024(var_0);
  self._id_B5E0._id_656D = var_1;
  var_2 = _id_7FB1(var_0, var_1);

  if(isDefined(var_2)) {
    self._id_B5E0._id_1312B = 1;
    self._id_B5E0.origin = var_2;
  } else {
    self._id_B5E0._id_1312B = 0;
    self._id_B5E0.origin = var_1;

    if(isDefined(self._id_5719)) {
      if(!isDefined(_id_5D54(self._id_B5E0.origin, 15, 55))) {
        if(!isDefined(self._id_DC9A)) {
          self._id_DC9A = [];

          for(var_3 = 0; var_3 < _id_800F(); var_3++)
            self._id_DC9A[self._id_DC9A.size] = var_3;

          self._id_DC9A = scripts\engine\utility::array_randomize(self._id_DC9A);
        }

        foreach(var_5 in self._id_DC9A) {
          var_6 = var_0 _id_7FB0(self._id_B640);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self._id_B5E0.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self._id_B5E0;
}

shouldignoreent(var_0) {
  if(scripts\engine\utility::is_true(player_in_laststand(var_0)))
    return 1;

  if(isDefined(var_0.team) && isDefined(self.team) && self.team == var_0.team)
    return 1;

  if(isplayerteleporting(var_0))
    return 1;

  if(isDefined(var_0.killing_time))
    return 1;

  if(isDefined(level._id_1002D)) {
    if([[level._id_1002D]](var_0))
      return 1;
  }

  return 0;
}

isplayerteleporting(var_0) {
  return isDefined(var_0._id_9987) && var_0._id_9987;
}

_id_38D1(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

_id_7E79() {
  if(scripts\mp\agents\zombie\zombie_agent::_id_3DE4("exo"))
    return "dismemberExoSound";
  else
    return "dismemberSound";
}

_id_7E59(var_0, var_1) {
  var_2 = self.agent_type;
  var_3 = level._id_1BA4[var_2]._id_2552["heavy_damage_threshold"];

  if(var_0 < var_3 && !var_1)
    return "light";
  else
    return "heavy";
}

_id_4E0C(var_0) {
  return level._id_1BBA._id_4E2D["hitLoc"][var_0];
}

_id_4E0D(var_0) {
  var_1 = scripts\anim\notetracks_mp::_id_7DBD(var_0);
  return level._id_1BBA._id_4E2D["hitDirection"][var_1];
}

_id_8044(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    var_4 = var_3[var_0][var_1][var_2];
  else
    var_4 = var_3[var_0][var_1];

  return var_4[randomint(var_4.size)];
}