/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armory_kiosk.gsc
****************************************************/

init() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint("scr_br_armory_kiosk", 1) != 0;
  level._id_011A3973390A71E8 = getDvar("dvar_F8E5C3DAA6C01012", "purchases");

  if(level.mapname == "mp_saba" || level.mapname == "mp_saba2" || level.mapname == "mp_saba_pm")
    level._id_8DEA6607B3189A60 = getdvarint("dvar_32C09327627C883C", 1);

  level._id_77E4ADD813FCA6AE = getdvarint("dvar_E024CF932EF753DC", 0);
  level._id_F38C74334D6FF472 = getdvarint("dvar_6E135C0A5EDC02B1", 0);
  level._id_EE08B1F41E7C2444 = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
  level._id_E7CEE4FBB5B46EF2 = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(level._id_011A3973390A71E8);

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("kiosk")) {
    level.br_armory_kiosk_enabled = 0;
    return;
  }

  if(level.br_armory_kiosk_enabled) {
    _id_665291FDC0B65758();
    scripts\engine\scriptable::scriptable_addusedcallback(::armorykioskused);
    scripts\engine\scriptable::scriptable_addautousecallback(::armorykioskused);
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onarmorykioskpurchase);
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("buy_station", ::_id_E6C1C35181A2870F);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("buy_station", ::_id_7CB54F604C35BE8C);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("buy_station", ::_id_086F5339F1334E16);
    level._id_D03E6BA38B56B4AB = getdvarint("dvar_E77AB3A32453AE92", 1);
    level._id_E9F7702D839B262C = getdvarint("dvar_0624B1F6964C696D", 180.0);
    level._id_F454C63919420AA9 = getdvarint("dvar_69C62CAE4D7929C9", 10.0);
    level._id_FB60F0244999D528 = getdvarint("dvar_9C3612143E0AD401", 1.0);
    level._id_8B92CB4447668562 = getdvarint("dvar_1B89015DECB21663", 1) == 1;
    _initsalesdiscount();
    _parsepurchaseitemtables();
    _id_6F3BD3113A48F7B7();
    _id_3E6DDD0AE062AC75();
    level thread _watchforcircleclosure();
    level._id_0A4078546548CB0A = ::_id_0A4078546548CB0A;
    level._id_4FECF02C9241F7F0 = ::_id_4FECF02C9241F7F0;
    _id_2695A20D4011076D::_id_ECA79FA0F341EE08(4, ::dangercircletick, ::_id_1A1709943670772A, ::_id_D9A3848F71C7C63A, ::disableallarmorykiosks);
  }
}

_id_B38F5FFE645943C3(_id_1BD79A12120F1848) {
  setDvar("dvar_F8E5C3DAA6C01012", _id_1BD79A12120F1848);
  level._id_E7CEE4FBB5B46EF2 = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_1BD79A12120F1848);

  if(!isDefined(level._id_6BE7B375EC4A629C))
    level._id_6BE7B375EC4A629C = [];

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == level._id_E7CEE4FBB5B46EF2)
      return;
  }

  level._id_6BE7B375EC4A629C[level._id_6BE7B375EC4A629C.size] = _id_0D84CDB7463425BA(_id_1BD79A12120F1848);
}

_initignoredtabspergamemode() {
  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    setDvar("dvar_6D36F3E8FBC43781", "2,5");
  else
    setDvar("dvar_6D36F3E8FBC43781", "3,4,5");
}

_initsalesdiscount() {
  _id_DB834D1CAC99EA96 = getdvarint("dvar_828FB46E27EF695D", 0);
  level.br_armory_kiosk.sales_discount = int(clamp(_id_DB834D1CAC99EA96, 0, 100));
  _id_BC97C6F634D832A0 = getDvar("dvar_068EB502C50F9A22", "");
  level.br_armory_kiosk.sales_discount_items = strtok(_id_BC97C6F634D832A0, ",");
  _id_997F4424A87B464E = 20;
  _id_F587FA837F6BF48F = level.br_armory_kiosk.sales_discount % _id_997F4424A87B464E;

  if(_id_F587FA837F6BF48F > 0) {
    _id_9A7512C4544FD449 = int(floor(level.br_armory_kiosk.sales_discount / _id_997F4424A87B464E) * _id_997F4424A87B464E);
    _id_0050C417A2A6400D = _id_F587FA837F6BF48F / _id_997F4424A87B464E >= 0.5;

    if(_id_0050C417A2A6400D)
      _id_9A7512C4544FD449 = _id_9A7512C4544FD449 + _id_997F4424A87B464E;

    level.br_armory_kiosk.sales_discount = int(_id_9A7512C4544FD449);
  }

  if(_id_DB834D1CAC99EA96 != level.br_armory_kiosk.sales_discount)
    setDvar("dvar_828FB46E27EF695D", level.br_armory_kiosk.sales_discount);
}

_applysalesdiscount(_id_9D384A51D5F0A3CF, _id_5805A52EC044F672) {
  if(!isDefined(_id_5805A52EC044F672) || _id_5805A52EC044F672 == 0)
    return _id_9D384A51D5F0A3CF;
  else if(_id_5805A52EC044F672 == 100)
    return 0;

  fraction = (100 - _id_5805A52EC044F672) * 0.01;
  return int(floor(_id_9D384A51D5F0A3CF * fraction + 0.5));
}

_id_A0389E3244A68894(_id_15B89FF206500554, _id_CF9D634EF87D898B) {
  _id_DC5CA81F164DF863 = _id_879D297885591207(_id_15B89FF206500554);

  if(!isDefined(_id_DC5CA81F164DF863))
    _id_DC5CA81F164DF863 = level._id_E7CEE4FBB5B46EF2;

  _id_8E9C7FC5D7CDC62B = _id_2A50F66EB0EC8756(_id_15B89FF206500554);

  if(!isDefined(_id_DC5CA81F164DF863))
    _id_8E9C7FC5D7CDC62B = level._id_E7CEE4FBB5B46EF2;

  _id_6E08BA5C758809B1 = scripts\engine\utility::array_combine(level._id_6BE7B375EC4A629C, level._id_4531798404D47E45);

  foreach(_id_EB7139726CC569B5 in _id_6E08BA5C758809B1) {
    if(_id_EB7139726CC569B5["index"] == _id_DC5CA81F164DF863) {
      _id_B0F4DCC20C3B0C76 = _id_EB7139726CC569B5["items"];

      if(isDefined(_id_B0F4DCC20C3B0C76[_id_CF9D634EF87D898B]))
        return 1;

      break;
    }
  }

  foreach(_id_BAE77D8848F4D84D in level._id_3899105CEEC08FB8) {
    if(_id_BAE77D8848F4D84D["index"] == _id_8E9C7FC5D7CDC62B) {
      _id_B7D5F294EB87D5CE = _id_BAE77D8848F4D84D["items"];

      if(isDefined(_id_B7D5F294EB87D5CE[_id_CF9D634EF87D898B]))
        return 1;

      break;
    }
  }

  return 0;
}

_id_A83AC2899E1FE5EB(_id_15B89FF206500554) {
  if(getdvarint("dvar_8BD31284E87B0865", 1) == 0)
    return 0;

  if(!isDefined(_id_15B89FF206500554) || !isDefined(_id_15B89FF206500554.index))
    return 0;

  _id_D584AF5CDD0345D8 = getsystemtime();

  if(!isDefined(_id_15B89FF206500554._id_7940DCDE72827AF7) && isDefined(level._id_6BE7B375EC4A629C) && level._id_6BE7B375EC4A629C.size > 0) {
    _id_DC5CA81F164DF863 = (_id_15B89FF206500554.index + _id_D584AF5CDD0345D8) % level._id_6BE7B375EC4A629C.size;
    _id_B25A062B16392EDD = level._id_6BE7B375EC4A629C[_id_DC5CA81F164DF863];
    _id_15B89FF206500554._id_7940DCDE72827AF7 = _id_B25A062B16392EDD["index"];
  }

  if(!isDefined(_id_15B89FF206500554._id_DED92CCB217BBAEB) && isDefined(level._id_3899105CEEC08FB8) && level._id_3899105CEEC08FB8.size > 0) {
    _id_2D4419C241FCB284 = (_id_15B89FF206500554.index + _id_D584AF5CDD0345D8) % level._id_3899105CEEC08FB8.size;
    _id_ABA76BFE006A0128 = level._id_3899105CEEC08FB8[_id_2D4419C241FCB284];
    _id_15B89FF206500554._id_DED92CCB217BBAEB = _id_ABA76BFE006A0128["index"];
  }

  return 1;
}

_id_879D297885591207(_id_15B89FF206500554) {
  if(!_id_A83AC2899E1FE5EB(_id_15B89FF206500554))
    return undefined;

  found = 0;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == _id_15B89FF206500554._id_7940DCDE72827AF7) {
      found = 1;
      break;
    }
  }

  if(!found)
    _id_AD499107951C0A81(_id_15B89FF206500554._id_7940DCDE72827AF7);

  return _id_15B89FF206500554._id_7940DCDE72827AF7;
}

_id_2A50F66EB0EC8756(_id_15B89FF206500554) {
  if(!_id_A83AC2899E1FE5EB(_id_15B89FF206500554))
    return undefined;

  return _id_15B89FF206500554._id_DED92CCB217BBAEB;
}

_id_AC84B48BB39D674F(_id_15B89FF206500554) {
  if(getdvarint("dvar_B0634929CD39973B", 1) == 0)
    return 0;

  if(!isDefined(_id_15B89FF206500554) || !isDefined(_id_15B89FF206500554.index))
    return 0;

  if(!isDefined(level._id_6BE7B375EC4A629C))
    return 0;

  _id_3C79041B6898CCBE = _id_879D297885591207(_id_15B89FF206500554);

  if(!isDefined(_id_3C79041B6898CCBE))
    return 0;

  if(!isDefined(level._id_44235D71492FA1A5))
    level._id_44235D71492FA1A5 = [];

  if(isDefined(level._id_44235D71492FA1A5[_id_15B89FF206500554.index]) && level._id_44235D71492FA1A5[_id_15B89FF206500554.index]._id_7C4E674C20384644 == _id_3C79041B6898CCBE)
    return 1;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == _id_3C79041B6898CCBE) {
      _id_44235D71492FA1A5 = spawnStruct();
      _id_44235D71492FA1A5._id_7C4E674C20384644 = _id_3C79041B6898CCBE;
      _id_44235D71492FA1A5.stock = [];

      foreach(_id_541FD62B8D9C236D, _id_00CF29BD90372E77 in _id_EB7139726CC569B5["items"])
      _id_44235D71492FA1A5.stock[_id_541FD62B8D9C236D] = _id_00CF29BD90372E77["defaultStock"];

      level._id_44235D71492FA1A5[_id_15B89FF206500554.index] = _id_44235D71492FA1A5;
      return 1;
    }
  }

  foreach(_id_EB7139726CC569B5 in level._id_4531798404D47E45) {
    if(_id_EB7139726CC569B5["index"] == _id_3C79041B6898CCBE) {
      _id_44235D71492FA1A5 = spawnStruct();
      _id_44235D71492FA1A5._id_7C4E674C20384644 = _id_3C79041B6898CCBE;
      _id_44235D71492FA1A5.stock = [];

      foreach(_id_541FD62B8D9C236D, _id_00CF29BD90372E77 in _id_EB7139726CC569B5["items"])
      _id_44235D71492FA1A5.stock[_id_541FD62B8D9C236D] = _id_00CF29BD90372E77["defaultStock"];

      level._id_44235D71492FA1A5[_id_15B89FF206500554.index] = _id_44235D71492FA1A5;
      return 1;
    }
  }

  return 0;
}

_id_6AF40E269AAE683E(_id_15B89FF206500554, _id_CF9D634EF87D898B) {
  player = self;

  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  if(_id_7E52B56769FA7774::isweaponpickup(_id_CF9D634EF87D898B))
    return undefined;

  _id_B0F4DCC20C3B0C76 = undefined;
  _id_602C39C79C517A48 = level._id_44235D71492FA1A5[_id_15B89FF206500554.index]._id_7C4E674C20384644;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == _id_602C39C79C517A48) {
      _id_B0F4DCC20C3B0C76 = _id_EB7139726CC569B5["items"];
      break;
    }
  }

  if(isDefined(level._id_4531798404D47E45)) {
    foreach(_id_EB7139726CC569B5 in level._id_4531798404D47E45) {
      if(_id_EB7139726CC569B5["index"] == _id_602C39C79C517A48) {
        _id_B0F4DCC20C3B0C76 = _id_EB7139726CC569B5["items"];
        break;
      }
    }
  }

  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player);
  _id_F80AD141CA44A56C = level._id_44235D71492FA1A5[_id_15B89FF206500554.index].stock[_id_CF9D634EF87D898B];

  if(isDefined(_id_F80AD141CA44A56C)) {
    if(istrue(_id_15B89FF206500554._id_114E759371623080)) {
      _id_417245CB30A84E5D = _id_799D521F485A1701::_id_DE1AC98379235D8B(_id_CF9D634EF87D898B, _id_F80AD141CA44A56C);
      _id_F80AD141CA44A56C = scripts\engine\utility::ter_op(isDefined(_id_417245CB30A84E5D), _id_417245CB30A84E5D, _id_F80AD141CA44A56C);
    }

    ishidden = !_id_D47B7F992CA8A91E && _id_B0F4DCC20C3B0C76[_id_CF9D634EF87D898B]["hidden"];

    if(ishidden) {
      return 0;
      return;
    }

    return _id_F80AD141CA44A56C;
    return;
  } else {
    _id_3A9BA92D55351A23 = _id_B0F4DCC20C3B0C76[_id_CF9D634EF87D898B];

    if(isDefined(_id_3A9BA92D55351A23))
      return 1;
    else
      return 0;
  }
}

_id_066CD523E6167613(_id_15B89FF206500554) {
  player = self;

  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  _id_B0F4DCC20C3B0C76 = undefined;
  _id_602C39C79C517A48 = level._id_44235D71492FA1A5[_id_15B89FF206500554.index]._id_7C4E674C20384644;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == _id_602C39C79C517A48) {
      _id_B0F4DCC20C3B0C76 = _id_EB7139726CC569B5["items"];
      break;
    }
  }

  if(isDefined(level._id_4531798404D47E45)) {
    foreach(_id_EB7139726CC569B5 in level._id_4531798404D47E45) {
      if(_id_EB7139726CC569B5["index"] == _id_602C39C79C517A48) {
        _id_B0F4DCC20C3B0C76 = _id_EB7139726CC569B5["items"];
        break;
      }
    }
  }

  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player);
  _id_C46F52AFD4F7232D = [];
  _id_AEDD70527004E768 = 0;

  foreach(_id_7A23A3DA52267DE1, _id_F80AD141CA44A56C in level._id_44235D71492FA1A5[_id_15B89FF206500554.index].stock) {
    if(isDefined(_id_F80AD141CA44A56C)) {
      if(istrue(_id_15B89FF206500554._id_114E759371623080)) {
        _id_417245CB30A84E5D = _id_799D521F485A1701::_id_DE1AC98379235D8B(_id_7A23A3DA52267DE1, _id_F80AD141CA44A56C);
        _id_F80AD141CA44A56C = scripts\engine\utility::ter_op(isDefined(_id_417245CB30A84E5D), _id_417245CB30A84E5D, _id_F80AD141CA44A56C);
      }

      ishidden = !_id_D47B7F992CA8A91E && _id_B0F4DCC20C3B0C76[_id_7A23A3DA52267DE1]["hidden"];

      if(ishidden)
        _id_C46F52AFD4F7232D[_id_AEDD70527004E768] = 0;
      else
        _id_C46F52AFD4F7232D[_id_AEDD70527004E768] = _id_F80AD141CA44A56C;
    }

    _id_AEDD70527004E768++;
  }

  return _id_C46F52AFD4F7232D;
}

_id_3C3BCA629D687994(_id_15B89FF206500554) {
  player = self;

  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  return level._id_44235D71492FA1A5[_id_15B89FF206500554.index].stock;
}

_id_B88D64CD67BBE60F(_id_15B89FF206500554) {
  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  _id_353DCD8B6675E407 = 0;
  _id_89FFAB3D9D3C9CDD = 0;
  _id_4A7F6EC38E1F5220 = _id_066CD523E6167613(_id_15B89FF206500554);

  foreach(_id_E5B48212891E8513 in _id_4A7F6EC38E1F5220) {
    if(isDefined(_id_E5B48212891E8513)) {
      _id_89FFAB3D9D3C9CDD = _id_89FFAB3D9D3C9CDD | _id_E5B48212891E8513 << 2 * _id_353DCD8B6675E407;
      _id_353DCD8B6675E407++;
    }
  }

  return _id_89FFAB3D9D3C9CDD;
}

_id_469CFCBC4A5185C1(_id_15B89FF206500554, _id_CF9D634EF87D898B) {
  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554)) {
    return;
  }
  _id_F80AD141CA44A56C = level._id_44235D71492FA1A5[_id_15B89FF206500554.index].stock[_id_CF9D634EF87D898B];

  if(isDefined(_id_F80AD141CA44A56C))
    level._id_44235D71492FA1A5[_id_15B89FF206500554.index].stock[_id_CF9D634EF87D898B] = scripts\engine\utility::ter_op(_id_F80AD141CA44A56C > 0, _id_F80AD141CA44A56C - 1, 0);
}

_id_EF08EB6F31F46BC3(lootid) {
  if(!isDefined(lootid))
    return 0;

  _id_25978461C6E4F61B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_25978461C6E4F61B))
    return 0;

  return issubstr(getDvar("dvar_275014452AE83A52", ""), _id_25978461C6E4F61B);
}

_id_3FB403D950DF330A(_id_CF9D634EF87D898B) {
  foreach(_id_A365E25AA9D7BCDA in level.br_armory_kiosk.items) {
    if(_id_CF9D634EF87D898B == _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0)
      return _id_A365E25AA9D7BCDA._id_7CB19F95DBC68942;
  }

  return 1;
}

_id_596CE27C393E3593(_id_15B89FF206500554) {
  _id_DC5CA81F164DF863 = _id_879D297885591207(_id_15B89FF206500554);

  if(!isDefined(_id_DC5CA81F164DF863))
    _id_DC5CA81F164DF863 = level._id_E7CEE4FBB5B46EF2;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == _id_DC5CA81F164DF863)
      return _id_EB7139726CC569B5["itemFilter"];
  }

  if(isDefined(level._id_4531798404D47E45)) {
    foreach(_id_EB7139726CC569B5 in level._id_4531798404D47E45) {
      if(_id_EB7139726CC569B5["index"] == _id_DC5CA81F164DF863)
        return _id_EB7139726CC569B5["itemFilter"];
    }
  }
}

