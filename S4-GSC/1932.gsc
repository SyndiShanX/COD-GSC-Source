/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1932.gsc
*************************************************/

_id_8185(var_0) {
  thread _id_E908(var_0);
}

_id_E908(var_0) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("end_dragBreath", "death");
}

_id_E29A() {
  var_0 = spawnStruct();
  var_0._id_A456 = [];
  var_0._id_79B9 = [];
  var_0._id_2D8F = "";
  return var_0;
}

_id_D535(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(_id_8A2B(var_4)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    }
  }

  if(var_0.size == 0) {
    return;
  }
  thread _id_2D8E(var_0, var_1, var_2);
}

_id_D536() {
  var_0 = self _meth_8122();
}

_id_E909() {
  self notify("stop_dragonsbreathDamage");
  self._id_4EE0 = undefined;
}

_id_2D8E(var_0, var_1, var_2) {
  self notify("newBurningParts");
  self endon("disconnect");
  self endon("newBurningParts");
  self endon("stop_dragonsbreathDamage");
  var_0 = scripts\engine\utility::_id_1BC1(var_0);

  foreach(var_4 in var_0) {
    if(isDefined(self._id_4EE0._id_79B9[var_4])) {
      self._id_4EE0._id_79B9[var_4] = self._id_4EE0._id_79B9[var_4] + 0.5;
      self._id_4EE0._id_79B9[var_4] = min(self._id_4EE0._id_79B9[var_4], 4.0);
      continue;
    }

    self._id_4EE0._id_79B9[var_4] = 0.5;
  }

  childthread _id_D4AB(var_1, var_2);

  for(;;) {
    wait 0.2;

    if(!isalive(self) || self._id_4EE0._id_79B9.size == 0) {
      _id_E909();
    }

    var_6 = 0;

    foreach(var_9, var_8 in self._id_4EE0._id_79B9) {
      self._id_4EE0._id_79B9[var_9] = self._id_4EE0._id_79B9[var_9] - 0.2;

      if(self._id_4EE0._id_79B9[var_9] <= 0) {
        self._id_4EE0._id_79B9 = scripts\engine\utility::_id_1BC6(self._id_4EE0._id_79B9, var_9);
        var_6 = 1;
      }
    }
  }
}

_id_D4AB(var_0, var_1) {
  for(;;) {
    wait 0.25;
    var_2 = scripts\engine\math::_id_A5C5(5, 1, self._id_4EE0._id_79B9.size);
    var_3 = scripts\engine\math::_id_5898(40, 54, var_2);
    var_4 = int(var_3 * 0.25);

    if(var_1 _meth_8624("ammo_incendiary", 1) && weaponclass(var_1) != "spread") {
      var_4 = int(3.0);

      if(_func_0278(var_1) && issubstr(var_1.basename, "s4_mr_")) {
        var_4 = var_4 - 1;
      }
    }

    self dodamage(var_4, self.origin, var_0, var_0, "MOD_FIRE", var_1, "torso_upper");
  }
}

_id_D4AC() {
  var_0 = "";
  var_1 = [];
  var_1["torso"] = 0;
  var_1["legs"] = 0;

  foreach(var_5, var_3 in self._id_4EE0._id_79B9) {
    var_4 = _id_9ABC(var_5);

    if(isDefined(var_4)) {
      var_1[var_4] = var_1[var_4] + 1;
      continue;
    }
  }

  if(var_1["torso"] > 2) {
    var_0 = "torso_l_";
  } else if(var_1["torso"] > 0) {
    var_0 = "torso_s_";
  }

  if(var_1["legs"] > 2) {
    var_0 = var_0 + "legs_l";
  } else if(var_1["legs"] > 0) {
    var_0 = var_0 + "legs_s";
  }

  if(var_0 == "") {
    var_0 = "neutral";
  }

  if(var_0 != self._id_4EE0._id_2D8F) {
    if(var_0 == "neutral") {
      scripts\mp\weapons::_id_4A84(1, self._id_4EE0._id_2D8F);
    } else {
      scripts\mp\weapons::_id_523B(1, var_0);
    }

    self._id_4EE0._id_2D8F = var_0;
  }
}

_id_9ABC(var_0) {
  switch (var_0) {
    case "helmet":
      return "torso";
    case "head":
      return "torso";
    case "neck":
      return "torso";
    case "torso_upper":
      return "torso";
    case "torso_lower":
      return "torso";
    case "right_arm_upper":
      return "torso";
    case "left_arm_upper":
      return "torso";
    case "right_arm_lower":
      return "torso";
    case "left_arm_lower":
      return "torso";
    case "right_hand":
      return "torso";
    case "left_hand":
      return "torso";
    case "right_leg_upper":
      return "legs";
    case "left_leg_upper":
      return "legs";
    case "right_leg_lower":
      return "legs";
    case "left_leg_lower":
      return "legs";
    case "right_foot":
      return "legs";
    case "left_foot":
      return "legs";
  }
}

_id_880F(var_0) {
  var_1 = _func_00E7(var_0);
  var_2 = var_0 _meth_8624("ammo_incendiary", 1);
  return var_1 == "WEAPON/AMMO_DB" || var_2;
}

_id_8A2B(var_0) {
  if(var_0 == "shield") {
    return 1;
  } else {
    return 0;
  }
}