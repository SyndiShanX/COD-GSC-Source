/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_480b1940332161de.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\debug;
#namespace poi;

function private autoexec __init__system__() {
  system::register(#"poi", &function_f64316de, undefined, undefined, undefined);
}

function enable(shouldenable, firstpoint, var_8fbcda45) {
  assert(isactor(self));
  assert(shouldenable === 1 || shouldenable === 0, "<dev string:x38>");

  if(is_true(shouldenable)) {
    if(!isDefined(self.poi)) {
      self.poi = {};
    }
  } else if(!isDefined(self.poi)) {
    return;
  }

  if(!shouldenable && (isDefined(self.poi.currentpoi.var_3b03815e) ? self.poi.currentpoi.var_3b03815e : 0) > gettime()) {
    self ai::look_at(undefined, 3);
  }

  self.poi.currentpoi = undefined;
  self.poi.nextpoi = undefined;
  self.poi.doingpoi = shouldenable;
  self.poi.var_8fbcda45 = var_8fbcda45;

  if(!shouldenable) {
    assert(isDefined(level.poi.var_5ee53e3), "<dev string:x69>");
    arrayremovevalue(level.poi.var_5ee53e3, self);
    self.turnrate = isDefined(self.poi.poi_oldturnrate) ? self.poi.poi_oldturnrate : self.turnrate;
    self.gunadditiveoverride = undefined;
    self.gunposeoverride = undefined;

    if(isDefined(self.poi.auto)) {
      self.poi = {
        #auto: self.poi.auto
      };
    } else {
      self.poi = undefined;
    }

    self notify(#"poi_disabled");
    return;
  }

  if(!isDefined(self.poi.var_1365068)) {
    self.poi.var_1365068 = self function_359fd121();
  }

  var_67b78bf3 = function_f002dade("human", "fast");
  var_47658db3 = function_15a5703b("human", min(self.poi.var_1365068, var_67b78bf3));
  self setdesiredspeed(var_47658db3);

  if(!isDefined(level.poi.var_5ee53e3)) {
    level.poi.var_5ee53e3 = [];
  }

  if(!array::contains(level.poi.var_5ee53e3, self)) {
    level.poi.var_5ee53e3[level.poi.var_5ee53e3.size] = self;
  }

  if(isDefined(level.poi.fnfindcqbpointsofinterest)) {
    level thread[[level.poi.fnfindcqbpointsofinterest]]();
  }

  assert(!isDefined(firstpoint) || isstruct(firstpoint));
  self.poi.poi_oldturnrate = self.turnrate;
  self.turnrate = 0.25;
  self.poi.leftaimlimit = 90;
  self.poi.rightaimlimit = -90;
  self.poi.poi_firstpoint = firstpoint;
  self.gunposeoverride = "disable";
  self notify(#"poi_enabled");
}

function function_fc1d22bd(shouldenable, yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45) {
  shouldenable = is_true(shouldenable);

  if(shouldenable && !isDefined(self.poi.auto)) {
    self auto_init(yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45);
    self thread function_c6ff2ee5();
    self notify(#"hash_4f88221ad3977829");
    return;
  }

  if(!shouldenable && isDefined(self.poi.auto)) {
    self notify(#"poiauto_disable");
    self ai::look_at(self.poi.auto.angles, 3, 1, float(function_60d95f53()) / 1000, self.poi.auto.var_8fbcda45, 1);
    self.poi.auto = undefined;
    self notify(#"hash_eb07a9b95814b4a");
  }
}

function private function_f64316de() {
  level.poi = {};
  level.poi.var_1ee388be = [];
  level.poi.fnfindcqbpointsofinterest = &function_b31aaef9;
  level.poi.fnenable = &enable;
  level.poi.var_38974483 = &function_fc1d22bd;

  function_5ac4dc99("<dev string:xa7>", 0);
  function_cd140ee9("<dev string:xa7>", &function_c30fad9a);

  thread function_4de58b23();
}

function private function_4de58b23() {
  waittillframeend();
  level.poi.var_1ee388be = struct::get_array("poi", "variantname");
  remove = [];

  foreach(poi in level.poi.var_1ee388be) {
    if(!is_true(poi.script_auto_use)) {
      remove[remove.size] = poi;
    }
  }

  level.poi.var_1ee388be = array::exclude(level.poi.var_1ee388be, remove);
}

function private function_b31aaef9() {
  if(is_true(level.poi.alreadyfindingpoi)) {
    return;
  }

  level.poi.alreadyfindingpoi = 1;
  waitframe(1);

  while(true) {
    if(!isarray(level.poi.var_5ee53e3) || level.poi.var_5ee53e3.size == 0) {
      level.poi.alreadyfindingpoi = undefined;
      return;
    }

    var_6a9ced4 = [];
    waited = 0;

    foreach(guy in level.poi.var_5ee53e3) {
      if(isalive(guy) && is_true(guy.poi.doingpoi) && !guy is_combat()) {
        poi = guy function_f3a2a643();

        if(isDefined(poi) && poi !== guy.poi.currentpoi) {
          now = gettime();
          guy.poi.poi_starttime = now;
          guy.poi.currentpoi = poi;
          var_8fbcda45 = isDefined(poi.var_1eabcced) ? poi.var_1eabcced : self.poi.var_8fbcda45;
          var_9ced4e21 = poi util::function_4b93f9c2();

          if((isDefined(var_9ced4e21) ? var_9ced4e21 : 0) == 0) {
            var_9ced4e21 = float(2000) / 1000;
          }

          guy.poi.currentpoi.var_3b03815e = now + var_9ced4e21 * 1000;
          guy ai::look_at(poi.origin, 3, 1, var_9ced4e21, var_8fbcda45);
          guy thread function_d0341c76(3, var_9ced4e21);
        }

        waitframe(1);
        waited = 1;
        continue;
      }

      var_6a9ced4[var_6a9ced4.size] = guy;
    }

    foreach(guy in var_6a9ced4) {
      arrayremovevalue(level.poi.var_5ee53e3, guy);
    }

    if(!waited) {
      wait 0.25;
    }
  }
}

function private function_f3a2a643() {
  ismoving = isDefined(self.pathgoalpos);
  haspoi = isDefined(self.poi.currentpoi);

  if(!haspoi && isDefined(self.poi.poi_firstpoint)) {
    return function_aabc1f4c();
  }

  if(haspoi && isDefined(self.poi.currentpoi.target) || isDefined(self.poi.nextpoi)) {
    return function_75334336(haspoi);
  }

  self.poi.nextpoi = undefined;

  if(haspoi) {
    assert(isDefined(self.poi.poi_starttime));

    if(gettime() < self.poi.poi_starttime + 2000) {
      return self.poi.currentpoi;
    }
  }

  var_c2fb3093 = undefined;
  var_dea63fff = 1048576;

  foreach(var_a9af01c3 in level.poi.var_1ee388be) {
    var_970aced0 = float(isDefined(var_a9af01c3.var_715fc83d) ? var_a9af01c3.var_715fc83d : 0) * 1000;

    if(var_970aced0 <= 0) {
      var_970aced0 = 5000;
    }

    if(isDefined(var_a9af01c3.var_3b03815e) && gettime() < var_a9af01c3.var_3b03815e + var_970aced0) {
      continue;
    }

    poi = var_a9af01c3.origin;
    var_49277a4f = vectornormalize(poi - self.origin);
    var_6045790a = acos(vectordot(anglesToForward(self.angles), var_49277a4f));

    if(var_6045790a >= 50) {
      continue;
    }

    var_38a7325b = distance2d(self.origin, poi);

    if(var_38a7325b > var_dea63fff) {
      continue;
    }

    if(!sighttracepassed(self.origin, poi, 0, undefined)) {
      continue;
    }

    var_c2fb3093 = var_a9af01c3;
    var_dea63fff = var_38a7325b;
  }

  return var_c2fb3093;
}

function private function_aabc1f4c() {
  assert(isDefined(self.poi.poi_firstpoint));

  if(sighttracepassed(self getEye(), self.poi.poi_firstpoint.origin, 0, undefined)) {
    poi = self.poi.poi_firstpoint;

    if(isDefined(poi.target)) {
      self.poi.nextpoi = struct::get(poi.target, "targetname");
    }

    if(function_a6d41d6e(poi)) {
      return poi;
    } else {
      return undefined;
    }

    return;
  }

  return undefined;
}

function private function_75334336(haspoi) {
  min_time = undefined;
  assert(haspoi && isDefined(self.poi.currentpoi.target) || isDefined(self.poi.nextpoi));

  if(haspoi) {
    if(isDefined(self.poi.currentpoi.target)) {
      self.poi.nextpoi = struct::get(self.poi.currentpoi.target, "targetname");
    } else {
      self.poi.nextpoi = undefined;
    }
  }

  if(isDefined(self.poi.poi_firstpoint)) {
    self.poi.poi_firstpoint = undefined;
  }

  min_time = 2000;

  if(haspoi) {
    var_d78af89e = self.poi.currentpoi util::function_4b93f9c2();

    if(var_d78af89e > 0) {
      min_time = var_d78af89e;
    }
  }

  if(!isDefined(self.poi.nextpoi)) {
    self notify(#"hash_1a7483ed1381776b");

    if(gettime() < self.poi.poi_starttime + min_time && function_a6d41d6e(self.poi.currentpoi)) {
      return self.poi.currentpoi;
    } else {
      self enable(0);
      return undefined;
    }
  }

  if(haspoi && gettime() < self.poi.poi_starttime + min_time && function_a6d41d6e(self.poi.currentpoi)) {
    return self.poi.currentpoi;
  }

  if(!sighttracepassed(self getEye(), self.poi.nextpoi.origin, 0, undefined)) {
    return undefined;
  }

  if(!function_a6d41d6e(self.poi.nextpoi)) {
    if(isDefined(self.poi.nextpoi.target)) {
      self.poi.nextpoi = struct::get(self.poi.nextpoi.target, "targetname");
    } else {
      self enable(0);
    }

    return undefined;
  }

  return self.poi.nextpoi;
}

function private function_a6d41d6e(poi) {
  if(is_true(self.poi.poi_disablefov)) {
    return true;
  }

  assert(isDefined(poi));
  myforward = anglesToForward(self.angles);
  var_82b1379b = acos(vectordot(myforward, vectornormalize(poi.origin - self getEye())));
  return var_82b1379b < (isDefined(self.poi.poi_fovlimit) ? self.poi.poi_fovlimit : 90);
}

function private is_combat() {
  assert(!isDefined(self) || isactor(self));

  if(isDefined(self.stealth) && level flag::get("stealth_spotted")) {
    return true;
  }

  if(isDefined(self.enemy)) {
    return true;
  }

  return false;
}

function private function_d0341c76(priority, var_9ced4e21) {
  self endon(#"death");
  result = self waittilltimeout(var_9ced4e21, #"stealth_attack", #"enemy");

  if(result._notify == "stealth_attack" || result._notify == "enemy") {
    self ai::look_at(undefined, priority, 1);
  }
}

function private auto_init(yawmin = 15, yawmax = 35, pitchmin = -20, pitchmax = 0, var_8fbcda45) {
  if(!isDefined(self.poi)) {
    self.poi = {};
  }

  self.poi.auto = {};
  self.poi.auto.yawmax = yawmax;
  self.poi.auto.yawmin = yawmin;
  self.poi.auto.pitchmin = pitchmin;
  self.poi.auto.pitchmax = pitchmax;
  self.poi.auto.var_8fbcda45 = var_8fbcda45;
}

function private function_c6ff2ee5() {
  self notify(#"poiauto_disable");
  self endon(#"poiauto_disable");
  self endon(#"death");
  var_796d6ecf = 500;
  var_b785492c = 0;
  var_8dfbd33c = 0;
  var_960224ae = gettime() + 30000;

  if(!isDefined(self.poi.auto)) {
    self auto_init();
  }

  self childthread function_4c4e4ab0();

  while(true) {
    secondaim = 0;

    if(var_960224ae <= gettime()) {
      self.poi.auto.angles = (0, 0, 0);

      if(var_960224ae == var_b785492c) {
        secondaim = 1;
      }
    }

    if(var_b785492c <= gettime()) {
      var_960224ae = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      var_8dfbd33c = gettime();
      function_504eb38e(secondaim);
      var_456b9fca = var_796d6ecf - gettime();
      var_33e79978 = var_960224ae - gettime();

      if(abs(var_33e79978 - var_456b9fca) >= 550 && math::cointoss()) {
        var_b785492c = var_960224ae;
      } else if(var_456b9fca > 3000) {
        var_b785492c = gettime() + randomintrange(2000, 3000);
      } else {
        var_b785492c = gettime() + var_456b9fca + 550 + randomintrange(1000, 2000);
      }
    }

    waitframe(1);
  }
}

function private function_34ed055a(angles) {
  forward = anglesToForward(angles);
  worldforward = rotatepoint(forward, self.angles);
  eye = self getEye();
  pos = eye + worldforward * 128;
  return pos;
}

function private function_e019f08b() {
  yaw = randomfloatrange(-45, 45);
  pitch = randomfloatrange(-20, 20);
  pos = function_34ed055a((pitch, yaw, 0));
  self.poi.auto.glancing = 1;
  self thread function_18a11ca3();
  self ai::look_at(pos, 3, 1, 0.55);
}

function private function_18a11ca3() {
  self notify(#"poiauto_glanceend");
  self endon(#"poiauto_glanceend");
  wait 0.55;
  self.poi.auto.glancing = 0;
}

function private function_28f716d5() {
  return is_true(self.poi.auto.glancing);
}

function private function_504eb38e(secondaim) {
  if(secondaim) {
    self.poi.auto.angles = self.poi.auto.nextangles;
    yaw = randomfloatrange(self.poi.auto.angles[1] + 5, self.poi.auto.angles[1] + 10);
    pitch = randomfloatrange(5, 10);

    if(math::cointoss()) {
      pitch *= -1;
    }

    pitch = self.poi.auto.angles[0] + pitch;

    if(math::cointoss()) {
      yaw *= -1;
    }
  } else {
    poiauto = self.poi.auto;
    yaw = randomfloatrange(poiauto.yawmin, poiauto.yawmax);
    pitch = randomfloatrange(poiauto.pitchmin, poiauto.pitchmax);

    if(math::cointoss()) {
      yaw *= -1;
    }

    self.poi.auto.angles = (pitch, yaw, 0);
  }

  self.poi.auto.nextangles = (pitch, yaw, 0);
  self.poi.auto.var_f0ada51b = randomintrange(100, 300) + gettime();
  self ai::look_at(self.poi.auto.angles, 3, 1, 0, self.poi.auto.var_8fbcda45, 1);
}

function private function_636d2b5d(yawmax, yawmin, pitchmin, pitchmax) {
  assert(isDefined(self.poi.auto));

  if(!isDefined(self.poi.auto.og_yawmax)) {
    self.poi.auto.og_yawmax = self.poi.auto.yawmax;
  }

  if(!isDefined(self.poi.auto.og_yawmin)) {
    self.poi.auto.og_yawmin = self.poi.auto.yawmin;
  }

  if(!isDefined(self.poi.auto.og_pitchmin)) {
    self.poi.auto.og_pitchmin = self.poi.auto.pitchmin;
  }

  if(!isDefined(self.poi.auto.og_pitchmax)) {
    self.poi.auto.og_pitchmax = self.poi.auto.pitchmax;
  }

  self.poi.auto.yawmax = yawmax;
  self.poi.auto.yawmin = yawmin;
  self.poi.auto.pitchmin = pitchmin;
  self.poi.auto.pitchmax = pitchmax;
}

function private function_d60aa558() {
  assert(isDefined(self.poi.auto.og_yawmax));
  assert(isDefined(self.poi.auto.og_yawmin));
  assert(isDefined(self.poi.auto.og_pitchmin));
  assert(isDefined(self.poi.auto.og_pitchmax));
  self.poi.auto.yawmax = self.poi.auto.og_yawmax;
  self.poi.auto.yawmin = self.poi.auto.og_yawmin;
  self.poi.auto.pitchmin = self.poi.auto.og_pitchmin;
  self.poi.auto.pitchmax = self.poi.auto.og_pitchmax;
}

function private function_c30fad9a(parms) {
  level notify(#"hash_4821a87b2782d121");
  level.poi.debug = getdvarint(#"hash_1986594f14fcd987", 0);

  if(is_true(level.poi.debug)) {
    level thread debug();
  }
}

function private debug() {
  self notify(#"hash_4821a87b2782d121");
  self endon(#"hash_4821a87b2782d121");
  var_3b1af2ae = struct::get_array("<dev string:xb7>", "<dev string:xbe>");

  while(true) {
    if(isDefined(level.poi.var_5ee53e3)) {
      foreach(ai in level.poi.var_5ee53e3) {
        if(isDefined(ai.poi.currentpoi) && gettime() < (isDefined(ai.poi.currentpoi.var_3b03815e) ? ai.poi.currentpoi.var_3b03815e : gettime() + float(function_60d95f53()) / 1000)) {
          line(ai getEye(), ai.poi.currentpoi.origin, (0, 0, 1), 1, 0, 1);
          continue;
        }

        if(isDefined(ai.poi.nextpoi)) {
          line(ai getEye(), ai.poi.nextpoi.origin, (1, 0, 0), 1, 0, 1);
          continue;
        }

        if(isDefined(ai.poi.poi_firstpoint)) {
          line(ai getEye(), ai.poi.poi_firstpoint.origin, (1, 0, 0), 1, 0, 1);
        }
      }
    }

    foreach(poi in var_3b1af2ae) {
      function_9c52ce45(poi);
    }

    waitframe(1);
  }
}

function private function_4c4e4ab0() {
  while(true) {
    if(is_true(level.poi.debug) && isDefined(self.poi.auto.angles)) {
      localdir = anglesToForward(self.poi.auto.angles);
      worlddir = rotatepoint(localdir, angleclamp180(self.angles));
      line(self getEye(), self getEye() + worlddir * 50, (1, 0.5, 0), 1, 0, 1);
    }

    waitframe(1);
  }
}

function private function_9c52ce45(poi) {
  hs = 4;
  color = (0, 0, 1);
  text = "<dev string:xcd>";
  auto = 1;

  if(!is_true(poi.script_auto_use)) {
    hs = 2;
    color = (0.2, 0.2, 0.2);
    text = "<dev string:xb7>";
    auto = 0;
  }

  var_711c17c1 = float(isDefined(poi.var_715fc83d) ? poi.var_715fc83d : 0) * 1000;

  if(var_711c17c1 <= 0) {
    var_711c17c1 = 2000;
  }

  visible = 0;
  prev = undefined;
  next = undefined;

  if(isDefined(poi.target)) {
    next = struct::get(poi.target, "<dev string:xd4>");
  }

  if(isDefined(poi.targetname)) {
    prev = struct::get(poi.targetname, "<dev string:xe2>");
  }

  if(auto && isDefined(poi.var_3b03815e) && gettime() < poi.var_3b03815e + var_711c17c1) {
    print3d(poi.origin, "<dev string:xec>" + float(poi.var_3b03815e + var_711c17c1 - gettime()) / 1000, (0.2, 0.2, 0.2), 1, 0.25, 1);
  } else {
    line(poi.origin + (0, 0, hs), poi.origin + (0, 0, hs * -1), color, 1, 1, 1);
    line(poi.origin + (0, hs, 0), poi.origin + (0, hs * -1, 0), color, 1, 1, 1);
    line(poi.origin + (hs, 0, 0), poi.origin + (hs * -1, 0, 0), color, 1, 1, 1);
    time = "<dev string:xec>" + float(2000) / 1000;
    waittime = poi util::function_4b93f9c2();

    if(waittime > 0) {
      time = "<dev string:xec>";

      if(isDefined(poi.script_wait)) {
        time += float(poi.script_wait);
      }

      if(isDefined(poi.script_wait_min) || isDefined(poi.script_wait_min)) {
        if(time.size > 0) {
          time += "<dev string:xf0>";
        }

        time += isDefined(poi.script_wait_min) ? poi.script_wait_min : 0;

        if(isDefined(poi.script_wait_max) && float(poi.script_wait_max) > float(isDefined(poi.script_wait_min) ? poi.script_wait_min : 0)) {
          time = time + "<dev string:xf7>" + poi.script_wait_max;
        }
      }
    }

    if(auto) {
      time = time + "<dev string:xfe>" + (float(isDefined(poi.var_715fc83d) ? poi.var_715fc83d : 0) < 0 ? float(5000) / 1000 : float(poi.var_715fc83d));
    }

    print3d(poi.origin + (0, 0, 5), text, color, 1, 0.25, 1, 1);
    print3d(poi.origin + (0, 0, -10), time, color, 1, 0.25, 1, 1);
    visible = 1;
  }

  if(isDefined(next) && (gettime() < (isDefined(poi.var_3b03815e) ? poi.var_3b03815e : 0) || visible)) {
    line(poi.origin, next.origin, (0.5, 0.5, 0.5), 0.5, 1, 1);
    debug::drawarrow(vectorlerp(poi.origin, next.origin, 0.1), vectortoangles(next.origin - poi.origin), (0.5, 0.5, 0.5), 0, 10, 0);
  }
}