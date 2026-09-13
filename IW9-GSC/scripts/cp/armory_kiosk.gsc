/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\armory_kiosk.gsc
***********************************************/

init() {
  if(isDefined(level.br_armory_kiosk)) {
    return;
  }
  setDvar("dvar_F8E5C3DAA6C01012", "cp_core");
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint("scr_br_armory_kiosk", 1);
  level._id_011A3973390A71E8 = getDvar("dvar_F8E5C3DAA6C01012", "cp_core");
  level._id_E7CEE4FBB5B46EF2 = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(level._id_011A3973390A71E8);

  if(level.br_armory_kiosk_enabled) {
    scripts\engine\scriptable::scriptable_addusedcallback(::armorykioskused);
    scripts\engine\scriptable::scriptable_addautousecallback(::armorykioskused);
    _id_098B53A7358927D9::_id_9BC69C26770D9533(::onarmorykioskpurchase);
    level._id_D03E6BA38B56B4AB = getdvarint("dvar_E77AB3A32453AE92", 1);
    level._id_E9F7702D839B262C = getdvarint("dvar_0624B1F6964C696D", 180.0);
    level._id_F454C63919420AA9 = getdvarint("dvar_69C62CAE4D7929C9", 10.0);
    level._id_FB60F0244999D528 = getdvarint("dvar_9C3612143E0AD401", 1.0);
    _initsalesdiscount();
    _parsepurchaseitemtables();
    level thread _watchforcircleclosure();
    _id_757C9AC43A532DAC::_id_19F98938B071A88F();

    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances))
      scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_jltv_mg", "KIOSK", 5);
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

_id_AC84B48BB39D674F(_id_15B89FF206500554) {
  if(getdvarint("dvar_B0634929CD39973B", 1) == 0)
    return 0;

  if(!isDefined(_id_15B89FF206500554) || !isDefined(_id_15B89FF206500554.index))
    return 0;

  if(!isDefined(level._id_6BE7B375EC4A629C))
    return 0;

  if(!isDefined(level._id_44235D71492FA1A5))
    level._id_44235D71492FA1A5 = [];

  if(isDefined(level._id_44235D71492FA1A5[_id_15B89FF206500554.index]))
    return 1;

  foreach(_id_EB7139726CC569B5 in level._id_6BE7B375EC4A629C) {
    if(_id_EB7139726CC569B5["index"] == level._id_E7CEE4FBB5B46EF2) {
      level._id_44235D71492FA1A5[_id_15B89FF206500554.index] = [];

      foreach(_id_541FD62B8D9C236D, _id_00CF29BD90372E77 in _id_EB7139726CC569B5["items"])
      level._id_44235D71492FA1A5[_id_15B89FF206500554.index][_id_541FD62B8D9C236D] = _id_00CF29BD90372E77["defaultStock"];

      return 1;
    }
  }

  return 0;
}

_id_6AF40E269AAE683E(_id_15B89FF206500554, _id_CF9D634EF87D898B) {
  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  return level._id_44235D71492FA1A5[_id_15B89FF206500554.index][_id_CF9D634EF87D898B];
}

_id_B88D64CD67BBE60F(_id_15B89FF206500554) {
  if(!_id_AC84B48BB39D674F(_id_15B89FF206500554))
    return undefined;

  _id_353DCD8B6675E407 = 0;
  _id_89FFAB3D9D3C9CDD = 0;

  foreach(_id_E5B48212891E8513 in level._id_44235D71492FA1A5[_id_15B89FF206500554.index]) {
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
  _id_F80AD141CA44A56C = level._id_44235D71492FA1A5[_id_15B89FF206500554.index][_id_CF9D634EF87D898B];

  if(isDefined(_id_F80AD141CA44A56C))
    level._id_44235D71492FA1A5[_id_15B89FF206500554.index][_id_CF9D634EF87D898B] = scripts\engine\utility::ter_op(_id_F80AD141CA44A56C > 0, _id_F80AD141CA44A56C - 1, 0);
}

_id_0D84CDB7463425BA(_id_9023CEA8F03E72D2) {
  _id_EB7139726CC569B5 = [];
  _id_3D329EBB0D03D6DB = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_9023CEA8F03E72D2);
  _id_EB7139726CC569B5["index"] = _id_3D329EBB0D03D6DB;
  _id_EB7139726CC569B5["ref"] = _id_9023CEA8F03E72D2;
  _id_EB7139726CC569B5["items"] = [];
  _id_904EEFA8F06CEECB = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, _id_3D329EBB0D03D6DB);
  _id_C6C26123001B9460 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 3);
  _id_3793828403C6873E = 0;

  for(_id_AC75B489772F26CE = 4 * _id_3793828403C6873E; _id_C6C26123001B9460 != ""; _id_C6C26123001B9460 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", _id_904EEFA8F06CEECB, 3 + _id_AC75B489772F26CE)) {
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

    _id_3793828403C6873E++;
    _id_AC75B489772F26CE = 4 * _id_3793828403C6873E;
  }

  return _id_EB7139726CC569B5;
}

_id_FE176342ED52B44F(_id_CB325DDB4A764623) {
  return int(tablelookup("cp/buyStation/buyStationItems.csv", 1, _id_CB325DDB4A764623, 0));
}

_id_517B8730DDEC7F59(_id_CB325DDB4A764623) {
  return int(tablelookup("cp/buyStation/buyStationItems.csv", 1, _id_CB325DDB4A764623, 4));
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

_parsepurchaseitemtables() {
  if(!isDefined(level._id_6BE7B375EC4A629C))
    level._id_6BE7B375EC4A629C = _id_4D81AE9CB22F4180("dvar_894C0B1C4E700989", level._id_011A3973390A71E8);

  if(!isDefined(level._id_3899105CEEC08FB8))
    level._id_3899105CEEC08FB8 = _id_4D81AE9CB22F4180("dvar_F4138AD8E0DE3AC6");

  level.br_armory_kiosk.items = [];
  table = "cp/buyStation/buyStationItems.csv";
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++) {
    _id_3793828403C6873E = int(tablelookupbyrow(table, _id_CB89110314447B2F, 0));

    if(_id_3793828403C6873E == 51)
      test = 1;

    _id_97642CC850F90CA0 = spawnStruct();
    _id_CB325DDB4A764623 = tablelookupbyrow(table, _id_CB89110314447B2F, 3);
    _id_97642CC850F90CA0._id_2CE272546E3AE7F0 = tablelookupbyrow(table, _id_CB89110314447B2F, 1);
    _id_97642CC850F90CA0.type = tablelookupbyrow(table, _id_CB89110314447B2F, 2);
    _id_97642CC850F90CA0.ref = _id_CB325DDB4A764623;
    _id_97642CC850F90CA0.cost = int(tablelookupbyrow(table, _id_CB89110314447B2F, 4));
    _id_97642CC850F90CA0.firesalediscount = int(tablelookupbyrow(table, _id_CB89110314447B2F, 10));
    level.br_armory_kiosk.items[_id_3793828403C6873E] = _id_97642CC850F90CA0;
  }
}

_id_D1687E85988049BB(_id_CB325DDB4A764623, _id_C95404CD83F761B6) {
  foreach(_id_EB7139726CC569B5 in _id_C95404CD83F761B6) {
    if(_id_EB7139726CC569B5["index"] == level._id_E7CEE4FBB5B46EF2) {
      if(isDefined(_id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]) && _id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]["cost"] > 0)
        return _id_EB7139726CC569B5["items"][_id_CB325DDB4A764623]["cost"];
      else
        return undefined;
    }
  }
}

