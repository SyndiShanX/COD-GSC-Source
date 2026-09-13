/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\class.gsc
***********************************************/

init() {
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.classmap["juggernaut"] = 0;

  if(istrue(level._id_7EBAD80A50484A39))
    level.classmap["superpower"] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 2; _id_AC0E594AC96AA3A8++)
    level.classmap["class" + _id_AC0E594AC96AA3A8] = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 12; _id_AC0E594AC96AA3A8++)
    level.classmap["custom" + _id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8 - 1;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 6; _id_AC0E594AC96AA3A8++) {
    level.classmap["axis_recipe" + _id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8 - 1;
    level.classmap["allies_recipe" + _id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8 - 1;
  }

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 11; _id_AC0E594AC96AA3A8++)
    level.classmap["default" + _id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8 - 1;

  level.defaultclass = "CLASS_ASSAULT";

  if(getdvarint("mgl", 0) && (scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.gametype == "brtdm" || level.gametype == "brtdm_mgl"))
    level.classtablename = "classtable:classtable_br_default_mgl";
  else if(scripts\mp\utility\game::getsubgametype() == "dmz" && getdvarint("dvar_2BE93DD484220A45", 0) == 0)
    level.classtablename = "classtable:classtable_dmz_default";
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.gametype == "brtdm" || level.gametype == "brtdm_mgl")
    level.classtablename = "classtable:classtable_br_default";
  else if(getdvarint("dvar_72FE29AA713EA21E", 0) != 0) {
    _id_2E37E0F4ABE00FD7 = getdvarint("dvar_72FE29AA713EA21E", 0);

    switch (_id_2E37E0F4ABE00FD7) {
      case 1:
        level.classtablename = "classtable:classtable_snipers_only";
        break;
      default:
        level.classtablename = "classtable:classtable";
        break;
    }

    setomnvar("ui_classtable_override", _id_2E37E0F4ABE00FD7);
  } else if(getdvarint("dvar_1E31D1DA0A5B6558", 0))
    level.classtablename = "classtable:classtable_weapon_test";
  else if(getdvarint("dvar_48B4D51AD390DA4F", 0))
    level.classtablename = "classtable:classtable_gwplus";
  else if(getdvarint("dvar_9FDEAB749D8F74A1", 0))
    level.classtablename = "classtable:" + level._id_1A2B600A06EC21F4._id_6452BBDFE7671A5D;
  else if(scripts\mp\utility\game::isanymlgmatch())
    level.classtablename = "classtable:classtable_cdl";
  else if(isDefined(level._id_62F6F7640E4431E3) && isDefined(level._id_62F6F7640E4431E3._id_09DDC180A1A5121D))
    level.classtablename = "classtable:" + level._id_62F6F7640E4431E3._id_09DDC180A1A5121D;
  else if(isDefined(level._id_1A2B600A06EC21F4) && isDefined(level._id_1A2B600A06EC21F4._id_09DDC180A1A5121D))
    level.classtablename = "classtable:" + level._id_1A2B600A06EC21F4._id_09DDC180A1A5121D;

  _id_B231AD92292E3018 = getDvar("killstreak_overrides", "");

  if(_id_B231AD92292E3018 != "")
    level._id_B231AD92292E3018 = strtok(_id_B231AD92292E3018, ",");

  level._id_C4809F80B4230099 = "kills";

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    level._id_C4809F80B4230099 = "score";

  level thread onplayerconnecting();
  level thread onplayerspawned();
}

_id_E83615F8A92E4378(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  return _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
}

getclasschoice(_id_7E9CCC2D6DDB44DA) {
  return _id_7E9CCC2D6DDB44DA;
}

getweaponchoice(_id_7E9CCC2D6DDB44DA) {
  _id_67F14F8315CB0F2F = strtok(_id_7E9CCC2D6DDB44DA, ",");

  if(_id_67F14F8315CB0F2F.size > 1)
    return int(_id_67F14F8315CB0F2F[1]);
  else
    return 0;
}

cac_getweapon(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "weapon");
}

cac_getweaponattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_10DC579C373A93DD = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
  weapon = cac_getweapon(_id_089688461C79EF11, _id_FE4048AD22C35D73);
  return _id_2669878CF5A1B6BC::_id_6E7BC1B23AFA0EA8(weapon, _id_10DC579C373A93DD);
}

cac_getweaponattachmentid(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
}

_id_A4065E820EB1F919(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_803ECABB6F57B183 = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "customTune", 0);
  _id_803ECBBB6F57B3B6 = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "customTune", 1);
  _id_0BF247E07A72958E = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "hasBPTune");
  return _id_A5D1432D54033EA9(_id_803ECABB6F57B183, _id_803ECBBB6F57B3B6, _id_0BF247E07A72958E);
}

_id_A5D1432D54033EA9(_id_803ECABB6F57B183, _id_803ECBBB6F57B3B6, _id_0BF247E07A72958E) {
  if(_id_0BF247E07A72958E == 1 && _id_803ECABB6F57B183 == 0 && _id_803ECBBB6F57B3B6 == 0) {
    _id_A3DDB63BDD450F67 = "clr";
    _id_62365E59D2D3FABC = "clr";
  } else {
    _id_A3DDB63BDD450F67 = _func_F76FF66A6601D9C9(_id_803ECABB6F57B183);
    _id_62365E59D2D3FABC = _func_F76FF66A6601D9C9(_id_803ECBBB6F57B3B6);
  }

  if(!isDefined(_id_A3DDB63BDD450F67) || !isDefined(_id_62365E59D2D3FABC))
    return undefined;
  else {
    _id_803E8CBB6F572929 = [_id_A3DDB63BDD450F67, _id_62365E59D2D3FABC];
    return _id_803E8CBB6F572929;
  }
}

cac_getweaponlootitemid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "lootItemID");
}

cac_getweaponvariantid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "variantID");
}

cac_getweaponcamo(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "camo");
}

cac_getweaponreticle(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "reticle");
}

cac_getkillstreak(index, class) {
  _id_6C131A37B5DF1AAC = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "killstreakSetups", index, "killstreak");
  _id_8DFCEBBE026021FC = getdvarint("dvar_C71C23FBD639D5D3", 0);

  if(_id_8DFCEBBE026021FC && scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E()) {
    switch (index) {
      case 0:
        _id_6C131A37B5DF1AAC = "uav";
        break;
      case 1:
        _id_6C131A37B5DF1AAC = "toma_strike";
        break;
      case 2:
        _id_6C131A37B5DF1AAC = "directional_uav";
        break;
      default:
        break;
    }
  }

  if(isDefined(level._id_B231AD92292E3018) && getdvarint("dvar_A464CB031C16EE87", 0) > 0) {
    _id_A7F68D4AD3AAA3A3 = level._id_B231AD92292E3018[index];

    if(!isDefined(_id_A7F68D4AD3AAA3A3))
      _id_A7F68D4AD3AAA3A3 = "";

    return _id_A7F68D4AD3AAA3A3;
  }

  return _id_6C131A37B5DF1AAC;
}

cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.archetype;

  return "archetype_assault";
}

cac_getequipmentprimary(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "equipment");
}

_id_9C883CB23C614891(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "variantID");
}

cac_getextraequipmentprimary(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "extraCharge");
}

cac_getequipmentsecondary(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "equipment");
}

_id_D9E6D0A8CBE6B48D(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "variantID");
}

cac_getextraequipmentsecondary(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "extraCharge");
}

cac_getfieldupgrade(_id_089688461C79EF11, _id_A780F473A6275DF4) {
  _id_CAFE84B3BB165C25 = getdvarint("dvar_6F667009CB37E9A0", 0);

  if(_id_CAFE84B3BB165C25 && scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    return "super_ammo_drop";

  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "fieldUpgrades", _id_A780F473A6275DF4);
}

cac_getgesture() {
  _id_DA50F25E979BAB7D = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    _id_6D1A148EFA806994 = level.archetypeids[self.changedarchetypeinfo.archetype];
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", _id_6D1A148EFA806994, "gesture");
  } else
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");

  return scripts\cp_mp\gestures::getgesturedata(_id_DA50F25E979BAB7D);
}

cac_getaccessoryweapon() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessoryweaponbyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorydata() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessorydatabyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorylogic() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessorylogicbyindex(_id_160F3CB2BB4232D3);
}

cac_getloadoutperk(_id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "loadoutPerks", _id_2B8554E15B5C8E77);
}

_id_12B59A6E11FF097F(_id_604F6052C4C383F5) {
  _id_C71AB9F1F2FB1217 = _id_3BB637A8E8D0A7C8();
  _id_131C7A07FD534436 = 6;

  if(isDefined(_id_C71AB9F1F2FB1217))
    _id_131C7A07FD534436 = _id_C71AB9F1F2FB1217._id_1DACE216D1A32D14.size;

  if(_id_604F6052C4C383F5 < _id_131C7A07FD534436)
    return _id_5D63EF3292DD14B9(_id_C71AB9F1F2FB1217._id_1DACE216D1A32D14[_id_604F6052C4C383F5]._id_782866E364DCD2EF);
  else
    _id_604F6052C4C383F5 = _id_604F6052C4C383F5 - _id_131C7A07FD534436;

  _id_23CC182D2553796A = [];
  _id_23CC182D2553796A[0] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", _id_604F6052C4C383F5, "perks", 0);
  _id_23CC182D2553796A[1] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", _id_604F6052C4C383F5, "perks", 1);
  _id_23CC182D2553796A[2] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", _id_604F6052C4C383F5, "perks", 2);
  _id_23CC182D2553796A[3] = self getplayerdata(level.loadoutsgroup, "customPerkPackage", _id_604F6052C4C383F5, "perks", 3);
  return _id_23CC182D2553796A;
}

_id_7E02BBBE3CA7AC36(_id_77BC1C85DC4C173F) {
  return !isDefined(_id_77BC1C85DC4C173F[0]) || _id_77BC1C85DC4C173F[0] == "specialty_null";
}

_id_AB0D3A90EBCA6E74(_id_77BC1C85DC4C173F, _id_782866E364DCD2EF) {
  if(_id_77BC1C85DC4C173F.size != _id_782866E364DCD2EF.size)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_77BC1C85DC4C173F.size; _id_AC0E594AC96AA3A8++) {
    if(_id_782866E364DCD2EF[_id_AC0E594AC96AA3A8] != _id_77BC1C85DC4C173F[_id_AC0E594AC96AA3A8])
      return 0;
  }

  return 1;
}

_id_ED0C3ACFDAC0BAED(_id_77BC1C85DC4C173F) {
  if(_id_7E02BBBE3CA7AC36(_id_77BC1C85DC4C173F))
    return -1;

  _id_C71AB9F1F2FB1217 = _id_3BB637A8E8D0A7C8();

  if(isDefined(_id_C71AB9F1F2FB1217)) {
    _id_131C7A07FD534436 = _id_C71AB9F1F2FB1217._id_1DACE216D1A32D14.size;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_131C7A07FD534436; _id_AC0E594AC96AA3A8++) {
      _id_782866E364DCD2EF = _id_5D63EF3292DD14B9(_id_C71AB9F1F2FB1217._id_1DACE216D1A32D14[_id_AC0E594AC96AA3A8]._id_782866E364DCD2EF);

      if(_id_AB0D3A90EBCA6E74(_id_77BC1C85DC4C173F, _id_782866E364DCD2EF))
        return _id_AC0E594AC96AA3A8;
    }
  }

  return -2;
}

_id_3C33D2D97119A585(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equippedPerkPackageIndex");
}

cac_getloadoutextraperk(_id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "extraPerks", _id_2B8554E15B5C8E77);
}

cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.trait;

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

_id_3BB637A8E8D0A7C8() {
  _id_0DC27B5EC02AA308 = getdvarint("dvar_A0ADE898BFC7AB0E", 0) != 0;
  _id_88028E83EEB63F27 = getdvarint("dvar_D5C6A9526FC3F978", 0) != 0;
  _id_7D2EB356179924AE = getdvarint("dvar_77BAFC3CC445C324", 0) != 0;
  _id_90606D78D79AF3E4 = istrue(_id_0DC27B5EC02AA308) || istrue(_id_88028E83EEB63F27);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_D175A6B927D099AE = getscriptbundle("perkpackagelist:perkpackagelist_mgl_jup");

    if(isDefined(_id_D175A6B927D099AE) && istrue(_id_90606D78D79AF3E4) && !istrue(_id_7D2EB356179924AE))
      _id_FA3697898BE9A322 = "perkpackagelist_mgl_jup";
    else
      _id_FA3697898BE9A322 = "perkpackagelist_mgl";
  } else
    _id_FA3697898BE9A322 = "perkpackagelist_iw9";

  if(istrue(level._id_EC2FB549B15AD827))
    _id_FA3697898BE9A322 = "ranked_perkpackagelist_iw9";
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
      _id_D175A6B927D099AE = getscriptbundle("perkpackagelist:perkpackagelist_mgl_jup");

      if(isDefined(_id_D175A6B927D099AE) && istrue(_id_90606D78D79AF3E4) && !istrue(_id_7D2EB356179924AE))
        _id_FA3697898BE9A322 = "perkpackagelist_mgl_jup";
      else
        _id_FA3697898BE9A322 = "perkpackagelist_mgl";
    } else
      _id_FA3697898BE9A322 = "br_perkpackagelist_iw9";
  }

  _id_C71AB9F1F2FB1217 = getscriptbundle("perkpackagelist:" + _id_FA3697898BE9A322);
  return _id_C71AB9F1F2FB1217;
}

cac_getusingspecialist(_id_089688461C79EF11) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "usingSpecialist");
}

cac_getweaponcosmeticattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment");
}

cac_getweaponsticker(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_36D2ABBDCBCB186C) {
  return self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "sticker", _id_36D2ABBDCBCB186C);
}

_id_70763795B02C14F4(operatorref) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_87E4AF68355FF3EB = _id_0B7A9CE0A2282B79::_id_EF8648922F0937B9(self);

    if(isDefined(_id_87E4AF68355FF3EB))
      return int(_id_87E4AF68355FF3EB);
  }

  return self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");
}

_id_05A29E896A16B251(operatorref) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_F178D65DE52D3894 = _id_0B7A9CE0A2282B79::_id_28F402FA85068F06(self);

    if(isDefined(_id_F178D65DE52D3894))
      return int(_id_F178D65DE52D3894);
  }

  return self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "execution");
}

recipe_getkillstreak(classteam, _id_089688461C79EF11, streakindex) {
  return scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "kilstreakSetups", streakindex, "killstreak");
}

_id_DE324C78ECDC7ACD(player) {
  return player getplayerdata(level._id_5D69837CF4DB0407, "enableDefaultDMZLoadouts");
}

_id_CFA0343E808B7421(player, enabled) {
  player setplayerdata(level._id_5D69837CF4DB0407, "enableDefaultDMZLoadouts", enabled);
}

_id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50) {
  if(!isDefined(level._id_F64740277F13E29B) || level._id_F64740277F13E29B.id != _id_00CEBA6EC7E8CA50) {
    level._id_F64740277F13E29B = spawnStruct();
    level._id_F64740277F13E29B.id = _id_00CEBA6EC7E8CA50;
    level._id_F64740277F13E29B._id_92F35FCFAE58B4EB = [];
    level._id_F64740277F13E29B._id_09DDC180A1A5121D = getscriptbundle(_id_00CEBA6EC7E8CA50);
  }

  return level._id_F64740277F13E29B;
}

_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);

  if(!isDefined(_id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11])) {
    _id_5FF608A2CF5C041B = _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3[_id_089688461C79EF11];
    _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11] = getscriptbundle("classtableentry:" + _id_5FF608A2CF5C041B._id_F90358454413407F);
  }

  return _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11];
}

_id_DF2933F96D726D71(_id_00CEBA6EC7E8CA50) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);
  return _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3.size;
}

table_getaddblueprintattachments(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);
  return scripts\engine\utility::ter_op(_id_FE4048AD22C35D73 == 0, classstruct.primaryweapon._id_8886D83D8D183347, classstruct.secondaryweapon._id_8886D83D8D183347);
}

table_getweapon(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.weapon;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.weapon;
}

table_getweaponattachment(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_AD6F9AC053FF4870 = "none";
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct.primaryweapon.attachments))
    classstruct.primaryweapon.attachments = [classstruct.primaryweapon._id_59F68715C04CE28F, classstruct.primaryweapon._id_59F68815C04CE4C2, classstruct.primaryweapon._id_59F68915C04CE6F5, classstruct.primaryweapon._id_59F68215C04CD790, classstruct.primaryweapon._id_59F68315C04CD9C3, classstruct.primaryweapon._id_59F68415C04CDBF6];

  if(!isDefined(classstruct.secondaryweapon.attachments))
    classstruct.secondaryweapon.attachments = [classstruct.secondaryweapon._id_59F68715C04CE28F, classstruct.secondaryweapon._id_59F68815C04CE4C2, classstruct.secondaryweapon._id_59F68915C04CE6F5, classstruct.secondaryweapon._id_59F68215C04CD790, classstruct.secondaryweapon._id_59F68315C04CD9C3];

  if(_id_FE4048AD22C35D73 == 0)
    _id_AD6F9AC053FF4870 = classstruct.primaryweapon.attachments[_id_DF6D8E005B4B8020];
  else
    _id_AD6F9AC053FF4870 = classstruct.secondaryweapon.attachments[_id_DF6D8E005B4B8020];

  if(!isDefined(_id_AD6F9AC053FF4870) || _id_AD6F9AC053FF4870 == "")
    return "none";
  else
    return _id_AD6F9AC053FF4870;
}

table_getweaponcamo(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.camo;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.camo;
}

table_getweaponreticle(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.reticle;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.reticle;
}

table_getweaponvariantid(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73, rootweapon) {
  _id_1092BC40C58C1C9A = undefined;

  if(_id_FE4048AD22C35D73 == 0)
    _id_1092BC40C58C1C9A = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.variantid;
  else
    _id_1092BC40C58C1C9A = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.variantid;

  return table_parseweaponvariantidvalue(rootweapon, _id_1092BC40C58C1C9A);
}

table_parseweaponvariantidvalue(rootweapon, value) {
  if(rootweapon == "none")
    return 0;

  if(!isDefined(level.blockedvariantidsmap)) {
    level.blockedvariantidsmap = [];
    level.blockedvariantidsmap["iw8_ar_tango21"] = [1];
    level.blockedvariantidsmap["iw8_ar_mike4"] = [5];
    level.blockedvariantidsmap["iw8_ar_kilo433"] = [3];
    level.blockedvariantidsmap["iw8_ar_scharlie"] = [3];
    level.blockedvariantidsmap["iw8_sm_uzulu"] = [4];
    level.blockedvariantidsmap["iw8_sh_romeo870"] = [5];
    level.blockedvariantidsmap["iw8_sh_dpapa12"] = [3];
    level.blockedvariantidsmap["iw8_lm_mgolf34"] = [4];
    level.blockedvariantidsmap["iw8_sn_kilo98"] = [16];
    level.blockedvariantidsmap["iw8_sn_alpha50"] = [2];
    level.blockedvariantidsmap["iw8_sn_hdromeo"] = [4];
    level.blockedvariantidsmap["iw8_pi_golf21"] = [3];
    level.blockedvariantidsmap["iw8_pi_cpapa"] = [15];
    _id_A6F6C01484BD5665 = getDvar("dvar_4CAA11CAEEBF587B", "");

    if(_id_A6F6C01484BD5665 != "") {
      _id_9C58C4F8ACC9CF26 = strtok(_id_A6F6C01484BD5665, ",");

      foreach(_id_9DA910194DABEABE in _id_9C58C4F8ACC9CF26) {
        _id_CBF22C9EDB76E72D = strtok(_id_9DA910194DABEABE, "|");

        if(_id_CBF22C9EDB76E72D.size == 2) {
          _id_34B5CB87E576C08A = _id_CBF22C9EDB76E72D[0];
          _id_D37AB34E1F353F3D = int(_id_CBF22C9EDB76E72D[1]);

          if(!isDefined(level.blockedvariantidsmap[_id_34B5CB87E576C08A]))
            level.blockedvariantidsmap[_id_34B5CB87E576C08A] = [];

          level.blockedvariantidsmap[_id_34B5CB87E576C08A][level.blockedvariantidsmap[_id_34B5CB87E576C08A].size] = _id_D37AB34E1F353F3D;
        }
      }
    }
  }

  _id_60EE6A5BAE11A91B = undefined;

  if(isDefined(level.blockedvariantidsmap[rootweapon]))
    _id_60EE6A5BAE11A91B = level.blockedvariantidsmap[rootweapon];

  variantid = 0;
  _id_B3A4D54288759D77 = getdvarint("dvar_C895AE760D4177D4", 0);

  if(_id_B3A4D54288759D77 == 1)
    variantid = scripts\mp\utility\weapon::getweaponrandomvariantid(rootweapon, _id_60EE6A5BAE11A91B);
  else {
    _id_2891E3DF80A13684 = strtok(value, " ");
    _id_C0AA7602B6BBC954 = [];

    foreach(_id_BE5507030B116D5B in _id_2891E3DF80A13684) {
      _id_FE5E8103F5FAC595 = int(_id_BE5507030B116D5B);

      if(!isDefined(_id_60EE6A5BAE11A91B) || !scripts\engine\utility::array_contains(_id_60EE6A5BAE11A91B, _id_FE5E8103F5FAC595))
        _id_C0AA7602B6BBC954[_id_C0AA7602B6BBC954.size] = _id_FE5E8103F5FAC595;
    }

    if(_id_C0AA7602B6BBC954.size != 0)
      variantid = _id_C0AA7602B6BBC954[randomint(_id_C0AA7602B6BBC954.size)];
  }

  if(variantid == -1)
    variantid = scripts\mp\utility\weapon::getweaponrandomvariantid(rootweapon, _id_60EE6A5BAE11A91B);

  _id_3F57E7EDDC8A4779 = scripts\mp\utility\weapon::weaponisValid(rootweapon, variantid);

  if(!_id_3F57E7EDDC8A4779)
    variantid = 0;

  return variantid;
}

table_getperk(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct._id_77BC1C85DC4C173F))
    classstruct._id_77BC1C85DC4C173F = [classstruct.perks._id_16680ABD1742C050, classstruct.perks._id_16680DBD1742C6E9, classstruct.perks._id_16680CBD1742C4B6];

  return classstruct._id_77BC1C85DC4C173F[_id_2B8554E15B5C8E77];
}

