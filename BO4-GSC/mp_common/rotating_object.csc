/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\rotating_object.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace rotating_object;

autoexec __init__system__() {
  system::register(#"rotating_object", &__init__, undefined, undefined);
}

__init__() {
  callback::on_localclient_connect(&init);
}

init(localclientnum) {
  rotating_objects = getEntArray(localclientnum, "rotating_object", "targetname");
  array::thread_all(rotating_objects, &rotating_object_think);
}

rotating_object_think() {
  self endon(#"death");
  util::waitforallclients();
  util::function_89a98f85();
  axis = "yaw";
  direction = 360;
  revolutions = 100;
  rotate_time = 12;

  if(isDefined(self.script_noteworthy)) {
    axis = self.script_noteworthy;
  }

  if(isDefined(self.script_float)) {
    rotate_time = self.script_float;
  }

  if(rotate_time == 0) {
    rotate_time = 12;
  }

  if(rotate_time < 0) {
    direction *= -1;
    rotate_time *= -1;
  }

  if(isDefined(self.angles)) {
    angles = self.angles;
  } else {
    angles = (0, 0, 0);
  }

  while(true) {
    switch (axis) {
      case #"roll":
        self rotateroll(direction * revolutions, rotate_time * revolutions);
        break;
      case #"pitch":
        self rotatepitch(direction * revolutions, rotate_time * revolutions);
        break;
      case #"yaw":
      default:
        self rotateyaw(direction * revolutions, rotate_time * revolutions);
        break;
    }

    self waittill(#"rotatedone");
    self.angles = angles;
  }
}