/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat_utility.gsc
******************************************/

_id_2373(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

_id_2374() {
  if(isPlayer(self.enemy)) {
    return randomfloatrange(self.enemy._id_20F2._id_22ED, self.enemy._id_20F2._id_22EE);
  } else {
    return randomfloatrange(anim._id_22ED, anim._id_22EE);
  }
}

_id_2375() {
  var_0 = (gettime() - self.a._id_0AA7) / 1000;
  var_1 = _id_2376();

  if(var_1 > var_0) {
    return var_1 - var_0;
  }
  return 0;
}

_id_2376() {
  if(animscripts\utility::_id_0C95()) {
    return randomfloatrange(0.15, 0.55);
  } else if(animscripts\utility::_id_0C97()) {
    return randomfloatrange(1.0, 1.7);
  } else if(issniper()) {
    return _id_2374();
  } else if(self._id_0CDB) {
    return randomfloatrange(0.1, 0.35);
  } else {
    return randomfloatrange(0.4, 0.9);
  }
}

_id_2377() {
  if(self._id_0CD1) {
    if(self._id_0CDA == "full" && !self._id_0CDB) {
      if(self.a._id_0AA7 == gettime()) {
        wait 0.05;
      }
      return;
    }

    var_0 = _id_2375();

    if(var_0) {
      wait(var_0);
    }
  }
}

_id_10BB() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(self.team != "allies") {
    if(!isPlayer(self.enemy)) {
      return 0;
    }
    if(self.enemy maps\_utility::_id_1008("player_is_invulnerable")) {
      return 0;
    }
  }

  if(animscripts\utility::_id_0C95() || animscripts\utility::_id_0BB6()) {
    return 0;
  }
  if(gettime() - self._id_10BA < self._id_20B7) {
    return 0;
  }
  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536) {
    return 0;
  }
  self._id_0CD1 = int(weaponclipsize(self.weapon) / 2);

  if(self._id_0CD1 > weaponclipsize(self.weapon)) {
    self._id_0CD1 = weaponclipsize(self.weapon);
  }
  self._id_10BA = gettime();
  return 1;
}

_id_2378() {
  for(var_0 = int(60.0); var_0 > 0; var_0--) {
    if(isDefined(self._id_0F9F) || isDefined(self.enemy) && isDefined(self.enemy._id_0FA0)) {
      wait 0.05;
      continue;
    }

    return 0;
  }

  return 1;
}

_id_0F06() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");

  if(_id_23BD()) {
    if(isDefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin, self.enemy.origin) < 147456) {
      self.enemy animscripts\battlechatter_ai::_id_0AD5("infantry", self, 1.0);
    }
    if(animscripts\utility::_id_0BB6() && issentient(self.enemy)) {
      wait(randomfloat(2.0));
    }
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(400)) {
    var_0 = randomintrange(1, 5);
  } else {
    var_0 = 10;
  }
  for(;;) {
    _id_2377();

    if(_id_2378()) {
      break;
    }

    if(self._id_0CDA == "full") {
      _id_237E(animscripts\utility::_id_0D4D("fire"), 1, animscripts\shared::_id_2379());
    } else if(self._id_0CDA == "burst" || self._id_0CDA == "semi") {
      var_1 = animscripts\shared::_id_237A();

      if(var_1 == 1) {
        _id_237E(animscripts\utility::_id_0CA8("single"), 1, var_1);
      } else {
        _id_237E(animscripts\utility::_id_0D4D(self._id_0CDA + var_1), 1, var_1);
      }
    } else if(self._id_0CDA == "single") {
      _id_237E(animscripts\utility::_id_0CA8("single"), 1, 1);
    } else {
      self waittill("hell freezes over");
    }
    if(!self._id_0CD1) {
      break;
    }

    var_0--;

    if(var_0 < 0) {
      self._id_0CDC = 1;
      break;
    }
  }
}

_id_0FF4() {
  anim._id_20C9++;
  return anim._id_20C9;
}

#using_animtree("generic_human");

_id_110B(var_0) {
  self setanim(%exposed_aiming, 1, 0.2);
  self setanimknoblimited(animscripts\utility::_id_0D4D("straight_level"), 1, var_0);
  self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_up"), 1, var_0);
  self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_down"), 1, var_0);
  self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_left"), 1, var_0);
  self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_right"), 1, var_0);
}

