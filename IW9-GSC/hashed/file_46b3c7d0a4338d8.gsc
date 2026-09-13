/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_46b3c7d0a4338d8.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_6D6A6FCD9E67BC58 = spawnStruct();
  level._id_6D6A6FCD9E67BC58.circleradius = getdvarint("dvar_9CBB7D15274D1400", 2000);
  level._id_6D6A6FCD9E67BC58._id_E3AA1DE9D96E0086 = getdvarint("dvar_22AFE1C9474C402B", 250);
  level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 = getdvarint("dvar_A4E9AF7F9B4F5F27", 3);
  level._id_6D6A6FCD9E67BC58._id_B5C92B054A1FED4B = getdvarint("dvar_A238C865CC6AF24C", 3500);
  level._id_6D6A6FCD9E67BC58._id_9F883F99B6BEBC25 = getdvarint("dvar_4EEF3124E0EEBA7E", 6000);
  level._id_6D6A6FCD9E67BC58._id_021E7AA9E2BE9A6B = getdvarint("dvar_7EC9710223DCE350", 1750);
  level._id_6D6A6FCD9E67BC58._id_15D8B4BB0DB69CDB = level._id_6D6A6FCD9E67BC58._id_021E7AA9E2BE9A6B * level._id_6D6A6FCD9E67BC58._id_021E7AA9E2BE9A6B;
  level._id_6D6A6FCD9E67BC58._id_60A7F94F444A39BB = level._id_6D6A6FCD9E67BC58._id_B5C92B054A1FED4B * level._id_6D6A6FCD9E67BC58._id_B5C92B054A1FED4B;
  level._id_6D6A6FCD9E67BC58._id_60C5FE5CA7547989 = level._id_6D6A6FCD9E67BC58._id_9F883F99B6BEBC25 * level._id_6D6A6FCD9E67BC58._id_9F883F99B6BEBC25;
  _id_479E458F6F530F0D::_id_58BF160252F94E21();
  level._id_308D8C8CA5731E79 = [];
  allnodes = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_hidden_container", "script_noteworthy"));
  _id_25DD3020969AA0F6 = [];

  foreach(node in allnodes) {
    if(_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin)) {
      continue;
    }
    _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = node;
  }

  _id_D8D64C09271E3C95 = getdvarint("dvar_E9C06CA749F2ABE9", 300);
  _id_C512D6E5FC38C740 = 0;
  _id_A7409EDF90C03E79 = [];

  foreach(node in _id_25DD3020969AA0F6) {
    if(istrue(node._id_32B1048DB382C805)) {
      continue;
    }
    node.allnodes = [node];

    for(_id_B038ED928EC17A81 = 1; _id_B038ED928EC17A81 < level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20; _id_B038ED928EC17A81++) {
      for(_id_FE8F7703F6313ED4 = 0; _id_FE8F7703F6313ED4 < _id_25DD3020969AA0F6.size; _id_FE8F7703F6313ED4++) {
        _id_196D1CC990D1BDBA = _id_25DD3020969AA0F6[_id_FE8F7703F6313ED4];

        if(istrue(_id_196D1CC990D1BDBA._id_32B1048DB382C805)) {
          continue;
        }
        _id_4076D436F9878FDF = 1;

        foreach(_id_CADD946C5C39FBF7 in node.allnodes) {
          dist = distance2dsquared(_id_196D1CC990D1BDBA.origin, _id_CADD946C5C39FBF7.origin);

          if(dist < level._id_6D6A6FCD9E67BC58._id_60A7F94F444A39BB || dist > level._id_6D6A6FCD9E67BC58._id_60C5FE5CA7547989) {
            _id_4076D436F9878FDF = 0;
            break;
          }
        }

        if(_id_4076D436F9878FDF) {
          node.allnodes[node.allnodes.size] = _id_196D1CC990D1BDBA;
          break;
        }
      }
    }

    if(node.allnodes.size == level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20) {
      _id_A7409EDF90C03E79[_id_A7409EDF90C03E79.size] = node;

      foreach(_id_CADD946C5C39FBF7 in node.allnodes)
      _id_CADD946C5C39FBF7._id_32B1048DB382C805 = 1;
    }

    _id_C512D6E5FC38C740++;

    if(_id_C512D6E5FC38C740 >= _id_D8D64C09271E3C95) {
      _id_C512D6E5FC38C740 = 0;
      waitframe();
    }
  }

  foreach(node in _id_A7409EDF90C03E79) {
    _id_B5FC2BFA7EEEEED5 = getentitylessscriptablearray("scriptable_cache_toolbox", "classname", node.origin, 7500);

    if(_id_B5FC2BFA7EEEEED5.size) {
      _id_31FF7305890A6EF2 = 1500;
      _id_06E51C4622AA0C30 = 999999999;
      _id_1DCA92BB81D1FFE7 = undefined;

      foreach(_id_B038ED928EC17A81 in _id_B5FC2BFA7EEEEED5) {
        if(istrue(_id_B038ED928EC17A81._id_A4AD8D0B52DAF9BE) || !_id_47B72E9DFBABD1DA(_id_B038ED928EC17A81)) {
          continue;
        }
        _id_4573A8725DD3748E = abs(distance(node.origin, _id_B038ED928EC17A81.origin) - _id_31FF7305890A6EF2);

        if(_id_4573A8725DD3748E < _id_06E51C4622AA0C30) {
          _id_06E51C4622AA0C30 = _id_4573A8725DD3748E;
          _id_1DCA92BB81D1FFE7 = _id_B038ED928EC17A81;

          if(_id_06E51C4622AA0C30 < 300) {
            break;
          }
        }
      }

      if(isDefined(_id_1DCA92BB81D1FFE7)) {
        node._id_30EB0D4ADCAAFED9 = _id_1DCA92BB81D1FFE7;
        _id_1DCA92BB81D1FFE7._id_A4AD8D0B52DAF9BE = 1;
        level._id_308D8C8CA5731E79[level._id_308D8C8CA5731E79.size] = node;
      }
    }

    _id_C512D6E5FC38C740++;

    if(_id_C512D6E5FC38C740 >= _id_D8D64C09271E3C95) {
      _id_C512D6E5FC38C740 = 0;
      waitframe();
    }
  }

  level._id_D8DB1602C8BF473E["brloot_valuable_fuelrods"] = ::_id_18DB3205A09F3D50;
  level._id_05635125E56693C8["brloot_valuable_fuelrods"] = ::_id_4BC551D2A91831AC;
  thread _id_9A1FDE02233CB33A();
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_C52467737F03E091, level._id_308D8C8CA5731E79);
}

