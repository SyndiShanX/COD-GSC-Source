/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\sealion_sidequest_chance_machine.gsc
***************************************************************************/

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
  if(!getdvarint("dvar_CE24BD30C03C5439", 0)) {
    return;
  }
  _id_618A1163576C3819();
  _id_43F3DE04ECBC94D4();
  _id_72132D53E4D2D267();
}

_id_618A1163576C3819() {
  level._id_919355D284B706D6 = spawnStruct();
}

_id_43F3DE04ECBC94D4() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("sealion_chance_machine", ::_id_38537C9B8626C08E);

  switch (level.mapname) {
    case "mp_sealion":
      spawnscriptable("sealion_chance_machine", (-7418, 1849, 522), (0, 83, 0));
      spawnscriptable("sealion_chance_machine", (4763, -12984, 575), (0, 287, 0));
      spawnscriptable("sealion_chance_machine", (152, 3992, 450), (0, 44, 0));
      spawnscriptable("sealion_chance_machine", (-16134, -2008.25, 408), (0, 269.525, 0));
      spawnscriptable("sealion_chance_machine", (-7958, -10010.8, 504), (0, 120.471, 0));
      spawnscriptable("sealion_chance_machine", (5073.5, -5253.75, 1020), (0, 179.919, 0));
      break;
    default:
      spawnscriptable("sealion_chance_machine", (-200, 100, 0));
      spawnscriptable("sealion_chance_machine", (-200, -100, 0));
      break;
  }
}

_id_72132D53E4D2D267() {
  _id_2C238DF86481AFEE("brloot_armor_plate", 3, 0.15);
  _id_2C238DF86481AFEE("ammo", 3, 0.3);
  _id_2C238DF86481AFEE("offhand", 2, 0.4);
  _id_2C238DF86481AFEE("armor_n_ammo", 2, 0.5);
  _id_2C238DF86481AFEE("armor_n_ammo", 3, 0.65);
  _id_2C238DF86481AFEE("super", 1, 0.75);
  _id_2C238DF86481AFEE("super", 2, 0.85);
  _id_2C238DF86481AFEE("killstreak", 1, 0.95);
  _id_2C238DF86481AFEE("jackpot", 1, 1.0);
  level._id_919355D284B706D6._id_0C26A74144A76F1D = ["low_wep", "low_wep", "low_wep", "brloot_offhand_throwstar", "brloot_offhand_frag", "brloot_offhand_flash", "brloot_offhand_smoke", "brloot_offhand_semtex", "brloot_offhand_molotov", "brloot_offhand_c4"];
  level._id_919355D284B706D6._id_B7DE73DE17FB0935 = ["brloot_killstreak_precision_airstrike", "brloot_killstreak_clusterstrike", "brloot_killstreak_scramblerdrone", "brloot_killstreak_uav", "high_wep"];
  level._id_919355D284B706D6._id_7C7B046A6B9536FC = ["brloot_super_munitionsbox", "brloot_super_armorbox", "brloot_super_stimpistol", "brloot_super_battlerage", "brloot_super_sonarpulse"];
  level._id_919355D284B706D6._id_CA826649F8BA23A3 = ["high_wep"];

  if(getdvarint("dvar_9264F8F1143934C6", 0) && _id_55E418C5CC946593::_id_2980F22FB01F43E6())
    level._id_919355D284B706D6._id_CA826649F8BA23A3 = scripts\engine\utility::array_add(level._id_919355D284B706D6._id_CA826649F8BA23A3, "perk_pack");

  if(getdvarint("dvar_368EA569C1A6A4E4", 1))
    level._id_919355D284B706D6._id_CA826649F8BA23A3 = scripts\engine\utility::array_add(level._id_919355D284B706D6._id_CA826649F8BA23A3, "plate_carrier");
}

_id_2C238DF86481AFEE(_id_DB35956D84816F27, quantity, _id_41BF2837650DA882) {
  if(!isDefined(level._id_919355D284B706D6._id_9AE73EADB4804B94))
    level._id_919355D284B706D6._id_9AE73EADB4804B94 = [];

  level._id_919355D284B706D6._id_9AE73EADB4804B94[level._id_919355D284B706D6._id_9AE73EADB4804B94.size] = _id_6C2920A725D40891(_id_DB35956D84816F27, quantity, _id_41BF2837650DA882);
}

