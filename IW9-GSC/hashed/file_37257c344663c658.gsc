/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_37257c344663c658.gsc
***********************************************/

_id_054655641D3957E3(grenade) {
  ref = _id_7EF95BBA57DC4B82::_id_7F245729FCB6414D(grenade.weapon_name);
  grenade._id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);

  if(!isDefined(grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09)) {}

  if(istrue(grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_B79E08E886B92D46)) {
    if(!isDefined(self._id_801217FE248465C4)) {
      self._id_801217FE248465C4 = [];
      _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("onPlayerSpawn_destroyEquipment", ::_id_02BCD92A365FEF09);
    }

    self._id_801217FE248465C4[self._id_801217FE248465C4.size] = grenade;
  }

  grenade thread _id_C00FB7CC84F2D066();
  grenade thread _id_50A6B61F28FF21C8();
  thread _id_374B1ABF46319E21(grenade);
}

_id_C00FB7CC84F2D066() {
  self endon("death");
  self endon("underwater_swap");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread _id_0C44B639F5005AFA();
}

_id_50A6B61F28FF21C8() {
  self endon("death");
  self endon("underwater_swap");
  self waittill("forceDeath");
  thread _id_0C44B639F5005AFA();
}

_id_0C44B639F5005AFA(_id_6A94CF09AA6E486E) {
  if(istrue(self.exploding)) {
    return;
  }
  time = 0.25;

  if(!istrue(_id_6A94CF09AA6E486E))
    time = 0.0;

  self.exploding = 1;
  self setscriptablepartstate("destroy", "on", 0);
  thread _id_C5852887BDEA3EFB(time);
}

_id_C5852887BDEA3EFB(_id_CBF7BE4F62A0DDB2) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_6BF09CCAFB1E16D2)) {
    self setscriptablepartstate("electric", "neutral", 0);
    _id_84D5C7478409FED5 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_A3395B5076EB8A6C, 1.0);
    wait(_id_84D5C7478409FED5 + 0.5);
    self notify("death");
    wait(_id_CBF7BE4F62A0DDB2);

    if(isDefined(self)) {
      self._id_5BCBCEF205CB1486 = undefined;
      self delete();
      return;
    }
  } else {
    self notify("death");
    wait(_id_CBF7BE4F62A0DDB2);

    if(isDefined(self)) {
      self._id_5BCBCEF205CB1486 = undefined;
      self setscriptablepartstate("electric", "neutral", 0);
      self delete();
    }
  }
}

_id_CA6C37E5D8F35C8B(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  data.victim thread _id_5D58EA6516BF050C(0.2);
  return 1;
}

_id_02BCD92A365FEF09(params) {
  if(isDefined(self._id_801217FE248465C4)) {
    foreach(_id_9C08B7361B58E75F in self._id_801217FE248465C4) {
      if(isDefined(_id_9C08B7361B58E75F))
        _id_9C08B7361B58E75F _id_0C44B639F5005AFA();
    }

    self._id_801217FE248465C4 = [];
  }
}

_id_A5E91EAA60D034D7(grenade) {
  _id_87C2825D26C0F315 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "_launchGrenade"))
    _id_87C2825D26C0F315 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "_launchGrenade")]]("shock_stick_underwater_mp", grenade.origin, (0, 0, 0), undefined, 1);

  _id_74502A9E0EF1F19C::grenadeinitialize(_id_87C2825D26C0F315, makeweapon("shock_stick_underwater_mp"), 0, self);
  ref = _id_7EF95BBA57DC4B82::_id_7F245729FCB6414D(grenade.weapon_name);
  _id_87C2825D26C0F315._id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  _id_87C2825D26C0F315.owner = self;
  grenade notify("underwater_swap");
  grenade delete();
  _id_87C2825D26C0F315 setscriptablepartstate("danger-icon", "on", 0);
  _id_87C2825D26C0F315 thread _id_AB90D143E732B403();
  return _id_87C2825D26C0F315;
}

_id_374B1ABF46319E21(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade endon("death");
  _id_D442547D75DFFD09 = grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  _id_A681B7890CD017C7 = grenade _id_74502A9E0EF1F19C::_id_F69ED22535D90B78();

  if(!isDefined(_id_A681B7890CD017C7)) {
    return;
  }
  _id_64AF3CD16FFDB953 = 0;

  if(isDefined(_id_A681B7890CD017C7.stuckto)) {
    stuckto = _id_A681B7890CD017C7.stuckto;

    if(isPlayer(stuckto)) {
      grenade thread _id_74502A9E0EF1F19C::grenadestuckto(grenade, _id_A681B7890CD017C7.stuckto);
      _id_64AF3CD16FFDB953 = 1;
    } else
      grenade thread _id_74502A9E0EF1F19C::_id_4AF015619E2534BA(stuckto, ::_id_0C44B639F5005AFA, 1);

    grenade.stuckto = stuckto;
  }

  if(!_id_64AF3CD16FFDB953) {
    grenade thread _id_AB90D143E732B403();
    fusetime = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_359BFA5663381124, 0.35);
    fusetime = getdvarfloat("dvar_B3E986AD3C157F80", fusetime);
    self setscriptablepartstate("electric", "fuse", 0);
    wait(fusetime);
  }

  thread _id_C205D3A32BF04340(grenade, _id_A681B7890CD017C7);
}

