/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1db908936531314b.gsc
*****************************************************/

#using script_19163c4e4e504a5e;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\audio;
#namespace snd_sp;

function autoexec sp_init() {
  snd::init();
  level.snd.callbacks["\x87N3\x99,?IL("] = &function_350a8cfc2e157a3b;
  level.snd.callbacks["{\x02\x1f\xafM\"T\x92\xba"] = &function_799119cdba53d447;
  level.snd.callbacks["\xce\xbdl]\xb5\xb2\xf5\xec\xb2\x8e"] = &function_1574edd3d7c768f;
  level.snd.callbacks["\f\x9a?\xa3&\xd7\xd7\x03\x9b\xd4"] = &function_b60d4eb789711f3b;
  function_2f9bbc3de709a345();
  audio::init_audio_struct();
  assert(isstruct(level.audio), "<dev string:x24>");
}

function private function_2201f4e15fc05acb(userdata) {
  player = self;
  assert(isPlayer(player));
  assert(isarray(player.snd.submix3d));
  var_a0d356b41798f493 = player snd::getplayervieworigin();

  foreach(submix3d in player.snd.submix3d) {
    if(!isarray(submix3d.targets)) {
      continue;
    }

    submix3d.targets = utility::array_removeundefined(submix3d.targets);
    closest_dist_sq = 2147483647;
    closest_target = undefined;

    foreach(target in submix3d.targets) {
      target_origin = snd::function_abdb7485bb0c82d5(target);

      if(isvector(target_origin)) {
        dist_sq = distancesquared(var_a0d356b41798f493, target_origin);

        if(dist_sq < closest_dist_sq) {
          closest_dist_sq = dist_sq;
          closest_target = target;
        }
      }
    }

    if(isDefined(closest_target)) {
      var_b20b91c0d115dd1a = squared(submix3d.dist_min);
      var_d101e2bab7d22d4 = squared(submix3d.dist_max);

      if(closest_dist_sq > var_d101e2bab7d22d4) {
        submix3d.dist_scale = 0;
      } else if(closest_dist_sq <= var_b20b91c0d115dd1a) {
        submix3d.dist_scale = 1;
      } else {
        var_d6532e5445dfda3c = var_d101e2bab7d22d4 - var_b20b91c0d115dd1a;
        dist_frac = 1 - (closest_dist_sq - var_b20b91c0d115dd1a) / var_d6532e5445dfda3c;
        submix3d.dist_scale = snd::curve_value(dist_frac, submix3d.dist_curve);
      }

      if(snd::function_8c35a6f99f836040() > 1) {
        audiocolor = level.snd.debug.color_3d;
        colorscale = level.snd.debug.color_scale;
        selectioncolor = snd::function_91e4e5dcd3f773b0(audiocolor, colorscale * 10);
        debugscale = level.snd.debug.scale_3d;

        foreach(target in submix3d.targets) {
          target_origin = snd::function_abdb7485bb0c82d5(target);

          if(!isvector(target_origin)) {
            continue;
          }

          dist = distance(target_origin, var_a0d356b41798f493);
          isclosest = target == closest_target;
          alpha = isclosest ? 1 : 0.72974;
          alphasq = alpha * alpha;

          if(isnumber(submix3d.dist_min) && submix3d.dist_min > 0 && isnumber(submix3d.dist_max) && submix3d.dist_max > 0) {
            safety_max = 0;

            if(submix3d.dist_min == submix3d.dist_max) {
              safety_max = 0.001;
            }

            mapfloat(submix3d.dist_min, submix3d.dist_max + safety_max, 1, 0.5, dist);
          }

          fixeddistscalar = dist * 0.00133333;
          snd::print3dplus(submix, target_origin + (0, 0, -1.666 * fixeddistscalar * debugscale * 16), -1.666 * debugscale, "<dev string:x53>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
          submix3d_text = isclosest ? "<dev string:x5d>" + snd::printdecimalcount(submix3d.dist_scale * submix3d.scale, 4) + "<dev string:x6b>" : "<dev string:x74>";
          snd::print3dplus(submix3d_text, target_origin + (0, 0, -2.666 * fixeddistscalar * debugscale * 16), -1.333 * debugscale, "<dev string:x53>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
          detail_dist = snd::printdecimalcount(submix3d.dist_min) + "<dev string:x80>" + snd::printdecimalcount(dist) + "<dev string:x80>" + snd::printdecimalcount(submix3d.dist_max);
          snd::print3dplus(detail_dist, target_origin + (0, 0, -3.666 * fixeddistscalar * debugscale * 16), -1.333 * debugscale, "<dev string:x53>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
        }
      }

    }
  }

  return player.snd.submix3d;
}

function private function_1db5618fc1033e70(inputvalue, userdata) {
  player = self;
  assert(isPlayer(player));
  assert(isarray(inputvalue));

  foreach(submix, submix3d in player.snd.submix3d) {
    if(isnumber(submix3d.dist_scale) && isnumber(submix3d.scale)) {
      scale = submix3d.dist_scale * submix3d.scale;

      if(scale > 0) {
        player setsoundsubmix(submix, 0, scale);
        continue;
      }

      player clearsoundsubmix(submix, 0);
    }
  }
}

function private function_8778c7d194819a87(userdata) {
  player = self;
  assert(isPlayer(player));
  assert(isarray(player.snd.submix3d));
  stoppers = [];

  foreach(submix, submix3d in player.snd.submix3d) {
    if(istrue(submix3d.willstop)) {
      stoppers[stoppers.size] = submix;
    }
  }

  foreach(submix in stoppers) {
    player clearsoundsubmix(submix, 0);
    player.snd.submix3d[submix] = undefined;
  }
}

function private function_8cfab6712856de45(submix, targets, dist_min, dist_max, dist_curve, scale) {
  player = self;
  assert(isPlayer(player), "<dev string:x87>");
  assert(isarray(targets) || isent(targets) || isvector(targets), "<dev string:xc1>");
  assert(function_68aef517b5294bf9(submix), "<dev string:x103>");

  if(!isDefined(dist_min)) {
    dist_min = 12;
  }

  if(!isDefined(dist_max)) {
    dist_max = 1200;
  }

  if(!isDefined(dist_curve)) {
    dist_curve = "?\xc6=:\xb0\xd8\xf8w\x8c\xbf\xa0\x92a\xbe\xc85";
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(snd::condition_alert(snd::curve_exists(dist_curve) == 0, "{-\xba\x92\xe3(\xd7\xbc;\x91\f$\x99_\x97[" + dist_curve + "@n\xad\x1a\xf0{\xad\x17+\xd6{U\xf0}\x96\x04\x84\xe8\xea\x88,YlL\xab\xe8")) {
    dist_curve = "s\xd9!`\x94\x9d";
  }

  snd::init_obj(player);
  assert(isstruct(player.snd), "<dev string:x12d>");

  if(!isarray(player.snd.submix3d)) {
    player.snd.submix3d = [];
  }

  if(!isstruct(player.snd.submix3d[submix])) {
    player.snd.submix3d[submix] = spawnStruct();
  }

  player.snd.submix3d[submix].dist_min = dist_min;
  player.snd.submix3d[submix].dist_max = dist_max;
  player.snd.submix3d[submix].dist_curve = dist_curve;
  player.snd.submix3d[submix].scale = scale;

  if(!isarray(player.snd.submix3d[submix].targets)) {
    player.snd.submix3d[submix].targets = snd::makearray(targets);
  } else {
    player.snd.submix3d[submix].targets = utility::array_combine_unique(player.snd.submix3d[submix].targets, targets);
  }

  if(player snd::param_exists("X\xabw\x95f\x8d\x1cj") == 0) {
    player snd::param("X\xabw\x95f\x8d\x1cj", undefined, &function_2201f4e15fc05acb, &function_1db5618fc1033e70, &function_8778c7d194819a87, player.snd.submix3d);
  }
}

function submix3d(players, submix, targets, dist_min, dist_max, dist_curve, scale) {
  isvalidplayers = isarray(players) || isPlayer(players);
  isvalidsubmix = isstring(submix) && function_68aef517b5294bf9(submix);
  isvalidtargets = isarray(targets) || isent(targets) || isvector(targets);

  if(snd::condition_alert(!isvalidplayers, "\xfd;RH\x85\xd6h\xb4\x10\xc6\xc1K\xba\x8fy5SoT\x8fH\x92\xe0b\xe2,\"\xa2\xd4\x9c\xc6H\xf6\xfb\x82\xc8\x0e") || snd::condition_alert(!isvalidsubmix, "Z\x1b-\x96\xeb$\xd6\\\x14\xda(\xf1x>:\xc3\xc8\xf1\x9a\x0er<\xc4\xa5|\xec\x15\x93\x80!\xf4") || snd::condition_alert(!isvalidtargets, "\xd5p.\xa0d\xd9\xe5\xf1h\x8eQ\x84\xe7\x7f\x8b\xab\xed&n\x12!\xcf\xa8#\xffhd8\xbf\xee \xb0")) {
    if(snd::function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return;
  }

  foreach(player in snd::makearray(players)) {
    if(snd::condition_alert(!isPlayer(player), "\xabu\x7f\xe1\xb6\xd5E\xe4\xe9\xa9\xf0|\xac\x0f~\x93f\"gc\r\xfa\xbcIZ:J\xe0i")) {
      if(snd::function_b38f1279fae1d2cf()) {
        DevOp(0x2);
      }

      continue;
    }

    player thread function_8cfab6712856de45(submix, targets, dist_min, dist_max, dist_curve, scale);
  }
}

function submix3d_stop(players, submix, targets) {
  isvalidplayers = isarray(players) || isPlayer(players);
  isvalidsubmix = isstring(submix) && function_68aef517b5294bf9(submix);
  isvalidtargets = isarray(targets) || isent(targets);

  if(snd::condition_alert(!isvalidplayers, "\x99\xfd\xe4\x848\xc4\x99g-*;\xf195\v:Zp\x983\xcfW\x94s\x1b\xc1\xca\x96\xde\xd2c\x17\x86\xe6\xa5\xe6\xf7\xb8\xb1P\x04!")) {
    if(snd::function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return;
  }

  foreach(player in snd::makearray(players)) {
    if(snd::condition_alert(!isPlayer(player), "m'(\xd1\xed\x1b>\xb0D\xf7\xb5\xb4\xc2Aj\x9f@1[\xe1\"\x94\xc2\xb1\xc1\xf2\xaeY\xfa\xf1\xe8\xcaR^") || snd::condition_alert(!isstruct(player.snd), "\xa6\x85\xb4\xad\xa46\xbf\x02\t\xba\x12\xbb\x95Ljv@\xa6\xd7$h*\xe9\x18\xc6\x89\xc1\xf2\xaa\x15\x19\fq?g\xed\x84\x12\xd7\x16\x0e\xb9\xf1D\xe2I") || snd::condition_alert(!isarray(player.snd.submix3d), "\x10\x93\x1f\xb7\xad\xdb\xdd\xd3\x805\x95\xd9\xb4\xc9\xbc*\x03V\xc2\"m\xe5\xf8\x8dC\xaa'\x1b\xf0{\xca#\x03\xbf\xff\x92\xa5\xf9a\x95\x0f2^\x97G\x81\xa6")) {
      if(snd::function_b38f1279fae1d2cf()) {
        DevOp(0x2);
      }

      continue;
    }

    if(isarray(player.snd.submix3d)) {
      if(!isDefined(submix) && !isvalidtargets) {
        foreach(submix3d in player.snd.submix3d) {
          submix3d.willstop = 1;
        }
      } else if(isvalidsubmix && isstring(submix) && isstruct(player.snd.submix3d[submix]) && !isvalidtargets) {
        player.snd.submix3d[submix].willstop = 1;
      } else if(isvalidsubmix && isvalidtargets) {
        targets = snd::makearray(targets);

        foreach(submix3d in player.snd.submix3d) {
          submix3d.targets = utility::array_remove_array(submix3d.targets, targets);

          if(submix3d.targets.size == 0) {
            submix3d.willstop = 1;
          }
        }
      }

      player function_8778c7d194819a87(player.snd.submix3d);

      if(player.snd.submix3d.size == 0) {
        player snd::param_stop("X\xabw\x95f\x8d\x1cj");
      }
    }
  }
}

function function_4c0ddaaf28551750(dimvolume, dimbutton) {
  level thread dimmer_thread(dimvolume, dimbutton);
}

function private dimmer_thread(dimvolume, dimbutton, dimbuttontime) {
  volume_dvar = @ "hash_455f5221de27673d";
  isdimmed = 0;
  isbuttonpressed = 0;
  defaultvolume = 0.8;
  setdevdvar(volume_dvar, "<dev string:x15f>" + defaultvolume);

  if(isDefined(dimvolume) == 0) {
    dimvolume = 0.1 * defaultvolume;
  }

  if(isDefined(dimbutton) == 0) {
    dimbutton = "<dev string:x163>";
  }

  if(isDefined(dimbuttontime) == 0) {
    dimbuttontime = 500;
  }

  lastvolume = defaultvolume;
  lastbuttonpressed = isbuttonpressed;
  dimhud = undefined;
  buttondowntime = 0;
  assert(isDefined(isdimmed));
  assert(isDefined(defaultvolume));
  assert(isDefined(dimvolume));
  assert(isDefined(lastvolume));
  assert(isDefined(dimbutton));

  while(true) {
    volume = getdvarfloat(volume_dvar);
    var_80110346bc4932f8 = 0;
    isbuttonpressed = level.player buttonPressed(dimbutton);

    if(isbuttonpressed == 1 && lastbuttonpressed == 0) {
      buttondowntime = gettime();
    } else if(isbuttonpressed == 0) {
      buttondowntime = 0;
    }

    if(isbuttonpressed == 1 && buttondowntime > 0) {
      buttonholdtime = gettime() - buttondowntime;

      if(buttonholdtime >= dimbuttontime) {
        var_80110346bc4932f8 = 1;
        buttondowntime = 0;
      }
    }

    if(var_80110346bc4932f8 == 1) {
      isdimmed = !isdimmed;

      switch (isdimmed) {
        case 0:
        default:
          setdevdvar(volume_dvar, "<dev string:x15f>" + defaultvolume);
          break;
        case 1:
          setdevdvar(volume_dvar, "<dev string:x15f>" + dimvolume);
          break;
      }
    }

    if(isdimmed == 1 && isDefined(dimhud) == 0) {
      color = (1, 0.623529, 0.498039);
      alpha = 0.333;
      fontscale = 2;
      x = 0;
      y = -64 * fontscale;
      dimstring = "<dev string:x170>" + dimbutton + "<dev string:x18a>";
      dimhud = newhudelem();
      dimhud.x = x;
      dimhud.y = y;
      dimhud.alignx = "<dev string:x53>";
      dimhud.aligny = "<dev string:x199>";
      dimhud.horzalign = "<dev string:x53>";
      dimhud.vertalign = "<dev string:x1a3>";
      dimhud.alpha = alpha;
      dimhud.color = color;
      dimhud.sort = 2;
      dimhud.font = "<dev string:x1ad>";
      dimhud.fontscale = fontscale;
      dimhud.shadowed = 1;
      dimhud.foreground = 1;
      dimhud.label = dimstring;
    } else if(isdimmed == 0 && isDefined(dimhud)) {
      dimhud destroy();
      dimhud = undefined;
    }

    lastvolume = defaultvolume;
    lastbuttonpressed = isbuttonpressed;
    waitframe();
  }
}

function function_1571d6ef59844e40(submix, attack, hold, release, pre_delay, scale) {
  if(isDefined(pre_delay) && pre_delay > 0) {
    wait pre_delay;
  }
}

function function_da3a8c7fa6a58b65(submix, attack, hold, release, pre_delay, dist_min, dist_max, sound_org, player_org) {
  if(!isDefined(sound_org) && isDefined(self) && isDefined(self.origin)) {
    sound_org = self.origin;
  }

  if(!isDefined(player_org)) {
    player_org = level.player.origin;
  }

  assert(isDefined(sound_org), "<dev string:x1ba>");

  if(!isDefined(pre_delay)) {
    pre_delay = 0;
  }

  if(!isDefined(dist_min)) {
    dist_min = 500;
  }

  if(!isDefined(dist_max)) {
    dist_max = 1000;
  }

  var_b20b91c0d115dd1a = squared(dist_min);
  var_d101e2bab7d22d4 = squared(dist_max);
  dist_sq = distancesquared(player_org, sound_org);

  if(dist_sq > var_d101e2bab7d22d4) {
    return;
  }

  scale = snd::scalerp(dist_sq, var_b20b91c0d115dd1a, var_d101e2bab7d22d4, 0, 0.3);
  wait pre_delay;

  if(hold == 0) {
    hold += 0.05;
  }

  wait attack + hold;
}

function function_5922c4826b88f3cf(range, view, scale) {
  thread function_a91d3812cfdb2368(range, view, scale);
}

function private function_a91d3812cfdb2368(range, view, scale) {
  self endon("Lu\x8e\xfd\xafh\xbf\xe5\xf5r\xd6w2\xaa\x7f\xbaJ+\xe9");
  level endon("px\xea~i\xda\xc6iW\xfc\xde\x104~\x86\xd1\xbf6\x98\x05\x1er\x05");
  self endon("\x1e\xfd\xd1\xa2\a");

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
    vol = snd::scalerp(vol, 0, 1, 1 - scale, 1);

    if(vol >= view) {
      function_b60d4eb789711f3b(self, vol, time);
    }
  }
}

function function_791c5dd24c093902(alias, position, range, view) {
  thread function_3ab48d6e03cd1f1(alias, position, range, view);
}

function private function_3ab48d6e03cd1f1(alias, position, range, view) {
  self endon("Lu\x8e\xfd\xafh\xbf\xe5\xf5r\xd6w2\xaa\x7f\xbaJ+\xe9");
  level endon("px\xea~i\xda\xc6iW\xfc\xde\x104~\x86\xd1\xbf6\x98\x05\x1er\x05");
  range_sq = squared(range ?? 1000);
  view = cos(view ?? 45);
  time = 0.1;

  while(true) {
    dist_sq = distancesquared(position, level.player.origin);

    if(dist_sq <= range_sq) {
      if(utility::within_fov(level.player snd::getplayervieworigin(), level.player snd::getplayerviewangles(), position, view)) {
        break;
      }
    }

    wait time;
  }

  snd::play(alias, position);
}

function function_2f9bbc3de709a345() {
  assert(isstruct(level.snd), "<dev string:x205>");

  if(!isDefined(level.snd.var_8a2c0e90334e5ba7)) {
    level.snd.var_8a2c0e90334e5ba7 = [];
    level.snd.var_8a2c0e90334e5ba7[".\xdc\x1c\x7f\xf9\xe2\xc3h\x16"] = [0, 0.02, 0.045, 0.065, 0.09, 0.11, 0.135, 0.155, 0.18, 0.2];
    level.snd.var_8a2c0e90334e5ba7["m\xb4\xb0\x80\x03\xaa \xfc1\x89\xae"] = [0.2, 0.18, 0.155, 0.135, 0.11, 0.09, 0.065, 0.045, 0.02, 0];
    level.snd.var_8a2c0e90334e5ba7["\xc5\xfe6\xba\xae\x170M\xc0,>\xe4F60\xdc\xa8\x04\xb5"] = [0, 0.01, 0.019, 0.03, 0.049, 0.068, 0.102, 0.15, 0.229, 0.343];
    level.snd.var_8a2c0e90334e5ba7["\xe2\xff\b\x9e\xd9V[?\xc4x%e\xbc\x7f\x92a\xae\xe1\x1b1\xd5"] = [0.343, 0.229, 0.15, 0.102, 0.068, 0.049, 0.03, 0.019, 0.01, 0];
    level.snd.var_8a2c0e90334e5ba7[":{'\x91\xd8O\xdf\xfeY}\xcf\xd3\xb4\x90\x01u\x1c\x11\x97"] = [0, 0.051, 0.077, 0.094, 0.108, 0.118, 0.127, 0.135, 0.142, 0.148];
    level.snd.var_8a2c0e90334e5ba7["\xf1Ym\x90\xef\x7f\r{\xb0\xf1(%H\x8a\xee_\\\xfa)\xb7m"] = [0.148, 0.142, 0.135, 0.127, 0.118, 0.108, 0.094, 0.077, 0.051, 0];
    level.snd.var_8a2c0e90334e5ba7["\x9d\xd3\xd1$"] = [0.003, 0.017, 0.057, 0.14, 0.283, 0.283, 0.14, 0.057, 0.017, 0.003];
    level.snd.var_8a2c0e90334e5ba7["\xf2\x04\xc5Xe\xcc\xc9t?]\xb0\xab5"] = [0.283, 0.14, 0.057, 0.017, 0.003, 0.003, 0.017, 0.057, 0.14, 0.283];
  }
}

function function_b910a61dafa90b62(time_min, time_max, random_curve) {
  values = [];
  values[0] = time_min;
  values_cnt = level.snd.var_8a2c0e90334e5ba7[random_curve].size;
  step = (time_max - time_min) / (values_cnt - 1);

  for(i = 1; i < values_cnt - 1; i++) {
    values[i] = values[i - 1] + step;
  }

  values[values.size] = time_max;
  return values;
}

function function_2969aea68ddb23f9(w, amount) {
  a = [];
  var_dfde9eb09e5424b2 = 1 / w.size;

  for(i = 0; i < w.size; i++) {
    diff = var_dfde9eb09e5424b2 - w[i];
    offset = (1 - amount) * abs(diff);

    if(diff < 0) {
      offset *= -1;
    }

    a[i] = w[i] + offset;
  }

  return a;
}

function function_2135abdaedd283b4(w, v) {
  values_cnt = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = v[v.size - 1];

  for(i = 0; i < values_cnt; i++) {
    total += w[i];

    if(r < total) {
      ret_value = v[i];
      break;
    }
  }

  return ret_value;
}

function function_efecb73201464243(w) {
  values_cnt = w.size;
  r = randomfloat(1);
  total = 0;
  ret_value = w.size - 1;

  for(i = 0; i < values_cnt; i++) {
    total += w[i];

    if(r < total) {
      ret_value = i;
      break;
    }
  }

  return ret_value;
}

function function_558541adfdb1dfa(min, max, random_curve) {
  if(isDefined(random_curve)) {
    weights = level.snd.var_8a2c0e90334e5ba7[random_curve];

    if(isDefined(weights)) {
      values = function_b910a61dafa90b62(min, max, random_curve);
      var_ccbe67c2387b7345 = function_efecb73201464243(weights);
      min_idx = 0;
      max_idx = values.size - 1;

      if(var_ccbe67c2387b7345 == 0) {
        max_idx = 1;
      } else if(var_ccbe67c2387b7345 == values.size - 1) {
        min_idx = max_idx - 1;
      } else {
        min_idx = var_ccbe67c2387b7345 - 1;
        max_idx = var_ccbe67c2387b7345 + 1;
      }

      return randomfloatrange(values[min_idx], values[max_idx]);
    }
  }
}

function function_892658f0a1334173(min, max, label = "\xfd\xba\xd0\xd8p\xf89\xd40\xfa\t\x83\xb0F", width = 0) {
  assert(isstruct(level.snd), "<dev string:x205>");

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
    x = snd::scalerp(x, min, max, max - randomfloatrange(0, range * 0.35), min + randomfloatrange(0, range * 0.35));
    x = clamp(x, min, max);
  }

  level.snd.random_aid.label = x;
  return x;
}

function private function_c02de021fa8d2355(alias, submix, attack, hold, release, scale) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb5H\xa9\xa9\x90\x97" + alias);

  while(true) {
    self waittill("\x94\x12\xdc\xa5a\x8c\x8aZ`\x83\xd6~\x01", var_6adb959ef84acd65);

    if(isDefined(var_6adb959ef84acd65) && var_6adb959ef84acd65 == alias) {
      break;
    }
  }
}

function function_8b81591c2f7ce5b8(alias, submix, scale, attack, release, radio) {
  ent = self;
  var_ba7fc2a931403cfe = 1;

  if(!isDefined(submix)) {
    submix = "\x12n\xf2\xcb\xd07\xf3\xacX\x16a\xc64s;\xf61";
  }

  if(!isDefined(scale)) {
    scale = 0.5;
  }

  assert(scale >= 0 && scale <= 1, "<dev string:x221>");

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
    alert_text = "<dev string:x246>" + alias + "<dev string:x251>";
    snd::function_9c0efd22ee470aa6(alert_text);

    var_ba7fc2a931403cfe = 0;
    return;
  }

  volmod = snd::function_302283a0a28785a6(alias, "U\x19\xcck-\x1fD");

  if(snd::condition_alert(volmod != "\xc5\xee\xff\xaa\x04]\xfc\xbas\x8a]!\xcb\xc3(", "\x1csdl[\x9e\xe5" + alias + "g\xb8\xb5\xbb\xef\x18\xe11\xac\xe7\x1b\xf4.\xb9\x19\xb6\xaf\xcc&\x1b@\x06\x1b9\xef.\xf9\x13\x14D\x9b\b:" + volmod + "D\xb7")) {
    var_ba7fc2a931403cfe = 0;
  }

  sndlength = lookupsoundlength(alias);
  hold = sndlength - attack - release;

  if(hold < 0) {
    hold = 0;
  }

  if(snd::condition_alert(sndlength <= 0, "\x1csdl[\x9e\xe5" + alias + "\r\x9e \x1dc\xces\xfc\xbf" + sndlength + "\x1d\xff\xd7\xfe8a\xe3\xbd\xb3E1l\xdf\x0e\xe9\xaf\xf0\xcd<^\x9d\xf4")) {
    var_ba7fc2a931403cfe = 0;
  }

  if(var_ba7fc2a931403cfe == 1) {
    falloffmin = snd::function_302283a0a28785a6(alias, "4\xb2^0\xb8\xca\x14\x13");
    falloffmax = snd::function_302283a0a28785a6(alias, "FZ7G\xeb\xad,\x87");
    thresh = falloffmax * 0.5;
    thresh_sq = squared(thresh);
    dist_sq = 0;

    if(isDefined(ent) && isDefined(ent.origin) && radio == 0) {
      dist_sq = distancesquared(ent.origin, level.player.origin);
    }

    if(dist_sq > thresh_sq) {
      var_ba7fc2a931403cfe = 0;

      if(snd::function_8c35a6f99f836040() > 0) {
        snd::function_9c0efd22ee470aa6("<dev string:x266>" + alias + "<dev string:x27d>" + sqrt(dist_sq) / 12 + "<dev string:x283>");
      }
    } else {
      ent thread function_c02de021fa8d2355(alias, submix, attack, hold, release, scale);
    }
  }

  if(ent == level.player || radio == 1) {
    ent utility_sp::smart_radio_dialogue(alias);
    return;
  }

  ent utility_sp::smart_dialogue(alias);
}

function private function_75d4a2c48efcbf6e(soundobject) {
  snd::init_obj(soundobject);
  assert(isstruct(soundobject.snd));

  if(isDefined(soundobject) && snd::function_cd79b44ba8163808(soundobject) == 0 && isDefined(soundobject.snd.scale) == 0) {
    soundobject.snd.scale = spawnStruct();
    soundobject.snd.scale.volume = 1;
    soundobject.snd.scale.pitch = 1;
    soundobject.snd.scale.threads = [];
    function_7121ca342058e08c(soundobject, snd::function_7c0b49ad82cf43cd());
  }
}

function private function_5f903ce63b6cdf8e(sound, volume, time) {
  sound scalevolume(volume, time);
}

function private function_925670658601f534(sound, volume, time) {
  sound scalepitch(volume, time);
}

function private function_6f9f5c426b7e2769(soundobject, value, scalefunc) {
  if(snd::function_cd79b44ba8163808(soundobject) || isDefined(soundobject) == 0) {
    return;
  }

  function_75d4a2c48efcbf6e(soundobject);
  assert(isDefined(soundobject.snd.scale));

  if(isDefined(scalefunc)) {
    if(scalefunc == &function_5f903ce63b6cdf8e) {
      soundobject.snd.scale.volume = value;
      return;
    }

    if(scalefunc == &function_925670658601f534) {
      soundobject.snd.scale.pitch = value;
    }
  }
}

function private function_33dccd51b5869fe5(soundobject, scalefunc) {
  assert(isDefined(soundobject));

  if(isstruct(soundobject.snd) && isDefined(soundobject.snd.scale)) {
    if(scalefunc == &function_5f903ce63b6cdf8e) {
      return soundobject.snd.scale.volume;
    } else if(scalefunc == &function_925670658601f534) {
      return soundobject.snd.scale.pitch;
    }
  }

  return undefined;
}

function private _scale_completed(scalefunc) {
  var_71316eadc7fac12b = 0;
  scalestring = undefined;
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x90\f\xcd\xf6\xbf\x95\xb2\x9cM\f\xf500o\rv\xae\x91\xcd");
  assert(isDefined(scalefunc), "<dev string:x291>");

  if(scalefunc == &function_5f903ce63b6cdf8e) {
    self.snd.scale.isscalingvolume = undefined;
    scalestring = "\x8e\x971\xf5B\x14";
  }

  if(scalefunc == &function_925670658601f534) {
    self.snd.scale.isscalingpitch = undefined;
    scalestring = "\x84K\x8f\xddK";
  }

  assert(isDefined(scalestring));
  self.snd.scale.threads[scalestring] = undefined;

  if(isDefined(self.snd.scale.isscalingvolume) == 0 && isDefined(self.snd.scale.isscalingpitch) == 0) {
    self.snd.scale.isscaling = undefined;
  }

  self notify("\xefm\xba\xcc\xd8\f,\x94\x99V\b*\\\x96\xdb" + scalestring);
  waittillframeend();
}

function private function_1c4bff0b7b903bed(curve, scale, time, scalefunc, callbackfunc) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x83d\x9a\x12\xb9\x93B");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(self.snd.scale));
  assert(isDefined(self.snd.scale.threads));
  assert(isDefined(scalefunc));
  assert(time > 0);
  curvepts = snd::curve_size(curve);
  assert(curvepts > 0, "<dev string:x15f>");
  frametime = float(snd::function_7c0b49ad82cf43cd());
  timeremainder = float(time) % frametime;
  time = float(time) + frametime - timeremainder;
  timeinterval = float(time) / float(curvepts);
  timeintervalremainder = timeinterval % frametime;
  timeinterval = timeinterval + frametime - timeintervalremainder;
  timeinterval = max(timeinterval, frametime);
  timeintervalms = int(timeinterval * 1000 + 0.5);
  timems = int(time * 1000 + 0.5);
  timecounterms = int(0);

  if(isDefined(self.snd.scale.isscaling)) {
    var_34fafcbd88691839 = 0;

    if(isDefined(self.snd.scale.isscalingvolume) && scalefunc == &function_5f903ce63b6cdf8e || isDefined(self.snd.scale.isscalingpitch) && scalefunc == &function_925670658601f534) {
      var_34fafcbd88691839 = 1;
    }

    if(var_34fafcbd88691839 == 1) {
      self notify("\x90\f\xcd\xf6\xbf\x95\xb2\x9cM\f\xf500o\rv\xae\x91\xcd", scalefunc);
      waittillframeend();
      self notify("z\x94\x92\x9c?_]\x02\xb2^\x89\xc8*\xfa\xd5\xed\xbe\x92\x83\xa0o", scalefunc);
    }
  }

  scalestart = function_33dccd51b5869fe5(self, scalefunc);
  inversecurve = 0;

  if(scalestart > scale) {
    inversecurve = 1;
  }

  while(isDefined(self.soundalias) == 0) {
    waitframe();
  }

  waittillframeend();
  thread _scale_completed(scalefunc);
  self.snd.scale.isscaling = 1;
  scalestring = undefined;

  if(scalefunc == &function_5f903ce63b6cdf8e) {
    self.snd.scale.isscalingvolume = 1;
    scalestring = "\x8e\x971\xf5B\x14";
  }

  if(scalefunc == &function_925670658601f534) {
    self.snd.scale.isscalingpitch = 1;
    scalestring = "\x84K\x8f\xddK";
  }

  assert(isDefined(scalestring));
  self.snd.scale.threads[scalestring] = getthread();
  self endon("\xefm\xba\xcc\xd8\f,\x94\x99V\b*\\\x96\xdb" + scalestring);

  while(timecounterms < timems && isDefined(self) && isDefined(self.snd.scale.threads[scalestring])) {
    remainingtime = (timems - timecounterms) * 0.001;

    if(isDefined(self.snd.scale.waitinterval)) {
      timeinterval = max(self.snd.scale.waitinterval, frametime);
    }

    waittime = min(timeinterval, remainingtime);
    timecounterms += int(waittime * 1000 + 0.5);
    timefrac = float(timecounterms) / float(timems);
    scalevalue = 1;

    if(inversecurve > 0) {
      timefrac = clamp(1 - timefrac, 0, 1);
      curvevalue = snd::curve_value(timefrac, curve);
      scalevalue = math::lerp(scale, scalestart, curvevalue);
    } else {
      curvevalue = snd::curve_value(timefrac, curve);
      scalevalue = math::lerp(scalestart, scale, curvevalue);
    }

    [[scalefunc]](self, scalevalue, waittime);
    wait waittime;

    if(isDefined(self) && snd::function_cd79b44ba8163808(self) == 0) {
      function_6f9f5c426b7e2769(self, scalevalue, scalefunc);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self)) {
    self notify("\x90\f\xcd\xf6\xbf\x95\xb2\x9cM\f\xf500o\rv\xae\x91\xcd", scalefunc);
  }

  if(isDefined(callbackfunc)) {
    self[[callbackfunc]]();
  }
}

function function_7121ca342058e08c(soundobject, waitinterval) {
  assert(isDefined(soundobject));
  function_75d4a2c48efcbf6e(soundobject);
  assert(isDefined(soundobject.snd.scale));
  soundobject.snd.scale.waitinterval = max(waitinterval, snd::function_7c0b49ad82cf43cd());
}

function private snd_scale(soundobject, scalewhat, value, time, curve, callbackfunc) {
  if(snd::condition_alert(isDefined(soundobject) == 0, "-\xedI\x01\n\xc6a\x04F\n\xf0Z\xf8\xe9\xe7\xa8\xe8\xa3\xf9\xc4W\xa5^\x06F\xc6d~\xe9I\xab\xacj\xf7\xb9\xad\"")) {
    return;
  }

  if(snd::condition_alert(snd::function_cd79b44ba8163808(soundobject), "e/C\xc7{\xa0\x13\xefC\xad\xccbyu)\xc4T=uv!E\n\xf3\xe7\x969n\xb8_+\x16\xc4\xaf'")) {
    return;
  }

  assert(isDefined(soundobject), "<dev string:x2bb>");
  assert(snd::function_cd79b44ba8163808(soundobject) == 0, "<dev string:x2e4>");
  assert(isDefined(value));
  function_75d4a2c48efcbf6e(soundobject);
  clampedvalue = value;
  scalefunc = undefined;
  scalestring = undefined;

  switch (scalewhat) {
    case #"hash_5c14048f84c6fdef":
      if(!isDefined(curve)) {
        curve = "m\xa29\xe3A\xe8D";
      }

      scalefunc = &function_5f903ce63b6cdf8e;
      scalestring = "\x8e\x971\xf5B\x14";
      clampedvalue = clamp(value, 0, 4);
      snd::condition_alert(value != clampedvalue, "j\x85\xd2\xf4{\xb9>\x81\r\x86F\x1b\x84K\xbd\x9fR\xf3v\xc6\xa0\xa2\xef\f\x8d-" + value + "\xa5\xb4O\xce" + clampedvalue);
      break;
    case #"hash_d7a0f5b3b8320991":
      if(!isDefined(curve)) {
        curve = "s\xd9!`\x94\x9d";
      }

      scalefunc = &function_925670658601f534;
      scalestring = "\x84K\x8f\xddK";
      clampedvalue = clamp(value, 0.00390625, 2);
      snd::condition_alert(value != clampedvalue, "\xa3Pi8m^v^D\xc7:\xdd\xb8\xca\xady\xcd\x954\xf0\xb3\xe0/\x12@" + value + "\xa5\xb4O\xce" + clampedvalue);
      break;
  }

  assert(isDefined(soundobject));

  if(isDefined(time) == 0 || time == 0) {
    [[scalefunc]](soundobject, clampedvalue, 0);
    function_6f9f5c426b7e2769(soundobject, clampedvalue, scalefunc);
    soundobject notify("\x90\f\xcd\xf6\xbf\x95\xb2\x9cM\f\xf500o\rv\xae\x91\xcd", scalefunc);
    soundobject notify("z\x94\x92\x9c?_]\x02\xb2^\x89\xc8*\xfa\xd5\xed\xbe\x92\x83\xa0o");
    soundobject notify("\xefm\xba\xcc\xd8\f,\x94\x99V\b*\\\x96\xdb" + scalestring);
    return;
  }

  soundobject thread function_1c4bff0b7b903bed(curve, clampedvalue, time, scalefunc, callbackfunc);

  if(scalefunc == &function_5f903ce63b6cdf8e) {
    soundobject notify("\xf1s \xbc\t0\x01{");
  }
}

function private function_b60d4eb789711f3b(soundobject, volume, time, curve, callbackfunc) {
  snd_scale(soundobject, "\x8e\x971\xf5B\x14", volume, time, curve, callbackfunc);
}

function private function_799119cdba53d447(soundobject, pitch, time, curve, callbackfunc) {
  snd_scale(soundobject, "\x84K\x8f\xddK", pitch, time, curve, callbackfunc);
}

function private function_1574edd3d7c768f(soundobject) {
  if(snd::condition_alert(isDefined(soundobject) == 0, "-\xedI\x01\n\xc6a\x04F\n\xf0Z\xf8\xe9\xe7\xa8\xe8\xa3\xf9\xc4W\xa5^\x06F\xc6d~\xe9I\xab\xacj\xf7\xb9\xad\"")) {
    return 0;
  }

  if(snd::condition_alert(snd::function_cd79b44ba8163808(soundobject), "e/C\xc7{\xa0\x13\xefC\xad\xccbyu)\xc4T=uv!E\n\xf3\xe7\x969n\xb8_+\x16\xc4\xaf'")) {
    return 0;
  }

  assert(isDefined(soundobject));
  return function_33dccd51b5869fe5(soundobject, &function_5f903ce63b6cdf8e);
}

function private function_350a8cfc2e157a3b(soundobject) {
  if(snd::condition_alert(isDefined(soundobject) == 0, "-\xedI\x01\n\xc6a\x04F\n\xf0Z\xf8\xe9\xe7\xa8\xe8\xa3\xf9\xc4W\xa5^\x06F\xc6d~\xe9I\xab\xacj\xf7\xb9\xad\"")) {
    return 0;
  }

  if(snd::condition_alert(snd::function_cd79b44ba8163808(soundobject), "e/C\xc7{\xa0\x13\xefC\xad\xccbyu)\xc4T=uv!E\n\xf3\xe7\x969n\xb8_+\x16\xc4\xaf'")) {
    return 0;
  }

  assert(isDefined(soundobject));
  return function_33dccd51b5869fe5(soundobject, &function_925670658601f534);
}

function private function_b04ee9ff97b2cd73() {
  assert(isDefined(self));

  if(isDefined(self.snd.timer)) {
    self waittill("Kr\x1a\xado\xc7\x9cR\xbf^\xcfq\b\xdf\xd1 \xc5\x1fE");

    if(isDefined(self.snd.timer.soundent)) {
      self.snd.timer.soundent delete();
    }

    self.snd.timer = undefined;
  }
}

function private _timer_thread(totaltime, tickalias, tockalias, pitchlo, pitchhi, pitchcurve, endcallback) {
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
    pitchcurve = "s\xd9!`\x94\x9d";
  }

  thread function_b04ee9ff97b2cd73();
  self endon("Kr\x1a\xado\xc7\x9cR\xbf^\xcfq\b\xdf\xd1 \xc5\x1fE");

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

    var_c79ce4991d54381f = remainingtime - ticktockinterval;
    var_ffafd84c9fcacf63 = var_c79ce4991d54381f % ticktockinterval;
    var_c79ce4991d54381f = var_c79ce4991d54381f + ticktockinterval - var_ffafd84c9fcacf63;

    if(remainingtime <= var_c79ce4991d54381f) {
      if(self.snd.timer.soundticktock != 0) {
        self.snd.timer.soundent playSound(tickalias);
        self.snd.timer.soundticktock = 0;
      } else {
        self.snd.timer.soundent playSound(tockalias);
        self.snd.timer.soundticktock = 1;
      }

      assert(isDefined(self.snd.timer.soundent));
      timerpitch = snd::scalerp(remainingtime, 0, totaltime, pitchhi, pitchlo);
      function_799119cdba53d447(self.snd.timer.soundent, timerpitch, 0.05, pitchcurve);
    }

    waitframe();
  }

  if(isDefined(endcallback)) {
    self[[endcallback]]();
  }

  self notify("Kr\x1a\xado\xc7\x9cR\xbf^\xcfq\b\xdf\xd1 \xc5\x1fE");
}