_id_F9C715F78B428034(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  _id_5ED4F9B02E1D9C1C = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_80B7030BB9FE44DF;

  if(isDefined(_id_5ED4F9B02E1D9C1C))
    return _id_5D63EF3292DD14B9(_id_5ED4F9B02E1D9C1C);

  return undefined;
}

table_getextraperk(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct._id_9E0A050F0398EDC3))
    classstruct._id_9E0A050F0398EDC3 = [classstruct._id_50D0559DCBA571E2._id_16680ABD1742C050, classstruct._id_50D0559DCBA571E2._id_16680DBD1742C6E9, classstruct._id_50D0559DCBA571E2._id_16680CBD1742C4B6];

  return classstruct._id_9E0A050F0398EDC3[_id_2B8554E15B5C8E77];
}

table_getequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment.primary;
}

table_getextraequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE.primary;
  return isDefined(value) && value == "1";
}

table_getequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
}

table_getextraequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE._id_D7B9856A19F9B6B5;
  return isDefined(value) && value == 1;
}

table_getsuper(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, index) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);
  classstruct._id_ED1E9520C9E770EA = [classstruct._id_7E39414CE66B7776._id_7E397F4CE66BFFD0, classstruct._id_7E39414CE66B7776._id_7E39824CE66C0669];
  return classstruct._id_ED1E9520C9E770EA[index];
}

table_getspecialist(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).specialist;
  return isDefined(value) && value == 1;
}

table_getgesture(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).gesture;
}

table_getexecution(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).execution;
}

loadout_getplayerstreaktype(loadoutstreaktype) {
  result = undefined;

  switch (loadoutstreaktype) {
    case "streaktype_support":
      result = "support";
      break;
    case "streaktype_specialist":
      result = "specialist";
      break;
    case "streaktype_resource":
      result = "resource";
      break;
    default:
      result = "assault";
  }

  return result;
}

_id_5D63EF3292DD14B9(_id_FA3697898BE9A322) {
  _id_6DB51B5B1A26EEA7 = getscriptbundle("perkpackage:" + _id_FA3697898BE9A322);
  _id_80B7030BB9FE44DF = [4];
  _id_80B7030BB9FE44DF[0] = _id_6DB51B5B1A26EEA7.perks._id_89BA9D57A95DA53B;
  _id_80B7030BB9FE44DF[1] = _id_6DB51B5B1A26EEA7.perks._id_89BA9E57A95DA76E;
  _id_80B7030BB9FE44DF[2] = _id_6DB51B5B1A26EEA7.perks._id_13DB3CA1AD2DB644;
  _id_80B7030BB9FE44DF[3] = _id_6DB51B5B1A26EEA7.perks._id_34FDCA49E62D81EE;
  return _id_80B7030BB9FE44DF;
}

getloadoutstreaktypefromstreaktype(streaktype) {
  if(!isDefined(streaktype))
    return "streaktype_assault";

  switch (streaktype) {
    case "support":
      return "streaktype_support";
    case "specialist":
      return "streaktype_specialist";
    case "assault":
      return "streaktype_assault";
    default:
      return "streaktype_assault";
  }
}

loadout_getclassteam(class) {
  if(self.team == "spectator")
    class = "none";

  classteam = "none";

  if(issubstr(class, "axis"))
    classteam = "axis";
  else if(issubstr(class, "allies"))
    classteam = "allies";

  return classteam;
}

loadout_clearplayer(_id_BEA1F8064EDA3DE9) {
  loadout_clearweapons(_id_BEA1F8064EDA3DE9);
  _detachall(_id_BEA1F8064EDA3DE9);
  scripts\mp\equipment::clearallequipment();

  if(isDefined(self.loadoutarchetype))
    clearscriptable();

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  loadout_clearperks(_id_BEA1F8064EDA3DE9);
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\cp_mp\gestures::cleargesture();
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\accessories::clearplayeraccessory();
  scripts\mp\perks\perkpackage::perkpackage_resetoverridefieldupgrades();

  if(!istrue(_id_BEA1F8064EDA3DE9)) {
    resetfunctionality();
    resetactionslots();
  }
}

loadout_clearweapons(_id_BEA1F8064EDA3DE9) {
  if(istrue(_id_BEA1F8064EDA3DE9)) {
    if(isDefined(self.primaryweaponobj))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweaponobj);

    if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none")
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweaponobj);
  } else
    self takeallweapons();

  self.primaryweapon = undefined;
  self.primaryweaponobj = undefined;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;
}

loadout_giveperk(perkname) {
  if(!isDefined(self.loadoutperks))
    self.loadoutperks = [];

  scripts\mp\utility\perk::giveperk(perkname);
  self.loadoutperks[self.loadoutperks.size] = perkname;
}

loadout_removeperk(perkname) {
  if(isDefined(self.loadoutperks)) {
    _id_5DE1358070F8DAAF = 0;
    _id_F04F11D62E9174AB = [];

    foreach(_id_780BE7DAC4190BB5 in self.loadoutperks) {
      if(!_id_5DE1358070F8DAAF) {
        if(_id_780BE7DAC4190BB5 == perkname) {
          scripts\mp\utility\perk::removeperk(_id_780BE7DAC4190BB5);
          _id_5DE1358070F8DAAF = 1;
          continue;
        }
      }

      _id_F04F11D62E9174AB[_id_F04F11D62E9174AB.size] = _id_780BE7DAC4190BB5;
    }

    self.loadoutperks = _id_F04F11D62E9174AB;
  }
}

loadout_clearperks(_id_BEA1F8064EDA3DE9, _id_8BE0F967AAA6ECA6) {
  if(!isDefined(_id_8BE0F967AAA6ECA6))
    _id_8BE0F967AAA6ECA6 = 0;

  if(getdvarint("dvar_6A4D5CD30C97A609", 0)) {}

  if(istrue(_id_BEA1F8064EDA3DE9)) {
    if(isDefined(self.loadoutperks)) {
      foreach(perkname in self.loadoutperks)
      scripts\mp\utility\perk::removeperk(perkname);
    }

    foreach(perkname, value in self.perks) {
      if(isDefined(self._id_15F3E6DF722FB1CF) && perkname == self._id_15F3E6DF722FB1CF)
        scripts\mp\utility\perk::removeperk(self._id_15F3E6DF722FB1CF);

      if(isDefined(self._id_15F3E5DF722FAF9C) && perkname == self._id_15F3E5DF722FAF9C)
        scripts\mp\utility\perk::removeperk(self._id_15F3E5DF722FAF9C);
    }
  } else {
    if(_id_8BE0F967AAA6ECA6)
      scripts\mp\perks\perks::_id_29EF7A1951B051F7();
    else
      scripts\mp\perks\perks::_clearperks();

    self notify("all_perks_cleared");
  }

  if(getdvarint("dvar_6A4D5CD30C97A609", 0)) {
    logstring("\n PERKS BUG LOGGING - After clear, player has " + self.perks.size + " perks.");

    foreach(_id_FE8F7703F6313ED4, perk in self.perks)
    logstring("\n" + _id_FE8F7703F6313ED4);
  }

  self.loadoutperks = [];
  self notify("loadout_perks_cleared");
}

loadout_getclassstruct() {
  struct = spawnStruct();
  struct.loadoutarchetype = "none";
  struct.loadoutprimary = "none";
  struct.loadoutprimaryattachments = [];
  struct.loadoutprimaryattachmentids = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = "none";
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutprimarycamo = "none";
  struct.loadoutprimaryreticle = "none";
  struct.loadoutprimarylootitemid = 0;
  struct.loadoutprimaryvariantid = -1;
  struct.loadoutprimarycosmeticattachment = "none";
  struct.loadoutprimarystickers = [];

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = "none";

  struct.loadoutsecondary = "none";
  struct.loadoutsecondaryattachments = [];
  struct.loadoutsecondaryattachmentids = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = "none";
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutsecondarycamo = "none";
  struct.loadoutsecondaryreticle = "none";
  struct.loadoutsecondarylootitemid = 0;
  struct.loadoutsecondaryvariantid = -1;
  struct.loadoutsecondarycosmeticattachment = "none";
  struct.loadoutsecondarystickers = [];

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = "none";

  struct.loadoutmeleeslot = "none";
  struct.loadoutperksfromgamemode = 0;
  struct.loadoutperks = [];
  struct.loadoutstandardperks = [];
  struct.loadoutextraperks = [];
  struct.loadoutrigtrait = "specialty_null";
  struct.loadoutusingspecialist = 0;
  struct.loadoutequipmentprimary = "none";
  struct._id_B68E3A0A9C628D23 = 0;
  struct.loadoutextraequipmentprimary = 0;
  struct.loadoutequipmentsecondary = "none";
  struct._id_0A1DFC5CE15795A3 = 0;
  struct.loadoutextraequipmentsecondary = 0;
  struct.loadoutsuper = "none";
  struct.loadoutgesture = "none";
  struct.loadoutaccessorydata = "none";
  struct.loadoutaccessoryweapon = "none";
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";
  struct._id_E4783B05BC8B859F = "none";
  struct._id_887F342B4C851024 = "none";
  struct.loadoutstreaksfilled = 0;
  struct.loadoutstreaktype = "streaktype_assault";
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "none";
  struct.tweakedbyplayerduringmatch = 0;
  struct.gamemodeforcednewloadout = 0;
  struct.iscopiedclass = 0;
  return struct;
}

loadout_copyclassstruct(classstruct) {
  _id_B1186EDCA9E8AEF1 = spawnStruct();
  _id_B1186EDCA9E8AEF1.loadoutarchetype = classstruct.loadoutarchetype;

  if(isDefined(classstruct.loadoutprimaryaddblueprintattachments))
    _id_B1186EDCA9E8AEF1.loadoutprimaryaddblueprintattachments = classstruct.loadoutprimaryaddblueprintattachments;

  _id_B1186EDCA9E8AEF1.loadoutprimary = classstruct.loadoutprimary;
  _id_B1186EDCA9E8AEF1.loadoutprimaryattachments = classstruct.loadoutprimaryattachments;
  _id_B1186EDCA9E8AEF1.loadoutprimaryattachmentids = classstruct.loadoutprimaryattachmentids;
  _id_B1186EDCA9E8AEF1.loadoutprimarycamo = classstruct.loadoutprimarycamo;
  _id_B1186EDCA9E8AEF1.loadoutprimaryreticle = classstruct.loadoutprimaryreticle;
  _id_B1186EDCA9E8AEF1.loadoutprimarylootitemid = classstruct.loadoutprimarylootitemid;
  _id_B1186EDCA9E8AEF1.loadoutprimaryvariantid = classstruct.loadoutprimaryvariantid;
  _id_B1186EDCA9E8AEF1.loadoutprimarycosmeticattachment = classstruct.loadoutprimarycosmeticattachment;
  _id_B1186EDCA9E8AEF1.loadoutprimarystickers = classstruct.loadoutprimaryweaponstickers;

  if(isDefined(classstruct.loadoutsecondaryaddblueprintattachments))
    _id_B1186EDCA9E8AEF1.loadoutsecondaryaddblueprintattachments = classstruct.loadoutsecondaryaddblueprintattachments;

  _id_B1186EDCA9E8AEF1.loadoutsecondary = classstruct.loadoutsecondary;
  _id_B1186EDCA9E8AEF1.loadoutsecondaryattachments = classstruct.loadoutsecondaryattachments;
  _id_B1186EDCA9E8AEF1.loadoutsecondaryattachmentids = classstruct.loadoutsecondaryattachmentids;
  _id_B1186EDCA9E8AEF1.loadoutsecondarycamo = classstruct.loadoutsecondarycamo;
  _id_B1186EDCA9E8AEF1.loadoutsecondaryreticle = classstruct.loadoutsecondaryreticle;
  _id_B1186EDCA9E8AEF1.loadoutsecondarylootitemid = classstruct.loadoutsecondarylootitemid;
  _id_B1186EDCA9E8AEF1.loadoutsecondaryvariantid = classstruct.loadoutsecondaryvariantid;
  _id_B1186EDCA9E8AEF1.loadoutsecondarycosmeticattachment = classstruct.loadoutsecondarycosmeticattachment;
  _id_B1186EDCA9E8AEF1.loadoutsecondarystickers = classstruct.loadoutsecondarystickers;
  _id_B1186EDCA9E8AEF1.loadoutmeleeslot = classstruct.loadoutmeleeslot;
  _id_B1186EDCA9E8AEF1.loadoutperksfromgamemode = classstruct.loadoutperksfromgamemode;
  _id_B1186EDCA9E8AEF1.loadoutperks = classstruct.loadoutperks;
  _id_B1186EDCA9E8AEF1.loadoutstandardperks = classstruct.loadoutstandardperks;
  _id_B1186EDCA9E8AEF1.loadoutextraperks = classstruct.loadoutextraperks;
  _id_B1186EDCA9E8AEF1.loadoutrigtrait = classstruct.loadoutrigtrait;
  _id_B1186EDCA9E8AEF1.loadoutusingspecialist = classstruct.loadoutusingspecialist;
  _id_B1186EDCA9E8AEF1.loadoutequipmentprimary = classstruct.loadoutequipmentprimary;
  _id_B1186EDCA9E8AEF1.loadoutextraequipmentprimary = classstruct.loadoutextraequipmentprimary;
  _id_B1186EDCA9E8AEF1.loadoutequipmentsecondary = classstruct.loadoutequipmentsecondary;
  _id_B1186EDCA9E8AEF1.loadoutextraequipmentsecondary = classstruct.loadoutextraequipmentsecondary;
  _id_B1186EDCA9E8AEF1.loadoutsuper = classstruct.loadoutsuper;
  _id_B1186EDCA9E8AEF1.loadoutgesture = classstruct.loadoutgesture;
  _id_B1186EDCA9E8AEF1.loadoutaccessorydata = classstruct.loadoutaccessorydata;
  _id_B1186EDCA9E8AEF1.loadoutaccessoryweapon = classstruct.loadoutaccessoryweapon;
  _id_B1186EDCA9E8AEF1.loadoutfieldupgrade1 = classstruct.loadoutfieldupgrade1;
  _id_B1186EDCA9E8AEF1.loadoutfieldupgrade2 = classstruct.loadoutfieldupgrade2;
  _id_B1186EDCA9E8AEF1.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
  _id_B1186EDCA9E8AEF1.loadoutstreaktype = classstruct.loadoutstreaktype;
  _id_B1186EDCA9E8AEF1.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
  _id_B1186EDCA9E8AEF1.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
  _id_B1186EDCA9E8AEF1.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
  _id_B1186EDCA9E8AEF1.tweakedbyplayerduringmatch = classstruct.tweakedbyplayerduringmatch;
  _id_B1186EDCA9E8AEF1.gamemodeforcednewloadout = classstruct.gamemodeforcednewloadout;
  _id_B1186EDCA9E8AEF1.iscopiedclass = classstruct.iscopiedclass;
  _id_B1186EDCA9E8AEF1 = loadout_updateclass(_id_B1186EDCA9E8AEF1, "copied");
  return _id_B1186EDCA9E8AEF1;
}

loadout_updateclassteam(struct, class, classteam) {
  classteam = loadout_getclassteam(class);
  _id_089688461C79EF11 = getclassindex(class);
  self.class_num = _id_089688461C79EF11;
  self.classteam = classteam;
  struct.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "archetype");
  struct.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 0, "weapon");

  if(struct.loadoutprimary == "none")
    struct.loadoutprimary = "iw9_me_fists";
  else {
    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++)
      struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 0, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");

    for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
      struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 0, "sticker", _id_36D2ABBDCBCB186C);
  }

  struct.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 0, "camo");
  struct.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 0, "reticle");
  struct.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 1, "weapon");

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++)
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 1, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 1, "sticker", _id_36D2ABBDCBCB186C);

  struct.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 1, "camo");
  struct.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "weaponSetups", 1, "reticle");
  struct.loadoutmeleeslot = "none";
  struct.loadoutequipmentprimary = "none";
  struct.loadoutextraequipmentprimary = 0;
  struct.loadoutequipmentsecondary = "none";
  struct.loadoutextraequipmentsecondary = 0;
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";
  struct.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "gesture");
  struct.loadoutstreaksfilled = 1;
  struct.loadoutkillstreak1 = recipe_getkillstreak(classteam, _id_089688461C79EF11, 0);
  struct.loadoutkillstreak2 = recipe_getkillstreak(classteam, _id_089688461C79EF11, 1);
  struct.loadoutkillstreak3 = recipe_getkillstreak(classteam, _id_089688461C79EF11, 2);
}

loadout_updateclasscustom(struct, class, _id_6B02E0D0B48F639A) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_AD29F2836C550C14(struct, class);
    return;
  }

  _id_089688461C79EF11 = getclassindex(class);
  self.class_num = _id_089688461C79EF11;
  struct.loadoutarchetype = cac_getcharacterarchetype();
  struct.loadoutprimary = cac_getweapon(_id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_659F734FC2A248FF = cac_getweaponattachment(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = _id_659F734FC2A248FF;
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

    if(!istrue(_id_6B02E0D0B48F639A)) {
      _id_C19231FE2990712E = _id_A4065E820EB1F919(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

      if(isDefined(_id_C19231FE2990712E))
        struct._id_193BF3CFB8AEAF0F[_id_659F734FC2A248FF] = _id_C19231FE2990712E;
    }
  }

  struct.loadoutprimarycamo = cac_getweaponcamo(_id_089688461C79EF11, 0);
  struct.loadoutprimaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 0);
  struct.loadoutprimarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 0);
  struct.loadoutprimaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 0);
  struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 0);

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 0, _id_36D2ABBDCBCB186C);

  struct.loadoutsecondary = cac_getweapon(_id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_659F734FC2A248FF = cac_getweaponattachment(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = _id_659F734FC2A248FF;
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

    if(!istrue(_id_6B02E0D0B48F639A)) {
      _id_C19231FE2990712E = _id_A4065E820EB1F919(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

      if(isDefined(_id_C19231FE2990712E))
        struct._id_EAD3720E647F74A3[_id_659F734FC2A248FF] = _id_C19231FE2990712E;
    }
  }

  struct.loadoutsecondarycamo = cac_getweaponcamo(_id_089688461C79EF11, 1);
  struct.loadoutsecondaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 1);
  struct.loadoutsecondarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 1);
  struct.loadoutsecondaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 1);
  struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 1);

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 1, _id_36D2ABBDCBCB186C);

  struct.loadoutequipmentprimary = cac_getequipmentprimary(_id_089688461C79EF11);
  struct._id_B68E3A0A9C628D23 = _id_9C883CB23C614891(_id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary(_id_089688461C79EF11);
  struct.loadoutequipmentsecondary = cac_getequipmentsecondary(_id_089688461C79EF11);
  struct._id_0A1DFC5CE15795A3 = _id_D9E6D0A8CBE6B48D(_id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(_id_089688461C79EF11);
  struct.loadoutgesture = cac_getgesture();
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  struct.loadoutfieldupgrade1 = cac_getfieldupgrade(_id_089688461C79EF11, 0);
  struct.loadoutfieldupgrade2 = cac_getfieldupgrade(_id_089688461C79EF11, 1);
  struct.loadoutstreaksfilled = 1;
  struct.loadoutkillstreak1 = cac_getkillstreak(0, class);
  struct.loadoutkillstreak2 = cac_getkillstreak(1, class);
  struct.loadoutkillstreak3 = cac_getkillstreak(2, class);
  struct.loadoutusingspecialist = cac_getusingspecialist(_id_089688461C79EF11);
}

_id_AD29F2836C550C14(struct, class) {
  _id_089688461C79EF11 = getclassindex(class);
  self.class_num = _id_089688461C79EF11;
  _id_85FB3582623DF614 = _id_0B7A9CE0A2282B79::_id_7DFE7EA5FFD28AD4(self, 0);
  struct.loadoutarchetype = cac_getcharacterarchetype();
  struct.loadoutprimary = _id_85FB3582623DF614.weaponref;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = _id_85FB3582623DF614._id_31553E68A5164E3E[_id_DF6D8E005B4B8020];
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = _id_85FB3582623DF614._id_F3464D71F01F614E[_id_DF6D8E005B4B8020];
    _id_C19231FE2990712E = _id_85FB3582623DF614._id_0EAE5A591E200672[_id_DF6D8E005B4B8020];

    if(isDefined(_id_C19231FE2990712E))
      struct._id_193BF3CFB8AEAF0F[struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020]] = _id_C19231FE2990712E;
  }

  struct.loadoutprimarycamo = _id_85FB3582623DF614._id_91F46FFD5296EEE1;
  struct.loadoutprimaryreticle = _id_85FB3582623DF614._id_B2EC7DAEBAAB7CAF;
  struct.loadoutprimarylootitemid = _id_85FB3582623DF614._id_358E8D9068997399;
  struct.loadoutprimaryvariantid = _id_85FB3582623DF614._id_9DA910194DABEABE;
  struct.loadoutprimarycosmeticattachment = _id_85FB3582623DF614._id_67DFD35699BA2D3E;

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = _id_85FB3582623DF614._id_3A585B7543F910C5[_id_36D2ABBDCBCB186C];

  if(isDefined(_id_85FB3582623DF614._id_EB30BDF1F971A3CD))
    struct._id_C4C1F56F0DDBEEFF = _id_85FB3582623DF614._id_EB30BDF1F971A3CD;

  _id_FC0FAE08675E1054 = _id_0B7A9CE0A2282B79::_id_7DFE7EA5FFD28AD4(self, 1);
  struct.loadoutsecondary = _id_FC0FAE08675E1054.weaponref;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = _id_FC0FAE08675E1054._id_31553E68A5164E3E[_id_DF6D8E005B4B8020];
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = _id_FC0FAE08675E1054._id_F3464D71F01F614E[_id_DF6D8E005B4B8020];
    _id_C19231FE2990712E = undefined;

    if(isDefined(_id_C19231FE2990712E))
      struct._id_EAD3720E647F74A3[struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020]] = _id_C19231FE2990712E;
  }

  struct.loadoutsecondarycamo = _id_FC0FAE08675E1054._id_91F46FFD5296EEE1;
  struct.loadoutsecondaryreticle = _id_FC0FAE08675E1054._id_B2EC7DAEBAAB7CAF;
  struct.loadoutsecondarylootitemid = _id_FC0FAE08675E1054._id_358E8D9068997399;
  struct.loadoutsecondaryvariantid = _id_FC0FAE08675E1054._id_9DA910194DABEABE;
  struct.loadoutsecondarycosmeticattachment = _id_FC0FAE08675E1054._id_67DFD35699BA2D3E;

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = _id_FC0FAE08675E1054._id_3A585B7543F910C5[_id_36D2ABBDCBCB186C];

  if(isDefined(_id_FC0FAE08675E1054._id_EB30BDF1F971A3CD))
    struct._id_F440BB0F08482D83 = _id_FC0FAE08675E1054._id_EB30BDF1F971A3CD;

  _id_0B7A9CE0A2282B79::_id_E10AC19DB1A5E21D(self, struct);
}