_id_1114() {
  if(!isDefined(self.a._id_0F78)) {
    _id_110B(0.2);
    thread _id_0F78();
    thread animscripts\track::_id_0CA9();
  }
}

_id_0F85() {
  _id_0F9D();
  self clearanim(%add_fire, 0.1);
  self notify("stop tracking");
}

_id_237B() {
  if(isDefined(self.a._id_0F78)) {
    self setanim(%add_idle, 0, 0.2);
  }
  self setanim(%add_fire, 1, 0.1);
}

_id_111E() {
  if(isDefined(self.a._id_0F78)) {
    self setanim(%add_idle, 1, 0.2);
  }
  self setanim(%add_fire, 0, 0.1);
}

_id_0F78(var_0) {
  self endon("killanimscript");
  self endon("end_aim_idle_thread");

  if(isDefined(self.a._id_0F78)) {
    return;
  }
  self.a._id_0F78 = 1;
  wait 0.1;
  self setanimlimited(%add_idle, 1, 0.2);
  var_1 = 0;

  for(;;) {
    var_2 = "idle" + var_1;

    if(isDefined(self.a._id_237C)) {
      var_3 = animscripts\utility::_id_0CA8("lean_idle");
    } else {
      var_3 = animscripts\utility::_id_0CA8("exposed_idle");
    }
    self setflaggedanimknoblimitedrestart(var_2, var_3, 1, 0.2);
    self waittillmatch(var_2, "end");
    var_1++;
  }

  self clearanim(%add_idle, 0.1);
}

_id_0F9D() {
  self notify("end_aim_idle_thread");
  self.a._id_0F78 = undefined;
  self clearanim(%add_idle, 0.1);
}

_id_237D() {
  if(animscripts\utility::_id_0C97()) {
    return 1.0;
  }
  if(animscripts\weaponlist::_id_0CCA()) {
    return animscripts\weaponlist::_id_0CCC() * 0.7;
  }
  return 0.4;
}

_id_237E(var_0, var_1, var_2) {
  var_3 = "fireAnim_" + _id_0FF4();
  maps\_gameskill::_id_0CD8();

  while(!_id_10E4()) {
    wait 0.05;
  }
  _id_237B();
  var_4 = 1.0;

  if(isDefined(self._id_237F)) {
    var_4 = self._id_237F;
  } else if(self._id_0CDA == "full") {
    var_4 = animscripts\weaponlist::_id_0CCC() * randomfloatrange(0.5, 1.0);
  } else if(self._id_0CDA == "burst") {
    var_4 = animscripts\weaponlist::_id_0CCD();
  } else if(animscripts\utility::_id_0C95()) {
    var_4 = 3.0;
  } else if(animscripts\utility::_id_2380()) {
    var_4 = _id_237D();
  }
  self setflaggedanimknobrestart(var_3, var_0, 1, 0.2, var_4);
  self updateplayersightaccuracy();

  if(!isDefined(self._id_023F)) {
    self._id_023F = 0;
  }
  self._id_023F++;
  _id_2381(var_3, var_0, var_1, var_2);
  self._id_023F = 0;
  _id_111E();
}

