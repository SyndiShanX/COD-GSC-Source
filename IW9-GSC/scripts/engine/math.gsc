/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\math.gsc
***********************************************/

anglebetweenvectors(_id_02B2BE2708DF81CD, _id_02B2BB2708DF7B34) {
  return acos(clamp(vectordot(_id_02B2BE2708DF81CD, _id_02B2BB2708DF7B34) / (length(_id_02B2BE2708DF81CD) * length(_id_02B2BB2708DF7B34)), -1, 1));
}

anglebetweenvectorsunit(_id_CDE77078F534191C, _id_CDE77378F5341FB5) {
  return acos(vectordot(_id_CDE77078F534191C, _id_CDE77378F5341FB5));
}

anglebetweenvectorssigned(_id_02B2BE2708DF81CD, _id_02B2BB2708DF7B34, _id_12CAEB2454E24879) {
  _id_9601C225B7890378 = vectorNormalize(_id_02B2BE2708DF81CD);
  _id_9601C525B7890A11 = vectorNormalize(_id_02B2BB2708DF7B34);
  angle = acos(clamp(vectordot(_id_9601C225B7890378, _id_9601C525B7890A11), -1, 1));
  _id_775361D05A790917 = vectorcross(_id_9601C225B7890378, _id_9601C525B7890A11);

  if(vectordot(_id_775361D05A790917, _id_12CAEB2454E24879) < 0)
    angle = angle * -1;

  return angle;
}

lerp(from, to, frac) {
  return from + (to - from) * frac;
}

lerp_fraction(from, to, n) {
  return (n - from) / (to - from);
}

fake_slerp(from, to, fraction) {
  return (angle_lerp(from[0], to[0], fraction), angle_lerp(from[1], to[1], fraction), angle_lerp(from[2], to[2], fraction));
}

angle_lerp(from, to, fraction) {
  return angleclamp(from + angleclamp180(to - from) * fraction);
}

get_dot(start_origin, start_angles, end_origin) {
  normal = vectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot;
}

vector_project_onto_plane(_id_16290C9DDA466BCE, normal) {
  return _id_16290C9DDA466BCE - vectordot(normal, _id_16290C9DDA466BCE) / squared(length(normal)) * normal;
}

vector_project_endpoint(origin, angles, _id_46F432042B3473D8) {
  dir = anglesToForward(angles);
  dir = dir * _id_46F432042B3473D8;
  end = origin + dir;
  return end;
}

vector_reflect(_id_16290C9DDA466BCE, normal) {
  return vectorNormalize(2 * vector_project_onto_plane(_id_16290C9DDA466BCE, normal) - _id_16290C9DDA466BCE);
}

vector_area_parallelogram(v, a, b) {
  return a[0] * b[1] - a[1] * b[0] + (b[0] * v[1] - v[0] * b[1]) + (v[0] * a[1] - a[0] * v[1]);
}

scalar_projection(_id_96021225B789B368, _id_96021525B789BA01) {
  return vectordot(vectorNormalize(_id_96021225B789B368), _id_96021525B789BA01);
}

get_point_on_parabola(start, end, height, t) {
  _id_B850E09EEB4AC957 = t * 2 - 1;
  direction = end - start;
  up = (0, 0, 1);
  result = start + t * direction;
  result = result + (_id_B850E09EEB4AC957 * _id_B850E09EEB4AC957 * -1 + 1) * height * up;
  return result;
}

get_mid_point(_id_4AD9B5BAA7793165, _id_4AD9B2BAA7792ACC) {
  return ((_id_4AD9B5BAA7793165[0] + _id_4AD9B2BAA7792ACC[0]) * 0.5, (_id_4AD9B5BAA7793165[1] + _id_4AD9B2BAA7792ACC[1]) * 0.5, (_id_4AD9B5BAA7793165[2] + _id_4AD9B2BAA7792ACC[2]) * 0.5);
}

round_float(value, _id_3E9F2F6A1F326C03, down) {
  _id_3E9F2F6A1F326C03 = int(_id_3E9F2F6A1F326C03);

  if(_id_3E9F2F6A1F326C03 < 0 || _id_3E9F2F6A1F326C03 > 4)
    return value;

  _id_0C0CE16DB90DA842 = 1;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_3E9F2F6A1F326C03; _id_AC0E594AC96AA3A8++)
    _id_0C0CE16DB90DA842 = _id_0C0CE16DB90DA842 * 10;

  _id_F27D0B5C6511561E = value * _id_0C0CE16DB90DA842;

  if(!isDefined(down) || down)
    _id_F27D0B5C6511561E = floor(_id_F27D0B5C6511561E);
  else
    _id_F27D0B5C6511561E = ceil(_id_F27D0B5C6511561E);

  value = _id_F27D0B5C6511561E / _id_0C0CE16DB90DA842;
  return value;
}

