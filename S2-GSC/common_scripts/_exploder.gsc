/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_exploder.gsc
****************************************/

_id_44D1(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807))
    return level._id_2807[var_0];

  var_1 = [];

  foreach(var_3 in level.createfxent) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(var_3.v["exploder"])) {
      continue;
    }
    if(var_3.v["exploder"] == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_885C(var_0) {
  var_1 = var_0._id_8186;

  if(!isDefined(level._id_3948[var_1]))
    level._id_3948[var_1] = [];

  var_2 = var_0.targetname;

  if(!isDefined(var_2))
    var_2 = "";

  level._id_3948[var_1][level._id_3948[var_1].size] = var_0;

  if(_id_393B(var_0)) {
    var_0 _meth_805C();
    return;
  }

  if(_id_393A(var_0)) {
    var_0 _meth_805C();
    var_0 _meth_82C2();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0._id_8166))
        var_0 _meth_8060();
    }

    return;
  }

  if(_id_3939(var_0)) {
    var_0 _meth_805C();
    var_0 _meth_82C2();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1)
      var_0 _meth_8060();

    return;
  }
}

_id_8A1A() {
  level._id_3948 = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_8272))
      var_4._id_8186 = var_4._id_8272;

    if(isDefined(var_4._id_6019)) {
      continue;
    }
    if(isDefined(var_4._id_8186))
      _id_885C(var_4);
  }

  var_6 = [];
  var_7 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2]._id_8272))
      var_7[var_2]._id_8186 = var_7[var_2]._id_8272;

    if(isDefined(var_7[var_2]._id_8186))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2]._id_8272))
      var_7[var_2]._id_8186 = var_7[var_2]._id_8272;

    if(isDefined(var_7[var_2]._id_8186))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getEntArray("script_origin", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2]._id_8272))
      var_7[var_2]._id_8186 = var_7[var_2]._id_8272;

    if(isDefined(var_7[var_2]._id_8186))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2]._id_8272))
      var_7[var_2]._id_8186 = var_7[var_2]._id_8272;

    if(isDefined(var_7[var_2]._id_8186))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = level.struct;

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(!isDefined(var_7[var_2])) {
      continue;
    }
    if(isDefined(var_7[var_2]._id_8272))
      var_7[var_2]._id_8186 = var_7[var_2]._id_8272;

    if(isDefined(var_7[var_2]._id_8186)) {
      if(!isDefined(var_7[var_2].angles))
        var_7[var_2].angles = (0, 0, 0);

      var_6[var_6.size] = var_7[var_2];
    }
  }

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread _id_8825();

  for(var_2 = 0; var_2 < var_6.size; var_2++) {
    var_9 = var_6[var_2];
    var_4 = common_scripts\utility::createexploder(var_9._id_81BB);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9._id_8155;
    var_4.v["firefx"] = var_9._id_8193;
    var_4.v["firefxdelay"] = var_9._id_8194;
    var_4.v["firefxsound"] = var_9._id_8195;
    var_4.v["firefxtimeout"] = var_9._id_8196;
    var_4.v["earthquake"] = var_9._id_817B;
    var_4.v["rumble"] = var_9._id_827D;
    var_4.v["damage"] = var_9._id_8146;
    var_4.v["damage_radius"] = var_9._id_8276;
    var_4.v["soundalias"] = var_9._id_828B;
    var_4.v["repeat"] = var_9._id_8278;
    var_4.v["delay_min"] = var_9._id_8154;
    var_4.v["delay_max"] = var_9._id_8153;
    var_4.v["target"] = var_9.target;
    var_4.v["ender"] = var_9._id_817E;
    var_4.v["physics"] = var_9._id_8269;
    var_4.v["type"] = "exploder";

    if(!isDefined(var_9._id_81BB))
      var_4.v["fxid"] = "No FX";
    else
      var_4.v["fxid"] = var_9._id_81BB;

    var_4.v["exploder"] = var_9._id_8186;

    if(isDefined(level._id_2807)) {
      var_10 = level._id_2807[var_4.v["exploder"]];

      if(!isDefined(var_10))
        var_10 = [];

      var_10[var_10.size] = var_4;
      level._id_2807[var_4.v["exploder"]] = var_10;
    }

    if(!isDefined(var_4.v["delay"]))
      var_4.v["delay"] = 0;

    if(isDefined(var_9.target)) {
      var_11 = getEntArray(var_4.v["target"], "targetname")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = common_scripts\utility::_id_4375(var_4.v["target"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isDefined(var_9._id_003B)) {
      var_4.model = var_9;

      if(isDefined(var_4.model._id_8205))
        precachemodel(var_4.model._id_8205);
    } else if(var_9._id_003B == "script_brushmodel" || isDefined(var_9.model)) {
      var_4.model = var_9;
      var_4.model._id_2FBF = var_9._id_8166;
    }

    if(isDefined(var_9.targetname) && isDefined(var_8[var_9.targetname]))
      var_4.v["exploder_type"] = var_9.targetname;
    else
      var_4.v["exploder_type"] = "normal";

    if(isDefined(var_9._id_6019)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9._id_8166;
      var_9 delete();
    }

    var_4 common_scripts\_createfx::post_entity_creation_function();
  }
}

_id_8825() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_0 = [];

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == "nil")
      var_2.v["flag"] = undefined;

    var_0[var_3] = 1;
  }

  foreach(var_7, var_6 in var_0)
  thread _id_3933(var_7);
}

