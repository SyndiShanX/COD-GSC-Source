/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3148.gsc
**************************************/

_id_3DF2(var_0, var_1, var_2, var_3) {
  if(isDefined(self.enemy)) {
    var_4 = distancesquared(self.origin, self.enemy.origin);

    if(var_4 < 65536.0)
      return 0;

    if(isai(self.enemy)) {
      if(!isDefined(self.enemy scripts\asm\asm_bb::bb_getcovernode()) || self.enemy scripts\asm\asm_bb::bb_getrequestedcoverstate() != "hide")
        return 0;
    } else if(var_4 < 262144)
      return 0;
  }

  if(isDefined(self._blackboard._id_28D0)) {
    if(self._blackboard._id_28D0 == var_3)
      return 1;
    else
      return 0;
  } else
    return 0;
}

_id_3EBB(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._blackboard._id_28DE))
    var_3 = self._blackboard._id_28DE.origin;
  else
    var_3 = level.player.origin + anglesToForward(level.player.angles) * 6000;

  if(isDefined(var_2))
    var_4 = var_2;
  else {
    var_5 = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(var_5))
      var_6 = var_5.angles;
    else
      var_6 = self.angles;

    var_4 = _id_7818(var_6, self.origin, var_3);
  }

  var_7 = _id_0A1E::_id_2356(var_1, var_4);

  if(!isDefined(var_7))
    var_7 = _id_0A1E::_id_2356(var_1, "8");

  return var_7;
}

_id_CEE9(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._blackboard._id_28D1 = 1;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self clearanim(var_4, var_2);
  self._blackboard._id_28D0 = undefined;
  self._blackboard._id_28D1 = undefined;
}

_id_980D(var_0, var_1, var_2, var_3) {
  return;
}

_id_D48B(var_0, var_1, var_2, var_3) {
  return;
}

_id_3EDA(var_0, var_1, var_2, var_3) {
  return;
}

_id_195F() {
  if(isDefined(self._blackboard._id_778B) && self._blackboard._id_778B)
    return 1;
  else
    return 0;
}

_id_19D2() {
  if(isDefined(self._blackboard._id_D636) && self._blackboard._id_D636)
    return 1;
  else
    return 0;
}

_id_12F2(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectorNormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 >= var_1)
    return 1;
  else
    return 0;
}

_id_7818(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = angleclamp180(var_3[1] - var_0[1]);
  var_5 = getangleindex(var_4, 10);
  var_6 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var_6[var_5];
}

#using_animtree("generic_human");

_id_1964(var_0) {
  self notify("new_gesture_stop_begin");
  self notify("gesture_stop");
  self endon("death");
  self endon("start_gesture_lookat");
  self endon("new_gesture_stop_begin");
  self endon("entitydeleted");

  if(isDefined(self._id_1ED4) && isDefined(self._id_C3D4))
    _id_E224();

  if(isDefined(self._id_1ED4) && !isDefined(self._id_C3D4))
    self._id_1ED4 = undefined;

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  if(!isDefined(self._id_9BFC)) {
    return;
  }
  var_2 = gettime() / 1000;
  var_3 = self _meth_8103(self._id_8C5A);
  var_4 = self _meth_8103(self._id_8C62);
  var_5 = self _meth_8103(self._id_8C60);
  var_6 = self _meth_8103(self._id_8C63);
  var_7 = self _meth_8103(self._id_8C61);
  var_8 = self _meth_8103(%lookat_left_right);
  var_9 = self _meth_8103(%lookat_up_down);
  var_10 = self _meth_8103(%lookat_head_base_partial);
  var_11 = self _meth_8103(%head_gesture_look_partial);
  var_12 = self _meth_8103(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_0) {
    var_13 = (gettime() / 1000 - var_2) / var_0;
    var_13 = _id_10384(0, 1, var_13);
    var_14 = _id_AB7A(var_3, 1, var_13);
    var_15 = _id_AB7A(var_4, 0, var_13);
    var_16 = _id_AB7A(var_5, 0, var_13);
    var_17 = _id_AB7A(var_6, 0, var_13);
    var_18 = _id_AB7A(var_7, 0, var_13);
    var_19 = _id_AB7A(var_8, 0, var_13);
    var_20 = _id_AB7A(var_9, 0, var_13);
    var_21 = _id_AB7A(var_10, 0, var_13);
    var_22 = _id_AB7A(var_11, 0, var_13);
    var_23 = _id_AB7A(var_12, 0, var_13);
    self _meth_82AC(self._id_8C5A, var_14, 0.05);
    self _meth_82AC(self._id_8C62, var_15, 0.05);
    self _meth_82AC(self._id_8C60, var_16, 0.05);
    self _meth_82AC(self._id_8C63, var_17, 0.05);
    self _meth_82AC(self._id_8C61, var_18, 0.05);
    self _meth_82AC(%lookat_left_right, var_19, 0.05);
    self _meth_82AC(%lookat_up_down, var_20, 0.05);
    self _meth_82AC(%lookat_head_base_partial, var_21, 0.05);
    self _meth_82AC(%head_gesture_look_partial, var_22, 0.05);
    self _meth_82AC(%lookat_head_adds, var_23, 0.05);
    wait 0.05;
  }

  self _meth_82AC(self._id_8C5A, 0, 0.05);
  self _meth_82AC(self._id_8C62, 0, 0.05);
  self _meth_82AC(self._id_8C60, 0, 0.05);
  self _meth_82AC(self._id_8C63, 0, 0.05);
  self _meth_82AC(self._id_8C61, 0, 0.05);
  self _meth_82AC(%lookat_left_right, 0, 0.05);
  self _meth_82AC(%lookat_up_down, 0, 0.05);
  self _meth_82AC(%lookat_head_base_partial, 0, 0.05);
  self _meth_82AC(%head_gesture_look_partial, 0, 0.05);
  self _meth_82AC(%lookat_head_adds, 0, 0.05);
  self clearanim(%lookat_left_right, 0.05);
  self clearanim(%lookat_up_down, 0.05);
  self._id_9BFC = undefined;
}

_id_194F(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("eye_gesture_stop");

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  self clearanim(%eyes_look_leftright, var_1);
  self clearanim(%eyes_look_updown, var_1);
  self clearanim(%eyes_lookat_base_partial, var_1);
  self clearanim(%facial_gesture_look_partial, var_1);
  self clearanim(%eyes_blink_base_partial, var_1);
  self clearanim(%facial_gesture_blink_partial, var_1);
  self clearanim(%eyes_blink, var_1);
  self._id_9BDC = undefined;
}