_id_2381(var_0, var_1, var_2, var_3) {
  self endon("enemy");

  if(isPlayer(self.enemy) && (self._id_0CDA == "full" || self._id_0CDA == "semi")) {
    level endon("player_becoming_invulnerable");
  }
  if(var_2) {
    thread _id_2382(var_0, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }
  var_4 = 0;
  var_5 = animhasnotetrack(var_1, "fire");
  var_6 = weaponclass(self.weapon) == "rocketlauncher";

  while(var_4 < var_3 && var_3 > 0) {
    if(var_5) {
      self waittillmatch(var_0, "fire");
    }
    if(!self._id_0CD1) {
      if(!_id_10BB()) {
        break;
      }
    }

    if(!_id_10E4()) {
      break;
    }

    _id_2383();

    if(isPlayer(self.enemy) && self.enemy maps\_utility::_id_1008("player_is_invulnerable")) {
      if(randomint(3) == 0) {
        self._id_0CD1--;
      }
    } else {
      self._id_0CD1--;
    }
    if(var_6) {
      self.a.rockets--;

      if(self.weapon == "rpg") {
        self hidepart("tag_rocket");
        self.a._id_0CD2 = 0;
      }
    }

    var_4++;
    thread _id_2387(var_0);

    if(self._id_0CDB && var_4 == var_3) {
      break;
    }

    if(!var_5 || var_3 == 1 && self._id_0CDA == "single") {
      self waittillmatch(var_0, "end");
    }
  }

  if(var_2) {
    self notify("fireAnimEnd");
  }
}

_id_10E4() {
  if(!isDefined(self._id_0CB1)) {
    return 1;
  }
  var_0 = self getmuzzleangle();
  var_1 = animscripts\shared::_id_0CB0();
  var_2 = vectortoangles(self._id_0CB1 - var_1);
  var_3 = animscripts\utility::_id_0D61(var_0[1] - var_2[1]);

  if(var_3 > anim._id_209E) {
    if(distancesquared(self getEye(), self._id_0CB1) > anim._id_209F || var_3 > anim._id_20A0) {
      return 0;
    }
  }

  return animscripts\utility::_id_0D61(var_0[0] - var_2[0]) <= anim._id_20A1;
}

_id_2382(var_0, var_1) {
  self endon("killanimscript");
  self endon(var_1);
  self waittillmatch(var_0, "end");
  self notify(var_1);
}

_id_2383() {
  if(isDefined(self._id_0CAB)) {
    if(isDefined(self.enemy) && self._id_0CAB == self.enemy) {
      animscripts\utility::_id_0D5F();
    }
  } else {
    animscripts\utility::_id_2384(self._id_0CB1);
  }
}

_id_2385() {
  if(self.weapon != "rpg") {
    return;
  }
  self.a._id_0CD2 = 1;
  self showpart("tag_rocket");
  self notify("showing_rocket");
}

_id_0CD3() {
  if(self.weapon != "rpg") {
    return;
  }
  self endon("death");
  self endon("showing_rocket");
  self waittill("killanimscript");
  _id_2385();
}

_id_2386() {
  if(self._id_0CD1) {
    self._id_0CD1--;
  }
}

_id_2387(var_0) {
  if(!animscripts\utility::_id_0C97()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread _id_2388(2.0);
  self waittillmatch(var_0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

_id_2388(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(var_0);
  self notify("shotgun_pump_sound_end");
}

_id_2389(var_0) {}

_id_0F08(var_0) {
  if(self.weapon == "none") {
    return 0;
  }
  if(isDefined(self._id_238A)) {
    if(self._id_0CD1 < weaponclipsize(self.weapon) * 0.5) {
      self._id_0CD1 = int(weaponclipsize(self.weapon) * 0.5);
    }
    if(self._id_0CD1 <= 0) {
      self._id_0CD1 = 0;
    }
    return 0;
  }

  if(self._id_0CD1 <= weaponclipsize(self.weapon) * var_0) {
    if(var_0 == 0) {
      if(_id_10BB()) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_1153() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  animscripts\shared::_id_0C9B(self.primaryweapon, "right");
}

_id_0F54(var_0, var_1) {
  self endon("killanimscript");

  if(!_id_0F08(var_0)) {
    return 0;
  }
  animscripts\battlechatter_ai::_id_0B36();
  animscripts\battlechatter::_id_0ABF();

  if(isDefined(var_1)) {
    self setflaggedanimknoball("reloadanim", var_1, %body, 1, 0.1, 1);
    animscripts\shared::_id_0C51("reloadanim");
    animscripts\weaponlist::_id_0CD0();
    self.a._id_114D = 0;
  } else {
    if(self.a._id_0D26 == "prone") {
      self setflaggedanimknoball("reloadanim", %prone_reload, %body, 1, 0.1, 1);
      self updateprone(%prone_legs_up, %prone_legs_down, 1, 0.1, 1);
    } else {
      wait 2;
      return;
    }

    animscripts\shared::_id_0C51("reloadanim");
    animscripts\weaponlist::_id_0CD0();
    self.a._id_114D = 0;
  }

  return 1;
}

_id_238B(var_0, var_1) {
  if(!isDefined(anim._id_238C)) {
    anim._id_238C = [];
    anim._id_238D = [];
  }

  var_2 = anim._id_238C.size;
  anim._id_238C[var_2] = var_0;
  anim._id_238D[var_2] = var_1;
}

_id_20E7() {
  _id_238B(%exposed_grenadethrowb, (41.5391, 7.28883, 72.2128));
  _id_238B(%exposed_grenadethrowc, (34.8849, -4.77048, 74.0488));
  _id_238B(%corner_standl_grenade_a, (41.605, 6.80107, 81.4785));
  _id_238B(%corner_standl_grenade_b, (24.1585, -14.7221, 29.2992));
  _id_238B(%cornercrl_grenadea, (25.8988, -10.2811, 30.4813));
  _id_238B(%cornercrl_grenadeb, (24.688, 45.0702, 64.377));
  _id_238B(%corner_standr_grenade_a, (37.1254, -32.7053, 76.5745));
  _id_238B(%corner_standr_grenade_b, (19.356, 15.5341, 16.5036));
  _id_238B(%cornercrr_grenadea, (39.8857, 5.92472, 24.5878));
  _id_238B(%covercrouch_grenadea, (-1.6363, -0.693674, 60.1009));
  _id_238B(%covercrouch_grenadeb, (-1.6363, -0.693674, 60.1009));
  _id_238B(%coverstand_grenadea, (10.8573, 7.12614, 77.2356));
  _id_238B(%coverstand_grenadeb, (19.1804, 5.68214, 73.2278));
  _id_238B(%prone_grenade_a, (12.2859, -1.3019, 33.4307));
  _id_238B(%cqb_stand_grenade_throw, (35.7494, 26.6052, 37.7086));
}

_id_1094(var_0) {
  var_1 = (0, 0, 64);

  if(isDefined(var_0)) {
    foreach(var_4, var_3 in anim._id_238C) {
      if(var_0 == var_3) {
        var_1 = anim._id_238D[var_4];
        break;
      }
    }
  }

  if(var_1[2] == 64) {
    if(isDefined(var_0)) {} else {}
  }

  return var_1;
}

_id_238E() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0]._id_20E4 == 0) {
      level.players[var_0]._id_20E3["fraggrenade"] = 0;
      level.players[var_0]._id_20E3["flash_grenade"] = 0;
    }
  }

  anim._id_0F38 = 1;
}

_id_1093(var_0) {
  self._id_238F = spawnStruct();

  if(isPlayer(var_0)) {
    self._id_238F._id_2390 = 1;
    self._id_238F.player = var_0;
    self._id_238F._id_2391 = self.grenadeweapon;
  } else {
    self._id_238F._id_2390 = 0;
    self._id_238F._id_2391 = "AI_" + self.grenadeweapon;
  }
}

_id_2392() {
  return self._id_238F._id_2390;
}

_id_2393(var_0, var_1) {
  if(var_0._id_2390) {
    var_2 = var_0.player;
    var_3 = var_2._id_20E3[var_0._id_2391];
    var_2._id_20E3[var_0._id_2391] = max(var_1, var_3);
  } else {
    var_3 = anim._id_20E3[var_0._id_2391];
    anim._id_20E3[var_0._id_2391] = max(var_1, var_3);
  }
}

_id_2394() {
  var_0 = undefined;

  if(_id_2392()) {
    var_1 = self._id_238F.player;
    var_0 = gettime() + var_1._id_20F2._id_22FD + randomint(var_1._id_20F2._id_20F3);
  } else {
    var_0 = gettime() + 30000 + randomint(30000);
  }
  return var_0;
}

_id_2395(var_0) {
  if(var_0._id_2390) {
    return var_0.player._id_20E3[var_0._id_2391];
  } else {
    return anim._id_20E3[var_0._id_2391];
  }
}

_id_2396(var_0) {
  if(!isPlayer(var_0) && self isbadguy()) {
    if(gettime() < _id_2395(self._id_238F)) {
      if(level.player.ignoreme) {
        return var_0;
      }
      var_1 = self getthreatbiasgroup();
      var_2 = level.player getthreatbiasgroup();

      if(var_1 != "" && var_2 != "" && getthreatbias(var_2, var_1) < -10000) {
        return var_0;
      }
      if(self cansee(level.player) || isai(var_0) && var_0 cansee(level.player)) {
        if(isDefined(self._id_0CAF)) {
          var_3 = vectortoangles(level.player.origin - self.origin);
          var_4 = angleclamp180(self._id_0CAF.angles[1] - var_3[1]);
        } else {
          var_4 = animscripts\utility::_id_113E(level.player.origin);
        }
        if(abs(var_4) < 60) {
          var_0 = level.player;
          _id_1093(var_0);
        }
      }
    }
  }

  return var_0;
}

_id_2397(var_0) {
  if(maps\_utility::_id_2398()) {
    return 0;
  }
  if(!var_0._id_20F2._id_2304) {
    return 0;
  }
  var_1 = gettime();

  if(var_1 < var_0._id_20E3["double_grenade"]) {
    return 0;
  }
  if(var_1 > var_0._id_20E6 + 3000) {
    return 0;
  }
  if(var_1 < var_0._id_20E6 + 500) {
    return 0;
  }
  return var_0._id_20E4 < 2;
}

_id_1138() {
  return gettime() >= self.a._id_113A;
}

_id_113D(var_0) {
  if(maps\_utility::_id_2398()) {
    return 0;
  }
  if(self._id_20B5 == 1) {
    return 1;
  }
  if(!_id_1138()) {
    return 0;
  }
  if(gettime() >= _id_2395(self._id_238F)) {
    return 1;
  }
  if(self._id_238F._id_2390 && self._id_238F._id_2391 == "fraggrenade") {
    return _id_2397(var_0);
  }
  return 0;
}

_id_2399(var_0, var_1, var_2, var_3) {
  if(!self isgrenadepossafe(var_0, var_1)) {
    return 0;
  } else if(distancesquared(self.origin, var_1) < 40000) {
    return 0;
  }
  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500)) {
    return 0;
  }
  var_4 = var_4 + (0, 0, 0.1);
  return _id_1095(var_0, var_4, var_2, var_3);
}

