/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\fx.gsc
***********************************************/

initfx() {
  if(!scripts\engine\utility::add_init_script("_encstr_840703F23B", ::initfx)) {
    return;
  }
  scripts\engine\utility::set_createfx_enabled();

  if(isplatformconsole())
    level.createfxent = [];

  scripts\engine\utility::create_func_ref("_encstr_AD22116CC9AC0BE8B27D8EE4B47676569C990F", ::create_triggerfx);
  thread init_fx_thread();
  script_struct_fx_init();
}

init_fx_thread() {
  if(!isDefined(level._fx))
    level._fx = spawnStruct();

  scripts\engine\utility::create_lock("_encstr_AF76100B3E592BEBB73A537044F018F88D02", 20);
  level._fx.fireloopmod = 1;
  level._fx.exploderfunction = scripts\common\exploder::exploder_before_load;
  waittillframeend;
  waittillframeend;
  level._fx.exploderfunction = scripts\common\exploder::exploder_after_load;
  level._fx.server_culled_sounds = 0;

  if(getdvarint("_encstr_A9080B558F61CA1F822721394F") == 1)
    level._fx.server_culled_sounds = 1;

  if(level.createfx_enabled)
    level._fx.server_culled_sounds = 0;

  if(level.createfx_enabled)
    level waittill("_encstr_A1B815C22301C210705918EF66C8A3BF2D78275D6F6257");

  level.createfxexploders = [];
  var_0 = [];

  foreach(var_2 in level.createfxent) {
    var_2 scripts\common\createfx::set_forward_and_up_vectors();

    switch (var_2.v["_encstr_81EF05D197C12B"]) {
      case "_encstr_BE7F073BF060E0F269":
        var_2 thread loopfxthread();
        break;
      case "_encstr_B6480A92880DD02267293B7B":
        var_2 thread oneshotfxthread();
        break;
      case "_encstr_A35408BE67DFC0D98F9B":
        var_2 thread create_loopsound();
        break;
      case "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1":
        var_2 thread create_interval_sound();
        break;
      case "_encstr_82510C0E3347CF308B935DA7A8D8":
        var_2 add_reactive_fx();
        break;
    }

    if(isDefined(var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"])) {
      scripts\common\createfx::add_exploder(var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"], var_2);

      if(isDefined(var_2.v["_encstr_8F7905C4EDE23F"]) && var_2.v["_encstr_8F7905C4EDE23F"] != "_encstr_BA19049E7739") {
        var_3 = var_0[var_2.v["_encstr_8F7905C4EDE23F"]];

        if(!isDefined(var_3))
          var_3 = [];

        var_3[var_3.size] = var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"];
        var_0[var_2.v["_encstr_8F7905C4EDE23F"]] = var_3;
      }
    }
  }

  foreach(var_7, var_6 in var_0)
  thread scripts\common\exploder::exploder_flag_wait(var_7, var_6);

  check_createfx_limit();
}

remove_dupes() {}

offset_fix() {}

check_createfx_limit() {}

check_limit_type(var_0, var_1) {}

print_org(var_0, var_1, var_2, var_3) {
  if(getDvar("_encstr_8E75065022EE9391") == "_encstr_A34C02BB")
    return;
}

loopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::createloopeffect(var_0);
  var_7.v["_encstr_97FE07DE392D76D2CD"] = var_1;
  var_7.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);

  if(isDefined(var_3))
    var_7.v["_encstr_A7610758E6CED8569B"] = vectortoangles(var_3 - var_1);

  var_7.v["_encstr_96750613A808E91B"] = var_2;
}

create_looper() {
  self.looper = playloopedfx(level._effect[self.v["_encstr_95780526F31FA7"]], self.v["_encstr_96750613A808E91B"], self.v["_encstr_97FE07DE392D76D2CD"], 0, self.v["_encstr_B42E085325A82CB3F221"], self.v["_encstr_87070365F7"]);
  create_loopsound();
}

create_loopsound() {
  self notify("_encstr_8B2D0AD00B95B1BEEB0FD057");

  if(!isDefined(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"])) {
    return;
  }
  if(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] == "_encstr_BA19049E7739") {
    return;
  }
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.v["_encstr_9B89096E1DDBE016981BAC"]) && self.v["_encstr_9B89096E1DDBE016981BAC"]) {
    if(isDefined(self.looper))
      var_1 = "_encstr_AD75063D571AE108";
    else
      var_1 = "_encstr_8B2D0AD00B95B1BEEB0FD057";
  } else if(level._fx.server_culled_sounds && isDefined(self.v["_encstr_8F9F0EC3D815737FAB70BBA5F13027BF"]))
    var_0 = self.v["_encstr_8F9F0EC3D815737FAB70BBA5F13027BF"];

  var_2 = self;

  if(isDefined(self.looper))
    var_2 = self.looper;

  var_3 = undefined;

  if(level.createfx_enabled)
    var_3 = self;

  var_2 scripts\engine\utility::loop_fx_sound_with_angles(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"], self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_A7610758E6CED8569B"], var_0, var_1, var_3);
}

