/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\javelin.gsc
**********************************/

func_9887() {
  self.var_A444 = undefined;
  self.var_A443 = undefined;
  self.var_A442 = undefined;
  self.var_A43E = undefined;
  self.var_A447 = undefined;
  self.var_A446 = undefined;
  self.var_A43F = undefined;
}

func_E254() {
  if(!isDefined(self.var_A449)) {
    return;
  }

  self.var_A449 = undefined;
  self notify("stop_lockon_sound");
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  self.var_4BF3 = 0;
  self.var_4BF2 = 0;
  self.var_A445 = undefined;
  self stoplocalsound("javelin_clu_lock");
  self stoplocalsound("javelin_clu_aquiring_lock");
  func_9887();
}

func_6A61() {
  var_00 = self getEye();
  var_01 = self getplayerangles();
  var_02 = anglesToForward(var_01);
  var_03 = var_00 + var_02 * 15000;
  var_04 = bulletTrace(var_00, var_03, 0, undefined);
  if(var_04["surfacetype"] == "none") {
    return undefined;
  }

  if(var_04["surfacetype"] == "default") {
    return undefined;
  }

  var_05 = var_04["entity"];
  if(isDefined(var_05)) {
    if(var_05 == level.ac130.planemodel) {
      return undefined;
    }
  }

  var_06 = [];
  var_06[0] = var_04["position"];
  var_06[1] = var_04["normal"];
  return var_06;
}

func_AF27() {
  self.var_A43E = undefined;
}

func_AF25() {
  if(!isDefined(self.var_A43E)) {
    self.var_A43E = 1;
    return;
  }

  self.var_A43E++;
}

func_AF26() {
  var_00 = 4;
  if(isDefined(self.var_A43E) && self.var_A43E >= var_00) {
    return 1;
  }

  return 0;
}

func_11579(param_00) {
  var_01 = 1100;
  var_02 = distance(self.origin, param_00);
  if(var_02 < var_01) {
    return 1;
  }

  return 0;
}

func_B061(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_lockon_sound");
  for(;;) {
    self playlocalsound(param_00);
    wait(param_01);
  }
}

func_11A03(param_00, param_01) {
  var_02 = param_00 + param_01 * 10;
  var_03 = var_02 + (0, 0, 2000);
  var_04 = bulletTrace(var_02, var_03, 0, undefined);
  if(sighttracepassed(var_02, var_03, 0, undefined)) {
    return 1;
  }

  return 0;
}

func_A448() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = 1150;
  var_01 = 25;
  var_02 = 100;
  var_03 = 400;
  var_04 = 12;
  var_05 = 0;
  var_06 = 0;
  self.var_A445 = undefined;
  func_9887();
  for(;;) {
    wait(0.05);
    var_07 = self getcurrentweapon();
    if((isbot(self) && var_07 != "javelin_mp") || !issubstr(var_07, "javelin") || scripts\mp\killstreaks\_emp_common::isemped()) {
      if(isDefined(self.var_A449)) {
        func_E254();
      }

      continue;
    }

    if(self getweaponrankinfominxp() < 0.95) {
      var_06 = gettime();
      func_E254();
      continue;
    }

    var_08 = 0;
    if(getdvar("missileDebugDraw") == "1") {
      var_08 = 1;
    }

    var_09 = 0;
    if(getdvar("missileDebugText") == "1") {
      var_09 = 1;
    }

    self.var_A449 = 1;
    if(!isDefined(self.var_A444)) {
      self.var_A444 = 1;
    }

    if(self.var_A444 == 1) {
      var_0A = scripts\mp\weapons::func_AF2B();
      if(var_0A.size != 0) {
        var_0B = [];
        foreach(var_0D in var_0A) {
          var_0E = self worldpointinreticle_circle(var_0D.origin, 65, 40);
          if(var_0E) {
            var_0B[var_0B.size] = var_0D;
          }
        }

        if(var_0B.size != 0) {
          var_10 = sortbydistance(var_0B, self.origin);
          if(!func_13263(var_10[0])) {
            continue;
          }

          if(var_09) {}

          self.var_A445 = var_10[0];
          if(!isDefined(self.var_A43F)) {
            self.var_A43F = gettime();
          }

          self.var_A444 = 2;
          self.var_A441 = 0;
          func_A440(var_00);
          self.var_A444 = 1;
          continue;
        }
      }

      if(func_AF26()) {
        func_E254();
        continue;
      }

      var_11 = gettime() - var_06;
      if(var_11 < var_02) {
        continue;
      }

      var_11 = gettime() - var_05;
      if(var_11 < var_01) {
        continue;
      }

      var_05 = gettime();
      var_15 = func_6A61();
      if(!isDefined(var_15)) {
        func_AF25();
        continue;
      }

      if(func_11579(var_15[0])) {
        self weaponlocktargettooclose(1);
        continue;
      } else {
        self weaponlocktargettooclose(0);
      }

      if(isDefined(self.var_A443)) {
        var_16 = averagepoint(self.var_A443);
        var_17 = distance(var_16, var_15[0]);
        if(var_17 > var_03) {
          func_AF25();
          continue;
        }
      } else {
        self.var_A443 = [];
        self.var_A442 = [];
      }

      self.var_A443[self.var_A443.size] = var_15[0];
      self.var_A442[self.var_A442.size] = var_15[1];
      func_AF27();
      if(self.var_A443.size < var_04) {
        continue;
      }

      self.var_A447 = averagepoint(self.var_A443);
      self.var_A446 = averagenormal(self.var_A442);
      self.var_A43E = undefined;
      self.var_A443 = undefined;
      self.var_A442 = undefined;
      self.var_A43F = gettime();
      self weaponlockstart(self.var_A447);
      thread func_B061("javelin_clu_aquiring_lock", 0.6);
      self.var_A444 = 2;
    }

    if(self.var_A444 == 2) {
      var_0E = self worldpointinreticle_circle(self.var_A447, 65, 45);
      if(!var_0E) {
        func_E254();
        continue;
      }

      if(func_11579(self.var_A447)) {
        self weaponlocktargettooclose(1);
      } else {
        self weaponlocktargettooclose(0);
      }

      var_11 = gettime() - self.var_A43F;
      if(var_11 < var_00) {
        continue;
      }

      self _meth_8402(self.var_A447, (0, 0, 0), 1);
      self notify("stop_lockon_sound");
      self playlocalsound("javelin_clu_lock");
      self.var_A444 = 3;
    }

    if(self.var_A444 == 3) {
      var_0E = self worldpointinreticle_circle(self.var_A447, 65, 45);
      if(!var_0E) {
        func_E254();
        continue;
      }

      if(func_11579(self.var_A447)) {
        self weaponlocktargettooclose(1);
      } else {
        self weaponlocktargettooclose(0);
      }

      continue;
    }
  }
}

