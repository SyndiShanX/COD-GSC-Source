/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\poi.gsc
***********************************************/

_id_C08668FE290FC31A() {
  if(getdvarint("dvar_2CC531E644D4FDB3", 1) == 0) {
    return;
  }
  level._id_B0EAE20487331106 = getdvarint("dvar_AF96CBE00F226832", 0);
  level._id_0D35175EC20B444C = getdvarint("dvar_AD89F1C2B195EDA2", 120) * 1000;
  level._id_B205D90302DA2F07 = [];
  level._id_AB20B3A256911579 = [];
  level._id_A09459A429DEB934 = [];

  if(!isDefined(level._id_DBB3DD5AB77CCD48))
    level._id_DBB3DD5AB77CCD48 = [];

  _id_3EC2BBF69971F68C();
  _id_E9B7AFAF35E17BDC();
  scripts\engine\utility::script_func("pois_found");

  if(istrue(level._id_6DF475909FFB403D) && isDefined(level._id_BEDC3454DFA5E84F))
    [[level._id_BEDC3454DFA5E84F]]();

  if(isDefined(level._id_DBB3DD5AB77CCD48)) {
    _id_FC8AFB765C52482B = 1;

    if(istrue(level._id_B0EAE20487331106))
      _id_FC8AFB765C52482B = 0;

    foreach(_id_171F90B9C4C76D44 in level._id_DBB3DD5AB77CCD48) {
      _id_EB5F2CFFBF051614 = _func_2EF675C13CA1C4AF("poi_", _id_171F90B9C4C76D44);

      if(getdvarint(_id_EB5F2CFFBF051614, _id_FC8AFB765C52482B) == 0)
        level._id_AB20B3A256911579[level._id_AB20B3A256911579.size] = _id_171F90B9C4C76D44;
    }
  }

  if(!isDefined(level._id_DBB3DD5AB77CCD48)) {
    return;
  }
  foreach(_id_171F90B9C4C76D44 in level._id_DBB3DD5AB77CCD48)
  _id_3D397C9451F80077(_id_171F90B9C4C76D44);

  _id_24D78167783C535F();
  _id_72BC50FD699E7A9D();
  level thread _id_52CB931E1834F98B();
  scripts\cp_mp\utility\script_utility::registersharedfunc("poi", "poi_isPOIActive", ::_id_FAA6481E65F14ADE);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_FC5D5824570E8C21);
  _id_68F5D2342AD95772();
  _id_683E582EFD2A8233();
  scripts\engine\utility::script_func("pois_init");
}

_id_3EC2BBF69971F68C() {
  level._id_DA9EDB0C15BE1C3B = [];
  _id_5B0BA90F4198628F = level.mapname == "mp_mgl_escape4";
  _id_03DDD80C2A77E4E9 = level.mapname == "mp_mgl_verdansk";
  _id_349BB06748E578C6 = [];

  foreach(volume in getEntArray("trigger_multiple", "code_classname")) {
    if(isDefined(volume.targetname) && issubstr(volume.targetname, "poi_trigger_"))
      _id_349BB06748E578C6[_id_349BB06748E578C6.size] = volume;
  }

  foreach(volume in _func_F159C10D5CF8F0B4("noent_volume_trigger", "classname")) {
    if(isDefined(volume.targetname) && issubstr(volume.targetname, "poi_trigger_"))
      _id_349BB06748E578C6[_id_349BB06748E578C6.size] = volume;
  }

  foreach(volume in _func_F159C10D5CF8F0B4("noent_volume_info", "classname")) {
    if(isDefined(volume.targetname) && issubstr(volume.targetname, "poi_trigger_"))
      _id_349BB06748E578C6[_id_349BB06748E578C6.size] = volume;
  }

  if(_id_5B0BA90F4198628F || _id_03DDD80C2A77E4E9) {
    foreach(volume in getEntArray("location_volume", "targetname")) {
      if(isDefined(volume.script_noteworthy))
        _id_349BB06748E578C6[_id_349BB06748E578C6.size] = volume;
    }
  }

  if(isDefined(_id_349BB06748E578C6) && _id_349BB06748E578C6.size > 0) {
    foreach(volume in _id_349BB06748E578C6) {
      if(_id_5B0BA90F4198628F)
        _id_171F90B9C4C76D44 = "escape4_" + volume.script_noteworthy;
      else if(_id_03DDD80C2A77E4E9 && isDefined(volume.script_noteworthy))
        _id_171F90B9C4C76D44 = volume.script_noteworthy;
      else
        _id_171F90B9C4C76D44 = tolower(getsubstr(volume.targetname, 12));

      if(!isDefined(level._id_DBB3DD5AB77CCD48))
        level._id_DBB3DD5AB77CCD48 = [];

      volume._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;

      if(!scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44)) {
        level._id_DBB3DD5AB77CCD48[level._id_DBB3DD5AB77CCD48.size] = _id_171F90B9C4C76D44;
        level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44] = volume;
        continue;
      }

      if(!isDefined(level._id_FF89A1714AF44C4E))
        level._id_FF89A1714AF44C4E = [];

      level._id_FF89A1714AF44C4E[_id_171F90B9C4C76D44] = level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44];
      level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44] = volume;
    }
  }
}

