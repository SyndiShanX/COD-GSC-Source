/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_killstreaks.gsc
************************************************/

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.var_012C["killstreaks"])) {
      var_00.var_012C["killstreaks"] = [];
    }

    if(!isDefined(var_00.var_012C["kID"])) {
      var_00.var_012C["kID"] = 10;
    }

    var_00.var_28D1 = 0;
    var_00.var_9133 = 0;
    if(getdvarint("4017", 0)) {
      return;
    }

    var_00 thread func_6B82();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    common_scripts\utility::func_A70A("spawned_player", "faux_spawn");
    thread func_5A7B();
    thread func_944D();
    thread func_A698();
    thread func_9450();
    thread func_944F();
    if(!level.var_258F) {
      thread func_6F34();
    }

    if(!isDefined(self.var_012C["killstreaks"][0])) {
      func_5333();
    }

    if(!isDefined(self.var_012C["killstreak_stowed_ammo"])) {
      self.var_012C["killstreak_stowed_ammo"] = [];
      thread func_2385();
    }

    if(!isDefined(self.var_353B)) {
      self.var_353B = 0;
    }

    if(!isDefined(self.var_0A06) || self.var_0A06 == 0) {
      self.var_0A06 = self.var_012C["ks_totalPoints"];
      self.var_0A0D = self.var_012C["ks_totalPointsSupport"];
      func_A16E();
      for(var_00 = 0; var_00 < 5; var_00++) {
        if(!isDefined(self.var_012C["killstreaks"][var_00])) {
          continue;
        }

        var_01 = self.var_012C["killstreaks"][var_00].var_944C;
        var_02 = self.var_012C["killstreaks"][var_00].var_13AF;
        if(isDefined(var_01)) {
          if(var_00 == 0 && !isDefined(var_02) || !var_02) {
            continue;
          }

          var_03 = maps\mp\_utility::func_453F(self.var_012C["killstreaks"][var_00].var_944C);
          var_04 = "ks_icon" + common_scripts\utility::func_9AAD(var_00);
          self setclientomnvar(var_04, var_03);
        }
      }

      func_A16F(0);
    }

    func_A170();
    func_47A1();
    func_A16E();
  }
}

func_A16F(param_00) {
  for(var_01 = 0; var_01 < 5; var_01++) {
    if(!param_00 && var_01 == 0) {
      continue;
    }

    var_02 = "ks_icon" + common_scripts\utility::func_9AAD(var_01);
    self setclientomnvar(var_02, 0);
    var_03 = self getclientomnvar("ks_hasStreak");
    var_04 = var_03 &~1 << var_01 &~1 << var_01 + 5;
    self setclientomnvar("ks_hasStreak", var_04);
  }

  var_05 = 1;
  if(isDefined(self.var_5A71)) {
    foreach(var_07 in self.var_5A71) {
      var_08 = self.var_012C["killstreaks"][var_05];
      var_08.var_944C = var_07;
      var_09 = var_08.var_944C;
      var_02 = "ks_icon" + common_scripts\utility::func_9AAD(var_05);
      self setclientomnvar(var_02, maps\mp\_utility::func_453F(var_09));
      var_03 = self getclientomnvar("ks_hasStreak");
      var_04 = var_03 &~1 << var_05;
      if(func_57F0(self, var_07)) {
        var_04 = var_04 | 1 << var_05 + 5;
      } else {
        var_04 = var_04 &~1 << var_05 + 5;
      }

      self setclientomnvar("ks_hasStreak", var_04);
      var_05++;
    }
  }
}

func_5333() {
  var_00 = spawnStruct();
  var_00.var_13AF = 0;
  var_00.var_944C = undefined;
  var_00.var_3539 = 0;
  var_00.var_145C = undefined;
  var_00.var_0117 = undefined;
  var_00.var_59F1 = undefined;
  var_00.var_5CC6 = undefined;
  var_00.var_5703 = 1;
  var_00.var_66CC = undefined;
  self.var_012C["killstreaks"][0] = var_00;
  for(var_01 = 1; var_01 < 5; var_01++) {
    var_02 = spawnStruct();
    var_02.var_13AF = 0;
    var_02.var_944C = undefined;
    var_02.var_3539 = 1;
    var_02.var_145C = 1;
    var_02.var_0117 = undefined;
    var_02.var_59F1 = undefined;
    var_02.var_5CC6 = -1;
    var_02.var_5703 = 0;
    self.var_012C["killstreaks"][var_01] = var_02;
  }

  func_A16F(1);
  self setclientomnvar("ks_selectedIndex", -1);
  var_03 = self getclientomnvar("ks_hasStreak");
  var_04 = var_03 &~32;
  self setclientomnvar("ks_hasStreak", var_04);
}

func_57F0(param_00, param_01) {
  return param_00 maps\mp\_utility::func_0649("specialty_supportstreaks");
}

func_A16E() {
  if(!isDefined(self.var_012C["killstreaks"])) {
    for(var_00 = 1; var_00 < 5; var_00++) {
      self setclientomnvar("ks_count" + common_scripts\utility::func_9AAD(var_00), 0);
    }

    self setclientomnvar("ks_count_updated", 1);
    return;
  }

  for(var_00 = 1; var_00 < 5; var_00++) {
    if(!isDefined(self.var_012C["killstreaks"][var_00])) {
      continue;
    }

    var_01 = self.var_012C["killstreaks"][var_00].var_944C;
    var_02 = "ks_count" + common_scripts\utility::func_9AAD(var_00);
    var_03 = "ks_points" + common_scripts\utility::func_9AAD(var_00);
    if(!isDefined(var_01)) {
      self setclientomnvar(var_02, 0);
      continue;
    }

    if(isDefined(self.var_012C["supportStreaksEarned"]) && isDefined(self.var_012C["supportStreaksEarned"][var_01]) && self.var_012C["supportStreaksEarned"][var_01]) {
      self setclientomnvar(var_03, 0);
      self setclientomnvar(var_02, -1);
      continue;
    }

    var_04 = func_46B4(self.var_012C["killstreaks"][var_00].var_944C);
    if(func_57F0(self, var_01)) {
      var_05 = self.var_0A0D / var_04;
      var_06 = var_04 - self.var_0A0D;
    } else if(var_01 == "basic_training_serum") {
      if(isDefined(self.var_012C["basicTrainingSerumEarnProgress"])) {
        var_05 = self.var_012C["basicTrainingSerumEarnProgress"];
        var_06 = int(100 * 1 - self.var_012C["basicTrainingSerumEarnProgress"]);
      } else {
        var_05 = 0;
        var_06 = 100;
      }
    } else {
      if(var_04 == 0) {
        var_05 = self.var_0A06;
      } else {
        var_05 = self.var_0A06 / var_04;
      }

      var_06 = var_04 - self.var_0A06;
    }

    if(var_05 >= 1) {
      var_05 = 0;
      var_06 = var_04;
    }

    self setclientomnvar(var_03, var_06);
    self setclientomnvar(var_02, var_05);
  }

  self setclientomnvar("ks_count_updated", 1);
}

func_457A(param_00) {
  if(!isDefined(self.var_5A71)) {
    return 0;
  }

  var_01 = 0;
  foreach(var_03 in self.var_5A71) {
    var_04 = func_57F0(self, var_03);
    if((param_00 && !var_04) || !param_00 && var_04) {
      continue;
    }

    var_05 = func_46B4(var_03);
    if(var_05 > var_01) {
      var_01 = var_05;
    }
  }

  return var_01;
}

func_A170() {
  if(!maps\mp\_utility::func_57A0(self)) {
    return;
  }

  var_00 = self.var_012C["killstreaks"];
  var_01 = 0;
  for(var_02 = 0; var_02 < 5; var_02++) {
    if(isDefined(var_00[var_02]) && isDefined(var_00[var_02].var_944C)) {
      var_03 = self getclientomnvar("ks_hasStreak");
      if(var_00[var_02].var_13AF == 1) {
        var_04 = var_03 | 1 << var_02;
      } else {
        var_04 = var_03 &~1 << var_02;
      }

      self setclientomnvar("ks_hasStreak", var_04);
      if(var_00[var_02].var_13AF == 1) {
        var_01++;
      }

      continue;
    }

    var_03 = self getclientomnvar("ks_hasStreak");
    var_04 = var_03 &~1 << var_02;
    self setclientomnvar("ks_hasStreak", var_04);
  }

  if(var_01 == 0) {
    self setclientomnvar("ks_hasStreak", 0);
  }

  if(isDefined(self.var_5A69)) {
    self setclientomnvar("ks_selectedIndex", self.var_5A69);
    return;
  }

  self setclientomnvar("ks_selectedIndex", -1);
}

func_A698() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");
  for(;;) {
    self waittill("joined_team");
    func_2400(1);
  }
}

