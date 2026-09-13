/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6893a0a79807f057.gsc
***********************************************/

_id_7CAE93055DAE77EC() {
  _id_67FFF5B201C4698D = 120.0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    spawnangle = _id_67FFF5B201C4698D * _id_AC0E594AC96AA3A8 + randomfloatrange(-15, 15);
    spawnpos = level.player.origin + 75 * (cos(spawnangle), sin(spawnangle), 0);
    agent = scripts\mp\mp_agent::spawnnewagentaitype("support_mp_ar_base", spawnpos, (0, spawnangle, 0), level.player.team);
    agent.leader = level.player;
    agent._id_B786822D9A87AB34 = 1;
    agent thread _id_02AFD04EB035F975();
    agent thread _id_456FF70FC6A3B1F8();
  }
}

_id_1D901A49EA1A6787() {
  _id_67FFF5B201C4698D = 360.0;
  _id_BCD3907D1BEE5B81 = level.player.origin + anglesToForward(level.player.angles) * 1000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++) {
    spawnangle = _id_67FFF5B201C4698D * _id_AC0E594AC96AA3A8 + randomfloatrange(-15, 15);
    spawnpos = _id_BCD3907D1BEE5B81 + 75 * (cos(spawnangle), sin(spawnangle), 0);
    agent = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_ar_base", spawnpos, (0, spawnangle, 0), "team_hundred_ninety_five");
  }
}

_id_02AFD04EB035F975() {
  self endon("death");
  self.leader endon("death_or_disconnect");

  for(;;) {
    self.leader waittill("luinotifyserver", _id_EA3E3B2121E6713A, _id_394466C2DDB208CB, _id_60FDFB1CFD734D00);

    if(!isDefined(_id_EA3E3B2121E6713A) || !isDefined(_id_394466C2DDB208CB)) {
      continue;
    }
    if(_id_EA3E3B2121E6713A == "calloutmarkerping_cleared" && isDefined(self._id_01F7D056B16649F4) && self._id_01F7D056B16649F4 == _id_394466C2DDB208CB) {
      self notify("ping_canceled");
      self._id_01F7D056B16649F4 = undefined;
      continue;
    }

    switch (_id_EA3E3B2121E6713A) {
      case "calloutmarkerping_added":
        _id_A1823E6B1CB4B46D = self.leader calloutmarkerping_gettype(_id_394466C2DDB208CB);
        _id_8512C523DCA1FD8F = self.leader calloutmarkerping_getorigin(_id_394466C2DDB208CB);

        if(scripts\cp_mp\calloutmarkerping::_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
          _id_D16C481BAE2B1CD3 = self.leader calloutmarkerping_getEnt(_id_394466C2DDB208CB);

          if(isDefined(_id_D16C481BAE2B1CD3)) {
            self._id_01F7D056B16649F4 = _id_394466C2DDB208CB;
            self setgoalpos(getclosestpointonnavmesh(_id_D16C481BAE2B1CD3.origin));
          }
        } else if(scripts\cp_mp\calloutmarkerping::_id_5DACC89A40A58737(_id_A1823E6B1CB4B46D)) {
          _id_C0E3B7C8C7C23791 = self.leader calloutmarkerping_getEnt(_id_394466C2DDB208CB);

          if(isDefined(_id_C0E3B7C8C7C23791) && isDefined(_id_C0E3B7C8C7C23791.entity))
            _id_C0E3B7C8C7C23791 = _id_C0E3B7C8C7C23791.entity;

          self.favoriteenemy = _id_C0E3B7C8C7C23791;
          self notify("target_switch");
          thread _id_675553DB448C2741(_id_C0E3B7C8C7C23791);
        } else if(scripts\cp_mp\calloutmarkerping::_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
          _id_C0E3B7C8C7C23791 = self.leader calloutmarkerping_getEnt(_id_394466C2DDB208CB);

          if(isDefined(_id_C0E3B7C8C7C23791) && isDefined(_id_C0E3B7C8C7C23791.entity))
            _id_C0E3B7C8C7C23791 = _id_C0E3B7C8C7C23791.entity;

          self._id_01F7D056B16649F4 = _id_394466C2DDB208CB;
          self setgoalpos(getclosestpointonnavmesh(_id_C0E3B7C8C7C23791.origin));
        } else if(scripts\cp_mp\calloutmarkerping::_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D)) {} else {
          switch (_id_A1823E6B1CB4B46D) {
            case 3:
              break;
            case 4:
            case 2:
              self._id_01F7D056B16649F4 = _id_394466C2DDB208CB;
              self setgoalpos(getclosestpointonnavmesh(_id_8512C523DCA1FD8F));
              break;
            case 6:
              break;
            case 5:
              break;
            case 12:
              break;
            default:
          }
        }

        break;
    }
  }
}

