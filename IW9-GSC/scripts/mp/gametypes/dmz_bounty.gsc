/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bounty.gsc
***********************************************/

_id_5BA1BB4933EDC5DA() {
  level._id_7481C0699A7C035C = getdvarint("dvar_F996B86AC195DA4E", 1);

  if(!_id_26660AE1076E2D99::_id_217E5C3B8A4CA539() || !level._id_7481C0699A7C035C) {
    return;
  }
  _id_362C58E8BB39BCDA::enablefeature("player_bounty");
  level._id_2CCB3BB7C65824BD = getdvarint("dvar_BB981387B47D3B0A", 7);
  level._id_9918180A152A2C49 = getdvarint("dvar_B0D283949FA83CFE", 8);
  level._id_42413476C36F4DE9 = getdvarfloat("dvar_D3D9B12AD067B71A", 0.1);
  level._id_EA588CA4581980E3 = getdvarfloat("dvar_9283DB15697679A8", 3.0);
  level._id_66901F8A5A5028D2 = getdvarint("dvar_8B4FD26F8D0F1F27", 60) * 1000;
  level._id_C33BE36F17C6F1C4 = getdvarint("dvar_DE0A66DA13BF686D", 60) * 1000;
  level._id_033081AD92157D89 = getdvarint("dvar_7E7E58269EEC0C4C", 4096);
  level._id_30CB0AD9930B995B = getdvarint("dvar_88FBE092F035854E", 1000);
  level._id_8C5F100DFCBD8ECA = getdvarint("dvar_17211EBB2D6E7FDC", 120);
  level._id_30DC2B175C83CE3B = getdvarfloat("dvar_E15493BF7AA7D925", 0.25);
  level._id_DA85DB0B3FD47276 = getdvarfloat("dvar_71CA88ED28116F2E", 1.5);
  level._id_C7B897C856840E47 = getdvarfloat("dvar_A75878FCA2A61A60", 0.25);
  level._id_B404CEFC87A66195 = getdvarfloat("dvar_0C01362BAFD123E2", 1);
  level._id_2C5B630622AF3240 = getdvarint("dvar_9006008DF935ADD2", 4);
  level._id_13A790A07DC25D17 = getdvarfloat("dvar_2547F1E25CBFA8BC", 0.5);
  level._id_B0DB22C3E521DD39 = getdvarfloat("dvar_FFD443B9CEE024F6", 1.0);
  level._id_A13977795D78D39C = getdvarint("dvar_4DC3C6509A8BA03E", 4);
  level._id_18E721FDD859EA38 = getdvarint("dvar_EE7F29468BCF226F", 2);
  level._id_5353DACAEF431F99 = getdvarfloat("dvar_0CEBE90DAC8B47FC", 0.25);
  level._id_153696EEE67770D3 = getdvarint("dvar_43ED1D607588204E", 3);
  level._id_A767584FED5587E8 = getdvarfloat("dvar_96B1854EE4098C22", 1.5);
  level._id_F8A9056AB7FC0FA4 = getdvarfloat("dvar_1627ED73590DDD4F", 0.5);
  level._id_EA415DD712D4DC36 = getdvarint("dvar_7D402A6D000F55C5", 1);
  level._id_22F3F5DFAF76570C = getdvarint("dvar_FC41FA9F3257837A", 1);
  level._id_0F50F4E9C206BACD = getdvarint("dvar_FF69C5CBCBFC5FC0", 1500);
  level._id_29D13063D54A343E = getdvarint("dvar_3A113F3A21A87F53", 5);
  level._id_C2812F877FAE7F90 = getdvarint("dvar_774B8B91E4BCDA07", 0);
  level._id_2D99C1A64EAB0CE3 = getdvarfloat("dvar_FFC46B09301C5EB6", 5.0);
  level._id_1384A410983757E1 = [];
  level._id_C704D3DE31DFE51F = [];
  _id_6CB0280F7AA7D3CD::_id_95C943D6949814D1(::_id_C7AA23953196010A);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_09DCDFD37EEAB85E);
}

