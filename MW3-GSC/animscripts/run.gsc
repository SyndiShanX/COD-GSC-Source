/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\run.gsc
**************************************/

_id_0FB9() {
  var_0 = [[self._id_0FBA]]("stand");

  switch (var_0) {
    case "stand":
      if(animscripts\setposemovement::_id_0FBB()) {
        return;
      }
      if(isDefined(self._id_0FBC)) {
        animscripts\move::_id_0FBE(self._id_0FBC, self._id_0FBD);
        return;
      }

      if(_id_0FFD()) {
        return;
      }
      if(_id_0FF0()) {
        return;
      }
      if(animscripts\utility::_id_0A69()) {
        _id_0FDC();
      } else {
        _id_0FED();

      }
      break;
    case "crouch":
      if(animscripts\setposemovement::_id_0FBF()) {
        return;
      }
      if(isDefined(self._id_0FC0)) {
        _id_0FEE();
      } else {
        _id_0FEF();

      }
      break;
    default:
      if(animscripts\setposemovement::_id_0FC1()) {
        return;
      }
      _id_0FC5();
      break;
  }
}

#using_animtree("generic_human");

_id_0FC2() {
  if(!isDefined(self.a._id_0CA6)) {
    return % run_lowready_f;

  }
  if(!self.facemotion) {
    if(self.stairsstate == "none" || abs(self getmotionangle()) > 45) {
      return animscripts\utility::_id_0FC3("move_f");
    }
  }

  if(self.stairsstate == "up") {
    return animscripts\utility::_id_0FC3("stairs_up");
  } else if(self.stairsstate == "down") {
    return animscripts\utility::_id_0FC3("stairs_down");

  }
  return animscripts\utility::_id_0FC3("straight");
}

_id_0FC4() {
  if(!isDefined(self.a._id_0CA6)) {
    return % crouch_fastwalk_f;

  }
  return animscripts\utility::_id_0FC3("crouch");
}

_id_0FC5() {
  self.a._id_0D2B = "run";
  self setflaggedanimknob("runanim", animscripts\utility::_id_0FC3("prone"), 1, 0.3, self._id_0FC6);
  animscripts\notetracks::_id_0D4F(0.25, "runanim");
}

_id_0FC7() {
  if(!isDefined(self._id_0FC8)) {
    self notify("stop_move_anim_update");
    self._id_0FC9 = undefined;
    self clearanim( % combatrun_backward, 0.2);
    self clearanim( % combatrun_right, 0.2);
    self clearanim( % combatrun_left, 0.2);
    self clearanim( % w_aim_2, 0.2);
    self clearanim( % w_aim_4, 0.2);
    self clearanim( % w_aim_6, 0.2);
    self clearanim( % w_aim_8, 0.2);
    self._id_0FC8 = 1;
  }
}

_id_0FCA() {
  if(isDefined(self._id_0FC8)) {
    self clearanim( % run_n_gun, 0.2);
    self._id_0FC8 = undefined;
  }

  return 0;
}

_id_0FC8(var_0) {
  if(var_0) {
    var_1 = _id_0FEC(0.2);
    var_2 = var_1 < 0;
  } else {
    var_1 = 0;
    var_2 = self._id_0FCB < 0;
  }

  var_3 = 1 - var_2;
  var_4 = self._id_0CA1;
  var_5 = self._id_0CA2;
  var_6 = self._id_0CA3;

  if(!var_0 || squared(var_1) > var_4 * var_4) {
    self clearanim( % add_fire, 0);

    if(squared(self._id_0FCB) < var_6 * var_6) {
      self._id_0FCB = 0;
      self._id_0FC8 = undefined;
      return 0;
    } else if(self._id_0FCB > 0) {
      self._id_0FCB = self._id_0FCB - var_6;
    } else {
      self._id_0FCB = self._id_0FCB + var_6;
    }
  } else {
    var_7 = var_1 / var_4;
    var_8 = var_7 - self._id_0FCB;

    if(abs(var_8) < var_5 * 0.7) {
      self._id_0FCB = var_7;
    } else if(var_8 > 0) {
      self._id_0FCB = self._id_0FCB + var_6;
    } else {
      self._id_0FCB = self._id_0FCB - var_6;
    }
  }

  _id_0FC7();
  var_9 = abs(self._id_0FCB);

  if(var_9 > var_5) {
    var_10 = (var_9 - var_5) / var_5;
    var_10 = clamp(var_10, 0, 1);
    self clearanim(self._id_0CA4["F"], 0.2);
    self setanimlimited(self._id_0CA4["L"], (1.0 - var_10) * var_2, 0.2);
    self setanimlimited(self._id_0CA4["R"], (1.0 - var_10) * var_3, 0.2);
    self setanimlimited(self._id_0CA4["LB"], var_10 * var_2, 0.2);
    self setanimlimited(self._id_0CA4["RB"], var_10 * var_3, 0.2);
  } else {
    var_10 = clamp(var_9 / var_5, 0, 1);
    self setanimlimited(self._id_0CA4["F"], 1.0 - var_10, 0.2);
    self setanimlimited(self._id_0CA4["L"], var_10 * var_2, 0.2);
    self setanimlimited(self._id_0CA4["R"], var_10 * var_3, 0.2);

    if(var_5 < 1) {
      self clearanim(self._id_0CA4["LB"], 0.2);
      self clearanim(self._id_0CA4["RB"], 0.2);
    }
  }

  self setflaggedanimknob("runanim", % run_n_gun, 1, 0.3, 0.8);
  self.a._id_0FCC = gettime() + 500;

  if(var_0 && isplayer(self.enemy)) {
    self updateplayersightaccuracy();

  }
  return 1;
}

