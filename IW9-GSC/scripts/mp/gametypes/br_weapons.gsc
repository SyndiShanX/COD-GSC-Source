/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_weapons.gsc
***********************************************/

createspawnweaponatpos(pos, _id_542376043461D863, fullweaponobj) {
  trace = scripts\engine\trace::ray_trace(pos, (pos[0], pos[1], pos[2] - 60));
  _id_1F9238CE81EA0D85 = pos;

  if(trace["fraction"] < 1.0)
    _id_1F9238CE81EA0D85 = trace["position"] + (0, 0, 2);

  if(!isDefined(_id_542376043461D863))
    _id_542376043461D863 = (0, 0, 90);

  pos = _id_1F9238CE81EA0D85;

  if(isDefined(_id_542376043461D863))
    _id_542376043461D863 = _id_542376043461D863;
  else
    _id_542376043461D863 = (0, 0, 90);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(pos, _id_542376043461D863);
  return weaponspawn(fullweaponobj, undefined, _id_CB4FAD49263E20C4, 1);
}

createspawnweaponatposfromname(pos, _id_A0CB84D50AFAAB7D) {
  _id_1F9238CE81EA0D85 = pos;
  trace = scripts\engine\trace::ray_trace(pos, (pos[0], pos[1], pos[2] - 60));

  if(trace["fraction"] < 1.0)
    _id_1F9238CE81EA0D85 = trace["position"] + (0, 0, 2);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(pos, (0, 0, 90));
  weaponobj = makeweaponfromstring(_id_A0CB84D50AFAAB7D);
  return weaponspawn(weaponobj, undefined, _id_CB4FAD49263E20C4, 1);
}

stripweaponsfromplayer() {
  primaryweapon = undefined;
  secondaryweapon = undefined;

  foreach(weapon in self.equippedweapons) {
    basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);
    classname = weapon.classname;

    if(basename != "iw9_me_fists" && basename != "iw9_knifestab" && basename != "iw8_gunless" && basename != "iw9_pi_golf17" && classname != "fist") {
      if(isweapon(weapon) && weapon.inventorytype == "primary") {
        _id_E18BC39347FD6FCB = _id_2669878CF5A1B6BC::getweaponrootname(self.currentprimaryweapon);
        _id_4BC5E453CC450F3E = _id_E18BC39347FD6FCB;

        if(isDefined(self.laststandoldweaponobj) && !_id_2669878CF5A1B6BC::iskillstreakweapon(self.laststandoldweaponobj))
          _id_4BC5E453CC450F3E = _id_2669878CF5A1B6BC::getweaponrootname(self.laststandoldweaponobj);

        if(basename == _id_E18BC39347FD6FCB || basename == _id_4BC5E453CC450F3E)
          primaryweapon = weapon;
        else
          secondaryweapon = weapon;
      }
    }
  }

  if(isDefined(primaryweapon))
    _id_04E1D85D8A40718A = _id_2669878CF5A1B6BC::getweaponrootname(primaryweapon.basename);

  if(isDefined(secondaryweapon))
    _id_A39E6237E3F658CA = _id_2669878CF5A1B6BC::getweaponrootname(secondaryweapon.basename);

  if(isDefined(primaryweapon) || isDefined(secondaryweapon)) {
    if(isDefined(primaryweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(primaryweapon);

    if(isDefined(secondaryweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(secondaryweapon);

    scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp");
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw9_me_fists_mp");
  }
}

playerdropweaponfrominventory(itemtype) {
  primaryweapon = undefined;
  secondaryweapon = undefined;

  foreach(weapon in self.equippedweapons) {
    basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

    if(basename != "iw9_me_fists" && basename != "iw9_knifestab") {
      if(isweapon(weapon) && weapon.inventorytype == "primary") {
        _id_E18BC39347FD6FCB = _id_2669878CF5A1B6BC::getweaponrootname(self.currentprimaryweapon);

        if(basename == _id_E18BC39347FD6FCB) {
          iprintln("PRIMARY IS " + basename);
          primaryweapon = weapon;
        } else
          secondaryweapon = weapon;
      }
    }
  }

  _id_0EC22A950F210E39 = undefined;
  _id_09F49BE88B7541ED = undefined;
  _id_04E1D85D8A40718A = "";
  _id_A39E6237E3F658CA = "";

  if(isDefined(primaryweapon))
    _id_04E1D85D8A40718A = _id_2669878CF5A1B6BC::getweaponrootname(primaryweapon.basename);

  if(isDefined(secondaryweapon))
    _id_A39E6237E3F658CA = _id_2669878CF5A1B6BC::getweaponrootname(secondaryweapon.basename);

  if(itemtype == _id_04E1D85D8A40718A) {
    _id_0EC22A950F210E39 = primaryweapon;
    _id_09F49BE88B7541ED = secondaryweapon;
  } else if(itemtype == _id_A39E6237E3F658CA) {
    _id_0EC22A950F210E39 = secondaryweapon;
    _id_09F49BE88B7541ED = primaryweapon;
  }

  _id_6584A71F9705DC0A = 0;

  if(isDefined(_id_0EC22A950F210E39)) {
    _id_AC9CAEBED426E625 = self getweaponammoclip(_id_0EC22A950F210E39);
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = weaponspawn(_id_0EC22A950F210E39, self, _id_CB4FAD49263E20C4, 0);
    item.count = _id_AC9CAEBED426E625;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0EC22A950F210E39);

    if(isDefined(_id_09F49BE88B7541ED))
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_09F49BE88B7541ED);
    else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp");
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw9_me_fists_mp");
    }

    br_ammo_update_weapons(self);
  }
}

weaponspawn(weaponobj, _id_2CA201D5906CDBA5, _id_CB4FAD49263E20C4, _id_63366D9D88CE51F8, _id_8D9AE21C4B7DA354) {
  _id_A0CB84D50AFAAB7D = getcompleteweaponname(weaponobj);
  _id_0CC708B3BF7C11ED = _id_7E52B56769FA7774::spawnpickup(_id_A0CB84D50AFAAB7D, _id_CB4FAD49263E20C4, 0, _id_8D9AE21C4B7DA354, weaponobj, undefined, undefined, undefined);
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0CC708B3BF7C11ED, _id_2CA201D5906CDBA5, weaponobj);
  return _id_0CC708B3BF7C11ED;
}

_id_55C5D35C8C76A95B(pickupent) {
  if(!isDefined(pickupent.weapon)) {
    attachments = [];
    _id_DD515FCF025B2E79 = undefined;

    if(isDefined(pickupent.customweaponname)) {
      _id_A0CB84D50AFAAB7D = pickupent.customweaponname;
      _id_DD515FCF025B2E79 = makeweaponfromstring(_id_A0CB84D50AFAAB7D);
    } else if(!isDefined(pickupent.completeweapon)) {
      _id_DD515FCF025B2E79 = _id_7E52B56769FA7774::getfullweaponobjforpickup(pickupent);
      _id_A0CB84D50AFAAB7D = getcompleteweaponname(_id_DD515FCF025B2E79);
    } else {
      _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(pickupent.loadoutprimaryfullname, attachments, "none", "none", -1);
      _id_A0CB84D50AFAAB7D = pickupent.loadoutprimaryfullname;
    }

    _id_1C454AEE1C2A55DF = _id_2669878CF5A1B6BC::getweaponrootname(_id_A0CB84D50AFAAB7D);
    weaponname = _id_A0CB84D50AFAAB7D;
  } else {
    _id_DD515FCF025B2E79 = pickupent.weapon;
    weaponname = getcompleteweaponname(_id_DD515FCF025B2E79);
    _id_1C454AEE1C2A55DF = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  }

  return [_id_DD515FCF025B2E79, _id_1C454AEE1C2A55DF, weaponname];
}

_id_5A80DBA504420037(index) {
  if(!isDefined(level.br_ammo_types)) {
    return;
  }
  if(isDefined(level.br_ammo_types[index]))
    return level.br_ammo_types[index];
  else {}
}

_id_2BF8EAF550FBE399(ammotype) {
  if(!isDefined(level.br_ammo_clipsize)) {
    return;
  }
  if(isDefined(level.br_ammo_clipsize[ammotype]))
    return level.br_ammo_clipsize[ammotype];
  else {}
}

_id_1352197E2482F1CF(player, ammotype) {
  if(!isDefined(player) || !isDefined(player.br_ammo)) {
    return;
  }
  if(isDefined(player.br_ammo[ammotype]))
    return player.br_ammo[ammotype];
  else {}
}

_id_088D62A65FF69EAC(player, ammotype) {
  _id_23C054F415636C51 = player.br_ammo[ammotype];

  if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(ammotype)) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
    _id_23C054F415636C51 = _id_23C054F415636C51 + _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
  }

  return _id_23C054F415636C51;
}

_id_64F6EBFF728689AB(player, weapon) {
  if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
    return;
  }
  clipammo = player getweaponammoclip(weapon);
  _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(weapon);

  if(isDefined(_id_811ABFDB6C33F17F))
    self.br_ammo[_id_811ABFDB6C33F17F] = self.br_ammo[_id_811ABFDB6C33F17F] + clipammo;
}

_id_2AB3BDA08C595A32(player, weapon) {
  if(isDefined(player.primaryweapons[0]) && issameweapon(weapon, player.primaryweapons[0]))
    return 0;

  if(isDefined(player.primaryweapons[1]) && issameweapon(weapon, player.primaryweapons[1]))
    return 1;

  if(issameweapon(weapon, _id_2D9D24F7C63AC143::_id_2985254128B1C262(player)))
    return 2;

  return undefined;
}