_id_C52467737F03E091(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_AB806E73F41ED0A2;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_1ED4E13220736831;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_235FE34454B16940;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_9E6A1FC8C2BDF24B;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_4B5D3D286D6DAC3B;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_599CE16653DA505A;
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.nodes = node.allnodes;
  _id_B8EBE3F71A08AB40.ref = "dmz_geiger_search_explore";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  return _id_B8EBE3F71A08AB40;
}

_id_AB806E73F41ED0A2() {
  self._id_4EAD6B4FF3816236 = [];
  _id_ECBE40BB7DB8C8DF = [];

  foreach(index, node in self.nodes) {
    _id_B038ED928EC17A81 = spawnscriptable("dmz_hidden_container", node.origin, node.angles);
    _id_B038ED928EC17A81._id_534E0CF170A981B7 = ::_id_D8352A33E10DF5A8;
    self._id_4EAD6B4FF3816236[index] = _id_B038ED928EC17A81;
    _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = self;
    _id_ECBE40BB7DB8C8DF[_id_ECBE40BB7DB8C8DF.size] = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(_id_B038ED928EC17A81.origin, level._id_6D6A6FCD9E67BC58.circleradius);
    _id_B038ED928EC17A81._id_4B1DC74724995FB7 = index;
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_unusable");
    _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_B038ED928EC17A81);
  }

  self._id_EFA8EF05B190D7D0.origin = self.nodes[0].origin;
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Explore_Dmz", _id_ECBE40BB7DB8C8DF, level._id_6D6A6FCD9E67BC58.circleradius + level._id_6D6A6FCD9E67BC58._id_E3AA1DE9D96E0086);
  pos = (0, 0, 0);

  foreach(loc in _id_ECBE40BB7DB8C8DF)
  pos = pos + loc;

  pos = pos / _id_ECBE40BB7DB8C8DF.size;
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(pos + (0, 0, 750));
  self._id_F42170AD6524CDC2 = 0;

  if(self._id_4EAD6B4FF3816236.size < level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20) {
    _id_8250FD658E3AAE32();
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  self._id_30EB0D4ADCAAFED9 = self.node._id_30EB0D4ADCAAFED9;

  if(!_id_47B72E9DFBABD1DA(self._id_30EB0D4ADCAAFED9)) {
    _id_8250FD658E3AAE32();
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  self._id_A161875F61A76BF1 = self.node._id_30EB0D4ADCAAFED9;
  self._id_A161875F61A76BF1._id_534E0CF170A981B7 = ::_id_6DF202B999C40A49;
  self._id_A161875F61A76BF1._id_B8EBE3F71A08AB40 = self;
}

_id_235FE34454B16940(player) {
  if(!isDefined(self._id_A161875F61A76BF1._id_556DB0B72A96514E) || !isDefined(self._id_A161875F61A76BF1._id_556DB0B72A96514E[player.guid])) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("equip_geigercounter");
    _id_5731E7B66522F308 = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F([], 1, lootid);
    scripts\mp\loot::_id_618F897065A12122(player, self._id_A161875F61A76BF1, _id_5731E7B66522F308);
    scripts\mp\loot::_id_618F897065A12122(player, self._id_A161875F61A76BF1, self._id_A161875F61A76BF1.contents);
  }

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
  _id_B038ED928EC17A81 enablescriptableplayeruse(player);
}

