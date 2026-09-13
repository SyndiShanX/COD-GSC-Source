/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1193c0b83fce13b.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  if(getdvarint("dvar_191305AD3D7422A8", 1) <= 0) {
    return;
  }
  _id_D21C423660EFCA45();
  _id_58E0D036347FD542 = [];
  _id_633F01F8D61A0608 = getentitylessscriptablearray("brloot_activity_starter_hacker_phone");

  foreach(phone in _id_633F01F8D61A0608) {
    if(_id_C8B12721D3A6C3FC(phone)) {
      origin = phone.origin;
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
      _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);
      struct = spawnStruct();
      struct.origin = origin;
      struct._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
      _id_58E0D036347FD542[_id_58E0D036347FD542.size] = struct;
    }
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_565ACF1A582DF350, _id_58E0D036347FD542);
}

_id_D21C423660EFCA45() {
  level._id_5DDDEDBF2BDA5311 = spawnStruct();
  level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352 = getdvarint("dvar_702EBF4EF0C6F88A", 3);
  level._id_5DDDEDBF2BDA5311._id_576A3B6B02998159 = getdvarint("dvar_046511004C7948DF", 60);
  level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293 = getdvarint("dvar_C767586E70F5452F", 20);
  level._id_5DDDEDBF2BDA5311._id_982966060D10F80A = getdvarint("dvar_330CBE811CD82406", 400);
  level._id_5DDDEDBF2BDA5311._id_88F1BF50C2880F31 = getdvarint("dvar_3326BA811FA9DE92", 0);
  level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E = int(level._id_5DDDEDBF2BDA5311._id_982966060D10F80A / level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_6BDC6F56944DC3AA);
}

_id_565ACF1A582DF350(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_7D55C65124970BDB;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_6EFA8F1AE457E738;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_D151278D57E44CE9;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_4E07EAFA1B6B460C;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_1E8F1B7F3E56D2FC;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_43267367654390F3;
  _id_B8EBE3F71A08AB40.ref = "dmz_hacker_phone";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  return _id_B8EBE3F71A08AB40;
}

_id_7D55C65124970BDB() {
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 25));
}

_id_6EFA8F1AE457E738(_id_FABF84450735DD93) {}

_id_D151278D57E44CE9(player) {
  player._id_45B8E84DE48BB89F = 1;
  player setclientomnvar("ui_br_hacker_phone_state", 2);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
  player _id_64ACB6CE534155B7::uiobjectivesetparameter(self._id_9F274E85B7BBD87F, level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352);
  _id_4F4334AE28F70353(player, player.team);
}

_id_4E07EAFA1B6B460C(player) {
  player._id_45B8E84DE48BB89F = undefined;
  player._id_6C8912EA30B21003 = undefined;
  player setclientomnvar("ui_br_hacker_phone_state", 0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);
  player setclientomnvar("ui_br_hacked_phones_data1", 0);
  player setclientomnvar("ui_br_hacked_phones_data2", 0);
}

_id_43267367654390F3(_id_FABF84450735DD93) {
  _id_D0F1C9A699A0A2D8(_id_FABF84450735DD93);
  _id_688A2ACDD7D9D902();
}

_id_1E8F1B7F3E56D2FC(_id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");
  self._id_9F274E85B7BBD87F = 0;
  self._id_CC4CD023F0195D5F = level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352;
  self._id_9CDFC15FE821D00C = _id_2FBB9E83420CA54B(_id_FABF84450735DD93);
  self._id_2655F1229EA3CB33 = [];

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]))
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] = 0;

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]))
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] = 0;

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"]))
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = [];

  if(!isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"]))
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = [];

  _id_851F0BA242E91378(_id_FABF84450735DD93);
  _id_70FBB5E0989F9E50(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hacker_phone_accept", _id_FABF84450735DD93);
  thread _id_527AC84BFBBBAD44(_id_FABF84450735DD93);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_45B8E84DE48BB89F = 1;
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    _id_03314ADD7998AB13::_id_64623E2FF7409F39(player, 1);
  }

  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hacker_phone_start", _id_FABF84450735DD93, 2);
}