_id_C205D3A32BF04340(grenade, _id_A681B7890CD017C7) {
  self endon("disconnect");
  level endon("game_ended");
  _id_D442547D75DFFD09 = grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  _id_5FBADC0F9063D647 = istrue(_id_D442547D75DFFD09._id_B79E08E886B92D46);

  if(istrue(grenade.exploding)) {
    return;
  }
  if(isDefined(_id_A681B7890CD017C7._id_6150B9D03028F80C)) {
    if(_id_5FBADC0F9063D647)
      grenade _id_0C44B639F5005AFA();
    else
      grenade = _id_A5E91EAA60D034D7(grenade);
  }

  grenade endon("death");

  if(_id_5FBADC0F9063D647) {
    if(!isDefined(_id_A681B7890CD017C7._id_6150B9D03028F80C))
      grenade _id_4D13735859A44508(_id_A681B7890CD017C7);
  } else {
    grenade setscriptablepartstate("electric", "active", 0);
    grenade setscriptablepartstate("detonate", "detonate", 0);
    grenade thread _id_F47AB824A48FE570(_id_A681B7890CD017C7);
  }
}

_id_AB90D143E732B403() {
  _id_6F9AB20311C32E55 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_890704710E61EBCC, 100);
  thread _id_74502A9E0EF1F19C::monitordamage(_id_6F9AB20311C32E55, "hitequip", ::_id_8E8A3B7D66FDC1B1, undefined);
}

_id_8E8A3B7D66FDC1B1(data) {
  _id_4714B4DF7581EF29(data.attacker);
  _id_0C44B639F5005AFA();
}

_id_4714B4DF7581EF29(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
  }
}

_id_13EFD74A5091DC42(_id_9C08B7361B58E75F) {
  if(self == _id_9C08B7361B58E75F)
    return 0;

  if(!isDefined(self))
    return 0;

  if(isPlayer(self))
    return _id_D3690389F7D8334C(_id_9C08B7361B58E75F);
  else if(istrue(self.exploding))
    return 0;
  else if(istrue(self._id_98E373D243C1936F))
    return 0;
  else
    return _id_407CDD75E41A385D(_id_9C08B7361B58E75F);

  return 1;
}

_id_407CDD75E41A385D(_id_9C08B7361B58E75F) {
  if(!isDefined(self.classname))
    return 0;

  if(!isDefined(self.owner) && !isagent(self) && self.classname != "misc_turret" && self.classname != "script_vehicle")
    return 0;

  if(_id_9C08B7361B58E75F == self)
    return 0;

  _id_D442547D75DFFD09 = _id_9C08B7361B58E75F._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(!istrue(_id_D442547D75DFFD09._id_05DD66EBDA239D1B))
    return 0;

  if(level.teambased) {
    if(isDefined(self.owner) && isDefined(self.team)) {
      if(_id_9C08B7361B58E75F.team == self.team && self.owner != _id_9C08B7361B58E75F.owner)
        return 0;
    }

    if(isDefined(level._id_F78FB7634E3797C4)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F78FB7634E3797C4.size; _id_AC0E594AC96AA3A8++) {
        if(level._id_F78FB7634E3797C4[_id_AC0E594AC96AA3A8] == self && self.team == _id_9C08B7361B58E75F.owner.team)
          return 0;
      }
    }
  }

  if(isDefined(self.weapon_name)) {
    weapontype = _id_74502A9E0EF1F19C::getweapontype(self.weapon_name);

    if(isDefined(weapontype)) {
      if(weapontype != "lethal" && weapontype != "tactical" && weapontype != "super" && !_id_10AD6174C8938599::_id_60DFACE26506153E(self.weapon_name))
        return 0;
    }
  }

  return 1;
}

