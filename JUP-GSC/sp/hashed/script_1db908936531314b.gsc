/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1db908936531314b.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace snd_sp;

function private autoexec function_42d3854e7dc0f031() {
  namespace_53c50dd747d66443::snd_init();
  function_8b2208523132fa90();
  level.snd.callbacks["pitch_get"] = &function_13b5f294b0646f6b;
  level.snd.callbacks["pitch_set"] = &function_759fbcd2f53a978c;
  level.snd.callbacks["volume_get"] = &function_5f67e5f881178d39;
  level.snd.callbacks["volume_set"] = &function_dcdcd5efb87fc9b0;
}

function private function_3a545679ff26019e(userdata) {
  player = level.player;
  now = gettime();

  if(isDefined(self.snd.submix3d.time) && self.snd.submix3d.time == now) {
    assert(isDefined(self.snd.submix3d.distanceattenuation));
    return self.snd.submix3d.distanceattenuation;
  }

  distancemin = self.snd.submix3d.distancemin;
  distancemax = self.snd.submix3d.distancemax;
  var_11b23f3656c3caef = squared(distancemin);
  var_44b7a85b7ea9caa1 = squared(distancemax);
  var_a1560db470f0d641 = self.snd.submix3d.var_a1560db470f0d641;
  playerorigin = player getplayervieworigin();
  distancetoplayer_sq = distancesquared(self.origin, playerorigin);

  if(distancetoplayer_sq > var_44b7a85b7ea9caa1) {
    self.snd.submix3d.distanceattenuation = 0;
  } else if(distancetoplayer_sq <= var_11b23f3656c3caef) {
    self.snd.submix3d.distanceattenuation = 1;
  } else {
    var_a9190cf033e725f9 = var_44b7a85b7ea9caa1 - var_11b23f3656c3caef;
    distancefrac = 1 - (distancetoplayer_sq - var_11b23f3656c3caef) / var_a9190cf033e725f9;
    distanceattenuation = function_e6ef280f5472a1d2(distancefrac, var_a1560db470f0d641);
    self.snd.submix3d.distanceattenuation = distanceattenuation;
  }

  self.snd.submix3d.time = now;

  if(function_ec24f13736bfc421() > 0) {
    src_origin = self.origin;
    debugscale = level.snd.debug.scale_3d;
    snd_print3d(src_origin - (0, 0, 0 * debugscale), "<dev string:x1c>" + self.snd.submix3d.distanceattenuation, (1, 1, 1), 1, debugscale, 1);
  }

  return self.snd.submix3d.distanceattenuation;
}

function private function_c8fdb79316f72ed9(inputvalue, userdata) {
  player = userdata;

  foreach(submix, var_15f09a6948319b43 in level.snd.var_a0d1075e5ea548cc) {
    assert(isDefined(submix));
    var_99434a3c2f6fe2fa = 0;

    foreach(var_a97e1ee1445592c2 in var_15f09a6948319b43) {
      if(function_5b8457b9d8edb521(var_a97e1ee1445592c2)) {
        continue;
      }

      inputvalue = var_a97e1ee1445592c2 function_feb1a4f9eda07b44("submix3D");

      if(var_a97e1ee1445592c2.snd.submix3d.distanceattenuation > var_99434a3c2f6fe2fa) {
        var_99434a3c2f6fe2fa = var_a97e1ee1445592c2.snd.submix3d.distanceattenuation;

        if(isDefined(var_a97e1ee1445592c2.snd.submix3d.var_c73348459be85799)) {
          var_99434a3c2f6fe2fa *= var_a97e1ee1445592c2.snd.submix3d.var_c73348459be85799;
        }
      }
    }

    if(var_99434a3c2f6fe2fa > 0) {
      if(isDefined(level.player.snd.submix3d[submix]) == 0) {
        waitframe();
      }

      level.player.snd.submix3d[submix] = var_99434a3c2f6fe2fa;
      continue;
    }

    if(isDefined(level.player.snd.submix3d[submix])) {
      level.player.snd.submix3d[submix] = undefined;
    }
  }
}

function private function_f41485b4614e621a(userdata) {
  submix = undefined;

  if(self != level.player) {
    submix = self.snd.submix3d.submix;

    if(isDefined(level.snd.var_a0d1075e5ea548cc[submix])) {
      if(array_contains(level.snd.var_a0d1075e5ea548cc[submix], self)) {
        level.snd.var_a0d1075e5ea548cc[submix] = array_remove(level.snd.var_a0d1075e5ea548cc[submix], self);
      }
    }

    self.snd.submix3d = undefined;
  }

  if(isDefined(submix)) {
    if(isDefined(level.snd.var_a0d1075e5ea548cc[submix])) {
      if(level.snd.var_a0d1075e5ea548cc[submix].size == 0) {
        level.snd.var_a0d1075e5ea548cc[submix] = undefined;
      }
    }

    if(isDefined(level.player.snd.submix3d)) {
      foreach(var_539356344751e13d in level.player.snd.submix3d) {
        if(submix == var_7843efd22b675798 && isDefined(level.snd.var_a0d1075e5ea548cc[submix]) == 0) {
          level.player.snd.submix3d[submix] = undefined;
        }
      }
    }
  }

  if(isDefined(level.player.snd.submix3d) && level.player.snd.submix3d.size == 0) {
    level.player.snd.submix3d = undefined;
    level.player function_96d11f9981c0fe4b("submix3D");

    if(isDefined(level.snd.var_a0d1075e5ea548cc) && level.snd.var_a0d1075e5ea548cc.size == 0) {
      assert(level.player function_db43aa8b88926353("submix3D") == 0);
      level.snd.var_a0d1075e5ea548cc = undefined;
    }
  }
}

