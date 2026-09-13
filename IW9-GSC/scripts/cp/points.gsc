/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\points.gsc
***********************************************/

_id_8E9B2E8BA0328E3C() {
  level._id_97E29F66F7229F48 = ::_id_0366980B6A8796AE;
}

givestreakpointswithtext(event, objweapon, _id_91185FF4A2E16A72) {
  if(isDefined(level.ignorescoring)) {
    return;
  }
  if(isDefined(_id_91185FF4A2E16A72))
    points = _id_91185FF4A2E16A72;
  else
    points = _id_187A04151C40FB72::getscoreinfovalue(event);

  points = modifyunifiedpoints(event, points, objweapon);
  displayscoreeventpoints(points, event);
}

_id_0366980B6A8796AE(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F) {
  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(event)) {
      if(isnumber(level.gameendtime)) {
        if(event[1] <= level.gameendtime) {
          isvalidevent = 1;
          event = event[0];
        }
      }
    } else if(isDefined(event))
      isvalidevent = 1;

    if(!isvalidevent)
      return;
  } else if(isarray(event))
    event = event[0];

  if(istrue(self.pers["ignoreWeaponKillXP"]))
    objweapon = undefined;

  showsplash = _id_187A04151C40FB72::_id_E3DFD7E570749681(event);

  if(showsplash)
    thread _id_293BC33BD79CABD1::killeventtextpopup(event, 1);

  if(_id_187A04151C40FB72::_id_034294184E90B96C(event))
    scripts\cp\cp_awards::givemidmatchaward(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F);
  else
    giveunifiedpoints(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F);
}

giveunifiedpoints(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23, _id_7EC7671A1E0C788F) {
  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(event)) {
      if(isnumber(level.gameendtime)) {
        if(event[1] <= level.gameendtime) {
          isvalidevent = 1;
          event = event[0];
        }
      }
    } else if(isDefined(event))
      isvalidevent = 1;

    if(!isvalidevent)
      return;
  } else if(isarray(event))
    event = event[0];

  if(istrue(self.pers["ignoreWeaponKillXP"]))
    objweapon = undefined;

  if(!_func_D03495FE6418377B(event))
    event = _func_1823FF50BB28148D(event);

  if(istrue(level.ignorescoring)) {
    _id_587EB1F4E11A34F3 = 1;
    _id_E7A7E20EC68138E3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\cp\utility::gameflag("prematch_done");

    if(_id_E7A7E20EC68138E3)
      _id_587EB1F4E11A34F3 = 0;

    if(_id_587EB1F4E11A34F3)
      return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(_id_91185FF4A2E16A72))
    points = _id_91185FF4A2E16A72;
  else {
    points = _id_187A04151C40FB72::getscoreinfovalue(event);

    if(!isDefined(points))
      points = 0;
  }

  points = modifyunifiedpoints(event, points, objweapon);

  if(isDefined(objweapon)) {
    weaponobj = _id_74502A9E0EF1F19C::mapweapon(objweapon);
    sweapon = getcompleteweaponname(weaponobj);
  }

  if(isDefined(streakinfo))
    streakinfo.score = streakinfo.score + points;

  _id_C9DB681C20FEFFE2 = event == "stat_8FCF8BBD78A0502E";
  _id_CE5497EF5AA384F5 = event == "stat_EF9582D72160F199";
  _id_6A97EBC2E0F33B5F = 1.0;

  if(_id_CE5497EF5AA384F5 || _id_C9DB681C20FEFFE2) {}

  _id_798ADA8B24BA4887 = 1;

  if(isDefined(_id_4B5A99C16ABFDFB1) && _id_4B5A99C16ABFDFB1 < 0)
    _id_798ADA8B24BA4887 = 0;

  if(_id_798ADA8B24BA4887) {
    xp = _id_4B5A99C16ABFDFB1;

    if(!isDefined(xp)) {
      if(isDefined(_id_91185FF4A2E16A72))
        xp = points;
      else
        xp = _id_187A04151C40FB72::_id_D06C3CBB904AE29B(event);
    }

    xp = scripts\engine\utility::_id_53C4C53197386572(xp, 0);

    if(_id_CE5497EF5AA384F5) {
      if(isDefined(objweapon)) {
        _id_009BCADACC6ECAD1 = objweapon hasattachment("gunperk_xp") || scripts\cp\utility::_hasperk("specialty_gunperk_xp");

        if(_id_009BCADACC6ECAD1)
          xp = xp + 20;
      }
    }

    _id_E9F5DFEE6649F67A = isDefined(self.pers) && istrue(self.pers["ignoreWeaponKillXP"]);
    thread _id_187A04151C40FB72::giverankxp(event, xp, objweapon, undefined, undefined, _id_E9F5DFEE6649F67A);
  }

  thread _id_293BC33BD79CABD1::killeventtextpopup(event, 0);

  if(istrue(level._id_1E17E3480B1D264D) && isDefined(level._id_9C1E3C18B99409E9) && points > 0 && event != "br_kioskBuy")
    self[[level._id_9C1E3C18B99409E9]](points);
}

