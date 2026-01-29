/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\setposemovement.gsc
*******************************************/

_id_10F1(var_0, var_1) {
  if(var_0 == "") {
    if(self.a._id_0D26 == "prone" && (var_1 == "walk" || var_1 == "run")) {
      var_0 = "crouch";
    } else {
      var_0 = self.a._id_0D26;
    }
  }

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = self.a._id_0D2B;

  }
  [[anim._id_240E[var_0][var_1]]]();
}

_id_20D9() {
  anim._id_240E["stand"]["stop"] = ::_id_240F;
  anim._id_240E["stand"]["walk"] = ::_id_1080;
  anim._id_240E["stand"]["run"] = ::_id_0FBB;
  anim._id_240E["crouch"]["stop"] = ::_id_2410;
  anim._id_240E["crouch"]["walk"] = ::_id_1083;
  anim._id_240E["crouch"]["run"] = ::_id_0FBF;
  anim._id_240E["prone"]["stop"] = ::_id_2411;
  anim._id_240E["prone"]["walk"] = ::_id_1084;
  anim._id_240E["prone"]["run"] = ::_id_0FC1;
}

_id_240F() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          return 0;
        case "walk":
          _id_2414();
          break;
        default:
          _id_2416();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_241C();
          break;
        case "walk":
          _id_2421();
          break;
        default:
          _id_2423();
          break;
      }

      break;
    default:
      switch (self.a._id_0D2B) {
        case "stop":
          _id_242E();
          break;
        default:
          _id_242E();
          break;
      }

      break;
  }

  return 1;
}

_id_1080() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_241A();
          break;
        case "walk":
          return 0;
        default:
          _id_241A();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_241F();
          break;
        case "walk":
          _id_241A();
          break;
        default:
          _id_241A();
          break;
      }

      break;
    default:
      _id_242F();
      break;
  }

  return 1;
}

_id_0FBB() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "walk":
        case "stop":
          return _id_2419();
        default:
          return 0;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          return _id_2425();
        default:
          return _id_2419();
      }

      break;
    default:
      _id_2428();
      break;
  }

  return 1;
}

_id_2410() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_242B();
          break;
        case "walk":
          _id_2415();
          break;
        case "run":
          _id_2417();
          break;
        default:
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          break;
        case "walk":
          _id_2420();
          break;
        case "run":
          _id_2422();
          break;
        default:
      }

      break;
    case "prone":
      _id_242D();
      break;
    default:
  }
}

_id_1083() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_242A();
          break;
        case "walk":
          _id_242A();
          break;
        default:
          _id_242A();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_241E();
          break;
        case "walk":
          return 0;
        default:
          _id_242A();
          break;
      }

      break;
    default:
      _id_2429();
      break;
  }

  return 1;
}

_id_0FBF() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2426();
          break;
        default:
          _id_2426();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2424();
          break;
        case "walk":
          _id_2426();
          break;
        default:
          return 0;
      }

      break;
    default:
      _id_2427();
      break;
  }

  return 1;
}

_id_2411() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2436();
          break;
        case "walk":
          _id_2436();
          break;
        case "run":
          _id_2439();
          break;
        default:
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2433();
          break;
        case "walk":
          _id_2433();
          break;
        case "run":
          _id_2439();
          break;
        default:
      }

      break;
    case "prone":
      switch (self.a._id_0D2B) {
        case "stop":
          break;
        case "walk":
        case "run":
          _id_2432();
          break;
        default:
      }

      break;
    default:
  }
}

_id_1084() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2437();
          break;
        default:
          _id_243B();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2434();
          break;
        default:
          _id_243B();
          break;
      }

      break;
    default:
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2431();
          break;
        default:
          self.a._id_0D2B = "walk";
          return 0;
      }

      break;
  }

  return 1;
}

_id_0FC1() {
  switch (self.a._id_0D26) {
    case "stand":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2438();
          break;
        default:
          _id_243C();
          break;
      }

      break;
    case "crouch":
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2435();
          break;
        default:
          _id_243C();
          break;
      }

      break;
    default:
      switch (self.a._id_0D2B) {
        case "stop":
          _id_2431();
          break;
        default:
          self.a._id_0D2B = "run";
          return 0;
      }

      break;
  }

  return 1;
}

#using_animtree("generic_human");

_id_2412(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_1 * 1000;

  if(isarray(var_0)) {
    var_0 = var_0[randomint(var_0.size)];

  }
  self setflaggedanimknoball("blendTransition", var_0, % body, 1, var_1, 1);
  animscripts\notetracks::_id_0D4F(var_1 / 2, "blendTransition");
  self.a._id_0D26 = var_2;
  self.a._id_0D2B = var_3;
  var_5 = (var_4 - gettime()) / 1000;

  if(var_5 < 0.05) {
    var_5 = 0.05;

  }
  animscripts\notetracks::_id_0D4F(var_5, "blendTransition");
}

