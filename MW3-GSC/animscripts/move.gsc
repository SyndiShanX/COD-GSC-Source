/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\move.gsc
**************************************/

main() {
  if(isDefined(self._id_10A5)) {
    if(isDefined(self._id_10A5["move"])) {
      [[self._id_10A5["move"]]]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.defaultexception["move"]]]();
  _id_10AC();
  _id_10AE();
  animscripts\utility::_id_0D15("move");
  var_0 = _id_10B1();

  if(var_0 && isDefined(self._id_0F74)) {
    _id_10D9();
    _id_10DB();
  } else if(isDefined(self._id_0AAF) && self._id_0AAF) {
    _id_10B2(var_0);
    animscripts\battlechatter::_id_0ABF();
  }

  thread _id_10BD();
  thread _id_1090();
  thread _id_10CB();
  animscripts\cover_arrival::_id_10A6();
  self._id_10A7 = undefined;
  self._id_10A8 = undefined;
  thread _id_10BC();
  thread animscripts\cover_arrival::_id_10A9(1);
  self._id_0FE4 = undefined;
  self._id_0FD2 = undefined;
  self._id_0FC8 = undefined;
  _id_10B3(1);
}

end_script() {
  if(isDefined(self._id_108F)) {
    self.grenadeweapon = self._id_108F;
    self._id_108F = undefined;
  }

  self._id_108B = undefined;
  self._id_108E = undefined;
  self._id_10A8 = undefined;
  self._id_0F74 = undefined;
  self._id_0F75 = undefined;
  self._id_0FC8 = undefined;
  self._id_0FCF = undefined;
  self._id_0FD1 = undefined;
  self._id_10AA = undefined;
  self._id_10AB = undefined;
}

_id_10AC() {
  self._id_0FCF = undefined;
  self._id_0FD1 = undefined;
  self._id_0FC9 = undefined;
  self._id_0FF5 = undefined;
  self._id_0FCB = 0;
  self._id_10AD = undefined;
}

_id_10AE() {
  if(self.a._id_0D26 == "prone") {
    var_0 = animscripts\utility::_id_10AF("stand");

    if(var_0 != "prone") {
      self orientmode("face current");
      self animmode("zonly_physics", 0);
      var_1 = 1;

      if(isDefined(self.grenade)) {
        var_1 = 2;
      }
      animscripts\cover_prone::_id_10B0(var_0, var_1);
      self animmode("none", 0);
      self orientmode("face default");
    }
  }
}

_id_10B1() {
  switch (self.prevscript) {
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "turret":
    case "cover_crouch":
    case "cover_right":
    case "hide":
      return 1;
  }

  return 0;
}

_id_10B2(var_0) {
  if(self.movemode == "run") {
    animscripts\battlechatter_ai::_id_0B2A(var_0);
  }
}

_id_10B3(var_0) {
  _id_10B6(var_0);
  self notify("abort_reload");
}

_id_10B4(var_0) {
  if(var_0 != self._id_10B5) {
    if(isDefined(self._id_0C88) && isDefined(self._id_0C88[var_0])) {
      self.a._id_0CA6 = self._id_0C88[var_0];
    } else {
      self.a._id_0CA6 = anim._id_0C65._id_0C66[var_0];

      if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > squared(100))) {
        self._id_0FE0 = 1;
        animscripts\animset::_id_0CA5();
      } else {
        self._id_0FE0 = 1.35;
      }
    }

    self._id_10B5 = var_0;
  }
}

#using_animtree("generic_human");

_id_10B6(var_0) {
  self endon("killanimscript");
  self endon("move_interrupt");
  var_1 = self getanimtime(%walk_and_run_loops);
  self.a._id_1077 = randomint(10000);
  self._id_10B5 = "none";
  self._id_10B7 = undefined;

  for(;;) {
    var_2 = self getanimtime(%walk_and_run_loops);

    if(var_2 < var_1) {
      self.a._id_1077++;
    }
    var_1 = var_2;
    _id_10B4(self.movemode);
    _id_10B8(self.movemode);

    if(isDefined(self._id_10B7)) {
      self[[self._id_10B7]]();
      self._id_10B7 = undefined;
    }

    self notify("abort_reload");
  }
}