_id_0FA1(var_0, var_1) {
  if(self.weapon == "mg42" || self.grenadeammo <= 0) {
    return 0;
  }
  _id_1093(var_0);
  var_0 = _id_2396(var_0);

  if(!_id_113D(var_0)) {
    return 0;
  }
  var_2 = _id_1094(var_1);

  if(isDefined(self.enemy) && var_0 == self.enemy) {
    if(!_id_23B7()) {
      return 0;
    }
    if(isPlayer(self.enemy) && maps\_utility::_id_1A43(self.enemy)) {
      return 0;
    }
    if(animscripts\utility::_id_0F4A()) {
      if(!self isgrenadepossafe(var_0, var_0.origin)) {
        return 0;
      }
      return _id_1095(var_0, undefined, var_1, var_2);
    } else if(animscripts\utility::_id_0F39()) {
      return _id_2399(var_0, animscripts\utility::_id_0CEE(), var_1, var_2);
    } else {
      if(!self isgrenadepossafe(var_0, var_0.origin)) {
        return 0;
      }
      return _id_1095(var_0, undefined, var_1, var_2);
    }

    return 0;
  } else {
    return _id_2399(var_0, var_0.origin, var_1, var_2);
  }
}

_id_1095(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(gettime() < 10000 && !isDefined(level._id_239A)) {
    return 0;
  }
  if(!isDefined(var_5)) {
    var_5 = 1;
  }
  if(isDefined(var_2)) {
    var_7 = var_2;
    var_8 = self.a._id_20A7;
  } else {
    switch (self.a._id_0D19) {
      case "cover_crouch":
      case "none":
        if(self.a._id_0D26 == "stand") {
          var_3 = (0, 0, 80);
          var_7 = % stand_grenade_throw;
        } else {
          var_3 = (0, 0, 65);
          var_7 = % crouch_grenade_throw;
        }

        var_8 = "left";
        break;
      default:
        var_7 = undefined;
        var_8 = undefined;
        break;
    }
  }

  if(!isDefined(var_7)) {
    return 0;
  }
  if(isDefined(var_1)) {
    if(!isDefined(var_4)) {
      var_9 = self checkgrenadethrowpos(var_3, var_1, var_5, "min energy", "min time", "max time");
    } else {
      var_9 = self checkgrenadethrowpos(var_3, var_1, var_5, "min time", "min energy");
    }
  } else {
    var_10 = self._id_20B6;
    var_11 = distance(var_0.origin, self.origin);

    if(var_11 < 800) {
      if(var_11 < 256) {
        var_10 = 0;
      } else {
        var_10 = var_10 * ((var_11 - 256) / 544);
      }
    }

    if(!isDefined(var_4)) {
      var_9 = self checkgrenadethrow(var_3, var_10, "min energy", "min time", "max time");
    } else {
      var_9 = self checkgrenadethrow(var_3, var_10, "min time", "min energy");
    }
  }

  self.a._id_113A = gettime() + randomintrange(1000, 2000);

  if(isDefined(var_9)) {
    if(!isDefined(self._id_239B)) {
      self._id_239B = self.grenadeawareness;
    }
    self.grenadeawareness = 0;
    var_12 = _id_2394();
    _id_2393(self._id_238F, min(gettime() + 3000, var_12));
    var_13 = 0;

    if(_id_2392()) {
      var_0._id_20E4++;
      thread _id_239C(var_0);

      if(var_0._id_20E4 > 1) {
        var_13 = 1;
      }
      if(self._id_238F._id_2391 == "fraggrenade") {
        if(var_0._id_20E4 <= 1) {
          var_0._id_20E6 = gettime();
        }
      }
    }

    if(isDefined(var_6)) {
      thread _id_239D(var_7, var_9, var_12, var_13);
    } else {
      _id_239D(var_7, var_9, var_12, var_13);
    }
    return 1;
  } else {}

  return 0;
}

