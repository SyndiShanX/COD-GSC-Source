/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7bfd4b57268935b.gsc
****************************************************/

#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\spy_cam;
#using scripts\sp\hud_util;
#namespace namespace_7a7e0463405adeb0;

function function_1f6b179a38bdc669(var_427174ec7793d3e9) {
  function_987c01b5819aa872(var_427174ec7793d3e9);
  level.player thread function_6078575ee542235c();
}

function function_e15d95257d2c822a(ai, var_5608a9f435e1a5da, var_2d17f3d98cc999a) {
  assert(isDefined(level.parabolic_mic.ai));

  if(isDefined(var_5608a9f435e1a5da)) {
    assert(!isDefined(ai.listening_func));
    ai.listening_func = var_5608a9f435e1a5da;
  } else {
    assert(isDefined(ai.listening_func), "<dev string:x24>");
  }

  ai.var_624ec5a043f3b36b = istrue(var_2d17f3d98cc999a);
  function_6df51d63314550c(ai);
}

function function_4ab17ab9af0c5def(ai) {
  assert(isDefined(level.parabolic_mic.ai));
  function_bed1c3040970e2e1(ai);
  ai.var_624ec5a043f3b36b = undefined;
  ai.listening_func = undefined;
  ai.hasplayed = undefined;
  ai.isplaying = undefined;
}

function function_69c36a2a58d14994(name, func) {
  assert(!isDefined(level.parabolic_mic.funcs[name]));
  level.parabolic_mic.funcs[name] = func;
}

function function_c098015b58c91299(name) {
  level.parabolic_mic.funcs[name] = undefined;
}

function function_c8e1b0e0e6c2c795(var_a1ddd6c86b6bc7e5, alias, delay_time, start_notify, end_notify, var_42c5e233c76f2e02, wait_notify, speaker_ent) {
  if(!isDefined(var_a1ddd6c86b6bc7e5)) {
    var_a1ddd6c86b6bc7e5 = spawnStruct();
    var_a1ddd6c86b6bc7e5.queue = [];
  } else {
    assert(isarray(var_a1ddd6c86b6bc7e5.queue));
  }

  var_ce267df30a7d1a20 = spawnStruct();
  var_ce267df30a7d1a20.alias = alias;
  var_ce267df30a7d1a20.delay_time = delay_time ?? 0;
  var_ce267df30a7d1a20.start_notify = start_notify;
  var_ce267df30a7d1a20.end_notify = end_notify;
  var_ce267df30a7d1a20.var_42c5e233c76f2e02 = var_42c5e233c76f2e02;
  var_ce267df30a7d1a20.wait_notify = wait_notify;
  var_ce267df30a7d1a20.speaker_ent = speaker_ent;
  var_a1ddd6c86b6bc7e5.queue[var_a1ddd6c86b6bc7e5.queue.size] = var_ce267df30a7d1a20;
  return var_a1ddd6c86b6bc7e5;
}

function function_b3003fa1c364d91d(ent) {
  if(isai(ent) && isDefined(ent.listening_func)) {
    ent = function_687dc64edd454081(ent);
  }

  foreach(soundent in level.parabolic_mic.sounds) {
    if(!(isDefined(soundent) && isDefined(soundent.traceent))) {
      continue;
    }

    if(soundent.traceent == ent) {
      return (soundent.volumescale ?? 0);
    }
  }

  return false;
}

function function_7477fae72290a952() {
  level.parabolic_mic.var_b87cf1817e3d4fb7 = 0;
}

function function_4012183a954f3ac(var_b28c5ea187fbae1, var_94a5a0346a5c327b) {
  assert(!isDefined(level.parabolic_mic.var_2d89deb81efe3274));
  level.parabolic_mic.var_2d89deb81efe3274 = var_b28c5ea187fbae1;
  level.parabolic_mic.var_99d2a20922dad57f = var_94a5a0346a5c327b;
}

function function_423e555a2a0b110f() {
  level.parabolic_mic.var_2d89deb81efe3274 = undefined;
  level.parabolic_mic.var_99d2a20922dad57f = undefined;
}

function function_5d5c1247b11fadf7() {
  level.parabolic_mic.static_enabled = 0;
}

function function_cab5185e54f062f8() {
  level.parabolic_mic.static_enabled = 1;
}