_id_0D84CDB7463425BA(_id_9023CEA8F03E72D2) {
  _id_EB7139726CC569B5 = [];
  _id_3D329EBB0D03D6DB = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_9023CEA8F03E72D2);
  _id_EB7139726CC569B5["index"] = _id_3D329EBB0D03D6DB;
  _id_EB7139726CC569B5["ref"] = _id_9023CEA8F03E72D2;
  _id_EB7139726CC569B5["items"] = [];
  _id_EB7139726CC569B5["itemFilter"] = 0;
  _id_904EEFA8F06CEECB = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, _id_3D329EBB0D03D6DB);
  _id_C6C26123001B9460 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 3);
  _id_3793828403C6873E = 0;

  for(_id_AC75B489772F26CE = 4 * _id_3793828403C6873E; _id_C6C26123001B9460 != ""; _id_C6C26123001B9460 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 3 + _id_AC75B489772F26CE)) {
    _id_8172B04B25618375 = _id_3FB403D950DF330A(_id_C6C26123001B9460);

    if(!_id_8172B04B25618375) {
      _id_730DD4E55DEE0CBB = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 4 + _id_AC75B489772F26CE);
      _id_0685CB12F08DA73B = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 5 + _id_AC75B489772F26CE);
      _id_BE32E0F210B83382 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 6 + _id_AC75B489772F26CE);
      _id_EB7139726CC569B5["items"][_id_C6C26123001B9460] = [];

      if(_id_730DD4E55DEE0CBB != "")
        _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["cost"] = int(_id_730DD4E55DEE0CBB);
      else
        _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["cost"] = -1;

      if(_id_0685CB12F08DA73B != "") {
        _id_0685CB12F08DA73B = int(_id_0685CB12F08DA73B);

        if(0 <= _id_0685CB12F08DA73B && _id_0685CB12F08DA73B <= 3)
          _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["defaultStock"] = _id_0685CB12F08DA73B;
        else
          _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["defaultStock"] = randomintrange(0, 3);
      } else
        _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["defaultStock"] = undefined;

      if(_id_BE32E0F210B83382 != "")
        _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["hidden"] = int(_id_BE32E0F210B83382);
      else
        _id_EB7139726CC569B5["items"][_id_C6C26123001B9460]["hidden"] = 0;
    }

    if(_id_3793828403C6873E < 15) {
      if(_id_8172B04B25618375) {
        _id_434B72E73A9CD4B9 = 1 << _id_3793828403C6873E;
        _id_EB7139726CC569B5["itemFilter"] = _id_EB7139726CC569B5["itemFilter"] | _id_434B72E73A9CD4B9;
      }
    } else {}

    _id_3793828403C6873E++;
    _id_AC75B489772F26CE = 4 * _id_3793828403C6873E;
  }

  return _id_EB7139726CC569B5;
}

_id_FE176342ED52B44F(_id_CB325DDB4A764623) {
  return int(tablelookup("mp/buyStation/buyStationItems.csv", 1, _id_CB325DDB4A764623, 0));
}

_id_517B8730DDEC7F59(_id_CB325DDB4A764623) {
  return int(tablelookup("mp/buyStation/buyStationItems.csv", 1, _id_CB325DDB4A764623, 4));
}

_id_7E0281196D6407C8() {
  return getdvarint("dvar_1696DF050AD70202", 0);
}

_id_4D81AE9CB22F4180(dvar, _id_A0732421235E346C) {
  _id_C95404CD83F761B6 = [];
  _id_FFFDBFFF87AB6316 = getDvar(dvar);

  if(isDefined(_id_FFFDBFFF87AB6316) && _id_FFFDBFFF87AB6316 != "") {
    _id_3D321E8859561813 = [];
    _id_3D08C62A01A4BEDD = strtok(_id_FFFDBFFF87AB6316, ",");

    if(_id_3D08C62A01A4BEDD.size == 2 && (int(_id_3D08C62A01A4BEDD[0]) || int(_id_3D08C62A01A4BEDD[1]))) {
      _id_919B9496930895B6 = int(_id_3D08C62A01A4BEDD[0]);
      _id_36336CEFCAD243F5 = int(_id_3D08C62A01A4BEDD[1]);

      for(_id_C5DCC7E2F341BF0B = _id_919B9496930895B6; _id_C5DCC7E2F341BF0B <= _id_36336CEFCAD243F5; _id_C5DCC7E2F341BF0B++) {
        _id_904EEFA8F06CEECB = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, _id_C5DCC7E2F341BF0B);

        if(_id_904EEFA8F06CEECB != -1) {
          _id_9023CEA8F03E72D2 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 1);

          if(_id_9023CEA8F03E72D2 != "")
            _id_3D321E8859561813[_id_3D321E8859561813.size] = _id_9023CEA8F03E72D2;
        }
      }
    } else
      _id_3D321E8859561813 = _id_3D08C62A01A4BEDD;

    _id_3D321E8859561813 = scripts\engine\utility::array_randomize(_id_3D321E8859561813);

    for(_id_3D329EBB0D03D6DB = 0; _id_3D329EBB0D03D6DB < _id_3D321E8859561813.size; _id_3D329EBB0D03D6DB++)
      _id_C95404CD83F761B6[_id_C95404CD83F761B6.size] = _id_0D84CDB7463425BA(_id_3D321E8859561813[_id_3D329EBB0D03D6DB]);
  } else if(isDefined(_id_A0732421235E346C))
    _id_C95404CD83F761B6[_id_C95404CD83F761B6.size] = _id_0D84CDB7463425BA(_id_A0732421235E346C);

  return _id_C95404CD83F761B6;
}

_id_AD499107951C0A81(index) {
  if(!isDefined(level._id_4531798404D47E45))
    level._id_4531798404D47E45 = [];

  foreach(_id_EB7139726CC569B5 in level._id_4531798404D47E45) {
    if(_id_EB7139726CC569B5["index"] == index)
      return 1;
  }

  _id_904EEFA8F06CEECB = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, index);

  if(_id_904EEFA8F06CEECB != -1) {
    _id_9023CEA8F03E72D2 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 1);

    if(_id_9023CEA8F03E72D2 != "") {
      level._id_4531798404D47E45[level._id_4531798404D47E45.size] = _id_0D84CDB7463425BA(_id_9023CEA8F03E72D2);
      return 1;
    }
  }

  return 0;
}

_id_9BD43636F6F0D8C4() {
  level.br_armory_kiosk.weapons._id_E02581D50B48C3F9 = [];
  _id_F615E27FABB97E45 = tablelookupgetnumrows("mp/buyStation/staticPriceList.csv");

  for(_id_46D56DB0A72EB5D4 = 0; _id_46D56DB0A72EB5D4 < _id_F615E27FABB97E45; _id_46D56DB0A72EB5D4++) {
    _id_46BA7EB0A7107F2D = tablelookupbyrow("mp/buyStation/staticPriceList.csv", _id_46D56DB0A72EB5D4, 0);
    _id_87D8E30FBD1164A5 = tablelookupbyrow("mp/buyStation/staticPriceList.csv", _id_46D56DB0A72EB5D4, 1);
    level.br_armory_kiosk.weapons._id_E02581D50B48C3F9[_id_46BA7EB0A7107F2D] = _id_87D8E30FBD1164A5;
  }
}

_id_2D02167ADEB2E60D() {
  level.br_armory_kiosk.weapons._id_E2CB29F4B0411D93 = [];
  _id_63CEC4DB64E32297 = tablelookupgetnumrows("mp/buyStation/weaponPriceList.csv");

  for(_id_279C628B1346E27E = 0; _id_279C628B1346E27E < _id_63CEC4DB64E32297; _id_279C628B1346E27E++) {
    _id_2770738B1316A17B = tablelookupbyrow("mp/buyStation/weaponPriceList.csv", _id_279C628B1346E27E, 1);
    _id_FA1AB16B7B374DB3 = tablelookupbyrow("mp/buyStation/weaponPriceList.csv", _id_279C628B1346E27E, 2);
    level.br_armory_kiosk.weapons._id_E2CB29F4B0411D93[_id_2770738B1316A17B] = _id_FA1AB16B7B374DB3;
  }
}

_id_D872D1B4B7C3C32E() {
  level.br_armory_kiosk.weapons._id_F6619D771D944FD2 = [];
  _id_648068A3992692F7 = tablelookupgetnumrows("mp/buyStation/weaponPriceScalars.csv");

  for(_id_6DCA16D75DF1105E = 0; _id_6DCA16D75DF1105E < _id_648068A3992692F7; _id_6DCA16D75DF1105E++) {
    _id_6D9E27D75DC0CF5B = tablelookupbyrow("mp/buyStation/weaponPriceScalars.csv", _id_6DCA16D75DF1105E, 1);
    _id_FACC5533AF7ABE13 = tablelookupbyrow("mp/buyStation/weaponPriceScalars.csv", _id_6DCA16D75DF1105E, 2);
    level.br_armory_kiosk.weapons._id_F6619D771D944FD2[_id_6D9E27D75DC0CF5B] = _id_FACC5533AF7ABE13;
  }
}

_id_723777567250AFB4() {
  level.br_armory_kiosk.weapons._id_734D96BC7D1A1F06 = [];
  _id_522088A531963514 = tablelookupgetnumrows("mp/buyStation/attachmentPriceList.csv");

  for(_id_A1D7492C6665AAEF = 0; _id_A1D7492C6665AAEF < _id_522088A531963514; _id_A1D7492C6665AAEF++) {
    _id_A1F1582C6681F4F6 = tablelookupbyrow("mp/buyStation/attachmentPriceList.csv", _id_A1D7492C6665AAEF, 1);
    _id_DBA2830453494044 = tablelookupbyrow("mp/buyStation/attachmentPriceList.csv", _id_A1D7492C6665AAEF, 2);
    level.br_armory_kiosk.weapons._id_734D96BC7D1A1F06[_id_A1F1582C6681F4F6] = _id_DBA2830453494044;
  }
}

_id_98B7422B7DCBCD5D() {
  level.br_armory_kiosk.weapons._id_40484251044547C1 = [];
  _id_022C065782099074 = tablelookupgetnumrows("mp/buyStation/attachmentPriceScalars.csv");

  for(_id_E3113D8479A341CF = 0; _id_E3113D8479A341CF < _id_022C065782099074; _id_E3113D8479A341CF++) {
    _id_E32B4C8479BF8BD6 = tablelookupbyrow("mp/buyStation/attachmentPriceScalars.csv", _id_E3113D8479A341CF, 1);
    _id_8BAE00B6A3BC9BA4 = tablelookupbyrow("mp/buyStation/attachmentPriceScalars.csv", _id_E3113D8479A341CF, 2);
    level.br_armory_kiosk.weapons._id_40484251044547C1[_id_E32B4C8479BF8BD6] = _id_8BAE00B6A3BC9BA4;
  }
}

_id_6F3BD3113A48F7B7() {
  level.br_armory_kiosk.weapons = spawnStruct();
  _id_9BD43636F6F0D8C4();
  _id_2D02167ADEB2E60D();
  _id_D872D1B4B7C3C32E();
  _id_723777567250AFB4();
  _id_98B7422B7DCBCD5D();
}

_parsepurchaseitemtables() {
  level.br_armory_kiosk.items = [];
  _id_50B073EC9558C3A4 = getdvarint("dvar_EE52115CBCA6F7CC", 1);
  _id_5A3D34C6E7BF27E4 = getdvarint("dvar_051099664F5B3C5C", 1);
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/buyStation/buyStationItems.csv");

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    _id_3793828403C6873E = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 0));
    _id_97642CC850F90CA0 = spawnStruct();
    _id_97642CC850F90CA0._id_2CE272546E3AE7F0 = tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 1);
    _id_97642CC850F90CA0.type = tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 2);
    _id_97642CC850F90CA0.ref = tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 3);
    _id_97642CC850F90CA0.cost = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 4));
    _id_97642CC850F90CA0._id_41F94BCA374ED58A = tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 14);

    if(_id_97642CC850F90CA0.type == "special")
      _id_97642CC850F90CA0._id_3FE0A24318C4A82D = tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 9);
    else
      _id_97642CC850F90CA0._id_3FE0A24318C4A82D = undefined;

    if(_id_97642CC850F90CA0._id_41F94BCA374ED58A != "")
      _id_97642CC850F90CA0._id_41F94BCA374ED58A = int(_id_97642CC850F90CA0._id_41F94BCA374ED58A);
    else
      _id_97642CC850F90CA0._id_41F94BCA374ED58A = undefined;

    _id_D3329A62A63406E9 = getdvarint("dvar_950C868DE7E98DBF", 0);

    if(_id_D3329A62A63406E9 != 0)
      _id_97642CC850F90CA0.firesalediscount = _id_D3329A62A63406E9;
    else
      _id_97642CC850F90CA0.firesalediscount = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 10));

    _id_97642CC850F90CA0.lootid = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", _id_CB89110314447B2F, 11));

    if(_id_50B073EC9558C3A4) {
      _id_140518973901AC9F = _id_EF08EB6F31F46BC3(_id_97642CC850F90CA0.lootid);
      _id_DF48480FCAAB21B9 = _id_5A3D34C6E7BF27E4 && _id_600B944A95C3A7BF::_id_5D47301F7BB7A6BA(_id_97642CC850F90CA0.lootid);
      _id_97642CC850F90CA0._id_7CB19F95DBC68942 = _id_140518973901AC9F || _id_DF48480FCAAB21B9;
    } else
      _id_97642CC850F90CA0._id_7CB19F95DBC68942 = 0;

    level.br_armory_kiosk.items[_id_3793828403C6873E] = _id_97642CC850F90CA0;
  }
}

_id_3E6DDD0AE062AC75() {
  if(!isDefined(level._id_6BE7B375EC4A629C))
    level._id_6BE7B375EC4A629C = _id_4D81AE9CB22F4180("dvar_894C0B1C4E700989", level._id_011A3973390A71E8);

  if(!isDefined(level._id_3899105CEEC08FB8))
    level._id_3899105CEEC08FB8 = _id_4D81AE9CB22F4180("dvar_F4138AD8E0DE3AC6");
}

_id_D1687E85988049BB(_id_CB325DDB4A764623, _id_C95404CD83F761B6) {
  foreach(_id_EB7139726CC569B5 in _id_C95404CD83F761B6) {
    if(_id_EB7139726CC569B5["index"] == level._id_E7CEE4FBB5B46EF2 || isDefined(level._id_747666592AE8CB22) && _id_EB7139726CC569B5["index"] == level._id_747666592AE8CB22) {
      if(isDefined(_id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]) && _id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]["cost"] > 0)
        return _id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]["cost"];
      else
        return undefined;
    }
  }
}

_id_D0E1AFE1BD3614DF(_id_CB325DDB4A764623) {
  _id_6E08BA5C758809B1 = scripts\engine\utility::array_combine(level._id_6BE7B375EC4A629C, level._id_4531798404D47E45);
  cost = _id_D1687E85988049BB(_id_CB325DDB4A764623, _id_6E08BA5C758809B1);

  if(!isDefined(cost) && isDefined(level._id_3899105CEEC08FB8))
    cost = _id_D1687E85988049BB(_id_CB325DDB4A764623, level._id_3899105CEEC08FB8);

  return cost;
}

_id_3CC8B2630D4F56E7(weaponref, _id_31553E68A5164E3E) {
  _id_3C955EFD14A0B2D0 = level.br_armory_kiosk.weapons._id_E2CB29F4B0411D93[weaponref];

  if(!isDefined(_id_3C955EFD14A0B2D0)) {
    _id_3C955EFD14A0B2D0 = level.br_armory_kiosk.weapons._id_E02581D50B48C3F9["base_weapon_price"];
    _id_2C8D5F3760CEFB99 = strtok(weaponref, "_");
    _id_83C238AC98DC9F3C = level.br_armory_kiosk.weapons._id_F6619D771D944FD2[_id_2C8D5F3760CEFB99[1]];

    if(isDefined(_id_83C238AC98DC9F3C))
      _id_3C955EFD14A0B2D0 = floor(float(_id_3C955EFD14A0B2D0) * float(_id_83C238AC98DC9F3C));
  }

  _id_3C955EFD14A0B2D0 = int(_id_3C955EFD14A0B2D0);
  _id_B4A5B92285739A05 = 0;
  _id_D92FA0CDAE417729 = 0;
  _id_1617F2212C6B2C64 = level.br_armory_kiosk.weapons._id_E02581D50B48C3F9["base_attachment_price"];

  foreach(attachmentref in _id_31553E68A5164E3E) {
    if(attachmentref != "none") {
      _id_B4A5B92285739A05++;
      _id_FDF92A09C2352059 = level.br_armory_kiosk.weapons._id_734D96BC7D1A1F06[attachmentref];

      if(!isDefined(_id_FDF92A09C2352059)) {
        _id_FDF92A09C2352059 = _id_1617F2212C6B2C64;
        _id_694AF79C48F661B4 = strtok(attachmentref, "_");
        _id_BA578616096ECAC9 = level.br_armory_kiosk.weapons._id_40484251044547C1[_id_694AF79C48F661B4[0]];

        if(isDefined(_id_BA578616096ECAC9))
          _id_FDF92A09C2352059 = floor(float(_id_1617F2212C6B2C64) * float(_id_BA578616096ECAC9));
      }

      _id_FDF92A09C2352059 = int(_id_FDF92A09C2352059);
      _id_D92FA0CDAE417729 = _id_D92FA0CDAE417729 + _id_FDF92A09C2352059;
    }
  }

  _id_74C73D277613A6AB = level.br_armory_kiosk.weapons._id_E02581D50B48C3F9[scripts\engine\utility::_id_996B01CD49D0128D(["rigging_", scripts\engine\utility::string(min(_id_B4A5B92285739A05, 7))])];

  if(isDefined(_id_74C73D277613A6AB))
    _id_74C73D277613A6AB = int(_id_74C73D277613A6AB);
  else
    _id_74C73D277613A6AB = 0;

  return _id_3C955EFD14A0B2D0 + _id_D92FA0CDAE417729 + _id_74C73D277613A6AB;
}

_getactualcost(player, _id_A365E25AA9D7BCDA) {
  _id_D47B7F992CA8A91E = 0;

  if(isDefined(player.br_kiosk))
    _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(player.br_kiosk, player);

  _id_150663DEF4F4145A = _id_A365E25AA9D7BCDA.cost;
  _id_BBD3CED9F1E6ACBF = _id_D0E1AFE1BD3614DF(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);

  if(isDefined(_id_BBD3CED9F1E6ACBF))
    _id_150663DEF4F4145A = _id_BBD3CED9F1E6ACBF;

  _id_1A61FA389340AE66 = getdvarint(_func_2EF675C13CA1C4AF("scr_", _id_A365E25AA9D7BCDA.ref, "_cost_override"), 0);

  if(_id_1A61FA389340AE66 != 0)
    _id_150663DEF4F4145A = _id_1A61FA389340AE66;

  if(level.br_armory_kiosk.sales_discount > 0) {
    _id_3719B75D66108F99 = level.br_armory_kiosk.sales_discount_items.size == 0 || scripts\engine\utility::array_contains(level.br_armory_kiosk.sales_discount_items, _id_A365E25AA9D7BCDA.ref);

    if(_id_3719B75D66108F99)
      _id_150663DEF4F4145A = _applysalesdiscount(_id_150663DEF4F4145A, level.br_armory_kiosk.sales_discount);
  }

  _id_2D4FA166958B2BBC = _id_0B7A9CE0A2282B79::_id_39F56604458D5A9B(player, _id_A365E25AA9D7BCDA);

  if(isDefined(_id_2D4FA166958B2BBC) && _id_2D4FA166958B2BBC > 0)
    _id_150663DEF4F4145A = _applysalesdiscount(_id_150663DEF4F4145A, _id_2D4FA166958B2BBC * 100);

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk._id_A84A6ACB3C2EDCAE) && scripts\engine\utility::array_contains(player.br_kiosk.players, player))
    return _applysalesdiscount(_id_150663DEF4F4145A, 100);
  else if(_id_D47B7F992CA8A91E)
    return _applysalesdiscount(_id_150663DEF4F4145A, _id_A365E25AA9D7BCDA.firesalediscount);

  return _id_150663DEF4F4145A;
}

