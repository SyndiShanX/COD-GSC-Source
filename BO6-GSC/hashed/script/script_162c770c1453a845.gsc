/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_162c770c1453a845.gsc
*****************************************************/

#using script_19163c4e4e504a5e;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\createfx;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace snd_debug;

function function_59d450dbd3c62236() {
  assert(isstruct(level.snd), "<dev string:x24>");
  level thread function_4eeb13709e87e34d();
  snd::dvar(@ "scr_levelnotify", "<dev string:x40>", &function_8ed5895a233409b3);
  snd::dvar(@ "hash_52b4c8d3c40cfc34", "<dev string:x40>", &function_25d13be248a81e55);
  snd::dvar(@ "hash_e5b570e920b9c1fd", "<dev string:x40>", &function_100e543ee93559a0);
  snd::dvar(@ "hash_6db29b2f497ade76", "<dev string:x40>", &function_100e543ee93559a0);
  snd::dvar(@ "hash_2fa2b5d1e7614a6a", "<dev string:x40>", &function_1255c3d916d0739b);
  snd::dvar(@ "hash_571a72fc6a9a2647", "<dev string:x40>", &function_308c070c9c9646ce);
  snd::dvar(@ "hash_fcb782f301399045", "<dev string:x44>", &function_74685f17be057840);
  snd::dvar(@ "hash_71610eca5056387", "<dev string:x44>", &function_b04d1f49f3449bd6);
  snd::dvar(@ "hash_46eb4af73fff2413", "<dev string:x40>", &function_fe44570d4f32f592);
  snd::dvar(@ "hash_ba43c6fa400869e0", "<dev string:x40>", &function_5eac22426f6bfe65);
  snd::dvar(@ "hash_843400373f683963", "<dev string:x44>", &function_f4254d7ded05589e);
}

function private function_1a1dac7fe2789347(linenum) {
  var_ece1d4425ecfb47 = level.snd.debug.hud_y;
  vidresolution = snd::function_e8dca3401a4ad001();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];

  if(var_ece1d4425ecfb47 < 0) {
    var_ece1d4425ecfb47 = vidheight + var_ece1d4425ecfb47;
  }

  posy = var_ece1d4425ecfb47 + 21.3333 * linenum;
  return posy;
}

function private function_ab25c95a68f3b0b6(xoffset, linenum, text, color) {
  var_e6f4689c1b2153b8 = level.snd.debug.hud_x;
  vidresolution = snd::function_e8dca3401a4ad001();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];

  if(isDefined(color) == 0) {
    color = (1, 1, 1);
  }

  if(var_e6f4689c1b2153b8 < 0) {
    var_e6f4689c1b2153b8 = vidwidth + var_e6f4689c1b2153b8;
  }

  snd::function_f2aaa10b4546fafb(text, var_e6f4689c1b2153b8 + xoffset, function_1a1dac7fe2789347(linenum), 1.33333, "<dev string:x49>", color, 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
}

function private function_4fc83e63d68ef378() {
  origin = undefined;

  if(isDefined(self.origin)) {
    origin = self.origin;
  }

  if(isDefined(self.v)) {
    origin = self.v["<dev string:x4e>"];
    self.origin = origin;
    self.var_ca40ae239a8e23ba = 1;
  }

  if(snd::function_cd79b44ba8163808(self)) {
    return undefined;
  }

  assert(isvector(origin));
  return origin;
}

function private function_fb51142a63c0096() {
  angles = undefined;

  if(isDefined(self.angles)) {
    angles = self.angles;
  }

  if(isDefined(self.v)) {
    angles = self.v["<dev string:x58>"];
    self.angles = angles;
    self.var_18ef4a9ee754fa18 = 1;
  }

  if(snd::function_cd79b44ba8163808(self)) {
    return undefined;
  }

  assert(isvector(angles));
  return angles;
}

function private function_e555236bae9336cb() {
  soundalias = "<dev string:x62>";

  if(isDefined(self.v) && isDefined(self.v["<dev string:x6d>"])) {
    soundalias = self.v["<dev string:x6d>"];
  } else if(isDefined(self.soundalias)) {
    soundalias = self.soundalias;
  }

  return soundalias;
}

function private function_895c3e32a5160ddd(player, playerview, playerangles, cosfov, maxdistance) {
  filterstring = level.snd.debug.filter;
  soundalias = function_e555236bae9336cb();
  origin = undefined;
  assert(isDefined(soundalias));
  isalias3d = 1;

  if(isDefined(isalias3d) && isalias3d == 0) {
    return -1;
  }

  if(isDefined(filterstring) && filterstring != "<dev string:x40>") {
    if(issubstr(soundalias, filterstring) == 0) {
      return -1;
    }
  }

  origin = function_4fc83e63d68ef378();

  if(isDefined(origin) == 0) {
    return -1;
  }

  deltapos = origin - playerview;
  normal = vectorNormalize(deltapos);
  playerforward = anglesToForward(playerangles);
  dot = vectordot(playerforward, normal);
  iswithinfov = dot >= cosfov;
  highlightdot = level.snd.debug.dot;

  if(isDefined(player.snd.var_d12e4af197c3b253) && player.snd.var_d12e4af197c3b253 == self && isDefined(player.snd.debugcenterdot) && player.snd.debugcenterdot != dot) {
    player.snd.debugcenterdot = dot;
    player.snd.var_d12e4af197c3b253 = undefined;
  }

  if(dot > highlightdot && (!isDefined(player.snd.debugcenterdot) || dot > player.snd.debugcenterdot)) {
    player.snd.debugcenterdot = dot;
    player.snd.var_d12e4af197c3b253 = self;
  }

  if(iswithinfov == 0) {
    return -1;
  }

  dist_squared = distancesquared(playerview, origin);

  if(dist_squared < 2) {
    return -1;
  }

  maxdistancesquared = squared(maxdistance);

  if(maxdistancesquared > 0 && maxdistancesquared < dist_squared) {
    return -1;
  }

  return dist_squared;
}