_id_6C2920A725D40891(_id_DB35956D84816F27, quantity, _id_41BF2837650DA882) {
  _id_92884735D8E33FBB = spawnStruct();
  _id_92884735D8E33FBB._id_DB35956D84816F27 = _id_DB35956D84816F27;
  _id_92884735D8E33FBB.quantity = quantity;
  _id_92884735D8E33FBB._id_41BF2837650DA882 = _id_41BF2837650DA882;
  return _id_92884735D8E33FBB;
}

_id_38537C9B8626C08E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(level._id_919355D284B706D6._id_12336ACB4323F318))
    level._id_919355D284B706D6._id_12336ACB4323F318 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_sealion_chance_token");

  _id_D32622B1A8442C5F = 0;

  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player); _id_A6F8D8115E0F1E79++) {
    quantity = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_A6F8D8115E0F1E79);
    lootid = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(quantity > 0 && lootid == level._id_919355D284B706D6._id_12336ACB4323F318)
      _id_D32622B1A8442C5F = _id_D32622B1A8442C5F + quantity;
  }

  if(_id_D32622B1A8442C5F < 1) {
    instance setscriptablepartstate(instance.type, "denied");
    instance scripts\engine\utility::delaycall(0.5, ::setscriptablepartstate, instance.type, "usable");
    return;
  }

  player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(level._id_919355D284B706D6._id_12336ACB4323F318, 1);
  player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_41E48CAAD74271B4");
  instance thread _id_1FD010598D202C71(player);
}

