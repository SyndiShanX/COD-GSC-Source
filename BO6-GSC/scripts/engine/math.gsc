/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\math.gsc
**************************************/

#using scripts\engine\utility;
#namespace math;

function anglebetweenvectors(vector1, vector2) {
  return acos(clamp(vectordot(vector1, vector2) / length(vector1) * length(vector2), -1, 1));
}

function anglebetweenvectorsunit(v1, v2) {
  return acos(vectordot(v1, v2));
}

function anglebetweenvectorssigned(vector1, vector2, reference_norm) {
  vec1 = vectorNormalize(vector1);
  vec2 = vectorNormalize(vector2);
  angle = acos(clamp(vectordot(vec1, vec2), -1, 1));
  cross = vectorcross(vec1, vec2);

  if(vectordot(cross, reference_norm) < 0) {
    angle *= -1;
  }

  return angle;
}

function lerp(from, to, frac) {
  return from + (to - from) * frac;
}

function lerp_fraction(from, to, n) {
  return (n - from) / (to - from);
}

function fake_slerp(from, to, fraction) {
  return (angle_lerp(from[0], to[0], fraction), angle_lerp(from[1], to[1], fraction), angle_lerp(from[2], to[2], fraction));
}

function angle_lerp(from, to, fraction) {
  return angleclamp(from + angleclamp180(to - from) * fraction);
}

function get_dot(start_origin, start_angles, end_origin) {
  normal = vectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot;
}

function vector_project_onto_plane(vector, normal) {
  return vector - vectordot(normal, vector) / squared(length(normal)) * normal;
}

function vector_project_endpoint(origin, angles, len) {
  assert(isDefined(origin));
  assert(isDefined(angles));
  assert(isDefined(len));
  dir = anglesToForward(angles);
  dir *= len;
  end = origin + dir;
  return end;
}

function vector_reflect(vector, normal) {
  return vectorNormalize(2 * vector_project_onto_plane(vector, normal) - vector);
}

function vector_area_parallelogram(v, a, b) {
  assert(isDefined(v));
  assert(isDefined(a));
  assert(isDefined(b));
  return a[0] * b[1] - a[1] * b[0] + b[0] * v[1] - v[0] * b[1] + v[0] * a[1] - a[0] * v[1];
}

function scalar_projection(veca, vecb) {
  return vectordot(vectorNormalize(veca), vecb);
}

function get_point_on_parabola(start, end, height, t) {
  parabolic_t = t * 2 - 1;
  direction = end - start;
  up = (0, 0, 1);
  result = start + t * direction;
  result += (parabolic_t * parabolic_t * -1 + 1) * height * up;
  return result;
}

function get_mid_point(point_1, point_2) {
  return ((point_1[0] + point_2[0]) * 0.5, (point_1[1] + point_2[1]) * 0.5, (point_1[2] + point_2[2]) * 0.5);
}

function round_float(value, precision, down) {
  assert(isDefined(value), "<dev string:x24>");
  assert(isDefined(precision), "<dev string:x3e>");
  assert(precision == int(precision), "<dev string:x5c>");
  precision = int(precision);

  if(precision < 0 || precision > 4) {
    assertmsg("<dev string:x7d>" + precision);
    return value;
  }

  decimal_offset = 1;

  for(i = 1; i <= precision; i++) {
    decimal_offset *= 10;
  }

  value_clipped = value * decimal_offset;

  if(!isDefined(down) || down) {
    value_clipped = floor(value_clipped);
  } else {
    value_clipped = ceil(value_clipped);
  }

  value = value_clipped / decimal_offset;
  return value;
}

function round_millisec_on_sec(value, precision, down) {
  value_seconds = value / 1000;
  value_seconds = round_float(value_seconds, precision, down);
  value = value_seconds * 1000;
  return int(value);
}

