/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3148.gsc
*********************************************/

func_3DF2(var_0, var_1, var_2, var_3) {
  if(isDefined(self.enemy)) {
    var_4 = distancesquared(self.origin, self.enemy.origin);
    if(var_4 < 65536) {
      return 0;
    }

    if(isai(self.enemy)) {
      if(!isDefined(self.enemy scripts\asm\asm_bb::bb_getcovernode()) || self.enemy scripts\asm\asm_bb::bb_getrequestedcoverstate() != "hide") {
        return 0;
      }
    } else if(var_4 < 262144) {
      return 0;
    }
  }

  if(isDefined(self._blackboard.var_28D0)) {
    if(self._blackboard.var_28D0 == var_3) {
      return 1;
    }

    return 0;
  }

  return 0;
}

func_3EBB(var_0, var_1, var_2) {
  var_3 = undefined;
  if(isDefined(self._blackboard.var_28DE)) {
    var_3 = self._blackboard.var_28DE.origin;
  } else {
    var_3 = level.player.origin + anglesToForward(level.player.angles) * 6000;
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_5 = scripts\asm\asm_bb::bb_getcovernode();
    if(isDefined(var_5)) {
      var_6 = var_5.angles;
    } else {
      var_6 = self.angles;
    }

    var_4 = func_7818(var_6, self.origin, var_3);
  }

  var_7 = lib_0A1E::func_2356(var_1, var_4);
  if(!isDefined(var_7)) {
    var_7 = lib_0A1E::func_2356(var_1, "8");
  }

  return var_7;
}

func_CEE9(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._blackboard.var_28D1 = 1;
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  self clearanim(var_4, var_2);
  self._blackboard.var_28D0 = undefined;
  self._blackboard.var_28D1 = undefined;
}

func_980D(var_0, var_1, var_2, var_3) {}

func_D48B(var_0, var_1, var_2, var_3) {}

func_3EDA(var_0, var_1, var_2, var_3) {}

func_195F() {
  if(isDefined(self._blackboard.var_778B) && self._blackboard.var_778B) {
    return 1;
  }

  return 0;
}

func_19D2() {
  if(isDefined(self._blackboard.var_D636) && self._blackboard.var_D636) {
    return 1;
  }

  return 0;
}

func_12F2(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectornormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);
  if(var_4 >= var_1) {
    return 1;
  }

  return 0;
}

func_7818(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = angleclamp180(var_3[1] - var_0[1]);
  var_5 = getangleindex(var_4, 10);
  var_6 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var_6[var_5];
}

func_1964(var_0) {
  self notify("new_gesture_stop_begin");
  self notify("gesture_stop");
  self endon("death");
  self endon("start_gesture_lookat");
  self endon("new_gesture_stop_begin");
  self endon("entitydeleted");
  if(isDefined(self.var_1ED4) && isDefined(self.var_C3D4)) {
    func_E224();
  }

  if(isDefined(self.var_1ED4) && !isDefined(self.var_C3D4)) {
    self.var_1ED4 = undefined;
  }

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 0.25;
  }

  if(!isDefined(self.var_9BFC)) {
    return;
  }

  var_2 = gettime() / 1000;
  var_3 = self func_8103(self.var_8C5A);
  var_4 = self func_8103(self.var_8C62);
  var_5 = self func_8103(self.var_8C60);
  var_6 = self func_8103(self.var_8C63);
  var_7 = self func_8103(self.var_8C61);
  var_8 = self func_8103(%lookat_left_right);
  var_9 = self func_8103(%lookat_up_down);
  var_10 = self func_8103(%lookat_head_base_partial);
  var_11 = self func_8103(%head_gesture_look_partial);
  var_12 = self func_8103(%lookat_head_adds);
  while(gettime() / 1000 - var_2 < var_0) {
    var_13 = gettime() / 1000 - var_2 / var_0;
    var_13 = func_10384(0, 1, var_13);
    var_14 = func_AB7A(var_3, 1, var_13);
    var_15 = func_AB7A(var_4, 0, var_13);
    var_10 = func_AB7A(var_5, 0, var_13);
    var_11 = func_AB7A(var_6, 0, var_13);
    var_12 = func_AB7A(var_7, 0, var_13);
    var_13 = func_AB7A(var_8, 0, var_13);
    var_14 = func_AB7A(var_9, 0, var_13);
    var_15 = func_AB7A(var_10, 0, var_13);
    var_16 = func_AB7A(var_11, 0, var_13);
    var_17 = func_AB7A(var_12, 0, var_13);
    self func_82AC(self.var_8C5A, var_14, 0.05);
    self func_82AC(self.var_8C62, var_15, 0.05);
    self func_82AC(self.var_8C60, var_10, 0.05);
    self func_82AC(self.var_8C63, var_11, 0.05);
    self func_82AC(self.var_8C61, var_12, 0.05);
    self func_82AC(%lookat_left_right, var_13, 0.05);
    self func_82AC(%lookat_up_down, var_14, 0.05);
    self func_82AC(%lookat_head_base_partial, var_15, 0.05);
    self func_82AC(%head_gesture_look_partial, var_16, 0.05);
    self func_82AC(%lookat_head_adds, var_17, 0.05);
    wait(0.05);
  }

  self func_82AC(self.var_8C5A, 0, 0.05);
  self func_82AC(self.var_8C62, 0, 0.05);
  self func_82AC(self.var_8C60, 0, 0.05);
  self func_82AC(self.var_8C63, 0, 0.05);
  self func_82AC(self.var_8C61, 0, 0.05);
  self func_82AC(%lookat_left_right, 0, 0.05);
  self func_82AC(%lookat_up_down, 0, 0.05);
  self func_82AC(%lookat_head_base_partial, 0, 0.05);
  self func_82AC(%head_gesture_look_partial, 0, 0.05);
  self func_82AC(%lookat_head_adds, 0, 0.05);
  self clearanim(%lookat_left_right, 0.05);
  self clearanim(%lookat_up_down, 0.05);
  self.var_9BFC = undefined;
}

func_194F(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("eye_gesture_stop");
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 0.25;
  }

  self clearanim(%eyes_look_leftright, var_1);
  self clearanim(%eyes_look_updown, var_1);
  self clearanim(%eyes_lookat_base_partial, var_1);
  self clearanim(%facial_gesture_look_partial, var_1);
  self clearanim(%eyes_blink_base_partial, var_1);
  self clearanim(%facial_gesture_blink_partial, var_1);
  self clearanim(%eyes_blink, var_1);
  self.var_9BDC = undefined;
}

