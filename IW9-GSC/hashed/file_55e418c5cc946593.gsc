/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_55e418c5cc946593.gsc
***********************************************/

_id_9FD92851E68A5662() {
  _id_451A1A9BD9613164::_id_8ECE37593311858A(::onplayerconnect);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  _id_B950D479E0B6A443();
  _id_0A8254D939DE3584();
}

_id_CA7E33035F7F102F() {
  if(!_id_56F3D322E17B9974()) {
    return;
  }
  level._id_0767653D4D33E973 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 >= 1) {
      level._id_0767653D4D33E973[_id_AC0E594AC96AA3A8] = getdvarint(_func_2EF675C13CA1C4AF("dvar_AB797BDAB019E7F3", _id_AC0E594AC96AA3A8, "_unlock_points"), _id_AC0E594AC96AA3A8 * 500);
      continue;
    }

    level._id_0767653D4D33E973[_id_AC0E594AC96AA3A8] = 0;
  }
}

_id_C0D385A09D173A36() {
  if(scripts\mp\utility\game::getsubgametype() == "br")
    return getdvarint("dvar_9B611CF0CB4BF80E", 1) > 0;
  else
    return getdvarint("dvar_9B611CF0CB4BF80E", -1) > 0;
}

_id_2980F22FB01F43E6() {
  return _id_C0D385A09D173A36() && getdvarint("dvar_A8B771882E2FBC7A", 1);
}

_id_53B52A367576CBE3() {
  _id_19868614946C4DF4();

  if(_id_56F3D322E17B9974() && !isDefined(self._id_EAAA77E5F0F34045)) {
    self._id_EAAA77E5F0F34045 = [];

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
      self._id_EAAA77E5F0F34045["slot" + _id_AC0E594AC96AA3A8] = 0;
  }
}

_id_0A8254D939DE3584() {
  if(!isDefined(level._id_952400F520B7F68D))
    level._id_952400F520B7F68D = [];

  _id_F1FDBD9E3B92F2FC = 0;

  for(;;) {
    _id_A0CE8000D303764C = tablelookupbyrow("mp/br_perkpacktable.csv", _id_F1FDBD9E3B92F2FC, 0);

    if(!isDefined(_id_A0CE8000D303764C) || _id_A0CE8000D303764C == "" || scripts\engine\utility::array_contains_key(level._id_952400F520B7F68D, _id_A0CE8000D303764C)) {
      break;
    }

    level._id_952400F520B7F68D[_id_A0CE8000D303764C]["loot_item"] = _id_A0CE8000D303764C;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_5D14FD750CB8AA7B = _id_AC0E594AC96AA3A8 + 1;
      level._id_952400F520B7F68D[_id_A0CE8000D303764C]["perk" + (_id_AC0E594AC96AA3A8 + 1)] = tablelookupbyrow("mp/br_perkpacktable.csv", _id_F1FDBD9E3B92F2FC, _id_5D14FD750CB8AA7B);
    }

    _id_F1FDBD9E3B92F2FC++;
  }
}