_id_A41D365900F73302(player, weapon) {
  heavyweapons = player.heavyweapons;

  for(_id_FEBA93FDF765E2A4 = 0; _id_FEBA93FDF765E2A4 < heavyweapons.size; _id_FEBA93FDF765E2A4++) {
    _id_07965F45F8A9AEC8 = heavyweapons[_id_FEBA93FDF765E2A4];

    if(isDefined(_id_07965F45F8A9AEC8) && issameweapon(_id_07965F45F8A9AEC8, weapon))
      return _id_FEBA93FDF765E2A4;
  }

  return undefined;
}

_id_86A5C7670325346B(player, index) {
  if(!isDefined(player._id_B4DB082889208622))
    player._id_B4DB082889208622 = [];

  if(!isDefined(index))
    return player.team;

  if(!isDefined(player._id_B4DB082889208622[index]))
    return player.team;
  else
    return player._id_B4DB082889208622[index];
}

_id_9DB6A7E1567BB1F9(player, _id_FE4048AD22C35D73) {
  team = player.team;

  if(isDefined(_id_FE4048AD22C35D73))
    team = _id_86A5C7670325346B(player, _id_FE4048AD22C35D73);

  return team;
}

_id_1A561E5EF2ECA63A(player, weapon) {
  index = _id_2AB3BDA08C595A32(player, weapon);
  return _id_9DB6A7E1567BB1F9(player, index);
}

_id_AE30366A2D519A57(player, index, team) {
  if(!isDefined(player._id_B4DB082889208622))
    player._id_B4DB082889208622 = [];

  player._id_B4DB082889208622[index] = team;
}