round_millisec_on_sec(value, _id_3E9F2F6A1F326C03, down) {
  _id_2514CE91ADDE4E58 = value / 1000;
  _id_2514CE91ADDE4E58 = round_float(_id_2514CE91ADDE4E58, _id_3E9F2F6A1F326C03, down);
  value = _id_2514CE91ADDE4E58 * 1000;
  return int(value);
}

remap(value, _id_3C58D40EE22036AE, _id_C979000E8E5B2AEC, _id_3C58D30EE220347B, _id_C979030E8E5B3185) {
  return _id_3C58D30EE220347B + (value - _id_3C58D40EE22036AE) * (_id_C979030E8E5B3185 - _id_3C58D30EE220347B) / (_id_C979000E8E5B2AEC - _id_3C58D40EE22036AE);
}

normalize_value(_id_07194AF5332B54E4, _id_07194DF5332B5B7D, _id_A8FE33CE005D9C1E) {
  if(_id_07194AF5332B54E4 > _id_07194DF5332B5B7D) {
    _id_DA611C632FE7481B = _id_07194AF5332B54E4;
    _id_07194AF5332B54E4 = _id_07194DF5332B5B7D;
    _id_07194DF5332B5B7D = _id_DA611C632FE7481B;
  }

  if(_id_A8FE33CE005D9C1E > _id_07194DF5332B5B7D)
    return 1.0;
  else if(_id_A8FE33CE005D9C1E < _id_07194AF5332B54E4)
    return 0.0;
  else if(_id_07194AF5332B54E4 == _id_07194DF5332B5B7D) {}

  return (_id_A8FE33CE005D9C1E - _id_07194AF5332B54E4) / (_id_07194DF5332B5B7D - _id_07194AF5332B54E4);
}

normalized_to_growth_clamps(min, max, value) {
  return (max - min) * squared(value) + min;
}

normalized_to_decay_clamps(min, max, value) {
  return normalized_to_growth_clamps(min, max, 1 - value);
}

normalized_parabola(x) {
  return -1 * squared(2 * x - 1) + 1;
}

normalized_sin_wave(x) {
  y = x * 2 * 3.14159 - 1.5708;
  y = (sin(radians_to_degrees(y)) + 1) * 0.5;
  return y;
}

normalized_cos_wave(x) {
  y = x * 2 * 3.14159;
  y = (cos(radians_to_degrees(y)) + 1) * 0.5;
  return y;
}

_id_4118613456C64C5E(value, _id_1A0C5BC8003822F2) {
  value = value + _id_1A0C5BC8003822F2;

  if(value > 1)
    value = value - 1;

  if(value < 0)
    value = value + 1;

  return value;
}

radians_to_degrees(_id_75358E383EBEDF15) {
  return _id_75358E383EBEDF15 * 57.2958;
}

degrees_to_radians(_id_D90439D9C610BE2A) {
  return _id_D90439D9C610BE2A * 0.0174533;
}

factor_value(_id_BC94ADD9A6699813, _id_2E882FB3D40AB2B5, _id_C803FF82836FF926) {
  return _id_2E882FB3D40AB2B5 * _id_C803FF82836FF926 + _id_BC94ADD9A6699813 * (1 - _id_C803FF82836FF926);
}

_id_889BEF0AD1600791(num) {
  if(num < 0.5) {
    num = num * 2;
    num = normalized_float_smooth_in(num);
    num = num * 0.5;
  } else {
    num = (num - 0.5) * 2;
    num = normalized_float_smooth_out(num);
    num = num * 0.5 + 0.5;
  }

  return num;
}

normalized_float_smooth_in(num) {
  return num * num;
}

normalized_float_smooth_out(num) {
  num = 1 - num;
  num = num * num;
  num = 1 - num;
  return num;
}

