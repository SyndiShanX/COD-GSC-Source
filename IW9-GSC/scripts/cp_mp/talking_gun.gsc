/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\talking_gun.gsc
***********************************************/

_id_CE3FED6316F195B9(_id_00CEBA6EC7E8CA50) {
  _id_CB89110314447B2F = 0;

  for(;;) {
    eventname = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 1);
    delay = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 3);
    _id_D2F366B8F6B1F04B = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 4);
    _id_99B24FC8D56E8F8E = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 5);

    if(eventname == "") {
      break;
    }

    _id_81E38B9504BED322(eventname, delay, _id_D2F366B8F6B1F04B, _id_99B24FC8D56E8F8E);
    _id_CB89110314447B2F++;
  }
}

_id_81E38B9504BED322(eventname, delay, _id_D2F366B8F6B1F04B, _id_99B24FC8D56E8F8E) {
  result = spawnStruct();
  result.delay = delay;
  result._id_D2F366B8F6B1F04B = _id_D2F366B8F6B1F04B;
  result._id_99B24FC8D56E8F8E = _id_99B24FC8D56E8F8E;
  result.lines = [];
  level._id_020E6A6F36157ADC[eventname] = result;
}

_id_EBDA2510D1D4F81D(_id_00CEBA6EC7E8CA50) {
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_638952FA86A33C2E = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 0);
    eventname = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 1);
    _id_AEA36014C00AAFB3 = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 2);

    if(_id_638952FA86A33C2E == "") {
      break;
    }

    _id_6B8AA0609ECB3CBD(_id_CB89110314447B2F, _id_638952FA86A33C2E, eventname, _id_AEA36014C00AAFB3);
    _id_CB89110314447B2F++;
  }
}

_id_6B8AA0609ECB3CBD(index, _id_638952FA86A33C2E, eventname, _id_AEA36014C00AAFB3) {
  level._id_020E6A6F36157ADC[eventname].lines[_id_638952FA86A33C2E] = _id_AEA36014C00AAFB3;
  level._id_3C611FE759D6CF8D[_id_AEA36014C00AAFB3] = index;
}

_id_2FA456BB8A94B7A1(eventname, _id_A8CB22A5334BE44F, _id_9C40AF0F61186602) {
  if(!isDefined(level._id_020E6A6F36157ADC))
    _id_C961767B96992AF9();

  event = level._id_020E6A6F36157ADC[eventname];

  if(isDefined(event) && isDefined(event._id_1A2E4136162E552B)) {
    return;
  }
  _id_0E3FB66CB950F273 = spawnStruct();
  _id_0E3FB66CB950F273.eventid = _id_A8CB22A5334BE44F;
  _id_0E3FB66CB950F273.omnvar = scripts\engine\utility::ter_op(isDefined(_id_9C40AF0F61186602), _id_9C40AF0F61186602, "ui_talkinggun_faceid");

  if(!isDefined(level.event))
    level._id_020E6A6F36157ADC[eventname] = spawnStruct();

  level._id_020E6A6F36157ADC[eventname]._id_1A2E4136162E552B = _id_0E3FB66CB950F273;
}

_id_C961767B96992AF9() {
  thread _id_B77041C06BD0E53A();
  thread _id_E8084259D5E9E5A6();
  thread _id_2F181C374B1AF79D();
  level._id_020E6A6F36157ADC = [];
  level._id_3C611FE759D6CF8D = [];
  _id_CE3FED6316F195B9("talkinggunscreen_lines.csv");
  _id_EBDA2510D1D4F81D("talkinggunscreen_lines.csv");
}

_id_B04504FFD83192E1() {
  self._id_D1D541D826231CAD = spawnStruct();
  self._id_D1D541D826231CAD._id_B364FEE4D7C7A6D7 = 0.0;
  self._id_D1D541D826231CAD._id_49E5355E2642F48D = 0.0;
  self._id_D1D541D826231CAD._id_56560380A4B1A392 = [];
  self._id_D1D541D826231CAD._id_759862146A4569CB = 0.0;
  self._id_D1D541D826231CAD._id_076665EAAAABDA31 = 0.0;
  self._id_D1D541D826231CAD._id_B303CB73DD6407F5 = 0.0;
  self._id_D1D541D826231CAD._id_E759DA6EDF27A220 = 0;
  self._id_D1D541D826231CAD.lastdamagedtime = 0;
  self._id_D1D541D826231CAD._id_6A8D989A494B74C4 = 1;
  self._id_D1D541D826231CAD._id_FBCFC873987AE39E = 0;
  self._id_D1D541D826231CAD._id_CF433C13DD493F3F = [];
}

