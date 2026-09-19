/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1248.gsc
**************************************/

_id_4F43() {
  _precacherumble("light_1s");
  level._id_707C = loadfx("vfx/map/mp_hub/clay_plate_death");
  level._id_5959 = loadfx("vfx/explosion/jerrycan_destruct_runner");
  level._id_60FF = loadfx("vfx/map/mp_hub/watermelon_death");
  level.melonmodel = "Hub_range_watermelon_01";
  level._id_AA65 = loadfx("vfx/map/mp_hub/hub_impact_wooden_human_target_sml");
  level._id_AA66 = loadfx("vfx/map/mp_hub/hub_impact_wooden_human_target_exp");

  if(getdvarint("986", 0) == 0) {
    level._id_94F1 = loadfx("vfx/unique/vfx_supplydrop_indicator_go");
    level._id_94F2 = loadfx("vfx/unique/vfx_supplydrop_indicator_stop");
    level._id_4B12 = loadfx("vfx/map/mp_hub/hub_firingrange_hard_reward");
    level._id_9B6D = loadfx("vfx/map/mp_hub/hub_firingrange_medium_reward");
    _precacheturret("sentry_supplydrop_mp");
  }
}

disablefocus(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(isDefined(var_4))
        self endon(var_4);
    }
  }

  wait(var_0);

  if(isDefined(self))
    self notify(var_1);
}

_id_7471(var_0) {
  var_1 = self;

  if(isDefined(var_1._id_537A) && var_1._id_537A == 1) {
    return;
  }
  var_1 notify("virtualLobbyActive");

  if(level._id_A220) {} else {
    if(!isDefined(var_1._id_1E99) && isDefined(var_0)) {
      var_2 = _getent(var_0, "targetname");
      var_3 = var_2.origin;
      var_4 = var_2.angles;
      var_5 = spawn("script_model", var_3);
      var_5.angles = var_4;
      var_5 setModel("tag_player");
      var_5._id_92F0 = var_3;
      var_5._id_92B8 = var_4;
      var_5.setmovingplatformplayerturnrate = (0, 0, 0);
      var_5._id_9815 = var_1;
      var_1._id_1E99 = var_5;
      var_5.player = var_1;
      var_5.targetname = "camera2player";
    }

    var_1 cameralinkto(var_1._id_1E99, "tag_player");
  }

  var_1._id_537A = 1;
  var_1._id_00C7 = 1;
  var_1 allowlean(0);
  var_1 _id_870B(1);
}

_id_7472() {
  if(isDefined(self._id_537A) && self._id_537A == 0) {
    return;
  }
  self setclientdvar("3078", "1");
  self._id_537A = 0;
  self._id_00C7 = 0;
  self allowlean(1);

  if(!level._id_A220) {
    self cameraunlink();
    self setplayerangles(self._id_8068);
  } else {}

  var_0 = [self._id_5721, self._id_5692, self._id_572A, self._id_572F];

  foreach(var_2 in var_0) {
    if(!isDefined(var_2))
      var_2 = 0;
  }

  _id_870B(_id_5790(1));

  if(!self._id_5721 && !self._id_5692 && !self._id_572A && !self._id_572F && !self._id_5722)
    _id_7446();
  else if(self._id_5721)
    _id_04DB::_id_37BD();
  else if(self._id_572F) {
    maps\mp\_utility::_giveweapon(self._id_8B27);
    self switchtoweaponimmediate(self._id_8B27);
  }
}

_id_7446() {
  self takeallweapons();
  self._id_7706 = "none";
  self.primarypaintjobid = 0;
  self.primarycharmguid = 0;
  self.botgetscriptgoal = "none";
  self.secondarypaintjobid = 0;
  self.secondarycharmguid = 0;
  self._id_60FB = "none";
  maps\mp\_utility::_giveweapon("emote_weapon_mp");
  self switchtoweaponimmediate("emote_weapon_mp");
  self _meth_85B6();
  self allowfire(0);
  self allowmelee(0);
  self _meth_85BE(0);
  self _meth_85BF(0);
  self disableweaponswitch();
  maps\mp\_utility::_id_05E4();
  maps\mp\_utility::giveperk("specialty_marathon");
  maps\mp\_utility::giveperk("specialty_falldamage");
}

_id_73E5(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    var_1 = spawn("script_origin", (0, 0, 0));
    self._id_2608 = var_1;
    self _meth_8200(var_1);
  } else if(isDefined(self._id_2608)) {
    self _meth_8201();
    self._id_2608 delete();
  }
}

_id_7DF8(var_0, var_1, var_2, var_3, var_4, var_5) {
  self _meth_8546(var_0);
  self _meth_8309(var_1);
  self allowads(var_2);
  self allowcrouch(0);
  self allowsprint(0);
  self allowmantle(0);

  if(!isDefined(var_5))
    var_5 = 0;

  self allowjump(var_5);

  if(isDefined(var_3))
    self setclientomnvar("ui_hub_enable_pause", var_3);

  if(isDefined(var_4))
    self allowlean(var_4);
}

_id_A04C() {
  self _meth_8546(1);
  self _meth_8309(1);
  self allowads(1);
  self allowcrouch(1);
  self allowsprint(1);
  self allowmantle(1);
  self allowjump(1);
  self allowlean(1);

  if(self getclientomnvar("ui_hub_enable_pause") == 0)
    self setclientomnvar("ui_hub_enable_pause", 1);
}

_id_63EA() {}

_id_721A(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(var_0 == "mp_emote_superhero_landing") {
    var_2 = getEntArray("invalid_psd_area", "targetname");

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(self istouching(var_4) && self.origin[2] < 300) {
          self iprintln(&"HUB_DONT_BE_A_HERO");
          return 0;
        }
      }
    }
  }

  if(!isDefined(var_1) || !var_1) {
    var_6 = self.origin;
    waitframe();

    if(self.origin != var_6 && _lengthsquared(self getentityvelocity()) >= 25.0)
      return 0;
  }

  if(!isDefined(self._id_99FD))
    return 0;

  if(self._id_56A4) {
    if(isDefined(self._id_155F))
      self._id_155F _id_1543((0, 0, 0), self);
  }

  var_7 = tablelookup("mp/animOverrideTable.csv", 0, var_0, 1);
  var_8 = tablelookup("mp/animOverrideTable.csv", 0, var_0, 3);
  var_9 = 0;
  var_10 = 0;
  var_11 = 3;

  if(isDefined(var_7) && var_7 != "")
    var_11 = int(var_7);

  if(var_11 == 2) {
    var_12 = self _meth_85E1(1);

    if(common_scripts\utility::_id_9467(var_12, "mp_emote_"))
      return 0;

    if(var_8 == "") {
      if(var_9 || var_12 != var_0) {
        self _meth_85B2(1, var_0);
        self _meth_85B3(1, 0);
        var_10 = 1;
      }
    } else if(var_9 || var_12 != var_0 && var_12 != var_8) {
      self _meth_85B2(2, var_0);
      self _meth_85B2(3, var_8);
      self _meth_85B3(1, 0);
      var_10 = 1;
    }
  } else {
    var_12 = self _meth_85E1(0);

    if(common_scripts\utility::_id_9467(var_12, "mp_emote_"))
      return 0;

    var_13 = tablelookup("mp/animOverrideTable.csv", 0, var_12, 4);

    if(isDefined(var_13) && var_13 != "" && var_12 != var_0) {
      self _meth_85B2(4, var_13);
      self _meth_85B2(5, var_0);
      self _meth_85B3(0, 1);
      var_10 = 1;
    } else if(var_8 == "") {
      if(var_9 || var_12 != var_0) {
        self _meth_85B2(0, var_0);
        self _meth_85B3(0, 0);
        var_10 = 1;
      }
    } else if(var_9 || var_12 != var_0 && var_12 != var_8) {
      self _meth_85B2(4, var_0);
      self _meth_85B2(5, var_8);
      self _meth_85B3(0, 1);
      var_10 = 1;
    }
  }

  if(var_10) {
    var_14 = _tablelookupistring("mp/animOverrideTable.csv", 0, var_0, 2);

    if(isDefined(var_14) && var_14 != &"") {
      if(_getsystemtime() - self._id_99FD > 2.5) {
        self._id_99FD = _getsystemtime();
        var_15 = _id_459B(160);

        foreach(var_17 in var_15) {
          if(var_17.team != self.team || var_17._id_572A) {
            continue;
          }
          var_17 iprintln(&"HUB_EMOTE_CHAT_SYNTAX", self.name, var_14);
        }
      }
    }
  }

  return 1;
}

