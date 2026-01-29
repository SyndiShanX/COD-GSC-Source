/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_arrival.gsc
*****************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  self endon("abort_approach");
  var_0 = self._id_1162;
  var_1 = anim._id_1164[self._id_1163][var_0];

  if(!isDefined(self._id_0C96)) {
    thread _id_116A();

  }
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("coverArrival", var_1, 1, 0.2, self._id_1165);
  animscripts\shared::_id_0C51("coverArrival", ::_id_1168);
  var_2 = anim._id_1166[self._id_1163];

  if(isDefined(var_2)) {
    self.a._id_0D26 = var_2;

  }
  self.a._id_0D2B = "stop";
  self.a._id_10DF = self._id_1163;
  self clearanim( % root, 0.3);
  self._id_1167 = undefined;
}

_id_1168(var_0) {
  if(var_0 == "start_aim") {
    if(self.a._id_0D26 == "stand") {
      animscripts\animset::_id_0C94();
    } else if(self.a._id_0D26 == "crouch") {
      animscripts\animset::_id_0C99();
    } else {}

    animscripts\combat::_id_110E();
    self._id_110A = 0.0;
    animscripts\combat_utility::_id_110B(0);
    thread animscripts\track::_id_0CA9();
  }
}

_id_1169() {
  if(!isDefined(self.node)) {
    return 0;

  }
  if(isDefined(self.enemy) && self seerecently(self.enemy, 1.5) && distancesquared(self.origin, self.enemy.origin) < 250000) {
    return !self iscovervalidagainstenemy();

  }
  return 0;
}

_id_116A() {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node)) {
      return;
    }
    if(_id_1169()) {
      self clearanim( % root, 0.3);
      self notify("abort_approach");
      self._id_1167 = gettime();
      return;
    }

    wait 0.1;
  }
}

_id_116B(var_0) {
  if(isDefined(self._id_0C96)) {
    return 0;

  }
  if(var_0 == "left" || var_0 == "left_crouch") {
    return 90.0;
  } else if(var_0 == "right" || var_0 == "right_crouch") {
    return -90.0;

  }
  return 0;
}

_id_116C(var_0) {
  if(!animscripts\utility::_id_0F79()) {
    return 0;

  }
  if(!isDefined(var_0._id_0F7A)) {
    return 0;

  }
  if(var_0.type != "Cover Stand" && var_0.type != "Cover Prone" && var_0.type != "Cover Crouch") {
    return 0;

  }
  if(isDefined(self.enemy) && distancesquared(self.enemy.origin, var_0.origin) < 65536) {
    return 0;

  }
  if(animscripts\utility::_id_116D() > 40 || animscripts\utility::_id_116D() < -40) {
    return 0;

  }
  return 1;
}