_id_2F181C374B1AF79D() {
  level endon("game_ended");

  for(;;) {
    wait 0.5;

    foreach(player in level._id_1642386C8E73A981) {
      if(!isDefined(player) || !isDefined(player._id_D1D541D826231CAD)) {
        continue;
      }
      _id_89B4EA3AB817D07D = isDefined(player.carryobject);
      _id_3821A301C5C7366D = isDefined(player.touchinggameobjects) && player.touchinggameobjects.size > 0;
      _id_A6E1E8C33F7A40FE = isDefined(player.usinggameobjects) && player.usinggameobjects.size > 0;
      _id_1EF9D4ABEA418A7E = _id_89B4EA3AB817D07D || _id_3821A301C5C7366D || _id_A6E1E8C33F7A40FE;

      if(_id_1EF9D4ABEA418A7E) {
        if(!istrue(player._id_D1D541D826231CAD._id_67A0BF18D97E0F61))
          _id_55B08D6D71B41402(player, "obj_capture");
      }

      player._id_D1D541D826231CAD._id_67A0BF18D97E0F61 = _id_1EF9D4ABEA418A7E;
    }
  }
}

_id_B77041C06BD0E53A() {
  level endon("game_ended");

  for(;;) {
    wait 1;
    time = gettime() / 1000.0;

    foreach(player in level._id_1642386C8E73A981) {
      if(!isDefined(player) || !isDefined(player._id_D1D541D826231CAD) || !isDefined(player.pers["totalDistTraveled"])) {
        continue;
      }
      if(!isDefined(player._id_D1D541D826231CAD._id_3B66EB954D36D751))
        player._id_D1D541D826231CAD._id_3B66EB954D36D751 = 0;

      if(!isDefined(player._id_D1D541D826231CAD._id_62FB673B6D0038E4))
        player._id_D1D541D826231CAD._id_62FB673B6D0038E4 = player.pers["totalDistTraveled"];

      _id_DB19FBCD5AF07943 = player.pers["totalDistTraveled"] - player._id_D1D541D826231CAD._id_62FB673B6D0038E4;
      player._id_D1D541D826231CAD._id_62FB673B6D0038E4 = player.pers["totalDistTraveled"];
      _id_7855FD9575DFD1BF = player getstance() == "prone";

      if(_id_DB19FBCD5AF07943 < 100) {
        player._id_D1D541D826231CAD._id_3B66EB954D36D751 = player._id_D1D541D826231CAD._id_3B66EB954D36D751 + 1;

        if(time > player._id_D1D541D826231CAD._id_49E5355E2642F48D + 30.0 && !_id_7855FD9575DFD1BF && player._id_D1D541D826231CAD._id_3B66EB954D36D751 > 15)
          _id_55B08D6D71B41402(player, "idle");

        continue;
      }

      player._id_D1D541D826231CAD._id_3B66EB954D36D751 = 0;
    }
  }
}

_id_E8084259D5E9E5A6() {
  self endon("game_ended");

  for(;;) {
    wait 0.1;
    time = gettime() / 1000.0;

    if(isDefined(level._id_1642386C8E73A981) && level._id_1642386C8E73A981.size > 0) {
      foreach(player in level._id_1642386C8E73A981) {
        if(!isDefined(player)) {
          continue;
        }
        _id_94DF8A1C478EFE5C = player playerads() > 0.3;

        if(_id_94DF8A1C478EFE5C) {
          if(player._id_D1D541D826231CAD._id_759862146A4569CB == 0.0)
            player._id_D1D541D826231CAD._id_759862146A4569CB = time;

          if(time - player._id_D1D541D826231CAD._id_759862146A4569CB > 4.0)
            _id_55B08D6D71B41402(player, "aiming_idle");

          continue;
        }

        if(player._id_D1D541D826231CAD._id_759862146A4569CB != 0.0)
          player._id_D1D541D826231CAD._id_759862146A4569CB = 0.0;
      }
    }
  }
}

_id_B97B71722A3DC5F0(player, eventname) {
  if(!isDefined(player._id_D1D541D826231CAD))
    return 0;

  if(!isDefined(player._id_D1D541D826231CAD._id_56560380A4B1A392[eventname]))
    return 0;

  _id_735A70BE53A0E4B5 = gettime() / 1000.0;
  event = level._id_020E6A6F36157ADC[eventname];
  return _id_735A70BE53A0E4B5 < player._id_D1D541D826231CAD._id_56560380A4B1A392[eventname] + event._id_99B24FC8D56E8F8E;
}

_id_7B50742A287D3CA1(player) {
  if(!isDefined(player._id_D1D541D826231CAD))
    return 0;

  if(player._id_D1D541D826231CAD.active)
    return 1;

  if(_id_B52945D0EC45B0CC(player)) {
    if(_id_D8239F9D7164D68E(player.primaryweaponobj))
      return 1;

    foreach(weapon in player.primaryweapons) {
      if(_id_D8239F9D7164D68E(weapon))
        return 1;
    }
  }

  return 0;
}

_id_B52945D0EC45B0CC(player) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player))
    return 1;

  if(player scripts\cp_mp\utility\player_utility::isusingremote())
    return 1;

  if(player _meth_415FE9EECA7B2E2B())
    return 1;

  return 0;
}

