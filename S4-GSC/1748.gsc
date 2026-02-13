/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1748.gsc
*************************************************/

_id_D7CE(var_0) {
  var_1 = var_0._id_0481;

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  if(_id_57C9(var_0)) {
    var_0 hide();
    return;
  }

  if(_id_57C3(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0._id_03EA) && var_0._id_03EA & 1) {
      if(isDefined(var_0._id_CD0F)) {
        var_0 _meth_8093();
      }
    }

    return;
  }

  if(_id_57C2(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0._id_03EA) && var_0._id_03EA & 1) {
      var_0 _meth_8093();
    }

    return;
  }
}

_id_10C4(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_CE28)) {
      var_2._id_0397 = var_2._id_CE28;
      level._id_7F7B[level._id_7F7B.size] = var_2;
      continue;
    }

    if(isDefined(var_2._id_0397)) {
      var_3 = 1;

      if(!isDefined(var_2.angles)) {
        var_2.angles = (0, 0, 0);
      }

      level._id_7F7B[level._id_7F7B.size] = var_2;
    }
  }
}

_id_C48E(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(isDefined(var_2._id_0394) && var_2._id_0394) {
      level._id_EA6A[var_3] = undefined;
    }
  }
}

_id_D86A() {
  level._id_7F7B = [];
  level._id_57CC = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    var_0[var_0.size] = var_3;
  }

  foreach(var_6 in var_0) {
    if(isDefined(var_6._id_CE28)) {
      var_6._id_0397 = var_6._id_CE28;
    }

    if(isDefined(var_6._id_9B9C)) {
      continue;
    }
    if(isDefined(var_6._id_0397)) {
      _id_D7CE(var_6);
    }
  }

  _id_10C4(getEntArray("script_brushmodel", "classname"));
  _id_10C4(getEntArray("script_model", "classname"));
  _id_10C4(level._id_EA6A);

  if(!isDefined(level._id_3FE3)) {
    level._id_3FE3 = [];
  }

  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;

  foreach(var_10 in level._id_7F7B) {
    var_6 = scripts\engine\utility::_id_3FC9(var_10._id_CD65, 1);
    var_6.v = [];
    var_6.v["origin"] = var_10.origin;
    var_6.v["angles"] = var_10.angles;
    var_6.v["delay"] = var_10._id_0393;
    var_6.v["delay_post"] = var_10._id_CCFF;
    var_6.v["firefx"] = var_10._id_CD3E;
    var_6.v["firefxdelay"] = var_10._id_CD3F;
    var_6.v["firefxsound"] = var_10._id_CD40;
    var_6.v["earthquake"] = var_10._id_0395;
    var_6.v["rumble"] = var_10._id_03A1;
    var_6.v["damage"] = var_10._id_0392;
    var_6.v["damage_radius"] = var_10._id_03A0;
    var_6.v["soundalias"] = var_10._id_CE4B;
    var_6.v["repeat"] = var_10._id_CE31;
    var_6.v["delay_min"] = var_10._id_CCFD;
    var_6.v["delay_max"] = var_10._id_CCFB;
    var_6.v["target"] = var_10.target;
    var_6.v["ender"] = var_10._id_CD2A;
    var_6.v["physics"] = var_10._id_CE1E;
    var_6.v["type"] = "exploder";
    var_6.v["dotraces"] = var_10._id_03A2;
    var_6.v["envonly"] = var_10._id_0396;

    if(!isDefined(var_6.v["angles"])) {
      var_6.v["angles"] = (0, 0, 0);
    }

    var_6 _id_06CE::_id_D216();

    if(!isDefined(var_10._id_CD65)) {
      var_6.v["fxid"] = "No FX";
    } else {
      var_6.v["fxid"] = var_10._id_CD65;
    }

    var_6.v["exploder"] = var_10._id_0397;

    if(!isDefined(var_6.v["delay"])) {
      var_6.v["delay"] = 0;
    }

    if(isDefined(var_10.target)) {
      var_11 = getEntArray(var_6.v["target"], "targetname")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_6.v["angles"] = vectortoangles(var_12 - var_6.v["origin"]);
      } else {
        var_11 = scripts\engine\utility::_id_67AA(var_6.v["target"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_6.v["angles"] = vectortoangles(var_12 - var_6.v["origin"]);
        }
      }
    }

    if(_func_02DE(var_10)) {
      var_6.model = var_10;

      if(isDefined(var_6.model._id_CDC1)) {
        precachemodel(var_6.model._id_CDC1);
      }
    } else if(var_10._id_00EC == "script_brushmodel" || isDefined(var_10.model)) {
      var_6.model = var_10;
      var_6.model._id_4B13 = var_10._id_CD0F;
    }

    if(isDefined(var_10._id_0481) && isDefined(var_8[var_10._id_0481])) {
      var_6.v["exploder_type"] = var_10._id_0481;
    } else {
      var_6.v["exploder_type"] = "normal";
    }

    if(isDefined(var_10._id_9B9C)) {
      var_6.v["masked_exploder"] = var_10.model;
      var_6.v["masked_exploder_spawnflags"] = var_10._id_03EA;
      var_6.v["masked_exploder_script_disconnectpaths"] = var_10._id_CD0F;
      var_10 delete();
    }

    var_6 _id_06CE::_id_BA24();
    var_13 = var_6.v["exploder"];

    if(!isDefined(level._id_57CC[var_13])) {
      level._id_57CC[var_13] = [];
    }

    level._id_57CC[var_13][level._id_57CC[var_13].size] = var_6;
  }

  level._id_7F7B = undefined;
  _id_C48E(level._id_EA6A);
}

