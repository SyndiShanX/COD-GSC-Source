/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\fx.gsc
***********************************************/

#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace fx;

function initfx() {
  if(!add_init_script("fx", &initfx)) {
    return;
  }

  set_createfx_enabled();

  if(havemapentseffects()) {
    level.createfxent = [];
  }

  create_func_ref("create_triggerfx", &create_triggerfx);
  thread init_fx_thread();
  script_struct_fx_init();
}

function init_fx_thread() {
  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  create_lock("createfx_looper", 20);
  level._fx.fireloopmod = 1;
  level._fx.exploderfunction = &scripts\common\exploder::exploder_before_load;
  waittillframeend();
  waittillframeend();
  level._fx.exploderfunction = &scripts\common\exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;

  if(getdvarint(@ "hash_7ebee7a942eed3c8") == 1) {
    level._fx.server_culled_sounds = 1;
  }

  if(level.createfx_enabled) {
    level._fx.server_culled_sounds = 0;
  }

  setdevdvarifuninitialized(@ "hash_85b139dc623fa880", 0);
  setdevdvarifuninitialized(@ "hash_66ba26fa32261de", 0);
  setdevdvarifuninitialized(@ "createfx_offset", 0);

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    level._fx.server_culled_sounds = 1;
  }

  if(level.createfx_enabled) {
    level waittill("createfx_common_done");
  }

  level.createfxexploders = [];
  var_4c5056380ab96e2d = [];

  remove_dupes();
  offset_fix();

  foreach(ent in level.createfxent) {
    ent set_forward_and_up_vectors();

    switch (ent.v["type"]) {
      case #"hash_1ac9f75b98e637fd":
        ent thread loopfxthread();
        break;
      case #"hash_16b43f355b98c009":
        ent thread oneshotfxthread();
        break;
      case #"hash_fbc4edc91b6c146a":
        ent thread create_loopsound();
        break;
      case #"hash_c9ec51ce0335258e":
        ent thread create_interval_sound();
        break;
      case #"hash_46a741fcf24ab59":
        ent add_reactive_fx();
        break;
    }

    if(isDefined(ent.v["exploder"])) {
      add_exploder(ent.v["exploder"], ent);

      if(isDefined(ent.v["flag"]) && ent.v["flag"] != "nil") {
        temp = var_4c5056380ab96e2d[ent.v["flag"]];

        if(!isDefined(temp)) {
          temp = [];
        }

        temp[temp.size] = ent.v["exploder"];
        var_4c5056380ab96e2d[ent.v["flag"]] = temp;
      }
    }
  }

  foreach(msg, exploderarray in var_4c5056380ab96e2d) {
    thread scripts\common\exploder::exploder_flag_wait(msg, exploderarray);
  }

  check_createfx_limit();
}

function remove_dupes() {
  if(getdvarint(@ "hash_66ba26fa32261de") == 0) {
    return;
  }

  new_ents = [];

  for(i = 0; i < level.createfxent.size; i++) {
    add_ent = 1;
    i_ent = level.createfxent[i];

    for(j = i + 1; j < level.createfxent.size; j++) {
      j_ent = level.createfxent[j];

      if(j_ent.v["<dev string:x1c>"] == i_ent.v["<dev string:x1c>"]) {
        if(j_ent.v["<dev string:x24>"] == i_ent.v["<dev string:x24>"]) {
          println("<dev string:x2e>" + j_ent.v["<dev string:x1c>"] + "<dev string:x46>" + j_ent.v["<dev string:x24>"]);
          add_ent = 0;
        }
      }
    }

    if(add_ent) {
      new_ents[new_ents.size] = i_ent;
    }
  }

  level.createfxent = new_ents;
}

function offset_fix() {
  if(getDvar(@ "createfx_offset") == "<dev string:x4e>") {
    return;
  }

  dvar = getDvar(@ "createfx_offset");
  toks = strtok(dvar, "<dev string:x52>");

  if(toks.size != 3) {
    return;
  }

  offset = (int(toks[0]), int(toks[1]), int(toks[2]));
  new_ents = [];

  foreach(ent in level.createfxent) {
    ent.v["<dev string:x24>"] = ent.v["<dev string:x24>"] + offset;
  }

  setDvar(@ "createfx_offset", "<dev string:x4e>");
  iprintlnbold("<dev string:x57>");
}

function check_createfx_limit() {
  if(!issp()) {
    return;
  }

  fx_count = 0;
  sound_count = 0;

  foreach(ent in level.createfxent) {
    if(is_createfx_type(ent, "<dev string:x86>")) {
      fx_count++;
      continue;
    }

    if(is_createfx_type(ent, "<dev string:x8c>")) {
      sound_count++;
    }
  }

  println("<dev string:x95>" + fx_count);
  println("<dev string:xb3>" + sound_count);
  check_limit_type("<dev string:x86>", fx_count);
  check_limit_type("<dev string:x8c>", sound_count);
}

