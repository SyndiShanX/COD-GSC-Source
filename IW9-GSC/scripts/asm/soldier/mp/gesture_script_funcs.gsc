/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\gesture_script_funcs.gsc
***********************************************************/

checkbcstatevalid(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

choosebcdirectionanim(asmname, statename, params) {}

playbcanim(asmname, statename, params) {}

initgesture(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return;
}

playgestureanim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return;
}

choosegestureanim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return;
}

ai_gesture_requested(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._blackboard.gesture_active);
}

ai_point_gesture_requested(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._blackboard.point_gesture_active);
}

_is_looking_at_range(_id_8D206297C3CB29D4, range) {
  _id_70222FBC47330166 = anglesToForward(level.player.angles);
  _id_BAC0559FEED06173 = vectorNormalize(_id_8D206297C3CB29D4.origin - level.player.origin);
  _id_FCE87949C9B65851 = vectordot(_id_70222FBC47330166, _id_BAC0559FEED06173);

  if(_id_FCE87949C9B65851 >= range)
    return 1;
  else
    return 0;
}

get_anim_direction(_id_4C44BD3C9BAC5AE2, _id_88DAF353E30ACF25, targetorigin) {
  _id_87617967D6BB7D22 = vectortoangles(targetorigin - _id_88DAF353E30ACF25);
  _id_077B9E4B599269EB = angleclamp180(_id_87617967D6BB7D22[1] - _id_4C44BD3C9BAC5AE2[1]);
  angleindex = getangleindex(_id_077B9E4B599269EB, 10);
  _id_84544112C7C95FBA = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  return _id_84544112C7C95FBA[angleindex];
}

ai_gesture_stop(_id_480E0D93B559931C) {}

ai_gesture_eyes_stop(_id_480E0D93B559931C) {}

ai_gesture_lookat_weight_down(_id_D775E14980E96400) {}

ai_gesture_lookat_weight_up(_id_D775E14980E96400) {}

ai_gesture_torso_stop(_id_480E0D93B559931C) {}

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

ai_gesture_lookat(_id_968583169A58B079, _id_EBC28D027B66FD81, blend_in_time) {}

ai_gesture_eyes_lookat(_id_968583169A58B079, _id_EBC28D027B66FD81, blend_in_time) {}

ai_gesture_lookat_torso(_id_968583169A58B079, blend_in_time) {}

set_root() {}

store_old_root() {}

reset_root() {}

ai_gesture_update_lookat(_id_3E53E7E020018FC0, _id_809D5BBB11B6031C) {}

ai_gesture_lookat_natural(_id_968583169A58B079, _id_EBC28D027B66FD81, blend_in_time, _id_1134633B00730D29) {}

ai_gesture_update_eyes_lookat(_id_3E53E7E020018FC0, _id_809D5BBB11B6031C) {}

ai_gesture_head_leftright() {}

_ai_head_weight_blend_in() {}

ai_gesture_head_updown() {}

_ai_gesture_head_additives() {}

ai_gesture_eyes_leftright() {}

ai_gesture_eyes_updown() {}

ai_gesture_torso_leftright() {}

_ai_torso_weight_blend_in() {}

ai_gesture_blink_loop(_id_25362A792B0E1353) {}

ai_gesture_single_blink() {}

ai_gesture_point(_id_4A32ECBAA6C22F70) {}

ai_gesture_simple(_id_7CA8D1CE367054F8) {}

blend_partial_in(_id_10C67B12BE486D55, animation, _id_D775E14980E96400, notetrack) {}

blend_partial_out(_id_10C67B12BE486D55, animation, _id_6E2597877D503152) {}

float_remap(value, _id_CFFD6E654A5673E8, _id_E9731D032A86C293, _id_CFFD71654A567A81, _id_E9731E032A86C4C6) {
  return (value - _id_CFFD6E654A5673E8) / (_id_E9731D032A86C293 - _id_CFFD6E654A5673E8) * (_id_E9731E032A86C4C6 - _id_CFFD71654A567A81) + _id_CFFD71654A567A81;
}

lerp_float(from, to, _id_3777ECE6A73EADA5) {
  return from + _id_3777ECE6A73EADA5 * (to - from);
}

smoothstep(start, end, _id_3777ECE6A73EADA5) {
  _id_3777ECE6A73EADA5 = clamp((_id_3777ECE6A73EADA5 - start) / (end - start), 0.0, 1.0);
  return _id_3777ECE6A73EADA5 * _id_3777ECE6A73EADA5 * (3 - 2 * _id_3777ECE6A73EADA5);
}

set_time_via_rate(anime, time, weight, _id_D775E14980E96400) {}

ai_gesture_directional_custom(target, anim_array, _id_4E9E76B78D716037) {}

ai_custom_gesture(_id_4EDB516A81E6B468, _id_4E9E76B78D716037) {}

use_c6_animtree() {}

ai_gesture_head_leftright_c6() {}

ai_gesture_head_updown_c6() {}

ai_gesture_stop_c6(_id_480E0D93B559931C) {}

blended_loop_anim() {}

blended_loop_cleanup() {}

blended_anim() {}