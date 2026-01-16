/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_fx.gsc
********************************/

initfx() {
  if(!isdefined(level.func))
    level.func = [];

  if(!isdefined(level.func["create_triggerfx"]))
    level.func["create_triggerfx"] = ::create_triggerfx;

  if(!isdefined(level._fx))
    level._fx = spawnstruct();

  common_scripts\utility::create_lock("createfx_looper", 20);
  level.fxfireloopmod = 1;
  level._fx.exploderfunction = common_scripts\_exploder::exploder_before_load;
  waittillframeend;
  waittillframeend;
  level._fx.exploderfunction = common_scripts\_exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;

  if(getdvarint("serverCulledSounds") == 1)
    level._fx.server_culled_sounds = 1;

  if(level.createfx_enabled)
    level._fx.server_culled_sounds = 0;

  if(level.createfx_enabled)
    level waittill("createfx_common_done");

  for (var_0 = 0; var_0 < level.createfxent.size; var_0++) {
    var_1 = level.createfxent[var_0];
    var_1 common_scripts\_createfx::set_forward_and_up_vectors();

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
      case "soundfx_dynamic":
        var_1 thread create_dynamicambience();
        break;
    }

    if(isdefined(var_1.v["stop_on_exploder"]))
      var_1 thread common_scripts\_createfx::stop_fx_looper_on_exploder();
  }

  check_createfx_limit();
}

remove_dupes() {}

check_createfx_limit() {}

check_limit_type(var_0, var_1) {}

print_org(var_0, var_1, var_2, var_3) {
  if(getdvar("debug") == "1")
    return;
}

platformmatches() {
  if(isdefined(self.v["platform"]) && isdefined(level.currentgen)) {
    var_0 = self.v["platform"];

    if(var_0 == "cg" && !level.currentgen || var_0 == "ng" && !level.nextgen || var_0 == "xenon" && !level.xenon || var_0 == "ps3" && !level.ps3 || var_0 == "pc" && !level.pc || var_0 == "xb3" && !level.xb3 || var_0 == "ps4" && !level.ps4 || var_0 == "pccg" && !level.pccg || var_0 == "!cg" && level.currentgen || var_0 == "!ng" && level.nextgen || var_0 == "!xenon" && level.xenon || var_0 == "!ps3" && level.ps3 || var_0 == "!pc" && level.pc || var_0 == "!xb3" && level.xb3 || var_0 == "!ps4" && level.ps4 || var_0 == "!pccg" && level.pccg)
      return 0;
  }

  return 1;
}

oneshotfx(var_0, var_1, var_2, var_3) {}

exploderfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17) {
  if(1) {
    var_18 = common_scripts\utility::createexploder(var_1);
    var_18.v["origin"] = var_2;
    var_18.v["angles"] = (0, 0, 0);

    if(isdefined(var_4))
      var_18.v["angles"] = vectortoangles(var_4 - var_2);

    var_18.v["delay"] = var_3;
    var_18.v["exploder"] = var_0;

    if(isdefined(level.createfxexploders)) {
      var_19 = level.createfxexploders[var_18.v["exploder"]];

      if(!isdefined(var_19))
        var_19 = [];

      var_19[var_19.size] = var_18;
      level.createfxexploders[var_18.v["exploder"]] = var_19;
    }

    return;
  }

  var_20 = spawn("script_origin", (0, 0, 0));
  var_20.origin = var_2;
  var_20.angles = vectortoangles(var_4 - var_2);
  var_20.script_exploder = var_0;
  var_20.script_fxid = var_1;
  var_20.script_delay = var_3;
  var_20.script_firefx = var_5;
  var_20.script_firefxdelay = var_6;
  var_20.script_firefxsound = var_7;
  var_20.script_sound = var_8;
  var_20.script_earthquake = var_9;
  var_20.script_damage = var_10;
  var_20.script_radius = var_15;
  var_20.script_soundalias = var_11;
  var_20.script_firefxtimeout = var_16;
  var_20.script_repeat = var_12;
  var_20.script_delay_min = var_13;
  var_20.script_delay_max = var_14;
  var_20.script_exploder_group = var_17;
  var_21 = anglestoforward(var_20.angles);
  var_21 = var_21 * 150;
  var_20.targetpos = var_2 + var_21;

  if(!isdefined(level._script_exploders))
    level._script_exploders = [];

  level._script_exploders[level._script_exploders.size] = var_20;
}

loopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = common_scripts\utility::createloopeffect(var_0);
  var_7.v["origin"] = var_1;
  var_7.v["angles"] = (0, 0, 0);

  if(isdefined(var_3))
    var_7.v["angles"] = vectortoangles(var_3 - var_1);

  var_7.v["delay"] = var_2;
}

create_looper() {
  self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

create_loopsound() {
  if(!platformmatches()) {
    return;
  }
  self notify("stop_loop");

  if(!isdefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_0 = 0;
  var_1 = undefined;

  if(isdefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isdefined(self.looper))
      var_1 = "death";
    else
      var_1 = "stop_loop";
  } else if(level._fx.server_culled_sounds && isdefined(self.v["server_culled"]))
    var_0 = self.v["server_culled"];

  var_2 = self;

  if(isdefined(self.looper))
    var_2 = self.looper;

  var_3 = undefined;

  if(level.createfx_enabled)
    var_3 = self;

  var_2 common_scripts\utility::loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, var_1, var_3);
}

create_interval_sound() {
  if(!platformmatches()) {
    return;
  }
  self notify("stop_loop");

  if(!isdefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_0 = undefined;
  var_1 = self;

  if(isdefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isdefined(self.looper)) {
      var_1 = self.looper;
      var_0 = "death";
    } else
      var_0 = "stop_loop";
  }

  var_1 thread common_scripts\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, undefined, self.v["delay_min"], self.v["delay_max"]);
}

create_dynamicambience() {
  if(!platformmatches()) {
    return;
  }
  if(!isdefined(self.v["ambiencename"])) {
    return;
  }
  if(self.v["ambiencename"] == "nil") {
    return;
  }
  if(common_scripts\utility::issp()) {
    return;
  }
  if(getdvar("createfx") == "on")
    common_scripts\utility::flag_wait("createfx_started");

  if(isdefined(self.dambinfostruct))
    level.player stopdynamicambience(self.dambinfostruct.unique_id);

  self.dambinfostruct = spawnstruct();
  self.dambinfostruct common_scripts\utility::assign_unique_id();
  level.player playdynamicambience(self.v["ambiencename"], self.v["origin"], self.v["dynamic_distance"], self.dambinfostruct.unique_id);
  return;
}

loopfxthread() {
  waitframe();

  if(isdefined(self.fxstart))
    level waittill("start fx" + self.fxstart);

  for (;;) {
    create_looper();

    if(isdefined(self.timeout))
      thread loopfxstop(self.timeout);

    if(isdefined(self.fxstop))
      level waittill("stop fx" + self.fxstop);
    else
      return;

    if(isdefined(self.looper))
      self.looper delete();

    if(isdefined(self.fxstart)) {
      level waittill("start fx" + self.fxstart);
      continue;
    }

    return;
  }
}

loopfxchangeid(var_0) {
  self endon("death");
  var_0 waittill("effect id changed", var_1);
}

loopfxchangeorg(var_0) {
  self endon("death");

  for (;;) {
    var_0 waittill("effect org changed", var_1);
    self.origin = var_1;
  }
}

loopfxchangedelay(var_0) {
  self endon("death");
  var_0 waittill("effect delay changed", var_1);
}

loopfxdeletion(var_0) {
  self endon("death");
  var_0 waittill("effect deleted");
  self delete();
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
  var_3 playloopsound(var_0);
}

gunfireloopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("stop all gunfireloopfx");
  waitframe();

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

  if(!level.createfx_enabled)
    var_15 willneverchange();

  for (;;) {
    var_16 = var_13 + randomint(var_14);

    for (var_17 = 0; var_17 < var_16; var_17++) {
      triggerfx(var_15);
      wait(var_11 + randomfloat(var_12));
    }

    wait(var_9 + randomfloat(var_10));
  }
}

