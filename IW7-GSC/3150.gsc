/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3150.gsc
**************************************/

_id_A22E(var_0, var_1, var_2, var_3) {
  self._id_4C93 = ::_id_A18B;
  _id_0BDC::_id_A2DE(1, 0);
  var_4 = _id_0A1E::_id_2356("Knobs", "root");
}

_id_A2AE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_A2BE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_8478(var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_A18B(var_0, var_1, var_2) {
  switch (var_0) {
    case "undefined":
    case "finish":
    case "end":
      return var_0;
    default:
      if(isDefined(var_2)) {
        return [[var_2]](var_0);
      }

      break;
  }
}

_id_10E30(var_0) {
  self endon("death");

  for(;;) {
    self waittill("spaceship_mode_switch", var_1, var_2);
    self.asm._id_D8B2 = var_1;
    self.asm.state = var_2;
  }
}

_id_10E25(var_0, var_1, var_2, var_3) {}

_id_A40C(var_0, var_1, var_2, var_3) {
  return self _meth_8498();
}

_id_C17E(var_0, var_1, var_2, var_3) {
  return !self _meth_8498();
}

_id_A410(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_82E4(var_1, var_4["base"], var_4["body"], 1.0, var_2, 1.0, var_3);
  self _meth_82A2(level._id_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add"], 1.0, var_2, 1.0, var_3);
}

_id_A411(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getanimlength(var_4["transition"]);
  self _meth_82E4(var_1, var_4["transition"], var_4["body"], 1.0, var_2, 1.0, var_3);
  self _meth_82A2(level._id_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add_in"], 1.0, var_5, 1.0, var_3);
  wait(var_5);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_A3F6(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_A410(var_0, var_1, var_2, var_3);
  _id_0C1A::_id_A3B3("hover");
  _id_0C20::_id_A3B4("hover");
  _id_0C18::_id_A3B2("hover");
}

_id_A3F7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_A410(var_0, var_1, var_2, var_3);
  _id_0C1A::_id_A3B3("hover");
  _id_0C20::_id_A3B4("hover");
  _id_0C18::_id_A3B2("hover");
}

_id_A3AF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_A410(var_0, var_1, var_2, var_3);
  _id_0C1A::_id_A3B3("boost_mode");
  _id_0C20::_id_A3B4("boost_mode");
  _id_0C18::_id_A3B2("boost_mode");
}

_id_A3B1(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("hover", 1);
  thread _id_0C20::_id_A3B7("hover", 0.5);
  _id_0C18::_id_A3B2("hover");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3F8(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("boost_mode", 1);
  thread _id_0C20::_id_A3B7("boost_mode", 0.2);
  _id_0C18::_id_A3B2("boost_mode");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3B0(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("fly", 1);
  thread _id_0C20::_id_A3B7("fly", 0.5);
  _id_0C18::_id_A3B2("fly");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3C1(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("boost_mode", 1);
  thread _id_0C20::_id_A3B7("boost_mode", 0.2);
  _id_0C18::_id_A3B2("boost_mode");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3C0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_A410(var_0, var_1, var_2, var_3);
  _id_0C1A::_id_A3B3("fly");
  _id_0C20::_id_A3B4("fly");
  _id_0C18::_id_A3B2("fly");
}

_id_D8EE(var_0) {
  self notify("new print");
  self endon("new print");
  var_1 = 3;

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    wait 0.05;
  }
}

_id_A3C2(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("hover", 1);
  thread _id_0C20::_id_A3B7("hover", 0.5);
  _id_0C18::_id_A3B2("hover");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3F9(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("fly", 1);
  thread _id_0C20::_id_A3B7("fly", 0.2);
  _id_0C18::_id_A3B2("fly");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3FA(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("launch_mode", 1);
  thread _id_0C20::_id_A3B7("launch_mode");
  _id_0C18::_id_A3B2("launch_mode");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A405(var_0, var_1, var_2, var_3) {
  _id_0C1A::_id_A3B6("fly", 1);
  thread _id_0C20::_id_A3B7("fly");
  _id_0C18::_id_A3B2("fly");
  _id_A411(var_0, var_1, var_2, var_3);
}

_id_A3FC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_0C1A::_id_A3B3("launch_mode");
  _id_0C20::_id_A3B4("launch_mode");
  _id_0C18::_id_A3B2("launch_mode");
  _id_A410(var_0, var_1, var_2, var_3);
}

_id_3EDF(var_0, var_1, var_2) {
  var_3 = [];
  var_3["transition"] = _id_0A1E::_id_2356(var_1, "transition");
  var_3["add_in"] = _id_0A1E::_id_2356(var_1, "add_in");
  var_3["body"] = _id_0A1E::_id_2356("Knobs", "body");
  return var_3;
}

_id_3EDE(var_0, var_1, var_2) {
  var_3 = [];
  var_3["body"] = _id_0A1E::_id_2356("Knobs", "body");
  var_4 = "base";
  var_5 = "add";

  if(isDefined(var_2) && isarray(var_2)) {
    switch (var_2.size) {
      case 2:
        var_5 = var_2[1];
      case 1:
        var_4 = var_2[0];
    }
  }

  if(_id_0BCE::_id_10056()) {
    if(scripts\asm\asm::asm_hasalias(var_1, "space_" + var_4)) {
      var_4 = "space_" + var_4;
      var_5 = "space_" + var_5;
    }
  }

  var_3["base"] = _id_0A1E::_id_2356(var_1, var_4);
  var_3["add"] = _id_0A1E::_id_2356(var_1, var_5);
  return var_3;
}

_id_9EAA(var_0, var_1, var_2, var_3) {
  switch (self.spaceship_mode) {
    case "hover":
      return var_3 == "hover";
    case "fly":
      return var_3 == "fly";
    case "land":
      return var_3 == "land";
    case "none":
      return var_3 == "none";
    default:
  }
}

_id_A41C(var_0, var_1, var_2, var_3) {
  if(self._id_117C == 0) {
    return _id_9EAA(var_0, var_1, var_2, var_3);
  }

  return 0;
}

_id_9E75(var_0, var_1, var_2, var_3) {
  return self._blackboard._id_AAB2 == 1;
}

_id_9D70(var_0, var_1, var_2, var_3) {
  return self._blackboard._id_2CCD == 1;
}

_id_C17C(var_0, var_1, var_2, var_3) {
  return !_id_9E75(var_0, var_1, var_2, var_3);
}

_id_C17B(var_0, var_1, var_2, var_3) {
  return !_id_9D70(var_0, var_1, var_2, var_3);
}

_id_67C5(var_0) {
  self endon("death");

  while(!isDefined(self._blackboard) || !isDefined(self._blackboard._id_1000D)) {
    wait 0.05;
  }

  for(;;) {
    if(self._blackboard._id_1000D) {
      var_1["evade"] = _id_0A1E::_id_2356("Fly_Evade", "Evade");
      var_2 = randomint(var_1["evade"].size - 1);
      var_3 = var_1["evade"][var_2];
      self._blackboard._id_9DE4 = 1;
      self _meth_82AB(var_3, 1.0, 0.0);

      if(var_2 == 0 || var_2 == 1 || var_2 == 6) {
        self playSound("jackal_evade_long");
      } else {
        self playSound("jackal_evade_short");
      }

      wait(getanimlength(var_3) * 0.8);
      self._blackboard._id_9DE4 = 0;
    }

    wait 0.05;
  }
}

_id_67C6() {
  self endon("evade_debug_stop");
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_1EA6(var_0) {
  self endon("death");

  if(self._id_1FA8 == "jackal_enemy") {
    return;
  }
  var_1 = _func_2EE(var_0, "cannon_state", "up", 0);
  var_2 = _func_2EE(var_0, "cannon_state", "down", 0);
  wait 0.1;

  for(;;) {
    if(self._blackboard.animscriptedactive) {
      wait 0.05;
      continue;
    }

    if(self._blackboard._id_E1AB != self._blackboard._id_38DC) {
      self._blackboard._id_38DC = self._blackboard._id_E1AB;
      var_3 = var_2;

      if(self._blackboard._id_38DC == "up") {
        var_3 = var_1;
      }

      self _meth_82E2("cannon", var_3.anims, 1.0, 0.0, 1.0);
      _id_0A1E::_id_231F(var_0, "cannon");
    }

    wait 0.05;
  }
}