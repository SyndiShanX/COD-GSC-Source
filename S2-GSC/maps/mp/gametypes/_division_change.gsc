/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_division_change.gsc
**************************************************/

func_8622(param_00, param_01) {
  self notify("division_change");
  self endon("division_change");
  self endon("death");
  self endon("disconnect");
  if(function_01EF(self) || isbot(self)) {
    return;
  }

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    func_8725(2, param_01);
    func_8725(3, param_01);
    func_8725(0, param_01);
    return;
  }

  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }

  if(!isDefined(param_00) || param_00 == 5) {
    func_A050();
  }

  while(!maps\mp\_utility::func_3FA0("prematch_done")) {
    wait 0.05;
  }

  thread func_6379();
  if(1) {
    func_8725(param_00, param_01);
    return;
  }

  func_8725(0, param_01);
  func_8725(1, param_01);
  func_8725(2, param_01);
  func_8725(3, param_01);
  func_8725(4, param_01);
  func_8725(6, param_01);
  func_8725(7, param_01);
  func_8725(8, param_01);
  func_8725(9, param_01);
  func_8725(10, param_01);
}

func_A050() {
  if(function_01EF(self) || isbot(self)) {
    return;
  }

  func_A07E(0);
  func_A07E(1);
  func_A07E(2);
  func_A07E(3);
  func_A07E(4);
  func_A07E(6);
  func_A07E(7);
  func_A07E(8);
  func_A07E(9);
  func_A07E(10);
}

func_A07E(param_00) {
  if(!isDefined(param_00) || !func_0F5B(param_00)) {
    return;
  }

  var_01 = maps\mp\gametypes\_divisions::func_461C(param_00);
  switch (var_01) {
    case "incendiary_level3":
    case "incendiary_level2":
    case "incendiary_level1":
      break;

    case "bipod_level3":
    case "bipod_level2":
    case "bipod_level1":
      self notify("endMonitorLMGMount");
      self notify("weapon_plant_cleanup");
      break;

    case "bayonet_level3":
    case "shield_charge":
      if(maps\mp\_utility::func_0649("specialty_sprintmeleechargelonger")) {
        maps\mp\_utility::func_0735("specialty_sprintmeleechargelonger");
      }
      break;

    case "bayonet_level2":
      if(maps\mp\_utility::func_0649("specialty_sprintmeleecharge")) {
        maps\mp\_utility::func_0735("specialty_sprintmeleecharge");
      }
      break;

    case "bayonet_level1":
      break;

    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;

    case "sharpshooter_level3":
    case "sharpshooter_level2":
      if(maps\mp\_utility::func_0649("specialty_marksmanvision")) {
        maps\mp\_utility::func_0735("specialty_marksmanvision");
      }

      if(maps\mp\_utility::func_0649("specialty_improvedholdbreath")) {
        maps\mp\_utility::func_0735("specialty_improvedholdbreath");
      }
      break;

    case "sharpshooter_level1":
      break;

    case "flashhider_level3":
    case "ironsight_level3":
    case "adjustablesight_level3":
    case "riflegrenade_level3":
    case "tacticalknife_level3":
    case "skill_level0":
    default:
      break;
  }
}

func_8725(param_00, param_01) {
  if(function_01EF(self) || isbot(self)) {
    return;
  }

  if(maps\mp\_utility::func_585F()) {
    maps\mp\_utility::func_47A2("specialty_sprintmeleechargelonger");
  }

  if(!isDefined(param_00) || !func_0F5B(param_00)) {
    return;
  }

  var_02 = maps\mp\gametypes\_divisions::func_461C(param_00);
  switch (var_02) {
    case "incendiary_level3":
    case "incendiary_level2":
    case "incendiary_level1":
      break;

    case "bipod_level3":
    case "bipod_level2":
    case "bipod_level1":
      thread func_63AC(param_01);
      break;

    case "bayonet_level3":
    case "shield_charge":
      maps\mp\_utility::func_47A2("specialty_sprintmeleechargelonger");
      break;

    case "bayonet_level2":
      maps\mp\_utility::func_47A2("specialty_sprintmeleecharge");
      break;

    case "bayonet_level1":
      break;

    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;

    case "sharpshooter_level3":
    case "sharpshooter_level2":
      maps\mp\_utility::func_47A2("specialty_marksmanvision");
      maps\mp\_utility::func_47A2("specialty_improvedholdbreath");
      break;

    case "sharpshooter_level1":
      break;

    case "flashhider_level3":
    case "ironsight_level3":
    case "adjustablesight_level3":
    case "riflegrenade_level3":
    case "tacticalknife_level3":
    case "skill_level0":
    default:
      break;
  }
}

