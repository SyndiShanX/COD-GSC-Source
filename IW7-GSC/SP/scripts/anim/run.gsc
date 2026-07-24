/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\run.gsc
**************************************/

_id_BCEB() {
  var_0 = [[self._id_3EF3]]("stand");

  switch (var_0) {
    case "stand":
      if(scripts\anim\setposemovement::_id_10B76()) {
        return;
      }
      if(isDefined(self._id_E80C)) {
        scripts\anim\move::_id_BCF8(self._id_E80C, self._id_E80B);
        return;
      }

      if(_id_10B77()) {
        return;
      }
      if(_id_10B78()) {
        return;
      }
      scripts\anim\utility::_id_12EB9();

      if(scripts\anim\utility::_id_9E40())
        _id_10B79();
      else
        _id_10B7A();

      break;
    case "crouch":
      if(scripts\anim\setposemovement::_id_4A9E()) {
        return;
      }
      if(isDefined(self._id_4A9F))
        _id_4AA1();
      else
        _id_4AA0();

      break;
    default:
      if(scripts\anim\setposemovement::_id_DA84()) {
        return;
      }
      _id_DA7F();
      break;
  }
}

getrunningforwardpainanim() {
  if(!isDefined(self.a._id_BCA5))
    return scripts\anim\utility::_id_B027("run", "straight");

  if(!self.facemotion) {
    if(self.stairsstate == "none" || abs(self _meth_813E()) > 45)
      return scripts\anim\utility::_id_7FCC("move_f");
  }

  if(self.stairsstate == "up")
    return scripts\anim\utility::_id_7FCC("stairs_up");
  else if(self.stairsstate == "down")
    return scripts\anim\utility::_id_7FCC("stairs_down");

  if(scripts\anim\utility::_id_9E40() || isDefined(self.a._id_29CE) && self.a._id_29CE)
    return scripts\anim\utility::_id_7FCC("straight");

  var_0 = scripts\anim\utility::_id_7FCC("straight_twitch");

  if(!isDefined(var_0) || var_0.size == 0)
    return scripts\anim\utility::_id_7FCC("straight");

  var_1 = scripts\anim\utility::_id_80BD(self.a._id_E860, 4);

  if(var_1 == 0) {
    var_1 = scripts\anim\utility::_id_80BD(self.a._id_E860, var_0.size);
    return var_0[var_1];
  }

  return scripts\anim\utility::_id_7FCC("straight");
}

_id_7E47() {
  if(!isDefined(self.a._id_BCA5))
    return scripts\anim\utility::_id_B027("run", "crouch");

  return scripts\anim\utility::_id_7FCC("crouch");
}

_id_DA7F() {
  self.a.movement = "run";
  self _meth_82E2("runanim", scripts\anim\utility::_id_7FCC("prone"), 1, 0.3, self.moveplaybackrate);
  _id_E7E5();
  scripts\anim\notetracks::donotetracksfortime(0.25, "runanim");
}

#using_animtree("generic_human");

_id_98C6() {
  if(!isDefined(self._id_E873)) {
    self notify("stop_move_anim_update");
    self._id_12DEF = undefined;
    self clearanim(%combatrun_backward, 0.2);
    self clearanim(%combatrun_right, 0.2);
    self clearanim(%combatrun_left, 0.2);
    self clearanim(%w_aim_2, 0.2);
    self clearanim(%w_aim_4, 0.2);
    self clearanim(%w_aim_6, 0.2);
    self clearanim(%w_aim_8, 0.2);
    self._id_E873 = 1;
  }
}

_id_11088() {
  if(isDefined(self._id_E873)) {
    self clearanim(%run_n_gun, 0.2);
    self._id_E873 = undefined;
  }

  return 0;
}