_id_47EF2434C27B063C(victim, attacker, meansofdeath, _id_2E81AF6D411890C9) {
  if(!_id_362C58E8BB39BCDA::isfeatureenabled("player_bounty")) {
    return;
  }
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("player_bounty")) {
    return;
  }
  if(!_id_26660AE1076E2D99::_id_217E5C3B8A4CA539() || !level._id_7481C0699A7C035C || !isDefined(level._id_1384A410983757E1)) {
    return;
  }
  if(!isDefined(attacker) || !isDefined(victim) || !isPlayer(attacker) || !isPlayer(victim)) {
    return;
  }
  if(!isDefined(attacker.pers) || !isDefined(victim.pers)) {
    return;
  }
  _id_4125D811C53D9546 = isDefined(meansofdeath) && (meansofdeath == "MOD_SUICIDE" || meansofdeath == "MOD_FALLING") || isDefined(attacker) && attacker == victim;

  if(_id_4125D811C53D9546) {
    return;
  }
  if(!_id_760C732463D67ABD(victim, attacker)) {
    return;
  }
  _id_ED1520A9C7BAA4AF = attacker scripts\mp\utility\player::getuniqueid();
  _id_48B7B944A7A02B2C = victim scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF])) {
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF] = spawnStruct();
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].victims = [];
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].score = 0;
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].lastkilltime = 0;
  }

  if(_id_C54F9C19D5062C2D(_id_ED1520A9C7BAA4AF, _id_48B7B944A7A02B2C) && !isDefined(_id_2E81AF6D411890C9)) {
    return;
  }
  currenttime = gettime();
  level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].victims[_id_48B7B944A7A02B2C] = currenttime + level._id_66901F8A5A5028D2;
  lastscore = _id_9D1EDAAFD9AE1F43(_id_ED1520A9C7BAA4AF);
  level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].score = _id_49514C83EDE61C52(_id_ED1520A9C7BAA4AF, attacker, victim);
  level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].lastkilltime = currenttime;

  if(isDefined(_id_2E81AF6D411890C9))
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].score = _id_2E81AF6D411890C9;

  _id_C115071FC3AD7124(attacker, lastscore);
}

_id_625D7EECAD65E25F(_id_CC75E0B74EE84D57) {
  _id_4EEBF10183CB21F2 = _id_CC75E0B74EE84D57._id_4EEBF10183CB21F2;
  _id_54920CBB1F92B9EA = _id_CC75E0B74EE84D57._id_54920CBB1F92B9EA;
  _id_2329E2336D8412BC = [];

  if(isDefined(_id_4EEBF10183CB21F2)) {
    _id_2329E2336D8412BC = scripts\mp\utility\teams::getteamdata(_id_4EEBF10183CB21F2, "players");

    foreach(player in _id_2329E2336D8412BC) {
      if(scripts\cp_mp\utility\player_utility::isreallyalive(player))
        _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([player], "bounty_completed", level._id_2D99C1A64EAB0CE3);
    }
  } else if(isDefined(_id_54920CBB1F92B9EA)) {
    _id_2329E2336D8412BC[_id_2329E2336D8412BC.size] = _id_54920CBB1F92B9EA;
    _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([_id_54920CBB1F92B9EA], "bounty_completed", level._id_2D99C1A64EAB0CE3);
  }

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_plunder_cash_common_1");

  foreach(player in _id_2329E2336D8412BC) {
    player _id_6AFF3948CF4CCA03::playerplunderpickup(level._id_30CB0AD9930B995B);

    if(isDefined(lootid))
      level thread _id_8723026F5A8E1127(player, lootid, level._id_2D99C1A64EAB0CE3);
  }

  if(isDefined(_id_CC75E0B74EE84D57.player)) {
    _id_ED1520A9C7BAA4AF = _id_CC75E0B74EE84D57.player scripts\mp\utility\player::getuniqueid();
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF] = undefined;
    _id_CC75E0B74EE84D57.player._id_69A9151E7DE440F1 = undefined;
  }
}

