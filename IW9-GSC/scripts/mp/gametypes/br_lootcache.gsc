/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootcache.gsc
*************************************************/

brlootcache_init() {
  _id_BB85AADE9D4A5515(_id_104E3370B024F998::_id_988143193CD6A03A);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::lootcacheused);
}

canspawnitemname(itemname, iscustomweapon) {
  if(istrue(iscustomweapon))
    itemname = _id_2669878CF5A1B6BC::getweaponrootname(itemname);

  if(!isDefined(itemname))
    return 0;

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    if(isDefined(level.forbiddencachespawns) && isDefined(level.forbiddencachespawns[itemname]))
      return 0;
  }

  if(_id_600B944A95C3A7BF::_id_9CA10C69808B00A5(itemname))
    return 0;

  if(itemname == "brloot_respawn_token" && _id_7E52B56769FA7774::respawntokendisabled())
    return 0;

  if(itemname == "brloot_gulag_token" && _id_2CEDCC356F1B9FC8::_id_8B2396647673BE50())
    return 0;

  if(itemname == "brloot_zmb_stim" && _id_2695A20D4011076D::_id_024C5A8D31AE262F(self.origin))
    return 0;

  if((itemname == "brloot_redeploy_token" || itemname == "brloot_gulag_token") && istrue(level.br_pickups._id_EC8ACC2CB92CEAF7))
    return 0;

  _id_04AD7C03EC4FA687 = level.maxteamsize == 1 || istrue(level.brgametype._id_04AD7C03EC4FA687);

  if(itemname == "brloot_super_reinforcementflare" && _id_04AD7C03EC4FA687)
    return 0;

  return 1;
}

lootspawnitem(itemname, dropstruct, origin, angles, _id_4EDDEDC3311EDE0D, _id_3F237137640BEDCE, _id_3BBE1192172D43FD, _id_77BD0639072486AC, _id_CD2354197D18F1CD) {
  if(istrue(_id_4EDDEDC3311EDE0D)) {
    if(dropstruct.dropcount % 2 > 0)
      yaw = 75;
    else
      yaw = 115;

    if(isDefined(_id_CD2354197D18F1CD)) {
      yaw = _id_CD2354197D18F1CD;

      if(dropstruct.dropcount % 2 > 0)
        yaw = yaw - 40;
    }

    if(istrue(_id_77BD0639072486AC))
      yaw = yaw + randomfloatrange(-1 * _id_77BD0639072486AC, _id_77BD0639072486AC);
    else
      yaw = yaw + randomfloatrange(-10, 10);

    if(istrue(_id_3BBE1192172D43FD))
      dist = 35 + dropstruct.dropcount / 2 * 25 + randomfloatrange(-1 * _id_3BBE1192172D43FD, _id_3BBE1192172D43FD);
    else
      dist = 35 + dropstruct.dropcount / 2 * 25 + randomfloatrange(-5, 5);

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, angles, undefined, yaw, dist);
  } else
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, angles);

  _id_EB545D149EFBFD23 = undefined;
  _id_37DDA6C5E1DABEFA = undefined;

  if(_id_724736FCF0FB6604::isvalidcustomweapon(itemname)) {
    weaponname = getcompleteweaponname(itemname);
    dropcount = _id_724736FCF0FB6604::br_getweaponstartingclipammo(itemname);

    if(scripts\mp\utility\weapon::isakimbo(itemname))
      _id_EB545D149EFBFD23 = dropcount;

    if(itemname.hasalternate) {
      _id_BE014A8D5A4F68F4 = itemname getaltweapon();
      _id_37DDA6C5E1DABEFA = int(min(weaponclipsize(_id_BE014A8D5A4F68F4), dropcount));
    }

    _id_AD30CE892002A2B2 = _id_7E52B56769FA7774::spawnpickup(weaponname, _id_CB4FAD49263E20C4, dropcount, 1, itemname, undefined, _id_EB545D149EFBFD23, _id_37DDA6C5E1DABEFA);
  } else {
    dropcount = level.br_pickups.counts[itemname];
    fullweaponobj = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(itemname);

    if(isDefined(fullweaponobj)) {
      dropcount = _id_724736FCF0FB6604::br_getweaponstartingclipammo(fullweaponobj);

      if(scripts\mp\utility\weapon::isakimbo(fullweaponobj))
        _id_EB545D149EFBFD23 = dropcount;

      if(fullweaponobj.hasalternate) {
        _id_BE014A8D5A4F68F4 = fullweaponobj getaltweapon();
        _id_37DDA6C5E1DABEFA = int(min(weaponclipsize(_id_BE014A8D5A4F68F4), dropcount));
      }
    }

    _id_AD30CE892002A2B2 = _id_7E52B56769FA7774::spawnpickup(itemname, _id_CB4FAD49263E20C4, dropcount, 1, undefined, undefined, _id_EB545D149EFBFD23, _id_37DDA6C5E1DABEFA);
    _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[itemname];
  }

  if(_id_3F237137640BEDCE) {}

  return _id_AD30CE892002A2B2;
}

_id_D683A60016231237(lootid, quantity, ref) {
  if(!isDefined(self.contents))
    self.contents = _id_EC87B214CD429E96(getscriptablelootcachecontents(self));

  self.contents = scripts\engine\utility::array_randomize(_id_848E20CF1D6CAB8F(self.contents, quantity, lootid, ref));
}

