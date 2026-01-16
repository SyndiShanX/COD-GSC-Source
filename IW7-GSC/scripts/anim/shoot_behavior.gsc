/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\shoot_behavior.gsc
*********************************************/

func_4F69(var_0) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");
  scripts\sp\gameskill::resetmisstime_code();
  self.var_FECA = var_0;
  self.var_FE9E = undefined;
  self.var_FECF = undefined;
  self.var_FED7 = "none";
  self.var_6B92 = 0;
  self.var_1006D = undefined;
  if(!isDefined(self.var_3C60)) {
    self.var_3C60 = 0;
  }

  var_1 = isDefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";
  if(var_1) {
    wait(0.05);
  }

  var_2 = self.var_FE9E;
  var_3 = self.var_FECF;
  var_4 = self.var_FED7;
  if(!isDefined(self.var_8B95)) {
    self.a.laseron = 1;
    scripts\anim\shared::updatelaserstatus();
  }

  if(scripts\anim\utility_common::isasniper()) {
    func_E26D();
  }

  if(var_1 && !self.a.var_2411 || !scripts\anim\utility_common::canseeenemy()) {
    thread func_13A46();
  }

  thread func_E883();
  self.var_1E2B = undefined;
  for(;;) {
    if(isDefined(self.var_FED1)) {
      if(!isDefined(self.enemy)) {
        self.var_FECF = self.var_FED1;
        self.var_FED1 = undefined;
        func_13696();
      } else {
        self.var_FED1 = undefined;
      }
    }

    var_5 = undefined;
    if(self.weapon == "none") {
      func_C064();
    } else if(scripts\anim\utility_common::usingrocketlauncher()) {
      var_5 = func_E778();
    } else if(scripts\anim\utility_common::isusingsidearm()) {
      var_5 = func_CBE2();
    } else {
      var_5 = func_E501();
    }

    if(isDefined(self.a.var_1096D)) {
      [
        [self.a.var_1096D]
      ]();
    }

    if(func_3DFB(var_2, self.var_FE9E) || !isDefined(self.var_FE9E) && func_3DFB(var_3, self.var_FECF) || func_3DFB(var_4, self.var_FED7)) {
      self notify("shoot_behavior_change");
    }

    var_2 = self.var_FE9E;
    var_3 = self.var_FECF;
    var_4 = self.var_FED7;
    if(!isDefined(var_5)) {
      func_13696();
    }
  }
}

func_13696() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");
  if(isDefined(self.var_FE9E)) {
    self.var_FE9E endon("death");
    self endon("do_slow_things");
    wait(0.05);
    while(isDefined(self.var_FE9E)) {
      self.var_FECF = self.var_FE9E getshootatpos();
      wait(0.05);
    }

    return;
  }

  self waittill("do_slow_things");
}

func_C064() {
  self.var_FE9E = undefined;
  self.var_FECF = undefined;
  self.var_FED7 = "none";
  self.var_FECA = "normal";
}

func_100A4() {
  return !scripts\anim\utility_common::isasniper() && !scripts\anim\utility_common::isshotgun(self.weapon);
}

func_E503() {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    if(scripts\anim\utility_common::isasniper()) {
      func_E26D();
    }

    if(self.var_FC) {
      self.var_FECA = "ambush";
      return "retry";
    }

    if(!isDefined(self.enemy)) {
      func_8C4D();
      return;
    }

    func_B376();
    if((self.assertmsg || randomint(5) > 0) && func_100A4()) {
      self.var_FECA = "suppress";
    } else {
      self.var_FECA = "ambush";
    }

    return "retry";
  }

  func_F83F();
  func_F842();
}

func_E504(var_0) {
  if(!var_0) {
    func_8C4D();
    return;
  }

  self.var_FE9E = undefined;
  self.var_FECF = scripts\anim\utility::func_7E90();
  func_F841();
}

