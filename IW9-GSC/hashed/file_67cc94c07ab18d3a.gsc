/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67cc94c07ab18d3a.gsc
***********************************************/

init() {
  if(_id_19598C1EA1487B84()) {
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_workbench", ::_id_302E021A6FF37AA6);
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_AD115D1D75AD46F8);
  }
}

_id_302E021A6FF37AA6(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player))
    player = self;

  if(!_id_2D9D24F7C63AC143::_id_9AC2038430604B09(player)) {
    return;
  }
  if(istrue(player._id_859654E0445A36D9)) {
    if(isDefined(level.br_pickups) && isDefined(level.br_pickups._id_355CDDB773CB000D))
      player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
  } else {
    if(istrue(player._id_35DADE814E13D3CE)) {
      return;
    }
    _id_055A0F1BFD09E95E = isDefined(state) && state == "visible";

    if(istrue(player.insertingarmorplate))
      player notify("try_armor_cancel", "armory_kiosk_used");

    if(!isDefined(state))
      thread _id_7BDD79F0C203D370(player, instance);
    else {
      if(_id_055A0F1BFD09E95E) {
        if(isDefined(instance)) {
          if(_id_2CEDCC356F1B9FC8::_id_0600D1AB3A9FF61F(instance.type)) {
            _id_9B1941CB7354665E = "open";
            instance setscriptablepartstate("br_workbench", _id_9B1941CB7354665E);
          }

          instance thread _id_4384ABBF498DF6A7::kioskfixupproneplayers();
        }

        _id_44DE440E5B812021(player);
        thread _id_7BDD79F0C203D370(player, instance);
        return;
      }

      if(state == "open") {
        _id_44DE440E5B812021(player);
        thread _id_7BDD79F0C203D370(player, instance);
      }
    }
  }
}

_id_7BDD79F0C203D370(player, _id_15B89FF206500554) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");

  if(isDefined(level._id_6BEFF7B631AB7E18))
    [[level._id_6BEFF7B631AB7E18]](_id_15B89FF206500554, player);

  player setclientomnvar("ui_buystation_purchase_response", 0);
  player setclientomnvar("ui_buystation_open", 8);
  player._id_192CBAB14DE92A20 = 1;

  if(isDefined(player.pers["telemetry"])) {
    player.pers["telemetry"]._id_399EB9EA9DA87875 = 1;
    player.pers["telemetry"]._id_399B5389B8E5205B = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  }

  player thread _id_4384ABBF498DF6A7::_id_B543ED41CDF64895(_id_15B89FF206500554);
  player scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_5036FE27DEDBE1D3(player) {
  player setclientomnvar("ui_buystation_purchase_response", 0);
  player setclientomnvar("ui_buystation_open", 1);
  player._id_192CBAB14DE92A20 = undefined;
  player notify("_watchToAutoCloseMenu_end");
  _id_82B0B33A03DFE81B(player);

  if(isDefined(player.pers["telemetry"]._id_399EB9EA9DA87875))
    player.pers["telemetry"]._id_399EB9EA9DA87875 = 0;
}

_id_AD115D1D75AD46F8(_id_7148C1A6F25491F8, value) {
  player = self;

  if(!istrue(player._id_192CBAB14DE92A20)) {
    return;
  }
  if(_id_7148C1A6F25491F8 == "br_cancel_upgrade_purchase") {
    _id_5036FE27DEDBE1D3(player);

    if(isDefined(player.pers["telemetry"])) {
      if(isDefined(player.pers["telemetry"]._id_399B5389B8E5205B)) {
        player.pers["telemetry"]._id_EFEE7941330D15BE = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
        player.pers["telemetry"]._id_0D3209B1DA38D435 = player.pers["telemetry"]._id_EFEE7941330D15BE - player.pers["telemetry"]._id_399B5389B8E5205B;
      }
    }
  } else if(_id_7148C1A6F25491F8 == "upgrade_weapon")
    _id_C40FEFDBC769BF5B(player, value);
}

