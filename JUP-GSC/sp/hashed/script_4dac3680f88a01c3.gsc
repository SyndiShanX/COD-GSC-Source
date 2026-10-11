/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4dac3680f88a01c3.gsc
*************************************************/

#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\gesture\script_funcs;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_6bc879d2947c65d2;
#using_animtree("generic_human");

function ai_gesture_stop(blendout_time) {
  self notify("new_gesture_stop_begin");
  self notify("gesture_stop");
  self endon("death");
  self endon("start_gesture_lookat");
  self endon("new_gesture_stop_begin");
  self endon("entitydeleted");

  if(isDefined(self.anim_getrootfunc) && isDefined(self.old_root)) {
    reset_root();
  }

  if(isDefined(self.anim_getrootfunc) && !isDefined(self.old_root)) {
    self.anim_getrootfunc = undefined;
  }

  if(isDefined(blendout_time)) {
    blend_time = blendout_time;
  } else {
    blend_time = 0.25;
  }

  if(!isDefined(self.is_head_tracking)) {
    return;
  }

  start_time = gettime() / 1000;
  var_cc7d64b564852548 = self getanimweight(self.head_center_anim);
  var_920f5e7265d0d6d3 = self getanimweight(self.head_right_anim);
  var_ea4fd9d5698bb0de = self getanimweight(self.head_left_anim);
  var_8a36695ea482743 = self getanimweight(self.head_rightback_anim);
  var_d94ccc571e35ad74 = self getanimweight(self.head_leftback_anim);
  var_f67c766809ec9eb1 = self getanimweight(%lookat_left_right);
  var_ff2b0adc7f8ab11 = self getanimweight(%lookat_up_down);
  var_7261fa6f5015c297 = self getanimweight(%lookat_head_base_partial);
  var_bff9b1c691b8b590 = self getanimweight(%head_gesture_look_partial);
  var_f7a05d8d154d1fca = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - start_time < blendout_time) {
    norm_val = (gettime() / 1000 - start_time) / blendout_time;
    norm_val = smoothstep(0, 1, norm_val);
    var_8eda33d84e23a48e = lerp_float(var_cc7d64b564852548, 1, norm_val);
    var_75a6f0398c7ce571 = lerp_float(var_920f5e7265d0d6d3, 0, norm_val);
    var_a36adbca83488924 = lerp_float(var_ea4fd9d5698bb0de, 0, norm_val);
    var_3b07618ff6abc8c9 = lerp_float(var_8a36695ea482743, 0, norm_val);
    var_ac8aa45eb885e4f2 = lerp_float(var_d94ccc571e35ad74, 0, norm_val);
    var_f68167872853c4c7 = lerp_float(var_f67c766809ec9eb1, 0, norm_val);
    var_6f9061194bec6ea3 = lerp_float(var_ff2b0adc7f8ab11, 0, norm_val);
    var_accf346b44a25cfd = lerp_float(var_7261fa6f5015c297, 0, norm_val);
    var_cdaf7985c83b0386 = lerp_float(var_bff9b1c691b8b590, 0, norm_val);
    var_5948b4c152818c80 = lerp_float(var_f7a05d8d154d1fca, 0, norm_val);
    self setanimlimited(self.head_center_anim, var_8eda33d84e23a48e, 0.05);
    self setanimlimited(self.head_right_anim, var_75a6f0398c7ce571, 0.05);
    self setanimlimited(self.head_left_anim, var_a36adbca83488924, 0.05);
    self setanimlimited(self.head_rightback_anim, var_3b07618ff6abc8c9, 0.05);
    self setanimlimited(self.head_leftback_anim, var_ac8aa45eb885e4f2, 0.05);
    self setanimlimited(%lookat_left_right, var_f68167872853c4c7, 0.05);
    self setanimlimited(%lookat_up_down, var_6f9061194bec6ea3, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_accf346b44a25cfd, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_cdaf7985c83b0386, 0.05);
    self setanimlimited(%lookat_head_adds, var_5948b4c152818c80, 0.05);
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

function ai_gesture_eyes_stop(blendout_time) {
  self endon("death");
  self endon("entitydeleted");
  self notify("eye_gesture_stop");

  if(isDefined(blendout_time)) {
    blend_time = blendout_time;
  } else {
    blend_time = 0.25;
  }

  self clearanim(%eyes_look_leftright, blend_time);
  self clearanim(%eyes_look_updown, blend_time);
  self clearanim(%eyes_lookat_base_partial, blend_time);
  self clearanim(%facial_gesture_look_partial, blend_time);
  self clearanim(%eyes_blink_base_partial, blend_time);
  self clearanim(%facial_gesture_blink_partial, blend_time);
  self clearanim(%eyes_blink, blend_time);
  self.is_eye_tracking = undefined;
}

function ai_gesture_lookat_weight_down(blend_time) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");

  if(isDefined(self.blend_down_in_progress)) {
    return;
  }

  blendout_time = blend_time;
  self.blend_down_in_progress = 1;
  self.blend_up_in_progress = undefined;
  start_time = gettime() / 1000;
  var_f67c766809ec9eb1 = self getanimweight(%lookat_left_right);
  var_ff2b0adc7f8ab11 = self getanimweight(%lookat_up_down);
  var_7261fa6f5015c297 = self getanimweight(%lookat_head_base_partial);
  var_bff9b1c691b8b590 = self getanimweight(%head_gesture_look_partial);
  var_f7a05d8d154d1fca = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - start_time < blendout_time) {
    norm_val = (gettime() / 1000 - start_time) / blendout_time;
    norm_val = smoothstep(0, 1, norm_val);
    var_f68167872853c4c7 = lerp_float(var_f67c766809ec9eb1, 0, norm_val);
    var_6f9061194bec6ea3 = lerp_float(var_ff2b0adc7f8ab11, 0, norm_val);
    var_accf346b44a25cfd = lerp_float(var_7261fa6f5015c297, 0, norm_val);
    var_cdaf7985c83b0386 = lerp_float(var_bff9b1c691b8b590, 0, norm_val);
    var_5948b4c152818c80 = lerp_float(var_f7a05d8d154d1fca, 0, norm_val);
    self setanimlimited(%lookat_left_right, var_f68167872853c4c7, 0.05);
    self setanimlimited(%lookat_up_down, var_6f9061194bec6ea3, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_accf346b44a25cfd, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_cdaf7985c83b0386, 0.05);
    self setanimlimited(%lookat_head_adds, var_5948b4c152818c80, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 0, 0.05);
  self setanimlimited(%lookat_up_down, 0, 0.05);
  self setanimlimited(%lookat_head_base_partial, 0, 0.05);
  self setanimlimited(%head_gesture_look_partial, 0, 0.05);
  self setanimlimited(%lookat_head_adds, 0, 0.05);
  self.blend_down_in_progress = undefined;
}