_id_459B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_4)) {
      if(!isDefined(var_1) || isDefined(var_1) && (var_4._id_5721 || var_4._id_572F)) {
        if(common_scripts\utility::_id_302B(self.origin, var_4.origin) < _squared(var_0))
          var_2 = common_scripts\utility::_id_0972(var_2, var_4);
      }
    }
  }

  return var_2;
}

_id_63C0() {
  self endon("disconnect");
  var_0 = getDvar("hub_emote");

  for(;;) {
    if(maps\mp\_utility::isreallyalive(self) && var_0 != getDvar("hub_emote")) {
      var_0 = getDvar("hub_emote");
      _id_721A(var_0);
      thread maps\mp\gametypes\_hud_util::_id_3005("Current emote: " + var_0, -100, 1, "hideCurrentEmoteStatus");
      wait 1;
      self notify("hideCurrentEmoteStatus");
    }

    waitframe();
  }
}

_id_637C() {
  self endon("disconnect");
  var_0 = getdvarint("hub_setThirdPerson");

  for(;;) {
    if(maps\mp\_utility::isreallyalive(self) && var_0 != getdvarint("hub_setThirdPerson")) {
      var_0 = getdvarint("hub_setThirdPerson");

      if(var_0 == 1)
        self _meth_85C7();
      else
        self _meth_85C8();

      wait 1;
    }

    waitframe();
  }
}

_id_639E() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(!isalive(self)) {
      self waittill("spawned_player");
      continue;
    }

    if(!self isonground()) {
      var_0 = self.origin[2];

      while(!self isonground() && isalive(self)) {
        if(self.origin[2] > var_0)
          var_0 = self.origin[2];

        waitframe();
      }

      var_1 = var_0 - self.origin[2];

      if(var_1 < 0)
        var_1 = 0;

      var_2 = int(var_1 / 12.0);
      var_3 = maps\mp\gametypes\_hud_util::_id_2097("ch_hq_falls");

      if(var_2 > var_3 && isalive(self))
        maps\mp\gametypes\_missions::processchallenge("ch_hq_falls", var_2, 1);
    }

    waitframe();
  }
}

