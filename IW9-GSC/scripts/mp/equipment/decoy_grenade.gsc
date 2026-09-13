/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\decoy_grenade.gsc
**************************************************/

decoy_init() {
  level.decoygrenades = [];
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.decoygrenadedata = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.firetypes = [];
  _id_962A30A9BB8C0F09.firetypeweights = [];
  _id_962A30A9BB8C0F09.firetimes = [];
  _id_962A30A9BB8C0F09.firemaxcounts = [];
  _id_962A30A9BB8C0F09.fireintervalmintimes = [];
  _id_962A30A9BB8C0F09.fireintervalmaxtimes = [];
  _id_962A30A9BB8C0F09.fireminupimpulse = [];
  _id_962A30A9BB8C0F09.firemaxupimpulse = [];
  _id_962A30A9BB8C0F09.fireminforwardimpulse = [];
  _id_962A30A9BB8C0F09.firemaxforwardimpulse = [];
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "ar";
  _id_962A30A9BB8C0F09.firetypeweights["ar"] = 35;
  _id_962A30A9BB8C0F09.firetimes["ar"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["ar"] = 3;
  _id_962A30A9BB8C0F09.fireintervalmintimes["ar"] = 0.5;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["ar"] = 2;
  _id_962A30A9BB8C0F09.fireminupimpulse["ar"] = 175;
  _id_962A30A9BB8C0F09.firemaxupimpulse["ar"] = 225;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["ar"] = 55;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["ar"] = 125;
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "smg";
  _id_962A30A9BB8C0F09.firetypeweights["smg"] = 50;
  _id_962A30A9BB8C0F09.firetimes["smg"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["smg"] = 4;
  _id_962A30A9BB8C0F09.fireintervalmintimes["smg"] = 0.25;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["smg"] = 1;
  _id_962A30A9BB8C0F09.fireminupimpulse["smg"] = 80;
  _id_962A30A9BB8C0F09.firemaxupimpulse["smg"] = 125;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["smg"] = 175;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["smg"] = 265;
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "sniper";
  _id_962A30A9BB8C0F09.firetypeweights["sniper"] = 15;
  _id_962A30A9BB8C0F09.firetimes["sniper"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["sniper"] = 2;
  _id_962A30A9BB8C0F09.fireintervalmintimes["sniper"] = 1;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["sniper"] = 3;
  _id_962A30A9BB8C0F09.fireminupimpulse["sniper"] = 250;
  _id_962A30A9BB8C0F09.firemaxupimpulse["sniper"] = 375;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["sniper"] = 0;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["sniper"] = 60;
}

decoy_used(grenade) {
  grenade endon("death");
  ref = _id_7EF95BBA57DC4B82::_id_7F245729FCB6414D(grenade.weapon_name);
  grenade._id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo(ref);
  _id_D442547D75DFFD09 = grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(!isDefined(grenade._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09)) {}

  if(istrue(_id_D442547D75DFFD09._id_F2F8C61E14FA90C5)) {
    if(!isDefined(self._id_2EE95D3EAE4FCE60)) {
      self._id_2EE95D3EAE4FCE60 = [];
      _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("onPlayerSpawn_destroyEquipment", ::_id_F2F8C61E14FA90C5);
    }

    self._id_2EE95D3EAE4FCE60[self._id_2EE95D3EAE4FCE60.size] = grenade;
  }

  scripts\mp\utility\print::printgameaction("decoy grenade spawn", grenade.owner);
  grenade.playersdebuffed = [];
  grenade.decoyassists = 0;
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::decoy_empapplied);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_9D529F508702DFE8);
  decoy_addtogloballist(grenade);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);

  if(istrue(_id_D442547D75DFFD09._id_92F375A60E3B214F)) {
    grenade scripts\cp_mp\emp_debuff::allow_emp(0);
    wait 0.4;
    grenade scripts\cp_mp\emp_debuff::allow_emp(1);
    _id_B38858F84E7951FD = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_E6573BDA1F59C5B8, 19);
    grenade thread scripts\mp\damage::monitordamage(_id_B38858F84E7951FD, "hitequip", ::decoy_handlefataldamage, ::decoy_handledamage);
    grenade thread decoy_monitorposition();
    wait 0.6;
    endtime = gettime() + 5000;
    _id_5DB609B6270B36F5 = gettime();
    _id_EDAA2169EC420478 = 3;

    while(gettime() < endtime) {
      if(gettime() >= _id_5DB609B6270B36F5) {
        _id_5DB609B6270B36F5 = gettime() + 200.0;

        if(grenade decoy_isonground()) {
          _id_EDAA2169EC420478--;

          if(_id_EDAA2169EC420478 == 0) {
            break;
          }
        } else
          _id_EDAA2169EC420478 = 3;
      }

      wait 0.2;
    }
  } else {
    _id_A681B7890CD017C7 = grenade _id_8100D200F92C6518();
    _id_B38858F84E7951FD = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_E6573BDA1F59C5B8, 19);
    grenade thread scripts\mp\damage::monitordamage(_id_B38858F84E7951FD, "hitequip", ::decoy_handlefataldamage, ::decoy_handledamage);
    armtime = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_8E21AF8D205F8107, 0.5);
    wait(armtime);
  }

  grenade thread decoy_monitorfuse();
  grenade thread decoy_activated();
}

