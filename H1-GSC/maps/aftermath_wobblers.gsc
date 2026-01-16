/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\aftermath_wobblers.gsc
***************************************/

main() {
  common_scripts\utility::run_thread_on_targetname("wobbler", ::wobbler_setup);
}

setup_linked_ent() {
  if(isdefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isdefined(var_0))
      self linkto(var_0);
    else {

    }
  }
}

wobbler_setup() {
  var_0 = 5;
  var_1 = 3;
  var_2 = 2;
  setup_linked_ent();

  if(isdefined(self.script_max_right_angle))
    var_0 = self.script_max_right_angle;

  if(isdefined(self.script_max_left_angle))
    var_1 = self.script_max_left_angle;

  if(isdefined(self.script_wheeldirection)) {
    if(-1 < self.script_wheeldirection && self.script_wheeldirection < 3)
      var_2 = self.script_wheeldirection;
  }

  self.axis = var_2;

  if(self islinked()) {
    self.max_angles = var_0;
    self.min_angles = var_1;
    self.start_angle = 0;
    thread wobbler_linked_think();
  } else {
    self.max_angles = self.angles[self.axis] + var_0;
    self.min_angles = self.angles[self.axis] - var_1;
    self.start_angle = self.angles[self.axis];
    thread wobbler_think();
  }
}

pick_new_target_angle(var_0) {
  if(var_0 > self.start_angle)
    return randomfloatrange(self.min_angles, self.start_angle);
  else
    return randomfloatrange(self.start_angle, self.max_angles);
}

update_angles_vector_from_axis(var_0, var_1, var_2) {
  switch (var_0) {
    case 0:
      return (var_2, var_1[1], var_1[2]);
    case 1:
      return (var_1[0], var_2, var_1[2]);
    case 2:
      return (var_1[0], var_1[1], var_2);
  }

  return var_1;
}

wobbler_think() {
  self endon("deleting");
  var_0 = pick_new_target_angle(self.angles[self.axis]);

  for (;;) {
    var_1 = randomfloatrange(0.75, 2.0);
    var_0 = pick_new_target_angle(self.angles[self.axis]);
    var_2 = update_angles_vector_from_axis(self.axis, self.angles, var_0);
    self rotateto(var_2, var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
  }
}

local_update_angles_vector_from_axis(var_0, var_1) {
  switch (var_0) {
    case 0:
      return (var_1, 0, 0);
    case 1:
      return (0, var_1, 0);
    case 2:
      return (0, 0, var_1);
  }

  return (0, 0, 0);
}

wobbler_linked_think() {
  var_0 = self.max_angles;

  for (;;) {
    var_1 = randomfloatrange(0.125, 0.25);
    var_2 = local_update_angles_vector_from_axis(self.axis, var_0);
    self rotatebylinked(var_2, var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
    var_0 = var_0 * -1;
  }
}