/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\activity_manager.gsc
*****************************************************/

_id_DF15F72187363229() {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_279C4202B5ED4980);

  if(isDefined(level.autoassignfirstquest) && level.autoassignfirstquest == 1 || getdvarint("dvar_85B85AAD9F4AEFEA", 1) == 0) {
    return;
  }
  if(!istrue(level._id_1E0470DBB6CF1859)) {
    while(!isDefined(level.struct_class_names) || !isDefined(level._id_41670C1C65F3D3CF) || _func_9A83377C98BCE82A("everybody") <= 0 || !isDefined(level._id_49A5D647639E781E) || !istrue(level._id_F1073FBD45B59A06._id_9B87FDB80920F442) || !isDefined(level._id_C40817516B7D2B68))
      waitframe();
  } else if(istrue(level._id_1E0470DBB6CF1859)) {
    while(!isDefined(level._id_F1073FBD45B59A06) || !isDefined(level._id_F1073FBD45B59A06._id_DF987907A483DF89))
      waitframe();
  }

  level._id_1B7407DFFE81E6E8 = spawnStruct();
  level._id_1B7407DFFE81E6E8.teamlist = [];
  level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24 = [];
  level._id_FE29A5BF2F96B5D3 = [];

  foreach(node in scripts\engine\utility::getStructArray("dmz_missionObjectiveUniversal", "script_noteworthy"))
  level._id_FE29A5BF2F96B5D3[level._id_FE29A5BF2F96B5D3.size] = node;

  level._id_1B7407DFFE81E6E8._id_A3E3841AB1AFFB3C = getDvar("dvar_518D6090239DF9B9", "mp/dmzactivities.csv");
  level._id_1B7407DFFE81E6E8._id_D6D000F64C923FD6 = getdvarint("dvar_10FCFFFE932C9BD5", 1);
  level._id_13DAF5D5CF8158B2 = getdvarint("dvar_A598966B6E53FDE8", 1);
  level._id_D1404CD77B68F22E = getdvarint("dvar_51CA2E83111F7340", 0);
  level._id_FC3962361E2033A9 = getdvarint("dvar_A17F8C87A9FFEFA6", 1);
  level._id_427F173FA29D4E80 = getdvarint("dvar_F173806BC718DDD1", 1);
  level._id_0A4840E7885EF58E = getdvarint("dvar_66A4A1572A0E159D", 1);

  if(istrue(level._id_1E0470DBB6CF1859))
    level._id_0A4840E7885EF58E = 0;

  level thread _id_97479A799D6EB103();
  level thread _id_4A6ADEB5F340FCC8();

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_22E206CC7AE5DBFD);
}

_id_7460E0ABA0B1F1B3(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_57AC6111C7DB410F(instance, player);
}

_id_ADC51ADE78872D95(team) {
  if(_id_5EA5A722C499078F(team)) {
    _id_EFA8EF05B190D7D0 = _id_B1D0568D9066A2CE(team);

    if(isDefined(_id_EFA8EF05B190D7D0)) {
      _id_45F403E1732217D3::_id_1EF65D2654424502(_id_EFA8EF05B190D7D0, "fail", team);
      _id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] _id_8D4A1199159F7D52(team);
    }
  }

  _id_652F47620AC4713F = scripts\mp\teams::getactiveteamcount();

  if(_id_652F47620AC4713F == 1)
    _id_0419EEBC6F24E287::_id_9AFA2021A101589A();
}

_id_B713F2D39B34540F(data, _id_68E354FCEB08D97B, nodes) {
  data._id_68E354FCEB08D97B = _id_68E354FCEB08D97B;
  data.nodes = nodes;
}

_id_038228778814192A() {
  spawndata = [];
  _id_A3E3841AB1AFFB3C = level._id_1B7407DFFE81E6E8._id_A3E3841AB1AFFB3C;
  _id_977F24E61599CBBA = tablelookupgetnumrows(_id_A3E3841AB1AFFB3C);
  debug = getdvarint("dvar_4CA9133F642D177F", 0) == 1;
  _id_C40817516B7D2B68 = [];

  foreach(set in level._id_C40817516B7D2B68) {
    if(isDefined(set.points)) {
      foreach(point in set.points) {
        if(isDefined(point.origin))
          _id_C40817516B7D2B68[_id_C40817516B7D2B68.size] = point.origin;
      }
    }

    if(isDefined(set.origin))
      _id_C40817516B7D2B68[_id_C40817516B7D2B68.size] = set.origin;
  }

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    enabled = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 2));
    name = tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 0);
    _id_975AFDC14C65649C(name, _id_CB89110314447B2F);
    _id_2362DA841D75B7F2 = getdvarint(_func_2EF675C13CA1C4AF("dvar_1B5FB36050170B0F", name, "_enabled"), -1);

    if(_id_2362DA841D75B7F2 != -1)
      enabled = _id_2362DA841D75B7F2;

    if(!enabled) {
      continue;
    }
    data = spawnStruct();
    data.index = _id_CB89110314447B2F;
    data.type = tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 3);
    data._id_723B8F7CB71CEB11 = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 4));
    data.difficulty = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 5));
    data.priority = float(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 7));
    data._id_44F8910125EC2A45 = float(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 8));
    data._id_51F461A8E820667B = float(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 9));
    data._id_E97D97A56BFE37AD = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 10));
    data._id_322A164A02A90407 = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 11));
    data._id_2CE8F82AD71EB571 = float(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 14));
    data._id_7A62616965ED6A2E = float(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 15));
    _id_EDABFA0430B5AD85 = int(tablelookupbyrow(_id_A3E3841AB1AFFB3C, _id_CB89110314447B2F, 16));

    if(_id_EDABFA0430B5AD85 > 0) {
      foreach(startpoint in _id_C40817516B7D2B68)
      _id_D4D97591648F4390(startpoint, _id_EDABFA0430B5AD85, name, 1);
    }

    _id_A620CB0E6444887F = getdvarint(_func_2EF675C13CA1C4AF("dvar_1B5FB36050170B0F", name, "_numberToSpawn"), -1);

    if(_id_A620CB0E6444887F != -1) {
      data._id_E97D97A56BFE37AD = _id_A620CB0E6444887F;
      data._id_322A164A02A90407 = _id_A620CB0E6444887F;
    }

    switch (name) {
      case "dom":
        _id_0C00335A7AEB2728::_id_80D68C9701E1AEA5(data);
        break;
      case "search":
        _id_358978E883D9F6C2::_id_80D68C9701E1AEA5(data);
        break;
      case "geiger":
        _id_046B3C7D0A4338D8::_id_80D68C9701E1AEA5(data);
        break;
      case "elim":
        _id_3665D737B10B78D9::_id_80D68C9701E1AEA5(data);
        break;
      case "clear":
        _id_6B7618D5EAD05B66::_id_80D68C9701E1AEA5(data);
        break;
      case "trap":
        _id_7FBA4131729FE74D::_id_80D68C9701E1AEA5(data);
        break;
      case "bads":
        break;
      case "sam":
        _id_2E2E13D44D465832::_id_80D68C9701E1AEA5(data);
        break;
      case "demo":
        _id_58FE895FD0FBE620::_id_80D68C9701E1AEA5(data);
        break;
      case "hostage":
        _id_241FF3C86D02A28D::_id_80D68C9701E1AEA5(data);
        break;
      case "safe":
        _id_495022338D50407E::_id_80D68C9701E1AEA5(data);
        break;
      case "boatdrive":
        _id_3E32E216CE730AC2::_id_80D68C9701E1AEA5(data);
        break;
      case "vehicledrive":
        _id_0A62705CB078EC0A::_id_80D68C9701E1AEA5(data);
        break;
      case "hunt":
        _id_0419EEBC6F24E287::_id_80D68C9701E1AEA5(data);
        break;
      case "supply":
        _id_6A9E2D3385424B39::_id_80D68C9701E1AEA5(data);
        break;
      case "convoy_attack":
        _id_34F71BD59550ADCB::_id_80D68C9701E1AEA5(data);
        break;
      case "hacker_phone":
        _id_01193C0B83FCE13B::_id_80D68C9701E1AEA5(data);
        break;
      case "convoy_defend":
        break;
      case "scav":
        _id_78FE9876BB090D6B::_id_80D68C9701E1AEA5(data);
        break;
      default:
    }

    data._id_A620CB0E6444887F = randomintrange(data._id_E97D97A56BFE37AD, data._id_322A164A02A90407 + 1);

    if(!isDefined(data.nodes) || !isarray(data.nodes) || data.nodes.size == 0 || data._id_A620CB0E6444887F <= 0) {
      continue;
    }
    data.spawned = 0;
    data.nodes = scripts\engine\utility::array_randomize(data.nodes);
    spawndata[name] = data;
  }

  return spawndata;
}

_id_AECE1E424E300380() {
  spawndata = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/bractivities.csv");

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    enabled = int(tablelookupbyrow("mp/bractivities.csv", _id_CB89110314447B2F, 2));
    name = tablelookupbyrow("mp/bractivities.csv", _id_CB89110314447B2F, 0);
    _id_975AFDC14C65649C(name, _id_CB89110314447B2F);

    if(!enabled) {
      continue;
    }
    data = spawnStruct();
    data.index = _id_CB89110314447B2F;
    data.type = tablelookupbyrow("mp/bractivities.csv", _id_CB89110314447B2F, 3);
    data._id_723B8F7CB71CEB11 = int(tablelookupbyrow("mp/bractivities.csv", _id_CB89110314447B2F, 4));

    switch (name) {
      case "bomb":
        _id_318621981299585A::_id_7AAE8CB0D8B0AC6A(data);
        break;
      case "poi":
        _id_0EF36A50D9B4627D::_id_7AAE8CB0D8B0AC6A(data);
        break;
      case "hold":
        _id_4F9A55DEE6AEBC8F::_id_7AAE8CB0D8B0AC6A(data);
        break;
      default:
    }

    spawndata[name] = data;
  }

  level._id_1B7407DFFE81E6E8._id_B2F15037287A033A = spawndata;
}

