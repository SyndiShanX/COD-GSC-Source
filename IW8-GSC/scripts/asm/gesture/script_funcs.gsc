/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\gesture\script_funcs.gsc
************************************************/

function checkbcstatevalid(var0, var1, var2, var3) {
  if(isDefined(self.enemy)) {
    var4 = distancesquared(self.origin, self.enemy.origin);

    if(var4 < 65536) {
      return 0;
    }

    if(isai(self.enemy)) {
      if(!isDefined(self.enemy scripts\asm\asm_bb::bb_getcovernode()) || self.enemy scripts\asm\asm_bb::bb_getrequestedcoverstate() != "hide") {
        return 0;
      }
    } else if(var4 < 262144) {
      return 0;
    }
  }

  if(isDefined(self._blackboard.battlechatter_alias)) {
    if(self._blackboard.battlechatter_alias == var3) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function choosebcdirectionanim(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(self._blackboard.battlechatter_target)) {
    var3 = self._blackboard.battlechatter_target.origin;
  } else {
    var3 = level.player.origin + anglesToForward(level.player.angles) * 6000;
  }

  jumpiffalse(isDefined(var2)) LOC_0000005a;
  var4 = var2;
  goto LOC_0000008c;
}

function playbcanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self._blackboard.battlechatter_anim_active = 1;
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self._blackboard.battlechatter_alias = undefined;
  self._blackboard.battlechatter_anim_active = undefined;
}

function ai_gesture_requested(var0, var1, var2, var3) {
  return istrue(self._blackboard.gesture_active);
}

function ai_point_gesture_requested(var0, var1, var2, var3) {
  return istrue(self._blackboard.point_gesture_active);
}

function _is_looking_at_range(var0, var1) {
  var2 = anglesToForward(level.player.angles);
  var3 = vectorNormalize(var0.origin - level.player.origin);
  var4 = vectordot(var2, var3);

  if(var4 >= var1) {
    return 1;
  }

  return 0;
}

function get_anim_direction(var0, var1, var2) {
  var3 = vectortoangles(var2 - var1);
  var4 = angleclamp180(var3[1] - var0[1]);
  var5 = getangleindex(var4, 10);
  var6 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var6[var5];
}

#using_animtree("");

function ai_gesture_stop(var0) {
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

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 0.25;
  }

  if(!isDefined(self.is_head_tracking)) {
    return;
  }

  var2 = gettime() / 1000;
  var3 = self getanimweight(self.head_center_anim);
  var4 = self getanimweight(self.head_right_anim);
  var5 = self getanimweight(self.head_left_anim);
  var6 = self getanimweight(self.head_rightback_anim);
  var7 = self getanimweight(self.head_leftback_anim);
  var8 = self getanimweight(%lookat_left_right);
  var9 = self getanimweight($lookat_up_down);
  var10 = self getanimweight(%lookat_head_base_partial);
  var11 = self getanimweight(%head_gesture_look_partial);
  var12 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var2 < var1) {
    var13 = (gettime() / 1000 - var2) / var1;
    var13 = smoothstep(0, 1, var13);
    var14 = lerp_float(var3, 1, var13);
    var15 = lerp_float(var4, 0, var13);
    var16 = lerp_float(var5, 0, var13);
    var17 = lerp_float(var6, 0, var13);
    var18 = lerp_float(var7, 0, var13);
    var19 = lerp_float(var8, 0, var13);
    var20 = lerp_float(var9, 0, var13);
    var21 = lerp_float(var10, 0, var13);
    var22 = lerp_float(var11, 0, var13);
    var23 = lerp_float(var12, 0, var13);
    self setanimlimited(self.head_center_anim, var14, 0.05);
    self setanimlimited(self.head_right_anim, var15, 0.05);
    self setanimlimited(self.head_left_anim, var16, 0.05);
    self setanimlimited(self.head_rightback_anim, var17, 0.05);
    self setanimlimited(self.head_leftback_anim, var18, 0.05);
    self setanimlimited(%lookat_left_right, var19, 0.05);
    self setanimlimited(%lookat_up_down, var20, 0.05);
    self setanimlimited(%lookat_head_base_partial, var21, 0.05);
    self setanimlimited(%head_gesture_look_partial, var22, 0.05);
    self setanimlimited(%lookat_head_adds, var23, 0.05);
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

function ai_gesture_eyes_stop(var0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("eye_gesture_stop");

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 0.25;
  }

  self clearanim(%eyes_look_leftright, var1);
  self clearanim(%eyes_look_updown, var1);
  self clearanim(%eyes_lookat_base_partial, var1);
  self clearanim(%facial_gesture_look_partial, var1);
  self clearanim(%eyes_blink_base_partial, var1);
  self clearanim(%facial_gesture_blink_partial, var1);
  self clearanim(%eyes_blink, var1);
  self.is_eye_tracking = undefined;
}

function ai_gesture_lookat_weight_down(var0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_up");
  self notify("head_weight_down");
  self endon("entitydeleted");

  if(isDefined(self.blend_down_in_progress)) {
    return;
  }

  var1 = var0;
  self.blend_down_in_progress = 1;
  self.blend_up_in_progress = undefined;
  var2 = gettime() / 1000;
  var3 = self getanimweight(%lookat_left_right);
  var4 = self getanimweight(%lookat_up_down);
  var5 = self getanimweight(%lookat_head_base_partial);
  var6 = self getanimweight(%head_gesture_look_partial);
  var7 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var2 < var1) {
    var8 = (gettime() / 1000 - var2) / var1;
    var8 = smoothstep(0, 1, var8);
    var9 = lerp_float(var3, 0, var8);
    var10 = lerp_float(var4, 0, var8);
    var11 = lerp_float(var5, 0, var8);
    var12 = lerp_float(var6, 0, var8);
    var13 = lerp_float(var7, 0, var8);
    self setanimlimited(%lookat_left_right, var9, 0.05);
    self setanimlimited(%lookat_up_down, var10, 0.05);
    self setanimlimited(%lookat_head_base_partial, var11, 0.05);
    self setanimlimited(%head_gesture_look_partial, var12, 0.05);
    self setanimlimited(%lookat_head_adds, var13, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 0, 0.05);
  self setanimlimited(%lookat_up_down, 0, 0.05);
  self setanimlimited(%lookat_head_base_partial, 0, 0.05);
  self setanimlimited(%head_gesture_look_partial, 0, 0.05);
  self setanimlimited(%lookat_head_adds, 0, 0.05);
  self.blend_down_in_progress = undefined;
}