func_5A7A() {
  var_00 = self.var_012C["killstreaks"];
  var_01 = var_00[self.var_5A69].var_944C;
  var_02 = var_00[self.var_5A69].var_5CC6;
  var_03 = var_00[self.var_5A69].var_3539;
  var_04 = var_00[self.var_5A69].var_145C;
  var_05 = var_00[self.var_5A69].var_59F1;
  var_06 = var_00[self.var_5A69].var_5703;
  var_07 = undefined;
  ~4
  var_08 = undefined;
  var_09 = ["grenade_info_processing", "death", "disconnect", "carepackage_grenade_switch", "CarepackageKillstreakFuncComplete"];
  self.lastusedkillstreakslotindex = self.var_5A69;
  var_0A = undefined;
  var_0B = undefined;
  var_0C = undefined;
  if(self.var_5A69 == 0) {
    var_0B = var_00[0].var_66CC;
  }

  if(!maps\mp\_utility::func_A27A(var_01)) {
    if(maps\mp\_utility::func_3153(var_01)) {
      self setclientomnvar("ui_map_location_selector", -1);
      self.var_8C04 = 1;
    }

    return 0;
  }

  var_0D = 0;
  if(maps\mp\_utility::func_0649("specialty_explosivebullets") && !issubstr(var_01, "explosive_ammo")) {
    var_0D = 1;
  }

  if(level.var_53C7) {
    maps\mp\gametypes\scorestreak_training::func_244D();
  }

  if(issubstr(var_01, "airdrop")) {
    if(!self[[level.var_5A61[var_01]]](var_02, var_05)) {
      return 0;
    }
  } else if(!self[[level.var_5A61[var_01]]](var_02)) {
    return 0;
  }

  if(level.var_53C7) {
    self.var_012C["scorestreaksCalled"]++;
    maps\mp\_utility::func_867B(self.var_012C["scorestreaksCalled"]);
    self.var_012C["score"] = self.var_012C["score"] + 1;
    if(self.var_012C["score"] < -1) {
      self.var_015C = self.var_012C["score"];
    }
  }

  if(var_0D) {
    maps\mp\_utility::func_0735("specialty_explosivebullets");
  }

  if(isDefined(var_0B) && var_01 != var_00[self.var_5A69].var_944C) {
    var_0C = 1;
    var_0A = var_0B;
  }

  var_0E = func_46B4(var_01);
  if(var_01 == "airstrike" || var_01 == "firebomb" || var_01 == "plane_gunner" || var_01 == "paratroopers" || var_01 == "emergency_carepackage" || var_01 == "flak_gun" || var_01 == "attack_dogs" || var_01 == "advanced_uav" || var_01 == "v2_rocket") {
    var_0F = maps\mp\_utility::func_453F(var_01);
    if(var_0F != -1) {
      maps\mp\_utility::func_863E(20, self.var_01A7, self getentitynumber(), var_0F);
    }
  }

  self.lastusedkillstreakindexweapon = self.var_5A69;
  thread func_A129(var_0C, var_0A);
  func_A206(var_01, var_04, self.lastusedkillstreakindexweapon);
  self.lastusedkillstreakindexweapon = undefined;
  return 1;
}

func_A206(param_00, param_01, param_02) {
  if(func_3150(param_00) && isDefined(self.var_012C["killstreak_stowed_ammo"])) {
    var_03 = maps\mp\_utility::func_454A(param_00, self.var_01A7, maps\mp\_utility::func_0649("specialty_improvedstreaks"));
    if(isDefined(var_03) && isDefined(param_02)) {
      if(isDefined(self.var_012C["killstreak_stowed_ammo"][var_03 + param_02])) {
        return;
      }
    }
  }

  if(param_00 == "basic_training_serum") {
    return;
  }

  maps\mp\_utility::func_50EA("killStreaksUsed", 1);
  if(!maps\mp\_utility::func_579B() || param_02 != 0) {
    maps\mp\gametypes\_missions::func_7750("ch_career_streaksinbound");
    lib_0468::func_0A28("scorestreakUsed");
  }

  if(param_00 == "carepackage" || param_00 == "emergency_carepackage") {
    lib_0468::func_0A28("packageUsed");
  }

  if(param_01) {
    thread maps\mp\gametypes\_missions::func_A20F(param_00);
  }

  var_04 = self.var_01A7;
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    var_04 = maps\mp\_utility::func_45DE(var_04);
  }

  var_05 = var_04 + "_friendly_" + param_00 + "_inbound";
  var_06 = var_04 + "_enemy_" + param_00 + "_inbound";
  if(param_00 != "basic_training_serum") {
    if(level.var_984D) {
      if(param_00 == "flamethrower" || param_00 == "molotovs" || param_00 == "raid_ss_serum_a" || param_00 == "raid_ss_serum_b" || param_00 == "raid_ss_serum_c" || param_00 == "raid_superweapon" || param_00 == "raid_tesla_moon") {
        thread maps\mp\_utility::func_5C43(var_05);
      } else {
        thread maps\mp\_utility::func_5C39(var_05, var_04);
      }

      if(func_4540(param_00)) {
        thread maps\mp\_utility::func_5C39(var_06, level.var_6C63[self.var_01A7]);
      }
    } else {
      thread maps\mp\_utility::func_5C43(var_05);
      if(func_4540(param_00)) {
        var_07[0] = self;
        thread maps\mp\_utility::func_5C39(var_06, undefined, undefined, var_07);
      }
    }
  }

  var_08 = "used_" + param_00;
  if(func_4540(param_00)) {
    thread maps\mp\_utility::func_9863(var_08, self);
    return;
  }

  if(level.var_984D) {
    thread maps\mp\_utility::func_9863(var_08, self, self.var_012C["team"]);
  }
}

func_A129(param_00, param_01) {
  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  if(!isDefined(param_00)) {
    self.var_012C["killstreaks"][self.var_5A69].var_13AF = 0;
    if(self.var_5A69 == 0) {
      func_23DD();
    }
  }

  if(isDefined(param_01)) {
    self.var_012C["killstreaks"][param_01] = undefined;
  }

  var_04 = undefined;
  for(var_05 = 0; var_05 < 5; var_05++) {
    var_06 = self.var_012C["killstreaks"][var_05];
    if(isDefined(var_06) && isDefined(var_06.var_944C) && var_06.var_13AF) {
      var_04 = var_05;
    }
  }

  if(isDefined(var_04)) {
    if(level.var_258F || common_scripts\utility::func_55E0()) {
      self.var_5A69 = var_04;
      self.var_012C["lastEarnedStreak"] = self.var_012C["killstreaks"][var_04].var_944C;
      func_47BA(var_04);
    } else {
      var_05 = 0;
      while(var_05 < 5) {
        var_06 = self.var_012C["killstreaks"][var_05];
        if(isDefined(var_06) && isDefined(var_06.var_944C) && var_06.var_13AF) {
          var_07 = maps\mp\_utility::func_454A(var_06.var_944C, var_02, var_03);
          var_08 = self getweaponslistitems();
          var_09 = 0;
          for(var_0A = 0; var_0A < var_08.size; var_0A++) {
            if(var_07 == var_08[var_0A]) {
              var_09 = 1;
              break;
            }
          }

          if(!var_09) {
            maps\mp\_utility::func_0642(var_07);
          } else if(issubstr(var_07, "airdrop_")) {
            self method_82FA(var_07, 1);
          }

          if(!common_scripts\utility::func_562E(self.pcwaitingforkillstreakweaponchange)) {
            maps\mp\_utility::func_06D0(var_05 + 4, "weapon", var_07);
          }
        }

        var_09++;
      }

      self.var_5A69 = undefined;
      self.var_012C["lastEarnedStreak"] = self.var_012C["killstreaks"][var_04].var_944C;
      func_A170();
    }
  } else {
    self.var_5A69 = undefined;
    self.var_012C["lastEarnedStreak"] = undefined;
    func_A170();
  }

  if(isDefined(self)) {
    self setclientomnvar("ks_used", 1);
  }
}

func_23DD() {
  self.var_012C["killstreaks"][self.var_012C["killstreaks"][0].var_66CC] = undefined;
  var_00 = undefined;
  var_01 = self.var_012C["killstreaks"];
  for(var_02 = 5; var_02 < var_01.size; var_02++) {
    if(!isDefined(var_01[var_02]) || !isDefined(var_01[var_02].var_944C)) {
      continue;
    }

    var_00 = var_01[var_02].var_944C;
    var_01[0].var_66CC = var_02;
  }

  if(isDefined(var_00)) {
    var_01[0].var_13AF = 1;
    var_01[0].var_944C = var_00;
    var_03 = maps\mp\_utility::func_453F(var_00);
    var_04 = "ks_icon" + common_scripts\utility::func_9AAD(0);
    self setclientomnvar(var_04, var_03);
    if(!level.var_258F && !common_scripts\utility::func_55E0()) {
      var_05 = maps\mp\_utility::func_454A(var_00, self.var_01A7, maps\mp\_utility::func_0649("specialty_improvedstreaks"));
      maps\mp\_utility::func_06D0(4, "weapon", var_05);
      return;
    }

    return;
  }

  var_04 = "ks_icon" + common_scripts\utility::func_9AAD(0);
  self setclientomnvar(var_04, 0);
}