_id_195A(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");

  if(isDefined(self._id_2B6D)) {
    return;
  }
  var_1 = var_0;
  self._id_2B6D = 1;
  self._id_2B80 = undefined;
  var_2 = gettime() / 1000;
  var_3 = self _meth_8103(%lookat_left_right);
  var_4 = self _meth_8103(%lookat_up_down);
  var_5 = self _meth_8103(%lookat_head_base_partial);
  var_6 = self _meth_8103(%head_gesture_look_partial);
  var_7 = self _meth_8103(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = (gettime() / 1000 - var_2) / var_1;
    var_8 = _id_10384(0, 1, var_8);
    var_9 = _id_AB7A(var_3, 0, var_8);
    var_10 = _id_AB7A(var_4, 0, var_8);
    var_11 = _id_AB7A(var_5, 0, var_8);
    var_12 = _id_AB7A(var_6, 0, var_8);
    var_13 = _id_AB7A(var_7, 0, var_8);
    self _meth_82AC(%lookat_left_right, var_9, 0.05);
    self _meth_82AC(%lookat_up_down, var_10, 0.05);
    self _meth_82AC(%lookat_head_base_partial, var_11, 0.05);
    self _meth_82AC(%head_gesture_look_partial, var_12, 0.05);
    self _meth_82AC(%lookat_head_adds, var_13, 0.05);
    wait 0.05;
  }

  self _meth_82AC(%lookat_left_right, 0, 0.05);
  self _meth_82AC(%lookat_up_down, 0, 0.05);
  self _meth_82AC(%lookat_head_base_partial, 0, 0.05);
  self _meth_82AC(%head_gesture_look_partial, 0, 0.05);
  self _meth_82AC(%lookat_head_adds, 0, 0.05);
  self._id_2B6D = undefined;
}

_id_195B(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");

  if(isDefined(self._id_2B80)) {
    return;
  }
  var_1 = var_0;
  self._id_2B80 = 1;
  self._id_2B6D = undefined;
  var_2 = gettime() / 1000;
  var_3 = self _meth_8103(%lookat_left_right);
  var_4 = self _meth_8103(%lookat_up_down);
  var_5 = self _meth_8103(%lookat_head_base_partial);
  var_6 = self _meth_8103(%head_gesture_look_partial);
  var_7 = self _meth_8103(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = (gettime() / 1000 - var_2) / var_1;
    var_8 = _id_10384(0, 1, var_8);
    var_9 = _id_AB7A(var_3, 1, var_8);
    var_10 = _id_AB7A(var_4, 1, var_8);
    var_11 = _id_AB7A(var_5, 10, var_8);
    var_12 = _id_AB7A(var_6, 10, var_8);
    var_13 = _id_AB7A(var_7, 0, var_8);
    self _meth_82AC(%lookat_left_right, var_9, 0.05);
    self _meth_82AC(%lookat_up_down, var_10, 0.05);
    self _meth_82AC(%lookat_head_base_partial, var_11, 0.05);
    self _meth_82AC(%head_gesture_look_partial, var_12, 0.05);
    self _meth_82AC(%lookat_head_adds, var_13, 0.05);
    wait 0.05;
  }

  self _meth_82AC(%lookat_left_right, 1, 0.05);
  self _meth_82AC(%lookat_up_down, 1, 0.05);
  self _meth_82AC(%lookat_head_base_partial, 10, 0.05);
  self _meth_82AC(%head_gesture_look_partial, 10, 0.05);
  self _meth_82AC(%lookat_head_adds, 1, 0.05);
  self._id_2B80 = undefined;
}

_id_1967(var_0) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");

  if(!isDefined(self._id_9CE9)) {
    return;
  }
  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  var_2 = gettime() / 1000;
  var_3 = self _meth_8103(self._id_11A0C);
  var_4 = self _meth_8103(self._id_11A11);
  var_5 = self _meth_8103(self._id_11A0E);
  var_6 = self _meth_8103(self._id_11A12);
  var_7 = self _meth_8103(self._id_11A0F);

  while(gettime() / 1000 - var_2 < var_0) {
    var_8 = (gettime() / 1000 - var_2) / var_0;
    var_8 = _id_10384(0, 1, var_8);
    var_9 = _id_AB7A(var_3, 1, var_8);
    var_10 = _id_AB7A(var_4, 0, var_8);
    var_11 = _id_AB7A(var_5, 0, var_8);
    var_12 = _id_AB7A(var_6, 0, var_8);
    var_13 = _id_AB7A(var_7, 0, var_8);
    self _meth_82AC(self._id_11A0C, var_9, 0.05);
    self _meth_82AC(self._id_11A11, var_10, 0.05);
    self _meth_82AC(self._id_11A0E, var_11, 0.05);
    self _meth_82AC(self._id_11A12, var_12, 0.05);
    self _meth_82AC(self._id_11A0F, var_13, 0.05);
    wait 0.05;
  }

  self _meth_82AC(self._id_11A0C, 1, 0.05);
  self _meth_82AC(self._id_11A11, 0, 0.05);
  self _meth_82AC(self._id_11A0E, 0, 0.05);
  self _meth_82AC(self._id_11A12, 0, 0.05);
  self _meth_82AC(self._id_11A0F, 0, 0.05);
  self clearanim(%torso_tracking_anims, var_0);
  self._id_9CE9 = undefined;
}

_id_19BD() {
  self._id_906F = 1;
}

_id_19BE() {
  self._id_906F = undefined;
}

_id_1921() {
  if(isDefined(self._id_906F))
    return 0;
  else
    return 1;
}

_id_1955(var_0, var_1, var_2) {
  self endon("entitydeleted");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_9BFC)) {
    _id_1964(0.25);
    wait 0.25;
  }

  self endon("death");
  self endon("gesture_stop");
  self notify("start_gesture_lookat");

  if(isai(self))
    var_3 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  else
    var_3 = undefined;

  if(isDefined(self._id_1ED4))
    _id_110A5();

  if(!isDefined(self._id_1ED4))
    self._id_1ED4 = ::_id_F580;

  if(isDefined(var_2))
    self._id_2B71 = var_2;
  else
    self._id_2B71 = 0.7;

  self._id_AFF7 = undefined;
  self._id_AFFA = undefined;
  self._id_B005 = 0;

  if(isDefined(var_1))
    self._id_778E = clamp(var_1, 0.25, 4.0);
  else
    self._id_778E = 0.5;

  if(self.unittype == "c6")
    _id_12FB2();
  else {
    self._id_AFF7 = % prototype_gesture_look_rightleft;
    self._id_AFFA = % prototype_gesture_look_updwn;
    self._id_8C5A = % gesture_head_fwd;
    self._id_8C62 = % gesture_head_right;
    self._id_8C60 = % gesture_head_left;
    self._id_8C63 = % gesture_head_rightback;
    self._id_8C61 = % gesture_head_leftback;
  }

  self._id_77A3 = var_0;

  if(self.unittype == "c6") {
    thread _id_1952();
    thread _id_1954();
  } else {
    thread _id_1951();
    thread _id_1953();
  }

  self._id_9BFC = 1;
}

_id_194E(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self._id_9BDC)) {
    _id_194F(0.25);
    wait 0.25;
  }

  if(isDefined(self._id_1ED4))
    _id_110A5();

  if(!isDefined(self._id_1ED4))
    self._id_1ED4 = ::_id_F580;

  if(isDefined(var_2))
    self._id_6A55 = var_2;
  else
    self._id_6A55 = 0.3;

  self._id_6A5C = undefined;
  self._id_6A5F = undefined;
  self._id_B005 = 0;

  if(isDefined(var_1))
    self._id_6A56 = clamp(var_1, 0.25, 4.0);
  else
    self._id_6A56 = 2.0;

  self._id_6A5C = % facial_gesture_look_rightleft;
  self._id_6A5F = % facial_gesture_look_updwn;
  self._id_6A5D = var_0;
  thread _id_194D();
  thread _id_1950();
  self._id_9BDC = 1;
}

