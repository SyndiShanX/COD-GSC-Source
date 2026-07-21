/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\gesture\script_funcs.gsc
***********************************************/

checkbcstatevalid(var_0, var_1, var_2, var_3) {
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

  if(isDefined(self._blackboard.battlechatter_alias)) {
    if(self._blackboard.battlechatter_alias == var_3)
      return 1;
    else
      return 0;
  } else
    return 0;
}

choosebcdirectionanim(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._blackboard.battlechatter_target))
    var_3 = self._blackboard.battlechatter_target.origin;
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

    var_4 = get_anim_direction(var_6, self.origin, var_3);
  }

  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);

  if(!isDefined(var_7))
    var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "8");

  return var_7;
}

playbcanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self._blackboard.battlechatter_anim_active = 1;
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self._blackboard.battlechatter_alias = undefined;
  self._blackboard.battlechatter_anim_active = undefined;
}

ai_gesture_requested(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.gesture_active);
}

ai_point_gesture_requested(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.point_gesture_active);
}

_is_looking_at_range(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectorNormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 >= var_1)
    return 1;
  else
    return 0;
}

get_anim_direction(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = angleclamp180(var_3[1] - var_0[1]);
  var_5 = getangleindex(var_4, 10);
  var_6 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var_6[var_5];
}

#using_animtree("generic_human");

ai_gesture_stop(var_0) {
  self notify("new_gesture_stop_begin");
  self notify("gesture_stop");
  self endon("death");
  self endon("start_gesture_lookat");
  self endon("new_gesture_stop_begin");
  self endon("entitydeleted");

  if(isDefined(self.anim_getrootfunc) && isDefined(self.old_root))
    reset_root();

  if(isDefined(self.anim_getrootfunc) && !isDefined(self.old_root))
    self.anim_getrootfunc = undefined;

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  if(!isDefined(self.is_head_tracking)) {
    return;
  }
  var_2 = gettime() / 1000;
  var_3 = self getanimweight(self.head_center_anim);
  var_4 = self getanimweight(self.head_right_anim);
  var_5 = self getanimweight(self.head_left_anim);
  var_6 = self getanimweight(self.head_rightback_anim);
  var_7 = self getanimweight(self.head_leftback_anim);
  var_8 = self getanimweight(%lookat_left_right);
  var_9 = self getanimweight(%lookat_up_down);
  var_10 = self getanimweight(%lookat_head_base_partial);
  var_11 = self getanimweight(%head_gesture_look_partial);
  var_12 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_0) {
    var_13 = (gettime() / 1000 - var_2) / var_0;
    var_13 = smoothstep(0, 1, var_13);
    var_14 = lerp_float(var_3, 1, var_13);
    var_15 = lerp_float(var_4, 0, var_13);
    var_16 = lerp_float(var_5, 0, var_13);
    var_17 = lerp_float(var_6, 0, var_13);
    var_18 = lerp_float(var_7, 0, var_13);
    var_19 = lerp_float(var_8, 0, var_13);
    var_20 = lerp_float(var_9, 0, var_13);
    var_21 = lerp_float(var_10, 0, var_13);
    var_22 = lerp_float(var_11, 0, var_13);
    var_23 = lerp_float(var_12, 0, var_13);
    self setanimlimited(self.head_center_anim, var_14, 0.05);
    self setanimlimited(self.head_right_anim, var_15, 0.05);
    self setanimlimited(self.head_left_anim, var_16, 0.05);
    self setanimlimited(self.head_rightback_anim, var_17, 0.05);
    self setanimlimited(self.head_leftback_anim, var_18, 0.05);
    self setanimlimited(%lookat_left_right, var_19, 0.05);
    self setanimlimited(%lookat_up_down, var_20, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_21, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_22, 0.05);
    self setanimlimited(%lookat_head_adds, var_23, 0.05);
    wait 0.05;
  }

  self setanimlimited(self.head_center_anim, 0, 0.05);
  self setanimlimited(self.head_right_anim, 0, 0.05);
  self setanimlimited(self.head_left_anim, 0, 0.05);
  self setanimlimited(self.head_rightback_anim, 0, 0.05);
  self setanimlimited(self.head_leftback_anim, 0, 0.05);
  self setanimlimited(%lookat_left_right, 0, 0.05);
  self setanimlimited(%lookat_up_down, 0, 0.05);
  self setanimlimited(%lookat_head_base_partial, 0, 0.05);
  self setanimlimited(%head_gesture_look_partial, 0, 0.05);
  self setanimlimited(%lookat_head_adds, 0, 0.05);
  self clearanim(%lookat_left_right, 0.05);
  self clearanim(%lookat_up_down, 0.05);
  self.is_head_tracking = undefined;
}

ai_gesture_eyes_stop(var_0) {
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
  self.is_eye_tracking = undefined;
}

ai_gesture_lookat_weight_down(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");

  if(isDefined(self.blend_down_in_progress)) {
    return;
  }
  var_1 = var_0;
  self.blend_down_in_progress = 1;
  self.blend_up_in_progress = undefined;
  var_2 = gettime() / 1000;
  var_3 = self getanimweight(%lookat_left_right);
  var_4 = self getanimweight(%lookat_up_down);
  var_5 = self getanimweight(%lookat_head_base_partial);
  var_6 = self getanimweight(%head_gesture_look_partial);
  var_7 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = (gettime() / 1000 - var_2) / var_1;
    var_8 = smoothstep(0, 1, var_8);
    var_9 = lerp_float(var_3, 0, var_8);
    var_10 = lerp_float(var_4, 0, var_8);
    var_11 = lerp_float(var_5, 0, var_8);
    var_12 = lerp_float(var_6, 0, var_8);
    var_13 = lerp_float(var_7, 0, var_8);
    self setanimlimited(%lookat_left_right, var_9, 0.05);
    self setanimlimited(%lookat_up_down, var_10, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_11, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_12, 0.05);
    self setanimlimited(%lookat_head_adds, var_13, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 0, 0.05);
  self setanimlimited(%lookat_up_down, 0, 0.05);
  self setanimlimited(%lookat_head_base_partial, 0, 0.05);
  self setanimlimited(%head_gesture_look_partial, 0, 0.05);
  self setanimlimited(%lookat_head_adds, 0, 0.05);
  self.blend_down_in_progress = undefined;
}