_id_E9B7AFAF35E17BDC() {
  level._id_ACF99124377543BB = [];

  if(isDefined(level._id_DA9EDB0C15BE1C3B) && level._id_DA9EDB0C15BE1C3B.size > 0) {
    foreach(_id_171F90B9C4C76D44, volume in level._id_DA9EDB0C15BE1C3B)
    level._id_ACF99124377543BB[_id_171F90B9C4C76D44] = volume.origin;
  } else {
    _id_C46A79729CBA49DE = [];
    _id_C46A79729CBA49DE["saba_hydro"] = (-8968, 8225, 772);
    _id_C46A79729CBA49DE["saba_oilfield"] = (-23684, 21737, 436);
    _id_C46A79729CBA49DE["saba_fort"] = (18357, -54628, 2270);
    _id_C46A79729CBA49DE["saba_exhume"] = (-49193, 14284, 1674);

    foreach(_id_171F90B9C4C76D44 in level._id_DBB3DD5AB77CCD48) {
      if(isDefined(_id_C46A79729CBA49DE[_id_171F90B9C4C76D44]))
        level._id_ACF99124377543BB[_id_171F90B9C4C76D44] = _id_C46A79729CBA49DE[_id_171F90B9C4C76D44];
    }
  }
}

_id_24D78167783C535F() {
  ents = scripts\engine\utility::array_combine(getEntArray("trigger_multiple", "classname"), _func_F159C10D5CF8F0B4("noent_volume_trigger", "classname"), _func_F159C10D5CF8F0B4("noent_volume_info", "classname"));
  _id_078FA8D928A0C292 = [];
  _id_44739FE1CF82E29A("subAreas");

  foreach(ent in ents) {
    if(isDefined(ent.script_noteworthy) && issubstr(ent.script_noteworthy, "subarea_")) {
      struct = spawnStruct();
      struct.trigger = ent;
      _id_84A8C10C861D7CE0 = "saba_";

      if(isDefined(level._id_4D8386ECA283E9C4))
        _id_84A8C10C861D7CE0 = level._id_4D8386ECA283E9C4;

      _id_67F14F8315CB0F2F = strtok(ent.script_noteworthy, "_");
      _id_171F90B9C4C76D44 = _id_84A8C10C861D7CE0 + tolower(scripts\engine\utility::_id_996B01CD49D0128D(scripts\engine\utility::array_slice(_id_67F14F8315CB0F2F, 1, _id_67F14F8315CB0F2F.size - 1), "_"));
      _id_6A01FF17267A7F86 = _id_67F14F8315CB0F2F[0].size + _id_67F14F8315CB0F2F[1].size + 2;

      if(issubstr(ent.script_noteworthy, "suburb_") || issubstr(ent.script_noteworthy, "suburbs_"))
        _id_6A01FF17267A7F86 = _id_67F14F8315CB0F2F[0].size + _id_67F14F8315CB0F2F[1].size + _id_67F14F8315CB0F2F[2].size + 3;

      struct._id_71AD22C5D093D90B = tolower(getsubstr(ent.script_noteworthy, _id_6A01FF17267A7F86));
      struct._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;

      foreach(_id_A0B37D5F4A050123, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
        if(issubstr(_id_A0B37D5F4A050123, _id_171F90B9C4C76D44))
          _id_D0E7647E5538EB9D(_id_A0B37D5F4A050123, "subAreas", struct, struct._id_71AD22C5D093D90B);
      }
    }
  }

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    _id_029260D0089DF816 = spawnStruct();
    _id_029260D0089DF816._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
    _id_029260D0089DF816._id_71AD22C5D093D90B = "orphan";
    _id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "subAreas", _id_029260D0089DF816, _id_029260D0089DF816._id_71AD22C5D093D90B);
  }

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    if(!isDefined(_id_B205D90302DA2F07["subAreas"])) {
      continue;
    }
    foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
      _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA = [];
      _id_D1CF55B36FACF5A8._id_25087194B5E05D51 = 0;
      _id_D1CF55B36FACF5A8._id_D276B08C96430BFC = [];
      _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D = [];
    }
  }
}