function ai_gesture_lookat_weight_up(blend_time) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");

  if(isDefined(self.blend_up_in_progress)) {
    return;
  }

  blendout_time = blend_time;
  self.blend_up_in_progress = 1;
  self.blend_down_in_progress = undefined;
  start_time = gettime() / 1000;
  var_f67c766809ec9eb1 = self getanimweight(%lookat_left_right);
  var_ff2b0adc7f8ab11 = self getanimweight(%lookat_up_down);
  var_7261fa6f5015c297 = self getanimweight(%lookat_head_base_partial);
  var_bff9b1c691b8b590 = self getanimweight(%head_gesture_look_partial);
  var_f7a05d8d154d1fca = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - start_time < blendout_time) {
    norm_val = (gettime() / 1000 - start_time) / blendout_time;
    norm_val = smoothstep(0, 1, norm_val);
    var_f68167872853c4c7 = lerp_float(var_f67c766809ec9eb1, 1, norm_val);
    var_6f9061194bec6ea3 = lerp_float(var_ff2b0adc7f8ab11, 1, norm_val);
    var_accf346b44a25cfd = lerp_float(var_7261fa6f5015c297, 10, norm_val);
    var_cdaf7985c83b0386 = lerp_float(var_bff9b1c691b8b590, 10, norm_val);
    var_5948b4c152818c80 = lerp_float(var_f7a05d8d154d1fca, 0, norm_val);
    self setanimlimited(%lookat_left_right, var_f68167872853c4c7, 0.05);
    self setanimlimited(%lookat_up_down, var_6f9061194bec6ea3, 0.05);
    self setanimlimited(%lookat_head_base_partial, var_accf346b44a25cfd, 0.05);
    self setanimlimited(%head_gesture_look_partial, var_cdaf7985c83b0386, 0.05);
    self setanimlimited(%lookat_head_adds, var_5948b4c152818c80, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 1, 0.05);
  self setanimlimited(%lookat_up_down, 1, 0.05);
  self setanimlimited(%lookat_head_base_partial, 10, 0.05);
  self setanimlimited(%head_gesture_look_partial, 10, 0.05);
  self setanimlimited(%lookat_head_adds, 1, 0.05);
  self.blend_up_in_progress = undefined;
}

function ai_gesture_torso_stop(blendout_time) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");

  if(!isDefined(self.is_torso_tracking)) {
    return;
  }

  if(isDefined(blendout_time)) {
    blend_time = blendout_time;
  } else {
    blend_time = 0.25;
  }

  start_time = gettime() / 1000;
  var_cc7d64b564852548 = self getanimweight(self.torso_center_anim);
  var_920f5e7265d0d6d3 = self getanimweight(self.torso_right_anim);
  var_ea4fd9d5698bb0de = self getanimweight(self.torso_left_anim);
  var_8a36695ea482743 = self getanimweight(self.torso_rightback_anim);
  var_d94ccc571e35ad74 = self getanimweight(self.torso_leftback_anim);

  while(gettime() / 1000 - start_time < blendout_time) {
    norm_val = (gettime() / 1000 - start_time) / blendout_time;
    norm_val = smoothstep(0, 1, norm_val);
    var_8eda33d84e23a48e = lerp_float(var_cc7d64b564852548, 1, norm_val);
    var_75a6f0398c7ce571 = lerp_float(var_920f5e7265d0d6d3, 0, norm_val);
    var_a36adbca83488924 = lerp_float(var_ea4fd9d5698bb0de, 0, norm_val);
    var_3b07618ff6abc8c9 = lerp_float(var_8a36695ea482743, 0, norm_val);
    var_ac8aa45eb885e4f2 = lerp_float(var_d94ccc571e35ad74, 0, norm_val);
    self setanimlimited(self.torso_center_anim, var_8eda33d84e23a48e, 0.05);
    self setanimlimited(self.torso_right_anim, var_75a6f0398c7ce571, 0.05);
    self setanimlimited(self.torso_left_anim, var_a36adbca83488924, 0.05);
    self setanimlimited(self.torso_rightback_anim, var_3b07618ff6abc8c9, 0.05);
    self setanimlimited(self.torso_leftback_anim, var_ac8aa45eb885e4f2, 0.05);
    wait 0.05;
  }

  self setanimlimited(self.torso_center_anim, 1, 0.05);
  self setanimlimited(self.torso_right_anim, 0, 0.05);
  self setanimlimited(self.torso_left_anim, 0, 0.05);
  self setanimlimited(self.torso_rightback_anim, 0, 0.05);
  self setanimlimited(self.torso_leftback_anim, 0, 0.05);
  self clearanim(%torso_tracking_anims, blendout_time);
  self.is_torso_tracking = undefined;
}

function ai_gesture_lookat(lookat_target, catchup_speed, blend_in_time) {
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

  if(isai(self)) {
    state = asm_getcurrentstate(self.asmname);
  } else {
    state = undefined;
  }

  if(isDefined(self.anim_getrootfunc)) {
    store_old_root();
  }

  if(!isDefined(self.anim_getrootfunc)) {
    self.anim_getrootfunc = &set_root;
  }

  if(isDefined(blend_in_time)) {
    self.blend_in_time = blend_in_time;
  } else {
    self.blend_in_time = 0.7;
  }

  self.look_leftright_anim = undefined;
  self.look_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(catchup_speed)) {
    self.gesture_catchup_speed = clamp(catchup_speed, 0.25, 4);
  } else {
    self.gesture_catchup_speed = 0.5;
  }

  self.look_leftright_anim = % prototype_gesture_look_rightleft;
  self.look_updown_anim = % prototype_gesture_look_updwn;
  self.head_center_anim = % gesture_head_fwd;
  self.head_right_anim = % gesture_head_right;
  self.head_left_anim = % gesture_head_left;
  self.head_rightback_anim = % gesture_head_rightback;
  self.head_leftback_anim = % gesture_head_leftback;
  self.gesture_lookat = lookat_target;
  thread ai_gesture_head_leftright();
  thread ai_gesture_head_updown();
  self.is_head_tracking = 1;
}

function ai_gesture_eyes_lookat(lookat_target, catchup_speed, blend_in_time) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self.is_eye_tracking)) {
    ai_gesture_eyes_stop(0.25);
    wait 0.25;
  }

  if(isDefined(self.anim_getrootfunc)) {
    store_old_root();
  }

  if(!isDefined(self.anim_getrootfunc)) {
    self.anim_getrootfunc = &set_root;
  }

  if(isDefined(blend_in_time)) {
    self.eye_blend_in_time = blend_in_time;
  } else {
    self.eye_blend_in_time = 0.3;
  }

  self.eyes_leftright_anim = undefined;
  self.eyes_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(catchup_speed)) {
    self.eye_catchup_speed = clamp(catchup_speed, 0.25, 4);
  } else {
    self.eye_catchup_speed = 2;
  }

  self.eyes_leftright_anim = % facial_gesture_look_rightleft;
  self.eyes_updown_anim = % facial_gesture_look_updwn;
  self.eyes_lookat = lookat_target;
  thread ai_gesture_eyes_leftright();
  thread ai_gesture_eyes_updown();
  self.is_eye_tracking = 1;
}

