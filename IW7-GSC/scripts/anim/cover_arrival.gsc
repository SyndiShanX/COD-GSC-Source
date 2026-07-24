/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_arrival.gsc
******************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  self endon("abort_approach");

  if(isDefined(self._id_4C7E)) {
    [[self._id_4C7E]]();
    return;
  }

  var_0 = self._id_20F0;
  var_1 = scripts\anim\utility::_id_B027("cover_trans", self._id_20F2)[var_0];

  if(!isDefined(self.heat)) {
    thread _id_1524();
  }

  self clearanim(%body, 0.2);
  self _meth_82EA("coverArrival", var_1, 1, 0.2, self._id_BD22);
  scripts\anim\face::playfacialanim(var_1, "run");
  scripts\anim\shared::donotetracks("coverArrival", ::_id_89EA);
  var_2 = anim._id_22E7[self._id_20F2];

  if(isDefined(var_2)) {
    self.a.pose = var_2;
  }

  self.a.movement = "stop";
  self.a._id_22F5 = self._id_20F2;
  self clearanim(%root, 0.3);
  self._id_A93C = undefined;
}

_id_89EA(var_0) {
  if(var_0 == "start_aim") {
    if(self.a.pose == "stand") {
      scripts\anim\animset::_id_F2BE();
    } else if(self.a.pose == "crouch") {
      scripts\anim\animset::_id_F2B6();
    } else {}

    scripts\anim\combat::_id_F296();
    self._id_D8AF = 0.0;
    scripts\anim\combat_utility::_id_FA8C(0);
    thread scripts\anim\track::_id_11B07();
  }
}

_id_9FA5() {
  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.enemy) && self seerecently(self.enemy, 1.5) && distancesquared(self.origin, self.enemy.origin) < 250000) {
    return !self _meth_8199();
  }

  return 0;
}

_id_1524() {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node)) {
      return;
    }
    if(_id_9FA5()) {
      self clearanim(%root, 0.3);
      self notify("abort_approach");
      self._id_A93C = gettime();
      return;
    }

    wait 0.1;
  }
}

_id_393C(var_0) {
  if(!scripts\anim\utility_common::usingmg()) {
    return 0;
  }

  if(!isDefined(var_0._id_12A72)) {
    return 0;
  }

  if(var_0.type != "Cover Stand" && var_0.type != "Cover Prone" && var_0.type != "Cover Crouch") {
    return 0;
  }

  if(isDefined(self.enemy) && distancesquared(self.enemy.origin, var_0.origin) < 65536) {
    return 0;
  }

  if(scripts\anim\utility_common::getnodeyawtoenemy() > 40 || scripts\anim\utility_common::getnodeyawtoenemy() < -40) {
    return 0;
  }

  return 1;
}

