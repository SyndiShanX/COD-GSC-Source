/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2852.gsc
**************************************/

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
    self _meth_8307(self.name, &"");
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

  var_0 = 0;

  switch (level.var_5CCB) {
    case "all":
      var_0 = 1;
      break;
    case "axis":
      var_0 = self.team == "axis";
      break;
    default:
      break;
  }

  if(var_0) {
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
  var_0 = self.target;
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = var_1;

  for(;;) {
    var_1 = var_4;
    var_5 = 0;

    for(;;) {
      if(!isDefined(var_1.target)) {
        break;
      }
      var_6 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }
      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7)) {
        break;
      }
      var_3[var_7.origin + ""] = 1;
      var_2[var_1.targetname] = var_7.origin - var_1.origin;
      var_1.angles = vectortoangles(var_2[var_1.targetname]);
      var_1 = var_7;
      var_5 = 1;
    }

    if(!var_5) {
      break;
    }
  }

  var_0 = self.target;
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_11 = var_1;
  var_3 = [];

  for(;;) {
    var_1 = var_4;
    var_5 = 0;

    for(;;) {
      if(!isDefined(var_1.target)) {
        return;
      }
      if(!isDefined(var_2[var_1.targetname])) {
        return;
      }
      var_6 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }
      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7)) {
        break;
      }
      if(isDefined(var_1.radius)) {
        var_14 = var_2[var_11.targetname];
        var_15 = var_2[var_1.targetname];
        var_16 = (var_14 + var_15) * 0.5;
        var_1.angles = vectortoangles(var_16);
      }

      var_5 = 1;
      var_11 = var_1;
      var_1 = var_7;
    }

    if(!var_5) {
      break;
    }
  }
}

func_23C7() {
  if(isDefined(self.type)) {
    if(self.type == "dog") {
      func_23B5();
    } else {
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