_id_10B8(var_0) {
  self endon("move_loop_restart");
  animscripts\face::_id_0C44(anim._id_0C3D);

  if(isDefined(self._id_10AB)) {
    self[[self._id_10AB]]();
  } else if(animscripts\utility::_id_0CB2()) {
    animscripts\cqb::_id_1075();
  } else if(var_0 == "run") {
    animscripts\run::_id_0FB9();
  } else {
    animscripts\walk::_id_107F();
  }
  self._id_0FD1 = undefined;
}

_id_0FDE() {
  if(self.weapon == "none") {
    return 0;
  }
  var_0 = weaponclass(self.weapon);

  if(!animscripts\utility::_id_0EE3()) {
    return 0;
  }
  if(animscripts\combat_utility::issniper()) {
    if(!animscripts\utility::_id_0C98() && self.facemotion) {
      return 0;
    }
  }

  if(isDefined(self._id_0FF1)) {
    return 0;
  }
  return 1;
}

_id_0FE8() {
  self endon("killanimscript");
  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");

  if(isDefined(self._id_0C82) && isDefined(self._id_0C82["fire"])) {
    self.a._id_0C6D["fire"] = self._id_0C82["fire"];
  } else {
    self.a._id_0C6D["fire"] = % exposed_shoot_auto_v3;
  }
  if(isDefined(self.weapon) && animscripts\utility::_id_0C97()) {
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D(%shotgun_stand_fire_1a, %shotgun_stand_fire_1b);
  } else {
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D(%exposed_shoot_semi1);
  }
  self.a._id_0C6D["burst2"] = % exposed_shoot_burst3;
  self.a._id_0C6D["burst3"] = % exposed_shoot_burst3;
  self.a._id_0C6D["burst4"] = % exposed_shoot_burst4;
  self.a._id_0C6D["burst5"] = % exposed_shoot_burst5;
  self.a._id_0C6D["burst6"] = % exposed_shoot_burst6;
  self.a._id_0C6D["semi2"] = % exposed_shoot_semi2;
  self.a._id_0C6D["semi3"] = % exposed_shoot_semi3;
  self.a._id_0C6D["semi4"] = % exposed_shoot_semi4;
  self.a._id_0C6D["semi5"] = % exposed_shoot_semi5;

  for(;;) {
    if(!self._id_0CD1) {
      if(animscripts\utility::_id_10B9()) {
        self._id_10BA = 0;
        animscripts\combat_utility::_id_10BB();
      }

      if(!self._id_0CD1) {
        wait 0.5;
        continue;
      }
    }

    animscripts\combat_utility::_id_0F06();
    self clearanim(%exposed_aiming, 0.2);
  }
}

_id_10BC() {
  self endon("killanimscript");
  wait 0.05;
  thread _id_10D4();
  thread _id_10D2();
  thread animscripts\door::_id_1096();
  thread animscripts\door::_id_1088();
}

_id_10BD() {
  self endon("killanimscript");
  self._id_10BE = self.stairsstate;

  for(;;) {
    wait 0.05;

    if(self._id_10BE != self.stairsstate) {
      if(!isDefined(self._id_10A8) || self.stairsstate != "none") {
        self notify("move_loop_restart");
      }
    }

    self._id_10BE = self.stairsstate;
  }
}

_id_1091(var_0) {
  self endon("killanimscript");

  if(!var_0) {
    animscripts\cover_arrival::_id_10A6();
  }
  self._id_10A8 = undefined;
  self clearanim(%root, 0.1);
  self orientmode("face default");
  self animmode("none", 0);
  self.requestarrivalnotify = 1;
  _id_10B3(!var_0);
}

_id_1090() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self._id_10A8 = 1;

  for(;;) {
    self waittill("path_changed", var_0, var_1);

    if(isDefined(self._id_10A8) || isDefined(self._id_10BF)) {
      continue;
    }
    if(!self.facemotion || abs(self getmotionangle()) > 15) {
      continue;
    }
    if(self.a._id_0D2B != "run" && self.a._id_0D2B != "walk") {
      continue;
    }
    if(self.a._id_0D26 != "stand") {
      continue;
    }
    self notify("stop_move_anim_update");
    self._id_0FC9 = undefined;
    var_2 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
    var_3 = _id_10C2(var_2);

    if(isDefined(var_3)) {
      self._id_10C0 = var_3;
      self._id_10C1 = gettime();
      self._id_10AB = ::_id_10C5;
      self notify("move_loop_restart");
      animscripts\run::_id_0FE2();
    }
  }
}