_id_688A2ACDD7D9D902(_id_FABF84450735DD93) {
  if(isDefined(_id_FABF84450735DD93)) {
    _id_D0F1C9A699A0A2D8(_id_FABF84450735DD93);
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hacker_phone_success", _id_FABF84450735DD93, 1.5);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hacker_phone_complete", _id_E2B2BBD9E6539F11, undefined, level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E);
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] = level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E;
    _id_8F0F565D34F52633(_id_FABF84450735DD93);
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!isDefined(player)) {
        continue;
      }
      player._id_6C8912EA30B21003 = 1;
    }

    if(!_id_7586E893298068D4(_id_FABF84450735DD93))
      wait 5.5;

    thread _id_FB296D840951AC58(_id_FABF84450735DD93);
  }

  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_C8B12721D3A6C3FC(node) {
  origin = node.origin;
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
  _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);
  return isDefined(_id_D1CF55B36FACF5A8) && !_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(origin) && !_id_4948CDF739393D2D::_id_F59F68ADC71D49B3(origin) && !_id_57D3850A12CF1D8F::_id_64332F29E2409E55(origin);
}

_id_7586E893298068D4(_id_FABF84450735DD93) {
  return level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] > 0;
}

_id_D0F1C9A699A0A2D8(_id_FABF84450735DD93) {
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(isDefined(player)) {
      player._id_45B8E84DE48BB89F = undefined;
      player setclientomnvar("ui_br_hacker_phone_state", 0);
    }
  }

  foreach(_id_17953215DD7C5F9B in self._id_2655F1229EA3CB33)
  _id_3290C9088F8C4E53(_id_17953215DD7C5F9B, _id_FABF84450735DD93);
}

_id_A232D3C610006843(_id_431A56B37ABA9942, _id_FBA0376E0036DE8D) {
  self endon("death_or_disconnect");

  if(istrue(_id_8BCCCF23DA031467(_id_431A56B37ABA9942.instance, _id_FBA0376E0036DE8D.team))) {
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  _id_FBA0376E0036DE8D _id_6C4E8CEA70BF4B6D::_id_9BE29AD72A155EE1("intel_pickup_phone_alt", 11);
  _id_5198324FF80596D8(_id_431A56B37ABA9942, _id_FBA0376E0036DE8D);
}

_id_5198324FF80596D8(_id_431A56B37ABA9942, _id_FBA0376E0036DE8D) {
  if(istrue(_id_8BCCCF23DA031467(_id_431A56B37ABA9942.instance, _id_FBA0376E0036DE8D.team)))
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
  else {
    _id_B8EBE3F71A08AB40 = _id_03314ADD7998AB13::_id_37416C14E9703FB6(_id_FBA0376E0036DE8D);

    if(!isDefined(_id_B8EBE3F71A08AB40)) {
      return;
    }
    _id_B8EBE3F71A08AB40 _id_105B8F7EBE0AD130(_id_431A56B37ABA9942.instance, _id_FBA0376E0036DE8D.team);
    _id_B8EBE3F71A08AB40._id_2655F1229EA3CB33[_id_B8EBE3F71A08AB40._id_2655F1229EA3CB33.size] = _id_431A56B37ABA9942.instance;
    _id_B8EBE3F71A08AB40._id_9F274E85B7BBD87F++;
    _id_B8EBE3F71A08AB40._id_CC4CD023F0195D5F = level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352 - _id_B8EBE3F71A08AB40._id_9F274E85B7BBD87F;
    _id_B8EBE3F71A08AB40 _id_70FBB5E0989F9E50(_id_FBA0376E0036DE8D.team);
    _id_6A8EC730B2BFA844::_id_8706A89FAE666D51(_id_FBA0376E0036DE8D);
    _id_604A7FC1FB4B6DFD(_id_431A56B37ABA9942.instance, _id_FBA0376E0036DE8D);

    if(_id_B8EBE3F71A08AB40._id_09AA953016FACACC == _id_431A56B37ABA9942.instance) {
      _id_B8EBE3F71A08AB40 notify("marked_contract_hacked");
      _id_B8EBE3F71A08AB40 _id_851F0BA242E91378(_id_FBA0376E0036DE8D.team, _id_FBA0376E0036DE8D);
    }

    _id_B8EBE3F71A08AB40._id_552C9E74F497621F = 0;
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FBA0376E0036DE8D.team, "players");

    foreach(player in _id_E2B2BBD9E6539F11)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F085EAF302A7E140");

    if(istrue(_id_B8EBE3F71A08AB40 _id_171503A34D052B4E())) {
      _id_B8EBE3F71A08AB40 _id_688A2ACDD7D9D902(_id_FBA0376E0036DE8D.team);
      return;
    }

    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hacker_phone_hacked", _id_FBA0376E0036DE8D.team, 1);
  }
}

