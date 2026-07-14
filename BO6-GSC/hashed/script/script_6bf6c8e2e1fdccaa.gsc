/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_6bf6c8e2e1fdccaa.gsc
*****************************************************/

#using script_19163c4e4e504a5e;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace snd;

function function_f7ba2e9e1314bd83(x, y) {
  return x % y;
}

function getplayervieworigin() {
  player = self;
  assert(isplayersafe(self));
  vieworigin = undefined;

  if(isfunction(level.snd.callbacks["\t6\\^s\xe5\xb5\xc9r\xaf"])) {
    vieworigin = player[[level.snd.callbacks["\t6\\^s\xe5\xb5\xc9r\xaf"]]]();
  } else {
    vieworigin = player getEye();
  }

  assert(isvector(vieworigin));
  return vieworigin;
}

function getplayerviewangles() {
  player = self;
  assert(isplayersafe(self));
  viewangles = undefined;

  if(isfunction(level.snd.callbacks["\x1c\x9cF7\xb2H\x1e\x88\"\xf2\x1a$\xb5"])) {
    viewangles = player[[level.snd.callbacks["\x1c\x9cF7\xb2H\x1e\x88\"\xf2\x1a$\xb5"]]]();
  } else {
    viewangles = player getplayerangles();
  }

  assert(isvector(viewangles));
  return viewangles;
}

function getplayerfov() {
  player = self;
  assert(isplayersafe(self));
  fov = undefined;

  if(isfunction(level.snd.callbacks["6\a\xea\xbf\x8f\x92\v\t\xc2-"])) {
    fov = player[[level.snd.callbacks["6\a\xea\xbf\x8f\x92\v\t\xc2-"]]]();
  } else {
    fov = getdvarfloat(@ "cg_fov", 65);
  }

  assert(isfloat(fov));
  assert(fov <= 180);
  return fov;
}

function vectoraverage(v) {
  if(isvector(v)) {
    avg = 0;
    avg += v[0];
    avg += v[1];
    avg += v[2];
    avg /= 3;
    return avg;
  }

  assert(isarray(v), "<dev string:x24>");
  avg = (0, 0, 0);

  if(v.size == 0) {
    return avg;
  } else if(v.size == 1) {
    return v[0];
  }

  foreach(vec in v) {
    avg += vec;
  }

  avg /= v.size;
  return avg;
}

function private function_aa8d103c5dcd2c3d(hud, duration) {
  waitframe();
  hud destroy();
}

function function_e746eb136d96afed(posx, posy, text, color, alpha, scale, duration) {
  origin = (posx, posy, 0);
  printtoscreen2d(posx, posy, text, color, scale);
}

function function_f404b1d48928edc5(func) {
  return isbuiltinfunction(func) || isbuiltinmethod(func);
}

function isscriptfunction(func) {
  return isfunction(func);
}

function function_9b68307805c4b4f1(func) {
  return isbuiltinfunction(func) || isfunction(func);
}

function function_302283a0a28785a6(soundalias, column) {
  return undefined;
}

function function_833c469c43335bb0(soundalias, column) {
  return function_302283a0a28785a6(soundalias, column);
}

function function_fa7ff1b5469aded6(angles) {
  assert(isvector(angles), "<dev string:x5e>");
  wrapped = (angleclamp180(angles[0]), angleclamp180(angles[1]), angleclamp180(angles[2]));
  return wrapped;
}

function randomhelper(value) {
  if(isarray(value)) {
    if(value.size >= 2) {
      min = value[0];
      max = value[1];

      if(min > max) {
        temp = max;
        max = min;
        min = temp;
      }

      assert(max >= min);
      randomrange = randomfloatrange(min, max);
      return randomrange;
    } else if(value.size == 1) {
      value = value[0];
    }
  }

  return float(value);
}

function randomrangehelper(value_min, value_max, value_default) {
  if(isDefined(value_min) && isDefined(value_max)) {
    if(value_min == value_max) {
      return value_min;
    } else {
      value = randomfloatrange(value_min, value_max);
      return value;
    }
  } else if((isDefined(value_min) && isDefined(value_max)) == 0) {
    return value_min;
  } else if(isDefined(value_default)) {
    return value_default;
  }

  return undefined;
}

function rangehelper(range, defaultminvalue) {
  randomrange = undefined;

  if(isarray(range)) {
    if(range.size == 0) {
      return undefined;
    } else if(range.size == 1) {
      return float(range[0]);
    } else {
      rangemin = range[0];
      rangemax = range[1];
      randomrange = randomrangehelper(rangemin, rangemax);
      return float(randomrange);
    }
  } else if(isarray(range) == 0 && isDefined(defaultminvalue)) {
    randomrange = randomrangehelper(defaultminvalue, range);
  } else {
    randomrange = range;
  }

  assert(isDefined(randomrange), "<dev string:x88>");
  return float(randomrange);
}

function function_6e154eec09203976(arr) {
  if(arr.size == 0) {
    return undefined;
  } else if(arr.size == 1) {
    return arr[0];
  }

  return arr;
}

function makearray(v) {
  if(!isDefined(v)) {
    return [];
  } else if(isDefined(v) && function_cd79b44ba8163808(v) == 0 && isarray(v)) {} else {
    return [v];
  }

  assert(isarray(v));
  return v;
}

