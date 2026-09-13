/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_payphone.gsc
************************************************************************/

main() {
  thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  init();
}

init() {
  if(!getdvarint("dvar_236DD39B0BA8FC3A", 0)) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("sealion_sidequest_safe", ::_id_26E21CE9A398EC4E);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("radio_usable", ::_id_599AD985EE08E1A1);
  level._id_1E1465ED69F27C94 = spawnStruct();
  level._id_1E1465ED69F27C94 _id_618A1163576C3819();
  level._id_1E1465ED69F27C94 _id_B84C15EE0AD25853();
  _id_D9C64C99BD5F47A0();
  level thread init_ai();
  level._id_1E1465ED69F27C94 thread _id_9D99A6B3C18A711C();
}

_id_618A1163576C3819() {
  self._id_6AC0F5E120368CA8 = [];
  self._id_8521B23EDF1F6321 = [];
  self._id_2101893E01B000F1 = 0;
  self._id_587BD29B0DE8B1D7 = [];
  self._id_E4B9B55EF09D4F53 = 0;
  self._id_D7F93C5DFB5F6567 = 40000;
  self._id_D9B390F2FFDE5B6B = getdvarint("dvar_70CE6CEAEEAD6AF5", 0);
  self._id_1470FC377D0EC166 = getdvarint("dvar_D0294E841EA60B85", 3);
  self._id_6E1752181686BB08 = getdvarint("dvar_F996F686C2BFFC26", 2);
  self._id_4ECEC7F761D7DCF2 = getdvarint("dvar_F7E697370FA2C400", 6);
  self._id_A3B9D8B38A35C12B = getdvarint("dvar_98A7EE41C2FF981D", 5);
  self._id_5C0438DA2377156B = getdvarint("dvar_5AD766BAE1BDEF02", 500);
  self._id_9EEC6F98A6B2F36F = getdvarint("dvar_7B6F41DC7C00572D", 16000);
  self._id_695CD7C3788EB91D = getdvarint("dvar_5DE732618F05F557", 8000);
  self._id_10EFB3AB897956BA = getdvarint("dvar_6C55A4D2F1BF9B71", 120);
  self._id_DA7AA0A251FDDD99 = getdvarint("dvar_2D9E06A4CC214A86", 6);
  self._id_6D51EAC6A865821B = getdvarint("dvar_417FE8B25559E7D1", 2);
  self._id_B4EFADFE79073356 = getdvarint("dvar_42DE28A7BBA30D03", 0);
  self._id_80134647909FD865 = getdvarint("dvar_9DB8522384642EFC", 0);
  self._id_BB47140EB0120D01 = getdvarint("dvar_0CD06F0479ED5C78", 180);
  self._id_087B730CF496CA00 = getdvarint("dvar_FD696E036C7EA3E3", 0);
  self._id_B22FE78CB138CBD1 = getdvarint("dvar_A50050AE81364447", 1);
  self._id_484CC38726DE1DC2 = getdvarint("dvar_353E68C753DB4E05", 120);
}