function function_3ce6577a5a0d5275(array, var_c26cf92f8ef868b9) {
  newarray = [];

  foreach(item in array) {
    if(snd::function_cd79b44ba8163808(item)) {
      continue;
    }

    if(istrue(var_c26cf92f8ef868b9)) {
      newarray[i] = item;
      continue;
    }

    newarray[newarray.size] = item;
  }

  return newarray;
}

function private function_f2e72268371a2d9d(visiblesndents, array, player, playerview, playerangles, cosfov, maxdistance) {
  playerforward = anglesToForward(playerangles);
  playerfov = player snd::getplayerfov();
  visible = [];
  array = function_3ce6577a5a0d5275(array);
  assert(isarray(visiblesndents));

  if(isarray(array) && array.size > 0) {
    visible = snd::function_bee53ee78849b6ea(array, playerview, playerforward, playerfov, maxdistance);
    visiblesndents = utility::array_combine(visiblesndents, visible);
  }

  filterstring = level.snd.debug.filter;

  if(isDefined(filterstring) && filterstring != "<dev string:x40>") {
    foreach(ent in visiblesndents) {
      soundalias = ent function_e555236bae9336cb();

      if(issubstr(soundalias, filterstring)) {
        visiblesndents = arrayremove(visiblesndents, ent);
      }
    }
  }

  return visiblesndents;
}

function private function_6aa9d7f46a45f335(player, scr_snddebug) {
  maxdistance = level.snd.debug.distance_max;
  maxdistance = maxdistance <= 0 ? 262144 : maxdistance;
  visiblesndents = [];
  assert(isDefined(player));
  assert(isDefined(scr_snddebug));
  playerview = player snd::getplayervieworigin();
  playerangles = player snd::getplayerviewangles();
  fov = player snd::getplayerfov();
  cosfov = cos(fov);

  if(isDefined(level.snd.createfxent) && scr_snddebug >= 3) {
    visiblesndents = function_f2e72268371a2d9d(visiblesndents, level.snd.createfxent, player, playerview, playerangles, cosfov, maxdistance);
  }

  if(isDefined(level.snd) && isDefined(level.snd.objects)) {
    visiblesndents = function_f2e72268371a2d9d(visiblesndents, level.snd.objects, player, playerview, playerangles, cosfov, maxdistance);
  }

  return visiblesndents;
}

function private function_5acc1592e1cdb1c3() {
  origin = function_4fc83e63d68ef378();
  angles = function_fb51142a63c0096();
  soundalias = function_e555236bae9336cb();
  defaultradius = level.snd.debug.dist_radius;
  radius = defaultradius;
  minradiusunknown = 0;
  angle = undefined;

  if(isDefined(self.angles)) {
    angles = self.angles;
  }

  if(soundalias != "<dev string:x62>") {
    angle = snd::function_833c469c43335bb0(soundalias, "<dev string:x7b>");
    dist_min = snd::function_9e4e272272a7638(soundalias, "<dev string:x8c>");

    if(isDefined(dist_min) && dist_min > 0) {
      radius = dist_min;
    } else {
      minradiusunknown = 1;
    }
  }

  var_d0c7b6d04e5f3b5a = 0;

  foreach(player in snd::getplayerssafe()) {
    playerview = player snd::getplayervieworigin();
    var_d0c7b6d04e5f3b5a = snd::function_7ad5b243f66e32ba(playerview, origin, radius);

    if(var_d0c7b6d04e5f3b5a == 1) {
      radius = defaultradius;
      break;
    }
  }

  colorscale = level.snd.debug.color_scale;
  color = snd::vectorscale((1, 1, 1), colorscale);
  line_alpha = 0.72974;

  if(isDefined(angle) && angle > 0) {
    half_radius = radius * 0.5;
    arrow_length = 2 + radius * 2 - half_radius;
    snd::debugarrow(origin, angles, arrow_length, half_radius, (1, 1, 1), line_alpha);
  }

  snd::debugcrosshair(origin, radius * 2, angles, (1, 1, 1), line_alpha);

  if(var_d0c7b6d04e5f3b5a == 1 || minradiusunknown == 1) {
    snd::cube(origin, angles, radius, color, line_alpha, 0, 1);
    return;
  }

  sphere(origin, radius, color, 0, 1);
}

function private function_b86e81cd07357ae3(player, visiblesndents, scr_snddebug) {
  if(isDefined(player.snd) && isDefined(player.snd.var_d12e4af197c3b253)) {
    return player.snd.var_d12e4af197c3b253;
  }

  crosshairradius = level.snd.debug.xhair_radius;
  fov = player snd::getplayerfov();
  playerview = player snd::getplayervieworigin();
  playerangles = player snd::getplayerviewangles();
  playerforward = anglesToForward(playerangles);
  highlightdot = level.snd.debug.dot;
  reticleentdot = 0;
  reticleent = undefined;
  visiblesndent = snd::function_2728c886eadd57bf(playerview, playerforward, visiblesndents);

  if(isDefined(visiblesndent)) {
    origin = visiblesndent function_4fc83e63d68ef378();
    deltapos = origin - playerview;
    normal = vectorNormalize(deltapos);
    dot = vectordot(playerforward, normal);

    if(dot > highlightdot && dot > reticleentdot) {
      reticleentdot = dot;
      reticleent = visiblesndent;
    }
  }

  return reticleent;
}

