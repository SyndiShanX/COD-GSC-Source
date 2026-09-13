/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_75b994f10201e95c.gsc
***********************************************/

init() {
  level waittill("player_spawned");
  level._id_87436FEBDC194615 = _id_D67FA72229E8393D("scriptable_digital_billboards_vertical", 5);
  level._id_F52634F659CE0777 = _id_D67FA72229E8393D("scriptable_digital_billboards_horizontal", 2);

  if(getdvarint("scr_mp_billboards_enabled", 0) == 0) {
    return;
  }
  _id_A1E312C81D78F53E = "digitalbillboardadvertisements:" + getDvar("scr_mp_billboards_advertisement_set");
  _id_04BFB302739681A2 = getscriptbundle(_id_A1E312C81D78F53E);

  if(!isDefined(_id_04BFB302739681A2)) {
    return;
  }
  _id_FD9720AB856B9182 = randomint(_id_04BFB302739681A2._id_A8815C64D130615B.size);
  _id_95681BCCCC148C4A = _id_04BFB302739681A2._id_A8815C64D130615B[_id_FD9720AB856B9182];
  level._id_CCCD17F9388086B7 = _id_95681BCCCC148C4A._id_E0A363ADF11C8946;
  _id_97FF8DF643DF7BD4 = _id_04BFB302739681A2._id_E4C472585AF18F5D;
  level._id_97FF8DF643DF7BD4 = _id_97FF8DF643DF7BD4;
  level._id_FEFF579D77781423 = istrue(_id_04BFB302739681A2._id_C217F5658291B348._id_2330778313DF3331);

  if(!isDefined(_id_95681BCCCC148C4A) || _id_95681BCCCC148C4A.size == 0) {
    return;
  }
  _id_E6CF0ED17753630B = getDvar("dvar_4BB0610B77A65173", "");
  _id_97D55065375F529E = [];

  if(_id_E6CF0ED17753630B != "")
    _id_97D55065375F529E = strtok(_id_E6CF0ED17753630B, ",");

  _id_14D0913AEC08F092 = getDvar("dvar_1D3125D35A55EFDD", "");
  _id_D718149245FD4533 = [];

  if(_id_14D0913AEC08F092 != "")
    _id_D718149245FD4533 = strtok(_id_14D0913AEC08F092, ",");

  _id_09F49F87BC82EFA7 = _id_95681BCCCC148C4A._id_E0A363ADF11C8946.size;
  level._id_2040B676CC5B064A = getdvarint("dvar_FC255BCF24C83B71", _id_09F49F87BC82EFA7);
  _id_10DE73A7DF631B43 = getdvarint("scr_mp_billboards_advertisement_display_time", 7);
  level._id_10DE73A7DF631B43 = _id_10DE73A7DF631B43;
  _id_E4C472585AF18F5D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_97D55065375F529E.size; _id_AC0E594AC96AA3A8++) {
    index = _id_D8E65966DA143203(_id_97D55065375F529E[_id_AC0E594AC96AA3A8], _id_97FF8DF643DF7BD4);

    if(!isDefined(index)) {
      continue;
    }
    _id_69D34BBE3D008A97 = spawnStruct();
    _id_69D34BBE3D008A97.id = index;
    _id_69D34BBE3D008A97.duration = _id_10DE73A7DF631B43;

    if(_id_D718149245FD4533.size > _id_AC0E594AC96AA3A8)
      _id_69D34BBE3D008A97.duration = int(_id_D718149245FD4533[_id_AC0E594AC96AA3A8]);

    _id_E4C472585AF18F5D[_id_E4C472585AF18F5D.size] = _id_69D34BBE3D008A97;
  }

  level._id_E4C472585AF18F5D = _id_E4C472585AF18F5D;
  _id_C217F5658291B348 = _id_04BFB302739681A2._id_C217F5658291B348;
  level._id_E80147EE9F1531E0 = 0;
  scripts\mp\flags::gameflaginit("billboard_advertisement_ready", 1);
  level _id_96F0D4C5FF43F24E(_id_FD9720AB856B9182 + 1);
  level thread _id_99B22AFE385DA736(_id_09F49F87BC82EFA7);

  if(getdvarint("dvar_1ECB4EE1B513876D", 0) == 0 && isDefined(_id_C217F5658291B348))
    level thread _id_4D4736A92ADFDE31();
}