_id_B84C15EE0AD25853() {
  if(level.mapname == "mp_br_hms_mechanics") {
    _id_978010E1BA6200A6((-700, -1100, 0), (0, 180, 0), (-700, -1050, 0), (0, 180, 0));
    _id_978010E1BA6200A6((-1200, 100, 0), (0, 90, 0), (-1150, 100, 0), (0, 90, 0));
    _id_978010E1BA6200A6((-900, -800, 0), (0, 0, 0), (-900, -850, 0), (0, 0, 0));
    _id_978010E1BA6200A6((300, 400, 0), (0, 270, 0), (250, 400, 0), (0, 270, 0));
    _id_978010E1BA6200A6((-800, 50, 0), (0, 180, 0), (-800, 100, 0), (0, 180, 0));
    _id_978010E1BA6200A6((300, -150, 0), (0, 90, 0), (300, -200, 0), (0, 90, 0));
    _id_978010E1BA6200A6((-400, 300, 0), (0, 180, 0), (-350, 300, 0), (0, 180, 0));
    _id_978010E1BA6200A6((-200, -1050, 0), (0, 0, 0), (-200, -1100, 0), (0, 0, 0));
  } else if(level.mapname == "mp_br_mechanics") {
    _id_978010E1BA6200A6((-700, -1100, 0), (0, 180, 0), (-700, -1050, 0), (0, 180, 0));
    _id_978010E1BA6200A6((-1200, 100, 0), (0, 90, 0), (-1150, 100, 0), (0, 90, 0));
    _id_978010E1BA6200A6((-900, -800, 0), (0, 0, 0), (-900, -850, 0), (0, 0, 0));
    _id_978010E1BA6200A6((300, 400, 0), (0, 270, 0), (250, 400, 0), (0, 270, 0));
    _id_978010E1BA6200A6((-800, 50, 0), (0, 180, 0), (-800, 100, 0), (0, 180, 0));
    _id_978010E1BA6200A6((300, -150, 0), (0, 90, 0), (300, -200, 0), (0, 90, 0));
    _id_978010E1BA6200A6((-400, 300, 0), (0, 180, 0), (-350, 300, 0), (0, 180, 0));
    _id_978010E1BA6200A6((-200, -1050, 0), (0, 0, 0), (-200, -1100, 0), (0, 0, 0));
  } else if(level.mapname == "mp_sealion") {
    _id_978010E1BA6200A6((2352.6, -8014, 1251.5), (0, -45, -90), (2325, -8526, 1182), (0, 45, 0), "castle");
    _id_978010E1BA6200A6((6044, -6052, 680.5), (0, 30, -90), (5838, -6141, 644), (0, 22.5, 0), "residential");
    _id_978010E1BA6200A6((1605, -1499, 1186.5), (0, 0, -60), (2158, -1701, 974), (0, 180, 0), "powerplant");
    _id_978010E1BA6200A6((3998.45, 6927, 658.5), (0, -100, -15), (3994, 7272, 612), (0, 235, 0), "greenhouses");
    _id_978010E1BA6200A6((-915, 7108, 402.5), (0, 215, -90), (-1159, 7220, 376), (0, 60, 0), "ferry");
    _id_978010E1BA6200A6((-5481.45, -8, 564.49), (0, 100, -10), (-5109, -34, 528), (0, 10, 0), "hotel");
    _id_978010E1BA6200A6((-10627, 1864, 488.6), (0, 30, -90), (-10704, 2400, 464), (0, 10, 0), "aquarium");
    _id_978010E1BA6200A6((-9321, -7882, 677.8), (0, 0, -90), (-8944, -7472, 512), (0, 120, 0), "port");
    _id_978010E1BA6200A6((-2832, -14841, 378.9), (0, 80, -90), (-2731.5, -14410, 344.6), (0, 311, 0), "shipwreck");
  } else
    return;

  thread _id_F7AA6C453B913884();
}

_id_978010E1BA6200A6(_id_CA8BA7C130852FCC, _id_195CA1FA72E567EB, _id_2A438B0332B8A143, _id_F7E895F013BFE634, _id_8F3CECEFC2DE967C) {
  phone = spawnStruct();
  phone.chosen = 0;
  phone.pos = _id_CA8BA7C130852FCC;
  phone.angles = _id_195CA1FA72E567EB;
  phone.scriptable = spawnscriptable("sealion_sidequest_payphone_radio", phone.pos, phone.angles);
  phone._id_2A438B0332B8A143 = _id_2A438B0332B8A143;
  phone._id_F7E895F013BFE634 = _id_F7E895F013BFE634;
  phone._id_9D42D8CFFEF859FB = undefined;
  phone._id_8F3CECEFC2DE967C = _id_8F3CECEFC2DE967C;
  self._id_8521B23EDF1F6321 = scripts\engine\utility::array_add(self._id_8521B23EDF1F6321, phone);
}