_id_848E20CF1D6CAB8F(contents, quantity, lootid, ref, _id_A6F8D8115E0F1E79) {
  if(!isDefined(_id_A6F8D8115E0F1E79))
    _id_A6F8D8115E0F1E79 = contents.size;

  contents[_id_A6F8D8115E0F1E79] = [];
  contents[_id_A6F8D8115E0F1E79]["quantity"] = int(quantity);
  contents[_id_A6F8D8115E0F1E79]["lootID"] = lootid;

  if(isDefined(ref) && _id_7E52B56769FA7774::isweaponpickup(ref))
    contents[_id_A6F8D8115E0F1E79]["ref"] = ref;

  return contents;
}

_id_EC87B214CD429E96(items, _id_3D7259162C4253EA) {
  contents = [];

  if(isDefined(_id_3D7259162C4253EA))
    contents = _id_3D7259162C4253EA;

  if(isDefined(items)) {
    _id_48E9C0F948129A0C = contents.size;

    for(index = 0; index < items.size - _id_48E9C0F948129A0C; index++) {
      item = items[index];
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(item);
      quantity = 1;

      if(isDefined(level.br_pickups.counts[item]))
        quantity = level.br_pickups.counts[item];

      if(!isDefined(lootid)) {
        if(item == "brloot_armor_plate")
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_plate");
        else if(_id_7E52B56769FA7774::_id_4294E9B331377C31(item))
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_satchel");
        else if(_id_7E52B56769FA7774::isplunder(item)) {
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("cash");
          quantity = level.br_pickups.counts[item];
        } else if(_id_2CEDCC356F1B9FC8::isammo(item) || item == "brloot_self_revive") {
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(item);
          quantity = level.br_pickups.counts[item];
        }
      }

      contents = _id_848E20CF1D6CAB8F(contents, quantity, lootid, item);
    }

    contents = scripts\engine\utility::array_randomize(contents);
  }

  return contents;
}

_id_EC8712F07ED15E07(player, items, _id_3D7259162C4253EA, _id_69E96A4CAA72D794) {
  contents = _id_EC87B214CD429E96(items, _id_3D7259162C4253EA);

  if(isDefined(_id_69E96A4CAA72D794._id_E0AEA15595ECF1A9)) {
    foreach(guid, _id_D89286DB53D9FE8A in _id_69E96A4CAA72D794._id_E0AEA15595ECF1A9) {
      foreach(item in _id_D89286DB53D9FE8A)
      contents = _id_848E20CF1D6CAB8F(contents, item["quantity"], item["lootID"], item["ref"]);

      _id_69E96A4CAA72D794._id_556DB0B72A96514E[guid].contents = contents;
      _id_69E96A4CAA72D794._id_E0AEA15595ECF1A9[guid] = undefined;
    }
  }
}

_id_9065B3738AC07DF0(items, _id_B038ED928EC17A81, player, contents) {
  if(scripts\mp\loot::_id_E3081772BBF7A51C(player, _id_B038ED928EC17A81))
    _id_EC8712F07ED15E07(player, items, contents, _id_B038ED928EC17A81);
  else
    _id_B038ED928EC17A81.contents = _id_EC87B214CD429E96(items, contents);

  _id_00400B0F96946B53 = scripts\mp\loot::_id_59B9C8081B873A10(player, _id_B038ED928EC17A81);

  if(isDefined(_id_00400B0F96946B53.contents))
    _id_B038ED928EC17A81._id_9632642B41DAD704 = _id_00400B0F96946B53.contents;

  scripts\mp\loot::_id_30F5EA60517F9E06(player, _id_B038ED928EC17A81);
  return [];
}

