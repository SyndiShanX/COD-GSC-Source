/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2852.gsc
***************************************/

func_5C21() {
  func_23C7();
  self _meth_839E();

  if(isDefined(self.func_EE2C)) {
    self.moveplaybackrate = self.func_EE2C;
  }
  else {
    self.moveplaybackrate = 1;
  }

  if(self.team == "allies") {
    scripts\sp\names::func_7B05();
    self _meth_8307(self.name, &"");
  }

  if(isDefined(level.func_5CA7)) {
    self thread[[level.func_5CA7]]();
  }

  if(!isDefined(self.func_EDB7)) {
    level thread scripts\sp\friendlyfire::func_73B1(self);
  }

  if(!isDefined(level.func_193D)) {
    func_1177B();
  }
}

func_1177B() {
  if(!isDefined(level.func_5CCB)) {
    level.func_5CCB = "all";
  }

  var_00 = 0;

  switch (level.func_5CCB) {
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
  if(isDefined(level.func_5C63[self.target])) {
    return;
  }
  level.func_5C63[self.target] = 1;
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
      if(!isDefined(var_1.target)) {
        break;
      }
      var_06 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }
      var_07 = undefined;

      foreach(var_09 in var_06) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_07 = var_09;
        break;
      }

      if(!isDefined(var_07)) {
        break;
      }
      var_3[var_7.origin + ""] = 1;
      var_2[var_1.targetname] = var_7.origin - var_1.origin;
      var_1.angles = vectortoangles(var_2[var_1.targetname]);
      var_01 = var_07;
      var_05 = 1;
    }

    if(!var_05) {
      break;
    }
  }

  var_00 = self.target;
  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");
  var_11 = var_01;
  var_03 = [];

  for(;;) {
    var_01 = var_04;
    var_05 = 0;

    for(;;) {
      if(!isDefined(var_1.target)) {
        return;
      }
      if(!isDefined(var_2[var_1.targetname])) {
        return;
      }
      var_06 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }
      var_07 = undefined;

      foreach(var_09 in var_06) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_07 = var_09;
        break;
      }

      if(!isDefined(var_07)) {
        break;
      }
      if(isDefined(var_1.radius)) {
        var_14 = var_2[var_11.targetname];
        var_15 = var_2[var_1.targetname];
        var_16 = (var_14 + var_15) * 0.5;
        var_1.angles = vectortoangles(var_16);
      }

      var_05 = 1;
      var_11 = var_01;
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
    }
    else {
      func_23C9();
    }
  }
}

#using_animtree("generic_human");

func_23C9() {
  self glinton(#animtree);
}

#using_animtree("animals");

func_23B5() {
  self glinton(#animtree);
}