ai_gesture_lookat_weight_up(var_0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");

  if(isDefined(self.blend_up_in_progress)) {
    return;
  }
  var_1 = var_0;
  self.blend_up_in_progress = 1;
  self.blend_down_in_progress = undefined;
  var_2 = gettime() / 1000;
  var_3 = self getanimweight(%lookat_left_right);
  var_4 = self getanimweight(%lookat_up_down);
  var_5 = self getanimweight(%lookat_head_base_partial);
  var_6 = self getanimweight(%head_gesture_look_partial);
  var_7 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var_2 < var_1) {
    var_8 = (gettime() / 1000 - var_2) / var_1;
    var_8 = smoothstep(0, 1, var_8);
    var_9 = lerp_float(var_3, 1, var_8);
    var_10 = lerp_float(var_4, 1, var_8);
    var_11 = lerp_float(var_5, 10, var_8);
    var_12 = lerp_float(var_6, 10, var_8);
    var_13 = lerp_float(var_7, 0, var_8);
    self setanimlimited(%lookat_left_right, var_9, 0.05);
    self setanimlimited(%lookat_up_down, var_10, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_11, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_12, 0.05);
    self setanimlimited(%lookat_head_adds, var_13, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 1, 0.05);
  self setanimlimited(%lookat_up_down, 1, 0.05);
  self setanimlimited(%lookat_head_base_partial, 10, 0.05);
  self setanimlimited(%head_gesture_look_partial, 10, 0.05);
  self setanimlimited(%lookat_head_adds, 1, 0.05);
  self.blend_up_in_progress = undefined;
}

ai_gesture_torso_stop(var_0) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");

  if(!isDefined(self.is_torso_tracking)) {
    return;
  }
  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  var_2 = gettime() / 1000;
  var_3 = self getanimweight(self.torso_center_anim);
  var_4 = self getanimweight(self.torso_right_anim);
  var_5 = self getanimweight(self.torso_left_anim);
  var_6 = self getanimweight(self.torso_rightback_anim);
  var_7 = self getanimweight(self.torso_leftback_anim);

  while(gettime() / 1000 - var_2 < var_0) {
    var_8 = (gettime() / 1000 - var_2) / var_0;
    var_8 = smoothstep(0, 1, var_8);
    var_9 = lerp_float(var_3, 1, var_8);
    var_10 = lerp_float(var_4, 0, var_8);
    var_11 = lerp_float(var_5, 0, var_8);
    var_12 = lerp_float(var_6, 0, var_8);
    var_13 = lerp_float(var_7, 0, var_8);
    self setanimlimited(self.torso_center_anim, var_9, 0.05);
    self setanimlimited(self.torso_right_anim, var_10, 0.05);
    self setanimlimited(self.torso_left_anim, var_11, 0.05);
    self setanimlimited(self.torso_rightback_anim, var_12, 0.05);
    self setanimlimited(self.torso_leftback_anim, var_13, 0.05);
    wait 0.05;
  }

  self setanimlimited(self.torso_center_anim, 1, 0.05);
  self setanimlimited(self.torso_right_anim, 0, 0.05);
  self setanimlimited(self.torso_left_anim, 0, 0.05);
  self setanimlimited(self.torso_rightback_anim, 0, 0.05);
  self setanimlimited(self.torso_leftback_anim, 0, 0.05);
  self clearanim(%torso_tracking_anims, var_0);
  self.is_torso_tracking = undefined;
}

ai_lookat_hold() {
  self.hold_lookat = 1;
}

ai_lookat_release() {
  self.hold_lookat = undefined;
}

ai_can_lookat() {
  if(isDefined(self.hold_lookat))
    return 0;
  else
    return 1;
}

ai_gesture_lookat(var_0, var_1, var_2) {
  self endon("entitydeleted");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.is_head_tracking)) {
    ai_gesture_stop(0.25);
    wait 0.25;
  }

  self endon("death");
  self endon("gesture_stop");
  self notify("start_gesture_lookat");

  if(isai(self))
    var_3 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  else
    var_3 = undefined;

  if(isDefined(self.anim_getrootfunc))
    store_old_root();

  if(!isDefined(self.anim_getrootfunc))
    self.anim_getrootfunc = ::set_root;

  if(isDefined(var_2))
    self.blend_in_time = var_2;
  else
    self.blend_in_time = 0.7;

  self.look_leftright_anim = undefined;
  self.look_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(var_1))
    self.gesture_catchup_speed = clamp(var_1, 0.25, 4.0);
  else
    self.gesture_catchup_speed = 0.5;

  if(self.unittype == "c6")
    use_c6_animtree();
  else {
    self.look_leftright_anim = % prototype_gesture_look_rightleft;
    self.look_updown_anim = % prototype_gesture_look_updwn;
    self.head_center_anim = % gesture_head_fwd;
    self.head_right_anim = % gesture_head_right;
    self.head_left_anim = % gesture_head_left;
    self.head_rightback_anim = % gesture_head_rightback;
    self.head_leftback_anim = % gesture_head_leftback;
  }

  self.gesture_lookat = var_0;

  if(self.unittype == "c6") {
    thread ai_gesture_head_leftright_c6();
    thread ai_gesture_head_updown_c6();
  } else {
    thread ai_gesture_head_leftright();
    thread ai_gesture_head_updown();
  }

  self.is_head_tracking = 1;
}

ai_gesture_eyes_lookat(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self.is_eye_tracking)) {
    ai_gesture_eyes_stop(0.25);
    wait 0.25;
  }

  if(isDefined(self.anim_getrootfunc))
    store_old_root();

  if(!isDefined(self.anim_getrootfunc))
    self.anim_getrootfunc = ::set_root;

  if(isDefined(var_2))
    self.eye_blend_in_time = var_2;
  else
    self.eye_blend_in_time = 0.3;

  self.eyes_leftright_anim = undefined;
  self.eyes_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(var_1))
    self.eye_catchup_speed = clamp(var_1, 0.25, 4.0);
  else
    self.eye_catchup_speed = 2.0;

  self.eyes_leftright_anim = % facial_gesture_look_rightleft;
  self.eyes_updown_anim = % facial_gesture_look_updwn;
  self.eyes_lookat = var_0;
  thread ai_gesture_eyes_leftright();
  thread ai_gesture_eyes_updown();
  self.is_eye_tracking = 1;
}