_id_0FCD() {
  _id_0FC7();
  self setflaggedanimknob("runanim", % combatwalk_b, 1, 0.3, 0.8);

  if(isplayer(self.enemy)) {
    self updateplayersightaccuracy();

  }
  animscripts\notetracks::_id_0D4F(0.2, "runanim");
  thread _id_0FE5();
  self clearanim( % combatwalk_b, 0.2);
}

_id_0FCE() {
  self endon("killanimscript");

  for(;;) {
    wait 0.2;

    if(!isDefined(self._id_0FCF)) {
      break;
    }

    if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < squared(80)) {
      _id_0FD0();
      self notify("interrupt_react_to_bullet");
      break;
    }
  }
}

_id_0FD0() {
  self orientmode("face default");
  self._id_0FCF = undefined;
  self._id_0FD1 = undefined;
}

_id_0F1D() {
  self._id_0FD2 = undefined;
  self notify("end_face_enemy_tracking");
  self endon("interrupt_react_to_bullet");
  self._id_0FCF = 1;
  self orientmode("face motion");
  var_0 = randomint(anim._id_0F1D.size);

  if(var_0 == anim._id_0F1E) {
    var_0 = (var_0 + 1) % anim._id_0F1D.size;

  }
  anim._id_0F1E = var_0;
  var_1 = anim._id_0F1D[var_0];
  self setflaggedanimknobrestart("reactanim", var_1, 1, 0.5);
  thread _id_0FCE();
  animscripts\shared::_id_0C51("reactanim");
  _id_0FD0();
}

_id_0FD3() {
  self._id_0FD2 = undefined;
  self notify("end_face_enemy_tracking");
  self._id_0FCF = 1;
  self orientmode("face motion");
  var_0 = randomint(self._id_0FD4.size);
  var_1 = self._id_0FD4[var_0];
  self setflaggedanimknobrestart("reactanim", var_1, 1, 0.5);
  thread _id_0FCE();
  animscripts\shared::_id_0C51("reactanim");
  _id_0FD0();
}

_id_0FD5() {
  var_0 = undefined;

  if(isDefined(self.grenade)) {
    var_0 = animscripts\utility::_id_0FC3("sprint_short");

  }
  if(!isDefined(var_0)) {
    var_0 = animscripts\utility::_id_0FC3("sprint");

  }
  return var_0;
}

_id_0FD6() {
  if(isDefined(self._id_0FD7)) {
    return 1;

  }
  if(isDefined(self.grenade) && isDefined(self.enemy) && self.frontshieldanglecos == 1) {
    return distancesquared(self.origin, self.enemy.origin) > 90000;

  }
  return 0;
}

_id_0FD8() {
  if(isDefined(self._id_0FD9)) {
    return 0;

  }
  if(!self.facemotion || self.stairsstate != "none") {
    return 0;

  }
  var_0 = gettime();

  if(isDefined(self._id_0FDA)) {
    if(var_0 < self._id_0FDA) {
      return 1;

    }
    if(var_0 - self._id_0FDA < 6000) {
      return 0;
    }
  }

  if(!isDefined(self.enemy) || !issentient(self.enemy)) {
    return 0;

  }
  if(randomint(100) < 25 && self lastknowntime(self.enemy) + 2000 > var_0) {
    self._id_0FDA = var_0 + 2000 + randomint(1000);
    return 1;
  }

  return 0;
}