_id_547117B1A7105F45(player, delay, line) {
  player endon("death_or_disconnect");
  wait(delay);
  player setclientomnvar("ui_talkinggun_soundid", level._id_3C611FE759D6CF8D[line]);
}

_id_A1E1B35A0BD2F57C(player, eventname) {
  if(!_id_7B50742A287D3CA1(player))
    return 0;

  if(!isDefined(level._id_020E6A6F36157ADC))
    _id_C961767B96992AF9();

  event = level._id_020E6A6F36157ADC[eventname];

  if(!isDefined(event) || !isDefined(event.lines) || !isDefined(event.lines[player._id_D1D541D826231CAD._id_DE1FD66F1B22F6A9]))
    return 0;

  return 1;
}

_id_E4D7E0E2FA1FE358() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "gameFlag")) {
    _id_DFD52EF074FB36AF = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "gameFlag")]]("prematch_done");

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(level.skipprematch) && !_id_DFD52EF074FB36AF)
      return 1;

    return _id_DFD52EF074FB36AF;
  }

  return 1;
}

_id_CD101CA0E17CFD60(player, eventname) {
  if(!_id_7B50742A287D3CA1(player))
    return 0;

  if(!_id_E4D7E0E2FA1FE358())
    return 0;

  if(!isDefined(level._id_020E6A6F36157ADC))
    _id_C961767B96992AF9();

  event = level._id_020E6A6F36157ADC[eventname];

  if(!_id_A1E1B35A0BD2F57C(player, eventname))
    return 0;

  _id_735A70BE53A0E4B5 = gettime() / 1000.0;

  if(_id_735A70BE53A0E4B5 < player._id_D1D541D826231CAD._id_B364FEE4D7C7A6D7)
    return 0;

  if(_id_B97B71722A3DC5F0(player, eventname))
    return 0;

  player._id_D1D541D826231CAD._id_B364FEE4D7C7A6D7 = _id_735A70BE53A0E4B5 + event._id_D2F366B8F6B1F04B + event.delay;
  player._id_D1D541D826231CAD._id_49E5355E2642F48D = _id_735A70BE53A0E4B5;
  player._id_D1D541D826231CAD._id_56560380A4B1A392[eventname] = _id_735A70BE53A0E4B5 + event.delay;
  return 1;
}

_id_09667B86A2C02B9A(player, eventname) {
  if(!_id_7B50742A287D3CA1(player))
    return undefined;

  if(!_id_E4D7E0E2FA1FE358())
    return undefined;

  if(!isDefined(level._id_020E6A6F36157ADC))
    _id_C961767B96992AF9();

  event = level._id_020E6A6F36157ADC[eventname];

  if(!isDefined(event))
    return undefined;

  return event._id_1A2E4136162E552B;
}

_id_55B08D6D71B41402(player, eventname) {
  _id_DAF69D284BD60FDF = _id_09667B86A2C02B9A(player, eventname);

  if(isDefined(_id_DAF69D284BD60FDF))
    player setclientomnvar(_id_DAF69D284BD60FDF.omnvar, _id_DAF69D284BD60FDF.eventid);

  if(!_id_CD101CA0E17CFD60(player, eventname)) {
    return;
  }
  event = level._id_020E6A6F36157ADC[eventname];
  thread _id_547117B1A7105F45(player, event.delay, event.lines[player._id_D1D541D826231CAD._id_DE1FD66F1B22F6A9]);
}

_id_C5F05871BA7C3AA3() {
  _id_DD2DECF8DB7E69B8 = self getweaponammostock(self.currentweapon);
  _id_AB0EE360900BCB85 = weaponmaxammo(self.currentweapon);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_weapons", "br_ammo_type_for_weapon")) {
    ammotype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_weapons", "br_ammo_type_for_weapon")]](self.currentweapon);

    if(isDefined(ammotype))
      _id_AB0EE360900BCB85 = level._id_E6EA72FC5E3FCD00[ammotype];
  }

  if(_id_DD2DECF8DB7E69B8 > _id_AB0EE360900BCB85 * 0.3)
    _id_55B08D6D71B41402(self, "reload_start");
  else
    _id_55B08D6D71B41402(self, "ammo_reserve_low");
}

_id_81F5578AED261DA1(player) {
  _id_55B08D6D71B41402(player, "loot_found");
}

_id_44CDB18EB18593DE(team, _id_EFA8EF05B190D7D0) {
  if(isDefined(_id_EFA8EF05B190D7D0) && isDefined(_id_EFA8EF05B190D7D0.name) && _id_EFA8EF05B190D7D0.name == "hold") {
    return;
  }
  wait 1.0;

  if(isDefined(level._id_1642386C8E73A981)) {
    foreach(player in level._id_1642386C8E73A981) {
      if(!isDefined(player)) {
        continue;
      }
      if(player.team == team)
        _id_55B08D6D71B41402(player, "contract_start");
    }
  }
}

_id_952D1A246A3ECE86(player) {
  wait 2.0;
  _id_55B08D6D71B41402(player, "activate_uav");
}