give_munition_currency(amount) {
  _id_8334742FE1363A27 = _id_3BCAA2CBAF54ABDD::get_player_munition_currency();
  amount = scripts\cp\cp_gamescore::round_up_to_nearest(amount, 5);

  if(isDefined(self.totalmuncurrencyearned) && isDefined(self.maxmuncurrencycap)) {
    if(self.totalmuncurrencyearned > self.maxmuncurrencycap)
      amount = 0;
    else
      self.totalmuncurrencyearned = self.totalmuncurrencyearned + amount;
  }

  _id_B4187EC006E2D1E2 = _id_3BCAA2CBAF54ABDD::get_player_max_currency();
  _id_98AFD1CE36F4905A = _id_8334742FE1363A27 + amount;
  _id_98AFD1CE36F4905A = min(_id_98AFD1CE36F4905A, _id_B4187EC006E2D1E2);
  _id_3BCAA2CBAF54ABDD::set_player_munition_currency(_id_98AFD1CE36F4905A);
}

modifyunifiedpoints(event, points, objweapon) {
  if(event == "stat_7F6308BE8AB37FC0")
    return 0;

  _id_A485D3A2171216FE = 0;

  if(isDefined(objweapon)) {
    if(event == "kill" && objweapon hasattachment("gunperk_xp"))
      _id_A485D3A2171216FE = _id_A485D3A2171216FE + 20;
  }

  points = points + _id_A485D3A2171216FE;

  if(isDefined(level.modifyunifiedpointscallback))
    points = [[level.modifyunifiedpointscallback]](points, event, self, objweapon);

  return int(points);
}

displayscoreeventpoints(points, event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }
  if(scripts\cp\utility::_id_93D685AC42F15C61())
    return;
  else if(isDefined(self.totalxpearned) && isDefined(self.maxxpcap)) {
    if(self.totalxpearned >= self.maxxpcap)
      return;
  }

  if(!isDefined(level.skippointdisplayxp)) {
    _id_DC03362B77C5058D = 0;

    if(scripts\cp\utility::issimultaneouskillenabled())
      _id_DC03362B77C5058D = event == "stat_EF9582D72160F199";

    thread _id_187A04151C40FB72::scorepointspopup(points, _id_DC03362B77C5058D);
  }
}

isnokillstreakprogressweapon(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  if(isstring(objweapon))
    objweapon = makeweapon(objweapon);

  switch (objweapon.basename) {
    case "bradley_tow_proj_mp":
    case "iw9_tur_light_tank_mp":
    case "iw9_tur_apc_russian_mp":
      return 1;
  }

  return 0;
}

isforcekillstreakprogressweapon(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  if(isstring(objweapon))
    objweapon = makeweapon(objweapon);

  switch (objweapon.basename) {
    case "iw8_green_beam_mp":
    case "iw8_spotter_scope_mp":
    case "deploy_juggernaut_mp":
    case "deploy_airdrop_mp":
      return 1;
  }

  return 0;
}

calculatematchbonus(_id_E8F096C8BFC6C153, _id_7DB9C25FC83CDED3) {
  _id_ACD7DFF57C94292A = 250;
  _id_F5C150745DB5BF66 = _id_7DB9C25FC83CDED3 / 60;
  _id_030FB07C2CA202FF = _id_187A04151C40FB72::_id_6D17F84162F0D8F0(_id_E8F096C8BFC6C153);
  _id_C1495B0F54D34DD6 = _id_187A04151C40FB72::getgametypexpmultiplier();

  if(scripts\cp\utility::_id_138028CA2B958511()) {
    _id_479FF69364253676 = getdvarint("dvar_7F9D5CD3CA6245A4", 4);
    _id_C1495B0F54D34DD6 = _id_C1495B0F54D34DD6 * _id_479FF69364253676;
  }

  matchbonus = int(_id_ACD7DFF57C94292A * _id_030FB07C2CA202FF * _id_C1495B0F54D34DD6);
  return matchbonus;
}

