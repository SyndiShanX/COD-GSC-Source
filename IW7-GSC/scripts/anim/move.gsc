/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\move.gsc
**************************************/

_id_951A() {}

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    _id_89C7();
    return;
  }

  if(isDefined(self._id_4C37)) {
    if(isDefined(self._id_4C37["move"])) {
      [[self._id_4C37["move"]]]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.exception["move"]]]();
  _id_BCBE();
  _id_81F3();
  scripts\anim\utility::_id_9832("move");
  var_0 = _id_1391A();

  if(var_0 && isDefined(self._id_1016F)) {
    _id_BCAD();
    _id_BCB0();
  } else if(isDefined(self._id_28CF) && self._id_28CF) {
    _id_BCF9(var_0);
    scripts\anim\battlechatter::_id_CEE8();
  }

  thread _id_12F27();
  var_1 = ::_id_C968;

  if(isDefined(self._id_C967)) {
    var_1 = self._id_C967;
  }

  self thread[[var_1]]();
  thread _id_1FAE();
  scripts\anim\exit_node::_id_10DCA();
  self._id_58DC = undefined;
  self._id_932E = undefined;
  thread _id_10DFD();
  _id_AD66();
  self._id_FE92 = undefined;
  self._id_1A32 = undefined;
  self._id_E873 = undefined;
  _id_BCC4(1);
}

#using_animtree("generic_human");

end_script() {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }
  if(isDefined(self._id_C3F2)) {
    self.grenadeweapon = self._id_C3F2;
    self._id_C3F2 = undefined;
  }

  self._id_115CE = undefined;
  self._id_B7B5 = undefined;
  self._id_932E = undefined;
  self._id_1016F = undefined;
  self.shufflenode = undefined;
  self._id_E873 = undefined;
  self._id_DD39 = undefined;
  self._id_E1B0 = undefined;
  self._id_4BE6 = undefined;
  self._id_BCC3 = undefined;
  scripts\anim\run::_id_F843(0);
  self clearanim(%head, 0.2);
  self.facialidx = undefined;
}

_id_89C7() {
  scripts\asm\asm_bb::bb_requestmove();
  self waittill("killanimscript");
  scripts\asm\asm_bb::bb_clearmoverequest();
}

_id_BCBE() {
  self._id_DD39 = undefined;
  self._id_E1B0 = undefined;
  self._id_12DEF = undefined;
  self._id_12DF0 = undefined;
  self._id_E879 = 0;
  self._id_22F0 = undefined;
}

_id_81F3() {
  if(self.a.pose == "prone") {
    var_0 = scripts\anim\utility::_id_3EF2("stand");

    if(var_0 != "prone") {
      self orientmode("face current");
      self animmode("zonly_physics", 0);
      var_1 = 1;

      if(isDefined(self.grenade)) {
        var_1 = 2;
      }

      scripts\anim\cover_prone::_id_DA87(var_0, var_1);
      self animmode("none", 0);
      self orientmode("face default");
    }
  }
}

_id_1391A() {
  switch (self.prevscript) {
    case "turret":
    case "cover_wide_right":
    case "cover_wide_left":
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "cover_right":
    case "cover_crouch":
    case "hide":
      return 1;
  }

  return 0;
}

_id_BCF9(var_0) {
  if(self.movemode == "run") {
    scripts\anim\battlechatter_ai::_id_67D2(var_0);
  }
}

_id_BCC4(var_0) {
  _id_BCC5(var_0);
  self notify("abort_reload");
}

_id_2125() {
  if(isDefined(self._id_1F62) && self._id_1F62 != self._id_D8B6) {
    return 1;
  } else if(!isDefined(self._id_1F62) && self._id_D8B6 != "none") {
    return 1;
  }

  return 0;
}

