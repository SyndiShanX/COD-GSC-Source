/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2994.gsc
**************************************/

_id_3193() {
  var_0 = spawnStruct();
  var_0._id_101AD = "L";
  var_1 = spawnStruct();
  var_1._id_101AD = "R";
  self._id_65CD = [var_1, var_0];
  self._id_65CE = 2;
  self._id_65AE = [];
  self._id_8CCA = 100;

  foreach(var_3 in self._id_65CD) {
    var_3 _id_318F(self);
  }

  if(issubstr(self.classname, "cheap")) {
    return;
  }
  thread _id_65A7();
  thread _id_9279();
  self._id_65CD thread _id_B858(self);
  self._id_65CD thread _id_B86E(self);
  thread _id_91BE();
}

_id_318F(var_0) {
  self._id_1BE4 = 1;
  self._id_4651 = _id_3190(var_0);
  self._id_119EA = _id_3191(var_0, "top");
  self._id_101B0 = _id_3191(var_0, "side");
  self._id_2F00 = _id_3191(var_0, "bottom");
  self.partnerheli = [self._id_4651, self._id_119EA[0], self._id_101B0[0], self._id_2F00[0]];
  var_0._id_65AE = scripts\engine\utility::array_combine(var_0._id_65AE, self.partnerheli);
  self._id_1033E = self._id_4651 _id_8192("light_small");
  self._id_A856 = self._id_4651 _id_8192("light_large");
  scripts\engine\utility::delaythread(0.1, ::_id_65AB);

  if(issubstr(var_0.classname, "cheap")) {
    return;
  }
  self._id_75ED = self._id_4651 _id_8192("fx_spark");
  self._id_754A = self._id_4651 _id_8192("fx_arc");

  foreach(var_2 in self._id_119EA) {
    var_2 thread _id_659B(var_0, self);
  }

  foreach(var_2 in self._id_101B0) {
    var_2 thread _id_659B(var_0, self);
  }

  foreach(var_2 in self._id_2F00) {
    var_2 thread _id_659B(var_0, self);
  }

  self._id_4651 thread _id_6598(var_0, self);
}

#using_animtree("vehicles");

