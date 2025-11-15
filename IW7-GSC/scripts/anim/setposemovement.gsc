/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\setposemovement.gsc
********************************************/

setposemovement(param_00, param_01) {
  if(param_00 == "") {
    if(self.a.pose == "prone" && param_01 == "walk" || param_01 == "run") {
      param_00 = "crouch";
    } else {
      param_00 = self.a.pose;
    }
  }

  if(!isDefined(param_01) || param_01 == "") {
    param_01 = self.a.movement;
  }

  [
    [level.setposemovementfnarray[param_00][param_01]]
  ]();
}

func_98BF() {
  level.setposemovementfnarray["stand"]["stop"] = ::func_10B7E;
  level.setposemovementfnarray["stand"]["walk"] = ::func_10B84;
  level.setposemovementfnarray["stand"]["run"] = ::func_10B76;
  level.setposemovementfnarray["crouch"]["stop"] = ::func_4AA7;
  level.setposemovementfnarray["crouch"]["walk"] = ::func_4AB1;
  level.setposemovementfnarray["crouch"]["run"] = ::func_4A9E;
  level.setposemovementfnarray["prone"]["stop"] = ::func_DA86;
  level.setposemovementfnarray["prone"]["walk"] = ::func_DA91;
  level.setposemovementfnarray["prone"]["run"] = ::func_DA84;
}

func_10B7E() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          return 0;

        case "walk":
          func_10B86();
          break;

        default:
          func_10B7D();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AAD();
          break;

        case "walk":
          func_4AB3();
          break;

        default:
          func_4AA6();
          break;
      }
      break;

    default:
      switch (self.a.movement) {
        case "stop":
          func_DA8D();
          break;

        default:
          func_DA8D();
          break;
      }
      break;
  }

  return 1;
}

func_10B84() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_2B92();
          break;

        case "walk":
          return 0;

        default:
          func_2B92();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AAF();
          break;

        case "walk":
          func_2B92();
          break;

        default:
          func_2B92();
          break;
      }
      break;

    default:
      func_DA8F();
      break;
  }

  return 1;
}

func_10B76() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "walk":
        case "stop":
          return func_2B91();

        default:
          return 0;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          return func_4AAE();

        default:
          return func_2B91();
      }
      break;

    default:
      func_DA8E();
      break;
  }

  return 1;
}

func_4AA7() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_10B7F();
          break;

        case "walk":
          func_10B85();
          break;

        case "run":
          func_10B7C();
          break;

        default:
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          break;

        case "walk":
          func_4AB2();
          break;

        case "run":
          func_4AA2();
          break;

        default:
          break;
      }
      break;

    case "prone":
      func_DA88();
      break;

    default:
      break;
  }
}

func_4AB1() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_2B90();
          break;

        case "walk":
          func_2B90();
          break;

        default:
          func_2B90();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AA9();
          break;

        case "walk":
          return 0;

        default:
          func_2B90();
          break;
      }
      break;

    default:
      func_DA8A();
      break;
  }

  return 1;
}

func_4A9E() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_2B8F();
          break;

        default:
          func_2B8F();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AA8();
          break;

        case "walk":
          func_2B8F();
          break;

        default:
          return 0;
      }
      break;

    default:
      func_DA89();
      break;
  }

  return 1;
}

func_DA86() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_10B80();
          break;

        case "walk":
          func_10B80();
          break;

        case "run":
          func_4AA3();
          break;

        default:
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AAA();
          break;

        case "walk":
          func_4AAA();
          break;

        case "run":
          func_4AA3();
          break;

        default:
          break;
      }
      break;

    case "prone":
      switch (self.a.movement) {
        case "stop":
          break;

        case "run":
        case "walk":
          func_DA80();
          break;

        default:
          break;
      }
      break;

    default:
      break;
  }
}

func_DA91() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_10B82();
          break;

        default:
          func_4AA5();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AAC();
          break;

        default:
          func_4AA5();
          break;
      }
      break;

    default:
      switch (self.a.movement) {
        case "stop":
          func_DA8C();
          break;

        default:
          self.a.movement = "walk";
          return 0;
      }
      break;
  }

  return 1;
}