_id_53C6(var_0) {
  var_1 = var_0.type;

  if(_id_393C(var_0)) {
    if(var_1 == "Cover Stand") {
      return "stand_saw";
    }

    if(var_1 == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_1 == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(anim._id_20EB[var_1])) {
    return;
  }
  if(isDefined(var_0._id_22EF)) {
    var_2 = var_0._id_22EF;
  } else {
    var_2 = var_0 gethighestnodestance();
  }

  if(var_2 == "prone") {
    var_2 = "crouch";
  }

  var_3 = anim._id_20EB[var_1][var_2];

  if(_id_130C9() && var_3 == "exposed") {
    var_3 = "exposed_ready";
  }

  if(scripts\anim\utility::_id_FFDB()) {
    var_4 = var_3 + "_cqb";

    if(isDefined(anim.archetypes["soldier"]["cover_trans"][var_4])) {
      var_3 = var_4;
    }
  }

  return var_3;
}

_id_53C4(var_0) {
  if(isDefined(self.heat)) {
    return "heat";
  }

  if(isDefined(var_0._id_22EF)) {
    var_1 = var_0._id_22EF;
  } else {
    var_1 = var_0 gethighestnodestance();
  }

  if(var_1 == "prone") {
    var_1 = "crouch";
  }

  if(var_1 == "crouch") {
    var_2 = "exposed_crouch";
  } else {
    var_2 = "exposed";
  }

  if(var_2 == "exposed" && _id_130C9()) {
    var_2 = var_2 + "_ready";
  }

  if(scripts\anim\utility::_id_FFDB()) {
    return var_2 + "_cqb";
  }

  return var_2;
}

_id_3719(var_0, var_1) {
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  return var_3 * var_1[0] + var_2 * (0 - var_1[1]);
}

_id_7DCB() {
  if(isDefined(self.scriptedarrivalent)) {
    return self.scriptedarrivalent;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  return undefined;
}

_id_7DCC(var_0, var_1) {
  if(var_1 == "stand_saw") {
    var_2 = (var_0._id_12A72.origin[0], var_0._id_12A72.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "crouch_saw") {
    var_2 = (var_0._id_12A72.origin[0], var_0._id_12A72.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "prone_saw") {
    var_2 = (var_0._id_12A72.origin[0], var_0._id_12A72.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -37.36 - var_4 * 13.279;
  } else if(isDefined(self.scriptedarrivalent))
    var_2 = self.goalpos;
  else {
    var_2 = var_0.origin;
  }

  return var_2;
}

_id_3DED() {
  if(isDefined(self _meth_8148())) {
    return 0;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  return 1;
}

_id_3DEC(var_0, var_1, var_2) {
  if(isDefined(anim._id_6A1B[var_0])) {
    return 0;
  }

  if(var_0 == "stand" || var_0 == "crouch") {
    if(scripts\engine\utility::absangleclamp180(vectortoyaw(var_1) - var_2.angles[1] + 180) < 60) {
      return 0;
    }
  }

  if(_id_9FA5() || isDefined(self._id_A93C) && self._id_A93C + 500 > gettime()) {
    return 0;
  }

  return 1;
}

_id_FA90(var_0) {
  self endon("killanimscript");

  if(isDefined(self.heat)) {
    thread _id_58E7();
    return;
  }

  if(var_0) {
    self.requestarrivalnotify = 1;
  }

  self.a._id_22F5 = undefined;
  thread _id_58E7();
  self waittill("cover_approach", var_1);

  if(!_id_3DED()) {
    return;
  }
  thread _id_FA90(0);
  var_2 = "exposed";
  var_3 = self.pathgoalpos;
  var_4 = vectortoyaw(var_1);
  var_5 = var_4;
  var_6 = _id_7DCB();

  if(isDefined(var_6)) {
    var_2 = _id_53C6(var_6);

    if(isDefined(var_2) && var_2 != "exposed") {
      var_3 = _id_7DCC(var_6, var_2);
      var_4 = var_6.angles[1];
      var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_6);
    }
  } else if(_id_130C9()) {
    if(scripts\anim\utility::_id_FFDB()) {
      var_2 = "exposed_ready_cqb";
    } else {
      var_2 = "exposed_ready";
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!_id_3DEC(var_2, var_1, var_6)) {
    return;
  }
  _id_10D80(var_2, var_3, var_4, var_5, var_1);
}

_id_4710(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(abs(self _meth_813E()) > 45 && isDefined(self.enemy) && vectordot(anglesToForward(self.angles), vectorNormalize(self.enemy.origin - self.origin)) > 0.8) {
    return 0;
  }

  if(self.a.pose != "stand" || self.a.movement != "run" && !scripts\anim\utility::_id_9D9C()) {
    return 0;
  }

  if(scripts\engine\utility::absangleclamp180(var_4 - self.angles[1]) > 30) {
    if(isDefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536) {
      if(vectordot(anglesToForward(self.angles), self.enemy.origin - self.origin) > 0) {
        return 0;
      }
    }
  }

  if(!_id_3E00(var_0, var_1, var_2, var_3, 0)) {
    return 0;
  }

  return 1;
}

_id_20F4(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      _id_136CD();
    }

    var_2 = distance(self.origin, self.pathgoalpos);

    if(var_2 <= var_1 + 8) {
      break;
    }

    var_3 = (var_2 - var_1) / 250 - 0.1;

    if(var_3 < 0.05) {
      var_3 = 0.05;
    }

    wait(var_3);
  }
}

_id_10D80(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("cover_approach");
  var_5 = _id_7DCB();
  var_6 = scripts\anim\exit_node::getmaxdamage(var_5);
  var_7 = var_6._id_B490;
  var_8 = var_6._id_68CA;
  var_9 = vectordot(var_4, anglesToForward(var_5.angles)) >= 0;
  var_6 = _id_3DEE(var_1, var_3, var_0, var_4, var_7, var_8, var_9);

  if(var_6._id_20F0 < 0) {
    return;
  }
  var_10 = var_6._id_20F0;

  if(var_10 <= 6 && var_9) {
    self endon("goal_changed");
    self._id_22F0 = anim._id_4754[var_0];
    _id_20F4(var_5, self._id_22F0);
    var_11 = vectorNormalize(var_1 - self.origin);
    var_6 = _id_3DEE(var_1, var_3, var_0, var_11, var_7, var_8, var_9);
    self._id_22F0 = length(scripts\anim\utility::_id_B031("cover_trans_dist", var_0, var_10));
    _id_20F4(var_5, self._id_22F0);

    if(!self maymovetopoint(var_1)) {
      self._id_22F0 = undefined;
      return;
    }

    if(var_6._id_20F0 < 0) {
      self._id_22F0 = undefined;
      return;
    }

    var_10 = var_6._id_20F0;
    var_12 = var_3 - scripts\anim\utility::_id_B031("cover_trans_angles", var_0, var_10);
  } else {
    self _meth_8331(self._id_4718);
    self waittill("runto_arrived");
    var_12 = var_3 - scripts\anim\utility::_id_B031("cover_trans_angles", var_0, var_10);

    if(!_id_4710(var_1, var_3, var_0, var_10, var_12)) {
      return;
    }
  }

  self._id_20F0 = var_10;
  self._id_20F2 = var_0;
  self._id_22F0 = undefined;
  self _meth_8396(self._id_4718, var_12);
}

_id_3DEE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  scripts\anim\exit_node::_id_371A(var_7, var_2, 1, var_1, var_3, var_4, var_5);
  scripts\anim\exit_node::_id_1043F(var_7, var_4);
  var_8 = spawnStruct();
  var_9 = (0, 0, 0);
  var_8._id_20F0 = -1;
  var_10 = 2;

  for(var_11 = 1; var_11 <= var_10; var_11++) {
    var_8._id_20F0 = var_7._id_12654[var_11];

    if(!_id_3E00(var_0, var_1, var_2, var_8._id_20F0, var_6)) {
      continue;
    }
    break;
  }

  if(var_11 > var_10) {
    var_8._id_20F0 = -1;
    return var_8;
  }

  var_12 = distancesquared(var_0, self.origin);
  var_13 = distancesquared(var_0, self._id_4718);

  if(var_12 < var_13 * 2 * 2) {
    if(var_12 < var_13) {
      var_8._id_20F0 = -1;
      return var_8;
    }

    if(!var_6) {
      var_14 = vectorNormalize(self._id_4718 - self.origin);
      var_15 = var_1 - scripts\anim\utility::_id_B031("cover_trans_angles", var_2, var_8._id_20F0);
      var_16 = anglesToForward((0, var_15, 0));
      var_17 = vectordot(var_14, var_16);

      if(var_17 < 0.707) {
        var_8._id_20F0 = -1;
        return var_8;
      }
    }
  }

  return var_8;
}

_id_58E7() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  thread _id_13A8F();

  for(;;) {
    _id_58E6();

    for(;;) {
      scripts\engine\utility::waittill_any("goal_changed", "goal_changed_previous_frame");

      if(isDefined(self._id_4718) && isDefined(self.pathgoalpos) && distance2d(self._id_4718, self.pathgoalpos) < 1) {
        continue;
      }
      break;
    }
  }
}

_id_13A8F() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");

  for(;;) {
    self waittill("goal_changed");
    wait 0.05;
    self notify("goal_changed_previous_frame");
  }
}

_id_6A0E(var_0, var_1) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self._id_20ED)) {
    if(!self[[self._id_20ED]](var_0)) {
      return 0;
    }
  } else {
    if(!self.facemotion && (!isDefined(var_0) || var_0.type == "Path" || var_0.type == "Path 3D")) {
      return 0;
    }

    if(self.a.pose != "stand") {
      return 0;
    }
  }

  if(_id_9FA5() || isDefined(self._id_A93C) && self._id_A93C + 500 > gettime()) {
    return 0;
  }

  if(!self maymovetopoint(self.pathgoalpos)) {
    return 0;
  }

  return 1;
}