function timer_stop() {
  if(isDefined(self.snd.timer)) {
    self notify("Kr\x1a\xado\xc7\x9cR\xbf^\xcfq\b\xdf\xd1 \xc5\x1fE");
  }
}

function timer(totaltime, tickalias, tockalias, endalias, pitchlo, pitchhi, pitchcurve, endcallback) {
  assert(isDefined(self));
  assert(isDefined(tickalias));

  if(isDefined(self.snd.timer)) {
    timer_stop();
  }

  starttime = gettime();
  totaltime = int(totaltime * 1000 + 0.5);
  snd::init_obj(self);

  if(isDefined(self.snd.timer) == 0) {
    self.snd.timer = spawnStruct();
    self.snd.timer.endtime = starttime + totaltime;
    self.snd.timer.soundticktock = 0;
    self.snd.timer.soundent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    self.snd.timer.soundent linkTo(self);
  }

  thread _timer_thread(totaltime, tickalias, tockalias, pitchlo, pitchhi, pitchcurve, endcallback);
}

function private function_80f89fe5c306b980(var_b3f3279ff4f2240a) {
  level endon("m\x1d~\xb4!\xf8\xdfXX*\xf6\xe9\b\x1f");
  radioconvo = [];
  lastconvo = [];
  assert(isstruct(level.snd), "<dev string:x205>");
  assert(isarray(level.snd.radioconvos));
  snd::waitforplayers();

  while(true) {
    waittime = snd::randomhelper(var_b3f3279ff4f2240a);
    wait waittime;

    if(isDefined(level.snd.var_7e95af24f394c382) == 0 || level.snd.var_7e95af24f394c382.size == 0) {
      function_84738231e4841291();
      level.snd.var_7e95af24f394c382 = arrayremove(level.snd.var_7e95af24f394c382, lastconvo);
    }

    radioconvo = level.snd.var_7e95af24f394c382[0];
    lastconvo = radioconvo;

    while(isarray(radioconvo) && radioconvo.size > 0) {
      radioline = radioconvo[0];

      if(soundexists(radioline)) {
        playtime = lookupsoundlength(radioline) / 1000;

        foreach(player in level.players) {
          player playlocalsound(radioline);
        }

        wait playtime;
        wait 0.666;
      }

      radioconvo = arrayremove(radioconvo, radioline);
    }

    level.snd.var_7e95af24f394c382 = arrayremove(level.snd.var_7e95af24f394c382, lastconvo);
  }
}