function private function_ab906084b9213a8b(submix, var_c73348459be85799, distancemin, distancemax, var_a1560db470f0d641) {
  var_8566b0fa1d69298a = self;
  assertex(isDefined(var_8566b0fa1d69298a), "audio entity must be defined");
  assertex(isDefined(submix), "submix must be defined");

  if(isDefined(var_c73348459be85799) == 0) {
    var_c73348459be85799 = 1;
  }

  if(isDefined(distancemin) == 0 || isDefined(distancemax) == 0 || isDefined(var_a1560db470f0d641) == 0) {
    while(isDefined(var_8566b0fa1d69298a.soundalias) == 0) {
      waitframe();
    }

    if(function_5b8457b9d8edb521(var_8566b0fa1d69298a)) {
      return;
    }

    distancemin = function_8a2af68cee25cdf7(var_8566b0fa1d69298a.soundalias, "dist_min");
    distancemax = function_8a2af68cee25cdf7(var_8566b0fa1d69298a.soundalias, "dist_max");
    var_a1560db470f0d641 = function_8a2af68cee25cdf7(var_8566b0fa1d69298a.soundalias, "volumefalloffcurve");

    if(isDefined(var_a1560db470f0d641) == 0 || var_a1560db470f0d641 == "" || var_a1560db470f0d641 == "$default" || var_a1560db470f0d641 == "default") {
      var_a1560db470f0d641 = "default_vfcurve";
    }
  }

  if(function_110d3ab280057f5b(function_115055e88972de05(var_a1560db470f0d641) == 0, "submix3D curve '" + var_a1560db470f0d641 + "' not found! using linear.")) {
    var_a1560db470f0d641 = "linear";
  }

  var_ebc662a0caef9b36 = spawnStruct();
  var_ebc662a0caef9b36.distancemin = distancemin;
  var_ebc662a0caef9b36.distancemax = distancemax;
  var_ebc662a0caef9b36.var_a1560db470f0d641 = var_a1560db470f0d641;
  var_ebc662a0caef9b36.submix = submix;
  var_ebc662a0caef9b36.var_c73348459be85799 = var_c73348459be85799;
  var_ebc662a0caef9b36.time = 0;
  function_b3e5599c9f6a8895(var_8566b0fa1d69298a);
  assertex(isstruct(var_8566b0fa1d69298a.snd));
  var_8566b0fa1d69298a.snd.submix3d = var_ebc662a0caef9b36;
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(isDefined(level.snd.var_a0d1075e5ea548cc) == 0) {
    level.snd.var_a0d1075e5ea548cc = [];
  }

  if(isDefined(level.snd.var_a0d1075e5ea548cc[submix]) == 0) {
    level.snd.var_a0d1075e5ea548cc[submix] = [];
  }

  var_3706dc09aebe1148 = level.snd.var_a0d1075e5ea548cc[submix].size;
  level.snd.var_a0d1075e5ea548cc[submix][var_3706dc09aebe1148] = var_8566b0fa1d69298a;
  snd_param("submix3D", undefined, &function_3a545679ff26019e, undefined, &function_f41485b4614e621a);

  if(level.player function_db43aa8b88926353("submix3D") == 0) {
    function_b3e5599c9f6a8895(level.player);
    assert(isstruct(level.player.snd));

    if(isDefined(level.player.snd.submix3d) == 0) {
      level.player.snd.submix3d = [];
    }

    assert(isarray(level.player.snd.submix3d));
    level.player snd_param("submix3D", undefined, undefined, &function_c8fdb79316f72ed9, &function_f41485b4614e621a);
  }
}

function function_14757b69209c039a(submix, var_c73348459be85799, distancemin, distancemax, var_a1560db470f0d641) {
  thread function_ab906084b9213a8b(submix, var_c73348459be85799, distancemin, distancemax, var_a1560db470f0d641);
}

function function_e2d87a63dd216b07() {
  var_8566b0fa1d69298a = undefined;
  submix = undefined;

  if(isent(self) && isDefined(self.snd.submix3d) && isDefined(self.snd.submix3d.submix)) {
    var_8566b0fa1d69298a = self;
    submix = self.snd.submix3d.submix;
  } else if(function_a3da201852146397()) {
    DevOp(0x94);
  }

  if(isDefined(submix)) {
    if(isDefined(level.snd.var_a0d1075e5ea548cc[submix])) {
      function_96d11f9981c0fe4b("submix3D");
    }
  }
}

function function_c3751c463dc674a1(dimvolume, dimbutton) {
  level thread function_ea684ece7f0a1b98(dimvolume, dimbutton);
}

