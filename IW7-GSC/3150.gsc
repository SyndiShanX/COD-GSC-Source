/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3150.gsc
***************************************/

func_A22E(var_00, var_01, var_02, var_03) {
  self.func_4C93 = ::func_A18B;
  func_0BDC::func_A2DE(1, 0);
  var_04 = func_0A1E::func_2356("Knobs", "root");
}

func_A2AE(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  var_04 = func_0A1E::asm_getallanimsforstate(var_00, var_01);
  self _meth_82E7(var_01, var_04, 1.0, var_02, 1.0);
  func_0A1E::func_231F(var_00, var_01, scripts\asm\asm::func_2341(var_00, var_01));
}

func_A2BE(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  var_04 = func_0A1E::asm_getallanimsforstate(var_00, var_01);
  self _meth_8478(var_04, 1.0, var_02, 1.0);
  func_0A1E::func_231F(var_00, var_01, scripts\asm\asm::func_2341(var_00, var_01));
}

func_A18B(var_00, var_01, var_02) {
  switch (var_00) {
    case "undefined":
    case "finish":
    case "end":
      return var_00;
    default:
      if(isDefined(var_02)) {
        return [
          }
          [var_02]
      ](var_00);

      break;
  }
}

func_10E30(var_00) {
  self endon("death");

  for(;;) {
    self waittill("spaceship_mode_switch", var_01, var_02);
    self.asm.func_D8B2 = var_01;
    self.asm.state = var_02;
  }
}

func_10E25(var_00, var_01, var_02, var_03) {}

func_A40C(var_00, var_01, var_02, var_03) {
  return self _meth_8498();
}

func_C17E(var_00, var_01, var_02, var_03) {
  return !self _meth_8498();
}