takeweaponpickup(pickupent, _id_DB943473454F6EA6, _id_5756AA71087F3439, _id_44EE85DCF52B4001, _id_7F437A5779C8787C, _id_B4B637B07F3F9F25) {
  _id_7B9DE6DB6A90DBE7 = 0;
  _id_060012A0838191D7 = self.primaryweapons.size;
  _id_7F6369ECA6D7C141 = _id_55C5D35C8C76A95B(pickupent);
  _id_DD515FCF025B2E79 = _id_7F6369ECA6D7C141[0];
  weaponname = _id_7F6369ECA6D7C141[2];
  _id_7DC30386B50647A1 = 0;
  _id_0EC22A950F210E39 = undefined;
  _id_A64E5E1EE95C7B96 = 0;
  _id_B9976CC76957A593 = _id_27EF2C36EB95D796();
  _id_7E67CC008AA22631 = _id_1E4A61DB11011446::_id_F32857A938336F2B(self, _id_B9976CC76957A593);
  _id_02840D4402B27DD0 = self isreloading();

  foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
    if(isnullweapon(_id_DE88CD14114C1E24) || istrue(_id_2669878CF5A1B6BC::_id_417760651C48814B(_id_DE88CD14114C1E24))) {
      _id_060012A0838191D7--;
      continue;
    }

    if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
      _id_7DC30386B50647A1 = 1;
      _id_0EC22A950F210E39 = _id_DE88CD14114C1E24;
    }
  }

  if(_id_060012A0838191D7 > 1 && !_id_7DC30386B50647A1) {
    if(!self hasweapon("iw9_me_fists_mp"))
      _id_7DC30386B50647A1 = 1;
    else if(!isDefined(_id_5756AA71087F3439) && (!isDefined(pickupent) || isDefined(pickupent) && !istrue(pickupent._id_4A08890FD43D6BC7))) {
      if(istrue(pickupent.isautouse)) {
        foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
          if(_id_DE88CD14114C1E24.basename == "iw9_me_fists_mp")
            _id_7B9DE6DB6A90DBE7 = _id_8DABE5259E6844E9(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79);
        }
      }

      if(_id_7E67CC008AA22631 || _id_02840D4402B27DD0)
        _id_7B9DE6DB6A90DBE7 = 1;

      self takeweapon("iw9_me_fists_mp");
    }
  }

  if(_id_7DC30386B50647A1 || isDefined(_id_5756AA71087F3439) || istrue(pickupent._id_4A08890FD43D6BC7)) {
    if(istrue(pickupent.isautouse) && !isDefined(_id_0EC22A950F210E39)) {
      _id_0EC22A950F210E39 = _id_823964AA15B30575();
      _id_7B9DE6DB6A90DBE7 = _id_8DABE5259E6844E9(_id_0EC22A950F210E39, _id_DD515FCF025B2E79);
    }

    if(!isDefined(_id_0EC22A950F210E39))
      _id_0EC22A950F210E39 = _id_27EF2C36EB95D796();

    if(!isDefined(_id_0EC22A950F210E39) && isDefined(_id_5756AA71087F3439))
      _id_0EC22A950F210E39 = _id_5756AA71087F3439;

    if(_id_0EC22A950F210E39.basename != "none") {
      _id_28AEBE3DD6733ED3 = undefined;
      _id_1AF8FE94EE02A80F = undefined;
      _id_961012DD15FA29EE = undefined;
      _id_1EE5FB8247544C62 = pickupent.origin - self.origin;
      yaw = vectortoyaw(_id_1EE5FB8247544C62);
      _id_C02997B2DEFF6E69 = !_id_4ACBD920A4F5A24D::extract_ismissionweapon(_id_0EC22A950F210E39);

      if(istrue(level._id_0F478C1F94CAA7E9) && !_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self) && (isDefined(_id_5756AA71087F3439) || istrue(_id_44EE85DCF52B4001))) {
        if(isDefined(_id_5756AA71087F3439))
          _id_0EC22A950F210E39 = _id_5756AA71087F3439;

        if(isDefined(_id_0EC22A950F210E39) && _id_0EC22A950F210E39.basename != "iw9_me_fists_mp" && _id_0EC22A950F210E39.basename != "none") {
          _id_E1147886CCF51970 = _id_1A561E5EF2ECA63A(self, _id_0EC22A950F210E39);
          _id_2D9D24F7C63AC143::_id_8107FE0FEEC27866(self, _id_0EC22A950F210E39);
          _id_A64E5E1EE95C7B96 = 1;
          _id_C02997B2DEFF6E69 = 0;
          _id_AE30366A2D519A57(self, 2, _id_E1147886CCF51970);
        }
      } else if(istrue(pickupent._id_4A08890FD43D6BC7)) {
        _id_0EC22A950F210E39 = _id_DD515FCF025B2E79;
        _id_AC9CAEBED426E625 = scripts\engine\utility::ter_op(isDefined(pickupent.count), pickupent.count, 0);
        _id_EBB08939922897E1 = scripts\engine\utility::ter_op(isDefined(pickupent.countlefthand), pickupent.countlefthand, 0);
        self._id_3EF503345DC57957 = _id_AC9CAEBED426E625;
        self._id_00AD7897ECDBCB63 = _id_EBB08939922897E1;

        if(_id_0EC22A950F210E39.hasalternate) {
          _id_9BFD50804DD2553C = scripts\engine\utility::ter_op(isDefined(pickupent._id_E97D731BEDD44C63), pickupent._id_E97D731BEDD44C63, 0);
          self._id_86B32AFF94B5714E = _id_9BFD50804DD2553C;
        }

        _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(self, _id_0EC22A950F210E39, istrue(pickupent._id_F51BBB191526DFA4), pickupent._id_4E479E14D0837E84, 1);
        _id_AE30366A2D519A57(self, 2, pickupent._id_E1147886CCF51970);
        _id_AC9A77A44C7739E9 = undefined;

        if(isDefined(_id_B9976CC76957A593))
          _id_AC9A77A44C7739E9 = br_ammo_type_for_weapon(_id_B9976CC76957A593);

        ammotype = br_ammo_type_for_weapon(_id_0EC22A950F210E39);
        _id_4BE638DAB99C2ED5 = isDefined(ammotype) && isDefined(_id_AC9A77A44C7739E9) && _id_AC9A77A44C7739E9 == ammotype;
        _id_32C6E6F4FCB57314 = _id_4BE638DAB99C2ED5 && _id_7E67CC008AA22631;

        if(isDefined(ammotype) && !_id_32C6E6F4FCB57314)
          br_ammo_update_ammotype_weapons(self, ammotype, self.br_ammo[ammotype]);

        return;
      } else if(isDefined(_id_DB943473454F6EA6) && _id_2D9D24F7C63AC143::_id_3AB0A87EEAA203BF()) {
        _id_64F6EBFF728689AB(self, _id_0EC22A950F210E39);
        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_0EC22A950F210E39);
        variantid = _id_0EC22A950F210E39.variantid;

        if(!isDefined(_id_0EC22A950F210E39.variantid))
          variantid = 0;

        lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
        _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(self, _id_DB943473454F6EA6, lootid, 1);
        _id_C02997B2DEFF6E69 = 0;
      } else {
        _id_28AEBE3DD6733ED3 = self getweaponammoclip(_id_0EC22A950F210E39);
        _id_1AF8FE94EE02A80F = self getweaponammoclip(_id_0EC22A950F210E39, "left");
        _id_961012DD15FA29EE = 0;

        if(_id_0EC22A950F210E39.hasalternate) {
          _id_5D9B5B689A1846C8 = _id_0EC22A950F210E39 getaltweapon();

          if(br_ammo_type_for_weapon(_id_5D9B5B689A1846C8) != br_ammo_type_for_weapon(_id_0EC22A950F210E39))
            _id_961012DD15FA29EE = self getweaponammoclip(_id_5D9B5B689A1846C8);
        }

        if(!scripts\cp_mp\utility\weapon_utility::isriotshield(_id_0EC22A950F210E39)) {
          _id_D1AD88BF84DAA67F = self getweaponammostock(_id_0EC22A950F210E39);
          _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(_id_0EC22A950F210E39);

          if(isDefined(_id_811ABFDB6C33F17F))
            self.br_ammo[_id_811ABFDB6C33F17F] = _id_D1AD88BF84DAA67F;
        }

        if(_id_C02997B2DEFF6E69) {
          droporigin = pickupent.origin;

          if(getdvarint("dvar_0D46305F139655DA", 0))
            droporigin = self.origin - anglesToForward(self.angles) * getdvarint("dvar_6A09F2A33E5367CE", 50);

          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
          _id_8D9AE21C4B7DA354 = 1;
          baseorigin = self.origin;
          baseangles = self.angles;
          _id_7591ED99E87A77D3 = pickupent.origin;

          if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
            _id_E1D097C517C3AF5B = self.br_kiosk _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
            self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
            dropstruct = self.br_kiosk.dropstruct;
            baseorigin = scripts\engine\utility::_id_53C4C53197386572(self.br_kiosk._id_AFC028D00356E443, self.br_kiosk.origin);
            baseangles = self.br_kiosk.angles;
            _id_7591ED99E87A77D3 = undefined;
          }

          if(getdvarint("dvar_752EEED3DDCBD04B", 0) == 0) {
            _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
            _id_3B32926691304382 = br_ammo_type_for_weapon(_id_0EC22A950F210E39);
            _id_E8399AB865C58EA3 = "";

            if(isDefined(_id_DD515FCF025B2E79))
              _id_E8399AB865C58EA3 = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

            _id_E8399AB865C58EA3 = scripts\engine\utility::ter_op(isDefined(_id_E8399AB865C58EA3), _id_E8399AB865C58EA3, "");

            if(_id_AD972C1D0F29841C(self, _id_0EC22A950F210E39) && self.br_ammo[_id_3B32926691304382] > 0 && _id_3B32926691304382 != _id_E8399AB865C58EA3) {
              _id_0660523CFF419F0B = getdvarint("dvar_3C4EDD0A748E4053", 1);
              _id_4E06553818889332 = _id_CB4FAD49263E20C4.origin - baseorigin;
              upvec = anglestoup(_id_CB4FAD49263E20C4.angles);
              _id_5A060C381DCE3622 = vectorcross(vectorNormalize(_id_4E06553818889332), upvec);
              _id_5A060C381DCE3622 = rotatepointaroundvector(upvec, _id_5A060C381DCE3622, getdvarint("dvar_51CB230BBD599B71", 20));
              _id_9EDC776840BAFF95 = _id_CB4FAD49263E20C4.origin + _id_5A060C381DCE3622 * getdvarint("dvar_16E74796DF75B8D0", 20);
              _id_CC9974FDF39F6CCA = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, undefined, undefined, undefined, undefined, _id_9EDC776840BAFF95);
              _id_F14355041A2A65AB = _id_7E52B56769FA7774::spawnpickup(_id_3B32926691304382, _id_CC9974FDF39F6CCA, self.br_ammo[_id_3B32926691304382], 1, undefined, _id_0660523CFF419F0B);
              br_ammo_take_type(self, _id_3B32926691304382, self.br_ammo[_id_3B32926691304382]);
            }
          } else {
            baseangles = (0, yaw, 0);
            _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, baseangles, self, 0, 0);
            _id_8D9AE21C4B7DA354 = 0;
          }

          item = weaponspawn(_id_0EC22A950F210E39, self, _id_CB4FAD49263E20C4, 0, _id_8D9AE21C4B7DA354);

          if(isDefined(item)) {
            _id_7E52B56769FA7774::loot_setitemcount(item, _id_28AEBE3DD6733ED3, _id_1AF8FE94EE02A80F, _id_961012DD15FA29EE);

            if(_id_B1DD9DCAE2F63965())
              _id_8E7E1DA48D7746E5(self, item);

            _id_E637EE4FAED5D14D = 1;
            _id_715028F54BAD19A1::branalytics_lootdrop(self, _id_0EC22A950F210E39.basename, _id_E637EE4FAED5D14D, _id_28AEBE3DD6733ED3);
            _id_FE4048AD22C35D73 = _id_2AB3BDA08C595A32(self, _id_0EC22A950F210E39);

            if(isDefined(_id_FE4048AD22C35D73))
              item._id_E1147886CCF51970 = _id_86A5C7670325346B(self, _id_FE4048AD22C35D73);

            if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
              for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
                _id_A1C804FFA2416774 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_AC0E594AC96AA3A8);

                if(isDefined(_id_A1C804FFA2416774) && _id_A1C804FFA2416774 == _id_0EC22A950F210E39) {
                  _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, _id_AC0E594AC96AA3A8);

                  if(isDefined(_id_96C4059AA2EABFB8)) {
                    item._id_4E479E14D0837E84 = _id_96C4059AA2EABFB8;
                    break;
                  }
                }
              }
            }

            self notify("dropped_weapon_scriptable", item, undefined, _id_CB4FAD49263E20C4.origin);
          }
        }
      }

      self takeweapon(_id_0EC22A950F210E39);
    }
  } else if(isDefined(_id_DB943473454F6EA6)) {
    [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_DB943473454F6EA6);
    _id_2D9D24F7C63AC143::_id_E900E7E66383AD97(self, _id_DB943473454F6EA6, 0);
  }

  self giveweapon(_id_DD515FCF025B2E79);
  _id_FEBA93FDF765E2A4 = _id_A41D365900F73302(self, _id_DD515FCF025B2E79);

  if(isDefined(_id_FEBA93FDF765E2A4))
    self assignweaponprimaryslot(weaponname);

  self notify("pickedupweapon", weaponname);
  _id_FE4048AD22C35D73 = _id_2AB3BDA08C595A32(self, _id_DD515FCF025B2E79);

  if(!isDefined(_id_FE4048AD22C35D73))
    logstring("Log this in IW9-536838: weaponIndex is undefined. weaponName = " + weaponname);

  _id_12A012FC10FA77A4 = pickupent._id_E1147886CCF51970;

  if(!isDefined(_id_12A012FC10FA77A4))
    _id_12A012FC10FA77A4 = self.team;

  if(isDefined(_id_FE4048AD22C35D73))
    _id_AE30366A2D519A57(self, _id_FE4048AD22C35D73, _id_12A012FC10FA77A4);

  if(getdvarint("dvar_218B826F84233424", 0))
    _id_7E52B56769FA7774::_id_5EF33BFFAEDA4FA9(_id_DD515FCF025B2E79, !istrue(pickupent.isautouse));

  _id_C1192C297BBF292F = pickupent.count;
  _id_7B7B94EFE2E96D4B = pickupent.countlefthand;
  _id_7B7B94EFE2E96D4B = scripts\engine\utility::_id_53C4C53197386572(_id_7B7B94EFE2E96D4B, 0);
  clipsize = weaponclipsize(_id_DD515FCF025B2E79);
  _id_031B36738FF4EACD = 0;

  if(_id_C1192C297BBF292F > clipsize) {
    _id_031B36738FF4EACD = _id_031B36738FF4EACD + (_id_C1192C297BBF292F - clipsize);
    _id_C1192C297BBF292F = clipsize;
  }

  if(_id_7B7B94EFE2E96D4B > clipsize) {
    _id_031B36738FF4EACD = _id_031B36738FF4EACD + (_id_7B7B94EFE2E96D4B - clipsize);
    _id_7B7B94EFE2E96D4B = clipsize;
  }

  self setweaponammoclip(weaponname, _id_C1192C297BBF292F);
  self setweaponammoclip(weaponname, _id_7B7B94EFE2E96D4B, "left");

  if(_id_031B36738FF4EACD > 0) {
    ammotype = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

    if(isDefined(ammotype))
      br_ammo_give_type(self, ammotype, _id_031B36738FF4EACD);
  }

  if(_id_DD515FCF025B2E79.hasalternate) {
    _id_DFD1FD5D26DD4E12 = pickupent._id_E97D731BEDD44C63;
    _id_84C947974132A108 = _id_DD515FCF025B2E79 getaltweapon();
    _id_26F2DB792005350E = br_ammo_type_for_weapon(_id_84C947974132A108);

    if(_id_26F2DB792005350E != br_ammo_type_for_weapon(_id_DD515FCF025B2E79)) {
      _id_13E1D3280DF9E6E7 = weaponclipsize(_id_84C947974132A108);

      if(!isDefined(_id_DFD1FD5D26DD4E12) || _id_DFD1FD5D26DD4E12 > _id_13E1D3280DF9E6E7)
        _id_DFD1FD5D26DD4E12 = _id_13E1D3280DF9E6E7;

      self setweaponammoclip(_id_84C947974132A108, _id_DFD1FD5D26DD4E12);
      br_ammo_player_hud_update_ammotype(_id_26F2DB792005350E);
      br_ammo_update_weapons(self);
    }
  }

  ammotype = undefined;

  if(isDefined(_id_DD515FCF025B2E79))
    ammotype = br_ammo_type_for_weapon(_id_DD515FCF025B2E79);

  _id_32C6E6F4FCB57314 = 0;

  if(isDefined(_id_B9976CC76957A593)) {
    _id_AC9A77A44C7739E9 = br_ammo_type_for_weapon(_id_B9976CC76957A593);
    _id_4BE638DAB99C2ED5 = isDefined(ammotype) && isDefined(_id_AC9A77A44C7739E9) && _id_AC9A77A44C7739E9 == ammotype;
    _id_32C6E6F4FCB57314 = _id_4BE638DAB99C2ED5 && _id_7E67CC008AA22631;
  }

  if(isDefined(ammotype) && !_id_32C6E6F4FCB57314)
    br_ammo_update_ammotype_weapons(self, ammotype, self.br_ammo[ammotype]);

  if(!istrue(_id_7B9DE6DB6A90DBE7) && !istrue(_id_B4B637B07F3F9F25)) {
    if(scripts\mp\utility\weapon::grenadeinpullback())
      self _meth_3BB358C91ECD131D();

    self assignweaponprimaryslot(weaponname);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponname);
    scripts\mp\weapons::fixupplayerweapons(self, weaponname);
    scripts\mp\weapons::updatelastweaponobj(_id_DD515FCF025B2E79);
  }

  if(isDefined(pickupent.weapon) && isent(pickupent.weapon))
    pickupent.weapon delete();

  _id_66B3DB972AC1531E = undefined;

  foreach(weapon in self.equippedweapons) {
    if(isweapon(weapon) && weapon.inventorytype == "primary") {
      _id_A0CB84D50AFAAB7D = getcompleteweaponname(weapon);

      if(_id_A0CB84D50AFAAB7D == weaponname) {
        _id_66B3DB972AC1531E = weapon;
        break;
      }
    }
  }

  if(!isDefined(_id_66B3DB972AC1531E)) {
    _id_B4BC9DE65CB1EDC3 = scripts\engine\utility::_id_53C4C53197386572(weaponname, "undefined weapon name");
    message = "newWeaponObj is undefined in takeWeaponPickup is br_weapons.gsc with a weaponname of: " + _id_B4BC9DE65CB1EDC3;
    scripts\mp\utility\script::demoforcesre(message);
    return;
  }

  thread _id_123A6F38785CDF2D::giveweaponpickup(weaponname);

  if(isDefined(pickupent.instance))
    level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_trigger(pickupent.instance, self, _id_DD515FCF025B2E79);

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_4E479E14D0837E84 = undefined;

    if(isDefined(pickupent.instance) && isDefined(pickupent.instance._id_4E479E14D0837E84))
      _id_4E479E14D0837E84 = pickupent.instance._id_4E479E14D0837E84;
    else if(isDefined(pickupent._id_4E479E14D0837E84))
      _id_4E479E14D0837E84 = pickupent._id_4E479E14D0837E84;

    _id_0B7A9CE0A2282B79::_id_E5845FF9B61AC5D7(self, _id_66B3DB972AC1531E, _id_0EC22A950F210E39, _id_A64E5E1EE95C7B96, _id_44EE85DCF52B4001, _id_4E479E14D0837E84);
  }

  customweaponname = getcompleteweaponname(_id_66B3DB972AC1531E);
  self.tookweaponfrom[customweaponname] = undefined;

  if(isDefined(pickupent.instance) && isDefined(pickupent.instance.owner))
    self.tookweaponfrom[customweaponname] = pickupent.instance.owner;
}