func_2400(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  var_01 = self.var_012C["killstreaks"];
  if(!isDefined(var_01)) {
    return;
  }

  for(var_02 = var_01.size - 1; var_02 > -1; var_02--) {
    self.var_012C["killstreaks"][var_02] = undefined;
  }

  func_5333();
  func_7D50(param_00);
  self.var_5A69 = undefined;
  func_A170();
}

transferkillstreaks() {
  var_00 = self.var_012C["killstreaks"];
  if(!isDefined(var_00)) {
    return;
  }

  func_2400(0);
  if(!isDefined(self.var_012C["killstreaks"])) {
    return;
  }

  for(var_01 = self.var_012C["killstreaks"].size - 1; var_01 > -1; var_01--) {
    if(!isDefined(self.var_012C["killstreaks"][var_01].var_944C)) {
      continue;
    }

    for(var_02 = var_00.size - 1; var_02 > -1; var_02--) {
      if(!isDefined(var_00[var_02].var_944C)) {
        continue;
      }

      if(var_00[var_02].var_944C == self.var_012C["killstreaks"][var_01].var_944C) {
        self.var_012C["killstreaks"][var_01].var_13AF = var_00[var_02].var_13AF;
      }
    }
  }
}

func_580E() {
  return isDefined(self.var_9E1C) && self.var_9E1C && isDefined(self.var_5A69);
}

func_A6A8() {
  self endon("weapon_switch_invalid");
  self waittill("weapon_switch_started", var_00);
  self notify("killstreak_weapon_change", "switch_started", var_00);
}

func_A6A7() {
  self endon("weapon_switch_started");
  self waittill("weapon_switch_invalid", var_00);
  self notify("killstreak_weapon_change", "switch_invalid", var_00);
}

func_A6A6() {
  childthread func_A6A8();
  childthread func_A6A7();
  self waittill("killstreak_weapon_change", var_00, var_01);
  if(var_00 == "switch_started") {
    return var_01;
  }

  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_04 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][self.var_5A69].var_944C, var_02, var_03);
  self switchtoweapon(var_04);
  self waittill("weapon_switch_started", var_05);
  if(var_05 != var_04) {
    return undefined;
  }

  return var_04;
}

func_A0DC() {
  foreach(var_01 in level.var_744A) {
    var_01 notify("updateKillStreakMarker");
  }
}

func_0A2F() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("clearAerialKillstreakMarkers");
  var_00 = maps\mp\gametypes\_gameobjects::func_44B9(self.var_01A7);
  var_01 = 1;
  for(;;) {
    if(!var_01) {
      common_scripts\utility::func_A70A("updateKillStreakMarker");
    } else {
      var_01 = 0;
    }

    var_02 = [];
    var_02 = func_4405(var_00);
    if(var_02.size == 0) {
      continue;
    }

    foreach(var_04 in var_02) {
      func_2832(var_04, self);
    }
  }
}

func_4405(param_00) {
  var_01 = [];
  var_02 = [];
  if(maps\mp\_utility::func_551F()) {
    return var_01;
  }

  if(level.var_984D) {
    var_02 = level.var_9FDA[param_00];
  } else {
    var_02 = level.var_9FDA;
  }

  foreach(var_04 in var_02) {
    if(isDefined(var_04.var_5745) && var_04.var_5745) {
      continue;
    }

    if(isDefined(var_04.var_6C1F) && var_04.var_6C1F) {
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  foreach(var_07 in level.var_7043) {
    if(!level.var_984D || var_07.var_01A7 == param_00) {
      var_01[var_01.size] = var_07;
    }
  }

  if(isDefined(level.var_4405)) {
    var_09 = [[level.var_4405]](param_00);
    foreach(var_0B in var_09) {
      var_01[var_01.size] = var_0B;
    }
  }

  return var_01;
}

func_2832(param_00, param_01) {
  if(!isDefined(param_00.var_A98D)) {
    param_00.var_A98D = [];
    param_00.var_A991 = [];
  }

  var_02 = param_01.var_48CA;
  if(isDefined(param_00.var_A98D[var_02])) {
    return;
  }

  param_00.var_A98D[var_02] = newclienthudelem(self);
  param_00.var_A98D[var_02] setshader("scorestreak_hud_target_hostile", 1, 1, 5);
  param_00.var_A98D[var_02].var_0018 = 0.9;
  param_00.var_A98D[var_02].var_01D3 = param_00.var_0116[0];
  param_00.var_A98D[var_02].var_01D7 = param_00.var_0116[1];
  param_00.var_A98D[var_02].var_01D9 = param_00.var_0116[2] - 400;
  param_00.var_A98D[var_02] setwaypoint(1, 1, 1);
  param_00.var_A98D[var_02] settargetent(param_00);
  param_00.var_A98D[var_02] method_8514(0);
  param_00.var_A98D[var_02].var_0180 = 0;
  param_00.var_A98D[var_02].var_001F = 0;
  param_00.var_A991[var_02] = newclienthudelem(self);
  param_00.var_A991[var_02] setshader("hud_exo_temp_warning", 1, 1);
  param_00.var_A991[var_02].var_0018 = 0.9;
  param_00.var_A991[var_02].var_0056 = (1, 1, 1);
  param_00.var_A991[var_02].var_01D3 = param_00.var_0116[0];
  param_00.var_A991[var_02].var_01D7 = param_00.var_0116[1];
  param_00.var_A991[var_02].var_01D9 = param_00.var_0116[2];
  param_00.var_A991[var_02] setwaypoint(0, 1, 0);
  param_00.var_A991[var_02] settargetent(param_00);
  param_00.var_A991[var_02].var_0180 = 0;
  param_00.var_A991[var_02].var_001F = 0;
  level thread func_7CFF(self, param_00, param_00.var_A98D[var_02], param_00.var_A991[var_02]);
}

func_7CFF(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_00 common_scripts\utility::func_A70C(param_00, "death", param_01, "death", param_00, "clearAerialKillstreakMarkers", param_00, "disconnect", param_01, "leaving");
  param_02 destroy();
  param_03 destroy();
}

func_5A7B() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("killstreakUseWaiter");
  self endon("killstreakUseWaiter");
  self.var_5BB3 = 0;
  if(!isDefined(self.var_012C["lastEarnedStreak"])) {
    self.var_012C["lastEarnedStreak"] = undefined;
  }

  thread func_3BA6();
  for(;;) {
    if(!isDefined(self.var_5992)) {
      self waittill("weapon_change", var_00);
    } else {
      var_00 = self.var_5992;
      self.var_5992 = undefined;
    }

    if(isDefined(self.var_8C04)) {
      self setclientomnvar("ui_map_location_selector", 0);
      self.var_8C04 = undefined;
    }

    if(!isalive(self)) {
      continue;
    }

    if(isDefined(self.var_1510)) {
      continue;
    }

    if(!isDefined(self.var_5A69)) {
      if(!level.var_258F) {
        if(isDefined(self.var_5B94) && var_00 == "killstreak_predator_missile_mp") {
          self switchtoweapon(self.var_5B94);
        }
      }

      continue;
    }

    if(isDefined(self.var_5FDD) && self.var_5FDD) {
      continue;
    }

    if(isDefined(self.var_56A3) && self.var_56A3) {
      continue;
    }

    if(!isDefined(self.var_012C["killstreaks"][self.var_5A69]) || !isDefined(self.var_012C["killstreaks"][self.var_5A69].var_944C)) {
      continue;
    }

    var_01 = self.var_01A7;
    var_02 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
    var_03 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][self.var_5A69].var_944C, var_01, var_02);
    if(var_00 != var_03) {
      if(issubstr(var_00, "turrethead")) {
        self switchtoweapon(self.var_5B94);
      }

      if(maps\mp\_utility::func_57E5(var_00, "airdrop_") || doeskillstreakweaponstowammo(var_00)) {
        self takeweapon(var_00);
        self switchtoweapon(self.var_5B94);
      }

      continue;
    }

    waittillframeend;
    var_04 = self.var_012C["killstreaks"][self.var_5A69].var_944C;
    var_05 = self.var_012C["killstreaks"][self.var_5A69].var_5703;
    var_06 = func_73EB();
    var_07 = self.var_5A69;
    if(func_8BAC(var_03)) {
      childthread func_956E(var_03, var_06);
    }

    var_08 = gettime();
    var_09 = func_5A7A();
    var_0A = gettime();
    var_0B = var_0A - var_08 / 1000;
    if(var_09 && var_04 == "fritzx" && issubstr(var_06, "alt+")) {
      self notify("cancelSwitchWeaponAfterRaiseAnimation");
    }

    if(!var_09 && !isalive(self) && !self hasweapon(common_scripts\utility::func_4550())) {
      var_06 = func_73EB(var_09);
      maps\mp\_utility::func_0642(var_06);
    }

    if(var_09) {
      thread func_A701(var_03, var_06, var_04);
    }

    if(func_8BAD(var_09, var_03, var_04) && !isDefined(self.var_5992) && !func_8BAC(var_03) || var_09) {
      switch (var_03) {
        case "killstreak_predator_missile_mp":
          if(!var_09 && 1.2 - var_0B > 0) {
            wait(1.2 - var_0B);
          }
          break;
      }

      if(!isDefined(self.var_A019)) {
        maps\mp\_utility::func_955C(var_06);
      } else {
        self.var_A95F = var_06;
      }
    }

    if(self getcurrentweapon() == "none") {
      while(self getcurrentweapon() == "none") {
        wait 0.05;
      }

      waittillframeend;
    }

    if(isDefined(level.var_2067) && var_09) {
      [[level.var_2067]](var_04, var_05, var_07);
    }

    if(func_3150(var_04)) {
      func_86B8(var_04, var_05, var_07);
      thread func_63A4();
      if(maps\mp\_utility::func_579B() && var_04 == "flamethrower") {
        thread func_7B75(var_03, var_07);
        continue;
      }

      if(maps\mp\_utility::func_579B() && var_04 == "raid_superweapon" || var_04 == "raid_tesla_moon") {
        thread reduceteslastowedammoondeath(var_03, var_07);
      }
    }
  }
}