_id_BF5315076804B215(team) {
  if(isDefined(level._id_1642386C8E73A981)) {
    foreach(player in level._id_1642386C8E73A981) {
      if(!isDefined(player)) {
        continue;
      }
      if(player.team == team)
        _id_55B08D6D71B41402(player, "contract_complete");
    }
  }
}

_id_4CCA00246F03B1F2(player, _id_0D2346943E5CB1F5, _id_B947C76FCEF1AFDB) {
  _id_DE1FD66F1B22F6A9 = player._id_D1D541D826231CAD._id_DE1FD66F1B22F6A9;

  for(;;) {
    wait 20.0;

    if(!isDefined(_id_0D2346943E5CB1F5)) {
      return;
    }
    playsoundatpos(_id_B947C76FCEF1AFDB, level._id_020E6A6F36157ADC["no_user_bark"].lines[_id_DE1FD66F1B22F6A9]);
  }
}

_id_ABA04688789CE643(_id_0D2346943E5CB1F5, objweapon, _id_CDCE80998EC668EE) {
  if(!_id_D8239F9D7164D68E(_id_0D2346943E5CB1F5)) {
    return;
  }
  if(!_id_CD101CA0E17CFD60(self, "dropped")) {
    return;
  }
  if(isDefined(_id_CDCE80998EC668EE))
    _id_B947C76FCEF1AFDB = _id_CDCE80998EC668EE;
  else
    _id_B947C76FCEF1AFDB = _id_0D2346943E5CB1F5.origin;

  playsoundatpos(_id_B947C76FCEF1AFDB, level._id_020E6A6F36157ADC["dropped"].lines[self._id_D1D541D826231CAD._id_DE1FD66F1B22F6A9]);
  thread _id_4CCA00246F03B1F2(self, _id_0D2346943E5CB1F5, _id_B947C76FCEF1AFDB);
}

_id_BD70B31DD13292BC(player) {
  player endon("death_or_disconnect");
  level endon("game_ended");
  wait 2;
  _id_55B08D6D71B41402(player, "player_death_revived_teammate");
}

_id_BD70A21DD1326D59(player) {
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(player._id_D1D541D826231CAD) && istrue(player._id_D1D541D826231CAD._id_6A8D989A494B74C4))
    player._id_D1D541D826231CAD._id_6A8D989A494B74C4 = 0;

  wait 2;
  _id_55B08D6D71B41402(player, "teammate_death_revived_me");
}

_id_14C5B1A6F5A9F37C(data) {
  if(isDefined(data.victim._id_D1D541D826231CAD)) {
    data.victim._id_D1D541D826231CAD._id_E759DA6EDF27A220 = 0;
    data.victim._id_D1D541D826231CAD._id_56560380A4B1A392 = [];
    data.victim._id_D1D541D826231CAD._id_6A8D989A494B74C4 = 1;
    data.victim._id_D1D541D826231CAD.active = 0;
  }

  if(data.attacker == data.victim) {
    return;
  }
  if(!isPlayer(data.attacker)) {
    return;
  }
  foreach(_id_6EE5484560EC747C in level._id_1642386C8E73A981) {
    if(!isDefined(_id_6EE5484560EC747C)) {
      continue;
    }
    if(_id_6EE5484560EC747C == data.attacker || _id_6EE5484560EC747C == data.victim) {
      continue;
    }
    if(!isDefined(_id_6EE5484560EC747C._id_D1D541D826231CAD)) {
      continue;
    }
    if(!isDefined(_id_6EE5484560EC747C._id_D1D541D826231CAD._id_CF433C13DD493F3F[data.victim.guid])) {
      continue;
    }
    if(gettime() / 1000.0 < _id_6EE5484560EC747C._id_D1D541D826231CAD._id_CF433C13DD493F3F[data.victim.guid] + 1.0)
      _id_55B08D6D71B41402(_id_6EE5484560EC747C, "kill_steal");
  }

  if(!isDefined(data.attacker._id_D1D541D826231CAD)) {
    return;
  }
  data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 = data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 + 1;

  if(_id_A1E1B35A0BD2F57C(data.attacker, "close_call") && gettime() / 1000.0 < data.attacker._id_D1D541D826231CAD.lastdamagedtime + 2.0 && data.attacker.health < 50) {
    if(randomfloat(1.0) < 0.5) {
      _id_55B08D6D71B41402(data.attacker, "close_call");
      return;
    }
  }

  if(scripts\engine\utility::string_starts_with(data.weaponfullstring, "throwingknife_mp"))
    _id_55B08D6D71B41402(data.attacker, "throwing_knife_kill");

  if(isDefined(data.attacker.vehicle) && data.meansofdeath == "MOD_CRUSH")
    _id_55B08D6D71B41402(data.attacker, "enemy_rammed");

  if(!_id_2669878CF5A1B6BC::isspreadweapon(data.objweapon) && scripts\cp_mp\utility\damage_utility::isheadshot(data.hitloc, data.meansofdeath, data.attacker))
    _id_55B08D6D71B41402(data.attacker, "headshot_kill");
  else if(data.objweapon issilenced())
    _id_55B08D6D71B41402(data.attacker, "stealth_kill");
  else if(data.meansofdeath == "MOD_MELEE")
    _id_55B08D6D71B41402(data.attacker, "melee_kill");

  if(isDefined(data.attacker.recentkillcount) && data.attacker.recentkillcount > 1) {
    if(data.attacker.recentkillcount == 2)
      _id_55B08D6D71B41402(data.attacker, "killed_enemy_double");
    else if(data.attacker.recentkillcount == 3)
      _id_55B08D6D71B41402(data.attacker, "killed_enemy_triple");
    else
      _id_55B08D6D71B41402(data.attacker, "killed_enemy_multi");
  }

  if(data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 == 5)
    _id_55B08D6D71B41402(data.attacker, "killed_enemy_5x");
  else if(data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 == 10)
    _id_55B08D6D71B41402(data.attacker, "killed_enemy_10x");
  else if(data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 == 15)
    _id_55B08D6D71B41402(data.attacker, "killed_enemy_15x");
  else if(data.attacker._id_D1D541D826231CAD._id_E759DA6EDF27A220 == 20)
    _id_55B08D6D71B41402(data.attacker, "killed_enemy_20x");
  else
    _id_55B08D6D71B41402(data.attacker, "killed_enemy");
}

