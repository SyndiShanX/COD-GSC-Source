/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3ff2458477d23489.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  _id_2FAC9B58D42B2920();
  data.funcs["onInit"] = ::_id_8C64A4F648288A95;
  data.funcs["onTeamAssigned"] = ::_id_921A0BE9EC330C6A;
  data.funcs["onEnterGulag"] = ::_id_CA07A6CA5C3C8AF5;
  data.funcs["onPlayerRespawn"] = ::_id_F6755BD234F8E261;
  data.funcs["onPlayerKilled"] = ::_id_A2045D8CAF0F792F;
  data.funcs["onPlayerDisconnect"] = ::_id_319BA124F0EC457C;
  data.funcs["onCancel"] = ::_id_AFD4BF63773CD7AD;
  data.funcs["onPlayerTearDown"] = ::_id_83D3732A571F142A;
  data.funcs["onPlayerAssimilated"] = ::_id_75B53AD947495F9C;
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_3D221E16860007D5);
}

_id_2FAC9B58D42B2920() {
  _id_ADC3C411E839C811();
  _id_89538DC128A24E58();
}

_id_ADC3C411E839C811() {
  level._id_5DDDEDBF2BDA5311 = spawnStruct();
  level._id_5DDDEDBF2BDA5311._id_61AB58DC6657120C = getdvarint("dvar_C7D4297BB4F79596", _id_64ACB6CE534155B7::_id_B891F0C9814330EB("hacker_phone"));
  level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352 = getdvarint("dvar_9EEF987DB450C17A", 2);
  level._id_5DDDEDBF2BDA5311._id_576A3B6B02998159 = getdvarint("dvar_C4E08D2FDAAB55F3", 50);
  level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293 = getdvarint("dvar_23FAB88C275BEC9F", 20);
  level._id_5DDDEDBF2BDA5311._id_982966060D10F80A = getdvarint("dvar_3CF195484E92A076", 200);
  level._id_5DDDEDBF2BDA5311._id_88F1BF50C2880F31 = getdvarint("dvar_630E4B6F3CC13D1E", 0);
  level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E = int(level._id_5DDDEDBF2BDA5311._id_982966060D10F80A / level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
  level._id_5DDDEDBF2BDA5311._id_30F17800E8EC227D = getdvarint("dvar_7152A29B5F75E34D", 1);
}

_id_89538DC128A24E58() {
  game["dialog"]["hacker_phone_start"] = "hack_wzan_msst";
  game["dialog"]["hacker_phone_nag"] = "hack_wzan_nagg";
  game["dialog"]["hacker_phone_missing"] = "hack_wzan_mrkl";
  game["dialog"]["hacker_phone_timer_expired"] = "hack_wzan_timx";
  game["dialog"]["hacker_phone_contract_hacked"] = "hack_wzan_cnhc";
  game["dialog"]["hacker_phone_complete"] = "hack_wzan_smxh";
}

_id_8C64A4F648288A95() {
  return 1;
}

_id_921A0BE9EC330C6A() {
  self.category = "hacker_phone";
  _id_FABF84450735DD93 = self.teams[0];
  self._id_9F274E85B7BBD87F = 0;
  self._id_CC4CD023F0195D5F = level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352;
  self._id_9CDFC15FE821D00C = _id_7FA77E2DBBD62DB5(_id_FABF84450735DD93);
  self._id_2655F1229EA3CB33 = [];
  _id_8280ACD4058F343B(_id_FABF84450735DD93);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_45B8E84DE48BB89F = 1;
    player setclientomnvar("ui_br_hacker_phone_state", 2);
  }

  _id_64ACB6CE534155B7::displayteamsplash(_id_FABF84450735DD93, "br_hacker_phone_quest_start_team");
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex("hacker_phone"));
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("hacker_phone", _id_FABF84450735DD93);
  _id_64ACB6CE534155B7::_id_E2AA45E2C6B5DEC1(self._id_9F274E85B7BBD87F, level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352);
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(level._id_5DDDEDBF2BDA5311._id_61AB58DC6657120C);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_6410262ECCC0AB66(time);
  _id_64ACB6CE534155B7::createquestobjicon("ui_map_icon_obj_hacker", "current", (0, 0, 0));
  objective_removeallfrommask(self.objectiveiconid);
  objective_addteamtomask(self.objectiveiconid, _id_FABF84450735DD93);
  _id_7155A66B3081EACA(_id_FABF84450735DD93);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hacker_phone_start", _id_FABF84450735DD93, 1, 1.0, undefined, "dx_br_bds4_");
}