_id_59E987D44A301EF5(_id_15B89FF206500554) {
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && isint(_id_15B89FF206500554))
    _id_15B89FF206500554 = self;

  player = self;
  _id_525B03BEAF285C54 = getdvarint("dvar_C37F7E3BB9ECA843", 0);
  _id_7E8ACBB6E945F44A = _id_525B03BEAF285C54 * _id_525B03BEAF285C54;

  for(;;) {
    if(!isDefined(_id_15B89FF206500554) || distancesquared(player.origin, _id_15B89FF206500554.origin) > _id_7E8ACBB6E945F44A) {
      player notify("exit_quick_purchase_zone");
      break;
    }

    wait 0.1;
  }
}

_watchforcircleclosure() {
  level endon("game_ended");
  setdvarifuninitialized("dvar_ACDDD0026CC9ADAD", 0);

  for(;;) {
    level waittill("br_circle_set");
    _id_DFF50030F50C58EA = getdvarint("dvar_ACDDD0026CC9ADAD", 0);

    if(_id_DFF50030F50C58EA == 0) {
      continue;
    }
    if(level.br_circle.circleindex + 1 >= _id_DFF50030F50C58EA) {
      disableallarmorykiosks();

      foreach(player in level.players) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }
        player thread scripts\mp\hud_message::showsplash("br_kiosks_disabled");
      }

      break;
    }
  }
}

showdiscountsplash(_id_04400D6A8D876BD9) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(istrue(player.hasseendiscountsplash)) {
    return;
  }
  if(!isDefined(level.br_armory_kiosk.sales_discount)) {
    return;
  }
  if(level.br_armory_kiosk.sales_discount == 0) {
    return;
  }
  player.hasseendiscountsplash = 1;

  if(isDefined(_id_04400D6A8D876BD9) && _id_04400D6A8D876BD9 > 0)
    wait(_id_04400D6A8D876BD9);

  if(level.br_armory_kiosk.sales_discount_items.size == 0)
    player thread scripts\mp\hud_message::showsplash("br_sales_event_all");
  else
    player thread scripts\mp\hud_message::showsplash("br_sales_event_selective");
}

_id_8807282A387BB5B4() {
  return getdvarint("dvar_E6B890D479B028F4", 0);
}

_id_F29B0D39F0DA104D() {
  if(!_id_8807282A387BB5B4()) {
    return;
  }
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    _id_CF635E78F21650CA._id_60B371EBA77D2372 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
    objective_setshowdistance(_id_CF635E78F21650CA._id_60B371EBA77D2372, 0);
    objective_state(_id_CF635E78F21650CA._id_60B371EBA77D2372, "invisible");
    objective_icon(_id_CF635E78F21650CA._id_60B371EBA77D2372, "ui_mobile_buystation_visual_marker");
    objective_setbackground(_id_CF635E78F21650CA._id_60B371EBA77D2372, 1);
    objective_position(_id_CF635E78F21650CA._id_60B371EBA77D2372, _id_CF635E78F21650CA.origin + (0, 0, 40));
    _id_A7C6C5D6C3D369AA = getdvarfloat("dvar_B57F7C58A492252B", 0);
    _id_0467F4D9B8D9063B = getdvarfloat("dvar_D56247CFC459711F", 0);
    _func_C047D7FFE7A83501(_id_CF635E78F21650CA._id_60B371EBA77D2372, _id_A7C6C5D6C3D369AA, _id_0467F4D9B8D9063B);
  }
}

onprematchdone() {
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "visible");
    _id_CF635E78F21650CA.visible = 1;
    _id_CF635E78F21650CA scripts\common\utility::_id_57257D1ED9CE2F48(::_id_3394094C2FBE7B81);
  }

  _id_F29B0D39F0DA104D();
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("kiosk") || getdvarint("dvar_AC54858B3FD07DAF", 0) == 1) {
    return;
  }
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + getdvarfloat("dvar_64432E664D4AE36A", 0.0);
  _id_C434624FF361BBA2 = _id_52D59C928EB97C81 * _id_52D59C928EB97C81;

  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    _id_E4E4AE4481958D2E = distance2dsquared(_id_CF635E78F21650CA.origin, _id_819EDACDACB810E4) + level._id_53C0FA66001CFF52 > _id_C434624FF361BBA2;

    if(istrue(_id_CF635E78F21650CA.visible)) {
      if(_id_E4E4AE4481958D2E)
        disablearmorykiosk(_id_CF635E78F21650CA);

      continue;
    }

    if(!_id_E4E4AE4481958D2E)
      _id_D9A3848F71C7C63A(_id_CF635E78F21650CA);
  }
}

_id_1A1709943670772A() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("kiosk") || getdvarint("dvar_AC54858B3FD07DAF", 0) == 1) {
    return;
  }
  _id_31966DAE052C3D71 = [];

  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    _id_E4E4AE4481958D2E = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_CF635E78F21650CA.origin, level._id_53C0FA66001CFF52);

    if(istrue(_id_CF635E78F21650CA.visible)) {
      if(_id_E4E4AE4481958D2E) {
        _id_31966DAE052C3D71[_id_31966DAE052C3D71.size] = _id_CF635E78F21650CA;
        disablearmorykiosk(_id_CF635E78F21650CA);
      }

      continue;
    }

    if(!_id_E4E4AE4481958D2E)
      _id_D9A3848F71C7C63A(_id_CF635E78F21650CA);
  }

  return _id_31966DAE052C3D71;
}

disableallarmorykiosks() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("kiosk")) {
    return;
  }
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_CF635E78F21650CA.visible))
      disablearmorykiosk(_id_CF635E78F21650CA);
  }
}

_id_D9A3848F71C7C63A(_id_CF635E78F21650CA) {
  _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "visible");
  _id_CF635E78F21650CA.visible = 1;
  _id_CF635E78F21650CA.disabled = undefined;
  _id_CF635E78F21650CA._id_B19F232FF8887A72 = undefined;
}

disablearmorykiosk(_id_CF635E78F21650CA) {
  if(istrue(level._id_8B92CB4447668562)) {
    _id_CF635E78F21650CA._id_B19F232FF8887A72 = 1;
    _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "disabled_visible");
  } else
    _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "disabled");

  _id_CF635E78F21650CA.visible = undefined;
  _id_CF635E78F21650CA.disabled = 1;

  if(_id_CF635E78F21650CA _id_64ACB6CE534155B7::checkforactiveobjicon())
    _id_CF635E78F21650CA _id_64ACB6CE534155B7::deletequestobjicon();

  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(isDefined(_id_AC0E424AC96A7113.br_kiosk) && _id_AC0E424AC96A7113.br_kiosk == _id_CF635E78F21650CA)
      _id_AC0E424AC96A7113 _closepurchasemenuwithresponse(2);
  }
}

getallspawninstances() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }
  _id_82AAA7C31B818B16 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  return _id_82AAA7C31B818B16;
}

_id_E6C1C35181A2870F() {
  if(!istrue(level.br_armory_kiosk_enabled)) {
    return;
  }
  _id_82AAA7C31B818B16 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  _id_25227F181A5BB8C9 = _id_82AAA7C31B818B16;

  if(istrue(level._id_8DEA6607B3189A60)) {
    _id_91B00DE1B63A7E5A = scripts\engine\utility::getStructArray("buy_station", "targetname");
    _id_25227F181A5BB8C9 = scripts\engine\utility::array_combine_unique(_id_25227F181A5BB8C9, _id_91B00DE1B63A7E5A);
  }

  level._id_6AA304E25520289F = _id_25227F181A5BB8C9;
  return _id_25227F181A5BB8C9;
}

setspawninstances(instances) {
  level.br_armory_kiosk.scriptables = instances;
}

_id_68F55B32AD3368E1() {
  if(!isDefined(level._id_68F55B32AD3368E1))
    level._id_68F55B32AD3368E1 = getdvarint("dvar_CA9C84470EAD8181", 0);

  return level._id_68F55B32AD3368E1;
}

_id_315D0A115FE536EE() {
  if(!isDefined(level._id_315D0A115FE536EE))
    level._id_315D0A115FE536EE = getdvarint("dvar_3AFF3E8D6E0B45DA", 0);

  return level._id_315D0A115FE536EE;
}

_id_785D7C2AE5066F66(_id_3D329EBB0D03D6DB, _id_C95404CD83F761B6) {
  if(_id_C95404CD83F761B6.size == 0) {
    return;
  }
  _id_3D329EBB0D03D6DB = _id_3D329EBB0D03D6DB % _id_C95404CD83F761B6.size;
  return _id_C95404CD83F761B6[_id_3D329EBB0D03D6DB];
}

_id_96E56767B949C013(_id_61B36239E6C3D026, _id_3D329EBB0D03D6DB, _id_849E91C5E0D0E0DF) {
  if(!isDefined(_id_61B36239E6C3D026.angles))
    _id_61B36239E6C3D026.angles = (0, 0, 0);

  _id_5715A6F63100CA0F = "br_plunder_box";

  if(isDefined(_id_61B36239E6C3D026._id_98A72274E33CA7D5))
    _id_5715A6F63100CA0F = "br_plunder_box_high_tier";

  _id_2FA65F34EB9042F5 = spawnscriptable(_id_5715A6F63100CA0F, _id_61B36239E6C3D026.origin, _id_61B36239E6C3D026.angles);
  _id_11A7769E6C3C691F = "visible";

  if(getdvarint("dvar_BE0526203E262092", 0) && getdvarint("dvar_BAC643B1A9D211A7", 0))
    _id_11A7769E6C3C691F = "hidden";

  _id_2FA65F34EB9042F5 setscriptablepartstate("br_plunder_box", _id_11A7769E6C3C691F);
  _id_2FA65F34EB9042F5._id_AFC028D00356E443 = _id_2FA65F34EB9042F5.origin + rotatevector((12, 0, 0), _id_2FA65F34EB9042F5.angles);

  if(isDefined(_id_3D329EBB0D03D6DB))
    _id_2FA65F34EB9042F5._id_7940DCDE72827AF7 = _id_3D329EBB0D03D6DB;

  if(isDefined(_id_3D329EBB0D03D6DB))
    _id_2FA65F34EB9042F5._id_DED92CCB217BBAEB = _id_849E91C5E0D0E0DF;

  if(isDefined(_id_61B36239E6C3D026.target)) {
    foreach(struct in scripts\engine\utility::getStructArray(_id_61B36239E6C3D026.target, "targetname")) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "kiosk_spawn_jltv_mg")
        _id_2FA65F34EB9042F5._id_DB32ABF0A18CADF6 = struct;
    }
  }

  return _id_2FA65F34EB9042F5;
}

_id_B8E0FEA098FB260B(_id_CB8CE683E2999310) {
  if(!isDefined(_id_CB8CE683E2999310.target)) {
    return;
  }
  _id_0459C7F8DE067151 = scripts\engine\utility::getStructArray(_id_CB8CE683E2999310.target, "targetname");

  foreach(struct in _id_0459C7F8DE067151) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "workbench") {
      if(!isDefined(struct.angles))
        struct.angles = (0, 0, 0);

      _id_BCBE0B59F31D0D42 = spawnscriptable("br_workbench", struct.origin, struct.angles);
      _id_BCBE0B59F31D0D42 setscriptablepartstate("br_workbench", "visible");
      return;
    }
  }
}

_id_E486C07C28A71F34() {
  if(!istrue(level._id_8DEA6607B3189A60)) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_D3A06CC30BC1F068 = getdvarint("dvar_1891A7C9188F098A", 1);
  _id_AC63CD16A707ECEA = getdvarint("dvar_1EAAEEC5FBA02706", 3);
  _id_7DE18EFB644429DC = getdvarint("dvar_4CC790851BC37D7C", 3);
  _id_ABD2EABEC6CF5F1E = randomintrange(_id_AC63CD16A707ECEA, _id_7DE18EFB644429DC + 1);
  _id_5FDA87CE72D1D195 = getdvarint("dvar_EECBC418C6540507", 0);
  _id_48CB4DF1FBAB9006 = getdvarint("dvar_5D7D5915E01D1303", 0);
  _id_0D1167A8340D7B64 = squared(getdvarint("dvar_61F3403E27E2815F", 3000));
  level._id_6AA304E25520289F = scripts\engine\utility::getStructArray("buy_station", "targetname");

  if(level._id_6AA304E25520289F.size == 0) {
    return;
  }
  _id_A165C118F696AA70 = getdvarint("dvar_4409A87281D77ED1", 0);
  _id_68F55B32AD3368E1 = _id_68F55B32AD3368E1();

  if(_id_5FDA87CE72D1D195 > 0) {
    _id_4F95D97A13077392 = 0;
    _id_E97A51E0F9B0C2D1 = level._id_6AA304E25520289F.size;
    _id_2446AE45EF06BF3D = [];
    level._id_6AA304E25520289F = scripts\engine\utility::array_randomize(level._id_6AA304E25520289F);

    for(_id_A0ADD690B201F3AD = 0; _id_A0ADD690B201F3AD < _id_E97A51E0F9B0C2D1; _id_A0ADD690B201F3AD++) {
      if(!isDefined(level._id_6AA304E25520289F[_id_A0ADD690B201F3AD])) {
        continue;
      }
      if(_id_2695A20D4011076D::_id_D449927F9683E871(level._id_6AA304E25520289F[_id_A0ADD690B201F3AD].origin)) {
        _id_4076D436F9878FDF = 0;

        foreach(_id_E4A6D0A55FD775A7 in _id_2446AE45EF06BF3D) {
          if(distance2dsquared(_id_E4A6D0A55FD775A7.origin, level._id_6AA304E25520289F[_id_A0ADD690B201F3AD].origin) < _id_0D1167A8340D7B64) {
            _id_4076D436F9878FDF = 1;
            break;
          }
        }

        if(_id_4076D436F9878FDF) {
          continue;
        }
        _id_2446AE45EF06BF3D[_id_2446AE45EF06BF3D.size] = _id_2FCAA447C4E7D4A0(level._id_6AA304E25520289F[_id_A0ADD690B201F3AD], _id_4F95D97A13077392);
        _id_4F95D97A13077392++;

        if(_id_4F95D97A13077392 == _id_5FDA87CE72D1D195) {
          break;
        }
      }
    }
  } else if(!_id_A165C118F696AA70 && !_id_68F55B32AD3368E1) {
    _id_A503FF4C72C94AFE = [];
    _id_932BE85924F099D8 = [];
    _id_E97A51E0F9B0C2D1 = level._id_6AA304E25520289F.size;

    for(_id_A0ADD690B201F3AD = 0; _id_A0ADD690B201F3AD < _id_E97A51E0F9B0C2D1; _id_A0ADD690B201F3AD++) {
      _id_2FA65F34EB9042F5 = level._id_6AA304E25520289F[_id_A0ADD690B201F3AD];

      if(!isDefined(_id_2FA65F34EB9042F5._id_B205D90302DA2F07)) {
        continue;
      }
      if(!isDefined(_id_A503FF4C72C94AFE[_id_2FA65F34EB9042F5._id_B205D90302DA2F07])) {
        _id_A503FF4C72C94AFE[_id_2FA65F34EB9042F5._id_B205D90302DA2F07] = [];
        _id_932BE85924F099D8[_id_932BE85924F099D8.size] = _id_2FA65F34EB9042F5._id_B205D90302DA2F07;
      }

      _id_A503FF4C72C94AFE[_id_2FA65F34EB9042F5._id_B205D90302DA2F07][_id_A503FF4C72C94AFE[_id_2FA65F34EB9042F5._id_B205D90302DA2F07].size] = _id_2FA65F34EB9042F5;
    }

    _id_932BE85924F099D8 = scripts\engine\utility::array_randomize(_id_932BE85924F099D8);
    _id_4F95D97A13077392 = 0;
    _id_97218EEF96CD3102 = 0;

    foreach(_id_72F29FA8DAC796BB in _id_932BE85924F099D8) {
      if(_id_97218EEF96CD3102 == _id_ABD2EABEC6CF5F1E) {
        break;
      }

      if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_72F29FA8DAC796BB)) {
        continue;
      }
      if(scripts\mp\utility\game::getsubgametype() == "dmz" && scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
        _id_4F95D97A13077392 = _id_EACA292314678F38(_id_4F95D97A13077392, _id_A503FF4C72C94AFE[_id_72F29FA8DAC796BB], _id_72F29FA8DAC796BB);
        continue;
      }

      _id_8761FECDF09ADDED = _id_A503FF4C72C94AFE[_id_72F29FA8DAC796BB];
      _id_2A980B0531901C38 = _id_D3A06CC30BC1F068;

      if(_id_2A980B0531901C38 > _id_8761FECDF09ADDED.size)
        _id_2A980B0531901C38 = _id_8761FECDF09ADDED.size;

      _id_8761FECDF09ADDED = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_8761FECDF09ADDED), 0, _id_2A980B0531901C38);

      for(_id_A0ADD690B201F3AD = 0; _id_A0ADD690B201F3AD < _id_8761FECDF09ADDED.size; _id_A0ADD690B201F3AD++) {
        _id_2FCAA447C4E7D4A0(_id_8761FECDF09ADDED[_id_A0ADD690B201F3AD], _id_4F95D97A13077392);
        _id_4F95D97A13077392++;
      }
    }
  } else {
    _id_6AA304E25520289F = level._id_6AA304E25520289F;

    if(!_id_68F55B32AD3368E1)
      _id_6AA304E25520289F = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(level._id_6AA304E25520289F), 0, _id_D3A06CC30BC1F068);

    _id_E97A51E0F9B0C2D1 = _id_6AA304E25520289F.size;
    _id_4F95D97A13077392 = 0;

    for(_id_A0ADD690B201F3AD = 0; _id_A0ADD690B201F3AD < _id_E97A51E0F9B0C2D1; _id_A0ADD690B201F3AD++) {
      _id_2FCAA447C4E7D4A0(_id_6AA304E25520289F[_id_A0ADD690B201F3AD], _id_4F95D97A13077392);
      _id_4F95D97A13077392++;
    }
  }

  if(_id_48CB4DF1FBAB9006 > 0) {
    _id_209967C144016964 = level.br_level.br_circlecenters.size;
    _id_209967C144016964 = int(max(_id_209967C144016964 - 1, 0));
    _id_3E0F25F7303CF9D1 = (level.br_level.br_circlecenters[_id_209967C144016964][0], level.br_level.br_circlecenters[_id_209967C144016964][1], 0);
    level._id_6AA304E25520289F = sortbydistance(level._id_6AA304E25520289F, _id_3E0F25F7303CF9D1);
    _id_5998F57AB1F3C248 = 0;

    for(_id_A0ADD690B201F3AD = 0; _id_A0ADD690B201F3AD < level._id_6AA304E25520289F.size; _id_A0ADD690B201F3AD++) {
      _id_4076D436F9878FDF = 0;

      foreach(_id_2FA65F34EB9042F5 in level.br_armory_kiosk.scriptables) {
        if(distance2dsquared(level._id_6AA304E25520289F[_id_A0ADD690B201F3AD].origin, _id_2FA65F34EB9042F5.origin) < _id_0D1167A8340D7B64) {
          _id_4076D436F9878FDF = 1;
          break;
        }
      }

      if(_id_4076D436F9878FDF) {
        _id_5998F57AB1F3C248++;

        if(_id_5998F57AB1F3C248 == _id_48CB4DF1FBAB9006) {
          break;
        } else
          continue;
      }

      _id_2FCAA447C4E7D4A0(level._id_6AA304E25520289F[_id_A0ADD690B201F3AD], _id_4F95D97A13077392);
      _id_4F95D97A13077392++;
      _id_5998F57AB1F3C248++;

      if(_id_5998F57AB1F3C248 == _id_48CB4DF1FBAB9006) {
        break;
      }
    }
  }
}

