/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2852.gsc
**************************************/

_id_5C21() {
  _id_23C7();
  self _meth_839E();

  if(isDefined(self._id_EE2C)) {
    self.moveplaybackrate = self._id_EE2C;
  } else {
    self.moveplaybackrate = 1;
  }

  if(self.team == "allies") {
    scripts\sp\names::_id_7B05();
    self _meth_8307(self.name, &"");
  }

  if(isDefined(level._id_5CA7)) {
    self thread[[level._id_5CA7]]();
  }

  if(!isDefined(self._id_EDB7)) {
    level thread scripts\sp\friendlyfire::_id_73B1(self);
  }

  if(!isDefined(level._id_193D)) {
    _id_1177B();
  }
}

_id_1177B() {
  if(!isDefined(level._id_5CCB)) {
    level._id_5CCB = "all";
  }

  var_0 = 0;

  switch (level._id_5CCB) {
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

_id_5C3A() {
  if(!isDefined(self.target)) {
    return;
  }
  if(isDefined(level._id_5C63[self.target])) {
    return;
  }
  level._id_5C63[self.target] = 1;
  var_0 = self.target;
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

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

      var_6 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

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
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
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
      var_6 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

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

_id_23C7() {
  if(isDefined(self.type)) {
    if(self.type == "dog") {
      _id_23B5();
    } else {
      _id_23C9();
    }
  }
}

#using_animtree("generic_human");

_id_23C9() {
  self _meth_83D0(#animtree);
}

#using_animtree("animals");

_id_23B5() {
  self _meth_83D0(#animtree);
}