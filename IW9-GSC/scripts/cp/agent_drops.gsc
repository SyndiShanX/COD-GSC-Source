/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agent_drops.gsc
***********************************************/

_id_6620B2D387064D74() {
  _id_22AD9CF8A9381198();
  _id_CB24C57AE08ED7AE();
}

_id_22AD9CF8A9381198() {
  level._id_0D932F46857D6D61 = [];
  level._id_DD7E94A4498CC047 = [];
  level._id_82482823A4BD9581 = [];
  level._id_D5149904CCB5FE9D = [];
  level._id_F7C5323D78892A4B = [];
  level._id_365210DF3B94B112 = [];
  _id_D2475F924F681EC3();
}

_id_D2475F924F681EC3() {
  level._id_13503C3176B8B0B1 = [];
  level._id_13503C3176B8B0B1["brloot_ammo_762"] = 38;
  level._id_13503C3176B8B0B1["brloot_ammo_919"] = 37;
  level._id_13503C3176B8B0B1["brloot_ammo_50cal"] = 10;
  level._id_13503C3176B8B0B1["brloot_ammo_12g"] = 10;
  level._id_13503C3176B8B0B1["brloot_ammo_rocket"] = 5;
  level._id_020E9E1C4DA44B83 = [];
  level._id_020E9E1C4DA44B83["brloot_ammo_762"] = -1;
  level._id_020E9E1C4DA44B83["brloot_ammo_919"] = -1;
  level._id_020E9E1C4DA44B83["brloot_ammo_50cal"] = -1;
  level._id_020E9E1C4DA44B83["brloot_ammo_12g"] = -1;
  level._id_020E9E1C4DA44B83["brloot_ammo_rocket"] = -1;
}

