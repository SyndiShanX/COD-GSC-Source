/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd_utility.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;

#namespace snd;

function isnumber(num) {
  var_e6fa5c22 = isfloat(num) || isint(num);
  return var_e6fa5c22;
}

function function_a18ae88f(x, y) {
  quotient = floor(x / y);
  remainder = float(x - quotient * y);
  return remainder;
}

function getplayervieworigin() {
  player = self;
  assert(isplayersafe(self));
  vieworigin = undefined;

  if(isscriptfunctionptr(level._snd._callbacks[#"player_view"])) {
    vieworigin = player[[level._snd._callbacks[#"player_view"]]]();
  } else {
    vieworigin = player getEye();
  }

  assert(isvec(vieworigin));
  return vieworigin;
}

function getplayerviewangles() {
  player = self;
  assert(isplayersafe(self));
  viewangles = undefined;

  if(isscriptfunctionptr(level._snd._callbacks[#"player_angles"])) {
    viewangles = player[[level._snd._callbacks[#"player_angles"]]]();
  } else {
    viewangles = player getplayerangles();
  }

  assert(isvec(viewangles));
  return viewangles;
}

function getplayerfov() {
  player = self;
  assert(isplayersafe(self));
  fov = undefined;

  if(isscriptfunctionptr(level._snd._callbacks[#"player_fov"])) {
    fov = player[[level._snd._callbacks[#"player_fov"]]]();
  } else {
    fov = getdvarfloat(#"cg_fov", 65);
  }

  assert(isfloat(fov));
  assert(fov <= 180);
  return fov;
}

function function_ea2f17d1(variable, value) {
  if(isDefined(variable) == 1) {
    return variable;
  }

  assert(isDefined(value) == 1);
  return value;
}

function vectoraverage(v) {
  if(isvec(v) == 1) {
    avg = 0;
    avg += v[0];
    avg += v[1];
    avg += v[2];
    avg /= 3;
    return avg;
  }

  assert(isarray(v) == 1, "<dev string:x38>");
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

function function_70dbede3(angle) {
  if(angle >= -180 && angle <= 180) {
    return angle;
  }

  while(angle < -180) {
    angle += 360;
  }

  while(angle > 180) {
    angle -= 360;
  }

  return angle;
}

function getplayername(player) {
  if(isDefined(player) == 1) {
    if(isDefined(player.name) == 1) {
      return player.name;
    }

    if(isDefined(player.playername) == 1) {
      return player.playername;
    }
  }

  return undefined;
}

function randomhelper(value) {
  if(isarray(value) == 1) {
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
  } else if(isDefined(value_min) == 1 && isDefined(value_max) == 0) {
    return value_min;
  } else if(isDefined(value_default)) {
    return value_default;
  }

  return undefined;
}

function rangehelper(range, defaultminvalue) {
  randomrange = undefined;

  if(isarray(range) == 1) {
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
  } else if(isarray(range) == 0 && isDefined(defaultminvalue) == 1) {
    randomrange = randomrangehelper(defaultminvalue, range);
  } else {
    randomrange = range;
  }

  assert(isDefined(randomrange) == 1, "<dev string:x72>");
  return float(randomrange);
}

function function_31bcd153(arr) {
  if(arr.size == 0) {
    return undefined;
  } else if(arr.size == 1) {
    return arr[0];
  }

  return arr;
}

function function_f218bff5(v) {
  if(!isDefined(v)) {
    return array();
  } else if(isDefined(v) == 1 && isremovedentity(v) == 0 && isarray(v) == 1) {} else {
    return array(v);
  }

  assert(isarray(v) == 1);
  return v;
}

function varrayadd(var_7620540d, v) {
  isarr = isarray(var_7620540d);
  isdef = isDefined(v);

  if(function_81fac19d(!isdef, "snd VarrayAdd undefined entity")) {
    return var_7620540d;
  }

  if(!isarr) {
    if(isDefined(var_7620540d)) {
      var_7620540d = array(var_7620540d, v);
    } else {
      var_7620540d = array(v);
    }
  } else if(isarr) {
    isinarr = isinarray(var_7620540d, v);

    if(!isinarr) {
      var_7620540d[var_7620540d.size] = v;
    }
  }

  return var_7620540d;
}

function varrayremove(var_7620540d, v) {
  isarr = isarray(var_7620540d);
  isdef = isDefined(v);

  if(function_81fac19d(!isdef, "snd VarrayRemove undefined entity")) {
    return var_7620540d;
  }

  if(!isarr) {
    var_7620540d = undefined;
  } else if(isarr) {
    isinarr = isinarray(var_7620540d, v);

    if(isinarr) {
      arrayremovevalue(var_7620540d, v);
    }
  }

  return var_7620540d;
}

function function_783b69(s, wrap) {
  s = function_ea2f17d1(s, "");
  wrap = function_ea2f17d1(wrap, "");
  str = "";

  if(ishash(s)) {
    if(wrap != "<dev string:x95>") {
      str = "<dev string:x99>";
    }

    s = hashtostring(s);
  }

  str += wrap + s + wrap;
  return str;
}

function function_8cb4e540(inputstring, var_329bae03) {
  prefix = "<dev string:x95>";
  outputstring = "<dev string:x95>";

  if(isstring(inputstring) && inputstring.size > 0 && inputstring.size < var_329bae03) {
    var_329bae03 -= inputstring.size;

    while(var_329bae03 >= 0) {
      prefix += "<dev string:x9e>";
      var_329bae03--;
    }
  }

  outputstring = prefix + inputstring;
  return outputstring;
}

function hasnumber(s) {
  if(isnumber(s) == 1) {
    return true;
  } else if(isstring(s) == 1 && s[0] == "0" || s[0] == "1" || s[0] == "2" || s[0] == "3" || s[0] == "4" || s[0] == "5" || s[0] == "6" || s[0] == "7" || s[0] == "8" || s[0] == "9" || s[0] == ".") {
    return true;
  }

  return false;
}

function printdecimalcount(inputvalue, decimalcount) {
  if(isstring(inputvalue)) {
    return inputvalue;
  }

  decimalcount = function_ea2f17d1(decimalcount, 0);
  decimalcount = int(min(decimalcount, 6));
  intvalue = int(inputvalue);
  fractional = inputvalue - intvalue;

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

  outputvalue = intvalue + "." + fractional;
  return outputvalue;
}

function function_6afe83c4(arr) {
  foreach(i, item in arr) {
    var_4c1ba7d3 = isstring(item);
    var_e6fa5c22 = hasnumber(item);

    if(var_4c1ba7d3 == 1 && var_e6fa5c22 == 1) {
      arr[i] = int(item);
    }
  }

  return arr;
}

function function_64a5440a(arr) {
  foreach(i, item in arr) {
    var_4c1ba7d3 = isstring(item);
    var_e6fa5c22 = hasnumber(item);

    if(var_4c1ba7d3 == 1 && var_e6fa5c22 == 1) {
      arr[i] = float(item);
    }
  }

  return arr;
}

function positionhelper(thing) {
  position = undefined;

  if(isremovedentity(thing) == 0 && isDefined(thing.origin)) {
    position = thing.origin;
  } else if(isvec(thing) == 1) {
    position = thing;
  } else {
    assert(0);
  }

  assert(isvec(position) == 1, "<dev string:xa3>");
  return position;
}

function function_322e32be(array) {
  assert(isarray(array) == 1, "<dev string:xc8>");

  if(array.size == 1) {
    return array[0];
  }

  randomindex = randomintrange(1, array.size);
  randomindex -= 1;
  assert(randomindex >= 0 && randomindex < array.size - 1);
  randomelement = array[randomindex];
  return randomelement;
}

function isstringinteger(str) {
  intvalue = int(str);

  if(intvalue > 0) {
    return true;
  } else if(intvalue < 0) {
    return true;
  } else if(intvalue == 0 && str == "0") {
    return true;
  }

  return false;
}

function gettargetnames(target) {
  ents = getEntArray(target, "targetname");
  structs = struct::get_array(target, "targetname");
  targets = arraycombine(ents, structs);
  return targets;
}

function smoothvalue(currentvalue, var_2901828, smoothalpha) {
  if(smoothalpha == 0) {
    return currentvalue;
  } else if(smoothalpha == 1) {
    text = "<dev string:xeb>";
    println(text);
    iprintlnbold(text);

    return var_2901828;
  }

  smoothalpha = math::clamp(smoothalpha, 0, 1);
  inversealpha = 1 - smoothalpha;
  var_2901828 = currentvalue * inversealpha + var_2901828 * smoothalpha;
  return var_2901828;
}

function function_a5300865(value, minvalue, maxvalue) {
  if(value >= minvalue && value <= maxvalue) {
    return true;
  }

  return false;
}

function function_6ecb085(value, midvalue, var_2c789a2) {
  isinrange = function_a5300865(value, midvalue - var_2c789a2, midvalue + var_2c789a2);
  return isinrange;
}

function waittilldeleted() {
  assert(isDefined(self) == 1);

  while(isremovedentity(self) == 0) {
    self waittill(#"death", #"disconnect");
  }
}

function waittilldistance(target, range) {
  self endon(#"death");
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

  while(isDefined(src) && isDefined(target)) {
    spt = positionhelper(src);
    tpt = positionhelper(target);
    current_distance = distance(spt, tpt);

    if(isfloat(rmax)) {
      if(current_distance <= rmax && current_distance >= rmin) {
        return;
      }
    } else {
      if(rmin > 0 && current_distance >= rmin) {
        return;
      }

      if(rmin <= 0 && current_distance <= armin) {
        return;
      }
    }

    if(function_95c9af4b() > 0) {
      randred = randomfloatrange(0.72974, 1);
      randgreen = randomfloatrange(0.5, 1);
      randblue = randomfloatrange(0.5, 1);
      randomcolor = (randred, randgreen, randblue);
      randomcolor = vectorNormalize(randomcolor);
      disttext = printdecimalcount(current_distance, 0) + "<dev string:x128>" + armin;

      if(isfloat(rmax)) {
        disttext += "<dev string:x128>" + rmax;

        if(rmax > 0) {
          linesphere(tpt, rmax, randomcolor, 1, 1);
        }
      }

      if(armin > 0) {
        linesphere(tpt, armin, randomcolor, 1, 1);
      }

      print3dplus(disttext, tpt + (0, 0, 4), -0.75, "<dev string:x12f>", randomcolor, 1, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
    }

    waitframe(1);
  }
}

function isplayersafe(player) {
  if(isDefined(player) && isentity(player) && isPlayer(player)) {
    return true;
  }

  return false;
}

function getplayerssafe(team) {
  if(is_true(level._snd.var_8c37ff34)) {
    players = getPlayers(0, team);

    foreach(player in players) {
      if(!isplayersafe(player)) {
        arrayremovevalue(players, player);
      }
    }

    return players;
  }

  if(is_true(level._snd.var_2dd09170)) {
    players = getPlayers(team);
    return players;
  }

  return array();
}

function function_a8210e43(localclientnum) {
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
    wait_init();
    players = getplayerssafe();

    if(isarray(players) && players.size > 0) {
      break;
    }

    waitframe(1);
  }
}

function function_da785aa8(team) {
  waitforplayers();
  players = getplayerssafe(team);
  return players;
}

function function_869cb8c6() {
  if(is_true(level._snd.var_8c37ff34)) {
    return int(60);
  }

  if(is_true(level._snd.var_2dd09170)) {
    return int(20);
  }

  return float(20);
}

function function_6cfa7975() {
  if(is_true(level._snd.var_8c37ff34)) {
    return float(0.0166667);
  }

  if(is_true(level._snd.var_2dd09170)) {
    return float(0.05);
  }

  return float(0.05);
}

function function_41df60ba(framecount, var_5bc3280a) {
  frametime = 0.0333333 * framecount;

  if(isDefined(var_5bc3280a) == 0) {
    var_5bc3280a = 0;
  }

  waittime = frametime + var_5bc3280a;

  if(waittime <= 0) {
    println("<dev string:x134>" + waittime + "<dev string:x14e>");
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

function private function_e17840b5(vector, scale) {
  assert(isvec(vector));
  assert(isnumber(scale));
  scaledvector = vector * (scale, scale, scale);
  return scaledvector;
}

function private function_afb43113(vector) {
  largestindex = 0;
  var_d7a0aa89 = 0;
  mult = 1;
  var_35f90ba = vector;

  for(i = 0; i < 3; i++) {
    v = vector[i];

    if(v > var_d7a0aa89) {
      largestindex = i;
      var_d7a0aa89 = v;
    }
  }

  mult = 1 / var_d7a0aa89;
  var_35f90ba = vectorscale(var_35f90ba, mult);
  return var_35f90ba;
}

function vectorclamp(v, min, max) {
  if(isnumber(min)) {
    min = (min, min, min);
  }

  if(isnumber(max)) {
    max = (max, max, max);
  }

  clampedvector = v;
  clampedvector = (math::clamp(clampedvector[0], min[0], max[0]), math::clamp(clampedvector[1], min[1], max[1]), math::clamp(clampedvector[2], min[2], max[2]));
  return clampedvector;
}

function vectorscalenormalize(vector, scale) {
  scaledvector = vectorscale(vector, scale);
  normalizedvector = function_afb43113(scaledvector);
  return normalizedvector;
}

function function_2677a7e2(vector, scale) {
  scaledvector = vectorscale(vector, scale);
  saturatedvector = vectorclamp(scaledvector, (0, 0, 0), (1, 1, 1));
  return saturatedvector;
}

function utofeet(inches) {
  assert(isnumber(inches) == 1, "<dev string:x158>");
  return float(inches) * 0.0833333;
}

function utometers(inches) {
  assert(isnumber(inches) == 1, "<dev string:x178>");
  return float(inches) * 0.0254;
}

function function_c8caaab4(point, sphere_origin, radius) {
  dist = distance(point, sphere_origin);

  if(dist <= radius) {
    return true;
  }

  return false;
}

function orbitalposition(centerorigin, dist, azimuth, elevation) {
  if(isDefined(dist) == 0 || dist <= 0) {
    return centerorigin;
  }

  azimuth = function_ea2f17d1(azimuth, 0);
  elevation = function_ea2f17d1(elevation, 0);
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

  if(is_true(level._snd.var_8c37ff34)) {
    tagname = "tag_origin";
  }

  if(isDefined(tagstr) == 1) {
    tagorigin = ent gettagorigin(tagstr);
  }

  if(isDefined(tagorigin) == 1) {
    tagname = tolower(tagstr);
  }

  assert(isDefined(tagname) == 1, "<dev string:x19a>");
  return tagname;
}

function function_1666c97e(origin, angles, extents) {
  mins = origin - extents;
  maxs = origin + extents;
  delta = maxs - mins;
  randomdelta = (randomfloat(delta[0]), randomfloat(delta[1]), randomfloat(delta[2]));

  if(angles != (0, 0, 0)) {
    mins = origin - rotatepoint(origin - mins, angles);
    randomdelta = rotatepoint(randomdelta, angles);
  }

  randompoint = mins + randomdelta;
  return randompoint;
}

function function_827811b5() {
  vidwidth = 1920;
  vidheight = 1080;

  if(ispc()) {
    isfullscreen = getdvarint(#"r_fullscreen", 0);

    if(isfullscreen) {
      mode = getDvar(#"r_fullscreenmode", "800x600");
      dims = strtok(mode, "x");

      if(isarray(dims) && dims.size >= 2) {
        vidwidth = int(dims[0]);
        vidheight = int(dims[1]);
      }
    } else {
      vidwidth = getdvarint(#"hash_799d70a49cc79c0f", 1920);
      vidheight = getdvarint(#"hash_526c340ae912bbd0", 1080);
    }
  }

  resolution = array(vidwidth, vidheight);
  return resolution;
}

function function_95c9af4b() {
  if(isDefined(level._snd._debug.debuglevel)) {
    return level._snd._debug.debuglevel;
  }

  return 0;
}

function function_d78e3644() {
  if(function_95c9af4b() > 0) {
    return true;
  }

  return false;
}

function function_f984063f() {
  if(function_95c9af4b() > 2) {
    return true;
  }

  return false;
}

function function_15ba1770() {
  usernames = ["jgosselin", "mdenis", "ntremblay", "plgrondines", "prenaud", "vleroux", "cbello", "csakanai", "imika", "jdrelick", "tbader", "carya", "cegert", "cstaples", "cchristensen", "dnatale", "dprior", "drowe", "smiller", "sprovine", "tleeamies", "tstasica", "abayless", "abrown", "bkreimeier", "dblondin", "jharley", "jsypult", "jtennies", "kkozlowski", "ndamato", "rsmsnjmiller", "jmiller", "vnuniyants", "dveca", "dswenson", "elopez", "flabarthe", "kchau", "mcaisley", "mgrimm", "midavies", "rmcsweeney", "bbitonti", "btuey", "cayers", "cdinkel", "hplunkard", "jmccawley", "ksherwood", "lstaples", "rgarigliano", "seckert", "sjimmerson", "wcornell"];
  players = getplayerssafe();

  if(isarray(players)) {
    foreach(player in players) {
      playername = getplayername(player);

      if(isDefined(playername)) {
        foreach(username in usernames) {
          if(issubstr(playername, username)) {
            setDvar(#"hash_7bf92664f192f2a2", "1");
            return;
          }
        }
      }
    }
  }
}

function function_81fac19d(condition, alerttext) {
  if(condition) {
    if(function_d78e3644() == 1) {
      function_3ba3cecb(alerttext);
    }
  }

  return condition;
}

function function_7b45efc6(volume) {
  var_aaa0f6d6 = log(float(volume)) / log(10);
  decibels = 20 * var_aaa0f6d6;
  return decibels;
}

function function_359f7bac(decibels) {
  volume = pow(10, float(decibels) / 20);
  return volume;
}

function function_d8b24901(semitone) {
  pitchscale = pow(2, float(semitone) / 12);
  return pitchscale;
}

function function_9bf57bf0(pitch) {
  pitchlog2 = log(float(pitch)) / log(2);
  semitone = 12 * pitchlog2;
  return semitone;
}

function rvplayanimation(animname, animtree, notifyname, rate) {
  if(isDefined(level.var_31efd858) == 0) {
    function_81fac19d(isDefined(level.var_31efd858) == 0, "rvPlayAnimation was not initialized!");
    return;
  }

  if(isDefined(notifyname) == 0) {
    notifyname = "animnotetrack";
  }

  if(isDefined(rate) == 0) {
    rate = 1;
  }

  self thread[[level.var_31efd858]](animname, animtree, notifyname, rate);
}

function dvar_shutdown() {
  level notify(#"dvar_stop");
}

function private function_225d1cb8() {
  level notify(#"dvar_stop");
  level endon(#"dvar_stop");
  level endon(#"game_ended");

  while(true) {
    foreach(dvar in level.var_ebd8d6b1) {
      callback = dvar.callback;
      key = dvar.key;
      value = getDvar(key);

      if(isDefined(callback) && isDefined(key) && isDefined(value) && dvar.value != value) {
        returnvalue = [[callback]](key, value);

        if(isDefined(returnvalue)) {
          setDvar(key, returnvalue);
          dvar.value = returnvalue;
          continue;
        }

        dvar.value = value;
      }
    }

    waitframe(1);

    if(isDefined(level.hostmigrationtimer)) {
      level waittill(#"host_migration_end");

      foreach(dvar in level.var_ebd8d6b1) {
        function_b7598ee(dvar.key, dvar.value);
      }
    }
  }
}

function private function_d517905b() {
  if(isDefined(level.var_ebd8d6b1) == 0) {
    level.var_ebd8d6b1 = array();
    level thread function_225d1cb8();
  }
}

function private function_3710d450(dvar, value, callback) {
  dvar_free(dvar);
  level.var_ebd8d6b1[dvar] = spawnStruct();
  level.var_ebd8d6b1[dvar].callback = callback;
  level.var_ebd8d6b1[dvar].key = dvar;
  level.var_ebd8d6b1[dvar].value = value;
  function_b7598ee(dvar, value);
}

function private function_b7598ee(dvar, value) {
  function_5ac4dc99(dvar, value);
}

function dvar_free(dvar) {
  if(isDefined(level.var_ebd8d6b1[dvar])) {
    level.var_ebd8d6b1[dvar] = undefined;
  }
}

function dvar(dvar, value, callback) {
  function_d517905b();
  function_3710d450(dvar, value, callback);
}

function private function_98a0f33(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  assert(isDefined(self) == 1);
  assert(isDefined(callbackfunc) == 1);
  assert(isscriptfunctionptr(callbackfunc) == 1);

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

function private function_8a64a4ec(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  assert(isDefined(self) == 1);
  assert(isDefined(callbackfunc) == 1);
  assert(iscodefunctionptr(callbackfunc) == 0);

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
  assert(isDefined(self) == 1);
  assert(isDefined(callbackfunc) == 1);

  if(isscriptfunctionptr(callbackfunc) == 1) {
    self function_98a0f33(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return;
  }

  if(iscodefunctionptr(callbackfunc) == 1) {
    self function_8a64a4ec(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
  }
}

function function_b3acadc6(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) {
  self thread callbackfunconentity(callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

function private function_9cae113f(soundalias, column, var_46195ad8) {
  if(soundexists(soundalias) == 0) {
    return undefined;
  }

  aliasvalue = function_9119c373(soundalias, column);

  if(isDefined(aliasvalue) == 0 || "<dev string:x95>" + aliasvalue == "<dev string:x95>") {
    return undefined;
  }

  minormaxvalue = float(aliasvalue);

  for(secondaryalias = function_9119c373(soundalias, "<dev string:x1b9>"); isDefined(secondaryalias) == 1 && secondaryalias != "<dev string:x95>"; secondaryalias = function_9119c373(secondaryalias, "<dev string:x1b9>")) {
    aliasvalue = function_9119c373(soundalias, column);
    aliasvalue = float(aliasvalue);

    if(var_46195ad8 == "<dev string:x1c6>") {
      minormaxvalue = min(minormaxvalue, aliasvalue);
      continue;
    }

    if(var_46195ad8 == "<dev string:x1cd>") {
      minormaxvalue = max(minormaxvalue, aliasvalue);
    }
  }

  return minormaxvalue;
}

function function_7139f5ae(soundalias, column) {
  minvalue = function_9cae113f(soundalias, column, "<dev string:x1c6>");
  return minvalue;
}

function function_10120598(soundalias, column) {
  maxvalue = function_9cae113f(soundalias, column, "<dev string:x1cd>");
  return maxvalue;
}

function function_636a2037(decimal) {
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

function function_cc1eeb91(hex) {
  hex = string(hex);
  intvalue = int(0);

  for(i = 0; i < hex.size; i++) {
    nib = hex[i];
    nibvalue = 0;

    switch (nib) {
      case #"5":
      case #"4":
      case #"7":
      case #"6":
      case #"1":
      case #"0":
      case #"3":
      case #"2":
      case #"9":
      case #"8":
        nibvalue = int(nib);
        break;
      case #"a":
      case #"a":
        nibvalue = 10;
        break;
      case #"b":
      case #"b":
        nibvalue = 11;
        break;
      case #"c":
      case #"c":
        nibvalue = 12;
        break;
      case #"d":
      case #"d":
        nibvalue = 13;
        break;
      case #"e":
      case #"e":
        nibvalue = 14;
        break;
      case #"f":
      case #"f":
        nibvalue = 15;
        break;
    }

    intvalue = int(intvalue << 4 | int(nibvalue));
  }

  return intvalue;
}

function function_c65c3de8(hashvalue) {
  intvalue = int(hashvalue);
  var_f76bdca5 = function_636a2037(intvalue);
  return var_f76bdca5;
}

function function_35dccf3f(hex) {
  intvalue = function_cc1eeb91(hex);
  hashvalue = hash(intvalue);
  return hashvalue;
}

function function_cc5643b5(str) {
  hashvalue = hash(str);
  var_f76bdca5 = string(hashvalue);
  return var_f76bdca5;
}

function function_3626f311(hex) {
  hashvalue = function_35dccf3f(hex);
  stringvalue = hashtostring(hashvalue);
  return stringvalue;
}

function function_33ccce67(scenedef, willexcludeplayers) {
  willexcludeplayers = function_ea2f17d1(willexcludeplayers, 1);
  instances = array();
  var_558dab14 = struct::get_array(scenedef, "scriptbundlename");
  instances = arraycombine(var_558dab14, instances, 0, 0);
  instances_active = scene::get_active_scenes(scenedef);
  instances = arraycombine(instances_active, instances, 0, 0);
  instances_inactive = scene::get_inactive_scenes(scenedef);
  instances = arraycombine(instances_inactive, instances, 0, 0);
  scenedef_ents = array();

  if(isarray(instances) && instances.size > 0) {
    foreach(i in instances) {
      if(isarray(i.scene_ents)) {
        scenedef_ents = arraycombine(i.scene_ents, scenedef_ents, 0, 0);
        arrayremovevalue(scenedef_ents, undefined, 0);

        if(willexcludeplayers) {
          foreach(e in scenedef_ents) {
            if(isplayersafe(e)) {
              arrayremovevalue(scenedef_ents, e, 0);
            }
          }
        }
      }
    }
  }

  return scenedef_ents;
}