_id_27FE46449778A3E3(winner) {
  if(isDefined(level._id_1642386C8E73A981)) {
    foreach(player in level._id_1642386C8E73A981) {
      if(!isDefined(player)) {
        continue;
      }
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == winner) {
        _id_55B08D6D71B41402(player, "round_won");
        continue;
      }

      _id_55B08D6D71B41402(player, "round_lost");
    }
  }
}

_id_967DE5F2484E51EF(player, _id_D8061F26B5ECA018) {
  wait 1.0;

  if(_id_D8061F26B5ECA018 == "uav")
    _id_55B08D6D71B41402(self, "activate_uav");
  else if(_id_D8061F26B5ECA018 == "scrambler_drone_guard")
    _id_55B08D6D71B41402(self, "activate_counter_uav");
  else if(_id_D8061F26B5ECA018 == "cruise_predator" || _id_D8061F26B5ECA018 == "chopper_gunner" || _id_D8061F26B5ECA018 == "gunship" || _id_D8061F26B5ECA018 == "pac_sentry")
    _id_55B08D6D71B41402(self, "activate_rided");
  else if(_id_D8061F26B5ECA018 == "precision_airstrike" || _id_D8061F26B5ECA018 == "toma_strike" || _id_D8061F26B5ECA018 == "directional_uav" || _id_D8061F26B5ECA018 == "fuel_airstrike" || _id_D8061F26B5ECA018 == "hover_jet" || _id_D8061F26B5ECA018 == "auto_drone" || _id_D8061F26B5ECA018 == "airdrop_escort")
    _id_55B08D6D71B41402(self, "activate_guided");
  else if(_id_D8061F26B5ECA018 == "assault_drone")
    _id_55B08D6D71B41402(self, "activate_drone");

  _id_55B08D6D71B41402(self, "killstreak_used");
}

_id_D0C66E5691FA4856(player, event) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  wait 2.0;
  _id_55B08D6D71B41402(player, event);
}

_id_556866C3C047A8B8(victim) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  self endon("death_or_disconnect");
  wait 0.5;
  _id_55B08D6D71B41402(self, "enemy_armor_depleted");
}

_id_0F0B105C339FB3E1(objweapon) {
  _id_CF4209C200F8BBF4 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("weapons", "getWeaponGroup", objweapon);
  return isDefined(_id_CF4209C200F8BBF4) && (_id_CF4209C200F8BBF4 == "weapon_sniper" || _id_CF4209C200F8BBF4 == "weapon_dmr");
}

_id_A81DF078CBB965A5() {
  self endon("game_ended");

  for(;;) {
    self waittill("post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    if(!isDefined(victim) || !isDefined(eattacker)) {
      continue;
    }
    if(!_id_7B50742A287D3CA1(eattacker) && !_id_7B50742A287D3CA1(victim)) {
      continue;
    }
    if(eattacker == victim) {
      continue;
    }
    _id_D69F8F4E2CBF2640 = isDefined(objweapon.basename) && objweapon.basename == "danger_circle_br";

    if(_id_D69F8F4E2CBF2640) {
      continue;
    }
    _id_F32CB8BE96D9C669 = distancesquared(victim.origin, eattacker.origin) > 250000;

    if(isPlayer(victim) && victim.health > 1) {
      if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH")
        thread _id_D0C66E5691FA4856(victim, "player_damaged_explosive");
      else if(victim.health < 30)
        thread _id_D0C66E5691FA4856(victim, "health_low");
      else if(_id_0F0B105C339FB3E1(objweapon) && istrue(_id_F32CB8BE96D9C669))
        thread _id_D0C66E5691FA4856(victim, "player_damaged_sniper");
      else
        thread _id_D0C66E5691FA4856(victim, "player_damaged");

      if(isDefined(victim._id_D1D541D826231CAD) && victim._id_D1D541D826231CAD._id_759862146A4569CB != 0.0)
        victim._id_D1D541D826231CAD._id_759862146A4569CB = gettime() / 1000.0;

      if(isDefined(victim._id_D1D541D826231CAD))
        victim._id_D1D541D826231CAD.lastdamagedtime = gettime() / 1000.0;
    }

    if(isPlayer(eattacker) && victim.health > 1) {
      if(isDefined(eattacker._id_D1D541D826231CAD))
        eattacker._id_D1D541D826231CAD._id_CF433C13DD493F3F[victim.guid] = gettime() / 1000.0;

      if(_id_0F0B105C339FB3E1(objweapon) && istrue(_id_F32CB8BE96D9C669)) {
        thread _id_D0C66E5691FA4856(eattacker, "enemy_damaged_sniper");
        continue;
      }

      thread _id_D0C66E5691FA4856(eattacker, "enemy_damaged");
    }
  }
}