_id_456FF70FC6A3B1F8() {
  self.leader endon("death_or_disconnect");

  for(;;) {
    self.leader waittill("damage", damage, attacker);

    if(isDefined(self.favoriteenemy) && self.leader.health >= 0.5 * self.leader.maxhealth) {
      continue;
    }
    if(isDefined(attacker) && isalive(attacker) && attacker.team != self.team) {
      if(isDefined(self.favoriteenemy) && self.favoriteenemy == attacker) {
        continue;
      }
      self.favoriteenemy = attacker;
      self notify("target_switch");
      thread _id_675553DB448C2741(attacker);
    }
  }
}

_id_675553DB448C2741(attacker) {
  self endon("death");
  self endon("target_switch");

  for(;;) {
    attacker waittill("death");
    self.favoriteenemy = undefined;
    return;
  }
}

_id_92CFD582AB09B167(pickup) {
  if(_id_2CEDCC356F1B9FC8::isammo(pickup.scriptablename)) {
    _id_FB40D5954B4F6792 = _id_7E52B56769FA7774::canholdammobox(pickup.scriptablename);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_F8A3FF0A73FA0C1D(pickup, _id_FB40D5954B4F6792);
    else if(_id_FB40D5954B4F6792)
      return 1;
    else
      return 4;
  }

  isautouse = istrue(pickup.isautouse);

  if(_id_7E52B56769FA7774::isweaponpickupitem(pickup)) {
    if(scripts\cp_mp\utility\player_utility::isinvehicle())
      return 17;

    _id_DD515FCF025B2E79 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];

    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

        if(isDefined(_id_60227BFF1E9478CC.scriptablename)) {
          result = _id_7E52B56769FA7774::_id_F8A3FF0A73FA0C1D(_id_60227BFF1E9478CC, _id_7E52B56769FA7774::canholdammobox(pickup.scriptablename));

          if(result == 1)
            result = 5;
          else if(result == 20)
            result = 27;

          return result;
        } else
          return 28;
      }
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && _id_2D9D24F7C63AC143::_id_3AB0A87EEAA203BF()) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    return 1;
  }

  if(_id_2CEDCC356F1B9FC8::isequipment(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup, isautouse);

    return 1;
  }

  if(_id_7E52B56769FA7774::isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit)
      return 11;

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup, isautouse);
  }

  if(_id_7E52B56769FA7774::isgasmask(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup, isautouse);
  }

  if(_id_7E52B56769FA7774::_id_6B5F3FB6550AE6D5(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

      if(istrue(result))
        return 20;
    }

    return 1;
  }

  if(_id_7E52B56769FA7774::iskillstreak(pickup.scriptablename)) {
    _id_A4E8372932B8612C = level.br_pickups._id_14BD11727C4B6629[pickup.scriptablename];

    if(!_id_7E52B56769FA7774::_id_A7CC24F3A189746A(_id_A4E8372932B8612C)) {
      if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename) && _id_2D9D24F7C63AC143::_id_D674D32C2D3BA5ED(self)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
        result = _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, pickup.count);

        if(istrue(result))
          return 20;
      }

      return 4;
    }
  }

  if(_id_7E52B56769FA7774::issuperpickup(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(_id_2D9D24F7C63AC143::_id_5E7049647595AB97())
        return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);
    }

    return 4;
  }

  if(_id_2CEDCC356F1B9FC8::isarmor(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_99AB09BA7022D107(pickup);

    return 1;
  }

  if(_id_7E52B56769FA7774::_id_A5202E2FC8ECB076(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(!isDefined(pickup.count))
        pickup.count = 1;

      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(_id_7E52B56769FA7774::isaccesscard(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_7E52B56769FA7774::_id_233D8364992B23B4(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);
  }

  if(_id_7E52B56769FA7774::_id_82D45592D750D388(pickup.scriptablename)) {
    if(_id_7E52B56769FA7774::_id_9A5D18FBDAD686C2(pickup.scriptablename)) {
      if(istrue(self._id_43B2A82936A5E974))
        return 23;
      else
        return 1;
    }

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
      index = _id_2D9D24F7C63AC143::_id_E05897F5D860188E(lootid, pickup.count, 0);

      if(isDefined(index)) {
        _id_E5FE6C50EC351711 = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(index);

        if(isDefined(_id_E5FE6C50EC351711) && isDefined(_id_E5FE6C50EC351711[1]) && _id_E5FE6C50EC351711[1] > 2)
          return 23;
      }

      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);
    }

    return 1;
  }

  if(_id_7E52B56769FA7774::_id_7E2F2A69FC0C022B(pickup.scriptablename) || _id_7E52B56769FA7774::_id_EAC097CE4C683AB9(pickup.scriptablename) || _id_7E52B56769FA7774::_id_CB1E30930C35F2E2(pickup.scriptablename) || _id_7E52B56769FA7774::_id_5449DA9D3D0358A4(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_7E52B56769FA7774::_id_55F0DAEA8408E3A9(pickup.scriptablename)) {
    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename))
      return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);

    return 1;
  }

  if(_id_7E52B56769FA7774::_id_9E3428357E5DF2E3(pickup.scriptablename)) {
    _id_2391409EF7B431E1::_id_B5D4FCC3FAB92696(pickup);

    if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
      if(_id_2391409EF7B431E1::_id_D9F5C5090DE1241B(self, pickup.count)) {
        [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(pickup.count);

        if(isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player))
          _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player, pickup.count);

        if(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player != self)
          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [self], undefined);

        return 1;
      }

      result = _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);

      if(result == 20) {
        if(isDefined(level._id_9A3C2481A4CD4B46))
          [[level._id_9A3C2481A4CD4B46]](self, pickup.count);

        if(_id_2391409EF7B431E1::_id_1129BA5718D33025(self, pickup.count))
          thread _id_2391409EF7B431E1::_id_EA29BCCF97CB1B9A(self, pickup.count);

        _id_2391409EF7B431E1::_id_B5FBE3CB4ED955F4(self, pickup.count);
      }

      return result;
    }

    return 1;
  }

  if(_id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(pickup.scriptablename)) {
    _id_0E9CFD120B0B43EF = _id_2CEDCC356F1B9FC8::_id_692C3DF266580DF6(pickup.scriptablename);

    if(self._id_BED158A6DFAC230D < _id_0E9CFD120B0B43EF)
      return 1;

    return _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);
  }

  if(_id_7E52B56769FA7774::_id_36DE08EA672B354C(pickup.scriptablename)) {
    if(isDefined(self._id_338C9E20B836E44C) && self._id_338C9E20B836E44C != "brloot_perkpack_custom" && self._id_338C9E20B836E44C == pickup.scriptablename) {
      if(_id_2D9D24F7C63AC143::_id_7E103028C464AB9A(pickup.scriptablename)) {
        result = _id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup);

        if(result == 4)
          return 29;
        else
          return result;
      } else
        return 4;
    }

    return 1;
  }

  return 4;
}

