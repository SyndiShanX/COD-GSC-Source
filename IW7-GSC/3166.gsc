/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3166.gsc
**************************************/

_id_FFD9() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.enemy) && isDefined(self.node);
}

_id_FFDA(var_0, var_1, var_2, var_3) {
  if(isDefined(self.bt.cover) && isDefined(self._id_280A)) {
    return scripts\asm\asm_bb::bb_reloadrequested();
  }

  return 0;
}

_id_CF00(var_0, var_1, var_2, var_3) {
  if(var_3 == "alignToNode") {
    if(isDefined(var_1)) {
      if(scripts\engine\utility::actor_is3d()) {
        var_4 = getangledelta3d(var_2);
        var_5 = scripts\asm\shared\utility::getnodeforwardangles(var_1, 0);
        var_6 = combineangles(var_5, -1 * var_4);
        self orientmode("face angle 3d", var_6);
      } else {
        var_4 = getangledelta3d(var_2);
        var_5 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var_1), 0);
        var_6 = var_5 - var_4;
        self orientmode("face angle", var_6[1]);
      }
    }
  } else if(var_3 == "stickToNode") {
    var_7 = getmovedelta(var_2);

    if(distancesquared(var_1.origin, self.origin) < 16) {
      self _meth_8272(var_1.origin);
    } else {
      thread _id_ABB7(var_1, 4, var_0 + "_finished");
    }
  }
}

_id_3F06(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_4 = getangledelta(var_3, 0.0, 1.0);
  var_5 = angleclamp180(180 - var_4);

  if(isDefined(self.pathgoalpos) && self.facemotion) {
    var_6 = vectortoangles(self.lookaheaddir);
    var_7 = var_6[1] - self.angles[1];
    var_8 = angleclamp180(var_7 + var_5);
  } else {
    var_9 = self.enemy;
    var_7 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.25, var_9, undefined);
    var_8 = angleclamp180(var_7 + var_5);
  }

  var_10 = spawnStruct();

  if(abs(var_8) > 135) {
    var_10._id_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  } else if(var_8 < 0) {
    var_10._id_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  } else {
    var_10._id_1299D = scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  }

  var_10._id_D81F = var_7;
  return var_10;
}

_id_D559(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  var_5 = 1.0;

  if((scripts\asm\asm_bb::bb_meleechargerequested(var_0, var_1, var_2, var_3) || scripts\asm\asm_bb::bb_meleerequested(var_0, var_1, var_2, var_3)) && isDefined(self.melee.target) && isPlayer(self.melee.target)) {
    var_5 = 2.0;
  }

  self _meth_82E7(var_1, var_4._id_1299D, 1.0, var_2, var_5);
  _id_0A1E::_id_2369(var_0, var_1, var_4._id_1299D);
  thread _id_D55A(var_1, var_4._id_1299D, var_4._id_D81F, var_2);
  var_6 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_6 == "end") {
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }
}

_id_D55A(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  self endon("death");
  self endon("entitydeleted");
  var_4 = getangledelta(var_1, 0.0, 1.0);
  var_5 = angleclamp180(self.angles[1] + var_4);
  var_6 = angleclamp180(self.angles[1] + var_2);
  var_7 = angleclamp180(var_6 - var_5);
  var_8 = getanimlength(var_1);
  var_9 = int((var_8 - var_3) * 20);
  var_10 = var_7 / var_9;
  var_11 = 0;

  while(var_11 < var_9) {
    self _meth_80F1(self.origin, self.angles + (0, var_10, 0));
    var_11++;
    wait 0.05;
  }
}