_id_086F5339F1334E16() {
  scripts\engine\utility::flag_set("buy_stations_spawned");
}

_id_2FCAA447C4E7D4A0(_id_61B36239E6C3D026, _id_4F95D97A13077392) {
  if(isDefined(level._id_6AA304E25520289F))
    level._id_6AA304E25520289F = scripts\engine\utility::array_remove(level._id_6AA304E25520289F, _id_61B36239E6C3D026);

  if(isDefined(_id_61B36239E6C3D026._id_5EA299587B551F9F)) {
    _id_BF02F24D129FCCA9 = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 1, _id_61B36239E6C3D026._id_5EA299587B551F9F);
    _id_3D329EBB0D03D6DB = int(tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_BF02F24D129FCCA9, 0));
  } else {
    _id_3D329EBB0D03D6DB = undefined;

    if(isDefined(level._id_6BE7B375EC4A629C) && level._id_6BE7B375EC4A629C.size > 0)
      _id_3D329EBB0D03D6DB = _id_785D7C2AE5066F66(_id_4F95D97A13077392, level._id_6BE7B375EC4A629C)["index"];
  }

  if(isDefined(_id_61B36239E6C3D026._id_C4231C7DDE966D14)) {
    _id_BF02F24D129FCCA9 = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 1, _id_61B36239E6C3D026._id_C4231C7DDE966D14);
    _id_849E91C5E0D0E0DF = int(tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_BF02F24D129FCCA9, 0));
  } else {
    _id_849E91C5E0D0E0DF = undefined;

    if(isDefined(level._id_3899105CEEC08FB8) && level._id_3899105CEEC08FB8.size > 0)
      _id_849E91C5E0D0E0DF = _id_785D7C2AE5066F66(_id_4F95D97A13077392, level._id_3899105CEEC08FB8)["index"];
  }

  if(_id_67CC94C07AB18D3A::_id_19598C1EA1487B84())
    _id_B8E0FEA098FB260B(_id_61B36239E6C3D026);

  _id_2FA65F34EB9042F5 = _id_96E56767B949C013(_id_61B36239E6C3D026, _id_3D329EBB0D03D6DB, _id_849E91C5E0D0E0DF);
  _id_2FA65F34EB9042F5._id_5EA299587B551F9F = _id_61B36239E6C3D026._id_5EA299587B551F9F;
  level.br_armory_kiosk.scriptables[level.br_armory_kiosk.scriptables.size] = _id_2FA65F34EB9042F5;
  return _id_2FA65F34EB9042F5;
}

_id_7CB54F604C35BE8C(_id_61B36239E6C3D026) {
  _id_4F95D97A13077392 = level.br_armory_kiosk.scriptables.size;
  _id_D436C77055614CA6 = _id_2FCAA447C4E7D4A0(_id_61B36239E6C3D026, _id_4F95D97A13077392);
  return _id_D436C77055614CA6;
}

_id_027C1CD609D90C09(_id_A1515A5680A32AEF) {
  for(_id_4F95D97A13077392 = 0; _id_4F95D97A13077392 < _id_A1515A5680A32AEF.size; _id_4F95D97A13077392++)
    _id_2FCAA447C4E7D4A0(_id_A1515A5680A32AEF[_id_4F95D97A13077392], _id_4F95D97A13077392);
}

_id_4E433CA69AEE9A03(instance, player) {
  if(istrue(level.gameended))
    return 0;

  if((!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) && !scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipKioskUse", instance)))
    return 0;

  if(istrue(player.iscarrying)) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return 0;
  }

  if(istrue(player.isjuggernaut) && !_id_4F0E283905A1B329::_id_B243F0FD0562BBFB()) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
    return 0;
  }

  if(istrue(instance.locked)) {
    if(!isDefined(instance._id_8D6DBCF5443A11F0))
      instance._id_8D6DBCF5443A11F0 = 0;

    instance._id_8D6DBCF5443A11F0++;
    return 0;
  }

  return 1;
}

armorykioskused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!_id_2CEDCC356F1B9FC8::_id_7897CA6463069464(instance.type) && !_id_2CEDCC356F1B9FC8::_id_A84A6ACB3C2EDCAE(instance.type)) {
    return;
  }
  if(istrue(instance._id_A84A6ACB3C2EDCAE) && !scripts\engine\utility::array_contains(instance.players, player)) {
    return;
  }
  if(istrue(_id_A5B2C541413AA895) && !_id_7E0281196D6407C8()) {
    return;
  }
  if(!isDefined(player))
    player = self;

  if(istrue(_id_A5B2C541413AA895) && !isDefined(player.armorykioskpurchaseallowed))
    player.armorykioskpurchaseallowed = 0;

  if(getdvarint("dvar_ECE0C71AA9D5C939", 0))
    player _id_C471A0358A06A7F0();

  if(!_id_4E433CA69AEE9A03(instance, player)) {
    if(istrue(_id_A5B2C541413AA895))
      player.armorykioskpurchaseallowed = 0;
  } else {
    if(!isDefined(instance.playersused))
      instance.playersused = [];

    if(!scripts\engine\utility::array_contains(instance.playersused, player))
      instance.playersused[instance.playersused.size] = player;

    if(istrue(instance._id_B19F232FF8887A72)) {
      if(soundexists("br_plunder_atm_cancel"))
        player playlocalsound("br_plunder_atm_cancel");

      player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_KIOSK");
    } else {
      if(!isDefined(instance.playersusing))
        instance.playersusing = [];

      instance.playersusing[instance.playersusing.size] = player;

      if(istrue(_id_A5B2C541413AA895)) {
        if(!player.armorykioskpurchaseallowed)
          _id_28D837F720B03BFA(instance, player);
      } else {
        _id_055A0F1BFD09E95E = isDefined(state) && (state == "visible" || state == "visible_blank" || state == "visible_armed" || state == "visible_disarmed" || state == "firesale_visible");

        if(istrue(player.insertingarmorplate))
          player notify("try_armor_cancel", "armory_kiosk_used");

        if(!isDefined(state)) {
          player thread _runpurchasemenu(instance);
          return;
        }

        if(_id_055A0F1BFD09E95E) {
          if(isDefined(instance)) {
            if(_id_2CEDCC356F1B9FC8::_id_7897CA6463069464(instance.type)) {
              _id_9B1941CB7354665E = "opening";

              if(state == "firesale_visible")
                _id_9B1941CB7354665E = "firesale_opening";

              instance setscriptablepartstate("br_plunder_box", _id_9B1941CB7354665E);
            }

            if(istrue(instance._id_A84A6ACB3C2EDCAE)) {
              if(istrue(_id_055A0F1BFD09E95E))
                instance setscriptablepartstate("br_plunder_box_stronghold", "opening");
            }

            instance thread kioskfixupproneplayers();
          }

          player thread _runpurchasemenu(instance);
          return;
        }

        if(state == "opening" || state == "open" || state == "firesale_opening" || state == "firesale_open")
          player thread _runpurchasemenu(instance);
      }
    }
  }
}

_id_C471A0358A06A7F0() {
  player = self;

  foreach(_id_AC0E424AC96A7113 in level.teamdata[player.team]["players"]) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    if(istrue(level.usegulag)) {
      _id_679EC0D579E8D5F3 = _id_AC0E424AC96A7113.game_extrainfo & 512;
      gulagarena = _id_AC0E424AC96A7113.game_extrainfo & 1024;
      _id_43FB259F4877F32C = istrue(_id_AC0E424AC96A7113.wasingulag);
      _id_C3FF2E180FE8A431 = isDefined(_id_AC0E424AC96A7113.gulag);
      _id_BC61B790659A94DC = istrue(_id_AC0E424AC96A7113.gulag);
      _id_5507B0BF5D504E84 = isDefined(_id_AC0E424AC96A7113.gulagarena);
      _id_9A5B643E836607EF = istrue(_id_AC0E424AC96A7113.gulagarena);
      _id_80668BA94093C0C7 = istrue(_id_AC0E424AC96A7113.gulagloser);
      arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_AC0E424AC96A7113);
      _id_A5AFCA0D858D1B83 = isDefined(arena);
    } else {
      _id_679EC0D579E8D5F3 = 0;
      gulagarena = 0;
      _id_43FB259F4877F32C = 0;
      _id_C3FF2E180FE8A431 = 0;
      _id_BC61B790659A94DC = 0;
      _id_5507B0BF5D504E84 = 0;
      _id_9A5B643E836607EF = 0;
      _id_80668BA94093C0C7 = 0;
      arena = 0;
      _id_A5AFCA0D858D1B83 = 0;
    }

    eliminated = istrue(_id_AC0E424AC96A7113.br_iseliminated);
    _id_267908F40DAC4C9D = isalive(_id_AC0E424AC96A7113);
    _id_76456258573201BD = _id_AC0E424AC96A7113.sessionstate;
    _id_967D26D713A6F95C = isDefined(_id_AC0E424AC96A7113 getspectatingplayer());
    _id_86F37CFA6384DCCC = _id_967D26D713A6F95C;
    _id_3F78C6A0862F9E25 = _id_AC0E424AC96A7113._id_3F78C6A0862F9E25;
    logstring("[ WHY_NO_BUYBACK TEST] : " + _id_AC0E424AC96A7113.name + ", " + eliminated + ", " + _id_679EC0D579E8D5F3 + ", " + gulagarena + ", " + _id_43FB259F4877F32C + ", " + _id_C3FF2E180FE8A431 + ", " + _id_BC61B790659A94DC + ", " + _id_5507B0BF5D504E84 + ", " + _id_9A5B643E836607EF + ", " + _id_80668BA94093C0C7 + ", " + _id_A5AFCA0D858D1B83 + ", " + _id_267908F40DAC4C9D + ", " + _id_76456258573201BD + ", " + _id_86F37CFA6384DCCC + ", " + _id_3F78C6A0862F9E25);
  }
}

kioskfixupproneplayers() {
  if(!getdvarint("dvar_636451C6314DF097", 1)) {
    return;
  }
  radius = getdvarfloat("dvar_3990F3347374D18E", 300);
  _id_0A427DED21077317 = sortbydistancecullbyradius(level.players, self.origin, radius);

  foreach(player in _id_0A427DED21077317) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    if(player getstance() != "prone") {
      continue;
    }
    halfsize = player getboundshalfsize();
    radius = halfsize[0];
    height = 2.0 * halfsize[2];

    if(capsuletracepassed(player.origin, radius, height, undefined, 0, 0)) {
      continue;
    }
    player setstance("crouch", 1);
  }
}

_id_3394094C2FBE7B81() {
  level.br_armory_kiosk.scriptables = scripts\engine\utility::array_remove(level.br_armory_kiosk.scriptables, self);
  return 1;
}

kiosksetupfiresaleforplayer(_id_15B89FF206500554, player) {
  if(!isDefined(_id_15B89FF206500554.firesaleforplayers))
    _id_15B89FF206500554.firesaleforplayers = [player];
  else if(!scripts\engine\utility::array_contains(_id_15B89FF206500554.firesaleforplayers, player))
    _id_15B89FF206500554.firesaleforplayers = scripts\engine\utility::array_add(_id_15B89FF206500554.firesaleforplayers, player);

  if(!_id_15B89FF206500554 _id_64ACB6CE534155B7::checkforactiveobjicon())
    _id_15B89FF206500554 _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", _id_15B89FF206500554.origin);

  _id_15B89FF206500554 _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
}

_id_D7F25B3C73157F5C() {
  if(_id_337BD370F7C5E6F9::ispubliceventoftypeactive(2))
    return 1;

  return 0;
}

iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player) {
  if(!isDefined(_id_15B89FF206500554))
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && (!isDefined(_id_15B89FF206500554) || isint(_id_15B89FF206500554)))
    _id_15B89FF206500554 = player;

  if(_id_D7F25B3C73157F5C())
    return 1;

  if(istrue(player._id_F33CC04CFB0810B7))
    return 1;

  if(!isDefined(_id_15B89FF206500554.firesaleforplayers))
    return 0;

  return scripts\engine\utility::array_contains(_id_15B89FF206500554.firesaleforplayers, player);
}

kioskfiresaledoneforplayer(_id_15B89FF206500554, player) {
  if(!isDefined(_id_15B89FF206500554.firesaleforplayers)) {
    return;
  }
  _id_15B89FF206500554 _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  _id_15B89FF206500554.firesaleforplayers = scripts\engine\utility::array_remove(_id_15B89FF206500554.firesaleforplayers, player);

  if(!_id_D7F25B3C73157F5C())
    setomnvar("ui_br_kiosk_hide_discount", 1);
}

_id_1A8066CCDB91C1D1() {
  if(isDefined(level._id_D03E6BA38B56B4AB) && istrue(level._id_D03E6BA38B56B4AB))
    return level._id_FB60F0244999D528;

  return 0;
}

getkioskyawoffsetoverride() {
  if(isDefined(level._id_D03E6BA38B56B4AB) && istrue(level._id_D03E6BA38B56B4AB)) {
    _id_924453750F53A090 = level._id_E9F7702D839B262C;

    if(level._id_F454C63919420AA9 > 0)
      _id_924453750F53A090 = _id_924453750F53A090 + randomfloatrange(level._id_F454C63919420AA9 * -1, level._id_F454C63919420AA9);

    return _id_924453750F53A090;
  }

  return 180.0 + randomfloatrange(-10.0, 10.0);
}

_id_33EE0ADA0B02B12A(_id_15B89FF206500554) {
  if(!isDefined(_id_15B89FF206500554.dropstruct)) {
    _id_15B89FF206500554.dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_15B89FF206500554._id_EF9B890E5F828228 = gettime();
  } else {
    if(_id_15B89FF206500554._id_EF9B890E5F828228 + getdvarint("dvar_30955F4B3A383805", 90) * 1000 < gettime()) {
      _id_15B89FF206500554.dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_15B89FF206500554._id_EF9B890E5F828228 = gettime();
      _id_15B89FF206500554._id_1AC656BA9C98B8DB = undefined;
      return;
    }

    _id_15B89FF206500554._id_EF9B890E5F828228 = gettime();
  }
}

_id_A5F8189DC840E9D6(_id_02EFBE865D1FACDF) {
  player = self;

  if(isDefined(player._id_B8993F862C953DB4) && player._id_B8993F862C953DB4) {
    return;
  }
  player allowmovement(0);
  player._id_B8993F862C953DB4 = 1;
  wait(_id_02EFBE865D1FACDF);
  player allowmovement(1);
  player._id_B8993F862C953DB4 = 0;
}

_runpurchasemenu(_id_15B89FF206500554) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player.br_kiosk = _id_15B89FF206500554;
  _id_33EE0ADA0B02B12A(_id_15B89FF206500554);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    player notify("kiosk_used");

  if(isDefined(level._id_6BEFF7B631AB7E18))
    [[level._id_6BEFF7B631AB7E18]](_id_15B89FF206500554, player);

  if(level._id_EE08B1F41E7C2444)
    player thread _id_A5F8189DC840E9D6(2);

  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player);
  _id_B25A062B16392EDD = _id_879D297885591207(_id_15B89FF206500554);

  if(isDefined(_id_B25A062B16392EDD)) {
    level._id_E7CEE4FBB5B46EF2 = _id_B25A062B16392EDD;
    player setclientomnvar("ui_buystation_override", _id_B25A062B16392EDD);
  } else if(isDefined(level._id_4B3D0771DF2C44A9) && !istrue(player._id_E5B7A6A0EC2B440E)) {
    level._id_E7CEE4FBB5B46EF2 = level._id_4B3D0771DF2C44A9;
    player setclientomnvar("ui_buystation_override", level._id_4B3D0771DF2C44A9);
  }

  if(istrue(level._id_C153EAC6E7C0E1A2)) {
    _id_78B116FF4ED463B9 = _id_342E51952B63E594::_id_6B9FB04B51E91720(player, _id_15B89FF206500554);
    player setclientomnvar("ui_barter_list_index", _id_78B116FF4ED463B9);
  }

  _id_ABA76BFE006A0128 = _id_2A50F66EB0EC8756(_id_15B89FF206500554);

  if(isDefined(_id_ABA76BFE006A0128)) {
    level._id_747666592AE8CB22 = _id_ABA76BFE006A0128;
    player setclientomnvar("ui_weapon_buystation_override", _id_ABA76BFE006A0128);
  }

  _id_6B3C6B40C0598D85 = _id_B88D64CD67BBE60F(_id_15B89FF206500554);

  if(isDefined(_id_6B3C6B40C0598D85))
    player setclientomnvar("ui_buystation_limited_item_amount", _id_6B3C6B40C0598D85);

  _id_5DCB74BC7C559130 = _id_596CE27C393E3593(_id_15B89FF206500554);

  if(isDefined(_id_5DCB74BC7C559130))
    player setclientomnvar("ui_buystation_item_filter", _id_5DCB74BC7C559130);

  setomnvar("ui_br_kiosk_hide_discount", 0);
  player setclientomnvar("ui_buystation_purchase_response", 0);

  if(istrue(player.br_kiosk._id_A84A6ACB3C2EDCAE))
    player setclientomnvar("ui_options_menu", 2);
  else {
    _id_254F655D3A722A22 = 0;

    if(istrue(player.br_kiosk._id_746C06C00CD6BDC5))
      _id_254F655D3A722A22 = _id_254F655D3A722A22 + 16;
    else
      _id_254F655D3A722A22 = _id_254F655D3A722A22 + 2;

    if(_id_D47B7F992CA8A91E)
      _id_254F655D3A722A22 = _id_254F655D3A722A22 + 4;

    if(istrue(_id_15B89FF206500554._id_114E759371623080))
      _id_254F655D3A722A22 = _id_254F655D3A722A22 + 32;

    player setclientomnvar("ui_buystation_open", _id_254F655D3A722A22);
  }

  player.armorykioskpurchaseallowed = 1;
  _id_715028F54BAD19A1::branalytics_kiosk_menu_event(player, "menu_open");
  player thread _id_B543ED41CDF64895(_id_15B89FF206500554);

  if(getdvarint("dvar_B4FF8C1463B8BC79", 1))
    player setsoundsubmix("iw8_br_plunder_kiosk_menu");

  player scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
  player _id_362C58E8BB39BCDA::runbrgametypefunc("playerKioskUsed", _id_15B89FF206500554);
}