_id_D3690389F7D8334C(_id_9C08B7361B58E75F) {
  _id_D442547D75DFFD09 = _id_9C08B7361B58E75F._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(scripts\cp\utility::isjuggernaut())
    return 0;

  if(istrue(_id_D442547D75DFFD09._id_B79E08E886B92D46) && (_id_B80ED39805876E5C(_id_9C08B7361B58E75F) || self == _id_9C08B7361B58E75F.owner))
    return 0;

  if(level.teambased) {
    if(!isDefined(self.team))
      return 1;

    if(_id_9C08B7361B58E75F.team == self.team && self != _id_9C08B7361B58E75F.owner)
      return 0;
  }

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  _id_160CF99A24C57B98 = _id_9C08B7361B58E75F _id_91A16C9B36FA1B5C(self);
  _id_672D556FCA0C15CC = scripts\engine\utility::_id_53C4C53197386572(5.0, _id_D442547D75DFFD09._id_95602B4D7262C11F);

  if(!isalive || _id_160CF99A24C57B98 >= _id_672D556FCA0C15CC)
    return 0;

  if(self sightconetrace(_id_9C08B7361B58E75F.origin, _id_9C08B7361B58E75F) <= 0)
    return 0;

  return _id_5E15CF3721CDCAAB(_id_9C08B7361B58E75F);
}

_id_F793C14E21581402(_id_9C08B7361B58E75F, _id_AEA56050CA64FC24) {
  _id_D442547D75DFFD09 = _id_9C08B7361B58E75F._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(istrue(_id_D442547D75DFFD09._id_B79E08E886B92D46) && (_id_B80ED39805876E5C(_id_9C08B7361B58E75F) || self == _id_9C08B7361B58E75F.owner))
    return 0;

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  _id_160CF99A24C57B98 = _id_9C08B7361B58E75F _id_91A16C9B36FA1B5C(self);
  _id_672D556FCA0C15CC = scripts\engine\utility::_id_53C4C53197386572(5.0, _id_D442547D75DFFD09._id_95602B4D7262C11F);

  if(!isalive || _id_160CF99A24C57B98 >= _id_672D556FCA0C15CC)
    return 0;

  if(self sightconetrace(_id_AEA56050CA64FC24.origin, _id_AEA56050CA64FC24) <= 0)
    return 0;

  return _id_5E15CF3721CDCAAB(_id_9C08B7361B58E75F);
}

_id_91A16C9B36FA1B5C(target) {
  if(!isDefined(self._id_5BCBCEF205CB1486))
    return 0;
  else {
    duration = self._id_5BCBCEF205CB1486[target getentitynumber()];

    if(!isDefined(duration))
      return 0;
    else
      return duration;
  }
}

_id_B80ED39805876E5C(_id_9C08B7361B58E75F) {
  if(!isDefined(self._id_CB886FF3371F4DF8))
    return 0;

  _id_D442547D75DFFD09 = _id_9C08B7361B58E75F._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  _id_C3FA36EB9AA40509 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_33BCE1558051CEB5, 0.3);
  _id_C3FA36EB9AA40509 = _id_C3FA36EB9AA40509 * 1000;
  return gettime() - self._id_CB886FF3371F4DF8 <= _id_C3FA36EB9AA40509;
}

_id_F47AB824A48FE570(_id_A681B7890CD017C7) {
  self endon("death");
  self.owner endon("disconnect");
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  ticks = 0;
  objweapon = makeweapon("shock_stick_mp");
  contents = ["physicscontents_item", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  _id_703E9FC257D523F1 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_48D181037894A0FE, 5.0);
  _id_703E9FC257D523F1 = getdvarfloat("dvar_2C69CB8CD7D267CD", _id_703E9FC257D523F1);
  _id_988C511564BEE3EA = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_ABA76142349AF9C0, 0.2);
  _id_988C511564BEE3EA = getdvarfloat("dvar_B2F16983A17DC833", _id_988C511564BEE3EA);
  _id_5112E7794DCA9367 = _id_703E9FC257D523F1 / _id_988C511564BEE3EA;
  _id_6CE919400E8C5E02 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_F196CC01F2B12053, 125);
  _id_D38B72705084C645 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_4D5D534EF8820D0A, 6);
  _id_46D6554BCB2371A1 = istrue(_id_D442547D75DFFD09._id_6BF09CCAFB1E16D2);

  if(_id_46D6554BCB2371A1)
    self._id_DAC6C64C0C59D452 = [];

  while(ticks < _id_5112E7794DCA9367) {
    ents = scripts\cp\utility::getentitiesinradius(self.origin, _id_6CE919400E8C5E02, undefined, undefined, physics_createcontents(contents));

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        continue;
      }
      if(ent == self) {
        continue;
      }
      if(!ent _id_13EFD74A5091DC42(self)) {
        continue;
      }
      if(isagent(ent) || isPlayer(ent)) {
        if(ent _meth_E40102956C887F7C())
          ent dodamage(_id_D38B72705084C645, self.origin, self.owner, self, "MOD_EXPLOSIVE", objweapon, "torso_upper");
        else if(ent != self.owner) {
          if(ent scripts\cp\utility::_hasperk("specialty_tac_resist"))
            self.owner _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
          else
            self.owner _id_5762AC2F22202BA2::updatedamagefeedback("");
        }
      }

      if(_id_46D6554BCB2371A1)
        self._id_DAC6C64C0C59D452[self._id_DAC6C64C0C59D452.size] = ent;

      thread _id_CF4FF41F0AE2047F(ent, objweapon, _id_46D6554BCB2371A1);
      _id_BBA576FC720ED9C5(ent);
      entisvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

      if(entisvehicle && istrue(ent.occupied) || !entisvehicle) {}
    }

    ticks++;
    wait(_id_988C511564BEE3EA);
  }

  _id_0C44B639F5005AFA();
}

