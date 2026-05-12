/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spectating.gsc
*********************************************/

func_00D5() {
  level.var_90E2["allies"] = spawnStruct();
  level.var_90E2["axis"] = spawnStruct();
  level.var_90E2["none"] = spawnStruct();
  level thread maps\mp\gametypes\_broadcaster::func_00D5();
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B49();
    var_00 thread func_6B48();
    var_00 thread func_6BAC();
  }
}

func_6B49() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    func_872F();
  }
}

func_6B48() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_spectators");
    func_872F();
    if(!maps\mp\_utility::func_551F() && !function_0367() && self method_8436() || isDefined(self.var_012C["broadcaster"]) && self.var_012C["broadcaster"]) {
      maps\mp\gametypes\_broadcaster::func_1C8B();
      self method_8506(1);
    }
  }
}

func_A0E7() {
  self endon("disconnect");
  if(self method_8436()) {
    for(;;) {
      level waittill("player_spawned", var_00);
      var_01 = var_00.var_90E4;
      if(isDefined(var_01)) {
        if(isDefined(var_01.var_7709)) {
          self method_8534(maps\mp\_utility::func_4737(var_01.var_7709));
        }

        if(isDefined(var_01.var_835D)) {
          self method_8534(maps\mp\_utility::func_4737(var_01.var_835D));
        }
      }
    }
  }
}

func_6BAC() {
  self endon("disconnect");
  thread func_A0E7();
  var_00 = self getspectatingplayer();
  self.var_90E1 = var_00;
  for(;;) {
    self waittill("spectating_cycle");
    if(isPlayer(self) && isDefined(var_00)) {
      if(var_00 maps\mp\_utility::func_0649("specialty_perception") || var_00 maps\mp\_utility::func_0649("specialty_class_perception")) {
        thread maps\mp\gametypes\_killcam::func_238F(var_00);
      }

      if(isDefined(var_00.var_0079)) {
        thread maps\mp\gametypes\_killcam::func_237D(var_00);
      }
    }

    var_00 = self getspectatingplayer();
    self.var_90E1 = var_00;
    if(isDefined(var_00)) {
      self setcarddisplayslot(var_00, 6);
      if(self method_8436()) {
        func_A168(var_00);
      }
    }
  }
}

func_A16A() {
  level endon("game_ended");
  for(var_00 = 0; var_00 < level.var_744A.size; var_00++) {
    level.var_744A[var_00] func_872F();
  }
}

func_872F() {
  var_00 = self.var_0179;
  if(level.var_3F9D && gettime() - level.var_3F9F >= 2000) {
    if(level.var_6520) {
      for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
        self allowspectateteam(level.var_985B[var_01], 0);
      }
    } else {
      self allowspectateteam("allies", 0);
      self allowspectateteam("axis", 0);
    }

    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 1);
    return;
  }

  var_02 = maps\mp\gametypes\_tweakables::func_46F7("game", "spectatetype");
  var_03 = maps\mp\gametypes\_tweakables::func_46F7("game", "lockspectatepov");
  if(common_scripts\utility::func_562E(level.disableprespawnspectator) && !common_scripts\utility::func_562E(self.var_4B96) && isDefined(self.var_01A7) && self.var_01A7 != "spectator") {
    var_02 = 0;
  }

  if(self method_8436() && !maps\mp\_utility::func_551F()) {
    var_02 = 1;
  }

  if(isDefined(level.var_585D) && level.var_585D) {
    var_02 = 1;
  }

  if(getdvarint("4605") && self ishost()) {
    var_02 = 2;
  }

  switch (var_02) {
    case 0:
      if(level.var_6520) {
        for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
          self allowspectateteam(level.var_985B[var_01], 0);
        }
      } else {
        self allowspectateteam("allies", 0);
        self allowspectateteam("axis", 0);
      }

      self allowspectateteam("freelook", 0);
      self allowspectateteam("none", 0);
      break;

    case 1:
      if(!level.var_984D) {
        self allowspectateteam("allies", 1);
        self allowspectateteam("axis", 1);
        self allowspectateteam("none", 1);
        self allowspectateteam("freelook", 0);
      } else if(isDefined(var_00) && (var_00 == "allies" || var_00 == "axis") && !level.var_6520) {
        self allowspectateteam(var_00, 1);
        self allowspectateteam(maps\mp\_utility::func_45DE(var_00), 0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else if(isDefined(var_00) && issubstr(var_00, "team_") && level.var_6520) {
        for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
          if(var_00 == level.var_985B[var_01]) {
            self allowspectateteam(level.var_985B[var_01], 1);
            continue;
          }

          self allowspectateteam(level.var_985B[var_01], 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      } else {
        if(level.var_6520) {
          for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
            self allowspectateteam(level.var_985B[var_01], 0);
          }
        } else {
          self allowspectateteam("allies", 0);
          self allowspectateteam("axis", 0);
        }

        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
      }
      break;

    case 2:
      if(level.var_6520) {
        for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
          self allowspectateteam(level.var_985B[var_01], 1);
        }
      } else {
        self allowspectateteam("allies", 1);
        self allowspectateteam("axis", 1);
      }

      self allowspectateteam("freelook", 1);
      self allowspectateteam("none", 1);
      break;
  }

  var_04 = self getxuid();
  switch (var_03) {
    case 0:
      self forcespectatepov(var_04, "freelook");
      break;

    case 1:
      if(level.var_984D) {
        self allowspectateteam("none", 0);
      }

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_04, "first_person");
      break;

    case 2:
      if(level.var_984D) {
        self allowspectateteam("none", 0);
      }

      self allowspectateteam("freelook", 0);
      self forcespectatepov(var_04, "third_person");
      break;
  }

  if(isDefined(var_00) && var_00 == "axis" || var_00 == "allies" || var_00 == "none") {
    if(isDefined(level.var_90E2[var_00].var_0C24)) {
      self allowspectateteam("freelook", 1);
    }

    if(isDefined(level.var_90E2[var_00].var_0C22)) {
      self allowspectateteam(maps\mp\_utility::func_45DE(var_00), 1);
    }

    if(isDefined(level.var_90E2[var_00].allownonespectate)) {
      self allowspectateteam("none", 1);
    }
  }
}