_id_985798A13250C99A(_id_171F90B9C4C76D44) {
  _id_C70BFAFFC89D58AF = tablelookup("mp/map_callouts/" + level.mapname + "_callouts.csv", 1, _id_171F90B9C4C76D44, 0);

  if(isDefined(_id_C70BFAFFC89D58AF) && _id_C70BFAFFC89D58AF != "")
    return int(_id_C70BFAFFC89D58AF);

  return undefined;
}

_id_80CDAEA4BD3ECF70(_id_171F90B9C4C76D44) {
  _id_D455648308E34F3F = 0;

  if(isDefined(_id_171F90B9C4C76D44)) {
    _id_C70BFAFFC89D58AF = _id_985798A13250C99A(_id_171F90B9C4C76D44);

    if(isDefined(_id_C70BFAFFC89D58AF))
      _id_D455648308E34F3F = _id_C70BFAFFC89D58AF;
  }

  return _id_D455648308E34F3F;
}

_id_72BC50FD699E7A9D() {
  if(!isDefined(level._id_DA9EDB0C15BE1C3B)) {
    return;
  }
  foreach(_id_2F9D02583DCACC98 in level._id_DBB3DD5AB77CCD48) {
    if(!isDefined(level._id_B205D90302DA2F07[_id_2F9D02583DCACC98])) {
      continue;
    }
    level._id_B205D90302DA2F07[_id_2F9D02583DCACC98]["otherPoiByDist"] = [];
    curorigin = level._id_ACF99124377543BB[_id_2F9D02583DCACC98];
    _id_B75D6C3B38C167D9 = sortbydistance(level._id_DA9EDB0C15BE1C3B, curorigin);

    foreach(index, volume in _id_B75D6C3B38C167D9) {
      if(scripts\engine\utility::array_contains_key(level._id_B205D90302DA2F07, volume._id_B205D90302DA2F07))
        level._id_B205D90302DA2F07[_id_2F9D02583DCACC98]["otherPoiByDist"][level._id_B205D90302DA2F07[_id_2F9D02583DCACC98]["otherPoiByDist"].size] = volume._id_B205D90302DA2F07;
    }
  }
}

_id_3D397C9451F80077(_id_171F90B9C4C76D44) {
  if(!_id_47D356083884F913()) {
    return;
  }
  if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]))
    return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44];

  if(!_id_FAA6481E65F14ADE(_id_171F90B9C4C76D44)) {
    return;
  }
  level._id_B205D90302DA2F07[_id_171F90B9C4C76D44] = _id_183A2F183E4A605B();
  level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["name"] = _id_171F90B9C4C76D44;
  level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["calloutIndex"] = _id_985798A13250C99A(_id_171F90B9C4C76D44);
  return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44];
}

