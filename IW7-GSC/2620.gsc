/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2620.gsc
***************************************/

initfx() {
  if(!scripts\engine\utility::add_init_script("fx", ::initfx)) {
    return;
  }
  scripts\engine\utility::add_func_ref_MAYBE("create_triggerfx", ::create_triggerfx);
  thread init_fx_thread();
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

  if(getdvarint("serverCulledSounds") == 1)
    level._fx.server_culled_sounds = 1;

  if(level.createfx_enabled)
    level._fx.server_culled_sounds = 0;

  if(level.createfx_enabled)
    level waittill("createfx_common_done");

  for(var_00 = 0; var_00 < level.createfxent.size; var_0++) {
    var_01 = level.createfxent[var_00];
    var_01 scripts\common\createfx::set_forward_and_up_vectors();

    switch (var_1.v["type"]) {
      case "loopfx":
        var_01 thread loopfxthread();
        break;
      case "oneshotfx":
        var_01 thread oneshotfxthread();
        break;
      case "soundfx":
        var_01 thread create_loopsound();
        break;
      case "soundfx_interval":
        var_01 thread create_interval_sound();
        break;
      case "reactive_fx":
        var_01 add_reactive_fx();
        break;
    }
  }

  check_createfx_limit();
}

remove_dupes() {}

offset_fix() {}

check_createfx_limit() {}

check_limit_type(var_00, var_01) {}

print_org(var_00, var_01, var_02, var_03) {
  if(getdvar("debug") == "1")
    return;
}

func_C519(var_00, var_01, var_02, var_03) {}

loopfx(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = scripts\engine\utility::createloopeffect(var_00);
  var_7.v["origin"] = var_01;
  var_7.v["angles"] = (0, 0, 0);

  if(isDefined(var_03))
    var_7.v["angles"] = vectortoangles(var_03 - var_01);

  var_7.v["delay"] = var_02;
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
  var_00 = 0;
  var_01 = undefined;

  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper))
      var_01 = "death";
    else
      var_01 = "stop_loop";
  } else if(level._fx.server_culled_sounds && isDefined(self.v["server_culled"]))
    var_00 = self.v["server_culled"];

  var_02 = self;

  if(isDefined(self.looper))
    var_02 = self.looper;

  var_03 = undefined;

  if(level.createfx_enabled)
    var_03 = self;

  var_02 scripts\engine\utility::loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_00, var_01, var_03);
}

create_interval_sound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_00 = undefined;
  var_01 = self;

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      var_01 = self.looper;
      var_00 = "death";
    } else
      var_00 = "stop_loop";
  }

  var_01 thread scripts\engine\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_00, undefined, self.v["delay_min"], self.v["delay_max"]);
}