function ai_gesture_lookat_torso(lookat_target, blend_in_time) {
  self endon("death");
  self endon("entitydeleted");
  self notify("start_gesture_torso_lookat");

  if(isai(self)) {
    state = asm_getcurrentstate(self.asmname);
  } else {
    state = undefined;
  }

  if(!isDefined(state)) {
    return;
  }

  if(isDefined(self.is_torso_tracking)) {
    ai_gesture_torso_stop(0.25);
    wait 0.25;
  }

  if(isDefined(blend_in_time)) {
    self.blend_in_time = blend_in_time;
  } else {
    self.blend_in_time = 0.7;
  }

  self.torso_leftright_anim = undefined;
  self.lookat_aquired = 0;
  self.torso_center_anim = % hm_grnd_grn_casual_stand_center_idle;
  self.torso_left_anim = % hm_grnd_grn_casual_stand_left_idle;
  self.torso_leftback_anim = % hm_grnd_grn_casual_stand_leftback_idle;
  self.torso_right_anim = % hm_grnd_grn_casual_stand_right_idle;
  self.torso_rightback_anim = % hm_grnd_grn_casual_stand_rightback_idle;
  self.gesture_lookat = lookat_target;
  thread ai_gesture_torso_leftright();
  self.is_torso_tracking = 1;
}

function set_root() {
  return % body;
}

function store_old_root() {
  self.old_root = self.anim_getrootfunc;
}

function reset_root() {
  self.anim_getrootfunc = self.old_root;
}

function ai_gesture_update_lookat(new_lookat, var_809d5bbb11b6031c) {
  self endon("death");
  self endon("entitydeleted");
  self.gesture_lookat = new_lookat;
  self.is_head_tracking = 1;

  if(isDefined(var_809d5bbb11b6031c)) {
    var_37015ada8160570c = self.gesture_catchup_speed;
    self.gesture_catchup_speed = var_809d5bbb11b6031c;
    wait var_809d5bbb11b6031c * 2;
    self.gesture_catchup_speed = var_37015ada8160570c;
  }
}

function ai_gesture_lookat_natural(lookat_target, catchup_speed, blend_in_time, check_range) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  while(!ai_can_lookat()) {
    wait 0.05;
  }

  while(distance2d(self.origin, lookat_target.origin) > check_range) {
    wait 0.05;
  }

  thread ai_gesture_lookat(lookat_target, catchup_speed, blend_in_time);
  wait blend_in_time;

  while(true) {
    wait randomfloatrange(4, 5);

    if(distance2d(self.origin, lookat_target.origin) <= check_range) {
      thread ai_gesture_lookat_weight_down(1);
      thread ai_gesture_eyes_stop();
    }

    wait randomfloatrange(4, 6);

    while(!ai_can_lookat()) {
      wait 0.05;
    }

    if(distance2d(self.origin, lookat_target.origin) <= check_range) {
      thread ai_gesture_lookat_weight_up(0.5);
      thread ai_gesture_eyes_lookat(lookat_target, 1, 0.2);
    }
  }
}

function ai_gesture_update_eyes_lookat(new_lookat, var_809d5bbb11b6031c) {
  self endon("death");
  self endon("entitydeleted");
  self.eyes_lookat = new_lookat;
  self.is_eye_tracking = 1;

  if(isDefined(var_809d5bbb11b6031c)) {
    var_37015ada8160570c = self.eye_catchup_speed;
    self.eye_catchup_speed = var_809d5bbb11b6031c;
    wait var_809d5bbb11b6031c * 2;
    self.eye_catchup_speed = var_37015ada8160570c;
  }
}

function ai_gesture_head_leftright() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  blendout_time = self.blend_in_time;
  start_time = gettime() / 1000;
  var_837c12743ab916fe = undefined;
  anim_parent = % lookat_left_right;
  fwd_anim = self.head_center_anim;
  right_anim = self.head_right_anim;
  left_anim = self.head_left_anim;
  back_right_anim = self.head_rightback_anim;
  back_left_anim = self.head_leftback_anim;
  thread _ai_head_weight_blend_in();
  var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
  self setanimlimited(fwd_anim, 1, self.blend_in_time);
  self setanimlimited(right_anim, 0.005, self.blend_in_time);
  self setanimlimited(left_anim, 0.005, self.blend_in_time);
  self setanimlimited(back_right_anim, 0.005, self.blend_in_time);
  self setanimlimited(back_left_anim, 0.005, self.blend_in_time);
  var_9e41f6b2a5fdfa6c = 0;
  var_3a58e25d07fa8963 = 0;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.gesture_lookat)) {
      thread ai_gesture_stop(0.7);
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(self.gesture_lookat)) {
      lookat = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      lookat = self.gesture_lookat;
    } else {
      lookat = self.gesture_lookat.origin;
    }

    var_f8018ede9bc535ee = self gettagangles("J_Spine4") + (0, 0, 0);
    var_7ac7a365a6aee172 = self gettagorigin("J_Spine4");
    vec_to_player = vectorNormalize(lookat - var_7ac7a365a6aee172);
    forward_vec = anglestoright(var_f8018ede9bc535ee);
    right_vec = anglestoup(var_f8018ede9bc535ee);
    left_vec = anglestoup(var_f8018ede9bc535ee) * -1;
    back_vec = anglestoright(var_f8018ede9bc535ee) * -1;
    up_vec = anglesToForward(var_f8018ede9bc535ee);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0.005, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0.005, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0.005, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0.005, 1);
    back_test = 1;

    if(anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    self setanimlimited(right_anim, dot_right, self.gesture_catchup_speed);
    self setanimlimited(left_anim, dot_left, self.gesture_catchup_speed);
    self setanimlimited(fwd_anim, dot_fwd + 0.005, self.gesture_catchup_speed);

    if(back_test) {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, dot_back, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, 0.005, 0.1);
    } else {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, 0.005, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, dot_back, 0.1);
    }

    self setanimlimited(back_right_anim, var_9e41f6b2a5fdfa6c, self.gesture_catchup_speed);
    self setanimlimited(back_left_anim, var_3a58e25d07fa8963, self.gesture_catchup_speed);
    waitframe();
  }
}