_id_F7AA6C453B913884() {
  if(isDefined(level.br_circle_disabled) && !level.br_circle_disabled && !self._id_B4EFADFE79073356) {
    level waittill("br_circle_set");
    _id_5420853E4D98E1D9();
    _id_688660459617D212();

    if(isDefined(self._id_8521B23EDF1F6321[0])) {
      self._id_6AC0F5E120368CA8[0] = self._id_8521B23EDF1F6321[0];
      self._id_6AC0F5E120368CA8[0].chosen = 1;
    } else
      return;
  } else {
    self._id_6AC0F5E120368CA8[0] = scripts\engine\utility::_id_7A2AAA4A09A4D250(self._id_8521B23EDF1F6321);
    self._id_6AC0F5E120368CA8[0].chosen = 1;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_1470FC377D0EC166 - 1; _id_AC0E594AC96AA3A8++) {
    _id_089F526D26E31878 = _id_9E4CF26943012959(self._id_6AC0F5E120368CA8[_id_AC0E594AC96AA3A8]);

    if(isDefined(_id_089F526D26E31878)) {
      _id_089F526D26E31878.chosen = 1;
      self._id_6AC0F5E120368CA8[self._id_6AC0F5E120368CA8.size] = _id_089F526D26E31878;
      continue;
    }

    return;
  }

  self._id_6AC0F5E120368CA8 = scripts\engine\utility::array_reverse(self._id_6AC0F5E120368CA8);
  self._id_6AC0F5E120368CA8[0] thread _id_6ED39B802DC6B2BA();
  self._id_54A673FB273FC459 = self._id_6AC0F5E120368CA8[self._id_6AC0F5E120368CA8.size - 1];
  self._id_A05DE526305693E5 = spawnscriptable("sealion_sidequest_safe", self._id_54A673FB273FC459._id_2A438B0332B8A143, self._id_54A673FB273FC459._id_F7E895F013BFE634);
}

_id_D9C64C99BD5F47A0() {
  game["dialog"]["sealion_payphone_castle_command"] = "phnc_rcvc_phca";
  game["dialog"]["sealion_payphone_castle_ground"] = "phnc_rgvc_phca";
  game["dialog"]["sealion_payphone_residential_command"] = "phnc_rcvc_phrs";
  game["dialog"]["sealion_payphone_residential_ground"] = "phnc_rgvc_phrs";
  game["dialog"]["sealion_payphone_powerplant_command"] = "phnc_rcvc_phpp";
  game["dialog"]["sealion_payphone_powerplant_ground"] = "phnc_rgvc_phpp";
  game["dialog"]["sealion_payphone_greenhouses_command"] = "phnc_rcvc_phgh";
  game["dialog"]["sealion_payphone_greenhouses_ground"] = "phnc_rgvc_phgh";
  game["dialog"]["sealion_payphone_ferry_command"] = "phnc_rcvc_phfr";
  game["dialog"]["sealion_payphone_ferry_ground"] = "phnc_rgvc_phfr";
  game["dialog"]["sealion_payphone_hotel_command"] = "phnc_rcvc_phht";
  game["dialog"]["sealion_payphone_hotel_ground"] = "phnc_rgvc_phht";
  game["dialog"]["sealion_payphone_aquarium_command"] = "phnc_rcvc_phaq";
  game["dialog"]["sealion_payphone_aquarium_ground"] = "phnc_rgvc_phaq";
  game["dialog"]["sealion_payphone_port_command"] = "phnc_rcvc_phpt";
  game["dialog"]["sealion_payphone_port_ground"] = "phnc_rgvc_phpt";
  game["dialog"]["sealion_payphone_shipwreck_command"] = "phnc_rcvc_phsw";
  game["dialog"]["sealion_payphone_shipwreck_ground"] = "phnc_rgvc_phsw";
  game["dialog"]["sealion_payphone_ambush_command"] = "phnc_rcvc_pham";
  game["dialog"]["sealion_payphone_ambush_ground"] = "phnc_rgvc_pham";
}

init_ai() {
  level endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_48814951E916AF89::_id_BA4022744DCE59F6("sidequest_payphone", level._id_1E1465ED69F27C94._id_DA7AA0A251FDDD99);
  _id_252FA7D2B1B1B50B::_id_B146E2B40516B668("sidequest_payphone");
}

_id_9D99A6B3C18A711C() {
  _id_88D7A2B341D3E3D7 = [];
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_offhand_advancedsupplydrop";
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = _id_14183DF6F9AF8737::_id_53382489FF523151();
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_super_munitionsbox";
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_super_armorbox";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.maxteamsize; _id_AC0E594AC96AA3A8++)
    _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_plunder_cash_epic_1";

  self._id_F8C903F8D6D4E353 = _id_88D7A2B341D3E3D7;
}

