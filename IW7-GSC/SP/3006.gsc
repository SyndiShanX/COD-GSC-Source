/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3006.gsc
************************/

func_5DFB(param_00) {
  var_01 = self.var_7724;
  var_02 = self.var_7723;
  if(param_00 == "down") {
    var_01 = self.var_7723;
    var_02 = self.var_7724;
  }

  self clearanim(var_02, 0.05);
  self give_attacker_kill_rewards(var_01);
}

func_9782(param_00, param_01) {
  self.var_1186E = param_00;
  self.var_11855 = param_01;
}

func_5EC8(param_00, param_01, param_02) {
  self endon("death");
  self glinton(#animtree);
  scripts\sp\utility::func_65E0("dynamicThrusters");
  scripts\sp\utility::func_65E1("dynamicThrusters");
  self.var_1ED4 = ::func_5DFF;
  var_03 = 150;
  var_04 = 0.1;
  var_05 = 0.1;
  var_06 = 0;
  var_07 = self.origin;
  var_08 = 0;
  for(;;) {
    var_09 = length((var_07[0], var_07[1], 0) - (self.origin[0], self.origin[1], 0));
    self.var_BCC9 = var_09;
    if(isDefined(self.var_BCCA)) {
      self.var_BCC9 = self.var_BCCA;
    }

    var_07 = self.origin;
    if(!scripts\sp\utility::func_65DB("dynamicThrusters")) {} else {
      if(isDefined(param_02)) {
        self[[param_02]](self.var_BCC9);
      }

      if(isDefined(self.script_team) && self.script_team == "axis" && self.var_BCC9 < 5) {
        var_08 = var_08 + 3;
        if(var_08 > 360) {
          var_08 = var_08 - 360;
        }

        var_0A = sin(var_08) * 0.5 + 0.5 * 0.3;
      } else {
        var_0A = scripts\sp\math::func_C097(0, var_03, self.var_BCC9);
      }

      var_06 = var_06 + var_0A - var_06 * var_05;
      var_0B = 1 - var_06;
      self give_attacker_kill_rewards(param_00, var_06, var_04, 1);
      self give_attacker_kill_rewards(param_01, var_0B, var_04, 1);
    }

    wait(var_04);
  }
}

func_774E(param_00) {
  var_01 = "allies";
  if(issubstr(param_00, "enemy")) {
    var_01 = "axis";
  }

  var_02 = "friendly";
  if(var_01 == "axis") {
    var_02 = "enemy";
  }

  if(issubstr(param_00, "_space")) {
    level._effect[var_01 + "_dropship_thrust_low"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_slow_moon.vfx");
    level._effect[var_01 + "_dropship_thrust_high"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_fast_moon.vfx");
    level._effect[var_01 + "_dropship_thrust_landed"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_idle.vfx");
    level._effect["dropship_thruster_tread_close"] = loadfx("vfx\no_effect.vfx");
    level._effect["dropship_thruster_tread_mid"] = loadfx("vfx\no_effect.vfx");
    level._effect["dropship_thruster_tread_high"] = loadfx("vfx\no_effect.vfx");
    return;
  }

  level._effect[var_01 + "_dropship_thrust_low"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_slow.vfx");
  level._effect[var_01 + "_dropship_thrust_high"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_fast.vfx");
  level._effect[var_01 + "_dropship_thrust_landed"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_02 + "\vfx_vehicle_dropship_" + var_01 + "_thruster_idle.vfx");
  level._effect["dropship_thruster_tread_close"] = loadfx("vfx\no_effect.vfx");
  level._effect["dropship_thruster_tread_mid"] = loadfx("vfx\no_effect.vfx");
  level._effect["dropship_thruster_tread_high"] = loadfx("vfx\no_effect.vfx");
}

func_774D() {
  scripts\sp\utility::func_65E0("thrusterEffects");
  scripts\sp\utility::func_65E1("thrusterEffects");
  scripts\sp\utility::func_65E0("inside_dropship_disable_effects");
  self.var_11865 = "low";
  self.var_11856 = "";
  thread func_11866();
}

func_774B(param_00) {
  foreach(var_02 in param_00) {
    thread scripts\sp\utility::func_75C4(self.script_team + "_dropship_thrust_high", var_02);
  }
}

func_FA5F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(self.var_11854)) {
    self.var_11854 = [];
  }

  if(!isDefined(self.var_1185B)) {
    self.var_1185B = [];
  }

  self.var_1185B = scripts\engine\utility::array_add(self.var_1185B, param_00);
  var_09 = spawnStruct();
  var_09.var_113EE = param_01;
  var_09.on = 0;
  if(!isDefined(param_02)) {
    param_02 = undefined;
  }

  var_09.var_B7CB = param_02;
  if(!isDefined(param_03)) {
    param_03 = undefined;
  }

  var_09.var_B4C9 = param_03;
  if(!isDefined(param_04)) {
    param_04 = undefined;
  }

  var_09.var_B783 = param_04;
  if(!isDefined(param_05)) {
    param_05 = undefined;
  }

  var_09.maxheight = param_05;
  if(!isDefined(param_06)) {
    var_0A = undefined;
  }

  var_09.var_6630 = param_06;
  if(!isDefined(param_07)) {
    param_07 = undefined;
  }

  var_09.var_4C94 = param_07;
  if(!isDefined(param_08)) {
    var_0B = undefined;
  }

  var_09.var_596F = param_08;
  self.var_11854[param_00] = var_09;
}

func_11866() {
  self endon("death");
  self endon("entitydeleted");
  var_00 = 1;
  var_01 = self.origin;
  for(;;) {
    if(!scripts\sp\utility::func_65DB("thrusterEffects") || scripts\sp\utility::func_65DB("inside_dropship_disable_effects")) {
      if(!var_00) {} else {
        func_1104F();
        var_00 = 0;
      } else {
        var_00 = 1;
        var_02 = length((var_01[0], var_01[1], 0) - (self.origin[0], self.origin[1], 0));
        self.var_BCC9 = var_02;
        if(isDefined(self.var_BCCA)) {
          self.var_BCC9 = self.var_BCCA;
        }

        var_01 = self.origin;
        var_03 = scripts\sp\utility::func_864C(self.origin);
        var_04 = distance(self.origin, var_03);
        self.var_8623 = var_04;
        if(isDefined(self.var_8624)) {
          self.var_8623 = self.var_8624;
        }

        var_05 = self.var_11865;
        if(var_02 >= 25) {
          var_05 = "high";
        } else if(self.var_BCC9 < 5 && self.var_8623 < 10) {
          var_05 = "landed";
        } else {
          var_05 = "low";
        }

        foreach(var_07 in self.var_1185B) {
          func_CE62(var_07, var_05);
        }

        self.var_11865 = var_05;
      }
    }

    wait(0.05);
  }
}

func_A61E(param_00) {
  foreach(var_02 in param_00) {
    func_A61D(var_02);
  }
}

func_A61D(param_00) {
  if(!isDefined(self.var_11854)) {
    return;
  }

  foreach(var_06, var_02 in self.var_11854) {
    foreach(var_04 in self.var_11854[var_06].var_113EE) {
      if(var_04 == param_00) {
        self.var_11854[var_06].var_113EE = scripts\engine\utility::array_remove(self.var_11854[var_06].var_113EE, var_04);
        stopFXOnTag(scripts\engine\utility::getfx(self.script_team + "_dropship_thrust_" + self.var_11865), self, var_04);
        return;
      }
    }
  }
}

func_CE62(param_00, param_01) {
  var_02 = self.var_11854[param_00];
  var_03 = self.var_BCC9;
  var_04 = self.var_8623;
  var_05 = 0;
  if(isDefined(var_02.var_B7CB)) {
    if(var_02.var_B7CB > var_03) {
      var_05 = 1;
    }
  }

  if(isDefined(var_02.var_B4C9)) {
    if(var_02.var_B4C9 < var_03) {
      var_05 = 1;
    }
  }

  if(isDefined(var_02.var_B783)) {
    if(var_02.var_B783 < var_04) {
      var_05 = 1;
    }
  }

  if(isDefined(var_02.maxheight)) {
    if(var_02.maxheight > var_04) {
      var_05 = 1;
    }
  }

  if(isDefined(var_02.var_6630)) {
    if(!scripts\sp\utility::func_65DB(var_02.var_6630)) {
      var_05 = 1;
    }
  }

  var_06 = 0;
  if(self.var_11865 != param_01) {
    var_06 = 1;
  }

  var_07 = 0;
  if(var_02.on) {
    var_07 = 1;
  }

  if(!var_06 && !var_05 && var_07) {
    return;
  }

  if(!var_06 && var_05 && !var_07) {
    return;
  }

  if(var_05 || var_06) {
    self notify(param_00 + "_stop_thruster_vfx");
    if(!isDefined(var_02.var_596F) || !var_02.var_596F) {
      func_1104F(param_00);
    }

    if(var_05) {
      return;
    }
  }

  var_08 = undefined;
  if(isDefined(var_02.var_4C94)) {
    var_08 = var_02.var_4C94;
  }

  var_09 = self.script_team + "_dropship_thrust_" + param_01;
  self.var_11856 = var_09;
  foreach(var_0B in var_02.var_113EE) {
    if(isDefined(var_08)) {
      self thread[[var_08]](var_09, var_0B, param_00);
      continue;
    }

    thread scripts\sp\utility::func_75C4(var_09, var_0B);
  }

  var_02.on = 1;
}

func_1104F(param_00) {
  var_01 = [];
  if(isDefined(param_00)) {
    var_01 = [param_00];
  } else {
    var_01 = self.var_1185B;
  }

  var_02 = self.script_team + "_dropship_thrust_" + self.var_11865;
  foreach(param_00 in var_01) {
    var_04 = self.var_11854[param_00];
    foreach(var_06 in var_04.var_113EE) {
      if(isDefined(var_04.var_4C94)) {
        self notify(param_00 + "_stop_thruster_vfx");
        continue;
      }

      thread scripts\sp\utility::func_75F8(var_02, var_06);
    }

    var_04.on = 0;
  }
}

func_A61F() {
  if(!isDefined(self.var_11854)) {
    return;
  }

  foreach(var_05, var_01 in self.var_11854) {
    foreach(var_03 in self.var_11854[var_05].var_113EE) {
      thread scripts\sp\utility::func_75A0(self.script_team + "_dropship_thrust_" + self.var_11865, var_03);
    }
  }
}

func_1185D(param_00, param_01, param_02) {
  self endon("death");
  self endon("entitydeleted");
  self endon(param_02 + "_stop_thruster_vfx");
  for(;;) {
    if(!isDefined(self.var_BCC9) || !isDefined(self.var_8623)) {} else {
      var_03 = self.var_8623;
      var_04 = undefined;
      if(var_03 < 125) {
        var_04 = "close";
      } else if(var_03 < 250) {
        var_04 = "mid";
      } else if(var_03 < 500) {
        var_04 = "high";
      }

      if(!isDefined(var_04)) {} else {
        var_05 = "dropship_thruster_tread_" + var_04;
        var_06 = (0, 0, -100000);
        var_07 = self gettagorigin(param_01);
        var_08 = bulletTrace(var_07, var_07 + var_06, 0, self);
        var_09 = var_08["position"];
        var_0A = var_09 - level.player.origin;
        var_0B = var_08["normal"];
        playFX(scripts\engine\utility::getfx(var_05), var_09, var_0B, var_0A);
      }
    }

    wait(0.33);
  }
}

func_774C() {
  self endon("death");
  self endon("entitydeleted");
  self endon("turnengineoff");
  thread func_5DAE();
  var_00 = [];
  var_00[0] = 4000;
  var_00[1] = 8000;
  var_00[2] = 12000;
  var_01 = [];
  var_01[0] = 40;
  var_01[1] = 25;
  self.var_11838 = spawn("script_origin", self.origin);
  self.var_11838 linkto(self);
  self.var_11838 ghostattack(0);
  self.var_90D5 = spawn("script_origin", self.origin);
  self.var_90D5 linkto(self);
  self.var_90D5 ghostattack(0);
  self _meth_83E8();
  wait(0.1);
  self.var_90D5 playLoopSound("dropship_enemy_idle_world");
  wait(0.05);
  self.var_90D5 ghostattack(1, 4);
  var_02 = "low";
  wait(0.9);
  for(;;) {
    var_03 = scripts\sp\utility::func_864C(self.origin);
    var_04 = distance(self.origin, var_03);
    while(!self vehicle_getspeed() > 2 || var_04 < 10) {
      var_03 = scripts\sp\utility::func_864C(self.origin);
      var_04 = distance(self.origin, var_03);
      wait(0.1);
    }

    while(!self vehicle_getspeed() > 2) {
      wait(0.1);
    }

    if(self vehicle_getspeed() > 2) {
      self playSound("dropship_enemy_takeoff_npc");
      self.var_11838 playLoopSound("dropship_enemy_thrust_world");
      self.var_11838 ghostattack(1, 2);
      thread func_5DEE("dropship_enemy_flyby", 1, var_00, var_01);
      self.var_90D5 ghostattack(0, 2);
      self.var_90D5 scripts\engine\utility::delaycall(2.1, ::stoploopsound);
      wait(1);
      while(self vehicle_getspeed() > 2) {
        if(var_02 == "low") {
          if(self.var_11865 == "high") {
            var_02 = "high";
            self playSound("dropship_enemy_thrust_change");
          }
        }

        wait(0.1);
      }

      self notify("stop_flybys");
      var_02 = "low";
      self.var_90D5 playLoopSound("dropship_enemy_hover_world");
      self.var_90D5 ghostattack(1, 2);
      self.var_11838 ghostattack(0, 2);
      self.var_11838 scripts\engine\utility::delaycall(2.1, ::stoploopsound);
      wait(0.1);
      continue;
    }

    wait(0.1);
  }
}

func_5DEE(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  if(!isDefined(self.audio)) {
    self.audio = spawnStruct();
  }

  self.audio.var_D889 = func_5DB5(param_01);
  self.audio.var_7008 = 0;
  self.audio.var_7007 = 0;
  self.audio.var_4E1F = 0;
  self.audio.var_20EF = 1;
  self.audio.var_B746 = 3;
  self.audio.var_B745 = 3;
  var_04 = 0.1;
  if(isarray(param_02)) {
    while(isDefined(self)) {
      var_05 = func_5DB5(param_01);
      for(var_06 = 0; var_06 < param_02.size; var_06++) {
        if(var_05 < param_02[var_06]) {
          if(var_06 == 0) {
            if(self.audio.var_20EF && self.audio.var_7008 == 0 && self.audio.var_4E1F == 0) {
              var_07 = func_5DEC(param_00, var_06, param_03);
              if(isDefined(var_07)) {
                thread func_5DED(var_07, var_06);
              }
            } else if(var_05 < self.audio.var_D889) {
              self.audio.var_20EF = 1;
            } else {
              self.audio.var_20EF = 0;
            }
          } else if(var_05 > self.audio.var_D889) {
            if(self.audio.var_20EF && self.audio.var_7008 == 0 && self.audio.var_7007 == 0 && self.audio.var_4E1F == 0) {
              self.audio.var_20EF = 0;
              var_07 = func_5DEC(param_00, var_06, param_03);
              if(isDefined(var_07)) {
                thread func_5DED(var_07, var_06);
              }
            }
          } else if(var_05 < 2500) {
            if(self.audio.var_7008 == 0 && self.audio.var_7007 == 0 && self.audio.var_4E1F == 0) {
              var_07 = func_5DEC(param_00, var_06, param_03);
              if(isDefined(var_07)) {
                thread func_5DED(var_07, var_06);
              }
            }
          } else {
            self.audio.var_20EF = 1;
          }

          break;
        }
      }

      self.audio.var_D889 = var_05;
      wait(var_04);
    }
  }
}

func_5DB5(param_00) {
  if(scripts\engine\utility::player_is_in_jackal()) {
    var_01 = level.var_D127.origin;
  } else {
    var_01 = level.player.origin;
  }

  var_02 = 0;
  if(isDefined(param_00)) {
    var_02 = param_00;
  }

  if(var_02) {
    var_03 = distance(self.origin, var_01);
  } else {
    var_03 = distance2d(self.origin, var_02);
  }

  return var_03;
}

func_5DEC(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = self vehicle_getvelocity();
  var_05 = length(var_04) * 0.05681818;
  if(var_05 > 15) {
    if(isarray(param_02)) {
      if(scripts\engine\utility::player_is_in_jackal()) {
        var_06 = level.var_D127._func_2AC * 17.6;
      } else {
        var_06 = level.player getvelocity();
      }

      var_07 = var_04 - var_06;
      var_08 = length(var_07) * 0.05681818;
      if(var_08 < 15) {
        return undefined;
      }

      for(var_09 = 0; var_09 < param_02.size; var_09++) {
        var_03 = var_09 + 1;
        if(var_08 > param_02[var_09]) {
          var_03 = var_09;
          break;
        }
      }
    }

    if(var_03 == 0) {
      var_0A = "fast";
    } else if(var_04 == 1) {
      var_0A = "med";
    } else {
      var_0A = "slow";
    }

    if(param_01 == 0) {
      var_0B = "close";
    } else if(param_02 == 1) {
      var_0B = "mid";
    } else if(param_02 == 2) {
      var_0B = "far";
    } else {
      return undefined;
    }

    if(scripts\engine\utility::player_is_in_jackal()) {
      var_0C = param_00 + "_" + var_0A + "_" + var_0B;
    } else {
      var_0C = param_01 + "_" + var_0B + "_" + var_0C + "_grnd";
    }

    if(param_01 == 0) {
      self.audio.var_7008 = 1;
    } else {
      self.audio.var_7007 = 1;
    }

    return var_0C;
  }

  return undefined;
}

func_5DED(param_00, param_01) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  thread func_5EA9(param_01);
  self.var_11838 ghostattack(0.4, 1);
  self playSound(param_00);
  wait(1);
  self.var_11838 ghostattack(1, 4);
}

func_5EA9(param_00) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  if(isDefined(param_00)) {
    if(param_00 == 0) {
      wait(self.audio.var_B746);
      if(isDefined(self)) {
        self.audio.var_7008 = 0;
        return;
      }

      return;
    }

    wait(self.audio.var_B745);
    if(isDefined(self)) {
      self.audio.var_7007 = 0;
      return;
    }
  }
}

func_5DAE() {
  self waittill("death");
  if(isDefined(self.var_5ECA)) {
    self.var_5ECA delete();
  }

  if(isDefined(self.var_11838)) {
    self.var_11838 delete();
  }

  if(isDefined(self.var_90D5)) {
    self.var_90D5 delete();
  }
}

func_5DFF() {
  return % scripted;
}