_id_6507DEA837A9799C(name) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A))
    _id_AECE1E424E300380();

  return level._id_1B7407DFFE81E6E8._id_B2F15037287A033A[name];
}

_id_975AFDC14C65649C(type, index) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_CBF0325DFCC5A117))
    level._id_1B7407DFFE81E6E8._id_CBF0325DFCC5A117 = [];

  level._id_1B7407DFFE81E6E8._id_CBF0325DFCC5A117[type] = index;
}

_id_F92C1A3D19210CCD(type) {
  return level._id_1B7407DFFE81E6E8._id_CBF0325DFCC5A117[type];
}

_id_3EE172D5F412DA21() {
  level._id_1B7407DFFE81E6E8._id_B2F15037287A033A = _id_038228778814192A();
  level._id_1B7407DFFE81E6E8._id_BA936A320AE753DD = getdvarint("dvar_B44C01CC57DE403D", 15);
  _id_24D627B48A11F1F1(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A);
  _id_FA609575F2417F18(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A);
}

_id_24D627B48A11F1F1(_id_B2F15037287A033A) {
  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  _id_FCF22B7B64B65CD5 = getdvarint("dvar_870DAD054972BF3E", 2);
  _id_D4A378ED7D56A57A = [];

  foreach(_id_171F90B9C4C76D44, _ in level._id_B205D90302DA2F07) {
    _id_A620CB0E6444887F = getdvarint(_func_2EF675C13CA1C4AF("dvar_C6CEA952B5D6724C", _id_171F90B9C4C76D44), scripts\engine\utility::ter_op(issubstr(_id_171F90B9C4C76D44, "suburb"), 0, _id_FCF22B7B64B65CD5));

    if(_id_A620CB0E6444887F > 0)
      _id_D4A378ED7D56A57A[_id_171F90B9C4C76D44] = _id_A620CB0E6444887F;
  }

  _id_4E01F7C3200A9ADB = 0;

  for(;;) {
    [name, spawndata] = _id_B77F6D389FED1407(_id_B2F15037287A033A);

    if(!isDefined(name) || !isDefined(spawndata)) {
      return;
    }
    foreach(index, node in spawndata.nodes) {
      if(!isDefined(node._id_B205D90302DA2F07))
        node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1);

      if(isDefined(node._id_B205D90302DA2F07) && isDefined(_id_D4A378ED7D56A57A[node._id_B205D90302DA2F07]) && _id_D4A378ED7D56A57A[node._id_B205D90302DA2F07] > 0 && _id_39C4F5C52FB521D8(node.origin, spawndata._id_44F8910125EC2A45, spawndata._id_51F461A8E820667B, name) && !_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin)) {
        _id_FBAC8FE5CBA1BCCD(node, name, spawndata, getdvarint("dvar_4CA9133F642D177F", 0) == 1);
        _id_D4A378ED7D56A57A[node._id_B205D90302DA2F07]--;

        if(_id_D4A378ED7D56A57A[node._id_B205D90302DA2F07] <= 0)
          _id_D4A378ED7D56A57A[node._id_B205D90302DA2F07] = undefined;

        spawndata.nodes[index] = undefined;
        _id_4E01F7C3200A9ADB++;

        if(_id_4E01F7C3200A9ADB >= level._id_1B7407DFFE81E6E8._id_BA936A320AE753DD) {
          _id_4E01F7C3200A9ADB = _id_4E01F7C3200A9ADB - level._id_1B7407DFFE81E6E8._id_BA936A320AE753DD;
          waitframe();
        }

        if(_id_D4A378ED7D56A57A.size <= 0) {
          return;
        }
        spawndata.spawned++;

        if(spawndata.spawned >= spawndata._id_A620CB0E6444887F) {
          break;
        }
      }
    }

    _id_B2F15037287A033A[name] = undefined;
  }
}

_id_FA609575F2417F18(_id_B2F15037287A033A) {
  _id_4E01F7C3200A9ADB = 0;

  for(;;) {
    [name, spawndata] = _id_B77F6D389FED1407(_id_B2F15037287A033A);

    if(!isDefined(name) || !isDefined(spawndata)) {
      break;
    }

    if(spawndata.spawned < spawndata._id_A620CB0E6444887F) {
      foreach(node in spawndata.nodes) {
        if(!isDefined(node._id_B205D90302DA2F07))
          node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1);

        if(_id_39C4F5C52FB521D8(node.origin, spawndata._id_44F8910125EC2A45, spawndata._id_51F461A8E820667B, name) && (!_id_5DEF7AF2A9F04234::_id_47D356083884F913() || !isDefined(node._id_B205D90302DA2F07) || _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(node._id_B205D90302DA2F07)) && !_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin)) {
          _id_FBAC8FE5CBA1BCCD(node, name, spawndata, getdvarint("dvar_4CA9133F642D177F", 0) == 1);
          _id_4E01F7C3200A9ADB++;

          if(_id_4E01F7C3200A9ADB >= level._id_1B7407DFFE81E6E8._id_BA936A320AE753DD) {
            _id_4E01F7C3200A9ADB = _id_4E01F7C3200A9ADB - level._id_1B7407DFFE81E6E8._id_BA936A320AE753DD;
            waitframe();
          }

          spawndata.spawned++;

          if(spawndata.spawned >= spawndata._id_A620CB0E6444887F) {
            break;
          }
        }
      }
    }

    _id_B2F15037287A033A[name] = undefined;
  }
}

_id_F222BD80432744FF(name) {
  _id_FFBCB57FE99F4F32 = self;
  spawndata = _id_6507DEA837A9799C(name);
  _id_EFA8EF05B190D7D0 = _id_AEBC13D5B1E8D58D();
  _id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] = [[spawndata._id_68E354FCEB08D97B]](_id_EFA8EF05B190D7D0, _id_FFBCB57FE99F4F32);
  _id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11 = spawndata._id_723B8F7CB71CEB11;
  _id_EFA8EF05B190D7D0.name = name;
  _id_EFA8EF05B190D7D0.origin = _id_FFBCB57FE99F4F32.origin;
  _id_EFA8EF05B190D7D0.type = spawndata.type;
  level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_EFA8EF05B190D7D0.id] = _id_EFA8EF05B190D7D0;
  return _id_EFA8EF05B190D7D0 _id_5C8FA034ED436A02();
}

_id_FBAC8FE5CBA1BCCD(node, name, spawndata, debug) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && !isDefined(node._id_B205D90302DA2F07))
    node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1);

  if(_id_4948CDF739393D2D::_id_2D421D1F793F6F93() && !isDefined(node._id_276AC5E84835EA87))
    node._id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(node.origin);

  _id_D4D97591648F4390(node.origin, spawndata._id_44F8910125EC2A45, name);
  _id_EFA8EF05B190D7D0 = _id_AEBC13D5B1E8D58D();
  _id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] = [[spawndata._id_68E354FCEB08D97B]](_id_EFA8EF05B190D7D0, node);
  _id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11 = spawndata._id_723B8F7CB71CEB11;
  _id_EFA8EF05B190D7D0.name = name;
  _id_EFA8EF05B190D7D0.origin = node.origin;
  _id_EFA8EF05B190D7D0._id_B205D90302DA2F07 = node._id_B205D90302DA2F07;
  _id_EFA8EF05B190D7D0._id_276AC5E84835EA87 = node._id_276AC5E84835EA87;
  _id_EFA8EF05B190D7D0.type = spawndata.type;
  level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_EFA8EF05B190D7D0.id] = _id_EFA8EF05B190D7D0;
  _id_EFA8EF05B190D7D0 thread _id_5C8FA034ED436A02();
  return _id_EFA8EF05B190D7D0;
}

_id_39C4F5C52FB521D8(origin, _id_83D4D63F858EEBB6, _id_FD8A6EBE7CE71B34, name) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4))
    level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4 = [];

  foreach(point in level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4) {
    dist = distance(origin, point.origin);

    if(istrue(point._id_03D250F9D9916A3C)) {
      if(point.name == name && dist < point.radius)
        return 0;
    } else if(dist < point.radius || dist < _id_83D4D63F858EEBB6 || point.name == name && dist < _id_FD8A6EBE7CE71B34)
      return 0;
  }

  return 1;
}

_id_D4D97591648F4390(origin, radius, name, _id_03D250F9D9916A3C) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4))
    level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4 = [];

  point = spawnStruct();
  point.origin = origin;
  point.radius = radius;
  point.name = name;
  point._id_03D250F9D9916A3C = _id_03D250F9D9916A3C;
  level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4[level._id_1B7407DFFE81E6E8._id_697F8897FF4784D4.size] = point;
}