func_195A(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");
  if(isDefined(self.var_2B6D)) {
    return;
  }

  var_1 = var_0;
  self.var_2B6D = 1;
  self.var_2B80 = undefined;
  var_2 = gettime() / 1000;
  var_3 = self func_8103(%lookat_left_right);
  var_4 = self func_8103(%lookat_up_down);
  var_5 = self func_8103(%lookat_head_base_partial);
  var_6 = self func_8103(%head_gesture_look_partial);
  var_7 = self func_8103(%lookat_head_adds);
  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = gettime() / 1000 - var_2 / var_1;
    var_8 = func_10384(0, 1, var_8);
    var_9 = func_AB7A(var_3, 0, var_8);
    var_10 = func_AB7A(var_4, 0, var_8);
    var_11 = func_AB7A(var_5, 0, var_8);
    var_12 = func_AB7A(var_6, 0, var_8);
    var_13 = func_AB7A(var_7, 0, var_8);
    self func_82AC(%lookat_left_right, var_9, 0.05);
    self func_82AC(%lookat_up_down, var_10, 0.05);
    self func_82AC(%lookat_head_base_partial, var_11, 0.05);
    self func_82AC(%head_gesture_look_partial, var_12, 0.05);
    self func_82AC(%lookat_head_adds, var_13, 0.05);
    wait(0.05);
  }

  self func_82AC(%lookat_left_right, 0, 0.05);
  self func_82AC(%lookat_up_down, 0, 0.05);
  self func_82AC(%lookat_head_base_partial, 0, 0.05);
  self func_82AC(%head_gesture_look_partial, 0, 0.05);
  self func_82AC(%lookat_head_adds, 0, 0.05);
  self.var_2B6D = undefined;
}

func_195B(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");
  if(isDefined(self.var_2B80)) {
    return;
  }

  var_1 = var_0;
  self.var_2B80 = 1;
  self.var_2B6D = undefined;
  var_2 = gettime() / 1000;
  var_3 = self func_8103(%lookat_left_right);
  var_4 = self func_8103(%lookat_up_down);
  var_5 = self func_8103(%lookat_head_base_partial);
  var_6 = self func_8103(%head_gesture_look_partial);
  var_7 = self func_8103(%lookat_head_adds);
  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = gettime() / 1000 - var_2 / var_1;
    var_8 = func_10384(0, 1, var_8);
    var_9 = func_AB7A(var_3, 1, var_8);
    var_10 = func_AB7A(var_4, 1, var_8);
    var_11 = func_AB7A(var_5, 10, var_8);
    var_12 = func_AB7A(var_6, 10, var_8);
    var_13 = func_AB7A(var_7, 0, var_8);
    self func_82AC(%lookat_left_right, var_9, 0.05);
    self func_82AC(%lookat_up_down, var_10, 0.05);
    self func_82AC(%lookat_head_base_partial, var_11, 0.05);
    self func_82AC(%head_gesture_look_partial, var_12, 0.05);
    self func_82AC(%lookat_head_adds, var_13, 0.05);
    wait(0.05);
  }

  self func_82AC(%lookat_left_right, 1, 0.05);
  self func_82AC(%lookat_up_down, 1, 0.05);
  self func_82AC(%lookat_head_base_partial, 10, 0.05);
  self func_82AC(%head_gesture_look_partial, 10, 0.05);
  self func_82AC(%lookat_head_adds, 1, 0.05);
  self.var_2B80 = undefined;
}

func_1967(var_0) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");
  if(!isDefined(self.var_9CE9)) {
    return;
  }

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 0.25;
  }

  var_2 = gettime() / 1000;
  var_3 = self func_8103(self.var_11A0C);
  var_4 = self func_8103(self.var_11A11);
  var_5 = self func_8103(self.var_11A0E);
  var_6 = self func_8103(self.var_11A12);
  var_7 = self func_8103(self.var_11A0F);
  while(gettime() / 1000 - var_2 < var_0) {
    var_8 = gettime() / 1000 - var_2 / var_0;
    var_8 = func_10384(0, 1, var_8);
    var_9 = func_AB7A(var_3, 1, var_8);
    var_10 = func_AB7A(var_4, 0, var_8);
    var_11 = func_AB7A(var_5, 0, var_8);
    var_12 = func_AB7A(var_6, 0, var_8);
    var_13 = func_AB7A(var_7, 0, var_8);
    self func_82AC(self.var_11A0C, var_9, 0.05);
    self func_82AC(self.var_11A11, var_10, 0.05);
    self func_82AC(self.var_11A0E, var_11, 0.05);
    self func_82AC(self.var_11A12, var_12, 0.05);
    self func_82AC(self.var_11A0F, var_13, 0.05);
    wait(0.05);
  }

  self func_82AC(self.var_11A0C, 1, 0.05);
  self func_82AC(self.var_11A11, 0, 0.05);
  self func_82AC(self.var_11A0E, 0, 0.05);
  self func_82AC(self.var_11A12, 0, 0.05);
  self func_82AC(self.var_11A0F, 0, 0.05);
  self clearanim(%torso_tracking_anims, var_0);
  self.var_9CE9 = undefined;
}

func_19BD() {
  self.var_906F = 1;
}

func_19BE() {
  self.var_906F = undefined;
}

func_1921() {
  if(isDefined(self.var_906F)) {
    return 0;
  }

  return 1;
}

func_1955(var_0, var_1, var_2) {
  self endon("entitydeleted");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_9BFC)) {
    func_1964(0.25);
    wait(0.25);
  }

  self endon("death");
  self endon("gesture_stop");
  self notify("start_gesture_lookat");
  if(isai(self)) {
    var_3 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var_3 = undefined;
  }

  if(isDefined(self.var_1ED4)) {
    func_110A5();
  }

  if(!isDefined(self.var_1ED4)) {
    self.var_1ED4 = ::func_F580;
  }

  if(isDefined(var_2)) {
    self.var_2B71 = var_2;
  } else {
    self.var_2B71 = 0.7;
  }

  self.var_AFF7 = undefined;
  self.var_AFFA = undefined;
  self.var_B005 = 0;
  if(isDefined(var_1)) {
    self.var_778E = clamp(var_1, 0.25, 4);
  } else {
    self.var_778E = 0.5;
  }

  if(self.unittype == "c6") {
    func_12FB2();
  } else {
    self.var_AFF7 = % prototype_gesture_look_rightleft;
    self.var_AFFA = % prototype_gesture_look_updwn;
    self.var_8C5A = % gesture_head_fwd;
    self.var_8C62 = % gesture_head_right;
    self.var_8C60 = % gesture_head_left;
    self.var_8C63 = % gesture_head_rightback;
    self.var_8C61 = % gesture_head_leftback;
  }

  self.var_77A3 = var_0;
  if(self.unittype == "c6") {
    thread func_1952();
    thread func_1954();
  } else {
    thread func_1951();
    thread func_1953();
  }

  self.var_9BFC = 1;
}

