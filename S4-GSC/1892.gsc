/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1892.gsc
*************************************************/

_id_CF31() {
  scripts\engine\utility::_id_5C11("fake_stealth_paused");
  _id_9604();
  level._id_3B89 = cos(65);
  level._id_416C = 0;
  level._id_9C6C = level._id_11055.size;
  level._id_A3F5 = [];
}

_id_8884(var_0) {
  if(isDefined(var_0._id_03E9) && isDefined(var_0._id_03E9._id_CE18) && (var_0._id_03E9._id_CE18 == "ground_spawn_no_boards" || var_0._id_03E9._id_CE18 == "ground_spawn")) {
    return 1;
  } else {
    return 0;
  }
}

_id_110A4(var_0, var_1) {
  var_0 notify("zombieScriptedStealth");
  var_0 endon("zombieScriptedStealth");
  var_0 endon("death");
  var_0 endon("exit_stealth");
  level endon("game_ended");

  for(;;) {
    var_0._id_0229 = 1;
    var_0._id_CF4A = 1;
    var_0._id_CF7C = 1;
    var_0 _id_5905(var_1);
    var_2 = var_0 scripts\engine\utility::_id_10899("alerted", "damage", "reset_stealth", "alerted_by_ai");

    if(!isDefined(var_2) || var_2 == "reset_stealth") {
      continue;
    }
    var_0._id_5E96 = undefined;
    var_0._id_CF7C = undefined;

    if(var_2 == "alerted" || var_2 == "damage") {
      foreach(var_4 in scripts\engine\utility::_id_6369(var_0.origin, level._id_E2A4, [var_0], undefined, _id_6EA5(var_0)._id_BDB9, 0)) {
        if(var_4._id_1210 != var_0._id_1210) {
          continue;
        }
        if(var_4.team != var_0.team) {
          continue;
        }
        if(var_4 != var_0) {
          var_4 notify("alerted");
        }
      }
    }

    if(var_2 == "alerted") {
      _id_D6F1("spotted");
    } else if(var_2 == "damage") {
      _id_D6F1("took damage");
    }

    _id_341D(var_0);
  }
}