ai_gesture_lookat_torso(var_0, var_1) {
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
  if(isDefined(self.is_torso_tracking)) {
    ai_gesture_torso_stop(0.25);
    wait 0.25;
  }

  if(isDefined(var_1))
    self.blend_in_time = var_1;
  else
    self.blend_in_time = 0.7;

  self.torso_leftright_anim = undefined;
  self.lookat_aquired = 0;
  self.torso_center_anim = % hm_grnd_grn_casual_stand_center_idle;
  self.torso_left_anim = % hm_grnd_grn_casual_stand_left_idle;
  self.torso_leftback_anim = % hm_grnd_grn_casual_stand_leftback_idle;
  self.torso_right_anim = % hm_grnd_grn_casual_stand_right_idle;
  self.torso_rightback_anim = % hm_grnd_grn_casual_stand_rightback_idle;
  self.gesture_lookat = var_0;
  thread ai_gesture_torso_leftright();
  self.is_torso_tracking = 1;
}

set_root() {
  return % body;
}

store_old_root() {
  self.old_root = self.anim_getrootfunc;
}

reset_root() {
  self.anim_getrootfunc = self.old_root;
}

ai_gesture_update_lookat(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.gesture_lookat = var_0;
  self.is_head_tracking = 1;

  if(isDefined(var_1)) {
    var_2 = self.gesture_catchup_speed;
    self.gesture_catchup_speed = var_1;
    wait(var_1 * 2);
    self.gesture_catchup_speed = var_2;
  }
}

ai_gesture_lookat_natural(var_0, var_1, var_2, var_3) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  while(!ai_can_lookat())
    wait 0.05;

  while(distance2d(self.origin, var_0.origin) > var_3)
    wait 0.05;

  thread ai_gesture_lookat(var_0, var_1, var_2);
  wait(var_2);

  for(;;) {
    wait(randomfloatrange(4.0, 5.0));

    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread ai_gesture_lookat_weight_down(1.0);
      thread ai_gesture_eyes_stop();
    }

    wait(randomfloatrange(4.0, 6.0));

    while(!ai_can_lookat())
      wait 0.05;

    if(distance2d(self.origin, var_0.origin) <= var_3) {
      thread ai_gesture_lookat_weight_up(0.5);
      thread ai_gesture_eyes_lookat(var_0, 1.0, 0.2);
    }
  }
}

ai_gesture_update_eyes_lookat(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.eyes_lookat = var_0;
  self.is_eye_tracking = 1;

  if(isDefined(var_1)) {
    var_2 = self.eye_catchup_speed;
    self.eye_catchup_speed = var_1;
    wait(var_1 * 2);
    self.eye_catchup_speed = var_2;
  }
}

ai_gesture_head_leftright() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self.blend_in_time;
  var_1 = gettime() / 1000;
  var_2 = undefined;
  var_3 = % lookat_left_right;
  var_4 = self.head_center_anim;
  var_5 = self.head_right_anim;
  var_6 = self.head_left_anim;
  var_7 = self.head_rightback_anim;
  var_8 = self.head_leftback_anim;
  thread _ai_head_weight_blend_in();
  var_2 = vectortoangles(level.player.origin - self.origin);
  self setanimlimited(var_4, 1.0, self.blend_in_time);
  self setanimlimited(var_5, 0.005, self.blend_in_time);
  self setanimlimited(var_6, 0.005, self.blend_in_time);
  self setanimlimited(var_7, 0.005, self.blend_in_time);
  self setanimlimited(var_8, 0.005, self.blend_in_time);
  var_9 = 0;
  var_10 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.gesture_lookat)) {
      thread ai_gesture_stop(0.7);
      break;
    }

    if(isPlayer(self.gesture_lookat))
      var_11 = level.player getEye();
    else if(isai(self.gesture_lookat))
      var_11 = self.gesture_lookat getEye();
    else if(isvector(self.gesture_lookat))
      var_11 = self.gesture_lookat;
    else
      var_11 = self.gesture_lookat.origin;

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

    if(scripts\engine\math::anglebetweenvectorssigned(var_15, var_14, var_19) > 0)
      var_24 = 0;

    self setanimlimited(var_5, var_21, self.gesture_catchup_speed);
    self setanimlimited(var_6, var_22, self.gesture_catchup_speed);
    self setanimlimited(var_4, var_20 + 0.005, self.gesture_catchup_speed);

    if(var_24) {
      var_9 = scripts\engine\math::lerp(var_9, var_23, 0.1);
      var_10 = scripts\engine\math::lerp(var_10, 0.005, 0.1);
    } else {
      var_9 = scripts\engine\math::lerp(var_9, 0.005, 0.1);
      var_10 = scripts\engine\math::lerp(var_10, var_23, 0.1);
    }

    self setanimlimited(var_7, var_9, self.gesture_catchup_speed);
    self setanimlimited(var_8, var_10, self.gesture_catchup_speed);
    waitframe();
  }
}

_ai_head_weight_blend_in() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = gettime() / 1000;
  self.blend_up_in_progress = 1;

  while(gettime() / 1000 - var_0 < self.blend_in_time * 2) {
    var_1 = (gettime() / 1000 - var_0) / (self.blend_in_time * 2);
    var_2 = smoothstep(0, 1, var_1);
    var_3 = smoothstep(0, 10, var_1);
    var_4 = lerp_float(0, 1, var_2);
    var_5 = lerp_float(0, 10, var_2);
    self setanimlimited(%lookat_left_right, var_4, 0.2);
    self setanimlimited(%lookat_up_down, var_4, 0.2);
    self setanimlimited(%lookat_head_base_partial, var_5, 0.2);
    self setanimlimited(%head_gesture_look_partial, var_5, 0.2);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 1.0, 0.2);
  self setanimlimited(%lookat_up_down, 1.0, 0.2);
  self setanimlimited(%lookat_head_base_partial, 10.0, 0.2);
  self setanimlimited(%head_gesture_look_partial, 10.0, 0.2);
  wait 0.05;
  self.blend_up_in_progress = undefined;
}