_id_12ED4(var_0) {
  if(var_0 != self._id_D8B7 || _id_2125()) {
    if(isDefined(self.custommoveanimset) && isDefined(self.custommoveanimset[var_0])) {
      self.a._id_BCA5 = self.custommoveanimset[var_0];
    } else {
      self.a._id_BCA5 = scripts\anim\utility::_id_B028(var_0);

      if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > squared(100))) {
        self._id_101BB = 1;
        scripts\anim\animset::_id_F2AC();
      } else
        self._id_101BB = 1.35;
    }

    self._id_D8B7 = var_0;

    if(isDefined(self._id_1F62)) {
      self._id_D8B6 = self._id_1F62;
    }
  }
}

_id_BCC5(var_0) {
  self endon("killanimscript");
  self endon("move_interrupt");
  var_1 = self islegacyagent(%walk_and_run_loops);
  self.a._id_E860 = randomint(10000);
  self._id_D8B7 = "none";
  self._id_D8B6 = "none";
  self._id_BCC2 = undefined;

  for(;;) {
    var_2 = self islegacyagent(%walk_and_run_loops);

    if(var_2 < var_1) {
      self.a._id_E860++;
    }

    var_1 = var_2;
    _id_12ED4(self.movemode);

    if(isDefined(self._id_BCC7)) {
      self[[self._id_BCC7]](self.movemode);
    } else {
      _id_BCC6(self.movemode);
    }

    if(isDefined(self._id_BCC2)) {
      self[[self._id_BCC2]]();
      self._id_BCC2 = undefined;
    }

    self notify("abort_reload");
  }
}

_id_BCC6(var_0) {
  self endon("move_loop_restart");

  if(isDefined(self._id_BCC3)) {
    self[[self._id_BCC3]]();
  } else if(scripts\anim\utility::_id_FFDB()) {
    scripts\anim\cqb::_id_BCB1();
  } else if(var_0 == "run") {
    scripts\anim\run::_id_BCEB();
  } else {
    scripts\anim\walk::_id_BD2B();
  }

  self._id_E1B0 = undefined;
}

_id_B4EC() {
  if(self.weapon == "none") {
    return 0;
  }

  var_0 = weaponclass(self.weapon);

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return 0;
  }

  if(scripts\anim\utility_common::isasniper()) {
    if(!scripts\anim\utility::_id_9D9B() && self.facemotion) {
      return 0;
    }
  }

  if(isDefined(self._id_596C)) {
    return 0;
  }

  return 1;
}

_id_FEEB() {
  self endon("killanimscript");
  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");
  var_0 = scripts\anim\utility::_id_B028("shoot_while_moving");

  foreach(var_3, var_2 in var_0) {
    self.a._id_2274[var_3] = var_2;
  }

  if(isDefined(self._id_440C) && isDefined(self._id_440C["fire"])) {
    self.a._id_2274["fire"] = self._id_440C["fire"];
  }

  if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a._id_2274["single"] = ::scripts\anim\utility::_id_B027("shotgun_stand", "single");
  }

  for(;;) {
    if(!self.bulletsinclip) {
      if(scripts\anim\utility::_id_9D9C()) {
        self.ammocheattime = 0;
        scripts\anim\utility_common::cheatammoifnecessary();
      }

      if(!self.bulletsinclip) {
        wait 0.5;
        continue;
      }
    }

    scripts\anim\combat_utility::_id_FEDF();
    self clearanim(%exposed_aiming, 0.2);
  }
}

_id_10DFD() {
  self endon("killanimscript");
  wait 0.05;
  thread _id_325C();
  thread _id_B5DF();
  thread scripts\anim\door::_id_940A();
  thread scripts\anim\door::_id_5A09();
}

_id_12F27() {
  self endon("killanimscript");
  self._id_D8C1 = self.stairsstate;

  for(;;) {
    wait 0.05;

    if(self._id_D8C1 != self.stairsstate) {
      if(!isDefined(self._id_932E) || self.stairsstate != "none") {
        self notify("move_loop_restart");
      }
    }

    self._id_D8C1 = self.stairsstate;
  }
}

_id_E2B4(var_0) {
  self endon("killanimscript");

  if(!var_0) {
    scripts\anim\exit_node::_id_10DCA();
  }

  self._id_932E = undefined;
  self clearanim(%root, 0.1);
  self orientmode("face default");
  self animmode("none", 0);
  self.requestarrivalnotify = 1;
  _id_BCC4(!var_0);
}

