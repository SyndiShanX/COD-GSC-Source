/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\fx.gsc
***********************************************/

initfx() {
  if(!scripts\engine\utility::add_init_script("fx", ::initfx)) {
    return;
  }
  scripts\engine\utility::set_createfx_enabled();

  if(havemapentseffects())
    level.createfxent = [];

  scripts\engine\utility::create_func_ref("create_triggerfx", ::create_triggerfx);
  thread init_fx_thread();
  script_struct_fx_init();
}

init_fx_thread() {
  if(!isDefined(level._fx))
    level._fx = spawnStruct();

  scripts\engine\utility::create_lock("createfx_looper", 20);
  level._fx.fireloopmod = 1;
  level._fx.exploderfunction = scripts\common\exploder::exploder_before_load;
  waittillframeend;
  waittillframeend;
  level._fx.exploderfunction = scripts\common\exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;

  if(getdvarint("serverculledsounds") == 1)
    level._fx.server_culled_sounds = 1;

  if(level.createfx_enabled)
    level._fx.server_culled_sounds = 0;

  if(level.createfx_enabled)
    level waittill("createfx_common_done");

  level.createfxexploders = [];
  _id_4C5056380AB96E2D = [];

  foreach(ent in level.createfxent) {
    ent scripts\common\createfx::set_forward_and_up_vectors();

    switch (ent.v["type"]) {
      case "loopfx":
        ent thread loopfxthread();
        break;
      case "oneshotfx":
        ent thread oneshotfxthread();
        break;
      case "soundfx":
        ent thread create_loopsound();
        break;
      case "soundfx_interval":
        ent thread create_interval_sound();
        break;
      case "reactive_fx":
        ent add_reactive_fx();
        break;
    }

    if(isDefined(ent.v["exploder"])) {
      scripts\common\createfx::add_exploder(ent.v["exploder"], ent);

      if(isDefined(ent.v["flag"]) && ent.v["flag"] != "nil") {
        temp = _id_4C5056380AB96E2D[ent.v["flag"]];

        if(!isDefined(temp))
          temp = [];

        temp[temp.size] = ent.v["exploder"];
        _id_4C5056380AB96E2D[ent.v["flag"]] = temp;
      }
    }
  }

  foreach(msg, _id_E2A3F554E65A5CED in _id_4C5056380AB96E2D)
  thread scripts\common\exploder::exploder_flag_wait(msg, _id_E2A3F554E65A5CED);

  check_createfx_limit();
}

remove_dupes() {}

offset_fix() {}

check_createfx_limit() {}

check_limit_type(type, count) {}

print_org(_id_020F391862892584, _id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, waittime) {
  if(getDvar("debug") == "1")
    return;
}

loopfx(_id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, waittime, _id_364F55168DC8057F, fxstart, fxstop, timeout) {
  ent = scripts\engine\utility::createloopeffect(_id_8C44BF99399EDF9A);
  ent.v["origin"] = _id_CC5C9FF8C3C69BB7;
  ent.v["angles"] = (0, 0, 0);

  if(isDefined(_id_364F55168DC8057F))
    ent.v["angles"] = vectortoangles(_id_364F55168DC8057F - _id_CC5C9FF8C3C69BB7);

  ent.v["delay"] = waittime;
}

create_looper() {
  self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

create_loopsound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  _id_331418EF0C2252D0 = 0;
  _id_0202BDD087FA1AE6 = undefined;

  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper))
      _id_0202BDD087FA1AE6 = "death";
    else
      _id_0202BDD087FA1AE6 = "stop_loop";
  } else if(level._fx.server_culled_sounds && isDefined(self.v["server_culled"]))
    _id_331418EF0C2252D0 = self.v["server_culled"];

  ent = self;

  if(isDefined(self.looper))
    ent = self.looper;

  createfx_ent = undefined;

  if(level.createfx_enabled)
    createfx_ent = self;

  ent scripts\engine\utility::loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], _id_331418EF0C2252D0, _id_0202BDD087FA1AE6, createfx_ent);
}

create_interval_sound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  ender = undefined;
  runner = self;

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      runner = self.looper;
      ender = "death";
    } else
      ender = "stop_loop";
  }

  runner thread scripts\engine\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], ender, undefined, self.v["delay_min"], self.v["delay_max"]);
}

loopfxthread() {
  waitframe();

  if(isDefined(self.fxstart))
    level waittill("start fx" + self.fxstart);

  for(;;) {
    create_looper();

    if(isDefined(self.timeout))
      thread loopfxstop(self.timeout);

    if(isDefined(self.fxstop))
      level waittill("stop fx" + self.fxstop);
    else
      return;

    if(isDefined(self.looper))
      self.looper delete();

    if(isDefined(self.fxstart)) {
      level waittill("start fx" + self.fxstart);
      continue;
    }

    return;
  }
}

loopfxstop(timeout) {
  self endon("death");
  wait(timeout);
  self.looper delete();
}