line_to_plane_intersection(_id_D747962793D54B7D, _id_D747932793D544E4, _id_0CAB2B4B6598610C, _id_9A94AB20E73B29A9) {
  _id_AC0E564AC96A9D0F = vectordot(_id_9A94AB20E73B29A9, _id_0CAB2B4B6598610C);
  _id_CB921303144E9E43 = _id_D747932793D544E4 - _id_D747962793D54B7D;
  _id_F93D442FEE36CEED = vectordot(_id_9A94AB20E73B29A9, _id_CB921303144E9E43);

  if(_id_F93D442FEE36CEED == 0)
    return undefined;

  t = (_id_AC0E564AC96A9D0F - vectordot(_id_9A94AB20E73B29A9, _id_D747962793D54B7D)) / _id_F93D442FEE36CEED;
  _id_5772A8229FD0EE85 = _id_D747962793D54B7D + _id_CB921303144E9E43 * t;
  return _id_5772A8229FD0EE85;
}

ray_to_plane_intersection_distance(_id_B7034EF67B8CA88D, _id_60AAA286CD521D8C, _id_D74074AD5396E58A, _id_FAD8BA79DADAF9EE) {
  return vectordot(_id_D74074AD5396E58A - _id_B7034EF67B8CA88D, _id_FAD8BA79DADAF9EE) / vectordot(_id_60AAA286CD521D8C, _id_FAD8BA79DADAF9EE);
}

_id_B2858FF2D7212BA7(point, start, end) {
  _id_496CEEBAA5E8670B = (point[0], point[1], 0);
  _id_B571FC374074E645 = (start[0], start[1], 0);
  _id_E2D1DB45F01495D8 = (end[0], end[1], 0);
  _id_EA13048AE45874C6 = vectorNormalize(_id_496CEEBAA5E8670B - _id_B571FC374074E645);
  forward = vectorNormalize(_id_E2D1DB45F01495D8 - _id_B571FC374074E645);
  dot = vectordot(_id_EA13048AE45874C6, forward);
  return dot > 0;
}

_id_D2C0D8330AB7AD7F(start, end, circlecenter, circleradius) {
  _id_CDEFFC78F53D38AE = start[0] - circlecenter[0];
  _id_CDEB7878F538208B = start[1] - circlecenter[1];
  _id_CDEFFB78F53D367B = end[0] - circlecenter[0];
  _id_CDEB7978F53822BE = end[1] - circlecenter[1];
  r = float(circleradius);
  _id_CE253D78F5784CB5 = _id_CDEFFB78F53D367B - _id_CDEFFC78F53D38AE;
  _id_CE253C78F5784A82 = _id_CDEB7978F53822BE - _id_CDEB7878F538208B;
  _id_CE254378F57859E7 = _id_CE253D78F5784CB5 * _id_CE253D78F5784CB5 + _id_CE253C78F5784A82 * _id_CE253C78F5784A82;
  _id_AC0E564AC96A9D0F = _id_CDEFFC78F53D38AE * _id_CDEB7978F53822BE - _id_CDEFFB78F53D367B * _id_CDEB7878F538208B;
  _id_D3E7EF03D73E0D93 = r * r * _id_CE254378F57859E7 - _id_AC0E564AC96A9D0F * _id_AC0E564AC96A9D0F;

  if(_id_D3E7EF03D73E0D93 < 0)
    return;
  else if(_id_D3E7EF03D73E0D93 == 0) {
    _id_BF6A113C5A54166F = _id_AC0E564AC96A9D0F * _id_CE253C78F5784A82 / _id_CE254378F57859E7 + circlecenter[0];
    _id_BF6A103C5A54143C = -1 * _id_AC0E564AC96A9D0F * _id_CE253D78F5784CB5 / _id_CE254378F57859E7 + circlecenter[1];
    return [(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 0)];
  } else {
    _id_CC551EACDE13F215 = sqrt(_id_D3E7EF03D73E0D93);
    _id_CDF02C78F53DA23E = _id_AC0E564AC96A9D0F * _id_CE253C78F5784A82;
    _id_CDF02B78F53DA00B = scripts\engine\utility::sign(_id_CE253C78F5784A82) * _id_CE253D78F5784CB5 * _id_CC551EACDE13F215;
    _id_495FF8BAA5DA6884 = (_id_CDF02C78F53DA23E + _id_CDF02B78F53DA00B) / _id_CE254378F57859E7 + circlecenter[0];
    _id_496CFABAA5E8816F = (_id_CDF02C78F53DA23E - _id_CDF02B78F53DA00B) / _id_CE254378F57859E7 + circlecenter[0];
    _id_CDEB4878F537B6FB = -1 * _id_AC0E564AC96A9D0F * _id_CE253D78F5784CB5;
    _id_CDEB4978F537B92E = abs(_id_CE253C78F5784A82) * _id_CC551EACDE13F215;
    _id_495FF9BAA5DA6AB7 = (_id_CDEB4878F537B6FB + _id_CDEB4978F537B92E) / _id_CE254378F57859E7 + circlecenter[1];
    _id_496CF9BAA5E87F3C = (_id_CDEB4878F537B6FB - _id_CDEB4978F537B92E) / _id_CE254378F57859E7 + circlecenter[1];
    return [(_id_495FF8BAA5DA6884, _id_495FF9BAA5DA6AB7, 0), (_id_496CFABAA5E8816F, _id_496CF9BAA5E87F3C, 0)];
  }
}

