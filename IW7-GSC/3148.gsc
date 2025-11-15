/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3148.gsc
************************/

func_3DF2(param_00, param_01, param_02, param_03) {
  if(isDefined(self.isnodeoccupied)) {
    var_04 = distancesquared(self.origin, self.isnodeoccupied.origin);
    if(var_04 < 65536) {
      return 0;
    }

    if(isai(self.isnodeoccupied)) {
      if(!isDefined(self.isnodeoccupied scripts\asm\asm_bb::bb_getcovernode()) || self.isnodeoccupied scripts\asm\asm_bb::bb_getrequestedcoverstate() != "hide") {
        return 0;
      }
    } else if(var_04 < 262144) {
      return 0;
    }
  }

  if(isDefined(self.var_1198.var_28D0)) {
    if(self.var_1198.var_28D0 == param_03) {
      return 1;
    }

    return 0;
  }

  return 0;
}

func_3EBB(param_00, param_01, param_02) {
  var_03 = undefined;
  if(isDefined(self.var_1198.var_28DE)) {
    var_03 = self.var_1198.var_28DE.origin;
  } else {
    var_03 = level.player.origin + anglesToForward(level.player.angles) * 6000;
  }

  if(isDefined(param_02)) {
    var_04 = param_02;
  } else {
    var_05 = scripts\asm\asm_bb::bb_getcovernode();
    if(isDefined(var_05)) {
      var_06 = var_05.angles;
    } else {
      var_06 = self.angles;
    }

    var_04 = func_7818(var_06, self.origin, var_03);
  }

  var_07 = lib_0A1E::func_2356(param_01, var_04);
  if(!isDefined(var_07)) {
    var_07 = lib_0A1E::func_2356(param_01, "8");
  }

  return var_07;
}

func_CEE9(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self.var_1198.var_28D1 = 1;
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  self clearanim(var_04, param_02);
  self.var_1198.var_28D0 = undefined;
  self.var_1198.var_28D1 = undefined;
}

func_980D(param_00, param_01, param_02, param_03) {}

func_D48B(param_00, param_01, param_02, param_03) {}

func_3EDA(param_00, param_01, param_02, param_03) {}

func_195F() {
  if(isDefined(self.var_1198.var_778B) && self.var_1198.var_778B) {
    return 1;
  }

  return 0;
}

func_19D2() {
  if(isDefined(self.var_1198.var_D636) && self.var_1198.var_D636) {
    return 1;
  }

  return 0;
}

func_12F2(param_00, param_01) {
  var_02 = anglesToForward(level.player.angles);
  var_03 = vectornormalize(param_00.origin - level.player.origin);
  var_04 = vectordot(var_02, var_03);
  if(var_04 >= param_01) {
    return 1;
  }

  return 0;
}

func_7818(param_00, param_01, param_02) {
  var_03 = vectortoangles(param_02 - param_01);
  var_04 = angleclamp180(var_03[1] - param_00[1]);
  var_05 = getangleindex(var_04, 10);
  var_06 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var_06[var_05];
}

func_1964(param_00) {
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

  if(isDefined(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = 0.25;
  }

  if(!isDefined(self.var_9BFC)) {
    return;
  }

  var_02 = gettime() / 1000;
  var_03 = self _meth_8103(self.var_8C5A);
  var_04 = self _meth_8103(self.var_8C62);
  var_05 = self _meth_8103(self.var_8C60);
  var_06 = self _meth_8103(self.var_8C63);
  var_07 = self _meth_8103(self.var_8C61);
  var_08 = self _meth_8103( % lookat_left_right);
  var_09 = self _meth_8103( % lookat_up_down);
  var_0A = self _meth_8103( % lookat_head_base_partial);
  var_0B = self _meth_8103( % head_gesture_look_partial);
  var_0C = self _meth_8103( % lookat_head_adds);
  while(gettime() / 1000 - var_02 < param_00) {
    var_0D = gettime() / 1000 - var_02 / param_00;
    var_0D = func_10384(0, 1, var_0D);
    var_0E = func_AB7A(var_03, 1, var_0D);
    var_0F = func_AB7A(var_04, 0, var_0D);
    var_10 = func_AB7A(var_05, 0, var_0D);
    var_11 = func_AB7A(var_06, 0, var_0D);
    var_12 = func_AB7A(var_07, 0, var_0D);
    var_13 = func_AB7A(var_08, 0, var_0D);
    var_14 = func_AB7A(var_09, 0, var_0D);
    var_15 = func_AB7A(var_0A, 0, var_0D);
    var_16 = func_AB7A(var_0B, 0, var_0D);
    var_17 = func_AB7A(var_0C, 0, var_0D);
    self _meth_82AC(self.var_8C5A, var_0E, 0.05);
    self _meth_82AC(self.var_8C62, var_0F, 0.05);
    self _meth_82AC(self.var_8C60, var_10, 0.05);
    self _meth_82AC(self.var_8C63, var_11, 0.05);
    self _meth_82AC(self.var_8C61, var_12, 0.05);
    self _meth_82AC( % lookat_left_right, var_13, 0.05);
    self _meth_82AC( % lookat_up_down, var_14, 0.05);
    self _meth_82AC( % lookat_head_base_partial, var_15, 0.05);
    self _meth_82AC( % head_gesture_look_partial, var_16, 0.05);
    self _meth_82AC( % lookat_head_adds, var_17, 0.05);
    wait(0.05);
  }

  self _meth_82AC(self.var_8C5A, 0, 0.05);
  self _meth_82AC(self.var_8C62, 0, 0.05);
  self _meth_82AC(self.var_8C60, 0, 0.05);
  self _meth_82AC(self.var_8C63, 0, 0.05);
  self _meth_82AC(self.var_8C61, 0, 0.05);
  self _meth_82AC( % lookat_left_right, 0, 0.05);
  self _meth_82AC( % lookat_up_down, 0, 0.05);
  self _meth_82AC( % lookat_head_base_partial, 0, 0.05);
  self _meth_82AC( % head_gesture_look_partial, 0, 0.05);
  self _meth_82AC( % lookat_head_adds, 0, 0.05);
  self clearanim( % lookat_left_right, 0.05);
  self clearanim( % lookat_up_down, 0.05);
  self.var_9BFC = undefined;
}

func_194F(param_00) {
  self endon("death");
  self endon("entitydeleted");
  self notify("eye_gesture_stop");
  if(isDefined(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = 0.25;
  }

  self clearanim( % eyes_look_leftright, var_01);
  self clearanim( % eyes_look_updown, var_01);
  self clearanim( % eyes_lookat_base_partial, var_01);
  self clearanim( % facial_gesture_look_partial, var_01);
  self clearanim( % eyes_blink_base_partial, var_01);
  self clearanim( % facial_gesture_blink_partial, var_01);
  self clearanim( % eyes_blink, var_01);
  self.var_9BDC = undefined;
}

func_195A(param_00) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");
  if(isDefined(self.var_2B6D)) {
    return;
  }

  var_01 = param_00;
  self.var_2B6D = 1;
  self.var_2B80 = undefined;
  var_02 = gettime() / 1000;
  var_03 = self _meth_8103( % lookat_left_right);
  var_04 = self _meth_8103( % lookat_up_down);
  var_05 = self _meth_8103( % lookat_head_base_partial);
  var_06 = self _meth_8103( % head_gesture_look_partial);
  var_07 = self _meth_8103( % lookat_head_adds);
  while(gettime() / 1000 - var_02 < var_01) {
    var_08 = gettime() / 1000 - var_02 / var_01;
    var_08 = func_10384(0, 1, var_08);
    var_09 = func_AB7A(var_03, 0, var_08);
    var_0A = func_AB7A(var_04, 0, var_08);
    var_0B = func_AB7A(var_05, 0, var_08);
    var_0C = func_AB7A(var_06, 0, var_08);
    var_0D = func_AB7A(var_07, 0, var_08);
    self _meth_82AC( % lookat_left_right, var_09, 0.05);
    self _meth_82AC( % lookat_up_down, var_0A, 0.05);
    self _meth_82AC( % lookat_head_base_partial, var_0B, 0.05);
    self _meth_82AC( % head_gesture_look_partial, var_0C, 0.05);
    self _meth_82AC( % lookat_head_adds, var_0D, 0.05);
    wait(0.05);
  }

  self _meth_82AC( % lookat_left_right, 0, 0.05);
  self _meth_82AC( % lookat_up_down, 0, 0.05);
  self _meth_82AC( % lookat_head_base_partial, 0, 0.05);
  self _meth_82AC( % head_gesture_look_partial, 0, 0.05);
  self _meth_82AC( % lookat_head_adds, 0, 0.05);
  self.var_2B6D = undefined;
}

func_195B(param_00) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");
  if(isDefined(self.var_2B80)) {
    return;
  }

  var_01 = param_00;
  self.var_2B80 = 1;
  self.var_2B6D = undefined;
  var_02 = gettime() / 1000;
  var_03 = self _meth_8103( % lookat_left_right);
  var_04 = self _meth_8103( % lookat_up_down);
  var_05 = self _meth_8103( % lookat_head_base_partial);
  var_06 = self _meth_8103( % head_gesture_look_partial);
  var_07 = self _meth_8103( % lookat_head_adds);
  while(gettime() / 1000 - var_02 < var_01) {
    var_08 = gettime() / 1000 - var_02 / var_01;
    var_08 = func_10384(0, 1, var_08);
    var_09 = func_AB7A(var_03, 1, var_08);
    var_0A = func_AB7A(var_04, 1, var_08);
    var_0B = func_AB7A(var_05, 10, var_08);
    var_0C = func_AB7A(var_06, 10, var_08);
    var_0D = func_AB7A(var_07, 0, var_08);
    self _meth_82AC( % lookat_left_right, var_09, 0.05);
    self _meth_82AC( % lookat_up_down, var_0A, 0.05);
    self _meth_82AC( % lookat_head_base_partial, var_0B, 0.05);
    self _meth_82AC( % head_gesture_look_partial, var_0C, 0.05);
    self _meth_82AC( % lookat_head_adds, var_0D, 0.05);
    wait(0.05);
  }

  self _meth_82AC( % lookat_left_right, 1, 0.05);
  self _meth_82AC( % lookat_up_down, 1, 0.05);
  self _meth_82AC( % lookat_head_base_partial, 10, 0.05);
  self _meth_82AC( % head_gesture_look_partial, 10, 0.05);
  self _meth_82AC( % lookat_head_adds, 1, 0.05);
  self.var_2B80 = undefined;
}