_id_2413(var_0, var_1) {
  _id_243E(var_0, "stand", "walk", var_1);
}

_id_2414() {
  self.a._id_0D2B = "stop";
}

_id_2415() {
  _id_2414();
  _id_242B();
}

_id_2416() {
  self.a._id_0D2B = "stop";
}

_id_2417() {
  self.a._id_0D2B = "stop";
  self.a._id_0D26 = "crouch";
}

_id_2418(var_0) {
  var_1 = 0.3;

  if(self.a._id_0D2B != "stop") {
    self endon("movemode");
    var_1 = 1.0;
  }

  _id_2412(var_0, var_1, "stand", "run");
}

_id_2419() {
  if(!self.facemotion) {
    self.a._id_0D2B = "run";
    self.a._id_0D26 = "stand";
    return 0;
  }

  if(isDefined(self._id_0FBC)) {
    _id_2418(self._id_0FBC);
    return 1;
  }

  var_0 = 0.1;

  if(self.a._id_0D2B != "stop" && self.stairsstate == "none") {
    var_0 = 0.5;

  }
  if(isDefined(self._id_0FD7)) {
    self setanimknoblimited(animscripts\utility::_id_0FC3("sprint"), 1, var_0, 1);
  } else {
    self setanimknoblimited(animscripts\run::_id_0FC2(), 1, var_0, 1);

  }
  animscripts\run::_id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"), self._id_0FE0);
  thread animscripts\run::_id_0FF8("run");
  wait 0.05;
  _id_2418( % combatrun);
  return 1;
}

_id_241A() {
  if(self.a._id_0D2B != "stop") {
    self endon("movemode");

  }
  if(!isDefined(self._id_241B) && self.a._id_0D26 != "prone") {
    animscripts\run::_id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));

  }
  self.a._id_0D26 = "stand";
  self.a._id_0D2B = "walk";
}

_id_241C() {
  var_0 = 1;

  if(isDefined(self._id_241D)) {
    var_0 = 1.8;
    self._id_241D = undefined;
  }

  if(animscripts\utility::_id_0C95()) {
    _id_243E( % pistol_crouchaimstraight2stand, "stand", "stop", undefined, var_0);
  } else {
    animscripts\utility::_id_10F0();
    _id_243E( % crouch2stand, "stand", "stop", undefined, var_0);
  }
}

_id_241E() {
  _id_242A();
}

_id_241F() {
  _id_241E();
  _id_241A();
}

_id_2420() {
  self.a._id_0D2B = "stop";
}

_id_2421() {
  _id_2420();
  _id_241C();
}

_id_2422() {
  self.a._id_0D2B = "stop";
}

_id_2423() {
  _id_2422();
  _id_241C();
}

_id_2424() {
  _id_2426();
}

_id_2425() {
  return _id_2419();
}

_id_2426() {
  if(isDefined(self._id_0FC0)) {
    _id_2412(self._id_0FC0, 0.6, "crouch", "run");
  } else {
    self setanimknob( % crouchrun, 1, 0.4, self._id_0FC6);
    thread animscripts\run::_id_0FF9("crouchrun", animscripts\utility::_id_0FC3("crouch"), animscripts\utility::_id_0FC3("crouch_b"), animscripts\utility::_id_0FC3("crouch_l"), animscripts\utility::_id_0FC3("crouch_r"));
    wait 0.05;
    _id_2412( % crouchrun, 0.4, "crouch", "run");
  }
}

_id_2427() {
  self orientmode("face current");
  animscripts\utility::_id_0F7D(1.0);
  _id_2441(0.2);
  animscripts\cover_prone::_id_10E2(0.1);
  _id_243E( % prone_2_crouch, "crouch", "run", animscripts\run::_id_0FC4());
}

_id_2428() {
  _id_2427();
  _id_2419();
}

_id_2429() {
  _id_2427();
  _id_242A();
}

_id_242A() {
  if(isDefined(self._id_0FC0)) {
    self setanimknoball(self._id_0FC0, % body, 1, 0.4);
    _id_2412(self._id_0FC0, 0.6, "crouch", "walk");
    self notify("BlendIntoCrouchWalk");
  } else {
    self setanimknob( % crouchrun, 1, 0.4, self._id_0FC6);
    thread animscripts\run::_id_0FF9("crouchrun", animscripts\utility::_id_0FC3("crouch"), animscripts\utility::_id_0FC3("crouch_b"), animscripts\utility::_id_0FC3("crouch_l"), animscripts\utility::_id_0FC3("crouch_r"));
    wait 0.05;
    _id_2412( % crouchrun, 0.4, "crouch", "run");
  }
}