_id_183A2F183E4A605B(_id_B205D90302DA2F07) {
  if(!isDefined(_id_B205D90302DA2F07))
    _id_B205D90302DA2F07 = [];

  foreach(_id_3F44C731FDDDD082 in level._id_A09459A429DEB934) {
    if(!isDefined(_id_B205D90302DA2F07[_id_3F44C731FDDDD082]))
      _id_B205D90302DA2F07[_id_3F44C731FDDDD082] = [];
  }

  return _id_B205D90302DA2F07;
}

_id_44739FE1CF82E29A(_id_3F44C731FDDDD082) {
  if(!_id_47D356083884F913()) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level._id_A09459A429DEB934, _id_3F44C731FDDDD082))
    level._id_A09459A429DEB934[level._id_A09459A429DEB934.size] = _id_3F44C731FDDDD082;

  foreach(index, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
  level._id_B205D90302DA2F07[index] = _id_183A2F183E4A605B(_id_B205D90302DA2F07);
}

_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, _id_3F44C731FDDDD082) {
  if(!_id_47D356083884F913()) {
    return;
  }
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(_id_3F44C731FDDDD082)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level._id_A09459A429DEB934, _id_3F44C731FDDDD082)) {
    return;
  }
  return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44][_id_3F44C731FDDDD082];
}

_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, _id_3F44C731FDDDD082, _id_F8FF5670B74761D2, _id_EC51FE53D55F33A1) {
  if(!_id_47D356083884F913()) {
    return;
  }
  if(!isDefined(_id_171F90B9C4C76D44)) {
    return;
  }
  if(!_id_FAA6481E65F14ADE(_id_171F90B9C4C76D44)) {
    return;
  }
  if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
    return;
  }
  if(isDefined(_id_EC51FE53D55F33A1))
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44][_id_3F44C731FDDDD082][_id_EC51FE53D55F33A1] = _id_F8FF5670B74761D2;
  else
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44][_id_3F44C731FDDDD082][level._id_B205D90302DA2F07[_id_171F90B9C4C76D44][_id_3F44C731FDDDD082].size] = _id_F8FF5670B74761D2;

  if(isDefined(_id_F8FF5670B74761D2.origin)) {
    _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(_id_F8FF5670B74761D2.origin, _id_171F90B9C4C76D44);

    if(isDefined(_id_D1CF55B36FACF5A8) && isDefined(_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B))
      _id_F8FF5670B74761D2._id_71AD22C5D093D90B = _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B;
  }
}

_id_D2ED76E2BEDD339E(_id_171F90B9C4C76D44) {
  if(isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_ACF99124377543BB))
    return level._id_ACF99124377543BB[_id_171F90B9C4C76D44];

  return undefined;
}

_id_9C93E67F90980177(origin) {
  _id_B205D90302DA2F07 = _id_6CC445C02B5EFFAC(origin, 1);
  return isDefined(_id_B205D90302DA2F07) && (!isDefined(level._id_AB20B3A256911579) || !scripts\engine\utility::array_contains(level._id_AB20B3A256911579, _id_B205D90302DA2F07));
}

_id_6CC445C02B5EFFAC(origin, _id_B0068B35C79EA7FA, _id_9D9D80ABB79138BB, _id_DB259B7E9331B0A0) {
  if(!_id_47D356083884F913())
    return undefined;

  _id_171F90B9C4C76D44 = _id_62F13E21048DACDE(origin, _id_B0068B35C79EA7FA, _id_9D9D80ABB79138BB, _id_DB259B7E9331B0A0);

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_55CF921EFA4CBD09(origin, _id_B0068B35C79EA7FA, _id_9D9D80ABB79138BB, _id_DB259B7E9331B0A0);

  return _id_171F90B9C4C76D44;
}

