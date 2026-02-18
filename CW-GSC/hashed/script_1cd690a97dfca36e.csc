/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1cd690a97dfca36e.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function did_init() {
  if(isDefined(level._snd) && isDefined(level._snd.var_d37e94ca) && is_true(level._snd.isinitialized)) {
    return true;
  }

  return false;
}

function wait_init() {
  while(did_init() == 0) {
    waitframe(1);
  }
}

function play(soundalias, targets) {
  soundtype = level._snd.var_d37e94ca;
  soundobject = function_2639b80c(soundtype, soundalias, targets);
  return soundobject;
}

function stop(soundobject, fadeoutseconds) {
  foreach(soundobj in function_f218bff5(soundobject)) {
    level thread function_f937a6f7(soundobj, fadeoutseconds);
  }
}

function stop_alias(soundalias, targets, fadeoutseconds) {
  if(function_81fac19d(!isDefined(soundalias), "snd_stop_alias with undefined soundalias")) {
    return 0;
  }

  soundalias = tolower(soundalias);
  soundobjects = function_33560b93(targets);
  nitrous_boat_motor_offset_y = 0;

  foreach(soundobj in soundobjects) {
    if(!isDefined(soundobj.soundalias)) {
      continue;
    }

    if(issubstr(tolower(soundobj.soundalias), soundalias)) {
      stop(soundobj, fadeoutseconds);
      nitrous_boat_motor_offset_y = int(nitrous_boat_motor_offset_y + 1);
    }
  }

  return nitrous_boat_motor_offset_y;
}

function function_2a2f26d4(soundobject, notifyentity, notifystring, fadeoutseconds) {
  if(function_81fac19d(!isDefined(soundobject), "snd_stop_on_ent_notify with undefined soundObject")) {
    return;
  }

  if(function_81fac19d(!isentity(notifyentity), "snd_stop_on_ent_notify notifyEntity is not an entity")) {
    return;
  }

  if(function_81fac19d(!isDefined(notifystring), "snd_stop_on_ent_notify with undefined levelNotifyString")) {
    return;
  }

  foreach(soundobj in function_f218bff5(soundobject)) {
    notifyentity thread function_7b540bad(soundobj, notifyentity, notifystring, fadeoutseconds);
  }
}

function function_f4f3a2a(soundobject, deathentity, fadeoutseconds) {
  if(function_81fac19d(!isDefined(soundobject), "snd_stop_on_ent_death with undefined soundObject")) {
    return;
  }

  if(function_81fac19d(!isDefined(deathentity), "snd_stop_on_ent_death with undefined linkedEntity")) {
    return;
  }

  foreach(soundobj in function_f218bff5(soundobject)) {
    deathentity thread function_7b540bad(soundobj, deathentity, "death", fadeoutseconds);
  }
}

function function_d4e10f97(soundobject, levelnotifystring, fadeoutseconds) {
  if(function_81fac19d(!isDefined(soundobject), "snd_stop_on_level_notify: undefined soundObject")) {
    return;
  }

  if(function_81fac19d(!isDefined(levelnotifystring), "snd_stop_on_level_notify: undefined levelNotifyString")) {
    return;
  }

  foreach(soundobj in function_f218bff5(soundobject)) {
    level thread function_78a6b95b(soundobj, levelnotifystring, fadeoutseconds);
  }
}

function function_2fdc4fb(soundobject) {
  if(function_81fac19d(!isDefined(soundobject), "snd_wait with undefined soundObject")) {
    return 0;
  }

  starttime = gettime();
  waittime = 0;

  while(true) {
    var_d4337e5 = 0;
    soundobjects = function_f218bff5(soundobject);
    arrayremovevalue(soundobjects, undefined);

    foreach(soundobj in soundobjects) {
      if(function_a6779cbd(soundobj)) {
        var_d4337e5 = 1;
        break;
      }
    }

    if(var_d4337e5 == 0) {
      break;
    }

    waitframe(1);
  }

  endtime = gettime();
  waittime = endtime - starttime;
  waittime /= 1000;
  return waittime;
}

function function_a6779cbd(soundobject) {
  if(isDefined(soundobject) && isDefined(soundobject.soundtype)) {
    return true;
  }

  return false;
}

function function_33560b93(targets) {
  sndobjs = [];

  foreach(target in function_f218bff5(targets)) {
    if(!isDefined(target)) {
      sndobjs = arraycombine(sndobjs, level._snd.var_3cc765a3);
      continue;
    }

    if(target == level) {
      sndobjs = arraycombine(sndobjs, level._snd.var_92f63ad0);
      continue;
    }

    if(isDefined(target.var_a415b6d6)) {
      sndobjs = arraycombine(sndobjs, target.var_a415b6d6);
    }
  }

  return sndobjs;
}

function function_8f5dfd03(soundalias, targets) {
  if(function_81fac19d(!isDefined(soundalias), "snd_get_alias_objects with undefined soundalias")) {
    return 0;
  }

  soundaliases = [];

  if(isarray(soundalias)) {
    foreach(alias in soundalias) {
      soundaliases[soundaliases.size] = tolower(alias);
    }
  } else if(isstring(soundalias)) {
    soundaliases = [tolower(soundalias)];
  }

  assert(isarray(soundaliases), "<dev string:x38>");
  soundobjects = function_33560b93(targets);
  aliasobjects = [];

  foreach(soundobj in soundobjects) {
    if(!isDefined(soundobj.soundalias)) {
      continue;
    }

    foreach(alias in soundaliases) {
      if(issubstr(tolower(soundobj.soundalias), alias)) {
        aliasobjects[aliasobjects.size] = soundobj;
      }
    }
  }

  return aliasobjects;
}