gunfireloopfxvec(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread gunfireloopfxvecthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

gunfireloopfxvecthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("stop all gunfireloopfx");
  waitframe();

  if(var_8 < var_7) {
    var_9 = var_8;
    var_8 = var_7;
    var_7 = var_9;
  }

  var_10 = var_7;
  var_11 = var_8 - var_7;

  if(var_6 < var_5) {
    var_9 = var_6;
    var_6 = var_5;
    var_5 = var_9;
  }

  var_12 = var_5;
  var_13 = var_6 - var_5;

  if(var_4 < var_3) {
    var_9 = var_4;
    var_4 = var_3;
    var_3 = var_9;
  }

  var_14 = var_3;
  var_15 = var_4 - var_3;
  var_2 = vectornormalize(var_2 - var_1);
  var_16 = spawnfx(level._effect[var_0], var_1, var_2);

  if(!level.createfx_enabled)
    var_16 willneverchange();

  for (;;) {
    var_17 = var_14 + randomint(var_15);

    for (var_18 = 0; var_18 < int(var_17 / level.fxfireloopmod); var_18++) {
      triggerfx(var_16);
      var_19 = (var_12 + randomfloat(var_13)) * level.fxfireloopmod;

      if(var_19 < 0.05)
        var_19 = 0.05;

      wait(var_19);
    }

    wait(var_12 + randomfloat(var_13));
    wait(var_10 + randomfloat(var_11));
  }
}

setfireloopmod(var_0) {
  level.fxfireloopmod = 1 / var_0;
}

setup_fx() {
  if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay)) {
    return;
  }
  if(isdefined(self.model)) {
    if(self.model == "toilet") {
      thread burnville_paratrooper_hack();
      return;
    }
  }

  var_0 = undefined;

  if(isdefined(self.target)) {
    var_1 = getent(self.target, "targetname");

    if(isdefined(var_1))
      var_0 = var_1.origin;
  }

  var_2 = undefined;

  if(isdefined(self.script_fxstart))
    var_2 = self.script_fxstart;

  var_3 = undefined;

  if(isdefined(self.script_fxstop))
    var_3 = self.script_fxstop;

  if(self.script_fxcommand == "OneShotfx")
    oneshotfx(self.script_fxid, self.origin, self.script_delay, var_0);

  if(self.script_fxcommand == "loopfx")
    loopfx(self.script_fxid, self.origin, self.script_delay, var_0, var_2, var_3);

  if(self.script_fxcommand == "loopsound")
    loopsound(self.script_fxid, self.origin, self.script_delay);

  self delete();
}

burnville_paratrooper_hack() {
  var_0 = (0, 0, self.angles[1]);
  var_1 = level._effect[self.script_fxid];
  var_2 = self.origin;
  wait 1;
  level thread burnville_paratrooper_hack_loop(var_0, var_2, var_1);
  self delete();
}

burnville_paratrooper_hack_loop(var_0, var_1, var_2) {
  for (;;) {
    playfx(var_2, var_1);
    wait(30 + randomfloat(40));
  }
}

create_triggerfx() {
  if(!verify_effects_assignment(self.v["fxid"])) {
    return;
  }
  if(isdefined(self.v["tintcolor"]) || isdefined(self.v["tintalpha"]) || isdefined(self.v["fadein"]) || isdefined(self.v["fadeout"]) || isdefined(self.v["emissive"]) || isdefined(self.v["sizescale"])) {
    var_0 = self.v["tintcolor"];

    if(!isdefined(var_0))
      var_0 = (1, 1, 1);

    var_1 = self.v["tintalpha"];

    if(!isdefined(var_1))
      var_1 = 1;

    var_2 = self.v["fadein"];

    if(!isdefined(var_2))
      var_2 = (0, 0, 0);

    var_3 = self.v["fadeout"];

    if(!isdefined(var_3))
      var_3 = (0, 0, 0);

    var_4 = self.v["emissive"];

    if(!isdefined(var_4))
      var_4 = 1;

    var_5 = self.v["sizescale"];

    if(!isdefined(var_5))
      var_5 = 1;

    self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);

  triggerfx(self.looper, self.v["delay"]);

  if(!level.createfx_enabled)
    self.looper willneverchange();
  else
    setfxkillondelete(self.looper, 1);

  create_loopsound();
}

