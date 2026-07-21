/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_spectate.gsc
***********************************************/

spectate_init() {
  level thread updateactivespectatorcounts();
}

initplayer() {
  _id_1252A();
}

regive_killstreak_after_use(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0._id_11E80)) {
    var_2 = reset_use_puzzle_effects(var_0._id_11E80);
    var_0._id_11E80 = undefined;
  }

  if(!isDefined(var_2))
    var_2 = var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12568(undefined, undefined, 1);

  if(!isDefined(var_2)) {
    var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_2 = registeruniquelootcallback(var_0, var_3);
  }

  if(!isDefined(var_2) && scripts\mp\menus::_id_13733()) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");
    var_2 = registeruniquelootcallback(var_0, var_3);
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.team != var_0.team) {
      if(isalive(var_1) && !istrue(var_1.gulag) && !istrue(var_1.inlaststand) && !var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
        var_2 = var_1;
      else {
        var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team);
        var_2 = registeruniquelootcallback(var_0, var_4, 1);
      }
    }
  }

  if(!isDefined(var_2) && isPlayer(var_1) && var_1 != var_0) {
    var_2 = reset_use_puzzle_effects(var_1);

    if(isDefined(var_2) && var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      var_2 = undefined;
  }

  if(!isDefined(var_2))
    var_2 = registeruniquelootcallback(var_0, level.players);

  if(!isDefined(var_2) && level.players.size > 1 && !istrue(level.gameended) && !istrue(level._encstr_82061D106BF2B7B046A9DDC72D77E133C5FBB8224E7CB8942543C150D98AC5)) {
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(istrue(var_7.delay_enter_combat_after_investigating_grenade))
        var_5++;
    }

    scripts\mp\utility\script::laststand_dogtags("_encstr_9AA834CEAC4724959B47A61CB2C68E0B3A2BA1B0E619A546C2E8B240A58073F602EC0B634B1910E08D852FAC279B4099F6AECD9180A0" + var_5 + "_encstr_997205D1353511" + level.players.size + "_encstr_AA590D638EA0400BD73A020BAB85DA");
  }

  return var_2;
}

issubgametype(var_0, var_1, var_2) {
  var_3 = "_encstr_96F809CBD1B7936568B2E6" + var_0.name + "_encstr_A5360EB2414EEA96D0C0FF865BE0FAB6" + var_1.name + "_encstr_AB911859C19A713F17D0C2F3CD1390D8A00FE576A7E892977A79" + var_2.size;
  scripts\mp\utility\script::laststand_dogtags(var_3);
  var_3 = "_encstr_B40101";
  var_4 = int(min(var_2.size, 3));
  var_5 = 0;

  foreach(var_7 in var_2) {
    var_3 = var_3 + ("_encstr_A3360C69A67289CBC10283785812" + var_7.name + "_encstr_95370FC8320D3C33A8339BF8F3A1B0B2B9" + istrue(var_7.delay_enter_combat_after_investigating_grenade));
    var_5++;

    if(var_5 > var_4) {
      break;
    }
  }

  scripts\mp\utility\script::laststand_dogtags(var_3);
}

reset_use_puzzle_effects(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = var_0; isDefined(var_3) && !vandalize_target_think(var_3); var_3 = var_3 _id_12580()) {
    var_2++;
    var_4 = var_3 getentitynumber();

    if(var_2 >= 150 || isDefined(var_1[var_4])) {
      issubgametype(var_0, var_3, var_1);
      return;
    }

    var_1[var_4] = var_3;
  }

  return var_3;
}