function remap(value, min1, max1, min2, max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

function normalize_value(clamp_a, clamp_b, var_be1bef06e8004725) {
  if(clamp_a > clamp_b) {
    upper = clamp_a;
    clamp_a = clamp_b;
    clamp_b = upper;
  }

  if(var_be1bef06e8004725 > clamp_b) {
    return 1;
  } else if(var_be1bef06e8004725 < clamp_a) {
    return 0;
  } else if(clamp_a == clamp_b) {
    assertmsg("<dev string:xcf>" + clamp_a + "<dev string:xdc>" + clamp_b + "<dev string:xe7>");
  }

  return (var_be1bef06e8004725 - clamp_a) / (clamp_b - clamp_a);
}

function normalized_to_growth_clamps(min, max, value) {
  return (max - min) * squared(value) + min;
}

function normalized_to_decay_clamps(min, max, value) {
  return normalized_to_growth_clamps(min, max, 1 - value);
}

function normalized_parabola(x) {
  return -1 * squared(2 * x - 1) + 1;
}

function normalized_sin_wave(x) {
  y = x * 2 * 3.14159 - 1.5708;
  y = (sin(radians_to_degrees(y)) + 1) * 0.5;
  return y;
}

function normalized_cos_wave(x) {
  y = x * 2 * 3.14159;
  y = (cos(radians_to_degrees(y)) + 1) * 0.5;
  return y;
}

function normalized_offset(value, offsetamount) {
  value += offsetamount;

  if(value > 1) {
    value -= 1;
  }

  if(value < 0) {
    value += 1;
  }

  return value;
}

function radians_to_degrees(radians) {
  return radians * 57.2958;
}

function degrees_to_radians(degrees) {
  return degrees * 0.0174533;
}

function factor_value(min_val, max_val, factor_val) {
  return max_val * factor_val + min_val * (1 - factor_val);
}

function normalized_float_smooth_in_out(num) {
  if(num < 0.5) {
    num *= 2;
    num = normalized_float_smooth_in(num);
    num *= 0.5;
  } else {
    num = (num - 0.5) * 2;
    num = normalized_float_smooth_out(num);
    num = num * 0.5 + 0.5;
  }

  return num;
}

function normalized_float_smooth_in(num) {
  return num * num;
}

function normalized_float_smooth_out(num) {
  num = 1 - num;
  num *= num;
  num = 1 - num;
  return num;
}

function line_to_plane_intersection(var_d4a14c1c2935f5ca, var_d4a14b1c2935f397, plane_point, plane_normal) {
  d = vectordot(plane_normal, plane_point);
  ray = var_d4a14b1c2935f397 - var_d4a14c1c2935f5ca;
  var_fb8c52976cbf82f6 = vectordot(plane_normal, ray);

  if(var_fb8c52976cbf82f6 == 0) {
    return undefined;
  }

  t = (d - vectordot(plane_normal, var_d4a14c1c2935f5ca)) / var_fb8c52976cbf82f6;
  intersection_point = var_d4a14c1c2935f5ca + ray * t;
  return intersection_point;
}

function function_47d0ed373b25c699(point, aabb_min, aabb_max) {
  return point[0] <= aabb_max[0] && point[0] >= aabb_min[0] && point[1] <= aabb_max[1] && point[1] >= aabb_min[1] && point[2] <= aabb_max[2] && point[2] >= aabb_min[2];
}

function function_4cf4185ddbaca596(point, yaw, var_bd160eb7f794536d, var_aef1d9ace20c6967) {
  var_ce7447cbebe28d4c = anglestoaxis((0, yaw, 0));
  v = point - var_bd160eb7f794536d;
  return abs(vectordot(v, var_ce7447cbebe28d4c["forward"])) <= var_aef1d9ace20c6967[0] && abs(vectordot(v, var_ce7447cbebe28d4c["right"])) <= var_aef1d9ace20c6967[1] && abs(vectordot(v, var_ce7447cbebe28d4c["up"])) <= var_aef1d9ace20c6967[2];
}

function ray_to_plane_intersection_distance(rayorigin, raydirection, var_349301d833e3afa9, planenormal) {
  return vectordot(var_349301d833e3afa9 - rayorigin, planenormal) / vectordot(raydirection, planenormal);
}

function function_f0bb04c1592d3497(point_a, point_b, location) {
  if(distancesquared(point_a, point_b) < 0.1) {
    return distancesquared(point_a, location);
  }

  var_d897dee97b062905 = location - point_a;
  a_to_b = point_b - point_a;
  a_to_b_scalar = clamp(vectordot(var_d897dee97b062905, a_to_b) / vectordot(a_to_b, a_to_b), 0, 1);
  closest_point = point_a + a_to_b * a_to_b_scalar;
  return lengthsquared(location - closest_point);
}

function function_5795923c67b62e4e(pointa, pointb, boxorigin, boxangles, boxbounds) {
  pointa = coordtransformtranspose(pointa, boxorigin, boxangles);
  pointb = coordtransformtranspose(pointb, boxorigin, boxangles);
  var_5cc1c67022fe6da0 = pointb - pointa;
  var_cff7681bc6ecca27 = 1 / vectorNormalize(var_5cc1c67022fe6da0);
  halfbounds = boxbounds / 2;
  negativehalfbounds = -1 * halfbounds;
  t1 = (negativehalfbounds[0] - pointa[0]) * var_cff7681bc6ecca27[0];
  t2 = (halfbounds[0] - pointa[0]) * var_cff7681bc6ecca27[0];
  t3 = (negativehalfbounds[1] - pointa[1]) * var_cff7681bc6ecca27[1];
  t4 = (halfbounds[1] - pointa[1]) * var_cff7681bc6ecca27[1];
  t5 = (negativehalfbounds[2] - pointa[2]) * var_cff7681bc6ecca27[2];
  t6 = (halfbounds[2] - pointa[2]) * var_cff7681bc6ecca27[2];
  tmin = max(max(min(t1, t2), min(t3, t4)), min(t5, t6));
  tmax = min(min(max(t1, t2), max(t3, t4)), max(t5, t6));

  if(tmax < 0) {
    return false;
  }

  if(tmin > tmax) {
    return false;
  }

  if(tmin > length(var_5cc1c67022fe6da0)) {
    return false;
  }

  return true;
}

function function_5f3cda415a9be47c(point, start, end) {
  point2d = (point[0], point[1], 0);
  start2d = (start[0], start[1], 0);
  end2d = (end[0], end[1], 0);
  topoint = vectorNormalize(point2d - start2d);
  forward = vectorNormalize(end2d - start2d);
  dot = vectordot(topoint, forward);
  return dot > 0;
}

function function_14a305b0209b352c(start, end, circlecenter, circleradius) {
  x1 = start[0] - circlecenter[0];
  y1 = start[1] - circlecenter[1];
  x2 = end[0] - circlecenter[0];
  y2 = end[1] - circlecenter[1];
  r = float(circleradius);
  dx = x2 - x1;
  dy = y2 - y1;
  dr = dx * dx + dy * dy;
  d = x1 * y2 - x2 * y1;
  dis = r * r * dr - d * d;

  if(dis < 0) {
    return;
  }

  if(dis == 0) {
    pointx = d * dy / dr + circlecenter[0];
    pointy = -1 * d * dx / dr + circlecenter[1];
    return [(pointx, pointy, 0)];
  }

  sqrtdis = sqrt(dis);
  xa = d * dy;
  xb = utility::sign(dy) * dx * sqrtdis;
  point1x = (xa + xb) / dr + circlecenter[0];
  point2x = (xa - xb) / dr + circlecenter[0];
  ya = -1 * d * dx;
  yb = abs(dy) * sqrtdis;
  point1y = (ya + yb) / dr + circlecenter[1];
  point2y = (ya - yb) / dr + circlecenter[1];
  return [(point1x, point1y, 0), (point2x, point2y, 0)];
}

function function_58dd1731345885d3(var_985142fcf9952f76, radius1, center2, radius2) {
  distance = distance2d(var_985142fcf9952f76, center2);

  if(distance >= radius1 + radius2) {
    return undefined;
  }

  if(distance <= abs(radius1 - radius2)) {
    if(radius1 < radius2) {
      return {
        #var_f93905958736347f: 1, #radius: radius1, #center: var_985142fcf9952f76
      };
    } else {
      return {
        #var_f93905958736347f: 1, #radius: radius2, #center: center2
      };
    }
  }

  maxradius = (radius1 + radius2 - distance) / 2;
  direction = (center2 - var_985142fcf9952f76) / distance;
  var_491917f3daa85d4e = var_985142fcf9952f76 + direction * (radius1 - maxradius);
  return {
    #radius: maxradius, #center: var_491917f3daa85d4e
  };
}

function function_d7775bc5c201ec83(start, end, circleorigin, circleradius) {
  result = function_14a305b0209b352c(start, end, circleorigin, circleradius);

  if(!isDefined(result)) {
    return;
  }

  if(result.size == 1) {
    if(function_5f3cda415a9be47c(result[0], start, end)) {
      return result;
    }

    return;
  }

  pt1valid = function_5f3cda415a9be47c(result[0], start, end);
  pt2valid = function_5f3cda415a9be47c(result[1], start, end);

  if(!pt1valid && !pt2valid) {
    return;
  }

  if(pt1valid && !pt2valid) {
    return result[0];
  }

  if(pt2valid && !pt1valid) {
    return result[1];
  }

  distsq1 = distance2dsquared(start, result[0]);
  distsq2 = distance2dsquared(start, result[1]);

  if(distsq1 < distsq2) {
    return result[0];
  }

  return result[1];
}

function function_13baf942c4a29776(point, firstsegment, secondsegment) {
  closestpointa = pointonsegmentnearesttopoint(firstsegment[0], firstsegment[1], point);
  closestpointb = pointonsegmentnearesttopoint(secondsegment[0], secondsegment[1], point);

  if(distance2dsquared(point, closestpointa) > distance2dsquared(point, closestpointb)) {
    return closestpointa;
  }

  return closestpointb;
}

function segmentvssphere(pointa, pointb, spherecenter, sphereradius) {
  if(pointa == pointb) {
    return false;
  }

  var_d643e9ac5916e2a5 = spherecenter - pointa;
  atob = pointb - pointa;
  atobscalar = clamp(vectordot(var_d643e9ac5916e2a5, atob) / vectordot(atob, atob), 0, 1);
  closestpoint = pointa + atob * atobscalar;
  return lengthsquared(spherecenter - closestpoint) <= sphereradius * sphereradius;
}

function pointvscone(point, coneorigin, coneforward, coneup, conelen, conelenoffset, coneang, conehalfheight) {
  starttopoint = point - coneorigin;
  starttopointforward = vectordot(starttopoint, coneforward);
  starttopointup = vectordot(starttopoint, coneup);

  if(starttopointforward > conelen) {
    return false;
  }

  if(starttopointforward < conelenoffset) {
    return false;
  }

  if(isDefined(conehalfheight)) {
    if(abs(starttopointup) > conehalfheight) {
      return false;
    }
  }

  if(anglebetweenvectors(coneforward, starttopoint) > coneang) {
    return false;
  }

  return true;
}

function pointvscylinder(point, radiussqr, height, origin, up) {
  btwn = point - origin;
  vmag = vectordot(btwn, up);

  if(vmag < 0 || vmag > height) {
    return false;
  }

  btwn -= vmag * up;
  var_bcd73deb9a8030ed = lengthsquared(btwn);

  if(var_bcd73deb9a8030ed > radiussqr) {
    return false;
  }

  return true;
}

function point_side_of_line2d(v, a, b) {
  area = vector_area_parallelogram(v, a, b);

  if(area > 0) {
    return "left";
  }

  return "right";
}

function wrap(min, max, value) {
  range_size = max - min + 1;

  if(value < min) {
    value += range_size * int((min - value) / range_size + 1);
  }

  return min + (value - min) % range_size;
}

function point_in_fov(origin, fov, checkpitch) {
  if(!isDefined(origin)) {
    return;
  }

  if(!isDefined(fov)) {
    fov = 0.766;
  }

  if(isent(self) && isPlayer(self)) {
    forward = anglesToForward(self getplayerangles(!checkpitch));
  } else {
    forward = anglesToForward(self.angles);
  }

  normalvec = vectorNormalize(origin - self.origin);
  dot = vectordot(forward, normalvec);
  return dot > fov;
}

function within_fov_2d(start_origin, start_angles, end_origin, fov) {
  normal = vectorNormalize((end_origin[0], end_origin[1], 0) - (start_origin[0], start_origin[1], 0));
  forward = anglesToForward((0, start_angles[1], 0));
  return vectordot(forward, normal) >= fov;
}

function is_point_in_front(point) {
  dot = 0;

  if(isent(self) && isPlayer(self)) {
    to_point = point - self getorigin();
    forward = anglesToForward(self getplayerangles(1));
    dot = vectordot(to_point, forward);
  } else {
    to_point = point - self.origin;
    forward = anglesToForward(self.angles);
    dot = vectordot(to_point, forward);
  }

  return dot > 0;
}

function is_point_on_right(point) {
  dot = 0;

  if(isPlayer(self)) {
    to_point = point - self getorigin();
    right = anglestoright(self getplayerangles(1));
    dot = vectordot(to_point, right);
  } else {
    to_point = point - self.origin;
    right = anglestoright(self.angles);
    dot = vectordot(to_point, right);
  }

  return dot > 0;
}

function function_84e592007021cc09(dir, forward_vec, up_vec) {
  if(!isDefined(up_vec)) {
    up_vec = (0, 0, 1);
  }

  cross = vectorcross(forward_vec, up_vec);
  dot = vectordot(cross, dir);
  return dot > 0;
}

function function_1243a6cc6a030f2a(point, center, half_size, forward_angles) {
  dir_to_point = point - center;
  result = center;
  axis_array = anglestoaxis(forward_angles);
  axis_vecs = [axis_array["forward"], axis_array["right"], axis_array["up"]];

  for(i = 0; i <= 2; i++) {
    dist = vectordot(axis_vecs[i], dir_to_point);
    dist = clamp(dist, -1 * half_size[i], half_size[i]);
    result += dist * axis_vecs[i];
  }

  return result;
}

function function_2e0e9b10b9c74d9e(point, segment_start, segment_end) {
  segment_vec = segment_end - segment_start;
  to_point_vec = point - segment_start;
  var_58c5e9b71b63dbc5 = vectordot(segment_vec, segment_vec);

  if(var_58c5e9b71b63dbc5 == 0) {
    return segment_start;
  }

  t = vectordot(to_point_vec, segment_vec) / var_58c5e9b71b63dbc5;
  t = clamp(t, 0, 1);
  closest_point = segment_start + t * segment_vec;
  return closest_point;
}

function random_vector_2d() {
  var_4d9b73147ea83832 = randomfloat(360);
  return (cos(var_4d9b73147ea83832), sin(var_4d9b73147ea83832), 0);
}

function set_matrix_from_up(new_up) {
  current_foward = anglesToForward(self.angles);
  new_right = vectorcross(current_foward, new_up);
  new_forward = vectorcross(new_up, new_right);
  self.angles = axistoangles(new_forward, new_right, new_up);
}

function set_matrix_from_up_and_angles(new_up, var_6212749e8a0bfd6e) {
  if(!isDefined(var_6212749e8a0bfd6e)) {
    var_6212749e8a0bfd6e = self.angles;
  }

  self.angles = build_matrix_from_up_and_angles(new_up, var_6212749e8a0bfd6e);
}

function build_matrix_from_up_and_angles(new_up, var_6212749e8a0bfd6e) {
  var_4457dd7dff80535a = acos(-1 * vectordot(anglesToForward(var_6212749e8a0bfd6e), new_up));
  new_forward = anglestoup(var_6212749e8a0bfd6e + (var_4457dd7dff80535a, 0, 0));
  new_right = vectorcross(new_forward, new_up);
  new_forward = vectorcross(new_up, new_right);
  return axistoangles(new_forward, new_right, new_up);
}

function critically_damped_move_to(target_pos, spring_factor, start_speed) {
  thread critically_damped_move_to_thread(target_pos, spring_factor, start_speed);
}

function critically_damped_move_to_thread(target_pos, spring_factor, start_speed) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(start_speed)) {
    start_speed = 1;
  }

  spring_index = spring_make_critically_damped(spring_factor, self.origin, anglesToForward(self.angles) * start_speed);

  while(distancesquared(self.origin, target_pos) > squared(0.1)) {
    self.origin = spring_update(spring_index, target_pos);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(spring_index);
}

