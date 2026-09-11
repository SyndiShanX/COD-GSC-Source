/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\math.gsc
***********************************************/

function anglebetweenvectors(var0, var1) {
  return acos(vectordot(var0, var1) / length(var0) * length(var1));
}

function anglebetweenvectorsunit(var0, var1) {
  return acos(vectordot(var0, var1));
}

function anglebetweenvectorssigned(var0, var1, var2) {
  var3 = vectorNormalize(var0);
  var4 = vectorNormalize(var1);
  var5 = acos(clamp(vectordot(var3, var4), -1, 1));
  var6 = vectorcross(var3, var4);

  if(vectordot(var6, var2) < 0) {
    var5 *= -1;
  }

  return var5;
}

function lerp(var0, var1, var2) {
  return var0 + (var1 - var0) * var2;
}

function lerp_fraction(var0, var1, var2) {
  return (var2 - var0) / (var1 - var0);
}

function fake_slerp(var0, var1, var2) {
  return (angle_lerp(var0[0], var1[0], var2), angle_lerp(var0[1], var1[1], var2), angle_lerp(var0[2], var1[2], var2));
}

function angle_lerp(var0, var1, var2) {
  return angleclamp(var0 + angleclamp180(var1 - var0) * var2);
}

function get_dot(var0, var1, var2) {
  var3 = vectorNormalize(var2 - var0);
  var4 = anglesToForward(var1);
  var5 = vectordot(var4, var3);
  return var5;
}

function vector_project_onto_plane(var0, var1) {
  return vectorNormalize(var0 - vectordot(var1, var0) * var1);
}

function vector_project_endpoint(var0, var1, var2) {
  var3 = anglesToForward(var1);
  var3 *= var2;
  var4 = var0 + var3;
  return var4;
}

function vector_reflect(var0, var1) {
  return vectorNormalize(2 * vector_project_onto_plane(var0, var1) - var0);
}

function vector_area_parallelogram(var0, var1, var2) {
  return var1[0] * var2[1] - var1[1] * var2[0] + var2[0] * var0[1] - var0[0] * var2[1] + var0[0] * var1[1] - var1[0] * var0[1];
}

function scalar_projection(var0, var1) {
  return vectordot(vectorNormalize(var0), var1);
}

function get_point_on_parabola(var0, var1, var2, var3) {
  var4 = var3 * 2 - 1;
  var5 = var1 - var0;
  var6 = (0, 0, 1);
  var7 = var0 + var3 * var5;
  var7 += (var4 * var4 * -1 + 1) * var2 * var6;
  return var7;
}

function get_mid_point(var0, var1) {
  return ((var0[0] + var1[0]) * 0.5, (var0[1] + var1[1]) * 0.5, (var0[2] + var1[2]) * 0.5);
}

function round_float(var0, var1, var2) {
  var1 = int(var1);

  if(var1 < 0 || var1 > 4) {
    return var0;
  }

  var3 = 1;

  for(var4 = 1; var4 <= var1; var4++) {
    var3 *= 10;
  }

  var5 = var0 * var3;

  if(!isDefined(var2) || var2) {
    var5 = floor(var5);
  } else {
    var5 = ceil(var5);
  }

  var0 = var5 / var3;
  return var0;
}

function round_millisec_on_sec(var0, var1, var2) {
  var3 = var0 / 1000;
  var3 = round_float(var3, var1, var2);
  var0 = var3 * 1000;
  return int(var0);
}

function remap(var0, var1, var2, var3, var4) {
  return var3 + (var0 - var1) * (var4 - var3) / (var2 - var1);
}

function normalize_value(var0, var1, var2) {
  if(var0 > var1) {
    var3 = var0;
    var0 = var1;
    var1 = var3;
  }

  if(var2 > var1) {
    return 1;
  } else if(var2 < var0) {
    return 0;
  } else if(var0 == var1) {}

  return (var2 - var0) / (var1 - var0);
}