_id_4834(var_0, var_1) {
  var_2 = [];
  var_2["division"] = maps\mp\gametypes\_class::cac_getdivision(var_1);
  var_2["primaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::cac_getweapon(var_1, 0), 0);

  for(var_3 = 0; var_3 < 6; var_3++)
    var_2["primaryAttachmentsGUID"][var_3] = maps\mp\gametypes\_class::cac_getweaponattachment(var_1, 0, var_3);

  var_2["primaryCamoGUID"] = maps\mp\gametypes\_class::cac_getweaponcamo(var_1, 0);
  var_2["primaryCamo2GUID"] = maps\mp\gametypes\_class::cac_getweaponcamo2(var_1, 0);
  var_2["primaryReticleGUID"] = maps\mp\gametypes\_class::cac_getweaponcustomization(var_1, 0);
  var_2["primaryCustomization"] = maps\mp\gametypes\_class::cac_getweaponcustomization(var_1, 0);
  var_2["primaryPaintjobId"] = maps\mp\gametypes\_class::cac_getweaponpaintjob(var_1, 0);
  var_2["primaryCharmGUID"] = maps\mp\gametypes\_class::cac_getweaponcharm(var_1, 0);
  var_2["secondaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::cac_getweapon(var_1, 1), 0);

  for(var_3 = 0; var_3 < 6; var_3++)
    var_2["secondaryAttachmentsGUID"][var_3] = maps\mp\gametypes\_class::cac_getweaponattachment(var_1, 1, var_3);

  var_2["secondaryCamoGUID"] = maps\mp\gametypes\_class::cac_getweaponcamo(var_1, 1);
  var_2["secondaryCamo2GUID"] = maps\mp\gametypes\_class::cac_getweaponcamo2(var_1, 1);
  var_2["secondaryReticleGUID"] = maps\mp\gametypes\_class::cac_getweaponcustomization(var_1, 1);
  var_2["secondaryCustomization"] = maps\mp\gametypes\_class::cac_getweaponcustomization(var_1, 1);
  var_2["secondaryPaintjobId"] = maps\mp\gametypes\_class::cac_getweaponpaintjob(var_1, 1);
  var_2["secondaryCharmGUID"] = maps\mp\gametypes\_class::cac_getweaponcharm(var_1, 1);
  var_2["meleeWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::_id_1E07(), 0);
  var_2["equipmentStruct"] = maps\mp\_utility::_id_44CE(maps\mp\gametypes\_class::cac_getequipment(var_1, 0), 0);
  var_2["offhandStruct"] = maps\mp\_utility::_id_44CE(maps\mp\gametypes\_class::cac_getequipment(var_1, 1), 0);

  for(var_3 = 0; var_3 < 9; var_3++)
    var_2["perkGUID" + var_3] = maps\mp\gametypes\_class::cac_getperk(var_1, var_3);

  return var_2;
}

_id_9C8C(var_0) {
  var_1 = [];
  var_1["division"] = var_0._id_0079;
  var_1["primaryWeaponStruct"] = var_0._id_7709;
  var_1["secondaryWeaponStruct"] = var_0.botgetscriptgoalradius;
  var_1["meleeWeaponStruct"] = var_0._id_60FC;
  var_1["equipmentStruct"] = var_0._id_37FE;
  var_1["offhandStruct"] = var_0._id_69AD;
  var_1["primaryAttachmentsGUID"] = [];
  var_1["secondaryAttachmentsGUID"] = [];

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_1["primaryAttachmentsGUID"][var_2] = var_0._id_76F3[var_2];
    var_1["secondaryAttachmentsGUID"][var_2] = var_0.botsetflag[var_2];
  }

  var_1["primaryCustomization"] = var_0._id_0144;
  var_1["secondaryCustomization"] = var_0._id_0176;
  var_1["primaryCamoGUID"] = var_0._id_76F5;
  var_1["secondaryCamoGUID"] = var_0.botsetscriptmove;
  var_1["primaryCamo2GUID"] = var_0._id_76F4;
  var_1["secondaryCamo2GUID"] = var_0.botsetstance;
  var_1["primaryReticleGUID"] = var_0._id_7700;
  var_1["primaryCustomization"] = var_0._id_0144;
  var_1["primaryPaintjobId"] = var_0.primarypaintjobid;
  var_1["primaryCharmGUID"] = var_0.primarycharmguid;
  var_1["secondaryReticleGUID"] = var_0.botsetscriptenemy;
  var_1["secondaryCustomization"] = var_0._id_0176;
  var_1["secondaryPaintjobId"] = var_0.secondarypaintjobid;
  var_1["secondaryCharmGUID"] = var_0.secondarycharmguid;

  for(var_2 = 0; var_2 < 9; var_2++)
    var_1["perkGUID" + var_2] = var_0._id_6F69[var_2];

  return var_1;
}

_id_4618() {
  var_0 = maps\mp\_utility::_id_1E01();

  if(!isDefined(self._id_294D))
    self._id_294D = maps\mp\gametypes\_class::_id_1E05();

  if(level._id_4F50 && isDefined(self._id_9FB3))
    self._id_294D = self._id_9FB3;

  var_1 = maps\mp\_utility::getclassindex("lobby" + (self._id_294D + 1));

  if(level._id_A220) {
    if(isDefined(self._id_A597))
      var_2 = _id_9C8C(self._id_A597);
    else
      var_2 = _id_4834(var_0, var_1);
  } else
    var_2 = self._id_5E01[var_0][var_1];

  self._id_0079 = var_2["division"];
  var_3 = var_2["primaryWeaponStruct"];
  var_4 = var_2["secondaryWeaponStruct"];
  var_5 = var_2["meleeWeaponStruct"];
  var_6 = var_2["equipmentStruct"];
  var_7 = var_2["offhandStruct"];
  var_8 = var_2["perkGUID3"];
  var_9 = 0;
  var_10 = var_8 == 73400412;
  var_11 = maps\mp\_utility::_id_4431(maps\mp\_utility::_id_4737(var_4));

  if(maps\mp\_utility::_id_5856(var_11))
    var_11 = maps\mp\gametypes\_class::_id_4432(var_11);

  if(maps\mp\_utility::getweaponclass(var_11) == "weapon_pistol") {
    if(var_10) {
      switch (var_11) {
        case "enfieldno2_mp":
        case "reich_mp":
        case "p38_mp":
        case "luger_mp":
        case "m1911_mp":
          var_9 = 50332864;
          break;
        case "m712_mp":
          var_9 = 50333920;
          break;
        default:
          break;
      }

      for(var_12 = 0; var_12 < var_2["secondaryAttachmentsGUID"].size; var_12++) {
        if(var_2["secondaryAttachmentsGUID"][var_12] == 50338160)
          var_2["secondaryAttachmentsGUID"][var_12] = 0;
      }
    }
  } else {}

  if(isDefined(var_3) && isDefined(var_3.guid) && var_3.guid != 0) {
    var_15 = maps\mp\_utility::_id_4737(var_3);
    self._id_7706 = maps\mp\gametypes\_class::_id_1D66(var_15, var_2["primaryAttachmentsGUID"][0], var_2["primaryAttachmentsGUID"][1], var_2["primaryAttachmentsGUID"][2], var_2["primaryAttachmentsGUID"][3], var_2["primaryAttachmentsGUID"][4], var_2["primaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_3), var_2["primaryCamoGUID"], var_2["primaryCamo2GUID"], var_2["primaryReticleGUID"], var_2["primaryCustomization"], self, self._id_0079);
    self.primarypaintjobid = var_2["primaryPaintjobId"];
    self.primarycharmguid = var_2["primaryCharmGUID"];
  }

  if(isDefined(var_4) && isDefined(var_4.guid) && var_4.guid != 0) {
    var_15 = maps\mp\_utility::_id_4737(var_4);
    self.botgetscriptgoal = maps\mp\gametypes\_class::_id_1D66(var_15, var_2["secondaryAttachmentsGUID"][0], var_2["secondaryAttachmentsGUID"][1], var_2["secondaryAttachmentsGUID"][2], var_2["secondaryAttachmentsGUID"][3], var_2["secondaryAttachmentsGUID"][4], var_9, maps\mp\_utility::_id_472D(var_4), var_2["secondaryCamoGUID"], var_2["secondaryCamo2GUID"], var_2["secondaryReticleGUID"], var_2["secondaryCustomization"], self, self._id_0079);
    self.secondarypaintjobid = var_2["secondaryPaintjobId"];
    self.secondarycharmguid = var_2["secondaryCharmGUID"];
  }

  if(isDefined(var_6) && isDefined(var_6.guid) && var_6.guid != 0)
    self._id_37FC = maps\mp\_utility::_id_4737(var_6);

  if(isDefined(var_7) && isDefined(var_7.guid) && var_7.guid != 0)
    self._id_69AB = maps\mp\_utility::_id_4737(var_7);

  self._id_5DF9 = [];

  for(var_12 = 0; var_12 < 9; var_12++)
    self._id_5DF9[var_12] = var_2["perkGUID" + var_12];
}

_id_478C() {
  var_0 = common_scripts\utility::_id_46AF();
  var_1 = self getplayerdata(var_0, "meleeWeapon", "weapon");
  var_2 = maps\mp\_utility::_id_452B(var_1);

  if(_weapontype(var_2) != "melee")
    var_2 = "combatknife_mp";

  maps\mp\_utility::_giveweapon(var_2);
}

_id_115E() {
  if(isDefined(self._id_2FAC) && self._id_2FAC) {
    return;
  }
  var_0 = maps\mp\_utility::_id_1E01();
  var_1 = maps\mp\gametypes\_class::_id_1E05();

  if(level._id_4F50 && isDefined(self._id_9FB3))
    var_1 = self._id_9FB3;

  var_2 = maps\mp\_utility::getclassindex("lobby" + (var_1 + 1));

  if(level._id_A220) {
    if(isDefined(self._id_A597))
      var_3 = _id_9C8C(self._id_A597);
    else
      var_3 = _id_4834(var_0, var_2);
  } else
    var_3 = self._id_5E01[var_0][var_2];

  var_4 = var_3["division"];
  var_5 = var_3["primaryWeaponStruct"];
  var_6 = undefined;

  if(isDefined(var_5) && isDefined(var_5.guid) && var_5.guid != 0) {
    var_7 = maps\mp\_utility::_id_4737(var_5);
    var_6 = maps\mp\gametypes\_class::_id_1D66(var_7, var_3["primaryAttachmentsGUID"][0], var_3["primaryAttachmentsGUID"][1], var_3["primaryAttachmentsGUID"][2], var_3["primaryAttachmentsGUID"][3], var_3["primaryAttachmentsGUID"][4], var_3["primaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_5), var_3["primaryCamoGUID"], var_3["primaryCamo2GUID"], var_3["primaryReticleGUID"], var_3["primaryCustomization"], self, var_4);
  }

  if(isDefined(var_6) && maps\mp\_utility::getweaponclass(var_6) != "weapon_other" && var_6 != "riotshield_mp") {
    var_8 = 0;

    if(isDefined(var_3["primaryPaintjobId"]))
      var_8 = var_3["primaryPaintjobId"];

    self _meth_85B7(_id_2164(var_6), var_8);
  } else if(isDefined(var_6) && var_6 == "riotshield_mp")
    self _meth_85B7("none", 0);
}

_id_2164(var_0) {
  if(isDefined(self.pers["altModeActive"]) && isDefined(self._id_0079) && !self.pers["altModeActive"] && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_smg" && issubstr(var_0, "suppressor"))
    var_0 = _id_04CB::_id_7CCD(var_0);

  return var_0;
}

_id_3663() {
  self._id_2FAC = undefined;
  _id_115E();
}

_id_2FA2() {
  self._id_2FAC = 1;
  self _meth_85B8();
}

_id_2811(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\mp\gametypes\_hud_util::createfontstring("mphubfont", var_3);

  if(_isarray(var_2))
    var_5 maps\mp\gametypes\_hud_util::setpoint(var_4, var_4, var_2[0], var_2[1]);
  else
    var_5 maps\mp\gametypes\_hud_util::setpoint(var_4, var_4, 0, var_2);

  var_5.sort = 1001;
  var_5.color = (1, 1, 1);
  var_5.alpha = 0.8;
  var_5.foreground = 0;
  var_5.hidewheninmenu = 1;
  var_5.label = var_1;
  var_5.name = var_0;
  var_5._id_017A = 0;

  if(!isDefined(self._id_308C)) {
    self._id_308C = [];
    thread _id_2386();
  }

  if(isDefined(self._id_308C[var_0]))
    _id_2DD2(var_0);

  self._id_308C[var_0] = var_5;
  return var_5;
}

_id_3010(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_2811(var_0, var_1, var_3, var_4, "CENTER");

  if(_isstring(var_2))
    var_6 settext(var_2);
  else if(_isnumber(var_2))
    var_6 setvalue(var_2);
  else if(isPlayer(var_2))
    var_6 setplayernamestring(var_2);
  else if(!isDefined(var_2)) {} else {
    _id_2DD2(var_0);
    return;
  }

  if(isDefined(var_5)) {
    wait(var_5);

    if(isDefined(self._id_308C[var_0]))
      _id_2DD2(var_0);
  } else
    return var_6;
}

_id_2835(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_308C) && isDefined(self._id_308C[var_0]))
    _id_A12B(var_0, var_2);
  else
    return _id_3010(var_0, var_1, var_2, var_3, var_4);
}

_id_A12B(var_0, var_1) {
  var_2 = self._id_308C[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  if(_isstring(var_1))
    var_2 settext(var_1);
  else if(_isnumber(var_1))
    var_2 setvalue(var_1);
  else if(isPlayer(var_1))
    var_2 setplayernamestring(var_1);
  else
    return;
}

_id_454D(var_0) {
  if(isDefined(self._id_308C))
    return self._id_308C[var_0];

  return undefined;
}

_id_2DD2(var_0) {
  var_1 = self._id_308C[var_0];
  var_1 destroy();
  self._id_308C[var_0] = undefined;
}

_id_2386(var_0) {
  if(!isDefined(var_0) || !var_0)
    common_scripts\utility::_id_A70A("disconnect", "death");

  if(isDefined(self._id_308C)) {
    foreach(var_3, var_2 in self._id_308C) {
      if(!isDefined(var_2)) {
        continue;
      }
      self._id_308C[var_3] = undefined;
      var_2 destroy();
    }
  }
}

_id_4F3B(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("disconnect");
  self fadeovertime(var_0);
  self.alpha = var_2;
}

_id_4F3C(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("disconnect");
  self fadeovertime(var_0);
  self.alpha = var_2;
}

_id_7889(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 waittill(var_2);
  var_0 scriptmodelplayanim(var_1);
  var_0._id_74B8 = 0;
  var_0._id_74B7 = 0;
}

_id_788A(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 waittill(var_2);
  var_0 scriptmodelplayanimdeltamotionfrompos(var_1, var_3.origin, var_3.angles);
}

_id_A13F() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1 _id_2835("numPlayers", &"HUB_SOLDIERS_IN_HUB", level.players.size, [-370, -220], 1);
  }
}

_id_238C() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1 _id_2DD2("numPlayers");
  }
}

_id_5790(var_0) {
  if(isDefined(self._id_572A) && self._id_572A)
    return 1;
  else if(isDefined(self._id_5692) && self._id_5692)
    return 1;
  else if(isDefined(self._id_572B) && self._id_572B)
    return 1;
  else if(isDefined(self._id_4B84) && self._id_4B84)
    return 1;
  else if(isDefined(self._id_5733) && self._id_5733)
    return 1;
  else if(isDefined(self._id_537A) && !maps\mp\_utility::isreallyalive(self))
    return 1;
  else if(isDefined(self._id_5722) && self._id_5722)
    return 1;
  else if(isDefined(self._id_584B) && self._id_584B)
    return 1;
  else if(isDefined(self._id_5791) && self._id_5791)
    return 1;
  else if(isDefined(self._id_537A) && self._id_537A)
    return 1;
  else if(isDefined(self._id_572F) && self._id_572F)
    return 1;
  else if(isDefined(self._id_57E0) && self._id_57E0)
    return 1;
  else if(isDefined(self._id_56AD) && self._id_56AD)
    return 1;
  else if(self _meth_803D())
    return 1;
  else if(isDefined(self.isintimertag) && self.isintimertag)
    return 1;

  if(!isDefined(var_0) || var_0) {
    if(isDefined(self._id_5721) && self._id_5721)
      return 1;
  }

  return 0;
}

_id_870B(var_0) {
  if(isDefined(self._id_56AD) && self._id_56AD && var_0 == 0) {
    return;
  }
  self setclientomnvar("ui_hub_is_preoccupied", var_0);
}

_id_6010(var_0, var_1) {
  var_0._id_4E03 = common_scripts\utility::_id_0972(var_0._id_4E03, var_1);
}

_id_A03C(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1))
    var_0._id_4E03 = common_scripts\utility::_id_0F98(var_1, var_0._id_4E03);
  else if(isDefined(var_0))
    var_0._id_4E03 = common_scripts\utility::_id_0FA0(var_0._id_4E03);
}

