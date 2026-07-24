/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\shoot_behavior.gsc
*******************************************/

_id_4F69(var_0) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");
  scripts\sp\gameskill::resetmisstime_code();
  self._id_FECA = var_0;
  self._id_FE9E = undefined;
  self._id_FECF = undefined;
  self._id_FED7 = "none";
  self._id_6B92 = 0;
  self._id_1006D = undefined;

  if(!isDefined(self._id_3C60))
    self._id_3C60 = 0;

  var_1 = isDefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";

  if(var_1)
    wait 0.05;

  var_2 = self._id_FE9E;
  var_3 = self._id_FECF;
  var_4 = self._id_FED7;

  if(!isDefined(self._id_8B95)) {
    self.a.laseron = 1;
    scripts\anim\shared::updatelaserstatus();
  }

  if(scripts\anim\utility_common::isasniper())
    _id_E26D();

  if(var_1 && (!self.a._id_2411 || !scripts\anim\utility_common::canseeenemy()))
    thread _id_13A46();

  thread _id_E883();
  self._id_1E2B = undefined;

  for(;;) {
    if(isDefined(self._id_FED1)) {
      if(!isDefined(self.enemy)) {
        self._id_FECF = self._id_FED1;
        self._id_FED1 = undefined;
        _id_13696();
      } else
        self._id_FED1 = undefined;
    }

    var_5 = undefined;

    if(self.weapon == "none")
      _id_C064();
    else if(scripts\anim\utility_common::usingrocketlauncher())
      var_5 = _id_E778();
    else if(scripts\anim\utility_common::isusingsidearm())
      var_5 = _id_CBE2();
    else
      var_5 = _id_E501();

    if(isDefined(self.a._id_1096D))
      [[self.a._id_1096D]]();

    if(_id_3DFB(var_2, self._id_FE9E) || !isDefined(self._id_FE9E) && _id_3DFB(var_3, self._id_FECF) || _id_3DFB(var_4, self._id_FED7))
      self notify("shoot_behavior_change");

    var_2 = self._id_FE9E;
    var_3 = self._id_FECF;
    var_4 = self._id_FED7;

    if(!isDefined(var_5))
      _id_13696();
  }
}

_id_13696() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");

  if(isDefined(self._id_FE9E)) {
    self._id_FE9E endon("death");
    self endon("do_slow_things");
    wait 0.05;

    while(isDefined(self._id_FE9E)) {
      self._id_FECF = self._id_FE9E getshootatpos();
      wait 0.05;
    }
  } else
    self waittill("do_slow_things");
}

_id_C064() {
  self._id_FE9E = undefined;
  self._id_FECF = undefined;
  self._id_FED7 = "none";
  self._id_FECA = "normal";
}

_id_100A4() {
  return !scripts\anim\utility_common::isasniper() && !scripts\anim\utility_common::isshotgun(self.weapon);
}

_id_E503() {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    if(scripts\anim\utility_common::isasniper())
      _id_E26D();

    if(self.doingambush) {
      self._id_FECA = "ambush";
      return "retry";
    }

    if(!isDefined(self.enemy))
      _id_8C4D();
    else {
      _id_B376();

      if((self.providecoveringfire || randomint(5) > 0) && _id_100A4())
        self._id_FECA = "suppress";
      else
        self._id_FECA = "ambush";

      return "retry";
    }
  } else {
    _id_F83F();
    _id_F842();
  }
}

_id_E504(var_0) {
  if(!var_0)
    _id_8C4D();
  else {
    self._id_FE9E = undefined;
    self._id_FECF = scripts\anim\utility::_id_7E90();
    _id_F841();
  }
}

_id_E502(var_0) {
  self._id_FED7 = "none";
  self._id_FE9E = undefined;

  if(!var_0) {
    _id_7DB9();

    if(_id_1009A()) {
      self._id_1E2B = undefined;
      self notify("return_to_cover");
      self._id_1006D = 1;
    }
  } else {
    self._id_FECF = scripts\anim\utility::_id_7E90();

    if(_id_1009A()) {
      self._id_1E2B = undefined;

      if(_id_100A4())
        self._id_FECA = "suppress";

      if(randomint(3) == 0) {
        self notify("return_to_cover");
        self._id_1006D = 1;
      }

      return "retry";
    }
  }
}