_id_CB24C57AE08ED7AE() {
  _id_6C38AF1AB38E980E("headshot_cash", ::_id_08CD9CA26D81FD9D, "money", 1, 30, 10, 1);
  _id_6C38AF1AB38E980E("cash_drop_50", ::_id_08CD9CA26D81FD9D, "money", 1, 30, 10, 1);
  _id_6C38AF1AB38E980E("cash_drop_150", ::_id_08CD9CA26D81FD9D, "money", 1, 30, 10, 1);
  _id_6C38AF1AB38E980E("cash_drop_1000", ::_id_08CD9CA26D81FD9D, "money", 1, 30, 10, 1);
  _id_6C38AF1AB38E980E("brloot_powerup_armor", ::_id_9EEC29E4018E3BD9, "power_up", 0, 30, 10, 1);
  _id_6C38AF1AB38E980E("cash_drop_100", ::_id_08CD9CA26D81FD9D, "money", 1, undefined, 5, 0);
  _id_6C38AF1AB38E980E("cash_drop_500", ::_id_08CD9CA26D81FD9D, "money", 1, undefined, 5, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_762", ::_id_E5FBAAB3DA0AF6DE, "ammo", 1, undefined, 20, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_rocket", ::_id_E5FBAAB3DA0AF6DE, "ammo", 1, undefined, 5, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_rocket_rpg_ai", ::_id_E5FBAAB3DA0AF6DE, "forced_ammo", 0, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_919", ::_id_E5FBAAB3DA0AF6DE, "ammo", 1, undefined, 20, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_50cal", ::_id_E5FBAAB3DA0AF6DE, "ammo", 1, undefined, 5, 0);
  _id_6C38AF1AB38E980E("brloot_ammo_12g", ::_id_E5FBAAB3DA0AF6DE, "ammo", 1, undefined, 10, 0);
  _id_6C38AF1AB38E980E("drop_random_ammo_types", ::_id_E4BD43508C05C894, "ammo", 1, undefined, 20, 0);
  _id_6C38AF1AB38E980E("brloot_armor_plate", ::_id_9EEC29E4018E3BD9, "power_up", 0, 8, 20, 0);
  _id_6C38AF1AB38E980E("brloot_powerup_ammo", ::_id_9EEC29E4018E3BD9, "power_up", 0, 30, 10, 0);
  _id_6C38AF1AB38E980E("brloot_powerup_equipment", ::_id_9EEC29E4018E3BD9, "power_up", 0, undefined, 10, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_claymore", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_decoy", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_flash", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_gas", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_smoke", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_snapshot", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_6C38AF1AB38E980E("brloot_offhand_throwingknife", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 1);
  _id_6C38AF1AB38E980E("brloot_offhand_heartbeatsensor", ::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
}

_id_6C38AF1AB38E980E(_id_D49285246B443066, _id_66565A6B6F849187, drop_type, _id_138C8168E3B1A349, time_between_spawns, _id_429F631E84274DD3, _id_3B2E46E915EA397B) {
  if(istrue(_id_3B2E46E915EA397B)) {
    return;
  }
  if(_id_92031FF8A97D9E90(_id_D49285246B443066)) {}

  if(!isDefined(level._id_0D932F46857D6D61[_id_D49285246B443066]))
    level._id_0D932F46857D6D61[_id_D49285246B443066] = [];

  level._id_0D932F46857D6D61[_id_D49285246B443066] = _id_66565A6B6F849187;

  if(isDefined(drop_type)) {
    if(!isDefined(level._id_DD7E94A4498CC047[drop_type]))
      level._id_DD7E94A4498CC047[drop_type] = [];

    level._id_DD7E94A4498CC047[_id_D49285246B443066] = drop_type;
  }

  if(istrue(_id_138C8168E3B1A349))
    level._id_82482823A4BD9581[_id_D49285246B443066] = 1;

  if(isDefined(time_between_spawns))
    _id_630229E935873B44(_id_D49285246B443066, time_between_spawns);

  if(isDefined(_id_429F631E84274DD3))
    level._id_365210DF3B94B112[_id_D49285246B443066] = _id_429F631E84274DD3;
  else
    level._id_365210DF3B94B112[_id_D49285246B443066] = 100;

  setDvar(_func_2EF675C13CA1C4AF("dvar_6E663FB6F8A19320", _id_D49285246B443066), level._id_365210DF3B94B112[_id_D49285246B443066]);
}

_id_276D0D2C772B45BB(_id_D49285246B443066) {
  level._id_0D932F46857D6D61[_id_D49285246B443066] = undefined;
  level._id_365210DF3B94B112[_id_D49285246B443066] = undefined;
  level._id_82482823A4BD9581[_id_D49285246B443066] = undefined;
  level._id_DD7E94A4498CC047[_id_D49285246B443066] = undefined;
  level._id_D5149904CCB5FE9D[_id_D49285246B443066] = undefined;
}

_id_630229E935873B44(_id_D49285246B443066, time_between_spawns) {
  level._id_D5149904CCB5FE9D[_id_D49285246B443066] = time_between_spawns * 1000;
}

_id_6C418592A0F5850D(_id_D49285246B443066) {
  return isDefined(level._id_D5149904CCB5FE9D[_id_D49285246B443066]);
}

_id_9C2F4B63B917CBC1(_id_D49285246B443066) {
  return level._id_D5149904CCB5FE9D[_id_D49285246B443066];
}

_id_A74A1AD1BBA9F0FD(_id_D49285246B443066) {
  if(isDefined(level._id_F7C5323D78892A4B[_id_D49285246B443066]))
    return level._id_F7C5323D78892A4B[_id_D49285246B443066];
  else
    return 0;
}

_id_526976D2FD70521F(_id_D49285246B443066) {
  _id_3238A12B980595E1 = _id_B843FBF56B48D7A5(_id_D49285246B443066);

  if(randomint(100) < _id_3238A12B980595E1) {
    if(_id_6C418592A0F5850D(_id_D49285246B443066)) {
      time = gettime();
      _id_67940DBF6482E648 = _id_A74A1AD1BBA9F0FD(_id_D49285246B443066);
      return time >= _id_67940DBF6482E648;
    } else
      return 1;
  } else
    return 0;
}

_id_B843FBF56B48D7A5(_id_D49285246B443066) {
  if(getdvarint("dvar_2CDA10D708006761"))
    return 100;

  if(isDefined(level._id_365210DF3B94B112[_id_D49285246B443066])) {
    if(getdvarint(_func_2EF675C13CA1C4AF("dvar_6E663FB6F8A19320", _id_D49285246B443066)) != level._id_365210DF3B94B112[_id_D49285246B443066])
      return getdvarint(_func_2EF675C13CA1C4AF("dvar_6E663FB6F8A19320", _id_D49285246B443066));
    else
      return level._id_365210DF3B94B112[_id_D49285246B443066];
  } else
    return 100;
}

_id_0304333FF6B2313F(_id_D49285246B443066) {
  if(_id_6C418592A0F5850D(_id_D49285246B443066)) {
    _id_13FACE5B7D5CE7B4 = _id_9C2F4B63B917CBC1(_id_D49285246B443066);
    time = gettime();
    level._id_F7C5323D78892A4B[_id_D49285246B443066] = time + _id_13FACE5B7D5CE7B4;
  }
}

_id_29A7CB456961B143(_id_D49285246B443066) {
  if(isDefined(level._id_DD7E94A4498CC047[_id_D49285246B443066]))
    return level._id_DD7E94A4498CC047[_id_D49285246B443066];
  else
    return undefined;
}

_id_6FDBF71C8217CFC5(_id_D49285246B443066) {
  if(!_id_713174DA2F52DE61()) {
    return;
  }
  if(!_id_E4E9A069045BF808(_id_D49285246B443066)) {
    return;
  }
  if(_id_9FFFC56F57C8F7C8(_id_D49285246B443066)) {
    return;
  }
  if(!isDefined(self._id_0D932F46857D6D61))
    self._id_0D932F46857D6D61 = [];

  if(_id_92031FF8A97D9E90(_id_D49285246B443066)) {
    if(_id_2A5A6EC75498CAC6(_id_D49285246B443066)) {
      drop_type = _id_29A7CB456961B143(_id_D49285246B443066);

      if(isDefined(drop_type))
        _id_8C4C5C17F08FF6F0(drop_type);
    }

    self._id_0D932F46857D6D61[self._id_0D932F46857D6D61.size] = _id_D49285246B443066;
  }
}

_id_713174DA2F52DE61() {
  if(isDefined(self.unittype)) {
    switch (self.unittype) {
      case "dog":
        return 0;
      default:
        return 1;
    }
  } else
    return 0;
}

_id_9FFFC56F57C8F7C8(_id_D49285246B443066) {
  if(isDefined(self._id_0D932F46857D6D61)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_0D932F46857D6D61.size; _id_AC0E594AC96AA3A8++) {
      if(self._id_0D932F46857D6D61[_id_AC0E594AC96AA3A8] == _id_D49285246B443066)
        return 1;
    }
  }

  return 0;
}

_id_92031FF8A97D9E90(_id_D49285246B443066) {
  return isDefined(level._id_0D932F46857D6D61[_id_D49285246B443066]);
}

_id_2A5A6EC75498CAC6(_id_D49285246B443066) {
  return istrue(level._id_82482823A4BD9581[_id_D49285246B443066]);
}

_id_8C4C5C17F08FF6F0(_id_528B2FC70E7691CC) {
  if(isDefined(self._id_0D932F46857D6D61)) {
    _id_947ACE46408CFB9C = self._id_0D932F46857D6D61;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_947ACE46408CFB9C.size; _id_AC0E594AC96AA3A8++) {
      drop_type = _id_29A7CB456961B143(_id_947ACE46408CFB9C[_id_AC0E594AC96AA3A8]);

      if(isDefined(drop_type) && drop_type == _id_528B2FC70E7691CC)
        _id_8033AADB6558D0FE(_id_947ACE46408CFB9C[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_8033AADB6558D0FE(_id_D49285246B443066) {
  if(!isDefined(self._id_0D932F46857D6D61)) {
    return;
  }
  _id_6D906809844C7CB1 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_0D932F46857D6D61.size; _id_AC0E594AC96AA3A8++) {
    if(self._id_0D932F46857D6D61[_id_AC0E594AC96AA3A8] != _id_D49285246B443066)
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = self._id_0D932F46857D6D61[_id_AC0E594AC96AA3A8];
  }

  self._id_0D932F46857D6D61 = _id_6D906809844C7CB1;
}

_id_C568B761A7F0B678(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(self._id_0D932F46857D6D61)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_0D932F46857D6D61.size; _id_AC0E594AC96AA3A8++) {
      _id_B703F10AA66786B1 = self._id_0D932F46857D6D61[_id_AC0E594AC96AA3A8];

      if(isDefined(level._id_0D932F46857D6D61[_id_B703F10AA66786B1]) && _id_526976D2FD70521F(_id_B703F10AA66786B1)) {
        self._id_D0E9753B09126417 = _id_B703F10AA66786B1;

        if(self[[level._id_0D932F46857D6D61[_id_B703F10AA66786B1]]]())
          _id_0304333FF6B2313F(_id_B703F10AA66786B1);
      }
    }
  }
}

_id_E4E9A069045BF808(_id_D49285246B443066) {
  if(!scripts\cp\utility::coop_mode_has("agent_drops"))
    return 0;

  if(istrue(level._id_EA8AFF4B580B0B8D))
    return 0;

  return 1;
}

_id_B1C55038843DE38B() {
  if(isDefined(self._id_07C968C5609ADED2)) {
    _id_748A5B6E1EB008F5 = self._id_07C968C5609ADED2;
    self._id_07C968C5609ADED2++;
    return _id_748A5B6E1EB008F5;
  } else
    return 0;
}

_id_08CD9CA26D81FD9D() {
  amount = 100;
  drop_type = "brloot_plunder_cash_common_1";

  if(isDefined(self._id_D0E9753B09126417)) {
    switch (self._id_D0E9753B09126417) {
      case "headshot_cash":
        drop_type = "brloot_plunder_cash_uncommon_2";
        amount = 200;
        break;
      case "cash_drop_500":
        drop_type = "brloot_plunder_cash_uncommon_2";
        amount = 500;
        break;
      case "cash_drop_1000":
        drop_type = "brloot_plunder_cash_rare_1";
        amount = 1000;
        break;
      case "cash_drop_150":
        drop_type = "brloot_plunder_cash_uncommon_1";
        amount = 100;
        break;
      case "cash_drop_50":
      case "cash_drop_100":
      default:
        drop_type = "brloot_plunder_cash_common_1";
        amount = 100;
        break;
    }
  }

  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
  item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4, amount, 1, undefined, 1);
  return 1;
}

_id_E4BD43508C05C894() {
  _id_7643BB9BACEC0071 = _id_D7555674B07D6FC9();
  _id_6C5825B2E510A830 = _id_EE2A1706B8952B4C(_id_7643BB9BACEC0071);
  ammo_count = _id_9A9EB8E1438E9CB8();
  _id_9A2766C35B457773 = weighted_array_randomize(_id_7643BB9BACEC0071, _id_6C5825B2E510A830);
  _id_7643BB9BACEC0071 = scripts\engine\utility::array_remove(_id_7643BB9BACEC0071, _id_9A2766C35B457773);
  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);

  switch (_id_9A2766C35B457773) {
    case "brloot_ammo_762":
      item = _id_66122A002AFF5D57::spawnpickup("brloot_ammo_762", _id_CB4FAD49263E20C4, ammo_count[_id_9A2766C35B457773], 1, undefined, 1);
      break;
    case "brloot_ammo_rocket":
      item = _id_66122A002AFF5D57::spawnpickup("brloot_ammo_rocket", _id_CB4FAD49263E20C4, ammo_count[_id_9A2766C35B457773], 1, undefined, 1);
      break;
    case "brloot_ammo_919":
      item = _id_66122A002AFF5D57::spawnpickup("brloot_ammo_919", _id_CB4FAD49263E20C4, ammo_count[_id_9A2766C35B457773], 1, undefined, 1);
      break;
    case "brloot_ammo_50cal":
      item = _id_66122A002AFF5D57::spawnpickup("brloot_ammo_50cal", _id_CB4FAD49263E20C4, ammo_count[_id_9A2766C35B457773], 1, undefined, 1);
      break;
    case "brloot_ammo_12g":
      item = _id_66122A002AFF5D57::spawnpickup("brloot_ammo_12g", _id_CB4FAD49263E20C4, ammo_count[_id_9A2766C35B457773], 1, undefined, 1);
      break;
  }

  _id_7643BB9BACEC0071 = _id_D7555674B07D6FC9(_id_9A2766C35B457773);
  _id_6C5825B2E510A830 = _id_EE2A1706B8952B4C(_id_7643BB9BACEC0071);
  _id_730ABF41238D2467 = weighted_array_randomize(_id_7643BB9BACEC0071, _id_6C5825B2E510A830);
  _id_3238A12B980595E1 = int(_id_B843FBF56B48D7A5(_id_730ABF41238D2467) * 0.5);
  result = randomint(100) < _id_3238A12B980595E1;

  if(result) {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup(_id_730ABF41238D2467, _id_CB4FAD49263E20C4, ammo_count[_id_730ABF41238D2467], 1, undefined, 1);
    _id_0304333FF6B2313F(_id_730ABF41238D2467);
  }

  return 1;
}

_id_D7555674B07D6FC9(_id_65DDEA6C7E53503D) {
  if(isDefined(_id_65DDEA6C7E53503D)) {
    _id_7BBDA18A855C7111 = [];

    if(!isarray(_id_65DDEA6C7E53503D))
      _id_65DDEA6C7E53503D = [_id_65DDEA6C7E53503D];

    keys = getarraykeys(level._id_13503C3176B8B0B1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
      _id_DB40693DB52522E8 = 1;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_65DDEA6C7E53503D.size; _id_AC0E5C4AC96AAA41++) {
        if(keys[_id_AC0E594AC96AA3A8] == _id_65DDEA6C7E53503D[_id_AC0E5C4AC96AAA41]) {
          _id_DB40693DB52522E8 = 0;
          break;
        }
      }

      if(_id_DB40693DB52522E8)
        _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = keys[_id_AC0E594AC96AA3A8];
    }

    return _id_7BBDA18A855C7111;
  } else
    return getarraykeys(level._id_13503C3176B8B0B1);
}