registeruniquelootcallback(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  foreach(var_9 in var_1) {
    if(!isDefined(var_9) || !vandalize_target_think(var_9) || var_9 == var_0) {
      continue;
    }
    if(istrue(var_9.gulag)) {
      var_5[var_5.size] = var_9;
      continue;
    }

    if(istrue(var_9.inlaststand)) {
      var_6[var_6.size] = var_9;
      continue;
    }

    if(var_9 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      var_7[var_7.size] = var_9;
      continue;
    }

    var_4[var_4.size] = var_9;
  }

  if(var_4.size > 0) {
    var_11 = randomint(var_4.size);
    var_3 = var_4[var_11];
  }

  if(!isDefined(var_3) && var_5.size > 0) {
    var_11 = randomint(var_5.size);
    var_3 = var_5[var_11];
  }

  if(!isDefined(var_3) && var_6.size > 0) {
    var_11 = randomint(var_6.size);
    var_3 = var_6[var_11];
  }

  if(!isDefined(var_3) && var_7.size > 0 && !istrue(var_2)) {
    var_11 = randomint(var_7.size);
    var_3 = var_7[var_11];
  }

  return var_3;
}

vandalize_target_think(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_95DB1628DA5E0B39828B87C9A70A7D581437F7A102D7E8ED")))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_95DB1628DA5E0B39828B87C9A70A7D581437F7A102D7E8ED", var_0);

  if(!isalive(var_0) && !istrue(var_0.respawningfromtoken) && (istrue(var_0.gulagarena) || !istrue(var_0.gulag)))
    return 0;

  return !istrue(var_0.delay_enter_combat_after_investigating_grenade);
}

_id_13668(var_0) {
  var_1 = spawnStruct();

  if(istrue(level._id_14603) && level._id_14603 == 6 && getdvarint("_encstr_8E08288E5BF3D685DAB990D29134A50B07D2190BA32FD8D785C128184ACE59E0576688F5060FE109AF5A", 1)) {
    var_1.origin = getdvarvector("_encstr_86E31E37B1C9AFC44EFA0F62FA4BCDE82B93B6B4373796DEE67DDE27D2EC96DC", (29247, 1991, 6334));
    var_1.angles = getdvarvector("_encstr_BECF1E9AF6ADB9321BA183AE8950E6D36B96E59466179277E0B9DFCBB028A5EB", (85, 135, 0));
  } else if(isDefined(level._id_12D05) && level._id_12D05 == 2 && getdvarint("_encstr_A6432AE6C69CEB4C937D32BDEC89F55A37472BC9B54BDC6E5ADE9BF58DBDC62CE82D7BE6BE95DC16C4D82B8C", 1)) {
    var_1.origin = getdvarvector("_encstr_A9842058F25A77811B87ED50863EEEC3856B10D88A3467FB0FAFE04067EB10972C72", (29247, 1991, 6334));
    var_1.angles = getdvarvector("_encstr_BDC0206EB19CBE2693F532EDB389EBA59BE8AC4E6BA59BE6A5DEDC7DC2E69DB1ACE6", (85, 135, 0));
  } else if(isDefined(var_0._id_136DC)) {
    var_1 = var_0._id_136DC;
    var_0._id_136DC = undefined;
  } else {
    var_1.origin = var_0.origin + (0, 0, 100);
    var_1.angles = var_0.angles;
  }

  scripts\mp\playerlogic::spawnintermission(var_1, undefined, 0);
}

spawnspectator(var_0, var_1, var_2) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
    return;
  }
  var_3 = self;
  var_3 _id_13668(var_3);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9")) {
    return;
  }
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126AA();

  if(!istrue(var_2))
    var_3 thread _id_13DC2();

  var_4 = undefined;

  if(isDefined(var_0.attacker))
    var_4 = var_0.attacker;

  var_5 = regive_killstreak_after_use(var_3, var_4);

  if(isDefined(var_5) || !istrue(level._encstr_82061D106BF2B7B046A9DDC72D77E133C5FBB8224E7CB8942543C150D98AC5))
    assignspectatortospectateplayer(var_3, var_5);

  if(!istrue(var_3.br_spectatorinitialized)) {
    var_3 notify("_encstr_AB6B185EF2998F6B05D7F040935763B3F25CCD538E0263D2EDE3");
    var_3.br_spectatorinitialized = 1;
  }
}