_id_BBA576FC720ED9C5(ent) {
  entisvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(!istrue(entisvehicle)) {
    if(ent != self.owner) {
      if(level.teambased) {
        if(isDefined(ent.team) && isDefined(self.team)) {
          if(ent.team != self.team)
            return;
        }
      } else {}
    }
  } else if(scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(ent, self.owner))
    return;
}

_id_AFA7236CE2426C99(victim) {
  self endon("death");
  self.owner endon("disconnect");
  _id_84D5C7478409FED5 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_A3395B5076EB8A6C, 1.0);
  wait(_id_84D5C7478409FED5);
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  objweapon = makeweapon("shock_stick_mp");
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  _id_D38B72705084C645 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_4D5D534EF8820D0A, 6);
  _id_804EC4EF50698A33 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_606C50913543C2F6, 3);
  _id_B22BEC491EE6513D = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C0EE4E9B4B96DE5A, 125);
  ents = scripts\cp\utility\entity::getentitiesinradius(victim.origin, _id_B22BEC491EE6513D, undefined, undefined, physics_createcontents(contents));
  targets = [];
  _id_6305027F095FBC1B = victim.origin;
  _id_E5539FE48E93BDCC = 1;
  maxdistance = -1;
  _id_9C11B3617C013966 = 0;

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }
    if(ent == victim) {
      continue;
    }
    if(isagent(ent) || isPlayer(ent)) {
      if(!ent _id_F793C14E21581402(self, victim)) {
        continue;
      }
      if(level.teambased) {
        if(self.team == ent.team)
          continue;
      }

      if(scripts\engine\utility::array_contains(self._id_DAC6C64C0C59D452, ent)) {
        continue;
      }
      if(ent _meth_E40102956C887F7C())
        ent dodamage(_id_D38B72705084C645, self.origin, self.owner, self, "MOD_EXPLOSIVE", objweapon, "torso_upper");
      else if(ent != self.owner)
        self.owner _id_5762AC2F22202BA2::updatedamagefeedback("");

      if(targets.size < _id_804EC4EF50698A33) {
        _id_CED0426E7E729ED5 = spawnStruct();
        _id_CED0426E7E729ED5.ent = ent;
        targets[targets.size] = _id_CED0426E7E729ED5;
        continue;
      }

      if(_id_E5539FE48E93BDCC) {
        _id_E5539FE48E93BDCC = 0;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < targets.size; _id_AC0E594AC96AA3A8++) {
          targets[_id_AC0E594AC96AA3A8].dist = distancesquared(_id_6305027F095FBC1B, targets[_id_AC0E594AC96AA3A8].ent.origin);

          if(targets[_id_AC0E594AC96AA3A8].dist > maxdistance) {
            maxdistance = targets[_id_AC0E594AC96AA3A8].dist;
            _id_9C11B3617C013966 = _id_AC0E594AC96AA3A8;
          }
        }
      }

      _id_822DB80CE3C87A54 = distancesquared(_id_6305027F095FBC1B, ent.origin);

      if(_id_822DB80CE3C87A54 < maxdistance) {
        targets[_id_9C11B3617C013966].ent = ent;
        targets[_id_9C11B3617C013966].dist = _id_822DB80CE3C87A54;
        maxdistance = -1;
        _id_9C11B3617C013966 = -1;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < targets.size; _id_AC0E594AC96AA3A8++) {
          if(targets[_id_AC0E594AC96AA3A8].dist > maxdistance) {
            maxdistance = targets[_id_AC0E594AC96AA3A8].dist;
            _id_9C11B3617C013966 = _id_AC0E594AC96AA3A8;
          }
        }
      }
    }
  }

  foreach(target in targets)
  thread _id_CF4FF41F0AE2047F(target.ent, objweapon, 0);
}

_id_4D13735859A44508(_id_A681B7890CD017C7) {
  self endon("death");
  self setscriptablepartstate("beacon", "active", 0);
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  _id_775635EB25C3C213 = 0;
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  triggerradius = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_4262C0E42874114F, 125);

  while(!_id_775635EB25C3C213) {
    if(!isDefined(self.owner))
      _id_0C44B639F5005AFA();

    ents = scripts\cp\utility\entity::getentitiesinradius(self.origin, triggerradius, undefined, undefined, physics_createcontents(contents));

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        continue;
      }
      if(ent == self) {
        continue;
      }
      if(!ent _id_13EFD74A5091DC42(self)) {
        continue;
      }
      if(isagent(ent) || isPlayer(ent))
        _id_775635EB25C3C213 = 1;
    }

    if(!_id_775635EB25C3C213)
      wait 0.1;
  }

  self setscriptablepartstate("electric", "active", 0);
  self setscriptablepartstate("detonate", "detonate", 0);
  thread _id_F47AB824A48FE570(_id_A681B7890CD017C7);
}

