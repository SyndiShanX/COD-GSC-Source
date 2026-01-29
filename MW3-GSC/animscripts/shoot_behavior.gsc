/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shoot_behavior.gsc
******************************************/

_id_0CD7(var_0) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");
  maps\_gameskill::_id_0CD8();
  self._id_0CD9 = var_0;
  self._id_0CAB = undefined;
  self._id_0CB1 = undefined;
  self._id_0CDA = "none";
  self._id_0CDB = 0;
  self._id_0CDC = undefined;

  if(!isDefined(self._id_0CDD)) {
    self._id_0CDD = 0;

  }
  var_1 = isDefined(self._id_0CAF) && self._id_0CAF.type != "Cover Prone" && self._id_0CAF.type != "Conceal Prone";

  if(var_1) {
    wait 0.05;

  }
  var_2 = self._id_0CAB;
  var_3 = self._id_0CB1;
  var_4 = self._id_0CDA;

  if(!isDefined(self._id_0CDE)) {
    self.a._id_0CDF = 1;
    animscripts\shared::_id_0CE0();
  }

  if(animscripts\combat_utility::issniper()) {
    _id_0D09();

  }
  if(var_1 && (!self.a._id_0CE2 || !animscripts\utility::_id_0CE3())) {
    thread _id_0CFA();

  }
  thread _id_0CFE();
  self._id_0CE4 = undefined;

  for(;;) {
    if(isDefined(self._id_0CE5)) {
      if(!isDefined(self.enemy)) {
        self._id_0CB1 = self._id_0CE5;
        self._id_0CE5 = undefined;
        _id_0CE7();
      } else {
        self._id_0CE5 = undefined;
      }
    }

    var_5 = undefined;

    if(self.weapon == "none") {
      _id_0CE8();
    } else if(animscripts\utility::_id_0BB6()) {
      var_5 = _id_0CF5();
    } else if(animscripts\utility::_id_0C95()) {
      var_5 = _id_0CF6();
    } else {
      var_5 = _id_0CF2();

    }
    if(isDefined(self.a._id_0CE6)) {
      [[self.a._id_0CE6]]();

    }
    if(_id_0CFF(var_2, self._id_0CAB) || !isDefined(self._id_0CAB) && _id_0CFF(var_3, self._id_0CB1) || _id_0CFF(var_4, self._id_0CDA)) {
      self notify("shoot_behavior_change");

    }
    var_2 = self._id_0CAB;
    var_3 = self._id_0CB1;
    var_4 = self._id_0CDA;

    if(!isDefined(var_5)) {
      _id_0CE7();
    }
  }
}

_id_0CE7() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");

  if(isDefined(self._id_0CAB)) {
    self._id_0CAB endon("death");
    self endon("do_slow_things");
    wait 0.05;

    while(isDefined(self._id_0CAB)) {
      self._id_0CB1 = self._id_0CAB getshootatpos();
      wait 0.05;
    }
  } else {
    self waittill("do_slow_things");
  }
}

_id_0CE8() {
  self._id_0CAB = undefined;
  self._id_0CB1 = undefined;
  self._id_0CDA = "none";
  self._id_0CD9 = "normal";
}

_id_0CE9() {
  return !animscripts\combat_utility::issniper() && !animscripts\utility::_id_0CEA(self.weapon);
}

_id_0CEB() {
  if(!animscripts\utility::_id_0CE3()) {
    return 0;

  }
  if(!isDefined(self._id_0CAF) && !self canshootenemy()) {
    return 0;

  }
  return 1;
}

_id_0CEC() {
  if(!_id_0CEB()) {
    if(animscripts\combat_utility::issniper()) {
      _id_0D09();

    }
    if(self.doingambush) {
      self._id_0CD9 = "ambush";
      return "retry";
    }

    if(!isDefined(self.enemy)) {
      _id_0D01();
    } else {
      _id_0CF7();

      if((self.providecoveringfire || randomint(5) > 0) && _id_0CE9()) {
        self._id_0CD9 = "suppress";
      } else {
        self._id_0CD9 = "ambush";

      }
      return "retry";
    }
  } else {
    _id_0D00();
    _id_0D03();
  }
}

_id_0CED(var_0) {
  if(!var_0) {
    _id_0D01();
  } else {
    self._id_0CAB = undefined;
    self._id_0CB1 = animscripts\utility::_id_0CEE();
    _id_0D05();
  }
}