_id_4F44(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = 1.5;
  var_2 = 0.6;
  var_3 = 2;

  while(!isDefined(self._id_ACA4))
    waitframe();

  self._id_56C8 = 1;
  self._id_ACA4.alpha = 0;
  self._id_162C.alpha = 0;
  self._id_ACA4.label = _id_474C(self._id_295A);
  self._id_ACA4 thread _id_4F3B(var_1, self, 1);
  self._id_162C thread _id_4F3B(var_1, self, 1);
  wait(var_1);
  wait(var_3);
  self._id_ACA4 thread _id_4F3C(var_2, self, 0);
  self._id_162C thread _id_4F3C(var_2, self, 0);
  wait(var_2);
  self._id_56C8 = 0;
}

_id_474C(var_0) {
  switch (var_0) {
    case "hq_zone_trigger":
      return &"HUB_ZONE_HEADQUARTERS";
    case "spawn_zone_trigger":
      return &"HUB_ZONE_SPAWN";
    case "beach_zone_trigger":
      return &"HUB_ZONE_BEACH";
    case "theatre_zone_trigger":
      return &"HUB_ZONE_THEATRE";
    case "firingrange_zone_trigger":
      return &"HUB_ZONE_FIRINGRANGE";
    case "offTower_zone_trigger":
      return &"HUB_ZONE_OFFTOWER";
    case "":
      return "something broke";
  }
}