function ai_gesture_lookat_weight_up(var0) {
  self endon("death");
  self endon("gesture_stop");
  self endon("head_weight_down");
  self notify("head_weight_up");
  self endon("entitydeleted");

  if(isDefined(self.blend_up_in_progress)) {
    return;
  }

  var1 = var0;
  self.blend_up_in_progress = 1;
  self.blend_down_in_progress = undefined;
  var2 = gettime() / 1000;
  var3 = self getanimweight(%lookat_left_right);
  var4 = self getanimweight(%lookat_up_down);
  var5 = self getanimweight(%lookat_head_base_partial);
  var6 = self getanimweight(%head_gesture_look_partial);
  var7 = self getanimweight(%lookat_head_adds);

  while(gettime() / 1000 - var2 < var1) {
    var8 = (gettime() / 1000 - var2) / var1;
    var8 = smoothstep(0, 1, var8);
    var9 = lerp_float(var3, 1, var8);
    var10 = lerp_float(var4, 1, var8);
    var11 = lerp_float(var5, 10, var8);
    var12 = lerp_float(var6, 10, var8);
    var13 = lerp_float(var7, 0, var8);
    self setanimlimited(%lookat_left_right, var9, 0.05);
    self setanimlimited(%lookat_up_down, var10, 0.05);
    self setanimlimited(%lookat_head_base_partial, var11, 0.05);
    self setanimlimited(%head_gesture_look_partial, var12, 0.05);
    self setanimlimited(%lookat_head_adds, var13, 0.05);
    wait 0.05;
  }

  self setanimlimited(%lookat_left_right, 1, 0.05);
  self setanimlimited(%lookat_up_down, 1, 0.05);
  self setanimlimited(%lookat_head_base_partial, 10, 0.05);
  self setanimlimited(%head_gesture_look_partial, 10, 0.05);
  self setanimlimited(%lookat_head_adds, 1, 0.05);
  self.blend_up_in_progress = undefined;
}

function ai_gesture_torso_stop(var0) {
  self endon("death");
  self endon("start_gesture_torso_lookat");
  self endon("entitydeleted");
  self notify("gesture_stop_torso");

  if(!isDefined(self.is_torso_tracking)) {
    return;
  }

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 0.25;
  }

  var2 = gettime() / 1000;
  var3 = self getanimweight(self.torso_center_anim);
  var4 = self getanimweight(self.torso_right_anim);
  var5 = self getanimweight(self.torso_left_anim);
  var6 = self getanimweight(self.torso_rightback_anim);
  var7 = self getanimweight(self.torso_leftback_anim);

  while(gettime() / 1000 - var2 < var1) {
    var8 = (gettime() / 1000 - var2) / var1;
    var8 = smoothstep(0, 1, var8);
    var9 = lerp_float(var3, 1, var8);
    var10 = lerp_float(var4, 0, var8);
    var11 = lerp_float(var5, 0, var8);
    var12 = lerp_float(var6, 0, var8);
    var13 = lerp_float(var7, 0, var8);
    self setanimlimited(self.torso_center_anim, var9, 0.05);
    self setanimlimited(self.torso_right_anim, var10, 0.05);
    self setanimlimited(self.torso_left_anim, var11, 0.05);
    self setanimlimited(self.torso_rightback_anim, var12, 0.05);
    self setanimlimited(self.torso_leftback_anim, var13, 0.05);
    wait 0.05;
  }

  self setanimlimited(self.torso_center_anim, 1, 0.05);
  self setanimlimited(self.torso_right_anim, 0, 0.05);
  self setanimlimited(self.torso_left_anim, 0, 0.05);
  self setanimlimited(self.torso_rightback_anim, 0, 0.05);
  self setanimlimited(self.torso_leftback_anim, 0, 0.05);
  self clearanim(%torso_tracking_anims, var1);
  self.is_torso_tracking = undefined;
}

function ai_lookat_hold() {
  self.hold_lookat = 1;
}

function ai_lookat_release() {
  self.hold_lookat = undefined;
}

function ai_can_lookat() {
  if(isDefined(self.hold_lookat)) {
    return 0;
  }

  return 1;
}

function ai_gesture_lookat(var0, var1, var2) {
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
    var3 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var3 = undefined;
  }

  if(isDefined(self.anim_getrootfunc)) {
    store_old_root();
  }

  if(!isDefined(self.anim_getrootfunc)) {
    self.anim_getrootfunc = &set_root;
  }

  if(isDefined(var3)) {
    self.blend_in_time = var3;
  } else {
    self.blend_in_time = 0.7;
  }

  self.look_leftright_anim = undefined;
  self.look_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(var2)) {
    self.gesture_catchup_speed = clamp(var2, 0.25, 4);
  } else {
    self.gesture_catchup_speed = 0.5;
  }

  if(self.unittype == "c6") {
    use_c6_animtree();
  } else {
    self.look_leftright_anim = % prototype_gesture_look_rightleft;
    self.look_updown_anim = % prototype_gesture_look_updwn;
    self.head_center_anim = % gesture_head_fwd;
    self.head_right_anim = % gesture_head_right;
    self.head_left_anim = % gesture_head_left;
    self.head_rightback_anim = % gesture_head_rightback;
    self.head_leftback_anim = % gesture_head_leftback;
  }

  self.gesture_lookat = var1;

  if(self.unittype == "c6") {
    thread ai_gesture_head_leftright_c6();
    thread ai_gesture_head_updown_c6();
  } else {
    thread ai_gesture_head_leftright();
    thread ai_gesture_head_updown();
  }

  self.is_head_tracking = 1;
}

function ai_gesture_eyes_lookat(var0, var1, var2) {
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

  if(isDefined(var2)) {
    self.eye_blend_in_time = var2;
  } else {
    self.eye_blend_in_time = 0.3;
  }

  self.eyes_leftright_anim = undefined;
  self.eyes_updown_anim = undefined;
  self.lookat_aquired = 0;

  if(isDefined(var1)) {
    self.eye_catchup_speed = clamp(var1, 0.25, 4);
  } else {
    self.eye_catchup_speed = 2;
  }

  self.eyes_leftright_anim = % facial_gesture_look_rightleft;
  self.eyes_updown_anim = % facial_gesture_look_updwn;
  self.eyes_lookat = var0;
  thread ai_gesture_eyes_leftright();
  thread ai_gesture_eyes_updown();
  self.is_eye_tracking = 1;
}

