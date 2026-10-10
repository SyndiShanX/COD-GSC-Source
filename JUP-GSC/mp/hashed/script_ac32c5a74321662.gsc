/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_ac32c5a74321662.gsc
************************************************/

#using scripts\engine\utility;
#namespace namespace_a9f18099144e93ba;

function function_a9a0b485d2e58d71() {
  thread function_524af1d56cb60f38();
}

function function_524af1d56cb60f38() {
  self endon("death");

  while(true) {
    self waittill("float_move_loop_start");
    thread function_43bd4a976c1ed3de();
  }
}

function function_43bd4a976c1ed3de() {
  self endon("death");
  self.var_7177dd881b296d3 = undefined;
  self.var_37ca4842bca3031c = gettime();

  while(true) {
    waitframe();

    if(!isDefined(self.var_17e48b8b7457c) || self.var_17e48b8b7457c.current_index >= self.var_17e48b8b7457c.points.size - 1) {
      clear_float_move();
      return;
    }

    speed = self.var_17e48b8b7457c.speed;
    current_index = self.var_17e48b8b7457c.current_index;
    start_point = self.var_17e48b8b7457c.points[current_index];
    next_point = self.var_17e48b8b7457c.points[current_index + 1];
    delta_z = next_point[2] - start_point[2];
    total_length = length(next_point - start_point);
    var_35761ff94239aeb5 = length2d(next_point - start_point);
    var_3fc17f20be7dce79 = next_point - self.origin;
    var_545ae14048828eed = length(var_3fc17f20be7dce79);
    var_9a9a0f5df2182638 = length2d(var_3fc17f20be7dce79);
    percentage = 1 - var_545ae14048828eed / total_length;
    percentage_2d = 1 - var_9a9a0f5df2182638 / var_35761ff94239aeb5;
    speed_percentage = 1;

    if(percentage < 0.5) {
      speed_percentage = 0.7 + easesine(percentage / 0.5, 1, 0) * 0.3;
    } else {
      speed_percentage = max(1 - easesine((percentage - 0.5) / 0.5, 1, 0), 0.2);
    }

    speed *= speed_percentage;
    var_1e6385adc65df44c = (var_3fc17f20be7dce79[0], var_3fc17f20be7dce79[1], 0);

    if(var_545ae14048828eed > self.var_17e48b8b7457c.speed) {
      new_origin = self.origin + vectorNormalize(var_1e6385adc65df44c) * speed;

      if(delta_z < var_35761ff94239aeb5) {
        z_percentage = easesine(percentage_2d, 1, 1);
      } else {
        z_percentage = easepower(percentage_2d, 2, 0, 1);
      }

      new_origin = (new_origin[0], new_origin[1], start_point[2] + delta_z * z_percentage);
    } else {
      new_origin = next_point;
      self.var_17e48b8b7457c.current_index = current_index + 1;
    }

    if(isDefined(self.var_7177dd881b296d3)) {
      var_8d6a47defa6cf947 = vectornormalize2(self.origin - self.var_7177dd881b296d3);
      var_25c45ec401562787 = vectornormalize2(new_origin - self.origin);
      var_a82f2dc40e33d7e = vectornormalize2(next_point - start_point);
      var_89ba7239e3c2b0ad = 0.1;

      if(vectordot(var_25c45ec401562787, var_8d6a47defa6cf947) <= var_89ba7239e3c2b0ad || vectordot(var_a82f2dc40e33d7e, var_25c45ec401562787) <= var_89ba7239e3c2b0ad || distance2dsquared(self.origin, self.var_7177dd881b296d3) < 64) {
        self.var_17e48b8b7457c.current_index = self.var_17e48b8b7457c.points.size;
      }
    }

    self forceteleport(new_origin);
    self.var_37ca4842bca3031c = gettime();
    self.var_7177dd881b296d3 = new_origin;
  }
}

function function_9eaaa0a5c40b2c19(goal, speed) {
  if(!isDefined(self.var_17e48b8b7457c)) {
    self.var_17e48b8b7457c = spawnStruct();
  }

  self.var_17e48b8b7457c.points = [self.origin, goal];
  self.var_17e48b8b7457c.current_index = 0;
  self.var_17e48b8b7457c.speed = default_to(speed, 6);
  self function_3e89eb3d8e3f1811("in_float_move", 1);
}

function clear_float_move() {
  self.var_17e48b8b7457c = undefined;
  self.var_37ca4842bca3031c = undefined;
  self function_4b733566e92d899e("in_float_move");
  self notify("clear_float_move");
}

function function_c73058e4f180cbff(goal, speed) {
  assert(isDefined(self.var_17e48b8b7457c), "<dev string:x1c>");
  self.var_17e48b8b7457c.points = [self.origin, goal];
  self.var_17e48b8b7457c.current_index = 0;
  self.var_17e48b8b7457c.speed = default_to(speed, self.var_17e48b8b7457c.speed);
}