_id_341D(var_0) {
  var_0 endon("death");

  if(isDefined(var_0._id_A991)) {
    var_0._id_0201 = var_0._id_A991;
  }

  var_0 _meth_8326(var_0.origin);
  var_0._id_0229 = 0;
  var_0._id_CF4A = 0;
  var_0._id_4D7A = undefined;
  var_0._id_5904 = 0;
  var_0._id_91A3._id_02D6 = "sprint";
  var_1 = _id_6EA5(var_0)._id_F212;
  var_2 = 0;
  var_3 = _id_6EA5(var_0)._id_4B92;
  var_4 = 0.5;

  while(var_2 < var_1) {
    var_5 = 0;
    var_6 = scripts\engine\utility::array_combine(level.players, _id_06FE::_id_6884(var_0.team));

    foreach(var_8 in var_6) {
      if(istrue(var_8.ignoreme)) {
        continue;
      }
      if(_id_8821(var_0, var_8, 0, 0)) {
        var_2 = 0;
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_2 = var_2 + var_4;
    }

    wait(var_4);
  }
}

_id_6D8E() {
  if(isDefined(self._id_AF40)) {
    return self._id_AF40;
  } else {
    return undefined;
  }
}

_id_D6F1(var_0) {
  self._id_AF40 = var_0;
  self notify("stealth_state_changed");
}

_id_5905(var_0) {
  _id_D3CA(self, int(level._id_416C));
  thread _id_D46E(self, var_0);
  thread _id_10E0F(self);
  thread _id_7147(self);
  thread _id_552D(self);
  thread _id_B558(self);
  thread _id_B645(self);
  thread _id_A1FE(self);
  thread _id_E7D8(self.origin);
  self._id_5904 = 1;
  self notify("fake_stealth_set");
}

_id_D46E(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  if(istrue(var_1)) {
    wait 0.15;
  }

  var_2 = strtok(var_0._id_E804._id_11077, ",");
  var_3 = scripts\engine\utility::random(var_2);
  var_0._id_91A3._id_02D6 = var_3;
  var_0 _id_D6F0(var_0, var_3);
}

_id_D6F0(var_0, var_1) {
  var_0 _id_06BD::_id_23F3(var_1);
}

_id_A1FE(var_0) {
  var_0 notify("move_speed_monitor");
  var_0 endon("move_speed_monitor");
  var_0 endon("alerted");
  var_0 endon("alerted_by_ai");
  var_0 endon("exit_stealth");
  var_0 endon("death");
  var_0 endon("new_goal");

  for(;;) {
    if(istrue(var_0._id_CF7C)) {
      var_1 = strtok(_id_6EA5(var_0)._id_11077, ",");
      var_2 = scripts\engine\utility::random(var_1);
      var_0 _id_D6F0(var_0, var_2);
    }

    scripts\engine\utility::_id_10888(var_0, "stealth_values_set", level, "runSpawnModule");
  }
}

_id_10E0F(var_0) {
  var_0 notify("whizby_listener");
  var_0 endon("whizby_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  for(;;) {
    var_0 waittill("bulletwhizby", var_1);

    if(istrue(var_1.ignoreme)) {
      continue;
    }
    if(isagent(var_1)) {
      var_0 _id_D6F1("spotted");
      var_0 playSound("zmb_vo_cop_pain");
      var_0 notify("alerted_by_ai");
      continue;
    }

    if(istrue(var_0._id_CF7C)) {
      var_0 thread _id_7074(var_0, var_1.origin, undefined, "investigating_bullet_whizby");
    }
  }
}

_id_552D(var_0) {
  var_0 notify("environment_listener");
  var_0 endon("environment_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");
  var_0 endon("new_goal");

  for(;;) {
    level waittill("environment_alert", var_1);

    if(!istrue(var_0._id_CF7C)) {
      continue;
    }
    if(distance(var_0.origin, var_1) > 650) {
      continue;
    } else {
      var_0 thread _id_7074(var_0, var_1, undefined, "investigating environment");
    }
  }
}

_id_7147(var_0) {
  var_0 notify("grenade_listener");
  var_0 endon("grenade_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");
  var_0 endon("new_goal");

  for(;;) {
    var_0 waittill("explode", var_1);

    if(!istrue(var_0._id_CF7C)) {
      continue;
    }
    if(distance(var_0.origin, var_1) > 1500) {
      continue;
    } else {
      var_0 thread _id_7074(var_0, var_1, undefined, "investigating_grenade explosion");
    }
  }
}

_id_5421(var_0) {
  level endon("game_ended");
  var_0 notify("enemyNearbyListener");
  var_0 endon("enemyNearbyListener");
  var_0 endon("alerted");
  var_0 endon("death");
  var_0 endon("exit_stealth");

  for(;;) {
    if(istrue(var_0._id_CF7C)) {
      var_1 = scripts\engine\utility::array_combine(level.players, _id_06FE::_id_6884(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }
        _id_8821(var_0, var_3, 0, 1);
      }
    }

    wait 0.1;
  }
}

_id_B558(var_0) {
  level endon("game_ended");
  var_0 notify("player_nearby_listener");
  var_0 endon("player_nearby_listener");
  var_0 endon("alerted");
  var_0 endon("death");
  var_0 endon("exit_stealth");

  for(;;) {
    if(istrue(var_0._id_CF7C)) {
      var_1 = scripts\engine\utility::array_combine(level.players, _id_06FE::_id_6884(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }
        _id_8821(var_0, var_3, 1, 1);
      }
    }

    wait 0.1;
  }
}

_id_D474(var_0, var_1) {
  var_0 notify("setAndUnsetZombieIgnoreMe");
  var_0 endon("setAndUnsetZombieIgnoreMe");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::_id_1088C(var_1, "fake_stealth_set", var_1, "death");
}

_id_143A(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    if(var_2) {
      var_0._id_E43C = var_1;
      var_0 _id_D6F1("spotted");
      _id_DC6F(var_1);
      var_0 playsoundtoplayer("zmb_vo_cop_pain", var_1);
      var_1 thread _id_D474(var_1, var_0);
    }

    var_0 notify("alerted");
  } else {
    var_0 _id_D6F1("spotted");
    var_0 playSound("zmb_vo_cop_pain");
    var_0 notify("alerted_by_ai");
  }
}