loadout_updateclassgamemode(struct, class) {
  if(!isDefined(self.pers["gamemodeLoadout"]) && isbot(self)) {
    scripts\mp\bots\bots_loadout::_id_A693C24DEF6FB1ED();
    loadout_updateclasscallback(struct);
    return;
  }

  self.class_num = getclassindex(class);
  _id_3800B8F9E799AE2C = self.pers["gamemodeLoadout"];

  if(!isDefined(_id_3800B8F9E799AE2C["loadoutArchetype"])) {
    if(isbot(self))
      struct.loadoutarchetype = "archetype_assault";
    else
      struct.loadoutarchetype = cac_getcharacterarchetype();
  } else
    struct.loadoutarchetype = _id_3800B8F9E799AE2C["loadoutArchetype"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutRigTrait"]))
    struct.loadoutrigtrait = _id_3800B8F9E799AE2C["loadoutRigTrait"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryAddBlueprintAttachments"]))
    struct.loadoutprimaryaddblueprintattachments = _id_3800B8F9E799AE2C["loadoutPrimaryAddBlueprintAttachments"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimary"]))
    struct.loadoutprimary = _id_3800B8F9E799AE2C["loadoutPrimary"];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");

    if(isDefined(_id_3800B8F9E799AE2C[_id_EFBDCD88107AF5F9]))
      struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = _id_3800B8F9E799AE2C[_id_EFBDCD88107AF5F9];
  }

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++) {
    _id_5E5774B116A39979 = getstickerloadoutstring(_id_36D2ABBDCBCB186C, "primary");

    if(isDefined(_id_3800B8F9E799AE2C[_id_5E5774B116A39979]))
      struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = _id_3800B8F9E799AE2C[_id_5E5774B116A39979];
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryCamo"]))
    struct.loadoutprimarycamo = _id_3800B8F9E799AE2C["loadoutPrimaryCamo"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryCosmeticAttachment"]))
    struct.loadoutprimarycosmeticattachment = _id_3800B8F9E799AE2C["loadoutPrimaryCosmeticAttachment"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryReticle"]))
    struct.loadoutprimaryreticle = _id_3800B8F9E799AE2C["loadoutPrimaryReticle"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryVariantID"]))
    struct.loadoutprimaryvariantid = _id_3800B8F9E799AE2C["loadoutPrimaryVariantID"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPrimaryVariantID"]) && scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(_id_3800B8F9E799AE2C["roundWinStreakPrimaryCamoTeam"]) && isDefined(self.pers["team"]) && _id_3800B8F9E799AE2C["roundWinStreakPrimaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(_id_3800B8F9E799AE2C["roundWinStreakPrimaryCamo"]))
        struct.loadoutprimarycamo = _id_3800B8F9E799AE2C["roundWinStreakPrimaryCamo"];
    }

    if(_id_3800B8F9E799AE2C["loadoutPrimaryVariantID"] != -1)
      setomnvar("ui_arena_primaryVariantID", _id_3800B8F9E799AE2C["loadoutPrimaryVariantID"]);
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryAddBlueprintAttachments"]))
    struct.loadoutsecondaryaddblueprintattachments = _id_3800B8F9E799AE2C["loadoutSecondaryAddBlueprintAttachments"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondary"]))
    struct.loadoutsecondary = _id_3800B8F9E799AE2C["loadoutSecondary"];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");

    if(isDefined(_id_3800B8F9E799AE2C[_id_EFBDCD88107AF5F9]))
      struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = _id_3800B8F9E799AE2C[_id_EFBDCD88107AF5F9];
  }

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++) {
    _id_5E5774B116A39979 = getstickerloadoutstring(_id_36D2ABBDCBCB186C, "secondary");

    if(isDefined(_id_3800B8F9E799AE2C[_id_5E5774B116A39979]))
      struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = _id_3800B8F9E799AE2C[_id_5E5774B116A39979];
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryCamo"]))
    struct.loadoutsecondarycamo = _id_3800B8F9E799AE2C["loadoutSecondaryCamo"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryCosmeticAttachment"]))
    struct.loadoutsecondarycosmeticattachment = _id_3800B8F9E799AE2C["loadoutSecondaryCosmeticAttachment"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryReticle"]))
    struct.loadoutsecondaryreticle = _id_3800B8F9E799AE2C["loadoutSecondaryReticle"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryVariantID"]))
    struct.loadoutsecondaryvariantid = _id_3800B8F9E799AE2C["loadoutSecondaryVariantID"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSecondaryVariantID"]) && scripts\mp\utility\game::getgametype() == "arena" && _id_3800B8F9E799AE2C["loadoutSecondaryVariantID"] != -1) {
    if(isDefined(_id_3800B8F9E799AE2C["roundWinStreakecondaryCamoTeam"]) && isDefined(self.pers["team"]) && _id_3800B8F9E799AE2C["roundWinStreakecondaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(_id_3800B8F9E799AE2C["roundWinStreakSecondaryCamo"]))
        struct.loadoutsecondarycamo = _id_3800B8F9E799AE2C["roundWinStreakSecondaryCamo"];
    }

    if(_id_3800B8F9E799AE2C["loadoutSecondaryVariantID"] != -1)
      setomnvar("ui_arena_secondaryVariantID", _id_3800B8F9E799AE2C["loadoutSecondaryVariantID"]);
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutMeleeSlot"]))
    struct.loadoutmeleeslot = _id_3800B8F9E799AE2C["loadoutMeleeSlot"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSwimWeapon"]))
    struct._id_E4783B05BC8B859F = _id_3800B8F9E799AE2C["loadoutSwimWeapon"];

  struct.loadoutperksfromgamemode = isDefined(_id_3800B8F9E799AE2C["loadoutPerks"]);

  if(isDefined(_id_3800B8F9E799AE2C["loadoutPerks"]))
    struct.loadoutperks = _id_3800B8F9E799AE2C["loadoutPerks"];

  struct.loadoutextraperksfromgamemode = isDefined(_id_3800B8F9E799AE2C["loadoutExtraPerks"]);

  if(isDefined(_id_3800B8F9E799AE2C["loadoutExtraPerks"]))
    struct.loadoutextraperks = _id_3800B8F9E799AE2C["loadoutExtraPerks"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutEquipmentPrimary"]))
    struct.loadoutequipmentprimary = _id_3800B8F9E799AE2C["loadoutEquipmentPrimary"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutExtraEquipmentPrimary"]))
    struct.loadoutextraequipmentprimary = _id_3800B8F9E799AE2C["loadoutExtraEquipmentPrimary"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutEquipmentSecondary"]))
    struct.loadoutequipmentsecondary = _id_3800B8F9E799AE2C["loadoutEquipmentSecondary"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutExtraEquipmentSecondary"]))
    struct.loadoutextraequipmentsecondary = _id_3800B8F9E799AE2C["loadoutExtraEquipmentSecondary"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutSuper"]))
    struct.loadoutsuper = _id_3800B8F9E799AE2C["loadoutSuper"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutFieldUpgrade1"]))
    struct.loadoutfieldupgrade1 = _id_3800B8F9E799AE2C["loadoutFieldUpgrade1"];

  if(isDefined(_id_3800B8F9E799AE2C["loadoutFieldUpgrade2"]))
    struct.loadoutfieldupgrade2 = _id_3800B8F9E799AE2C["loadoutFieldUpgrade2"];

  if(isbot(self)) {
    struct.loadoutaccessoryweapon = "none";
    struct.loadoutaccessorydata = "none";
    struct.loadoutaccessorylogic = "none";
  } else {
    struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
    struct.loadoutaccessorydata = cac_getaccessorydata();
    struct.loadoutaccessorylogic = cac_getaccessorylogic();
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutGesture"])) {
    if(_id_3800B8F9E799AE2C["loadoutGesture"] == "playerData") {
      if(isbot(self))
        struct.loadoutgesture = "none";
      else
        struct.loadoutgesture = cac_getgesture();
    } else
      struct.loadoutgesture = _id_3800B8F9E799AE2C["loadoutGesture"];
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutKillstreak1"]) && _id_3800B8F9E799AE2C["loadoutKillstreak1"] != "specialty_null" || isDefined(_id_3800B8F9E799AE2C["loadoutKillstreak2"]) && _id_3800B8F9E799AE2C["loadoutKillstreak2"] != "specialty_null" || isDefined(_id_3800B8F9E799AE2C["loadoutKillstreak3"]) && _id_3800B8F9E799AE2C["loadoutKillstreak3"] != "specialty_null") {
    struct.loadoutstreaksfilled = 1;
    struct.loadoutkillstreak1 = _id_3800B8F9E799AE2C["loadoutKillstreak1"];
    struct.loadoutkillstreak2 = _id_3800B8F9E799AE2C["loadoutKillstreak2"];
    struct.loadoutkillstreak3 = _id_3800B8F9E799AE2C["loadoutKillstreak3"];
  }

  if(isDefined(_id_3800B8F9E799AE2C["loadoutUsingSpecialist"]))
    struct.loadoutusingspecialist = 1;
}

loadout_updateclasscallback(struct) {
  if(!isDefined(self.classcallback))
    scripts\engine\utility::error("self.classCallback function reference required for class 'callback'");

  _id_2D720734D96CD35E = self[[self.classcallback]]();

  if(!isDefined(_id_2D720734D96CD35E))
    scripts\engine\utility::error("array required from self.classCallback for class 'callback'");

  if(isbot(self)) {
    if(isDefined(_id_2D720734D96CD35E.archetype))
      struct.loadoutarchetype = "archetype_" + tolower(_id_2D720734D96CD35E.archetype);

    if(isDefined(_id_2D720734D96CD35E.primaryweapon.weapon))
      struct.loadoutprimary = _id_2D720734D96CD35E.primaryweapon.weapon;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68715C04CE28F))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68715C04CE28F;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68815C04CE4C2))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68815C04CE4C2;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68915C04CE6F5))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68915C04CE6F5;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68215C04CD790))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68215C04CD790;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68315C04CD9C3))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68315C04CD9C3;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon._id_59F68415C04CDBF6))
      struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = _id_2D720734D96CD35E.primaryweapon._id_59F68415C04CDBF6;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon.camo))
      struct.loadoutprimarycamo = _id_2D720734D96CD35E.primaryweapon.camo;

    if(isDefined(_id_2D720734D96CD35E.primaryweapon.reticle))
      struct.loadoutprimaryreticle = _id_2D720734D96CD35E.primaryweapon.reticle;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon.weapon))
      struct.loadoutsecondary = _id_2D720734D96CD35E.secondaryweapon.weapon;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon._id_59F68715C04CE28F))
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = _id_2D720734D96CD35E.secondaryweapon._id_59F68715C04CE28F;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon._id_59F68815C04CE4C2))
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = _id_2D720734D96CD35E.secondaryweapon._id_59F68815C04CE4C2;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon._id_59F68915C04CE6F5))
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = _id_2D720734D96CD35E.secondaryweapon._id_59F68915C04CE6F5;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon._id_59F68215C04CD790))
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = _id_2D720734D96CD35E.secondaryweapon._id_59F68215C04CD790;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon._id_59F68315C04CD9C3))
      struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = _id_2D720734D96CD35E.secondaryweapon._id_59F68315C04CD9C3;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon.camo))
      struct.loadoutsecondarycamo = _id_2D720734D96CD35E.secondaryweapon.camo;

    if(isDefined(_id_2D720734D96CD35E.secondaryweapon.reticle))
      struct.loadoutsecondaryreticle = _id_2D720734D96CD35E.secondaryweapon.reticle;

    if(isDefined(_id_2D720734D96CD35E.equipment.primary))
      struct.loadoutequipmentprimary = _id_2D720734D96CD35E.equipment.primary;

    if(isDefined(_id_2D720734D96CD35E.equipment._id_D7B9856A19F9B6B5))
      struct.loadoutequipmentsecondary = _id_2D720734D96CD35E.equipment._id_D7B9856A19F9B6B5;

    if(isDefined(_id_2D720734D96CD35E.perks._id_16680ABD1742C050))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E.perks._id_16680ABD1742C050;

    if(isDefined(_id_2D720734D96CD35E.perks._id_16680DBD1742C6E9))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E.perks._id_16680DBD1742C6E9;

    if(isDefined(_id_2D720734D96CD35E.perks._id_16680CBD1742C4B6))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E.perks._id_16680CBD1742C4B6;

    if(isDefined(_id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680ABD1742C050))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680ABD1742C050;

    if(isDefined(_id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680DBD1742C6E9))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680DBD1742C6E9;

    if(isDefined(_id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680CBD1742C4B6))
      struct.loadoutperks[struct.loadoutperks.size] = _id_2D720734D96CD35E._id_50D0559DCBA571E2._id_16680CBD1742C4B6;

    if(isDefined(_id_2D720734D96CD35E.gesture))
      struct.loadoutgesture = _id_2D720734D96CD35E.gesture;

    if(isDefined(_id_2D720734D96CD35E._id_7E397F4CE66BFFD0))
      struct.loadoutfieldupgrade1 = _id_2D720734D96CD35E._id_7E397F4CE66BFFD0;

    if(isDefined(_id_2D720734D96CD35E._id_7E39824CE66C0669))
      struct.loadoutfieldupgrade2 = _id_2D720734D96CD35E._id_7E39824CE66C0669;

    if(isDefined(_id_2D720734D96CD35E.specialist))
      struct.loadoutusingspecialist = _id_2D720734D96CD35E.specialist;
  } else {
    if(isDefined(_id_2D720734D96CD35E["loadoutArchetype"]))
      struct.loadoutarchetype = _id_2D720734D96CD35E["loadoutArchetype"];

    if(isDefined(_id_2D720734D96CD35E["loadoutPrimaryAddBlueprintAttachments"]))
      struct.loadoutprimaryaddblueprintattachments = _id_2D720734D96CD35E["loadoutPrimaryAddBlueprintAttachments"];

    if(isDefined(_id_2D720734D96CD35E["loadoutPrimary"]))
      struct.loadoutprimary = _id_2D720734D96CD35E["loadoutPrimary"];

    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
      _id_EFBDCD88107AF5F9 = getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");

      if(isDefined(_id_2D720734D96CD35E[_id_EFBDCD88107AF5F9]))
        struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = _id_2D720734D96CD35E[_id_EFBDCD88107AF5F9];
    }

    if(isDefined(_id_2D720734D96CD35E["loadoutPrimaryCamo"]))
      struct.loadoutprimarycamo = _id_2D720734D96CD35E["loadoutPrimaryCamo"];

    if(isDefined(_id_2D720734D96CD35E["loadoutPrimaryReticle"]))
      struct.loadoutprimaryreticle = _id_2D720734D96CD35E["loadoutPrimaryReticle"];

    if(isDefined(_id_2D720734D96CD35E["loadoutPrimaryVariantID"]))
      struct.loadoutprimaryvariantid = _id_2D720734D96CD35E["loadoutPrimaryVariantID"];

    if(isDefined(_id_2D720734D96CD35E["loadoutSecondaryAddBlueprintAttachments"]))
      struct.loadoutsecondaryaddblueprintattachments = _id_2D720734D96CD35E["loadoutSecondaryAddBlueprintAttachments"];

    if(isDefined(_id_2D720734D96CD35E["loadoutSecondary"]))
      struct.loadoutsecondary = _id_2D720734D96CD35E["loadoutSecondary"];

    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
      _id_EFBDCD88107AF5F9 = getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");

      if(isDefined(_id_2D720734D96CD35E[_id_EFBDCD88107AF5F9]))
        struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = _id_2D720734D96CD35E[_id_EFBDCD88107AF5F9];
    }

    if(isDefined(_id_2D720734D96CD35E["loadoutSecondaryCamo"]))
      struct.loadoutsecondarycamo = _id_2D720734D96CD35E["loadoutSecondaryCamo"];

    if(isDefined(_id_2D720734D96CD35E["loadoutSecondaryReticle"]))
      struct.loadoutsecondaryreticle = _id_2D720734D96CD35E["loadoutSecondaryReticle"];

    if(isDefined(_id_2D720734D96CD35E["loadoutSecondaryVariantID"]))
      struct.loadoutsecondaryvariantid = _id_2D720734D96CD35E["loadoutSecondaryVariantID"];

    if(isDefined(_id_2D720734D96CD35E["loadoutMeleeSlot"]))
      struct.loadoutmeleeslot = _id_2D720734D96CD35E["loadoutMeleeSlot"];

    if(isDefined(_id_2D720734D96CD35E["loadoutEquipmentPrimary"]))
      struct.loadoutequipmentprimary = _id_2D720734D96CD35E["loadoutEquipmentPrimary"];

    if(isDefined(_id_2D720734D96CD35E["loadoutExtraEquipmentPrimary"]))
      struct.loadoutextraequipmentprimary = _id_2D720734D96CD35E["loadoutExtraEquipmentPrimary"];

    if(isDefined(_id_2D720734D96CD35E["loadoutEquipmentSecondary"]))
      struct.loadoutequipmentsecondary = _id_2D720734D96CD35E["loadoutEquipmentSecondary"];

    if(isDefined(_id_2D720734D96CD35E["loadoutExtraEquipmentSecondary"]))
      struct.loadoutextraequipmentsecondary = _id_2D720734D96CD35E["loadoutExtraEquipmentSecondary"];

    if(isDefined(_id_2D720734D96CD35E["loadoutSuper"]))
      struct.loadoutsuper = _id_2D720734D96CD35E["loadoutSuper"];

    if(isDefined(_id_2D720734D96CD35E["loadoutGesture"]))
      struct.loadoutgesture = _id_2D720734D96CD35E["loadoutGesture"];

    struct.loadoutstreaksfilled = isDefined(_id_2D720734D96CD35E["loadoutStreak1"]) || isDefined(_id_2D720734D96CD35E["loadoutStreak2"]) || isDefined(_id_2D720734D96CD35E["loadoutStreak3"]);

    if(isDefined(_id_2D720734D96CD35E["loadoutStreakType"]))
      struct.loadoutstreaktype = _id_2D720734D96CD35E["loadoutStreakType"];

    if(isDefined(_id_2D720734D96CD35E["loadoutStreak1"]))
      struct.loadoutkillstreak1 = _id_2D720734D96CD35E["loadoutStreak1"];

    if(isDefined(_id_2D720734D96CD35E["loadoutStreak2"]))
      struct.loadoutkillstreak2 = _id_2D720734D96CD35E["loadoutStreak2"];

    if(isDefined(_id_2D720734D96CD35E["loadoutStreak3"]))
      struct.loadoutkillstreak3 = _id_2D720734D96CD35E["loadoutStreak3"];
  }

  struct._id_DE7FE0F200A1DEFF = isDefined(struct.loadoutperks) && struct.loadoutperks.size > 0;
  struct._id_B5C2D62F9D1DAE7B = isDefined(struct.loadoutextraperks) && struct.loadoutextraperks.size > 0;
}