_id_77B4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("pulseDurationEnded");
  self endon("pulseDurationEnded");
  var_5 endon("death");
  var_5 endon("disconnect");

  if(isDefined(var_4))
    thread disablefocus(var_4, "pulseDurationEnded", undefined);

  self._id_5798 = 1;

  while(isDefined(self)) {
    if(isDefined(self))
      _id_4F3B(var_0, var_5, var_6);

    wait(var_0);
    wait(var_2);

    if(isDefined(self))
      _id_4F3C(var_1, var_5, var_7);

    wait(var_1);
    wait(var_3);
  }
}

_id_532E() {
  if(getDvar("1459") != "") {
    return;
  }
  wait 1;
  setdvarifuninitialized("spv_hub_ball_kswitch", 0);
  level._id_1564[0] = common_scripts\utility::_id_46B5("ball_spawn_point_1", "targetname");
  level._id_1564[1] = common_scripts\utility::_id_46B5("ball_spawn_point_2", "targetname");
  level._id_1564[2] = common_scripts\utility::_id_46B5("ball_spawn_point_3", "targetname");

  for(var_0 = 0; var_0 < level._id_1564.size; var_0++)
    level._id_1564[var_0] thread _id_1553();
}

_id_1553() {
  for(;;) {
    if(getdvarint("spv_hub_ball_kswitch", 0) == 1) {
      return;
    }
    var_0 = spawn("script_model", self.origin);

    if(self.origin == level._id_1564[0].origin)
      var_0 setModel("npc_soccer_ball_02");
    else if(self.origin == level._id_1564[2].origin)
      var_0 setModel("npc_soccer_ball_04");
    else
      var_0 setModel("npc_soccer_ball_03");

    var_0 show();
    var_0 thread _id_6FA2();
    var_1 = 24;
    var_2 = spawn("trigger_radius", var_0.origin - (0, 0, var_1 / 2), 0, var_1, var_1);
    var_2 enablelinkto();
    var_2 linkto(var_0);
    var_2._id_66F0 = 1;
    var_3 = [var_0];
    var_4 = _id_04D1::_id_27D6("any", var_2, var_3, (0, 0, 32), 0, 0, 1);
    var_4 _id_04D1::_id_0C1D("any");
    var_4 _id_04D1::_id_8A60("any");
    var_4._id_698F = 0;
    var_4._id_6993 = 1.0;
    var_4._id_0C33 = 0;
    var_4.carryweapon = "hub_ball_mp";
    var_4._id_59D8 = 1;
    var_4._id_A965 = 0;
    var_4.visualgroundoffset = (0, 0, 30);
    var_4._id_1F84 = ::_id_150E;
    var_4._id_6B62 = ::_id_1535;
    var_4._id_866E = ::_id_1550;
    var_4._id_201D = ::_id_1555;
    var_4.requireslos = 1;
    var_4._id_152D = self.setmovespeedscale;
    maps\mp\_utility::_objective_delete(var_4._id_698A);
    maps\mp\_utility::_objective_delete(var_4._id_698B);
    maps\mp\_utility::_objective_delete(var_4._id_698C);
    var_4._id_2562 = undefined;
    var_4._id_2561 = undefined;
    var_4._id_698A = undefined;
    var_4._id_698B = undefined;
    var_4._id_698C = undefined;
    var_4 thread monitorballkswitch();

    for(;;) {
      var_2 waittill("trigger", var_5);

      if(isPlayer(var_5)) {
        if(!var_5._id_56A4 && !isDefined(var_5._id_155F)) {
          break;
        }
      }
    }

    wait 120;
  }
}

monitorballkswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");

  while(getdvarint("spv_hub_ball_kswitch", 0) == 0)
    wait 1;

  _id_04D1::_id_23DA();
  _id_04D1::_id_2D2F();
}

_id_150E(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(self._id_34B1) && self._id_34B1 >= gettime())
    return 0;

  if(isbot(var_0) || _isagent(var_0))
    return 0;

  if(var_0 _id_72F0())
    return 0;

  if(var_0 _id_5790())
    return 0;

  var_1 = var_0 _meth_85E1(1);

  if(common_scripts\utility::_id_9467(var_1, "mp_emote_"))
    return 0;

  var_1 = var_0 _meth_85E1(0);

  if(common_scripts\utility::_id_9467(var_1, "mp_emote_"))
    return 0;

  return 1;
}

_id_1535(var_0) {
  self notify("pickup_object");
  var_1 = self._id_A582[0] getlinkedparent();

  if(isDefined(var_1))
    self._id_A582[0] unlink();

  self._id_A582[0] physicsstop();
  self._id_A582[0] show();
  self._id_A582[0] ghost();
  var_0 setweaponammoclip("hub_ball_mp", 1);
  var_0 playSound("grid_ball_pickup");
  var_0 maps\mp\_utility::giveperk("specialty_ballcarrier");
  var_0 allowfire(1);
  var_0._id_56A4 = 1;
  var_0._id_155F = self;

  if(isDefined(self._id_152D)) {
    var_0 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_data_ball" + self._id_152D);
    var_2 = var_0 maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_ball1");
    var_3 = var_0 maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_ball2");
    var_4 = var_0 maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_ball3");
    var_5 = var_2 + var_3 + var_4;
    var_0 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_balls", var_5, 1);
  }

  var_0 common_scripts\utility::_id_0601();
}

_id_1550(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self._id_57A6 = 1;
  self._id_34B1 = gettime();
  self notify("dropped");
  var_1 = self.carrier;

  if(isDefined(var_1) && var_1.team != "spectator")
    var_2 = var_1 gettagorigin("TAG_ACCESSORY_RIGHT");
  else
    var_2 = self.detachall;

  var_3 = (0, 0, 0);

  for(var_4 = 0; var_4 < self._id_A582.size; var_4++) {
    self._id_A582[var_4].origin = var_2;
    self._id_A582[var_4].angles = var_3;
    self._id_A582[var_4] show();
  }

  self._id_9D65.origin = var_2;
  _id_151D();
  self._id_28D4 = self._id_9D65.origin;
  _id_1511();
  _id_04D1::_id_23DA();
  self._id_57A6 = 0;

  if(!var_0)
    _id_1542((0, 0, 80));

  thread _id_1533();
  return 1;
}

_id_151D() {
  self._id_A582[0] dontinterpolate();
  self._id_1521 = 0;
}