_id_8280ACD4058F343B(_id_FABF84450735DD93) {
  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]))
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] = 0;

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]))
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] = 0;

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"]))
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = [];

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"]))
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = [];
}

_id_7FA77E2DBBD62DB5(_id_FABF84450735DD93) {
  _id_6CF4D7026C51235B = level._id_5DDDEDBF2BDA5311._id_576A3B6B02998159;

  if(istrue(level._id_5DDDEDBF2BDA5311._id_88F1BF50C2880F31)) {
    _id_926316044E93F849 = getDvar("dvar_779EAC48F0F0FA66", "50 45 40 35");
    _id_21E6C4EB825D874D = strtok(_id_926316044E93F849, " ");
    _id_652F47620AC4713F = int(min(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93), _id_21E6C4EB825D874D.size));
    _id_6CF4D7026C51235B = _id_21E6C4EB825D874D[_id_652F47620AC4713F - 1];
  }

  return int(_id_6CF4D7026C51235B);
}

_id_7155A66B3081EACA(_id_FABF84450735DD93, _id_FBA0376E0036DE8D) {
  _id_7CA287A82F54E4F6 = self._id_7CA287A82F54E4F6;

  if(isDefined(_id_FBA0376E0036DE8D))
    _id_7CA287A82F54E4F6 = _id_FBA0376E0036DE8D;

  _id_3D397B9A8D8CCDE2 = _id_06FC3C13CA7D3708(_id_7CA287A82F54E4F6, _id_FABF84450735DD93);
  thread _id_D9BA30C978790906(_id_3D397B9A8D8CCDE2, _id_FABF84450735DD93);
}

_id_06FC3C13CA7D3708(_id_7CA287A82F54E4F6, _id_FABF84450735DD93) {
  _id_6D1F29B3B0161959 = self.tablet.origin;

  if(isDefined(_id_7CA287A82F54E4F6))
    _id_6D1F29B3B0161959 = _id_7CA287A82F54E4F6.origin;
  else {
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!isDefined(player)) {
        continue;
      }
      _id_6D1F29B3B0161959 = player.origin;
      break;
    }
  }

  _id_FACF33F7F7AE6BCD = [];

  foreach(_id_92709BF054B20C5D in level._id_41F4BC9EE8C7C9C6.activetablets) {
    if(!isDefined(_id_92709BF054B20C5D) || !isDefined(_id_92709BF054B20C5D.origin)) {
      continue;
    }
    _id_FACF33F7F7AE6BCD[_id_FACF33F7F7AE6BCD.size] = _id_92709BF054B20C5D;
  }

  _id_FACF33F7F7AE6BCD = sortbydistance(_id_FACF33F7F7AE6BCD, _id_6D1F29B3B0161959);
  _id_FACF33F7F7AE6BCD = scripts\engine\utility::array_remove_array(_id_FACF33F7F7AE6BCD, self._id_2655F1229EA3CB33);

  if(isDefined(_id_FACF33F7F7AE6BCD) && _id_FACF33F7F7AE6BCD.size > 0) {
    _id_30A99625B9F5D98C = _id_FACF33F7F7AE6BCD[0];
    _id_68C7EE907C012FAD(_id_30A99625B9F5D98C);
    return _id_30A99625B9F5D98C;
  }
}

