/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\hanging_light_off.gsc
*********************************************************/

main() {
  if(common_scripts\utility::issp()) {
    common_scripts\_destructible::destructible_create("toy_hanging_light_off", "tag_origin", 0);
    common_scripts\_destructible::destructible_function(::hanging_light_off);
  }
}

hanging_light_off() {
  var_0 = self.angles;
  var_1 = anglesToForward(var_0);
  var_2 = (var_1[1], var_1[0], 0);
  var_1 = (var_1[0], -1 * var_1[1], 0);

  if(isDefined(self.script_angles)) {
    var_3 = (self.script_angles[2], self.script_angles[0], self.script_angles[1]);
  }
  else {
    var_3 = (90, 90, 90);
  }

  if(isDefined(self.script_duration)) {
    var_4 = self.script_duration / 6 * randomfloatrange(0.9, 1.1);
  }
  else {
    var_4 = 0.4 * randomfloatrange(0.9, 1.1);
  }

  var_4 = int(var_4 * 20) / 20;

  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_6) && var_6 == self) {
      continue;
    }
    var_9 = destructible_scripts\toy_lv_trash_can_vegas::destructible_modifydamagetype(var_9);
    var_10 = [];

    if(var_9 == "splash") {
      var_7 = vectornormalize(var_7);
      var_8 = (randomfloatrange(-100, 100), randomfloatrange(-100, 100), -400);
      var_8 = var_8 * var_4;
      var_8 = var_8 + self.origin;
    }

    var_11 = vectorfromlinetopoint(var_8, var_8 + var_7, self.origin);

    for(var_12 = 0; var_12 < 3; var_12++) {
      var_13 = maps\interactive_models\_interactive_utility::zerocomponent(var_11, var_12);
      var_13 = maps\interactive_models\_interactive_utility::rotate90aroundaxis(var_13, var_12);
      var_14 = maps\interactive_models\_interactive_utility::zerocomponent(var_7, var_12);
      var_10[var_12] = vectordot(var_13, var_14);
    }

    var_10 = var_10[0] * var_1 + var_10[1] * var_2 + (0, 0, var_10[2]);
    var_10 = var_10 / (var_4 * var_4 * 40);
    self notify("new swing");
    thread hanging_light_swing((var_10[1], var_10[2], var_10[0]), var_0, var_4, var_3);
  }
}

hanging_light_swing(var_0, var_1, var_2, var_3) {
  self endon("new swing");
  var_4 = self.angles + var_0;
  var_4 = (clamp(var_4[0], var_1[0] - var_3[0], var_1[0] + var_3[0]), clamp(var_4[1], var_1[1] - var_3[1], var_1[1] + var_3[1]), clamp(var_4[2], var_1[2] - var_3[2], var_1[2] + var_3[2]));
  var_5 = length(var_4 - self.angles) / length(var_0);
  var_5 = var_5 * var_2;
  var_5 = int(var_5 * 20) / 20;

  if(var_5 < 0.1) {
    var_5 = 0.1;
  }

  self rotateto(var_4, var_5 * 3 / 2, 0, var_5);
  wait(var_5 * 3 / 2);
  var_0 = var_4 - var_1;
  var_6 = max(max(abs(var_0[0]), abs(var_0[1])), abs(var_0[2]));

  while(var_0[0] != 0 || var_0[1] != 0 || var_0[2] != 0) {
    var_7 = (var_6 * 0.9 - 0.5) / var_6;

    if(var_7 < 0) {
      var_7 = 0;
    }

    var_6 = var_6 * var_7;
    var_0 = var_0 * (var_7 * -1);
    var_4 = var_1 + var_0;
    self rotateto(var_4, var_2 * 3, var_2, var_2);
    wait(var_2 * 3);
  }
}