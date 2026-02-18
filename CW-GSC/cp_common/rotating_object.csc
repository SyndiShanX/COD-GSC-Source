/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\rotating_object.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace rotating_object;

function private autoexec __init__system__() {
  system::register(#"rotating_object", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_localclient_connect(&main);
}

function main(localclientnum) {
  rotating_objects = getEntArray(localclientnum, "rotating_object", "targetname");
  array::thread_all(rotating_objects, &rotating_object_think);
}

function rotating_object_think() {
  self endon(#"death");
  util::waitforallclients();
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

  angles = self.angles;

  while(true) {
    switch (axis) {
      case # "roll":
        self rotateroll(direction * revolutions, rotate_time * revolutions);
        break;
      case # "pitch":
        self rotatepitch(direction * revolutions, rotate_time * revolutions);
        break;
      case # "yaw":
      default:
        self rotateyaw(direction * revolutions, rotate_time * revolutions);
        break;
    }

    self waittill(#"rotatedone");
    self.angles = angles;
  }
}