func_194E(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  if(isDefined(self.var_9BDC)) {
    func_194F(0.25);
    wait(0.25);
  }

  if(isDefined(self.var_1ED4)) {
    func_110A5();
  }

  if(!isDefined(self.var_1ED4)) {
    self.var_1ED4 = ::func_F580;
  }

  if(isDefined(var_2)) {
    self.var_6A55 = var_2;
  } else {
    self.var_6A55 = 0.3;
  }

  self.var_6A5C = undefined;
  self.var_6A5F = undefined;
  self.var_B005 = 0;
  if(isDefined(var_1)) {
    self.var_6A56 = clamp(var_1, 0.25, 4);
  } else {
    self.var_6A56 = 2;
  }

  self.var_6A5C = % facial_gesture_look_rightleft;
  self.var_6A5F = % facial_gesture_look_updwn;
  self.var_6A5D = var_0;
  thread func_194D();
  thread func_1950();
  self.var_9BDC = 1;
}

func_1959(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self notify("start_gesture_torso_lookat");
  if(isai(self)) {
    var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var_2 = undefined;
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(isDefined(self.var_9CE9)) {
    func_1967(0.25);
    wait(0.25);
  }

  if(isDefined(var_1)) {
    self.var_2B71 = var_1;
  } else {
    self.var_2B71 = 0.7;
  }

  self.var_11A10 = undefined;
  self.var_B005 = 0;
  self.var_11A0C = % hm_grnd_grn_casual_stand_center_idle;
  self.var_11A0E = % hm_grnd_grn_casual_stand_left_idle;
  self.var_11A0F = % hm_grnd_grn_casual_stand_leftback_idle;
  self.var_11A11 = % hm_grnd_grn_casual_stand_right_idle;
  self.var_11A12 = % hm_grnd_grn_casual_stand_rightback_idle;
  self.var_77A3 = var_0;
  thread func_1966();
  self.var_9CE9 = 1;
}

func_F580() {
  return % body;
}

func_110A5() {
  self.var_C3D4 = self.var_1ED4;
}

func_E224() {
  self.var_1ED4 = self.var_C3D4;
}

func_196A(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.var_77A3 = var_0;
  self.var_9BFC = 1;
  if(isDefined(var_1)) {
    var_2 = self.var_778E;
    self.var_778E = var_1;
    wait(var_1 * 2);
    self.var_778E = var_2;
  }
}

func_1956(var_0, var_1, var_2, var_3) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  while(!func_1921()) {
    wait(0.05);
  }

  while(distance2d(self.origin, var_0.origin) > var_3) {
    wait(0.05);
  }

  thread func_1955(var_0, var_1, var_2);
  wait(var_2);
  for(;;) {
    wait(randomfloatrange(4, 5));
    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread func_195A(1);
      thread func_194F();
    }

    wait(randomfloatrange(4, 6));
    while(!func_1921()) {
      wait(0.05);
    }

    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread func_195B(0.5);
      thread func_194E(var_0, 1, 0.2);
    }
  }
}

func_1969(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.var_6A5D = var_0;
  self.var_9BDC = 1;
  if(isDefined(var_1)) {
    var_2 = self.var_6A56;
    self.var_6A56 = var_1;
    wait(var_1 * 2);
    self.var_6A56 = var_2;
  }
}

func_1951() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self.var_2B71;
  var_1 = gettime() / 1000;
  var_2 = undefined;
  var_3 = % lookat_left_right;
  var_4 = self.var_8C5A;
  var_5 = self.var_8C62;
  var_6 = self.var_8C60;
  var_7 = self.var_8C63;
  var_8 = self.var_8C61;
  thread func_1163();
  var_2 = vectortoangles(level.player.origin - self.origin);
  self func_82AC(var_4, 1, self.var_2B71);
  self func_82AC(var_5, 0.005, self.var_2B71);
  self func_82AC(var_6, 0.005, self.var_2B71);
  self func_82AC(var_7, 0.005, self.var_2B71);
  self func_82AC(var_8, 0.005, self.var_2B71);
  var_9 = 0;
  var_10 = 0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.var_77A3)) {
      thread func_1964(0.7);
      break;
    }

    if(isPlayer(self.var_77A3)) {
      var_11 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_11 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_11 = self.var_77A3;
    } else {
      var_11 = self.var_77A3.origin;
    }

    var_12 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_13 = self gettagorigin("J_Spine4");
    var_14 = vectornormalize(var_11 - var_13);
    var_15 = anglestoright(var_12);
    var_10 = anglestoup(var_12);
    var_11 = anglestoup(var_12) * -1;
    var_12 = anglestoright(var_12) * -1;
    var_13 = anglesToForward(var_12);
    var_14 = clamp(vectordot(var_14, var_15), 0.005, 1);
    var_15 = clamp(vectordot(var_14, var_10), 0.005, 1);
    var_16 = clamp(vectordot(var_14, var_11), 0.005, 1);
    var_17 = clamp(vectordot(var_14, var_12), 0.005, 1);
    var_18 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_15, var_14, var_13) > 0) {
      var_18 = 0;
    }

    self func_82AC(var_5, var_15, self.var_778E);
    self func_82AC(var_6, var_16, self.var_778E);
    self func_82AC(var_4, var_14 + 0.005, self.var_778E);
    if(var_18) {
      var_9 = scripts\sp\math::func_AB6F(var_9, var_17, 0.1);
      var_10 = scripts\sp\math::func_AB6F(var_10, 0.005, 0.1);
    } else {
      var_9 = scripts\sp\math::func_AB6F(var_9, 0.005, 0.1);
      var_10 = scripts\sp\math::func_AB6F(var_10, var_17, 0.1);
    }

    self func_82AC(var_7, var_9, self.var_778E);
    self func_82AC(var_8, var_10, self.var_778E);
    scripts\engine\utility::waitframe();
  }
}

func_1163() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = gettime() / 1000;
  self.var_2B80 = 1;
  while(gettime() / 1000 - var_0 < self.var_2B71 * 2) {
    var_1 = gettime() / 1000 - var_0 / self.var_2B71 * 2;
    var_2 = func_10384(0, 1, var_1);
    var_3 = func_10384(0, 10, var_1);
    var_4 = func_AB7A(0, 1, var_2);
    var_5 = func_AB7A(0, 10, var_2);
    self func_82AC(%lookat_left_right, var_4, 0.2);
    self func_82AC(%lookat_up_down, var_4, 0.2);
    self func_82AC(%lookat_head_base_partial, var_5, 0.2);
    self func_82AC(%head_gesture_look_partial, var_5, 0.2);
    wait(0.05);
  }

  self func_82AC(%lookat_left_right, 1, 0.2);
  self func_82AC(%lookat_up_down, 1, 0.2);
  self func_82AC(%lookat_head_base_partial, 10, 0.2);
  self func_82AC(%head_gesture_look_partial, 10, 0.2);
  wait(0.05);
  self.var_2B80 = undefined;
}