_id_EE2A1706B8952B4C(_id_32137B56AF4C22DD) {
  _id_6C5825B2E510A830 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32137B56AF4C22DD.size; _id_AC0E594AC96AA3A8++) {
    rate = _id_D4D68B57453C54E0(_id_32137B56AF4C22DD[_id_AC0E594AC96AA3A8]);
    _id_6C5825B2E510A830[_id_6C5825B2E510A830.size] = rate;
  }

  return _id_6C5825B2E510A830;
}

_id_D4D68B57453C54E0(_id_25F2EBE6B0BCD6DC) {
  if(isDefined(level._id_020E9E1C4DA44B83[_id_25F2EBE6B0BCD6DC]) && level._id_020E9E1C4DA44B83[_id_25F2EBE6B0BCD6DC] >= 0)
    return level._id_020E9E1C4DA44B83[_id_25F2EBE6B0BCD6DC];
  else
    return level._id_13503C3176B8B0B1[_id_25F2EBE6B0BCD6DC];
}

_id_06CD80BE6451F285(_id_25F2EBE6B0BCD6DC, _id_3238A12B980595E1) {
  level._id_020E9E1C4DA44B83[_id_25F2EBE6B0BCD6DC] = _id_3238A12B980595E1;
}

_id_38924FB7672B340D(_id_D49285246B443066, _id_429F631E84274DD3) {
  if(isDefined(_id_429F631E84274DD3))
    level._id_365210DF3B94B112[_id_D49285246B443066] = _id_429F631E84274DD3;
  else
    level._id_365210DF3B94B112[_id_D49285246B443066] = 100;

  setDvar(_func_2EF675C13CA1C4AF("dvar_6E663FB6F8A19320", _id_D49285246B443066), level._id_365210DF3B94B112[_id_D49285246B443066]);
}