_id_8821(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return 0;
  }

  var_4 = isPlayer(var_1);
  var_5 = _id_6EA5(var_0);
  var_6 = var_5._id_98A2;
  var_7 = distance(var_1.origin, var_0.origin);
  var_0._id_E43C = undefined;
  var_2 = istrue(var_2);
  var_8 = var_0 getplayerangles(1);
  var_9 = istrue(var_5._id_31D3);

  if(var_4) {
    if(!var_1 scripts\cp\utility::_id_8708()) {
      return 0;
    }

    if(isDefined(var_1._id_DD78)) {
      var_7 = var_7 * var_1._id_DD78["stealth"]._id_E7A7;
    }
  }

  if(var_7 < 96) {
    if(vectordot(var_8, vectornormalize(var_1.origin - var_0.origin)) > 0) {
      _id_143A(var_0, var_1, var_2);
      return 1;
    }
  }

  var_10 = var_0 _meth_8067(var_1) && _func_0202(var_0 getEye(), var_1.origin, 0, var_0, var_9);

  if(var_10 || istrue(level._id_DDC8)) {
    var_11 = scripts\engine\math::_id_645E(var_0.origin, var_8, var_1.origin);

    if(var_11 < 0.573576 && !istrue(level._id_DDC8)) {
      var_0._id_E43C = undefined;
      return 0;
    }

    var_3 = istrue(var_3);
    var_12 = var_1 getstance();
    var_13 = 1;
    var_14 = 1;
    var_15 = var_1 getvelocity();
    var_16 = length(var_15);

    if(var_16 < 128) {
      var_13 = 0.75;
    } else if(var_16 < 200 || var_4 && var_1._id_DD78["stealth"]._id_E7EC) {
      var_13 = 1;
    } else {
      var_13 = 1.25;
    }

    if(var_12 == "stand" && var_7 <= int(var_5._id_E589 * var_11 * var_13 * var_14) && (!var_3 || _id_31AA(var_0, var_1.origin))) {
      _id_143A(var_0, var_1, var_2);
      return 1;
    } else if(var_12 == "crouch" && var_7 <= int(var_5._id_40A3 * var_11 * var_13 * var_14) && (!var_3 || _id_31AA(var_0, var_1.origin))) {
      _id_143A(var_0, var_1, var_2);
      return 1;
    } else if(var_12 != "prone" && var_7 <= int(var_5._id_BDAE * var_11 * var_13 * var_14) && (!var_3 || _id_31AA(var_0, var_1.origin))) {
      _id_143A(var_0, var_1, var_2);
      return 1;
    } else {
      var_0._id_E43C = undefined;
      return 0;
    }
  } else {
    var_0._id_E43C = undefined;
    return 0;
  }

  var_0._id_E43C = undefined;
  return 0;
}

_id_31AA(var_0, var_1) {
  if(!isDefined(level._id_5B01)) {
    level._id_5B01 = 1;
  }

  level._id_5B01 = level._id_5B01 + 1;
  var_2 = istrue(var_0._id_DDCA);
  var_3 = var_0 _meth_847B(var_0.origin, var_1, 0, var_2);

  if(var_3.size >= 1 && distance(var_3[var_3.size - 1], var_1) <= 64) {
    return 1;
  } else {
    return 0;
  }
}

_id_E7D8(var_0) {
  var_1 = self;
  var_1 notify("stealth_patrol");
  var_1 endon("stealth_patrol");
  var_1 endon("death");
  var_1 endon("alerted");
  var_1 endon("alerted_by_ai");
  var_1 endon("new_goal");
  var_1._id_A991 = var_1._id_0201;

  if(!istrue(var_1._id_5904)) {
    var_1 waittill("fake_stealth_set");
  }

  if(!isDefined(var_0)) {
    var_0 = var_1.origin;
  }

  var_1 _id_D6F1("patrol");
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = undefined;

    if(isDefined(var_1._id_AF40) && var_1._id_AF40 != "patrol") {
      var_1._id_10845 = 1;
      var_1 waittill("stealth_state_changed");
      var_1._id_10845 = undefined;
      continue;
    }

    if(istrue(var_1._id_CF7C)) {
      if(isDefined(var_1._id_5E96)) {
        var_5 = _func_02AB(var_1._id_5E96.origin);

        if(isDefined(var_2)) {
          var_3 = var_2;
        }

        var_2 = var_1._id_5E96;
        thread _id_06FD::_id_D4E3(var_1._id_5E96, 20);
        thread _id_C4D2(var_1, var_1._id_5E96);
        _id_0CEA(var_1, var_5, 32);
        _id_06FD::_id_FA74(var_1._id_5E96);
        var_1._id_5E96 = undefined;
      } else {
        var_6 = scripts\engine\utility::_id_6369(var_1.origin, level._id_1627, undefined, 10);
        var_6 = var_1 _id_6D0A(var_1, var_6, [var_2, var_3], "generic_zombie");

        if(isDefined(var_6)) {
          foreach(var_8 in var_6) {
            var_5 = _func_02AB(var_8.origin);

            if(distance(var_8.origin, var_5) <= 40 && _id_31AA(var_1, var_5)) {
              if(isDefined(var_2)) {
                var_3 = var_2;
              }

              var_2 = var_8;
              thread _id_06FD::_id_D4E3(var_8, 20);
              thread _id_C4D2(var_1, var_8);
              _id_0CEA(var_1, var_5, 32);
              _id_06FD::_id_FA74(var_8);
              break;
            } else {
              var_2 = undefined;
              var_3 = undefined;
            }
          }
        } else {
          var_2 = undefined;
          var_3 = undefined;
        }
      }
    }

    if(randomint(100) < 20) {
      wait(randomfloatrange(2.5, 5));
    }
  }
}