func_1953() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self func_82AC(%lookat_up_down, 1, self.var_2B71);
  self func_82AC(self.var_AFFA, 1, self.var_2B71);
  self func_82B0(self.var_AFFA, 0.5);
  var_0 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.var_77A3)) {
      var_1 = 0;
      if(level.player func_846D() == "safe") {
        var_1 = 4.62;
      }

      var_2 = level.player getEye() + anglestoup(self.angles) * var_1;
    } else if(isai(self.var_77A3)) {
      var_2 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_2 = self.var_77A3;
    } else {
      var_2 = self.var_77A3.origin;
    }

    var_3 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_4 = self gettagorigin("J_Spine4");
    var_5 = undefined;
    if(isai(self)) {
      var_5 = self getEye();
    } else {
      var_5 = self gettagorigin("J_Head");
    }

    var_6 = vectornormalize(var_2 - var_5);
    var_7 = anglesToForward(var_3);
    var_8 = vectordot(var_7, var_6);
    var_9 = func_6F41(var_8, 1, -1, 0, 1);
    var_0 = var_0 + var_9 - var_0 * self.var_778E * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    func_F5CD(self.var_AFFA, var_0);
    scripts\engine\utility::waitframe();
  }
}

func_1161() {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  self func_82AC(%lookat_head_adds, 1, 0.5);
  for(;;) {
    self func_82AC(%shipcrib_gst_head_idle_01, 0.25, 0.5);
    wait(getanimlength(%shipcrib_gst_head_idle_01) * randomfloatrange(1, 3));
  }
}

func_194D() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self func_82AC(%eyes_lookat_base_partial, 10, self.var_6A55 * 2);
  self func_82AC(%facial_gesture_look_partial, 10, self.var_6A55 * 2);
  self func_82AC(%eyes_look_leftright, 1, self.var_6A55);
  self func_82AC(self.var_6A5C, 1, self.var_6A55);
  self func_82B0(self.var_6A5C, 0.5);
  self func_82B1(self.var_6A5C, 0);
  var_0 = 0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.var_6A5D)) {
      func_194F(0.25);
      break;
    }

    if(isPlayer(self.var_6A5D)) {
      var_1 = level.player getEye();
    } else if(isai(self.var_6A5D)) {
      var_1 = self.var_6A5D getEye();
    } else if(isvector(self.var_6A5D)) {
      var_1 = self.var_6A5D;
    } else {
      var_1 = self.var_6A5D.origin;
    }

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_5 = vectornormalize(var_1 - var_3);
    var_6 = anglestoup(var_2);
    var_7 = scripts\engine\utility::flatten_vector(var_5);
    var_8 = scripts\engine\utility::flatten_vector(var_6);
    var_9 = vectordot(var_8, var_7);
    var_10 = func_6F41(var_9, 1, -1, 0, 1);
    var_11 = clamp(var_10, 0, 1);
    self func_82B0(self.var_6A5C, var_11);
    scripts\engine\utility::waitframe();
  }
}

func_1950() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self func_82AC(%eyes_look_updown, 1, self.var_6A55);
  self func_82AC(self.var_6A5F, 1, self.var_6A55);
  self func_82B0(self.var_6A5F, 0.5);
  var_0 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.var_6A5D)) {
      var_1 = level.player getEye();
    } else if(isai(self.var_6A5D)) {
      var_1 = self.var_6A5D getEye();
    } else if(isvector(self.var_6A5D)) {
      var_1 = self.var_6A5D;
    } else {
      var_1 = self.var_6A5D.origin;
    }

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4");
    var_5 = anglesToForward(var_2);
    var_6 = vectornormalize(var_1 - var_3);
    var_7 = vectordot(var_5, var_6);
    var_8 = func_6F41(var_7, 1, -1, 0.3, 0.7);
    var_9 = clamp(var_8, 0, 1);
    var_0 = var_0 + var_9 - var_0 * self.var_6A56 * 0.3;
    var_0 = clamp(var_0, 0.1, 0.9);
    func_F5CD(self.var_6A5F, var_0);
    scripts\engine\utility::waitframe();
  }
}

func_1966() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var_0 = undefined;
  var_1 = % torso_tracking_anims;
  var_2 = self.var_11A0C;
  var_3 = self.var_11A11;
  var_4 = self.var_11A0E;
  var_5 = self.var_11A12;
  var_6 = self.var_11A0F;
  childthread func_1165();
  var_0 = vectortoangles(level.player.origin - self.origin);
  self func_82AC(var_2, 1, 0.05);
  self func_82AC(var_3, 0, 0.05);
  self func_82AC(var_4, 0, 0.05);
  self func_82AC(var_5, 0, 0.05);
  self func_82AC(var_6, 0, 0.05);
  var_7 = 0;
  var_8 = 0;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.var_77A3)) {
      var_9 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_9 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_9 = self.var_77A3;
    } else {
      var_9 = self.var_77A3.origin;
    }

    var_10 = vectornormalize(var_9 - self.origin);
    var_11 = anglesToForward(self.angles);
    var_12 = anglestoright(self.angles);
    var_13 = anglestoright(self.angles) * -1;
    var_14 = anglesToForward(self.angles) * -1;
    var_15 = anglestoup(self.angles);
    var_10 = clamp(vectordot(var_10, var_11), 0, 1);
    var_11 = clamp(vectordot(var_10, var_12), 0, 1);
    var_12 = clamp(vectordot(var_10, var_13), 0, 1);
    var_13 = clamp(vectordot(var_10, var_14), 0, 1);
    var_14 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_11, var_10, var_15) > 0) {
      var_14 = 0;
    }

    self func_82AC(var_3, var_11, 0.2);
    self func_82AC(var_4, var_12, 0.2);
    self func_82AC(var_2, var_10 + 0.005, 0.2);
    if(var_14) {
      var_7 = scripts\sp\math::func_AB6F(var_7, var_13, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::func_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, var_13, 0.1);
    }

    self func_82AC(var_5, var_7, 0.2);
    self func_82AC(var_6, var_8, 0.2);
    scripts\engine\utility::waitframe();
  }
}

func_1165() {
  var_0 = gettime() / 1000;
  while(gettime() / 1000 - var_0 < self.var_2B71) {
    var_1 = gettime() / 1000 - var_0 / self.var_2B71;
    var_1 = func_10384(0, 1, var_1);
    var_2 = func_AB7A(0, 1, var_1);
    self func_82AC(%torso_tracking_anims, var_2, 0.05);
    wait(0.05);
    waittillframeend;
  }

  self func_82AC(%torso_tracking_anims, 1, 0.05);
}