function ai_gesture_lookat_torso(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self notify("start_gesture_torso_lookat");

  if(isai(self)) {
    var2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  } else {
    var2 = undefined;
  }

  if(!isDefined(var2)) {
    return;
  }

  if(isDefined(self.is_torso_tracking)) {
    ai_gesture_torso_stop(0.25);
    wait 0.25;
  }

  if(isDefined(var2)) {
    self.blend_in_time = var2;
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
  self.gesture_lookat = var1;
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

function ai_gesture_update_lookat(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self.gesture_lookat = var0;
  self.is_head_tracking = 1;

  if(isDefined(var1)) {
    var2 = self.gesture_catchup_speed;
    self.gesture_catchup_speed = var1;
    wait var1 * 2;
    self.gesture_catchup_speed = var2;
    return;
  }
}

function ai_gesture_lookat_natural(var0, var1, var2, var3) {
  self endon("gesture_natural_stop");
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");

  while(!ai_can_lookat()) {
    wait 0.05;
  }

  while(distance2d(self.origin, var0.origin) > var3) {
    wait 0.05;
  }

  thread ai_gesture_lookat(var0, var1, var2);
  wait var2;

  for(;;) {
    wait randomfloatrange(4, 5);

    if(distance2d(self.origin, var0.origin) <= var3) {
      thread ai_gesture_lookat_weight_down(1);
      thread ai_gesture_eyes_stop();
    }

    wait randomfloatrange(4, 6);

    while(!ai_can_lookat()) {
      wait 0.05;
    }

    if(distance2d(self.origin, var0.origin) <= var3) {
      thread ai_gesture_lookat_weight_up(0.5);
      thread ai_gesture_eyes_lookat(var0, 1, 0.2);
    }
  }
}

function ai_gesture_update_eyes_lookat(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self.eyes_lookat = var0;
  self.is_eye_tracking = 1;

  if(isDefined(var1)) {
    var2 = self.eye_catchup_speed;
    self.eye_catchup_speed = var1;
    wait var1 * 2;
    self.eye_catchup_speed = var2;
    return;
  }
}

function ai_gesture_head_leftright() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var0 = self.blend_in_time;
  var1 = gettime() / 1000;
  var2 = undefined;
  var3 = % lookat_left_right;
  var4 = self.head_center_anim;
  var5 = self.head_right_anim;
  var6 = self.head_left_anim;
  var7 = self.head_rightback_anim;
  var8 = self.head_leftback_anim;
  thread _ai_head_weight_blend_in();
  var2 = vectortoangles(level.player.origin - self.origin);
  self setanimlimited(var4, 1, self.blend_in_time);
  self setanimlimited(var5, 0.005, self.blend_in_time);
  self setanimlimited(var6, 0.005, self.blend_in_time);
  self setanimlimited(var7, 0.005, self.blend_in_time);
  self setanimlimited(var8, 0.005, self.blend_in_time);
  var9 = 0;
  var10 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.gesture_lookat)) {
      thread ai_gesture_stop(0.7);
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      var11 = level.player getEye();
    } else if(isai(self.gesture_lookat)) {
      var11 = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      var11 = self.gesture_lookat;
    } else {
      var11 = self.gesture_lookat.origin;
    }

    var12 = self gettagangles("J_Spine4") + (0, 0, 0);
    var13 = self gettagorigin("J_Spine4");
    var14 = vectorNormalize(var11 - var13);
    var15 = anglestoright(var12);
    var16 = anglestoup(var12);
    var17 = anglestoup(var12) * -1;
    var18 = anglestoright(var12) * -1;
    var19 = anglesToForward(var12);
    var20 = clamp(vectordot(var14, var15), 0.005, 1);
    var21 = clamp(vectordot(var14, var16), 0.005, 1);
    var22 = clamp(vectordot(var14, var17), 0.005, 1);
    var23 = clamp(vectordot(var14, var18), 0.005, 1);
    var24 = 1;

    if(scripts\engine\math::anglebetweenvectorssigned(var15, var14, var19) > 0) {
      var24 = 0;
    }

    self setanimlimited(var5, var21, self.gesture_catchup_speed);
    self setanimlimited(var6, var22, self.gesture_catchup_speed);
    self setanimlimited(var4, var20 + 0.005, self.gesture_catchup_speed);

    if(var24) {
      var9 = scripts\engine\math::lerp(var9, var23, 0.1);
      var10 = scripts\engine\math::lerp(var10, 0.005, 0.1);
    } else {
      var9 = scripts\engine\math::lerp(var9, 0.005, 0.1);
      var10 = scripts\engine\math::lerp(var10, var23, 0.1);
    }

    self setanimlimited(var7, var9, self.gesture_catchup_speed);
    self setanimlimited(var8, var10, self.gesture_catchup_speed);
    waitframe();
  }
}

function _ai_head_weight_blend_in() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var0 = gettime() / 1000;
  self.blend_up_in_progress = 1;

  while(gettime() / 1000 - var0 < self.blend_in_time * 2) {
    var1 = (gettime() / 1000 - var0) / self.blend_in_time * 2;
    var2 = smoothstep(0, 1, var1);
    var3 = smoothstep(0, 10, var1);
    var4 = lerp_float(0, 1, var2);
    var5 = lerp_float(0, 10, var2);
    self setanimlimited(%lookat_left_right, var4, 0.2);
    self setanimlimited(%lookat_up_down, var4, 0.2);
    self setanimlimited(%lookat_head_base_partial, var5, 0.2);
    self setanimlimited(%head_gesture_look_partial, var5, 0.2);
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
  var0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      var1 = 0;

      if(level.player getdemeanorviewmodel() == "safe") {
        var1 = 4.62;
      }

      var2 = level.player getEye() + anglestoup(self.angles) * var1;
    } else if(isai(self.gesture_lookat)) {
      var2 = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      var2 = self.gesture_lookat;
    } else {
      var2 = self.gesture_lookat.origin;
    }

    var3 = self gettagangles("J_Spine4") + (0, 0, 0);
    var4 = self gettagorigin("J_Spine4");
    var5 = undefined;

    if(isai(self)) {
      var5 = self getEye();
    } else {
      var5 = self gettagorigin("J_Head");
    }

    var6 = vectorNormalize(var2 - var5);
    var7 = anglesToForward(var3);
    var8 = vectordot(var7, var6);
    var9 = float_remap(var8, 1, -1, 0, 1);
    var0 += (var9 - var0) * self.gesture_catchup_speed * 0.3;
    var0 = clamp(var0, 0.1, 0.65);
    set_time_via_rate(self.look_updown_anim, var0);
    waitframe();
  }
}