_id_239C(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0._id_20E4--;
}

_id_239D(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(self.script == "combat" || self.script == "move") {
    self orientmode("face direction", var_1);
  }
  animscripts\battlechatter_ai::_id_0B3A(self.grenadeweapon);
  self notify("stop_aiming_at_enemy");
  self setflaggedanimknoballrestart("throwanim", var_0, %body, _id_0F7B(), 0.1, 1);
  thread animscripts\notetracks::_id_239E("throwanim", "killanimscript");
  var_4 = animscripts\utility::_id_239F();
  var_5 = "none";

  for(;;) {
    self waittill("throwanim", var_6);

    if(var_6 == "grenade_left" || var_6 == "grenade_right") {
      var_5 = _id_23A6(var_4, "TAG_INHAND");
      self._id_23A0 = 1;
    }

    if(var_6 == "grenade_throw" || var_6 == "grenade throw") {
      break;
    }

    if(var_6 == "end") {
      self._id_238F.player._id_20E4--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(_id_2392()) {
    thread _id_23A1(self._id_238F.player, var_2);
  }
  self throwgrenade();

  if(!_id_2392()) {
    _id_2393(self._id_238F, var_2);
  }
  if(var_3) {
    var_13 = self._id_238F.player;

    if(var_13._id_20E4 > 1 || gettime() - var_13._id_20E5 < 2000) {
      var_13._id_20E3["double_grenade"] = gettime() + min(5000, var_13._id_20F2._id_20F4);
    }
  }

  self notify("stop grenade check");

  if(var_5 != "none") {
    self detach(var_4, var_5);
  } else {}

  self._id_23A0 = undefined;
  self.grenadeawareness = self._id_239B;
  self._id_239B = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self setanim(%exposed_modern, 1, 0.2);
  self setanim(%exposed_aiming, 1);
  self clearanim(var_0, 0.2);
}

_id_23A1(var_0, var_1) {
  var_0 endon("death");
  _id_23A2(var_1);
  var_0._id_20E4--;
}

_id_23A2(var_0) {
  var_1 = self._id_238F;
  var_2 = spawnStruct();
  var_2 thread _id_23A5(5);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self.grenadeweapon;
  var_4 = _id_23A4();

  if(!isDefined(var_4)) {
    return;
  }
  _id_2393(var_1, min(gettime() + 5000, var_0));
  var_5 = 62500;
  var_6 = 160000;

  if(var_3 == "flash_grenade") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          var_11 _id_23A3(var_1, var_0);
          continue;
        }

        if(var_12 < var_6) {
          var_9[var_9.size] = var_11;
        }
      }

      var_7 = var_9;

      if(var_7.size == 0) {
        break;
      }
    }

    var_8 = var_4.origin;
  }
}