_id_1959(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self notify("start_gesture_torso_lookat");

  if(isai(self))
    var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  else
    var_2 = undefined;

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(self._id_9CE9)) {
    _id_1967(0.25);
    wait 0.25;
  }

  if(isDefined(var_1))
    self._id_2B71 = var_1;
  else
    self._id_2B71 = 0.7;

  self._id_11A10 = undefined;
  self._id_B005 = 0;
  self._id_11A0C = % hm_grnd_grn_casual_stand_center_idle;
  self._id_11A0E = % hm_grnd_grn_casual_stand_left_idle;
  self._id_11A0F = % hm_grnd_grn_casual_stand_leftback_idle;
  self._id_11A11 = % hm_grnd_grn_casual_stand_right_idle;
  self._id_11A12 = % hm_grnd_grn_casual_stand_rightback_idle;
  self._id_77A3 = var_0;
  thread _id_1966();
  self._id_9CE9 = 1;
}

_id_F580() {
  return % body;
}

_id_110A5() {
  self._id_C3D4 = self._id_1ED4;
}

_id_E224() {
  self._id_1ED4 = self._id_C3D4;
}

_id_196A(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self._id_77A3 = var_0;
  self._id_9BFC = 1;

  if(isDefined(var_1)) {
    var_2 = self._id_778E;
    self._id_778E = var_1;
    wait(var_1 * 2);
    self._id_778E = var_2;
  }
}

_id_1956(var_0, var_1, var_2, var_3) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  while(!_id_1921())
    wait 0.05;

  while(distance2d(self.origin, var_0.origin) > var_3)
    wait 0.05;

  thread _id_1955(var_0, var_1, var_2);
  wait(var_2);

  for(;;) {
    wait(randomfloatrange(4.0, 5.0));

    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread _id_195A(1.0);
      thread _id_194F();
    }

    wait(randomfloatrange(4.0, 6.0));

    while(!_id_1921())
      wait 0.05;

    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread _id_195B(0.5);
      thread _id_194E(var_0, 1.0, 0.2);
    }
  }
}

_id_1969(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self._id_6A5D = var_0;
  self._id_9BDC = 1;

  if(isDefined(var_1)) {
    var_2 = self._id_6A56;
    self._id_6A56 = var_1;
    wait(var_1 * 2);
    self._id_6A56 = var_2;
  }
}

_id_1951() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self._id_2B71;
  var_1 = gettime() / 1000;
  var_2 = undefined;
  var_3 = % lookat_left_right;
  var_4 = self._id_8C5A;
  var_5 = self._id_8C62;
  var_6 = self._id_8C60;
  var_7 = self._id_8C63;
  var_8 = self._id_8C61;
  thread _id_1163();
  var_2 = vectortoangles(level.player.origin - self.origin);
  self _meth_82AC(var_4, 1.0, self._id_2B71);
  self _meth_82AC(var_5, 0.005, self._id_2B71);
  self _meth_82AC(var_6, 0.005, self._id_2B71);
  self _meth_82AC(var_7, 0.005, self._id_2B71);
  self _meth_82AC(var_8, 0.005, self._id_2B71);
  var_9 = 0;
  var_10 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self._id_77A3)) {
      thread _id_1964(0.7);
      break;
    }

    if(isPlayer(self._id_77A3))
      var_11 = level.player getEye();
    else if(isai(self._id_77A3))
      var_11 = self._id_77A3 getEye();
    else if(isvector(self._id_77A3))
      var_11 = self._id_77A3;
    else
      var_11 = self._id_77A3.origin;

    var_12 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_13 = self gettagorigin("J_Spine4");
    var_14 = vectorNormalize(var_11 - var_13);
    var_15 = anglestoright(var_12);
    var_16 = anglestoup(var_12);
    var_17 = anglestoup(var_12) * -1;
    var_18 = anglestoright(var_12) * -1;
    var_19 = anglesToForward(var_12);
    var_20 = clamp(vectordot(var_14, var_15), 0.005, 1);
    var_21 = clamp(vectordot(var_14, var_16), 0.005, 1);
    var_22 = clamp(vectordot(var_14, var_17), 0.005, 1);
    var_23 = clamp(vectordot(var_14, var_18), 0.005, 1);
    var_24 = 1;

    if(scripts\engine\utility::anglebetweenvectorssigned(var_15, var_14, var_19) > 0)
      var_24 = 0;

    self _meth_82AC(var_5, var_21, self._id_778E);
    self _meth_82AC(var_6, var_22, self._id_778E);
    self _meth_82AC(var_4, var_20 + 0.005, self._id_778E);

    if(var_24) {
      var_9 = scripts\sp\math::_id_AB6F(var_9, var_23, 0.1);
      var_10 = scripts\sp\math::_id_AB6F(var_10, 0.005, 0.1);
    } else {
      var_9 = scripts\sp\math::_id_AB6F(var_9, 0.005, 0.1);
      var_10 = scripts\sp\math::_id_AB6F(var_10, var_23, 0.1);
    }

    self _meth_82AC(var_7, var_9, self._id_778E);
    self _meth_82AC(var_8, var_10, self._id_778E);
    scripts\engine\utility::waitframe();
  }
}

_id_1163() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = gettime() / 1000;
  self._id_2B80 = 1;

  while(gettime() / 1000 - var_0 < self._id_2B71 * 2) {
    var_1 = (gettime() / 1000 - var_0) / (self._id_2B71 * 2);
    var_2 = _id_10384(0, 1, var_1);
    var_3 = _id_10384(0, 10, var_1);
    var_4 = _id_AB7A(0, 1, var_2);
    var_5 = _id_AB7A(0, 10, var_2);
    self _meth_82AC(%lookat_left_right, var_4, 0.2);
    self _meth_82AC(%lookat_up_down, var_4, 0.2);
    self _meth_82AC(%lookat_head_base_partial, var_5, 0.2);
    self _meth_82AC(%head_gesture_look_partial, var_5, 0.2);
    wait 0.05;
  }

  self _meth_82AC(%lookat_left_right, 1.0, 0.2);
  self _meth_82AC(%lookat_up_down, 1.0, 0.2);
  self _meth_82AC(%lookat_head_base_partial, 10.0, 0.2);
  self _meth_82AC(%head_gesture_look_partial, 10.0, 0.2);
  wait 0.05;
  self._id_2B80 = undefined;
}

