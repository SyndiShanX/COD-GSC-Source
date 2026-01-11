/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2757.gsc
***************************************/

func_9887() {
  self.func_A444 = undefined;
  self.func_A443 = undefined;
  self.func_A442 = undefined;
  self.func_A43E = undefined;
  self.func_A447 = undefined;
  self.func_A446 = undefined;
  self.func_A43F = undefined;
}

func_E254() {
  if(!isDefined(self.func_A449)) {
    return;
  }
  self.func_A449 = undefined;
  self notify("stop_lockon_sound");
  self _meth_8403();
  self _meth_8406(0);
  self _meth_8404(0);
  self.func_4BF3 = 0;
  self.func_4BF2 = 0;
  self.func_A445 = undefined;
  self stopolcalsound("javelin_clu_lock");
  self stopolcalsound("javelin_clu_aquiring_lock");
  func_9887();
}

func_6A61() {
  var_00 = self getEye();
  var_01 = self getplayerangles();
  var_02 = anglesToForward(var_01);
  var_03 = var_00 + var_02 * 15000;
  var_04 = bulletTrace(var_00, var_03, 0, undefined);

  if(var_4["surfacetype"] == "none") {
    return undefined;
  }

  if(var_4["surfacetype"] == "default") {
    return undefined;
  }

  var_05 = var_4["entity"];

  if(isDefined(var_05)) {
    if(var_05 == level.ac130.planemodel) {
      return undefined;
    }
  }

  var_06 = [];
  var_6[0] = var_4["position"];
  var_6[1] = var_4["normal"];
  return var_06;
}

func_AF27() {
  self.func_A43E = undefined;
}

func_AF25() {
  if(!isDefined(self.func_A43E)) {
    self.func_A43E = 1;
  } else {
    self.func_A43E++;
  }
}

func_AF26() {
  var_00 = 4;

  if(isDefined(self.func_A43E) && self.func_A43E >= var_00) {
    return 1;
  }

  return 0;
}

func_11579(var_00) {
  var_01 = 1100;
  var_02 = distance(self.origin, var_00);

  if(var_02 < var_01) {
    return 1;
  }

  return 0;
}

func_B061(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var_00);
    wait(var_01);
  }
}

func_11A03(var_00, var_01) {
  var_02 = var_00 + var_01 * 10.0;
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
  self.func_A445 = undefined;
  func_9887();

  for(;;) {
    wait 0.05;
    var_07 = self getcurrentweapon();

    if(isbot(self) && var_07 != "javelin_mp" || !issubstr(var_07, "javelin") || scripts\mp\killstreaks\emp_common::isemped()) {
      if(isDefined(self.func_A449)) {
        func_E254();
      }

      continue;
    }

    if(self playerads() < 0.95) {
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

    self.func_A449 = 1;

    if(!isDefined(self.func_A444)) {
      self.func_A444 = 1;
    }

    if(self.func_A444 == 1) {
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
          var_16 = sortbydistance(var_11, self.origin);

          if(!func_13263(var_16[0])) {
            continue;
          }
          if(var_09) {}

          self.func_A445 = var_16[0];

          if(!isDefined(self.func_A43F)) {
            self.func_A43F = gettime();
          }

          self.func_A444 = 2;
          self.func_A441 = 0;
          func_A440(var_00);
          self.func_A444 = 1;
          continue;
        }
      }

      if(func_AF26()) {
        func_E254();
        continue;
      }

      var_17 = gettime() - var_06;

      if(var_17 < var_02) {
        continue;
      }
      var_17 = gettime() - var_05;

      if(var_17 < var_01) {
        continue;
      }
      var_05 = gettime();
      var_21 = func_6A61();

      if(!isDefined(var_21)) {
        func_AF25();
        continue;
      }

      if(func_11579(var_21[0])) {
        self _meth_8406(1);
        continue;
      } else
        self _meth_8406(0);

      if(isDefined(self.func_A443)) {
        var_22 = averagepoint(self.func_A443);
        var_23 = distance(var_22, var_21[0]);

        if(var_23 > var_03) {
          func_AF25();
          continue;
        }
      } else {
        self.func_A443 = [];
        self.func_A442 = [];
      }

      self.func_A443[self.func_A443.size] = var_21[0];
      self.func_A442[self.func_A442.size] = var_21[1];
      func_AF27();

      if(self.func_A443.size < var_04) {
        continue;
      }
      self.func_A447 = averagepoint(self.func_A443);
      self.func_A446 = averagenormal(self.func_A442);
      self.func_A43E = undefined;
      self.func_A443 = undefined;
      self.func_A442 = undefined;
      self.func_A43F = gettime();
      self _meth_8405(self.func_A447);
      thread func_B061("javelin_clu_aquiring_lock", 0.6);
      self.func_A444 = 2;
    }

    if(self.func_A444 == 2) {
      var_14 = self worldpointinreticle_circle(self.func_A447, 65, 45);

      if(!var_14) {
        func_E254();
        continue;
      }

      if(func_11579(self.func_A447)) {
        self _meth_8406(1);
      } else {
        self _meth_8406(0);
      }

      var_17 = gettime() - self.func_A43F;

      if(var_17 < var_00) {
        continue;
      }
      self _meth_8402(self.func_A447, (0, 0, 0), 1);
      self notify("stop_lockon_sound");
      self playlocalsound("javelin_clu_lock");
      self.func_A444 = 3;
    }

    if(self.func_A444 == 3) {
      var_14 = self worldpointinreticle_circle(self.func_A447, 65, 45);

      if(!var_14) {
        func_E254();
        continue;
      }

      if(func_11579(self.func_A447)) {
        self _meth_8406(1);
      } else {
        self _meth_8406(0);
      }

      continue;
    }
  }
}