_id_23A3(var_0, var_1) {
  var_2 = self;
  anim._id_0F38 = undefined;

  if(gettime() - var_2._id_20E5 < 3000) {
    var_2._id_20E3["double_grenade"] = gettime() + var_2._id_20F2._id_20F4;
  }
  var_2._id_20E5 = gettime();
  var_3 = var_2._id_20E3[var_0._id_2391];
  var_2._id_20E3[var_0._id_2391] = max(var_1, var_3);
}

_id_23A4() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

_id_23A5(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

_id_23A6(var_0, var_1) {
  self attach(var_0, var_1);
  thread _id_23A7(var_0, var_1);
  return var_1;
}

_id_23A7(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_239B)) {
    self.grenadeawareness = self._id_239B;
    self._id_239B = undefined;
  }

  self detach(var_0, var_1);
}

_id_23A8(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

_id_23A9(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + _id_23A8(var_0);

  for(;;) {
    wait 0.05;
  }
}

_id_0D7E() {
  var_0 = randomfloat(360);
  var_1 = randomfloatrange(30, 75);
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = cos(var_0) * var_3;
  var_5 = sin(var_0) * var_3;
  var_6 = randomfloatrange(100, 200);
  var_7 = (var_4, var_5, var_2) * var_6;
  return var_7;
}

_id_23AA() {
  var_0 = self gettagorigin("tag_inhand");
  var_1 = _id_0D7E();
  self magicgrenademanual(var_0, var_1, 3);
}

_id_0F3B() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(self.fixednode || self.doingambush) {
    return 0;
  }
  var_0 = _id_23AB();

  if(isDefined(var_0)) {
    return _id_23AC(var_0);
  }
  return 0;
}

