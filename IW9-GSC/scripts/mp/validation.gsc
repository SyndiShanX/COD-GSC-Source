/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\validation.gsc
***********************************************/

validationerror(_id_3B3FC6A41B9C37DD, slot, item) {
  _id_B00CC25137FA2908 = _id_3B3FC6A41B9C37DD;

  if(isDefined(slot))
    _id_B00CC25137FA2908 = _id_B00CC25137FA2908 + "_" + slot;

  if(isDefined(item))
    _id_B00CC25137FA2908 = _id_B00CC25137FA2908 + " - " + item;

  if(getdvarint("scr_validate_print", 0) == 1) {}

  if(getdvarint("scr_validate_assert", 0) == 1) {}

  if(getdvarint("scr_validate_record", 0) == 1)
    scripts\mp\class::recordvalidationinfraction();
}

isvalidattachmentunlock(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA) {
  _id_338C04A2F19BA8B6 = getdvarint("dvar_464624F0183DE3D0", 0) == 1;

  if(_id_338C04A2F19BA8B6)
    return scripts\mp\utility\weapon::attachmentisselectablerootname(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA);

  return 1;
}

_id_F6D25A34B1D286B1() {
  _id_CFBD5DFAB1E96CB1 = getdvarint("dvar_838359D5EBDCC7E0", 0);

  if(_id_CFBD5DFAB1E96CB1 == 0) {
    return;
  }
  for(loadoutindex = 0; loadoutindex < 12; loadoutindex++) {
    _id_05D204F0BEFA309B = self getplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", loadoutindex, "inUse");

    if(_id_05D204F0BEFA309B == 1) {
      for(_id_FE4048AD22C35D73 = 0; _id_FE4048AD22C35D73 < 2; _id_FE4048AD22C35D73++) {
        weaponname = scripts\mp\class::cac_getweapon(loadoutindex, _id_FE4048AD22C35D73);
        _id_FEDB77AAD2340743 = scripts\mp\class::cac_getweaponvariantid(loadoutindex, _id_FE4048AD22C35D73);
        _id_2F36F150E9C51CB5 = scripts\mp\class::cac_getweaponlootitemid(loadoutindex, _id_FE4048AD22C35D73);
        attachments = [];
        _id_3770967D73999EB9 = [];
        _id_BA38574234720011 = scripts\engine\utility::ter_op(_id_FE4048AD22C35D73 == 0, scripts\mp\class::getmaxprimaryattachments(), scripts\mp\class::getmaxsecondaryattachments());
        _id_6C85232FCAB7882D = scripts\engine\utility::ter_op(_id_FE4048AD22C35D73 == 0, scripts\mp\class::_id_ED8BABBE1912171F(), scripts\mp\class::_id_FBA1013E19EB56C3());

        for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < _id_BA38574234720011; _id_DF6D8E005B4B8020++) {
          _id_659F734FC2A248FF = scripts\mp\class::cac_getweaponattachment(loadoutindex, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020);
          attachments[_id_DF6D8E005B4B8020] = _id_659F734FC2A248FF;
          _id_3770967D73999EB9[_id_DF6D8E005B4B8020] = scripts\mp\class::cac_getweaponattachmentid(loadoutindex, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020);
        }

        camoname = scripts\mp\class::cac_getweaponcamo(loadoutindex, _id_FE4048AD22C35D73);
        _id_BD1DB6DD9710A427 = scripts\mp\class::cac_getweaponcosmeticattachment(loadoutindex, _id_FE4048AD22C35D73);
        stickers = [];

        for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < _id_6C85232FCAB7882D; _id_36D2ABBDCBCB186C++)
          stickers[_id_36D2ABBDCBCB186C] = scripts\mp\class::cac_getweaponsticker(loadoutindex, _id_FE4048AD22C35D73, _id_36D2ABBDCBCB186C);

        _id_503F87754BE2D15C(weaponname, _id_FEDB77AAD2340743, _id_2F36F150E9C51CB5, attachments, _id_3770967D73999EB9, camoname, _id_BD1DB6DD9710A427, stickers);
      }
    }
  }
}

_id_18B8C4C4FA0F6D1C(weaponname, _id_91F46FFD5296EEE1) {
  category = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", _id_91F46FFD5296EEE1), "stat_1A86D464182EDEB5");

  if(isDefined(category) && category == "camo_category_completion") {
    if(isDefined(level._id_305637ED4E3E8513[weaponname]) && isDefined(level._id_305637ED4E3E8513[weaponname][_id_91F46FFD5296EEE1]))
      return level._id_305637ED4E3E8513[weaponname][_id_91F46FFD5296EEE1];
    else {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_91F46FFD5296EEE1);

      if(lootid == 0)
        scripts\mp\utility\script::demoforcesre("getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + _id_91F46FFD5296EEE1 + "] not in level.weaponMappedCamos");

      return lootid;
    }
  } else if(isDefined(category) && category == "camo_category_events") {
    weaponclass = "";
    _id_255E0DF33FAE6D5A = _id_2669878CF5A1B6BC::_id_8477D8595E0364A7(weaponname, ["stat_556143152458180A"]);

    if(isDefined(_id_255E0DF33FAE6D5A))
      weaponclass = _id_255E0DF33FAE6D5A.menuclass;

    if(weaponclass != "" && isDefined(level._id_305637ED4E3E8513[weaponclass]) && isDefined(level._id_305637ED4E3E8513[weaponclass][_id_91F46FFD5296EEE1])) {
      return level._id_305637ED4E3E8513[weaponclass][_id_91F46FFD5296EEE1];
      return;
    }

    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_91F46FFD5296EEE1);

    if(lootid == 0)
      scripts\mp\utility\script::demoforcesre("getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + _id_91F46FFD5296EEE1 + "] not in level.weaponMappedCamos");

    return lootid;
    return;
  } else
    return _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_91F46FFD5296EEE1);
}

_id_2C4D04305E3C9601(_id_904C82687DDFEB02) {
  if(getdvarint("dvar_272C95C93DA464BB", 0) == 0)
    return 0;

  _id_E7A7288F46DEE8E7 = [11354, 11344, 11338, 11352, 11318, 11337, 11340, 11323, 11331, 11307, 11317, 11324, 11328, 11351, 11357, 11355, 11315, 11367, 11320, 11353];
  _id_4B40391F47F1D3EA = [11354, 11356, 11374, 11344, 11317, 11352];

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    foreach(_id_8C996F399D5E3282 in _id_E7A7288F46DEE8E7) {
      if(_id_8C996F399D5E3282 == _id_904C82687DDFEB02)
        return 1;
    }
  } else if(scripts\common\utility::ismp() || scripts\common\utility::iscp()) {
    foreach(_id_8C996F399D5E3282 in _id_4B40391F47F1D3EA) {
      if(_id_8C996F399D5E3282 == _id_904C82687DDFEB02)
        return 1;
    }
  }

  return 0;
}