_id_B950D479E0B6A443() {
  if(!isDefined(level._id_952400F520B7F68D))
    level._id_952400F520B7F68D = [];

  _id_25EA48876F86D21E = getscriptbundle("perkpackagelist:brloot_perkpackagelist_iw9");

  if(isDefined(_id_25EA48876F86D21E)) {
    foreach(_id_3516AC40ED0E076E in _id_25EA48876F86D21E._id_1DACE216D1A32D14) {
      _id_94301E72B910A4E0 = _id_3516AC40ED0E076E._id_782866E364DCD2EF;
      _id_B65F7E354B049957 = getscriptbundle("perkpackage:" + _id_94301E72B910A4E0);

      if(isDefined(_id_B65F7E354B049957)) {
        level._id_952400F520B7F68D[_id_94301E72B910A4E0]["loot_item"] = _id_94301E72B910A4E0;

        if(isDefined(_id_B65F7E354B049957.perks._id_89BA9D57A95DA53B) && _id_B65F7E354B049957.perks._id_89BA9D57A95DA53B != "" && _id_B65F7E354B049957.perks._id_89BA9D57A95DA53B != "specialty_null")
          level._id_952400F520B7F68D[_id_94301E72B910A4E0]["perk1"] = _id_B65F7E354B049957.perks._id_89BA9D57A95DA53B;

        if(isDefined(_id_B65F7E354B049957.perks._id_89BA9E57A95DA76E) && _id_B65F7E354B049957.perks._id_89BA9E57A95DA76E != "" && _id_B65F7E354B049957.perks._id_89BA9E57A95DA76E != "specialty_null")
          level._id_952400F520B7F68D[_id_94301E72B910A4E0]["perk2"] = _id_B65F7E354B049957.perks._id_89BA9E57A95DA76E;

        if(isDefined(_id_B65F7E354B049957.perks._id_13DB3CA1AD2DB644) && _id_B65F7E354B049957.perks._id_13DB3CA1AD2DB644 != "" && _id_B65F7E354B049957.perks._id_13DB3CA1AD2DB644 != "specialty_null")
          level._id_952400F520B7F68D[_id_94301E72B910A4E0]["perk3"] = _id_B65F7E354B049957.perks._id_13DB3CA1AD2DB644;

        if(isDefined(_id_B65F7E354B049957.perks._id_34FDCA49E62D81EE) && _id_B65F7E354B049957.perks._id_34FDCA49E62D81EE != "" && _id_B65F7E354B049957.perks._id_34FDCA49E62D81EE != "specialty_null")
          level._id_952400F520B7F68D[_id_94301E72B910A4E0]["perk4"] = _id_B65F7E354B049957.perks._id_34FDCA49E62D81EE;
      }
    }
  }
}

_id_40D138C40BD87F37(_id_183EC729C8876D57, _id_547C5DD37FEECABF) {
  if(!isDefined(self._id_028C944F222F4814))
    self._id_028C944F222F4814 = spawnStruct();

  if(!isDefined(self._id_028C944F222F4814.perks))
    self._id_028C944F222F4814.perks = [];
  else
    _id_F7D6C69E277FB3D4();

  if(isDefined(_id_183EC729C8876D57)) {
    self._id_028C944F222F4814._id_183EC729C8876D57 = _id_183EC729C8876D57;

    if(scripts\engine\utility::array_contains_key(level._id_952400F520B7F68D, _id_183EC729C8876D57)) {
      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
        self._id_028C944F222F4814.perks["perk" + _id_AC0E594AC96AA3A8] = level._id_952400F520B7F68D[_id_183EC729C8876D57]["perk" + _id_AC0E594AC96AA3A8];
    } else if(isDefined(_id_547C5DD37FEECABF)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 + 1 <= 4; _id_AC0E594AC96AA3A8++) {
        key = "perk" + (_id_AC0E594AC96AA3A8 + 1);

        if(scripts\engine\utility::array_contains_key(_id_547C5DD37FEECABF, key)) {
          self._id_028C944F222F4814.perks[key] = _id_547C5DD37FEECABF[key];
          continue;
        }

        if(_id_AC0E594AC96AA3A8 < _id_547C5DD37FEECABF.size && _id_3F643D9C78963AD5(_id_547C5DD37FEECABF[_id_AC0E594AC96AA3A8]))
          self._id_028C944F222F4814.perks[key] = _id_547C5DD37FEECABF[_id_AC0E594AC96AA3A8];
      }
    }

    _id_BAE19A088F61B99A();
    _id_1296419D9C62A9A8();
  } else
    _id_19868614946C4DF4();
}

_id_19868614946C4DF4() {
  _id_F7D6C69E277FB3D4();

  if(!isDefined(self._id_028C944F222F4814))
    self._id_028C944F222F4814 = spawnStruct();

  if(!isDefined(self._id_028C944F222F4814.perks))
    self._id_028C944F222F4814.perks = [];

  self._id_028C944F222F4814._id_183EC729C8876D57 = undefined;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    self._id_028C944F222F4814.perks["perk" + _id_AC0E594AC96AA3A8] = undefined;

  _id_1296419D9C62A9A8();
}