decoy_activated() {
  self endon("death");
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  self setotherent(self.owner);

  if(self.weapon_name == "t10_decoy_grenade_mp")
    self setscriptablepartstate("beacon", "t10Active", 0);
  else
    self setscriptablepartstate("beacon", "active", 0);

  firetype = decoy_getfiretype();
  self._id_10CE829C0F6C6CE4 = [];

  if(istrue(_id_D442547D75DFFD09._id_3C615C401A26BA90))
    self._id_10CE829C0F6C6CE4["footFallSoundsPlayedTime"] = undefined;

  scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_decoy", self.owner, undefined, 0);
  self notify("decoy_sequence_started", self.origin);

  for(;;) {
    _id_E089BA219BA4B6E9(firetype);
    wait(randomfloatrange(1.5, 3.5));
  }
}

_id_E089BA219BA4B6E9(firetype) {
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(istrue(_id_D442547D75DFFD09._id_3C615C401A26BA90) && _id_4EF2FC84CDC52176()) {
    _id_EAC15A3E39A5B1AB = randomint(100);

    if(istrue(_id_D442547D75DFFD09._id_3C2F3B4105AB254C) || _id_EAC15A3E39A5B1AB > 35)
      _id_61DAABF7AD718D7C();
  }

  if(istrue(_id_D442547D75DFFD09._id_825D16386FE4C4A4))
    decoy_firesequence(firetype);
}

decoy_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread decoy_delete(0.1);
}

decoy_delete(delay) {
  if(!isDefined(delay))
    delay = 0;

  self notify("death");
  self.exploding = 1;
  decoy_removefromgloballist(self getentitynumber());
  scripts\mp\damage::monitordamageend();
  wait(delay);
  self delete();
}

_id_F2F8C61E14FA90C5(params) {
  if(isDefined(self._id_2EE95D3EAE4FCE60)) {
    foreach(_id_D53CBBE71A3A5853 in self._id_2EE95D3EAE4FCE60) {
      if(isDefined(_id_D53CBBE71A3A5853))
        _id_D53CBBE71A3A5853 decoy_destroy();
    }

    self._id_2EE95D3EAE4FCE60 = [];
  }
}

decoy_firesequence(firetype) {
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  _id_A2A92143787D00A4 = 1 + randomint(_id_962A30A9BB8C0F09.firemaxcounts[firetype]);

  for(;;) {
    _id_A2A92143787D00A4--;
    decoy_fireevent(firetype);

    if(_id_A2A92143787D00A4 == 0) {
      break;
    }

    wait(randomfloatrange(_id_962A30A9BB8C0F09.fireintervalmintimes[firetype], _id_962A30A9BB8C0F09.fireintervalmaxtimes[firetype]));
  }
}