_id_03ADDBB064480340() {
  self endon("game_ended");

  for(;;) {
    currenttime = gettime() / 1000.0;

    for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < level._id_1642386C8E73A981.size; _id_AC0E5B4AC96AA80E++) {
      if(!isPlayer(level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E])) {
        continue;
      }
      if(currenttime < level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E]._id_D1D541D826231CAD._id_FBCFC873987AE39E + 10) {
        continue;
      }
      if(level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E] issprinting()) {
        if(randomfloat(1.0) < 0.3) {
          _id_55B08D6D71B41402(level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E], "sprint");
          continue;
        }

        _id_CD101CA0E17CFD60(level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E], "sprint");
      }
    }

    wait 0.3;
  }
}

_id_EB8660DBFA7117B5() {
  self endon("disconnect");
  self endon("remove_talking_gun");

  for(;;) {
    self waittill("weapon_fired");
    firetime = weaponfiretime(self.currentweapon.basename);
    time = gettime() / 1000.0;

    if(isDefined(self._id_D1D541D826231CAD)) {
      if(isDefined(self._id_D1D541D826231CAD) && self._id_D1D541D826231CAD._id_759862146A4569CB != 0.0)
        self._id_D1D541D826231CAD._id_759862146A4569CB = gettime() / 1000.0;

      if(self._id_D1D541D826231CAD._id_076665EAAAABDA31 == 0) {
        self._id_D1D541D826231CAD._id_076665EAAAABDA31 = time;
        self._id_D1D541D826231CAD._id_B303CB73DD6407F5 = time + firetime + 0.1;
      } else if(time < self._id_D1D541D826231CAD._id_B303CB73DD6407F5) {
        if(time > self._id_D1D541D826231CAD._id_076665EAAAABDA31 + 1.5) {
          _id_55B08D6D71B41402(self, "war_cry");
          self._id_D1D541D826231CAD._id_076665EAAAABDA31 = 0;
        } else
          self._id_D1D541D826231CAD._id_B303CB73DD6407F5 = time + firetime + 0.1;
      } else
        self._id_D1D541D826231CAD._id_076665EAAAABDA31 = 0;
    }

    if(self getcurrentweaponclipammo() == 0 && self getweaponammostock(self.currentweapon) == 0)
      _id_55B08D6D71B41402(self, "player_zero_ammo");
  }
}

_id_0CD39869120C7218() {
  self endon("disconnect");
  self endon("remove_talking_gun");

  for(;;) {
    self waittill("weapon_inspect");
    _id_55B08D6D71B41402(self, "weapon_inspect");
  }
}

_id_26ACD7206CA70734(_id_D27680FF86693F5C) {
  _id_51BA34154A645B70 = isDefined(self._id_47BDE44B1ACEC603);
  _id_1AB543205027C0A8 = isDefined(_id_D27680FF86693F5C.eattacker) && _id_D27680FF86693F5C.eattacker scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(_id_D27680FF86693F5C.eattacker.owner) && isPlayer(_id_D27680FF86693F5C.eattacker.owner);

  if((!isDefined(_id_D27680FF86693F5C.eattacker) || !isPlayer(_id_D27680FF86693F5C.eattacker)) && !_id_1AB543205027C0A8) {
    return;
  }
  if(_id_51BA34154A645B70)
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "dmz_boss_kill");
  else if(_id_A1E1B35A0BD2F57C(_id_D27680FF86693F5C.eattacker, "close_call") && gettime() / 1000.0 < _id_D27680FF86693F5C.eattacker._id_D1D541D826231CAD.lastdamagedtime + 2.0 && _id_D27680FF86693F5C.eattacker.health < 50) {
    if(randomfloat(1.0) < 0.5) {
      _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "close_call");
      return;
    }
  } else if(_id_1AB543205027C0A8 && _id_D27680FF86693F5C.smeansofdeath == "MOD_CRUSH")
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker.owner, "enemy_rammed");
  else if(!_id_2669878CF5A1B6BC::isspreadweapon(_id_D27680FF86693F5C.sweapon) && scripts\cp_mp\utility\damage_utility::isheadshot(_id_D27680FF86693F5C.shitloc, _id_D27680FF86693F5C.smeansofdeath, _id_D27680FF86693F5C.eattacker))
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "headshot_kill");
  else if(_id_D27680FF86693F5C.sweapon issilenced())
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "stealth_kill");
  else if(_id_D27680FF86693F5C.smeansofdeath == "MOD_MELEE")
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "melee_kill");
  else
    _id_55B08D6D71B41402(_id_D27680FF86693F5C.eattacker, "player_killed_agent");
}