function function_ca07dc1773060da4(var_eb8ff213cc6c220e, v) {
  isarr = isarray(var_eb8ff213cc6c220e);
  isdef = isDefined(v);

  if(condition_alert(!isdef, "\xa3s\xca/\xa1\xaf\xe9\xcd*\xf0\xec\x9a\xe1\xb0\x0f\x03\xa6\xfd\xc9]Y\xf3\xc9\xcb-<!\x9a6\xdf")) {
    return var_eb8ff213cc6c220e;
  }

  if(!isarr) {
    if(isDefined(var_eb8ff213cc6c220e)) {
      var_eb8ff213cc6c220e = [var_eb8ff213cc6c220e, v];
    } else {
      var_eb8ff213cc6c220e = [v];
    }
  } else if(isarr) {
    isinarr = arraycontains(var_eb8ff213cc6c220e, v);

    if(!isinarr) {
      var_eb8ff213cc6c220e[var_eb8ff213cc6c220e.size] = v;
    }
  }

  return var_eb8ff213cc6c220e;
}

function varrayremove(var_eb8ff213cc6c220e, v) {
  isarr = isarray(var_eb8ff213cc6c220e);

  if(condition_alert(!isDefined(v), "\x8d\x1f\x03\xf6t\xa0\xe6`\x14\xcdi\aQWYY\xff\xce\xb4eA7y\xb6_\xaa\\\nlR\xf8g\x06")) {
    return var_eb8ff213cc6c220e;
  }

  if(!isarr) {
    var_eb8ff213cc6c220e = undefined;
  } else if(isarr) {
    isinarr = arraycontains(var_eb8ff213cc6c220e, v);

    if(isinarr) {
      var_eb8ff213cc6c220e = arrayremove(var_eb8ff213cc6c220e, v);
    }
  }

  return var_eb8ff213cc6c220e;
}

function function_d9d59b56f5fd76de(inputstring, var_30170cdc226b0ed) {
  prefix = "<dev string:xab>";
  outputstring = "<dev string:xab>";

  if(isstring(inputstring) && inputstring.size > 0 && inputstring.size < var_30170cdc226b0ed) {
    var_30170cdc226b0ed -= inputstring.size;

    while(var_30170cdc226b0ed >= 0) {
      prefix += "<dev string:xaf>";
      var_30170cdc226b0ed--;
    }
  }

  outputstring = prefix + inputstring;
  return outputstring;
}

function hasnumber(s) {
  if(isnumber(s)) {
    return true;
  } else if(isstring(s) && s[0] == "\xfe" || s[0] == "\x87" || s[0] == "\x19" || s[0] == "?" || s[0] == "P" || s[0] == "5" || s[0] == "\xbb" || s[0] == "{" || s[0] == "\f" || s[0] == "i" || s[0] == "\x93") {
    return true;
  }

  return false;
}

function printdecimalcount(inputvalue, decimalcount) {
  if(isstring(inputvalue)) {
    return inputvalue;
  }

  if(!isnumber(inputvalue)) {
    assertmsg("<dev string:xb4>");
    return undefined;
  }

  if(!isDefined(decimalcount)) {
    decimalcount = 0;
  }

  decimalcount = int(min(decimalcount, 6));
  intvalue = int(inputvalue + 0.0001);
  fractional = round(inputvalue - intvalue, 0.0001);

  switch (decimalcount) {
    case 0:
      return ("" + intvalue);
    case 1:
      fractional = int(fractional * 10);
      break;
    case 2:
      fractional = int(fractional * 100);
      break;
    case 3:
      fractional = int(fractional * 1000);
      break;
    case 4:
      fractional = int(fractional * 10000);
      break;
    case 5:
      fractional = int(fractional * 10000);
      break;
    case 6:
    default:
      fractional = int(fractional * 100000);
      break;
  }

  fractional_text = fractional + "";
  var_b54da8de1a75d3ad = decimalcount - fractional_text.size;

  if(var_b54da8de1a75d3ad >= 1) {
    for(i = var_b54da8de1a75d3ad; i > 0; i--) {
      fractional_text += "\xfe";
    }
  }

  outputvalue = intvalue + "\x93" + fractional_text;
  return outputvalue;
}

function function_36c3b74ec81a9940(arr) {
  foreach(item in arr) {
    if(isstring(item) && isnumber(item)) {
      arr[i] = int(item);
    }
  }

  return arr;
}

function function_a242ede6cdc85c7(arr) {
  foreach(item in arr) {
    if(isstring(item) && isnumber(item)) {
      arr[i] = float(item);
    }
  }

  return arr;
}

function positionhelper(thing) {
  position = undefined;

  if(isent(thing)) {
    position = thing.origin;
  } else if(isstruct(thing)) {
    position = thing.origin;
  } else if(isvector(thing)) {
    position = thing;
  } else {
    assert(0);
  }

  assert(isvector(position), "<dev string:xe2>");
  return position;
}

function function_6b5c9e7bfbf14dba(thing) {
  origins = [];

  if(isvector(thing)) {
    origins[origins.size] = thing;
  } else if(isarray(thing)) {
    foreach(obj in thing) {
      if(isvector(obj)) {
        origins[origins.size] = obj;
        continue;
      }

      if((isent(obj) || isstruct(obj)) && isvector(obj.origin)) {
        origins[origins.size] = obj.origin;
      }
    }
  }

  return origins;
}