_id_C4D2(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("goal_reached");
  var_0 endon("goal");
  var_0 endon("stalled");
  var_0 scripts\engine\utility::waittill_any_3("death", "alerted", "alerted_by_ai");
  _id_06FD::_id_FA74(var_1);
}

_id_3D0C(var_0) {
  level endon("game_ended");
  var_0._id_3D06 = 1;
  wait 20;
  var_0._id_3D06 = undefined;
}

_id_6D0A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = level._id_15ED;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = scripts\engine\utility::_id_1BD1(var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = "soldier_agent";
  }

  var_4 = 25;
  var_5 = _id_06FE::_id_6882(var_3);
  var_6 = _func_0204(scripts\engine\utility::_id_1BBF(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::_id_6369(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12._id_AF4E;
    var_12._id_B02A = 0;
    var_14 = 250;
    var_15 = distance(var_0.origin, var_12.origin);

    if(var_8 && var_15 <= 500) {
      var_14 = 500;
    } else if(var_15 >= 1500) {
      var_14 = 500;
    } else {
      var_16 = scripts\engine\math::_id_645E(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_17 = scripts\engine\utility::getStructArray(var_12.target, "targetname");

        if(var_17.size > 1) {
          var_18 = var_10 * 500;
          var_14 = var_14 - var_18;
        }

        var_19 = var_9 * 500;
        var_14 = var_19 * var_16;
      } else
        var_14 = 500 * var_16;
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12._id_B02A = int(var_14);
    var_7[var_7.size] = var_12;
  }

  var_21 = scripts\cp\utility::_id_1BD5(var_7, ::_id_6C28);
  return var_21;
}

_id_6C28() {
  if(isDefined(self._id_B02A)) {
    return self._id_B02A;
  } else {
    return 999;
  }
}

_id_6C22() {
  if(isDefined(self._id_AF4E)) {
    return self._id_AF4E;
  } else {
    return 0;
  }
}

_id_7074(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("alerted_by_ai");
  var_0 endon("exit_stealth");
  var_4 = _func_02AB(var_1);

  if(distance(var_4, var_1) <= 32 && _id_31AA(var_0, var_4)) {
    var_0 notify("new_goal");
    var_0 endon("new_goal");
    var_0 _id_D6F1(var_3);
    _id_C615(var_0);

    if(!isDefined(var_0._id_91A3)) {
      iprintln("** - LEGACY IS UNDEFINED FOR : " + var_0 getentitynumber() + ", health: " + var_0.health + ", agent: " + var_0._id_1210);
      var_0._id_91A3 = spawnStruct();
    }

    if(isDefined(var_2)) {
      var_0._id_91A3._id_02D6 = var_2;
    } else {
      var_0._id_91A3._id_02D6 = "sprint";
    }

    _id_0CEA(var_0, var_4, 32);
    var_0._id_91A3._id_02D6 = "slow_walk";
    wait(_id_6EA5(var_0)._id_F212);
    var_0 notify("reset_stealth");
  }
}

_id_10CF6() {
  self notify("weapon_fire_monitor");
  self endon("weapon_fire_monitor");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired");
    level notify("weapon_fired", self.origin, self getcurrentweapon(), self);
  }
}

_id_B645(var_0) {
  var_0 notify("player_weapon_listener");
  var_0 endon("player_weapon_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  for(;;) {
    level waittill("weapon_fired", var_1, var_2, var_3, var_4);

    if(!istrue(var_0._id_CF7C)) {
      continue;
    }
    if(isPlayer(var_3)) {
      var_5 = 2000 * var_3._id_DD78["stealth"]._id_E7EF;
    } else {
      var_5 = 2000;
    }

    foreach(var_7 in var_2._id_0070) {
      if(issubstr(var_7, "silencer")) {
        var_5 = var_5 * 0.75;
        break;
      }
    }

    var_5 = int(var_5);

    if(distance(var_1, var_0.origin) > var_5) {
      continue;
    } else {
      var_0 thread _id_7074(var_0, var_1, undefined, "investigating_weapon_fire");
      wait 0.5;
    }
  }
}

_id_11017() {
  self endon("death");
  self notify("texthandler");
  self endon("texthandler");
  var_0 = self getentitynumber();

  for(;;) {
    if(getDvar("#x385a1810201b75220") == "") {
      level waittill("show_stealth_states");
    }

    if(isDefined(self._id_AF40)) {}

    waitframe();
  }
}

_id_4F10() {
  self endon("death");
  self notify("draw_fov");
  self endon("draw_fov");

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

  if(isDefined(level._id_11054)) {
    var_0 = level._id_11054;
  } else {
    var_0 = "scripts/cp/zombie_stealth.csv";
  }

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
    var_4._id_98A2 = cos(int(tablelookupbyrow(var_0, 21, var_1)));
    var_4._id_31D3 = cos(int(tablelookupbyrow(var_0, 22, var_1)));
    level._id_11055[int(var_3)] = var_4;
    var_1++;
  }
}