func_5830(param_00) {
  return !maps\mp\_utility::func_568F(param_00) && !maps\mp\_utility::func_5740(param_00) && maps\mp\_utility::func_472A(param_00) == "weapon_heavy" && !issubstr(param_00, "bipod");
}

func_574C(param_00) {
  return isDefined(param_00) && maps\mp\_utility::func_472A(param_00) == "weapon_heavy" && issubstr(param_00, "bipod");
}

func_63AC(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self endon("endMonitorLMGMount");
  wait 0.05;
  if(func_5830(param_00)) {
    maps\mp\_utility::func_3FA5("prematch_done");
    common_scripts\_plant_weapon::func_5369(param_00);
  }

  for(;;) {
    self waittill("weapon_change", var_01);
    wait 0.05;
    if(var_01 != param_00 && func_5830(var_01)) {
      if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && self.var_0079 == 6 && isDefined(self.var_012C["resistanceScramblerIndicatorActive"])) {} else {
        common_scripts\_plant_weapon::func_5369(var_01);
      }
    } else if(function_0367() && !common_scripts\utility::func_562E(self.var_5721) || common_scripts\utility::func_562E(self.var_572A)) {
      self method_8114(0);
    }

    param_00 = var_01;
  }
}

func_6379() {
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("division_change");
  level endon("game_ended");
  self waittill("death");
  thread func_A050();
}

func_4B98(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 0;
  }

  foreach(var_03 in param_01) {
    switch (param_00) {
      case "sharpshooter_level3":
      case "sharpshooter_level2":
      case "sharpshooter_level1":
        if(issubstr(var_03, "iron_sight_sniper") || issubstr(var_03, "telescopic_sight")) {
          return 1;
        }
        break;

      case "incendiary_level3":
      case "incendiary_level2":
      case "incendiary_level1":
        if(issubstr(var_03, "m30_rifle")) {
          return 1;
        }
        break;

      case "tacticalknife_level3":
        if(issubstr(var_03, "akimbo")) {
          return 1;
        }
        break;

      case "flashhider_level3":
      case "ironsight_level3":
      case "adjustablesight_level3":
      case "riflegrenade_level3":
      case "bipod_level3":
      case "bipod_level2":
      case "bipod_level1":
      case "bayonet_level1":
      case "skill_level0":
      case "bayonet_level3":
      case "bayonet_level2":
      case "suppressor_level3":
      case "suppressor_level2":
      case "suppressor_level1":
      default:
        break;
    }
  }

  return 0;
}

func_440E(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    var_06 = [];
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 2, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 3, param_02, param_03, param_04, param_05));
    if(param_01 == 7) {
      var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 7, param_02, param_03, param_04, param_05));
    }

    return var_06;
  }

  if(isDefined(level.disabledivisionskills) && level.disabledivisionskills) {
    return [];
  }

  var_06 = [];
  if(1) {
    var_06 = func_4688(param_00, param_01, param_02, param_03, param_04, param_05);
  } else {
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 0, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 1, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 2, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 3, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 4, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 6, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 7, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 8, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 9, param_02, param_03, param_04, param_05));
    var_06 = common_scripts\utility::func_0F73(var_06, func_4688(param_00, 10, param_02, param_03, param_04, param_05));
  }

  return var_06;
}