_id_13DC2() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9191195A33D053DF804BC7C643D0A52F78493292B8938316C0B3F4");
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  if(var_0.size > 0) {
    var_1 = 1;

    switch (scripts\mp\utility\game::round_vehicle_logic()) {
      case "_encstr_866209ECEDB1197DEE0B4E":
      case "_encstr_9B1F05BE4B9B52":
      case "_encstr_8AE1099A0B999F2D28AF15":
      case "_encstr_BE180419DAE9":
      case "_encstr_816E079685517D0975":
        var_1 = 0;
        break;
      case "_encstr_85EE090C9DD0A62F3CA1B3":
        var_1 = !isDefined(level._id_13ACE) || !isDefined(level._id_13ACE[self.team]);
        break;
    }

    if(var_1) {
      thread _id_13132();
      wait 0.25;
      self setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 5);
      wait 1.0;
      self setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 0);
    }
  }
}

_id_125C9() {
  var_0 = 0;
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && self != var_3 && isalive(var_3) && !var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

_id_13132() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9191195A33D053DF804BC7C643D0A52F78493292B8938316C0B3F4");
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");
  self endon("_encstr_B1E80FD9BAB1B076EB2C5DE87BF5EE5A37");

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_0 = istrue(getdvarint("_encstr_93DE21E28EA5B12A03A993F7F0DBF2FA53906E9F780DAA632B308FD37931D6C2353977", 0)) && level.disable_super_in_turret._id_12CA4;

  if(scripts\mp\utility\game::getgametype() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::getgametype() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::getgametype() != "_encstr_866209ECEDB1197DEE0B4E" && !var_0) {
    _id_143FA(self);

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::use_csm(self)) {
      return;
    }
    scripts\mp\utility\lower_message::setlowermessageomnvar(75);

    for(;;) {
      waittillframeend;

      if(isDefined(self._id_126CC) && istrue(self._id_126CC.gulag)) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        waitframe();
        continue;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(75);

      if(!_id_125C9()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        waitframe();
      }

      var_1 = scripts\engine\utility::_id_143AF("_encstr_966811918399F057DA5F5DCBCF43ADB04C1FD9", "_encstr_BE2522CA4D51727305D183DA5B68232128CD446F8D28FAF73D2949E3E3B5AF235091F7CA", "_encstr_840F150ED8B0F22B931DDEE61C95C6E8B0E8597D9BB2E8", "_encstr_95C0114B0F99BF33EB808AF230BF2E0FB1F9A5");

      if(isDefined(self) && isDefined(var_1) && var_1 == "_encstr_966811918399F057DA5F5DCBCF43ADB04C1FD9") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        wait 10;
      }
    }
  }
}

istacticalbc(var_0, var_1) {
  var_2 = "_encstr_96F809CBD1B7936568B2E6" + var_0.name;

  if(isDefined(var_1))
    var_2 = var_2 + ("_encstr_843A15DDD150BCDA7B0B73E3773693ED60E3065391FA38" + var_1.name + "_encstr_A20A0AA1983F30135B9A02DA" + isalive(var_1) + "_encstr_95370FC8320D3C33A8339BF8F3A1B0B2B9" + istrue(var_1.delay_enter_combat_after_investigating_grenade) + "_encstr_9BEB0A651967E5E5FEBC4AAF" + istrue(var_1.gulag));

  scripts\mp\utility\script::laststand_dogtags(var_2);
  waitframe();
  var_2 = "_encstr_9B921FEE2C96A333C916DA9580B4010E8DB02FAC9345EDD407AC1B3A5847AC8E04" + var_1.name + "_encstr_A20A0AA1983F30135B9A02DA" + isalive(var_1) + "_encstr_95370FC8320D3C33A8339BF8F3A1B0B2B9" + istrue(var_1.delay_enter_combat_after_investigating_grenade) + "_encstr_9BEB0A651967E5E5FEBC4AAF" + istrue(var_1.gulag);
  scripts\mp\utility\script::laststand_dogtags(var_2);
}