function private function_9eb18e61fc410fd9(player, scr_snddebug) {
  audiocolor = level.snd.debug.color_3d;
  colorscale = level.snd.debug.color_scale;
  selectioncolor = snd::function_91e4e5dcd3f773b0(audiocolor, colorscale * 10);
  fov = player snd::getplayerfov();
  origin = function_4fc83e63d68ef378();
  soundalias = function_e555236bae9336cb();
  radiusmin = "<dev string:x98>";
  radiusmax = "<dev string:x98>";
  assert(isDefined(player));
  playerview = player snd::getplayervieworigin();
  playerangles = player snd::getplayerviewangles();
  playerright = anglestoright(playerangles);

  if(soundalias != "<dev string:x62>") {
    dist_min = snd::function_9e4e272272a7638(soundalias, "<dev string:x8c>");
    dist_max = snd::function_280d10d0b8ab8d66(soundalias, "<dev string:x9d>");

    if(isDefined(dist_min) && dist_min > 0) {
      radiusmin = dist_min;
    }

    if(isDefined(dist_max) && dist_max > 0) {
      radiusmax = dist_max;
    }
  }

  if(isDefined(soundalias)) {
    debugscale = level.snd.debug.scale_3d;
    dist = distance(origin, playerview);
    alpha = 1;
    alphasq = alpha * alpha;

    if(isnumber(radiusmin) && radiusmin > 0 && isnumber(radiusmax) && radiusmax > 0) {
      safetymax = 0;

      if(radiusmin == radiusmax) {
        safetymax = 0.001;
      }

      mapfloat(radiusmin, radiusmax + safetymax, 1, 0.5, dist);
    }

    fixeddistscalar = dist * 0.00133333;
    snd::print3dplus(soundalias, origin + (0, 0, -1.666 * fixeddistscalar * debugscale * 16), -1.666 * debugscale, "<dev string:xa9>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    detail_text = "<dev string:x40>";

    if(istrue(level.snd.var_aa82b3c5f09326cc)) {
      detail_text = "<dev string:xb3>";
    }

    if(istrue(level.snd.var_47d98b44f58f4910)) {
      detail_text = "<dev string:xbd>";
    }

    detail_text += "<dev string:xc7>" + snd::printdecimalcount(radiusmin) + "<dev string:xd2>" + snd::printdecimalcount(dist) + "<dev string:xd2>" + snd::printdecimalcount(radiusmax);
    snd::print3dplus(detail_text, origin + (0, 0, -2.666 * fixeddistscalar * debugscale * 16), -1.333 * debugscale, "<dev string:xa9>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
  }

  if(isDefined(radiusmax) && isnumber(radiusmax) && radiusmax > 0) {
    color = snd::vectorscale(selectioncolor, 1);
    line_alpha = 1;
    angles = function_fb51142a63c0096();
    snd::debugcrosshair(origin, radiusmax * 2, angles, color, line_alpha);
    snd::linesphere(origin, radiusmax, snd::vectorscale(selectioncolor, 0.72974), line_alpha, 0, 1);
  }
}

function private function_eda0e3c9de2372a9(scr_snddebug) {
  if(scr_snddebug <= 1) {
    return;
  }

  players = snd::getplayerssafe();
  level.snd.debug.visiblesndobjs = [];

  foreach(player in players) {
    var_e0c443370918bc6 = [];
    var_e0c443370918bc6 = function_6aa9d7f46a45f335(player, scr_snddebug);
    level.snd.debug.visiblesndobjs = utility::array_combine_unique(level.snd.debug.visiblesndobjs, var_e0c443370918bc6);
  }

  drawlimit = level.snd.debug.draw_limit;
  var_128e325a1e4b5774 = 0;

  if(drawlimit > 0 && level.snd.debug.visiblesndobjs.size >= drawlimit) {
    allplayersviews = [];

    foreach(player in players) {
      allplayersviews[allplayersviews.size] = player snd::getplayervieworigin();
    }

    var_e3f508d6b705d2d8 = snd::vectoraverage(allplayersviews);
    level.snd.debug.visiblesndobjs = sortbydistance(level.snd.debug.visiblesndobjs, var_e3f508d6b705d2d8);

    if(!isarray(level.snd.debug.visiblesndobjs)) {
      level.snd.debug.visiblesndobjs = [];
    }

    foreach(ent in level.snd.debug.visiblesndobjs) {
      if(isDefined(ent.var_ca40ae239a8e23ba)) {
        ent.origin = undefined;
        ent.var_ca40ae239a8e23ba = undefined;
      }
    }
  }

  level.snd.debug.visiblesndobjs = function_3ce6577a5a0d5275(level.snd.debug.visiblesndobjs);

  foreach(visiblesndent in level.snd.debug.visiblesndobjs) {
    if(drawlimit > 0 && var_128e325a1e4b5774 >= drawlimit) {
      function_ab25c95a68f3b0b6(520, 2, "<dev string:xd9>" + drawlimit + "<dev string:xe0>", (1, 0, 0));
      break;
    }

    visiblesndent function_5acc1592e1cdb1c3();
    var_128e325a1e4b5774 += 1;
  }

  var_4ea2d923afc6fec0 = [];

  foreach(player in players) {
    var_dc030a329fc2080d = function_b86e81cd07357ae3(player, level.snd.debug.visiblesndobjs, scr_snddebug);

    if(isDefined(var_4ea2d923afc6fec0) && isDefined(var_dc030a329fc2080d)) {
      var_dc030a329fc2080d function_9eb18e61fc410fd9(player, scr_snddebug);
      var_4ea2d923afc6fec0[var_4ea2d923afc6fec0.size] = var_dc030a329fc2080d;
      var_128e325a1e4b5774 += 1;
    }
  }
}

function private function_11b2ec4ff06a449b(scr_snddebug) {
  filterstring = level.snd.debug.filter;
  var_1d60d90cede11cca = 0;
  var_398c1e8b79144103 = 0;
  sndentcount = 0;
  sndentvisiblestring = "<dev string:x40>";
  sndentfilterstring = "<dev string:x40>";
  sndparamcount = 0;

  if(isDefined(level.snd.createfxent)) {
    assert(isDefined(level.snd.createfxloopcount));
    assert(isDefined(level.snd.var_2728ecf947b6f0d4));
    var_1d60d90cede11cca = level.snd.createfxloopcount;
    var_398c1e8b79144103 = level.snd.var_2728ecf947b6f0d4;
  }

  if(isDefined(level.snd) && isDefined(level.snd.objects)) {
    sndentcount = level.snd.objects.size;
  }

  if(isDefined(level.snd.debug.visiblesndobjs) && level.snd.debug.visiblesndobjs.size > 0 && scr_snddebug >= 3) {
    sndentvisiblestring += "<dev string:xef>" + level.snd.debug.visiblesndobjs.size + "<dev string:xf5>";
  }

  if(isDefined(filterstring) && filterstring != "<dev string:x40>") {
    sndentfilterstring += "<dev string:x102>" + filterstring + "<dev string:x102>";
  }

  if(isDefined(level.snd.param_ents)) {
    sndparamcount = level.snd.param_ents.size;
  }

  row = -3;

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    mapname = tolower(level.script);
    mapname = snd::function_d9d59b56f5fd76de(mapname, 24);
    function_ab25c95a68f3b0b6(0, row, mapname);
  }

  row = -2;

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    start = snd::function_d6cdcc1bd5241be5();

    if(!isstring(start) || start == "<dev string:x40>") {
      start = "<dev string:x107>";
    }

    start = snd::function_d9d59b56f5fd76de(start, 24);
    function_ab25c95a68f3b0b6(0, row, start);
  }

  row = -1;

  if(istrue(level.snd.var_47d98b44f58f4910)) {
    player = snd::getplayerssafe()[0];
    trigger = player.snd.trigger;
    trigger_name = trigger.script_ambientroom ?? "<dev string:x115>";
    trigger_name = snd::function_d9d59b56f5fd76de(trigger_name, 24);
    function_ab25c95a68f3b0b6(0, row, trigger_name);
  }

  row = 0;

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    function_ab25c95a68f3b0b6(0, row, "<dev string:x121>" + sndentcount);
  }

  row++;

  if(istrue(level.snd.var_47d98b44f58f4910)) {
    function_ab25c95a68f3b0b6(0, row, "<dev string:x13f>" + sndentcount);
    row++;
  }

  function_ab25c95a68f3b0b6(0, row, "<dev string:x15d>" + sndparamcount);
  row++;

  if(scr_snddebug >= 3) {
    visiblestring = "<dev string:x40>";

    if(isDefined(level.snd.debug.visiblesndobjs) && level.snd.debug.visiblesndobjs.size > 0) {
      visiblestring += level.snd.debug.visiblesndobjs.size;
    } else {
      visiblestring += "<dev string:x44>";
    }

    if(isDefined(filterstring) && filterstring != "<dev string:x40>") {
      visiblestring += "<dev string:xef>" + sndentfilterstring + "<dev string:x17b>";
    }

    function_ab25c95a68f3b0b6(0, row, "<dev string:x180>" + visiblestring);
    row++;
  }
}

