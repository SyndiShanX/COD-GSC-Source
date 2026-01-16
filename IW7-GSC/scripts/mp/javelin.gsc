/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\javelin.gsc
*********************************************/

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
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 15000;
  var_4 = bulletTrace(var_0, var_3, 0, undefined);
  if(var_4["surfacetype"] == "none") {
    return undefined;
  }

  if(var_4["surfacetype"] == "default") {
    return undefined;
  }

  var_5 = var_4["entity"];
  if(isDefined(var_5)) {
    if(var_5 == level.ac130.planemodel) {
      return undefined;
    }
  }

  var_6 = [];
  var_6[0] = var_4["position"];
  var_6[1] = var_4["normal"];
  return var_6;
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
  var_0 = 4;
  if(isDefined(self.var_A43E) && self.var_A43E >= var_0) {
    return 1;
  }

  return 0;
}

func_11579(var_0) {
  var_1 = 1100;
  var_2 = distance(self.origin, var_0);
  if(var_2 < var_1) {
    return 1;
  }

  return 0;
}

func_B061(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_lockon_sound");
  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

func_11A03(var_0, var_1) {
  var_2 = var_0 + var_1 * 10;
  var_3 = var_2 + (0, 0, 2000);
  var_4 = bulletTrace(var_2, var_3, 0, undefined);
  if(sighttracepassed(var_2, var_3, 0, undefined)) {
    return 1;
  }

  return 0;
}

func_A448() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = 1150;
  var_1 = 25;
  var_2 = 100;
  var_3 = 400;
  var_4 = 12;
  var_5 = 0;
  var_6 = 0;
  self.var_A445 = undefined;
  func_9887();
  for(;;) {
    wait(0.05);
    var_7 = self getcurrentweapon();
    if((isbot(self) && var_7 != "javelin_mp") || !issubstr(var_7, "javelin") || scripts\mp\killstreaks\emp_common::isemped()) {
      if(isDefined(self.var_A449)) {
        func_E254();
      }

      continue;
    }

    if(self playerads() < 0.95) {
      var_6 = gettime();
      func_E254();
      continue;
    }

    var_8 = 0;
    if(getdvar("missileDebugDraw") == "1") {
      var_8 = 1;
    }

    var_9 = 0;
    if(getdvar("missileDebugText") == "1") {
      var_9 = 1;
    }

    self.var_A449 = 1;
    if(!isDefined(self.var_A444)) {
      self.var_A444 = 1;
    }

    if(self.var_A444 == 1) {
      var_10 = scripts\mp\weapons::func_AF2B();
      if(var_10.size != 0) {
        var_11 = [];
        foreach(var_13 in var_10) {
          var_14 = self worldpointinreticle_circle(var_13.origin, 65, 40);
          if(var_14) {
            var_11[var_11.size] = var_13;
          }
        }

        if(var_11.size != 0) {
          var_10 = sortbydistance(var_11, self.origin);
          if(!func_13263(var_10[0])) {
            continue;
          }

          if(var_9) {}

          self.var_A445 = var_10[0];
          if(!isDefined(self.var_A43F)) {
            self.var_A43F = gettime();
          }

          self.var_A444 = 2;
          self.var_A441 = 0;
          func_A440(var_0);
          self.var_A444 = 1;
          continue;
        }
      }

      if(func_AF26()) {
        func_E254();
        continue;
      }

      var_11 = gettime() - var_6;
      if(var_11 < var_2) {
        continue;
      }

      var_11 = gettime() - var_5;
      if(var_11 < var_1) {
        continue;
      }

      var_5 = gettime();
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
        if(var_17 > var_3) {
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
      if(self.var_A443.size < var_4) {
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
      var_14 = self worldpointinreticle_circle(self.var_A447, 65, 45);
      if(!var_14) {
        func_E254();
        continue;
      }

      if(func_11579(self.var_A447)) {
        self weaponlocktargettooclose(1);
      } else {
        self weaponlocktargettooclose(0);
      }

      var_11 = gettime() - self.var_A43F;
      if(var_11 < var_0) {
        continue;
      }

      self func_8402(self.var_A447, (0, 0, 0), 1);
      self notify("stop_lockon_sound");
      self playlocalsound("javelin_clu_lock");
      self.var_A444 = 3;
    }

    if(self.var_A444 == 3) {
      var_14 = self worldpointinreticle_circle(self.var_A447, 65, 45);
      if(!var_14) {
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

func_4F53(var_0, var_1, var_2) {}

func_13263(var_0) {
  var_1 = self getEye();
  var_2 = var_0 getpointinbounds(0, 0, 0);
  var_3 = sighttracepassed(var_1, var_2, 0, var_0);
  func_4F53(var_1, var_2, var_3);
  if(var_3) {
    return 1;
  }

  var_4 = var_0 getpointinbounds(1, 0, 0);
  var_3 = sighttracepassed(var_1, var_4, 0, var_0);
  func_4F53(var_1, var_4, var_3);
  if(var_3) {
    return 1;
  }

  var_5 = var_0 getpointinbounds(-1, 0, 0);
  var_3 = sighttracepassed(var_1, var_5, 0, var_0);
  func_4F53(var_1, var_5, var_3);
  if(var_3) {
    return 1;
  }

  return 0;
}

func_A440(var_0) {
  if(self.var_A444 == 2) {
    self weaponlockstart(self.var_A445);
    if(!func_10F9B(self.var_A445)) {
      func_E254();
      self.var_A43F = undefined;
      return;
    }

    var_1 = softsighttest();
    if(!var_1) {
      self.var_A43F = undefined;
      return;
    }

    if(!isDefined(self.var_4BF3) || !self.var_4BF3) {
      thread func_B061("javelin_clu_aquiring_lock", 0.6);
      self.var_4BF3 = 1;
    }

    var_2 = gettime() - self.var_A43F;
    if(scripts\mp\utility::_hasperk("specialty_fasterlockon")) {
      if(var_2 < var_0 * 0.5) {
        return;
      }
    } else if(var_2 < var_0) {
      return;
    }

    if(isplayer(self.var_A445)) {
      self func_8402(self.var_A445, (0, 0, 64), 0);
    } else {
      self func_8402(self.var_A445, (0, 0, 0), 0);
    }

    self notify("stop_lockon_sound");
    if(!isDefined(self.var_4BF2) || !self.var_4BF2) {
      self playlocalsound("javelin_clu_lock");
      self.var_4BF2 = 1;
    }

    self.var_A444 = 3;
  }

  if(self.var_A444 == 3) {
    var_1 = softsighttest();
    if(!var_1) {
      return;
    }

    if(!func_10F9B(self.var_A445)) {
      func_E254();
      return;
    }
  }
}

func_10F9B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!self worldpointinreticle_circle(var_0.origin, 65, 85)) {
    return 0;
  }

  return 1;
}

softsighttest() {
  var_0 = 500;
  if(func_13263(self.var_A445)) {
    self.var_A441 = 0;
    return 1;
  }

  if(self.var_A441 == 0) {
    self.var_A441 = gettime();
  }

  var_1 = gettime() - self.var_A441;
  if(var_1 >= var_0) {
    func_E254();
    return 0;
  }

  return 1;
}