_id_1296419D9C62A9A8() {
  _id_77BC1C85DC4C173F = _id_FCBB275768006EBD();
  scripts\mp\perks\perks::_id_7C8CC44B58093CE4(_id_77BC1C85DC4C173F);
  scripts\mp\perks\perks::setomnvarsforperklist("ui_spawn_perk_", _id_77BC1C85DC4C173F);
}

_id_FCBB275768006EBD() {
  _id_CA58D54671E2640D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_CA58D54671E2640D[_id_AC0E594AC96AA3A8] = undefined;
    _id_FA18B14EE43C464B = "perk" + (_id_AC0E594AC96AA3A8 + 1);

    if(isDefined(self._id_028C944F222F4814.perks) && scripts\engine\utility::array_contains_key(self._id_028C944F222F4814.perks, _id_FA18B14EE43C464B))
      _id_CA58D54671E2640D[_id_AC0E594AC96AA3A8] = self._id_028C944F222F4814.perks[_id_FA18B14EE43C464B];
  }

  return _id_CA58D54671E2640D;
}

_id_BAE19A088F61B99A() {
  if(!isDefined(self._id_028C944F222F4814) || !isDefined(self._id_028C944F222F4814.perks)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
    if(istrue(_id_EE52068FBB9B0DEC(_id_AC0E594AC96AA3A8)) && scripts\engine\utility::array_contains_key(self._id_028C944F222F4814.perks, "perk" + _id_AC0E594AC96AA3A8)) {
      perk = self._id_028C944F222F4814.perks["perk" + _id_AC0E594AC96AA3A8];

      if(_id_3F643D9C78963AD5(perk) && !scripts\mp\utility\perk::_hasperk(perk))
        scripts\mp\class::loadout_giveperk(perk);
    }
  }
}

_id_F7D6C69E277FB3D4() {
  if(!isDefined(self._id_028C944F222F4814) || !isDefined(self._id_028C944F222F4814.perks)) {
    return;
  }
  foreach(perk in self._id_028C944F222F4814.perks) {
    if(_id_3F643D9C78963AD5(perk) && scripts\mp\utility\perk::_hasperk(perk)) {
      if(isDefined(self.loadoutperks) && scripts\engine\utility::array_contains(self.loadoutperks, perk)) {
        scripts\mp\class::loadout_removeperk(perk);
        continue;
      }

      scripts\mp\utility\perk::removeperk(perk);
    }
  }
}

_id_3AF287CE55291889(_id_65B695F0C0D909ED) {
  _id_A1093166DE09E6B8 = undefined;
  [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_65B695F0C0D909ED);

  if(isDefined(lootid)) {
    _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(!isDefined(_id_A1093166DE09E6B8))
      _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

    if(_id_43044DA0ED44D79F(_id_A1093166DE09E6B8)) {
      _id_A991642854217164 = _id_3634D41E203BC04E(_id_65B695F0C0D909ED);

      if(isDefined(_id_A991642854217164) && isDefined(_id_A991642854217164.perks))
        return [_id_A1093166DE09E6B8, _id_A991642854217164.perks];
    } else if(scripts\engine\utility::array_contains_key(level._id_952400F520B7F68D, _id_A1093166DE09E6B8))
      return [_id_A1093166DE09E6B8, level._id_952400F520B7F68D[_id_A1093166DE09E6B8]];
  }

  return undefined;
}

_id_B28E5AC58E164CAC(_id_3E89258CCB54EB4B) {
  _id_6C77123D46F26285 = _id_3E89258CCB54EB4B.scriptablename;
  _id_CA5AD0C2334C4A6C = undefined;

  if(isDefined(_id_3E89258CCB54EB4B.perks))
    _id_CA5AD0C2334C4A6C = _id_3E89258CCB54EB4B.perks;
  else if(isDefined(_id_3E89258CCB54EB4B.instance) && isDefined(_id_3E89258CCB54EB4B.instance.perks))
    _id_CA5AD0C2334C4A6C = _id_3E89258CCB54EB4B.instance.perks;
  else if(isDefined(_id_6C77123D46F26285) && scripts\engine\utility::array_contains_key(level._id_952400F520B7F68D, _id_6C77123D46F26285))
    _id_CA5AD0C2334C4A6C = level._id_952400F520B7F68D[_id_6C77123D46F26285];

  return [_id_6C77123D46F26285, _id_CA5AD0C2334C4A6C];
}