func_4688(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  var_07 = maps\mp\_utility::func_45B5(getweapondisplayname(param_02));
  if(!func_0F5B(param_01)) {
    return [];
  }

  if(!func_56C9(param_02)) {
    return [];
  }

  var_08 = param_00 maps\mp\gametypes\_divisions::func_461C(param_01);
  if(func_4B98(var_08, param_05)) {
    return [];
  }

  var_09 = undefined;
  var_0A = undefined;
  var_0B = undefined;
  var_0C = undefined;
  switch (var_08) {
    case "incendiary_level3":
      var_09 = "_3";
      break;

    case "incendiary_level2":
      if(!isDefined(var_09)) {
        var_09 = "_2";
      }

      break;

    case "incendiary_level1":
      if(!isDefined(var_09)) {
        var_09 = "_1";
      }

      var_0D = !maps\mp\_utility::func_56B1() && !function_03AF();
      if(!param_04 && var_0D) {
        if(maps\mp\_utility::func_472A(param_02) == "weapon_shotgun") {
          var_0E = "";
          switch (var_07) {
            case "model21_mp":
            case "m30_mp":
              var_0E = "dragon_breath_break";
              break;

            case "walther_mp":
              var_0E = "dragon_breath_magazine";
              break;

            case "winchester1897_mp":
              var_0E = "dragon_breath_bolt_action";
              break;

            default:
              break;
          }

          if(var_0E != "") {
            var_0E = var_0E + var_09;
            var_06[var_06.size] = var_0E;
          }
        }
      }
      break;

    case "bipod_level3":
      var_0A = "_3";
      break;

    case "bipod_level2":
      if(!isDefined(var_0A)) {
        var_0A = "_2";
      }

      break;

    case "bipod_level1":
      if(!isDefined(var_0A)) {
        var_0A = "_1";
      }

      if(param_03) {
        if(maps\mp\_utility::func_472A(param_02) == "weapon_heavy") {
          var_0F = "bipod";
          var_0F = var_0F + var_0A;
          var_06[var_06.size] = var_0F;
        }
      }
      break;

    case "bayonet_level1":
    case "bayonet_level3":
    case "bayonet_level2":
      if(maps\mp\_utility::func_472A(param_02) == "weapon_assault") {
        var_10 = "";
        switch (var_07) {
          case "bar_mp":
          case "m1941_mp":
          case "svt40_mp":
          case "m1a1_mp":
            var_10 = "bayonet_allies";
            break;

          case "m1garand_mp":
            var_10 = "bayonet_m1garand";
            break;

          case "volk_mp":
          case "stg44_mp":
          case "fg42_mp":
          case "type5_mp":
          case "g43_mp":
            var_10 = "bayonet_axis";
            break;

          default:
            break;
        }

        if(var_10 != "") {
          var_06[var_06.size] = var_10;
        }
      }
      break;

    case "suppressor_level3":
      var_0B = "_3";
      break;

    case "suppressor_level2":
      if(!isDefined(var_0B)) {
        var_0B = "_2";
      }

      break;

    case "suppressor_level1":
      if(!isDefined(var_0B)) {
        var_0B = "_1";
      }

      if(maps\mp\_utility::func_472A(param_02) == "weapon_smg") {
        var_11 = "";
        switch (var_07) {
          case "mas38_mp":
          case "ppsh41_mp":
          case "sten_mp":
          case "thompson_mp":
            var_11 = "suppressor_smg_allies";
            break;

          case "greasegun_mp":
            var_11 = "suppressor_greasegun";
            break;

          case "type100_mp":
          case "mp28_mp":
          case "beretta_mp":
          case "mp40_mp":
            var_11 = "suppressor_smg_axis";
            break;

          default:
            break;
        }

        if(var_11 != "") {
          var_11 = var_11 + var_0B;
          var_06[var_06.size] = var_11;
        }
      }
      break;

    case "sharpshooter_level3":
      var_0C = "_3";
      break;

    case "sharpshooter_level2":
    case "sharpshooter_level1":
      if(!isDefined(var_0C)) {
        var_0C = "_1";
      }

      if(maps\mp\_utility::func_472A(param_02) == "weapon_sniper") {
        var_12 = "hold_breath";
        var_12 = var_12 + var_0C;
        var_06[var_06.size] = var_12;
      }
      break;

    case "tacticalknife_level3":
      if(maps\mp\_utility::func_472A(param_02) == "weapon_pistol") {
        var_13 = "tactical_knife";
        var_06[var_06.size] = var_13;
      }
      break;

    case "riflegrenade_level3":
      if(!param_04) {
        if(maps\mp\_utility::func_472A(param_02) == "weapon_assault") {
          var_14 = "";
          switch (var_07) {
            case "bar_mp":
            case "m1941_mp":
            case "svt40_mp":
            case "m1a1_mp":
            case "m1garand_mp":
              var_14 = "grenade_launcher_allies";
              break;

            case "m1935_mp":
            case "volk_mp":
            case "stg44_mp":
            case "fg42_mp":
            case "type5_mp":
            case "g43_mp":
              var_14 = "grenade_launcher_axis";
              break;

            default:
              break;
          }

          if(var_14 != "") {
            var_06[var_06.size] = var_14;
          }
        }
      }
      break;

    case "shield_charge":
      if(param_02 == "riotshield_mp") {
        var_15 = "shield_charge";
        var_06[var_06.size] = var_15;
      }
      break;

    case "flashhider_level3":
    case "ironsight_level3":
    case "skill_level0":
    default:
      break;
  }

  return var_06;
}