_id_0CEF(var_0) {
  self._id_0CDA = "none";
  self._id_0CAB = undefined;

  if(!var_0) {
    _id_0CF0();

    if(_id_0CF4()) {
      self._id_0CE4 = undefined;
      self notify("return_to_cover");
      self._id_0CDC = 1;
    }
  } else {
    self._id_0CB1 = animscripts\utility::_id_0CEE();

    if(_id_0CF4()) {
      self._id_0CE4 = undefined;

      if(_id_0CE9()) {
        self._id_0CD9 = "suppress";

      }
      if(randomint(3) == 0) {
        self notify("return_to_cover");
        self._id_0CDC = 1;
      }

      return "retry";
    }
  }
}

_id_0CF0() {
  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    _id_0D00();
    return;
  }

  var_0 = self getanglestolikelyenemypath();

  if(!isDefined(var_0)) {
    if(isDefined(self._id_0CAF)) {
      var_0 = self._id_0CAF.angles;
    } else if(isDefined(self._id_0CF1)) {
      var_0 = self._id_0CF1.angles;
    } else if(isDefined(self.enemy)) {
      var_0 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
    } else {
      var_0 = self.angles;
    }
  }

  var_1 = 1024;

  if(isDefined(self.enemy)) {
    var_1 = distance(self.origin, self.enemy.origin);

  }
  var_2 = self getEye() + anglesToForward(var_0) * var_1;

  if(!isDefined(self._id_0CB1) || distancesquared(var_2, self._id_0CB1) > 25) {
    self._id_0CB1 = var_2;
  }
}

_id_0CF2() {
  if(self._id_0CD9 == "normal") {
    _id_0CEC();
  } else {
    if(_id_0CEB()) {
      self._id_0CD9 = "normal";
      self._id_0CE4 = undefined;
      return "retry";
    }

    _id_0CF7();

    if(animscripts\combat_utility::issniper()) {
      _id_0D09();

    }
    var_0 = animscripts\utility::_id_0CF3();

    if(self._id_0CD9 == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var_0) {
      _id_0CED(var_0);
    } else {
      _id_0CEF(var_0);
    }
  }
}

_id_0CF4() {
  if(!isDefined(self._id_0CE4)) {
    if(self isbadguy()) {
      self._id_0CE4 = gettime() + randomintrange(10000, 60000);
    } else {
      self._id_0CE4 = gettime() + randomintrange(4000, 10000);
    }
  }

  return self._id_0CE4 < gettime();
}

_id_0CF5() {
  if(!_id_0CEB()) {
    _id_0CF7();
    _id_0D01();
    return;
  }

  _id_0D00();
  self._id_0CDA = "single";
  var_0 = lengthsquared(self.origin - self._id_0CB1);

  if(var_0 < squared(512)) {
    self notify("return_to_cover");
    self._id_0CDC = 1;
    return;
  }
}

_id_0CF6() {
  if(self._id_0CD9 == "normal") {
    if(!_id_0CEB()) {
      if(!isDefined(self.enemy)) {
        _id_0D01();
        return;
      } else {
        _id_0CF7();
        self._id_0CD9 = "ambush";
        return "retry";
      }
    } else {
      _id_0D00();
      self._id_0CDA = "single";
    }
  } else {
    if(_id_0CEB()) {
      self._id_0CD9 = "normal";
      self._id_0CE4 = undefined;
      return "retry";
    }

    _id_0CF7();
    self._id_0CAB = undefined;
    self._id_0CDA = "none";
    self._id_0CB1 = animscripts\utility::_id_0CEE();

    if(!isDefined(self._id_0CE4)) {
      self._id_0CE4 = gettime() + randomintrange(4000, 8000);

    }
    if(self._id_0CE4 < gettime()) {
      self._id_0CD9 = "normal";
      self._id_0CE4 = undefined;
      return "retry";
    }
  }
}

_id_0CF7() {
  if(isDefined(self.enemy) && !self._id_0CDD && self.script != "combat") {
    if(isai(self.enemy) && isDefined(self.enemy.script) && (self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")) {
      if(isDefined(self.enemy.a._id_0CF8) && self.enemy.a._id_0CF8 == "hide") {
        return;
      }
    }

    self._id_0CF9 = self.enemy.origin;
  }
}

_id_0CFA() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for(;;) {
    self waittill("suppression");

    if(self.suppressionmeter > self._id_0CFB) {
      if(_id_0CFC()) {
        self notify("return_to_cover");
        self._id_0CDC = 1;
      }
    }
  }
}

_id_0CFC() {
  if(self._id_0CDD) {
    return 0;

  }
  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    return 1;

  }
  if(gettime() < self._id_0CFD + 800) {
    return 0;

  }
  if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self._id_0CFD + 3000) {
      return 0;
    }
  }

  return 1;
}