_id_1252A() {
  self._id_12876 = undefined;
  self._id_11E80 = undefined;
  self._id_126CC = undefined;
  self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  self notify("_encstr_AC211A091DBAD07DD16B231B67DBAE9045F6B361431521278B5F1319");
  self notify("_encstr_A5E21C1F3D32D3B16A2770705F84083DF9A21D2E936A81B83227D8E053AD");
}

_id_126AB() {
  var_0 = self;

  if(var_0.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258") {
    var_1 = var_0 _id_12580();

    if(istrue(var_1._id_14439)) {
      var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1268E(1);
      level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
    }

    var_0 _id_13668(var_1);
  }
}

forceplayerspectatetarget(var_0) {
  if(istrue(level.endmatchcameratransitions)) {
    return;
  }
  var_1 = self;
  level endon("_encstr_918D15899CA638B0DDB982D8B0CBB2273715DC8C4BB93B");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_AC211A091DBAD07DD16B231B67DBAE9045F6B361431521278B5F1319");
  var_1 endon("_encstr_AC211A091DBAD07DD16B231B67DBAE9045F6B361431521278B5F1319");
  var_1._id_12876 = 1;
  var_1 _id_126AB();

  if(!isDefined(var_0) || !isPlayer(var_0) || !isalive(var_0) && !var_0 _id_125ED()) {
    if(level.gameended || level.players.size == 1) {
      var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_1 getentitynumber());
      var_1._id_12876 = undefined;
      return;
    }

    thread istacticalbc(var_1, var_0);
    var_0 = regive_killstreak_after_use(var_1);

    if(!isDefined(var_0)) {
      var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_1 getentitynumber());
      var_1._id_12876 = undefined;
      return;
    }
  }

  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0 getentitynumber();
  var_1._id_126CC = var_0;
  var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_2);

  if(!var_1 isadditionalstreamposready())
    var_1 clearadditionalstreampos();

  var_1 calloutmarkerping_getorigin(0.0);
  var_3 = var_0.origin;

  if(istrue(var_0.respawningfromtoken) && isDefined(var_0.forcespawnorigin)) {
    if(!var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA()) {
      if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1)
        logstring("_encstr_B8DA201213E0F9D7BF7D99029A4988C2B74EDF382566C4DBDB9FF9C9F3920703DA91");

      var_1 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();
    } else if(!var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA())
      var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12522();

    var_3 = var_0.forcespawnorigin;
    var_1 setadditionalstreampos(var_3, 1);
  } else if(isDefined(var_0._id_1391A)) {
    var_3 = var_0._id_1391A.origin;
    var_1 setadditionalstreampos(var_3, 1);
  } else
    var_1 setadditionalstreampos(var_3, 1, 0, var_0);

  var_1 loadcustomizationplayerview(var_0);
  var_4 = var_0 getweaponslistprimaries();
  var_1 loadweaponsforplayer(var_4, 1);
  waitframe();
  var_5 = getdvarint("_encstr_87391EFA2B08435BA7F99F7F1FD5C3BDC01079C3835809138D97835F07FD9BE1", 2500);
  var_6 = getdvarint("_encstr_9B841C6E1C59C647581DACFACD4727AC2C5BAFAB838CB0E8AC7D1D2D6B59", 500);
  var_7 = getdvarint("_encstr_B13818BF9B0AEEC00973D9965AE40815A2776F0957D2A550354B", 9000);
  var_8 = gettime() + var_6;
  var_9 = gettime() + var_7;

  while((!var_1 isadditionalstreamposready() || isDefined(var_0) && !var_1 hasloadedcustomizationplayerview(var_0) || !var_1 hasloadedviewweapons(var_4)) && gettime() < var_9) {
    if(isDefined(var_0) && !isDefined(var_0._id_1391A) && gettime() > var_8) {
      var_10 = distance2dsquared(var_0.origin, var_3);

      if(var_10 > var_5) {
        var_3 = var_0.origin;
        var_1 setadditionalstreampos(var_3, 1, 0, var_0);
        var_8 = gettime() + var_6;
      }
    }

    waitframe();
  }

  var_12 = getdvarint("_encstr_9B841C6E1C59C647581DACFACD4727AC2C5BAFAB838CB0E8AC7D1D2D6B59", 2000);
  var_9 = gettime() + var_7;
  var_13 = 0;

  while((isDefined(var_0._id_1391A) || !isalive(var_0)) && gettime() < var_9) {
    if(gettime() > var_13) {
      var_1 setadditionalstreampos(var_3, 1);
      var_13 = gettime() + var_12;
    }

    waitframe();
  }

  if(isDefined(var_0))
    var_1 _id_12563(var_0);

  var_1 thread _id_12603();
  var_1 clearadditionalstreampos();

  if(istrue(var_1._id_14439)) {
    var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1268E(0);
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
  }
}

