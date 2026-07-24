/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\setposemovement.gsc
********************************************/

setposemovement(var_0, var_1) {
  if(var_0 == "") {
    if(self.a.pose == "prone" && (var_1 == "walk" || var_1 == "run")) {
      var_0 = "crouch";
    } else {
      var_0 = self.a.pose;
    }
  }

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = self.a.movement;
  }

  [[anim.setposemovementfnarray[var_0][var_1]]]();
}

_id_98BF() {
  anim.setposemovementfnarray["stand"]["stop"] = ::_id_10B7E;
  anim.setposemovementfnarray["stand"]["walk"] = ::_id_10B84;
  anim.setposemovementfnarray["stand"]["run"] = ::_id_10B76;
  anim.setposemovementfnarray["crouch"]["stop"] = ::_id_4AA7;
  anim.setposemovementfnarray["crouch"]["walk"] = ::_id_4AB1;
  anim.setposemovementfnarray["crouch"]["run"] = ::_id_4A9E;
  anim.setposemovementfnarray["prone"]["stop"] = ::_id_DA86;
  anim.setposemovementfnarray["prone"]["walk"] = ::_id_DA91;
  anim.setposemovementfnarray["prone"]["run"] = ::_id_DA84;
}

_id_10B7E() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          return 0;
        case "walk":
          _id_10B86();
          break;
        default:
          _id_10B7D();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AAD();
          break;
        case "walk":
          _id_4AB3();
          break;
        default:
          _id_4AA6();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          _id_DA8D();
          break;
        default:
          _id_DA8D();
          break;
      }

      break;
  }

  return 1;
}

_id_10B84() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_2B92();
          break;
        case "walk":
          return 0;
        default:
          _id_2B92();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AAF();
          break;
        case "walk":
          _id_2B92();
          break;
        default:
          _id_2B92();
          break;
      }

      break;
    default:
      _id_DA8F();
      break;
  }

  return 1;
}

_id_10B76() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "walk":
        case "stop":
          return _id_2B91();
        default:
          return 0;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          return _id_4AAE();
        default:
          return _id_2B91();
      }

      break;
    default:
      _id_DA8E();
      break;
  }

  return 1;
}

_id_4AA7() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_10B7F();
          break;
        case "walk":
          _id_10B85();
          break;
        case "run":
          _id_10B7C();
          break;
        default:
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          break;
        case "walk":
          _id_4AB2();
          break;
        case "run":
          _id_4AA2();
          break;
        default:
      }

      break;
    case "prone":
      _id_DA88();
      break;
    default:
  }
}

_id_4AB1() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_2B90();
          break;
        case "walk":
          _id_2B90();
          break;
        default:
          _id_2B90();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AA9();
          break;
        case "walk":
          return 0;
        default:
          _id_2B90();
          break;
      }

      break;
    default:
      _id_DA8A();
      break;
  }

  return 1;
}

_id_4A9E() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_2B8F();
          break;
        default:
          _id_2B8F();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AA8();
          break;
        case "walk":
          _id_2B8F();
          break;
        default:
          return 0;
      }

      break;
    default:
      _id_DA89();
      break;
  }

  return 1;
}

_id_DA86() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_10B80();
          break;
        case "walk":
          _id_10B80();
          break;
        case "run":
          _id_4AA3();
          break;
        default:
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AAA();
          break;
        case "walk":
          _id_4AAA();
          break;
        case "run":
          _id_4AA3();
          break;
        default:
      }

      break;
    case "prone":
      switch (self.a.movement) {
        case "stop":
          break;
        case "run":
        case "walk":
          _id_DA80();
          break;
        default:
      }

      break;
    default:
  }
}

_id_DA91() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_10B82();
          break;
        default:
          _id_4AA5();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AAC();
          break;
        default:
          _id_4AA5();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          _id_DA8C();
          break;
        default:
          self.a.movement = "walk";
          return 0;
      }

      break;
  }

  return 1;
}