_id_57C1(var_0, var_1) {
  if(!scripts\engine\utility::_id_5C0C(var_0)) {
    scripts\engine\utility::_id_5C11(var_0);
  }

  scripts\engine\utility::_id_5C24(var_0);

  foreach(var_3 in var_1) {
    foreach(var_5 in level._id_3FE4[var_3]) {
      var_5 scripts\engine\utility::_id_0EB3();
    }
  }
}

_id_57C3(var_0) {
  return isDefined(var_0._id_0481) && var_0._id_0481 == "exploder";
}

_id_57C9(var_0) {
  return var_0.model == "fx" && (!isDefined(var_0._id_0481) || var_0._id_0481 != "exploderchunk");
}

_id_57C2(var_0) {
  return isDefined(var_0._id_0481) && var_0._id_0481 == "exploderchunk";
}

_id_DC3C(var_0) {
  var_0 = var_0 + "";
  var_1 = _id_6495();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(_func_02DE(var_3.model)) {
        continue;
      }
      if(!_id_57C9(var_3.model) && !_id_57C3(var_3.model) && !_id_57C2(var_3.model)) {
        var_3.model show();
      }

      if(isDefined(var_3._id_2C3F)) {
        var_3.model show();
      }
    }
  }
}

_id_6495(var_0) {
  var_1 = [];

  if(level._id_3FD9) {
    var_1 = _id_641E(var_0);
  } else if(isDefined(level._id_3FE4) && isDefined(level._id_3FE4[var_0])) {
    var_1 = level._id_3FE4[var_0];
  }

  if(isDefined(level._id_57CC) && isDefined(level._id_57CC[var_0])) {
    foreach(var_3 in level._id_57CC[var_0]) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_641E(var_0) {}

_id_E894(var_0, var_1, var_2) {
  var_0 = var_0 + "";
  var_3 = 0;
  var_4 = _id_6495(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6._id_9834)) {
        continue;
      }
      if(isDefined(var_6._id_9845)) {
        var_6._id_9845 stoploopsound();
        var_6._id_9845 delete();
      }

      var_6._id_9834 delete();
      var_3 = 1;
    }
  }

  if(!_id_DBCB() && (_func_03B1() || !var_3)) {
    _id_E889(var_0, var_1, var_2);
  }
}

_id_E889(var_0, var_1, var_2) {
  if(_func_03B1()) {
    _func_039D(var_0, var_1, var_2);
    return;
  }

  if(!_id_8705(var_0)) {
    return;
  }
  var_3 = int(var_0);
  _func_039D(var_3, var_1, var_2);
}

