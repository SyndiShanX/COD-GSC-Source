/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1750.gsc
*************************************************/

_id_819D() {
  if(!scripts\engine\utility::_id_0FE2("fx", ::_id_819D)) {
    return;
  }
  scripts\engine\utility::_id_D19F();

  if(_func_03B1()) {
    level._id_3FE3 = [];
  }

  scripts\engine\utility::_id_3F1B("create_triggerfx", ::_id_3F7D);
  thread _id_7F8F();
  _id_CE72();
}

_id_7F8F() {
  if(!isDefined(level._id_0BF2)) {
    level._id_0BF2 = spawnStruct();
  }

  scripts\engine\utility::_id_3F35("createfx_looper", 20);
  level._id_0BF2._id_5B7A = 1;
  level._id_0BF2._id_57CA = _id_06D4::_id_57BC;
  waittillframeend;
  waittillframeend;
  level._id_0BF2._id_57CA = _id_06D4::_id_57BB;
  level._id_0BF2._id_D129 = 0;

  if(getdvarint("#x3fff570c1283682b6") == 1) {
    level._id_0BF2._id_D129 = 1;
  }

  if(level._id_3FD9) {
    level._id_0BF2._id_D129 = 0;
  }

  if(level._id_3FD9) {
    level waittill("createfx_common_done");
  }

  level._id_3FE4 = [];
  var_0 = [];

  foreach(var_2 in level._id_3FE3) {
    var_2 _id_06CE::_id_D216();

    switch (var_2.v["type"]) {
      case "loopfx":
        var_2 thread _id_9838();
        break;
      case "oneshotfx":
        var_2 thread _id_AAD2();
        break;
      case "soundfx":
        var_2 thread _id_3F3A();
        break;
      case "soundfx_interval":
        var_2 thread _id_3F2B();
        break;
      case "reactive_fx":
        var_2 _id_100E();
        break;
    }

    if(isDefined(var_2.v["exploder"])) {
      _id_06CE::_id_0FD6(var_2.v["exploder"], var_2);

      if(isDefined(var_2.v["flag"]) && var_2.v["flag"] != "nil") {
        var_3 = var_0[var_2.v["flag"]];

        if(!isDefined(var_3)) {
          var_3 = [];
        }

        var_3[var_3.size] = var_2.v["exploder"];
        var_0[var_2.v["flag"]] = var_3;
      }
    }
  }

  foreach(var_7, var_6 in var_0) {
    thread _id_06D4::_id_57C1(var_7, var_6);
  }

  _id_3439();
}

_id_C3AD() {}

_id_A980() {}

_id_3439() {}

_id_348A(var_0, var_1) {}

_id_BCFF(var_0, var_1, var_2, var_3) {
  if(getDvar("#x38d6cec2aab7e1513") == "1") {
    return;
  }
}

_id_9836(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::_id_400E(var_0);
  var_7.v["origin"] = var_1;
  var_7.v["angles"] = (0, 0, 0);

  if(isDefined(var_3)) {
    var_7.v["angles"] = vectortoangles(var_3 - var_1);
  }

  var_7.v["delay"] = var_2;
}

_id_3F39() {
  self._id_9834 = _func_019E(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  _id_3F3A();
}

_id_3F3A() {
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
    if(isDefined(self._id_9834)) {
      var_1 = "death";
    } else {
      var_1 = "stop_loop";
    }
  } else if(level._id_0BF2._id_D129 && isDefined(self.v["server_culled"]))
    var_0 = self.v["server_culled"];

  var_2 = self;

  if(isDefined(self._id_9834)) {
    var_2 = self._id_9834;
  }

  var_3 = undefined;

  if(level._id_3FD9) {
    var_3 = self;
  }

  var_2 scripts\engine\utility::_id_9823(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, var_1, var_3);
}