function private function_b5ca82097666d544(scr_snddebug) {
  aspect = 0.75;
  crosshair = level.snd.debug.xhair;
  crosshairalpha = level.snd.debug.xhair_alpha;
  crosshairradius = level.snd.debug.xhair_radius;

  if(crosshair != 0 && isDefined(level.snd.debug.xhair_hudelem) == 0) {
    hud = newhudelem();
    hud.x = 320;
    hud.y = 240;
    hud.alignx = "<dev string:xa9>";
    hud.aligny = "<dev string:x19e>";
    hud.horzalign = "<dev string:x1a8>";
    hud.vertalign = "<dev string:x1a8>";
    hud.foreground = 1;
    hud.sort = 1;
    level.snd.debug.xhair_hudelem = hud;
  }

  if(crosshair != 0 && isDefined(level.snd.debug.xhair_hudelem) && "<dev string:x1b6>" != "<dev string:x40>") {
    level.snd.debug.xhair_hudelem setshader("<dev string:x1b6>", int(crosshairradius * 2 * aspect), int(crosshairradius * 2));
    level.snd.debug.xhair_hudelem.alpha = crosshairalpha;
  }

  if(crosshair == 0 && isDefined(level.snd.debug.xhair_hudelem)) {
    level.snd.debug.xhair_hudelem destroy();
    level.snd.debug.xhair_hudelem = undefined;
  }
}