loadout_updateclassdefault(struct, class) {
  _id_089688461C79EF11 = getclassindex(class);
  self.class_num = _id_089688461C79EF11;
  loadout_updateclassdefault_weapons(struct, _id_089688461C79EF11);
  struct.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutgesture = table_getgesture(level.classtablename, _id_089688461C79EF11);
  struct.loadoutusingspecialist = table_getspecialist(level.classtablename, _id_089688461C79EF11);
  struct.loadoutfieldupgrade1 = table_getsuper(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutfieldupgrade2 = table_getsuper(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  struct.loadoutarchetype = cac_getcharacterarchetype();
  struct.loadoutkillstreak1 = cac_getkillstreak(0, class);
  struct.loadoutkillstreak2 = cac_getkillstreak(1, class);
  struct.loadoutkillstreak3 = cac_getkillstreak(2, class);
  struct.loadoutrigtrait = cac_getloadoutarchetypeperk();

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::_id_E10AC19DB1A5E21D(self, struct);
}

loadout_updateclassdefault_weapons(struct, _id_089688461C79EF11) {
  struct.loadoutprimary = table_getweapon(level.classtablename, _id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++)
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

  struct.loadoutprimarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutsecondary = table_getweapon(level.classtablename, _id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++)
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

  struct.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 1);
}

loadout_updateclassdefault_weaponsheadless(struct) {
  if(!isDefined(self.headlessloadoutindexprimary)) {
    if(!isDefined(level.headlessloadoutindexprimary)) {
      offset = randomint(200);
      level.headlessloadoutindexprimary = offset;
      level.headlessloadoutindexsecondary = offset;
    } else {
      level.headlessloadoutindexprimary++;
      level.headlessloadoutindexsecondary++;
    }

    self.headlessloadoutindexprimary = level.headlessloadoutindexprimary;
    self.headlessloadoutindexsecondary = level.headlessloadoutindexsecondary;
  }

  _id_686861DAFAEB67BA = loadout_updateclassdefault_headlessgetweaponn(self.headlessloadoutindexprimary, 1);
  _id_3B584D0E4ACC08FA = loadout_updateclassdefault_headlessgetweaponn(self.headlessloadoutindexsecondary, 0);
  _id_E6107D9D2A8CF0FD = _id_686861DAFAEB67BA[0];
  _id_EC53CCE80BA56E52 = _id_686861DAFAEB67BA[1];
  _id_4F5FADAC618F5ADD = _id_3B584D0E4ACC08FA[0];
  _id_396B20660F5ABA3E = _id_3B584D0E4ACC08FA[1];
  struct.loadoutprimary = _id_E6107D9D2A8CF0FD;

  foreach(attachment, id in _id_EC53CCE80BA56E52.attachcustomtoidmap) {
    struct.loadoutprimaryattachments[struct.loadoutprimaryattachments.size] = attachment;
    struct.loadoutprimaryattachmentids[struct.loadoutprimaryattachmentids.size] = id;
  }

  struct.loadoutprimaryvariantid = _id_EC53CCE80BA56E52.variantid;
  struct.loadoutsecondary = _id_4F5FADAC618F5ADD;

  foreach(attachment, id in _id_396B20660F5ABA3E.attachcustomtoidmap) {
    struct.loadoutsecondaryattachments[struct.loadoutsecondaryattachments.size] = attachment;
    struct.loadoutsecondaryattachmentids[struct.loadoutsecondaryattachmentids.size] = id;
  }

  struct.loadoutsecondaryvariantid = _id_396B20660F5ABA3E.variantid;
}

loadout_updateclassdefault_headlessgetweaponn(index, _id_B61841814CC99F42) {
  _id_B590DD50C4FE1F77 = 0;
  _id_F56E5C9FA79AC6B6 = -1;

  for(;;) {
    foreach(key, struct in level.weaponlootmapdata) {
      if(struct.variantid == 0 || struct.islocked || !isDefined(struct.attachcustomtoidmap)) {
        continue;
      }
      root = strtok(key, "|")[0];

      if(_id_B61841814CC99F42 != scripts\mp\utility\weapon::iscacprimaryweapon(root)) {
        continue;
      }
      _id_F56E5C9FA79AC6B6++;

      if(_id_F56E5C9FA79AC6B6 == index)
        return [root, struct];
    }
  }
}

loadout_updatestreaktype(struct) {
  if(istrue(struct.loadoutusingspecialist))
    self.streaktype = "streaktype_specialist";
  else
    self.streaktype = "streaktype_assault";

  struct.loadoutstreaktype = self.streaktype;
}

loadout_updateabilities(struct, class) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && getdvarint("dvar_48587F2CFA448879", 1) == 1) {
    return;
  }
  if(!isDefined(self.pers["loadoutPerks"]))
    self.pers["loadoutPerks"] = [];

  if(!isDefined(self.pers["loadoutStandardPerks"]))
    self.pers["loadoutStandardPerks"] = [];

  if(!isDefined(self.pers["loadoutExtraPerks"]))
    self.pers["loadoutExtraPerks"] = [];

  if(!isDefined(self.pers["loadoutRigTrait"]))
    self.pers["loadoutRigTrait"] = [];

  if(!isDefined(self.pers["loadoutUsingSpecialist"]))
    self.pers["loadoutUsingSpecialist"] = 0;

  _id_8CDAA5E3E1CCBE02 = getsubstr(class, 0, 7) == "default";

  if(istrue(struct.loadoutperksfromgamemode) || istrue(struct._id_DE7FE0F200A1DEFF)) {
    loadoutperks = struct.loadoutperks;
    struct.loadoutperks = [];

    foreach(perk in loadoutperks) {
      if(!isDefined(perk) || perk == "specialty_null") {
        continue;
      }
      slot = scripts\mp\perks\perks::getperkslot(perk);

      if(!isDefined(slot)) {
        continue;
      }
      switch (slot) {
        case 2:
          struct._id_15F3E6DF722FB1CF = perk;
          break;
        case 3:
          struct._id_15F3E5DF722FAF9C = perk;
          break;
        default:
          struct.loadoutperks[struct.loadoutperks.size] = perk;
          struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
          break;
      }
    }

    if(istrue(struct.loadoutextraperksfromgamemode) || istrue(struct._id_B5C2D62F9D1DAE7B)) {
      struct.loadoutextraperks = struct.loadoutextraperks;
      return;
    }
  } else if(!scripts\mp\utility\perk::perksenabled())
    return;
  else {
    if(class == "juggernaut" || class == "copied" || class == "superpower") {
      return;
    }
    classteam = loadout_getclassteam(class);
    _id_80B7030BB9FE44DF = [];
    _id_27CB4AAFCA7D6E65 = 0;
    _id_169384367B7C1C89 = 0;

    if(classteam != "none") {} else if(_id_8CDAA5E3E1CCBE02) {
      _id_089688461C79EF11 = getclassindex(class);
      _id_7CA920F6D0B36B7E = _id_F9C715F78B428034(level.classtablename, _id_089688461C79EF11);

      if(isDefined(_id_7CA920F6D0B36B7E))
        _id_80B7030BB9FE44DF = _id_7CA920F6D0B36B7E;
    } else {
      _id_27CB4AAFCA7D6E65 = _id_3C33D2D97119A585(self.class_num);
      _id_80B7030BB9FE44DF = _id_12B59A6E11FF097F(_id_27CB4AAFCA7D6E65);
    }

    if(_id_80B7030BB9FE44DF.size > 0) {
      foreach(perk in _id_80B7030BB9FE44DF) {
        if(perk != "specialty_null") {
          _id_169384367B7C1C89 = 1;
          break;
        }
      }
    }

    for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < 3; _id_2B8554E15B5C8E77++) {
      perk = "specialty_null";

      if(_id_169384367B7C1C89)
        perk = _id_80B7030BB9FE44DF[_id_2B8554E15B5C8E77];
      else if(classteam != "none") {
        _id_089688461C79EF11 = getclassindex(class);
        perk = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "loadoutPerks");
      } else if(_id_8CDAA5E3E1CCBE02) {
        _id_089688461C79EF11 = getclassindex(class);
        perk = table_getperk(level.classtablename, _id_089688461C79EF11, _id_2B8554E15B5C8E77);
      } else
        perk = cac_getloadoutperk(self.class_num, _id_2B8554E15B5C8E77);

      if(isDefined(perk) && perk != "specialty_null") {
        if(_id_2B8554E15B5C8E77 == 2) {
          struct._id_15F3E6DF722FB1CF = perk;
          continue;
        }

        struct.loadoutperks[struct.loadoutperks.size] = perk;
        struct.loadoutstandardperks[struct.loadoutstandardperks.size] = perk;
      }
    }

    for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < 3; _id_2B8554E15B5C8E77++) {
      perk = "specialty_null";

      if(classteam != "none") {
        _id_089688461C79EF11 = getclassindex(class);
        perk = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "extraPerks");
      } else if(_id_8CDAA5E3E1CCBE02) {
        _id_089688461C79EF11 = getclassindex(class);
        perk = table_getextraperk(level.classtablename, _id_089688461C79EF11, _id_2B8554E15B5C8E77);
      } else
        perk = cac_getloadoutextraperk(self.class_num, _id_2B8554E15B5C8E77);

      if(isDefined(perk) && perk != "specialty_null") {
        if(_id_2B8554E15B5C8E77 == 0) {
          if(_id_169384367B7C1C89)
            struct._id_15F3E5DF722FAF9C = _id_80B7030BB9FE44DF[3];
          else
            struct._id_15F3E5DF722FAF9C = perk;
        }

        struct.loadoutextraperks[struct.loadoutextraperks.size] = perk;

        if(perk == "specialty_third_person")
          struct.loadoutperks[struct.loadoutperks.size] = perk;

        continue;
      }

      if(_id_169384367B7C1C89 && _id_2B8554E15B5C8E77 == 0 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        perk = _id_80B7030BB9FE44DF[3];

        if(isDefined(perk) && perk != "specialty_null") {
          struct._id_15F3E5DF722FAF9C = perk;
          struct.loadoutextraperks[struct.loadoutextraperks.size] = perk;
        }
      }
    }

    perk = "specialty_null";

    if(classteam != "none") {
      _id_089688461C79EF11 = getclassindex(class);
      perk = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", classteam, _id_089688461C79EF11, "class", "archetypePerk");
    } else
      perk = cac_getloadoutarchetypeperk();

    if(isDefined(perk) && perk != "specialty_null") {
      struct.loadoutperks[struct.loadoutperks.size] = perk;
      self.pers["loadoutRigTrait"] = perk;
      struct.loadoutrigtrait = perk;
    }

    _id_089688461C79EF11 = getclassindex(class);
    return;
  }
}

loadout_getclasstype(classname) {
  classteam = loadout_getclassteam(classname);

  if(classteam == "none" && !isDefined(classname))
    return "custom";

  if(classteam != "none")
    return "team";
  else if(issubstr(classname, "custom"))
    return "custom";
  else if(classname == "gamemode")
    return "gamemode";
  else if(classname == "callback")
    return "callback";
  else if(classname == "juggernaut")
    return "juggernaut";
  else if(classname == "superpower")
    return "superpower";
  else if(classname == "copied")
    return "copied";
  else
    return "default";
}

loadout_updateglobalclass(globalstruct, class) {
  _id_FD84DF04ADEAD383 = loadout_getclasstype(class);

  switch (_id_FD84DF04ADEAD383) {
    case "team":
      break;
    case "custom":
      break;
    case "gamemode":
      loadout_updateglobalclassgamemode(globalstruct, class);
      break;
    case "callback":
      break;
    case "default":
      break;
    case "juggernaut":
      break;
  }

  return globalstruct;
}

loadout_updateclass(struct, class) {
  if(!isagent(self) && self isplayerheadless() && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    class = "default" + (randomint(5) + 1);

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && _id_DE324C78ECDC7ACD(self))
    class = "default" + (randomint(5) + 1);

  _id_FD84DF04ADEAD383 = loadout_getclasstype(class);
  _id_6B02E0D0B48F639A = 0;

  if(istrue(level._id_EC2FB549B15AD827)) {
    if(level._id_BBCB5F6B1B0A78AE == 1 && getdvarint("dvar_0CA2769E986904FA", 0) == 1 || level._id_BBCB5F6B1B0A78AE != 1)
      _id_6B02E0D0B48F639A = 1;
  }

  switch (_id_FD84DF04ADEAD383) {
    case "team":
      loadout_updateclassteam(struct, class);
      break;
    case "custom":
      loadout_updateclasscustom(struct, class, _id_6B02E0D0B48F639A);
      break;
    case "gamemode":
      loadout_updateclassgamemode(struct, class);
      break;
    case "callback":
      loadout_updateclasscallback(struct);
      break;
    case "default":
      loadout_updateclassdefault(struct, class);
      break;
    case "juggernaut":
      break;
    case "superpower":
      break;
    case "copied":
      break;
  }

  if(!istrue(game["isLaunchChunk"]))
    self.pers["defaultOperatorSkinIndex"] = scripts\mp\teams::pickdefaultoperatorskin(struct.loadoutprimary);

  loadout_updatehasnvg(struct);
  loadout_updateclassfistweapons(struct);
  _id_2DAD855D27735128(struct);
  _id_FB9C11AEB7909511(struct);
  loadout_updatestreaktype(struct);
  loadout_updateabilities(struct, class);
  struct = loadout_validateclass(struct, class);
  loadout_updateclassfinalweapons(struct);

  if(isDefined(level.modeupdateloadoutclass))
    self[[level.modeupdateloadoutclass]](struct);

  return struct;
}

_id_1D52554D28B51CBC(struct, _id_089688461C79EF11, table) {
  struct.loadoutarchetype = "archetype_assault";
  struct.loadoutprimary = _id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.weapon;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < getmaxprimaryattachments(); _id_DF6D8E005B4B8020++)
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(table, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

  struct.loadoutprimarycamo = _id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.camo;
  struct.loadoutprimaryreticle = _id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.reticle;
  struct.loadoutsecondary = _id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.weapon;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++)
    struct._id_DF3825D542A9DB4E[_id_DF6D8E005B4B8020] = table_getweaponattachment(table, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

  struct.loadoutsecondarycamo = _id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.camo;
  struct.loadoutsecondaryreticle = _id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.reticle;
  struct.loadoutmeleeslot = "none";
  struct.loadoutequipmentprimary = _id_0C7A0B640C398497(table, _id_089688461C79EF11).equipment.primary;
  struct.loadoutequipmentsecondary = _id_0C7A0B640C398497(table, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
  struct.loadoutstreaktype = "assault";
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "none";
  struct.loadoutfieldupgrade1 = "super_br_extract";
  struct.loadoutfieldupgrade2 = "none";
  struct.loadoutperks = [_id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680ABD1742C050, _id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680DBD1742C6E9, _id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680CBD1742C4B6, _id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680ABD1742C050, _id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680DBD1742C6E9, _id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  struct.loadoutgesture = "playerData";
  return struct;
}

loadout_updateclassfistweapons(struct) {
  if(struct.loadoutprimary == "none")
    struct.loadoutprimary = "iw9_me_fists";

  if(scripts\mp\utility\game::_id_B7D052E4BF41EE9B()) {
    if(struct.loadoutsecondary == "none")
      struct.loadoutsecondary = "none";
  } else if(struct.loadoutsecondary == "none" && struct.loadoutprimary != "iw9_me_fists" && !istrue(self.isjuggernaut))
    struct.loadoutsecondary = "iw9_me_fists";
  else if(struct.loadoutprimary == "iw9_me_fists" && struct.loadoutsecondary == "iw9_me_fists")
    struct.loadoutsecondary = "none";
}

_id_2DAD855D27735128(struct) {
  if(struct._id_E4783B05BC8B859F == "none") {
    if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "br" || scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      struct._id_E4783B05BC8B859F = "iw9_swimfists_mp";
    else
      struct._id_E4783B05BC8B859F = "iw9_me_diveknife_mp";
  }
}

_id_FB9C11AEB7909511(struct) {
  if(struct._id_887F342B4C851024 == "none")
    struct._id_887F342B4C851024 = "iw9_me_climbfists";
}

loadout_updatehasnvg(struct) {
  if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4())
    struct.loadouthasnvg = 1;
}

loadout_validateclass(struct, class) {
  _id_27CECB4114A00360 = scripts\mp\utility\game::isanymlgmatch() && issubstr(class, "default");

  if(issubstr(class, "custom") || _id_27CECB4114A00360)
    return scripts\mp\validation::validateloadout(struct);

  return struct;
}

loadout_forcearchetype(struct) {
  _id_C69B13A67FE9879F = getdvarint("forcearchetype", 0);

  if(_id_C69B13A67FE9879F > 0) {
    _id_FE8F7703F6313ED4 = getdvarint("forcearchetype", 0);

    switch (_id_FE8F7703F6313ED4) {
      case 1:
        struct.loadoutarchetype = "archetype_assault";
        break;
      default:
        struct.loadoutarchetype = "archetype_assault";
        break;
    }
  } else if(_id_C69B13A67FE9879F == -1) {
    archetypes = ["archetype_assault"];
    _id_00AE14C5A8B1B582 = randomint(archetypes.size);
    struct.loadoutarchetype = archetypes[_id_00AE14C5A8B1B582];
    self iprintlnbold("Random Archetype: " + archetypes[_id_00AE14C5A8B1B582]);
  }
}

loadout_updateplayerarchetype(struct) {
  if(!istrue(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = struct.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
  _id_B6592BB80F5EE4F5 = 1;
  _id_0AD84ADCB356CFCE = 2;
  _id_CB3E24E9928EFA4F = 4;
  _id_F9B7D099AA487FA8 = 8;
  _id_9CE56EBBDEC8A388 = 0;
  _id_98A729282E6315AD = undefined;
  clothtype = undefined;
  _id_F91D73BCC743D785 = 400;
  _id_DB92D9DA17C77527 = 400;
  _id_A8E6644FDA18165A = 900;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    _id_DB92D9DA17C77527 = 133.333;
    _id_A8E6644FDA18165A = 1800;
  }

  switch (self.loadoutarchetype) {
    case "archetype_assault":
      _id_9CE56EBBDEC8A388 = _id_B6592BB80F5EE4F5 | _id_0AD84ADCB356CFCE | _id_CB3E24E9928EFA4F;
      _id_98A729282E6315AD = scripts\mp\archetypes\archassault::applyarchetype;
      clothtype = "vestlight";
      self.clothtype = clothtype;
      break;
    default:
      if(!istrue(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }

      break;
  }

  if(getdvarint("dvar_0BA3719A1AD298B5")) {
    self allowdoublejump(_id_9CE56EBBDEC8A388 &_id_B6592BB80F5EE4F5);
    self allowwallrun(_id_9CE56EBBDEC8A388 &_id_CB3E24E9928EFA4F);
    self allowdodge(_id_9CE56EBBDEC8A388 &_id_F9B7D099AA487FA8);
  } else {
    self allowdoublejump(0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowslide(_id_9CE56EBBDEC8A388 &_id_0AD84ADCB356CFCE);
  self allowlean(0);
  self energy_setmax(0, _id_F91D73BCC743D785);
  self energy_setenergy(0, _id_F91D73BCC743D785);
  self energy_setrestorerate(0, _id_DB92D9DA17C77527);
  self energy_setresttimems(0, _id_A8E6644FDA18165A);
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 10);
  self energy_setresttimems(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

  if(isDefined(_id_98A729282E6315AD))
    self[[_id_98A729282E6315AD]]();
}

loadout_updateclassfinalweapons(struct) {
  if(istrue(struct.loadoutprimaryaddblueprintattachments))
    struct.loadoutprimaryobject = _id_2669878CF5A1B6BC::buildweapon_blueprint(struct.loadoutprimary, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg));
  else
    struct.loadoutprimaryobject = _id_2669878CF5A1B6BC::buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg), struct._id_193BF3CFB8AEAF0F);

  struct.loadoutprimaryfullname = getcompleteweaponname(struct.loadoutprimaryobject);

  if(struct.loadoutsecondary == "none") {
    struct.loadoutsecondaryfullname = "none";
    struct.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(struct.loadoutsecondaryaddblueprintattachments))
      struct.loadoutsecondaryobject = _id_2669878CF5A1B6BC::buildweapon_blueprintwithcustomattachments(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg));
    else
      struct.loadoutsecondaryobject = _id_2669878CF5A1B6BC::buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg), struct._id_EAD3720E647F74A3);

    struct.loadoutsecondaryfullname = getcompleteweaponname(struct.loadoutsecondaryobject);
  }
}

loadout_updateplayerweapons(struct, class, _id_4D71AC90487BA0D7, skipfirstraise) {
  respawnitems = respawnitems_getrespawnitems();
  _id_B86CF5CEF6838543 = respawnitems_hasweapondata(respawnitems);
  _id_10B09490BB78E90E = level.magcount;
  _id_3920D61392AEC9D5 = loadout_giveprimaryweapon(struct, respawnitems, _id_B86CF5CEF6838543);
  _id_976A64288E459315 = undefined;

  if(isDefined(respawnitems)) {
    if(isDefined(respawnitems.weapons) && isDefined(respawnitems.weapons["secondary"]))
      _id_976A64288E459315 = loadout_givesecondaryweapon(struct, respawnitems, _id_B86CF5CEF6838543);
  } else
    _id_976A64288E459315 = loadout_givesecondaryweapon(struct, respawnitems, _id_B86CF5CEF6838543);

  _id_9743C56A4D2DC135(struct);
  _id_A80B77A2ABAA376E(struct);
  _id_607536857FAC2407(struct);
  loadout_updateammo(struct, _id_3920D61392AEC9D5, _id_976A64288E459315, respawnitems, _id_B86CF5CEF6838543, _id_10B09490BB78E90E);
  self.loadoutmeleeslot = struct.loadoutmeleeslot;

  if(!isDefined(_id_3920D61392AEC9D5)) {
    if(isDefined(struct.loadoutprimary))
      logstring("IW9-688909: primaryGiveWeaponObj is undefined, weapon name is " + struct.loadoutprimary);
    else
      logstring("IW9-688909: primaryGiveWeaponObj is undefined, weapon name is also undefined");
  }

  if(self hasweapon(_id_3920D61392AEC9D5))
    spawnweaponobj = _id_3920D61392AEC9D5;
  else
    spawnweaponobj = _id_976A64288E459315;

  if(isDefined(_id_976A64288E459315) && _id_976A64288E459315.basename != "none" && isDefined(_id_3920D61392AEC9D5) && _id_3920D61392AEC9D5.basename == "iw9_me_fists_mp")
    spawnweaponobj = _id_976A64288E459315;

  if(!isai(self))
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(spawnweaponobj);

  if(!isDefined(_id_4D71AC90487BA0D7) || _id_4D71AC90487BA0D7) {
    skipfirstraise = _id_BAE2A0B1DB21CAB9(spawnweaponobj, skipfirstraise);

    if(!isagent(self))
      self setspawnweapon(spawnweaponobj, !skipfirstraise);
  }

  self.spawnweaponobj = spawnweaponobj;
  loadout_updateweapondependentsettings();
}

loadout_finalizeweapons() {
  self notify("loadout_weapon_finalize");

  if(isDefined(self.primaryweaponobj) && !self hasweapon(self.primaryweaponobj)) {
    loadout_giveprimaryweapon(self.classstruct);
    thread trackriotshield_monitorshieldattach();
  }

  if(isDefined(self.secondaryweaponobj) && !self hasweapon(self.secondaryweaponobj)) {
    loadout_givesecondaryweapon(self.classstruct);
    thread trackriotshield_monitorshieldattach();
  }
}

loadout_giveprimaryweapon(struct, respawnitems, _id_B86CF5CEF6838543) {
  self.loadoutprimary = struct.loadoutprimary;
  self.loadoutprimarycamo = struct.loadoutprimarycamo;
  self.loadoutprimaryattachments = struct.loadoutprimaryattachments;
  self.loadoutprimaryattachmentids = struct.loadoutprimaryattachmentids;
  self.loadoutprimaryreticle = struct.loadoutprimaryreticle;
  self.loadoutprimarylootitemid = struct.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = struct.loadoutprimaryvariantid;
  _id_3920D61392AEC9D5 = loadout_giveweaponobj("primary", struct.loadoutprimaryobject, respawnitems, _id_B86CF5CEF6838543);
  self.primaryweapon = struct.loadoutprimaryfullname;
  self.primaryweaponobj = struct.loadoutprimaryobject;
  self.pers["primaryWeapon"] = struct.loadoutprimaryfullname;
  return _id_3920D61392AEC9D5;
}

