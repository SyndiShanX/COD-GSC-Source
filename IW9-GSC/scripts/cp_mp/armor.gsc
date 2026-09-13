/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\armor.gsc
***********************************************/

init() {
  level._id_D73697030C5D4E05 = getdvarint("scr_player_allowarmor", 1) == 1;

  if(scripts\common\utility::iscp()) {
    level._id_4B78859BACC88808 = getdvarint("dvar_EA4FD87F53EC4456", 120);
    level._id_FB2B3C3DB6061DF5 = getdvarint("dvar_95E3CDFA6F3B12A1", 0);
  } else {
    level._id_4B78859BACC88808 = getdvarint("dvar_EA4FD87F53EC4456", 50);
    level._id_FB2B3C3DB6061DF5 = getdvarint("dvar_95E3CDFA6F3B12A1", 1);
  }

  level._id_34867328231CA54B = getdvarint("scr_player_spawnarmor", 0);
  level._id_BF6C149BC4124962 = getdvarint("scr_player_spawnarmorplates", 0);
  level._id_23500029F84B30D0 = getdvarint("dvar_A729499D07BCD90A", 1) == 1;
  level._id_36304CC9071BF738 = getdvarint("dvar_08AD1AB9436BCCCA", 0);
  level._id_2B27FF18B10AD519 = getdvarint("dvar_28D450F7F28644B7", 0);
  level._id_6835A3D279520DC9 = getdvarint("dvar_2BCFBE19DAC56DD7", 3);
  level._id_699BB1FCAE5B2EEE = getdvarint("dvar_BE3A8D807C217559", 1);
  level._id_23960E36343A87A6 = getdvarint("dvar_571F1AB18FCF566C", 1);
  level._id_1FE86BFC07EAA587 = getdvarint("scr_br_platesactivatequickfix", 0);
  level._id_27720C0C325958C1 = getdvarint("dvar_D2591F329D2EC7D4", 1) > 0;
  scripts\cp_mp\utility\damage_utility::_id_0ABFCDEE8FDA20A4();

  if(!istrue(level._id_D73697030C5D4E05)) {
    return;
  }
  level.onhelmetsniped = ::onhelmetsniped;
}

_id_13CAA305C839A278(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "try_use_heal_slot") {
    _id_57D8F859DC2DD35D = _id_E1D097C517C3AF5B;
    _id_C84CDF4DBD2B7B98 = 1;
    self._id_D26F815B7EB18327 = undefined;

    if(_id_57D8F859DC2DD35D == 1) {
      _id_C84CDF4DBD2B7B98 = self getammocount(_id_46CD39650BEB293F());
      self._id_D26F815B7EB18327 = 1;
    } else if(isDefined(self.armorqueued) && self.armorqueued > 0 && _id_57D8F859DC2DD35D == 2)
      _id_C84CDF4DBD2B7B98 = 0;

    thread _id_9F1608BD570DD94C(_id_C84CDF4DBD2B7B98);
  }
}

initarmor(_id_B5C8BC15F7117B19) {
  if(!istrue(level._id_D73697030C5D4E05)) {
    return;
  }
  if(!istrue(_id_B5C8BC15F7117B19))
    self.armorhealth = 0;

  _id_407C627FC7915153 = 150;

  if(scripts\common\utility::iscp()) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_extra_armor"))
      _id_2E1D1AF8AFE39BA8 = 3;
    else
      _id_2E1D1AF8AFE39BA8 = 2;

    _id_407C627FC7915153 = 120 * _id_2E1D1AF8AFE39BA8;
    self._id_BED158A6DFAC230D = _id_2E1D1AF8AFE39BA8;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk") || istrue(self._id_163E87B7D147DF4E)) {
      if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_increased_armor_health") || istrue(self._id_163E87B7D147DF4E))
        _id_407C627FC7915153 = 540;
    }

    self._id_8790C077C95DB752 = _id_407C627FC7915153;

    if(istrue(_id_B5C8BC15F7117B19)) {
      _id_3E955591D6FEBC8D = self getammocount(_id_46CD39650BEB293F());
      _id_7293FBE4C07E316F(_id_3E955591D6FEBC8D);
      return;
    }

    _id_2BE3084F26829EAC(0);
    _id_AC7803D45979135C(0, 1);
    return;
  }

  if(istrue(level._id_FB2B3C3DB6061DF5)) {
    _id_2E1D1AF8AFE39BA8 = getdvarint("scr_br_plate_carrier_start_level", 3);

    if(isDefined(level.gametype) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("instanceInventory", "restorePlateCarrier"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("instanceInventory", "restorePlateCarrier")]](self);

        if(isbot(self))
          _id_2E1D1AF8AFE39BA8 = getdvarint("scr_br_plate_carrier_br_start_level", 2);
        else
          _id_2E1D1AF8AFE39BA8 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzPlateCarrierLevel");

        _id_0CB44A7B7EDD34BD = getdvarint("dvar_8F2B4D22DCDC9934", -1);

        if(_id_0CB44A7B7EDD34BD != -1)
          _id_2E1D1AF8AFE39BA8 = _id_0CB44A7B7EDD34BD;
      } else {
        _id_2E1D1AF8AFE39BA8 = getdvarint("scr_br_plate_carrier_br_start_level", 2);
        _id_7293FBE4C07E316F(_id_2E1D1AF8AFE39BA8);
      }

      if(istrue(level._id_7F3AAFCF56C9CE14) && !isDefined(self._id_04045F099F3DA4BD) && _id_2E1D1AF8AFE39BA8 > 1)
        self._id_04045F099F3DA4BD = "brloot_plate_carrier_" + _id_2E1D1AF8AFE39BA8;
    }

    self._id_BED158A6DFAC230D = _id_2E1D1AF8AFE39BA8;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_407C627FC7915153 = 50 * _id_2E1D1AF8AFE39BA8;
      self._id_34867328231CA54B = _id_407C627FC7915153;
    }
  }

  self._id_8790C077C95DB752 = getdvarint("dvar_9C790ECB6CCEF79A", _id_407C627FC7915153);
  _id_2BE3084F26829EAC(0);
  _id_AC7803D45979135C(0, 1);
}

givestartingarmor(_id_D16569F10048FCE9, _id_10FD8ED3FED0E0AE, _id_AC1D8E40765A422E) {
  if(!istrue(level._id_D73697030C5D4E05)) {
    return;
  }
  if(istrue(level._id_1F9A4D8F7E4586BB)) {
    _id_BE5C0CDFA0202544();
    return;
  }

  if(!_id_A024D9111228A85E()) {
    if(istrue(self._id_D4BFB0D4D797F448)) {
      self._id_D4BFB0D4D797F448 = undefined;
      return;
    }

    _id_BE5C0CDFA0202544();
    return;
  }

  if(!istrue(level.br_prematchstarted) && getdvarint("dvar_4F0D66BB284EADD7", 1) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getDvar("dvar_7611A2790A0BF7FE", "") != "dmz") {
    if(isDefined(self.c130)) {
      _id_D16569F10048FCE9 = getdvarint("dvar_34CF7BA2E01ABB6E", 100);
      _id_AC1D8E40765A422E = getdvarint("dvar_19F5EC6621CA72B3", 0);
    } else {
      _id_D16569F10048FCE9 = getdvarint("dvar_CCBA9A492FBCFC42", 100);
      _id_AC1D8E40765A422E = getdvarint("dvar_3750034C54D1966F", 3);
    }
  }

  if(isDefined(level._id_3C8E175D92BE01EA))
    [_id_D16569F10048FCE9, _id_10FD8ED3FED0E0AE] = [[level._id_3C8E175D92BE01EA]](self);

  if(!isDefined(_id_D16569F10048FCE9))
    _id_D16569F10048FCE9 = self._id_34867328231CA54B;

  if(!isDefined(_id_D16569F10048FCE9))
    _id_D16569F10048FCE9 = level._id_34867328231CA54B;

  _id_AC7803D45979135C(_id_D16569F10048FCE9, 1);

  if(istrue(self._id_57C207FDE9B78089))
    self._id_57C207FDE9B78089 = undefined;

  if(!isDefined(_id_10FD8ED3FED0E0AE))
    _id_10FD8ED3FED0E0AE = level._id_BF6C149BC4124962;

  if(!isDefined(_id_AC1D8E40765A422E))
    _id_AC1D8E40765A422E = _id_10FD8ED3FED0E0AE;

  _id_B44E627D6A911F55 = scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73();

  if(_id_B44E627D6A911F55 && isDefined(self.equipment))
    self.equipment["health"] = "equip_armorplate";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getDvar("dvar_7611A2790A0BF7FE", "") != "dmz") {
    if(isDefined(_id_10FD8ED3FED0E0AE) && _id_10FD8ED3FED0E0AE > getdvarint("scr_br_plate_carrier_br_start_level", 3))
      self._id_BED158A6DFAC230D = _id_10FD8ED3FED0E0AE;
    else
      self._id_BED158A6DFAC230D = getdvarint("scr_br_plate_carrier_br_start_level", 3);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isInGulagCheck")) {
      _id_1B7F5108008D55B6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isInGulagCheck")]]();

      if(_id_1B7F5108008D55B6)
        _id_10FD8ED3FED0E0AE = 0;
    }

    _id_AC7803D45979135C(_id_D16569F10048FCE9);
  }

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    _id_10FD8ED3FED0E0AE = _id_10FD8ED3FED0E0AE + self.pers["armor_buy_plates"];

  if(isDefined(self._id_D0205933322679A9)) {
    _id_10FD8ED3FED0E0AE = _id_10FD8ED3FED0E0AE + self._id_D0205933322679A9;
    self._id_D0205933322679A9 = undefined;
  }

  self giveweapon(_id_46CD39650BEB293F());
  self setclientomnvar("ui_equipment_id_health", 27);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("instanceInventory", "getNumStartUpgradePlates"))
    _id_10FD8ED3FED0E0AE = [[scripts\cp_mp\utility\script_utility::getsharedfunc("instanceInventory", "getNumStartUpgradePlates")]](self);

  _id_225CC3A0A507A66A = _id_10FD8ED3FED0E0AE;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getDvar("dvar_7611A2790A0BF7FE", "") != "dmz")
    _id_225CC3A0A507A66A = _id_AC1D8E40765A422E;

  if(_id_AC1D8E40765A422E < 0) {
    _id_BE5C0CDFA0202544();
    return;
  }

  _id_7293FBE4C07E316F(_id_225CC3A0A507A66A);
}