function private function_ea684ece7f0a1b98(dimvolume, dimbutton, dimbuttontime) {
  volume_dvar = @ "hash_455f5221de27673d";
  var_d350711d075718f1 = 0;
  isbuttonpressed = 0;
  defaultvolume = 0.8;
  setdevdvar(volume_dvar, "<dev string:x24>" + defaultvolume);

  if(isDefined(dimvolume) == 0) {
    dimvolume = 0.1 * defaultvolume;
  }

  if(isDefined(dimbutton) == 0) {
    dimbutton = "<dev string:x25>";
  }

  if(isDefined(dimbuttontime) == 0) {
    dimbuttontime = 500;
  }

  lastvolume = defaultvolume;
  lastbuttonpressed = isbuttonpressed;
  dimhud = undefined;
  buttondowntime = 0;
  assert(isDefined(var_d350711d075718f1));
  assert(isDefined(defaultvolume));
  assert(isDefined(dimvolume));
  assert(isDefined(lastvolume));
  assert(isDefined(dimbutton));

  while(true) {
    volume = getdvarfloat(volume_dvar);
    var_54faa24a906d6b9d = 0;
    isbuttonpressed = level.player buttonPressed(dimbutton);

    if(isbuttonpressed == 1 && lastbuttonpressed == 0) {
      buttondowntime = gettime();
    } else if(isbuttonpressed == 0) {
      buttondowntime = 0;
    }

    if(isbuttonpressed == 1 && buttondowntime > 0) {
      var_f7ef816ae86f91f1 = gettime() - buttondowntime;

      if(var_f7ef816ae86f91f1 >= dimbuttontime) {
        var_54faa24a906d6b9d = 1;
        buttondowntime = 0;
      }
    }

    if(var_54faa24a906d6b9d == 1) {
      var_d350711d075718f1 = !var_d350711d075718f1;

      switch (var_d350711d075718f1) {
        case 0:
        default:
          setdevdvar(volume_dvar, "<dev string:x24>" + defaultvolume);
          break;
        case 1:
          setdevdvar(volume_dvar, "<dev string:x24>" + dimvolume);
          break;
      }
    }

    if(var_d350711d075718f1 == 1 && isDefined(dimhud) == 0) {
      color = (1, 0.623529, 0.498039);
      alpha = 0.333;
      fontscale = 2;
      x = 0;
      y = -64 * fontscale;
      dimstring = "<dev string:x2f>" + dimbutton + "<dev string:x46>";
      dimhud = newhudelem();
      dimhud.x = x;
      dimhud.y = y;
      dimhud.alignx = "<dev string:x52>";
      dimhud.aligny = "<dev string:x59>";
      dimhud.horzalign = "<dev string:x52>";
      dimhud.vertalign = "<dev string:x60>";
      dimhud.alpha = alpha;
      dimhud.color = color;
      dimhud.sort = 2;
      dimhud.font = "<dev string:x67>";
      dimhud.fontscale = fontscale;
      dimhud.shadowed = 1;
      dimhud.foreground = 1;
      dimhud.label = dimstring;
    } else if(var_d350711d075718f1 == 0 && isDefined(dimhud)) {
      dimhud destroy();
      dimhud = undefined;
    }

    lastvolume = defaultvolume;
    lastbuttonpressed = isbuttonpressed;
    waitframe();
  }
}

function function_1c545fdb7a03d965(submix, attack, hold, release, pre_delay, scale) {
  if(isDefined(pre_delay) && pre_delay > 0) {
    wait pre_delay;
  }
}

function function_1c5079db7a001cbc(submix, attack, hold, release, pre_delay, dist_min, dist_max, sound_org, player_org) {
  if(!isDefined(sound_org) && isDefined(self) && isDefined(self.origin)) {
    sound_org = self.origin;
  }

  if(!isDefined(player_org)) {
    player_org = level.player.origin;
  }

  assertex(isDefined(sound_org), "no origin specified and no calling ent to derive origin from, you fool!");
  pre_delay = default_to(pre_delay, 0);
  dist_min = default_to(dist_min, 500);
  dist_max = default_to(dist_max, 1000);
  var_892b4b802cb0b6af = squared(dist_min);
  var_4311b4affc690a61 = squared(dist_max);
  dist_sq = distancesquared(player_org, sound_org);

  if(dist_sq > var_4311b4affc690a61) {
    return;
  }

  scale = scalerp(dist_sq, var_892b4b802cb0b6af, var_4311b4affc690a61, 0, 0.3);
  wait pre_delay;

  if(hold == 0) {
    hold += 0.05;
  }

  wait attack + hold;
}

function function_a74657bc602790a2(range, view, scale) {
  thread function_f2e7631ed6ec286d(range, view, scale);
}