_id_009B3D2DA91A6665(victim) {
  victim endon("haywire_cleared");
  self endon("death");

  if(!isDefined(self._id_5BCBCEF205CB1486))
    self._id_5BCBCEF205CB1486 = [];

  if(!isDefined(self._id_5BCBCEF205CB1486[victim getentitynumber()]))
    self._id_5BCBCEF205CB1486[victim getentitynumber()] = 0;

  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  _id_6B7054210E5DF55D = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_95602B4D7262C11F, 5.0);

  for(;;) {
    self._id_5BCBCEF205CB1486[victim getentitynumber()] = self._id_5BCBCEF205CB1486[victim getentitynumber()] + 0.05;

    if(self._id_5BCBCEF205CB1486[victim getentitynumber()] >= _id_6B7054210E5DF55D) {
      victim notify("haywire_max_duration");
      break;
    }

    wait 0.05;
  }
}

_id_CF4FF41F0AE2047F(victim, objweapon, _id_9EA07D2E4FF2E982) {
  level endon("game_ended");
  victim endon("disconnect");
  victim notify("shockStick_haywireApplied");
  victim endon("shockStick_haywireApplied");

  if(isPlayer(victim))
    victim thread _id_0CBB0697DE4C5728::_id_943511AB1F39DB66();

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);

  if(_id_9EA07D2E4FF2E982)
    childthread _id_AFA7236CE2426C99(victim);

  if(isPlayer(victim) || isagent(victim))
    childthread _id_009B3D2DA91A6665(victim);

  _id_EA2863C73339AE9E(data);
  _id_FB327FD48C0E34E0(data);
  _id_FCEF8D217A441961 = 0;

  if(isPlayer(data.victim) || isagent(data.victim))
    _id_FCEF8D217A441961 = !scripts\cp\utility\player::isreallyalive(data.victim);

  _id_46B866D198A76DDC(data, _id_FCEF8D217A441961);
}

_id_EA2863C73339AE9E(data) {
  if(!isDefined(data.damage))
    data.damage = 1;

  if(!isDefined(data.meansofdeath))
    data.meansofdeath = "MOD_EXPLOSIVE";

  if(!isDefined(data.point))
    data.point = (0, 0, 0);

  if(!isDefined(data.direction_vec))
    data.direction_vec = (0, 0, 0);

  if(!isDefined(data.modelname))
    data.modelname = 0;

  if(!isDefined(data.partname))
    data.partname = "";

  if(!isDefined(data.tagname))
    data.tagname = 0;

  if(!isDefined(data.damageflags))
    data.damageflags = 0;

  if(!isDefined(data.hitloc))
    data.hitloc = "none";

  if(!isDefined(data.timeoffset))
    data.timeoffset = 0;

  if(isagent(data.victim))
    thread _id_9B443E9C3E29F880(data);
  else if(isPlayer(data.victim))
    thread _id_C927FD013FC6E502(data.victim);
  else if(scripts\cp\utility\entity::isturret(data.victim) && !isDefined(data.victim._id_AA6FE6AF4CBBDD47))
    thread _id_805969CA0925B2BD(data);
  else
    thread _id_05DD66EBDA239D1B(data);
}

_id_805969CA0925B2BD(data) {
  level endon("game_ended");
  data.victim endon("death");
  data.victim endon("haywire_cleared");

  if(istrue(data.victim._id_12BFB031C0A0EFD8)) {
    return;
  }
  data.victim._id_12BFB031C0A0EFD8 = 1;
  turretweapon = data.victim.objweapon;

  if(!isDefined(turretweapon)) {
    return;
  }
  _id_6FCDBF704E881920 = data.victim.owner;

  if(!isDefined(_id_6FCDBF704E881920)) {
    return;
  }
  _id_6FCDBF704E881920 _meth_9E7F47B1711DCA62();
}

_id_FB327FD48C0E34E0(data) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  data.victim childthread _id_48F07EA78DAA5B21();
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  _id_160CF99A24C57B98 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_7C742AF3D434B807, 0.25);
  _id_160CF99A24C57B98 = getdvarfloat("dvar_E66E541920AC9101", _id_160CF99A24C57B98);
  data.victim scripts\engine\utility::waittill_any_timeout_3(_id_160CF99A24C57B98, "haywire_cleared", "haywire_max_duration", "shockstick_interrupt");
}