_id_242B() {
  animscripts\utility::_id_10F0();
  var_0 = 1;

  if(isDefined(self._id_242C)) {
    var_0 = 1.8;
    self._id_242C = undefined;
  }

  _id_243E( % exposed_stand_2_crouch, "crouch", "stop", undefined, var_0);
}

_id_242D() {
  animscripts\utility::_id_10F0();
  self orientmode("face current");
  animscripts\utility::_id_0F7D(1.0);
  _id_2441(0.1);
  animscripts\cover_prone::_id_10E2(0.1);
  _id_243E( % prone_2_crouch, "crouch", "stop");
}

_id_242E() {
  self orientmode("face current");
  animscripts\utility::_id_0F7D(1.0);
  _id_2441(0.1);
  animscripts\cover_prone::_id_10E2(0.1);
  _id_243E( % prone_2_stand, "stand", "stop");
}

_id_242F() {
  _id_242D();
  _id_241E();
  _id_241A();
}

_id_2430(var_0) {
  _id_2441(0.1);
  _id_243E( % prone_2_prone_crawl, "prone", var_0, % prone_crawl);
  animscripts\cover_prone::_id_10E2(0.1);
}

_id_2431() {
  _id_2430("run");
}

_id_2432() {
  _id_2441(0.1);
  animscripts\cover_prone::_id_10E2(0.1);
  _id_243E( % prone_crawl_2_prone, "prone", "stop");
}

_id_2433() {
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(1.0);
  _id_2441(0.3);
  animscripts\cover_prone::_id_10E2(0.1);
  _id_243E( % crouch_2_prone, "prone", "stop");
}

_id_2434() {
  _id_2433();
  _id_2431();
}

_id_2435() {
  _id_2433();
  _id_2431();
}

_id_2436() {
  self endon("entered_poseprone");
  var_0 = 0.5;
  thread _id_243D( % stand_2_prone, "prone", "stop", undefined, var_0);
  self waittillmatch("transAnimDone2", "anim_pose = \"crouch\"");
  waittillframeend;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(var_0);
  self.a._id_0D2B = "stop";
  _id_2441(0.2);
  animscripts\cover_prone::_id_10E2(0.1);
  self waittillmatch("transAnimDone2", "end");
}

_id_2437() {
  _id_2436();
  _id_2431();
}

_id_2438() {
  _id_2436();
  _id_2431();
}

_id_2439() {
  var_0 = 0.5;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(var_0);
  _id_2441(0.2);
  animscripts\cover_prone::_id_10E2(0.1);
  var_1 = animscripts\utility::_id_243A(self getmotionangle());
  var_2 = % crouch_2_prone;
  var_3 = getmovedelta(var_2, 0, 1);
  var_4 = self localtoworldcoords(var_3);

  if(self maymovetopoint(var_4)) {
    _id_243E(var_2, "prone", "stop", undefined, var_0);
  } else {
    _id_243E( % crouch_2_prone_firing, "prone", "stop", undefined, var_0);
  }
}

_id_243B() {
  _id_2439();
  _id_2431();
}

_id_243C() {
  _id_2439();
  _id_2431();
}

_id_243D(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("entered_pose" + var_1);
  _id_243F(var_0, var_1, var_2, var_3, var_4, 0);
}

_id_243E(var_0, var_1, var_2, var_3, var_4) {
  _id_243F(var_0, var_1, var_2, var_3, var_4, 1);
}

_id_243F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 1;

  }
  if(var_5) {
    thread _id_2440(getanimlength(var_0) / 2.0, "killtimerscript", var_1);

  }
  self setflaggedanimknoballrestart("transAnimDone2", var_0, % body, 1, 0.2, var_4);

  if(!isDefined(self.a._id_0D26)) {
    self._id_0D26 = "undefined";

  }
  if(!isDefined(self.a._id_0D2B)) {
    self._id_0D2B = "undefined";

  }
  var_6 = "";
  animscripts\shared::_id_0C51("transAnimDone2", undefined, var_6);
  self notify("killtimerscript");
  self.a._id_0D26 = var_1;
  self notify("entered_pose" + var_1);
  self.a._id_0D2B = var_2;

  if(isDefined(var_3)) {
    self setanimknoball(var_3, % body, 1, 0.3, var_4);
  }
}

_id_2440(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon(var_1);
  var_3 = self.a._id_0D26;
  wait(var_0);

  if(var_3 != "prone" && var_2 == "prone") {
    animscripts\cover_prone::_id_10E2(0.1);
    animscripts\utility::_id_10E1(1.0);
  } else if(var_3 == "prone" && var_2 != "prone") {
    animscripts\utility::_id_0F7D(1.0);
    self orientmode("face default");
  }
}

_id_2441(var_0) {
  self setanimknoball( % prone_legsstraight, % body, 1, var_0, 1);
}