lootspawnitemlist(dropstruct, items, _id_A6293F3144240B99, player, _id_3BBE1192172D43FD, _id_77BD0639072486AC) {
  _id_E05413A53B5D9167 = [];
  _id_17B34CF2DD66912F = 0;

  if(isDefined(items) && isDefined(items[0]) && isarray(items[0])) {
    _id_E9E9E4F0D28D6357 = [];

    foreach(item in items) {
      if(isDefined(item["lootID"])) {
        scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(item["lootID"]);
        _id_E9E9E4F0D28D6357[_id_E9E9E4F0D28D6357.size] = scriptable;
      }
    }

    items = _id_E9E9E4F0D28D6357;
  }

  if(isDefined(self) && isDefined(self.type) && scripts\cp_mp\utility\script_utility::issharedfuncdefined(self.type, "spawnLoot")) {
    _id_EB061C2E39F5D6F7 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(self.type, "spawnLoot", player, dropstruct);

    if(isDefined(_id_EB061C2E39F5D6F7)) {
      foreach(_id_DB009605FE48BC5E in _id_EB061C2E39F5D6F7)
      _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = _id_DB009605FE48BC5E;
    }
  }

  _id_4472B62C1FA150E5 = 0;
  _id_07DEFD476665A5C0 = 0;
  _id_1A51B8DD1E3A0296 = 0;
  _id_7F6DC80424E55D7B = isDefined(player) && !player _id_2CEDCC356F1B9FC8::playeriszombie() && _id_E1A934067BB5BC35(self);
  [_id_822C11116211822F, _id_96FE9D369E45B9DE] = _id_CB377A5E11EEF62C(self, player);
  _id_96FE9D369E45B9DE = scripts\engine\utility::ter_op(isDefined(_id_96FE9D369E45B9DE), _id_96FE9D369E45B9DE, self.origin);

  foreach(itemname in items) {
    iscustomweapon = _id_724736FCF0FB6604::isvalidcustomweapon(itemname);

    if(canspawnitemname(itemname, iscustomweapon)) {
      if(_id_7F6DC80424E55D7B && _id_7E52B56769FA7774::isplunder(itemname)) {
        amount = level.br_pickups.counts[itemname];

        if(isDefined(amount)) {
          player _id_6AFF3948CF4CCA03::playerplunderpickup(amount, undefined, undefined, 1);
          player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(0, amount);
          _id_1A51B8DD1E3A0296 = _id_1A51B8DD1E3A0296 + amount;
        }

        continue;
      }

      _id_A69FFF5222862F26 = undefined;

      if(!iscustomweapon)
        _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[itemname];

      if(isDefined(_id_A69FFF5222862F26) && _id_A69FFF5222862F26 == 4 && _id_17B34CF2DD66912F == 0) {
        if(isDefined(_id_3BBE1192172D43FD) || isDefined(_id_77BD0639072486AC)) {
          if(!isDefined(_id_3BBE1192172D43FD))
            _id_3BBE1192172D43FD = 5;

          if(!isDefined(_id_77BD0639072486AC))
            _id_77BD0639072486AC = 10;

          _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, _id_96FE9D369E45B9DE, self.angles, _id_A6293F3144240B99, 1, _id_3BBE1192172D43FD, _id_77BD0639072486AC, _id_822C11116211822F);
          self.itemsdropped++;
          _id_17B34CF2DD66912F = 1;
        } else {
          _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, _id_96FE9D369E45B9DE, self.angles, _id_A6293F3144240B99, 1, undefined, undefined, _id_822C11116211822F);
          self.itemsdropped++;
          _id_17B34CF2DD66912F = 1;
        }
      } else if(isDefined(_id_3BBE1192172D43FD) || isDefined(_id_77BD0639072486AC)) {
        if(!isDefined(_id_3BBE1192172D43FD))
          _id_3BBE1192172D43FD = 5;

        if(!isDefined(_id_77BD0639072486AC))
          _id_77BD0639072486AC = 10;

        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, _id_96FE9D369E45B9DE, self.angles, _id_A6293F3144240B99, 0, _id_3BBE1192172D43FD, _id_77BD0639072486AC, _id_822C11116211822F);
        self.itemsdropped++;
      } else {
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, _id_96FE9D369E45B9DE, self.angles, _id_A6293F3144240B99, 0, undefined, undefined, _id_822C11116211822F);
        self.itemsdropped++;
      }

      if(!_id_4472B62C1FA150E5 && istrue(_id_A6293F3144240B99) && !iscustomweapon)
        _id_4472B62C1FA150E5 = _id_2CEDCC356F1B9FC8::_id_63D8455B2C1455EB(itemname);

      if(iscustomweapon) {
        _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(itemname);

        if(isDefined(_id_811ABFDB6C33F17F)) {
          _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(_id_811ABFDB6C33F17F, dropstruct, _id_96FE9D369E45B9DE, self.angles, _id_A6293F3144240B99, 0, undefined, undefined, _id_822C11116211822F);
          self.itemsdropped++;
        }

        _id_07DEFD476665A5C0 = 1;
      }
    }
  }

  if(_id_1A51B8DD1E3A0296 > 0 && istrue(level._id_9DD3CE936C1DEC1D)) {
    plunder = spawnStruct();
    plunder.origin = player.origin;
    plunder.count = _id_1A51B8DD1E3A0296;
    plunder.scriptablename = _id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC("cash");

    if(isDefined(plunder.scriptablename))
      player _id_7E52B56769FA7774::_id_EFDDDF60C5DB058C(plunder, 0);
  }

  if(_id_8C57777A730CA632(self) && isDefined(self.owner)) {
    foreach(item in _id_E05413A53B5D9167)
    self.owner _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(item);

    if(isDefined(self._id_04F6CDE716E0C3D7) && isDefined(self._id_6FB67C8525B1D79E)) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles);
      _id_C9614496B843196E = _id_724736FCF0FB6604::weaponspawn(self._id_6FB67C8525B1D79E, self.owner, _id_CB4FAD49263E20C4, 0, 1);

      if(isDefined(_id_C9614496B843196E)) {
        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(self._id_6FB67C8525B1D79E);
        _id_C9614496B843196E.ammotype = ammotype;
        _id_7E52B56769FA7774::loot_setitemcount(_id_C9614496B843196E, self._id_3EF503345DC57957, self._id_00AD7897ECDBCB63, self._id_86B32AFF94B5714E);
      }

      self.owner _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(_id_C9614496B843196E);
      self._id_04F6CDE716E0C3D7 = undefined;
      self._id_6FB67C8525B1D79E = undefined;
    }

    self.contents = [];
  }

  if(istrue(_id_A6293F3144240B99) && isDefined(player)) {
    if(_id_4472B62C1FA150E5) {
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F396D39FEE1A8054");
      player playsoundtoplayer("uin_loot_container_open_epic", player);
    } else if(_id_07DEFD476665A5C0) {
      foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
        if(isalive(_id_B2810E8D06E0A042) && distance2d(_id_B2810E8D06E0A042.origin, player.origin) <= 1000)
          _id_B2810E8D06E0A042 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C01D7D8B6119D321");
      }

      player playsoundtoplayer("uin_loot_container_open_epic", player);
    } else {
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C19301D569C97C3C");
      player playsoundtoplayer("uin_loot_container_open_common", player);
    }
  }

  return _id_E05413A53B5D9167;
}

lootcachespawncontents(items, _id_7A824904D97D59D7, player, contents) {
  if(_id_7A824904D97D59D7)
    return _id_9065B3738AC07DF0(items, self, player, contents);
  else {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    return lootspawnitemlist(dropstruct, items, 1, player);
  }
}

lootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, _id_9F39A1D0187CEFB8) {
  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }
  _id_64C59C08B4538D72 = scripts\mp\loot::_id_55B384ECB923003E() && !_id_E91A96D043315490(instance) && scripts\mp\loot::_id_C929A8AD95B46FDA(instance);

  if(istrue(player.isjuggernaut) && _id_64C59C08B4538D72)
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
  else {
    if(!istrue(_id_9F39A1D0187CEFB8)) {}

    if((state == "closed_usable" || state == "closed_usable_no_collision") && !isDefined(instance.entity)) {
      if(_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
        _id_F75061432D4C00A7(instance, player);

      if(isDefined(instance._id_534E0CF170A981B7)) {
        result = [[instance._id_534E0CF170A981B7]](instance, player);

        if(isDefined(result) && result == 0)
          return;
      }

      if(!scripts\mp\loot::_id_E3081772BBF7A51C(player, instance)) {
        if(_id_64C59C08B4538D72 && instance getscriptableparthasstate(part, "partially_opening_unusable"))
          instance setscriptablepartstate(part, "partially_opening_unusable");
        else if(instance getscriptableparthasstate(part, "closed_to_fully_open_unusable"))
          instance setscriptablepartstate(part, "closed_to_fully_open_unusable");
        else if(instance getscriptableparthasstate(part, "fully_opening_unusable"))
          instance setscriptablepartstate(part, "fully_opening_unusable");
      }

      instance.itemsdropped = 0;
      _id_E05413A53B5D9167 = [];
      items = undefined;

      if(isDefined(instance.type) && instance.type == "br_loot_cache_personal_supply") {
        _id_2B751927C89F66B5 = ["custom1", "custom2", "custom3", "custom4", "custom5", "custom6", "custom7", "custom8", "custom9", "custom10"];
        _id_67765E10502FCD44 = player getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");

        if(isDefined(_id_67765E10502FCD44)) {
          _id_67765E10502FCD44 = _id_2B751927C89F66B5[_id_67765E10502FCD44];
          _id_990BF19E67EC2D89 = player thread _id_1E4A61DB11011446::_id_4043E420432F59F0(_id_67765E10502FCD44);
          _id_DD8A980F1D3213E5 = player _id_75E83820A58A07C9(_id_990BF19E67EC2D89);
          items = [];

          foreach(weapon in _id_DD8A980F1D3213E5)
          items[items.size] = weapon;
        }
      } else if(scripts\mp\loot::_id_E3081772BBF7A51C(player, instance) && instance._id_556DB0B72A96514E[player.guid].contents.size > 0)
        items = scripts\mp\loot::_id_3C85CBBFD2D2A3DA(player, instance);
      else if(isDefined(instance.contents) && !_id_AE639176FEC476A6(instance))
        items = instance.contents;
      else {
        if(_id_AE639176FEC476A6(instance)) {
          instance _id_EF853AD16B5319E6();
          items = instance.contents;
        } else
          items = getscriptablelootcachecontents(instance);

        if(!isDefined(items)) {
          return;
        }
        if(isDefined(instance._id_2E1A29FB688816D4))
          items[items.size] = instance._id_2E1A29FB688816D4;

        instance._id_2E1A29FB688816D4 = undefined;
        items = _id_728BDC627D7DF6C2(items, instance);
        items = _id_583266F1450C18C6(items, instance);

        if(isDefined(instance.type) && scripts\cp_mp\utility\script_utility::issharedfuncdefined(instance.type, "opened"))
          items = instance scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(instance.type, "opened", items, player, _id_64C59C08B4538D72);

        if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("lootCacheAdjustItems"))
          items = _id_362C58E8BB39BCDA::runbrgametypefunc("lootCacheAdjustItems", items, instance);

        if(player scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance"))
          items = lootcontentsadjustkillchain(items, player);

        if(getdvarint("dvar_F925D53A2A478522", 1) && (getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")) {
          if(scripts\mp\flags::gameflag("placement_updates_allowed")) {
            placement = game["teamPlacements"][player.team];

            if(!isDefined(level._id_153F283BCBFFA477))
              scripts\mp\utility\teams::calculatenumteamswithplayers();

            _id_777FC6D644BB8864 = 100 - 100 * placement / level._id_153F283BCBFFA477;

            if(isDefined(level.bottompercentagetoadjusteconomy) && _id_777FC6D644BB8864 < level.bottompercentagetoadjusteconomy)
              items = lootcontentsadjusteconomy_bottomtier(instance, items);
            else if(isDefined(level.toppercentagetoadjusteconomy) && _id_777FC6D644BB8864 > level.toppercentagetoadjusteconomy)
              items = lootcontentsadjusteconomy_toptier(instance, items);
          }
        }

        if(isDefined(level.maxaccesscardspawns_red))
          items = lootcontentsadjust_accesscardsred(items);
      }

      if(_id_6759FF16E552AA94(instance) || _id_8C57777A730CA632(instance))
        player playsoundtoplayer("open_backpack", player);

      if(!isDefined(instance._id_46A3A8565AC0C17C))
        instance._id_46A3A8565AC0C17C = 3;

      _id_4E2B4A3E39B84D99 = level.teamdata[player.team]["activeSupplySweeps"];

      if(isDefined(_id_4E2B4A3E39B84D99)) {
        foreach(streakinfo in _id_4E2B4A3E39B84D99) {
          if(isDefined(streakinfo) && streakinfo.owner != player)
            streakinfo.owner thread scripts\mp\utility\points::giveunifiedpoints("br_supply_sweep_assist", undefined, undefined, undefined, undefined, undefined, streakinfo);
        }
      }

      _id_3D7259162C4253EA = instance.contents;

      if(scripts\mp\loot::_id_E3081772BBF7A51C(player, instance))
        _id_3D7259162C4253EA = scripts\mp\loot::_id_3C85CBBFD2D2A3DA(player, instance);

      _id_E05413A53B5D9167 = instance lootcachespawncontents(items, _id_64C59C08B4538D72, player, _id_3D7259162C4253EA);

      if(_id_509A21C5F4CEA6AE::_id_3392F98172A332D7() && !isbot(player))
        player thread _id_509A21C5F4CEA6AE::_id_A23861C0F0635CF4(instance);

      instance _id_64E2037F2E0D7C04::_id_6849C58E1CEC4248(items);
      _id_2B48101CA8AD8249 = undefined;

      switch (instance.type) {
        case "br_loot_cache":
          _id_2B48101CA8AD8249 = "cache";
          break;
        case "br_loot_cache_lege":
          _id_2B48101CA8AD8249 = "cache_legendary";
          break;
        case "br_scavenger_quest_cache":
          _id_2B48101CA8AD8249 = "cache_scavenger";
          break;
        case "br_secretstash_quest_cache":
          _id_2B48101CA8AD8249 = "cache_secretstash";
          break;
        case "br_reusable_loot_cache":
          _id_2B48101CA8AD8249 = "reusable_cache";
          instance thread _id_BD5CC49BE99997BD(part);
          instance._id_AB01AFAE3CE374E2 = player;
          break;
        case "br_loot_cache_personal_supply":
          _id_2B48101CA8AD8249 = "cache_personal_supply";
          break;
        case "br_loot_cache_stronghold":
          _id_744CAD313ED0A87E::_id_EC5E700FA41093A4(instance._id_276AC5E84835EA87, instance);
          break;
        case "br_loot_cache_blacksite":
          _id_744CAD313ED0A87E::_id_EC5E700FA41093A4(instance._id_276AC5E84835EA87, instance);
          break;
      }

      if(isDefined(_id_2B48101CA8AD8249)) {
        foreach(ent in _id_E05413A53B5D9167)
        ent.lootsource = _id_2B48101CA8AD8249;

        _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("br_loot_cache", -1);

        if(!isDefined(player.lootcachesopened))
          player.lootcachesopened = 1;
        else
          player.lootcachesopened++;

        if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
          player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);

        level notify("lootcache_opened_kill_callout" + instance.origin);
        level notify("open_loot_box_" + player.team, player, 1, instance);
      }

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(level._id_41F4BC9EE8C7C9C6)) {
        foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
          if(isDefined(_id_6640C2677653D96F.funcs["onCacheLooted"])) {
            foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
              if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
                _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onCacheLooted"]]](player, instance._id_46A3A8565AC0C17C);
            }
          }
        }
      }

      player scripts\cp_mp\challenges::_id_DA9003DF08944B01(instance);
      _id_6A8EC730B2BFA844::_id_68D841F5BC2DD2B6(player, instance);
      return;
    }

    if(_id_64C59C08B4538D72 && (isDefined(instance.contents) || scripts\mp\loot::_id_E3081772BBF7A51C(player, instance)) && state == "partially_open_usable") {
      if(!scripts\mp\loot::_id_E3081772BBF7A51C(player, instance)) {
        if(instance getscriptableparthasstate(part, "partially_reopen_in_use_unusable"))
          instance setscriptablepartstate(part, "partially_reopen_in_use_unusable");
        else if(instance getscriptableparthasstate(part, "partially_open_in_use_unusable"))
          instance setscriptablepartstate(part, "partially_open_in_use_unusable");
      }

      _id_3D7259162C4253EA = instance.contents;

      if(scripts\mp\loot::_id_E3081772BBF7A51C(player, instance))
        _id_3D7259162C4253EA = scripts\mp\loot::_id_3C85CBBFD2D2A3DA(player, instance);

      instance lootcachespawncontents(undefined, _id_64C59C08B4538D72, player, _id_3D7259162C4253EA);
    }
  }
}