_id_D67FA72229E8393D(_id_C65F0784F2C835D0, _id_1A5B3F60261D2F86) {
  _id_CB332C2D80FF6A51 = getentitylessscriptablearray(_id_C65F0784F2C835D0, "classname");
  _id_5B7C5AD771190C7C = [];
  _id_27DEC58D1D9B3319 = [];

  foreach(_id_114D2772AABE8518 in _id_CB332C2D80FF6A51) {
    _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_114D2772AABE8518.origin);

    if(!isDefined(_id_5B7C5AD771190C7C[_id_B205D90302DA2F07])) {
      _id_5B7C5AD771190C7C[_id_B205D90302DA2F07] = [];
      _id_27DEC58D1D9B3319[_id_27DEC58D1D9B3319.size] = _id_B205D90302DA2F07;
    }

    _id_5B7C5AD771190C7C[_id_B205D90302DA2F07][_id_5B7C5AD771190C7C[_id_B205D90302DA2F07].size] = _id_114D2772AABE8518;
  }

  foreach(_id_B205D90302DA2F07 in _id_27DEC58D1D9B3319) {
    index = 0;

    foreach(_id_114D2772AABE8518 in _id_5B7C5AD771190C7C[_id_B205D90302DA2F07]) {
      state = index % _id_1A5B3F60261D2F86 + 1;
      _id_114D2772AABE8518.state = "rt" + state;
      _id_114D2772AABE8518 setscriptablepartstate("root", _id_114D2772AABE8518.state);
      index++;
    }
  }

  return _id_CB332C2D80FF6A51;
}

_id_99B22AFE385DA736(_id_09F49F87BC82EFA7) {
  level endon("game_ended");
  _id_2040B676CC5B064A = level._id_2040B676CC5B064A;
  _id_10DE73A7DF631B43 = level._id_10DE73A7DF631B43;
  _id_8B79F0B23A386000 = 0;
  _id_ECC00EDCBC94F8F2 = 0;

  for(;;) {
    scripts\mp\flags::gameflagwait("billboard_advertisement_ready");
    _id_E4C472585AF18F5D = level._id_E4C472585AF18F5D;
    level notify("update_featured_ads");

    if(_id_E4C472585AF18F5D.size > 0) {
      _id_2659BF2515661476(istrue(_id_E4C472585AF18F5D[_id_ECC00EDCBC94F8F2]._id_2330778313DF3331));
      level _id_EDD927A5F453D828(1, _id_E4C472585AF18F5D[_id_ECC00EDCBC94F8F2].id + 1);
      wait(_id_E4C472585AF18F5D[_id_ECC00EDCBC94F8F2].duration);
      _id_ECC00EDCBC94F8F2 = (_id_ECC00EDCBC94F8F2 + 1) % _id_E4C472585AF18F5D.size;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2040B676CC5B064A; _id_AC0E594AC96AA3A8++) {
      scripts\mp\flags::gameflagwait("billboard_advertisement_ready");
      _id_2659BF2515661476(istrue(level._id_CCCD17F9388086B7[_id_8B79F0B23A386000]._id_2330778313DF3331));
      level _id_EDD927A5F453D828(3, _id_8B79F0B23A386000 + 1);
      _id_8B79F0B23A386000 = (_id_8B79F0B23A386000 + 1) % _id_09F49F87BC82EFA7;
      wait(_id_10DE73A7DF631B43);
    }
  }
}

