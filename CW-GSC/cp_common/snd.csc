/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_debug;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function private autoexec function_4047919b() {
  if(!isDefined(level._snd)) {
    level._snd = spawnStruct();
    level._snd.var_8c37ff34 = 1;
    level._snd._callbacks = [];
    level._snd.var_3cc765a3 = [];
    level._snd.var_92f63ad0 = [];
    level._snd.var_d37e94ca = # "centity";
    level._snd.var_90903fc0 = 0;
    level._snd._callbacks[#"pitch_get"] = &function_6f94855d;
    level._snd._callbacks[#"pitch_set"] = &function_679011ab;
    level._snd._callbacks[#"volume_get"] = &function_7308d4d0;
    level._snd._callbacks[#"volume_set"] = &function_a43df3ac;
    level._snd._callbacks[#"player_view"] = &function_959bbfdb;
    level._snd._callbacks[#"player_angles"] = &function_2c0c5fbc;
    level._snd._callbacks[#"player_fov"] = &function_bf76eea3;
    level._snd.var_cd3159ba = [];
  }

  util::register_system("clientSoundCommand", &function_b0baf0b5);
  clientfield::register("actor", "clientFieldSndTargetActor", 1, 11, "int", &function_201a102c, 0, 0);
  clientfield::register("allplayers", "clientFieldSndTargetPlayer", 1, 11, "int", &function_201a102c, 0, 0);
  clientfield::register("vehicle", "clientFieldSndTargetVehicle", 1, 11, "int", &function_201a102c, 0, 0);
  clientfield::register("scriptmover", "clientFieldSndTargetScriptMover", 1, 11, "int", &function_201a102c, 0, 0);
  function_3ffa0089();

  level thread function_ce893a25();
  dvar("<dev string:x38>", "<dev string:x58>", &function_360bb421);
  dvar("<dev string:x5c>", "<dev string:x58>", &function_360bb421);
  dvar("<dev string:x7c>", "<dev string:x58>", &function_360bb421);

  waittillframeend();
  level._snd.isinitialized = 1;
}

function private function_b0baf0b5(localclientnum, _cmd) {
  level thread function_8610d024(localclientnum, _cmd);
}

function private function_8610d024(localclientnum, _cmd) {
  waitforplayers();
  player = function_a8210e43(localclientnum);
  args = strtok(_cmd, " ");
  waittillframeend();

  if(!isDefined(player)) {
    return;
  }

  if(isarray(args) && args.size >= 2) {
    cmd = args[0];

    switch (cmd) {
      case # "#":
      case # "m":
        level thread function_21d71e38(player, cmd, args);
        break;
      case # "t":
        level thread function_6d366059(player, cmd, args);
        break;
      case # "v":
        level thread function_cc4bf5ee(player, cmd, args);
        break;
      default:

        function_81fac19d(function_d78e3644(), "<dev string:x9c>" + cmd + "<dev string:xbb>");

        break;
    }
  }

  if(isscriptfunctionptr(level._snd._callbacks[#"clientsoundcommand"])) {
    level thread[[level._snd._callbacks[#"clientsoundcommand"]]](localclientnum, _cmd);
  }
}

function private function_21d71e38(player, cmd, args) {
  assert(isPlayer(player));
  assert(isDefined(player.localclientnum));
  assert(isstring(cmd) && (cmd == "<dev string:xc0>" || cmd == "<dev string:xc5>"));
  assert(isarray(args) && args.size >= 2);

  if(function_81fac19d(!isscriptfunctionptr(level._snd._callbacks[#"client_msg"]), "snd: client msg without initialization")) {
    return;
  }

  msg = undefined;

  if(cmd == "#") {
    msg = function_35dccf3f(args[1]);
  } else if(cmd == "M") {
    msg = args[1];
  }

  var_65cde9d7 = isstring(msg) || ishash(msg);

  if(function_81fac19d(!var_65cde9d7, "snd: invalid client msg")) {
    return;
  }

  level thread[[level._snd._callbacks[#"client_msg"]]](player, msg);
}

function private function_6d366059(player, cmd, args) {
  assert(isPlayer(player));
  assert(isDefined(player.localclientnum));
  assert(isstring(cmd) && cmd == "<dev string:xca>");
  assert(isarray(args));
  entitynumber = int(args[1]);
  targetname = string(args[2]);

  if(args.size > 3) {
    for(i = 3; i < args.size; i++) {
      targetname += " " + string(args[i]);
    }
  }

  level._snd.var_cd3159ba["" + entitynumber] = targetname;
}

function private function_cc4bf5ee(player, cmd, args) {
  assert(isPlayer(player));
  assert(isDefined(player.localclientnum));
  assert(isstring(cmd) && cmd == "<dev string:xcf>");
  assert(isarray(args));
  var_e1fb96c7 = isDefined(level._snd._callbacks[#"client_voice"]) && isscriptfunctionptr(level._snd._callbacks[#"client_voice"]);
  entitynumber = int(args[1]);
  soundalias = undefined;

  if(args.size >= 3 && isDefined(args[2])) {
    soundalias = string(args[2]);
  }

  if(args.size > 3) {
    assert(isstring(soundalias));

    for(i = 3; i < args.size; i++) {
      soundalias += " " + string(args[i]);
    }
  }

  ent = undefined;
  framecount = 0;

  while(true) {
    ent = getentbynum(player.localclientnum, entitynumber);

    if(isentity(ent)) {
      if(var_e1fb96c7) {
        ent thread[[level._snd._callbacks[#"client_voice"]]](ent, soundalias);
      } else {
        var_90709302 = isDefined(soundalias);
        var_2115c64c = function_a6779cbd(ent.var_6d22c36f);

        if(var_90709302) {
          if(!isarray(ent.var_bfe14559)) {
            ent.var_bfe14559 = [soundalias];
          } else {
            ent.var_bfe14559[ent.var_bfe14559.size] = soundalias;
          }
        }

        if(var_2115c64c && !var_90709302) {
          stop(ent.var_6d22c36f);
          ent.var_bfe14559 = undefined;
          ent.var_6d22c36f = undefined;
        }

        if(!isDefined(ent.var_6d22c36f)) {
          while(isarray(ent.var_bfe14559)) {
            alias = ent.var_bfe14559[0];
            arrayremoveindex(ent.var_bfe14559, 0, 0);
            ent.var_6d22c36f = play(alias, [ent, "j_head"]);
            function_2fdc4fb(ent.var_6d22c36f);
            wait 0.666;

            if(isarray(ent.var_bfe14559) && ent.var_bfe14559.size == 0) {
              ent.var_bfe14559 = undefined;
            }

            if(isDefined(ent)) {
              ent.var_6d22c36f = undefined;
            }
          }
        }
      }

      break;
    }

    framecount++;

    if(function_81fac19d(framecount % 60 == 0, "snd: client voice entity not found '" + soundalias + "' (" + entitynumber + ")")) {
      if(function_81fac19d(framecount % 1800 == 0, "snd: client soundalias ABORTED '" + soundalias + "' (" + entitynumber + ")")) {
        return;
      }
    }

    waitframe(1);
  }
}

function function_201a102c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self thread function_c5463db2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

function function_c5463db2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(function_81fac19d(!isscriptfunctionptr(level._snd._callbacks[#"client_targetname"]), "snd: client targetname without initialization")) {
    return;
  }

  if(function_81fac19d(!isentity(self), "snd: client targetname called with non-entity")) {
    return;
  }

  ent = self;
  entitynumber = ent getentitynumber();

  if(isDefined(ent) && bwasdemojump == 0) {
    return;
  }

  framecount = 0;

  while(isDefined(ent)) {
    targetname = level._snd.var_cd3159ba["" + entitynumber];

    if(isentity(ent) && isstring(targetname)) {
      ent.targetname = targetname;
      ent thread[[level._snd._callbacks[#"client_targetname"]]](ent, targetname);
      level thread function_3c94cf0c(ent);
      return;
    }

    framecount++;

    if(function_81fac19d(framecount % 60 == 0, "snd: client targetname not found for $e" + entitynumber)) {
      if(function_81fac19d(framecount % 1800 == 0, "snd: client targetname ABORTED for $e" + entitynumber)) {
        return;
      }
    }

    waitframe(1);
  }
}

function function_3c94cf0c(ent) {
  entitynumber = ent getentitynumber();
  ent waittill(#"death");
  level._snd.var_cd3159ba["" + entitynumber] = undefined;
}

function function_d4ec748e(callback) {
  if(function_81fac19d(!isscriptfunctionptr(callback), "snd_client_msg_init: invalid function")) {
    if(function_f984063f()) {
      debugbreak();
    }

    return;
  }

  level._snd._callbacks[#"client_msg"] = callback;
}

function function_ce78b33b(callback) {
  if(function_81fac19d(!isscriptfunctionptr(callback), "snd_client_targetname_init: invalid function")) {
    if(function_f984063f()) {
      debugbreak();
    }

    return;
  }

  level._snd._callbacks[#"client_targetname"] = callback;
}

#namespace namespace_afa8e18b;

function function_2761fc04(ent, var_1d25915, linkedentity, var_e330010e) {
  assert(isDefined(ent), "<dev string:xd4>");
  assert(isDefined(ent.soundkey), "<dev string:xee>");

  if(isDefined(linkedentity)) {
    var_e330010e = linkedentity snd::function_bf7c949(var_e330010e);
    linkedoffset = (0, 0, 0);
    linkedangles = (0, 0, 0);

    if(isDefined(var_1d25915)) {
      linkedoffset = var_1d25915;
    }

    assert(isDefined(var_e330010e), "<dev string:x109>");

    if(isstring(var_e330010e) && var_e330010e != "" && var_e330010e != "tag_origin") {
      ent linkto(linkedentity, var_e330010e);
    } else {
      ent linkto(linkedentity);
    }

    if(!isarray(linkedentity.var_a415b6d6)) {
      linkedentity.var_a415b6d6 = [];
    }

    linkedentity.var_a415b6d6[ent.soundkey] = ent;
    return;
  }

  level._snd.var_92f63ad0[ent.soundkey] = ent;
}

function function_5275752c(soundalias, var_1d25915, linkedentity, var_e330010e) {
  ent = undefined;
  spawnorigin = undefined;

  if(isDefined(linkedentity) && isDefined(var_e330010e) && isDefined(var_1d25915)) {
    spawnorigin = linkedentity gettagorigin(var_e330010e);
    spawnorigin += var_1d25915;
  } else if(isDefined(linkedentity) && isDefined(var_e330010e)) {
    spawnorigin = linkedentity gettagorigin(var_e330010e);
  } else if(isDefined(linkedentity) && isDefined(var_1d25915)) {
    spawnorigin = linkedentity.origin;
    spawnorigin += var_1d25915;
  } else if(isDefined(linkedentity)) {
    spawnorigin = linkedentity.origin;
  } else if(!isDefined(linkedentity) && !isDefined(var_1d25915)) {
    var_3692a397 = (0, 0, -32768);
    spawnorigin = var_3692a397;
  } else {
    spawnorigin = var_1d25915;
  }

  assert(isDefined(spawnorigin));
  ent = undefined;

  if(isDefined(linkedentity)) {
    ent = spawn(0, spawnorigin, "script_model");
    ent setModel("tag_origin");
  } else {
    ent = spawn(0, spawnorigin, "script_origin");
  }

  assert(isDefined(ent), "<dev string:x129>");
  ent.var_90c86b97 = linkedentity;
  ent.soundtype = # "centity";
  ent.soundkey = ent getentitynumber();
  ent.targetname = "snd " + soundalias;
  return ent;
}

function function_bdc44456(ent) {
  if(snd::function_81fac19d(!isDefined(ent) || function_3132f113(ent), "snd: free on deleted entity!")) {
    if(snd::function_f984063f()) {
      debugbreak();
    }

    return;
  }

  if(isDefined(ent.var_90c86b97) && isarray(ent.var_90c86b97.var_a415b6d6)) {
    linkedentity = ent.var_90c86b97;
    var_5244aa9 = isDefined(linkedentity.var_a415b6d6[ent.soundkey]);

    if(var_5244aa9 == 1) {
      linkedentity.var_a415b6d6[ent.soundkey] = undefined;
    } else {
      if(snd::function_f984063f()) {
        debugbreak();
      }
    }
  } else {
    level._snd.var_92f63ad0[ent.soundkey] = undefined;
  }

  waittillframeend();
  ent delete();
}

function function_bb749fc3(soundobject, soundalias, initialvolume, delaytime) {
  ent = soundobject;
  currentvolume = undefined;
  ent endon(#"death");
  assert(isDefined(ent));
  assert(isstring(soundalias) || ishash(soundalias));
  currentvolume = 1;

  if(!isDefined(initialvolume) && isDefined(currentvolume)) {
    initialvolume = currentvolume;
  }

  if(snd::did_init() == 0) {
    var_cd7344db = !isDefined(delaytime) || snd::isnumber(delaytime) && delaytime == 0;

    if(snd::function_81fac19d(var_cd7344db, "snd: delayed due to first frame!")) {
      delaytime = 0.05;
    }
  }

  if(snd::isnumber(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  soundhandle = -1;
  assert(soundexists(soundalias), "<dev string:x151>" + soundalias);

  if(soundislooping(soundalias) == 1) {
    soundhandle = ent playLoopSound(soundalias);
  } else {
    donenotifystr = "sounddone";
    soundhandle = ent playSound(0, soundalias);
    ent.soundhandle = soundhandle;
    ent thread function_297cdf07(donenotifystr, soundhandle);
  }

  ent.soundalias = soundalias;
  ent.soundhandle = soundhandle;
}

function function_273d939b(soundobject, fadeoutseconds) {
  soundobject endon(#"death");
  ent = soundobject;

  if(snd::function_81fac19d(!isDefined(ent) || function_3132f113(ent), "snd: stop on deleted entity!")) {
    if(snd::function_f984063f()) {
      debugbreak();
    }

    return;
  }

  soundalias = ent.soundalias;

  if(isstring(soundalias)) {
    if(is_true(soundislooping(soundalias))) {
      ent stoploopsound(ent.soundhandle, fadeoutseconds);
    } else {
      ent stopsounds();
      stopsound(ent.soundhandle);
    }

    waitframe(1);
    ent.soundalias = undefined;
    ent.soundhandle = undefined;
  }

  ent.soundtype = undefined;
  function_bdc44456(ent);
}

function private function_5834ae26(soundalias, done) {
  ent = self;
  ent endon(#"death");
  waittime = soundgetplaybacktime(soundalias);
  waittime *= 1.25;
  waittime /= 1000;
  wait waittime;
  ent notify(done, ent.soundalias);
  function_bdc44456(ent);
}

function private function_7b0e43ab(done) {
  ent = self;
  ent endon(#"death");
  ent waittill(done);
  ent notify(done, ent.soundalias);
  function_bdc44456(ent);
}

function private function_297cdf07(done, soundhandle) {
  ent = self;
  ent endon(#"death");

  while(soundplaying(soundhandle)) {
    waitframe(1);
  }

  ent notify(done, ent.soundalias);
  function_bdc44456(ent);
}

function function_b5959278(ent, var_1d25915, linkedentity, var_e330010e) {
  assert(0, "<dev string:x16f>");
}

function function_85daf9f0(soundalias, var_1d25915, linkedentity, var_e330010e) {
  assert(0, "<dev string:x16f>");
  return undefined;
}

function function_6ac5b570(ent) {
  assert(0, "<dev string:x16f>");
}

function function_2dde45d9(soundobject, soundalias, initialvolume, delaytime) {
  assert(0, "<dev string:x16f>");
}

function function_9f156b27(soundobject, fadeoutseconds) {
  assert(0, "<dev string:x16f>");
}

#namespace snd;

function private function_3323ac64(soundobject) {
  if(isDefined(soundobject) == 1 && function_3132f113(soundobject) == 0 && isDefined(soundobject.var_aceb47b0) == 0) {
    soundobject.var_aceb47b0 = spawnStruct();
    soundobject.var_aceb47b0.volume = 1;
    soundobject.var_aceb47b0.pitch = 1;
    soundobject.var_aceb47b0.threads = [];
    function_f2a84378(soundobject, function_6cfa7975());
  }
}

function private function_5803da43(sound, volume, time) {
  if(isDefined(sound) && isDefined(sound.soundhandle)) {
    if(time > 0) {
      time = 1 / time;
    }

    setsoundvolumerate(sound.soundhandle, time);
    setsoundvolume(sound.soundhandle, volume);
  }
}

function private function_d7b79aea(sound, pitch, time) {
  if(isDefined(sound) && isDefined(sound.soundhandle)) {
    if(time > 0) {
      time = 1 / time;
    }

    setsoundpitchrate(sound.soundhandle, time);
    setsoundpitch(sound.soundhandle, pitch);
  }
}

function private function_d72fc2b9(soundobject, value, scalefunc) {
  if(function_3132f113(soundobject) == 1 || isDefined(soundobject) == 0) {
    return;
  }

  function_3323ac64(soundobject);
  assert(isDefined(soundobject.var_aceb47b0) == 1);

  if(isDefined(scalefunc) == 1) {
    if(scalefunc == &function_5803da43) {
      soundobject.var_aceb47b0.volume = value;
      return;
    }

    if(scalefunc == &function_d7b79aea) {
      soundobject.var_aceb47b0.pitch = value;
    }
  }
}

function private function_2530f85d(soundobject, scalefunc) {
  assert(isDefined(soundobject));

  if(isDefined(soundobject.var_aceb47b0) == 1) {
    if(scalefunc == &function_5803da43) {
      return soundobject.var_aceb47b0.volume;
    } else if(scalefunc == &function_d7b79aea) {
      return soundobject.var_aceb47b0.pitch;
    }
  }

  return undefined;
}

function private function_6c660df4(scalefunc) {
  var_5a2568f4 = 0;
  scalestring = undefined;
  self endon(#"death");
  self waittill(#"hash_2178ab9046055607");
  assert(isDefined(scalefunc) == 1, "<dev string:x192>");

  if(scalefunc == &function_5803da43) {
    self.var_aceb47b0.var_6d865326 = undefined;
    scalestring = "volume";
  }

  if(scalefunc == &function_d7b79aea) {
    self.var_aceb47b0.var_a1666553 = undefined;
    scalestring = "pitch";
  }

  assert(isDefined(scalestring) == 1);
  self.var_aceb47b0.threads[scalestring] = undefined;

  if(isDefined(self.var_aceb47b0.var_6d865326) == 0 && isDefined(self.var_aceb47b0.var_a1666553) == 0) {
    self.var_aceb47b0.isscaling = undefined;
  }

  self notify("snd_stop_scale_" + scalestring);
  waittillframeend();
}

function private function_48e190dd(curve, scale, time, scalefunc, callbackfunc) {
  self endon(#"death", #"disconnect");
  assert(isDefined(self.var_aceb47b0) == 1);
  assert(isDefined(self.var_aceb47b0.threads) == 1);
  assert(isDefined(scalefunc) == 1);
  assert(time > 0);
  curvepts = function_fc955f31(curve);
  assert(curvepts > 0, "<dev string:x58>");
  frametime = float(function_6cfa7975());
  timeremainder = function_a18ae88f(float(time), frametime);
  time = float(time) + frametime - timeremainder;
  timeinterval = float(time) / float(curvepts);
  var_aeb0a629 = function_a18ae88f(timeinterval, frametime);
  timeinterval = timeinterval + frametime - var_aeb0a629;
  timeinterval = max(timeinterval, frametime);
  var_a7ce73cd = int(timeinterval * 1000 + 0.5);
  timems = int(time * 1000 + 0.5);
  var_5bd40646 = int(0);

  if(isDefined(self.var_aceb47b0.isscaling) == 1) {
    var_e971cedf = 0;

    if(isDefined(self.var_aceb47b0.var_6d865326) == 1 && scalefunc == &function_5803da43 || isDefined(self.var_aceb47b0.var_a1666553) == 1 && scalefunc == &function_d7b79aea) {
      var_e971cedf = 1;
    }

    if(var_e971cedf == 1) {
      self notify(#"hash_2178ab9046055607");
      waittillframeend();
      self notify(#"hash_6e1c0f8335cc603c");
    }
  }

  scalestart = function_2530f85d(self, scalefunc);
  inversecurve = 0;

  if(scalestart > scale) {
    inversecurve = 1;
  }

  while(isDefined(self.soundalias) == 0) {
    waitframe(1);
  }

  waittillframeend();
  self thread function_6c660df4(scalefunc);
  self.var_aceb47b0.isscaling = 1;
  scalestring = undefined;

  if(scalefunc == &function_5803da43) {
    self.var_aceb47b0.var_6d865326 = 1;
    scalestring = "volume";
  }

  if(scalefunc == &function_d7b79aea) {
    self.var_aceb47b0.var_a1666553 = 1;
    scalestring = "pitch";
  }

  assert(isDefined(scalestring) == 1);
  self.var_aceb47b0.threads[scalestring] = 1;
  self endon("snd_stop_scale_" + scalestring);

  while(var_5bd40646 < timems && isDefined(self) == 1 && isDefined(self.var_aceb47b0.threads[scalestring]) == 1) {
    remainingtime = (timems - var_5bd40646) * 0.001;

    if(isDefined(self.var_aceb47b0.waitinterval) == 1) {
      timeinterval = max(self.var_aceb47b0.waitinterval, frametime);
    }

    waittime = min(timeinterval, remainingtime);
    var_5bd40646 += int(waittime * 1000 + 0.5);
    timefrac = float(var_5bd40646) / float(timems);
    scalevalue = 1;

    if(inversecurve > 0) {
      timefrac = math::clamp(1 - timefrac, 0, 1);
      curvevalue = function_b918d683(timefrac, curve);
      scalevalue = lerpfloat(scale, scalestart, curvevalue);
    } else {
      curvevalue = function_b918d683(timefrac, curve);
      scalevalue = lerpfloat(scalestart, scale, curvevalue);
    }

    [[scalefunc]](self, scalevalue, waittime);
    wait waittime;

    if(isDefined(self) == 1 && function_3132f113(self) == 0) {
      function_d72fc2b9(self, scalevalue, scalefunc);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self) == 1) {
    self notify(#"hash_2178ab9046055607", scalefunc);
  }

  if(isDefined(callbackfunc) == 1) {
    self[[callbackfunc]]();
  }
}

function function_f2a84378(soundobject, waitinterval) {
  assert(isDefined(soundobject) == 1);
  function_3323ac64(soundobject);
  assert(isDefined(soundobject.var_aceb47b0) == 1);
  soundobject.var_aceb47b0.waitinterval = max(waitinterval, function_6cfa7975());
}

function snd_scale(soundobject, scalewhat, value, time, curve, callbackfunc) {
  var_43b6ef7d = 0.00390625;
  var_16f452ed = 2;
  var_7a9a68cb = 0;
  var_69111be2 = 4;

  if(function_81fac19d(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return;
  }

  if(function_81fac19d(function_3132f113(soundobject) == 1, "snd_scale: called on removed entity")) {
    return;
  }

  assert(isDefined(soundobject) == 1, "<dev string:x1bc>");
  assert(function_3132f113(soundobject) == 0, "<dev string:x1e5>");
  assert(isDefined(value) == 1);
  function_3323ac64(soundobject);
  var_e127d44f = value;
  scalefunc = undefined;
  scalestring = undefined;

  switch (scalewhat) {
    case # "volume":
    case # "volume":
    case # "v":
    case # "v":
    case # "vol":
    case # "vol":
      curve = function_ea2f17d1(curve, "easeout");
      scalefunc = &function_5803da43;
      scalestring = "volume";
      var_e127d44f = math::clamp(value, var_7a9a68cb, var_69111be2);
      function_81fac19d(value != var_e127d44f, "snd_scale: clamped volume " + value + " -> " + var_e127d44f);
      break;
    case # "p":
    case # "p":
    case # "pitch":
    case # "pitch":
      curve = function_ea2f17d1(curve, "linear");
      scalefunc = &function_d7b79aea;
      scalestring = "pitch";
      var_e127d44f = math::clamp(value, var_43b6ef7d, var_16f452ed);
      function_81fac19d(value != var_e127d44f, "snd_scale: clamped pitch " + value + " -> " + var_e127d44f);
      break;
  }

  assert(isDefined(soundobject) == 1);

  if(isDefined(time) == 0 || time == 0) {
    [[scalefunc]](soundobject, var_e127d44f, 0);
    function_d72fc2b9(soundobject, var_e127d44f, scalefunc);
    soundobject notify(#"hash_2178ab9046055607", scalefunc);
    soundobject notify(#"hash_6e1c0f8335cc603c");
    soundobject notify("snd_stop_scale_" + scalestring);
    return;
  }

  soundobject thread function_48e190dd(curve, var_e127d44f, time, scalefunc, callbackfunc);

  if(scalefunc == &function_5803da43) {
    soundobject notify(#"hash_501fa67f084af993");
  }
}

function function_a43df3ac(soundobject, volume, time, curve, callbackfunc) {
  snd_scale(soundobject, "volume", volume, time, curve, callbackfunc);
}

function function_679011ab(soundobject, pitch, time, curve, callbackfunc) {
  snd_scale(soundobject, "pitch", pitch, time, curve, callbackfunc);
}

function function_7308d4d0(soundobject) {
  if(function_81fac19d(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return 0;
  }

  if(function_81fac19d(function_3132f113(soundobject) == 1, "snd_scale: called on removed entity")) {
    return 0;
  }

  assert(isDefined(soundobject) == 1);
  return function_2530f85d(soundobject, &function_5803da43);
}

function function_6f94855d(soundobject) {
  if(function_81fac19d(isDefined(soundobject) == 0, "snd_scale: called on undefined entity")) {
    return 0;
  }

  if(function_81fac19d(function_3132f113(soundobject) == 1, "snd_scale: called on removed entity")) {
    return 0;
  }

  assert(isDefined(soundobject) == 1);
  return function_2530f85d(soundobject, &function_d7b79aea);
}

function private function_959bbfdb() {
  player = self;
  vieworigin = player getcampos();
  return vieworigin;
}

function private function_2c0c5fbc() {
  player = self;
  viewangles = player getcamangles();
  return viewangles;
}

function private function_bf76eea3() {
  player = self;
  fov = player function_9169401e();
  return fov;
}

function private function_360bb421(key, value) {
  values = strtok(value, "<dev string:x20c>");

  if(isarray(values) && values.size > 0) {
    contextkey = values[0];
    contextvalue = function_ea2f17d1(values[1], "<dev string:x58>");
    var_23614cc2 = function_ea2f17d1(values[2], 0);

    if(key == "<dev string:x38>") {
      iprintlnbold("<dev string:x213>" + "<dev string:x21e>" + contextkey + "<dev string:x224>" + contextvalue + "<dev string:xbb>");
      setsoundcontext(contextkey, contextvalue);
    } else if(key == "<dev string:x5c>") {
      iprintlnbold("<dev string:x22d>" + "<dev string:x21e>" + contextkey + "<dev string:x224>" + contextvalue + "<dev string:xbb>");

      foreach(player in getplayerssafe()) {
        player setsoundentcontext(contextkey, contextvalue);
      }
    } else if(key == "<dev string:x7c>") {
      iprintlnbold("<dev string:x238>" + "<dev string:x21e>" + contextkey + "<dev string:x224>" + contextvalue + "<dev string:xbb>");

      foreach(ent in getEntArray(0)) {
        ent setsoundentcontext(contextkey, contextvalue);
      }
    }
  }

  return value;
}