_id_1953() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self _meth_82AC(%lookat_up_down, 1, self._id_2B71);
  self _meth_82AC(self._id_AFFA, 1, self._id_2B71);
  self _meth_82B0(self._id_AFFA, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self._id_77A3)) {
      var_1 = 0;

      if(level.player _meth_846D() == "safe")
        var_1 = 4.62;

      var_2 = level.player getEye() + anglestoup(self.angles) * var_1;
    } else if(isai(self._id_77A3))
      var_2 = self._id_77A3 getEye();
    else if(isvector(self._id_77A3))
      var_2 = self._id_77A3;
    else
      var_2 = self._id_77A3.origin;

    var_3 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_4 = self gettagorigin("J_Spine4");
    var_5 = undefined;

    if(isai(self))
      var_5 = self getEye();
    else
      var_5 = self gettagorigin("J_Head");

    var_6 = vectorNormalize(var_2 - var_5);
    var_7 = anglesToForward(var_3);
    var_8 = vectordot(var_7, var_6);
    var_9 = _id_6F41(var_8, 1, -1, 0.0, 1.0);
    var_0 = var_0 + (var_9 - var_0) * self._id_778E * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    _id_F5CD(self._id_AFFA, var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_1161() {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC(%lookat_head_adds, 1, 0.5);

  for(;;) {
    self _meth_82AC(%shipcrib_gst_head_idle_01, 0.25, 0.5);
    wait(getanimlength(%shipcrib_gst_head_idle_01) * randomfloatrange(1, 3));
  }
}

_id_194D() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC(%eyes_lookat_base_partial, 10, self._id_6A55 * 2);
  self _meth_82AC(%facial_gesture_look_partial, 10, self._id_6A55 * 2);
  self _meth_82AC(%eyes_look_leftright, 1, self._id_6A55);
  self _meth_82AC(self._id_6A5C, 1, self._id_6A55);
  self _meth_82B0(self._id_6A5C, 0.5);
  self _meth_82B1(self._id_6A5C, 0.0);
  var_0 = 0.0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self._id_6A5D)) {
      _id_194F(0.25);
      break;
    }

    if(isPlayer(self._id_6A5D))
      var_1 = level.player getEye();
    else if(isai(self._id_6A5D))
      var_1 = self._id_6A5D getEye();
    else if(isvector(self._id_6A5D))
      var_1 = self._id_6A5D;
    else
      var_1 = self._id_6A5D.origin;

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_5 = vectorNormalize(var_1 - var_3);
    var_6 = anglestoup(var_2);
    var_7 = scripts\engine\utility::flatten_vector(var_5);
    var_8 = scripts\engine\utility::flatten_vector(var_6);
    var_9 = vectordot(var_8, var_7);
    var_10 = _id_6F41(var_9, 1.0, -1.0, 0.0, 1.0);
    var_11 = clamp(var_10, 0, 1);
    self _meth_82B0(self._id_6A5C, var_11);
    scripts\engine\utility::waitframe();
  }
}

_id_1950() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC(%eyes_look_updown, 1, self._id_6A55);
  self _meth_82AC(self._id_6A5F, 1, self._id_6A55);
  self _meth_82B0(self._id_6A5F, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self._id_6A5D))
      var_1 = level.player getEye();
    else if(isai(self._id_6A5D))
      var_1 = self._id_6A5D getEye();
    else if(isvector(self._id_6A5D))
      var_1 = self._id_6A5D;
    else
      var_1 = self._id_6A5D.origin;

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4");
    var_5 = anglesToForward(var_2);
    var_6 = vectorNormalize(var_1 - var_3);
    var_7 = vectordot(var_5, var_6);
    var_8 = _id_6F41(var_7, 1.0, -1.0, 0.3, 0.7);
    var_9 = clamp(var_8, 0, 1);
    var_0 = var_0 + (var_9 - var_0) * self._id_6A56 * 0.3;
    var_0 = clamp(var_0, 0.1, 0.9);
    _id_F5CD(self._id_6A5F, var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_1966() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var_0 = undefined;
  var_1 = % torso_tracking_anims;
  var_2 = self._id_11A0C;
  var_3 = self._id_11A11;
  var_4 = self._id_11A0E;
  var_5 = self._id_11A12;
  var_6 = self._id_11A0F;
  childthread _id_1165();
  var_0 = vectortoangles(level.player.origin - self.origin);
  self _meth_82AC(var_2, 1.0, 0.05);
  self _meth_82AC(var_3, 0.0, 0.05);
  self _meth_82AC(var_4, 0.0, 0.05);
  self _meth_82AC(var_5, 0.0, 0.05);
  self _meth_82AC(var_6, 0.0, 0.05);
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self._id_77A3))
      var_9 = level.player getEye();
    else if(isai(self._id_77A3))
      var_9 = self._id_77A3 getEye();
    else if(isvector(self._id_77A3))
      var_9 = self._id_77A3;
    else
      var_9 = self._id_77A3.origin;

    var_10 = vectorNormalize(var_9 - self.origin);
    var_11 = anglesToForward(self.angles);
    var_12 = anglestoright(self.angles);
    var_13 = anglestoright(self.angles) * -1;
    var_14 = anglesToForward(self.angles) * -1;
    var_15 = anglestoup(self.angles);
    var_16 = clamp(vectordot(var_10, var_11), 0, 1);
    var_17 = clamp(vectordot(var_10, var_12), 0, 1);
    var_18 = clamp(vectordot(var_10, var_13), 0, 1);
    var_19 = clamp(vectordot(var_10, var_14), 0, 1);
    var_20 = 1;

    if(scripts\engine\utility::anglebetweenvectorssigned(var_11, var_10, var_15) > 0)
      var_20 = 0;

    self _meth_82AC(var_3, var_17, 0.2);
    self _meth_82AC(var_4, var_18, 0.2);
    self _meth_82AC(var_2, var_16 + 0.005, 0.2);

    if(var_20) {
      var_7 = scripts\sp\math::_id_AB6F(var_7, var_19, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::_id_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, var_19, 0.1);
    }

    self _meth_82AC(var_5, var_7, 0.2);
    self _meth_82AC(var_6, var_8, 0.2);
    scripts\engine\utility::waitframe();
  }
}

_id_1165() {
  var_0 = gettime() / 1000;

  while(gettime() / 1000 - var_0 < self._id_2B71) {
    var_1 = (gettime() / 1000 - var_0) / self._id_2B71;
    var_1 = _id_10384(0, 1, var_1);
    var_2 = _id_AB7A(0, 1, var_1);
    self _meth_82AC(%torso_tracking_anims, var_2, 0.05);
    wait 0.05;
    waittillframeend;
  }

  self _meth_82AC(%torso_tracking_anims, 1.0, 0.05);
}

_id_1948(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  _id_1963();

  for(;;) {
    wait(randomfloatrange(var_0 * 0.5, var_0));
    self clearanim(%facial_gesture_blink_1, 0.0);
    wait 0.05;
    self _meth_82AC(%facial_gesture_blink_1, 1, 0.0);
    scripts\engine\utility::waitframe();
  }
}

_id_1963() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(self)) {
    return;
  }
  self _meth_82AC(%eyes_blink, 1, 0.0);
  self clearanim(%facial_gesture_blink_1, 0.0);
  wait 0.05;
  self _meth_82AC(%facial_gesture_blink_1, 1, 0.0);
}