_id_D0E1AFE1BD3614DF(_id_CB325DDB4A764623) {
  cost = _id_D1687E85988049BB(_id_CB325DDB4A764623, level._id_6BE7B375EC4A629C);

  if(!isDefined(cost) && isDefined(level._id_3899105CEEC08FB8))
    cost = _id_D1687E85988049BB(_id_CB325DDB4A764623, level._id_3899105CEEC08FB8);

  return cost;
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

  if(isDefined(level._id_2AD8917B23C8C1D2))
    return [[level._id_2AD8917B23C8C1D2]](_id_150663DEF4F4145A, _id_A365E25AA9D7BCDA);

  if(_id_D47B7F992CA8A91E)
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
        player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_kiosks_disabled");
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
    player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_sales_event_all");
  else
    player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_sales_event_selective");
}

_id_8807282A387BB5B4() {
  return 1;
}

_id_F29B0D39F0DA104D() {
  if(!_id_8807282A387BB5B4()) {
    return;
  }
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables)
  _id_EF7118F0EF2196B5(_id_CF635E78F21650CA);
}

_id_EF7118F0EF2196B5(_id_CF635E78F21650CA) {
  _id_CF635E78F21650CA._id_60B371EBA77D2372 = scripts\cp\cp_objectives::requestworldid("kiosk_objective", 15);
  objective_setshowdistance(_id_CF635E78F21650CA._id_60B371EBA77D2372, 1);
  objective_state(_id_CF635E78F21650CA._id_60B371EBA77D2372, "current");
  objective_icon(_id_CF635E78F21650CA._id_60B371EBA77D2372, "ui_mobile_buystation_visual_marker");
  objective_setbackground(_id_CF635E78F21650CA._id_60B371EBA77D2372, 1);
  objective_position(_id_CF635E78F21650CA._id_60B371EBA77D2372, _id_CF635E78F21650CA.origin + (0, 0, 40));
  objective_setplayintro(_id_CF635E78F21650CA._id_60B371EBA77D2372, 1);
  objective_setlabel(_id_CF635E78F21650CA._id_60B371EBA77D2372, &"CP_MISSION_DEFENDER/SUPPLIES_ICON");
  objective_setownerteam(_id_CF635E78F21650CA._id_60B371EBA77D2372, "allies");
  _id_CF635E78F21650CA thread _id_AC44CA4A1F1D7561();
}

_id_AC44CA4A1F1D7561() {
  level endon("game_ended");
  self endon("death");
  waittime = 4;

  if(isDefined(level._id_4B12176117D66EBB))
    waittime = level._id_4B12176117D66EBB;

  for(;;) {
    level waittill("kiosks_pulsate_objectives");
    objective_setpulsate(self._id_60B371EBA77D2372, 1);
    wait(waittime);
    objective_setpulsate(self._id_60B371EBA77D2372, 0);
  }
}

onprematchdone() {
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "visible");
    _id_CF635E78F21650CA.visible = 1;
  }

  _id_F29B0D39F0DA104D();
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("kiosk") || getdvarint("dvar_AC54858B3FD07DAF", 0) == 1) {
    return;
  }
  _id_8FA87D2C8780E014 = _id_E86632D645C137D0 * _id_E86632D645C137D0;

  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_CF635E78F21650CA.visible) && distance2dsquared(_id_CF635E78F21650CA.origin, _id_819EDACDACB810E4) > _id_8FA87D2C8780E014)
      disablearmorykiosk(_id_CF635E78F21650CA);
  }
}

_id_1A1709943670772A() {
  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("kiosk") || getdvarint("dvar_AC54858B3FD07DAF", 0) == 1) {
    return;
  }
  _id_31966DAE052C3D71 = [];

  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_CF635E78F21650CA.visible)) {
      _id_31966DAE052C3D71[_id_31966DAE052C3D71.size] = _id_CF635E78F21650CA;
      disablearmorykiosk(_id_CF635E78F21650CA);
    }
  }

  return _id_31966DAE052C3D71;
}

disableallarmorykiosks() {
  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("kiosk")) {
    return;
  }
  foreach(_id_CF635E78F21650CA in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_CF635E78F21650CA.visible))
      disablearmorykiosk(_id_CF635E78F21650CA);
  }
}

disablearmorykiosk(_id_CF635E78F21650CA) {
  _id_CF635E78F21650CA setscriptablepartstate("br_plunder_box", "disabled");
  _id_CF635E78F21650CA.visible = undefined;
  _id_CF635E78F21650CA.disabled = 1;

  if(_id_CF635E78F21650CA _id_098B53A7358927D9::checkforactiveobjicon())
    _id_CF635E78F21650CA _id_098B53A7358927D9::deletequestobjicon();
}

getallspawninstances() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }
  _id_1EB07A39FF244CD5 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  return _id_1EB07A39FF244CD5;
}

setspawninstances(instances) {
  level.br_armory_kiosk.scriptables = instances;
}

_id_3058B3E95A1BF984(instance, player) {
  if(istrue(level.gameended))
    return 0;

  if((!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) && !scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(player _id_098B53A7358927D9::_id_25FB9A3B7EE98D69("playerSkipKioskUse", instance)))
    return 0;

  if(istrue(player.iscarrying)) {
    player _id_098B53A7358927D9::_id_CED51005E26102FA("MP/CANNOT_USE_GENERIC");
    return 0;
  }

  return 1;
}

armorykioskused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!_id_098B53A7358927D9::_id_BE79DBA5F7B2A51B(instance.type)) {
    return;
  }
  if(istrue(_id_A5B2C541413AA895) && !_id_7E0281196D6407C8()) {
    return;
  }
  if(!isDefined(player))
    player = self;

  if(istrue(_id_A5B2C541413AA895) && !isDefined(player.armorykioskpurchaseallowed))
    player.armorykioskpurchaseallowed = 0;

  if(!_id_3058B3E95A1BF984(instance, player)) {
    if(istrue(_id_A5B2C541413AA895))
      player.armorykioskpurchaseallowed = 0;
  } else if(istrue(_id_A5B2C541413AA895)) {
    if(!player.armorykioskpurchaseallowed)
      _id_28D837F720B03BFA(instance, player);
  } else {
    if(istrue(player.insertingarmorplate))
      player notify("try_armor_cancel", "armory_kiosk_used");

    if(!isDefined(state))
      player thread _runpurchasemenu(instance);
    else {
      if(state == "visible") {
        if(isDefined(instance)) {
          instance setscriptablepartstate("br_plunder_box", "opening");
          instance thread kioskfixupproneplayers();
        }

        player thread _runpurchasemenu(instance);
        return;
      }

      if(state == "opening" || state == "open")
        player thread _runpurchasemenu(instance);
    }
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

kiosksetupfiresaleforplayer(_id_15B89FF206500554, player) {
  if(!isDefined(_id_15B89FF206500554.firesaleforplayers))
    _id_15B89FF206500554.firesaleforplayers = [player];
  else if(!scripts\engine\utility::array_contains(_id_15B89FF206500554.firesaleforplayers, player))
    _id_15B89FF206500554.firesaleforplayers = scripts\engine\utility::array_add(_id_15B89FF206500554.firesaleforplayers, player);

  if(!_id_15B89FF206500554 _id_098B53A7358927D9::checkforactiveobjicon())
    _id_15B89FF206500554 _id_098B53A7358927D9::_id_F4C2D922E3610D74("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", _id_15B89FF206500554.origin);

  _id_15B89FF206500554 _id_098B53A7358927D9::_id_46F7AD16E39B4E0D(player);
}

_id_D7F25B3C73157F5C() {
  if(_id_098B53A7358927D9::_id_2F0D084017095D28(2))
    return 1;

  return 0;
}

iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player) {
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && (!isDefined(_id_15B89FF206500554) || isint(_id_15B89FF206500554)))
    _id_15B89FF206500554 = player;

  if(_id_D7F25B3C73157F5C())
    return 1;

  if(!isDefined(_id_15B89FF206500554.firesaleforplayers))
    return 0;

  return scripts\engine\utility::array_contains(_id_15B89FF206500554.firesaleforplayers, player);
}