_id_AEA35499F76041BB() {
  self endon("death_or_disconnect");
  self endon("remove_talking_gun");
  self._id_D1D541D826231CAD._id_FBCFC873987AE39E = gettime() / 1000.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "gameFlag") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "gameFlag")]]("prematch_done")) {
    level waittill("prematch_done");
    wait 5;
  }

  self._id_D1D541D826231CAD._id_FBCFC873987AE39E = gettime() / 1000.0;
  _id_55B08D6D71B41402(self, "deploy");
}

_id_D8239F9D7164D68E(_id_0D2346943E5CB1F5) {
  if(!isDefined(_id_0D2346943E5CB1F5))
    return 0;

  _id_A1C804FFA2416774 = undefined;

  if(isweapon(_id_0D2346943E5CB1F5) && !isnullweapon(_id_0D2346943E5CB1F5))
    _id_A1C804FFA2416774 = _id_0D2346943E5CB1F5;
  else if(isDefined(_id_0D2346943E5CB1F5.objweapon)) {
    if(isnullweapon(_id_0D2346943E5CB1F5.objweapon))
      return 0;

    _id_A1C804FFA2416774 = _id_0D2346943E5CB1F5.objweapon;
  } else if(isDefined(_id_0D2346943E5CB1F5.classname) && _id_0D2346943E5CB1F5.classname == "scriptable") {
    if(!isDefined(_id_0D2346943E5CB1F5.customweaponname))
      return 0;

    _id_A1C804FFA2416774 = _id_0D2346943E5CB1F5.customweaponname;
  } else
    return 0;

  attachments = getweaponattachments(_id_A1C804FFA2416774);

  foreach(attachment in attachments) {
    perks = _id_2669878CF5A1B6BC::attachmentperkmap(_id_A1C804FFA2416774, attachment);

    foreach(perk in perks) {
      if(scripts\engine\utility::string_starts_with(perk, "specialty_talkinggun"))
        return 1;
    }
  }

  return 0;
}

_id_7FD5A6ABCD15E5BA() {
  self endon("game_ended");

  for(;;) {
    level waittill("enter_vehicle", vehicle, player);
    _id_55B08D6D71B41402(player, "vehicle_enter");
  }
}

_id_7143E9D45CFF1D4C() {
  self endon("game_ended");

  for(;;) {
    level waittill("exit_vehicle", vehicle, player);
    wait 0.1;
    _id_55B08D6D71B41402(player, "vehicle_exit");
  }
}

_id_572B61079927196B() {
  for(;;) {
    level waittill("br_ending_start", winners);

    foreach(player in level._id_1642386C8E73A981) {
      if(isDefined(winners) && scripts\engine\utility::array_contains(winners, player))
        _id_55B08D6D71B41402(player, "round_won");

      _id_0F70B3CE9138E10B(player);
    }
  }
}

_id_0EF6885141252869(player, grenade) {
  issuper = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("weapons", "isSuperWeapon", grenade.weapon_object);

  if(issuper)
    _id_55B08D6D71B41402(player, "equipment_deployed");
  else if(_id_7EF95BBA57DC4B82::isequipmentlethal(grenade.equipmentref)) {
    if(grenade.equipmentref != "equip_throwing_knife")
      _id_55B08D6D71B41402(player, "grenade_lethal_used");
  } else if(_id_7EF95BBA57DC4B82::isequipmenttactical(grenade.equipmentref)) {
    switch (grenade.equipmentref) {
      case "equip_binoculars":
      case "equip_hb_sensor":
      case "equip_geigercounter":
      case "equip_sonar_pulse":
        break;
      default:
        _id_55B08D6D71B41402(player, "grenade_tactical_used");
    }
  }
}