_id_D3CA(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 = int(clamp(var_1, 0, level._id_9C6C - 1));
  }

  var_1 = int(max(var_1, 0));
  var_2 = spawnStruct();
  var_2._id_41F8 = int(var_1);
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
  var_2._id_31D3 = level._id_11055[var_1]._id_31D3;
  var_0._id_E804 = var_2;
  _id_D8F6(var_0, var_1);
  var_0 notify("stealth_values_set");
}

_id_D8F6(var_0, var_1) {
  var_2 = level._id_9C6C;

  switch (var_1) {
    case 10:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 9:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 8:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 7:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 6:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 5:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "active");
      break;
    case 4:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 3:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "active");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 2:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 1:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "active");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    default:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
  }
}

_id_DC6F(var_0) {
  if(!isDefined(var_0._id_8F62) || gettime() >= var_0._id_8F62 + 5000) {
    var_0._id_8F62 = gettime();

    if(!istrue(level._id_4A74)) {
      var_0 iprintlnbold("You've been spotted!");
    }
  }
}

_id_7DCF(var_0) {
  if(isDefined(var_0._id_E804) && isDefined(var_0._id_E804._id_41F8)) {
    var_1 = clamp(var_0._id_E804._id_41F8 + 1, 0, level._id_9C6C - 1);
    _id_D3CA(var_0, int(var_1));
  }
}

_id_454B(var_0) {
  if(isDefined(var_0._id_E804) && isDefined(var_0._id_E804._id_41F8)) {
    var_1 = clamp(var_0._id_E804._id_41F8 - 1, 0, level._id_9C6C - 1);
    _id_D3CA(var_0, int(var_1));
  }
}

_id_6EA5(var_0) {
  if(isDefined(var_0._id_E804)) {
    return var_0._id_E804;
  } else {
    return undefined;
  }
}

_id_A157(var_0) {
  var_0 notify("monitorZAwarenessLevel");
  var_0 endon("monitorZAwarenessLevel");
  level endon("game_ended");
  level endon("disable_zombie_scripted_stealth");
  var_0 endon("disconnect");
  var_0._id_11063 = 0;
  var_1 = 100;
  var_2 = 0;

  for(;;) {
    if(scripts\engine\utility::_id_5C00("track_player_movement")) {
      if(var_0 scripts\cp\utility::_id_8708()) {
        var_3 = var_0 getvelocity();
        var_4 = length(var_3);

        if(var_4 < 64) {
          var_2 = var_2 + 2;
        } else if(var_4 > 64 && var_4 < 128) {
          var_2 = var_2 + 1;
        } else if(var_4 > 350) {
          var_2 = var_2 - 10;
        } else if(var_4 > 200) {
          var_2 = var_2 - 5;
        }

        var_2 = clamp(var_2, 0, var_1);

        if(var_2 >= var_1) {
          thread _id_D0C5(var_0);
          var_2 = 0;
          wait 10;
        }
      }
    }

    wait 0.25;
  }
}

