/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd_debug.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function function_ce893a25() {
  level thread function_926b63ee();
  level thread function_222f3594();
  dvar("<dev string:x38>", "<dev string:x4b>", &function_29bb1234);
  dvar("<dev string:x4f>", "<dev string:x65>", &function_53489ad);
  dvar("<dev string:x6a>", "<dev string:x65>", &function_3261cc72);
  dvar("<dev string:x81>", "<dev string:x65>", &function_1dddb5c2);
}

function private function_1c3e68dd(linenum) {
  var_d63a89fd = level._snd._debug.hud_y;
  var_1790a507 = function_827811b5();
  var_38c41a5e = var_1790a507[0];
  var_c13d121d = var_1790a507[1];

  if(var_d63a89fd < 0) {
    var_d63a89fd = var_c13d121d + var_d63a89fd;
  }

  posy = var_d63a89fd + 32 * linenum;
  return posy;
}

function private function_d34c1a24(xoffset, linenum, text, color) {
  var_7ab7d2f1 = level._snd._debug.hud_x;
  var_1790a507 = function_827811b5();
  var_38c41a5e = var_1790a507[0];
  var_c13d121d = var_1790a507[1];

  if(isDefined(color) == 0) {
    color = (1, 1, 1);
  }

  if(var_7ab7d2f1 < 0) {
    var_7ab7d2f1 = var_38c41a5e + var_7ab7d2f1;
  }

  function_65bb0ccd(text, var_7ab7d2f1 + xoffset, function_1c3e68dd(linenum), 1.33333, "<dev string:x98>", color, 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
}

function private function_43c85ce2() {
  origin = undefined;

  if(isDefined(self.origin) == 1) {
    origin = self.origin;
  }

  if(isDefined(self.v) == 1) {
    origin = self.v[# "origin"];
    self.origin = origin;
    self.var_3f03e75e = 1;
  }

  if(function_3132f113(self) == 1) {
    return undefined;
  }

  assert(isvec(origin) == 1);
  return origin;
}

function private function_cb457f5b() {
  angles = undefined;

  if(isDefined(self.angles) == 1) {
    angles = self.angles;
  }

  if(isDefined(self.v) == 1) {
    angles = self.v[# "angles"];
    self.angles = angles;
    self.var_45dbf7c9 = 1;
  }

  if(function_3132f113(self) == 1) {
    return undefined;
  }

  assert(isvec(angles) == 1);
  return angles;
}

function private function_738e0260() {
  soundalias = "<dev string:x9d>";

  if(isDefined(self.v) == 1 && isDefined(self.v[# "soundalias"]) == 1) {
    soundalias = self.v[# "soundalias"];
  } else if(isDefined(self.soundalias) == 1) {
    soundalias = self.soundalias;
  }

  return soundalias;
}

function private function_7814c6ed(player, playerview, playerangles, cosfov, maxdistance) {
  filterstring = level._snd._debug.filter;
  soundalias = self function_738e0260();
  origin = undefined;
  assert(isDefined(soundalias) == 1);
  var_688ce44d = function_c41f829d(soundalias);

  if(isDefined(var_688ce44d) && var_688ce44d == 0) {
    return -1;
  }

  if(isDefined(filterstring) == 1 && filterstring != "<dev string:x4b>") {
    if(issubstr(soundalias, filterstring) == 0) {
      return -1;
    }
  }

  origin = self function_43c85ce2();

  if(isDefined(origin) == 0) {
    return -1;
  }

  deltapos = origin - playerview;
  normal = vectornormalize(deltapos);
  playerforward = anglesToForward(playerangles);
  dot = vectordot(playerforward, normal);
  iswithinfov = dot >= cosfov;
  highlightdot = level._snd._debug.dot;

  if(isDefined(player.var_6d42228d) && player.var_6d42228d == self && isDefined(player.var_c84d8d23) && player.var_c84d8d23 != dot) {
    player.var_c84d8d23 = dot;
    player.var_6d42228d = undefined;
  }

  if(dot > highlightdot && (!isDefined(player.var_c84d8d23) || dot > player.var_c84d8d23)) {
    player.var_c84d8d23 = dot;
    player.var_6d42228d = self;
  }

  if(iswithinfov == 0) {
    return -1;
  }

  dist = distance(playerview, origin);

  if(dist < 1) {
    return -1;
  }

  if(maxdistance > 0 && maxdistance < dist) {
    return -1;
  }

  return dist;
}

function private function_a3b46281(var_22a4e6a0, array, player, playerview, playerangles, cosfov, maxdistance) {
  playerforward = anglesToForward(cosfov);
  playerfov = playerview getplayerfov();
  visible = [];
  assert(isarray(array));

  if(isarray(player) && player.size > 0) {
    visible = function_ada64c98(player, playerangles, playerforward, playerfov, maxdistance);
    array = arraycombine(array, visible, 0);
  }

  filterstring = level._snd._debug.filter;

  if(isDefined(filterstring) == 1 && filterstring != "<dev string:x4b>") {
    foreach(ent in array) {
      soundalias = ent function_738e0260();

      if(issubstr(soundalias, filterstring)) {
        arrayremovevalue(array, ent);
      }
    }
  }

  return array;
}

function private function_9386ad03(player, var_977d0bf3) {
  maxdistance = level._snd._debug.distance_max;
  maxdistance = maxdistance <= 0 ? 262144 : maxdistance;
  var_22a4e6a0 = [];
  assert(isDefined(player) == 1);
  assert(isDefined(var_977d0bf3) == 1);
  playerview = player getplayervieworigin();
  playerangles = player getplayerviewangles();
  fov = player getplayerfov();
  cosfov = cos(fov);

  if(isDefined(level.var_b7d2deb) == 1 && var_977d0bf3 >= 3) {
    var_22a4e6a0 = function_a3b46281(var_22a4e6a0, level.var_b7d2deb, player, playerview, playerangles, cosfov, maxdistance);
  }

  if(isDefined(level._snd) == 1 && isDefined(level._snd.var_3cc765a3) == 1) {
    var_22a4e6a0 = function_a3b46281(var_22a4e6a0, level._snd.var_3cc765a3, player, playerview, playerangles, cosfov, maxdistance);
  }

  return var_22a4e6a0;
}

function private function_bf58f58b() {
  origin = self function_43c85ce2();
  angles = self function_cb457f5b();
  soundalias = self function_738e0260();
  defaultradius = level._snd._debug.dist_radius;
  radius = defaultradius;
  minradiusunknown = 0;
  angle = undefined;

  if(isDefined(self.angles) == 1) {
    angles = self.angles;
  }

  if(soundalias != "<dev string:x9d>") {
    angle = function_9119c373(soundalias, "<dev string:xa8>");
    dist_min = function_7139f5ae(soundalias, "<dev string:xb9>");

    if(isDefined(dist_min) == 1 && dist_min > 0) {
      radius = dist_min;
    } else {
      minradiusunknown = 1;
    }
  }

  var_e3eb0c85 = 0;

  foreach(player in getplayerssafe()) {
    playerview = player getplayervieworigin();
    var_e3eb0c85 = function_c8caaab4(playerview, origin, radius);

    if(var_e3eb0c85 == 1) {
      radius = defaultradius;
      break;
    }
  }

  colorscale = level._snd._debug.color_scale;
  color = vectorscale((1, 1, 1), colorscale);
  line_alpha = 0.72974;

  if(isDefined(angle) && angle > 0) {
    half_radius = radius * 0.5;
    arrow_length = 2 + radius * 2 - half_radius;
    debugarrow(origin, angles, arrow_length, half_radius, (1, 1, 1), line_alpha);
  }

  debugcrosshair(origin, radius * 2, angles, (1, 1, 1), line_alpha);

  if(var_e3eb0c85 == 1 || minradiusunknown == 1) {
    cube(origin, angles, radius, color, line_alpha, 0, 1);
    return;
  }

  linesphere(origin, radius, color, line_alpha, 0, 1);
}

function private function_17547f34(player, var_22a4e6a0, var_977d0bf3) {
  if(isDefined(var_22a4e6a0.var_6d42228d)) {
    return var_22a4e6a0.var_6d42228d;
  }

  crosshairradius = level._snd._debug.var_4b824b64;
  fov = var_22a4e6a0 getplayerfov();
  playerview = var_22a4e6a0 getplayervieworigin();
  playerangles = var_22a4e6a0 getplayerviewangles();
  playerforward = anglesToForward(playerangles);
  highlightdot = level._snd._debug.dot;
  var_f45e7cd0 = 0;
  reticleent = undefined;
  visiblesndent = function_9ade037c(playerview, playerforward, var_977d0bf3);

  if(isDefined(visiblesndent)) {
    origin = visiblesndent function_43c85ce2();
    deltapos = origin - playerview;
    normal = vectornormalize(deltapos);
    dot = vectordot(playerforward, normal);

    if(dot > highlightdot && dot > var_f45e7cd0) {
      var_f45e7cd0 = dot;
      reticleent = visiblesndent;
    }
  }

  return reticleent;
}

function private function_b78b1ab1(player, var_977d0bf3) {
  audiocolor = level._snd._debug.color_3d;
  colorscale = level._snd._debug.color_scale;
  selectioncolor = function_2677a7e2(audiocolor, colorscale * 10);
  fov = var_977d0bf3 getplayerfov();
  origin = self function_43c85ce2();
  soundalias = self function_738e0260();
  radiusmin = "<dev string:xc4>";
  radiusmax = "<dev string:xc4>";
  assert(isDefined(var_977d0bf3) == 1);
  playerview = var_977d0bf3 getplayervieworigin();
  playerangles = var_977d0bf3 getplayerviewangles();
  playerright = anglestoright(playerangles);

  if(soundalias != "<dev string:x9d>") {
    dist_min = function_7139f5ae(soundalias, "<dev string:xb9>");
    dist_max = function_10120598(soundalias, "<dev string:xc9>");

    if(isDefined(dist_min) == 1 && dist_min > 0) {
      radiusmin = dist_min;
    }

    if(isDefined(dist_max) == 1 && dist_max > 0) {
      radiusmax = dist_max;
    }
  }

  if(isDefined(soundalias) == 1) {
    debugscale = level._snd._debug.scale_3d;
    dist = distance(origin, playerview);
    alpha = 1;
    alphasq = alpha * alpha;

    if(isnumber(radiusmin) == 1 && radiusmin > 0 && isnumber(radiusmax) == 1 && radiusmax > 0) {
      safetymax = 0;

      if(radiusmin == radiusmax) {
        safetymax = 0.001;
      }

      mapfloat(radiusmin, radiusmax + safetymax, 1, 0.5, dist);
    }

    var_7295dcac = dist * 0.00133333;
    print3dplus(soundalias, origin + (0, 0, -1.666 * var_7295dcac * debugscale * 24), -1.666 * debugscale, "<dev string:xd7>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    detail_text = "<dev string:x4b>";

    if(is_true(level._snd.var_2dd09170)) {
      detail_text = "<dev string:xe1>";
    }

    if(is_true(level._snd.var_8c37ff34)) {
      detail_text = "<dev string:xeb>";
    }

    detail_text += "<dev string:xf5>" + function_d6053a8f(radiusmin) + "<dev string:x100>" + function_d6053a8f(dist) + "<dev string:x100>" + function_d6053a8f(radiusmax);
    print3dplus(detail_text, origin + (0, 0, -2.666 * var_7295dcac * debugscale * 24), -1.333 * debugscale, "<dev string:xd7>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
  }

  if(isDefined(radiusmax) == 1 && isnumber(radiusmax) == 1 && radiusmax > 0) {
    color = vectorscale(selectioncolor, 1);
    line_alpha = 1;
    angles = self function_cb457f5b();
    debugcrosshair(origin, radiusmax * 2, angles, color, line_alpha);
    linesphere(origin, radiusmax, vectorscale(selectioncolor, 0.72974), line_alpha, 0, 1);
  }
}

function private function_c5ac5c05(var_977d0bf3) {
  if(var_977d0bf3 <= 1) {
    return;
  }

  players = getplayerssafe();

  if(!isarray(level.var_dbe59aee)) {
    level.var_dbe59aee = [];
  }

  foreach(player in players) {
    var_a9d76ab3 = [];
    var_a9d76ab3 = function_9386ad03(player, var_977d0bf3);
    level.var_dbe59aee = arraycombine(level.var_dbe59aee, var_a9d76ab3, 0);
  }

  drawlimit = level._snd._debug.draw_limit;
  var_82d451c6 = 0;

  if(level.var_dbe59aee.size >= drawlimit) {
    var_d8515b45 = [];

    foreach(player in players) {
      var_d8515b45[var_d8515b45.size] = player getplayervieworigin();
    }

    var_2ccfcb0e = vectoraverage(var_d8515b45);
    level.var_dbe59aee = arraysortclosest(level.var_dbe59aee, var_2ccfcb0e);

    foreach(ent in level.var_dbe59aee) {
      if(isDefined(ent.var_3f03e75e) == 1) {
        ent.origin = undefined;
        ent.var_3f03e75e = undefined;
      }
    }
  }

  foreach(visiblesndent in level.var_dbe59aee) {
    if(drawlimit > 0 && var_82d451c6 >= drawlimit) {
      function_d34c1a24(520, 2, "<dev string:x107>" + drawlimit + "<dev string:x10e>", (1, 0, 0));
      break;
    }

    visiblesndent function_bf58f58b();
    var_82d451c6 += 1;
  }

  var_a91b3615 = [];

  foreach(player in players) {
    var_e70b966c = function_17547f34(player, level.var_dbe59aee, var_977d0bf3);

    if(isDefined(var_a91b3615) == 1 && isDefined(var_e70b966c) == 1) {
      var_e70b966c function_b78b1ab1(player, var_977d0bf3);
      var_a91b3615[var_a91b3615.size] = var_e70b966c;
      var_82d451c6 += 1;
    }
  }
}

function private function_3d58f598(var_977d0bf3) {
  filterstring = level._snd._debug.filter;
  var_56ac818e = 0;
  var_da38b6bb = 0;
  sndentcount = 0;
  var_52e339ad = "<dev string:x4b>";
  var_89cff76c = "<dev string:x4b>";
  var_a91ca488 = 0;

  if(isDefined(level.var_b7d2deb) == 1) {
    assert(isDefined(level.var_c8afcee6) == 1);
    assert(isDefined(level.var_eb0e2b51) == 1);
    var_56ac818e = level.var_c8afcee6;
    var_da38b6bb = level.var_eb0e2b51;
  }

  if(isDefined(level._snd) == 1 && isDefined(level._snd.var_3cc765a3) == 1) {
    sndentcount = level._snd.var_3cc765a3.size;
  }

  if(isDefined(level.var_dbe59aee) == 1 && level.var_dbe59aee.size > 0 && var_977d0bf3 >= 3) {
    var_52e339ad += "<dev string:x11d>" + level.var_dbe59aee.size + "<dev string:x123>";
  }

  if(isDefined(filterstring) == 1 && filterstring != "<dev string:x4b>") {
    var_89cff76c += "<dev string:x130>" + filterstring + "<dev string:x130>";
  }

  if(isDefined(level.var_ba9b4ed) == 1) {
    var_a91ca488 = level.var_ba9b4ed.size;
  }

  row = -4;

  if(is_true(level._snd.var_2dd09170)) {
    mapname = tolower(getdvarstring(#"sv_mapname"));
    mapname = function_8cb4e540(mapname, 24);
    function_d34c1a24(0, row, mapname);
  }

  row = -3;

  if(is_true(level._snd.var_8c37ff34)) {
    skipto = function_bdd32fcc();

    if(skipto == "<dev string:x4b>") {
      skipto = "<dev string:x135>";
    }

    skipto = function_8cb4e540(skipto, 24);
    function_d34c1a24(0, row, skipto);
  }

  row = -2;

  if(is_true(level._snd.var_8c37ff34)) {
    player = getplayerssafe()[0];
    trigger = player.var_9a8a4923;
    trigger_name = function_ea2f17d1(trigger.script_ambientroom, "<dev string:x144>");
    trigger_name = function_8cb4e540(trigger_name, 24);
    function_d34c1a24(0, row, trigger_name);
  }

  row = 0;

  if(is_true(level._snd.var_2dd09170)) {
    function_d34c1a24(0, row, "<dev string:x150>" + sndentcount);
    return;
  }

  row++;

  if(is_true(level._snd.var_8c37ff34)) {
    function_d34c1a24(0, row, "<dev string:x16e>" + sndentcount);
  }

  row++;
  function_d34c1a24(0, row, "<dev string:x18c>" + var_a91ca488);
  row++;

  if(var_977d0bf3 >= 3) {
    function_d34c1a24(0, row, "<dev string:x1aa>" + var_56ac818e);
    row++;
    function_d34c1a24(0, row, "<dev string:x1c8>" + var_da38b6bb);
    row++;
    visiblestring = "<dev string:x4b>";

    if(isDefined(level.var_dbe59aee) == 1 && level.var_dbe59aee.size > 0) {
      visiblestring += level.var_dbe59aee.size;
    } else {
      visiblestring += "<dev string:x65>";
    }

    if(isDefined(filterstring) == 1 && filterstring != "<dev string:x4b>") {
      visiblestring += "<dev string:x11d>" + var_89cff76c + "<dev string:x1e6>";
    }

    function_d34c1a24(0, row, "<dev string:x1eb>" + visiblestring);
    row++;
  }
}

function private function_94f79425(var_977d0bf3) {
  if(isDefined(var_977d0bf3) == 1 && var_977d0bf3 < 1) {
    return;
  }

  if(getDvar(#"createfx", "<dev string:x4b>") != "<dev string:x209>") {
    if(isDefined(level.var_b7d2deb) == 1 && level.var_b7d2deb.size > 0) {
      return;
    }
  } else {
    while(isDefined(level.createfx) == 0) {
      waitframe(1);
    }
  }

  while(isDefined(level.createfxent) == 0) {
    waitframe(1);
  }

  level.var_b7d2deb = [];
  level.var_c8afcee6 = 0;
  level.var_eb0e2b51 = 0;

  foreach(ent in level.createfxent) {
    if(isDefined(ent.v[# "type"]) == 0) {
      continue;
    }

    if(ent.v[# "type"] == "<dev string:x20f>") {
      level.var_c8afcee6++;
      level.var_b7d2deb[level.var_b7d2deb.size] = ent;
    }

    if(ent.v[# "type"] == "<dev string:x21a>") {
      level.var_eb0e2b51++;
      level.var_b7d2deb[level.var_b7d2deb.size] = ent;
    }
  }
}

function private function_fcbbe789(key, value) {
  var_76519319 = ishash(key) || isstring(key);
  var_9cb80f5f = isDefined(value);

  if(function_81fac19d(!var_76519319, "<dev string:x22e>")) {
    return;
  }

  if(function_81fac19d(!var_9cb80f5f, "<dev string:x24b>")) {
    return;
  }

  switch (key) {
    default:
      break;
    case # "hash_7bf92664f192f2a2":
    case # "hash_7bf92664f192f2a2":
      level._snd._debug.debuglevel = int(value);
      break;
    case # "hash_7f77282fd4f2f35c":
    case # "hash_7f77282fd4f2f35c":
      level._snd._debug.filter = "<dev string:x4b>" + value;
      break;
    case # "hash_52bc4ee11d186c55":
    case # "hash_52bc4ee11d186c55":
      level._snd._debug.hud_x = int(value);
      break;
    case # "hash_52bc4de11d186aa2":
    case # "hash_52bc4de11d186aa2":
      level._snd._debug.hud_y = int(value);
      break;
    case # "hash_4b427a4d65f4f4b0":
    case # "hash_4b427a4d65f4f4b0":
      level._snd._debug.dist_radius = int(value);
      break;
    case # "hash_182296346d138cf8":
    case # "hash_182296346d138cf8":
      level._snd._debug.scale_3d = float(value);
      break;
    case # "hash_3b9f89c8082a9915":
    case # "hash_3b9f89c8082a9915":
      if(isstring(value)) {} else if(isvec(value)) {
        level._snd._debug.color_3d = value;
      }

      break;
    case # "hash_3944b771315157c1":
    case # "hash_3944b771315157c1":
      level._snd._debug.color_scale = float(value);
      break;
    case # "hash_28da12ba1bad355a":
    case # "hash_28da12ba1bad355a":
      level._snd._debug.var_2751db2e = int(value);
      break;
    case # "hash_7fb5d688966509c9":
    case # "hash_7fb5d688966509c9":
      level._snd._debug.distance_max = int(value);
      break;
    case # "hash_4a9b448151bd0fa9":
    case # "hash_4a9b448151bd0fa9":
      level._snd._debug.dot = float(value);
      break;
    case # "hash_579325eaa87b4d2f":
    case # "hash_579325eaa87b4d2f":
      level._snd._debug.draw_limit = int(value);
      break;
    case # "hash_35a6f662245752fa":
    case # "hash_35a6f662245752fa":
      level._snd._debug.xhair = int(value);
      break;
    case # "hash_5ba24ffba2d85322":
    case # "hash_5ba24ffba2d85322":
      level._snd._debug.var_4c5d0455 = float(value);
      break;
    case # "hash_3d649e7c9abdc358":
    case # "hash_3d649e7c9abdc358":
      level._snd._debug.var_4b824b64 = int(value);
      break;
  }
}

function private function_a3f5c17f(p) {
  var_cf07c027 = isstruct(p);
  var_76519319 = ishash(p.name) || isstring(p.name);
  var_9cb80f5f = isDefined(p.value);
  var_aa7a0fd6 = var_cf07c027 && var_76519319 && var_9cb80f5f;

  if(function_81fac19d(!var_aa7a0fd6, "<dev string:x26a>")) {
    if(function_f984063f()) {
      debugbreak();
    }

    return;
  }

  function_fcbbe789(p.name, p.value);
}

function private function_926b63ee() {
  hudx = -480;
  hudy = -272;

  if(ispc()) {
    hudx = -444;
    hudy = -248;
  }

  waitforplayers();
  level._snd._debug = spawnStruct();
  level._snd._debug.debuglevel = 0;
  level._snd._debug.filter = "<dev string:x4b>";
  level._snd._debug.hud_x = hudx;
  level._snd._debug.hud_y = hudy;
  level._snd._debug.dist_radius = 12;
  level._snd._debug.scale_3d = 0.666;
  level._snd._debug.color_3d = (0.5, 1, 0.666);
  level._snd._debug.color_scale = 0.72974;
  level._snd._debug.var_2751db2e = 5;
  level._snd._debug.distance_max = 0;
  level._snd._debug.dot = 0.99;
  level._snd._debug.draw_limit = 0;
  level._snd._debug.xhair = 0;
  level._snd._debug.var_4c5d0455 = 0.1;
  level._snd._debug.var_4b824b64 = 5;
  util::init_dvar("<dev string:x295>", level._snd._debug.debuglevel, &function_a3f5c17f);
  util::init_dvar("<dev string:x2a5>", level._snd._debug.filter, &function_a3f5c17f);
  util::init_dvar("<dev string:x2bb>", level._snd._debug.hud_x, &function_a3f5c17f);
  util::init_dvar("<dev string:x2cf>", level._snd._debug.hud_y, &function_a3f5c17f);
  util::init_dvar("<dev string:x2e3>", level._snd._debug.dist_radius, &function_a3f5c17f);
  util::init_dvar("<dev string:x2f9>", level._snd._debug.scale_3d, &function_a3f5c17f);
  util::init_dvar("<dev string:x30e>", level._snd._debug.color_3d, &function_a3f5c17f);
  util::init_dvar("<dev string:x323>", level._snd._debug.color_scale, &function_a3f5c17f);
  util::init_dvar("<dev string:x33d>", level._snd._debug.var_2751db2e, &function_a3f5c17f);
  util::init_dvar("<dev string:x356>", level._snd._debug.distance_max, &function_a3f5c17f);
  util::init_dvar("<dev string:x36e>", level._snd._debug.dot, &function_a3f5c17f);
  util::init_dvar("<dev string:x381>", level._snd._debug.draw_limit, &function_a3f5c17f);
  util::init_dvar("<dev string:x39a>", level._snd._debug.xhair, &function_a3f5c17f);
  util::init_dvar("<dev string:x3b3>", level._snd._debug.var_4c5d0455, &function_a3f5c17f);
  util::init_dvar("<dev string:x3d1>", level._snd._debug.var_4b824b64, &function_a3f5c17f);
}

function private function_222f3594() {
  level notify(#"hash_1b2711bf69eca1e2");
  level endon(#"hash_1b2711bf69eca1e2");
  waitforplayers();

  while(true) {
    var_977d0bf3 = function_95c9af4b();

    if(var_977d0bf3 > 0) {
      function_c5ac5c05(var_977d0bf3);
      function_3d58f598(var_977d0bf3);
    }

    waitframe(1);
  }
}

function private function_29bb1234(key, value) {
  if(value != "<dev string:x4b>" && isstring(value) == 1) {
    function_81fac19d(1, "<dev string:x3f0>" + value + "<dev string:x403>");
    level notify(value);
  }

  return "<dev string:x4b>";
}

function private function_fa2bfbd1() {
  player = self;
  player endon(#"death");
  player endon(#"hash_1c8039ff7519235");

  while(!function_3132f113(player)) {
    var_5e193409 = function_827811b5();
    var_9e35ce44 = var_5e193409[0] * 0.5;
    var_749dfb19 = var_5e193409[1] * 0.5;
    eyeorigin = player getplayervieworigin();
    eyeangles = player getplayerviewangles();
    eyeforward = anglesToForward(eyeangles);
    eyeright = anglestoright(eyeangles);
    traceend = eyeorigin + eyeforward * 262144;
    trace = bulletTrace(eyeorigin, traceend, 1, player);

    if(isDefined(trace) == 1 && isDefined(trace[# "position"]) == 1 && trace[# "position"] != eyeorigin) {
      pos = trace[# "position"];
      surfacetype = trace[# "surfacetype"];
      dist = distance(pos, eyeorigin);
      fontscale = 1.5;
      posstring = "<dev string:x40a>" + pos[0] + "<dev string:x410>" + pos[1] + "<dev string:x410>" + pos[2] + "<dev string:x416>";
      hoffset = 1 * fontscale * 24;
      function_65bb0ccd(posstring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xd7>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      diststring = "<dev string:x4b>" + dist;
      hoffset = 2 * fontscale * 24;
      function_65bb0ccd(diststring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xd7>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);

      if(isDefined(surfacetype) == 1) {
        surfstring = "<dev string:x4b>" + surfacetype + "<dev string:x4b>";
        hoffset = 3 * fontscale * 24;
        function_65bb0ccd(surfstring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xd7>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      }

      debugcrosshair(pos, 4, (0, 0, 0), (1, 1, 1), 1, 1);
    }

    waitframe(1);
  }
}

function private function_53489ad(key, value) {
  if(is_true(level._snd.var_8c37ff34)) {
    intvalue = int(value);
    waitforplayers();
    players = getplayerssafe();

    foreach(player in players) {
      if(intvalue > 0) {
        player thread function_fa2bfbd1();
        continue;
      }

      player notify(#"hash_1c8039ff7519235");
    }
  }

  return value;
}

function private function_27e49109(distance) {
  player = self;
  player notify(#"hash_4d6bc2c72c2fe097");
  player endon(#"hash_4d6bc2c72c2fe097");
  player endon(#"death");

  if(!isDefined(distance)) {
    distance = 2400;
  }

  while(!function_3132f113(player)) {
    scale = -1 * level._snd._debug.scale_3d;
    zinc = 6 * level._snd._debug.scale_3d;
    playervieworg = player getplayervieworigin();
    playerangles = player getplayerviewangles();
    playerforward = anglesToForward(playerangles);
    playerfov = player getplayerfov();
    ents = [];

    if(is_true(level._snd.var_8c37ff34)) {
      ents = getentitiesinradius(0, playervieworg, distance);
    } else {
      ents = getentitiesinradius(playervieworg, distance, undefined);
    }

    visibleents = function_ada64c98(ents, playervieworg, playerforward, playerfov, distance);

    foreach(ent in visibleents) {
      row = 0;

      if(is_true(level._snd.var_2dd09170)) {
        if(isstring(ent.classname)) {
          yy = (0, 0, zinc * row);
          print3dplus("<dev string:x41c>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.classname, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.targetname)) {
          row++;
          yy = (0, 0, zinc * row);
          print3dplus("<dev string:x442>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.targetname, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.script_noteworthy)) {
          row++;
          yy = (0, 0, zinc * row);
          print3dplus("<dev string:x455>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.script_noteworthy, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }
      }

      row = 3;

      if(is_true(level._snd.var_8c37ff34)) {
        if(isstring(ent.classname)) {
          print3dplus("<dev string:x46f>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.classname, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.targetname)) {
          row++;
          yy = (0, 0, zinc * row);
          print3dplus("<dev string:x481>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.targetname, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.script_noteworthy)) {
          row++;
          yy = (0, 0, zinc * row);
          print3dplus("<dev string:x494>", ent.origin + yy, scale, "<dev string:x42e>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          print3dplus("<dev string:x4b>" + function_ea2f17d1(ent.script_noteworthy, "<dev string:x433>"), ent.origin + yy, scale, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }
      }

      if(is_true(level._snd.var_2dd09170)) {
        debugcrosshair(ent.origin, 12, ent.angles, (1, 1, 1), 1, 0);
      }

      if(is_true(level._snd.var_8c37ff34)) {
        debugarrow(ent.origin, ent.angles, 12, 4, (1, 0, 0), 1, 0);
      }
    }

    waitframe(1);
  }
}

function private function_3261cc72(key, value) {
  waitforplayers();
  players = getplayerssafe();
  intvalue = int(value);

  foreach(player in players) {
    if(intvalue > 0) {
      player thread function_27e49109(intvalue);
      continue;
    }

    player notify(#"hash_4d6bc2c72c2fe097");
  }

  return value;
}

function private function_40f589b7() {
  level notify(#"hash_2036f819b394154");
  level endon(#"hash_2036f819b394154");

  while(true) {
    var_1790a507 = function_827811b5();
    var_38c41a5e = var_1790a507[0];
    var_c13d121d = var_1790a507[1];
    pos = (var_38c41a5e * 0.5, var_c13d121d * 0.5, 0);
    txt = "<dev string:x4ae>";
    skipto = function_bdd32fcc();

    if(is_true(level._snd.var_8c37ff34)) {
      txt = "<dev string:x4b4>";
      pos = (var_38c41a5e * 0.5, 32 + var_c13d121d * 0.5, 0);
    }

    txt += "<dev string:x4ba>";
    txt += "<dev string:x4c7>";

    if(isDefined(skipto)) {
      txt += skipto;
    }

    txt += "<dev string:x4c7>";
    function_65bb0ccd(txt, pos[0], pos[1], 1.33333, "<dev string:x98>", (1, 1, 1), 1, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974, 1);
    waitframe(1);
  }
}

function private function_1dddb5c2(key, value) {
  intvalue = int(value);

  if(intvalue > 0) {
    level thread function_40f589b7();
  } else {
    level notify(#"hash_2036f819b394154");
  }

  return value;
}