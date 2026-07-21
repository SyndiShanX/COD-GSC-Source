/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\mp\gesture_script_funcs.gsc
***************************************************/

checkbcstatevalid(var_0, var_1, var_2, var_3) {
  return 0;
}

choosebcdirectionanim(var_0, var_1, var_2) {}

playbcanim(var_0, var_1, var_2) {}

initgesture(var_0, var_1, var_2, var_3) {
  return;
}

playgestureanim(var_0, var_1, var_2, var_3) {
  return;
}

choosegestureanim(var_0, var_1, var_2, var_3) {
  return;
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
  var_6 = ["_encstr_A74C0222", "_encstr_A14C023B", "_encstr_8F4C026A", "_encstr_8B4C0227", "_encstr_864C02F9", "_encstr_914C02DC", "_encstr_AC4C024A", "_encstr_A34C02BB", "_encstr_A74C0222"];
  return var_6[var_5];
}

ai_gesture_stop(var_0) {}

ai_gesture_eyes_stop(var_0) {}

ai_gesture_lookat_weight_down(var_0) {}

ai_gesture_lookat_weight_up(var_0) {}

ai_gesture_torso_stop(var_0) {}

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

ai_gesture_lookat(var_0, var_1, var_2) {}

ai_gesture_eyes_lookat(var_0, var_1, var_2) {}

ai_gesture_lookat_torso(var_0, var_1) {}

set_root() {}

store_old_root() {}

reset_root() {}

ai_gesture_update_lookat(var_0, var_1) {}

ai_gesture_lookat_natural(var_0, var_1, var_2, var_3) {}

ai_gesture_update_eyes_lookat(var_0, var_1) {}

ai_gesture_head_leftright() {}

_ai_head_weight_blend_in() {}

ai_gesture_head_updown() {}

_ai_gesture_head_additives() {}

ai_gesture_eyes_leftright() {}

ai_gesture_eyes_updown() {}

ai_gesture_torso_leftright() {}

_ai_torso_weight_blend_in() {}

ai_gesture_blink_loop(var_0) {}

ai_gesture_single_blink() {}

ai_gesture_point(var_0) {}

ai_gesture_simple(var_0) {}

blend_partial_in(var_0, var_1, var_2, var_3) {}

blend_partial_out(var_0, var_1, var_2) {}

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

set_time_via_rate(var_0, var_1, var_2, var_3) {}

ai_gesture_directional_custom(var_0, var_1, var_2) {}

ai_custom_gesture(var_0, var_1) {}

use_c6_animtree() {}

ai_gesture_head_leftright_c6() {}

ai_gesture_head_updown_c6() {}

ai_gesture_stop_c6(var_0) {}

blended_loop_anim() {}

blended_loop_cleanup() {}

blended_anim() {}