_id_10C2(var_0) {
  if(isDefined(self._id_10C3)) {
    return [[self._id_10C3]](var_0);
  }
  var_1 = undefined;
  var_2 = undefined;

  if(animscripts\utility::_id_0CB2() || self.movemode == "walk") {
    var_3 = anim._id_0C9F;
  } else {
    var_3 = anim._id_0C9E;
  }
  if(var_0 < -30) {
    if(var_0 > -60) {
      var_1 = var_3["L45"];
    } else if(var_0 > -112.5) {
      var_1 = var_3["L90"];

      if(var_0 > -90) {
        var_2 = var_3["L45"];
      } else {
        var_2 = var_3["L135"];
      }
    } else if(var_0 > -157.5) {
      var_1 = var_3["L135"];

      if(var_0 > -135) {
        var_2 = var_3["L90"];
      } else {
        var_2 = var_3["180"];
      }
    } else {
      var_1 = var_3["180"];
      var_2 = var_3["L135"];
    }
  } else if(var_0 > 30) {
    if(var_0 < 60) {
      var_1 = var_3["R45"];
    } else if(var_0 < 112.5) {
      var_1 = var_3["R90"];

      if(var_0 < 90) {
        var_2 = var_3["R45"];
      } else {
        var_2 = var_3["R135"];
      }
    } else if(var_0 < 157.5) {
      var_1 = var_3["R135"];

      if(var_0 < 135) {
        var_2 = var_3["R90"];
      } else {
        var_2 = var_3["180"];
      }
    } else {
      var_1 = var_3["180"];
      var_2 = var_3["R135"];
    }
  }

  if(isDefined(var_1)) {
    if(_id_10C4(var_1)) {
      return var_1;
    }
  }

  if(isDefined(var_2)) {
    if(_id_10C4(var_2)) {
      return var_2;
    }
  }

  return undefined;
}

_id_10C4(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }
  var_1 = getnotetracktimes(var_0, "code_move");
  var_2 = var_1[0];
  var_3 = getmovedelta(var_0, 0, var_2);
  var_4 = self localtoworldcoords(var_3);

  if(isDefined(self._id_10AD) && squared(self._id_10AD) > distancesquared(self.pathgoalpos, var_4)) {
    return 0;
  }
  var_3 = getmovedelta(var_0, 0, 1);
  var_5 = self localtoworldcoords(var_3);
  var_5 = var_4 + vectornormalize(var_5 - var_4) * 20;
  return self maymovefrompointtopoint(var_4, var_5, 1, 1);
}

_id_10C5() {
  self endon("killanimscript");
  self._id_10AB = undefined;
  var_0 = self._id_10C0;

  if(gettime() > self._id_10C1 + 50) {
    return;
  }
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.1);
  self._id_10B7 = ::_id_10C8;
  self._id_10A8 = 1;
  var_1 = 0.05;

  if(isDefined(self._id_10C6)) {
    var_1 = isDefined(self._id_10C6);
  }
  self setflaggedanimrestart("turnAnim", var_0, 1, var_1, self._id_0FC6);
  self orientmode("face current");
  animscripts\shared::_id_0C51("turnAnim");
  self._id_10A8 = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  animscripts\shared::_id_0C51("turnAnim");
}

_id_10C7() {
  self._id_10AB = undefined;

  if(gettime() > self._id_10C1 + 50) {
    return;
  }
  self._id_10B7 = ::_id_10C8;
  animscripts\cover_arrival::_id_10A6();
}

_id_10C8() {
  self._id_10A8 = undefined;
  self orientmode("face default");
  self clearanim(%root, 0.1);
  self animmode("none", 0);
}

_id_10C9() {
  self pushplayer(1);
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.2);
  self setflaggedanimrestart("dodgeAnim", self._id_10AA, 1, 0.2, 1);
  animscripts\shared::_id_0C51("dodgeAnim");
  self animmode("none", 0);
  self orientmode("face default");

  if(animhasnotetrack(self._id_10AA, "code_move")) {
    animscripts\shared::_id_0C51("dodgeAnim");
  }
  self clearanim(%civilian_dodge, 0.2);
  self pushplayer(0);
  self._id_10AA = undefined;
  self._id_10AB = undefined;
  return 1;
}