_id_C968() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self._id_932E = 1;

  for(;;) {
    self waittill("path_changed", var_0, var_1);

    if(isDefined(self._id_932E) || isDefined(self.noturnanims)) {
      continue;
    }
    if(!isDefined(self.usingnavmesh) || !self.usingnavmesh) {
      if(!self.facemotion || abs(self _meth_813E()) > 15) {
        continue;
      }
    }

    if(self.a.pose != "stand") {
      continue;
    }
    self notify("stop_move_anim_update");
    self._id_12DEF = undefined;
    var_2 = vectortoangles(var_1);
    var_3 = angleclamp180(self.angles[1] - var_2[1]);
    var_4 = angleclamp180(self.angles[0] - var_2[0]);
    var_5 = _id_C966(var_3, var_4);

    if(isDefined(var_5)) {
      self._id_1299D = var_5;
      self._id_129B0 = gettime();
      self._id_BCC3 = ::_id_C965;
      self notify("move_loop_restart");
      scripts\anim\run::_id_6318();
    }
  }
}

_id_C966(var_0, var_1) {
  if(isDefined(self._id_C976)) {
    return [[self._id_C976]](var_0, var_1);
  }

  var_2 = undefined;
  var_3 = undefined;

  if(self.movemode == "walk") {
    var_4 = scripts\anim\utility::_id_B028("cqb_turn");
  } else if(scripts\anim\utility::_id_FFDB()) {
    var_4 = scripts\anim\utility::_id_B028("cqb_run_turn");
  } else {
    var_4 = scripts\anim\utility::_id_B028("run_turn");
  }

  if(var_0 < 0) {
    if(var_0 > -45) {
      var_5 = 3;
    } else {
      var_5 = int(ceil((var_0 + 180 - 10) / 45));
    }
  } else if(var_0 < 45)
    var_5 = 5;
  else {
    var_5 = int(floor((var_0 + 180 + 10) / 45));
  }

  var_2 = var_4[var_5];

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      while(var_2.size > 0) {
        var_6 = randomint(var_2.size);

        if(_id_C963(var_2[var_6])) {
          return var_2[var_6];
        }

        var_2[var_6] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
      }
    } else if(_id_C963(var_2))
      return var_2;
  }

  var_7 = -1;

  if(var_0 < -60) {
    var_7 = int(ceil((var_0 + 180) / 45));

    if(var_7 == var_5) {
      var_7 = var_5 - 1;
    }
  } else if(var_0 > 60) {
    var_7 = int(floor((var_0 + 180) / 45));

    if(var_7 == var_5) {
      var_7 = var_5 + 1;
    }
  }

  if(var_7 >= 0 && var_7 < 9) {
    var_3 = var_4[var_7];
  }

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_3 = var_3[0];
    }

    if(_id_C963(var_3)) {
      return var_3;
    }
  }

  return undefined;
}

_id_C963(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  var_1 = getnotetracktimes(var_0, "code_move");
  var_2 = var_1[0];
  var_3 = getmovedelta(var_0, 0, var_2);
  var_4 = self localtoworldcoords(var_3);

  if(isDefined(self._id_22F0) && squared(self._id_22F0) > distancesquared(self.pathgoalpos, var_4)) {
    return 0;
  }

  var_3 = getmovedelta(var_0, 0, 1);
  var_5 = self localtoworldcoords(var_3);
  var_5 = var_4 + vectorNormalize(var_5 - var_4) * 20;
  var_6 = !scripts\engine\utility::actor_is3d();
  return self maymovefrompointtopoint(var_4, var_5, var_6, 1);
}