_id_3F2B() {
  self notify("stop_loop");

  if(!isDefined(self.v["soundalias"])) {
    return;
  }
  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_0 = undefined;
  var_1 = self;

  if(isDefined(self.v["stopable"]) && self.v["stopable"] || level._id_3FD9) {
    if(isDefined(self._id_9834)) {
      var_1 = self._id_9834;
      var_0 = "death";
    } else
      var_0 = "stop_loop";
  }

  var_1 thread scripts\engine\utility::_id_9822(self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, undefined, self.v["delay_min"], self.v["delay_max"]);
}

_id_9838() {
  waitframe();

  if(isDefined(self._id_609A)) {
    level waittill("start fx" + self._id_609A);
  }

  for(;;) {
    _id_3F39();

    if(isDefined(self._id_F224)) {
      thread _id_9837(self._id_F224);
    }

    if(isDefined(self._id_609B)) {
      level waittill("stop fx" + self._id_609B);
    } else {
      return;
    }

    if(isDefined(self._id_9834)) {
      self._id_9834 delete();
    }

    if(isDefined(self._id_609A)) {
      level waittill("start fx" + self._id_609A);
      continue;
    }

    return;
  }
}

_id_9837(var_0) {
  self endon("death");
  wait(var_0);
  self._id_9834 delete();
}

_id_72AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_72AC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_72AC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

  if(!level._id_3FD9) {
    var_15 _meth_845D();
  }

  for(;;) {
    var_16 = var_13 + randomint(var_14);

    for(var_17 = 0; var_17 < var_16; var_17++) {
      triggerfx(var_15);
      wait(var_11 + randomfloat(var_12));
    }

    wait(var_9 + randomfloat(var_10));
  }
}

_id_3F7D() {
  if(!_id_103A7(self.v["fxid"])) {
    return;
  }
  self._id_9834 = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self._id_9834, self.v["delay"]);

  if(!level._id_3FD9) {
    self._id_9834 _meth_845D();
  }

  _id_3F3A();
}

_id_103A7(var_0) {
  if(isDefined(level._effect[var_0])) {
    return 1;
  }

  if(!isDefined(level._id_0C65)) {
    level._id_0C65 = [];
  }

  level._id_0C65[self.v["fxid"]] = var_0;
  _id_103A8(var_0);
  return 0;
}

_id_103A8(var_0) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  waitframe();
  var_1 = getarraykeys(level._id_0C65);

  foreach(var_3 in var_1) {}
}

_id_AAD2() {
  waitframe();

  if(self.v["delay"] > 0) {
    wait(self.v["delay"]);
  }

  [[level._id_6016["create_triggerfx"]]]();
}

_id_100E() {
  if(!scripts\common\utility::issp() && getDvar("#x3ae2cde154e196de") == "") {
    return;
  }
  if(!isDefined(level._id_0BF2._id_C096)) {
    level._id_0BF2._id_C096 = 1;
    level thread _id_C094();
  }

  if(!isDefined(level._id_0BF2._id_C093)) {
    level._id_0BF2._id_C093 = [];
  }

  level._id_0BF2._id_C093[level._id_0BF2._id_C093.size] = self;
  self._id_A47A = 3000;
}

_id_C094() {
  if(!scripts\common\utility::issp()) {
    if(getDvar("#x3ae2cde154e196de") == "on") {
      scripts\engine\utility::_id_5C24("createfx_started");
    }
  }

  level._id_0BF2._id_C095 = [];
  var_0 = 256;

  for(;;) {
    level waittill("code_damageradius", var_1, var_0, var_2, var_3, var_4);
    var_5 = _id_E025(var_2, var_0);

    foreach(var_8, var_7 in var_5) {
      var_7 thread _id_B2A9(var_8, var_4);
    }
  }
}

_id_FFD8(var_0) {
  return (var_0[0], var_0[1], 0);
}