_id_BE5C0CDFA0202544() {
  self setclientomnvar("ui_equipment_id_health", 27);
  _id_7293FBE4C07E316F(0);
}

_id_46CD39650BEB293F() {
  if(isDefined(level.equipment.table["equip_armorplate"]))
    return level.equipment.table["equip_armorplate"].objweapon;

  if(!isDefined(level._id_AE24A96D67A946A9))
    level._id_AE24A96D67A946A9 = makeweapon("iw9_armor_plate_deploy_mp");

  return level._id_AE24A96D67A946A9;
}

hasarmor() {
  return isDefined(self.armorhealth) && self.armorhealth > 0;
}

_id_9BCA5C1D23A3E0B3() {
  if(!isDefined(self.armorhealth) || !isDefined(self._id_8790C077C95DB752))
    return 0;

  if(istrue(level._id_FB2B3C3DB6061DF5))
    return int((self.armorhealth + 5) / level._id_4B78859BACC88808) >= 3;
  else
    return _id_E47B13BABB51A365();
}

_id_AC266FC218266D08() {
  if(!istrue(level._id_D73697030C5D4E05))
    return 0;

  return self.armorhealth;
}

_id_AC7803D45979135C(value, _id_5FB98290D356D5DD) {
  if(!isDefined(value)) {
    return;
  }
  self.armorhealth = int(clamp(value, 0, self._id_8790C077C95DB752));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setArmorOmnvars"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setArmorOmnvars")]](_id_5FB98290D356D5DD);
  else
    _id_CF547D762189DEAA(_id_5FB98290D356D5DD);
}

_id_0600F6CF462E983F() {
  return self getammocount(_id_46CD39650BEB293F());
}

_id_77B7145C92102847(armorhealth) {
  if(level._id_4B78859BACC88808 > 0) {
    _id_4970AC49EA82AB16 = float(armorhealth) / float(level._id_4B78859BACC88808);
    return int(ceil(_id_4970AC49EA82AB16));
  }

  return 0;
}

_id_9C6E9A6643B6C9A6(_id_7BD6E41EA1E31283) {
  if(!isDefined(_id_7BD6E41EA1E31283))
    _id_7BD6E41EA1E31283 = 1;

  current = self getammocount(_id_46CD39650BEB293F());
  _id_7293FBE4C07E316F(current + _id_7BD6E41EA1E31283);
}

_id_047320A25B8EE003() {
  _id_A81ADEB0E1F89320 = 5;

  if(isDefined(level._id_4941FC1EE570D4CB) && (istrue(level._id_FB2B3C3DB6061DF5) || scripts\common\utility::iscp())) {
    _id_A81ADEB0E1F89320 = [[level._id_4941FC1EE570D4CB]]();
    return _id_A81ADEB0E1F89320;
  }

  if(istrue(self.hasplatepouch))
    _id_A81ADEB0E1F89320 = _id_A81ADEB0E1F89320 + level._id_6835A3D279520DC9;

  return _id_A81ADEB0E1F89320;
}

_id_79E0AB2AA0304A2C() {
  current = self getammocount(_id_46CD39650BEB293F());
  _id_A81ADEB0E1F89320 = _id_047320A25B8EE003();
  return current >= _id_A81ADEB0E1F89320;
}

damagearmor(damage, _id_3773B3D5CCE15DCE, attacker, _id_5FB98290D356D5DD) {
  if(!hasarmor())
    return damage;

  if(isDefined(level._id_E8F60267621FDA8D))
    _id_787585D4E82E1E58 = self[[level._id_E8F60267621FDA8D]](damage);
  else
    _id_787585D4E82E1E58 = int(min(self.armorhealth, damage));

  _id_C022505DB080EF7C = damage - _id_787585D4E82E1E58;
  _id_AC7803D45979135C(self.armorhealth - _id_787585D4E82E1E58, _id_5FB98290D356D5DD);

  if(!istrue(_id_3773B3D5CCE15DCE)) {
    if(self.armorhealth == 0 && _id_787585D4E82E1E58 > 0)
      thread _id_8832743697109F0D(attacker);
  }

  if(self.armorhealth == 0 && isDefined(self._id_8C5C47F81A1869E5))
    [[self._id_8C5C47F81A1869E5]](self, attacker);

  if(isPlayer(attacker) && self.armorhealth == 0 && _id_787585D4E82E1E58 > 0)
    attacker thread _id_189B67B2735B981D::_id_556866C3C047A8B8(self);

  if(scripts\engine\utility::ent_flag("frenzied_guard_active") && self.armorhealth > 0)
    _id_C022505DB080EF7C = 0;

  return _id_C022505DB080EF7C;
}

_id_8832743697109F0D(attacker) {
  wait 0.2;

  if(isDefined(self) && isalive(self)) {
    if(isPlayer(self)) {
      self playsoundtoplayer("hit_marker_armor_break_plr", self);
      self setscriptablepartstate("armor_break", "armor_break", 0);
    } else if(isDefined(attacker) && isPlayer(attacker) && isalive(attacker))
      self playsoundtoplayer("hit_marker_3d_armor_break", attacker, self);
  }
}

breakarmor() {
  damagearmor(self.armorhealth, 1);
}

_id_3F8A6F9DA782D418() {
  _id_CE50C3E3E9D89E29 = self.armorhealth / self._id_8790C077C95DB752;

  if(istrue(level._id_FB2B3C3DB6061DF5))
    _id_CE50C3E3E9D89E29 = self.armorhealth / 150;

  return _id_CE50C3E3E9D89E29;
}

_id_55811FC89CF705B5() {
  _id_16DA20E6451D7744 = [0.67, 0.34, 0];
  _id_424327452369B290 = self getclientomnvar("ui_armor_percent");
  _id_F0C90B3263CC3702 = _id_3F8A6F9DA782D418();
  _id_E9EFE053D24B91D3 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16DA20E6451D7744.size; _id_AC0E594AC96AA3A8++) {
    if(_id_424327452369B290 > _id_16DA20E6451D7744[_id_AC0E594AC96AA3A8] && _id_F0C90B3263CC3702 <= _id_16DA20E6451D7744[_id_AC0E594AC96AA3A8])
      _id_E9EFE053D24B91D3++;
  }

  return _id_E9EFE053D24B91D3;
}

_id_CF547D762189DEAA(_id_5FB98290D356D5DD) {
  if(!isPlayer(self)) {
    return;
  }
  _id_CE50C3E3E9D89E29 = _id_3F8A6F9DA782D418();

  if(!istrue(_id_5FB98290D356D5DD)) {
    if(isDefined(self.pers["telemetry"]._id_5E444DBA2B86C3AC)) {
      _id_E9EFE053D24B91D3 = _id_55811FC89CF705B5();

      if(_id_E9EFE053D24B91D3 > 0)
        self.pers["telemetry"]._id_5E444DBA2B86C3AC = self.pers["telemetry"]._id_5E444DBA2B86C3AC + _id_E9EFE053D24B91D3;
    }
  }

  self setclientomnvar("ui_armor_percent", _id_CE50C3E3E9D89E29);
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(!isDefined(squadmemberindex) || !isDefined(self.team) || squadmemberindex == -1) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A()) {
    squadmemberindex = 0;
    self setclientomnvar("ui_armor_squad_index_" + squadmemberindex, int(self.armorhealth));
  } else
    _id_1B593D5E688A409C();
}