_id_B77F6D389FED1407(spawndata) {
  if(!isDefined(spawndata) || spawndata.size <= 0)
    return [undefined, undefined];

  _id_CACCB7944FF88B19 = -1;
  _id_9A9347CCD8359D98 = undefined;
  _id_939BDF45CE71425B = undefined;

  foreach(name, data in spawndata) {
    if(data.priority > _id_CACCB7944FF88B19) {
      _id_CACCB7944FF88B19 = data.priority;
      _id_9A9347CCD8359D98 = name;
      _id_939BDF45CE71425B = data;
    }
  }

  return [_id_9A9347CCD8359D98, _id_939BDF45CE71425B];
}

_id_5C8FA034ED436A02() {
  foreach(index, _id_B8EBE3F71A08AB40 in self._id_B7718B6E41108129) {
    _id_B8EBE3F71A08AB40.index = index;

    if(isDefined(_id_B8EBE3F71A08AB40.funcs["onInit"]))
      _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.funcs["onInit"]]]();
  }
}

_id_97479A799D6EB103() {
  _id_DB5B04BC41F47C73 = 0;
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1 = [];

  if(istrue(level._id_1E0470DBB6CF1859)) {
    level _id_744CAD313ED0A87E::_id_2E6A3F3E4D2731EA(1);

    if(istrue(level._id_187B57DD871EC189)) {
      foreach(agent in _func_B4B9401715CF98EA("everybody"))
      _id_234DFCCD8495C7D1(agent.team);

      _id_DB5B04BC41F47C73 = _func_9A83377C98BCE82A("everybody");
    }
  } else {
    level _id_3EE172D5F412DA21();
    level thread _id_98C331A3E2621695();
    level _id_84ED600D2BD001AD();

    if(getdvarint("dvar_5EBC91CFDC6A2402", 0))
      level thread _id_0419EEBC6F24E287::_id_7562A66C42D923DC();
  }

  level._id_1B7407DFFE81E6E8.totalplayers = level.players.size + _id_DB5B04BC41F47C73;

  foreach(player in level.players)
  _id_234DFCCD8495C7D1(player.team);

  _id_93AA5AC7D4107DAB = getdvarint("dvar_7AA1F51E05F1BD54", 5);

  if(_id_93AA5AC7D4107DAB > 0)
    level thread _id_672B3BF78B2F92E7(_id_93AA5AC7D4107DAB);
}

_id_672B3BF78B2F92E7(_id_93AA5AC7D4107DAB) {
  for(;;) {
    if(level._id_1B7407DFFE81E6E8.totalplayers < level.players.size) {
      foreach(player in level.players) {
        if(!isDefined(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[player.team]))
          _id_234DFCCD8495C7D1(player.team);
      }
    }

    level._id_1B7407DFFE81E6E8.totalplayers = level.players.size;

    if(istrue(level._id_187B57DD871EC189))
      level._id_1B7407DFFE81E6E8.totalplayers = level.players.size + level._id_41670C1C65F3D3CF.spawned["everybody"].size;

    wait(_id_93AA5AC7D4107DAB);
  }
}

_id_234DFCCD8495C7D1(_id_FABF84450735DD93) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93])) {
    level._id_1B7407DFFE81E6E8.teamlist[level._id_1B7407DFFE81E6E8.teamlist.size] = _id_FABF84450735DD93;
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93] = spawnStruct();
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_6299084AE61B350A = [];
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_ACB56EDCF61F231C = -1;
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_83ABCB9B3A5DBE24 = [];
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_4245D658E9AE8A3D = 0;
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93].active = 0;
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_388B0969AE3525F2 = [];

    if(level._id_0A4840E7885EF58E > 1) {
      if(!_id_5EA5A722C499078F(_id_FABF84450735DD93)) {
        player = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players")[0];

        if(isDefined(player)) {
          _id_EFA8EF05B190D7D0 = _id_EBE9B1E455D46450(player);

          if(isDefined(_id_EFA8EF05B190D7D0))
            _id_EFA8EF05B190D7D0 _id_3FAA04EF514A5FC4(_id_FABF84450735DD93);
        }
      }
    }
  }
}

_id_821FA443949531C9(_id_E1DD7BED632A13C3, _id_EFA8EF05B190D7D0) {
  _id_FFBCB57FE99F4F32 = self;
  level endon("game_ended");
  _id_E1DD7BED632A13C3 endon("deleted");
  _id_E1DD7BED632A13C3 endon("activity_ended");
  _id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E = [];
  _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D = [];
  _id_FFBCB57FE99F4F32 thread _id_F222BD80432744FF(_id_EFA8EF05B190D7D0);

  for(;;) {
    _id_FD2E17866307AAA5 = 0;
    _id_E1DD7BED632A13C3 waittill("trigger", ent);

    if(!istrue(_id_FFBCB57FE99F4F32._id_7BE8B486A10B3DE8) || istrue(level._id_6E53394B95FDE2BF) && !istrue(_id_FFBCB57FE99F4F32._id_7F893C2E20A823DB)) {
      continue;
    }
    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      if(!isDefined(occupants)) {
        continue;
      }
      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(_id_E1DD7BED632A13C3 _id_1A0A0367591E7F87(_id_F85572CD5F6117C6)) {
          _id_FD2E17866307AAA5 = _id_E1DD7BED632A13C3 _id_7098FF5BC0EC9505(_id_F85572CD5F6117C6, _id_E1DD7BED632A13C3.entnum, _id_FFBCB57FE99F4F32);

          if(_id_FD2E17866307AAA5)
            _id_E1DD7BED632A13C3 _id_C4839E806AC50BD6(_id_F85572CD5F6117C6);
        }
      }

      continue;
    }

    if(_id_E1DD7BED632A13C3 _id_1A0A0367591E7F87(ent)) {
      _id_FD2E17866307AAA5 = _id_E1DD7BED632A13C3 _id_7098FF5BC0EC9505(ent, _id_E1DD7BED632A13C3.entnum, _id_FFBCB57FE99F4F32);

      if(_id_FD2E17866307AAA5)
        _id_E1DD7BED632A13C3 _id_C4839E806AC50BD6(ent);
    }
  }
}

_id_C4839E806AC50BD6(player) {
  _id_E1DD7BED632A13C3 = self;
  _id_C53E78332A6C514F = player getentitynumber();

  if(!isDefined(_id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E[_id_C53E78332A6C514F])) {
    _id_E1DD7BED632A13C3 notify("trigger_enter", player);
    _id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E[_id_C53E78332A6C514F] = player;
    _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D[_id_C53E78332A6C514F] = gettime();
  } else
    _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D[_id_C53E78332A6C514F] = gettime();
}

_id_1A0A0367591E7F87(player) {
  _id_7426B3050C68B548 = self;

  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  if(istrue(_id_7426B3050C68B548.trigger_off))
    return 0;

  if(!istrue(level._id_187B57DD871EC189)) {
    if(!isbot(player) && scripts\cp_mp\utility\game_utility::isaigameparticipant(player))
      return 0;

    if(!scripts\cp_mp\utility\game_utility::isgameparticipant(player))
      return 0;

    if(isagent(player) && (!isDefined(player.team) || !isDefined(_id_7426B3050C68B548.numtouching[player.team])))
      return 0;
  }

  if(isDefined(player.classname) && player.classname == "script_vehicle")
    return 0;

  return 1;
}

_id_7098FF5BC0EC9505(player, _id_E619EFB5B1203664, _id_FFBCB57FE99F4F32) {
  _id_C53E78332A6C514F = player getentitynumber();
  return _id_CED68E0624873AF5(player, _id_E619EFB5B1203664, _id_FFBCB57FE99F4F32);
}

_id_A33C10C0682918BD(_id_E1DD7BED632A13C3, _id_9399BF62B66519D1) {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  _id_E1DD7BED632A13C3 endon("deleted");
  _id_E1DD7BED632A13C3 endon("activity_ended");
  _id_D0FF518E0D3279C6 = 1;

  if(!isDefined(_id_9399BF62B66519D1))
    _id_9399BF62B66519D1 = 9000;

  _id_51785C3DCE118D4B = 0;

  if(!isDefined(_id_E1DD7BED632A13C3._id_51785C3DCE118D4B))
    _id_51785C3DCE118D4B = 300;
  else
    _id_51785C3DCE118D4B = _id_E1DD7BED632A13C3._id_51785C3DCE118D4B;

  _id_94CEEE32950DDF00 = _id_51785C3DCE118D4B / 1000;

  for(;;) {
    wait(_id_94CEEE32950DDF00);
    waittillframeend;

    foreach(_id_C53E78332A6C514F, _id_7C991DCBC6A72C19 in _id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E) {
      if(!isDefined(_id_7C991DCBC6A72C19)) {
        _id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E[_id_C53E78332A6C514F] = undefined;
        _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D[_id_C53E78332A6C514F] = undefined;
        continue;
      }

      currenttime = gettime();
      _id_CA63CBDF2251B4AF = currenttime - _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D[_id_C53E78332A6C514F];

      if(_id_CA63CBDF2251B4AF > _id_9399BF62B66519D1) {
        _id_E1DD7BED632A13C3 notify("trigger_exit", _id_7C991DCBC6A72C19);

        if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerExitTimeout"]))
          _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerExitTimeout"]]](_id_7C991DCBC6A72C19);

        _id_E1DD7BED632A13C3._id_ABE8F125E1A6AD1E[_id_C53E78332A6C514F] = undefined;
        _id_E1DD7BED632A13C3._id_3551BEFC72F03B2D[_id_C53E78332A6C514F] = undefined;
        continue;
      }

      if(_id_CA63CBDF2251B4AF > _id_51785C3DCE118D4B) {
        if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerExitVolume"]))
          _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerExitVolume"]]](_id_7C991DCBC6A72C19);

        continue;
      }

      if(istrue(_id_7C991DCBC6A72C19._id_E09C6EA56555F1ED)) {
        if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerReenterVolume"]))
          _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerReenterVolume"]]](_id_7C991DCBC6A72C19);
      }
    }
  }
}