function _ai_gesture_head_additives() {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  self setanimlimited(%lookat_head_adds, 1, 0.5);

  for(;;) {
    self setanimlimited(%shipcrib_gst_head_idle_01, 0.25, 0.5);
    wait getanimlength(%shipcrib_gst_head_idle_01) * randomfloatrange(1, 3);
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
  var0 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.eyes_lookat)) {
      ai_gesture_eyes_stop(0.25);
      break;
    }

    if(isPlayer(self.eyes_lookat)) {
      var1 = level.player getEye();
    } else if(isai(self.eyes_lookat)) {
      var1 = self.eyes_lookat getEye();
    } else if(isvector(self.eyes_lookat)) {
      var1 = self.eyes_lookat;
    } else {
      var1 = self.eyes_lookat.origin;
    }

    var2 = self gettagangles("j_head");
    var3 = self gettagorigin("j_head");
    var4 = self gettagangles("J_Spine4") + (0, 90, 0);
    var5 = vectorNormalize(var1 - var3);
    var6 = anglestoup(var2);
    var7 = scripts\engine\utility::flatten_vector(var5);
    var8 = scripts\engine\utility::flatten_vector(var6);
    var9 = vectordot(var8, var7);
    var10 = float_remap(var9, 1, -1, 0, 1);
    var11 = clamp(var10, 0, 1);
    self setanimtime(self.eyes_leftright_anim, var11);
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
  var0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.eyes_lookat)) {
      var1 = level.player getEye();
    } else if(isai(self.eyes_lookat)) {
      var1 = self.eyes_lookat getEye();
    } else if(isvector(self.eyes_lookat)) {
      var1 = self.eyes_lookat;
    } else {
      var1 = self.eyes_lookat.origin;
    }

    var2 = self gettagangles("j_head");
    var3 = self gettagorigin("j_head");
    var4 = self gettagangles("J_Spine4");
    var5 = anglesToForward(var2);
    var6 = vectorNormalize(var1 - var3);
    var7 = vectordot(var5, var6);
    var8 = float_remap(var7, 1, -1, 0.3, 0.7);
    var9 = clamp(var8, 0, 1);
    var0 += (var9 - var0) * self.eye_catchup_speed * 0.3;
    var0 = clamp(var0, 0.1, 0.9);
    set_time_via_rate(self.eyes_updown_anim, var0);
    waitframe();
  }
}

function ai_gesture_torso_leftright() {
  self endon("gesture_stop_torso");
  self endon("death");
  self endon("entitydeleted");
  var0 = undefined;
  var1 = % torso_tracking_anims;
  var2 = self.torso_center_anim;
  var3 = self.torso_right_anim;
  var4 = self.torso_left_anim;
  var5 = self.torso_rightback_anim;
  var6 = self.torso_leftback_anim;
  GscBinSkip4(0x35);
}

function _ai_torso_weight_blend_in() {
  var0 = gettime() / 1000;

  while(gettime() / 1000 - var0 < self.blend_in_time) {
    var1 = (gettime() / 1000 - var0) / self.blend_in_time;
    var1 = smoothstep(0, 1, var1);
    var2 = lerp_float(0, 1, var1);
    self setanimlimited(%torso_tracking_anims, var2, 0.05);
    wait 0.05;
    waittillframeend();
  }

  self setanimlimited(%torso_tracking_anims, 1, 0.05);
}