_id_2659BF2515661476(_id_8063670B409C27FD) {
  if(level._id_E80147EE9F1531E0 == _id_8063670B409C27FD) {
    return;
  }
  _id_CB332C2D80FF6A51 = scripts\engine\utility::array_combine(level._id_87436FEBDC194615, level._id_F52634F659CE0777);

  foreach(_id_114D2772AABE8518 in _id_CB332C2D80FF6A51) {
    state = "rt1";

    if(!istrue(_id_8063670B409C27FD))
      state = _id_114D2772AABE8518.state;

    _id_114D2772AABE8518 setscriptablepartstate("root", state);
  }

  level._id_E80147EE9F1531E0 = _id_8063670B409C27FD;
}

_id_4D4736A92ADFDE31() {
  level endon("game_ended");
  level waittill("prematch_over");
  _id_2C9EFF3BE64BE074 = getdvarint("dvar_83EB61FD6910D5DF", 10);
  _id_05995C3B47F8D158 = getdvarint("dvar_3AE7B8BC6636FB3D", 20);

  for(;;) {
    foreach(tag, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      if(!isDefined(_id_B205D90302DA2F07["calloutIndex"])) {
        continue;
      }
      _id_8E25E33A0825D40F = _id_B205D90302DA2F07["players"];

      if(isDefined(_id_8E25E33A0825D40F) && _id_8E25E33A0825D40F.size >= _id_2C9EFF3BE64BE074) {
        scripts\mp\flags::gameflagclear("billboard_advertisement_ready");
        _id_2659BF2515661476(level._id_FEFF579D77781423);
        level _id_EDD927A5F453D828(2, _id_B205D90302DA2F07["calloutIndex"]);
        _id_1C2961EB8990C7D4(tag);
        wait(_id_05995C3B47F8D158);
        scripts\mp\flags::gameflagset("billboard_advertisement_ready");
        wait((level._id_2040B676CC5B064A + 1) * level._id_10DE73A7DF631B43);
      }
    }

    wait 2;
  }
}

_id_1C2961EB8990C7D4(_id_171F90B9C4C76D44) {
  _id_EF4A35C3BF56BCC9 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  dlog_recordevent("dlog_event_br_billboard_poi_warning", ["poi_name", _id_171F90B9C4C76D44, "timestamp_warning", _id_EF4A35C3BF56BCC9]);
}

_id_EDD927A5F453D828(_id_EE2ED6D8B66240CA, index) {
  foreach(player in level.players) {
    if(isDefined(player)) {
      player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_mp_billboards_advertisement_data", 0, 2, _id_EE2ED6D8B66240CA);
      player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_mp_billboards_advertisement_data", 7, 5, index);
    }
  }
}

_id_96F0D4C5FF43F24E(_id_4852060D0A82BCDE) {
  foreach(player in level.players) {
    if(isDefined(player))
      player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_mp_billboards_advertisement_data", 2, 5, _id_4852060D0A82BCDE);
  }
}

_id_F7DEDAA26220B51C(data, duration) {
  level endon("game_ended");
  level waittill("update_featured_ads");

  if(!isDefined(duration))
    duration = level._id_10DE73A7DF631B43;

  index = _id_D8E65966DA143203(data, level._id_97FF8DF643DF7BD4);

  if(!isDefined(index)) {
    return;
  }
  _id_69D34BBE3D008A97 = spawnStruct();
  _id_69D34BBE3D008A97.id = index;
  _id_69D34BBE3D008A97.duration = duration;
  _id_69D34BBE3D008A97._id_2330778313DF3331 = level._id_97FF8DF643DF7BD4[index]._id_2330778313DF3331;
  level._id_E4C472585AF18F5D[level._id_E4C472585AF18F5D.size] = _id_69D34BBE3D008A97;
}

_id_D8E65966DA143203(_id_248D851D0FFDB9D7, _id_07CAE2543E26B4FE) {
  if(isDefined(_id_248D851D0FFDB9D7)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_07CAE2543E26B4FE.size; _id_AC0E594AC96AA3A8++) {
      if(_id_248D851D0FFDB9D7 == _id_07CAE2543E26B4FE[_id_AC0E594AC96AA3A8]._id_E9635FE005F5AD03)
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}