function function_ba651d6cc07c6068(var_b3f3279ff4f2240a) {
  if(isDefined(var_b3f3279ff4f2240a) == 0) {
    var_b3f3279ff4f2240a = [6, 12];
  }

  level thread function_80f89fe5c306b980(var_b3f3279ff4f2240a);
}

function radioconvostop() {
  level notify("m\x1d~\xb4!\xf8\xdfXX*\xf6\xe9\b\x1f");
}

function function_84738231e4841291() {
  if(isDefined(level.snd.radioconvos)) {
    level.snd.var_7e95af24f394c382 = utility::array_randomize(level.snd.radioconvos);
  }
}

function submix_flag(flag_name, submix_name, fade_in_time, fade_out_time) {
  level thread function_d43e967b417e2ba(flag_name, submix_name, fade_in_time, fade_out_time);
}

function private function_d43e967b417e2ba(flag_name, submix_name, fade_in_time, fade_out_time) {
  level.player endon("\x1e\xfd\xd1\xa2\a");

  if(!utility::flag_exist(flag_name)) {
    utility::flag_init(flag_name);
  }

  if(!isDefined(fade_in_time)) {
    fade_in_time = 0.5;
  }

  if(!isDefined(fade_out_time)) {
    fade_out_time = 0.5;
  }

  while(true) {
    utility::flag_wait(flag_name);
    level.player setsoundsubmix(submix_name, fade_in_time);
    utility::flag_waitopen(flag_name);
    level.player clearsoundsubmix(submix_name, fade_out_time);
  }
}