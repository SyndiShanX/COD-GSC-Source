/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\gesture_script_funcs.gsc
***********************************************************/

function checkbcstatevalid(var_0, var_1, var_2, var_3) {
  return false;
}

function choosebcdirectionanim(var_0, var_1, var_2) {}

function playbcanim(var_0, var_1, var_2) {}

function initgesture(var_0, var_1, var_2, var_3) {}

function playgestureanim(var_0, var_1, var_2, var_3) {}

function choosegestureanim(var_0, var_1, var_2, var_3) {}

function ai_gesture_requested(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.gesture_active);
}

function ai_point_gesture_requested(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.point_gesture_active);
}

function _is_looking_at_range(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectorNormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 >= var_1) {
    return 1;
  }

  return 0;
}

function get_anim_direction(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = angleclamp180(var_3[1] - var_0[1]);
  var_5 = getangleindex(var_4, 10);
  var_6 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return var_6[var_5];
}

function ai_gesture_stop(var_0) {}

function ai_gesture_eyes_stop(var_0) {}

function ai_gesture_lookat_weight_down(var_0) {}

function ai_gesture_lookat_weight_up(var_0) {}

function ai_gesture_torso_stop(var_0) {}

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

function ai_gesture_lookat(var_0, var_1, var_2) {}

function ai_gesture_eyes_lookat(var_0, var_1, var_2) {}

function ai_gesture_lookat_torso(var_0, var_1) {}

function set_root() {}

function store_old_root() {}

function reset_root() {}

function ai_gesture_update_lookat(var_0, var_1) {}

function ai_gesture_lookat_natural(var_0, var_1, var_2, var_3) {}

function ai_gesture_update_eyes_lookat(var_0, var_1) {}

function ai_gesture_head_leftright() {}

function _ai_head_weight_blend_in() {}

function ai_gesture_head_updown() {}

function _ai_gesture_head_additives() {}

function ai_gesture_eyes_leftright() {}

function ai_gesture_eyes_updown() {}

function ai_gesture_torso_leftright() {}

function _ai_torso_weight_blend_in() {}

function ai_gesture_blink_loop(var_0) {}

function ai_gesture_single_blink() {}

function ai_gesture_point(var_0) {}

function ai_gesture_simple(var_0) {}

function blend_partial_in(var_0, var_1, var_2, var_3) {}

function blend_partial_out(var_0, var_1, var_2) {}

function float_remap(var_0, var_1, var_2, var_3, var_4) {
  return (var_0 - var_1) / (var_2 - var_1) * (var_4 - var_3) + var_3;
}

function lerp_float(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

function smoothstep(var_0, var_1, var_2) {
  var_2 = clamp((var_2 - var_0) / (var_1 - var_0), 0, 1);
  return var_2 * var_2 * (3 - 2 * var_2);
}

function set_time_via_rate(var_0, var_1, var_2, var_3) {}

function ai_gesture_directional_custom(var_0, var_1, var_2) {}

function ai_custom_gesture(var_0, var_1) {}

function use_c6_animtree() {}

function ai_gesture_head_leftright_c6() {}

function ai_gesture_head_updown_c6() {}

function ai_gesture_stop_c6(var_0) {}

function blended_loop_anim() {}

function blended_loop_cleanup() {}

function blended_anim() {}