_id_3933(var_0) {
  if(!common_scripts\utility::_id_3C83(var_0))
    common_scripts\utility::flag_init(var_0);

  common_scripts\utility::_id_3C9F(var_0);

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      continue;
    }
    var_2 common_scripts\utility::activate_individual_exploder();
  }
}

_id_393A(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploder";
}

_id_393B(var_0) {
  return var_0.model == "fx" && (!isDefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

_id_3939(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

_id_8BCA(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!_id_393B(var_3.model) && !_id_393A(var_3.model) && !_id_3939(var_3.model))
          var_3.model _meth_805B();

        if(isDefined(var_3._id_1CB4))
          var_3.model _meth_805B();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        if(!_id_393B(var_3.model) && !_id_393A(var_3.model) && !_id_3939(var_3.model))
          var_3.model _meth_805B();

        if(isDefined(var_3._id_1CB4))
          var_3.model _meth_805B();
      }
    }
  }
}

_id_93C8(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3.looper)) {
          continue;
        }
        var_3.looper delete();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!isDefined(var_3.looper)) {
        continue;
      }
      var_3.looper delete();
    }
  }
}

_id_417F(var_0) {
  var_0 = var_0 + "";
  var_1 = [];

  if(isDefined(level._id_2807)) {
    var_2 = level._id_2807[var_0];

    if(isDefined(var_2))
      var_1 = var_2;
  } else {
    foreach(var_4 in level.createfxent) {
      if(var_4.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_4.v["exploder"])) {
        continue;
      }
      if(var_4.v["exploder"] + "" != var_0) {
        continue;
      }
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

_id_4CE3(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model))
          var_3.model _meth_805C();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model))
        var_3.model _meth_805C();
    }
  }
}

_id_2D0D(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model))
          var_3.model delete();
      }
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model))
        var_3.model delete();
    }
  }

  level notify("killexplodertridgers" + var_0);
}

_id_392F() {
  if(isDefined(self.v["delay"]))
    var_0 = self.v["delay"];
  else
    var_0 = 0;

  if(isDefined(self.v["damage_radius"]))
    var_1 = self.v["damage_radius"];
  else
    var_1 = 128;

  var_2 = self.v["damage"];
  var_3 = self.v["origin"];
  wait(var_0);

  if(isDefined(level._id_2971))
    [[level._id_2971]](var_3, var_1, var_2);
  else
    radiusdamage(var_3, var_1, var_2, var_2);
}