_id_61DAABF7AD718D7C() {
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(istrue(istrue(_id_D442547D75DFFD09._id_3C2F3B4105AB254C)))
    self._id_8549D8B383189C34 = 1;

  _id_0E62AC38633D5DAD = scripts\engine\utility::random(_id_D442547D75DFFD09._id_5F1DA0FE731D593E);
  _id_E14619CB2CF279CA = _id_0E62AC38633D5DAD._id_6A2C0F46B832C6FA + randomint(_id_0E62AC38633D5DAD._id_CF7D2640E0D98E84);

  for(;;) {
    _id_E14619CB2CF279CA--;
    _id_A7201449BE7399AB(_id_0E62AC38633D5DAD);

    if(_id_E14619CB2CF279CA == 0) {
      if(istrue(_id_D442547D75DFFD09._id_3C2F3B4105AB254C)) {
        _id_0E62AC38633D5DAD = scripts\engine\utility::random(_id_D442547D75DFFD09._id_5F1DA0FE731D593E);
        _id_E14619CB2CF279CA = _id_0E62AC38633D5DAD._id_6A2C0F46B832C6FA + randomint(_id_0E62AC38633D5DAD._id_CF7D2640E0D98E84);
      } else
        break;
    }

    wait(randomfloatrange(_id_0E62AC38633D5DAD._id_597CAFFB4585D369, _id_0E62AC38633D5DAD._id_BCFBE97A5148E25B));
  }

  self._id_10CE829C0F6C6CE4["footFallSoundsPlayedTime"] = gettime();
}

_id_A7201449BE7399AB(_id_3C8B1CBFA325C448) {
  if(istrue(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_92F375A60E3B214F)) {
    origin = self.origin + (0, 0, 1.5);
    velocity = decoy_getvelocity(origin);
    angles = decoy_getfireeventangles(velocity);
    _id_D71630B8BAF84FA8 = _id_03D4031D0FF8CDB6(velocity, _id_3C8B1CBFA325C448, angles);
    _id_F24845EEAEEDC946 = self.owner getheldoffhand();

    if(!isDefined(_id_F24845EEAEEDC946) || _func_F581838CE4328F7A(_id_F24845EEAEEDC946) != "frag_grenade")
      self.owner scripts\mp\utility\weapon::_launchgrenade("decoy_grenade_mp", origin, _id_D71630B8BAF84FA8, 100, 1, self);

    self setCanDamage(1);
  }

  decoy_debuffenemiesinrange();
  _id_10BD16C4ADFE80D8 = _id_3C8B1CBFA325C448._id_A3BDF3F3509252C9;
  self setscriptablepartstate(_id_D08F9A08AFAED2F5(), _id_10BD16C4ADFE80D8, 0);
  wait(_id_3C8B1CBFA325C448._id_635A91D2DD01551D);
}

_id_D08F9A08AFAED2F5() {
  _id_D442547D75DFFD09 = self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;

  if(istrue(self._id_C99E4C450C908F1C)) {
    self._id_C99E4C450C908F1C = 0;
    return scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_ED2D8117C9ED9ECB, "footFallPartA");
  }

  self._id_C99E4C450C908F1C = 1;
  return scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_ED2D8217C9EDA0FE, "footFallPartB");
}