_id_D0C5(var_0) {
  if(istrue(var_0.ignoreme)) {
    return;
  }
  var_1 = _id_06FE::_id_6882("generic_zombie");
  var_2 = _func_0204(var_1, var_0.origin);
  var_3 = 10;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(istrue(var_6._id_5904)) {
      var_7 = var_6 _id_6D8E();

      if(isDefined(var_7) && var_7 == "patrol") {
        var_6 thread _id_7074(var_6, var_0.origin, "run", "sent_to_player_position");
        var_4++;

        if(var_4 >= var_3) {
          break;
        }
      }
    }
  }
}

_id_E0BE(var_0) {
  var_1 = undefined;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_1._id_CE18)) {
    var_1._id_CE18 = "ground_spawn_no_boards";
  }

  if(var_1._id_CE18 != "ground_spawn_no_boards") {
    iprintlnbold("bad spawn");
  }

  var_2 = var_1[[level._id_E249]]("generic_zombie", 1, var_1);

  if(isDefined(var_2)) {
    if(istrue(var_0._id_DDCA)) {
      var_2._id_DDCA = 1;
    }

    if(istrue(var_0._id_4DA6)) {
      var_2._id_4DA6 = 1;
    }

    if(isDefined(var_1.target)) {
      var_2._id_5E96 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var_1.target, "targetname"));
    }

    if(isDefined(var_0._id_F15F)) {
      var_2._id_F15F = var_0._id_F15F;
    }

    var_1._id_904F = gettime();
    var_2._id_8D8E = gettime() + 10000;
    var_2 _meth_80C6(1, 0.1);
    var_2 thread _id_455F(var_2, var_0, 1);
    return 1;
  }

  return 0;
}

_id_455F(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0._id_8B1C = 1;
  var_0._id_4D8F = 1;
  var_0._id_4D7A = 1;
  var_0._id_53AB = var_1._id_7218;
  var_0._id_A029 = var_1._id_A029;
  var_0._id_71F4 = var_1;
  var_0._id_71F4._id_0F3C++;
  var_3 = getdvarint("#x3ec7239234d3cb10", 160);
  var_0.maxhealth = var_3;
  var_0.health = var_3;
  _id_0F04(var_0, var_2);
}

_id_FD95(var_0, var_1) {
  var_0._id_53AB = var_1._id_7218;
}

_id_0F04(var_0, var_1) {
  var_0 thread _id_110A4(var_0, var_1);
}

_id_0CEA(var_0, var_1, var_2) {
  var_0 notify("set_goal_pos_requested");
  var_0 endon("set_goal_pos_requested");
  var_0 endon("death");
  var_0 endon("stalled");

  if(isDefined(var_2)) {
    var_0._id_0201 = var_2;
  } else {
    var_0._id_0201 = 32;
  }

  var_3 = 0;

  foreach(var_5 in level._id_A3F5) {
    if(distance(var_5, var_1) <= 32) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = _func_02AA(var_1, 128, 10, undefined, _func_02A9(var_1, 64), 128);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level._id_A3F5) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread _id_9A2A(var_0, var_1);
  var_0 _meth_8326(var_1);
  var_15 = var_0 scripts\engine\utility::_id_10897("goal", "goal_reached");
}

_id_9A2A(var_0, var_1) {
  level._id_A3F5[level._id_A3F5.size] = var_1;
  var_2 = var_0 scripts\engine\utility::_id_10892(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

  if(scripts\engine\utility::array_contains(level._id_A3F5, var_1)) {
    level._id_A3F5 = scripts\engine\utility::array_remove(level._id_A3F5, var_1);
  }
}

_id_C615(var_0) {
  var_0 _meth_8326(self.origin);
  var_0 scripts\engine\utility::waittill_any_2("goal", "goal_reached");
}