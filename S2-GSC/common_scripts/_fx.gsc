/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_fx.gsc
**************************************/

_id_52BD() {
  if(!isDefined(level._id_3F02)) {
    level._id_3F02 = [];
  }

  if(!isDefined(level._id_3F02["create_triggerfx"])) {
    level._id_3F02["create_triggerfx"] = ::create_triggerfx;
  }

  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  common_scripts\utility::_id_27A6("createfx_looper", 20);
  level._id_3F70 = 1;
  level._fx._id_3945 = common_scripts\_exploder::_id_392D;
  waittillframeend;
  waittillframeend;
  level._fx._id_3945 = common_scripts\_exploder::_id_392B;
  level._fx.getmovingplatformparent = 0;

  if(getdvarint("1189") == 1) {
    level._fx.getmovingplatformparent = 1;
  }

  if(level.createfx_enabled) {
    level._fx.getmovingplatformparent = 0;
  }

  if(level.createfx_enabled) {
    level waittill("createfx_common_done");
  }

  level._fx._id_8F32 = [];

  for(var_0 = 0; var_0 < level.createfxent.size; var_0++) {
    var_1 = level.createfxent[var_0];
    var_1 common_scripts\_createfx::set_forward_and_up_vectors();

    switch (var_1.v["type"]) {
      case "loopfx":
        var_1 thread _id_5EF5();
        break;
      case "oneshotfx":
        var_1 thread _id_6B11();
        break;
      case "soundfx":
        var_1 thread create_loopsound();

        if(isDefined(var_1.v["end_notify"]) && !common_scripts\utility::_id_0F79(level._fx._id_8F32, var_1.v["end_notify"])) {
          level._fx._id_8F32[level._fx._id_8F32.size] = var_1.v["end_notify"];
        }

        break;
      case "soundfx_interval":
        var_1 thread create_interval_sound();

        if(isDefined(var_1.v["end_notify"]) && !common_scripts\utility::_id_0F79(level._fx._id_8F32, var_1.v["end_notify"])) {
          level._fx._id_8F32[level._fx._id_8F32.size] = var_1.v["end_notify"];
        }

        break;
      case "reactive_fx":
        var_1 add_reactive_fx();
        break;
      case "soundfx_dynamic":
        var_1 thread create_dynamicambience();
        break;
    }
  }

  thread _id_8F33();
  _id_214C();
  level notify("createfx_initialized");
}

_id_7C81() {}

_id_214C() {}

_id_217A(var_0, var_1) {}

_id_770F(var_0, var_1, var_2, var_3) {
  if(getDvar("debug") == "1") {
    return;
  }
}

_id_7085() {
  if(isDefined(self.v["platform"])) {
    var_0 = self.v["platform"];

    if(var_0 == "ng" && !level._id_010B || var_0 == "pc" && !level._id_0122 || var_0 == "xb3" && !level._id_01D4 || var_0 == "ps4" && !level._id_0148 || var_0 == "!ng" && level._id_010B || var_0 == "!pc" && level._id_0122 || var_0 == "!xb3" && level._id_01D4 || var_0 == "!ps4" && level._id_0148) {
      return 0;
    }
  }

  return 1;
}

_id_6B10(var_0, var_1, var_2, var_3) {}