function check_limit_type(type, count) {
  limit = undefined;

  if(type == "<dev string:x86>") {
    limit = 1750;
  } else if(type == "<dev string:x8c>") {
    limit = 384;
  }

  if(count > limit) {
    assertmsg("<dev string:xd4>" + type + "<dev string:xf4>" + count + "<dev string:x130>" + limit);
  }
}

function print_org(fxcommand, fxid, fxpos, waittime) {
  if(getDvar(@ "debug") == "1") {
    println("<dev string:x146>");
    println("<dev string:x14b>" + fxpos[0] + "<dev string:x52>" + fxpos[1] + "<dev string:x52>" + fxpos[2] + "<dev string:x159>");
    println("<dev string:x15e>");
    println("<dev string:x17c>");
    println("<dev string:x18c>" + fxcommand + "<dev string:x159>");
    println("<dev string:x1a4>" + fxid + "<dev string:x159>");
    println("<dev string:x1b7>" + waittime + "<dev string:x159>");
    println("<dev string:x1cb>");
  }
}

function loopfx(fxid, fxpos, waittime, fxpos2, fxstart, fxstop, timeout) {
  println("<dev string:x1d0>");
  ent = createloopeffect(fxid);
  ent.v["origin"] = fxpos;
  ent.v["angles"] = (0, 0, 0);

  if(isDefined(fxpos2)) {
    ent.v["angles"] = vectortoangles(fxpos2 - fxpos);
  }

  ent.v["delay"] = waittime;
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

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "<dev string:x1e9>") {
    return;
  }

  culled = 0;
  end_on = undefined;

  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper)) {
      end_on = "death";
    } else {
      end_on = "stop_loop";
    }
  } else if(level._fx.server_culled_sounds && isDefined(self.v["server_culled"])) {
    culled = self.v["server_culled"];
  }

  ent = self;

  if(isDefined(self.looper)) {
    ent = self.looper;
  }

  createfx_ent = undefined;

  if(level.createfx_enabled) {
    createfx_ent = self;
  }

  ent loop_fx_sound_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], culled, end_on, createfx_ent);
}

function create_interval_sound() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  ender = undefined;
  runner = self;

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "<dev string:x1e9>") {
    return;
  }

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      runner = self.looper;
      ender = "death";
    } else {
      ender = "stop_loop";
    }
  }

  runner thread loop_fx_sound_interval_with_angles(self.v["soundalias"], self.v["origin"], self.v["angles"], ender, undefined, self.v["delay_min"], self.v["delay_max"]);
}