function ai_gesture_blink_loop(var0) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  ai_gesture_single_blink();

  for(;;) {
    wait randomfloatrange(var0 * 0.5, var0);
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

function ai_gesture_point(var0) {
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
  var1 = scripts\asm\asm::asm_getdemeanor();
  var2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  scripts\asm\asm_sp::asm_setupgesture(self.asmname, var2);

  if(var1 != "casual" && var1 != "casual_gun") {
    self.gesture_point_parent = % gesture_partials;
  } else {
    self.gesture_point_parent = % point_at_without_head;
  }

  if(!scripts\asm\asm::asm_currentstatehasflag(self.asmname, "gesture")) {
    return;
  } else if(var1 == "casual" || var1 == "combat" || var1 == "casual_gun" || var1 == "frantic") {
    self.point_center_anim = self.asm.gestures.gesture_point_center;
    self.point_left_anim = self.asm.gestures.gesture_point_left;
    self.point_right_anim = self.asm.gestures.gesture_point_right;
    self.point_up_anim = self.asm.gestures.gesture_point_up;
    self.point_down_anim = self.asm.gestures.gesture_point_down;
    self.gesture_body_knob = scripts\asm\asm::asm_getbodyknob();
  } else {
    return;
  }

  if(isPlayer(var0)) {
    var3 = level.player getEye();
  } else if(!isDefined(var1)) {
    var3 = self.origin;
    self.no_point_defined = 1;
  } else if(isai(var2)) {
    var3 = var2 getEye();
  } else if(isvector(var3)) {
    var3 = var3;
  } else {
    var3 = var3.origin;
  }

  var4 = self gettagangles("J_Spine4") + (0, 90, 0);
  var5 = self gettagorigin("J_Spine4");
  var6 = anglestoright(var4);
  var7 = anglestoup(var4);
  var8 = vectorNormalize(var3 - var5);
  var9 = scripts\engine\utility::flatten_vector(var6);
  var10 = scripts\engine\utility::flatten_vector(var7);
  var11 = scripts\engine\utility::flatten_vector(var8);
  var12 = vectordot(var9, var11) * -1;
  var13 = var12 * -1;
  var14 = clamp(float_remap(var12, 0.2, 1, 0, 1), 0, 1);
  var15 = clamp(float_remap(var13, 0.2, 1, 0, 1), 0, 1);
  var16 = self gettagorigin("J_Spine4");
  var17 = vectorNormalize(var3 - var16);
  var18 = anglesToForward(var4);
  var19 = vectordot(var17, var18);
  var20 = var19 * -1;
  var21 = vectordot(var7, var17);
  var22 = clamp(float_remap(var21, 0.2, 1, 0, 1), 0, 1);
  var23 = clamp(float_remap(var19, 0.2, 1, 0, 1), 0, 1);
  var24 = clamp(float_remap(var20, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(var21 < -0.9) {
      ai_gesture_simple("fallback_up");
    } else {
      if(var3 != "casual" && var3 != "casual_gun") {
        self setanimlimited(self.gesture_point_parent, 10, 0.25);
      } else {
        self setanimlimited(self.gesture_point_parent, 1, 0.25);
      }

      if(var22 < 0.3) {
        self setanimlimited(self.point_center_anim, 0, 0, 0.85);
      } else {
        self setanimlimited(self.point_center_anim, var22, 0.25, 0.85);
      }

      if(isDefined(self.point_up_anim)) {
        self setanimlimited(self.point_up_anim, var23, 0.25, 0.85);
      }

      if(isDefined(self.point_down_anim)) {
        self setanimlimited(self.point_down_anim, var24, 0.2, 0.85);
      }

      self setanimlimited(self.point_left_anim, var15, 0.25, 0.85);
      self setanimlimited(self.point_right_anim, var14, 0.25, 0.85);
    }
  } else {
    if(var3 != "casual" && var3 != "casual_gun") {
      self setanimlimited(self.gesture_point_parent, 10, 0.2);
    } else {
      self setanimlimited(self.gesture_point_parent, 1, 0.2);
    }

    self setanimlimited(self.point_center_anim, 1, 0.2, 0.85);
  }

  var25 = getanimlength(%prototype_gesture_point_center) * 0.85;
  wait var25;
  self clearanim(self.gesture_point_parent, 0.25);
  self setanimlimited(self.gesture_body_knob, 1, 0.25);
  self._blackboard.point_gesture_active = 0;
}

function ai_gesture_simple(var0) {
  self endon("death");
  self endon("entitydeleted");
  self.point_center_anim = undefined;
  self.gesture_body_knob = undefined;
  self.is_partial = 0;
  var1 = "casual";
  var2 = undefined;

  if(isai(self)) {
    self._blackboard.gesture_active = 1;
    var1 = scripts\asm\asm::asm_getdemeanor();
    var2 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  }

  var3 = ["shrug", "cross", "nod", "salute", "wave", "wait", "fallback_up"];
  var4 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var5 = ["move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];
  var6 = ["shrug", "cross", "nod", "salute", "wave", "wait", "move_up", "on_me", "hold", "fallback_up", "fallback_down", "arm_up"];

  if(!scripts\engine\utility::array_contains(var3, var0) && !scripts\engine\utility::array_contains(var4, var0)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isai(self) && !scripts\asm\asm::asm_currentstatehasflag(self.asmname, "gesture")) {
    return;
  } else if(isai(self)) {
    self.gesture_body_knob = scripts\asm\asm::asm_getbodyknob();

    if(var1 == "casual") {
      if(scripts\engine\utility::array_contains(var3, var0)) {
        self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
        self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
        self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
        self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
        self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
        self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
      } else {
        return;
      }
    } else if(var1 == "casual_gun") {
      if(scripts\engine\utility::array_contains(var6, var0)) {
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
        return;
      }
    } else if(var1 == "combat") {
      if(scripts\engine\utility::array_contains(var4, var0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        return;
      }
    } else if(var1 == "cqb") {
      if(scripts\engine\utility::array_contains(var5, var0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        return;
      }
    } else if(var1 == "frantic") {
      if(scripts\engine\utility::array_contains(var4, var0)) {
        self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
        self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
        self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
        self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
        self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
      } else {
        return;
      }
    } else {
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

  var7 = undefined;

  switch (var0) {
    case "shrug":
      var7 = self.gesture_shrug_anim;
      break;
    case "cross":
      var7 = self.gesture_cross_anim;
      break;
    case "nod":
      var7 = self.gesture_nod_anim;
      break;
    case "salute":
      var7 = self.gesture_salute_anim;
      break;
    case "wave":
      var7 = self.gesture_wave_anim;
      break;
    case "wait":
      var7 = self.gesture_wait_anim;
      break;
    case "hold":
      self.is_partial = 1;
      var7 = self.gesture_hold_anim;
      break;
    case "on_me":
      self.is_partial = 1;
      var7 = self.gesture_onme_anim;
      break;
    case "move_up":
      self.is_partial = 1;
      var7 = self.gesture_moveup_anim;
      break;
    case "fallback_up":
      self.is_partial = 1;
      var7 = self.gesture_fallback_up_anim;
      break;
    case "fallback_down":
      self.is_partial = 1;
      var7 = self.gesture_fallback_down_anim;
      break;
    case "arm_up":
      self.is_partial = 1;
      var7 = self.gesture_armup_anim;
      break;
  }

  if(self.is_partial) {
    self.simple_gesture_parent = % gesture_partials;
  } else {
    self.simple_gesture_parent = % add_gesture;
  }

  if(self.is_partial) {
    thread blend_partial_in(self.simple_gesture_parent, var7, 0.5);
  } else {
    self setanimlimited(self.simple_gesture_parent, 1, 0.5);
    self setanimlimited(var7, 1, 0.5, 0.75);
  }

  var8 = getanimlength(var7) * 0.85;
  wait var8;

  if(self.is_partial) {
    thread blend_partial_out(self.simple_gesture_parent, var7, 0.5);
  } else {
    self clearanim(self.simple_gesture_parent, 0.5);
    self clearanim(var7, 0.5);
  }

  self.is_partial = 0;

  if(isai(self)) {
    self._blackboard.gesture_active = undefined;
    return;
  }
}

function blend_partial_in(var0, var1, var2, var3) {
  var4 = var2 * 0.5;
  self setanimlimited(var0, 1, var4);
  self setanimlimited(var1, 1, var4, 0.75);
  wait var2 * 0.5;
  self setanimlimited(var1, 10, var4, 0.75);
  self setanimlimited(var0, 10, var4);
}

function blend_partial_out(var0, var1, var2) {
  var3 = var2 * 0.5;
  self setanimlimited(var0, 1, var3);
  self setanimlimited(var1, 1, var3);
  wait var3;
  self clearanim(var0, var3);
  self clearanim(var1, var3);
}

function float_remap(var0, var1, var2, var3, var4) {
  return (var0 - var1) / (var2 - var1) * (var4 - var3) + var3;
}

function lerp_float(var0, var1, var2) {
  return var0 + var2 * (var1 - var0);
}

function smoothstep(var0, var1, var2) {
  var2 = clamp((var2 - var0) / (var1 - var0), 0, 1);
  return var2 * var2 * (3 - 2 * var2);
}

function set_time_via_rate(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 0.25;
  }

  var4 = self getanimtime(var0);
  var5 = getanimlength(var0);
  var6 = (var1 - var4) * var5 / 0.05;

  if(self.unittype == "c6") {
    use_c6_animtree();
  }

  self setanimlimited(var0, var2, var3, var6);
}

function ai_gesture_directional_custom(var0, var1, var2) {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var3 = var1;
  var4 = var1[0];
  var5 = var1[1];
  var6 = var1[2];
  var7 = var1[3];
  var8 = var1[4];
  var9 = 0;
  var10 = undefined;
  self.no_point_defined = 0;
  var11 = undefined;

  if(isDefined(var2)) {
    var10 = scripts\asm\asm::asm_getbodyknob();
    var11 = % gesture_partials;
  } else {
    var11 = % add_gesture;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isPlayer(var0)) {
    var12 = level.player getEye();
  } else if(!isDefined(var1)) {
    var12 = self.origin;
    var10 = 1;
  } else if(isai(var2)) {
    var12 = var2 getEye();
  } else if(isvector(var3)) {
    var12 = var3;
  } else {
    var12 = var4.origin;
  }

  var13 = self gettagangles("tag_origin");
  var14 = self gettagorigin("tag_origin");
  var15 = anglestoright(var13);
  var16 = anglesToForward(var13);
  var17 = vectorNormalize(var12 - var14);
  var18 = scripts\engine\utility::flatten_vector(var15);
  var19 = scripts\engine\utility::flatten_vector(var16);
  var20 = scripts\engine\utility::flatten_vector(var17);
  var21 = vectordot(var18, var20);
  var22 = var21 * -1;
  var23 = clamp(float_remap(var21, 0.2, 1, 0, 1), 0, 1);
  var24 = clamp(float_remap(var22, 0.2, 1, 0, 1), 0, 1);
  var25 = self gettagorigin("J_Spine4");
  var26 = vectorNormalize(var12 - var25);
  var27 = anglestoup(var13);
  var28 = vectordot(var26, var27);
  var29 = var28 * -1;
  var30 = vectordot(var19, var26);
  var31 = clamp(float_remap(var30, 0.2, 1, 0, 1), 0, 1);
  var32 = clamp(float_remap(var28, 0.2, 1, 0, 1), 0, 1);
  var33 = clamp(float_remap(var29, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(isDefined(var6)) {
      self setanimlimited(var12, 10, 0.25);
    } else {
      self setanimlimited(var12, 1, 0.25);
    }

    if(var31 < 0.3) {
      self setanimlimited(var8, 0, 0, 1);
    } else {
      self setanimlimited(var8, var31, 0.25, 1);
    }

    if(isDefined(var11)) {
      self setanimlimited(var11, var32, 0.25, 1);
    }

    if(isDefined(var12)) {
      self setanimlimited(var12, var33, 0.25, 1);
    }

    self setanimlimited(var9, var24, 0.25, 1);
    self setanimlimited(var10, var23, 0.25, 1);
  } else {
    if(isDefined(var6)) {
      self setanimlimited(var12, 0.001, 0.1);
    }

    self setanimlimited(var12, 1, 0.25);
    self setanimlimited(var8, 1, 0.25);
  }

  var34 = getanimlength(var8);
  wait var34;
  self clearanim(var12, 0.25);
  self setanimlimited(var12, 1, 0.25);
}

function ai_custom_gesture(var0, var1) {
  self endon("death");
  self endon("gesture_stop");
  self endon("entitydeleted");
  var2 = % add_gesture;
  var3 = 0;
  var4 = "single anim";
  thread scripts\common\notetrack::start_notetrack_wait(self, var4, undefined, undefined, var0);

  if(isDefined(var1) && var1) {
    var2 = % gesture_partials;
    var3 = 1;
  }

  if(var3) {
    thread blend_partial_in(var2, var0, 0.2);
  } else {
    self setanimlimited(var2, 1, 0.1);
    self setanimlimited(var0, 1, 0.1);
  }

  var5 = getanimlength(var0) * 0.75 - 0.2;
  wait var5;

  if(var3) {
    thread blend_partial_out(var2, var0, 0.2);
    return;
  }

  self clearanim(var2, 0.2);
  self clearanim(var0, 0.2);
}

function use_c6_animtree() {
  self.look_leftright_anim = % prototype_gesture_look_rightleft;
  self.look_updown_anim = $prototype_gesture_look_updwn;
}

function ai_gesture_head_leftright_c6() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  var0 = self.blend_in_time;
  var1 = gettime() / 1000;

  while(gettime() / 1000 - var1 < var0) {
    var2 = (gettime() / 1000 - var1) / var0;
    var2 = smoothstep(0, 1, var2);
    var3 = lerp_float(0, 1, var2);
    var4 = lerp_float(0, 1, var2);
    var5 = lerp_float(0, 5, var2);
    var6 = lerp_float(0, 5, var2);
    self setanimlimited(%lookat_left_right, var3, 0.05);
    self setanimlimited(self.look_leftright_anim, var4, 0.05);
    self setanimlimited(%lookat_head_base_partial, var5, 0.05);
    self setanimlimited(%head_gesture_look_partial, var6, 0.05);
    self setanimtime(self.look_leftright_anim, 0.5);
    wait 0.05;
    waittillframeend();
  }

  self setanimlimited(%lookat_left_right, 1, 0.05);
  self setanimlimited(self.look_leftright_anim, 1, 0.05);
  self setanimlimited(%lookat_head_base_partial, 5, 0.05);
  self setanimlimited(%head_gesture_look_partial, 5, 0.05);
  var7 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      var8 = level.player getEye();
    } else if(isai(self.gesture_lookat)) {
      var8 = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      var8 = self.gesture_lookat;
    } else {
      var8 = self.gesture_lookat.origin;
    }

    var9 = self gettagangles("J_Head");
    var10 = self gettagorigin("J_Head");
    var11 = self gettagangles("J_Spine4") + (0, 90, 0);
    var12 = self gettagorigin("J_Spine4");
    var13 = vectorNormalize(var8 - var12);
    var14 = anglestoright(var11);
    var15 = scripts\engine\utility::flatten_vector(var14);
    var16 = scripts\engine\utility::flatten_vector(var13);
    var17 = vectordot(var15, var16);
    var18 = float_remap(var17, -1, 1, 0, 1);
    var18 = clamp(var18, 0, 1);
    var7 += (var18 - var7) * self.gesture_catchup_speed;
    var7 = clamp(var7, 0.1, 0.9);
    set_time_via_rate(self.look_leftright_anim, var7, 1);
    waitframe();
  }
}

function ai_gesture_head_updown_c6() {
  self endon("gesture_stop");
  self endon("death");
  self endon("entitydeleted");
  self setanimlimited(%lookat_up_down, 1, self.blend_in_time);
  self setanimlimited(self.look_updown_anim, 1, self.blend_in_time);
  self setanimtime(self.look_updown_anim, 0.5);
  var0 = 0.5;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(isPlayer(self.gesture_lookat)) {
      var1 = level.player getEye();
    } else if(isai(self.gesture_lookat)) {
      var1 = self.gesture_lookat getEye();
    } else if(isvector(self.gesture_lookat)) {
      var1 = self.gesture_lookat;
    } else {
      var1 = self.gesture_lookat.origin;
    }

    var2 = self gettagangles("J_Spine4") + (0, 0, 0);
    var3 = self gettagorigin("J_Spine4");
    var4 = undefined;

    if(isai(self)) {
      var4 = self getEye();
    } else {
      var4 = self gettagorigin("J_Head");
    }

    var5 = vectorNormalize(var1 - var4);
    var6 = anglesToForward(var2);
    var7 = vectordot(var6, var5);
    var8 = float_remap(var7, 1, -1, 0, 1);
    var0 += (var8 - var0) * self.gesture_catchup_speed * 0.3;
    var0 = clamp(var0, 0.1, 0.65);
    set_time_via_rate(self.look_updown_anim, var0);
    waitframe();
  }
}

function ai_gesture_stop_c6(var0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("gesture_stop");

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 0.25;
  }

  self setanimlimited(%lookat_left_right, 1, var1 * 0.15);
  self setanimlimited(%lookat_up_down, 1, var1 * 0.15);
  self setanimlimited(%lookat_head_base_partial, 1, var1 * 0.15);
  self setanimlimited(%head_gesture_look_partial, 1, var1 * 0.15);
  wait var1 * 0.15;
  self clearanim(%lookat_left_right, var1 * 0.85);
  self clearanim(%lookat_up_down, var1 * 0.85);
  self clearanim(%lookat_head_base_partial, var1 * 0.85);
  self clearanim(%head_gesture_look_partial, var1 * 0.85);
  self.is_head_tracking = undefined;
}

#using_animtree("generic_human");

function blended_loop_anim() {
  var0 = self;
  self endon(self.ender);
  var0.fwd_anim = undefined;
  var0.right_anim = undefined;
  var0.left_anim = undefined;
  var0.leftback_anim = undefined;
  var0.rightback_anim = undefined;

  foreach(var2 in var0.anim_array) {
    if(issubstr(var2, "forward")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.fwd_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "right") && !issubstr(var2, "back")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.right_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "left") && !issubstr(var2, "back")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.left_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "leftback")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.leftback_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "rightback")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.rightback_anim = level.scr_anim[var0.animname][var2];
      }
    }
  }

  var4 = getstartorigin(self.animnode.origin, self.animnode.angles, var0.fwd_anim);
  var5 = getstartangles(self.animnode.origin, self.animnode.angles, var0.fwd_anim);

  if(isai(var0)) {
    var0 forceteleport(var4, var5, 10000);
  } else {
    var0.origin = var4;
    var0.angles = var5;
  }

  var6 = vectortoangles(level.player.origin - var0.origin);
  var0 setanimknoball(var0.fwd_anim, %root, 1, 0.2);

  if(isDefined(var0.right_anim)) {
    var0 setanimlimited(var0.right_anim, 0, 0.2);
  }

  if(isDefined(var0.left_anim)) {
    var0 setanimlimited(var0.left_anim, 0, 0.2);
  }

  if(isDefined(var0.leftback_anim)) {
    var0 setanimlimited(var0.leftback_anim, 0, 0.2);
  }

  if(isDefined(var0.rightback_anim)) {
    var0 setanimlimited(var0.rightback_anim, 0, 0.2);
  }

  var7 = 0;
  var8 = 0;
  var0 pushplayer(1);

  for(;;) {
    if(!isDefined(var0)) {
      break;
    }

    if(isPlayer(var0.gesture_lookat)) {
      var9 = level.player getEye();
    } else if(isai(var0.gesture_lookat)) {
      var9 = var0.gesture_lookat getEye();
    } else if(isvector(var0.gesture_lookat)) {
      var9 = var0.gesture_lookat;
    } else {
      var9 = var0.gesture_lookat.origin;
    }

    var10 = var0 gettagangles("tag_origin");
    var11 = var0 gettagorigin("tag_origin");
    var12 = scripts\engine\utility::flatten_vector(vectorNormalize(var9 - var11));
    var13 = anglesToForward(var10);
    var14 = anglestoright(var10);
    var15 = anglestoright(var10) * -1;
    var16 = anglesToForward(var10) * -1;
    var17 = anglestoup(var10);
    var18 = clamp(vectordot(var12, var13), 0, 1);
    var19 = clamp(vectordot(var12, var14), 0, 1);
    var20 = clamp(vectordot(var12, var15), 0, 1);
    var21 = clamp(vectordot(var12, var16), 0, 1);
    var22 = 1;

    if(scripts\engine\math::anglebetweenvectorssigned(var13, var12, var17) > 0) {
      var22 = 0;
    }

    if(isDefined(var0.right_anim)) {
      var0 setanimlimited(var0.right_anim, var19, 0.2);
    }

    if(isDefined(var0.left_anim)) {
      var0 setanimlimited(var0.left_anim, var20, 0.2);
    }

    var0 setanimlimited(var0.fwd_anim, var18 + 0.005, 0.2);

    if(var22) {
      var7 = scripts\engine\math::lerp(var7, var21, 0.1);
      var8 = scripts\engine\math::lerp(var8, 0, 0.1);
    } else {
      var7 = scripts\engine\math::lerp(var7, 0, 0.1);
      var8 = scripts\engine\math::lerp(var8, var21, 0.1);
    }

    if(isDefined(var0.rightback_anim)) {
      var0 setanimlimited(var0.rightback_anim, var7 + 0.005, 0.2);
    }

    if(isDefined(var0.leftback_anim)) {
      var0 setanimlimited(var0.leftback_anim, var8 + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }
}

function blended_loop_cleanup() {
  var0 = self;

  if(isDefined(var0.ender)) {
    var0 notify(var0.ender);
  }

  var0 clearanim(var0.fwd_anim, 0.2);

  if(isDefined(var0.right_anim)) {
    var0 clearanim(var0.right_anim, 0.2);
  }

  if(isDefined(var0.left_anim)) {
    var0 clearanim(var0.left_anim, 0.2);
  }

  if(isDefined(var0.leftback_anim)) {
    var0 clearanim(var0.leftback_anim, 0.2);
  }

  if(isDefined(var0.rightback_anim)) {
    var0 clearanim(var0.rightback_anim, 0.2);
  }

  var0 pushplayer(0);
  var0.fwd_anim = undefined;
  var0.right_anim = undefined;
  var0.left_anim = undefined;
  var0.leftback_anim = undefined;
  var0.rightback_anim = undefined;
  var0.anim_array = undefined;
  var0.ender = undefined;
  var0.gesture_lookat = undefined;
}

#using_animtree("");

function blended_anim() {
  var0 = self;
  var0.fwd_anim = undefined;
  var0.right_anim = undefined;
  var0.left_anim = undefined;
  var0.leftback_anim = undefined;
  var0.rightback_anim = undefined;

  foreach(var2 in var0.anim_array) {
    if(issubstr(var2, "forward")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.fwd_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "right") && !issubstr(var2, "back")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.right_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "left") && !issubstr(var2, "back")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.left_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "leftback")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.leftback_anim = level.scr_anim[var0.animname][var2];
      }

      continue;
    }

    if(issubstr(var2, "rightback")) {
      if(isDefined(level.scr_anim[var0.animname][var2])) {
        var0.rightback_anim = level.scr_anim[var0.animname][var2];
      }
    }
  }

  var4 = getstartorigin(self.animnode.origin, self.animnode.angles, var0.fwd_anim);
  var5 = getstartangles(self.animnode.origin, self.animnode.angles, var0.fwd_anim);

  if(isai(var0)) {
    var0 forceteleport(var4, var5, 10000);
  } else {
    var0.origin = var4;
    var0.angles = var5;
  }

  var6 = vectortoangles(level.player.origin - var0.origin);
  var0 setanimknoball(var0.fwd_anim, %root, 1, 0.2);

  if(isDefined(var0.right_anim)) {
    var0 setanimlimited(var0.right_anim, 0, 0.2);
  }

  if(isDefined(var0.left_anim)) {
    var0 setanimlimited(var0.left_anim, 0, 0.2);
  }

  if(isDefined(var0.leftback_anim)) {
    var0 setanimlimited(var0.leftback_anim, 0, 0.2);
  }

  if(isDefined(var0.rightback_anim)) {
    var0 setanimlimited(var0.rightback_anim, 0, 0.2);
  }

  var7 = 0;
  var8 = 0;
  var9 = gettime() / 1000;
  var10 = getanimlength(var0.fwd_anim);

  while(gettime() / 1000 - var9 < var10) {
    if(!isDefined(var0)) {
      break;
    }

    if(isPlayer(var0.gesture_lookat)) {
      var11 = level.player getEye();
    } else if(isai(var0.gesture_lookat)) {
      var11 = var0.gesture_lookat getEye();
    } else if(isvector(var0.gesture_lookat)) {
      var11 = var0.gesture_lookat;
    } else {
      var11 = var0.gesture_lookat.origin;
    }

    var12 = var0 gettagangles("tag_origin");
    var13 = var0 gettagorigin("tag_origin");
    var14 = scripts\engine\utility::flatten_vector(vectorNormalize(var11 - var13));
    var15 = anglesToForward(var12);
    var16 = anglestoright(var12);
    var17 = anglestoright(var12) * -1;
    var18 = anglesToForward(var12) * -1;
    var19 = anglestoup(var12);
    var20 = clamp(vectordot(var14, var15), 0, 1);
    var21 = clamp(vectordot(var14, var16), 0, 1);
    var22 = clamp(vectordot(var14, var17), 0, 1);
    var23 = clamp(vectordot(var14, var18), 0, 1);
    var24 = 1;

    if(scripts\engine\math::anglebetweenvectorssigned(var15, var14, var19) > 0) {
      var24 = 0;
    }

    if(isDefined(var0.right_anim)) {
      var0 setanimlimited(var0.right_anim, var21, 0.2);
    }

    if(isDefined(var0.left_anim)) {
      var0 setanimlimited(var0.left_anim, var22, 0.2);
    }

    var0 setanimlimited(var0.fwd_anim, var20 + 0.005, 0.2);

    if(var24) {
      var7 = scripts\engine\math::lerp(var7, var23, 0.1);
      var8 = scripts\engine\math::lerp(var8, 0, 0.1);
    } else {
      var7 = scripts\engine\math::lerp(var7, 0, 0.1);
      var8 = scripts\engine\math::lerp(var8, var23, 0.1);
    }

    if(isDefined(var0.rightback_anim)) {
      var0 setanimlimited(var0.rightback_anim, var7 + 0.005, 0.2);
    }

    if(isDefined(var0.leftback_anim)) {
      var0 setanimlimited(var0.leftback_anim, var8 + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }

  thread blended_loop_cleanup();
}