_id_503F87754BE2D15C(weaponname, _id_FEDB77AAD2340743, _id_2F36F150E9C51CB5, attachments, _id_3770967D73999EB9, camoname, _id_BD1DB6DD9710A427, stickers) {
  _id_4A654BD9A395C1FF = [];
  _id_A4146E4EAF636EF2 = getdvarint("dvar_C876F19DD06EB2CF", 0);
  _id_989C8EAFE834F9DE = _id_FEDB77AAD2340743 != 0;
  _id_928C1CAC31EA99E5 = weaponname + "|" + _id_FEDB77AAD2340743;
  _id_FE506348D9341132 = 0;

  if(_id_2F36F150E9C51CB5 != 0)
    _id_FE506348D9341132 = _id_2F36F150E9C51CB5;
  else if(isDefined(level.weaponmapdata[weaponname]))
    _id_FE506348D9341132 = level.weaponmapdata[weaponname]._id_904C82687DDFEB02;

  if(!_id_2C4D04305E3C9601(_id_FE506348D9341132))
    _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_FE506348D9341132;

  weaponclass = "";
  _id_255E0DF33FAE6D5A = _id_2669878CF5A1B6BC::_id_8477D8595E0364A7(weaponname, ["stat_556143152458180A"]);

  if(isDefined(_id_255E0DF33FAE6D5A))
    weaponclass = _id_255E0DF33FAE6D5A.menuclass;

  if(isDefined(weaponclass) && weaponclass != "weapon_melee" && weaponclass != "weapon_melee2") {
    _id_AD61FFB38EC2A6B0 = _func_6527364C1ECCA6C6(scripts\mp\utility\weapon::getdefaultweaponbasename(weaponname));

    foreach(_id_DF6D8E005B4B8020, _id_659F734FC2A248FF in attachments) {
      if(_id_659F734FC2A248FF != "none") {
        _id_763D626A0644C430 = 1;

        if(_id_A4146E4EAF636EF2 == 1 && _id_2669878CF5A1B6BC::_id_975E31B63F01FBCC(_id_659F734FC2A248FF)) {
          continue;
        }
        if(_id_3770967D73999EB9[_id_DF6D8E005B4B8020] != 0) {
          _id_5C3F9357F11D2223 = scripts\mp\utility\weapon::getdefaultweaponbasename(weaponname);
          _id_50A998E9DC6E96DD = _func_55DB7A4374ED4B1B(_id_5C3F9357F11D2223, _id_659F734FC2A248FF);

          foreach(_id_946152E4CD7CD90F, _id_ABF526089D208196 in _id_50A998E9DC6E96DD) {
            if(_id_ABF526089D208196 == _id_3770967D73999EB9[_id_DF6D8E005B4B8020] && isDefined(level._id_8DD253609D606F1C[_id_946152E4CD7CD90F])) {
              _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = level._id_8DD253609D606F1C[_id_946152E4CD7CD90F];

              if(_id_989C8EAFE834F9DE && isDefined(level.weaponlootmapdata) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap[_id_659F734FC2A248FF]) && level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap[_id_659F734FC2A248FF] == _id_ABF526089D208196)
                _id_763D626A0644C430 = 0;

              break;
            }
          }
        }

        if(_id_763D626A0644C430) {
          _id_2C4FC9C24CCFDF3C = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_3C2C9813BB16552F", _id_659F734FC2A248FF), "stat_5BD2E7FFB1224E91");

          if(_id_2C4FC9C24CCFDF3C == "RECEIVER") {
            continue;
          }
          _id_1C34CB85A2BC9BAF = 0;

          foreach(_id_C7B8980D348EB4DC in _id_AD61FFB38EC2A6B0) {
            if(_id_C7B8980D348EB4DC == _id_659F734FC2A248FF) {
              _id_1C34CB85A2BC9BAF = 1;
              break;
            }
          }

          if(_id_1C34CB85A2BC9BAF) {
            continue;
          }
          _id_3B3077EE39BDCD6F = _func_40FD49171FAD19D3(_id_659F734FC2A248FF);

          if(isDefined(level._id_8DD253609D606F1C[_id_3B3077EE39BDCD6F]))
            _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = level._id_8DD253609D606F1C[_id_3B3077EE39BDCD6F];
        }
      }
    }
  }

  _id_FEFAD7765EF87400 = _id_18B8C4C4FA0F6D1C(weaponname, camoname);
  _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_FEFAD7765EF87400;
  _id_8B245507630A7BA1 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_BD1DB6DD9710A427);
  _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_8B245507630A7BA1;

  foreach(_id_514B604B42B22810 in stickers) {
    if(_id_514B604B42B22810 != "none") {
      _id_C3C5D884C6B46717 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_514B604B42B22810);
      _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_C3C5D884C6B46717;
    }
  }

  self _meth_616C0CA219597829(_id_4A654BD9A395C1FF);
}

_id_5A92673DB4ECE37F(classstruct) {
  _id_CFBD5DFAB1E96CB1 = getdvarint("dvar_838359D5EBDCC7E0", 0);

  if(_id_CFBD5DFAB1E96CB1 == 0) {
    return;
  }
  if(scripts\common\utility::iscp() || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level._id_EC2FB549B15AD827 || !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled) {
    return;
  }
  _id_503F87754BE2D15C(classstruct.loadoutprimary, classstruct.loadoutprimaryvariantid, classstruct.loadoutprimarylootitemid, classstruct.loadoutprimaryattachments, classstruct.loadoutprimaryattachmentids, classstruct.loadoutprimarycamo, classstruct.loadoutprimarycosmeticattachment, classstruct.loadoutprimarystickers);
  _id_503F87754BE2D15C(classstruct.loadoutsecondary, classstruct.loadoutsecondaryvariantid, classstruct.loadoutsecondarylootitemid, classstruct.loadoutsecondaryattachments, classstruct.loadoutsecondaryattachmentids, classstruct.loadoutsecondarycamo, classstruct.loadoutsecondarycosmeticattachment, classstruct.loadoutsecondarystickers);
}

