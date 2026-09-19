/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_division_change.gsc
**********************************************************/

setclienttriggeraudiozone(var_0, var_1) {
  self notify("division_change");
  self endon("division_change");
  self endon("death");
  self endon("disconnect");

  if(_isagent(self) || isbot(self)) {
    return;
  }
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    _id_8725(2, var_1);
    _id_8725(3, var_1);
    _id_8725(0, var_1);
  } else {
    if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
      return;
    }
    if(!isDefined(var_0) || var_0 == 5)
      _id_A050();

    while(!maps\mp\_utility::gameflag("prematch_done"))
      waitframe();

    thread _id_6379();

    if(1) {
      _id_8725(var_0, var_1);
      return;
    }

    _id_8725(0, var_1);
    _id_8725(1, var_1);
    _id_8725(2, var_1);
    _id_8725(3, var_1);
    _id_8725(4, var_1);
    _id_8725(6, var_1);
    _id_8725(7, var_1);
    _id_8725(8, var_1);
    _id_8725(9, var_1);
    _id_8725(10, var_1);
  }
}

_id_A050() {
  if(_isagent(self) || isbot(self)) {
    return;
  }
  _id_A07E(0);
  _id_A07E(1);
  _id_A07E(2);
  _id_A07E(3);
  _id_A07E(4);
  _id_A07E(6);
  _id_A07E(7);
  _id_A07E(8);
  _id_A07E(9);
  _id_A07E(10);
}

_id_A07E(var_0) {
  if(!isDefined(var_0) || !_id_0F5B(var_0)) {
    return;
  }
  var_1 = _id_04CA::_id_461C(var_0);

  switch (var_1) {
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
      if(maps\mp\_utility::_hasperk("specialty_sprintmeleechargelonger"))
        maps\mp\_utility::_id_0735("specialty_sprintmeleechargelonger");

      break;
    case "bayonet_level2":
      if(maps\mp\_utility::_hasperk("specialty_sprintmeleecharge"))
        maps\mp\_utility::_id_0735("specialty_sprintmeleecharge");

      break;
    case "bayonet_level1":
      break;
    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;
    case "sharpshooter_level3":
    case "sharpshooter_level2":
      if(maps\mp\_utility::_hasperk("specialty_marksmanvision"))
        maps\mp\_utility::_id_0735("specialty_marksmanvision");

      if(maps\mp\_utility::_hasperk("specialty_improvedholdbreath"))
        maps\mp\_utility::_id_0735("specialty_improvedholdbreath");

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

_id_8725(var_0, var_1) {
  if(_isagent(self) || isbot(self)) {
    return;
  }
  if(maps\mp\_utility::_id_585F())
    maps\mp\_utility::giveperk("specialty_sprintmeleechargelonger");

  if(!isDefined(var_0) || !_id_0F5B(var_0)) {
    return;
  }
  var_2 = _id_04CA::_id_461C(var_0);

  switch (var_2) {
    case "incendiary_level3":
    case "incendiary_level2":
    case "incendiary_level1":
      break;
    case "bipod_level3":
    case "bipod_level2":
    case "bipod_level1":
      thread _id_63AC(var_1);
      break;
    case "bayonet_level3":
    case "shield_charge":
      maps\mp\_utility::giveperk("specialty_sprintmeleechargelonger");
      break;
    case "bayonet_level2":
      maps\mp\_utility::giveperk("specialty_sprintmeleecharge");
      break;
    case "bayonet_level1":
      break;
    case "suppressor_level3":
    case "suppressor_level2":
    case "suppressor_level1":
      break;
    case "sharpshooter_level3":
    case "sharpshooter_level2":
      maps\mp\_utility::giveperk("specialty_marksmanvision");
      maps\mp\_utility::giveperk("specialty_improvedholdbreath");
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

_id_5830(var_0) {
  return !maps\mp\_utility::_id_568F(var_0) && !maps\mp\_utility::iskillstreakweapon(var_0) && maps\mp\_utility::getweaponclass(var_0) == "weapon_heavy" && !issubstr(var_0, "bipod");
}

_id_574C(var_0) {
  return isDefined(var_0) && maps\mp\_utility::getweaponclass(var_0) == "weapon_heavy" && issubstr(var_0, "bipod");
}

_id_63AC(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self endon("endMonitorLMGMount");
  waitframe();

  if(_id_5830(var_0)) {
    maps\mp\_utility::gameflagwait("prematch_done");
    _id_028D::_id_5369(var_0);
  }

  for(;;) {
    self waittill("weapon_change", var_1);
    waitframe();

    if(var_1 != var_0 && _id_5830(var_1)) {
      if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && self._id_0079 == 6 && isDefined(self.pers["resistanceScramblerIndicatorActive"])) {} else
        _id_028D::_id_5369(var_1);
    } else if(_func_367() && !(common_scripts\utility::_id_562E(self._id_5721) || common_scripts\utility::_id_562E(self._id_572A)))
      self allowprone(0);

    var_0 = var_1;
  }
}

_id_6379() {
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("division_change");
  level endon("game_ended");
  self waittill("death");
  thread _id_A050();
}

_id_4B98(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  foreach(var_3 in var_1) {
    switch (var_0) {
      case "sharpshooter_level3":
      case "sharpshooter_level2":
      case "sharpshooter_level1":
        if(issubstr(var_3, "iron_sight_sniper") || issubstr(var_3, "telescopic_sight"))
          return 1;

        break;
      case "incendiary_level3":
      case "incendiary_level2":
      case "incendiary_level1":
        if(issubstr(var_3, "m30_rifle"))
          return 1;

        break;
      case "tacticalknife_level3":
        if(issubstr(var_3, "akimbo"))
          return 1;

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

_id_440E(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    var_6 = [];
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 2, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 3, var_2, var_3, var_4, var_5));

    if(var_1 == 7)
      var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 7, var_2, var_3, var_4, var_5));

    return var_6;
  }

  if(isDefined(level.disabledivisionskills) && level.disabledivisionskills)
    return [];

  var_6 = [];

  if(1)
    var_6 = _id_4688(var_0, var_1, var_2, var_3, var_4, var_5);
  else {
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 0, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 1, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 2, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 3, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 4, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 6, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 7, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 8, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 9, var_2, var_3, var_4, var_5));
    var_6 = common_scripts\utility::_id_0F73(var_6, _id_4688(var_0, 10, var_2, var_3, var_4, var_5));
  }

  return var_6;
}