_id_087E294701A141CE(_id_CC75E0B74EE84D57, player) {
  if(_id_CC75E0B74EE84D57.player.team == player.team) {
    return;
  }
  if(!isDefined(_id_CC75E0B74EE84D57._id_F3C3089E456BD1FB))
    _id_CC75E0B74EE84D57._id_F3C3089E456BD1FB = [];

  currenttime = gettime();
  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(_id_CC75E0B74EE84D57._id_F3C3089E456BD1FB[playerid])) {
    _id_CC75E0B74EE84D57._id_F3C3089E456BD1FB[playerid] = gettime() + level._id_C33BE36F17C6F1C4;
    _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([player], "bounty_placed_enemy", level._id_2D99C1A64EAB0CE3);
    player _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_killed_nearby_callout", [player]);
  } else if(_id_CC75E0B74EE84D57._id_F3C3089E456BD1FB[playerid] < currenttime)
    _id_CC75E0B74EE84D57._id_F3C3089E456BD1FB[playerid] = undefined;
}

_id_8723026F5A8E1127(player, lootid, waittime) {
  player notify("bounty_reward_delay");
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("bounty_reward_delay");
  wait(waittime + 1);
  _id_FBB5190911C15C1B = player getvieworigin();
  player _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, level._id_30CB0AD9930B995B);
}

_id_09DCDFD37EEAB85E() {
  level thread _id_84703A2EE79A7BBA(self);
}

_id_C7AA23953196010A(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(!scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    return;
  }
  if(!isDefined(eattacker) || !isDefined(victim) || !isDefined(eattacker.team) || !isDefined(victim.team) || eattacker.team == victim.team) {
    return;
  }
  if(!isDefined(level._id_C704D3DE31DFE51F[victim.team]))
    level._id_C704D3DE31DFE51F[victim.team] = [];

  currenttime = gettime();

  if(!isDefined(level._id_C704D3DE31DFE51F[victim.team][eattacker.team])) {
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team] = spawnStruct();
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_6F635BFCC8E71408 = currenttime;
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_7A7953DE79B5D5C0 = currenttime;
  } else if(isDefined(level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_7A7953DE79B5D5C0) && level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_7A7953DE79B5D5C0 + level._id_8C5F100DFCBD8ECA * 1000 < currenttime) {
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_6F635BFCC8E71408 = currenttime;
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_7A7953DE79B5D5C0 = currenttime;
  } else
    level._id_C704D3DE31DFE51F[victim.team][eattacker.team]._id_7A7953DE79B5D5C0 = currenttime;
}

_id_84703A2EE79A7BBA(player) {
  player endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    player waittill("bulletwhizby", attacker, distance, position, forward);

    if(!isDefined(attacker) || !isDefined(attacker.team) || attacker.team == player.team) {
      continue;
    }
    if(!isDefined(level._id_C704D3DE31DFE51F[player.team]))
      level._id_C704D3DE31DFE51F[player.team] = [];

    currenttime = gettime();

    if(!isDefined(level._id_C704D3DE31DFE51F[player.team][attacker.team])) {
      level._id_C704D3DE31DFE51F[player.team][attacker.team] = spawnStruct();
      level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_6F635BFCC8E71408 = currenttime;
      level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_A6C14DFBE6016990 = currenttime;
      continue;
    }

    if(isDefined(level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_A6C14DFBE6016990) && level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_A6C14DFBE6016990 + level._id_8C5F100DFCBD8ECA * 1000 < currenttime) {
      level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_6F635BFCC8E71408 = currenttime;
      level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_A6C14DFBE6016990 = currenttime;
      continue;
    }

    level._id_C704D3DE31DFE51F[player.team][attacker.team]._id_A6C14DFBE6016990 = currenttime;
  }
}

_id_5D60F21784F774F4(attacker, victim) {
  if(!isDefined(attacker) || !isDefined(victim))
    return 0;

  if(!isDefined(level._id_C704D3DE31DFE51F[attacker.team]) || !isDefined(level._id_C704D3DE31DFE51F[attacker.team][victim.team]))
    return 0;

  _id_A05CCC186B33A983 = level._id_C704D3DE31DFE51F[attacker.team][victim.team]._id_6F635BFCC8E71408;
  _id_E296CF4B39B5A680 = 0;

  if(isDefined(level._id_C704D3DE31DFE51F[victim.team]) && isDefined(level._id_C704D3DE31DFE51F[victim.team][attacker.team]))
    _id_E296CF4B39B5A680 = level._id_C704D3DE31DFE51F[victim.team][attacker.team]._id_6F635BFCC8E71408;

  return _id_A05CCC186B33A983 <= _id_E296CF4B39B5A680;
}