function _ai_head_weight_blend_in() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  start_time = gettime() / 1000;
  self.blend_up_in_progress = 1;

  while(gettime() / 1000 - start_time < self.blend_in_time * 2) {
    norm_val = (gettime() / 1000 - start_time) / self.blend_in_time * 2;
    smooth_val = smoothstep(0, 1, norm_val);
    var_1253d54849fc8641 = smoothstep(0, 10, norm_val);
    weight = lerp_float(0, 1, smooth_val);
    part_weight = lerp_float(0, 10, smooth_val);
    self setanimlimited(%lookat_left_right, weight, 0.2);
    self setanimlimited(%lookat_up_down, weight, 0.2);
    self setanimlimited(%lookat_head_base_partial, part_weight, 0.2);
    self setanimlimited(%head_gesture_look_partial, part_weight, 0.2);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 1, 0.2);
  self setanimlimited(%lookat_up_down, 1, 0.2);
  self setanimlimited(%lookat_head_base_partial, 10, 0.2);
  self setanimlimited(%head_gesture_look_partial, 10, 0.2);
  wait 0.05;
  self.blend_up_in_progress = undefined;
}

function ai_gesture_head_updown() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self setanimlimited(%lookat_up_down, 1, self.blend_in_time);
  self setanimlimited(self.look_updown_anim, 1, self.blend_in_time);
  self setanimtime(self.look_updown_anim, 0.5);
  var_8bc1a6a78e77c5d1 = 0.5;

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      offset = 0;

      if(level.player getdemeanorviewmodel() == "safe") {
        offset = 4.62;
      }

      lookat = level.player getEye() + anglestoup(self.angles) * offset;
    } else if(isai(self.gesture_lookat)) {
      lookat = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      lookat = self.gesture_lookat;
    } else {
      lookat = self.gesture_lookat.origin;
    }

    var_f8018ede9bc535ee = self gettagangles("J_Spine4") + (0, 0, 0);
    var_7ac7a365a6aee172 = self gettagorigin("J_Spine4");
    guy_pos = undefined;

    if(isai(self)) {
      guy_pos = self getEye();
    } else {
      guy_pos = self gettagorigin("J_Head");
    }

    vec_to_player = vectorNormalize(lookat - guy_pos);
    var_295ec4aa62f17342 = anglesToForward(var_f8018ede9bc535ee);
    var_bdbf163e071652f8 = vectordot(var_295ec4aa62f17342, vec_to_player);
    var_e7e7df501885a8b7 = float_remap(var_bdbf163e071652f8, 1, -1, 0, 1);
    var_8bc1a6a78e77c5d1 += (var_e7e7df501885a8b7 - var_8bc1a6a78e77c5d1) * self.gesture_catchup_speed * 0.3;
    var_8bc1a6a78e77c5d1 = clamp(var_8bc1a6a78e77c5d1, 0.1, 0.65);
    set_time_via_rate(self.look_updown_anim, var_8bc1a6a78e77c5d1);
    waitframe();
  }
}

function ai_gesture_eyes_leftright() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%eyes_lookat_base_partial, 10, self.eye_blend_in_time * 2);
  self setanimlimited(%facial_gesture_look_partial, 10, self.eye_blend_in_time * 2);
  self setanimlimited(%eyes_look_leftright, 1, self.eye_blend_in_time);
  self setanimlimited(self.eyes_leftright_anim, 1, self.eye_blend_in_time);
  self setanimtime(self.eyes_leftright_anim, 0.5);
  self setanimrate(self.eyes_leftright_anim, 0);
  var_8bc1a6a78e77c5d1 = 0;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.eyes_lookat)) {
      ai_gesture_eyes_stop(0.25);
      break;
    }

    if(isPlayer(self.eyes_lookat)) {
      lookat = level.player getEye();
    } else if(isai(self.eyes_lookat)) {
      lookat = self.eyes_lookat getEye();
    } else if(isvector(self.eyes_lookat)) {
      lookat = self.eyes_lookat;
    } else {
      lookat = self.eyes_lookat.origin;
    }

    var_22768c2b78f15eb0 = self gettagangles("j_head");
    var_e630138e877b75b0 = self gettagorigin("j_head");
    var_f8018ede9bc535ee = self gettagangles("J_Spine4") + (0, 90, 0);
    vec_to_player = vectorNormalize(lookat - var_e630138e877b75b0);
    var_73ffcab9352f4558 = anglestoup(var_22768c2b78f15eb0);
    var_8a2a8dfdef9c641d = scripts\engine\utility::flatten_vector(vec_to_player);
    var_818e7dcbfe8c45c9 = scripts\engine\utility::flatten_vector(var_73ffcab9352f4558);
    var_f750bc72c7dca1a0 = vectordot(var_818e7dcbfe8c45c9, var_8a2a8dfdef9c641d);
    var_e7e7df501885a8b7 = float_remap(var_f750bc72c7dca1a0, 1, -1, 0, 1);
    follow_percent = clamp(var_e7e7df501885a8b7, 0, 1);
    self setanimtime(self.eyes_leftright_anim, follow_percent);
    waitframe();
  }
}

function ai_gesture_eyes_updown() {
  self endon("gesture_stop");
  self endon("death");
  self endon("eye_gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%eyes_look_updown, 1, self.eye_blend_in_time);
  self setanimlimited(self.eyes_updown_anim, 1, self.eye_blend_in_time);
  self setanimtime(self.eyes_updown_anim, 0.5);
  var_8bc1a6a78e77c5d1 = 0.5;

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.eyes_lookat)) {
      lookat = level.player getEye();
    } else if(isai(self.eyes_lookat)) {
      lookat = self.eyes_lookat getEye();
    } else if(isvector(self.eyes_lookat)) {
      lookat = self.eyes_lookat;
    } else {
      lookat = self.eyes_lookat.origin;
    }

    var_22768c2b78f15eb0 = self gettagangles("j_head");
    var_e630138e877b75b0 = self gettagorigin("j_head");
    var_f8018ede9bc535ee = self gettagangles("J_Spine4");
    var_96685d578c819929 = anglesToForward(var_22768c2b78f15eb0);
    vec_to_player = vectorNormalize(lookat - var_e630138e877b75b0);
    dot_vec = vectordot(var_96685d578c819929, vec_to_player);
    var_e7e7df501885a8b7 = float_remap(dot_vec, 1, -1, 0.3, 0.7);
    follow_percent = clamp(var_e7e7df501885a8b7, 0, 1);
    var_8bc1a6a78e77c5d1 += (follow_percent - var_8bc1a6a78e77c5d1) * self.eye_catchup_speed * 0.3;
    var_8bc1a6a78e77c5d1 = clamp(var_8bc1a6a78e77c5d1, 0.1, 0.9);
    set_time_via_rate(self.eyes_updown_anim, var_8bc1a6a78e77c5d1);
    waitframe();
  }
}