function private function_de98243af45d80c9(scr_snddebug) {
  if(isDefined(scr_snddebug) && scr_snddebug < 1) {
    return;
  }

  if(getDvar(@ "createfx") != "<dev string:x1bf>") {
    if(isDefined(level.snd.createfxent) && level.snd.createfxent.size > 0) {
      return;
    }
  } else {
    while(isDefined(level.createfx) == 0) {
      waitframe();
    }
  }

  while(isDefined(level.createfxent) == 0) {
    waitframe();
  }

  level.snd.createfxent = [];
  level.snd.createfxloopcount = 0;
  level.snd.var_2728ecf947b6f0d4 = 0;

  foreach(ent in level.createfxent) {
    if(isDefined(ent.v["<dev string:x1c5>"]) == 0) {
      continue;
    }

    if(ent.v["<dev string:x1c5>"] == "<dev string:x1cd>") {
      level.snd.createfxloopcount++;
      level.snd.createfxent[level.snd.createfxent.size] = ent;
    }

    if(ent.v["<dev string:x1c5>"] == "<dev string:x1d8>") {
      level.snd.var_2728ecf947b6f0d4++;
      level.snd.createfxent[level.snd.createfxent.size] = ent;
    }
  }
}

function private function_e6639f41160b3424(key, value) {
  var_522a44f01ff51a30 = isstring(key) || isDefined(key);
  var_93f3a3ad78ec497d = isDefined(value);

  if(snd::condition_alert(!var_522a44f01ff51a30, "<dev string:x1ec>")) {
    return;
  }

  if(snd::condition_alert(!var_93f3a3ad78ec497d, "<dev string:x209>")) {
    return;
  }

  if(key == @ "scr_snddebug") {
    level.snd.debug.debuglevel = int(value);

    if(level.snd.debug.debuglevel == 0) {
      level notify("<dev string:x228>");
    } else {
      level thread function_51cf1f1a33e2d4fe();
    }
  } else if(key == @ "hash_9c1eb53708e52e2f") {
    level.snd.debug.filter = "<dev string:x40>" + value;
  } else if(key == @ "hash_8f80f3ca72788192") {
    level.snd.debug.hud_x = int(value);
  } else if(key == @ "hash_8f80f4ca727883c5") {
    level.snd.debug.hud_y = int(value);
  } else if(key == @ "hash_bca67414aef4061b") {
    level.snd.debug.dist_radius = int(value);
  } else if(key == @ "hash_90c83c3028a58709") {
    level.snd.debug.scale_3d = float(value);
  } else if(key == @ "hash_f21deb173dd93370") {
    if(isstring(value)) {} else if(isvector(value)) {
      level.snd.debug.color_3d = value;
    }
  } else if(key == @ "hash_2a753b30a1212892") {
    level.snd.debug.color_scale = float(value);
  } else if(key == @ "hash_fb5f3970d2e3bfdb") {
    level.snd.debug.var_480f87461a368bd1 = int(value);
  } else if(key == @ "hash_52ac4c0cc02bb1fa") {
    level.snd.debug.distance_max = int(value);
  } else if(key == @ "hash_53a06c9d638ec478") {
    level.snd.debug.dot = float(value);
  } else if(key == @ "hash_33175192ed572d96") {
    level.snd.debug.draw_limit = int(value);
  } else if(key == @ "hash_7cb2165a98d551b") {
    level.snd.debug.xhair = int(value);
  } else if(key == @ "hash_abd89601b7f5878d") {
    level.snd.debug.xhair_alpha = float(value);
  } else if(key == @ "hash_e307089961790a19") {
    level.snd.debug.xhair_radius = int(value);
  }

  return value;
}

function private function_8303fed4cd3f077e() {
  if(isDefined(level.snd) && isDefined(level.snd.debug) && istrue(level.snd.debug.initialized)) {
    return 1;
  }

  return 0;
}

function private function_a1694c2fd1775417() {
  while(function_8303fed4cd3f077e() == 0) {
    waitframe();
  }
}

function private function_8fa2ae5d06de8cb3(text) {
  snd::waitforplayers();
  waitframe();
  waittillframeend();
  adddebugcommand(text + "<dev string:x239>");
}

function private function_22219de62996cbeb(menu, submenu, item, text) {
  devgui_txt = "<dev string:x23f>" + menu + "<dev string:x250>" + submenu + "<dev string:x250>" + item + "<dev string:x255>" + text + "<dev string:x239>";
  function_8fa2ae5d06de8cb3(devgui_txt);
}