ai_gesture_head_updown() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self setanimlimited(%lookat_up_down, 1, self.blend_in_time);
  self setanimlimited(self.look_updown_anim, 1, self.blend_in_time);
  self setanimtime(self.look_updown_anim, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      var_1 = 0;

      if(level.player getdemeanorviewmodel() == "safe")
        var_1 = 4.62;

      var_2 = level.player getEye() + anglestoup(self.angles) * var_1;
    } else if(isai(self.gesture_lookat))
      var_2 = self.gesture_lookat getEye();
    else if(isvector(self.gesture_lookat))
      var_2 = self.gesture_lookat;
    else
      var_2 = self.gesture_lookat.origin;

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
    var_9 = float_remap(var_8, 1, -1, 0.0, 1.0);
    var_0 = var_0 + (var_9 - var_0) * self.gesture_catchup_speed * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    set_time_via_rate(self.look_updown_anim, var_0);
    waitframe();
  }
}

_ai_gesture_head_additives() {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%lookat_head_adds, 1, 0.5);

  for(;;) {
    self setanimlimited(%shipcrib_gst_head_idle_01, 0.25, 0.5);
    wait(getanimlength(%shipcrib_gst_head_idle_01) * randomfloatrange(1, 3));
  }
}

ai_gesture_eyes_leftright() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%eyes_lookat_base_partial, 10, self.eye_blend_in_time * 2);
  self setanimlimited(%facial_gesture_look_partial, 10, self.eye_blend_in_time * 2);
  self setanimlimited(%eyes_look_leftright, 1, self.eye_blend_in_time);
  self setanimlimited(self.eyes_leftright_anim, 1, self.eye_blend_in_time);
  self setanimtime(self.eyes_leftright_anim, 0.5);
  self setanimrate(self.eyes_leftright_anim, 0.0);
  var_0 = 0.0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.eyes_lookat)) {
      ai_gesture_eyes_stop(0.25);
      break;
    }

    if(isPlayer(self.eyes_lookat))
      var_1 = level.player getEye();
    else if(isai(self.eyes_lookat))
      var_1 = self.eyes_lookat getEye();
    else if(isvector(self.eyes_lookat))
      var_1 = self.eyes_lookat;
    else
      var_1 = self.eyes_lookat.origin;

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_5 = vectorNormalize(var_1 - var_3);
    var_6 = anglestoup(var_2);
    var_7 = scripts\engine\utility::flatten_vector(var_5);
    var_8 = scripts\engine\utility::flatten_vector(var_6);
    var_9 = vectordot(var_8, var_7);
    var_10 = float_remap(var_9, 1.0, -1.0, 0.0, 1.0);
    var_11 = clamp(var_10, 0, 1);
    self setanimtime(self.eyes_leftright_anim, var_11);
    waitframe();
  }
}

ai_gesture_eyes_updown() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%eyes_look_updown, 1, self.eye_blend_in_time);
  self setanimlimited(self.eyes_updown_anim, 1, self.eye_blend_in_time);
  self setanimtime(self.eyes_updown_anim, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.eyes_lookat))
      var_1 = level.player getEye();
    else if(isai(self.eyes_lookat))
      var_1 = self.eyes_lookat getEye();
    else if(isvector(self.eyes_lookat))
      var_1 = self.eyes_lookat;
    else
      var_1 = self.eyes_lookat.origin;

    var_2 = self gettagangles("j_head");
    var_3 = self gettagorigin("j_head");
    var_4 = self gettagangles("J_Spine4");
    var_5 = anglesToForward(var_2);
    var_6 = vectorNormalize(var_1 - var_3);
    var_7 = vectordot(var_5, var_6);
    var_8 = float_remap(var_7, 1.0, -1.0, 0.3, 0.7);
    var_9 = clamp(var_8, 0, 1);
    var_0 = var_0 + (var_9 - var_0) * self.eye_catchup_speed * 0.3;
    var_0 = clamp(var_0, 0.1, 0.9);
    set_time_via_rate(self.eyes_updown_anim, var_0);
    waitframe();
  }
}

ai_gesture_torso_leftright() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var_0 = undefined;
  var_1 = % torso_tracking_anims;
  var_2 = self.torso_center_anim;
  var_3 = self.torso_right_anim;
  var_4 = self.torso_left_anim;
  var_5 = self.torso_rightback_anim;
  var_6 = self.torso_leftback_anim;
  childthread _ai_torso_weight_blend_in();
  var_0 = vectortoangles(level.player.origin - self.origin);
  self setanimlimited(var_2, 1.0, 0.05);
  self setanimlimited(var_3, 0.0, 0.05);
  self setanimlimited(var_4, 0.0, 0.05);
  self setanimlimited(var_5, 0.0, 0.05);
  self setanimlimited(var_6, 0.0, 0.05);
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat))
      var_9 = level.player getEye();
    else if(isai(self.gesture_lookat))
      var_9 = self.gesture_lookat getEye();
    else if(isvector(self.gesture_lookat))
      var_9 = self.gesture_lookat;
    else
      var_9 = self.gesture_lookat.origin;

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

    if(scripts\engine\math::anglebetweenvectorssigned(var_11, var_10, var_15) > 0)
      var_20 = 0;

    self setanimlimited(var_3, var_17, 0.2);
    self setanimlimited(var_4, var_18, 0.2);
    self setanimlimited(var_2, var_16 + 0.005, 0.2);

    if(var_20) {
      var_7 = scripts\engine\math::lerp(var_7, var_19, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, 0, 0.1);
    } else {
      var_7 = scripts\engine\math::lerp(var_7, 0, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, var_19, 0.1);
    }

    self setanimlimited(var_5, var_7, 0.2);
    self setanimlimited(var_6, var_8, 0.2);
    waitframe();
  }
}