_id_E025(var_0, var_1) {
  var_2 = [];
  var_3 = gettime();

  foreach(var_5 in level._id_0BF2._id_C093) {
    if(var_5._id_A47A > var_3) {
      continue;
    }
    var_6 = var_5.v["reactive_radius"] + var_1;
    var_6 = var_6 * var_6;

    if(distancesquared(var_0, var_5.v["origin"]) < var_6) {
      var_2[var_2.size] = var_5;
    }
  }

  foreach(var_5 in var_2) {
    var_9 = _id_FFD8(var_5.v["origin"] - level.player.origin);
    var_10 = _id_FFD8(var_0 - level.player.origin);
    var_11 = vectornormalize(var_9);
    var_12 = vectornormalize(var_10);
    var_5._id_4E80 = vectordot(var_11, var_12);
  }

  for(var_14 = 0; var_14 < var_2.size - 1; var_14++) {
    for(var_15 = var_14 + 1; var_15 < var_2.size; var_15++) {
      if(var_2[var_14]._id_4E80 > var_2[var_15]._id_4E80) {
        var_16 = var_2[var_14];
        var_2[var_14] = var_2[var_15];
        var_2[var_15] = var_16;
      }
    }
  }

  foreach(var_5 in var_2) {
    var_5.origin = undefined;
    var_5._id_4E80 = undefined;
  }

  for(var_14 = 4; var_14 < var_2.size; var_14++) {
    var_2[var_14] = undefined;
  }

  return var_2;
}

_id_B2A9(var_0, var_1) {
  if(self.v["fxid"] != "No FX") {
    playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }
  var_2 = _id_66F3();

  if(!isDefined(var_2)) {
    return;
  }
  self._id_A47A = gettime() + 3000;
  var_2.origin = self.v["origin"];
  var_2._id_8679 = 1;

  if(!isDefined(var_1)) {
    var_1 = 0.0;
  }

  wait(var_0 * randomfloatrange(0.05, 0.1) + var_1);

  if(scripts\common\utility::issp()) {
    var_2 playSound(self.v["soundalias"], "sounddone");
    var_2 waittill("sounddone");
  } else {
    var_2 playSound(self.v["soundalias"]);
    wait 2;
  }

  wait 0.1;
  var_2._id_8679 = 0;
}

_id_66F3() {
  foreach(var_1 in level._id_0BF2._id_C095) {
    if(!var_1._id_8679) {
      return var_1;
    }
  }

  if(level._id_0BF2._id_C095.size < 4) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1._id_8679 = 0;
    level._id_0BF2._id_C095[level._id_0BF2._id_C095.size] = var_1;
    return var_1;
  }

  return undefined;
}

_id_B842(var_0, var_1, var_2, var_3) {
  playFX(var_0, var_1, var_2, var_3);
}

_id_CE72() {
  level._id_EA73 = scripts\engine\utility::getStructArray("struct_fx", "targetname");

  foreach(var_1 in level._id_EA73) {
    if(!scripts\common\utility::issp() || !isDefined(var_1._id_CD64)) {
      _id_B2EB(var_1);
    }
  }
}

_id_B2EB(var_0) {
  if(isDefined(var_0._id_CD65) && isDefined(level._effect[var_0._id_CD65])) {
    if(!isDefined(var_0.angles)) {
      var_0.angles = (0, 0, 0);
    }

    var_0._id_605B = spawnfx(level._effect[var_0._id_CD65], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));

    if(isDefined(var_0._id_CCFD) && isDefined(var_0._id_CCFB)) {
      triggerfx(var_0._id_605B, randomfloat(var_0._id_CCFD, var_0._id_CCFB) / 1000);
    } else if(isDefined(var_0._id_0393)) {
      triggerfx(var_0._id_605B, var_0._id_0393 / 1000);
    } else {
      triggerfx(var_0._id_605B, -0.004);
    }
  }

  if(isDefined(var_0._id_CE4B)) {
    var_0._id_D8F9 = spawn("script_origin", var_0.origin);
    var_0._id_D8F9.angles = var_0.angles;

    if(_func_0207(var_0._id_CE4B)) {
      var_0._id_D8F9 playLoopSound(var_0._id_CE4B);
    } else {
      var_0._id_D8F9 playSound(var_0._id_CE4B);
    }
  }
}

