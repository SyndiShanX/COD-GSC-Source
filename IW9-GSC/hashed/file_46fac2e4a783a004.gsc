/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_46fac2e4a783a004.gsc
***********************************************/

main() {
  thread _id_C0331162F149609C(10.0);
  _id_EAD09275BB875C19();
  thread _id_2270E45E7ECD710E();
  _id_569AEC3F2378F201();
}

_id_0B7281BFB9645666(h, s, v) {
  if(s == 0)
    return (v, v, v);

  h = scripts\engine\utility::mod(h, 360);
  _id_1315E257CD87D760 = floor(h / 60.0);
  _id_8367D2AE5B6EDBA2 = h / 60.0 - _id_1315E257CD87D760;
  _id_AC0E424AC96A7113 = v * (1.0 - s);
  _id_AC0E414AC96A6EE0 = v * (1.0 - s * _id_8367D2AE5B6EDBA2);
  t = v * (1.0 - s * (1 - _id_8367D2AE5B6EDBA2));

  if(_id_1315E257CD87D760 == 0)
    return (v, t, _id_AC0E424AC96A7113);
  else if(_id_1315E257CD87D760 == 1)
    return (_id_AC0E414AC96A6EE0, v, _id_AC0E424AC96A7113);
  else if(_id_1315E257CD87D760 == 2)
    return (_id_AC0E424AC96A7113, v, t);
  else if(_id_1315E257CD87D760 == 3)
    return (_id_AC0E424AC96A7113, _id_AC0E414AC96A6EE0, v);
  else if(_id_1315E257CD87D760 == 4)
    return (t, _id_AC0E424AC96A7113, v);
  else if(_id_1315E257CD87D760 == 5)
    return (v, _id_AC0E424AC96A7113, _id_AC0E414AC96A6EE0);

  return (v, _id_AC0E424AC96A7113, _id_AC0E414AC96A6EE0);
}

_id_C0331162F149609C(duration) {
  level endon("game_ended");

  if(getDvar("r_reflectionprobegenerate") == "1") {
    return;
  }
  lights = getEntArray("ferris_wheel_rgb_light", "targetname");

  if(!isDefined(lights) || lights.size == 0) {
    return;
  }
  for(;;) {
    foreach(index, light in lights)
    light thread _id_4F1FD0F5003012DC(duration, float(light.script_noteworthy), 0.75);

    wait(duration);
  }
}

_id_EAD09275BB875C19() {
  level._id_2270E45E7ECD710E = getEntArray("gp_bink_light", "targetname");

  foreach(light in level._id_2270E45E7ECD710E) {
    light._id_EB99FBEA3747C2DF = light _meth_CDD36EB036403400();
    light.og_intensity = light getlightintensity();
  }
}

_id_2270E45E7ECD710E() {
  self notify("bink_display_lights");
  self endon("bink_display_lights");
  level endon("game_ended");

  if(getDvar("r_reflectionprobegenerate") == "1") {
    return;
  }
  if(!isDefined(level._id_2270E45E7ECD710E) || level._id_2270E45E7ECD710E.size == 0) {
    return;
  }
  for(;;) {
    foreach(light in level._id_2270E45E7ECD710E)
    light childthread _id_9070ECA46954F112((0.917, 0.976, 0.643), (0.776, 1, 0.588), 30, 5.0, 1, 1.5);

    wait 30;
  }
}

_id_11DC35BA5D15E22C() {
  self notify("bink_display_lights_single_shot");
  self endon("bink_display_lights_single_shot");
  level endon("game_ended");

  if(getDvar("r_reflectionprobegenerate") == "1") {
    return;
  }
  if(!isDefined(level._id_2270E45E7ECD710E) || level._id_2270E45E7ECD710E.size == 0) {
    return;
  }
  foreach(light in level._id_2270E45E7ECD710E)
  light _meth_8A5136D4D87795D4((0.819, 0.862, 1));

  wait 0.5;

  foreach(light in level._id_2270E45E7ECD710E)
  light childthread _id_7435BA1D572EB268((0.819, 0.862, 1), (0.776, 1, 0.588), 0.15);

  wait 0.15;

  foreach(light in level._id_2270E45E7ECD710E)
  light childthread _id_9070ECA46954F112((0.823, 0.98, 0.56), (0.776, 1, 0.588), 14.15, 2.0, 1, 0.9);

  wait 14.15;

  foreach(light in level._id_2270E45E7ECD710E)
  light childthread _id_654BBA95F143727D((0.301, 0.454, 0.972), 0.5);

  wait 0.5;

  foreach(light in level._id_2270E45E7ECD710E)
  light childthread _id_9070ECA46954F112((0.576, 0.062, 0.956), (0.301, 0.454, 0.972), 50, 10.0, 1, 0.8);

  wait 20;
}

_id_9070ECA46954F112(_id_6CAF7524B4964B2C, _id_6CAF7824B49651C5, duration, speed, _id_E951E895FB5D8C46, _id_B153A77942D79D3B) {
  self notify("color_pulse");
  self endon("color_pulse");

  if(!isDefined(_id_E951E895FB5D8C46))
    _id_E951E895FB5D8C46 = 0;

  _id_63F445469B886BF8 = floor(duration * 20);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    _id_CDDE8478F52A266A = _id_6655396AEC86B2EF(_id_AC0E594AC96AA3A8 * speed);
    _id_A7122AB037474A3D = vectorlerp(_id_6CAF7524B4964B2C, _id_6CAF7824B49651C5, _id_CDDE8478F52A266A);
    self _meth_8A5136D4D87795D4(_id_A7122AB037474A3D);

    if(_id_E951E895FB5D8C46) {
      _id_CDDE8378F52A2437 = _id_6655396AEC86B2EF((_id_AC0E594AC96AA3A8 + 50) * speed);
      _id_50D6E555F692ABFE = scripts\engine\math::lerp(self.og_intensity * _id_B153A77942D79D3B, self.og_intensity, _id_CDDE8378F52A2437);
      self setlightintensity(_id_50D6E555F692ABFE);
    }

    wait 0.05;
  }
}