_id_6ED39B802DC6B2BA() {
  level notify("phone_stop_ringing");
  level endon("phone_stop_ringing");

  if(self != level._id_1E1465ED69F27C94._id_6AC0F5E120368CA8[0]) {
    _id_066A800A4D7E9B7A = randomintrange(level._id_1E1465ED69F27C94._id_6E1752181686BB08, level._id_1E1465ED69F27C94._id_4ECEC7F761D7DCF2);
    wait(_id_066A800A4D7E9B7A);
  } else if(level._id_1E1465ED69F27C94._id_80134647909FD865)
    wait(level._id_1E1465ED69F27C94._id_BB47140EB0120D01);

  self.scriptable setscriptablepartstate("radio_usable", "usable");

  for(;;) {
    self.scriptable setscriptablepartstate("radio_sfx", "radio_sfx_play");
    waitframe();
    self.scriptable setscriptablepartstate("radio_sfx", "inactive");
    wait(level._id_1E1465ED69F27C94._id_A3B9D8B38A35C12B);
  }
}

_id_599AD985EE08E1A1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_6AC0F5E120368CA8 = level._id_1E1465ED69F27C94._id_6AC0F5E120368CA8;
  _id_2101893E01B000F1 = level._id_1E1465ED69F27C94._id_2101893E01B000F1;
  instance setscriptablepartstate("radio_usable", "inactive");
  _id_F0FA3B7B27926553 = _func_1823FF50BB28148D("sealion_sq_payphone_answer");
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0FA3B7B27926553);
  _id_2101893E01B000F1++;

  if(_id_2101893E01B000F1 != level._id_1E1465ED69F27C94._id_1470FC377D0EC166 && isDefined(_id_6AC0F5E120368CA8[_id_2101893E01B000F1])) {
    level._id_1E1465ED69F27C94 thread _id_60F520C87B4ED8DC(_id_6AC0F5E120368CA8[_id_2101893E01B000F1], player.team);
    _id_6AC0F5E120368CA8[_id_2101893E01B000F1] thread _id_6ED39B802DC6B2BA();

    if(_id_2101893E01B000F1 == level._id_1E1465ED69F27C94._id_1470FC377D0EC166 - 1 && level._id_1E1465ED69F27C94._id_D9B390F2FFDE5B6B == 1)
      level._id_1E1465ED69F27C94 thread _id_B218145CE9781425();
  } else if(_id_2101893E01B000F1 == level._id_1E1465ED69F27C94._id_1470FC377D0EC166 && level._id_1E1465ED69F27C94._id_D9B390F2FFDE5B6B == 0) {
    level._id_1E1465ED69F27C94 thread _id_60F520C87B4ED8DC(undefined, player.team);
    level notify("phone_stop_ringing");

    if(!level._id_1E1465ED69F27C94._id_087B730CF496CA00)
      wait 4;

    level._id_1E1465ED69F27C94 encounter_start();
  } else {}

  level._id_1E1465ED69F27C94._id_6AC0F5E120368CA8 = _id_6AC0F5E120368CA8;
  level._id_1E1465ED69F27C94._id_2101893E01B000F1 = _id_2101893E01B000F1;
}

_id_60F520C87B4ED8DC(phone, team) {
  soundalias = undefined;
  _id_171F90B9C4C76D44 = "ambush";

  if(isDefined(phone))
    _id_171F90B9C4C76D44 = phone._id_8F3CECEFC2DE967C;

  if(scripts\engine\utility::cointoss() || _id_171F90B9C4C76D44 == "ambush")
    soundalias = "sealion_payphone_" + _id_171F90B9C4C76D44 + "_command";
  else
    soundalias = "sealion_payphone_" + _id_171F90B9C4C76D44 + "_ground";

  if(isDefined(soundalias) && isDefined(team))
    _id_05C607EF7F46F361::_id_F676AFAFAF3764F2(soundalias, team, 1, 1);
}

_id_B218145CE9781425() {
  for(;;) {
    nearby_players = scripts\mp\utility\player::getplayersinradius(self._id_54A673FB273FC459.pos, self._id_5C0438DA2377156B);

    if(isDefined(nearby_players) && nearby_players.size > 0) {
      break;
    }

    wait 0.5;
  }

  self._id_54A673FB273FC459.scriptable setscriptablepartstate("radio_usable", "inactive");
  encounter_start();
}