_id_C965() {
  self endon("killanimscript");
  self._id_BCC3 = undefined;
  var_0 = self._id_1299D;

  if(gettime() > self._id_129B0 + 50) {
    return;
  }
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity", 0);
  } else {
    self animmode("zonly_physics", 0);
  }

  var_1 = 0.1;

  if(isDefined(self._id_C975)) {
    var_1 = self._id_C975;
  }

  self clearanim(%body, var_1);
  self._id_BCC2 = ::_id_C964;
  self._id_932E = 1;
  var_1 = 0.05;

  if(isDefined(self._id_C975)) {
    var_1 = self._id_C975;
  }

  self _meth_82EA("turnAnim", var_0, 1, var_1, self.moveplaybackrate);

  if(scripts\engine\utility::actor_is3d()) {
    self orientmode("face angle 3d", self.angles);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  scripts\anim\shared::donotetracks("turnAnim");
  self._id_932E = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  scripts\anim\shared::donotetracks("turnAnim");
}

_id_C964() {
  self._id_932E = undefined;
  self orientmode("face default");
  self clearanim(%root, 0.1);
  self animmode("none", 0);
}

_id_580E() {
  self _meth_8250(1);
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.2);
  self _meth_82EA("dodgeAnim", self._id_4BE6, 1, 0.2, 1);
  scripts\anim\shared::donotetracks("dodgeAnim");
  self animmode("none", 0);
  self orientmode("face default");

  if(animhasnotetrack(self._id_4BE6, "code_move")) {
    scripts\anim\shared::donotetracks("dodgeAnim");
  }

  self clearanim(%civilian_dodge, 0.2);
  self _meth_8250(0);
  self._id_4BE6 = undefined;
  self._id_BCC3 = undefined;
  return 1;
}

_id_12898(var_0, var_1) {
  var_2 = (self.lookaheaddir[1], -1 * self.lookaheaddir[0], 0);
  var_3 = self.lookaheaddir * var_1[0];
  var_4 = var_2 * var_1[1];
  var_5 = self.origin + var_3 - var_4;
  self _meth_8250(1);

  if(self maymovetopoint(var_5)) {
    self._id_4BE6 = var_0;
    self._id_BCC3 = ::_id_580E;
    self notify("move_loop_restart");
    return 1;
  }

  self _meth_8250(0);
  return 0;
}

_id_1FAE() {
  if(!isDefined(self._id_580B) || !isDefined(self._id_580F)) {
    return;
  }
  self endon("killanimscript");
  self endon("move_interrupt");

  for(;;) {
    self waittill("path_need_dodge", var_0, var_1);
    scripts\anim\utility::_id_12EB9();

    if(scripts\anim\utility::_id_9E40()) {
      self.nododgemove = 0;
      return;
    }

    if(!issentient(var_0)) {
      continue;
    }
    var_2 = vectorNormalize(var_1 - self.origin);

    if(self.lookaheaddir[0] * var_2[1] - var_2[0] * self.lookaheaddir[1] > 0) {
      if(!_id_12898(self._id_580F, self._id_5810)) {
        _id_12898(self._id_580B, self._id_580C);
      }
    } else if(!_id_12898(self._id_580B, self._id_580C))
      _id_12898(self._id_580F, self._id_5810);

    if(isDefined(self._id_4BE6)) {
      wait(getanimlength(self._id_4BE6));
      continue;
    }

    wait 0.1;
  }
}

_id_F6CD(var_0, var_1) {
  self.nododgemove = 1;
  self._id_580B = var_0;
  self._id_580F = var_1;
  var_2 = 1;

  if(animhasnotetrack(var_0, "code_move")) {
    var_2 = getnotetracktimes(var_0, "code_move")[0];
  }

  self._id_580C = getmovedelta(var_0, 0, var_2);
  var_2 = 1;

  if(animhasnotetrack(var_1, "code_move")) {
    var_2 = getnotetracktimes(var_1, "code_move")[0];
  }

  self._id_5810 = getmovedelta(var_1, 0, var_2);
  self.interval = 80;
}

_id_41A8() {
  self.nododgemove = 0;
  self._id_580B = undefined;
  self._id_580F = undefined;
  self._id_580C = undefined;
  self._id_5810 = undefined;
}

_id_B5DF() {}