_id_0895() {
  if(isDefined(self.v["firefx"]))
    thread _id_3BB8();

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    thread _id_1F5E();

  if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
    thread _id_8F30();

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
    thread _id_359F();

  if(isDefined(self.v["damage"]))
    thread _id_392F();

  if(isDefined(self.v["earthquake"]))
    thread _id_3931();

  if(isDefined(self.v["rumble"]))
    thread _id_393F();

  if(self.v["exploder_type"] == "exploder")
    thread _id_1CB3();
  else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
    thread _id_1CB5();
  else
    thread _id_1CB2();
}

_id_1CB2() {
  var_0 = self.v["exploder"];

  if(isDefined(self.v["delay"]) && self.v["delay"] >= 0)
    wait(self.v["delay"]);
  else
    waitframe();

  if(!isDefined(self.model)) {
    return;
  }
  if(isDefined(self.model.classname)) {
    if(common_scripts\utility::issp() && self.model.spawnflags & 1)
      self.model call[[level._id_2587]]();
  }

  if(level._id_27F6) {
    if(isDefined(self._id_3928)) {
      return;
    }
    self._id_3928 = 1;
    self.model _meth_805C();
    self.model _meth_82C2();
    wait 3;
    self._id_3928 = undefined;
    self.model _meth_805B();
    self.model _meth_82C1();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend;

  if(isDefined(self.model) && isDefined(self.model.classname))
    self.model delete();
}

_id_1CB5() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  var_0 = undefined;

  if(isDefined(self.v["target"]))
    var_0 = common_scripts\utility::_id_4375(self.v["target"]);

  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model _meth_805B();

  if(isDefined(self.v["delay_post"]))
    wait(self.v["delay_post"]);

  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = var_3 - self.v["origin"];
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = var_4[2];
  var_8 = isDefined(self.v["physics"]);

  if(var_8) {
    var_9 = undefined;

    if(isDefined(var_0.target))
      var_9 = var_0 common_scripts\utility::_id_4375();

    if(!isDefined(var_9)) {
      var_10 = var_1;
      var_11 = var_0.origin;
    } else {
      var_10 = var_0.origin;
      var_11 = (var_9.origin - var_0.origin) * self.v["physics"];
    }

    self.model _meth_82C5(var_10, var_11);
    return;
  } else {
    self.model _meth_82C0((var_5, var_6, var_7), 12);
    self.model _meth_82B5((var_5, var_6, var_7), 12);
  }

  if(level._id_27F6) {
    if(isDefined(self._id_3928)) {
      return;
    }
    self._id_3928 = 1;
    wait 3;
    self._id_3928 = undefined;
    self.v["origin"] = var_1;
    self.v["angles"] = var_2;
    self.model _meth_805C();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

_id_1CB3() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  if(!isDefined(self.model._id_8205)) {
    self.model _meth_805B();
    self.model _meth_82C1();
  } else {
    var_0 = self.model common_scripts\utility::_id_8FFC();

    if(isDefined(self.model._id_0164))
      var_0._id_0164 = self.model._id_0164;

    var_0 setModel(self.model._id_8205);
    var_0 _meth_805B();
  }

  self._id_1CB4 = 1;

  if(common_scripts\utility::issp() && !isDefined(self.model._id_8205) && self.model.spawnflags & 1) {
    if(!isDefined(self.model._id_2FBF))
      self.model call[[level._id_2587]]();
    else
      self.model call[[level._id_2FC3]]();
  }

  if(level._id_27F6) {
    if(isDefined(self._id_3928)) {
      return;
    }
    self._id_3928 = 1;
    wait 3;
    self._id_3928 = undefined;

    if(!isDefined(self.model._id_8205)) {
      self.model _meth_805C();
      self.model _meth_82C2();
    }
  }
}

_id_393F() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  _id_3930();
  level.player _meth_809F(self.v["rumble"]);
}

_id_3930() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;

  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"]))
    var_0 = self.v["delay_min"];

  if(isDefined(self.v["delay_max"]))
    var_1 = self.v["delay_max"];

  if(var_0 > 0) {
    var_2 = _func_0A5(var_0, var_1);
    self._id_08F0 = var_2;
    wait(var_2);
  }
}

_id_359F() {
  common_scripts\utility::_id_3F51();
  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  _id_3930();
  common_scripts\utility::_id_5EDF(var_1, var_0);
}