_id_7DB9() {
  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    _id_F83F();
    return;
  }

  var_0 = self _meth_80FC();

  if(!isDefined(var_0)) {
    if(isDefined(self.covernode))
      var_0 = self.covernode.angles;
    else if(isDefined(self._id_1E2C))
      var_0 = self._id_1E2C.angles;
    else if(isDefined(self.enemy))
      var_0 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
    else
      var_0 = self.angles;
  }

  var_1 = 1024;

  if(isDefined(self.enemy))
    var_1 = distance(self.origin, self.enemy.origin);

  var_2 = self getEye() + anglesToForward(var_0) * var_1;

  if(!isDefined(self._id_FECF) || distancesquared(var_2, self._id_FECF) > 25)
    self._id_FECF = var_2;
}

_id_E501() {
  if(self._id_FECA == "normal")
    _id_E503();
  else {
    if(scripts\anim\utility_common::shouldshootenemyent()) {
      self._id_FECA = "normal";
      self._id_1E2B = undefined;
      return "retry";
    }

    _id_B376();

    if(scripts\anim\utility_common::isasniper())
      _id_E26D();

    var_0 = scripts\anim\utility_common::cansuppressenemy();

    if(self._id_FECA == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var_0)
      _id_E504(var_0);
    else
      _id_E502(var_0);
  }
}

_id_1009A() {
  if(!isDefined(self._id_1E2B)) {
    if(self isbadguy())
      self._id_1E2B = gettime() + randomintrange(10000, 60000);
    else
      self._id_1E2B = gettime() + randomintrange(4000, 10000);
  }

  return self._id_1E2B < gettime();
}

_id_E778() {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    _id_B376();
    _id_8C4D();
    return;
  }

  _id_F83F();
  _id_F840("single", 0);
  var_0 = lengthsquared(self.origin - self._id_FECF);

  if(var_0 < squared(512)) {
    self notify("return_to_cover");
    self._id_1006D = 1;
    return;
  }
}

_id_CBE2() {
  if(self._id_FECA == "normal") {
    if(!scripts\anim\utility_common::shouldshootenemyent()) {
      if(!isDefined(self.enemy)) {
        _id_8C4D();
        return;
      } else {
        _id_B376();
        self._id_FECA = "ambush";
        return "retry";
      }
    } else {
      _id_F83F();
      _id_F840("single", 0);
    }
  } else {
    if(scripts\anim\utility_common::shouldshootenemyent()) {
      self._id_FECA = "normal";
      self._id_1E2B = undefined;
      return "retry";
    }

    _id_B376();
    self._id_FE9E = undefined;
    self._id_FED7 = "none";
    self._id_FECF = scripts\anim\utility::_id_7E90();

    if(!isDefined(self._id_1E2B))
      self._id_1E2B = gettime() + randomintrange(4000, 8000);

    if(self._id_1E2B < gettime()) {
      self._id_FECA = "normal";
      self._id_1E2B = undefined;
      return "retry";
    }
  }
}

_id_B376() {
  if(isDefined(self.enemy) && !self._id_3C60 && self.script != "combat") {
    if(isai(self.enemy) && isDefined(self.enemy.script) && (self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")) {
      if(isDefined(self.enemy.a._id_4727) && self.enemy.a._id_4727 == "hide")
        return;
    }

    self._id_46A6 = self.enemy.origin;
  }
}

_id_13A46() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for(;;) {
    self waittill("suppression");

    if(self.suppressionmeter > self.suppressionthreshold) {
      if(_id_DD7D()) {
        self notify("return_to_cover");
        self._id_1006D = 1;
      }
    }
  }
}

_id_DD7D() {
  if(self._id_3C60)
    return 0;

  if(!isDefined(self.enemy) || !self cansee(self.enemy))
    return 1;

  if(gettime() < self._id_4740 + 800)
    return 0;

  if(isPlayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self._id_4740 + 3000)
      return 0;
  }

  return 1;
}

_id_E883() {
  self endon("death");
  scripts\engine\utility::waittill_any("killanimscript", "stop_deciding_how_to_shoot");
  self.a.laseron = 0;
  scripts\anim\shared::updatelaserstatus();
}

