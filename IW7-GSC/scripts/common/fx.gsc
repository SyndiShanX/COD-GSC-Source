/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\common\fx.gsc
*********************************************/

initfx() {
  if(!scripts\engine\utility::add_init_script("fx", ::initfx)) {
    return;
  }

  scripts\engine\utility::add_func_ref_MAYBE("create_triggerfx", ::create_triggerfx);
  thread init_fx_thread();
}

init_fx_thread() {
  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  scripts\engine\utility::create_lock("createfx_looper", 20);
  level._fx.fireloopmod = 1;
  level._fx.exploderfunction = scripts\common\exploder::exploder_before_load;
  waittillframeend;
  waittillframeend;
  level._fx.exploderfunction = scripts\common\exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;
  if(getdvarint("serverCulledSounds") == 1) {
    level._fx.server_culled_sounds = 1;
  }

  if(level.createfx_enabled) {
    level._fx.server_culled_sounds = 0;
  }

  if(level.createfx_enabled) {
    level waittill("createfx_common_done");
  }

  for(var_0 = 0; var_0 < level.createfxent.size; var_0++) {
    var_1 = level.createfxent[var_0];
    var_1 scripts\common\createfx::set_forward_and_up_vectors();
    switch (var_1.v["type"]) {
      case "loopfx":
        var_1 thread loopfxthread();
        break;

      case "oneshotfx":
        var_1 thread oneshotfxthread();
        break;

      case "soundfx":
        var_1 thread create_loopsound();
        break;

      case "soundfx_interval":
        var_1 thread create_interval_sound();
        break;

      case "reactive_fx":
        var_1 add_reactive_fx();
        break;
    }
  }

  check_createfx_limit();
}

remove_dupes() {}

offset_fix() {}

check_createfx_limit() {}

check_limit_type(var_0, var_1) {}

print_org(var_0, var_1, var_2, var_3) {
  if(getDvar("debug") == "1") {}
}

func_C519(var_0, var_1, var_2, var_3) {}

loopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::createloopeffect(var_0);
  var_7.v["origin"] = var_1;
  var_7.v["angles"] = (0, 0, 0);
  if(isDefined(var_3)) {
    var_7.v["angles"] = vectortoangles(var_3 - var_1);
  }

  var_7.v["delay"] = var_2;
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

  var_0 = 0;
  var_1 = undefined;
  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper)) {
      var_1 = "death";
    } else {
      var_1 = "stop_loop";
    }
  } else if(level._fx.server_culled_sounds && isDefined(self.v["server_culled"])) {
    var_0 = self.v["server_culled"];
  }

  var_2 = self;
  if(isDefined(self.looper)) {
    var_2 = self.looper;
  }

  var_3 = undefined;
  if(level.createfx_enabled) {
    var_3 = self;
  }

  var_2 scripts\engine\utility::loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, var_1, var_3);
}

create_interval_sound() {
  self notify("stop_loop");
  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var_0 = undefined;
  var_1 = self;
  if((isDefined(self.v["stopable"]) && self.v["stopable"]) || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      var_1 = self.looper;
      var_0 = "death";
    } else {
      var_0 = "stop_loop";
    }
  }

  var_1 thread scripts\engine\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, undefined, self.v["delay_min"], self.v["delay_max"]);
}

loopfxthread() {
  scripts\engine\utility::waitframe();
  if(isDefined(self.fxstart)) {
    level waittill("start fx" + self.fxstart);
  }

  for(;;) {
    create_looper();
    if(isDefined(self.timeout)) {
      thread loopfxstop(self.timeout);
    }

    if(isDefined(self.fxstop)) {
      level waittill("stop fx" + self.fxstop);
    } else {
      return;
    }

    if(isDefined(self.looper)) {
      self.looper delete();
    }

    if(isDefined(self.fxstart)) {
      level waittill("start fx" + self.fxstart);
      continue;
    }
  }
}

loopfxstop(var_0) {
  self endon("death");
  wait(var_0);
  self.looper delete();
}

loopsound(var_0, var_1, var_2) {
  level thread loopsoundthread(var_0, var_1, var_2);
}

loopsoundthread(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);
}

gunfireloopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("stop all gunfireloopfx");
  scripts\engine\utility::waitframe();
  if(var_7 < var_6) {
    var_8 = var_7;
    var_7 = var_6;
    var_6 = var_8;
  }

  var_9 = var_6;
  var_10 = var_7 - var_6;
  if(var_5 < var_4) {
    var_8 = var_5;
    var_5 = var_4;
    var_4 = var_8;
  }

  var_11 = var_4;
  var_12 = var_5 - var_4;
  if(var_3 < var_2) {
    var_8 = var_3;
    var_3 = var_2;
    var_2 = var_8;
  }

  var_13 = var_2;
  var_14 = var_3 - var_2;
  var_15 = spawnfx(level._effect[var_0], var_1);
  if(!level.createfx_enabled) {
    var_15 willneverchange();
  }

  for(;;) {
    var_10 = var_13 + randomint(var_14);
    for(var_11 = 0; var_11 < var_10; var_11++) {
      triggerfx(var_15);
      wait(var_11 + randomfloat(var_12));
    }

    wait(var_9 + randomfloat(var_10));
  }
}