_id_E873(var_0) {
  if(var_0) {
    var_1 = _id_8096(0.2);
    var_2 = var_1 < 0;
  } else {
    var_1 = 0;
    var_2 = self._id_E879 < 0;
  }

  var_3 = 1 - var_2;
  var_4 = self._id_B4C3;
  var_5 = self._id_E878;
  var_6 = self._id_E876;

  if(!var_0 || squared(var_1) > var_4 * var_4) {
    self clearanim(%add_fire, 0);

    if(squared(self._id_E879) < var_6 * var_6) {
      self._id_E879 = 0;
      self._id_E873 = undefined;
      return 0;
    } else if(self._id_E879 > 0)
      self._id_E879 = self._id_E879 - var_6;
    else
      self._id_E879 = self._id_E879 + var_6;
  } else {
    var_7 = var_1 / var_4;
    var_8 = var_7 - self._id_E879;

    if(abs(var_8) < var_5 * 0.7)
      self._id_E879 = var_7;
    else if(var_8 > 0)
      self._id_E879 = self._id_E879 + var_6;
    else
      self._id_E879 = self._id_E879 - var_6;
  }

  _id_98C6();
  var_9 = abs(self._id_E879);
  var_10 = scripts\anim\utility::_id_B028("run_n_gun");

  if(var_9 > var_5) {
    var_11 = (var_9 - var_5) / var_5;
    var_11 = clamp(var_11, 0, 1);
    self clearanim(var_10["F"], 0.2);
    self _meth_82AC(var_10["L"], (1.0 - var_11) * var_2, 0.2);
    self _meth_82AC(var_10["R"], (1.0 - var_11) * var_3, 0.2);
    self _meth_82AC(var_10["LB"], var_11 * var_2, 0.2);
    self _meth_82AC(var_10["RB"], var_11 * var_3, 0.2);
  } else {
    var_11 = clamp(var_9 / var_5, 0, 1);
    self _meth_82AC(var_10["F"], 1.0 - var_11, 0.2);
    self _meth_82AC(var_10["L"], var_11 * var_2, 0.2);
    self _meth_82AC(var_10["R"], var_11 * var_3, 0.2);

    if(var_5 < 1) {
      self clearanim(var_10["LB"], 0.2);
      self clearanim(var_10["RB"], 0.2);
    }
  }

  self _meth_82E2("runanim", %run_n_gun, 1, 0.3, 0.8);
  _id_E80F(undefined);
  self.a._id_1C8D = gettime() + 500;

  if(var_0 && isPlayer(self.enemy))
    self _meth_83CE();

  return 1;
}

_id_E874() {
  _id_98C6();
  var_0 = scripts\anim\utility::_id_B027("run_n_gun", "move_back");
  self _meth_82E2("runanim", var_0, 1, 0.3, 0.8);
  _id_E80F(var_0);

  if(isPlayer(self.enemy))
    self _meth_83CE();

  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
  self clearanim(var_0, 0.2);
}

_id_DD62() {
  self endon("killanimscript");

  for(;;) {
    wait 0.2;

    if(!isDefined(self._id_DD39)) {
      break;
    }

    if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < squared(80)) {
      _id_6382();
      self notify("interrupt_react_to_bullet");
      break;
    }
  }
}

_id_6382() {
  self orientmode("face default");
  self._id_DD39 = undefined;
  self._id_E1B0 = undefined;
}

_id_E87E() {
  _id_6318();
  self endon("interrupt_react_to_bullet");
  self._id_DD39 = 1;
  self orientmode("face motion");
  var_0 = scripts\anim\utility::_id_B028("running_react_to_bullets");
  var_1 = randomint(var_0.size);

  if(var_1 == anim._id_A9E6)
    var_1 = (var_1 + 1) % var_0.size;

  anim._id_A9E6 = var_1;
  var_2 = var_0[var_1];
  self _meth_82E7("reactanim", var_2, 1, 0.5, self.moveplaybackrate);
  _id_E80F(var_2);
  thread _id_DD62();
  scripts\anim\shared::donotetracks("reactanim");
  _id_6382();
}

_id_4C9A() {
  _id_6318();
  self._id_DD39 = 1;
  self orientmode("face motion");
  var_0 = randomint(self._id_E80D.size);
  var_1 = self._id_E80D[var_0];
  self _meth_82E7("reactanim", var_1, 1, 0.5, self.moveplaybackrate);
  _id_E80F(var_1);
  thread _id_DD62();
  scripts\anim\shared::donotetracks("reactanim");
  _id_6382();
}

_id_8150() {
  var_0 = undefined;

  if(isDefined(self.grenade))
    var_0 = scripts\anim\utility::_id_7FCC("sprint_short");

  if(!isDefined(var_0))
    var_0 = scripts\anim\utility::_id_7FCC("sprint");

  return var_0;
}

_id_10086() {
  if(isDefined(self._id_10AB7))
    return 1;

  if(isDefined(self.grenade) && isDefined(self.enemy) && self.frontshieldanglecos == 1)
    return distancesquared(self.origin, self.enemy.origin) > 90000;

  return 0;
}

