/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\math.gsc
***********************************************/

anglebetweenvectors(var_0, var_1) {
  return acos(vectordot(var_0, var_1) / (length(var_0) * length(var_1)));
}

anglebetweenvectorsunit(var_0, var_1) {
  return acos(vectordot(var_0, var_1));
}

anglebetweenvectorssigned(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_0);
  var_4 = vectorNormalize(var_1);
  var_5 = acos(clamp(vectordot(var_3, var_4), -1, 1));
  var_6 = vectorcross(var_3, var_4);

  if(vectordot(var_6, var_2) < 0)
    var_5 = var_5 * -1;

  return var_5;
}

lerp(var_0, var_1, var_2) {
  return var_0 + (var_1 - var_0) * var_2;
}

lerp_fraction(var_0, var_1, var_2) {
  return (var_2 - var_0) / (var_1 - var_0);
}

fake_slerp(var_0, var_1, var_2) {
  return (angle_lerp(var_0[0], var_1[0], var_2), angle_lerp(var_0[1], var_1[1], var_2), angle_lerp(var_0[2], var_1[2], var_2));
}

angle_lerp(var_0, var_1, var_2) {
  return angleclamp(var_0 + angleclamp180(var_1 - var_0) * var_2);
}

get_dot(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

vector_project_onto_plane(var_0, var_1) {
  return vectorNormalize(var_0 - vectordot(var_1, var_0) * var_1);
}

vector_project_endpoint(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);
  var_3 = var_3 * var_2;
  var_4 = var_0 + var_3;
  return var_4;
}

vector_reflect(var_0, var_1) {
  return vectorNormalize(2 * vector_project_onto_plane(var_0, var_1) - var_0);
}

vector_area_parallelogram(var_0, var_1, var_2) {
  return var_1[0] * var_2[1] - var_1[1] * var_2[0] + (var_2[0] * var_0[1] - var_0[0] * var_2[1]) + (var_0[0] * var_1[1] - var_1[0] * var_0[1]);
}

scalar_projection(var_0, var_1) {
  return vectordot(vectorNormalize(var_0), var_1);
}

get_point_on_parabola(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 2 - 1;
  var_5 = var_1 - var_0;
  var_6 = (0, 0, 1);
  var_7 = var_0 + var_3 * var_5;
  var_7 = var_7 + (var_4 * var_4 * -1 + 1) * var_2 * var_6;
  return var_7;
}

get_mid_point(var_0, var_1) {
  return ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
}

round_float(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4)
    return var_0;

  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2)
    var_5 = floor(var_5);
  else
    var_5 = ceil(var_5);

  var_0 = var_5 / var_3;
  return var_0;
}