function private function_4eeb13709e87e34d() {
  if(function_8303fed4cd3f077e()) {
    return;
  }

  if("<dev string:x1b6>" != "<dev string:x40>") {
    precacheshader("<dev string:x1b6>");
  }

  hudx = -320;
  hudy = -128;

  if(istrue(level.pc)) {
    hudx = -320;
    hudy = -128;
  }

  level.snd.debug = spawnStruct();
  level.snd.debug.debuglevel = getdvarint(@ "scr_snddebug", 0);
  level.snd.debug.filter = getDvar(@ "hash_9c1eb53708e52e2f", "<dev string:x40>");
  level.snd.debug.hud_x = getdvarint(@ "hash_8f80f3ca72788192", hudx);
  level.snd.debug.hud_y = getdvarint(@ "hash_8f80f4ca727883c5", hudy);
  level.snd.debug.dist_radius = getdvarint(@ "hash_bca67414aef4061b", 12);
  level.snd.debug.scale_3d = getdvarfloat(@ "hash_90c83c3028a58709", 1);
  level.snd.debug.color_3d = getdvarvector(@ "hash_f21deb173dd93370", (0.5, 1, 0.666));
  level.snd.debug.color_scale = getdvarfloat(@ "hash_2a753b30a1212892", 0.72974);
  level.snd.debug.var_480f87461a368bd1 = getdvarint(@ "hash_fb5f3970d2e3bfdb", 5);
  level.snd.debug.distance_max = getdvarint(@ "hash_52ac4c0cc02bb1fa", 0);
  level.snd.debug.dot = getdvarfloat(@ "hash_53a06c9d638ec478", 0.99);
  level.snd.debug.draw_limit = getdvarint(@ "hash_33175192ed572d96", 0);
  level.snd.debug.xhair = getdvarint(@ "hash_7cb2165a98d551b", 0);
  level.snd.debug.xhair_alpha = getdvarfloat(@ "hash_abd89601b7f5878d", 0.1);
  level.snd.debug.xhair_radius = getdvarint(@ "hash_e307089961790a19", 3);
  level.snd.debug.initialized = 1;
  snd::dvar(@ "scr_snddebug", level.snd.debug.debuglevel, &function_e6639f41160b3424);
  snd::dvar(@ "hash_9c1eb53708e52e2f", level.snd.debug.filter, &function_e6639f41160b3424);
  snd::dvar(@ "hash_8f80f3ca72788192", level.snd.debug.hud_x, &function_e6639f41160b3424);
  snd::dvar(@ "hash_8f80f4ca727883c5", level.snd.debug.hud_y, &function_e6639f41160b3424);
  snd::dvar(@ "hash_bca67414aef4061b", level.snd.debug.dist_radius, &function_e6639f41160b3424);
  snd::dvar(@ "hash_90c83c3028a58709", level.snd.debug.scale_3d, &function_e6639f41160b3424);
  snd::dvar(@ "hash_f21deb173dd93370", level.snd.debug.color_3d, &function_e6639f41160b3424);
  snd::dvar(@ "hash_2a753b30a1212892", level.snd.debug.color_scale, &function_e6639f41160b3424);
  snd::dvar(@ "hash_fb5f3970d2e3bfdb", level.snd.debug.var_480f87461a368bd1, &function_e6639f41160b3424);
  snd::dvar(@ "hash_52ac4c0cc02bb1fa", level.snd.debug.distance_max, &function_e6639f41160b3424);
  snd::dvar(@ "hash_53a06c9d638ec478", level.snd.debug.dot, &function_e6639f41160b3424);
  snd::dvar(@ "hash_33175192ed572d96", level.snd.debug.draw_limit, &function_e6639f41160b3424);
  snd::dvar(@ "hash_7cb2165a98d551b", level.snd.debug.xhair, &function_e6639f41160b3424);
  snd::dvar(@ "hash_abd89601b7f5878d", level.snd.debug.xhair_alpha, &function_e6639f41160b3424);
  snd::dvar(@ "hash_e307089961790a19", level.snd.debug.xhair_radius, &function_e6639f41160b3424);
  menu = "<dev string:x25b>";
  submenu = "<dev string:x264>";
  function_22219de62996cbeb(menu, submenu, "<dev string:x277>", "<dev string:x283>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x293>", "<dev string:x2a2>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x2bb>", "<dev string:x2d1>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x2f0>", "<dev string:x2fe>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x316>", "<dev string:x326>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x33f>", "<dev string:x352>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x367>", "<dev string:x372>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x387>", "<dev string:x39d>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x3b7>", "<dev string:x3c6>");
  function_22219de62996cbeb(menu, submenu, "<dev string:x3da>", "<dev string:x3ea>");
  function_8fa2ae5d06de8cb3("<dev string:x3fe>");
  function_8fa2ae5d06de8cb3("<dev string:x41d>");
  function_8fa2ae5d06de8cb3("<dev string:x442>");
  function_8fa2ae5d06de8cb3("<dev string:x473>");
  function_8fa2ae5d06de8cb3("<dev string:x49f>");
  function_8fa2ae5d06de8cb3("<dev string:x4ca>");
  function_8fa2ae5d06de8cb3("<dev string:x4f2>");
  function_8fa2ae5d06de8cb3("<dev string:x521>");
  function_8fa2ae5d06de8cb3("<dev string:x55a>");
  function_8fa2ae5d06de8cb3("<dev string:x58b>" + level.snd.debug.hud_x + "<dev string:x5a9>");
  function_8fa2ae5d06de8cb3("<dev string:x5b8>" + level.snd.debug.hud_y + "<dev string:x5d6>");

  if(level.snd.debug.debuglevel == 0) {
    level notify("<dev string:x228>");
    return;
  }

  level thread function_51cf1f1a33e2d4fe();
}

function private function_51cf1f1a33e2d4fe() {
  level notify("<dev string:x228>");
  level endon("<dev string:x228>");
  function_a1694c2fd1775417();
  snd::waitforplayers();

  while(true) {
    scr_snddebug = level.snd.debug.debuglevel ?? 0;

    if(scr_snddebug > 0) {
      function_eda0e3c9de2372a9(scr_snddebug);
      function_b5ca82097666d544(scr_snddebug);
      function_11b2ec4ff06a449b(scr_snddebug);
    }

    waitframe();
  }
}