_id_654BBA95F143727D(col, duration) {
  self notify("lerp_light_color_to");
  self endon("lerp_light_color_to");
  _id_45BC9F5268F90238 = self _meth_CDD36EB036403400();
  _id_63F445469B886BF8 = floor(duration * 20);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    t = float((_id_AC0E594AC96AA3A8 + 1) / _id_63F445469B886BF8);
    t = t * t * t;
    _id_A7122AB037474A3D = vectorlerp(_id_45BC9F5268F90238, col, t);
    self _meth_8A5136D4D87795D4(_id_A7122AB037474A3D);
    wait 0.05;
  }
}

_id_7435BA1D572EB268(_id_3DDFE174855A3F28, _id_9F38E87B16EFE319, duration) {
  self notify("lerp_light_color_from_to");
  self endon("lerp_light_color_ftom_to");
  self _meth_8A5136D4D87795D4(_id_3DDFE174855A3F28);
  _id_63F445469B886BF8 = floor(duration * 20);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    t = float((_id_AC0E594AC96AA3A8 + 1) / _id_63F445469B886BF8);
    _id_A7122AB037474A3D = vectorlerp(_id_3DDFE174855A3F28, _id_9F38E87B16EFE319, t);
    self _meth_8A5136D4D87795D4(_id_A7122AB037474A3D);
    wait 0.05;
  }
}

_id_6655396AEC86B2EF(x) {
  y = sin(2.0 * x) + sin(3.14159 * x);
  return clamp((y + 2.0) / 4.0, 0.0, 1.0);
}

_id_4F1FD0F5003012DC(duration, _id_7C6637A253602501, _id_46BE16725EEFEEDD) {
  self notify("lerp_rgb_wheel");
  self endon("lerp_rgb_wheel");

  if(!isDefined(_id_7C6637A253602501))
    _id_7C6637A253602501 = 0.0;

  if(!isDefined(_id_46BE16725EEFEEDD))
    _id_46BE16725EEFEEDD = 1.0;

  self _meth_8A5136D4D87795D4(_id_0B7281BFB9645666(_id_7C6637A253602501, _id_46BE16725EEFEEDD, 1.0));
  _id_63F445469B886BF8 = floor(duration * 20);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    t = float(_id_AC0E594AC96AA3A8 / _id_63F445469B886BF8);
    self _meth_8A5136D4D87795D4(_id_0B7281BFB9645666(360.0 * t + _id_7C6637A253602501, _id_46BE16725EEFEEDD, 1.0));
    wait 0.05;
  }

  self _meth_8A5136D4D87795D4(_id_0B7281BFB9645666(360.0 + _id_7C6637A253602501, _id_46BE16725EEFEEDD, 1.0));
}

_id_569AEC3F2378F201() {
  _id_2849C362052EF66C = getEnt("crashed_car_fire_light_01", "targetname");
  _id_2849C662052EFD05 = getEnt("crashed_car_fire_light_02", "targetname");
  _id_2849C562052EFAD2 = getEnt("crashed_car_fire_light_03", "targetname");
  _id_2849C062052EEFD3 = getEnt("crashed_car_fire_light_04", "targetname");
  _id_29F9D33E2FF44DFF = [_id_2849C362052EF66C, _id_2849C662052EFD05, _id_2849C562052EFAD2, _id_2849C062052EEFD3];

  foreach(light in _id_29F9D33E2FF44DFF) {
    if(!isDefined(light))
      return;
  }

  _id_2849C362052EF66C thread _id_0F9E4BDC4AF4B6A0(0.4, 1.0, 55, 0.3, 0.8);
  _id_2849C662052EFD05 thread _id_0F9E4BDC4AF4B6A0(0.4, 1.0, 35, 0.3, 0.8);
  _id_2849C562052EFAD2 thread _id_0F9E4BDC4AF4B6A0(0.4, 1.0, 35, 0.3, 0.8);
  _id_2849C062052EEFD3 thread _id_0F9E4BDC4AF4B6A0(0.4, 1.0, 25, 0.3, 0.8);
}

_id_0F9E4BDC4AF4B6A0(_id_034BAF23CFCE266E, _id_EF51947AA5AC420A, _id_CFBA7E98AF704038, min_time, max_time) {
  self notify("grandprix_fire_flicker");
  self endon("grandprix_fire_flicker");
  level endon("game_ended");

  if(getDvar("r_reflectionprobegenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  _id_B5524BFA7931B674 = _id_CFBA7E98AF704038;

  for(;;) {
    intensity = randomfloatrange(_id_CFBA7E98AF704038 * _id_034BAF23CFCE266E, _id_CFBA7E98AF704038 * _id_EF51947AA5AC420A);
    timer = randomfloatrange(min_time, max_time);
    timer = timer * 20;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < timer; _id_AC0E594AC96AA3A8++) {
      _id_A510AE7913007CD7 = intensity * (_id_AC0E594AC96AA3A8 / timer) + _id_B5524BFA7931B674 * ((timer - _id_AC0E594AC96AA3A8) / timer);
      self setlightintensity(_id_A510AE7913007CD7);
      wait 0.05;
    }

    _id_B5524BFA7931B674 = intensity;
  }
}