func_E502(var_0) {
  self.var_FED7 = "none";
  self.var_FE9E = undefined;
  if(!var_0) {
    func_7DB9();
    if(func_1009A()) {
      self.var_1E2B = undefined;
      self notify("return_to_cover");
      self.var_1006D = 1;
      return;
    }

    return;
  }

  self.var_FECF = scripts\anim\utility::func_7E90();
  if(func_1009A()) {
    self.var_1E2B = undefined;
    if(func_100A4()) {
      self.var_FECA = "suppress";
    }

    if(randomint(3) == 0) {
      self notify("return_to_cover");
      self.var_1006D = 1;
    }

    return "retry";
  }
}

func_7DB9() {
  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    func_F83F();
    return;
  }

  var_0 = self getsafeanimmovedeltapercentage();
  if(!isDefined(var_0)) {
    if(isDefined(self.covernode)) {
      var_0 = self.covernode.angles;
    } else if(isDefined(self.var_1E2C)) {
      var_0 = self.var_1E2C.angles;
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
  if(!isDefined(self.var_FECF) || distancesquared(var_2, self.var_FECF) > 25) {
    self.var_FECF = var_2;
  }
}

func_E501() {
  if(self.var_FECA == "normal") {
    func_E503();
  } else {
    if(scripts\anim\utility_common::shouldshootenemyent()) {
      self.var_FECA = "normal";
      self.var_1E2B = undefined;
      return "retry";
    }

    func_B376();
    if(scripts\anim\utility_common::isasniper()) {
      func_E26D();
    }

    var_0 = scripts\anim\utility_common::cansuppressenemy();
    if(self.var_FECA == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var_0) {
      func_E504(var_0);
    } else {
      func_E502(var_0);
    }
  }
}

func_1009A() {
  if(!isDefined(self.var_1E2B)) {
    if(self gettargetchargepos()) {
      self.var_1E2B = gettime() + randomintrange(10000, -5536);
    } else {
      self.var_1E2B = gettime() + randomintrange(4000, 10000);
    }
  }

  return self.var_1E2B < gettime();
}

func_E778() {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    func_B376();
    func_8C4D();
    return;
  }

  func_F83F();
  func_F840("single", 0);
  var_0 = lengthsquared(self.origin - self.var_FECF);
  if(var_0 < squared(512)) {
    self notify("return_to_cover");
    self.var_1006D = 1;
  }
}

func_CBE2() {
  if(self.var_FECA == "normal") {
    if(!scripts\anim\utility_common::shouldshootenemyent()) {
      if(!isDefined(self.enemy)) {
        func_8C4D();
        return;
      }

      func_B376();
      self.var_FECA = "ambush";
      return "retry";
    }

    func_F83F();
    func_F840("single", 0);
    return;
  }

  if(scripts\anim\utility_common::shouldshootenemyent()) {
    self.var_FECA = "normal";
    self.var_1E2B = undefined;
    return "retry";
  }

  func_B376();
  self.var_FE9E = undefined;
  self.var_FED7 = "none";
  self.var_FECF = scripts\anim\utility::func_7E90();
  if(!isDefined(self.var_1E2B)) {
    self.var_1E2B = gettime() + randomintrange(4000, 8000);
  }

  if(self.var_1E2B < gettime()) {
    self.var_FECA = "normal";
    self.var_1E2B = undefined;
    return "retry";
  }
}

func_B376() {
  if(isDefined(self.enemy) && !self.var_3C60 && self.script != "combat") {
    if(isai(self.enemy) && isDefined(self.enemy.script) && self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch") {
      if(isDefined(self.enemy.a.var_4727) && self.enemy.a.var_4727 == "hide") {
        return;
      }
    }

    self.var_46A6 = self.enemy.origin;
  }
}

func_13A46() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");
  for(;;) {
    self waittill("suppression");
    if(self.suppressionmeter > self.suppressionthreshold) {
      if(func_DD7D()) {
        self notify("return_to_cover");
        self.var_1006D = 1;
      }
    }
  }
}

func_DD7D() {
  if(self.var_3C60) {
    return 0;
  }

  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    return 1;
  }

  if(gettime() < self.var_4740 + 800) {
    return 0;
  }

  if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self.var_4740 + 3000) {
      return 0;
    }
  }

  return 1;
}

func_E883() {
  self endon("death");
  scripts\engine\utility::waittill_any("killanimscript", "stop_deciding_how_to_shoot");
  self.a.laseron = 0;
  scripts\anim\shared::updatelaserstatus();
}