func_DA84() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          func_10B81();
          break;

        default:
          func_4AA4();
          break;
      }
      break;

    case "crouch":
      switch (self.a.movement) {
        case "stop":
          func_4AAB();
          break;

        default:
          func_4AA4();
          break;
      }
      break;

    default:
      switch (self.a.movement) {
        case "stop":
          func_DA8C();
          break;

        default:
          self.a.movement = "run";
          return 0;
      }
      break;
  }

  return 1;
}

func_CEED(param_00, param_01, param_02, param_03) {
  var_04 = gettime() + param_01 * 1000;
  if(isarray(param_00)) {
    param_00 = param_00[randomint(param_00.size)];
  }

  self _meth_82E3("blendTransition", param_00, % body, 1, param_01, 1);
  scripts\anim\notetracks::donotetracksfortime(param_01 / 2, "blendTransition");
  self.a.pose = param_02;
  self.a.movement = param_03;
  var_05 = var_04 - gettime() / 1000;
  if(var_05 < 0.05) {
    var_05 = 0.05;
  }

  scripts\anim\notetracks::donotetracksfortime(var_05, "blendTransition");
}

func_D557(param_00, param_01) {
  func_D554(param_00, "stand", "walk", param_01);
}

func_10B86() {
  self.a.movement = "stop";
}

func_10B85() {
  func_10B86();
  func_10B7F();
}

func_10B7D() {
  self.a.movement = "stop";
}

func_10B7C() {
  self.a.movement = "stop";
  self.a.pose = "crouch";
}

func_CEEE(param_00) {
  var_01 = 0.3;
  if(self.a.movement != "stop") {
    self endon("movemode");
    var_01 = 1;
  }

  func_CEED(param_00, var_01, "stand", "run");
}

func_2B91() {
  if(!self.livestreamingenable) {
    self.a.movement = "run";
    self.a.pose = "stand";
    return 0;
  }

  if(isDefined(self.var_E80C)) {
    func_CEEE(self.var_E80C);
    return 1;
  }

  var_00 = 0.1;
  if(self.a.movement != "stop" && self.getcsplinepointtargetname == "none") {
    var_00 = 0.5;
  }

  if(isDefined(self.var_10AB7)) {
    self _meth_82A9(scripts\anim\utility::func_7FCC("sprint"), 1, var_00, 1);
  } else {
    self _meth_82A9(scripts\anim\run::getrunningforwardpainanim(), 1, var_00, 1);
  }

  scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"), self.var_101BB);
  thread scripts\anim\run::setcombatstandmoveanimweights("run");
  wait(0.05);
  func_CEEE( % combatrun);
  return 1;
}

func_2B92() {
  if(self.a.movement != "stop") {
    self endon("movemode");
  }

  if(!isDefined(self.alwaysrunforward) && self.a.pose != "prone") {
    scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
  }

  self.a.pose = "stand";
  self.a.movement = "walk";
}

func_4AAD() {
  var_00 = 1;
  if(isDefined(self.var_6B9F)) {
    var_00 = 1.8;
    self.var_6B9F = undefined;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return;
  }

  scripts\anim\utility::func_DCB7();
}

func_4AA9() {
  func_2B90();
}

func_4AAF() {
  func_4AA9();
  func_2B92();
}

func_4AB2() {
  self.a.movement = "stop";
}

func_4AB3() {
  func_4AB2();
  func_4AAD();
}

func_4AA2() {
  self.a.movement = "stop";
}

func_4AA6() {
  func_4AA2();
  func_4AAD();
}

func_4AA8() {
  func_2B8F();
}

func_4AAE() {
  return func_2B91();
}

func_2B8F() {
  if(isDefined(self.var_4A9F)) {
    func_CEED(self.var_4A9F, 0.6, "crouch", "run");
    return;
  }

  self setanimknob( % crouchrun, 1, 0.4, self.moveplaybackrate);
  thread scripts\anim\run::func_12ED3("crouchrun", scripts\anim\utility::func_7FCC("crouch"), scripts\anim\utility::func_7FCC("crouch_b"), scripts\anim\utility::func_7FCC("crouch_l"), scripts\anim\utility::func_7FCC("crouch_r"));
  wait(0.05);
}

