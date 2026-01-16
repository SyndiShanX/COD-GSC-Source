/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\hunted_windmill.gsc
********************************/

main() {
  common_scripts\utility::run_thread_on_noteworthy("windmill_wheel", ::windmill_wheel_setup);
}

windmill_wheel_setup() {
  self.rotate_speed = 1.0;
  self enablequatinterpolationrotation(1);
  var_0 = getent(self.target, "targetname");

  if(!isdefined(var_0)) {}

  self linkto(var_0);
  thread windmill_wheel_think();
  var_0 thread windmill_top_setup();
}

windmill_top_setup() {
  self.min_time = 0.1;
  self.max_time = 1.0;
  thread windmill_top_think();
}

windmill_wheel_think() {
  self endon("deleting");

  for (;;) {
    self rotatebylinked((30, 0, 0), self.rotate_speed);
    wait(self.rotate_speed);
  }
}

windmill_top_think() {
  self endon("deleting");
  var_0 = 1.5;

  for (;;) {
    var_1 = randomfloatrange(self.min_time, self.max_time);
    var_0 = var_0 * -1;
    self rotateyaw(var_0, var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
  }
}