function loopfxthread() {
  waitframe();

  if(isDefined(self.fxstart)) {
    level waittill("start fx" + self.fxstart);
  }

  while(true) {
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

function loopfxstop(timeout) {
  self endon("death");
  wait timeout;
  self.looper delete();
}

function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

function gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  level endon("stop all gunfireloopfx");
  waitframe();

  if(betweensetsmax < betweensetsmin) {
    temp = betweensetsmax;
    betweensetsmax = betweensetsmin;
    betweensetsmin = temp;
  }

  betweensetsbase = betweensetsmin;
  betweensetsrange = betweensetsmax - betweensetsmin;

  if(shotdelaymax < shotdelaymin) {
    temp = shotdelaymax;
    shotdelaymax = shotdelaymin;
    shotdelaymin = temp;
  }

  shotdelaybase = shotdelaymin;
  shotdelayrange = shotdelaymax - shotdelaymin;

  if(shotsmax < shotsmin) {
    temp = shotsmax;
    shotsmax = shotsmin;
    shotsmin = temp;
  }

  shotsbase = shotsmin;
  shotsrange = shotsmax - shotsmin;
  fxent = spawnfx(level._effect[fxid], fxpos);

  if(!level.createfx_enabled) {
    fxent willneverchange();
  }

  for(;;) {
    shotnum = shotsbase + randomint(shotsrange);

    for(i = 0; i < shotnum; i++) {
      triggerfx(fxent);
      wait shotdelaybase + randomfloat(shotdelayrange);
    }

    wait betweensetsbase + randomfloat(betweensetsrange);
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

function verify_effects_assignment(effectid) {
  if(isDefined(level._effect[effectid])) {
    return true;
  }

  if(!isDefined(level._missing_fx)) {
    level._missing_fx = [];
  }

  level._missing_fx[self.v["fxid"]] = effectid;
  verify_effects_assignment_print(effectid);
  return false;
}

function verify_effects_assignment_print(effectid) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  waitframe();

  println("<dev string:x1ee>");
  println("<dev string:x1f8>");
  keys = getarraykeys(level._missing_fx);

  foreach(key in keys) {
    println("<dev string:x229>" + key);
  }

  println("<dev string:x1ee>");

  assertmsg("<dev string:x257>");
}

function oneshotfxthread() {
  waitframe();

  if(self.v["delay"] > 0) {
    wait self.v["delay"];
  }

  [[level.func["create_triggerfx"]]]();
}

function add_reactive_fx() {
  if(!issp() && getDvar(@ "createfx") == "") {
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

function reactive_fx_thread() {
  if(!issp()) {
    if(getDvar(@ "createfx") == "on") {
      flag_wait("createfx_started");
    }
  }

  level._fx.reactive_sound_ents = [];
  explosion_radius = 256;

  while(true) {
    level waittill("code_damageradius", attacker, explosion_radius, point, objweapon, delay);
    ents = sort_reactive_ents(point, explosion_radius);

    foreach(i, ent in ents) {
      ent thread play_reactive_fx(i, delay);
    }
  }
}

function vector2d(vec) {
  return (vec[0], vec[1], 0);
}

function sort_reactive_ents(point, explosion_radius) {
  closest = [];
  time = gettime();

  foreach(ent in level._fx.reactive_fx_ents) {
    if(ent.next_reactive_time > time) {
      continue;
    }

    radius_squared = ent.v["reactive_radius"] + explosion_radius;
    radius_squared *= radius_squared;

    if(distancesquared(point, ent.v["origin"]) < radius_squared) {
      closest[closest.size] = ent;
    }
  }

  foreach(ent in closest) {
    var_af1392a218a7888a = vector2d(ent.v["origin"] - level.player.origin);
    playertopoint = vector2d(point - level.player.origin);
    vec1 = vectorNormalize(var_af1392a218a7888a);
    vec2 = vectorNormalize(playertopoint);
    ent.dot = vectordot(vec1, vec2);
  }

  for(i = 0; i < closest.size - 1; i++) {
    for(j = i + 1; j < closest.size; j++) {
      if(closest[i].dot > closest[j].dot) {
        temp = closest[i];
        closest[i] = closest[j];
        closest[j] = temp;
      }
    }
  }

  foreach(ent in closest) {
    ent.origin = undefined;
    ent.dot = undefined;
  }

  for(i = 4; i < closest.size; i++) {
    closest[i] = undefined;
  }

  return closest;
}

function play_reactive_fx(num, delay) {
  assertex(self.v["<dev string:x289>"] != "<dev string:x291>" || self.v["<dev string:x29a>"] != "<dev string:x2a8>", "<dev string:x2af>" + self.v["<dev string:x24>"] + "<dev string:x2c2>");

  if(self.v["fxid"] != "No FX") {
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  sound_ent = get_reactive_sound_ent();

  if(!isDefined(sound_ent)) {
    return;
  }

  self.is_playing = 1;

  self.next_reactive_time = gettime() + 3000;
  sound_ent.origin = self.v["origin"];
  sound_ent.is_playing = 1;

  if(!isDefined(delay)) {
    delay = 0;
  }

  wait num * randomfloatrange(0.05, 0.1) + delay;

  if(utility::issp()) {
    sound_ent playSound(self.v["soundalias"], "sounddone");
    sound_ent waittill("sounddone");
  } else {
    sound_ent playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  sound_ent.is_playing = 0;

  self.is_playing = undefined;
}

function get_reactive_sound_ent() {
  foreach(ent in level._fx.reactive_sound_ents) {
    if(!ent.is_playing) {
      return ent;
    }
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    ent = spawn("script_origin", (0, 0, 0));
    ent.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = ent;
    return ent;
  }

  return undefined;
}

function playfxnophase(fx, location, forwarddir, updir) {
  playFX(fx, location, forwarddir, updir);
}

function script_struct_fx_init() {
  level.struct_fx = getStructArray("struct_fx", "targetname");

  foreach(struct in level.struct_fx) {
    if(!issp() || !isDefined(struct.script_fxgroup)) {
      play_struct_fx(struct);
    }
  }
}

function play_struct_fx(struct) {
  if(isDefined(struct.script_fxid) && isDefined(level._effect[struct.script_fxid])) {
    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    struct.fx = spawnfx(level._effect[struct.script_fxid], struct.origin, anglesToForward(struct.angles), anglestoup(struct.angles));

    if(isDefined(struct.script_delay_min) && isDefined(struct.script_delay_max)) {
      assertex(struct.script_delay_min <= struct.script_delay_max, "<dev string:x2f9>" + struct.origin + "<dev string:x311>");
      triggerfx(struct.fx, randomfloat(struct.script_delay_min, struct.script_delay_max) / 1000);
    } else if(isDefined(struct.script_delay)) {
      triggerfx(struct.fx, struct.script_delay / 1000);
    } else {
      triggerfx(struct.fx, -0.004);
    }
  }

  if(isDefined(struct.script_soundalias)) {
    struct.sfx = spawn("script_origin", struct.origin);
    struct.sfx.angles = struct.angles;

    if(soundislooping(struct.script_soundalias)) {
      struct.sfx playLoopSound(struct.script_soundalias);
      return;
    }

    struct.sfx playSound(struct.script_soundalias);
  }
}

function stop_struct_fx(struct) {
  struct.fx delete();

  if(isDefined(struct.sfx)) {
    struct.sfx delete();
  }
}

function struct_fx_active(struct) {
  return isDefined(struct.fx);
}

function struct_fx_inactive(struct) {
  return !isDefined(struct.fx);
}