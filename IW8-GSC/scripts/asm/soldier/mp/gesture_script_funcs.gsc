/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\gesture_script_funcs.gsc
***********************************************************/

function checkbcstatevalid(var0, var1, var2, var3) {
  return false;
}

function choosebcdirectionanim(var0, var1, var2) {}

function playbcanim(var0, var1, var2) {}

function initgesture(var0, var1, var2, var3) {}

function playgestureanim(var0, var1, var2, var3) {}

function choosegestureanim(var0, var1, var2, var3) {}

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

function ai_gesture_stop(var0) {}

function ai_gesture_eyes_stop(var0) {}

function ai_gesture_lookat_weight_down(var0) {}

function ai_gesture_lookat_weight_up(var0) {}

function ai_gesture_torso_stop(var0) {}

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

function ai_gesture_lookat(var0, var1, var2) {}

function ai_gesture_eyes_lookat(var0, var1, var2) {}

function ai_gesture_lookat_torso(var0, var1) {}

function set_root() {}

function store_old_root() {}

function reset_root() {}

function ai_gesture_update_lookat(var0, var1) {}

function ai_gesture_lookat_natural(var0, var1, var2, var3) {}

function ai_gesture_update_eyes_lookat(var0, var1) {}

function ai_gesture_head_leftright() {}

function _ai_head_weight_blend_in() {}

function ai_gesture_head_updown() {}

function _ai_gesture_head_additives() {}

function ai_gesture_eyes_leftright() {}

function ai_gesture_eyes_updown() {}

function ai_gesture_torso_leftright() {}

function _ai_torso_weight_blend_in() {}

function ai_gesture_blink_loop(var0) {}

function ai_gesture_single_blink() {}

function ai_gesture_point(var0) {}

function ai_gesture_simple(var0) {}

function blend_partial_in(var0, var1, var2, var3) {}

function blend_partial_out(var0, var1, var2) {}

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

function set_time_via_rate(var0, var1, var2, var3) {}

function ai_gesture_directional_custom(var0, var1, var2) {}

function ai_custom_gesture(var0, var1) {}

function use_c6_animtree() {}

function ai_gesture_head_leftright_c6() {}

function ai_gesture_head_updown_c6() {}

function ai_gesture_stop_c6(var0) {}

function blended_loop_anim() {}

function blended_loop_cleanup() {}

function blended_anim() {}