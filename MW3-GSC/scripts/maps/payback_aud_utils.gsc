/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_aud_utils.gsc
**********************************************/

_id_6854(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6855)) {
    level._id_6855 = [];

  }
  var_5 = 1;

  if(isDefined(var_4)) {
    var_5 = var_4;

  }
  var_6 = spawnStruct();
  level._id_6855[level._id_6855.size] = var_6;
  var_6._id_6856 = [];
  var_6._id_6856["type"] = var_0;
  var_6._id_6856["targetname"] = var_1;
  var_6._id_6856["active"] = var_5;
  var_6._id_6856["playing"] = 0;
  var_6._id_6856["soundalias"] = var_2;
  var_6._id_6856["origin"] = var_3;
  var_6._id_6856["angles"] = undefined;
  var_6._id_6856["delay_min"] = undefined;
  var_6._id_6856["delay_max"] = undefined;
  var_6.drawn = 1;
  return var_6;
}

_id_6857(var_0, var_1, var_2, var_3) {
  var_4 = _id_6854("looping", var_0, var_1, var_2, var_3);
  return var_4;
}

_id_6858(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_6854("oneshot", var_0, var_1, var_2, var_5);
  var_6._id_6856["delay_min"] = var_3;
  var_6._id_6856["delay_max"] = var_4;
  return var_6;
}

_id_6859() {
  var_0 = self._id_6856["soundalias"];
  var_1 = self._id_6856["origin"];
  self._id_6856["active"] = 1;

  if(self._id_6856["active"] == 1 && self._id_6856["playing"] == 0) {
    var_2 = spawn("script_origin", var_1);
    self.entity = var_2;
    self._id_6856["playing"] = 1;
    self.entity playLoopSound(var_0);
    self.entity willneverchange();
  }
}

_id_685A() {
  var_0 = self._id_6856["soundalias"];
  var_1 = self._id_6856["origin"];
  var_2 = self._id_6856["delay_min"];
  var_3 = self._id_6856["delay_max"];
  self._id_6856["active"] = 1;

  while(self._id_6856["active"]) {
    wait(randomfloatrange(var_2, var_3));

    if(self._id_6856["active"]) {
      var_4 = self.entity;

      if(!isDefined(var_4)) {
        var_5 = spawn("script_origin", var_1);
        self.entity = var_5;
        self._id_6856["playing"] = 1;
        self.entity playSound(var_0, "sounddone");
        self.entity waittill("sounddone");
        self._id_6856["playing"] = 0;
        waittillframeend;
        self.entity delete();
      }
    }
  }
}

_id_685B(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  for(var_3 = 0; var_3 < level._id_6855.size; var_3++) {
    var_4 = level._id_6855[var_3];

    if(var_4._id_6856["targetname"] == var_0) {
      continue;
    } else {
      if(var_4._id_6856["type"] == "looping") {
        var_4 thread _id_6859();
        continue;
      }

      if(var_4._id_6856["type"] == "oneshot") {
        var_4 thread _id_685A();
        continue;
      }

      if(var_2 > 0) {
        var_4.entity scalevolume(0.0);
        var_4.entity scalevolume(1.0, var_2);
        wait(var_2);
        waittillframeend;
      }
    }
  }
}

_id_685C(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  for(var_3 = 0; var_3 < level._id_6855.size; var_3++) {
    var_4 = level._id_6855[var_3];

    if(var_4._id_6856["targetname"] != var_0) {
      continue;
    } else {
      if(var_2 > 0) {
        var_4.entity scalevolume(0.0, var_2);
        wait(var_2);
        waittillframeend;
      }

      var_4._id_6856["active"] = 0;
      var_4._id_6856["playing"] = 0;

      if(var_4._id_6856["type"] == "looping") {
        var_4.entity stoploopsound();
        waittillframeend;
        var_4.entity delete();
        continue;
      }

      if(var_4._id_6856["type"] == "oneshot") {
        continue;
      }
    }
  }
}

_id_685D() {
  if(getdvar("snd_staticDebug") == "") {
    return;
  }
}

_id_685E() {
  if(!isDefined(level._id_6855)) {
    level._id_6855 = [];

  }
  thread _id_685D();

  for(var_0 = 0; var_0 < level._id_6855.size; var_0++) {
    var_1 = level._id_6855[var_0];

    if(var_1._id_6856["active"] == 1) {
      if(var_1._id_6856["type"] == "looping") {
        var_1 thread _id_6859();

      }
      if(var_1._id_6856["type"] == "oneshot") {
        var_1 thread _id_685A();
      }
    }
  }
}