_id_C32B469BB2B68ECE() {
  return [self._id_028C944F222F4814._id_183EC729C8876D57, self._id_028C944F222F4814.perks];
}

_id_3F643D9C78963AD5(perk) {
  return isDefined(perk) && perk != "" && perk != "none" && perk != "specialty_null" && scripts\mp\perks\perks::_id_F45C19871B412EA5(perk);
}

_id_BDD930EEE0042052() {
  return getdvarint("dvar_FAA72EDE42EA5FAA", 1);
}

_id_C3023358DC648BF1(_id_3E89258CCB54EB4B, _id_A24F1824F93081A8, _id_A5B2C541413AA895, _id_65B695F0C0D909ED, _id_44EE85DCF52B4001) {
  _id_A1093166DE09E6B8 = undefined;
  perks = undefined;

  if(isDefined(_id_65B695F0C0D909ED)) {
    if(istrue(_id_A5B2C541413AA895) && (!isDefined(_id_44EE85DCF52B4001) || _id_44EE85DCF52B4001 == 0))
      [_id_A1093166DE09E6B8, perks] = _id_B28E5AC58E164CAC(_id_3E89258CCB54EB4B);
    else
      [_id_A1093166DE09E6B8, perks] = _id_3AF287CE55291889(_id_65B695F0C0D909ED);
  } else if(isDefined(_id_3E89258CCB54EB4B))
    [_id_A1093166DE09E6B8, perks] = _id_B28E5AC58E164CAC(_id_3E89258CCB54EB4B);

  if(isDefined(_id_3E89258CCB54EB4B)) {
    if(_id_A24F1824F93081A8) {
      origin = undefined;
      angles = (0, 0, 0);

      if(isDefined(_id_3E89258CCB54EB4B.origin))
        origin = _id_3E89258CCB54EB4B.origin;
      else if(isDefined(_id_3E89258CCB54EB4B.instance) && isDefined(_id_3E89258CCB54EB4B.instance.origin))
        origin = _id_3E89258CCB54EB4B.instance.origin;
      else if(isDefined(self.origin))
        origin = self.origin;

      if(isDefined(_id_3E89258CCB54EB4B.angles))
        angles = _id_3E89258CCB54EB4B.angles;
      else if(isDefined(_id_3E89258CCB54EB4B.instance) && isDefined(_id_3E89258CCB54EB4B.instance.angles))
        angles = _id_3E89258CCB54EB4B.instance.angles;
      else if(isDefined(self.angles))
        angles = self.angles;

      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_3AF23B0BFAF91DBD(dropstruct, origin, angles);
    } else if(isDefined(self._id_028C944F222F4814._id_183EC729C8876D57)) {
      if(_id_43044DA0ED44D79F(self._id_028C944F222F4814._id_183EC729C8876D57))
        _id_222999AAD19F5B52(_id_65B695F0C0D909ED, _id_FCBB275768006EBD());
    }
  }

  _id_40D138C40BD87F37(_id_A1093166DE09E6B8, perks);
  return 1;
}