round_millisec_on_sec(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = round_float(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

remap(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + (var_0 - var_1) * (var_4 - var_3) / (var_2 - var_1);
}

normalize_value(var_0, var_1, var_2) {
  if(var_0 > var_1) {
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
  }

  if(var_2 > var_1)
    return 1.0;
  else if(var_2 < var_0)
    return 0.0;
  else if(var_0 == var_1) {}

  return (var_2 - var_0) / (var_1 - var_0);
}

normalized_to_growth_clamps(var_0, var_1, var_2) {
  return (var_1 - var_0) * squared(var_2) + var_0;
}

normalized_to_decay_clamps(var_0, var_1, var_2) {
  return normalized_to_growth_clamps(var_0, var_1, 1 - var_2);
}

normalized_parabola(var_0) {
  return -1 * squared(2 * var_0 - 1) + 1;
}

normalized_sin_wave(var_0) {
  var_1 = var_0 * 2 * 3.14159 - 1.5708;
  var_1 = (sin(radians_to_degrees(var_1)) + 1) * 0.5;
  return var_1;
}

normalized_cos_wave(var_0) {
  var_1 = var_0 * 2 * 3.14159;
  var_1 = (cos(radians_to_degrees(var_1)) + 1) * 0.5;
  return var_1;
}

radians_to_degrees(var_0) {
  return var_0 * 57.2958;
}

keypad_increase_failnum(var_0) {
  return var_0 * 0.0174533;
}

factor_value(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * (1 - var_2);
}

normalized_float_smoth_in_out(var_0) {
  if(var_0 < 0.5) {
    var_0 = var_0 * 2;
    var_0 = normalized_float_smooth_in(var_0);
    var_0 = var_0 * 0.5;
  } else {
    var_0 = (var_0 - 0.5) * 2;
    var_0 = normalized_float_smooth_out(var_0);
    var_0 = var_0 * 0.5 + 0.5;
  }

  return var_0;
}

normalized_float_smooth_in(var_0) {
  return var_0 * var_0;
}

normalized_float_smooth_out(var_0) {
  var_0 = 1 - var_0;
  var_0 = var_0 * var_0;
  var_0 = 1 - var_0;
  return var_0;
}

line_to_plane_intersection(var_0, var_1, var_2, var_3) {
  var_4 = vectordot(var_3, var_2);
  var_5 = var_1 - var_0;
  var_6 = vectordot(var_3, var_5);

  if(var_6 == 0)
    return undefined;

  var_7 = (var_4 - vectordot(var_3, var_0)) / var_6;
  var_8 = var_0 + var_5 * var_7;
  return var_8;
}

ray_to_plane_intersection_distance(var_0, var_1, var_2, var_3) {
  return vectordot(var_2 - var_0, var_3) / vectordot(var_1, var_3);
}

segmentvssphere(var_0, var_1, var_2, var_3) {
  if(var_0 == var_1)
    return 0;

  var_4 = var_2 - var_0;
  var_5 = var_1 - var_0;
  var_6 = clamp(vectordot(var_4, var_5) / vectordot(var_5, var_5), 0, 1);
  var_7 = var_0 + var_5 * var_6;
  return lengthsquared(var_2 - var_7) <= var_3 * var_3;
}

pointvscone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 - var_1;
  var_9 = vectordot(var_8, var_2);
  var_10 = vectordot(var_8, var_3);

  if(var_9 > var_4)
    return 0;

  if(var_9 < var_5)
    return 0;

  if(isDefined(var_7)) {
    if(abs(var_10) > var_7)
      return 0;
  }

  if(anglebetweenvectors(var_2, var_8) > var_6)
    return 0;

  return 1;
}

pointvscylinder(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 - var_3;
  var_6 = vectordot(var_5, var_4);

  if(var_6 < 0 || var_6 > var_2)
    return 0;

  var_5 = var_5 - var_6 * var_4;
  var_7 = lengthsquared(var_5);

  if(var_7 > var_1)
    return 0;

  return 1;
}

point_side_of_line2d(var_0, var_1, var_2) {
  var_3 = vector_area_parallelogram(var_0, var_1, var_2);

  if(var_3 > 0.0)
    return "_encstr_A5AD056A019C63";

  return "_encstr_8253060E2B5FE330";
}

wrap(var_0, var_1, var_2) {
  var_3 = var_1 - var_0 + 1;

  if(var_2 < var_0)
    var_2 = var_2 + var_3 * int((var_0 - var_2) / var_3 + 1);

  return var_0 + (var_2 - var_0) % var_3;
}

point_in_fov(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.766;

  if(isPlayer(self))
    var_3 = anglesToForward(self getplayerangles(!istrue(var_2)));
  else
    var_3 = anglesToForward(self.angles);

  var_4 = vectorNormalize(var_0 - self.origin);
  var_5 = vectordot(var_3, var_4);
  return var_5 > var_1;
}

within_fov_2d(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

is_point_in_front(var_0) {
  var_1 = 0;

  if(isent(self) && isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_0 - self.origin;
    var_3 = anglesToForward(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

is_point_on_right(var_0) {
  var_1 = 0;

  if(isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_0 - self.origin;
    var_3 = anglestoright(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

random_vector_2d() {
  var_0 = randomfloat(360);
  return (cos(var_0), sin(var_0), 0.0);
}

set_matrix_from_up(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectorcross(var_1, var_0);
  var_3 = vectorcross(var_0, var_2);
  self.angles = axistoangles(var_3, var_2, var_0);
}

set_matrix_from_up_and_angles(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.angles;

  self.angles = build_matrix_from_up_and_angles(var_0, var_1);
}

build_matrix_from_up_and_angles(var_0, var_1) {
  var_2 = acos(-1 * vectordot(anglesToForward(var_1), var_0));
  var_3 = anglestoup(var_1 + (var_2, 0, 0));
  var_4 = vectorcross(var_3, var_0);
  var_3 = vectorcross(var_0, var_4);
  return axistoangles(var_3, var_4, var_0);
}

critically_damped_move_to(var_0, var_1, var_2) {
  thread critically_damped_move_to_thread(var_0, var_1, var_2);
}

critically_damped_move_to_thread(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_81620C3A6B9890296E310367651C");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = spring_make_critically_damped(var_1, self.origin, anglesToForward(self.angles) * var_2);

  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = spring_update(var_3, var_0);
    wait 0.05;
  }

  self notify("_encstr_9B420907FD535DAC6DF285");
  spring_delete(var_3);
}

critically_damped_move_and_rotate_to(var_0, var_1, var_2) {
  thread critically_damped_move_and_rotate_to_thread(var_0, var_1, var_2);
}

critically_damped_move_and_rotate_to_thread(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_81620C3A6B9890296E310367651C");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = spring_make_critically_damped(var_1, self.origin, anglesToForward(self.angles) * var_2);

  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = spring_update(var_3, var_0);
    self.angles = vectortoangles(spring_get_vel(var_3));
    wait 0.05;
  }

  self notify("_encstr_9B420907FD535DAC6DF285");
  spring_delete(var_3);
}

over_damped_move_to(var_0, var_1, var_2, var_3) {
  thread over_damped_move_to_thread(var_0, var_1, var_2, var_3);
}

over_damped_move_to_thread(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_81620C3A6B9890296E310367651C");

  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = spring_make_over_damped(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);

  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = spring_update(var_4, var_0);
    wait 0.05;
  }

  self notify("_encstr_9B420907FD535DAC6DF285");
  spring_delete(var_4);
}

under_damped_move_to(var_0, var_1, var_2, var_3) {
  thread under_damped_move_to_thread(var_0, var_1, var_2, var_3);
}

under_damped_move_to_thread(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_81620C3A6B9890296E310367651C");

  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = spring_make_under_damped(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);

  while(distancesquared(self.origin, var_0) > squared(0.1) || length(spring_get_vel(var_4)) < squared(0.1)) {
    self.origin = spring_update(var_4, var_0);
    wait 0.05;
  }

  self notify("_encstr_9B420907FD535DAC6DF285");
  spring_delete(var_4);
}

spring_make_critically_damped(var_0, var_1, var_2) {
  var_3 = spring_add(var_1, var_2);
  var_4 = var_0 * 0.05;
  var_5 = exp(-1 * var_4);
  level.springs[var_3].c0 = (var_4 + 1) * var_5;
  level.springs[var_3].c1 = var_5;
  level.springs[var_3].c2 = -1 * var_4 * var_4 * var_5;
  level.springs[var_3].c3 = (1 - var_4) * var_5;
  spring_set_pos(var_3, var_1);
  spring_set_vel(var_3, var_2);
  return var_3;
}

spring_make_over_damped(var_0, var_1, var_2, var_3) {
  var_4 = spring_add(var_2, var_3);
  var_5 = var_0 * var_0;
  var_6 = -1 * sqrt(var_1 * var_1 + 4.0 * var_5);
  var_7 = 0.5 * (var_6 + var_1);
  var_8 = 0.5 * (var_6 - var_1);
  var_9 = var_8 - var_7;
  var_10 = 1.0 / var_9;
  var_11 = exp(var_7 * 0.05);
  var_12 = exp(var_8 * 0.05);
  var_13 = var_12 - var_11;
  level.springs[var_4].c1 = var_13 * var_10;
  level.springs[var_4].c0 = var_11 - var_7 * level.springs[var_4].c1;
  level.springs[var_4].c3 = (var_8 * var_12 - var_7 * var_11) * var_10;
  level.springs[var_4].c2 = var_7 * (var_11 - level.springs[var_4].c3);
  spring_set_pos(var_4, var_2);
  spring_set_vel(var_4, var_3);
  return var_4;
}

spring_make_under_damped(var_0, var_1, var_2, var_3) {
  var_4 = spring_add(var_2, var_3);
  var_5 = -0.5 * var_1;
  var_6 = var_0;
  var_7 = exp(var_5 * 0.05) / var_6;
  var_8 = angleclamp(var_6 * 0.05);
  var_9 = sin(var_8);
  var_10 = cos(var_8);
  var_11 = var_6 * var_10;
  var_12 = var_5 * var_9;
  level.springs[var_4].c0 = var_7 * (var_11 - var_12);
  level.springs[var_4].c1 = var_7 * var_9;
  level.springs[var_4].c2 = var_7 * -1 * var_9 * (var_5 * var_5 + var_6 * var_6);
  level.springs[var_4].c3 = var_7 * (var_11 + var_12);
  spring_set_pos(var_4, var_2);
  spring_set_vel(var_4, var_3);
  return var_4;
}

spring_update(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    spring_set_pos(var_0, var_2);

  if(isDefined(var_3))
    spring_set_vel(var_0, var_3);

  var_4 = level.springs[var_0].pos - var_1;
  var_5 = level.springs[var_0].c0 * var_4 + level.springs[var_0].c1 * level.springs[var_0].vel;
  var_6 = level.springs[var_0].c2 * var_4 + level.springs[var_0].c3 * level.springs[var_0].vel;
  level.springs[var_0].pos = var_5 + var_1;
  level.springs[var_0].vel = var_6;
  return level.springs[var_0].pos;
}

spring_delete(var_0) {
  level.springs[var_0] = undefined;
}

spring_get_pos(var_0) {
  return level.springs[var_0].pos;
}

spring_get_vel(var_0) {
  return level.springs[var_0].vel;
}

spring_init() {
  if(!isDefined(level.springs)) {
    level.springs = [];
    level.spring_count = 0;
  }
}

spring_add(var_0, var_1) {
  spring_init();
  var_2 = level.spring_count;
  level.spring_count++;
  level.springs[var_2] = spawnStruct();
  level.springs[var_2].pos = var_0;
  level.springs[var_2].vel = var_1;
  level.springs[var_2].c0 = 0;
  level.springs[var_2].c1 = 0;
  level.springs[var_2].c2 = 0;
  level.springs[var_2].c3 = 0;
  return var_2;
}

spring_set_pos(var_0, var_1) {
  level.springs[var_0].pos = var_1;
}

spring_set_vel(var_0, var_1) {
  level.springs[var_0].vel = var_1;
}