_id_62F13E21048DACDE(origin, _id_B0068B35C79EA7FA, _id_9D9D80ABB79138BB, _id_DB259B7E9331B0A0) {
  if(!_id_47D356083884F913())
    return undefined;

  if(!isDefined(_id_B0068B35C79EA7FA))
    _id_B0068B35C79EA7FA = 0;

  if(!isDefined(_id_9D9D80ABB79138BB))
    _id_9D9D80ABB79138BB = 1;

  if(!isDefined(_id_DB259B7E9331B0A0))
    _id_DB259B7E9331B0A0 = 0;

  _id_5D0BB59F45D65C1C = scripts\engine\utility::ter_op(_id_B0068B35C79EA7FA, level._id_DBB3DD5AB77CCD48, getarraykeys(level._id_B205D90302DA2F07));

  foreach(_id_171F90B9C4C76D44 in _id_5D0BB59F45D65C1C) {
    if(!_id_9D9D80ABB79138BB && issubstr(_id_171F90B9C4C76D44, "suburb")) {
      continue;
    }
    if(_id_DB259B7E9331B0A0 && !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["calloutIndex"])) {
      continue;
    }
    if(isDefined(level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44])) {
      if(istrue(_id_9802DD00208B0F03(origin, _id_171F90B9C4C76D44)))
        return _id_171F90B9C4C76D44;
    }
  }
}

_id_9802DD00208B0F03(origin, _id_171F90B9C4C76D44) {
  if(!isDefined(origin)) {
    return;
  }
  if(_id_47D356083884F913()) {
    _id_6E80031CE7163196 = isDefined(level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44]) && ispointinvolume(origin, level._id_DA9EDB0C15BE1C3B[_id_171F90B9C4C76D44]);
    _id_DD4DFF0B187CB059 = isDefined(level._id_FF89A1714AF44C4E) && isDefined(level._id_FF89A1714AF44C4E[_id_171F90B9C4C76D44]) && ispointinvolume(origin, level._id_FF89A1714AF44C4E[_id_171F90B9C4C76D44]);
    return istrue(_id_6E80031CE7163196) || istrue(_id_DD4DFF0B187CB059);
  }

  return undefined;
}

_id_55CF921EFA4CBD09(origin, _id_B0068B35C79EA7FA, _id_9D9D80ABB79138BB, _id_DB259B7E9331B0A0) {
  if(!isDefined(origin)) {
    return;
  }
  if(_id_47D356083884F913()) {
    _id_574B367A589E1F37 = undefined;
    _id_EA5672010D764EBC = undefined;

    if(!isDefined(_id_B0068B35C79EA7FA))
      _id_B0068B35C79EA7FA = 0;

    if(!isDefined(_id_9D9D80ABB79138BB))
      _id_9D9D80ABB79138BB = 1;

    if(!isDefined(_id_DB259B7E9331B0A0))
      _id_DB259B7E9331B0A0 = 0;

    _id_5D0BB59F45D65C1C = scripts\engine\utility::ter_op(_id_B0068B35C79EA7FA, level._id_DBB3DD5AB77CCD48, getarraykeys(level._id_B205D90302DA2F07));

    foreach(_id_171F90B9C4C76D44 in _id_5D0BB59F45D65C1C) {
      if(!_id_9D9D80ABB79138BB && issubstr(_id_171F90B9C4C76D44, "suburb")) {
        continue;
      }
      if(!isDefined(level._id_ACF99124377543BB[_id_171F90B9C4C76D44])) {
        continue;
      }
      if(_id_DB259B7E9331B0A0 && !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["calloutIndex"])) {
        continue;
      }
      dist = distance2dsquared(level._id_ACF99124377543BB[_id_171F90B9C4C76D44], origin);

      if(!isDefined(_id_EA5672010D764EBC) || dist < _id_EA5672010D764EBC) {
        _id_574B367A589E1F37 = _id_171F90B9C4C76D44;
        _id_EA5672010D764EBC = dist;
      }
    }

    return _id_574B367A589E1F37;
  }
}