func_4F53(var_00, var_01, var_02) {}

func_13263(var_00) {
  var_01 = self getEye();
  var_02 = var_00 getpointinbounds(0, 0, 0);
  var_03 = sighttracepassed(var_01, var_02, 0, var_00);
  func_4F53(var_01, var_02, var_03);

  if(var_03) {
    return 1;
  }

  var_04 = var_00 getpointinbounds(1, 0, 0);
  var_03 = sighttracepassed(var_01, var_04, 0, var_00);
  func_4F53(var_01, var_04, var_03);

  if(var_03) {
    return 1;
  }

  var_05 = var_00 getpointinbounds(-1, 0, 0);
  var_03 = sighttracepassed(var_01, var_05, 0, var_00);
  func_4F53(var_01, var_05, var_03);

  if(var_03) {
    return 1;
  }

  return 0;
}

func_A440(var_00) {
  if(self.func_A444 == 2) {
    self _meth_8405(self.func_A445);

    if(!func_10F9B(self.func_A445)) {
      func_E254();
      self.func_A43F = undefined;
      return;
    }

    var_01 = softsighttest();

    if(!var_01) {
      self.func_A43F = undefined;
      return;
    }

    if(!isDefined(self.func_4BF3) || !self.func_4BF3) {
      thread func_B061("javelin_clu_aquiring_lock", 0.6);
      self.func_4BF3 = 1;
    }

    var_02 = gettime() - self.func_A43F;

    if(scripts\mp\utility\game::_hasperk("specialty_fasterlockon")) {
      if(var_02 < var_00 * 0.5) {
        return;
      }
    } else if(var_02 < var_00) {
      return;
    }
    if(isplayer(self.func_A445)) {
      self _meth_8402(self.func_A445, (0, 0, 64), 0);
    } else {
      self _meth_8402(self.func_A445, (0, 0, 0), 0);
    }

    self notify("stop_lockon_sound");

    if(!isDefined(self.func_4BF2) || !self.func_4BF2) {
      self playlocalsound("javelin_clu_lock");
      self.func_4BF2 = 1;
    }

    self.func_A444 = 3;
  }

  if(self.func_A444 == 3) {
    var_01 = softsighttest();

    if(!var_01) {
      return;
    }
    if(!func_10F9B(self.func_A445)) {
      func_E254();
      return;
    }
  }
}

func_10F9B(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(!self worldpointinreticle_circle(var_0.origin, 65, 85)) {
    return 0;
  }

  return 1;
}

softsighttest() {
  var_00 = 500;

  if(func_13263(self.func_A445)) {
    self.func_A441 = 0;
    return 1;
  }

  if(self.func_A441 == 0) {
    self.func_A441 = gettime();
  }

  var_01 = gettime() - self.func_A441;

  if(var_01 >= var_00) {
    func_E254();
    return 0;
  }

  return 1;
}