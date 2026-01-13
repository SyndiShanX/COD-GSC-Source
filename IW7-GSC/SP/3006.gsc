/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3006.gsc
*********************************************/

func_5DFB(var_0) {
  var_1 = self.var_7724;
  var_2 = self.var_7723;
  if(var_0 == "down") {
    var_1 = self.var_7723;
    var_2 = self.var_7724;
  }

  self clearanim(var_2, 0.05);
  self give_attacker_kill_rewards(var_1);
}

func_9782(var_0, var_1) {
  self.var_1186E = var_0;
  self.var_11855 = var_1;
}

func_5EC8(var_0, var_1, var_2) {
  self endon("death");
  self glinton(#animtree);
  scripts\sp\utility::func_65E0("dynamicThrusters");
  scripts\sp\utility::func_65E1("dynamicThrusters");
  self.var_1ED4 = ::func_5DFF;
  var_3 = 150;
  var_4 = 0.1;
  var_5 = 0.1;
  var_6 = 0;
  var_7 = self.origin;
  var_8 = 0;
  for(;;) {
    var_9 = length((var_7[0], var_7[1], 0) - (self.origin[0], self.origin[1], 0));
    self.var_BCC9 = var_9;
    if(isDefined(self.var_BCCA)) {
      self.var_BCC9 = self.var_BCCA;
    }

    var_7 = self.origin;
    if(!scripts\sp\utility::func_65DB("dynamicThrusters")) {} else {
      if(isDefined(var_2)) {
        self[[var_2]](self.var_BCC9);
      }

      if(isDefined(self.script_team) && self.script_team == "axis" && self.var_BCC9 < 5) {
        var_8 = var_8 + 3;
        if(var_8 > 360) {
          var_8 = var_8 - 360;
        }

        var_0A = sin(var_8) * 0.5 + 0.5 * 0.3;
      } else {
        var_0A = scripts\sp\math::func_C097(0, var_3, self.var_BCC9);
      }

      var_6 = var_6 + var_0A - var_6 * var_5;
      var_0B = 1 - var_6;
      self give_attacker_kill_rewards(var_0, var_6, var_4, 1);
      self give_attacker_kill_rewards(var_1, var_0B, var_4, 1);
    }

    wait(var_4);
  }
}

func_774E(var_0) {
  var_1 = "allies";
  if(issubstr(var_0, "enemy")) {
    var_1 = "axis";
  }

  var_2 = "friendly";
  if(var_1 == "axis") {
    var_2 = "enemy";
  }

  if(issubstr(var_0, "_space")) {
    level._effect[var_1 + "_dropship_thrust_low"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_slow_moon.vfx");
    level._effect[var_1 + "_dropship_thrust_high"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_fast_moon.vfx");
    level._effect[var_1 + "_dropship_thrust_landed"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_idle.vfx");
    level._effect["dropship_thruster_tread_close"] = loadfx("vfx\no_effect.vfx");
    level._effect["dropship_thruster_tread_mid"] = loadfx("vfx\no_effect.vfx");
    level._effect["dropship_thruster_tread_high"] = loadfx("vfx\no_effect.vfx");
    return;
  }

  level._effect[var_1 + "_dropship_thrust_low"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_slow.vfx");
  level._effect[var_1 + "_dropship_thrust_high"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_fast.vfx");
  level._effect[var_1 + "_dropship_thrust_landed"] = loadfx("vfx\iw7\core\vehicle\dropship_" + var_2 + "\vfx_vehicle_dropship_" + var_1 + "_thruster_idle.vfx");
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

func_774B(var_0) {
  foreach(var_2 in var_0) {
    thread scripts\sp\utility::func_75C4(self.script_team + "_dropship_thrust_high", var_2);
  }
}

func_FA5F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self.var_11854)) {
    self.var_11854 = [];
  }

  if(!isDefined(self.var_1185B)) {
    self.var_1185B = [];
  }

  self.var_1185B = scripts\engine\utility::array_add(self.var_1185B, var_0);
  var_9 = spawnStruct();
  var_9.var_113EE = var_1;
  var_9.on = 0;
  if(!isDefined(var_2)) {
    var_2 = undefined;
  }

  var_9.var_B7CB = var_2;
  if(!isDefined(var_3)) {
    var_3 = undefined;
  }

  var_9.var_B4C9 = var_3;
  if(!isDefined(var_4)) {
    var_4 = undefined;
  }

  var_9.var_B783 = var_4;
  if(!isDefined(var_5)) {
    var_5 = undefined;
  }

  var_9.maxheight = var_5;
  if(!isDefined(var_6)) {
    var_0A = undefined;
  }

  var_9.var_6630 = var_6;
  if(!isDefined(var_7)) {
    var_7 = undefined;
  }

  var_9.var_4C94 = var_7;
  if(!isDefined(var_8)) {
    var_0B = undefined;
  }

  var_9.var_596F = var_8;
  self.var_11854[var_0] = var_9;
}

func_11866() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 1;
  var_1 = self.origin;
  for(;;) {
    if(!scripts\sp\utility::func_65DB("thrusterEffects") || scripts\sp\utility::func_65DB("inside_dropship_disable_effects")) {
      if(!var_0) {} else {
        func_1104F();
        var_0 = 0;
      } else {
        var_0 = 1;
        var_2 = length((var_1[0], var_1[1], 0) - (self.origin[0], self.origin[1], 0));
        self.var_BCC9 = var_2;
        if(isDefined(self.var_BCCA)) {
          self.var_BCC9 = self.var_BCCA;
        }

        var_1 = self.origin;
        var_3 = scripts\sp\utility::func_864C(self.origin);
        var_4 = distance(self.origin, var_3);
        self.var_8623 = var_4;
        if(isDefined(self.var_8624)) {
          self.var_8623 = self.var_8624;
        }

        var_5 = self.var_11865;
        if(var_2 >= 25) {
          var_5 = "high";
        } else if(self.var_BCC9 < 5 && self.var_8623 < 10) {
          var_5 = "landed";
        } else {
          var_5 = "low";
        }

        foreach(var_7 in self.var_1185B) {
          func_CE62(var_7, var_5);
        }

        self.var_11865 = var_5;
      }
    }

    wait(0.05);
  }
}

func_A61E(var_0) {
  foreach(var_2 in var_0) {
    func_A61D(var_2);
  }
}

func_A61D(var_0) {
  if(!isDefined(self.var_11854)) {
    return;
  }

  foreach(var_6, var_2 in self.var_11854) {
    foreach(var_4 in self.var_11854[var_6].var_113EE) {
      if(var_4 == var_0) {
        self.var_11854[var_6].var_113EE = scripts\engine\utility::array_remove(self.var_11854[var_6].var_113EE, var_4);
        stopFXOnTag(scripts\engine\utility::getfx(self.script_team + "_dropship_thrust_" + self.var_11865), self, var_4);
        return;
      }
    }
  }
}

func_CE62(var_0, var_1) {
  var_2 = self.var_11854[var_0];
  var_3 = self.var_BCC9;
  var_4 = self.var_8623;
  var_5 = 0;
  if(isDefined(var_2.var_B7CB)) {
    if(var_2.var_B7CB > var_3) {
      var_5 = 1;
    }
  }

  if(isDefined(var_2.var_B4C9)) {
    if(var_2.var_B4C9 < var_3) {
      var_5 = 1;
    }
  }

  if(isDefined(var_2.var_B783)) {
    if(var_2.var_B783 < var_4) {
      var_5 = 1;
    }
  }

  if(isDefined(var_2.maxheight)) {
    if(var_2.maxheight > var_4) {
      var_5 = 1;
    }
  }

  if(isDefined(var_2.var_6630)) {
    if(!scripts\sp\utility::func_65DB(var_2.var_6630)) {
      var_5 = 1;
    }
  }

  var_6 = 0;
  if(self.var_11865 != var_1) {
    var_6 = 1;
  }

  var_7 = 0;
  if(var_2.on) {
    var_7 = 1;
  }

  if(!var_6 && !var_5 && var_7) {
    return;
  }

  if(!var_6 && var_5 && !var_7) {
    return;
  }

  if(var_5 || var_6) {
    self notify(var_0 + "_stop_thruster_vfx");
    if(!isDefined(var_2.var_596F) || !var_2.var_596F) {
      func_1104F(var_0);
    }

    if(var_5) {
      return;
    }
  }

  var_8 = undefined;
  if(isDefined(var_2.var_4C94)) {
    var_8 = var_2.var_4C94;
  }

  var_9 = self.script_team + "_dropship_thrust_" + var_1;
  self.var_11856 = var_9;
  foreach(var_0B in var_2.var_113EE) {
    if(isDefined(var_8)) {
      self thread[[var_8]](var_9, var_0B, var_0);
      continue;
    }

    thread scripts\sp\utility::func_75C4(var_9, var_0B);
  }

  var_2.on = 1;
}

func_1104F(var_0) {
  var_1 = [];
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = self.var_1185B;
  }

  var_2 = self.script_team + "_dropship_thrust_" + self.var_11865;
  foreach(var_0 in var_1) {
    var_4 = self.var_11854[var_0];
    foreach(var_6 in var_4.var_113EE) {
      if(isDefined(var_4.var_4C94)) {
        self notify(var_0 + "_stop_thruster_vfx");
        continue;
      }

      thread scripts\sp\utility::func_75F8(var_2, var_6);
    }

    var_4.on = 0;
  }
}

func_A61F() {
  if(!isDefined(self.var_11854)) {
    return;
  }

  foreach(var_5, var_1 in self.var_11854) {
    foreach(var_3 in self.var_11854[var_5].var_113EE) {
      thread scripts\sp\utility::func_75A0(self.script_team + "_dropship_thrust_" + self.var_11865, var_3);
    }
  }
}

func_1185D(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  self endon(var_2 + "_stop_thruster_vfx");
  for(;;) {
    if(!isDefined(self.var_BCC9) || !isDefined(self.var_8623)) {} else {
      var_3 = self.var_8623;
      var_4 = undefined;
      if(var_3 < 125) {
        var_4 = "close";
      } else if(var_3 < 250) {
        var_4 = "mid";
      } else if(var_3 < 500) {
        var_4 = "high";
      }

      if(!isDefined(var_4)) {} else {
        var_5 = "dropship_thruster_tread_" + var_4;
        var_6 = (0, 0, -100000);
        var_7 = self gettagorigin(var_1);
        var_8 = bulletTrace(var_7, var_7 + var_6, 0, self);
        var_9 = var_8["position"];
        var_0A = var_9 - level.player.origin;
        var_0B = var_8["normal"];
        playFX(scripts\engine\utility::getfx(var_5), var_9, var_0B, var_0A);
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
  var_0 = [];
  var_0[0] = 4000;
  var_0[1] = 8000;
  var_0[2] = 12000;
  var_1 = [];
  var_1[0] = 40;
  var_1[1] = 25;
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
  var_2 = "low";
  wait(0.9);
  for(;;) {
    var_3 = scripts\sp\utility::func_864C(self.origin);
    var_4 = distance(self.origin, var_3);
    while(!self vehicle_getspeed() > 2 || var_4 < 10) {
      var_3 = scripts\sp\utility::func_864C(self.origin);
      var_4 = distance(self.origin, var_3);
      wait(0.1);
    }

    while(!self vehicle_getspeed() > 2) {
      wait(0.1);
    }

    if(self vehicle_getspeed() > 2) {
      self playSound("dropship_enemy_takeoff_npc");
      self.var_11838 playLoopSound("dropship_enemy_thrust_world");
      self.var_11838 ghostattack(1, 2);
      thread func_5DEE("dropship_enemy_flyby", 1, var_0, var_1);
      self.var_90D5 ghostattack(0, 2);
      self.var_90D5 scripts\engine\utility::delaycall(2.1, ::stoploopsound);
      wait(1);
      while(self vehicle_getspeed() > 2) {
        if(var_2 == "low") {
          if(self.var_11865 == "high") {
            var_2 = "high";
            self playSound("dropship_enemy_thrust_change");
          }
        }

        wait(0.1);
      }

      self notify("stop_flybys");
      var_2 = "low";
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

func_5DEE(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  if(!isDefined(self.audio)) {
    self.audio = spawnStruct();
  }

  self.audio.var_D889 = func_5DB5(var_1);
  self.audio.var_7008 = 0;
  self.audio.var_7007 = 0;
  self.audio.var_4E1F = 0;
  self.audio.var_20EF = 1;
  self.audio.var_B746 = 3;
  self.audio.var_B745 = 3;
  var_4 = 0.1;
  if(isarray(var_2)) {
    while(isDefined(self)) {
      var_5 = func_5DB5(var_1);
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_5 < var_2[var_6]) {
          if(var_6 == 0) {
            if(self.audio.var_20EF && self.audio.var_7008 == 0 && self.audio.var_4E1F == 0) {
              var_7 = func_5DEC(var_0, var_6, var_3);
              if(isDefined(var_7)) {
                thread func_5DED(var_7, var_6);
              }
            } else if(var_5 < self.audio.var_D889) {
              self.audio.var_20EF = 1;
            } else {
              self.audio.var_20EF = 0;
            }
          } else if(var_5 > self.audio.var_D889) {
            if(self.audio.var_20EF && self.audio.var_7008 == 0 && self.audio.var_7007 == 0 && self.audio.var_4E1F == 0) {
              self.audio.var_20EF = 0;
              var_7 = func_5DEC(var_0, var_6, var_3);
              if(isDefined(var_7)) {
                thread func_5DED(var_7, var_6);
              }
            }
          } else if(var_5 < 2500) {
            if(self.audio.var_7008 == 0 && self.audio.var_7007 == 0 && self.audio.var_4E1F == 0) {
              var_7 = func_5DEC(var_0, var_6, var_3);
              if(isDefined(var_7)) {
                thread func_5DED(var_7, var_6);
              }
            }
          } else {
            self.audio.var_20EF = 1;
          }

          break;
        }
      }

      self.audio.var_D889 = var_5;
      wait(var_4);
    }
  }
}

func_5DB5(var_0) {
  if(scripts\engine\utility::player_is_in_jackal()) {
    var_1 = level.var_D127.origin;
  } else {
    var_1 = level.player.origin;
  }

  var_2 = 0;
  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(var_2) {
    var_3 = distance(self.origin, var_1);
  } else {
    var_3 = distance2d(self.origin, var_2);
  }

  return var_3;
}

func_5DEC(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = self vehicle_getvelocity();
  var_5 = length(var_4) * 0.05681818;
  if(var_5 > 15) {
    if(isarray(var_2)) {
      if(scripts\engine\utility::player_is_in_jackal()) {
        var_6 = level.var_D127._func_2AC * 17.6;
      } else {
        var_6 = level.player getvelocity();
      }

      var_7 = var_4 - var_6;
      var_8 = length(var_7) * 0.05681818;
      if(var_8 < 15) {
        return undefined;
      }

      for(var_9 = 0; var_9 < var_2.size; var_9++) {
        var_3 = var_9 + 1;
        if(var_8 > var_2[var_9]) {
          var_3 = var_9;
          break;
        }
      }
    }

    if(var_3 == 0) {
      var_0A = "fast";
    } else if(var_4 == 1) {
      var_0A = "med";
    } else {
      var_0A = "slow";
    }

    if(var_1 == 0) {
      var_0B = "close";
    } else if(var_2 == 1) {
      var_0B = "mid";
    } else if(var_2 == 2) {
      var_0B = "far";
    } else {
      return undefined;
    }

    if(scripts\engine\utility::player_is_in_jackal()) {
      var_0C = var_0 + "_" + var_0A + "_" + var_0B;
    } else {
      var_0C = var_1 + "_" + var_0B + "_" + var_0C + "_grnd";
    }

    if(var_1 == 0) {
      self.audio.var_7008 = 1;
    } else {
      self.audio.var_7007 = 1;
    }

    return var_0C;
  }

  return undefined;
}

func_5DED(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  thread func_5EA9(var_1);
  self.var_11838 ghostattack(0.4, 1);
  self playSound(var_0);
  wait(1);
  self.var_11838 ghostattack(1, 4);
}

func_5EA9(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_flybys");
  self endon("turnengineoff");
  if(isDefined(var_0)) {
    if(var_0 == 0) {
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