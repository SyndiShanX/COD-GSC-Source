/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd.gsc
***********************************************/

#using script_198f1b397865a5ad;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_debug;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function private autoexec function_4047919b() {
  if(!isDefined(level._snd)) {
    level._snd = spawnStruct();
    level._snd.var_2dd09170 = 1;
    level._snd._callbacks = [];
    level._snd.var_3cc765a3 = [];
    level._snd.var_92f63ad0 = [];
    level._snd.var_d37e94ca = # "gentity";
    level._snd.var_90903fc0 = 0;
    level._snd._callbacks[# "player_view"] = &function_9d361345;
    level._snd._callbacks[# "player_angles"] = &function_d33afb70;
    level._snd._callbacks[# "player_fov"] = &function_51436f04;
  }

  util::registerclientsys("clientSoundCommand");
  clientfield::register("actor", "clientFieldSndTargetActor", 1, 11, "int");
  clientfield::register("allplayers", "clientFieldSndTargetPlayer", 1, 11, "int");
  clientfield::register("vehicle", "clientFieldSndTargetVehicle", 1, 11, "int");
  clientfield::register("scriptmover", "clientFieldSndTargetScriptMover", 1, 11, "int");
  function_3ffa0089();

  level thread function_ce893a25();

  waittillframeend();
  level._snd.isinitialized = 1;
}

function client_msg(msg, players) {
  level thread function_a74b8be1(msg, players);
}

function function_a74b8be1(msg, players) {
  waitforplayers();
  var_9077d19c = isstring(players) && players.size > 0 || ishash(players);

  if(function_81fac19d(!var_9077d19c, "snd_client_msg must be a string or hash")) {
    return;
  }

  assert(var_9077d19c);
  state = "";

  if(ishash(players)) {
    state = "# " + players;
  } else if(isstring(players)) {
    if(function_81fac19d(players.size > 16, "snd: client_msg > 16 chars " + function_783b69(players, "'"))) {
      if(function_f984063f()) {
        debugbreak();
      }
    }

    state = "M " + players;
  }

  util::setclientsysstate("clientSoundCommand", state);
}

function client_targetname(ent, targetname) {
  level thread function_5018393e(ent, targetname);
}

function private function_5018393e(ent, targetname) {
  waitforplayers();
  isvalidtarget = isentity(ent);

  if(function_81fac19d(!isvalidtarget, "snd_client_targetname is not an entity")) {
    return;
  }

  assert(isvalidtarget);
  targetname = function_ea2f17d1(targetname, ent.targetname);

  if(function_81fac19d(!isDefined(targetname), "snd_client_targetname targetname is undefined")) {
    return;
  }

  assert(isDefined(targetname));
  entitynumber = ent getentitynumber();
  state = "T " + entitynumber + " " + targetname;
  fieldname = function_9d83cae7(ent);
  util::setclientsysstate("clientSoundCommand", state);
  ent clientfield::set(fieldname, entitynumber);
  level thread function_b2f22cd6(ent, state, fieldname);
}

function private function_9d83cae7(ent) {
  fieldname = "clientFieldSndTargetScriptMover";

  if(isactor(ent)) {
    fieldname = "clientFieldSndTargetActor";
  } else if(isPlayer(ent)) {
    fieldname = "clientFieldSndTargetPlayer";
  } else if(isvehicle(ent)) {
    fieldname = "clientFieldSndTargetVehicle";
  } else {
    fieldname = "clientFieldSndTargetScriptMover";
  }

  return fieldname;
}

function private function_b2f22cd6(ent, state, fieldname, var_792fc52c) {
  assert(isstring(state));
  assert(isstring(fieldname));
  var_792fc52c = function_ea2f17d1(var_792fc52c, 3);
  wait var_792fc52c;

  if(isDefined(ent)) {
    util::setclientsysstate("clientSoundCommand", state);
    ent clientfield::set(fieldname, 0);
  }
}

function client_voice(ent, soundalias) {
  isvalidtarget = isentity(ent);

  if(function_81fac19d(!isvalidtarget, "snd client_vo was not given an entity")) {
    return 0;
  }

  assert(isvalidtarget);
  var_3dd9dcff = soundexists(soundalias);

  if(function_81fac19d(isDefined(soundalias) && !var_3dd9dcff, "snd client_vo alias does not exist: " + soundalias)) {
    return 0;
  }

  entitynumber = ent getentitynumber();
  state = "V " + entitynumber;

  if(var_3dd9dcff) {
    state += " " + soundalias;
  }

  util::setclientsysstate("clientSoundCommand", state);
  waittime = 0;

  if(var_3dd9dcff) {
    waittime = soundgetplaybacktime(soundalias);
    waittime /= 1000;
  }

  return waittime;
}

#namespace namespace_afa8e18b;

function function_b5959278(ent, var_1d25915, linkedentity, var_e330010e) {
  assert(isDefined(ent), "<dev string:x38>");
  assert(isDefined(ent.soundkey), "<dev string:x52>");

  if(isDefined(linkedentity)) {
    var_e330010e = linkedentity snd::function_bf7c949(var_e330010e);
    linkedoffset = (0, 0, 0);
    linkedangles = (0, 0, 0);

    if(isDefined(var_1d25915)) {
      linkedoffset = var_1d25915;
    }

    assert(isDefined(var_e330010e), "<dev string:x6d>");

    if(var_e330010e == "tag_origin") {
      var_e330010e = "";
    }

    ent enablelinkto();
    ent linkto(linkedentity, var_e330010e, linkedoffset, linkedangles);

    if(!isarray(linkedentity.var_a415b6d6)) {
      linkedentity.var_a415b6d6 = [];
    }

    linkedentity.var_a415b6d6[ent.soundkey] = ent;
    return;
  }

  level._snd.var_92f63ad0[ent.soundkey] = ent;
}

function function_85daf9f0(soundalias, var_1d25915, linkedentity, var_e330010e) {
  ent = undefined;
  spawnorigin = undefined;

  if(isDefined(linkedentity) && isDefined(var_e330010e) && isDefined(var_1d25915)) {
    spawnorigin = linkedentity gettagorigin(var_e330010e);
    spawnorigin += var_1d25915;
  } else if(isDefined(linkedentity) && isDefined(var_e330010e)) {
    spawnorigin = linkedentity gettagorigin(var_e330010e);
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
    ent = spawn("script_model", spawnorigin);

    if(isentity(ent)) {
      ent setModel("tag_origin");
    }
  } else {
    ent = spawn("script_origin", spawnorigin);
  }

  assert(isDefined(ent), "<dev string:x8d>");

  if(isentity(ent)) {
    ent.var_90c86b97 = linkedentity;
    ent.soundtype = # "gentity";
    ent.soundkey = ent getentitynumber();
    ent.targetname = "snd " + soundalias;
  }

  return ent;
}

function function_6ac5b570(ent) {
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

function function_2dde45d9(soundobject, soundalias, initialvolume, delaytime) {
  ent = soundobject;
  currentvolume = undefined;
  ent endon(#"death");
  assert(isDefined(ent));
  assert(isstring(soundalias));
  currentvolume = snd::get_volume(ent);

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

  assert(soundexists(soundalias), "<dev string:xb5>" + soundalias);

  if(soundislooping(soundalias) == 1) {
    ent playLoopSound(soundalias);
  } else {
    donenotifystr = "sounddone";

    if(sessionmodeiscampaigngame()) {
      ent playSound(soundalias);
      var_ef1f34f = 1;

      if(var_ef1f34f) {
        ent thread function_94954510(soundalias, donenotifystr);
      } else {
        ent thread function_bd8d70b0(donenotifystr);
      }
    } else {
      if(isDefined(ent.var_90c86b97) && isDefined(level._snd.var_c7f0039)) {
        waitframe(1);
        ent[[level._snd.var_c7f0039]](soundalias);
      } else {
        ent playSound(soundalias);
      }

      ent thread function_94954510(soundalias, donenotifystr);
    }
  }

  ent.soundalias = soundalias;
}

function function_9f156b27(soundobject, fadeoutseconds) {
  soundobject endon(#"death");
  ent = soundobject;

  if(snd::function_81fac19d(!isDefined(ent) || function_3132f113(ent), "snd: stop on deleted entity!")) {
    if(snd::function_f984063f()) {
      debugbreak();
    }

    return;
  }

  soundalias = ent.soundalias;
  fadeoutseconds = snd::function_ea2f17d1(fadeoutseconds, 0);

  if(isstring(soundalias)) {
    if(is_true(soundislooping(soundalias))) {
      ent stoploopsound(fadeoutseconds);
    } else {
      ent stopsounds();
      ent stopsound(ent.soundalias);
    }

    waitframe(1);
    ent.soundalias = undefined;
  }

  ent.soundtype = undefined;
  function_6ac5b570(ent);
}

function private function_94954510(soundalias, done) {
  ent = self;
  ent endon(#"death");
  waittime = soundgetplaybacktime(soundalias);
  waittime += 250;
  waittime /= 1000;
  wait waittime;
  ent notify(done, ent.soundalias);
  function_6ac5b570(ent);
}

function private function_bd8d70b0(done) {
  ent = self;
  ent endon(#"death");
  ent waittill(done);
  ent notify(done, ent.soundalias);
  function_6ac5b570(ent);
}

function function_2761fc04(ent, var_1d25915, linkedentity, var_e330010e) {
  assert(0, "<dev string:xd3>");
}

function function_5275752c(soundalias, var_1d25915, linkedentity, var_e330010e) {
  assert(0, "<dev string:xd3>");
  return undefined;
}

function function_bdc44456(ent) {
  assert(0, "<dev string:xd3>");
}

function function_bb749fc3(soundobject, soundalias, initialvolume, delaytime) {
  assert(0, "<dev string:xd3>");
}

function function_273d939b(soundobject, fadeoutseconds) {
  assert(0, "<dev string:xd3>");
}

#namespace snd;

function private function_9d361345() {
  player = self;
  vieworigin = player getplayercamerapos();
  return vieworigin;
}

function private function_d33afb70() {
  player = self;
  viewangles = player getplayerangles();
  return viewangles;
}

function private function_51436f04() {
  player = self;
  fov = getdvarfloat(#"cg_fov", 65);
  return fov;
}

function private function_7f94241b(ent) {
  if(ent == level) {
    ent = function_da785aa8()[0];
  }

  return ent;
}

function function_13246855(soundalias, notifystring, player_or_team) {
  ent = function_7f94241b(self);

  if(!isentity(ent) || issentient(ent) && !isalive(ent)) {
    return;
  }

  ent endon(#"death");
  snd = play(notifystring, [ent, "j_head"]);
  function_f4f3a2a(snd, ent);

  if(isDefined(player_or_team)) {
    function_2fdc4fb(snd);
    ent notify(player_or_team);
  }
}

function function_fb9b8ef4(soundalias) {
  ent = function_7f94241b(self);
  stop_alias(soundalias, ent);
}

function function_aeea7f5e(soundalias, notifystring, player_or_team) {
  ent = function_7f94241b(self);

  if(!isentity(ent) || issentient(ent) && !isalive(ent)) {
    return;
  }

  waittime = client_voice(ent, notifystring);

  if(isDefined(player_or_team)) {
    wait waittime;
    self notify(player_or_team);
  }
}

function function_4264ab7c(soundalias) {
  ent = function_7f94241b(self);
  client_voice(ent);
}