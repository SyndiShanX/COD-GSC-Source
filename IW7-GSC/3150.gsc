/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3150.gsc
**************************************/

func_A22E(var_0, var_1, var_2, var_3) {
  self.var_4C93 = ::func_A18B;
  func_0BDC::func_A2DE(1, 0);
  var_4 = func_0A1E::func_2356("Knobs", "root");
}

func_A2AE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = func_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_82E7(var_1, var_4, 1.0, var_2, 1.0);
  func_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_A2BE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = func_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_8478(var_4, 1.0, var_2, 1.0);
  func_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_A18B(var_0, var_1, var_2) {
  switch (var_0) {
    case "undefined":
    case "finish":
    case "end":
      return var_0;
    default:
      if(isDefined(var_2)) {
        return [}
          [var_2]](var_0);

      break;
  }
}

func_10E30(var_0) {
  self endon("death");

  for(;;) {
    self waittill("spaceship_mode_switch", var_1, var_2);
    self.asm.var_D8B2 = var_1;
    self.asm.state = var_2;
  }
}

func_10E25(var_0, var_1, var_2, var_3) {}

func_A40C(var_0, var_1, var_2, var_3) {
  return self func_8498();
}

func_C17E(var_0, var_1, var_2, var_3) {
  return !self func_8498();
}

func_A410(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = func_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_82E4(var_1, var_4["base"], var_4["body"], 1.0, var_2, 1.0, var_3);
  self give_attacker_kill_rewards(level.var_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add"], 1.0, var_2, 1.0, var_3);
}

func_A411(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = func_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getanimlength(var_4["transition"]);
  self func_82E4(var_1, var_4["transition"], var_4["body"], 1.0, var_2, 1.0, var_3);
  self give_attacker_kill_rewards(level.var_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add_in"], 1.0, var_5, 1.0, var_3);
  wait(var_5);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_A3F6(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_A410(var_0, var_1, var_2, var_3);
  func_0C1A::func_A3B3("hover");
  func_0C20::func_A3B4("hover");
  func_0C18::func_A3B2("hover");
}

func_A3F7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_A410(var_0, var_1, var_2, var_3);
  func_0C1A::func_A3B3("hover");
  func_0C20::func_A3B4("hover");
  func_0C18::func_A3B2("hover");
}

func_A3AF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_A410(var_0, var_1, var_2, var_3);
  func_0C1A::func_A3B3("boost_mode");
  func_0C20::func_A3B4("boost_mode");
  func_0C18::func_A3B2("boost_mode");
}

func_A3B1(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("hover", 1);
  thread func_0C20::func_A3B7("hover", 0.5);
  func_0C18::func_A3B2("hover");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3F8(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("boost_mode", 1);
  thread func_0C20::func_A3B7("boost_mode", 0.2);
  func_0C18::func_A3B2("boost_mode");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3B0(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly", 0.5);
  func_0C18::func_A3B2("fly");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3C1(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("boost_mode", 1);
  thread func_0C20::func_A3B7("boost_mode", 0.2);
  func_0C18::func_A3B2("boost_mode");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3C0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_A410(var_0, var_1, var_2, var_3);
  func_0C1A::func_A3B3("fly");
  func_0C20::func_A3B4("fly");
  func_0C18::func_A3B2("fly");
}

func_D8EE(var_0) {
  self notify("new print");
  self endon("new print");
  var_1 = 3;

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    wait 0.05;
  }
}

func_A3C2(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("hover", 1);
  thread func_0C20::func_A3B7("hover", 0.5);
  func_0C18::func_A3B2("hover");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3F9(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly", 0.2);
  func_0C18::func_A3B2("fly");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3FA(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("launch_mode", 1);
  thread func_0C20::func_A3B7("launch_mode");
  func_0C18::func_A3B2("launch_mode");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A405(var_0, var_1, var_2, var_3) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly");
  func_0C18::func_A3B2("fly");
  func_A411(var_0, var_1, var_2, var_3);
}

func_A3FC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_0C1A::func_A3B3("launch_mode");
  func_0C20::func_A3B4("launch_mode");
  func_0C18::func_A3B2("launch_mode");
  func_A410(var_0, var_1, var_2, var_3);
}

func_3EDF(var_0, var_1, var_2) {
  var_3 = [];
  var_3["transition"] = func_0A1E::func_2356(var_1, "transition");
  var_3["add_in"] = func_0A1E::func_2356(var_1, "add_in");
  var_3["body"] = func_0A1E::func_2356("Knobs", "body");
  return var_3;
}

func_3EDE(var_0, var_1, var_2) {
  var_3 = [];
  var_3["body"] = func_0A1E::func_2356("Knobs", "body");
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

  if(lib_0BCE::func_10056()) {
    if(scripts\asm\asm::asm_hasalias(var_1, "space_" + var_4)) {
      var_4 = "space_" + var_4;
      var_5 = "space_" + var_5;
    }
  }

  var_3["base"] = func_0A1E::func_2356(var_1, var_4);
  var_3["add"] = func_0A1E::func_2356(var_1, var_5);
  return var_3;
}

func_9EAA(var_0, var_1, var_2, var_3) {
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

func_A41C(var_0, var_1, var_2, var_3) {
  if(self.var_117C == 0) {
    return func_9EAA(var_0, var_1, var_2, var_3);
  }

  return 0;
}

func_9E75(var_0, var_1, var_2, var_3) {
  return self._blackboard.var_AAB2 == 1;
}

func_9D70(var_0, var_1, var_2, var_3) {
  return self._blackboard.var_2CCD == 1;
}

func_C17C(var_0, var_1, var_2, var_3) {
  return !func_9E75(var_0, var_1, var_2, var_3);
}

func_C17B(var_0, var_1, var_2, var_3) {
  return !func_9D70(var_0, var_1, var_2, var_3);
}

func_67C5(var_0) {
  self endon("death");

  while(!isDefined(self._blackboard) || !isDefined(self._blackboard.var_1000D)) {
    wait 0.05;
  }

  for(;;) {
    if(self._blackboard.var_1000D) {
      var_1["evade"] = func_0A1E::func_2356("Fly_Evade", "Evade");
      var_2 = randomint(var_1["evade"].size - 1);
      var_3 = var_1["evade"][var_2];
      self._blackboard.var_9DE4 = 1;
      self func_82AB(var_3, 1.0, 0.0);

      if(var_2 == 0 || var_2 == 1 || var_2 == 6) {
        self playSound("jackal_evade_long");
      } else {
        self playSound("jackal_evade_short");
      }

      wait(getanimlength(var_3) * 0.8);
      self._blackboard.var_9DE4 = 0;
    }

    wait 0.05;
  }
}

func_67C6() {
  self endon("evade_debug_stop");
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

func_1EA6(var_0) {
  self endon("death");

  if(self.var_1FA8 == "jackal_enemy") {
    return;
  }
  var_1 = func_2EE(var_0, "cannon_state", "up", 0);
  var_2 = func_2EE(var_0, "cannon_state", "down", 0);
  wait 0.1;

  for(;;) {
    if(self._blackboard.animscriptedactive) {
      wait 0.05;
      continue;
    }

    if(self._blackboard.var_E1AB != self._blackboard.var_38DC) {
      self._blackboard.var_38DC = self._blackboard.var_E1AB;
      var_3 = var_2;

      if(self._blackboard.var_38DC == "up") {
        var_3 = var_1;
      }

      self give_left_powers("cannon", var_3.anims, 1.0, 0.0, 1.0);
      func_0A1E::func_231F(var_0, "cannon");
    }

    wait 0.05;
  }
}