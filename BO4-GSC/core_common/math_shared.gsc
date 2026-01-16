/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\math_shared.gsc
***********************************************/

#include scripts\core_common\util_shared;

#namespace math;

cointoss(n_chance = 50) {
  return randomintrangeinclusive(1, 100) <= n_chance;
}

clamp(val, val_min, val_max = val) {
  if(val < val_min) {
    val = val_min;
  } else if(val > val_max) {
    val = val_max;
  }

  return val;
}

linear_map(num, min_a, max_a, min_b, max_b) {
  return clamp((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b, min_b, max_b);
}

lag(desired, curr, k, dt) {
  r = 0;

  if(k * dt >= 1 || k <= 0) {
    r = desired;
  } else {
    err = desired - curr;
    r = curr + k * err * dt;
  }

  return r;
}

find_box_center(mins, maxs) {
  center = (0, 0, 0);
  center = maxs - mins;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
  return center;
}

expand_mins(mins, point) {
  if(mins[0] > point[0]) {
    mins = (point[0], mins[1], mins[2]);
  }

  if(mins[1] > point[1]) {
    mins = (mins[0], point[1], mins[2]);
  }

  if(mins[2] > point[2]) {
    mins = (mins[0], mins[1], point[2]);
  }

  return mins;
}

expand_maxs(maxs, point) {
  if(maxs[0] < point[0]) {
    maxs = (point[0], maxs[1], maxs[2]);
  }

  if(maxs[1] < point[1]) {
    maxs = (maxs[0], point[1], maxs[2]);
  }

  if(maxs[2] < point[2]) {
    maxs = (maxs[0], maxs[1], point[2]);
  }

  return maxs;
}

vector_compare(vec1, vec2) {
  return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

random_vector(max_length) {
  return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

angle_dif(oldangle, newangle) {
  outvalue = (oldangle - newangle) % 360;

  if(outvalue < 0) {
    outvalue += 360;
  }

  if(outvalue > 180) {
    outvalue = (outvalue - 360) * -1;
  }

  return outvalue;
}

sign(x) {
  return x >= 0 ? 1 : -1;
}

randomsign() {
  return randomintrange(-1, 1) >= 0 ? 1 : -1;
}

get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, b_use_eye) {
  assert(isDefined(v_point), "<dev string:x38>");

  if(!isDefined(b_ignore_z)) {
    b_ignore_z = 0;
  }

  if(!isDefined(b_normalize)) {
    b_normalize = 1;
  }

  if(!isDefined(str_direction)) {
    str_direction = "forward";
  }

  if(!isDefined(b_use_eye)) {
    b_use_eye = 0;

    if(isplayer(self)) {
      b_use_eye = 1;
    }
  }

  v_angles = self.angles;
  v_origin = self.origin;

  if(b_use_eye) {
    v_origin = self util::get_eye();
  }

  if(isplayer(self)) {
    v_angles = self getplayerangles();

    if(level.wiiu) {
      v_angles = self getgunangles();
    }
  }

  if(b_ignore_z) {
    v_angles = (v_angles[0], v_angles[1], 0);
    v_point = (v_point[0], v_point[1], 0);
    v_origin = (v_origin[0], v_origin[1], 0);
  }

  switch (str_direction) {
    case #"forward":
      v_direction = anglesToForward(v_angles);
      break;
    case #"backward":
      v_direction = anglesToForward(v_angles) * -1;
      break;
    case #"right":
      v_direction = anglestoright(v_angles);
      break;
    case #"left":
      v_direction = anglestoright(v_angles) * -1;
      break;
    case #"up":
      v_direction = anglestoup(v_angles);
      break;
    case #"down":
      v_direction = anglestoup(v_angles) * -1;
      break;
    default:
      assertmsg(str_direction + "<dev string:x66>");
      v_direction = anglesToForward(v_angles);
      break;
  }

  v_to_point = v_point - v_origin;

  if(b_normalize) {
    v_to_point = vectornormalize(v_to_point);
  }

  n_dot = vectordot(v_direction, v_to_point);
  return n_dot;
}

get_dot_right(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "<dev string:x93>");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "right");
  return n_dot;
}

get_dot_up(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "<dev string:xc7>");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "up");
  return n_dot;
}

get_dot_forward(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "<dev string:xf8>");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "forward");
  return n_dot;
}

get_dot_from_eye(v_point, b_ignore_z, b_normalize, str_direction) {
  assert(isDefined(v_point), "<dev string:xf8>");
  assert(isplayer(self) || isai(self), "<dev string:x12e>" + self.classname + "<dev string:x150>");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, 1);
  return n_dot;
}

array_average(array) {
  assert(isarray(array));
  assert(array.size > 0);
  total = 0;

  for(i = 0; i < array.size; i++) {
    total += array[i];
  }

  return total / array.size;
}

array_std_deviation(array, mean) {
  assert(isarray(array));
  assert(array.size > 0);
  tmp = [];

  for(i = 0; i < array.size; i++) {
    tmp[i] = (array[i] - mean) * (array[i] - mean);
  }

  total = 0;

  for(i = 0; i < tmp.size; i++) {
    total += tmp[i];
  }

  return sqrt(total / array.size);
}