_id_B95656BC9F3D0896(_id_D16C481BAE2B1CD3) {
  self endon("ping_canceled");
  self waittill("goal");
  _id_9DA49B7A0E592D6D = _id_D16C481BAE2B1CD3 scriptableisdoor();
  _id_3D5823CC55965DD7 = _id_D16C481BAE2B1CD3 scriptableislootcache();
  isusable = _id_D16C481BAE2B1CD3 _meth_6954A8D7BA8CD9FB();

  if(isusable) {
    if(_id_9DA49B7A0E592D6D) {
      if(_id_D16C481BAE2B1CD3 scriptabledoorisclosed())
        return;
    } else {
      if(_id_3D5823CC55965DD7) {
        return;
      }
      part = _id_D16C481BAE2B1CD3.type;
      state = _id_D16C481BAE2B1CD3 getscriptablepartstate(part);
      pickup = spawnStruct();
      pickup.scriptablename = _id_D16C481BAE2B1CD3.type;
      pickup.origin = _id_D16C481BAE2B1CD3.origin;
      pickup.count = _id_7E52B56769FA7774::loot_getitemcount(_id_D16C481BAE2B1CD3);
      pickup.countlefthand = _id_7E52B56769FA7774::loot_getitemcountlefthand(_id_D16C481BAE2B1CD3);
      pickup._id_E97D731BEDD44C63 = _id_7E52B56769FA7774::_id_3A5F7703319142DD(_id_D16C481BAE2B1CD3);
      pickup.instance = _id_D16C481BAE2B1CD3;
      pickup.customweaponname = _id_D16C481BAE2B1CD3.customweaponname;
      pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
      pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];

      if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename]))
        pickup.count = level.br_pickups.counts[pickup.scriptablename];

      pickup.isweaponfromcrate = _id_D16C481BAE2B1CD3.isweaponfromcrate;
      pickup.isautouse = 0;

      if(!isDefined(_id_D16C481BAE2B1CD3) || _id_D16C481BAE2B1CD3 getscriptableisloot() && !_id_7E52B56769FA7774::_id_B6B71C738C7F7CA4(_id_D16C481BAE2B1CD3)) {
        results = _id_92CFD582AB09B167(pickup);

        if(results == 1)
          return _id_7E52B56769FA7774::_id_60234AA487445085(pickup, self, 0, _id_D16C481BAE2B1CD3);
        else if(results == 20)
          return _id_7E52B56769FA7774::_id_08F0BD51F5C6108B(pickup, self, 0, _id_D16C481BAE2B1CD3);
        else if(results == 5 || results == 27) {
          _id_DD515FCF025B2E79 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup)[0];
          _id_60227BFF1E9478CC = spawnStruct();
          _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
          _id_60227BFF1E9478CC.origin = pickup.origin;
          _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);

          if(results == 5)
            _id_7E52B56769FA7774::_id_60234AA487445085(_id_60227BFF1E9478CC, self);
          else
            _id_7E52B56769FA7774::_id_08F0BD51F5C6108B(_id_60227BFF1E9478CC, self);

          if(isDefined(_id_D16C481BAE2B1CD3)) {
            _id_7E52B56769FA7774::loothide(_id_D16C481BAE2B1CD3);
            return;
          }
        } else {}
      } else {}
    }
  }
}