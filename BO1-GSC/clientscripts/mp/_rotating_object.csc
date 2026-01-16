/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_rotating_object.csc
*************************************************/

#include clientscripts\mp\_utility;

init(localClientNum) {
  rotating_objects = GetEntArray(localClientNum, "rotating_object", "targetname");
  array_thread(rotating_objects, ::rotating_object_think);
}
rotating_object_think() {
  self endon("entityshutdown");
  change_spin = 0;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "roll") {
    change_spin = 1;
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "pitch") {
    change_spin = 2;
  }
  while (1) {
    rotate_time = GetDvarFloat(#"scr_rotating_objects_secs");
    if(rotate_time == 0) {
      rotate_time = 12;
    }
    if(isDefined(self.script_float) && (rotate_time == 12)) {
      rotate_time = self.script_float;
    }
    if(rotate_time > 0) {
      switch (change_spin) {
        case 0:
          self RotateYaw(360, rotate_time);
          break;
        case 1:
          self RotateRoll(360, rotate_time);
          break;
        case 2:
          self RotatePitch(360, rotate_time);
          break;
        default:
          break;
      }
    } else {
      switch (change_spin) {
        case 0:
          self RotateYaw(-360, Abs(rotate_time));
          break;
        case 1:
          self RotateRoll(-360, Abs(rotate_time));
          break;
        case 2:
          self RotatePitch(-360, Abs(rotate_time));
          break;
        default:
          break;
      }
    }
    self waittill("rotatedone");
  }
}