func_1948(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  func_1963();
  for(;;) {
    wait(randomfloatrange(var_0 * 0.5, var_0));
    self clearanim(%facial_gesture_blink_1, 0);
    wait(0.05);
    self func_82AC(%facial_gesture_blink_1, 1, 0);
    scripts\engine\utility::waitframe();
  }
}

func_1963() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  if(!isDefined(self)) {
    return;
  }

  self func_82AC(%eyes_blink, 1, 0);
  self clearanim(%facial_gesture_blink_1, 0);
  wait(0.05);
  self func_82AC(%facial_gesture_blink_1, 1, 0);
}

func_195D(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self.var_D633 = undefined;
  self.var_D639 = undefined;
  self.var_D63B = undefined;
  self.var_D63D = undefined;
  self.var_D635 = undefined;
  self.var_C00A = 0;
  self._blackboard.var_D636 = 1;
  var_1 = scripts\asm\asm::asm_getdemeanor();
  var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  lib_0A1E::func_2381(self.asmname, var_2);
  if(var_1 != "casual" && var_1 != "casual_gun") {
    self.var_77AD = % gesture_partials;
  } else {
    self.var_77AD = % point_at_without_head;
  }

  if(!scripts\asm\asm::func_231B(self.asmname, "gesture")) {
    return;
  } else if(var_1 == "casual" || var_1 == "combat" || var_1 == "casual_gun" || var_1 == "frantic") {
    self.var_D633 = self.asm.var_77C1.var_77AA;
    self.var_D639 = self.asm.var_77C1.var_77AC;
    self.var_D63B = self.asm.var_77C1.var_77AE;
    self.var_D63D = self.asm.var_77C1.var_77AF;
    self.var_D635 = self.asm.var_77C1.var_77AB;
    self.var_778D = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
  } else {
    return;
  }

  if(isPlayer(var_0)) {
    var_3 = level.player getEye();
  } else if(!isDefined(var_1)) {
    var_3 = self.origin;
    self.var_C00A = 1;
  } else if(isai(var_1)) {
    var_3 = var_1 getEye();
  } else if(isvector(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = var_1.origin;
  }

  var_4 = self gettagangles("J_Spine4") + (0, 90, 0);
  var_5 = self gettagorigin("J_Spine4");
  var_6 = anglestoright(var_4);
  var_7 = anglestoup(var_4);
  var_8 = vectornormalize(var_3 - var_5);
  var_9 = scripts\engine\utility::flatten_vector(var_6);
  var_10 = scripts\engine\utility::flatten_vector(var_7);
  var_11 = scripts\engine\utility::flatten_vector(var_8);
  var_12 = vectordot(var_9, var_11) * -1;
  var_13 = var_12 * -1;
  var_14 = clamp(func_6F41(var_12, 0.2, 1, 0, 1), 0, 1);
  var_15 = clamp(func_6F41(var_13, 0.2, 1, 0, 1), 0, 1);
  var_10 = self gettagorigin("J_Spine4");
  var_11 = vectornormalize(var_3 - var_10);
  var_12 = anglesToForward(var_4);
  var_13 = vectordot(var_11, var_12);
  var_14 = var_13 * -1;
  var_15 = vectordot(var_7, var_11);
  var_16 = clamp(func_6F41(var_15, 0.2, 1, 0, 1), 0, 1);
  var_17 = clamp(func_6F41(var_13, 0.2, 1, 0, 1), 0, 1);
  var_18 = clamp(func_6F41(var_14, 0.2, 1, 0, 1), 0, 1);
  if(!self.var_C00A) {
    if(var_15 < -0.9) {
      func_1960("fallback_up");
    } else {
      if(var_1 != "casual" && var_1 != "casual_gun") {
        self func_82AC(self.var_77AD, 10, 0.25);
      } else {
        self func_82AC(self.var_77AD, 1, 0.25);
      }

      if(var_16 < 0.3) {
        self func_82AC(self.var_D633, 0, 0, 0.85);
      } else {
        self func_82AC(self.var_D633, var_16, 0.25, 0.85);
      }

      if(isDefined(self.var_D63D)) {
        self func_82AC(self.var_D63D, var_17, 0.25, 0.85);
      }

      if(isDefined(self.var_D635)) {
        self func_82AC(self.var_D635, var_18, 0.2, 0.85);
      }

      self func_82AC(self.var_D639, var_15, 0.25, 0.85);
      self func_82AC(self.var_D63B, var_14, 0.25, 0.85);
    }
  } else {
    if(var_1 != "casual" && var_1 != "casual_gun") {
      self func_82AC(self.var_77AD, 10, 0.2);
    } else {
      self func_82AC(self.var_77AD, 1, 0.2);
    }

    self func_82AC(self.var_D633, 1, 0.2, 0.85);
  }

  var_19 = getanimlength(%prototype_gesture_point_center) * 0.85;
  wait(var_19);
  self clearanim(self.var_77AD, 0.25);
  self func_82AC(self.var_778D, 1, 0.25);
  self._blackboard.var_D636 = 0;
}

func_1960(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.var_D633 = undefined;
  self.var_778D = undefined;
  self.var_9C5F = 0;
  var_1 = "casual";
  var_2 = undefined;
  if(isai(self)) {
    self._blackboard.var_778B = 1;
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

  if(isai(self) && !scripts\asm\asm::func_231B(self.asmname, "gesture")) {
    return;
  } else if(isai(self)) {
    self.var_778D = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
    if(var_1 == "casual") {
      if(scripts\engine\utility::array_contains(var_3, var_0)) {
        self.var_77B6 = self.asm.var_77C1.var_77B6;
        self.var_778F = self.asm.var_77C1.var_778F;
        self.var_77A7 = self.asm.var_77C1.var_77A7;
        self.var_77B4 = self.asm.var_77C1.var_77B4;
        self.var_77BF = self.asm.var_77C1.var_77BF;
        self.var_77BE = self.asm.var_77C1.var_77BE;
        self.var_7795 = self.asm.var_77C1.var_7795;
      } else {
        return;
      }
    } else if(var_1 == "casual_gun") {
      if(scripts\engine\utility::array_contains(var_6, var_0)) {
        self.var_77B6 = self.asm.var_77C1.var_77B6;
        self.var_778F = self.asm.var_77C1.var_778F;
        self.var_77A7 = self.asm.var_77C1.var_77A7;
        self.var_77B4 = self.asm.var_77C1.var_77B4;
        self.var_77BF = self.asm.var_77C1.var_77BF;
        self.var_77BE = self.asm.var_77C1.var_77BE;
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else if(var_1 == "combat") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else if(var_1 == "cqb") {
      if(scripts\engine\utility::array_contains(var_5, var_0)) {
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else if(var_1 == "frantic") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else {
      return;
    }
  } else {
    self.var_77B6 = % shipcrib_gst_body_shrug_01;
    self.var_778F = % shipcrib_gst_body_cross_01;
    self.var_77A7 = % shipcrib_gst_head_nod_01;
    self.var_77B4 = % shipcrib_gst_head_salute_01;
    self.var_77BF = % shipcrib_gst_body_wave_01;
    self.var_77BE = % shipcrib_gst_body_wait_01;
    self.var_7795 = % hm_grnd_org_gest_fallback_up;
  }

  var_7 = undefined;
  switch (var_0) {
    case "shrug":
      var_7 = self.var_77B6;
      break;

    case "cross":
      var_7 = self.var_778F;
      break;

    case "nod":
      var_7 = self.var_77A7;
      break;

    case "salute":
      var_7 = self.var_77B4;
      break;

    case "wave":
      var_7 = self.var_77BF;
      break;

    case "wait":
      var_7 = self.var_77BE;
      break;

    case "hold":
      self.var_9C5F = 1;
      var_7 = self.var_77A0;
      break;

    case "on_me":
      self.var_9C5F = 1;
      var_7 = self.var_77A8;
      break;

    case "move_up":
      self.var_9C5F = 1;
      var_7 = self.var_77A6;
      break;

    case "fallback_up":
      self.var_9C5F = 1;
      var_7 = self.var_7795;
      break;

    case "fallback_down":
      self.var_9C5F = 1;
      var_7 = self.var_7794;
      break;

    case "arm_up":
      self.var_9C5F = 1;
      var_7 = self.var_778C;
      break;
  }

  if(self.var_9C5F) {
    self.var_101F8 = % gesture_partials;
  } else {
    self.var_101F8 = % add_gesture;
  }

  if(self.var_9C5F) {
    thread func_2B79(self.var_101F8, var_7, 0.5);
  } else {
    self func_82AC(self.var_101F8, 1, 0.5);
    self func_82AC(var_7, 1, 0.5, 0.75);
  }

  var_8 = getanimlength(var_7) * 0.85;
  wait(var_8);
  if(self.var_9C5F) {
    thread func_2B7A(self.var_101F8, var_7, 0.5);
  } else {
    self clearanim(self.var_101F8, 0.5);
    self clearanim(var_7, 0.5);
  }

  self.var_9C5F = 0;
  if(isai(self)) {
    self._blackboard.var_778B = undefined;
  }
}

func_2B79(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * 0.5;
  self func_82AC(var_0, 1, var_4);
  self func_82AC(var_1, 1, var_4, 0.75);
  wait(var_2 * 0.5);
  self func_82AC(var_1, 10, var_4, 0.75);
  self func_82AC(var_0, 10, var_4);
}

func_2B7A(var_0, var_1, var_2) {
  var_3 = var_2 * 0.5;
  self func_82AC(var_0, 1, var_3);
  self func_82AC(var_1, 1, var_3);
  wait(var_3);
  self clearanim(var_0, var_3);
  self clearanim(var_1, var_3);
}

func_6F41(var_0, var_1, var_2, var_3, var_4) {
  return var_0 - var_1 / var_2 - var_1 * var_4 - var_3 + var_3;
}

func_AB7A(var_0, var_1, var_2) {
  return var_0 + var_2 * var_1 - var_0;
}

func_10384(var_0, var_1, var_2) {
  var_2 = clamp(var_2 - var_0 / var_1 - var_0, 0, 1);
  return var_2 * var_2 * 3 - 2 * var_2;
}

func_F5CD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.25;
  }

  var_4 = self getscoreinfocategory(var_0);
  var_5 = getanimlength(var_0);
  var_6 = var_1 - var_4 * var_5 / 0.05;
  if(self.unittype == "c6") {
    func_12FB2();
  }

  self func_82AC(var_0, var_2, var_3, var_6);
}

func_194C(var_0, var_1, var_2) {
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
  self.var_C00A = 0;
  var_11 = undefined;
  if(isDefined(var_2)) {
    var_10 = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
    var_11 = % gesture_partials;
  } else {
    var_11 = % add_gesture;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isPlayer(var_0)) {
    var_12 = level.player getEye();
  } else if(!isDefined(var_1)) {
    var_12 = self.origin;
    var_9 = 1;
  } else if(isai(var_1)) {
    var_12 = var_1 getEye();
  } else if(isvector(var_1)) {
    var_12 = var_1;
  } else {
    var_12 = var_1.origin;
  }

  var_13 = self gettagangles("tag_origin");
  var_14 = self gettagorigin("tag_origin");
  var_15 = anglestoright(var_13);
  var_10 = anglesToForward(var_13);
  var_11 = vectornormalize(var_12 - var_14);
  var_12 = scripts\engine\utility::flatten_vector(var_15);
  var_13 = scripts\engine\utility::flatten_vector(var_10);
  var_14 = scripts\engine\utility::flatten_vector(var_11);
  var_15 = vectordot(var_12, var_14);
  var_16 = var_15 * -1;
  var_17 = clamp(func_6F41(var_15, 0.2, 1, 0, 1), 0, 1);
  var_18 = clamp(func_6F41(var_16, 0.2, 1, 0, 1), 0, 1);
  var_19 = self gettagorigin("J_Spine4");
  var_1A = vectornormalize(var_12 - var_19);
  var_1B = anglestoup(var_13);
  var_1C = vectordot(var_1A, var_1B);
  var_1D = var_1C * -1;
  var_1E = vectordot(var_13, var_1A);
  var_1F = clamp(func_6F41(var_1E, 0.2, 1, 0, 1), 0, 1);
  var_20 = clamp(func_6F41(var_1C, 0.2, 1, 0, 1), 0, 1);
  var_21 = clamp(func_6F41(var_1D, 0.2, 1, 0, 1), 0, 1);
  if(!self.var_C00A) {
    if(isDefined(var_2)) {
      self func_82AC(var_11, 10, 0.25);
    } else {
      self func_82AC(var_11, 1, 0.25);
    }

    if(var_1F < 0.3) {
      self func_82AC(var_4, 0, 0, 1);
    } else {
      self func_82AC(var_4, var_1F, 0.25, 1);
    }

    if(isDefined(var_7)) {
      self func_82AC(var_7, var_20, 0.25, 1);
    }

    if(isDefined(var_8)) {
      self func_82AC(var_8, var_21, 0.25, 1);
    }

    self func_82AC(var_5, var_18, 0.25, 1);
    self func_82AC(var_6, var_17, 0.25, 1);
  } else {
    if(isDefined(var_2)) {
      self func_82AC(var_10, 0.001, 0.1);
    }

    self func_82AC(var_11, 1, 0.25);
    self func_82AC(var_4, 1, 0.25);
  }

  var_22 = getanimlength(var_4);
  wait(var_22);
  self clearanim(var_11, 0.25);
  self func_82AC(var_10, 1, 0.25);
}

func_192F(var_0, var_1) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  var_2 = % add_gesture;
  var_3 = 0;
  var_4 = "single anim";
  thread scripts\sp\anim::func_10CBF(self, var_4, undefined, undefined, var_0);
  if(isDefined(var_1) && var_1) {
    var_2 = % gesture_partials;
    var_3 = 1;
  }

  if(var_3) {
    thread func_2B79(var_2, var_0, 0.2);
  } else {
    self func_82AC(var_2, 1, 0.1);
    self func_82AC(var_0, 1, 0.1);
  }

  var_5 = getanimlength(var_0) * 0.75 - 0.2;
  wait(var_5);
  if(var_3) {
    thread func_2B7A(var_2, var_0, 0.2);
    return;
  }

  self clearanim(var_2, 0.2);
  self clearanim(var_0, 0.2);
}

func_12FB2() {
  self.var_AFF7 = % prototype_gesture_look_rightleft;
  self.var_AFFA = % prototype_gesture_look_updwn;
}

func_1952() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self.var_2B71;
  var_1 = gettime() / 1000;
  while(gettime() / 1000 - var_1 < var_0) {
    var_2 = gettime() / 1000 - var_1 / var_0;
    var_2 = func_10384(0, 1, var_2);
    var_3 = func_AB7A(0, 1, var_2);
    var_4 = func_AB7A(0, 1, var_2);
    var_5 = func_AB7A(0, 5, var_2);
    var_6 = func_AB7A(0, 5, var_2);
    self func_82AC(%lookat_left_right, var_3, 0.05);
    self func_82AC(self.var_AFF7, var_4, 0.05);
    self func_82AC(%lookat_head_base_partial, var_5, 0.05);
    self func_82AC(%head_gesture_look_partial, var_6, 0.05);
    self func_82B0(self.var_AFF7, 0.5);
    wait(0.05);
    waittillframeend;
  }

  self func_82AC(%lookat_left_right, 1, 0.05);
  self func_82AC(self.var_AFF7, 1, 0.05);
  self func_82AC(%lookat_head_base_partial, 5, 0.05);
  self func_82AC(%head_gesture_look_partial, 5, 0.05);
  var_7 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.var_77A3)) {
      var_8 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_8 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_8 = self.var_77A3;
    } else {
      var_8 = self.var_77A3.origin;
    }

    var_9 = self gettagangles("J_Head");
    var_10 = self gettagorigin("J_Head");
    var_11 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_12 = self gettagorigin("J_Spine4");
    var_13 = vectornormalize(var_8 - var_12);
    var_14 = anglestoright(var_11);
    var_15 = scripts\engine\utility::flatten_vector(var_14);
    var_10 = scripts\engine\utility::flatten_vector(var_13);
    var_11 = vectordot(var_15, var_10);
    var_12 = func_6F41(var_11, -1, 1, 0, 1);
    var_12 = clamp(var_12, 0, 1);
    var_7 = var_7 + var_12 - var_7 * self.var_778E;
    var_7 = clamp(var_7, 0.1, 0.9);
    func_F5CD(self.var_AFF7, var_7, 1);
    scripts\engine\utility::waitframe();
  }
}