_id_28D837F720B03BFA(_id_15B89FF206500554, player) {
  player.br_kiosk = _id_15B89FF206500554;
  player.armorykioskpurchaseallowed = 1;
  player thread _id_00AB62CD6135DFE6(_id_15B89FF206500554);
  player scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_5221F0C9BDEA6589() {
  player = self;
  player.br_kiosk = undefined;
  player._id_E5B7A6A0EC2B440E = undefined;
  player._id_C77002478CDFD85F = undefined;
  player.armorykioskpurchaseallowed = undefined;
  player scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_00AB62CD6135DFE6(_id_15B89FF206500554) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player childthread _id_59E987D44A301EF5(_id_15B89FF206500554);
  scripts\engine\utility::waittill_any_ents(player, "death", player, "last_stand_start", player, "exit_quick_purchase_zone", level, "game_ended");

  if(isDefined(player))
    _id_5221F0C9BDEA6589();
}

_id_EF547F1865E05653(_id_97AA74C2193A9DC6) {
  player = self;
  player setclientomnvar("ui_buystation_purchase_response", _id_97AA74C2193A9DC6);
}

_id_C8BD59CDE912455F(_id_97AA74C2193A9DC6) {
  player = self;

  if(_id_97AA74C2193A9DC6 == 1 && getdvarint("dvar_ED6E4FFA933AF621", 0)) {
    if(!isDefined(player.br_kiosk) || !istrue(player.br_kiosk._id_A84A6ACB3C2EDCAE)) {
      player _id_EF547F1865E05653(1);
      return;
    }
  }

  player _closepurchasemenuwithresponse(_id_97AA74C2193A9DC6);
}

_closepurchasemenuwithresponse(_id_97AA74C2193A9DC6) {
  player = self;
  player setclientomnvar("ui_buystation_purchase_response", _id_97AA74C2193A9DC6);
  player setclientomnvar("ui_buystation_open", 1);
  player setclientomnvar("ui_buystation_override", -1);
  player setclientomnvar("ui_weapon_buystation_override", -1);
  player clearsoundsubmix("iw8_br_plunder_kiosk_menu");
  scripts\cp_mp\vehicles\vehicle_interact::_id_FED77CD5C54EFE19(player._id_C77002478CDFD85F, player);

  if(isDefined(player.br_kiosk)) {
    player.br_kiosk.playersusing = scripts\engine\utility::array_remove(player.br_kiosk.playersusing, player);

    if(istrue(player.br_kiosk._id_A84A6ACB3C2EDCAE)) {
      if(_id_97AA74C2193A9DC6 == 1 && scripts\engine\utility::array_contains(player.br_kiosk.players, player)) {
        player.br_kiosk.players = scripts\engine\utility::array_remove(player.br_kiosk.players, player);
        player.br_kiosk._id_4261EB2AB67DB6F7 = scripts\engine\utility::array_add(player.br_kiosk._id_4261EB2AB67DB6F7, player);
        player.br_kiosk _id_744CAD313ED0A87E::_id_648D8F21BD9DC5C4(player);

        if(player.br_kiosk.players.size <= 0 && !istrue(level._id_25E8B4AFE5E06169))
          player.br_kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_blank");
      }

      player setclientomnvar("ui_options_menu", 0);
    }
  }

  player.br_kiosk = undefined;
  player._id_E5B7A6A0EC2B440E = undefined;
  player._id_C77002478CDFD85F = undefined;
  player.armorykioskpurchaseallowed = undefined;
  player._id_192CBAB14DE92A20 = undefined;

  if(level._id_EE08B1F41E7C2444 && isDefined(player._id_B8993F862C953DB4) && player._id_B8993F862C953DB4) {
    player allowmovement(1);
    player._id_B8993F862C953DB4 = 0;
  }

  _id_715028F54BAD19A1::branalytics_kiosk_menu_event(player, "menu_close", "reason: " + _id_97AA74C2193A9DC6);
  player notify("_watchToAutoCloseMenu_end");
  player scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_purchasemenuclosedbyclient(player) {
  player _id_C8BD59CDE912455F(0);
  player notify("_watchToAutoCloseMenu_end");
}

_id_B543ED41CDF64895(_id_15B89FF206500554) {
  player = self;
  player endon("disconnect");
  player notify("_watchToAutoCloseMenu_end");
  player endon("_watchToAutoCloseMenu_end");
  player childthread _proximitywatcher(_id_15B89FF206500554);
  scripts\engine\utility::waittill_any_ents(player, "death", player, "last_stand_start", player, "pushed_too_far", level, "game_ended");

  if(isDefined(player.pers["telemetry"])) {
    if(istrue(player.pers["telemetry"]._id_399EB9EA9DA87875)) {
      player.pers["telemetry"]._id_B04ABD5D84312ACB = 1;
      player.pers["telemetry"]._id_399EB9EA9DA87875 = 0;
    }
  }

  player _id_C8BD59CDE912455F(2);
}

_proximitywatcher(_id_15B89FF206500554) {
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && isint(_id_15B89FF206500554))
    _id_15B89FF206500554 = self;

  player = self;
  _id_23D839B7D0ACE88A = 64;
  _id_525B03BEAF285C54 = getdvarfloat("dvar_ECD52993B5DAB130", 128) + _id_23D839B7D0ACE88A;
  _id_7E8ACBB6E945F44A = _id_525B03BEAF285C54 * _id_525B03BEAF285C54;

  for(;;) {
    wait 0.1;
    _id_77C977C78B3F7D84 = distancesquared(player.origin, _id_15B89FF206500554.origin);

    if(_id_77C977C78B3F7D84 > _id_7E8ACBB6E945F44A) {
      player notify("pushed_too_far");
      break;
    }
  }
}

_getequipmentammotomax(equipmentref) {
  player = self;

  if(!isDefined(equipmentref))
    return 0;

  ammo = player scripts\mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipmentref);
  return max(0, ammomax - ammo);
}

_maxoutequipmentammo(equipmentref) {
  player = self;

  if(!isDefined(equipmentref))
    return 0;

  ammo = player scripts\mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipmentref);

  if(ammo < ammomax)
    player scripts\mp\equipment::setequipmentammo(equipmentref, ammomax);
}

_id_8C8F1E3F153A6FA3() {}

_findgivearmoramountanddropleftovers(_id_7F437A5779C8787C, _id_2737CAC9EE8F6098) {
  player = self;
  _id_3E048EF43950BBD7 = player scripts\mp\equipment::getequipmentslotammo("health");

  if(!isDefined(_id_3E048EF43950BBD7))
    _id_3E048EF43950BBD7 = 0;

  _id_AC932F5B44405F3B = player scripts\mp\equipment::getequipmentmaxammo("equip_armorplate");

  if(getdvarint("dvar_AD67CF67992FE5F2", 0))
    _id_CF60CDC4E2F0E3D0 = 2;
  else
    _id_CF60CDC4E2F0E3D0 = 5;

  _id_BF203CE62DD1C99C = int(max(min(_id_CF60CDC4E2F0E3D0, _id_AC932F5B44405F3B - _id_3E048EF43950BBD7), 0));
  _id_2FB86E1C9B4C6464 = _id_CF60CDC4E2F0E3D0 - _id_BF203CE62DD1C99C;
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  if(istrue(_id_7F437A5779C8787C) && isDefined(player.br_kiosk)) {
    _id_E1D097C517C3AF5B = player.br_kiosk _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
    player.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
    dropstruct = player.br_kiosk.dropstruct;
  }

  if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A("brloot_armor_plate")) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = "brloot_armor_plate";
    _id_60227BFF1E9478CC.count = _id_2FB86E1C9B4C6464;
    _id_F94E260AC3C6121E = player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC, 1);

    if(_id_F94E260AC3C6121E > 0 && !istrue(_id_2737CAC9EE8F6098)) {
      baseorigin = player.origin;
      baseangles = player.angles;

      if(istrue(_id_7F437A5779C8787C) && isDefined(player.br_kiosk)) {
        baseorigin = scripts\engine\utility::_id_53C4C53197386572(player.br_kiosk._id_AFC028D00356E443, player.br_kiosk.origin);
        baseangles = player.br_kiosk.angles;
      }

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
      _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4, _id_2FB86E1C9B4C6464, 1);
    }
  } else if(_id_2FB86E1C9B4C6464 > 0 && !istrue(_id_2737CAC9EE8F6098)) {
    baseorigin = player.origin;
    baseangles = player.angles;

    if(istrue(_id_7F437A5779C8787C) && isDefined(player.br_kiosk)) {
      baseorigin = scripts\engine\utility::_id_53C4C53197386572(player.br_kiosk._id_AFC028D00356E443, player.br_kiosk.origin);
      baseangles = player.br_kiosk.angles;
    }

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
    _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4, _id_2FB86E1C9B4C6464, 1);
  }

  return _id_BF203CE62DD1C99C;
}

_validateitempurchase(_id_15B89FF206500554, _id_A365E25AA9D7BCDA, _id_6DC0E605ECD21EEE, _id_07C3865DEE4ABED6, _id_D260DF4653B74CEF) {
  player = self;
  _id_3BDC75A8B6E7B7CD = scripts\engine\utility::ter_op(_id_D260DF4653B74CEF, 2, 0);
  _id_A55838D829A2C54B = scripts\engine\utility::ter_op(_id_3BDC75A8B6E7B7CD == 2, 0, 1);

  if(istrue(_id_A365E25AA9D7BCDA._id_7CB19F95DBC68942)) {
    player _id_C8BD59CDE912455F(24);
    return 0;
  }

  _id_B690D52FA5CC0957 = _id_A0389E3244A68894(_id_15B89FF206500554, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);

  if(!istrue(_id_B690D52FA5CC0957)) {
    player _id_C8BD59CDE912455F(24);
    return 0;
  }

  _id_F80AD141CA44A56C = _id_6AF40E269AAE683E(_id_15B89FF206500554, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);

  if(isDefined(_id_F80AD141CA44A56C) && _id_F80AD141CA44A56C <= 0) {
    player _id_C8BD59CDE912455F(24);
    return 0;
  }

  _id_FBD5FADA61AE8341 = _getactualcost(player, _id_A365E25AA9D7BCDA);

  if(!isDefined(player.plundercount))
    player.plundercount = 0;

  if(player.plundercount < _id_FBD5FADA61AE8341) {
    player _id_C8BD59CDE912455F(3);
    return 0;
  }

  if(isDefined(_id_A365E25AA9D7BCDA._id_41F94BCA374ED58A)) {
    _id_E75264E51D24BB57 = _id_0B7A9CE0A2282B79::_id_59352C09A417A5E2(player, _id_A365E25AA9D7BCDA._id_41F94BCA374ED58A);

    if(!_id_E75264E51D24BB57)
      return 0;
  }

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("kioskValidateItemPurchase")) {
    result = player _id_362C58E8BB39BCDA::runbrgametypefunc("kioskValidateItemPurchase", _id_15B89FF206500554, _id_A365E25AA9D7BCDA);

    if(isDefined(result)) {
      if(!istrue(result))
        return 0;
      else
        return 1;
    }
  }

  if(_id_A365E25AA9D7BCDA.type == "killstreak") {
    if(!istrue(_id_6DC0E605ECD21EEE)) {
      if(player _id_7E52B56769FA7774::haskillstreak(_id_A365E25AA9D7BCDA.ref)) {
        if(_id_A55838D829A2C54B)
          player _id_C8BD59CDE912455F(4);

        return _id_3BDC75A8B6E7B7CD;
      }
    }
  } else if(_id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super") {
    if(player scripts\mp\supers::issuperinuse()) {
      if(_id_A55838D829A2C54B)
        player _id_C8BD59CDE912455F(6);

      return _id_3BDC75A8B6E7B7CD;
    }

    if(!istrue(_id_6DC0E605ECD21EEE)) {
      _id_75630A54FF140EC2 = player scripts\mp\supers::getcurrentsuperref();

      if(isDefined(_id_75630A54FF140EC2) && _id_A365E25AA9D7BCDA.ref == _id_75630A54FF140EC2) {
        if(_id_A55838D829A2C54B)
          player _id_C8BD59CDE912455F(5);

        return _id_3BDC75A8B6E7B7CD;
      }
    }
  } else if(_id_A365E25AA9D7BCDA.type == "perk") {
    if(player scripts\mp\utility\perk::_hasperk(_id_A365E25AA9D7BCDA.ref)) {
      if(_id_A55838D829A2C54B)
        player _id_C8BD59CDE912455F(5);

      return _id_3BDC75A8B6E7B7CD;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "equipment") {
    if(istrue(_id_07C3865DEE4ABED6))
      return 2;

    _id_6A8B46E184E181CC = spawnStruct();
    _id_6A8B46E184E181CC.scriptablename = _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0;
    _id_6A8B46E184E181CC.count = 1;
    _id_DC297349765E2088 = _id_7E52B56769FA7774::cantakepickup(_id_6A8B46E184E181CC, 1);

    switch (_id_DC297349765E2088) {
      case 20:
      case 1:
        break;
      default:
        if(_id_A55838D829A2C54B)
          player _id_C8BD59CDE912455F(7);

        return _id_3BDC75A8B6E7B7CD;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "weapon") {
    if(istrue(player._id_859654E0445A36D9)) {
      if(isDefined(level.br_pickups) && isDefined(level.br_pickups._id_355CDDB773CB000D))
        player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);

      return 0;
    }

    _id_DD515FCF025B2E79 = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(_id_A365E25AA9D7BCDA.ref);

    if(isDefined(_id_DD515FCF025B2E79)) {
      foreach(_id_DE88CD14114C1E24 in player.primaryweapons) {
        if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(7);

          return 0;
        }
      }

      if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
        _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

        if(issameweapon(_id_9AC5E72784815708, _id_DD515FCF025B2E79)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(7);

          return 0;
        }
      }
    }

    return 1;
  } else if(_id_A365E25AA9D7BCDA.type == "special" || _id_A365E25AA9D7BCDA.type == "persistent") {
    switch (_id_A365E25AA9D7BCDA.ref) {
      case "armor_bundle":
      case "armor_plate":
      case "armor":
        if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
          _id_6A8B46E184E181CC = spawnStruct();
          _id_6A8B46E184E181CC.scriptablename = "brloot_armor_plate";

          if(_id_A365E25AA9D7BCDA.ref == "armor_bundle")
            _id_6A8B46E184E181CC.count = 5;
          else
            _id_6A8B46E184E181CC.count = 1;

          _id_DC297349765E2088 = _id_7E52B56769FA7774::cantakepickup(_id_6A8B46E184E181CC);

          if(_id_DC297349765E2088 != 1) {
            if(_id_A55838D829A2C54B)
              player _id_C8BD59CDE912455F(7);

            return _id_3BDC75A8B6E7B7CD;
          }
        }

        break;
      case "armor_plate_instant":
        _id_1F158CCAA5D9C0BE = _id_07C40FA80892A721::_id_92FEC40B905C5112();

        if(!_id_1F158CCAA5D9C0BE) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(7);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "gas_mask":
      case "brloot_equip_gasmask_scuba":
      case "brloot_equip_gasmask_durable":
      case "gas_mask_mobile":
      case "brloot_equip_gasmask":
        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = scripts\cp_mp\gasmask::_id_D855F39E2B239317(_id_A365E25AA9D7BCDA.ref);
        _id_6A8B46E184E181CC.count = scripts\cp_mp\gasmask::_id_894ADF8CE12D224D(_id_6A8B46E184E181CC.scriptablename);
        _id_DC297349765E2088 = _id_7E52B56769FA7774::cantakepickup(_id_6A8B46E184E181CC, 1);

        switch (_id_DC297349765E2088) {
          case 20:
          case 1:
            break;
          default:
            if(_id_A55838D829A2C54B)
              player _id_C8BD59CDE912455F(7);

            return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "ammo_refill":
        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        _id_B1DB5698237FE274 = 0;

        if(player _getequipmentammotomax(player.equipment["primary"]) > 0)
          _id_B1DB5698237FE274 = 1;
        else if(player _getequipmentammotomax(player.equipment["secondary"]) > 0)
          _id_B1DB5698237FE274 = 1;
        else if(!player _id_724736FCF0FB6604::br_ammo_player_is_maxed_out())
          _id_B1DB5698237FE274 = 1;

        if(!_id_B1DB5698237FE274) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(7);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "respawn_token":
      case "brloot_redeploy_token":
        if(_id_7E52B56769FA7774::respawntokendisabled()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(9);

          return 0;
        }

        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        if(istrue(player.hasrespawntoken)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(10);

          return 0;
        }

        break;
      case "brloot_gulag_token":
        if(_id_2CEDCC356F1B9FC8::_id_8B2396647673BE50()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(9);

          return 0;
        }

        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        if(istrue(player _id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A())) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(10);

          return 0;
        }

        break;
      case "self_revive_token_mobile":
      case "self_revive_token":
        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        if(player _id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(10);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "supply_drop":
        if(istrue(_id_07C3865DEE4ABED6))
          return 2;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = "brloot_offhand_advancedsupplydrop";
        _id_6A8B46E184E181CC.count = 1;
        _id_DC297349765E2088 = _id_7E52B56769FA7774::cantakepickup(_id_6A8B46E184E181CC, 1);

        if(_id_DC297349765E2088 != 1) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(7);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "circle_pick":
        if(isDefined(level.br_circle)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(17);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "redeploy":
        if(isDefined(level.br_circle) || istrue(level.brgametype.circlerunning)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(9);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_repair":
        if(!player _id_334BEE7871C3AE0F()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(21);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_upgrade_armor":
        if(!player _id_FF0081CA56B5A384("armor")) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(20);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_refill_trophy":
        if(!player _id_A037837DC6C85636()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(19);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_upgrade_trophy":
        if(!player _id_FF0081CA56B5A384("trophy")) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(20);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_upgrade_uav":
        if(!player _id_FF0081CA56B5A384("uav")) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(20);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_upgrade_barrel":
        if(!player _id_FF0081CA56B5A384("barrel")) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(20);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "vehicle_replace":
        if(!player _id_799D521F485A1701::_id_81124B7B16101F8B()) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(23);

          return 0;
        }

        break;
      case "loot_key_fortress":
      case "brloot_self_revive":
      case "brloot_backpack_medium":
      case "brloot_plate_carrier_2":
      case "brloot_plate_carrier_3":
      case "brloot_backpack_large":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0;
        _id_6A8B46E184E181CC.count = 1;
        _id_DC297349765E2088 = _id_7E52B56769FA7774::cantakepickup(_id_6A8B46E184E181CC);

        switch (_id_DC297349765E2088) {
          case 20:
          case 1:
            break;
          default:
            if(_id_A55838D829A2C54B)
              player _id_C8BD59CDE912455F(7);

            return _id_3BDC75A8B6E7B7CD;
        }
      case "vehicle_apc_improved_ammo":
      case "vehicle_defense_tier_2":
      case "vehicle_defense_tier_1":
      case "defense_spawn_plate_tier_2":
      case "defense_spawn_plate_tier_1":
      case "defense_spawn_armor_tier_2":
      case "defense_spawn_armor_tier_1":
      case "deploy_minefield":
      case "ai_jugg":
      case "ai_squad":
      case "uav_ping_global":
      case "uav_ping_duration":
      case "uav_ping_radius":
      case "uav_ping":
      case "ammo_depot":
      case "longer_capture_time":
        objective = undefined;

        if(isDefined(level._id_D23C7C1ADD9FB181))
          objective = player[[level._id_D23C7C1ADD9FB181]]();

        if(isDefined(objective) && isDefined(level._id_4DE8052758F986F3) && [[level._id_4DE8052758F986F3]](objective.objectivekey, player.team, _id_A365E25AA9D7BCDA.ref)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(17);

          return _id_3BDC75A8B6E7B7CD;
        }

        break;
      case "risk_turret":
      case "skydive_redeploy":
        break;
      case "research_upgrade_defense":
      case "research_upgrade_vehicle":
      case "research_upgrade_uav":
        break;
      case "brloot_life_insurance":
      case "brloot_credit_card":
        itemname = getsubstr(_id_A365E25AA9D7BCDA.ref, 7);

        if(player _id_7E52B56769FA7774::_id_E351A4B1C26EC991(itemname)) {
          if(_id_A55838D829A2C54B)
            player _id_C8BD59CDE912455F(17);

          return 0;
        }

        break;
    }
  }

  return 1;
}

_killstreakneedslocationselection(_id_A4E8372932B8612C) {
  switch (_id_A4E8372932B8612C) {
    case "toma_strike":
    case "precision_airstrike":
      return 1;
    case "uav":
      return 0;
    default:
      return 0;
  }
}

_locationselectioninterrupt() {
  player = self;
  scripts\engine\utility::waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

_handlekillstreakpurchase(_id_A365E25AA9D7BCDA, _id_A5AB866673E5E99D, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  player = self;
  player endon("disconnect");
  activateimmediately = getdvarint("dvar_E516A6AA0D85B36D", 0);

  if(!activateimmediately) {
    player _id_7E52B56769FA7774::forcegivekillstreak(_id_A365E25AA9D7BCDA.ref, _id_A5AB866673E5E99D, 1, _id_1E736A37C3737585, _id_DB943473454F6EA6);
    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "killstreak", "br_killstreak_purchased");
  } else {
    if(_killstreakneedslocationselection(_id_A365E25AA9D7BCDA.ref)) {
      _id_6EB64F3FEA3BBE81 = player.br_kiosk;
      player _id_C8BD59CDE912455F(16);
      player scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
      player beginlocationselection(0, 0, "circle_marker", 0, 4);
      player childthread _locationselectioninterrupt();
      _id_6E586A99FA56A20F = player scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
      player endlocationselection();
      player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");

      if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
        _id_9083EA775F3B0CD7 = _id_1E4A61DB11011446::traceselectedmaplocation(_id_6E586A99FA56A20F.location);
        player.kstargetlocation = _id_9083EA775F3B0CD7["position"];
        _id_E4AECB271D56914B = player _id_7E52B56769FA7774::forceusekillstreak(_id_A365E25AA9D7BCDA.ref);

        if(istrue(_id_E4AECB271D56914B)) {
          _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "killstreak", "br_killstreak_purchased_and_activated");
          return;
        }

        return;
      }

      player thread _runpurchasemenu(_id_6EB64F3FEA3BBE81);
      return;
      return;
    }

    player _id_7E52B56769FA7774::forcegivekillstreak(_id_A365E25AA9D7BCDA.ref, _id_A5AB866673E5E99D, 1, _id_DB943473454F6EA6);
    _id_E4AECB271D56914B = player _id_7E52B56769FA7774::forceusekillstreak(_id_A365E25AA9D7BCDA.ref);

    if(istrue(_id_E4AECB271D56914B))
      _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "killstreak", "br_killstreak_purchased_and_activated");
  }
}