_id_98C331A3E2621695() {
  for(;;) {
    foreach(_id_EFA8EF05B190D7D0 in level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24) {
      if(isDefined(_id_EFA8EF05B190D7D0)) {
        foreach(team, index in _id_EFA8EF05B190D7D0.teams) {
          if(!level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team].active) {
            foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
              if(distancesquared(player.origin, _id_EFA8EF05B190D7D0.origin) < _id_EFA8EF05B190D7D0._id_8D3A05143C7A1142) {
                _id_EFA8EF05B190D7D0 _id_3262F80D2B114587(team);
                break;
              }
            }
          }
        }
      }
    }

    wait 1;
  }
}

_id_C509B7FAAE587820(_id_FFBCB57FE99F4F32) {
  player = self;

  if(istrue(istrue(player._id_38F4F1B1C66513F1)))
    return 0;

  if(!level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[player.team].active) {
    if(!isDefined(_id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40))
      return 0;
  } else if(!scripts\engine\utility::array_contains(_id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40.players, player)) {
    _id_388B0969AE3525F2 = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[player.team]._id_388B0969AE3525F2;

    foreach(_id_EFA8EF05B190D7D0 in _id_388B0969AE3525F2) {
      if(!isDefined(_id_EFA8EF05B190D7D0._id_B7718B6E41108129)) {
        continue;
      }
      foreach(_id_B8EBE3F71A08AB40 in _id_EFA8EF05B190D7D0._id_B7718B6E41108129) {
        if(!isDefined(_id_B8EBE3F71A08AB40)) {
          continue;
        }
        if(scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.players, player)) {
          _id_5D7B8825AE739AB4 = distance2d(_id_B8EBE3F71A08AB40.circlecenter, player.origin);
          _id_3C7FA17BE3F77A08 = distance2d(_id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40.circlecenter, player.origin);

          if(_id_5D7B8825AE739AB4 > _id_3C7FA17BE3F77A08 && !istrue(player._id_38F4F1B1C66513F1))
            player thread _id_0513D7F67AB57C97(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0, _id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0);

          return 0;
        }
      }
    }
  } else if(scripts\engine\utility::array_contains(_id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40.players, player))
    return 1;

  player playlocalsound("mp_dmz_phone_pickup");
  _id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0 _id_3FAA04EF514A5FC4(player.team, undefined, player, 1);
  _id_FFBCB57FE99F4F32._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0 _id_6E31CC7110B536FD(player.team);
  return 1;
}

_id_CED68E0624873AF5(player, _id_E619EFB5B1203664, _id_FFBCB57FE99F4F32) {
  if(isDefined(_id_FFBCB57FE99F4F32))
    return player _id_C509B7FAAE587820(_id_FFBCB57FE99F4F32);

  return 0;
}

_id_018D4E8025EC24A0(_id_B8EBE3F71A08AB40, _id_5E671FC71E72D5E8, _id_644A33D86D8514BF) {
  _id_C893965B0B5CC806 = isDefined(_id_5E671FC71E72D5E8);
  _id_7BAF547D7EB18030 = _id_B8EBE3F71A08AB40.index + 1;

  foreach(_id_729F88304CD1D6F8 in _id_B8EBE3F71A08AB40.teams) {
    _id_8EB7AFC94E00A6C2 = _id_C893965B0B5CC806 && _id_729F88304CD1D6F8 == _id_5E671FC71E72D5E8;

    if(_id_7BAF547D7EB18030 >= self._id_B7718B6E41108129.size) {
      _id_6C4E8CEA70BF4B6D::_id_83D7EB52598BE0B3(_id_729F88304CD1D6F8);
      _id_1F97A44D1761C919::_id_70979C1EABF04180(scripts\mp\utility\teams::getteamdata(_id_729F88304CD1D6F8, "players"), self.name);
      level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_729F88304CD1D6F8].active = 0;

      if(_id_8EB7AFC94E00A6C2) {
        players = scripts\mp\utility\teams::getteamdata(_id_729F88304CD1D6F8, "players");

        foreach(player in players) {
          if(!isDefined(player.brmissionscompleted))
            player.brmissionscompleted = 0;

          player.brmissionscompleted++;
          player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_4F33A2C9E6F878F3");

          if(istrue(level._id_9FB5000AE38DCF7F))
            player setclientomnvar("ui_dmz_missions_completed", 0);

          player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);
        }

        level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_729F88304CD1D6F8]._id_4245D658E9AE8A3D++;
        _id_45F403E1732217D3::_id_1EF65D2654424502(self, "success", _id_5E671FC71E72D5E8);
        _id_4AB01941798B314C = undefined;

        if(isDefined(self._id_5EA1BE154AEB609B) && isDefined(self._id_5EA1BE154AEB609B._id_4AB01941798B314C))
          _id_4AB01941798B314C = self._id_5EA1BE154AEB609B._id_4AB01941798B314C;

        _id_6A8EC730B2BFA844::_id_A9F8FA06A358585B(_id_5E671FC71E72D5E8, self.name, 1, _id_4AB01941798B314C);

        if(isDefined(level._id_FAA873310ADD1096))
          level[[level._id_FAA873310ADD1096]](_id_729F88304CD1D6F8, self);
      }

      if(!istrue(_id_644A33D86D8514BF))
        thread _id_6C4E8CEA70BF4B6D::_id_137D718C82AC0947(_id_729F88304CD1D6F8);

      continue;
    }

    self._id_B7718B6E41108129[_id_7BAF547D7EB18030].teams[self._id_B7718B6E41108129[_id_7BAF547D7EB18030].teams.size] = _id_729F88304CD1D6F8;
    self.teams[_id_729F88304CD1D6F8] = _id_7BAF547D7EB18030;
    _id_6C4E8CEA70BF4B6D::_id_B7BBE29ED551EE90(self._id_B7718B6E41108129[_id_7BAF547D7EB18030]._id_30E8A65CFF941C7A, self._id_B7718B6E41108129[_id_7BAF547D7EB18030].tier, _id_729F88304CD1D6F8);
    _id_675059586A84FA06(_id_729F88304CD1D6F8, "onTeamStart");
    self._id_B7718B6E41108129[_id_7BAF547D7EB18030].started = 1;
  }

  if(_id_7BAF547D7EB18030 >= self._id_B7718B6E41108129.size)
    _id_97156D82E0AF9453(_id_5E671FC71E72D5E8);

  _id_B8EBE3F71A08AB40 notify("task_ended");
}

_id_97156D82E0AF9453(_id_5E671FC71E72D5E8) {
  level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[self.id] = undefined;

  if(isDefined(self._id_5EA1BE154AEB609B)) {
    level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38, self._id_5EA1BE154AEB609B);
    self._id_5EA1BE154AEB609B setscriptablepartstate("brloot_activity_starter", "hidden");
  }

  foreach(team, _id_B8EBE3F71A08AB40 in self.teams) {
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24, self.id);

    if(!_id_5EA5A722C499078F(team))
      _id_D8625665D55F3941(team, 1);

    if(level._id_0A4840E7885EF58E > 0) {
      if(!_id_5EA5A722C499078F(team)) {
        player = scripts\mp\utility\teams::getteamdata(team, "players")[0];

        if(isDefined(player)) {
          _id_EFA8EF05B190D7D0 = _id_EBE9B1E455D46450(player);

          if(isDefined(_id_EFA8EF05B190D7D0))
            _id_EFA8EF05B190D7D0 _id_3FAA04EF514A5FC4(team);
        }
      }
    }

    if(!level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team].active)
      _id_3FD9D5652F4642AD(team);
  }
}

_id_3262F80D2B114587(team) {
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team].active = 1;
  _id_675059586A84FA06(team, "onTeamStart");
  self._id_B7718B6E41108129[0].started = 1;
  _id_B8EBE3F71A08AB40 = _id_73FD6FE2488E3EBF(self, team);
  _id_6C4E8CEA70BF4B6D::_id_B7BBE29ED551EE90(_id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A, _id_6C4E8CEA70BF4B6D::_id_F8CD22FB229F4138(self._id_723B8F7CB71CEB11), team);
}

_id_6E31CC7110B536FD(team) {
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team].active = 1;
  self._id_B7718B6E41108129[0].started = 1;
}

_id_0BF253015FF42711(player, team) {
  _id_EFA8EF05B190D7D0 = _id_B1D0568D9066A2CE(team);
  _id_EFA8EF05B190D7D0 _id_D36579BAB450735A(player, team);

  foreach(_id_B8EBE3F71A08AB40 in _id_EFA8EF05B190D7D0._id_B7718B6E41108129) {
    if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerJoined"]))
      _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerJoined"]]](player);
  }

  _id_EFA8EF05B190D7D0 _id_37DB4C1F01E80F2F(team);
}

_id_90603F537224E960() {
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();

  if(isDefined(self.funcs["onForceEnd"]))
    self thread[[self.funcs["onForceEnd"]]]();
}

_id_8D4A1199159F7D52(team) {
  if(isDefined(self.funcs["onCancel"]))
    self thread[[self.funcs["onCancel"]]](team);
}