gunfireloopfx(_id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, _id_06C9683A0E7FD1D2, _id_06A5723A0E576D18, _id_7766A7EB755502F8, _id_7789BDEB757B7B12, _id_2D4247FA398C3BC2, _id_2D1F31FA3965C3A8) {
  thread gunfireloopfxthread(_id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, _id_06C9683A0E7FD1D2, _id_06A5723A0E576D18, _id_7766A7EB755502F8, _id_7789BDEB757B7B12, _id_2D4247FA398C3BC2, _id_2D1F31FA3965C3A8);
}

gunfireloopfxthread(_id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, _id_06C9683A0E7FD1D2, _id_06A5723A0E576D18, _id_7766A7EB755502F8, _id_7789BDEB757B7B12, _id_2D4247FA398C3BC2, _id_2D1F31FA3965C3A8) {
  level endon("stop all gunfireloopfx");
  waitframe();

  if(_id_2D1F31FA3965C3A8 < _id_2D4247FA398C3BC2) {
    temp = _id_2D1F31FA3965C3A8;
    _id_2D1F31FA3965C3A8 = _id_2D4247FA398C3BC2;
    _id_2D4247FA398C3BC2 = temp;
  }

  _id_ECD1CDA89335EE1B = _id_2D4247FA398C3BC2;
  _id_946DCF7383B79C43 = _id_2D1F31FA3965C3A8 - _id_2D4247FA398C3BC2;

  if(_id_7789BDEB757B7B12 < _id_7766A7EB755502F8) {
    temp = _id_7789BDEB757B7B12;
    _id_7789BDEB757B7B12 = _id_7766A7EB755502F8;
    _id_7766A7EB755502F8 = temp;
  }

  _id_7C20A38FF2740811 = _id_7766A7EB755502F8;
  _id_92B47DFD6D264929 = _id_7789BDEB757B7B12 - _id_7766A7EB755502F8;

  if(_id_06A5723A0E576D18 < _id_06C9683A0E7FD1D2) {
    temp = _id_06A5723A0E576D18;
    _id_06A5723A0E576D18 = _id_06C9683A0E7FD1D2;
    _id_06C9683A0E7FD1D2 = temp;
  }

  _id_9DE84A07378256AB = _id_06C9683A0E7FD1D2;
  _id_CC550627BA0C20F3 = _id_06A5723A0E576D18 - _id_06C9683A0E7FD1D2;
  fxent = spawnfx(level._effect[_id_8C44BF99399EDF9A], _id_CC5C9FF8C3C69BB7);

  if(!level.createfx_enabled)
    fxent willneverchange();

  for(;;) {
    _id_305B1B326D21E99F = _id_9DE84A07378256AB + randomint(_id_CC550627BA0C20F3);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_305B1B326D21E99F; _id_AC0E594AC96AA3A8++) {
      triggerfx(fxent);
      wait(_id_7C20A38FF2740811 + randomfloat(_id_92B47DFD6D264929));
    }

    wait(_id_ECD1CDA89335EE1B + randomfloat(_id_946DCF7383B79C43));
  }
}

create_triggerfx() {
  if(!verify_effects_assignment(self.v["fxid"])) {
    return;
  }
  self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper, self.v["delay"]);

  if(!level.createfx_enabled)
    self.looper willneverchange();

  create_loopsound();
}

verify_effects_assignment(effectid) {
  if(isDefined(level._effect[effectid]))
    return 1;

  if(!isDefined(level._missing_fx))
    level._missing_fx = [];

  level._missing_fx[self.v["fxid"]] = effectid;
  verify_effects_assignment_print(effectid);
  return 0;
}

verify_effects_assignment_print(effectid) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  waitframe();
  keys = getarraykeys(level._missing_fx);

  foreach(key in keys) {}
}

oneshotfxthread() {
  waitframe();

  if(self.v["delay"] > 0)
    wait(self.v["delay"]);

  [[level.func["create_triggerfx"]]]();
}

add_reactive_fx() {
  if(!scripts\common\utility::issp() && getDvar("createfx") == "") {
    return;
  }
  if(!isDefined(level._fx.reactive_thread)) {
    level._fx.reactive_thread = 1;
    level thread reactive_fx_thread();
  }

  if(!isDefined(level._fx.reactive_fx_ents))
    level._fx.reactive_fx_ents = [];

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self.next_reactive_time = 3000;
}

reactive_fx_thread() {
  if(!scripts\common\utility::issp()) {
    if(getDvar("createfx") == "on")
      scripts\engine\utility::flag_wait("createfx_started");
  }

  level._fx.reactive_sound_ents = [];
  _id_2137922BE2342EC7 = 256;

  for(;;) {
    level waittill("code_damageradius", attacker, _id_2137922BE2342EC7, point, objweapon, delay);
    ents = sort_reactive_ents(point, _id_2137922BE2342EC7);

    foreach(_id_AC0E594AC96AA3A8, ent in ents)
    ent thread play_reactive_fx(_id_AC0E594AC96AA3A8, delay);
  }
}

vector2d(_id_06A3A1033FFC2699) {
  return (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], 0);
}