function private function_f2e7631ed6ec286d(range, view, scale) {
  self endon("stop_looking_sounds");
  level endon("stop_all_looking_sounds");
  self endon("death");

  if(!isDefined(range)) {
    range = 1000;
  }

  if(!isDefined(view)) {
    view = cos(90);
  } else {
    view = cos(view);
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  time = 0.05;

  while(true) {
    wait time;
    start_origin = level.player getEye();
    start_angles = level.player getplayerangles();
    end_origin = self.origin;
    normal = vectorNormalize(end_origin - start_origin);
    forward = anglesToForward(start_angles);
    vol = vectordot(forward, normal);
    vol = scalerp(vol, 0, 1, 1 - scale, 1);

    if(vol >= view) {
      function_dcdcd5efb87fc9b0(self, vol, time);
    }
  }
}

function function_a3a7cbb72317099b(alias, position, range, view) {
  thread function_2e897c93d360feb0(alias, position, range, view);
}

function private function_2e897c93d360feb0(alias, position, range, view) {
  self endon("stop_looking_sounds");
  level endon("stop_all_looking_sounds");
  range_sq = squared(default_to(range, 1000));
  view = cos(default_to(view, 45));
  time = 0.1;

  while(true) {
    dist_sq = distancesquared(position, level.player.origin);

    if(dist_sq <= range_sq) {
      if(within_fov(level.player getplayervieworigin(), level.player getplayerviewangles(), position, view)) {
        break;
      }
    }

    wait time;
  }

  snd_play(alias, position);
}

function function_8b2208523132fa90() {
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(!isDefined(level.snd.var_81b664ea82102a8e)) {
    level.snd.var_81b664ea82102a8e = [];
    level.snd.var_81b664ea82102a8e["linear_up"] = [0, 0.02, 0.045, 0.065, 0.09, 0.11, 0.135, 0.155, 0.18, 0.2];
    level.snd.var_81b664ea82102a8e["linear_down"] = [0.2, 0.18, 0.155, 0.135, 0.11, 0.09, 0.065, 0.045, 0.02, 0];
    level.snd.var_81b664ea82102a8e["exponential_slow_up"] = [0, 0.01, 0.019, 0.03, 0.049, 0.068, 0.102, 0.15, 0.229, 0.343];
    level.snd.var_81b664ea82102a8e["exponential_fast_down"] = [0.343, 0.229, 0.15, 0.102, 0.068, 0.049, 0.03, 0.019, 0.01, 0];
    level.snd.var_81b664ea82102a8e["exponential_fast_up"] = [0, 0.051, 0.077, 0.094, 0.108, 0.118, 0.127, 0.135, 0.142, 0.148];
    level.snd.var_81b664ea82102a8e["exponential_slow_down"] = [0.148, 0.142, 0.135, 0.127, 0.118, 0.108, 0.094, 0.077, 0.051, 0];
    level.snd.var_81b664ea82102a8e["bell"] = [0.003, 0.017, 0.057, 0.14, 0.283, 0.283, 0.14, 0.057, 0.017, 0.003];
    level.snd.var_81b664ea82102a8e["inverted_bell"] = [0.283, 0.14, 0.057, 0.017, 0.003, 0.003, 0.017, 0.057, 0.14, 0.283];
  }
}

function function_ff2551404bb53223(time_min, time_max, random_curve) {
  values = [];
  values[0] = time_min;
  var_f1d815fca5ec80b = level.snd.var_81b664ea82102a8e[random_curve].size;
  step = (time_max - time_min) / (var_f1d815fca5ec80b - 1);

  for(i = 1; i < var_f1d815fca5ec80b - 1; i++) {
    values[i] = values[i - 1] + step;
  }

  values[values.size] = time_max;
  return values;
}

function function_58b4be4667013c74(w, amount) {
  a = [];
  var_e8f0e2d93cf9aa13 = 1 / w.size;

  for(i = 0; i < w.size; i++) {
    diff = var_e8f0e2d93cf9aa13 - w[i];
    offset = (1 - amount) * abs(diff);

    if(diff < 0) {
      offset *= -1;
    }

    a[i] = w[i] + offset;
  }

  return a;
}

function function_3a936ade9c53e549(w, v) {
  var_f1d815fca5ec80b = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = v[v.size - 1];

  for(i = 0; i < var_f1d815fca5ec80b; i++) {
    total += w[i];

    if(r < total) {
      ret_value = v[i];
      break;
    }
  }

  return ret_value;
}

function function_d3101e7a53711d56(w) {
  var_f1d815fca5ec80b = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = w.size - 1;

  for(i = 0; i < var_f1d815fca5ec80b; i++) {
    total += w[i];

    if(r < total) {
      ret_value = i;
      break;
    }
  }

  return ret_value;
}

function function_5b6b7f0f5b844a7b(min, max, random_curve) {
  if(isDefined(random_curve)) {
    weights = level.snd.var_81b664ea82102a8e[random_curve];

    if(isDefined(weights)) {
      values = function_ff2551404bb53223(min, max, random_curve);
      var_897cfe4e3b31708 = function_d3101e7a53711d56(weights);
      min_idx = 0;
      max_idx = values.size - 1;

      if(var_897cfe4e3b31708 == 0) {
        max_idx = 1;
      } else if(var_897cfe4e3b31708 == values.size - 1) {
        min_idx = max_idx - 1;
      } else {
        min_idx = var_897cfe4e3b31708 - 1;
        max_idx = var_897cfe4e3b31708 + 1;
      }

      return randomfloatrange(values[min_idx], values[max_idx]);
    }
  }
}

function function_b169f8a1fceab946(min, max, label, width) {
  width = default_to(width, 0);
  label = default_to(label, "shared_default");
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(!isDefined(level.snd.random_aid)) {
    level.snd.random_aid = spawnStruct();
    level.snd.random_aid.label = 0;
  }

  width = clamp(width, 0, 1);
  width *= 5;
  width = math::round_float(width, 1);
  iteration = 0;

  for(i = 0; i < width; i++) {
    iteration += randomfloatrange(min, max);
  }

  x = iteration / width;

  if(x > max * 0.5) {
    x -= max;
  }

  x += max * 0.5;
  previous = level.snd.random_aid.label;
  range = max - min;
  mid = range * 0.5;

  if(abs(previous - x) < range * 0.2) {
    x = scalerp(x, min, max, max - randomfloatrange(0, range * 0.35), min + randomfloatrange(0, range * 0.35));
    x = clamp(x, min, max);
  }

  level.snd.random_aid.label = x;
  return x;
}

function private function_b1dd3bbeb1ad7384(alias, submix, attack, hold, release, scale) {
  self endon("death");
  self endon("abort_" + alias);

  while(true) {
    self waittill("anim dialogue", var_a5145a04d172d704);

    if(isDefined(var_a5145a04d172d704) && var_a5145a04d172d704 == alias) {
      break;
    }
  }
}

function function_4c14bc367fc3a09(alias, submix, scale, attack, release, radio) {
  ent = self;
  var_5de261c412fd939b = 1;
  submix = default_to(submix, "critical_dialogue");
  scale = default_to(scale, 0.5);
  assertex(scale >= 0 && scale <= 1, "scale must be between 0.0 and 1.0");
  attack = default_to(attack, 0.5 * scale);
  release = default_to(release, 1 * scale);
  radio = default_to(radio, 0);

  if(radio == 1) {
    ent = level.player;
  }

  if(soundexists(alias) == 0) {
    alert_text = "<dev string:x71>" + alias + "<dev string:x79>";
    function_265429989bce8de3(alert_text);

    var_5de261c412fd939b = 0;
    return;
  }

  volmod = function_8a2af68cee25cdf7(alias, "vol_mod");

  if(function_110d3ab280057f5b(volmod != "dialog_critical", "alias '" + alias + "' volmod not 'dialog_critical' ('" + volmod + "')")) {
    var_5de261c412fd939b = 0;
  }

  sndlength = lookupsoundlength(alias);
  hold = sndlength - attack - release;

  if(hold < 0) {
    hold = 0;
  }

  if(function_110d3ab280057f5b(sndlength <= 0, "alias '" + alias + "' length " + sndlength + " too short to envelope")) {
    var_5de261c412fd939b = 0;
  }

  if(var_5de261c412fd939b == 1) {
    var_e05aeab5341d4573 = function_8a2af68cee25cdf7(alias, "dist_min");
    var_e07e00b53443bd8d = function_8a2af68cee25cdf7(alias, "dist_max");
    thresh = var_e07e00b53443bd8d * 0.5;
    var_a10a4080b15de80c = squared(thresh);
    dist_sq = 0;

    if(isDefined(ent) && isDefined(ent.origin) && radio == 0) {
      dist_sq = distancesquared(ent.origin, level.player.origin);
    }

    if(dist_sq > var_a10a4080b15de80c) {
      var_5de261c412fd939b = 0;

      if(function_ec24f13736bfc421() > 0) {
        function_265429989bce8de3("<dev string:x8b>" + alias + "<dev string:x9f>" + sqrt(dist_sq) / 12 + "<dev string:xa2>");
      }
    } else {
      ent thread function_b1dd3bbeb1ad7384(alias, submix, attack, hold, release, scale);
    }
  }

  if(ent == level.player || radio == 1) {
    ent smart_radio_dialogue(alias);
    return;
  }

  ent smart_dialogue(alias);
}

function private function_6f015404fd952b0b(soundobject) {
  function_b3e5599c9f6a8895(soundobject);
  assert(isstruct(soundobject.snd));

  if(isDefined(soundobject) && function_5b8457b9d8edb521(soundobject) == 0 && isDefined(soundobject.snd.scale) == 0) {
    soundobject.snd.scale = spawnStruct();
    soundobject.snd.scale.volume = 1;
    soundobject.snd.scale.pitch = 1;
    soundobject.snd.scale.threads = [];
    function_8ee338ebe8c076cc(soundobject, function_e448203aedcadcf8());
  }
}

function private function_39e69965841fa467(sound, volume, time) {
  sound scalevolume(volume, time);
}

function private function_394f85a9b323c069(sound, volume, time) {
  sound scalepitch(volume, time);
}

function private function_bb64367b01278da4(soundobject, value, scalefunc) {
  if(function_5b8457b9d8edb521(soundobject) || isDefined(soundobject) == 0) {
    return;
  }

  function_6f015404fd952b0b(soundobject);
  assert(isDefined(soundobject.snd.scale));

  if(isDefined(scalefunc)) {
    if(scalefunc == &function_39e69965841fa467) {
      soundobject.snd.scale.volume = value;
      return;
    }

    if(scalefunc == &function_394f85a9b323c069) {
      soundobject.snd.scale.pitch = value;
    }
  }
}

function private function_284e6d4e6de04c70(soundobject, scalefunc) {
  assert(isDefined(soundobject));

  if(isstruct(soundobject.snd) && isDefined(soundobject.snd.scale)) {
    if(scalefunc == &function_39e69965841fa467) {
      return soundobject.snd.scale.volume;
    } else if(scalefunc == &function_394f85a9b323c069) {
      return soundobject.snd.scale.pitch;
    }
  }

  return undefined;
}

function private function_8ed5f37dfe5595a(scalefunc) {
  var_836b23c9f9e0f7aa = 0;
  scalestring = undefined;
  self endon("death");
  self waittill("snd_scale_completed");
  assertex(isDefined(scalefunc), "scale completed with unknown scaleFunc");

  if(scalefunc == &function_39e69965841fa467) {
    self.snd.scale.var_8ef6ac3969a6c990 = undefined;
    scalestring = "volume";
  }

  if(scalefunc == &function_394f85a9b323c069) {
    self.snd.scale.var_2f60e0a3d98be6ec = undefined;
    scalestring = "pitch";
  }

  assert(isDefined(scalestring));
  self.snd.scale.threads[scalestring] = undefined;

  if(isDefined(self.snd.scale.var_8ef6ac3969a6c990) == 0 && isDefined(self.snd.scale.var_2f60e0a3d98be6ec) == 0) {
    self.snd.scale.isscaling = undefined;
  }

  self notify("snd_stop_scale_" + scalestring);
  waittillframeend();
}

function private function_9d9326a28f4ae880(curve, scale, time, scalefunc, callbackfunc) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  self endon("disconnect");
  self endon("deleted");
  self endon("death");
  assert(isDefined(self.snd.scale));
  assert(isDefined(self.snd.scale.threads));
  assert(isDefined(scalefunc));
  assert(time > 0);
  curvepts = function_f17e814008bf23a4(curve);
  assertex(curvepts > 0, "");
  frametime = float(function_e448203aedcadcf8());
  timeremainder = float(time) % frametime;
  time = float(time) + frametime - timeremainder;
  timeinterval = float(time) / float(curvepts);
  var_1bab9a5dcb8b8cc4 = timeinterval % frametime;
  timeinterval = timeinterval + frametime - var_1bab9a5dcb8b8cc4;
  timeinterval = max(timeinterval, frametime);
  var_a99a7c1f162492e5 = int(timeinterval * 1000 + 0.5);
  timems = int(time * 1000 + 0.5);
  var_533d6b6dea3ed270 = int(0);

  if(isDefined(self.snd.scale.isscaling)) {
    var_3f04bb8f81987348 = 0;

    if(isDefined(self.snd.scale.var_8ef6ac3969a6c990) && scalefunc == &function_39e69965841fa467 || isDefined(self.snd.scale.var_2f60e0a3d98be6ec) && scalefunc == &function_394f85a9b323c069) {
      var_3f04bb8f81987348 = 1;
    }

    if(var_3f04bb8f81987348 == 1) {
      self notify("snd_scale_completed", scalefunc);
      waittillframeend();
      self notify("snd_scale_interrupted", scalefunc);
    }
  }

  scalestart = function_284e6d4e6de04c70(self, scalefunc);
  inversecurve = 0;

  if(scalestart > scale) {
    inversecurve = 1;
  }

  while(isDefined(self.soundalias) == 0) {
    waitframe();
  }

  waittillframeend();
  thread function_8ed5f37dfe5595a(scalefunc);
  self.snd.scale.isscaling = 1;
  scalestring = undefined;

  if(scalefunc == &function_39e69965841fa467) {
    self.snd.scale.var_8ef6ac3969a6c990 = 1;
    scalestring = "volume";
  }

  if(scalefunc == &function_394f85a9b323c069) {
    self.snd.scale.var_2f60e0a3d98be6ec = 1;
    scalestring = "pitch";
  }

  assert(isDefined(scalestring));
  self.snd.scale.threads[scalestring] = getthread();
  self endon("snd_stop_scale_" + scalestring);

  while(var_533d6b6dea3ed270 < timems && isDefined(self) && isDefined(self.snd.scale.threads[scalestring])) {
    remainingtime = (timems - var_533d6b6dea3ed270) * 0.001;

    if(isDefined(self.snd.scale.waitinterval)) {
      timeinterval = max(self.snd.scale.waitinterval, frametime);
    }

    waittime = min(timeinterval, remainingtime);
    var_533d6b6dea3ed270 += int(waittime * 1000 + 0.5);
    timefrac = float(var_533d6b6dea3ed270) / float(timems);
    scalevalue = 1;

    if(inversecurve > 0) {
      timefrac = clamp(1 - timefrac, 0, 1);
      curvevalue = function_e6ef280f5472a1d2(timefrac, curve);
      scalevalue = math::lerp(scale, scalestart, curvevalue);
    } else {
      curvevalue = function_e6ef280f5472a1d2(timefrac, curve);
      scalevalue = math::lerp(scalestart, scale, curvevalue);
    }

    [[scalefunc]](self, scalevalue, waittime);
    wait waittime;

    if(isDefined(self) && function_5b8457b9d8edb521(self) == 0) {
      function_bb64367b01278da4(self, scalevalue, scalefunc);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self)) {
    self notify("snd_scale_completed", scalefunc);
  }

  if(isDefined(callbackfunc)) {
    self[[callbackfunc]]();
  }
}