_id_116E(var_0) {
  if(_id_116C(var_0)) {
    if(var_0.type == "Cover Stand") {
      return "stand_saw";

    }
    if(var_0.type == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_0.type == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(anim._id_116F[var_0.type])) {
    return;
  }
  if(isDefined(var_0._id_1170)) {
    var_1 = var_0._id_1170;
  } else {
    var_1 = var_0 gethighestnodestance();

  }
  if(var_1 == "prone") {
    var_1 = "crouch";

  }
  var_2 = anim._id_116F[var_0.type][var_1];

  if(_id_11B2() && var_2 == "exposed") {
    var_2 = "exposed_ready";

  }
  if(animscripts\utility::_id_0CB2()) {
    var_3 = var_2 + "_cqb";

    if(isDefined(anim._id_1164[var_3])) {
      var_2 = var_3;
    }
  }

  return var_2;
}

_id_1171(var_0) {
  if(_id_116C(var_0)) {
    if(var_0.type == "Cover Stand") {
      return "stand_saw";

    }
    if(var_0.type == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_0.type == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(anim._id_116F[var_0.type])) {
    return;
  }
  if(isDefined(anim._id_1172[var_0.type]) && anim._id_1172[var_0.type] != self.a._id_0D26) {
    return;
  }
  var_1 = self.a._id_0D26;

  if(var_1 == "prone") {
    var_1 = "crouch";

  }
  var_2 = anim._id_116F[var_0.type][var_1];

  if(_id_11B2() && var_2 == "exposed") {
    var_2 = "exposed_ready";

  }
  if(animscripts\utility::_id_0CB2()) {
    var_3 = var_2 + "_cqb";

    if(isDefined(anim._id_1173[var_3])) {
      var_2 = var_3;
    }
  }

  return var_2;
}

_id_1174(var_0) {
  if(isDefined(self._id_0C96)) {
    return "heat";

  }
  if(isDefined(var_0._id_1170)) {
    var_1 = var_0._id_1170;
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
  if(var_2 == "exposed" && _id_11B2()) {
    var_2 = var_2 + "_ready";

  }
  if(animscripts\utility::_id_0CB2()) {
    return var_2 + "_cqb";

  }
  return var_2;
}

_id_1175(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0) && isDefined(anim._id_1176[var_0.type])) {
    var_1._id_1176 = anim._id_1176[var_0.type];
    var_1._id_1177 = anim._id_1177[var_0.type];
  } else {
    var_1._id_1176 = 9;
    var_1._id_1177 = -1;
  }

  return var_1;
}

_id_1178(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(animscripts\combat_utility::_id_0F08(0.5)) {
    return 0;

  }
  if(animscripts\utility::_id_0F4C()) {
    return 0;

  }
  if(isDefined(anim._id_1179[var_0])) {
    return 0;

  }
  if(var_0 == "left_crouch" || var_0 == "right_crouch") {
    return 0;

  }
  return animscripts\utility::_id_117A(self.enemy getshootatpos(), self.node);
}

_id_117B(var_0, var_1) {
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  return var_3 * var_1[0] + var_2 * (0 - var_1[1]);
}

_id_117C() {
  if(isDefined(self.scriptedarrivalent)) {
    return self.scriptedarrivalent;

  }
  if(isDefined(self.node)) {
    return self.node;

  }
  return undefined;
}

_id_117D(var_0, var_1) {
  if(var_1 == "stand_saw") {
    var_2 = (var_0._id_0F7A.origin[0], var_0._id_0F7A.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_0F7A.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_0F7A.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "crouch_saw") {
    var_2 = (var_0._id_0F7A.origin[0], var_0._id_0F7A.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_0F7A.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_0F7A.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "prone_saw") {
    var_2 = (var_0._id_0F7A.origin[0], var_0._id_0F7A.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0._id_0F7A.angles[1], 0));
    var_4 = anglestoright((0, var_0._id_0F7A.angles[1], 0));
    var_2 = var_2 + var_3 * -37.36 - var_4 * 13.279;
  } else if(isDefined(self.scriptedarrivalent)) {
    var_2 = self.goalpos;
  } else {
    var_2 = var_0.origin;

  }
  return var_2;
}

_id_117E() {
  if(isDefined(self getnegotiationstartnode())) {
    return 0;

  }
  if(isDefined(self._id_117F) && self._id_117F) {
    return 0;

  }
  return 1;
}

_id_1180(var_0, var_1, var_2) {
  if(isDefined(anim._id_1179[var_0])) {
    return 0;

  }
  if(var_0 == "stand" || var_0 == "crouch") {
    if(animscripts\utility::_id_0D61(vectortoyaw(var_1) - var_2.angles[1] + 180) < 60) {
      return 0;
    }
  }

  if(_id_1169() || isDefined(self._id_1167) && self._id_1167 + 500 > gettime()) {
    return 0;

  }
  return 1;
}

_id_10A9(var_0) {
  self endon("killanimscript");

  if(isDefined(self._id_0C96)) {
    thread _id_118B();
    return;
  }

  if(var_0) {
    self.requestarrivalnotify = 1;

  }
  self.a._id_10DF = undefined;
  thread _id_118B();
  self waittill("cover_approach", var_1);

  if(!_id_117E()) {
    return;
  }
  thread _id_10A9(0);
  var_2 = "exposed";
  var_3 = self.pathgoalpos;
  var_4 = vectortoyaw(var_1);
  var_5 = var_4;
  var_6 = _id_117C();

  if(isDefined(var_6)) {
    var_2 = _id_116E(var_6);

    if(isDefined(var_2) && var_2 != "exposed") {
      var_3 = _id_117D(var_6, var_2);
      var_4 = var_6.angles[1];
      var_5 = animscripts\utility::_id_0F41(var_6);
    }
  } else if(_id_11B2()) {
    if(animscripts\utility::_id_0CB2()) {
      var_2 = "exposed_ready_cqb";
    } else {
      var_2 = "exposed_ready";
    }
  }

  if(!_id_1180(var_2, var_1, var_6)) {
    return;
  }
  _id_1183(var_2, var_3, var_4, var_5, var_1);
}

_id_1181(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_117F) && self._id_117F) {
    return 0;

  }
  if(abs(self getmotionangle()) > 45 && isDefined(self.enemy) && vectordot(anglesToForward(self.angles), vectornormalize(self.enemy.origin - self.origin)) > 0.8) {
    return 0;

  }
  if(self.a._id_0D26 != "stand" || self.a._id_0D2B != "run" && !animscripts\utility::_id_10B9()) {
    return 0;

  }
  if(animscripts\utility::_id_0D61(var_4 - self.angles[1]) > 30) {
    if(isDefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536) {
      if(vectordot(anglesToForward(self.angles), self.enemy.origin - self.origin) > 0) {
        return 0;
      }
    }
  }

  if(!_id_11B1(var_0, var_1, var_2, var_3, 0)) {
    return 0;

  }
  return 1;
}