_id_8F30() {
  _id_35A0();
}

_id_35A0() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  _id_3930();
  common_scripts\utility::_id_3F50(var_1, var_0);
}

_id_3931() {
  _id_3930();
  common_scripts\utility::_id_30AE(self.v["earthquake"], self.v["origin"]);
}

_id_393D() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  common_scripts\utility::_id_3F50(self.v["soundalias"], self.v["origin"]);
}

_id_3BB8() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isDefined(var_6))
    var_6 = "createfx_effectStopper";

  var_7 = 0.5;

  if(isDefined(self.v["firefxdelay"]))
    var_7 = self.v["firefxdelay"];

  _id_3930();

  if(isDefined(var_3))
    common_scripts\utility::_id_5EE2(var_3, var_4, (0, 0, 0), 1, var_6);

  playFX(level._effect[var_5], self.v["origin"], var_0, var_1);
}

_id_1F5E() {
  if(isDefined(self.v["repeat"])) {
    thread _id_393D();

    for(var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      _id_3930();
    }

    return;
  }

  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;

  if(self.v["delay"] >= 0) {
    _id_3930();
    var_1 = 0;
  } else
    var_1 = self.v["delay"];

  if(isDefined(self.looper))
    self.looper delete();

  self.looper = _func_14B(common_scripts\utility::_id_44F5(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);

  if(level._id_27F6)
    setfxkillondelete(self.looper, 1);

  if(self.v["delay"] >= 0)
    _func_14C(self.looper);
  else
    _func_14C(self.looper, var_1);

  _id_393D();
}

_id_0891(var_0, var_1, var_2) {
  var_0 = var_0 + "";
  level notify("exploding_" + var_0);
  var_3 = 0;

  if(isDefined(level._id_2807) && !level._id_27F6) {
    var_4 = level._id_2807[var_0];

    if(isDefined(var_4)) {
      foreach(var_6 in var_4) {
        if(!var_6 _id_2158()) {
          continue;
        }
        var_6 common_scripts\utility::activate_individual_exploder();
        var_3 = 1;
      }
    }
  } else {
    for(var_8 = 0; var_8 < level.createfxent.size; var_8++) {
      var_6 = level.createfxent[var_8];

      if(!isDefined(var_6)) {
        continue;
      }
      if(var_6.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!var_6 _id_2158()) {
        continue;
      }
      var_6 common_scripts\utility::activate_individual_exploder();
      var_3 = 1;
    }
  }

  if(!_id_8BA5() && !var_3)
    _id_088E(var_0, var_1, var_2);
}

exploder(var_0, var_1, var_2) {
  [[level._fx._id_3945]](var_0, var_1, var_2);
}

kill_exploder(var_0) {
  var_1 = _id_44D1(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.looper))
        setfxkillondelete(var_3.looper, 1);
    }

    waitframe();

    foreach(var_3 in var_1)
    var_3 common_scripts\utility::pauseeffect();
  }
}

_id_2158() {
  var_0 = self;
  return 1;
}

_id_088E(var_0, var_1, var_2) {
  if(!_id_5640(var_0)) {
    return;
  }
  var_3 = int(var_0);
  _func_213(var_3, var_1, var_2);
}

_id_2A6D(var_0, var_1, var_2) {
  if(!_id_5640(var_0)) {
    return;
  }
  var_3 = int(var_0);
  _func_277(var_3, var_1, var_2);
}

_id_5640(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0;

  if(_func_031(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "0")
      return 0;
  }

  return var_1 >= 0;
}

_id_8BA5() {
  if(common_scripts\utility::issp())
    return 1;

  if(!isDefined(level._id_27F6))
    level._id_27F6 = getDvar("1459") != "";

  if(level._id_27F6)
    return 1;
  else
    return getDvar("3508") != "1";
}

_id_392D(var_0, var_1, var_2) {
  waittillframeend;
  waittillframeend;
  _id_0891(var_0, var_1, var_2);
}

_id_392B(var_0, var_1, var_2) {
  _id_0891(var_0, var_1, var_2);
}