function critically_damped_move_and_rotate_to(target_pos, spring_factor, start_speed) {
  thread critically_damped_move_and_rotate_to_thread(target_pos, spring_factor, start_speed);
}

function critically_damped_move_and_rotate_to_thread(target_pos, spring_factor, start_speed) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(start_speed)) {
    start_speed = 1;
  }

  spring_index = spring_make_critically_damped(spring_factor, self.origin, anglesToForward(self.angles) * start_speed);

  while(distancesquared(self.origin, target_pos) > squared(0.1)) {
    self.origin = spring_update(spring_index, target_pos);
    self.angles = vectortoangles(spring_get_vel(spring_index));
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(spring_index);
}

function function_5cf1e88395e33eba(start_point, target_point, yaw_limit, start_yaw) {
  yaw = start_yaw;
  target_yaw = vectortoyaw(target_point - start_point);
  diff = angleclamp180(target_yaw - yaw);
  new_yaw = undefined;

  if(abs(diff) < yaw_limit) {
    new_yaw = target_yaw;
  } else {
    new_yaw = yaw + utility::sign(diff) * yaw_limit;
  }

  return int(new_yaw);
}

function function_27800ff2fd4867c6(start_angle, target_angle, limit) {
  diff = angleclamp180(target_angle - start_angle);
  new_angle = undefined;

  if(abs(diff) < limit) {
    new_angle = target_angle;
  } else {
    new_angle = start_angle + utility::sign(diff) * limit;
  }

  return new_angle;
}

