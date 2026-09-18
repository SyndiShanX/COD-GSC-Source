/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1331.gsc
*********************************************/

func_7BCE(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_52BC = param_01;
  var_04.var_6AF7 = param_02;
  var_04.var_6AED = param_03;
  level.var_7ED0[param_00] = var_04;
}

func_7BA6() {
  func_7BCE("role_ability_adrenaline_shot_mp", ::lib_052E::init, ::lib_052E::func_3662, ::lib_052E::func_2F9E);
  func_7BCE("role_ability_steel_bib_mp", ::lib_0535::init, ::lib_0535::func_3662, ::lib_0535::func_2F9E);
  func_7BCE("role_ability_extreme_conditioning_mp", ::lib_0531::init, ::lib_0531::func_3662, ::lib_0531::func_2F9E);
  func_7BCE("role_ability_doron_vest_mp", ::lib_0530::init, ::lib_0530::func_3662, ::lib_0530::func_2F9E);
  func_7BCE("role_ability_combat_focus_mp", ::lib_052F::init, ::lib_052F::func_3662, ::lib_052F::func_2F9E);
  func_7BCE("role_ability_undercover_mp", ::lib_0536::init, ::lib_0536::func_3662, ::lib_0536::func_2F9E);
  func_7BCE("role_ability_misinformation_mp", ::lib_0532::init, ::lib_0532::func_3662, ::lib_0532::func_2F9E);
  func_7BCE("role_ability_self_revive_mp", ::lib_0534::init, ::lib_0534::func_3662, ::lib_0534::func_2F9E);
}

init() {
  self.var_7ED1 = [];
  level.var_7ED0 = [];
  if(isDefined(level.var_7BF5)) {
    level[[level.var_7BF5]]();
  } else {
    func_7BA6();
  }

  foreach(var_01 in level.var_7ED0) {
    level thread[[var_01.var_52BC]]();
  }

  level thread onplayerconnect();
  setdvarifuninitialized("rolePowerGainOnDeathShouldCheckWasActive", 0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!maps\mp\_utility::func_585F()) {
      if(!isDefined(var_00.pers["roleRespawnPower"])) {
        var_00.pers["roleRespawnPower"] = 0;
      }
    }

    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned");
    self.var_7ED1["activeOnDeath"] = 0;
    func_7DF5();
    if(getdvarint("1936")) {
      thread func_6B7A();
      thread onplayerdeath();
      thread func_6B98();
      thread func_6B76();
    }
  }
}

func_6B7A() {
  self endon("disconnect");
  self endon("spawned");
  self waittill("joined_team");
  func_7D6B();
}

onplayerdeath() {
  self endon("disconnect");
  self endon("spawned");
  self waittill("death");
  var_00 = self rolecheckstate("active");
  self.var_7ED1["activeOnDeath"] = var_00;
  self roleondeath();
  func_942F();
}

func_6B76() {
  self endon("disconnect");
  self endon("spawned");
  self endon("death ");
  var_00 = self rolecheckstate("ready");
  if(var_00) {
    return;
  }

  for(;;) {
    var_01 = self rolecheckstate("ready");
    var_02 = self rolecheckstate("active");
    if(!var_00 && var_01 || var_02) {
      if(maps\mp\_utility::func_585F()) {
        lib_0378::func_8D74("role_ready");
      } else {
        self method_860F("ks_earn_dna_bomb", self, 1);
      }

      return;
    } else {
      wait 0.05;
    }
  }
}

func_6B98() {
  self endon("disconnect");
  self endon("spawned");
  level waittill("game_ended");
  if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround()) {
    var_00 = self rolecheckstate("active");
    self.var_7ED1["activeOnDeath"] = var_00;
    self roleondeath();
    func_942F();
  }
}

func_3662(param_00) {
  if(!getdvarint("1936")) {
    return;
  }

  if(isDefined(self.var_7ED1) && isDefined(self.var_7ED1[param_00]) && self.var_7ED1[param_00] == 1) {
    func_2F9E(param_00);
    return;
  }

  var_01 = level.var_7ED0[param_00];
  if(isDefined(var_01)) {
    self thread[[var_01.var_6AF7]]();
  } else {
    return;
  }

  self.var_7ED1[param_00] = 1;
  thread func_2F94(param_00);
}

func_2F9E(param_00) {
  if(!getdvarint("1936")) {
    return;
  }

  self notify("DisabledRoleAbility");
  self notify("DisabledRoleAbility_" + param_00);
  var_01 = level.var_7ED0[param_00];
  if(isDefined(var_01)) {
    self thread[[var_01.var_6AED]]();
  } else {
    return;
  }

  if(maps\mp\_utility::func_585F()) {
    var_02 = self getentitynumber();
    function_0327(&"activate_special_teammate", 3, var_02, param_00, 0);
  }

  self.var_7ED1[param_00] = 0;
  func_2408();
}

func_2F94(param_00) {
  level endon("game_ended");
  self endon("DisabledRoleAbility");
  common_scripts\utility::waittill_any("death", "disconnect", "joined_team", "joined_spectators");
  func_2F9E(param_00);
}

func_2408() {
  self roleapplypowerchange(-1);
}

func_0F37(param_00, param_01, param_02) {
  if(isDefined(self.powerbuffamount)) {
    param_00 = param_00 * self.powerbuffamount;
  }

  if(param_00 > 0 && param_00 < 1 && isDefined(level._zmb_roles_positive_power_multiplier)) {
    param_00 = param_00 * level._zmb_roles_positive_power_multiplier;
  }

  if(!getdvarint("1936")) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(self.sessionstate == "dead") {
    if(isDefined(self.pers["roleRespawnPower"])) {
      var_03 = getdvarint("rolePowerGainOnDeathShouldCheckWasActive") == 1;
      if(var_03) {
        if(isDefined(self.var_7ED1["activeOnDeath"])) {
          var_04 = self.var_7ED1["activeOnDeath"];
          if(!var_04) {
            self.pers["roleRespawnPower"] = self.pers["roleRespawnPower"] + param_00;
            self roleapplypowerchange(param_00, param_01);
            return;
          }

          return;
        }

        return;
      }

      self.pers["roleRespawnPower"] = self.pers["roleRespawnPower"] + param_01;
      self roleapplypowerchange(param_01, param_02);
      return;
    }

    return;
  }

  var_05 = self rolecheckstate("active");
  if(!var_05 || var_04) {
    self roleapplypowerchange(param_02, var_03);
  }
}

func_3F90() {
  if(!maps\mp\_utility::func_585F()) {
    func_0F37(0.07);
  }
}

func_6BCF(param_00) {
  if(!maps\mp\_utility::func_585F()) {
    func_0F37(0.0425);
  }
}

func_942F() {
  var_00 = self rolegetpower();
  if(isDefined(self.pers["roleRespawnPower"])) {
    self.pers["roleRespawnPower"] = var_00;
  }
}

func_7D6B() {
  if(isDefined(self.pers["roleRespawnPower"])) {
    self.pers["roleRespawnPower"] = 0;
  }
}

func_7DF5() {
  if(isDefined(self.pers["roleRespawnPower"])) {
    self roleapplypowerchange(self.pers["roleRespawnPower"]);
  }
}