_id_9E6A1FC8C2BDF24B(player) {
  _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);

  if(isDefined(self._id_77B131EF0E51D26C))
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
  _id_B038ED928EC17A81 disablescriptableplayeruse(player);
}

_id_1ED4E13220736831(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  if(!isDefined(self._id_A161875F61A76BF1.contents)) {
    items = getscriptablelootcachecontents(self._id_A161875F61A76BF1);
    self._id_A161875F61A76BF1._id_46A3A8565AC0C17C = 3;
    self._id_A161875F61A76BF1.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
  }

  foreach(player in players) {
    if(!isDefined(self._id_A161875F61A76BF1._id_556DB0B72A96514E) || !isDefined(self._id_A161875F61A76BF1._id_556DB0B72A96514E[player.guid])) {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("equip_geigercounter");
      _id_5731E7B66522F308 = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F([], 1, lootid);
      scripts\mp\loot::_id_618F897065A12122(player, self._id_A161875F61A76BF1, _id_5731E7B66522F308);
      scripts\mp\loot::_id_618F897065A12122(player, self._id_A161875F61A76BF1, self._id_A161875F61A76BF1.contents);
    }
  }

  _id_8EDC62019D327B86 = _id_C80F253020916751();

  if(_id_8EDC62019D327B86) {
    index = _id_64ACB6CE534155B7::getquesttableindex("dmz_geiger_search_loot");
    _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(self._id_A161875F61A76BF1.origin + (0, 0, 15));
    self._id_77B131EF0E51D26C = spawnStruct();
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(_id_3AA6A56AD7AB8AA7(), "recon");

    foreach(player in players) {
      if(player _id_26E5198328580B5A()) {
        _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
        _id_55BE392E685E2721(player);
        _id_D327E41F5EEF4F64(player);
        continue;
      }

      _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
      _id_75903B3C87D79DDC(player);
      _id_6C4E8CEA70BF4B6D::_id_B43E9536B7E60884(player, index);
    }
  } else {
    foreach(player in players)
    player._id_6947D1A323FD968B = 1;

    _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  }

  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("geiger_search_assigned", _id_FABF84450735DD93, 3.0);
  self._id_8BD50C7E994C7434 = _id_6C4E8CEA70BF4B6D::_id_9C6AB63C4B6BD08B(_id_FABF84450735DD93);

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236) {
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");

    foreach(player in level.players)
    _id_B038ED928EC17A81 disablescriptableplayeruse(player);

    foreach(player in players)
    _id_B038ED928EC17A81 enablescriptableplayeruse(player);
  }

  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_geiger_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");

  foreach(player in players)
  player _id_64ACB6CE534155B7::uiobjectivesetparameter(level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 - self._id_F42170AD6524CDC2);

  thread _id_0B75B0CF7005C5F7(_id_FABF84450735DD93);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);
}