func_DA89() {
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1);
  func_DA81(0.2);
  scripts\anim\cover_prone::func_12EF6(0.1);
}

func_DA8E() {
  func_DA89();
  func_2B91();
}

func_DA8A() {
  func_DA89();
  func_2B90();
}

func_2B90() {
  if(isDefined(self.var_4A9F)) {
    self _meth_82A5(self.var_4A9F, % body, 1, 0.4);
    func_CEED(self.var_4A9F, 0.6, "crouch", "walk");
    self notify("BlendIntoCrouchWalk");
    return;
  }

  self setanimknob( % crouchrun, 1, 0.4, self.moveplaybackrate);
  thread scripts\anim\run::func_12ED3("crouchrun", scripts\anim\utility::func_7FCC("crouch"), scripts\anim\utility::func_7FCC("crouch_b"), scripts\anim\utility::func_7FCC("crouch_l"), scripts\anim\utility::func_7FCC("crouch_r"));
  wait(0.05);
}

func_10B7F() {
  scripts\anim\utility::func_DCB7();
  var_00 = 1;
  if(isDefined(self.var_6B99)) {
    var_00 = 1.8;
    self.var_6B99 = undefined;
  }
}

func_DA88() {
  scripts\anim\utility::func_DCB7();
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1);
  func_DA81(0.1);
  scripts\anim\cover_prone::func_12EF6(0.1);
}

func_DA8D() {
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1);
  func_DA81(0.1);
  scripts\anim\cover_prone::func_12EF6(0.1);
}

func_DA8F() {
  func_DA88();
  func_4AA9();
  func_2B92();
}

func_DA8B(param_00) {
  func_DA81(0.1);
  scripts\anim\cover_prone::func_12EF6(0.1);
}

func_DA8C() {
  func_DA8B("run");
}

func_DA80() {
  func_DA81(0.1);
  scripts\anim\cover_prone::func_12EF6(0.1);
}

func_4AAA() {}

func_4AAC() {
  func_4AAA();
  func_DA8C();
}

func_4AAB() {
  func_4AAA();
  func_DA8C();
}

func_10B80() {}

func_10B82() {
  func_10B80();
  func_DA8C();
}

func_10B81() {
  func_10B80();
  func_DA8C();
}

func_4AA3() {}

func_4AA5() {
  func_4AA3();
  func_DA8C();
}

func_4AA4() {
  func_4AA3();
  func_DA8C();
}

func_D556(param_00, param_01, param_02, param_03, param_04) {
  self endon("killanimscript");
  self endon("entered_pose" + param_01);
  func_D555(param_00, param_01, param_02, param_03, param_04, 0);
}

func_D554(param_00, param_01, param_02, param_03, param_04) {
  func_D555(param_00, param_01, param_02, param_03, param_04, 1);
}

func_D555(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(param_05) {
    thread func_13712(getanimlength(param_00) / 2, "killtimerscript", param_01);
  }

  self _meth_82E4("transAnimDone2", param_00, % body, 1, 0.2, param_04);
  if(!isDefined(self.a.pose)) {
    self.pose = "undefined";
  }

  if(!isDefined(self.a.movement)) {
    self.movement = "undefined";
  }

  var_06 = "";
  scripts\anim\shared::donotetracks("transAnimDone2", undefined, var_06);
  self notify("killtimerscript");
  self.a.pose = param_01;
  self notify("entered_pose" + param_01);
  self.a.movement = param_02;
  if(isDefined(param_03)) {
    self _meth_82A5(param_03, % body, 1, 0.3, param_04);
  }
}

func_13712(param_00, param_01, param_02) {
  self endon("killanimscript");
  self endon("death");
  self endon(param_01);
  var_03 = self.a.pose;
  wait(param_00);
  if(var_03 != "prone" && param_02 == "prone") {
    scripts\anim\cover_prone::func_12EF6(0.1);
    scripts\anim\utility::enterpronewrapper(1);
    return;
  }

  if(var_03 == "prone" && param_02 != "prone") {
    scripts\anim\utility::exitpronewrapper(1);
    self orientmode("face default");
  }
}

func_DA81(param_00) {}