_id_3946(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17) {
  if(1) {
    var_18 = common_scripts\utility::createexploder(var_1);
    var_18.v["origin"] = var_2;
    var_18.v["angles"] = (0, 0, 0);

    if(isDefined(var_4)) {
      var_18.v["angles"] = vectortoangles(var_4 - var_2);
    }

    var_18.v["delay"] = var_3;
    var_18.v["exploder"] = var_0;

    if(isDefined(level._id_2807)) {
      var_19 = level._id_2807[var_18.v["exploder"]];

      if(!isDefined(var_19)) {
        var_19 = [];
      }

      var_19[var_19.size] = var_18;
      level._id_2807[var_18.v["exploder"]] = var_19;
    }

    return;
  }

  var_20 = spawn("script_origin", (0, 0, 0));
  var_20.origin = var_2;
  var_20.angles = vectortoangles(var_4 - var_2);
  var_20.setdepthoffield = var_0;
  var_20._id_81BB = var_1;
  var_20.script_delay = var_3;
  var_20.getturret = var_5;
  var_20.getgroundenttype = var_6;
  var_20.animcustom = var_7;
  var_20.script_sound = var_8;
  var_20._id_817B = var_9;
  var_20.setanim = var_10;
  var_20.scriptmodelplayanim = var_15;
  var_20.vehicle_getsteering = var_11;
  var_20.isinscriptedstate = var_16;
  var_20.scriptmodelplayanimdeltamotion = var_12;
  var_20._id_8154 = var_13;
  var_20.setbottomarc = var_14;
  var_20.pickupgrenade = var_17;
  var_21 = anglesToForward(var_20.angles);
  var_21 = var_21 * 150;
  var_20._id_9834 = var_2 + var_21;

  if(!isDefined(level._id_06CC)) {
    level._id_06CC = [];
  }

  level._id_06CC[level._id_06CC.size] = var_20;
}

_id_5EEE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = common_scripts\utility::_id_2814(var_0);
  var_7.v["origin"] = var_1;
  var_7.v["angles"] = (0, 0, 0);

  if(isDefined(var_3)) {
    var_7.v["angles"] = vectortoangles(var_3 - var_1);
  }

  var_7.v["delay"] = var_2;
}

create_looper() {
  self.looper = _playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

create_loopsound() {
  if(!_id_7085()) {
    return;
  }
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
  } else if(level._fx.getmovingplatformparent && isDefined(self.v["server_culled"]))
    var_0 = self.v["server_culled"];

  var_2 = self;

  if(isDefined(self.looper)) {
    var_2 = self.looper;
  }

  var_3 = undefined;

  if(level.createfx_enabled) {
    var_3 = self;
  }

  var_2 common_scripts\utility::_id_5EE2(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, var_1, var_3);
}

create_interval_sound() {
  if(!_id_7085()) {
    return;
  }
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_0 = undefined;
  var_1 = self;

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level.createfx_enabled) {
    if(isDefined(self.looper)) {
      var_1 = self.looper;
      var_0 = "death";
    } else
      var_0 = "stop_loop";
  }

  var_1 thread common_scripts\utility::_id_5EE1(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, undefined, self.v["delay_min"], self.v["delay_max"]);
}

create_dynamicambience() {
  if(!_id_7085()) {
    return;
  }
  if(!isDefined(self.v["ambiencename"])) {
    return;
  }
  if(self.v["ambiencename"] == "nil") {
    return;
  }
  if(common_scripts\utility::issp()) {
    return;
  }
  if(getDvar("1459") == "on") {
    common_scripts\utility::_id_3C9F("createfx_started");
  }

  if(isDefined(self._id_29FB)) {
    level.player stopdynamicambience(self._id_29FB._id_A01E);
  }

  self._id_29FB = spawnStruct();
  self._id_29FB common_scripts\utility::_id_10DA();
  level.player playdynamicambience(self.v["ambiencename"], self.v["origin"], self.v["dynamic_distance"], self._id_29FB._id_A01E);
  return;
}

_id_5EF5() {
  waitframe();

  if(isDefined(self._id_3F7E)) {
    level waittill("start fx" + self._id_3F7E);
  }

  for(;;) {
    create_looper();

    if(isDefined(self._id_9A01)) {
      thread _id_5EF4(self._id_9A01);
    }

    if(isDefined(self._id_3F7F)) {
      level waittill("stop fx" + self._id_3F7F);
    } else {
      return;
    }

    if(isDefined(self.looper)) {
      self.looper delete();
    }

    if(isDefined(self._id_3F7E)) {
      level waittill("start fx" + self._id_3F7E);
      continue;
    }

    return;
  }
}

_id_5EF1(var_0) {
  self endon("death");
  var_0 waittill("effect id changed", var_1);
}

_id_5EF2(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("effect org changed", var_1);
    self.origin = var_1;
  }
}

_id_5EF0(var_0) {
  self endon("death");
  var_0 waittill("effect delay changed", var_1);
}

_id_5EF3(var_0) {
  self endon("death");
  var_0 waittill("effect deleted");
  self delete();
}