verify_effects_assignment(var_0) {
  if(isdefined(level._effect[var_0]))
    return 1;

  if(!isdefined(level._missing_fx))
    level._missing_fx = [];

  level._missing_fx[self.v["fxid"]] = var_0;
  verify_effects_assignment_print(var_0);
  return 0;
}

verify_effects_assignment_print(var_0) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  wait 0.05;
  var_1 = getarraykeys(level._missing_fx);

  foreach(var_3 in var_1) {}
}

oneshotfxthread() {
  wait 0.05;

  if(!platformmatches()) {
    return;
  }
  if(self.v["delay"] > 0)
    wait(self.v["delay"]);

  [[level.func["create_triggerfx"]]]();
}

add_reactive_fx() {
  if(!platformmatches()) {
    return;
  }
  if(!common_scripts\utility::issp() && getdvar("createfx") == "") {
    return;
  }
  if(!isdefined(level._fx.reactive_thread)) {
    level._fx.reactive_thread = 1;
    level thread reactive_fx_thread();
  }

  if(!isdefined(level._fx.reactive_fx_ents))
    level._fx.reactive_fx_ents = [];

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self.next_reactive_time = 3000;
}

reactive_fx_thread() {
  if(!common_scripts\utility::issp()) {
    if(getdvar("createfx") == "on")
      common_scripts\utility::flag_wait("createfx_started");
  }

  level._fx.reactive_sound_ents = [];
  var_0 = 256;

  for (;;) {
    level waittill("code_damageradius", var_1, var_0, var_2, var_3);
    var_4 = sort_reactive_ents(var_2, var_0);

    foreach(var_7, var_6 in var_4)
    var_6 thread play_reactive_fx(var_7);
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

    if(distancesquared(var_0, var_5.v["origin"]) < var_6)
      var_2[var_2.size] = var_5;
  }

  foreach(var_5 in var_2) {
    var_9 = vector2d(var_5.v["origin"] - level.player.origin);
    var_10 = vector2d(var_0 - level.player.origin);
    var_11 = vectornormalize(var_9);
    var_12 = vectornormalize(var_10);
    var_5.dot = vectordot(var_11, var_12);
  }

  for (var_14 = 0; var_14 < var_2.size - 1; var_14++) {
    for (var_15 = var_14 + 1; var_15 < var_2.size; var_15++) {
      if(var_2[var_14].dot > var_2[var_15].dot) {
        var_16 = var_2[var_14];
        var_2[var_14] = var_2[var_15];
        var_2[var_15] = var_16;
      }
    }
  }

  foreach(var_5 in var_2) {
    var_5.origin = undefined;
    var_5.dot = undefined;
  }

  for (var_14 = 4; var_14 < var_2.size; var_14++)
    var_2[var_14] = undefined;

  return var_2;
}

play_reactive_fx(var_0) {
  var_1 = get_reactive_sound_ent();

  if(!isdefined(var_1)) {
    return;
  }
  self.next_reactive_time = gettime() + 3000;
  var_1.origin = self.v["origin"];
  var_1.is_playing = 1;
  wait(var_0 * randomfloatrange(0.05, 0.1));

  if(common_scripts\utility::issp()) {
    var_1 playsound(self.v["soundalias"], "sounddone");
    var_1 waittill("sounddone");
  } else {
    var_1 playsound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  var_1.is_playing = 0;
}

get_reactive_sound_ent() {
  foreach(var_1 in level._fx.reactive_sound_ents) {
    if(!var_1.is_playing)
      return var_1;
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_1;
    return var_1;
  }

  return undefined;
}