_id_325C() {
  self endon("killanimscript");

  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(self.movemode != "run" || !self.facemotion || self.a.pose != "stand" || isDefined(self._id_DD39)) {
      continue;
    }
    if(self.stairsstate != "none") {
      continue;
    }
    if(!isDefined(self.enemy) && !self.ignoreall && isDefined(var_0.team) && isenemyteam(self.team, var_0.team)) {
      self._id_13D13 = var_0;
      self animcustom(scripts\anim\reactions::_id_325E);
      continue;
    }

    if(self.lookaheadhitsstairs || self.lookaheaddist < 100) {
      continue;
    }
    if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < 10000) {
      wait 0.2;
      continue;
    }

    self._id_E1B0 = gettime();
    self notify("move_loop_restart");
    scripts\anim\run::_id_6318();
  }
}

_id_7C69(var_0, var_1) {
  var_2 = var_1.type;

  if(var_2 == "Cover Left") {
    return scripts\anim\utility::_id_B027("shuffle", "shuffle_start_from_cover_left");
  } else if(var_2 == "Cover Right") {
    return scripts\anim\utility::_id_B027("shuffle", "shuffle_start_from_cover_right");
  } else if(var_0) {
    return scripts\anim\utility::_id_B027("shuffle", "shuffle_start_left");
  } else {
    return scripts\anim\utility::_id_B027("shuffle", "shuffle_start_right");
  }
}

_id_FA42(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_2.type;

  if(var_4 == "Cover Left") {
    var_3["shuffle_start"] = _id_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_to_cover_left");
    var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_cover_left");
  } else if(var_4 == "Cover Right") {
    var_3["shuffle_start"] = _id_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_to_cover_right");
    var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_cover_right");
  } else if(var_4 == "Cover Stand" && var_1.type == var_4) {
    if(var_0) {
      var_3["shuffle_start"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_start_left_stand_to_stand");
      var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_left_stand_to_stand");
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_left_stand_to_stand");
    } else {
      var_3["shuffle_start"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_start_right_stand_to_stand");
      var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_right_stand_to_stand");
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_right_stand_to_stand");
    }
  } else if(var_0) {
    var_3["shuffle_start"] = _id_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_to_left_crouch");

    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_left_stand");
    } else {
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_left_crouch");
    }
  } else {
    var_3["shuffle_start"] = _id_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_to_right_crouch");

    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_right_stand");
    } else {
      var_3["shuffle_end"] = ::scripts\anim\utility::_id_B027("shuffle", "shuffle_end_to_right_crouch");
    }
  }

  self.a._id_2274 = var_3;
}

_id_BCAF(var_0, var_1) {
  if(self.a.pose == "stand" && (var_1.type != "Cover Stand" || var_0.type != "Cover Stand")) {
    self.a.pose = "crouch";
    return 0;
  }

  return 1;
}

_id_BCAE(var_0) {
  if(self.a.pose == "crouch" && var_0.type == "Cover Stand") {
    self.a.pose = "stand";
    return 0;
  }

  return 1;
}