_id_12563(var_0) {
  var_1 = self;

  if(!istrue(var_1.multieventdisabled)) {
    if(!var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA()) {
      if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1)
        logstring("_encstr_A71225DB2038075BB9D7302F460562D2C190871BC0916432D1F8FAAEA1639A868B99C7C720A0E1");

      var_1 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();
    } else if(!var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA()) {
      var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12522();
      wait 0.5;
    }
  }

  var_2 = var_0 getentitynumber();
  var_1 scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  var_1.forcespectatorclient = var_2;
  var_1 scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_A37012E60EC2EE37A4CD3AB2276BB437374BDB73");
  var_1 calloutmarkerping_getcreatedtime(0.0);
  var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  var_3 = var_1 getspectatingplayer();

  while(!isDefined(var_3) || var_2 != var_3 getentitynumber()) {
    waitframe();
    var_3 = var_1 getspectatingplayer();

    if(!isDefined(var_0) || !vandalize_target_think(var_0)) {
      break;
    }
  }

  var_1 notify("_encstr_BE2522CA4D51727305D183DA5B68232128CD446F8D28FAF73D2949E3E3B5AF235091F7CA");
  var_1.forcespectatorclient = -1;

  if(isDefined(var_0) && vandalize_target_think(var_0))
    var_1 spectateclientnum(var_2, 1);

  var_1._id_12876 = undefined;
}

assignspectatortospectateplayer(var_0, var_1) {
  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_86342022A8D774B7E8B66875B67377FB0758F95A01692FEFC387546DC7583FC04BF0", var_0, var_1);

  if(istrue(var_2)) {
    return;
  }
  var_0 allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);
  var_0 allowspectateteam("_encstr_8BBA05185F8B99", 0);
  var_0 setmlgmessagesent(0);

  if(level.teambased && isDefined(var_1))
    var_0 allowspectateteam(var_1.team, 1);

  var_0 thread forceplayerspectatetarget(var_1);
  self notify("_encstr_840F150ED8B0F22B931DDEE61C95C6E8B0E8597D9BB2E8");
}

