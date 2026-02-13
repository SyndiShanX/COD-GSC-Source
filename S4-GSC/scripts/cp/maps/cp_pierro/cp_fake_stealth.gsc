/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_pierro\cp_fake_stealth.gsc
*********************************************************/

_id_3E0E() {
  scripts\engine\utility::_id_5C11("fake_stealth_paused");
  level._id_3B89 = cos(65);
  level thread _id_9604();
  level._id_416C = 0;

  for(;;) {
    if(scripts\engine\utility::_id_5C00("fake_stealth_paused")) {
      waitframe();
      continue;
    }

    var_0 = _id_06FE::_id_68A1("axis");

    if(var_0.size == 0) {
      waitframe();
      continue;
    }

    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_8A45)) {
        continue;
      }
      if(isDefined(var_2._id_5904)) {
        continue;
      }
      var_2._id_4D7A = 1;
      var_2._id_5904 = 1;
      var_2 thread _id_11029();
      var_2 thread _id_E7D8(var_2.origin);
      waitframe();
    }

    waitframe();
  }
}

_id_D456(var_0) {}

_id_11029() {
  self endon("death");
  self endon("exit_stealth");

  if(!istrue(self._id_7598)) {
    wait 2;
  }

  waitframe();
  self._id_0229 = 1;
  self._id_CF4A = 1;
  _id_5905();
  var_0 = scripts\engine\utility::waittill_any_return("alerted", "damage");

  if(var_0 == "damage") {
    self._id_5906 = "took damage";
  }

  if(isDefined(self._id_A991)) {
    self._id_0201 = self._id_A991;
  }

  if(self _meth_85EC()) {
    self _meth_82BE(self.origin);
  } else {
    self _meth_8326(self.origin);
    self _meth_8474();
  }

  self._id_0229 = 0;
  self._id_CF4A = 0;
  self._id_91A3._id_02D6 = "sprint";
  wait 5;
  thread _id_C7BA();
}

_id_C7BA() {
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    while(!isDefined(self._id_0192)) {
      waitframe();
      continue;
    }

    if(!isPlayer(self._id_0192)) {
      waitframe();
      continue;
    }

    var_0 = self._id_0192;
    var_1 = distance(var_0.origin, self.origin);
    var_2 = self _meth_8067(var_0) && _func_0202(self getEye(), var_0.origin + (0, 0, 40), 0, self);
    var_3 = scripts\engine\utility::_id_10E76(self getEye(), self gettagangles("tag_eye"), var_0.origin + (0, 0, 40), level._id_3B89);
    var_4 = var_0 getstance();

    if(var_2 && var_3) {
      if(var_1 < 650) {
        if(var_4 == "stand") {
          wait 0.25;
          continue;
        } else {
          _id_7065(var_0);
          return;
        }
      } else if(var_1 < 128) {
        if(var_4 == "prone") {
          wait 0.25;
          continue;
        } else {
          _id_7065(var_0);
          return;
        }
      }
    } else if(var_1 > 196) {
      _id_7065(var_0);
      return;
    }

    wait 0.25;
  }
}

_id_7065(var_0) {
  self._id_5906 = "going_to_last_position";
  self._id_CF4A = 1;
  self._id_0229 = 1;
  thread _id_11029();
  thread _id_7074(var_0.origin);
}

_id_5905() {
  thread _id_10E0F();
  thread _id_7147();
  thread _id_552D();
  thread _id_B558();
  thread _id_B645();
  _id_D3CA(self, 0);
  thread _id_11017();
  thread _id_4F10();
}

_id_10E0F() {
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    self waittill("bulletwhizby", var_0);
    self._id_5906 = "investigating_bullet_whizby";
    thread _id_7074(var_0.origin);
  }
}

_id_552D() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    level waittill("environment_alert", var_0);

    if(distance(self.origin, var_0) > 650) {
      continue;
    } else {
      self._id_5906 = "investigating environment";
      thread _id_7074(var_0);
    }
  }
}