_id_27EF2C36EB95D796() {
  _id_B8F96BD12748F572 = self _meth_B2ED366433A3D074();
  _id_49100FD322777E39 = 0;

  if(isDefined(_id_B8F96BD12748F572) && scripts\mp\weapons::isdroppableweapon(_id_B8F96BD12748F572)) {
    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_B8F96BD12748F572)) {
        _id_49100FD322777E39 = 1;
        break;
      }
    }
  }

  if(_id_49100FD322777E39)
    return _id_B8F96BD12748F572;

  return self.lastdroppableweaponobj;
}

_id_9C602BFCA5626687(pickupent) {
  level endon("game_ended");
  self endon("disconnect");

  while(self isreloading())
    waitframe();

  waitframe();
  takeammopickup(pickupent, 1);
}

takeammopickup(pickupent, _id_27B9FB21995D592C) {
  if(!istrue(_id_27B9FB21995D592C) && self isreloading()) {
    thread _id_9C602BFCA5626687(pickupent);
    return 0;
  }

  _id_C240D5BBB6B43A32 = 0;

  if(pickupent.scriptablename == "Ammo_Crate") {
    _id_5C3F9357F11D2223 = self getcurrentweapon().basename;
    _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(_id_5C3F9357F11D2223);
    clipsize = weaponclipsize(_id_5C3F9357F11D2223);
    ammotype = br_ammo_type_for_weapon(_id_5C3F9357F11D2223);

    if(isDefined(ammotype))
      _id_C240D5BBB6B43A32 = br_ammo_give_type(self, ammotype, clipsize);
  } else
    _id_C240D5BBB6B43A32 = br_ammo_give_type(self, pickupent.scriptablename, pickupent.count, 1);

  if(_id_C240D5BBB6B43A32) {
    pickupent.count = _id_C240D5BBB6B43A32;
    _id_10BBEACB1429824E = _id_C240D5BBB6B43A32;
  } else
    _id_10BBEACB1429824E = 0;

  return _id_10BBEACB1429824E;
}

br_forcegiveweapon(weaponname, player, completeweapon) {
  if(!scripts\engine\utility::array_contains(level.br_pickups.br_lootguns, weaponname))
    weaponname = br_getrandomlootweapon();

  _id_CE75C5B27952F765 = spawnStruct();
  _id_CE75C5B27952F765.loadoutprimaryfullname = weaponname;
  _id_CE75C5B27952F765.scriptablename = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  _id_CE75C5B27952F765.completeweapon = completeweapon;
  _id_CE75C5B27952F765.count = 0;
  _id_CE75C5B27952F765.countlefthand = 0;
  _id_CE75C5B27952F765._id_E97D731BEDD44C63 = 0;
  player takeweaponpickup(_id_CE75C5B27952F765);
}

br_getrandomlootweapon(weapontype, rarity) {
  if(!isDefined(weapontype))
    weapontype = "ar";

  if(!isDefined(rarity))
    rarity = "comm";

  weaponarray = [];

  foreach(weapon in level.br_pickups.br_lootguns) {
    if(issubstr(weapon, "_" + weapontype + "_")) {
      if(issubstr(weapon, "_" + rarity))
        weaponarray[weaponarray.size] = weapon;
    }
  }

  return weaponarray[randomint(weaponarray.size)];
}

br_getweaponstartingclipammo(weaponobj) {
  clipsize = weaponclipsize(weaponobj);
  return int(clipsize);
}

br_forcegivecustomweapon(player, weaponobj, _id_878AB837C6FE40DF, _id_5C3F9357F11D2223, _id_BDE57922CF2180D3, _id_EAAC92793F70B7DF, _id_7591ED99E87A77D3, _id_4E479E14D0837E84, _id_E1147886CCF51970) {
  if(player hasweapon(weaponobj)) {
    player scripts\mp\hud_message::showerrormessage("MP/BR_ALREADY_HOLDING_WEAPON");
    return 0;
  }

  hasmaxammo = weaponobj hasattachment("maxammo");
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.weapon = weaponobj;
  _id_60227BFF1E9478CC.loadoutprimaryfullname = _id_878AB837C6FE40DF;
  _id_60227BFF1E9478CC.scriptablename = _id_5C3F9357F11D2223;
  _id_60227BFF1E9478CC.origin = scripts\engine\utility::ter_op(isDefined(_id_7591ED99E87A77D3), _id_7591ED99E87A77D3, player.origin + (0, 0, 24));
  _id_60227BFF1E9478CC.count = br_getweaponstartingclipammo(weaponobj);
  _id_60227BFF1E9478CC.countlefthand = 0;
  _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = 0;
  _id_60227BFF1E9478CC._id_4E479E14D0837E84 = _id_4E479E14D0837E84;
  _id_60227BFF1E9478CC._id_E1147886CCF51970 = _id_E1147886CCF51970;

  if(hasmaxammo)
    _id_60227BFF1E9478CC.count = 999;

  if(isDefined(_id_BDE57922CF2180D3) && isDefined(_id_EAAC92793F70B7DF)) {
    _id_AC9CAEBED426E625 = weaponclipsize(weaponobj);
    _id_4429CFCFF681B936 = int(ceil(_id_AC9CAEBED426E625 * _id_BDE57922CF2180D3));
    _id_60227BFF1E9478CC.count = int(min(_id_4429CFCFF681B936, _id_EAAC92793F70B7DF));
  }

  if(scripts\mp\utility\weapon::isakimbo(weaponobj))
    _id_60227BFF1E9478CC.countlefthand = _id_60227BFF1E9478CC.count;

  if(weaponobj.hasalternate) {
    _id_A0F049FA949F48E9 = weaponobj getaltweapon();

    if(br_ammo_type_for_weapon(_id_A0F049FA949F48E9) != br_ammo_type_for_weapon(weaponobj)) {
      _id_6664D64B7CB8A858 = weaponclipsize(_id_A0F049FA949F48E9);
      _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = _id_6664D64B7CB8A858;

      if(hasmaxammo)
        _id_60227BFF1E9478CC._id_E97D731BEDD44C63 = 999;
    }
  }

  if(getdvarint("dvar_C8896A161AEBDA74", 0) > 0)
    player loadweaponsforplayer([_id_60227BFF1E9478CC.loadoutprimaryfullname]);

  player takeweaponpickup(_id_60227BFF1E9478CC);

  if(weaponobj.hasalternate) {
    _id_BE014A8D5A4F68F4 = weaponobj getaltweapon();

    if(_id_BE014A8D5A4F68F4.isalternate && _id_2669878CF5A1B6BC::_id_DE04E13AB01E1A10(_id_BE014A8D5A4F68F4.underbarrel)) {
      clipammo = weaponclipsize(_id_BE014A8D5A4F68F4);
      _id_2AA9CAEF99C9AF77 = int(clipammo);
      player setweaponammoclip(_id_BE014A8D5A4F68F4, _id_2AA9CAEF99C9AF77);
    }
  }

  return 1;
}