encounter_start() {
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_C567FCD308CABE78);
  params = spawnStruct();
  params._id_AAC993A0C1361744 = "sidequest_payphone";
  params._id_6ADBAF8D10937E14 = "medium";
  params._id_15D6C88336DEBDF4 = 1;
  _id_DD4F509B9C56C76F = _id_A1CFBD2F6488717B(self._id_DA7AA0A251FDDD99, self._id_6D51EAC6A865821B);
  _id_D3F7AA273DCDAAD9(_id_DD4F509B9C56C76F, ["para"], params);
}

_id_A1CFBD2F6488717B(_id_1EAFFE65673CF616, _id_B394BFDB1010B2CD) {
  _id_DD4F509B9C56C76F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1EAFFE65673CF616; _id_AC0E594AC96AA3A8++) {
    tier = 1;

    if(_id_AC0E594AC96AA3A8 < _id_B394BFDB1010B2CD)
      tier = 2;

    _id_4C3337129231E244 = _id_48814951E916AF89::_id_ED108FF3EB578327("guard", tier);
    _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF(_id_4C3337129231E244, tier);
  }

  return _id_DD4F509B9C56C76F;
}

_id_D3F7AA273DCDAAD9(_id_DD4F509B9C56C76F, _id_38EC12043600CBE0, params) {
  agents = [];
  _id_8FA1CEBFA2E413E0 = [];
  _id_9F74717E76B293CC = 3;
  _id_BA5EA72C8AEE781E = 0;

  if(self._id_087B730CF496CA00)
    agents = _id_252FA7D2B1B1B50B::_id_4E0244F0C1AB5067(self._id_A05DE526305693E5.origin, _id_DD4F509B9C56C76F, _id_38EC12043600CBE0, params);

  if(agents.size <= 0) {
    group_name = _id_48814951E916AF89::_id_78759441C259F58A();
    _id_F96E9372BF4D85EB = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self._id_A05DE526305693E5.origin);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DD4F509B9C56C76F.size; _id_AC0E594AC96AA3A8++) {
      _id_4C3337129231E244 = _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_4C3337129231E244;

      if(!isDefined(_id_4C3337129231E244))
        _id_4C3337129231E244 = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type, _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier, _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED);

      for(;;) {
        waitframe();
        _id_BA5EA72C8AEE781E++;
        _id_273A7E688CEC3E10 = _id_355344431F4446E4();

        if(isDefined(_id_273A7E688CEC3E10)) {
          _id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8] = _id_273A7E688CEC3E10;
          break;
        }

        if(_id_BA5EA72C8AEE781E == _id_9F74717E76B293CC) {
          _id_BA5EA72C8AEE781E = 0;
          break;
        }
      }

      if(!isDefined(_id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8]))
        _id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8] = _id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8 - 1];

      if(!isDefined(_id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8])) {
        agents = _id_252FA7D2B1B1B50B::_id_4E0244F0C1AB5067(self._id_A05DE526305693E5.origin, _id_DD4F509B9C56C76F, _id_38EC12043600CBE0, params);
        break;
      } else {
        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_4C3337129231E244, _id_8FA1CEBFA2E413E0[_id_AC0E594AC96AA3A8], (0, 0, 0), "medium", "sidequest_payphone", undefined, group_name, undefined, undefined, _id_F96E9372BF4D85EB, 1, 0, 0, undefined, 0);

        if(isDefined(agent)) {
          agents[agents.size] = agent;

          if(isagent(agent)) {
            agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256, _id_514E0C3E9F3FCEFF());
            thread _id_ECBABC6EB922E267(agent);
          }
        }
      }
    }
  }

  foreach(agent in agents) {
    agent.baseaccuracy = 0.4;
    agent.accuracy = agent.baseaccuracy;
    agent.maxsightdistsqrd = squared(1000);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropGrenade", 0);
  }

  self._id_587BD29B0DE8B1D7 = agents;
}