_id_19598C1EA1487B84() {
  if(!isDefined(level._id_08A960EC1F8D3B60))
    level._id_08A960EC1F8D3B60 = getdvarint("dvar_3AFF3E8D6E0B45DA", 0);

  return level._id_08A960EC1F8D3B60;
}

_id_E4E89A1C489C6FE1(player) {
  if(!isDefined(level._id_0EE910422C8F34B3))
    level._id_0EE910422C8F34B3 = getdvarint("dvar_A1D5DC7BD9D01032", 300);

  _id_2D4FA166958B2BBC = _id_0B7A9CE0A2282B79::_id_BA249AC98EDC6279(player);
  return int(max(0, level._id_0EE910422C8F34B3 - level._id_0EE910422C8F34B3 * _id_2D4FA166958B2BBC));
}

_id_EAB89BC3B0709D85(value) {
  return value & 3;
}

_id_EC72AAFFD5629E92(value) {
  return (value & 60) >> 2;
}

_id_373D9E3E41486AE1(player, _id_85166DA84E55DE25) {
  player setplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "blueprintTuned", 0);
  _id_88C1658D6B22A174 = [];
  _id_6DB9DF5A6DA9F3F7 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_88C1658D6B22A174[_id_DF6D8E005B4B8020] = player getplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
    _id_6DB9DF5A6DA9F3F7[_id_DF6D8E005B4B8020] = player getplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
  }

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    _id_460BD2A877684086 = player getplayerdata(level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
    _id_F23B046D49B6FA9B = player getplayerdata(level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
    player setplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment", _id_460BD2A877684086);
    player setplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID", _id_F23B046D49B6FA9B);
    _id_3793828403C6873E = scripts\engine\utility::array_find(_id_88C1658D6B22A174, _id_460BD2A877684086);
    _id_A5BFD04C143C5C3D = isDefined(_id_3793828403C6873E) && _id_6DB9DF5A6DA9F3F7[_id_3793828403C6873E] == _id_F23B046D49B6FA9B;

    if(_id_460BD2A877684086 == "none" || _id_A5BFD04C143C5C3D)
      player setplayerdata(level._id_5D69837CF4DB0407, "insuredWeapons", "weaponSetups", _id_85166DA84E55DE25, "attachmentSetup", _id_DF6D8E005B4B8020, "hasBPTune", 0);
  }
}

_id_15B07F33EB2E0625(weaponobj, attachment) {
  if(!isDefined(attachment))
    return undefined;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  weaponasset = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312);

  if(_func_EC9CD761DF1A3271(weaponasset, attachment))
    return "thermal_attachment";

  return undefined;
}

_id_BD931EA5F74143D9(player, _id_DD515FCF025B2E79) {
  foreach(_id_DE88CD14114C1E24 in player.primaryweapons) {
    if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79))
      return 1;
  }

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

    if(issameweapon(_id_9AC5E72784815708, _id_DD515FCF025B2E79))
      return 1;
  }

  return 0;
}