kioskfiresaledoneforplayer(_id_15B89FF206500554, player) {
  if(!isDefined(_id_15B89FF206500554.firesaleforplayers)) {
    return;
  }
  _id_15B89FF206500554 _id_098B53A7358927D9::_id_0601B78B411B7479(player);
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

_runpurchasemenu(_id_15B89FF206500554) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player.br_kiosk = _id_15B89FF206500554;

  if(_id_098B53A7358927D9::_id_1A0BFFD69502C210())
    player notify("kiosk_used");

  if(isDefined(level._id_6BEFF7B631AB7E18))
    [[level._id_6BEFF7B631AB7E18]](_id_15B89FF206500554, player);

  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(_id_15B89FF206500554, player);

  if(!isint(_id_15B89FF206500554) && isDefined(_id_15B89FF206500554._id_7940DCDE72827AF7)) {
    level._id_E7CEE4FBB5B46EF2 = _id_15B89FF206500554._id_7940DCDE72827AF7;
    player setclientomnvar("ui_buystation_override", _id_15B89FF206500554._id_7940DCDE72827AF7);

    if(isDefined(_id_15B89FF206500554._id_DED92CCB217BBAEB))
      player setclientomnvar("ui_weapon_buystation_override", _id_15B89FF206500554._id_DED92CCB217BBAEB);
  } else if(isDefined(level._id_4B3D0771DF2C44A9) && !istrue(player._id_E5B7A6A0EC2B440E)) {
    level._id_E7CEE4FBB5B46EF2 = level._id_4B3D0771DF2C44A9;
    player setclientomnvar("ui_buystation_override", level._id_4B3D0771DF2C44A9);
  }

  player setclientomnvar("ui_buystation_purchase_response", 0);
  _id_254F655D3A722A22 = 2;

  if(_id_D47B7F992CA8A91E)
    _id_254F655D3A722A22 = _id_254F655D3A722A22 + 4;

  player setclientomnvar("ui_buystation_open", _id_254F655D3A722A22);
  player.armorykioskpurchaseallowed = 1;
  _id_098B53A7358927D9::_id_E667D74ECC894CEB(player, "menu_open");
  player thread _watchtoautoclosemenu(_id_15B89FF206500554);

  if(getdvarint("dvar_B4FF8C1463B8BC79", 1))
    player setsoundsubmix("iw8_br_plunder_kiosk_menu");
}

_id_28D837F720B03BFA(_id_15B89FF206500554, player) {
  player.br_kiosk = _id_15B89FF206500554;
  player.armorykioskpurchaseallowed = 1;
  player thread _id_00AB62CD6135DFE6(_id_15B89FF206500554);
}

_id_5221F0C9BDEA6589() {
  player = self;
  player.br_kiosk = undefined;
  player._id_E5B7A6A0EC2B440E = undefined;
  player._id_C77002478CDFD85F = undefined;
  player.armorykioskpurchaseallowed = undefined;
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

_closepurchasemenuwithresponse(_id_97AA74C2193A9DC6) {
  player = self;

  if(_id_97AA74C2193A9DC6 == 1 && getdvarint("dvar_ED6E4FFA933AF621", 0)) {
    return;
  }
  player setclientomnvar("ui_buystation_purchase_response", _id_97AA74C2193A9DC6);
  player setclientomnvar("ui_buystation_open", 1);
  player clearsoundsubmix("iw8_br_plunder_kiosk_menu");
  scripts\cp_mp\vehicles\vehicle_interact::_id_FED77CD5C54EFE19(player._id_C77002478CDFD85F, player);
  player.br_kiosk = undefined;
  player._id_E5B7A6A0EC2B440E = undefined;
  player._id_C77002478CDFD85F = undefined;
  player.armorykioskpurchaseallowed = undefined;
  _id_098B53A7358927D9::_id_E667D74ECC894CEB(player, "menu_close", "reason: " + _id_97AA74C2193A9DC6);
}

_purchasemenuclosedbyclient(player) {
  player _closepurchasemenuwithresponse(0);
  player notify("_watchToAutoCloseMenu_end");
}

_watchtoautoclosemenu(_id_15B89FF206500554) {
  player = self;
  player endon("disconnect");
  player notify("_watchToAutoCloseMenu_end");
  player endon("_watchToAutoCloseMenu_end");
  player childthread _proximitywatcher(_id_15B89FF206500554);
  scripts\engine\utility::waittill_any_ents(player, "death", player, "last_stand_start", player, "pushed_too_far", level, "game_ended");
  player _closepurchasemenuwithresponse(2);
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

  ammo = player _id_7EF95BBA57DC4B82::getequipmentammo(equipmentref);
  ammomax = player _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipmentref);
  return max(0, ammomax - ammo);
}

_maxoutequipmentammo(equipmentref) {
  player = self;

  if(!isDefined(equipmentref))
    return 0;

  ammo = player _id_7EF95BBA57DC4B82::getequipmentammo(equipmentref);
  ammomax = player _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipmentref);

  if(ammo < ammomax)
    player _id_7EF95BBA57DC4B82::setequipmentammo(equipmentref, ammomax);
}

_id_8C8F1E3F153A6FA3() {}

_findgivearmoramountanddropleftovers(_id_7F437A5779C8787C, _id_2737CAC9EE8F6098) {
  player = self;
  _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
  _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

  if(getdvarint("dvar_AD67CF67992FE5F2", 0))
    _id_CF60CDC4E2F0E3D0 = 2;
  else
    _id_CF60CDC4E2F0E3D0 = 5;

  _id_BF203CE62DD1C99C = int(max(min(_id_CF60CDC4E2F0E3D0, _id_A81ADEB0E1F89320 - _id_1CD29382D1867470), 0));
  _id_2FB86E1C9B4C6464 = _id_CF60CDC4E2F0E3D0 - _id_BF203CE62DD1C99C;

  if(_id_098B53A7358927D9::_id_83E3B506365BAFC5()) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = "brloot_armor_plate";
    _id_60227BFF1E9478CC.count = _id_2FB86E1C9B4C6464;
    _id_F94E260AC3C6121E = player _id_098B53A7358927D9::_id_EF240AA7C1052D13(lootid, _id_60227BFF1E9478CC, 1);

    if(_id_F94E260AC3C6121E > 0 && !istrue(_id_2737CAC9EE8F6098)) {
      _id_96C7526F4AB04875 = undefined;

      if(_id_7F437A5779C8787C && isDefined(player.br_kiosk))
        _id_96C7526F4AB04875 = distance2d(player.origin, player.br_kiosk.origin) / 2;

      _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, player.origin, player.angles, player, undefined, _id_96C7526F4AB04875);
      _id_098B53A7358927D9::_id_09D6D4C76ABC82CF("brloot_armor_plate", _id_CB4FAD49263E20C4, _id_F94E260AC3C6121E, 1);
    }
  } else if(_id_2FB86E1C9B4C6464 > 0 && !istrue(_id_2737CAC9EE8F6098)) {
    _id_AD49A38DD7C4C10F = undefined;

    if(istrue(_id_7F437A5779C8787C))
      _id_AD49A38DD7C4C10F = getkioskyawoffsetoverride();

    _id_CB4FAD49263E20C4 = _id_098B53A7358927D9::_id_BB87CFAE1E28E70B(0, player.origin, player.angles, player, _id_AD49A38DD7C4C10F);
    _id_098B53A7358927D9::_id_09D6D4C76ABC82CF("brloot_armor_plate", _id_CB4FAD49263E20C4, _id_2FB86E1C9B4C6464, 1);
  }

  return _id_BF203CE62DD1C99C;
}

