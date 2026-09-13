/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dead_drop.gsc
***********************************************/

_id_476BA78D85B349EA() {
  if(getdvarint("dvar_9A391AFDCA9A675D", 1) == 0) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body_dead_drop", _id_048614492EF09B23::_id_CF1B1F86951A9209);
  scripts\engine\utility::flag_wait("scriptables_ready");
  level._id_CED78996BBF1B2D3 = [];
  _id_23BB061A51E4A968 = getentitylessscriptablearray("scriptable_dmz_dead_drop", "classname");
  _id_D7EE9EE56A05D38E = scripts\engine\utility::getStructArray("dead_drop", "targetname");

  foreach(_id_5793A0CF9D352C92 in _id_D7EE9EE56A05D38E) {
    _id_96F03B58138C074B = "dmz_dead_drop";

    if(isDefined(_id_5793A0CF9D352C92._id_89DADBBF1464C45E) && int(_id_5793A0CF9D352C92._id_89DADBBF1464C45E) == 1)
      _id_96F03B58138C074B = "dmz_dead_drop_transaction_drawer";

    scriptable = spawnscriptable(_id_96F03B58138C074B, _id_5793A0CF9D352C92.origin, _id_5793A0CF9D352C92.angles);
    _id_23BB061A51E4A968[_id_23BB061A51E4A968.size] = scriptable;
  }

  _id_23BB061A51E4A968 = scripts\engine\utility::array_randomize(_id_23BB061A51E4A968);
  _id_687E21D8E8EA30D9 = _id_23BB061A51E4A968.size;

  if(level.mapname == "mp_bio_lab")
    _id_687E21D8E8EA30D9 = getdvarint("dvar_B17C7DABC88F3082", 1);

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    _id_35D8FF653F94A7CA = [(10021, 21237, 308), (9406, 6453, 354), (28068, -16832, 627), (-14881, -34634, 530), (-24077, -19468, 396), (-34730, 20647, -397)];
    _id_0A7313B60400BB70 = [];

    foreach(loc in _id_23BB061A51E4A968) {
      foreach(_id_18176E8F61BB2E83 in _id_35D8FF653F94A7CA) {
        if(distancesquared(loc.origin, _id_18176E8F61BB2E83) < 250000) {
          _id_7E52B56769FA7774::loothide(loc, "body_dead_drop");
          _id_0A7313B60400BB70[_id_0A7313B60400BB70.size] = loc;
        }
      }
    }

    _id_23BB061A51E4A968 = scripts\engine\utility::array_remove_array(_id_23BB061A51E4A968, _id_0A7313B60400BB70);
  }

  _id_6AD079AC6AB5CDC3 = 0;

  foreach(_id_5793A0CF9D352C92 in _id_23BB061A51E4A968) {
    if(_id_6AD079AC6AB5CDC3 >= _id_687E21D8E8EA30D9) {
      _id_7E52B56769FA7774::loothide(_id_5793A0CF9D352C92, "body_dead_drop");
      continue;
    }

    _id_5793A0CF9D352C92 setscriptablepartstate("body_dead_drop", "closed_usable");
    _id_5793A0CF9D352C92._id_055AA0066A9F3E9F = ::_id_BE64875FAE5BD1CE;
    _id_5793A0CF9D352C92._id_6978A4B328FD33B3 = ::_id_2463F61A8C4D7772;
    _id_5793A0CF9D352C92._id_CEB543956C7203E7 = ::_id_A1CBB02F01A33768;
    _id_5793A0CF9D352C92._id_FEBE9AACDD2E47B2 = !getdvarint("dvar_6EE9465E13D271E5", 1);
    level._id_CED78996BBF1B2D3[level._id_CED78996BBF1B2D3.size] = _id_5793A0CF9D352C92;
    _id_6AD079AC6AB5CDC3++;
  }

  scripts\engine\utility::flag_set("dead_drops_init");
}

_id_BE64875FAE5BD1CE(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance getscriptablepartstate("body_dead_drop") != "partially_opening_unusable")
    instance setscriptablepartstate("body_dead_drop", "partially_opening_unusable");

  if(isDefined(instance._id_50657BCF5BB1ED14))
    [[instance._id_50657BCF5BB1ED14]](player);
}

_id_2463F61A8C4D7772(_id_69E96A4CAA72D794, player, lootid, quantity, itemtype, _id_3793828403C6873E, _id_D54A79024C228770) {
  _id_338E098F5CBFDA5B = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onAddItemToDeadDrop"))
    [lootid, _id_338E098F5CBFDA5B] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onAddItemToDeadDrop")]](_id_69E96A4CAA72D794, lootid);

  _id_DFAB44D4D8D10B36 = quantity;

  if(isDefined(itemtype) && itemtype == 10)
    _id_DFAB44D4D8D10B36 = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_3793828403C6873E);

  if(!isDefined(itemtype))
    itemtype = 0;

  if(!isDefined(_id_3793828403C6873E))
    _id_3793828403C6873E = 0;

  player notify("item_added_to_cache", itemtype, _id_3793828403C6873E, lootid, _id_DFAB44D4D8D10B36);
  return [lootid, _id_338E098F5CBFDA5B];
}