loadout_givesecondaryweapon(struct, respawnitems, _id_B86CF5CEF6838543) {
  self.loadoutsecondary = struct.loadoutsecondary;
  self.loadoutsecondarycamo = struct.loadoutsecondarycamo;
  self.loadoutsecondaryattachments = struct.loadoutsecondaryattachments;
  self.loadoutsecondaryattachmentids = struct.loadoutsecondaryattachmentids;
  self.loadoutsecondaryreticle = struct.loadoutsecondaryreticle;
  self.loadoutsecondarylootitemid = struct.loadoutsecondarylootitemid;
  self.loadoutsecondaryvariantid = struct.loadoutsecondaryvariantid;
  _id_976A64288E459315 = loadout_giveweaponobj("secondary", struct.loadoutsecondaryobject, respawnitems, _id_B86CF5CEF6838543);
  self.secondaryweapon = struct.loadoutsecondaryfullname;
  self.secondaryweaponobj = struct.loadoutsecondaryobject;
  self.pers["secondaryWeapon"] = struct.loadoutsecondaryfullname;
  return _id_976A64288E459315;
}

loadout_giveweaponobj(weaponslot, weaponobj, respawnitems, _id_B86CF5CEF6838543) {
  _id_6199E5B093C84749 = undefined;

  if(!istrue(_id_B86CF5CEF6838543))
    _id_6199E5B093C84749 = weaponobj;
  else
    _id_6199E5B093C84749 = respawnitems_getweaponobj(respawnitems, weaponslot);

  if(!isundefinedweapon(_id_6199E5B093C84749)) {
    if(scripts\cp_mp\utility\weapon_utility::_id_38642DB3C423BCDC(_id_6199E5B093C84749) && !scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("infil_will_run"))
      thread _id_C6CD33220CCE845A(weaponslot, weaponobj, respawnitems, _id_B86CF5CEF6838543);
    else {
      _id_6199E5B093C84749 = scripts\mp\weapons::updatesavedaltstate(_id_6199E5B093C84749);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_6199E5B093C84749, undefined, undefined, 1);
      scripts\mp\weapons::updatetogglescopestate(_id_6199E5B093C84749);
      scripts\mp\perks\weaponpassives::loadoutweapongiven(_id_6199E5B093C84749);
    }
  }

  return _id_6199E5B093C84749;
}

_id_C6CD33220CCE845A(weaponslot, weaponobj, respawnitems, _id_B86CF5CEF6838543) {
  self endon("death_or_disconnect");
  self endon("swapLoadout");
  self endon("giveLoadout_start");
  level waittill("prematch_over");
  _id_6199E5B093C84749 = undefined;

  if(!istrue(_id_B86CF5CEF6838543))
    _id_6199E5B093C84749 = weaponobj;
  else
    _id_6199E5B093C84749 = respawnitems_getweaponobj(respawnitems, weaponslot);

  if(!isundefinedweapon(_id_6199E5B093C84749)) {
    _id_6199E5B093C84749 = scripts\mp\weapons::updatesavedaltstate(_id_6199E5B093C84749);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_6199E5B093C84749, undefined, undefined, 1);
    scripts\mp\weapons::updatetogglescopestate(_id_6199E5B093C84749);
    scripts\mp\perks\weaponpassives::loadoutweapongiven(_id_6199E5B093C84749);
  }

  if(weaponslot == "primary")
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_6199E5B093C84749);
}

_id_9743C56A4D2DC135(struct) {
  if(struct._id_E4783B05BC8B859F != "none") {
    _id_6199E5B093C84749 = _id_2669878CF5A1B6BC::buildweapon(struct._id_E4783B05BC8B859F);
    self giveweapon(_id_6199E5B093C84749);
  }

  self._id_350710EA016EAC45 = struct._id_E4783B05BC8B859F;
}

_id_A80B77A2ABAA376E(struct) {
  if(struct._id_887F342B4C851024 != "none") {
    _id_6199E5B093C84749 = _id_2669878CF5A1B6BC::buildweapon(struct._id_887F342B4C851024);
    self giveweapon(_id_6199E5B093C84749);
  }

  self._id_F1DDB2E2F886E31E = struct._id_887F342B4C851024;
}

_id_607536857FAC2407(struct) {
  if(struct.loadoutmeleeslot != "none") {
    self giveweapon(struct.loadoutmeleeslot);
    self assignweaponmeleeslot(struct.loadoutmeleeslot);
  }
}

loadout_updateammo(struct, _id_3920D61392AEC9D5, _id_976A64288E459315, respawnitems, _id_B86CF5CEF6838543, _id_10B09490BB78E90E) {
  _id_FF9807DAEEC4751C = [];
  _id_94D101FA8C9C2DA4 = 0;

  if(isDefined(struct.loadoutprimaryobject) && struct.loadoutprimaryobject.basename != "none")
    _id_FF9807DAEEC4751C[_id_FF9807DAEEC4751C.size] = struct.loadoutprimaryobject;

  if(isDefined(struct.loadoutsecondaryobject) && struct.loadoutsecondaryobject.basename != "none")
    _id_FF9807DAEEC4751C[_id_FF9807DAEEC4751C.size] = struct.loadoutsecondaryobject;

  if(isDefined(level.modeloadoutupdateammo))
    self[[level.modeloadoutupdateammo]](_id_FF9807DAEEC4751C);
  else if(istrue(_id_B86CF5CEF6838543)) {
    respawnitems_giveweaponammo(respawnitems, "primary");
    respawnitems_giveweaponammo(respawnitems, "secondary");
  } else if(_id_10B09490BB78E90E != 3) {
    if(isDefined(_id_3920D61392AEC9D5))
      spawnammocountoverride_giveweaponammo(_id_3920D61392AEC9D5, "primary", _id_10B09490BB78E90E);

    if(isDefined(_id_976A64288E459315))
      spawnammocountoverride_giveweaponammo(_id_976A64288E459315, "secondary", _id_10B09490BB78E90E);
  } else {
    foreach(weapon in _id_FF9807DAEEC4751C) {
      if(_func_F30A6D3194F97C09(weapon, "specialty_extraclip")) {
        _id_23887D8D62685E16 = self getweaponammoclip(weapon);

        if(_id_23887D8D62685E16 < 6)
          _id_23887D8D62685E16 = 6;

        _id_DD2DECF8DB7E69B8 = self getweaponammostock(weapon);
        self setweaponammostock(weapon, _id_DD2DECF8DB7E69B8 + _id_23887D8D62685E16);
      }
    }
  }

  if(!istrue(_id_B86CF5CEF6838543) && _id_10B09490BB78E90E == 3) {
    foreach(weapon in _id_FF9807DAEEC4751C) {
      if(istrue(weapon.hasalternate)) {
        _id_6890A4CE965BBA99 = weapon getaltweapon();
        _id_91093EF03654702C = weaponclass(_id_6890A4CE965BBA99);

        if(_id_91093EF03654702C == "grenade")
          self setweaponammostock(_id_6890A4CE965BBA99, 1);

        continue;
      }

      if(scripts\mp\utility\weapon::isakimbo(weapon))
        self setweaponammostock(weapon, self getweaponammostock(weapon) + weaponclipsize(weapon) * 3);
    }
  }
}

loadout_updateweapondependentsettings() {
  scripts\mp\weapons::updatemovespeedscale();
}

_id_87C3B562F2B366EE(player) {
  perks = ["specialty_selectivehearing", "specialty_pistoldraw", "specialty_location_marking"];

  if(scripts\mp\utility\game::islaststandenabled())
    perks[perks.size] = "specialty_pistoldeath";

  if(scripts\cp_mp\utility\game_utility::isnightmap() && scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
    if(getdvarint("dvar_58735393383459D4", 1) == 1)
      perks[perks.size] = "specialty_spygame";
  }

  if(istrue(player._id_8BC1DDAD56AB00BF))
    perks[perks.size] = "specialty_strategist";

  if(istrue(level._id_7F3AAFCF56C9CE14) && isDefined(player._id_04045F099F3DA4BD))
    perks[perks.size] = _id_7E52B56769FA7774::_id_77702C2321292AA3(player._id_04045F099F3DA4BD);

  return perks;
}

loadout_updateplayerperks(struct, class) {
  loadoutperks = struct.loadoutperks;
  _id_15F3E6DF722FB1CF = struct._id_15F3E6DF722FB1CF;
  _id_15F3E5DF722FAF9C = struct._id_15F3E5DF722FAF9C;
  loadoutstandardperks = self.pers["loadoutStandardPerks"];
  loadoutextraperks = self.pers["loadoutExtraPerks"];
  loadoutrigtrait = self.pers["loadoutRigTrait"];
  loadoutusingspecialist = self.pers["loadoutUsingSpecialist"];
  _id_CA485F8EC3DE1D80 = self.pers["perkPackageProgress"];
  _id_CFDC3CD745250748 = self.pers["perkPackageTier2Earned"];
  _id_BACE4E767AF4F379 = self.pers["perkPackageTier3State"];
  respawnitems = respawnitems_getrespawnitems();

  if(_id_B19856925DDABD5A(respawnitems)) {
    loadoutperks = _id_40A3148D5514FFA3(respawnitems);
    _id_15F3E6DF722FB1CF = _id_DC2F8C385699A6E8(respawnitems);
    _id_15F3E5DF722FAF9C = _id_DC2F8D385699A91B(respawnitems);
    loadoutstandardperks = _id_64D9F4542FDD7B14(respawnitems);
    loadoutextraperks = _id_DC35CB143C497599(respawnitems);
    loadoutrigtrait = _id_7F47875B5FD88F24(respawnitems);
    loadoutusingspecialist = _id_EBA2981FA45AE3BF(respawnitems);
    _id_CA485F8EC3DE1D80 = _id_33E44385E17EECC1(respawnitems);
    _id_CFDC3CD745250748 = _id_7AF26FC564E26A5F(respawnitems);
    _id_BACE4E767AF4F379 = _id_7D2BA1E36AFE24B0(respawnitems);
  } else {
    _id_96E16459D5114277 = _id_87C3B562F2B366EE(self);

    foreach(perk in _id_96E16459D5114277)
    loadout_giveperk(perk);
  }

  if(!isDefined(class) || class != "juggernaut") {
    if(struct.loadoutstandardperks.size > 0) {
      _id_1B7E9DC9EB756EF5 = getdvarint("dvar_8463BC866E14F4C7", 0) == 0;

      if(_id_1B7E9DC9EB756EF5) {
        scripts\mp\perks\perks::giveperks(loadoutperks);
        scripts\mp\perks\perks::_id_4613EC15F87B7CF2(_id_15F3E6DF722FB1CF, _id_15F3E5DF722FAF9C);
      }

      if(getdvarint("dvar_9FDEAB749D8F74A1", 0)) {
        self._id_90E8BBDBA663D7C6 = "1st";

        foreach(perk in loadoutperks) {
          if(perk == "specialty_third_person")
            self._id_90E8BBDBA663D7C6 = "3rd";
        }

        self.pers["shootingMode"] = self._id_90E8BBDBA663D7C6;
      }
    }

    if(istrue(_id_CFDC3CD745250748) && isDefined(_id_15F3E6DF722FB1CF))
      scripts\mp\utility\perk::giveperk(_id_15F3E6DF722FB1CF);

    if(isDefined(_id_BACE4E767AF4F379) && isDefined(_id_15F3E5DF722FAF9C) && _id_BACE4E767AF4F379 >= 2)
      scripts\mp\utility\perk::giveperk(_id_15F3E5DF722FAF9C);

    self.pers["loadoutPerks"] = loadoutperks;
    self.pers["loadoutStandardPerks"] = loadoutstandardperks;
    self.pers["loadoutExtraPerks"] = loadoutextraperks;
    self.pers["loadoutRigTrait"] = loadoutrigtrait;
    self.pers["loadoutUsingSpecialist"] = loadoutusingspecialist;

    if(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
      thread scripts\mp\perks\perks::giveperksafterspawn();

    if(!isagent(self) && scripts\mp\utility\dvars::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {
      _id_77BC1C85DC4C173F = loadoutperks;

      if(istrue(level._id_606EB45E074FF204) || istrue(level._id_9A849908E60B857C)) {
        _id_77BC1C85DC4C173F[_id_77BC1C85DC4C173F.size] = _id_15F3E6DF722FB1CF;
        _id_77BC1C85DC4C173F[_id_77BC1C85DC4C173F.size] = _id_15F3E5DF722FAF9C;
      }

      scripts\mp\perks\perks::_id_7C8CC44B58093CE4(_id_77BC1C85DC4C173F);
      scripts\mp\perks\perks::setomnvarsforperklist("ui_spawn_perk_", _id_77BC1C85DC4C173F);
    }
  }

  if(getdvarint("dvar_6A4D5CD30C97A609", 0)) {
    logstring("\n PERKS BUG LOGGING - After update, player has " + self.perks.size + " perks.");

    foreach(_id_FE8F7703F6313ED4, perk in self.perks)
    logstring("\n" + _id_FE8F7703F6313ED4);
  }
}

loadout_updateplayerequipment(struct) {
  respawnitems = respawnitems_getrespawnitems();
  _id_B86CF5CEF6838543 = respawnitems_hasequipmentdata(respawnitems);
  self.loadoutequipmentprimary = struct.loadoutequipmentprimary;
  self.loadoutequipmentsecondary = struct.loadoutequipmentsecondary;
  _id_E7D8E765AC9243A6 = undefined;

  if(!_id_B86CF5CEF6838543)
    _id_E7D8E765AC9243A6 = struct.loadoutequipmentprimary;
  else
    _id_E7D8E765AC9243A6 = respawnitems_getequipmentref(respawnitems, "primary");

  _id_6DC747A4410E0395 = struct._id_B68E3A0A9C628D23;
  _id_604669419E2560E6 = undefined;

  if(!_id_B86CF5CEF6838543)
    _id_604669419E2560E6 = struct.loadoutequipmentsecondary;
  else
    _id_604669419E2560E6 = respawnitems_getequipmentref(respawnitems, "secondary");

  _id_203895659950911D = level.equipment.table[self.loadoutequipmentsecondary].weaponname;
  _id_6E8F0546B97C1DD5 = struct._id_0A1DFC5CE15795A3;
  scripts\mp\equipment::giveequipment(_id_E7D8E765AC9243A6, "primary", _id_6DC747A4410E0395);
  scripts\mp\equipment::giveequipment(_id_604669419E2560E6, "secondary", _id_6E8F0546B97C1DD5);

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_tactical"))
    scripts\mp\equipment::incrementequipmentammo(_id_604669419E2560E6);

  if(_id_B86CF5CEF6838543) {
    respawnitems_giveequipmentammo(respawnitems, "primary");
    respawnitems_giveequipmentammo(respawnitems, "secondary");
  }

  if(scripts\mp\equipment\nvg::_id_258C5E445C8B7F80()) {
    thread scripts\mp\equipment\nvg::runnvg();
    thread loadout_updateplayernvgs();
  }
}

loadout_updateplayernvgs() {
  self endon("death_or_disconnect");
  self notify("loadout_updatePlayerNVGs");
  self endon("loadout_updatePlayerNVGs");
  _id_29D009AA63D16EB7 = 0;

  if(game["roundsPlayed"] == 0 && !istrue(self.hasspawned) && (scripts\cp_mp\utility\game_utility::isnightmap() || getdvarint("dvar_68A323D5BD07266C", 0) == 1)) {
    if(!scripts\mp\flags::gameflag("infil_will_run") || scripts\mp\flags::gameflag("infil_started"))
      _id_29D009AA63D16EB7 = 1;
  } else if(istrue(self.pers["useNVG"]))
    _id_29D009AA63D16EB7 = 1;

  if(istrue(self.inspawncamera))
    scripts\engine\utility::waittill_any_2("spawned_player", "fadeUp_start");

  while(!isDefined(self.operatorcustomization))
    waitframe();

  if(_id_29D009AA63D16EB7)
    self nightvisionviewon(1);

  scripts\mp\equipment\nvg::nvg_update3rdperson(_id_29D009AA63D16EB7);
}

loadout_updateplayersuper(struct) {
  _id_3EE5F90EC4D78460 = struct.loadoutsuper;
  respawnitems = respawnitems_getrespawnitems();
  _id_B86CF5CEF6838543 = respawnitems_hassuperdata(respawnitems);

  if(_id_B86CF5CEF6838543)
    _id_3EE5F90EC4D78460 = respawnitems_getsuperref(respawnitems);

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuperref();

    if(_id_D3C112E63BF53EE5 == _id_3EE5F90EC4D78460 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(_id_3EE5F90EC4D78460 == "none" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
  } else if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::givesuper(self.loadoutsuper, 1);
  } else {
    self.loadoutsuper = struct.loadoutsuper;
    scripts\mp\supers::givesuper(_id_3EE5F90EC4D78460, 1);

    if(_id_B86CF5CEF6838543) {
      scripts\mp\supers::setsuperbasepoints(respawnitems_getsuperpoints(respawnitems));
      scripts\mp\supers::setsuperextrapoints(respawnitems_getsuperextrapoints(respawnitems));
    }
  }
}

loadout_updateplayergesture(struct) {
  if(!istrue(self.btestclient)) {
    if(struct.loadoutgesture != "none") {
      self.loadoutgesture = struct.loadoutgesture;
      scripts\cp_mp\gestures::givegesture(struct.loadoutgesture);
    }
  }
}

loadout_updateplayeraccessory(struct) {
  if(!istrue(self.btestclient)) {
    if(isDefined(struct.loadoutaccessoryweapon) && struct.loadoutaccessoryweapon != "none") {
      self.loadoutaccessorydata = struct.loadoutaccessorydata;
      self.loadoutaccessoryweapon = struct.loadoutaccessoryweapon;
      scripts\mp\accessories::giveplayeraccessory(struct.loadoutaccessorydata, struct.loadoutaccessoryweapon, struct.loadoutaccessorylogic);
    }
  }
}

loadout_updateplayerstreaktype(struct) {
  self.streaktype = loadout_getplayerstreaktype(struct.loadoutstreaktype);

  if(isDefined(level.gametype) && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_FA1875DBAC819C2F = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "scoreStreak");
    self._id_8BC1DDAD56AB00BF = istrue(_id_FA1875DBAC819C2F);
  }
}

loadout_updateplayerkillstreaks(struct, class) {
  if(level._id_C4809F80B4230099 == "score")
    scripts\mp\utility\perk::giveperk("specialty_killstreak_to_scorestreak");

  if(!level.allowkillstreaks) {
    struct.loadoutkillstreak1 = "none";
    struct.loadoutkillstreak2 = "none";
    struct.loadoutkillstreak3 = "none";
  }

  if(struct.loadoutstreaksfilled == 0 && isDefined(self.streakdata) && self.streakdata.streaks.size > 0 && class == "gamemode") {
    _id_3B991F00E2E091E4 = 0;

    foreach(_id_F406BE343AB9CC93 in self.streakdata.streaks) {
      if(_id_3B991F00E2E091E4 == 0) {
        struct.loadoutkillstreak1 = _id_F406BE343AB9CC93.streakname;
        _id_3B991F00E2E091E4++;
        continue;
      }

      if(_id_3B991F00E2E091E4 == 1) {
        struct.loadoutkillstreak2 = _id_F406BE343AB9CC93.streakname;
        _id_3B991F00E2E091E4++;
        continue;
      }

      if(_id_3B991F00E2E091E4 == 2) {
        struct.loadoutkillstreak3 = _id_F406BE343AB9CC93.streakname;
        break;
      }
    }
  }

  _id_66383C9FDF2D18C4 = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];

  if(level.allowkillstreaks) {
    self.pers["hackedStreaks"] = 0;
    _id_66383C9FDF2D18C4 = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
  }

  self.loadoutusingspecialist = 0;
  respawnitems = respawnitems_getrespawnitems();
  _id_B86CF5CEF6838543 = respawnitems_hasstreakdata(respawnitems);

  if(_id_B86CF5CEF6838543 && level.allowkillstreaks)
    _id_66383C9FDF2D18C4 = respawnitems_getstreaks(respawnitems);

  if(level.allowkillstreaks)
    _id_66383C9FDF2D18C4 = sortkillstreaksbycost(_id_66383C9FDF2D18C4);

  if(!isagent(self)) {
    _id_92BBBE3246F6A87B = scripts\mp\killstreaks\killstreaks::arekillstreaksequipped(_id_66383C9FDF2D18C4);

    if(!_id_92BBBE3246F6A87B) {
      self notify("givingLoadout");
      _id_8D31993278C0BBE1 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();
      _id_E6F8BD2478B0E77D = scripts\mp\killstreaks\killstreaks::getavailableequippedkillstreakstructs();

      if(!scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && !isDefined(self.earnedmaxkillstreak))
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();

      for(streakindex = 0; streakindex < _id_66383C9FDF2D18C4.size; streakindex++) {
        _id_153FDEE861E0F06F = _id_66383C9FDF2D18C4[streakindex];

        if(isDefined(_id_153FDEE861E0F06F) && _id_153FDEE861E0F06F != "none" && _id_153FDEE861E0F06F != "")
          scripts\mp\killstreaks\killstreaks::equipkillstreak(_id_153FDEE861E0F06F, streakindex + 1);
      }

      for(_id_CE1A78C55BDD4530 = _id_8D31993278C0BBE1.size - 1; _id_CE1A78C55BDD4530 >= 0; _id_CE1A78C55BDD4530--) {
        _id_153FDEE861E0F06F = _id_8D31993278C0BBE1[_id_CE1A78C55BDD4530];

        if(!_id_153FDEE861E0F06F.isspecialist)
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(_id_8D31993278C0BBE1[_id_CE1A78C55BDD4530], "other");
      }

      for(_id_CE1A78C55BDD4530 = 0; _id_CE1A78C55BDD4530 < _id_E6F8BD2478B0E77D.size; _id_CE1A78C55BDD4530++) {
        _id_153FDEE861E0F06F = _id_E6F8BD2478B0E77D[_id_CE1A78C55BDD4530];

        if(!_id_153FDEE861E0F06F.isspecialist)
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(_id_E6F8BD2478B0E77D[_id_CE1A78C55BDD4530], "other");
      }
    }
  }

  self notify("equipKillstreaksFinished");
}