_id_90B0E9EB26E38443(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  scriptablename = _id_A365E25AA9D7BCDA.ref;
  _id_BADA25504E8844D7 = spawnStruct();
  _id_BADA25504E8844D7.scriptablename = scriptablename;
  _id_BADA25504E8844D7.origin = self.origin;
  _id_BADA25504E8844D7.count = 1;
  _id_BADA25504E8844D7.maxcount = level.br_pickups.maxcounts[scriptablename];
  _id_BADA25504E8844D7.stackable = level.br_pickups.stackable[scriptablename];
  [ammo, _id_04F04B15053655BA, _id_35EAD47ED0D7507E] = _id_4480C6CE37B2BDF3::_id_5C9E1BD30347CB36(level.br_lootiteminfo[scriptablename].fullweaponobj);
  _id_BADA25504E8844D7.count = ammo * 3;
  _id_BADA25504E8844D7.countlefthand = _id_04F04B15053655BA;
  _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_35EAD47ED0D7507E;
  _id_724736FCF0FB6604::takeweaponpickup(_id_BADA25504E8844D7, undefined, undefined, undefined, 1);
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "weapon");
}

_handlefieldupgradepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  if(scripts\mp\supers::issuperinuse()) {
    _id_733D60A5F3A8C170 = undefined;

    foreach(scriptablename, _id_5237A188CCDA4D7B in level.br_pickups._id_14BD11727C4B6629) {
      if(_id_5237A188CCDA4D7B == _id_A365E25AA9D7BCDA.ref) {
        _id_733D60A5F3A8C170 = scriptablename;
        break;
      }
    }

    if(isDefined(_id_733D60A5F3A8C170)) {
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = _id_733D60A5F3A8C170;
      _id_60227BFF1E9478CC.count = 1;
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_733D60A5F3A8C170);
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC, undefined, undefined, 1);
      _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "fieldUpgrade", "br_field_upgrade_purchased");
    }
  } else {
    _id_7E52B56769FA7774::forcegivesuper(_id_A365E25AA9D7BCDA.ref, _id_7DDDAC09987D559E, 1, _id_452130D9D126E506, _id_DB943473454F6EA6);
    _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "fieldUpgrade", "br_field_upgrade_purchased");

    if((level.allowsupers || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) && !istrue(_id_452130D9D126E506))
      scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
  }
}

_id_B140D6E72B665C8F(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554) {
  player = self;
  _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, undefined, 1, _id_452130D9D126E506);

  if(!_id_59CDCDF44A2FA379) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(_id_15B89FF206500554.dropstruct)) {
      _id_E1D097C517C3AF5B = _id_15B89FF206500554 _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
      _id_15B89FF206500554.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = _id_15B89FF206500554.dropstruct;
    }

    count = 1;

    if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(_id_A365E25AA9D7BCDA.lootid, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0))
      count = level.br_pickups.counts[_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0];

    _id_285B7129B392CF3D = _id_15B89FF206500554 _id_7E52B56769FA7774::quickdropaddtoexisting(undefined, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, count);

    if(!_id_285B7129B392CF3D) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, scripts\engine\utility::_id_53C4C53197386572(_id_15B89FF206500554._id_AFC028D00356E443, _id_15B89FF206500554.origin), _id_15B89FF206500554.angles, player);
      pickupent = _id_7E52B56769FA7774::spawnpickup(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, _id_CB4FAD49263E20C4, count, 1, undefined, 0);
      _id_15B89FF206500554 _id_7E52B56769FA7774::quickdropaddtocache(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, undefined, pickupent, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
    }

    _id_59CDCDF44A2FA379 = 1;
  }

  if(_id_59CDCDF44A2FA379)
    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "equipment", "br_equipment_purchased");

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
    if(isDefined(level._id_8EC1A1CA587A6487))
      player[[level._id_8EC1A1CA587A6487]](_id_A365E25AA9D7BCDA.ref);
  }

  armorykioskused(_id_15B89FF206500554, undefined, undefined, self);
}

_id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, scriptablename, count, _id_25F0D68EE22434EB, quickdropcache) {
  if(!_id_59CDCDF44A2FA379 && _id_25F0D68EE22434EB) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(_id_15B89FF206500554.dropstruct)) {
      _id_E1D097C517C3AF5B = _id_15B89FF206500554 _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
      _id_15B89FF206500554.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = _id_15B89FF206500554.dropstruct;
    }

    _id_285B7129B392CF3D = 0;

    if(istrue(quickdropcache))
      _id_285B7129B392CF3D = _id_15B89FF206500554 _id_7E52B56769FA7774::quickdropaddtoexisting(undefined, scriptablename, count);

    if(!_id_285B7129B392CF3D) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, scripts\engine\utility::_id_53C4C53197386572(_id_15B89FF206500554._id_AFC028D00356E443, _id_15B89FF206500554.origin), _id_15B89FF206500554.angles, player);
      pickupent = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, count, 1, undefined, 0);

      if(istrue(quickdropcache))
        _id_15B89FF206500554 _id_7E52B56769FA7774::quickdropaddtocache(scriptablename, undefined, pickupent, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);
    }

    return 1;
  }

  return _id_59CDCDF44A2FA379;
}

_handlespecialpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554, _id_682E4B53880A6720, _id_DB943473454F6EA6) {
  player = self;
  _id_25F0D68EE22434EB = _id_7DDDAC09987D559E && _id_682E4B53880A6720;
  _id_59CDCDF44A2FA379 = 1;
  _id_B517DF938986556F = 1;
  _id_3E048EF43950BBD7 = undefined;
  quantity = 1;
  _id_96C7526F4AB04875 = undefined;

  switch (_id_A365E25AA9D7BCDA.ref) {
    case "armor_plate":
    case "armor":
      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, undefined, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, "brloot_armor_plate", 1, _id_25F0D68EE22434EB, 1);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
      break;
    case "armor_bundle":
      _id_2B83F7CF5DD2CF23 = player _findgivearmoramountanddropleftovers(1);

      if(_id_2B83F7CF5DD2CF23 <= 0)
        _id_59CDCDF44A2FA379 = 1;
      else
        _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, _id_2B83F7CF5DD2CF23, 1, _id_452130D9D126E506);

      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, "brloot_armor_plate", _id_2B83F7CF5DD2CF23, _id_25F0D68EE22434EB, 1);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
      quantity = _id_2B83F7CF5DD2CF23;
      break;
    case "gas_mask":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask";
      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_1680A35FE50DC05E, 1, undefined, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_1680A35FE50DC05E, 108, _id_25F0D68EE22434EB);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_1680A35FE50DC05E);
      break;
    case "gas_mask_mobile":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask";
      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_1680A35FE50DC05E, 1, undefined, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_1680A35FE50DC05E, 108, _id_25F0D68EE22434EB);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_1680A35FE50DC05E);
      break;
    case "ammo_refill":
      player _id_724736FCF0FB6604::br_ammo_player_max_out();
      player _maxoutequipmentammo(player.equipment["primary"]);
      player _maxoutequipmentammo(player.equipment["secondary"]);
      break;
    case "respawn_token":
    case "brloot_redeploy_token":
      player _id_7E52B56769FA7774::addrespawntoken();
      _id_B517DF938986556F = 0;
      break;
    case "self_revive_token":
      _id_5DB3E79EF6900447 = "brloot_self_revive";

      if(istrue(_id_452130D9D126E506)) {
        _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
        _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_5DB3E79EF6900447, 1, 0);
      } else if(player _id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
        _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
        _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_5DB3E79EF6900447, 1, _id_25F0D68EE22434EB);
      } else
        player _id_7E52B56769FA7774::addselfrevivetoken();

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_5DB3E79EF6900447);
      _id_B517DF938986556F = 0;
      break;
    case "self_revive_token_mobile":
      _id_5DB3E79EF6900447 = "brloot_self_revive";

      if(istrue(_id_452130D9D126E506)) {
        _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
        _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_5DB3E79EF6900447, 1, 0);
      } else if(player _id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
        _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
        _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_5DB3E79EF6900447, 1, _id_25F0D68EE22434EB);
      } else
        player _id_7E52B56769FA7774::addselfrevivetoken();

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_5DB3E79EF6900447);
      _id_B517DF938986556F = 0;
      break;
    case "supply_drop":
      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, "brloot_offhand_advancedsupplydrop", 1, _id_25F0D68EE22434EB);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_offhand_advancedsupplydrop");
      break;
    case "circle_pick":
      _id_59CDCDF44A2FA379 = player playerhandlecirclepickitem();
      break;
    case "redeploy":
      _id_59CDCDF44A2FA379 = player playerhandleredeploy();
      break;
    case "vehicle_repair":
      _id_59CDCDF44A2FA379 = player _handlevehiclerepair();
      break;
    case "vehicle_upgrade_armor":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("armor");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_refill_trophy":
      _id_59CDCDF44A2FA379 = player _id_9FC999A4450EACB2("trophy_refill");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_trophy":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("trophy");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_uav":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("uav");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_barrel":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("barrel");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_turret":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("turret");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_smoke":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("smoke");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_upgrade_engine":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("engine");
      _id_B517DF938986556F = 0;
      break;
    case "vehicle_replace":
      _id_59CDCDF44A2FA379 = player _id_202BF25CC40D87B4(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      _id_B517DF938986556F = 0;
      break;
    case "veh9_mil_lnd_mrap":
    case "veh9_jltv_mg":
      _id_59CDCDF44A2FA379 = player _handlevehiclepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E);

      if(_id_59CDCDF44A2FA379)
        player thread scripts\mp\hud_message::showsplash("br_vehicle_purchased");
      else
        player scripts\mp\hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");

      break;
    case "dmz_exfil_personal":
      _id_59CDCDF44A2FA379 = player _id_5307834CD39B435C::_id_7FF5E35E992DF372();

      if(_id_59CDCDF44A2FA379) {
        players = scripts\mp\utility\teams::getteamdata(player.team, "players");

        foreach(_id_F0EA4030349A33D5 in players) {
          _id_F0EA4030349A33D5 setclientomnvar("ui_owns_personal_exfil", 1);
          _id_F0EA4030349A33D5._id_5A4D470F2093FFF1 = 1;
        }

        player thread _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_purchased", players);
      } else
        player scripts\mp\hud_message::showerrormessage("DMZ/EXFIL_PURCHASED_FAILED");

      break;
    case "brloot_equip_gasmask_scuba":
    case "brloot_equip_gasmask_durable":
    case "brloot_equip_gasmask":
      count = 216;

      if(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0 == "brloot_equip_gasmask" || _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0 == "brloot_equip_gasmask_scuba")
        count = 108;

      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, count, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, count, _id_25F0D68EE22434EB);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);
      break;
    case "brloot_valuable_bunker_board_epic":
    case "brloot_valuable_bunker_liquid_nitrogen":
    case "brloot_valuable_bunker_server_tape_epic":
    case "brloot_valuable_bunker_notes_epic":
    case "loot_key_biobunker_fortress_worn":
    case "loot_key_biobunker_fortress":
    case "loot_key_exhume_warehouse":
    case "loot_key_control_tower":
    case "loot_key_post_office_stronghold":
    case "loot_key_police_academy":
    case "loot_key_sira_mall":
    case "loot_key_fort":
    case "loot_key_embassy":
    case "loot_key_civic_center":
    case "loot_key_fortress":
    case "loot_key_mrap":
    case "brloot_self_revive":
    case "loot_key_gold_door":
    case "brloot_backpack_medium":
    case "brloot_plate_carrier_2":
    case "brloot_plate_carrier_3":
    case "brloot_backpack_large":
    case "brloot_plate_carrier_3_medic":
      _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, undefined, 1, _id_452130D9D126E506);
      _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, player, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, _id_25F0D68EE22434EB);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);
      break;
    case "research_upgrade_defense":
    case "research_upgrade_vehicle":
    case "research_upgrade_uav":
    case "vehicle_apc_improved_ammo":
    case "vehicle_defense_tier_2":
    case "vehicle_defense_tier_1":
    case "defense_spawn_plate_tier_2":
    case "defense_spawn_plate_tier_1":
    case "defense_spawn_armor_tier_2":
    case "defense_spawn_armor_tier_1":
    case "deploy_minefield":
    case "ai_jugg":
    case "ai_squad":
    case "uav_ping_global":
    case "uav_ping_duration":
    case "uav_ping_radius":
    case "uav_ping":
    case "ammo_depot":
    case "longer_capture_time":
      _id_59CDCDF44A2FA379 = isDefined(level._id_3CE1055115EDCBBB) && [[level._id_3CE1055115EDCBBB]](player, _id_A365E25AA9D7BCDA.ref);
      break;
    case "skydive_redeploy":
      _id_59CDCDF44A2FA379 = isDefined(level._id_EFBC646224FDA4FA);
      player thread[[level._id_EFBC646224FDA4FA]]();
      break;
    case "risk_turret":
      _id_59CDCDF44A2FA379 = 1;
      player thread scripts\mp\hud_message::showkillstreaksplash("sentry_gun");
      player scripts\mp\killstreaks\killstreaks::awardkillstreak("sentry_gun", "other", undefined, undefined, undefined, 0);
      break;
    case "armor_plate_instant":
      _id_59CDCDF44A2FA379 = _id_07C40FA80892A721::_id_92FEC40B905C5112();
      break;
    case "cranked":
      _id_59CDCDF44A2FA379 = 1;
      player.supportcranked = 1;
      player thread[[level._id_068A1353068460D1]]();
      break;
    case "loot_key_gulag":
      player._id_89BD3A34AC165F4F = 1;
      player _id_0B0385BB45379222::_id_37F6A694B8C6656A();
      break;
    case "life_insurance":
    case "credit_card":
      player _id_7E52B56769FA7774::_id_7CB3C8630787467E(_id_A365E25AA9D7BCDA.ref);
      break;
    default:
      _id_A701C338DC9F8375 = 0;

      if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("kioskHandleSpecialPurchase"))
        [_id_A701C338DC9F8375, _id_59CDCDF44A2FA379, _id_B517DF938986556F, quantity] = player _id_362C58E8BB39BCDA::_id_D72AF9CCEDFC923B("kioskHandleSpecialPurchase", _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554, _id_59CDCDF44A2FA379, _id_B517DF938986556F, quantity);

      if(!_id_A701C338DC9F8375) {}

      break;
  }

  if(_id_59CDCDF44A2FA379) {
    _id_1B4ADA49A21B51CA = undefined;

    if(_id_B517DF938986556F) {
      if(isDefined(_id_A365E25AA9D7BCDA._id_3FE0A24318C4A82D) && _id_A365E25AA9D7BCDA._id_3FE0A24318C4A82D == "MP_INGAME_ONLY/ITEM_TYPE_EQUIPMENT")
        _id_1B4ADA49A21B51CA = "br_equipment_purchased";
      else
        _id_1B4ADA49A21B51CA = "br_item_purchased";
    }

    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "special", _id_1B4ADA49A21B51CA, quantity);
  }

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
    if(isDefined(level._id_8EC1A1CA587A6487))
      player[[level._id_8EC1A1CA587A6487]](_id_A365E25AA9D7BCDA.ref);

    armorykioskused(0, undefined, undefined, self);
  }
}

_id_202BF25CC40D87B4(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  _id_C0F80CCA9C0F5767 = spawnStruct();
  _id_59CDCDF44A2FA379 = 0;
  _id_799D521F485A1701::_id_60D5992F51286201();

  if(_id_799D521F485A1701::_id_59566A4CE3C2C3E2()) {
    _id_C0F80CCA9C0F5767.ref = level.br_pickups._id_14BD11727C4B6629["brloot_offhand_advancedvehicledrop"];

    if(scripts\mp\supers::issuperinuse()) {
      _id_60227BFF1E9478CC = spawnStruct();
      _id_60227BFF1E9478CC.scriptablename = "brloot_offhand_advancedvehicledrop";
      _id_60227BFF1E9478CC.count = 1;
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_offhand_advancedvehicledrop");
      _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC, undefined, undefined, 1);
    } else {
      _id_7E52B56769FA7774::forcegivesuper(_id_C0F80CCA9C0F5767.ref, _id_7DDDAC09987D559E, 1, _id_452130D9D126E506, _id_DB943473454F6EA6);

      if((level.allowsupers || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) && !istrue(_id_452130D9D126E506))
        scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
    }

    _id_59CDCDF44A2FA379 = 1;
  } else {
    _id_C0F80CCA9C0F5767.ref = "veh9_mil_lnd_mrap";
    _id_59CDCDF44A2FA379 = _handlevehiclepurchase(_id_C0F80CCA9C0F5767, _id_7DDDAC09987D559E, 1);

    if(_id_59CDCDF44A2FA379)
      thread _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("truckwar_vehicle_deploying", level.teamdata[self.team]["players"]);
    else
      thread scripts\mp\hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
  }

  return _id_59CDCDF44A2FA379;
}

_handlevehiclepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_5C529B214774F72D) {
  _id_26D956B5A9E59A2E = (1, 1, 1);
  _id_10A5A10C444AEFBB = (1, 0, 0);
  _id_42B28C7586481D92 = (0, 1, 0);
  _id_1EFDCE79E6A210AE = (0, 1, 1);
  _id_C710D54EC720DE16 = 3;
  _id_69ACF5E6CF081BC9 = 8;

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(_id_A365E25AA9D7BCDA.ref, undefined, undefined, "KIOSK"))
    return 0;

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    return 0;

  spawndata = spawnStruct();

  if(isDefined(self.br_kiosk._id_DB32ABF0A18CADF6)) {
    spawndata.origin = self.br_kiosk._id_DB32ABF0A18CADF6.origin;
    spawndata.angles = self.br_kiosk._id_DB32ABF0A18CADF6.angles;
  }

  if(!isDefined(spawndata.origin))
    spawndata.origin = self.br_kiosk.origin + anglesToForward(self.br_kiosk.angles) * 100 + (0, 0, 60);

  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, self.br_kiosk.angles[1] + 90, 0);

  if(istrue(_id_5C529B214774F72D)) {
    spawndata._id_427538F5A2AD4F8B = 1;
    spawndata._id_EC76FFDBE2F37C5B = 1;
    spawndata._id_065DA0A245B653CC = 1;
    spawndata._id_D04816FE2F5BCEE6 = 1;
  }

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, _id_A365E25AA9D7BCDA.ref))
    return 0;

  thread _id_3F45B3C575EC001B(_id_A365E25AA9D7BCDA, spawndata, _id_5C529B214774F72D);
  return 1;
}

_id_3F45B3C575EC001B(_id_A365E25AA9D7BCDA, spawndata, _id_5C529B214774F72D) {
  level endon("game_ended");
  spawndata.spawntype = "KIOSK";

  if(_id_721EE99D7A8F9168::_id_CCDCF48542C8A5B7(_id_A365E25AA9D7BCDA.ref))
    vehicle = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD(_id_A365E25AA9D7BCDA.ref, spawndata);
  else
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_A365E25AA9D7BCDA.ref, spawndata);

  if(istrue(_id_5C529B214774F72D)) {
    _id_799D521F485A1701::_id_020B77FBF1AF1A5D(vehicle, self.team, 1);
    thread _id_799D521F485A1701::_id_C1BFB96A5E39A0A7(vehicle);
    thread _id_799D521F485A1701::_id_2D381B790DC27F9F(vehicle);
    vehicle setscriptablepartstate("tag_buystation", "buystation_usable");
    _id_799D521F485A1701::_id_D5D633C35998EBE7(self.team);
    thread _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("truckwar_vehicle_spawn_enabled", level.teamdata[self.team]["alivePlayers"]);
  }

  if(!isDefined(vehicle)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);

  if(isDefined(self)) {
    _id_D0AE85B60EC1F5F7 = self calloutmarkerping_create(21, (0, 0, 100), vehicle getentitynumber());
    thread _id_9416A673C4E2703E(vehicle, _id_D0AE85B60EC1F5F7);
  }
}

_id_9416A673C4E2703E(vehicle, _id_D0AE85B60EC1F5F7) {
  vehicle endon("death");
  entnumber = vehicle getentitynumber();
  vehicle waittill("vehicle_owner_update");

  if(isDefined(self) && self _meth_B02C8E799779BC10(entnumber))
    self calloutmarkerping_delete(_id_D0AE85B60EC1F5F7);
}

_id_334BEE7871C3AE0F() {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth)
      return 0;

    return 1;
  }

  return 0;
}

_id_A037837DC6C85636() {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    if(isDefined(vehicle._id_FA8480818F379E09) && isDefined(vehicle._id_C1CC7F4FBEBFB815) && vehicle._id_FA8480818F379E09 == vehicle._id_C1CC7F4FBEBFB815)
      return 0;
    else
      return 1;
  }

  return 0;
}

_id_FF0081CA56B5A384(_id_5473A133B9D77893) {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, _id_5473A133B9D77893))
      return 0;
    else
      return 1;
  }

  return 0;
}

_handlevehiclerepair(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E) {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth)
      return 0;

    _id_6D294B74DE0D301E = getdvarfloat("dvar_3C1B0ADF9DA014A0", 0.25);
    _id_E4F8AD64A6E67D4B = int(vehicle.maxhealth * _id_6D294B74DE0D301E);
    vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_653B96CE8310763E(_id_E4F8AD64A6E67D4B);
    playsoundatpos(vehicle.origin + (0, 0, 20), "veh_truckwars_repair");
    _id_799D521F485A1701::_id_35F2FF0427594776(vehicle);

    if(istrue(vehicle._id_4F3E23EE48660F12))
      _id_799D521F485A1701::_id_00E9B1E17B0D0BA3(vehicle);

    players = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(player in players) {
      if(getdvarint("dvar_38D15E2D7DDBF066", 1) == 1)
        player _id_5762AC2F22202BA2::hudicontype("truckheal");

      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);
    }

    return 1;
  }

  return 0;
}

_id_9FC999A4450EACB2(_id_5473A133B9D77893) {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    scripts\cp_mp\vehicles\vehicle_interact::_id_C4B9D8E33849435E(vehicle, _id_5473A133B9D77893, player);
    return 1;
  }

  return 0;
}

_id_0388AA30E37ABBB0(_id_5473A133B9D77893) {
  player = self;
  vehicle = player._id_C77002478CDFD85F;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, _id_5473A133B9D77893))
      return 0;
    else {
      scripts\cp_mp\vehicles\vehicle_interact::_id_C4B9D8E33849435E(vehicle, _id_5473A133B9D77893, player);
      return 1;
    }
  }

  return 0;
}

_id_365E64606D4F3DA8(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  scripts\mp\killstreaks\killstreaks::awardkillstreak(_id_A365E25AA9D7BCDA.ref, "other");
  thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
  armorykioskused(0, undefined, undefined, self);
  return;
}

_id_6C02B611541421D2(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(_id_A365E25AA9D7BCDA.ref);
  scripts\mp\supers::givesuper(_id_A365E25AA9D7BCDA.ref, 1);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");

  if((level.allowsupers || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) && !istrue(_id_452130D9D126E506))
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);

  armorykioskused(0, undefined, undefined, self);
}

_id_F1D968FD69AB759A(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(_id_A365E25AA9D7BCDA.ref);
  scripts\mp\supers::givesuper(_id_A365E25AA9D7BCDA.ref, 1);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");

  if((level.allowsupers || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) && !istrue(_id_452130D9D126E506))
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);

  armorykioskused(0, undefined, undefined, self);
}

_id_157316F7321DD26B(_id_A365E25AA9D7BCDA, _id_A5AB866673E5E99D, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  self endon("disconnect");
  scripts\mp\utility\perk::giveperk(_id_A365E25AA9D7BCDA.ref);
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "perk", _id_A365E25AA9D7BCDA.ref);
  armorykioskused(0, undefined, undefined, self);
  return;
}

_id_9C38FEC481B62D3B(_id_A365E25AA9D7BCDA, _id_A5AB866673E5E99D, _id_1E736A37C3737585, _id_15B89FF206500554, _id_DB943473454F6EA6) {
  self endon("disconnect");

  if(level._id_F38C74334D6FF472 && _id_55E418C5CC946593::_id_C0D385A09D173A36()) {
    _id_59CDCDF44A2FA379 = _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, undefined, 1, _id_1E736A37C3737585);
    _id_59CDCDF44A2FA379 = _id_BDDEDA747A14D679(_id_59CDCDF44A2FA379, _id_15B89FF206500554, self, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0, 1, _id_1E736A37C3737585);
    _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);
    _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "perkpackage");
  }
}

_id_BC5F62F877BE030F(func, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  level endon("game_ended");
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, _id_A365E25AA9D7BCDA.type);

  if(!isalive(self))
    armorykioskused(0, undefined, undefined, self);

  while(!isalive(self))
    waitframe();

  self thread[[func]](_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
}

_id_65C0E46D953F9657(player, loadoutindex, _id_7DDDAC09987D559E) {
  _id_324375F2F392C8EE = scripts\mp\menus::isloadoutindexdefault(loadoutindex);
  _id_A3DB00E9F0A90D88 = undefined;

  if(istrue(_id_324375F2F392C8EE))
    _id_A3DB00E9F0A90D88 = _id_601181692F53E4ED("loadout_default");
  else
    _id_A3DB00E9F0A90D88 = _id_601181692F53E4ED("loadout_custom");

  _id_02502897AE7BFD1E = getdvarint("dvar_B7252F55210DD7E9", 0);

  if(_id_02502897AE7BFD1E != 0)
    _id_A3DB00E9F0A90D88.cost = _id_02502897AE7BFD1E;

  _id_03E487E0C00E4A4C = _getactualcost(player, _id_A3DB00E9F0A90D88);

  if(player.plundercount < _id_03E487E0C00E4A4C)
    player _id_C8BD59CDE912455F(3);
  else {
    _id_2D36749FDFFC49B4 = scripts\mp\menus::getclasschoice(loadoutindex);
    _id_715028F54BAD19A1::branalytics_inventory_snapshot(self, "purchasing_new_loadout");
    _id_4047CB430F29ADA4 = getdvarint("dvar_6D746A5B4ACEE20D", 1);
    player.pers["class"] = _id_2D36749FDFFC49B4;
    player.class = _id_2D36749FDFFC49B4;
    _id_D5601F78A39895FF = player scripts\mp\class::preloadandqueueclass(_id_2D36749FDFFC49B4);
    _id_1E4A61DB11011446::br_giveselectedclass(player, _id_7DDDAC09987D559E, _id_4047CB430F29ADA4);
    _id_A573B91325F9EA32(player, _id_A3DB00E9F0A90D88, "loadout", "br_loadout_purchased");

    if(istrue(_id_324375F2F392C8EE)) {
      _id_715028F54BAD19A1::branalytics_kiosk_purchaseitem(self, _id_03E487E0C00E4A4C, "defaultLoadout", "loadout_" + loadoutindex);
      return;
    }

    _id_715028F54BAD19A1::branalytics_kiosk_purchaseloadout(self, _id_03E487E0C00E4A4C, _id_D5601F78A39895FF);
  }
}

_id_9353E641AB9B0884(weaponref, _id_31553E68A5164E3E) {
  _id_A365E25AA9D7BCDA = spawnStruct();
  _id_A365E25AA9D7BCDA.ref = "loadout_primary";
  _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0 = "loadoutPrimary";
  _id_A365E25AA9D7BCDA.type = "loadout";
  _id_A365E25AA9D7BCDA.cost = _id_3CC8B2630D4F56E7(weaponref, _id_31553E68A5164E3E);
  firesalediscount = level.br_armory_kiosk.weapons._id_E02581D50B48C3F9["firesale_weapon_discount"];

  if(isDefined(firesalediscount))
    _id_A365E25AA9D7BCDA.firesalediscount = int(firesalediscount);
  else
    _id_A365E25AA9D7BCDA.firesalediscount = 0;

  return _id_A365E25AA9D7BCDA;
}

_id_601181692F53E4ED(_id_CB325DDB4A764623) {
  foreach(item in level.br_armory_kiosk.items) {
    if(item.ref == _id_CB325DDB4A764623)
      return item;
  }
}

onarmorykioskpurchase(_id_7148C1A6F25491F8, _id_1657E74C9190D2A2) {
  player = self;
  _id_15B89FF206500554 = player.br_kiosk;

  if(!istrue(player.armorykioskpurchaseallowed) && !istrue(level._id_D804888D9484FF69) && !istrue(level._id_C5DC0E983C929728)) {
    return;
  }
  if(_id_7148C1A6F25491F8 == "exit_loadout_bag")
    _id_1657E74C9190D2A2 = 0;

  _id_6C457C5F341BEB23 = "channel: " + _id_7148C1A6F25491F8;

  if(isDefined(_id_1657E74C9190D2A2))
    _id_6C457C5F341BEB23 = _id_6C457C5F341BEB23 + ", index: " + _id_1657E74C9190D2A2;

  _id_97AA008EFEEDD23C = "standard_kiosk";

  if(isDefined(_id_15B89FF206500554) && isDefined(_id_15B89FF206500554.type) && _id_15B89FF206500554.type == "drone_deployable_kiosk")
    _id_97AA008EFEEDD23C = "deployable_kiosk";

  _id_715028F54BAD19A1::branalytics_kiosk_menu_event(player, "menu_purchase", _id_6C457C5F341BEB23, _id_97AA008EFEEDD23C);
  _id_7DDDAC09987D559E = getdvarint("dvar_D6A60F25EF560A17", 1);
  _id_452130D9D126E506 = getdvarint("dvar_8E3B1991482F0D41", 0);
  _id_295D6F5D7716AFFA = getdvarint("dvar_CE452A7FAEFD9E7D", 1);

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    _id_452130D9D126E506 = 1;

  if(_id_7148C1A6F25491F8 == "br_cancel_purchase" || _id_7148C1A6F25491F8 == "exit_loadout_bag")
    _purchasemenuclosedbyclient(player);
  else if(_id_7148C1A6F25491F8 == "br_item_purchase") {
    _id_3793828403C6873E = _id_1657E74C9190D2A2;
    _id_A365E25AA9D7BCDA = level.br_armory_kiosk.items[_id_3793828403C6873E];
    result = player _validateitempurchase(_id_15B89FF206500554, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_295D6F5D7716AFFA);
    _id_4D1BE4FB3C1A5C4E = result == 1 || result == 2;

    if(_id_4D1BE4FB3C1A5C4E) {
      _id_469CFCBC4A5185C1(_id_15B89FF206500554, _id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0);
      _id_6B3C6B40C0598D85 = _id_B88D64CD67BBE60F(_id_15B89FF206500554);

      if(isDefined(_id_6B3C6B40C0598D85)) {
        foreach(usingplayer in _id_15B89FF206500554.playersusing) {
          if(isDefined(usingplayer))
            usingplayer setclientomnvar("ui_buystation_limited_item_amount", _id_6B3C6B40C0598D85);
        }
      }

      _id_DB943473454F6EA6 = undefined;
      _id_25978461C6E4F61B = _id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(_id_A365E25AA9D7BCDA.ref);

      if(!isDefined(_id_25978461C6E4F61B) || _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_25978461C6E4F61B))
        _id_DB943473454F6EA6 = _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

      if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "killstreak")
        player thread _id_BC5F62F877BE030F(::_id_365E64606D4F3DA8, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super")
        player thread _id_BC5F62F877BE030F(::_id_6C02B611541421D2, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "perk")
        player thread _id_BC5F62F877BE030F(::_id_157316F7321DD26B, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "killstreak")
        player thread _handlekillstreakpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super")
        player _handlefieldupgradepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "weapon")
        player _id_90B0E9EB26E38443(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "perk")
        player _id_157316F7321DD26B(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506);
      else if(_id_A365E25AA9D7BCDA.type == "equipment")
        player _id_B140D6E72B665C8F(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554);
      else if(_id_A365E25AA9D7BCDA.type == "special" || _id_A365E25AA9D7BCDA.type == "persistent")
        player _handlespecialpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554, _id_295D6F5D7716AFFA, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "perkpackage")
        player _id_9C38FEC481B62D3B(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554, _id_DB943473454F6EA6);
    }
  } else if(_id_7148C1A6F25491F8 == "br_loadout_purchase") {
    loadoutindex = _id_1657E74C9190D2A2;

    if(getdvarint("dvar_E10D9168500BD034", 0) == 0) {
      _id_3718B699E7CF7578 = scripts\mp\menus::getclasschoice(loadoutindex);
      classstruct = scripts\mp\class::loadout_getorbuildclassstruct(_id_3718B699E7CF7578);

      if(!isDefined(classstruct.loadoutprimary) || !isDefined(classstruct.loadoutprimaryattachments) || !isDefined(classstruct.loadoutprimaryobject) || !isDefined(classstruct.loadoutprimaryfullname)) {
        player _id_C8BD59CDE912455F(2);
        return;
      }

      _id_7AFE454B9BE1B7E8 = _id_9353E641AB9B0884(classstruct.loadoutprimary, classstruct.loadoutprimaryattachments);
      _id_03E487E0C00E4A4C = _getactualcost(player, _id_7AFE454B9BE1B7E8);

      if(player.plundercount < _id_03E487E0C00E4A4C) {
        player _id_C8BD59CDE912455F(3);
        return;
      }

      if(getdvarint("dvar_4A50D6714D2A1D0C") <= 0)
        _id_2D04108C0A0ED7A5(player, classstruct.loadoutprimaryobject);

      if(_id_724736FCF0FB6604::br_forcegivecustomweapon(player, classstruct.loadoutprimaryobject, classstruct.loadoutprimaryfullname, classstruct.loadoutprimary)) {
        _id_A573B91325F9EA32(player, _id_7AFE454B9BE1B7E8, _id_7AFE454B9BE1B7E8.type);
        _id_715028F54BAD19A1::_id_6039C3FFA983858F(player, _id_03E487E0C00E4A4C, classstruct.loadoutprimary, classstruct.loadoutprimaryattachments);
      }
    } else
      _id_65C0E46D953F9657(player, loadoutindex, _id_7DDDAC09987D559E);
  } else if(_id_7148C1A6F25491F8 == "class_select") {
    loadoutindex = _id_1657E74C9190D2A2;
    _id_65C0E46D953F9657(player, loadoutindex, _id_7DDDAC09987D559E);
  } else if(_id_7148C1A6F25491F8 == "br_team_revive") {
    _id_BF5D82BEFBB59EFE = _id_1657E74C9190D2A2 - 1;
    _id_69FAC551DCF6C2FB = _id_601181692F53E4ED("teamrevive");
    _id_0A120356B021F8E8 = _getactualcost(player, _id_69FAC551DCF6C2FB);
    _id_EB276D34779513E3 = level._id_77E4ADD813FCA6AE && !_id_362C58E8BB39BCDA::isfeaturedisabled("useTokenToReviveTeammate");
    _id_4DFC1F5D7602B10D = istrue(player.hasrespawntoken) && _id_EB276D34779513E3 && player.plundercount < _id_0A120356B021F8E8;

    if(!_id_4DFC1F5D7602B10D && player.plundercount < _id_0A120356B021F8E8) {
      player _id_C8BD59CDE912455F(3);
      return 0;
    }

    if(getdvarint("dvar_ECE0C71AA9D5C939", 0))
      logstring("[ WHY_NO_BUYBACK TEST] buyback from - " + player.name + " for squadmateSquadIndex = " + _id_BF5D82BEFBB59EFE);

    _id_C7869D69DBCF7FD3 = undefined;
    squad = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_8F7040E569EC9E98 in squad) {
      if(!isDefined(_id_8F7040E569EC9E98) || _id_8F7040E569EC9E98 == player) {
        continue;
      }
      if(isDefined(_id_8F7040E569EC9E98._id_3F78C6A0862F9E25) && _id_8F7040E569EC9E98._id_3F78C6A0862F9E25 == _id_BF5D82BEFBB59EFE) {
        if(getdvarint("dvar_ECE0C71AA9D5C939", 0))
          logstring("[ WHY_NO_BUYBACK TEST] buyback player - " + _id_8F7040E569EC9E98.name + ", sessionuimemberindex = " + _id_8F7040E569EC9E98._id_3F78C6A0862F9E25);

        _id_C7869D69DBCF7FD3 = _id_8F7040E569EC9E98;
        break;
      }
    }

    if(!isDefined(_id_C7869D69DBCF7FD3)) {
      player _id_C8BD59CDE912455F(12);
      return;
    }

    if(!_id_C7869D69DBCF7FD3 _id_2CEDCC356F1B9FC8::iseligibleforteamrevive() && !getdvarint("dvar_4D250E4873E1753E", 0)) {
      if(_id_2CEDCC356F1B9FC8::isrespawningfromtoken(_id_C7869D69DBCF7FD3))
        player _id_C8BD59CDE912455F(14);
      else if(scripts\mp\utility\player::isreallyalive(_id_C7869D69DBCF7FD3))
        player _id_C8BD59CDE912455F(15);
      else
        player _id_C8BD59CDE912455F(13);

      return;
    }

    player scripts\mp\utility\stats::incpersstat("kioskRevives", 1);
    _id_C7869D69DBCF7FD3 scripts\mp\utility\stats::incpersstat("revivedFromKiosk", 1);
    _id_A4C6CDA2E74187F2 = 0;

    if(!_id_4DFC1F5D7602B10D) {
      cost = level.br_armory_kiosk.teamrevivecost;
      firesalediscount = level.br_armory_kiosk.teamrevivefiresalediscount;
      _id_A573B91325F9EA32(player, _id_69FAC551DCF6C2FB, "teamrevive");

      if(istrue(player.hasrespawntoken))
        _id_A4C6CDA2E74187F2 = 1;
      else
        player _id_7E52B56769FA7774::addrespawntoken(1);
    } else {
      _id_3A93448A74526680 = spawnStruct();
      _id_3A93448A74526680.cost = 0;
      _id_3A93448A74526680.firesalediscount = 0;
      _id_A573B91325F9EA32(player, _id_3A93448A74526680, "teamrevive");
    }

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("kioskRevivePlayer"))
      _id_C7869D69DBCF7FD3 thread _id_362C58E8BB39BCDA::runbrgametypefunc("kioskRevivePlayer", player, _id_4DFC1F5D7602B10D);
    else
      _id_C7869D69DBCF7FD3 thread _id_67708F418B1FAC79::playergulagautowin("kioskRevivePlayer", player, _id_4DFC1F5D7602B10D);

    if(_id_A4C6CDA2E74187F2)
      player _id_7E52B56769FA7774::addrespawntoken(1);

    _id_BDF786BE066C860B = getDvar("dvar_58D8DFA7B8338078", "");

    if(_id_BDF786BE066C860B != "")
      level thread _id_64ACB6CE534155B7::utilflare_shootflare(_id_15B89FF206500554.origin, _id_BDF786BE066C860B);
    else
      level thread _id_64ACB6CE534155B7::utilflare_shootflare(_id_15B89FF206500554.origin, "revive");

    player thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
  } else if(_id_7148C1A6F25491F8 == "insure_slot") {
    if(!getdvarint("dvar_EBF8A842C7DD2D82", 0)) {
      return;
    }
    if(!isDefined(player._id_06317F2446D7F722))
      player._id_06317F2446D7F722 = [0, 0, 0];

    if(istrue(player._id_06317F2446D7F722[_id_1657E74C9190D2A2])) {
      return;
    }
    _id_CB325DDB4A764623 = _id_FBEA988DA0967DBC(_id_1657E74C9190D2A2);
    _id_A365E25AA9D7BCDA = spawnStruct();
    _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_CB325DDB4A764623);
    _id_A365E25AA9D7BCDA.cost = int(_id_600B944A95C3A7BF::_id_AFA71C22D9DCFDC5(_id_A365E25AA9D7BCDA.lootid));
    _id_A365E25AA9D7BCDA.ref = _id_CB325DDB4A764623;
    _id_A365E25AA9D7BCDA._id_8F0CC1F91F9B12ED = 1;

    if(!isDefined(player.plundercount) || player.plundercount < _id_A365E25AA9D7BCDA.cost) {
      return;
    }
    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "buy_station_insured_slot");
    player._id_06317F2446D7F722[_id_1657E74C9190D2A2] = 1;
  }
}