_id_CC2AD02DCF5030D8(start, end, circleorigin, circleradius) {
  result = _id_D2C0D8330AB7AD7F(start, end, circleorigin, circleradius);

  if(!isDefined(result))
    return;
  else if(result.size == 1) {
    if(_id_B2858FF2D7212BA7(result[0], start, end))
      return result;
  } else {
    _id_7A5BCC8FDBC7FB9E = _id_B2858FF2D7212BA7(result[0], start, end);
    _id_80D347F931A2E541 = _id_B2858FF2D7212BA7(result[1], start, end);

    if(!_id_7A5BCC8FDBC7FB9E && !_id_80D347F931A2E541)
      return;
    else if(_id_7A5BCC8FDBC7FB9E && !_id_80D347F931A2E541)
      return result[0];
    else if(_id_80D347F931A2E541 && !_id_7A5BCC8FDBC7FB9E)
      return result[1];
    else {
      _id_4574AE4853374F88 = distance2dsquared(start, result[0]);
      _id_4574B14853375621 = distance2dsquared(start, result[1]);

      if(_id_4574AE4853374F88 < _id_4574B14853375621)
        return result[0];
      else
        return result[1];
    }
  }
}

segmentvssphere(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D, _id_507E3E6432C4FFAD, _id_C77E7A25454430DA) {
  if(_id_BF6A083C5A5402A4 == _id_BF6A0B3C5A54093D)
    return 0;

  _id_1B1C7BE2A8E1295C = _id_507E3E6432C4FFAD - _id_BF6A083C5A5402A4;
  _id_5CEF7CFD464E0781 = _id_BF6A0B3C5A54093D - _id_BF6A083C5A5402A4;
  _id_80D56F0DCA67F561 = clamp(vectordot(_id_1B1C7BE2A8E1295C, _id_5CEF7CFD464E0781) / vectordot(_id_5CEF7CFD464E0781, _id_5CEF7CFD464E0781), 0, 1);
  closestpoint = _id_BF6A083C5A5402A4 + _id_5CEF7CFD464E0781 * _id_80D56F0DCA67F561;
  return lengthsquared(_id_507E3E6432C4FFAD - closestpoint) <= _id_C77E7A25454430DA * _id_C77E7A25454430DA;
}

pointvscone(point, _id_7D4419EEE2E4CB28, _id_16062DA7C74D1D43, _id_8DB1F601729968B3, _id_9EACE12F534AD325, _id_DA2CE43C649B224A, _id_5A151D2FDC3AD81A, _id_EA4FDBA37C5B9244) {
  _id_32A966523B6D08A0 = point - _id_7D4419EEE2E4CB28;
  _id_3ABE054FBF02D18D = vectordot(_id_32A966523B6D08A0, _id_16062DA7C74D1D43);
  _id_E6CB9C8CCD2BC82D = vectordot(_id_32A966523B6D08A0, _id_8DB1F601729968B3);

  if(_id_3ABE054FBF02D18D > _id_9EACE12F534AD325)
    return 0;

  if(_id_3ABE054FBF02D18D < _id_DA2CE43C649B224A)
    return 0;

  if(isDefined(_id_EA4FDBA37C5B9244)) {
    if(abs(_id_E6CB9C8CCD2BC82D) > _id_EA4FDBA37C5B9244)
      return 0;
  }

  if(anglebetweenvectors(_id_16062DA7C74D1D43, _id_32A966523B6D08A0) > _id_5A151D2FDC3AD81A)
    return 0;

  return 1;
}

pointvscylinder(point, _id_F85C8A0556EDF077, height, origin, up) {
  _id_340D59422336E85A = point - origin;
  _id_0A0C60260C964694 = vectordot(_id_340D59422336E85A, up);

  if(_id_0A0C60260C964694 < 0 || _id_0A0C60260C964694 > height)
    return 0;

  _id_340D59422336E85A = _id_340D59422336E85A - _id_0A0C60260C964694 * up;
  _id_96FB14702AE758B4 = lengthsquared(_id_340D59422336E85A);

  if(_id_96FB14702AE758B4 > _id_F85C8A0556EDF077)
    return 0;

  return 1;
}