_id_3DFB(var_0, var_1) {
  if(isDefined(var_0) != isDefined(var_1))
    return 1;

  if(!isDefined(var_1))
    return 0;

  return var_0 != var_1;
}

_id_F83F() {
  self._id_FE9E = self.enemy;
  self._id_FECF = self._id_FE9E getshootatpos();
}

_id_8C4D() {
  self._id_FE9E = undefined;
  self._id_FECF = undefined;
  self._id_FED7 = "none";

  if(self.doingambush)
    self._id_FECA = "ambush";

  if(!self._id_3C60) {
    self notify("return_to_cover");
    self._id_1006D = 1;
  }
}

_id_FFC6() {
  return level._id_7683 == 3 && isPlayer(self.enemy);
}

_id_F842() {
  if(isDefined(self._id_FE9E.enemy) && isDefined(self._id_FE9E.enemy.syncedmeleetarget))
    return _id_F840("single", 0);

  if(scripts\anim\utility_common::isasniper())
    return _id_F840("single", 0);

  if(scripts\anim\utility_common::isshotgun(self.weapon)) {
    if(scripts\anim\utility_common::weapon_pump_action_shotgun())
      return _id_F840("single", 0);
    else
      return _id_F840("semi", 0);
  }

  if(weaponclass(self.weapon) == "grenade")
    return _id_F840("single", 0);

  if(weaponburstcount(self.weapon) > 0)
    return _id_F840("burst", 0);

  if(isDefined(self._id_A4A3) && self._id_A4A3)
    return _id_F840("full", 1);

  var_0 = distancesquared(self getshootatpos(), self._id_FECF);
  var_1 = weaponclass(self.weapon) == "mg";

  if(self.providecoveringfire && var_1)
    return _id_F840("full", 0);

  if(var_0 < 62500) {
    if(isDefined(self._id_FE9E) && isDefined(self._id_FE9E._id_B14F))
      return _id_F840("single", 0);
    else
      return _id_F840("full", 0);
  } else if(var_0 < 810000 || _id_FFC6()) {
    if(weaponissemiauto(self.weapon) || _id_FFF6())
      return _id_F840("semi", 1);
    else
      return _id_F840("burst", 1);
  } else if(self.providecoveringfire || var_1 || var_0 < 2560000) {
    if(_id_FFF6())
      return _id_F840("semi", 0);
    else
      return _id_F840("burst", 0);
  }

  return _id_F840("single", 0);
}

_id_F841() {
  var_0 = distancesquared(self getshootatpos(), self._id_FECF);

  if(weaponissemiauto(self.weapon)) {
    if(var_0 < 2560000)
      return _id_F840("semi", 0);

    return _id_F840("single", 0);
  }

  if(weaponclass(self.weapon) == "mg")
    return _id_F840("full", 0);

  if(self.providecoveringfire || var_0 < 2560000) {
    if(_id_FFF6())
      return _id_F840("semi", 0);
    else
      return _id_F840("burst", 0);
  }

  return _id_F840("single", 0);
}

_id_F840(var_0, var_1) {
  self._id_FED7 = var_0;
  self._id_6B92 = var_1;
}

_id_FFF6() {
  if(weaponclass(self.weapon) != "rifle")
    return 0;

  if(self.team != "allies")
    return 0;

  var_0 = scripts\anim\utility_common::safemod(int(self.origin[1]), 10000) + 2000;
  var_1 = int(self.origin[0]) + gettime();
  return var_1 % (2 * var_0) > var_0;
}

_id_E26D() {
  self._id_103BF = 0;
  self._id_103BA = 0;
  thread _id_103A7();
}

_id_103A7() {
  self endon("killanimscript");
  self endon("enemy");
  self endon("return_to_cover");
  self notify("new_glint_thread");
  self endon("new_glint_thread");

  if(isDefined(self._id_5583) && self._id_5583) {
    return;
  }
  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }
  if(!isalive(self.enemy)) {
    return;
  }
  var_0 = scripts\engine\utility::getfx("sniper_glint");
  wait 0.2;

  for(;;) {
    if(self.weapon == self.primaryweapon && scripts\anim\combat_utility::_id_D285()) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536)
        playFXOnTag(var_0, self, "tag_flash");

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}