_id_4688(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = maps\mp\_utility::_id_45B5(_getweaponbasename(var_2));

  if(!_id_0F5B(var_1))
    return [];

  if(!_id_56C9(var_2))
    return [];

  var_8 = var_0 _id_04CA::_id_461C(var_1);

  if(_id_4B98(var_8, var_5))
    return [];

  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  switch (var_8) {
    case "incendiary_level3":
      var_9 = "_3";
    case "incendiary_level2":
      if(!isDefined(var_9))
        var_9 = "_2";
    case "incendiary_level1":
      if(!isDefined(var_9))
        var_9 = "_1";

      var_13 = !maps\mp\_utility::_id_56B1() && !_func_3AF();

      if(!var_4 && var_13) {
        if(maps\mp\_utility::getweaponclass(var_2) == "weapon_shotgun") {
          var_14 = "";

          switch (var_7) {
            case "model21_mp":
            case "m30_mp":
              var_14 = "dragon_breath_break";
              break;
            case "walther_mp":
              var_14 = "dragon_breath_magazine";
              break;
            case "winchester1897_mp":
              var_14 = "dragon_breath_bolt_action";
              break;
            default:
              break;
          }

          if(var_14 != "") {
            var_14 = var_14 + var_9;
            var_6[var_6.size] = var_14;
          }
        }
      }

      break;
    case "bipod_level3":
      var_10 = "_3";
    case "bipod_level2":
      if(!isDefined(var_10))
        var_10 = "_2";
    case "bipod_level1":
      if(!isDefined(var_10))
        var_10 = "_1";

      if(var_3) {
        if(maps\mp\_utility::getweaponclass(var_2) == "weapon_heavy") {
          var_15 = "bipod";
          var_15 = var_15 + var_10;
          var_6[var_6.size] = var_15;
        }
      }

      break;
    case "bayonet_level1":
    case "bayonet_level3":
    case "bayonet_level2":
      if(maps\mp\_utility::getweaponclass(var_2) == "weapon_assault") {
        var_16 = "";

        switch (var_7) {
          case "bar_mp":
          case "m1941_mp":
          case "svt40_mp":
          case "m1a1_mp":
            var_16 = "bayonet_allies";
            break;
          case "m1garand_mp":
            var_16 = "bayonet_m1garand";
            break;
          case "volk_mp":
          case "stg44_mp":
          case "fg42_mp":
          case "type5_mp":
          case "g43_mp":
            var_16 = "bayonet_axis";
            break;
          default:
            break;
        }

        if(var_16 != "")
          var_6[var_6.size] = var_16;
      }

      break;
    case "suppressor_level3":
      var_11 = "_3";
    case "suppressor_level2":
      if(!isDefined(var_11))
        var_11 = "_2";
    case "suppressor_level1":
      if(!isDefined(var_11))
        var_11 = "_1";

      if(maps\mp\_utility::getweaponclass(var_2) == "weapon_smg") {
        var_17 = "";

        switch (var_7) {
          case "mas38_mp":
          case "ppsh41_mp":
          case "sten_mp":
          case "thompson_mp":
            var_17 = "suppressor_smg_allies";
            break;
          case "greasegun_mp":
            var_17 = "suppressor_greasegun";
            break;
          case "type100_mp":
          case "mp28_mp":
          case "beretta_mp":
          case "mp40_mp":
            var_17 = "suppressor_smg_axis";
            break;
          default:
            break;
        }

        if(var_17 != "") {
          var_17 = var_17 + var_11;
          var_6[var_6.size] = var_17;
        }
      }

      break;
    case "sharpshooter_level3":
      var_12 = "_3";
    case "sharpshooter_level2":
    case "sharpshooter_level1":
      if(!isDefined(var_12))
        var_12 = "_1";

      if(maps\mp\_utility::getweaponclass(var_2) == "weapon_sniper") {
        var_18 = "hold_breath";
        var_18 = var_18 + var_12;
        var_6[var_6.size] = var_18;
      }

      break;
    case "tacticalknife_level3":
      if(maps\mp\_utility::getweaponclass(var_2) == "weapon_pistol") {
        var_19 = "tactical_knife";
        var_6[var_6.size] = var_19;
      }

      break;
    case "riflegrenade_level3":
      if(!var_4) {
        if(maps\mp\_utility::getweaponclass(var_2) == "weapon_assault") {
          var_20 = "";

          switch (var_7) {
            case "bar_mp":
            case "m1941_mp":
            case "svt40_mp":
            case "m1a1_mp":
            case "m1garand_mp":
              var_20 = "grenade_launcher_allies";
              break;
            case "m1935_mp":
            case "volk_mp":
            case "stg44_mp":
            case "fg42_mp":
            case "type5_mp":
            case "g43_mp":
              var_20 = "grenade_launcher_axis";
              break;
            default:
              break;
          }

          if(var_20 != "")
            var_6[var_6.size] = var_20;
        }
      }

      break;
    case "shield_charge":
      if(var_2 == "riotshield_mp") {
        var_21 = "shield_charge";
        var_6[var_6.size] = var_21;
      }

      break;
    case "flashhider_level3":
    case "ironsight_level3":
    case "skill_level0":
    default:
      break;
  }

  return var_6;
}

