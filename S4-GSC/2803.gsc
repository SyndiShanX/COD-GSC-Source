/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2803.gsc
*************************************************/

_id_D7A5() {
  self._id_9F82 = 0;
  self._id_4B40 = 0;
  self._id_858B = 0;
  level._id_3EB8 = scripts\cp\utility::_id_459B(level._id_3EB8, 0);
}

has_head() {
  return (self._id_9F82 & 16) == 0;
}

_id_DA84(var_0) {
  return isalive(var_0) && getdvarint("#x33af927e082864840", 1) && !istrue(var_0._id_86ED) && !istrue(var_0._id_8AAE) && !istrue(var_0._id_4DA9) && !istrue(var_0._id_8873) && scripts\cp\utility::_id_459B(self._id_7598, 1);
}

_id_F707(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_DA84(self) || _func_0279(var_2)) {
    return;
  }
  var_5 = var_3 >= self.health;

  if(_id_0017::_id_8A63() && !var_5) {
    return;
  }
  var_6 = _id_96D4(var_1);
  var_7 = isDefined(var_4) && _func_010F(var_4);

  if(var_5) {
    if(should_annihilate(var_0, var_1, var_2, var_3, var_4)) {
      _id_4B3E(31, var_5, 1);
    } else if(var_7) {
      _id_4B3E(31, var_5);
    } else if(var_6 != 0 && var_6 != 1) {
      _id_4B3E(var_6, var_5);
    } else if(randomint(100) < 50) {
      _id_4B41(var_5);

      if(randomint(100) < 50) {
        _id_4B41(var_5);
      }
    }
  } else {
    var_8 = scripts\engine\utility::ter_op(self.maxhealth > 0, var_3 / self.maxhealth, 1) * 100;

    if(var_7 && var_8 >= 50 && randomint(100) < 20) {
      _id_4B3E(12, var_5);
    }

    if(var_6 == 16) {
      var_9 = scripts\engine\utility::ter_op(self.maxhealth > 0, self.health / self.maxhealth, 0) * 100;

      if(var_9 < 30 && randomint(100) < 1) {
        _id_4B3E(16, var_5);
        return;
      }
    } else {
      if(var_6 == 2 || var_6 == 0) {
        var_8 = scripts\engine\utility::ter_op(self.maxhealth > 0, var_3 / self.maxhealth, 1) * 100;

        if(var_8 > 10 && randomint(100) < 5) {
          _id_4B3E(2, var_5);
          return;
        }

        return;
      }

      if(var_6 == 4 || var_6 == 8) {
        var_8 = scripts\engine\utility::ter_op(self.maxhealth > 0, var_3 / self.maxhealth, 1) * 100;

        if(var_8 >= 50 && randomint(100) < 5) {
          _id_4B3E(var_6, var_5);
        }
      }
    }
  }
}

_id_96D4(var_0) {
  switch (var_0) {
    case "right_arm_upper":
    case "right_hand":
    case "right_arm_lower":
      return 1;
    case "left_arm_upper":
    case "left_hand":
    case "left_arm_lower":
      return 2;
    case "right_leg_lower":
    case "right_leg_upper":
    case "right_foot":
      return 4;
    case "left_leg_upper":
    case "left_foot":
    case "left_leg_lower":
      return 8;
    case "neck":
    case "helmet":
    case "head":
      return 16;
  }

  return 0;
}

_id_4B41(var_0) {
  var_1 = 31 ^ self._id_9F82;
  var_1 = var_1 &~1;

  if(var_1 > 0) {
    var_2 = randomint(_id_3D96(var_1));
    var_3 = 0;

    for(var_4 = 0; 31 >> var_4 > 0; var_4++) {
      var_5 = 1 << var_4;

      if(var_1 &var_5) {
        if(var_3 == var_2) {
          _id_4B3E(var_5, var_0);
          break;
        }

        var_3++;
      }
    }
  }
}