_id_3191(var_0, var_1) {
  var_2 = [];
  var_3 = self._id_101AD;
  var_4 = "tag_engine_sheild_" + var_1 + "_" + var_3;
  var_5 = "veh_mil_air_ca_missile_boat_sheild_" + var_1 + "_" + var_3;
  var_6 = spawn("script_model", var_0.origin);
  var_6 setModel(var_5);
  var_6 linkTo(var_0, var_4, (0, 0, 0), (0, 0, 0));
  var_6.tag = var_4;

  if(issubstr(var_0.classname, "cheap")) {
    var_2[var_2.size] = var_6;
    return var_2;
  }

  var_6._id_1BE4 = 1;
  var_6 _meth_83D0(#animtree);
  var_6.script_team = "axis";
  var_6[[level._id_A056._id_11543]]("turret", "JACKAL_SHIELD", "none", "enemy_jackal", 0, 0, 0, "missileboat_shield_damage");
  var_2[var_2.size] = var_6;
  return var_2;
}

_id_3190(var_0) {
  var_1 = self._id_101AD;
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("veh_mil_air_ca_missile_boat_engine");
  var_2 linkTo(var_0, "tag_engine_" + self._id_101AD, (0, 0, 0), (0, 0, 0));

  if(issubstr(var_0.classname, "cheap")) {
    return var_2;
  }

  var_2 _meth_83D0(#animtree);
  var_2._id_109FA = 3;
  var_2.script_team = "axis";
  var_2 _meth_82A2(%vh_missile_boat_engine_rotate, 1, 0, var_2._id_109FA);
  var_2.script_team = "axis";
  var_2._id_52D4 = "veh_mil_air_ca_missile_boat_engine_dest";
  var_2[[level._id_A056._id_11543]]("missileboat_turret", "JACKAL_ENGINE", "none", "enemy_jackal", 0, 0, 0, "missileboat_engine_damage");
  return var_2;
}

_id_659F(var_0) {
  _id_659D(%vh_missile_boat_engine_top_door_open, %vh_missile_boat_engine_bottom_door_open, var_0);
  wait 2.5;
  self notify("engine_doors_open");
}

_id_659E(var_0) {
  _id_659D(%vh_missile_boat_engine_top_door_close, %vh_missile_boat_engine_bottom_door_close, var_0);
  wait 2.5;
  self notify("engine_doors_closed");
}

_id_65B0() {
  self notify("engine_change_state");
  _id_65AA();
  thread _id_6597(0, 0.02);
}

_id_65B7() {
  self notify("engine_change_state");

  if(!isDefined(self)) {
    return;
  }
  if(self.model == self._id_52D4) {
    return;
  }
  _id_65AB();
  thread _id_6597(3, 0.02);
}

_id_65A2() {
  foreach(var_1 in self._id_1033E) {
    self._id_4651 scripts\sp\utility::_id_75C4("missile_boat_engine_light_small_emp", var_1);
  }

  thread _id_65A4();
  thread _id_65A0();
}

_id_65A4() {
  self endon("emp_fx_off");

  while(isDefined(self._id_4651.model) && self._id_4651.model == "veh_mil_air_ca_missile_boat_engine") {
    var_0 = scripts\engine\utility::random(self._id_75ED);
    self._id_4651 scripts\sp\utility::_id_75C4("missile_boat_engine_emp_spark", var_0);
    wait(randomfloatrange(0.35, 1.5));
  }
}

_id_65A0() {
  self endon("emp_fx_off");

  while(isDefined(self._id_4651.model) && self._id_4651.model == "veh_mil_air_ca_missile_boat_engine") {
    var_0 = scripts\engine\utility::random(self._id_754A);
    self._id_4651 scripts\sp\utility::_id_75C4("missile_boat_engine_emp_arc", var_0);
    wait(randomfloatrange(0.15, 0.5));
  }
}

_id_65A1() {
  self notify("emp_fx_off");

  foreach(var_1 in self._id_1033E) {
    self._id_4651 scripts\sp\utility::_id_75A0("missile_boat_engine_light_small_emp", var_1);
  }
}

_id_6597(var_0, var_1) {
  self endon("engine_change_state");

  if(!isDefined(self._id_4651._id_109FA)) {
    return;
  }
  var_2 = self._id_4651._id_109FA;
  var_3 = 1;
  var_4 = 0.02;

  for(;;) {
    if(var_3) {
      var_5 = abs(var_2 - var_0);

      if(var_5 < var_1) {
        var_2 = var_0;
        var_3 = 0;
      } else if(var_2 < var_0)
        var_2 = var_2 + var_1;
      else {
        var_2 = var_2 - var_1;
      }
    }

    if(abs(self._id_4651._id_109FA - var_0) < 0.01) {
      break;
    }

    self._id_4651._id_109FA = scripts\sp\math::_id_AB6F(self._id_4651._id_109FA, var_0, var_4);
    self._id_4651 _meth_82B1(%vh_missile_boat_engine_rotate, self._id_4651._id_109FA);
    wait 0.05;
  }

  self._id_4651._id_109FA = var_0;
  self._id_4651 _meth_82B1(%vh_missile_boat_engine_rotate, self._id_4651._id_109FA);
}

_id_65AB() {
  if(!isDefined(self._id_4651)) {
    return;
  }
  if(!isDefined(self._id_4651.model)) {
    return;
  }
  if(self._id_4651.model != "veh_mil_air_ca_missile_boat_engine") {
    return;
  }
  foreach(var_1 in self._id_1033E) {
    self._id_4651 scripts\sp\utility::_id_75C4("missile_boat_engine_light_small", var_1);
  }

  foreach(var_1 in self._id_A856) {
    self._id_4651 scripts\sp\utility::_id_75C4("missile_boat_engine_light_large", var_1);
  }
}

_id_65AA() {
  if(!isDefined(self._id_4651)) {
    return;
  }
  if(!isDefined(self._id_4651.model)) {
    return;
  }
  if(self._id_4651.model != "veh_mil_air_ca_missile_boat_engine") {
    return;
  }
  foreach(var_1 in self._id_1033E) {
    self._id_4651 scripts\sp\utility::_id_75A0("missile_boat_engine_light_small", var_1);
  }

  foreach(var_1 in self._id_A856) {
    self._id_4651 scripts\sp\utility::_id_75A0("missile_boat_engine_light_large", var_1);
  }
}

_id_659D(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  foreach(var_4 in self._id_119EA) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4._id_1BE4) {
      var_4 setanimknob(var_0, 1, 0.2);

      if(var_2) {
        var_4 _meth_82B0(var_0, 1);
      }
    }
  }

  foreach(var_4 in self._id_2F00) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4._id_1BE4) {
      var_4 setanimknob(var_1, 1, 0.2);

      if(var_2) {
        var_4 _meth_82B0(var_1, 1);
      }
    }
  }
}