function function_880857eb(var_932dabe2) {
  var_932dabe2 = function_ea2f17d1(var_932dabe2, 1);

  if(!isDefined(level._snd.fnplaysoundonentity)) {
    level._snd.fnplaysoundonentity = level.fnplaysoundonentity;
    level._snd.fnplaysoundontag = level.fnplaysoundontag;
    level._snd.fnnotetrackprefixhandler = level.fnnotetrackprefixhandler;
    level._snd.var_2861a322 = level.animation.callbacks[# "playsoundatviewheight"];
  }

  if(var_932dabe2) {
    level.fnplaysoundonentity = &function_b7609ab;
    level.fnplaysoundontag = &function_e94a63b7;
    level.fnnotetrackprefixhandler = &function_95d9f208;
    level.animation.callbacks[# "playsoundatviewheight"] = &function_e9b666c7;
    return;
  }

  level.fnplaysoundonentity = level._snd.fnplaysoundonentity;
  level.fnplaysoundontag = level._snd.fnplaysoundontag;
  level.fnnotetrackprefixhandler = level._snd.fnnotetrackprefixhandler;
  level.animation.callbacks[# "playsoundatviewheight"] = level._snd.var_2861a322;
}

function get_volume(soundobject) {
  if(isDefined(level._snd._callbacks[# "volume_get"])) {
    return [[level._snd._callbacks[# "volume_get"]]](soundobject);
  }

  return 1;
}

function set_volume(soundobject, volume, timeinseconds, curve, callbackfunc) {
  if(isDefined(level._snd._callbacks[# "volume_set"])) {
    [[level._snd._callbacks[# "volume_set"]]](soundobject, volume, timeinseconds, curve, callbackfunc);
  }
}

function get_pitch(soundobject) {
  if(isDefined(level._snd._callbacks[# "pitch_get"])) {
    return [[level._snd._callbacks[# "pitch_get"]]](soundobject);
  }

  return 1;
}

function set_pitch(soundobject, pitch, timeinseconds, curve, callbackfunc) {
  if(isDefined(level._snd._callbacks[# "pitch_set"])) {
    [[level._snd._callbacks[# "pitch_set"]]](soundobject, pitch, timeinseconds, curve, callbackfunc);
  }
}

function function_ccb932f2() {
  if(is_true(level._snd.var_2dd09170)) {
    return # "gentity";
  }

  return # "centity";
}

function function_34595a23() {
  return level._snd.var_d37e94ca;
}

function function_793ba430(type) {
  type = function_ea2f17d1(type, function_ccb932f2());
  level._snd.var_d37e94ca = type_string(type);
}

function get_type(soundobject) {
  if(isDefined(soundobject.soundtype)) {
    return soundobject.soundtype;
  }

  return "";
}

function type_string(soundtype) {
  snd_type = undefined;

  switch (soundtype) {
    case 0:
    case # "entity":
    case # "e":
    case # "ent":
      snd_type = # "gentity";
      break;
    case 1:
    case # "centity":
    case # "c":
    case # "cent":
      snd_type = # "centity";
      break;
    case # "emitter":
      snd_type = # "emitter";
      break;
    default:
      snd_type = undefined;
      break;
  }

  assert(isDefined(snd_type), "<dev string:x6f>" + soundtype);
  return snd_type;
}

function private function_aaee1de3(snd_type, snd_key, item) {
  assert(isDefined(level._snd), "<dev string:x90>");
  assert(isDefined(level._snd.var_3cc765a3), "<dev string:x90>");

  switch (snd_type) {
    default:
      assert(0, "<dev string:xab>");
      break;
    case # "centity":
    case # "gentity":
      level._snd.var_3cc765a3[snd_key] = item;
      break;
  }
}

function private function_7e9752b7(snd_type, snd_key, item) {
  assert(isDefined(level._snd), "<dev string:x90>");
  assert(isDefined(level._snd.var_3cc765a3), "<dev string:x90>");

  switch (snd_type) {
    default:
      assert(0, "<dev string:xab>");
      break;
    case # "centity":
    case # "gentity":
      assert(isinarray(level._snd.var_3cc765a3, item), "<dev string:xbf>");
      level._snd.var_3cc765a3[snd_key] = undefined;
      break;
  }
}

function private function_e12570db() {
  snd_type = self.soundtype;
  snd_key = self.soundkey;
  self waittill(#"death");
  function_7e9752b7(snd_type, snd_key, self);
}

function private function_9a3d9ff2(soundarg) {
  delaytime = 0;
  soundalias = undefined;
  fadeinseconds = undefined;

  if(isarray(soundarg)) {
    keys = soundarg;
    soundalias = undefined;
    aliasindex = keys.size + 1;

    for(i = 0; i < keys.size; i++) {
      key = keys[i];

      if(isstring(key)) {
        soundalias = key;
        aliasindex = i;
      }

      if(isnumber(key) && i < aliasindex) {
        delaytime = key;
      }

      if(isnumber(key) && i > aliasindex) {
        fadeinseconds = key;
      }
    }
  } else if(isstring(soundarg)) {
    soundalias = soundarg;
  }

  sndparam = array(delaytime, soundalias, fadeinseconds);
  return sndparam;
}

function private function_75a3b79f(targ) {
  targets = [];

  if(!isDefined(targ)) {
    foreach(player in getplayerssafe()) {
      tagname = player function_bf7c949("j_head");

      if(player.model != "" && tagname != "") {
        targets[targets.size] = [player, tagname];
        continue;
      }

      targets[targets.size] = player;
    }
  } else if(isarray(targ)) {
    if(function_81fac19d(targ.size == 0, "snd: zero-sized array used for targ")) {
      return undefined;
    } else if(targ.size == 2) {
      if(isentity(targ[0]) && isstring(targ[1])) {
        targets = [targ];
      } else if(isentity(targ[0]) && isvec(targ[1])) {
        targets = [targ];
      } else if(isentity(targ[0]) && !isDefined(targ[1])) {
        targets = [targ[0]];
      } else if(isstring(targ[0]) && isstring(targ[1])) {
        firsttargets = gettargetnames(targ[0]);
        secondtargets = gettargetnames(targ[1]);
        targets = arraycombine(firsttargets, secondtargets);
      } else {
        targets = targ;
      }
    } else {
      targets = [];

      foreach(key in targ) {
        if(isentity(key) || isstruct(key) && isDefined(key.origin) || isvec(key) || isarray(key)) {
          targets[targets.size] = key;
          continue;
        }

        if(isstring(key)) {
          tnames = gettargetnames(key);

          foreach(t in tnames) {
            targets[targets.size] = t;
          }
        }
      }
    }
  } else if(isstring(targ)) {
    targets = gettargetnames(targ);
  } else {
    targets = [targ];
  }

  return targets;
}

function private function_2639b80c(soundtype, soundalias, var_9ab0e73a) {
  if(function_81fac19d(!did_init(), "snd was not initialized!")) {
    if(function_f984063f()) {
      debugbreak();
    }

    return undefined;
  }

  if(function_81fac19d(!isDefined(soundalias), "snd_play: sound alias undefined")) {
    return undefined;
  }

  level._snd._callbacks[# "stop"] = &stop;
  assert(isDefined(level._snd.var_d37e94ca), "<dev string:x90>");
  soundtype = function_ea2f17d1(soundtype, level._snd.var_d37e94ca);
  soundobjects = [];
  targets = [];
  soundparam = function_9a3d9ff2(soundalias);
  assert(isarray(soundparam) && soundparam.size == 3, "<dev string:xe5>");
  delaytime = soundparam[0];
  soundalias = soundparam[1];
  fadeinseconds = soundparam[2];
  initialvolume = undefined;

  if(function_81fac19d(isstring(soundalias) && soundalias == "", "snd_play: empty sound alias \"\"")) {
    return undefined;
  }

  assert(isstring(soundalias) || ishash(soundalias), "<dev string:x102>");
  islooping = soundislooping(soundalias);
  sndexists = soundexists(soundalias);

  if(function_81fac19d(!sndexists, "snd: sound alias '" + soundalias + "' does not exist!")) {
    if(function_f984063f()) {
      debugbreak();
    }

    return undefined;
  }

  if(!isDefined(fadeinseconds)) {
    if(islooping) {
      fadeinseconds = level._snd.var_90903fc0;
    } else {
      fadeinseconds = 0;
    }
  }

  if(isDefined(fadeinseconds) && fadeinseconds > 0) {
    initialvolume = 0;
  }

  assert(isDefined(fadeinseconds));
  targets = function_75a3b79f(var_9ab0e73a);

  if(function_81fac19d(!isDefined(targets), "snd: undefined targets")) {
    return undefined;
  }

  foreach(t in targets) {
    linkedentity = undefined;
    var_e330010e = undefined;
    var_1d25915 = undefined;
    soundobject = undefined;
    ise = isentity(t);
    isr = function_3132f113(t);
    iss = isstruct(t);
    isv = isvec(t);
    isn = isstring(t);
    isa = isarray(t);

    if(ise) {
      linkedentity = t;
      var_1d25915 = (0, 0, 0);
    } else if(function_81fac19d(isr, "snd: could not play on removed entity")) {
      continue;
    } else if(iss) {
      if(function_81fac19d(!isDefined(t.origin), "snd: sound alias '" + soundalias + "' played on struct with no origin!")) {
        continue;
      } else {
        var_1d25915 = t.origin;
      }
    } else if(isv) {
      var_1d25915 = t;
    } else if(isn) {} else if(isarray(t)) {
      if(!isDefined(t[0]) || function_3132f113(t[0])) {
        continue;
      } else if(isentity(t[0]) && isstring(t[1])) {
        linkedentity = t[0];
        var_e330010e = t[1];
        var_1d25915 = (0, 0, 0);
      } else if(isentity(t[0]) && isvec(t[1])) {
        linkedentity = t[0];
        var_1d25915 = t[1];
      } else if(function_81fac19d(1, "snd: unexpected target array combination")) {}
    }

    switch (soundtype) {
      default:
        assert(0, "<dev string:x11f>");
        break;
      case # "gentity":
        soundobject = namespace_afa8e18b::function_85daf9f0(soundalias, var_1d25915, linkedentity, var_e330010e);

        if(isentity(soundobject)) {
          namespace_afa8e18b::function_b5959278(soundobject, var_1d25915, linkedentity, var_e330010e);
          function_aaee1de3(#"gentity", soundobject.soundkey, soundobject);
          soundobject thread function_e12570db();
        }

        break;
      case # "centity":
        soundobject = namespace_afa8e18b::function_5275752c(soundalias, var_1d25915, linkedentity, var_e330010e);

        if(isentity(soundobject)) {
          namespace_afa8e18b::function_2761fc04(soundobject, var_1d25915, linkedentity, var_e330010e);
          function_aaee1de3(#"centity", soundobject.soundkey, soundobject);
          soundobject thread function_e12570db();
        }

        break;
    }

    if(isDefined(soundobject) && function_a6779cbd(soundobject)) {
      switch (soundtype) {
        case # "gentity":
        default:
          soundobject thread namespace_afa8e18b::function_2dde45d9(soundobject, soundalias, initialvolume, delaytime);
          break;
        case # "centity":
          soundobject thread namespace_afa8e18b::function_bb749fc3(soundobject, soundalias, initialvolume, delaytime);
          break;
      }

      if(fadeinseconds > 0) {
        if(soundtype == # "gentity" && isDefined(linkedentity)) {
          delaytime += 0.05;
        }

        soundobject thread function_6f736cc1(soundobject, fadeinseconds, delaytime);
      }

      soundobjects[soundobjects.size] = soundobject;
    }
  }

  if(function_81fac19d(soundobjects.size == 0, "snd: zero sound objects played")) {
    return undefined;
  }

  return function_31bcd153(soundobjects);
}

function private function_f937a6f7(soundobject, fadeoutseconds) {
  if(function_81fac19d(!isDefined(level._snd) || !isDefined(level._snd.var_d37e94ca), "snd was not initialized")) {
    return;
  }

  if(function_81fac19d(!isDefined(soundobject) || function_3132f113(soundobject), "snd_stop with undefined soundObject")) {
    return;
  }

  if(function_81fac19d(!isDefined(soundobject.soundtype), "snd_stop with unknown type")) {
    return;
  }

  assert(isDefined(level._snd.var_d37e94ca), "<dev string:x90>");
  assert(isDefined(soundobject), "<dev string:x139>");
  assert(isDefined(soundobject.soundtype), "<dev string:x163>");

  if(soundobject.soundtype == # "emitter") {
    soundobject notify(#"snd_emitter_stop");
    soundobject.soundtype = undefined;
    soundobject.soundalias = undefined;
    soundobject.var_90c86b97 = undefined;
    soundobject.origin = undefined;
    soundobject.angles = undefined;
    return;
  }

  soundobject endon(#"death");
  soundtype = soundobject.soundtype;
  soundalias = soundobject.soundalias;

  if(isDefined(soundalias) && soundislooping(soundobject.soundalias) && !isDefined(fadeoutseconds)) {
    fadeoutseconds = level._snd.var_90903fc0;
  }

  if(isDefined(soundalias) && isDefined(fadeoutseconds) && is_true(level._snd.var_8c37ff34)) {
    set_volume(soundobject, 0, fadeoutseconds);
    wait fadeoutseconds;
    waitframe(1);

    if(function_3132f113(soundobject)) {
      return;
    }
  }

  switch (soundtype) {
    case # "gentity":
    default:
      namespace_afa8e18b::function_9f156b27(soundobject, fadeoutseconds);
      break;
    case # "centity":
      namespace_afa8e18b::function_273d939b(soundobject, fadeoutseconds);
      break;
  }
}

function private function_7b540bad(soundobject, notifyentity, notifystring, fadeoutseconds) {
  soundobject endon(#"death");
  notifyentity waittill(#"death", notifystring);
  function_f937a6f7(soundobject, fadeoutseconds);
}

function private function_78a6b95b(soundobject, levelnotifystring, fadeoutseconds) {
  soundobject endon(#"death");
  level waittill(levelnotifystring);
  function_f937a6f7(soundobject, fadeoutseconds);
}

function private function_6f736cc1(soundobject, fadeinseconds, delaytime) {
  if(function_81fac19d(!isDefined(soundobject) || function_3132f113(soundobject), "snd: fade in on deleted gentity!")) {
    return;
  }

  assert(isDefined(soundobject));
  soundobject endon(#"death");
  soundobject endon(#"hash_501fa67f084af993");
  delaytime = function_ea2f17d1(delaytime, 0);
  set_volume(soundobject, 0, 0);

  if(delaytime > 0) {
    wait delaytime;
  }

  set_volume(soundobject, 1, fadeinseconds);
}

function private function_5eb4c6d(target) {
  position = undefined;

  if(isplayersafe(target)) {
    position = target getplayervieworigin();
  } else if(!function_3132f113(target) && isDefined(target.origin)) {
    position = target.origin;
  } else if(isvec(target) == 1) {
    position = target;
  } else {
    assert(0);
  }

  assert(isvec(position) == 1, "<dev string:x17c>");
  return position;
}

function private function_cdc85ae5(rotationrange) {
  var_3c67b910 = randomfloatrange(-180, 180);
  rotation = 0;

  if(isarray(rotationrange)) {
    if(rotationrange.size == 1) {
      rotationrange = rotationrange[0];
    } else if(rotationrange.size == 2) {
      rotation = rangehelper(rotationrange);
    } else if(rotationrange.size == 3) {
      var_3c67b910 = rotationrange[0];
      rotation = rangehelper(rotationrange);
      var_9b234989 = [rotationrange[1], rotationrange[2]];
      rotation = rangehelper(var_9b234989);
    } else if(rotationrange.size >= 4) {
      var_e0d0816c = [rotationrange[0], rotationrange[1]];
      var_3c67b910 = rangehelper(var_e0d0816c);
      var_9b234989 = [rotationrange[2], rotationrange[3]];
      rotation = rangehelper(var_9b234989);
    }
  }

  if(isnumber(rotationrange) && rotationrange != 0) {
    absrotation = abs(rotationrange);
    min = -1 * absrotation;
    max = absrotation;
    rotation = randomfloatrange(min, max);
  }

  return array(var_3c67b910, rotation);
}

function private function_1ce48d0f(target, dist, var_3c67b910, elevation, rotation) {
  self endon(#"death");
  self endon(#"sounddone");

  if(isDefined(rotation) == 0 || rotation == 0) {
    return;
  }

  assert(isentity(target) || isstruct(target) && isDefined(target.origin) || isvec(target), "<dev string:x1a9>");
  assert(isnumber(dist), "<dev string:x1a9>");
  assert(isnumber(var_3c67b910), "<dev string:x1a9>");
  assert(isnumber(rotation), "<dev string:x1a9>");

  if(function_95c9af4b() > 2) {
    randred = randomfloat(1);
    randgreen = randomfloat(1);
    randblue = randomfloat(1);
    randomcolor = (randred, randgreen, randblue);
    randomcolor = vectornormalize(randomcolor);
    snd_drawpath(self, randomcolor);
  }

  movetime = function_6cfa7975() * 3;
  rotationstep = rotation * movetime;
  centerorigin = function_5eb4c6d(target);

  while(isentity(self) && isDefined(target) && isDefined(target.origin)) {
    centerorigin = function_5eb4c6d(target);
    position = function_160366e9(centerorigin, dist, var_3c67b910, elevation);
    self moveto(position, movetime, 0, 0);
    var_3c67b910 += rotationstep;
    wait movetime;
  }
}

function private function_d1e7d514(emitter) {
  iss = isstruct(emitter);
  hast = isDefined(emitter.soundtype);
  ist = emitter.soundtype == # "emitter";
  is_emitter = iss && hast && ist;

  if(function_81fac19d(is_emitter == 0, "snd emitter stop not an emitter")) {
    return;
  }

  assert(isDefined(emitter.soundkey), "<dev string:x1ad>");
  assert(isDefined(level._snd.var_9e1f6b3e), "<dev string:x1cd>");
  assert(isDefined(level._snd.var_90a7c764), "<dev string:x1ec>");
  level._snd.var_90a7c764[emitter.soundkey] = undefined;
  emitter notify(#"snd_emitter_stop");
  emitter.soundtype = undefined;
  emitter.soundalias = undefined;
  emitter.var_90c86b97 = undefined;
  emitter.origin = undefined;
  emitter.angles = undefined;
  emitter = undefined;
}

function private function_dcc0344(soundalias, target, spawntimerange, distancerange, rotationrange, var_ad8975b4) {
  self endon(#"snd_emitter_stop");
  level endon(#"snd_emitter_stop");
  assert(isDefined(target) && isarray(target) == 0, "<dev string:x212>");

  if(isvec(target)) {
    target = self;
  }

  targetposition = undefined;
  position = undefined;
  dist = rangehelper(function_ea2f17d1(distancerange, 0));
  var_a7685aa3 = function_cdc85ae5(rotationrange);
  assert(isarray(var_a7685aa3) && var_a7685aa3.size != 0);
  var_3c67b910 = var_a7685aa3[0];
  rotation = var_a7685aa3[1];
  elevation = rangehelper(function_ea2f17d1(var_ad8975b4, 0));

  if(isarray(spawntimerange) && spawntimerange.size >= 4) {
    assert(spawntimerange.size == 4, "<dev string:x241>");
    var_f9baa88 = [spawntimerange[0], spawntimerange[1]];
    spawntime = rangehelper(var_f9baa88, 0.05);
    wait spawntime;
    targetposition = function_5eb4c6d(target);
    position = function_160366e9(targetposition, dist, var_3c67b910, elevation);
    sndobj = play(soundalias, position);

    if(isDefined(sndobj) && isDefined(dist) && dist > 0 && isDefined(rotation) && rotation != 0) {
      sndobj thread function_1ce48d0f(target, dist, var_3c67b910, rotation);
      spawntimerange = [spawntimerange[2], spawntimerange[3]];
    }
  }

  while(true) {
    spawntime = rangehelper(spawntimerange, 0.05);
    wait spawntime;

    if(!isDefined(target)) {
      break;
    }

    dist = rangehelper(function_ea2f17d1(distancerange, 0));
    var_a7685aa3 = function_cdc85ae5(rotationrange);
    assert(isarray(var_a7685aa3) && var_a7685aa3.size != 0);
    var_3c67b910 = var_a7685aa3[0];
    rotation = var_a7685aa3[1];
    elevation = rangehelper(function_ea2f17d1(var_ad8975b4, 0));
    targetposition = function_5eb4c6d(target);
    position = function_160366e9(targetposition, dist, var_3c67b910, elevation);
    sndobj = play(soundalias, position);

    if(isDefined(sndobj) && isDefined(dist) && dist > 0 && isDefined(rotation) && rotation != 0) {
      sndobj thread function_1ce48d0f(target, dist, var_3c67b910, elevation, rotation);
    }
  }
}

function emitter(soundalias, target, spawntime, distancerange, rotation, elevation) {
  emitters = [];
  targets = target;
  islooping = soundislooping(soundalias);
  isexists = isDefined(islooping);

  if(function_81fac19d(!isexists, "snd_emitter soundalias does not exist: " + soundalias)) {
    return undefined;
  }

  if(function_81fac19d(islooping, "snd_emitter cannot emit looping alias: " + soundalias)) {
    return undefined;
  }

  if(!isDefined(level._snd.var_9e1f6b3e)) {
    level._snd.var_9e1f6b3e = 1792;
    level._snd.var_90a7c764 = [];
  }

  assert(isDefined(level._snd.var_9e1f6b3e), "<dev string:x1cd>");
  assert(soundexists(soundalias), "<dev string:x28a>" + soundalias);
  assert(isDefined(target), "<dev string:x2b5>");
  assert(isDefined(spawntime), "<dev string:x2d8>");

  if(isarray(targets) == 0) {
    targets = [target];
  }

  foreach(t in targets) {
    ise = isentity(t);
    isv = isvec(t);

    if(ise || isv) {
      emitter = spawnStruct();
      emitter.soundtype = # "emitter";
      emitter.soundalias = soundalias;
      emitter.spawntime = spawntime;
      emitter.distancerange = distancerange;
      emitter.rotation = rotation;
      emitter.elevation = elevation;
      level._snd.var_9e1f6b3e = int(level._snd.var_9e1f6b3e + 1);
      emitter.soundkey = "" + level._snd.var_9e1f6b3e;
      level._snd.var_90a7c764[emitter.soundkey] = emitter;

      if(ise) {
        emitter.var_90c86b97 = t;
      }

      if(isv) {
        emitter.origin = t;
        emitter.angles = (0, 0, 0);
      }

      emitter thread function_dcc0344(soundalias, t, spawntime, distancerange, rotation, elevation);
      emitters[emitters.size] = emitter;
      continue;
    }

    function_81fac19d(ise == 0 && isv == 0, "snd_emitter target '" + t + "' was not an entity or vector.");
  }

  function_81fac19d(emitters.size == 0, "snd_emitter resulted in zero emitter targets");
  return function_31bcd153(emitters);
}

function private function_e94a63b7(alias, tag, ends_on_death, var_50bba55f, radio_dialog) {
  if(!isalive(self)) {
    return;
  }

  target = [self, ends_on_death];
  snd = function_2639b80c(level._snd.var_d37e94ca, tag, target);

  if(isDefined(level.player_radio_emitter) && self == level.player_radio_emitter) {
    println("<dev string:x2fe>" + tag);
  }

  if(isDefined(var_50bba55f)) {
    assert(var_50bba55f, "<dev string:x320>");
    function_f4f3a2a(snd, self);
  }

  function_2fdc4fb(snd);

  if(isDefined(radio_dialog)) {
    self notify(radio_dialog);
  }
}

function private function_b7609ab(alias, var_50bba55f) {
  self function_e94a63b7(alias, undefined, undefined, var_50bba55f);
}

function private function_e9b666c7(soundalias, notifystring, var_741da363) {
  var_741da363 = function_ea2f17d1(var_741da363, 0);

  if(!isalive(self)) {
    return;
  }

  target = [self, "j_head"];
  snd = function_2639b80c(level._snd.var_d37e94ca, soundalias, target);

  if(var_741da363) {
    function_f4f3a2a(snd, self);
  }

  if(isDefined(notifystring)) {
    self thread function_61c048e7(snd, notifystring);
  }
}

function private function_61c048e7(snd, notifystring) {
  function_2fdc4fb(snd);
  self notify(notifystring);
}

function private function_95d9f208(notetrack) {
  prefix = getsubstr(notetrack, 0, 3);

  if(prefix == "ps_") {
    alias = getsubstr(notetrack, 3);
    params = strtok(alias, ",");

    if(params.size < 2) {
      self thread function_e94a63b7(alias, undefined, 1);
    } else {
      self thread function_e94a63b7(params[0], params[1], 1);
    }

    return 1;
  }

  if(prefix == "vo_") {
    alias = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](alias, "j_head", 1);
    } else {
      self thread function_e94a63b7(alias, "j_head", 1, alias);
    }

    return 1;
  }

  if(isDefined(level._snd.fnnotetrackprefixhandler)) {
    return self[[level._snd.fnnotetrackprefixhandler]](notetrack);
  }

  return 0;
}

function function_13b51154(curve, size) {
  lut = [];
  step = 1 / (size - 1);

  for(i = 0; i < size; i++) {
    x = i * step;
    y = 0;

    switch (curve) {
      default:
        assert(0);
        break;
      case # "default_vfcurve":
      case # "linear":
        lut[0] = 0;
        lut[1] = 1;
        return lut;
      case # "sine":
        y = 0.5 + cos(x * 180) * -0.5;
      case # "easein":
        y = 1 - cos(x * 90);
        break;
      case # "easeout":
        y = sin(x * 90);
        break;
      case # "easeinout":
        y = 3 * pow(x, 2) - 2 * pow(x, 3);
        break;
      case # "circularin":
        y = 1 - sqrt(1 - x * x);
        break;
      case # "circularout":
        y = sqrt(1 - (1 - x) * (1 - x));
        break;
      case # "exponential_40db":
        lut[0] = 0;
        lut[1] = 0.0158489;
        lut[2] = 0.0251189;
        lut[3] = 0.0398107;
        lut[4] = 0.0630957;
        lut[5] = 0.1;
        lut[6] = 0.158489;
        lut[7] = 0.251189;
        lut[8] = 0.398107;
        lut[9] = 0.630957;
        lut[10] = 1;
        return lut;
      case # "exponential_60db":
        lut[0] = 0;
        lut[1] = 1.97531e-05;
        lut[2] = 0.000316049;
        lut[3] = 0.0016;
        lut[4] = 0.00505679;
        lut[5] = 0.0123457;
        lut[6] = 0.0256;
        lut[7] = 0.0474272;
        lut[8] = 0.0809086;
        lut[9] = 0.1296;
        lut[10] = 0.197531;
        lut[11] = 0.289205;
        lut[12] = 0.4096;
        lut[13] = 0.564168;
        lut[14] = 0.758835;
        lut[15] = 1;
        return lut;
    }

    lut[lut.size] = y;
  }

  return lut;
}

function function_3ffa0089(size) {
  size = function_ea2f17d1(size, 11);
  level.var_c386bd24 = [];
  level.var_c386bd24[# "linear"] = function_13b51154("linear", size);
  level.var_c386bd24[# "sine"] = function_13b51154("sine", size);
  level.var_c386bd24[# "easein"] = function_13b51154("easein", size);
  level.var_c386bd24[# "easeout"] = function_13b51154("easeout", size);
  level.var_c386bd24[# "easeinout"] = function_13b51154("easeinout", size);
  level.var_c386bd24[# "circularin"] = function_13b51154("circularin", size);
  level.var_c386bd24[# "circularout"] = function_13b51154("circularout", size);
  level.var_c386bd24[# "exponential_40db"] = function_13b51154("exponential_40db", size);
  level.var_c386bd24[# "exponential_60db"] = function_13b51154("exponential_60db", size);
  level.var_c386bd24[# "default_vfcurve"] = function_13b51154("default_vfcurve", size);
}

function private function_d3f407d6(alias) {
  if(isDefined(alias) == 0) {
    return "easeout";
  }

  switch (alias) {
    case # "xfade":
      return "easeout";
  }

  return alias;
}

function function_fc955f31(curve) {
  lut = level.var_c386bd24[function_d3f407d6(curve)];

  if(isDefined(lut)) {
    return lut.size;
  }

  return 0;
}

function function_9020a959(curve) {
  lut = level.var_c386bd24[curve];

  if(isDefined(lut)) {
    return true;
  }

  return false;
}

function function_b918d683(inval, curve) {
  curve = function_d3f407d6(curve);
  lut = level.var_c386bd24[curve];
  assert(isDefined(lut), "<dev string:x34b>" + curve);
  inval = math::clamp(inval, 0, 1);
  outval = 0;
  step = 1 / (lut.size - 1);

  if(inval == 0) {
    return 0;
  }

  if(inval == 1) {
    return 1;
  }

  for(i = 0; i < lut.size; i++) {
    stepx = i * step;
    stepn = (i + 1) * step;

    if(inval >= stepx && inval <= stepn) {
      diffx = inval - stepx;
      diffn = stepn - stepx;
      diff = diffx / diffn;
      valx = lut[i];
      valn = lut[i + 1];
      valdiff = valn - valx;
      outval = valx + valdiff * diff;
      break;
    }
  }

  return outval;
}

function private function_bc4f45dd(name) {
  if(isDefined(self.var_3dc056c0) == 0) {
    return;
  }

  if(isDefined(name)) {
    if(isDefined(self.var_3dc056c0[name])) {
      if(isDefined(self.var_3dc056c0[name].stopcallback)) {
        self[[self.var_3dc056c0[name].stopcallback]](self.var_3dc056c0[name].userdata);
      }

      self.var_3dc056c0[name] = undefined;
    }
  } else {
    foreach(p in self.var_3dc056c0) {
      if(isDefined(p.stopcallback)) {
        self[[p.stopcallback]](p.userdata);
      }

      self.var_3dc056c0 = undefined;
    }
  }

  if(isDefined(self.var_3dc056c0) == 0 || self.var_3dc056c0.size == 0) {
    arrayremovevalue(level.var_ba9b4ed, self, 1);
    arrayremovevalue(level.var_ba9b4ed, undefined, 1);
    self.var_3dc056c0 = undefined;
    self.var_b7790cd8 = undefined;
    self notify(#"param_stop");
  }
}

function private function_edd37e50() {
  self endon(#"param_stop");
  self waittill(#"death", #"disconnect");
  self function_bc4f45dd();
}

function private function_8eaaf665() {
  if(isDefined(self.var_b7790cd8)) {
    return;
  }

  self.var_b7790cd8 = 1;
  self thread function_edd37e50();
  self endon(#"disconnect");
  self endon(#"param_stop");

  while(function_3132f113(self) == 0 && isDefined(self.var_3dc056c0) && self.var_3dc056c0.size > 0) {
    now = gettime();

    foreach(p in self.var_3dc056c0) {
      p.isprocessing = 1;

      if(isDefined(p.inputcallback)) {
        assert(isentity(self), "<dev string:x37c>");
        p.inputvalue = self[[p.inputcallback]](p.userdata);
        assert(gettime() == now, "<dev string:x3c2>");
      }

      if(isDefined(p.outputcallbacks)) {
        if(p.userdata.size > 0) {
          assert(p.outputcallbacks.size == p.userdata.size, "<dev string:x3fb>");
        }

        foreach(index, outputcallback in p.outputcallbacks) {
          if(isentity(self)) {
            userdata = undefined;

            if(p.userdata.size > 0) {
              userdata = p.userdata[index];
            }

            self thread[[outputcallback]](p.inputvalue, userdata);
          }
        }
      }

      p.isprocessing = undefined;
    }

    waitframe(1);
  }

  if(function_3132f113(self)) {
    self function_bc4f45dd();
  }
}

function private function_ef12a0f5(name) {
  if(isDefined(level.var_ba9b4ed) == 0) {
    level.var_ba9b4ed = [];
  }

  assert(isarray(level.var_ba9b4ed), "<dev string:x42c>");

  if(isDefined(self.var_3dc056c0) == 0) {
    self.var_3dc056c0 = [];
  }

  assert(isarray(self.var_3dc056c0), "<dev string:x452>");

  if(isDefined(self.var_3dc056c0[name]) == 0) {
    self.var_3dc056c0[name] = spawnStruct();
  }

  if(isinarray(level.var_ba9b4ed, self) == 0) {
    level.var_ba9b4ed[level.var_ba9b4ed.size] = self;
  }
}

function function_67f723dd(name, inputcallback) {
  self function_ef12a0f5(name);
  self.var_3dc056c0[name].inputcallback = inputcallback;
  self.var_3dc056c0[name].inputvalue = undefined;
  self thread function_8eaaf665();
}

function function_fae704b2(name, outputcallback, userdata) {
  self function_ef12a0f5(name);

  if(isDefined(self.var_3dc056c0[name].outputcallbacks) == 0) {
    self.var_3dc056c0[name].outputcallbacks = [];
  }

  assert(isDefined(self.var_3dc056c0[name]), "<dev string:x479>" + name + "<dev string:x48e>");
  assert(isDefined(self.var_3dc056c0[name].outputcallbacks), "<dev string:x452>");
  assert(isarray(self.var_3dc056c0[name].outputcallbacks), "<dev string:x452>");
  var_68ec0ce1 = self.var_3dc056c0[name].outputcallbacks.size;
  self.var_3dc056c0[name].outputcallbacks[var_68ec0ce1] = outputcallback;

  if(isDefined(self.var_3dc056c0[name].userdata) == 0) {
    self.var_3dc056c0[name].userdata = [];
  }

  if(isinarray(self.var_3dc056c0[name].userdata, userdata) == 0) {
    userdataindex = self.var_3dc056c0[name].userdata.size;
    self.var_3dc056c0[name].userdata[userdataindex] = userdata;
  } else {
    if(function_d78e3644()) {
      debugbreak();
    }
  }

  self thread function_8eaaf665();
}

function private function_cb11f45c(name, startcallback, stopcallback) {
  self function_ef12a0f5(name);
  self.var_3dc056c0[name].startcallback = startcallback;
  self.var_3dc056c0[name].stopcallback = stopcallback;

  if(isDefined(self.var_3dc056c0[name].startcallback)) {
    self[[self.var_3dc056c0[name].startcallback]]();
  }
}

function function_79d9c57d(name) {
  self function_bc4f45dd(name);
}

function snd_param(name, startcallback, inputcallback, outputcallback, stopcallback, userdata) {
  self function_cb11f45c(name, startcallback, stopcallback);
  self function_67f723dd(name, inputcallback);
  self function_fae704b2(name, outputcallback, userdata);
}

function function_e6dfc446(name) {
  if(isDefined(self.var_3dc056c0) && isDefined(self.var_3dc056c0[name]) && isDefined(self.var_3dc056c0[name].inputcallback)) {
    p = self.var_3dc056c0[name];

    if(isDefined(p.inputvalue)) {
      return p.inputvalue;
    } else {
      return self[[p.inputcallback]](p.userdata);
    }
  }

  return undefined;
}

function function_e74190aa(name) {
  if(isDefined(self.var_3dc056c0) && isarray(self.var_3dc056c0) && isDefined(self.var_3dc056c0[name])) {
    return true;
  }

  return false;
}

function function_e94ea06d(inputcallback) {
  if(isDefined(self.var_3dc056c0) && isarray(self.var_3dc056c0)) {
    foreach(p in self.var_3dc056c0) {
      if(p.inputcallback == inputcallback) {
        return true;
      }
    }
  }

  return false;
}

function function_c0e3d9aa(userdata) {
  assert(isDefined(self.origin));
  now = gettime();

  if(isDefined(self.origin_velocity_time) && self.origin_velocity_time == now) {
    assert(isDefined(self.origin_velocity));
    return self.origin_velocity;
  }

  if(isDefined(self.origin_last) == 0) {
    self.origin_last = self.origin;
  }

  if(isentity(self)) {
    self.origin_velocity = 0.0166667 * self getvelocity();
  } else {
    self.origin_velocity = self.origin - self.origin_last;
  }

  self.origin_velocity_time = now;
  self.origin_last = self.origin;
  return self.origin_velocity;
}

function function_8764d0b2(userdata) {
  assert(isDefined(self.origin));
  velocity = self function_c0e3d9aa();
  self.origin_speed = length(velocity);

  if(function_95c9af4b() >= 2) {
    debugspeed = self.origin_speed;

    if(debugspeed < 0.001) {
      debugspeed = 0;
    }

    var_38f9ec40 = function_d6053a8f(debugspeed * function_869cb8c6() * 0.0568182, 1) + "<dev string:x4ad>" + function_d6053a8f(debugspeed, 1) + "<dev string:x4b8>";
    debugcolor = getdvarvector(#"hash_3b9f89c8082a9915", (1, 1, 1));
    debugalpha = 0.9;
    var_74500ef = debugalpha * debugalpha;
    debugscale = getdvarfloat(#"hash_182296346d138cf8");
    colorscale = getdvarfloat(#"hash_3944b771315157c1", 1);
    debugcolor = function_2677a7e2(debugcolor, colorscale * 10);
    debugframes = 1;
    debugoffset = (0, 0, 4 * debugscale * 24);
    print3dplus(var_38f9ec40, self.origin + debugoffset, -1 * debugscale, "<dev string:x4c0>", debugcolor, debugalpha, (0, 0, 0), var_74500ef, (1, 1, 1), var_74500ef, debugframes);
  }

  return self.origin_speed;
}

function function_29584494(userdata) {
  assert(isDefined(self.angles));
  now = gettime();

  if(isDefined(self.angle_time) && self.angle_time == now) {
    assert(isDefined(self.var_c60cbb0f));
    return self.var_c60cbb0f;
  }

  angles = self.angles;

  if(isplayersafe(self)) {
    angles = self getplayerviewangles();
  } else if(isDefined(self.model)) {
    hastag = 0;

    if(hastag == 0) {
      angles = self gettagangles("tag_origin");
    }
  }

  if(angles[0] > 180) {
    angles -= (360, 0, 0);
  }

  if(angles[1] > 180) {
    angles -= (0, 360, 0);
  }

  if(angles[2] > 180) {
    angles -= (0, 0, 360);
  }

  if(isDefined(self.var_c60cbb0f) == 0) {
    self.var_c60cbb0f = angles;
  }

  if(isDefined(self.var_7ebe209e) == 0) {
    self.var_7ebe209e = angles;
  }

  self.var_7ebe209e = self.var_c60cbb0f;
  self.var_c60cbb0f = angles;
  return self.var_c60cbb0f;
}

function function_cf6a940f(userdata) {
  angles = function_29584494(userdata);
  self.var_1536fabb = angles - self.var_7ebe209e;
  return self.var_1536fabb;
}

function private function_cebd7215(var_67f427c4, initialvolume, initialpitch) {
  var_67f427c4.snd = play(var_67f427c4.soundalias, var_67f427c4.target);
  set_volume(var_67f427c4.snd, initialvolume, 0);
  set_pitch(var_67f427c4.snd, initialpitch, 0);
}

function private function_a3ee9bec(var_67f427c4, fadetime, fadecurve) {
  if(isDefined(var_67f427c4) && isDefined(var_67f427c4.snd)) {
    fadetime = function_ea2f17d1(fadetime, 0);
    fadecurve = function_ea2f17d1(fadecurve, "easeinout");

    if(isDefined(fadetime) == 1 && fadetime > 0) {
      set_volume(var_67f427c4.snd, 0, fadetime, fadecurve);
      wait fadetime;
    }

    stop(var_67f427c4.snd);
    var_67f427c4.snd = undefined;
  }
}

function private function_a04fdd(inputvalue, userdata) {
  speed = inputvalue;
  v = userdata;

  if(speed < 0.01) {
    speed = 0;
  }

  var_53970876 = v.var_4da05e4e[# "speed"][0];
  var_56df0922 = v.var_4da05e4e[# "speed"][1];
  var_29305831 = v.var_4da05e4e[# "scale"][0];
  var_2b905459 = v.var_4da05e4e[# "scale"][1];
  volumecurve = v.var_4da05e4e[# "curve"][0];
  var_96fa4b31 = v.var_5c76982f[# "speed"][0];
  var_8d892f33 = v.var_5c76982f[# "speed"][1];
  var_f670290f = v.var_5c76982f[# "scale"][0];
  var_2f163596 = v.var_5c76982f[# "scale"][1];
  pitchcurve = v.var_5c76982f[# "curve"][0];
  volume = scalerp(speed, var_53970876, var_56df0922, var_29305831, var_2b905459);
  pitch = scalerp(speed, var_96fa4b31, var_8d892f33, var_f670290f, var_2f163596);

  if(isDefined(v.snd) == 1 && volume <= 0.001) {
    self thread function_a3ee9bec(v);
    return;
  } else if(isDefined(v.snd) == 0 && volume > 0.001) {
    function_cebd7215(v, volume, pitch);
    v.var_ca7e4f27 = speed;
    return;
  }

  if(isDefined(v.snd) && isDefined(v.var_ca7e4f27)) {
    speed_delta = abs(speed - v.var_ca7e4f27);

    if(speed_delta > 0.01) {
      set_volume(v.snd, volume, 0.05, volumecurve);
      set_pitch(v.snd, pitch, 0.05, pitchcurve);
      v.var_ca7e4f27 = speed;
    }
  }
}

function private function_caa62515(userdata) {
  fadeout = self.var_f2acbf06;
  fadeoutcurve = self.var_436e97ed;

  if(isDefined(userdata) == 1) {
    foreach(v in userdata) {
      self thread function_a3ee9bec(v, fadeout, fadeoutcurve);
    }
  }

  self.var_a21eb7f9 = undefined;
  self.var_f2acbf06 = undefined;
  self.var_436e97ed = undefined;
  self.var_1ab997d2 = undefined;
}

function private function_ebe7010d(target, soundalias, var_5c76982f, var_4da05e4e) {
  ent = undefined;
  islooping = soundislooping(soundalias);

  if(!isarray(target)) {
    ent = target;
  } else if(target.size > 0) {
    ent = target[0];
  }

  if(function_81fac19d(!isentity(ent), "snd_speed: target entity not found!")) {
    return;
  }

  if(function_81fac19d(!isDefined(islooping), "snd_speed: alias " + function_783b69(soundalias, "'") + " does not exist!")) {
    return;
  }

  if(function_81fac19d(!is_true(islooping), "snd_speed: alias " + function_783b69(soundalias, "'") + " is not looping!")) {
    return;
  }

  if(function_81fac19d(!isarray(var_5c76982f), "snd_speed: pitchDict is not an array!")) {
    return;
  }

  if(function_81fac19d(!isarray(var_4da05e4e), "snd_speed: volumeDict is not an array!")) {
    return;
  }

  var_67f427c4 = spawnStruct();
  var_67f427c4.soundalias = soundalias;
  var_67f427c4.target = target;
  var_67f427c4.var_5c76982f = var_5c76982f;
  var_67f427c4.var_4da05e4e = var_4da05e4e;
  var_67f427c4.var_5c76982f[# "curve"] = function_ea2f17d1(var_67f427c4.var_5c76982f[# "curve"], ["linear"]);
  var_67f427c4.var_4da05e4e[# "curve"] = function_ea2f17d1(var_67f427c4.var_4da05e4e[# "curve"], ["xfade"]);
  ent.var_1ab997d2 = function_ea2f17d1(ent.var_1ab997d2, array());
  ent.var_1ab997d2[ent.var_1ab997d2.size] = var_67f427c4;
  ent snd_param("speed", undefined, &function_8764d0b2, &function_a04fdd, &function_caa62515, var_67f427c4);
}

function speed_stop(target, fadeout, fadeoutcurve) {
  fadeout = function_ea2f17d1(fadeout, 0.05);
  fadeoutcurve = function_ea2f17d1(fadeoutcurve, "easeinout");
  target.var_a21eb7f9 = 1;
  target.var_f2acbf06 = fadeout;
  target.var_436e97ed = fadeoutcurve;
  target function_79d9c57d("speed");
}

function speed(target, alias, var_5c76982f, var_4da05e4e) {
  level thread function_ebe7010d(target, alias, var_5c76982f, var_4da05e4e);
}

function function_d6d4a5d8(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale, var_2982cf88) {
  assert(isvec(src_origin));
  assert(isvec(src_velocity));
  assert(isvec(dst_origin));
  assert(isvec(dst_velocity));
  src_scale = function_ea2f17d1(src_scale, 1);
  dst_scale = function_ea2f17d1(dst_scale, 1);
  var_2982cf88 = function_ea2f17d1(var_2982cf88, 343.3);

  if(src_scale == 0 && dst_scale == 0 || var_2982cf88 == 0) {
    return [0, 0, 0];
  }

  var_ec47cb08 = float(var_2982cf88) * 39.3701;
  assert(isnumber(src_scale));
  assert(isnumber(dst_scale));
  assert(isnumber(var_ec47cb08));
  delta_origin = src_origin - dst_origin;
  len = length(delta_origin);
  var_2c6a3dcc = 0;
  var_3619eb04 = 0;

  if(src_scale > 0 && src_velocity != (0, 0, 0)) {
    var_2c6a3dcc = vectordot(src_velocity, delta_origin) / len;
    var_2c6a3dcc *= src_scale;
  }

  if(dst_scale > 0 && dst_velocity != (0, 0, 0)) {
    var_3619eb04 = vectordot(dst_velocity, delta_origin) / len;
    var_3619eb04 *= dst_scale;
  }

  dopplerscale = (var_ec47cb08 - var_2c6a3dcc) / (var_ec47cb08 - var_3619eb04);
  return [dopplerscale, var_2c6a3dcc, var_3619eb04];
}

function private function_6486ffc7() {}

function private function_ea96deb8(userdata) {
  var_78c4228e = arraycopy(level.var_ba9b4ed);
  var_e309e90d = 0;
  var_8b774403 = [];
  arrayremovevalue(var_78c4228e, self, 1);

  foreach(var_b05cf605 in var_78c4228e) {
    if(var_b05cf605 function_e74190aa("doppler")) {
      var_e309e90d += 1;

      if(isplayersafe(var_b05cf605)) {
        var_8b774403[var_8b774403.size] = var_b05cf605;
      }
    }
  }

  if(var_e309e90d == var_8b774403.size) {
    foreach(player in var_8b774403) {
      player function_79d9c57d("doppler");
    }
  }
}

function private function_344f3a4a(inputvalue, userdata) {
  player = userdata;

  if(!isplayersafe(player)) {
    return;
  }

  assert(isDefined(player));
  assert(isDefined(player.var_9dad7949));
  assert(isDefined(self));
  assert(isDefined(self.var_9dad7949));
  assert(isDefined(self.var_9dad7949.scale));
  assert(isDefined(self.var_9dad7949.playerscale));
  src_origin = self.origin;
  src_velocity = inputvalue;
  src_scale = self.var_9dad7949.scale;
  dst_origin = player getplayervieworigin();
  dst_velocity = player function_e6dfc446("doppler");
  dst_scale = self.var_9dad7949.playerscale;

  if(isDefined(dst_velocity) == 0 || self.var_9dad7949.playerscale == 0) {
    dst_velocity = (0, 0, 0);
  }

  assert(isvec(src_origin));
  assert(isvec(src_velocity));
  assert(isnumber(src_scale));
  assert(isvec(dst_origin));
  assert(isvec(dst_velocity));
  assert(isnumber(dst_scale));
  var_c9ea7ee3 = function_d6d4a5d8(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale);
  dopplerscale = var_c9ea7ee3[0];

  if(isDefined(self.var_9dad7949.pitchscale)) {
    dopplerscale *= self.var_9dad7949.pitchscale;
  }

  dopplerscale = math::clamp(dopplerscale, 0.01, 2);
  set_pitch(self, dopplerscale, function_6cfa7975());

  if(function_95c9af4b() > 1) {
    debugscale = getdvarfloat(#"hash_182296346d138cf8");
    audiocolor = getdvarvector(#"hash_3b9f89c8082a9915", (1, 1, 1));
    colorscale = getdvarfloat(#"hash_3944b771315157c1", 1);
    selectioncolor = function_2677a7e2(audiocolor, colorscale * 10);
    var_6a1e7792 = var_c9ea7ee3[1];
    dist = distance(src_origin, dst_origin);
    var_7295dcac = dist * 0.002;
    scale = debugscale * 0.666 * var_7295dcac;
    alpha = 1;
    alphasq = alpha * alpha;
    var_c730c816 = "<dev string:x4ca>";
    var_f7bf2aa1 = dopplerscale + "<dev string:x4d7>" + var_6a1e7792;
    print3dplus(var_c730c816, src_origin + (0, 0, -1 * scale * 24), scale, "<dev string:x4de>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    print3dplus(var_f7bf2aa1, src_origin + (0, 0, -1 * scale * 24), scale, "<dev string:x4e7>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
  }
}

function private _snd_doppler_main(player, dopplerscale, pitchscale, var_a47261d3) {
  assert(isplayersafe(player));
  dopplerscale = function_ea2f17d1(dopplerscale, 1);
  pitchscale = function_ea2f17d1(pitchscale, 1);
  var_a47261d3 = function_ea2f17d1(var_a47261d3, 1);
  assert(isDefined(player));

  if(isDefined(player.var_9dad7949) == 0) {
    player.var_9dad7949 = spawnStruct();
  }

  if(var_a47261d3 > 0) {
    player snd_param("doppler", undefined, &function_c0e3d9aa);
  }

  if(function_3132f113(self)) {
    return;
  }

  while(isDefined(self.soundalias) == 0) {
    waitframe(1);
  }

  self.var_9dad7949 = spawnStruct();
  self.var_9dad7949.scale = dopplerscale;
  self.var_9dad7949.pitchscale = pitchscale;
  self.var_9dad7949.playerscale = var_a47261d3;
  self snd_param("doppler", undefined, &function_c0e3d9aa, &function_344f3a4a, &function_ea96deb8, player);
}

function doppler(soundobject, player, dopplerscale, pitchscale, var_a47261d3) {
  if(function_81fac19d(isDefined(soundobject) == 0, "snd_doppler with undefined soundObject")) {
    return;
  }

  foreach(soundobj in function_f218bff5(soundobject)) {
    soundobj thread _snd_doppler_main(player, dopplerscale, pitchscale, var_a47261d3);
  }
}

function function_b9f3bee9(soundobject) {
  if(function_81fac19d(isDefined(soundobject) == 0, "snd_doppler_stop with undefined soundObject")) {
    return;
  }

  foreach(soundobj in function_f218bff5(soundobject)) {
    soundobj function_ea96deb8();
  }
}

function function_bdd32fcc() {
  skiptos = getskiptos();
  assert(isstring(skiptos));
  skiptos = tolower(skiptos);
  skiptos = strtok(skiptos, ",");
  skipto = "";

  if(isarray(skiptos)) {
    if(skiptos.size >= 1) {
      skipto = skiptos[0] + "";
    }
  } else if(isstring(skiptos)) {
    skipto = skiptos;
  }

  return skipto;
}

function private function_637f9a70(callback, allowretrigger) {
  level notify(#"hash_163618840778df8c");
  level endon(#"hash_163618840778df8c");
  allowretrigger = function_ea2f17d1(allowretrigger, 1);
  assert(isscriptfunctionptr(callback));
  assert(isDefined(allowretrigger));
  waitforplayers();

  while(true) {
    skipto = function_bdd32fcc();

    if(skipto != "") {
      break;
    }

    waitframe(1);
  }

  waitframe(1);
  objectives = [];

  while(true) {
    skipto = function_bdd32fcc();

    if(skipto == "") {} else if(allowretrigger || !allowretrigger && !isDefined(objectives[skipto])) {
      level thread[[callback]](skipto);
      objectives[skipto] = 1;
    }

    level waittill(#"objective_changed", #"save_restore");
    waittillframeend();
  }
}

function objective_init(callback, allowretrigger) {
  level thread function_637f9a70(callback, allowretrigger);
}

function function_5e69f468(callback, allowretrigger) {
  level thread function_637f9a70(callback, allowretrigger);
}

function private function_c66d3ce2(trigger, player) {
  istouching = 0;

  if(isplayersafe(player)) {
    if(isentity(trigger)) {
      istouching = player istouching(trigger);
    } else if(trigger == level) {
      if(!isDefined(player.var_9a8a4923) || isDefined(player.var_9a8a4923) && player.var_9a8a4923 == level) {
        istouching = 1;
      }
    }
  }

  return istouching;
}

function private function_9588abe4() {
  waitforplayers();
  waitframe(3);
  waittillframeend();

  foreach(player in getplayerssafe()) {
    level notify(#"trigger", {
      #activator: player
    });
  }
}

function private function_78013c7e(callback) {
  level endon(#"game_ended");
  self endon(#"death");
  triggers_default = [level];
  trigger = self;
  assert(isDefined(trigger));

  while(true) {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;
    istouching = function_c66d3ce2(trigger, player);

    if(istouching) {
      player.var_a1d98d00 = function_ea2f17d1(player.var_a1d98d00, triggers_default);
      assert(isarray(player.var_a1d98d00) && isDefined(player.var_a1d98d00[0]) && player.var_a1d98d00[0] == level);

      if(trigger != level) {
        player.var_a1d98d00[player.var_a1d98d00.size] = trigger;
      }

      haspriority = isDefined(player.var_9a8a4923.script_ambientpriority) && isDefined(trigger.script_ambientpriority);
      var_a4243a33 = haspriority && int(player.var_9a8a4923.script_ambientpriority) <= int(trigger.script_ambientpriority);

      if(!isDefined(player.var_9a8a4923) || haspriority && var_a4243a33 || !haspriority) {
        player.var_9a8a4923 = trigger;
        trigger thread[[callback]](player, trigger, 1);
      }

      while(istouching) {
        istouching = function_c66d3ce2(trigger, player);
        waitframe(1);
      }

      if(!isDefined(player)) {
        continue;
      }

      if(trigger != level) {
        arrayremovevalue(player.var_a1d98d00, trigger, 0);
      }

      if(player.var_9a8a4923 == trigger) {
        next_trigger = undefined;

        if(haspriority) {
          next_trigger = level;
          var_c0aa1fe7 = -1;

          for(i = player.var_a1d98d00.size - 1; i > 0; i--) {
            other_trigger = player.var_a1d98d00[i];

            if(isDefined(other_trigger.script_ambientpriority)) {
              var_271728fd = int(other_trigger.script_ambientpriority);

              if(var_271728fd > var_c0aa1fe7) {
                next_trigger = other_trigger;
                var_c0aa1fe7 = var_271728fd;
              }
            }
          }
        } else {
          assert(player.var_a1d98d00.size > 0);
          index = player.var_a1d98d00.size - 1;
          assert(index >= 0);
          next_trigger = player.var_a1d98d00[index];
        }

        if(isDefined(next_trigger)) {
          player.var_9a8a4923 = next_trigger;
          next_trigger thread[[callback]](player, next_trigger, 0);
          continue;
        }

        player.var_9a8a4923 = undefined;
        level notify(#"trigger", {
          #activator: player
        });
      }
    }
  }
}

function trigger_init(callback, name, key) {
  name = function_ea2f17d1(name, "ambient_package");
  key = function_ea2f17d1(key, "targetname");
  triggers = array(level);
  found_triggers = undefined;

  if(is_true(level._snd.var_2dd09170)) {
    found_triggers = getEntArray(name, key);
  } else if(is_true(level._snd.var_8c37ff34)) {
    found_triggers = getEntArray(0, name, key);
  }

  if(isarray(found_triggers)) {
    triggers = arraycombine(triggers, found_triggers);
  }

  foreach(trigger in function_f218bff5(triggers)) {
    trigger thread function_78013c7e(callback);
  }

  level thread function_9588abe4();
}

function element_init(name, elements) {
  assert(did_init());
  var_ce0e8448 = isstring(name);
  var_a718b5db = isarray(elements) && elements.size > 0 && isarray(elements[0]);
  var_505293ad = isarray(elements) && elements.size >= 3 && isstring(elements[0]);
  var_8314d62 = isstring(elements);
  var_f7816d0b = var_ce0e8448 && (var_a718b5db || var_505293ad || var_8314d62);

  if(function_81fac19d(!var_f7816d0b, "snd: element_init invalid")) {
    if(function_f984063f()) {
      debugbreak();
    }
  }

  if(var_8314d62 && !isDefined(level._snd.var_9353c9dd[elements])) {
    if(function_f984063f()) {
      debugbreak();
    }
  }

  if(var_505293ad) {
    elements = [elements];
  }

  level._snd.var_9353c9dd[name] = elements;
}

function function_50601e7c(element) {
  if(isstring(element)) {
    levelelements = level._snd.var_9353c9dd[element];
    var_36fc3b04 = isarray(levelelements);
    var_e3ac0560 = isstring(levelelements);

    if(var_36fc3b04) {
      return element;
    } else if(var_e3ac0560 && isarray(level._snd.var_9353c9dd[levelelements])) {
      return levelelements;
    }
  }

  return undefined;
}

function function_74c0fa84(element) {
  if(isarray(element)) {
    return element;
  } else if(isstring(element)) {
    element = function_50601e7c(element);
    levelelements = level._snd.var_9353c9dd[element];
    var_a2dc2648 = isarray(levelelements);

    if(var_a2dc2648) {
      return levelelements;
    }
  }

  return undefined;
}

function set_element(player, element) {
  isplayervalid = isplayersafe(player);

  if(function_81fac19d(!isplayervalid, "snd: set_element invalid player")) {
    return;
  }

  var_a2dc2648 = isarray(element);
  var_8314d62 = isstring(element);
  var_c78e3536 = !isDefined(element);
  var_f7816d0b = var_a2dc2648 || var_8314d62 || var_c78e3536;

  if(function_81fac19d(!var_f7816d0b, "snd: set_element invalid element")) {
    return;
  }

  if(var_a2dc2648) {
    player.var_c0ee07ef = "**** custom****";
  } else if(var_8314d62) {
    current = function_50601e7c(player.var_c0ee07ef);
    remapped = function_50601e7c(element);
    isequal = isstring(current) && isstring(remapped) && current == remapped;
    player.var_c0ee07ef = element;

    if(isequal) {
      return;
    }
  }

  if(isplayervalid && isarray(player.var_c6206b8b)) {
    stop(player.var_c6206b8b);
    player.var_c6206b8b = undefined;
  }

  if(var_c78e3536) {
    player.var_c0ee07ef = undefined;
    return;
  }

  elements = function_74c0fa84(element);
  var_a718b5db = isarray(elements);

  if(function_81fac19d(!var_a718b5db, "snd: set_element unexpected")) {
    return;
  }

  assert(isplayervalid);
  assert(var_a718b5db);
  player.var_c6206b8b = array();

  foreach(e in elements) {
    alias = e[0];
    target = function_ea2f17d1(e[1], player);
    spawntime = e[2];
    distancerange = e[3];
    rotation = e[4];
    elevation = e[5];
    emt = emitter(alias, target, spawntime, distancerange, rotation, elevation);

    if(isDefined(emt)) {
      player.var_c6206b8b[player.var_c6206b8b.size] = emt;
    }
  }
}

function private function_2fc1b3a7(soundobject, player, org_start, org_end) {
  assert(function_a6779cbd(soundobject));
  soundobject endon(#"death");
  soundobject notify(#"hash_20f2dfe33da3f037");
  soundobject endon(#"hash_20f2dfe33da3f037");

  while(isplayersafe(player) && function_a6779cbd(soundobject)) {
    org_player = player getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);
    soundobject.origin = org;

    if(function_95c9af4b() > 1) {
      color_line = (0.97254, 0.72974, 0.72974);
      color_rt = (0.72974, 0.97254, 0.72974);
      color_up = (0.72974, 0.72974, 0.97254);
      line(org_start, org_end, color_line, 1, 0, 1);
      line_angles = vectortoangles(org_end - org_start);
      line_rt = anglestoright(line_angles);
      line_up = anglestoup(line_angles);
      line(org_start - line_rt * 24, org_start + line_rt * 24, color_rt, 1, 0, 1);
      line(org_start - line_up * 24, org_start + line_up * 24, color_up, 1, 0, 1);
      line(org_end - line_rt * 24, org_end + line_rt * 24, color_rt, 1, 0, 1);
      line(org_end - line_up * 24, org_end + line_up * 24, color_up, 1, 0, 1);
    }

    waitframe(1);
  }
}

function line_attach(soundobject, player, org_start, org_end) {
  if(function_81fac19d(!isDefined(soundobject), "snd_line_attach with undefined soundObject")) {
    return;
  }

  soundobject thread function_2fc1b3a7(soundobject, player, org_start, org_end);
}

function line_detach(soundobject) {
  if(function_81fac19d(!isDefined(soundobject), "snd_line_detach with undefined soundObject")) {
    return;
  }

  soundobject notify(#"hash_20f2dfe33da3f037");
}