_id_171503A34D052B4E() {
  if(self._id_9F274E85B7BBD87F >= level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352) {
    self notify("reached_hacked_limit");
    return 1;
  }

  return 0;
}

_id_527AC84BFBBBAD44(_id_FABF84450735DD93) {
  self endon("task_ended");
  level endon("game_ended");
  _id_2773522DFBC4D477 = level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38;

  while(_id_2773522DFBC4D477.size >= self._id_CC4CD023F0195D5F) {
    _id_2773522DFBC4D477 = level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38;
    _id_2773522DFBC4D477 = scripts\engine\utility::array_remove_array(_id_2773522DFBC4D477, self._id_2655F1229EA3CB33);
    wait 1;
  }

  _id_43267367654390F3(_id_FABF84450735DD93);
}

_id_105B8F7EBE0AD130(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(!isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30))
    _id_DB376EE90688810D._id_5E3CC2521BD27A30 = [];

  _id_DB376EE90688810D._id_5E3CC2521BD27A30[_id_DB376EE90688810D._id_5E3CC2521BD27A30.size] = _id_FABF84450735DD93;
  _id_991E730674C3CDD8(_id_FABF84450735DD93, _id_DB376EE90688810D.index);
}

_id_8BCCCF23DA031467(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30)) {
    if(scripts\engine\utility::array_contains(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93))
      return 1;
  }

  return 0;
}

_id_3290C9088F8C4E53(_id_DB376EE90688810D, _id_FABF84450735DD93) {
  if(isDefined(_id_DB376EE90688810D._id_5E3CC2521BD27A30) && scripts\engine\utility::array_contains(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93)) {
    _id_DB376EE90688810D._id_5E3CC2521BD27A30 = scripts\engine\utility::array_remove(_id_DB376EE90688810D._id_5E3CC2521BD27A30, _id_FABF84450735DD93);
    _id_72DB8368F7FFAAFA(_id_FABF84450735DD93, _id_DB376EE90688810D.index);
  }
}

_id_70FBB5E0989F9E50(_id_FABF84450735DD93) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  player _id_64ACB6CE534155B7::uiobjectivesetparameter(self._id_9F274E85B7BBD87F, level._id_5DDDEDBF2BDA5311._id_BE8A6484AED40352);
}

_id_54BB0E15262AC835() {
  if(!isDefined(self.team)) {
    return;
  }
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  _id_6CF4D7026C51235B = _id_2FBB9E83420CA54B(self.team);
  _id_9F870CCAE9510EAB = int(ceil(_id_6C4E8CEA70BF4B6D::_id_8C5476A01AFAB741(self, _id_6C4E8CEA70BF4B6D::_id_DA38BE107AE836FF(_id_6D5ED003AF1F9612, _id_6CF4D7026C51235B))));
  _id_94FDF3291D472947 = _id_9F870CCAE9510EAB * level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E;
  self setclientomnvar("ui_br_hacker_phone_potential_cash_value", _id_94FDF3291D472947);
}

_id_2FBB9E83420CA54B(_id_FABF84450735DD93) {
  _id_6CF4D7026C51235B = level._id_5DDDEDBF2BDA5311._id_576A3B6B02998159;

  if(istrue(level._id_5DDDEDBF2BDA5311._id_88F1BF50C2880F31)) {
    _id_926316044E93F849 = getDvar("dvar_A38ED422CBF98056", "60 45 30 15");
    _id_21E6C4EB825D874D = strtok(_id_926316044E93F849, " ");
    _id_652F47620AC4713F = int(min(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93), _id_21E6C4EB825D874D.size));
    _id_6CF4D7026C51235B = _id_21E6C4EB825D874D[_id_652F47620AC4713F - 1];
  }

  return int(_id_6CF4D7026C51235B);
}

_id_CFB5D79CFE8C03A9(_id_FABF84450735DD93) {
  return level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"] * self._id_9CDFC15FE821D00C;
}

_id_FB296D840951AC58(_id_FABF84450735DD93) {
  level endon("game_ended");
  lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_payment_hacker_phone"];
  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]++;
  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] = level._id_5DDDEDBF2BDA5311._id_D6B7C0CB8162CD8E;
  _id_53FCF5791CA038A0(_id_FABF84450735DD93, lootid);
  thread _id_725C819DA2F98664(_id_FABF84450735DD93, lootid);
  thread _id_624D73A636EEFFED(_id_FABF84450735DD93);
}