_id_8192(var_0) {
  var_1 = [];
  var_2 = getnumparts(self.model);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tolower(getpartname(self.model, var_3));

    if(issubstr(var_4, tolower(var_0))) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

_id_91BE() {
  self endon("death");
  self endon("missileboat_destroyed");
  var_0 = self;
  var_0.health = 999999;
  var_0._id_EF52 = 1000;
  var_1 = 950;
  var_0 setCanDamage(1);
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0._id_65CD) {
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_2F00[0]);
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_101B0[0]);
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_119EA[0]);
    var_3 = scripts\engine\utility::array_add(var_3, var_5._id_4651);
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 scripts\engine\utility::array_randomize(var_3);

  for(;;) {
    var_0 waittill("damage", var_7, var_8, var_9, var_10, var_11, var_9, var_9, var_9, var_9, var_12);
    self.health = 999999;

    if(_id_24DB(var_8) && distancesquared(var_8.origin, var_0.origin) < 1600000000 && var_1 > 700) {
      if(_id_9B48(var_12, var_11)) {
        self._id_EF52 = self._id_EF52 - 1;
      } else if(var_11 == "MOD_EXPLOSIVE") {
        self._id_EF52 = self._id_EF52 - 2;
        wait 1.0;
      } else if(_id_9B47(var_12, var_11))
        var_0._id_EF52 = var_0._id_EF52 - 1;

      if(var_0._id_EF52 <= var_1) {
        if(var_1 < 900) {
          if(var_1 < 850) {
            if(isDefined(var_3[0])) {
              var_3[0]._id_EF52 = 0;
              var_3[0] _id_0B76::_id_54DE(15000, var_3[0].origin, level._id_D127, level._id_D127._id_13BF7.weapon);
              var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);
            }

            var_1 = var_1 - 100;
          } else if(var_1 < 750) {
            if(isDefined(var_3[0])) {
              var_3[0]._id_EF52 = 0;
              var_3[0] _id_0B76::_id_54DE(15000, var_3[0].origin, level._id_D127, level._id_D127._id_13BF7.weapon);
              var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);
              var_1 = var_1 - 100;
            }
          } else
            var_1 = var_1 - 100;
        } else {
          if(isDefined(var_2[0])) {
            var_2[0]._id_EF52 = 0;
            var_2[0] _id_0B76::_id_54DE(15000, var_2[0].origin, level._id_D127, level._id_D127._id_13BF7.weapon);
            var_2 = scripts\engine\utility::array_remove(var_2, var_2[0]);
          }

          var_1 = var_1 - 50;
        }

        wait 2;
      }
    }
  }
}

_id_659B(var_0, var_1) {
  self._id_10DAD = int(5000 * level._id_A48E._id_1B13);
  self._id_EF52 = self._id_10DAD;
  self.health = 999999;
  self setCanDamage(1);
  self endon("death");
  self endon("missileboat_destroyed");
  var_0 thread scripts\engine\utility::delete_on_death(self);

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_4, var_4, var_4, var_4, var_7);
    self.health = 999999;

    if(_id_24DB(var_3) && distancesquared(var_3.origin, var_0.origin) < 1600000000) {
      if(_id_9B48(var_7, var_6)) {
        var_0 thread _id_FD67(3);
        self._id_EF52 = self._id_EF52 - var_2;
      } else if(var_6 == "MOD_EXPLOSIVE") {
        var_0 thread _id_FD67(3);
        self._id_EF52 = self._id_EF52 - var_2;
        wait 1.0;
      } else if(_id_9B47(var_7, var_6)) {
        var_0 thread _id_FD67(1);
        self._id_EF52 = self._id_EF52 - var_2;
      }

      if(self._id_EF52 <= 0) {
        thread _id_659C(var_0, var_1);
        break;
      }
    }
  }
}