func_956E(param_00, param_01) {
  self endon("cancelSwitchWeaponAfterRaiseAnimation");
  switch (param_00) {
    case "killstreak_uav_axis_mp":
    case "killstreak_uav_mp":
      if(!getdvarint("4263", 0)) {
        wait(0.833);
        break;
      }

      break;

    case "war_super_soldier_syrum_orange_mp":
    case "war_super_soldier_syrum_mp":
    case "war_super_soldier_syrum_green_mp":
    case "war_super_soldier_syrum_purple_mp":
      wait(0.833);
      break;

    default:
      break;
  }

  maps\mp\_utility::func_955C(param_01);
}

func_73EB(param_00) {
  if((!isDefined(param_00) || isDefined(param_00) && !param_00) && !isalive(self) && !self hasweapon(common_scripts\utility::func_4550())) {
    return common_scripts\utility::func_4550();
  }

  if(!self hasweapon(common_scripts\utility::func_4550())) {
    var_01 = maps\mp\_utility::func_44DD();
    return var_01;
  }

  return common_scripts\utility::func_4550();
}

func_A701(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  level endon("game_ended");
  self endon("faux_spawn");
  self notify("waitTakeKillstreakWeapon");
  self endon("waitTakeKillstreakWeapon");
  var_03 = self getcurrentweapon() == "none";
  self waittill("weapon_change", var_04);
  if(var_04 == param_01 || func_3150(param_02)) {
    func_95D6(param_00);
    if(!level.var_258F && !common_scripts\utility::func_55E0()) {
      if(isDefined(self.var_5A69) && self.var_012C["killstreaks"][self.var_5A69].var_944C == param_02) {
        self.var_5A69 = undefined;
        return;
      }

      return;
    }

    return;
  }

  if(var_04 != param_00) {
    thread func_A701(param_00, param_01, param_02);
    return;
  }

  if(var_03 && self getcurrentweapon() == param_00) {
    thread func_A701(param_00, param_01, param_02);
    return;
  }
}

func_95D6(param_00) {
  var_01 = 0;
  var_02 = self.var_012C["killstreaks"];
  var_03 = self.var_01A7;
  var_04 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  for(var_05 = 0; var_05 < var_02.size; var_05++) {
    if(isDefined(var_02[var_05]) && isDefined(var_02[var_05].var_944C) && var_02[var_05].var_13AF) {
      if(param_00 == maps\mp\_utility::func_454A(var_02[var_05].var_944C, var_03, var_04)) {
        var_01 = 1;
        break;
      }
    }
  }

  if(var_01) {
    if(level.var_258F || common_scripts\utility::func_55E0()) {
      if(isDefined(self.var_5A69) && param_00 != maps\mp\_utility::func_454A(var_02[self.var_5A69].var_944C, var_03, var_04)) {
        self takeweapon(param_00);
        return;
      }

      if(isDefined(self.var_5A69) && param_00 == maps\mp\_utility::func_454A(var_02[self.var_5A69].var_944C, var_03, var_04)) {
        self takeweapon(param_00);
        maps\mp\_utility::func_0642(param_00);
        maps\mp\_utility::func_06D0(4, "weapon", param_00);
        return;
      }

      return;
    }

    self takeweapon(param_00);
    maps\mp\_utility::func_0642(param_00);
    return;
  }

  self takeweapon(param_00);
}

func_8BAD(param_00, param_01, param_02) {
  if(!param_00) {
    return 1;
  }

  switch (param_02) {
    case "fighter_strike":
      return 0;
  }

  if(func_8BAC(param_01)) {
    return 0;
  }

  return 1;
}

func_8BAC(param_00) {
  switch (param_00) {
    case "m712carry_mp":
    case "killstreak_mortar_mp":
    case "m1917_carry_turret_mp":
    case "teslagun_war_regular_mp":
    case "teslagunmtx_mp":
    case "sword_mp":
    case "killstreak_molotov_cocktail_grenadier_mp":
    case "killstreak_molotov_cocktail_mp":
    case "flamethrower_german_grenadier_mp":
    case "flamethrower_grenadier_mp":
    case "flamethrower_german_mp":
    case "flamethrower_mp":
    case "war_sword_mp":
    case "war_super_soldier_syrum_orange_mp":
    case "war_super_soldier_syrum_mp":
    case "war_super_soldier_syrum_green_mp":
    case "war_super_soldier_syrum_purple_mp":
    case "teslagun_war_moon_mp":
      return 1;

    case "killstreak_uav_axis_mp":
    case "killstreak_uav_mp":
      if(!getdvarint("4263", 0)) {
        return 1;
      }

      break;

    default:
      return 0;
  }
}

func_3BA6() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  self notify("finishDeathWaiter");
  self endon("finishDeathWaiter");
  self waittill("death");
  wait 0.05;
  self notify("finish_death");
  self.var_012C["lastEarnedStreak"] = undefined;
}

func_21E7() {
  var_00 = self.var_0A06;
  var_01 = self.var_76DA;
  var_02 = self.var_0A0D;
  var_03 = self.var_76DB;
  foreach(var_05 in self.var_5A71) {
    if(var_05 == "basic_training_serum") {
      continue;
    }

    var_06 = func_46B4(var_05);
    var_07 = var_00;
    var_08 = var_01;
    if(func_57F0(self, var_05)) {
      var_07 = var_02;
      var_08 = var_03;
    }

    if(var_06 > var_07 && var_07 > var_08) {
      continue;
    }

    if(var_08 < var_06 && var_07 >= var_06 || var_07 <= var_08) {
      func_353C(var_05, var_06);
    }
  }
}

func_5A60(param_00) {
  var_01 = 0;
  if(isDefined(param_00) && param_00 != "none") {
    var_01 = maps\mp\_utility::func_452A(param_00);
  }

  if(isDefined(self.var_231B)) {
    var_02 = self.var_231B;
    if(var_02 == -1) {
      var_03 = self.var_012C["copyCatLoadout"]["className"];
      var_02 = maps\mp\_utility::func_445D(var_03);
      if(issubstr(var_03, "practice")) {
        var_02 = self.var_012C["copyCatLoadout"]["practiceClassNum"];
      }
    }

    if(issubstr(self.var_2319, "custom")) {
      var_04 = common_scripts\utility::func_46AF();
      if(!function_03AC()) {
        var_04 = common_scripts\utility::func_46AC();
      } else if(function_03AF()) {
        var_04 = common_scripts\utility::func_ACEE();
      }

      if(self getrankedplayerdata(var_04, "assaultStreaks", 0, "streak") == var_01) {
        self.var_3C6B = gettime();
        return;
      }

      if(self getrankedplayerdata(var_04, "assaultStreaks", 2, "streak") == var_01 && isDefined(self.var_3C6B)) {
        if(gettime() - self.var_3C6B < 20000) {
          thread maps\mp\gametypes\_missions::func_4032("wargasm");
          return;
        }

        return;
      }

      return;
    }
  }
}

func_353C(param_00, param_01) {
  if(isDefined(self.var_012C["supportStreaksEarned"]) && isDefined(self.var_012C["supportStreaksEarned"][param_00]) && self.var_012C["supportStreaksEarned"][param_00]) {
    return;
  }

  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  self.var_353B = param_01;
  var_04 = func_45A5(param_00, 1);
  thread maps\mp\_events::func_353A(param_00, param_01, var_04);
  thread func_5A60(param_00);
  self.var_012C["lastEarnedStreak"] = param_00;
  if(func_3150(param_00)) {
    if(isDefined(self.var_012C["killstreak_stowed_ammo"])) {
      var_05 = maps\mp\_utility::func_454A(param_00, var_02, var_03);
      self.var_012C["killstreak_stowed_ammo"][var_05 + var_04] = undefined;
      var_06 = self.var_012C["killstreak_stowed_ammo"]["streakName"];
      var_07 = self.var_012C["killstreak_stowed_ammo"]["slotNumber"];
      if(isDefined(var_06) && isDefined(var_07) && var_06 == param_00 && var_07 == var_04) {
        self notify("cancel_stowed_ammo");
      }
    }
  }

  func_478D(param_00, 1, 1, self);
  if(maps\mp\_utility::func_0649("specialty_class_ordnance")) {
    maps\mp\gametypes\_missions::func_7750("ch_field_ordnance");
  }

  if(maps\mp\_utility::func_0649("specialty_class_blitzkrieg")) {
    maps\mp\gametypes\_missions::func_7750("ch_dlc2_blitzkrieg");
  }
}

