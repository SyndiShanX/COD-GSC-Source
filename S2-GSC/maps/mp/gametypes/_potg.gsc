/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_potg.gsc
*********************************************/

func_4632() {
  return function_036A() + function_036B() + function_0369();
}

func_578D() {
  if(getdvarint("2653", 0) == 0) {
    return 0;
  }

  return 1;
}

func_2392() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_00 = function_036B() * 1000;
  for(var_01 = 0; var_01 < 40; var_01++) {
    if(maps\mp\_utility::func_44FA() - self.var_75F8[var_01].var_3FD7 > var_00 && self.var_75F8[var_01].var_8CA6 != 0) {
      self.var_75F8[var_01].var_3FD7 = 0;
      self.var_75F8[var_01].var_AA00 = 0;
      self.var_75F8[var_01].var_8CA6 = 0;
      self.var_75F8[var_01].var_1EB5 = undefined;
      self.var_75F8[var_01].victimnum = undefined;
      self.var_75F8[var_01].var_01D0 = "none";
    }
  }
}

func_772C() {
  var_00 = 0;
  if(!function_036C()) {
    return;
  }

  for(var_01 = 0; var_01 < 40; var_01++) {
    if(self.var_75F8[var_01].var_8CA6 == 1 && self.var_75F8[var_01].var_AA00 > 0) {
      var_00 = var_00 + self.var_75F8[var_01].var_AA00;
    }
  }
}

func_772D() {
  if(!function_036C()) {
    return;
  }

  for(var_00 = 0; var_00 < 40; var_00++) {
    if(level.var_74CB[var_00].var_8CA6 == 1 && level.var_74CB[var_00].var_AA00 > 0) {}
  }
}

func_942E(param_00) {
  if(!isDefined(level.var_74CB)) {
    level.var_74CB = [];
    for(var_01 = 0; var_01 < 40; var_01++) {
      level.var_74CB[var_01] = spawnStruct();
      level.var_74CB[var_01].var_3FD7 = 0;
      level.var_74CB[var_01].var_AA00 = 0;
      level.var_74CB[var_01].var_8CA6 = 0;
      level.var_74CB[var_01].var_1EB5 = undefined;
      level.var_74CB[var_01].victimnum = undefined;
      level.var_74CB[var_01].var_01D0 = "none";
      level.var_74CB[var_01].var_A490 = undefined;
    }
  }

  if(isDefined(level.var_74CB)) {
    for(var_01 = 0; var_01 < 40; var_01++) {
      if(self.var_75F8[var_01].var_8CA6 == 1) {
        level.var_74CB[var_01].var_AA00 = self.var_75F8[var_01].var_AA00;
        level.var_74CB[var_01].var_1458 = self.var_75F8[var_01].var_1458;
        level.var_74CB[var_01].var_8CA6 = 1;
        level.var_74CB[var_01].var_3FD7 = self.var_75F8[var_01].var_3FD7;
        level.var_74CB[var_01].var_1EB5 = self.var_75F8[var_01].var_1EB5;
        level.var_74CB[var_01].victimnum = self.var_75F8[var_01].victimnum;
        level.var_74CB[var_01].var_01D0 = self.var_75F8[var_01].var_01D0;
        level.var_74CB[var_01].var_A490 = self.var_75F8[var_01].var_A490;
        continue;
      }

      level.var_74CB[var_01].var_8CA6 = 0;
    }
  }

  level.var_74CC = param_00;
}

func_A155(param_00) {
  if(isDefined(level.var_74CC)) {
    if(level.var_74CC < param_00) {
      func_942E(param_00);
      function_03B6();
      maps\mp\gametypes\_final_killcam::func_7B3B(self, function_0369());
      func_772D();
      return;
    }

    return;
  }

  func_942E(param_00);
  function_03B6();
  maps\mp\gametypes\_final_killcam::func_7B3B(self, function_0369());
  func_772D();
}

func_4633() {
  var_00 = 0;
  var_01 = function_036B() * 1000;
  for(var_02 = 0; var_02 < 40; var_02++) {
    if(self.var_75F8[var_02].var_8CA6 != 0 && maps\mp\_utility::func_44FA() - self.var_75F8[var_02].var_3FD7 <= var_01) {
      var_00 = var_00 + self.var_75F8[var_02].var_AA00;
    }
  }

  return var_00;
}