_id_1B593D5E688A409C() {
  _id_607DA387F3617ED1 = level.teamdata[self.team]["players"];

  if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A]))
    _id_607DA387F3617ED1 = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

  if(!isDefined(_id_607DA387F3617ED1))
    _id_607DA387F3617ED1 = level.players;

  armorhealth = int(self.armorhealth);
  _id_388CDEBC14DD4AA4 = self._id_8790C077C95DB752;
  _id_5524B1700566D195 = 0;
  _id_8ED19FD39D6993CF = 150;
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(squadmemberindex == -1) {
    return;
  }
  if(istrue(level._id_FB2B3C3DB6061DF5)) {
    _id_388CDEBC14DD4AA4 = 150;
    _id_5524B1700566D195 = 256;
    _id_8ED19FD39D6993CF = 8191;
  }

  _id_CABC886D846DD979 = int(armorhealth * 150 / _id_388CDEBC14DD4AA4);

  if(istrue(level._id_FB2B3C3DB6061DF5)) {
    _id_8F098991D1E07346 = self._id_BED158A6DFAC230D << 8;
    _id_CABC886D846DD979 = _id_CABC886D846DD979 + _id_8F098991D1E07346;
    _id_7610674E1F362875 = _id_8775D4E6734630C0(self);
    _id_6F0CFCE91BA1FEB3 = _id_7610674E1F362875 << 10;
    _id_CABC886D846DD979 = _id_CABC886D846DD979 + _id_6F0CFCE91BA1FEB3;
  }

  if(!isDefined(_id_CABC886D846DD979))
    _id_CABC886D846DD979 = _id_5524B1700566D195;
  else
    _id_CABC886D846DD979 = int(clamp(_id_CABC886D846DD979, _id_5524B1700566D195, _id_8ED19FD39D6993CF));

  foreach(player in _id_607DA387F3617ED1) {
    if(isDefined(player))
      player setclientomnvar("ui_armor_squad_index_" + squadmemberindex, _id_CABC886D846DD979);
  }
}

_id_774133DC8DF0CCD5(_id_10FD8ED3FED0E0AE) {
  _id_7293FBE4C07E316F(_id_10FD8ED3FED0E0AE);
}

_id_7293FBE4C07E316F(_id_10FD8ED3FED0E0AE) {
  _id_7EB0A2A2BEDF8DFC = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("backpack", "isBackpackInventoryEnabled"))
    _id_7EB0A2A2BEDF8DFC = [[scripts\cp_mp\utility\script_utility::getsharedfunc("backpack", "isBackpackInventoryEnabled")]]();

  _id_A81ADEB0E1F89320 = _id_047320A25B8EE003();

  if(isDefined(_id_7EB0A2A2BEDF8DFC) && !_id_7EB0A2A2BEDF8DFC)
    _id_10FD8ED3FED0E0AE = int(clamp(_id_10FD8ED3FED0E0AE, 0, _id_A81ADEB0E1F89320));

  if(istrue(_id_7EB0A2A2BEDF8DFC) || scripts\common\utility::iscp()) {
    _id_2C86AF91E7E20602 = 0;
    _id_CA0B74003E73B2DD = _id_A81ADEB0E1F89320 - _id_10FD8ED3FED0E0AE;

    if(_id_CA0B74003E73B2DD > 0 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("backpack", "removeSmallestItemStackBackpack"))
      _id_2C86AF91E7E20602 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("backpack", "removeSmallestItemStackBackpack")]]("brloot_armor_plate", _id_CA0B74003E73B2DD);
    else if(_id_CA0B74003E73B2DD < 0 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("backpack", "addItemToBackpack"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("backpack", "addItemToBackpackByRef")]]("brloot_armor_plate", "consumable", _id_CA0B74003E73B2DD * -1);

    _id_1C9DC6C0F33953CD = int(min(_id_A81ADEB0E1F89320, _id_A81ADEB0E1F89320 - _id_2C86AF91E7E20602));
    self setweaponammoclip(_id_46CD39650BEB293F(), _id_1C9DC6C0F33953CD);
    self setclientomnvar("ui_equipment_id_health_numCharges", _id_1C9DC6C0F33953CD);

    if(isDefined(self.equipment)) {
      self.equipment["health"] = "equip_armorplate";
      return;
    }
  } else {
    _id_A81ADEB0E1F89320 = _id_047320A25B8EE003();
    _id_10FD8ED3FED0E0AE = int(clamp(_id_10FD8ED3FED0E0AE, 0, _id_A81ADEB0E1F89320));
    self setweaponammoclip(_id_46CD39650BEB293F(), _id_10FD8ED3FED0E0AE);
    self setclientomnvar("ui_equipment_id_health_numCharges", _id_10FD8ED3FED0E0AE);
  }
}

_id_EF6D8B8C2ED89E8A(count) {
  if(self _meth_E8E6D2926FD6D61E()) {
    if(!self _meth_4A13111B050F0B72() || !istrue(self._id_B43706CBB600FE5A)) {
      waitframe();
      amount = 1;

      if(isDefined(count))
        amount = count;

      if(self _meth_6ADB0980232F3EFF())
        amount = self getammocount(_id_46CD39650BEB293F());

      if(amount) {
        self._id_B846F916AF2F7782 = 1;
        _id_9F1608BD570DD94C(amount);
        self._id_B43706CBB600FE5A = 1;
      }
    }
  }
}

_id_9F1608BD570DD94C(_id_C84CDF4DBD2B7B98) {
  if(!istrue(level._id_D73697030C5D4E05)) {
    return;
  }
  self endon("death_or_disconnect");
  self notify("try_use_heal_slot");

  if(!_id_CF37789D18FBCC1B()) {
    return;
  }
  if(!isDefined(_id_C84CDF4DBD2B7B98))
    _id_C84CDF4DBD2B7B98 = 1;

  if(istrue(self.insertingarmorplate)) {
    if(canqueuearmorbydefault())
      _id_2BE3084F26829EAC(self.armorqueued + _id_C84CDF4DBD2B7B98);
  } else {
    _id_2BE3084F26829EAC(_id_C84CDF4DBD2B7B98);
    self._id_D322EFB4EE20D7FD = 0;
    self._id_1A3CFA051795CEA3 = 0;
  }

  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "use_armor");
  thread _id_F2A4A5AED60E552D();
}

_id_2BE3084F26829EAC(_id_D2A5DDC13D5CED30) {
  _id_971D04134A431BFD = int(self.armorhealth / level._id_4B78859BACC88808);
  _id_1688C3E909C6563F = self._id_8790C077C95DB752 / level._id_4B78859BACC88808;
  _id_0A02589DFAAA6749 = _id_1688C3E909C6563F - _id_971D04134A431BFD;
  _id_F18C4218C7058E95 = int((self.armorhealth + 5) / level._id_4B78859BACC88808);
  _id_2D430AF8E8AEA492 = self._id_8790C077C95DB752 - self.armorhealth > level._id_4B78859BACC88808;

  if(_id_2D430AF8E8AEA492 && _id_F18C4218C7058E95 > _id_971D04134A431BFD)
    _id_0A02589DFAAA6749 = _id_1688C3E909C6563F - _id_F18C4218C7058E95;

  _id_73BD1164E54E82BA = self getammocount(_id_46CD39650BEB293F());
  _id_D2A5DDC13D5CED30 = clamp(_id_D2A5DDC13D5CED30, 0, min(_id_0A02589DFAAA6749, _id_73BD1164E54E82BA));
  self.armorqueued = _id_D2A5DDC13D5CED30;
  self setclientomnvar("ui_armor_queued_count", int(_id_D2A5DDC13D5CED30));
}

_id_F2A4A5AED60E552D() {
  self endon("disconnect");

  if(istrue(self.insertingarmorplate) || self isswitchingweapon()) {
    return;
  }
  _id_16C2D930984F2FEF = self isreloading();

  if(_id_16C2D930984F2FEF) {
    _id_5814D27874B48E54 = spawnStruct();
    _id_5814D27874B48E54.player = self;
    _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
    _id_5814D27874B48E54._id_C198F7CA473378FB = "EQUIP_ARMOR";
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
  }

  weaponobj = makeweapon("iw9_armor_plate_deploy_mp");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", self);
  streakinfo.armorweapon = weaponobj;
  streakinfo._id_9D7C6EE83F507A26 = _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch") || _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("script_weapon_switch");
  _id_43D4382B6CEA4DF9(1);
  thread _id_1240021A9C87BCDB();
  thread watchgameend(streakinfo);
  _id_41BF9BF4918115AC = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::_id_0A86A98DE3E7986B, undefined, undefined, undefined, undefined, 0);

  if(isDefined(_id_41BF9BF4918115AC) && !istrue(_id_41BF9BF4918115AC))
    self notify("try_armor_cancel", "switch_failed");
}