_id_56CA(var_0, var_1) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
    return 0;

  var_2 = maps\mp\_utility::getweaponclass(var_0);

  switch (var_2) {
    case "weapon_shotgun":
      if(issubstr(var_1, "dragon_breath_"))
        return 1;

      break;
    case "weapon_heavy":
      if(issubstr(var_1, "bipod"))
        return 1;

      break;
    case "weapon_assault":
      if(issubstr(var_1, "bayonet_"))
        return 1;

      if(issubstr(var_1, "grenade_launcher"))
        return 1;

      break;
    case "weapon_smg":
      if(issubstr(var_1, "suppressor_"))
        return 1;

      break;
    case "weapon_sniper":
      if(issubstr(var_1, "hold_breath"))
        return 1;

      break;
    case "weapon_pistol":
      if(issubstr(var_1, "tacticalknife"))
        return 1;

      break;
  }

  return 0;
}

_id_7CCD(var_0) {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
    return var_0;

  if(!isDefined(var_0) || var_0 == "none")
    return var_0;

  if(!_id_56C9(var_0))
    return var_0;

  var_1 = maps\mp\_utility::_id_4738(var_0);
  var_2 = var_1[0];

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    if(!_id_56CA(var_0, var_1[var_3])) {
      var_2 = var_2 + "+";
      var_2 = var_2 + var_1[var_3];
    }
  }

  return var_2;
}

removealtmodeattachmentsfromweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "none")
    return var_0;

  var_1 = maps\mp\_utility::_id_4738(var_0);
  var_2 = var_1[0];

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    if(!issubstr(var_1[var_3], "dragon_breath_") && !issubstr(var_1[var_3], "grenade_launcher") && !issubstr(var_1[var_3], "suppressor_smg_") && !issubstr(var_1[var_3], "suppressor_greasegun_") && !issubstr(var_1[var_3], "m30_rifle")) {
      var_2 = var_2 + "+";
      var_2 = var_2 + var_1[var_3];
    }
  }

  return var_2;
}

_id_0995(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == 5)
    return var_2;

  if(!_id_56C9(var_2))
    return var_2;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = maps\mp\_utility::_id_472B(var_2);
  var_6 = maps\mp\_utility::_id_4728(var_2);
  var_7 = maps\mp\_utility::_id_473A(var_2);
  var_8 = maps\mp\_utility::_id_472F(var_2);
  var_9 = _getweaponattachments(var_2);
  var_9 = common_scripts\utility::_id_0F93(var_9, "special_grip");
  var_10 = _id_440E(var_0, var_1, var_2, var_3, var_4, var_9);
  var_9 = common_scripts\utility::_id_0F73(var_9, var_10);
  var_9 = common_scripts\utility::alphabetize(var_9);
  var_11 = _getweaponbasename(var_2);
  var_12 = var_11;

  foreach(var_14 in var_9)
  var_12 = var_12 + ("+" + var_14);

  if(isDefined(var_5) && var_5 != "")
    var_12 = var_12 + ("+" + var_5);

  if(isDefined(var_6) && var_6 != "")
    var_12 = var_12 + ("+" + var_6);

  if(isDefined(var_7) && var_7 != "")
    var_12 = var_12 + ("+" + var_7);

  if(isDefined(var_8) && var_8 != "")
    var_12 = var_12 + ("+" + var_8);

  return var_12;
}