_id_760C732463D67ABD(victim, attacker) {
  _id_48B7B944A7A02B2C = victim scripts\mp\utility\player::getuniqueid();
  _id_773AD909331CEE07 = scripts\mp\utility\teams::getteamdata(victim.team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_773AD909331CEE07) {
    _id_A779EA1A22E09530 = _id_F0EA4030349A33D5 scripts\mp\utility\player::getuniqueid();

    if(isDefined(_id_A779EA1A22E09530) && isDefined(level._id_1384A410983757E1[_id_A779EA1A22E09530]) && isDefined(level._id_1384A410983757E1[_id_A779EA1A22E09530]._id_CC75E0B74EE84D57))
      return 0;
  }

  if(_id_0419EEBC6F24E287::_id_5FAC7D775590ECDD(victim.team, attacker.team))
    return 0;

  return 1;
}

_id_140A6288C05473FE(player) {
  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level._id_1384A410983757E1[playerid])) {
    level._id_1384A410983757E1[playerid] = spawnStruct();
    level._id_1384A410983757E1[playerid].victims = [];
    level._id_1384A410983757E1[playerid].score = 0;
    level._id_1384A410983757E1[playerid].lastkilltime = 0;
  }
}

_id_C115071FC3AD7124(attacker, lastscore) {
  if(istrue(attacker._id_69A9151E7DE440F1)) {
    return;
  }
  _id_ED1520A9C7BAA4AF = attacker scripts\mp\utility\player::getuniqueid();
  _id_4F7F0599B533DA3C = _id_9D1EDAAFD9AE1F43(_id_ED1520A9C7BAA4AF);
  _id_04597FF2ED063CF9 = _id_39C1F2930FD57DB5(_id_4F7F0599B533DA3C);
  _id_FBFAA7D0BC334DA7 = _id_39C1F2930FD57DB5(lastscore);

  if(_id_04597FF2ED063CF9 == 3 && _id_FBFAA7D0BC334DA7 != 2) {
    _id_04597FF2ED063CF9 = 2;
    level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].score = level._id_9918180A152A2C49 - 0.1;
  }

  if(_id_04597FF2ED063CF9 < 3) {
    _id_06029F97C06C2236(attacker, _id_04597FF2ED063CF9);
    return;
  }

  _id_06029F97C06C2236(attacker, _id_04597FF2ED063CF9);
  _id_0424DD60EF6B968C = spawnStruct();

  if(level._id_EA415DD712D4DC36)
    _id_59D1B7F99D093E0E(_id_0424DD60EF6B968C);
  else
    _id_993EB16C9EC92291(_id_0424DD60EF6B968C);

  attacker._id_69A9151E7DE440F1 = 1;
  _id_0424DD60EF6B968C._id_652D26F30484AFE1 = "ui_map_icon_bounty_s5";
  _id_0424DD60EF6B968C._id_9FCCD0C71039EFF7 = ::_id_087E294701A141CE;
  _id_0424DD60EF6B968C._id_88C5361DB8DBCEAC = ::_id_625D7EECAD65E25F;
  _id_CC75E0B74EE84D57 = _id_26660AE1076E2D99::_id_4647CBF23F54D6F6(attacker, _id_0424DD60EF6B968C);
  _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([attacker], "bounty_placed_self", level._id_2D99C1A64EAB0CE3);
  _id_8BED5039285F4038 = scripts\mp\utility\teams::getteamdata(attacker.team, "players");

  foreach(player in _id_8BED5039285F4038) {
    player setclientomnvar("ui_dmz_bounty_squad_index", attacker._id_3F78C6A0862F9E25);

    if(player != attacker && scripts\cp_mp\utility\player_utility::isreallyalive(player))
      _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([player], "bounty_placed_friendly", level._id_2D99C1A64EAB0CE3);
  }

  level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF]._id_CC75E0B74EE84D57 = _id_CC75E0B74EE84D57;
}