_validateitempurchase(_id_A365E25AA9D7BCDA, _id_6DC0E605ECD21EEE, _id_07C3865DEE4ABED6) {
  player = self;
  _id_FBD5FADA61AE8341 = _getactualcost(player, _id_A365E25AA9D7BCDA);

  if(!isDefined(player.plundercount))
    player.plundercount = 0;

  if(player.plundercount < _id_FBD5FADA61AE8341) {
    player _closepurchasemenuwithresponse(3);
    return 0;
  }

  if(isDefined(level._id_5771FC79979CCC58))
    return [[level._id_5771FC79979CCC58]](_id_A365E25AA9D7BCDA, _id_6DC0E605ECD21EEE, _id_07C3865DEE4ABED6, _id_FBD5FADA61AE8341);

  if(_id_A365E25AA9D7BCDA.type == "killstreak") {
    if(!istrue(_id_6DC0E605ECD21EEE)) {
      if(player _id_098B53A7358927D9::_id_77986DB57958B676(_id_A365E25AA9D7BCDA.ref)) {
        player _closepurchasemenuwithresponse(4);
        return 0;
      }
    }
  } else if(_id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super") {
    if(player _id_098B53A7358927D9::_id_3F422A1C87BD2809()) {
      player _closepurchasemenuwithresponse(6);
      return 0;
    }

    if(!istrue(_id_6DC0E605ECD21EEE)) {
      _id_75630A54FF140EC2 = player _id_098B53A7358927D9::_id_97FAC14206681B1F();

      if(isDefined(_id_75630A54FF140EC2) && _id_A365E25AA9D7BCDA.ref == _id_75630A54FF140EC2) {
        player _closepurchasemenuwithresponse(5);
        return 0;
      }
    }
  } else if(_id_A365E25AA9D7BCDA.type == "perk") {
    if(player _id_098B53A7358927D9::_id_87072B42853A9C58(_id_A365E25AA9D7BCDA.ref)) {
      player _closepurchasemenuwithresponse(5);
      return 0;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "special") {
    switch (_id_A365E25AA9D7BCDA.ref) {
      case "armor_bundle":
      case "armor":
        if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
          _id_6A8B46E184E181CC = spawnStruct();
          _id_6A8B46E184E181CC.scriptablename = "brloot_armor_plate";

          if(_id_A365E25AA9D7BCDA.ref == "armor_bundle")
            _id_6A8B46E184E181CC.count = 5;
          else
            _id_6A8B46E184E181CC.count = 1;

          _id_DC297349765E2088 = _id_098B53A7358927D9::_id_76AE39F27ED53321(_id_6A8B46E184E181CC);

          if(_id_DC297349765E2088 != 1) {
            player _closepurchasemenuwithresponse(7);
            return 0;
          }
        }

        break;
      case "armor_plate_instant":
        _id_1F158CCAA5D9C0BE = _id_07C40FA80892A721::_id_92FEC40B905C5112();

        if(!_id_1F158CCAA5D9C0BE) {
          player _closepurchasemenuwithresponse(7);
          return 0;
        }

        break;
      case "gas_mask":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = "brloot_equip_gasmask";
        _id_DC297349765E2088 = _id_098B53A7358927D9::_id_76AE39F27ED53321(_id_6A8B46E184E181CC);
        break;
      case "gas_mask_mobile":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = "brloot_equip_gasmask";
        _id_DC297349765E2088 = _id_098B53A7358927D9::_id_76AE39F27ED53321(_id_6A8B46E184E181CC);
        break;
      case "ammo_refill":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        _id_B1DB5698237FE274 = 0;

        if(player _getequipmentammotomax(player.equipment["primary"]) > 0)
          _id_B1DB5698237FE274 = 1;
        else if(player _getequipmentammotomax(player.equipment["secondary"]) > 0)
          _id_B1DB5698237FE274 = 1;
        else if(!player _id_098B53A7358927D9::_id_ECEEA793E05658BD())
          _id_B1DB5698237FE274 = 1;

        if(!_id_B1DB5698237FE274) {
          player _closepurchasemenuwithresponse(8);
          return 0;
        }

        break;
      case "respawn_token":
        if(_id_098B53A7358927D9::_id_F41FE8DC1D31D5BF()) {
          player _closepurchasemenuwithresponse(9);
          return 0;
        }

        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        if(istrue(player.hasrespawntoken)) {
          player _closepurchasemenuwithresponse(10);
          return 0;
        }

        break;
      case "self_revive_token_mobile":
      case "self_revive_token":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        if(player _id_098B53A7358927D9::_id_C8DFC3FECEEB2896()) {
          player _closepurchasemenuwithresponse(10);
          return 0;
        }

        break;
      case "supply_drop":
        if(istrue(_id_07C3865DEE4ABED6))
          return 1;

        _id_6A8B46E184E181CC = spawnStruct();
        _id_6A8B46E184E181CC.scriptablename = "brloot_offhand_advancedsupplydrop";
        _id_6A8B46E184E181CC.count = 1;
        _id_DC297349765E2088 = _id_098B53A7358927D9::_id_76AE39F27ED53321(_id_6A8B46E184E181CC);

        if(_id_DC297349765E2088 != 1) {
          player _closepurchasemenuwithresponse(7);
          return 0;
        }

        break;
      case "circle_pick":
        if(isDefined(level.br_circle)) {
          player _closepurchasemenuwithresponse(17);
          return 0;
        }

        break;
      case "redeploy":
        if(isDefined(level.br_circle) || istrue(level.brgametype.circlerunning)) {
          player _closepurchasemenuwithresponse(9);
          return 0;
        }

        break;
      case "vehicle_repair":
        if(!player _id_334BEE7871C3AE0F()) {
          player _closepurchasemenuwithresponse(21);
          return 0;
        }

        break;
      case "vehicle_upgrade_armor":
        if(!player _id_FF0081CA56B5A384("armor")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case "vehicle_refill_trophy":
        if(!player _id_A037837DC6C85636()) {
          player _closepurchasemenuwithresponse(19);
          return 0;
        }

        break;
      case "vehicle_upgrade_trophy":
        if(!player _id_FF0081CA56B5A384("trophy")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case "vehicle_upgrade_uav":
        if(!player _id_FF0081CA56B5A384("uav")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case "vehicle_upgrade_barrel":
        if(!player _id_FF0081CA56B5A384("barrel")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case "vehicle_replace":
        if(player _id_6E4F7E117D4651C3()) {
          player _closepurchasemenuwithresponse(23);
          return 0;
        }

        if(!player _id_D48C5142F8271C18()) {
          player _closepurchasemenuwithresponse(22);
          return 0;
        }

        break;
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
      case "longer_capture_time":
      case "ammo_depot":
      case "uav_ping":
        objective = undefined;

        if(isDefined(level._id_D23C7C1ADD9FB181))
          objective = player[[level._id_D23C7C1ADD9FB181]]();

        if(isDefined(objective) && isDefined(level._id_4DE8052758F986F3) && [[level._id_4DE8052758F986F3]](objective.objectivekey, player.team, _id_A365E25AA9D7BCDA.ref)) {
          player _closepurchasemenuwithresponse(17);
          return 0;
        }

        break;
      case "cp_sentry":
      case "risk_turret":
      case "skydive_redeploy":
        break;
      case "armor_plate":
        break;
      case "research_upgrade_defense":
      case "research_upgrade_vehicle":
      case "research_upgrade_uav":
        break;
      case "armoredtruck":
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
    player _id_098B53A7358927D9::_id_DA31E13C27A6ACF4(_id_A365E25AA9D7BCDA.ref, _id_A5AB866673E5E99D, 1, _id_1E736A37C3737585, _id_DB943473454F6EA6);
    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "killstreak", "br_killstreak_purchased");
  } else {
    if(_killstreakneedslocationselection(_id_A365E25AA9D7BCDA.ref)) {
      _id_6EB64F3FEA3BBE81 = player.br_kiosk;
      player _closepurchasemenuwithresponse(16);
      player scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
      player beginlocationselection(0, 0, "circle_marker", 0, 4);
      player childthread _locationselectioninterrupt();
      _id_6E586A99FA56A20F = player _id_098B53A7358927D9::_id_88CAFEC24778C70C("confirm_location", "cancel_location");
      player endlocationselection();
      player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");

      if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
        _id_9083EA775F3B0CD7 = _id_098B53A7358927D9::_id_5C8AD6E89A9F7B73(_id_6E586A99FA56A20F.location);
        player.kstargetlocation = _id_9083EA775F3B0CD7["position"];
        _id_E4AECB271D56914B = player _id_098B53A7358927D9::_id_25C4C34D6C3DD08A(_id_A365E25AA9D7BCDA.ref);

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

    player _id_098B53A7358927D9::_id_DA31E13C27A6ACF4(_id_A365E25AA9D7BCDA.ref, _id_A5AB866673E5E99D, 1, _id_DB943473454F6EA6);
    _id_E4AECB271D56914B = player _id_098B53A7358927D9::_id_25C4C34D6C3DD08A(_id_A365E25AA9D7BCDA.ref);

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
  [ammo, _id_04F04B15053655BA, _id_35EAD47ED0D7507E] = _id_098B53A7358927D9::_id_CFB85293F9660751(level.br_lootiteminfo[scriptablename].fullweaponobj);
  _id_BADA25504E8844D7.count = ammo * 3;
  _id_BADA25504E8844D7.countlefthand = _id_04F04B15053655BA;
  _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_35EAD47ED0D7507E;
  _id_098B53A7358927D9::_id_6E3DB23952F2E451(_id_BADA25504E8844D7);
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "weapon");
}

_handlefieldupgradepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  _id_098B53A7358927D9::_id_EB96721D13C5F3DF(_id_A365E25AA9D7BCDA.ref, _id_7DDDAC09987D559E, 1, _id_452130D9D126E506, _id_DB943473454F6EA6);
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "fieldUpgrade", "br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(_id_452130D9D126E506))
    _id_098B53A7358927D9::_id_74EFAA97EBFEC5DF(_id_098B53A7358927D9::_id_19DD797E5D48D987(), undefined, undefined, undefined, 1);
}

_handlespecialpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554) {
  player = self;
  _id_59CDCDF44A2FA379 = 1;
  _id_B517DF938986556F = 1;
  _id_3E048EF43950BBD7 = undefined;
  quantity = 1;

  switch (_id_A365E25AA9D7BCDA.ref) {
    case "armor":
      _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_armor_plate", 1, undefined, 1, _id_452130D9D126E506);

      if(!_id_59CDCDF44A2FA379) {
        _id_CB4FAD49263E20C4 = _id_098B53A7358927D9::_id_BB87CFAE1E28E70B(0, _id_15B89FF206500554.origin, _id_15B89FF206500554.angles, player);
        pickupent = _id_098B53A7358927D9::_id_09D6D4C76ABC82CF("brloot_armor_plate", _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
        _id_59CDCDF44A2FA379 = 1;
      }

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
      break;
    case "armor_bundle":
      _id_2B83F7CF5DD2CF23 = player _findgivearmoramountanddropleftovers(1);

      if(_id_2B83F7CF5DD2CF23 <= 0)
        _id_59CDCDF44A2FA379 = 1;
      else
        _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_armor_plate", 1, _id_2B83F7CF5DD2CF23, 1, _id_452130D9D126E506);

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
      quantity = _id_2B83F7CF5DD2CF23;
      break;
    case "gas_mask":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask";
      _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, _id_1680A35FE50DC05E, 1, undefined, 1, _id_452130D9D126E506);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_1680A35FE50DC05E);
      break;
    case "gas_mask_mobile":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask";
      _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, _id_1680A35FE50DC05E, 1, undefined, 1, _id_452130D9D126E506);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_1680A35FE50DC05E);
      break;
    case "ammo_refill":
      player _id_098B53A7358927D9::_id_836C7D119E02D1D5();
      player _maxoutequipmentammo(player.equipment["primary"]);
      player _maxoutequipmentammo(player.equipment["secondary"]);
      break;
    case "respawn_token":
      player _id_098B53A7358927D9::_id_C00F90A28C41FEBE();
      _id_B517DF938986556F = 0;
      break;
    case "self_revive_token":
      _id_5DB3E79EF6900447 = "brloot_self_revive";

      if(istrue(_id_452130D9D126E506))
        _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
      else
        player _id_098B53A7358927D9::_id_2D5A30D6FE54567B();

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_5DB3E79EF6900447);
      _id_B517DF938986556F = 0;
      break;
    case "self_revive_token_mobile":
      _id_5DB3E79EF6900447 = "brloot_self_revive";

      if(istrue(_id_452130D9D126E506))
        _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, _id_5DB3E79EF6900447, 1, undefined, 1, _id_452130D9D126E506);
      else
        player _id_098B53A7358927D9::_id_2D5A30D6FE54567B();

      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_5DB3E79EF6900447);
      _id_B517DF938986556F = 0;
      break;
    case "supply_drop":
      _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, _id_452130D9D126E506);
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
      break;
    case "vehicle_refill_trophy":
      _id_59CDCDF44A2FA379 = player _id_9FC999A4450EACB2("trophy");
      break;
    case "vehicle_upgrade_trophy":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("trophy");
      break;
    case "vehicle_upgrade_uav":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("uav");
      break;
    case "vehicle_upgrade_barrel":
      _id_59CDCDF44A2FA379 = player _id_0388AA30E37ABBB0("barrel");
      break;
    case "vehicle_replace":
      _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_offhand_advancedvehicledrop", 1, undefined, 1, _id_452130D9D126E506);
      _id_A365E25AA9D7BCDA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_offhand_advancedvehicledrop");
      break;
    case "veh9_jltv_mg":
      _id_59CDCDF44A2FA379 = player _handlevehiclepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E);

      if(_id_59CDCDF44A2FA379)
        player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_vehicle_purchased");
      else
        player _id_098B53A7358927D9::_id_CED51005E26102FA("MP/VEHICLE_PURCHASE_FAILED");

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
    case "longer_capture_time":
    case "ammo_depot":
    case "uav_ping":
      _id_59CDCDF44A2FA379 = isDefined(level._id_3CE1055115EDCBBB) && [[level._id_3CE1055115EDCBBB]](player, _id_A365E25AA9D7BCDA.ref);
      break;
    case "skydive_redeploy":
      _id_59CDCDF44A2FA379 = isDefined(level._id_EFBC646224FDA4FA);
      player thread[[level._id_EFBC646224FDA4FA]]();
      break;
    case "cp_sentry":
    case "risk_turret":
      _id_59CDCDF44A2FA379 = 1;
      player thread _id_098B53A7358927D9::_id_F5E58B5375381386("sentry_gun");
      player _id_098B53A7358927D9::_id_0F87529D7AF4978B("sentry_gun", "other", undefined, undefined, undefined, 0);
      break;
    case "armor_plate_instant":
      _id_59CDCDF44A2FA379 = _id_07C40FA80892A721::_id_92FEC40B905C5112();
      break;
    case "cranked":
      _id_59CDCDF44A2FA379 = 1;
      player.supportcranked = 1;
      player thread[[level._id_068A1353068460D1]]();
      break;
    case "armoredtruck":
      break;
    default:
      break;
  }

  if(_id_59CDCDF44A2FA379) {
    _id_1B4ADA49A21B51CA = undefined;

    if(_id_B517DF938986556F)
      _id_1B4ADA49A21B51CA = "br_item_purchased";

    _id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, "special", _id_1B4ADA49A21B51CA, quantity);
  }

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
    if(isDefined(level._id_8EC1A1CA587A6487))
      player[[level._id_8EC1A1CA587A6487]](_id_A365E25AA9D7BCDA.ref);

    armorykioskused(0, undefined, undefined, self);
  } else if(getdvarint("dvar_5509A47C2830ABD3", 1) == 1)
    armorykioskused(_id_15B89FF206500554, undefined, undefined, self);
}

_handlevehiclepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E) {
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

  contents = physics_createcontents(["physicscontents_water", "physicscontents_item", "physicscontents_vehicleclip"]);

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, _id_A365E25AA9D7BCDA.ref))
    return 0;

  spawndata.spawntype = "KIOSK";

  if(_id_721EE99D7A8F9168::_id_CCDCF48542C8A5B7(_id_A365E25AA9D7BCDA.ref))
    vehicle = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD(_id_A365E25AA9D7BCDA.ref, spawndata);
  else
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_A365E25AA9D7BCDA.ref, spawndata);

  if(!isDefined(vehicle))
    return 0;

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);
  self calloutmarkerping_create(21, (0, 0, 100), vehicle getentitynumber());
  return 1;
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
    players = _id_098B53A7358927D9::_id_9563F2D4E690856D(self.team, "players");

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

_id_6E4F7E117D4651C3() {
  player = self;
  squad = _id_098B53A7358927D9::_id_9563F2D4E690856D(player.team, "players");

  foreach(_id_8F7040E569EC9E98 in squad) {
    if(isDefined(_id_8F7040E569EC9E98)) {
      _id_EBEC497FF8B18A45 = _id_8F7040E569EC9E98 _id_098B53A7358927D9::_id_97FAC14206681B1F();

      if(isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "super_vehicle_drop") {
        if(_id_8F7040E569EC9E98 getammocount(_id_8F7040E569EC9E98.super.staticdata.weapon) > 0)
          return 1;
      }
    }
  }

  if(isDefined(level._id_E3CCF0898A949BEC) && istrue(level._id_E3CCF0898A949BEC[player.team]))
    return 1;

  return 0;
}