_id_C40FEFDBC769BF5B(player, value) {
  if(isDefined(player.pers["telemetry"]))
    player.pers["telemetry"]._id_DEA1AA89475B4D0F = 1;

  _id_9FCE40CC0126E16C = _id_EC72AAFFD5629E92(value);
  _id_FDF92A09C2352059 = 0;
  _id_EFFB4AE1788A8B10 = undefined;

  if(_id_9FCE40CC0126E16C != 15 && _id_9FCE40CC0126E16C <= 4) {
    _id_FDF92A09C2352059 = _id_E4E89A1C489C6FE1(player);
    _id_EFFB4AE1788A8B10 = player getplayerdata(level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", _id_9FCE40CC0126E16C, "attachment");
    _id_F4FC78C8B588B517(player, _id_EFFB4AE1788A8B10, _id_FDF92A09C2352059);
  }

  if(player.plundercount < _id_FDF92A09C2352059 || _id_9FCE40CC0126E16C != 15 && _id_9FCE40CC0126E16C > 4) {
    return;
  }
  if(_id_FDF92A09C2352059 > 0)
    player _id_6AFF3948CF4CCA03::playerplunderkioskpurchase(_id_FDF92A09C2352059);

  _id_FE4048AD22C35D73 = _id_EAB89BC3B0709D85(value);
  _id_C40FEFDBC769BF5B = _id_2D9D24F7C63AC143::_id_F2849DAE62F7444E(player, level.loadoutsgroup, "upgradeWeapon");

  if(_id_BD931EA5F74143D9(player, _id_C40FEFDBC769BF5B)) {
    return;
  }
  _id_0A7EFDAACBD89567 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(player, _id_FE4048AD22C35D73);
  _id_B6F7D841700BE1AD = _id_0B7A9CE0A2282B79::_id_540C2B6342F4E28C(player, _id_FE4048AD22C35D73);
  _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_9DB6A7E1567BB1F9(player, _id_FE4048AD22C35D73);
  itemtype = _id_15B07F33EB2E0625(_id_C40FEFDBC769BF5B, _id_EFFB4AE1788A8B10);
  _id_8CF1618BC3D277E0 = _id_C40FEFDBC769BF5B issilenced();
  _id_288ADCBB974853FD = 0;

  if(isDefined(player.pers["telemetry"])) {
    if(isDefined(_id_C40FEFDBC769BF5B)) {
      _id_FD464247E82127CB = getweaponvariantindex(_id_C40FEFDBC769BF5B);
      _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(_id_C40FEFDBC769BF5B);

      if(isDefined(_id_49E6EF3EDADD524E)) {
        player.pers["telemetry"]._id_F6814A1944AA6F42 = _id_49E6EF3EDADD524E;

        if(isDefined(_id_FD464247E82127CB))
          player.pers["telemetry"]._id_F6814A1944AA6F42 = player.pers["telemetry"]._id_F6814A1944AA6F42 + ("|" + _id_FD464247E82127CB);
      }
    }
  }

  if(_id_FE4048AD22C35D73 == 2)
    _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(player, _id_C40FEFDBC769BF5B, 1, _id_0A7EFDAACBD89567);
  else {
    _id_B10EFA89DF98704C = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, _id_FE4048AD22C35D73);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_B10EFA89DF98704C);
    _id_0B7A9CE0A2282B79::_id_BFEDEB20F8B77F3F(player, _id_FE4048AD22C35D73);
    _id_7E52B56769FA7774::_id_E5845FF9B61AC5D7(_id_C40FEFDBC769BF5B, weaponclipsize(_id_C40FEFDBC769BF5B), undefined, undefined, undefined, undefined, _id_0A7EFDAACBD89567, undefined, undefined, undefined, weaponclipsize(_id_C40FEFDBC769BF5B));
    _id_288ADCBB974853FD = _id_B10EFA89DF98704C issilenced();

    if(_id_9FCE40CC0126E16C == 15)
      _id_CB50685EBDAF0908(player, _id_B10EFA89DF98704C, _id_C40FEFDBC769BF5B);
  }

  _id_5B4A7BC1AF4766A6 = _id_0B7A9CE0A2282B79::_id_540C2B6342F4E28C(player, _id_FE4048AD22C35D73);
  _id_0B7A9CE0A2282B79::_id_C2B37CAEB3E8DFA0(player, _id_FE4048AD22C35D73, _id_B6F7D841700BE1AD, _id_5B4A7BC1AF4766A6);
  _id_724736FCF0FB6604::_id_AE30366A2D519A57(player, _id_FE4048AD22C35D73, _id_E1147886CCF51970);
  _id_85166DA84E55DE25 = _id_0B7A9CE0A2282B79::_id_5148F855DE907E6F(player, _id_FE4048AD22C35D73);

  if(isDefined(player.pers["telemetry"]))
    player.pers["telemetry"]._id_2BEE281754374F2F = _id_FE4048AD22C35D73;

  if(isDefined(_id_85166DA84E55DE25)) {
    _id_373D9E3E41486AE1(player, int(_id_85166DA84E55DE25) - 1);

    if(isDefined(player.pers["telemetry"]))
      player.pers["telemetry"]._id_C4C2BE79AA5960A4 = 1;
  }

  if(_id_FDF92A09C2352059 > 0) {
    if(_id_8CF1618BC3D277E0 && !_id_288ADCBB974853FD)
      itemtype = "silencer_attached";

    lootid = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(_id_2669878CF5A1B6BC::getweaponrootname(_id_C40FEFDBC769BF5B), _id_EFFB4AE1788A8B10);
    scripts\cp_mp\challenges::_id_C2C80007AFF49924("attachment", itemtype, lootid, 1, _id_FDF92A09C2352059);
  } else
    scripts\cp_mp\challenges::_id_3D8A8B0878F9F129(itemtype, undefined, undefined, 1, 0);
}