_id_993EB16C9EC92291(_id_0424DD60EF6B968C) {
  _id_0424DD60EF6B968C._id_D66266E27481ACE9 = scripts\engine\utility::ter_op(level._id_22F3F5DFAF76570C, 2, 0);
  _id_0424DD60EF6B968C._id_40CA706DA5962314 = 2;
  _id_0424DD60EF6B968C._id_A0C9C946B5C00006 = level._id_C2812F877FAE7F90;
}

_id_59D1B7F99D093E0E(_id_0424DD60EF6B968C) {
  _id_0424DD60EF6B968C._id_D66266E27481ACE9 = scripts\engine\utility::ter_op(level._id_22F3F5DFAF76570C, 2, 0);
  _id_0424DD60EF6B968C._id_40CA706DA5962314 = 1;
  _id_0424DD60EF6B968C.circleradius = level._id_0F50F4E9C206BACD;
  _id_0424DD60EF6B968C._id_212406C9408B2D05 = level._id_29D13063D54A343E;
  _id_0424DD60EF6B968C._id_E6F187BCB4B1648E = "Bounty_DMZ";
  _id_0424DD60EF6B968C._id_D77771D6BFB89518 = "ui_map_icon_bounty_s5";
}

_id_C54F9C19D5062C2D(_id_ED1520A9C7BAA4AF, _id_48B7B944A7A02B2C) {
  if(!isDefined(level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].victims) || !isDefined(level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].victims[_id_48B7B944A7A02B2C]))
    return 0;

  cooldowntime = level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].victims[_id_48B7B944A7A02B2C];
  currenttime = gettime();
  return cooldowntime <= currenttime;
}