function function_235fe1fdb403e4b2(vector, pitch, up_vector = (0, 0, 1)) {
  assert(vector != up_vector, "<dev string:x105>");
  right_vec = vectorcross(vector, up_vector);
  new_vector = rotatepointaroundvector(right_vec, vector, pitch);
  return new_vector;
}

function function_b77296185c2d6c26(start_value, target_value, limit) {
  diff = target_value - start_value;
  new_value = undefined;

  if(abs(diff) < limit) {
    new_value = target_value;
  } else {
    new_value = start_value + utility::sign(diff) * limit;
  }

  return new_value;
}

function function_b642fd3e37ae7eb4(start_vector, target_vector, limit) {
  diff = target_vector - start_vector;
  new_vector = undefined;

  if(length(diff) < limit) {
    new_vector = target_vector;
  } else {
    new_vector = start_vector + vectorNormalize(diff) * limit;
  }

  return new_vector;
}

function function_562709d61af16bd4(center, outer_radius, inner_radius, begin_yaw, end_yaw) {
  ratio = 0;

  if(isDefined(inner_radius)) {
    ratio = clamp(inner_radius / outer_radius, 0, 1);
  }

  if(!isDefined(begin_yaw)) {
    begin_yaw = 0;
  }

  if(!isDefined(end_yaw)) {
    end_yaw = 360;
  }

  radius = outer_radius * sqrt(randomfloatrange(ratio * ratio, 1));
  theta = randomfloatrange(begin_yaw, end_yaw);
  offset = (cos(theta) * radius, sin(theta) * radius, 0);
  return center + offset;
}