func_1967(param_00) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");
  if(!isDefined(self.var_9CE9)) {
    return;
  }

  if(isDefined(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = 0.25;
  }

  var_02 = gettime() / 1000;
  var_03 = self _meth_8103(self.var_11A0C);
  var_04 = self _meth_8103(self.var_11A11);
  var_05 = self _meth_8103(self.var_11A0E);
  var_06 = self _meth_8103(self.var_11A12);
  var_07 = self _meth_8103(self.var_11A0F);
  while(gettime() / 1000 - var_02 < param_00) {
    var_08 = gettime() / 1000 - var_02 / param_00;
    var_08 = func_10384(0, 1, var_08);
    var_09 = func_AB7A(var_03, 1, var_08);
    var_0A = func_AB7A(var_04, 0, var_08);
    var_0B = func_AB7A(var_05, 0, var_08);
    var_0C = func_AB7A(var_06, 0, var_08);
    var_0D = func_AB7A(var_07, 0, var_08);
    self _meth_82AC(self.var_11A0C, var_09, 0.05);
    self _meth_82AC(self.var_11A11, var_0A, 0.05);
    self _meth_82AC(self.var_11A0E, var_0B, 0.05);
    self _meth_82AC(self.var_11A12, var_0C, 0.05);
    self _meth_82AC(self.var_11A0F, var_0D, 0.05);
    wait(0.05);
  }

  self _meth_82AC(self.var_11A0C, 1, 0.05);
  self _meth_82AC(self.var_11A11, 0, 0.05);
  self _meth_82AC(self.var_11A0E, 0, 0.05);
  self _meth_82AC(self.var_11A12, 0, 0.05);
  self _meth_82AC(self.var_11A0F, 0, 0.05);
  self clearanim( % torso_tracking_anims, param_00);
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

func_1955(param_00, param_01, param_02) {
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
    var_03 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var_03 = undefined;
  }

  if(isDefined(self.var_1ED4)) {
    func_110A5();
  }

  if(!isDefined(self.var_1ED4)) {
    self.var_1ED4 = ::func_F580;
  }

  if(isDefined(param_02)) {
    self.var_2B71 = param_02;
  } else {
    self.var_2B71 = 0.7;
  }

  self.var_AFF7 = undefined;
  self.var_AFFA = undefined;
  self.var_B005 = 0;
  if(isDefined(param_01)) {
    self.var_778E = clamp(param_01, 0.25, 4);
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

  self.var_77A3 = param_00;
  if(self.unittype == "c6") {
    thread func_1952();
    thread func_1954();
  } else {
    thread func_1951();
    thread func_1953();
  }

  self.var_9BFC = 1;
}

func_194E(param_00, param_01, param_02) {
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

  if(isDefined(param_02)) {
    self.var_6A55 = param_02;
  } else {
    self.var_6A55 = 0.3;
  }

  self.var_6A5C = undefined;
  self.var_6A5F = undefined;
  self.var_B005 = 0;
  if(isDefined(param_01)) {
    self.var_6A56 = clamp(param_01, 0.25, 4);
  } else {
    self.var_6A56 = 2;
  }

  self.var_6A5C = % facial_gesture_look_rightleft;
  self.var_6A5F = % facial_gesture_look_updwn;
  self.var_6A5D = param_00;
  thread func_194D();
  thread func_1950();
  self.var_9BDC = 1;
}

func_1959(param_00, param_01) {
  self endon("death");
  self endon("entitydeleted");
  self notify("start_gesture_torso_lookat");
  if(isai(self)) {
    var_02 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var_02 = undefined;
  }

  if(!isDefined(var_02)) {
    return;
  }

  if(isDefined(self.var_9CE9)) {
    func_1967(0.25);
    wait(0.25);
  }

  if(isDefined(param_01)) {
    self.var_2B71 = param_01;
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
  self.var_77A3 = param_00;
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

func_196A(param_00, param_01) {
  self endon("death");
  self endon("entitydeleted");
  self.var_77A3 = param_00;
  self.var_9BFC = 1;
  if(isDefined(param_01)) {
    var_02 = self.var_778E;
    self.var_778E = param_01;
    wait(param_01 * 2);
    self.var_778E = var_02;
  }
}

func_1956(param_00, param_01, param_02, param_03) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  while(!func_1921()) {
    wait(0.05);
  }

  while(distance2d(self.origin, param_00.origin) > param_03) {
    wait(0.05);
  }

  thread func_1955(param_00, param_01, param_02);
  wait(param_02);
  for(;;) {
    wait(randomfloatrange(4, 5));
    if(distance2d(self.origin, param_00.origin) <= param_03) {
      thread func_195A(1);
      thread func_194F();
    }

    wait(randomfloatrange(4, 6));
    while(!func_1921()) {
      wait(0.05);
    }

    if(distance2d(self.origin, param_00.origin) <= param_03) {
      thread func_195B(0.5);
      thread func_194E(param_00, 1, 0.2);
    }
  }
}

func_1969(param_00, param_01) {
  self endon("death");
  self endon("entitydeleted");
  self.var_6A5D = param_00;
  self.var_9BDC = 1;
  if(isDefined(param_01)) {
    var_02 = self.var_6A56;
    self.var_6A56 = param_01;
    wait(param_01 * 2);
    self.var_6A56 = var_02;
  }
}

func_1951() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_00 = self.var_2B71;
  var_01 = gettime() / 1000;
  var_02 = undefined;
  var_03 = % lookat_left_right;
  var_04 = self.var_8C5A;
  var_05 = self.var_8C62;
  var_06 = self.var_8C60;
  var_07 = self.var_8C63;
  var_08 = self.var_8C61;
  thread func_1163();
  var_02 = vectortoangles(level.player.origin - self.origin);
  self _meth_82AC(var_04, 1, self.var_2B71);
  self _meth_82AC(var_05, 0.005, self.var_2B71);
  self _meth_82AC(var_06, 0.005, self.var_2B71);
  self _meth_82AC(var_07, 0.005, self.var_2B71);
  self _meth_82AC(var_08, 0.005, self.var_2B71);
  var_09 = 0;
  var_0A = 0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.var_77A3)) {
      thread func_1964(0.7);
      break;
    }

    if(isplayer(self.var_77A3)) {
      var_0B = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_0B = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_0B = self.var_77A3;
    } else {
      var_0B = self.var_77A3.origin;
    }

    var_0C = self gettagangles("J_Spine4") + (0, 0, 0);
    var_0D = self gettagorigin("J_Spine4");
    var_0E = vectornormalize(var_0B - var_0D);
    var_0F = anglestoright(var_0C);
    var_10 = anglestoup(var_0C);
    var_11 = anglestoup(var_0C) * -1;
    var_12 = anglestoright(var_0C) * -1;
    var_13 = anglesToForward(var_0C);
    var_14 = clamp(vectordot(var_0E, var_0F), 0.005, 1);
    var_15 = clamp(vectordot(var_0E, var_10), 0.005, 1);
    var_16 = clamp(vectordot(var_0E, var_11), 0.005, 1);
    var_17 = clamp(vectordot(var_0E, var_12), 0.005, 1);
    var_18 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_0F, var_0E, var_13) > 0) {
      var_18 = 0;
    }

    self _meth_82AC(var_05, var_15, self.var_778E);
    self _meth_82AC(var_06, var_16, self.var_778E);
    self _meth_82AC(var_04, var_14 + 0.005, self.var_778E);
    if(var_18) {
      var_09 = scripts\sp\math::func_AB6F(var_09, var_17, 0.1);
      var_0A = scripts\sp\math::func_AB6F(var_0A, 0.005, 0.1);
    } else {
      var_09 = scripts\sp\math::func_AB6F(var_09, 0.005, 0.1);
      var_0A = scripts\sp\math::func_AB6F(var_0A, var_17, 0.1);
    }

    self _meth_82AC(var_07, var_09, self.var_778E);
    self _meth_82AC(var_08, var_0A, self.var_778E);
    scripts\engine\utility::waitframe();
  }
}

