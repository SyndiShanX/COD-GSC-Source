/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\points.gsc
***********************************************/

_id_8E9B2E8BA0328E3C() {
  level._id_97E29F66F7229F48 = ::_id_0366980B6A8796AE;
}

givestreakpointswithtext(event, objweapon, _id_91185FF4A2E16A72) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(isDefined(_id_91185FF4A2E16A72))
    points = _id_91185FF4A2E16A72;
  else
    points = scripts\mp\rank::getscoreinfovalue(event);

  points = modifyunifiedpoints(event, points, objweapon);
  scripts\mp\killstreaks\killstreaks::givestreakpoints(event, points);
  displayscoreeventpoints(points, event);
}

givexpwithtext(event, _id_91185FF4A2E16A72) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  points = undefined;

  if(isDefined(_id_91185FF4A2E16A72))
    points = _id_91185FF4A2E16A72;
  else
    points = scripts\mp\rank::getscoreinfovalue(event);

  thread scripts\mp\rank::giverankxp(event, points);
  thread scripts\mp\rank::scoreeventpopup(event);
}

_id_0366980B6A8796AE(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23, _id_7EC7671A1E0C788F, _id_339E50A026E4674F) {
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

  if(getdvarint("dvar_28825C0C0B691B0D", 0) == 1) {
    _id_6EEC53A074D33065 = _func_0F28FD66285FA2C9(event);
    _id_69A6FCF999F750BE = _func_2EF675C13CA1C4AF("dvar_01E443AAA4347A9C", _id_6EEC53A074D33065);

    if(getdvarint(_id_69A6FCF999F750BE, 0) == 1)
      return;
  }

  showsplash = scripts\mp\rank::_id_E3DFD7E570749681(event);

  if(showsplash)
    thread scripts\mp\events::killeventtextpopup(event, 1);

  if(scripts\mp\rank::_id_034294184E90B96C(event))
    scripts\mp\awards::givemidmatchaward(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23, _id_7EC7671A1E0C788F);
  else
    giveunifiedpoints(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23, _id_7EC7671A1E0C788F, _id_339E50A026E4674F);

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "champion")
    thread _id_303FD53078A244F1::_id_0366980B6A8796AE(event);
}

_id_E3E3E81453FD788B(event, objweapon, victim) {
  if(!isDefined(level._id_FF4509FFA6E8ACAE)) {
    level._id_FF4509FFA6E8ACAE = spawnStruct();
    level._id_FF4509FFA6E8ACAE._id_E62CEEEE8B598809 = 1;
  }

  _id_0366980B6A8796AE(event, objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, level._id_FF4509FFA6E8ACAE);
}

giveunifiedpoints(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F, _id_339E50A026E4674F) {
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

  if(!_func_D03495FE6418377B(event))
    event = _func_1823FF50BB28148D(event);

  if(istrue(level.ignorescoring)) {
    _id_587EB1F4E11A34F3 = 1;
    _id_E7A7E20EC68138E3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done");

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
    points = scripts\mp\rank::getscoreinfovalue(event);

    if(level.mapname != "mp_firingrange") {}

    if(!isDefined(points))
      points = 0;
  }

  points = modifyunifiedpoints(event, points, objweapon);
  scripts\mp\gamescore::giveplayerscore(event, points, victim, _id_7EC7671A1E0C788F);

  if(isDefined(objweapon)) {
    weaponobj = scripts\mp\utility\weapon::mapweapon(objweapon);
    sweapon = getcompleteweaponname(weaponobj);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, points, "total_score_earned");
  }

  if(isDefined(streakinfo))
    streakinfo.score = streakinfo.score + points;

  _id_C9DB681C20FEFFE2 = event == "stat_8FCF8BBD78A0502E";
  _id_CE5497EF5AA384F5 = event == "stat_EF9582D72160F199";

  if(_id_72886DAC59580765(self, objweapon, event, _id_7EC7671A1E0C788F, _id_F459A13A227B8DE6, _id_AD8C6C5CC50AF10B))
    scripts\mp\killstreaks\killstreaks::givestreakpoints(event, 1, points);

  _id_6A97EBC2E0F33B5F = 1.0;

  if(_id_CE5497EF5AA384F5 || _id_C9DB681C20FEFFE2)
    _id_6A97EBC2E0F33B5F = _id_FA5F24DF7C838FE0(_id_6A97EBC2E0F33B5F);

  if(isDefined(level._id_5DFD73C97BF5D03D))
    [[level._id_5DFD73C97BF5D03D]](self, victim, event, points);

  scripts\mp\supers::givesuperpoints(points, event, undefined, _id_6A97EBC2E0F33B5F);
  _id_798ADA8B24BA4887 = 1;

  if(isDefined(_id_4B5A99C16ABFDFB1) && _id_4B5A99C16ABFDFB1 < 0)
    _id_798ADA8B24BA4887 = 0;

  if(_id_798ADA8B24BA4887) {
    xp = _id_4B5A99C16ABFDFB1;

    if(!isDefined(xp)) {
      if(isDefined(_id_91185FF4A2E16A72))
        xp = points;
      else
        xp = scripts\mp\rank::_id_D06C3CBB904AE29B(event);
    }

    xp = scripts\engine\utility::_id_53C4C53197386572(xp, 0);

    if(_id_CE5497EF5AA384F5) {
      _id_009BCADACC6ECAD1 = isDefined(objweapon) && objweapon hasattachment("gunperk_xp") || scripts\mp\utility\perk::_hasperk("specialty_gunperk_xp");

      if(_id_009BCADACC6ECAD1)
        xp = xp + 20;
    }

    thread scripts\mp\rank::giverankxp(event, xp, objweapon, undefined, undefined, _id_339E50A026E4674F);
  }

  thread scripts\mp\events::killeventtextpopup(event, 0);

  if(istrue(level._id_1E17E3480B1D264D) && isDefined(level._id_9C1E3C18B99409E9) && points > 0 && event != "br_kioskBuy")
    self[[level._id_9C1E3C18B99409E9]](points);

  if(istrue(level._id_606EB45E074FF204)) {
    if(!isDefined(self._id_4C6852D3C7765D04))
      self._id_4C6852D3C7765D04 = 0;

    if(!isDefined(points))
      points = 0;

    self._id_4C6852D3C7765D04 = self._id_4C6852D3C7765D04 + points;
    scripts\mp\perks\perks::_id_2CB1405F41491297(points);
    scripts\mp\perks\perks::_id_F2DBAB6F947771F2();
  } else if(_id_55E418C5CC946593::_id_C0D385A09D173A36())
    _id_55E418C5CC946593::onplayerscore();
}