_id_23AB() {
  var_0 = self findbestcovernode();

  if(!isDefined(var_0)) {
    return undefined;
  }
  var_1 = animscripts\utility::_id_0BEE();

  if(isDefined(var_1) && var_0 == var_1) {
    return undefined;
  }
  if(isDefined(self._id_0CAF) && var_0 == self._id_0CAF) {
    return undefined;
  }
  return var_0;
}

_id_23AC(var_0) {
  var_1 = self.keepclaimednodeifvalid;
  var_2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self usecovernode(var_0)) {
    return 1;
  } else {}

  self.keepclaimednodeifvalid = var_1;
  self.keepclaimednode = var_2;
  return 0;
}

_id_0F34() {
  if(level._id_20ED[self.team] > 0 && level._id_20ED[self.team] < level._id_20EF) {
    if(gettime() - level._id_20E9[self.team] > 4000) {
      return 0;
    }
    var_0 = level._id_20EC[self.team];
    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level._id_20EB[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level._id_20EA[self.team]) < 262144)) {
      return 1;
    }
  }

  return 0;
}

_id_23AD() {
  if(!isDefined(level._id_20E9[self.team])) {
    return 0;
  }
  if(_id_0F34()) {
    return 1;
  }
  if(gettime() - level._id_20E9[self.team] < level._id_20EE) {
    return 0;
  }
  if(!issentient(self.enemy)) {
    return 0;
  }
  if(level._id_20ED[self.team]) {
    level._id_20ED[self.team] = 0;
  }
  var_0 = isDefined(self._id_4418) && self._id_4418;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return 0;
  }
  return 1;
}

_id_0F35(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(self.fixednode) {
    return 0;
  }
  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") {
    return 0;
  }
  if(!self isingoal(self.enemy.origin)) {
    return 0;
  }
  if(_id_23BD()) {
    return 0;
  }
  if(!_id_23AD()) {
    return 0;
  }
  self findreacquiredirectpath(var_0);

  if(self reacquiremove()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;
    self.a._id_1111 = 1;

    if(level._id_20ED[self.team] == 0) {
      level._id_20E9[self.team] = gettime();
      level._id_20EC[self.team] = self;
    }

    level._id_20EB[self.team] = self.origin;
    level._id_20EA[self.team] = self.enemy.origin;
    level._id_20ED[self.team]++;
    return 1;
  }

  return 0;
}