_ai_torso_weight_blend_in() {
  var_0 = gettime() / 1000;

  while(gettime() / 1000 - var_0 < self.blend_in_time) {
    var_1 = (gettime() / 1000 - var_0) / self.blend_in_time;
    var_1 = smoothstep(0, 1, var_1);
    var_2 = lerp_float(0, 1, var_1);
    self setanimlimited(%torso_tracking_anims, var_2, 0.05);
    wait 0.05;
    waittillframeend;
  }

  self setanimlimited(%torso_tracking_anims, 1.0, 0.05);
}

ai_gesture_blink_loop(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  ai_gesture_single_blink();

  for(;;) {
    wait(randomfloatrange(var_0 * 0.5, var_0));
    self clearanim(%facial_gesture_blink_1, 0.0);
    wait 0.05;
    self setanimlimited(%facial_gesture_blink_1, 1, 0.0);
    waitframe();
  }
}

ai_gesture_single_blink() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(self)) {
    return;
  }
  self setanimlimited(%eyes_blink, 1, 0.0);
  self clearanim(%facial_gesture_blink_1, 0.0);
  wait 0.05;
  self setanimlimited(%facial_gesture_blink_1, 1, 0.0);
}

ai_gesture_point(var_0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self.point_center_anim = undefined;
  self.point_left_anim = undefined;
  self.point_right_anim = undefined;
  self.point_up_anim = undefined;
  self.point_down_anim = undefined;
  self.no_point_defined = 0;
  self._blackboard.point_gesture_active = 1;
  var_1 = scripts\asm\asm::asm_getdemeanor();
  var_2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  scripts\asm\asm_sp::asm_setupgesture(self.asmname, var_2);

  if(var_1 != "casual" && var_1 != "casual_gun")
    self.gesture_point_parent = % gesture_partials;
  else
    self.gesture_point_parent = % point_at_without_head;

  if(!scripts\asm\asm::asm_currentstatehasflag(self.asmname, "gesture"))
    return;
  else if(var_1 == "casual" || var_1 == "combat" || var_1 == "casual_gun" || var_1 == "frantic") {
    self.point_center_anim = self.asm.gestures.gesture_point_center;
    self.point_left_anim = self.asm.gestures.gesture_point_left;
    self.point_right_anim = self.asm.gestures.gesture_point_right;
    self.point_up_anim = self.asm.gestures.gesture_point_up;
    self.point_down_anim = self.asm.gestures.gesture_point_down;
    self.gesture_body_knob = scripts\asm\asm::asm_getbodyknob();
  } else
    return;

  if(isPlayer(var_0))
    var_3 = level.player getEye();
  else if(!isDefined(var_0)) {
    var_3 = self.origin;
    self.no_point_defined = 1;
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
  var_14 = clamp(float_remap(var_12, 0.2, 1.0, 0, 1), 0, 1);
  var_15 = clamp(float_remap(var_13, 0.2, 1, 0, 1), 0, 1);
  var_16 = self gettagorigin("J_Spine4");
  var_17 = vectorNormalize(var_3 - var_16);
  var_18 = anglesToForward(var_4);
  var_19 = vectordot(var_17, var_18);
  var_20 = var_19 * -1.0;
  var_21 = vectordot(var_7, var_17);
  var_22 = clamp(float_remap(var_21, 0.2, 1, 0, 1), 0, 1);
  var_23 = clamp(float_remap(var_19, 0.2, 1, 0, 1), 0, 1);
  var_24 = clamp(float_remap(var_20, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(var_21 < -0.9)
      ai_gesture_simple("fallback_up");
    else {
      if(var_1 != "casual" && var_1 != "casual_gun")
        self setanimlimited(self.gesture_point_parent, 10.0, 0.25);
      else
        self setanimlimited(self.gesture_point_parent, 1.0, 0.25);

      if(var_22 < 0.3)
        self setanimlimited(self.point_center_anim, 0, 0, 0.85);
      else
        self setanimlimited(self.point_center_anim, var_22, 0.25, 0.85);

      if(isDefined(self.point_up_anim))
        self setanimlimited(self.point_up_anim, var_23, 0.25, 0.85);

      if(isDefined(self.point_down_anim))
        self setanimlimited(self.point_down_anim, var_24, 0.2, 0.85);

      self setanimlimited(self.point_left_anim, var_15, 0.25, 0.85);
      self setanimlimited(self.point_right_anim, var_14, 0.25, 0.85);
    }
  } else {
    if(var_1 != "casual" && var_1 != "casual_gun")
      self setanimlimited(self.gesture_point_parent, 10.0, 0.2);
    else
      self setanimlimited(self.gesture_point_parent, 1.0, 0.2);

    self setanimlimited(self.point_center_anim, 1, 0.2, 0.85);
  }

  var_25 = getanimlength(%prototype_gesture_point_center) * 0.85;
  wait(var_25);
  self clearanim(self.gesture_point_parent, 0.25);
  self setanimlimited(self.gesture_body_knob, 1.0, 0.25);
  self._blackboard.point_gesture_active = 0;
}

ai_gesture_simple(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.point_center_anim = undefined;
  self.gesture_body_knob = undefined;
  self.is_partial = 0;
  var_1 = "casual";
  var_2 = undefined;

  if(isai(self)) {
    self._blackboard.gesture_active = 1;
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
  if(isai(self) && !scripts\asm\asm::asm_currentstatehasflag(self.asmname, "gesture"))
    return;
  else if(isai(self)) {
    self.gesture_body_knob = scripts\asm\asm::asm_getbodyknob();

    if(var_1 == "casual") {
      if(scripts\engine\utility::array_contains(var_3, var_0)) {
        self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
        self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
        self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
        self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
        self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
        self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
      } else
        return;
    } else if(var_1 == "casual_gun") {
      if(scripts\engine\utility::array_contains(var_6, var_0)) {
        self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
        self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
        self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
        self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
        self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
        self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else
        return;
    } else if(var_1 == "combat") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else
        return;
    } else if(var_1 == "cqb") {
      if(scripts\engine\utility::array_contains(var_5, var_0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else
        return;
    } else if(var_1 == "frantic") {
      if(scripts\engine\utility::array_contains(var_4, var_0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else
        return;
    } else
      return;
  } else {
    self.gesture_shrug_anim = % shipcrib_gst_body_shrug_01;
    self.gesture_cross_anim = % shipcrib_gst_body_cross_01;
    self.gesture_nod_anim = % shipcrib_gst_head_nod_01;
    self.gesture_salute_anim = % shipcrib_gst_head_salute_01;
    self.gesture_wave_anim = % shipcrib_gst_body_wave_01;
    self.gesture_wait_anim = % shipcrib_gst_body_wait_01;
    self.gesture_fallback_up_anim = % hm_grnd_org_gest_fallback_up;
  }

  var_7 = undefined;

  switch (var_0) {
    case "shrug":
      var_7 = self.gesture_shrug_anim;
      break;
    case "cross":
      var_7 = self.gesture_cross_anim;
      break;
    case "nod":
      var_7 = self.gesture_nod_anim;
      break;
    case "salute":
      var_7 = self.gesture_salute_anim;
      break;
    case "wave":
      var_7 = self.gesture_wave_anim;
      break;
    case "wait":
      var_7 = self.gesture_wait_anim;
      break;
    case "hold":
      self.is_partial = 1;
      var_7 = self.gesture_hold_anim;
      break;
    case "on_me":
      self.is_partial = 1;
      var_7 = self.gesture_onme_anim;
      break;
    case "move_up":
      self.is_partial = 1;
      var_7 = self.gesture_moveup_anim;
      break;
    case "fallback_up":
      self.is_partial = 1;
      var_7 = self.gesture_fallback_up_anim;
      break;
    case "fallback_down":
      self.is_partial = 1;
      var_7 = self.gesture_fallback_down_anim;
      break;
    case "arm_up":
      self.is_partial = 1;
      var_7 = self.gesture_armup_anim;
      break;
  }

  if(self.is_partial)
    self.simple_gesture_parent = % gesture_partials;
  else
    self.simple_gesture_parent = % add_gesture;

  if(self.is_partial)
    thread blend_partial_in(self.simple_gesture_parent, var_7, 0.5);
  else {
    self setanimlimited(self.simple_gesture_parent, 1.0, 0.5);
    self setanimlimited(var_7, 1.0, 0.5, 0.75);
  }

  var_8 = getanimlength(var_7) * 0.85;
  wait(var_8);

  if(self.is_partial)
    thread blend_partial_out(self.simple_gesture_parent, var_7, 0.5);
  else {
    self clearanim(self.simple_gesture_parent, 0.5);
    self clearanim(var_7, 0.5);
  }

  self.is_partial = 0;

  if(isai(self))
    self._blackboard.gesture_active = undefined;
}

blend_partial_in(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * 0.5;
  self setanimlimited(var_0, 1.0, var_4);
  self setanimlimited(var_1, 1.0, var_4, 0.75);
  wait(var_2 * 0.5);
  self setanimlimited(var_1, 10.0, var_4, 0.75);
  self setanimlimited(var_0, 10.0, var_4);
}

blend_partial_out(var_0, var_1, var_2) {
  var_3 = var_2 * 0.5;
  self setanimlimited(var_0, 1.0, var_3);
  self setanimlimited(var_1, 1.0, var_3);
  wait(var_3);
  self clearanim(var_0, var_3);
  self clearanim(var_1, var_3);
}

float_remap(var_0, var_1, var_2, var_3, var_4) {
  return (var_0 - var_1) / (var_2 - var_1) * (var_4 - var_3) + var_3;
}

lerp_float(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

smoothstep(var_0, var_1, var_2) {
  var_2 = clamp((var_2 - var_0) / (var_1 - var_0), 0.0, 1.0);
  return var_2 * var_2 * (3 - 2 * var_2);
}

set_time_via_rate(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.25;

  var_4 = self getanimtime(var_0);
  var_5 = getanimlength(var_0);
  var_6 = (var_1 - var_4) * var_5 / 0.05;

  if(self.unittype == "c6")
    use_c6_animtree();

  self setanimlimited(var_0, var_2, var_3, var_6);
}

ai_gesture_directional_custom(var_0, var_1, var_2) {
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
  self.no_point_defined = 0;
  var_11 = undefined;

  if(isDefined(var_2)) {
    var_10 = scripts\asm\asm::asm_getbodyknob();
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
  var_23 = clamp(float_remap(var_21, 0.2, 1.0, 0, 1), 0, 1);
  var_24 = clamp(float_remap(var_22, 0.2, 1, 0, 1), 0, 1);
  var_25 = self gettagorigin("J_Spine4");
  var_26 = vectorNormalize(var_12 - var_25);
  var_27 = anglestoup(var_13);
  var_28 = vectordot(var_26, var_27);
  var_29 = var_28 * -1.0;
  var_30 = vectordot(var_19, var_26);
  var_31 = clamp(float_remap(var_30, 0.2, 1, 0, 1), 0, 1);
  var_32 = clamp(float_remap(var_28, 0.2, 1, 0, 1), 0, 1);
  var_33 = clamp(float_remap(var_29, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(isDefined(var_2))
      self setanimlimited(var_11, 10.0, 0.25);
    else
      self setanimlimited(var_11, 1.0, 0.25);

    if(var_31 < 0.3)
      self setanimlimited(var_4, 0, 0, 1);
    else
      self setanimlimited(var_4, var_31, 0.25, 1);

    if(isDefined(var_7))
      self setanimlimited(var_7, var_32, 0.25, 1);

    if(isDefined(var_8))
      self setanimlimited(var_8, var_33, 0.25, 1);

    self setanimlimited(var_5, var_24, 0.25, 1);
    self setanimlimited(var_6, var_23, 0.25, 1);
  } else {
    if(isDefined(var_2))
      self setanimlimited(var_10, 0.001, 0.1);

    self setanimlimited(var_11, 1.0, 0.25);
    self setanimlimited(var_4, 1, 0.25);
  }

  var_34 = getanimlength(var_4);
  wait(var_34);
  self clearanim(var_11, 0.25);
  self setanimlimited(var_10, 1.0, 0.25);
}

ai_custom_gesture(var_0, var_1) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  var_2 = % add_gesture;
  var_3 = 0;
  var_4 = "single anim";
  thread scripts\common\notetrack::start_notetrack_wait(self, var_4, undefined, undefined, var_0);

  if(isDefined(var_1) && var_1) {
    var_2 = % gesture_partials;
    var_3 = 1;
  }

  if(var_3)
    thread blend_partial_in(var_2, var_0, 0.2);
  else {
    self setanimlimited(var_2, 1.0, 0.1);
    self setanimlimited(var_0, 1.0, 0.1);
  }

  var_5 = getanimlength(var_0) * 0.75 - 0.2;
  wait(var_5);

  if(var_3)
    thread blend_partial_out(var_2, var_0, 0.2);
  else {
    self clearanim(var_2, 0.2);
    self clearanim(var_0, 0.2);
  }
}

#using_animtree("c6");

use_c6_animtree() {
  self.look_leftright_anim = % prototype_gesture_look_rightleft;
  self.look_updown_anim = % prototype_gesture_look_updwn;
}

ai_gesture_head_leftright_c6() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var_0 = self.blend_in_time;
  var_1 = gettime() / 1000;

  while(gettime() / 1000 - var_1 < var_0) {
    var_2 = (gettime() / 1000 - var_1) / var_0;
    var_2 = smoothstep(0, 1, var_2);
    var_3 = lerp_float(0, 1, var_2);
    var_4 = lerp_float(0, 1, var_2);
    var_5 = lerp_float(0, 5, var_2);
    var_6 = lerp_float(0, 5, var_2);
    self setanimlimited(%lookat_left_right, var_3, 0.05);
    self setanimlimited(self.look_leftright_anim, var_4, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_5, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_6, 0.05);
    self setanimtime(self.look_leftright_anim, 0.5);
    wait 0.05;
    waittillframeend;
  }

  self setanimlimited(%lookat_left_right, 1, 0.05);
  self setanimlimited(self.look_leftright_anim, 1, 0.05);
  self setanimlimited(%lookat_head_base_partial, 5, 0.05);
  self setanimlimited(%head_gesture_look_partial, 5, 0.05);
  var_7 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat))
      var_8 = level.player getEye();
    else if(isai(self.gesture_lookat))
      var_8 = self.gesture_lookat getEye();
    else if(isvector(self.gesture_lookat))
      var_8 = self.gesture_lookat;
    else
      var_8 = self.gesture_lookat.origin;

    var_9 = self gettagangles("J_Head");
    var_10 = self gettagorigin("J_Head");
    var_11 = self gettagangles("J_Spine4") + (0, 90, 0);
    var_12 = self gettagorigin("J_Spine4");
    var_13 = vectorNormalize(var_8 - var_12);
    var_14 = anglestoright(var_11);
    var_15 = scripts\engine\utility::flatten_vector(var_14);
    var_16 = scripts\engine\utility::flatten_vector(var_13);
    var_17 = vectordot(var_15, var_16);
    var_18 = float_remap(var_17, -1.0, 1.0, 0.0, 1.0);
    var_18 = clamp(var_18, 0.0, 1.0);
    var_7 = var_7 + (var_18 - var_7) * self.gesture_catchup_speed;
    var_7 = clamp(var_7, 0.1, 0.9);
    set_time_via_rate(self.look_leftright_anim, var_7, 1);
    waitframe();
  }
}

ai_gesture_head_updown_c6() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self setanimlimited(%lookat_up_down, 1, self.blend_in_time);
  self setanimlimited(self.look_updown_anim, 1, self.blend_in_time);
  self setanimtime(self.look_updown_anim, 0.5);
  var_0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat))
      var_1 = level.player getEye();
    else if(isai(self.gesture_lookat))
      var_1 = self.gesture_lookat getEye();
    else if(isvector(self.gesture_lookat))
      var_1 = self.gesture_lookat;
    else
      var_1 = self.gesture_lookat.origin;

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
    var_8 = float_remap(var_7, 1, -1, 0.0, 1.0);
    var_0 = var_0 + (var_8 - var_0) * self.gesture_catchup_speed * 0.3;
    var_0 = clamp(var_0, 0.1, 0.65);
    set_time_via_rate(self.look_updown_anim, var_0);
    waitframe();
  }
}

ai_gesture_stop_c6(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("gesture_stop");

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 0.25;

  self setanimlimited(%lookat_left_right, 1.0, var_1 * 0.15);
  self setanimlimited(%lookat_up_down, 1.0, var_1 * 0.15);
  self setanimlimited(%lookat_head_base_partial, 1.0, var_1 * 0.15);
  self setanimlimited(%head_gesture_look_partial, 1.0, var_1 * 0.15);
  wait(var_1 * 0.15);
  self clearanim(%lookat_left_right, var_1 * 0.85);
  self clearanim(%lookat_up_down, var_1 * 0.85);
  self clearanim(%lookat_head_base_partial, var_1 * 0.85);
  self clearanim(%head_gesture_look_partial, var_1 * 0.85);
  self.is_head_tracking = undefined;
}

#using_animtree("generic_human");

blended_loop_anim() {
  var_0 = self;
  self endon(self.ender);
  var_0.fwd_anim = undefined;
  var_0.right_anim = undefined;
  var_0.left_anim = undefined;
  var_0.leftback_anim = undefined;
  var_0.rightback_anim = undefined;

  foreach(var_2 in var_0.anim_array) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.fwd_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.right_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.left_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.leftback_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.rightback_anim = level.scr_anim[var_0.animname][var_2];
    }
  }

  var_4 = getstartorigin(self.animnode.origin, self.animnode.angles, var_0.fwd_anim);
  var_5 = getstartangles(self.animnode.origin, self.animnode.angles, var_0.fwd_anim);

  if(isai(var_0))
    var_0 forceteleport(var_4, var_5, 10000);
  else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 setanimknoball(var_0.fwd_anim, %root, 1.0, 0.2);

  if(isDefined(var_0.right_anim))
    var_0 setanimlimited(var_0.right_anim, 0.0, 0.2);

  if(isDefined(var_0.left_anim))
    var_0 setanimlimited(var_0.left_anim, 0.0, 0.2);

  if(isDefined(var_0.leftback_anim))
    var_0 setanimlimited(var_0.leftback_anim, 0.0, 0.2);

  if(isDefined(var_0.rightback_anim))
    var_0 setanimlimited(var_0.rightback_anim, 0.0, 0.2);

  var_7 = 0;
  var_8 = 0;
  var_0 pushplayer(1);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0.gesture_lookat))
      var_9 = level.player getEye();
    else if(isai(var_0.gesture_lookat))
      var_9 = var_0.gesture_lookat getEye();
    else if(isvector(var_0.gesture_lookat))
      var_9 = var_0.gesture_lookat;
    else
      var_9 = var_0.gesture_lookat.origin;

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

    if(scripts\engine\math::anglebetweenvectorssigned(var_13, var_12, var_17) > 0)
      var_22 = 0;

    if(isDefined(var_0.right_anim))
      var_0 setanimlimited(var_0.right_anim, var_19, 0.2);

    if(isDefined(var_0.left_anim))
      var_0 setanimlimited(var_0.left_anim, var_20, 0.2);

    var_0 setanimlimited(var_0.fwd_anim, var_18 + 0.005, 0.2);

    if(var_22) {
      var_7 = scripts\engine\math::lerp(var_7, var_21, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, 0, 0.1);
    } else {
      var_7 = scripts\engine\math::lerp(var_7, 0, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, var_21, 0.1);
    }

    if(isDefined(var_0.rightback_anim))
      var_0 setanimlimited(var_0.rightback_anim, var_7 + 0.005, 0.2);

    if(isDefined(var_0.leftback_anim))
      var_0 setanimlimited(var_0.leftback_anim, var_8 + 0.005, 0.2);

    waitframe();
    waittillframeend;
  }
}