br_ammo_init() {
  if(istrue(level._id_FCD1AE93F5209B41)) {
    return;
  }
  level.br_ammo_types = [];
  level.br_ammo_types[0] = "brloot_ammo_919";
  level.br_ammo_types[1] = "brloot_ammo_12g";
  level.br_ammo_types[2] = "brloot_ammo_762";
  level.br_ammo_types[3] = "brloot_ammo_50cal";
  level.br_ammo_types[4] = "brloot_ammo_rocket";
  level.br_ammo_clipsize["brloot_ammo_919"] = 60;
  level.br_ammo_clipsize["brloot_ammo_12g"] = 16;
  level.br_ammo_clipsize["brloot_ammo_762"] = 60;
  level.br_ammo_clipsize["brloot_ammo_50cal"] = 16;
  level.br_ammo_clipsize["brloot_ammo_rocket"] = 1;
  level.br_ammo_max = [];
  level.br_ammo_omnvars = [];
  level.br_ammo_omnvars["brloot_ammo_919"] = "ui_br_smallarms_ammo";
  level.br_ammo_omnvars["brloot_ammo_12g"] = "ui_br_shotgun_ammo";
  level.br_ammo_omnvars["brloot_ammo_762"] = "ui_br_assault_ammo";
  level.br_ammo_omnvars["brloot_ammo_50cal"] = "ui_br_sniper_ammo";
  level.br_ammo_omnvars["brloot_ammo_rocket"] = "ui_br_rocket_ammo";
  level._id_E6EA72FC5E3FCD00 = [];
  level._id_E6EA72FC5E3FCD00["brloot_ammo_919"] = 150;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_12g"] = 40;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_762"] = 210;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_50cal"] = 40;
  level._id_E6EA72FC5E3FCD00["brloot_ammo_rocket"] = 6;
  level._id_E00C53FF08AA5FDB = getdvarint("dvar_7F141E09AFDD4E95", 1);
  level._id_01AA4FF5576B74B2 = getdvarint("dvar_A6F8CA984F2D9F90", 1) == 1;
  _id_436ADD9DE781CDFB::_id_3A363AE38F309166(::_id_801F575BA3157258);
  level._id_FCD1AE93F5209B41 = 1;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_weapons", "br_ammo_type_for_weapon", ::br_ammo_type_for_weapon);
}

br_ammo_player_init() {
  self endon("disconnect");
  thread br_ammo_player_hud_monitor();

  if(getdvarint("dvar_7A52196CE3C53C73", 0)) {
    thread _id_6681A5284FD5FAD1();
    thread _id_7E52B56769FA7774::_id_6FF4FEE4F07A3392();
  }

  for(;;) {
    self waittill("br_spawned");

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      _id_509D86412C9D7426 = self getweaponslistprimaries();

      foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
        _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);

        if(isDefined(_id_44C97DCE6932DE3C)) {
          if(scripts\mp\utility\weapon::isakimbo(_id_DE88CD14114C1E24)) {
            self setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C, "left");
            self setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C, "right");
            continue;
          }

          self setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C);
        }
      }
    }

    foreach(ammotype in level.br_ammo_types) {
      if(istrue(level._id_11525426FEEB297A) || istrue(self._id_11525426FEEB297A)) {
        if(isDefined(self.pers["br_ammo"]) && isDefined(self.pers["br_ammo"]))
          self.br_ammo[ammotype] = self.pers["br_ammo"][ammotype];
        else
          self.br_ammo[ammotype] = 0;

        continue;
      }

      if(!scripts\mp\flags::gameflag("prematch_done") && !istrue(level._id_376762409014CC8E)) {
        self.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];
        continue;
      }

      self.br_ammo[ammotype] = 0;
    }

    br_ammo_update_weapons(self);
    br_ammo_player_hud_update_ammotype("brloot_ammo_919");
    br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
    br_ammo_player_hud_update_ammotype("brloot_ammo_762");
    br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
    br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
  }
}

_id_6681A5284FD5FAD1() {
  self endon("disconnect");
  logstring("br_watch_mobile_cheat_weapon finished setup.");

  for(;;) {
    self waittill("luinotifyserver", message, _id_2150015540242E9E);
    _id_00EE6DDCDFB8E929 = "";
    _id_14004B68DDACB781 = "";
    _id_E7CD53FCB3B3E346 = [];

    if(message == "mobile_debug_give_weapon_augolf") {
      _id_00EE6DDCDFB8E929 = "iw9_ar_augolf_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_ar_augolf_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_ar_augolf_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_ar_augolf_rare";
          break;
        case 3:
          _id_14004B68DDACB781 = "brloot_weapon_ar_augolf_epic";
          break;
        case 4:
          _id_14004B68DDACB781 = "brloot_weapon_ar_augolf_lege";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_mike4") {
      _id_00EE6DDCDFB8E929 = "iw9_ar_mike4_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_ar_mike4_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_ar_mike4_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_ar_mike4_rare";
          break;
        case 3:
          _id_14004B68DDACB781 = "brloot_weapon_ar_mike4_epic";
          break;
        case 4:
          _id_14004B68DDACB781 = "brloot_weapon_ar_mike4_lege";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_mpapa5") {
      _id_00EE6DDCDFB8E929 = "iw9_sm_mpapa5_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_sm_mpapa5_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_sm_mpapa5_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_sm_mpapa5_rare";
          break;
        case 3:
          _id_14004B68DDACB781 = "brloot_weapon_sm_mpapa5_epic";
          break;
        case 4:
          _id_14004B68DDACB781 = "brloot_weapon_sm_mpapa5_lege";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_mbravo") {
      _id_00EE6DDCDFB8E929 = "iw9_sh_mbravo_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_sh_mbravo_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_sh_mbravo_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_sh_mbravo_rare";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_golf17") {
      _id_00EE6DDCDFB8E929 = "iw9_pi_golf17_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_pi_golf17_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_pi_golf17_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_pi_golf17_rare";
          break;
        case 3:
          _id_14004B68DDACB781 = "brloot_weapon_pi_golf17_epic";
          break;
        case 4:
          _id_14004B68DDACB781 = "brloot_weapon_pi_golf17_lege";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_pgolf") {
      _id_00EE6DDCDFB8E929 = "iw9_dm_pgolf1_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_dm_pgolf1_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_dm_pgolf1_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_dm_pgolf1_rare";
          break;
        case 3:
          _id_14004B68DDACB781 = "brloot_weapon_dm_pgolf1_epic";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_ax50") {
      _id_00EE6DDCDFB8E929 = "iw9_sn_alpha50_mp";

      switch (_id_2150015540242E9E) {
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_sn_alpha50_unco";
          break;
      }
    } else if(message == "mobile_debug_give_weapon_slima") {
      _id_00EE6DDCDFB8E929 = "iw9_lm_slima_mp";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_14004B68DDACB781 = "brloot_weapon_lm_slima_comm";
          break;
        case 1:
          _id_14004B68DDACB781 = "brloot_weapon_lm_slima_unco";
          break;
        case 2:
          _id_14004B68DDACB781 = "brloot_weapon_lm_slima_rare";
          break;
      }
    } else if(message == "mobile_debug_give_weapon") {
      _id_00EE6DDCDFB8E929 = "iw9_me_knife";

      switch (_id_2150015540242E9E) {
        case 0:
          _id_00EE6DDCDFB8E929 = "iw9_me_knife";
          _id_14004B68DDACB781 = "brloot_weapon_me_tactical_knife_comm";
          break;
        case 1:
          _id_00EE6DDCDFB8E929 = "iw9_la_rpapa7_mp";
          _id_14004B68DDACB781 = "brloot_weapon_la_rpapa7_comm";
          break;
      }
    }

    if(_id_00EE6DDCDFB8E929 != "") {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_00EE6DDCDFB8E929);

      if(_id_14004B68DDACB781 != "") {
        _id_FC5B5CABB888A488 = tablelookupbyrow(level.brloottablename, level.br_pickups.br_itemrow[_id_14004B68DDACB781], 9);

        if(isDefined(_id_FC5B5CABB888A488) && _id_FC5B5CABB888A488.size)
          _id_E7CD53FCB3B3E346 = strtok(_id_FC5B5CABB888A488, "+");
      }

      _id_C88B10F789ADF8EB = _id_2669878CF5A1B6BC::buildweapon(_id_00EE6DDCDFB8E929, _id_E7CD53FCB3B3E346, undefined, undefined, -1, undefined, undefined, undefined, 0);
      _id_CB4FAD49263E20C4 = spawnStruct();
      _id_CB4FAD49263E20C4.origin = self.origin;
      _id_CB4FAD49263E20C4.angles = self.angles;
      _id_CB4FAD49263E20C4.payload = 0;
      pickupent = _id_7E52B56769FA7774::spawnpickup(_id_14004B68DDACB781, _id_CB4FAD49263E20C4, weaponclipsize(_id_C88B10F789ADF8EB), 0, _id_C88B10F789ADF8EB, 1);

      if(!isDefined(pickupent)) {
        return;
      }
      pickupent.countlefthand = weaponclipsize(_id_C88B10F789ADF8EB);
      takeweaponpickup(pickupent);
      _id_7E52B56769FA7774::deregisterscriptableinstance(pickupent);
      pickupent freescriptable();
    }
  }
}