_id_80DD9D6A6BF6BBC1(agent, _id_171F90B9C4C76D44, origin) {
  if(!isDefined(_id_171F90B9C4C76D44)) {
    _id_171F90B9C4C76D44 = undefined;
    _id_3A6B42AB825A103E = agent.origin;

    if(isDefined(origin))
      _id_3A6B42AB825A103E = origin;

    _id_171F90B9C4C76D44 = _id_6CC445C02B5EFFAC(_id_3A6B42AB825A103E);
  }

  agent._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;

  if(isDefined(_id_171F90B9C4C76D44))
    agent _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "poiName", _id_171F90B9C4C76D44);

  return _id_171F90B9C4C76D44;
}

_id_9656B61CC8A37CBA(array, _id_171F90B9C4C76D44) {
  _id_50F783A5617F8940 = [];

  foreach(item in array) {
    if(isDefined(item._id_B205D90302DA2F07) && item._id_B205D90302DA2F07 == _id_171F90B9C4C76D44)
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = item;
  }

  return _id_50F783A5617F8940;
}

_id_47D356083884F913() {
  return isDefined(level._id_B205D90302DA2F07);
}

_id_53C14FE145417E51(array) {
  level._id_DBB3DD5AB77CCD48 = array;
}

_id_FAA6481E65F14ADE(_id_171F90B9C4C76D44) {
  return isDefined(_id_171F90B9C4C76D44) && _id_47D356083884F913() && scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44) && !scripts\engine\utility::array_contains(level._id_AB20B3A256911579, _id_171F90B9C4C76D44);
}

_id_7E9CBC0F32DE6578() {
  return _id_47D356083884F913() && level._id_AB20B3A256911579.size < level._id_DBB3DD5AB77CCD48.size;
}

_id_FF7254EF602812CB(_id_171F90B9C4C76D44) {
  return issubstr(_id_171F90B9C4C76D44, "suburb");
}