_id_0FDB() {
  var_0 = self._id_0FC6;

  if(self.lookaheadhitsstairs && self.stairsstate == "none" && self.lookaheaddist < 300) {
    var_0 = var_0 * 0.75;

  }
  return var_0;
}

_id_0FDC() {
  var_0 = _id_0FDB();
  self setanimknob( % combatrun, 1.0, 0.5, var_0);
  var_1 = 0;

  if(isDefined(self._id_0FD1) && gettime() - self._id_0FD1 < 100 && randomfloat(1) < self.a._id_0FDD) {
    _id_0FCA();
    _id_0F1D();
    return;
  }

  if(_id_0FD6()) {
    self setflaggedanimknob("runanim", _id_0FD5(), 1, 0.5);
    var_1 = 1;
  } else if(isDefined(self.enemy) && animscripts\move::_id_0FDE()) {
    _id_0FE3();

    if(!self.facemotion) {
      thread _id_0FE1();
    } else if(self._id_0CDA != "none" && !isDefined(self._id_0FDF)) {
      self notify("end_face_enemy_tracking");
      self._id_0FD2 = undefined;

      if(_id_0FE9()) {
        var_1 = _id_0FC8(1);
      } else if(_id_0FEA()) {
        _id_0FCD();
        return;
      }
    } else if(isDefined(self._id_0FCB) && self._id_0FCB != 0) {
      var_1 = _id_0FC8(0);
    }
  } else if(isDefined(self._id_0FCB) && self._id_0FCB != 0) {
    var_1 = _id_0FC8(0);

  }
  if(!var_1) {
    _id_0FCA();

    if(isDefined(self._id_0FD1) && gettime() - self._id_0FD1 < 100 && self.a._id_0FDD != 0) {
      _id_0F1D();
      return;
    }

    if(_id_0FD8()) {
      var_2 = animscripts\utility::_id_0FC3("sprint_short");
    } else {
      var_2 = _id_0FC2();

    }
    self setflaggedanimknoblimited("runanim", var_2, 1, 0.1, 1, 1);
    _id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"), self._id_0FE0);
    thread _id_0FF8("run");
  }

  animscripts\notetracks::_id_0D4F(0.2, "runanim");
  thread _id_0FE5();
}

_id_0FE1() {
  self notify("want_aim_while_moving");

  if(isDefined(self._id_0FD2)) {
    return;
  }
  self._id_0FD2 = 1;
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");
  self setdefaultaimlimits();

  if(!isDefined(self._id_0C82) || !isDefined(self._id_0C82["walk_aims"])) {
    self setanimlimited( % walk_aim_2);
    self setanimlimited( % walk_aim_4);
    self setanimlimited( % walk_aim_6);
    self setanimlimited( % walk_aim_8);
  } else {
    self setanimlimited(self._id_0C82["walk_aims"]["walk_aim_2"]);
    self setanimlimited(self._id_0C82["walk_aims"]["walk_aim_4"]);
    self setanimlimited(self._id_0C82["walk_aims"]["walk_aim_6"]);
    self setanimlimited(self._id_0C82["walk_aims"]["walk_aim_8"]);
  }

  animscripts\track::_id_0CAA( % w_aim_2, % w_aim_4, % w_aim_6, % w_aim_8);
}

_id_0FE2() {
  self._id_0FD2 = undefined;
  self notify("end_face_enemy_tracking");
}

_id_0FE3() {
  self notify("want_shoot_while_moving");

  if(isDefined(self._id_0FE4)) {
    return;
  }
  self._id_0FE4 = 1;
  thread _id_0FE6();
  thread _id_0FE7();
}

_id_0FE5() {
  self endon("killanimscript");
  self endon("want_shoot_while_moving");
  self endon("want_aim_while_moving");
  wait 0.05;
  self notify("end_shoot_while_moving");
  self notify("end_face_enemy_tracking");
  self._id_0FE4 = undefined;
  self._id_0FD2 = undefined;
  self._id_0FC8 = undefined;
}

_id_0FE6() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  animscripts\shoot_behavior::_id_0CD7("normal");
}

_id_0FE7() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  animscripts\move::_id_0FE8();
}