_id_195D(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self._id_D633 = undefined;
  self._id_D639 = undefined;
  self._id_D63B = undefined;
  self._id_D63D = undefined;
  self._id_D635 = undefined;
  self._id_C00A = 0;
  self._blackboard._id_D636 = 1;
  var_1 = scripts\asm\asm::asm_getdemeanor();
  var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  _id_0A1E::_id_2381(self.asmname, var_2);

  if(var_1 != "casual" && var_1 != "casual_gun")
    self._id_77AD = % gesture_partials;
  else
    self._id_77AD = % point_at_without_head;

  if(!scripts\asm\asm::_id_231B(self.asmname, "gesture"))
    return;
  else if(var_1 == "casual" || var_1 == "combat" || var_1 == "casual_gun" || var_1 == "frantic") {
    self._id_D633 = self.asm._id_77C1._id_77AA;
    self._id_D639 = self.asm._id_77C1._id_77AC;
    self._id_D63B = self.asm._id_77C1._id_77AE;
    self._id_D63D = self.asm._id_77C1._id_77AF;
    self._id_D635 = self.asm._id_77C1._id_77AB;
    self._id_778D = _id_0A1E::_id_2357(self.asm.archetype, "Knobs", "body");
  } else
    return;

  if(isPlayer(var_0))
    var_3 = level.player getEye();
  else if(!isDefined(var_0)) {
    var_3 = self.origin;
    self._id_C00A = 1;
  } else if(isai(var_0))
    var_3 = var_0 getEye();
  else if(isvector(var_0))
    var_3 = var_0;
  else
    var_3 = var_0.origin;

  var_4 = self gettagangles("J_Spine4") + (0, 90, 0);
  var_5 = self gettagorigin("J_Spine4");
  var_6 = anglestoright(var_4);
  var_7 = anglestoup(var_4);
  var_8 = vectorNormalize(var_3 - var_5);
  var_9 = scripts\engine\utility::flatten_vector(var_6);
  var_10 = scripts\engine\utility::flatten_vector(var_7);
  var_11 = scripts\engine\utility::flatten_vector(var_8);
  var_12 = vectordot(var_9, var_11) * -1;
  var_13 = var_12 * -1.0;
  var_14 = clamp(_id_6F41(var_12, 0.2, 1.0, 0, 1), 0, 1);
  var_15 = clamp(_id_6F41(var_13, 0.2, 1, 0, 1), 0, 1);
  var_16 = self gettagorigin("J_Spine4");
  var_17 = vectorNormalize(var_3 - var_16);
  var_18 = anglesToForward(var_4);
  var_19 = vectordot(var_17, var_18);
  var_20 = var_19 * -1.0;
  var_21 = vectordot(var_7, var_17);
  var_22 = clamp(_id_6F41(var_21, 0.2, 1, 0, 1), 0, 1);
  var_23 = clamp(_id_6F41(var_19, 0.2, 1, 0, 1), 0, 1);
  var_24 = clamp(_id_6F41(var_20, 0.2, 1, 0, 1), 0, 1);

  if(!self._id_C00A) {
    if(var_21 < -0.9)
      _id_1960("fallback_up");
    else {
      if(var_1 != "casual" && var_1 != "casual_gun")
        self _meth_82AC(self._id_77AD, 10.0, 0.25);
      else
        self _meth_82AC(self._id_77AD, 1.0, 0.25);

      if(var_22 < 0.3)
        self _meth_82AC(self._id_D633, 0, 0, 0.85);
      else
        self _meth_82AC(self._id_D633, var_22, 0.25, 0.85);

      if(isDefined(self._id_D63D))
        self _meth_82AC(self._id_D63D, var_23, 0.25, 0.85);

      if(isDefined(self._id_D635))
        self _meth_82AC(self._id_D635, var_24, 0.2, 0.85);

      self _meth_82AC(self._id_D639, var_15, 0.25, 0.85);
      self _meth_82AC(self._id_D63B, var_14, 0.25, 0.85);
    }
  } else {
    if(var_1 != "casual" && var_1 != "casual_gun")
      self _meth_82AC(self._id_77AD, 10.0, 0.2);
    else
      self _meth_82AC(self._id_77AD, 1.0, 0.2);

    self _meth_82AC(self._id_D633, 1, 0.2, 0.85);
  }

  var_25 = getanimlength(%prototype_gesture_point_center) * 0.85;
  wait(var_25);
  self clearanim(self._id_77AD, 0.25);
  self _meth_82AC(self._id_778D, 1.0, 0.25);
  self._blackboard._id_D636 = 0;
}

_id_1960(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self._id_D633 = undefined;
  self._id_778D = undefined;
  self._id_9C5F = 0;
  var_1 = "casual";
  var_2 = undefined;

  if(isai(self)) {
    self._blackboard._id_778B = 1;
    var_1 = scripts\asm\asm::asm_getdemeanor();
    var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  }

  var_3 = ["shrug", "cross", "nod", "salute", "wave", "wait", "fallback_up"];
  var_4 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_5 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_6 = ["shrug", "cross", "nod", "salute", "wave", "wait", "move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];

  if(!scripts\engine\utility::array_contains(var_3, var_0) && !scripts\engine\utility::array_contains(var_4, var_0)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(isai(self) && !scripts\asm\asm::_id_231B(self.asmname, "gesture"))
    return;
  else if(isai(self)) {
    self._id_778D = _id_0A1E::_id_2357(self.asm.archetype, "Knobs", "body");

    if(var_1 == "casual") {
      if(scripts\engine\utility::array_contains(var_3, var_0)) {
        self._id_77B6 = self.asm._id_77C1._id_77B6;
        self._id_778F = self.asm._id_77C1._id_778F;
        self._id_77A7 = self.asm._id_77C1._id_77A7;
        self._id_77B4 = self.asm._id_77C1._id_77B4;
        self._id_77BF = self.asm._id_77C1._id_77BF;
        self._id_77BE = self.asm._id_77C1._id_77BE;
        self._id_7795 = self.asm._id_77C1._id_7795;
      } else
        return;
    } else if(var_1 == "casual_gun") {
      if(scripts\engine\utility::array_contains(var_6, var_0)) {
        self._id_77B6 = self.asm._id_77C1._id_77B6;
        self._id_778F = self.asm._id_77C1._id_778F;
        self._id_77A7 = self.asm._id_77C1._id_77A7;
        self._id_77B4 = self.asm._id_77C1._id_77B4;
        self._id_77BF = self.asm._id_77C1._id_77BF;
        self._id_77BE = self.asm._id_77C1._id_77BE;
        self._id_77A6 = self.asm._id_77C1._id_77A6;
        self._id_77A8 = self.asm._id_77C1._id_77A8;
        self._id_77A0 = self.asm._id_77C1._id_77A0;
        self._id_7795 = self.asm._id_77C1._id_7795;
        self._id_7794 = self.asm._id_77C1._id_7794;
        self._id_778C = self.asm._id_77C1._id_778C;
      } else
        return;
    } else if(var_1 == "combat") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self._id_77A6 = self.asm._id_77C1._id_77A6;
        self._id_77A8 = self.asm._id_77C1._id_77A8;
        self._id_77A0 = self.asm._id_77C1._id_77A0;
        self._id_7795 = self.asm._id_77C1._id_7795;
        self._id_7794 = self.asm._id_77C1._id_7794;
        self._id_778C = self.asm._id_77C1._id_778C;
      } else
        return;
    } else if(var_1 == "cqb") {
      if(scripts\engine\utility::array_contains(var_5, var_0)) {
        self._id_77A6 = self.asm._id_77C1._id_77A6;
        self._id_77A8 = self.asm._id_77C1._id_77A8;
        self._id_77A0 = self.asm._id_77C1._id_77A0;
        self._id_7795 = self.asm._id_77C1._id_7795;
        self._id_7794 = self.asm._id_77C1._id_7794;
        self._id_778C = self.asm._id_77C1._id_778C;
      } else
        return;
    } else if(var_1 == "frantic") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self._id_77A6 = self.asm._id_77C1._id_77A6;
        self._id_77A8 = self.asm._id_77C1._id_77A8;
        self._id_77A0 = self.asm._id_77C1._id_77A0;
        self._id_7795 = self.asm._id_77C1._id_7795;
        self._id_7794 = self.asm._id_77C1._id_7794;
        self._id_778C = self.asm._id_77C1._id_778C;
      } else
        return;
    } else
      return;
  } else {
    self._id_77B6 = % shipcrib_gst_body_shrug_01;
    self._id_778F = % shipcrib_gst_body_cross_01;
    self._id_77A7 = % shipcrib_gst_head_nod_01;
    self._id_77B4 = % shipcrib_gst_head_salute_01;
    self._id_77BF = % shipcrib_gst_body_wave_01;
    self._id_77BE = % shipcrib_gst_body_wait_01;
    self._id_7795 = % hm_grnd_org_gest_fallback_up;
  }

  var_7 = undefined;

  switch (var_0) {
    case "shrug":
      var_7 = self._id_77B6;
      break;
    case "cross":
      var_7 = self._id_778F;
      break;
    case "nod":
      var_7 = self._id_77A7;
      break;
    case "salute":
      var_7 = self._id_77B4;
      break;
    case "wave":
      var_7 = self._id_77BF;
      break;
    case "wait":
      var_7 = self._id_77BE;
      break;
    case "hold":
      self._id_9C5F = 1;
      var_7 = self._id_77A0;
      break;
    case "on_me":
      self._id_9C5F = 1;
      var_7 = self._id_77A8;
      break;
    case "move_up":
      self._id_9C5F = 1;
      var_7 = self._id_77A6;
      break;
    case "fallback_up":
      self._id_9C5F = 1;
      var_7 = self._id_7795;
      break;
    case "fallback_down":
      self._id_9C5F = 1;
      var_7 = self._id_7794;
      break;
    case "arm_up":
      self._id_9C5F = 1;
      var_7 = self._id_778C;
      break;
  }

  if(self._id_9C5F)
    self._id_101F8 = % gesture_partials;
  else
    self._id_101F8 = % add_gesture;

  if(self._id_9C5F)
    thread _id_2B79(self._id_101F8, var_7, 0.5);
  else {
    self _meth_82AC(self._id_101F8, 1.0, 0.5);
    self _meth_82AC(var_7, 1.0, 0.5, 0.75);
  }

  var_8 = getanimlength(var_7) * 0.85;
  wait(var_8);

  if(self._id_9C5F)
    thread _id_2B7A(self._id_101F8, var_7, 0.5);
  else {
    self clearanim(self._id_101F8, 0.5);
    self clearanim(var_7, 0.5);
  }

  self._id_9C5F = 0;

  if(isai(self))
    self._blackboard._id_778B = undefined;
}