_id_B2AEF739A3653A70(player, team) {
  _id_EFA8EF05B190D7D0 = _id_B1D0568D9066A2CE(team);
  _id_6C4E8CEA70BF4B6D::_id_6D93BE335873296E(player);

  if(isDefined(_id_EFA8EF05B190D7D0._id_B7718B6E41108129[0].icon))
    _id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
  else if(isDefined(_id_EFA8EF05B190D7D0._id_B7718B6E41108129[0].objidnum))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_EFA8EF05B190D7D0._id_B7718B6E41108129[0].objidnum, player);

  foreach(_id_B8EBE3F71A08AB40 in _id_EFA8EF05B190D7D0._id_B7718B6E41108129) {
    if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"]))
      _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"]]](player);
  }

  if(isDefined(_id_EFA8EF05B190D7D0._id_972EDDBDCF30619C))
    _id_EFA8EF05B190D7D0._id_972EDDBDCF30619C = scripts\engine\utility::array_remove(_id_EFA8EF05B190D7D0._id_972EDDBDCF30619C, player);

  if(!_id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] _id_0C251E35450891F3())
    _id_EFA8EF05B190D7D0._id_B7718B6E41108129[0] _id_8D4A1199159F7D52(team);
  else
    _id_EFA8EF05B190D7D0 _id_37DB4C1F01E80F2F(team);
}

_id_0513D7F67AB57C97(_id_620CF537A8109AF8, _id_580E2B2CD55B4B53) {
  player = self;

  if(istrue(player._id_38F4F1B1C66513F1))
    return 0;

  player._id_38F4F1B1C66513F1 = 1;
  _id_620CF537A8109AF8 _id_B2AEF739A3653A70(player, player.team);
  wait 3;
  player playlocalsound("mp_dmz_phone_pickup");
  _id_580E2B2CD55B4B53 _id_3FAA04EF514A5FC4(player.team, undefined, player, 1);
  _id_580E2B2CD55B4B53 _id_6E31CC7110B536FD(player.team);
  player._id_38F4F1B1C66513F1 = 0;
  return 1;
}

_id_22E206CC7AE5DBFD(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_5EA5A722C499078F(_id_8A04AA0E0755E7E3))
    _id_B2AEF739A3653A70(player, _id_8A04AA0E0755E7E3);

  _id_6C4E8CEA70BF4B6D::_id_6D93BE335873296E(player);
  _id_3DD2C57AC95BE94F = _id_5EA5A722C499078F(_id_EB06B338608EF354);

  if(_id_5EA5A722C499078F(_id_EB06B338608EF354))
    _id_0BF253015FF42711(player, _id_EB06B338608EF354);

  _id_64623E2FF7409F39(player, !_id_3DD2C57AC95BE94F || istrue(player._id_45B8E84DE48BB89F));
}

_id_3FAA04EF514A5FC4(team, _id_D3DDDED84427DD1C, _id_27E49251BB3376EA, _id_21D04CE2F9146315) {
  if(_id_5EA5A722C499078F(team) && !istrue(_id_21D04CE2F9146315)) {
    return;
  }
  if(!isDefined(_id_D3DDDED84427DD1C))
    _id_D3DDDED84427DD1C = 0;

  if(isDefined(self._id_5EA1BE154AEB609B)) {
    level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38, self._id_5EA1BE154AEB609B);
    self._id_5EA1BE154AEB609B setscriptablepartstate("brloot_activity_starter", "hidden");
  }

  if(istrue(level._id_9FB5000AE38DCF7F)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
    player setclientomnvar("ui_dmz_missions_completed", 1);
  }

  if(!scripts\cp_mp\utility\game_utility::isaigameparticipant(_id_27E49251BB3376EA)) {
    _id_D8625665D55F3941(team, 0);
    _id_1F97A44D1761C919::_id_2C722A2EF9574E87(scripts\mp\utility\teams::getteamdata(team, "players"), self.name, 75);
  }

  self.teams[team] = _id_D3DDDED84427DD1C;

  if(!scripts\engine\utility::array_contains(self._id_B7718B6E41108129[_id_D3DDDED84427DD1C].teams, team))
    self._id_B7718B6E41108129[_id_D3DDDED84427DD1C].teams[self._id_B7718B6E41108129[_id_D3DDDED84427DD1C].teams.size] = team;

  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24 = scripts\engine\utility::array_add(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24, self.id);
  self._id_7CA287A82F54E4F6 = _id_27E49251BB3376EA;

  if(!scripts\cp_mp\utility\game_utility::isaigameparticipant(_id_27E49251BB3376EA))
    thread _id_415205C2B0DF5476(team, _id_27E49251BB3376EA);

  foreach(_id_B8EBE3F71A08AB40 in self._id_B7718B6E41108129) {
    if(isDefined(_id_B8EBE3F71A08AB40.funcs["onTeamAssigned"]))
      _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onTeamAssigned"]]](team);

    if(isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"]) && isDefined(_id_B8EBE3F71A08AB40.funcs["onPlayerJoined"]))
      _id_B8EBE3F71A08AB40 _id_ECEF3F5E98FB83C1(team, _id_27E49251BB3376EA);
  }

  _id_4AB01941798B314C = undefined;

  if(isDefined(self._id_5EA1BE154AEB609B) && isDefined(self._id_5EA1BE154AEB609B._id_4AB01941798B314C))
    _id_4AB01941798B314C = self._id_5EA1BE154AEB609B._id_4AB01941798B314C;

  _id_6A8EC730B2BFA844::_id_A9F8FA06A358585B(team, self.name, 0, _id_4AB01941798B314C);
  _id_189B67B2735B981D::_id_44CDB18EB18593DE(team, self);
}

_id_ECEF3F5E98FB83C1(_id_FABF84450735DD93, player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_F1C8753E7038E53F = _id_B8EBE3F71A08AB40.teams.size == 1;
  _id_F9D50B9D04AF1C7F = _id_B8EBE3F71A08AB40.players.size == 0;
  _id_0404766DB14E343F = 0;
  _id_96710DFE8FA22D93 = 0;
  _id_A61C75B156FC1EE0 = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_388B0969AE3525F2.size;

  if(_id_F9D50B9D04AF1C7F) {
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_388B0969AE3525F2[_id_A61C75B156FC1EE0] = _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0;
    _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"]]](_id_FABF84450735DD93, player);
    return;
  }

  if(_id_B8EBE3F71A08AB40.teams.size >= 0) {
    foreach(_id_6D018F66068582C5 in _id_B8EBE3F71A08AB40.players) {
      if(!isDefined(_id_6D018F66068582C5) || !isDefined(_id_6D018F66068582C5.team)) {
        continue;
      }
      if(player.team == _id_6D018F66068582C5.team) {
        _id_0404766DB14E343F = 1;
        break;
      }
    }

    if(!_id_0404766DB14E343F && !_id_F1C8753E7038E53F)
      _id_96710DFE8FA22D93 = 1;
  }

  if(_id_0404766DB14E343F) {
    _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerJoined"]]](player);
    return;
  }

  if(!_id_F9D50B9D04AF1C7F && _id_96710DFE8FA22D93) {
    level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_388B0969AE3525F2[_id_A61C75B156FC1EE0] = _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0;
    _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"]]](_id_FABF84450735DD93, player);
  }
}

_id_D36579BAB450735A(player, team) {
  if(istrue(level._id_427F173FA29D4E80) && !istrue(level._id_1E0470DBB6CF1859)) {
    _id_B8EBE3F71A08AB40 = _id_73FD6FE2488E3EBF(self, team);
    _id_6C4E8CEA70BF4B6D::_id_B43E9536B7E60884(player, _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A);
  }

  if(isDefined(self._id_B7718B6E41108129[0].icon))
    self._id_B7718B6E41108129[0] _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
  else if(isDefined(self._id_B7718B6E41108129[0].objidnum))
    objective_showtoplayersinmask(self._id_B7718B6E41108129[0].objidnum);
}

_id_415205C2B0DF5476(team, _id_27E49251BB3376EA) {
  info = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team];
  info._id_ACB56EDCF61F231C = info._id_ACB56EDCF61F231C + 1;
  info._id_ACB56EDCF61F231C = scripts\engine\utility::ter_op(info._id_ACB56EDCF61F231C >= level._id_FC3962361E2033A9, 0, info._id_ACB56EDCF61F231C);

  foreach(index, id in info._id_6299084AE61B350A) {
    if(!isDefined(level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[id]))
      info._id_ACB56EDCF61F231C = index;
  }

  if(isDefined(info._id_6299084AE61B350A[info._id_ACB56EDCF61F231C])) {
    _id_F33DEDF5E2DC3021 = level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[info._id_6299084AE61B350A[info._id_ACB56EDCF61F231C]];

    if(isDefined(_id_F33DEDF5E2DC3021)) {
      if(level._id_D1404CD77B68F22E == 0) {
        return;
      }
      if(isDefined(self._id_B7718B6E41108129[0].icon))
        _id_F33DEDF5E2DC3021._id_B7718B6E41108129[0] _id_6C4E8CEA70BF4B6D::_id_743033B2E6C2D930(team);
      else if(isDefined(self._id_B7718B6E41108129[0].objidnum))
        _id_F33DEDF5E2DC3021._id_B7718B6E41108129[0] _id_6C4E8CEA70BF4B6D::_id_E8D8DF3DA4392F0F(team);
    }
  }

  info._id_6299084AE61B350A[info._id_ACB56EDCF61F231C] = self.id;

  if(istrue(level._id_427F173FA29D4E80) && !istrue(level._id_1E0470DBB6CF1859)) {
    _id_B8EBE3F71A08AB40 = _id_73FD6FE2488E3EBF(self, team);
    _id_6C4E8CEA70BF4B6D::_id_B7BBE29ED551EE90(_id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A, _id_6C4E8CEA70BF4B6D::_id_F8CD22FB229F4138(self._id_723B8F7CB71CEB11), team);
  }

  if(!isDefined(self._id_B7718B6E41108129[0].icon) && !isDefined(self._id_B7718B6E41108129[0].objidnum)) {
    return;
  }
  self._id_B7718B6E41108129[0] endon("task_ended");
  self._id_B7718B6E41108129[0] _id_00CED2DBD3BA98D2(team, _id_27E49251BB3376EA, 1);
}