point_side_of_line2d(v, a, b) {
  area = vector_area_parallelogram(v, a, b);

  if(area > 0.0)
    return "left";

  return "right";
}

wrap(min, max, value) {
  _id_66A7A56D18CCA472 = max - min + 1;

  if(value < min)
    value = value + _id_66A7A56D18CCA472 * int((min - value) / _id_66A7A56D18CCA472 + 1);

  return min + (value - min) % _id_66A7A56D18CCA472;
}

point_in_fov(origin, fov, _id_871EA848F69E124F) {
  if(!isDefined(origin)) {
    return;
  }
  if(!isDefined(fov))
    fov = 0.766;

  if(isPlayer(self))
    forward = anglesToForward(self getplayerangles(!istrue(_id_871EA848F69E124F)));
  else
    forward = anglesToForward(self.angles);

  _id_62F4DA066051326C = vectorNormalize(origin - self.origin);
  dot = vectordot(forward, _id_62F4DA066051326C);
  return dot > fov;
}

within_fov_2d(start_origin, start_angles, end_origin, fov) {
  normal = vectorNormalize((end_origin[0], end_origin[1], 0) - (start_origin[0], start_origin[1], 0));
  forward = anglesToForward((0, start_angles[1], 0));
  return vectordot(forward, normal) >= fov;
}

is_point_in_front(point) {
  dot = 0;

  if(isent(self) && isPlayer(self)) {
    _id_485B74CB677A51A9 = point - self getorigin();
    forward = anglesToForward(self getplayerangles(1));
    dot = vectordot(_id_485B74CB677A51A9, forward);
  } else {
    _id_485B74CB677A51A9 = point - self.origin;
    forward = anglesToForward(self.angles);
    dot = vectordot(_id_485B74CB677A51A9, forward);
  }

  return dot > 0;
}

is_point_on_right(point) {
  dot = 0;

  if(isPlayer(self)) {
    _id_485B74CB677A51A9 = point - self getorigin();
    right = anglestoright(self getplayerangles(1));
    dot = vectordot(_id_485B74CB677A51A9, right);
  } else {
    _id_485B74CB677A51A9 = point - self.origin;
    right = anglestoright(self.angles);
    dot = vectordot(_id_485B74CB677A51A9, right);
  }

  return dot > 0;
}

_id_6C1E6433C5E5CF79(point, center, half_size, _id_3BBE2F748D8AFB73) {
  _id_9B91A9E577670535 = point - center;
  result = center;
  _id_161C18750F51FE9E = anglestoaxis(_id_3BBE2F748D8AFB73);
  _id_A53038DCFD7D76DA = [_id_161C18750F51FE9E["forward"], _id_161C18750F51FE9E["right"], _id_161C18750F51FE9E["up"]];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 2; _id_AC0E594AC96AA3A8++) {
    dist = vectordot(_id_A53038DCFD7D76DA[_id_AC0E594AC96AA3A8], _id_9B91A9E577670535);
    dist = clamp(dist, -1 * half_size[_id_AC0E594AC96AA3A8], half_size[_id_AC0E594AC96AA3A8]);
    result = result + dist * _id_A53038DCFD7D76DA[_id_AC0E594AC96AA3A8];
  }

  return result;
}

random_vector_2d() {
  _id_057338C9E11B3E93 = randomfloat(360);
  return (cos(_id_057338C9E11B3E93), sin(_id_057338C9E11B3E93), 0.0);
}

set_matrix_from_up(_id_9F6F345AB78551FB) {
  _id_6139C7AE54A7BADA = anglesToForward(self.angles);
  _id_B2B893575005B08C = vectorcross(_id_6139C7AE54A7BADA, _id_9F6F345AB78551FB);
  _id_93D8002C576C2E0B = vectorcross(_id_9F6F345AB78551FB, _id_B2B893575005B08C);
  self.angles = axistoangles(_id_93D8002C576C2E0B, _id_B2B893575005B08C, _id_9F6F345AB78551FB);
}

set_matrix_from_up_and_angles(_id_9F6F345AB78551FB, _id_08583B7021EC2367) {
  if(!isDefined(_id_08583B7021EC2367))
    _id_08583B7021EC2367 = self.angles;

  self.angles = build_matrix_from_up_and_angles(_id_9F6F345AB78551FB, _id_08583B7021EC2367);
}