function normalized_to_growth_clamps(var0, var1, var2) {
  return (var1 - var0) * squared(var2) + var0;
}

function normalized_to_decay_clamps(var0, var1, var2) {
  return normalized_to_growth_clamps(var0, var1, 1 - var2);
}

function normalized_parabola(var0) {
  return -1 * squared(2 * var0 - 1) + 1;
}

function normalized_sin_wave(var0) {
  var1 = var0 * 2 * 3.14159 - 1.5708;
  var1 = (sin(radians_to_degrees(var1)) + 1) * 0.5;
  return var1;
}

function normalized_cos_wave(var0) {
  var1 = var0 * 2 * 3.14159;
  var1 = (cos(radians_to_degrees(var1)) + 1) * 0.5;
  return var1;
}

function radians_to_degrees(var0) {
  return var0 * 57.2958;
}

function keypad_increase_failnum(var0) {
  return var0 * 0.0174533;
}

function factor_value(var0, var1, var2) {
  return var1 * var2 + var0 * (1 - var2);
}

function normalized_float_smoth_in_out(var0) {
  if(var0 < 0.5) {
    var0 *= 2;
    var0 = normalized_float_smooth_in(var0);
    var0 *= 0.5;
  } else {
    var0 = (var0 - 0.5) * 2;
    var0 = normalized_float_smooth_out(var0);
    var0 = var0 * 0.5 + 0.5;
  }

  return var0;
}

function normalized_float_smooth_in(var0) {
  return var0 * var0;
}

function normalized_float_smooth_out(var0) {
  var0 = 1 - var0;
  var0 *= var0;
  var0 = 1 - var0;
  return var0;
}

function line_to_plane_intersection(var0, var1, var2, var3) {
  var4 = vectordot(var3, var2);
  var5 = var1 - var0;
  var6 = vectordot(var3, var5);

  if(var6 == 0) {
    return undefined;
  }

  var7 = (var4 - vectordot(var3, var0)) / var6;
  var8 = var0 + var5 * var7;
  return var8;
}

function ray_to_plane_intersection_distance(var0, var1, var2, var3) {
  return vectordot(var2 - var0, var3) / vectordot(var1, var3);
}

function segmentvssphere(var0, var1, var2, var3) {
  if(var0 == var1) {
    return false;
  }

  var4 = var2 - var0;
  var5 = var1 - var0;
  var6 = clamp(vectordot(var4, var5) / vectordot(var5, var5), 0, 1);
  var7 = var0 + var5 * var6;
  return lengthsquared(var2 - var7) <= var3 * var3;
}

function pointvscone(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = var0 - var1;
  var9 = vectordot(var8, var2);
  var10 = vectordot(var8, var3);

  if(var9 > var4) {
    return false;
  }

  if(var9 < var5) {
    return false;
  }

  if(isDefined(var7)) {
    if(abs(var10) > var7) {
      return false;
    }
  }

  if(anglebetweenvectors(var2, var8) > var6) {
    return false;
  }

  return true;
}

function pointvscylinder(var0, var1, var2, var3, var4) {
  var5 = var0 - var3;
  var6 = vectordot(var5, var4);

  if(var6 < 0 || var6 > var2) {
    return false;
  }

  var5 -= var6 * var4;
  var7 = lengthsquared(var5);

  if(var7 > var1) {
    return false;
  }

  return true;
}

function point_side_of_line2d(var0, var1, var2) {
  var3 = vector_area_parallelogram(var0, var1, var2);

  if(var3 > 0) {
    return "left";
  }

  return "right";
}

function wrap(var0, var1, var2) {
  var3 = var1 - var0 + 1;

  if(var2 < var0) {
    var2 += var3 * int((var0 - var2) / var3 + 1);
  }

  return var0 + (var2 - var0) % var3;
}

