/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd_sp.gsc
***********************************************/

#using script_198f1b397865a5ad;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function private autoexec function_db8ba550() {
  wait_init();
  function_518f6be7();

  dvar("<dev string:x38>", "<dev string:x4f>", &function_6a02a3f8);
  dvar("<dev string:x53>", "<dev string:x4f>", &function_c1f0a1a0);
}

function private function_b9014159(userdata) {
  player = level.player;
  now = gettime();

  if(isDefined(self.var_404d1644.time) == 1 && self.var_404d1644.time == now) {
    assert(isDefined(self.var_404d1644.distanceattenuation) == 1);
    return self.var_404d1644.distanceattenuation;
  }

  distancemin = self.var_404d1644.distancemin;
  distancemax = self.var_404d1644.distancemax;
  var_16fc9737 = self.var_404d1644.var_16fc9737;
  playerorigin = player getEye();
  distancetoplayer = distance(self.origin, playerorigin);

  if(distancetoplayer > distancemax) {
    self.var_404d1644.distanceattenuation = 0;
  } else if(distancetoplayer <= distancemin) {
    self.var_404d1644.distanceattenuation = 1;
  } else {
    var_96454505 = distancemax - distancemin;
    distancefrac = 1 - (distancetoplayer - distancemin) / var_96454505;
  }

  self.var_404d1644.time = now;

  if(function_95c9af4b() > 1) {
    src_origin = self.origin;
    debugscale = getdvarfloat(#"hash_182296346d138cf8");
    snd_print3d(src_origin - (0, 0, 0 * debugscale), "<dev string:x63>" + self.var_404d1644.distanceattenuation, (1, 1, 1), 1, debugscale, 1);
  }

  return self.var_404d1644.distanceattenuation;
}

function private function_e2782c4a(inputvalue, userdata) {
  player = userdata;

  foreach(submix, var_79162eff in level.var_28778381) {
    assert(isDefined(submix) == 1);
    var_ab57c0be = 0;

    foreach(var_453b3fb3 in var_79162eff) {
      if(function_3132f113(var_453b3fb3) == 1) {
        continue;
      }

      if(var_453b3fb3.var_404d1644.distanceattenuation > var_ab57c0be) {
        var_ab57c0be = var_453b3fb3.var_404d1644.distanceattenuation;

        if(isDefined(var_453b3fb3.var_404d1644.var_d89a17f3) == 1) {
          var_ab57c0be *= var_453b3fb3.var_404d1644.var_d89a17f3;
        }
      }
    }

    if(var_ab57c0be > 0) {
      if(isDefined(level.player.var_404d1644[submix]) == 0) {
        waitframe(1);
      }

      level.player.var_404d1644[submix] = var_ab57c0be;
      continue;
    }

    if(isDefined(level.player.var_404d1644[submix]) == 1) {
      level.player.var_404d1644[submix] = undefined;
    }
  }
}

function private function_77a1c8ae(userdata) {
  submix = undefined;

  if(self != level.player) {
    submix = self.var_404d1644.submix;

    if(isDefined(level.var_28778381[submix]) == 1) {
      if(isinarray(level.var_28778381[submix], self) == 1) {
        arrayremovevalue(level.var_28778381[submix], self, 1);
      }
    }

    self.var_404d1644 = undefined;
  }

  if(isDefined(submix) == 1) {
    if(isDefined(level.var_28778381[submix]) == 1) {
      if(level.var_28778381[submix].size == 0) {
        level.var_28778381[submix] = undefined;
      }
    }

    if(isDefined(level.player.var_404d1644) == 1) {
      foreach(var_9fa1f8fb, var_f9695b5f in level.player.var_404d1644) {
        if(submix == var_9fa1f8fb && isDefined(level.var_28778381[submix]) == 0) {
          level.player.var_404d1644[submix] = undefined;
        }
      }
    }
  }

  if(isDefined(level.player.var_404d1644) == 1 && level.player.var_404d1644.size == 0) {
    level.player.var_404d1644 = undefined;

    if(isDefined(level.var_28778381) == 1 && level.var_28778381.size == 0) {}
  }
}

function private function_bfea3a77(submix, var_d89a17f3, distancemin, distancemax, var_16fc9737) {
  var_5a696c5d = self;
  assert(isDefined(var_5a696c5d) == 1, "<dev string:x6e>");
  assert(isDefined(submix) == 1, "<dev string:x8e>");

  if(isDefined(var_d89a17f3) == 0) {
    var_d89a17f3 = 1;
  }

  if(isDefined(distancemin) == 0 || isDefined(distancemax) == 0 || isDefined(var_16fc9737) == 0) {
    while(isDefined(var_5a696c5d.soundalias) == 0) {
      waitframe(1);
    }

    if(function_3132f113(var_5a696c5d) == 1) {
      return;
    }

    distancemin = 24;
    distancemax = 2400;
    var_16fc9737 = undefined;

    if(isDefined(var_16fc9737) == 0 || var_16fc9737 == "" || var_16fc9737 == "$default" || var_16fc9737 == "default") {
      var_16fc9737 = "default_vfcurve";
    }
  }

  var_16fc9737 = "linear";
  var_b9fe5640 = spawnStruct();
  var_b9fe5640.distancemin = distancemin;
  var_b9fe5640.distancemax = distancemax;
  var_b9fe5640.var_16fc9737 = var_16fc9737;
  var_b9fe5640.submix = submix;
  var_b9fe5640.var_d89a17f3 = var_d89a17f3;
  var_b9fe5640.time = 0;
  var_5a696c5d.var_404d1644 = var_b9fe5640;

  if(isDefined(level.var_28778381) == 0) {
    level.var_28778381 = [];
  }

  if(isDefined(level.var_28778381[submix]) == 0) {
    level.var_28778381[submix] = [];
  }

  var_3e7ec58e = level.var_28778381[submix].size;
  level.var_28778381[submix][var_3e7ec58e] = var_5a696c5d;
}

function function_90dcaacf(submix, var_d89a17f3, distancemin, distancemax, var_16fc9737) {
  self thread function_bfea3a77(submix, var_d89a17f3, distancemin, distancemax, var_16fc9737);
}

function function_38e71eb0() {
  var_5a696c5d = undefined;
  submix = undefined;

  if(isentity(self) == 1 && isDefined(self.var_404d1644) == 1 && isDefined(self.var_404d1644.submix) == 1) {
    var_5a696c5d = self;
    submix = self.var_404d1644.submix;
  } else if(function_f984063f() == 1) {
    debugbreak();
  }

  if(isDefined(submix) == 1) {
    if(isDefined(level.var_28778381[submix]) == 1) {}
  }
}

function function_90509715(dimvolume, dimbutton) {
  level thread function_44a0fc4(dimvolume, dimbutton);
}

function private function_44a0fc4(dimvolume, dimbutton, dimbuttontime) {
  volume_dvar = "<dev string:xa8>";
  var_c8c21635 = 0;
  isbuttonpressed = 0;
  defaultvolume = 0.8;

  if(isDefined(dimvolume) == 0) {
    dimvolume = 0.1 * defaultvolume;
  }

  if(isDefined(dimbutton) == 0) {
    dimbutton = "<dev string:xbc>";
  }

  if(isDefined(dimbuttontime) == 0) {
    dimbuttontime = 500;
  }

  lastvolume = defaultvolume;
  lastbuttonpressed = isbuttonpressed;
  dimhud = undefined;
  buttondowntime = 0;
  assert(isDefined(var_c8c21635));
  assert(isDefined(defaultvolume));
  assert(isDefined(dimvolume));
  assert(isDefined(lastvolume));
  assert(isDefined(dimbutton));

  while(true) {
    volume = getdvarfloat(volume_dvar);
    var_5cbd7bfa = 0;
    isbuttonpressed = level.player buttonPressed(dimbutton);

    if(isbuttonpressed == 1 && lastbuttonpressed == 0) {
      buttondowntime = gettime();
    } else if(isbuttonpressed == 0) {
      buttondowntime = 0;
    }

    if(isbuttonpressed == 1 && buttondowntime > 0) {
      var_e497ff20 = gettime() - buttondowntime;

      if(var_e497ff20 >= dimbuttontime) {
        var_5cbd7bfa = 1;
        buttondowntime = 0;
      }
    }

    if(var_5cbd7bfa == 1) {
      var_c8c21635 = !var_c8c21635;

      switch (var_c8c21635) {
        default:
          break;
      }
    }

    if(var_c8c21635 == 1 && isDefined(dimhud) == 0) {
      color = (1, 0.623529, 0.498039);
      alpha = 0.333;
      fontscale = 2;
      x = 0;
      y = -64 * fontscale;
      dimstring = "<dev string:xc9>" + dimbutton + "<dev string:xe3>";
      dimhud = newdebughudelem();
      dimhud.x = x;
      dimhud.y = y;
      dimhud.alignx = "<dev string:xf2>";
      dimhud.aligny = "<dev string:xfc>";
      dimhud.horzalign = "<dev string:xf2>";
      dimhud.vertalign = "<dev string:x106>";
      dimhud.alpha = alpha;
      dimhud.color = color;
      dimhud.sort = 2;
      dimhud.font = "<dev string:x110>";
      dimhud.fontscale = fontscale;
      dimhud.shadowed = 1;
      dimhud.foreground = 1;
      dimhud.label = dimstring;
    } else if(var_c8c21635 == 0 && isDefined(dimhud) == 1) {
      dimhud destroy();
      dimhud = undefined;
    }

    lastvolume = defaultvolume;
    lastbuttonpressed = isbuttonpressed;
    waitframe(1);
  }
}

function function_59b7784b(var_91377dd9) {
  var_6df2f4ed = 11;
  sourcepoint = level.player.origin;
  shakescale = (var_91377dd9 + 0.2, var_91377dd9, var_91377dd9 * 0.5);
  duration = 1;
  durationfadeup = 0;
  durationfadedown = 1;
  radius = 2500;
  var_636ecd76 = (var_6df2f4ed + 0.33, var_6df2f4ed - 0.2, var_6df2f4ed * 0.25);
  screenshake(sourcepoint, shakescale[0], shakescale[1], shakescale[2], duration, durationfadeup, durationfadedown, radius, var_636ecd76[0], var_636ecd76[1], var_636ecd76[2]);

  if(isDefined(level.var_9378edd5) && level.var_9378edd5 == 1) {
    iprintlnbold("<dev string:x11d>");
  }
}

function private function_68dbcf23(org_start, org_end) {
  org_player = level.player getplayervieworigin();
  org = pointonsegmentnearesttopoint(org_start, org_end, org_player);
  return org;
}

function private function_6134380c(alias, islooping, org_start, org_end, fadein, fadeout, end_notify) {
  self endon(#"death");
  waittime = 0.0666;
  self.soundalias = alias;
  self.line_start = org_start;
  self.line_end = org_end;

  if(isDefined(fadein) == 1) {
    waitframe(1);
  }

  if(islooping == 1) {
    self playLoopSound(alias);
  } else {
    end_notify = "sounddone";
    self playSound(alias);
  }

  if(isDefined(end_notify) == 1) {
    self thread function_58019ad9(islooping, fadeout, end_notify);
  }

  while(true) {
    org = function_68dbcf23(org_start, org_end);
    self moveto(org, waittime, 0, 0);
    wait waittime;
  }
}

function private function_58019ad9(islooping, fadeout, end_notify) {
  if(isDefined(end_notify) == 1) {
    self waittill(end_notify);
  }

  if(isDefined(fadeout) == 1 && fadeout > 0) {
    wait fadeout;
  }

  if(islooping == 1) {
    self stoploopsound();
  }
}

function function_6dc5d407(alias, islooping, org_start, org_end, fadein, fadeout, var_a0d34681) {
  org = function_68dbcf23(org_start, org_end);
  ent = undefined;

  if(isDefined(ent) == 0) {
    iprintln("<dev string:x135>");

    return;
  }

  ent thread function_6134380c(alias, islooping, org_start, org_end, fadein, fadeout, var_a0d34681);
  return ent;
}

function function_dda1d491(alias, org_start, org_end, time_min, time_max) {
  self endon(#"hash_1fdfe9a2ee5c7a64");
  self endon(#"hash_21cbaaf28d93437b");
  self endon(#"death");

  while(true) {
    function_6dc5d407(alias, 0, org_start, org_end);
    var_7f793265 = randomrangehelper(time_min, time_max);
    wait var_7f793265;
  }
}

function function_ab26d4b7(label, point1, point2) {
  if(!isDefined(level.var_77a389b2)) {
    level.var_77a389b2 = [];
  }

  assert(!isDefined(level.var_77a389b2[label]), "<dev string:x15f>" + label + "<dev string:x16d>");
  level.var_77a389b2[label] = [point1, vectornormalize(point2 - point1), distance(point1, point2), point2];
  self thread function_17b9cb33(label);
  self thread function_a0414d75(label);
}

function private function_17b9cb33(label) {
  self endon(#"death");
  self endon(label + "_line_ent_stop");
  assert(isDefined(self) == 1);
  update_rate = 0.1;

  while(true) {
    var_874f5aad = level.player.origin - level.var_77a389b2[label][0];
    var_7bfe4890 = vectordot(var_874f5aad, level.var_77a389b2[label][1]);
    var_7bfe4890 = math::clamp(var_7bfe4890, 0, level.var_77a389b2[label][2]);
    sound_origin = level.var_77a389b2[label][0] + level.var_77a389b2[label][1] * var_7bfe4890;
    self moveto(sound_origin, update_rate);

    if(function_95c9af4b() > 1) {
      p1 = level.var_77a389b2[label][0];
      p2 = level.var_77a389b2[label][3];
      color = (1, 1, 1);
      alpha = 1;
      depthtest = 0;
      dur = int(floor(update_rate / 0.05));
      line(p1, p2, color, alpha, depthtest, dur);
      debugcrosshair(sound_origin, 24, self.angles, color * 1000, alpha, depthtest, dur);
    }

    wait update_rate;
  }
}

function function_65485047(label, point1, point2, time) {
  self endon(#"death");
  self endon(#"sounddone");
  self endon(label + "_line_ent_stop");
  assert(isDefined(level.var_77a389b2[label]), "<dev string:x15f>" + label + "<dev string:x184>");
  self thread function_6cec2fa9(label, point1, point2, time);
}

function private function_6cec2fa9(label, point1, point2, time) {
  self endon(#"death");
  self endon(#"sounddone");
  self endon(label + "_line_ent_stop");
  tick = 0.2;
  var_7e80dee7 = level.var_77a389b2[label][0];
  var_7b2f5268 = level.var_77a389b2[label][3];
  var_8113b1f4 = time / tick;

  for(i = 0; i < var_8113b1f4; i++) {
    fraction = (i + 1) / var_8113b1f4;
    var_c9b2005f = vectorlerp(var_7e80dee7, point1, fraction);
    var_9d4813f0 = vectorlerp(var_7b2f5268, point2, fraction);
    level.var_77a389b2[label] = [var_c9b2005f, vectornormalize(var_9d4813f0 - var_c9b2005f), distance(var_c9b2005f, var_9d4813f0), var_9d4813f0];
    wait tick;
  }
}

function function_a0414d75(label) {
  self waittill(#"death", #"sounddone", label + "_line_ent_stop");
  level.var_77a389b2[label] = undefined;
}

function function_e3bbd02e(submix, attack, hold, release, pre_delay, scale) {
  if(isDefined(scale) == 1 && scale > 0) {
    wait scale;
  }
}

function function_4f3aa5d6(submix, attack, hold, release, pre_delay, dist_min, dist_max, sound_org, player_org) {
  if(!isDefined(sound_org) && isDefined(self) && isDefined(self.origin)) {
    sound_org = self.origin;
  }

  if(!isDefined(player_org)) {
    player_org = level.player.origin;
  }

  assert(isDefined(sound_org), "<dev string:x19c>");

  if(!isDefined(pre_delay)) {
    pre_delay = 0;
  }

  if(!isDefined(dist_min)) {
    dist_min = 500;
  }

  if(!isDefined(dist_max)) {
    dist_max = 1000;
  }

  dist = distance(player_org, sound_org);

  if(dist > dist_max) {
    return;
  }

  scale = mapfloat(dist_min, dist_max, 0, 0.3, dist);
  wait pre_delay;

  if(release == 0) {
    release += 0.05;
  }

  wait hold + release;
}

function function_85642848(range, view, scale) {
  self thread function_4f2eaeca(range, view, scale);
}

function private function_4f2eaeca(range, view, scale) {
  self endon(#"hash_123d75bd0aca2c20");
  level endon(#"hash_6bc6a0427de83068");
  self endon(#"death");

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
    dist = distance(self.origin, level.player.origin);
    start_origin = level.player getEye();
    start_angles = level.player getplayerangles();
    end_origin = self.origin;
    normal = vectornormalize(end_origin - start_origin);
    forward = anglesToForward(start_angles);
    vol = vectordot(forward, normal);
    vol = mapfloat(0, 1, 1 - scale, 1, vol);

    if(vol >= view) {
      set_volume(self, vol, time);
    }
  }
}

function function_aa00de89(alias, position, range, view) {
  self thread function_ec6efa64(alias, position, range, view);
}

function private function_ec6efa64(alias, position, range, view) {
  self endon(#"hash_123d75bd0aca2c20");
  level endon(#"hash_6bc6a0427de83068");

  if(!isDefined(range)) {
    range = 1000;
  }

  if(!isDefined(view)) {
    view = cos(45);
  } else {
    view = cos(view);
  }

  time = 0.1;

  while(true) {
    wait time;
    dist = distance(position, level.player.origin);
    wait time;
  }

  play(alias, position);
}

function function_518f6be7() {
  if(!isDefined(level.var_9c638f25)) {
    level.var_9c638f25 = [];
    level.var_9c638f25[# "linear_up"] = [0, 0.02, 0.045, 0.065, 0.09, 0.11, 0.135, 0.155, 0.18, 0.2];
    level.var_9c638f25[# "linear_down"] = [0.2, 0.18, 0.155, 0.135, 0.11, 0.09, 0.065, 0.045, 0.02, 0];
    level.var_9c638f25[# "hash_4e2d52f3f0be7ff0"] = [0, 0.01, 0.019, 0.03, 0.049, 0.068, 0.102, 0.15, 0.229, 0.343];
    level.var_9c638f25[# "hash_4f72d4357814b6ec"] = [0.343, 0.229, 0.15, 0.102, 0.068, 0.049, 0.03, 0.019, 0.01, 0];
    level.var_9c638f25[# "hash_60fcd0938f1c15ad"] = [0, 0.051, 0.077, 0.094, 0.108, 0.118, 0.127, 0.135, 0.142, 0.148];
    level.var_9c638f25[# "hash_515cc0964c4d5f65"] = [0.148, 0.142, 0.135, 0.127, 0.118, 0.108, 0.094, 0.077, 0.051, 0];
    level.var_9c638f25[# "bell"] = [0.003, 0.017, 0.057, 0.14, 0.283, 0.283, 0.14, 0.057, 0.017, 0.003];
    level.var_9c638f25[# "hash_3a962d646a55e818"] = [0.283, 0.14, 0.057, 0.017, 0.003, 0.003, 0.017, 0.057, 0.14, 0.283];
  }
}

function function_e963e8e(time_min, time_max, random_curve) {
  values = [];
  values[0] = time_min;
  var_99adf0c9 = level.var_9c638f25[random_curve].size;
  step = (time_max - time_min) / (var_99adf0c9 - 1);

  for(i = 1; i < var_99adf0c9 - 1; i++) {
    values[i] = values[i - 1] + step;
  }

  values[values.size] = time_max;
  return values;
}

function function_7bde8914(w, amount) {
  a = [];
  var_bf1e5b71 = 1 / w.size;

  for(i = 0; i < w.size; i++) {
    diff = var_bf1e5b71 - w[i];
    offset = (1 - amount) * abs(diff);

    if(diff < 0) {
      offset *= -1;
    }

    a[i] = w[i] + offset;
  }

  return a;
}

function function_4dca3057(w, v) {
  var_99adf0c9 = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = v[v.size - 1];

  for(i = 0; i < var_99adf0c9; i++) {
    total += w[i];

    if(r < total) {
      ret_value = v[i];
      break;
    }
  }

  return ret_value;
}

function function_7a111e9c(w) {
  var_99adf0c9 = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = w.size - 1;

  for(i = 0; i < var_99adf0c9; i++) {
    total += w[i];

    if(r < total) {
      ret_value = i;
      break;
    }
  }

  return ret_value;
}

function function_9ca26fba(min, max, random_curve) {
  if(isDefined(random_curve)) {
    weights = level.var_9c638f25[random_curve];

    if(isDefined(weights)) {
      values = function_e963e8e(min, max, random_curve);
      var_ba9b2215 = function_7a111e9c(weights);
      min_idx = 0;
      max_idx = values.size - 1;

      if(var_ba9b2215 == 0) {
        max_idx = 1;
      } else if(var_ba9b2215 == values.size - 1) {
        min_idx = max_idx - 1;
      } else {
        min_idx = var_ba9b2215 - 1;
        max_idx = var_ba9b2215 + 1;
      }

      return randomfloatrange(values[min_idx], values[max_idx]);
    }
  }
}

function function_2517b19c(min, max, label = "shared_default", width = 0.5) {
  if(!isDefined(level.var_76d79843)) {
    level.var_76d79843 = spawnStruct();
    level.var_76d79843.label = 0;
  }

  width = math::clamp(width, 0, 1);
  width *= 5;
  iteration = 0;

  for(i = 0; i < width; i++) {
    iteration += randomfloatrange(min, max);
  }

  x = iteration / width;

  if(x > max * 0.5) {
    x -= max;
  }

  x += max * 0.5;
  previous = level.var_76d79843.label;
  range = max - min;
  mid = range * 0.5;

  if(abs(previous - x) < range * 0.2) {
    x = mapfloat(min, max, max - randomfloatrange(0, range * 0.35), min + randomfloatrange(0, range * 0.35), x);
    x = math::clamp(x, min, max);
  }

  level.var_76d79843.label = x;
  return x;
}

function private function_7776e399(alias, submix, attack, hold, release, scale) {
  self endon(#"death");
  self endon("abort_" + scale);

  while(true) {}
}

function function_da704a02(alias, submix, scale, attack, release, radio) {
  ent = self;
  var_2c0edc54 = 1;

  if(!isDefined(submix)) {
    submix = "critical_dialogue";
  }

  if(!isDefined(scale)) {
    scale = 0.5;
  }

  assert(scale >= 0 && scale <= 1, "<dev string:x1e7>");

  if(!isDefined(attack)) {
    attack = 0.5 * scale;
  }

  if(!isDefined(release)) {
    release = 1 * scale;
  }

  if(!isDefined(radio)) {
    radio = 0;
  }

  if(radio == 1) {
    ent = level.player;
  }

  if(soundexists(alias) == 0) {
    alert_text = "<dev string:x20c>" + alias + "<dev string:x217>";
    function_3ba3cecb(alert_text);

    var_2c0edc54 = 0;
    return;
  }

  volmod = "";

  if(function_81fac19d(volmod != "dialog_critical", "alias '" + alias + "' volmod not 'dialog_critical' ('" + volmod + "')")) {
    var_2c0edc54 = 0;
  }

  sndlength = soundgetplaybacktime(alias);
  hold = sndlength - attack - release;

  if(hold < 0) {
    hold = 0;
  }

  if(function_81fac19d(sndlength <= 0, "alias '" + alias + "' length " + sndlength + " too short to envelope")) {
    var_2c0edc54 = 0;
  }

  if(var_2c0edc54 == 1) {
    var_66a04f11 = 24;
    var_7e2f0732 = 2400;
    thresh = var_7e2f0732 * 0.5;

    if(isDefined(ent) && isDefined(ent.origin) && radio == 0) {
      dist = distance(ent.origin, level.player.origin);
    } else {
      dist = 0;
    }

    if(function_81fac19d(dist > thresh, "critical dialogue '" + alias + "' " + dist / 12 + " feet away")) {
      var_2c0edc54 = 0;
    } else {
      ent thread function_7776e399(alias, submix, attack, hold, release, scale);
    }
  }

  if(ent == level.player || radio == 1) {}
}

function function_9299618(var_16ae04ab, var_5b2df2a0, endons) {
  self notify(#"hash_63850bb43dbc38de");
  level endon(#"hash_63850bb43dbc38de");
  self endon(#"hash_63850bb43dbc38de", #"death");
  var_5b2df2a0 = function_ea2f17d1(var_5b2df2a0, [6, 24]);
  var_8969a580 = var_5b2df2a0[0];
  var_4a4a2db8 = var_5b2df2a0[1];

  if(isarray(endons)) {
    foreach(end_on in endons) {
      if(isstring(end_on)) {
        level endon(end_on);
      }
    }
  } else if(isstring(endons)) {
    level endon(endons);
  }

  if(!isscriptfunctionptr(var_16ae04ab)) {
    return;
  }

  if(function_3132f113(self)) {
    return;
  }

  self.var_2de4672c = 0;
  self.lastsaytime = gettime();
  assert(isDefined(self.lastsaytime) == 1);

  while(function_3132f113(self) == 0) {
    if(isDefined(level._snd.var_91ff3ae4)) {
      var_8969a580 = level._snd.var_91ff3ae4;
    }

    if(isDefined(level._snd.var_8bea37be)) {
      var_4a4a2db8 = level._snd.var_8bea37be;
    }

    now = gettime();
    istalking = is_true(self.istalking);

    if(istalking) {
      self.lastsaytime = now;
    }

    lastsaytime = self.lastsaytime;
    delta = now - lastsaytime;
    deltaseconds = delta / 1000;

    if(istalking == 0 && deltaseconds >= var_8969a580) {
      if(self.var_2de4672c == 0) {
        self.var_2de4672c = int(now + randomfloatrange(var_8969a580, var_4a4a2db8) * 1000);
      }

      if(now >= self.var_2de4672c) {
        soundalias = [[var_16ae04ab]](self);

        if(isDefined(soundalias)) {
          self.bdisabledefaultfacialanims = 1;
          self dialogue::queue(soundalias);
          self.lastsaytime = now;
          self.var_2de4672c = 0;
        }
      }
    } else {
      self.var_2de4672c = 0;
    }

    if(function_95c9af4b() > 1) {
      var_20768eda = self gettagorigin("<dev string:x22c>");

      if(!isDefined(var_20768eda)) {
        var_20768eda = self.origin + (0, 0, 72);
      }

      org = var_20768eda;
      org += (0, 0, 9);
      var_a8dca3b9 = "<dev string:x236>";

      if(self.var_2de4672c > 0) {
        nexttime = self.var_2de4672c / 1000 - now / 1000;
        var_a8dca3b9 = function_d6053a8f(nexttime, 2);
      }

      var_ed98e4bb = "<dev string:x23e>";
      var_479b18b2 = "<dev string:x4f>" + var_a8dca3b9 + "<dev string:x24f>" + deltaseconds;
      print3dplus(var_ed98e4bb, org, 0.125, "<dev string:x254>", (180, 180, 180), 0.72974, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      print3dplus(var_479b18b2, org, 0.125, "<dev string:x259>", (1, 1, 1), 1, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
    }

    waitframe(1);
  }
}

function function_6967f975(actor_ent, soundalias, var_793802a, var_7ca3f45d, frame_rate, stop_notify, fadeout_time) {
  thread function_f253a9d9(actor_ent, soundalias, var_793802a, var_7ca3f45d, frame_rate, stop_notify, fadeout_time);
}

function private function_f253a9d9(actor_ent, soundalias, var_793802a, var_7ca3f45d, frame_rate, stop_notify, fadeout_time) {
  if(function_81fac19d(!isDefined(soundalias), "snd_pcap_play_vo: sound alias undefined")) {
    return;
  }

  if(function_81fac19d(!soundexists(soundalias), "snd_pcap_play_vo: not a a valid alias")) {
    return;
  }

  sound_target = [self, "j_head"];
  fadeout_time = function_ea2f17d1(fadeout_time, 0.1);
  function_56a60177(var_793802a, frame_rate);
  sndobj = play(soundalias, sound_target);

  if(isstring(stop_notify)) {
    function_d4e10f97(sndobj, var_7ca3f45d, fadeout_time);
  }
}

function private function_56a60177(var_793802a, frame_rate) {
  var_793802a = function_ea2f17d1(var_793802a, 0);
  frame_rate = function_ea2f17d1(frame_rate, 29.97);
  secs = floor(var_793802a);
  frames = (var_793802a - secs) * 100;
  wait_time = secs + frames * 1 / frame_rate;
  wait wait_time;
}

function function_c9ebfa2(xanim, notetrack, var_596cbb65) {
  info = function_643b5581(var_596cbb65);
  animname = info[# "animname"];
  anime = info[# "anime"];
  assert(isDefined(anime), "<dev string:x25e>");
}

function private function_643b5581(xanim) {
  foreach(var_7cd1f30b, var_d74d7402 in level.scr_anim) {
    if(isstring(var_7cd1f30b) && isarray(var_d74d7402)) {
      foreach(var_ba93f88, var_42203061 in var_d74d7402) {
        if(isstring(var_ba93f88) && !isarray(var_42203061)) {
          if(xanim == var_42203061) {
            result = [];
            result[# "anime"] = var_ba93f88;
            result[# "animname"] = var_7cd1f30b;
            return result;
          }
        }
      }
    }
  }
}

function private function_be27bceb() {
  assert(isDefined(self) == 1);

  if(isDefined(self.var_3ce724aa) == 1) {
    self waittill(#"hash_3a117b23d7bfa071");

    if(isDefined(self.var_3ce724aa.soundent) == 1) {
      self.var_3ce724aa.soundent delete();
    }

    self.var_3ce724aa = undefined;
  }
}

function private function_250787e2(totaltime, tickalias, tockalias, pitchlo, pitchhi, pitchcurve, endcallback) {
  assert(isDefined(self) == 1);
  assert(isDefined(self.var_3ce724aa) == 1);
  assert(isDefined(tickalias) == 1);

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

  self thread function_be27bceb();
  self endon(#"hash_3a117b23d7bfa071");

  while(gettime() <= self.var_3ce724aa.endtime) {
    now = gettime();
    remainingtime = self.var_3ce724aa.endtime - now;
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

    var_95b67614 = remainingtime - ticktockinterval;
    var_f515cb6a = var_95b67614 % ticktockinterval;
    var_95b67614 = var_95b67614 + ticktockinterval - var_f515cb6a;

    if(remainingtime <= var_95b67614) {
      if(self.var_3ce724aa.soundticktock != 0) {
        self.var_3ce724aa.soundent playSound(tickalias);
        self.var_3ce724aa.soundticktock = 0;
      } else {
        self.var_3ce724aa.soundent playSound(tockalias);
        self.var_3ce724aa.soundticktock = 1;
      }

      assert(isDefined(self.var_3ce724aa.soundent) == 1);
      timerpitch = mapfloat(0, totaltime, pitchhi, pitchlo, remainingtime);
      set_pitch(self.var_3ce724aa.soundent, timerpitch, 0.05, pitchcurve);
    }

    waitframe(1);
  }

  if(isDefined(endcallback) == 1) {
    self[[endcallback]]();
  }

  self notify(#"hash_3a117b23d7bfa071");
}

function function_68fc9c9b() {
  if(isDefined(self.var_3ce724aa) == 1) {
    self notify(#"hash_3a117b23d7bfa071");
  }
}

function snd_timer(totaltime, tickalias, tockalias, endalias, pitchlo, pitchhi, pitchcurve, endcallback) {
  assert(isDefined(self) == 1);
  assert(isDefined(tockalias) == 1);

  if(isDefined(self.var_3ce724aa) == 1) {
    self function_68fc9c9b();
  }

  starttime = gettime();
  tickalias = int(tickalias * 1000 + 0.5);

  if(isDefined(self.var_3ce724aa) == 0) {
    self.var_3ce724aa = spawnStruct();
    self.var_3ce724aa.endtime = starttime + tickalias;
    self.var_3ce724aa.soundticktock = 0;
    self.var_3ce724aa.soundent = spawn("script_origin", self.origin);
    self.var_3ce724aa.soundent linkto(self);
  }

  self thread function_250787e2(tickalias, tockalias, endalias, pitchlo, pitchhi, pitchcurve, endcallback);
}

function private function_c71c2a61(var_5229451c) {
  level endon(#"hash_1fc826e0acca152f");
  var_bb25ac71 = [];
  var_ad5f1285 = [];
  assert(isarray(level.var_cfbd198a) == 1);
  waitforplayers();

  while(true) {
    waittime = randomhelper(var_5229451c);
    wait waittime;

    if(isDefined(level.var_a5a54d7a) == 0 || level.var_a5a54d7a.size == 0) {
      function_4bb3b8d9();
      arrayremovevalue(level.var_a5a54d7a, var_ad5f1285, 1);
    }

    var_bb25ac71 = level.var_a5a54d7a[0];
    var_ad5f1285 = var_bb25ac71;

    while(isarray(var_bb25ac71) == 1 && var_bb25ac71.size > 0) {
      radioline = var_bb25ac71[0];

      if(soundexists(radioline) == 1) {
        playtime = soundgetplaybacktime(radioline) / 1000;

        foreach(player in getplayerssafe()) {
          player playlocalsound(radioline);
        }

        wait playtime;
        wait 0.666;
      }

      arrayremovevalue(var_bb25ac71, radioline, 1);
    }

    arrayremovevalue(level.var_a5a54d7a, var_ad5f1285, 1);
  }
}

function function_a1446973(var_5229451c) {
  if(isDefined(var_5229451c) == 0) {
    var_5229451c = [6, 12];
  }

  level thread function_c71c2a61(var_5229451c);
}

function function_3c463326() {
  level notify(#"hash_1fc826e0acca152f");
}

function function_4bb3b8d9() {
  if(isDefined(level.var_cfbd198a) == 1) {}
}

function function_6c69eaba(flag_name, var_2ce1e8bb, fade_in_time, fade_out_time) {
  level thread function_d2c66f6e(flag_name, var_2ce1e8bb, fade_in_time, fade_out_time);
}

function private function_d2c66f6e(flag_name, var_2ce1e8bb, fade_in_time, fade_out_time) {
  level.player endon(#"death");

  if(!flag::exists(var_2ce1e8bb)) {
    flag::init(var_2ce1e8bb);
  }

  if(!isDefined(fade_in_time)) {
    fade_in_time = 0.5;
  }

  if(!isDefined(fade_out_time)) {
    fade_out_time = 0.5;
  }

  while(true) {
    flag::wait_till(var_2ce1e8bb);
    flag::wait_till_clear(var_2ce1e8bb);
  }
}

function private function_b5c66198() {
  level endon(#"hash_6a5860b6e04cdea1");

  while(!isDefined(level.stealth) && !isDefined(level.player.stealth)) {
    waitframe(1);
  }

  scale = 1.5;
  x = 960 - 96 * scale;
  y = 540 - 112 * scale;
  var_97b12dd2 = 16 * scale;
  var_94de442b = (0.72974, 0.72974, 0.72974);

  while(true) {
    yy = y;
    state = function_ea2f17d1(level.stealth.detect.state, "<dev string:x294>");
    var_27dc744f = (1, 1, 1);
    maxthreat = "<dev string:x294>";
    delta = "<dev string:x2a0>";
    var_ddb580ee = "<dev string:x294>";

    if(isDefined(level.player.stealth)) {
      maxthreat = function_ea2f17d1(level.player.stealth.maxthreat, 0);
      delta = function_ea2f17d1(level.player.stealth.var_2c539111, 0);
      var_ddb580ee = function_ea2f17d1(level.player.stealth.var_ddb580ee, function_ea2f17d1(level.player.stealth.threat_sight_snd_threat, 0));
    }

    if(state == "<dev string:x2a7>") {
      var_27dc744f = (1, 0.25, 0.25);
    }

    alpha = 1;
    function_669c57bc(x, yy, "<dev string:x2b2>", (0.72974, 0.72974, 0.72974), alpha, scale);
    function_669c57bc(x, yy, "<dev string:x2c3>" + state, var_27dc744f, alpha, scale);
    yy += var_97b12dd2;
    function_669c57bc(x, yy, "<dev string:x2d4>", (0.72974, 0.72974, 0.72974), alpha, scale);
    function_669c57bc(x, yy, "<dev string:x2c3>" + maxthreat + "<dev string:x2e5>" + delta + "<dev string:x2eb>", var_27dc744f, alpha, scale);
    yy += var_97b12dd2;
    function_669c57bc(x, yy, "<dev string:x2f0>", (0.72974, 0.72974, 0.72974), alpha, scale);
    function_669c57bc(x, yy, "<dev string:x2c3>" + var_ddb580ee, var_27dc744f, alpha, scale);
    waitframe(1);
  }
}

function private function_6a02a3f8(key, value) {
  value = int(value);

  if(value == 0) {
    level notify(#"hash_6a5860b6e04cdea1");
  } else {
    level thread function_b5c66198();
  }

  return "<dev string:x4f>" + value;
}

function private function_c1f0a1a0(key, value) {
  music::setmusicstate(value);
  return value;
}

function private function_7dbf6e02(key, value) {
  valuearray = strtok(value, "<dev string:x301>");
  time = 0.05;
  return value;
}

function private function_4ba99182(key, value) {
  return "<dev string:x4f>";
}