function function_8ee338ebe8c076cc(soundobject, waitinterval) {
  assert(isDefined(soundobject));
  function_6f015404fd952b0b(soundobject);
  assert(isDefined(soundobject.snd.scale));
  soundobject.snd.scale.waitinterval = max(waitinterval, function_e448203aedcadcf8());
}

function snd_scale(soundobject, scalewhat, value, time, curve, callbackfunc) {
  if(function_110d3ab280057f5b(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return;
  }

  if(function_110d3ab280057f5b(function_5b8457b9d8edb521(soundobject), "snd_scale: called on removed entity")) {
    return;
  }

  assertex(isDefined(soundobject), "snd_scale: called on undefined entity");
  assertex(function_5b8457b9d8edb521(soundobject) == 0, "snd_scale: called on removed entity");
  assert(isDefined(value));
  function_6f015404fd952b0b(soundobject);
  var_a36b81f450d2c3ae = value;
  scalefunc = undefined;
  scalestring = undefined;

  switch (scalewhat) {
    case #"hash_5c14048f84c6fdef":
      curve = default_to(curve, "easeout");
      scalefunc = &function_39e69965841fa467;
      scalestring = "volume";
      var_a36b81f450d2c3ae = clamp(value, 0, 4);
      function_110d3ab280057f5b(value != var_a36b81f450d2c3ae, "snd_scale: clamped volume " + value + " -> " + var_a36b81f450d2c3ae);
      break;
    case #"hash_d7a0f5b3b8320991":
      curve = default_to(curve, "linear");
      scalefunc = &function_394f85a9b323c069;
      scalestring = "pitch";
      var_a36b81f450d2c3ae = clamp(value, 0.00390625, 2);
      function_110d3ab280057f5b(value != var_a36b81f450d2c3ae, "snd_scale: clamped pitch " + value + " -> " + var_a36b81f450d2c3ae);
      break;
  }

  assert(isDefined(soundobject));

  if(isDefined(time) == 0 || time == 0) {
    [[scalefunc]](soundobject, var_a36b81f450d2c3ae, 0);
    function_bb64367b01278da4(soundobject, var_a36b81f450d2c3ae, scalefunc);
    soundobject notify("snd_scale_completed", scalefunc);
    soundobject notify("snd_scale_interrupted");
    soundobject notify("snd_stop_scale_" + scalestring);
    return;
  }

  soundobject thread function_9d9326a28f4ae880(curve, var_a36b81f450d2c3ae, time, scalefunc, callbackfunc);

  if(scalefunc == &function_39e69965841fa467) {
    soundobject notify("stopfade");
  }
}

function function_dcdcd5efb87fc9b0(soundobject, volume, time, curve, callbackfunc) {
  snd_scale(soundobject, "volume", volume, time, curve, callbackfunc);
}

function function_759fbcd2f53a978c(soundobject, pitch, time, curve, callbackfunc) {
  snd_scale(soundobject, "pitch", pitch, time, curve, callbackfunc);
}

function function_5f67e5f881178d39(soundobject) {
  if(function_110d3ab280057f5b(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return 0;
  }

  if(function_110d3ab280057f5b(function_5b8457b9d8edb521(soundobject), "snd_scale: called on removed entity")) {
    return 0;
  }

  assert(isDefined(soundobject));
  return function_284e6d4e6de04c70(soundobject, &function_39e69965841fa467);
}

function function_13b5f294b0646f6b(soundobject) {
  if(function_110d3ab280057f5b(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return 0;
  }

  if(function_110d3ab280057f5b(function_5b8457b9d8edb521(soundobject), "snd_scale: called on removed entity")) {
    return 0;
  }

  assert(isDefined(soundobject));
  return function_284e6d4e6de04c70(soundobject, &function_394f85a9b323c069);
}

function private function_fe3baea2918dede2() {
  assert(isDefined(self));

  if(isDefined(self.snd.timer)) {
    self waittill("snd_stop_audioTimer");

    if(isDefined(self.snd.timer.soundent)) {
      self.snd.timer.soundent delete();
    }

    self.snd.timer = undefined;
  }
}

function private function_1d2a474fd292fcf4(totaltime, tickalias, tockalias, pitchlo, pitchhi, pitchcurve, endcallback) {
  assert(isDefined(self));
  assert(isDefined(self.snd.timer));
  assert(isDefined(tickalias));

  if(isDefined(tockalias) == 0) {
    tockalias = tickalias;
  }

  if(isDefined(pitchlo) == 0) {
    pitchlo = 1;
  }

  if(isDefined(pitchhi) == 0) {
    pitchhi = 1;
  }

  if(isDefined(pitchcurve) == 0) {
    pitchcurve = "linear";
  }

  thread function_fe3baea2918dede2();
  self endon("snd_stop_audioTimer");

  while(gettime() <= self.snd.timer.endtime) {
    now = gettime();
    remainingtime = self.snd.timer.endtime - now;
    ticktockinterval = 1000;

    if(remainingtime <= 5000) {
      ticktockinterval = 500;
    }

    if(remainingtime <= 3000) {
      ticktockinterval = 250;
    }

    if(remainingtime <= 1000) {
      ticktockinterval = 50;
    }

    var_671d21bb106c757a = remainingtime - ticktockinterval;
    var_d2038b1c6bb074be = var_671d21bb106c757a % ticktockinterval;
    var_671d21bb106c757a = var_671d21bb106c757a + ticktockinterval - var_d2038b1c6bb074be;

    if(remainingtime <= var_671d21bb106c757a) {
      if(self.snd.timer.soundticktock != 0) {
        self.snd.timer.soundent playSound(tickalias);
        self.snd.timer.soundticktock = 0;
      } else {
        self.snd.timer.soundent playSound(tockalias);
        self.snd.timer.soundticktock = 1;
      }

      assert(isDefined(self.snd.timer.soundent));
      timerpitch = scalerp(remainingtime, 0, totaltime, pitchhi, pitchlo);
      self.snd.timer.soundent function_759fbcd2f53a978c(timerpitch, 0.05, pitchcurve);
    }

    waitframe();
  }

  if(isDefined(endcallback)) {
    self[[endcallback]]();
  }

  self notify("snd_stop_audioTimer");
}

function function_e303cfbf5b4ae3cb() {
  if(isDefined(self.snd.timer)) {
    self notify("snd_stop_audioTimer");
  }
}

function snd_timer(totaltime, tickalias, tockalias, endalias, pitchlo, pitchhi, pitchcurve, endcallback) {
  assert(isDefined(self));
  assert(isDefined(tickalias));

  if(isDefined(self.snd.timer)) {
    function_e303cfbf5b4ae3cb();
  }

  starttime = gettime();
  totaltime = int(totaltime * 1000 + 0.5);
  function_b3e5599c9f6a8895(self);

  if(isDefined(self.snd.timer) == 0) {
    self.snd.timer = spawnStruct();
    self.snd.timer.endtime = starttime + totaltime;
    self.snd.timer.soundticktock = 0;
    self.snd.timer.soundent = spawn("script_origin", self.origin);
    self.snd.timer.soundent linkTo(self);
  }

  thread function_1d2a474fd292fcf4(totaltime, tickalias, tockalias, pitchlo, pitchhi, pitchcurve, endcallback);
}

function private function_25cd589593729f1(var_c1cc78e068001d23) {
  level endon("radioConvoStop");
  var_b609fc03c4b98503 = [];
  var_4ef7f927f8917d38 = [];
  assertex(isstruct(level.snd), "snd was not initialized.");
  assert(isarray(level.snd.var_117aac49a4007550));
  waitforplayers();

  while(true) {
    waittime = randomhelper(var_c1cc78e068001d23);
    wait waittime;

    if(isDefined(level.snd.var_35a5d01e6e6e88f7) == 0 || level.snd.var_35a5d01e6e6e88f7.size == 0) {
      function_f98c715cf7000bec();
      level.snd.var_35a5d01e6e6e88f7 = array_remove(level.snd.var_35a5d01e6e6e88f7, var_4ef7f927f8917d38);
    }

    var_b609fc03c4b98503 = level.snd.var_35a5d01e6e6e88f7[0];
    var_4ef7f927f8917d38 = var_b609fc03c4b98503;

    while(isarray(var_b609fc03c4b98503) && var_b609fc03c4b98503.size > 0) {
      radioline = var_b609fc03c4b98503[0];

      if(soundexists(radioline)) {
        playtime = lookupsoundlength(radioline) / 1000;

        foreach(player in level.players) {
          player playlocalsound(radioline);
        }

        wait playtime;
        wait 0.666;
      }

      var_b609fc03c4b98503 = array_remove(var_b609fc03c4b98503, radioline);
    }

    level.snd.var_35a5d01e6e6e88f7 = array_remove(level.snd.var_35a5d01e6e6e88f7, var_4ef7f927f8917d38);
  }
}

function function_4779f470d4e11c91(var_c1cc78e068001d23) {
  if(isDefined(var_c1cc78e068001d23) == 0) {
    var_c1cc78e068001d23 = [6, 12];
  }

  level thread function_25cd589593729f1(var_c1cc78e068001d23);
}

function radioconvostop() {
  level notify("radioConvoStop");
}

function function_f98c715cf7000bec() {
  if(isDefined(level.snd.var_117aac49a4007550)) {
    level.snd.var_35a5d01e6e6e88f7 = array_randomize(level.snd.var_117aac49a4007550);
  }
}

function function_83ad3db1a9ccd7f8(flag_name, var_220cfd744ed0ba55, fade_in_time, fade_out_time) {
  level thread function_704e6701c74424db(flag_name, var_220cfd744ed0ba55, fade_in_time, fade_out_time);
}

function private function_704e6701c74424db(flag_name, var_220cfd744ed0ba55, fade_in_time, fade_out_time) {
  level.player endon("death");

  if(!flag_exist(flag_name)) {
    flag_init(flag_name);
  }

  if(!isDefined(fade_in_time)) {
    fade_in_time = 0.5;
  }

  if(!isDefined(fade_out_time)) {
    fade_out_time = 0.5;
  }

  while(true) {
    flag_wait(flag_name);
    level.player setsoundsubmix(var_220cfd744ed0ba55, fade_in_time);
    flag_waitopen(flag_name);
    level.player clearsoundsubmix(var_220cfd744ed0ba55, fade_out_time);
  }
}

function private function_ae2644bb5c0d2ef4(key, value) {
  valuearray = strtok(value, " ");
  time = 0.05;
  return value;
}

function private function_f01b2b3f17289b74(key, value) {
  return "";
}