_id_5EF4(var_0) {
  self endon("death");
  wait(var_0);
  self.looper delete();
}

_id_5F02(var_0, var_1, var_2) {
  level thread _id_5F06(var_0, var_1, var_2);
}

_id_5F06(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);
}

_id_48E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_48E2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_48E2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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
  var_15 = _spawnfx(level._effect[var_0], var_1);

  if(!level.createfx_enabled) {
    var_15 willneverchange();
  }

  for(;;) {
    var_16 = var_13 + randomint(var_14);

    for(var_17 = 0; var_17 < var_16; var_17++) {
      _triggerfx(var_15);
      wait(var_11 + _randomfloat(var_12));
    }

    wait(var_9 + _randomfloat(var_10));
  }
}

_id_48E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread _id_48E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_48E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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
  var_2 = vectorNormalize(var_2 - var_1);
  var_16 = _spawnfx(level._effect[var_0], var_1, var_2);

  if(!level.createfx_enabled) {
    var_16 willneverchange();
  }

  for(;;) {
    var_17 = var_14 + randomint(var_15);

    for(var_18 = 0; var_18 < int(var_17 / level._id_3F70); var_18++) {
      _triggerfx(var_16);
      var_19 = (var_12 + _randomfloat(var_13)) * level._id_3F70;

      if(var_19 < 0.05) {
        var_19 = 0.05;
      }

      wait(var_19);
    }

    wait(var_12 + _randomfloat(var_13));
    wait(var_10 + _randomfloat(var_11));
  }
}

_id_8681(var_0) {
  level._id_3F70 = 1 / var_0;
}

_id_8834() {
  if(!isDefined(self._id_81BB) || !isDefined(self.seerecently) || !isDefined(self.script_delay)) {
    return;
  }
  if(isDefined(self.model)) {
    if(self.model == "toilet") {
      thread _id_1DB1();
      return;
    }
  }

  var_0 = undefined;

  if(isDefined(self.target)) {
    var_1 = _getEnt(self.target, "targetname");

    if(isDefined(var_1)) {
      var_0 = var_1.origin;
    }
  }

  var_2 = undefined;

  if(isDefined(self.lastknowntime)) {
    var_2 = self.lastknowntime;
  }

  var_3 = undefined;

  if(isDefined(self.lastknownpos)) {
    var_3 = self.lastknownpos;
  }

  if(self.seerecently == "OneShotfx") {
    _id_6B10(self._id_81BB, self.origin, self.script_delay, var_0);
  }

  if(self.seerecently == "loopfx") {
    _id_5EEE(self._id_81BB, self.origin, self.script_delay, var_0, var_2, var_3);
  }

  if(self.seerecently == "loopsound") {
    _id_5F02(self._id_81BB, self.origin, self.script_delay);
  }

  self delete();
}

_id_1DB1() {
  var_0 = (0, 0, self.angles[1]);
  var_1 = level._effect[self._id_81BB];
  var_2 = self.origin;
  wait 1;
  level thread _id_1DB2(var_0, var_2, var_1);
  self delete();
}

_id_1DB2(var_0, var_1, var_2) {
  for(;;) {
    playFX(var_2, var_1);
    wait(30 + _randomfloat(40));
  }
}

create_triggerfx() {
  if(!_id_A411(self.v["fxid"])) {
    return;
  }
  self.looper = _spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  _triggerfx(self.looper, self.v["delay"]);

  if(!level.createfx_enabled) {
    self.looper willneverchange();
  }

  create_loopsound();
}

_id_A411(var_0) {
  if(isDefined(level._effect[var_0])) {
    return 1;
  }

  if(!isDefined(level._id_067C)) {
    level._id_067C = [];
  }

  level._id_067C[self.v["fxid"]] = var_0;
  _id_A412(var_0);
  return 0;
}

_id_A412(var_0) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  waitframe();
  var_1 = "";
  var_2 = getarraykeys(level._id_067C);

  foreach(var_4 in var_2) {
    var_1 = var_1 + (var_4 + "\n");
  }
}