function over_damped_move_to(target_pos, spring_factor, spring_drag, start_speed) {
  thread over_damped_move_to_thread(target_pos, spring_factor, spring_drag, start_speed);
}

function over_damped_move_to_thread(target_pos, spring_factor, spring_drag, start_speed) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(start_speed)) {
    start_speed = 1;
  }

  spring_index = spring_make_over_damped(spring_factor, spring_drag, self.origin, anglesToForward(self.angles) * start_speed);

  while(distancesquared(self.origin, target_pos) > squared(0.1)) {
    self.origin = spring_update(spring_index, target_pos);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(spring_index);
}

function under_damped_move_to(target_pos, freq, damp, start_speed) {
  thread under_damped_move_to_thread(target_pos, freq, damp, start_speed);
}

function under_damped_move_to_thread(target_pos, freq, damp, start_speed) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(start_speed)) {
    start_speed = 1;
  }

  spring_index = spring_make_under_damped(freq, damp, self.origin, anglesToForward(self.angles) * start_speed);

  while(distancesquared(self.origin, target_pos) > squared(0.1) || length(spring_get_vel(spring_index)) < squared(0.1)) {
    self.origin = spring_update(spring_index, target_pos);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(spring_index);
}

function spring_make_critically_damped(spring_factor, start_pos, start_vel) {
  spring_index = spring_add(start_pos, start_vel);
  k = spring_factor * 0.05;
  e = exp(-1 * k);
  level.springs[spring_index].c0 = (k + 1) * e;
  level.springs[spring_index].c1 = e;
  level.springs[spring_index].c2 = -1 * k * k * e;
  level.springs[spring_index].c3 = (1 - k) * e;
  spring_set_pos(spring_index, start_pos);
  spring_set_vel(spring_index, start_vel);
  return spring_index;
}