_id_A5E1636E3B1950B8(player) {
  if(!self._id_E4B9B55EF09D4F53) {
    wait 2;
    self._id_A05DE526305693E5 setscriptablepartstate("sealion_sidequest_safe", "closed_usable");

    foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
      if(isDefined(_id_B2810E8D06E0A042) && isalive(_id_B2810E8D06E0A042) && !_id_B2810E8D06E0A042 _id_2CEDCC356F1B9FC8::isplayeringulag())
        _id_B2810E8D06E0A042 thread scripts\mp\hud_message::showsplash("br_sealion_sidequest_payphone_success", undefined, undefined, undefined, undefined, "splash_list_br_sealion_sidequest_payphone");
    }

    wait 1;
    self._id_0B028CCD9DA8A536 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(self._id_0B028CCD9DA8A536 > -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(self._id_0B028CCD9DA8A536, "current", self._id_A05DE526305693E5.origin, "ui_map_icon_obj_sealion_sidequest_reward");

      if(isDefined(player.team)) {
        objective_removeallfrommask(self._id_0B028CCD9DA8A536);
        objective_showtoplayersinmask(self._id_0B028CCD9DA8A536);
        objective_addteamtomask(self._id_0B028CCD9DA8A536, player.team);
        objective_setbackground(self._id_0B028CCD9DA8A536, 1);
      }

      objective_setplayintro(self._id_0B028CCD9DA8A536, 0);
      objective_position(self._id_0B028CCD9DA8A536, self._id_A05DE526305693E5.origin + (0, 0, 55));
      objective_setdescription(self._id_0B028CCD9DA8A536, &"MP_BR_INGAME/REWARD_ICON_NAME_PAYPHONE");
    }

    thread _id_E681C2FA64A0205D();
  } else {}

  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_C567FCD308CABE78);
}

_id_E681C2FA64A0205D() {
  level endon("game_ended");
  self endon("safe_looted");
  _id_E88B7FDAADFED6F2 = _id_58F20490049AF6AC::_id_60951B84C58915AB(self._id_A05DE526305693E5.origin);
  _id_6EDCD14681F382F2 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_E88B7FDAADFED6F2);

  if(_id_6EDCD14681F382F2 < self._id_484CC38726DE1DC2)
    wait(_id_6EDCD14681F382F2);
  else
    wait(self._id_484CC38726DE1DC2);

  scripts\mp\objidpoolmanager::update_objective_state(self._id_0B028CCD9DA8A536, "active");
}

_id_5420853E4D98E1D9() {
  foreach(phone in self._id_8521B23EDF1F6321) {
    _id_85691B1EE9A783F0 = _id_58F20490049AF6AC::_id_60951B84C58915AB(phone.pos);
    _id_71F26E0C8F780FCD = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_85691B1EE9A783F0);
    phone._id_9D42D8CFFEF859FB = _id_71F26E0C8F780FCD;
  }
}

_id_688660459617D212() {
  _id_C777085C3F7366ED = [];
  _id_1FF31E8AC06D8E0E = self._id_8521B23EDF1F6321;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_8521B23EDF1F6321.size; _id_AC0E594AC96AA3A8++) {
    _id_C32C6D9E3F528486 = undefined;

    foreach(phone in _id_1FF31E8AC06D8E0E) {
      if(isDefined(_id_C32C6D9E3F528486) && phone._id_9D42D8CFFEF859FB > _id_C32C6D9E3F528486._id_9D42D8CFFEF859FB) {
        _id_C32C6D9E3F528486 = phone;
        continue;
      }

      if(!isDefined(_id_C32C6D9E3F528486))
        _id_C32C6D9E3F528486 = phone;
    }

    if(isDefined(_id_C32C6D9E3F528486)) {
      _id_C777085C3F7366ED = scripts\engine\utility::array_add(_id_C777085C3F7366ED, _id_C32C6D9E3F528486);
      _id_1FF31E8AC06D8E0E = scripts\engine\utility::array_remove(_id_1FF31E8AC06D8E0E, _id_C32C6D9E3F528486);
    }
  }

  self._id_8521B23EDF1F6321 = _id_C777085C3F7366ED;
}