_id_6B11() {
  waitframe();

  if(!_id_7085()) {
    return;
  }
  if(self.v["delay"] > 0) {
    wait(self.v["delay"]);
  }

  [[level._id_3F02["create_triggerfx"]]]();
}

add_reactive_fx() {
  if(!_id_7085()) {
    return;
  }
  if(!common_scripts\utility::issp() && getDvar("1459") == "") {
    return;
  }
  if(!isDefined(level._fx._id_7AB0)) {
    level._fx._id_7AB0 = 1;
    level thread _id_7AAE();
  }

  if(!isDefined(level._fx.reactive_fx_ents)) {
    level._fx.reactive_fx_ents = [];
  }

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self._id_66AE = 3000;
}

_id_7AAE() {
  if(!common_scripts\utility::issp()) {
    if(getDvar("1459") == "on") {
      common_scripts\utility::_id_3C9F("createfx_started");
    }
  }

  level._fx._id_7AAF = [];
  var_0 = 256;

  for(;;) {
    level waittill("code_damageradius", var_1, var_0, var_2, var_3);
    var_4 = _id_8F21(var_2, var_0);

    foreach(var_7, var_6 in var_4) {
      var_6 thread _id_718B(var_7);
    }
  }
}

_id_A2B8(var_0) {
  return (var_0[0], var_0[1], 0);
}

_id_8F21(var_0, var_1) {
  var_2 = [];
  var_3 = gettime();

  foreach(var_5 in level._fx.reactive_fx_ents) {
    if(var_5._id_66AE > var_3) {
      continue;
    }
    var_6 = var_5.v["reactive_radius"] + var_1;
    var_6 = var_6 * var_6;

    if(distancesquared(var_0, var_5.v["origin"]) < var_6) {
      var_2[var_2.size] = var_5;
    }
  }

  foreach(var_5 in var_2) {
    var_9 = _id_A2B8(var_5.v["origin"] - level.player.origin);
    var_10 = _id_A2B8(var_0 - level.player.origin);
    var_11 = vectorNormalize(var_9);
    var_12 = vectorNormalize(var_10);
    var_5._id_32B1 = vectordot(var_11, var_12);
  }

  for(var_14 = 0; var_14 < var_2.size - 1; var_14++) {
    for(var_15 = var_14 + 1; var_15 < var_2.size; var_15++) {
      if(var_2[var_14]._id_32B1 > var_2[var_15]._id_32B1) {
        var_16 = var_2[var_14];
        var_2[var_14] = var_2[var_15];
        var_2[var_15] = var_16;
      }
    }
  }

  foreach(var_5 in var_2) {
    var_5.origin = undefined;
    var_5._id_32B1 = undefined;
  }

  for(var_14 = 4; var_14 < var_2.size; var_14++) {
    var_2[var_14] = undefined;
  }

  return var_2;
}

_id_718B(var_0) {
  var_1 = _id_42F0();

  if(!isDefined(var_1)) {
    return;
  }
  self._id_66AE = gettime() + 3000;
  var_1.origin = self.v["origin"];
  var_1.is_playing = 1;
  wait(var_0 * _randomfloatrange(0.05, 0.1));

  if(common_scripts\utility::issp()) {
    var_1 playSound(self.v["soundalias"], "sounddone");
    var_1 waittill("sounddone");
  } else {
    var_1 playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  var_1.is_playing = 0;
}

_id_42F0() {
  foreach(var_1 in level._fx._id_7AAF) {
    if(!var_1.is_playing) {
      return var_1;
    }
  }

  if(level._fx._id_7AAF.size < 4) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1.is_playing = 0;
    level._fx._id_7AAF[level._fx._id_7AAF.size] = var_1;
    return var_1;
  }

  return undefined;
}

_id_8F33() {
  for(;;) {
    var_0 = level common_scripts\utility::_id_A712(level._fx._id_8F32);

    for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
      var_2 = level.createfxent[var_1];

      if(var_2.v["type"] == "soundfx_interval" || var_2.v["type"] == "soundfx") {
        if(isDefined(var_2.v["end_notify"]) && var_2.v["end_notify"] == var_0) {
          var_2 notify("stop_loop");
        }
      }
    }
  }
}