_id_10CA(var_0, var_1) {
  var_2 = (self.lookaheaddir[1], -1 * self.lookaheaddir[0], 0);
  var_3 = self.lookaheaddir * var_1[0];
  var_4 = var_2 * var_1[1];
  var_5 = self.origin + var_3 - var_4;
  self pushplayer(1);

  if(self maymovetopoint(var_5)) {
    self._id_10AA = var_0;
    self._id_10AB = ::_id_10C9;
    self notify("move_loop_restart");
    return 1;
  }

  self pushplayer(0);
  return 0;
}

_id_10CB() {
  if(!isDefined(self._id_10CC) || !isDefined(self._id_10CD)) {
    return;
  }
  self endon("killanimscript");
  self endon("move_interrupt");

  for(;;) {
    self waittill("path_need_dodge", var_0, var_1);

    if(animscripts\utility::_id_0A69()) {
      self.nododgemove = 0;
      return;
    }

    if(!issentient(var_0)) {
      continue;
    }
    var_2 = vectornormalize(var_1 - self.origin);

    if(self.lookaheaddir[0] * var_2[1] - var_2[0] * self.lookaheaddir[1] > 0) {
      if(!_id_10CA(self._id_10CD, self._id_10CE)) {
        _id_10CA(self._id_10CC, self._id_10CF);
      }
    } else if(!_id_10CA(self._id_10CC, self._id_10CF)) {
      _id_10CA(self._id_10CD, self._id_10CE);
    }
    if(isDefined(self._id_10AA)) {
      wait(getanimlength(self._id_10AA));
      continue;
    }

    wait 0.1;
  }
}

_id_10D0(var_0, var_1) {
  self.nododgemove = 1;
  self._id_10CC = var_0;
  self._id_10CD = var_1;
  var_2 = 1;

  if(animhasnotetrack(var_0, "code_move")) {
    var_2 = getnotetracktimes(var_0, "code_move")[0];
  }
  self._id_10CF = getmovedelta(var_0, 0, var_2);
  var_2 = 1;

  if(animhasnotetrack(var_1, "code_move")) {
    var_2 = getnotetracktimes(var_1, "code_move")[0];
  }
  self._id_10CE = getmovedelta(var_1, 0, var_2);
  self.interval = 80;
}

_id_10D1() {
  self.nododgemove = 0;
  self._id_10CC = undefined;
  self._id_10CD = undefined;
  self._id_10CF = undefined;
  self._id_10CE = undefined;
}

_id_10D2() {
  self endon("killanimscript");

  for(;;) {
    if(isDefined(self.enemy) && (isai(self.enemy) || isDefined(self._id_10D3))) {
      if(abs(self getmotionangle()) <= 135) {
        animscripts\melee::_id_1009();
      }
    }

    wait 0.1;
  }
}

_id_10D4() {
  self endon("killanimscript");

  if(isDefined(self._id_0EEE)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(self.movemode != "run" || !self.facemotion || self.a._id_0D26 != "stand" || isDefined(self._id_0FCF)) {
      continue;
    }
    if(self.stairsstate != "none") {
      continue;
    }
    if(!isDefined(self.enemy) && !self.ignoreall && isDefined(var_0.team) && isenemyteam(self.team, var_0.team)) {
      self._id_0F24 = var_0;
      self animcustom(animscripts\reactions::_id_0F23);
      continue;
    }

    if(self.lookaheadhitsstairs || self.lookaheaddist < 100) {
      continue;
    }
    if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < 10000) {
      wait 0.2;
      continue;
    }

    self._id_0FD1 = gettime();
    self notify("move_loop_restart");
    animscripts\run::_id_0FE2();
  }
}

_id_10D5(var_0, var_1) {
  if(var_1.type == "Cover Left") {
    return % cornercrl_alert_2_shuffle;
  } else if(var_1.type == "Cover Right") {
    return % cornercrr_alert_2_shuffle;
  } else if(var_0) {
    return % covercrouch_hide_2_shufflel;
  } else {
    return % covercrouch_hide_2_shuffler;
  }
}