build_matrix_from_up_and_angles(_id_9F6F345AB78551FB, _id_08583B7021EC2367) {
  _id_89752207BCF12F45 = acos(-1 * vectordot(anglesToForward(_id_08583B7021EC2367), _id_9F6F345AB78551FB));
  _id_93D8002C576C2E0B = anglestoup(_id_08583B7021EC2367 + (_id_89752207BCF12F45, 0, 0));
  _id_B2B893575005B08C = vectorcross(_id_93D8002C576C2E0B, _id_9F6F345AB78551FB);
  _id_93D8002C576C2E0B = vectorcross(_id_9F6F345AB78551FB, _id_B2B893575005B08C);
  return axistoangles(_id_93D8002C576C2E0B, _id_B2B893575005B08C, _id_9F6F345AB78551FB);
}

critically_damped_move_to(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F) {
  thread critically_damped_move_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F);
}

critically_damped_move_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(_id_F878DC67E6B8B59F))
    _id_F878DC67E6B8B59F = 1;

  _id_D8A4196AFBA8742B = spring_make_critically_damped(_id_6F3B0221662DBF46, self.origin, anglesToForward(self.angles) * _id_F878DC67E6B8B59F);

  while(distancesquared(self.origin, _id_2AE01F9836C08415) > squared(0.1)) {
    self.origin = spring_update(_id_D8A4196AFBA8742B, _id_2AE01F9836C08415);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(_id_D8A4196AFBA8742B);
}

critically_damped_move_and_rotate_to(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F) {
  thread critically_damped_move_and_rotate_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F);
}

critically_damped_move_and_rotate_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F878DC67E6B8B59F) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(_id_F878DC67E6B8B59F))
    _id_F878DC67E6B8B59F = 1;

  _id_D8A4196AFBA8742B = spring_make_critically_damped(_id_6F3B0221662DBF46, self.origin, anglesToForward(self.angles) * _id_F878DC67E6B8B59F);

  while(distancesquared(self.origin, _id_2AE01F9836C08415) > squared(0.1)) {
    self.origin = spring_update(_id_D8A4196AFBA8742B, _id_2AE01F9836C08415);
    self.angles = vectortoangles(spring_get_vel(_id_D8A4196AFBA8742B));
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(_id_D8A4196AFBA8742B);
}

_id_C5B0D1646EBC8EB3(start_point, _id_EC3A18275B0F901D, _id_641D483A41B435C0, _id_55EEC07C0C5C88AF) {
  yaw = _id_55EEC07C0C5C88AF;
  _id_91684A9882455754 = vectortoyaw(_id_EC3A18275B0F901D - start_point);
  _id_4573A8725DD3748E = angleclamp180(_id_91684A9882455754 - yaw);
  _id_D5CE8B821ABA4929 = undefined;

  if(abs(_id_4573A8725DD3748E) < _id_641D483A41B435C0)
    _id_D5CE8B821ABA4929 = _id_91684A9882455754;
  else
    _id_D5CE8B821ABA4929 = yaw + scripts\engine\utility::sign(_id_4573A8725DD3748E) * _id_641D483A41B435C0;

  return int(_id_D5CE8B821ABA4929);
}

over_damped_move_to(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F7DDBAAF878E7B63, _id_F878DC67E6B8B59F) {
  thread over_damped_move_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F7DDBAAF878E7B63, _id_F878DC67E6B8B59F);
}

over_damped_move_to_thread(_id_2AE01F9836C08415, _id_6F3B0221662DBF46, _id_F7DDBAAF878E7B63, _id_F878DC67E6B8B59F) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(_id_F878DC67E6B8B59F))
    _id_F878DC67E6B8B59F = 1;

  _id_D8A4196AFBA8742B = spring_make_over_damped(_id_6F3B0221662DBF46, _id_F7DDBAAF878E7B63, self.origin, anglesToForward(self.angles) * _id_F878DC67E6B8B59F);

  while(distancesquared(self.origin, _id_2AE01F9836C08415) > squared(0.1)) {
    self.origin = spring_update(_id_D8A4196AFBA8742B, _id_2AE01F9836C08415);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(_id_D8A4196AFBA8742B);
}

under_damped_move_to(_id_2AE01F9836C08415, _id_31B4A298F5F26A83, _id_B857D472B19D37AF, _id_F878DC67E6B8B59F) {
  thread under_damped_move_to_thread(_id_2AE01F9836C08415, _id_31B4A298F5F26A83, _id_B857D472B19D37AF, _id_F878DC67E6B8B59F);
}