func_56CA(param_00, param_01) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    return 0;
  }

  var_02 = maps\mp\_utility::func_472A(param_00);
  switch (var_02) {
    case "weapon_shotgun":
      if(issubstr(param_01, "dragon_breath_")) {
        return 1;
      }
      break;

    case "weapon_heavy":
      if(issubstr(param_01, "bipod")) {
        return 1;
      }
      break;

    case "weapon_assault":
      if(issubstr(param_01, "bayonet_")) {
        return 1;
      }

      if(issubstr(param_01, "grenade_launcher")) {
        return 1;
      }
      break;

    case "weapon_smg":
      if(issubstr(param_01, "suppressor_")) {
        return 1;
      }
      break;

    case "weapon_sniper":
      if(issubstr(param_01, "hold_breath")) {
        return 1;
      }
      break;

    case "weapon_pistol":
      if(issubstr(param_01, "tacticalknife")) {
        return 1;
      }
      break;
  }

  return 0;
}

func_7CCD(param_00) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    return param_00;
  }

  if(!isDefined(param_00) || param_00 == "none") {
    return param_00;
  }

  if(!func_56C9(param_00)) {
    return param_00;
  }

  var_01 = maps\mp\_utility::func_4738(param_00);
  var_02 = var_01[0];
  for(var_03 = 1; var_03 < var_01.size; var_03++) {
    if(!func_56CA(param_00, var_01[var_03])) {
      var_02 = var_02 + "+";
      var_02 = var_02 + var_01[var_03];
    }
  }

  return var_02;
}

removealtmodeattachmentsfromweapon(param_00) {
  if(!isDefined(param_00) || param_00 == "none") {
    return param_00;
  }

  var_01 = maps\mp\_utility::func_4738(param_00);
  var_02 = var_01[0];
  for(var_03 = 1; var_03 < var_01.size; var_03++) {
    if(!issubstr(var_01[var_03], "dragon_breath_") && !issubstr(var_01[var_03], "grenade_launcher") && !issubstr(var_01[var_03], "suppressor_smg_") && !issubstr(var_01[var_03], "suppressor_greasegun_") && !issubstr(var_01[var_03], "m30_rifle")) {
      var_02 = var_02 + "+";
      var_02 = var_02 + var_01[var_03];
    }
  }

  return var_02;
}