_id_24DB(var_0) {
  if(var_0 == level.player) {
    return 1;
  }

  if(isDefined(level._id_D127) && var_0 == level._id_D127) {
    return 1;
  }

  return 0;
}

_id_9B47(var_0, var_1) {
  if(var_1 != "MOD_PROJECTILE") {
    return 0;
  }

  var_2 = ["spaceship_30mm_projectile", "spaceship_30mm_growler", "spaceship_30mm_slow", "spaceship_30mm_projectile_weapupgrade", "spaceship_30mm_growler_weapupgrade", "spaceship_30mm_slow_weapupgrade"];

  if(scripts\engine\utility::array_contains(var_2, var_0)) {
    return 1;
  }

  return 0;
}

_id_9B48(var_0, var_1) {
  if(var_1 != "MOD_PROJECTILE") {
    return 0;
  }

  var_2 = ["spaceship_cannon_projectile", "spaceship_cleaver_projectile", "spaceship_anvil_projectile", "spaceship_cannon_projectile_weapupgrade", "spaceship_cleaver_projectile_weapupgrade", "spaceship_anvil_projectile_weapupgrade"];

  if(scripts\engine\utility::array_contains(var_2, var_0)) {
    return 1;
  }

  return 0;
}

_id_659C(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("missileboat_destroyed");
  var_3 = var_1._id_4651;
  var_4 = self;
  var_5 = undefined;
  thread scripts\engine\utility::play_sound_in_space("ajak_engine_explo", var_0.origin);

  if(var_1._id_101AD == "R") {
    var_6 = [var_0._id_65CD[0]._id_119EA[0], var_0._id_65CD[0]._id_101B0[0], var_0._id_65CD[0]._id_2F00[0]];
    self notify("missileboat_right_shield_destroyed");
    var_7 = "missileboat_shield_float_r";
  } else {
    var_6 = [var_0._id_65CD[1]._id_119EA[0], var_0._id_65CD[1]._id_101B0[0], var_0._id_65CD[1]._id_2F00[0]];
    self notify("missileboat_left_shield_destroyed");
    var_7 = "missileboat_shield_float_l";
  }

  var_6 = scripts\engine\utility::array_removeundefined(var_6);
  var_6 = scripts\engine\utility::array_randomize(var_6);

  if(!isDefined(var_2) || isDefined(var_2) && !var_2) {
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_6[var_8] != var_4) {
        var_6 = scripts\engine\utility::array_remove(var_6, var_6[var_8]);
        break;
      }
    }
  }

  foreach(var_10 in var_6) {
    if(var_10 islinked()) {
      var_10 hudoutlinedisable();
      var_10 hide();

      if(issubstr(var_10.tag, "top")) {
        var_5 = var_7 + "t";
      } else if(issubstr(var_10.tag, "side")) {
        var_5 = var_7 + "s";
      } else if(issubstr(var_10.tag, "bottom")) {
        var_5 = var_7 + "b";
      }

      playFXOnTag(scripts\engine\utility::getfx(var_5), var_0, var_10.tag);
      var_10 notify("engine_doors_open");

      if(isDefined(var_10)) {
        var_0 notify("engine_door_destroyed");

        if(isDefined(var_1)) {
          var_1 thread _id_65B7();
        }
      }

      if(scripts\sp\utility::_id_B324() && isDefined(var_10._id_AEDF)) {
        var_10[[level._id_A056._id_11540]]();
      }

      var_10 delete();
      var_0._id_8CCA = var_0._id_8CCA - 2.5;
      var_5 = undefined;
    }
  }
}

