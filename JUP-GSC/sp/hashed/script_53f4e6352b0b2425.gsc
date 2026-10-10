/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_53f4e6352b0b2425.gsc
*************************************************/

#using script_162c770c1453a845;
#using script_19163c4e4e504a5e;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace snd;

function snd_init() {
  if(!isDefined(level.snd)) {
    level.snd = spawnStruct();
    level.snd.var_78f5f86726c0fdb5 = 1;
    level.snd.callbacks = [];
    level.snd.objects = [];
    level.snd.var_a79bb46c42ffe2fd = [];
    level.snd.var_6bb7b2b49f3454a1 = "gentity";
    level.snd.var_c5b5d16976d4a8ef = 0;
    level.snd.callbacks["player_view"] = &function_cfd6fc964dca520a;
    level.snd.callbacks["player_angles"] = &function_d4503656fc0a9c48;
    level.snd.callbacks["player_fov"] = &function_6c8d0689823981ab;
  }

  function_301f98e25e20c1ab();

  level thread function_28988b4602b0b747();
}

function function_b3e5599c9f6a8895(obj) {
  assert(obj == level || isstruct(obj) || isent(obj));

  if(!isstruct(obj.snd)) {
    obj.snd = spawnStruct();
  }

  assertex(isstruct(obj.snd), "snd_init_obj obj.snd is not a struct");
}

function function_4677a3d91779f0e() {
  now = gettime();
  var_62b0f3e6017d4cee = function_f0b5522ee5ce0cb1() == 0 || now <= 300;
  return var_62b0f3e6017d4cee;
}

function function_f0b5522ee5ce0cb1() {
  if(isstruct(level.snd)) {
    return true;
  }

  return false;
}

function function_40a17693396019a7() {
  while(function_f0b5522ee5ce0cb1() == 0) {
    waitframe();
  }
}

function snd_play(soundalias, targets) {
  soundtype = level.snd.var_6bb7b2b49f3454a1;
  soundobject = function_88c8b4d475d4cfd(soundtype, soundalias, targets);
  return soundobject;
}

function snd_stop(soundobject, fadeoutseconds) {
  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    level thread function_114485fecd709d37(soundobj, fadeoutseconds);
  }
}

function snd_stop_alias(soundalias, targets, fadeoutseconds) {
  if(function_110d3ab280057f5b(!isDefined(soundalias), "snd_stop_alias with undefined soundalias")) {
    return 0;
  }

  soundalias = tolower(soundalias);
  soundobjects = function_a922099e0d89c828(targets);
  var_cadaa7a8d37a5adc = 0;

  foreach(soundobj in soundobjects) {
    if(!isDefined(soundobj.soundalias)) {
      continue;
    }

    if(issubstr(tolower(soundobj.soundalias), soundalias)) {
      snd_stop(soundobj, fadeoutseconds);
      var_cadaa7a8d37a5adc = int(var_cadaa7a8d37a5adc + 1);
    }
  }

  return var_cadaa7a8d37a5adc;
}

function function_c5647295e3ac75df(soundobject, notifyentity, notifystring, fadeoutseconds) {
  if(function_110d3ab280057f5b(!function_f0a31c88dbf01c1(soundobject), "snd_stop_on_ent_notify soundObject is not a snd object")) {
    return;
  }

  if(function_110d3ab280057f5b(!isent(notifyentity), "snd_stop_on_ent_notify notifyEntity is not an entity")) {
    return;
  }

  if(function_110d3ab280057f5b(!isstring(notifystring), "snd_stop_on_ent_notify notifyString is not a string")) {
    return;
  }

  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    notifyentity thread function_696597962461161(soundobj, notifyentity, notifystring, fadeoutseconds);
  }
}

function function_a9bcfafb96e69580(soundobject, deathentity, fadeoutseconds) {
  if(function_110d3ab280057f5b(!function_f0a31c88dbf01c1(soundobject), "stop_on_ent_death soundObject is not a snd object")) {
    return;
  }

  if(function_110d3ab280057f5b(!isent(deathentity), "stop_on_ent_death deathEntity is not an entity")) {
    return;
  }

  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    deathentity thread function_696597962461161(soundobj, deathentity, "death", fadeoutseconds);
  }
}

function function_74726126b3d8b0aa(soundobject, levelnotifystring, fadeoutseconds) {
  if(function_110d3ab280057f5b(!function_f0a31c88dbf01c1(soundobject), "stop_on_level_notify soundObject is not a snd object")) {
    return;
  }

  if(function_110d3ab280057f5b(!isstring(levelnotifystring), "snd_stop_on_level_notify: levelNotifyString is not a string")) {
    return;
  }

  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    level thread function_eddfe63d2da7ee5c(soundobj, levelnotifystring, fadeoutseconds);
  }
}

function snd_wait(soundobject) {
  if(function_110d3ab280057f5b(!isDefined(soundobject), "snd_wait with undefined soundObject")) {
    return 0;
  }

  starttime = gettime();
  waittime = 0;

  while(true) {
    var_e7662060a76bac2b = 0;
    soundobjects = function_5762e7cb509e83c0(soundobject);
    soundobjects = array_removeundefined(soundobjects);

    foreach(soundobj in soundobjects) {
      if(function_f0a31c88dbf01c1(soundobj)) {
        var_e7662060a76bac2b = 1;
        break;
      }
    }

    if(var_e7662060a76bac2b == 0) {
      break;
    }

    waitframe();
  }

  endtime = gettime();
  waittime = endtime - starttime;
  waittime /= 1000;
  return waittime;
}

function function_f0a31c88dbf01c1(soundobject) {
  if(isDefined(soundobject) && isDefined(soundobject.soundtype)) {
    return true;
  }

  return false;
}

function function_a922099e0d89c828(targets) {
  sndobjs = [];

  foreach(target in function_5762e7cb509e83c0(targets)) {
    if(!isDefined(target)) {
      sndobjs = array_combine(sndobjs, level.snd.objects);
      continue;
    }

    if(function_110d3ab280057f5b(isnumber(target), "snd: get_sound_objects invalid target was a number")) {
      if(function_6fa24a43c981460a()) {
        DevOp(0x94);
      }

      continue;
    }

    if(target == level) {
      sndobjs = array_combine(sndobjs, level.snd.var_a79bb46c42ffe2fd);
      continue;
    }

    if(isDefined(target.snd.objects)) {
      sndobjs = array_combine(sndobjs, target.snd.objects);
    }
  }

  return sndobjs;
}