function ai_gesture_torso_leftright() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var_837c12743ab916fe = undefined;
  anim_parent = % torso_tracking_anims;
  fwd_anim = self.torso_center_anim;
  right_anim = self.torso_right_anim;
  left_anim = self.torso_left_anim;
  back_right_anim = self.torso_rightback_anim;
  back_left_anim = self.torso_leftback_anim;
  childthread _ai_torso_weight_blend_in();
  var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
  self setanimlimited(fwd_anim, 1, 0.05);
  self setanimlimited(right_anim, 0, 0.05);
  self setanimlimited(left_anim, 0, 0.05);
  self setanimlimited(back_right_anim, 0, 0.05);
  self setanimlimited(back_left_anim, 0, 0.05);
  var_9e41f6b2a5fdfa6c = 0;
  var_3a58e25d07fa8963 = 0;

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(self.gesture_lookat)) {
      lookat = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      lookat = self.gesture_lookat;
    } else {
      lookat = self.gesture_lookat.origin;
    }

    vec_to_player = vectorNormalize(lookat - self.origin);
    forward_vec = anglesToForward(self.angles);
    right_vec = anglestoright(self.angles);
    left_vec = anglestoright(self.angles) * -1;
    back_vec = anglesToForward(self.angles) * -1;
    up_vec = anglestoup(self.angles);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
    back_test = 1;

    if(anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    self setanimlimited(right_anim, dot_right, 0.2);
    self setanimlimited(left_anim, dot_left, 0.2);
    self setanimlimited(fwd_anim, dot_fwd + 0.005, 0.2);

    if(back_test) {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, dot_back, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, 0, 0.1);
    } else {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, 0, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, dot_back, 0.1);
    }

    self setanimlimited(back_right_anim, var_9e41f6b2a5fdfa6c, 0.2);
    self setanimlimited(back_left_anim, var_3a58e25d07fa8963, 0.2);
    waitframe();
  }
}

function _ai_torso_weight_blend_in() {
  start_time = gettime() / 1000;

  while(gettime() / 1000 - start_time < self.blend_in_time) {
    norm_val = (gettime() / 1000 - start_time) / self.blend_in_time;
    norm_val = smoothstep(0, 1, norm_val);
    weight = lerp_float(0, 1, norm_val);
    self setanimlimited(%torso_tracking_anims, weight, 0.05);
    wait 0.05;
    waittillframeend();
  }

  self setanimlimited(%torso_tracking_anims, 1, 0.05);
}

function ai_gesture_blink_loop(blink_interval) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  ai_gesture_single_blink();

  while(true) {
    wait randomfloatrange(blink_interval * 0.5, blink_interval);
    self clearanim(%facial_gesture_blink_1, 0);
    wait 0.05;
    self setanimlimited(%facial_gesture_blink_1, 1, 0);
    waitframe();
  }
}

function ai_gesture_single_blink() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(self)) {
    return;
  }

  self setanimlimited(%eyes_blink, 1, 0);
  self clearanim(%facial_gesture_blink_1, 0);
  wait 0.05;
  self setanimlimited(%facial_gesture_blink_1, 1, 0);
}