_id_6598(var_0, var_1) {
  self._id_10DAD = int(12000 * level._id_A48E._id_1B13);
  self._id_EF52 = self._id_10DAD;
  self.health = 999999;
  self setCanDamage(1);
  self endon("death");
  var_0 thread scripts\engine\utility::delete_on_death(self);

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_4, var_4, var_4, var_4, var_7);
    self.health = 999999;

    if(_id_24DB(var_3) && distancesquared(var_3.origin, var_0.origin) < 1600000000) {
      if(var_6 == "MOD_PROJECTILE_SPLASH") {
        continue;
      }
      if(_id_9B48(var_7, var_6)) {
        var_0 thread _id_FD67(1);
        self._id_EF52 = self._id_EF52 - var_2;
      } else if(var_6 == "MOD_EXPLOSIVE") {
        var_0 thread _id_FD67(3);
        self._id_EF52 = self._id_EF52 - var_2;
        wait 1.0;
      } else if(_id_9B47(var_7, var_6)) {
        var_0 thread _id_FD67(1);
        self._id_EF52 = self._id_EF52 - var_2;
      }

      if(self._id_EF52 <= 0) {
        level thread _id_6599(var_0, self, var_1);
        break;
      }
    }
  }
}

_id_B853(var_0) {
  var_0 endon("engine_change_state");

  if(!isDefined(self._id_1060A) || isDefined(self._id_1060A) && !self._id_1060A && self._id_4651.model == "veh_mil_air_ca_missile_boat_engine") {
    _id_65A2();
    self._id_1060A = 1;
  } else
    return;

  wait 3;
  _id_65A1();
  self._id_1060A = 0;
}

_id_6599(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 notify("engine_destroyed");
  var_1 notify("engine_change_state");
  var_3 = [];

  if(var_2._id_101AD == "L") {
    var_4 = ["fx_engine_s_1", "fx_engine_s_3"];
    var_5 = "fx_thruster_v_s_6";
    var_6 = 0;
  } else {
    var_4 = ["fx_engine_s_2", "fx_engine_s_4"];
    var_5 = "fx_thruster_v_s_7";
    var_6 = 1;
  }

  _id_659C(var_0, var_2, 1);

  foreach(var_8 in var_0._id_7560["thrust_rear"]) {
    foreach(var_10 in var_4) {
      if(var_8.tag == var_10) {
        var_11 = var_8.fx + "_" + var_8.state;
        var_0 scripts\sp\utility::_id_75A0(var_11, var_8.tag);
        var_0._id_7560["thrust_rear"] = ::scripts\engine\utility::array_remove(var_0._id_7560["thrust_rear"], var_8);
      }
    }
  }

  foreach(var_8 in var_0._id_7560["thrust_vert"]) {
    if(var_8.tag == var_5) {
      var_11 = var_8.fx + "_" + var_8.state;
      var_0 scripts\sp\utility::_id_75A0(var_11, var_8.tag);
      var_0._id_7560["thrust_vert"] = ::scripts\engine\utility::array_remove(var_0._id_7560["thrust_vert"], var_8);
    }
  }

  var_1 scripts\sp\utility::_id_75C4("missileboat_engine_destroyed", "tag_origin");
  thread scripts\engine\utility::play_sound_in_space("ajak_engine_explo", var_1.origin);
  var_1 setModel(var_1._id_52D4);

  if(scripts\sp\utility::_id_B324() && isDefined(var_1._id_AEDF)) {
    var_1[[level._id_A056._id_11540]]();
  }

  var_1 hudoutlinedisable();
  var_1 scripts\sp\utility::_id_75C4("missile_boat_smoking", "tag_origin");
  var_0._id_65CE--;
  var_0._id_8CCA = var_0._id_8CCA - 50;
}

_id_659A() {
  wait 0.5;
  _id_0BB8::_id_39CE("med");
  _id_0BB8::_id_39D0("idle");
  wait(randomfloatrange(0.25, 0.5));
  _id_0BB8::_id_39CE("off");
  _id_0BB8::_id_39D0("off");
  wait 0.15;
  _id_0BB8::_id_39CE("med");
  _id_0BB8::_id_39D0("idle");
  wait 0.25;
  _id_0BB8::_id_39CE("off");
  _id_0BB8::_id_39D0("off");
  wait 0.15;
  _id_0BB8::_id_39CE("med");
  _id_0BB8::_id_39D0("idle");
}