_id_23AE(var_0) {
  self endon("death");
  wait 0.5;
  var_1 = "" + anim._id_20DD;
  badplace_cylinder(var_1, 5, var_0, 16, 64, self.team);
  anim._id_1ED7[anim._id_1ED7.size] = var_1;

  if(anim._id_1ED7.size >= 10) {
    var_2 = [];

    for(var_3 = 1; var_3 < anim._id_1ED7.size; var_3++) {
      var_2[var_2.size] = anim._id_1ED7[var_3];
    }
    badplace_delete(anim._id_1ED7[0]);
    anim._id_1ED7 = var_2;
  }

  anim._id_20DD++;

  if(anim._id_20DD > 10) {
    anim._id_20DD = anim._id_20DD - 20;
  }
}

_id_23AF(var_0, var_1, var_2) {
  if(var_0 > var_1 && var_0 < var_2) {
    return 1;
  }
  return 0;
}

_id_23B0() {
  if(!isDefined(self._id_0CB1)) {
    return 0;
  }
  var_0 = self getmuzzleangle()[1] - animscripts\utility::_id_101A(self._id_0CB1);
  var_0 = angleclamp180(var_0);
  return var_0;
}

_id_23B1() {
  if(!isDefined(self._id_0CB1)) {
    return 0;
  }
  var_0 = self getmuzzleangle()[0] - vectortoangles(self._id_0CB1 - self getmuzzlepos())[0];
  var_0 = angleclamp180(var_0);
  return var_0;
}

_id_23B2() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  var_0 = self.enemy getshootatpos() - self getshootatpos();
  var_0 = vectornormalize(var_0);
  var_1 = 360 - vectortoangles(var_0)[0];
  return angleclamp180(var_1);
}

_id_23B3(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  var_1 = var_0 - self getshootatpos();
  var_1 = vectornormalize(var_1);
  var_2 = 360 - vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

_id_20DE() {
  self._id_0F53 = 0;
  self._id_23B4 = -1;

  for(;;) {
    self waittill("reload_start");
    self._id_0F53 = 1;
    self._id_23B4 = gettime();
    _id_23B5();
    self._id_0F53 = 0;
  }
}

_id_23B5() {
  thread _id_23B6(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();

    if(var_0 == "none") {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

_id_23B6(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

_id_23B7() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon == "flash_grenade") {
    return var_1 < 589824;
  }
  return var_1 >= 40000 && var_1 <= 1562500;
}

monitorflash() {
  self endon("death");

  if(!isDefined(level._id_23B8)) {
    self endon("stop_monitoring_flash");
  }
  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);

    if(isDefined(self._id_0D68) && self._id_0D68) {
      continue;
    }
    if(isDefined(self._id_23B9) && self._id_23B9 != 0) {
      continue;
    }
    if(isDefined(self._id_0CB3) || isDefined(self._id_0CB4)) {
      continue;
    }
    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }
      if(isDefined(self._id_108B)) {
        continue;
      }
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5) {
      var_0 = 1.0;
    } else {
      var_0 = var_0 / (1 - var_5);
    }
    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }
    self._id_23BA = var_4;
    maps\_utility::_id_23BB(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

_id_23BC() {
  return animscripts\utility::_id_0CEA(self.primaryweapon);
}

issniper() {
  return animscripts\utility::_id_0BEB(self.primaryweapon);
}

_id_23BD() {
  return issniper() || animscripts\utility::_id_0BB6();
}

_id_0F7B() {
  return 1.5;
}

_id_0F97() {
  return randomfloatrange(1, 1.2);
}

_id_0FB6(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }
  if(var_0.size == 1) {
    return var_0[0];
  }
  if(isDefined(self.a._id_0F3E) && randomint(100) > 20) {
    foreach(var_3, var_2 in var_0) {
      if(var_2 == self.a._id_0F3E) {
        if(var_3 < var_0.size - 1) {
          var_0[var_3] = var_0[var_0.size - 1];
        }
        var_0[var_0.size - 1] = undefined;
        break;
      }
    }
  }

  return var_0[randomint(var_0.size)];
}

_id_0D0E() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
      continue;
    }
    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(common_scripts\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return 1;
  }

  return 0;
}