_id_00CED2DBD3BA98D2(team, _id_27E49251BB3376EA, _id_8064F574A628C5EE) {
  wait 2.4;

  if(isDefined(self.icon))
    _id_6C4E8CEA70BF4B6D::_id_A92867E16C21DA22(team);
  else if(isDefined(self.objidnum))
    _id_6C4E8CEA70BF4B6D::_id_30C89AC91CFAE119(team);

  if(!isDefined(_id_27E49251BB3376EA)) {
    return;
  }
  if(istrue(_id_8064F574A628C5EE)) {
    wait 2;

    if(isDefined(self.objidnum) || isDefined(self.icon)) {
      origin = self.origin;

      if(isDefined(self._id_7919C8F3A10FEB86))
        origin = self._id_7919C8F3A10FEB86;

      if(isDefined(self.curorigin))
        origin = self.curorigin;

      if(isDefined(self.offset3d))
        origin = origin + self.offset3d;

      _id_23EBE333D480B214 = scripts\engine\utility::_id_53C4C53197386572(self.icon, self.objidnum);
      scripts\mp\objidpoolmanager::objective_set_play_intro(_id_23EBE333D480B214, 0);
      _id_27E49251BB3376EA calloutmarkerping_create(11, origin, _id_23EBE333D480B214);
    }
  }
}

_id_3FD9D5652F4642AD(team) {
  if(!_id_5EA5A722C499078F(team)) {
    return;
  }
  _id_DAD9C3E8B724D629 = scripts\mp\utility\teams::getteamdata(team, "players")[0];

  if(!isDefined(_id_DAD9C3E8B724D629)) {
    return;
  }
  _id_D7AD79A8E4F34D8D = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24[0];
  _id_42CA41C7DADAE0C0 = 100000000;

  foreach(id in level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24) {
    _id_72CB45D542FA0766 = level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[id].origin;
    dist = distancesquared(_id_72CB45D542FA0766, _id_DAD9C3E8B724D629.origin);

    if(dist < _id_42CA41C7DADAE0C0) {
      _id_42CA41C7DADAE0C0 = dist;
      _id_D7AD79A8E4F34D8D = id;
    }
  }

  if(!scripts\engine\utility::array_contains(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_6299084AE61B350A, _id_D7AD79A8E4F34D8D))
    level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_D7AD79A8E4F34D8D] thread _id_415205C2B0DF5476(team, _id_DAD9C3E8B724D629);
}

_id_AEBC13D5B1E8D58D() {
  _id_EFA8EF05B190D7D0 = spawnStruct();
  _id_EFA8EF05B190D7D0._id_46334D99742B3BF3 = 0;
  _id_EFA8EF05B190D7D0.id = _id_A4316795AF2639F3();
  _id_EFA8EF05B190D7D0.teams = [];
  _id_EFA8EF05B190D7D0._id_B7718B6E41108129 = [];
  _id_EFA8EF05B190D7D0._id_8573076FA89267A1 = 2500;
  _id_EFA8EF05B190D7D0._id_8D3A05143C7A1142 = _id_EFA8EF05B190D7D0._id_8573076FA89267A1 * _id_EFA8EF05B190D7D0._id_8573076FA89267A1;
  _id_EFA8EF05B190D7D0.origin = (0, 0, 0);
  _id_EFA8EF05B190D7D0._id_75DED47B03386E57 = 0;
  return _id_EFA8EF05B190D7D0;
}

_id_A4316795AF2639F3() {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_8D03DA3910129D74))
    level._id_1B7407DFFE81E6E8._id_8D03DA3910129D74 = 0;
  else
    level._id_1B7407DFFE81E6E8._id_8D03DA3910129D74 = level._id_1B7407DFFE81E6E8._id_8D03DA3910129D74 + 1;

  return level._id_1B7407DFFE81E6E8._id_8D03DA3910129D74;
}

_id_4A6ADEB5F340FCC8() {
  level endon("game_ended");

  while(!isDefined(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38))
    waitframe();

  _id_B30B3C96C21FB5D8 = 160000;
  _id_AE35AE0FA34731B8(_id_B30B3C96C21FB5D8);

  while(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38.size > 0) {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.origin) && isDefined(player.team) && isalive(player) && (!_id_5EA5A722C499078F(player.team) || istrue(player._id_45B8E84DE48BB89F))) {
        _id_30A99625B9F5D98C = scripts\engine\utility::_id_4D046F33253E46E0(player.origin, level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38);

        if(isDefined(_id_30A99625B9F5D98C) && distancesquared(_id_30A99625B9F5D98C.origin, player.origin) < _id_B30B3C96C21FB5D8) {
          player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_dmz_activity_starter_activity_type", _id_30A99625B9F5D98C._id_DABE413C9C6C48F4);
          player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_dmz_activity_starter_poi_name", _id_30A99625B9F5D98C._id_E995BB533046188D);
          _id_01193C0B83FCE13B::_id_604A7FC1FB4B6DFD(_id_30A99625B9F5D98C, player);
        }
      }
    }

    wait 1;
  }
}

_id_AE35AE0FA34731B8(mindistancesq) {
  foreach(_id_5EA1BE154AEB609B in level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) {
    foreach(_id_81A6258C743174DB in level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) {
      if(_id_5EA1BE154AEB609B == _id_81A6258C743174DB) {
        continue;
      }
      if(distancesquared(_id_5EA1BE154AEB609B.origin, _id_81A6258C743174DB.origin) <= mindistancesq) {}
    }
  }
}

_id_84ED600D2BD001AD() {
  level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38 = [];
  _id_D48061D99A12DD19 = [];

  foreach(_id_EFA8EF05B190D7D0 in level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24) {
    if(!isDefined(_id_D48061D99A12DD19[_id_EFA8EF05B190D7D0.type]))
      _id_D48061D99A12DD19[_id_EFA8EF05B190D7D0.type] = [];

    _id_D48061D99A12DD19[_id_EFA8EF05B190D7D0.type][_id_D48061D99A12DD19[_id_EFA8EF05B190D7D0.type].size] = _id_EFA8EF05B190D7D0;
  }

  _id_B1E6CFEA54837661 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_activity_starter");
  _id_B1E6CFEA54837661 = _id_0879FAF1BEA33F06(_id_B1E6CFEA54837661);
  _id_202F4B66718AB8BD = [];

  foreach(_id_5EA1BE154AEB609B in _id_B1E6CFEA54837661) {
    type = getsubstr(_id_5EA1BE154AEB609B.type, 24);

    if(!isDefined(_id_202F4B66718AB8BD[type]))
      _id_202F4B66718AB8BD[type] = [];

    _id_202F4B66718AB8BD[type][_id_202F4B66718AB8BD[type].size] = _id_5EA1BE154AEB609B;
  }

  foreach(type, _id_8D65040262935F78 in _id_D48061D99A12DD19) {
    if(!isDefined(_id_202F4B66718AB8BD[type])) {
      continue;
    }
    foreach(_id_EFA8EF05B190D7D0 in _id_8D65040262935F78) {
      _id_112E955BA5DB3F2B = squared(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A[_id_EFA8EF05B190D7D0.name]._id_2CE8F82AD71EB571);
      _id_B03AD0BA8C8849EA = squared(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A[_id_EFA8EF05B190D7D0.name]._id_7A62616965ED6A2E);
      _id_5EA1BE154AEB609B = _id_368CFEDCF00AB6F2(_id_202F4B66718AB8BD[type], _id_EFA8EF05B190D7D0.origin, _id_112E955BA5DB3F2B, _id_B03AD0BA8C8849EA);

      if(isDefined(_id_5EA1BE154AEB609B)) {
        _id_202F4B66718AB8BD[type] = scripts\engine\utility::array_remove(_id_202F4B66718AB8BD[type], _id_5EA1BE154AEB609B);
        _id_5EA1BE154AEB609B._id_0D855AA87B99592A = int(clamp(distance(_id_EFA8EF05B190D7D0.origin, _id_5EA1BE154AEB609B.origin) / 200, 1, 100));
        _id_5EA1BE154AEB609B._id_DABE413C9C6C48F4 = _id_F92C1A3D19210CCD(_id_EFA8EF05B190D7D0.name);
        _id_5EA1BE154AEB609B._id_E995BB533046188D = _id_5DEF7AF2A9F04234::_id_80CDAEA4BD3ECF70(_id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_EFA8EF05B190D7D0.origin, undefined, undefined, 1));
        _id_5EA1BE154AEB609B._id_4AB01941798B314C = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_5EA1BE154AEB609B.origin, 0, 0, 0);
        _id_5EA1BE154AEB609B._id_EFA8EF05B190D7D0 = _id_EFA8EF05B190D7D0;
        _id_EFA8EF05B190D7D0._id_5EA1BE154AEB609B = _id_5EA1BE154AEB609B;
        _id_5EA1BE154AEB609B _id_5220F38B5239EAC8();
        level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38[level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38.size] = _id_5EA1BE154AEB609B;
      }
    }
  }

  level notify("activitymanager_initActivityStarters_done");
}