_id_B850(var_0) {
  var_1 = self;
  var_1._id_10D90 = 0;
  var_1._id_9391 = 0;
  var_1 notify("missileboat_destroyed");
  var_1 notify("new_volume");

  if(isDefined(var_1)) {
    var_1._id_51E6 = 0;
    var_2 = spawn("script_model", var_1.origin);
    var_2 setModel("tag_origin");
    var_2.angles = var_1.angles;
    _id_B851();
    var_1 _id_0BA9::_id_397B();
    var_1 scripts\engine\utility::stop_loop_sound_on_entity("ajak_engine_lfe");
    playFXOnTag(scripts\engine\utility::getfx("missile_boat_death"), var_2, "tag_origin");
    var_2 playSound("ajak_explo");
    wait 5;
    var_2 delete();
  }
}

_id_B851() {
  if(!scripts\sp\utility::_id_D123()) {
    return;
  }
  var_0 = distance(self.origin, level._id_D127.origin);
  var_1 = scripts\sp\math::_id_C097(6000, 45000, var_0);
  var_2 = scripts\sp\math::_id_6A8E(0.578, 0.01, var_1);
  var_3 = scripts\sp\math::_id_6A8E(1.2, 0.5, var_1);
  var_1 = scripts\sp\math::_id_C097(6000, 30000, var_0);
  var_4 = scripts\sp\math::_id_6A8E(225, 0, var_1);
  earthquake(var_2, var_3, level._id_D127.origin, 15000);
  [[level._id_A056._id_20A9]](self.origin, var_4, 0.1, 1.5);
}

_id_FD67(var_0) {
  self notify("ship_hit");
  self endon("death");
  self endon("ship_hit");
  var_1 = self;
  var_1._id_12B8B = 1;
  wait(var_0);
  var_1._id_12B8B = 0;
}

_id_B86E(var_0) {
  var_0 endon("death");
  var_1 = 0;
  var_2 = [];

  while(var_1 < 1) {
    var_3 = var_0._id_8B50["cap_hardpoint_missile_barrage"];
    var_4 = var_0._id_8B51["cap_hardpoint_missile_barrage"];
    var_2 = scripts\engine\utility::array_combine(var_3, var_4);

    if(isDefined(var_0.turrets["cap_turret_small_constant"])) {
      var_2 = scripts\engine\utility::array_combine(var_2, var_0.turrets["cap_turret_small_constant"]);
    }

    var_1 = var_2.size;
    wait 0.5;
  }

  var_5 = var_2;

  while(var_0._id_8CCA > 0) {
    var_3 = var_0._id_8B50["cap_hardpoint_missile_barrage"];
    var_4 = var_0._id_8B51["cap_hardpoint_missile_barrage"];
    var_2 = scripts\engine\utility::array_combine(var_3, var_4);

    if(isDefined(var_0.turrets["cap_turret_small_constant"])) {
      var_2 = scripts\engine\utility::array_combine(var_2, var_0.turrets["cap_turret_small_constant"]);
    }

    var_2 = scripts\engine\utility::array_removeundefined(var_2);

    if(var_2.size == 0) {
      var_0 notify("all_turrets_dead");
    }

    if(var_2.size != var_5.size) {
      var_6 = var_5.size - var_2.size;
      var_1 = var_1 - var_6;
      var_5 = var_2;
      var_0._id_8CCA = var_0._id_8CCA - 2.5 * var_6;
      var_0 thread _id_B85E();
    }

    wait 0.5;
  }

  var_0 thread _id_B850(var_0);
}