validateloadout(loadout) {
  if(getdvarint("unlockAllItems", 0) == 1)
    return loadout;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && getdvarint("dvar_65F0EA4FF58C3FA0", 0) == 1)
    return loadout;

  _id_6433B6E8ECDE2AE9 = _id_9480A79A4852090F();
  _id_5A92673DB4ECE37F(loadout);
  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;

  _id_D70EBC5CE61F7EBE = "specialty_underkill";
  _id_6940A6D9400F329B = !perkisrestricted(_id_D70EBC5CE61F7EBE) && scripts\engine\utility::array_contains(loadout.loadoutperks, _id_D70EBC5CE61F7EBE);

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(loadout.loadoutprimary) && !_id_6940A6D9400F329B)
    _id_35CCABD9AD4E542F = 1;

  _id_BC72F32B1575D517 = 0;
  _id_E1388376A5BE9B75 = 0;
  _id_429A6B39B9959FDB = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(loadout.loadoutprimary, "stat_556143152458180A");

  if(weaponisrestricted(loadout.loadoutprimary) || isDefined(_id_429A6B39B9959FDB) && _func_DC0D4632189B623A(_id_429A6B39B9959FDB)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutprimary = _id_6433B6E8ECDE2AE9._id_5E6961853F911ABF;
    loadout.loadoutprimaryattachments = _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB;
    loadout.loadoutprimarycamo = _id_6433B6E8ECDE2AE9._id_606482762A976E6B;
    loadout.loadoutprimaryreticle = _id_6433B6E8ECDE2AE9._id_9E9BF32419E3FB65;
    loadout.loadoutprimaryvariantid = _id_6433B6E8ECDE2AE9._id_A2746A3326FFD02D;
    loadout.loadoutprimaryattachmentids = _id_6433B6E8ECDE2AE9._id_DBD72EBF429C33CC;
    loadout.loadoutprimarycosmeticattachment = _id_6433B6E8ECDE2AE9._id_AB71722736D6300D;
    loadout.loadoutprimarystickers[0] = _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[0];
    loadout.loadoutprimarystickers[1] = _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[1];
    loadout.loadoutprimarystickers[2] = _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[2];
    loadout.loadoutprimarystickers[3] = _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[3];
    loadout.loadoutprimarystickers[4] = _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[4];
  } else {
    if(isweaponvariantlocked(loadout.loadoutprimary, loadout.loadoutprimaryvariantid))
      loadout.loadoutprimaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutprimaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8];

      if(attachment != "none" && attachmentisrestricted(attachment, loadout.loadoutprimary)) {
        loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;

  _id_E825245F4893A9A0 = "specialty_munitions_2";
  _id_FB9B83072ABF0EC9 = getdvarint("dvar_A0ADE898BFC7AB0E", 0) && scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
  _id_DF3D6A2FFC2E83C1 = !perkisrestricted(_id_E825245F4893A9A0) && scripts\engine\utility::array_contains(loadout.loadoutperks, _id_E825245F4893A9A0);

  if(scripts\mp\utility\weapon::iscacprimaryweapon(loadout.loadoutsecondary) && !_id_FB9B83072ABF0EC9 && !_id_DF3D6A2FFC2E83C1)
    _id_35CCABD9AD4E542F = 1;

  _id_24DF3F0898E5E31B = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(loadout.loadoutsecondary, "stat_556143152458180A");

  if(weaponisrestricted(loadout.loadoutsecondary) || isDefined(_id_24DF3F0898E5E31B) && _func_DC0D4632189B623A(_id_24DF3F0898E5E31B)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutsecondary = _id_6433B6E8ECDE2AE9._id_FBC41EF364D09CDB;
    loadout.loadoutsecondaryattachments = _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F;
    loadout.loadoutsecondarycamo = _id_6433B6E8ECDE2AE9._id_FE85AC60E4C42827;
    loadout.loadoutsecondaryreticle = _id_6433B6E8ECDE2AE9._id_5EF582D35FC85969;
    loadout.loadoutsecondaryvariantid = _id_6433B6E8ECDE2AE9._id_5CCACFECEB8F0B91;
    loadout.loadoutsecondaryattachmentids = _id_6433B6E8ECDE2AE9._id_541023C8262AD6A8;
    loadout.loadoutsecondarycosmeticattachment = _id_6433B6E8ECDE2AE9._id_28C73C08C5F76289;
    loadout.loadoutsecondarystickers[0] = _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[0];
    loadout.loadoutsecondarystickers[1] = _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[1];
    loadout.loadoutsecondarystickers[2] = _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[2];
    loadout.loadoutsecondarystickers[3] = _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[3];
    loadout.loadoutsecondarystickers[4] = _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[4];
  } else {
    if(isweaponvariantlocked(loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid))
      loadout.loadoutsecondaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutsecondaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8];

      if(attachment != "none" && attachmentisrestricted(attachment, loadout.loadoutsecondary)) {
        loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  foreach(perk in loadout.loadoutperks) {
    if(!scripts\mp\perks\perks::_id_F45C19871B412EA5(perk)) {
      continue;
    }
    slot = scripts\mp\perks\perks::getperkslot(perk);

    if(!isDefined(slot) || slot != 1) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutperks.size; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 >= _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1.size) {
          continue;
        }
        loadout.loadoutperks[_id_AC0E594AC96AA3A8] = _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[_id_AC0E594AC96AA3A8];
      }

      break;
    }

    if(perkisrestricted(perk)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutperks.size; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 >= _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1.size) {
          continue;
        }
        loadout.loadoutperks[_id_AC0E594AC96AA3A8] = _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[_id_AC0E594AC96AA3A8];
      }

      break;
    }
  }

  if(!isDefined(loadout.loadoutperks)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutperks.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 >= _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1.size) {
        continue;
      }
      loadout.loadoutperks[_id_AC0E594AC96AA3A8] = _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[_id_AC0E594AC96AA3A8];
    }
  }

  slot = scripts\mp\perks\perks::getperkslot(loadout._id_15F3E6DF722FB1CF);

  if(!isDefined(slot) || slot != 2)
    loadout._id_15F3E6DF722FB1CF = _id_6433B6E8ECDE2AE9._id_13DB3CA1AD2DB644;

  if(perkisrestricted(loadout._id_15F3E6DF722FB1CF))
    loadout._id_15F3E6DF722FB1CF = _id_6433B6E8ECDE2AE9._id_13DB3CA1AD2DB644;

  slot = scripts\mp\perks\perks::getperkslot(loadout._id_15F3E5DF722FAF9C);

  if(!isDefined(slot) || slot != 3)
    loadout._id_15F3E5DF722FAF9C = _id_6433B6E8ECDE2AE9._id_34FDCA49E62D81EE;

  if(perkisrestricted(loadout._id_15F3E5DF722FAF9C))
    loadout._id_15F3E5DF722FAF9C = _id_6433B6E8ECDE2AE9._id_34FDCA49E62D81EE;

  if(killstreakisrestricted("specialist_perk_1") || killstreakisrestricted("specialist_perk_2") || killstreakisrestricted("specialist_perk_3"))
    loadout.loadoutusingspecialist = 0;

  if(!scripts\mp\equipment::isequipmentprimary(loadout.loadoutequipmentprimary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentprimary))
    loadout.loadoutequipmentprimary = _id_6433B6E8ECDE2AE9._id_223912952E2FCAA5;
  else if(equipmentisrestricted(loadout.loadoutequipmentprimary)) {
    loadout.loadoutequipmentprimary = _id_6433B6E8ECDE2AE9._id_223912952E2FCAA5;
    _id_BC72F32B1575D517 = 1;
  }

  if(!scripts\mp\equipment::isequipmentsecondary(loadout.loadoutequipmentsecondary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentsecondary))
    loadout.loadoutequipmentsecondary = _id_6433B6E8ECDE2AE9._id_56507F15843909C5;
  else if(equipmentisrestricted(loadout.loadoutequipmentsecondary)) {
    loadout.loadoutequipmentsecondary = _id_6433B6E8ECDE2AE9._id_56507F15843909C5;
    _id_BC72F32B1575D517 = 1;
  }

  _id_DC5F6FAA8BB8FFFE = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    if(killstreakisrestricted(_id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[_id_AC0E594AC96AA3A8]))
      _id_35BD18D6D22E7106[_id_AC0E594AC96AA3A8] = "none";
  }

  if(!scripts\mp\utility\game::isanymlgmatch() && (loadout.loadoutkillstreak1 == "none" || loadout.loadoutkillstreak2 == "none" || loadout.loadoutkillstreak3 == "none"))
    _id_DC5F6FAA8BB8FFFE = 1;

  if(!_id_DC5F6FAA8BB8FFFE) {
    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak1];

    if(!(scripts\mp\utility\game::isanymlgmatch() && loadout.loadoutkillstreak1 == "none") && (!isDefined(_id_D442547D75DFFD09) || !isDefined(_id_D442547D75DFFD09._id_594AF43597023062) || !_id_D442547D75DFFD09._id_594AF43597023062))
      _id_DC5F6FAA8BB8FFFE = 1;

    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak2];

    if(!(scripts\mp\utility\game::isanymlgmatch() && loadout.loadoutkillstreak2 == "none") && (!isDefined(_id_D442547D75DFFD09) || !isDefined(_id_D442547D75DFFD09._id_594AF43597023062) || !_id_D442547D75DFFD09._id_594AF43597023062))
      _id_DC5F6FAA8BB8FFFE = 1;

    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak3];

    if(!(scripts\mp\utility\game::isanymlgmatch() && loadout.loadoutkillstreak3 == "none") && (!isDefined(_id_D442547D75DFFD09) || !isDefined(_id_D442547D75DFFD09._id_594AF43597023062) || !_id_D442547D75DFFD09._id_594AF43597023062))
      _id_DC5F6FAA8BB8FFFE = 1;
  }

  if(!_id_DC5F6FAA8BB8FFFE) {
    if(killstreakisrestricted(loadout.loadoutkillstreak1)) {
      loadout.loadoutkillstreak1 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[0];
      _id_BC72F32B1575D517 = 1;
    }

    if(killstreakisrestricted(loadout.loadoutkillstreak2)) {
      loadout.loadoutkillstreak2 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[1];
      _id_BC72F32B1575D517 = 1;
    }

    if(killstreakisrestricted(loadout.loadoutkillstreak3)) {
      loadout.loadoutkillstreak3 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[2];
      _id_BC72F32B1575D517 = 1;
    }
  }

  if(!_id_DC5F6FAA8BB8FFFE) {
    if(loadout.loadoutkillstreak1 == loadout.loadoutkillstreak2 && loadout.loadoutkillstreak1 != "none")
      _id_DC5F6FAA8BB8FFFE = 1;
    else if(loadout.loadoutkillstreak1 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak1 != "none")
      _id_DC5F6FAA8BB8FFFE = 1;
    else if(loadout.loadoutkillstreak2 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak2 != "none")
      _id_DC5F6FAA8BB8FFFE = 1;
  }

  if(!_id_DC5F6FAA8BB8FFFE) {
    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak1];

    if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.kills))
      _id_C3B445B88848B00F = _id_D442547D75DFFD09.kills;
    else
      _id_C3B445B88848B00F = 0;

    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak2];

    if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.kills))
      _id_C3B446B88848B242 = _id_D442547D75DFFD09.kills;
    else
      _id_C3B446B88848B242 = 0;

    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[loadout.loadoutkillstreak3];

    if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.kills))
      _id_C3B447B88848B475 = _id_D442547D75DFFD09.kills;
    else
      _id_C3B447B88848B475 = 0;

    if(_id_C3B445B88848B00F != 0 && _id_C3B445B88848B00F == _id_C3B446B88848B242)
      _id_DC5F6FAA8BB8FFFE = 1;
    else if(_id_C3B445B88848B00F != 0 && _id_C3B445B88848B00F == _id_C3B447B88848B475)
      _id_DC5F6FAA8BB8FFFE = 1;
    else if(_id_C3B446B88848B242 != 0 && _id_C3B446B88848B242 == _id_C3B447B88848B475)
      _id_DC5F6FAA8BB8FFFE = 1;
  }

  if(_id_DC5F6FAA8BB8FFFE) {
    loadout.loadoutkillstreak1 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[0];
    loadout.loadoutkillstreak2 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[1];
    loadout.loadoutkillstreak3 = _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[2];
  }

  return loadout;
}