_id_52CB931E1834F98B() {
  level scripts\engine\utility::waittill_either("matchStartTimer_done", "br_ready_to_jump");

  while(!isDefined(level.players) || level._id_B205D90302DA2F07.size == 0)
    waitframe();

  _id_3A1B9192A1F0B3C4 = scripts\mp\utility\game::getsubgametype() == "dmz";

  if(_id_3A1B9192A1F0B3C4) {
    foreach(player in level.players) {
      _id_171F90B9C4C76D44 = _id_62F13E21048DACDE(player.origin);

      if(isDefined(_id_171F90B9C4C76D44)) {
        difficulty = _id_0A0D6D84038540F3(_id_171F90B9C4C76D44);

        if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
          difficulty = 4;

        player setclientomnvar("ui_dmz_poi_difficulty_rating", difficulty);
      }
    }
  }

  for(;;) {
    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"] = [];

    foreach(player in level.players) {
      _id_4642E4E356A13E50 = player._id_DA28916E7827AF7C;

      if(isDefined(player._id_16FDF4E2A0A41A51))
        player._id_BB146C53EFAB3242 = player._id_16FDF4E2A0A41A51;

      _id_171F90B9C4C76D44 = _id_6CC445C02B5EFFAC(player.origin);
      player._id_16FDF4E2A0A41A51 = _id_171F90B9C4C76D44;

      if(isDefined(_id_171F90B9C4C76D44))
        player._id_8F4E316493C7D231 = _id_171F90B9C4C76D44;

      _id_FB6BAFB61D5C3D4A = undefined;

      if(_id_3A1B9192A1F0B3C4 && isDefined(level._id_A524A11DADC4D9FB)) {
        foreach(name, trigger in level._id_A524A11DADC4D9FB) {
          if(ispointinvolume(player.origin, trigger)) {
            _id_FB6BAFB61D5C3D4A = name;
            break;
          }
        }
      }

      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"][level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size] = player;
      player._id_DA28916E7827AF7C = _id_171F90B9C4C76D44;
      player._id_FB6BAFB61D5C3D4A = _id_FB6BAFB61D5C3D4A;

      if(!isDefined(player._id_DF1204F47F6F0067))
        player._id_DF1204F47F6F0067 = [];

      if(!isDefined(player._id_DF1204F47F6F0067[_id_171F90B9C4C76D44])) {
        _id_F90358454413407F = spawnStruct();
        _id_F90358454413407F._id_B150554AF2FA2748 = -99999999;
        player._id_DF1204F47F6F0067[_id_171F90B9C4C76D44] = _id_F90358454413407F;
      }

      _id_FF778B58D7ED077A = 0;
      _id_A8119182D3648E2D = isDefined(_id_985798A13250C99A(_id_171F90B9C4C76D44));

      if(_id_3A1B9192A1F0B3C4 && isDefined(player._id_BB146C53EFAB3242) && isDefined(player._id_16FDF4E2A0A41A51) && player._id_BB146C53EFAB3242 != player._id_16FDF4E2A0A41A51 && player._id_DA28916E7827AF7C == player._id_16FDF4E2A0A41A51 && _id_A8119182D3648E2D) {
        _id_22D742BAB072905A = gettime() - player._id_DF1204F47F6F0067[_id_171F90B9C4C76D44]._id_B150554AF2FA2748;

        if(_id_22D742BAB072905A > level._id_0D35175EC20B444C && !_id_FF7254EF602812CB(_id_171F90B9C4C76D44)) {
          difficulty = _id_0A0D6D84038540F3(_id_171F90B9C4C76D44);

          if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
            difficulty = 4;

          player setclientomnvar("ui_dmz_poi_difficulty_rating", difficulty);
          _id_FF778B58D7ED077A = 1;
          _id_1B4ADA49A21B51CA = "br_poi_entry_" + _id_171F90B9C4C76D44;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showDMZSplash"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showDMZSplash")]](_id_1B4ADA49A21B51CA, [player]);

          player _id_77CC88D0FABF6371(_id_171F90B9C4C76D44);
        }
      }

      if(!isDefined(_id_4642E4E356A13E50) || isDefined(player._id_DA28916E7827AF7C) && _id_4642E4E356A13E50 != player._id_DA28916E7827AF7C) {
        if(_id_3A1B9192A1F0B3C4 && !_id_FF7254EF602812CB(_id_171F90B9C4C76D44))
          _id_6A8EC730B2BFA844::_id_D10645AFED0F00FE(player, _id_171F90B9C4C76D44);

        vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

        if(isDefined(vehicle) && isDefined(player.team)) {
          if(!isDefined(level._id_7352A1221B306395))
            level._id_7352A1221B306395 = [];

          if(!isDefined(level._id_7352A1221B306395[_id_171F90B9C4C76D44]))
            level._id_7352A1221B306395[_id_171F90B9C4C76D44] = [];

          if(!isDefined(level._id_7352A1221B306395[_id_171F90B9C4C76D44][player.team])) {
            level._id_7352A1221B306395[_id_171F90B9C4C76D44][player.team] = 1;
            player scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(vehicle, "poi_travel");
          }
        }

        _id_D455648308E34F3F = -1;

        if(!_id_FF7254EF602812CB(player._id_DA28916E7827AF7C)) {
          _id_C70BFAFFC89D58AF = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["calloutIndex"];

          if(isDefined(_id_C70BFAFFC89D58AF))
            _id_D455648308E34F3F = _id_C70BFAFFC89D58AF;
        }

        player setclientomnvar("ui_callout_area_id", _id_D455648308E34F3F);

        if(_id_3A1B9192A1F0B3C4 && !_id_FF778B58D7ED077A) {
          if(_id_D455648308E34F3F == -1)
            player setclientomnvar("ui_dmz_poi_difficulty_rating", 0);
          else {
            difficulty = _id_0A0D6D84038540F3(_id_171F90B9C4C76D44);

            if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
              difficulty = 4;

            player setclientomnvar("ui_dmz_poi_difficulty_rating", difficulty);
          }
        }
      }

      player._id_DF1204F47F6F0067[_id_171F90B9C4C76D44]._id_B150554AF2FA2748 = gettime();
    }

    wait 5.0;
  }
}