function spring_make_over_damped(spring_factor, spring_drag, start_pos, start_vel) {
  assert(spring_drag > 0);
  spring_index = spring_add(start_pos, start_vel);
  k = spring_factor * spring_factor;
  c = -1 * sqrt(spring_drag * spring_drag + 4 * k);
  r1 = 0.5 * (c + spring_drag);
  r2 = 0.5 * (c - spring_drag);
  dr = r2 - r1;
  rdr = 1 / dr;
  e1 = exp(r1 * 0.05);
  e2 = exp(r2 * 0.05);
  de = e2 - e1;
  level.springs[spring_index].c1 = de * rdr;
  level.springs[spring_index].c0 = e1 - r1 * level.springs[spring_index].c1;
  level.springs[spring_index].c3 = (r2 * e2 - r1 * e1) * rdr;
  level.springs[spring_index].c2 = r1 * (e1 - level.springs[spring_index].c3);
  spring_set_pos(spring_index, start_pos);
  spring_set_vel(spring_index, start_vel);
  return spring_index;
}

function spring_make_under_damped(freq, damp, start_pos, start_vel) {
  assert(freq > 0);
  spring_index = spring_add(start_pos, start_vel);
  h = -0.5 * damp;
  w = freq;
  e = exp(h * 0.05) / w;
  angle = angleclamp(w * 0.05);
  s = sin(angle);
  c = cos(angle);
  wc = w * c;
  hs = h * s;
  level.springs[spring_index].c0 = e * (wc - hs);
  level.springs[spring_index].c1 = e * s;
  level.springs[spring_index].c2 = e * -1 * s * (h * h + w * w);
  level.springs[spring_index].c3 = e * (wc + hs);
  spring_set_pos(spring_index, start_pos);
  spring_set_vel(spring_index, start_vel);
  return spring_index;
}

