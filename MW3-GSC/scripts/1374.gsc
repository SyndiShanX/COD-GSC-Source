/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1374.gsc
**************************************/

_id_4219() {
  _id_4232();
  thread _id_421A();
}

_id_421A() {
  self endon("death");
  self endon("pain_death");
  var_0 = self._id_0B6E._id_41ED._id_421B;

  if(isplayer(self)) {
    thread _id_4229();

  }
  for(;;) {
    maps\_utility::_id_1654("_stealth_enabled");
    self[[var_0]]();
    self.maxvisibledist = _id_421F();
    wait 0.05;
  }
}

_id_421C() {
  return length(self getvelocity());
}

_id_421D() {
  var_0 = length(self getvelocity());
  var_1 = self._id_0B6E._id_41ED.stance;
  var_2 = [];
  var_2["stand"] = 30;
  var_2["crouch"] = 15;
  var_2["prone"] = 4;
  var_3 = [];
  var_3["stand"] = 40;
  var_3["crouch"] = 25;
  var_3["prone"] = 10;

  if(!var_0) {
    self._id_0B6E._id_41ED._id_421E = 0;
  } else if(var_0 > self._id_0B6E._id_41ED._id_421E) {
    self._id_0B6E._id_41ED._id_421E = self._id_0B6E._id_41ED._id_421E + var_2[var_1];

    if(self._id_0B6E._id_41ED._id_421E > var_0) {
      self._id_0B6E._id_41ED._id_421E = var_0;
    }
  } else if(var_0 < self._id_0B6E._id_41ED._id_421E) {
    self._id_0B6E._id_41ED._id_421E = self._id_0B6E._id_41ED._id_421E - var_3[var_1];

    if(self._id_0B6E._id_41ED._id_421E < 0) {
      self._id_0B6E._id_41ED._id_421E = 0;
    }
  }

  return self._id_0B6E._id_41ED._id_421E;
}

_id_421F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self._id_0B6E._id_41ED.stance;

  }
  if(var_0 == "back") {
    var_0 = "prone";

  }
  var_1 = level._id_0B6E._id_41ED._id_4220;
  var_2 = level._id_0B6E._id_41ED._id_4221[var_1][var_0];

  if(maps\_utility::_id_1008("_stealth_in_shadow")) {
    var_2 = var_2 * 0.5;

    if(var_2 < level._id_0B6E._id_41ED._id_4221["hidden"]["prone"]) {
      var_2 = level._id_0B6E._id_41ED._id_4221["hidden"]["prone"];
    }
  }

  var_3 = self._id_0B6E._id_41ED._id_4222[var_1][var_0];

  if(isDefined(self._id_4223) && var_3 > self._id_4223) {
    var_3 = self._id_4223;

  }
  return var_2 + var_3;
}

_id_4224() {
  return self.a._id_0D26;
}

_id_4225() {
  return self.angles;
}

_id_4226() {
  self._id_0B6E._id_41ED.stance = self[[self._id_0B6E._id_41ED._id_4227]]();
  self._id_0B6E._id_41ED._id_4228 = self._id_0B6E._id_41ED.stance;
}

_id_4229() {
  self endon("death");
  self endon("pain_death");
  var_0 = self._id_0B6E._id_41ED._id_422A;
  var_1 = self._id_0B6E._id_41ED._id_422B;
  var_2 = self[[var_0]]();

  for(;;) {
    maps\_utility::_id_1654("_stealth_enabled");
    var_3 = undefined;

    if(maps\_utility::_id_1008("_stealth_in_shadow")) {
      var_3 = 0;
    } else {
      var_3 = self[[var_1]]();

    }
    foreach(var_9, var_5 in self._id_0B6E._id_41ED._id_4222) {
      foreach(var_8, var_7 in var_5) {}
      var_7 = var_3 * self._id_0B6E._id_41ED._id_422C[var_9][var_8];
    }

    var_2 = self[[var_0]]();
    wait 0.1;
  }
}

_id_422D() {
  return self getstance();
}

_id_422E() {
  return self getplayerangles();
}