function private function_8ed5895a233409b3(key, value) {
  if(value != "<dev string:x40>" && isstring(value)) {
    snd::condition_alert(1, "<dev string:x5e5>" + value + "<dev string:x5f8>");
    level notify(value);
  }

  return "<dev string:x40>";
}

function private function_e83fff6161707649(value) {
  level notify("<dev string:x5ff>");
  level endon("<dev string:x5ff>");

  if(isDefined(level.snd.debug.playing)) {
    snd::stop(level.snd.debug.playing);
    level.snd.debug.playing = undefined;
  }

  if(isstring(value) && value.size > 0) {
    sndaliases = strtok(value, "<dev string:x613>");
    snds = [];

    foreach(sndalias in sndaliases) {
      snds[snds.size] = snd::play(sndalias);
    }

    level.snd.debug.playing = snds;
  }

  if(isDefined(level.snd.debug.playing)) {
    snd::await (level.snd.debug.playing);
    level.snd.debug.playing = undefined;
    setDvar(@ "hash_52b4c8d3c40cfc34", "<dev string:x40>");
  }
}

function private function_25d13be248a81e55(key, value) {
  level thread function_e83fff6161707649(value);
  return value;
}

function private function_100e543ee93559a0(key, value) {
  if(key == @ "hash_6db29b2f497ade76" || value == "<dev string:x40>") {
    foreach(player in level.players) {
      player clearsoundsubmix();
    }

    return;
  }

  if(key == @ "hash_e5b570e920b9c1fd") {
    valuearr = strtok(value, "<dev string:x61a>");
    duck = valuearr[0];
    scale = float(valuearr[1] ?? 1);

    foreach(player in level.players) {
      player setsoundsubmix(duck, scale);
    }
  }
}

function private function_1255c3d916d0739b(key, value) {
  foreach(player in level.players) {
    player setplayermusicstate("<dev string:x40>");
    waitframe();
    player setplayermusicstate(value);
  }

  setDvar(@ "hash_2fa2b5d1e7614a6a", "<dev string:x40>");
  return value;
}

function private function_46c9223fda3b2624(waitframes) {
  offset = (262144, 262144, 262144);

  foreach(player in level.players) {
    playerorigin = player.origin;
    playerhealth = player.health;
    player setpriorityclienttriggeraudiozone("<dev string:x61f>", "<dev string:x62a>", 0);

    while(waitframes >= 0) {
      player setOrigin(playerorigin + offset);
      player dontinterpolate();
      player cancelmantle();
      waitframe();
      waitframes -= 1;
    }

    player clearpriorityclienttriggeraudiozone("<dev string:x62a>");
    player setOrigin(playerorigin);
    player dontinterpolate();
    player cancelmantle();
    player cleardamageindicators();
    player.health = playerhealth;
  }
}

function private function_308c070c9c9646ce(key, value) {
  waitframes = int(value);

  if(waitframes < 1) {
    waitframes = 1;
  }

  level thread function_46c9223fda3b2624(waitframes);
  return "<dev string:x40>";
}