_id_6A0F() {
  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      _id_136CD();
    }

    var_0 = _id_7DCB();

    if(isDefined(var_0) && !isDefined(self.heat)) {
      var_1 = var_0.origin;
    } else {
      var_1 = self.pathgoalpos;
    }

    var_2 = distance(self.origin, var_1);
    var_3 = anim._id_AFE8;

    if(var_2 <= var_3 + 8) {
      break;
    }

    var_4 = (var_2 - anim._id_AFE8) / 250 - 0.1;

    if(var_4 < 0) {
      break;
    }

    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    wait(var_4);
  }
}

_id_6A6D(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(isDefined(self.heat) && isDefined(var_0)) {
    return 0;
  }

  if(self.combatmode == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000) {
    return 0;
  }

  return sighttracepassed(self.enemy getshootatpos(), self.pathgoalpos + (0, 0, 60), 0, undefined);
}

_id_58E6() {
  self endon("goal_changed");
  self endon("move_interrupt");

  if(isDefined(self _meth_8148())) {
    return;
  }
  _id_6A0F();

  if(isDefined(self.grenade) && isDefined(self.grenade.activator) && self.grenade.activator == self) {
    return;
  }
  var_0 = "exposed";
  var_1 = 1;

  if(isDefined(self._id_20F3)) {
    var_0 = self[[self._id_20F3]]();
  } else if(_id_130C9()) {
    if(scripts\anim\utility::_id_FFDB()) {
      var_0 = "exposed_ready_cqb";
    } else {
      var_0 = "exposed_ready";
    }
  } else if(scripts\anim\utility::_id_FFDB())
    var_0 = "exposed_cqb";
  else if(isDefined(self.heat)) {
    var_0 = "heat";
    var_1 = 4096;
  }

  var_2 = _id_7DCB();

  if(isDefined(var_2) && isDefined(self.pathgoalpos) && !isDefined(self.disablecollision)) {
    var_3 = distancesquared(self.pathgoalpos, var_2.origin) < var_1;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    var_0 = _id_53C4(var_2);
  }

  var_4 = vectorNormalize(self.pathgoalpos - self.origin);
  var_5 = vectortoyaw(var_4);

  if(isDefined(self._id_6A6C)) {
    var_5 = self.angles[1];
  } else if(_id_6A6D(var_2)) {
    var_5 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
  } else {
    var_6 = isDefined(var_2) && var_3;
    var_6 = var_6 && var_2.type != "Path" && var_2.type != "Path 3D" && (var_2.type != "Ambush" || !scripts\anim\utility_common::recentlysawenemy());

    if(var_6) {
      var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_2);
    } else {
      var_7 = self _meth_80FC();

      if(isDefined(var_7)) {
        var_5 = var_7[1];
      }
    }
  }

  var_8 = spawnStruct();
  scripts\anim\exit_node::_id_371A(var_8, var_0, 1, var_5, var_4, 9, -1);
  var_9 = 1;

  for(var_10 = 2; var_10 <= 9; var_10++) {
    if(var_8.transitions[var_10] > var_8.transitions[var_9]) {
      var_9 = var_10;
    }
  }

  self._id_20F0 = var_8._id_12654[var_9];
  self._id_20F2 = var_0;
  var_11 = scripts\anim\utility::_id_B031("cover_trans", var_0, self._id_20F0);
  var_12 = length(scripts\anim\utility::_id_B031("cover_trans_dist", var_0, self._id_20F0));
  var_13 = var_12 + 8;
  var_13 = var_13 * var_13;

  while(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > var_13) {
    wait 0.05;
  }

  if(isDefined(self._id_22F0) && self._id_22F0 < var_12 + 8) {
    return;
  }
  if(!_id_6A0E(var_2, var_3)) {
    return;
  }
  var_14 = distance(self.origin, self.pathgoalpos);

  if(abs(var_14 - var_12) > 8) {
    return;
  }
  var_15 = vectortoyaw(self.pathgoalpos - self.origin);

  if(isDefined(self.heat) && var_3) {
    var_16 = var_5 - scripts\anim\utility::_id_B031("cover_trans_angles", var_0, self._id_20F0);
    var_17 = _id_7DD9(self.pathgoalpos, var_5, var_0, self._id_20F0);
  } else if(var_12 > 0) {
    var_18 = scripts\anim\utility::_id_B031("cover_trans_dist", var_0, self._id_20F0);
    var_19 = atan(var_18[1] / var_18[0]);

    if(!isDefined(self._id_6A6C) || self.facemotion) {
      var_16 = var_15 - var_19;

      if(scripts\engine\utility::absangleclamp180(var_16 - self.angles[1]) > 30) {
        return;
      }
    } else
      var_16 = self.angles[1];

    var_20 = var_14 - var_12;
    var_17 = self.origin + vectorNormalize(self.pathgoalpos - self.origin) * var_20;
  } else {
    var_16 = self.angles[1];
    var_17 = self.origin;
  }

  self _meth_8396(var_17, var_16);
}