_id_6494(var_0) {
  var_0 = var_0 + "";
  var_1 = [];
  var_2 = _id_6495(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

_id_78AD(var_0) {
  var_0 = var_0 + "";
  var_1 = _id_6495(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(_func_02DE(var_3.model)) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model hide();
      }
    }
  }
}

_id_4712(var_0) {
  var_0 = var_0 + "";
  var_1 = _id_6495(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(_func_02DE(var_3.model)) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + var_0);
}

_id_57BD() {
  if(isDefined(self.v["delay"])) {
    var_0 = self.v["delay"];
  } else {
    var_0 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var_1 = self.v["damage_radius"];
  } else {
    var_1 = 128;
  }

  var_2 = self.v["damage"];
  var_3 = self.v["origin"];

  if(isDefined(self.v["envonly"])) {
    var_4 = self.v["envonly"];
  } else {
    var_4 = 0;
  }

  if(isDefined(self.v["dotraces"])) {
    var_5 = self.v["dotraces"];
  } else {
    var_5 = 1;
  }

  if(var_2 <= 0) {
    return;
  }
  wait(var_0);
  _func_01BA(var_3, var_1, var_2, var_2, undefined, "MOD_EXPLOSIVE", undefined, var_4, var_5);
}

_id_0EB4() {
  if(isDefined(self.v["firefx"])) {
    thread _id_5B2F();
  }

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    thread _id_319C();
  } else if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    thread _id_E052();
  }

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil") {
    thread _id_5109();
  }

  if(isDefined(self.v["damage"])) {
    thread _id_57BD();
  }

  if(isDefined(self.v["earthquake"])) {
    thread _id_57BF();
  }

  if(isDefined(self.v["rumble"])) {
    thread _id_57C7();
  }

  if(self.v["exploder_type"] == "exploder") {
    thread _id_2C3E();
  } else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread _id_2C40();
  } else {
    thread _id_2C3D();
  }
}

_id_2C3D() {
  var_0 = self.v["exploder"];

  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    waitframe();
  }

  if(!isDefined(self.model)) {
    return;
  }
  if(_func_02DE(self.model)) {
    return;
  }
  if(scripts\common\utility::issp() && isDefined(self.model.classname)) {
    if(self.model._id_03EA & 1) {
      self.model call[[level._id_6016["connectPaths"]]]();
    }
  }

  if(level._id_3FD9) {
    if(isDefined(self._id_57B7)) {
      return;
    }
    self._id_57B7 = 1;
    self.model hide();
    self.model notsolid();
    wait 3;
    self._id_57B7 = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }

  waittillframeend;
  self.model delete();
}

_id_2C40() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  var_0 = undefined;

  if(isDefined(self.v["target"])) {
    var_0 = scripts\engine\utility::_id_67AA(self.v["target"]);
  }

  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait(self.v["delay_post"]);
  }

  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = isDefined(self.v["physics"]);

  if(var_4) {
    var_5 = undefined;

    if(isDefined(var_0.target)) {
      var_5 = var_0 scripts\engine\utility::_id_67AA();
    }

    if(isDefined(var_5)) {
      var_6 = var_0.origin;
      var_7 = vectornormalize(var_5.origin - var_0.origin);
    } else {
      var_6 = self.model.origin;
      var_7 = vectornormalize(var_3 - self.model.origin);
    }

    var_7 = var_7 * self.v["physics"];
    self.model physicslaunchserver(var_6, var_7);
    return;
  } else {
    var_7 = var_3 - self.model.origin;
    self.model rotatevelocity(var_7, 12);
    self.model movegravity(var_7, 12);
  }

  if(level._id_3FD9) {
    if(isDefined(self._id_57B7)) {
      return;
    }
    self._id_57B7 = 1;
    wait 3;
    self._id_57B7 = undefined;
    self.v["origin"] = var_1;
    self.v["angles"] = var_2;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

_id_2C3E() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(self.model._id_CDC1)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = 1;
    var_1 = spawn("script_model", self.model.origin);
    var_1.angles = self.model.angles;
    var_1 setModel(self.model._id_CDC1);

    if(isDefined(self.model._id_0398)) {
      var_1._id_0398 = self.model._id_0398;
    }
  }

  self._id_2C3F = 1;

  if(!var_0 && scripts\common\utility::issp() && self.model._id_03EA & 1) {
    if(!isDefined(self.model._id_4B13)) {
      self.model call[[level._id_6016["connectPaths"]]]();
    } else {
      self.model call[[level._id_6016["disconnectPaths"]]]();
    }
  }

  if(level._id_3FD9) {
    if(isDefined(self._id_57B7)) {
      return;
    }
    self._id_57B7 = 1;
    wait 3;
    self._id_57B7 = undefined;

    if(!var_0) {
      self.model hide();
      self.model notsolid();
    } else
      var_1 delete();
  }
}