_id_0D60() {
  var_0 = self getmuzzleangle();
  var_1 = vectortoangles(self.enemy getshootatpos() - self getmuzzlepos());

  if(animscripts\utility::_id_0D61(var_0[1] - var_1[1]) > 15) {
    return 0;

  }
  return animscripts\utility::_id_0D61(var_0[0] - var_1[0]) <= 20;
}

_id_0FE9() {
  if((!isDefined(self._id_0FCB) || self._id_0FCB == 0) && abs(self getmotionangle()) > self._id_0CA1) {
    return 0;

  }
  return 1;
}

_id_0FEA() {
  if(180 - abs(self getmotionangle()) >= 45) {
    return 0;

  }
  var_0 = _id_0FEC(0.2);

  if(abs(var_0) > 30) {
    return 0;

  }
  return 1;
}

_id_0FEB() {
  return animscripts\move::_id_0FDE() && isDefined(self.enemy) && (_id_0FE9() || _id_0FEA());
}

_id_0FEC(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getmotionangle();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.velocity) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

_id_0FED() {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  var_0 = _id_0FDB();
  self setanimknoball( % combatrun, % body, 1, 0.2, var_0);

  if(_id_0FD6()) {
    var_1 = _id_0FD5();
  } else {
    var_1 = _id_0FC2();

  }
  if(self.stairsstate == "none") {
    var_2 = 0.3;
  } else {
    var_2 = 0.1;

  }
  self setflaggedanimknob("runanim", var_1, 1, var_2, 1, 1);
  _id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));
  thread _id_0FF8("run");
  animscripts\notetracks::_id_0D4F(0.2, "runanim");
}

_id_0FEE() {
  self endon("movemode");
  self setflaggedanimknoball("runanim", self._id_0FC0, % body, 1, 0.4, self._id_0FC6);
  animscripts\shared::_id_0C51("runanim");
}

_id_0FEF() {
  self endon("movemode");
  var_0 = _id_0FC4();
  self setanimknob(var_0, 1, 0.4);
  thread _id_0FF9("crouchrun", var_0, % crouch_fastwalk_b, % crouch_fastwalk_l, % crouch_fastwalk_r);
  self setflaggedanimknoball("runanim", % crouchrun, % body, 1, 0.2, self._id_0FC6);
  animscripts\notetracks::_id_0D4F(0.2, "runanim");
}

_id_0FF0() {
  var_0 = isDefined(self.a._id_0FCC) && self.a._id_0FCC > gettime();
  var_0 = var_0 || isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536;

  if(var_0) {
    if(!animscripts\combat_utility::_id_0F08(0)) {
      return 0;
    }
  } else if(!animscripts\combat_utility::_id_0F08(0.5)) {
    return 0;

  }
  if(isDefined(self.grenade)) {
    return 0;

  }
  if(!self.facemotion || self.stairsstate != "none") {
    return 0;

  }
  if(isDefined(self._id_0FF1) || isDefined(self._id_0FF2)) {
    return 0;

  }
  if(_id_0FEB() && !animscripts\combat_utility::_id_0F08(0)) {
    return 0;

  }
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536) {
    return 0;

  }
  var_1 = angleclamp180(self getmotionangle());

  if(abs(var_1) > 25) {
    return 0;

  }
  if(!animscripts\utility::_id_0EE3()) {
    return 0;

  }
  if(!_id_0FF6()) {
    return 0;

  }
  _id_0FF3();
  self notify("abort_reload");
  self orientmode("face default");
  return 1;
}

_id_0FF3() {
  self endon("movemode");
  self orientmode("face motion");
  var_0 = "reload_" + animscripts\combat_utility::_id_0FF4();
  self setflaggedanimknoballrestart(var_0, % run_lowready_reload, % body, 1, 0.25);
  self._id_0FF5 = 1;
  _id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));
  thread _id_0FF8("run");
  animscripts\shared::_id_0C51(var_0);
  self._id_0FF5 = undefined;
}

_id_0FF6() {
  var_0 = self getanimtime( % walk_and_run_loops);
  var_1 = getanimlength( % run_lowready_f) / 3.0;
  var_0 = var_0 * 3.0;

  if(var_0 > 3) {
    var_0 = var_0 - 2.0;
  } else if(var_0 > 2) {
    var_0 = var_0 - 1.0;

  }
  if(var_0 < 0.15 / var_1) {
    return 1;

  }
  if(var_0 > 1 - 0.3 / var_1) {
    return 1;

  }
  return 0;
}