_id_CB50685EBDAF0908(player, _id_B10EFA89DF98704C, _id_C40FEFDBC769BF5B) {
  _id_A25A6D782EB4BBDA = undefined;

  foreach(attachment in _id_B10EFA89DF98704C.attachments) {
    if(!scripts\engine\utility::array_contains(_id_C40FEFDBC769BF5B.attachments, attachment))
      _id_A25A6D782EB4BBDA = attachment;
  }

  if(isDefined(_id_A25A6D782EB4BBDA)) {
    if(isDefined(player.pers["telemetry"]) && isDefined(_id_A25A6D782EB4BBDA)) {
      if(isDefined(player.pers["telemetry"]._id_EAED37605BA2E1D0))
        player.pers["telemetry"]._id_EAED37605BA2E1D0 = player.pers["telemetry"]._id_EAED37605BA2E1D0 + ("," + _id_A25A6D782EB4BBDA);
      else
        player.pers["telemetry"]._id_EAED37605BA2E1D0 = _id_A25A6D782EB4BBDA;
    }
  }
}

_id_44DE440E5B812021(player) {
  if(isDefined(player.pers["telemetry"]._id_68F5A925FFC5A5E1))
    player.pers["telemetry"]._id_68F5A925FFC5A5E1 = player.pers["telemetry"]._id_68F5A925FFC5A5E1 + 1;
  else
    player.pers["telemetry"]._id_68F5A925FFC5A5E1 = 1;
}

_id_F4FC78C8B588B517(player, attachment, _id_FDF92A09C2352059) {
  if(isDefined(player.pers["telemetry"])) {
    if(isDefined(player.pers["telemetry"]._id_EB1574F222631C93) && isDefined(_id_FDF92A09C2352059))
      player.pers["telemetry"]._id_EB1574F222631C93 = player.pers["telemetry"]._id_EB1574F222631C93 + _id_FDF92A09C2352059;
    else
      player.pers["telemetry"]._id_EB1574F222631C93 = _id_FDF92A09C2352059;

    if(isDefined(player.pers["telemetry"]._id_A7825EFF586379C1) && isDefined(attachment))
      player.pers["telemetry"]._id_A7825EFF586379C1 = player.pers["telemetry"]._id_A7825EFF586379C1 + ("," + attachment);
    else
      player.pers["telemetry"]._id_A7825EFF586379C1 = attachment;
  }
}