_id_725C819DA2F98664(_id_FABF84450735DD93, lootid) {
  level notify("monitor_payout_" + _id_FABF84450735DD93);
  level endon("monitor_payout_" + _id_FABF84450735DD93);
  level endon("game_ended");
  thread _id_E387A70C3E4E731D(_id_FABF84450735DD93);

  while(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] > 0) {
    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
    _id_53FCF5791CA038A0(_id_FABF84450735DD93, lootid);
  }
}

_id_624D73A636EEFFED(_id_FABF84450735DD93) {
  level endon("game_ended");
  wait 0.5;

  for(_id_327EFEB48A68A152 = level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]; _id_327EFEB48A68A152 > 0; _id_327EFEB48A68A152--)
    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);

  level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentCountActive"]--;
}

_id_53FCF5791CA038A0(_id_FABF84450735DD93, lootid) {
  if(level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"] > 0)
    level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]--;

  _id_EC2736524E4A7410 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers");

  if(!_id_EC2736524E4A7410.size) {
    return;
  }
  _id_9CDFC15FE821D00C = _id_CFB5D79CFE8C03A9(_id_FABF84450735DD93);
  _id_1DD0F3DFB99017D1 = _id_6C4E8CEA70BF4B6D::_id_DA38BE107AE836FF(_id_EC2736524E4A7410, _id_9CDFC15FE821D00C);

  foreach(player in _id_EC2736524E4A7410) {
    if(isDefined(player) && _id_1DD0F3DFB99017D1 > 0 && istrue(player._id_6C8912EA30B21003)) {
      _id_9F870CCAE9510EAB = int(ceil(_id_6C4E8CEA70BF4B6D::_id_8C5476A01AFAB741(player, _id_1DD0F3DFB99017D1)));
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_9F870CCAE9510EAB);

      if(isDefined(lootid)) {
        _id_FBB5190911C15C1B = player getvieworigin();
        player setclientomnvar("ui_br_hacker_phone_remaining_payments", level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]);
        player _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, _id_9F870CCAE9510EAB);
      }

      if(isDefined(player._id_A4DD02E65175E1E7))
        player._id_A4DD02E65175E1E7["totalPayout"] = player._id_A4DD02E65175E1E7["totalPayout"] + _id_9F870CCAE9510EAB * 10;

      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "passive_income_payment", 1);
    }
  }
}

_id_E387A70C3E4E731D(_id_FABF84450735DD93) {
  level endon("monitor_payout_" + _id_FABF84450735DD93);
  level endon("game_ended");
  _id_9C231835BE3C8312 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  for(_id_327EFEB48A68A152 = level.teamdata[_id_FABF84450735DD93]["hackerPhonePaymentsRemaining"]; _id_327EFEB48A68A152 > 0; _id_327EFEB48A68A152--) {
    if(_id_327EFEB48A68A152 == 3) {
      foreach(player in _id_9C231835BE3C8312) {
        if(isDefined(player) && player.team == _id_FABF84450735DD93)
          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hacker_phone_expiring", [player]);
      }
    }

    wait(level._id_5DDDEDBF2BDA5311._id_C669E317F1FD1293);
  }

  foreach(player in _id_9C231835BE3C8312) {
    if(isDefined(player) && player.team == _id_FABF84450735DD93)
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hacker_phone_expired", [player]);
  }

  wait 0.5;

  foreach(player in _id_9C231835BE3C8312) {
    if(isDefined(player))
      player._id_6C8912EA30B21003 = undefined;
  }

  _id_EC032BED730022D1(_id_FABF84450735DD93, 0);
}

_id_604A7FC1FB4B6DFD(_id_30A99625B9F5D98C, player) {
  if(_id_8BCCCF23DA031467(_id_30A99625B9F5D98C, player.team))
    player setclientomnvar("ui_br_hacker_phone_state", 1);
  else if(istrue(player._id_45B8E84DE48BB89F))
    player setclientomnvar("ui_br_hacker_phone_state", 2);
  else {
    player setclientomnvar("ui_br_hacker_phone_state", 0);

    if(_id_30A99625B9F5D98C._id_EFA8EF05B190D7D0.type == "hacker_phone")
      player _id_54BB0E15262AC835();
  }
}