_id_10087() {
  if(isDefined(self._id_BEFA))
    return 0;

  if(!self.facemotion || self.stairsstate != "none")
    return 0;

  var_0 = gettime();

  if(isDefined(self._id_4D85)) {
    if(var_0 < self._id_4D85)
      return 1;

    if(var_0 - self._id_4D85 < 6000)
      return 0;
  }

  if(!isDefined(self.enemy) || !issentient(self.enemy))
    return 0;

  if(randomint(100) < 25 && self lastknowntime(self.enemy) + 2000 > var_0) {
    self._id_4D85 = var_0 + 2000 + randomint(1000);
    return 1;
  }

  return 0;
}

_id_7FCF() {
  var_0 = self.moveplaybackrate;

  if(self.lookaheadhitsstairs && self.stairsstate == "none" && self.lookaheaddist < 300)
    var_0 = var_0 * 0.75;

  return var_0;
}

_id_10B79() {
  var_0 = _id_7FCF();
  self setanimknob(%combatrun, 1.0, 0.5, var_0);
  var_1 = 0;
  var_2 = isDefined(self._id_E1B0) && gettime() - self._id_E1B0 < 100;

  if(var_2 && randomfloat(1) < self.a.reacttobulletchance) {
    _id_11088();
    _id_F843(0);
    _id_E87E();
    return;
  }

  if(_id_10086()) {
    var_3 = _id_8150();
    self _meth_82E2("runanim", var_3, 1, 0.5, self.moveplaybackrate);
    _id_E80F(var_3);
    _id_F843(0);
    var_1 = 1;
  } else if(isDefined(self.enemy) && scripts\anim\move::_id_B4EC()) {
    _id_F843(1);

    if(!self.facemotion)
      thread _id_6A6B();
    else if(self._id_FED7 != "none" && !isDefined(self._id_C09F)) {
      _id_6318();

      if(canshoottargetfrompos())
        var_1 = _id_E873(1);
      else if(canshoottarget()) {
        _id_E874();
        return;
      }
    } else if(isDefined(self._id_E879) && self._id_E879 != 0)
      var_1 = _id_E873(0);
  } else if(isDefined(self._id_E879) && self._id_E879 != 0) {
    _id_F843(0);
    var_1 = _id_E873(0);
  } else
    _id_F843(0);

  if(!var_1) {
    _id_11088();

    if(var_2 && self.a.reacttobulletchance != 0) {
      _id_E87E();
      return;
    }

    if(_id_BC1D()) {
      return;
    }
    self clearanim(%stair_transitions, 0.1);

    if(_id_10087())
      var_4 = scripts\anim\utility::_id_7FCC("sprint_short");
    else
      var_4 = getrunningforwardpainanim();

    self _meth_82E5("runanim", var_4, 1, 0.1, self.moveplaybackrate, 1);
    _id_E80F(var_4);
    _id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"), self._id_101BB);
    thread setcombatstandmoveanimweights("run");
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
}

_id_815A(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "none";

  if(var_0 == var_1)
    return undefined;

  if(var_0 == "up")
    return scripts\anim\utility::_id_7FCC("stairs_up_out");
  else if(var_0 == "down")
    return scripts\anim\utility::_id_7FCC("stairs_down_out");
  else if(var_1 == "up")
    return scripts\anim\utility::_id_7FCC("stairs_up_in");
  else if(var_1 == "down")
    return scripts\anim\utility::_id_7FCC("stairs_down_in");
}

_id_6A6B() {
  if(isDefined(self._id_1A32)) {
    return;
  }
  self._id_1A32 = 1;
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");
  self _meth_82D0();
  var_0 = undefined;

  if(isDefined(self._id_440C) && isDefined(self._id_440C["walk_aims"])) {
    self _meth_82AC(self._id_440C["walk_aims"]["walk_aim_2"]);
    self _meth_82AC(self._id_440C["walk_aims"]["walk_aim_4"]);
    self _meth_82AC(self._id_440C["walk_aims"]["walk_aim_6"]);
    self _meth_82AC(self._id_440C["walk_aims"]["walk_aim_8"]);
  } else {
    var_1 = "walk";

    if(scripts\anim\utility::_id_FFDB() && isDefined(scripts\anim\utility::_id_B027("cqb", "aim_2")))
      var_1 = "cqb";

    var_2 = scripts\anim\utility::_id_B028(var_1);
    self _meth_82AC(var_2["aim_2"]);
    self _meth_82AC(var_2["aim_4"]);
    self _meth_82AC(var_2["aim_6"]);
    self _meth_82AC(var_2["aim_8"]);

    if(isDefined(var_2["aim_5"])) {
      self _meth_82AC(var_2["aim_5"]);
      var_0 = % w_aim_5;
    }
  }

  scripts\anim\track::_id_11AF8(%w_aim_2, %w_aim_4, %w_aim_6, %w_aim_8, var_0);
}

_id_6318() {
  self._id_1A32 = undefined;
  self notify("end_face_enemy_tracking");
}

_id_F843(var_0) {
  var_1 = isDefined(self._id_3129);

  if(var_0) {
    self._id_3129 = var_0;

    if(!var_1) {
      thread _id_E843();
      thread _id_E89B();
    }
  } else {
    self._id_3129 = undefined;

    if(var_1) {
      self notify("end_shoot_while_moving");
      self notify("end_face_enemy_tracking");
      self._id_FE92 = undefined;
      self._id_1A32 = undefined;
      self._id_E873 = undefined;
    }
  }
}

_id_E843() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  scripts\anim\shoot_behavior::_id_4F69("normal");
}