func_1954() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self func_82AC(%lookat_up_down, 1, self.var_2B71);
  self func_82AC(self.var_AFFA, 1, self.var_2B71);
  self func_82B0(self.var_AFFA, 0.5);
  var_0 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.var_77A3)) {
      var_1 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_1 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_1 = self.var_77A3;
    } else {
      var_1 = self.var_77A3.origin;
    }

    var_2 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_3 = self gettagorigin("J_Spine4");
    var_4 = undefined;
    if(isai(self)) {
      var_4 = self getEye();
    } else {
      var_4 = self gettagorigin("J_Head");
    }

    var_5 = vectornormalize(var_1 - var_4);
    var_6 = anglesToForward(var_2);
    var_7 = vectordot(var_6, var_5);
    var_8 = func_6F41(var_7, 1, -1, 0, 1);
    var_0 = var_0 + var_8 - var_0 * self.var_778E * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    func_F5CD(self.var_AFFA, var_0);
    scripts\engine\utility::waitframe();
  }
}

func_1965(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("gesture_stop");
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 0.25;
  }

  self func_82AC(%lookat_left_right, 1, var_1 * 0.15);
  self func_82AC(%lookat_up_down, 1, var_1 * 0.15);
  self func_82AC(%lookat_head_base_partial, 1, var_1 * 0.15);
  self func_82AC(%head_gesture_look_partial, 1, var_1 * 0.15);
  wait(var_1 * 0.15);
  self clearanim(%lookat_left_right, var_1 * 0.85);
  self clearanim(%lookat_up_down, var_1 * 0.85);
  self clearanim(%lookat_head_base_partial, var_1 * 0.85);
  self clearanim(%head_gesture_look_partial, var_1 * 0.85);
  self.var_9BFC = undefined;
}