function isstringinteger(str) {
  intvalue = int(str);

  if(intvalue) {
    return true;
  } else if(intvalue == 0 && str == "\xfe") {
    return true;
  }

  return false;
}

function function_cd79b44ba8163808(obj) {
  isa = isarray(obj);
  isd = isDefined(obj);
  ise = isent(obj);
  iss = isstruct(obj);

  if(isa == 0 && iss == 0 && ise == 0 && isd == 0) {
    return true;
  }

  return false;
}

function gettargetnames(target) {
  ents = getEntArray(target, #targetname);
  structs = utility::getStructArray(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  nodes = [];
  vehiclenodes = getvehiclenodearray(target, #targetname);

  if(utility::issp()) {
    nodes = builtin[[level.getnodearrayfunction]](target, #targetname);
  }

  targets = utility::array_combine(ents, structs, nodes, vehiclenodes);
  return targets;
}

function smoothvalue(currentvalue, var_318f27ca9ffc545a, smoothalpha) {
  if(smoothalpha == 0) {
    return currentvalue;
  } else if(smoothalpha == 1) {
    text = "<dev string:x107>";
    println(text);
    iprintlnbold(text);

    return var_318f27ca9ffc545a;
  }

  smoothalpha = clamp(smoothalpha, 0, 1);
  inversealpha = 1 - smoothalpha;
  var_318f27ca9ffc545a = currentvalue * inversealpha + var_318f27ca9ffc545a * smoothalpha;
  return var_318f27ca9ffc545a;
}

function function_23c9259c01aae7d7(value, minvalue, maxvalue) {
  if(value >= minvalue && value <= maxvalue) {
    return true;
  }

  return false;
}

function function_1826b521863cd3af(value, midvalue, var_e825262056d6d755) {
  isinrange = function_23c9259c01aae7d7(value, midvalue - var_e825262056d6d755, midvalue + var_e825262056d6d755);
  return isinrange;
}

function waittilldeleted() {
  assert(isDefined(self));

  while(function_cd79b44ba8163808(self) == 0) {
    self waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  }
}

function waittilldistance(target, range) {
  self endon("\x1e\xfd\xd1\xa2\a");
  src = self;
  rmin = undefined;
  rmax = undefined;

  if(isarray(range)) {
    assert(range.size == 2);
    rmin = float(range[0]);
    rmax = float(range[1]);
    assert(rmax >= rmin);
  } else if(isnumber(range)) {
    rmin = float(range);
  }

  assert(isfloat(rmin));
  armin = abs(rmin);
  armin_sq = squared(armin);
  rmin_sq = squared(rmin);
  rmax_sq = undefined;

  if(isfloat(rmax)) {
    rmax_sq = squared(rmax);

    if(rmax < 0) {
      rmax_sq *= -1;
    }
  }

  if(rmin < 0) {
    rmin_sq *= -1;
  }

  while(isDefined(src) && isDefined(target)) {
    spt = positionhelper(src);
    tpt = positionhelper(target);
    var_732a78014b623520 = distancesquared(spt, tpt);

    if(isfloat(rmax_sq)) {
      if(var_732a78014b623520 <= rmax_sq && var_732a78014b623520 >= rmin_sq) {
        return;
      }
    } else {
      if(rmin_sq > 0 && var_732a78014b623520 >= rmin_sq) {
        return;
      }

      if(rmin_sq <= 0 && var_732a78014b623520 <= armin_sq) {
        return;
      }
    }

    if(function_8c35a6f99f836040() > 0) {
      randred = randomfloatrange(0.72974, 1);
      randgreen = randomfloatrange(0.5, 1);
      randblue = randomfloatrange(0.5, 1);
      randomcolor = (randred, randgreen, randblue);
      randomcolor = vectorNormalize(randomcolor);
      scale = -0.75;
      current_distance = sqrt(var_732a78014b623520);
      disttext = printdecimalcount(current_distance, 0) + "<dev string:x144>" + armin;

      if(isfloat(rmax)) {
        disttext += "<dev string:x144>" + rmax;

        if(rmax > 0) {
          linesphere(tpt, rmax, randomcolor, 1, 1);
        }
      }

      if(armin > 0) {
        linesphere(tpt, armin, randomcolor, 1, 1);
      }

      print3dplus(disttext, tpt + (0, 0, 4), scale, "<dev string:x14b>", randomcolor, 1, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
    }

    waitframe();
  }
}

function function_c57e5010e91e4c2d(holdduration) {
  if(isnumber(holdduration)) {
    return holdduration;
  }

  switch (holdduration) {
    case #"hash_d41336d028b3b99c":
      return 0;
    case #"hash_245ddd42796f500":
    default:
      return 250;
    case #"hash_f920647079c5619d":
      return 1000;
    case #"hash_d3eb18db47fa3d20":
      return 5000;
  }

  return 0;
}

function function_1ce20edf266285af(player, holdduration) {
  var_65f044dc84cfc883 = 250;

  if(isstring(holdduration)) {
    var_65f044dc84cfc883 = function_c57e5010e91e4c2d(holdduration);
  } else if(isnumber(holdduration)) {
    var_65f044dc84cfc883 = holdduration;
  }

  button_time = 0;

  while(button_time < var_65f044dc84cfc883) {
    button_time += 50;
    waitframe();
    waittillframeend();

    if(!player useButtonPressed()) {
      break;
    }
  }

  return button_time;
}

function function_36a5738fd0b9935c(trigger_progress, holdduration, usemilliseconds) {
  if(!isDefined(trigger_progress)) {
    return undefined;
  }

  if(!isDefined(usemilliseconds)) {
    usemilliseconds = 0;
  }

  if(!istrue(trigger_progress.var_f7031246727bf9b0)) {
    trigger_progress waittill("\x1cS\xe3^\xfa\xb5\x1ah\xd3\xcb\x94y\x03%\xff\\", player);
    trigger_progress.var_f7031246727bf9b0 = 1;
    trigger_progress.var_12a5edf6c5dda986 = player;
    return [player, 0];
  }

  player = trigger_progress.var_12a5edf6c5dda986;
  trigger_progress.var_f7031246727bf9b0 = undefined;
  trigger_progress.var_12a5edf6c5dda986 = undefined;
  total_time = function_c57e5010e91e4c2d(holdduration);
  button_time = function_1ce20edf266285af(player, holdduration);
  progress = undefined;

  if(usemilliseconds) {
    progress = [player, button_time];
  } else {
    scale = button_time / total_time;
    progress = [player, scale];
  }

  return progress;
}

function isplayersafe(player) {
  if(isDefined(player) && isent(player) && isPlayer(player)) {
    return true;
  }

  return false;
}

function _getPlayers(team) {
  return level.players;
}

function getplayerssafe(team) {
  if(isDefined(level.snd) && istrue(level.snd.var_47d98b44f58f4910)) {
    players = _getPlayers(team);

    foreach(player in players) {
      if(!isplayersafe(player)) {
        players = arrayremove(players, player);
      }
    }

    return players;
  }

  if(isDefined(level.snd) && istrue(level.snd.var_aa82b3c5f09326cc)) {
    players = _getPlayers(team);
    return players;
  }

  return [];
}

function function_19e9d0581666ee48(localclientnum) {
  players = getplayerssafe();

  foreach(player in players) {
    if(isDefined(player.localclientnum) && player.localclientnum == localclientnum) {
      return player;
    }
  }

  return undefined;
}

function waitforplayers() {
  while(true) {
    players = getplayerssafe();

    if(isarray(players) && players.size > 0) {
      break;
    }

    waitframe();
  }
}

function function_9f9823e903561362(team) {
  waitforplayers();
  players = getplayerssafe(team);
  return players;
}

function function_c06479d09e00277a() {
  if(istrue(level.snd.var_47d98b44f58f4910)) {
    return int(60);
  }

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    return int(20);
  }

  return float(20);
}

function function_7c0b49ad82cf43cd() {
  if(istrue(level.snd.var_47d98b44f58f4910)) {
    return float(0.0166667);
  }

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    return float(0.05);
  }

  return float(0.05);
}

function function_d6cdcc1bd5241be5() {
  if(isstruct(level.snd) && isstring(level.snd.start_point)) {
    return level.snd.start_point;
  } else if(isstring(level.start_point)) {
    return level.start_point;
  }

  return "";
}

function function_c2fc78bcd15019fa(framecount, var_269003928df982b) {
  frametime = 0.0333333 * framecount;

  if(isDefined(var_269003928df982b) == 0) {
    var_269003928df982b = 0;
  }

  waittime = frametime + var_269003928df982b;

  if(waittime <= 0) {
    println("<dev string:x150>" + waittime + "<dev string:x16a>");
    return;
  }

  wait waittime;
}

function scalerp(in_value, in_min, in_max, out_min, out_max) {
  if(in_min == in_max) {
    in_max += 0.001;
  }

  if(out_min == out_max) {
    out_max += 0.001;
  }

  out_lerp = mapfloat(in_min, in_max, out_min, out_max, in_value);
  return out_lerp;
}

function vectorscale(vector, scale) {
  assert(isvector(vector));
  assert(isnumber(scale));
  scaledvector = vector * (scale, scale, scale);
  return scaledvector;
}

function vectorclamp(v, min, max) {
  if(isnumber(min)) {
    min = (min, min, min);
  }

  if(isnumber(max)) {
    max = (max, max, max);
  }

  clampedvector = v;
  clampedvector = (clamp(clampedvector[0], min[0], max[0]), clamp(clampedvector[1], min[1], max[1]), clamp(clampedvector[2], min[2], max[2]));
  return clampedvector;
}

function vectorscalenormalize(vector, scale) {
  scaledvector = vectorscale(vector, scale);
  normalizedvector = vectorNormalize(scaledvector);
  return normalizedvector;
}

function function_91e4e5dcd3f773b0(vector, scale) {
  scaledvector = vectorscale(vector, scale);
  saturatedvector = vectorclamp(scaledvector, (0, 0, 0), (1, 1, 1));
  return saturatedvector;
}

function utofeet(inches) {
  assert(isnumber(inches), "<dev string:x174>");
  return float(inches) * 0.0833333;
}

function utometers(inches) {
  assert(isnumber(inches), "<dev string:x194>");
  return float(inches) * 0.0254;
}

function function_ee380970ca336bf(meters) {
  assert(isnumber(meters), "<dev string:x1b6>");
  return float(meters) * 39.3701;
}

function function_af3e2c890f4a0f4b(meters) {
  assert(isnumber(meters), "<dev string:x1dd>");
  return float(meters) * 3.28084;
}

function function_73d8aecbb9c71091(miles) {
  assert(isnumber(miles), "<dev string:x202>");
  return float(miles) * 63360;
}

function function_7ad5b243f66e32ba(point, sphere_origin, radius) {
  radius_sq = squared(radius);
  dist_sq = distancesquared(point, sphere_origin);

  if(dist_sq <= radius_sq) {
    return true;
  }

  return false;
}

function orbitalposition(centerorigin, dist, var_e67d84fbedc2b48e, elevation) {
  if(isDefined(dist) == 0 || dist <= 0) {
    return centerorigin;
  }

  if(!isDefined(var_e67d84fbedc2b48e)) {
    var_e67d84fbedc2b48e = 0;
  }

  if(!isDefined(elevation)) {
    elevation = 0;
  }

  var_e67d84fbedc2b48e += 180;
  elevation += 270;
  posx = centerorigin[0];
  posy = centerorigin[1];
  posz = centerorigin[2];
  posx += dist * sin(elevation) * cos(var_e67d84fbedc2b48e);
  posy += dist * sin(elevation) * sin(var_e67d84fbedc2b48e);
  posz += dist * cos(elevation);
  position = (posx, posy, posz);
  return position;
}

function gettagsafe(tagstr) {
  ent = self;
  tagname = "";
  tagorigin = undefined;

  if(isDefined(tagstr)) {
    tagname = tagstr;
    tagorigin = ent gettagorigin(tagname, 1);
  }

  if(isDefined(tagorigin)) {
    tagname = tolower(tagname);
  }

  assert(isDefined(tagname), "<dev string:x228>");
  return tagname;
}

function function_3eaabe36c9276b3e(origin, angles, extents) {
  mins = origin - extents;
  maxs = origin + extents;
  delta = maxs - mins;
  randomdelta = (randomfloat(delta[0]), randomfloat(delta[1]), randomfloat(delta[2]));

  if(angles != (0, 0, 0)) {
    mins = origin - rotatevector(origin - mins, angles);
    randomdelta = rotatevector(randomdelta, angles);
  }

  randompoint = mins + randomdelta;
  return randompoint;
}

function function_e8dca3401a4ad001() {
  vidwidth = getdvarint(@ "vid_width", 1920);
  vidheight = getdvarint(@ "vid_height", 1080);
  return [vidwidth, vidheight];
}

function function_8c35a6f99f836040() {
  if(isDefined(level.snd.debug.debuglevel)) {
    return level.snd.debug.debuglevel;
  }

  return 0;
}

function function_1bf6b0f15d5c7e6() {
  if(function_8c35a6f99f836040() > 0) {
    return true;
  }

  return false;
}

function function_b38f1279fae1d2cf() {
  if(function_8c35a6f99f836040() > 2) {
    return true;
  }

  return false;
}

function condition_alert(condition, alerttext) {
  if(istrue(condition)) {
    if(function_1bf6b0f15d5c7e6()) {
      function_9c0efd22ee470aa6(alerttext);
    }
  }

  return condition;
}

function function_4824c7b4727a684(volume) {
  volume = float(volume);

  if(volume <= 0) {
    return -120;
  }

  var_cb74a5214dd67217 = log(volume) / log(10);
  var_c3aeeabd207ddd63 = 20 * var_cb74a5214dd67217;
  return var_c3aeeabd207ddd63;
}

function function_d78564a521d24e24(var_c3aeeabd207ddd63) {
  volume = pow(10, float(var_c3aeeabd207ddd63) / 20);
  return volume;
}

function function_aa97e8c600eb0864(semitone) {
  pitchscale = pow(2, float(semitone) / 12);
  return pitchscale;
}

function function_8056f364a7706266(pitch) {
  pitchlog2 = log(pitch) / log(2);
  semitone = 12 * pitchlog2;
  return semitone;
}

function rvplayanimation(animname, animtree, notifyname, rate) {
  if(isDefined(level.var_106abedb2dabaa7c) == 0) {
    condition_alert(isDefined(level.var_106abedb2dabaa7c) == 0, "r\xec\x14lX\x97\xa0\x9bim\xc2G\xb4{7\b\xbb\x85\xdc\x01\xe6\xde\xa3@\xd2\xcd\xd2\xe8ia6\xd2\x9ee2!");
    return;
  }

  if(isDefined(notifyname) == 0) {
    notifyname = "\xe6\x1a\x90\x81\xb4>\xa6\xb5=\xaa\xff\xd3\x82";
  }

  if(isDefined(rate) == 0) {
    rate = 1;
  }

  self thread[[level.var_106abedb2dabaa7c]](animname, animtree, notifyname, rate);
}

function did_once(name, will_set) {
  assert(isstruct(level.snd), "<dev string:x247>");
  assert(isstring(name), "<dev string:x263>");

  if(!isDefined(will_set)) {
    will_set = 1;
  }

  if(!isarray(level.snd.onesies)) {
    assert(!isarray(level.snd.onesies), "<dev string:x28f>");
    level.snd.onesies = [];
  }

  if(isarray(level.snd.onesies) && istrue(level.snd.onesies[name])) {
    return true;
  }

  if(istrue(will_set)) {
    level.snd.onesies[name] = 1;
  }

  return false;
}

function dvar_shutdown() {
  level notify("\xb9\xb9#\xf5FvaN_\xcd:\xf6\xc1");
}

function private function_11443e34c3542650() {
  level notify("\xb9\xb9#\xf5FvaN_\xcd:\xf6\xc1");
  level endon("\xb9\xb9#\xf5FvaN_\xcd:\xf6\xc1");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  assert(isstruct(level.snd), "<dev string:x247>");
  assert(isDefined(level.snd.dvars));

  while(true) {
    foreach(dvar in level.snd.dvars) {
      callback = dvar.callback;
      key = dvar.key;
      value = "" + dvar.value;
      curvalue = getDvar(key);

      if(isDefined(key) && isDefined(callback) && isDefined(curvalue) && value != curvalue) {
        returnvalue = [[callback]](key, curvalue);

        if(isDefined(returnvalue)) {
          setDvar(key, returnvalue);
          dvar.value = returnvalue;
          continue;
        }

        dvar.value = curvalue;
      }
    }

    waitframe();

    if(isDefined(level.hostmigrationtimer)) {
      level waittill("\xa1\xednG\xf5[-vNa\xa3K{\xb9_YsF");

      foreach(dvar in level.snd.dvars) {
        function_c4fae40e9af028d(dvar.key, dvar.value);
      }
    }
  }
}

function private function_781faad073048ddf() {
  assert(isstruct(level.snd), "<dev string:x247>");

  if(isarray(level.snd.dvars) == 0) {
    level.snd.dvars = [];
    level thread function_11443e34c3542650();
  }
}

function private function_e05d9386b8b00f18(dvar, value, callback_func) {
  dvar_free(dvar);
  level.snd.dvars[dvar] = spawnStruct();
  level.snd.dvars[dvar].callback = callback_func;
  level.snd.dvars[dvar].key = dvar;
  level.snd.dvars[dvar].value = value;
  function_c4fae40e9af028d(dvar, value);
}

function private function_c4fae40e9af028d(dvar, value) {
  existingvalue = getDvar(dvar);

  if(isDefined(existingvalue) == 0 || existingvalue == "") {
    setdvarifuninitialized(dvar, value);
  }
}

function dvar_free(dvar) {
  if(isDefined(level.snd.dvars[dvar])) {
    level.snd.dvars[dvar] = undefined;
  }
}

function dvar(dvar, value, callback_func) {
  var_18a767963fc561f9 = isxhashdvar(dvar);
  var_8a8bcd8938960071 = "\xf0C\xff#a\x96;\x1e\xc5\xc7\x8c\xca\xa0m/\x13\x06LQ@\x1a/\xba^\xcfS\xf3\xba#e\azLL \x98\xff\x9fPU\xbd\xd4\xba9RX5\xe9";

  if(condition_alert(!var_18a767963fc561f9, var_8a8bcd8938960071)) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    assert(var_18a767963fc561f9, var_8a8bcd8938960071 + "<dev string:x2d8>" + dvar);
    return;
  }

  function_781faad073048ddf();
  function_e05d9386b8b00f18(dvar, value, callback_func);
}

function private function_71f7c8675971472f(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  assert(isDefined(self));
  assert(isDefined(callbackfunc));
  assert(isfunction(callbackfunc));

  if(isDefined(arg9)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
  }

  if(isDefined(arg8)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  }

  if(isDefined(arg7)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7);
  }

  if(isDefined(arg6)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6);
  }

  if(isDefined(arg5)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5);
  }

  if(isDefined(arg4)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4);
  }

  if(isDefined(arg3)) {
    self[[callbackfunc]](arg1, arg2, arg3);
    return;
  }

  if(isDefined(arg2)) {
    self[[callbackfunc]](arg1, arg2);
    return;
  }

  if(isDefined(arg1)) {
    self[[callbackfunc]](arg1);
    return;
  }

  self[[callbackfunc]]();
}