_id_DA84() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          _id_10B81();
          break;
        default:
          _id_4AA4();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          _id_4AAB();
          break;
        default:
          _id_4AA4();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          _id_DA8C();
          break;
        default:
          self.a.movement = "run";
          return 0;
      }

      break;
  }

  return 1;
}

#using_animtree("generic_human");

_id_CEED(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_1 * 1000;

  if(isarray(var_0)) {
    var_0 = var_0[randomint(var_0.size)];
  }

  self _meth_82E3("blendTransition", var_0, %body, 1, var_1, 1);
  scripts\anim\notetracks::donotetracksfortime(var_1 / 2, "blendTransition");
  self.a.pose = var_2;
  self.a.movement = var_3;
  var_5 = (var_4 - gettime()) / 1000;

  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  scripts\anim\notetracks::donotetracksfortime(var_5, "blendTransition");
}

_id_D557(var_0, var_1) {
  _id_D554(var_0, "stand", "walk", var_1);
}

_id_10B86() {
  self.a.movement = "stop";
}

_id_10B85() {
  _id_10B86();
  _id_10B7F();
}

_id_10B7D() {
  self.a.movement = "stop";
}

_id_10B7C() {
  self.a.movement = "stop";
  self.a.pose = "crouch";
}

_id_CEEE(var_0) {
  var_1 = 0.3;

  if(self.a.movement != "stop") {
    self endon("movemode");
    var_1 = 1.0;
  }

  _id_CEED(var_0, var_1, "stand", "run");
}

_id_2B91() {
  if(!self.facemotion) {
    self.a.movement = "run";
    self.a.pose = "stand";
    return 0;
  }

  if(isDefined(self._id_E80C)) {
    _id_CEEE(self._id_E80C);
    return 1;
  }

  var_0 = 0.1;

  if(self.a.movement != "stop" && self.stairsstate == "none") {
    var_0 = 0.5;
  }

  if(isDefined(self._id_10AB7)) {
    self _meth_82A9(scripts\anim\utility::_id_7FCC("sprint"), 1, var_0, 1);
  } else {
    self _meth_82A9(scripts\anim\run::getrunningforwardpainanim(), 1, var_0, 1);
  }

  scripts\anim\run::_id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"), self._id_101BB);
  thread scripts\anim\run::setcombatstandmoveanimweights("run");
  wait 0.05;
  _id_CEEE(%combatrun);
  return 1;
}

_id_2B92() {
  if(self.a.movement != "stop") {
    self endon("movemode");
  }

  if(!isDefined(self.alwaysrunforward) && self.a.pose != "prone") {
    scripts\anim\run::_id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
  }

  self.a.pose = "stand";
  self.a.movement = "walk";
}

_id_4AAD() {
  var_0 = 1;

  if(isDefined(self._id_6B9F)) {
    var_0 = 1.8;
    self._id_6B9F = undefined;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return;
  }
  scripts\anim\utility::_id_DCB7();
  return;
}

_id_4AA9() {
  _id_2B90();
}

_id_4AAF() {
  _id_4AA9();
  _id_2B92();
}

_id_4AB2() {
  self.a.movement = "stop";
}

_id_4AB3() {
  _id_4AB2();
  _id_4AAD();
}

_id_4AA2() {
  self.a.movement = "stop";
}

_id_4AA6() {
  _id_4AA2();
  _id_4AAD();
}

_id_4AA8() {
  _id_2B8F();
}

_id_4AAE() {
  return _id_2B91();
}

_id_2B8F() {
  if(isDefined(self._id_4A9F)) {
    _id_CEED(self._id_4A9F, 0.6, "crouch", "run");
  } else {
    self setanimknob(%crouchrun, 1, 0.4, self.moveplaybackrate);
    thread scripts\anim\run::_id_12ED3("crouchrun", scripts\anim\utility::_id_7FCC("crouch"), scripts\anim\utility::_id_7FCC("crouch_b"), scripts\anim\utility::_id_7FCC("crouch_l"), scripts\anim\utility::_id_7FCC("crouch_r"));
    wait 0.05;
  }
}

_id_DA89() {
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1.0);
  _id_DA81(0.2);
  scripts\anim\cover_prone::_id_12EF6(0.1);
}

