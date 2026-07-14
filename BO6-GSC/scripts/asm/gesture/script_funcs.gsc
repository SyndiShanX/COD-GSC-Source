/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\gesture\script_funcs.gsc
************************************************/

#namespace script_funcs;

function ai_gesture_requested(asmname, statename, tostatename, params) {
  return istrue(self._blackboard.gesture_active);
}

function ai_point_gesture_requested(asmname, statename, tostatename, params) {
  return istrue(self._blackboard.point_gesture_active);
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