_id_57C7() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  _id_57BE();
  level.player playrumbleonentity(self.v["rumble"]);
}

_id_57BE() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    var_0 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var_1 = self.v["delay_max"];
  }

  if(var_0 > 0) {
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_5109() {
  if(isDefined(self._id_9845)) {
    self._id_9845 stoploopsound();
    self._id_9845 delete();
  }

  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  _id_57BE();
  self._id_9845 = scripts\engine\utility::_id_B27F(var_1, var_0);
}

_id_E052() {
  _id_510A();
}

_id_510A() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  _id_57BE();
  scripts\engine\utility::_id_B2DA(var_1, var_0);
}

_id_57BF() {
  _id_57BE();
  scripts\engine\utility::_id_4BF4(self.v["earthquake"], self.v["origin"]);
}

_id_57C6() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  scripts\engine\utility::_id_B2DA(self.v["soundalias"], self.v["origin"]);
}

_id_5B2F() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isDefined(var_6)) {
    var_6 = "createfx_effectStopper";
  }

  var_7 = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    var_7 = self.v["firefxdelay"];
  }

  _id_57BE();

  if(isDefined(var_3)) {
    scripts\engine\utility::_id_9820(var_3, var_4, 1, var_6);
  }

  playFX(level._effect[var_5], self.v["origin"], var_0, var_1);
}

_id_319C() {
  if(isDefined(self.v["repeat"])) {
    thread _id_57C6();

    for(var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      _id_57BE();
    }

    return;
  }

  _id_57BE();

  if(isDefined(self._id_9834)) {
    self._id_9834 delete();
  }

  self._id_9834 = spawnfx(scripts\engine\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self._id_9834);
  _id_57C6();
}

_id_0EAD(var_0, var_1, var_2) {
  var_0 = var_0 + "";
  level notify("exploding_" + var_0);
  var_3 = 0;
  var_4 = _id_6495(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      var_6 scripts\engine\utility::_id_0EB3();
      var_3 = 1;
    }
  }

  if(!_id_DBCB() && (_func_03B1() || !var_3)) {
    _id_0EA0(var_0, var_1, var_2);
  }
}

_id_0EA0(var_0, var_1, var_2) {
  if(_func_03B1()) {
    _func_0003(var_0, var_1, var_2);
    return;
  }

  if(!_id_8705(var_0)) {
    return;
  }
  var_3 = int(var_0);
  _func_0003(var_3, var_1, var_2);
}

_id_8705(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0;

  if(_func_0121(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "0") {
      return 0;
    }
  }

  return var_1 >= 0;
}

_id_DBCB() {
  if(scripts\common\utility::issp() && !_func_03B1()) {
    return 1;
  }

  if(!isDefined(level._id_3FD9)) {
    scripts\engine\utility::_id_D19F();
  }

  if(level._id_3FD9) {
    return 1;
  } else {
    return getDvar("#x3e4eb4040dda2b10e") != "1";
  }
}

_id_57BC(var_0, var_1, var_2) {
  waittillframeend;
  waittillframeend;
  _id_0EAD(var_0, var_1, var_2);
}

_id_57BB(var_0, var_1, var_2) {
  _id_0EAD(var_0, var_1, var_2);
}