usearmorplate() {
  if(isDefined(self.armorqueued)) {
    _id_1D614448F6CAC2D7 = self.armorqueued - 1;

    if(istrue(self._id_D26F815B7EB18327) && !self._id_1A3CFA051795CEA3)
      _id_1D614448F6CAC2D7 = 1;

    _id_2BE3084F26829EAC(_id_1D614448F6CAC2D7);
  }

  _id_1C07EF7BC0E3723A = 0;

  if(isDefined(level._id_03DAF6A38C04A7DD))
    _id_1C07EF7BC0E3723A = self[[level._id_03DAF6A38C04A7DD]]();
  else if(level._id_699BB1FCAE5B2EEE == 1) {
    _id_43167C86311C997E = max(1, _id_85E373BB15921966());
    _id_1C07EF7BC0E3723A = int(self.armorhealth + _id_43167C86311C997E);
  } else {
    _id_830009CEFCE35A66 = self.armorhealth + 5;
    _id_1C07EF7BC0E3723A = clamp(_id_830009CEFCE35A66, 0, self._id_8790C077C95DB752);
    _id_43167C86311C997E = max(1, _id_85E373BB15921966());
    _id_1C07EF7BC0E3723A = int(_id_1C07EF7BC0E3723A / _id_43167C86311C997E) * _id_43167C86311C997E + _id_43167C86311C997E;
  }

  if(isDefined(self.pers["telemetry"]._id_9BC5683C9FE914F0))
    self.pers["telemetry"]._id_9BC5683C9FE914F0++;

  _id_AC7803D45979135C(_id_1C07EF7BC0E3723A);
  _id_3E955591D6FEBC8D = self getammocount(_id_46CD39650BEB293F());
  _id_CFCB8FC02F9DB4DC = int(max(0, _id_3E955591D6FEBC8D - 1));
  _id_7293FBE4C07E316F(_id_CFCB8FC02F9DB4DC);

  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    self.pers["armor_buy_plates"] = _id_CFCB8FC02F9DB4DC;

  scripts\cp_mp\challenges::onuseitem("armor_plate");

  if(scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_reduce_regen_delay_on_plate") && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && level._id_1FE86BFC07EAA587)
    _id_7F2CFC2CED509047();

  if(isDefined(self._id_D322EFB4EE20D7FD))
    self._id_D322EFB4EE20D7FD = self._id_D322EFB4EE20D7FD + 1;

  self notify("armor_plate_inserted");

  if(_id_AC266FC218266D08() == self._id_8790C077C95DB752)
    level notify("equiped_full_armor_" + self.team, self);
}

_id_7F2CFC2CED509047() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("regenDelayReduce_delayedRegen");
  self endon("regenDelayReduce_delayedRegen");
  _id_0372301AF73968CB::_id_5457F0107A845374("regenDelayReduce_delayedRegen", 1.0, 140);
}

_id_85E373BB15921966() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk") || istrue(self._id_163E87B7D147DF4E)) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_increased_armor_health") || istrue(self._id_163E87B7D147DF4E))
      return int(self._id_8790C077C95DB752 / 3);
    else if(istrue(level._id_7F3AAFCF56C9CE14) && self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_pc_tempered") && isDefined(self._id_42294CC94C3BF2C3))
      return self._id_42294CC94C3BF2C3;
  }

  return level._id_4B78859BACC88808;
}

_id_77A293180F44E63C() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    return self _meth_96F814CC20CBF3D5() && self._id_D322EFB4EE20D7FD == 0;
  else
    return self _meth_96F814CC20CBF3D5();
}

_id_4504B6B6771998BB(_id_401C3A2E68AAB0FD) {
  self endon("insertArmorComplete");
  self endon("disconnect");

  if(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
    highpriorityweapon = self gethighpriorityweapon();

    if(!isnullweapon(highpriorityweapon))
      self clearhighpriorityweapon(highpriorityweapon);

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.currentweapon);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  }

  self notify("armor_cancel", _id_401C3A2E68AAB0FD);
}

_id_1240021A9C87BCDB() {
  self endon("insertArmorComplete");
  self endon("disconnect");
  _id_451B277F45C6174F();
  thread _id_A5E267FD4B705FD6();
  thread _id_D9C269FB5751937B();
  self.stoparmorinsert = 0;

  for(;;) {
    childthread _id_EBBB01A971EDD5B3();
    childthread _id_8A7D870C4615A027();
    self waittill("armor_cancel", _id_E75F0523BC1DBDE8, _id_AD20D588BCE2CE99);
    self notify("armor_cancel_watch_stop");

    if(_id_E75F0523BC1DBDE8 == "try_armor_cancel" && _id_77A293180F44E63C()) {
      self setclientomnvar("ui_armor_forced_notify", gettime());

      if(isDefined(self.armorqueued) && self.armorqueued > 1) {
        if(getdvarint("dvar_C7714FE0D53C925C", 1) == 1)
          _id_2BE3084F26829EAC(1);
      }

      self._id_1A3CFA051795CEA3 = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
      continue;
    }

    if(!isbot(self) && istrue(self._id_B846F916AF2F7782))
      _id_9CDA8706BC1D6A7D(_id_E75F0523BC1DBDE8, _id_AD20D588BCE2CE99);

    break;
  }

  self notify("cancel_all_killstreak_deployments");
  self.stoparmorinsert = 1;
  self._id_B846F916AF2F7782 = 0;
  thread _id_22E06081220ED098();
}

watchgameend(streakinfo) {
  self endon("disconnect");
  self endon("armor_plate_done");
  level waittill("game_ended");
  scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(streakinfo.armorweapon);
}

_id_A5E267FD4B705FD6() {
  self endon("disconnect");
  self endon("insertArmorComplete");
  msg = scripts\engine\utility::waittill_any_return_3("player_switched_weapon", "player_switched_to_grenade", "player_interaction");
  self notify("try_armor_cancel", msg);
}

_id_D9C269FB5751937B() {
  self endon("disconnect");
  self endon("insertArmorComplete");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename != "iw9_armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("try_armor_cancel", "ladder_used");

    waitframe();
  }

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("try_armor_cancel", "ladder_used");

    waitframe();
  }

  self notify("try_armor_cancel", "armor_unselected");
}

_id_EBBB01A971EDD5B3() {
  self endon("armor_cancel_watch_stop");
  self waittill("try_armor_cancel", _id_51B71F011305B016);
  self notify("armor_cancel", "try_armor_cancel", _id_51B71F011305B016);
}

_id_8A7D870C4615A027() {
  self endon("armor_cancel_watch_stop");
  msg = scripts\engine\utility::waittill_any_return_6("death", "mantle_start", "last_stand_start", "scr_change_swim_state", "special_weapon_fired", "armor_plate_done");
  self notify("armor_cancel", msg);
}

_id_9CDA8706BC1D6A7D(_id_E75F0523BC1DBDE8, _id_AD20D588BCE2CE99) {
  _id_5814D27874B48E54 = spawnStruct();
  _id_5814D27874B48E54.player = self;
  _id_5814D27874B48E54._id_E75F0523BC1DBDE8 = _id_E75F0523BC1DBDE8;
  _id_5814D27874B48E54._id_AD20D588BCE2CE99 = _id_AD20D588BCE2CE99;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_armor_auto_apply", _id_5814D27874B48E54);
}

canqueuearmorbydefault() {
  return !scripts\engine\utility::is_player_gamepad_enabled();
}

_id_43D4382B6CEA4DF9(_id_E12D78C11D85D9C2) {
  if(_id_E12D78C11D85D9C2) {
    if(self _meth_96F814CC20CBF3D5()) {
      _id_3B64EB40368C1450::set("armor", "weapon_switch", 0);
      _id_3B64EB40368C1450::set("armor", "script_weapon_switch", 0);
      _id_3B64EB40368C1450::set("armor", "mantle", 0);
    }

    _id_3B64EB40368C1450::set("armor", "melee", 0);
    _id_3B64EB40368C1450::set("armor", "killstreaks", 0);
    _id_3B64EB40368C1450::set("armor", "supers", 0);
    _id_3B64EB40368C1450::set("armor", "crate_use", 0);
    _id_3B64EB40368C1450::set("armor", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("armor", "offhand_throwback", 0);
    _id_3B64EB40368C1450::set("armor", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("armor", "supersprint", 0);

    if(!istrue(level._id_27720C0C325958C1))
      _id_3B64EB40368C1450::set("armor", "sprint", 0);

    self _meth_8B7829A01E6B58AA(0);
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("armor");
    self _meth_8B7829A01E6B58AA(1);
  }

  self.insertingarmorplate = _id_E12D78C11D85D9C2;
  self setclientomnvar("ui_inserting_armor_plate", _id_E12D78C11D85D9C2);
}

_id_0A86A98DE3E7986B(streakinfo) {
  self endon("disconnect");
  self endon("insertArmorComplete");

  if(!_id_CF37789D18FBCC1B() || istrue(self.stoparmorinsert)) {
    return;
  }
  currenttime = gettime();
  _id_796BA59FC6C2AC9B = currenttime + 1300.0;
  _id_3F536CBD3A3C3591 = 1567.0;
  _id_FD3A2BB4C34A405C = 1300.0;
  _id_48115C25C4A06354 = 0;
  self setclientomnvar("ui_inserting_armor_plate_timer", 1567.0);

  while(currenttime < _id_796BA59FC6C2AC9B) {
    if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
      return;
    }
    waitframe();
    currenttime = gettime();
  }

  usearmorplate();
  self setclientomnvar("ui_inserting_armor_plate_timer", 0);
  _id_4D5F2C05F11DB0EC = (_id_3F536CBD3A3C3591 - _id_FD3A2BB4C34A405C) / 1000;
  wait(_id_4D5F2C05F11DB0EC);

  while(_id_4E03F222ED8B54A1()) {
    _id_BEF0447316D92BFD = gettime() + 900.0;
    self setclientomnvar("ui_inserting_armor_plate_timer", 1133.0);

    while(gettime() < _id_BEF0447316D92BFD) {
      if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
        return;
      }
      waitframe();
    }

    usearmorplate();
    self setclientomnvar("ui_inserting_armor_plate_timer", 0);
    _id_0CF97CAF9E7EC424 = 0.233;
    wait(_id_0CF97CAF9E7EC424);
  }

  self notify("armor_plate_done");
}

_id_22E06081220ED098() {
  self endon("disconnect");
  self notify("insertArmorComplete");
  _id_25AAE4D93A36C291();
  _id_3B64EB40368C1450::set("armor", "supers", 1);

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp")
    waitframe();

  waitframe();
  _id_2BE3084F26829EAC(0);
  _id_43D4382B6CEA4DF9(0);
}