loopfxthread() {
  scripts\engine\utility::waitframe();

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

loopfxstop(var_00) {
  self endon("death");
  wait(var_00);
  self.looper delete();
}

loopsound(var_00, var_01, var_02) {
  level thread loopsoundthread(var_00, var_01, var_02);
}

loopsoundthread(var_00, var_01, var_02) {
  var_03 = spawn("script_origin", var_01);
  var_3.origin = var_01;
  var_03 playLoopSound(var_00);
}

gunfireloopfx(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  thread gunfireloopfxthread(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
}

gunfireloopfxthread(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  level endon("stop all gunfireloopfx");
  scripts\engine\utility::waitframe();

  if(var_07 < var_06) {
    var_08 = var_07;
    var_07 = var_06;
    var_06 = var_08;
  }

  var_09 = var_06;
  var_10 = var_07 - var_06;

  if(var_05 < var_04) {
    var_08 = var_05;
    var_05 = var_04;
    var_04 = var_08;
  }

  var_11 = var_04;
  var_12 = var_05 - var_04;

  if(var_03 < var_02) {
    var_08 = var_03;
    var_03 = var_02;
    var_02 = var_08;
  }

  var_13 = var_02;
  var_14 = var_03 - var_02;
  var_15 = spawnfx(level._effect[var_00], var_01);

  if(!level.createfx_enabled)
    var_15 willneverchange();

  for(;;) {
    var_16 = var_13 + randomint(var_14);

    for(var_17 = 0; var_17 < var_16; var_17++) {
      triggerfx(var_15);
      wait(var_11 + randomfloat(var_12));
    }

    wait(var_09 + randomfloat(var_10));
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

verify_effects_assignment(var_00) {
  if(isDefined(level._effect[var_00]))
    return 1;

  if(!isDefined(level._missing_fx))
    level._missing_fx = [];

  level._missing_fx[self.v["fxid"]] = var_00;
  verify_effects_assignment_print(var_00);
  return 0;
}

verify_effects_assignment_print(var_00) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  wait 0.05;
  var_01 = getarraykeys(level._missing_fx);

  foreach(var_03 in var_01) {}
}

oneshotfxthread() {
  wait 0.05;

  if(self.v["delay"] > 0)
    wait(self.v["delay"]);

  [
    [level.func["create_triggerfx"]]
  ]();
}

add_reactive_fx() {
  if(!scripts\engine\utility::issp() && getdvar("createfx") == "") {
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
  if(!scripts\engine\utility::issp()) {
    if(getdvar("createfx") == "on")
      scripts\engine\utility::flag_wait("createfx_started");
  }

  level._fx.reactive_sound_ents = [];
  var_00 = 256;

  for(;;) {
    level waittill("code_damageradius", var_01, var_00, var_02, var_03, var_04);
    var_05 = sort_reactive_ents(var_02, var_00);

    foreach(var_08, var_07 in var_05)
    var_07 thread play_reactive_fx(var_08, var_04);
  }
}

vector2d(var_00) {
  return (var_0[0], var_0[1], 0);
}

sort_reactive_ents(var_00, var_01) {
  var_02 = [];
  var_03 = gettime();

  foreach(var_05 in level._fx.reactive_fx_ents) {
    if(var_5.next_reactive_time > var_03) {
      continue;
    }
    var_06 = var_5.v["reactive_radius"] + var_01;
    var_06 = var_06 * var_06;

    if(distancesquared(var_00, var_5.v["origin"]) < var_06)
      var_2[var_2.size] = var_05;
  }

  foreach(var_05 in var_02) {
    var_09 = vector2d(var_5.v["origin"] - level.player.origin);
    var_10 = vector2d(var_00 - level.player.origin);
    var_11 = vectornormalize(var_09);
    var_12 = vectornormalize(var_10);
    var_5.dot = vectordot(var_11, var_12);
  }

  for(var_14 = 0; var_14 < var_2.size - 1; var_14++) {
    for(var_15 = var_14 + 1; var_15 < var_2.size; var_15++) {
      if(var_2[var_14].dot > var_2[var_15].dot) {
        var_16 = var_2[var_14];
        var_2[var_14] = var_2[var_15];
        var_2[var_15] = var_16;
      }
    }
  }

  foreach(var_05 in var_02) {
    var_5.origin = undefined;
    var_5.dot = undefined;
  }

  for(var_14 = 4; var_14 < var_2.size; var_14++)
    var_2[var_14] = undefined;

  return var_02;
}

play_reactive_fx(var_00, var_01) {
  if(self.v["fxid"] != "No FX")
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);

  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_02 = get_reactive_sound_ent();

  if(!isDefined(var_02)) {
    return;
  }
  self.next_reactive_time = gettime() + 3000;
  var_2.origin = self.v["origin"];
  var_2.is_playing = 1;

  if(!isDefined(var_01))
    var_01 = 0.0;

  wait(var_00 * randomfloatrange(0.05, 0.1) + var_01);

  if(scripts\engine\utility::issp()) {
    var_02 playSound(self.v["soundalias"], "sounddone");
    var_02 waittill("sounddone");
  } else {
    var_02 playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  var_2.is_playing = 0;
}

get_reactive_sound_ent() {
  foreach(var_01 in level._fx.reactive_sound_ents) {
    if(!var_1.is_playing)
      return var_01;
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_1.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_01;
    return var_01;
  }

  return undefined;
}

playfxnophase(var_00, var_01, var_02, var_03) {
  var_04 = 0;
  var_05 = [];

  foreach(var_07 in level.players) {
    if(var_07 isinphase()) {
      var_04 = 1;
      continue;
    }

    var_5[var_5.size] = var_07;
  }

  if(var_04) {
    foreach(var_07 in var_05)
    playFX(var_00, var_01, var_02, var_03, var_07);
  } else
    playFX(var_00, var_01, var_02, var_03);
}