_id_991E730674C3CDD8(_id_FABF84450735DD93, _id_C9B0E78500221992) {
  _id_C568C261258FB4E0 = level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"].size + level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"].size;

  if(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"].size < 2) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = scripts\engine\utility::array_add(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992);
    _id_1ED7C25EBA401809(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], "ui_br_hacked_phones_data1");
  } else {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = scripts\engine\utility::array_add(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992);
    _id_1ED7C25EBA401809(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

_id_72DB8368F7FFAAFA(_id_FABF84450735DD93, _id_C9B0E78500221992) {
  if(scripts\engine\utility::array_contains(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992)) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"] = scripts\engine\utility::array_remove(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], _id_C9B0E78500221992);
    _id_1ED7C25EBA401809(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"], "ui_br_hacked_phones_data1");
  } else if(scripts\engine\utility::array_contains(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992)) {
    level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"] = scripts\engine\utility::array_remove(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], _id_C9B0E78500221992);
    _id_1ED7C25EBA401809(_id_FABF84450735DD93, level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

_id_4F4334AE28F70353(player, _id_FABF84450735DD93) {
  if(isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"])) {
    _id_081DAB8953B9DF82 = _id_02F03A84E3419528(level.teamdata[_id_FABF84450735DD93]["hackedContractsData1"]);
    player setclientomnvar("ui_br_hacked_phones_data1", _id_081DAB8953B9DF82);
  }

  if(isDefined(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"])) {
    _id_081DAB8953B9DF82 = _id_02F03A84E3419528(level.teamdata[_id_FABF84450735DD93]["hackedContractsData2"]);
    player setclientomnvar("ui_br_hacked_phones_data2", _id_081DAB8953B9DF82);
  }
}

_id_1ED7C25EBA401809(_id_FABF84450735DD93, _id_B4A6C7C6C1EC8A4D, _id_939613B9F38207B0) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_081DAB8953B9DF82 = _id_02F03A84E3419528(_id_B4A6C7C6C1EC8A4D);

  foreach(player in _id_E2B2BBD9E6539F11)
  player setclientomnvar(_id_939613B9F38207B0, _id_081DAB8953B9DF82);
}

_id_02F03A84E3419528(_id_B4A6C7C6C1EC8A4D) {
  _id_081DAB8953B9DF82 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B4A6C7C6C1EC8A4D.size; _id_AC0E594AC96AA3A8++)
    _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_B4A6C7C6C1EC8A4D[_id_AC0E594AC96AA3A8] << _id_AC0E594AC96AA3A8 * 16);

  return _id_081DAB8953B9DF82;
}

_id_5D4530EBFA3DA544(player) {
  if(level.teamdata[player.team]["hackerPhonePaymentCountActive"] > 1)
    return "br_pickup_cash_med_01";
  else
    return "br_pickup_cash_01";
}

_id_851F0BA242E91378(_id_FABF84450735DD93, _id_FBA0376E0036DE8D) {
  _id_7CA287A82F54E4F6 = self._id_EFA8EF05B190D7D0._id_7CA287A82F54E4F6;

  if(isDefined(_id_FBA0376E0036DE8D))
    _id_7CA287A82F54E4F6 = _id_FBA0376E0036DE8D;

  _id_3D397B9A8D8CCDE2 = _id_D81544C3289CE882(_id_7CA287A82F54E4F6, _id_FABF84450735DD93);
  thread _id_F27B2D13F59D7978(_id_3D397B9A8D8CCDE2, _id_FABF84450735DD93);
}

_id_D81544C3289CE882(_id_7CA287A82F54E4F6, _id_FABF84450735DD93) {
  _id_6D1F29B3B0161959 = self.node.origin;

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

  foreach(_id_92709BF054B20C5D in level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) {
    if(!isDefined(_id_92709BF054B20C5D) || !isDefined(_id_92709BF054B20C5D.origin)) {
      continue;
    }
    _id_FACF33F7F7AE6BCD[_id_FACF33F7F7AE6BCD.size] = _id_92709BF054B20C5D;
  }

  _id_FACF33F7F7AE6BCD = sortbydistance(_id_FACF33F7F7AE6BCD, _id_6D1F29B3B0161959);
  _id_FACF33F7F7AE6BCD = scripts\engine\utility::array_remove_array(_id_FACF33F7F7AE6BCD, self._id_2655F1229EA3CB33);

  if(isDefined(_id_FACF33F7F7AE6BCD) && _id_FACF33F7F7AE6BCD.size > 0) {
    foreach(phone in _id_FACF33F7F7AE6BCD) {
      if(_id_C8B12721D3A6C3FC(phone)) {
        _id_91780ADF8743A1D5(phone);
        return phone;
      }
    }
  }
}

_id_F27B2D13F59D7978(_id_4A84DD415B837DE9, _id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("marked_contract_hacked");

  if(!isDefined(_id_4A84DD415B837DE9)) {
    return;
  }
  _id_565DA6844875937A = _id_4A84DD415B837DE9 getscriptablehaspart("brloot_activity_starter");

  if(!_id_565DA6844875937A) {
    return;
  }
  self._id_552C9E74F497621F = 0;

  while(!istrue(_id_171503A34D052B4E())) {
    if(_id_4A84DD415B837DE9 getscriptablepartstate("brloot_activity_starter") == "hidden" || self._id_552C9E74F497621F >= 90) {
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hacker_phone_nag", _id_FABF84450735DD93, 0);
      self._id_552C9E74F497621F = 0;
      _id_4A84DD415B837DE9 = _id_D81544C3289CE882(self._id_EFA8EF05B190D7D0._id_7CA287A82F54E4F6, _id_FABF84450735DD93);
    }

    self._id_552C9E74F497621F++;
    wait 1;
  }
}

_id_91780ADF8743A1D5(_id_DB376EE90688810D) {
  if(isDefined(self._id_09AA953016FACACC) && self._id_09AA953016FACACC == _id_DB376EE90688810D) {
    return;
  }
  _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(_id_DB376EE90688810D.origin + (0, 0, 25));
  self._id_09AA953016FACACC = _id_DB376EE90688810D;
}

_id_8F0F565D34F52633(_id_FABF84450735DD93) {
  self.dlogdata = [];
  self.dlogdata["totalPayout"] = [];
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(isDefined(player)) {
      _id_6EC01DD217D2FF03(player, 0, 0, 1);
      player._id_A4DD02E65175E1E7 = [];
      player._id_A4DD02E65175E1E7["totalPayout"] = 0;
      player._id_A4DD02E65175E1E7["payoutValue"] = self._id_9CDFC15FE821D00C * 10;
      scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_3205795847561BE3);
    }
  }

  thread _id_89FBD9BB7207A48D(_id_FABF84450735DD93);
}

_id_EC032BED730022D1(_id_FABF84450735DD93, _id_D1C192F65678CCA7) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  _id_6EC01DD217D2FF03(player, _id_D1C192F65678CCA7, 0, 0);

  self notify("hackerPhoneDlogSent");
}