random_normal_distribution(mean, std_deviation, lower_bound, upper_bound) {
  x1 = 0;
  x2 = 0;
  w = 1;
  y1 = 0;

  while(w >= 1) {
    x1 = 2 * randomfloatrange(0, 1) - 1;
    x2 = 2 * randomfloatrange(0, 1) - 1;
    w = x1 * x1 + x2 * x2;
  }

  w = sqrt(-2 * log(w) / w);
  y1 = x1 * w;
  number = mean + y1 * std_deviation;

  if(isDefined(lower_bound) && number < lower_bound) {
    number = lower_bound;
  }

  if(isDefined(upper_bound) && number > upper_bound) {
    number = upper_bound;
  }

  return number;
}

point_on_sphere_even_distribution(pitchrange, index, numberofpoints) {
  zrange = mapfloat(0, 180, 1, -1, pitchrange);
  golden_angle = 180 * (3 - sqrt(5));
  theta = index * golden_angle;
  z = mapfloat(0, numberofpoints - 1, 1, zrange, index);
  r = sqrt(1 - z * z);
  dir = (r * cos(theta), r * sin(theta), z);
  return dir;
}

closest_point_on_line(point, linestart, lineend) {
  linemagsqrd = lengthsquared(lineend - linestart);
  t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;

  if(t < 0) {
    return linestart;
  } else if(t > 1) {
    return lineend;
  }

  start_x = linestart[0] + t * (lineend[0] - linestart[0]);
  start_y = linestart[1] + t * (lineend[1] - linestart[1]);
  start_z = linestart[2] + t * (lineend[2] - linestart[2]);
  return (start_x, start_y, start_z);
}

function_8dd4c3c5(linestart, lineend, point) {
  var_6dbcbbd = distancesquared(linestart, point);
  var_eb2bcaa0 = distancesquared(lineend, point);
  lengthsq = lengthsquared(lineend - linestart);

  if(var_6dbcbbd > lengthsq || var_eb2bcaa0 > lengthsq) {
    point = var_6dbcbbd > var_eb2bcaa0 ? lineend : linestart;
  }

  return point;
}

function_d3de8415(var_17a1aca9, var_9522f5ec, var_e5dbc91e, var_815dce62, clamp) {
  veca = var_9522f5ec - var_17a1aca9;
  vecb = var_815dce62 - var_e5dbc91e;
  vecc = var_e5dbc91e - var_17a1aca9;
  dotaa = vectordot(veca, veca);
  dotab = vectordot(veca, vecb);
  dotac = vectordot(veca, vecc);
  dotbb = vectordot(vecb, vecb);
  dotbc = vectordot(vecb, vecc);
  denom = dotaa * dotbb - dotab * dotab;

  if(denom == 0) {
    return undefined;
  }

  t = (dotab * -1 * dotbc + dotac * dotbb) / (dotaa * dotbb - dotab * dotab);
  point = var_17a1aca9 + veca * t;

  if(clamp) {
    point = function_8dd4c3c5(var_17a1aca9, var_9522f5ec, point);
  }

  return point;
}

function_f16fbd66(var_17a1aca9, var_9522f5ec, var_e5dbc91e, var_815dce62, clamp) {
  veca = var_9522f5ec - var_17a1aca9;
  vecb = var_815dce62 - var_e5dbc91e;
  vecc = var_e5dbc91e - var_17a1aca9;
  dotaa = vectordot(veca, veca);
  dotab = vectordot(veca, vecb);
  dotac = vectordot(veca, vecc);
  dotbb = vectordot(vecb, vecb);
  dotbc = vectordot(vecb, vecc);
  var_a3676a4c = dotaa * dotbb - dotab * dotab;
  var_75358de9 = dotaa * dotbb - dotab * dotab;

  if(var_a3676a4c == 0 || var_75358de9 == 0) {
    return undefined;
  }

  ta = (dotab * -1 * dotbc + dotac * dotbb) / (dotaa * dotbb - dotab * dotab);
  tb = (dotab * dotac - dotbc * dotaa) / (dotaa * dotbb - dotab * dotab);
  pointa = var_17a1aca9 + veca * ta;
  pointb = var_e5dbc91e + vecb * tb;

  if(clamp) {
    pointa = function_8dd4c3c5(var_17a1aca9, var_9522f5ec, pointa);
    pointb = function_8dd4c3c5(var_e5dbc91e, var_815dce62, pointb);
  }

  pointstruct = {
    #pointa: pointa, 
    #pointb: pointb
  };
  return pointstruct;
}

get_2d_yaw(start, end) {
  vector = (end[0] - start[0], end[1] - start[1], 0);
  return vec_to_angles(vector);
}

vec_to_angles(vector) {
  yaw = 0;
  vecx = vector[0];
  vecy = vector[1];

  if(vecx == 0 && vecy == 0) {
    return 0;
  }

  if(vecy < 0.001 && vecy > -0.001) {
    vecy = 0.001;
  }

  yaw = atan(vecx / vecy);

  if(vecy < 0) {
    yaw += 180;
  }

  return 90 - yaw;
}

pow(base, exp) {
  if(exp == 0) {
    return 1;
  }

  result = base;

  for(i = 0; i < exp - 1; i++) {
    result *= base;
  }

  return result;
}

function_b1820790(a, b, c, var_2bff268f) {
  var_9f942cf4 = var_2bff268f * 0.0174533;
  radius = b + a * pow(var_9f942cf4, 1 / c);
  return radius;
}