_id_AE639176FEC476A6(instance) {
  return instance.type == "br_reusable_loot_cache" && istrue(instance._id_1208F086F2985C55);
}

_id_E1A934067BB5BC35(_id_69E96A4CAA72D794) {
  if(!istrue(level._id_E8FC7C00FD85A565))
    return 0;

  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794.type)) {
    switch (_id_69E96A4CAA72D794.type) {
      case "cache_cash_register_clean":
      case "cache_cash_register":
        return 1;
    }
  }

  return 0;
}

_id_BD5CC49BE99997BD(part) {
  level endon("game_ended");
  self endon("death");
  self endon("closed");
  _id_EB937F6D33835604 = getdvarint("dvar_FD0C403FEE9DC217", 90);
  _id_18BBA7F7B97E4F0C = _id_EB937F6D33835604 / 3;
  self._id_1208F086F2985C55 = 1;
  wait(_id_18BBA7F7B97E4F0C);
  self setscriptablepartstate(part, "fully_open_unusable_fx2");
  wait(_id_18BBA7F7B97E4F0C);
  self setscriptablepartstate(part, "fully_open_unusable_fx3");
  wait(_id_18BBA7F7B97E4F0C);

  if(isDefined(self._id_AB01AFAE3CE374E2) && isDefined(self._id_AB01AFAE3CE374E2._id_02FA5B49969DEF47) && self._id_AB01AFAE3CE374E2._id_02FA5B49969DEF47 == self)
    self._id_AB01AFAE3CE374E2 setclientomnvar("loot_container_open", 0);

  _id_64E2037F2E0D7C04::_id_C23984C8AF54D944();
  self setscriptablepartstate(part, "closing");
  self notify("closed");
}

_id_EF853AD16B5319E6() {
  self._id_1208F086F2985C55 = 0;
  _id_8B7C7CB1B28F0E97 = getDvar("dvar_11437FBC9EEEF7F0", "sc_reusable_cache_restock");
  _id_610520BE555433B2 = randomintrange(0, 100);
  self.contents = getscriptcachecontents(_id_8B7C7CB1B28F0E97, _id_610520BE555433B2);
}

