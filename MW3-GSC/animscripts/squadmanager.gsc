/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\squadmanager.gsc
****************************************/

_id_0A5E() {
  if(isDefined(anim._id_0A5F) && anim._id_0A5F) {
    return;
  }
  anim._id_0A60 = [];
  anim._id_0A61 = [];
  anim._id_0A62 = [];
  anim._id_0A63 = [];
  anim._id_0A64 = 0;
  anim._id_0A5F = 1;
}

_id_0A65(var_0, var_1) {
  anim._id_0A62[var_0] = spawnStruct();
  var_2 = anim._id_0A62[var_0];
  var_2._id_0A66 = var_0;
  var_2.team = _id_0A7D(var_1);
  var_2._id_0A67 = 0;
  var_2.origin = undefined;
  var_2.forward = undefined;
  var_2.enemy = undefined;
  var_2._id_0A69 = 0;
  var_2._id_0A6A = 0;
  var_2._id_0A6B = [];
  var_2._id_0A6C = [];
  var_2._id_0A6D = 0;
  var_2._id_0A6E = [];
  var_2._id_0A6F = [];
  var_2._id_0A70 = [];
  var_2._id_0A71 = [];
  var_2._id_0A72 = [];
  var_2._id_0A73 = [];
  var_2._id_0A74 = [];
  var_2._id_0A75 = anim._id_0A63.size;
  var_2 _id_0A9F("combat", 0.75);
  var_2 _id_0A9F("cover", 0.75);
  var_2 _id_0A9F("move", 0.75);
  var_2 _id_0A9F("stop", 0.75);
  var_2 _id_0A9F("death", 0.75);
  var_2 _id_0A9F("suppressed", 0.75);
  var_2 _id_0A9F("attacking", 0.5);
  anim._id_0A63[anim._id_0A63.size] = var_2;
  var_2 _id_0A94();
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);

  for(var_3 = 0; var_3 < anim._id_0A60.size; var_3++) {
    var_4 = anim._id_0A60[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_3 = 0; var_3 < anim._id_0A63.size; var_3++) {
    anim._id_0A63[var_3] _id_0A94();
  }
  var_2 thread _id_0A89();
  var_2 thread _id_0A8A();
  var_2 thread _id_0A88();
  var_2 thread _id_0A9A();
  return var_2;
}

_id_0A76(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies") {
    return;
  }
  var_1 = anim._id_0A62[var_0]._id_0A75;
  var_2 = anim._id_0A62[var_0];
  var_2 notify("squad_deleting");

  while(var_2._id_0A6B.size) {
    var_2._id_0A6B[0] _id_0A7E(var_2._id_0A6B[0].team);
  }
  anim._id_0A63[var_1] = anim._id_0A63[anim._id_0A63.size - 1];
  anim._id_0A63[var_1]._id_0A75 = var_1;
  anim._id_0A63[anim._id_0A63.size - 1] = undefined;
  anim._id_0A62[var_0] = undefined;
  level notify("squad deleted " + var_0);
  anim notify("squad deleted " + var_0);

  for(var_3 = 0; var_3 < anim._id_0A63.size; var_3++) {
    anim._id_0A63[var_3] _id_0A94();
  }
}

_id_0A77() {
  var_0 = "auto" + anim._id_0A64;
  anim._id_0A64++;
  return var_0;
}

_id_0A78(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_0A79)) {
      var_0 = self._id_0A79;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(anim._id_0A62[var_0])) {
    anim _id_0A65(var_0, self);
  }
  var_1 = anim._id_0A62[var_0];
  self._id_0A7A = var_1;
}

_id_0A7B() {
  self endon("death");
  wait 10.0;

  if(!isDefined(self._id_0A79)) {
    var_0 = self.team + self._id_0A7C;
  } else {
    var_0 = self._id_0A79 + self._id_0A7C;
  }
  _id_0A7E(var_0);
}

_id_0A7D(var_0) {
  var_1 = "allies";

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3") {
    var_1 = var_0.team;
  }
  return var_1;
}