_id_2D04108C0A0ED7A5(player, _id_8DDCEE7F743EE3A8) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  dropstruct.weaponpickups = [];
  dropstruct.equipprimarypickup = undefined;
  dropstruct._id_DFBA5A2C3C6F0A07 = int(4.0);

  if(getdvarint("dvar_AC8187887A7808AA", 0))
    dropstruct._id_DFBA5A2C3C6F0A07 = dropstruct._id_DFBA5A2C3C6F0A07 + 9;

  foreach(weapon in player.equippedweapons) {
    basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

    if(isweapon(weapon) && weapon.inventorytype == "primary" && issameweapon(weapon, _id_8DDCEE7F743EE3A8)) {
      if(_id_7E52B56769FA7774::shoulddropbrprimary(weapon, player)) {
        _id_EC7DED352736C3B1 = player _id_4ACBD920A4F5A24D::extract_ismissionweapon(weapon);

        if(!_id_EC7DED352736C3B1) {
          _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
          pickupent = _id_724736FCF0FB6604::weaponspawn(weapon, player, _id_CB4FAD49263E20C4, 0, 1);

          if(isDefined(pickupent)) {
            _id_5413C446D646561A = player getweaponammoclip(weapon);
            _id_5F1E64F3E8613C52 = player getweaponammoclip(weapon, "left");
            _id_DAA197E6C4B920EE = 0;

            if(weapon.hasalternate) {
              _id_B6FF735C3690CC44 = weapon getaltweapon();

              if(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_B6FF735C3690CC44) != _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon))
                _id_DAA197E6C4B920EE = player getweaponammoclip(_id_B6FF735C3690CC44);
            }

            _id_7E52B56769FA7774::loot_setitemcount(pickupent, _id_5413C446D646561A, _id_5F1E64F3E8613C52, _id_DAA197E6C4B920EE);
            dropstruct.weaponpickups[dropstruct.weaponpickups.size] = pickupent;
          }
        }
      }

      player scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    }
  }
}

_makekioskpurchase(_id_A365E25AA9D7BCDA) {
  player = self;
  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  cost = _id_A365E25AA9D7BCDA.cost;

  if(!istrue(_id_A365E25AA9D7BCDA._id_8F0CC1F91F9B12ED))
    cost = _getactualcost(player, _id_A365E25AA9D7BCDA);

  if(_id_D47B7F992CA8A91E && _id_A365E25AA9D7BCDA.firesalediscount > 0)
    kioskfiresaledoneforplayer(player.br_kiosk, player);

  if(!_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch())
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6B6AA986D5126ABB", undefined, _id_1E4A61DB11011446::calculatepurchasexp(cost, _id_A365E25AA9D7BCDA.type));

  if(cost > 0)
    player _id_6AFF3948CF4CCA03::playerplunderkioskpurchase(cost);

  if(!isDefined(level.br_plunder))
    level.br_plunder = spawnStruct();

  if(!isDefined(level.br_plunder.kiosk_spent_total))
    level.br_plunder.kiosk_spent_total = 0;

  level.br_plunder.kiosk_spent_total = level.br_plunder.kiosk_spent_total + cost;

  if(!isDefined(level.br_plunder.kiosk_num_purchases))
    level.br_plunder.kiosk_num_purchases = 0;

  level.br_plunder.kiosk_num_purchases++;
  player _id_C8BD59CDE912455F(1);
  return cost;
}

_id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, _id_7E1BFBE3F25F5583, _id_F7B6CC6C062A7A43, quantity) {
  _id_1CB2654B9D2B112A = player _makekioskpurchase(_id_A365E25AA9D7BCDA);

  if(!isDefined(quantity))
    quantity = 1;

  lootid = _id_A365E25AA9D7BCDA.lootid;

  if(!isDefined(lootid) || lootid == 0) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_A365E25AA9D7BCDA.ref);

    if(!isDefined(lootid) || lootid == 0) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_A365E25AA9D7BCDA.ref);

      if(!isDefined(lootid))
        lootid = 0;
    }
  }

  if(isDefined(lootid) && lootid > 0) {
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 0);
    scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, lootid, undefined, _id_3EAA9F644DBE7834, quantity);
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_6A8EC730B2BFA844::_id_7184ABFE5941A710(player, _id_1CB2654B9D2B112A);

  level notify("buy_station_cash_spent_" + player.team, player, _id_1CB2654B9D2B112A);

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk._id_08B199355950FB72))
    _id_6A8EC730B2BFA844::_id_0C2B3319EB135740(player);

  player scripts\cp_mp\challenges::onkioskpurchaseitem(_id_7E1BFBE3F25F5583, _id_A365E25AA9D7BCDA.ref, lootid, quantity, _id_1CB2654B9D2B112A);

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk._id_AC9AFF06FCBD2B98))
    _id_6A8EC730B2BFA844::_id_4F23417A848E2F5F(player);

  if(isDefined(_id_7E1BFBE3F25F5583)) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      _id_715028F54BAD19A1::branalytics_kiosk_purchaseitem(player, _id_1CB2654B9D2B112A, _id_7E1BFBE3F25F5583, _id_A365E25AA9D7BCDA.ref);
    else
      _id_715028F54BAD19A1::branalytics_kiosk_purchaseitem(player, _id_A365E25AA9D7BCDA.cost, _id_7E1BFBE3F25F5583, _id_A365E25AA9D7BCDA.ref);
  }

  if(isDefined(player.br_kiosk) && isDefined(player.br_kiosk.type) && _id_2CEDCC356F1B9FC8::_id_A84A6ACB3C2EDCAE(player.br_kiosk.type)) {
    return;
  }
  if(isDefined(_id_F7B6CC6C062A7A43))
    player thread scripts\mp\hud_message::showsplash(_id_F7B6CC6C062A7A43);
}

playerlocationselectinterrupt() {
  player = self;
  level endon("game_ended");
  self endon("disconnect");
  player endon("confirm_location");
  scripts\engine\utility::waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

playerhandlecirclepickitem() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "playerHandleCirclePickItem");
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  _id_6E586A99FA56A20F = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
    if(_id_2695A20D4011076D::isvalidpointinbounds(_id_6E586A99FA56A20F.location, 1)) {
      _id_9083EA775F3B0CD7 = _id_1E4A61DB11011446::traceselectedmaplocation(_id_6E586A99FA56A20F.location);
      _id_01230EA36A300368 = _id_9083EA775F3B0CD7["position"];

      if(_id_2695A20D4011076D::isvalidpointinbounds(_id_01230EA36A300368, 1)) {
        thread restartcircleelimination(_id_01230EA36A300368);
        success = 1;
      } else
        _id_C8BD59CDE912455F(18);
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "playerHandleCirclePickItem");
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

restartcircleelimination(origin) {
  level endon("game_ended");
  level notify("restartCircleElimination");
  _id_7C409A7D87B3C6B6 = 60;
  _id_5E344CD3618EE701 = 4;
  _id_55A74749A759FC2D = -1;
  _id_4D700B38444FAB26 = 15;
  _id_8F6402AD8E91DA6A = getdvarint("dvar_5EF97113D77C0835", _id_7C409A7D87B3C6B6);
  _id_00836A83C2BCA261 = getdvarint("dvar_341F671CD388B556", _id_5E344CD3618EE701);
  _id_26189638809F7B88 = getdvarint("dvar_B925987ADB7FBD3E", _id_55A74749A759FC2D);
  _id_937DD942E0664F1A = getdvarint("dvar_3C88A1D746D97236", _id_4D700B38444FAB26);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("restartCircleElimination"))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("restartCircleElimination", origin, _id_8F6402AD8E91DA6A);

  foreach(player in level.players)
  player scripts\mp\hud_message::showsplash("br_late_circle_soon");

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("circle")) {
    _id_2695A20D4011076D::initcirclepoststarttocircleindex(origin, _id_8F6402AD8E91DA6A, _id_00836A83C2BCA261, _id_26189638809F7B88);
    level.brgametype.disabledfeatures["circle"] = undefined;
  }

  if(_id_362C58E8BB39BCDA::isfeatureenabled("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  _id_EFCF5EB682EF5688 = max(0, _id_8F6402AD8E91DA6A - _id_937DD942E0664F1A);
  wait(_id_EFCF5EB682EF5688);

  foreach(player in level.players)
  player scripts\mp\hud_message::showsplash("br_late_circle_now");

  _id_AD75DBC17E0FAF18 = _id_8F6402AD8E91DA6A - _id_EFCF5EB682EF5688;
  wait(_id_AD75DBC17E0FAF18);

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate")) {
    level thread _id_6489FCDFE6FA2E36::spectate_init();
    level.brgametype.disabledfeatures["teamSpectate"] = undefined;
  }

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
  }
}

playerhandleredeploy() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "playerHandleRedeploy");
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  _id_6E586A99FA56A20F = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
    if(_id_2695A20D4011076D::isvalidpointinbounds(_id_6E586A99FA56A20F.location, 1)) {
      _id_9083EA775F3B0CD7 = _id_1E4A61DB11011446::traceselectedmaplocation(_id_6E586A99FA56A20F.location);
      _id_01230EA36A300368 = _id_9083EA775F3B0CD7["position"];

      if(_id_2695A20D4011076D::isvalidpointinbounds(_id_01230EA36A300368, 1)) {
        self notify("_watchToAutoCloseMenu_end");
        playerredeploy(_id_01230EA36A300368);
        success = 1;
      } else
        _id_C8BD59CDE912455F(18);
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "playerHandleRedeploy");
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

playerredeploy(groundorigin, _id_F9A785628F97EEC6, _id_27A5B29AAEFC2FB4) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  _id_4630A5DF954561F2 = 12000;
  height = _id_F9A785628F97EEC6;

  if(!isDefined(height))
    height = _id_4630A5DF954561F2;

  yaw = _id_27A5B29AAEFC2FB4;

  if(!isDefined(yaw))
    yaw = 0;

  spawnpoint = spawnStruct();
  spawnpoint.origin = groundorigin + (0, 0, height);
  spawnpoint.angles = (0, yaw, 0);
  spawnpoint.height = height;
  _id_11F3B4465C8B637B = player _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  player.forcespawnorigin = _id_11F3B4465C8B637B;
  _id_B59F471C2C064E56 = 1.0;
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait(_id_B59F471C2C064E56);
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  player _id_5BAB271917698DC4::_id_961B4AFC4C695B94();
  player _id_5BAB271917698DC4::_id_AB31CF673D70F72D(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(player);
  player playerlinktoabsolute(linker, "tag_origin");
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_armory_kiosk::playerRedeploy()");
  player thread _id_5BAB271917698DC4::playercleanupentondisconnect(linker);
  waitframe();
  player _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  player _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(isDefined(_id_11F3B4465C8B637B))
    linker.origin = spawnorigin;

  linker playsoundtoplayer("br_ac130_flyby", player);
  wait 1.5;

  if(!player islinked())
    player _id_5BAB271917698DC4::_id_AB31CF673D70F72D(spawnorigin, spawnangles);

  player unlink();
  player clearsoundsubmix("deaths_door_mp");
  player clearclienttriggeraudiozone(1);
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_armory_kiosk::playerRedeploy()");
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  player.isredeploykeepweapons = 1;
  player thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_show_spectateHud", -1);
  player _id_5BAB271917698DC4::resetplayermovespeedscale();
  wait 0.5;
  player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  waitframe();
  linker delete();
}

_id_8301CE82F0AE1BE6() {
  if(istrue(level.br_circle_disabled))
    return level.br_armory_kiosk.scriptables.size;

  _id_035C1E70B1D29218 = 0;

  foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
    if(_id_2695A20D4011076D::ispointincurrentsafecircle(_id_15B89FF206500554.origin))
      _id_035C1E70B1D29218++;
  }

  return _id_035C1E70B1D29218;
}

_id_0A4078546548CB0A() {
  if(istrue(level.br_armory_kiosk_enabled)) {
    foreach(_id_E4A6D0A55FD775A7 in level.br_armory_kiosk.scriptables) {
      currentstate = _id_E4A6D0A55FD775A7 getscriptablepartstate("br_plunder_box");

      if(currentstate != "disabled" && currentstate != "hidden") {
        if(!scripts\engine\utility::string_starts_with(currentstate, "firesale_")) {
          _id_9B1941CB7354665E = "firesale_" + currentstate;
          _id_E4A6D0A55FD775A7 setscriptablepartstate("br_plunder_box", _id_9B1941CB7354665E);
        }
      }
    }
  }
}

_id_4FECF02C9241F7F0() {
  if(istrue(level.br_armory_kiosk_enabled)) {
    foreach(_id_E4A6D0A55FD775A7 in level.br_armory_kiosk.scriptables) {
      currentstate = _id_E4A6D0A55FD775A7 getscriptablepartstate("br_plunder_box");

      if(scripts\engine\utility::string_starts_with(currentstate, "firesale_")) {
        _id_05558F4A2139C46E = strtok(currentstate, "_");

        if(!isDefined(_id_05558F4A2139C46E) || _id_05558F4A2139C46E.size < 2) {
          continue;
        }
        _id_9B1941CB7354665E = _id_05558F4A2139C46E[_id_05558F4A2139C46E.size - 1];
        _id_E4A6D0A55FD775A7 setscriptablepartstate("br_plunder_box", _id_9B1941CB7354665E);
      }
    }
  }
}

_id_665291FDC0B65758() {
  foreach(_id_15B89FF206500554 in getentitylessscriptablearray("scriptable_br_plunder_box", "classname"))
  _id_15B89FF206500554._id_AFC028D00356E443 = _id_15B89FF206500554.origin + rotatevector((12, 0, 0), _id_15B89FF206500554.angles);
}

_id_FBEA988DA0967DBC(index) {
  switch (index) {
    case 0:
      return "buy_station_insured_slot_1";
    case 1:
      return "buy_station_insured_slot_2";
    case 2:
      return "buy_station_insured_slot_3";
    default:
      return "buy_station_insured_slot_1";
  }

  return "buy_station_insured_slot_1";
}

_id_0233A7ADC7A673BE(_id_15B89FF206500554) {
  _id_15B89FF206500554.locked = 1;
}

_id_3B1235B668CB5C71(_id_15B89FF206500554) {
  _id_15B89FF206500554.locked = 0;
}

_id_EACA292314678F38(_id_4F95D97A13077392, _id_F3BFF22D504C243A, _id_171F90B9C4C76D44) {
  _id_20D8602C22F884FA = [];

  foreach(_id_8B0DFD11A808587B in _id_F3BFF22D504C243A) {
    if(isDefined(_id_8B0DFD11A808587B._id_F38C6C70051ACB18) && istrue(int(_id_8B0DFD11A808587B._id_F38C6C70051ACB18))) {
      _id_2FCAA447C4E7D4A0(_id_8B0DFD11A808587B, _id_4F95D97A13077392);
      _id_4F95D97A13077392++;
      continue;
    }

    _id_20D8602C22F884FA[_id_20D8602C22F884FA.size] = _id_8B0DFD11A808587B;
  }

  if(_id_20D8602C22F884FA.size == 0)
    return _id_4F95D97A13077392;

  _id_FC617751F654A141 = randomintrange(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["minExtraBuyStations"], level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["maxExtraBuyStations"] + 1);
  _id_20D8602C22F884FA = scripts\engine\utility::array_randomize(_id_20D8602C22F884FA);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_20D8602C22F884FA[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    _id_2FCAA447C4E7D4A0(_id_20D8602C22F884FA[_id_AC0E594AC96AA3A8], _id_4F95D97A13077392);
    _id_4F95D97A13077392++;
  }

  return _id_4F95D97A13077392;
}