function spring_update(spring_index, target_pos, overwrite_pos, overwrite_vel) {
  if(isDefined(overwrite_pos)) {
    spring_set_pos(spring_index, overwrite_pos);
  }

  if(isDefined(overwrite_vel)) {
    spring_set_vel(spring_index, overwrite_vel);
  }

  adjusted_pos = level.springs[spring_index].pos - target_pos;
  new_pos = level.springs[spring_index].c0 * adjusted_pos + level.springs[spring_index].c1 * level.springs[spring_index].vel;
  new_vel = level.springs[spring_index].c2 * adjusted_pos + level.springs[spring_index].c3 * level.springs[spring_index].vel;
  level.springs[spring_index].pos = new_pos + target_pos;
  level.springs[spring_index].vel = new_vel;
  return level.springs[spring_index].pos;
}

function spring_delete(spring_index) {
  level.springs[spring_index] = undefined;
}

function spring_get_pos(spring_index) {
  return level.springs[spring_index].pos;
}

function spring_get_vel(spring_index) {
  return level.springs[spring_index].vel;
}

function spring_init() {
  if(!isDefined(level.springs)) {
    level.springs = [];
    level.spring_count = 0;
  }
}

function spring_add(start_pos, start_vel) {
  spring_init();
  new_spring_index = level.spring_count;
  level.spring_count++;
  level.springs[new_spring_index] = spawnStruct();
  level.springs[new_spring_index].pos = start_pos;
  level.springs[new_spring_index].vel = start_vel;
  level.springs[new_spring_index].c0 = 0;
  level.springs[new_spring_index].c1 = 0;
  level.springs[new_spring_index].c2 = 0;
  level.springs[new_spring_index].c3 = 0;
  return new_spring_index;
}

function spring_set_pos(spring_index, pos) {
  level.springs[spring_index].pos = pos;
}

function spring_set_vel(spring_index, vel) {
  level.springs[spring_index].vel = vel;
}

function random_normal_distribution(mean, std_deviation, lower_bound, upper_bound) {
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

  if(number < lower_bound) {
    number = lower_bound;
  }

  if(number > upper_bound) {
    number = upper_bound;
  }

  return number;
}

function function_78a5b128a3e32460(origin, radius) {
  r = sqrt(radius);
  theta = randomfloat(360);
  offset = (r * cos(theta), r * sin(theta), 0);
  randompoint = origin + offset;
  randompoint = getclosestpointonnavmesh(randompoint);
  return randompoint;
}