_id_10D6(var_0, var_1, var_2) {
  var_3 = [];

  if(var_2.type == "Cover Left") {
    var_3["shuffle_start"] = _id_10D5(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shufflel;
    var_3["shuffle_end"] = % cornercrl_shuffle_2_alert;
  } else if(var_2.type == "Cover Right") {
    var_3["shuffle_start"] = _id_10D5(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shuffler;
    var_3["shuffle_end"] = % cornercrr_shuffle_2_alert;
  } else if(var_2.type == "Cover Stand" && var_1.type == var_2.type) {
    if(var_0) {
      var_3["shuffle_start"] = % coverstand_hide_2_shufflel;
      var_3["shuffle"] = % coverstand_shufflel;
      var_3["shuffle_end"] = % coverstand_shufflel_2_hide;
    } else {
      var_3["shuffle_start"] = % coverstand_hide_2_shuffler;
      var_3["shuffle"] = % coverstand_shuffler;
      var_3["shuffle_end"] = % coverstand_shuffler_2_hide;
    }
  } else if(var_0) {
    var_3["shuffle_start"] = _id_10D5(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shufflel;

    if(var_2.type == "Cover Stand") {
      var_3["shuffle_end"] = % coverstand_shufflel_2_hide;
    } else {
      var_3["shuffle_end"] = % covercrouch_shufflel_2_hide;
    }
  } else {
    var_3["shuffle_start"] = _id_10D5(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shuffler;

    if(var_2.type == "Cover Stand") {
      var_3["shuffle_end"] = % coverstand_shuffler_2_hide;
    } else {
      var_3["shuffle_end"] = % covercrouch_shuffler_2_hide;
    }
  }

  self.a._id_0C6D = var_3;
}

_id_10D7(var_0, var_1) {
  if(self.a._id_0D26 == "stand" && (var_1.type != "Cover Stand" || var_0.type != "Cover Stand")) {
    self.a._id_0D26 = "crouch";
    return 0;
  }

  return 1;
}

_id_10D8(var_0) {
  if(self.a._id_0D26 == "crouch" && var_0.type == "Cover Stand") {
    self.a._id_0D26 = "stand";
    return 0;
  }

  return 1;
}

_id_10D9() {
  self endon("killanimscript");
  self endon("goal_changed");
  var_0 = self._id_0F75;
  self._id_0F74 = undefined;
  self._id_0F75 = undefined;
  self._id_10DA = 1;

  if(!isDefined(self.prevnode)) {
    return;
  }
  if(!isDefined(self.node) || !isDefined(var_0) || self.node != var_0) {
    return;
  }
  var_1 = self.prevnode;
  var_2 = self.node;
  var_3 = var_2.origin - self.origin;

  if(lengthsquared(var_3) < 1) {
    return;
  }
  var_3 = vectornormalize(var_3);
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;

  if(_id_10DC(var_5, var_1, var_2)) {
    return;
  }
  if(_id_10D7(var_1, var_2)) {
    var_6 = 0.1;
  } else {
    var_6 = 0.4;
  }
  _id_10D6(var_5, var_1, var_2);
  self animmode("zonly_physics", 0);
  self clearanim(%body, var_6);
  var_7 = animscripts\utility::_id_0D4D("shuffle_start");
  var_8 = animscripts\utility::_id_0D4D("shuffle");
  var_9 = animscripts\utility::_id_0D4D("shuffle_end");

  if(animhasnotetrack(var_7, "finish")) {
    var_10 = getnotetracktimes(var_7, "finish")[0];
  } else {
    var_10 = 1;
  }
  var_11 = length(getmovedelta(var_7, 0, var_10));
  var_12 = length(getmovedelta(var_8, 0, 1));
  var_13 = length(getmovedelta(var_9, 0, 1));
  var_14 = distance(self.origin, var_2.origin);

  if(var_14 > var_11) {
    self orientmode("face angle", animscripts\utility::_id_0F41(var_1));
    self setflaggedanimrestart("shuffle_start", var_7, 1, var_6);
    animscripts\shared::_id_0C51("shuffle_start");
    self clearanim(var_7, 0.2);
    var_14 = var_14 - var_11;
    var_6 = 0.2;
  } else {
    self orientmode("face angle", var_2.angles[1]);
  }
  var_15 = 0;

  if(var_14 > var_13) {
    var_15 = 1;
    var_14 = var_14 - var_13;
  }

  var_16 = getanimlength(var_8);
  var_17 = var_16 * (var_14 / var_12) * 0.9;
  var_17 = floor(var_17 * 20) * 0.05;
  self setflaggedanim("shuffle", var_8, 1, var_6);
  animscripts\notetracks::_id_0D4F(var_17, "shuffle");

  for(var_18 = 0; var_18 < 2; var_18++) {
    var_14 = distance(self.origin, var_2.origin);

    if(var_15) {
      var_14 = var_14 - var_13;
    }
    if(var_14 < 4) {
      break;
    }

    var_17 = var_16 * (var_14 / var_12) * 0.9;
    var_17 = floor(var_17 * 20) * 0.05;

    if(var_17 < 0.05) {
      break;
    }

    animscripts\notetracks::_id_0D4F(var_17, "shuffle");
  }

  if(var_15) {
    if(_id_10D8(var_2)) {
      var_6 = 0.2;
    } else {
      var_6 = 0.4;
    }
    self clearanim(var_8, var_6);
    self setflaggedanim("shuffle_end", var_9, 1, var_6);
    animscripts\shared::_id_0C51("shuffle_end");
  }

  self safeteleport(var_2.origin);
  self animmode("normal");
  self._id_10DA = undefined;
}

_id_10DB() {
  if(isDefined(self._id_10DA)) {
    self clearanim(%cover_shuffle, 0.2);
    self._id_10DA = undefined;
    self animmode("none", 0);
    self orientmode("face default");
  } else {
    wait 0.2;
    self clearanim(%cover_shuffle, 0.2);
  }
}

_id_10DC(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.type == "Cover Right" && var_2.type == "Cover Left" && !var_0) {
    var_3 = % corner_standr_door_r2l;
  } else if(var_1.type == "Cover Left" && var_2.type == "Cover Right" && var_0) {
    var_3 = % corner_standl_door_l2r;
  }
  if(!isDefined(var_3)) {
    return 0;
  }
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self setflaggedanimrestart("sideToSide", var_3, 1, 0.2);
  animscripts\shared::_id_0C51("sideToSide", ::_id_10DD);
  var_4 = self getanimtime(var_3);
  var_5 = var_2.origin - var_1.origin;
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
  var_6 = getmovedelta(var_3, var_4, 1);
  var_7 = var_2.origin - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectordot(var_7, var_5) - abs(var_6[1]);

  if(var_8 > 2) {
    var_9 = getnotetracktimes(var_3, "slide_end")[0];
    var_10 = (var_9 - var_4) * getanimlength(var_3);
    var_11 = int(ceil(var_10 / 0.05));
    var_12 = var_5 * var_8 / var_11;
    thread _id_10DE(var_12, var_11);
  }

  animscripts\shared::_id_0C51("sideToSide");
  self safeteleport(var_2.origin);
  self animmode("none");
  self orientmode("face default");
  self._id_10DA = undefined;
  wait 0.2;
  return 1;
}

_id_10DD(var_0) {
  if(var_0 == "slide_start") {
    return 1;
  }
}

_id_10DE(var_0, var_1) {
  self endon("killanimscript");
  self endon("goal_changed");

  while(var_1 > 0) {
    self safeteleport(self.origin + var_0);
    var_1--;
    wait 0.05;
  }
}

_id_0FBE(var_0, var_1) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self setanimknoball(%combatrun, %body, 1, 0.5, self._id_0FC6);

  if(isDefined(self._id_0FD1) && gettime() - self._id_0FD1 < 100 && isDefined(self._id_0FD4) && randomfloat(1) < self.a._id_0FDD) {
    animscripts\run::_id_0FD3();
    return;
  }

  if(isarray(var_0)) {
    if(isDefined(self._id_0FBD)) {
      var_2 = common_scripts\utility::choose_from_weighted_array(var_0, var_1);
    } else {
      var_2 = var_0[randomint(var_0.size)];
    }
  } else {
    var_2 = var_0;
  }
  self setflaggedanimknob("moveanim", var_2, 1, 0.2);
  animscripts\shared::_id_0C51("moveanim");
}