_id_7147() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    self waittill("explode", var_0);

    if(distance(self.origin, var_0) > 1000) {
      continue;
    } else {
      self._id_5906 = "investigating_grenade explosion";
      thread _id_7074(var_0);
    }
  }
}

_id_B558() {
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distance(var_1.origin, self.origin);

      if(var_2 > 600) {
        continue;
      }
      if(var_2 < 96) {
        self._id_5906 = "spotted";
        self notify("alerted");
        break;
      }

      var_3 = self _meth_8067(var_1) && _func_0202(self getEye(), var_1.origin + (0, 0, 40), 0, self);
      var_4 = var_1 getstance();

      if(var_3) {
        var_5 = scripts\engine\utility::_id_10E76(self getEye(), self gettagangles("tag_eye"), var_1.origin + (0, 0, 40), level._id_3B89);

        if(!var_5) {
          continue;
        }
        if(var_2 <= 600 && var_4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self._id_5906 = "spotted";
          self notify("alerted");
          return;
        } else if(var_2 <= 400 && var_4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self._id_5906 = "spotted";
          self notify("alerted");
          return;
        } else if(var_2 <= 200 && var_4 != "prone") {
          self playSound("emt_wood_barrier_destr");
          self._id_5906 = "spotted";
          self notify("alerted");
          return;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

_id_E7D8(var_0) {
  self endon("death");
  self endon("alerted");
  self endon("new_goal");
  self endon("exit_stealth");
  self._id_A991 = self._id_0201;

  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_1 = _func_02AA(var_0, 350, 6);

  if(!isDefined(var_1)) {
    return;
  }
  self._id_5906 = "patrol";

  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);

    if(self _meth_85EC()) {
      self _meth_82BF(8);
      self _meth_82BE(var_2);
    } else {
      self._id_0201 = 8;
      self _meth_8326(var_2);
    }

    scripts\engine\utility::_id_1087F("goal", "goal_reached");
    wait(randomfloatrange(0.05, 3));
  }
}

_id_7074(var_0) {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");
  self notify("new_goal");
  self endon("new_goal");

  if(self _meth_85EC()) {
    self _meth_82BE(self.origin);
    scripts\engine\utility::_id_1087F("goal", "goal_reached");
  } else {
    self _meth_8326(self.origin);
    self _meth_8474();
  }

  if(!isDefined(self._id_91A3)) {
    iprintln("** - LEGACY IS UNDEFINED FOR : " + self getentitynumber() + ", health: " + self.health + ", agent: " + self._id_1210);
    self._id_91A3 = spawnStruct();
  }

  self._id_91A3._id_02D6 = "sprint";

  if(self _meth_85EC()) {
    self _meth_82BE(_func_02AB(var_0));
    var_1 = scripts\engine\utility::waittill_any_return("goal", "goal_reached");
  } else {
    self _meth_8326(_func_02AB(var_0));
    self waittill("goal");
  }

  self._id_91A3._id_02D6 = "slow_walk";
  wait 3;
  self._id_5906 = "patrol";
  thread _id_E7D8(var_0);
}

_id_10CF6() {
  self notify("weapon_fire_monitor");
  self endon("weapon_fire_monitor");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired");
    level notify("weapon_fired", self.origin, self getcurrentweapon());
  }
}

_id_B645() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    level waittill("weapon_fired", var_0, var_1);

    if(distance(var_0, self.origin) > 1500) {
      continue;
    } else {
      self._id_5906 = "investigating_weapon_fire";
      thread _id_7074(var_0);
    }
  }
}

_id_11017() {
  self endon("death");
  self notify("texthandler");
  self endon("texthandler");

  for(;;) {
    if(getDvar("#x385a1810201b75220") == "") {
      wait 1;
      continue;
    }

    waitframe();
  }
}