validateweapon(_id_7BD653180204FCA6, weapon, attachments, camo, reticle, _id_358E8D9068997399, variantid, _id_681BA90FF25200C5) {
  _id_CD13663AEE778DB6 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  _id_099C561069F2EB71 = scripts\mp\utility\weapon::iscacsecondaryweapon(weapon);
  weaponslot = scripts\engine\utility::ter_op(_id_681BA90FF25200C5, "secondary", "primary");
  _id_BDDD73591D13804E = scripts\engine\utility::ter_op(_id_681BA90FF25200C5, 4, 1);

  if(isDefined(weapon) && weapon != "none" && weapon != "iw9_me_fists") {
    _id_7BD653180204FCA6.pointcost++;

    if(_id_681BA90FF25200C5) {
      if(!_id_099C561069F2EB71) {
        _id_7BD653180204FCA6.pointcost++;
        _id_7BD653180204FCA6.wildcards["overkill"] = 1;
      }
    } else if(_id_099C561069F2EB71) {
      validationerror("secondaryAsPrimary", undefined, weapon);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(_id_CD13663AEE778DB6)) {
      validationerror("unknownWeapon", weaponslot, weapon);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    } else if(istrue(level.weaponmapdata[_id_CD13663AEE778DB6].uihidden)) {
      validationerror("unreleasedWeapon", weaponslot, weapon);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    if(!self isitemunlocked(_id_CD13663AEE778DB6, "weapon") && !weaponunlocksvialoot(_id_CD13663AEE778DB6)) {
      validationerror("lockedWeapon", weaponslot, weapon);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    if(_id_358E8D9068997399 == 0) {
      if(variantid != -1) {
        validationerror("emptyItemIDMismatch", weaponslot, weapon);
        _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
      }
    } else if(variantid == -1) {
      validationerror("emptyVariantIDMismatch", weaponslot, weapon);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(_id_358E8D9068997399)) {
        validationerror("nonWeaponLootItemID", weaponslot, weapon);
        _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
      }

      _id_157C94951634CBC9 = scripts\mp\loot::getlootweaponref(_id_358E8D9068997399);

      if(!isDefined(_id_157C94951634CBC9)) {
        validationerror("badLootItemID", weaponslot, weapon);
        _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
      } else {
        _id_093B3002EBEF628B = scripts\mp\loot::lookupvariantref(weapon, variantid);

        if(!isDefined(_id_093B3002EBEF628B)) {
          validationerror("badVariantRef", weaponslot, weapon);
          _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
        } else if(_id_093B3002EBEF628B != _id_157C94951634CBC9) {
          validationerror("lootDataMismatch", weaponslot, weapon);
          _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
        }
      }
    }

    validateattachments(_id_7BD653180204FCA6, attachments, weapon, _id_CD13663AEE778DB6, weaponslot);
  }
}

validateattachments(_id_7BD653180204FCA6, attachments, weapon, _id_CD13663AEE778DB6, weaponslot) {
  _id_CF4209C200F8BBF4 = _id_2669878CF5A1B6BC::weapongroupmap(weapon);
  _id_3B66374A358E4A8D = getsubstr(_id_CF4209C200F8BBF4, 7) + "Attach";
  _id_BDDD73591D13804E = scripts\engine\utility::ter_op(weaponslot == "primary", 2, 5);
  _id_80553B9EE292C3E6 = 0;
  _id_38CE0EE62103D3FB = 0;
  _id_2501CA5A023E0655 = scripts\engine\utility::ter_op(weaponslot == "primary", 2, 2);

  foreach(_id_DF6D8E005B4B8020, attachment in attachments) {
    _id_3807BD1F5D9DD252 = 0;

    if(isDefined(attachment) && attachment != "none") {
      _id_F98BAFD67872A38C = scripts\mp\utility\weapon::getattachmenttype(attachment);

      if(isDefined(_id_F98BAFD67872A38C) && _id_F98BAFD67872A38C != "") {
        if(isDefined(attachment)) {
          if(_id_F98BAFD67872A38C == "rail")
            _id_3807BD1F5D9DD252 = 1;
        }
      }

      _id_4F4DD9B2C0BC606A = _id_CD13663AEE778DB6 + "+" + attachment;

      if(!self isitemunlocked(_id_4F4DD9B2C0BC606A, _id_3B66374A358E4A8D)) {
        validationerror("lockedAttachment", weaponslot, attachment);
        _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E][_id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E].size] = _id_DF6D8E005B4B8020;
      }

      if(!scripts\mp\utility\weapon::attachmentisselectable(_id_CD13663AEE778DB6, attachment)) {
        validationerror("nonSelectableAttachment", weaponslot, attachment);
        _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E][_id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E].size] = _id_DF6D8E005B4B8020;
      }

      if(_id_3807BD1F5D9DD252) {
        _id_80553B9EE292C3E6++;
        _id_7BD653180204FCA6.pointcost++;
      } else {
        _id_38CE0EE62103D3FB++;

        if(_id_38CE0EE62103D3FB <= _id_2501CA5A023E0655)
          _id_7BD653180204FCA6.pointcost++;
        else {
          _id_7BD653180204FCA6.wildcards[weaponslot + "_attachment_" + (_id_38CE0EE62103D3FB + 1)] = 1;
          _id_7BD653180204FCA6.pointcost = _id_7BD653180204FCA6.pointcost + 2;
        }
      }
    }
  }

  if(_id_38CE0EE62103D3FB > 5) {
    validationerror("tooManyAttachments", weaponslot, _id_38CE0EE62103D3FB);
    _id_7BD653180204FCA6.invaliditems[scripts\engine\utility::ter_op(weaponslot == "primary", 3, 6)] = 1;
  }

  if(_id_80553B9EE292C3E6 > 1) {
    validationerror("tooManyOpticAttachments", weaponslot, _id_80553B9EE292C3E6);
    _id_7BD653180204FCA6.invaliditems[scripts\engine\utility::ter_op(weaponslot == "primary", 3, 6)] = 1;
  }
}