func_45A5(param_00, param_01, param_02) {
  var_03 = undefined;
  if(!isDefined(param_01) || param_01 == 0) {
    if(!isDefined(param_02)) {
      var_03 = 0;
    } else {
      var_03 = param_02;
    }
  } else {
    for(var_04 = 1; var_04 < 5; var_04++) {
      var_05 = self.var_012C["killstreaks"][var_04];
      if(isDefined(var_05) && isDefined(var_05.var_944C) && param_00 == var_05.var_944C) {
        var_03 = var_04;
        break;
      }
    }
  }

  return var_03;
}

func_478D(param_00, param_01, param_02, param_03, param_04) {
  self endon("givingLoadout");
  if(!isDefined(level.var_5A61[param_00]) || tablelookup("mp/killstreakTable.csv", 1, param_00, 0) == "") {
    return;
  }

  if(!isDefined(self.var_012C["killstreaks"])) {
    return;
  }

  self endon("disconnect");
  var_05 = undefined;
  if(!isDefined(param_01) || param_01 == 0) {
    var_06 = self.var_012C["killstreaks"].size;
    if(isDefined(param_04)) {
      var_06 = param_04;
    }

    if(!isDefined(self.var_012C["killstreaks"][var_06])) {
      self.var_012C["killstreaks"][var_06] = spawnStruct();
    }

    var_07 = self.var_012C["killstreaks"][var_06];
    var_07.var_13AF = 0;
    var_07.var_944C = param_00;
    var_07.var_3539 = 0;
    var_07.var_145C = isDefined(param_02) && param_02;
    var_07.var_0117 = param_03;
    var_07.var_59F1 = self.var_012C["kID"];
    var_07.var_5CC6 = -1;
    var_07.var_5703 = 1;
    var_05 = func_45A5(param_00, param_01, param_04);
    if(!isDefined(self.var_012C["killstreaks"][var_05])) {
      self.var_012C["killstreaks"][var_05] = spawnStruct();
    }

    self.var_012C["killstreaks"][var_05].var_66CC = var_06;
    self.var_012C["killstreaks"][var_05].var_944C = param_00;
    var_08 = maps\mp\_utility::func_453F(param_00);
    var_09 = "ks_icon" + common_scripts\utility::func_9AAD(var_05);
    self setclientomnvar(var_09, var_08);
  } else {
    var_05 = func_45A5(param_00, param_01, param_04);
    if(param_01 && maps\mp\_utility::func_0649("specialty_supportstreaks")) {
      if(!isDefined(self.var_012C["supportStreaksEarned"])) {
        self.var_012C["supportStreaksEarned"] = [];
      }

      self.var_012C["supportStreaksEarned"][param_00] = 1;
    }

    if(!isDefined(var_05)) {
      return;
    }
  }

  var_0E = self.var_01A7;
  var_0F = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_10 = self.var_012C["killstreaks"][var_05];
  var_10.var_13AF = 1;
  var_10.var_3539 = isDefined(param_01) && param_01;
  var_10.var_145C = isDefined(param_02) && param_02;
  var_10.var_5703 = !isDefined(param_01) || param_01 == 0;
  var_10.var_0117 = param_03;
  var_10.var_59F1 = self.var_012C["kID"];
  self.var_012C["kID"]++;
  if(!var_10.var_3539) {
    var_10.var_5CC6 = -1;
  } else {
    var_10.var_5CC6 = self.var_5CC6;
  }

  if(level.var_258F || common_scripts\utility::func_55E0()) {
    var_11 = maps\mp\_utility::func_454A(param_00, var_0E, var_0F);
    func_478E(var_11, var_05);
    if(isDefined(self.var_5A69)) {
      param_00 = self.var_012C["killstreaks"][self.var_5A69].var_944C;
      var_12 = maps\mp\_utility::func_454A(param_00, var_0E, var_0F);
      var_13 = self getcurrentweapon();
      if(var_13 != var_12 && !issubstr(var_13, "turrethead")) {
        self.var_5A69 = var_05;
      }
    } else {
      self.var_5A69 = var_05;
    }
  } else {
    if(0 == var_0E && self.var_012C["killstreaks"][0].var_66CC > 5) {
      var_14 = self.var_012C["killstreaks"][0].var_66CC - 1;
      var_15 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][var_14].var_944C, var_0F, var_10);
      self takeweapon(var_15);
    }

    var_12 = maps\mp\_utility::func_454A(param_01, var_0F, var_10);
    maps\mp\_utility::func_0642(var_12);
    if(self.var_0887[var_0E]) {
      maps\mp\_utility::func_06D0(var_0E + 4, "weapon", var_12);
    }

    param_01 = self.var_012C["killstreaks"][var_0E].var_944C;
    if(func_3150(param_01)) {
      func_A12A(param_01, var_12, var_0E);
    }
  }

  func_A170();
  if(isDefined(level.var_5A75[param_01])) {
    self[[level.var_5A75[param_01]]]();
  }

  self setclientomnvar("ks_acquired", 1);
}

func_3150(param_00) {
  return param_00 == "flamethrower" || param_00 == "molotovs" || param_00 == "raid_superweapon" || param_00 == "raid_tesla_moon";
}

doeskillstreakweaponstowammo(param_00) {
  if(maps\mp\_utility::func_579B() && issubstr(param_00, "tesla")) {
    return 1;
  }

  return param_00 == "flamethrower_mp" || param_00 == "flamethrower_german_mp" || param_00 == "flamethrower_grenadier_mp" || param_00 == "flamethrower_german_grenadier_mp" || param_00 == "killstreak_molotov_cocktail_mp" || param_00 == "killstreak_molotov_cocktail_grenadier_mp";
}

func_86B8(param_00, param_01, param_02) {
  if(func_3150(param_00)) {
    self.var_012C["killstreak_stowed_ammo"]["streakName"] = param_00;
    self.var_012C["killstreak_stowed_ammo"]["slotNumber"] = param_02;
    self.var_012C["killstreak_stowed_ammo"]["isGimme"] = param_01;
  }
}

func_A12A(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    if(func_3150(param_00)) {
      if(isDefined(self.var_012C["killstreak_stowed_ammo"])) {
        var_03 = self.var_012C["killstreak_stowed_ammo"][param_01 + param_02];
        if(isDefined(var_03)) {
          self method_82FA(param_01, var_03.var_0DB3);
          self setweaponammostock(param_01, var_03.var_0DBB);
          return;
        }

        return;
      }

      return;
    }
  }
}

func_7B75(param_00, param_01) {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  self endon("cancel_stowed_ammo");
  self notify("reduceFlamethrowerStowedAmmoOnDeath");
  self endon("reduceFlamethrowerStowedAmmoOnDeath");
  for(;;) {
    self waittill("death");
    waittillframeend;
    if(isDefined(self.var_012C["killstreak_stowed_ammo"])) {
      var_02 = self.var_012C["killstreak_stowed_ammo"][param_00 + param_01];
      if(isDefined(var_02)) {
        var_03 = int(0.2 * weaponclipsize(param_00));
        if(var_02.var_0DB3 > var_03) {
          var_02.var_0DB3 = int(max(var_03, var_02.var_0DB3 - var_03));
        }
      }
    }
  }
}

reduceteslastowedammoondeath(param_00, param_01) {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  self endon("cancel_stowed_ammo");
  self notify("reduceTeslaStowedAmmoOnDeath");
  self endon("reduceTeslaStowedAmmoOnDeath");
  for(;;) {
    self waittill("death");
    waittillframeend;
    if(isDefined(self.var_012C["killstreak_stowed_ammo"])) {
      var_02 = self.var_012C["killstreak_stowed_ammo"][param_00 + param_01];
      if(isDefined(var_02)) {
        var_03 = weaponclipsize(param_00);
        var_04 = var_02.var_0DBB - var_03;
        if(var_04 < 0) {
          var_04 = 0;
        }

        var_02.var_0DBB = int(var_04);
      }
    }
  }
}

func_2385() {
  self endon("disconnect");
  var_00 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  common_scripts\utility::func_A70C(level, "game_ended", self, "joined_team", self, "joined_spectators");
  for(var_01 = 0; var_01 < 5; var_01++) {
    if(isDefined(self.var_012C) && isDefined(self.var_012C["killstreaks"]) && isDefined(self.var_012C["killstreaks"][var_01]) && isDefined(self.var_012C["killstreaks"][var_01].var_944C)) {
      var_02 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][var_01].var_944C, self.var_01A7, var_00);
      if(isDefined(self.var_012C["killstreak_stowed_ammo"][var_02 + var_01])) {
        self.var_012C["killstreaks"][var_01].var_13AF = 0;
        if(var_01 == 0) {
          func_23DD();
        }
      }
    }
  }

  self.var_012C["killstreak_stowed_ammo"] = undefined;
}