_id_9E4CF26943012959(_id_309F6B93D3CFA950) {
  _id_1749437DC7091CA8 = _id_309F6B93D3CFA950.pos;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_8521B23EDF1F6321.size; _id_AC0E594AC96AA3A8++) {
    _id_5743B4D2A4358264 = self._id_8521B23EDF1F6321[_id_AC0E594AC96AA3A8];
    dist = distance2d(_id_1749437DC7091CA8, _id_5743B4D2A4358264.pos);

    if(istrue(_id_5743B4D2A4358264.chosen) || dist < self._id_695CD7C3788EB91D || dist > self._id_9EEC6F98A6B2F36F) {
      continue;
    }
    if(isDefined(level.br_circle_disabled) && !level.br_circle_disabled && !self._id_B4EFADFE79073356 && _id_5743B4D2A4358264._id_9D42D8CFFEF859FB > _id_309F6B93D3CFA950._id_9D42D8CFFEF859FB) {
      continue;
    }
    return _id_5743B4D2A4358264;
  }
}

_id_09B4145AA15328E8(_id_E8012A4DEC660D62) {
  _id_104352A4068A6EF3 = 0;

  if(isDefined(level.br_circle_disabled) && !level.br_circle_disabled && !level._id_1E1465ED69F27C94._id_B4EFADFE79073356) {
    if(isDefined(_id_E8012A4DEC660D62))
      _id_104352A4068A6EF3 = _id_E8012A4DEC660D62._id_9D42D8CFFEF859FB + level._id_1E1465ED69F27C94._id_10EFB3AB897956BA;
    else
      _id_104352A4068A6EF3 = level.br_circle._id_5B8569581E64D55A / 1000 + level._id_1E1465ED69F27C94._id_10EFB3AB897956BA;

    if(self._id_9D42D8CFFEF859FB < _id_104352A4068A6EF3)
      return 0;
  }

  return 1;
}

_id_355344431F4446E4() {
  _id_AB23FDF59781F2EB = self._id_A05DE526305693E5.origin;
  location = _id_AB23FDF59781F2EB + vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) * 800;
  origin = getclosestpointonnavmesh(location);
  spawnpoints = getrandomnavpoints(origin, 300, 20);

  foreach(point in spawnpoints) {
    if(point[2] - _id_AB23FDF59781F2EB[2] > 60) {
      continue;
    }
    dist = distance2dsquared(point, _id_AB23FDF59781F2EB);

    if(dist > self._id_D7F93C5DFB5F6567 && _id_120270BD0A747A35::_id_5867290FDA7A1AC1(point, 400))
      return point;
  }

  return undefined;
}

_id_ECBABC6EB922E267(agent) {
  agent endon("death");
  level endon("game_ended");

  for(;;) {
    agent waittill("bad_path", _id_772EDBDCFE906C73);
    wait 1;
    agent clearbtgoal(0);
    agent clearbtgoal(1);
    agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256, _id_514E0C3E9F3FCEFF());
  }
}

_id_514E0C3E9F3FCEFF() {
  location = self._id_A05DE526305693E5.origin + vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) * 300;
  origin = getclosestpointonnavmesh(location);
  return origin;
}

_id_C567FCD308CABE78(agent, attacker) {
  _id_36242BF26474F8A7 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "killedByGas");

  if(self._id_B22FE78CB138CBD1 && istrue(_id_36242BF26474F8A7) && !self._id_E4B9B55EF09D4F53)
    self._id_E4B9B55EF09D4F53 = 1;

  self._id_587BD29B0DE8B1D7 = scripts\engine\utility::array_remove(self._id_587BD29B0DE8B1D7, agent);

  if(self._id_587BD29B0DE8B1D7.size > 0) {
    return;
  }
  _id_A5E1636E3B1950B8(attacker);
}

_id_26E21CE9A398EC4E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance setscriptablepartstate(part, "opening");
  _id_BAB0D10E51188531 = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");
  _id_05C607EF7F46F361::_id_467F8B6E641DC16C(level._id_1E1465ED69F27C94._id_F8C903F8D6D4E353, instance.origin, instance.angles - (0, 135, 0), _id_BAB0D10E51188531, 0, "sealion_sq_payphone_complete");

  if(isDefined(level._id_1E1465ED69F27C94._id_0B028CCD9DA8A536))
    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_1E1465ED69F27C94._id_0B028CCD9DA8A536);

  level._id_1E1465ED69F27C94 notify("safe_looted");
}