blended_loop_cleanup() {
  var_0 = self;

  if(isDefined(var_0.ender))
    var_0 notify(var_0.ender);

  var_0 clearanim(var_0.fwd_anim, 0.2);

  if(isDefined(var_0.right_anim))
    var_0 clearanim(var_0.right_anim, 0.2);

  if(isDefined(var_0.left_anim))
    var_0 clearanim(var_0.left_anim, 0.2);

  if(isDefined(var_0.leftback_anim))
    var_0 clearanim(var_0.leftback_anim, 0.2);

  if(isDefined(var_0.rightback_anim))
    var_0 clearanim(var_0.rightback_anim, 0.2);

  var_0 pushplayer(0);
  var_0.fwd_anim = undefined;
  var_0.right_anim = undefined;
  var_0.left_anim = undefined;
  var_0.leftback_anim = undefined;
  var_0.rightback_anim = undefined;
  var_0.anim_array = undefined;
  var_0.ender = undefined;
  var_0.gesture_lookat = undefined;
}

blended_anim() {
  var_0 = self;
  var_0.fwd_anim = undefined;
  var_0.right_anim = undefined;
  var_0.left_anim = undefined;
  var_0.leftback_anim = undefined;
  var_0.rightback_anim = undefined;

  foreach(var_2 in var_0.anim_array) {
    if(issubstr(var_2, "forward")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.fwd_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "right") && !issubstr(var_2, "back")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.right_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "left") && !issubstr(var_2, "back")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.left_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "leftback")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.leftback_anim = level.scr_anim[var_0.animname][var_2];

      continue;
    }

    if(issubstr(var_2, "rightback")) {
      if(isDefined(level.scr_anim[var_0.animname][var_2]))
        var_0.rightback_anim = level.scr_anim[var_0.animname][var_2];
    }
  }

  var_4 = getstartorigin(self.animnode.origin, self.animnode.angles, var_0.fwd_anim);
  var_5 = getstartangles(self.animnode.origin, self.animnode.angles, var_0.fwd_anim);

  if(isai(var_0))
    var_0 forceteleport(var_4, var_5, 10000);
  else {
    var_0.origin = var_4;
    var_0.angles = var_5;
  }

  var_6 = vectortoangles(level.player.origin - var_0.origin);
  var_0 setanimknoball(var_0.fwd_anim, %root, 1.0, 0.2);

  if(isDefined(var_0.right_anim))
    var_0 setanimlimited(var_0.right_anim, 0.0, 0.2);

  if(isDefined(var_0.left_anim))
    var_0 setanimlimited(var_0.left_anim, 0.0, 0.2);

  if(isDefined(var_0.leftback_anim))
    var_0 setanimlimited(var_0.leftback_anim, 0.0, 0.2);

  if(isDefined(var_0.rightback_anim))
    var_0 setanimlimited(var_0.rightback_anim, 0.0, 0.2);

  var_7 = 0;
  var_8 = 0;
  var_9 = gettime() / 1000;
  var_10 = getanimlength(var_0.fwd_anim);

  while(gettime() / 1000 - var_9 < var_10) {
    if(!isDefined(var_0)) {
      break;
    }

    if(isPlayer(var_0.gesture_lookat))
      var_11 = level.player getEye();
    else if(isai(var_0.gesture_lookat))
      var_11 = var_0.gesture_lookat getEye();
    else if(isvector(var_0.gesture_lookat))
      var_11 = var_0.gesture_lookat;
    else
      var_11 = var_0.gesture_lookat.origin;

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

    if(scripts\engine\math::anglebetweenvectorssigned(var_15, var_14, var_19) > 0)
      var_24 = 0;

    if(isDefined(var_0.right_anim))
      var_0 setanimlimited(var_0.right_anim, var_21, 0.2);

    if(isDefined(var_0.left_anim))
      var_0 setanimlimited(var_0.left_anim, var_22, 0.2);

    var_0 setanimlimited(var_0.fwd_anim, var_20 + 0.005, 0.2);

    if(var_24) {
      var_7 = scripts\engine\math::lerp(var_7, var_23, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, 0, 0.1);
    } else {
      var_7 = scripts\engine\math::lerp(var_7, 0, 0.1);
      var_8 = scripts\engine\math::lerp(var_8, var_23, 0.1);
    }

    if(isDefined(var_0.rightback_anim))
      var_0 setanimlimited(var_0.rightback_anim, var_7 + 0.005, 0.2);

    if(isDefined(var_0.leftback_anim))
      var_0 setanimlimited(var_0.leftback_anim, var_8 + 0.005, 0.2);

    waitframe();
    waittillframeend;
  }

  var_0 thread blended_loop_cleanup();
}