_id_12603() {
  self notify("_encstr_A5E21C1F3D32D3B16A2770705F84083DF9A21D2E936A81B83227D8E053AD");
  self endon("_encstr_A5E21C1F3D32D3B16A2770705F84083DF9A21D2E936A81B83227D8E053AD");
  self endon("_encstr_AC211A091DBAD07DD16B231B67DBAE9045F6B361431521278B5F1319");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");
  level endon("_encstr_AC63109843D7295D3A2C58D48963A11142F3");

  for(;;) {
    self waittill("_encstr_935F179B1C56D88E58A3B4CDECD78DF28D36B2FADC1D0BE4E8", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA())
      _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12522();

    var_1 = _id_126EC(var_0);
    var_2 = self getspectatingplayer();

    if(!istrue(var_1) || !isDefined(var_2)) {
      stopspectateplayer(self getentitynumber(), 1);

      if(vandalize_target_think(self._id_126CC))
        _id_12563(self._id_126CC);
      else {
        var_0 = regive_killstreak_after_use(self);

        if(isDefined(var_0) && !var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA()) {
          if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1)
            logstring("_encstr_A55C22E0122C47F3B369B3A5521FD89D141B10E8B9827BA90B913DA84A5F424FBD92A24A");

          thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();
        }

        assignspectatortospectateplayer(self, var_0);
      }

      continue;
    }

    self._id_126CC = var_0;

    if(var_2 != var_0)
      self._id_126CC = var_2;

    if(self._id_126CC _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA()) {
      if(!_encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125EA())
        _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12522();

      continue;
    }

    if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1)
      logstring("_encstr_A55C22E0122C47F3B369B3A5521FD89D141B10E8B9827BA90B913DA84A5F424FBD92A24A");

    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();
  }
}

_id_126EC(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_95C0114B0F99BF33EB808AF230BF2E0FB1F9A5");
  return 1;
}

_id_12580() {
  var_0 = undefined;

  if(!istrue(self.spectatekillcam))
    var_0 = self getspectatingplayer();

  if(!isDefined(var_0) && isDefined(self._id_11E80))
    var_0 = self._id_11E80;

  if(!isDefined(var_0) && isDefined(self._id_126CC))
    var_0 = self._id_126CC;

  return var_0;
}

rotatetocurrentangles(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(vandalize_target_think(var_3)) {
      continue;
    }
    if(!istrue(var_3.br_spectatorinitialized)) {
      continue;
    }
    var_4 = var_3 _id_12580();

    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_11BE2(var_0, var_1, var_2) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  var_3 = regive_killstreak_after_use(var_0, var_1);

  if(var_2 && !istrue(var_0.gulag))
    var_0._id_11E80 = var_3;

  if(isDefined(var_3) || !istrue(level._encstr_82061D106BF2B7B046A9DDC72D77E133C5FBB8224E7CB8942543C150D98AC5))
    updateexistingspectatorsofvictim(var_0, var_3);
}

_id_125ED() {
  return isDefined(self._id_1391A) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() || istrue(self.tut_popup_listener) || istrue(self.respawningfromtoken);
}

updateexistingspectatorsofvictim(var_0, var_1) {
  var_2 = rotatetocurrentangles(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_1) && var_0.team == var_4.team && var_1.team != var_0.team && var_0 _id_125ED()) {
      assignspectatortospectateplayer(var_4, var_0);
      continue;
    }

    if(isDefined(var_4._id_11E80)) {
      var_4._id_11E80 = var_1;
      continue;
    }

    assignspectatortospectateplayer(var_4, var_1);
  }
}

updateactivespectatorcounts() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_3 = var_2 getspectatingplayer();

        if(isDefined(var_3)) {
          var_4 = var_3 getentitynumber();
          var_0[var_4] = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_0[var_4]) + 1;
        }
      }
    }

    var_6 = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_8 = var_2 getentitynumber();
        var_9 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_0[var_8]);
        var_10 = var_2 calloutmarkerping_entityzoffset("_encstr_9B1018EA5ABE899C7DB0363AA5B356AF370E59C6A3588EB74EDC");

        if(var_9 != var_10)
          var_2 setclientomnvar("_encstr_9B1018EA5ABE899C7DB0363AA5B356AF370E59C6A3588EB74EDC", var_9);

        var_6++;

        if(var_6 % 10 == 0)
          waitframe();
      }
    }

    wait 1.0;
  }
}

_id_143FA(var_0) {
  while(var_0.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
    waitframe();

  while(var_0.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
    waitframe();

  while(var_0.sessionstate != "_encstr_AF8C0A1B6A1D6045925B4F7D")
    waitframe();
}