func_1163() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_00 = gettime() / 1000;
  self.var_2B80 = 1;
  while(gettime() / 1000 - var_00 < self.var_2B71 * 2) {
    var_01 = gettime() / 1000 - var_00 / self.var_2B71 * 2;
    var_02 = func_10384(0, 1, var_01);
    var_03 = func_10384(0, 10, var_01);
    var_04 = func_AB7A(0, 1, var_02);
    var_05 = func_AB7A(0, 10, var_02);
    self _meth_82AC( % lookat_left_right, var_04, 0.2);
    self _meth_82AC( % lookat_up_down, var_04, 0.2);
    self _meth_82AC( % lookat_head_base_partial, var_05, 0.2);
    self _meth_82AC( % head_gesture_look_partial, var_05, 0.2);
    wait(0.05);
  }

  self _meth_82AC( % lookat_left_right, 1, 0.2);
  self _meth_82AC( % lookat_up_down, 1, 0.2);
  self _meth_82AC( % lookat_head_base_partial, 10, 0.2);
  self _meth_82AC( % head_gesture_look_partial, 10, 0.2);
  wait(0.05);
  self.var_2B80 = undefined;
}

func_1953() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self _meth_82AC( % lookat_up_down, 1, self.var_2B71);
  self _meth_82AC(self.var_AFFA, 1, self.var_2B71);
  self _meth_82B0(self.var_AFFA, 0.5);
  var_00 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isplayer(self.var_77A3)) {
      var_01 = 0;
      if(level.player _meth_846D() == "safe") {
        var_01 = 4.62;
      }

      var_02 = level.player getEye() + anglestoup(self.angles) * var_01;
    } else if(isai(self.var_77A3)) {
      var_02 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_02 = self.var_77A3;
    } else {
      var_02 = self.var_77A3.origin;
    }

    var_03 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_04 = self gettagorigin("J_Spine4");
    var_05 = undefined;
    if(isai(self)) {
      var_05 = self getEye();
    } else {
      var_05 = self gettagorigin("J_Head");
    }

    var_06 = vectornormalize(var_02 - var_05);
    var_07 = anglesToForward(var_03);
    var_08 = vectordot(var_07, var_06);
    var_09 = func_6F41(var_08, 1, -1, 0, 1);
    var_00 = var_00 + var_09 - var_00 * self.var_778E * 0.3;
    var_00 = clamp(var_00, 0.1, 0.65);
    func_F5CD(self.var_AFFA, var_00);
    scripts\engine\utility::waitframe();
  }
}