_id_D9BA30C978790906(_id_4A84DD415B837DE9, _id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("marked_contract_hacked");

  if(!isDefined(_id_4A84DD415B837DE9)) {
    return;
  }
  self._id_552C9E74F497621F = 0;

  while(!istrue(_id_1C6066D91AE79A56())) {
    _id_62787AB10CD11954 = 0;

    if(self._id_552C9E74F497621F >= 70) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hacker_phone_nag", _id_FABF84450735DD93, 1, 0.0, undefined, "dx_br_bds4_");
      _id_62787AB10CD11954 = 1;
      self._id_552C9E74F497621F = 0;
    }

    if(!scripts\engine\utility::array_contains(level._id_41F4BC9EE8C7C9C6.activetablets, _id_4A84DD415B837DE9)) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hacker_phone_missing", _id_FABF84450735DD93, 1, 0, undefined, "dx_br_bds4_");
      _id_62787AB10CD11954 = 1;
    }

    if(istrue(_id_62787AB10CD11954))
      _id_4A84DD415B837DE9 = _id_06FC3C13CA7D3708(self._id_7CA287A82F54E4F6, _id_FABF84450735DD93);

    self._id_552C9E74F497621F++;
    wait 1;
  }
}

_id_68C7EE907C012FAD(_id_DB376EE90688810D) {
  if(isDefined(self._id_09AA953016FACACC) && self._id_09AA953016FACACC == _id_DB376EE90688810D) {
    return;
  }
  _id_64ACB6CE534155B7::movequestobjicon(_id_DB376EE90688810D.origin + (0, 0, 25));
  self._id_09AA953016FACACC = _id_DB376EE90688810D;
}

_id_5D0B1FA9645F3C89(pickupent, _id_FBA0376E0036DE8D) {
  _id_FBA0376E0036DE8D endon("death_or_disconnect");

  if(istrue(_id_2FDCB6899DB87A0F(pickupent.instance, _id_FBA0376E0036DE8D.team))) {
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  if(istrue(level._id_5DDDEDBF2BDA5311._id_30F17800E8EC227D))
    _id_FBA0376E0036DE8D _id_6C4E8CEA70BF4B6D::_id_9BE29AD72A155EE1("intel_pickup_phone_alt", 11);

  _id_302CB8661B3C7AFA(pickupent, _id_FBA0376E0036DE8D);
}

_id_2FDCB6899DB87A0F(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30)) {
    if(scripts\engine\utility::array_contains(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93))
      return 1;
  }

  return 0;
}

_id_247BB9F9ABB4C268(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(!isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30))
    _id_DB376EE90688810D._id_5E3CC2521BD27A30 = [];

  _id_DB376EE90688810D._id_5E3CC2521BD27A30[_id_DB376EE90688810D._id_5E3CC2521BD27A30.size] = _id_FABF84450735DD93;
  _id_34BC4CAEFCDE3120(_id_FABF84450735DD93, _id_DB376EE90688810D.index);
}

_id_B111C1D13E127B6D(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30) && scripts\engine\utility::array_contains(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93)) {
    _id_DB376EE90688810D._id_5E3CC2521BD27A30 = scripts\engine\utility::array_remove(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93);
    _id_5BBF368BF1A6B402(_id_FABF84450735DD93, _id_DB376EE90688810D.index);
  }
}