_id_4B5D3D286D6DAC3B(_id_FABF84450735DD93) {}

_id_599CE16653DA505A(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
    _id_B038ED928EC17A81 disablescriptableplayeruse(player);
  }

  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, undefined, undefined);
  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self._id_7EF0FA7A21303CCC = 1;
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  if(isDefined(self._id_77B131EF0E51D26C))
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
}

_id_CA27DBC903D08245(_id_FABF84450735DD93) {
  self notify("task_ended");
  _id_8250FD658E3AAE32();
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("geiger_search_win", _id_FABF84450735DD93, 3.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_26E5198328580B5A() {
  curr = scripts\mp\equipment::getcurrentequipment("secondary");
  _id_0C89F07DA007FF0D = scripts\mp\equipment::getequipmentslotammo("secondary");
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("equip_geigercounter");
  count = _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
  return isDefined(curr) && curr == "equip_geigercounter" && _id_0C89F07DA007FF0D || isDefined(count) && count;
}

_id_C80F253020916751() {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
  _id_9DF31B4639D9EED8 = 0;

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(_id_F0EA4030349A33D5 _id_26E5198328580B5A()) {
      continue;
    }
    _id_9DF31B4639D9EED8++;
  }

  return _id_9DF31B4639D9EED8;
}

_id_47B72E9DFBABD1DA(_id_B038ED928EC17A81) {
  return !_id_4948CDF739393D2D::_id_F59F68ADC71D49B3(_id_B038ED928EC17A81.origin) && !_id_57D3850A12CF1D8F::_id_64332F29E2409E55(_id_B038ED928EC17A81.origin) && !istrue(_id_B038ED928EC17A81._id_3E5D613E6F4D92E3);
}

_id_6DF202B999C40A49(instance, player) {
  if(!isDefined(instance._id_B8EBE3F71A08AB40) || !isDefined(instance._id_B8EBE3F71A08AB40.teams[0]) || player.team != instance._id_B8EBE3F71A08AB40.teams[0] || istrue(instance._id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC)) {
    player scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR");
    return 0;
  }

  if(!isDefined(instance.contents)) {
    items = getscriptablelootcachecontents(instance);
    instance._id_46A3A8565AC0C17C = 3;
    instance.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
  }

  if(!isDefined(instance._id_556DB0B72A96514E) || !isDefined(instance._id_556DB0B72A96514E[player.guid])) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("equip_geigercounter");
    _id_5731E7B66522F308 = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F([], 1, lootid);
    scripts\mp\loot::_id_618F897065A12122(player, instance, _id_5731E7B66522F308);
  }
}

_id_D8352A33E10DF5A8(instance, player) {
  if(!isDefined(instance.contents)) {
    items = getscriptablelootcachecontents(instance);
    instance._id_46A3A8565AC0C17C = 3;
    instance.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
    _id_8BD50C7E994C7434 = int(ceil(instance._id_B8EBE3F71A08AB40._id_8BD50C7E994C7434 / level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20));
    instance.contents = _id_552B8E4EA5FF7DF1::_id_163D360C111CAA16(instance.contents, _id_8BD50C7E994C7434, 500);
  }
}

_id_18DB3205A09F3D50(instance, player) {
  if(isDefined(player._id_02FA5B49969DEF47) && isDefined(player._id_02FA5B49969DEF47._id_B8EBE3F71A08AB40)) {
    _id_B038ED928EC17A81 = player._id_02FA5B49969DEF47;
    _id_B8EBE3F71A08AB40 = _id_B038ED928EC17A81._id_B8EBE3F71A08AB40;

    if(istrue(_id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC))
      return 34;

    result = undefined;

    if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
      return player _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(instance);

    return 34;
  }

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
    return player _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(instance);

  return 34;
}