_id_1511() {
  if(isDefined(self.carrier)) {
    var_0 = self.carrier;
    var_0._id_6735 = gettime() + 500;
    var_0 common_scripts\utility::_id_0615();
    var_0._id_56A4 = 0;
    var_0._id_155F = undefined;
    var_0 maps\mp\_utility::_id_0735("specialty_ballcarrier");
    var_0 allowfire(0);
    var_0 switchtoweaponimmediate("emote_weapon_mp");
  }
}

_id_1555() {
  self endon("disconnect");
  thread _id_1557();
  self._id_2016 waittill("dropped");
}

_id_1557() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  var_0 = getdvarfloat("scr_ball_shoot_extra_pitch", -12);
  var_1 = getdvarfloat("scr_ball_shoot_force", 500);

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != "hub_ball_mp") {
      continue;
    }
    break;
  }

  if(isDefined(self._id_2016)) {
    self _meth_85C9(1);
    wait 0.1;
    var_3 = self getplayerangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    self _meth_85C9(0);
    _id_0468::_id_0A27("passBall");
    self playSound("grid_ball_throw");
    self._id_2016 thread _id_1543(var_4 * var_1, self);
  }
}

_id_1556() {
  self endon("death");
  self endon("disconnect");
  self._id_6EA7 = 1;
  self allowmelee(0);

  while("hub_ball_mp" == self getcurrentweapon())
    waitframe();

  wait 1;
  self allowmelee(1);
  self._id_6EA7 = 0;
}

_id_1543(var_0, var_1) {
  _id_1550(1);
  _id_1542(var_0, var_1);
}

_id_1542(var_0, var_1) {
  var_2 = self._id_A582[0];
  var_2._id_6C43 = undefined;
  var_2 physicslaunchserver(var_2.origin + (0.1, 0, 0.25), var_0);
  thread _id_1546(var_1);
}

_id_1546(var_0) {
  var_1 = self._id_A582[0];
  var_2 = self._id_9D65;
  var_1 endon("physics_finished");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isDefined(var_0) && var_0 == var_3 && var_3 _id_72F0()) {
      continue;
    }
    if(self._id_34B1 >= gettime()) {
      continue;
    }
    if(var_1.origin == var_1._id_162D + (0, 0, 4000)) {
      continue;
    }
    if(!_id_150E(var_3)) {}
  }
}

_id_6FA2() {
  self endon("death");

  for(;;) {
    self waittill("physics_impact", var_0, var_1, var_2, var_3);
    var_4 = vectordot(var_2, var_1);

    if(var_4 > 0.5)
      self playSound("grid_ball_bounce");

    wait 0.3;
  }
}

_id_72F0() {
  return isDefined(self._id_6735) && self._id_6735 > gettime();
}

_id_1541() {
  var_0 = self._id_A582[0];

  if(!var_0 physicsisactive()) {
    return;
  }
  var_1 = var_0 physicsgetlinvel();
  var_2 = length(var_1) / 10;
  var_3 = -1 * vectorNormalize(var_1);
  var_0 physicsstop();
  var_0 physicslaunchserver(var_0.origin, var_3 * var_2);
}

_id_1516() {
  self._id_A582[0] dontinterpolate();
  self._id_A582[0] physicsstop();
  self._id_A582[0].origin = (0, 0, 0);
}

_id_1533() {
  self endon("death");
  self endon("deleted");
  thread disablefocus(60, "ballIsInactive", ["death", "deleted", "pickup_object"]);
  var_0 = common_scripts\utility::waittill_any_return("ballIsInactive", "pickup_object");

  if(var_0 == "ballIsInactive")
    _id_04D1::_id_2D2F();
  else
    return;
}

_id_531B() {
  self._id_746C = [];
  self._id_5711 = 0;
  self._id_5710 = 0;
}

_id_34DA() {
  if(isDefined(level) && isDefined(level.players)) {
    foreach(var_1 in level.players) {}
  } else {}
}

_id_0F54(var_0, var_1) {
  return !common_scripts\utility::_id_0F79(var_0._id_4E03, var_1);
}

_id_8BA6(var_0) {
  return isDefined(self._id_5710) && !(self._id_5710 || self._id_5711 && _id_0F54(self, var_0));
}

_id_4D12(var_0) {
  if(isDefined(self._id_746C) && common_scripts\utility::_id_0F79(self._id_746C, var_0)) {
    self._id_746C = common_scripts\utility::_id_0F93(self._id_746C, var_0);
    self _meth_85CD(self._id_746C);
  }
}

_id_8C0D(var_0) {
  if(isDefined(self._id_746C) && !common_scripts\utility::_id_0F79(self._id_746C, var_0)) {
    self._id_746C = common_scripts\utility::_id_0F6F(self._id_746C, var_0);
    self _meth_85CD(self._id_746C);
  }
}

_id_8BEB() {
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    var_1 _id_8C0D(self);
  }

  self._id_5710 = 0;
  self._id_5711 = 0;
}

_id_8BFB() {
  _id_8BEB();
}

_id_4D02() {
  self._id_5710 = 1;

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    var_1 _id_4D12(self);
  }
}

_id_4D09() {
  self._id_5711 = 1;

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    if(var_1 _id_8BA6(self)) {
      var_1 _id_8C0D(self);
      continue;
    }

    var_1 _id_4D12(self);
  }
}

_id_7B90() {
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    if(isDefined(var_1)) {
      if(_id_8BA6(var_1))
        var_1 _id_8C0D(self);
      else
        var_1 _id_4D12(self);

      if(var_1 _id_8BA6(self)) {
        _id_8C0D(var_1);
        continue;
      }

      _id_4D12(var_1);
    }
  }
}

_id_1EB6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.5;
  var_6 = 0.5;

  if(var_5 + var_6 > var_2) {
    var_5 = var_2 * 0.4;
    var_6 = var_2 * 0.4;
  }

  var_7 = _id_43F8();
  var_8 = self getplayerangles();
  self freezecontrols(1);
  var_9 = spawn("script_model", var_7);
  var_9 setModel("tag_player");
  var_9.angles = var_8;
  self cameralinkto(var_9, "tag_player", 250);
  wait 0.25;
  var_9 moveto(var_0, var_2, var_5, var_6);
  var_9 rotateto(vectortoangles(var_1 - var_0), var_2);
  wait(var_2);
  wait(var_3);
  var_9 moveto(var_7, var_4, var_5, var_6);
  var_9 rotateto(var_8, var_4);
  wait(var_4);
  self cameraunlink(250);
  wait 0.25;
  var_9 delete();
  self freezecontrols(0);
}

_id_86A9(var_0) {
  self setclientdvar("4990", var_0);
}

_id_43F8() {
  var_0 = 512;
  var_1 = getdvarint("1586");
  var_2 = getdvarint("2766");
  var_3 = getdvarint("3711");
  var_4 = self getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = self getplayerviewheight();
  var_7 = self.origin;
  var_7 = (var_7[0], var_7[1], var_7[2] + var_6);
  var_8 = var_7 + var_0 * var_5;
  var_7 = (var_7[0], var_7[1], var_7[2] + 8);
  var_9 = var_4;
  var_9 = (0.5 * var_9[0], var_9[1] - var_1, var_9[2]);
  var_10 = _anglestoaxis(var_9);
  var_7 = var_7 - var_2 * var_10["forward"];
  var_7 = var_7 + var_3 * var_10["right"];
  return var_7;
}