_id_2CC0D17B7E641E00(player, _id_DE1FD66F1B22F6A9) {
  _id_0CEDEFD3160BF7CC = !isDefined(player._id_D1D541D826231CAD) || player._id_D1D541D826231CAD._id_6A8D989A494B74C4;

  if(!isDefined(level._id_1642386C8E73A981))
    level._id_1642386C8E73A981 = [];

  if(!isDefined(player._id_D1D541D826231CAD))
    player _id_B04504FFD83192E1();

  player._id_D1D541D826231CAD._id_DE1FD66F1B22F6A9 = _id_DE1FD66F1B22F6A9;
  player._id_D1D541D826231CAD.active = 1;
  player._id_D1D541D826231CAD._id_6A8D989A494B74C4 = 0;
  level._id_1642386C8E73A981[level._id_1642386C8E73A981.size] = player;

  if(!isDefined(level._id_3F30D667FF99B732)) {
    level._id_3F30D667FF99B732 = 1;
    level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_death", ::_id_14C5B1A6F5A9F37C);
    _id_15DE7DC4D21F1DA3::_id_BA46CF958AE0CBDA(::_id_ABA04688789CE643);
    _id_15DE7DC4D21F1DA3::_id_39027364B9C16127(::_id_ABA04688789CE643);
    level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("on_ai_killed", ::_id_26ACD7206CA70734);
    level thread _id_A81DF078CBB965A5();
    level thread _id_03ADDBB064480340();
    level thread _id_7FD5A6ABCD15E5BA();
    level thread _id_7143E9D45CFF1D4C();

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_436ADD9DE781CDFB::_id_3A363AE38F309166(::_id_C5F05871BA7C3AA3);
      level thread _id_572B61079927196B();
    }
  }

  player thread _id_EB8660DBFA7117B5();
  player thread _id_0CD39869120C7218();
  weaponname = getcompleteweaponname(player.currentweapon);

  if(isDefined(player.tookweaponfrom) && isDefined(player.tookweaponfrom[weaponname])) {
    if(player.tookweaponfrom[weaponname] == player)
      _id_55B08D6D71B41402(self, "reunited_deploy");
    else
      _id_55B08D6D71B41402(self, "stranger_deploy");
  } else if(_id_0CEDEFD3160BF7CC)
    player thread _id_AEA35499F76041BB();

  if(_id_DE1FD66F1B22F6A9 != "doom")
    player setclientomnvar("ui_talkinggun_faceid", _id_DE1FD66F1B22F6A9);
}

_id_0F70B3CE9138E10B(player) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(player._id_D1D541D826231CAD)) {
    return;
  }
  player notify("remove_talking_gun");
  player._id_D1D541D826231CAD.active = 0;

  for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < level._id_1642386C8E73A981.size; _id_AC0E5B4AC96AA80E++) {
    if(level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E] == player) {
      _id_321CFFBB6B6BAA79 = level._id_1642386C8E73A981.size - 1;
      level._id_1642386C8E73A981[_id_AC0E5B4AC96AA80E] = level._id_1642386C8E73A981[_id_321CFFBB6B6BAA79];
      level._id_1642386C8E73A981[_id_321CFFBB6B6BAA79] = undefined;
      break;
    }
  }

  player setclientomnvar("ui_talkinggun_faceid", "none");
}

_id_DA3D9F34D24AC85A() {
  _id_0F70B3CE9138E10B(self);
}

_id_096F59FEFD781E47() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_2CC0D17B7E641E00(self, "announcer");
}

_id_096F5AFEFD78207A() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_2CC0D17B7E641E00(self, "robot");
}

_id_096F5BFEFD7822AD() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_2CC0D17B7E641E00(self, "hypeman");
}

_id_096F54FEFD781348() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_2CC0D17B7E641E00(self, "blackcell");
}

_id_FC6E0B02ABB995CB() {
  _id_2CC0D17B7E641E00(self, "announcer");
}

_id_73E4AE4F932E9F30() {
  _id_2CC0D17B7E641E00(self, "robot");
}

_id_CC0FDDFE26B772A7() {
  _id_2CC0D17B7E641E00(self, "blackcell");
}

_id_FC09644394BF843F() {
  _id_2CC0D17B7E641E00(self, "npc");
}

_id_44D73A43CA35CBCC() {
  _id_2CC0D17B7E641E00(self, "cat");
}

_id_514A7643D295A3A2() {
  _id_2CC0D17B7E641E00(self, "dog");
}

_id_62E0BCEF615A8D1D() {
  _id_2CC0D17B7E641E00(self, "doom");
  _id_5275B9018A6575AA = "ui_doomscreen_faceid";
  _id_2FA456BB8A94B7A1("contract_complete", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("loot_found", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("obj_capture", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killstreak_used", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("round_won", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("knocked_down_enemy", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("self_apply", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("war_cry", 1, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("highalert_spotted", 2, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("teammate_death_revived_me", 2, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("round_lost", 2, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("sprint", 2, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("player_knocked_down", 3, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("highalert_spotted_left", 7, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("highalert_spotted_right", 8, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killed_enemy_multi", 9, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killed_enemy_5x", 9, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killed_enemy_10x", 9, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killed_enemy_15x", 9, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("killed_enemy_20x", 9, _id_5275B9018A6575AA);
  _id_2FA456BB8A94B7A1("nuke_earned", 9, _id_5275B9018A6575AA);
}

_id_ADE69726300553AC() {
  _id_0F70B3CE9138E10B(self);

  if(isDefined(self))
    self notify("remove_doom_screen");
}