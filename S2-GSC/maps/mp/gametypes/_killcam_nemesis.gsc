/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam_nemesis.gsc
**************************************************/

init() {
  setdvarifuninitialized("nemesis_limitToFirst", 1);
  if(!isDefined(self.pers["killcam"])) {
    self.pers["killcam"] = [];
    self.pers["killcam"]["IsNemesis"] = 0;
    self.pers["killcam"]["killsOfCount"] = [];
    self.pers["killcam"]["killsByCount"] = [];
    self.pers["killcam"]["killsByTopCount"] = 1;
    if(getdvarint("nemesis_limitToFirst") == 1) {
      self.pers["killcam"]["current"] = "";
    }
  }
}

func_575A(param_00) {
  if(isDefined(self.pers["killcam"]["killsByCount"][param_00])) {
    if(self.pers["killcam"]["killsByCount"][param_00] >= self.pers["killcam"]["killsByTopCount"]) {
      if(getdvarint("nemesis_limitToFirst") == 1) {
        return self.pers["killcam"]["current"] == param_00;
      }

      return 1;
    }
  }

  return 0;
}

func_5A3F(param_00) {
  self notify("increment_nemesis_kills");
}

func_A13D(param_00) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }

  if(isDefined(self.pers["killcam"]["killsByCount"][param_00])) {
    var_01 = self.pers["killcam"]["killsByCount"][param_00];
    var_02 = self.pers["killcam"]["killsByTopCount"];
    if(var_01 > var_02) {
      if(getdvarint("nemesis_limitToFirst") == 1) {
        self.pers["killcam"]["current"] = param_00;
      }

      self.pers["killcam"]["killsByTopCount"] = var_01;
      self.pers["killcam"]["IsNemesis"] = 1;
      return;
    }

    if(var_01 == var_02) {
      self.pers["killcam"]["IsNemesis"] = getdvarint("nemesis_limitToFirst") != 1;
      return;
    }
  }
}

func_A13E(param_00) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }

  self.pers["killcam"]["IsNemesis"] = 0;
  var_01 = param_00.name;
  var_02 = maps\mp\gametypes\_damage::isfriendlyfire(self, param_00);
  if(!var_02) {
    func_A13D(var_01);
  }

  self setclientomnvar("ui_killcam_killsOfPlayer", self.pers["killcam"]["killsOfCount"][var_01]);
  self setclientomnvar("ui_killcam_killsByPlayer", self.pers["killcam"]["killsByCount"][var_01]);
  self setclientomnvar("ui_killcam_isFriendlyFire", var_02);
  self setclientomnvar("ui_killcam_isNemesis", self.pers["killcam"]["IsNemesis"]);
}

func_A128(param_00, param_01) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }

  if(self == param_00) {
    var_02 = param_01.name;
    if(var_02 != "") {
      if(!isDefined(self.pers["killcam"]["killsOfCount"][var_02])) {
        self.pers["killcam"]["killsOfCount"][var_02] = 0;
      }

      self.pers["killcam"]["killsOfCount"][var_02] = self.pers["killcam"]["killsOfCount"][var_02] + 1;
    }

    if(func_575A(var_02)) {
      func_5A3F(param_01);
      return;
    }

    return;
  }

  if(self == param_01) {
    var_03 = param_00.name;
    if(var_03 != "") {
      if(!isDefined(self.pers["killcam"]["killsByCount"][var_03])) {
        self.pers["killcam"]["killsByCount"][var_03] = 0;
      }

      self.pers["killcam"]["killsByCount"][var_03] = self.pers["killcam"]["killsByCount"][var_03] + 1;
      if(!isDefined(self.pers["killcam"]["killsOfCount"][var_03])) {
        self.pers["killcam"]["killsOfCount"][var_03] = 0;
      }
    }

    func_A13E(param_00);
  }
}

func_45A3(param_00) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }

  foreach(var_03, var_02 in self.pers["killcam"]["killsByCount"]) {
    func_A13D(var_03);
  }
}

func_2405(param_00) {
  if(!isDefined(self.pers["killcam"])) {
    return;
  }

  var_01 = func_575A(param_00.name);
  self.pers["killcam"]["killsByCount"][param_00.name] = undefined;
  self.pers["killcam"]["killsOfCount"][param_00.name] = undefined;
  if(var_01) {
    self.pers["killcam"]["current"] = "";
    self.pers["killcam"]["killsByTopCount"] = 1;
    func_45A3();
  }
}

func_4AFB(param_00, param_01) {
  if(param_00 != "spectator" && param_00 != param_01) {
    foreach(var_03 in level.players) {
      if(var_03 == self) {
        continue;
      }

      if(var_03.team != param_00) {
        var_03 func_2405(self);
        func_2405(var_03);
      }
    }
  }
}

func_4AB9() {
  foreach(var_01 in level.players) {
    if(var_01 == self) {
      continue;
    }

    var_01 func_2405(self);
  }

  self.pers["killcam"] = undefined;
}