func_1161() {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC( % lookat_head_adds, 1, 0.5);
  for(;;) {
    self _meth_82AC( % shipcrib_gst_head_idle_01, 0.25, 0.5);
    wait(getanimlength( % shipcrib_gst_head_idle_01) * randomfloatrange(1, 3));
  }
}

func_194D() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC( % eyes_lookat_base_partial, 10, self.var_6A55 * 2);
  self _meth_82AC( % facial_gesture_look_partial, 10, self.var_6A55 * 2);
  self _meth_82AC( % eyes_look_leftright, 1, self.var_6A55);
  self _meth_82AC(self.var_6A5C, 1, self.var_6A55);
  self _meth_82B0(self.var_6A5C, 0.5);
  self _meth_82B1(self.var_6A5C, 0);
  var_00 = 0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.var_6A5D)) {
      func_194F(0.25);
      break;
    }

    if(isplayer(self.var_6A5D)) {
      var_01 = level.player getEye();
    } else if(isai(self.var_6A5D)) {
      var_01 = self.var_6A5D getEye();
    } else if(isvector(self.var_6A5D)) {
      var_01 = self.var_6A5D;
    } else {
      var_01 = self.var_6A5D.origin;
    }

    var_02 = self gettagangles("j_head");
    var_03 = self gettagorigin("j_head");
    var_04 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_05 = vectornormalize(var_01 - var_03);
    var_06 = anglestoup(var_02);
    var_07 = scripts\engine\utility::flatten_vector(var_05);
    var_08 = scripts\engine\utility::flatten_vector(var_06);
    var_09 = vectordot(var_08, var_07);
    var_0A = func_6F41(var_09, 1, -1, 0, 1);
    var_0B = clamp(var_0A, 0, 1);
    self _meth_82B0(self.var_6A5C, var_0B);
    scripts\engine\utility::waitframe();
  }
}

func_1950() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self _meth_82AC( % eyes_look_updown, 1, self.var_6A55);
  self _meth_82AC(self.var_6A5F, 1, self.var_6A55);
  self _meth_82B0(self.var_6A5F, 0.5);
  var_00 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isplayer(self.var_6A5D)) {
      var_01 = level.player getEye();
    } else if(isai(self.var_6A5D)) {
      var_01 = self.var_6A5D getEye();
    } else if(isvector(self.var_6A5D)) {
      var_01 = self.var_6A5D;
    } else {
      var_01 = self.var_6A5D.origin;
    }

    var_02 = self gettagangles("j_head");
    var_03 = self gettagorigin("j_head");
    var_04 = self gettagangles("J_Spine4");
    var_05 = anglesToForward(var_02);
    var_06 = vectornormalize(var_01 - var_03);
    var_07 = vectordot(var_05, var_06);
    var_08 = func_6F41(var_07, 1, -1, 0.3, 0.7);
    var_09 = clamp(var_08, 0, 1);
    var_00 = var_00 + var_09 - var_00 * self.var_6A56 * 0.3;
    var_00 = clamp(var_00, 0.1, 0.9);
    func_F5CD(self.var_6A5F, var_00);
    scripts\engine\utility::waitframe();
  }
}

func_1966() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var_00 = undefined;
  var_01 = % torso_tracking_anims;
  var_02 = self.var_11A0C;
  var_03 = self.var_11A11;
  var_04 = self.var_11A0E;
  var_05 = self.var_11A12;
  var_06 = self.var_11A0F;
  childthread func_1165();
  var_00 = vectortoangles(level.player.origin - self.origin);
  self _meth_82AC(var_02, 1, 0.05);
  self _meth_82AC(var_03, 0, 0.05);
  self _meth_82AC(var_04, 0, 0.05);
  self _meth_82AC(var_05, 0, 0.05);
  self _meth_82AC(var_06, 0, 0.05);
  var_07 = 0;
  var_08 = 0;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isplayer(self.var_77A3)) {
      var_09 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_09 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_09 = self.var_77A3;
    } else {
      var_09 = self.var_77A3.origin;
    }

    var_0A = vectornormalize(var_09 - self.origin);
    var_0B = anglesToForward(self.angles);
    var_0C = anglestoright(self.angles);
    var_0D = anglestoright(self.angles) * -1;
    var_0E = anglesToForward(self.angles) * -1;
    var_0F = anglestoup(self.angles);
    var_10 = clamp(vectordot(var_0A, var_0B), 0, 1);
    var_11 = clamp(vectordot(var_0A, var_0C), 0, 1);
    var_12 = clamp(vectordot(var_0A, var_0D), 0, 1);
    var_13 = clamp(vectordot(var_0A, var_0E), 0, 1);
    var_14 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_0B, var_0A, var_0F) > 0) {
      var_14 = 0;
    }

    self _meth_82AC(var_03, var_11, 0.2);
    self _meth_82AC(var_04, var_12, 0.2);
    self _meth_82AC(var_02, var_10 + 0.005, 0.2);
    if(var_14) {
      var_07 = scripts\sp\math::func_AB6F(var_07, var_13, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, 0, 0.1);
    } else {
      var_07 = scripts\sp\math::func_AB6F(var_07, 0, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, var_13, 0.1);
    }

    self _meth_82AC(var_05, var_07, 0.2);
    self _meth_82AC(var_06, var_08, 0.2);
    scripts\engine\utility::waitframe();
  }
}

func_1165() {
  var_00 = gettime() / 1000;
  while(gettime() / 1000 - var_00 < self.var_2B71) {
    var_01 = gettime() / 1000 - var_00 / self.var_2B71;
    var_01 = func_10384(0, 1, var_01);
    var_02 = func_AB7A(0, 1, var_01);
    self _meth_82AC( % torso_tracking_anims, var_02, 0.05);
    wait(0.05);
    waittillframeend;
  }

  self _meth_82AC( % torso_tracking_anims, 1, 0.05);
}

func_1948(param_00) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  func_1963();
  for(;;) {
    wait(randomfloatrange(param_00 * 0.5, param_00));
    self clearanim( % facial_gesture_blink_1, 0);
    wait(0.05);
    self _meth_82AC( % facial_gesture_blink_1, 1, 0);
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

  self _meth_82AC( % eyes_blink, 1, 0);
  self clearanim( % facial_gesture_blink_1, 0);
  wait(0.05);
  self _meth_82AC( % facial_gesture_blink_1, 1, 0);
}