func_A410(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon(var_01 + "_finished");
  var_04 = func_0A1E::asm_getallanimsforstate(var_00, var_01);
  self _meth_82E4(var_01, var_4["base"], var_4["body"], 1.0, var_02, 1.0, var_03);
  self give_attacker_kill_rewards(level.func_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add"], 1.0, var_02, 1.0, var_03);
}

func_A411(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon(var_01 + "_finished");
  var_04 = func_0A1E::asm_getallanimsforstate(var_00, var_01);
  var_05 = getanimlength(var_4["transition"]);
  self _meth_82E4(var_01, var_4["transition"], var_4["body"], 1.0, var_02, 1.0, var_03);
  self give_attacker_kill_rewards(level.func_A065["evasion_overlay"], 1, 0);
  self setanimknob(var_4["add_in"], 1.0, var_05, 1.0, var_03);
  wait(var_05);
  scripts\asm\asm::asm_fireevent(var_01, "end");
}

func_A3F6(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  func_A410(var_00, var_01, var_02, var_03);
  func_0C1A::func_A3B3("hover");
  func_0C20::func_A3B4("hover");
  func_0C18::func_A3B2("hover");
}

func_A3F7(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  func_A410(var_00, var_01, var_02, var_03);
  func_0C1A::func_A3B3("hover");
  func_0C20::func_A3B4("hover");
  func_0C18::func_A3B2("hover");
}

func_A3AF(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  func_A410(var_00, var_01, var_02, var_03);
  func_0C1A::func_A3B3("boost_mode");
  func_0C20::func_A3B4("boost_mode");
  func_0C18::func_A3B2("boost_mode");
}

func_A3B1(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("hover", 1);
  thread func_0C20::func_A3B7("hover", 0.5);
  func_0C18::func_A3B2("hover");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3F8(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("boost_mode", 1);
  thread func_0C20::func_A3B7("boost_mode", 0.2);
  func_0C18::func_A3B2("boost_mode");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3B0(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly", 0.5);
  func_0C18::func_A3B2("fly");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3C1(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("boost_mode", 1);
  thread func_0C20::func_A3B7("boost_mode", 0.2);
  func_0C18::func_A3B2("boost_mode");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3C0(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  func_A410(var_00, var_01, var_02, var_03);
  func_0C1A::func_A3B3("fly");
  func_0C20::func_A3B4("fly");
  func_0C18::func_A3B2("fly");
}

func_D8EE(var_00) {
  self notify("new print");
  self endon("new print");
  var_01 = 3;

  while(var_01 > 0) {
    var_01 = var_01 - 0.05;
    wait 0.05;
  }
}

func_A3C2(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("hover", 1);
  thread func_0C20::func_A3B7("hover", 0.5);
  func_0C18::func_A3B2("hover");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3F9(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly", 0.2);
  func_0C18::func_A3B2("fly");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3FA(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("launch_mode", 1);
  thread func_0C20::func_A3B7("launch_mode");
  func_0C18::func_A3B2("launch_mode");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A405(var_00, var_01, var_02, var_03) {
  func_0C1A::func_A3B6("fly", 1);
  thread func_0C20::func_A3B7("fly");
  func_0C18::func_A3B2("fly");
  func_A411(var_00, var_01, var_02, var_03);
}

func_A3FC(var_00, var_01, var_02, var_03) {
  self endon(var_01 + "_finished");
  func_0C1A::func_A3B3("launch_mode");
  func_0C20::func_A3B4("launch_mode");
  func_0C18::func_A3B2("launch_mode");
  func_A410(var_00, var_01, var_02, var_03);
}

func_3EDF(var_00, var_01, var_02) {
  var_03 = [];
  var_3["transition"] = func_0A1E::func_2356(var_01, "transition");
  var_3["add_in"] = func_0A1E::func_2356(var_01, "add_in");
  var_3["body"] = func_0A1E::func_2356("Knobs", "body");
  return var_03;
}

func_3EDE(var_00, var_01, var_02) {
  var_03 = [];
  var_3["body"] = func_0A1E::func_2356("Knobs", "body");
  var_04 = "base";
  var_05 = "add";

  if(isDefined(var_02) && isarray(var_02)) {
    switch (var_2.size) {
      case 2:
        var_05 = var_2[1];
      case 1:
        var_04 = var_2[0];
    }
  }

  if(func_0BCE::func_10056()) {
    if(scripts\asm\asm::asm_hasalias(var_01, "space_" + var_04)) {
      var_04 = "space_" + var_04;
      var_05 = "space_" + var_05;
    }
  }

  var_3["base"] = func_0A1E::func_2356(var_01, var_04);
  var_3["add"] = func_0A1E::func_2356(var_01, var_05);
  return var_03;
}

func_9EAA(var_00, var_01, var_02, var_03) {
  switch (self.spaceship_mode) {
    case "hover":
      return var_03 == "hover";
    case "fly":
      return var_03 == "fly";
    case "land":
      return var_03 == "land";
    case "none":
      return var_03 == "none";
    default:
  }
}

func_A41C(var_00, var_01, var_02, var_03) {
  if(self.func_117C == 0) {
    return func_9EAA(var_00, var_01, var_02, var_03);
  }

  return 0;
}

func_9E75(var_00, var_01, var_02, var_03) {
  return self.var_1198.func_AAB2 == 1;
}

func_9D70(var_00, var_01, var_02, var_03) {
  return self.var_1198.func_2CCD == 1;
}

func_C17C(var_00, var_01, var_02, var_03) {
  return !func_9E75(var_00, var_01, var_02, var_03);
}

func_C17B(var_00, var_01, var_02, var_03) {
  return !func_9D70(var_00, var_01, var_02, var_03);
}

func_67C5(var_00) {
  self endon("death");

  while(!isDefined(self.var_1198) || !isDefined(self.var_1198.func_1000D)) {
    wait 0.05;
  }

  for(;;) {
    if(self.var_1198.func_1000D) {
      var_1["evade"] = func_0A1E::func_2356("Fly_Evade", "Evade");
      var_02 = randomint(var_1["evade"].size - 1);
      var_03 = var_1["evade"][var_02];
      self.var_1198.func_9DE4 = 1;
      self _meth_82AB(var_03, 1.0, 0.0);

      if(var_02 == 0 || var_02 == 1 || var_02 == 6) {
        self playSound("jackal_evade_long");
      } else {
        self playSound("jackal_evade_short");
      }

      wait(getanimlength(var_03) * 0.8);
      self.var_1198.func_9DE4 = 0;
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

func_1EA6(var_00) {
  self endon("death");

  if(self.func_1FA8 == "jackal_enemy") {
    return;
  }
  var_01 = _func_2EE(var_00, "cannon_state", "up", 0);
  var_02 = _func_2EE(var_00, "cannon_state", "down", 0);
  wait 0.1;

  for(;;) {
    if(self.var_1198.animscriptedactive) {
      wait 0.05;
      continue;
    }

    if(self.var_1198.func_E1AB != self.var_1198.func_38DC) {
      self.var_1198.func_38DC = self.var_1198.func_E1AB;
      var_03 = var_02;

      if(self.var_1198.func_38DC == "up") {
        var_03 = var_01;
      }

      self give_left_powers("cannon", var_3.anims, 1.0, 0.0, 1.0);
      func_0A1E::func_231F(var_00, "cannon");
    }

    wait 0.05;
  }
}