_id_2B79(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * 0.5;
  self _meth_82AC(var_0, 1.0, var_4);
  self _meth_82AC(var_1, 1.0, var_4, 0.75);
  wait(var_2 * 0.5);
  self _meth_82AC(var_1, 10.0, var_4, 0.75);
  self _meth_82AC(var_0, 10.0, var_4);
}

_id_2B7A(var_0, var_1, var_2) {
  var_3 = var_2 * 0.5;
  self _meth_82AC(var_0, 1.0, var_3);
  self _meth_82AC(var_1, 1.0, var_3);
  wait(var_3);
  self clearanim(var_0, var_3);
  self clearanim(var_1, var_3);
}

_id_6F41(var_0, var_1, var_2, var_3, var_4) {
  return (var_0 - var_1) / (var_2 - var_1) * (var_4 - var_3) + var_3;
}

_id_AB7A(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

_id_10384(var_0, var_1, var_2) {
  var_2 = clamp((var_2 - var_0) / (var_1 - var_0), 0.0, 1.0);
  return var_2 * var_2 * (3 - 2 * var_2);
}

_id_F5CD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.25;

  var_4 = self islegacyagent(var_0);
  var_5 = getanimlength(var_0);
  var_6 = (var_1 - var_4) * var_5 / 0.05;

  if(self.unittype == "c6")
    _id_12FB2();

  self _meth_82AC(var_0, var_2, var_3, var_6);
}

_id_194C(var_0, var_1, var_2) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_3 = var_1;
  var_4 = var_1[0];
  var_5 = var_1[1];
  var_6 = var_1[2];
  var_7 = var_1[3];
  var_8 = var_1[4];
  var_9 = 0;
  var_10 = undefined;
  self._id_C00A = 0;
  var_11 = undefined;

  if(isDefined(var_2)) {
    var_10 = _id_0A1E::_id_2357(self.asm.archetype, "Knobs", "body");
    var_11 = % gesture_partials;
  } else
    var_11 = % add_gesture;

  if(!isDefined(self)) {
    return;
  }
  if(isPlayer(var_0))
    var_12 = level.player getEye();
  else if(!isDefined(var_0)) {
    var_12 = self.origin;
    var_9 = 1;
  } else if(isai(var_0))
    var_12 = var_0 getEye();
  else if(isvector(var_0))
    var_12 = var_0;
  else
    var_12 = var_0.origin;

  var_13 = self gettagangles("tag_origin");
  var_14 = self gettagorigin("tag_origin");
  var_15 = anglestoright(var_13);
  var_16 = anglesToForward(var_13);
  var_17 = vectorNormalize(var_12 - var_14);
  var_18 = scripts\engine\utility::flatten_vector(var_15);
  var_19 = scripts\engine\utility::flatten_vector(var_16);
  var_20 = scripts\engine\utility::flatten_vector(var_17);
  var_21 = vectordot(var_18, var_20);
  var_22 = var_21 * -1.0;
  var_23 = clamp(_id_6F41(var_21, 0.2, 1.0, 0, 1), 0, 1);
  var_24 = clamp(_id_6F41(var_22, 0.2, 1, 0, 1), 0, 1);
  var_25 = self gettagorigin("J_Spine4");
  var_26 = vectorNormalize(var_12 - var_25);
  var_27 = anglestoup(var_13);
  var_28 = vectordot(var_26, var_27);
  var_29 = var_28 * -1.0;
  var_30 = vectordot(var_19, var_26);
  var_31 = clamp(_id_6F41(var_30, 0.2, 1, 0, 1), 0, 1);
  var_32 = clamp(_id_6F41(var_28, 0.2, 1, 0, 1), 0, 1);
  var_33 = clamp(_id_6F41(var_29, 0.2, 1, 0, 1), 0, 1);

  if(!self._id_C00A) {
    if(isDefined(var_2))
      self _meth_82AC(var_11, 10.0, 0.25);
    else
      self _meth_82AC(var_11, 1.0, 0.25);

    if(var_31 < 0.3)
      self _meth_82AC(var_4, 0, 0, 1);
    else
      self _meth_82AC(var_4, var_31, 0.25, 1);

    if(isDefined(var_7))
      self _meth_82AC(var_7, var_32, 0.25, 1);

    if(isDefined(var_8))
      self _meth_82AC(var_8, var_33, 0.25, 1);

    self _meth_82AC(var_5, var_24, 0.25, 1);
    self _meth_82AC(var_6, var_23, 0.25, 1);
  } else {
    if(isDefined(var_2))
      self _meth_82AC(var_10, 0.001, 0.1);

    self _meth_82AC(var_11, 1.0, 0.25);
    self _meth_82AC(var_4, 1, 0.25);
  }

  var_34 = getanimlength(var_4);
  wait(var_34);
  self clearanim(var_11, 0.25);
  self _meth_82AC(var_10, 1.0, 0.25);
}