func_195D(param_00) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self.var_D633 = undefined;
  self.var_D639 = undefined;
  self.var_D63B = undefined;
  self.var_D63D = undefined;
  self.var_D635 = undefined;
  self.var_C00A = 0;
  self.var_1198.var_D636 = 1;
  var_01 = scripts\asm\asm::asm_getdemeanor();
  var_02 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  lib_0A1E::func_2381(self.asmname, var_02);
  if(var_01 != "casual" && var_01 != "casual_gun") {
    self.var_77AD = % gesture_partials;
  } else {
    self.var_77AD = % point_at_without_head;
  }

  if(!scripts\asm\asm::func_231B(self.asmname, "gesture")) {
    return;
  } else if(var_01 == "casual" || var_01 == "combat" || var_01 == "casual_gun" || var_01 == "frantic") {
    self.var_D633 = self.asm.var_77C1.var_77AA;
    self.var_D639 = self.asm.var_77C1.var_77AC;
    self.var_D63B = self.asm.var_77C1.var_77AE;
    self.var_D63D = self.asm.var_77C1.var_77AF;
    self.var_D635 = self.asm.var_77C1.var_77AB;
    self.var_778D = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
  } else {
    return;
  }

  if(isplayer(param_00)) {
    var_03 = level.player getEye();
  } else if(!isDefined(var_01)) {
    var_03 = self.origin;
    self.var_C00A = 1;
  } else if(isai(var_01)) {
    var_03 = var_01 getEye();
  } else if(isvector(var_01)) {
    var_03 = var_01;
  } else {
    var_03 = var_01.origin;
  }

  var_04 = self gettagangles("J_Spine4") + (0, 90, 0);
  var_05 = self gettagorigin("J_Spine4");
  var_06 = anglestoright(var_04);
  var_07 = anglestoup(var_04);
  var_08 = vectornormalize(var_03 - var_05);
  var_09 = scripts\engine\utility::flatten_vector(var_06);
  var_0A = scripts\engine\utility::flatten_vector(var_07);
  var_0B = scripts\engine\utility::flatten_vector(var_08);
  var_0C = vectordot(var_09, var_0B) * -1;
  var_0D = var_0C * -1;
  var_0E = clamp(func_6F41(var_0C, 0.2, 1, 0, 1), 0, 1);
  var_0F = clamp(func_6F41(var_0D, 0.2, 1, 0, 1), 0, 1);
  var_10 = self gettagorigin("J_Spine4");
  var_11 = vectornormalize(var_03 - var_10);
  var_12 = anglesToForward(var_04);
  var_13 = vectordot(var_11, var_12);
  var_14 = var_13 * -1;
  var_15 = vectordot(var_07, var_11);
  var_16 = clamp(func_6F41(var_15, 0.2, 1, 0, 1), 0, 1);
  var_17 = clamp(func_6F41(var_13, 0.2, 1, 0, 1), 0, 1);
  var_18 = clamp(func_6F41(var_14, 0.2, 1, 0, 1), 0, 1);
  if(!self.var_C00A) {
    if(var_15 < -0.9) {
      func_1960("fallback_up");
    } else {
      if(var_01 != "casual" && var_01 != "casual_gun") {
        self _meth_82AC(self.var_77AD, 10, 0.25);
      } else {
        self _meth_82AC(self.var_77AD, 1, 0.25);
      }

      if(var_16 < 0.3) {
        self _meth_82AC(self.var_D633, 0, 0, 0.85);
      } else {
        self _meth_82AC(self.var_D633, var_16, 0.25, 0.85);
      }

      if(isDefined(self.var_D63D)) {
        self _meth_82AC(self.var_D63D, var_17, 0.25, 0.85);
      }

      if(isDefined(self.var_D635)) {
        self _meth_82AC(self.var_D635, var_18, 0.2, 0.85);
      }

      self _meth_82AC(self.var_D639, var_0F, 0.25, 0.85);
      self _meth_82AC(self.var_D63B, var_0E, 0.25, 0.85);
    }
  } else {
    if(var_01 != "casual" && var_01 != "casual_gun") {
      self _meth_82AC(self.var_77AD, 10, 0.2);
    } else {
      self _meth_82AC(self.var_77AD, 1, 0.2);
    }

    self _meth_82AC(self.var_D633, 1, 0.2, 0.85);
  }

  var_19 = getanimlength( % prototype_gesture_point_center) * 0.85;
  wait(var_19);
  self clearanim(self.var_77AD, 0.25);
  self _meth_82AC(self.var_778D, 1, 0.25);
  self.var_1198.var_D636 = 0;
}