_id_4BC551D2A91831AC(pickup, player) {
  if(isDefined(player._id_02FA5B49969DEF47) && isDefined(player._id_02FA5B49969DEF47._id_B8EBE3F71A08AB40)) {
    _id_B038ED928EC17A81 = player._id_02FA5B49969DEF47;
    _id_B8EBE3F71A08AB40 = _id_B038ED928EC17A81._id_B8EBE3F71A08AB40;
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_4E927BFE9B585059(_id_B038ED928EC17A81._id_4B1DC74724995FB7);
    _id_B8EBE3F71A08AB40._id_F42170AD6524CDC2++;
    _id_B038ED928EC17A81.found = 1;
    _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(_id_B038ED928EC17A81);
    players = scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40.teams[0], "players");

    foreach(player in players)
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 - _id_B8EBE3F71A08AB40._id_F42170AD6524CDC2);

    _id_1B4ADA49A21B51CA = undefined;

    if(level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 == 1)
      _id_1B4ADA49A21B51CA = "dmz_geiger_complete";

    if(level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 == 2)
      _id_1B4ADA49A21B51CA = ["dmz_geiger_first_found_out_of_two", "dmz_geiger_complete"][_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 - 1];

    if(level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 == 3)
      _id_1B4ADA49A21B51CA = ["dmz_geiger_first_found", "dmz_geiger_second_found", "dmz_geiger_complete"][_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 - 1];

    if(_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 == level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20) {
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094(_id_1B4ADA49A21B51CA, "geiger", _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, player.team);
      _id_B8EBE3F71A08AB40 _id_CA27DBC903D08245(player.team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    } else {
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, scripts\mp\utility\teams::getteamdata(player.team, "players"));
      _id_B8EBE3F71A08AB40 _id_FCE203BF90070FF0();
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, "dmz_geigersearch_pickups", 0.0, "dmz_geigersearch_pickups_classic");
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, "", 8.0, "dmz_geigersearch_pickups_classic");
    }
  }
}

_id_3AA6A56AD7AB8AA7() {
  pos = (0, 0, 0);

  foreach(circle in self._id_B0F4BF8621B96C0A) {
    if(isDefined(circle) && isDefined(circle.mapcircle))
      pos = pos + circle.mapcircle.origin;
  }

  _id_D20AAEEE28502DA1 = max(1, level._id_6D6A6FCD9E67BC58._id_B04566C546A49C20 - self._id_F42170AD6524CDC2);
  pos = pos / _id_D20AAEEE28502DA1;
  height = 0;

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236) {
    if(!istrue(_id_B038ED928EC17A81.found))
      height = height + _id_B038ED928EC17A81.origin[2];
  }

  height = height / _id_D20AAEEE28502DA1;
  pos = (pos[0], pos[1], height);
  return pos + (0, 0, 750);
}

_id_FCE203BF90070FF0() {
  pos = _id_3AA6A56AD7AB8AA7();

  if(isDefined(self._id_77B131EF0E51D26C))
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(pos);
  else
    _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(pos);
}

_id_55BE392E685E2721(player) {
  if(isDefined(self._id_77B131EF0E51D26C))
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
  else
    _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
}

_id_75903B3C87D79DDC(player) {
  if(isDefined(self._id_77B131EF0E51D26C))
    self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
  else
    _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
}

_id_3C9248D849F9FFD7(player) {
  if(isDefined(self._id_77B131EF0E51D26C))
    _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
}

_id_D327E41F5EEF4F64(player) {
  if(isDefined(self._id_77B131EF0E51D26C))
    _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
}

_id_0B75B0CF7005C5F7(_id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(player in players) {
      if(isDefined(player._id_BCB3E1F6F7CD3CB7) && isDefined(player._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E) && player._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E < 0.8) {
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("geiger_search_detected", _id_FABF84450735DD93);
        return;
      }
    }

    wait 1.0;
  }
}