_id_0FF7(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;

  }
  self setanimknoblimited(var_0, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_1, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_2, 1, 0.1, var_3, 1);
}

_id_0FF8(var_0) {
  _id_0FF9(var_0, % combatrun_forward, % combatrun_backward, % combatrun_left, % combatrun_right);
}

_id_0FF9(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_0FC9) && self._id_0FC9 == var_0) {
    return;
  }
  self notify("stop_move_anim_update");
  self._id_0FC9 = var_0;
  self._id_0FFA = undefined;
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("stop_move_anim_update");

  for(;;) {
    _id_0FFB(var_1, var_2, var_3, var_4);
    wait 0.05;
    waittillframeend;
  }
}

_id_0FFB(var_0, var_1, var_2, var_3) {
  if(self.facemotion && !animscripts\utility::_id_0CB2() && !isDefined(self._id_0FF5)) {
    if(!isDefined(self._id_0FFA)) {
      self._id_0FFA = 1;
      self setanim(var_0, 1, 0.2, 1, 1);
      self setanim(var_1, 0, 0.2, 1, 1);
      self setanim(var_2, 0, 0.2, 1, 1);
      self setanim(var_3, 0, 0.2, 1, 1);
    }
  } else {
    self._id_0FFA = undefined;
    var_4 = animscripts\utility::_id_0FFC(self getmotionangle());

    if(isDefined(self._id_0FF5)) {
      var_4["back"] = 0.0;

      if(var_4["front"] < 0.2) {
        var_4["front"] = 0.2;
      }
    }

    self setanim(var_0, var_4["front"], 0.2, 1, 1);
    self setanim(var_1, var_4["back"], 0.2, 1, 1);
    self setanim(var_2, var_4["left"], 0.2, 1, 1);
    self setanim(var_3, var_4["right"], 0.2, 1, 1);
  }
}

_id_0FFD() {
  var_0 = isDefined(self._id_0FFE) && self._id_0FFE;
  var_1 = animscripts\utility::_id_0CEA(self.weapon);

  if(var_0 == var_1) {
    return 0;

  }
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536) {
    return 0;

  }
  if(animscripts\utility::_id_0C95()) {
    return 0;

  }
  if(self.weapon == self.primaryweapon) {
    if(!var_0) {
      return 0;

    }
    if(animscripts\utility::_id_0CEA(self.secondaryweapon)) {
      return 0;
    }
  } else {
    if(var_0) {
      return 0;

    }
    if(animscripts\utility::_id_0CEA(self.primaryweapon)) {
      return 0;
    }
  }

  var_2 = angleclamp180(self getmotionangle());

  if(abs(var_2) > 25) {
    return 0;

  }
  if(!_id_0FF6()) {
    return 0;

  }
  if(var_0) {
    _id_1000("shotgunPullout", % shotgun_cqbrun_pullout, "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
  } else {
    _id_1000("shotgunPutaway", % shotgun_cqbrun_putaway, "gun_2_back", "back", self.primaryweapon, "shotgun_pickup");

  }
  self notify("switchEnded");
  return 1;
}

_id_1000(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("movemode");
  self setflaggedanimknoballrestart(var_0, var_1, % body, 1, 0.25);
  self._id_0FF5 = 1;
  _id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));
  thread _id_0FF8("run");
  thread _id_1003(var_0, var_2, var_3, var_4, var_5);
  animscripts\notetracks::_id_1001(getanimlength(var_1) - 0.25, var_0, ::_id_1002);
  self._id_0FF5 = undefined;
}

_id_1002(var_0) {
  if(var_0 == "gun_2_chest" || var_0 == "gun_2_back") {
    return 1;
  }
}

_id_1003(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("movemode");
  self endon("switchEnded");
  self waittillmatch(var_0, var_1);
  animscripts\shared::_id_0C9B(self.weapon, var_2);
  thread _id_1004(var_3);
  self waittillmatch(var_0, var_4);
  self notify("complete_weapon_switch");
}

_id_1004(var_0) {
  self endon("death");
  common_scripts\utility::waittill_any("killanimscript", "movemode", "switchEnded", "complete_weapon_switch");
  self._id_1005 = self.weapon;
  animscripts\shared::_id_0C9B(var_0, "right");
  self._id_0CD1 = weaponclipsize(self.weapon);
}