_id_72886DAC59580765(_id_127DAB70C06A79E6, objweapon, event, _id_7EC7671A1E0C788F, _id_F459A13A227B8DE6, _id_AD8C6C5CC50AF10B) {
  if(isagent(_id_127DAB70C06A79E6))
    return 0;

  _id_CE5497EF5AA384F5 = event == "stat_EF9582D72160F199";
  iskillstreakkillevent = isDefined(_id_7EC7671A1E0C788F) && istrue(_id_7EC7671A1E0C788F._id_E0BADEC2B1517CA3);
  _id_4057C6CCC0529D32 = _id_127DAB70C06A79E6 scripts\mp\utility\killstreak::isjuggernaut();
  _id_E0BADEC2B1517CA3 = _id_4057C6CCC0529D32 || iskillstreakkillevent || isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon);
  _id_CADDF81C02734FA0 = _id_CADDF81C02734FA0(objweapon);
  _id_1ABBD3B2B53279A5 = _id_127DAB70C06A79E6 scripts\mp\utility\perk::_hasperk("specialty_strategist");
  _id_1F79C5EB226F51E2 = _id_423A6AC43D977BB6();

  if(istrue(_id_1F79C5EB226F51E2))
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  if(_id_E0BADEC2B1517CA3 && !scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks"))
    _id_127DAB70C06A79E6.pers["canKillChain"] = undefined;

  if(!_id_127DAB70C06A79E6 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(istrue(_id_AD8C6C5CC50AF10B))
    return 0;

  if(isDefined(objweapon) && !_id_CADDF81C02734FA0)
    return 0;

  if(_id_E0BADEC2B1517CA3) {
    _id_DF795729DADCD508 = istrue(_id_127DAB70C06A79E6.pers["canKillChain"]);

    if(!_id_DF795729DADCD508 || _id_DF795729DADCD508 && !istrue(_id_F459A13A227B8DE6))
      return 0;
  }

  if(!_id_CE5497EF5AA384F5 && !_id_1ABBD3B2B53279A5)
    return 0;

  return 1;
}

modifyunifiedpoints(event, points, objweapon) {
  if(event == "stat_7F6308BE8AB37FC0")
    return 0;

  _id_A485D3A2171216FE = 0;
  points = points + _id_A485D3A2171216FE;

  if(isDefined(level.modifyunifiedpointscallback))
    points = [[level.modifyunifiedpointscallback]](points, event, self, objweapon);

  return int(points);
}

displayscoreeventpoints(points, event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }
  if(level.codcasterenabled) {
    foreach(player in level.players) {
      if(player _meth_8420670EAFC8D391()) {
        _id_13C5603D4BEEA2FC = player getspectatingplayer();

        if(isDefined(_id_13C5603D4BEEA2FC)) {
          _id_917B3708F1E070D9 = _id_13C5603D4BEEA2FC getentitynumber();
          clientnum = self getentitynumber();

          if(_id_917B3708F1E070D9 == clientnum) {
            player thread scripts\mp\rank::scorepointspopup(points);
            player thread scripts\mp\rank::scoreeventpopup(event);
          }
        }
      }
    }
  }

  if(!istrue(level._id_BB8596FB319EB83E)) {
    _id_DC03362B77C5058D = 0;

    if(scripts\mp\utility\game::issimultaneouskillenabled())
      _id_DC03362B77C5058D = event == "stat_EF9582D72160F199";

    thread scripts\mp\rank::scorepointspopup(points, _id_DC03362B77C5058D);
  }
}

_id_CADDF81C02734FA0(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  return !scripts\mp\utility\weapon::isvehicleweapon(objweapon);
}

isforcekillstreakprogressweapon(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  if(isstring(objweapon))
    objweapon = makeweapon(objweapon);

  switch (objweapon.basename) {
    case "iw9_laser_large_ir_mp":
    case "deploy_juggernaut_mp":
    case "deploy_airdrop_mp":
    case "iw9_spotter_scope_mp":
      return 1;
  }

  return 0;
}

_id_423A6AC43D977BB6() {
  return 0;
}

_id_FA5F24DF7C838FE0(_id_98EA5AFB293A76A2) {
  if(scripts\mp\utility\perk::_hasperk("specialty_underkill"))
    _id_98EA5AFB293A76A2 = _id_98EA5AFB293A76A2 * getdvarfloat("dvar_001CD604FC4C6912", 3.0);

  return _id_98EA5AFB293A76A2;
}

_id_9C1E3C18B99409E9(_id_52C67624A2BB680E) {
  if(_id_52C67624A2BB680E < 10)
    _id_52C67624A2BB680E = int(_id_52C67624A2BB680E);
  else
    _id_52C67624A2BB680E = int(max(_id_52C67624A2BB680E / 10, 1));

  _id_6AFF3948CF4CCA03::playerplunderpickup(_id_52C67624A2BB680E, undefined, 1);
}