_id_E91A96D043315490(instance) {
  return _id_8C57777A730CA632(instance) && istrue(level._id_04BC57EBFFEE174B);
}

_id_6759FF16E552AA94(_id_69E96A4CAA72D794) {
  return isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794.type) && _id_69E96A4CAA72D794.type == "brloot_backpack";
}

_id_8C57777A730CA632(_id_69E96A4CAA72D794) {
  return isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794.type) && (_id_69E96A4CAA72D794.type == "brloot_backpack_player_small" || _id_69E96A4CAA72D794.type == "brloot_backpack_player_medium" || _id_69E96A4CAA72D794.type == "brloot_backpack_player_large");
}

_id_163D360C111CAA16(contents, _id_8BD50C7E994C7434, _id_42BE80BA01341305) {
  _id_FEC4228317AFE4FF = 0;
  _id_311064D4E2C10B88 = 0;

  foreach(item in contents) {
    if(_id_7E52B56769FA7774::_id_34AF0F77C1668DBA(item["lootID"])) {
      _id_FEC4228317AFE4FF = _id_FEC4228317AFE4FF + item["quantity"];
      _id_311064D4E2C10B88++;
    }
  }

  _id_745BBDE1234BC1E1 = 0;

  if(_id_311064D4E2C10B88) {
    _id_7F7DFF1F5FD7EF9D = _id_8BD50C7E994C7434 - _id_FEC4228317AFE4FF;
    _id_C1D5034790909C2E = 5 * int(_id_7F7DFF1F5FD7EF9D / _id_311064D4E2C10B88 / 5);

    foreach(_id_AC0E594AC96AA3A8, item in contents) {
      if(_id_7E52B56769FA7774::_id_34AF0F77C1668DBA(item["lootID"]) && item["quantity"] < _id_42BE80BA01341305) {
        _id_BBE29C12A0CBBB11 = max(item["quantity"] + _id_C1D5034790909C2E - _id_42BE80BA01341305, 0);
        contents[_id_AC0E594AC96AA3A8]["quantity"] = int(min(item["quantity"] + _id_C1D5034790909C2E, _id_42BE80BA01341305));
        _id_745BBDE1234BC1E1 = _id_745BBDE1234BC1E1 + _id_BBE29C12A0CBBB11;
      }
    }
  } else
    _id_745BBDE1234BC1E1 = _id_8BD50C7E994C7434;

  while(_id_745BBDE1234BC1E1 > 0) {
    value = min(_id_745BBDE1234BC1E1, _id_42BE80BA01341305);
    contents = _id_848E20CF1D6CAB8F(contents, value, 8395);
    _id_745BBDE1234BC1E1 = _id_745BBDE1234BC1E1 - value;
  }

  return scripts\engine\utility::array_randomize(contents);
}

_id_728BDC627D7DF6C2(items, instance) {
  if(instance.type != "br_loot_cache_lege")
    return items;

  ammotype = "brloot_ammo_762";

  foreach(item in items) {
    if(isDefined(level.br_lootiteminfo[item]) && isDefined(level.br_lootiteminfo[item].fullweaponobj) && _id_7E52B56769FA7774::isweaponpickup(item)) {
      ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(level.br_lootiteminfo[item].fullweaponobj);
      break;
    }
  }

  items[items.size] = ammotype;
  return scripts\engine\utility::array_randomize(items);
}

_id_BB85AADE9D4A5515(_id_83CB4D74538AF81D) {
  if(!isDefined(level._id_6313C4D3BAA059EA))
    level._id_6313C4D3BAA059EA = [];

  level._id_6313C4D3BAA059EA[level._id_6313C4D3BAA059EA.size] = _id_83CB4D74538AF81D;
}

_id_583266F1450C18C6(items, instance) {
  _id_3ABF1883ADA5D45E = level._id_6313C4D3BAA059EA;

  if(isDefined(_id_3ABF1883ADA5D45E) && _id_3ABF1883ADA5D45E.size > 0) {
    foreach(_id_FF5D88DAA686695B in _id_3ABF1883ADA5D45E) {
      _id_0FB8DF1A883F578C = [[_id_FF5D88DAA686695B]](instance);

      if(isDefined(_id_0FB8DF1A883F578C))
        items[items.size] = _id_0FB8DF1A883F578C;
    }
  }

  return scripts\engine\utility::array_randomize(items);
}

lootcontentsadjusteconomy_bottomtier(instance, items) {
  _id_B059ADAF8E5750F5 = [];

  foreach(item in items) {
    if(issubstr(item, "brloot_plunder")) {
      if(instance.type == "br_loot_cache_lege") {
        if(item != "brloot_plunder_cash_legendary_1" && scripts\engine\utility::cointoss())
          item = "brloot_plunder_cash_legendary_1";
      } else if(item != "brloot_plunder_cash_epic_2" && scripts\engine\utility::cointoss())
        item = "brloot_plunder_cash_epic_2";
    }

    _id_B059ADAF8E5750F5[_id_B059ADAF8E5750F5.size] = item;
  }

  return _id_B059ADAF8E5750F5;
}

lootcontentsadjusteconomy_toptier(instance, items) {
  _id_B059ADAF8E5750F5 = [];

  foreach(item in items) {
    if(issubstr(item, "brloot_plunder")) {
      if(instance.type == "br_loot_cache_lege") {
        if((item == "brloot_plunder_cash_epic_2" || item == "brloot_plunder_cash_legendary_1") && scripts\engine\utility::cointoss())
          item = "brloot_plunder_cash_epic_1";
      } else if((item == "brloot_plunder_cash_epic_2" || item == "brloot_plunder_cash_epic_1") && scripts\engine\utility::cointoss())
        item = "brloot_plunder_cash_rare_2";
    }

    _id_B059ADAF8E5750F5[_id_B059ADAF8E5750F5.size] = item;
  }

  return _id_B059ADAF8E5750F5;
}