sortkillstreaksbycost(_id_400D80E48322C797) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_400D80E48322C797.size - 1; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_400D80E48322C797[_id_AC0E594AC96AA3A8]) && _id_400D80E48322C797[_id_AC0E594AC96AA3A8] != "none" && _id_400D80E48322C797[_id_AC0E594AC96AA3A8] != "") {
      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_400D80E48322C797.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(_id_400D80E48322C797[_id_AC0E5C4AC96AAA41]) && _id_400D80E48322C797[_id_AC0E5C4AC96AAA41] != "none" && _id_400D80E48322C797[_id_AC0E5C4AC96AAA41] != "") {
          currentcost = scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_400D80E48322C797[_id_AC0E594AC96AA3A8]);
          _id_6E1140A41607A4C1 = scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_400D80E48322C797[_id_AC0E5C4AC96AAA41]);

          if(_id_6E1140A41607A4C1 < currentcost) {
            ref = _id_400D80E48322C797[_id_AC0E5C4AC96AAA41];
            _id_400D80E48322C797[_id_AC0E5C4AC96AAA41] = _id_400D80E48322C797[_id_AC0E594AC96AA3A8];
            _id_400D80E48322C797[_id_AC0E594AC96AA3A8] = ref;
          }
        }
      }
    }
  }

  return _id_400D80E48322C797;
}

loadout_updateplayeractionslots(struct, class) {
  self setactionslot(3, "altmode");
}

loadout_updatefieldupgrades(struct, class) {
  if(class == "juggernaut" || class == "superpower") {
    return;
  }
  respawnitems = respawnitems_getrespawnitems();

  if(respawnitems_hassuperdata(respawnitems))
    [self.loadoutfieldupgrade1, self.loadoutfieldupgrade2] = _id_2F17741F5C15A7D6(respawnitems);
  else {
    self.loadoutfieldupgrade1 = struct.loadoutfieldupgrade1;
    self.loadoutfieldupgrade2 = struct.loadoutfieldupgrade2;
  }

  if(superisrestricted(self.loadoutfieldupgrade1))
    self.loadoutfieldupgrade1 = "super_deadsilence";

  if(superisrestricted(self.loadoutfieldupgrade2))
    self.loadoutfieldupgrade2 = "super_deadsilence";

  if(scripts\mp\utility\game::isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2)
    self.loadoutfieldupgrade2 = "none";

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed") {
      self.loadoutfieldupgrade1 = _id_15DA17F6AC6380AF(self.loadoutfieldupgrade1);
      self.loadoutfieldupgrade2 = _id_15DA17F6AC6380AF(self.loadoutfieldupgrade2);

      if(self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2)
        self.loadoutfieldupgrade2 = "none";
    }

    thread scripts\mp\supers::watchplayersuperdelayweapon();
    thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getgametype() == "gwai") {
      super = fixsuperforbr(self.loadoutfieldupgrade1);

      if(isDefined(level.forcegivesuper))
        self[[level.forcegivesuper]](super);
    }
  } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_4C8A3999FEF6F4F6 = 0;
    _id_950A7F7BF33D118D = getDvar("dvar_5F03217B17054E74");

    if(_id_950A7F7BF33D118D != "" && scripts\mp\supers::_id_3B0BB7416DC0F9F1(_id_950A7F7BF33D118D)) {
      self.loadoutfieldupgrade1 = _id_950A7F7BF33D118D;
      _id_4C8A3999FEF6F4F6 = 1;
    }

    self.loadoutbrfieldupgrade = fixsuperforbr(self.loadoutfieldupgrade1);
    self.loadoutfieldupgrade1 = "none";
    self.loadoutfieldupgrade2 = "none";

    if(getdvarint("dvar_52994F8FC649C87A", 0) == 0)
      scripts\mp\perks\perkpackage::perkpackage_initpersdata();

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && isDefined(level.forcegivesuper) || _id_4C8A3999FEF6F4F6)
      self[[level.forcegivesuper]](self.loadoutbrfieldupgrade);
  }

  if(self.loadoutfieldupgrade1 != "super_emp_pulse" && self.loadoutfieldupgrade2 != "super_emp_pulse")
    _id_5E2DCB7FB9811781::_id_75BAA17A54260F6F(0);
}

fixsuperforbr(_id_EBEC497FF8B18A45) {
  if(!istrue(level._id_D040719163E20394) && !isDefined(_id_EBEC497FF8B18A45))
    return "super_ammo_drop";
  else {
    _id_55319C52DE1E69F5 = !scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() || scripts\mp\utility\game::getsubgametype() == "rumble_mgl";

    if(_id_EBEC497FF8B18A45 == "none" && _id_55319C52DE1E69F5 && !_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
      return "super_ammo_drop";
    else
      return _id_EBEC497FF8B18A45;
  }
}

_id_15DA17F6AC6380AF(_id_FED7B85886638423) {
  switch (_id_FED7B85886638423) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      _id_FED7B85886638423 = "super_ammo_drop";
      break;
    default:
      break;
  }

  return _id_FED7B85886638423;
}

loadout_updateplayer(globalstruct, struct, class, _id_4D71AC90487BA0D7, skipfirstraise) {
  loadout_updateplayerstreaktype(struct);
  loadout_updateplayerarchetype(struct);

  if(!istrue(level.noweaponsonstart))
    loadout_updateplayerweapons(struct, class, _id_4D71AC90487BA0D7, skipfirstraise);

  loadout_updateplayerperks(struct, class);

  if(!istrue(level.noweaponsonstart))
    loadout_updateplayerequipment(struct);

  if(!istrue(game["isLaunchChunk"]) && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    loadout_updateplayerkillstreaks(struct, class);

  loadout_updateplayeractionslots(struct, class);

  if(!istrue(game["isLaunchChunk"]))
    loadout_updatefieldupgrades(struct, class);

  self.pers["lastClass"] = self.class;
  self.lastclass = self.class;
  self.lastarchetypeinfo = self.changedarchetypeinfo;

  if(isDefined(self.gamemode_chosenclass)) {
    self.pers["class"] = self.gamemode_chosenclass;
    self.pers["lastClass"] = self.gamemode_chosenclass;
    self.class = self.gamemode_chosenclass;
    self.lastclass = self.gamemode_chosenclass;
    self.gamemode_chosenclass = undefined;
  }

  if(isDefined(self.revive_chosenclass)) {
    self.pers["class"] = self.revive_chosenclass;
    self.pers["lastClass"] = self.revive_chosenclass;
    self.class = self.revive_chosenclass;
    self.lastclass = self.revive_chosenclass;
  }

  scripts\mp\teams::setupplayermodel();
  _id_C5CE8711741E44B8();
  loadout_updateplayeraccessory(struct);

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && _id_DE324C78ECDC7ACD(self))
    _id_0B7A9CE0A2282B79::_id_F19E6219C8DFB06E(self);
}

setmlgspectatorclientloadoutdata(player, struct) {
  if(isagent(player)) {
    return;
  }
  player endon("disconnect");
  player notify("setMLGSpectatorClientLoadoutData()");
  player endon("setMLGSpectatorClientLoadoutData()");
  player setclientweaponinfo(0, struct.loadoutprimaryfullname);
  player setclientweaponinfo(1, struct.loadoutsecondaryfullname);

  if(isDefined(self.equipment["primary"])) {
    _id_9DA2F83262BCA52F = scripts\mp\equipment::getequipmenttableinfo(self.equipment["primary"]);

    if(isDefined(_id_9DA2F83262BCA52F))
      player setclientloadoutinfo("primaryPower", _id_9DA2F83262BCA52F.id);
  }

  if(isDefined(self.equipment["secondary"])) {
    _id_EF8CE378A3DC072B = scripts\mp\equipment::getequipmenttableinfo(self.equipment["secondary"]);

    if(isDefined(_id_EF8CE378A3DC072B))
      player setclientloadoutinfo("secondaryPower", _id_EF8CE378A3DC072B.id);
  }

  if(self.loadoutfieldupgrade2 == "none")
    player setclientloadoutinfo("fieldUpgrade", scripts\mp\supers::getsuperid(self.loadoutfieldupgrade1));
  else
    player setclientloadoutinfo("fieldUpgrade", 255);

  _id_C59E88D893128017 = scripts\mp\supers::getsuperid(struct.loadoutsuper);
  player setclientloadoutinfo("super", _id_C59E88D893128017);

  if(isai(player)) {
    for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < struct.loadoutperks.size; _id_2B8554E15B5C8E77++) {
      perk = struct.loadoutperks[_id_2B8554E15B5C8E77];
      _id_8852E1DA266FEA14 = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(_id_2B8554E15B5C8E77 + 1 + "_perk", _id_8852E1DA266FEA14);
    }
  } else {
    if(struct.loadoutperksfromgamemode)
      struct.loadoutstandardperks = struct.loadoutperks;

    for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < self.pers["loadoutPerks"].size; _id_2B8554E15B5C8E77++) {
      perk = self.pers["loadoutPerks"][_id_2B8554E15B5C8E77];
      _id_8852E1DA266FEA14 = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(_id_2B8554E15B5C8E77 + 1 + "_perk", _id_8852E1DA266FEA14);
    }

    for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < struct.loadoutextraperks.size; _id_2B8554E15B5C8E77++) {
      perk = struct.loadoutextraperks[_id_2B8554E15B5C8E77];
      _id_8852E1DA266FEA14 = scripts\mp\perks\perks::getperkid(perk);
      player setclientloadoutinfo(_id_2B8554E15B5C8E77 + 1 + "_extraPerk", _id_8852E1DA266FEA14);
    }
  }

  _id_E50678F76FC66FBB = struct.loadoutrigtrait;
  _id_CADB7E2A87892576 = scripts\mp\perks\perks::getperkid(_id_E50678F76FC66FBB);
  player setclientloadoutinfo("rigTrait", _id_CADB7E2A87892576);
  _id_6D1A148EFA806994 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(struct.loadoutarchetype);
  player setclientloadoutinfo("archetype", _id_6D1A148EFA806994);
}

shouldallowinstantclassswap() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    disableclassswapallowed();

  if(!isDefined(self.instantclassswapallowed))
    return 1;

  return self.instantclassswapallowed;
}

swaploadout() {
  if(scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && scripts\engine\utility::ent_flag("swapLoadout_blocked")) {
    self endon("death_or_disconnect");
    self endon("joined_team");
    self endon("joined_spectators");
    self notify("swapLoadout");
    self endon("swapLoadout");

    if(!scripts\engine\utility::ent_flag("swapLoadout_pending"))
      scripts\engine\utility::ent_flag_set("swapLoadout_pending");

    self waittill("swapLoadout_blocked");
  }

  setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(scripts\mp\utility\game::allowclasschoice())
    scripts\mp\utility\stats::incpersstat("classChanges", 1);

  giveloadout(self.pers["team"], self.pers["class"], undefined, 1);
  _id_2B89CA43CAC539D8 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done");

  if(_id_2B89CA43CAC539D8 && isDefined(level._id_B89A535236A6F3D8) && !istrue(level._id_8281A47E2CECB257))
    self[[level._id_B89A535236A6F3D8]]();

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1 && isDefined(level._id_2C4E8C67F6F62117))
    self[[level._id_2C4E8C67F6F62117]]();

  if(scripts\engine\utility::ent_flag_exist("swapLoadout_pending") && scripts\engine\utility::ent_flag("swapLoadout_pending")) {
    scripts\engine\utility::ent_flag_clear("swapLoadout_pending");
    scripts\engine\utility::ent_flag_set("swapLoadout_complete");
  }
}

giveloadout(team, class, _id_4D71AC90487BA0D7, _id_BEA1F8064EDA3DE9, skipfirstraise, _id_F15FDB6DCA506606) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;

  if(getdvarint("dvar_6A4D5CD30C97A609", 0)) {
    logstring("\n Player already has " + self.perks.size + " perks.");

    foreach(_id_FE8F7703F6313ED4, perk in self.perks)
    logstring("\n" + _id_FE8F7703F6313ED4);
  }

  if(isDefined(self.perks))
    self.oldperks = self.perks;

  _id_99EF88E44462109E = self.attached_bag;
  loadout_clearplayer(_id_BEA1F8064EDA3DE9);
  globalstruct = loadout_getglobalclassstruct();
  globalstruct = loadout_updateglobalclass(globalstruct, class);
  self.globalstruct = globalstruct;
  struct = undefined;

  if(isDefined(self.preloadedclassstruct)) {
    struct = self.preloadedclassstruct;
    self.preloadedclassstruct = undefined;
    self.class_num = getclassindex(class);
  } else {
    struct = loadout_getclassstruct();
    struct = loadout_updateclass(struct, class);
  }

  self.classstruct = struct;
  loadout_updateplayer(globalstruct, struct, class, _id_4D71AC90487BA0D7, skipfirstraise);

  if(class != "juggernaut" || class != "superpower") {
    _id_200C71E93799B32F(struct);

    if(scripts\mp\flags::gameflag("prematch_done"))
      loadout_lognewlygivenloadout(globalstruct, struct, class);
  }

  self.gettingloadout = 0;

  if(isDefined(_id_99EF88E44462109E) && istrue(_id_F15FDB6DCA506606))
    _id_4480C6CE37B2BDF3::_id_0C3F3FCEEDDDA6F6(_id_99EF88E44462109E);

  respawnitems_clear();
  self notify("changed_kit");
  self notify("giveLoadout");
  scripts\mp\rank::tryresetrankxp();

  if(!istrue(game["isLaunchChunk"]) && !isagent(self))
    scripts\mp\killstreaks\killstreaks::resetforloadoutswitch();

  scripts\mp\playerlogic::trydisableminimap();
}

_id_200C71E93799B32F(struct) {
  if(level.codcasterenabled) {
    if(!isPlayer(self) && !isalive(self)) {
      return;
    }
    if(isagent(self)) {
      return;
    }
    thread setmlgspectatorclientloadoutdata(self, struct);
  }
}

loadout_lognewlygivenloadout(globalstruct, struct, class) {
  if(!isPlayer(self) && !isalive(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(level.codcasterenabled)
    thread setmlgspectatorclientloadoutdata(self, struct);

  if(getdvarint("online_matchdata_enabled") == 0) {
    return;
  }
  if(struct.iscopiedclass) {
    _id_2654B22C71E9AAFC = 99;
    _id_FD84DF04ADEAD383 = "copied";
  } else {
    _id_2654B22C71E9AAFC = getclassindex(class);
    _id_FD84DF04ADEAD383 = loadout_getclasstype(class);
    _id_8CDAA5E3E1CCBE02 = getsubstr(class, 0, 7) == "default";
    self._id_36EA89EADC674509 = class;

    if(_id_8CDAA5E3E1CCBE02)
      _id_2654B22C71E9AAFC = _id_2654B22C71E9AAFC + 20;
  }

  _id_4C5B4888FF814CDE = struct.tweakedbyplayerduringmatch || struct.gamemodeforcednewloadout;
  struct.tweakedbyplayerduringmatch = 0;
  struct.gamemodeforcednewloadout = 0;
  _id_15BAB3EAA5DF4C14 = 0;

  if(!isDefined(self.pers["loggedClasses"]))
    self.pers["loggedClasses"] = [];

  loadoutindex = -1;

  foreach(index, _id_73F89B0786EEF941 in self.pers["loggedClasses"]) {
    _id_B7BFC64A828A13FF = self.pers["loggedClasses"][index];

    if(_id_B7BFC64A828A13FF == _id_2654B22C71E9AAFC) {
      if(_id_4C5B4888FF814CDE) {
        _id_15BAB3EAA5DF4C14 = _id_15BAB3EAA5DF4C14 + 1;
        continue;
      }

      loadoutindex = index;
    }
  }

  _id_D445F727570E7250 = undefined;
  _id_425DDBA200712090 = undefined;

  if(loadoutindex == -1 || struct.iscopiedclass) {
    loadoutindex = self.pers["loggedClasses"].size;
    self.pers["loggedClasses"][loadoutindex] = _id_2654B22C71E9AAFC;
    primaryweapon = struct.loadoutprimaryobject;

    if(isDefined(primaryweapon)) {
      _id_FD464247E82127CB = getweaponvariantindex(primaryweapon);

      if(isDefined(_id_FD464247E82127CB)) {
        _id_08EF2C236F415DCD = _id_2669878CF5A1B6BC::getweaponrootname(primaryweapon) + "|" + _id_FD464247E82127CB;
        _id_134C70A5C6DE474C = level.weaponlootmapdata[_id_08EF2C236F415DCD];

        if(isDefined(_id_134C70A5C6DE474C)) {
          _id_D445F727570E7250 = _id_134C70A5C6DE474C;
          _id_D445F727570E7250._id_2A169C65850E1A47 = _id_08EF2C236F415DCD;
        }
      }
    }

    secondaryweapon = struct.loadoutsecondaryobject;

    if(isDefined(secondaryweapon)) {
      _id_BB70007D1FDC480B = getweaponvariantindex(secondaryweapon);

      if(isDefined(_id_BB70007D1FDC480B)) {
        _id_F5763B2CFAF2080D = _id_2669878CF5A1B6BC::getweaponrootname(secondaryweapon) + "|" + _id_BB70007D1FDC480B;
        _id_134C70A5C6DE474C = level.weaponlootmapdata[_id_F5763B2CFAF2080D];

        if(isDefined(_id_134C70A5C6DE474C)) {
          _id_425DDBA200712090 = _id_134C70A5C6DE474C;
          _id_425DDBA200712090._id_2A169C65850E1A47 = _id_F5763B2CFAF2080D;
        }
      }
    }

    _id_7E2C53B0BCF117D9 = spawnStruct();

    if(isDefined(self.pers["telemetry"]) && isDefined(self.pers["telemetry"].life) && isDefined(self.pers["telemetry"].life._id_6F9BBED303902680))
      _id_7E2C53B0BCF117D9._id_59A52BFE186A64C9 = self.pers["telemetry"].life._id_6F9BBED303902680;

    if(isDefined(_id_D445F727570E7250))
      _id_7E2C53B0BCF117D9._id_D445F727570E7250 = _id_D445F727570E7250;

    if(isDefined(_id_425DDBA200712090))
      _id_7E2C53B0BCF117D9._id_425DDBA200712090 = _id_425DDBA200712090;

    _id_7E2C53B0BCF117D9.globalstruct = globalstruct;
    _id_7E2C53B0BCF117D9.classstruct = struct;
    _id_7E2C53B0BCF117D9._id_FD84DF04ADEAD383 = _id_FD84DF04ADEAD383;
    _id_7E2C53B0BCF117D9.loadoutindex = loadoutindex;
    _id_7E2C53B0BCF117D9._id_15BAB3EAA5DF4C14 = _id_15BAB3EAA5DF4C14;
    _id_7E2C53B0BCF117D9.player = self;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_new_loadout_used", _id_7E2C53B0BCF117D9);
  }

  if(!isDefined(self.loadoutindex) || self.loadoutindex != loadoutindex) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = self;
    _id_7E2C53B0BCF117D9.globalstruct = globalstruct;
    _id_7E2C53B0BCF117D9.struct = struct;
    _id_7E2C53B0BCF117D9.class = class;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_loadout_changed", _id_7E2C53B0BCF117D9);
  }

  self.loadoutindex = loadoutindex;
}

hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"]))
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
}

_detachall(_id_BE69C03CAA346D6C) {
  if(!istrue(_id_BE69C03CAA346D6C))
    self.headmodel = undefined;

  if(isDefined(self.riotshieldmodel))
    scripts\mp\riotshield::riotshield_detach(1);

  if(isDefined(self.riotshieldmodelstowed))
    scripts\mp\riotshield::riotshield_detach(0);

  if(!istrue(_id_BE69C03CAA346D6C)) {
    _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();
    self detachall();
  }

  scripts\mp\equipment\nvg::clearnvg(istrue(_id_BE69C03CAA346D6C));
}

trackriotshield_ontrophystow() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_pullback", objweapon);

    if(objweapon.basename != "trophy_mp") {
      continue;
    }
    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }
    scripts\mp\riotshield::riotshield_move(1);
    self waittill("offhand_end");

    if(scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed))
      scripts\mp\riotshield::riotshield_move(0);
  }
}

istwohandedoffhand(grenade) {
  if(isDefined(grenade) && grenade.basename != "none") {
    if(scripts\mp\utility\weapon::issuperweapon(grenade.basename) && !_id_2669878CF5A1B6BC::_id_6C51B05CE2E9AED3(grenade.basename))
      return 1;

    _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(grenade);

    if(isDefined(_id_11D2F075E9A0E643) && _id_11D2F075E9A0E643 == "lethal")
      return 1;
  }

  return 0;
}

trackriotshield_grenadepullbackforc4() {
  for(;;) {
    self waittill("grenade_pullback", grenade);

    if(!isnullweapon(grenade) && grenade.basename == "c4_mp" && scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon()))
      self.onriotshieldstow_force = 1;

    waitframe();
  }
}

trackriotshield_updateoffhandstowignorec4() {
  if(!istrue(self.onriotshieldstow_force)) {
    weaponobj = self getheldoffhand();

    if(!isnullweapon(weaponobj) && weaponobj.basename != "c4_mp" && scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon()) && istwohandedoffhand(weaponobj))
      self.onriotshieldstow_force = 1;
  }
}

trackriotshield_watchswitchawayfromshield() {
  self.riotshieldswitchawaytimer = undefined;
  self.riotshieldswitchaway = undefined;

  for(;;) {
    self waittill("weapon_switch_started", weapon);

    if(!scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      self.riotshieldswitchawaytimer = gettime() + 200;
      continue;
    }

    self.riotshieldswitchawaytimer = undefined;
    self.riotshieldswitchaway = undefined;
  }
}

trackriotshield_watchcancelswitchaway() {
  for(;;) {
    self waittill("weapon_switch_canceled", weapon);
    waittillframeend;

    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      self.riotshieldswitchawaytimer = undefined;
      self.riotshieldswitchaway = undefined;
    }
  }
}