_id_3AF23B0BFAF91DBD(dropstruct, position, angles, _id_65B695F0C0D909ED) {
  scriptablename = undefined;
  item = undefined;

  if(_id_2980F22FB01F43E6()) {
    if(!isDefined(_id_65B695F0C0D909ED)) {
      if(isDefined(self._id_028C944F222F4814._id_183EC729C8876D57))
        scriptablename = self._id_028C944F222F4814._id_183EC729C8876D57;
      else if(isDefined(self.pers["loadoutPerks"]) && self.pers["loadoutPerks"].size > 0 && _id_F9311648DE44DE28())
        scriptablename = "brloot_perkpack_custom";
    } else {
      lootid = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_65B695F0C0D909ED);
      scriptablename = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    }

    if(isDefined(scriptablename)) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F);
      _id_CF2ABEC2F25BAE27 = undefined;

      if(_id_43044DA0ED44D79F(scriptablename)) {
        if(isDefined(_id_65B695F0C0D909ED)) {
          perkdata = _id_3634D41E203BC04E(_id_65B695F0C0D909ED);

          if(isDefined(perkdata))
            _id_CF2ABEC2F25BAE27 = perkdata.perks;

          _id_E8FD3389A3F6433A(_id_65B695F0C0D909ED);
        } else if(isDefined(self._id_028C944F222F4814.perks) && self._id_028C944F222F4814.perks.size > 0)
          _id_CF2ABEC2F25BAE27 = self._id_028C944F222F4814.perks;
        else
          _id_CF2ABEC2F25BAE27 = _id_5816441F86753DDA();

        _id_CB4FAD49263E20C4._id_A0597A25C511B0AC = ["stat_371D996051B67A4A"];

        if(isDefined(_id_CF2ABEC2F25BAE27)) {
          foreach(perk in _id_CF2ABEC2F25BAE27)
          _id_CB4FAD49263E20C4._id_A0597A25C511B0AC[_id_CB4FAD49263E20C4._id_A0597A25C511B0AC.size] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(perk);
        }
      }

      item = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, 1, 1);

      if(isDefined(item) && isDefined(_id_CF2ABEC2F25BAE27))
        item.perks = _func_82D95BA721744147(_id_CF2ABEC2F25BAE27);
    }
  }

  if(!isDefined(_id_65B695F0C0D909ED))
    _id_19868614946C4DF4();

  return item;
}

onplayerconnect() {
  _id_53B52A367576CBE3();
  thread _id_2FBBDFA540BDFB59();
}

onplayerdisconnect(player) {
  if(!isbot(player))
    player _id_6B534B98C34F9610();
}

onplayerkilled(attacker, victim) {
  if(isbot(victim)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  victim _id_19868614946C4DF4();
}

onplayerscore() {
  if(!_id_56F3D322E17B9974()) {
    return;
  }
  _id_F2DBAB6F947771F2();
  _id_C6BAC765C268EC51();
}

_id_56F3D322E17B9974() {
  return !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || getdvarint("dvar_B2A4FA1894B756BF", 0);
}

_id_EE52068FBB9B0DEC(index) {
  if(!_id_56F3D322E17B9974())
    return 1;

  if(!isDefined(self.pers["score"]) || index < 0 || index >= level._id_0767653D4D33E973.size)
    return 0;

  return self.pers["score"] >= level._id_0767653D4D33E973[index];
}

_id_F2DBAB6F947771F2() {
  if(!isPlayer(self)) {
    return;
  }
  if(!_id_C0D385A09D173A36() || !_id_56F3D322E17B9974()) {
    return;
  }
  if(!isDefined(self.pers["score"])) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  [_id_A0CE8000D303764C, perks] = _id_C32B469BB2B68ECE();

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
    if(!self._id_EAAA77E5F0F34045["slot" + _id_AC0E594AC96AA3A8] && _id_EE52068FBB9B0DEC(_id_AC0E594AC96AA3A8)) {
      self._id_EAAA77E5F0F34045["slot" + _id_AC0E594AC96AA3A8] = 1;

      if(isDefined(perks) && scripts\engine\utility::array_contains_key(perks, "perk" + _id_AC0E594AC96AA3A8)) {
        perk = perks["perk" + _id_AC0E594AC96AA3A8];

        if(isDefined(perk) && perk != "" && !scripts\mp\utility\perk::_hasperk(perk))
          scripts\mp\class::loadout_giveperk(perk);
      }
    }
  }
}

_id_C6BAC765C268EC51() {
  _id_CA485F8EC3DE1D80 = self.pers["score"];
  _id_9BDD49504CBA2069 = level._id_0767653D4D33E973[2];
  _id_724EB9AF40D71ADE = level._id_0767653D4D33E973[3];
  _id_4D0D085EE780C083 = _id_CA485F8EC3DE1D80 / _id_9BDD49504CBA2069;
  _id_E3DF6497B9E052AD = (_id_CA485F8EC3DE1D80 - _id_9BDD49504CBA2069) / (_id_724EB9AF40D71ADE - _id_9BDD49504CBA2069);
  self setclientomnvar("ui_perk_bonus_progress", _id_4D0D085EE780C083);
  self setclientomnvar("ui_perk_ultimate_progress", _id_E3DF6497B9E052AD);
}