_id_192F(var_0, var_1) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  var_2 = % add_gesture;
  var_3 = 0;
  var_4 = "single anim";
  thread scripts\sp\anim::_id_10CBF(self, var_4, undefined, undefined, var_0);

  if(isDefined(var_1) && var_1) {
    var_2 = % gesture_partials;
    var_3 = 1;
  }

  if(var_3)
    thread _id_2B79(var_2, var_0, 0.2);
  else {
    self _meth_82AC(var_2, 1.0, 0.1);
    self _meth_82AC(var_0, 1.0, 0.1);
  }

  var_5 = getanimlength(var_0) * 0.75 - 0.2;
  wait(var_5);

  if(var_3)
    thread _id_2B7A(var_2, var_0, 0.2);
  else {
    self clearanim(var_2, 0.2);
    self clearanim(var_0, 0.2);
  }
}

#using_animtree("c6");

_id_12FB2() {
  self._id_AFF7 = % prototype_gesture_look_rightleft;
  self._id_AFFA = % prototype_gesture_look_updwn;
}

_id_1952() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self._id_2B71;
  var_1 = gettime() / 1000;

  while(gettime() / 1000 - var_1 < var_0) {
    var_2 = (gettime() / 1000 - var_1) / var_0;
    var_2 = _id_10384(0, 1, var_2);
    var_3 = _id_AB7A(0, 1, var_2);
    var_4 = _id_AB7A(0, 1, var_2);
    var_5 = _id_AB7A(0, 5, var_2);
    var_6 = _id_AB7A(0, 5, var_2);
    self _meth_82AC(%lookat_left_right, var_3, 0.05);
    self _meth_82AC(self._id_AFF7, var_4, 0.05);
    self _meth_82AC(%lookat_head_base_partial, var_5, 0.05);
    self _meth_82AC(%head_gesture_look_partial, var_6, 0.05);
    self _meth_82B0(self._id_AFF7, 0.5);
    wait 0.05;
    waittillframeend;
  }

  self _meth_82AC(%lookat_left_right, 1, 0.05);
  self _meth_82AC(self._id_AFF7, 1, 0.05);
  self _meth_82AC(%lookat_head_base_partial, 5, 0.05);
  self _meth_82AC(%head_gesture_look_partial, 5, 0.05);
  var_7 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self._id_77A3))
      var_8 = level.player getEye();
    else if(isai(self._id_77A3))
      var_8 = self._id_77A3 getEye();
    else if(isvector(self._id_77A3))
      var_8 = self._id_77A3;
    else
      var_8 = self._id_77A3.origin;

    var_9 = self gettagangles("J_Head");
    var_10 = self gettagorigin("J_Head");
    var_11 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_12 = self gettagorigin("J_Spine4");
    var_13 = vectorNormalize(var_8 - var_12);
    var_14 = anglestoright(var_11);
    var_15 = scripts\engine\utility::flatten_vector(var_14);
    var_16 = scripts\engine\utility::flatten_vector(var_13);
    var_17 = vectordot(var_15, var_16);
    var_18 = _id_6F41(var_17, -1.0, 1.0, 0.0, 1.0);
    var_18 = clamp(var_18, 0.0, 1.0);
    var_7 = var_7 + (var_18 - var_7) * self._id_778E;
    var_7 = clamp(var_7, 0.1, 0.9);
    _id_F5CD(self._id_AFF7, var_7, 1);
    scripts\engine\utility::waitframe();
  }
}

_id_1954() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self _meth_82AC(%lookat_up_down, 1, self._id_2B71);
  self _meth_82AC(self._id_AFFA, 1, self._id_2B71);
  self _meth_82B0(self._id_AFFA, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self._id_77A3))
      var_1 = level.player getEye();
    else if(isai(self._id_77A3))
      var_1 = self._id_77A3 getEye();
    else if(isvector(self._id_77A3))
      var_1 = self._id_77A3;
    else
      var_1 = self._id_77A3.origin;

    var_2 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_3 = self gettagorigin("J_Spine4");
    var_4 = undefined;

    if(isai(self))
      var_4 = self getEye();
    else
      var_4 = self gettagorigin("J_Head");

    var_5 = vectorNormalize(var_1 - var_4);
    var_6 = anglesToForward(var_2);
    var_7 = vectordot(var_6, var_5);
    var_8 = _id_6F41(var_7, 1, -1, 0.0, 1.0);
    var_0 = var_0 + (var_8 - var_0) * self._id_778E * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    _id_F5CD(self._id_AFFA, var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_1965(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("gesture_stop");

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  self _meth_82AC(%lookat_left_right, 1.0, var_1 * 0.15);
  self _meth_82AC(%lookat_up_down, 1.0, var_1 * 0.15);
  self _meth_82AC(%lookat_head_base_partial, 1.0, var_1 * 0.15);
  self _meth_82AC(%head_gesture_look_partial, 1.0, var_1 * 0.15);
  wait(var_1 * 0.15);
  self clearanim(%lookat_left_right, var_1 * 0.85);
  self clearanim(%lookat_up_down, var_1 * 0.85);
  self clearanim(%lookat_head_base_partial, var_1 * 0.85);
  self clearanim(%head_gesture_look_partial, var_1 * 0.85);
  self._id_9BFC = undefined;
}

#using_animtree("generic_human");

_id_2B8A() {
  var_0 = self;
  self endon(self._id_6317);
  var_0._id_7540 = undefined;
  var_0._id_E512 = undefined;
  var_0._id_AB35 = undefined;
  var_0._id_AB54 = undefined;
  var_0._id_E52E = undefined;

  foreach(var_2 in var_0._id_1E9D) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_7540 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_E512 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_AB35 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_AB54 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_E52E = level._id_EC85[var_0._id_1FBB][var_2];
    }
  }

  var_4 = getstartorigin(self._id_1FBD.origin, self._id_1FBD.angles, var_0._id_7540);
  var_5 = getstartangles(self._id_1FBD.origin, self._id_1FBD.angles, var_0._id_7540);

  if(isai(var_0))
    var_0 _meth_80F1(var_4, var_5, 10000);
  else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 _meth_82A5(var_0._id_7540, %root, 1.0, 0.2);

  if(isDefined(var_0._id_E512))
    var_0 _meth_82AC(var_0._id_E512, 0.0, 0.2);

  if(isDefined(var_0._id_AB35))
    var_0 _meth_82AC(var_0._id_AB35, 0.0, 0.2);

  if(isDefined(var_0._id_AB54))
    var_0 _meth_82AC(var_0._id_AB54, 0.0, 0.2);

  if(isDefined(var_0._id_E52E))
    var_0 _meth_82AC(var_0._id_E52E, 0.0, 0.2);

  var_7 = 0;
  var_8 = 0;
  var_0 _meth_8250(1);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0._id_77A3))
      var_9 = level.player getEye();
    else if(isai(var_0._id_77A3))
      var_9 = var_0._id_77A3 getEye();
    else if(isvector(var_0._id_77A3))
      var_9 = var_0._id_77A3;
    else
      var_9 = var_0._id_77A3.origin;

    var_10 = var_0 gettagangles("tag_origin");
    var_11 = var_0 gettagorigin("tag_origin");
    var_12 = scripts\engine\utility::flatten_vector(vectorNormalize(var_9 - var_11));
    var_13 = anglesToForward(var_10);
    var_14 = anglestoright(var_10);
    var_15 = anglestoright(var_10) * -1;
    var_16 = anglesToForward(var_10) * -1;
    var_17 = anglestoup(var_10);
    var_18 = clamp(vectordot(var_12, var_13), 0, 1);
    var_19 = clamp(vectordot(var_12, var_14), 0, 1);
    var_20 = clamp(vectordot(var_12, var_15), 0, 1);
    var_21 = clamp(vectordot(var_12, var_16), 0, 1);
    var_22 = 1;

    if(scripts\engine\utility::anglebetweenvectorssigned(var_13, var_12, var_17) > 0)
      var_22 = 0;

    if(isDefined(var_0._id_E512))
      var_0 _meth_82AC(var_0._id_E512, var_19, 0.2);

    if(isDefined(var_0._id_AB35))
      var_0 _meth_82AC(var_0._id_AB35, var_20, 0.2);

    var_0 _meth_82AC(var_0._id_7540, var_18 + 0.005, 0.2);

    if(var_22) {
      var_7 = scripts\sp\math::_id_AB6F(var_7, var_21, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::_id_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, var_21, 0.1);
    }

    if(isDefined(var_0._id_E52E))
      var_0 _meth_82AC(var_0._id_E52E, var_7 + 0.005, 0.2);

    if(isDefined(var_0._id_AB54))
      var_0 _meth_82AC(var_0._id_AB54, var_8 + 0.005, 0.2);

    scripts\engine\utility::waitframe();
    waittillframeend;
  }
}

