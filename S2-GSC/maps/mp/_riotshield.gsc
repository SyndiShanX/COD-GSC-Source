/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_riotshield.gsc
*********************************************/

func_00D5() {
  level.var_7E95 = [];
  level.var_7E95[level.var_7E95.size] = "riotshield_mp";
}

func_4B8C() {
  return isDefined(self.var_3EF6) || isDefined(self.var_14EA);
}

func_4B8D() {
  return isDefined(self.var_3EF6);
}

func_A9C9(param_00) {
  if(!isDefined(level.var_7E95)) {
    return 0;
  }

  var_01 = getweapondisplayname(param_00);
  if(!isDefined(var_01)) {
    var_01 = param_00;
  }

  foreach(var_03 in level.var_7E95) {
    if(var_03 == var_01) {
      return 1;
    }
  }

  return 0;
}

func_45DD(param_00) {
  var_01 = 0;
  var_02 = self getweaponslistprimaries();
  foreach(var_04 in var_02) {
    if(func_A9C9(var_04)) {
      if(var_04 == param_00 && !var_01) {
        var_01 = 1;
        continue;
      }

      return var_04;
    }
  }

  return undefined;
}

func_A118(param_00, param_01) {
  self.var_3EF6 = undefined;
  self.var_14EA = undefined;
  if(!isDefined(param_00)) {
    param_00 = self getcurrentprimaryweapon();
  }

  if(func_A9C9(param_00)) {
    self.var_3EF6 = getweaponmodel(param_00);
    if(isDefined(self.riotshield_backpack) && self.var_267E[3] == 0) {
      self.var_267E[3] = self.riotshield_backpack;
      self setcostumemodels(self.var_267E, self.var_01A7, 1);
      self.riotshield_backpack = undefined;
    }
  }

  var_02 = func_45DD(param_00);
  if(isDefined(var_02)) {
    self.var_14EA = getweaponmodel(var_02);
    if(!isDefined(self.riotshield_backpack) && self.var_267E[3] != 0) {
      self.riotshield_backpack = self.var_267E[3];
    }

    if(isDefined(self.riotshield_backpack) && self.var_267E[3] != 0) {
      self.var_267E[3] = 0;
      self setcostumemodels(self.var_267E, self.var_01A7, 1);
    }
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  self method_84D2(param_00, param_01);
}

func_7E96() {
  self.var_3EF6 = undefined;
  self.var_14EA = undefined;
  self.riotshield_backpack = undefined;
}

func_37C2() {
  if(!self islinked()) {
    return 0;
  }

  var_00 = self method_852C();
  if(!isDefined(var_00)) {
    return 0;
  }

  switch (var_00) {
    case "tag_inhand":
    case "tag_shield_back":
      return 1;
  }

  return 0;
}

func_7E99() {
  if(function_0367() && getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_00 = undefined;
  self waittill("weapon_change", var_00);
  self notify("riotshield_change_weapon", var_00);
}

func_7E9B() {
  if(function_0367() && getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_00 = undefined;
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(self method_801D()) {
      thread func_7E9A();
      break;
    }

    if(isDefined(self.var_3EF6) && isDefined(self.var_14EA)) {
      wait(0.5);
      break;
    }
  }

  self notify("riotshield_change_weapon", var_00);
}

func_7E9A() {
  if(function_0367()) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");
  while(self method_801D()) {
    wait 0.05;
  }

  self notify("riotshield_change_weapon", self getcurrentprimaryweapon());
}

func_9BC6() {
  if(function_0367()) {
    if(getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
      return;
    }

    if(common_scripts\utility::func_562E(self.activeshieldthread)) {
      return;
    }

    self.activeshieldthread = 1;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("track_riot_shield");
  self endon("track_riot_shield");
  var_00 = 0;
  if(common_scripts\utility::func_562E(self.hideshieldmodels)) {
    var_00 = 1;
  }

  func_A118(self.var_2954, var_00);
  if(!func_4B8C()) {
    if(function_0367()) {
      self.activeshieldthread = 0;
    }

    return;
  }

  self.var_5BC4 = "none";
  for(;;) {
    var_01 = self getcurrentweapon();
    thread func_7E99();
    thread func_7E9B();
    self waittill("riotshield_change_weapon", var_02);
    var_03 = 0;
    if(common_scripts\utility::func_562E(self.hideshieldmodels)) {
      var_03 = 1;
    }

    if(func_A9C9(var_02)) {
      if(func_4B8C()) {
        if(isDefined(self.var_7EA3)) {
          self takeweapon(self.var_7EA3);
          self.var_7EA3 = undefined;
        }
      }

      if(func_5832(var_01)) {
        self.var_5BC4 = var_01;
      }
    } else if(issubstr(var_02, "killstreak_uav") || issubstr(var_02, "super_soldier_syrum")) {
      continue;
    }

    func_A15C(var_02, var_03);
  }
}

func_A15C(param_00, param_01) {
  if(self method_82E4() && param_00 == "none") {
    return;
  }

  func_A118(param_00, param_01);
}

func_5832(param_00) {
  if(maps\mp\_utility::func_5740(param_00)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  if(maps\mp\gametypes\_class::func_5826(param_00, 1) || maps\mp\gametypes\_class::func_5826(param_00, 0)) {
    return 0;
  }

  if(func_A9C9(param_00)) {
    return 0;
  }

  if(function_01AA(param_00) == "ball") {
    return 0;
  }

  return 1;
}

func_A93C(param_00, param_01) {
  param_00 endon("death");
  common_scripts\utility::func_A70A("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");
  param_00 method_81D6(param_01);
}