func_0995(param_00, param_01, param_02, param_03, param_04) {
  if(param_01 == 5) {
    return param_02;
  }

  if(!func_56C9(param_02)) {
    return param_02;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_05 = maps\mp\_utility::func_472B(param_02);
  var_06 = maps\mp\_utility::func_4728(param_02);
  var_07 = maps\mp\_utility::func_473A(param_02);
  var_08 = maps\mp\_utility::func_472F(param_02);
  var_09 = function_0061(param_02);
  var_09 = common_scripts\utility::func_0F93(var_09, "special_grip");
  var_0A = func_440E(param_00, param_01, param_02, param_03, param_04, var_09);
  var_09 = common_scripts\utility::func_0F73(var_09, var_0A);
  var_09 = common_scripts\utility::func_0C9E(var_09);
  var_0B = getweapondisplayname(param_02);
  var_0C = var_0B;
  foreach(var_0E in var_09) {
    var_0C = var_0C + "+" + var_0E;
  }

  if(isDefined(var_05) && var_05 != "") {
    var_0C = var_0C + "+" + var_05;
  }

  if(isDefined(var_06) && var_06 != "") {
    var_0C = var_0C + "+" + var_06;
  }

  if(isDefined(var_07) && var_07 != "") {
    var_0C = var_0C + "+" + var_07;
  }

  if(isDefined(var_08) && var_08 != "") {
    var_0C = var_0C + "+" + var_08;
  }

  return var_0C;
}

func_56C9(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  switch (maps\mp\_utility::func_472A(param_00)) {
    case "weapon_other":
    case "weapon_pistol":
    case "weapon_heavy":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      return 1;

    default:
      return 0;
  }
}

func_0F5B(param_00) {
  if(getdvarint("5572", 1) == 0) {
    return 0;
  }

  if(isDefined(level.disabledivisionskills) && level.disabledivisionskills) {
    return 0;
  }

  if(!maps\mp\_utility::isdivisionsglobaloverhaulenabled() && isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return 0;
  }

  var_01 = "5572";
  switch (param_00) {
    case 0:
      var_01 = "4769";
      break;

    case 3:
      var_01 = "3669";
      break;

    case 1:
      var_01 = "5809";
      break;

    case 2:
      var_01 = "150";
      break;

    case 4:
      var_01 = "4740";
      break;

    case 6:
      return maps\mp\_utility::isproductionlevelactive(7);

    case 7:
      return maps\mp\_utility::isproductionlevelactive(13);

    case 8:
      return maps\mp\_utility::isproductionlevelactive(18);

    case 9:
      return maps\mp\_utility::isproductionlevelactive(23);

    case 10:
      return maps\mp\_utility::isproductionlevelactive(23);

    case 5:
    default:
      return 0;
  }

  return getdvarint(var_01, 1) == 1;
}

func_3657(param_00, param_01) {
  if(function_01EF(self) || isbot(self)) {
    return;
  }

  if(!func_0F5B(param_00)) {
    return;
  }

  thread func_A8FA(param_00, param_01);
  if(!isDefined(level.var_A4BE)) {
    level.var_A4BE["intensity"] = 0.3;
    level.var_A4BE["falloff"] = 1.2;
    level.var_A4BE["scaleX"] = 1;
    level.var_A4BE["scaleY"] = 1;
    level.var_A4BE["squareAspectRatio"] = 0;
    level.var_A4BE["lerpDuration"] = 0.4;
  }

  if(!isDefined(level.var_A4B5)) {
    level.var_A4B5["intensity"] = 0.2;
    level.var_A4B5["falloff"] = 1.2;
    level.var_A4B5["scaleX"] = 1;
    level.var_A4B5["scaleY"] = 1;
    level.var_A4B5["squareAspectRatio"] = 0;
    level.var_A4B5["lerpDuration"] = 0.1;
  }

  var_02 = undefined;
  if(isDefined(level.var_A4BE)) {
    var_02 = level.var_A4BE;
  }

  switch (param_01) {
    case "flashhider_level3":
    case "ironsight_level3":
    case "adjustablesight_level3":
    case "riflegrenade_level3":
    case "tacticalknife_level3":
    case "bipod_level3":
    case "bipod_level2":
    case "bipod_level1":
    case "bayonet_level1":
    case "skill_level0":
    case "incendiary_level3":
    case "incendiary_level2":
    case "incendiary_level1":
    case "shield_charge":
    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;

    case "sharpshooter_level3":
    case "sharpshooter_level2":
    case "sharpshooter_level1":
      var_02["intensity"] = 1;
      var_02["falloff"] = 0.6;
      var_02["scaleX"] = 1;
      var_02["scaleY"] = 1;
      var_02["squareAspectRatio"] = 1;
      var_02["lerpDuration"] = 0.4;
      self setclientomnvar("ui_hide_hud", 1);
      maps\mp\_snd_common_mp::func_8D7E();
      break;

    case "bayonet_level3":
    case "bayonet_level2":
      var_03 = common_scripts\utility::func_44F5("divisions_bayonet_charge");
      playfxontagforclients(var_03, self, "j_head", self);
      var_02["intensity"] = 0.2;
      var_02["falloff"] = 1.2;
      var_02["scaleX"] = 1;
      var_02["scaleY"] = 1;
      var_02["squareAspectRatio"] = 0;
      var_02["lerpDuration"] = 0.4;
      self method_8036(1.046, 1);
      self setscriptmotionblurparams(2, 0, 1);
      break;

    default:
      break;
  }

  if(isDefined(var_02)) {
    self vignettesetparams(var_02["intensity"], var_02["falloff"], var_02["scaleX"], var_02["scaleY"], var_02["squareAspectRatio"], var_02["lerpDuration"]);
  }
}

func_2F7B(param_00, param_01, param_02, param_03) {
  if(!isDefined(self)) {
    return;
  }

  if(function_01EF(self) || isbot(self)) {
    return;
  }

  if(!func_0F5B(param_00)) {
    return;
  }

  self notify("removeDivisionVignette");
  var_04 = self;
  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  switch (param_01) {
    case "flashhider_level3":
    case "ironsight_level3":
    case "adjustablesight_level3":
    case "riflegrenade_level3":
    case "tacticalknife_level3":
    case "bipod_level3":
    case "bipod_level2":
    case "bipod_level1":
    case "bayonet_level1":
    case "skill_level0":
    case "incendiary_level3":
    case "incendiary_level2":
    case "incendiary_level1":
    case "shield_charge":
    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;

    case "bayonet_level3":
    case "bayonet_level2":
      var_05 = common_scripts\utility::func_44F5("divisions_bayonet_charge");
      function_0295(var_05, var_04, "j_head", self);
      break;

    case "sharpshooter_level3":
    case "sharpshooter_level2":
    case "sharpshooter_level1":
      self setclientomnvar("ui_hide_hud", 0);
      if(!isDefined(param_03)) {
        maps\mp\_snd_common_mp::func_8D7D(1);
      } else {
        maps\mp\_snd_common_mp::func_8D7D(param_03);
      }
      break;

    default:
      break;
  }

  var_06 = undefined;
  if(isDefined(level.var_A4B5)) {
    var_06 = level.var_A4B5;
  }

  if(isDefined(var_06) && !isDefined(var_06["lerpDuration"])) {
    var_06["lerpDuration"] = 0.1;
  }

  if(isDefined(var_06)) {
    self vignettesetparams(var_06["intensity"], var_06["falloff"], var_06["scaleX"], var_06["scaleY"], var_06["squareAspectRatio"], var_06["lerpDuration"]);
  }

  if(maps\mp\_utility::func_579B() == 0) {
    if(self playerads() > 0) {
      self method_8036(1, 0.1);
    } else {
      self method_8036(1, 0.2);
    }
  }

  var_07 = undefined;
  if(isDefined(level.var_6465)) {
    var_07 = level.var_6465;
  }

  if(isDefined(var_07)) {
    self setscriptmotionblurparams(var_07["velocityscaler"], var_07["cameraRotationInfluence"], var_07["cameraTranslationInfluence"]);
    return;
  }

  self setscriptmotionblurparams(0, 0, 0);
}

func_A8FA(param_00, param_01) {
  self endon("disconnect");
  self endon("removeDivisionVignette");
  common_scripts\utility::func_A70A("death", "weapon_change");
  thread func_2F7B(param_00, param_01);
}

func_4499(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03) || !isDefined(param_01) || !isDefined(param_01.var_0079) || param_01.var_0079 == 5) {
    return param_00;
  }

  var_05 = 1;
  switch (maps\mp\_utility::func_472A(param_03)) {
    case "weapon_assault":
      if(isDefined(param_01.var_165B) && param_01.var_165B && isDefined(param_04) && maps\mp\_utility::func_5755(param_04)) {
        return "divisions_infantry_kill";
      }
      break;

    case "weapon_sniper":
      if(isDefined(param_01.var_8AE0) && param_01.var_8AE0) {
        return "divisions_mountain_kill";
      }
      break;

    case "weapon_smg":
      var_06 = issubstr(param_03, "zk383");
      if((maps\mp\_utility::func_5670(param_03) && !var_06) || var_06 && param_01.var_4B47) {
        return "divisions_airborne_kill";
      }
      break;

    case "weapon_heavy":
      if(issubstr(param_03, "bipod")) {
        return "divisions_armored_kill";
      }
      break;

    case "weapon_shotgun":
      if((maps\mp\_utility::func_5670(param_03) && issubstr(param_03, "dragon_breath_")) || maps\mp\_utility::func_5697(param_04, param_03)) {
        return "divisions_cavalry_kill";
      }
      break;

    case "weapon_pistol":
      if(issubstr(param_03, "tactical_knife") && isDefined(param_04) && maps\mp\_utility::func_5755(param_04)) {
        return "division_resistance_kill";
      }
      break;

    default:
      var_05 = 0;
      break;
  }

  return param_00;
}