_id_BCAD() {
  self endon("killanimscript");
  self endon("goal_changed");
  var_0 = self.shufflenode;
  self._id_1016F = undefined;
  self.shufflenode = undefined;
  self._id_10170 = 1;

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
  var_3 = vectorNormalize(var_3);
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;

  if(_id_BCB5(var_5, var_1, var_2)) {
    return;
  }
  if(_id_BCAF(var_1, var_2)) {
    var_6 = 0.1;
  } else {
    var_6 = 0.4;
  }

  _id_FA42(var_5, var_1, var_2);
  self animmode("zonly_physics", 0);
  self clearanim(%body, var_6);
  var_7 = scripts\anim\utility::_id_1F64("shuffle_start");
  var_8 = scripts\anim\utility::_id_1F64("shuffle");
  var_9 = scripts\anim\utility::_id_1F64("shuffle_end");

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
    self orientmode("face angle", scripts\asm\shared\utility::getnodeforwardyaw(var_1));
    self _meth_82EA("shuffle_start", var_7, 1, var_6);
    scripts\anim\shared::donotetracks("shuffle_start");
    self clearanim(var_7, 0.2);
    var_14 = var_14 - var_11;
    var_6 = 0.2;
  } else
    self orientmode("face angle", var_2.angles[1]);

  var_15 = 0;

  if(var_14 > var_13) {
    var_15 = 1;
    var_14 = var_14 - var_13;
  }

  var_16 = getanimlength(var_8);
  var_17 = var_16 * (var_14 / var_12) * 0.9;
  var_17 = floor(var_17 * 20) * 0.05;
  self _meth_82E1("shuffle", var_8, 1, var_6);
  scripts\anim\notetracks::donotetracksfortime(var_17, "shuffle");

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

    scripts\anim\notetracks::donotetracksfortime(var_17, "shuffle");
  }

  if(var_15) {
    if(_id_BCAE(var_2)) {
      var_6 = 0.2;
    } else {
      var_6 = 0.4;
    }

    self clearanim(var_8, var_6);
    self _meth_82E1("shuffle_end", var_9, 1, var_6);
    scripts\anim\shared::donotetracks("shuffle_end");
  }

  self _meth_8272(var_2.origin);
  self animmode("normal");
  self._id_10170 = undefined;
}

_id_BCB0() {
  if(isDefined(self._id_10170)) {
    self clearanim(%cover_shuffle, 0.2);
    self._id_10170 = undefined;
    self animmode("none", 0);
    self orientmode("face default");
  } else {
    wait 0.2;
    self clearanim(%cover_shuffle, 0.2);
  }
}

_id_BCB5(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_3)) {
    return 0;
  }

  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self _meth_82EA("sideToSide", var_3, 1, 0.2);
  scripts\anim\shared::donotetracks("sideToSide", ::_id_89E3);
  var_4 = self islegacyagent(var_3);
  var_5 = var_2.origin - var_1.origin;
  var_5 = vectorNormalize((var_5[0], var_5[1], 0));
  var_6 = getmovedelta(var_3, var_4, 1);
  var_7 = var_2.origin - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectordot(var_7, var_5) - abs(var_6[1]);

  if(var_8 > 2) {
    var_9 = getnotetracktimes(var_3, "slide_end")[0];
    var_10 = (var_9 - var_4) * getanimlength(var_3);
    var_11 = int(ceil(var_10 / 0.05));
    var_12 = var_5 * var_8 / var_11;
    thread _id_102E9(var_12, var_11);
  }

  scripts\anim\shared::donotetracks("sideToSide");
  self _meth_8272(var_2.origin);
  self animmode("none");
  self orientmode("face default");
  self._id_10170 = undefined;
  wait 0.2;
  return 1;
}

_id_89E3(var_0) {
  if(var_0 == "slide_start") {
    return 1;
  }
}

_id_102E9(var_0, var_1) {
  self endon("killanimscript");
  self endon("goal_changed");

  while(var_1 > 0) {
    self _meth_8272(self.origin + var_0);
    var_1--;
    wait 0.05;
  }
}

_id_BCF8(var_0, var_1) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self _meth_82A5(%combatrun, %body, 1, 0.5, self.moveplaybackrate);

  if(isDefined(self._id_E1B0) && gettime() - self._id_E1B0 < 100 && isDefined(self._id_E80D) && randomfloat(1) < self.a.reacttobulletchance) {
    scripts\anim\run::_id_4C9A();
    return;
  }

  if(isarray(var_0)) {
    if(isDefined(self._id_E80B)) {
      var_2 = scripts\engine\utility::choose_from_weighted_array(var_0, var_1);
    } else {
      var_2 = var_0[randomint(var_0.size)];
    }
  } else
    var_2 = var_0;

  self _meth_82E2("moveanim", var_2, 1, 0.2, self.moveplaybackrate);
  scripts\anim\shared::donotetracks("moveanim");
}

_id_AD66() {
  thread scripts\anim\cover_arrival::_id_FA90(1);
}