_id_302CB8661B3C7AFA(pickupent, _id_FBA0376E0036DE8D) {
  if(istrue(_id_2FDCB6899DB87A0F(pickupent.instance, _id_FBA0376E0036DE8D.team)))
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
  else {
    _id_B8EBE3F71A08AB40 = _id_64ACB6CE534155B7::_id_22239D4CFF05D0A1(_id_FBA0376E0036DE8D.team);

    if(!isDefined(_id_B8EBE3F71A08AB40)) {
      return;
    }
    _id_B8EBE3F71A08AB40 _id_247BB9F9ABB4C268(pickupent.instance, _id_FBA0376E0036DE8D.team);
    _id_B8EBE3F71A08AB40._id_2655F1229EA3CB33[_id_B8EBE3F71A08AB40._id_2655F1229EA3CB33.size] = pickupent.instance;
    _id_B8EBE3F71A08AB40._id_9F274E85B7BBD87F++;
    _id_B8EBE3F71A08AB40._id_CC4CD023F0195D5F = level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352 - _id_B8EBE3F71A08AB40._id_9F274E85B7BBD87F;
    _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_E2AA45E2C6B5DEC1(_id_B8EBE3F71A08AB40._id_9F274E85B7BBD87F, level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352);
    _id_04F6916C4E48CC55(pickupent.instance, _id_FBA0376E0036DE8D);

    if(_id_B8EBE3F71A08AB40._id_09AA953016FACACC == pickupent.instance) {
      _id_B8EBE3F71A08AB40 notify("marked_contract_hacked");
      _id_B8EBE3F71A08AB40 _id_7155A66B3081EACA(_id_FBA0376E0036DE8D.team, _id_FBA0376E0036DE8D);
    }

    _id_B8EBE3F71A08AB40._id_552C9E74F497621F = 0;
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FBA0376E0036DE8D.team, "players");

    foreach(player in _id_E2B2BBD9E6539F11)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F085EAF302A7E140");

    if(istrue(_id_B8EBE3F71A08AB40 _id_1C6066D91AE79A56())) {
      _id_B8EBE3F71A08AB40 _id_AA30A0B07502A038(1);
      return;
    }

    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hacker_phone_contract_hacked", _id_FBA0376E0036DE8D.team, 1, 0.5, undefined, "dx_br_bds4_");
  }
}

_id_6410262ECCC0AB66(time) {
  self endon("task_ended");
  level endon("game_ended");
  thread _id_0FC63C9695ED174C();
  wait(time);
  _id_CD0F560FAD2E9CB6("br_hacker_phone_quest_timer_expired", "hacker_phone_timer_expired", 1.0);
}

_id_0FC63C9695ED174C() {
  self endon("task_ended");
  level endon("game_ended");
  _id_2773522DFBC4D477 = level._id_41F4BC9EE8C7C9C6.activetablets;

  while(_id_2773522DFBC4D477.size >= self._id_CC4CD023F0195D5F) {
    _id_2773522DFBC4D477 = level._id_41F4BC9EE8C7C9C6.activetablets;
    _id_2773522DFBC4D477 = scripts\engine\utility::array_remove_array(_id_2773522DFBC4D477, self._id_2655F1229EA3CB33);
    wait 1;
  }

  _id_CD0F560FAD2E9CB6("br_hacker_phone_quest_failure");
}

_id_CA07A6CA5C3C8AF5(player) {
  if(_id_42A0806457EA8039(player))
    _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
}

_id_F6755BD234F8E261(player) {
  if(_id_42A0806457EA8039(player))
    _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
}

_id_42A0806457EA8039(player) {
  if(player.team == self.teams[0])
    return 1;

  return 0;
}

_id_A2045D8CAF0F792F(attacker, victim) {
  _id_F59B4B0550D4E1E9(victim);
}

_id_319BA124F0EC457C(player) {
  _id_F59B4B0550D4E1E9(player);
}

_id_F59B4B0550D4E1E9(player) {
  if(player.team == self.teams[0]) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.teams[0], level._id_41F4BC9EE8C7C9C6.defaultfilter))
      _id_CD0F560FAD2E9CB6();
  }
}

_id_AFD4BF63773CD7AD(team) {
  if(istrue(self.teams[0] == team))
    _id_CD0F560FAD2E9CB6();
}

_id_CD0F560FAD2E9CB6(_id_F7B6CC6C062A7A43, _id_A7B676ACA5B263C2, _id_27FF0692112DA50C) {
  if(isDefined(_id_F7B6CC6C062A7A43))
    _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], _id_F7B6CC6C062A7A43);

  delay = 0.0;

  if(isDefined(_id_27FF0692112DA50C))
    delay = _id_27FF0692112DA50C;

  if(isDefined(_id_A7B676ACA5B263C2))
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_A7B676ACA5B263C2, self.teams[0], 1, delay, undefined, "dx_br_bds4_");

  thread _id_AA30A0B07502A038(0);
}

_id_1C6066D91AE79A56() {
  if(self._id_9F274E85B7BBD87F >= level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352)
    return 1;

  return 0;
}