trackriotshield_monitorshieldattach(wasinlaststand) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");

  if(isDefined(self.infil))
    scripts\mp\flags::gameflagwait("prematch_done");

  childthread trackriotshield_grenadepullbackforc4();

  if(isDefined(wasinlaststand))
    self.wasinlaststand = wasinlaststand;
  else if(!isDefined(self.wasinlaststand))
    self.wasinlaststand = 0;

  while(scripts\mp\riotshield::riotshield_hasweapon()) {
    trackriotshield_updateoffhandstowignorec4();

    if(!istrue(self.inlaststand)) {
      if(self.wasinlaststand) {
        self.laststandforceback = 1;
        self.laststandforcebackendtime = gettime() + 1000;
      } else if(isDefined(self.laststandforcebackendtime) && gettime() >= self.laststandforcebackendtime) {
        self.laststandforceback = undefined;
        self.laststandforcebackendtime = undefined;
      }

      self.wasinlaststand = 0;
    } else {
      self.laststandforceback = undefined;
      self.laststandforcebackendtime = undefined;
      self.wasinlaststand = 1;
    }

    if(self isonladder())
      trackriotshield_tryback();
    else if(self isinexecutionattack())
      trackriotshield_tryback();
    else if(self isinexecutionvictim())
      trackriotshield_trydetach();
    else if(self isparachuting() || self isskydiving())
      trackriotshield_tryback();
    else if(istrue(self.laststandforceback))
      trackriotshield_tryback();
    else if(istrue(self.onriotshieldstow_force)) {
      if(isnullweapon(self getheldoffhand())) {
        self.onriotshieldstow_force = undefined;
        trackriotshield_tryreset();
      } else
        trackriotshield_tryback();
    } else
      trackriotshield_tryreset();

    waitframe();
  }

  trackriotshield_tryreset();
}

trackriotshield_tryback() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onback) {
    if(_id_F8EE3E194415C066)
      scripts\mp\riotshield::riotshield_move(1);
    else
      scripts\mp\riotshield::riotshield_attach(0, scripts\mp\riotshield::riotshield_getmodel());
  }
}

trackriotshield_tryarm() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!_id_F8EE3E194415C066) {
    if(onback)
      scripts\mp\riotshield::riotshield_move(0);
    else
      scripts\mp\riotshield::riotshield_attach(1, scripts\mp\riotshield::riotshield_getmodel());
  }
}

trackriotshield_trydetach() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(_id_F8EE3E194415C066)
    scripts\mp\riotshield::riotshield_detach(1);

  if(onback)
    scripts\mp\riotshield::riotshield_detach(0);
}

trackriotshield_tryreset() {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    _id_E04977FBA6749BED = scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon());

    if(_id_E04977FBA6749BED) {
      trackriotshield_tryarm();
      return;
    }

    trackriotshield_tryback();
    return;
  } else {
    _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
    onback = isDefined(self.riotshieldmodelstowed);

    if(_id_F8EE3E194415C066)
      scripts\mp\riotshield::riotshield_detach(1);

    if(onback)
      scripts\mp\riotshield::riotshield_detach(0);
  }
}

riotshieldonweaponchange(objweapon) {
  if(scripts\mp\riotshield::riotshield_hasweapon())
    thread trackriotshield_monitorshieldattach();
  else {
    trackriotshield_tryreset();
    riotshieldclearvars();
    self notify("riotshield_detach");
  }
}

riotshieldclearvars(_id_FCEF8D217A441961) {
  self.laststandforceback = undefined;
  self.laststandforcebackendtime = undefined;
  self.wasinlaststand = undefined;

  if(istrue(_id_FCEF8D217A441961)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

isweaponsilenced(weapon) {
  return weapon issilenced();
}

getweaponpassives(_id_5C3F9357F11D2223, variantid) {
  return scripts\mp\loot::getpassivesforweapon(_id_5C3F9357F11D2223, variantid);
}

weaponhaspassive(_id_5C3F9357F11D2223, variantid, _id_F8B2E6BF3F40AB02) {
  passives = getweaponpassives(_id_5C3F9357F11D2223, variantid);

  if(!isDefined(passives) || passives.size <= 0)
    return 0;

  foreach(_id_D8DA47E8DAA32CE6 in passives) {
    if(_id_F8B2E6BF3F40AB02 == _id_D8DA47E8DAA32CE6)
      return 1;
  }

  return 0;
}

getweaponvariantattachments(_id_5C3F9357F11D2223, variantid) {
  attachments = [];
  passives = getweaponpassives(_id_5C3F9357F11D2223, variantid);

  if(isDefined(passives)) {
    foreach(_id_F8B2E6BF3F40AB02 in passives) {
      _id_077134C6DD01475F = scripts\mp\passives::getpassiveattachment(_id_F8B2E6BF3F40AB02);

      if(!isDefined(_id_077134C6DD01475F)) {
        continue;
      }
      attachments[attachments.size] = _id_077134C6DD01475F;
    }
  }

  return attachments;
}

replenishloadout() {
  team = self.pers["team"];
  class = self.pers["class"];
  _id_8CAC01EF5BCB1816 = self getweaponslistall();

  for(_id_FE8F7703F6313ED4 = 0; _id_FE8F7703F6313ED4 < _id_8CAC01EF5BCB1816.size; _id_FE8F7703F6313ED4++) {
    weapon = _id_8CAC01EF5BCB1816[_id_FE8F7703F6313ED4];
    self givemaxammo(weapon);
    self setweaponammoclip(weapon, 9999);
    weaponname = weapon.basename;

    if(weaponname == "claymore_mp" || weaponname == "claymore_detonator_mp")
      self setweaponammostock(weapon, 2);
  }
}

onplayerconnecting() {
  for(;;) {
    level waittill("connected", player);
    player enableplayerbreathsystem(0);

    if(!isDefined(player.pers["class"]))
      player.pers["class"] = "";

    if(!isDefined(player.pers["lastClass"]))
      player.pers["lastClass"] = "";

    player.class = player.pers["class"];
    player.lastclass = player.pers["lastClass"];
    player.changedarchetypeinfo = player.pers["changedArchetypeInfo"];
    player.lastarchetypeinfo = undefined;

    if(!isDefined(player.pers["validationInfractions"]))
      player.pers["validationInfractions"] = 0;
  }
}

onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(!isDefined(player)) {
      continue;
    }
    player enableplayerbreathsystem(1);

    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinref) && player.operatorcustomization.skinref + "" == "355")
      player _meth_555E2D32E2756625("gasmask_female");
    else if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female")
      player _meth_555E2D32E2756625("female");
    else if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinref) && player.operatorcustomization.skinref + "" == "319")
      player setentitysoundcontext("gender", "bongmask_male");
    else
      player _meth_555E2D32E2756625("");

    player stoplocalsound("deaths_door_death");

    if(isDefined(level._id_D39AA4B67CEFA0D6))
      player stoplocalsound(level._id_D39AA4B67CEFA0D6);

    player clearsoundsubmix("player_swimming_underwater", 1);
    player clearsoundsubmix("mp_juggernaut", 0.5);
    player clearsoundsubmix("iw9_mp_soccer_goal", 1);
    player setentitysoundcontext("atmosphere", "", 1);
    player clearclienttriggeraudiozone(2);

    if(isDefined(player.operatorsfx)) {
      player clearsoundsubmix("iw8_mp_spawn_camera");
      player.operatorsfx stoploopsound(self.operatorsfxalias);
      player.operatorsfx delete();
      player.operatorsfx = undefined;
      player.operatorsfxalias = undefined;
    }

    if(isDefined(player.operatorcustomization.clothtype) && player.operatorcustomization.clothtype != "")
      player setclothtype(player.operatorcustomization.clothtype);
    else
      player setclothtype("vestlight");

    if(isDefined(player.operatorcustomization._id_400EF51562606E7A) && player.operatorcustomization._id_400EF51562606E7A != "") {
      player _meth_8ABE5A968CC3C220(player.operatorcustomization._id_400EF51562606E7A);
      continue;
    }

    player _meth_8ABE5A968CC3C220("millghtgr");
  }
}

fadeaway(waitdelay, _id_06EA9CF1222359E6) {
  wait(waitdelay);
  self fadeovertime(_id_06EA9CF1222359E6);
  self.alpha = 0;
}

setclass(_id_0AC2E2DC79F3D177) {
  self.curclass = _id_0AC2E2DC79F3D177;
}

haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass))
    return 1;

  if(scripts\mp\utility\game::getgametype() == "infect" && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class))
    return 1;

  return 0;
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
  }

  return 0;
}

resetactionslots() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");

  if(!isagent(self) && !self isconsoleplayer()) {
    self setactionslot(5, "");
    self setactionslot(6, "");
    self setactionslot(7, "");
  }
}

resetfunctionality() {
  self enableequipdeployvfx(0);

  if(!isagent(self)) {
    self setclientomnvar("ui_hide_hud", 0);
    vehicle_allowplayeruse(self, 1);

    if(level.minimaponbydefault || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && istrue(game["inLiveLobby"]))
      self setclientomnvar("ui_hide_minimap", 0);
    else
      self setclientomnvar("ui_hide_minimap", 1);
  }

  _id_3B64EB40368C1450::_id_8B5F9E0014775208();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_clearallowmovementplayer(self, 1);
  self.doublejumpenergy = undefined;
  self.doublejumpenergyrestorerate = undefined;
  self.enabledcollisionnotifies = undefined;
  self.enabledequipdeployvfx = undefined;
  self.minimapstatetracker = undefined;
  self.isstunned = undefined;
  self.isblinded = undefined;
  self.nocorpse = undefined;
  self.prematchlook = undefined;
  self.ladderexecutionblocked = undefined;
  scripts\mp\damage::resetattackerlist();
  scripts\mp\damage::clearcorpsetablefuncs();
  riotshieldclearvars();
  scripts\cp_mp\utility\player_utility::cleardemeanorsafe();
  scripts\mp\weapons::_id_6B4A68DBDAE21499(1);
  scripts\mp\equipment\molotov::molotov_clear_fx();
  scripts\mp\equipment\flash_grenade::clearflash(1);
  scripts\mp\equipment\gas_grenade::gas_clear(1);

  if(!isagent(self)) {
    scripts\mp\utility\player::hidehudclear();
    _id_6D68CFDF0836123C::_id_A867654273504370();
  }

  scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
  scripts\mp\utility\player::_resetenableignoreme();
  scripts\cp_mp\utility\player_utility::_id_C28310E3B33872CB();
}

clearscriptable() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
}

changearchetype(archetype, super, trait) {
  if(isDefined(self.changedarchetypeinfo)) {
    _id_1DF3C8537EBF5ED5 = self.changedarchetypeinfo;

    if(_id_1DF3C8537EBF5ED5.archetype == archetype && _id_1DF3C8537EBF5ED5.super == super && _id_1DF3C8537EBF5ED5.trait == trait)
      return;
  }

  changedarchetypeinfo = spawnStruct();
  changedarchetypeinfo.archetype = archetype;
  changedarchetypeinfo.super = super;
  changedarchetypeinfo.trait = trait;
  self.changedarchetypeinfo = changedarchetypeinfo;
  self.pers["changedArchetypeInfo"] = changedarchetypeinfo;

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    preloadandqueueclass(self.pers["class"]);

    if(shouldallowinstantclassswap())
      thread swaploadout();
    else if(isalive(self))
      self iprintlnbold(game["strings"]["change_rig"]);
  }
}

getattachmentloadoutstring(_id_DF6D8E005B4B8020, slot) {
  base = scripts\engine\utility::ter_op(slot == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");

  if(_id_DF6D8E005B4B8020 == 0)
    return base;

  return base + (_id_DF6D8E005B4B8020 + 1);
}

getstickerloadoutstring(_id_36D2ABBDCBCB186C, slot) {
  base = scripts\engine\utility::ter_op(slot == "primary", "loadoutPrimarySticker", "loadoutSecondarySticker");

  if(_id_36D2ABBDCBCB186C == 0)
    return base;

  return base + (_id_36D2ABBDCBCB186C + 1);
}

getmaxprimaryattachments() {
  return 7;
}

getmaxsecondaryattachments() {
  return 7;
}

_id_ED8BABBE1912171F() {
  return 5;
}

_id_FBA1013E19EB56C3() {
  return 5;
}

getmaxattachments(weaponslot) {
  return scripts\engine\utility::ter_op(weaponslot == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments());
}

fillemptystreakslots(_id_66383C9FDF2D18C4, struct) {
  if(!level.allowkillstreaks) {
    return;
  }
  _id_3C96DB658445965E = [];
  _id_5FEB6ADFD05E27F1 = [];

  foreach(index, _id_153FDEE861E0F06F in _id_66383C9FDF2D18C4) {
    if(_id_153FDEE861E0F06F == "none") {
      _id_3C96DB658445965E[_id_3C96DB658445965E.size] = index;
      continue;
    }

    _id_5FEB6ADFD05E27F1[_id_5FEB6ADFD05E27F1.size] = _id_153FDEE861E0F06F;
  }

  if(_id_3C96DB658445965E.size > 0)
    self.pers["hackedStreaks"] = 1;

  foreach(slot in _id_3C96DB658445965E) {
    _id_9215D4AEE874A4DB = findfirststreakdifferentcost(_id_5FEB6ADFD05E27F1);

    if(slot + 1 == 1)
      struct.loadoutkillstreak1 = _id_9215D4AEE874A4DB;
    else if(slot + 1 == 2)
      struct.loadoutkillstreak2 = _id_9215D4AEE874A4DB;
    else
      struct.loadoutkillstreak3 = _id_9215D4AEE874A4DB;

    _id_5FEB6ADFD05E27F1[_id_5FEB6ADFD05E27F1.size] = _id_9215D4AEE874A4DB;
  }

  return [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
}

findfirststreakdifferentcost(_id_5FEB6ADFD05E27F1) {
  _id_7B0A8D49F719A44E = [];

  foreach(_id_2B7CF61AF0CB9960, _id_D442547D75DFFD09 in level._id_0B23156D776B1D85._id_038F2A11237246AC) {
    if(!istrue(_id_D442547D75DFFD09._id_594AF43597023062)) {
      continue;
    }
    _id_7A93DB468BFA64C4 = 0;

    foreach(_id_ACE49E98DEC89E03 in _id_5FEB6ADFD05E27F1) {
      if(_id_2B7CF61AF0CB9960 == _id_ACE49E98DEC89E03 || scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_2B7CF61AF0CB9960) == scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_ACE49E98DEC89E03)) {
        _id_7A93DB468BFA64C4 = 1;
        break;
      }
    }

    if(!istrue(_id_7A93DB468BFA64C4))
      _id_7B0A8D49F719A44E[_id_7B0A8D49F719A44E.size] = _id_2B7CF61AF0CB9960;
  }

  return _id_7B0A8D49F719A44E[0];
}

replacewithspecialistkillstreaks(struct) {
  return ["specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus"];
}

updateinstantclassswapallowed() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.instantclassswapallowed = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_CD83A28652A3F837 = scripts\mp\gamelogic::_id_8F54DEEC605690D1(scripts\mp\utility\game::getsubgametype());

    if(_id_CD83A28652A3F837) {
      scripts\mp\flags::gameflagwait("prematch_fade_done");
      updateinstantclassswapallowedinternal();
    }
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
    updateinstantclassswapallowedinternal();
  }

  disableclassswapallowed();
}

updateinstantclassswapallowedinternal() {
  self endon("death");
  graceperiod = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 15);

  if(scripts\mp\gamelogic::_id_8F54DEEC605690D1(scripts\mp\utility\game::getsubgametype())) {
    while(isDefined(self.c130))
      waitframe();

    self waittill("parachute_complete");
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_tune_up"))
    graceperiod = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 5);

  wait(graceperiod);
}

disableclassswapallowed() {
  if(isDefined(level._id_F55A78DE40F16B44) && istrue(level._id_F55A78DE40F16B44)) {
    return;
  }
  if(istrue(self.instantclassswapallowed)) {
    self.instantclassswapallowed = 0;

    if(scripts\mp\utility\game::isteamreviveenabled()) {
      self.revive_chosenclass = self.class;
      self.pers["next_round_class"] = self.class;
    }
  }
}

isvalidclass(class) {
  return isDefined(class) && class != "";
}

getclassindex(classname) {
  return level.classmap[classname];
}

preloadandqueueclass(class, _id_1DCE12D4EAF02799) {
  struct = loadout_getorbuildclassstruct(class);
  preloadandqueueclassstruct(struct, _id_1DCE12D4EAF02799);
  return struct;
}

preloadandqueueclassstruct(classstruct, _id_1DCE12D4EAF02799, _id_8C3977C9C8DC729B) {
  _id_1583B947947AD005 = scripts\mp\playerlogic::getplayerassets(classstruct);
  scripts\mp\playerlogic::loadplayerassets([_id_1583B947947AD005], _id_1DCE12D4EAF02799, _id_8C3977C9C8DC729B);
  self.preloadedclassstruct = classstruct;
}

loadout_getorbuildclassstruct(classname) {
  if(self.team == "spectator" && !isDefined(classname))
    classname = "custom1";

  _id_FD84DF04ADEAD383 = loadout_getclasstype(classname);
  _id_B96B2D290A5D5DBE = getcachedloadoutstruct(classname, _id_FD84DF04ADEAD383);

  if(isDefined(_id_B96B2D290A5D5DBE)) {
    if(!isDefined(_id_B96B2D290A5D5DBE.loadoutprimaryobject) && isDefined(_id_B96B2D290A5D5DBE.loadoutprimaryfullname))
      _id_B96B2D290A5D5DBE.loadoutprimaryobject = makeweaponfromstring(_id_B96B2D290A5D5DBE.loadoutprimaryfullname);

    if(!isDefined(_id_B96B2D290A5D5DBE.loadoutsecondaryobject) && isDefined(_id_B96B2D290A5D5DBE.loadoutsecondaryfullname))
      _id_B96B2D290A5D5DBE.loadoutsecondaryobject = makeweaponfromstring(_id_B96B2D290A5D5DBE.loadoutsecondaryfullname);
  }

  if(isDefined(_id_B96B2D290A5D5DBE)) {
    if(classname == "gamemode") {
      _id_92DB85C8DCF21152 = loadout_getclassstruct();
      _id_92DB85C8DCF21152 = loadout_updateclass(_id_92DB85C8DCF21152, classname);
      _id_94A93D61B8C3E782 = compareclassstructs(_id_92DB85C8DCF21152, _id_B96B2D290A5D5DBE);

      if(!_id_94A93D61B8C3E782) {
        _id_92DB85C8DCF21152.gamemodeforcednewloadout = 1;
        trytocacheclassstruct(_id_92DB85C8DCF21152, classname, _id_FD84DF04ADEAD383);
        return _id_92DB85C8DCF21152;
      }
    }

    return _id_B96B2D290A5D5DBE;
  }

  classstruct = loadout_getclassstruct();
  classstruct = loadout_updateclass(classstruct, classname);
  trytocacheclassstruct(classstruct, classname, _id_FD84DF04ADEAD383);
  return classstruct;
}

loadout_getglobalclassstruct() {
  if(!isDefined(self.pers["globalLoadoutStruct"]))
    loadout_updateglobalclassstruct();

  return self.pers["globalLoadoutStruct"];
}

loadout_updateglobalclassstruct() {
  struct = spawnStruct();
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";

  if(!isagent(self)) {
    if(!isDefined(self.loadoutfieldupgrade1) && getdvarint("dvar_A464CB031C16EE87", 0)) {
      if(getDvar("dvar_953B8C504C0DD6F2", "") == "zm_t10")
        struct.loadoutfieldupgrade1 = "super_aether_shroud";
      else
        struct.loadoutfieldupgrade1 = "super_trophy";
    }
  }

  self.pers["globalLoadoutStruct"] = struct;
}

loadout_editglobalclassstruct() {
  _id_24E17785934294E8 = loadout_getglobalclassstruct();
  loadout_updateglobalclassstruct();
  _id_B7C2FF3894E369A3 = loadout_getglobalclassstruct();

  if(_id_24E17785934294E8.loadoutfieldupgrade1 != _id_B7C2FF3894E369A3.loadoutfieldupgrade1)
    return 1;

  if(_id_24E17785934294E8.loadoutfieldupgrade2 != _id_B7C2FF3894E369A3.loadoutfieldupgrade2)
    return 1;

  return 0;
}

loadout_updateglobalclassgamemode(globalstruct, class) {
  _id_3800B8F9E799AE2C = self.pers["gamemodeLoadout"];

  if(isDefined(_id_3800B8F9E799AE2C)) {
    if(isDefined(_id_3800B8F9E799AE2C["loadoutFieldUpgrade1"]))
      globalstruct.loadoutfieldupgrade1 = _id_3800B8F9E799AE2C["loadoutFieldUpgrade1"];

    if(isDefined(_id_3800B8F9E799AE2C["loadoutFieldUpgrade2"]))
      globalstruct.loadoutfieldupgrade2 = _id_3800B8F9E799AE2C["loadoutFieldUpgrade2"];
  }
}

loadout_editcachedclassstruct(classname) {
  _id_FD84DF04ADEAD383 = loadout_getclasstype(classname);
  _id_B96B2D290A5D5DBE = getcachedloadoutstruct(classname, _id_FD84DF04ADEAD383);

  if(isDefined(_id_B96B2D290A5D5DBE)) {
    _id_92DB85C8DCF21152 = loadout_getclassstruct();
    _id_92DB85C8DCF21152 = loadout_updateclass(_id_92DB85C8DCF21152, classname);
    _id_94A93D61B8C3E782 = compareclassstructs(_id_92DB85C8DCF21152, _id_B96B2D290A5D5DBE);

    if(!_id_94A93D61B8C3E782) {
      _id_92DB85C8DCF21152.tweakedbyplayerduringmatch = 1;
      trytocacheclassstruct(_id_92DB85C8DCF21152, classname, _id_FD84DF04ADEAD383);
      return 1;
    }
  }

  return 0;
}

getcachedloadoutstruct(classname, _id_FD84DF04ADEAD383) {
  switch (_id_FD84DF04ADEAD383) {
    case "gamemode":
    case "custom":
    case "default":
      if(!isDefined(self.pers["classCache"])) {
        break;
      }

      return self.pers["classCache"][classname];
  }

  return undefined;
}

trytocacheclassstruct(classstruct, classname, _id_FD84DF04ADEAD383) {
  switch (_id_FD84DF04ADEAD383) {
    case "gamemode":
    case "custom":
    case "default":
      addclassstructtocache(classstruct, classname);
      break;
  }
}

addclassstructtocache(classstruct, classname) {
  if(!isDefined(self.pers["classCache"]))
    self.pers["classCache"][classname] = [];

  self.pers["classCache"][classname] = classstruct;
}