_id_0CFE() {
  self endon("death");
  common_scripts\utility::waittill_any("killanimscript", "stop_deciding_how_to_shoot");
  self.a._id_0CDF = 0;
  animscripts\shared::_id_0CE0();
}

_id_0CFF(var_0, var_1) {
  if(isDefined(var_0) != isDefined(var_1)) {
    return 1;

  }
  if(!isDefined(var_1)) {
    return 0;

  }
  return var_0 != var_1;
}

_id_0D00() {
  self._id_0CAB = self.enemy;
  self._id_0CB1 = self._id_0CAB getshootatpos();
}

_id_0D01() {
  self._id_0CAB = undefined;
  self._id_0CB1 = undefined;
  self._id_0CDA = "none";

  if(self.doingambush) {
    self._id_0CD9 = "ambush";

  }
  if(!self._id_0CDD) {
    self notify("return_to_cover");
    self._id_0CDC = 1;
  }
}

_id_0D02() {
  return level.gameskill == 3 && isplayer(self.enemy);
}

_id_0D03() {
  if(isDefined(self._id_0CAB.enemy) && isDefined(self._id_0CAB.enemy.syncedmeleetarget)) {
    return _id_0D06("single", 0);

  }
  if(animscripts\combat_utility::issniper()) {
    return _id_0D06("single", 0);

  }
  if(animscripts\utility::_id_0CEA(self.weapon)) {
    if(animscripts\utility::_id_0C97()) {
      return _id_0D06("single", 0);
    } else {
      return _id_0D06("semi", 0);
    }
  }

  if(weaponburstcount(self.weapon) > 0) {
    return _id_0D06("burst", 0);

  }
  if(isDefined(self._id_0A37) && self._id_0A37) {
    return _id_0D06("full", 1);

  }
  var_0 = distancesquared(self getshootatpos(), self._id_0CB1);
  var_1 = weaponclass(self.weapon) == "mg";

  if(self.providecoveringfire && var_1) {
    return _id_0D06("full", 0);

  }
  if(var_0 < 62500) {
    if(isDefined(self._id_0CAB) && isDefined(self._id_0CAB._id_0D04)) {
      return _id_0D06("single", 0);
    } else {
      return _id_0D06("full", 0);
    }
  } else if(var_0 < 810000 || _id_0D02()) {
    if(weaponissemiauto(self.weapon) || _id_0D07()) {
      return _id_0D06("semi", 1);
    } else {
      return _id_0D06("burst", 1);
    }
  } else if(self.providecoveringfire || var_1 || var_0 < 2560000) {
    if(_id_0D07()) {
      return _id_0D06("semi", 0);
    } else {
      return _id_0D06("burst", 0);
    }
  }

  return _id_0D06("single", 0);
}

_id_0D05() {
  var_0 = distancesquared(self getshootatpos(), self._id_0CB1);

  if(weaponissemiauto(self.weapon)) {
    if(var_0 < 2560000) {
      return _id_0D06("semi", 0);

    }
    return _id_0D06("single", 0);
  }

  if(weaponclass(self.weapon) == "mg") {
    return _id_0D06("full", 0);

  }
  if(self.providecoveringfire || var_0 < 2560000) {
    if(_id_0D07()) {
      return _id_0D06("semi", 0);
    } else {
      return _id_0D06("burst", 0);
    }
  }

  return _id_0D06("single", 0);
}

_id_0D06(var_0, var_1) {
  self._id_0CDA = var_0;
  self._id_0CDB = var_1;
}

_id_0D07() {
  if(weaponclass(self.weapon) != "rifle") {
    return 0;

  }
  if(self.team != "allies") {
    return 0;

  }
  var_0 = animscripts\utility::_id_0D08(int(self.origin[1]), 10000) + 2000;
  var_1 = int(self.origin[0]) + gettime();
  return var_1 % (2 * var_0) > var_0;
}

_id_0D09() {
  self._id_0D0A = 0;
  self._id_0D0B = 0;
  thread _id_0D0C();
}

_id_0D0C() {
  self endon("killanimscript");
  self endon("enemy");
  self endon("return_to_cover");
  self notify("new_glint_thread");
  self endon("new_glint_thread");

  if(isDefined(self._id_0D0D) && self._id_0D0D) {
    return;
  }
  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }
  if(!isalive(self.enemy)) {
    return;
  }
  var_0 = common_scripts\utility::getfx("sniper_glint");
  wait 0.2;

  for(;;) {
    if(self.weapon == self.primaryweapon && animscripts\combat_utility::_id_0D0E()) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536) {
        playFXOnTag(var_0, self, "tag_flash");

      }
      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}