_id_5220F38B5239EAC8() {
  if(istrue(level._id_1B7407DFFE81E6E8._id_D6D000F64C923FD6))
    self setscriptablepartstate("brloot_activity_starter", "visible");
  else
    self setscriptablepartstate("brloot_activity_starter", "visible_no_icon");
}

_id_66DA9365BBFEA8B7() {
  level notify("tablethide_kill_callout_" + self.origin);
  self setscriptablepartstate("brloot_activity_starter", "hidden");
}

_id_0879FAF1BEA33F06(locations) {
  _id_57D3850A12CF1D8F::_id_1A037D5CD64DC892();
  validlocations = [];
  _id_229DD59111A2FA54 = getdvarint("dvar_B54C660E3E9515B2", 1000);
  _id_AA5A3885F8D284DC = _id_229DD59111A2FA54 * _id_229DD59111A2FA54;

  foreach(location in locations) {
    if((!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087() || !_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(location.origin)) && _id_5DEF7AF2A9F04234::_id_9C93E67F90980177(location.origin) && (!isDefined(level._id_F64C6EF6F688A407) || level._id_F64C6EF6F688A407.size == 0 || distance(sortbydistance(level._id_F64C6EF6F688A407, location.origin)[0].origin, location.origin) > 350) && (validlocations.size == 0 || distancesquared(sortbydistance(validlocations, location.origin)[0].origin, location.origin) > _id_AA5A3885F8D284DC) && !_id_4948CDF739393D2D::_id_F0201365C368CF88(location.origin))
      validlocations[validlocations.size] = location;
  }

  return validlocations;
}

_id_368CFEDCF00AB6F2(_id_9E4E1482CB40C9C5, origin, mindistancesq, _id_205A760F75F8E9D6) {
  _id_2B0591F184AE430E = undefined;
  _id_06E51C4622AA0C30 = 999999999;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    dist = distancesquared(struct.origin, origin);
    _id_4573A8725DD3748E = abs(dist - _id_205A760F75F8E9D6);

    if(_id_4573A8725DD3748E < _id_06E51C4622AA0C30 && dist > mindistancesq) {
      if(_id_06E51C4622AA0C30 < 150)
        return struct;

      _id_2B0591F184AE430E = struct;
      _id_06E51C4622AA0C30 = _id_4573A8725DD3748E;
    }
  }

  return _id_2B0591F184AE430E;
}

_id_EBE9B1E455D46450(player) {
  if(!isDefined(level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24) || level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24.size == 0)
    return undefined;

  if(!isDefined(level._id_1B7407DFFE81E6E8._id_786FDA809023E24A))
    _id_4B4F24E571CB5AF9();

  _id_CEE0C6760060DFF8 = scripts\mp\utility\teams::getteamdata(player.team, "exfils");
  playerorigin = player.origin;
  _id_2A73D37D4F624825 = undefined;
  _id_00A96C0AD7583E3D = undefined;
  _id_B6B0B797C6EF02E2 = 0;

  if(_id_CEE0C6760060DFF8.size > 0) {
    _id_2A73D37D4F624825 = scripts\engine\utility::getclosest(playerorigin, _id_CEE0C6760060DFF8).origin;
    _id_00A96C0AD7583E3D = _id_2A73D37D4F624825 - playerorigin;
    _id_B6B0B797C6EF02E2 = distance(_id_2A73D37D4F624825, playerorigin) > 2000;
  }

  _id_C56664807B194ADB = sortbydistance(level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24, playerorigin);
  _id_7F767D0B39D7E455 = [];
  _id_32F9BD0CA63C013E = 0;

  for(index = 0; index < _id_C56664807B194ADB.size && _id_32F9BD0CA63C013E < 10; index++) {
    _id_EFA8EF05B190D7D0 = _id_C56664807B194ADB[index];

    if(scripts\engine\utility::array_contains_key(_id_EFA8EF05B190D7D0.teams, player.team)) {
      continue;
    }
    _id_43697DE9671BB892 = _id_EFA8EF05B190D7D0.origin;
    score = 0;
    score = score + _id_5F083FB42518423C(playerorigin, _id_43697DE9671BB892);

    if(isDefined(_id_2A73D37D4F624825))
      score = score + _id_2B921D0E6BC242E1(playerorigin, _id_2A73D37D4F624825);

    if(_id_B6B0B797C6EF02E2)
      score = score + _id_52BB8AEC483E159A(playerorigin, _id_43697DE9671BB892, _id_00A96C0AD7583E3D);

    _id_32F9BD0CA63C013E++;
    _id_7F767D0B39D7E455[index] = score;
  }

  if(_id_32F9BD0CA63C013E <= 0)
    return undefined;

  _id_7F767D0B39D7E455 = _id_6C2C22972F70BE38(_id_7F767D0B39D7E455);
  _id_E98ACF9FA9D0767D = _id_076E8E9F07068AD3(_id_7F767D0B39D7E455);
  return _id_C56664807B194ADB[_id_E98ACF9FA9D0767D];
}

_id_4B4F24E571CB5AF9() {
  _id_786FDA809023E24A = spawnStruct();
  _id_786FDA809023E24A._id_6F1D78292F73EE46 = getdvarfloat("dvar_C508E27B819D49B2", 0.15);
  _id_786FDA809023E24A._id_05845BA08C276F11 = getdvarfloat("dvar_58211513A78506AF", 0.3);
  _id_786FDA809023E24A._id_F9CFF5C6714553F7 = getdvarfloat("dvar_C321CDA536BC126E", 0.3);
  _id_786FDA809023E24A._id_D6ACB1CBF4657382 = getdvarfloat("dvar_7CDAC9442BC68FB2", 0.25);
  _id_786FDA809023E24A._id_07C0A2BB952BF39C = getdvarfloat("dvar_F88016CB082A72EC", 0.5);
  level._id_1B7407DFFE81E6E8._id_786FDA809023E24A = _id_786FDA809023E24A;
}

_id_5F083FB42518423C(playerorigin, _id_43697DE9671BB892) {
  dist = distance(_id_43697DE9671BB892, playerorigin);
  _id_74F7841A848C74DF = (15000 - dist) / 15000;
  _id_74F7841A848C74DF = _id_74F7841A848C74DF * level._id_1B7407DFFE81E6E8._id_786FDA809023E24A._id_6F1D78292F73EE46;
  _id_BB7A6B74942C715E = (40000 - dist) / 40000;
  _id_BB7A6B74942C715E = _id_BB7A6B74942C715E * level._id_1B7407DFFE81E6E8._id_786FDA809023E24A._id_05845BA08C276F11;
  return max(0, _id_74F7841A848C74DF) + max(0, _id_BB7A6B74942C715E);
}

_id_2B921D0E6BC242E1(playerorigin, _id_2A73D37D4F624825) {
  dist = distance(_id_2A73D37D4F624825, playerorigin);
  _id_7A73315D7CA78155 = (15000 - dist) / 15000;
  return max(0, _id_7A73315D7CA78155 * level._id_1B7407DFFE81E6E8._id_786FDA809023E24A._id_F9CFF5C6714553F7);
}

_id_52BB8AEC483E159A(playerorigin, _id_43697DE9671BB892, _id_00A96C0AD7583E3D) {
  _id_076C8BE7626613CA = _id_43697DE9671BB892 - playerorigin;
  angle = scripts\engine\math::anglebetweenvectors(_id_076C8BE7626613CA, _id_00A96C0AD7583E3D);
  return max(0, (1 - angle / 180) * level._id_1B7407DFFE81E6E8._id_786FDA809023E24A._id_D6ACB1CBF4657382);
}

_id_6C2C22972F70BE38(_id_5201AD92C6E26086) {
  if(_id_5201AD92C6E26086.size <= 1)
    return _id_5201AD92C6E26086;

  _id_7BE91F1A817C1E47 = 100;
  _id_D414BA671EB56685 = -100;

  foreach(score in _id_5201AD92C6E26086) {
    if(score < _id_7BE91F1A817C1E47)
      _id_7BE91F1A817C1E47 = score;

    if(score > _id_D414BA671EB56685)
      _id_D414BA671EB56685 = score;
  }

  range = _id_D414BA671EB56685 - _id_7BE91F1A817C1E47;

  if(range <= 0) {
    foreach(key, score in _id_5201AD92C6E26086)
    _id_5201AD92C6E26086[key] = 1;
  } else {
    foreach(key, score in _id_5201AD92C6E26086) {
      _id_C715CB5BEDB6BC8E = max(0, (score - _id_7BE91F1A817C1E47) / range);

      if(_id_C715CB5BEDB6BC8E < level._id_1B7407DFFE81E6E8._id_786FDA809023E24A._id_07C0A2BB952BF39C)
        _id_C715CB5BEDB6BC8E = 0;

      _id_5201AD92C6E26086[key] = _id_C715CB5BEDB6BC8E;
    }
  }

  return _id_5201AD92C6E26086;
}

_id_076E8E9F07068AD3(_id_5201AD92C6E26086) {
  totalscore = 0;

  foreach(score in _id_5201AD92C6E26086)
  totalscore = totalscore + score;

  _id_73C0BD15F57DB725 = randomfloat(totalscore);

  foreach(key, score in _id_5201AD92C6E26086) {
    _id_73C0BD15F57DB725 = _id_73C0BD15F57DB725 - score;

    if(_id_73C0BD15F57DB725 <= 0)
      return key;
  }

  return key;
}