_id_1182(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      _id_1197();

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

_id_1183(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("cover_approach");
  var_5 = _id_117C();
  var_6 = _id_1175(var_5);
  var_7 = var_6._id_1176;
  var_8 = var_6._id_1177;
  var_9 = vectordot(var_4, anglesToForward(var_5.angles)) >= 0;
  var_6 = _id_1189(var_1, var_3, var_0, var_4, var_7, var_8, var_9);

  if(var_6._id_1162 < 0) {
    return;
  }
  var_10 = var_6._id_1162;

  if(level._id_1184 && var_10 <= 6 && var_9) {
    self endon("goal_changed");
    self._id_10AD = anim._id_1185[var_0];
    _id_1182(var_5, self._id_10AD);
    var_11 = vectornormalize(var_1 - self.origin);
    var_6 = _id_1189(var_1, var_3, var_0, var_11, var_7, var_8, var_9);
    self._id_10AD = length(anim._id_1186[var_0][var_10]);
    _id_1182(var_5, self._id_10AD);

    if(!self maymovetopoint(var_1)) {
      self._id_10AD = undefined;
      return;
    }

    if(var_6._id_1162 < 0) {
      self._id_10AD = undefined;
      return;
    }

    var_10 = var_6._id_1162;
    var_12 = var_3 - anim._id_1187[var_0][var_10];
  } else {
    self setruntopos(self._id_1188);
    self waittill("runto_arrived");
    var_12 = var_3 - anim._id_1187[var_0][var_10];

    if(!_id_1181(var_1, var_3, var_0, var_10, var_12)) {
      return;
    }
  }

  self._id_1162 = var_10;
  self._id_1163 = var_0;
  self._id_10AD = undefined;
  self startcoverarrival(self._id_1188, var_12);
}

_id_1189(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  _id_11A8(var_7, var_2, 1, var_1, var_3, var_4, var_5);
  _id_11AA(var_7, var_4);
  var_8 = spawnStruct();
  var_9 = (0, 0, 0);
  var_8._id_1162 = -1;
  var_10 = 2;

  for(var_11 = 1; var_11 <= var_10; var_11++) {
    var_8._id_1162 = var_7._id_118A[var_11];

    if(!_id_11B1(var_0, var_1, var_2, var_8._id_1162, var_6)) {
      continue;
    }
    break;
  }

  if(var_11 > var_10) {
    var_8._id_1162 = -1;
    return var_8;
  }

  var_12 = distancesquared(var_0, self.origin);
  var_13 = distancesquared(var_0, self._id_1188);

  if(var_12 < var_13 * 2 * 2) {
    if(var_12 < var_13) {
      var_8._id_1162 = -1;
      return var_8;
    }

    if(!level._id_1184 || !var_6) {
      var_14 = vectornormalize(self._id_1188 - self.origin);
      var_15 = var_1 - anim._id_1187[var_2][var_8._id_1162];
      var_16 = anglesToForward((0, var_15, 0));
      var_17 = vectordot(var_14, var_16);

      if(var_17 < 0.707) {
        var_8._id_1162 = -1;
        return var_8;
      }
    }
  }

  return var_8;
}

_id_118B() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  thread _id_118C();

  for(;;) {
    _id_1192();

    for(;;) {
      common_scripts\utility::waittill_any("goal_changed", "goal_changed_previous_frame");

      if(isDefined(self._id_1188) && isDefined(self.pathgoalpos) && distance2d(self._id_1188, self.pathgoalpos) < 1) {
        continue;
      }
      break;
    }
  }
}