validatepower(_id_7BD653180204FCA6, power, _id_17BD8FA17EE68BD6, _id_2B8EAD494644680B) {
  _id_BDDD73591D13804E = scripts\engine\utility::ter_op(_id_17BD8FA17EE68BD6 == "primary", 7, 8);

  if(isDefined(power) && power != "none") {
    if(!isDefined(level.powers[power])) {
      validationerror("unknownPower", _id_17BD8FA17EE68BD6, power);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    if(!self isitemunlocked(power, "power")) {
      validationerror("lockedPower", _id_17BD8FA17EE68BD6, power);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    _id_A9F5EF46BA07C23F = lookuppowerslot(power);

    if(!isDefined(_id_A9F5EF46BA07C23F)) {
      validationerror("unknownMenuPower", _id_17BD8FA17EE68BD6, power);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    } else if(_id_A9F5EF46BA07C23F != _id_17BD8FA17EE68BD6) {
      validationerror("powerInWrongSlot", _id_17BD8FA17EE68BD6, power);
      _id_7BD653180204FCA6.invaliditems[_id_BDDD73591D13804E] = 1;
    }

    _id_7BD653180204FCA6.pointcost++;
  }

  if(istrue(_id_2B8EAD494644680B)) {
    _id_7BD653180204FCA6.pointcost = _id_7BD653180204FCA6.pointcost + 2;
    _id_34989FF734E79A50 = scripts\engine\utility::ter_op(_id_17BD8FA17EE68BD6 == "primary", "extra_lethal", "extra_tactical");
    _id_7BD653180204FCA6.wildcards[_id_34989FF734E79A50] = 1;
  }
}

validateperks(_id_7BD653180204FCA6, perks, archetype) {
  _id_BE7E0B9208F63C11 = [];
  _id_BE7E0B9208F63C11[1] = 0;
  _id_BE7E0B9208F63C11[2] = 0;
  _id_BE7E0B9208F63C11[3] = 0;

  foreach(perk in perks) {
    if(isDefined(perk) && perk != "none") {
      if(!scripts\mp\perks\perks::_id_F45C19871B412EA5(perk)) {
        validationerror("invalidPerk", undefined, perk);
        _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
      }

      slot = scripts\mp\perks\perks::getperkslot(perk);

      if(isDefined(slot)) {
        _id_BE7E0B9208F63C11[slot]++;

        if(_id_BE7E0B9208F63C11[slot] > 2) {
          validationerror("tooManyPerks", slot, perk);
          _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
        }

        if(!self isitemunlocked(perk, "perk")) {
          validationerror("lockedPerk", slot, perk);
          _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
        }

        if(_id_BE7E0B9208F63C11[slot] == 1)
          _id_7BD653180204FCA6.pointcost++;
        else {
          _id_7BD653180204FCA6.wildcards["extra_perk_" + slot] = 1;
          _id_7BD653180204FCA6.pointcost = _id_7BD653180204FCA6.pointcost + 2;
        }
      } else if(isDefined(level.menurigperks[perk])) {
        if(level.menurigperks[perk].archetype != archetype) {
          validationerror("rigPerkOnWrongRig", undefined, perk);
          _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
        }

        if(!self isitemunlocked(perk, "trait")) {
          validationerror("lockedRigPerk", slot, perk);
          _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
        }
      } else {
        validationerror("unknownPerkType", undefined, perk);
        _id_7BD653180204FCA6.invaliditems[9][_id_7BD653180204FCA6.invaliditems[9].size] = perk;
      }
    }
  }
}

validatestreaks(_id_7BD653180204FCA6, _id_9C67970F41B09EBA, _id_9C67960F41B09C87, _id_9C67950F41B09A54) {
  streaks = [_id_9C67970F41B09EBA, _id_9C67960F41B09C87, _id_9C67950F41B09A54];

  foreach(_id_153FDEE861E0F06F in streaks) {
    if(_id_153FDEE861E0F06F == "none") {
      continue;
    }
    _id_159EC9A052E1EFDA = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(_id_153FDEE861E0F06F);

    if(!isDefined(_id_159EC9A052E1EFDA)) {
      validationerror("unknownStreak", undefined, _id_153FDEE861E0F06F);
      _id_7BD653180204FCA6.invaliditems[12] = 1;
    }

    if(!self isitemunlocked(_id_153FDEE861E0F06F, "killstreak")) {
      validationerror("lockedStreak", undefined, _id_153FDEE861E0F06F);
      _id_7BD653180204FCA6.invaliditems[12] = 1;
    }
  }

  if(_id_9C67970F41B09EBA == _id_9C67960F41B09C87 && _id_9C67970F41B09EBA != "none") {
    validationerror("duplicateStreak", undefined, _id_9C67970F41B09EBA);
    _id_7BD653180204FCA6.invaliditems[12] = 1;
  } else if(_id_9C67970F41B09EBA == _id_9C67950F41B09A54 && _id_9C67970F41B09EBA != "none") {
    validationerror("duplicateStreak", undefined, _id_9C67970F41B09EBA);
    _id_7BD653180204FCA6.invaliditems[12] = 1;
  } else if(_id_9C67960F41B09C87 == _id_9C67950F41B09A54 && _id_9C67960F41B09C87 != "none") {
    validationerror("duplicateStreak", undefined, _id_9C67960F41B09C87);
    _id_7BD653180204FCA6.invaliditems[12] = 1;
  }
}

validatearchetype(_id_7BD653180204FCA6, archetype) {
  if(!isDefined(level.archetypeids[archetype])) {
    validationerror("unknownArchetype", undefined, archetype);
    _id_7BD653180204FCA6.invaliditems[10] = 1;
  }

  if(!self isitemunlocked(archetype, "rig")) {
    validationerror("lockedArchetype", undefined, archetype);
    _id_7BD653180204FCA6.invaliditems[10] = 1;
  }
}

validatesuper(_id_7BD653180204FCA6, super) {
  if(!isDefined(super) || super == "none") {
    return;
  }
  _id_FBBB3212817D1D40 = level.superglobals.staticsuperdata[super];

  if(!isDefined(_id_FBBB3212817D1D40)) {
    validationerror("unknownSuper", undefined, super);
    _id_7BD653180204FCA6.invaliditems[11] = 1;
  }

  if(!self isitemunlocked(super, "super")) {
    validationerror("lockedSuper", undefined, super);
    _id_7BD653180204FCA6.invaliditems[11] = 1;
  }
}

validatewildcards(_id_7BD653180204FCA6) {}

fixloadout(loadout) {
  _id_B9C1CB17EE62925B = scripts\mp\class::loadout_getclassstruct();
  _id_B9C1CB17EE62925B.loadoutarchetype = "archetype_assault";
  _id_B9C1CB17EE62925B.loadoutprimary = "iw9_ar_mike4";
  return _id_B9C1CB17EE62925B;
}

fixweapon(loadout, weaponslot) {
  if(weaponslot == "primary") {
    loadout.loadoutprimary = "iw9_ar_mike4";
    loadout.loadoutprimarycamo = "none";
    loadout.loadoutprimaryreticle = "none";
    loadout.loadoutprimarylootitemid = 0;
    loadout.loadoutprimaryvariantid = -1;

    for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < scripts\mp\class::getmaxprimaryattachments(); _id_40E4B9C48B36C9EC++)
      loadout.loadoutprimaryattachments[_id_40E4B9C48B36C9EC] = "none";
  } else {
    loadout.loadoutsecondary = "none";
    loadout.loadoutsecondarycamo = "none";
    loadout.loadoutsecondaryreticle = "none";
    loadout.loadoutsecondarylootitemid = 0;
    loadout.loadoutsecondaryvariantid = -1;

    for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < scripts\mp\class::getmaxsecondaryattachments(); _id_40E4B9C48B36C9EC++)
      loadout.loadoutsecondaryattachments[_id_40E4B9C48B36C9EC] = "none";
  }
}