_id_AA30A0B07502A038(success) {
  level endon("game_ended");
  self notify("task_ended");
  wait 1.0;
  _id_FABF84450735DD93 = self.teams[0];
  _id_4B223B8DF93235AA(_id_FABF84450735DD93);
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), _id_FABF84450735DD93, undefined));

  if(istrue(success))
    thread _id_4FEE9A98DFED4A76(_id_FABF84450735DD93);
}

_id_4B223B8DF93235AA(_id_FABF84450735DD93) {
  _id_64ACB6CE534155B7::deletequestobjicon();
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(isDefined(player)) {
      player._id_45B8E84DE48BB89F = undefined;
      player setclientomnvar("ui_br_hacker_phone_state", 0);
    }
  }

  foreach(_id_17953215DD7C5F9B in self._id_2655F1229EA3CB33)
  _id_B111C1D13E127B6D(_id_17953215DD7C5F9B, _id_FABF84450735DD93);
}

_id_4FEE9A98DFED4A76(_id_FABF84450735DD93) {
  level endon("game_ended");
  params = spawnStruct();
  params.intvar = level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E;
  _id_64ACB6CE534155B7::displayteamsplash(_id_FABF84450735DD93, "br_hacker_phone_quest_complete", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hacker_phone_complete", _id_FABF84450735DD93, 1, 1.5, undefined, "dx_br_bds4_");
  _id_196E12780ECC8E3B(_id_FABF84450735DD93);

  if(!_id_AAA32AE55C133B06(_id_FABF84450735DD93))
    wait 4;

  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_6C8912EA30B21003 = 1;
  }

  thread _id_305219F2CD4252CE(_id_FABF84450735DD93);
}

_id_AAA32AE55C133B06(_id_FABF84450735DD93) {
  return level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] > 0;
}

_id_305219F2CD4252CE(_id_FABF84450735DD93) {
  lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_payment_hacker_phone"];
  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]++;
  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] = level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E;
  _id_BDCFA4AC81DC3472(_id_FABF84450735DD93, lootid);
  thread _id_40F8341D00EE8BE6(_id_FABF84450735DD93, lootid);
  thread _id_D1FE6AC87F940BFB(_id_FABF84450735DD93);
}

_id_D1FE6AC87F940BFB(_id_FABF84450735DD93) {
  level endon("game_ended");
  wait 0.05;

  for(_id_327EFEB48A68A152 = level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]; _id_327EFEB48A68A152 > 0; _id_327EFEB48A68A152--)
    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);

  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]--;
}

_id_40F8341D00EE8BE6(_id_FABF84450735DD93, lootid) {
  level notify("monitor_payout_" + _id_FABF84450735DD93);
  level endon("monitor_payout_" + _id_FABF84450735DD93);
  level endon("game_ended");
  thread _id_AC7AAAFED966DCFF(_id_FABF84450735DD93);

  while(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] > 0) {
    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
    _id_BDCFA4AC81DC3472(_id_FABF84450735DD93, lootid);
  }
}

_id_BDCFA4AC81DC3472(_id_FABF84450735DD93, lootid) {
  if(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] > 0)
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]--;

  _id_9CDFC15FE821D00C = _id_97FF781643EF7DAF(_id_FABF84450735DD93);
  _id_EC2736524E4A7410 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers");

  foreach(player in _id_EC2736524E4A7410) {
    if(isDefined(player) && _id_9CDFC15FE821D00C > 0 && istrue(player._id_6C8912EA30B21003) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_9CDFC15FE821D00C);

      if(isDefined(lootid)) {
        _id_FBB5190911C15C1B = player getvieworigin();
        player setclientomnvar("ui_br_hacker_phone_remaining_payments", level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]);
        player _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, _id_9CDFC15FE821D00C);
      }

      if(isDefined(player._id_A4DD02E65175E1E7))
        player._id_A4DD02E65175E1E7["totalPayout"] = player._id_A4DD02E65175E1E7["totalPayout"] + _id_9CDFC15FE821D00C * 10;
    }
  }
}