_id_E89B() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  scripts\anim\move::_id_FEEB();
}

_id_1A3C() {
  var_0 = self getmuzzleangle();
  var_1 = vectortoangles(self.enemy getshootatpos() - self getmuzzlepos());

  if(scripts\engine\utility::absangleclamp180(var_0[1] - var_1[1]) > 15)
    return 0;

  return scripts\engine\utility::absangleclamp180(var_0[0] - var_1[0]) <= 20;
}

canshoottargetfrompos() {
  if((!isDefined(self._id_E879) || self._id_E879 == 0) && abs(self _meth_813E()) > self._id_B4C3)
    return 0;

  return 1;
}

canshoottarget() {
  if(180 - abs(self _meth_813E()) >= 45)
    return 0;

  var_0 = _id_8096(0.2);

  if(abs(var_0) > 30)
    return 0;

  return 1;
}

canshootinvehicle() {
  return scripts\anim\move::_id_B4EC() && isDefined(self.enemy) && (canshoottargetfrompos() || canshoottarget());
}

_id_8096(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self _meth_813E();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.velocity) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

_id_BC1D() {
  var_0 = 0;
  var_1 = undefined;

  if(self.stairsstate == "none" && self.lookaheadhitsstairs) {
    if(scripts\anim\utility::_id_FFDB())
      var_2 = 32;
    else
      var_2 = 48;

    var_3 = self.origin + (0, 0, 6);
    var_4 = vectorNormalize((self.lookaheaddir[0], self.lookaheaddir[1], 0));
    var_5 = var_3 + var_2 * var_4;
    var_6 = self aiphysicstrace(var_3, var_5, 15, 48, 1, 1);

    if(var_6["fraction"] < 1) {
      if(!isDefined(var_6["stairs"]))
        return 0;

      var_1 = _id_815A("none", "up");
    } else {
      var_7 = 18;
      var_8 = var_5 + (0, 0, var_7);
      var_9 = var_5 - (0, 0, var_7);
      var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);

      if(var_6["fraction"] >= 1)
        return 0;

      if(!isDefined(var_6["stairs"]))
        return 0;

      var_1 = _id_815A("none", "down");
    }
  } else if(self.stairsstate == "up") {
    var_2 = 24;
    var_7 = 18;
    var_5 = self.origin + var_2 * self.lookaheaddir;
    var_8 = var_5 + (0, 0, var_7);
    var_9 = var_5 - (0, 0, var_7);
    var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);

    if(var_6["fraction"] <= 0 || var_6["fraction"] >= 1)
      return 0;

    if(isDefined(var_6["stairs"]))
      return 0;

    var_1 = _id_815A("up", "none");
  } else if(self.stairsstate == "down" && !self.lookaheadhitsstairs) {
    var_2 = 24;
    var_7 = 18;
    var_5 = self.origin + var_2 * self.lookaheaddir;
    var_8 = var_5 + (0, 0, var_7);
    var_9 = var_5 - (0, 0, var_7);
    var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);

    if(var_6["fraction"] <= 0 || var_6["fraction"] >= 1)
      return 0;

    if(isDefined(var_6["stairs"]))
      return 0;

    var_1 = _id_815A("down", "none");
  }

  if(!isDefined(var_1))
    return 0;

  self notify("stop_move_anim_update");
  self._id_12DEF = undefined;
  self _meth_82E4("runanim", var_1, %body, 1, 0.1, self.moveplaybackrate);
  _id_E80F(var_1);
  scripts\anim\shared::donotetracks("runanim");
  return 1;
}