function point_in_fov(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0.766;
  }

  if(isPlayer(self)) {
    var3 = anglesToForward(self getplayerangles(!istrue(var2)));
  } else {
    var3 = anglesToForward(self.angles);
  }

  var4 = vectorNormalize(var1 - self.origin);
  var5 = vectordot(var3, var4);
  return var5 > var2;
}

function within_fov_2d(var0, var1, var2, var3) {
  var4 = vectorNormalize((var2[0], var2[1], 0) - (var0[0], var0[1], 0));
  var5 = anglesToForward((0, var1[1], 0));
  return vectordot(var5, var4) >= var3;
}

function is_point_in_front(var0) {
  var1 = 0;

  if(isent(self) && isPlayer(self)) {
    var2 = var0 - self getorigin();
    var3 = anglesToForward(self getplayerangles(1));
    var1 = vectordot(var2, var3);
  } else {
    var2 -= self.origin;
    var3 = anglesToForward(self.angles);
    var3 = vectordot(var2, var3);
  }

  return var3 > 0;
}

function is_point_on_right(var0) {
  var1 = 0;

  if(isPlayer(self)) {
    var2 = var0 - self getorigin();
    var3 = anglestoright(self getplayerangles(1));
    var1 = vectordot(var2, var3);
  } else {
    var2 -= self.origin;
    var3 = anglestoright(self.angles);
    var3 = vectordot(var2, var3);
  }

  return var3 > 0;
}

function random_vector_2d() {
  var0 = randomfloat(360);
  return (cos(var0), sin(var0), 0);
}

function set_matrix_from_up(var0) {
  var1 = anglesToForward(self.angles);
  var2 = vectorcross(var1, var0);
  var3 = vectorcross(var0, var2);
  self.angles = axistoangles(var3, var2, var0);
}

function set_matrix_from_up_and_angles(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.angles;
  }

  self.angles = build_matrix_from_up_and_angles(var0, var1);
}

function build_matrix_from_up_and_angles(var0, var1) {
  var2 = acos(-1 * vectordot(anglesToForward(var1), var0));
  var3 = anglestoup(var1 + (var2, 0, 0));
  var4 = vectorcross(var3, var0);
  var3 = vectorcross(var0, var4);
  return axistoangles(var3, var4, var0);
}

function critically_damped_move_to(var0, var1, var2) {
  thread critically_damped_move_to_thread(var0, var1, var2);
}

function critically_damped_move_to_thread(var0, var1, var2) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = spring_make_critically_damped(var1, self.origin, anglesToForward(self.angles) * var2);

  while(distancesquared(self.origin, var0) > squared(0.1)) {
    self.origin = spring_update(var3, var0);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(var3);
}

function critically_damped_move_and_rotate_to(var0, var1, var2) {
  thread critically_damped_move_and_rotate_to_thread(var0, var1, var2);
}

function critically_damped_move_and_rotate_to_thread(var0, var1, var2) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = spring_make_critically_damped(var1, self.origin, anglesToForward(self.angles) * var2);

  while(distancesquared(self.origin, var0) > squared(0.1)) {
    self.origin = spring_update(var3, var0);
    self.angles = vectortoangles(spring_get_vel(var3));
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(var3);
}

function over_damped_move_to(var0, var1, var2, var3) {
  thread over_damped_move_to_thread(var0, var1, var2, var3);
}

function over_damped_move_to_thread(var0, var1, var2, var3) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var3)) {
    var3 = 1;
  }

  var4 = spring_make_over_damped(var1, var2, self.origin, anglesToForward(self.angles) * var3);

  while(distancesquared(self.origin, var0) > squared(0.1)) {
    self.origin = spring_update(var4, var0);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(var4);
}

function under_damped_move_to(var0, var1, var2, var3) {
  thread under_damped_move_to_thread(var0, var1, var2, var3);
}

function under_damped_move_to_thread(var0, var1, var2, var3) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var3)) {
    var3 = 1;
  }

  var4 = spring_make_under_damped(var1, var2, self.origin, anglesToForward(self.angles) * var3);

  while(distancesquared(self.origin, var0) > squared(0.1) || length(spring_get_vel(var4)) < squared(0.1)) {
    self.origin = spring_update(var4, var0);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(var4);
}