function private function_8430d76a495b74c3(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  assert(isDefined(self));
  assert(isDefined(callbackfunc));
  assert(isbuiltinmethod(callbackfunc));

  if(isDefined(arg9)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
  }

  if(isDefined(arg8)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  }

  if(isDefined(arg7)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6, arg7);
  }

  if(isDefined(arg6)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5, arg6);
  }

  if(isDefined(arg5)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4, arg5);
  }

  if(isDefined(arg4)) {
    self[[callbackfunc]](arg1, arg2, arg3, arg4);
  }

  if(isDefined(arg3)) {
    self[[callbackfunc]](arg1, arg2, arg3);
    return;
  }

  if(isDefined(arg2)) {
    self[[callbackfunc]](arg1, arg2);
    return;
  }

  if(isDefined(arg1)) {
    self[[callbackfunc]](arg1);
    return;
  }

  self[[callbackfunc]]();
}

function callbackfunconentity(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  assert(isDefined(self));
  assert(isDefined(callbackfunc));

  if(isfunction(callbackfunc)) {
    function_71f7c8675971472f(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return;
  }

  if(isbuiltinmethod(callbackfunc)) {
    function_8430d76a495b74c3(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
  }
}

function function_6f6f86e82d8f5b23(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  thread callbackfunconentity(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

function private function_98ba0cd6af200bcb(soundalias, column, var_18fbbdabde404bab) {
  if(soundexists(soundalias) == 0) {
    return undefined;
  }

  aliasvalue = function_833c469c43335bb0(soundalias, column);

  if(isDefined(aliasvalue) == 0 || "" + aliasvalue == "") {
    return undefined;
  }

  minormaxvalue = float(aliasvalue);

  for(secondaryalias = function_833c469c43335bb0(soundalias, "{\xcfP\xe5\xd1`\x9f\xdb[\x89\xe0\x85\a\tmR\x9a\xc9"); isDefined(secondaryalias) && secondaryalias != ""; secondaryalias = function_833c469c43335bb0(secondaryalias, "{\xcfP\xe5\xd1`\x9f\xdb[\x89\xe0\x85\a\tmR\x9a\xc9")) {
    aliasvalue = function_833c469c43335bb0(soundalias, column);
    aliasvalue = float(aliasvalue);

    if(var_18fbbdabde404bab == "$\x99\xe4") {
      minormaxvalue = min(minormaxvalue, aliasvalue);
      continue;
    }

    if(var_18fbbdabde404bab == "a\xa1\xc4") {
      minormaxvalue = max(minormaxvalue, aliasvalue);
    }
  }

  return minormaxvalue;
}

function function_9e4e272272a7638(soundalias, column) {
  minvalue = function_98ba0cd6af200bcb(soundalias, column, "$\x99\xe4");
  return minvalue;
}

function function_280d10d0b8ab8d66(soundalias, column) {
  maxvalue = function_98ba0cd6af200bcb(soundalias, column, "a\xa1\xc4");
  return maxvalue;
}

function function_33e26cf69a948288(name) {
  assert(isstring(name), "<dev string:x2de>");
  var_4f0b6541ff0bbb16 = ["J!y\xac\x88", "\xd0\xce\x88\x9e", "\xc1\xf0\x81\x9b", "0\xb0\xc0\xda"];
  musicsndaliases = [];

  foreach(sndaliaspostfix in var_4f0b6541ff0bbb16) {
    sndalias = "\xfe\xb2\x84\xc8" + name + "w" + sndaliaspostfix;
    didexist = soundexists(sndalias);

    if(istrue(didexist)) {
      musicsndaliases[musicsndaliases.size] = sndalias;
      continue;
    }

    statenum = 0;

    while(true) {
      sndaliasnum = sndalias + "w" + statenum;
      didexist = soundexists(sndaliasnum);

      if(istrue(didexist)) {
        musicsndaliases[musicsndaliases.size] = sndaliasnum;
        statenum += 1;
        continue;
      }

      break;
    }
  }

  return musicsndaliases;
}

function musicexists(name) {
  musicsndaliases = function_33e26cf69a948288(name);

  if(musicsndaliases.size > 0) {
    return true;
  }

  return false;
}

function musicislooping(name) {
  islooping = undefined;
  musicsndaliases = function_33e26cf69a948288(name);

  foreach(sndalias in musicsndaliases) {
    islooping = soundislooping(sndalias);

    if(istrue(islooping)) {
      return 1;
    }
  }

  return islooping;
}

function musiclength(name) {
  maxsndaliaslength = 0;
  musicnames = makearray(name);

  foreach(musicname in musicnames) {
    musicsndaliases = function_33e26cf69a948288(musicname);

    foreach(sndalias in musicsndaliases) {
      islooping = soundislooping(sndalias);

      if(istrue(islooping)) {
        return -1;
      }

      sndaliaslength = lookupsoundlength(sndalias, 1);

      if(sndaliaslength > maxsndaliaslength) {
        maxsndaliaslength = sndaliaslength;
      }
    }
  }

  return maxsndaliaslength;
}

function function_b58319a6618febe(decimal) {
  hexarray = "\xa8\x9b\x7fL\xaa\x81\xc9\xe5\xc1\xc0>\xb4\xacW{\x8d";
  quotient = int(decimal);
  hexadecimal = "";

  while(quotient != 0) {
    remainder = quotient % 16;
    hexadecimal = hexarray[remainder] + hexadecimal;
    quotient >>= 4;
  }

  return hexadecimal;
}

function function_9f44a1d7c9525cdc(hex) {
  hex = utility::string(hex);
  intvalue = int(0);

  for(i = 0; i < hex.size; i++) {
    nib = hex[i];
    nibvalue = 0;

    switch (nib) {
      case #"hash_31100bbc01bd3230":
      case #"hash_31100cbc01bd33c3":
      case #"hash_31100dbc01bd3556":
      case #"hash_31100ebc01bd36e9":
      case #"hash_31100fbc01bd387c":
      case #"hash_311010bc01bd3a0f":
      case #"hash_311011bc01bd3ba2":
      case #"hash_311012bc01bd3d35":
      case #"hash_311017bc01bd4514":
      case #"hash_311018bc01bd46a7":
        nibvalue = int(nib);
        break;
      case #"hash_31103fbc01bd840c":
      case #"hash_31105fbc01bdb66c":
        nibvalue = 10;
        break;
      case #"hash_311042bc01bd88c5":
      case #"hash_311062bc01bdbb25":
        nibvalue = 11;
        break;
      case #"hash_311041bc01bd8732":
      case #"hash_311061bc01bdb992":
        nibvalue = 12;
        break;
      case #"hash_31103cbc01bd7f53":
      case #"hash_31105cbc01bdb1b3":
        nibvalue = 13;
        break;
      case #"hash_31103bbc01bd7dc0":
      case #"hash_31105bbc01bdb020":
        nibvalue = 14;
        break;
      case #"hash_31103ebc01bd8279":
      case #"hash_31105ebc01bdb4d9":
        nibvalue = 15;
        break;
    }

    intvalue = int(intvalue << 4 | int(nibvalue));
  }

  return intvalue;
}

function function_28bfe06826a74487(scenedef, willexcludeplayers = 1) {
  instances = [];
  var_ba1a6404825fa9d0 = utility::getStructArray(scenedef, "1\x1b\x9c\x85\xea\xc0k\xfbHd\x80\xef\fh\xd6\x92");
  instances = utility::array_combine(var_ba1a6404825fa9d0, instances);
  instances_active = [];
  instances = utility::array_combine(instances_active, instances);
  instances_inactive = [];
  instances = utility::array_combine(instances_inactive, instances);
  scenedef_ents = [];

  if(isarray(instances) && instances.size > 0) {
    foreach(i in instances) {
      if(isarray(i.scene_ents)) {
        scenedef_ents = utility::array_combine(i.scene_ents, scenedef_ents);
        scenedef_ents = utility::array_removeundefined(scenedef_ents);

        if(willexcludeplayers) {
          foreach(e in scenedef_ents) {
            if(isplayersafe(e)) {
              scenedef_ents = arrayremove(scenedef_ents, e);
            }
          }
        }
      }
    }
  }

  return scenedef_ents;
}

function scr_getentitiesinradius(org, radius, _ignored) {
  ents = getentarrayinradius(undefined, undefined, org, radius);
  return ents;
}

function function_bee53ee78849b6ea(arr, origin, forward, fov = 65, maxdistance) {
  cosfov = cos(fov);

  if(!isDefined(maxdistance)) {
    maxdistance = 262144;
  }

  maxdistance_sq = squared(maxdistance);
  visible = [];

  foreach(v in arr) {
    dist_sq = distancesquared(v.origin, origin);

    if(dist_sq <= maxdistance_sq) {
      delta = v.origin - origin;
      normalized = vectorNormalize(delta);
      dot = vectordot(forward, normalized);

      if(dot >= cosfov) {
        visible[visible.size] = v;
      }
    }
  }

  return visible;
}

function function_2728c886eadd57bf(origin, forward, arr, maxdistance = 262144) {
  maxdistance_sq = squared(maxdistance);
  closest = undefined;
  closestdot = 0;

  foreach(v in arr) {
    dist_sq = distancesquared(v.origin, origin);

    if(dist_sq <= maxdistance_sq) {
      delta = v.origin - origin;
      normalized = vectorNormalize(delta);
      dot = vectordot(forward, normalized);

      if(dot > closestdot) {
        closest = v;
        closestdot = dot;
      }
    }
  }

  return closest;
}

function function_5f2c0a5466e89c2(alertlevel, origin, radius, team) {
  var_3b3d2324724becdd = isvector(origin) && isnumber(radius);
  hasteam = isstring(team);
  ents = undefined;

  if(hasteam && var_3b3d2324724becdd) {
    ents = getaiarrayinradius(origin, radius, team);
  } else if(hasteam && !var_3b3d2324724becdd) {
    ents = getaiarray(team);
  } else if(!hasteam && var_3b3d2324724becdd) {
    ents = getaiarrayinradius(origin, radius);
  } else {
    ents = getaiarray();
  }

  assert(isarray(ents), "<dev string:x304>");

  if(ents.size > 0 && isstring(alertlevel) && alertlevel != "") {
    ai_array = [];

    foreach(ent in ents) {
      if(isstring(ent.alertlevel) && ent.alertlevel == alertlevel) {
        ai_array[ai_array.size] = ent;
      }
    }

    return ai_array;
  }

  return ents;
}

function function_641cb69e464cf8d3(alertlevel, team) {
  ents = function_5f2c0a5466e89c2(alertlevel, undefined, undefined, team);
  return ents;
}

function function_92b3b053e3273e2d(alertlevel, targets, team) {
  if(!isarray(targets)) {
    targets = [targets];
  }

  ents = function_641cb69e464cf8d3(alertlevel, team);

  if(ents.size > 0) {
    ai_array = [];

    foreach(ent in ents) {
      if(isent(ent.enemy) && arraycontains(targets, ent.enemy)) {
        ai_array[ai_array.size] = ent;
      }
    }

    return ai_array;
  }

  return ents;
}

function function_f2e3c2552a8716d2(targets = [level.player], team = "\x9a\x1f\x83\x1bs=\x13\xf8") {
  if(team == "\x9a\x1f\x83\x1bs=\x13\xf8") {
    team = "?\xb1\xc0\x9a";
  }

  vehicles = vehicle_getarray();

  if(isarray(vehicles) && vehicles.size > 0) {
    vehs = [];

    foreach(veh in vehicles) {
      if(isstring(veh.team) && veh.team == team || isstring(veh.script_team) && veh.script_team == team) {
        if(isent(veh.enemy) && arraycontains(targets, veh.enemy)) {
          vehs[vehs.size] = veh;
          continue;
        }

        turret_target = veh getturrettargetEnt();

        if(isent(turret_target) && arraycontains(targets, turret_target)) {
          vehs[vehs.size] = veh;
        }
      }
    }

    return vehs;
  }

  return vehicles;
}