_id_E8E7(var_0) {
  var_0._id_605B delete();

  if(isDefined(var_0._id_D8F9)) {
    var_0._id_D8F9 delete();
  }
}

_id_EA74(var_0) {
  return isDefined(var_0._id_605B);
}

_id_EA75(var_0) {
  return !isDefined(var_0._id_605B);
}

_id_103B9(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
  }

  if(isDefined(var_3._id_532F)) {
    self endon(var_3._id_532F);
  }

  if(!isDefined(var_3._id_295C)) {
    var_3._id_295C = 1;
  }

  if(!isDefined(var_3._id_295E)) {
    var_3._id_295E = -1;
  }

  if(!isDefined(var_3._id_295D)) {
    var_3._id_295D = 1;
  }

  if(!isDefined(var_3._id_295F)) {
    var_3._id_295F = -1;
  }

  if(!isDefined(var_3._id_2960)) {
    var_3._id_2960 = 1;
  }

  if(!isDefined(var_3._id_295B)) {
    var_3._id_295B = -1;
  }

  if(!isDefined(var_3._id_F3C8)) {
    var_3._id_F3C8 = 500;
  }

  if(!isDefined(var_3._id_F3CD)) {
    var_3._id_F3CD = (0, 0, -1);
  } else {
    var_3._id_F3CD = vectornormalize(var_3._id_F3CD);
  }

  var_4 = var_3._id_F3CD * var_3._id_F3C8;

  if(!isDefined(var_3._id_7D4E)) {
    if(isDefined(self._id_04DE)) {
      var_3._id_7D4D = 0.866;
    } else {
      var_3._id_7D4D = 0.5;
    }
  } else
    var_3._id_7D4D = cos(var_3._id_7D4E);

  if(!isDefined(var_3._id_412A)) {
    var_3._id_412A = 1000;
  }

  if(!isDefined(var_3._id_1D7C)) {
    var_3._id_1D7C = 1;
  }

  var_5 = 1 / var_1;
  var_6 = int(max(level._id_5F3A / var_5, 1.0));
  var_5 = level._id_5F3A * int(max(var_5 / level._id_5F3A, 1.0));

  for(;;) {
    if(self _meth_86AA(level.player getEye(), anglesToForward(level.player getplayerangles()), 40, var_3._id_412A)) {
      for(var_8 = 0; var_8 < var_6; var_8++) {
        var_9 = randomfloatrange(var_3._id_295E, var_3._id_295C);
        var_10 = randomfloatrange(var_3._id_295F, var_3._id_295D);
        var_11 = randomfloatrange(var_3._id_295B, var_3._id_2960);
        var_12 = self _meth_8174(var_9, var_10, var_11);
        var_13 = var_12 - var_4;
        var_12 = var_12 + var_4;
        var_14 = scripts\engine\trace::_id_C051(var_13, var_12);
        var_15 = (1, 0, 0);

        if(isDefined(var_14["entity"]) && var_14["entity"] == self) {
          var_16 = vectordot(var_3._id_F3CD, var_14["normal"]) * -1;

          if(var_16 >= var_3._id_7D4D) {
            if(_func_0107(var_0)) {
              var_17 = var_0[randomintrange(0, var_0.size)];
            } else {
              var_17 = var_0;
            }

            thread _id_0DC1(var_17, var_2, var_14["position"], var_14["normal"], var_3._id_1D7C);
            var_15 = (0, 1, 1);
          }
        }
      }
    }

    wait(var_5);
  }
}

_id_0DC1(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self)) {
    return;
  }
  if(!var_4) {
    playFX(scripts\engine\utility::getfx(var_0), var_2, var_3);
    return;
  }

  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5.origin = var_2;
  var_5.angles = vectortoangles(var_3);
  var_5 linkto(self, "tag_origin");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx(var_0), var_5, "tag_origin");
  wait(var_1);
  var_5 delete();
}