function spring_make_critically_damped(var0, var1, var2) {
  var3 = spring_add(var1, var2);
  var4 = var0 * 0.05;
  var5 = exp(-1 * var4);
  level.springs[var3].c0 = (var4 + 1) * var5;
  level.springs[var3].c1 = var5;
  level.springs[var3].c2 = -1 * var4 * var4 * var5;
  level.springs[var3].c3 = (1 - var4) * var5;
  spring_set_pos(var3, var1);
  spring_set_vel(var3, var2);
  return var3;
}

function spring_make_over_damped(var0, var1, var2, var3) {
  var4 = spring_add(var2, var3);
  var5 = var0 * var0;
  var6 = -1 * sqrt(var1 * var1 + 4 * var5);
  var7 = 0.5 * (var6 + var1);
  var8 = 0.5 * (var6 - var1);
  var9 = var8 - var7;
  var10 = 1 / var9;
  var11 = exp(var7 * 0.05);
  var12 = exp(var8 * 0.05);
  var13 = var12 - var11;
  level.springs[var4].c1 = var13 * var10;
  level.springs[var4].c0 = var11 - var7 * level.springs[var4].c1;
  level.springs[var4].c3 = (var8 * var12 - var7 * var11) * var10;
  level.springs[var4].c2 = var7 * (var11 - level.springs[var4].c3);
  spring_set_pos(var4, var2);
  spring_set_vel(var4, var3);
  return var4;
}

function spring_make_under_damped(var0, var1, var2, var3) {
  var4 = spring_add(var2, var3);
  var5 = -0.5 * var1;
  var6 = var0;
  var7 = exp(var5 * 0.05) / var6;
  var8 = angleclamp(var6 * 0.05);
  var9 = sin(var8);
  var10 = cos(var8);
  var11 = var6 * var10;
  var12 = var5 * var9;
  level.springs[var4].c0 = var7 * (var11 - var12);
  level.springs[var4].c1 = var7 * var9;
  level.springs[var4].c2 = var7 * -1 * var9 * (var5 * var5 + var6 * var6);
  level.springs[var4].c3 = var7 * (var11 + var12);
  spring_set_pos(var4, var2);
  spring_set_vel(var4, var3);
  return var4;
}

function spring_update(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    spring_set_pos(var0, var2);
  }

  if(isDefined(var3)) {
    spring_set_vel(var0, var3);
  }

  var4 = level.springs[var0].pos - var1;
  var5 = level.springs[var0].c0 * var4 + level.springs[var0].c1 * level.springs[var0].vel;
  var6 = level.springs[var0].c2 * var4 + level.springs[var0].c3 * level.springs[var0].vel;
  level.springs[var0].pos = var5 + var1;
  level.springs[var0].vel = var6;
  return level.springs[var0].pos;
}

function spring_delete(var0) {
  level.springs[var0] = undefined;
}

function spring_get_pos(var0) {
  return level.springs[var0].pos;
}

function spring_get_vel(var0) {
  return level.springs[var0].vel;
}

function spring_init() {
  if(!isDefined(level.springs)) {
    level.springs = [];
    level.spring_count = 0;
    return;
  }
}

function spring_add(var0, var1) {
  spring_init();
  var2 = level.spring_count;
  level.spring_count++;
  level.springs[var2] = spawnStruct();
  level.springs[var2].pos = var0;
  level.springs[var2].vel = var1;
  level.springs[var2].c0 = 0;
  level.springs[var2].c1 = 0;
  level.springs[var2].c2 = 0;
  level.springs[var2].c3 = 0;
  return var2;
}

function spring_set_pos(var0, var1) {
  level.springs[var0].pos = var1;
}

function spring_set_vel(var0, var1) {
  level.springs[var0].vel = var1;
}