br_give_starting_ammo() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("weapons")) {
    return;
  }
  br_ammo_give_type(self, "brloot_ammo_919", 60, 0);
}

br_ammo_player_clear() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("weapons")) {
    return;
  }
  foreach(ammotype in level.br_ammo_types)
  self.br_ammo[ammotype] = 0;

  self notify("ammo_update");
}

br_ammo_player_is_maxed_out() {
  player = self;
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(ammotype)) {
      _id_E0116C5B8D303105 = player getweaponammoclip(_id_DE88CD14114C1E24, "right");
      _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);

      if(_id_E0116C5B8D303105 < _id_44C97DCE6932DE3C)
        return 0;

      if(_id_DE88CD14114C1E24._id_318338AA880DFAC6) {
        _id_734357A0B88E3A30 = player getweaponammoclip(_id_DE88CD14114C1E24, "left");

        if(_id_734357A0B88E3A30 < _id_44C97DCE6932DE3C)
          return 0;
      }

      if(!br_ammo_type_player_full(player, ammotype))
        return 0;
    }
  }

  return 1;
}

br_ammo_player_max_out() {
  player = self;
  _id_F32522625B3C7CF9 = [];
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(ammotype)) {
      _id_F32522625B3C7CF9[ammotype] = "dummy_value";
      _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);
      player setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C);
    }
  }

  foreach(ammotype, _id_97282C14346A7FCF in _id_F32522625B3C7CF9) {
    player.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];
    player br_ammo_player_hud_update_ammotype(ammotype);
  }

  br_ammo_update_weapons(player);
}

br_ammo_type_player_full(player, ammotype) {
  if(!isDefined(player.br_ammo) || !isDefined(player.br_ammo[ammotype]))
    return 0;

  if(!isDefined(level._id_E6EA72FC5E3FCD00[ammotype]))
    return 0;

  if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(ammotype))
    return 0;

  return _id_1E4A61DB11011446::get_int_or_0(player.br_ammo[ammotype]) >= level._id_E6EA72FC5E3FCD00[ammotype];
}

br_ammo_give_type(player, ammotype, amount, _id_8BB770D6EEDA5198) {
  if(level.br_ammo_max.size == 0)
    return 0;

  if(br_ammo_type_player_full(player, ammotype))
    return amount;

  if(!isDefined(_id_8BB770D6EEDA5198))
    _id_8BB770D6EEDA5198 = 0;

  _id_2C86AF91E7E20602 = 0;
  player.br_ammo[ammotype] = player.br_ammo[ammotype] + amount;

  if(player.br_ammo[ammotype] > level.br_ammo_max[ammotype]) {
    _id_2C86AF91E7E20602 = player.br_ammo[ammotype] - level.br_ammo_max[ammotype];

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(ammotype)) {
      _id_BADA25504E8844D7 = spawnStruct();
      _id_BADA25504E8844D7.scriptablename = ammotype;
      _id_BADA25504E8844D7.count = _id_2C86AF91E7E20602;
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
      player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_BADA25504E8844D7, !_id_8BB770D6EEDA5198);
      _id_2C86AF91E7E20602 = 0;
    } else if(!_id_8BB770D6EEDA5198 && _id_2C86AF91E7E20602 < level.br_ammo_clipsize[ammotype])
      _id_2C86AF91E7E20602 = 0;

    player.br_ammo[ammotype] = level.br_ammo_max[ammotype];
  }

  player br_ammo_player_hud_update_ammotype(ammotype);
  br_ammo_update_weapons(player);
  return _id_2C86AF91E7E20602;
}

br_ammo_take_type(player, ammotype, amount) {
  if(player.br_ammo[ammotype] <= 0)
    return 0;

  player.br_ammo[ammotype] = player.br_ammo[ammotype] - amount;

  if(player.br_ammo[ammotype] < 0)
    player.br_ammo[ammotype] = 0;

  player br_ammo_player_hud_update_ammotype(ammotype);
  br_ammo_update_weapons(player);
  return 1;
}

br_ammo_player_hud_monitor() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_5("ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");
    br_ammo_player_hud_update_ammotype("brloot_ammo_919");
    br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
    br_ammo_player_hud_update_ammotype("brloot_ammo_762");
    br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
    br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
  }
}

br_ammo_player_hud_update_ammotype(ammotype, _id_D2B0C34470701882) {
  _id_047905BF82C80D97 = 0;

  if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(ammotype)) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
    _id_2D9D24F7C63AC143::_id_5BAAA0CE73D6FE84(self, ammotype);
  }

  if(isDefined(level.br_ammo_omnvars[ammotype]) && isDefined(self.br_ammo[ammotype]))
    self setclientomnvar(level.br_ammo_omnvars[ammotype], self.br_ammo[ammotype] + _id_047905BF82C80D97);
}

br_ammo_update_weapons(player) {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("weapons")) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  player thread _id_B91FB4A74BCAE056(player);
}

_id_B91FB4A74BCAE056(player) {
  player br_wait_for_complete_reload();

  if(!isDefined(player)) {
    return;
  }
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_1C0BAEEC9828351C = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_1C0BAEEC9828351C)) {
      _id_5B3F7D686C59AB97 = _id_1E4A61DB11011446::get_int_or_0(player.br_ammo[_id_1C0BAEEC9828351C]);

      if(istrue(self._id_F497AE55EEF569AF))
        player setweaponammostock(_id_DE88CD14114C1E24, _id_5B3F7D686C59AB97, 1);
      else
        player setweaponammostock(_id_DE88CD14114C1E24, _id_5B3F7D686C59AB97);
    }
  }

  player notify("ammo_update");
}

_id_5143C54FB8C3C4FD(player, ammotype) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();
  _id_A9BC5314D494806D = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && ammotype == _id_7CAC4FF8E11F1BCA) {
      _id_5B3F7D686C59AB97 = self.br_ammo[ammotype];

      if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(ammotype)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
        _id_5B3F7D686C59AB97 = _id_5B3F7D686C59AB97 + _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
      }

      _id_5B3F7D686C59AB97 = _id_1E4A61DB11011446::get_int_or_0(_id_5B3F7D686C59AB97);
      player setweaponammostock(_id_DE88CD14114C1E24, _id_5B3F7D686C59AB97);
    }
  }

  player notify("ammo_update");
}

br_ammo_update_ammotype_weapons(player, ammotype, _id_23C054F415636C51) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
    _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
    _id_509D86412C9D7426[_id_509D86412C9D7426.size] = _id_9AC5E72784815708;
  }

  _id_A9BC5314D494806D = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && ammotype == _id_7CAC4FF8E11F1BCA) {
      if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(ammotype) && !_id_A9BC5314D494806D) {
        _id_EFB882BF4F27EE85 = level._id_E6EA72FC5E3FCD00[ammotype] - _id_23C054F415636C51;
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
        _id_750FCC188317845A = [];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
          if(player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8) == lootid)
            _id_750FCC188317845A[_id_AC0E594AC96AA3A8] = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
        }

        _id_2C20EA06F37F490A = tablesort(_id_750FCC188317845A, "up");

        foreach(index in _id_2C20EA06F37F490A) {
          _id_E30B916ADC1E2DC8 = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(index);

          if(_id_EFB882BF4F27EE85 <= _id_E30B916ADC1E2DC8) {
            _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(index, _id_EFB882BF4F27EE85);
            _id_EFB882BF4F27EE85 = 0;
            break;
          }

          _id_EFB882BF4F27EE85 = _id_EFB882BF4F27EE85 - _id_E30B916ADC1E2DC8;
          _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(index, _id_E30B916ADC1E2DC8);
        }

        _id_23C054F415636C51 = _id_23C054F415636C51 + (level._id_E6EA72FC5E3FCD00[ammotype] - _id_23C054F415636C51 - _id_EFB882BF4F27EE85);
      }

      _id_23C054F415636C51 = _id_1E4A61DB11011446::get_int_or_0(_id_23C054F415636C51);
      player setweaponammostock(_id_DE88CD14114C1E24, _id_23C054F415636C51);
      self.br_ammo[ammotype] = min(_id_23C054F415636C51, level._id_E6EA72FC5E3FCD00[ammotype]);
      self.br_ammo[ammotype] = _id_1E4A61DB11011446::get_int_or_0(self.br_ammo[ammotype]);
      _id_A9BC5314D494806D = 1;
    }
  }

  player notify("ammo_update");
}

br_ammo_type_for_weapon(weapon) {
  _id_0DD6BF5F9DBA888C = undefined;
  _id_D0A536D5580F1BDE = isDefined(weapon.underbarrel) && (issubstr(weapon.underbarrel, "selectsemi") || issubstr(weapon.underbarrel, "selectauto") || issubstr(weapon.underbarrel, "selectburst"));

  if(weapon.isalternate && !_id_D0A536D5580F1BDE) {
    if(isDefined(weapon.underbarrel) && (issubstr(weapon.underbarrel, "ubshtgn") || issubstr(weapon.underbarrel, "ub_sh")))
      return "brloot_ammo_12g";
    else
      _id_0DD6BF5F9DBA888C = "weapon_projectile";
  } else if(istrue(_id_2669878CF5A1B6BC::_id_417760651C48814B(weapon)))
    return undefined;
  else
    _id_0DD6BF5F9DBA888C = scripts\mp\utility\weapon::getweapongroup(weapon);

  return _id_A2FA56C4E1C77BA9(_id_0DD6BF5F9DBA888C);
}