_id_AC7AAAFED966DCFF(_id_FABF84450735DD93) {
  level endon("monitor_payout_" + _id_FABF84450735DD93);
  level endon("game_ended");
  _id_359F2CD3B12BB4CB = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  for(_id_327EFEB48A68A152 = level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]; _id_327EFEB48A68A152 > 0; _id_327EFEB48A68A152--) {
    if(_id_327EFEB48A68A152 == 3) {
      foreach(player in _id_359F2CD3B12BB4CB) {
        if(isDefined(player) && player.team == _id_FABF84450735DD93)
          _id_64ACB6CE534155B7::displayplayersplash(player, "br_hacker_phone_quest_payment_expiring");
      }
    }

    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
  }

  _id_19F022D240A597B9(_id_FABF84450735DD93, 0);

  foreach(player in _id_359F2CD3B12BB4CB) {
    if(isDefined(player) && player.team == _id_FABF84450735DD93)
      _id_64ACB6CE534155B7::displayplayersplash(player, "br_hacker_phone_quest_payment_expired");
  }

  wait 0.05;

  foreach(player in _id_359F2CD3B12BB4CB) {
    if(isDefined(player))
      player._id_6C8912EA30B21003 = undefined;
  }
}

_id_97FF781643EF7DAF(_id_FABF84450735DD93) {
  return level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] * self._id_9CDFC15FE821D00C;
}

_id_34BC4CAEFCDE3120(_id_FABF84450735DD93, _id_C9B0E78500221992) {
  _id_C568C261258FB4E0 = level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"].size + level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"].size;

  if(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"].size < 2) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = scripts\engine\utility::array_add(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992);
    _id_FA76FC991FF22CDB(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], "ui_br_hacked_phones_data1");
  } else {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = scripts\engine\utility::array_add(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992);
    _id_FA76FC991FF22CDB(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

_id_5BBF368BF1A6B402(_id_FABF84450735DD93, _id_C9B0E78500221992) {
  if(scripts\engine\utility::array_contains(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992)) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = scripts\engine\utility::array_remove(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992);
    _id_FA76FC991FF22CDB(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], "ui_br_hacked_phones_data1");
  } else if(scripts\engine\utility::array_contains(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992)) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = scripts\engine\utility::array_remove(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992);
    _id_FA76FC991FF22CDB(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

_id_A3FCFE7472F9C5DB(player, _id_FABF84450735DD93) {
  if(isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"])) {
    _id_081DAB8953B9DF82 = _id_4F0FAE2ECE09D000(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"]);
    player setclientomnvar("ui_br_hacked_phones_data1", _id_081DAB8953B9DF82);
  }

  if(isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"])) {
    _id_081DAB8953B9DF82 = _id_4F0FAE2ECE09D000(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"]);
    player setclientomnvar("ui_br_hacked_phones_data2", _id_081DAB8953B9DF82);
  }
}

_id_196E12780ECC8E3B(_id_FABF84450735DD93) {
  self.dlogdata = [];
  self.dlogdata["totalPayout"] = [];
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(isDefined(player)) {
      _id_8CF0F4E99DCF177B(player, 0, 0, 1);
      player._id_A4DD02E65175E1E7 = [];
      player._id_A4DD02E65175E1E7["totalPayout"] = 0;
      player._id_A4DD02E65175E1E7["payoutValue"] = self._id_9CDFC15FE821D00C * 10;
      scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_A3A8454199EAE9CB);
    }
  }

  thread _id_C5110AE0CAD07145(_id_FABF84450735DD93);
}

_id_19F022D240A597B9(_id_FABF84450735DD93, _id_D1C192F65678CCA7) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  _id_8CF0F4E99DCF177B(player, _id_D1C192F65678CCA7, 0, 0);

  self notify("hackerPhoneDlogSent");
}

_id_8CF0F4E99DCF177B(player, _id_D1C192F65678CCA7, _id_F8B7FD6747AD8F77, _id_1F5B8C9203A2F046) {
  if(isDefined(player) &isarray(player._id_A4DD02E65175E1E7)) {
    player dlog_recordplayerevent("dlog_event_contract_hacker_phone_payment_phase_completion", ["total_payout_value", player._id_A4DD02E65175E1E7["totalPayout"], "cash_per_payout", player._id_A4DD02E65175E1E7["payoutValue"], "stopped_by_match_end", _id_D1C192F65678CCA7, "stopped_by_disconnect", _id_F8B7FD6747AD8F77, "payout_extended", _id_1F5B8C9203A2F046]);
    player._id_A4DD02E65175E1E7 = undefined;
  }
}

_id_A3A8454199EAE9CB(player) {
  _id_8CF0F4E99DCF177B(player, 0, 1, 0);
}

_id_C5110AE0CAD07145(_id_FABF84450735DD93) {
  self endon("hackerPhoneDlogSent");
  level waittill("game_ended");
  _id_19F022D240A597B9(_id_FABF84450735DD93, 1);
}

_id_FA76FC991FF22CDB(_id_FABF84450735DD93, _id_B4A6C7C6C1EC8A4D, _id_939613B9F38207B0) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_081DAB8953B9DF82 = _id_4F0FAE2ECE09D000(_id_B4A6C7C6C1EC8A4D);

  foreach(player in _id_E2B2BBD9E6539F11)
  player setclientomnvar(_id_939613B9F38207B0, _id_081DAB8953B9DF82);
}