func_1960(param_00) {
  self endon("death");
  self endon("entitydeleted");
  self.var_D633 = undefined;
  self.var_778D = undefined;
  self.var_9C5F = 0;
  var_01 = "casual";
  var_02 = undefined;
  if(isai(self)) {
    self.var_1198.var_778B = 1;
    var_01 = scripts\asm\asm::asm_getdemeanor();
    var_02 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  }

  var_03 = ["shrug", "cross", "nod", "salute", "wave", "wait", "fallback_up"];
  var_04 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_05 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_06 = ["shrug", "cross", "nod", "salute", "wave", "wait", "move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  if(!scripts\engine\utility::array_contains(var_03, param_00) && !scripts\engine\utility::array_contains(var_04, param_00)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isai(self) && !scripts\asm\asm::func_231B(self.asmname, "gesture")) {
    return;
  } else if(isai(self)) {
    self.var_778D = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
    if(var_01 == "casual") {
      if(scripts\engine\utility::array_contains(var_03, param_00)) {
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
    } else if(var_01 == "casual_gun") {
      if(scripts\engine\utility::array_contains(var_06, param_00)) {
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
    } else if(var_01 == "combat") {
      if(scripts\engine\utility::array_contains(var_04, param_00)) {
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else if(var_01 == "cqb") {
      if(scripts\engine\utility::array_contains(var_05, param_00)) {
        self.var_77A6 = self.asm.var_77C1.var_77A6;
        self.var_77A8 = self.asm.var_77C1.var_77A8;
        self.var_77A0 = self.asm.var_77C1.var_77A0;
        self.var_7795 = self.asm.var_77C1.var_7795;
        self.var_7794 = self.asm.var_77C1.var_7794;
        self.var_778C = self.asm.var_77C1.var_778C;
      } else {
        return;
      }
    } else if(var_01 == "frantic") {
      if(scripts\engine\utility::array_contains(var_04, param_00)) {
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

  var_07 = undefined;
  switch (param_00) {
    case "shrug":
      var_07 = self.var_77B6;
      break;

    case "cross":
      var_07 = self.var_778F;
      break;

    case "nod":
      var_07 = self.var_77A7;
      break;

    case "salute":
      var_07 = self.var_77B4;
      break;

    case "wave":
      var_07 = self.var_77BF;
      break;

    case "wait":
      var_07 = self.var_77BE;
      break;

    case "hold":
      self.var_9C5F = 1;
      var_07 = self.var_77A0;
      break;

    case "on_me":
      self.var_9C5F = 1;
      var_07 = self.var_77A8;
      break;

    case "move_up":
      self.var_9C5F = 1;
      var_07 = self.var_77A6;
      break;

    case "fallback_up":
      self.var_9C5F = 1;
      var_07 = self.var_7795;
      break;

    case "fallback_down":
      self.var_9C5F = 1;
      var_07 = self.var_7794;
      break;

    case "arm_up":
      self.var_9C5F = 1;
      var_07 = self.var_778C;
      break;
  }

  if(self.var_9C5F) {
    self.var_101F8 = % gesture_partials;
  } else {
    self.var_101F8 = % add_gesture;
  }

  if(self.var_9C5F) {
    thread func_2B79(self.var_101F8, var_07, 0.5);
  } else {
    self _meth_82AC(self.var_101F8, 1, 0.5);
    self _meth_82AC(var_07, 1, 0.5, 0.75);
  }

  var_08 = getanimlength(var_07) * 0.85;
  wait(var_08);
  if(self.var_9C5F) {
    thread func_2B7A(self.var_101F8, var_07, 0.5);
  } else {
    self clearanim(self.var_101F8, 0.5);
    self clearanim(var_07, 0.5);
  }

  self.var_9C5F = 0;
  if(isai(self)) {
    self.var_1198.var_778B = undefined;
  }
}

func_2B79(param_00, param_01, param_02, param_03) {
  var_04 = param_02 * 0.5;
  self _meth_82AC(param_00, 1, var_04);
  self _meth_82AC(param_01, 1, var_04, 0.75);
  wait(param_02 * 0.5);
  self _meth_82AC(param_01, 10, var_04, 0.75);
  self _meth_82AC(param_00, 10, var_04);
}

func_2B7A(param_00, param_01, param_02) {
  var_03 = param_02 * 0.5;
  self _meth_82AC(param_00, 1, var_03);
  self _meth_82AC(param_01, 1, var_03);
  wait(var_03);
  self clearanim(param_00, var_03);
  self clearanim(param_01, var_03);
}

func_6F41(param_00, param_01, param_02, param_03, param_04) {
  return param_00 - param_01 / param_02 - param_01 * param_04 - param_03 + param_03;
}

func_AB7A(param_00, param_01, param_02) {
  return param_00 + param_02 * param_01 - param_00;
}

func_10384(param_00, param_01, param_02) {
  param_02 = clamp(param_02 - param_00 / param_01 - param_00, 0, 1);
  return param_02 * param_02 * 3 - 2 * param_02;
}

func_F5CD(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.25;
  }

  var_04 = self getscoreinfocategory(param_00);
  var_05 = getanimlength(param_00);
  var_06 = param_01 - var_04 * var_05 / 0.05;
  if(self.unittype == "c6") {
    func_12FB2();
  }

  self _meth_82AC(param_00, param_02, param_03, var_06);
}

func_194C(param_00, param_01, param_02) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_03 = param_01;
  var_04 = param_01[0];
  var_05 = param_01[1];
  var_06 = param_01[2];
  var_07 = param_01[3];
  var_08 = param_01[4];
  var_09 = 0;
  var_0A = undefined;
  self.var_C00A = 0;
  var_0B = undefined;
  if(isDefined(param_02)) {
    var_0A = lib_0A1E::func_2357(self.asm.archetype, "Knobs", "body");
    var_0B = % gesture_partials;
  } else {
    var_0B = % add_gesture;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isplayer(param_00)) {
    var_0C = level.player getEye();
  } else if(!isDefined(param_01)) {
    var_0C = self.origin;
    var_09 = 1;
  } else if(isai(param_01)) {
    var_0C = param_01 getEye();
  } else if(isvector(param_01)) {
    var_0C = param_01;
  } else {
    var_0C = param_01.origin;
  }

  var_0D = self gettagangles("tag_origin");
  var_0E = self gettagorigin("tag_origin");
  var_0F = anglestoright(var_0D);
  var_10 = anglesToForward(var_0D);
  var_11 = vectornormalize(var_0C - var_0E);
  var_12 = scripts\engine\utility::flatten_vector(var_0F);
  var_13 = scripts\engine\utility::flatten_vector(var_10);
  var_14 = scripts\engine\utility::flatten_vector(var_11);
  var_15 = vectordot(var_12, var_14);
  var_16 = var_15 * -1;
  var_17 = clamp(func_6F41(var_15, 0.2, 1, 0, 1), 0, 1);
  var_18 = clamp(func_6F41(var_16, 0.2, 1, 0, 1), 0, 1);
  var_19 = self gettagorigin("J_Spine4");
  var_1A = vectornormalize(var_0C - var_19);
  var_1B = anglestoup(var_0D);
  var_1C = vectordot(var_1A, var_1B);
  var_1D = var_1C * -1;
  var_1E = vectordot(var_13, var_1A);
  var_1F = clamp(func_6F41(var_1E, 0.2, 1, 0, 1), 0, 1);
  var_20 = clamp(func_6F41(var_1C, 0.2, 1, 0, 1), 0, 1);
  var_21 = clamp(func_6F41(var_1D, 0.2, 1, 0, 1), 0, 1);
  if(!self.var_C00A) {
    if(isDefined(param_02)) {
      self _meth_82AC(var_0B, 10, 0.25);
    } else {
      self _meth_82AC(var_0B, 1, 0.25);
    }

    if(var_1F < 0.3) {
      self _meth_82AC(var_04, 0, 0, 1);
    } else {
      self _meth_82AC(var_04, var_1F, 0.25, 1);
    }

    if(isDefined(var_07)) {
      self _meth_82AC(var_07, var_20, 0.25, 1);
    }

    if(isDefined(var_08)) {
      self _meth_82AC(var_08, var_21, 0.25, 1);
    }

    self _meth_82AC(var_05, var_18, 0.25, 1);
    self _meth_82AC(var_06, var_17, 0.25, 1);
  } else {
    if(isDefined(param_02)) {
      self _meth_82AC(var_0A, 0.001, 0.1);
    }

    self _meth_82AC(var_0B, 1, 0.25);
    self _meth_82AC(var_04, 1, 0.25);
  }

  var_22 = getanimlength(var_04);
  wait(var_22);
  self clearanim(var_0B, 0.25);
  self _meth_82AC(var_0A, 1, 0.25);
}

func_192F(param_00, param_01) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  var_02 = % add_gesture;
  var_03 = 0;
  var_04 = "single anim";
  thread scripts\sp\anim::func_10CBF(self, var_04, undefined, undefined, param_00);
  if(isDefined(param_01) && param_01) {
    var_02 = % gesture_partials;
    var_03 = 1;
  }

  if(var_03) {
    thread func_2B79(var_02, param_00, 0.2);
  } else {
    self _meth_82AC(var_02, 1, 0.1);
    self _meth_82AC(param_00, 1, 0.1);
  }

  var_05 = getanimlength(param_00) * 0.75 - 0.2;
  wait(var_05);
  if(var_03) {
    thread func_2B7A(var_02, param_00, 0.2);
    return;
  }

  self clearanim(var_02, 0.2);
  self clearanim(param_00, 0.2);
}

func_12FB2() {
  self.var_AFF7 = % prototype_gesture_look_rightleft;
  self.var_AFFA = % prototype_gesture_look_updwn;
}

func_1952() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_00 = self.var_2B71;
  var_01 = gettime() / 1000;
  while(gettime() / 1000 - var_01 < var_00) {
    var_02 = gettime() / 1000 - var_01 / var_00;
    var_02 = func_10384(0, 1, var_02);
    var_03 = func_AB7A(0, 1, var_02);
    var_04 = func_AB7A(0, 1, var_02);
    var_05 = func_AB7A(0, 5, var_02);
    var_06 = func_AB7A(0, 5, var_02);
    self _meth_82AC( % lookat_left_right, var_03, 0.05);
    self _meth_82AC(self.var_AFF7, var_04, 0.05);
    self _meth_82AC( % lookat_head_base_partial, var_05, 0.05);
    self _meth_82AC( % head_gesture_look_partial, var_06, 0.05);
    self _meth_82B0(self.var_AFF7, 0.5);
    wait(0.05);
    waittillframeend;
  }

  self _meth_82AC( % lookat_left_right, 1, 0.05);
  self _meth_82AC(self.var_AFF7, 1, 0.05);
  self _meth_82AC( % lookat_head_base_partial, 5, 0.05);
  self _meth_82AC( % head_gesture_look_partial, 5, 0.05);
  var_07 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isplayer(self.var_77A3)) {
      var_08 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_08 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_08 = self.var_77A3;
    } else {
      var_08 = self.var_77A3.origin;
    }

    var_09 = self gettagangles("J_Head");
    var_0A = self gettagorigin("J_Head");
    var_0B = self gettagangles("J_Spine4") + (0, 90, 0);
    var_0C = self gettagorigin("J_Spine4");
    var_0D = vectornormalize(var_08 - var_0C);
    var_0E = anglestoright(var_0B);
    var_0F = scripts\engine\utility::flatten_vector(var_0E);
    var_10 = scripts\engine\utility::flatten_vector(var_0D);
    var_11 = vectordot(var_0F, var_10);
    var_12 = func_6F41(var_11, -1, 1, 0, 1);
    var_12 = clamp(var_12, 0, 1);
    var_07 = var_07 + var_12 - var_07 * self.var_778E;
    var_07 = clamp(var_07, 0.1, 0.9);
    func_F5CD(self.var_AFF7, var_07, 1);
    scripts\engine\utility::waitframe();
  }
}

func_1954() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self _meth_82AC( % lookat_up_down, 1, self.var_2B71);
  self _meth_82AC(self.var_AFFA, 1, self.var_2B71);
  self _meth_82B0(self.var_AFFA, 0.5);
  var_00 = 0.5;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isplayer(self.var_77A3)) {
      var_01 = level.player getEye();
    } else if(isai(self.var_77A3)) {
      var_01 = self.var_77A3 getEye();
    } else if(isvector(self.var_77A3)) {
      var_01 = self.var_77A3;
    } else {
      var_01 = self.var_77A3.origin;
    }

    var_02 = self gettagangles("J_Spine4") + (0, 0, 0);
    var_03 = self gettagorigin("J_Spine4");
    var_04 = undefined;
    if(isai(self)) {
      var_04 = self getEye();
    } else {
      var_04 = self gettagorigin("J_Head");
    }

    var_05 = vectornormalize(var_01 - var_04);
    var_06 = anglesToForward(var_02);
    var_07 = vectordot(var_06, var_05);
    var_08 = func_6F41(var_07, 1, -1, 0, 1);
    var_00 = var_00 + var_08 - var_00 * self.var_778E * 0.3;
    var_00 = clamp(var_00, 0.1, 0.65);
    func_F5CD(self.var_AFFA, var_00);
    scripts\engine\utility::waitframe();
  }
}