_id_49514C83EDE61C52(_id_ED1520A9C7BAA4AF, attacker, victim) {
  _id_4F7F0599B533DA3C = _id_9D1EDAAFD9AE1F43(_id_ED1520A9C7BAA4AF);
  _id_BB812FFE48276652 = getdvarint("dvar_9D43C91BD2B1870E", 1);
  _id_C82F49D7E44EB40D = 1;
  _id_EBE73726F006A63F = scripts\engine\utility::_id_53C4C53197386572(attacker.pers["kills"], 0);
  _id_86DBD4C78B4B630A = scripts\engine\utility::_id_53C4C53197386572(victim.pers["kills"], 0);

  switch (_id_BB812FFE48276652) {
    case 1:
      _id_C82F49D7E44EB40D = scripts\engine\utility::ter_op(_id_5D60F21784F774F4(attacker, victim), level._id_30DC2B175C83CE3B, 1);
      _id_A36E49C4E7A7E02D = scripts\mp\gamelogic::gettimeremainingpercentage();
      _id_0C5F06DD68C41574 = level._id_DA85DB0B3FD47276 * scripts\engine\utility::ter_op(_id_A36E49C4E7A7E02D < 0.75, _id_A36E49C4E7A7E02D, 1);
      _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * _id_0C5F06DD68C41574;
      _id_E9B7EB3FB1BC573A = scripts\mp\utility\teams::getteamdata(victim.team, "players");
      _id_F873DCA25C9DD763 = scripts\mp\utility\teams::getteamdata(attacker.team, "players");
      _id_EC3E0C1A53056D7F = 1 + (_id_F873DCA25C9DD763.size - _id_E9B7EB3FB1BC573A.size) / _id_3FF084F114B7F6C9::_id_17339FA510BD6380();
      _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * _id_EC3E0C1A53056D7F;
      _id_8C7E696211FE4F37 = level._id_2C5B630622AF3240 / (_id_86DBD4C78B4B630A + 1);
      _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * clamp(_id_8C7E696211FE4F37, level._id_C7B897C856840E47, level._id_B404CEFC87A66195);
      _id_97761A3C665CBCDE = 1;

      foreach(_id_78D4262A23453D9E in _id_F873DCA25C9DD763) {
        _id_EC91E42317212DCE = scripts\engine\utility::_id_53C4C53197386572(_id_78D4262A23453D9E.pers["kills"], 0);
        _id_97761A3C665CBCDE = _id_97761A3C665CBCDE + _id_EC91E42317212DCE;
      }

      if(_id_97761A3C665CBCDE >= level._id_153696EEE67770D3) {
        foreach(_id_78D4262A23453D9E in _id_F873DCA25C9DD763) {
          if(_id_78D4262A23453D9E != attacker) {
            _id_140A6288C05473FE(_id_78D4262A23453D9E);
            _id_D91669507FBFA423 = _id_78D4262A23453D9E scripts\mp\utility\player::getuniqueid();
            _id_6FF1DF16B93E2A45 = scripts\engine\utility::ter_op(_id_5D60F21784F774F4(attacker, victim), level._id_30DC2B175C83CE3B, 1);
            level._id_1384A410983757E1[_id_D91669507FBFA423].score = level._id_1384A410983757E1[_id_D91669507FBFA423].score + _id_6FF1DF16B93E2A45;
          }
        }
      }

      _id_D893E028FDDAE063 = scripts\mp\utility\teams::getteamdata(victim.team, "aliveCount");

      if(_id_D893E028FDDAE063 <= 0)
        _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * level._id_A767584FED5587E8;

      if(isDefined(victim.attackers)) {
        foreach(_id_2C5B6AA194FE1165 in victim.attackers) {
          if(isPlayer(_id_2C5B6AA194FE1165) && _id_2C5B6AA194FE1165 != attacker && _id_2C5B6AA194FE1165 != victim) {
            _id_140A6288C05473FE(_id_2C5B6AA194FE1165);
            _id_AF47DE65831FE700 = _id_2C5B6AA194FE1165 scripts\mp\utility\player::getuniqueid();
            _id_6FF1DF16B93E2A45 = scripts\engine\utility::ter_op(_id_5D60F21784F774F4(attacker, victim), level._id_30DC2B175C83CE3B, 1);
            level._id_1384A410983757E1[_id_AF47DE65831FE700].score = level._id_1384A410983757E1[_id_AF47DE65831FE700].score + level._id_F8A9056AB7FC0FA4 * _id_6FF1DF16B93E2A45;
          }
        }
      }

      if(isDefined(victim.pers["assists"])) {
        _id_FDDC8AA6F0828E47 = level._id_A13977795D78D39C / (victim.pers["assists"] + 1);
        _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * clamp(_id_8C7E696211FE4F37, level._id_13A790A07DC25D17, level._id_B0DB22C3E521DD39);
      }

      if(_id_EBE73726F006A63F + 1 <= level._id_18E721FDD859EA38)
        _id_C82F49D7E44EB40D = _id_C82F49D7E44EB40D * level._id_5353DACAEF431F99;

      break;
    default:
      break;
  }

  _id_C82F49D7E44EB40D = clamp(_id_C82F49D7E44EB40D, level._id_42413476C36F4DE9, level._id_EA588CA4581980E3);
  return _id_4F7F0599B533DA3C + _id_C82F49D7E44EB40D;
}

_id_9D1EDAAFD9AE1F43(_id_ED1520A9C7BAA4AF) {
  if(!isDefined(level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF]))
    return 0;

  return level._id_1384A410983757E1[_id_ED1520A9C7BAA4AF].score;
}

_id_F59BB0593A8F98A9(player) {
  if(!isDefined(level._id_1384A410983757E1) || !isDefined(player))
    return 0;

  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level._id_1384A410983757E1[playerid]))
    return 0;

  return level._id_1384A410983757E1[playerid].score;
}

_id_39C1F2930FD57DB5(score) {
  threshold = 0;

  if(score > 0)
    threshold++;

  if(score >= level._id_2CCB3BB7C65824BD)
    threshold++;

  if(score >= level._id_9918180A152A2C49)
    threshold++;

  return threshold;
}

_id_06029F97C06C2236(attacker, threshold) {
  switch (threshold) {
    case 1:
      attacker _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_killed_marked_warning_first", [attacker]);
      break;
    case 2:
      attacker _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_killed_marked_second", [attacker]);
      break;
    case 3:
      attacker _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_killed_marked_final", [attacker]);
      break;
    default:
      break;
  }
}