_id_A2FA56C4E1C77BA9(_id_0DD6BF5F9DBA888C) {
  switch (_id_0DD6BF5F9DBA888C) {
    case "weapon_machine_pistol":
    case "weapon_smg":
    case "weapon_pistol":
      return "brloot_ammo_919";
    case "weapon_shotgun":
      return "brloot_ammo_12g";
    case "weapon_battle":
    case "weapon_lmg":
    case "weapon_assault":
      return "brloot_ammo_762";
    case "weapon_sniper":
    case "weapon_dmr":
      return "brloot_ammo_50cal";
    case "weapon_projectile":
      return "brloot_ammo_rocket";
  }

  return undefined;
}

_id_09E44F8D2E11EF1A(_id_73D33F45A70BFC9F) {
  switch (_id_73D33F45A70BFC9F) {
    case "brloot_ammo_rocket":
    case "brloot_ammo_50cal":
    case "brloot_ammo_12g":
    case "brloot_ammo_762":
    case "brloot_ammo_919":
      return 1;
  }

  return 0;
}

_id_801F575BA3157258() {
  if(!isDefined(self)) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::isplayeringulag()) {
    return;
  }
  thread _id_C0848667D62ED371();
}

_id_C0848667D62ED371() {
  objweapon = self getcurrentweapon();
  _id_811ABFDB6C33F17F = br_ammo_type_for_weapon(objweapon);

  if(!isDefined(_id_811ABFDB6C33F17F)) {
    return;
  }
  self._id_55562BD5EB6065E5 = self getweaponammoclip(objweapon);
  br_wait_for_complete_reload();

  if(!isDefined(self)) {
    self._id_55562BD5EB6065E5 = undefined;
    return;
  }

  if(objweapon != self getcurrentweapon() && !_id_1E4A61DB11011446::_id_F32857A938336F2B(self, objweapon)) {
    self._id_55562BD5EB6065E5 = undefined;
    return;
  }

  _id_7FF630BFBCA7B961 = self.br_ammo[_id_811ABFDB6C33F17F];

  if(!getdvarint("dvar_59A26F9BD4367B8D", istrue(level.prematchinfinitammo)) || scripts\mp\flags::gameflag("prematch_done")) {
    if(!self hasweapon(objweapon) && _id_1E4A61DB11011446::_id_F32857A938336F2B(self, objweapon))
      _id_7FF630BFBCA7B961 = self.br_ammo[_id_811ABFDB6C33F17F];
    else
      _id_7FF630BFBCA7B961 = self getweaponammostock(objweapon);
  }

  br_ammo_update_ammotype_weapons(self, _id_811ABFDB6C33F17F, _id_7FF630BFBCA7B961);

  if(isDefined(self.br_ammo[_id_811ABFDB6C33F17F]) && self.br_ammo[_id_811ABFDB6C33F17F] <= 0) {
    _id_54A24336CC9A143D = istrue(objweapon.isalternate) && (weaponclass(objweapon) == "grenade" || weaponclass(objweapon) == "spread");
    _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);
    _id_38497CE38042ADF7 = 0;

    switch (_id_2669878CF5A1B6BC::getweaponrootname(objweapon)) {
      case "iw8_sn_kilo98":
      case "iw9_la_mike32":
      case "iw9_dm_crossbow":
        _id_38497CE38042ADF7 = 1;
        break;
    }

    _id_DA66AF6058340796 = _id_38497CE38042ADF7 || _id_54A24336CC9A143D;

    if(!_id_DA66AF6058340796) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_811ABFDB6C33F17F);

      if(isDefined(lootid))
        scripts\cp_mp\calloutmarkerping::_id_1CED737A22161A49(22, lootid);
    }
  }

  self._id_55562BD5EB6065E5 = undefined;
}

br_wait_for_complete_reload() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self isreloading())
    waitframe();
}

_id_C668C8660AB99773(objweapon, player, dropstruct) {
  box = self;
  ammotype = br_ammo_type_for_weapon(objweapon);

  if(isDefined(ammotype)) {
    _id_B971E09CE070BD58 = player.br_ammo[ammotype];
    player.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];

    if(_id_B971E09CE070BD58 > 0 && istrue(level._id_E00C53FF08AA5FDB)) {
      _id_78BDCC21E4751868 = 0;

      if(isDefined(player.primaryweaponobj) && objweapon == player.primaryweaponobj)
        _id_78BDCC21E4751868 = 1;
      else if(isDefined(player.secondaryweaponobj) && objweapon == player.secondaryweaponobj)
        _id_78BDCC21E4751868 = 1;

      if(_id_78BDCC21E4751868) {
        if(level._id_01AA4FF5576B74B2 && isDefined(dropstruct))
          scripts\mp\equipment\support_box::_id_225B99924F316BC1(dropstruct, player, ammotype, _id_B971E09CE070BD58);
        else {
          _id_EDE16A605F45A41D = _id_B971E09CE070BD58;
          _id_7B207409AE007577 = spawnStruct();
          _id_7B207409AE007577.scriptablename = ammotype;
          _id_7B207409AE007577.count = _id_EDE16A605F45A41D;
          lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
          player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_7B207409AE007577);
        }
      }
    }

    br_ammo_update_weapons(player);
  }
}

br_give_weapon_clip(objweapon, _id_B153A3F2C4662B5E) {
  player = self;

  if(!isDefined(_id_B153A3F2C4662B5E))
    _id_B153A3F2C4662B5E = 1;

  ammotype = br_ammo_type_for_weapon(objweapon);

  if(isDefined(ammotype)) {
    _id_C1192C297BBF292F = int(level.br_ammo_clipsize[ammotype] * _id_B153A3F2C4662B5E);
    _id_237F7E1CA590E053 = level._id_E6EA72FC5E3FCD00[ammotype];

    if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(ammotype)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
      _id_237F7E1CA590E053 = _id_237F7E1CA590E053 + _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
    }

    _id_7FF630BFBCA7B961 = int(clamp(player.br_ammo[ammotype] + _id_C1192C297BBF292F, 0, _id_237F7E1CA590E053));
    br_ammo_update_ammotype_weapons(player, ammotype, _id_7FF630BFBCA7B961);
  }
}

br_give_weapon_ammo(objweapon, ammo) {
  player = self;
  ammotype = br_ammo_type_for_weapon(objweapon);

  if(isDefined(ammotype)) {
    _id_237F7E1CA590E053 = level._id_E6EA72FC5E3FCD00[ammotype];

    if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(ammotype)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);
      _id_237F7E1CA590E053 = _id_237F7E1CA590E053 + _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
    }

    _id_7FF630BFBCA7B961 = int(clamp(player.br_ammo[ammotype] + ammo, 0, _id_237F7E1CA590E053));
    br_ammo_update_ammotype_weapons(player, ammotype, _id_7FF630BFBCA7B961);
  }
}

isvalidcustomweapon(weaponobj) {
  if(!isDefined(weaponobj))
    return 0;

  if(!isweapon(weaponobj))
    return 0;

  if(isnullweapon(weaponobj))
    return 0;

  if(scripts\mp\weapons::isfistweapon(weaponobj) || scripts\mp\utility\weapon::isgunlessweapon(weaponobj) || scripts\mp\utility\weapon::ismeleeoverrideweapon(weaponobj))
    return 0;

  return 1;
}

brallowclasschoicefunc() {
  if(istrue(level.br_allowloadout) && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    return 1;
}

brloadoutupdateammo(_id_FF9807DAEEC4751C) {
  foreach(weapon in _id_FF9807DAEEC4751C)
  loadout_updatebrammo(weapon, weapon hasattachment("maxammo"));
}

loadout_updatebrammo(weapon, hasmaxammo) {
  ammotype = br_ammo_type_for_weapon(weapon);
  startammo = weaponstartammo(weapon);
  clipsize = weaponclipsize(weapon);
  maxammo = weaponmaxammo(weapon);
  _id_BCDA1F3BA70D2035 = undefined;

  if(hasmaxammo)
    _id_BCDA1F3BA70D2035 = maxammo;
  else
    _id_BCDA1F3BA70D2035 = startammo - clipsize;

  if(isDefined(ammotype)) {
    _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

    if(_id_FAF0D2FAC3F47583 == "rumble_mgl" || _id_FAF0D2FAC3F47583 == "champion")
      self.br_ammo[ammotype] = 0;

    if(getdvarint("dvar_1B973CFDBC2AABEC", 1)) {
      if(scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done")) {
        if(isDefined(level.br_ammo_max[ammotype]))
          _id_BCDA1F3BA70D2035 = int(min(level.br_ammo_max[ammotype], _id_BCDA1F3BA70D2035));
      }
    }

    if(istrue(level._id_376762409014CC8E))
      br_ammo_give_type(self, ammotype, maxammo);
    else
      br_ammo_give_type(self, ammotype, _id_BCDA1F3BA70D2035);
  }
}

_id_D885E66811EE3A4D(_id_4CE224053F650637) {
  _id_509D86412C9D7426 = self getweaponslistprimaries();
  _id_2CA75F603DE25B76 = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_4CE224053F650637 == _id_7CAC4FF8E11F1BCA)
      return 1;
  }

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
    _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
    _id_7CAC4FF8E11F1BCA = br_ammo_type_for_weapon(_id_9AC5E72784815708);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_4CE224053F650637 == _id_7CAC4FF8E11F1BCA)
      return 1;
  }

  return 0;
}

_id_937ACC181CFC6285() {
  if(getdvarint("bg_weapondiscardoptionsenabled", 0))
    return !self _meth_27BB46EAF2ECD374();

  return getdvarint("dvar_8C2F43C3816349FA", 0);
}