_id_1FD010598D202C71(player) {
  self setscriptablepartstate(self.type, "playing");
  wait 1.5;
  _id_03FD97D05418814C = randomfloatrange(0, 1);
  _id_4A6093FE94F62563 = "";
  _id_6DE063FA5C68CA27 = 0;

  foreach(_id_F90358454413407F in level._id_919355D284B706D6._id_9AE73EADB4804B94) {
    if(_id_03FD97D05418814C <= _id_F90358454413407F._id_41BF2837650DA882) {
      _id_4A6093FE94F62563 = _id_F90358454413407F._id_DB35956D84816F27;
      _id_6DE063FA5C68CA27 = _id_F90358454413407F.quantity;
      break;
    }
  }

  if(!isDefined(self._id_F5246583F81E13B0))
    self._id_F5246583F81E13B0 = self.origin + anglesToForward(self.angles) * 20;

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_6CFFF609F6B840F5 = "loss";

  switch (_id_4A6093FE94F62563) {
    case "brloot_armor_plate":
      _id_F9992DF3250B2A45(player, _id_6DE063FA5C68CA27, dropstruct);
      break;
    case "ammo":
      _id_38AC32FF19ADBE52(player, _id_6DE063FA5C68CA27, dropstruct);
      break;
    case "armor_n_ammo":
      _id_38AC32FF19ADBE52(player, _id_6DE063FA5C68CA27, dropstruct);
      _id_F9992DF3250B2A45(player, _id_6DE063FA5C68CA27, dropstruct);
      break;
    case "offhand":
      _id_6CFFF609F6B840F5 = "win";

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6DE063FA5C68CA27; _id_AC0E594AC96AA3A8++) {
        lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_919355D284B706D6._id_0C26A74144A76F1D);

        if(lootid == "low_wep")
          lootid = pickscriptablelootitem("weapon", 2, 2, "mp/loot/br/default/lootset_cache_lege.csv");

        _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
        _id_920F4173513EB6B8 = _id_7E52B56769FA7774::spawnpickup(lootid, _id_CB4FAD49263E20C4, undefined, 1);

        if(isDefined(level.br_lootiteminfo[lootid])) {
          weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(lootid);
          _id_920F4173513EB6B8.count = weaponclipsize(weapon);
        }
      }

      break;
    case "super":
      _id_6CFFF609F6B840F5 = "win";

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6DE063FA5C68CA27; _id_AC0E594AC96AA3A8++) {
        lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_919355D284B706D6._id_7C7B046A6B9536FC);
        _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
        _id_920F4173513EB6B8 = _id_7E52B56769FA7774::spawnpickup(lootid, _id_CB4FAD49263E20C4, undefined, 1);

        if(isDefined(level.br_lootiteminfo[lootid])) {
          weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(lootid);
          _id_920F4173513EB6B8.count = weaponclipsize(weapon);
        }
      }

      break;
    case "killstreak":
      _id_6CFFF609F6B840F5 = "jackpot";
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2559C2D4EAA7AA30");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6DE063FA5C68CA27; _id_AC0E594AC96AA3A8++) {
        lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_919355D284B706D6._id_B7DE73DE17FB0935);

        if(lootid == "high_wep")
          lootid = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");

        _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
        _id_920F4173513EB6B8 = _id_7E52B56769FA7774::spawnpickup(lootid, _id_CB4FAD49263E20C4, undefined, 1);

        if(isDefined(level.br_lootiteminfo[lootid])) {
          weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(lootid);
          _id_920F4173513EB6B8.count = weaponclipsize(weapon);
        }
      }

      break;
    case "jackpot":
      _id_6CFFF609F6B840F5 = "jackpot";
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2559C2D4EAA7AA30");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6DE063FA5C68CA27; _id_AC0E594AC96AA3A8++) {
        lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_919355D284B706D6._id_CA826649F8BA23A3);

        if(lootid == "high_wep")
          lootid = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
        else if(lootid == "perk_pack")
          lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(["brloot_perkpack_beret_br", "brloot_perkpack_insurgent_br", "brloot_perkpack_demolitionist_br", "brloot_perkpack_reserves_br", "brloot_perkpack_swat_br"]);
        else if(lootid == "plate_carrier")
          lootid = scripts\engine\utility::_id_7A2AAA4A09A4D250(["brloot_plate_carrier_tempered"]);

        _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
        _id_920F4173513EB6B8 = _id_7E52B56769FA7774::spawnpickup(lootid, _id_CB4FAD49263E20C4, undefined, 1);

        if(isDefined(level.br_lootiteminfo[lootid])) {
          weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(lootid);
          _id_920F4173513EB6B8.count = weaponclipsize(weapon);
        }
      }

      break;
    default:
      if(_id_4A6093FE94F62563 != "brloot_armor_plate")
        _id_6CFFF609F6B840F5 = "win";

      _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
      _id_7E52B56769FA7774::spawnpickup(_id_4A6093FE94F62563, _id_CB4FAD49263E20C4, undefined, 1);
      break;
  }

  self setscriptablepartstate(self.type, _id_6CFFF609F6B840F5);
  wait 3;
  self setscriptablepartstate(self.type, "usable");
}

_id_F9992DF3250B2A45(player, _id_0CE1BD3FDF0FCECF, dropstruct) {
  _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
  _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4, _id_0CE1BD3FDF0FCECF, 1);
}

_id_38AC32FF19ADBE52(player, _id_0CE1BD3FDF0FCECF, dropstruct) {
  _id_92D8A509637FB29B = _id_724736FCF0FB6604::br_ammo_type_for_weapon(player.lastdroppableweaponobj);

  if(!isDefined(_id_92D8A509637FB29B))
    _id_92D8A509637FB29B = "brloot_ammo_762";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0CE1BD3FDF0FCECF; _id_AC0E594AC96AA3A8++) {
    _id_CB4FAD49263E20C4 = _id_271B817BB062520B(dropstruct);
    _id_7E52B56769FA7774::spawnpickup(_id_92D8A509637FB29B, _id_CB4FAD49263E20C4, undefined, 1);
  }
}

_id_271B817BB062520B(dropstruct) {
  _id_46868F52B4CDE86C = scripts\engine\utility::ter_op(istrue(self._id_9309B5986908525F), randomfloatrange(40, 55), level.br_pickups._id_3B53BC0EEE6AE84E);
  return _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self._id_F5246583F81E13B0, self.angles, undefined, level.br_pickups._id_AD49A38DD7C4C10F, _id_46868F52B4CDE86C);
}