func_09EE(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.var_75F8)) {
    func_2392();
    for(var_05 = 0; var_05 < 40; var_05++) {
      if(self.var_75F8[var_05].var_8CA6 == 0) {
        self.var_75F8[var_05].var_3FD7 = maps\mp\_utility::func_44FA();
        self.var_75F8[var_05].var_AA00 = param_01;
        self.var_75F8[var_05].var_1458 = param_00;
        self.var_75F8[var_05].var_8CA6 = 1;
        self.var_75F8[var_05].var_1EB5 = param_03;
        self.var_75F8[var_05].victimnum = param_04;
        if(!isDefined(param_02)) {
          param_02 = "none";
        }

        self.var_75F8[var_05].var_01D0 = param_02;
        break;
      }
    }
  }

  func_772C();
  var_06 = func_4633();
  func_A155(var_06);
}

func_4631(param_00) {
  if(!isDefined(param_00) || param_00 == "") {
    return 0;
  }

  var_01 = tablelookup("mp/xp_event_table.csv", 0, param_00, 21);
  if(!isDefined(var_01) || var_01 == "") {
    var_01 = 0;
  }

  return int(var_01);
}

func_4AE2(param_00, param_01, param_02, param_03) {
  if(!func_578D()) {
    return;
  }

  if(!isDefined(param_03)) {
    return;
  }

  var_04 = func_4631(param_00);
  if(var_04 <= 0) {
    var_04 = 0;
  }

  if(!isDefined(self.var_75F8)) {
    self.var_75F8 = [];
    for(var_05 = 0; var_05 < 40; var_05++) {
      self.var_75F8[var_05] = spawnStruct();
      self.var_75F8[var_05].var_3FD7 = 0;
      self.var_75F8[var_05].var_AA00 = 0;
      self.var_75F8[var_05].var_8CA6 = 0;
      self.var_75F8[var_05].var_1EB5 = undefined;
      self.var_75F8[var_05].victimnum = undefined;
      self.var_75F8[var_05].var_01D0 = "none";
    }
  }

  if(isDefined(self.var_75F8)) {
    func_2392();
    var_05 = 0;
    while(var_05 < 40) {
      if(self.var_75F8[var_05].var_8CA6 == 0) {
        self.var_75F8[var_05].var_3FD7 = maps\mp\_utility::func_44FA();
        self.var_75F8[var_05].var_AA00 = var_04;
        self.var_75F8[var_05].var_1458 = param_00;
        self.var_75F8[var_05].var_8CA6 = 1;
        if(isDefined(param_02)) {
          self.var_75F8[var_05].var_A490 = param_02;
        }

        if(!isDefined(self.var_75F8[var_05].var_1EB5) && isDefined(param_02) && isDefined(param_01)) {
          var_06 = param_02 maps\mp\gametypes\_damage::func_452F(self, param_03, param_01);
          if(isDefined(var_06)) {
            self.var_75F8[var_05].var_1EB5 = var_06 getentitynumber();
            self.var_75F8[var_05].victimnum = param_02 getentitynumber();
          } else {
            self.var_75F8[var_05].var_1EB5 = self getentitynumber();
          }
        } else {
          self.var_75F8[var_06].var_1EB5 = self getentitynumber();
        }

        if(!isDefined(param_02)) {
          param_02 = "none";
        }

        self.var_75F8[var_06].var_01D0 = param_02;
        if(maps\mp\_events::iskillevent(self.var_75F8[var_06].var_1458) && self.var_75F8[getlastkillplay(var_06)].var_01D0 != param_02) {
          func_09EE("POTG_weapon_Swap", func_4631("POTG_weapon_Swap"), "none", undefined, undefined);
        }

        break;
      }

      var_06++;
    }
  }

  var_07 = func_4633();
  func_A155(var_07);
  if(var_07 > 0) {
    func_772C();
  }
}

getlastkillplay(param_00) {
  var_01 = 0;
  var_02 = param_00;
  for(var_03 = 0; var_03 < 40; var_03++) {
    if(self.var_75F8[var_03].var_8CA6 == 1 && maps\mp\_events::iskillevent(self.var_75F8[var_03].var_1458) && var_03 != param_00) {
      if(self.var_75F8[var_03].var_3FD7 > var_01 && self.var_75F8[var_03].var_3FD7 < self.var_75F8[param_00].var_3FD7) {
        var_02 = var_03;
      }
    }
  }

  return var_02;
}

func_2407(param_00) {
  level endon("cancel_previous_delayed_recording");
  var_01 = param_00 getentitynumber();
  param_00 waittill("disconnect");
  if(level.var_74CA == var_01) {
    level.var_74CA = -1;
    level.playofthegameentity = undefined;
    level.var_74CC = undefined;
    level.var_74CB = undefined;
  }
}