_id_136CD() {
  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      return;
    }
    wait 0.1;
  }
}

custommovetransitionfunc() {
  if(!isDefined(self._id_10DCB)) {
    return;
  }
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self _meth_82E4("move", self._id_10DCB, %root, 1);
  scripts\anim\face::playfacialanim(self._id_10DCB, "run");

  if(animhasnotetrack(self._id_10DCB, "code_move")) {
    scripts\anim\shared::donotetracks("move");
    self orientmode("face motion");
    self animmode("none", 0);
  }

  scripts\anim\shared::donotetracks("move");
}

_id_110CC(var_0) {
  if(!isDefined(var_0)) {
    return "{undefined}";
  }

  return var_0;
}

_id_5B8D(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_2 * 100; var_4++) {
    wait 0.05;
  }
}

_id_5B6C(var_0) {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node)) {
      break;
    }

    wait 0.05;
  }
}

_id_7DD9(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - scripts\anim\utility::_id_B031("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = scripts\anim\utility::_id_B031("cover_trans_dist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

_id_7DD8(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - scripts\anim\utility::_id_B031("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = scripts\anim\utility::_id_B031("cover_trans_predist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

_id_3E00(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_7DD9(var_0, var_1, var_2, var_3);
  self._id_4718 = var_5;

  if(var_3 <= 6 && var_4) {
    return 1;
  }

  if(!self maymovefrompointtopoint(var_5, var_0)) {
    return 0;
  }

  if(var_3 <= 6 || isDefined(anim._id_6A1B[var_2])) {
    return 1;
  }

  var_6 = _id_7DD8(var_5, var_1, var_2, var_3);
  self._id_4718 = var_6;
  return self maymovefrompointtopoint(var_6, var_5);
}

_id_130C9() {
  if(!isDefined(anim._id_DD79)) {
    return 0;
  }

  if(!anim._id_DD79) {
    return 0;
  }

  if(!isDefined(self._id_32D4)) {
    return 0;
  }

  if(!self._id_32D4) {
    return 0;
  }

  return 1;
}

_id_4EAC() {
  return 0;
}

_id_4EAB(var_0) {
  if(!_id_4EAC()) {
    return;
  }
}