create_interval_sound() {
  self notify("_encstr_8B2D0AD00B95B1BEEB0FD057");

  if(!isDefined(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"])) {
    return;
  }
  if(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] == "_encstr_BA19049E7739") {
    return;
  }
  var_0 = undefined;
  var_1 = self;

  if(isDefined(self.v["_encstr_9B89096E1DDBE016981BAC"]) && self.v["_encstr_9B89096E1DDBE016981BAC"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      var_1 = self.looper;
      var_0 = "_encstr_AD75063D571AE108";
    } else
      var_0 = "_encstr_8B2D0AD00B95B1BEEB0FD057";
  }

  var_1 thread scripts\engine\utility::loop_fx_sound_interval_with_angles(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"], self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_A7610758E6CED8569B"], var_0, undefined, self.v["_encstr_AB9A0AC80DCBE9A137FDD988"], self.v["_encstr_A59A0AB1672C48FBB9E79B91"]);
}

loopfxthread() {
  waitframe();

  if(isDefined(self.fxstart))
    level waittill("_encstr_83B009037311E04D7E1B79" + self.fxstart);

  for(;;) {
    create_looper();

    if(isDefined(self.timeout))
      thread loopfxstop(self.timeout);

    if(isDefined(self.fxstop))
      level waittill("_encstr_AD7A0843335FB0275AA3" + self.fxstop);
    else
      return;

    if(isDefined(self.looper))
      self.looper delete();

    if(isDefined(self.fxstart)) {
      level waittill("_encstr_83B009037311E04D7E1B79" + self.fxstart);
      continue;
    }

    return;
  }
}

loopfxstop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  self.looper delete();
}

gunfireloopfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

gunfireloopfxthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_8B4417FB437813DED03984D037A89583937B129288C04B0770");
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

  for(;;) {
    var_16 = var_13 + randomint(var_14);

    for(var_17 = 0; var_17 < var_16; var_17++) {
      triggerfx(var_15);
      wait(var_11 + randomfloat(var_12));
    }

    wait(var_9 + randomfloat(var_10));
  }
}