_id_48F07EA78DAA5B21() {
  self endon("haywire_cleared");
  self endon("haywire_max_duration");

  for(;;) {
    if(isPlayer(self)) {
      if(self isinexecutionvictim()) {
        self notify("shockstick_interrupt");
        break;
      }
    }

    waitframe();
  }
}

_id_A9A57668997E3C85(_id_12BFB031C0A0EFD8, _id_B121AB4966BFB436) {
  if(_id_12BFB031C0A0EFD8) {
    _id_3B64EB40368C1450::set("haywire_controls", "sprint", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "supersprint", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "ads", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "ascender_use", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "autoreload", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "reload", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "weapon_switch_clip", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "melee", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "offhand_throwback", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "supers", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "usability", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "interactions", 0);
    _id_3B64EB40368C1450::set("haywire_controls", "ladder", 0);

    if(!istrue(_id_B121AB4966BFB436))
      _id_3B64EB40368C1450::set("haywire_controls", "mantle", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("haywire_controls");
}

_id_C927FD013FC6E502(victim) {
  level endon("game_ended");

  if(istrue(victim._id_12BFB031C0A0EFD8) || victim scripts\cp_mp\utility\player_utility::isusingremote()) {
    return;
  }
  if(isDefined(victim.carryobject))
    victim notify("force_manual_drop");

  _id_9D97A6BEFBEAC652 = !isDefined(self._id_8BF83D28BE4C2D4F);
  victim _id_A9A57668997E3C85(1, _id_9D97A6BEFBEAC652);

  if(istrue(victim.revivingteammate))
    victim._id_4A2F2F50A9020E2E = 1;

  victim._id_12BFB031C0A0EFD8 = 1;
  victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);

  if(!istrue(_id_9D97A6BEFBEAC652))
    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_shockstick", self.owner, undefined, 1);

  _id_405B7207CD5F1B1D = "vm_ges_shockstick_react";
  _id_2869A3A20D48E6AD = victim getcurrentweapon();

  if(_id_2869A3A20D48E6AD.basename == "iw9_me_fists_mp")
    _id_405B7207CD5F1B1D = "vm_ges_shockstick_react_fists";

  while(!victim isgestureplaying(_id_405B7207CD5F1B1D)) {
    _id_2B2DBB6B26A12A45 = victim getcurrentweapon();

    if(isDefined(_id_2B2DBB6B26A12A45) && _id_2B2DBB6B26A12A45.basename != "none")
      victim forceplaygestureviewmodel(_id_405B7207CD5F1B1D);

    waitframe();
  }

  _id_D442547D75DFFD09 = undefined;

  if(!istrue(_id_9D97A6BEFBEAC652)) {
    _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

    if(istrue(_id_D442547D75DFFD09._id_B79E08E886B92D46)) {
      victim setempjammed(1);
      victim._id_CB886FF3371F4DF8 = gettime();
    }

    if(istrue(_id_D442547D75DFFD09._id_D5798377C05F4EDF))
      victim _meth_9E7F47B1711DCA62();

    if(istrue(_id_D442547D75DFFD09._id_07C149D627799674))
      victim _id_600C7C4C73C6A773(1);

    movespeedscale = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_77AE83EEDD8CAB0C, 0.8);
  } else {
    victim setempjammed(1);
    victim._id_CB886FF3371F4DF8 = gettime();
    victim _meth_9E7F47B1711DCA62();
    movespeedscale = 0.8;
  }

  movespeedscale = getdvarfloat("dvar_D677956E73B3BFB4", movespeedscale);

  if(!victim scripts\cp\utility::_hasperk("specialty_tac_resist")) {
    victim setmovespeedscale(movespeedscale);

    while(!victim _meth_E40102956C887F7C() && istrue(victim._id_12BFB031C0A0EFD8))
      wait 0.1;

    victim setmovespeedscale(1.0);
  } else
    victim scripts\cp\utility::_id_5A3FEF8CB39336B8("specialty_tac_resist");

  victim setempjammed(0);

  if(istrue(_id_9D97A6BEFBEAC652)) {
    victim _id_600C7C4C73C6A773(0);
    return;
  }

  if(istrue(_id_D442547D75DFFD09._id_07C149D627799674))
    victim _id_600C7C4C73C6A773(0);
}

_id_CF082013D5205E0D(weapon) {
  weaponname = weapon.basename;

  if(_id_AA6ACFF8443C394B(weaponname))
    return 1;

  if(_id_2669878CF5A1B6BC::_id_5419AC7173288FC1(weapon))
    return 1;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
    return 1;

  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(weaponname) || _id_02AABAC61F2AE422::_id_B04CBD5DB8951229(weaponname))
    return 1;

  if(scripts\cp_mp\killstreaks\helper_drone::_id_8C4AB0A7799E7AB8(weapon))
    return 1;
  else
    return 0;
}