_id_77F5254D6847360B(_id_25F2EBE6B0BCD6DC) {
  _id_7643BB9BACEC0071 = _id_D7555674B07D6FC9();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7643BB9BACEC0071.size; _id_AC0E594AC96AA3A8++)
    _id_73A9FF1E1E7EF586(_id_7643BB9BACEC0071[_id_AC0E594AC96AA3A8]);
}

_id_73A9FF1E1E7EF586(_id_25F2EBE6B0BCD6DC) {
  _id_06CD80BE6451F285(_id_25F2EBE6B0BCD6DC, -1);
}

_id_9A9EB8E1438E9CB8() {
  ammo_count = [];
  ammo_count["brloot_ammo_762"] = 30;
  ammo_count["brloot_ammo_919"] = 25;
  ammo_count["brloot_ammo_50cal"] = 10;
  ammo_count["brloot_ammo_12g"] = 10;
  ammo_count["brloot_ammo_rocket"] = 1;
  return ammo_count;
}

_id_C530DE57DAFE4BD8(_id_D49285246B443066) {
  _id_E10D206E63187808 = _id_9A9EB8E1438E9CB8();

  if(isDefined(_id_E10D206E63187808[_id_D49285246B443066]))
    return _id_E10D206E63187808[_id_D49285246B443066];
  else
    return undefined;
}