create_triggerfx() {
  if(!verify_effects_assignment(self.v["_encstr_95780526F31FA7"])) {
    return;
  }
  self.looper = spawnfx(level._effect[self.v["_encstr_95780526F31FA7"]], self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_B42E085325A82CB3F221"], self.v["_encstr_87070365F7"]);
  triggerfx(self.looper, self.v["_encstr_96750613A808E91B"]);

  if(!level.createfx_enabled)
    self.looper willneverchange();

  create_loopsound();
}

verify_effects_assignment(var_0) {
  if(isDefined(level._effect[var_0]))
    return 1;

  if(!isDefined(level._missing_fx))
    level._missing_fx = [];

  level._missing_fx[self.v["_encstr_95780526F31FA7"]] = var_0;
  verify_effects_assignment_print(var_0);
  return 0;
}

verify_effects_assignment_print(var_0) {
  level notify("_encstr_9B0A20D92BC95A33BCBE5999CC95C6479BD785CDB9D2D99BADCAE6E8D71CE4B4373A");
  level endon("_encstr_9B0A20D92BC95A33BCBE5999CC95C6479BD785CDB9D2D99BADCAE6E8D71CE4B4373A");
  waitframe();
  var_1 = getarraykeys(level._missing_fx);

  foreach(var_3 in var_1) {}
}

oneshotfxthread() {
  waitframe();

  if(self.v["_encstr_96750613A808E91B"] > 0)
    wait(self.v["_encstr_96750613A808E91B"]);

  [[level.func["_encstr_AD22116CC9AC0BE8B27D8EE4B47676569C990F"]]]();
}

add_reactive_fx() {
  if(!scripts\common\utility::issp() && getDvar("_encstr_A7A10BE87FB447783F6F314482") == "_encstr_B40101") {
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
    if(getDvar("_encstr_A7A10BE87FB447783F6F314482") == "_encstr_AB0703DBB9")
      scripts\engine\utility::flag_wait("_encstr_82B111B335F88E0B6D296B01933D978288F32C");
  }

  level._fx.reactive_sound_ents = [];
  var_0 = 256;

  for(;;) {
    level waittill("_encstr_AFB012367B8CACBEC8C26BB03B95C9C23296AEDC", var_1, var_0, var_2, var_3, var_4);
    var_5 = sort_reactive_ents(var_2, var_0);

    foreach(var_8, var_7 in var_5)
    var_7 thread play_reactive_fx(var_8, var_4);
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
    var_6 = var_5.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"] + var_1;
    var_6 = var_6 * var_6;

    if(distancesquared(var_0, var_5.v["_encstr_97FE07DE392D76D2CD"]) < var_6)
      var_2[var_2.size] = var_5;
  }

  foreach(var_5 in var_2) {
    var_9 = vector2d(var_5.v["_encstr_97FE07DE392D76D2CD"] - level.player.origin);
    var_10 = vector2d(var_0 - level.player.origin);
    var_11 = vectorNormalize(var_9);
    var_12 = vectorNormalize(var_10);
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

  foreach(var_5 in var_2) {
    var_5.origin = undefined;
    var_5.dot = undefined;
  }

  for(var_14 = 4; var_14 < var_2.size; var_14++)
    var_2[var_14] = undefined;

  return var_2;
}

play_reactive_fx(var_0, var_1) {
  if(self.v["_encstr_95780526F31FA7"] != "_encstr_A67306780FE2ADD9")
    playFX(level._effect[self.v["_encstr_95780526F31FA7"]], self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_B42E085325A82CB3F221"], self.v["_encstr_87070365F7"]);

  if(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] == "_encstr_BA19049E7739") {
    return;
  }
  var_2 = get_reactive_sound_ent();

  if(!isDefined(var_2)) {
    return;
  }
  self.next_reactive_time = gettime() + 3000;
  var_2.origin = self.v["_encstr_97FE07DE392D76D2CD"];
  var_2.is_playing = 1;

  if(!isDefined(var_1))
    var_1 = 0.0;

  wait(var_0 * randomfloatrange(0.05, 0.1) + var_1);

  if(scripts\common\utility::issp()) {
    var_2 playSound(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"], "_encstr_95C70A37B8E87540AD27CEA1");
    var_2 waittill("_encstr_95C70A37B8E87540AD27CEA1");
  } else {
    var_2 playSound(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]);
    wait 2;
  }

  wait 0.1;
  var_2.is_playing = 0;
}

get_reactive_sound_ent() {
  foreach(var_1 in level._fx.reactive_sound_ents) {
    if(!var_1.is_playing)
      return var_1;
  }

  if(level._fx.reactive_sound_ents.size < 4) {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_1.is_playing = 0;
    level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_1;
    return var_1;
  }

  return undefined;
}

playfxnophase(var_0, var_1, var_2, var_3) {
  playFX(var_0, var_1, var_2, var_3);
}

script_struct_fx_init() {
  level.struct_fx = scripts\engine\utility::getStructArray("_encstr_BA980A0F75403511EC21D023", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.struct_fx) {
    if(!scripts\common\utility::issp() || !isDefined(var_1.script_fxgroup))
      play_struct_fx(var_1);
  }
}

play_struct_fx(var_0) {
  if(isDefined(var_0.script_fxid) && isDefined(level._effect[var_0.script_fxid])) {
    if(!isDefined(var_0.angles))
      var_0.angles = (0, 0, 0);

    var_0.fx = spawnfx(level._effect[var_0.script_fxid], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));

    if(isDefined(var_0.script_delay_min) && isDefined(var_0.script_delay_max))
      triggerfx(var_0.fx, randomfloat(var_0.script_delay_min, var_0.script_delay_max) / 1000);
    else if(isDefined(var_0.script_delay))
      triggerfx(var_0.fx, var_0.script_delay / 1000);
    else
      triggerfx(var_0.fx, -0.004);
  }

  if(isDefined(var_0.script_soundalias)) {
    var_0.sfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
    var_0.sfx.angles = var_0.angles;

    if(soundislooping(var_0.script_soundalias))
      var_0.sfx playLoopSound(var_0.script_soundalias);
    else
      var_0.sfx playSound(var_0.script_soundalias);
  }
}

stop_struct_fx(var_0) {
  var_0.fx delete();

  if(isDefined(var_0.sfx))
    var_0.sfx delete();
}

struct_fx_active(var_0) {
  return isDefined(var_0.fx);
}

struct_fx_inactive(var_0) {
  return !isDefined(var_0.fx);
}