_id_AA6ACFF8443C394B(weaponname) {
  switch (weaponname) {
    case "offhand_spotter_scope_mp":
    case "teammate_revive_stim_mp":
    case "hb_sensor_mp":
      return 1;
    default:
      return 0;
  }
}

_id_5E15CF3721CDCAAB(_id_9C08B7361B58E75F) {
  self endon("death_or_disconnect");
  _id_9C08B7361B58E75F endon("death");
  currentweapon = undefined;

  if(_id_74502A9E0EF1F19C::grenadeinpullback()) {
    currentweapon = _id_2669878CF5A1B6BC::getgrenadeinpullback();

    if(_id_9C08B7361B58E75F.owner == self && currentweapon.basename == "shock_stick_mp")
      return 1;

    currentweapon = _id_2669878CF5A1B6BC::getgrenadeinpullback();

    if(!isDefined(currentweapon))
      currentweapon = self.currentweapon;
  } else
    currentweapon = self.currentweapon;

  if(!isDefined(currentweapon) || isnullweapon(currentweapon))
    return 0;

  ammocount = self getweaponammoclip(currentweapon);
  _id_64615C1842352E97 = _id_CF082013D5205E0D(currentweapon);
  prevweapon = self.prevweaponobj;

  if(!isDefined(prevweapon))
    prevweapon = makeweapon("iw9_me_fists");

  if(!_id_64615C1842352E97) {
    _id_87CAAC6BF5E569E7 = self.origin;
    _id_11D2F075E9A0E643 = scripts\cp\utility::getequipmenttype(currentweapon.basename);

    if(!isDefined(_id_11D2F075E9A0E643))
      return 1;

    if(_id_11D2F075E9A0E643 == "tactical")
      _id_87CAAC6BF5E569E7 = self gettagorigin("tag_accessory_right");
    else if(_id_11D2F075E9A0E643 == "lethal")
      _id_87CAAC6BF5E569E7 = self gettagorigin("tag_accessory_left");

    _id_6E17D9FBF3B64B04 = (0, 0, 0);
    _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglesToForward(self.angles) * getdvarfloat("dvar_C7F7FB9EA22E108F", 200.0);
    _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglestoup(self.angles) * getdvarfloat("dvar_B2D4C6BD7DA9E85F", 100.0);
    scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(currentweapon, undefined, undefined, 1);
    _id_A22F69FAEA7636B1 = scripts\cp\utility::_launchgrenade(currentweapon.basename, _id_87CAAC6BF5E569E7, _id_6E17D9FBF3B64B04);
    self setweaponammoclip(currentweapon, ammocount - 1);
    _id_74502A9E0EF1F19C::grenadeinitialize(_id_A22F69FAEA7636B1, currentweapon, 0, self);
    _id_054655641D3957E3(_id_A22F69FAEA7636B1);
    return 1;
  } else
    return _id_DE0E81433EB4B20C(currentweapon);
}

_id_DE0E81433EB4B20C(currentweapon) {
  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(currentweapon.basename))
    return 0;
  else if(scripts\cp_mp\killstreaks\helper_drone::_id_8C4AB0A7799E7AB8(currentweapon))
    return 0;
  else if(_id_2669878CF5A1B6BC::_id_5419AC7173288FC1(currentweapon)) {
    self._id_4A2F2F50A9020E2E = 1;
    self notify("cancel_location");
    return 0;
  } else if(currentweapon.basename == "deploy_sentry_mp") {
    self notify("equip_deploy_cancel");
    return 1;
  } else if(_id_84422A637AA542E2(currentweapon.basename)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(currentweapon, undefined, undefined, 1);
    return 1;
  } else {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
    return 1;
  }
}

_id_84422A637AA542E2(weaponname) {
  _id_05A4002DD20A8C7B = 0;

  switch (weaponname) {
    case "offhand_spotter_scope_mp":
    case "hb_sensor_mp":
      return 1;
    default:
      return 0;
  }
}

_id_9B443E9C3E29F880(_id_91BEB5C3A5AB6910) {
  level endon("game_ended");
  victim = _id_91BEB5C3A5AB6910.victim;
  inflictor = _id_91BEB5C3A5AB6910.inflictor;
  attacker = _id_91BEB5C3A5AB6910.attacker;
  objweapon = _id_91BEB5C3A5AB6910.objweapon;

  if(victim.health > 0 && !victim scripts\asm\asm_bb::bb_isanimScripted()) {
    _id_DBA6BBE47BD81571 = gettime() > victim._blackboard._id_DC51D4EA36DA3AE1 + getdvarint("dvar_00ACF5B8FED3C019");
    victim._blackboard._id_DC51D4EA36DA3AE1 = gettime();

    if(victim asmhaspainstate(victim.asmname) && _id_DBA6BBE47BD81571)
      victim asmevalpaintransition(victim.asmname);

    victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);
    victim._id_12BFB031C0A0EFD8 = 1;

    if(_id_DBA6BBE47BD81571)
      victim dodamage(1, victim.origin, attacker, inflictor, "MOD_EXPLOSIVE", objweapon, "torso_upper");
  }
}