_id_823964AA15B30575() {
  _id_6FB2D8460BBFEABE = undefined;

  if(self _meth_C3A5505BC8F25A14()) {
    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(_id_7E52B56769FA7774::_id_AAFFA8AFA2D9C195(_id_DE88CD14114C1E24)) {
        _id_6FB2D8460BBFEABE = _id_DE88CD14114C1E24;
        break;
      }
    }
  } else if(self _meth_362521BCB3A1BA25()) {
    _id_AA84DA7B844EDAA5 = 8;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
      primaryweaponobj = self.primaryweapons[_id_AC0E594AC96AA3A8];

      if(!isnullweapon(primaryweaponobj) && !_id_7E52B56769FA7774::_id_AF4AEFC234671C2F(_id_AC0E594AC96AA3A8)) {
        _id_83106F206AE5A450 = level._id_81369E82645391F0[weaponclass(primaryweaponobj.basename)];
        _id_095F9039D76BF3AF = self _meth_337E400EAD27B7BD(_id_83106F206AE5A450);

        if(_id_095F9039D76BF3AF < _id_AA84DA7B844EDAA5) {
          _id_6FB2D8460BBFEABE = primaryweaponobj;
          _id_AA84DA7B844EDAA5 = _id_095F9039D76BF3AF;
        }
      }
    }
  }

  if(!isDefined(_id_6FB2D8460BBFEABE)) {
    if(self _meth_0617199566A43446()) {
      foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
        if(!scripts\mp\utility\weapon::iscacsecondaryweapon(_id_DE88CD14114C1E24)) {
          continue;
        }
        if(!isDefined(_id_6FB2D8460BBFEABE)) {
          _id_6FB2D8460BBFEABE = _id_DE88CD14114C1E24;
          continue;
        }

        _id_6FB2D8460BBFEABE = undefined;
        break;
      }
    }

    if(self _meth_27BB46EAF2ECD374()) {
      currentweapon = self getcurrentweapon();

      foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
        if(!issameweapon(currentweapon, _id_DE88CD14114C1E24)) {
          _id_6FB2D8460BBFEABE = _id_DE88CD14114C1E24;
          break;
        }
      }
    }
  }

  return _id_6FB2D8460BBFEABE;
}

_id_744E28EBE63C0358(_id_A700F4673C85C915) {
  _id_4C8D2E277A2EFAD9 = 1;
  _id_0EC22A950F210E39 = undefined;
  _id_060012A0838191D7 = self.primaryweapons.size;
  _id_7DC30386B50647A1 = 0;

  foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
    if(isnullweapon(_id_DE88CD14114C1E24)) {
      _id_060012A0838191D7--;
      continue;
    }

    if(issameweapon(_id_DE88CD14114C1E24, _id_A700F4673C85C915)) {
      _id_0EC22A950F210E39 = _id_DE88CD14114C1E24;
      _id_7DC30386B50647A1 = 1;
    }
  }

  if(_id_060012A0838191D7 > 1 && !_id_7DC30386B50647A1) {
    if(!self hasweapon("iw9_me_fists_mp")) {
      if(!isDefined(_id_0EC22A950F210E39))
        _id_0EC22A950F210E39 = _id_823964AA15B30575();

      _id_4C8D2E277A2EFAD9 = issameweapon(_id_0EC22A950F210E39, self getcurrentweapon());
    } else
      _id_4C8D2E277A2EFAD9 = scripts\mp\weapons::isfistweapon(self getcurrentweapon());
  } else
    _id_4C8D2E277A2EFAD9 = issameweapon(_id_0EC22A950F210E39, self getcurrentweapon());

  return _id_4C8D2E277A2EFAD9;
}

_id_8DABE5259E6844E9(_id_0EC22A950F210E39, _id_DD515FCF025B2E79) {
  _id_7B9DE6DB6A90DBE7 = 0;

  if(isDefined(_id_0EC22A950F210E39)) {
    _id_7B9DE6DB6A90DBE7 = _id_671DF7651500EA08(_id_DD515FCF025B2E79);

    if(!_id_7B9DE6DB6A90DBE7 && (self _meth_0617199566A43446() || self _meth_27BB46EAF2ECD374()))
      _id_7B9DE6DB6A90DBE7 = !issameweapon(_id_0EC22A950F210E39, self getcurrentweapon());
  }

  return _id_7B9DE6DB6A90DBE7;
}

_id_671DF7651500EA08(_id_DD515FCF025B2E79) {
  _id_7B9DE6DB6A90DBE7 = 0;

  if(_id_937ACC181CFC6285() && self _meth_362521BCB3A1BA25()) {
    _id_B27047C65737F75B = self getcurrentweapon();
    _id_185D0D5E6E0BE607 = level._id_81369E82645391F0[weaponclass(_id_B27047C65737F75B.basename)];
    _id_096ADEFE344D42A2 = self _meth_337E400EAD27B7BD(_id_185D0D5E6E0BE607);
    _id_A97D475BD039E5EC = level._id_81369E82645391F0[weaponclass(_id_DD515FCF025B2E79.basename)];
    _id_9AEE8300FD6E45EB = self _meth_337E400EAD27B7BD(_id_A97D475BD039E5EC);
    _id_7B9DE6DB6A90DBE7 = _id_9AEE8300FD6E45EB < _id_096ADEFE344D42A2;
  }

  return _id_7B9DE6DB6A90DBE7;
}

_id_B1DD9DCAE2F63965() {
  return getdvarint("dvar_1445BEA2674012B9", 0);
}

_id_B9DA718E50063452() {
  if(isDefined(level.br_pickups._id_C9015F26F73062A0)) {
    return;
  }
  level.br_pickups._id_C9015F26F73062A0 = [];
  thread _id_0A856FC2139EEF0C(2);
}

_id_AC3EC31BE7AAD7A7(_id_08488A6AF29DE20A) {
  _id_B9DA718E50063452();
  _id_712A14F78C75A0C2 = level.br_pickups._id_C9015F26F73062A0[self.guid];

  if(isDefined(_id_712A14F78C75A0C2)) {
    foreach(_id_C544EDC003A91D23 in _id_712A14F78C75A0C2.array) {
      if(_id_C544EDC003A91D23 == _id_08488A6AF29DE20A.index)
        return 1;
    }
  }

  return 0;
}

_id_8E7E1DA48D7746E5(player, _id_0CC708B3BF7C11ED) {
  _id_B9DA718E50063452();
  _id_712A14F78C75A0C2 = level.br_pickups._id_C9015F26F73062A0[player.guid];

  if(!isDefined(_id_712A14F78C75A0C2)) {
    _id_712A14F78C75A0C2 = spawnStruct();
    _id_712A14F78C75A0C2.array = [];
    _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 = 0;
    _id_712A14F78C75A0C2._id_A78288F999168A17 = 0;
    level.br_pickups._id_C9015F26F73062A0[player.guid] = _id_712A14F78C75A0C2;
  }

  _id_712A14F78C75A0C2.array[_id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7] = _id_0CC708B3BF7C11ED.index;
  _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 = scripts\engine\math::wrap(0, 4, _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 + 1);
  _id_712A14F78C75A0C2._id_A78288F999168A17 = gettime();
}

_id_0A856FC2139EEF0C(_id_50FBAAA3F3459D1B) {
  level endon("game_ended");

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_342CB0D14D88D2AB = getdvarint("dvar_5EFF4677B208A6B8", 45000);

    foreach(key, _id_712A14F78C75A0C2 in level.br_pickups._id_C9015F26F73062A0) {
      if(_id_6B7BEE46F2C6DA28 - _id_712A14F78C75A0C2._id_A78288F999168A17 >= _id_342CB0D14D88D2AB)
        level.br_pickups._id_C9015F26F73062A0[key] = undefined;
    }

    if(getdvarint("dvar_9723D1B7AB64DF07", 0))
      _id_C50D56273471BF54();

    wait(_id_50FBAAA3F3459D1B);
  }
}

_id_C50D56273471BF54() {
  _id_C215E2A76B873506 = 0;
  _id_96F1817624122314 = 0;

  foreach(_id_F4AE06A55C9C79DB in level.br_pickups._id_C9015F26F73062A0) {
    if(isDefined(_id_F4AE06A55C9C79DB)) {
      _id_96F1817624122314++;
      _id_C215E2A76B873506 = _id_C215E2A76B873506 + _id_F4AE06A55C9C79DB.array.size;
    }
  }
}

_id_AD972C1D0F29841C(player, weapon) {
  ammotype = br_ammo_type_for_weapon(weapon);

  if(!isDefined(ammotype))
    return 0;

  foreach(_id_DE88CD14114C1E24 in player.primaryweapons) {
    _id_3C8E002031CEBE5B = undefined;

    if(!isnullweapon(_id_DE88CD14114C1E24) && !issameweapon(_id_DE88CD14114C1E24, weapon))
      _id_3C8E002031CEBE5B = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_3C8E002031CEBE5B) && _id_3C8E002031CEBE5B == ammotype)
      return 0;
  }

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    _id_DE88CD14114C1E24 = _id_2D9D24F7C63AC143::_id_F2849DAE62F7444E(player);

    if(!isDefined(_id_DE88CD14114C1E24))
      return 1;

    _id_07908D034A3F457B = undefined;

    if(!isnullweapon(_id_DE88CD14114C1E24) && !issameweapon(_id_DE88CD14114C1E24, weapon))
      _id_07908D034A3F457B = br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_07908D034A3F457B) && _id_07908D034A3F457B == ammotype)
      return 0;
  }

  return 1;
}