_id_118C() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");

  for(;;) {
    self waittill("goal_changed");
    wait 0.05;
    self notify("goal_changed_previous_frame");
  }
}

_id_118D(var_0, var_1) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;

  }
  if(isDefined(self._id_117F) && self._id_117F) {
    return 0;

  }
  if(isDefined(self._id_118E)) {
    if(!self[[self._id_118E]](var_0)) {
      return 0;
    }
  } else {
    if(!self.facemotion && (!isDefined(var_0) || var_0.type == "Path")) {
      return 0;

    }
    if(self.a._id_0D26 != "stand") {
      return 0;
    }
  }

  if(_id_1169() || isDefined(self._id_1167) && self._id_1167 + 500 > gettime()) {
    return 0;

  }
  if(!self maymovetopoint(self.pathgoalpos)) {
    return 0;

  }
  return 1;
}

_id_118F() {
  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      _id_1197();

    }
    var_0 = _id_117C();

    if(isDefined(var_0) && !isDefined(self._id_0C96)) {
      var_1 = var_0.origin;
    } else {
      var_1 = self.pathgoalpos;

    }
    var_2 = distance(self.origin, var_1);
    var_3 = anim._id_1190;

    if(var_2 <= var_3 + 8) {
      break;
    }

    var_4 = (var_2 - anim._id_1190) / 250 - 0.1;

    if(var_4 < 0) {
      break;
    }

    if(var_4 < 0.05) {
      var_4 = 0.05;

    }
    wait(var_4);
  }
}

_id_1191(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(isDefined(self._id_0C96) && isDefined(var_0)) {
    return 0;

  }
  if(self.combatmode == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000) {
    return 0;

  }
  return sighttracepassed(self.enemy getshootatpos(), self.pathgoalpos + (0, 0, 60), 0, undefined);
}