function private function_987c01b5819aa872(var_427174ec7793d3e9) {
  level.parabolic_mic = spawnStruct();
  level thread init_static(var_427174ec7793d3e9);

  setdevdvarifuninitialized(@ "hash_5f3a0cc4e00aedf6", 0);

  level.parabolic_mic.sounds = [];
  level.parabolic_mic.viewents = [];
  function_5d5c1247b11fadf7();
  level.parabolic_mic.volumes = getEntArray("\xc9\xb7#-0N|\xe0\xd9\xe9,xd\xfa\xf7C'sJ\xf9H\x95W", #targetname);

  foreach(volume in level.parabolic_mic.volumes) {
    volume.is_volume = 1;
  }

  a_structs = utility::getStructArray("qo\x9f\xf5\xdfl\v={\x80m\xdfz\x19\xcds\xfd\b\x1bu_-N~", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  a_ents = getEntArray("qo\x9f\xf5\xdfl\v={\x80m\xdfz\x19\xcds\xfd\b\x1bu_-N~", #targetname);
  level.parabolic_mic.points = utility::array_combine(a_structs, a_ents);
  level.parabolic_mic.ai = [];
  level.parabolic_mic.aiconversations = [];
  a_ai = getaiarray();

  foreach(ai in a_ai) {
    if(isalive(ai) && isDefined(ai.listening_func)) {
      function_6df51d63314550c(ai);
    }
  }

  level.parabolic_mic.funcs = [];
  level.parabolic_mic.var_b87cf1817e3d4fb7 = 1;
}

function private function_6df51d63314550c(ai) {
  assert(isDefined(level.parabolic_mic.ai));
  assert(isDefined(ai.listening_func));
  var_25ca6f738b832383 = ai getentitynumber();

  if(isDefined(level.parabolic_mic.ai[var_25ca6f738b832383])) {
    return;
  }

  foreach(existingai in level.parabolic_mic.ai) {
    if(existingai.listening_func == ai.listening_func) {
      if(!isDefined(level.parabolic_mic.aiconversations[ai.listening_func])) {
        level.parabolic_mic.aiconversations[ai.listening_func] = [existingai, ai];
        continue;
      }

      newindex = level.parabolic_mic.aiconversations[ai.listening_func].size;
      level.parabolic_mic.aiconversations[ai.listening_func][newindex] = ai;
    }
  }

  level.parabolic_mic.ai[var_25ca6f738b832383] = ai;
}

function private function_bed1c3040970e2e1(ai) {
  assert(isDefined(level.parabolic_mic.ai));
  assert(isDefined(ai.listening_func));
  var_25ca6f738b832383 = ai getentitynumber();

  if(!isDefined(level.parabolic_mic.ai[var_25ca6f738b832383])) {
    return;
  }

  if(isDefined(level.parabolic_mic.aiconversations[ai.listening_func])) {
    currentparticipants = level.parabolic_mic.aiconversations[ai.listening_func];
    remainingparticipants = [];

    for(participantindex = 0; participantindex < currentparticipants.size; participantindex++) {
      if(currentparticipants[participantindex] != ai) {
        remainingparticipants[remainingparticipants.size] = currentparticipants[participantindex];
      }
    }

    if(remainingparticipants.size > 1) {
      level.parabolic_mic.aiconversations[ai.listening_func] = remainingparticipants;
    } else {
      level.parabolic_mic.aiconversations[ai.listening_func] = undefined;
    }
  }

  level.parabolic_mic.ai[var_25ca6f738b832383] = undefined;
}

function private function_6078575ee542235c() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player waittill("l?\xf0r-p\xcfN\\Z\xc6\xa5\xc8\x1ce ");
    player function_e1505cf5b81dba09();
  }
}

function private function_e1505cf5b81dba09() {
  player = self;

  if(player utility::ent_flag("\xd7b\xeb\x01\xfd<F\xe0\xc8u\x1c\xdf\x9d\xf9\xa5T@\xab\xabE\x1d\x86")) {
    return;
  }

  player utility::ent_flag_set("\xd7b\xeb\x01\xfd<F\xe0\xc8u\x1c\xdf\x9d\xf9\xa5T@\xab\xabE\x1d\x86");
  player thread function_f62e4a5ee8beb63a();
  player thread function_6f9c990d9e54edb0();
}

function private function_f62e4a5ee8beb63a() {
  player = self;
  player endon("\x0eK\xa5bZe\xae\x04\xe4\xe3c\xd1o1\xc0kk");

  while(true) {
    player waittill("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84");
    player utility::ent_flag_set(">\x1c\xf9@^\x97IX\x187\xc9\xdbE\xdc\x1e\xa6\x1e\n\xf8F");
    player play_static();

    while(player utility::ent_flag("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84")) {
      player mic_trace();
      player function_8f6ea0274712e77d();
      player function_3fd1c29f36a2f4a8();
      player setsoundsubmix("c\x96\x9b\x8e\xcas\xb4\xcd\xec\xd7#Y;\xd2\xd8e", 0.2, 1);

      player function_9d3cea7e0c70856a();

      waitframe();
    }

    player clearsoundsubmix("c\x96\x9b\x8e\xcas\xb4\xcd\xec\xd7#Y;\xd2\xd8e", 0.2);
    player function_ecc2fa840c61d15f();
    player stop_static();
    player utility::ent_flag_clear(">\x1c\xf9@^\x97IX\x187\xc9\xdbE\xdc\x1e\xa6\x1e\n\xf8F");

    player function_770708923cf1cbfd();

    waitframe();
  }
}

function private function_6f9c990d9e54edb0() {
  player = self;
  player utility::waittill_any("\x1e\xfd\xd1\xa2\a", "a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");
  player notify("\x0eK\xa5bZe\xae\x04\xe4\xe3c\xd1o1\xc0kk");
  player stop_static();
  player utility::ent_flag_clear(">\x1c\xf9@^\x97IX\x187\xc9\xdbE\xdc\x1e\xa6\x1e\n\xf8F");

  player function_770708923cf1cbfd();

  level.parabolic_mic.viewents = [];

  foreach(soundent in level.parabolic_mic.sounds) {
    if(!isDefined(soundent)) {
      continue;
    }

    foreach(soundobj in soundent.soundobjarray) {
      if(!isDefined(soundobj)) {
        continue;
      }

      snd::stop(soundobj);
    }

    soundent delete();
  }

  level.parabolic_mic.sounds = [];
}

function private init_static(var_427174ec7793d3e9) {
  if(isDefined(var_427174ec7793d3e9)) {
    assert(soundexists(var_427174ec7793d3e9));
    assert(soundislooping(var_427174ec7793d3e9));
  }

  level.parabolic_mic.static_alias = var_427174ec7793d3e9;
  level.parabolic_mic.static_volumescale = 0.1;
}

function private play_static() {
  player = self;
  assert(!isDefined(level.parabolic_mic.staticsoundobj));

  if(isDefined(level.parabolic_mic.static_alias) && level.parabolic_mic.static_enabled) {
    level.parabolic_mic.staticsoundobj = snd::play(level.parabolic_mic.static_alias);
    snd::set_volume(level.parabolic_mic.staticsoundobj, level.parabolic_mic.static_volumescale);
  }
}

function private stop_static() {
  if(isDefined(level.parabolic_mic.staticsoundobj)) {
    snd::stop(level.parabolic_mic.staticsoundobj);
  }
}

function private mic_trace() {
  player = self;
  min_dist = 50;
  min_dist_squared = min_dist * min_dist;
  max_dist = 4096;
  var_83e110e254f0254d = max_dist * max_dist;
  eye = player getEye();
  fwd = anglesToForward(player getplayerangles());
  dotlimit = 0;
  level.parabolic_mic.viewents = [];
  var_a0d5f71a4d2b265 = trace::create_contents(1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0);
  level.parabolic_mic.trace = trace::ray_trace(eye + fwd * min_dist, eye + fwd * max_dist, self, var_a0d5f71a4d2b265);
  trace_position = level.parabolic_mic.trace["\xc1\xbd\xdci\xe8i{7"];

  foreach(volume in level.parabolic_mic.volumes) {
    if(!isDefined(volume)) {
      continue;
    }

    if(istrue(volume.hasplayed)) {
      continue;
    }

    if(volume istouchingpoint(trace_position)) {
      level.parabolic_mic.var_fea4c8bffe75bfd6 = trace_position;
      level.parabolic_mic.viewents = utility::function_e86d2ca144f6bde8(level.parabolic_mic.viewents, volume);
      player function_56ba34b06e154271(volume);
      break;
    }
  }

  foreach(item in level.parabolic_mic.points) {
    if(istrue(item.hasplayed)) {
      continue;
    }

    delta = item.origin - eye;
    dir = vectorNormalize(delta);
    vector_dot = vectordot(dir, fwd);
    distsq = distance2dsquared(item.origin, eye);

    if(vector_dot > dotlimit && distsq > min_dist_squared && distsq < var_83e110e254f0254d) {
      if(sighttracepassed(eye, item.origin, 1, player, item)) {
        level.parabolic_mic.viewents = utility::function_e86d2ca144f6bde8(level.parabolic_mic.viewents, item);
        player function_56ba34b06e154271(item);
      }
    }
  }

  foreach(item in level.parabolic_mic.ai) {
    if(!isDefined(item) || !isalive(item)) {
      continue;
    }

    target_pos = function_7b40bebad77468af(item);
    delta = target_pos - eye;
    dir = vectorNormalize(delta);
    vector_dot = vectordot(dir, fwd);
    distsq = distance2dsquared(target_pos, eye);

    if(vector_dot > dotlimit && distsq > min_dist_squared && distsq < var_83e110e254f0254d) {
      if(sighttracepassed(eye, target_pos, 1, player, item)) {
        level.parabolic_mic.viewents = utility::function_e86d2ca144f6bde8(level.parabolic_mic.viewents, item);
        player function_56ba34b06e154271(item);
      }
    }
  }
}

function function_7b40bebad77468af(aitarget) {
  eyepos = aitarget gettagorigin("\xc7\xae?f\x10\xbcr");
  eyeangles = aitarget gettagangles("\xc7\xae?f\x10\xbcr");
  eyeup = anglestoup(eyeangles);
  eyeforward = anglesToForward(eyeangles);
  var_1371e23b8b000d57 = eyepos + eyeup * -3 + eyeforward * 1;
  return var_1371e23b8b000d57;
}

function private function_687dc64edd454081(var_b14501fb1de5767f) {
  assert(isai(var_b14501fb1de5767f) && isDefined(var_b14501fb1de5767f.listening_func));

  if(isDefined(level.parabolic_mic.aiconversations[var_b14501fb1de5767f.listening_func])) {
    return level.parabolic_mic.aiconversations[var_b14501fb1de5767f.listening_func][0];
  }

  return var_b14501fb1de5767f;
}

function private function_56ba34b06e154271(ent) {
  player = self;

  if(isai(ent)) {
    ent = function_687dc64edd454081(ent);
  }

  if(isDefined(ent.hasplayed)) {
    return;
  }

  if(isDefined(ent.isplaying)) {
    return;
  }

  if(isDefined(ent.script_parameters) && ent.script_parameters == "\xf8\x88m") {
    return;
  }

  player thread prep_sound(ent);
}

function private prep_sound(ent) {
  player = self;
  ent endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  ent endon("\x1e\xfd\xd1\xa2\a");
  soundent = utility::spawn_tag_origin(player getEye(), (0, 0, 0));
  soundent linkTo(player);
  soundent.volumescale = 0;
  soundent.traceent = ent;
  soundent.soundobjarray = [];
  level.parabolic_mic.sounds[level.parabolic_mic.sounds.size] = soundent;
  ent.isplaying = 1;
  soundent play_sound();

  if(isDefined(ent)) {
    ent.isplaying = 0;
    ent.hasplayed = 1;
  }
}

function private play_sound() {
  soundent = self;
  strfunc = undefined;

  if(isDefined(soundent.traceent.listening_func)) {
    strfunc = soundent.traceent.listening_func;
  } else if(isDefined(soundent.traceent.script_noteworthy)) {
    strfunc = soundent.traceent.script_noteworthy;
  }

  level endon("M\xa2\xf9\xb2\xbc5\x8a\x82\aC\x9bvA?\xfa\x95\x02");
  soundent thread function_2775560e38ca2c2a();

  if(isDefined(strfunc) && isDefined(level.parabolic_mic.funcs[strfunc])) {
    data = [[level.parabolic_mic.funcs[strfunc]]]();

    if(isDefined(data) && isDefined(data.queue) && data.queue.size > 0) {
      soundent function_820d3c48d32b6b06(data);
    }
  }

  soundent delete();
}

function private function_2775560e38ca2c2a() {
  soundent = self;
  soundent endon("\x1e\xfd\xd1\xa2\a");
  level waittill("M\xa2\xf9\xb2\xbc5\x8a\x82\aC\x9bvA?\xfa\x95\x02");
  soundent delete();
}

function private function_820d3c48d32b6b06(data) {
  soundent = self;
  soundent utility_sp::function_stack(&function_e6b98aab5e265c70, data);
}

function private function_e6b98aab5e265c70(data) {
  soundent = self;
  function_374ff6b9d1c828ed(data);
  level endon("M\xa2\xf9\xb2\xbc5\x8a\x82\aC\x9bvA?\xfa\x95\x02");

  for(sound_index = 0; sound_index < data.queue.size; sound_index++) {
    item = data.queue[sound_index];

    if(isDefined(item.wait_notify) && !istrue(item.var_ee53b2f06b0a1d38)) {
      level waittill(item.wait_notify);
    }

    if(item.delay_time != 0) {
      wait item.delay_time;
    }

    if(isDefined(item.start_notify)) {
      level notify(item.start_notify);
    }

    next_item = data.queue[sound_index + 1];
    var_469316ba70695973 = undefined;

    if(isDefined(next_item)) {
      var_469316ba70695973 = next_item.wait_notify;
    }

    if(!soundexists(item.alias)) {
      iprintlnbold("<dev string:x65>" + item.alias + "<dev string:x7e>");

      if(isDefined(var_469316ba70695973)) {
        var_5415c70c4de7c557 = level utility::waittill_any_timeout(3, var_469316ba70695973);

        if(var_5415c70c4de7c557 == var_469316ba70695973) {
          next_item.var_ee53b2f06b0a1d38 = 1;
        }
      } else {
        wait 3;
      }
    } else {
      soundobj = snd::play(item.alias);
      startingvolume = max(0.01, soundent.volumescale);
      snd::set_volume(soundobj, startingvolume);
      soundent.soundobjarray[soundent.soundobjarray.size] = soundobj;
      soundent.var_7f49214df70a7045 = item.speaker_ent;

      if(soundislooping(item.alias)) {
        assert(isDefined(item.var_42c5e233c76f2e02), "<dev string:x92>" + item.alias + "<dev string:xdc>");

        if(isDefined(var_469316ba70695973)) {
          var_5415c70c4de7c557 = level utility::waittill_any_return(item.var_42c5e233c76f2e02, var_469316ba70695973);

          if(var_5415c70c4de7c557 == var_469316ba70695973) {
            next_item.var_ee53b2f06b0a1d38 = 1;
          }
        } else {
          level waittill(item.var_42c5e233c76f2e02);
        }

        snd::stop(soundobj);
        waitframe();
      } else if(isDefined(var_469316ba70695973)) {
        var_5415c70c4de7c557 = function_635065d045fa15d1(soundobj, var_469316ba70695973);

        if(!isDefined(var_5415c70c4de7c557)) {
          next_item.var_ee53b2f06b0a1d38 = 1;
        }
      } else {
        snd::await (soundobj);
      }
    }

    if(isDefined(item.end_notify)) {
      level notify(item.end_notify);
    }
  }
}

function private function_635065d045fa15d1(soundobj, var_98094e85af9733bc) {
  level endon(var_98094e85af9733bc);
  snd::await (soundobj);
  return "\x8d\xd0\x0e5K\x80\x13w-\xbf";
}

function private function_374ff6b9d1c828ed(data) {
  soundent = self;

  if(isDefined(data.interruptable)) {
    level notify("M\xa2\xf9\xb2\xbc5\x8a\x82\aC\x9bvA?\xfa\x95\x02");

    foreach(soundobj in soundent.soundobjarray) {
      if(!isDefined(soundobj)) {
        continue;
      }

      snd::stop(soundobj);
    }

    soundent.soundobjarray = [];
  }
}

function private function_1001847ab696fc48(soundsourceent, currentfov) {
  if(!arraycontains(level.parabolic_mic.viewents, soundsourceent)) {
    return 0;
  }

  if(isDefined(level.parabolic_mic.var_2d89deb81efe3274)) {
    customvolumescale = self[[level.parabolic_mic.var_2d89deb81efe3274]](soundsourceent, currentfov);

    if(isDefined(customvolumescale)) {
      return customvolumescale;
    }
  }

  targetpos = soundsourceent.origin;

  if(isai(soundsourceent)) {
    targetpos = function_7b40bebad77468af(soundsourceent);
  } else if(istrue(soundsourceent.is_volume)) {
    targetpos = level.parabolic_mic.var_fea4c8bffe75bfd6;
  }

  if(getdvarint(@ "hash_5f3a0cc4e00aedf6")) {
    sphere(targetpos, 4, (1, 1, 0), 0, 1);
  }

  var_ac2ef64027044e2a = 180;
  targetscreenpos = level.player worldpointtoscreenpos(targetpos, currentfov);

  if(!isDefined(targetscreenpos)) {
    var_7cba18f046ddeecc = var_ac2ef64027044e2a;
  } else {
    var_7cba18f046ddeecc = distance2d((0, 0, 0), (targetscreenpos[0], targetscreenpos[1], 0));
  }

  targetvolumescale = 1 - var_7cba18f046ddeecc / var_ac2ef64027044e2a;
  targetvolumescale = clamp(targetvolumescale, 0, 1);
  return targetvolumescale;
}

function private static_volume() {
  function_a0a7e7b3f3d369cf();
  level.parabolic_mic.static_volumescale = clamp(level.parabolic_mic.static_volumescale, 0, 1);

  if(isDefined(level.parabolic_mic.staticsoundobj)) {
    snd::set_volume(level.parabolic_mic.staticsoundobj, level.parabolic_mic.static_volumescale, level.framedurationseconds);
  }
}

function private function_8f6ea0274712e77d() {
  eye = self getEye();
  fwd = anglesToForward(self getplayerangles());
  currentfov = spy_cam::function_25f3c3dc847f86e6();
  var_eb97ddc96b02ca91 = 0;

  foreach(ent in level.parabolic_mic.sounds) {
    if(!isDefined(ent)) {
      var_eb97ddc96b02ca91 = 1;
      continue;
    }

    if(isai(ent.traceent) && isDefined(level.parabolic_mic.aiconversations[ent.traceent.listening_func])) {
      if(isDefined(ent.var_7f49214df70a7045) && level.parabolic_mic.var_b87cf1817e3d4fb7) {
        ent.volumescale = function_1001847ab696fc48(ent.var_7f49214df70a7045, currentfov);
      } else {
        convogroup = level.parabolic_mic.aiconversations[ent.traceent.listening_func];
        maxvolumescale = 0;

        foreach(participant in convogroup) {
          targetvolumescale = function_1001847ab696fc48(participant, currentfov);
          maxvolumescale = max(maxvolumescale, targetvolumescale);
        }

        ent.volumescale = maxvolumescale;
      }
    } else {
      ent.volumescale = function_1001847ab696fc48(ent.traceent, currentfov);
    }

    var_64d29c27d566eee8 = 0;

    foreach(soundobj in ent.soundobjarray) {
      if(!isDefined(soundobj)) {
        var_64d29c27d566eee8 = 1;
      }

      snd::set_volume(soundobj, ent.volumescale, level.framedurationseconds);
    }

    if(var_64d29c27d566eee8) {
      ent.soundobjarray = utility::array_removeundefined(ent.soundobjarray);
    }

    if(getdvarint(@ "hash_5f3a0cc4e00aedf6")) {
      if(istrue(ent.traceent.is_volume) && isDefined(level.parabolic_mic.trace)) {
        if(isDefined(level.parabolic_mic.var_fea4c8bffe75bfd6)) {
          print3d(level.parabolic_mic.var_fea4c8bffe75bfd6 + (0, 0, 18), ent.traceent.script_noteworthy + "<dev string:xe1>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
        }

        continue;
      }

      targetid = ent.traceent.script_noteworthy;

      if(!isDefined(targetid)) {
        targetid = ent.traceent getentitynumber();
      }

      print3d(ent.traceent.origin + (0, 0, 18), targetid + "<dev string:xe1>" + ent.volumescale, (1, 1, 0), 1, 0.35, 2);
    }
  }

  if(var_eb97ddc96b02ca91) {
    level.parabolic_mic.sounds = utility::array_removeundefined(level.parabolic_mic.sounds);
  }

  thread static_volume();
}

function private function_a0a7e7b3f3d369cf() {
  level endon("\x80L=\xd4\f\xab\b\xc1d\xf4if^\xd1%m\xdc");
  self endon("\xef\xcc\xb1[\xb9\x8f\xfc\x9dQ\xd0>\xedb\x9a\xe5\x96\xbf\xf4");

  if(isDefined(level.parabolic_mic.var_99d2a20922dad57f)) {
    var_fdd2b0ac730725eb = self[[level.parabolic_mic.var_99d2a20922dad57f]]();

    if(isDefined(var_fdd2b0ac730725eb)) {
      level.parabolic_mic.static_volumescale = var_fdd2b0ac730725eb;
      return;
    }
  }

  origin = function_3c66292464075160();

  if(isDefined(origin)) {
    angle = function_824ae60cb54cb9a7(origin);
    scale = snd::scalerp(angle, 0, 0.5, 0.05, 1);
    level.parabolic_mic.static_volumescale = scale;
  }
}

function private function_3c66292464075160() {
  closest_enemy = undefined;
  var_94f4039d5ef66a32 = -2;
  player_forward = anglesToForward(self.angles);
  player_forward = vectorNormalize(player_forward);

  foreach(ent in level.parabolic_mic.viewents) {
    var_107a235dbdae5850 = ent.origin - self.origin;
    var_68db3dd6780b8940 = vectorNormalize(var_107a235dbdae5850);
    dot_product = vectordot(var_68db3dd6780b8940, player_forward);

    if(dot_product > var_94f4039d5ef66a32) {
      var_94f4039d5ef66a32 = dot_product;
      closest_enemy = ent;
    }
  }

  if(isDefined(closest_enemy)) {
    return closest_enemy.origin;
  }

  return undefined;
}

function private function_6dba0834cceaef4e(dot_product) {
  return (1 + dot_product) * 360;
}

function private function_824ae60cb54cb9a7(origin) {
  if(isvector(origin)) {
    vertical_offset = 50;
    var_107a235dbdae5850 = self.origin + (0, 0, vertical_offset) - origin + (0, 0, vertical_offset);
    var_68db3dd6780b8940 = vectorNormalize(var_107a235dbdae5850);
    player_forward = anglesToForward(self.angles);
    player_forward = vectorNormalize(player_forward);
    dot_product = vectordot(var_68db3dd6780b8940, player_forward);
    return function_6dba0834cceaef4e(dot_product);
  }

  return undefined;
}

function private function_ecc2fa840c61d15f() {
  level endon("\x80L=\xd4\f\xab\b\xc1d\xf4if^\xd1%m\xdc");
  self notify("\xef\xcc\xb1[\xb9\x8f\xfc\x9dQ\xd0>\xedb\x9a\xe5\x96\xbf\xf4");
  level.parabolic_mic.static_volumescale = 0.1;
  level.parabolic_mic.static_volumescale = clamp(level.parabolic_mic.static_volumescale, 0, 1);

  if(isDefined(level.parabolic_mic.staticsoundobj)) {
    snd::set_volume(level.parabolic_mic.staticsoundobj, level.parabolic_mic.static_volumescale, level.framedurationseconds);
  }

  if(isarray(level.parabolic_mic.sounds)) {
    level.parabolic_mic.sounds = utility::array_removeundefined(level.parabolic_mic.sounds);

    foreach(ent in level.parabolic_mic.sounds) {
      ent.volumescale = 0;
      ent.soundobjarray = utility::array_removeundefined(ent.soundobjarray);

      foreach(soundobj in ent.soundobjarray) {
        snd::set_volume(soundobj, ent.volumescale, level.framedurationseconds);
      }
    }
  }
}

function private function_3fd1c29f36a2f4a8() {
  player = self;
  var_af138745fd98ac7b = [];

  foreach(targetent in level.parabolic_mic.viewents) {
    if(isai(targetent) && istrue(targetent.var_624ec5a043f3b36b)) {
      var_af138745fd98ac7b[var_af138745fd98ac7b.size] = targetent;
    }
  }

  var_fca8c5db79f99ae0 = undefined;
  eye = player getEye();
  fwd = anglesToForward(player getplayerangles());
  maxdot = 0;

  foreach(uicandidate in var_af138745fd98ac7b) {
    targetpos = function_7b40bebad77468af(uicandidate);
    dir = vectorNormalize(targetpos - eye);
    uicandidatedot = vectordot(dir, fwd);

    if(uicandidatedot > maxdot) {
      var_fca8c5db79f99ae0 = uicandidate;
      maxdot = uicandidatedot;
    }
  }

  if(isDefined(var_fca8c5db79f99ae0)) {
    var_9587428bf2981408 = function_b3003fa1c364d91d(var_fca8c5db79f99ae0);
    spy_cam::function_bb980f7b7c16eb28(1);
    self setclientomnvar("Y\x10\xe9SYo\x94\x905\xba\x18\x87\xa2\xf8.c\xc8w8F\xcbk\xecV\xde\xab@\xbfX\xa8\x0e\x1cr>\xee", var_9587428bf2981408);

    level.parabolic_mic.var_f26d3556add1a5e5 = var_fca8c5db79f99ae0 getentitynumber();
    level.parabolic_mic.var_2a183d82b58e3d54 = var_9587428bf2981408;

    return;
  }

  spy_cam::function_bb980f7b7c16eb28(0);
  self setclientomnvar("Y\x10\xe9SYo\x94\x905\xba\x18\x87\xa2\xf8.c\xc8w8F\xcbk\xecV\xde\xab@\xbfX\xa8\x0e\x1cr>\xee", 0);

  level.parabolic_mic.var_f26d3556add1a5e5 = -1;
  level.parabolic_mic.var_2a183d82b58e3d54 = 0;
}

function private function_9d3cea7e0c70856a() {
  player = self;

  if(getdvarint(@ "hash_5f3a0cc4e00aedf6", 0)) {
    debug_title = function_7ef6667637a6b822(0);
    debug_title.label = "<dev string:xf0>";
    view_ents = function_7ef6667637a6b822(1);
    view_ents.label = "<dev string:x101>";
    var_7aa1282edb0e6b88 = "<dev string:x110>";

    foreach(ent in level.parabolic_mic.viewents) {
      var_7aa1282edb0e6b88 += ent getentitynumber() + "<dev string:x116>";
    }

    var_7aa1282edb0e6b88 += "<dev string:x11c>";
    view_ents setdevtext(var_7aa1282edb0e6b88);
    var_344a6c8c7cc53dc1 = function_7ef6667637a6b822(2);
    var_344a6c8c7cc53dc1.label = "<dev string:x122>";
    var_344a6c8c7cc53dc1 setdevtext(level.parabolic_mic.var_f26d3556add1a5e5 ?? "<dev string:x13a>");
    var_cae9a0447716f410 = function_7ef6667637a6b822(3);
    var_cae9a0447716f410.label = "<dev string:x13f>";
    var_cae9a0447716f410 setdevtext(level.parabolic_mic.var_2a183d82b58e3d54 ?? "<dev string:x13a>");
    var_8e5fc1973011b883 = function_7ef6667637a6b822(4);
    var_8e5fc1973011b883.label = "<dev string:x15a>";
    var_427174ec7793d3e9 = function_7ef6667637a6b822(5, 10);
    var_427174ec7793d3e9.label = "<dev string:x16c>";

    if(isDefined(level.parabolic_mic.staticsoundobj)) {
      var_427174ec7793d3e9 setdevtext(level.parabolic_mic.staticsoundobj.soundalias ?? "<dev string:x13a>");
    } else {
      var_427174ec7793d3e9 setdevtext("<dev string:x177>");
    }

    var_ab6161e6a1e77041 = function_7ef6667637a6b822(6, 20);
    var_ab6161e6a1e77041.label = "<dev string:x188>";
    var_ab6161e6a1e77041 setvalue(level.parabolic_mic.static_volumescale ?? -1);
    var_e1f0df67e9df2ff9 = function_7ef6667637a6b822(7);
    var_e1f0df67e9df2ff9.label = "<dev string:x19d>";
    var_3394f2fa1ea51ebc = 8;
    function_b1521229c12c5f5d(var_3394f2fa1ea51ebc);

    foreach(soundent in level.parabolic_mic.sounds) {
      foreach(soundobj in soundent.soundobjarray) {
        if(isDefined(soundobj)) {
          line_elem = function_7ef6667637a6b822(var_3394f2fa1ea51ebc, 10);
          var_3394f2fa1ea51ebc++;
          line_elem.label = "<dev string:x16c>";
          line_elem setdevtext(soundobj.soundalias ?? "<dev string:x13a>");
          line_elem = function_7ef6667637a6b822(var_3394f2fa1ea51ebc, 20);
          var_3394f2fa1ea51ebc++;
          line_elem.label = "<dev string:x188>";
          line_elem setvalue(soundent.volumescale ?? -1);
        }
      }
    }

    return;
  }

  player function_770708923cf1cbfd();
}

function private function_7ef6667637a6b822(line_index, x_offset, color_override) {
  player = self;
  starting_x = 480;
  starting_y = 220;
  line_height = 12;

  if(!isDefined(level.parabolic_mic.var_f9602f589428e790)) {
    level.parabolic_mic.var_f9602f589428e790 = [];
  }

  if(!isDefined(level.parabolic_mic.var_f9602f589428e790[line_index])) {
    text_elem = player hud_util::createclientfontstring("<dev string:x1b2>", 0.8);
    level.parabolic_mic.var_f9602f589428e790[line_index] = text_elem;
  }

  level.parabolic_mic.var_f9602f589428e790[line_index] hud_util::setpoint("<dev string:x1bd>", undefined, starting_x + (x_offset ?? 0), starting_y + line_index * line_height);
  level.parabolic_mic.var_f9602f589428e790[line_index].color = color_override ?? (1, 1, 0);
  level.parabolic_mic.var_f9602f589428e790[line_index].alpha = 1;
  return level.parabolic_mic.var_f9602f589428e790[line_index];
}

function private function_b1521229c12c5f5d(var_529d89591b811e98) {
  for(line_index = var_529d89591b811e98; line_index < level.parabolic_mic.var_f9602f589428e790.size; line_index++) {
    if(isDefined(level.parabolic_mic.var_f9602f589428e790[line_index])) {
      level.parabolic_mic.var_f9602f589428e790[line_index].alpha = 0;
    }
  }
}

function private function_770708923cf1cbfd() {
  player = self;

  if(!isDefined(level.parabolic_mic.var_f9602f589428e790)) {
    return;
  }

  foreach(text_elem in level.parabolic_mic.var_f9602f589428e790) {
    text_elem hud_util::destroyelem();
  }

  level.parabolic_mic.var_f9602f589428e790 = [];
}

# /