_id_4F0FAE2ECE09D000(_id_B4A6C7C6C1EC8A4D) {
  _id_081DAB8953B9DF82 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B4A6C7C6C1EC8A4D.size; _id_AC0E594AC96AA3A8++)
    _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_B4A6C7C6C1EC8A4D[_id_AC0E594AC96AA3A8] << _id_AC0E594AC96AA3A8 * 16);

  return _id_081DAB8953B9DF82;
}

_id_04F6916C4E48CC55(_id_30A99625B9F5D98C, player) {
  if(_id_2FDCB6899DB87A0F(_id_30A99625B9F5D98C, player.team))
    player setclientomnvar("ui_br_hacker_phone_state", 1);
  else if(istrue(player._id_45B8E84DE48BB89F))
    player setclientomnvar("ui_br_hacker_phone_state", 2);
  else {
    player setclientomnvar("ui_br_hacker_phone_state", 0);

    if(_id_30A99625B9F5D98C.tablettype.ref == "hacker_phone")
      player _id_7A1A95A9782F2D03();
  }
}

_id_7A1A95A9782F2D03() {
  _id_6CF4D7026C51235B = _id_7FA77E2DBBD62DB5(self.team);
  _id_4CD71A157CE666C9 = int(level._id_5DDDEDBF2BDA5311._id_982966060D10F80A / level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
  _id_94FDF3291D472947 = _id_6CF4D7026C51235B * _id_4CD71A157CE666C9;
  self setclientomnvar("ui_br_hacker_phone_potential_cash_value", _id_94FDF3291D472947);
}

_id_3D221E16860007D5(_id_FE7BD20E5B3DF7D2, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(istrue(_id_FE7BD20E5B3DF7D2._id_6C8912EA30B21003)) {
    _id_FE7BD20E5B3DF7D2._id_6C8912EA30B21003 = undefined;
    thread _id_7481B64FDDCB07CA(_id_FE7BD20E5B3DF7D2);
  }
}

_id_7481B64FDDCB07CA(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  wait 1;
  _id_64ACB6CE534155B7::displayplayersplash(player, "br_hacker_phone_quest_payment_expired");
}

_id_83D3732A571F142A(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player._id_45B8E84DE48BB89F = undefined;
  player._id_6C8912EA30B21003 = undefined;
  player setclientomnvar("ui_br_hacker_phone_state", 0);

  if(_id_42A0806457EA8039(player))
    _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);

  player setclientomnvar("ui_br_hacked_phones_data1", 0);
  player setclientomnvar("ui_br_hacked_phones_data2", 0);
}

_id_75B53AD947495F9C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_42A0806457EA8039(player)) {
    player._id_45B8E84DE48BB89F = 1;
    player _id_64ACB6CE534155B7::uiobjectiveshow("hacker_phone");
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(self._id_9F274E85B7BBD87F, level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352);
    _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
    _id_A3FCFE7472F9C5DB(player, player.team);
  }
}