loadout_emptycacheofloadout(classname) {
  if(!isDefined(self.pers["classCache"])) {
    return;
  }
  self.pers["classCache"][classname] = undefined;
}

loadout_gamemodeloadoutchanged() {
  self.pers["classCache"]["gamemode"] = undefined;
}

copyclassfornextlife(_id_6EE5484560EC747C) {
  self setclientomnvar("ui_loadout_copied", gettime());
  thread _loadout_setcopyloadoutomvnaronspawn();
  loadout = undefined;

  if(isDefined(_id_6EE5484560EC747C.juggcontext) && isDefined(_id_6EE5484560EC747C.juggcontext.prevclassstruct))
    loadout = _id_6EE5484560EC747C.juggcontext.prevclassstruct;
  else
    loadout = _id_6EE5484560EC747C.classstruct;

  self.pers["copiedClass"] = loadout_copyclassstruct(loadout);
  self.pers["lastKiller"] = _id_6EE5484560EC747C;
}

_loadout_setcopyloadoutomvnaronspawn() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned");
  self setclientomnvar("ui_loadout_changed", 13);
}

loadout_fixcopiedclassstruct(_id_23665705A38D7D0C, classstruct) {
  _id_23665705A38D7D0C.loadoutsuper = classstruct.loadoutsuper;
  _id_23665705A38D7D0C.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
  _id_23665705A38D7D0C.loadoutstreaktype = classstruct.loadoutstreaktype;
  _id_23665705A38D7D0C.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
  _id_23665705A38D7D0C.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
  _id_23665705A38D7D0C.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
  _id_23665705A38D7D0C.loadoutaccessoryweapon = classstruct.loadoutaccessoryweapon;
  _id_23665705A38D7D0C.loadoutaccessorydata = classstruct.loadoutaccessorydata;
  _id_23665705A38D7D0C.loadoutaccessorylogic = classstruct.loadoutaccessorylogic;
  _id_23665705A38D7D0C.tweakedbyplayerduringmatch = 0;
  _id_23665705A38D7D0C.gamemodeforcednewloadout = 0;
  _id_23665705A38D7D0C.iscopiedclass = 1;
}

_id_BAE2A0B1DB21CAB9(weaponobj, skipfirstraise) {
  if(!isDefined(skipfirstraise))
    skipfirstraise = 0;

  if(scripts\cp_mp\utility\game_utility::shouldskipfirstraise() && istrue(self.hasspawned))
    skipfirstraise = 1;

  if(istrue(self.wassquadspawned))
    skipfirstraise = 1;

  return skipfirstraise;
}

respawnitems_saveplayeritemstostruct(_id_56E2F00432CCDF01, _id_B8750288D505BB24, _id_F8CE8528A93F0A9F, _id_6454C461F07B0789, _id_D517EF3586612FC7) {
  respawnitems = spawnStruct();

  if(!isDefined(_id_56E2F00432CCDF01) || _id_56E2F00432CCDF01)
    respawnitems_saveweapons(respawnitems);

  if(!isDefined(_id_B8750288D505BB24) || _id_B8750288D505BB24)
    respawnitems_saveequipmentitems(respawnitems);

  if(!isDefined(_id_F8CE8528A93F0A9F) || _id_F8CE8528A93F0A9F)
    respawnitems_savestreaks(respawnitems);

  if(!isDefined(_id_6454C461F07B0789) || _id_6454C461F07B0789)
    _id_1A5ECF82792E6BB8(respawnitems);

  if(!isDefined(_id_D517EF3586612FC7) || _id_D517EF3586612FC7)
    respawnitems_savesuper(respawnitems);

  return respawnitems;
}

respawnitems_assignrespawnitems(respawnitems) {
  self.respawnitems = respawnitems;
}

respawnitems_hasrespawnitems() {
  return isDefined(self.respawnitems);
}

respawnitems_getrespawnitems() {
  if(isDefined(self.respawnitems))
    return self.respawnitems;

  return undefined;
}

respawnitems_clear() {
  self.respawnitems = undefined;
}

respawnitems_saveweapons(respawnitems) {
  _id_7682D2D8788DB683 = [];
  _id_5BC770E98FE2F25E = self.primaryweapons;
  _id_B27047C65737F75B = self.currentweapon;

  foreach(weapon in _id_5BC770E98FE2F25E) {
    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(weapon))
      _id_7682D2D8788DB683[_id_7682D2D8788DB683.size] = weapon;
  }

  primaryweaponobj = undefined;

  if(isDefined(self.lastcacweaponobj))
    primaryweaponobj = self.lastcacweaponobj;
  else if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(self.currentweapon))
    primaryweaponobj = self.currentweapon;
  else if(_id_7682D2D8788DB683.size > 0)
    primaryweaponobj = _id_7682D2D8788DB683[0];

  if(isundefinedweapon(primaryweaponobj))
    primaryweaponobj = makeweapon("iw9_me_fists_mp");

  respawnitems_saveweapon(primaryweaponobj, "primary", respawnitems);
  secondaryweaponobj = undefined;

  foreach(weapon in _id_7682D2D8788DB683) {
    if(!issameweapon(weapon, primaryweaponobj, 1)) {
      secondaryweaponobj = weapon;
      break;
    }
  }

  if(isDefined(secondaryweaponobj))
    respawnitems_saveweapon(secondaryweaponobj, "secondary", respawnitems);
}

respawnitems_saveweapon(weaponobj, weaponslot, respawnitems) {
  if(!isDefined(respawnitems.weapons))
    respawnitems.weapons = [];

  weaponinfo = spawnStruct();
  respawnitems.weapons[weaponslot] = weaponinfo;
  weaponinfo.weaponobj = weaponobj;
  weaponinfo.clipammo = self getweaponammoclip(weaponobj);
  weaponinfo.stockammo = self getweaponammostock(weaponobj);

  if(weaponobj.hasalternate) {
    _id_6890A4CE965BBA99 = weaponobj getaltweapon();
    weaponinfo.altclipammo = self getweaponammoclip(_id_6890A4CE965BBA99);
    weaponinfo.altstockammo = self getweaponammostock(_id_6890A4CE965BBA99);
  }
}

respawnitems_saveequipmentitems(respawnitems) {
  respawnitems_saveequipment("primary", respawnitems);
  respawnitems_saveequipment("secondary", respawnitems);
}

respawnitems_saveequipment(slot, respawnitems) {
  _id_CB325DDB4A764623 = scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(_id_CB325DDB4A764623))
    _id_CB325DDB4A764623 = "none";

  if(!isDefined(respawnitems.equipment))
    respawnitems.equipment = [];

  _id_9B83EFBA8BFECC3F = spawnStruct();
  respawnitems.equipment[slot] = _id_9B83EFBA8BFECC3F;
  _id_9B83EFBA8BFECC3F.item = _id_CB325DDB4A764623;

  if(_id_CB325DDB4A764623 != "none")
    _id_9B83EFBA8BFECC3F.ammo = scripts\mp\equipment::getequipmentammo(_id_9B83EFBA8BFECC3F.item);
  else
    _id_9B83EFBA8BFECC3F.ammo = 0;
}

respawnitems_savestreaks(respawnitems) {
  streakstate = spawnStruct();
  streakstate.streaks = [];
  streakstate.streakpoints = self.streakpoints;

  if(!isDefined(self.streakpoints)) {
    return;
  }
  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(streakinfo))
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;

  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(2);

  if(isDefined(streakinfo))
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;

  streakinfo = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(3);

  if(isDefined(streakinfo))
    streakstate.streaks[streakstate.streaks.size] = streakinfo.streakname;

  if(streakstate.streaks.size <= 0) {
    return;
  }
  respawnitems.streakstate = streakstate;
}

_id_1A5ECF82792E6BB8(respawnitems) {
  _id_239FB3AF0CF6EEB2 = spawnStruct();
  respawnitems._id_239FB3AF0CF6EEB2 = _id_239FB3AF0CF6EEB2;
  _id_239FB3AF0CF6EEB2.loadoutperks = self.loadoutperks;
  _id_239FB3AF0CF6EEB2._id_15F3E6DF722FB1CF = self._id_15F3E6DF722FB1CF;
  _id_239FB3AF0CF6EEB2._id_15F3E5DF722FAF9C = self._id_15F3E5DF722FAF9C;
  _id_239FB3AF0CF6EEB2.loadoutstandardperks = self.pers["loadoutStandardPerks"];
  _id_239FB3AF0CF6EEB2.loadoutextraperks = self.pers["loadoutExtraPerks"];
  _id_239FB3AF0CF6EEB2.loadoutrigtrait = self.pers["loadoutRigTrait"];
  _id_239FB3AF0CF6EEB2.loadoutusingspecialist = self.pers["loadoutUsingSpecialist"];
  _id_239FB3AF0CF6EEB2._id_CA485F8EC3DE1D80 = self.pers["perkPackageProgress"];
  _id_239FB3AF0CF6EEB2._id_CFDC3CD745250748 = self.pers["perkPackageTier2Earned"];
  _id_239FB3AF0CF6EEB2._id_BACE4E767AF4F379 = self.pers["perkPackageTier3State"];
}

respawnitems_savesuper(respawnitems) {
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();

  if(!isDefined(_id_EBEC497FF8B18A45)) {
    return;
  }
  superstate = spawnStruct();
  respawnitems.superstate = superstate;
  superstate.super = _id_EBEC497FF8B18A45;
  superstate.superpoints = scripts\mp\supers::getcurrentsuperbasepoints();
  superstate.extrapoints = scripts\mp\supers::getcurrentsuperextrapoints();

  if(_id_EBEC497FF8B18A45 == "super_select") {
    _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuper();
    superstate.firstupgrade = _id_D3C112E63BF53EE5.firstupgrade;
    superstate.secondupgrade = _id_D3C112E63BF53EE5.secondupgrade;
  }
}

respawnitems_hasweapondata(respawnitems) {
  if(!isDefined(respawnitems))
    return 0;

  return isDefined(respawnitems.weapons);
}

respawnitems_getweaponobj(respawnitems, weaponslot) {
  return respawnitems.weapons[weaponslot].weaponobj;
}

respawnitems_giveweaponammo(respawnitems, weaponslot) {
  weaponinfo = respawnitems.weapons[weaponslot];

  if(!isDefined(weaponinfo)) {
    return;
  }
  self setweaponammoclip(weaponinfo.weaponobj, weaponinfo.clipammo);
  self setweaponammostock(weaponinfo.weaponobj, weaponinfo.stockammo);

  if(weaponinfo.weaponobj.hasalternate) {
    _id_6890A4CE965BBA99 = weaponinfo.weaponobj getaltweapon();
    self setweaponammoclip(_id_6890A4CE965BBA99, weaponinfo.altclipammo);
    self setweaponammostock(_id_6890A4CE965BBA99, weaponinfo.altstockammo);
  }
}

respawnitems_hasequipmentdata(respawnitems) {
  if(!isDefined(respawnitems))
    return 0;

  return isDefined(respawnitems.equipment);
}

respawnitems_getequipmentref(respawnitems, slot) {
  return respawnitems.equipment[slot].item;
}

respawnitems_giveequipmentammo(respawnitems, slot) {
  item = respawnitems_getequipmentref(respawnitems, slot);

  if(!isDefined(item) || item == "none") {
    return;
  }
  ammo = respawnitems.equipment[slot].ammo;

  if(!isDefined(ammo)) {
    return;
  }
  scripts\mp\equipment::setequipmentammo(item, ammo);
}

respawnitems_hasstreakdata(respawnitems) {
  if(!isDefined(respawnitems))
    return 0;

  return isDefined(respawnitems.streakstate);
}

respawnitems_getstreakpoints(respawnitems) {
  return respawnitems.streakstate.streakpoints;
}

respawnitems_getstreaks(respawnitems) {
  return respawnitems.streakstate.streaks;
}

_id_B19856925DDABD5A(respawnitems) {
  if(!isDefined(respawnitems))
    return 0;

  return isDefined(respawnitems._id_239FB3AF0CF6EEB2);
}

_id_40A3148D5514FFA3(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2.loadoutperks;
}

_id_DC2F8C385699A6E8(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2._id_15F3E6DF722FB1CF;
}

_id_DC2F8D385699A91B(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2._id_15F3E5DF722FAF9C;
}

_id_64D9F4542FDD7B14(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2.loadoutstandardperks;
}

_id_DC35CB143C497599(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2.loadoutextraperks;
}

_id_7F47875B5FD88F24(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2.loadoutrigtrait;
}

_id_EBA2981FA45AE3BF(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2.loadoutusingspecialist;
}

_id_33E44385E17EECC1(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2._id_CA485F8EC3DE1D80;
}

_id_7AF26FC564E26A5F(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2._id_CFDC3CD745250748;
}

_id_7D2BA1E36AFE24B0(respawnitems) {
  return respawnitems._id_239FB3AF0CF6EEB2._id_BACE4E767AF4F379;
}

respawnitems_hassuperdata(respawnitems) {
  if(!isDefined(respawnitems))
    return 0;

  return isDefined(respawnitems.superstate);
}

respawnitems_getsuperref(respawnitems) {
  return respawnitems.superstate.super;
}

respawnitems_getsuperpoints(respawnitems) {
  return respawnitems.superstate.superpoints;
}

respawnitems_getsuperextrapoints(respawnitems) {
  return respawnitems.superstate.extrapoints;
}

_id_2F17741F5C15A7D6(respawnitems) {
  if(respawnitems_getsuperref(respawnitems) == "super_select")
    return [respawnitems.superstate.firstupgrade, respawnitems.superstate.secondupgrade];

  return [respawnitems_getsuperref(respawnitems), "none"];
}

spawnammocountoverride_giveweaponammo(weaponobj, weaponslot, _id_10B09490BB78E90E) {
  weaponinfo = weaponobj;
  _id_640C8B74FC979400 = !_id_10B09490BB78E90E;

  if(_id_640C8B74FC979400 && !_id_55EF6C1F428AC567(weaponobj)) {
    clipsize = 0;
    _id_96F765C1BFEC9E65 = 0;

    if(weaponobj._id_318338AA880DFAC6)
      self setweaponammoclip(weaponinfo, clipsize, "left");
  } else {
    clipsize = weaponinfo.clipsize;
    _id_96F765C1BFEC9E65 = _id_10B09490BB78E90E - 1;
  }

  if(_id_10B09490BB78E90E == 7)
    _id_96F765C1BFEC9E65 = weaponmaxammo(weaponinfo);
  else if(issubstr(weaponinfo.basename, "iw8_sh_charlie725") && !_id_640C8B74FC979400)
    _id_96F765C1BFEC9E65 = weaponinfo.clipsize * _id_96F765C1BFEC9E65 + 18;
  else
    _id_96F765C1BFEC9E65 = weaponinfo.clipsize * _id_96F765C1BFEC9E65;

  self setweaponammoclip(weaponinfo, clipsize);
  self setweaponammostock(weaponinfo, _id_96F765C1BFEC9E65);

  if(weaponobj.hasalternate) {
    _id_6890A4CE965BBA99 = weaponobj getaltweapon();

    if(_id_640C8B74FC979400) {
      altclipammo = 0;
      altstockammo = 0;
    } else {
      altclipammo = self getweaponammoclip(_id_6890A4CE965BBA99);
      altstockammo = self getweaponammostock(_id_6890A4CE965BBA99);
    }

    self setweaponammoclip(_id_6890A4CE965BBA99, altclipammo);
    self setweaponammostock(_id_6890A4CE965BBA99, altstockammo);
  }
}

_id_55EF6C1F428AC567(objweapon) {
  _id_55EF6C1F428AC567 = scripts\cp_mp\utility\weapon_utility::isknifeonly(objweapon.basename) || scripts\mp\utility\weapon::isakimbomeleeweapon(objweapon.basename) || scripts\mp\utility\weapon::isaxeweapon(objweapon.basename) || scripts\mp\utility\weapon::ismeleeoverrideweapon(objweapon) || scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename);
  return _id_55EF6C1F428AC567;
}

compareclassstructs(_id_FD10CBC8E506F14E, _id_FD10CAC8E506EF1B) {
  if(_id_FD10CBC8E506F14E.loadoutarchetype != _id_FD10CAC8E506EF1B.loadoutarchetype)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimary != _id_FD10CAC8E506EF1B.loadoutprimary)
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutprimaryattachments, _id_FD10CAC8E506EF1B.loadoutprimaryattachments))
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutprimaryattachmentids, _id_FD10CAC8E506EF1B.loadoutprimaryattachmentids))
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimarycamo != _id_FD10CAC8E506EF1B.loadoutprimarycamo)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimaryreticle != _id_FD10CAC8E506EF1B.loadoutprimaryreticle)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimarylootitemid != _id_FD10CAC8E506EF1B.loadoutprimarylootitemid)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimaryvariantid != _id_FD10CAC8E506EF1B.loadoutprimaryvariantid)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutprimarycosmeticattachment != _id_FD10CAC8E506EF1B.loadoutprimarycosmeticattachment)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondary != _id_FD10CAC8E506EF1B.loadoutsecondary)
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutsecondaryattachments, _id_FD10CAC8E506EF1B.loadoutsecondaryattachments))
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutsecondaryattachmentids, _id_FD10CAC8E506EF1B.loadoutsecondaryattachmentids))
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondarycamo != _id_FD10CAC8E506EF1B.loadoutsecondarycamo)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondaryreticle != _id_FD10CAC8E506EF1B.loadoutsecondaryreticle)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondarylootitemid != _id_FD10CAC8E506EF1B.loadoutsecondarylootitemid)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondaryvariantid != _id_FD10CAC8E506EF1B.loadoutsecondaryvariantid)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutsecondarycosmeticattachment != _id_FD10CAC8E506EF1B.loadoutsecondarycosmeticattachment)
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutperks, _id_FD10CAC8E506EF1B.loadoutperks))
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutstandardperks, _id_FD10CAC8E506EF1B.loadoutstandardperks))
    return 0;

  if(!checkclassstructarray(_id_FD10CBC8E506F14E.loadoutextraperks, _id_FD10CAC8E506EF1B.loadoutextraperks))
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutusingspecialist != _id_FD10CAC8E506EF1B.loadoutusingspecialist)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutmeleeslot != _id_FD10CAC8E506EF1B.loadoutmeleeslot)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutperksfromgamemode != _id_FD10CAC8E506EF1B.loadoutperksfromgamemode)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutrigtrait != _id_FD10CAC8E506EF1B.loadoutrigtrait)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutequipmentprimary != _id_FD10CAC8E506EF1B.loadoutequipmentprimary)
    return 0;

  if(_id_FD10CBC8E506F14E._id_B68E3A0A9C628D23 != _id_FD10CAC8E506EF1B._id_B68E3A0A9C628D23)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutextraequipmentprimary != _id_FD10CAC8E506EF1B.loadoutextraequipmentprimary)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutequipmentsecondary != _id_FD10CAC8E506EF1B.loadoutequipmentsecondary)
    return 0;

  if(_id_FD10CBC8E506F14E._id_0A1DFC5CE15795A3 != _id_FD10CAC8E506EF1B._id_0A1DFC5CE15795A3)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutextraequipmentsecondary != _id_FD10CAC8E506EF1B.loadoutextraequipmentsecondary)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutfieldupgrade1 != _id_FD10CAC8E506EF1B.loadoutfieldupgrade1)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutfieldupgrade2 != _id_FD10CAC8E506EF1B.loadoutfieldupgrade2)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutgesture != _id_FD10CAC8E506EF1B.loadoutgesture)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutstreaksfilled != _id_FD10CAC8E506EF1B.loadoutstreaksfilled)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutstreaktype != _id_FD10CAC8E506EF1B.loadoutstreaktype)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutkillstreak1 != _id_FD10CAC8E506EF1B.loadoutkillstreak1)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutkillstreak2 != _id_FD10CAC8E506EF1B.loadoutkillstreak2)
    return 0;

  if(_id_FD10CBC8E506F14E.loadoutkillstreak3 != _id_FD10CAC8E506EF1B.loadoutkillstreak3)
    return 0;

  return 1;
}

checkclassstructarray(_id_4F6FC34F222A98E1, _id_4F6FC04F222A9248) {
  if(_id_4F6FC34F222A98E1.size != _id_4F6FC04F222A9248.size)
    return 0;

  foreach(key, value in _id_4F6FC34F222A98E1) {
    if(!isDefined(_id_4F6FC04F222A9248[key]))
      return 0;

    if(_id_4F6FC04F222A9248[key] != value)
      return 0;
  }

  return 1;
}

blockclasschange() {
  scripts\engine\utility::ent_flag_init("swapLoadout_blocked");
  scripts\engine\utility::ent_flag_init("swapLoadout_pending");
  scripts\engine\utility::ent_flag_init("swapLoadout_complete");
  scripts\engine\utility::ent_flag_set("swapLoadout_blocked");
}

unblockclasschange() {
  self endon("death_or_disconnect");

  if(scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && scripts\engine\utility::ent_flag("swapLoadout_blocked"))
    scripts\engine\utility::ent_flag_clear("swapLoadout_blocked");
}

_id_C5CE8711741E44B8() {
  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
    self setcamerathirdperson(0);
    thread _id_9FF15282A5A9FCB3();
  } else if(istrue(self._id_9E3BDDA27A519A9F))
    self setcamerathirdperson(1);
  else if(istrue(self._id_C4C8B91E0B16AA5E))
    self setcamerathirdperson(1);
  else {
    switch (level._id_DC65C33DFDD9EFE8) {
      case 1:
        self setcamerathirdperson(1);
        break;
      case 2:
        self setcamerathirdperson(self.team == "allies");
        break;
      case 3:
        self setcamerathirdperson(self.team == "axis");
        break;
      default:
        self setcamerathirdperson(0);
        break;
    }
  }
}

_id_9FF15282A5A9FCB3() {
  self endon("death_or_disconnect");
  self notify("restoreGameplayThirdPerson");
  self endon("restoreGameplayThirdPerson");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_C5CE8711741E44B8();
}

alwaysgamemodeclass() {
  return "gamemode";
}

_id_A16868D4DCD81A4B() {
  self setclientomnvar("ui_skip_loadout", 1);
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];

  if(isbot(self))
    self.classcallback = "gamemode";
}