_id_B858(var_0) {
  if(var_0._id_7481 != 1) {
    return;
  }
  var_0 endon("death");
  var_0 endon("missileboat_destroyed");
  var_0 endon("no_ftl_escape");
  var_0 waittill("all_turrets_dead");
  var_0._id_10D90 = 1;
  wait 1;
  var_0 thread _id_B857();
  wait 1;

  foreach(var_2 in self) {
    var_2 thread _id_65B7();
    var_3 = [var_2._id_119EA[0], var_2._id_101B0[0], var_2._id_2F00[0]];
    var_3 = scripts\engine\utility::array_removeundefined(var_3);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      if(var_5 islinked()) {
        wait(randomfloatrange(0.0, 0.25));
        var_6 = var_5.origin - var_2._id_4651.origin;
        var_6 = var_6 * 500000;
        var_5 unlink();
        scripts\engine\utility::waitframe();
        var_5 _meth_8224(var_5.origin + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-100, 100)), var_6);
        var_5 hudoutlinedisable();

        if(isDefined(var_5._id_AEDF) && scripts\sp\utility::_id_B324() && isDefined(var_5._id_AEDF)) {
          var_5[[level._id_A056._id_11540]]();
        }
      }
    }

    if(isDefined(var_2._id_4651) && var_2._id_4651._id_EF52 > 0) {
      var_2._id_4651 scripts\sp\utility::_id_F40A("enemy", 1, 1);
      var_2._id_4651._id_EF52 = 10;
    }
  }

  var_0 waittill("ftl_now");
  var_0 notify("ftl_out");
  var_9 = var_0._id_7482 + "_out";
  playFXOnTag(level._effect[var_9], var_0, "tag_origin");
  wait 3.0;
  var_0 thread _id_0BB8::_id_7491();
  var_0 thread _id_0BB8::_id_749C();

  if(soundexists("capitalship_npc_ally_ftl_out")) {
    var_0 playSound("capitalship_npc_ally_ftl_out");
  }

  foreach(var_2 in self) {
    if(isDefined(var_2._id_4651)) {
      var_2._id_4651 delete();
    }
  }

  var_0 _id_0BA9::_id_397B();
  var_0 notify("missileboat_destroyed");
}

_id_B857() {
  if(self._id_7481 != 1) {
    return;
  }
  self endon("death");
  self endon("no_ftl_escape");
  wait 7;
  self notify("ftl_now");
}

_id_65A7() {
  self endon("death");
  var_0 = -999;
  var_1 = scripts\engine\utility::array_combine(self._id_65CD[0].partnerheli, self._id_65CD[1].partnerheli);

  for(;;) {
    if(!isDefined(level.player) || !scripts\sp\utility::_id_D123()) {
      wait 0.05;
      continue;
    }

    var_2 = level.player _meth_848A();

    if(!isDefined(level._id_D127) || !isDefined(var_2) || !isDefined(var_2[0])) {
      wait 0.05;
      continue;
    }

    var_3 = gettime() - var_0;

    if(var_3 < 2000) {
      if(scripts\engine\utility::array_contains(var_1, var_2[0])) {
        var_0 = gettime();
      }

      wait 0.05;
      continue;
    }

    var_4 = [];

    foreach(var_6 in self._id_65CD) {
      if(var_6 _id_11526(var_2[0])) {
        var_0 = gettime();
        var_4 = var_6.partnerheli;
        break;
      }
    }

    if(var_4.size > 0) {
      thread _id_65A8(var_4);
    }

    wait 0.05;
  }
}

_id_11526(var_0) {
  foreach(var_2 in self.partnerheli) {
    if(var_2 == var_0) {
      var_3 = self.partnerheli;
      return 1;
    }
  }

  return 0;
}

_id_65A8(var_0) {
  for(var_1 = 2; var_1 > 0; var_1--) {
    foreach(var_3 in var_0) {
      if(isDefined(var_3)) {
        var_3 scripts\sp\utility::_id_F40A("enemy", 1, 1);
      }
    }

    wait 0.2;

    foreach(var_3 in var_0) {
      if(isDefined(var_3)) {
        var_3 hudoutlinedisable();
      }
    }

    wait 0.1;
  }
}

_id_9279() {
  self._id_9278 = 0;

  foreach(var_1 in self._id_65AE) {
    var_1._id_190E = self;
    var_1 thread _id_65AD();
  }
}

_id_65AD() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_2, var_2, var_2, var_2, var_5);

    if(!scripts\sp\utility::_id_D123()) {
      continue;
    }
    if(!isDefined(var_1) || var_1 != level._id_D127) {
      continue;
    }
    self._id_190E thread _id_B85E();
  }
}

_id_B85E() {
  self notify("start_agro_attack");
  self endon("death");
  self endon("start_agro_attack");
  self._id_9278 = 1;
  wait 4;
  self._id_9278 = 0;
}