_id_CF37789D18FBCC1B() {
  if(!isalive(self) || self isparachuting() || self isskydiving() || self isonladder() || self _meth_9CC921A57FF4DEB5())
    return 0;

  if(self.armorhealth >= self._id_8790C077C95DB752)
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("armor"))
    return 0;

  if(istrue(self.inlaststand) || isDefined(self.usingremote) || istrue(self.isdeploying) || istrue(self.usingascender) || scripts\cp_mp\utility\player_utility::_id_B7869F6D9D4242E3(self) || istrue(self.isjuggernaut) || istrue(self._id_859654E0445A36D9))
    return 0;

  if(!istrue(self._id_4B6E638CB12A3E90) && isDefined(self.super) && istrue(self.super.isinuse) && !_id_9719A1E79DE2989F(self.super.staticdata.ref))
    return 0;

  _id_3E955591D6FEBC8D = self getammocount(_id_46CD39650BEB293F());

  if(_id_3E955591D6FEBC8D == 0)
    return 0;

  return 1;
}

_id_9719A1E79DE2989F(_id_5237A188CCDA4D7B) {
  if(!isDefined(_id_5237A188CCDA4D7B))
    return 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superHasTimedUsage")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superHasTimedUsage")]](self.super))
      return 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superHasAmmoUsage")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superHasAmmoUsage")]](self.super))
      return 1;
  }

  return 0;
}

_id_4E03F222ED8B54A1() {
  if(!_id_CF37789D18FBCC1B())
    return 0;

  _id_A5EA2300EFAAA6A7 = scripts\engine\utility::is_player_gamepad_enabled() && self weaponswitchbuttonPressed();
  _id_1D20666098BAA9F9 = isDefined(self.armorqueued) && self.armorqueued > 0;
  return _id_A5EA2300EFAAA6A7 || _id_1D20666098BAA9F9;
}

_id_451B277F45C6174F() {
  if(!isbot(self)) {
    self notifyonplayercommand("player_switched_weapon", "+weapnext");
    self notifyonplayercommand("player_switched_weapon", "+weapprev");
    self notifyonplayercommand("player_switched_weapon", "selectweapon1");
    self notifyonplayercommand("player_switched_weapon", "selectweapon2");
    self notifyonplayercommand("player_switched_weapon", "selectweapon3");
    self notifyonplayercommand("player_interaction", "+ads_attack");
  }

  self notifyonplayercommand("player_interaction", "+attack");
  self notifyonplayercommand("player_switched_to_grenade", "+smoke");
  self notifyonplayercommand("player_switched_to_grenade", "+frag");
  self notifyonplayercommand("player_interaction", "+melee_zoom");
}

_id_25AAE4D93A36C291() {
  if(!isbot(self)) {
    self notifyonplayercommandremove("player_switched_weapon", "+weapnext");
    self notifyonplayercommandremove("player_switched_weapon", "+weapprev");
    self notifyonplayercommandremove("player_switched_weapon", "selectweapon1");
    self notifyonplayercommandremove("player_switched_weapon", "selectweapon2");
    self notifyonplayercommandremove("player_switched_weapon", "selectweapon3");
    self notifyonplayercommandremove("player_interaction", "+ads_attack");
  }

  self notifyonplayercommandremove("player_interaction", "+attack");
  self notifyonplayercommandremove("player_switched_to_grenade", "+smoke");
  self notifyonplayercommandremove("player_switched_to_grenade", "+frag");
  self notifyonplayercommandremove("player_interaction", "+melee_zoom");
}

hashelmet() {
  return isDefined(self.br_helmetlevel);
}

_id_47AD39003B16CF4C() {
  return isDefined(self.helmethealth) && self.helmethealth > 0;
}

helmetitemtypeforlevel(_id_9FB8A8EE3A677CEA) {
  switch (_id_9FB8A8EE3A677CEA) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

takehelmet(_id_73B1997698AE0DEB, _id_9FB8A8EE3A677CEA) {
  self.br_helmetlevel = _id_9FB8A8EE3A677CEA;
  _id_CB89110314447B2F = level.br_pickups.br_itemrow[_id_73B1997698AE0DEB.scriptablename];
}

_id_CD4A78B4A236DDC8(_id_DBD090CC010CD89B) {
  _id_9FB8A8EE3A677CEA = 0;

  if(_id_DBD090CC010CD89B == "equip_helmet_1")
    _id_9FB8A8EE3A677CEA = 1;
  else if(_id_DBD090CC010CD89B == "equip_helmet_2")
    _id_9FB8A8EE3A677CEA = 2;
  else if(_id_DBD090CC010CD89B == "equip_helmet_3")
    _id_9FB8A8EE3A677CEA = 3;

  if(_id_9FB8A8EE3A677CEA > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < _id_9FB8A8EE3A677CEA)
      return 1;
  }

  return 0;
}

_id_E71F062243EA8827(damage, _id_3773B3D5CCE15DCE, attacker) {
  if(!isDefined(self.helmethealth) || self.helmethealth <= 0)
    return damage;

  _id_0B9BC5879C1FD673 = damage - self.helmethealth;
  self.helmethealth = clamp(self.helmethealth - damage, 0, self._id_CFC69E5588A5BED6);

  if(istrue(self._id_895DAE193CFAAC3A)) {
    if(self.helmethealth / self._id_CFC69E5588A5BED6 < 0.45 && !istrue(self._id_250A0D62E13C6E73)) {
      self setscriptablepartstate("helmet", "damaged");
      self._id_250A0D62E13C6E73 = 1;
    }
  }

  if(self.helmethealth == 0) {
    if(isDefined(self._id_CD6A3A50F09688B9))
      [[self._id_CD6A3A50F09688B9]](self, attacker);

    if(!istrue(_id_3773B3D5CCE15DCE))
      thread _id_1D16645547AF7D5B(attacker);

    if(isDefined(attacker))
      attacker.brokehelmet = gettime();

    if(istrue(self._id_89610E737D06F12E))
      return 0;

    return _id_0B9BC5879C1FD673;
  }

  if(isDefined(attacker)) {
    attacker.hithelmet = gettime();
    thread _id_0908110BDFB8E8BA(attacker);
  }

  return 0;
}

_id_0908110BDFB8E8BA(attacker) {
  wait 0.15;

  if(isDefined(self) && isalive(self)) {
    if(isDefined(attacker) && isPlayer(attacker) && isalive(attacker)) {
      attacker playsoundtoplayer("bullet_plr_helmet_impact", attacker, self);
      self playSound("bullet_npc_helmet_impact", attacker, self);
    } else
      self playSound("bullet_npc_helmet_impact");
  }
}

_id_1D16645547AF7D5B(attacker) {
  wait 0.15;

  if(isDefined(self) && isalive(self)) {
    if(isDefined(attacker) && isPlayer(attacker) && isalive(attacker)) {
      attacker playsoundtoplayer("bullet_plr_helmet_break", attacker, self);
      self playSound("bullet_npc_helmet_break", attacker, self);
    } else
      self playSound("bullet_npc_helmet_break");
  }
}

damagehelmet(damage, _id_AC4A1F6F548136EA, _id_483B72BBC1109AB2) {
  if(!isDefined(_id_AC4A1F6F548136EA) || !level._id_23500029F84B30D0)
    _id_AC4A1F6F548136EA = 0;

  _id_84872288B2E0CE95 = 1;

  switch (self.br_helmetlevel) {
    case 1:
      _id_84872288B2E0CE95 = 0.85;
      break;
    case 2:
      _id_84872288B2E0CE95 = 0.7;
      break;
    case 3:
      _id_84872288B2E0CE95 = 0.7;
      break;
    default:
  }

  if(_id_AC4A1F6F548136EA) {
    if(isDefined(level.onhelmetsniped))
      [[level.onhelmetsniped]](self, _id_483B72BBC1109AB2);
  }

  return _id_84872288B2E0CE95;
}

popoffhelmet(_id_483B72BBC1109AB2, _id_3C70A7175FBFA3FC, playerorigin) {
  level endon("game_ended");
  _id_332F92D26F25D2BC = self gettagorigin("j_helmet");

  if(!isDefined(_id_332F92D26F25D2BC))
    _id_332F92D26F25D2BC = playerorigin + (0, 0, 80);

  helmet = spawn("script_model", self gettagorigin("j_helmet"));
  helmet setModel("loot_helmet");
  helmet.angles = _id_3C70A7175FBFA3FC;
  up = anglestoup(_id_3C70A7175FBFA3FC);
  forward = _id_483B72BBC1109AB2;
  vel = vectorNormalize(forward + up) * 2500;
  helmet physicslaunchserver(helmet.origin, vel);
  _id_73B1997698AE0DEB = "brloot_armor_helmet_" + self.br_helmetlevel;
  _id_29511A1C049E1067 = 15;
  _id_F246E6DC812FBCFE = 0.1;
  _id_29511A1C049E1067 = _id_29511A1C049E1067 * (1 / _id_F246E6DC812FBCFE);
  _id_30226C918113271E = helmet.origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_29511A1C049E1067; _id_AC0E594AC96AA3A8++) {
    wait(_id_F246E6DC812FBCFE);
    _id_76A2EA10CCBC4C62 = _id_30226C918113271E - helmet.origin;

    if(_id_76A2EA10CCBC4C62[0] < 2 && _id_76A2EA10CCBC4C62[1] < 2 && _id_76A2EA10CCBC4C62[2] < 2 && _id_76A2EA10CCBC4C62[0] > -2 && _id_76A2EA10CCBC4C62[1] > -2 && _id_76A2EA10CCBC4C62[2] > -2) {
      return;
    }
    _id_30226C918113271E = helmet.origin;
  }

  helmet delete();
}