func_63A4() {
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("game_ended");
  level endon("runBomberObjective");
  var_00 = self.var_01A7;
  var_01 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_02 = common_scripts\utility::func_A716("weapon_change", "death", "cancel_stowed_ammo");
  if(!isDefined(self.var_012C["killstreak_stowed_ammo"])) {
    return;
  }

  var_03 = self.var_012C["killstreak_stowed_ammo"]["streakName"];
  var_04 = self.var_012C["killstreak_stowed_ammo"]["slotNumber"];
  if(var_02 == "cancel_stowed_ammo") {
    self.var_012C["killstreak_stowed_ammo"]["streakName"] = undefined;
    self.var_012C["killstreak_stowed_ammo"]["slotNumber"] = undefined;
    self.var_012C["killstreak_stowed_ammo"]["isGimme"] = undefined;
    return;
  }

  if(!isDefined(var_03) || !isDefined(var_04)) {
    return;
  }

  var_05 = maps\mp\_utility::func_454A(var_03, var_00, var_01);
  var_06 = self getweaponammoclip(var_05);
  var_07 = self getweaponammostock(var_05);
  if(var_06 + var_07 <= 0) {
    self.var_012C["killstreak_stowed_ammo"][var_05 + var_04] = undefined;
    self.var_012C["killstreak_stowed_ammo"]["streakName"] = undefined;
    self.var_012C["killstreak_stowed_ammo"]["slotNumber"] = undefined;
    self notify("reduceFlamethrowerStowedAmmoOnDeath");
    self notify("reduceTeslaStowedAmmoOnDeath");
    return;
  }

  if(!isDefined(self.var_012C["killstreak_stowed_ammo"][var_05 + var_04])) {
    self.var_012C["killstreak_stowed_ammo"][var_05 + var_04] = spawnStruct();
  }

  var_08 = self.var_012C["killstreak_stowed_ammo"][var_05 + var_04];
  var_08.var_0DB3 = var_06;
  var_08.var_0DBB = var_07;
  var_09 = self.var_012C["killstreak_stowed_ammo"]["isGimme"];
  var_0A = var_04;
  if(var_09) {
    var_0A = undefined;
  }

  switch (var_02) {
    case "weapon_change":
      waittillframeend;
      func_478D(var_03, !var_09, 0, self, var_0A);
      func_A12A(var_03, var_05, var_04);
      break;

    case "death":
      self waittill("spawned_player");
      func_478D(var_03, !var_09, 0, self, var_0A);
      break;
  }
}

func_478E(param_00, param_01) {
  self endon("disconnect");
  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  if(!level.var_258F && !common_scripts\utility::func_55E0()) {
    return;
  }

  var_04 = self getcurrentweapon();
  while(maps\mp\_utility::func_56A8()) {
    if(doeskillstreakweaponstowammo(param_00) && self method_801D() || (isDefined(self.hasuseweapon) && self.hasuseweapon) || isDefined(self.var_56A1) && self.var_56A1) {
      break;
    }

    wait 0.05;
  }

  var_05 = self getweaponslistitems();
  foreach(var_07 in var_05) {
    if(!maps\mp\_utility::func_57E5(var_07, "killstreak_") && !maps\mp\_utility::func_57E5(var_07, "airdrop_") && !maps\mp\_utility::func_57E5(var_07, "deployable_")) {
      continue;
    }

    if(var_07 == "killstreak_molotov_cocktail_mp" || var_07 == "killstreak_molotov_cocktail_grenadier_mp") {
      continue;
    }

    if(self getcurrentweapon() == var_07) {
      continue;
    }

    self takeweapon(var_07);
  }

  if(isDefined(self.var_5A69)) {
    var_09 = self.var_012C["killstreaks"][self.var_5A69];
    var_0A = var_09.var_944C;
    var_0B = maps\mp\_utility::func_454A(var_0A, var_02, var_03);
    if(self getcurrentweapon() != var_0B || func_1F6E()) {
      if(self hasweapon(param_00) && self getcurrentweapon() != param_00) {
        self takeweapon(param_00);
      }

      if(func_3150(var_0A) && self getcurrentweapon() == var_0B && isDefined(self.lastusedkillstreakindexweapon) && param_01 != self.lastusedkillstreakindexweapon) {
        func_A170();
        var_0C = common_scripts\utility::func_A715("toggled_up", "toggled_down", "weapon_change");
        if(var_0C != "weapon_change" || self getclientomnvar("ks_selectedIndex") != param_01) {
          return;
        }
      }

      maps\mp\_utility::func_0642(param_00);
      maps\mp\_utility::func_06D0(4, "weapon", param_00);
      if(func_3150(var_0A) && self getcurrentweapon() != var_0B) {
        func_A12A(var_0A, var_0B, param_01);
      }
    }
  } else {
    maps\mp\_utility::func_0642(param_00);
    maps\mp\_utility::func_06D0(4, "weapon", param_00);
  }

  if(issubstr(param_00, "flamethrower") && self getcurrentweapon() == param_00) {
    self setweaponammostock(param_00, 0);
  }
}

func_46B4(param_00) {
  if(getdvarint("isMLGMatch", 0) == 1 || function_03AF()) {
    var_01 = int(maps\mp\_utility::getkillstreakesportscost(param_00));
  } else if(maps\mp\_utility::func_0649("specialty_killstreaks")) {
    var_01 = int(maps\mp\_utility::getkillstreakkills(var_01));
    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::func_0649("specialty_hardline")) {
        var_01 = int(maps\mp\_utility::getkillstreakhardlinekills(param_00));
      }

      if(maps\mp\_utility::func_0649("specialty_supportstreaks")) {
        var_01 = int(maps\mp\_utility::getkillstreaksupportkills(param_00));
      }
    }
  } else {
    var_01 = int(maps\mp\_utility::func_4531(var_01));
    if(isDefined(self) && isPlayer(self)) {
      if(maps\mp\_utility::func_0649("specialty_hardline")) {
        var_01 = int(maps\mp\_utility::func_453C(param_00));
      }

      if(maps\mp\_utility::func_0649("specialty_supportstreaks")) {
        var_01 = int(maps\mp\_utility::func_4548(param_00));
      }
    }
  }

  return var_01;
}

func_453D(param_00) {
  return function_01AF("mp/killstreakTable.csv", 1, param_00, 10);
}

func_4540(param_00) {
  return int(tablelookup("mp/killstreakTable.csv", 1, param_00, 15));
}

func_4535(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 12);
}

func_4533(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 19);
}

func_47A1(param_00) {
  var_01 = self.var_012C["killstreaks"];
  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  if(level.var_258F || common_scripts\utility::func_55E0()) {
    var_04 = -1;
    var_05 = -1;
    for(var_06 = 0; var_06 < 5; var_06++) {
      if(isDefined(var_01[var_06]) && isDefined(var_01[var_06].var_944C) && var_01[var_06].var_13AF && func_46B4(var_01[var_06].var_944C) > var_05) {
        var_05 = 0;
        if(!var_01[var_06].var_5703) {
          var_05 = func_46B4(var_01[var_06].var_944C);
        }

        var_04 = var_06;
      }
    }

    if(var_04 != -1) {
      self.var_5A69 = var_04;
      var_07 = var_01[self.var_5A69].var_944C;
      var_08 = maps\mp\_utility::func_454A(var_07, var_02, var_03);
      func_478E(var_08, self.var_5A69);
    } else {
      self.var_5A69 = undefined;
    }
  } else {
    var_04 = -1;
    var_05 = -1;
    var_06 = 0;
    while(var_06 < 5) {
      if(isDefined(var_01[var_06]) && isDefined(var_01[var_06].var_944C) && var_01[var_06].var_13AF) {
        var_09 = maps\mp\_utility::func_454A(var_01[var_06].var_944C, var_02, var_03);
        var_0A = self getweaponslistitems();
        var_0B = 0;
        for(var_0C = 0; var_0C < var_0A.size; var_0C++) {
          if(var_09 == var_0A[var_0C]) {
            var_0B = 1;
            break;
          }
        }

        if(!var_0B) {
          maps\mp\_utility::func_0642(var_09);
        } else if(issubstr(var_09, "airdrop_")) {
          self method_82FA(var_09, 1);
        }

        maps\mp\_utility::func_06D0(var_06 + 4, "weapon", var_09);
        var_07 = var_01[var_06].var_944C;
        if(func_3150(var_07) && self getcurrentweapon() != var_09) {
          func_A12A(var_07, var_09, var_06);
        }

        if(func_46B4(var_01[var_06].var_944C) > var_05) {
          var_05 = 0;
          if(!var_01[var_06].var_5703) {
            var_05 = func_46B4(var_01[var_06].var_944C);
          }

          var_04 = var_06;
        }
      }

      var_0C++;
    }

    if(var_04 != -1) {
      var_07 = var_01[var_04].var_944C;
    }

    self.var_5A69 = undefined;
  }

  func_A170();
}

func_748B() {
  if(!isDefined(self.var_7C67)) {
    return;
  }

  self endon("rideKillstreakComplete");
  self waittill("rideKillstreakFailed");
}