function function_ad1b3fbc486397da(var_e2607b109a0b1419, var_56c01eedcd65f5ee, var_b23738be0590b3a6, n_delta_time) {
  var_56c01eedcd65f5ee = vectorNormalize(var_56c01eedcd65f5ee);
  var_1999be4f1fd880b2 = (cos(var_b23738be0590b3a6) + squared(var_56c01eedcd65f5ee[0]) * (1 - cos(var_b23738be0590b3a6)), var_56c01eedcd65f5ee[0] * var_56c01eedcd65f5ee[1] * (1 - cos(var_b23738be0590b3a6)) - var_56c01eedcd65f5ee[2] * sin(var_b23738be0590b3a6), var_56c01eedcd65f5ee[0] * var_56c01eedcd65f5ee[2] * (1 - cos(var_b23738be0590b3a6)) + var_56c01eedcd65f5ee[1] * sin(var_b23738be0590b3a6));
  var_1999bf4f1fd882e5 = (var_56c01eedcd65f5ee[1] * var_56c01eedcd65f5ee[0] * (1 - cos(var_b23738be0590b3a6)) + var_56c01eedcd65f5ee[2] * sin(var_b23738be0590b3a6), cos(var_b23738be0590b3a6) + squared(var_56c01eedcd65f5ee[1]) * (1 - cos(var_b23738be0590b3a6)), var_56c01eedcd65f5ee[1] * var_56c01eedcd65f5ee[2] * (1 - cos(var_b23738be0590b3a6) - var_56c01eedcd65f5ee[0] * sin(var_b23738be0590b3a6)));
  var_1999bc4f1fd87c4c = (var_56c01eedcd65f5ee[2] * var_56c01eedcd65f5ee[0] * (1 - cos(var_b23738be0590b3a6)) - var_56c01eedcd65f5ee[1] * sin(var_b23738be0590b3a6), var_56c01eedcd65f5ee[2] * var_56c01eedcd65f5ee[1] * (1 - cos(var_b23738be0590b3a6) + var_56c01eedcd65f5ee[0] * sin(var_b23738be0590b3a6)), cos(var_b23738be0590b3a6) + squared(var_56c01eedcd65f5ee[2]) * (1 - cos(var_b23738be0590b3a6)));
  var_c703ee67dccce7f3 = self.origin - var_e2607b109a0b1419;
  var_3461ff8bd4ac79b9 = (vectordot(var_1999be4f1fd880b2, var_c703ee67dccce7f3), vectordot(var_1999bf4f1fd882e5, var_c703ee67dccce7f3), vectordot(var_1999bc4f1fd87c4c, var_c703ee67dccce7f3));
  var_ac363df0c4bb98e4 = var_e2607b109a0b1419 + var_3461ff8bd4ac79b9;
  self moveTo(var_ac363df0c4bb98e4, n_delta_time);
}

function function_2f40252ef1a28501(center, radius, num_points = 8, starting_angles = (0, 0, 0), draw_debug = 0, alternate_direction = 0, var_56375ecf63b3bc10, ...) {
  center_x = center[0];
  center_y = center[1];
  center_z = center[2];
  starting_angles_delta = anglesdelta((0, 0, 0), starting_angles);
  anglefrac = 360 / num_points;

  if(!isDefined(var_56375ecf63b3bc10)) {
    points = [];
  }

  if(draw_debug) {
    sphere(center, 20, (0, 0, 0), 0, 50);
  }

  for(i = 0; i < num_points; i++) {
    angle = anglefrac * i;

    if(alternate_direction && i % 2 == 1) {
      angle *= -1;
    }

    angle += starting_angles_delta;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    point = (center_x + xadd, center_y + yadd, center_z);

    if(isDefined(var_56375ecf63b3bc10)) {
      var_9d5a46a2c7604aa6 = [[var_56375ecf63b3bc10]](point, flat_args(vararg, varargcount));

      if(var_9d5a46a2c7604aa6) {
        if(draw_debug) {
          sphere(point, 20, (0, 1, 0), 0, 50);
        }

        return point;
      }

      if(draw_debug) {
        sphere(point, 20, (1, 0, 0), 0, 50);
      }

      continue;
    }

    if(draw_debug) {
      sphere(point, 20, (0, 0, 1), 0, 50);
    }

    points[points.size] = point;
  }

  return points;
}