sort_reactive_ents(point, _id_2137922BE2342EC7) {
  _id_114AB88507847C50 = [];
  time = gettime();

  foreach(ent in level._fx.reactive_fx_ents) {
    if(ent.next_reactive_time > time) {
      continue;
    }
    _id_2C5BC6B981D47171 = ent.v["reactive_radius"] + _id_2137922BE2342EC7;
    _id_2C5BC6B981D47171 = _id_2C5BC6B981D47171 * _id_2C5BC6B981D47171;

    if(distancesquared(point, ent.v["origin"]) < _id_2C5BC6B981D47171)
      _id_114AB88507847C50[_id_114AB88507847C50.size] = ent;
  }

  foreach(ent in _id_114AB88507847C50) {
    _id_AF1392A218A7888A = vector2d(ent.v["origin"] - level.player.origin);
    _id_C2DA92F3A0A86861 = vector2d(point - level.player.origin);
    _id_9601C225B7890378 = vectorNormalize(_id_AF1392A218A7888A);
    _id_9601C525B7890A11 = vectorNormalize(_id_C2DA92F3A0A86861);
    ent.dot = vectordot(_id_9601C225B7890378, _id_9601C525B7890A11);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_114AB88507847C50.size - 1; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_114AB88507847C50.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_114AB88507847C50[_id_AC0E594AC96AA3A8].dot > _id_114AB88507847C50[_id_AC0E5C4AC96AAA41].dot) {
        temp = _id_114AB88507847C50[_id_AC0E594AC96AA3A8];
        _id_114AB88507847C50[_id_AC0E594AC96AA3A8] = _id_114AB88507847C50[_id_AC0E5C4AC96AAA41];
        _id_114AB88507847C50[_id_AC0E5C4AC96AAA41] = temp;
      }
    }
  }

  foreach(ent in _id_114AB88507847C50) {
    ent.origin = undefined;
    ent.dot = undefined;
  }

  for(_id_AC0E594AC96AA3A8 = 4; _id_AC0E594AC96AA3A8 < _id_114AB88507847C50.size; _id_AC0E594AC96AA3A8++)
    _id_114AB88507847C50[_id_AC0E594AC96AA3A8] = undefined;

  return _id_114AB88507847C50;
}

play_reactive_fx(num, delay) {
  if(self.v["fxid"] != "No FX")
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);

  if(self.v["soundalias"] == "nil") {
    return;
  }
  sound_ent = get_reactive_sound_ent();

  if(!isDefined(sound_ent)) {
    return;
  }
  self.next_reactive_time = gettime() + 3000;
  sound_ent.origin = self.v["origin"];
  sound_ent.is_playing = 1;

  if(!isDefined(delay))
    delay = 0.0;

  wait(num * randomfloatrange(0.05, 0.1) + delay);

  if(scripts\common\utility::issp()) {
    sound_ent playSound(self.v["soundalias"], "sounddone");
    sound_ent waittill("sounddone");
  } else {
    sound_ent playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  sound_ent.is_playing = 0;
}

get_reactive_sound_ent() {
  foreach(ent in level._fx.reactive_sound_ents) {
    if(!ent.is_playing)
      return ent;
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    ent = spawn("script_origin", (0, 0, 0));
    ent.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = ent;
    return ent;
  }

  return undefined;
}

playfxnophase(fx, location, _id_68FD30DB511477F5, _id_89CD0863B0FA67EB) {
  playFX(fx, location, _id_68FD30DB511477F5, _id_89CD0863B0FA67EB);
}

script_struct_fx_init() {
  level.struct_fx = scripts\engine\utility::getStructArray("struct_fx", "targetname");

  foreach(struct in level.struct_fx) {
    if(!scripts\common\utility::issp() || !isDefined(struct.script_fxgroup))
      play_struct_fx(struct);
  }
}

play_struct_fx(struct) {
  if(isDefined(struct.script_fxid) && isDefined(level._effect[struct.script_fxid])) {
    if(!isDefined(struct.angles))
      struct.angles = (0, 0, 0);

    struct.fx = spawnfx(level._effect[struct.script_fxid], struct.origin, anglesToForward(struct.angles), anglestoup(struct.angles));

    if(isDefined(struct.script_delay_min) && isDefined(struct.script_delay_max))
      triggerfx(struct.fx, randomfloat(struct.script_delay_min, struct.script_delay_max) / 1000);
    else if(isDefined(struct.script_delay))
      triggerfx(struct.fx, struct.script_delay / 1000);
    else
      triggerfx(struct.fx, -0.004);
  }

  if(isDefined(struct.script_soundalias)) {
    struct.sfx = spawn("script_origin", struct.origin);
    struct.sfx.angles = struct.angles;

    if(soundislooping(struct.script_soundalias))
      struct.sfx playLoopSound(struct.script_soundalias);
    else
      struct.sfx playSound(struct.script_soundalias);
  }
}

stop_struct_fx(struct) {
  struct.fx delete();

  if(isDefined(struct.sfx))
    struct.sfx delete();
}

struct_fx_active(struct) {
  return isDefined(struct.fx);
}

struct_fx_inactive(struct) {
  return !isDefined(struct.fx);
}