_id_0A7E(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_0A7C)) {
      thread _id_0A7B();
    }
    if(isDefined(self._id_0A79)) {
      var_0 = self._id_0A79;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(anim._id_0A62[var_0])) {
    anim _id_0A65(var_0, self);
  }
  var_1 = anim._id_0A62[var_0];

  if(isDefined(self._id_0A7A)) {
    if(self._id_0A7A == var_1) {
      return;
    } else {
      _id_0A84();
    }
  }

  self._id_0A7F = 0;
  self._id_0A80 = 0;
  self._id_0A7A = var_1;
  self._id_0A81 = var_1._id_0A6B.size;
  var_1._id_0A6B[self._id_0A81] = self;
  var_1._id_0A6A = var_1._id_0A6B.size;

  if(isDefined(level._id_0A82)) {
    if(self.team == "allies" && animscripts\battlechatter::_id_0A83()) {
      _id_0A86();
    }
  }

  for(var_2 = 0; var_2 < self._id_0A7A._id_0A6F.size; var_2++) {
    var_3 = self._id_0A7A._id_0A6F[var_2];
    self thread[[var_3]](self._id_0A7A._id_0A66);
  }

  thread _id_0A8D();
  thread _id_0A8B();
}

_id_0A84() {
  var_0 = self._id_0A7A;
  var_1 = -1;

  if(isDefined(self)) {
    var_1 = self._id_0A81;
  } else {
    for(var_2 = 0; var_2 < var_0._id_0A6B.size; var_2++) {
      if(var_0._id_0A6B[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0._id_0A6B.size - 1) {
    var_3 = var_0._id_0A6B[var_0._id_0A6B.size - 1];
    var_0._id_0A6B[var_1] = var_3;

    if(isDefined(var_3)) {
      var_3._id_0A81 = var_1;
    }
  }

  var_0._id_0A6B[var_0._id_0A6B.size - 1] = undefined;
  var_0._id_0A6A = var_0._id_0A6B.size;

  if(isDefined(self._id_0A85)) {
    _id_0A87();
  }
  for(var_2 = 0; var_2 < self._id_0A7A._id_0A71.size; var_2++) {
    var_4 = self._id_0A7A._id_0A71[var_2];
    self thread[[var_4]](var_0._id_0A66);
  }

  if(var_0._id_0A6A == 0) {
    _id_0A76(var_0._id_0A66);
  }
  if(isDefined(self)) {
    self._id_0A7A = undefined;
    self._id_0A81 = undefined;
  }

  self notify("removed from squad");
}

_id_0A86() {
  var_0 = self._id_0A7A;

  if(isDefined(self._id_0A85)) {
    return;
  }
  self._id_0A85 = var_0._id_0A6C.size;
  var_0._id_0A6C[self._id_0A85] = self;
  var_0._id_0A6D = var_0._id_0A6C.size;
}

_id_0A87() {
  var_0 = self._id_0A7A;
  var_1 = -1;

  if(isDefined(self)) {
    var_1 = self._id_0A85;
  } else {
    for(var_2 = 0; var_2 < var_0._id_0A6C.size; var_2++) {
      if(var_0._id_0A6C[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0._id_0A6C.size - 1) {
    var_3 = var_0._id_0A6C[var_0._id_0A6C.size - 1];
    var_0._id_0A6C[var_1] = var_3;

    if(isDefined(var_3)) {
      var_3._id_0A85 = var_1;
    }
  }

  var_0._id_0A6C[var_0._id_0A6C.size - 1] = undefined;
  var_0._id_0A6D = var_0._id_0A6C.size;

  if(isDefined(self)) {
    self._id_0A85 = undefined;
  }
}

_id_0A88() {
  if(!isDefined(level._id_0A82)) {
    anim waittill("loadout complete");
  }
  for(var_0 = 0; var_0 < self._id_0A6B.size; var_0++) {
    if(self._id_0A6B[var_0] animscripts\battlechatter::_id_0A83()) {
      self._id_0A6B[var_0] _id_0A86();
    }
  }
}

_id_0A89() {
  for(;;) {
    anim waittill("squadupdate", var_0);

    switch (var_0) {
      case "squadlist":
        _id_0A94();
        break;
      case "combat":
        _id_0A90();
        break;
      case "origin":
        updateorigin();
        break;
      case "forward":
        _id_0A8E();
        break;
    }
  }
}

_id_0A8A() {
  anim endon("squad deleted " + self._id_0A66);

  for(;;) {
    _id_0A93();
    wait 0.1;
  }
}

_id_0A8B() {
  self endon("removed from squad");
  self waittill("death", var_0);

  if(isDefined(self)) {
    self.attacker = var_0;
  }
  _id_0A84();
}

_id_0A8D() {
  self endon("removed from squad");

  for(;;) {
    self waittill("enemy");

    if(!isDefined(self.enemy)) {
      self._id_0A7A notify("squadupdate", "combat");
    } else {
      self._id_0A7A._id_0A69 = 1;
    }
    wait 0.05;
  }
}

_id_0A8E() {
  if(isDefined(self.enemy)) {
    self.forward = vectornormalize(self.enemy.origin - self.origin);
  } else {
    var_0 = (0, 0, 0);
    var_1 = 0;

    for(var_2 = 0; var_2 < self._id_0A6B.size; var_2++) {
      if(!isalive(self._id_0A6B[var_2])) {
        continue;
      }
      var_0 = var_0 + anglesToForward(self._id_0A6B[var_2].angles);
      var_1++;
    }

    if(var_1) {
      self.forward = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
      return;
    }

    self.forward = var_0;
  }
}

updateorigin() {
  var_0 = (0, 0, 0);
  var_1 = 0;

  for(var_2 = 0; var_2 < self._id_0A6B.size; var_2++) {
    if(!isalive(self._id_0A6B[var_2])) {
      continue;
    }
    var_0 = var_0 + self._id_0A6B[var_2].origin;
    var_1++;
  }

  if(var_1) {
    self.origin = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
  } else {
    self.origin = var_0;
  }
}

_id_0A90() {
  self._id_0A69 = 0;

  for(var_0 = 0; var_0 < anim._id_0A63.size; var_0++) {
    self._id_0A6E[anim._id_0A63[var_0]._id_0A66]._id_0A91 = 0;
  }
  for(var_0 = 0; var_0 < self._id_0A6B.size; var_0++) {
    if(isDefined(self._id_0A6B[var_0].enemy) && isDefined(self._id_0A6B[var_0].enemy._id_0A7A) && self._id_0A6B[var_0]._id_0A80 > 0) {
      self._id_0A6E[self._id_0A6B[var_0].enemy._id_0A7A._id_0A66]._id_0A91 = 1;
    }
  }
}

_id_0A92() {
  var_0 = undefined;

  for(var_1 = 0; var_1 < self._id_0A6B.size; var_1++) {
    if(isDefined(self._id_0A6B[var_1].enemy) && isDefined(self._id_0A6B[var_1].enemy._id_0A7A)) {
      if(!isDefined(var_0)) {
        var_0 = self._id_0A6B[var_1].enemy._id_0A7A;
        continue;
      }

      if(self._id_0A6B[var_1].enemy._id_0A7A._id_0A6A > var_0._id_0A6A) {
        var_0 = self._id_0A6B[var_1].enemy._id_0A7A;
      }
    }
  }

  self.enemy = var_0;
}

_id_0A93() {
  var_0 = (0, 0, 0);
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;
  _id_0A90();

  for(var_4 = 0; var_4 < self._id_0A6B.size; var_4++) {
    if(!isalive(self._id_0A6B[var_4])) {
      continue;
    }
    var_0 = var_0 + self._id_0A6B[var_4].origin;
    var_1++;

    if(isDefined(self._id_0A6B[var_4].enemy) && isDefined(self._id_0A6B[var_4].enemy._id_0A7A)) {
      if(!isDefined(var_2)) {
        var_2 = self._id_0A6B[var_4].enemy._id_0A7A;
        continue;
      }

      if(self._id_0A6B[var_4].enemy._id_0A7A._id_0A6A > var_2._id_0A6A) {
        var_2 = self._id_0A6B[var_4].enemy._id_0A7A;
      }
    }
  }

  if(var_1) {
    self.origin = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
  } else {
    self.origin = var_0;
  }
  self._id_0A69 = var_3;
  self.enemy = var_2;
  _id_0A8E();
}

_id_0A94() {
  for(var_0 = 0; var_0 < anim._id_0A63.size; var_0++) {
    if(!isDefined(self._id_0A6E[anim._id_0A63[var_0]._id_0A66])) {
      self._id_0A6E[anim._id_0A63[var_0]._id_0A66] = spawnStruct();
      self._id_0A6E[anim._id_0A63[var_0]._id_0A66]._id_0A91 = 0;
    }

    for(var_1 = 0; var_1 < self._id_0A73.size; var_1++) {
      var_2 = self._id_0A73[var_1];
      self thread[[var_2]](anim._id_0A63[var_0]._id_0A66);
    }
  }
}

_id_0A95(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }
  if(!isDefined(var_3)) {
    var_3 = (1, 0, 0);
  }
  for(var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }
    var_5 = self getshootatpos() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

_id_0A96(var_0) {
  switch (var_0) {
    case "move":
    case "combat":
    case "death":
    case "stop":
      self.a._id_0A98 = var_0;
      break;
    case "grenadecower":
    case "pain":
      break;
    case "stalingrad_cover_crouch":
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "cover_crouch":
    case "cover_right":
      self.a._id_0A98 = "cover";
      break;
    case "l33t truckride combat":
    case "aim":
      self.a._id_0A98 = "combat";
      break;
  }
}

_id_0A99() {
  _id_0AA4("combat");
  _id_0AA4("cover");
  _id_0AA4("move");
  _id_0AA4("stop");
  _id_0AA4("death");
  _id_0AA4("suppressed");
  _id_0AA4("attacking");

  for(var_0 = 0; var_0 < self._id_0A6B.size; var_0++) {
    if(!isalive(self._id_0A6B[var_0])) {
      continue;
    }
    _id_0AA5(self._id_0A6B[var_0]);
    _id_0AA6(self._id_0A6B[var_0], "suppressed");
    _id_0AA6(self._id_0A6B[var_0], "combat");
    _id_0AA6(self._id_0A6B[var_0], "attacking");
    _id_0AA6(self._id_0A6B[var_0], "cover");
  }
}

_id_0A9A() {
  anim endon("squad deleted " + self._id_0A66);
  var_0 = 0.05;

  for(;;) {
    for(var_1 = 0; var_1 < self._id_0A6B.size; var_1++) {
      if(!isalive(self._id_0A6B[var_1])) {
        continue;
      }
      self._id_0A6B[var_1] _id_0A9B(var_0);
      self._id_0A6B[var_1] _id_0A9C(var_0);
    }

    wait(var_0);
  }
}

_id_0A9B(var_0) {
  if(isDefined(self.lastenemysightpos)) {
    if(self._id_0A80 < 0) {
      self._id_0A80 = var_0;
    } else {
      self._id_0A80 = self._id_0A80 + var_0;
    }
    self._id_0A7F = gettime();
    return;
  } else if(self issuppressed()) {
    self._id_0A80 = self._id_0A80 + var_0;
    return;
  }

  if(self._id_0A80 > 0) {
    self._id_0A80 = 0 - var_0;
  } else {
    self._id_0A80 = self._id_0A80 - var_0;
  }
}

_id_0A9C(var_0) {
  if(self._id_0A9D) {
    if(self._id_0A9E < 0) {
      self._id_0A9E = var_0;
    } else {
      self._id_0A9E = self._id_0A9E + var_0;
    }
  } else {
    if(self._id_0A9E > 0) {
      self._id_0A9E = 0 - var_0;
      return;
    }

    self._id_0A9E = self._id_0A9E - var_0;
  }
}

_id_0A9F(var_0, var_1) {
  self._id_0AA0[var_0] = spawnStruct();
  self._id_0AA0[var_0]._id_0AA1 = var_1;
  self._id_0AA0[var_0]._id_0AA2 = 0;
  self._id_0AA0[var_0]._id_0AA3 = 0;
}

_id_0AA4(var_0) {
  self._id_0AA0[var_0]._id_0AA2 = 0;
  self._id_0AA0[var_0]._id_0AA3 = 0;
}

_id_0AA5(var_0) {
  self._id_0AA0[var_0.a._id_0A98]._id_0AA3++;

  if(self._id_0AA0[var_0.a._id_0A98]._id_0AA3 > self._id_0AA0[var_0.a._id_0A98]._id_0AA1 * self._id_0A6B.size) {
    self._id_0AA0[var_0.a._id_0A98]._id_0AA2 = 1;
  }
}

_id_0AA6(var_0, var_1) {
  switch (var_1) {
    case "suppressed":
      if(var_0._id_0A9E > 1.0) {
        self._id_0AA0[var_1]._id_0AA3++;
      }
      break;
    case "combat":
      if(var_0._id_0A80 > 0.0) {
        self._id_0AA0[var_1]._id_0AA3++;
      }
      break;
    case "attacking":
      if(gettime() < var_0.a._id_0AA7 + 2000) {
        self._id_0AA0[var_1]._id_0AA3++;
      }
      break;
    case "cover":
      if(!var_0 animscripts\battlechatter::_id_0AA8()) {
        self._id_0AA0[var_1]._id_0AA3++;
      }
      break;
  }

  if(self._id_0AA0[var_1]._id_0AA3 > self._id_0AA0[var_1]._id_0AA1 * self._id_0A6B.size) {
    self._id_0AA0[var_1]._id_0AA2 = 1;
  }
}