_id_0A0D6D84038540F3(_id_171F90B9C4C76D44) {
  _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44);
  _id_B511A23DEC1A289C = 0;

  if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["relativeDifficulty"]))
    _id_B511A23DEC1A289C = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["relativeDifficulty"];

  if(_id_B511A23DEC1A289C == 3)
    return 3;

  if(_id_ACA1544C91A292FD > 3)
    return 3;

  if(_id_B511A23DEC1A289C == 2)
    return 2;

  if(_id_ACA1544C91A292FD >= 2)
    return 2;

  return 1;
}

_id_FC5D5824570E8C21(player) {
  if(isDefined(player._id_DA28916E7827AF7C))
    level._id_B205D90302DA2F07[player._id_DA28916E7827AF7C]["players"] = scripts\engine\utility::array_remove(level._id_B205D90302DA2F07[player._id_DA28916E7827AF7C]["players"], player);
}

_id_77CC88D0FABF6371(_id_171F90B9C4C76D44) {
  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = self._id_DA28916E7827AF7C;

  if(istrue(level._id_B76E1ACDF15010D2)) {
    return;
  }
  difficulty = _id_0A0D6D84038540F3(_id_171F90B9C4C76D44);

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
    difficulty = 4;

  switch (difficulty) {
    case 1:
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("ai_density_low", [self]);
      break;
    case 2:
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("ai_density_med", [self]);
      break;
    case 4:
    case 3:
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("ai_density_high", [self]);
      break;
  }
}

_id_68F5D2342AD95772() {
  if(!isDefined(level._id_09FAB40ED3326F8B)) {
    return;
  }
  table = level._id_09FAB40ED3326F8B;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);
  _id_BFD57D442DEE737F = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);

    if(!scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44)) {
      continue;
    }
    if(isDefined(_id_BFD57D442DEE737F) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["relativeDifficulty"]) && _id_171F90B9C4C76D44 == _id_BFD57D442DEE737F) {
      continue;
    }
    _id_B511A23DEC1A289C = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 10));

    if(_id_B511A23DEC1A289C > 0 && _id_B511A23DEC1A289C <= 3) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["relativeDifficulty"] = _id_B511A23DEC1A289C;
      _id_BFD57D442DEE737F = _id_171F90B9C4C76D44;
    }
  }
}

_id_683E582EFD2A8233() {
  if(!isDefined(level._id_09FAB40ED3326F8B)) {
    return;
  }
  table = level._id_09FAB40ED3326F8B;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);
  _id_BFD57D442DEE737F = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);

    if(!scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44)) {
      continue;
    }
    if(isDefined(_id_BFD57D442DEE737F) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["minExtraBuyStations"]) && _id_171F90B9C4C76D44 == _id_BFD57D442DEE737F) {
      continue;
    }
    _id_139FC69CC262B8E9 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 11);

    if(_id_139FC69CC262B8E9 == "") {
      continue;
    }
    _id_ECEE6223BFB23360 = int(_id_139FC69CC262B8E9);
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["minExtraBuyStations"] = _id_ECEE6223BFB23360;
    _id_BFD57D442DEE737F = _id_171F90B9C4C76D44;
  }

  _id_BFD57D442DEE737F = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);

    if(!scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44)) {
      continue;
    }
    if(isDefined(_id_BFD57D442DEE737F) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["maxExtraBuyStations"]) && _id_171F90B9C4C76D44 == _id_BFD57D442DEE737F) {
      continue;
    }
    _id_139FC69CC262B8E9 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 12);

    if(_id_139FC69CC262B8E9 == "") {
      continue;
    }
    _id_E69D6788C495952A = int(_id_139FC69CC262B8E9);
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["maxExtraBuyStations"] = _id_E69D6788C495952A;
    _id_BFD57D442DEE737F = _id_171F90B9C4C76D44;
  }
}