_id_31EA444C3CECF0FB() {
  self._id_028C944F222F4814 = undefined;
}

_id_054410113B73D012() {
  self._id_EAAA77E5F0F34045 = undefined;
}

_id_BE64B439107F4392() {
  if(!isDefined(self._id_A1ADCD8BA70C9723)) {
    return;
  }
  if(self._id_A1ADCD8BA70C9723.size > 0) {
    foreach(_id_4EFE32558A7556C6 in self._id_A1ADCD8BA70C9723) {
      if(isDefined(_id_4EFE32558A7556C6.parent))
        _id_4EFE32558A7556C6.parent scripts\mp\hud_util::removechild(_id_4EFE32558A7556C6);
    }
  }

  self._id_A1ADCD8BA70C9723 = undefined;
  self._id_9DC07720609CC75B = undefined;
}

_id_6B534B98C34F9610() {
  _id_31EA444C3CECF0FB();
  _id_054410113B73D012();
  _id_4B84C1E093769DDF();
  _id_BE64B439107F4392();
}

_id_43044DA0ED44D79F(ref) {
  if(!isDefined(ref))
    return 0;

  return ref == "brloot_perkpack_custom";
}

_id_F9311648DE44DE28() {
  _id_F9311648DE44DE28 = 0;

  if(isDefined(self.pers["loadoutPerks"])) {
    foreach(perk in self.pers["loadoutPerks"]) {
      if(isDefined(perk) && perk != "specialty_null") {
        _id_F9311648DE44DE28 = 1;
        break;
      }
    }
  }

  return _id_F9311648DE44DE28;
}

_id_2FBBDFA540BDFB59() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("giveLoadout");

    if(scripts\mp\utility\player::isreallyalive(self) && _id_F9311648DE44DE28()) {
      perks = _id_5816441F86753DDA();
      _id_40D138C40BD87F37("brloot_perkpack_custom", perks);
    } else
      _id_19868614946C4DF4();

    waitframe();
  }
}

_id_BBB44BD3B8347EFC(_id_65B695F0C0D909ED, _id_4740EADAE93E17E7) {
  perkdata = _id_3634D41E203BC04E(_id_65B695F0C0D909ED);
  _id_4740EADAE93E17E7.perks = perkdata.perks;
  _id_E8FD3389A3F6433A(_id_65B695F0C0D909ED);
}

_id_1CA82D98D7519E1F(_id_65B695F0C0D909ED, _id_4740EADAE93E17E7) {
  if(!isDefined(_id_4740EADAE93E17E7.perks)) {
    return;
  }
  _id_222999AAD19F5B52(_id_65B695F0C0D909ED, _id_4740EADAE93E17E7.perks);
}

_id_446A16D58F290CA6(_id_4598840B8E42C901, _id_DB86A856DDBA5113) {
  if(!isDefined(_id_4598840B8E42C901.scriptablename) || _id_4598840B8E42C901.scriptablename != "brloot_perkpack_custom") {
    return;
  }
  if(!isDefined(_id_DB86A856DDBA5113) || _id_DB86A856DDBA5113.size <= 0) {
    [_id_A0CE8000D303764C, perks] = _id_C32B469BB2B68ECE();

    if(isDefined(perks) && perks.size > 0) {
      _id_4598840B8E42C901.perks = perks;
      return;
    }

    _id_4598840B8E42C901.perks = _id_5816441F86753DDA();
    return;
  } else
    _id_4598840B8E42C901.perks = _id_DB86A856DDBA5113;
}

_id_5816441F86753DDA() {
  perks = [];
  perks["perk1"] = self.pers["loadoutPerks"][0];
  perks["perk2"] = self.pers["loadoutPerks"][1];
  perks["perk3"] = self._id_15F3E6DF722FB1CF;
  perks["perk4"] = self._id_15F3E5DF722FAF9C;
  return perks;
}