fixattachment(loadout, weaponslot, _id_DF6D8E005B4B8020) {
  if(weaponslot == "primary")
    loadout.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = "none";
  else
    loadout.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = "none";
}

fixpower(loadout, _id_17BD8FA17EE68BD6) {
  if(_id_17BD8FA17EE68BD6 == "primary") {
    loadout.loadoutpowerprimary = "none";
    loadout.loadoutextrapowerprimary = 0;
  } else {
    loadout.loadoutpowersecondary = "none";
    loadout.loadoutextrapowersecondary = 0;
  }
}

fixperk(loadout, perk) {
  loadout.loadoutperks = scripts\engine\utility::array_remove(loadout.loadoutperks, perk);
}

fixkillstreaks(loadout) {
  loadout.loadoutkillstreak1 = "none";
  loadout.loadoutkillstreak2 = "none";
  loadout.loadoutkillstreak3 = "none";
}

fixarchetype(loadout) {
  loadout.loadoutarchetype = "archetype_assault";
  fixsuper(loadout);

  foreach(perk in loadout.loadoutperks) {
    if(isDefined(level.menurigperks[perk])) {
      fixperk(loadout, perk);
      break;
    }
  }
}

fixsuper(loadout) {
  loadout.loadoutsuper = "none";
}

fixinvaliditems(loadout, invaliditems) {
  if(isDefined(invaliditems[0])) {
    loadout = fixloadout(loadout);
    return loadout;
  }

  if(isDefined(invaliditems[1]))
    fixweapon(loadout, "primary");
  else if(isDefined(invaliditems[3])) {
    for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < scripts\mp\class::getmaxprimaryattachments(); _id_40E4B9C48B36C9EC++)
      fixattachment(loadout, "primary", _id_40E4B9C48B36C9EC);
  } else {
    foreach(_id_40E4B9C48B36C9EC in invaliditems[2])
    fixattachment(loadout, "primary", _id_40E4B9C48B36C9EC);
  }

  if(isDefined(invaliditems[4]))
    fixweapon(loadout, "secondary");
  else if(isDefined(invaliditems[6])) {
    for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < scripts\mp\class::getmaxsecondaryattachments(); _id_40E4B9C48B36C9EC++)
      fixattachment(loadout, "secondary", _id_40E4B9C48B36C9EC);
  } else {
    foreach(_id_40E4B9C48B36C9EC in invaliditems[5])
    fixattachment(loadout, "secondary", _id_40E4B9C48B36C9EC);
  }

  if(isDefined(invaliditems[7]))
    fixpower(loadout, "primary");

  if(isDefined(invaliditems[8]))
    fixpower(loadout, "secondary");

  foreach(perk in invaliditems[9])
  fixperk(loadout, perk);

  if(isDefined(invaliditems[10]))
    fixarchetype(loadout);
  else if(isDefined(invaliditems[11]))
    fixarchetype(loadout);

  if(isDefined(invaliditems[12]))
    fixkillstreaks(loadout);

  return loadout;
}