func_4F53(param_00, param_01, param_02) {}

func_13263(param_00) {
  var_01 = self getEye();
  var_02 = param_00 getpointinbounds(0, 0, 0);
  var_03 = sighttracepassed(var_01, var_02, 0, param_00);
  func_4F53(var_01, var_02, var_03);
  if(var_03) {
    return 1;
  }

  var_04 = param_00 getpointinbounds(1, 0, 0);
  var_03 = sighttracepassed(var_01, var_04, 0, param_00);
  func_4F53(var_01, var_04, var_03);
  if(var_03) {
    return 1;
  }

  var_05 = param_00 getpointinbounds(-1, 0, 0);
  var_03 = sighttracepassed(var_01, var_05, 0, param_00);
  func_4F53(var_01, var_05, var_03);
  if(var_03) {
    return 1;
  }

  return 0;
}

func_A440(param_00) {
  if(self.var_A444 == 2) {
    self weaponlockstart(self.var_A445);
    if(!func_10F9B(self.var_A445)) {
      func_E254();
      self.var_A43F = undefined;
      return;
    }

    var_01 = softsighttest();
    if(!var_01) {
      self.var_A43F = undefined;
      return;
    }

    if(!isDefined(self.var_4BF3) || !self.var_4BF3) {
      thread func_B061("javelin_clu_aquiring_lock", 0.6);
      self.var_4BF3 = 1;
    }

    var_02 = gettime() - self.var_A43F;
    if(scripts\mp\utility::_hasperk("specialty_fasterlockon")) {
      if(var_02 < param_00 * 0.5) {
        return;
      }
    } else if(var_02 < param_00) {
      return;
    }

    if(isplayer(self.var_A445)) {
      self _meth_8402(self.var_A445, (0, 0, 64), 0);
    } else {
      self _meth_8402(self.var_A445, (0, 0, 0), 0);
    }

    self notify("stop_lockon_sound");
    if(!isDefined(self.var_4BF2) || !self.var_4BF2) {
      self playlocalsound("javelin_clu_lock");
      self.var_4BF2 = 1;
    }

    self.var_A444 = 3;
  }

  if(self.var_A444 == 3) {
    var_01 = softsighttest();
    if(!var_01) {
      return;
    }

    if(!func_10F9B(self.var_A445)) {
      func_E254();
      return;
    }
  }
}

func_10F9B(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!self worldpointinreticle_circle(param_00.origin, 65, 85)) {
    return 0;
  }

  return 1;
}

softsighttest() {
  var_00 = 500;
  if(func_13263(self.var_A445)) {
    self.var_A441 = 0;
    return 1;
  }

  if(self.var_A441 == 0) {
    self.var_A441 = gettime();
  }

  var_01 = gettime() - self.var_A441;
  if(var_01 >= var_00) {
    func_E254();
    return 0;
  }

  return 1;
}