_id_422F() {
  var_0 = self[[self._id_0B6E._id_41ED._id_4227]]();

  if(!self._id_0B6E._id_41ED._id_4230) {
    switch (var_0) {
      case "prone":
        if(self._id_0B6E._id_41ED._id_4228 != "prone") {
          self._id_0B6E._id_41ED._id_4230 = self._id_0B6E._id_41ED._id_4231;

        }
        break;
      case "crouch":
        if(self._id_0B6E._id_41ED._id_4228 == "stand") {
          self._id_0B6E._id_41ED._id_4230 = self._id_0B6E._id_41ED._id_4231;

        }
        break;
    }
  }

  if(self._id_0B6E._id_41ED._id_4230) {
    self._id_0B6E._id_41ED.stance = self._id_0B6E._id_41ED._id_4228;

    if(self._id_0B6E._id_41ED._id_4230 > 0.05) {
      self._id_0B6E._id_41ED._id_4230 = self._id_0B6E._id_41ED._id_4230 - 0.05;
    } else {
      self._id_0B6E._id_41ED._id_4230 = 0;
      self._id_0B6E._id_41ED.stance = var_0;
      self._id_0B6E._id_41ED._id_4228 = var_0;
    }
  } else {
    self._id_0B6E._id_41ED.stance = var_0;
    self._id_0B6E._id_41ED._id_4228 = var_0;
  }
}

_id_4232() {
  maps\_utility::_id_1402("_stealth_in_shadow");
  maps\_utility::_id_1402("_stealth_enabled");
  maps\_utility::_id_13DC("_stealth_enabled");
  self._id_0B6E = spawnStruct();
  self._id_0B6E._id_41ED = spawnStruct();

  if(isplayer(self)) {
    self._id_0B6E._id_41ED._id_4227 = ::_id_422D;
    self._id_0B6E._id_41ED._id_422A = ::_id_422E;

    if(level.console) {
      self._id_0B6E._id_41ED._id_422B = ::_id_421C;
    } else {
      self._id_0B6E._id_41ED._id_422B = ::_id_421D;
      self._id_0B6E._id_41ED._id_421E = 0;
    }

    self._id_0B6E._id_41ED._id_421B = ::_id_422F;
  } else {
    self._id_0B6E._id_41ED._id_4227 = ::_id_4224;
    self._id_0B6E._id_41ED._id_422A = ::_id_4225;
    self._id_0B6E._id_41ED._id_422B = ::_id_421C;
    self._id_0B6E._id_41ED._id_421B = ::_id_4226;
  }

  self._id_0B6E._id_41ED._id_4231 = 0.2;
  self._id_0B6E._id_41ED._id_4230 = 0;
  self._id_0B6E._id_41ED._id_4228 = self[[self._id_0B6E._id_41ED._id_4227]]();
  self._id_0B6E._id_41ED.stance = self[[self._id_0B6E._id_41ED._id_4227]]();
  self._id_0B6E._id_41ED._id_41EE = [];
  self._id_0B6E._id_41ED._id_4222 = [];
  self._id_0B6E._id_41ED._id_422C = [];
  self._id_0B6E._id_41ED._id_4222["hidden"] = [];
  self._id_0B6E._id_41ED._id_4222["hidden"]["prone"] = 0;
  self._id_0B6E._id_41ED._id_4222["hidden"]["crouch"] = 0;
  self._id_0B6E._id_41ED._id_4222["hidden"]["stand"] = 0;
  self._id_0B6E._id_41ED._id_4222["spotted"] = [];
  self._id_0B6E._id_41ED._id_4222["spotted"]["prone"] = 0;
  self._id_0B6E._id_41ED._id_4222["spotted"]["crouch"] = 0;
  self._id_0B6E._id_41ED._id_4222["spotted"]["stand"] = 0;
  _id_4233();
}

_id_4233() {
  var_0 = [];
  var_0["prone"] = 3;
  var_0["crouch"] = 2;
  var_0["stand"] = 2;
  var_1 = [];
  var_1["prone"] = 2;
  var_1["crouch"] = 2;
  var_1["stand"] = 2;
  _id_4234(var_0, var_1);
}

_id_4234(var_0, var_1) {
  if(isDefined(var_0)) {
    self._id_0B6E._id_41ED._id_422C["hidden"]["prone"] = var_0["prone"];
    self._id_0B6E._id_41ED._id_422C["hidden"]["crouch"] = var_0["crouch"];
    self._id_0B6E._id_41ED._id_422C["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    self._id_0B6E._id_41ED._id_422C["spotted"]["prone"] = var_1["prone"];
    self._id_0B6E._id_41ED._id_422C["spotted"]["crouch"] = var_1["crouch"];
    self._id_0B6E._id_41ED._id_422C["spotted"]["stand"] = var_1["stand"];
  }
}