_id_1192() {
  self endon("goal_changed");
  self endon("move_interrupt");

  if(isDefined(self getnegotiationstartnode())) {
    return;
  }
  _id_118F();

  if(isDefined(self.grenade) && isDefined(self.grenade.activator) && self.grenade.activator == self) {
    return;
  }
  var_0 = "exposed";
  var_1 = 1;

  if(isDefined(self._id_1193)) {
    var_0 = self[[self._id_1193]]();
  } else if(_id_11B2()) {
    if(animscripts\utility::_id_0CB2()) {
      var_0 = "exposed_ready_cqb";
    } else {
      var_0 = "exposed_ready";
    }
  } else if(animscripts\utility::_id_0CB2()) {
    var_0 = "exposed_cqb";
  } else if(isDefined(self._id_0C96)) {
    var_0 = "heat";
    var_1 = 4096;
  }

  var_2 = _id_117C();

  if(isDefined(var_2) && isDefined(self.pathgoalpos) && !isDefined(self._id_1194)) {
    var_3 = distancesquared(self.pathgoalpos, var_2.origin) < var_1;
  } else {
    var_3 = 0;

  }
  if(var_3) {
    var_0 = _id_1174(var_2);

  }
  var_4 = vectornormalize(self.pathgoalpos - self.origin);
  var_5 = vectortoyaw(var_4);

  if(isDefined(self._id_1195)) {
    var_5 = self.angles[1];
  } else if(_id_1191(var_2)) {
    var_5 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
  } else {
    var_6 = isDefined(var_2) && var_3;
    var_6 = var_6 && var_2.type != "Path" && (var_2.type != "Ambush" || !animscripts\utility::_id_0CBC());

    if(var_6) {
      var_5 = animscripts\utility::_id_0F41(var_2);
    } else {
      var_7 = self getanglestolikelyenemypath();

      if(isDefined(var_7)) {
        var_5 = var_7[1];
      }
    }
  }

  var_8 = spawnStruct();
  _id_11A8(var_8, var_0, 1, var_5, var_4, 9, -1);
  var_9 = 1;

  for(var_10 = 2; var_10 <= 9; var_10++) {
    if(var_8._id_1196[var_10] > var_8._id_1196[var_9]) {
      var_9 = var_10;
    }
  }

  self._id_1162 = var_8._id_118A[var_9];
  self._id_1163 = var_0;
  var_11 = anim._id_1164[var_0][self._id_1162];
  var_12 = length(anim._id_1186[var_0][self._id_1162]);
  var_13 = var_12 + 8;
  var_13 = var_13 * var_13;

  while(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > var_13) {
    wait 0.05;

  }
  if(isDefined(self._id_10AD) && self._id_10AD < var_12 + 8) {
    return;
  }
  if(!_id_118D(var_2, var_3)) {
    return;
  }
  var_14 = distance(self.origin, self.pathgoalpos);

  if(abs(var_14 - var_12) > 8) {
    return;
  }
  var_15 = vectortoyaw(self.pathgoalpos - self.origin);

  if(isDefined(self._id_0C96) && var_3) {
    var_16 = var_5 - anim._id_1187[var_0][self._id_1162];
    var_17 = _id_11AE(self.pathgoalpos, var_5, var_0, self._id_1162);
  } else if(var_12 > 0) {
    var_18 = anim._id_1186[var_0][self._id_1162];
    var_19 = atan(var_18[1] / var_18[0]);

    if(!isDefined(self._id_1195) || self.facemotion) {
      var_16 = var_15 - var_19;

      if(animscripts\utility::_id_0D61(var_16 - self.angles[1]) > 30) {
        return;
      }
    } else {
      var_16 = self.angles[1];

    }
    var_20 = var_14 - var_12;
    var_17 = self.origin + vectornormalize(self.pathgoalpos - self.origin) * var_20;
  } else {
    var_16 = self.angles[1];
    var_17 = self.origin;
  }

  self startcoverarrival(var_17, var_16);
}

_id_1197() {
  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      return;
    }
    wait 0.1;
  }
}

_id_1198() {
  if(!isDefined(self.pathgoalpos)) {
    return 0;

  }
  if(!self shouldfacemotion()) {
    return 0;

  }
  if(self.a._id_0D26 == "prone") {
    return 0;

  }
  if(isDefined(self._id_1199) && self._id_1199) {
    return 0;

  }
  if(self.stairsstate != "none") {
    return 0;

  }
  if(!self isstanceallowed("stand") && !isDefined(self._id_0C96)) {
    return 0;

  }
  if(distancesquared(self.origin, self.pathgoalpos) < 10000) {
    return 0;

  }
  return 1;
}

_id_119A(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(var_0 == "exposed" || isDefined(self._id_0C96)) {
    if(self.a._id_0D26 != "stand" && self.a._id_0D26 != "crouch") {
      return 0;

    }
    if(self.a._id_0D2B != "stop") {
      return 0;
    }
  }

  if(!isDefined(self._id_0C96) && isDefined(self.enemy) && vectordot(self.lookaheaddir, self.enemy.origin - self.origin) < 0) {
    if(animscripts\utility::_id_0F4A() && distancesquared(self.origin, self.enemy.origin) < 90000) {
      return 0;
    }
  }

  return 1;
}

_id_119B() {
  var_0 = undefined;

  if(!isDefined(self._id_0C96)) {
    var_1 = 400;
  } else {
    var_1 = 4096;

  }
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
    var_0 = self.node;
  } else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < var_1) {
    var_0 = self.prevnode;

  }
  if(isDefined(var_0) && isDefined(self._id_0C96) && animscripts\utility::_id_0D61(self.angles[1] - var_0.angles[1]) > 30) {
    return undefined;

  }
  return var_0;
}

_id_119C() {
  if(!isDefined(self._id_119D)) {
    return;
  }
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self setflaggedanimknoballrestart("move", self._id_119D, % root, 1);

  if(animhasnotetrack(self._id_119D, "code_move")) {
    animscripts\shared::_id_0C51("move");
    self orientmode("face motion");
    self animmode("none", 0);
  }

  animscripts\shared::_id_0C51("move");
}