_id_E5FBAAB3DA0AF6DE() {
  if(isDefined(self._id_D0E9753B09126417)) {
    _id_D49285246B443066 = self._id_D0E9753B09126417;
    amount = _id_C530DE57DAFE4BD8(_id_D49285246B443066);

    switch (_id_D49285246B443066) {
      case "brloot_ammo_rocket":
      case "brloot_ammo_50cal":
      case "brloot_ammo_12g":
      case "brloot_ammo_919":
      case "brloot_ammo_762":
        break;
      case "brloot_ammo_rocket_rpg_ai":
        _id_D49285246B443066 = "brloot_ammo_rocket";
        amount = 1;
        _id_0304333FF6B2313F(_id_D49285246B443066);
        break;
    }

    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup(_id_D49285246B443066, _id_CB4FAD49263E20C4, amount, 1, undefined, 1);
    return 1;
  } else
    return 0;
}

_id_8F956DE778C73E8E() {
  _id_3238A12B980595E1 = getdvarint("dvar_5372D188BBF813AC", 10);

  if(randomint(100) <= _id_3238A12B980595E1) {
    drop_type = "brloot_armor_plate";
    amount = 1;
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4, amount, 1, undefined, 1);
    return 1;
  } else
    return 0;
}

_id_9EEC29E4018E3BD9() {
  if(isDefined(self._id_D0E9753B09126417)) {
    _id_D49285246B443066 = "brloot_powerup_ammo";
    amount = 1;
    _id_A5B2C541413AA895 = 1;
    _id_3238A12B980595E1 = getdvarint("dvar_05B1597CF9406744", 5);

    switch (self._id_D0E9753B09126417) {
      case "brloot_powerup_ammo":
        _id_D49285246B443066 = "brloot_powerup_ammo";
        amount = 1;
        break;
      case "brloot_powerup_equipment":
        _id_D49285246B443066 = scripts\engine\utility::random(["brloot_offhand_claymore", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite", "brloot_offhand_throwingknife"]);
        _id_A5B2C541413AA895 = 0;
        amount = 4;
        break;
      case "brloot_powerup_armor":
        _id_D49285246B443066 = "brloot_powerup_armor";
        amount = 1;
        break;
      case "brloot_armor_plate":
        _id_D49285246B443066 = "brloot_armor_plate";
        amount = 1;
        _id_A5B2C541413AA895 = getdvarint("dvar_9925F8AD1812F844", 1);
        break;
    }

    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup(_id_D49285246B443066, _id_CB4FAD49263E20C4, amount, 0, undefined, _id_A5B2C541413AA895);
    return 1;
  }

  return 0;
}

_id_3EEB69D40AD71F2B() {
  if(isDefined(self._id_D0E9753B09126417)) {
    amount = 4;
    _id_D49285246B443066 = self._id_D0E9753B09126417;
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_B1C55038843DE38B(), self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup(_id_D49285246B443066, _id_CB4FAD49263E20C4, amount, 0, undefined, 0);
    return 1;
  }

  return 0;
}

weighted_array_randomize(array, weights) {
  _id_13ACBD53528ED1FF = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weights.size; _id_AC0E594AC96AA3A8++)
    _id_13ACBD53528ED1FF = _id_13ACBD53528ED1FF + weights[_id_AC0E594AC96AA3A8];

  random_weight = randomfloat(_id_13ACBD53528ED1FF);
  _id_98ABCC65D2B0707D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_98ABCC65D2B0707D = _id_98ABCC65D2B0707D + weights[_id_AC0E594AC96AA3A8];

    if(_id_98ABCC65D2B0707D >= random_weight)
      return array[_id_AC0E594AC96AA3A8];
  }
}