function private function_9259f35d84f2c88a() {
  player = self;
  player endon("<dev string:x634>");
  player endon("<dev string:x63d>");

  while(!snd::function_cd79b44ba8163808(player)) {
    vidsize = snd::function_e8dca3401a4ad001();
    var_5f9bc2e03dc5590f = vidsize[0] * 0.5;
    var_6971eee158b50d6e = vidsize[1] * 0.5;
    eyeorigin = player snd::getplayervieworigin();
    eyeangles = player snd::getplayerviewangles();
    eyeforward = anglesToForward(eyeangles);
    eyeright = anglestoright(eyeangles);
    traceend = eyeorigin + eyeforward * 262144;
    trace = trace::_bullet_trace(eyeorigin, traceend, 1, player, 1, 1);

    if(isDefined(trace) && isDefined(trace["<dev string:x651>"]) && trace["<dev string:x651>"] != eyeorigin) {
      pos = trace["<dev string:x651>"];
      surfacetype = trace["<dev string:x65d>"];
      dist = distance(pos, eyeorigin);
      fontscale = 1.5;
      posstring = "<dev string:x66c>" + pos[0] + "<dev string:x672>" + pos[1] + "<dev string:x672>" + pos[2] + "<dev string:x678>";
      hoffset = 1 * fontscale * 16;
      snd::function_f2aaa10b4546fafb(posstring, var_5f9bc2e03dc5590f, var_6971eee158b50d6e + hoffset, fontscale, "<dev string:xa9>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      diststring = "<dev string:x40>" + dist;
      hoffset = 2 * fontscale * 16;
      snd::function_f2aaa10b4546fafb(diststring, var_5f9bc2e03dc5590f, var_6971eee158b50d6e + hoffset, fontscale, "<dev string:xa9>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);

      if(isDefined(surfacetype)) {
        surfstring = "<dev string:x40>" + surfacetype + "<dev string:x40>";
        hoffset = 3 * fontscale * 16;
        snd::function_f2aaa10b4546fafb(surfstring, var_5f9bc2e03dc5590f, var_6971eee158b50d6e + hoffset, fontscale, "<dev string:xa9>", (1, 1, 1), 0.854248, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      }

      snd::debugcrosshair(pos, 4, (0, 0, 0), (1, 1, 1), 1, 1);
    }

    waitframe();
  }
}

function private function_74685f17be057840(key, value) {
  intvalue = int(value);

  foreach(player in level.players) {
    if(intvalue > 0) {
      player thread function_9259f35d84f2c88a();
      continue;
    }

    player notify("<dev string:x63d>");
  }

  return value;
}

function private function_6aef9ac55f28fdfc(dist) {
  player = self;
  player notify("<dev string:x67e>");
  player endon("<dev string:x67e>");
  player endon("<dev string:x634>");

  if(!isDefined(dist)) {
    dist = 2400;
  }

  while(!snd::function_cd79b44ba8163808(player)) {
    playervieworg = player snd::getplayervieworigin();
    playerangles = player snd::getplayerviewangles();
    playerforward = anglesToForward(playerangles);
    playerfov = player snd::getplayerfov();
    scale = -1 * level.snd.debug.scale_3d;
    ents = [];

    if(istrue(level.snd.var_47d98b44f58f4910)) {
      ents = snd::scr_getentitiesinradius(0, playervieworg, dist);
    } else {
      ents = snd::scr_getentitiesinradius(playervieworg, dist, undefined);
    }

    visibleents = snd::function_bee53ee78849b6ea(ents, playervieworg, playerforward, playerfov, dist);

    foreach(ent in visibleents) {
      ent_dist = distance(ent.origin, playervieworg);
      zinc = ent_dist * 0.00125 * 16 * level.snd.debug.scale_3d;
      row = -1;
      yy = (0, 0, 0);

      if(istrue(level.snd.var_aa82b3c5f09326cc)) {
        if(isnumber(ent_dist)) {
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x696>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + ent_dist, ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.classname)) {
          row++;
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x6a9>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.classname ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.targetname)) {
          row++;
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x6ca>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.targetname ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.script_noteworthy)) {
          row++;
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x6dd>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.script_noteworthy ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }
      }

      row = 3;

      if(istrue(level.snd.var_47d98b44f58f4910)) {
        if(isstring(ent.classname)) {
          snd::print3dplus("<dev string:x6f7>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.classname ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.targetname)) {
          row++;
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x709>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.targetname ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }

        if(isstring(ent.script_noteworthy)) {
          row++;
          yy = (0, 0, zinc * row);
          snd::print3dplus("<dev string:x71c>", ent.origin + yy, scale, "<dev string:x6a4>", (0.72974, 0.72974, 0.72974), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
          snd::print3dplus("<dev string:x40>" + (ent.script_noteworthy ?? "<dev string:x6bb>"), ent.origin + yy, scale, "<dev string:x49>", (1, 1, 1), 1, (0, 0, 0), 0.72, (1, 1, 1), 0.72);
        }
      }

      if(istrue(level.snd.var_aa82b3c5f09326cc)) {
        snd::debugcrosshair(ent.origin, 12, ent.angles, (1, 1, 1), 1, 0);
      }

      if(istrue(level.snd.var_47d98b44f58f4910)) {
        snd::debugarrow(ent.origin, ent.angles, 12, 4, (1, 0, 0), 1, 0);
      }
    }

    waitframe();
  }
}

function private function_b04d1f49f3449bd6(key, value) {
  snd::waitforplayers();
  players = snd::getplayerssafe();
  intvalue = int(value);

  foreach(player in players) {
    if(intvalue > 0) {
      player thread function_6aef9ac55f28fdfc(intvalue);
      continue;
    }

    player notify("<dev string:x67e>");
  }

  return value;
}

function private function_fe44570d4f32f592(key, value) {
  return "<dev string:x40>";
}

function private function_5eac22426f6bfe65(key, value) {
  level._createfx.selected_fx_ents = [];

  foreach(ent in level.createfxent) {
    if(isDefined(ent.v["<dev string:x1c5>"]) == 0) {
      continue;
    }

    if(isDefined(ent.v["<dev string:x4e>"]) && utility::string_starts_with(ent.v["<dev string:x1c5>"], "<dev string:x1cd>")) {
      origin = ent.v["<dev string:x4e>"];
      angles = (270, 0, 0);
      origin = (floor(origin[0]), floor(origin[1]), floor(origin[2]));
      ent.v["<dev string:x58>"] = angles;
      ent.v["<dev string:x4e>"] = origin;
      level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = ent;
    }
  }

  createfx::update_selected_entities();
  level._createfx.selected_fx_ents = [];
  return "<dev string:x40>";
}

function private function_f4254d7ded05589e(key, value) {
  if(isarray(level.snd.objects)) {
    count = 0;

    foreach(sndobj in level.snd.objects) {
      soundkey = sndobj.soundkey ?? "<dev string:x736>";
      soundtype = sndobj.soundtype ?? "<dev string:x736>";
      soundalias = sndobj.soundalias ?? "<dev string:x6bb>";
      soundlinkedentity = "<dev string:x73d>";

      if(isDefined(sndobj.soundlinkedentity)) {
        soundlinkedentity = sndobj.soundlinkedentity.classname;
      }

      txt = "<dev string:x40>" + count + "<dev string:x74b>" + soundkey + "<dev string:x756>" + soundtype + "<dev string:x761>" + soundalias + "<dev string:x76f>" + soundlinkedentity + "<dev string:x785>" + sndobj.origin + "<dev string:x40>";
      print(txt);
      count += 1;
    }
  }

  return "<dev string:x44>";
}

# /