under_damped_move_to_thread(_id_2AE01F9836C08415, _id_31B4A298F5F26A83, _id_B857D472B19D37AF, _id_F878DC67E6B8B59F) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(_id_F878DC67E6B8B59F))
    _id_F878DC67E6B8B59F = 1;

  _id_D8A4196AFBA8742B = spring_make_under_damped(_id_31B4A298F5F26A83, _id_B857D472B19D37AF, self.origin, anglesToForward(self.angles) * _id_F878DC67E6B8B59F);

  while(distancesquared(self.origin, _id_2AE01F9836C08415) > squared(0.1) || length(spring_get_vel(_id_D8A4196AFBA8742B)) < squared(0.1)) {
    self.origin = spring_update(_id_D8A4196AFBA8742B, _id_2AE01F9836C08415);
    wait 0.05;
  }

  self notify("movedone");
  spring_delete(_id_D8A4196AFBA8742B);
}

spring_make_critically_damped(_id_6F3B0221662DBF46, _id_D5685B7BAEE6505E, _id_B764147B98875E2F) {
  _id_D8A4196AFBA8742B = spring_add(_id_D5685B7BAEE6505E, _id_B764147B98875E2F);
  _id_AC0E5B4AC96AA80E = _id_6F3B0221662DBF46 * 0.05;
  e = exp(-1 * _id_AC0E5B4AC96AA80E);
  level.springs[_id_D8A4196AFBA8742B].c0 = (_id_AC0E5B4AC96AA80E + 1) * e;
  level.springs[_id_D8A4196AFBA8742B].c1 = e;
  level.springs[_id_D8A4196AFBA8742B].c2 = -1 * _id_AC0E5B4AC96AA80E * _id_AC0E5B4AC96AA80E * e;
  level.springs[_id_D8A4196AFBA8742B].c3 = (1 - _id_AC0E5B4AC96AA80E) * e;
  spring_set_pos(_id_D8A4196AFBA8742B, _id_D5685B7BAEE6505E);
  spring_set_vel(_id_D8A4196AFBA8742B, _id_B764147B98875E2F);
  return _id_D8A4196AFBA8742B;
}

spring_make_over_damped(_id_6F3B0221662DBF46, _id_F7DDBAAF878E7B63, _id_D5685B7BAEE6505E, _id_B764147B98875E2F) {
  _id_D8A4196AFBA8742B = spring_add(_id_D5685B7BAEE6505E, _id_B764147B98875E2F);
  _id_AC0E5B4AC96AA80E = _id_6F3B0221662DBF46 * _id_6F3B0221662DBF46;
  c = -1 * sqrt(_id_F7DDBAAF878E7B63 * _id_F7DDBAAF878E7B63 + 4.0 * _id_AC0E5B4AC96AA80E);
  _id_CDD57878F51FED58 = 0.5 * (c + _id_F7DDBAAF878E7B63);
  _id_CDD57B78F51FF3F1 = 0.5 * (c - _id_F7DDBAAF878E7B63);
  _id_CE254378F57859E7 = _id_CDD57B78F51FF3F1 - _id_CDD57878F51FED58;
  _id_CBA816031466D80F = 1.0 / _id_CE254378F57859E7;
  e1 = exp(_id_CDD57878F51FED58 * 0.05);
  e2 = exp(_id_CDD57B78F51FF3F1 * 0.05);
  _id_CE253078F578301E = e2 - e1;
  level.springs[_id_D8A4196AFBA8742B].c1 = _id_CE253078F578301E * _id_CBA816031466D80F;
  level.springs[_id_D8A4196AFBA8742B].c0 = e1 - _id_CDD57878F51FED58 * level.springs[_id_D8A4196AFBA8742B].c1;
  level.springs[_id_D8A4196AFBA8742B].c3 = (_id_CDD57B78F51FF3F1 * e2 - _id_CDD57878F51FED58 * e1) * _id_CBA816031466D80F;
  level.springs[_id_D8A4196AFBA8742B].c2 = _id_CDD57878F51FED58 * (e1 - level.springs[_id_D8A4196AFBA8742B].c3);
  spring_set_pos(_id_D8A4196AFBA8742B, _id_D5685B7BAEE6505E);
  spring_set_vel(_id_D8A4196AFBA8742B, _id_B764147B98875E2F);
  return _id_D8A4196AFBA8742B;
}