_id_10B7A() {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  var_0 = _id_7FCF();

  if(_id_BC1D()) {
    return;
  }
  self clearanim(%stair_transitions, 0.1);
  self _meth_82A5(%combatrun, %body, 1, 0.2, var_0);

  if(_id_10086())
    var_1 = _id_8150();
  else
    var_1 = getrunningforwardpainanim();

  if(self.stairsstate == "none")
    var_2 = 0.3;
  else
    var_2 = 0.1;

  self _meth_82E2("runanim", var_1, 1, var_2, self.moveplaybackrate, 1);
  _id_E80F(var_1);
  _id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  var_3 = 0;

  if(self.leanamount > 0 && self.leanamount < 0.998)
    var_3 = 1;
  else if(self.leanamount < 0 && self.leanamount > -0.998)
    var_3 = -1;

  var_4 = max(0.2, var_2);
  scripts\anim\notetracks::donotetracksfortime(var_4, "runanim");
}

_id_4AA1() {
  self endon("movemode");
  self _meth_82E3("runanim", self._id_4A9F, %body, 1, 0.4, self.moveplaybackrate);
  _id_E80F(self._id_4A9F);
  scripts\anim\shared::donotetracks("runanim");
}

_id_4AA0() {
  self endon("movemode");
  var_0 = _id_7E47();
  self setanimknob(var_0, 1, 0.4);
  thread _id_12ED3("crouchrun", var_0, scripts\anim\utility::_id_B027("run", "crouch_b"), scripts\anim\utility::_id_B027("run", "crouch_l"), scripts\anim\utility::_id_B027("run", "crouch_r"));
  self _meth_82E3("runanim", %crouchrun, %body, 1, 0.2, self.moveplaybackrate);
  _id_E80F(undefined);
  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
}

_id_10B78() {
  var_0 = isDefined(self.a._id_1C8D) && self.a._id_1C8D > gettime();
  var_0 = var_0 || isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536;

  if(var_0) {
    if(!scripts\anim\utility_common::needtoreload(0))
      return 0;
  } else if(!scripts\anim\utility_common::needtoreload(0.5))
    return 0;

  if(isDefined(self.grenade))
    return 0;

  if(!self.facemotion || self.stairsstate != "none")
    return 0;

  if(isDefined(self._id_596C) || isDefined(self._id_C0A0))
    return 0;

  if(canshootinvehicle() && !scripts\anim\utility_common::needtoreload(0))
    return 0;

  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536)
    return 0;

  var_1 = angleclamp180(self _meth_813E());

  if(abs(var_1) > 25)
    return 0;

  if(!scripts\anim\utility_common::usingriflelikeweapon())
    return 0;

  if(!_id_E861())
    return 0;

  if(scripts\anim\utility::_id_FFDB())
    scripts\anim\cqb::_id_4790();
  else
    _id_10B7B();

  self notify("abort_reload");
  self orientmode("face default");
  return 1;
}

_id_10B7B() {
  self endon("movemode");
  self orientmode("face motion");
  var_0 = "reload_" + scripts\anim\combat_utility::_id_81EB();
  var_1 = scripts\anim\utility::_id_B027("run", "reload");

  if(isarray(var_1))
    var_1 = var_1[randomint(var_1.size)];

  self _meth_82E4(var_0, var_1, %body, 1, 0.25);
  _id_E80F(var_1);
  self._id_12DF0 = 1;
  _id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  scripts\anim\shared::donotetracks(var_0);
  self._id_12DF0 = undefined;
}

_id_E861() {
  var_0 = self islegacyagent(%walk_and_run_loops);
  var_1 = getanimlength(scripts\anim\utility::_id_B027("run", "straight")) / 3.0;
  var_0 = var_0 * 3.0;

  if(var_0 > 3)
    var_0 = var_0 - 2.0;
  else if(var_0 > 2)
    var_0 = var_0 - 1.0;

  if(var_0 < 0.15 / var_1)
    return 1;

  if(var_0 > 1 - 0.3 / var_1)
    return 1;

  return 0;
}

_id_F7A9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  self _meth_82A9(var_0, 1, 0.1, var_3, 1);
  self _meth_82A9(var_1, 1, 0.1, var_3, 1);
  self _meth_82A9(var_2, 1, 0.1, var_3, 1);
}