onhelmetsniped(victim, _id_483B72BBC1109AB2) {
  if(isDefined(victim))
    victim thread popoffhelmet(_id_483B72BBC1109AB2, victim.angles, victim.origin);

  self.br_helmetlevel = undefined;
}

_id_92FEC40B905C5112() {
  if(isalive(self) && isDefined(self.armorhealth) && self.armorhealth < self._id_8790C077C95DB752)
    return 1;
  else if(self.pers["armor_buy_plates_instant"] < 3)
    return 1;

  return 0;
}

_id_4F88731347251184() {
  level endon("game_ended");
  self notify("buy_armor_instant");
  self endon("buy_armor_instant");

  while(!isalive(self))
    waitframe();

  waitframe();
  _id_AC7803D45979135C(int(clamp(self.armorhealth + self.pers["armor_buy_plates_instant"] * level._id_4B78859BACC88808, 0, self._id_8790C077C95DB752)));
  self.pers["armor_buy_plates_instant"] = 0;
}

_id_90CE8EB3DDAA4943(attacker, inflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_BE4285B26ED99AB1, _id_69CFD14B4398C458, partname) {
  _id_ED76DB33212E6A92 = idamage;
  _id_24DF708F286B0562 = idamage;
  _id_AE0F808555C671F9 = 0;
  _id_99A81DC3A8DEEBD6 = 0;
  _id_7820F81EE1ADF7B9 = victim hasarmor();

  if(isPlayer(attacker)) {
    armorvest_clearhit(attacker);
    armorvest_clearbroke(attacker);
  }

  if(_id_7820F81EE1ADF7B9 || scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE() && !istrue(victim.inlaststand)) {
    _id_E13E382321A8580B = shitloc == "shield" && smeansofdeath != "MOD_GRENADE_SPLASH";
    _id_94974807C7DC3ACF = _id_343613187BDF786F(objweapon, smeansofdeath) || istrue(victim.inlaststand) || _id_E13E382321A8580B;

    if(!istrue(_id_94974807C7DC3ACF) || scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE()) {
      _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      weapontype = weaponclass(objweapon);
      _id_520F3F243189CA25 = _id_AE24F0C0C8C6DE2A(objweapon, _id_49E6EF3EDADD524E, weapontype);

      if(smeansofdeath == "MOD_RIFLE_BULLET" && !_id_8B607CC9CC1EB155(objweapon) && !_id_23F2BCFE3327879B(objweapon)) {
        _id_24DF708F286B0562 = _id_BDB257C83AE70586(attacker, victim, idflags, _id_24DF708F286B0562, objweapon, smeansofdeath, _id_69CFD14B4398C458);

        if(_id_55C156D63BE9EBA2(objweapon))
          _id_24DF708F286B0562 = _id_6E4490A9F0F4006B(idamage, _id_24DF708F286B0562, attacker, victim, idflags);
        else
          _id_24DF708F286B0562 = _id_B8F067334016AC40(objweapon, _id_24DF708F286B0562);
      } else {
        if(scripts\cp_mp\utility\weapon_utility::_id_102D677621400199(objweapon) && _id_AD6472280450C778(attacker, victim))
          _id_24DF708F286B0562 = _id_597E2EB3A04537CC(_id_24DF708F286B0562, _id_49E6EF3EDADD524E);

        if(_id_23F2BCFE3327879B(objweapon) && _id_AD6472280450C778(attacker, victim) && objweapon.basename != "dragonsbreath_mp")
          _id_24DF708F286B0562 = _id_DCC3B1093C9A295E(_id_24DF708F286B0562, _id_49E6EF3EDADD524E);

        if(getdvarint("dvar_B39C4BFF0DA4C703", 0) && _id_49E6EF3EDADD524E == "iw9_knifestab" && _id_24DF708F286B0562 > 135)
          _id_24DF708F286B0562 = 135;

        if(_id_49E6EF3EDADD524E == "assault_drone_mp") {
          _id_24DF708F286B0562 = _id_249F45D992AF1114::_id_571F1E65C43FB585(inflictor, victim, _id_24DF708F286B0562);
          _id_ED76DB33212E6A92 = _id_24DF708F286B0562;
        } else if(isPlayer(victim)) {
          _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

          if(isexplosivedamagemod(smeansofdeath)) {
            switch (_id_49E6EF3EDADD524E) {
              case "bunkerbuster_round_mp":
              case "bunkerbuster_not_burrowed_mp":
              case "semtex_mp":
              case "bunkerbuster_burrowed_mp":
              case "bunkerbuster_mp":
                if(istrue(_id_B4A7D8CD8C4FB7DA))
                  _id_99A81DC3A8DEEBD6 = 1;

                break;
            }

            if(!_id_23F2BCFE3327879B(objweapon) && _id_49E6EF3EDADD524E != "assault_drone_mp" && smeansofdeath != "MOD_EXPLOSIVE_BULLET") {
              _id_24DF708F286B0562 = _id_24DF708F286B0562 * _id_3768B225BD3BCF44();
              _id_ED76DB33212E6A92 = _id_24DF708F286B0562;
            }
          } else if(scripts\engine\utility::_id_F1D312F6935BC2D2(smeansofdeath)) {
            partname = scripts\cp_mp\utility\damage_utility::_id_EDEFA1E693DD3C7D(partname);

            switch (_id_49E6EF3EDADD524E) {
              case "throwingknife_mp":
                if(scripts\cp_mp\utility\damage_utility::_id_B656251147D7D40B(partname) || scripts\cp_mp\utility\damage_utility::_id_DCDDE2598F1BDFC0(partname))
                  _id_99A81DC3A8DEEBD6 = 1;

                break;
              case "throwstar_mp":
                if(scripts\cp_mp\utility\damage_utility::_id_B656251147D7D40B(partname))
                  _id_99A81DC3A8DEEBD6 = 1;
                else if(scripts\cp_mp\utility\damage_utility::_id_DCDDE2598F1BDFC0(partname)) {
                  _id_24DF708F286B0562 = _id_52D91CB28006A5BD::_id_FC924820627E1C55();
                  _id_24DF708F286B0562 = _id_24DF708F286B0562 * _id_3768B225BD3BCF44();
                  _id_ED76DB33212E6A92 = _id_24DF708F286B0562;
                }

                break;
            }
          }

          _id_32F6184D9170CF0D = istrue(_id_99A81DC3A8DEEBD6) && (!istrue(victim.gulag) || istrue(victim.gulagarena));

          if(_id_32F6184D9170CF0D) {
            _id_24DF708F286B0562 = victim _id_AC266FC218266D08() + victim.health + 100;
            _id_ED76DB33212E6A92 = _id_24DF708F286B0562;
          }
        }
      }

      if(isDefined(victim._id_AB96E6AE80B66789))
        _id_24DF708F286B0562 = victim[[victim._id_AB96E6AE80B66789]](attacker, objweapon, smeansofdeath, _id_24DF708F286B0562, _id_BE4285B26ED99AB1);

      if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE() && _id_CA2FBBA0B1F55BBD()) {
        _id_ED76DB33212E6A92 = _id_24DF708F286B0562;
        _id_ED76DB33212E6A92 = _id_ACB600E2132F092E(attacker, _id_ED76DB33212E6A92, objweapon, smeansofdeath);
      }

      if(smeansofdeath == "MOD_RIFLE_BULLET")
        _id_24DF708F286B0562 = _id_E5E4AD050998E4C1(attacker, objweapon, smeansofdeath, _id_24DF708F286B0562, _id_BE4285B26ED99AB1);

      if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
        _id_24DF708F286B0562 = _id_7EE9D2852CEDAB94(_id_24DF708F286B0562, objweapon);

      if(!_id_94974807C7DC3ACF)
        _id_0B9BC5879C1FD673 = victim damagearmor(_id_24DF708F286B0562, _id_49765AA03D634CAB(), attacker);
      else
        _id_0B9BC5879C1FD673 = _id_24DF708F286B0562;

      _id_AE0F808555C671F9 = int(_id_24DF708F286B0562 - _id_0B9BC5879C1FD673);
      _id_ED76DB33212E6A92 = _id_F2EC69546B32A636(_id_ED76DB33212E6A92, _id_24DF708F286B0562, _id_0B9BC5879C1FD673, _id_AE0F808555C671F9);

      if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
        _id_ED76DB33212E6A92 = _id_ED76DB33212E6A92 * _id_F42BF3137EB74656();

      if(_id_7820F81EE1ADF7B9) {
        victim.tookvesthit = 1;

        if(isDefined(attacker) && !isPlayer(attacker) && isDefined(attacker.owner) && isDefined(inflictor) && isDefined(inflictor.streakinfo))
          attacker = attacker.owner;

        if(isPlayer(attacker)) {
          armorvest_sethit(attacker);

          if(!victim hasarmor())
            armorvest_setbroke(attacker);
        }
      }

      if(_id_55C156D63BE9EBA2(objweapon) && smeansofdeath == "MOD_RIFLE_BULLET")
        _id_22B15671BBF7A54E(attacker, victim, idflags, _id_24DF708F286B0562, _id_ED76DB33212E6A92 + _id_AE0F808555C671F9);
      else {
        _id_4A101E7F1377C05D = istrue(_id_43702519A3DC0854(smeansofdeath, objweapon, _id_49E6EF3EDADD524E, victim)) && _id_AE0F808555C671F9 >= 150;
        _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);
        _id_6339E40DFFE69486 = istrue(_id_B4A7D8CD8C4FB7DA) && isexplosivedamagemod(smeansofdeath);
        _id_2DC587F0E7D4D221 = istrue(_id_6339E40DFFE69486) && getdvarint("dvar_5C2F4DF8BAFB4FC0", 1) && victim _id_098B53A7358927D9::_id_87072B42853A9C58("specialty_blastshield") && _id_AE0F808555C671F9 >= 130;
        _id_84B2B2A1586DE527 = istrue(level._id_FB2B3C3DB6061DF5) && isDefined(victim._id_BED158A6DFAC230D) && victim._id_BED158A6DFAC230D >= 3;
        _id_02373E1B4830C807 = 0;

        if(_id_84B2B2A1586DE527) {
          if(_id_4A101E7F1377C05D) {
            if(_id_ED76DB33212E6A92 >= victim.health && !istrue(_id_520F3F243189CA25)) {
              _id_ED76DB33212E6A92 = int(clamp(_id_ED76DB33212E6A92, 0, victim.health - 1));
              _id_02373E1B4830C807 = 1;
            }
          } else if(_id_2DC587F0E7D4D221) {
            if(_id_ED76DB33212E6A92 >= victim.health) {
              _id_ED76DB33212E6A92 = int(clamp(_id_ED76DB33212E6A92, 0, victim.health - 15));
              victim _id_098B53A7358927D9::_id_CC76ABCED8A70F47("specialty_eod");
              _id_02373E1B4830C807 = 1;
            }
          }

          if(_id_02373E1B4830C807) {
            if(_id_ED76DB33212E6A92 < victim.health && isDefined(attacker) && isPlayer(attacker) && attacker != victim && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent")) {
              if(isDefined(victim._id_04045F099F3DA4BD) && victim._id_04045F099F3DA4BD == "brloot_plate_carrier_tempered")
                attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_4CAA4F3C52EAA383");
              else
                attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_676AA7832878D5EF");
            }
          }
        }

        if(scripts\engine\utility::ismeleedamage(smeansofdeath)) {
          if(_id_ED76DB33212E6A92 == 0 && victim.health > 1)
            _id_ED76DB33212E6A92 = 1;
        }
      }
    }
  }

  return [_id_ED76DB33212E6A92, _id_AE0F808555C671F9];
}