create_triggerfx() {
  if(!verify_effects_assignment(self.v["fxid"])) {
    return;
  }

  self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper, self.v["delay"]);
  if(!level.createfx_enabled) {
    self.looper willneverchange();
  }

  create_loopsound();
}

verify_effects_assignment(var_0) {
  if(isDefined(level._effect[var_0])) {
    return 1;
  }

  if(!isDefined(level._missing_fx)) {
    level._missing_fx = [];
  }

  level._missing_fx[self.v["fxid"]] = var_0;
  verify_effects_assignment_print(var_0);
  return 0;
}

verify_effects_assignment_print(var_0) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  wait(0.05);
  var_1 = getarraykeys(level._missing_fx);
  foreach(var_3 in var_1) {}
}

oneshotfxthread() {
  wait(0.05);
  if(self.v["delay"] > 0) {
    wait(self.v["delay"]);
  }

  [[level.func["create_triggerfx"]]]();
}

add_reactive_fx() {
  if(!scripts\engine\utility::issp() && getDvar("createfx") == "") {
    return;
  }

  if(!isDefined(level._fx.reactive_thread)) {
    level._fx.reactive_thread = 1;
    level thread reactive_fx_thread();
  }

  if(!isDefined(level._fx.reactive_fx_ents)) {
    level._fx.reactive_fx_ents = [];
  }

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self.next_reactive_time = 3000;
}

reactive_fx_thread() {
  if(!scripts\engine\utility::issp()) {
    if(getDvar("createfx") == "on") {
      scripts\engine\utility::flag_wait("createfx_started");
    }
  }

  level._fx.reactive_sound_ents = [];
  var_0 = 256;
  for(;;) {
    level waittill("code_damageradius", var_1, var_0, var_2, var_3, var_4);
    var_5 = sort_reactive_ents(var_2, var_0);
    foreach(var_8, var_7 in var_5) {
      var_7 thread play_reactive_fx(var_8, var_4);
    }
  }
}

vector2d(var_0) {
  return (var_0[0], var_0[1], 0);
}

sort_reactive_ents(var_0, var_1) {
  var_2 = [];
  var_3 = gettime();
  foreach(var_5 in level._fx.reactive_fx_ents) {
    if(var_5.next_reactive_time > var_3) {
      continue;
    }

    var_6 = var_5.v["reactive_radius"] + var_1;
    var_6 = var_6 * var_6;
    if(distancesquared(var_0, var_5.v["origin"]) < var_6) {
      var_2[var_2.size] = var_5;
    }
  }

  foreach(var_5 in var_2) {
    var_9 = vector2d(var_5.v["origin"] - level.player.origin);
    var_10 = vector2d(var_0 - level.player.origin);
    var_11 = vectornormalize(var_9);
    var_12 = vectornormalize(var_10);
    var_5.dot = vectordot(var_11, var_12);
  }

  for(var_14 = 0; var_14 < var_2.size - 1; var_14++) {
    for(var_15 = var_14 + 1; var_15 < var_2.size; var_15++) {
      if(var_2[var_14].dot > var_2[var_15].dot) {
        var_10 = var_2[var_14];
        var_2[var_14] = var_2[var_15];
        var_2[var_15] = var_10;
      }
    }
  }

  foreach(var_5 in var_2) {
    var_5.origin = undefined;
    var_5.dot = undefined;
  }

  for(var_14 = 4; var_14 < var_2.size; var_14++) {
    var_2[var_14] = undefined;
  }

  return var_2;
}

play_reactive_fx(var_0, var_1) {
  if(self.v["fxid"] != "No FX") {
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var_2 = get_reactive_sound_ent();
  if(!isDefined(var_2)) {
    return;
  }

  self.next_reactive_time = gettime() + 3000;
  var_2.origin = self.v["origin"];
  var_2.is_playing = 1;
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  wait(var_0 * randomfloatrange(0.05, 0.1) + var_1);
  if(scripts\engine\utility::issp()) {
    var_2 playSound(self.v["soundalias"], "sounddone");
    var_2 waittill("sounddone");
  } else {
    var_2 playSound(self.v["soundalias"]);
    wait(2);
  }

  wait(0.1);
  var_2.is_playing = 0;
}

get_reactive_sound_ent() {
  foreach(var_1 in level._fx.reactive_sound_ents) {
    if(!var_1.is_playing) {
      return var_1;
    }
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_1;
    return var_1;
  }

  return undefined;
}

playfxnophase(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = [];
  foreach(var_7 in level.players) {
    if(var_7 isinphase()) {
      var_4 = 1;
      continue;
    }

    var_5[var_5.size] = var_7;
  }

  if(var_4) {
    foreach(var_7 in var_5) {
      playFX(var_0, var_1, var_2, var_3, var_7);
    }

    return;
  }

  playFX(var_0, var_1, var_2, var_3);
}