_id_4F10() {
  self notify("draw_fov");
  self endon("draw_fov");
  self endon("death");

  for(;;) {
    if(getDvar("#x3ce0bfb22e0e23328") == "") {
      wait 1;
      continue;
    }

    var_0 = self gettagorigin("tag_eye");
    var_1 = self gettagangles("tag_eye");
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * self._id_E804._id_E589;
    waitframe();
  }
}

_id_9604() {
  level._id_11055 = [];
  var_0 = "scripts/cp/zombie_stealth.csv";
  var_1 = 1;
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, var_1);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4._id_E589 = int(tablelookupbyrow(var_0, 2, var_1));
    var_4._id_40A3 = int(tablelookupbyrow(var_0, 3, var_1));
    var_4._id_BDAE = int(tablelookupbyrow(var_0, 4, var_1));
    var_4._id_7889 = int(tablelookupbyrow(var_0, 5, var_1));
    var_4._id_7882 = int(tablelookupbyrow(var_0, 6, var_1));
    var_4._id_7887 = int(tablelookupbyrow(var_0, 7, var_1));
    var_4._id_BDB9 = int(tablelookupbyrow(var_0, 8, var_1));
    var_4._id_F205 = int(tablelookupbyrow(var_0, 9, var_1));
    var_4._id_F204 = int(tablelookupbyrow(var_0, 10, var_1));
    var_4._id_4B92 = int(tablelookupbyrow(var_0, 11, var_1));
    var_4._id_F212 = int(tablelookupbyrow(var_0, 12, var_1));
    var_4._id_11077 = tablelookupbyrow(var_0, 13, var_1);
    var_4._id_B7DC = int(tablelookupbyrow(var_0, 14, var_1));
    var_4._id_B686 = int(tablelookupbyrow(var_0, 15, var_1));
    var_4._id_B75D = int(tablelookupbyrow(var_0, 16, var_1));
    var_4._id_7886 = int(tablelookupbyrow(var_0, 17, var_1));
    var_4._id_7884 = int(tablelookupbyrow(var_0, 18, var_1));
    var_4._id_7885 = int(tablelookupbyrow(var_0, 19, var_1));
    var_4._id_B721 = int(tablelookupbyrow(var_0, 20, var_1));
    var_4._id_98A2 = int(tablelookupbyrow(var_0, 21, var_1));
    level._id_11055[int(var_3)] = var_4;
    var_1++;
  }
}

_id_D3CA(var_0, var_1) {
  var_1 = "" + var_1;
  var_2 = spawnStruct();
  var_2._id_E589 = level._id_11055[var_1]._id_E589;
  var_2._id_40A3 = level._id_11055[var_1]._id_40A3;
  var_2._id_BDAE = level._id_11055[var_1]._id_BDAE;
  var_2._id_7889 = level._id_11055[var_1]._id_7889;
  var_2._id_7882 = level._id_11055[var_1]._id_7882;
  var_2._id_7887 = level._id_11055[var_1]._id_7887;
  var_2._id_BDB9 = level._id_11055[var_1]._id_BDB9;
  var_2._id_F205 = level._id_11055[var_1]._id_F205;
  var_2._id_F204 = level._id_11055[var_1]._id_F204;
  var_2._id_4B92 = level._id_11055[var_1]._id_4B92;
  var_2._id_F212 = level._id_11055[var_1]._id_F212;
  var_2._id_11077 = level._id_11055[var_1]._id_11077;
  var_2._id_B7DC = level._id_11055[var_1]._id_B7DC;
  var_2._id_B686 = level._id_11055[var_1]._id_B686;
  var_2._id_B75D = level._id_11055[var_1]._id_B75D;
  var_2._id_7886 = level._id_11055[var_1]._id_7886;
  var_2._id_7884 = level._id_11055[var_1]._id_7884;
  var_2._id_7885 = level._id_11055[var_1]._id_7885;
  var_2._id_B721 = level._id_11055[var_1]._id_B721;
  var_2._id_98A2 = level._id_11055[var_1]._id_98A2;
  var_0._id_E804 = var_2;
}