func_1965(param_00) {
  self endon("death");
  self endon("entitydeleted");
  self notify("gesture_stop");
  if(isDefined(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = 0.25;
  }

  self _meth_82AC( % lookat_left_right, 1, var_01 * 0.15);
  self _meth_82AC( % lookat_up_down, 1, var_01 * 0.15);
  self _meth_82AC( % lookat_head_base_partial, 1, var_01 * 0.15);
  self _meth_82AC( % head_gesture_look_partial, 1, var_01 * 0.15);
  wait(var_01 * 0.15);
  self clearanim( % lookat_left_right, var_01 * 0.85);
  self clearanim( % lookat_up_down, var_01 * 0.85);
  self clearanim( % lookat_head_base_partial, var_01 * 0.85);
  self clearanim( % head_gesture_look_partial, var_01 * 0.85);
  self.var_9BFC = undefined;
}

func_2B8A() {
  var_00 = self;
  self endon(self.var_6317);
  var_00.var_7540 = undefined;
  var_00.var_E512 = undefined;
  var_00.var_AB35 = undefined;
  var_00.var_AB54 = undefined;
  var_00.var_E52E = undefined;
  foreach(var_02 in var_00.var_1E9D) {
    if(issubstr(var_02, "forward")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_7540 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "right") && !issubstr(var_02, "back")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_E512 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "left") && !issubstr(var_02, "back")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_AB35 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "leftback")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_AB54 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "rightback")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_E52E = level.var_EC85[var_00.var_1FBB][var_02];
      }
    }
  }

  var_04 = getstartorigin(self.var_1FBD.origin, self.var_1FBD.angles, var_00.var_7540);
  var_05 = getstartangles(self.var_1FBD.origin, self.var_1FBD.angles, var_00.var_7540);
  if(isai(var_00)) {
    var_00 _meth_80F1(var_04, var_05, 10000);
  } else {
    var_00.origin = var_04;
    var_00.angles = var_05;
  }

  var_06 = vectortoangles(level.player.origin - var_00.origin);
  var_00 _meth_82A5(var_00.var_7540, % root, 1, 0.2);
  if(isDefined(var_00.var_E512)) {
    var_00 _meth_82AC(var_00.var_E512, 0, 0.2);
  }

  if(isDefined(var_00.var_AB35)) {
    var_00 _meth_82AC(var_00.var_AB35, 0, 0.2);
  }

  if(isDefined(var_00.var_AB54)) {
    var_00 _meth_82AC(var_00.var_AB54, 0, 0.2);
  }

  if(isDefined(var_00.var_E52E)) {
    var_00 _meth_82AC(var_00.var_E52E, 0, 0.2);
  }

  var_07 = 0;
  var_08 = 0;
  var_00 _meth_8250(1);
  for(;;) {
    if(!isDefined(var_00)) {
      break;
    }

    if(isplayer(var_00.var_77A3)) {
      var_09 = level.player getEye();
    } else if(isai(var_00.var_77A3)) {
      var_09 = var_00.var_77A3 getEye();
    } else if(isvector(var_00.var_77A3)) {
      var_09 = var_00.var_77A3;
    } else {
      var_09 = var_00.var_77A3.origin;
    }

    var_0A = var_00 gettagangles("tag_origin");
    var_0B = var_00 gettagorigin("tag_origin");
    var_0C = scripts\engine\utility::flatten_vector(vectornormalize(var_09 - var_0B));
    var_0D = anglesToForward(var_0A);
    var_0E = anglestoright(var_0A);
    var_0F = anglestoright(var_0A) * -1;
    var_10 = anglesToForward(var_0A) * -1;
    var_11 = anglestoup(var_0A);
    var_12 = clamp(vectordot(var_0C, var_0D), 0, 1);
    var_13 = clamp(vectordot(var_0C, var_0E), 0, 1);
    var_14 = clamp(vectordot(var_0C, var_0F), 0, 1);
    var_15 = clamp(vectordot(var_0C, var_10), 0, 1);
    var_16 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_0D, var_0C, var_11) > 0) {
      var_16 = 0;
    }

    if(isDefined(var_00.var_E512)) {
      var_00 _meth_82AC(var_00.var_E512, var_13, 0.2);
    }

    if(isDefined(var_00.var_AB35)) {
      var_00 _meth_82AC(var_00.var_AB35, var_14, 0.2);
    }

    var_00 _meth_82AC(var_00.var_7540, var_12 + 0.005, 0.2);
    if(var_16) {
      var_07 = scripts\sp\math::func_AB6F(var_07, var_15, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, 0, 0.1);
    } else {
      var_07 = scripts\sp\math::func_AB6F(var_07, 0, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, var_15, 0.1);
    }

    if(isDefined(var_00.var_E52E)) {
      var_00 _meth_82AC(var_00.var_E52E, var_07 + 0.005, 0.2);
    }

    if(isDefined(var_00.var_AB54)) {
      var_00 _meth_82AC(var_00.var_AB54, var_08 + 0.005, 0.2);
    }

    scripts\engine\utility::waitframe();
    waittillframeend;
  }
}

