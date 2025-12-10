/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_rotating_object.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace rotating_object;

function autoexec __init__sytem__() {
  system::register("rotating_object", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_localclient_connect(&init);
}

function init(localclientnum) {
  rotating_objects = getEntArray(localclientnum, "rotating_object", "targetname");
  array::thread_all(rotating_objects, &rotating_object_think);
}

function rotating_object_think() {
  self endon("entityshutdown");
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
    direction = direction * -1;
    rotate_time = rotate_time * -1;
  }
  angles = self.angles;
  while(true) {
    switch (axis) {
      case "roll": {
        self rotateroll(direction * revolutions, rotate_time * revolutions);
        break;
      }
      case "pitch": {
        self rotatepitch(direction * revolutions, rotate_time * revolutions);
        break;
      }
      case "yaw":
      default: {
        self rotateyaw(direction * revolutions, rotate_time * revolutions);
        break;
      }
    }
    self waittill("rotatedone");
    self.angles = angles;
  }
}