_id_D558(var_0, var_1, var_2, var_3) {
  var_4 = anim.asm[var_0].states[var_1]._id_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  var_6 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var_6)) {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096) {
      var_6 = self.node;
    }
  }

  var_7 = undefined;

  if(isDefined(var_6)) {
    var_7 = _id_8178(var_0, var_1, var_5, var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_1 + "_finished");
    self._id_4C7E = _id_0F3D::_id_22EA;
    self.a._id_22E5 = var_1;
    var_8 = var_7._id_0130;
    var_9 = var_7.startpos;
    var_10 = angleclamp180(var_8 - var_7.angledelta);
    self.keepclaimednodeifvalid = 1;
    self animmode("zonly_physics", 0);
    self orientmode("face current");

    if(self.script == "init") {
      wait 0.05;
    }

    _id_0A1E::_id_2369(var_0, var_1, var_7._id_02C9);
    self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
    self _meth_82E7(var_1, var_7._id_02C9, 1, var_2, self.animplaybackrate);
    _id_0F3D::_id_444B(var_1);
    self _meth_8396(var_9, var_10);
    _id_0A1E::_id_231F(var_0, var_1);
    self.a.movement = "stop";
    return;
  }

  self.keepclaimednodeifvalid = 1;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
  self orientmode("face current");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_5, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_7);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_36D9(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

_id_8178(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_4 = var_3.origin;
  var_5 = _id_0F3D::_id_C057(var_3);
  var_6 = undefined;
  var_7 = undefined;

  if(var_5) {
    var_8 = undefined;

    if(scripts\engine\utility::isnodecoverleft(var_3) && _id_0F3D::_id_9D4C(var_0, var_1, undefined, "Cover Left Crouch") || scripts\engine\utility::isnodecoverright(var_3) && _id_0F3D::_id_9D4C(var_0, var_1, undefined, "Cover Right Crouch")) {
      var_8 = "crouch";
    }

    var_6 = scripts\asm\shared\utility::getnodeforwardyaw(var_3, var_8);
    var_7 = var_3.angles;
  }

  var_9 = spawnStruct();
  var_9._id_02C9 = var_2;
  var_9.angleindex = 3;
  var_9._id_01F3 = getmovedelta(var_9._id_02C9, 0.0, 1.0);
  var_9.angledelta = getangledelta(var_9._id_02C9, 0.0, 1.0);
  var_9.startpos = _id_36D9(var_4, var_6, var_9._id_01F3, var_9.angledelta);
  var_9.angles = var_7;
  var_9._id_0130 = var_6;
  return var_9;
}

_id_9E30(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 _meth_8169();

  foreach(var_3 in var_1) {
    if(var_3 == "over") {
      return 0;
    }
  }

  return 1;
}

_id_3EC7(var_0, var_1, var_2) {
  var_3 = var_2;

  if(_id_9E30(self.node)) {
    var_3 = var_3 + "_high";
  }

  var_4 = _id_0A1E::_id_2356(var_1, var_3);

  if(isarray(var_4)) {
    return var_4[randomint(var_4.size)];
  }

  return var_4;
}

_id_CEFC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.keepclaimednodeifvalid = 1;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self orientmode("face current");
  var_5 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      foreach(var_7 in var_3) {
        _id_CF00(var_1, var_5, var_4, var_7);
      }
    } else
      _id_CF00(var_1, var_5, var_4, var_3);
  }

  if(scripts\asm\asm::_id_2384(var_0, var_1, "notetrackAim")) {
    var_9 = getangledelta(var_4, 0.0, 1.0);
    self._id_10F8C = self.angles[1] + var_9;
  }

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self orientmode("face current");
}

_id_D46B(var_0, var_1, var_2, var_3) {
  _id_CF02(var_0, var_1, var_2, var_3);
}

_id_12675(var_0) {
  var_1 = self._id_164D[var_0];

  if(isDefined(var_1._id_10E23)) {
    if(var_1._id_10E23 == "stand_run_loop") {
      return 1;
    } else if(scripts\engine\utility::actor_is3d() && var_1._id_10E23 == "stand_run_strafe_loop") {
      return 1;
    }
  }

  return 0;
}

_id_CF01(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asm._id_A961)) {
    var_4 = [scripts\asm\asm_bb::bb_getcovernode(), self.node];

    for(var_5 = 0; !isDefined(self.asm._id_A961) && var_5 < var_4.size; var_5++) {
      if(isDefined(var_4[var_5]) && distancesquared(self.origin, var_4[var_5].origin) < 256) {
        self.asm._id_A961 = var_4[var_5];
      }
    }
  }

  _id_CF02(var_0, var_1, var_2, var_3);
}

_id_CF02(var_0, var_1, var_2, var_3) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(var_3)) {
    if(var_3 == "stickToNode") {
      var_4 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_4)) {
        if(distancesquared(var_4.origin, self.origin) < 16) {
          self _meth_8272(var_4.origin);
        } else {
          thread _id_ABB7(var_4, 4, var_1 + "_finished");
        }
      }

      self.keepclaimednodeifvalid = 0;

      if(_id_12675(var_0)) {
        childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
      }
    }
  }

  var_5 = _func_2EE(self.asm.archetype, var_1, "conceal_add", 0);
  var_4 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_5) && isDefined(var_4) && (var_4.type == "Conceal Crouch" || var_4.type == "Conceal Stand")) {
    self _meth_82A2(var_5.anims, 1.0, 0.2, 1.0, 1);
    thread _id_4497(var_1);
  }

  _id_0F3D::_id_B050(var_0, var_1, var_2, var_3);
}

_id_4497(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0 + "_finished");
  var_1 = _func_2EE(self.asm.archetype, "Knobs", "conceal_add", 0);
  self clearanim(var_1.anims, 0.2);
}