_id_DA4A5BFFE842512A() {
  if(!isDefined(self.scriptablename) || self.scriptablename != "brloot_perkpack_custom" || !isDefined(self.perks))
    return undefined;

  perks = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.perks["perk" + _id_AC0E594AC96AA3A8]))
      perks[perks.size] = self.perks["perk" + _id_AC0E594AC96AA3A8];
  }

  return perks;
}

_id_3634D41E203BC04E(_id_65B695F0C0D909ED) {
  if(!isDefined(self._id_B9D1AAE41A5E8D70) || !isDefined(_id_65B695F0C0D909ED))
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_B9D1AAE41A5E8D70.size; _id_AC0E594AC96AA3A8++) {
    if(self._id_B9D1AAE41A5E8D70[_id_AC0E594AC96AA3A8].index == _id_65B695F0C0D909ED)
      return self._id_B9D1AAE41A5E8D70[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

_id_222999AAD19F5B52(index, perks) {
  if(isDefined(_id_3634D41E203BC04E(index)))
    _id_E8FD3389A3F6433A(index);

  if(!isDefined(self._id_B9D1AAE41A5E8D70))
    self._id_B9D1AAE41A5E8D70 = [];

  _id_CA58D54671E2640D = [];
  _id_CA5AD0C2334C4A6C = perks;

  if((!isDefined(_id_CA5AD0C2334C4A6C) || _id_CA5AD0C2334C4A6C.size <= 0) && _id_F9311648DE44DE28())
    _id_CA5AD0C2334C4A6C = _id_5816441F86753DDA();

  if(isDefined(_id_CA5AD0C2334C4A6C) && _id_CA5AD0C2334C4A6C.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 + 1 <= 4; _id_AC0E594AC96AA3A8++) {
      key = "perk" + (_id_AC0E594AC96AA3A8 + 1);

      if(scripts\engine\utility::array_contains_key(_id_CA5AD0C2334C4A6C, key)) {
        _id_CA58D54671E2640D[key] = _id_CA5AD0C2334C4A6C[key];
        continue;
      }

      if(_id_AC0E594AC96AA3A8 < _id_CA5AD0C2334C4A6C.size)
        _id_CA58D54671E2640D[key] = _id_CA5AD0C2334C4A6C[_id_AC0E594AC96AA3A8];
    }
  }

  if(_id_CA58D54671E2640D.size > 0) {
    _id_C9288AD70E172698 = self._id_B9D1AAE41A5E8D70.size;
    self._id_B9D1AAE41A5E8D70[_id_C9288AD70E172698] = spawnStruct();
    self._id_B9D1AAE41A5E8D70[_id_C9288AD70E172698].index = index;
    self._id_B9D1AAE41A5E8D70[_id_C9288AD70E172698].perks = _id_CA58D54671E2640D;
  }
}

_id_E8FD3389A3F6433A(_id_65B695F0C0D909ED) {
  if(!isDefined(self._id_B9D1AAE41A5E8D70) || !isDefined(_id_65B695F0C0D909ED)) {
    return;
  }
  _id_E61DD137E1DEC54B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_B9D1AAE41A5E8D70.size; _id_AC0E594AC96AA3A8++) {
    if(self._id_B9D1AAE41A5E8D70[_id_AC0E594AC96AA3A8].index == _id_65B695F0C0D909ED)
      _id_E61DD137E1DEC54B[_id_E61DD137E1DEC54B.size] = self._id_B9D1AAE41A5E8D70[_id_AC0E594AC96AA3A8];
  }

  if(_id_E61DD137E1DEC54B.size > 0) {
    foreach(item in _id_E61DD137E1DEC54B)
    self._id_B9D1AAE41A5E8D70 = scripts\engine\utility::array_remove(self._id_B9D1AAE41A5E8D70, item);
  }
}

_id_4B84C1E093769DDF() {
  if(!isDefined(self._id_B9D1AAE41A5E8D70)) {
    return;
  }
  self._id_B9D1AAE41A5E8D70 = undefined;
}