_id_636B() {
  level endon("game_ended");
  level._id_2939 = 1;

  for(;;) {
    if(getdvarint("hub_cameraAdjustMode") == 1) {
      if(getdvarint("hub_cam_preset_1") == 1) {
        if(level._id_2939 != 1) {
          setDvar("2766", level._id_1728);
          setDvar("cg_fov", 65);
          setDvar("3711", level._id_1727);
          setDvar("1586", 364);
          setDvar("4505", 0);
          level._id_2939 = 1;
        }
      } else if(getdvarint("hub_cam_preset_2") == 1) {
        if(level._id_2939 != 2) {
          setDvar("2766", 57);
          setDvar("cg_fov", 73);
          setDvar("3711", 22);
          setDvar("1586", 364);
          setDvar("4505", 0);
          level._id_2939 = 2;
        }
      } else if(getdvarint("hub_cam_preset_3") == 1) {
        if(level._id_2939 != 3) {
          setDvar("2766", 60);
          setDvar("cg_fov", 72);
          setDvar("3711", 18);
          setDvar("1586", 364);
          setDvar("4505", 0);
          level._id_2939 = 3;
        }
      } else if(getdvarint("hub_cam_preset_4") == 1) {
        if(level._id_2939 != 4) {
          setDvar("2766", 89);
          setDvar("cg_fov", 70);
          setDvar("3711", level._id_1727);
          setDvar("1586", 360);
          setDvar("4505", -5);
          level._id_2939 = 4;
        }
      } else if(getdvarint("hub_cam_preset_5") == 1) {
        if(level._id_2939 != 5) {
          setDvar("2766", 114);
          setDvar("cg_fov", 75);
          setDvar("3711", 20);
          setDvar("1586", -1);
          setDvar("4505", -5);
          level._id_2939 = 5;
        }
      }

      setDvar("hub_cam_preset_1", 0);
      setDvar("hub_cam_preset_2", 0);
      setDvar("hub_cam_preset_3", 0);
      setDvar("hub_cam_preset_4", 0);
      setDvar("hub_cam_preset_5", 0);
    }

    waitframe();
  }
}

_id_2DD4(var_0) {
  level endon("game_ended");
  self waittillmatch(var_0, "end");
  self delete();
}

pushplayervector(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {}

  if(!isDefined(var_3))
    var_3 = -1.0;

  if(!isDefined(var_4))
    var_4 = "NA";

  if(!isDefined(var_0))
    var_0 = "unknown_event";

  if(!isDefined(var_1))
    var_1 = "unknown_category";

  _reconevent("script_mp_hub_event: game_time %d, player_name %s, player_id %d, event_category %s, event_name %s, event_value_int %d, event_value_float %f, event_value_string %s, player_count %d", gettime(), self.name, self.clientid, var_1, var_0, var_2, var_3, var_4, level.players.size);
}

_id_50F0(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  if(getdvarint("3708", 0) == 1 && getdvarint("3645", 0) == 1) {
    return;
  }
  if(!isDefined(var_1)) {}

  if(!isDefined(var_2))
    var_2 = -1.0;

  if(!isDefined(var_3))
    var_3 = "NA";

  var_4 = "unknown_event";
  var_5 = "unknown_category";
  var_6 = 0;

  switch (var_0.size) {
    case 1:
      var_6 = self getplayerdata(common_scripts\utility::_id_46AA(), var_0[0]) + var_1;
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_6);
      var_4 = var_0[var_0.size - 1];
      break;
    case 2:
      var_6 = self getplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1]) + var_1;
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_6);
      var_4 = var_0[var_0.size - 1];
      var_5 = var_0[var_0.size - 2];
      break;
    case 3:
      var_6 = self getplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2]) + var_1;
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_6);
      var_4 = var_0[var_0.size - 1];
      var_5 = var_0[var_0.size - 2];
      break;
    case 4:
      var_6 = self getplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3]) + var_1;
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3], var_6);
      var_4 = var_0[var_0.size - 1];
      var_5 = var_0[var_0.size - 2];
      break;
    case 5:
      var_6 = self getplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3], var_0[4]) + var_1;
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3], var_0[4], var_6);
      var_4 = var_0[var_0.size - 1];
      var_5 = var_0[var_0.size - 2];
      break;
    default:
      break;
  }

  pushplayervector(var_4, var_5, var_1, var_2, var_3);
  return var_6;
}

isusingoffhand(var_0, var_1) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  if(getdvarint("3708", 0) == 1 && getdvarint("3645", 0) == 1) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = "unknown_event";
  var_3 = "unknown_category";

  switch (var_0.size) {
    case 1:
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_1);
      var_2 = var_0[var_0.size - 1];
      break;
    case 2:
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_1);
      var_2 = var_0[var_0.size - 1];
      var_3 = var_0[var_0.size - 2];
      break;
    case 3:
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_1);
      var_2 = var_0[var_0.size - 1];
      var_3 = var_0[var_0.size - 2];
      break;
    case 4:
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3], var_1);
      var_2 = var_0[var_0.size - 1];
      var_3 = var_0[var_0.size - 2];
      break;
    case 5:
      self setplayerdata(common_scripts\utility::_id_46AA(), var_0[0], var_0[1], var_0[2], var_0[3], var_0[4], var_1);
      var_2 = var_0[var_0.size - 1];
      var_3 = var_0[var_0.size - 2];
      break;
    default:
      break;
  }
}

_id_5E88(var_0, var_1, var_2, var_3) {
  if(_isremovedentity(self)) {
    return;
  }
  var_4 = self._id_4F4C;

  if(!isDefined(var_4))
    var_4 = -1;

  var_5 = self.clientid;

  if(!isDefined(var_5))
    var_5 = -1;

  self _meth_8681("telemetry_hq_event", ["base", ["hq_guid", _func_398(), "utc_timestamp_join", var_4, "data_center_id", _func_397(), "game_time", gettime(), "player_index", var_5, "player_count", level.players.size, "event_name", var_0, "event_category", var_1, "duration_seconds", var_2], var_0, var_3]);
}

_id_582B() {
  if(_func_367() && level.players.size > 20 && getdvarint("3708", 0) != 1 && getdvarint("3645", 0) != 1)
    return 1;

  return 0;
}

_id_7D1D(var_0) {
  self notify("cancelEntSwitch");

  if(!isDefined(self._id_4F4D))
    self._id_4F4D = 0;

  if(!isDefined(self._id_4F4B))
    self._id_4F4B = [];

  switch (var_0) {
    case 3:
    case 2:
    case 1:
    case 0:
      if(!isDefined(self._id_4F4B[var_0]) || self._id_4F4B[var_0] == 0) {
        self._id_4F4B[var_0] = 1;
        self._id_4F4D = self._id_4F4D + 1;
      }

      self _meth_85EA("ET_PLAYER");
      break;
    default:
      break;
  }
}

_id_86FE() {
  self endon("cancelEntSwitch");
  self endon("disconnect");
  level endon("game_ended");
  wait 4;
  self _meth_85EA("ET_PLAYER_HUB");
}

