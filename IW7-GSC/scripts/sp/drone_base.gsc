/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\drone_base.gsc
*************************************/

func_5C21() {
  func_23C7();
  self _meth_839E();
  if(isDefined(self.var_EE2C)) {
    self.moveplaybackrate = self.var_EE2C;
  } else {
    self.moveplaybackrate = 1;
  }

  if(self.team == "allies") {
    scripts\sp\names::func_7B05();
    self _meth_8307(self.name, & "");
  }

  if(isDefined(level.var_5CA7)) {
    self thread[[level.var_5CA7]]();
  }

  if(!isDefined(self.var_EDB7)) {
    level thread scripts\sp\friendlyfire::func_73B1(self);
  }

  if(!isDefined(level.var_193D)) {
    func_1177B();
  }
}

func_1177B() {
  if(!isDefined(level.var_5CCB)) {
    level.var_5CCB = "all";
  }

  var_00 = 0;
  switch (level.var_5CCB) {
    case "all":
      var_00 = 1;
      break;

    case "axis":
      var_00 = self.team == "axis";
      break;

    default:
      break;
  }

  if(var_00) {
    self thermaldrawenable();
  }
}

func_5C3A() {
  if(!isDefined(self.target)) {
    return;
  }

  if(isDefined(level.var_5C63[self.target])) {
    return;
  }

  level.var_5C63[self.target] = 1;
  var_00 = self.target;
  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = [];
  var_03 = [];
  var_04 = var_01;
  for(;;) {
    var_01 = var_04;
    var_05 = 0;
    for(;;) {
      if(!isDefined(var_01.target)) {
        break;
      }

      var_06 = scripts\engine\utility::getstructarray(var_01.target, "targetname");
      if(var_06.size) {
        break;
      }

      var_07 = undefined;
      foreach(var_09 in var_06) {
        if(isDefined(var_03[var_09.origin + ""])) {
          continue;
        }

        var_07 = var_09;
        break;
      }

      if(!isDefined(var_07)) {
        break;
      }

      var_03[var_07.origin + ""] = 1;
      var_02[var_01.var_336] = var_07.origin - var_01.origin;
      var_01.angles = vectortoangles(var_02[var_01.var_336]);
      var_01 = var_07;
      var_05 = 1;
    }

    if(!var_05) {
      break;
    }
  }

  var_00 = self.target;
  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");
  var_0B = var_01;
  var_03 = [];
  for(;;) {
    var_01 = var_04;
    var_05 = 0;
    for(;;) {
      if(!isDefined(var_01.target)) {
        return;
      }

      if(!isDefined(var_02[var_01.var_336])) {
        return;
      }

      var_06 = scripts\engine\utility::getstructarray(var_01.target, "targetname");
      if(var_06.size) {
        break;
      }

      var_07 = undefined;
      foreach(var_09 in var_06) {
        if(isDefined(var_03[var_09.origin + ""])) {
          continue;
        }

        var_07 = var_09;
        break;
      }

      if(!isDefined(var_07)) {
        break;
      }

      if(isDefined(var_01.fgetarg)) {
        var_0E = var_02[var_0B.var_336];
        var_0F = var_02[var_01.var_336];
        var_10 = var_0E + var_0F * 0.5;
        var_01.angles = vectortoangles(var_10);
      }

      var_05 = 1;
      var_0B = var_01;
      var_01 = var_07;
    }

    if(!var_05) {
      break;
    }
  }
}

func_23C7() {
  if(isDefined(self.type)) {
    if(self.type == "dog") {
      func_23B5();
      return;
    }

    func_23C9();
  }
}

func_23C9() {
  self glinton(#animtree);
}

func_23B5() {
  self glinton(#animtree);
}