func_2B8B() {
  var_00 = self;
  if(isDefined(var_00.var_6317)) {
    var_00 notify(var_00.var_6317);
  }

  var_00 clearanim(var_00.var_7540, 0.2);
  if(isDefined(var_00.var_E512)) {
    var_00 clearanim(var_00.var_E512, 0.2);
  }

  if(isDefined(var_00.var_AB35)) {
    var_00 clearanim(var_00.var_AB35, 0.2);
  }

  if(isDefined(var_00.var_AB54)) {
    var_00 clearanim(var_00.var_AB54, 0.2);
  }

  if(isDefined(var_00.var_E52E)) {
    var_00 clearanim(var_00.var_E52E, 0.2);
  }

  var_00 _meth_8250(0);
  var_00.var_7540 = undefined;
  var_00.var_E512 = undefined;
  var_00.var_AB35 = undefined;
  var_00.var_AB54 = undefined;
  var_00.var_E52E = undefined;
  var_00.var_1E9D = undefined;
  var_00.var_6317 = undefined;
  var_00.var_77A3 = undefined;
}

func_2B86() {
  var_00 = self;
  var_00.var_7540 = undefined;
  var_00.var_E512 = undefined;
  var_00.var_AB35 = undefined;
  var_00.var_AB54 = undefined;
  var_00.var_E52E = undefined;
  foreach(var_02 in var_00.var_1E9D) {
    if(issubstr(var_02, "forward")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_7540 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "right") && !issubstr(var_02, "back")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_E512 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "left") && !issubstr(var_02, "back")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_AB35 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "leftback")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_AB54 = level.var_EC85[var_00.var_1FBB][var_02];
      }

      continue;
    }

    if(issubstr(var_02, "rightback")) {
      if(isDefined(level.var_EC85[var_00.var_1FBB][var_02])) {
        var_00.var_E52E = level.var_EC85[var_00.var_1FBB][var_02];
      }
    }
  }

  var_04 = getstartorigin(self.var_1FBD.origin, self.var_1FBD.angles, var_00.var_7540);
  var_05 = getstartangles(self.var_1FBD.origin, self.var_1FBD.angles, var_00.var_7540);
  if(isai(var_00)) {
    var_00 _meth_80F1(var_04, var_05, 10000);
  } else {
    var_00.origin = var_04;
    var_00.angles = var_05;
  }

  var_06 = vectortoangles(level.player.origin - var_00.origin);
  var_00 _meth_82A5(var_00.var_7540, % root, 1, 0.2);
  if(isDefined(var_00.var_E512)) {
    var_00 _meth_82AC(var_00.var_E512, 0, 0.2);
  }

  if(isDefined(var_00.var_AB35)) {
    var_00 _meth_82AC(var_00.var_AB35, 0, 0.2);
  }

  if(isDefined(var_00.var_AB54)) {
    var_00 _meth_82AC(var_00.var_AB54, 0, 0.2);
  }

  if(isDefined(var_00.var_E52E)) {
    var_00 _meth_82AC(var_00.var_E52E, 0, 0.2);
  }

  var_07 = 0;
  var_08 = 0;
  var_09 = gettime() / 1000;
  var_0A = getanimlength(var_00.var_7540);
  while(gettime() / 1000 - var_09 < var_0A) {
    if(!isDefined(var_00)) {
      break;
    }

    if(isplayer(var_00.var_77A3)) {
      var_0B = level.player getEye();
    } else if(isai(var_00.var_77A3)) {
      var_0B = var_00.var_77A3 getEye();
    } else if(isvector(var_00.var_77A3)) {
      var_0B = var_00.var_77A3;
    } else {
      var_0B = var_00.var_77A3.origin;
    }

    var_0C = var_00 gettagangles("tag_origin");
    var_0D = var_00 gettagorigin("tag_origin");
    var_0E = scripts\engine\utility::flatten_vector(vectornormalize(var_0B - var_0D));
    var_0F = anglesToForward(var_0C);
    var_10 = anglestoright(var_0C);
    var_11 = anglestoright(var_0C) * -1;
    var_12 = anglesToForward(var_0C) * -1;
    var_13 = anglestoup(var_0C);
    var_14 = clamp(vectordot(var_0E, var_0F), 0, 1);
    var_15 = clamp(vectordot(var_0E, var_10), 0, 1);
    var_16 = clamp(vectordot(var_0E, var_11), 0, 1);
    var_17 = clamp(vectordot(var_0E, var_12), 0, 1);
    var_18 = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_0F, var_0E, var_13) > 0) {
      var_18 = 0;
    }

    if(isDefined(var_00.var_E512)) {
      var_00 _meth_82AC(var_00.var_E512, var_15, 0.2);
    }

    if(isDefined(var_00.var_AB35)) {
      var_00 _meth_82AC(var_00.var_AB35, var_16, 0.2);
    }

    var_00 _meth_82AC(var_00.var_7540, var_14 + 0.005, 0.2);
    if(var_18) {
      var_07 = scripts\sp\math::func_AB6F(var_07, var_17, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, 0, 0.1);
    } else {
      var_07 = scripts\sp\math::func_AB6F(var_07, 0, 0.1);
      var_08 = scripts\sp\math::func_AB6F(var_08, var_17, 0.1);
    }

    if(isDefined(var_00.var_E52E)) {
      var_00 _meth_82AC(var_00.var_E52E, var_07 + 0.005, 0.2);
    }

    if(isDefined(var_00.var_AB54)) {
      var_00 _meth_82AC(var_00.var_AB54, var_08 + 0.005, 0.2);
    }

    scripts\engine\utility::waitframe();
    waittillframeend;
  }

  var_00 thread func_2B8B();
}