decoy_fireevent(firetype) {
  if(istrue(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_92F375A60E3B214F)) {
    origin = self.origin + (0, 0, 1.5);
    velocity = decoy_getvelocity(origin);
    angles = decoy_getfireeventangles(velocity);
    _id_D71630B8BAF84FA8 = decoy_getfireeventimpulse(velocity, firetype, angles);
    _id_F24845EEAEEDC946 = self.owner getheldoffhand();

    if(!isDefined(_id_F24845EEAEEDC946) || _func_F581838CE4328F7A(_id_F24845EEAEEDC946) != "frag_grenade")
      self.owner scripts\mp\utility\weapon::_launchgrenade("decoy_grenade_mp", self.origin, _id_D71630B8BAF84FA8, 100, 1, self);

    self setCanDamage(1);
  }

  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", firetype + "Fire", 0);
  self setscriptablepartstate("weaponSounds", firetype + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  decoy_debuffenemiesinrange(1);
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  wait(_id_962A30A9BB8C0F09.firetimes[firetype]);
}

_id_87152DFC9A628684() {
  if(!isDefined(self._id_10CE829C0F6C6CE4["footFallSoundsPlayedTime"]))
    return 1;

  return gettime() - self._id_10CE829C0F6C6CE4["footFallSoundsPlayedTime"] > 2000;
}

decoy_debuffenemiesinrange(_id_0FCE8828ABF8327B) {
  _id_617FCC52969F24B8 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_77B64BF7DEA3506B, 800);
  _id_7E9C12829CA09CA7 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_3B8CD7CF44335571, 2000);
  _id_46F5EFB8178285E9 = max(_id_617FCC52969F24B8, _id_7E9C12829CA09CA7);
  _id_5A532B3D41B19C7A = scripts\common\utility::_id_98A826B6B6D0D118(self.origin, _id_46F5EFB8178285E9);
  _id_5E048634C072B43B = undefined;

  foreach(enemy in _id_5A532B3D41B19C7A) {
    if(isPlayer(enemy) && !enemy scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, enemy))) {
      continue;
    }
    if(isPlayer(enemy)) {
      _id_5E048634C072B43B = distance(enemy.origin, self.origin);

      if(_id_5E048634C072B43B > _id_617FCC52969F24B8) {
        continue;
      }
      thread decoy_debuffenemy(enemy);
    } else if(istrue(_id_0FCE8828ABF8327B))
      enemy aieventlistenerevent("gunshot", self, self.origin);
    else
      enemy aieventlistenerevent("decoy_grenade", self, self.origin);

    if(isPlayer(self.owner)) {
      self.owner scripts\mp\damage::combatrecordtacticalstat("equip_decoy");
      self.owner scripts\mp\utility\stats::incpersstat("decoyHits", 1);
    }
  }
}

decoy_debuffenemy(player) {
  player endon("disconnect");
  self endon("death");
  owner = self.owner;
  owner endon("disconnect");
  self notify("decoy_debuffEnemy_" + player getentitynumber());
  self endon("decoy_debuffEnemy_" + player getentitynumber());

  if(!isDefined(self.playersdebuffed[player getentitynumber()])) {
    self.playersdebuffed[player getentitynumber()] = player;

    if(player != owner)
      _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "decoyDebuffed", 4.0);
  }

  result = player scripts\engine\utility::waittill_notify_or_timeout_return("death", 5);
  self.playersdebuffed[player getentitynumber()] = undefined;

  if(isDefined(player.lastkilledby) && player.lastkilledby != owner) {
    if(result == "death" && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, owner))) {
      if(self.decoyassists < 3) {
        owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF68378274BC9C41");
        self.decoyassists++;
      }
    }
  }
}

decoy_monitorposition() {
  self endon("death");

  for(;;) {
    oldposition = self.origin;
    waitframe();
    self.oldposition = oldposition;
  }
}

decoy_monitorfuse() {
  self endon("death");
  _id_2870C09375C519E7 = scripts\engine\utility::_id_53C4C53197386572(self._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_E4CE5A32B20ACA32, 15);
  wait(_id_2870C09375C519E7);
  thread decoy_destroy();
}

decoy_empapplied(_id_E527F023260C562C) {
  _id_E527F023260C562C.victim decoy_givepointsfordestroy(_id_E527F023260C562C.attacker);
  _id_E527F023260C562C.victim thread decoy_destroy();
}

_id_9D529F508702DFE8(data) {
  data.victim decoy_givepointsfordestroy(data.attacker);
  data.victim thread decoy_destroy();
}

decoy_handledamage(data) {
  scripts\mp\weapons::equipmenthit(self.owner, data.attacker, data.objweapon, data.meansofdeath);
  return data.damage;
}

decoy_handlefataldamage(data) {
  decoy_givepointsfordestroy(data.attacker, data.objweapon);
  thread decoy_destroy();
}

decoy_getfiretype() {
  _id_A78DC38B12EAFEBA = 0;
  _id_2873368D0CD5753F = [];
  _id_962A30A9BB8C0F09 = decoy_getleveldata();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_962A30A9BB8C0F09.firetypes.size; _id_AC0E594AC96AA3A8++) {
    firetype = _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
    _id_A78DC38B12EAFEBA = _id_A78DC38B12EAFEBA + _id_962A30A9BB8C0F09.firetypeweights[firetype];
    _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8] = _id_A78DC38B12EAFEBA;
  }

  _id_854B5C669A29592A = randomint(_id_A78DC38B12EAFEBA);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2873368D0CD5753F.size; _id_AC0E594AC96AA3A8++) {
    if(_id_854B5C669A29592A < _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8])
      return _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

