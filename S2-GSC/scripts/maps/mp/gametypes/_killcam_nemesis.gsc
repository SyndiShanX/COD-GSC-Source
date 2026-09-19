/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_killcam_nemesis.gsc
**********************************************************/

init() {
  setdvarifuninitialized("nemesis_limitToFirst", 1);

  if(!isDefined(self.pers["killcam"])) {
    self.pers["killcam"] = [];
    self.pers["killcam"]["IsNemesis"] = 0;
    self.pers["killcam"]["killsOfCount"] = [];
    self.pers["killcam"]["killsByCount"] = [];
    self.pers["killcam"]["killsByTopCount"] = 1;

    if(getdvarint("nemesis_limitToFirst") == 1)
      self.pers["killcam"]["current"] = "";
  }
}

_id_575A(var_0) {
  if(isDefined(self.pers["killcam"]["killsByCount"][var_0])) {
    if(self.pers["killcam"]["killsByCount"][var_0] >= self.pers["killcam"]["killsByTopCount"]) {
      if(getdvarint("nemesis_limitToFirst") == 1)
        return self.pers["killcam"]["current"] == var_0;

      return 1;
    }
  }

  return 0;
}

_id_5A3F(var_0) {
  self notify("increment_nemesis_kills");
}

_id_A13D(var_0) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }
  if(isDefined(self.pers["killcam"]["killsByCount"][var_0])) {
    var_1 = self.pers["killcam"]["killsByCount"][var_0];
    var_2 = self.pers["killcam"]["killsByTopCount"];

    if(var_1 > var_2) {
      if(getdvarint("nemesis_limitToFirst") == 1)
        self.pers["killcam"]["current"] = var_0;

      self.pers["killcam"]["killsByTopCount"] = var_1;
      self.pers["killcam"]["IsNemesis"] = 1;
    } else if(var_1 == var_2)
      self.pers["killcam"]["IsNemesis"] = getdvarint("nemesis_limitToFirst") != 1;
  }
}

_id_A13E(var_0) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }
  self.pers["killcam"]["IsNemesis"] = 0;
  var_1 = var_0.name;
  var_2 = maps\mp\gametypes\_damage::_id_56FA(self, var_0);

  if(!var_2)
    _id_A13D(var_1);

  self setclientomnvar("ui_killcam_killsOfPlayer", self.pers["killcam"]["killsOfCount"][var_1]);
  self setclientomnvar("ui_killcam_killsByPlayer", self.pers["killcam"]["killsByCount"][var_1]);
  self setclientomnvar("ui_killcam_isFriendlyFire", var_2);
  self setclientomnvar("ui_killcam_isNemesis", self.pers["killcam"]["IsNemesis"]);
}

_id_A128(var_0, var_1) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }
  if(self == var_0) {
    var_2 = var_1.name;

    if(var_2 != "") {
      if(!isDefined(self.pers["killcam"]["killsOfCount"][var_2]))
        self.pers["killcam"]["killsOfCount"][var_2] = 0;

      self.pers["killcam"]["killsOfCount"][var_2] = self.pers["killcam"]["killsOfCount"][var_2] + 1;
    }

    if(_id_575A(var_2)) {
      _id_5A3F(var_1);
      return;
    }
  } else if(self == var_1) {
    var_3 = var_0.name;

    if(var_3 != "") {
      if(!isDefined(self.pers["killcam"]["killsByCount"][var_3]))
        self.pers["killcam"]["killsByCount"][var_3] = 0;

      self.pers["killcam"]["killsByCount"][var_3] = self.pers["killcam"]["killsByCount"][var_3] + 1;

      if(!isDefined(self.pers["killcam"]["killsOfCount"][var_3]))
        self.pers["killcam"]["killsOfCount"][var_3] = 0;
    }

    _id_A13E(var_0);
  }
}

_id_45A3(var_0) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }
  foreach(var_3, var_2 in self.pers["killcam"]["killsByCount"])
  _id_A13D(var_3);
}

_id_2405(var_0) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }
  var_1 = _id_575A(var_0.name);
  self.pers["killcam"]["killsByCount"][var_0.name] = undefined;
  self.pers["killcam"]["killsOfCount"][var_0.name] = undefined;

  if(var_1) {
    self.pers["killcam"]["current"] = "";
    self.pers["killcam"]["killsByTopCount"] = 1;
    _id_45A3();
  }
}

_id_4AFB(var_0, var_1) {
  if(var_0 != "spectator" && var_0 != var_1) {
    foreach(var_3 in level.players) {
      if(var_3 == self) {
        continue;
      }
      if(var_3.team != var_0) {
        var_3 _id_2405(self);
        _id_2405(var_3);
      }
    }
  }
}

_id_4AB9() {
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    var_1 _id_2405(self);
  }

  self.pers["killcam"] = undefined;
}