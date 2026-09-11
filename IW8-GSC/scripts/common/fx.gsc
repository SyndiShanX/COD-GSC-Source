/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\fx.gsc
***********************************************/

function initfx() {
  if(!scripts\engine\utility::add_init_script("fx", &initfx)) {
    return;
  }

  scripts\engine\utility::set_createfx_enabled();

  if(isplatformconsole()) {
    level.createfxent = [];
  }

  scripts\engine\utility::create_func_ref("create_triggerfx", &create_triggerfx);
  thread init_fx_thread();
  script_struct_fx_init();
}

function init_fx_thread() {
  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  scripts\engine\utility::create_lock("createfx_looper", 20);
  level._fx.fireloopmod = 1;
  level._fx.exploderfunction = &scripts\common\exploder::exploder_before_load;
  waittillframeend();
  waittillframeend();
  level._fx.exploderfunction = &scripts\common\exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;

  if(getdvarint("MKOSOKPQPP") == 1) {
    level._fx.server_culled_sounds = 1;
  }

  if(level.createfx_enabled) {
    level._fx.server_culled_sounds = 0;
  }

  if(level.createfx_enabled) {
    level waittill("createfx_common_done");
  }

  level.createfxexploders = [];
  var0 = [];

  foreach(var2 in level.createfxent) {
    var2 scripts\common\createfx::set_forward_and_up_vectors();

    switch (var2.v["type"]) {
      case "loopfx":
        thread loopfxthread();
        break;
      case "oneshotfx":
        thread oneshotfxthread();
        break;
      case "soundfx":
        thread create_loopsound();
        break;
      case "soundfx_interval":
        thread create_interval_sound();
        break;
      case "reactive_fx":
        add_reactive_fx(var2);
        break;
    }

    if(isDefined(var2.v["exploder"])) {
      scripts\common\createfx::add_exploder(var2.v["exploder"], var2);

      if(isDefined(var2.v["flag"]) && var2.v["flag"] != "nil") {
        var3 = var0[var2.v["flag"]];

        if(!isDefined(var3)) {
          var3 = [];
        }

        GscBinSkip0(0x2e, var3.size, var2.v["exploder"], var2, var2, var2, var2);
      }
    }
  }

  var2 = undefined;
  var3 = undefined;

  foreach(var6 in var1) {
    thread scripts\common\exploder::exploder_flag_wait(var7, var6);
  }

  check_createfx_limit();
}

function remove_dupes() {}

function offset_fix() {}

function check_createfx_limit() {}

function check_limit_type(var0, var1) {}

function print_org(var0, var1, var2, var3) {
  if(getDvar("debug") == "1") {
    return;
  }
}

function loopfx(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\utility::createloopeffect(var0);
  var7.v["origin"] = var1;
  var7.v["angles"] = (0, 0, 0);

  if(isDefined(var3)) {
    var7.v["angles"] = vectortoangles(var3 - var1);
  }

  var7.v["delay"] = var2;
}

function create_looper() {
  self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

function create_loopsound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var0 = 0;
  var1 = undefined;

  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper)) {
      var1 = "death";
    } else {
      var1 = "stop_loop";
    }
  } else if(level._fx.server_culled_sounds && isDefined(self.v["server_culled"])) {
    var0 = self.v["server_culled"];
  }

  var2 = self;

  if(isDefined(self.looper)) {
    var2 = self.looper;
  }

  var3 = undefined;

  if(level.createfx_enabled) {
    var3 = self;
  }

  var2 scripts\engine\utility::loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var0, var1, var3);
}

function create_interval_sound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var0 = undefined;
  var1 = self;

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      var1 = self.looper;
      var0 = "death";
    } else {
      var0 = "stop_loop";
    }
  }

  var1 thread scripts\engine\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var0, undefined, self.v["delay_min"], self.v["delay_max"]);
}

function loopfxthread() {
  waitframe();

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

    return;
  }
}

function loopfxstop(var0) {
  self endon("death");
  wait var0;
  self.looper delete();
}

function gunfireloopfx(var0, var1, var2, var3, var4, var5, var6, var7) {
  thread gunfireloopfxthread(var0, var1, var2, var3, var4, var5, var6, var7);
}

function gunfireloopfxthread(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("stop all gunfireloopfx");
  waitframe();

  if(var7 < var6) {
    var8 = var7;
    var7 = var6;
    var6 = var8;
  }

  var9 = var6;
  var10 = var7 - var6;

  if(var5 < var4) {
    var8 = var5;
    var5 = var4;
    var4 = var8;
  }

  var11 = var4;
  var12 = var5 - var4;

  if(var3 < var2) {
    var8 = var3;
    var3 = var2;
    var2 = var8;
  }

  var13 = var2;
  var14 = var3 - var2;
  var15 = spawnfx(level._effect[var0], var1);
  jumpiftrue(level.createfx_enabled) LOC_00000082;
  var15 willneverchange();

  for(;;) {
    var16 = var13 + randomint(var14);

    for(var17 = 0; var17 < var16; var17++) {
      triggerfx(var15);
      wait var11 + randomfloat(var12);
    }

    wait var9 + randomfloat(var10);
  }
}

function create_triggerfx() {
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

function verify_effects_assignment(var0) {
  if(isDefined(level._effect[var0])) {
    return true;
  }

  if(!isDefined(level._missing_fx)) {
    level._missing_fx = [];
  }

  level._missing_fx[self.v["fxid"]] = var0;
  verify_effects_assignment_print(var0);
  return false;
}

function verify_effects_assignment_print(var0) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  waitframe();
  var1 = getarraykeys(level._missing_fx);

  foreach(var3 in var1) {}
}