func_3DFB(var_0, var_1) {
  if(isDefined(var_0) != isDefined(var_1)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 != var_1;
}

func_F83F() {
  self.var_FE9E = self.enemy;
  self.var_FECF = self.var_FE9E getshootatpos();
}

func_8C4D() {
  self.var_FE9E = undefined;
  self.var_FECF = undefined;
  self.var_FED7 = "none";
  if(self.var_FC) {
    self.var_FECA = "ambush";
  }

  if(!self.var_3C60) {
    self notify("return_to_cover");
    self.var_1006D = 1;
  }
}

func_FFC6() {
  return level.var_7683 == 3 && isplayer(self.enemy);
}

func_F842() {
  if(isDefined(self.var_FE9E.enemy) && isDefined(self.var_FE9E.enemy.physics_setgravityragdollscalar)) {
    return func_F840("single", 0);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return func_F840("single", 0);
  }

  if(scripts\anim\utility_common::isshotgun(self.weapon)) {
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      return func_F840("single", 0);
    } else {
      return func_F840("semi", 0);
    }
  }

  if(weaponclass(self.weapon) == "grenade") {
    return func_F840("single", 0);
  }

  if(weaponburstcount(self.weapon) > 0) {
    return func_F840("burst", 0);
  }

  if(isDefined(self.var_A4A3) && self.var_A4A3) {
    return func_F840("full", 1);
  }

  var_0 = distancesquared(self getshootatpos(), self.var_FECF);
  var_1 = weaponclass(self.weapon) == "mg";
  if(self.assertmsg && var_1) {
    return func_F840("full", 0);
  }

  if(var_0 < -3036) {
    if(isDefined(self.var_FE9E) && isDefined(self.var_FE9E.var_B14F)) {
      return func_F840("single", 0);
    } else {
      return func_F840("full", 0);
    }
  } else if(var_0 < 810000 || func_FFC6()) {
    if(weaponissemiauto(self.weapon) || func_FFF6()) {
      return func_F840("semi", 1);
    } else {
      return func_F840("burst", 1);
    }
  } else if(self.assertmsg || var_1 || var_0 < 2560000) {
    if(func_FFF6()) {
      return func_F840("semi", 0);
    } else {
      return func_F840("burst", 0);
    }
  }

  return func_F840("single", 0);
}

func_F841() {
  var_0 = distancesquared(self getshootatpos(), self.var_FECF);
  if(weaponissemiauto(self.weapon)) {
    if(var_0 < 2560000) {
      return func_F840("semi", 0);
    }

    return func_F840("single", 0);
  }

  if(weaponclass(self.weapon) == "mg") {
    return func_F840("full", 0);
  }

  if(self.assertmsg || var_0 < 2560000) {
    if(func_FFF6()) {
      return func_F840("semi", 0);
    } else {
      return func_F840("burst", 0);
    }
  }

  return func_F840("single", 0);
}

func_F840(var_0, var_1) {
  self.var_FED7 = var_0;
  self.var_6B92 = var_1;
}

func_FFF6() {
  if(weaponclass(self.weapon) != "rifle") {
    return 0;
  }

  if(self.team != "allies") {
    return 0;
  }

  var_0 = scripts\anim\utility_common::safemod(int(self.origin[1]), 10000) + 2000;
  var_1 = int(self.origin[0]) + gettime();
  return var_1 % 2 * var_0 > var_0;
}

func_E26D() {
  self.var_103BF = 0;
  self.var_103BA = 0;
  thread func_103A7();
}

func_103A7() {
  self endon("killanimscript");
  self endon("enemy");
  self endon("return_to_cover");
  self notify("new_glint_thread");
  self endon("new_glint_thread");
  if(isDefined(self.var_5583) && self.var_5583) {
    return;
  }

  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }

  var_0 = scripts\engine\utility::getfx("sniper_glint");
  wait(0.2);
  for(;;) {
    if(self.weapon == self.primaryweapon && scripts\anim\combat_utility::func_D285()) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536) {
        playFXOnTag(var_0, self, "tag_flash");
      }

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait(0.2);
  }
}