_id_D48C5142F8271C18() {
  if(isDefined(level.teamvehicles) && !isDefined(level.teamvehicles[self.team]))
    return 1;

  return 0;
}

_id_365E64606D4F3DA8(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  _id_098B53A7358927D9::_id_0F87529D7AF4978B(_id_A365E25AA9D7BCDA.ref, "other");
  thread _id_098B53A7358927D9::_id_234F5394668ED388("br_killstreak_purchased");
  armorykioskused(0, undefined, undefined, self);
  return;
}

_id_6C02B611541421D2(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  _id_098B53A7358927D9::_id_690E9E142EBC1C69(_id_A365E25AA9D7BCDA.ref);
  _id_098B53A7358927D9::_id_4F2BD7DA634CBA24(_id_A365E25AA9D7BCDA.ref, 1);
  thread _id_098B53A7358927D9::_id_234F5394668ED388("br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(_id_452130D9D126E506))
    _id_098B53A7358927D9::_id_74EFAA97EBFEC5DF(_id_098B53A7358927D9::_id_19DD797E5D48D987(), undefined, undefined, undefined, 1);

  armorykioskused(0, undefined, undefined, self);
}

_id_F1D968FD69AB759A(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  _id_098B53A7358927D9::_id_690E9E142EBC1C69(_id_A365E25AA9D7BCDA.ref);
  _id_098B53A7358927D9::_id_4F2BD7DA634CBA24(_id_A365E25AA9D7BCDA.ref, 1);
  thread _id_098B53A7358927D9::_id_234F5394668ED388("br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(_id_452130D9D126E506))
    _id_098B53A7358927D9::_id_74EFAA97EBFEC5DF(_id_098B53A7358927D9::_id_19DD797E5D48D987(), undefined, undefined, undefined, 1);

  armorykioskused(0, undefined, undefined, self);
}

_id_157316F7321DD26B(_id_A365E25AA9D7BCDA, _id_A5AB866673E5E99D, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  self endon("disconnect");
  _id_098B53A7358927D9::_id_5942F6CDBB6CB63B(_id_A365E25AA9D7BCDA.ref);
  _id_A573B91325F9EA32(self, _id_A365E25AA9D7BCDA, "perk", _id_A365E25AA9D7BCDA.ref);
  armorykioskused(0, undefined, undefined, self);
  return;
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

_id_601181692F53E4ED(_id_CB325DDB4A764623) {
  foreach(item in level.br_armory_kiosk.items) {
    if(item.ref == _id_CB325DDB4A764623)
      return item;
  }
}

onarmorykioskpurchase(_id_7148C1A6F25491F8, _id_1657E74C9190D2A2) {
  player = self;
  _id_15B89FF206500554 = player.br_kiosk;

  if(!istrue(player.armorykioskpurchaseallowed) && !istrue(level._id_D804888D9484FF69)) {
    return;
  }
  _id_6C457C5F341BEB23 = "channel: " + _id_7148C1A6F25491F8;

  if(isDefined(_id_1657E74C9190D2A2))
    _id_6C457C5F341BEB23 = _id_6C457C5F341BEB23 + ", index: " + _id_1657E74C9190D2A2;

  _id_098B53A7358927D9::_id_E667D74ECC894CEB(player, "menu_purchase", _id_6C457C5F341BEB23);
  _id_7DDDAC09987D559E = getdvarint("dvar_D6A60F25EF560A17", 1);
  _id_452130D9D126E506 = getdvarint("dvar_8E3B1991482F0D41", 0);

  if(player _id_098B53A7358927D9::_id_C4D8558FC1592CD6())
    _id_452130D9D126E506 = 1;

  if(_id_7148C1A6F25491F8 == "br_cancel_purchase")
    _purchasemenuclosedbyclient(player);
  else if(_id_7148C1A6F25491F8 == "br_item_purchase") {
    _id_3793828403C6873E = _id_1657E74C9190D2A2;
    _id_A365E25AA9D7BCDA = level.br_armory_kiosk.items[_id_3793828403C6873E];
    _id_4D1BE4FB3C1A5C4E = player _validateitempurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506);

    if(_id_4D1BE4FB3C1A5C4E) {
      if(isDefined(_id_A365E25AA9D7BCDA._id_144769F518D71226) && _id_A365E25AA9D7BCDA._id_144769F518D71226 > 0) {
        _id_A365E25AA9D7BCDA._id_144769F518D71226--;
        setomnvar("ui_buystation_limited_item_amount_temp", _id_A365E25AA9D7BCDA._id_144769F518D71226);
      }

      _id_DB943473454F6EA6 = undefined;

      if(_id_098B53A7358927D9::_id_83E3B506365BAFC5())
        _id_DB943473454F6EA6 = _id_098B53A7358927D9::_id_507B98884B41CC8E();

      if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "killstreak")
        player thread _id_BC5F62F877BE030F(::_id_365E64606D4F3DA8, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super")
        player thread _id_BC5F62F877BE030F(::_id_6C02B611541421D2, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && _id_A365E25AA9D7BCDA.type == "perk")
        player thread _id_BC5F62F877BE030F(::_id_157316F7321DD26B, _id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(isDefined(level._id_8A3D726E5CF04CC0))
        player[[level._id_8A3D726E5CF04CC0]](_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "killstreak")
        player thread _handlekillstreakpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super")
        player _handlefieldupgradepurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "weapon")
        player _id_90B0E9EB26E38443(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6);
      else if(_id_A365E25AA9D7BCDA.type == "perk")
        player _id_157316F7321DD26B(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506);
      else if(_id_A365E25AA9D7BCDA.type == "special")
        player _handlespecialpurchase(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554);
    }
  } else if(_id_7148C1A6F25491F8 == "br_loadout_purchase") {
    _id_324375F2F392C8EE = 0;
    loadoutindex = _id_1657E74C9190D2A2;
    _id_A3DB00E9F0A90D88 = _id_601181692F53E4ED("loadout_custom");

    if(_id_098B53A7358927D9::_id_496BA4F72BA5E5D1(loadoutindex)) {
      _id_A3DB00E9F0A90D88 = _id_601181692F53E4ED("loadout_default");
      _id_324375F2F392C8EE = 1;
    }

    _id_03E487E0C00E4A4C = _getactualcost(player, _id_A3DB00E9F0A90D88);

    if(player.plundercount < _id_03E487E0C00E4A4C) {
      player _closepurchasemenuwithresponse(3);
      return;
    }

    _id_2D36749FDFFC49B4 = _id_098B53A7358927D9::_id_6A38B44A9A4E8761(loadoutindex);
    _id_098B53A7358927D9::_id_90CA6872B70E4C2E(self, "purchasing_new_loadout");
    player.pers["class"] = _id_2D36749FDFFC49B4;
    player.class = _id_2D36749FDFFC49B4;
    _id_D5601F78A39895FF = player _id_098B53A7358927D9::_id_A4968A44B192F2ED(_id_2D36749FDFFC49B4);
    _id_098B53A7358927D9::_id_BE7AF2B74939C9B5(player, _id_7DDDAC09987D559E);
    _id_A573B91325F9EA32(player, _id_A3DB00E9F0A90D88, "loadout", "br_loadout_purchased");

    if(istrue(_id_324375F2F392C8EE))
      _id_098B53A7358927D9::_id_98BD9179435D1557(self, _id_03E487E0C00E4A4C, "defaultLoadout", "loadout_" + loadoutindex);
    else
      _id_098B53A7358927D9::_id_3CF2D6DDF853BDEE(self, _id_03E487E0C00E4A4C, _id_D5601F78A39895FF);
  } else if(_id_7148C1A6F25491F8 == "br_team_revive") {
    _id_BF5D82BEFBB59EFE = _id_1657E74C9190D2A2 - 1;
    _id_EB276D34779513E3 = !_id_098B53A7358927D9::_id_946938D9FDE4BDCE("useTokenToReviveTeammate");
    _id_4DFC1F5D7602B10D = istrue(player.hasrespawntoken) && _id_EB276D34779513E3;
    _id_69FAC551DCF6C2FB = _id_601181692F53E4ED("teamrevive");
    _id_0A120356B021F8E8 = _getactualcost(player, _id_69FAC551DCF6C2FB);

    if(!_id_4DFC1F5D7602B10D && player.plundercount < _id_0A120356B021F8E8) {
      player _closepurchasemenuwithresponse(3);
      return 0;
    }

    _id_C7869D69DBCF7FD3 = undefined;
    squad = _id_098B53A7358927D9::_id_9563F2D4E690856D(player.team, "players");

    foreach(_id_8F7040E569EC9E98 in squad) {
      if(!isDefined(_id_8F7040E569EC9E98) || _id_8F7040E569EC9E98 == player) {
        continue;
      }
      if(isDefined(_id_8F7040E569EC9E98._id_3F78C6A0862F9E25) && _id_8F7040E569EC9E98._id_3F78C6A0862F9E25 == _id_BF5D82BEFBB59EFE) {
        _id_C7869D69DBCF7FD3 = _id_8F7040E569EC9E98;
        break;
      }
    }

    if(!isDefined(_id_C7869D69DBCF7FD3)) {
      player _closepurchasemenuwithresponse(12);
      return;
    }

    if(!_id_C7869D69DBCF7FD3 _id_098B53A7358927D9::_id_B71E2F7AFD69D580() && !getdvarint("dvar_4D250E4873E1753E", 0)) {
      if(_id_098B53A7358927D9::_id_F6C807A601F8A34D(_id_C7869D69DBCF7FD3))
        player _closepurchasemenuwithresponse(14);
      else if(isalive(_id_C7869D69DBCF7FD3))
        player _closepurchasemenuwithresponse(15);
      else
        player _closepurchasemenuwithresponse(13);

      return;
    }

    _id_A4C6CDA2E74187F2 = 0;

    if(!_id_4DFC1F5D7602B10D) {
      cost = level.br_armory_kiosk.teamrevivecost;
      firesalediscount = level.br_armory_kiosk.teamrevivefiresalediscount;
      _id_A573B91325F9EA32(player, _id_69FAC551DCF6C2FB, "teamrevive");

      if(istrue(player.hasrespawntoken))
        _id_A4C6CDA2E74187F2 = 1;
      else
        player _id_098B53A7358927D9::_id_C00F90A28C41FEBE(1);

      player scripts\cp_mp\challenges::onkioskpurchaseitem("teamrevive", "teamrevive");
      _id_098B53A7358927D9::_id_98BD9179435D1557(player, _id_0A120356B021F8E8, "teamrevive_money", "teamrevive");
    } else {
      _id_3A93448A74526680 = [];
      _id_3A93448A74526680.cost = 0;
      _id_3A93448A74526680.firesalediscount = 0;
      _id_A573B91325F9EA32(player, _id_3A93448A74526680, "teamrevive");
    }

    if(_id_098B53A7358927D9::_id_3FCB060110170AC9("kioskRevivePlayer"))
      _id_C7869D69DBCF7FD3 thread _id_098B53A7358927D9::_id_25FB9A3B7EE98D69("kioskRevivePlayer", player, _id_4DFC1F5D7602B10D);
    else
      _id_C7869D69DBCF7FD3 thread _id_098B53A7358927D9::_id_8BD31D20349AA464(player, _id_4DFC1F5D7602B10D);

    if(_id_A4C6CDA2E74187F2)
      player _id_098B53A7358927D9::_id_C00F90A28C41FEBE(1);

    level thread _id_098B53A7358927D9::_id_188F8C265A7EF6EA(_id_15B89FF206500554.origin, "revive");
    player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_squadmate_revived");
  } else if(_id_7148C1A6F25491F8 == "upgrade_weapon") {}
}

_makekioskpurchase(_id_A365E25AA9D7BCDA) {
  player = self;
  _id_D47B7F992CA8A91E = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  cost = _getactualcost(player, _id_A365E25AA9D7BCDA);

  if(_id_D47B7F992CA8A91E && _id_A365E25AA9D7BCDA.firesalediscount > 0)
    kioskfiresaledoneforplayer(player.br_kiosk, player);

  if(!_id_098B53A7358927D9::_id_A8A68668A0B2C9C4())
    player thread _id_098B53A7358927D9::_id_E800498086E36C29("br_kioskBuy", undefined, _id_098B53A7358927D9::_id_3D48DA36C7FD0FDB(_id_A365E25AA9D7BCDA.cost));

  if(cost > 0)
    player _id_098B53A7358927D9::_id_78A18C3B6DBFB0A5(cost);

  if(!isDefined(level.br_plunder))
    level.br_plunder = spawnStruct();

  if(!isDefined(level.br_plunder.kiosk_spent_total))
    level.br_plunder.kiosk_spent_total = 0;

  level.br_plunder.kiosk_spent_total = level.br_plunder.kiosk_spent_total + cost;

  if(!isDefined(level.br_plunder.kiosk_num_purchases))
    level.br_plunder.kiosk_num_purchases = 0;

  level.br_plunder.kiosk_num_purchases++;
  player _closepurchasemenuwithresponse(1);
  return cost;
}

_id_A573B91325F9EA32(player, _id_A365E25AA9D7BCDA, _id_7E1BFBE3F25F5583, _id_F7B6CC6C062A7A43, quantity) {
  _id_1CB2654B9D2B112A = player _makekioskpurchase(_id_A365E25AA9D7BCDA);
  lootid = _id_A365E25AA9D7BCDA.lootid;

  if(!isDefined(lootid))
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_A365E25AA9D7BCDA.ref);

  if(!isDefined(quantity))
    quantity = 1;

  player scripts\cp_mp\challenges::onkioskpurchaseitem(_id_7E1BFBE3F25F5583, _id_A365E25AA9D7BCDA.ref, lootid, quantity, _id_1CB2654B9D2B112A, undefined);

  if(isDefined(_id_7E1BFBE3F25F5583))
    _id_098B53A7358927D9::_id_98BD9179435D1557(player, _id_A365E25AA9D7BCDA.cost, _id_7E1BFBE3F25F5583, _id_A365E25AA9D7BCDA.ref);

  if(isDefined(_id_F7B6CC6C062A7A43))
    player thread _id_098B53A7358927D9::_id_234F5394668ED388(_id_F7B6CC6C062A7A43);
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
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  _id_6E586A99FA56A20F = _id_098B53A7358927D9::_id_88CAFEC24778C70C("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
    if(_id_098B53A7358927D9::_id_9CB5F84F96E33914(_id_6E586A99FA56A20F.location, 1)) {
      _id_9083EA775F3B0CD7 = _id_098B53A7358927D9::_id_5C8AD6E89A9F7B73(_id_6E586A99FA56A20F.location);
      _id_01230EA36A300368 = _id_9083EA775F3B0CD7["position"];

      if(_id_098B53A7358927D9::_id_9CB5F84F96E33914(_id_01230EA36A300368, 1)) {
        thread restartcircleelimination(_id_01230EA36A300368);
        success = 1;
      } else
        _closepurchasemenuwithresponse(18);
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
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

  if(_id_098B53A7358927D9::_id_3FCB060110170AC9("restartCircleElimination"))
    thread _id_098B53A7358927D9::_id_25FB9A3B7EE98D69("restartCircleElimination", origin, _id_8F6402AD8E91DA6A);

  foreach(player in level.players)
  player _id_098B53A7358927D9::_id_234F5394668ED388("br_late_circle_soon");

  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("circle")) {
    _id_098B53A7358927D9::_id_FA5BAABE8489E675(origin, _id_8F6402AD8E91DA6A, _id_00836A83C2BCA261, _id_26189638809F7B88);
    level.brgametype.disabledfeatures["circle"] = undefined;
  }

  if(_id_098B53A7358927D9::_id_9D18A22123E54D05("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  _id_EFCF5EB682EF5688 = max(0, _id_8F6402AD8E91DA6A - _id_937DD942E0664F1A);
  wait(_id_EFCF5EB682EF5688);

  foreach(player in level.players)
  player _id_098B53A7358927D9::_id_234F5394668ED388("br_late_circle_now");

  _id_AD75DBC17E0FAF18 = _id_8F6402AD8E91DA6A - _id_EFCF5EB682EF5688;
  wait(_id_AD75DBC17E0FAF18);

  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("teamSpectate")) {
    level thread _id_098B53A7358927D9::_id_0BAF6855827FE902();
    level.brgametype.disabledfeatures["teamSpectate"] = undefined;
  }

  if(_id_098B53A7358927D9::_id_946938D9FDE4BDCE("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", _id_098B53A7358927D9::_id_67386B14D0C7D1EE(), "_numLives"), 1);
  }
}

playerhandleredeploy() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  _id_6E586A99FA56A20F = _id_098B53A7358927D9::_id_88CAFEC24778C70C("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
    _id_9083EA775F3B0CD7 = _id_098B53A7358927D9::_id_5C8AD6E89A9F7B73(_id_6E586A99FA56A20F.location);
    _id_01230EA36A300368 = _id_9083EA775F3B0CD7["position"];
    _closepurchasemenuwithresponse(18);
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
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
  _id_11F3B4465C8B637B = player _id_098B53A7358927D9::_id_20071A4B90F92B46(spawnpoint);
  player.forcespawnorigin = _id_11F3B4465C8B637B;
  _id_B59F471C2C064E56 = 1.0;
  player _id_098B53A7358927D9::_id_A39E8A33D7378F08();
  wait(_id_B59F471C2C064E56);
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  player _id_098B53A7358927D9::_id_092E04B29006F91C();
  player _id_098B53A7358927D9::_id_2CEA92D21876A90A(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(player);
  player playerlinktoabsolute(linker, "tag_origin");
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player thread _id_098B53A7358927D9::_id_01F5865AAB1FDAFD(linker);
  waitframe();
  player _id_098B53A7358927D9::_id_B4E05F84B56C7BBF();
  player _id_098B53A7358927D9::_id_BA38E09A56256701();
  linker playsoundtoplayer("br_ac130_flyby", player);
  wait 1.5;
  player unlink();
  player clearsoundsubmix("deaths_door_mp");
  player clearclienttriggeraudiozone(1);
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  player.isredeploykeepweapons = 1;
  player thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_show_spectateHud", -1);
  player _id_098B53A7358927D9::_id_4EC23357B146259C();
  wait 0.5;
  player _id_098B53A7358927D9::_id_B17054C9879EA13B();
  waitframe();
  linker delete();
}