_id_2B8B() {
  var_0 = self;

  if(isDefined(var_0._id_6317))
    var_0 notify(var_0._id_6317);

  var_0 clearanim(var_0._id_7540, 0.2);

  if(isDefined(var_0._id_E512))
    var_0 clearanim(var_0._id_E512, 0.2);

  if(isDefined(var_0._id_AB35))
    var_0 clearanim(var_0._id_AB35, 0.2);

  if(isDefined(var_0._id_AB54))
    var_0 clearanim(var_0._id_AB54, 0.2);

  if(isDefined(var_0._id_E52E))
    var_0 clearanim(var_0._id_E52E, 0.2);

  var_0 _meth_8250(0);
  var_0._id_7540 = undefined;
  var_0._id_E512 = undefined;
  var_0._id_AB35 = undefined;
  var_0._id_AB54 = undefined;
  var_0._id_E52E = undefined;
  var_0._id_1E9D = undefined;
  var_0._id_6317 = undefined;
  var_0._id_77A3 = undefined;
}

_id_2B86() {
  var_0 = self;
  var_0._id_7540 = undefined;
  var_0._id_E512 = undefined;
  var_0._id_AB35 = undefined;
  var_0._id_AB54 = undefined;
  var_0._id_E52E = undefined;

  foreach(var_2 in var_0._id_1E9D) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_7540 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_E512 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_AB35 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_AB54 = level._id_EC85[var_0._id_1FBB][var_2];

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level._id_EC85[var_0._id_1FBB][var_2]))
        var_0._id_E52E = level._id_EC85[var_0._id_1FBB][var_2];
    }
  }

  var_4 = getstartorigin(self._id_1FBD.origin, self._id_1FBD.angles, var_0._id_7540);
  var_5 = getstartangles(self._id_1FBD.origin, self._id_1FBD.angles, var_0._id_7540);

  if(isai(var_0))
    var_0 _meth_80F1(var_4, var_5, 10000);
  else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 _meth_82A5(var_0._id_7540, %root, 1.0, 0.2);

  if(isDefined(var_0._id_E512))
    var_0 _meth_82AC(var_0._id_E512, 0.0, 0.2);

  if(isDefined(var_0._id_AB35))
    var_0 _meth_82AC(var_0._id_AB35, 0.0, 0.2);

  if(isDefined(var_0._id_AB54))
    var_0 _meth_82AC(var_0._id_AB54, 0.0, 0.2);

  if(isDefined(var_0._id_E52E))
    var_0 _meth_82AC(var_0._id_E52E, 0.0, 0.2);

  var_7 = 0;
  var_8 = 0;
  var_9 = gettime() / 1000;
  var_10 = getanimlength(var_0._id_7540);

  while(gettime() / 1000 - var_9 < var_10) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0._id_77A3))
      var_11 = level.player getEye();
    else if(isai(var_0._id_77A3))
      var_11 = var_0._id_77A3 getEye();
    else if(isvector(var_0._id_77A3))
      var_11 = var_0._id_77A3;
    else
      var_11 = var_0._id_77A3.origin;

    var_12 = var_0 gettagangles("tag_origin");
    var_13 = var_0 gettagorigin("tag_origin");
    var_14 = scripts\engine\utility::flatten_vector(vectorNormalize(var_11 - var_13));
    var_15 = anglesToForward(var_12);
    var_16 = anglestoright(var_12);
    var_17 = anglestoright(var_12) * -1;
    var_18 = anglesToForward(var_12) * -1;
    var_19 = anglestoup(var_12);
    var_20 = clamp(vectordot(var_14, var_15), 0, 1);
    var_21 = clamp(vectordot(var_14, var_16), 0, 1);
    var_22 = clamp(vectordot(var_14, var_17), 0, 1);
    var_23 = clamp(vectordot(var_14, var_18), 0, 1);
    var_24 = 1;

    if(scripts\engine\utility::anglebetweenvectorssigned(var_15, var_14, var_19) > 0)
      var_24 = 0;

    if(isDefined(var_0._id_E512))
      var_0 _meth_82AC(var_0._id_E512, var_21, 0.2);

    if(isDefined(var_0._id_AB35))
      var_0 _meth_82AC(var_0._id_AB35, var_22, 0.2);

    var_0 _meth_82AC(var_0._id_7540, var_20 + 0.005, 0.2);

    if(var_24) {
      var_7 = scripts\sp\math::_id_AB6F(var_7, var_23, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::_id_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::_id_AB6F(var_8, var_23, 0.1);
    }

    if(isDefined(var_0._id_E52E))
      var_0 _meth_82AC(var_0._id_E52E, var_7 + 0.005, 0.2);

    if(isDefined(var_0._id_AB54))
      var_0 _meth_82AC(var_0._id_AB54, var_8 + 0.005, 0.2);

    scripts\engine\utility::waitframe();
    waittillframeend;
  }

  var_0 thread _id_2B8B();
}