_id_3205795847561BE3(player) {
  _id_6EC01DD217D2FF03(player, 0, 1, 0);
}

_id_89FBD9BB7207A48D(_id_FABF84450735DD93) {
  level endon("hackerPhoneDlogSent");
  level waittill("game_ended");
  _id_EC032BED730022D1(_id_FABF84450735DD93, 1);
}

_id_6EC01DD217D2FF03(player, _id_D1C192F65678CCA7, _id_F8B7FD6747AD8F77, _id_1F5B8C9203A2F046) {
  if(isDefined(player) &isarray(player._id_A4DD02E65175E1E7)) {
    player dlog_recordplayerevent("dlog_event_contract_hacker_phone_payment_phase_completion", ["total_payout_value", player._id_A4DD02E65175E1E7["totalPayout"], "cash_per_payout", player._id_A4DD02E65175E1E7["payoutValue"], "stopped_by_match_end", _id_D1C192F65678CCA7, "stopped_by_disconnect", _id_F8B7FD6747AD8F77, "payout_extended", _id_1F5B8C9203A2F046]);
    player._id_A4DD02E65175E1E7 = undefined;
  }
}

_id_6BDC6F56944DC3AA(_id_FE7BD20E5B3DF7D2, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(istrue(_id_FE7BD20E5B3DF7D2._id_6C8912EA30B21003)) {
    _id_FE7BD20E5B3DF7D2._id_6C8912EA30B21003 = undefined;
    thread _id_7113E9264646A968(_id_FE7BD20E5B3DF7D2);
  }
}

_id_7113E9264646A968(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  wait 1;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hacker_phone_expired", [player]);
}