_id_DA8E() {
  _id_DA89();
  _id_2B91();
}

_id_DA8A() {
  _id_DA89();
  _id_2B90();
}

_id_2B90() {
  if(isDefined(self._id_4A9F)) {
    self _meth_82A5(self._id_4A9F, %body, 1, 0.4);
    _id_CEED(self._id_4A9F, 0.6, "crouch", "walk");
    self notify("BlendIntoCrouchWalk");
  } else {
    self setanimknob(%crouchrun, 1, 0.4, self.moveplaybackrate);
    thread scripts\anim\run::_id_12ED3("crouchrun", scripts\anim\utility::_id_7FCC("crouch"), scripts\anim\utility::_id_7FCC("crouch_b"), scripts\anim\utility::_id_7FCC("crouch_l"), scripts\anim\utility::_id_7FCC("crouch_r"));
    wait 0.05;
  }
}

_id_10B7F() {
  scripts\anim\utility::_id_DCB7();
  var_0 = 1;

  if(isDefined(self._id_6B99)) {
    var_0 = 1.8;
    self._id_6B99 = undefined;
  }
}

_id_DA88() {
  scripts\anim\utility::_id_DCB7();
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1.0);
  _id_DA81(0.1);
  scripts\anim\cover_prone::_id_12EF6(0.1);
}

_id_DA8D() {
  self orientmode("face current");
  scripts\anim\utility::exitpronewrapper(1.0);
  _id_DA81(0.1);
  scripts\anim\cover_prone::_id_12EF6(0.1);
}

_id_DA8F() {
  _id_DA88();
  _id_4AA9();
  _id_2B92();
}

_id_DA8B(var_0) {
  _id_DA81(0.1);
  scripts\anim\cover_prone::_id_12EF6(0.1);
}

_id_DA8C() {
  _id_DA8B("run");
}

_id_DA80() {
  _id_DA81(0.1);
  scripts\anim\cover_prone::_id_12EF6(0.1);
}

_id_4AAA() {}

_id_4AAC() {
  _id_4AAA();
  _id_DA8C();
}

_id_4AAB() {
  _id_4AAA();
  _id_DA8C();
}

_id_10B80() {}

_id_10B82() {
  _id_10B80();
  _id_DA8C();
}

_id_10B81() {
  _id_10B80();
  _id_DA8C();
}

_id_4AA3() {}

_id_4AA5() {
  _id_4AA3();
  _id_DA8C();
}

_id_4AA4() {
  _id_4AA3();
  _id_DA8C();
}

_id_D556(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("entered_pose" + var_1);
  _id_D555(var_0, var_1, var_2, var_3, var_4, 0);
}

_id_D554(var_0, var_1, var_2, var_3, var_4) {
  _id_D555(var_0, var_1, var_2, var_3, var_4, 1);
}

_id_D555(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(var_5) {
    thread _id_13712(getanimlength(var_0) / 2.0, "killtimerscript", var_1);
  }

  self _meth_82E4("transAnimDone2", var_0, %body, 1, 0.2, var_4);

  if(!isDefined(self.a.pose)) {
    self.pose = "undefined";
  }

  if(!isDefined(self.a.movement)) {
    self.movement = "undefined";
  }

  var_6 = "";
  scripts\anim\shared::donotetracks("transAnimDone2", undefined, var_6);
  self notify("killtimerscript");
  self.a.pose = var_1;
  self notify("entered_pose" + var_1);
  self.a.movement = var_2;

  if(isDefined(var_3)) {
    self _meth_82A5(var_3, %body, 1, 0.3, var_4);
  }
}

_id_13712(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon(var_1);
  var_3 = self.a.pose;
  wait(var_0);

  if(var_3 != "prone" && var_2 == "prone") {
    scripts\anim\cover_prone::_id_12EF6(0.1);
    scripts\anim\utility::enterpronewrapper(1.0);
  } else if(var_3 == "prone" && var_2 != "prone") {
    scripts\anim\utility::exitpronewrapper(1.0);
    self orientmode("face default");
  }
}

_id_DA81(var_0) {}