_id_57AC6111C7DB410F(struct, player) {
  instance = struct.instance;
  _id_EFA8EF05B190D7D0 = instance._id_EFA8EF05B190D7D0;
  level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38, instance);
  instance setscriptablepartstate("brloot_activity_starter", "hidden");
  player playlocalsound("mp_dmz_phone_pickup");
  player _id_6C4E8CEA70BF4B6D::_id_9BE29AD72A155EE1();

  if(isDefined(_id_EFA8EF05B190D7D0))
    _id_EFA8EF05B190D7D0 _id_3FAA04EF514A5FC4(player.team, undefined, player);
}

_id_3AB4A84501CAACDE(_id_69E96A4CAA72D794, player) {
  _id_69E96A4CAA72D794 notify("stopRinging");
  _id_69E96A4CAA72D794 _id_6C4E8CEA70BF4B6D::_id_D062142F367ED7B2();
  player _id_6C4E8CEA70BF4B6D::_id_9BE29AD72A155EE1("intel_put_usb_in_tablet");
  _id_EFA8EF05B190D7D0 = _id_EBE9B1E455D46450(player);

  if(isDefined(_id_EFA8EF05B190D7D0))
    _id_EFA8EF05B190D7D0 _id_3FAA04EF514A5FC4(player.team, undefined, player);
}

_id_D8625665D55F3941(team, show) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  _id_64623E2FF7409F39(player, show);
}

_id_64623E2FF7409F39(player, show) {
  if(isDefined(level._id_1B7407DFFE81E6E8) && isDefined(level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) && isDefined(player)) {
    foreach(_id_B65B043741750C60 in level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) {
      if(istrue(show)) {
        _id_B65B043741750C60 enablescriptableplayeruse(player);
        continue;
      }

      _id_B65B043741750C60 disablescriptableplayeruse(player);
    }
  }
}

_id_5EA5A722C499078F(team) {
  return isDefined(team) && isDefined(level._id_1B7407DFFE81E6E8) && isDefined(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1) && isDefined(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]) && isDefined(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24) && level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24.size > 0;
}

_id_37416C14E9703FB6(player) {
  if(!_id_5EA5A722C499078F(player.team)) {
    return;
  }
  _id_EFA8EF05B190D7D0 = _id_B1D0568D9066A2CE(player.team);

  if(isDefined(_id_EFA8EF05B190D7D0))
    return _id_EFA8EF05B190D7D0 _id_43C0A14BAE1AA483(player);
}

_id_A2DCDCD112310E33(team, _id_276AC5E84835EA87) {
  if(_id_5EA5A722C499078F(team)) {
    foreach(id in level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team]._id_83ABCB9B3A5DBE24) {
      _id_EFA8EF05B190D7D0 = level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[id];

      if(isDefined(_id_EFA8EF05B190D7D0) && isDefined(_id_EFA8EF05B190D7D0._id_276AC5E84835EA87) && _id_EFA8EF05B190D7D0._id_276AC5E84835EA87 == _id_276AC5E84835EA87)
        return 1;
    }
  }

  return 0;
}

_id_040143C869E13213(_id_FABF84450735DD93, dialog) {
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  _id_B2810E8D06E0A042 queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2);
}

_id_73FD6FE2488E3EBF(_id_EFA8EF05B190D7D0, team) {
  if(isDefined(_id_EFA8EF05B190D7D0) && isDefined(_id_EFA8EF05B190D7D0._id_B7718B6E41108129) && isDefined(_id_EFA8EF05B190D7D0.teams) && scripts\engine\utility::array_contains_key(_id_EFA8EF05B190D7D0.teams, team))
    return _id_EFA8EF05B190D7D0._id_B7718B6E41108129[_id_EFA8EF05B190D7D0.teams[team]];

  return undefined;
}

_id_675059586A84FA06(team, func) {
  _id_B8EBE3F71A08AB40 = _id_73FD6FE2488E3EBF(self, team);

  if(isDefined(_id_B8EBE3F71A08AB40) && isDefined(_id_B8EBE3F71A08AB40.funcs[func]))
    _id_B8EBE3F71A08AB40 thread[[_id_B8EBE3F71A08AB40.funcs[func]]](team);
}

_id_43C0A14BAE1AA483(player) {
  if(isDefined(self.teams[player.team]))
    return self._id_B7718B6E41108129[self.teams[player.team]];

  return undefined;
}

_id_B1D0568D9066A2CE(team) {
  info = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[team];
  _id_D9C7846C5A70D0BD = info._id_6299084AE61B350A[info._id_ACB56EDCF61F231C];
  _id_95C69228E0685E73 = level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_D9C7846C5A70D0BD];

  if(isDefined(_id_95C69228E0685E73))
    return _id_95C69228E0685E73;
}

_id_0C251E35450891F3() {
  foreach(team in self.teams) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    if(players.size > 0)
      return 1;
  }

  return 0;
}

_id_AD20469C1815A7C7(team, _id_693B800E6CD7B21C) {
  _id_B8EBE3F71A08AB40 = self;
  _id_AE2F1138C7599B30 = [];
  players = [];

  foreach(player in _id_B8EBE3F71A08AB40.players) {
    if(!isDefined(player) || !isDefined(player.team)) {
      continue;
    }
    _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

    if(_id_AA128E29D7C10074 && !_id_693B800E6CD7B21C) {
      continue;
    }
    _id_5C5D5D857CE5FD60 = scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, team);
    _id_87D653F5E64BE2D7 = player.team == team;
    _id_33A0C14B002FD190 = scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, player.team);

    if(isDefined(team) && !_id_5C5D5D857CE5FD60) {
      continue;
    }
    if(isDefined(team) && !_id_87D653F5E64BE2D7) {
      continue;
    }
    if(!isDefined(team) && !_id_33A0C14B002FD190) {
      continue;
    }
    players[players.size] = player;
  }

  return players;
}

_id_133EBA493F1F3636(team) {
  if(!isDefined(self._id_972EDDBDCF30619C))
    self._id_972EDDBDCF30619C = [];

  numplayers = 0;
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::_id_3D0F2343793D709B(team, undefined, 1);

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(scripts\engine\utility::array_contains(self._id_972EDDBDCF30619C, player))
      numplayers++;
  }

  return numplayers;
}

_id_37DB4C1F01E80F2F(team) {
  if(!isDefined(self._id_972EDDBDCF30619C))
    self._id_972EDDBDCF30619C = [];

  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::_id_3D0F2343793D709B(team, undefined, 1);

  if(_id_133EBA493F1F3636(team) == _id_E2B2BBD9E6539F11.size) {
    if(!istrue(self._id_B7718B6E41108129[0]._id_BB74E27BBADCC48B))
      level thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("mission_cancel_complete", team, 1);

    self._id_B7718B6E41108129[0] _id_8D4A1199159F7D52(team);

    foreach(player in _id_E2B2BBD9E6539F11)
    player setclientomnvar("ui_br_contract_cancellation_state", 0);

    if(!istrue(self._id_B7718B6E41108129[0]._id_2FA3A0C38DFCE74B))
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_contract_cancelled_" + self.type, _id_E2B2BBD9E6539F11);

    return 1;
  }

  return 0;
}

_id_15AB6BABBE46E018() {
  if(isDefined(self) && isDefined(self.team) && _id_5EA5A722C499078F(self.team)) {
    _id_EFA8EF05B190D7D0 = _id_B1D0568D9066A2CE(self.team);

    if(!isDefined(_id_EFA8EF05B190D7D0)) {
      return;
    }
    if(!isDefined(_id_EFA8EF05B190D7D0._id_972EDDBDCF30619C))
      _id_EFA8EF05B190D7D0._id_972EDDBDCF30619C = [];

    if(scripts\engine\utility::array_contains(_id_EFA8EF05B190D7D0._id_972EDDBDCF30619C, self)) {
      _id_EFA8EF05B190D7D0 _id_37DB4C1F01E80F2F(self.team);
      return;
    }

    _id_EFA8EF05B190D7D0._id_972EDDBDCF30619C[_id_EFA8EF05B190D7D0._id_972EDDBDCF30619C.size] = self;

    if(!_id_EFA8EF05B190D7D0 _id_37DB4C1F01E80F2F(self.team)) {
      _id_607DA387F3617ED1 = scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, undefined, 1);
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("mission_cancel_request", scripts\engine\utility::array_remove_array(_id_607DA387F3617ED1, _id_EFA8EF05B190D7D0._id_972EDDBDCF30619C));
      _id_7AA06BE6F06BEF26 = _id_EFA8EF05B190D7D0 _id_133EBA493F1F3636(self.team);
      totalplayers = _id_607DA387F3617ED1.size;
      _id_587EC5B2038407DE = _id_7AA06BE6F06BEF26 | totalplayers << 3;

      foreach(player in _id_607DA387F3617ED1)
      player setclientomnvar("ui_br_contract_cancellation_state", _id_587EC5B2038407DE);

      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_contract_pending_" + _id_EFA8EF05B190D7D0.type, _id_607DA387F3617ED1, undefined, _id_587EC5B2038407DE);
      return;
    }
  } else {}
}

_id_279C4202B5ED4980(_id_EA3E3B2121E6713A, value) {
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "br_cancel_contract":
        _id_15AB6BABBE46E018();
        break;
    }
  }
}