func_2B8A() {
  var_0 = self;
  self endon(self.var_6317);
  var_0.var_7540 = undefined;
  var_0.var_E512 = undefined;
  var_0.var_AB35 = undefined;
  var_0.var_AB54 = undefined;
  var_0.var_E52E = undefined;
  foreach(var_2 in var_0.var_1E9D) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_7540 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_E512 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_AB35 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_AB54 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_E52E = level.var_EC85[var_0.var_1FBB][var_2];
      }
    }
  }

  var_4 = getstartorigin(self.var_1FBD.origin, self.var_1FBD.angles, var_0.var_7540);
  var_5 = getstartangles(self.var_1FBD.origin, self.var_1FBD.angles, var_0.var_7540);
  if(isai(var_0)) {
    var_0 func_80F1(var_4, var_5, 10000);
  } else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 func_82A5(var_0.var_7540, %root, 1, 0.2);
  if(isDefined(var_0.var_E512)) {
    var_0 func_82AC(var_0.var_E512, 0, 0.2);
  }

  if(isDefined(var_0.var_AB35)) {
    var_0 func_82AC(var_0.var_AB35, 0, 0.2);
  }

  if(isDefined(var_0.var_AB54)) {
    var_0 func_82AC(var_0.var_AB54, 0, 0.2);
  }

  if(isDefined(var_0.var_E52E)) {
    var_0 func_82AC(var_0.var_E52E, 0, 0.2);
  }

  var_7 = 0;
  var_8 = 0;
  var_0 func_8250(1);
  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0.var_77A3)) {
      var_9 = level.player getEye();
    } else if(isai(var_0.var_77A3)) {
      var_9 = var_0.var_77A3 getEye();
    } else if(isvector(var_0.var_77A3)) {
      var_9 = var_0.var_77A3;
    } else {
      var_9 = var_0.var_77A3.origin;
    }

    var_10 = var_0 gettagangles("tag_origin");
    var_11 = var_0 gettagorigin("tag_origin");
    var_12 = scripts\engine\utility::flatten_vector(vectornormalize(var_9 - var_11));
    var_13 = anglesToForward(var_10);
    var_14 = anglestoright(var_10);
    var_15 = anglestoright(var_10) * -1;
    var_10 = anglesToForward(var_10) * -1;
    var_11 = anglestoup(var_10);
    var_12 = clamp(vectordot(var_12, var_13), 0, 1);
    var_13 = clamp(vectordot(var_12, var_14), 0, 1);
    var_14 = clamp(vectordot(var_12, var_15), 0, 1);
    var_15 = clamp(vectordot(var_12, var_10), 0, 1);
    var_16 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_13, var_12, var_11) > 0) {
      var_16 = 0;
    }

    if(isDefined(var_0.var_E512)) {
      var_0 func_82AC(var_0.var_E512, var_13, 0.2);
    }

    if(isDefined(var_0.var_AB35)) {
      var_0 func_82AC(var_0.var_AB35, var_14, 0.2);
    }

    var_0 func_82AC(var_0.var_7540, var_12 + 0.005, 0.2);
    if(var_16) {
      var_7 = scripts\sp\math::func_AB6F(var_7, var_15, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::func_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, var_15, 0.1);
    }

    if(isDefined(var_0.var_E52E)) {
      var_0 func_82AC(var_0.var_E52E, var_7 + 0.005, 0.2);
    }

    if(isDefined(var_0.var_AB54)) {
      var_0 func_82AC(var_0.var_AB54, var_8 + 0.005, 0.2);
    }

    scripts\engine\utility::waitframe();
    waittillframeend;
  }
}