decoy_getvelocity(origin) {
  if(!isDefined(self.oldposition))
    return undefined;

  return (origin - self.oldposition) / level.framedurationseconds;
}

decoy_getfireeventangles(velocity) {
  angles = undefined;

  if(!isDefined(velocity))
    angles = (0, randomint(360), 0);
  else if(velocity * (1, 1, 0) == (0, 0, 0))
    angles = (0, randomint(360), 0);
  else if(randomint(100) < 20)
    angles = (0, randomint(360), 0);
  else {
    angles = vectortoangles(velocity * (1, 1, 0));
    yaw = angleclamp180(angles[1]);
    yaw = yaw + angleclamp(-30.0 + randomint(61));
    angles = (angles[0], yaw, angles[2]);
  }

  return angles;
}

decoy_getfireeventimpulse(velocity, firetype, _id_7F51BB920D03D261) {
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  _id_D71630B8BAF84FA8 = velocity;
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglestoup(_id_7F51BB920D03D261) * randomfloatrange(_id_962A30A9BB8C0F09.fireminupimpulse[firetype], _id_962A30A9BB8C0F09.firemaxupimpulse[firetype]);
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglesToForward(_id_7F51BB920D03D261) * randomfloatrange(_id_962A30A9BB8C0F09.fireminforwardimpulse[firetype], _id_962A30A9BB8C0F09.firemaxforwardimpulse[firetype]);
  return _id_D71630B8BAF84FA8;
}

_id_03D4031D0FF8CDB6(velocity, _id_3C8B1CBFA325C448, _id_7F51BB920D03D261) {
  _id_D71630B8BAF84FA8 = velocity;
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglestoup(_id_7F51BB920D03D261) * randomfloatrange(_id_3C8B1CBFA325C448._id_EF5C03D1EA3BFA59, _id_3C8B1CBFA325C448._id_23F84923A02C6943);
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglesToForward(_id_7F51BB920D03D261) * randomfloatrange(_id_3C8B1CBFA325C448._id_63EDEC7B060E35A3, _id_3C8B1CBFA325C448._id_CC5D412DADEC37FD);
  return _id_D71630B8BAF84FA8;
}

decoy_isonground() {
  vel = decoy_getvelocity(self.origin);

  if(!isDefined(vel) || abs(vel[2]) <= 200) {
    if(decoy_isongroundraycastonly())
      return 1;
  }

  return 0;
}

decoy_isongroundraycastonly() {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  caststart = self.origin + (0, 0, 1);
  castend = caststart + (0, 0, -5);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    return 1;

  return 0;
}

decoy_givepointsfordestroy(attacker, objweapon) {
  if(isDefined(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, objweapon);
  }
}

decoy_addtogloballist(grenade) {
  level.decoygrenades[grenade getentitynumber()] = grenade;
}

decoy_removefromgloballist(entnum) {
  level.decoygrenades[entnum] = undefined;
}

decoy_getleveldata() {
  return level.decoygrenadedata;
}

_id_4EF2FC84CDC52176() {
  if(isDefined(self._id_8549D8B383189C34))
    return 0;

  return _id_87152DFC9A628684();
}

_id_8100D200F92C6518() {
  self endon("death");
  level endon("game_ended");
  self.owner endon("disconnect");
  _id_A681B7890CD017C7 = spawnStruct();
  childthread _id_3217C8851124AB5F(_id_A681B7890CD017C7);
  self waittill("missile_impact");
  return _id_A681B7890CD017C7;
}

_id_3217C8851124AB5F(_id_A681B7890CD017C7) {
  self endon("missile_impact");
  self waittill("missile_stuck", stuckto);

  if(isDefined(stuckto))
    _id_A681B7890CD017C7.stuckto = stuckto;

  self notify("missile_impact");
}