_id_A1CBB02F01A33768(_id_69E96A4CAA72D794, opener) {
  _id_69E96A4CAA72D794 setscriptablepartstate("body_dead_drop", "partially_closing_unusable");
  player = opener;

  if(!isDefined(player) || !isDefined(_id_69E96A4CAA72D794)) {
    return;
  }
  if(isDefined(_id_69E96A4CAA72D794._id_2BC73315BD31809C) && isDefined(_id_69E96A4CAA72D794._id_2BC73315BD31809C[player.guid]))
    _id_69E96A4CAA72D794._id_2BC73315BD31809C[player.guid] = undefined;

  _id_E1CF43F3AE9D77E7 = _id_048614492EF09B23::_id_564C579AE581A82D(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents);

  if(isDefined(_id_69E96A4CAA72D794._id_7FF4ADF1A6C36A48))
    [[_id_69E96A4CAA72D794._id_7FF4ADF1A6C36A48]](_id_E1CF43F3AE9D77E7, opener);

  _id_BBAC576AADE31A1E = 0;

  foreach(index, item in _id_E1CF43F3AE9D77E7) {
    if(!isDefined(item.lootid)) {
      continue;
    }
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);
    _id_25978461C6E4F61B = level.br_pickups._id_838863C4848D4C26[ref];
    itemtype = undefined;

    if(isDefined(_id_25978461C6E4F61B))
      itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

    if(isDefined(itemtype) && !istrue(item._id_338E098F5CBFDA5B)) {
      if(itemtype == "plunder") {
        _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + item.quantity;
        continue;
      }

      if(getdvarint("dvar_06D4FB2DE66A0BD7", 1) || _id_2D9D24F7C63AC143::_id_E25E584CAC984A5D(itemtype)) {
        if(isDefined(_id_25978461C6E4F61B) && isDefined(level.br_pickups._id_D93566A78E29D583[_id_25978461C6E4F61B])) {
          _id_B87F7FAE01CE754F = level.br_pickups._id_D93566A78E29D583[_id_25978461C6E4F61B];
          quantity = item.quantity;

          if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(item.lootid))
            quantity = 1;

          _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + quantity * _id_B87F7FAE01CE754F;
        }
      }
    }
  }

  _id_B8F5D813D9E1194E = undefined;

  if(!istrue(_id_69E96A4CAA72D794._id_FEBE9AACDD2E47B2) && !istrue(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_5A90D1A92F9AF4E3)) {
    _id_98F7CE981BB1F93C = player scripts\mp\loot::_id_D6A3266145BAB76D("loot_container_weapon");

    if(istrue(_id_98F7CE981BB1F93C)) {
      _id_B8F5D813D9E1194E = spawnStruct();
      _id_B8F5D813D9E1194E.lootid = _id_98F7CE981BB1F93C;
      _id_B8F5D813D9E1194E.quantity = 1;
      _id_B8F5D813D9E1194E._id_E1147886CCF51970 = _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_275F4441AB7920C8;
      _id_E1CF43F3AE9D77E7[_id_E1CF43F3AE9D77E7.size] = _id_B8F5D813D9E1194E;
      _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + getdvarint("dvar_06BF1F5DA160E1CC", 400);
    }
  }

  _id_3EAA9F644DBE7834 = 0;
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 7);
  _id_B205D90302DA2F07 = _id_30B30561882A2477(_id_69E96A4CAA72D794);

  if(!_id_6A8EC730B2BFA844::_id_6F6CC16C0528DE5B(player) && !getdvarint("dvar_C3DA1A11F720D408", 0)) {
    return;
  }
  _id_BE59925F9891E2C1 = 0;

  foreach(index, item in _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents) {
    if(item["lootID"] == 0 || item["quantity"] == 0) {
      continue;
    }
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item["lootID"]);
    _id_25978461C6E4F61B = level.br_pickups._id_838863C4848D4C26[ref];
    itemtype = undefined;

    if(isDefined(_id_25978461C6E4F61B))
      itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

    if(!istrue(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["noExtract"])) {
      result = scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["lootID"], itemtype, _id_3EAA9F644DBE7834, _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["quantity"], undefined, _id_69E96A4CAA72D794._id_B205D90302DA2F07);
      _id_BE59925F9891E2C1 = istrue(result) || _id_BE59925F9891E2C1;

      if(!getdvarint("dvar_06D4FB2DE66A0BD7", 1) && !istrue(result) && !_id_2D9D24F7C63AC143::_id_E25E584CAC984A5D(itemtype)) {
        continue;
      }
      _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["lootID"] = 0;
      _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["quantity"] = 0;
    }
  }

  if(isDefined(_id_B8F5D813D9E1194E)) {
    lootsource = 0;

    if(isDefined(_id_B8F5D813D9E1194E._id_E1147886CCF51970) && isDefined(player.team) && _id_B8F5D813D9E1194E._id_E1147886CCF51970 != player.team)
      lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 0);

    result = scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, _id_B8F5D813D9E1194E.lootid, "weapon", _id_3EAA9F644DBE7834, _id_B8F5D813D9E1194E.quantity, lootsource, _id_69E96A4CAA72D794._id_B205D90302DA2F07);
    _id_6A8EC730B2BFA844::_id_44CB8B0C33CEF670(player, _id_69E96A4CAA72D794, _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_6FB67C8525B1D79E);
    _id_BE59925F9891E2C1 = istrue(result) || _id_BE59925F9891E2C1;
    player setclientomnvar("loot_container_weapon", 0);
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_04F6CDE716E0C3D7 = 0;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_6FB67C8525B1D79E = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_275F4441AB7920C8 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_4E479E14D0837E84 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_5A90D1A92F9AF4E3 = undefined;
  }

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_A123CDD3C38B7829 = _id_0B7A9CE0A2282B79::_id_80478F2EF8C8882F(player);
    _id_3D437F1697570E9A = _id_0160A29300CE1E14(_id_BBAC576AADE31A1E, player);

    if(_id_3D437F1697570E9A > 0) {
      _id_495E140C3EB9A557 = _id_0B7A9CE0A2282B79::_id_04E92B2A9E565AEE();
      _id_500370E4F476FAA9 = int(getdvarint("dvar_FABC6973E3E762A1", 200) * _id_BBAC576AADE31A1E / _id_495E140C3EB9A557);
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F50873A1C64BB93D", undefined, _id_500370E4F476FAA9, _id_500370E4F476FAA9);

      if(istrue(_id_A123CDD3C38B7829) && !istrue(_id_BE59925F9891E2C1)) {
        _id_1CC0D36F156A181A = _id_0B7A9CE0A2282B79::_id_498BA9B391E5D087(player);

        if(!isDefined(_id_1CC0D36F156A181A))
          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_dead_drop_cooldown_finish", [player]);
        else {
          _id_6F4690AA906C3F73 = _id_1CC0D36F156A181A - getsystemtime();

          if(_id_6F4690AA906C3F73 < 1800)
            _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_dead_drop_cooldown_low", [player]);
          else if(_id_6F4690AA906C3F73 >= 1800 && _id_6F4690AA906C3F73 < 3600)
            _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_dead_drop_cooldown_medium", [player]);
          else
            _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_dead_drop_cooldown_high", [player]);
        }
      }

      if(!isDefined(player._id_FD5C87130F304833))
        player._id_FD5C87130F304833 = 0;

      player._id_FD5C87130F304833 = player._id_FD5C87130F304833 + _id_500370E4F476FAA9;
    }

    if(!isDefined(player._id_8AE6C90597DAA60A))
      player._id_8AE6C90597DAA60A = 0;

    player._id_8AE6C90597DAA60A = player._id_8AE6C90597DAA60A + _id_BBAC576AADE31A1E;

    if(!isDefined(player._id_EC9A1B9484844FBE))
      player._id_EC9A1B9484844FBE = 0;

    player._id_EC9A1B9484844FBE = player._id_EC9A1B9484844FBE + _id_3D437F1697570E9A;
  }

  if(istrue(_id_BE59925F9891E2C1))
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_item_dead_drop_taken", [player]);
}

_id_0160A29300CE1E14(_id_BBAC576AADE31A1E, player, _id_95338F9D8305C0CB) {
  _id_95338F9D8305C0CB = scripts\engine\utility::_id_53C4C53197386572(_id_95338F9D8305C0CB, 1);
  _id_495E140C3EB9A557 = _id_0B7A9CE0A2282B79::_id_04E92B2A9E565AEE();
  _id_3D437F1697570E9A = int(3600 * _id_BBAC576AADE31A1E / _id_495E140C3EB9A557 * _id_95338F9D8305C0CB);
  _id_0B7A9CE0A2282B79::_id_A9857977596563CD(player, _id_3D437F1697570E9A);
  return _id_3D437F1697570E9A;
}

_id_30B30561882A2477(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_B205D90302DA2F07))
    _id_69E96A4CAA72D794._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_69E96A4CAA72D794.origin, 0, 1);

  return _id_69E96A4CAA72D794._id_B205D90302DA2F07;
}