spring_make_under_damped(_id_31B4A298F5F26A83, _id_B857D472B19D37AF, _id_D5685B7BAEE6505E, _id_B764147B98875E2F) {
  _id_D8A4196AFBA8742B = spring_add(_id_D5685B7BAEE6505E, _id_B764147B98875E2F);
  h = -0.5 * _id_B857D472B19D37AF;
  _id_AC0E474AC96A7C12 = _id_31B4A298F5F26A83;
  e = exp(h * 0.05) / _id_AC0E474AC96A7C12;
  angle = angleclamp(_id_AC0E474AC96A7C12 * 0.05);
  s = sin(angle);
  c = cos(angle);
  _id_CDE33A78F52FAC83 = _id_AC0E474AC96A7C12 * c;
  _id_CE363A78F58A5078 = h * s;
  level.springs[_id_D8A4196AFBA8742B].c0 = e * (_id_CDE33A78F52FAC83 - _id_CE363A78F58A5078);
  level.springs[_id_D8A4196AFBA8742B].c1 = e * s;
  level.springs[_id_D8A4196AFBA8742B].c2 = e * -1 * s * (h * h + _id_AC0E474AC96A7C12 * _id_AC0E474AC96A7C12);
  level.springs[_id_D8A4196AFBA8742B].c3 = e * (_id_CDE33A78F52FAC83 + _id_CE363A78F58A5078);
  spring_set_pos(_id_D8A4196AFBA8742B, _id_D5685B7BAEE6505E);
  spring_set_vel(_id_D8A4196AFBA8742B, _id_B764147B98875E2F);
  return _id_D8A4196AFBA8742B;
}

spring_update(_id_D8A4196AFBA8742B, _id_2AE01F9836C08415, _id_DC3B6531176A056B, _id_F5A4C43128B87E4E) {
  if(isDefined(_id_DC3B6531176A056B))
    spring_set_pos(_id_D8A4196AFBA8742B, _id_DC3B6531176A056B);

  if(isDefined(_id_F5A4C43128B87E4E))
    spring_set_vel(_id_D8A4196AFBA8742B, _id_F5A4C43128B87E4E);

  _id_17EFC75714761B9E = level.springs[_id_D8A4196AFBA8742B].pos - _id_2AE01F9836C08415;
  _id_55A01E81BDA4CC0C = level.springs[_id_D8A4196AFBA8742B].c0 * _id_17EFC75714761B9E + level.springs[_id_D8A4196AFBA8742B].c1 * level.springs[_id_D8A4196AFBA8742B].vel;
  _id_FC441F817B4B65B9 = level.springs[_id_D8A4196AFBA8742B].c2 * _id_17EFC75714761B9E + level.springs[_id_D8A4196AFBA8742B].c3 * level.springs[_id_D8A4196AFBA8742B].vel;
  level.springs[_id_D8A4196AFBA8742B].pos = _id_55A01E81BDA4CC0C + _id_2AE01F9836C08415;
  level.springs[_id_D8A4196AFBA8742B].vel = _id_FC441F817B4B65B9;
  return level.springs[_id_D8A4196AFBA8742B].pos;
}

spring_delete(_id_D8A4196AFBA8742B) {
  level.springs[_id_D8A4196AFBA8742B] = undefined;
}

spring_get_pos(_id_D8A4196AFBA8742B) {
  return level.springs[_id_D8A4196AFBA8742B].pos;
}

spring_get_vel(_id_D8A4196AFBA8742B) {
  return level.springs[_id_D8A4196AFBA8742B].vel;
}

spring_init() {
  if(!isDefined(level.springs)) {
    level.springs = [];
    level.spring_count = 0;
  }
}

spring_add(_id_D5685B7BAEE6505E, _id_B764147B98875E2F) {
  spring_init();
  _id_E22DC56261FCF460 = level.spring_count;
  level.spring_count++;
  level.springs[_id_E22DC56261FCF460] = spawnStruct();
  level.springs[_id_E22DC56261FCF460].pos = _id_D5685B7BAEE6505E;
  level.springs[_id_E22DC56261FCF460].vel = _id_B764147B98875E2F;
  level.springs[_id_E22DC56261FCF460].c0 = 0;
  level.springs[_id_E22DC56261FCF460].c1 = 0;
  level.springs[_id_E22DC56261FCF460].c2 = 0;
  level.springs[_id_E22DC56261FCF460].c3 = 0;
  return _id_E22DC56261FCF460;
}

spring_set_pos(_id_D8A4196AFBA8742B, pos) {
  level.springs[_id_D8A4196AFBA8742B].pos = pos;
}

spring_set_vel(_id_D8A4196AFBA8742B, vel) {
  level.springs[_id_D8A4196AFBA8742B].vel = vel;
}