updatematchbonusscores(winner) {
  _id_7DB9C25FC83CDED3 = _id_467F0FDFDD155A45::get_play_time() / 1000;
  _id_7DB9C25FC83CDED3 = min(_id_7DB9C25FC83CDED3, 1200);

  if(level.teambased) {
    if(winner != "tie")
      setwinningteam(winner);

    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        continue;
      }
      if(istrue(level.hostforcedend) && player ishost()) {
        continue;
      }
      if(!istrue(player.pers["hasDoneAnyCombat"])) {
        continue;
      }
      if(winner == "tie") {
        _id_663572CC85C027C6 = player calculatematchbonus("tie", _id_7DB9C25FC83CDED3);
        player thread givematchbonus("tie", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == winner) {
        _id_663572CC85C027C6 = player calculatematchbonus("win", _id_7DB9C25FC83CDED3);
        player thread givematchbonus("win", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] != winner) {
        _id_663572CC85C027C6 = player calculatematchbonus("loss", _id_7DB9C25FC83CDED3);
        player thread givematchbonus("loss", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      }

      player calculateweaponmatchbonus(_id_7DB9C25FC83CDED3);
    }
  } else {
    _id_DBBFD0E462584B9B = "win";
    _id_0B1EFC8448D0E3B3 = "loss";

    if(!isDefined(winner)) {
      _id_DBBFD0E462584B9B = "tie";
      _id_0B1EFC8448D0E3B3 = "tie";
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        continue;
      }
      if(!istrue(player.pers["hasDoneAnyCombat"])) {
        continue;
      }
      _id_7C6311737CB7A0B2 = 0;

      for(_id_3EB36C9F2F1A8E92 = 0; _id_3EB36C9F2F1A8E92 < min(level.placement["all"].size, 3); _id_3EB36C9F2F1A8E92++) {
        if(level.placement["all"][_id_3EB36C9F2F1A8E92] != player) {
          continue;
        }
        _id_7C6311737CB7A0B2 = 1;
      }

      if(_id_7C6311737CB7A0B2) {
        _id_663572CC85C027C6 = player calculatematchbonus(_id_DBBFD0E462584B9B, _id_7DB9C25FC83CDED3);
        player thread givematchbonus("win", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else {
        _id_663572CC85C027C6 = player calculatematchbonus(_id_0B1EFC8448D0E3B3, _id_7DB9C25FC83CDED3);
        player thread givematchbonus("loss", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      }

      player calculateweaponmatchbonus(_id_7DB9C25FC83CDED3);
    }
  }
}

givematchbonus(_id_69CB334822EBE431, score) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  _id_187A04151C40FB72::giverankxp(_func_1823FF50BB28148D(_id_69CB334822EBE431), score);

  if(_id_69CB334822EBE431 == "win")
    thread _id_0366980B6A8796AE("stat_FE606101A22E3E79");
  else
    thread _id_0366980B6A8796AE("stat_DC98011722824BD8");
}

calculateweaponmatchbonus(_id_7DB9C25FC83CDED3) {
  _id_7DB9C25FC83CDED3 = 600;

  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }
  _id_011865501DE9083D = scripts\cp\cp_weaponrank::getgametypekillsperhouravg() / 60;
  _id_F5C150745DB5BF66 = _id_7DB9C25FC83CDED3 / 60;
  _id_162A122A3E3CCE1A = int(_id_011865501DE9083D * _id_F5C150745DB5BF66);
  _id_63F737A3357B557E = int(50.0);
  _id_9BF173C2AA7EB966 = _id_63F737A3357B557E * 1;
  _id_4B7CF89ACAABDCAC = int(_id_162A122A3E3CCE1A * _id_9BF173C2AA7EB966);
  _id_4B7CF89ACAABDCAC = _id_4B7CF89ACAABDCAC - int(self.pers["weaponMatchBonusKills"] * _id_9BF173C2AA7EB966);

  if(_id_4B7CF89ACAABDCAC <= 0) {
    return;
  }
  _id_CE22C9B0708CAF7E = 0;

  foreach(data in self.pers["killsPerWeapon"])
  _id_CE22C9B0708CAF7E = _id_CE22C9B0708CAF7E + (_id_162A122A3E3CCE1A - data.killcount);

  if(_id_CE22C9B0708CAF7E <= 0) {
    return;
  }
  foreach(_id_5DC27A5BF459C504, data in self.pers["killsPerWeapon"]) {
    _id_6C8D21B2E54B2478 = (_id_162A122A3E3CCE1A - data.killcount) / _id_CE22C9B0708CAF7E;
    _id_C01EE836EF4A7E4A = int(_id_4B7CF89ACAABDCAC * _id_6C8D21B2E54B2478);
    _id_187A04151C40FB72::incrankxp(0, data, _id_C01EE836EF4A7E4A, _func_1823FF50BB28148D("WeaponMatchBonus"));

    foreach(_id_10CA4BF7AA9C3ED2, _id_5842E592DDCEF384 in self.pers["weaponStats"]) {
      if(issubstr(_id_10CA4BF7AA9C3ED2, _id_5DC27A5BF459C504)) {
        if(isDefined(_id_5842E592DDCEF384.stats["kills"]) && data.killcount > 0) {
          _id_C40AA4F6F34FFDC4 = _id_6C8D21B2E54B2478 * (_id_5842E592DDCEF384.stats["kills"] / data.killcount);
          _id_C01EE836EF4A7E4A = int(_id_4B7CF89ACAABDCAC * _id_C40AA4F6F34FFDC4);

          if(isDefined(_id_5842E592DDCEF384.stats["xp_earned"]))
            _id_5842E592DDCEF384.stats["xp_earned"] = _id_5842E592DDCEF384.stats["xp_earned"] + _id_C01EE836EF4A7E4A;
          else
            _id_5842E592DDCEF384.stats["xp_earned"] = _id_C01EE836EF4A7E4A;
        }
      }
    }
  }
}

sethasdonecombat(player, _id_0D6FB9FB787EB9CF) {
  if(_id_0D6FB9FB787EB9CF && !istrue(player.hasdonecombat)) {}

  player.hasdonecombat = _id_0D6FB9FB787EB9CF;

  if(_id_0D6FB9FB787EB9CF && !istrue(player.pers["hasDoneAnyCombat"]))
    player.pers["hasDoneAnyCombat"] = 1;
}