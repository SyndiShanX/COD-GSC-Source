/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\parabolic_mic.gsc
***********************************************/

#using script_37f9ff47f340fbe8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;
#namespace parabolic_mic;

function private autoexec __init__system__() {
  system::register("parabolic_mic", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_weapon_change(&on_weapon_change);
  var_1e935eba = array("scriptmover");

  foreach(str_type in var_1e935eba) {
    clientfield::register(str_type, "parabolic_mic_volume_scale", 1, 5, "float");
  }

  clientfield::register_clientuimodel("hudItems.ParabolicMic.active", 1, 1, "int");
  level.parabolic_mic = spawnStruct();
  level.parabolic_mic.weapon = getweapon("eq_parabolic_mic");

  function_5ac4dc99("<dev string:x38>", 0);
}

function init(var_e00524ce) {
  level.parabolic_mic.trace = undefined;
  thread init_static();
  level.parabolic_mic.static_alias = var_e00524ce;
  level.parabolic_mic.sounds = [];
  level.parabolic_mic.viewents = [];
  level.parabolic_mic.volumes = getEntArray("listening_device_volume", "targetname");

  foreach(volume in level.parabolic_mic.volumes) {
    volume.is_volume = 1;
    volume.var_62a70840 = 0;
  }

  a_structs = struct::get_array("listening_device_targets", "targetname");
  a_ents = getEntArray("listening_device_targets", "targetname");
  level.parabolic_mic.points = arraycombine(a_structs, a_ents);

  foreach(point in level.parabolic_mic.points) {
    point.var_62a70840 = 0;
  }

  level.parabolic_mic.ai = [];
  a_ai = getaiarray();

  foreach(ai in a_ai) {
    if(isalive(ai) && isDefined(ai.var_5b67d687)) {
      level.parabolic_mic.ai[level.parabolic_mic.ai.size] = ai;
      ai.var_62a70840 = 0;
    }
  }

  level.parabolic_mic.funcs = [];
}

function function_765c50e5() {
  self giveweapon(level.parabolic_mic.weapon);
}

function function_f0404f70() {
  self takeweapon(level.parabolic_mic.weapon);
  cleanup();
}

function cleanup() {
  level notify(#"hash_20a07e7129a41bb6");

  if(isDefined(level.parabolic_mic.static)) {
    level.parabolic_mic.static delete();
  }

  if(isDefined(level.parabolic_mic.volumes)) {
    array::delete_all(level.parabolic_mic.volumes);
  }

  level.parabolic_mic = undefined;
}

function private on_weapon_change(params) {
  if(params.weapon === level.parabolic_mic.weapon) {
    self thread function_8ca53cc6(params.weapon);
    return;
  }

  self thread function_af74deb4();
}

function private function_af74deb4() {
  self notify(#"hash_68632710a76257a1");
  self clientfield::set_player_uimodel("hudItems.ParabolicMic.active", 0);
  self stop_static();

  if(isDefined(level.parabolic_mic)) {
    level.parabolic_mic function_5cc7f362();
  }
}

function private function_8ca53cc6(weapon) {
  self endon(#"death", #"hash_68632710a76257a1");
  level endon(#"hash_20a07e7129a41bb6");

  function_5ac4dc99("<dev string:x4f>", 0);

  was_ads = 0;
  self play_static();

  while(true) {
    waitframe(1);

    if(self playerads() > 0.75) {
      self clientfield::set_player_uimodel("hudItems.ParabolicMic.active", 1);
      self trace();
      self function_c5979d91();

      if(!was_ads) {
        self val::set("parabolic_mic", "show_hud", 0);
      }

      was_ads = 1;
      continue;
    }

    if(was_ads) {
      self clientfield::set_player_uimodel("hudItems.ParabolicMic.active", 0);
      self function_5cc7f362();
      self val::reset("parabolic_mic", "show_hud");
      was_ads = 0;
    }
  }
}

function private init_static() {
  if(isDefined(level.parabolic_mic.static)) {
    level.parabolic_mic.static delete();
  }

  ent = util::spawn_model("tag_origin", (0, 0, 0));
  ent.volumescale = 0.1;
  level.parabolic_mic.static = ent;
  util::wait_network_frame(1);
  level.parabolic_mic.static clientfield::set("parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale);
}

function private play_static() {
  if(!level.parabolic_mic.static islinkedto(self)) {
    level.parabolic_mic.static dontinterpolate();
    level.parabolic_mic.static.origin = self getEye();
    level.parabolic_mic.static linkto(self);
  }

  level.parabolic_mic.static playLoopSound(level.parabolic_mic.static_alias);
  level.parabolic_mic.static clientfield::set("parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale);
}

function private stop_static() {
  if(isDefined(level.parabolic_mic.static)) {
    level.parabolic_mic.static stoploopsound();
  }
}

function function_ce0dfadd(name, func) {
  if(!isDefined(level.parabolic_mic.funcs)) {
    level.parabolic_mic.funcs = [];
  }

  level.parabolic_mic.funcs[name] = func;
}

function function_afd5613e(name) {
  if(isDefined(level.parabolic_mic.funcs) && isDefined(level.parabolic_mic.funcs[name])) {
    level.parabolic_mic.funcs[name] = undefined;
  }
}

function private trace() {
  level endon(#"hash_20a07e7129a41bb6");
  min_dist = 300;
  min_dist_squared = min_dist * min_dist;
  max_dist = 4096;
  var_11ecc9fe = max_dist * max_dist;
  eye = self getEye();
  fwd = anglesToForward(self getplayerangles());
  dotlimit = 0.9986;
  level.parabolic_mic.viewents = [];
  level.parabolic_mic.trace = beamtrace(eye + fwd * min_dist, eye + fwd * max_dist, 1, self, 1, 1);

  if(getdvarint(#"hash_1a81e6400daa0c60")) {
    print3d(level.parabolic_mic.trace[# "position"], "<dev string:x66>" + level.parabolic_mic.trace[# "position"][0] + "<dev string:x6a>" + level.parabolic_mic.trace[# "position"][1] + "<dev string:x6a>" + level.parabolic_mic.trace[# "position"][2], (1, 1, 1), 1, 0.35);
    sphere(level.parabolic_mic.trace[# "position"]);
  }

  arrayremovevalue(level.parabolic_mic.volumes, undefined);

  foreach(volume in level.parabolic_mic.volumes) {
    if(!isDefined(volume)) {
      break;
    }

    if(is_true(volume.hasplayed)) {
      continue;
    }

    if(istouching(level.parabolic_mic.trace[# "position"], volume)) {
      if(getdvarint(#"hash_1a81e6400daa0c60")) {
        print3d(level.parabolic_mic.trace[# "position"] + (0, 0, 6), "<dev string:x70>" + volume.script_noteworthy + "<dev string:x78>", (1, 1, 1), 1, 0.35, 2);
      }

      level.parabolic_mic.var_55e793a5 = level.parabolic_mic.trace[# "position"];
      level.parabolic_mic.viewents[level.parabolic_mic.viewents.size] = volume;
      self function_4383ffd(volume);
      break;
    }

    volume.var_62a70840 -= 5;
    volume.var_62a70840 = int(max(0, volume.var_62a70840));

    if(getdvarint(#"hash_1a81e6400daa0c60")) {
      print3d(volume.origin, volume.var_62a70840, (1, 0, 1), 1, 1, 2);
    }
  }

  foreach(item in level.parabolic_mic.points) {
    if(is_true(item.hasplayed)) {
      continue;
    }

    delta = item.origin - eye;
    dir = vectornormalize(delta);
    vector_dot = vectordot(dir, fwd);
    dist = distance2dsquared(item.origin, eye);

    if(vector_dot > dotlimit && dist < var_11ecc9fe) {
      if(sighttracepassed(eye + fwd * min_dist, item.origin, 1, self, item)) {
        if(getdvarint(#"hash_1a81e6400daa0c60")) {
          print3d(item.origin + (0, 0, 4), "<dev string:x70>" + item.script_noteworthy + "<dev string:x83>", (1, 1, 1), 1, 0.35, 2);
        }

        level.parabolic_mic.viewents[level.parabolic_mic.viewents.size] = item;
        self function_4383ffd(item);
      } else {
        item.var_62a70840 -= 5;
        item.var_62a70840 = int(max(0, item.var_62a70840));
      }

      continue;
    }

    item.var_62a70840 -= 5;
    item.var_62a70840 = int(max(0, item.var_62a70840));
  }

  function_1eaaceab(level.parabolic_mic.ai);
  arrayremovevalue(level.parabolic_mic.ai, undefined);

  foreach(item in level.parabolic_mic.ai) {
    offset = item.origin + (0, 0, 64);
    delta = offset - eye;
    dir = vectornormalize(delta);
    vector_dot = vectordot(dir, fwd);
    dist = distance2dsquared(offset, eye);

    if(vector_dot > dotlimit && dist < var_11ecc9fe) {
      if(sighttracepassed(eye + fwd * min_dist, item.origin, 1, self, item)) {
        if(getdvarint(#"hash_1a81e6400daa0c60")) {
          print3d(offset + (0, 0, 26), "<dev string:x70>" + item.script_noteworthy + "<dev string:x8d>", (1, 1, 1), 1, 0.35, 2);
        }

        level.parabolic_mic.viewents[level.parabolic_mic.viewents.size] = item;
        self function_4383ffd(item);
      } else {
        item.var_62a70840 -= 5;
        item.var_62a70840 = int(max(0, item.var_62a70840));

        if(getdvarint(#"hash_1a81e6400daa0c60")) {
          print3d(item.origin, item.var_62a70840, (1, 0, 1), 1, 1, 2);
        }
      }

      continue;
    }

    item.var_62a70840 -= 5;
    item.var_62a70840 = int(max(0, item.var_62a70840));

    if(getdvarint(#"hash_1a81e6400daa0c60")) {
      print3d(item.origin, item.var_62a70840, (1, 0, 1), 1, 1, 2);
    }
  }
}

function private function_c5979d91() {
  level endon(#"hash_20a07e7129a41bb6");

  if(level.parabolic_mic.viewents.size > 0) {
    level.parabolic_mic.static.volumescale -= 0.1;
  } else {
    level.parabolic_mic.static.volumescale += 0.1;
  }

  level.parabolic_mic.static.volumescale = math::clamp(level.parabolic_mic.static.volumescale, 0, 1);
  level.parabolic_mic.static clientfield::set("parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale);
  eye = self getEye();
  fwd = anglesToForward(self getplayerangles());

  if(getdvarint(#"hash_1a81e6400daa0c60")) {
    iprintln("<dev string:x94>" + level.parabolic_mic.static.volumescale);
  }

  arrayremovevalue(level.parabolic_mic.sounds, undefined);

  foreach(ent in level.parabolic_mic.sounds) {
    var_21397691 = 0;

    foreach(var_1d5586e8 in level.parabolic_mic.viewents) {
      if(ent.traceent == var_1d5586e8) {
        var_21397691 = 1;
        break;
      }
    }

    delta = ent.traceent.origin - eye;

    if(isai(ent.traceent)) {
      delta = ent.traceent.origin + (0, 0, 64) - eye;
    }

    if(is_true(ent.traceent.is_volume)) {
      delta = level.parabolic_mic.var_55e793a5 - eye;
    }

    dir = vectornormalize(delta);
    vector_dot = vectordot(dir, fwd);

    if(is_true(ent.traceent.is_volume) && isDefined(level.parabolic_mic.trace)) {
      range = 0.00139999;
      ent.volumescale = 1 - (1 - vector_dot) / range;
      ent.volumescale = math::clamp(ent.volumescale, 0, 1);
      ent clientfield::set("parabolic_mic_volume_scale", ent.volumescale);

      if(getdvarint(#"hash_1a81e6400daa0c60")) {
        if(isDefined(level.parabolic_mic.var_55e793a5)) {
          print3d(level.parabolic_mic.var_55e793a5 + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
        }
      }

      continue;
    }

    range = 0.00139999;
    ent.volumescale = 1 - (1 - vector_dot) / range;
    ent.volumescale = math::clamp(ent.volumescale, 0, 1);
    ent clientfield::set("parabolic_mic_volume_scale", ent.volumescale);

    if(getdvarint(#"hash_1a81e6400daa0c60")) {
      print3d(ent.traceent.origin + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
    }
  }
}

function private function_5cc7f362() {
  level endon(#"hash_20a07e7129a41bb6");

  if(isDefined(level.parabolic_mic.static)) {
    level.parabolic_mic.static.volumescale = 0.1;
    level.parabolic_mic.static.volumescale = math::clamp(level.parabolic_mic.static.volumescale, 0, 1);
    level.parabolic_mic.static clientfield::set("parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale);
  }

  if(isarray(level.parabolic_mic.sounds)) {
    arrayremovevalue(level.parabolic_mic.sounds, undefined);

    foreach(ent in level.parabolic_mic.sounds) {
      ent.volumescale = 0;
      ent clientfield::set("parabolic_mic_volume_scale", ent.volumescale);

      if(getdvarint(#"hash_1a81e6400daa0c60")) {
        print3d(ent.traceent.origin + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, (1, 1, 0), 1, 1, 2);
      }
    }
  }
}

function function_9a3bbf32() {
  level endon(#"hash_20a07e7129a41bb6");
  was_ads = 0;

  foreach(item in level.parabolic_mic.points) {
    item.isplaying = undefined;
    item.hasplayed = undefined;
  }

  max_dist = function_8a7dffe8(level.parabolic_mic.max_dist, 4096);

  while(true) {
    wait 0.1;
    level.parabolic_mic.viewents = [];

    foreach(item in level.parabolic_mic.points) {
      eye = level.players[0] getEye();
      distance = distance(item.origin, eye);

      if(distance < max_dist) {
        level.parabolic_mic.viewents[level.parabolic_mic.viewents.size] = item;
        self function_4383ffd(item);
        continue;
      }

      item.var_62a70840 -= 5;
      item.var_62a70840 = int(max(0, item.var_62a70840));
    }

    self function_3ed9a402();
  }
}

function function_f4d9b06e() {
  level notify(#"hash_20a07e7129a41bb6");
  wait 0.25;
  self function_5cc7f362();
  waitframe(1);
  cleanup();
}

function private function_3ed9a402() {
  level endon(#"hash_20a07e7129a41bb6");
  dotlimit = function_8a7dffe8(level.parabolic_mic.dotlimit, 0.9986);
  eye = self getEye();
  fwd = anglesToForward(self getplayerangles());

  if(getdvarint(#"hash_1a81e6400daa0c60")) {
    iprintln("<dev string:x94>" + level.parabolic_mic.static.volumescale);
  }

  arrayremovevalue(level.parabolic_mic.sounds, undefined);

  foreach(ent in level.parabolic_mic.sounds) {
    var_21397691 = 0;

    foreach(var_1d5586e8 in level.parabolic_mic.viewents) {
      if(ent.traceent == var_1d5586e8) {
        var_21397691 = 1;
        break;
      }
    }

    delta = ent.traceent.origin - eye;

    if(isai(ent.traceent)) {
      delta = ent.traceent.origin + (0, 0, 64) - eye;
    }

    if(is_true(ent.traceent.is_volume)) {
      delta = level.parabolic_mic.var_55e793a5 - eye;
    }

    dir = vectornormalize(delta);
    vectordot = vectordot(dir, fwd);

    if(is_true(ent.traceent.is_volume) && isDefined(level.parabolic_mic.trace)) {
      ent.volumescale = ent function_57f5f925(dotlimit, vectordot);
      ent function_51ee7f9b(ent.volumescale, "parabolic_mic_volume_scale");

      if(getdvarint(#"hash_1a81e6400daa0c60")) {
        if(isDefined(level.parabolic_mic.var_55e793a5)) {
          print3d(level.parabolic_mic.var_55e793a5 + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
        }
      }

      continue;
    }

    ent.volumescale = ent function_57f5f925(dotlimit, vectordot);
    ent function_51ee7f9b(ent.volumescale, "parabolic_mic_volume_scale");

    if(getdvarint(#"hash_1a81e6400daa0c60")) {
      print3d(ent.traceent.origin + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
    }
  }
}

function private function_66b4e486(vectordot) {
  if(isDefined(level.parabolic_mic.var_7b9d607e)) {
    dotlimit = level.parabolic_mic.var_7b9d607e;
  } else {
    dotlimit = function_8a7dffe8(level.parabolic_mic.dotlimit, 0.9986);
  }

  level.parabolic_mic.static.volumescale = self function_57f5f925(dotlimit, vectordot, 1);
  level.parabolic_mic.static function_51ee7f9b(level.parabolic_mic.static.volumescale, "parabolic_mic_volume_scale");
}

function private function_57f5f925(dotlimit, vectordot, isstatic) {
  range = 1 - dotlimit;
  min_dist = function_8a7dffe8(level.parabolic_mic.min_dist, 300);
  max_dist = function_8a7dffe8(level.parabolic_mic.max_dist, 4096);
  eye = level.players[0] getEye();
  distance = distance(self.traceent.origin, eye);

  if(isDefined(isstatic)) {
    volumescale = (1 - vectordot) / range;
    volumescale = math::clamp(volumescale, 0, 1);

    if(volumescale < 1) {
      ratio = 1 - (distance - min_dist) / (max_dist - min_dist);
      volumescale = ratio * volumescale;
    } else if(volumescale == 0) {
      ratio = 1 - (distance - min_dist) / (max_dist - min_dist);
      volumescale = ratio;
    }
  } else {
    if(distance >= max_dist) {
      return 0;
    }

    var_3eb55f86 = 0.75;

    if(level.players[0] playerads() > 0.75) {
      var_3eb55f86 = 1;
    }

    var_9e29ef18 = 1;

    if(isDefined(level.var_731c10af.var_42659717)) {
      if(level.var_731c10af.var_42659717 == 1) {
        var_9e29ef18 = 0.5;
      } else if(level.var_731c10af.var_42659717 == 2) {
        var_9e29ef18 = 0.75;
      }
    }

    volumescale = 1 - (1 - vectordot) / range;
    volumescale = math::clamp(volumescale, 0, 1);
    ratio = (1 + distance - min_dist) / (max_dist - min_dist);
    var_4d090353 = 1 - ratio;
    volumescale = var_4d090353 * volumescale * var_3eb55f86 * var_9e29ef18;
  }

  return volumescale;
}

function private function_51ee7f9b(var_f6287736, var_b62cd9d4) {
  var_f6287736 = math::clamp(var_f6287736, 0, 1);
  self clientfield::set(var_b62cd9d4, var_f6287736);
}

function function_18b589f0(alias, var_21290857 = 0, var_7b80750a, endnotify, var_43a9c16) {
  if(soundislooping(alias) === 1 && !isDefined(endnotify)) {
    assertmsg("<dev string:xb8>" + alias + "<dev string:xe9>");
  }

  self.queue[self.queue.size] = [alias, float(soundgetplaybacktime(alias)) / 1000, var_21290857, var_7b80750a, endnotify, var_43a9c16];
}

function private function_4383ffd(ent) {
  if(isDefined(ent.hasplayed)) {
    return;
  }

  ent.var_62a70840 += 5;
  ent.var_62a70840 = int(min(100, ent.var_62a70840));

  if(getdvarint(#"hash_1a81e6400daa0c60")) {
    print3d(ent.origin, ent.var_62a70840, (1, 0, 1), 1, 1, 2);
  }

  if(isDefined(ent.isplaying)) {
    return;
  }

  if(ent.script_parameters === "off") {
    return;
  }

  self thread function_bcd711ec(ent);
}

function private function_bcd711ec(ent) {
  ent endon(#"entitydeleted");
  ent endon(#"death");
  soundent = util::spawn_model("tag_origin", self getEye());
  soundent linkto(self);
  soundent.volumescale = 0;
  soundent.traceent = ent;
  soundent clientfield::set("parabolic_mic_volume_scale", soundent.volumescale);
  level.parabolic_mic.sounds[level.parabolic_mic.sounds.size] = soundent;
  ent.isplaying = 1;
  soundent play_sound();

  if(isDefined(ent)) {
    ent.isplaying = 0;
    ent.hasplayed = 1;
  }
}

function private play_sound() {
  strfunc = undefined;

  if(isDefined(self.traceent.var_5b67d687)) {
    strfunc = self.traceent.var_5b67d687;
  } else if(isDefined(self.traceent.script_noteworthy)) {
    strfunc = self.traceent.script_noteworthy;
  }

  level endon(#"hash_5b32caefb30f1d4f");
  self thread function_85eb609f();

  if(isDefined(strfunc)) {
    if(isDefined(level.parabolic_mic.funcs[strfunc])) {
      data = [[level.parabolic_mic.funcs[strfunc]]]();

      if(isDefined(data) && isDefined(data.queue) && data.queue.size > 0) {
        self function_4384e133(data);
      }
    }
  }

  self delete();
}

function private function_4384e133(data) {
  self util::function_stack(&function_622d474a, data);
}

function private function_622d474a(data) {
  function_9716db11(data);
  level endon(#"hash_5b32caefb30f1d4f");
  data endon(#"hash_7893b918a25583b7");

  foreach(item in data.queue) {
    alias = item[0];
    var_d6819a9f = item[1];
    delaytime = item[2];
    var_7b80750a = item[3];
    endnotify = item[4];
    var_43a9c16 = item[5];

    if(isDefined(var_43a9c16)) {
      level waittill(var_43a9c16);
    }

    if(delaytime !== 0) {
      wait delaytime;
    }

    if(isDefined(var_7b80750a)) {
      level notify(var_7b80750a);
    }

    if(!soundexists(alias)) {
      iprintlnbold("<dev string:x11c>" + function_9e72a96(alias) + "<dev string:x135>");

      wait 3;

      if(isDefined(endnotify)) {
        level notify(endnotify);
      }

      continue;
    }

    if(soundislooping(alias) === 1) {
      self function_32c867ae(alias, endnotify);
      continue;
    }

    self playSound(alias);

    if(var_d6819a9f > 0) {
      wait var_d6819a9f;
    }

    if(isDefined(endnotify)) {
      level notify(endnotify);
    }
  }
}

function private function_32c867ae(alias, endnotify) {
  if(isDefined(alias)) {
    self playLoopSound(alias);
    level waittill(endnotify);
    self stoploopsound();
    waitframe(1);
  }
}

function private function_9716db11(data) {
  if(isDefined(data.interruptable)) {
    level notify(#"hash_5b32caefb30f1d4f");

    foreach(item in data.queue) {
      self stopsounds();
    }
  }
}

function private function_85eb609f() {
  self endon(#"death");
  level waittill(#"hash_5b32caefb30f1d4f");
  self delete();
}

function private function_8a7dffe8(var_a8cdbaa5, var_53bfdf6b) {
  if(isDefined(var_a8cdbaa5)) {
    value = var_a8cdbaa5;
  } else {
    value = var_53bfdf6b;
  }

  return value;
}