_id_C373F127DAFC389A(_id_FABF84450735DD93) {
  self endon("task_ended");
  wait 5;
  _id_44937005A0F57F50 = 0;
  _id_F8EBE9CFC6BE863E = _id_64ACB6CE534155B7::getquesttableindex("dmz_geiger_search");
  _id_A69FCD2FCA613429 = _id_64ACB6CE534155B7::getquesttableindex("dmz_geiger_search_explore");
  _id_1660A3B7FCFFB869 = _id_64ACB6CE534155B7::getquesttableindex("dmz_geiger_search_loot");

  for(;;) {
    if(isDefined(self._id_77B131EF0E51D26C)) {
      _id_9DF31B4639D9EED8 = _id_C80F253020916751();

      if(_id_9DF31B4639D9EED8 == 0) {
        _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(self._id_77B131EF0E51D26C._id_7919C8F3A10FEB86);
        self._id_77B131EF0E51D26C _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
        self._id_77B131EF0E51D26C = undefined;
      }
    }

    players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
    _id_4F0FC1C36324AFFB = 10000000000;
    _id_0FA73C7E2D99FA15 = (0, 0, 0);

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!player _id_26E5198328580B5A() && isDefined(self._id_77B131EF0E51D26C)) {
        _id_6C4E8CEA70BF4B6D::_id_B43E9536B7E60884(player, _id_1660A3B7FCFFB869);
        _id_75903B3C87D79DDC(player);
        _id_3C9248D849F9FFD7(player);
        _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
        continue;
      } else {
        _id_D327E41F5EEF4F64(player);
        _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
      }

      foreach(circle in self._id_B0F4BF8621B96C0A) {
        if(!isDefined(circle)) {
          continue;
        }
        distsq = distance2dsquared(circle.mapcircle.origin, player.origin);

        if(distsq < level._id_6D6A6FCD9E67BC58.circleradius * level._id_6D6A6FCD9E67BC58.circleradius) {
          _id_6C4E8CEA70BF4B6D::_id_B43E9536B7E60884(player, _id_F8EBE9CFC6BE863E);
          _id_75903B3C87D79DDC(player);
        } else {
          _id_6C4E8CEA70BF4B6D::_id_B43E9536B7E60884(player, _id_A69FCD2FCA613429);
          _id_55BE392E685E2721(player);
        }

        if(!_id_44937005A0F57F50 && distsq < level._id_6D6A6FCD9E67BC58.circleradius * level._id_6D6A6FCD9E67BC58.circleradius) {
          _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("geiger_search_approach", _id_FABF84450735DD93);
          _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
          _id_44937005A0F57F50 = 1;
        }
      }
    }

    wait 1.0;
  }
}

_id_9A1FDE02233CB33A() {
  if(getdvarint("dvar_E3673B8854E11B40", 0)) {
    index = 0;
    nodes = scripts\engine\utility::getStructArray("dmz_hidden_container", "script_noteworthy");
    _id_C7826D3DFFD46C45 = undefined;

    for(;;) {
      _id_B205D90302DA2F07 = getDvar("dvar_D4DD9C7F6EECAF23");

      if(getdvarint("dvar_BE93C6177FEB6077", 0)) {
        setDvar("dvar_BE93C6177FEB6077", 0);
        node = undefined;

        while(index < nodes.size) {
          node = nodes[index];
          index++;

          if(isDefined(_id_B205D90302DA2F07) && _id_B205D90302DA2F07 != "") {
            if(!isDefined(node._id_B205D90302DA2F07))
              node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

            if(node._id_B205D90302DA2F07 == _id_B205D90302DA2F07) {
              break;
            }
          } else
            break;
        }

        if(!isDefined(node)) {
          index = 0;
          continue;
        }

        if(isDefined(_id_C7826D3DFFD46C45))
          _id_C7826D3DFFD46C45 freescriptable();

        _id_C7826D3DFFD46C45 = spawnscriptable("dmz_hidden_container", node.origin, node.angles);
        _id_C7826D3DFFD46C45 setscriptablepartstate("body", "closed_usable");
        origin = node.origin + (0, 0, 75);
        angles = vectortoangles(node.origin - origin);
        level.players[0] setOrigin(origin);
        level.players[0] setplayerangles(angles);
      }

      waitframe();
    }
  }
}

_id_12A716196C05ECA1() {
  for(;;)
    waitframe();
}