_id_7E4E(var_0) {
  self notify("cancelEntSwitch");

  if(!isDefined(self._id_4F4D))
    self._id_4F4D = 0;

  if(!isDefined(self._id_4F4B))
    self._id_4F4B = [];

  switch (var_0) {
    case 3:
    case 2:
    case 1:
    case 0:
      if(isDefined(self._id_4F4B[var_0]) && self._id_4F4B[var_0] == 1) {
        self._id_4F4B[var_0] = 0;
        self._id_4F4D = self._id_4F4D - 1;
      } else
        self._id_4F4B[var_0] = 0;

      break;
    default:
      break;
  }

  if(self._id_4F4D == 0)
    thread _id_86FE();
}

_id_7D1E(var_0) {
  if(!isDefined(self._id_4F4E))
    self._id_4F4E = 0;

  if(!isDefined(self._id_4F4F))
    self._id_4F4F = [];

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      if(!isDefined(self._id_4F4F[var_0]) || self._id_4F4F[var_0] == 0) {
        self._id_4F4F[var_0] = 1;
        self._id_4F4E = self._id_4F4E + 1;
      }

      self setclientomnvar("blockPlaylistUpdateWarning", 1);
      break;
    default:
      break;
  }
}

_id_7E4F(var_0) {
  if(!isDefined(self._id_4F4E))
    self._id_4F4E = 0;

  if(!isDefined(self._id_4F4F))
    self._id_4F4F = [];

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      if(isDefined(self._id_4F4F[var_0]) && self._id_4F4F[var_0] == 1) {
        self._id_4F4F[var_0] = 0;
        self._id_4F4E = self._id_4F4E - 1;
      } else
        self._id_4F4F[var_0] = 0;

      break;
    default:
      break;
  }

  if(self._id_4F4E == 0)
    self setclientomnvar("blockPlaylistUpdateWarning", 0);
}

_id_8698(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = _getgroundposition(var_0, 20, 512, 120, 0);

  if(isDefined(var_2))
    self setOrigin(var_2, var_1);
  else
    self setOrigin(var_0, var_1);
}

playerlinkeduselinkedvelocity(var_0) {
  level endon("game_ended");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] notify(var_0[var_1 + 1]);
    var_1++;
  }
}

clientclearsoundsubmix() {
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self._id_00B9)) {
    if(issubstr(self._id_00B9, "huba"))
      var_0 = 500;
    else if(issubstr(self._id_00B9, "hubb")) {
      var_0 = 499;
      var_1 = 499;
    } else if(issubstr(self._id_00B9, "hubc"))
      var_0 = 501;
    else if(issubstr(self._id_00B9, "hubd"))
      var_0 = 502;

    if(!isDefined(var_1) && isDefined(self._id_18A8)) {
      if(issubstr(self._id_18A8, "huba"))
        var_1 = 500;
      else if(issubstr(self._id_18A8, "hubb")) {
        var_0 = 499;
        var_1 = 499;
      } else if(issubstr(self._id_18A8, "hubc"))
        var_1 = 501;
      else if(issubstr(self._id_18A8, "hubd"))
        var_1 = 502;
      else if(issubstr(self._id_18A8, "hube"))
        var_1 = 503;
    }
  } else if(issubstr(self.model, "huba"))
    var_0 = 500;
  else if(issubstr(self.model, "hubb")) {
    var_0 = 499;
    var_1 = 499;
  } else if(issubstr(self.model, "hubc"))
    var_0 = 501;
  else if(issubstr(self.model, "hubd"))
    var_0 = 502;
  else if(issubstr(self.model, "hube")) {
    var_0 = 499;
    var_1 = 499;
  }

  if(!isDefined(var_0))
    var_0 = _randomintrange(500, 503);

  if(!isDefined(var_1))
    var_1 = _randomintrange(500, 504);

  self _meth_84C7([var_1, var_0, 0, 0, 0]);
}

_id_4B02(var_0, var_1, var_2) {
  level endon("game_ended");

  for(;;) {
    for(var_3 = 1; var_3 < var_2.size; var_3++) {
      var_0 scriptmodelplayanimdeltamotionfrompos(var_2[0], self.switchtoweapon.origin, self.switchtoweapon.angles, "animEnded");

      foreach(var_5 in var_1) {
        if(var_5._id_0ED2[0] == "") {
          continue;
        }
        var_5._id_378F scriptmodelplayanimdeltamotionfrompos(var_5._id_0ED2[0], self.switchtoweapon.origin, self.switchtoweapon.angles);
      }

      var_0 waittillmatch("animEnded", "end");
      var_0 scriptmodelplayanimdeltamotionfrompos(var_2[var_3], self.switchtoweapon.origin, self.switchtoweapon.angles, "animEnded");

      foreach(var_5 in var_1) {
        if(var_5._id_0ED2[var_3] == "") {
          continue;
        }
        var_5._id_378F scriptmodelplayanimdeltamotionfrompos(var_5._id_0ED2[var_3], self.switchtoweapon.origin, self.switchtoweapon.angles);
      }

      var_0 waittillmatch("animEnded", "end");
    }
  }
}

_id_4F45(var_0) {
  if(!_isdedicatedserver() && (!_func_3AE() || common_scripts\utility::_id_562E(level._id_AC5A))) {
    while(!_istransientloaded(var_0))
      waitframe();
  }
}

_id_74AB(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = "idle";

  for(;;) {
    var_0 scriptmodelplayanimdeltamotionfrompos(var_1[var_4], var_2.origin, var_2.angles, "idle");

    if(var_4 != "idle") {
      var_0 waittillmatch("idle", "end");
      var_4 = "idle";
      continue;
    }

    var_4 = var_0 common_scripts\utility::_id_A712(var_3);
  }
}

_id_3E1F(var_0) {
  var_0._id_3E1E = 1;
  var_0._id_3E27 = 0;
}

_id_3E28(var_0) {
  if(isDefined(var_0))
    self _meth_84EC(var_0, 1);
}

_id_3E15(var_0) {
  self _meth_84EC(var_0, 0);
}

_id_4B90() {
  if(self getplayerdata(common_scripts\utility::_id_46AE(), "forceTutorialDivision") >= 1 || self getplayerdata(common_scripts\utility::_id_46AE(), "matchesCompleted") >= 1)
    return 1;

  return 0;
}

removeunusedpatchclip() {
  var_0 = ["patchclip_item_16_128_128", "patchclip_item_16_64_64", "patchclip_player_16_256_256", "patchclip_player_16_128_128", "patchclip_player_16_64_64", "patchclip_player_128_128_128", "patchclip_player_64_64_64", "patchclip_player_32_32_32", "patchclip_nosight_16_128_128", "patchclip_vehicle_16_256_256", "patchclip_vehicle_16_128_128", "patchclip_vehicle_16_64_64", "patchclip_nosight_16_64_64", "patchclip_vehicle_128_128_128", "patchclip_vehicle_64_64_64", "patchclip_vehicle_32_32_32", "patchclip_nosight_64_64_64", "patchclip_nosight_32_32_32"];

  foreach(var_2 in var_0) {
    var_3 = _getent(var_2, "targetname");

    if(isDefined(var_3))
      var_3 delete();
  }
}