_id_05DD66EBDA239D1B(data) {
  level endon("game_ended");

  if(isDefined(data.victim._id_AA6FE6AF4CBBDD47))
    data.victim thread[[data.victim._id_AA6FE6AF4CBBDD47]](data);
}

_id_46B866D198A76DDC(data, _id_FCEF8D217A441961) {
  if(istrue(data.victim._id_12BFB031C0A0EFD8)) {
    data.victim._id_12BFB031C0A0EFD8 = undefined;

    if(isagent(data.victim))
      data.victim setscriptablepartstate("shockStickVfx", "off", 0);
    else if(isPlayer(data.victim))
      data.victim thread _id_6C0A9D95EBB14F2A(_id_FCEF8D217A441961);
    else if(scripts\cp\utility\entity::isturret(data.victim)) {
      if(isDefined(data.victim.owner) && (isPlayer(data.victim.owner) || isagent(data.victim.owner)))
        data.victim.owner _meth_05C5C9CBAE3114B0();
    } else if(isDefined(data.victim._id_2CA1A8CC9F467817))
      data.victim[[data.victim._id_2CA1A8CC9F467817]](data);

    data.victim notify("haywire_cleared");
  }
}

_id_F100472240074998(_id_9B9A9FD5C7F44AF0) {
  self._id_AA6FE6AF4CBBDD47 = _id_9B9A9FD5C7F44AF0;
}

_id_6EB20C71654FB6B4(_id_31AB61E6884F3BC2) {
  self._id_63CF7C55A99888EB = _id_31AB61E6884F3BC2;
}

_id_6C0A9D95EBB14F2A(_id_FCEF8D217A441961) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self _meth_05C5C9CBAE3114B0();
  _id_24FA1B56C39C25A9 = getdvarfloat("dvar_BCF804B0535227B8", 1.3);
  self setscriptablepartstate("shockStickVfx", "off", 0);
  _id_405B7207CD5F1B1D = "vm_ges_shockstick_react";
  _id_2869A3A20D48E6AD = self getcurrentweapon();

  if(_id_2869A3A20D48E6AD.basename == "iw9_me_fists_mp")
    _id_405B7207CD5F1B1D = "vm_ges_shockstick_react_fists";

  if(!_id_FCEF8D217A441961) {
    self stopgestureviewmodel(_id_405B7207CD5F1B1D);
    _id_A9A57668997E3C85(0);
  }
}

_id_600C7C4C73C6A773(lock) {
  stance = self getstance();

  if(lock) {
    if(stance == "stand") {
      _id_3B64EB40368C1450::set("shockstick_stance", "crouch", 0);
      _id_3B64EB40368C1450::set("shockstick_stance", "prone", 0);
    } else if(stance == "crouch") {
      _id_3B64EB40368C1450::set("shockstick_stance", "stand", 0);
      _id_3B64EB40368C1450::set("shockstick_stance", "prone", 0);
    } else if(stance == "prone") {
      _id_3B64EB40368C1450::set("shockstick_stance", "crouch", 0);
      _id_3B64EB40368C1450::set("shockstick_stance", "stand", 0);
    }
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("shockstick_stance");
}

_id_5D58EA6516BF050C(duration) {
  self endon("clearShockFX");
  self endon("disconnect");
  self notify("shockFX_active");
  self endon("shockFX_active");
  thread _id_17ADEB1FE103990D();
  wait(duration);
  _id_F4B9F15CB4D6E60B();
}

_id_17ADEB1FE103990D() {
  self notify("stopShockFX");
  self endon("disconnect");
  self endon("stopShockFX");

  for(;;) {
    if(!scripts\cp_mp\utility\player_utility::isreallyalive(self)) {
      return;
    }
    _id_D0FE1A6B5A5E42B5 = !istrue(self _meth_E40102956C887F7C());
    _id_A576CB241180FB7F = istrue(self._id_A576CB241180FB7F);

    if(_id_D0FE1A6B5A5E42B5 && _id_A576CB241180FB7F) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("shockStickDeath");

      self._id_A576CB241180FB7F = undefined;
    } else if(!_id_D0FE1A6B5A5E42B5 && !_id_A576CB241180FB7F) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("shockStickDeath", ::_id_A09639F24D4E918E);

      self._id_A576CB241180FB7F = 1;
    }

    waitframe();
  }
}

_id_F4B9F15CB4D6E60B() {
  self notify("stopShockFX");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("shockStickDeath");

  self._id_A576CB241180FB7F = undefined;
}

_id_A09639F24D4E918E(_id_3741EA5B9FB53EC3) {
  _id_3741EA5B9FB53EC3 setscriptablepartstate("shockStickDeath", "vfx_start", 0);
}