lootcontentsadjust_accesscardsred(items) {
  _id_B059ADAF8E5750F5 = [];

  foreach(item in items) {
    if(item != "brloot_access_card_red") {
      _id_B059ADAF8E5750F5[_id_B059ADAF8E5750F5.size] = item;
      continue;
    }

    if(level.maxaccesscardspawns_red > level.accesscardsspawned_red) {
      _id_B059ADAF8E5750F5[_id_B059ADAF8E5750F5.size] = item;
      level.accesscardsspawned_red++;
    }
  }

  return _id_B059ADAF8E5750F5;
}

chooseandspawnitems(dropstruct, _id_426AB5C68504F990, _id_2860FA0F2247CCF0, _id_E31187607FF31DA2, _id_D6379F1654C3DCA3, angleoffset) {
  _id_E05413A53B5D9167 = [];
  _id_17B34CF2DD66912F = 0;

  if(!isDefined(_id_E31187607FF31DA2))
    _id_E31187607FF31DA2 = "";

  if(!isDefined(_id_426AB5C68504F990))
    _id_426AB5C68504F990 = 0;

  _id_6314E68D57B3349B = "mp/loot_set_cache_contents_base.csv";

  if(isDefined(_id_D6379F1654C3DCA3))
    _id_6314E68D57B3349B = _id_D6379F1654C3DCA3;

  for(_id_EC877E0D3A90BCD3 = 0; _id_EC877E0D3A90BCD3 < _id_2860FA0F2247CCF0; _id_EC877E0D3A90BCD3++) {
    itemname = pickscriptablelootitem(_id_E31187607FF31DA2, _id_426AB5C68504F990, 0, _id_6314E68D57B3349B);

    if(canspawnitemname(itemname)) {
      angles = self.angles;

      if(isDefined(angleoffset))
        angles = angles + angleoffset;

      _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[itemname];

      if(isDefined(_id_A69FFF5222862F26) && _id_A69FFF5222862F26 == 4 && _id_17B34CF2DD66912F == 0) {
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, self.origin, angles, undefined, 1);
        _id_17B34CF2DD66912F = 1;
      } else
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = lootspawnitem(itemname, dropstruct, self.origin, angles, undefined, 0);
    }
  }

  return _id_E05413A53B5D9167;
}

lootcontentsadjustkillchain(items, player) {
  if(!isDefined(player.brkillchainchance))
    player.brkillchainchance = 10;

  _id_8DD5FA3FD9854F26 = 0;

  foreach(index, item in items) {
    if(issubstr(item, "killstreak")) {
      _id_8DD5FA3FD9854F26 = 1;
      break;
    }
  }

  if(!_id_8DD5FA3FD9854F26) {
    _id_281158B82D0291BA = player.killcountthislife * 0;

    if(randomint(100) < player.brkillchainchance + _id_281158B82D0291BA) {
      _id_D45C83148EF4CF67 = ["brloot_killstreak_clusterstrike", "brloot_killstreak_precision_airstrike", "brloot_killstreak_uav", "brloot_killstreak_shieldturret"];
      items[items.size] = scripts\engine\utility::random(_id_D45C83148EF4CF67);
      player.brkillchainchance = 10;
    } else
      player.brkillchainchance = player.brkillchainchance + (_id_281158B82D0291BA + 15);
  }

  return items;
}

_id_75E83820A58A07C9(_id_990BF19E67EC2D89) {
  level endon("game_ended");
  weapons = [];
  weapons[weapons.size] = _id_990BF19E67EC2D89.loadoutprimaryobject;
  weapons[weapons.size] = _id_990BF19E67EC2D89.loadoutsecondaryobject;
  return weapons;
}

_id_A76B46F057488CC0(instance, team, _id_57838BB4FAE836F8, _id_583832B5EC35DFBC) {
  _id_5332CDA4054641DA = _id_0B7A9CE0A2282B79::_id_E860C1BE7FF11F5B(team, _id_57838BB4FAE836F8);
  _id_2BD6F23F3FE9D91E = _id_5332CDA4054641DA * _id_583832B5EC35DFBC;
  items = getscriptablelootcachecontents(instance);
  _id_401049E104D6479C = scripts\engine\utility::array_randomize(getscriptablelootcachecontents(instance));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2BD6F23F3FE9D91E; _id_AC0E594AC96AA3A8++)
    items[items.size] = _id_401049E104D6479C[_id_AC0E594AC96AA3A8];

  return items;
}

_id_3ACD6FF5BDA75039(items) {
  foreach(item in items) {
    if(issubstr(item, "brloot_plunder"))
      return 1;
  }

  return 0;
}

_id_8CA2F83C962D40D9() {
  for(;;) {
    waitframe();

    if(getdvarint("dvar_82B5F4ECCB13D4D2", 0)) {
      _id_4EAD6B4FF3816236 = [];
      _id_EA156F5F477A8792 = getlootspawnpointcount();

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EA156F5F477A8792; _id_AC0E594AC96AA3A8++) {
        loot = getlootspawnpoint(_id_AC0E594AC96AA3A8);

        if(loot.type == 1) {
          _id_972D1889BBE8CC7C = distance2dsquared(level.players[0].origin, loot.origin);

          if(_id_972D1889BBE8CC7C <= 100000000.0)
            _id_4EAD6B4FF3816236[_id_4EAD6B4FF3816236.size] = loot;
        }
      }

      foreach(_id_B038ED928EC17A81 in _id_4EAD6B4FF3816236) {}
    }
  }
}