lookuppowerslot(_id_EF7579BE51267BDB) {
  _id_DADAE42DC766A7F7 = tablelookup("mp/menuPowers.csv", 3, _id_EF7579BE51267BDB, 2);

  if(!isDefined(_id_DADAE42DC766A7F7) || _id_DADAE42DC766A7F7 != "1" && _id_DADAE42DC766A7F7 != "2")
    return undefined;

  return scripts\engine\utility::ter_op(_id_DADAE42DC766A7F7 == "1", "primary", "secondary");
}

weaponunlocksvialoot(weaponref) {
  return 0;
}

isweaponuihidden(_id_49E6EF3EDADD524E) {
  return isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && istrue(level.weaponmapdata[_id_49E6EF3EDADD524E].uihidden);
}

isweaponvariantlocked(_id_49E6EF3EDADD524E, variantid) {
  if(scripts\mp\utility\game::isanymlgmatch())
    return 1;

  if(!isDefined(variantid) || variantid <= 0)
    return 0;

  _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + variantid;
  return isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749]) && istrue(level.weaponlootmapdata[_id_A6ED1602A5107749].islocked);
}

isattachmentvariantinvalid(_id_49E6EF3EDADD524E, _id_FEDB77AAD2340743, attachment, _id_1708B873A34EEB50) {
  if(scripts\mp\utility\game::isanymlgmatch())
    return 1;

  _id_C0123FB0FCE151E5 = isDefined(_id_1708B873A34EEB50) && _id_1708B873A34EEB50 > 0 && attachment != "none";

  if(!_id_C0123FB0FCE151E5)
    return 0;

  _id_D54114842C617892 = getdvarint("dvar_14E87EA13737CDBB", 1);
  _id_851E7FE2EC9ADBCE = isDefined(_id_FEDB77AAD2340743) && _id_FEDB77AAD2340743 > 0;

  if(!_id_D54114842C617892 && !_id_851E7FE2EC9ADBCE)
    return 1;

  _id_E88B89F1334A1506 = _id_49E6EF3EDADD524E + "|" + _id_FEDB77AAD2340743;
  _id_FFE43E0D1655060E = 0;
  _id_ABF526089D208196 = 1;

  for(;;) {
    _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + _id_ABF526089D208196;

    if(!isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749])) {
      break;
    }

    if(_id_D54114842C617892 || _id_A6ED1602A5107749 == _id_E88B89F1334A1506) {
      if(!istrue(level.weaponlootmapdata[_id_A6ED1602A5107749].islocked)) {
        if(isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap)) {
          foreach(key, id in level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap) {
            if(_id_1708B873A34EEB50 == id && attachment == key) {
              _id_FFE43E0D1655060E = 1;
              break;
            }
          }
        }

        if(_id_FFE43E0D1655060E) {
          break;
        }
      }
    }

    _id_ABF526089D208196++;
  }

  return !_id_FFE43E0D1655060E;
}