_id_56C9(var_0) {
  if(var_0 == "none")
    return 0;

  switch (maps\mp\_utility::getweaponclass(var_0)) {
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

_id_0F5B(var_0) {
  if(getdvarint("5572", 1) == 0)
    return 0;

  if(isDefined(level.disabledivisionskills) && level.disabledivisionskills)
    return 0;

  if(!maps\mp\_utility::isdivisionsglobaloverhaulenabled() && isDefined(level.disabledivisionpassives) && level.disabledivisionpassives)
    return 0;

  var_1 = "5572";

  switch (var_0) {
    case 0:
      var_1 = "4769";
      break;
    case 3:
      var_1 = "3669";
      break;
    case 1:
      var_1 = "5809";
      break;
    case 2:
      var_1 = "150";
      break;
    case 4:
      var_1 = "4740";
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

  return getdvarint(var_1, 1) == 1;
}

_id_3657(var_0, var_1) {
  if(_isagent(self) || isbot(self)) {
    return;
  }
  if(!_id_0F5B(var_0)) {
    return;
  }
  thread _id_A8FA(var_0, var_1);

  if(!isDefined(level._id_A4BE)) {
    level._id_A4BE["intensity"] = 0.3;
    level._id_A4BE["falloff"] = 1.2;
    level._id_A4BE["scaleX"] = 1;
    level._id_A4BE["scaleY"] = 1;
    level._id_A4BE["squareAspectRatio"] = 0;
    level._id_A4BE["lerpDuration"] = 0.4;
  }

  if(!isDefined(level._id_A4B5)) {
    level._id_A4B5["intensity"] = 0.2;
    level._id_A4B5["falloff"] = 1.2;
    level._id_A4B5["scaleX"] = 1;
    level._id_A4B5["scaleY"] = 1;
    level._id_A4B5["squareAspectRatio"] = 0;
    level._id_A4B5["lerpDuration"] = 0.1;
  }

  var_2 = undefined;

  if(isDefined(level._id_A4BE))
    var_2 = level._id_A4BE;

  switch (var_1) {
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
      var_2["intensity"] = 1;
      var_2["falloff"] = 0.6;
      var_2["scaleX"] = 1;
      var_2["scaleY"] = 1;
      var_2["squareAspectRatio"] = 1;
      var_2["lerpDuration"] = 0.4;
      self setclientomnvar("ui_hide_hud", 1);
      _id_048E::_id_8D7E();
      break;
    case "bayonet_level3":
    case "bayonet_level2":
      var_3 = common_scripts\utility::_id_44F5("divisions_bayonet_charge");
      _playfxontagforclients(var_3, self, "j_head", self);
      var_2["intensity"] = 0.2;
      var_2["falloff"] = 1.2;
      var_2["scaleX"] = 1;
      var_2["scaleY"] = 1;
      var_2["squareAspectRatio"] = 0;
      var_2["lerpDuration"] = 0.4;
      self lerpfovscale(1.046, 1);
      self _meth_866F(2, 0, 1);
      break;
    default:
      break;
  }

  if(isDefined(var_2))
    self digitaldistortsetparams(var_2["intensity"], var_2["falloff"], var_2["scaleX"], var_2["scaleY"], var_2["squareAspectRatio"], var_2["lerpDuration"]);
}

_id_2F7B(var_0, var_1, var_2, var_3) {
  if(!isDefined(self)) {
    return;
  }
  if(_isagent(self) || isbot(self)) {
    return;
  }
  if(!_id_0F5B(var_0)) {
    return;
  }
  self notify("removeDivisionVignette");
  var_4 = self;

  if(isDefined(var_2))
    var_4 = var_2;

  switch (var_1) {
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
      var_5 = common_scripts\utility::_id_44F5("divisions_bayonet_charge");
      _killfxontagforclient(var_5, var_4, "j_head", self);
      break;
    case "sharpshooter_level3":
    case "sharpshooter_level2":
    case "sharpshooter_level1":
      self setclientomnvar("ui_hide_hud", 0);

      if(!isDefined(var_3))
        _id_048E::_id_8D7D(1);
      else
        _id_048E::_id_8D7D(var_3);

      break;
    default:
      break;
  }

  var_6 = undefined;

  if(isDefined(level._id_A4B5))
    var_6 = level._id_A4B5;

  if(isDefined(var_6) && !isDefined(var_6["lerpDuration"]))
    var_6["lerpDuration"] = 0.1;

  if(isDefined(var_6))
    self digitaldistortsetparams(var_6["intensity"], var_6["falloff"], var_6["scaleX"], var_6["scaleY"], var_6["squareAspectRatio"], var_6["lerpDuration"]);

  if(maps\mp\_utility::_id_579B() == 0) {
    if(self playerads() > 0)
      self lerpfovscale(1.0, 0.1);
    else
      self lerpfovscale(1.0, 0.2);
  }

  var_7 = undefined;

  if(isDefined(level._id_6465))
    var_7 = level._id_6465;

  if(isDefined(var_7))
    self _meth_866F(var_7["velocityscaler"], var_7["cameraRotationInfluence"], var_7["cameraTranslationInfluence"]);
  else
    self _meth_866F(0, 0, 0);
}

_id_A8FA(var_0, var_1) {
  self endon("disconnect");
  self endon("removeDivisionVignette");
  common_scripts\utility::_id_A70A("death", "weapon_change");
  thread _id_2F7B(var_0, var_1);
}

_id_4499(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3) || !isDefined(var_1) || !isDefined(var_1._id_0079) || var_1._id_0079 == 5)
    return var_0;

  var_5 = 1;

  switch (maps\mp\_utility::getweaponclass(var_3)) {
    case "weapon_assault":
      if(isDefined(var_1._id_165B) && var_1._id_165B && isDefined(var_4) && maps\mp\_utility::_id_5755(var_4))
        return "divisions_infantry_kill";

      break;
    case "weapon_sniper":
      if(isDefined(var_1._id_8AE0) && var_1._id_8AE0)
        return "divisions_mountain_kill";

      break;
    case "weapon_smg":
      var_6 = issubstr(var_3, "zk383");

      if(maps\mp\_utility::_id_5670(var_3) && !var_6 || var_6 && var_1._id_4B47)
        return "divisions_airborne_kill";

      break;
    case "weapon_heavy":
      if(issubstr(var_3, "bipod"))
        return "divisions_armored_kill";

      break;
    case "weapon_shotgun":
      if(maps\mp\_utility::_id_5670(var_3) && issubstr(var_3, "dragon_breath_") || maps\mp\_utility::_id_5697(var_4, var_3))
        return "divisions_cavalry_kill";

      break;
    case "weapon_pistol":
      if(issubstr(var_3, "tactical_knife") && isDefined(var_4) && maps\mp\_utility::_id_5755(var_4))
        return "division_resistance_kill";

      break;
    default:
      var_5 = 0;
      break;
  }

  return var_0;
}