_id_CB377A5E11EEF62C(_id_69E96A4CAA72D794, player) {
  if(!getdvarint("dvar_C38245858B3DCC0D", 1))
    return [undefined, undefined];

  if(!isDefined(self.type) || !isDefined(player))
    return [undefined, undefined];

  forward = anglesToForward(_id_69E96A4CAA72D794.angles);
  left = anglestoright(_id_69E96A4CAA72D794.angles) * -1;
  up = anglestoup(_id_69E96A4CAA72D794.angles);
  _id_24C6F607CFEED805 = player.origin - _id_69E96A4CAA72D794.origin;

  switch (_id_69E96A4CAA72D794.type) {
    case "br_loot_swamp_eggmound_cache":
    case "br_loot_swamp_eggmound_cache_small":
      return [vectortoyaw(_id_24C6F607CFEED805), _id_69E96A4CAA72D794.origin + up * 100];
    case "cache_school_locker_b":
    case "cache_school_locker_a":
      return [undefined, _id_69E96A4CAA72D794.origin + left * getdvarfloat("dvar_90CE55A815605004", 16.0) + up * 30];
    case "cache_military_container":
      return [undefined, _id_69E96A4CAA72D794.origin + forward * getdvarfloat("dvar_90CE55A815605004", 16.0)];
    case "cache_office_cabinet":
    case "cache_mail_kiosk":
    case "cache_fridge_mini":
    case "cache_fridge_b":
    case "cache_fridge_a":
    case "cache_dresser":
    case "cache_bar_cabinet":
      return [0, _id_69E96A4CAA72D794.origin + forward * getdvarfloat("dvar_90CE55A815605004", 16.0)];
    case "cache_medical_box_wall":
      return [0, _id_69E96A4CAA72D794.origin + forward * getdvarfloat("dvar_90CE55A815605004", 16.0) + up * -15];
    case "cache_computer_tower":
      return [270, undefined];
    case "cache_weapon_locker":
      return [270, _id_69E96A4CAA72D794.origin + up * 15];
    case "cache_hanging_clothes":
      return [undefined, _id_69E96A4CAA72D794.origin + left * 10 + up * -30];
    case "cache_toolbox":
      return [0, _id_69E96A4CAA72D794.origin + up * -15];
    case "cache_medicine_cabinet":
    case "cache_cash_register_clean":
    case "cache_cash_register":
      return [0, _id_69E96A4CAA72D794.origin + forward * 15 + up * -15];
    case "cache_comm_fridge_02":
    case "cache_comm_fridge_01":
      return [0, _id_69E96A4CAA72D794.origin + forward * getdvarfloat("dvar_90CE55A815605004", 16.0) + up * 30];
    case "cache_utility_metal_crate":
      return [undefined, _id_69E96A4CAA72D794.origin + left * 10 + up * 20];
    case "cache_pelican_case_rifle":
    case "cache_metal_briefcase":
      return [0, _id_69E96A4CAA72D794.origin + forward * 8 + up * -10];
    case "cache_duffel_bag_02":
    case "cache_duffel_bag_01":
      return [undefined, _id_69E96A4CAA72D794.origin + forward * getdvarfloat("dvar_90CE55A815605004", 16.0) + left * 16 + up * -5];
    case "cache_fridge_old":
      return [0, _id_69E96A4CAA72D794.origin + forward * 25 + up * 20];
    case "dmz_hidden_container_common":
      return [undefined, _id_69E96A4CAA72D794.origin + up * 20];
    case "dmz_hell_train_safe":
      return [30, _id_69E96A4CAA72D794.origin + up * 10];
    default:
      return [undefined, undefined];
  }
}

_id_F75061432D4C00A7(instance, player) {
  if(!isDefined(instance.type)) {
    return;
  }
  switch (instance.type) {
    case "br_loot_swamp_eggmound_cache":
    case "br_loot_swamp_eggmound_cache_small":
    case "locked_cache_prompt":
    case "dmz_elimination_quest_cache":
    case "br_secretstash_quest_cache":
    case "dmz_geiger_counter_cache":
    case "br_x1_stash_quest_cache":
    case "brloot_backpack_player_scav":
    case "brloot_backpack_player_secure":
    case "br_plunder_box_stronghold":
    case "br_plunder_box":
    case "br_scavenger_quest_cache":
    case "brloot_backpack_player_small":
    case "brloot_backpack_player_medium":
    case "brloot_backpack_player_large":
    case "brloot_backpack":
    case "cyber_revive_pillage":
    case "cache_gulag_west_4":
    case "cache_gulag_west_3":
    case "cache_gulag_east_4":
    case "cache_gulag_east_3":
    case "dmz_geiger_puzzle_container":
    case "dmz_dead_drop_transaction_drawer":
    case "dmz_dead_drop":
      return;
    default:
      break;
  }

  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(instance.origin);

  switch (_id_171F90B9C4C76D44) {
    case "saba_airport":
      _id_44B8991C2B01716A::_id_0F7FE427D574911C("ingame_haunting_witch", player);
      break;
    case "saba_exhume":
      _id_44B8991C2B01716A::_id_0F7FE427D574911C("ingame_haunting_reaper", player);
      break;
    case "saba_fort":
      _id_44B8991C2B01716A::_id_0F7FE427D574911C("ingame_haunting_spectre", player);
      break;
    case "saba_moderncity":
      _id_44B8991C2B01716A::_id_0F7FE427D574911C("ingame_haunting_ghoul", player);
      break;
    default:
      _id_44B8991C2B01716A::_id_0B67F0B02F25B1AF(player);
      break;
  }
}