_id_ACB600E2132F092E(attacker, _id_ED76DB33212E6A92, objweapon, smeansofdeath) {
  if(smeansofdeath == "MOD_MELEE" && !istrue(objweapon.ismelee) && !attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_gunmelee"))
    return 70;

  return _id_ED76DB33212E6A92;
}

_id_3768B225BD3BCF44() {
  if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE() && _id_CA2FBBA0B1F55BBD())
    return 1.2;
  else
    return 1;
}

_id_F42BF3137EB74656() {
  if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE() && _id_CA2FBBA0B1F55BBD())
    return 1.5;
  else
    return 1;
}

_id_8B607CC9CC1EB155(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "grenade";
}

_id_23F2BCFE3327879B(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.inventorytype) && objweapon.inventorytype == "offhand";
}

_id_F2EC69546B32A636(idamage, _id_24DF708F286B0562, _id_0B9BC5879C1FD673, _id_AE0F808555C671F9) {
  if(_id_0B9BC5879C1FD673 > 0) {
    if(_id_24DF708F286B0562 != 0)
      _id_10077C30C9A6ECE0 = _id_AE0F808555C671F9 / _id_24DF708F286B0562;
    else
      _id_10077C30C9A6ECE0 = 0;

    _id_702BFC08FABD86CB = _func_C5CF558181E12D1F(idamage * (1 - _id_10077C30C9A6ECE0));
  } else
    _id_702BFC08FABD86CB = _id_0B9BC5879C1FD673;

  return _id_702BFC08FABD86CB;
}

_id_6E4490A9F0F4006B(idamage, _id_24DF708F286B0562, eattacker, victim, idflags) {
  if(_id_24DF708F286B0562 > idamage) {
    scripts\cp_mp\utility\weapon_utility::_id_AD15087050F05B04(eattacker, victim, idflags, _id_24DF708F286B0562);
    _id_79E0E4B77D93EEF4 = _id_24DF708F286B0562 - idamage;
    _id_79E0E4B77D93EEF4 = scripts\cp_mp\utility\weapon_utility::_id_1113FC99A0327D7D(eattacker, victim, idflags, _id_79E0E4B77D93EEF4);
    _id_24DF708F286B0562 = idamage + _id_79E0E4B77D93EEF4;
  }

  return _id_24DF708F286B0562;
}

_id_22B15671BBF7A54E(attacker, victim, idflags, _id_24DF708F286B0562, _id_89BE7633506FA104) {
  if(_id_89BE7633506FA104 < _id_24DF708F286B0562)
    scripts\cp_mp\utility\weapon_utility::_id_9665CBEBA4D776F7(attacker, victim, idflags, _id_89BE7633506FA104 - _id_24DF708F286B0562);
}

_id_D8202C9300A4EEF7(attacker, inflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_BE4285B26ED99AB1, _id_E93A0355B918AAD5) {
  _id_702BFC08FABD86CB = idamage;
  _id_25359C8E0B5022A5 = 0;
  hashelmet = victim _id_47AD39003B16CF4C();

  if(hashelmet) {
    _id_94974807C7DC3ACF = _id_343613187BDF786F(objweapon, smeansofdeath);
    _id_E13E382321A8580B = shitloc == "shield" && smeansofdeath != "MOD_GRENADE_SPLASH";

    if(!istrue(_id_94974807C7DC3ACF) && !istrue(victim.inlaststand) && !_id_E13E382321A8580B) {
      _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      weapontype = weaponclass(objweapon);
      _id_24DF708F286B0562 = scripts\engine\utility::ter_op(istrue(_id_E93A0355B918AAD5), _id_BE4285B26ED99AB1, _id_5145949F900334F0(attacker, idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, _id_BE4285B26ED99AB1, idamage, objweapon, smeansofdeath));
      _id_0B9BC5879C1FD673 = victim _id_E71F062243EA8827(_id_24DF708F286B0562, _id_49765AA03D634CAB(), attacker);
      _id_25359C8E0B5022A5 = int(_id_24DF708F286B0562 - _id_0B9BC5879C1FD673);
      _id_702BFC08FABD86CB = _id_0B9BC5879C1FD673;
    }
  }

  return [_id_702BFC08FABD86CB, _id_25359C8E0B5022A5];
}

isbulletpenetration(idflags) {
  return isDefined(idflags) && idflags &level.idflags_penetration;
}

_id_BDB257C83AE70586(attacker, victim, idflags, idamage, objweapon, smeansofdeath, _id_69CFD14B4398C458) {
  if(!isDefined(_id_69CFD14B4398C458))
    _id_69CFD14B4398C458 = idamage;

  idamage = _id_72638AE79D782126(attacker, victim, idflags, idamage, objweapon, _id_69CFD14B4398C458);
  idamage = _id_5A1B7CFA5AC58688(idamage, objweapon, _id_69CFD14B4398C458);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleAkimboDamage"))
    idamage = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleAkimboDamage")]](objweapon, smeansofdeath, idamage, attacker, self);

  return idamage;
}

_id_E5E4AD050998E4C1(attacker, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleAPAmmoDamage"))
    idamage = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleAPAmmoDamage")]](objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleAPDamage"))
    idamage = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleAPDamage")]](objweapon, smeansofdeath, idamage, attacker, self);

  return idamage;
}

_id_72638AE79D782126(attacker, victim, idflags, idamage, objweapon, _id_69CFD14B4398C458) {
  _id_960C2637064F97E9 = objweapon _meth_5BE35054519DA350();

  if(_id_55C156D63BE9EBA2(objweapon) && _id_960C2637064F97E9 > -1) {
    if(scripts\cp_mp\utility\weapon_utility::_id_A3FC7EBC9FC3E9A3(attacker, victim, idflags))
      return idamage;
  }

  _id_1317052F37A9D4C3 = 0;

  if(_id_69CFD14B4398C458 != 0)
    _id_1317052F37A9D4C3 = idamage / _id_69CFD14B4398C458;
  else
    _id_1317052F37A9D4C3 = 1;

  if(_id_960C2637064F97E9 > -1 && _id_69CFD14B4398C458 < _id_960C2637064F97E9)
    idamage = _id_960C2637064F97E9 * _id_1317052F37A9D4C3;

  return idamage;
}