_id_ABB7(var_0, var_1, var_2) {
  self endon(var_2);

  for(;;) {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < var_1) {
      self _meth_8272(var_0.origin);
      break;
    }

    var_3 = var_3 / var_4;
    var_5 = self.origin + var_3 * var_1;
    self _meth_8272(var_5);
    wait 0.05;
  }
}

_id_CEC2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getanimlength(var_4);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
  var_6 = _id_0A1E::_id_2323(var_0, var_1, var_5, scripts\asm\asm::_id_2341(var_0, var_1));

  if(isDefined(var_6) && var_6 == "end") {
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }

  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_41A2(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 0;
  self._id_10F8C = undefined;

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        scripts\asm\asm::asm_fireephemeralevent(var_4, "end");
      }
    } else
      scripts\asm\asm::asm_fireephemeralevent(var_2, "end");
  }
}

_id_116F2(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  _id_0C68::_id_DF4F(var_0, var_1, var_2);
}

_id_CEFD(var_0, var_1, var_2, var_3) {
  self.keepclaimednodeifvalid = 1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self orientmode("face current");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_D51A(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["crouch_shuffle_right"] = -90;
  var_4["crouch_shuffle_left"] = 90;
  var_4["stand_shuffle_right"] = -90;
  var_4["stand_shuffle_left"] = 90;
  self endon(var_1 + "_finished");
  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_6, var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_5);

  if(isDefined(self._blackboard.shufflenode)) {
    var_7 = self._blackboard.shufflenode.angles[1];
  } else if(isDefined(self.node)) {
    var_7 = self.node.angles[1];
  } else {
    var_7 = self.angles[1];
  }

  if(self.unittype != "c6" && isDefined(var_4[var_1])) {
    var_7 = var_7 + var_4[var_1];
  }

  self orientmode("face angle", var_7);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_10054(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::_id_235D(var_2);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_6 = getmovedelta(var_5);
  var_7 = lengthsquared(var_6);
  var_8 = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return var_7 <= var_8 + 1;
}

_id_FFB5(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.shufflenode)) {
    return 1;
  }

  if(!isDefined(self.node)) {
    return 1;
  }

  if(self._blackboard.shufflenode != self.node) {
    return 1;
  }

  return 0;
}

_id_FFCA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && self._blackboard.shufflenode.type != var_3) {
    return 0;
  }

  var_4 = _id_0A1E::_id_235D(var_2);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_6 = self._blackboard.shufflenode.origin - self.origin;
  var_7 = vectorNormalize(var_6);
  var_8 = getmovedelta(var_5, 0, 1);
  var_9 = length(var_8);
  var_10 = self._blackboard.shufflenode.origin - var_7 * var_9;
  var_6 = var_10 - self.origin;
  var_11 = self._blackboard.shufflenode.origin - self._blackboard._id_1016B.origin;
  var_11 = (var_11[0], var_11[1], 0);

  if(vectordot(var_11, var_6) < 0) {
    return 1;
  }

  return 0;
}

_id_D518(var_0, var_1, var_2, var_3) {
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);

  if(isDefined(self._blackboard.shufflenode)) {
    var_7 = self._blackboard.shufflenode;
  } else {
    var_7 = self.node;
  }

  if(isDefined(var_7)) {
    var_8 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var_7), 0);
    var_9 = combineangles(var_8, invertangles(var_6));
    var_10 = var_7.origin - rotatevector(var_5, var_9);
  } else {
    var_10 = self.origin;
    var_9 = self.angles;
  }

  self _meth_8396(var_10, var_9[1]);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_D519(var_0, var_1, var_2) {
  self._blackboard.shufflenode = undefined;
  self._blackboard._id_1016B = undefined;
}

_id_4742(var_0, var_1, var_2, var_3) {
  _id_CEFC(var_0, var_1, var_2, var_3);
}

_id_4700(var_0, var_1, var_2, var_3) {
  self.bt.cover._id_46FF = undefined;
  var_4 = (self.enemy.origin + scripts\anim\utility_common::getenemyeyepos()) / 2;
  var_5 = anim.asm[var_0].states[var_2];
  var_6 = scripts\engine\utility::array_randomize(var_5.transitions);
  var_7 = undefined;

  foreach(var_9 in var_6) {
    var_7 = var_9._id_100B1;

    if(var_7 == "up") {
      break;
    }

    var_10 = scripts\anim\utility_common::getcover3dnodeoffset(self.node, var_7);
    var_11 = self.node.origin + var_10;

    if(sighttracepassed(var_11, var_4, 0, undefined)) {
      break;
    }
  }

  self.bt.cover._id_46FF = var_0 + "_" + var_2 + "_" + var_7;
  return 1;
}

_id_46FE(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + "_" + var_1 + "_" + var_3;
  return var_4 == self.bt.cover._id_46FF;
}