function function_40970b59b11f71d3(soundalias, targets) {
  if(function_110d3ab280057f5b(!isDefined(soundalias), "snd_get_alias_objects with undefined soundalias")) {
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

  assertex(isarray(soundaliases), "snd_get_alias_objects: soundaliases is not an array");
  soundobjects = function_a922099e0d89c828(targets);
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

function function_c2524740dbf249bd(var_879128515ec2caa2) {
  var_879128515ec2caa2 = default_to(var_879128515ec2caa2, 1);

  if(!isDefined(level.snd.fnplaysoundonentity)) {
    level.snd.fnplaysoundonentity = level.fnplaysoundonentity;
    level.snd.fnplaysoundontag = level.fnplaysoundontag;
    level.snd.fnnotetrackprefixhandler = level.fnnotetrackprefixhandler;
    level.snd.var_f7ce8811120b418e = anim.callbacks["PlaySoundAtViewHeight"];
  }

  if(var_879128515ec2caa2) {
    level.fnplaysoundonentity = &function_ee9c171db1ae676e;
    level.fnplaysoundontag = &function_ee1f9b08b748b2bf;
    level.fnnotetrackprefixhandler = &function_f1fa7d6753f06a41;
    anim.callbacks["PlaySoundAtViewHeight"] = &function_4df9eee6e5769696;
    return;
  }

  level.fnplaysoundonentity = level.snd.fnplaysoundonentity;
  level.fnplaysoundontag = level.snd.fnplaysoundontag;
  level.fnnotetrackprefixhandler = level.snd.fnnotetrackprefixhandler;
  anim.callbacks["PlaySoundAtViewHeight"] = level.snd.var_f7ce8811120b418e;
}

function function_3b12d9c60745e066(soundobject) {
  if(isDefined(level.snd.callbacks["volume_get"])) {
    return [[level.snd.callbacks["volume_get"]]](soundobject);
  }

  return 1;
}

function function_e70d88e85d5fb19a(soundobject, volume, timeinseconds, curve, callbackfunc) {
  if(isDefined(level.snd.callbacks["volume_set"])) {
    [[level.snd.callbacks["volume_set"]]](soundobject, volume, timeinseconds, curve, callbackfunc);
  }
}

function function_f54bdc273c4ca53a(soundobject) {
  if(isDefined(level.snd.callbacks["pitch_get"])) {
    return [[level.snd.callbacks["pitch_get"]]](soundobject);
  }

  return 1;
}

function function_a2c9c85b2af7c7fe(soundobject, pitch, timeinseconds, curve, callbackfunc) {
  if(isDefined(level.snd.callbacks["pitch_set"])) {
    [[level.snd.callbacks["pitch_set"]]](soundobject, pitch, timeinseconds, curve, callbackfunc);
  }
}

function function_fb2fb41ac5ab1d47() {
  if(istrue(level.snd.var_ab52ccadc04df539)) {
    return "centity";
  }

  return "gentity";
}

function function_47659f446bf756a4() {
  return level.snd.var_6bb7b2b49f3454a1;
}

function function_202b3d1e393890(type) {
  type = default_to(type, function_fb2fb41ac5ab1d47());
  level.snd.var_6bb7b2b49f3454a1 = function_21d5c74cfbf9ebcb(type);
}

function function_77d8a00d3187f85c(soundobject) {
  if(isDefined(soundobject.soundtype)) {
    return soundobject.soundtype;
  }

  return "";
}

function function_21d5c74cfbf9ebcb(soundtype) {
  snd_type = undefined;

  switch (soundtype) {
    case #"hash_59f13b3cf23ba655":
      snd_type = "gentity";
      break;
    case #"hash_9ffcd1094df9c111":
      snd_type = "centity";
      break;
    case #"hash_cb36e64f12ba9ad":
      snd_type = "emitter";
      break;
    default:
      snd_type = undefined;
      break;
  }

  assertex(isDefined(snd_type), "snd: illegal soundtype string" + soundtype);
  return snd_type;
}

function private function_bf5653c442222ab8(snd_type, snd_key, item) {
  assertex(isstruct(level.snd), "snd was not initialized");
  assertex(isDefined(level.snd.objects), "snd was not initialized");

  switch (snd_type) {
    default:
      assertex(0, "unknown snd type");
      break;
    case #"hash_59f13b3cf23ba655":
    case #"hash_9ffcd1094df9c111":
      level.snd.objects[snd_key] = item;
      break;
  }
}

function private function_23a8f89921cec8a3(snd_type, snd_key, item) {
  assertex(isstruct(level.snd), "snd was not initialized");
  assertex(isDefined(level.snd.objects), "snd was not initialized");

  switch (snd_type) {
    default:
      assertex(0, "unknown snd type");
      break;
    case #"hash_59f13b3cf23ba655":
    case #"hash_9ffcd1094df9c111":
      assertex(array_contains(level.snd.objects, item), "snd freed entity was not allocated");
      level.snd.objects[snd_key] = undefined;
      break;
  }
}

function private function_f6cebff1cb2afece() {
  snd_type = self.soundtype;
  snd_key = self.soundkey;
  self waittill("death");
  function_23a8f89921cec8a3(snd_type, snd_key, self);
}

function private function_2743b5d65cb4aa61(ent, var_b042ad1a3b3400e8, linkedentity, linkedbonetag) {
  assertex(isDefined(ent), "snd: undefined gentity");
  assertex(isDefined(ent.soundkey), "snd: undefined soundkey");

  if(isDefined(linkedentity)) {
    linkedbonetag = linkedentity function_1437d15fc0a0a804(linkedbonetag);
    linkedoffset = (0, 0, 0);
    linkedangles = (0, 0, 0);

    if(isDefined(var_b042ad1a3b3400e8)) {
      linkedoffset = var_b042ad1a3b3400e8;
    }

    assertex(isDefined(linkedbonetag), "snd: undefined linkedBoneTag");
    ent linkTo(linkedentity, linkedbonetag, linkedoffset, linkedangles);
    function_b3e5599c9f6a8895(linkedentity);

    if(!isarray(linkedentity.snd.objects)) {
      linkedentity.snd.objects = [];
    }

    linkedentity.snd.objects[ent.soundkey] = ent;
    return;
  }

  level.snd.var_a79bb46c42ffe2fd[ent.soundkey] = ent;
}

function private function_32231133ccc402ee(soundalias, var_b042ad1a3b3400e8, linkedentity, linkedbonetag) {
  ent = undefined;
  spawnorigin = undefined;

  if(isDefined(linkedentity) && isDefined(linkedbonetag) && isDefined(var_b042ad1a3b3400e8)) {
    spawnorigin = linkedentity gettagorigin(linkedbonetag);
    spawnorigin += var_b042ad1a3b3400e8;
  } else if(isDefined(linkedentity) && isDefined(linkedbonetag)) {
    spawnorigin = linkedentity gettagorigin(linkedbonetag);
  } else if(isDefined(linkedentity)) {
    spawnorigin = linkedentity.origin;
  } else if(!isDefined(linkedentity) && !isDefined(var_b042ad1a3b3400e8)) {
    var_7473306a600cd2ec = (0, 0, -32768);
    spawnorigin = var_7473306a600cd2ec;
  } else {
    spawnorigin = var_b042ad1a3b3400e8;
  }

  assertex(isDefined(spawnorigin));
  ent = undefined;

  if(isDefined(linkedentity)) {
    ent = spawn("script_model", spawnorigin);

    if(isent(ent)) {
      ent setModel("tag_origin");
    }
  } else {
    ent = spawn("script_origin", spawnorigin);
  }

  assertex(isDefined(ent), "snd: could not spawn/allocate entity");

  if(isent(ent)) {
    ent.var_c55912d11e27cbee = linkedentity;
    ent.soundtype = "gentity";
    ent.soundkey = ent getentitynumber();
    ent.targetname = "snd " + soundalias;
  }

  return ent;
}

function private function_3faaafc0bfa48453(ent) {
  if(function_110d3ab280057f5b(!isDefined(ent) || function_5b8457b9d8edb521(ent), "snd: free on deleted entity!")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    return;
  }

  if(isDefined(ent.var_c55912d11e27cbee) && isarray(ent.var_c55912d11e27cbee.snd.objects)) {
    linkedentity = ent.var_c55912d11e27cbee;
    var_25fdd8d118c2da05 = isDefined(linkedentity.snd.objects[ent.soundkey]);

    if(var_25fdd8d118c2da05 == 1) {
      linkedentity.snd.objects[ent.soundkey] = undefined;
    } else {
      if(function_6fa24a43c981460a()) {
        DevOp(0x94);
      }
    }
  } else {
    level.snd.var_a79bb46c42ffe2fd[ent.soundkey] = undefined;
  }

  waittillframeend();
  ent delete();
}

function private function_2a7a90760153d57b(soundobject, soundalias, initialvolume, delaytime) {
  ent = soundobject;
  currentvolume = undefined;
  ent endon("death");
  assert(isDefined(ent));
  assert(isstring(soundalias));
  currentvolume = function_3b12d9c60745e066(ent);

  if(!isDefined(initialvolume) && isDefined(currentvolume)) {
    initialvolume = currentvolume;
  }

  if(function_4677a3d91779f0e()) {
    var_14cbdbf60f75e20b = !isDefined(delaytime) || isnumber(delaytime) && delaytime == 0;

    if(function_110d3ab280057f5b(var_14cbdbf60f75e20b, "snd: delayed due to first frame!")) {
      delaytime = 0.05;
    }
  }

  if(isnumber(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  assertex(soundexists(soundalias), "snd alias does not exist: " + soundalias);

  if(soundislooping(soundalias)) {
    ent playLoopSound(soundalias);
  } else {
    donenotifystr = "sounddone";

    if(utility::issp()) {
      ent playSound(soundalias, donenotifystr);
      var_549286f0044c1565 = 0;

      if(var_549286f0044c1565) {
        ent thread function_9dc92ee851117f94(soundalias, donenotifystr);
      } else {
        ent thread function_f5abe4d9a18d99c7(donenotifystr);
      }
    } else {
      if(isDefined(ent.var_c55912d11e27cbee) && isDefined(level.snd.var_5ee4aba82383469e)) {
        waitframe();
        ent[[level.snd.var_5ee4aba82383469e]](soundalias);
      } else {
        ent playSound(soundalias);
      }

      ent thread function_9dc92ee851117f94(soundalias, donenotifystr);
    }
  }

  ent.soundalias = soundalias;
}

function private function_e1f20b9363ca750d(soundobject, fadeoutseconds) {
  soundobject endon("death");
  ent = soundobject;

  if(function_110d3ab280057f5b(!isDefined(ent) || function_5b8457b9d8edb521(ent), "snd: stop on deleted entity!")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    return;
  }

  soundalias = ent.soundalias;
  fadeoutseconds = default_to(fadeoutseconds, 0);

  if(isstring(soundalias)) {
    if(istrue(soundislooping(soundalias))) {
      ent stoploopsound();
    } else {
      ent stopsounds();
    }

    waitframe();
    ent.soundalias = undefined;
  }

  ent.soundtype = undefined;
  function_3faaafc0bfa48453(ent);
}

function private function_9dc92ee851117f94(soundalias, done) {
  ent = self;
  ent endon("death");
  waittime = lookupsoundlength(soundalias);
  waittime *= 1.25;
  waittime /= 1000;
  pitchmin = function_f0ef19ea41182a49(soundalias, "pitch_min");

  if(isDefined(pitchmin)) {
    waittime *= 1 / pitchmin;
  }

  wait waittime;
  ent notify(done, ent.soundalias);
  function_3faaafc0bfa48453(ent);
}

function private function_f5abe4d9a18d99c7(done) {
  ent = self;
  ent endon("death");
  ent waittill(done);
  ent notify(done, ent.soundalias);
  function_3faaafc0bfa48453(ent);
}

function private function_ff4680a250fab665(ent, var_b042ad1a3b3400e8, linkedentity, linkedbonetag) {
  assertex(0, "snd: server centity unsupported");
}

function private function_7940c57b609bed52(soundalias, var_b042ad1a3b3400e8, linkedentity, linkedbonetag) {
  assertex(0, "snd: server centity unsupported");
  return undefined;
}

function private function_4269910fc1e0759f(ent) {
  assertex(0, "snd: server centity unsupported");
}

function private function_9802311630468f27(soundobject, soundalias, initialvolume, delaytime) {
  assertex(0, "snd: server centity unsupported");
}

function private function_e1ad0c284215f3b1(soundobject, fadeoutseconds) {
  assertex(0, "snd: server centity unsupported");
}

function private function_cfd6fc964dca520a() {
  player = self;
  vieworigin = player getEye();
  return vieworigin;
}

function private function_d4503656fc0a9c48() {
  player = self;
  viewangles = player getplayerangles();
  return viewangles;
}

function private function_6c8d0689823981ab() {
  player = self;
  fov = getdvarfloat(@ "cg_fov", 65);
  return fov;
}

function private function_f94e1534de6d5409(soundarg) {
  delaytime = 0;
  soundalias = undefined;
  fadeinseconds = undefined;

  if(isarray(soundarg)) {
    keys = soundarg;
    soundalias = undefined;
    aliasindex = keys.size + 1;

    foreach(i, key in keys) {
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

  sndparam = [delaytime, soundalias, fadeinseconds];
  return sndparam;
}

function private function_d3655eaed7181b30(targ) {
  targets = [];

  if(!isDefined(targ)) {
    foreach(player in getplayerssafe()) {
      tagname = player function_1437d15fc0a0a804("j_head");

      if(player.model != "" && tagname != "") {
        targets[targets.size] = [player, tagname];
        continue;
      }

      targets[targets.size] = player;
    }
  } else if(isarray(targ)) {
    if(function_110d3ab280057f5b(targ.size == 0, "snd: zero-sized array used for targ")) {
      return undefined;
    } else if(targ.size == 2) {
      if(isent(targ[0]) && isstring(targ[1])) {
        targets = [targ];
      } else if(isent(targ[0]) && isvector(targ[1])) {
        targets = [targ];
      } else if(isent(targ[0]) && !isDefined(targ[1])) {
        targets = [targ[0]];
      } else if(isstring(targ[0]) && isstring(targ[1])) {
        firsttargets = gettargetnames(targ[0]);
        secondtargets = gettargetnames(targ[1]);
        targets = array_combine(firsttargets, secondtargets);
      } else {
        targets = targ;
      }
    } else {
      targets = [];

      foreach(key in targ) {
        if(isent(key) || isstruct(key) && isDefined(key.origin) || isvector(key) || isarray(key)) {
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

function private function_88c8b4d475d4cfd(soundtype, soundalias, var_56cc972df3606c48, var_ee21476b751693ab) {
  if(function_110d3ab280057f5b(!function_f0b5522ee5ce0cb1(), "snd was not initialized!")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    return undefined;
  }

  if(function_110d3ab280057f5b(!isDefined(soundalias), "snd_play: sound alias undefined")) {
    return undefined;
  }

  level.snd.callbacks["stop"] = &snd_stop;
  assertex(isDefined(level.snd.var_6bb7b2b49f3454a1), "snd was not initialized");
  soundtype = default_to(soundtype, level.snd.var_6bb7b2b49f3454a1);
  soundobjects = [];
  targets = [];
  soundparam = function_f94e1534de6d5409(soundalias);
  assertex(isarray(soundparam) && soundparam.size == 3, "snd unexpected soundparam");
  delaytime = soundparam[0];
  soundalias = soundparam[1];
  fadeinseconds = soundparam[2];
  initialvolume = undefined;

  if(function_110d3ab280057f5b(isstring(soundalias) && soundalias == "", "snd_play: empty sound alias \"\"")) {
    return undefined;
  }

  assertex(isstring(soundalias), "snd: soundalias undefined");
  islooping = soundislooping(soundalias);
  sndexists = soundexists(soundalias);

  if(function_110d3ab280057f5b(!sndexists, "snd: sound alias '" + soundalias + "' does not exist!")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    return undefined;
  }

  if(!isDefined(fadeinseconds)) {
    if(islooping) {
      fadeinseconds = level.snd.var_c5b5d16976d4a8ef;
    } else {
      fadeinseconds = 0;
    }
  }

  if(isDefined(fadeinseconds) && fadeinseconds > 0) {
    initialvolume = 0;
  }

  assert(isDefined(fadeinseconds));
  targets = function_d3655eaed7181b30(var_56cc972df3606c48);

  if(function_110d3ab280057f5b(!isDefined(targets), "snd: undefined targets")) {
    return undefined;
  }

  foreach(t in targets) {
    linkedentity = undefined;
    linkedbonetag = undefined;
    var_b042ad1a3b3400e8 = undefined;
    soundobject = undefined;
    ise = isent(t);
    isr = function_5b8457b9d8edb521(t);
    iss = isstruct(t);
    isv = isvector(t);
    isn = isstring(t);
    isa = isarray(t);

    if(ise) {
      linkedentity = t;
      var_b042ad1a3b3400e8 = (0, 0, 0);
    } else if(function_110d3ab280057f5b(isr, "snd: could not play on removed entity")) {
      continue;
    } else if(iss) {
      if(function_110d3ab280057f5b(!isDefined(t.origin), "snd: sound alias '" + soundalias + "' played on struct with no origin!")) {
        continue;
      } else {
        var_b042ad1a3b3400e8 = t.origin;
      }
    } else if(isv) {
      var_b042ad1a3b3400e8 = t;
    } else if(isn) {} else if(isarray(t)) {
      if(!isDefined(t[0]) || function_5b8457b9d8edb521(t[0])) {
        continue;
      } else if(isent(t[0]) && isstring(t[1])) {
        linkedentity = t[0];
        linkedbonetag = t[1];
        var_b042ad1a3b3400e8 = (0, 0, 0);
      } else if(isent(t[0]) && isvector(t[1])) {
        linkedentity = t[0];
        var_b042ad1a3b3400e8 = t[1];
      } else if(function_110d3ab280057f5b(1, "snd: unexpected target array combination")) {}
    }

    switch (soundtype) {
      default:
        assertex(0, "snd: unknown soundtype");
        break;
      case #"hash_59f13b3cf23ba655":
        soundobject = function_32231133ccc402ee(soundalias, var_b042ad1a3b3400e8, linkedentity, linkedbonetag);

        if(isent(soundobject)) {
          function_2743b5d65cb4aa61(soundobject, var_b042ad1a3b3400e8, linkedentity, linkedbonetag);
          function_bf5653c442222ab8("gentity", soundobject.soundkey, soundobject);
          soundobject thread function_f6cebff1cb2afece();
        }

        break;
      case #"hash_9ffcd1094df9c111":
        soundobject = function_7940c57b609bed52(soundalias, var_b042ad1a3b3400e8, linkedentity, linkedbonetag);

        if(isent(soundobject)) {
          function_ff4680a250fab665(soundobject, var_b042ad1a3b3400e8, linkedentity, linkedbonetag);
          function_bf5653c442222ab8("centity", soundobject.soundkey, soundobject);
          soundobject thread function_f6cebff1cb2afece();
        }

        break;
    }

    if(isDefined(soundobject) && function_f0a31c88dbf01c1(soundobject)) {
      switch (soundtype) {
        case #"hash_59f13b3cf23ba655":
        default:
          soundobject thread function_2a7a90760153d57b(soundobject, soundalias, initialvolume, delaytime);
          break;
        case #"hash_9ffcd1094df9c111":
          soundobject thread function_9802311630468f27(soundobject, soundalias, initialvolume, delaytime);
          break;
      }

      if(fadeinseconds > 0) {
        if(soundtype == "gentity" && isDefined(linkedentity)) {
          delaytime += 0.05;
        }

        soundobject thread function_b1fd36299b09c0f5(soundobject, fadeinseconds, delaytime);
      }

      soundobjects[soundobjects.size] = soundobject;
    }
  }

  if(function_110d3ab280057f5b(soundobjects.size == 0, "snd: zero sound objects played")) {
    return undefined;
  }

  return function_3782ee9519fb76c3(soundobjects);
}

function private function_114485fecd709d37(soundobject, fadeoutseconds) {
  if(function_110d3ab280057f5b(!isstruct(level.snd) || !isDefined(level.snd.var_6bb7b2b49f3454a1), "snd was not initialized")) {
    return;
  }

  if(function_110d3ab280057f5b(!isDefined(soundobject) || function_5b8457b9d8edb521(soundobject), "snd_stop with undefined soundObject")) {
    return;
  }

  if(function_110d3ab280057f5b(!isDefined(soundobject.soundtype), "snd_stop with unknown type")) {
    return;
  }

  assertex(isDefined(level.snd.var_6bb7b2b49f3454a1), "snd was not initialized");
  assertex(isDefined(soundobject), "snd call missing soundObject parameter");
  assertex(isDefined(soundobject.soundtype), "snd with unknown type");

  if(soundobject.soundtype == "emitter") {
    soundobject notify("snd_emitter_stop");
    soundobject.soundtype = undefined;
    soundobject.soundalias = undefined;
    soundobject.var_c55912d11e27cbee = undefined;
    soundobject.origin = undefined;
    soundobject.angles = undefined;
    return;
  }

  soundobject endon("death");
  soundtype = soundobject.soundtype;
  soundalias = soundobject.soundalias;
  islooping = undefined;

  if(isstring(soundalias)) {
    islooping = soundislooping(soundalias);
  }

  if(istrue(islooping) && !isDefined(fadeoutseconds)) {
    fadeoutseconds = float(level.snd.var_c5b5d16976d4a8ef);
  } else if(isnumber(fadeoutseconds)) {
    fadeoutseconds = float(fadeoutseconds);
  }

  if(isDefined(soundalias) && isfloat(fadeoutseconds)) {
    function_e70d88e85d5fb19a(soundobject, 0, fadeoutseconds);
    wait fadeoutseconds;
    waitframe();

    if(function_5b8457b9d8edb521(soundobject)) {
      return;
    }
  }

  switch (soundtype) {
    case #"hash_59f13b3cf23ba655":
    default:
      function_e1f20b9363ca750d(soundobject, fadeoutseconds);
      break;
    case #"hash_9ffcd1094df9c111":
      function_e1ad0c284215f3b1(soundobject, fadeoutseconds);
      break;
  }
}

function private function_696597962461161(soundobject, notifyentity, notifystring, fadeoutseconds) {
  soundobject endon("death");
  notifyentity waittill_any_2("death", notifystring);
  function_114485fecd709d37(soundobject, fadeoutseconds);
}

function private function_eddfe63d2da7ee5c(soundobject, levelnotifystring, fadeoutseconds) {
  soundobject endon("death");
  level waittill(levelnotifystring);
  function_114485fecd709d37(soundobject, fadeoutseconds);
}

function private function_b1fd36299b09c0f5(soundobject, fadeinseconds, delaytime) {
  if(function_110d3ab280057f5b(!isDefined(soundobject) || function_5b8457b9d8edb521(soundobject), "snd: fade in on deleted gentity!")) {
    return;
  }

  assert(isDefined(soundobject));
  soundobject endon("death");
  soundobject endon("stopfade");
  delaytime = default_to(delaytime, 0);
  function_e70d88e85d5fb19a(soundobject, 0, 0);

  if(delaytime > 0) {
    wait delaytime;
  }

  function_e70d88e85d5fb19a(soundobject, 1, fadeinseconds);
}

function function_7670acb4b00bb0ac(target) {
  position = undefined;

  if(isvector(target)) {
    position = target;
  } else if(isplayersafe(target)) {
    position = target getplayervieworigin();
  } else if(!function_5b8457b9d8edb521(target) && isDefined(target.origin)) {
    position = target.origin;
  }

  return position;
}

function private function_2e4ee66733c986ee(rotationrange) {
  var_57338c9e11b3e93 = randomfloatrange(-180, 180);
  rotation = 0;

  if(isarray(rotationrange)) {
    if(rotationrange.size == 1) {
      rotationrange = rotationrange[0];
    } else if(rotationrange.size == 2) {
      rotation = rangehelper(rotationrange);
    } else if(rotationrange.size == 3) {
      var_57338c9e11b3e93 = rotationrange[0];
      rotation = rangehelper(rotationrange);
      var_cd04a8e443a298ea = [rotationrange[1], rotationrange[2]];
      rotation = rangehelper(var_cd04a8e443a298ea);
    } else if(rotationrange.size >= 4) {
      var_1c6878741047dda8 = [rotationrange[0], rotationrange[1]];
      var_57338c9e11b3e93 = rangehelper(var_1c6878741047dda8);
      var_cd04a8e443a298ea = [rotationrange[2], rotationrange[3]];
      rotation = rangehelper(var_cd04a8e443a298ea);
    }
  }

  if(isnumber(rotationrange) && rotationrange != 0) {
    absrotation = abs(rotationrange);
    min = -1 * absrotation;
    max = absrotation;
    rotation = randomfloatrange(min, max);
  }

  return [var_57338c9e11b3e93, rotation];
}

function private function_fe69ae3b76d26efa(target, dist, var_57338c9e11b3e93, elevation, rotation) {
  self endon("death");
  self endon("sounddone");

  if(isDefined(rotation) == 0 || rotation == 0) {
    return;
  }

  assertex(isent(target) || isstruct(target) && isDefined(target.origin) || isvector(target), "");
  assertex(isnumber(dist), "");
  assertex(isnumber(var_57338c9e11b3e93), "");
  assertex(isnumber(rotation), "");

  if(function_ec24f13736bfc421() > 2) {
    randred = randomfloat(1);
    randgreen = randomfloat(1);
    randblue = randomfloat(1);
    randomcolor = (randred, randgreen, randblue);
    randomcolor = vectorNormalize(randomcolor);
    snd_drawpath(self, randomcolor);
  }

  movetime = function_e448203aedcadcf8() * 2;
  rotationstep = rotation * movetime;

  while(true) {
    centerorigin = function_7670acb4b00bb0ac(target);

    if(!isvector(centerorigin)) {
      break;
    }

    position = function_3ad9433c6a61f479(centerorigin, dist, var_57338c9e11b3e93, elevation);
    self moveTo(position, movetime, 0, 0);
    var_57338c9e11b3e93 += rotationstep;
    wait movetime;

    if(function_ec24f13736bfc421() <= 2) {
      self notify("<dev string:x1c>");
    }
  }
}

function private function_71b899d04c402bb5(emitter) {
  iss = isstruct(emitter);
  hast = isDefined(emitter.soundtype);
  ist = emitter.soundtype == "emitter";
  is_emitter = iss && hast && ist;

  if(function_110d3ab280057f5b(is_emitter == 0, "snd emitter stop not an emitter")) {
    return;
  }

  assertex(isDefined(emitter.soundkey), "snd_emitter with no soundkey");
  assertex(isDefined(level.snd.emitterkey), "snd_emitter not initialized");
  assertex(isDefined(level.snd.emitters), "snd_emitters array not initialized");
  level.snd.emitters[emitter.soundkey] = undefined;
  emitter notify("snd_emitter_stop");
  emitter.soundtype = undefined;
  emitter.soundalias = undefined;
  emitter.var_c55912d11e27cbee = undefined;
  emitter.origin = undefined;
  emitter.angles = undefined;
  emitter = undefined;
}

function private function_5a53ef7be394d4a8(soundalias, target, spawntimerange, distancerange, rotationrange, var_c1acbb1d24b6efc5) {
  self endon("snd_emitter_stop");
  level endon("snd_emitter_stop");
  assertex(isDefined(target) && isarray(target) == 0, "snd_emitter target must be entity or vector");

  if(isvector(target)) {
    target = self;
  }

  targetposition = undefined;
  position = undefined;
  dist = rangehelper(default_to(distancerange, 0));
  var_ee2e91a46457edcd = function_2e4ee66733c986ee(rotationrange);
  assert(isarray(var_ee2e91a46457edcd) && var_ee2e91a46457edcd.size != 0);
  var_57338c9e11b3e93 = var_ee2e91a46457edcd[0];
  rotation = var_ee2e91a46457edcd[1];
  elevation = rangehelper(default_to(var_c1acbb1d24b6efc5, 0));

  if(isarray(spawntimerange) && spawntimerange.size >= 4) {
    assertex(spawntimerange.size == 4, "snd_emitter spawnTimeRange array size must be exactly 2 or 4 in size.");
    var_e500e5a50841701e = [spawntimerange[0], spawntimerange[1]];
    spawntime = rangehelper(var_e500e5a50841701e, 0.05);
    wait spawntime;
    targetposition = function_7670acb4b00bb0ac(target);
    position = function_3ad9433c6a61f479(targetposition, dist, var_57338c9e11b3e93, elevation);
    sndobj = snd_play(soundalias, position);

    if(isDefined(sndobj) && isDefined(dist) && dist > 0 && isDefined(rotation) && rotation != 0) {
      sndobj thread function_fe69ae3b76d26efa(target, dist, var_57338c9e11b3e93, rotation);
      spawntimerange = [spawntimerange[2], spawntimerange[3]];
    }
  }

  while(true) {
    spawntime = rangehelper(spawntimerange, 0.05);
    wait spawntime;

    if(!isDefined(target)) {
      break;
    }

    dist = rangehelper(default_to(distancerange, 0));
    var_ee2e91a46457edcd = function_2e4ee66733c986ee(rotationrange);
    assert(isarray(var_ee2e91a46457edcd) && var_ee2e91a46457edcd.size != 0);
    var_57338c9e11b3e93 = var_ee2e91a46457edcd[0];
    rotation = var_ee2e91a46457edcd[1];
    elevation = rangehelper(default_to(var_c1acbb1d24b6efc5, 0));
    targetposition = function_7670acb4b00bb0ac(target);
    position = function_3ad9433c6a61f479(targetposition, dist, var_57338c9e11b3e93, elevation);
    sndobj = snd_play(soundalias, position);

    if(isDefined(sndobj) && isDefined(dist) && dist > 0 && isDefined(rotation) && rotation != 0) {
      sndobj thread function_fe69ae3b76d26efa(target, dist, var_57338c9e11b3e93, elevation, rotation);
    }
  }
}

function snd_emitter(soundalias, target, spawntime, distancerange, rotation, elevation) {
  emitters = [];
  targets = target;
  islooping = soundislooping(soundalias);
  isexists = isDefined(islooping);

  if(function_110d3ab280057f5b(!isexists, "snd_emitter soundalias does not exist: " + soundalias)) {
    return undefined;
  }

  if(function_110d3ab280057f5b(islooping, "snd_emitter cannot emit looping alias: " + soundalias)) {
    return undefined;
  }

  if(!isDefined(level.snd.emitterkey)) {
    level.snd.emitterkey = 2432;
    level.snd.emitters = [];
  }

  assertex(isDefined(level.snd.emitterkey), "snd_emitter not initialized");
  assertex(soundexists(soundalias), "snd_emitter soundalias does not exist: " + soundalias);
  assertex(isDefined(target), "snd_emitter target is undefined");
  assertex(isDefined(spawntime), "snd_emitter spawnTime is undefined");

  if(isarray(targets) == 0) {
    targets = [target];
  }

  foreach(t in targets) {
    ise = isent(t);
    isv = isvector(t);

    if(ise || isv) {
      emitter = spawnStruct();
      emitter.soundtype = "emitter";
      emitter.soundalias = soundalias;
      emitter.spawntime = spawntime;
      emitter.distancerange = distancerange;
      emitter.rotation = rotation;
      emitter.elevation = elevation;
      level.snd.emitterkey = int(level.snd.emitterkey + 1);
      emitter.soundkey = "" + level.snd.emitterkey;
      level.snd.emitters[emitter.soundkey] = emitter;

      if(ise) {
        emitter.var_c55912d11e27cbee = t;
      }

      if(isv) {
        emitter.origin = t;
        emitter.angles = (0, 0, 0);
      }

      emitter thread function_5a53ef7be394d4a8(soundalias, t, spawntime, distancerange, rotation, elevation);
      emitters[emitters.size] = emitter;
      continue;
    }

    function_110d3ab280057f5b(ise == 0 && isv == 0, "snd_emitter target '" + t + "' was not an entity or vector.");
  }

  function_110d3ab280057f5b(emitters.size == 0, "snd_emitter resulted in zero emitter targets");
  return function_3782ee9519fb76c3(emitters);
}

function private function_ee1f9b08b748b2bf(alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog) {
  if(is_dead_sentient()) {
    return;
  }

  target = [self, tag];
  snd = namespace_53c50dd747d66443::function_88c8b4d475d4cfd(level.snd.var_6bb7b2b49f3454a1, alias, target);

  if(isDefined(level.player_radio_emitter) && self == level.player_radio_emitter) {
    println("<dev string:x2e>" + alias);
  }

  if(isDefined(ends_on_death)) {
    assertex(ends_on_death, "ends_on_death must be true or undefined");
    namespace_53c50dd747d66443::function_a9bcfafb96e69580(snd, self);
  }

  namespace_53c50dd747d66443::snd_wait(snd);

  if(isDefined(var_b426f32755673ba6)) {
    self notify(var_b426f32755673ba6);
  }
}

function private function_ee9c171db1ae676e(alias, var_b426f32755673ba6) {
  assertex(!isspawner(self), "Spawner tried to play a sound");
  function_ee1f9b08b748b2bf(alias, undefined, undefined, var_b426f32755673ba6);
}

function private function_4df9eee6e5769696(soundalias, notifystring, var_fe0cdb15e0d3c83f) {
  var_fe0cdb15e0d3c83f = default_to(var_fe0cdb15e0d3c83f, 0);

  if(is_dead_sentient()) {
    return;
  }

  target = [self, "j_head"];
  snd = function_88c8b4d475d4cfd(level.snd.var_6bb7b2b49f3454a1, soundalias, target);

  if(var_fe0cdb15e0d3c83f) {
    namespace_53c50dd747d66443::function_a9bcfafb96e69580(snd, self);
  }

  if(isDefined(notifystring)) {
    thread function_1cf95ea7031cf826(snd, notifystring);
  }
}

function private function_1cf95ea7031cf826(snd, notifystring) {
  namespace_53c50dd747d66443::snd_wait(snd);
  self notify(notifystring);
}

function private function_f1fa7d6753f06a41(notetrack) {
  prefix = getsubstr(notetrack, 0, 3);

  if(prefix == "ps_") {
    alias = getsubstr(notetrack, 3);
    params = strtok(alias, ",");

    if(params.size < 2) {
      thread function_ee1f9b08b748b2bf(alias, undefined, 1);
    } else {
      thread function_ee1f9b08b748b2bf(params[0], params[1], 1);
    }

    return 1;
  }

  if(prefix == "vo_") {
    alias = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](alias, "j_head", 1);
    } else {
      thread function_ee1f9b08b748b2bf(alias, "j_head", 1, alias);
    }

    return 1;
  }

  if(isDefined(level.snd.fnnotetrackprefixhandler)) {
    return self[[level.snd.fnnotetrackprefixhandler]](notetrack);
  }

  return 0;
}

function function_a0b9c82d6558a5b5(curve, size) {
  lut = [];
  step = 1 / (size - 1);

  for(i = 0; i < size; i++) {
    x = i * step;
    y = 0;

    switch (curve) {
      default:
        assert(0);
        break;
      case #"hash_28724bf44fcad5a":
      case #"hash_a07b7ad0ae57b120":
        lut[0] = 0;
        lut[1] = 1;
        return lut;
      case #"hash_d14c288a042b2358":
        y = 0.5 + cos(x * 180) * -0.5;
        break;
      case #"hash_e5b5c9bbaf55cda4":
        y = 1 - cos(x * 90);
        break;
      case #"hash_c61d0274ec76f271":
        y = sin(x * 90);
        break;
      case #"hash_6975a515a3376748":
        y = 3 * pow(x, 2) - 2 * pow(x, 3);
        break;
      case #"hash_2e3e9521be134e7f":
        y = 1 - sqrt(1 - x * x);
        break;
      case #"hash_9e33f1e4dcc4f04":
        y = sqrt(1 - (1 - x) * (1 - x));
        break;
      case #"hash_e004d61d10ac743f":
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
      case #"hash_3906f2285eb98bad":
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

function function_301f98e25e20c1ab(size) {
  size = default_to(size, 11);
  assertex(isstruct(level.snd), "snd was not initialized.");
  level.snd.curves = [];
  level.snd.curves["linear"] = function_a0b9c82d6558a5b5("linear", size);
  level.snd.curves["sine"] = function_a0b9c82d6558a5b5("sine", size);
  level.snd.curves["easein"] = function_a0b9c82d6558a5b5("easein", size);
  level.snd.curves["easeout"] = function_a0b9c82d6558a5b5("easeout", size);
  level.snd.curves["easeinout"] = function_a0b9c82d6558a5b5("easeinout", size);
  level.snd.curves["circularin"] = function_a0b9c82d6558a5b5("circularin", size);
  level.snd.curves["circularout"] = function_a0b9c82d6558a5b5("circularout", size);
  level.snd.curves["exponential_40db"] = function_a0b9c82d6558a5b5("exponential_40db", size);
  level.snd.curves["exponential_60db"] = function_a0b9c82d6558a5b5("exponential_60db", size);
  level.snd.curves["default_vfcurve"] = function_a0b9c82d6558a5b5("default_vfcurve", size);
}

function private function_f3a9bb58d29c733a(alias) {
  if(!isDefined(alias)) {
    return "easeout";
  }

  switch (alias) {
    case #"hash_e72a3996c47e1ac9":
      return "easeout";
  }

  return alias;
}

function function_f17e814008bf23a4(curve) {
  lut = level.snd.curves[function_f3a9bb58d29c733a(curve)];

  if(isDefined(lut)) {
    return lut.size;
  }

  return 0;
}

function function_115055e88972de05(curve) {
  lut = level.snd.curves[curve];

  if(isDefined(lut)) {
    return true;
  }

  return false;
}

function function_e6ef280f5472a1d2(inval, curve) {
  curve = function_f3a9bb58d29c733a(curve);
  lut = level.snd.curves[curve];
  assertex(isDefined(lut), "snd_curve_value: could not find lookup table " + curve);
  inval = clamp(inval, 0, 1);
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

function private function_b8022e006c096aa7(name) {
  if(isDefined(self.snd.params) == 0) {
    return;
  }

  if(isDefined(name)) {
    if(isDefined(self.snd.params[name])) {
      if(isDefined(self.snd.params[name].stopcallback)) {
        self[[self.snd.params[name].stopcallback]](self.snd.params[name].userdata);
      }

      self.snd.params[name] = undefined;
    }
  } else {
    foreach(p in self.snd.params) {
      if(isDefined(p.stopcallback)) {
        self[[p.stopcallback]](p.userdata);
      }

      self.snd.params = undefined;
    }
  }

  if(isDefined(self.snd.params) == 0 || self.snd.params.size == 0) {
    level.snd.param_ents = array_remove(level.snd.param_ents, self);
    level.snd.param_ents = array_removeundefined(level.snd.param_ents);
    self.snd.params = undefined;
    self.snd.paramthread = undefined;
    self notify("param_stop");
  }
}

function private function_6833106b5e960c6b() {
  self endon("param_stop");
  waittill_any_2("death", "disconnect");
  function_b8022e006c096aa7();
}

function private function_da383238aee79a39() {
  if(isDefined(self.snd.paramthread)) {
    return;
  }

  self.snd.paramthread = getthread();
  thread function_6833106b5e960c6b();
  self endon("disconnect");
  self endon("param_stop");

  while(function_5b8457b9d8edb521(self) == 0 && isDefined(self.snd.params) && self.snd.params.size > 0) {
    now = gettime();

    foreach(p in self.snd.params) {
      p.isprocessing = 1;

      if(isDefined(p.inputcallback)) {
        assertex(isent(self), "snd_param ent is not valid. was there a wait in an input callback?");
        p.inputvalue = self[[p.inputcallback]](p.userdata);
        assertex(gettime() == now, "snd_param input callback must return without waiting!");
      }

      if(isDefined(p.outputcallbacks)) {
        if(p.userdata.size > 0) {
          assertex(p.outputcallbacks.size == p.userdata.size, "snd_param has invalid output / userdata state");
        }

        foreach(outputcallback in p.outputcallbacks) {
          if(isent(self)) {
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

    waitframe();
  }

  if(function_5b8457b9d8edb521(self)) {
    function_b8022e006c096aa7();
  }
}

function private function_afa0d9063a40dfe(name) {
  if(isDefined(level.snd.param_ents) == 0) {
    level.snd.param_ents = [];
  }

  assertex(isarray(level.snd.param_ents), "snd_param not initialized on level");
  function_b3e5599c9f6a8895(self);

  if(isDefined(self.snd.params) == 0) {
    self.snd.params = [];
  }

  assertex(isarray(self.snd.params), "snd_param not initialized on entity");

  if(isDefined(self.snd.params[name]) == 0) {
    self.snd.params[name] = spawnStruct();
  }

  if(array_contains(level.snd.param_ents, self) == 0) {
    level.snd.param_ents[level.snd.param_ents.size] = self;
  }
}

function function_1bec576d8688dbc1(name, inputcallback) {
  function_afa0d9063a40dfe(name);
  self.snd.params[name].inputcallback = inputcallback;
  self.snd.params[name].inputvalue = undefined;
  thread function_da383238aee79a39();
}

function function_775073c6517ceb5e(name, outputcallback, userdata) {
  function_afa0d9063a40dfe(name);

  if(isDefined(self.snd.params[name].outputcallbacks) == 0) {
    self.snd.params[name].outputcallbacks = [];
  }

  assertex(isDefined(self.snd.params[name]), "snd_param input '" + name + "' not initialized on entity");
  assertex(isDefined(self.snd.params[name].outputcallbacks), "snd_param not initialized on entity");
  assertex(isarray(self.snd.params[name].outputcallbacks), "snd_param not initialized on entity");
  var_91920809a5e8e2b9 = self.snd.params[name].outputcallbacks.size;
  self.snd.params[name].outputcallbacks[var_91920809a5e8e2b9] = outputcallback;

  if(isDefined(self.snd.params[name].userdata) == 0) {
    self.snd.params[name].userdata = [];
  }

  if(array_contains(self.snd.params[name].userdata, userdata) == 0) {
    userdataindex = self.snd.params[name].userdata.size;
    self.snd.params[name].userdata[userdataindex] = userdata;
  } else {
    if(function_a3da201852146397()) {
      DevOp(0x94);
    }
  }

  thread function_da383238aee79a39();
}

function private function_eef3b433a76adca0(name, startcallback, stopcallback) {
  function_afa0d9063a40dfe(name);
  self.snd.params[name].startcallback = startcallback;
  self.snd.params[name].stopcallback = stopcallback;

  if(isDefined(self.snd.params[name].startcallback)) {
    self[[self.snd.params[name].startcallback]]();
  }
}

function function_96d11f9981c0fe4b(name) {
  function_b8022e006c096aa7(name);
}

function snd_param(name, startcallback, inputcallback, outputcallback, stopcallback, userdata) {
  function_eef3b433a76adca0(name, startcallback, stopcallback);
  function_1bec576d8688dbc1(name, inputcallback);
  function_775073c6517ceb5e(name, outputcallback, userdata);
}

function function_feb1a4f9eda07b44(name) {
  if(isDefined(self.snd.params) && isDefined(self.snd.params[name]) && isDefined(self.snd.params[name].inputcallback)) {
    p = self.snd.params[name];

    if(isDefined(p.inputvalue)) {
      return p.inputvalue;
    } else {
      return self[[p.inputcallback]](p.userdata);
    }
  }

  return undefined;
}

function function_db43aa8b88926353(name) {
  if(isDefined(self.snd.params) && isarray(self.snd.params) && isDefined(self.snd.params[name])) {
    return true;
  }

  return false;
}

function function_1fc874ce2bd0cc74(inputcallback) {
  if(isDefined(self.snd.params) && isarray(self.snd.params)) {
    foreach(p in self.snd.params) {
      if(p.inputcallback == inputcallback) {
        return true;
      }
    }
  }

  return false;
}

function private function_95848ecd26935b4b(userdata) {
  assert(isDefined(self.origin));
  now = gettime();

  if(isDefined(self.origin_velocity_time) && self.origin_velocity_time == now) {
    assert(isDefined(self.origin_velocity));
    return self.origin_velocity;
  }

  if(isDefined(self.origin_last) == 0) {
    self.origin_last = self.origin;
  }

  delta = self.origin - self.origin_last;
  self.origin_velocity = delta;
  self.origin_velocity_time = now;
  self.origin_last = self.origin;
  return self.origin_velocity;
}

function private function_f2d694165b0e0e17(userdata) {
  assert(isDefined(self.origin));
  assert(isDefined(self.snd));
  assert(isDefined(self.snd.origin_speed));
  velocity = function_95848ecd26935b4b();
  speed = length(velocity);
  self.snd.origin_speed = function_eb651502ea5a7ea8(speed, self.snd.origin_speed, 0.05);

  if(function_ec24f13736bfc421() >= 2) {
    debugspeed = self.snd.origin_speed;

    if(debugspeed < 0.001) {
      debugspeed = 0;
    }

    var_750a2993c537e7b0 = function_692101820901e01a(debugspeed * function_9f6e6c09d0cac253() * 0.0568182, 1) + "<dev string:x4d>" + function_692101820901e01a(debugspeed, 1) + "<dev string:x55>";
    debugcolor = level.snd.debug.color_3d;
    debugalpha = 0.9;
    var_de81b175de6cc8a8 = debugalpha * debugalpha;
    debugscale = level.snd.debug.scale_3d;
    colorscale = level.snd.debug.color_scale;
    debugcolor = function_1f9e5d44e92014a5(debugcolor, colorscale * 10);
    debugframes = 1;
    debugoffset = (0, 0, 4 * debugscale * 16);
    print3dplus(var_750a2993c537e7b0, self.origin + debugoffset, -1 * debugscale, "<dev string:x5a>", debugcolor, debugalpha, (0, 0, 0), var_de81b175de6cc8a8, (1, 1, 1), var_de81b175de6cc8a8, debugframes);
  }

  return self.snd.origin_speed;
}

function private function_bfab56d23a4691f8(userdata) {
  assert(isDefined(self.angles));
  now = gettime();

  if(isDefined(self.angle_time) && self.angle_time == now) {
    assert(isDefined(self.snd.angles));
    return self.snd.angles;
  }

  angles = self.angles;

  if(isplayersafe(self)) {
    angles = getplayerviewangles();
  } else if(isDefined(self.model)) {
    hastag = 0;

    if(hastag == 0) {
      angles = self gettagangles("tag_origin");
    }
  }

  angles = function_c4cc5b1e29ed927(angles);

  if(isDefined(self.snd.angles) == 0) {
    self.snd.angles = angles;
  }

  if(isDefined(self.snd.angles_last) == 0) {
    self.snd.angles_last = angles;
  }

  self.snd.angles_last = self.snd.angles;
  self.snd.angles = angles;
  return self.snd.angles;
}

function private function_ab6b2e892ee33fe3(userdata) {
  angles = function_bfab56d23a4691f8(userdata);
  self.snd.angle_velocity = angles - self.snd.angles_last;
  return self.snd.angle_velocity;
}

function private function_9af2a1ae11395b08(speedlayer, initialvolume, initialpitch) {
  speedlayer.snd = snd_play(speedlayer.soundalias, speedlayer.target);
  function_e70d88e85d5fb19a(speedlayer.snd, initialvolume, 0);
  function_a2c9c85b2af7c7fe(speedlayer.snd, initialpitch, 0);
}

function private function_d1642191e07fc7f0(speedlayer, fadetime, fadecurve) {
  if(isDefined(speedlayer) && isDefined(speedlayer.snd)) {
    fadetime = default_to(fadetime, 0);
    fadecurve = default_to(fadecurve, "easeinout");

    if(isDefined(fadetime) && fadetime > 0) {
      function_e70d88e85d5fb19a(speedlayer.snd, 0, fadetime, fadecurve);
      wait fadetime;
    }

    snd_stop(speedlayer.snd);
    speedlayer.snd = undefined;
  }
}

function private function_653bedee3bcc58bd(inputvalue, userdata) {
  speed = inputvalue;
  v = userdata;

  if(speed < 0.01) {
    speed = 0;
  }

  var_640a3fbfe37f7312 = v.var_270c723c3b5f910b["speed"][0];
  var_63e749bfe3594158 = v.var_270c723c3b5f910b["speed"][1];
  var_7f89dca4fd0c82e5 = v.var_270c723c3b5f910b["scale"][0];
  var_7fade6a4fd35139b = v.var_270c723c3b5f910b["scale"][1];
  volumecurve = v.var_270c723c3b5f910b["curve"][0];
  var_57dd5bc37ee77d94 = v.var_bb71b5efdeeee611["speed"][0];
  var_580149c37f0fd0b6 = v.var_bb71b5efdeeee611["speed"][1];
  var_df0dce5971287c53 = v.var_bb71b5efdeeee611["scale"][0];
  var_df30e459714ef46d = v.var_bb71b5efdeeee611["scale"][1];
  pitchcurve = v.var_bb71b5efdeeee611["curve"][0];
  volume = scalerp(speed, var_640a3fbfe37f7312, var_63e749bfe3594158, var_7f89dca4fd0c82e5, var_7fade6a4fd35139b);
  pitch = scalerp(speed, var_57dd5bc37ee77d94, var_580149c37f0fd0b6, var_df0dce5971287c53, var_df30e459714ef46d);

  if(isDefined(self.snd.doppler) && isDefined(self.snd.doppler.value)) {
    pitch *= self.snd.doppler.value;
  }

  if(isDefined(v.snd) && volume <= 0.001) {
    thread function_d1642191e07fc7f0(v);
    return;
  } else if(isDefined(v.snd) == 0 && volume > 0.001) {
    function_9af2a1ae11395b08(v, volume, pitch);
    v.speed_last = speed;
    return;
  }

  if(isDefined(v.snd) && isDefined(v.speed_last)) {
    speed_delta = abs(speed - v.speed_last);

    if(speed_delta > 0.01) {
      function_e70d88e85d5fb19a(v.snd, volume, 0.05, volumecurve);
      function_a2c9c85b2af7c7fe(v.snd, pitch, 0.05, pitchcurve);
      v.speed_last = speed;
    }
  }
}

function private function_28a90b1ade70dc5c(userdata) {
  fadeout = self.snd.speedsfadeout;
  fadeoutcurve = self.snd.var_82f743323a519d6c;

  if(isDefined(userdata)) {
    foreach(v in userdata) {
      thread function_d1642191e07fc7f0(v, fadeout, fadeoutcurve);
    }
  }

  self.snd.var_bdb184b54e906021 = undefined;
  self.snd.speedsfadeout = undefined;
  self.snd.var_82f743323a519d6c = undefined;
  self.snd.speeds = undefined;
}

function private function_d80f1d438bdc691f(target, soundalias, var_bb71b5efdeeee611, var_270c723c3b5f910b) {
  ent = undefined;
  islooping = soundislooping(soundalias);

  if(!isarray(target)) {
    ent = target;
  } else if(target.size > 0) {
    ent = target[0];
  }

  if(function_110d3ab280057f5b(!isent(ent), "snd_speed: target entity not found!")) {
    return;
  }

  if(function_110d3ab280057f5b(!isDefined(islooping), "snd_speed: alias '" + soundalias + "' does not exist!")) {
    return;
  }

  if(function_110d3ab280057f5b(!istrue(islooping), "snd_speed: alias '" + soundalias + "' is not looping!")) {
    return;
  }

  if(function_110d3ab280057f5b(!isarray(var_bb71b5efdeeee611), "snd_speed: pitchDict is not an array!")) {
    return;
  }

  if(function_110d3ab280057f5b(!isarray(var_270c723c3b5f910b), "snd_speed: volumeDict is not an array!")) {
    return;
  }

  function_b3e5599c9f6a8895(ent);
  assertex(isstruct(ent.snd), "_snd_speed_main ent with no snd init");
  speedlayer = spawnStruct();
  speedlayer.soundalias = soundalias;
  speedlayer.target = target;
  speedlayer.var_bb71b5efdeeee611 = var_bb71b5efdeeee611;
  speedlayer.var_270c723c3b5f910b = var_270c723c3b5f910b;
  speedlayer.var_bb71b5efdeeee611["curve"] = default_to(speedlayer.var_bb71b5efdeeee611["curve"], ["linear"]);
  speedlayer.var_270c723c3b5f910b["curve"] = default_to(speedlayer.var_270c723c3b5f910b["curve"], ["xfade"]);
  ent.snd.speeds = default_to(ent.snd.speeds, []);
  ent.snd.speeds[ent.snd.speeds.size] = speedlayer;
  ent.snd.origin_speed = 0;
  ent snd_param("speed", undefined, &function_f2d694165b0e0e17, &function_653bedee3bcc58bd, &function_28a90b1ade70dc5c, speedlayer);
}

function function_fd77ba9b1a318099(target, fadeout, fadeoutcurve) {
  fadeout = default_to(fadeout, 0.05);
  fadeoutcurve = default_to(fadeoutcurve, "easeinout");
  ent = undefined;

  if(!isarray(target)) {
    ent = target;
  } else if(target.size > 0) {
    ent = target[0];
  }

  if(function_110d3ab280057f5b(!isent(ent), "snd_speed: target entity not found!")) {
    return;
  }

  ent.snd.var_bdb184b54e906021 = 1;
  ent.snd.speedsfadeout = fadeout;
  ent.snd.var_82f743323a519d6c = fadeoutcurve;
  ent function_96d11f9981c0fe4b("speed");
}

function snd_speed(target, alias, var_bb71b5efdeeee611, var_270c723c3b5f910b) {
  level thread function_d80f1d438bdc691f(target, alias, var_bb71b5efdeeee611, var_270c723c3b5f910b);
}

function function_ad44dad83d5fa19e(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale, var_83c847736bed906) {
  assert(isvector(src_origin));
  assert(isvector(src_velocity));
  assert(isvector(dst_origin));
  assert(isvector(dst_velocity));
  src_scale = default_to(src_scale, 1);
  dst_scale = default_to(dst_scale, 1);
  var_83c847736bed906 = default_to(var_83c847736bed906, 343.3);

  if(src_scale == 0 && dst_scale == 0 || var_83c847736bed906 == 0) {
    return [0, 0, 0];
  }

  var_d1b36d182e789860 = 39.3701 * var_83c847736bed906;
  assert(isnumber(src_scale));
  assert(isnumber(dst_scale));
  assert(isnumber(var_d1b36d182e789860));
  delta_origin = src_origin - dst_origin;
  len = length(delta_origin);
  var_82fbb6e7bc0e9a16 = 0;
  var_d3203d6399241453 = 0;

  if(src_scale > 0 && src_velocity != (0, 0, 0)) {
    var_82fbb6e7bc0e9a16 = vectordot(src_velocity, delta_origin) / len;
    var_82fbb6e7bc0e9a16 *= src_scale;
  }

  if(dst_scale > 0 && dst_velocity != (0, 0, 0)) {
    var_d3203d6399241453 = vectordot(dst_velocity, delta_origin) / len;
    var_d3203d6399241453 *= dst_scale;
  }

  dopplerscale = (var_d1b36d182e789860 - var_82fbb6e7bc0e9a16) / (var_d1b36d182e789860 - var_d3203d6399241453);
  return [dopplerscale, var_82fbb6e7bc0e9a16, var_d3203d6399241453];
}

function private function_73239e48c1f6929b() {}

function private function_c69efdf57402f1c3(userdata) {
  var_52017d9bfee9e3a4 = arraycopy(level.snd.param_ents);
  var_9a197a3837525172 = 0;
  var_dfc140baf957db23 = [];
  var_52017d9bfee9e3a4 = array_remove(var_52017d9bfee9e3a4, self);

  foreach(var_8d9574b86ef251bf in var_52017d9bfee9e3a4) {
    if(var_8d9574b86ef251bf function_db43aa8b88926353("doppler")) {
      var_9a197a3837525172 += 1;

      if(isplayersafe(var_8d9574b86ef251bf)) {
        var_dfc140baf957db23[var_dfc140baf957db23.size] = var_8d9574b86ef251bf;
      }
    }
  }

  if(var_9a197a3837525172 == var_dfc140baf957db23.size) {
    foreach(player in var_dfc140baf957db23) {
      player function_96d11f9981c0fe4b("doppler");
    }
  }
}

function private function_3e1c8ad0ace0b40a(inputvalue, userdata) {
  player = userdata;

  if(!isplayersafe(player)) {
    return;
  }

  assert(isDefined(player));
  assert(isDefined(self));
  assert(isDefined(self.snd));
  assert(isDefined(self.snd.doppler));
  assert(isDefined(self.snd.doppler.scale));
  assert(isDefined(self.snd.doppler.playerscale));
  src_origin = self.origin;
  src_velocity = inputvalue;
  src_scale = self.snd.doppler.scale;
  dst_origin = player getplayervieworigin();
  dst_velocity = player function_feb1a4f9eda07b44("doppler");
  dst_scale = self.snd.doppler.playerscale;

  if(isDefined(dst_velocity) == 0 || self.snd.doppler.playerscale == 0) {
    dst_velocity = (0, 0, 0);
  }

  assert(isvector(src_origin));
  assert(isvector(src_velocity));
  assert(isnumber(src_scale));
  assert(isvector(dst_origin));
  assert(isvector(dst_velocity));
  assert(isnumber(dst_scale));
  var_b6e775fcff80d699 = function_ad44dad83d5fa19e(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale);
  dopplerscale = var_b6e775fcff80d699[0];

  if(isDefined(self.snd.doppler.pitchscale)) {
    dopplerscale *= self.snd.doppler.pitchscale;
  }

  dopplerscale = clamp(dopplerscale, 0.01, 2);
  self.snd.doppler.value = dopplerscale;

  if(function_f0a31c88dbf01c1(self)) {
    function_a2c9c85b2af7c7fe(self, dopplerscale, function_e448203aedcadcf8());
  }

  if(function_ec24f13736bfc421() > 1) {
    debugscale = level.snd.debug.scale_3d;
    audiocolor = level.snd.debug.color_3d;
    colorscale = level.snd.debug.color_scale;
    selectioncolor = function_1f9e5d44e92014a5(audiocolor, colorscale * 10);
    var_313ae10332ea71c8 = var_b6e775fcff80d699[1];
    dist = distance(src_origin, dst_origin);
    var_abeed90f073feea9 = dist * 0.002;
    scale = debugscale * 0.666 * var_abeed90f073feea9;
    alpha = 1;
    alphasq = alpha * alpha;
    var_aca821760f2f4441 = "<dev string:x61>";
    var_512eadbfa4e5120 = dopplerscale + "<dev string:x6b>" + var_313ae10332ea71c8;
    print3dplus(var_aca821760f2f4441, src_origin + (0, 0, -1 * scale * 16), scale, "<dev string:x6f>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    print3dplus(var_512eadbfa4e5120, src_origin + (0, 0, -1 * scale * 16), scale, "<dev string:x75>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
  }
}

function private _snd_doppler_main(player, dopplerscale, pitchscale, var_aa54cc5521fdb017) {
  assert(isplayersafe(player));
  dopplerscale = default_to(dopplerscale, 1);
  pitchscale = default_to(pitchscale, 1);
  var_aa54cc5521fdb017 = default_to(var_aa54cc5521fdb017, 1);
  assert(isDefined(player));

  if(var_aa54cc5521fdb017 > 0) {
    player snd_param("doppler", undefined, &function_95848ecd26935b4b);
  }

  if(function_5b8457b9d8edb521(self)) {
    return;
  }

  function_b3e5599c9f6a8895(self);
  self.snd.doppler = spawnStruct();
  self.snd.doppler.scale = dopplerscale;
  self.snd.doppler.pitchscale = pitchscale;
  self.snd.doppler.playerscale = var_aa54cc5521fdb017;
  snd_param("doppler", undefined, &function_95848ecd26935b4b, &function_3e1c8ad0ace0b40a, &function_c69efdf57402f1c3, player);
}

function snd_doppler(soundobject, player, dopplerscale, pitchscale, var_aa54cc5521fdb017) {
  if(function_110d3ab280057f5b(isDefined(soundobject) == 0, "snd_doppler with undefined soundObject")) {
    return;
  }

  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    soundobj thread _snd_doppler_main(player, dopplerscale, pitchscale, var_aa54cc5521fdb017);
  }
}

function snd_doppler_stop(soundobject) {
  if(function_110d3ab280057f5b(isDefined(soundobject) == 0, "snd_doppler_stop with undefined soundObject")) {
    return;
  }

  foreach(soundobj in function_5762e7cb509e83c0(soundobject)) {
    soundobj function_c69efdf57402f1c3();
  }
}

function private function_80aa5254a4d828d6(callback, allowretrigger) {
  level notify("snd_stop_start");
  level endon("snd_stop_start");
  allowretrigger = default_to(allowretrigger, 1);
  assertex(isstruct(level.snd), "snd was not initialized.");
  assert(isscriptfunction(callback));
  assert(isDefined(allowretrigger));
  flag_wait("start_is_set");
  start_points = [];
  start_point = function_80ab0bb7534149c0();

  while(true) {
    level waittill("start_logic", start_point);
    level.snd.start_point = start_point;
    waittillframeend();

    if(!isstring(start_point) || start_point == "") {
      continue;
    }

    if(allowretrigger || !allowretrigger && !isDefined(start_points[start_point])) {
      level thread[[callback]](start_point);
      start_points[start_point] = 1;
    }
  }
}

function function_c10ad7950de75f96(callback, allowretrigger) {
  level thread function_80aa5254a4d828d6(callback, allowretrigger);
}

function private function_bafbd550ab234c4f(trigger, player) {
  if(!isplayersafe(player)) {
    return;
  }

  is_touching = 0;

  if(isent(trigger)) {
    is_touching = player istouching(trigger);
  } else if(trigger == level) {
    if(!isDefined(player.snd.trigger) || isDefined(player.snd.trigger) && player.snd.trigger == level) {
      is_touching = 1;
    }
  }

  return is_touching;
}

function private function_63e183cd49335a12() {
  waitforplayers();
  waitframe();
  waittillframeend();

  foreach(player in getplayerssafe()) {
    level notify("trigger", player);
  }
}

function private function_ce7cbb5aae13431e(callback) {
  level endon("game_ended");
  self endon("death");
  triggers_default = [level];
  trigger = self;
  assert(isDefined(trigger));

  while(true) {
    player = undefined;
    trigger waittill("trigger", player);
    is_touching = function_bafbd550ab234c4f(trigger, player);
    function_b3e5599c9f6a8895(player);
    assertex(isstruct(player.snd), "_snd_trigger_main player with no snd init");

    if(is_touching) {
      player.snd.triggers = default_to(player.snd.triggers, triggers_default);
      assert(isarray(player.snd.triggers) && isDefined(player.snd.triggers[0]) && player.snd.triggers[0] == level);

      if(trigger != level) {
        player.snd.triggers[player.snd.triggers.size] = trigger;
      }

      haspriority = isDefined(player.snd.trigger.script_ambientpriority) && isDefined(trigger.script_ambientpriority);
      var_cb7cb2b095f4a00 = haspriority && int(player.snd.trigger.script_ambientpriority) <= int(trigger.script_ambientpriority);

      if(!isDefined(player.snd.trigger) || haspriority && var_cb7cb2b095f4a00 || !haspriority) {
        player.snd.trigger = trigger;
        trigger thread[[callback]](player, trigger, 1);
      }

      while(is_touching) {
        is_touching = function_bafbd550ab234c4f(trigger, player);
        waitframe();
      }

      if(!isDefined(player)) {
        continue;
      }

      if(trigger != level) {
        player.snd.triggers = array_remove(player.snd.triggers, trigger);
      }

      if(player.snd.trigger == trigger) {
        next_trigger = undefined;

        if(haspriority) {
          next_trigger = level;
          var_9ff9530a034ae58 = -1;

          for(i = player.snd.triggers.size - 1; i > 0; i--) {
            other_trigger = player.snd.triggers[i];

            if(isDefined(other_trigger.script_ambientpriority)) {
              var_8d0c6ccd9012df37 = int(other_trigger.script_ambientpriority);

              if(var_8d0c6ccd9012df37 > var_9ff9530a034ae58) {
                next_trigger = other_trigger;
                var_9ff9530a034ae58 = var_8d0c6ccd9012df37;
              }
            }
          }
        } else {
          assert(player.snd.triggers.size > 0);
          index = player.snd.triggers.size - 1;
          assert(index >= 0);
          next_trigger = player.snd.triggers[index];
        }

        if(isDefined(next_trigger)) {
          player.snd.trigger = next_trigger;
          next_trigger thread[[callback]](player, next_trigger, 0);
          continue;
        }

        player.snd.trigger = undefined;
        level notify("trigger", player);
      }
    }
  }
}

function function_37a9b1e456beb42a(callback, name, key) {
  name = default_to(name, "ambient_package");
  key = default_to(key, "targetname");
  triggers = [level];
  found_triggers = undefined;

  if(istrue(level.snd.var_78f5f86726c0fdb5)) {
    found_triggers = getEntArray(name, key);
  } else if(istrue(level.snd.var_ab52ccadc04df539)) {
    found_triggers = getEntArray(0, name, key);
  }

  if(isarray(found_triggers)) {
    triggers = array_combine(triggers, found_triggers);
  }

  foreach(trigger in function_5762e7cb509e83c0(triggers)) {
    trigger thread function_ce7cbb5aae13431e(callback);
  }

  level thread function_63e183cd49335a12();
}

function function_54c3fa447687f86(name, elements) {
  assert(function_f0b5522ee5ce0cb1());
  var_28b2ea06db7db7d3 = isstring(name);
  var_c59b3d0a5b387b2d = isarray(elements) && elements.size > 0 && isarray(elements[0]);
  var_f468c22613f33b97 = isarray(elements) && elements.size >= 3 && isstring(elements[0]);
  var_ce692c7a46788fa6 = isstring(elements);
  var_3561ce9cbee3e19f = var_28b2ea06db7db7d3 && (var_c59b3d0a5b387b2d || var_f468c22613f33b97 || var_ce692c7a46788fa6);

  if(function_110d3ab280057f5b(!var_3561ce9cbee3e19f, "snd: element_init invalid")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }
  }

  if(var_ce692c7a46788fa6 && !isDefined(level.snd.elements[elements])) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }
  }

  if(var_f468c22613f33b97) {
    elements = [elements];
  }

  level.snd.elements[name] = elements;
}

function private function_a694f301951b340(element) {
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(isarray(level.snd.elements) && isstring(element)) {
    levelelements = level.snd.elements[element];
    var_563f0fdd4afa1de5 = isarray(levelelements);
    var_85434fa931ce44d1 = isstring(levelelements);

    if(var_563f0fdd4afa1de5) {
      return element;
    } else if(var_85434fa931ce44d1 && isarray(level.snd.elements[levelelements])) {
      return levelelements;
    }
  }

  return undefined;
}

function private function_1038bc878bfe6a5a(element) {
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(isarray(element)) {
    return element;
  } else if(isarray(level.snd.elements) && isstring(element)) {
    element = function_a694f301951b340(element);
    levelelements = level.snd.elements[element];
    var_a9cc843c3422bd78 = isarray(levelelements);

    if(var_a9cc843c3422bd78) {
      return levelelements;
    }
  }

  return undefined;
}

function function_54b7b0779da7f0c0(player, element) {
  isplayervalid = isplayersafe(player);

  if(function_110d3ab280057f5b(!isplayervalid, "snd: set_element invalid player")) {
    return;
  }

  function_b3e5599c9f6a8895(player);
  var_a9cc843c3422bd78 = isarray(element);
  var_ce692c7a46788fa6 = isstring(element);
  var_2a5c31386af49af6 = !isDefined(element);
  var_3561ce9cbee3e19f = var_a9cc843c3422bd78 || var_ce692c7a46788fa6 || var_2a5c31386af49af6;

  if(function_110d3ab280057f5b(!var_3561ce9cbee3e19f, "snd: set_element invalid element")) {
    return;
  }

  if(var_a9cc843c3422bd78) {
    player.snd.element = "**** custom****";
  } else if(var_ce692c7a46788fa6) {
    current = function_a694f301951b340(player.snd.element);
    remapped = function_a694f301951b340(element);
    isequal = isstring(current) && isstring(remapped) && current == remapped;
    player.snd.element = element;

    if(isequal) {
      return;
    }
  }

  if(isplayervalid && isarray(player.snd.emitters)) {
    snd_stop(player.snd.emitters);
    player.snd.emitters = undefined;
  }

  if(var_2a5c31386af49af6) {
    player.snd.element = undefined;
    return;
  }

  elements = function_1038bc878bfe6a5a(element);
  var_c59b3d0a5b387b2d = isarray(elements);

  if(function_110d3ab280057f5b(!var_c59b3d0a5b387b2d, "snd: set_element '" + player.snd.element + "' undefined")) {
    if(function_6fa24a43c981460a()) {
      DevOp(0x94);
    }

    return;
  }

  assert(isplayervalid);
  assert(var_c59b3d0a5b387b2d);
  player.snd.emitters = [];

  foreach(e in elements) {
    alias = e[0];
    target = default_to(e[1], player);
    spawntime = e[2];
    distancerange = e[3];
    rotation = e[4];
    elevation = e[5];
    emt = snd_emitter(alias, target, spawntime, distancerange, rotation, elevation);

    if(isDefined(emt)) {
      player.snd.emitters[player.snd.emitters.size] = emt;
    }
  }
}

function private function_b73221aba7ab22bc(soundobject, player, org_start, org_end) {
  assert(function_f0a31c88dbf01c1(soundobject));
  assert(isplayersafe(player));
  assert(isvector(org_start));
  assert(isvector(org_end));
  soundobject endon("death");
  soundobject notify("snd_line_detach");
  soundobject endon("snd_line_detach");

  while(isplayersafe(player) && function_f0a31c88dbf01c1(soundobject)) {
    org_player = player getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);
    soundobject.origin = org;

    if(function_ec24f13736bfc421() > 1) {
      line_size = 24;
      depth_test = 0;
      color_line = (0.97254, 0.72974, 0.72974);
      color_rt = (0.72974, 0.97254, 0.72974);
      color_up = (0.72974, 0.72974, 0.97254);
      line(org_start, org_end, color_line, 1, depth_test, 1);
      line_angles = vectortoangles(org_end - org_start);
      line_rt = anglestoright(line_angles);
      line_up = anglestoup(line_angles);
      line(org_start - line_rt * line_size, org_start + line_rt * line_size, color_rt, 1, depth_test, 1);
      line(org_start - line_up * line_size, org_start + line_up * line_size, color_up, 1, depth_test, 1);
      line(org_end - line_rt * line_size, org_end + line_rt * line_size, color_rt, 1, depth_test, 1);
      line(org_end - line_up * line_size, org_end + line_up * line_size, color_up, 1, depth_test, 1);
    }

    waitframe();
  }
}

function function_f4103b35bbe765f1(soundobject, player, org_start, org_end) {
  if(function_110d3ab280057f5b(!function_f0a31c88dbf01c1(soundobject), "snd_line_attach with invalid soundObject")) {
    return;
  }

  if(function_110d3ab280057f5b(!isplayersafe(player), "snd_line_attach with invalid player")) {
    return;
  }

  if(function_110d3ab280057f5b(!isvector(org_start), "snd_line_attach with invalid start position")) {
    return;
  }

  if(function_110d3ab280057f5b(!isvector(org_end), "snd_line_attach with invalid end position")) {
    return;
  }

  soundobject thread function_b73221aba7ab22bc(soundobject, player, org_start, org_end);
}

function snd_line_detach(soundobject) {
  if(function_110d3ab280057f5b(!isDefined(soundobject), "snd_line_detach with undefined soundObject")) {
    return;
  }

  soundobject notify("snd_line_detach");
}

function private function_5b159f140bd186df() {
  function_40a17693396019a7();

  if(!isarray(level.snd.var_828ab610e771905)) {
    level.snd.var_828ab610e771905 = [];
  }

  if(!isent(level.snd.var_4388174fd6467686)) {
    level.snd.var_4388174fd6467686 = spawn("sound_transient_soundbanks", (0, 0, 0));
  }
}

function function_1186ca4e2e51afea(name) {
  if(isstruct(level.snd) && isDefined(level.snd.var_828ab610e771905) && isDefined(level.snd.var_828ab610e771905[name])) {
    return true;
  }

  return false;
}

function function_f1aed36ab4598ea(name) {
  function_5b159f140bd186df();
  assert(function_f0b5522ee5ce0cb1());
  assert(isent(level.snd.var_4388174fd6467686));
  assert(isarray(level.snd.var_828ab610e771905));
  assertex(isstring(name), "snd_transient_load requires a name argument");
  isloaded = function_1186ca4e2e51afea(name);

  if(function_110d3ab280057f5b(isloaded, "snd_transient_load loaded '" + name + "'")) {
    return;
  }

  level.snd.var_4388174fd6467686 settransientsoundbank(name + ".all", 1);
  level.snd.var_828ab610e771905[name] = level.snd.var_828ab610e771905.size;
}

function function_f4e0ff5cb899686d(name) {
  function_5b159f140bd186df();
  assert(function_f0b5522ee5ce0cb1());
  assert(isent(level.snd.var_4388174fd6467686));
  assert(isarray(level.snd.var_828ab610e771905));
  assertex(isstring(name), "snd_transient_unload requires a name argument");
  isloaded = function_1186ca4e2e51afea(name);

  if(function_110d3ab280057f5b(!isloaded, "snd_transient_unload '" + name + "' not loaded")) {
    return;
  }

  level.snd.var_4388174fd6467686 settransientsoundbank(name + ".all", 0);
  level.snd.var_828ab610e771905[name] = undefined;
}