_id_5A1B7CFA5AC58688(idamage, objweapon, _id_69CFD14B4398C458) {
  _id_C94BF7474B2B367B = objweapon _meth_957E87390FD5DBA2();

  if(_id_55C156D63BE9EBA2(objweapon) && _id_C94BF7474B2B367B > 0)
    _id_C94BF7474B2B367B = -1;

  if(_id_C94BF7474B2B367B > 0 && idamage > _id_C94BF7474B2B367B)
    idamage = _id_C94BF7474B2B367B;

  return idamage;
}

_id_B8F067334016AC40(objweapon, idamage) {
  return idamage;
}

_id_048870325DB7E028(idamage, number) {
  if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE() && _id_CA2FBBA0B1F55BBD())
    _id_504126E76D4ACB79 = 150 + self.maxhealth;
  else
    _id_504126E76D4ACB79 = 150;

  _id_FF7309DD24B65641 = ceil(_id_504126E76D4ACB79 / idamage);
  idamage = ceil(_id_504126E76D4ACB79 / (_id_FF7309DD24B65641 + number));
  return idamage;
}

_id_5145949F900334F0(attacker, idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, _id_BE4285B26ED99AB1, idamage, objweapon, smeansofdeath) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleAPDamage"))
    idamage = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleAPDamage")]](objweapon, smeansofdeath, idamage, attacker, self);

  return idamage;
}

_id_58A4D5ED666352EF(_id_BE4285B26ED99AB1, weapon, _id_4EFCC1874038117A) {
  _id_E7EC701163E1B30C = 0;

  if(_id_4EFCC1874038117A == 4)
    _id_E7EC701163E1B30C = weapon getmid3damage();
  else if(_id_4EFCC1874038117A == 3)
    _id_E7EC701163E1B30C = weapon getmid2damage();
  else if(_id_4EFCC1874038117A == 2)
    _id_E7EC701163E1B30C = weapon getmid1damage();

  if(_id_E7EC701163E1B30C <= 0)
    _id_E7EC701163E1B30C = weapon.mindamage;

  if(_id_4EFCC1874038117A == 1 || _id_E7EC701163E1B30C <= 0)
    _id_E7EC701163E1B30C = weapon.maxdamage;

  if(_id_BE4285B26ED99AB1 < _id_E7EC701163E1B30C)
    return int(_id_E7EC701163E1B30C);
  else
    return _id_BE4285B26ED99AB1;
}

_id_343613187BDF786F(objweapon, smeansofdeath) {
  _id_5C3F9357F11D2223 = objweapon.basename;

  if(isDefined(_id_5C3F9357F11D2223) && _id_5C3F9357F11D2223 == "danger_circle_br")
    return 1;

  if(smeansofdeath == "MOD_EXECUTION")
    return 1;

  if(smeansofdeath == "MOD_FALLING")
    return 1;

  if(smeansofdeath == "MOD_UNKNOWN")
    return 1;

  if(smeansofdeath == "MOD_SUICIDE")
    return 1;

  return 0;
}

armorvest_washit(attacker) {
  return isDefined(attacker.hitarmorvest) && gettime() == attacker.hitarmorvest;
}

_id_75C4F7172E4EF3F5(attacker, victim, _id_1DA1A66B5C6A06A7) {
  return isDefined(victim) && isDefined(victim._id_BED158A6DFAC230D) && victim._id_BED158A6DFAC230D >= 2 && _id_1DA1A66B5C6A06A7 > 0 && isDefined(victim.armorhealth) && victim.armorhealth > 50;
}

_id_3F09A25CB8C206FF(attacker, victim, _id_1DA1A66B5C6A06A7) {
  return isDefined(victim) && isDefined(victim._id_BED158A6DFAC230D) && isDefined(level._id_4B78859BACC88808) && victim._id_BED158A6DFAC230D >= 3 && _id_1DA1A66B5C6A06A7 > 0 && victim.armorhealth + _id_1DA1A66B5C6A06A7 > level._id_4B78859BACC88808 * 2;
}

armorvest_sethit(attacker) {
  attacker.hitarmorvest = gettime();
}

armorvest_clearhit(attacker) {
  attacker.hitarmorvest = undefined;
}

armorvest_wasbroke(attacker) {
  return isDefined(attacker.brokearmorvest) && gettime() == attacker.brokearmorvest;
}

_id_78EA9AC6C9AB7305(attacker, victim, idamage, _id_1DA1A66B5C6A06A7) {
  return isDefined(victim) && isDefined(victim._id_BED158A6DFAC230D) && victim._id_BED158A6DFAC230D >= 3 && armorvest_wasbroke(attacker) && idamage == victim.maxhealth - 10 && _id_1DA1A66B5C6A06A7 > 100;
}

armorvest_setbroke(attacker) {
  attacker.brokearmorvest = gettime();
}

armorvest_clearbroke(attacker) {
  attacker.brokearmorvest = undefined;
}

_id_49765AA03D634CAB() {
  return istrue(level._id_E4623740D9B51824);
}

_id_A024D9111228A85E() {
  return !istrue(self._id_57C207FDE9B78089) || istrue(level._id_843573804B98EB7E);
}

_id_E47B13BABB51A365() {
  if(self.armorhealth == self._id_8790C077C95DB752)
    return 1;

  return 0;
}

_id_32BC8E85688648F4(_id_5F6546312365B65C) {
  _id_1C07EF7BC0E3723A = self.armorhealth + _id_5F6546312365B65C;
  _id_AC7803D45979135C(_id_1C07EF7BC0E3723A);
}

_id_43702519A3DC0854(smeansofdeath, objweapon, _id_49E6EF3EDADD524E, victim) {
  if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || _id_49E6EF3EDADD524E == "assault_drone_mp")
    return 1;

  if(getdvarint("dvar_6EBA4697F8459B88", 0) && victim _id_098B53A7358927D9::_id_87072B42853A9C58("specialty_blastshield") && scripts\cp_mp\utility\weapon_utility::_id_102D677621400199(objweapon))
    return 1;

  if(objweapon.inventorytype == "offhand")
    return 0;
}

_id_AE24F0C0C8C6DE2A(objweapon, _id_49E6EF3EDADD524E, weapontype) {
  if(weapontype == "sniper" && _id_49E6EF3EDADD524E != "iw9_sn_limax" && _func_F30A6D3194F97C09(objweapon, "specialty_explosivebullet"))
    return 1;

  if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
    return 1;

  return 0;
}

_id_7EE9D2852CEDAB94(_id_24DF708F286B0562, objweapon) {
  _id_E91D6967B22E56A7 = "";

  foreach(_id_AC0E594AC96AA3A8 in objweapon.attachments) {
    if(issubstr(_id_AC0E594AC96AA3A8, "ammo_bolt"))
      _id_E91D6967B22E56A7 = _id_AC0E594AC96AA3A8;
  }

  switch (_id_E91D6967B22E56A7) {
    case "ammo_bolt_db":
      modifier = 1.9;
      break;
    case "ammo_bolt_he":
      modifier = 1.21;
      break;
    case "ammo_bolt_gas":
      modifier = 1.9;
      break;
    default:
      modifier = 2.0;
  }

  return int(_id_24DF708F286B0562 * modifier);
}

_id_DCC3B1093C9A295E(_id_24DF708F286B0562, _id_49E6EF3EDADD524E) {
  switch (_id_49E6EF3EDADD524E) {
    case "claymore_mp":
      modifier = 0.9;
      break;
    case "claymore_radial_mp":
      modifier = 0.9;
      break;
    case "throwingknife_mp":
      modifier = 0.8;
      break;
    case "semtex_mp":
      modifier = 1.43;
      break;
    case "cluster_spike_mp":
      modifier = 0.6;
      break;
    case "bunkerbuster_round_mp":
      modifier = 0.75;
      break;
    default:
      modifier = 1.0;
  }

  return int(_id_24DF708F286B0562 * modifier * _id_3768B225BD3BCF44());
}

_id_597E2EB3A04537CC(damage, _id_49E6EF3EDADD524E) {
  switch (_id_49E6EF3EDADD524E) {
    case "iw9_la_rpapa7":
      modifier = 0.91;
      break;
    case "iw9_la_kgolf":
      modifier = 0.86;
      break;
    case "iw9_la_mike32":
      modifier = 0.93;
      break;
    case "iw9_la_gromeo":
      modifier = 0.95;
      break;
    case "iw9_la_juliet":
      modifier = 0.97;
      break;
    default:
      modifier = 1.0;
  }

  return int(damage * modifier);
}

_id_AD6472280450C778(attacker, victim) {
  if(isPlayer(attacker) && isPlayer(victim))
    return 1;

  return 0;
}

_id_8775D4E6734630C0(player) {
  if(!istrue(level._id_7F3AAFCF56C9CE14))
    return 0;

  if(!isDefined(player._id_04045F099F3DA4BD))
    return 0;

  switch (player._id_04045F099F3DA4BD) {
    case "brloot_plate_carrier_tempered":
      return 1;
    case "brloot_plate_carrier_3_comms":
    case "brloot_plate_carrier_2_comms":
      return 3;
    case "brloot_plate_carrier_3_stealth":
    case "brloot_plate_carrier_2_stealth":
      return 2;
    case "brloot_plate_carrier_3_medic":
    case "brloot_plate_carrier_2_medic":
      return 4;
    default:
      break;
  }

  return 0;
}

_id_55C156D63BE9EBA2(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}

_id_CA2FBBA0B1F55BBD() {
  return level._id_23960E36343A87A6;
}