_id_119E(var_0) {
  if(self.a._id_0D26 == "stand") {
    var_0 = "exposed";
  } else {
    var_0 = "exposed_crouch";

  }
  if(_id_11B2()) {
    var_0 = "exposed_ready";

  }
  if(animscripts\utility::_id_0CB2()) {
    var_0 = var_0 + "_cqb";
  } else if(isDefined(self._id_0C96)) {
    var_0 = "heat";

  }
  return var_0;
}

_id_119F(var_0, var_1) {
  if(var_0.type == "Cover Right") {
    var_1 = "heat_right";
  } else if(var_0.type == "Cover Left") {
    var_1 = "heat_left";

  }
  return var_1;
}

_id_10A6() {
  if(isDefined(self._id_11A0)) {
    var_0 = self._id_11A0;

    if(!isDefined(self._id_11A1)) {
      self._id_11A0 = undefined;

    }
    [[var_0]]();

    if(!isDefined(self._id_11A1)) {
      self._id_119D = undefined;

    }
    self clearanim( % root, 0.2);
    self orientmode("face default");
    self animmode("none", 0);
    return;
  }

  self endon("killanimscript");

  if(!_id_1198()) {
    return;
  }
  var_1 = self.origin;
  var_2 = self.angles[1];
  var_3 = "exposed";
  var_4 = 0;
  var_5 = _id_119B();

  if(isDefined(var_5)) {
    var_6 = _id_1171(var_5);

    if(isDefined(var_6)) {
      var_3 = var_6;
      var_4 = 1;

      if(isDefined(self._id_0C96)) {
        var_3 = _id_119F(var_5, var_3);

      }
      if(!isDefined(anim._id_1179[var_3]) && var_3 != "stand_saw" && var_3 != "crouch_saw") {
        var_7 = animscripts\utility::_id_0D61(self.angles[1] - animscripts\utility::_id_0F41(var_5));

        if(var_7 < 5) {
          if(!isDefined(self._id_0C96)) {
            var_1 = var_5.origin;

          }
          var_2 = animscripts\utility::_id_0F41(var_5);
        }
      }
    }
  }

  if(!_id_119A(var_3, var_5)) {
    return;
  }
  var_8 = isDefined(anim._id_1179[var_3]);

  if(!var_4) {
    var_3 = _id_119E();

  }
  var_9 = (-1 * self.lookaheaddir[0], -1 * self.lookaheaddir[1], 0);
  var_10 = _id_1175(var_5);
  var_11 = var_10._id_1176;
  var_12 = var_10._id_1177;
  var_13 = spawnStruct();
  _id_11A8(var_13, var_3, 0, var_2, var_9, var_11, var_12);
  _id_11AA(var_13, var_11);
  var_14 = -1;
  var_15 = 3;

  if(var_8) {
    var_15 = 1;

  }
  for(var_16 = 1; var_16 <= var_15; var_16++) {
    var_14 = var_13._id_118A[var_16];

    if(_id_11AB(var_1, var_2, var_3, var_8, var_14)) {
      break;
    }
  }

  if(var_16 > var_15) {
    return;
  }
  var_17 = distancesquared(self.origin, self._id_11A2) * 1.25 * 1.25;

  if(distancesquared(self.origin, self.pathgoalpos) < var_17) {
    return;
  }
  _id_11A4(var_3, var_14);
}

_id_11A3(var_0) {
  if(!isDefined(var_0)) {
    return "{undefined}";

  }
  return var_0;
}

_id_11A4(var_0, var_1) {
  var_2 = anim._id_1173[var_0][var_1];
  var_3 = vectortoangles(self.lookaheaddir);

  if(self.a._id_0D26 == "prone") {
    return;
  }
  var_5 = 0.2;
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  self setflaggedanimknoballrestart("coverexit", var_2, % body, 1, var_5, self._id_1165);
  animscripts\shared::_id_0C51("coverexit");
  self.a._id_0D26 = "stand";
  self.a._id_0D2B = "run";
  self._id_10A8 = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  _id_11A5("coverexit");
  self clearanim( % root, 0.2);
  self orientmode("face default");
  self animmode("normal", 0);
}