setcombatstandmoveanimweights(var_0) {
  _id_12ED3(var_0, %combatrun_forward, %combatrun_backward, %combatrun_left, %combatrun_right);
}

_id_12ED3(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_12DEF) && self._id_12DEF == var_0) {
    return;
  }
  self notify("stop_move_anim_update");
  self._id_12DEF = var_0;
  self._id_13910 = undefined;
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("stop_move_anim_update");

  for(;;) {
    _id_12F08(var_1, var_2, var_3, var_4);
    wait 0.05;
    waittillframeend;
  }
}

_id_12F08(var_0, var_1, var_2, var_3) {
  if(self.facemotion && !scripts\anim\utility::_id_FFDB() && !isDefined(self._id_12DF0)) {
    if(!isDefined(self._id_13910)) {
      self._id_13910 = 1;
      self _meth_82A2(var_0, 1, 0.2, 1, 1);
      self _meth_82A2(var_1, 0, 0.2, 1, 1);
      self _meth_82A2(var_2, 0, 0.2, 1, 1);
      self _meth_82A2(var_3, 0, 0.2, 1, 1);
    }
  } else {
    self._id_13910 = undefined;
    var_4 = scripts\anim\utility_common::quadrantanimweights(self _meth_813E());

    if(isDefined(self._id_12DF0)) {
      var_4["back"] = 0.0;

      if(var_4["front"] < 0.2)
        var_4["front"] = 0.2;
    }

    self _meth_82A2(var_0, var_4["front"], 0.2, 1, 1);
    self _meth_82A2(var_1, var_4["back"], 0.2, 1, 1);
    self _meth_82A2(var_2, var_4["left"], 0.2, 1, 1);
    self _meth_82A2(var_3, var_4["right"], 0.2, 1, 1);
  }
}

_id_10B77() {
  var_0 = isDefined(self._id_138DF) && self._id_138DF;
  var_1 = scripts\anim\utility_common::isshotgun(self.weapon);

  if(var_0 == var_1)
    return 0;

  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536)
    return 0;

  if(scripts\anim\utility_common::isusingsidearm())
    return 0;

  if(self.weapon == self.primaryweapon) {
    if(!var_0)
      return 0;

    if(scripts\anim\utility_common::isshotgun(self.secondaryweapon))
      return 0;
  } else {
    if(var_0)
      return 0;

    if(scripts\anim\utility_common::isshotgun(self.primaryweapon))
      return 0;
  }

  var_2 = angleclamp180(self _meth_813E());

  if(abs(var_2) > 25)
    return 0;

  if(!_id_E861())
    return 0;

  if(var_0)
    _id_FF02("shotgunPullout", scripts\anim\utility::_id_B027("cqb", "shotgun_pullout"), "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
  else
    _id_FF02("shotgunPutaway", scripts\anim\utility::_id_B027("cqb", "shotgun_putaway"), "gun_2_back", "back", self.primaryweapon, "shotgun_pickup");

  self notify("switchEnded");
  return 1;
}

_id_FF02(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("movemode");
  self _meth_82E4(var_0, var_1, %body, 1, 0.25);
  _id_E80F(var_1);
  self._id_12DF0 = 1;
  _id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  thread _id_13B40(var_0, var_2, var_3, var_4, var_5);
  scripts\anim\notetracks::donotetracksfortimeintercept(getanimlength(var_1) - 0.25, var_0, ::_id_9A61);
  self._id_12DF0 = undefined;
}

_id_9A61(var_0) {
  if(var_0 == "gun_2_chest" || var_0 == "gun_2_back")
    return 1;
}

_id_13B40(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("movemode");
  self endon("switchEnded");
  self waittillmatch(var_0, var_1);
  scripts\anim\shared::placeweaponon(self.weapon, var_2);
  thread _id_FF01(var_3);
  self waittillmatch(var_0, var_4);
  self notify("complete_weapon_switch");
}

_id_FF01(var_0) {
  self endon("death");
  scripts\engine\utility::waittill_any("killanimscript", "movemode", "switchEnded", "complete_weapon_switch");
  self.lastweapon = self.weapon;
  scripts\anim\shared::placeweaponon(var_0, "right");
  self.bulletsinclip = weaponclipsize(self.weapon);
}

_id_E80F(var_0) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, "run", self.facialidx);
}

_id_E7E5() {
  self.facialidx = undefined;
  self clearanim(%head, 0.2);
}