/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6bf6c8e2e1fdccaa.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace snd_utility;

function function_2e231b6fcf0a8552(x, y) {
  return x % y;
}

function getplayervieworigin() {
  player = self;
  assert(isplayersafe(self));
  vieworigin = undefined;

  if(isfunction(level.snd.callbacks["player_view"])) {
    vieworigin = player[[level.snd.callbacks["player_view"]]]();
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

  if(isfunction(level.snd.callbacks["player_angles"])) {
    viewangles = player[[level.snd.callbacks["player_angles"]]]();
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

  if(isfunction(level.snd.callbacks["player_fov"])) {
    fov = player[[level.snd.callbacks["player_fov"]]]();
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

  assertex(isarray(v), "VectorAverage: invalid input parameter is not an array");
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

function private function_535d291881827750(hud, duration) {
  waitframe();
  hud destroy();
}

function print2d(posx, posy, text, color, scale, duration) {
  origin = (posx, posy, 0);
  printtoscreen2d(posx, posy, text, color, scale);
}

function function_fff92f6a135f2bf0(func) {
  return isbuiltinfunction(func) || isbuiltinmethod(func);
}

function isscriptfunction(func) {
  return isfunction(func);
}

function function_ea27c1335507c840(func) {
  return isbuiltinfunction(func) || isfunction(func);
}

function getsndaliasvalue(soundalias, column) {
  return undefined;
}

function function_6d9cb3dc1b62081(soundalias, column) {
  return getsndaliasvalue(soundalias, column);
}

function function_c4cc5b1e29ed927(angles) {
  assertex(isvector(angles), "AnglesWrapTo180 angles is not a vector");
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
  } else if(isDefined(value_min) && isDefined(value_max) == 0) {
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

  assertex(isDefined(randomrange), "RangeHelper invalid randomRange");
  return float(randomrange);
}

function function_3782ee9519fb76c3(arr) {
  if(arr.size == 0) {
    return undefined;
  } else if(arr.size == 1) {
    return arr[0];
  }

  return arr;
}

function function_5762e7cb509e83c0(v) {
  if(!isDefined(v)) {
    return [];
  } else if(isDefined(v) && function_5b8457b9d8edb521(v) == 0 && isarray(v)) {} else {
    return [v];
  }

  assert(isarray(v));
  return v;
}

function varrayadd(var_213ec2bb5c244f6b, v) {
  isarr = isarray(var_213ec2bb5c244f6b);
  isdef = isDefined(v);

  if(function_110d3ab280057f5b(!isdef, "snd VarrayAdd undefined entity")) {
    return var_213ec2bb5c244f6b;
  }

  if(!isarr) {
    if(isDefined(var_213ec2bb5c244f6b)) {
      var_213ec2bb5c244f6b = [var_213ec2bb5c244f6b, v];
    } else {
      var_213ec2bb5c244f6b = [v];
    }
  } else if(isarr) {
    isinarr = array_contains(var_213ec2bb5c244f6b, v);

    if(!isinarr) {
      var_213ec2bb5c244f6b[var_213ec2bb5c244f6b.size] = v;
    }
  }

  return var_213ec2bb5c244f6b;
}

function varrayremove(var_213ec2bb5c244f6b, v) {
  isarr = isarray(var_213ec2bb5c244f6b);

  if(function_110d3ab280057f5b(!isDefined(v), "snd VarrayRemove undefined entity")) {
    return var_213ec2bb5c244f6b;
  }

  if(!isarr) {
    var_213ec2bb5c244f6b = undefined;
  } else if(isarr) {
    isinarr = array_contains(var_213ec2bb5c244f6b, v);

    if(isinarr) {
      var_213ec2bb5c244f6b = array_remove(var_213ec2bb5c244f6b, v);
    }
  }

  return var_213ec2bb5c244f6b;
}

function function_960946df28da50d3(inputstring, var_6459c022ce7f65c0) {
  prefix = "<dev string:x1c>";
  outputstring = "<dev string:x1c>";

  if(isstring(inputstring) && inputstring.size > 0 && inputstring.size < var_6459c022ce7f65c0) {
    var_6459c022ce7f65c0 -= inputstring.size;

    while(var_6459c022ce7f65c0 >= 0) {
      prefix += "<dev string:x1d>";
      var_6459c022ce7f65c0--;
    }
  }

  outputstring = prefix + inputstring;
  return outputstring;
}

function hasnumber(s) {
  if(isnumber(s)) {
    return true;
  } else if(isstring(s) && s[0] == "0" || s[0] == "1" || s[0] == "2" || s[0] == "3" || s[0] == "4" || s[0] == "5" || s[0] == "6" || s[0] == "7" || s[0] == "8" || s[0] == "9" || s[0] == ".") {
    return true;
  }

  return false;
}

function printdecimalcount(inputvalue, decimalcount) {
  if(isstring(inputvalue)) {
    return inputvalue;
  }

  decimalcount = default_to(decimalcount, 0);
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
  var_5941b4a648cb1fa8 = decimalcount - fractional_text.size;

  if(var_5941b4a648cb1fa8 >= 1) {
    for(i = var_5941b4a648cb1fa8; i > 0; i--) {
      fractional_text += "0";
    }
  }

  outputvalue = intvalue + "." + fractional_text;
  return outputvalue;
}

function function_d4d3b207b456339(arr) {
  foreach(item in arr) {
    if(isstring(item) && isnumber(item)) {
      arr[i] = int(item);
    }
  }

  return arr;
}

function function_9f5d39cfad84b702(arr) {
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

  assertex(isvector(position), "PositionHelper thing is undefined");
  return position;
}

function isstringinteger(str) {
  intvalue = int(str);

  if(intvalue) {
    return true;
  } else if(intvalue == 0 && str == "0") {
    return true;
  }

  return false;
}

function function_5b8457b9d8edb521(obj) {
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
  ents = getEntArray(target, "targetname");
  structs = getStructArray(target, "targetname");
  nodes = [];
  vehiclenodes = getvehiclenodearray(target, "targetname");

  if(utility::issp()) {
    nodes = builtin[[level.getnodearrayfunction]](target, "targetname");
  }

  targets = array_combine(ents, structs, nodes, vehiclenodes);
  return targets;
}

function smoothvalue(currentvalue, var_260759ad2ad1d733, smoothalpha) {
  if(smoothalpha == 0) {
    return currentvalue;
  } else if(smoothalpha == 1) {
    text = "<dev string:x1f>";
    println(text);
    iprintlnbold(text);

    return var_260759ad2ad1d733;
  }

  smoothalpha = clamp(smoothalpha, 0, 1);
  inversealpha = 1 - smoothalpha;
  var_260759ad2ad1d733 = currentvalue * inversealpha + var_260759ad2ad1d733 * smoothalpha;
  return var_260759ad2ad1d733;
}

function function_b06eae918d71459e(value, minvalue, maxvalue) {
  if(value >= minvalue && value <= maxvalue) {
    return true;
  }

  return false;
}

function function_c186ea7493546122(value, midvalue, var_d8cf2044c3c965b0) {
  isinrange = function_b06eae918d71459e(value, midvalue - var_d8cf2044c3c965b0, midvalue + var_d8cf2044c3c965b0);
  return isinrange;
}

function waittilldeleted() {
  assert(isDefined(self));

  while(function_5b8457b9d8edb521(self) == 0) {
    self waittill("death_or_disconnect");
  }
}

function waittilldistance(target, range) {
  self endon("death");
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
    var_1dbcede9e13d5c1d = distancesquared(spt, tpt);

    if(isfloat(rmax_sq)) {
      if(var_1dbcede9e13d5c1d <= rmax_sq && var_1dbcede9e13d5c1d >= rmin_sq) {
        return;
      }
    } else {
      if(rmin_sq > 0 && var_1dbcede9e13d5c1d >= rmin_sq) {
        return;
      }

      if(rmin_sq <= 0 && var_1dbcede9e13d5c1d <= armin_sq) {
        return;
      }
    }

    if(function_ec24f13736bfc421() > 0) {
      randred = randomfloatrange(0.72974, 1);
      randgreen = randomfloatrange(0.5, 1);
      randblue = randomfloatrange(0.5, 1);
      randomcolor = (randred, randgreen, randblue);
      randomcolor = vectorNormalize(randomcolor);
      scale = -0.75;
      current_distance = sqrt(var_1dbcede9e13d5c1d);
      disttext = printdecimalcount(current_distance, 0) + "<dev string:x59>" + armin;

      if(isfloat(rmax)) {
        disttext += "<dev string:x59>" + rmax;

        if(rmax > 0) {
          linesphere(tpt, rmax, randomcolor, 1, 1);
        }
      }

      if(armin > 0) {
        linesphere(tpt, armin, randomcolor, 1, 1);
      }

      print3dplus(disttext, tpt + (0, 0, 4), scale, "<dev string:x5d>", randomcolor, 1, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
    }

    waitframe();
  }
}

function function_2d4a302ee020c250(holdduration) {
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

function function_3adf7739d36e98fe(player, holdduration) {
  var_5e02182f8f6fb6fa = 250;

  if(isstring(holdduration)) {
    var_5e02182f8f6fb6fa = function_2d4a302ee020c250(holdduration);
  } else if(isnumber(holdduration)) {
    var_5e02182f8f6fb6fa = holdduration;
  }

  button_time = 0;

  while(button_time < var_5e02182f8f6fb6fa) {
    button_time += 50;
    waitframe();
    waittillframeend();

    if(!player useButtonPressed()) {
      break;
    }
  }

  return button_time;
}

function function_e2c745eac5d9b071(trigger_progress, holdduration, usemilliseconds) {
  if(!isDefined(trigger_progress)) {
    return undefined;
  }

  if(!isDefined(usemilliseconds)) {
    usemilliseconds = 0;
  }

  if(!istrue(trigger_progress.var_f1206490bf71179)) {
    trigger_progress waittill("trigger_progress", player);
    trigger_progress.var_f1206490bf71179 = 1;
    trigger_progress.var_3155d3f1b3e6901f = player;
    return [player, 0];
  }

  player = trigger_progress.var_3155d3f1b3e6901f;
  trigger_progress.var_f1206490bf71179 = undefined;
  trigger_progress.var_3155d3f1b3e6901f = undefined;
  total_time = function_2d4a302ee020c250(holdduration);
  button_time = function_3adf7739d36e98fe(player, holdduration);
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
  if(isDefined(level.snd) && istrue(level.snd.var_ab52ccadc04df539)) {
    players = _getPlayers(team);

    foreach(player in players) {
      if(!isplayersafe(player)) {
        players = array_remove(players, player);
      }
    }

    return players;
  }

  if(isDefined(level.snd) && istrue(level.snd.var_78f5f86726c0fdb5)) {
    players = _getPlayers(team);
    return players;
  }

  return [];
}

function function_7f2f3b83a3cdb2b1(localclientnum) {
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

function function_f4bbf11e1e40fd7(team) {
  waitforplayers();
  players = getplayerssafe(team);
  return players;
}

function function_9f6e6c09d0cac253() {
  if(istrue(level.snd.var_ab52ccadc04df539)) {
    return int(60);
  }

  if(istrue(level.snd.var_78f5f86726c0fdb5)) {
    return int(20);
  }

  return float(20);
}

function function_e448203aedcadcf8() {
  if(istrue(level.snd.var_ab52ccadc04df539)) {
    return float(0.0166667);
  }

  if(istrue(level.snd.var_78f5f86726c0fdb5)) {
    return float(0.05);
  }

  return float(0.05);
}

function function_80ab0bb7534149c0() {
  if(isstruct(level.snd) && isstring(level.snd.start_point)) {
    return level.snd.start_point;
  } else if(isstring(level.start_point)) {
    return level.start_point;
  }

  return "";
}

function function_3c8f0102ea5254f3(framecount, var_74599c89953026e2) {
  frametime = 0.0333333 * framecount;

  if(isDefined(var_74599c89953026e2) == 0) {
    var_74599c89953026e2 = 0;
  }

  waittime = frametime + var_74599c89953026e2;

  if(waittime <= 0) {
    println("<dev string:x5f>" + waittime + "<dev string:x76>");
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

function function_1f9e5d44e92014a5(vector, scale) {
  scaledvector = vectorscale(vector, scale);
  saturatedvector = vectorclamp(scaledvector, (0, 0, 0), (1, 1, 1));
  return saturatedvector;
}

function utofeet(inches) {
  assert(isnumber(inches), "uToFeet() not given a number");
  return float(inches) * 0.0833333;
}

function utometers(inches) {
  assertex(isnumber(inches), "uToMeters() not given a number");
  return float(inches) * 0.0254;
}

function function_a3258e7663b11656(meters) {
  assertex(isnumber(meters), "MetersToInches() not given a number");
  return float(meters) * 39.3701;
}

function function_6bbd3920ae04ba2(meters) {
  assertex(isnumber(meters), "MetersToFeet() not given a number");
  return float(meters) * 3.28084;
}

function function_9fc5aa48cc12af7c(miles) {
  assertex(isnumber(miles), "MilesToInches() not given a number");
  return float(miles) * 63360;
}

function function_ccb738f1c790e173(point, sphere_origin, radius) {
  radius_sq = squared(radius);
  dist_sq = distancesquared(point, sphere_origin);

  if(dist_sq <= radius_sq) {
    return true;
  }

  return false;
}

function orbitalposition(centerorigin, dist, azimuth, elevation) {
  if(isDefined(dist) == 0 || dist <= 0) {
    return centerorigin;
  }

  azimuth = default_to(azimuth, 0);
  elevation = default_to(elevation, 0);
  azimuth += 180;
  elevation += 270;
  posx = centerorigin[0];
  posy = centerorigin[1];
  posz = centerorigin[2];
  posx += dist * sin(elevation) * cos(azimuth);
  posy += dist * sin(elevation) * sin(azimuth);
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

  assertex(isDefined(tagname), "GetTagSafe result undefined");
  return tagname;
}

function function_bbb1fe3fb51bcc47(origin, angles, extents) {
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

function function_d8bcdde57d13f7fc() {
  vidwidth = getdvarint(@ "hash_b7c9a158890bce5a", 1920);
  vidheight = getdvarint(@ "hash_9139b4ad2f235c95", 1080);
  return [vidwidth, vidheight];
}

function function_ec24f13736bfc421() {
  if(isDefined(level.snd.debug.debuglevel)) {
    return level.snd.debug.debuglevel;
  }

  return 0;
}

function function_a3da201852146397() {
  if(function_ec24f13736bfc421() > 0) {
    return true;
  }

  return false;
}

function function_6fa24a43c981460a() {
  if(function_ec24f13736bfc421() > 2) {
    return true;
  }

  return false;
}

function function_110d3ab280057f5b(condition, alerttext) {
  if(istrue(condition)) {
    if(function_a3da201852146397()) {
      function_265429989bce8de3(alerttext);
    }
  }

  return condition;
}

function function_7284566594830145(volume) {
  volume = float(volume);

  if(volume <= 0) {
    return -120;
  }

  var_97a53b026af9b69a = log(volume) / log(10);
  decibels = 20 * var_97a53b026af9b69a;
  return decibels;
}

function function_9d8af59c187aab85(decibels) {
  volume = pow(10, float(decibels) / 20);
  return volume;
}

function function_fbdf5ac18dd9d23d(semitone) {
  pitchscale = pow(2, float(semitone) / 12);
  return pitchscale;
}

function function_72959275a75b62cb(pitch) {
  pitchlog2 = log(pitch) / log(2);
  semitone = 12 * pitchlog2;
  return semitone;
}

function rvplayanimation(animname, animtree, notifyname, rate) {
  if(isDefined(level.var_7e106f551950e269) == 0) {
    function_110d3ab280057f5b(isDefined(level.var_7e106f551950e269) == 0, "rvPlayAnimation was not initialized!");
    return;
  }

  if(isDefined(notifyname) == 0) {
    notifyname = "animnotetrack";
  }

  if(isDefined(rate) == 0) {
    rate = 1;
  }

  self thread[[level.var_7e106f551950e269]](animname, animtree, notifyname, rate);
}

function function_4521134fe3202077() {
  level notify("snd_dvar_stop");
}

function private function_b382d59ff766305() {
  level notify("snd_dvar_stop");
  level endon("snd_dvar_stop");
  level endon("game_ended");
  assertex(isstruct(level.snd), "snd was not initialized.");
  assert(isDefined(level.snd.dvars));

  while(true) {
    foreach(dvar in level.snd.dvars) {
      callback = dvar.callback;
      key = dvar.key;
      value = "" + dvar.value;
      curvalue = getDvar(key);

      if(isDefined(callback) && isDefined(key) && isDefined(curvalue) && value != curvalue) {
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
      level waittill("host_migration_end");

      foreach(dvar in level.snd.dvars) {
        function_96352e81a9257bd4(dvar.key, dvar.value);
      }
    }
  }
}

function private function_38f72ff79044a8ba() {
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(isarray(level.snd.dvars) == 0) {
    level.snd.dvars = [];
    level thread function_b382d59ff766305();
  }
}

function private function_8393534a687ed75d(dvar, value, callback) {
  function_98497fc05416023f(dvar);
  level.snd.dvars[dvar] = spawnStruct();
  level.snd.dvars[dvar].callback = callback;
  level.snd.dvars[dvar].key = dvar;
  level.snd.dvars[dvar].value = value;
  function_96352e81a9257bd4(dvar, value);
}

function private function_96352e81a9257bd4(dvar, value) {
  existingvalue = getDvar(dvar);

  if(isDefined(existingvalue) == 0 || existingvalue == "") {
    setdvarifuninitialized(dvar, value);
  }
}

function function_98497fc05416023f(dvar) {
  if(isDefined(level.snd.dvars[dvar])) {
    level.snd.dvars[dvar] = undefined;
  }
}

function snd_dvar(dvar, value, callback) {
  var_34f0a8b5d28f1398 = isxhashdvar(dvar);
  var_a9f03d5e09892a48 = "snd_dvar: dvar parameter must be XHashDvar (#d)";

  if(function_110d3ab280057f5b(!var_34f0a8b5d28f1398, var_a9f03d5e09892a48)) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    assertex(var_34f0a8b5d28f1398, var_a9f03d5e09892a48 + ": " + dvar);
    return;
  }

  function_38f72ff79044a8ba();
  function_8393534a687ed75d(dvar, value, callback);
}

function private function_2a23870523c17412(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
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

function private function_843f50112a7ef6c2(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
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
    function_2a23870523c17412(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return;
  }

  if(isbuiltinmethod(callbackfunc)) {
    function_843f50112a7ef6c2(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
  }
}

function function_fc1dfbd1f4b5e70e(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  thread callbackfunconentity(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

function private function_83729cc4557db59e(soundalias, column, var_f679c90119df7f7a) {
  if(soundexists(soundalias) == 0) {
    return undefined;
  }

  aliasvalue = function_6d9cb3dc1b62081(soundalias, column);

  if(isDefined(aliasvalue) == 0 || "" + aliasvalue == "") {
    return undefined;
  }

  minormaxvalue = float(aliasvalue);

  for(secondaryalias = function_6d9cb3dc1b62081(soundalias, "secondaryaliasname"); isDefined(secondaryalias) && secondaryalias != ""; secondaryalias = function_6d9cb3dc1b62081(secondaryalias, "secondaryaliasname")) {
    aliasvalue = function_6d9cb3dc1b62081(soundalias, column);
    aliasvalue = float(aliasvalue);

    if(var_f679c90119df7f7a == "min") {
      minormaxvalue = min(minormaxvalue, aliasvalue);
      continue;
    }

    if(var_f679c90119df7f7a == "max") {
      minormaxvalue = max(minormaxvalue, aliasvalue);
    }
  }

  return minormaxvalue;
}

function function_f0ef19ea41182a49(soundalias, column) {
  minvalue = function_83729cc4557db59e(soundalias, column, "min");
  return minvalue;
}

function function_f0cc0bea40f1c3c7(soundalias, column) {
  maxvalue = function_83729cc4557db59e(soundalias, column, "max");
  return maxvalue;
}

function function_814272bc8118f83f(decimal) {
  hexarray = "0123456789ABCDEF";
  quotient = int(decimal);
  hexadecimal = "";

  while(quotient != 0) {
    remainder = quotient % 16;
    hexadecimal = hexarray[remainder] + hexadecimal;
    quotient >>= 4;
  }

  return hexadecimal;
}

function function_be78ea90290a8bb9(hex) {
  hex = string(hex);
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

function function_9826a3de9da92b6e(scenedef, willexcludeplayers) {
  willexcludeplayers = default_to(willexcludeplayers, 1);
  instances = [];
  var_3b71de60548e6665 = getStructArray(scenedef, "scriptbundlename");
  instances = array_combine(var_3b71de60548e6665, instances);
  instances_active = [];
  instances = array_combine(instances_active, instances);
  instances_inactive = [];
  instances = array_combine(instances_inactive, instances);
  scenedef_ents = [];

  if(isarray(instances) && instances.size > 0) {
    foreach(i in instances) {
      if(isarray(i.scene_ents)) {
        scenedef_ents = array_combine(i.scene_ents, scenedef_ents);
        scenedef_ents = array_removeundefined(scenedef_ents);

        if(willexcludeplayers) {
          foreach(e in scenedef_ents) {
            if(isplayersafe(e)) {
              scenedef_ents = array_remove(scenedef_ents, e);
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

function function_789bd1ba84f550cb(arr, origin, forward, fov, maxdistance) {
  fov = default_to(fov, 65);
  cosfov = cos(fov);
  maxdistance = default_to(maxdistance, 262144);
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

function function_706b5dd50f7d5c96(origin, forward, arr, maxdistance) {
  maxdistance = default_to(maxdistance, 262144);
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