function oneshotfxthread() {
  waitframe();

  if(self.v["delay"] > 0) {
    wait self.v["delay"];
  }

  [[level.func["create_triggerfx"]]]();
}

function add_reactive_fx() {
  if(!scripts\common\utility::issp() && getDvar("LSTTOTKPNP") == "") {
    return;
  }

  if(!isDefined(level._fx.reactive_thread)) {
    level._fx.reactive_thread = 1;
    thread reactive_fx_thread();
  }

  if(!isDefined(level._fx.reactive_fx_ents)) {
    level._fx.reactive_fx_ents = [];
  }

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self.next_reactive_time = 3000;
}

function reactive_fx_thread() {
  if(!scripts\common\utility::issp()) {
    if(getDvar("LSTTOTKPNP") == "on") {
      scripts\engine\utility::flag_wait("createfx_started");
    }
  }

  level._fx.reactive_sound_ents = [];
  var0 = 256;

  for(;;) {
    level waittill("code_damageradius", var1, var0, var2, var3, var4);
    var5 = sort_reactive_ents(var2, var0);

    foreach(var7 in var5) {
      thread play_reactive_fx(var7, var8);
    }
  }
}

function vector2d(var0) {
  return (var0[0], var0[1], 0);
}

function sort_reactive_ents(var0, var1) {
  var2 = [];
  var3 = gettime();

  foreach(var5 in level._fx.reactive_fx_ents) {
    if(var5.next_reactive_time > var3) {
      continue;
    }

    var6 = var5.v["reactive_radius"] + var1;
    var6 *= var6;

    if(distancesquared(var0, var5.v["origin"]) < var6) {
      var2 = var5;
    }
  }

  foreach(var5 in var2) {
    var9 = vector2d(var5.v["origin"] - level.player.origin);
    var10 = vector2d(var0 - level.player.origin);
    var11 = vectorNormalize(var9);
    var12 = vectorNormalize(var10);
    var5.dot = vectordot(var11, var12);
  }

  for(var14 = 0; var14 < var2.size - 1; var14++) {
    for(var15 = var14 + 1; var15 < var2.size; var15++) {
      if(var2[var14].dot > var2[var15].dot) {
        var16 = var2[var14];
        var2 = var2[var15];
        var2 = var16;
      }
    }
  }

  foreach(var5 in var2) {
    var5.origin = undefined;
    var5.dot = undefined;
  }

  for(var14 = 4; var14 < var2.size; var14++) {
    var2[var14] = undefined;
  }

  return var2;
}

function play_reactive_fx(var0, var1) {
  if(self.v["fxid"] != "No FX") {
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var2 = get_reactive_sound_ent();

  if(!isDefined(var2)) {
    return;
  }

  self.next_reactive_time = gettime() + 3000;
  var2.origin = self.v["origin"];
  var2.is_playing = 1;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  wait var0 * randomfloatrange(0.05, 0.1) + var1;

  if(scripts\common\utility::issp()) {
    var2 playSound(self.v["soundalias"], "sounddone");
    var2 waittill("sounddone");
  } else {
    var2 playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  var2.is_playing = 0;
}

function get_reactive_sound_ent() {
  foreach(var1 in level._fx.reactive_sound_ents) {
    if(!var1.is_playing) {
      return var1;
    }
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    var1 = spawn("script_origin", (0, 0, 0));
    var1.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var1;
    return var1;
  }

  return undefined;
}

function playfxnophase(var0, var1, var2, var3) {
  playFX(var0, var1, var2, var3);
}

function script_struct_fx_init() {
  level.struct_fx = scripts\engine\utility::getStructArray("struct_fx", "targetname");

  foreach(var1 in level.struct_fx) {
    if(!scripts\common\utility::issp() || !isDefined(var1.script_fxgroup)) {
      play_struct_fx(var1);
    }
  }
}

function play_struct_fx(var0) {
  if(isDefined(var0.script_fxid) && isDefined(level._effect[var0.script_fxid])) {
    if(!isDefined(var0.angles)) {
      var0.angles = (0, 0, 0);
    }

    var0.fx = spawnfx(level._effect[var0.script_fxid], var0.origin, anglesToForward(var0.angles), anglestoup(var0.angles));

    if(isDefined(var0.script_delay_min) && isDefined(var0.script_delay_max)) {
      triggerfx(var0.fx, randomfloat(var0.script_delay_min, var0.script_delay_max) / 1000);
    } else if(isDefined(var0.script_delay)) {
      triggerfx(var0.fx, var0.script_delay / 1000);
    } else {
      triggerfx(var0.fx, -0.004);
    }
  }

  if(isDefined(var0.script_soundalias)) {
    var0.sfx = spawn("script_origin", var0.origin);
    var0.sfx.angles = var0.angles;

    if(soundislooping(var0.script_soundalias)) {
      var0.sfx playLoopSound(var0.script_soundalias);
      return;
    }

    var0.sfx playSound(var0.script_soundalias);
    return;
  }
}

function stop_struct_fx(var0) {
  var0.fx delete();

  if(isDefined(var0.sfx)) {
    var0.sfx delete();
    return;
  }
}

function struct_fx_active(var0) {
  return isDefined(var0.fx);
}

function struct_fx_inactive(var0) {
  return !isDefined(var0.fx);
}