func_2B8B() {
  var_0 = self;
  if(isDefined(var_0.var_6317)) {
    var_0 notify(var_0.var_6317);
  }

  var_0 clearanim(var_0.var_7540, 0.2);
  if(isDefined(var_0.var_E512)) {
    var_0 clearanim(var_0.var_E512, 0.2);
  }

  if(isDefined(var_0.var_AB35)) {
    var_0 clearanim(var_0.var_AB35, 0.2);
  }

  if(isDefined(var_0.var_AB54)) {
    var_0 clearanim(var_0.var_AB54, 0.2);
  }

  if(isDefined(var_0.var_E52E)) {
    var_0 clearanim(var_0.var_E52E, 0.2);
  }

  var_0 func_8250(0);
  var_0.var_7540 = undefined;
  var_0.var_E512 = undefined;
  var_0.var_AB35 = undefined;
  var_0.var_AB54 = undefined;
  var_0.var_E52E = undefined;
  var_0.var_1E9D = undefined;
  var_0.var_6317 = undefined;
  var_0.var_77A3 = undefined;
}

func_2B86() {
  var_0 = self;
  var_0.var_7540 = undefined;
  var_0.var_E512 = undefined;
  var_0.var_AB35 = undefined;
  var_0.var_AB54 = undefined;
  var_0.var_E52E = undefined;
  foreach(var_2 in var_0.var_1E9D) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_7540 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_E512 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_AB35 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_AB54 = level.var_EC85[var_0.var_1FBB][var_2];
      }

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level.var_EC85[var_0.var_1FBB][var_2])) {
        var_0.var_E52E = level.var_EC85[var_0.var_1FBB][var_2];
      }
    }
  }

  var_4 = getstartorigin(self.var_1FBD.origin, self.var_1FBD.angles, var_0.var_7540);
  var_5 = getstartangles(self.var_1FBD.origin, self.var_1FBD.angles, var_0.var_7540);
  if(isai(var_0)) {
    var_0 func_80F1(var_4, var_5, 10000);
  } else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 func_82A5(var_0.var_7540, %root, 1, 0.2);
  if(isDefined(var_0.var_E512)) {
    var_0 func_82AC(var_0.var_E512, 0, 0.2);
  }

  if(isDefined(var_0.var_AB35)) {
    var_0 func_82AC(var_0.var_AB35, 0, 0.2);
  }

  if(isDefined(var_0.var_AB54)) {
    var_0 func_82AC(var_0.var_AB54, 0, 0.2);
  }

  if(isDefined(var_0.var_E52E)) {
    var_0 func_82AC(var_0.var_E52E, 0, 0.2);
  }

  var_7 = 0;
  var_8 = 0;
  var_9 = gettime() / 1000;
  var_10 = getanimlength(var_0.var_7540);
  while(gettime() / 1000 - var_9 < var_10) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0.var_77A3)) {
      var_11 = level.player getEye();
    } else if(isai(var_0.var_77A3)) {
      var_11 = var_0.var_77A3 getEye();
    } else if(isvector(var_0.var_77A3)) {
      var_11 = var_0.var_77A3;
    } else {
      var_11 = var_0.var_77A3.origin;
    }

    var_12 = var_0 gettagangles("tag_origin");
    var_13 = var_0 gettagorigin("tag_origin");
    var_14 = scripts\engine\utility::flatten_vector(vectornormalize(var_11 - var_13));
    var_15 = anglesToForward(var_12);
    var_10 = anglestoright(var_12);
    var_11 = anglestoright(var_12) * -1;
    var_12 = anglesToForward(var_12) * -1;
    var_13 = anglestoup(var_12);
    var_14 = clamp(vectordot(var_14, var_15), 0, 1);
    var_15 = clamp(vectordot(var_14, var_10), 0, 1);
    var_16 = clamp(vectordot(var_14, var_11), 0, 1);
    var_17 = clamp(vectordot(var_14, var_12), 0, 1);
    var_18 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_15, var_14, var_13) > 0) {
      var_18 = 0;
    }

    if(isDefined(var_0.var_E512)) {
      var_0 func_82AC(var_0.var_E512, var_15, 0.2);
    }

    if(isDefined(var_0.var_AB35)) {
      var_0 func_82AC(var_0.var_AB35, var_16, 0.2);
    }

    var_0 func_82AC(var_0.var_7540, var_14 + 0.005, 0.2);
    if(var_18) {
      var_7 = scripts\sp\math::func_AB6F(var_7, var_17, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, 0, 0.1);
    } else {
      var_7 = scripts\sp\math::func_AB6F(var_7, 0, 0.1);
      var_8 = scripts\sp\math::func_AB6F(var_8, var_17, 0.1);
    }

    if(isDefined(var_0.var_E52E)) {
      var_0 func_82AC(var_0.var_E52E, var_7 + 0.005, 0.2);
    }

    if(isDefined(var_0.var_AB54)) {
      var_0 func_82AC(var_0.var_AB54, var_8 + 0.005, 0.2);
    }

    scripts\engine\utility::waitframe();
    waittillframeend;
  }

  var_0 thread func_2B8B();
}