function ai_gesture_point(pointat) {
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
  demeanor = asm_getdemeanor();
  state = asm_getcurrentstate(self.asmname);
  scripts\asm\asm::asm_setupgesture(self.asmname, state);

  if(demeanor != "casual" && demeanor != "casual_gun") {
    self.gesture_point_parent = % gesture_partials;
  } else {
    self.gesture_point_parent = % point_at_without_head;
  }

  if(!asm_currentstatehasflag(self.asmname, "gesture")) {
    println("<dev string:x1c>" + state + "<dev string:x29>");
    return;
  } else if(demeanor == "casual" || demeanor == "combat" || demeanor == "casual_gun" || demeanor == "frantic") {
    self.point_center_anim = self.asm.gestures.gesture_point_center;
    self.point_left_anim = self.asm.gestures.gesture_point_left;
    self.point_right_anim = self.asm.gestures.gesture_point_right;
    self.point_up_anim = self.asm.gestures.gesture_point_up;
    self.point_down_anim = self.asm.gestures.gesture_point_down;
    self.gesture_body_knob = asm_getbodyknob();
  } else {
    println(demeanor + "<dev string:x44>");
    return;
  }

  if(isPlayer(pointat)) {
    lookat = level.player getEye();
  } else if(!isDefined(pointat)) {
    lookat = self.origin;
    self.no_point_defined = 1;
  } else if(isai(pointat)) {
    lookat = pointat getEye();
  } else if(isvector(pointat)) {
    lookat = pointat;
  } else {
    lookat = pointat.origin;
  }

  character_angles = self gettagangles("J_Spine4") + (0, 90, 0);
  character_origin = self gettagorigin("J_Spine4");
  var_84debf527911a15d = anglestoright(character_angles);
  var_4bd579fa63eb0ed2 = anglestoup(character_angles);
  vec_to_target = vectorNormalize(lookat - character_origin);
  var_b4291343f067bb1d = scripts\engine\utility::flatten_vector(var_84debf527911a15d);
  var_ebf67e00f0184992 = scripts\engine\utility::flatten_vector(var_4bd579fa63eb0ed2);
  var_af48fc7d3df203f1 = scripts\engine\utility::flatten_vector(vec_to_target);
  dot_vec = vectordot(var_b4291343f067bb1d, var_af48fc7d3df203f1) * -1;
  var_8e8c89b2cbb6bc04 = dot_vec * -1;
  clamped_dot = clamp(float_remap(dot_vec, 0.2, 1, 0, 1), 0, 1);
  var_824c03276d8cdcec = clamp(float_remap(var_8e8c89b2cbb6bc04, 0.2, 1, 0, 1), 0, 1);
  var_9088cba4a109b331 = self gettagorigin("J_Spine4");
  var_20f493dca3c1483f = vectorNormalize(lookat - var_9088cba4a109b331);
  var_ca399d17885e392 = anglesToForward(character_angles);
  var_2cb0644208843c51 = vectordot(var_20f493dca3c1483f, var_ca399d17885e392);
  var_2e436ef195c55994 = var_2cb0644208843c51 * -1;
  var_f25cc6d803539f37 = vectordot(var_4bd579fa63eb0ed2, var_20f493dca3c1483f);
  var_7ba291bb89a5d6dd = clamp(float_remap(var_f25cc6d803539f37, 0.2, 1, 0, 1), 0, 1);
  var_bed61d13bd0fe46f = clamp(float_remap(var_2cb0644208843c51, 0.2, 1, 0, 1), 0, 1);
  var_bd630759847e7b0c = clamp(float_remap(var_2e436ef195c55994, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(var_f25cc6d803539f37 < -0.9) {
      ai_gesture_simple("fallback_up");
    } else {
      if(demeanor != "casual" && demeanor != "casual_gun") {
        self setanimlimited(self.gesture_point_parent, 10, 0.25);
      } else {
        self setanimlimited(self.gesture_point_parent, 1, 0.25);
      }

      if(var_7ba291bb89a5d6dd < 0.3) {
        self setanimlimited(self.point_center_anim, 0, 0, 0.85);
      } else {
        self setanimlimited(self.point_center_anim, var_7ba291bb89a5d6dd, 0.25, 0.85);
      }

      if(isDefined(self.point_up_anim)) {
        self setanimlimited(self.point_up_anim, var_bed61d13bd0fe46f, 0.25, 0.85);
      }

      if(isDefined(self.point_down_anim)) {
        self setanimlimited(self.point_down_anim, var_bd630759847e7b0c, 0.2, 0.85);
      }

      self setanimlimited(self.point_left_anim, var_824c03276d8cdcec, 0.25, 0.85);
      self setanimlimited(self.point_right_anim, clamped_dot, 0.25, 0.85);
    }
  } else {
    if(demeanor != "casual" && demeanor != "casual_gun") {
      self setanimlimited(self.gesture_point_parent, 10, 0.2);
    } else {
      self setanimlimited(self.gesture_point_parent, 1, 0.2);
    }

    self setanimlimited(self.point_center_anim, 1, 0.2, 0.85);
  }

  wait_time = getanimlength(%prototype_gesture_point_center) * 0.85;
  wait wait_time;
  self clearanim(self.gesture_point_parent, 0.25);
  self setanimlimited(self.gesture_body_knob, 1, 0.25);
  self._blackboard.point_gesture_active = 0;
}

function ai_gesture_simple(var_7ca8d1ce367054f8) {
  self endon("death");
  self endon("entitydeleted");
  self.point_center_anim = undefined;
  self.gesture_body_knob = undefined;
  self.is_partial = 0;
  demeanor = "casual";
  state = undefined;

  if(isai(self)) {
    self._blackboard.gesture_active = 1;
    demeanor = asm_getdemeanor();
    state = asm_getcurrentstate(self.asmname);
  }

  var_3b61fb88f64b3755 = ["shrug", "cross", "nod", "salute", "wave", "wait", "fallback_up"];
  var_a534bbf61c8c91af = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_337fd93417b7bcbd = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var_684250e83139a238 = ["shrug", "cross", "nod", "salute", "wave", "wait", "move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];

  if(!scripts\engine\utility::array_contains(var_3b61fb88f64b3755, var_7ca8d1ce367054f8) && !scripts\engine\utility::array_contains(var_a534bbf61c8c91af, var_7ca8d1ce367054f8)) {
    assertex(var_7ca8d1ce367054f8, "Gesture type specified is not a valid type");
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isai(self) && !asm_currentstatehasflag(self.asmname, "gesture")) {
    println("<dev string:x1c>" + state + "<dev string:x29>");
    return;
  } else if(isai(self)) {
    self.gesture_body_knob = asm_getbodyknob();

    if(demeanor == "casual") {
      if(scripts\engine\utility::array_contains(var_3b61fb88f64b3755, var_7ca8d1ce367054f8)) {
        self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
        self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
        self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
        self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
        self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
        self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
      } else {
        println("<dev string:x69>");
        return;
      }
    } else if(demeanor == "casual_gun") {
      if(scripts\engine\utility::array_contains(var_684250e83139a238, var_7ca8d1ce367054f8)) {
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
      } else {
        println("<dev string:x93>");
        return;
      }
    } else if(demeanor == "combat") {
      if(scripts\engine\utility::array_contains(var_a534bbf61c8c91af, var_7ca8d1ce367054f8)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        println("<dev string:xc1>");
        return;
      }
    } else if(demeanor == "cqb") {
      if(scripts\engine\utility::array_contains(var_337fd93417b7bcbd, var_7ca8d1ce367054f8)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        println("<dev string:xeb>");
        return;
      }
    } else if(demeanor == "frantic") {
      if(scripts\engine\utility::array_contains(var_a534bbf61c8c91af, var_7ca8d1ce367054f8)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        println("<dev string:xc1>");
        return;
      }
    } else {
      println(demeanor + "<dev string:x44>");
      return;
    }
  } else {
    self.gesture_shrug_anim = % shipcrib_gst_body_shrug_01;
    self.gesture_cross_anim = % shipcrib_gst_body_cross_01;
    self.gesture_nod_anim = % shipcrib_gst_head_nod_01;
    self.gesture_salute_anim = % shipcrib_gst_head_salute_01;
    self.gesture_wave_anim = % shipcrib_gst_body_wave_01;
    self.gesture_wait_anim = % shipcrib_gst_body_wait_01;
    self.gesture_fallback_up_anim = % hm_grnd_org_gest_fallback_up;
  }

  anim_to_play = undefined;

  switch (var_7ca8d1ce367054f8) {
    case #"hash_f95a6a3ee8c001ec":
      anim_to_play = self.gesture_shrug_anim;
      break;
    case #"hash_eb00cb01bd7a6e7b":
      anim_to_play = self.gesture_cross_anim;
      break;
    case #"hash_40a1376c2c1dba9a":
      anim_to_play = self.gesture_nod_anim;
      break;
    case #"hash_c7d247b0c27f20b1":
      anim_to_play = self.gesture_salute_anim;
      break;
    case #"hash_bda5687440fc2934":
      anim_to_play = self.gesture_wave_anim;
      break;
    case #"hash_bdf347744138cb00":
      anim_to_play = self.gesture_wait_anim;
      break;
    case #"hash_dd93195493d0c818":
      self.is_partial = 1;
      anim_to_play = self.gesture_hold_anim;
      break;
    case #"hash_b8e7e4b53801f40f":
      self.is_partial = 1;
      anim_to_play = self.gesture_onme_anim;
      break;
    case #"hash_c49910ada754deb4":
      self.is_partial = 1;
      anim_to_play = self.gesture_moveup_anim;
      break;
    case #"hash_486396f4d5e0cc51":
      self.is_partial = 1;
      anim_to_play = self.gesture_fallback_up_anim;
      break;
    case #"hash_f61262b439059658":
      self.is_partial = 1;
      anim_to_play = self.gesture_fallback_down_anim;
      break;
    case #"hash_de706ce2cae61473":
      self.is_partial = 1;
      anim_to_play = self.gesture_armup_anim;
      break;
  }

  if(self.is_partial) {
    self.simple_gesture_parent = % gesture_partials;
  } else {
    self.simple_gesture_parent = % add_gesture;
  }

  if(self.is_partial) {
    thread blend_partial_in(self.simple_gesture_parent, anim_to_play, 0.5);
  } else {
    self setanimlimited(self.simple_gesture_parent, 1, 0.5);
    self setanimlimited(anim_to_play, 1, 0.5, 0.75);
  }

  wait_time = getanimlength(anim_to_play) * 0.85;
  wait wait_time;

  if(self.is_partial) {
    thread blend_partial_out(self.simple_gesture_parent, anim_to_play, 0.5);
  } else {
    self clearanim(self.simple_gesture_parent, 0.5);
    self clearanim(anim_to_play, 0.5);
  }

  self.is_partial = 0;

  if(isai(self)) {
    self._blackboard.gesture_active = undefined;
  }
}

function blend_partial_in(gesture_parent, animation, blend_time, notetrack) {
  blend = blend_time * 0.5;
  self setanimlimited(gesture_parent, 1, blend);
  self setanimlimited(animation, 1, blend, 0.75);
  wait blend_time * 0.5;
  self setanimlimited(animation, 10, blend, 0.75);
  self setanimlimited(gesture_parent, 10, blend);
}

function blend_partial_out(gesture_parent, animation, clear_time) {
  clear = clear_time * 0.5;
  self setanimlimited(gesture_parent, 1, clear);
  self setanimlimited(animation, 1, clear);
  wait clear;
  self clearanim(gesture_parent, clear);
  self clearanim(animation, clear);
}

function float_remap(value, from1, to1, from2, to2) {
  return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function lerp_float(from, to, delta) {
  return from + delta * (to - from);
}

function smoothstep(start, end, delta) {
  delta = clamp((delta - start) / (end - start), 0, 1);
  return delta * delta * (3 - 2 * delta);
}

function set_time_via_rate(anime, time, weight, blend_time) {
  if(!isDefined(weight)) {
    weight = 1;
  }

  if(!isDefined(blend_time)) {
    blend_time = 0.25;
  }

  prev_time = self getanimtime(anime);
  duration = getanimlength(anime);
  rate = (time - prev_time) * duration / 0.05;
  self setanimlimited(anime, weight, blend_time, rate);
}

function ai_gesture_directional_custom(target, anim_array, partial_bool) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  anims = anim_array;
  var_5286de9bce84f2c4 = anim_array[0];
  var_18e5b6b83a6361c0 = anim_array[1];
  var_b849486170a283ff = anim_array[2];
  var_dc7d859aab697700 = anim_array[3];
  var_e990bebf600b1c9f = anim_array[4];
  var_8bc1a08153e71af8 = 0;
  gesture_body_knob = undefined;
  self.no_point_defined = 0;
  gesture_parent = undefined;

  if(isDefined(partial_bool)) {
    gesture_body_knob = asm_getbodyknob();
    gesture_parent = % gesture_partials;
  } else {
    gesture_parent = % add_gesture;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isPlayer(target)) {
    lookat = level.player getEye();
  } else if(!isDefined(target)) {
    lookat = self.origin;
    var_8bc1a08153e71af8 = 1;
  } else if(isai(target)) {
    lookat = target getEye();
  } else if(isvector(target)) {
    lookat = target;
  } else {
    lookat = target.origin;
  }

  character_angles = self gettagangles("tag_origin");
  character_origin = self gettagorigin("tag_origin");
  var_84debf527911a15d = anglestoright(character_angles);
  var_4bd579fa63eb0ed2 = anglesToForward(character_angles);
  vec_to_target = vectorNormalize(lookat - character_origin);
  var_b4291343f067bb1d = scripts\engine\utility::flatten_vector(var_84debf527911a15d);
  var_ebf67e00f0184992 = scripts\engine\utility::flatten_vector(var_4bd579fa63eb0ed2);
  var_af48fc7d3df203f1 = scripts\engine\utility::flatten_vector(vec_to_target);
  dot_vec = vectordot(var_b4291343f067bb1d, var_af48fc7d3df203f1);
  var_8e8c89b2cbb6bc04 = dot_vec * -1;
  clamped_dot = clamp(float_remap(dot_vec, 0.2, 1, 0, 1), 0, 1);
  var_824c03276d8cdcec = clamp(float_remap(var_8e8c89b2cbb6bc04, 0.2, 1, 0, 1), 0, 1);
  var_9088cba4a109b331 = self gettagorigin("J_Spine4");
  var_20f493dca3c1483f = vectorNormalize(lookat - var_9088cba4a109b331);
  var_ca399d17885e392 = anglestoup(character_angles);
  var_2cb0644208843c51 = vectordot(var_20f493dca3c1483f, var_ca399d17885e392);
  var_2e436ef195c55994 = var_2cb0644208843c51 * -1;
  var_f25cc6d803539f37 = vectordot(var_ebf67e00f0184992, var_20f493dca3c1483f);
  var_7ba291bb89a5d6dd = clamp(float_remap(var_f25cc6d803539f37, 0.2, 1, 0, 1), 0, 1);
  var_bed61d13bd0fe46f = clamp(float_remap(var_2cb0644208843c51, 0.2, 1, 0, 1), 0, 1);
  var_bd630759847e7b0c = clamp(float_remap(var_2e436ef195c55994, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(isDefined(partial_bool)) {
      self setanimlimited(gesture_parent, 10, 0.25);
    } else {
      self setanimlimited(gesture_parent, 1, 0.25);
    }

    if(var_7ba291bb89a5d6dd < 0.3) {
      self setanimlimited(var_5286de9bce84f2c4, 0, 0, 1);
    } else {
      self setanimlimited(var_5286de9bce84f2c4, var_7ba291bb89a5d6dd, 0.25, 1);
    }

    if(isDefined(var_dc7d859aab697700)) {
      self setanimlimited(var_dc7d859aab697700, var_bed61d13bd0fe46f, 0.25, 1);
    }

    if(isDefined(var_e990bebf600b1c9f)) {
      self setanimlimited(var_e990bebf600b1c9f, var_bd630759847e7b0c, 0.25, 1);
    }

    self setanimlimited(var_18e5b6b83a6361c0, var_824c03276d8cdcec, 0.25, 1);
    self setanimlimited(var_b849486170a283ff, clamped_dot, 0.25, 1);
  } else {
    if(isDefined(partial_bool)) {
      self setanimlimited(gesture_body_knob, 0.001, 0.1);
    }

    self setanimlimited(gesture_parent, 1, 0.25);
    self setanimlimited(var_5286de9bce84f2c4, 1, 0.25);
  }

  wait_time = getanimlength(var_5286de9bce84f2c4);
  wait wait_time;
  self clearanim(gesture_parent, 0.25);
  self setanimlimited(gesture_body_knob, 1, 0.25);
}

function ai_custom_gesture(gesture_anim, partial_bool) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  gesture_root = % add_gesture;
  using_partial = 0;
  notification = "single anim";
  thread scripts\common\notetrack::start_notetrack_wait(self, notification, undefined, undefined, gesture_anim);

  if(isDefined(partial_bool) && partial_bool) {
    gesture_root = % gesture_partials;
    using_partial = 1;
  }

  if(using_partial) {
    thread blend_partial_in(gesture_root, gesture_anim, 0.2);
  } else {
    self setanimlimited(gesture_root, 1, 0.1);
    self setanimlimited(gesture_anim, 1, 0.1);
  }

  wait_time = getanimlength(gesture_anim) * 0.75 - 0.2;
  wait wait_time;

  if(using_partial) {
    thread blend_partial_out(gesture_root, gesture_anim, 0.2);
    return;
  }

  self clearanim(gesture_root, 0.2);
  self clearanim(gesture_anim, 0.2);
}

function blended_loop_anim() {
  guy = self;
  self endon(self.ender);
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;

  foreach(thing in guy.anim_array) {
    if(issubstr(thing, "forward")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.fwd_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "right") && !issubstr(thing, "back")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.right_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "left") && !issubstr(thing, "back")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.left_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "leftback")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.leftback_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "rightback")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.rightback_anim = level.scr_anim[guy.animname][thing];
      }
    }
  }

  org = getstartorigin(self.animnode.origin, self.animnode.angles, guy.fwd_anim);
  ang = getstartangles(self.animnode.origin, self.animnode.angles, guy.fwd_anim);

  if(isai(guy)) {
    guy forceteleport(org, ang, 10000);
  } else {
    guy.origin = org;
    guy.angles = ang;
  }

  var_837c12743ab916fe = vectortoangles(level.player.origin - guy.origin);
  guy setanimknoball(guy.fwd_anim, %root, 1, 0.2);

  if(isDefined(guy.right_anim)) {
    guy setanimlimited(guy.right_anim, 0, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy setanimlimited(guy.left_anim, 0, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy setanimlimited(guy.leftback_anim, 0, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy setanimlimited(guy.rightback_anim, 0, 0.2);
  }

  var_9e41f6b2a5fdfa6c = 0;
  var_3a58e25d07fa8963 = 0;
  guy pushplayer(1);

  while(true) {
    if(!isDefined(guy)) {
      break;
    }

    if(isPlayer(guy.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat getEye();
    } else if(isvector(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat;
    } else {
      lookat = guy.gesture_lookat.origin;
    }

    var_f8018ede9bc535ee = guy gettagangles("tag_origin");
    var_7ac7a365a6aee172 = guy gettagorigin("tag_origin");
    vec_to_player = flatten_vector(vectorNormalize(lookat - var_7ac7a365a6aee172));
    forward_vec = anglesToForward(var_f8018ede9bc535ee);
    right_vec = anglestoright(var_f8018ede9bc535ee);
    left_vec = anglestoright(var_f8018ede9bc535ee) * -1;
    back_vec = anglesToForward(var_f8018ede9bc535ee) * -1;
    up_vec = anglestoup(var_f8018ede9bc535ee);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
    back_test = 1;

    if(anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(isDefined(guy.right_anim)) {
      guy setanimlimited(guy.right_anim, dot_right, 0.2);
    }

    if(isDefined(guy.left_anim)) {
      guy setanimlimited(guy.left_anim, dot_left, 0.2);
    }

    guy setanimlimited(guy.fwd_anim, dot_fwd + 0.005, 0.2);

    if(back_test) {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, dot_back, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, 0, 0.1);
    } else {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, 0, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, dot_back, 0.1);
    }

    if(isDefined(guy.rightback_anim)) {
      guy setanimlimited(guy.rightback_anim, var_9e41f6b2a5fdfa6c + 0.005, 0.2);
    }

    if(isDefined(guy.leftback_anim)) {
      guy setanimlimited(guy.leftback_anim, var_3a58e25d07fa8963 + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }
}

function blended_loop_cleanup() {
  guy = self;

  if(isDefined(guy.ender)) {
    guy notify(guy.ender);
  }

  guy clearanim(guy.fwd_anim, 0.2);

  if(isDefined(guy.right_anim)) {
    guy clearanim(guy.right_anim, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy clearanim(guy.left_anim, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy clearanim(guy.leftback_anim, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy clearanim(guy.rightback_anim, 0.2);
  }

  guy pushplayer(0);
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;
  guy.anim_array = undefined;
  guy.ender = undefined;
  guy.gesture_lookat = undefined;
}

function blended_anim() {
  guy = self;
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;

  foreach(thing in guy.anim_array) {
    if(issubstr(thing, "forward")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.fwd_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "right") && !issubstr(thing, "back")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.right_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "left") && !issubstr(thing, "back")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.left_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "leftback")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.leftback_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "rightback")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.rightback_anim = level.scr_anim[guy.animname][thing];
      }
    }
  }

  org = getstartorigin(self.animnode.origin, self.animnode.angles, guy.fwd_anim);
  ang = getstartangles(self.animnode.origin, self.animnode.angles, guy.fwd_anim);

  if(isai(guy)) {
    guy forceteleport(org, ang, 10000);
  } else {
    guy.origin = org;
    guy.angles = ang;
  }

  var_837c12743ab916fe = vectortoangles(level.player.origin - guy.origin);
  guy setanimknoball(guy.fwd_anim, %root, 1, 0.2);

  if(isDefined(guy.right_anim)) {
    guy setanimlimited(guy.right_anim, 0, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy setanimlimited(guy.left_anim, 0, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy setanimlimited(guy.leftback_anim, 0, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy setanimlimited(guy.rightback_anim, 0, 0.2);
  }

  var_9e41f6b2a5fdfa6c = 0;
  var_3a58e25d07fa8963 = 0;
  start_time = gettime() / 1000;
  wait_time = getanimlength(guy.fwd_anim);

  while(gettime() / 1000 - start_time < wait_time) {
    if(!isDefined(guy)) {
      break;
    }

    if(isPlayer(guy.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat getEye();
    } else if(isvector(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat;
    } else {
      lookat = guy.gesture_lookat.origin;
    }

    var_f8018ede9bc535ee = guy gettagangles("tag_origin");
    var_7ac7a365a6aee172 = guy gettagorigin("tag_origin");
    vec_to_player = flatten_vector(vectorNormalize(lookat - var_7ac7a365a6aee172));
    forward_vec = anglesToForward(var_f8018ede9bc535ee);
    right_vec = anglestoright(var_f8018ede9bc535ee);
    left_vec = anglestoright(var_f8018ede9bc535ee) * -1;
    back_vec = anglesToForward(var_f8018ede9bc535ee) * -1;
    up_vec = anglestoup(var_f8018ede9bc535ee);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
    back_test = 1;

    if(anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(isDefined(guy.right_anim)) {
      guy setanimlimited(guy.right_anim, dot_right, 0.2);
    }

    if(isDefined(guy.left_anim)) {
      guy setanimlimited(guy.left_anim, dot_left, 0.2);
    }

    guy setanimlimited(guy.fwd_anim, dot_fwd + 0.005, 0.2);

    if(back_test) {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, dot_back, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, 0, 0.1);
    } else {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, 0, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, dot_back, 0.1);
    }

    if(isDefined(guy.rightback_anim)) {
      guy setanimlimited(guy.rightback_anim, var_9e41f6b2a5fdfa6c + 0.005, 0.2);
    }

    if(isDefined(guy.leftback_anim)) {
      guy setanimlimited(guy.leftback_anim, var_3a58e25d07fa8963 + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }

  guy thread blended_loop_cleanup();
}