func_748A() {
  if(!isDefined(self.var_7C67)) {
    return;
  }

  self endon("rideKillstreakBlack");
  self waittill("rideKillstreakFailed");
}

func_5345(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(func_5347(param_00)) {
    waittillframeend;
    self.var_7C67 = undefined;
    maps\mp\_utility::func_7441();
    self notify("rideKillstreakFailed");
    return "fail";
  }

  func_73D0();
  common_scripts\utility::func_0601();
  maps\mp\_utility::func_3E8E(1);
  self.var_7C67 = 1;
  var_04 = func_5346(param_00, param_01, param_02, param_03);
  if(isDefined(self)) {
    maps\mp\_utility::func_3E8E(0);
    common_scripts\utility::func_0615();
    self.var_7C67 = undefined;
    if(var_04 == "success") {
      self notify("rideKillstreakBlack");
    } else {
      maps\mp\_utility::func_7441();
      self notify("rideKillstreakFailed");
    }
  }

  return var_04;
}

func_5346(param_00, param_01, param_02, param_03) {
  thread func_7D69();
  var_04 = "none";
  var_05 = 0.75;
  if(isDefined(param_00) && param_00 == "plane_gunner") {
    var_05 = 0.05;
  }

  var_04 = common_scripts\utility::func_A71A(var_05, "disconnect", "death", "weapon_switch_started");
  maps\mp\gametypes\_hostmigration::func_A782();
  if(var_04 == "disconnect") {
    return "disconnect";
  }

  if(var_04 == "death") {
    return "fail";
  }

  if(var_04 == "weapon_switch_started") {
    return "fail";
  }

  if(func_5347(param_00)) {
    return "fail";
  }

  maps\mp\_utility::func_7440();
  func_73D0();
  if(param_01) {
    if(!isDefined(param_02)) {
      param_02 = 1;
    }
  } else {
    if(!isDefined(param_02)) {
      param_02 = 0.8;
    }

    self setclientomnvar("ui_killstreak_blackout", 1);
    self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(param_02 * 1000));
    thread func_240D();
    thread func_240C();
  }

  var_04 = common_scripts\utility::func_A71A(param_02, "disconnect", "death");
  if(var_04 == "disconnect" || !isDefined(self)) {
    return "disconnect";
  }

  if(!isDefined(param_03)) {
    param_03 = 0.6;
  }

  if(param_01) {
    self notify("intro_cleared");
  } else {
    thread func_240B(param_03);
  }

  if(var_04 == "death") {
    return "fail";
  }

  if(func_5347(param_00)) {
    return "fail";
  }

  maps\mp\gametypes\_hostmigration::func_A782();
  return "success";
}

func_5347(param_00) {
  if(!isDefined(self) || !isalive(self)) {
    return 1;
  }

  if(!self isonground() && !self islinked()) {
    self iclientprintlnbold(&"KILLSTREAKS_CANT_ACTIVATE_WHILE_FALLING");
    return 1;
  }

  if(isDefined(self.var_A019) && self.var_A019) {
    return 1;
  }

  if(level.var_3F9D) {
    return 1;
  }

  if(maps\mp\_utility::func_56D7()) {
    return 1;
  }

  if(maps\mp\_utility::func_5668(0)) {
    return 1;
  }

  return 0;
}

func_240B(param_00) {
  self endon("disconnect");
  self endon("joined_team");
  if(isDefined(param_00)) {
    maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
  }

  var_01 = 0.5;
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + int(var_01 * 1000));
  wait(var_01);
  if(!isDefined(self)) {
    return;
  }

  self notify("rideKillstreakComplete");
}

func_7D69() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  maps\mp\_utility::func_3E8E(0);
  self.var_7C67 = undefined;
  if(self.var_2F80) {
    common_scripts\utility::func_0615();
  }

  if(maps\mp\_utility::func_581D()) {
    maps\mp\_utility::func_2414();
  }
}

func_240D() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::func_7441();
  self notify("rideKillstreakComplete");
}

func_240C() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");
  level waittill("game_ended");
  self setclientomnvar("ui_killstreak_blackout", 0);
  self setclientomnvar("ui_killstreak_blackout_fade_end", 0);
  maps\mp\_utility::func_7441();
  self notify("rideKillstreakComplete");
}

func_73D0() {
  if(self isonground()) {
    var_00 = bulletTrace(self.var_0116 + (0, 0, 5), self.var_0116 + (0, 0, -5), 0);
    if(isDefined(var_00["glass"])) {
      destroyglass(var_00["glass"]);
    }
  }
}

func_47BA(param_00) {
  var_01 = self.var_01A7;
  var_02 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_03 = self.var_012C["killstreaks"][self.var_5A69].var_944C;
  var_04 = maps\mp\_utility::func_454A(var_03, var_01, var_02);
  func_478E(var_04, self.var_5A69);
  if(isDefined(param_00)) {
    self.var_5A69 = param_00;
  }

  func_A170();
}

func_4532() {
  var_00 = 0;
  for(var_01 = 0; var_01 < 5; var_01++) {
    if(isDefined(self.var_012C["killstreaks"][var_01]) && isDefined(self.var_012C["killstreaks"][var_01].var_944C) && self.var_012C["killstreaks"][var_01].var_13AF) {
      var_00++;
    }
  }

  return var_00;
}

func_8C30() {
  if(func_4532() > 1) {
    for(;;) {
      self.var_5A69++;
      if(self.var_5A69 >= 5) {
        self.var_5A69 = 0;
      }

      if(self.var_012C["killstreaks"][self.var_5A69].var_13AF == 1) {
        break;
      }
    }

    func_47BA();
  }
}

func_8C2F() {
  if(func_4532() > 1) {
    for(;;) {
      self.var_5A69--;
      if(self.var_5A69 < 0) {
        self.var_5A69 = 4;
      }

      if(self.var_012C["killstreaks"][self.var_5A69].var_13AF == 1) {
        break;
      }
    }

    func_47BA();
  }
}

func_9450() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("toggled_up");
    if(!level.var_258F && !common_scripts\utility::func_55E0()) {
      continue;
    }

    if(func_1F6D()) {
      func_8C30();
    }

    wait(0.12);
  }
}

func_944F() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("toggled_down");
    if(!level.var_258F && !common_scripts\utility::func_55E0()) {
      continue;
    }

    if(func_1F6D()) {
      func_8C2F();
    }

    wait(0.12);
  }
}

func_1F6D() {
  return !self method_82E4() && !self method_8128() && !isDefined(self.var_20CC) && func_1F6E() && !isDefined(self.var_56A3) || isDefined(self.var_56A3) && self.var_56A3 == 0;
}

func_1F6E() {
  var_00 = self getcurrentweapon();
  if(var_00 == "flamethrower_mp" || var_00 == "flamethrower_german_mp" || var_00 == "flamethrower_grenadier_mp" || var_00 == "flamethrower_german_grendier_mp" || var_00 == "killstreak_molotov_cocktail_mp" || var_00 == "killstreak_molotov_cocktail_grenadier_mp" || var_00 == "teslagun_war_moon_mp") {
    return 1;
  }

  return !maps\mp\_utility::func_5740(var_00);
}

func_944D() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  if(isbot(self)) {
    return;
  }

  maps\mp\_utility::func_3FA5("prematch_done");
  self notifyonplayercommand("toggled_up", "+actionslot 1");
  self notifyonplayercommand("toggled_down", "+actionslot 2");
  if(!level.var_258F) {
    self notifyonplayercommand("streakUsed1", "+actionslot 4");
    self notifyonplayercommand("streakUsed2", "+actionslot 5");
    self notifyonplayercommand("streakUsed3", "+actionslot 6");
    self notifyonplayercommand("streakUsed4", "+actionslot 7");
    self notifyonplayercommand("streakUsed5", "+actionslot 8");
  }
}

func_4771(param_00) {
  if(!param_00) {
    return;
  }

  var_01 = self.var_0A06 + param_00;
  var_02 = func_457A(0);
  if(var_01 >= var_02) {
    var_01 = var_01 - var_02;
  }

  func_861D(var_01);
  var_01 = self.var_0A0D + param_00;
  var_02 = func_457A(1);
  if(var_01 >= var_02) {
    var_01 = var_01 - var_02;
  }

  func_861E(var_01);
  func_A16E();
  func_21E7();
}

func_7F2C(param_00) {
  if(int(param_00) != param_00) {
    return int(param_00 + 1);
  }

  return int(param_00);
}

iskillevent(param_00) {
  switch (param_00) {
    case "division_commando_kill":
    case "division_grenadier_kill":
    case "crossfire_cavalry":
    case "assist_cavalry":
    case "kill":
    case "mg_nest_kill":
    case "tac_insert_kill":
    case "division_artillery_kill":
    case "division_scout_kill":
    case "division_resistance_kill":
    case "divisions_cavalry_kill":
    case "divisions_mountain_kill":
    case "divisions_armored_kill":
    case "divisions_airborne_kill":
    case "divisions_infantry_kill":
      return 1;

    case "attack_dogs_kill":
    case "v2_rocket_kill":
    case "airdrop_kill":
    case "paratroopers_kill":
    case "missile_strike_kill":
    case "mortar_strike_kill":
    case "flamethrower_kill":
    case "molotovs_kill":
    case "plane_gunner_kill":
    case "airstrike_kill":
    case "firebomb_kill":
    case "fritzx_kill":
    case "fighter_strike_kill":
      return maps\mp\_utility::areexperimentalbasictrainingsenabled();
  }

  return 0;
}