_id_4B3E(var_0, var_1, var_2) {
  if(!isDefined(level.dismember_time) || gettime() != level.dismember_time) {
    level.dismember_time = gettime();
    level.dismember_count = 1;
  } else {
    level.dismember_count++;

    if(level.dismember_count > 5) {
      return;
    }
  }

  var_3 = var_0;
  var_3 = var_3 &~1;
  var_3 = var_3 &~self._id_9F82;

  if(var_3 == 0) {
    return;
  }
  var_4 = self._id_9F82 | var_3;
  var_5 = _id_0907::_id_25EA(var_4);

  if(!istrue(var_1) && !isDefined(var_5) && var_3 != 16) {
    return;
  }
  self._id_9F82 = var_4;

  if(var_3 & 2) {
    _id_0BB1("torso", "left_arm_off", "left_arm_off");
  }

  var_6 = var_3 & 12;
  var_6 = var_6 && level._id_3EB8 < 8;

  if(var_6) {
    if((self._id_9F82 & 12) == 12) {
      var_7 = get_scriptabl_part_state_base("legs");

      if(var_7 == "left_leg_off") {
        _id_0BB1("legs", "both_legs_off", "both_legs_off_from_left_leg_off");
      } else if(var_7 == "right_leg_off") {
        _id_0BB1("legs", "both_legs_off", "both_legs_off_from_right_leg_off");
      } else if(var_7 == "normal") {
        _id_0BB1("legs", "both_legs_off", "both_legs_off_from_normal");
      }
    } else if(var_3 & 4)
      _id_0BB1("legs", "right_leg_off", "right_leg_off");
    else if(var_3 & 8) {
      _id_0BB1("legs", "left_leg_off", "left_leg_off");
    }
  }

  if(var_3 & 16) {
    var_8 = get_scriptabl_part_state_base("head");
    var_9 = var_8 + "_off";
    _id_0BB1("head", var_9, "detach");

    if(self _meth_8679("ai_glow")) {
      self setscriptablepartstate("ai_glow", "glow_off");
    }

    if(!istrue(var_1)) {
      thread _id_E5ED();
    }
  }

  var_10 = 0;

  if(isDefined(self._id_E393) && self._id_E393 < gettime() && !istrue(self._id_4B40)) {
    var_10 = 1;
  }

  if(istrue(var_2)) {
    if(var_10) {
      self._id_C0F7 = var_3;
    }

    var_10 = 0;
    self._id_5FF5 = 1;
    self._id_A546 = 1;
  }

  if(!istrue(var_1) && isDefined(var_5)) {
    if(!self._id_4B40 && var_3 & 12) {
      thread _id_E5C9();
    }

    if(var_10) {
      _id_0907::_id_D513(self._id_9F82, 0);
    }
  }
}

get_scriptabl_part_state_base(var_0) {
  var_1 = self _meth_8575(var_0);
  return _func_0440(var_1, "_frozen");
}

_id_3D96(var_0) {
  for(var_1 = 0; var_0 > 0; var_0 = var_0 - (var_0 & 0 - var_0)) {
    var_1++;
  }

  return var_1;
}

_id_E5C9() {
  self._id_4B40 = 1;
  self.brain_rot_immune = 1;
  thread _id_D1C4();
  level._id_3EB8++;
  self waittill("death");
  level._id_3EB8--;
}

_id_D1C4() {
  self endon("death");
  wait 0.5;
  self._id_858B = 1;
}

_id_E5ED() {
  self endon("death");
  var_0 = self.maxhealth * 0.05;

  for(;;) {
    self dodamage(var_0, self.origin, self);
    wait 1;
  }
}

_id_0BB1(var_0, var_1, var_2) {
  if(istrue(self._id_8873)) {
    var_1 = var_1 + "_frozen";
    var_2 = var_2 + "_frozen";
  }

  if(self _meth_867A(var_0, var_1)) {
    self setscriptablepartstate(var_0, var_1, 1);
  } else {}

  var_4 = var_0 + "_detach";
  self setscriptablepartstate(var_4, var_2, 1);

  if(!isDefined(self._id_4B3F)) {
    self._id_4B3F = [];
  }

  var_5 = spawnStruct();
  var_5._id_F1E8 = gettime();
  var_5._id_AE77 = var_0;
  var_5._id_E747 = var_1;
  self._id_4B3F[self._id_4B3F.size] = var_5;
}

_id_3D54(var_0) {
  if(isDefined(self._id_4B3F)) {
    var_1 = gettime();

    foreach(var_3 in self._id_4B3F) {
      if(var_3._id_F1E8 != var_1) {
        continue;
      }
      if(var_0 _meth_867A(var_3._id_AE77, var_3._id_E747)) {
        var_0 setscriptablepartstate(var_3._id_AE77, var_3._id_E747, 1);
      }
    }
  }
}

should_annihilate(var_0, var_1, var_2, var_3, var_4) {
  switch (var_2.classname) {
    case "smg":
    case "throwingknife":
    case "pistol":
      var_5 = var_0 scripts\cp\cp_weapon::_id_683D(var_2);

      if(var_5 == 1) {
        return 0;
      } else {
        break;
      }
  }

  var_6 = scripts\engine\utility::ter_op(self.maxhealth > 0, var_3 / self.maxhealth, 1) * 100;
  return var_3 > self.maxhealth && var_6 >= 50 && var_4 != "MOD_MELEE" && randomint(100) < 25;
}