_id_11A5(var_0) {
  self endon("move_loop_restart");
  animscripts\shared::_id_0C51(var_0);
}

_id_11A6(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_2 * 100; var_4++) {
    wait 0.05;
  }
}

_id_11A7(var_0) {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node)) {
      break;
    }

    wait 0.05;
  }
}

_id_11A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0._id_1196 = [];
  var_0._id_118A = [];
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;

  if(var_2) {
    var_7 = anim._id_1187[var_1];
    var_8 = -1;
    var_9 = 0;
  } else {
    var_7 = anim._id_11A9[var_1];
    var_8 = 1;
    var_9 = 180;
  }

  for(var_10 = 1; var_10 <= var_5; var_10++) {
    var_0._id_118A[var_10] = var_10;

    if(var_10 == 5 || var_10 == var_6 || !isDefined(var_7[var_10])) {
      var_0._id_1196[var_10] = -1.0003;
      continue;
    }

    var_11 = (0, var_3 + var_8 * var_7[var_10] + var_9, 0);
    var_12 = vectornormalize(anglesToForward(var_11));
    var_0._id_1196[var_10] = vectordot(var_4, var_12);
  }
}

_id_11AA(var_0, var_1) {
  for(var_2 = 2; var_2 <= var_1; var_2++) {
    var_3 = var_0._id_1196[var_0._id_118A[var_2]];
    var_4 = var_0._id_118A[var_2];

    for(var_5 = var_2 - 1; var_5 >= 1; var_5--) {
      if(var_3 < var_0._id_1196[var_0._id_118A[var_5]]) {
        break;
      }

      var_0._id_118A[var_5 + 1] = var_0._id_118A[var_5];
    }

    var_0._id_118A[var_5 + 1] = var_4;
  }
}

_id_11AB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, var_1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = var_6 * anim._id_11AC[var_2][var_4][0];
  var_9 = var_7 * anim._id_11AC[var_2][var_4][1];
  var_10 = var_0 + var_8 - var_9;
  self._id_11A2 = var_10;

  if(!var_3 && !self checkcoverexitposwithpath(var_10)) {
    return 0;

  }
  if(!self maymovefrompointtopoint(self.origin, var_10)) {
    return 0;

  }
  if(var_4 <= 6 || var_3) {
    return 1;

  }
  var_8 = var_6 * anim._id_11AD[var_2][var_4][0];
  var_9 = var_7 * anim._id_11AD[var_2][var_4][1];
  var_11 = var_10 + var_8 - var_9;
  self._id_11A2 = var_11;
  return self maymovefrompointtopoint(var_10, var_11);
}

_id_11AE(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - anim._id_1187[var_2][var_3], 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = var_5 * anim._id_1186[var_2][var_3][0];
  var_8 = var_6 * anim._id_1186[var_2][var_3][1];
  return var_0 - var_7 + var_8;
}

_id_11AF(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - anim._id_1187[var_2][var_3], 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = var_5 * anim._id_11B0[var_2][var_3][0];
  var_8 = var_6 * anim._id_11B0[var_2][var_3][1];
  return var_0 - var_7 + var_8;
}

_id_11B1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_11AE(var_0, var_1, var_2, var_3);
  self._id_1188 = var_5;

  if(level._id_1184 && var_3 <= 6 && var_4) {
    return 1;

  }
  if(!self maymovefrompointtopoint(var_5, var_0)) {
    return 0;

  }
  if(var_3 <= 6 || isDefined(anim._id_1179[var_2])) {
    return 1;

  }
  var_6 = _id_11AF(var_5, var_1, var_2, var_3);
  self._id_1188 = var_6;
  return self maymovefrompointtopoint(var_6, var_5);
}

_id_11B2() {
  if(!isDefined(anim._id_11B3)) {
    return 0;

  }
  if(!anim._id_11B3) {
    return 0;

  }
  if(!isDefined(self._id_10FD)) {
    return 0;

  }
  if(!self._id_10FD) {
    return 0;

  }
  return 1;
}

_id_11B4() {
  return 0;
}

_id_11B5(var_0) {
  if(!_id_11B4()) {
    return;
  }
}