func_4770(param_00) {
  var_01 = maps\mp\gametypes\_rank::func_4671(param_00);
  thread lib_0533::func_6BCF(var_01);
  if(isPlayer(self) && isDefined(self.var_4B5D) && self.var_4B5D) {
    var_01 = var_01 * level.var_252C;
  }

  if(maps\mp\_utility::func_0F5C() && (maps\mp\_utility::func_57A0(self) || maps\mp\_utility::func_0649("specialty_supportstreaks")) && param_00 != "raid_flak_kill" && param_00 != "raid_fighters_kill" && param_00 != "raid_flak_assist" && param_00 != "raid_fighters_assist") {
    if(maps\mp\_utility::func_0649("specialty_killstreaks")) {
      if(iskillevent(param_00)) {
        func_4771(1);
      }
    } else {
      func_4771(var_01);
    }
  }

  if(maps\mp\_utility::func_0649("specialty_improvedstreaks") && param_00 == "airdrop_kill" || param_00 == "fritzx_kill" || param_00 == "mortar_strike_kill" || param_00 == "missile_strike_kill" || param_00 == "airstrike_kill" || param_00 == "firebomb_kill" || param_00 == "fighter_strike_kill" || param_00 == "plane_gunner_kill" || param_00 == "flamethrower_kill" || param_00 == "attack_dogs_kill" || param_00 == "paratroopers_kill" || param_00 == "molotovs_kill" || param_00 == "v2_rocket_kill") {
    var_01 = maps\mp\gametypes\_rank::func_4671("kill");
  }

  func_300F(param_00, var_01);
}

func_300F(param_00, param_01) {
  if(!level.var_4B17) {
    thread maps\mp\gametypes\_rank::func_AAD2(param_00, param_01);
  }
}

func_7D50(param_00) {
  if(maps\mp\_utility::func_0F5C()) {
    self.var_353B = 0;
    func_861D(0);
    if(param_00) {
      func_861E(0);
      self.var_012C["ks_totalPointsSupport"] = 0;
    }

    func_A16E();
    self.var_012C["ks_totalPoints"] = 0;
    self.var_012C["lastEarnedStreak"] = undefined;
  }
}

func_861D(param_00) {
  if(maps\mp\_utility::func_0F5C()) {
    if(param_00 < 0) {
      param_00 = 0;
    }

    if(isDefined(self.var_0A06) && self.var_0A06 != 0) {
      self.var_76DA = self.var_0A06;
    } else {
      self.var_76DA = 0;
    }

    self.var_0A06 = param_00;
    self.var_012C["ks_totalPoints"] = self.var_0A06;
  }
}

func_861E(param_00) {
  if(maps\mp\_utility::func_0F5C()) {
    if(param_00 < 0) {
      param_00 = 0;
    }

    if(isDefined(self.var_0A0D) && self.var_0A0D != 0) {
      self.var_76DB = self.var_0A0D;
    } else {
      self.var_76DB = 0;
    }

    self.var_0A0D = param_00;
    self.var_012C["ks_totalPointsSupport"] = self.var_0A0D;
  }
}

func_6F33() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = common_scripts\utility::func_55E0();
  for(;;) {
    if(maps\mp\_utility::func_572D() || maps\mp\_utility::func_581D() || maps\mp\_utility::func_56A8()) {
      while(maps\mp\_utility::func_572D() || maps\mp\_utility::func_581D() || maps\mp\_utility::func_56A8()) {
        wait 0.05;
      }

      wait 0.05;
    }

    if(var_00 != common_scripts\utility::func_55E0()) {
      thread func_A129(1);
      var_00 = common_scripts\utility::func_55E0();
    }

    wait 0.05;
  }
}

func_6F34() {
  self.var_0887 = [];
  self.var_0887[0] = 1;
  self.var_0887[1] = 1;
  self.var_0887[2] = 1;
  self.var_0887[3] = 1;
  self.var_0887[4] = 1;
  self.pcwaitingforkillstreakweaponchange = 0;
  if(!isbot(self)) {
    thread func_6F33();
  }

  thread pc_watchstreakuseslot("streakUsed1", 0);
  thread pc_watchstreakuseslot("streakUsed2", 1);
  thread pc_watchstreakuseslot("streakUsed3", 2);
  thread pc_watchstreakuseslot("streakUsed4", 3);
  thread pc_watchstreakuseslot("streakUsed5", 4);
}

pc_watchstreakuseslot(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");
  var_02 = self.var_01A7;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  for(;;) {
    self waittill(param_00);
    if(common_scripts\utility::func_55E0()) {
      continue;
    }

    if(isDefined(self.var_20CC) && self.var_20CC == "none") {
      continue;
    }

    if(self.pcwaitingforkillstreakweaponchange) {
      continue;
    }

    if(self.var_012C["killstreaks"][param_01].var_13AF && self.var_0887[param_01]) {
      self.var_5A69 = param_01;
    }

    if(isDefined(self.var_5A69) && !self.var_012C["killstreaks"][self.var_5A69].var_13AF) {
      self.var_5A69 = undefined;
    }

    if(isDefined(self.var_5A69)) {
      var_04 = 0;
      if(!isbot(self)) {
        func_2F8C();
      }

      self.pcwaitingforkillstreakweaponchange = 1;
      for(;;) {
        if(maps\mp\_utility::isdogfightgametype()) {
          wait 0.05;
          break;
        }

        self waittill("weapon_change", var_05);
        if(isDefined(self.var_5A69)) {
          var_06 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][self.var_5A69].var_944C, var_02, var_03);
          if(var_05 == var_06 && func_1F6E()) {
            var_04 = 1;
            break;
          }

          if(var_05 == "none" && self isusingturret()) {
            self switchtoweapon(self.var_5B94);
            break;
          }

          if(var_05 == var_06 || var_05 == "none" || ((var_06 == "killstreak_uav_axis_mp" || var_06 == "killstreak_uav_mp") && var_05 == "uav_remote_mp") || var_06 == "killstreak_recreation_mp" && var_05 == "uav_remote_mp") {
            continue;
          }

          break;
        }

        break;
      }

      self.pcwaitingforkillstreakweaponchange = 0;
      if(!isbot(self)) {
        func_365A();
      }

      if(!var_04) {
        self.var_5A69 = undefined;
      }
    }
  }
}

func_2F8C() {
  for(var_00 = 0; var_00 < 5; var_00++) {
    if(!isDefined(self.var_5A69)) {
      break;
    }

    if(self.var_5A69 == var_00) {
      continue;
    }

    maps\mp\_utility::func_06D0(var_00 + 4, "");
    self.var_0887[var_00] = 0;
  }
}

func_365A() {
  var_00 = self.var_01A7;
  var_01 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  for(var_02 = 0; var_02 < 5; var_02++) {
    if(!isDefined(self.var_012C["killstreaks"][var_02])) {
      continue;
    }

    if(self.var_012C["killstreaks"][var_02].var_13AF) {
      var_03 = maps\mp\_utility::func_454A(self.var_012C["killstreaks"][var_02].var_944C, var_00, var_01);
      maps\mp\_utility::func_06D0(var_02 + 4, "weapon", var_03);
    } else {
      maps\mp\_utility::func_06D0(var_02 + 4, "");
    }

    self.var_0887[var_02] = 1;
  }
}

func_5A67(param_00, param_01, param_02) {
  if(isDefined(param_01) && isPlayer(param_00) && isDefined(param_02.var_0117) && isDefined(param_02.var_0117.var_01A7)) {
    if(((level.var_984D && param_02.var_0117.var_01A7 != param_00.var_01A7) || !level.var_984D) && param_00 != param_02.var_0117) {
      if(maps\mp\_utility::func_5740(param_01)) {
        return;
      }

      if(!isDefined(param_00.var_5BA9[param_01])) {
        param_00.var_5BA9[param_01] = 0;
      }

      if(param_00.var_5BA9[param_01] == gettime()) {
        return;
      }

      param_00.var_5BA9[param_01] = gettime();
      param_00 thread maps\mp\gametypes\_gamelogic::func_996D(param_01, 1, "hits");
      var_03 = param_00 maps\mp\gametypes\_persistence::func_9330("totalShots");
      var_04 = param_00 maps\mp\gametypes\_persistence::func_9330("hits") + 1;
      if(var_04 <= var_03) {
        param_00 maps\mp\gametypes\_persistence::func_9339("hits", var_04);
        param_00 maps\mp\gametypes\_persistence::func_9339("misses", int(var_03 - var_04));
        var_05 = clamp(float(var_04) / float(var_03), 0, 1) * 10000;
        param_00 maps\mp\gametypes\_persistence::func_9339("accuracy", int(var_05));
        return;
      }
    }
  }
}