_id_9480A79A4852090F() {
  _id_6433B6E8ECDE2AE9 = spawnStruct();
  _id_6433B6E8ECDE2AE9._id_5E6961853F911ABF = "iw9_ar_mike4";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB = [];
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[0] = "none";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[1] = "none";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[2] = "none";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[3] = "none";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[4] = "none";
  _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[5] = "none";
  _id_6433B6E8ECDE2AE9._id_606482762A976E6B = "none";
  _id_6433B6E8ECDE2AE9._id_9E9BF32419E3FB65 = "none";
  _id_6433B6E8ECDE2AE9._id_A2746A3326FFD02D = -1;
  _id_6433B6E8ECDE2AE9._id_DBD72EBF429C33CC = [];
  _id_6433B6E8ECDE2AE9._id_AB71722736D6300D = "none";
  _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[0] = "none";
  _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[1] = "none";
  _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[2] = "none";
  _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[3] = "none";
  _id_6433B6E8ECDE2AE9._id_21EDF78F47F80693[4] = "none";
  _id_6433B6E8ECDE2AE9._id_FBC41EF364D09CDB = "iw9_pi_papa220";
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F = [];
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[0] = "none";
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[1] = "none";
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[2] = "none";
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[3] = "none";
  _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[4] = "none";
  _id_6433B6E8ECDE2AE9._id_FE85AC60E4C42827 = "none";
  _id_6433B6E8ECDE2AE9._id_5EF582D35FC85969 = "none";
  _id_6433B6E8ECDE2AE9._id_5CCACFECEB8F0B91 = -1;
  _id_6433B6E8ECDE2AE9._id_541023C8262AD6A8 = [];
  _id_6433B6E8ECDE2AE9._id_28C73C08C5F76289 = "none";
  _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[0] = "none";
  _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[1] = "none";
  _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[2] = "none";
  _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[3] = "none";
  _id_6433B6E8ECDE2AE9._id_6FF9BDDE98B6C7AF[4] = "none";
  _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1 = [];
  _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[0] = "specialty_hustle";
  _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[1] = "specialty_grenade_expert";
  _id_6433B6E8ECDE2AE9._id_13DB3CA1AD2DB644 = "specialty_restock";
  _id_6433B6E8ECDE2AE9._id_34FDCA49E62D81EE = "specialty_quick_fix";
  _id_6433B6E8ECDE2AE9._id_223912952E2FCAA5 = "equip_frag";
  _id_6433B6E8ECDE2AE9._id_56507F15843909C5 = "equip_flash";
  _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E = [];
  _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[0] = "uav";
  _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[1] = "cruise_predator";
  _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[2] = "chopper_gunner";

  if(scripts\mp\utility\game::isanymlgmatch()) {
    _id_4E05090D7E0C97CE = getscriptbundle("leagueplaybundle:" + level._id_21E8A7768C0260F2._id_B1E3933DEC92EBFF);
    _id_EFFE6F81E1A11B81 = getscriptbundle("classtableentry:" + _id_4E05090D7E0C97CE._id_6433B6E8ECDE2AE9);
    _id_9F9E341110BF6F8E = getscriptbundle("killstreaklist:" + _id_4E05090D7E0C97CE._id_4B45B03E52A55F4E);
    _id_6433B6E8ECDE2AE9._id_5E6961853F911ABF = _id_EFFE6F81E1A11B81.primaryweapon.weapon;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB = [];
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[0] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68715C04CE28F;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[1] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68815C04CE4C2;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[2] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68915C04CE6F5;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[3] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68215C04CD790;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[4] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68315C04CD9C3;
    _id_6433B6E8ECDE2AE9._id_2AABEC7BB44D89CB[5] = _id_EFFE6F81E1A11B81.primaryweapon._id_59F68415C04CDBF6;
    _id_6433B6E8ECDE2AE9._id_606482762A976E6B = _id_EFFE6F81E1A11B81.primaryweapon.camo;
    _id_6433B6E8ECDE2AE9._id_5A68D67FC469E1E7 = _id_EFFE6F81E1A11B81.primaryweapon.reticle;
    _id_6433B6E8ECDE2AE9._id_A2746A3326FFD02D = scripts\engine\utility::ter_op(isDefined(_id_EFFE6F81E1A11B81.primaryweapon.variantid), int(_id_EFFE6F81E1A11B81.primaryweapon.variantid), -1);
    _id_6433B6E8ECDE2AE9._id_FBC41EF364D09CDB = _id_EFFE6F81E1A11B81.secondaryweapon.weapon;
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F = [];
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[0] = _id_EFFE6F81E1A11B81.secondaryweapon._id_59F68715C04CE28F;
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[1] = _id_EFFE6F81E1A11B81.secondaryweapon._id_59F68815C04CE4C2;
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[2] = _id_EFFE6F81E1A11B81.secondaryweapon._id_59F68915C04CE6F5;
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[3] = _id_EFFE6F81E1A11B81.secondaryweapon._id_59F68215C04CD790;
    _id_6433B6E8ECDE2AE9._id_8DB17208EEE8983F[4] = _id_EFFE6F81E1A11B81.secondaryweapon._id_59F68315C04CD9C3;
    _id_6433B6E8ECDE2AE9._id_FE85AC60E4C42827 = _id_EFFE6F81E1A11B81.secondaryweapon.camo;
    _id_6433B6E8ECDE2AE9._id_5EF582D35FC85969 = _id_EFFE6F81E1A11B81.secondaryweapon.reticle;
    _id_6433B6E8ECDE2AE9._id_5CCACFECEB8F0B91 = scripts\engine\utility::ter_op(isDefined(_id_EFFE6F81E1A11B81.secondaryweapon.variantid), int(_id_EFFE6F81E1A11B81.secondaryweapon.variantid), -1);
    _id_6433B6E8ECDE2AE9._id_541023C8262AD6A8 = [];
    _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1 = [];
    _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[0] = _id_EFFE6F81E1A11B81.perks._id_16680ABD1742C050;
    _id_6433B6E8ECDE2AE9._id_89BA5F57A95D1CE1[1] = _id_EFFE6F81E1A11B81.perks._id_16680DBD1742C6E9;
    _id_6433B6E8ECDE2AE9._id_13DB3CA1AD2DB644 = _id_EFFE6F81E1A11B81.perks._id_16680CBD1742C4B6;
    _id_6433B6E8ECDE2AE9._id_34FDCA49E62D81EE = _id_EFFE6F81E1A11B81._id_50D0559DCBA571E2._id_16680ABD1742C050;
    _id_6433B6E8ECDE2AE9._id_223912952E2FCAA5 = _id_EFFE6F81E1A11B81.equipment.primary;
    _id_6433B6E8ECDE2AE9._id_56507F15843909C5 = _id_EFFE6F81E1A11B81.equipment._id_D7B9856A19F9B6B5;
    _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[0] = _id_9F9E341110BF6F8E._id_386A08793AF08E6C[0].ref;
    _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[1] = _id_9F9E341110BF6F8E._id_386A08793AF08E6C[1].ref;
    _id_6433B6E8ECDE2AE9._id_4B45B03E52A55F4E[2] = _id_9F9E341110BF6F8E._id_386A08793AF08E6C[2].ref;
  }

  return _id_6433B6E8ECDE2AE9;
}