func_A169(param_00, param_01, param_02) {
  var_03 = 0;
  if(isDefined(param_01) && param_01 != 0) {
    var_03 = tablelookuprownum("mp/statstable.csv", 18, param_01);
  }

  self setclientomnvar(param_00 + "weapon", var_03);
  for(var_04 = 0; var_04 < param_02.size; var_04++) {
    var_05 = undefined;
    if(isDefined(param_02[var_04]) && param_02[var_04] != 0) {
      var_05 = maps\mp\_utility::func_452B(param_02[var_04]);
    }

    if(!isDefined(var_05)) {
      var_05 = 0;
    }

    self setclientomnvar(param_00 + "attachment_" + var_04, var_05);
  }
}

func_A168(param_00) {
  var_01 = param_00.var_90E4;
  var_02 = maps\mp\_utility::func_4604();
  var_03 = 3;
  func_A169("ui_broadcaster_loadout_primary_", var_01.var_7709.var_48CA, [var_01.var_76F3[0], var_01.var_76F3[1], var_01.var_76F3[2]]);
  func_A169("ui_broadcaster_loadout_secondary_", var_01.var_835D.var_48CA, [var_01.var_8353[0], var_01.var_8353[1]]);
  var_04 = 0;
  if(isDefined(var_01.var_69AD)) {
    var_05 = maps\mp\_utility::func_44CD(var_01.var_69AD);
    var_04 = tablelookuprownum(var_02, 1, var_05);
  }

  self setclientomnvar("ui_broadcaster_loadout_equipment_0", var_04);
  var_06 = 0;
  if(isDefined(var_01.var_37FE)) {
    var_07 = maps\mp\_utility::func_44CD(var_01.var_37FE);
    var_06 = tablelookuprownum(var_02, 1, var_07);
  }

  self setclientomnvar("ui_broadcaster_loadout_equipment_1", var_06);
  if(isDefined(var_01.var_37FA) && var_01.var_37FA) {
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", var_06);
  } else {
    self setclientomnvar("ui_broadcaster_loadout_equipment_2", -1);
  }

  var_08 = [var_01.var_5A62, var_01.var_5A63, var_01.var_5A64, var_01.var_5A65];
  for(var_09 = 0; var_09 < 4; var_09++) {
    var_0A = var_08[var_09];
    var_0B = undefined;
    if(isDefined(var_0A) && var_0A != 0) {
      var_0C = maps\mp\_utility::func_452B(var_0A);
      var_0B = tablelookuprownum("mp/killstreakTable.csv", 1, var_0C);
    }

    if(!isDefined(var_0B)) {
      var_0B = 0;
    }

    self setclientomnvar("ui_broadcaster_loadout_streak_" + var_09, var_0B);
  }

  var_0D = var_01.var_6F69[var_03];
  var_0E = undefined;
  if(isDefined(var_0D) && var_0D != 0) {
    var_0F = maps\mp\_utility::func_452B(var_0D);
    var_0E = tablelookuprownum(var_02, 1, var_0F);
  } else {
    var_0E = 0;
  }

  self setclientomnvar("ui_broadcaster_loadout_training", var_0E);
}