_id_82B0B33A03DFE81B(player) {
  _id_68F5A925FFC5A5E1 = 0;

  if(isDefined(player.pers["telemetry"]._id_68F5A925FFC5A5E1))
    _id_68F5A925FFC5A5E1 = player.pers["telemetry"]._id_68F5A925FFC5A5E1;

  _id_1CB2654B9D2B112A = 0;

  if(isDefined(player.pers["telemetry"]._id_EB1574F222631C93))
    _id_1CB2654B9D2B112A = int(player.pers["telemetry"]._id_EB1574F222631C93);

  _id_A18FE6BAF21AC773 = 0;

  if(isDefined(player.pers["telemetry"]._id_DEA1AA89475B4D0F))
    _id_A18FE6BAF21AC773 = player.pers["telemetry"]._id_DEA1AA89475B4D0F;

  _id_AA3672FDDEFEE7A8 = 0;

  if(isDefined(player.pers["telemetry"]._id_C4C2BE79AA5960A4))
    _id_AA3672FDDEFEE7A8 = player.pers["telemetry"]._id_C4C2BE79AA5960A4;

  _id_FE4048AD22C35D73 = 0;

  if(isDefined(player.pers["telemetry"]._id_2BEE281754374F2F))
    _id_FE4048AD22C35D73 = player.pers["telemetry"]._id_2BEE281754374F2F;

  weaponref = "";

  if(isDefined(player.pers["telemetry"]._id_F6814A1944AA6F42))
    weaponref = player.pers["telemetry"]._id_F6814A1944AA6F42;

  _id_54CB5BE3478A9E82 = "";

  if(isDefined(player.pers["telemetry"]._id_A7825EFF586379C1))
    _id_54CB5BE3478A9E82 = player.pers["telemetry"]._id_A7825EFF586379C1;

  _id_7A00B1279C13426B = "";

  if(isDefined(player.pers["telemetry"]._id_EAED37605BA2E1D0))
    _id_7A00B1279C13426B = player.pers["telemetry"]._id_EAED37605BA2E1D0;

  _id_C8FCB229A279D5CC = 0;

  if(istrue(player.pers["telemetry"]._id_B04ABD5D84312ACB))
    _id_C8FCB229A279D5CC = 1;

  _id_5177B21338FFA020 = 0;

  if(isDefined(player.pers["telemetry"]._id_0D3209B1DA38D435))
    _id_5177B21338FFA020 = player.pers["telemetry"]._id_0D3209B1DA38D435;

  _id_81954D580B24281B = 0.0;

  if(isDefined(player.origin[0]))
    _id_81954D580B24281B = player.origin[0];

  _id_E4F34F3A01C6FFF2 = 0.0;

  if(isDefined(player.origin[1]))
    _id_E4F34F3A01C6FFF2 = player.origin[1];

  _id_689A1188271A0BE5 = 0.0;

  if(isDefined(player.origin[2]))
    _id_689A1188271A0BE5 = player.origin[2];

  pitch = 0.0;

  if(isDefined(player.angles[0]))
    pitch = player.angles[0];

  yaw = 0.0;

  if(isDefined(player.angles[1]))
    yaw = player.angles[1];

  roll = 0.0;

  if(isDefined(player.angles[2]))
    roll = player.angles[2];

  player dlog_recordplayerevent("dlog_event_dmz_workbench", ["player_position_x", _id_81954D580B24281B, "player_position_y", _id_E4F34F3A01C6FFF2, "player_position_z", _id_689A1188271A0BE5, "player_rotation_pitch", pitch, "player_rotation_yaw", yaw, "player_rotation_roll", roll, "workbench_open_count", _id_68F5A925FFC5A5E1, "workbench_was_weapon_edited", _id_A18FE6BAF21AC773, "workbench_weapon_edited_ref", weaponref, "workbench_weapon_slot_edited", _id_FE4048AD22C35D73, "workbench_was_weapon_insured", _id_AA3672FDDEFEE7A8, "workbench_attachments_removed", _id_7A00B1279C13426B, "workbench_attachments_added", _id_54CB5BE3478A9E82, "workbench_cash_spent", _id_1CB2654B9D2B112A, "workbench_time_spent", _id_5177B21338FFA020, "workbench_session_ended_by_combat", _id_C8FCB229A279D5CC]);

  if(isDefined(player.pers["telemetry"]._id_EB1574F222631C93))
    player.pers["telemetry"]._id_EB1574F222631C93 = 0;

  if(isDefined(player.pers["telemetry"]._id_A7825EFF586379C1))
    player.pers["telemetry"]._id_A7825EFF586379C1 = "";

  _id_7A00B1279C13426B = "";

  if(isDefined(player.pers["telemetry"]._id_EAED37605BA2E1D0))
    player.pers["telemetry"]._id_EAED37605BA2E1D0 = "";
}