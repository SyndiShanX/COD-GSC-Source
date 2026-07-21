/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tutorial\br_tut_utility.gsc
***********************************************/

_encstr_A2560DD347ADAF339ACA5343CBD263(var_0, var_1, var_2) {
  level.ttlos_suppressasserts = 1;
  level._id_133E0 = 1;
  level.codcasterenabled = 0;
  level.prematchperiodend = 0;
  level.br_infils_disabled = 1;
  level.skipprematchdropspawn = 1;
  level.usegulag = 0;
  thread _encstr_91FA10B7B99D0BB656A3E583AC9359B0462F();
  thread _encstr_ABEC18B230A963EBD81641412103B3AE1BF0EB8AD0451DE7317D(var_0);

  if(isDefined(var_1) && isbuiltinfunction(var_1) || isDefined(var_2) && isbuiltinfunction(var_2))
    thread _encstr_B6BD1BA0D524F86DAAABBBB3CB83B990D1EF8B19BC8A9025038BA3972B(var_1, var_2);

  _encstr_97FE11C636AC16E4EBED3153AC363A5ACE95DC();
  level scripts\common\ui::lui_registercallback("_encstr_A3AF090768A9910F4118EF", ::_encstr_AC48164B3013CF837B1FADE3FD031A873828ABB30869353A);
  level scripts\common\ui::lui_registercallback("_encstr_A1211603730260D8BA8FB16BB48E28B62897E3A9EB3A45B8", ::_encstr_825824D1ABD1BD935A8563BAA32DC67B730B63C6B7C4A9AC36A32D9D59B9D8B7B5C1C62BA3B2);
  level._encstr_B82F1B89E68B51D9D83FB8C023E1139953CF7B0F3D02F341BC13E0F8EF = gettime();
}

_encstr_91FA10B7B99D0BB656A3E583AC9359B0462F() {
  while(!isDefined(level.disable_super_in_turret))
    waitframe();

  while(!isDefined(level.disable_super_in_turret.funcs))
    waitframe();

  level.disable_super_in_turret.funcs["_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB"] = ::_encstr_96610ECD11AB73C055386AB2D8A3BDE3;
}

_encstr_96610ECD11AB73C055386AB2D8A3BDE3() {}

_encstr_ABEC18B230A963EBD81641412103B3AE1BF0EB8AD0451DE7317D(var_0) {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);

    if(!isbot(var_1)) {
      var_1.delay_give_tactical_grenade = 0;
      var_1.manualoverridewindmaterial = 1;
      var_1.haspickedupplunderyet = 1;
      var_1.highlight_atvs_until_router = [];
      var_1 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);

      if(isDefined(var_0) && isbuiltinfunction(var_0))
        self[[var_0]](var_1);
    }
  }
}

_encstr_B6BD1BA0D524F86DAAABBBB3CB83B990D1EF8B19BC8A9025038BA3972B(var_0, var_1) {
  for(;;) {
    self waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_2);

    if(!isbot(var_2)) {
      if(isDefined(var_0) && isbuiltinfunction(var_0))
        self thread[[var_0]](var_2);

      if(isDefined(var_1) && isbuiltinfunction(var_1))
        var_2 thread _encstr_8D2B136F10B7B1C17147CBA77B2B10773B4DEF3455(var_1);

      break;
    }
  }
}

_encstr_8D2B136F10B7B1C17147CBA77B2B10773B4DEF3455(var_0) {
  self waittill("_encstr_B2110C63C02DC5E92388229F9D75");
  self[[var_0]]();
}

_encstr_AC48164B3013CF837B1FADE3FD031A873828ABB30869353A(var_0) {
  for(var_1 = 0; var_1 < level._encstr_924C0F7A3043412FC1B2E51B55488317A7; var_1++) {
    if(isDefined(level._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1]) && level._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1] < level._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_1])
      level _encstr_829915CFDFC0FF5E883B9D70B1C9A89BA78F10D3135DE8(var_1, 0, 1);
  }
}

_encstr_825824D1ABD1BD935A8563BAA32DC67B730B63C6B7C4A9AC36A32D9D59B9D8B7B5C1C62BA3B2(var_0) {
  for(var_1 = 0; var_1 < level._encstr_924C0F7A3043412FC1B2E51B55488317A7; var_1++) {
    if(isDefined(level._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1]) && level._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1] < level._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_1])
      level _encstr_829915CFDFC0FF5E883B9D70B1C9A89BA78F10D3135DE8(var_1, 1, 0);
  }
}

_encstr_843C15170B7383B4F038B571B008D7AADDB9C7D7E3287A(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::ismeleeing, var_0, var_1, var_2);
}

_encstr_B27D16D3F9827C54439229F07882FFBB53F31856EB23AA59(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::issprinting, var_0, var_1, var_2);
}

_encstr_AAC714DD16B4E8474B1B1BFA5ACDF5D45DB61CA5B976(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::isjumping, var_0, var_1, var_2);
}

_encstr_8A8C158FE7F25DC8196DF06ED4EB5919AA7331315FEAAC(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::ismantling, var_0, var_1, var_2);
}

_encstr_B61312E406CAB1DB39FB20C1975BF6F1232DD065(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::_encstr_BAB20867FF6812FF784D, var_0, var_1, var_2);
}

_encstr_A6011670592DBB952738954FD02BBF49257B534A681A2877(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::_encstr_8A1F0C4B9B364E7BBAB1435A3776, var_0, var_1, var_2);
}

_encstr_AF4215FB2741FB0BFFA54C07A47E89AF89CF5658D3D897(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::_encstr_BA6B0BA2A8D733AFE82D717EB4, var_0, var_1, var_2);
}

_encstr_BD4D15DB811B63ABF019A48F0B78393733F8D2736860F7(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::isshooting, var_0, var_1, var_2);
}

_encstr_A3E6104F58B08BBD28A05029F996C159A56B(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(scripts\mp\utility\player::isplayerads, var_0, var_1, var_2);
}

_encstr_8D9B16A4066F1811B93D1007F373D99B9B182F0204CC208C(var_0, var_1, var_2) {
  return _encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(::isreloading, var_0, var_1, var_2);
}

_encstr_8FD21AABE04AAC48A03BDC860B2124737FB2492237754E788D8D7ACC(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_2))
    var_2 = 0.1;

  if(!isDefined(var_0))
    return 0;

  var_4 = 0;

  if(isanimation(var_0)) {
    if(isDefined(var_3) && var_3 > 0) {
      for(var_5 = 0; var_5 < var_3; var_5 = var_5 + var_2) {
        if(var_1 call[[var_0]]()) {
          var_4 = 1;
          break;
        }

        wait(var_2);
      }
    } else {
      while(!var_1 call[[var_0]]())
        wait(var_2);

      var_4 = 1;
    }

    return var_4;
  } else {
    if(isDefined(var_3) && var_3 > 0) {
      for(var_5 = 0; var_5 < var_3; var_5 = var_5 + var_2) {
        if(var_1[[var_0]]()) {
          var_4 = 1;
          break;
        }

        wait(var_2);
      }
    } else {
      while(!var_1[[var_0]]())
        wait(var_2);

      var_4 = 1;
    }

    return var_4;
  }
}

_encstr_ACA5177B39731B1DFADB447791B34384FB9FF36328C4F7D9EB(var_0) {
  var_1 = var_0 + "_encstr_8A6F07AFD856C2D9CA";

  if(!scripts\engine\utility::flag_exist(var_1))
    scripts\engine\utility::flag_init(var_1);

  thread _encstr_B1EA19ABA20B2910DBCAC107328DB83CC167A0D13B22E34F19253B(var_0, var_1);
  scripts\engine\utility::flag_wait(var_1);

  for(;;) {
    scripts\engine\utility::flag_clear(var_1);
    wait 0.25;

    if(!scripts\engine\utility::flag(var_1)) {
      self notify("_encstr_BDC50E6E3ADBE0F56BF6372DA37B4E7D" + var_0);
      break;
    }
  }
}

_encstr_B1EA19ABA20B2910DBCAC107328DB83CC167A0D13B22E34F19253B(var_0, var_1) {
  self endon("_encstr_BDC50E6E3ADBE0F56BF6372DA37B4E7D" + var_0);
  var_2 = scripts\engine\utility::getent_or_struct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    for(;;) {
      var_2 waittill("_encstr_8F5C086405E70FBA4B4A");
      scripts\engine\utility::flag_set(var_1);
    }
  }
}

_encstr_B6F3299B1C97CF8120D09D2908C1233B97C748A704525B414A37512016C31353803F8D7ACF338F69CBF0D7(var_0, var_1, var_2, var_3) {
  for(;;) {
    var_4 = scripts\engine\utility::getent_or_struct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_4)) {
      var_4 waittill("_encstr_8F5C086405E70FBA4B4A");
      level.player sethudtutorialmessage(var_0);

      if(isDefined(var_3))
        level.player playlocalsound(var_3);
      else
        level.player playlocalsound("_encstr_889B0D8E563C1DFA4CF6C3FAE62BEE");

      _encstr_ACA5177B39731B1DFADB447791B34384FB9FF36328C4F7D9EB(var_1);
      level.player clearhudtutorialmessage();

      if(var_2 == 1)
        return;
    }
  }
}

_encstr_BA6B0BA2A8D733AFE82D717EB4() {
  if(!isPlayer(self))
    return 0;

  return self getstance() == "_encstr_A5AD069B231F0BAF";
}

_encstr_8A1F0C4B9B364E7BBAB1435A3776() {
  if(!isPlayer(self))
    return 0;

  return self getstance() == "_encstr_B13D076BED70539F23";
}

_encstr_BAB20867FF6812FF784D() {
  if(!isPlayer(self))
    return 0;

  return self getstance() == "_encstr_922406F1A6FD5E05";
}

isshooting() {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self.watch_for_players_touching_ground))
    return 0;

  return gettime() - self.watch_for_players_touching_ground < 400;
}

_encstr_A1DD0F231FC230BFD7030815F3FAF1B0BF(var_0, var_1) {
  return var_0 == scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_getpoolidnavigation();
}

_encstr_A2F00DBBA79A5E201DA60B83CCCE90(var_0, var_1) {
  return scripts\cp\vehicles\little_bird_mg_cp::addpostlaunchspawns(var_0) || scripts\cp\vehicles\little_bird_mg_cp::addplundercarrycredit(var_0);
}

_encstr_8C970C969BB0275B7B271CD2DCEC(var_0, var_1) {
  if(!_encstr_A2F00DBBA79A5E201DA60B83CCCE90(var_0, var_1))
    return 0;

  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isarmorplate(var_1.type);
}

_encstr_96FA0DAFEFBC5261781875FAF0A0AF(var_0, var_1) {
  if(!_encstr_A2F00DBBA79A5E201DA60B83CCCE90(var_0, var_1))
    return 0;

  return scripts\engine\utility::string_starts_with(var_1.type, "_encstr_9A8E0E89C9D8F6DB3AEBDD2BB0E0B79B");
}

_encstr_87A80E61EF48D5DF2D30E27A3B8BF38F(var_0, var_1) {
  return scripts\cp\vehicles\little_bird_mg_cp::addplayeraslootleader(var_0) || isent(var_1) && scripts\cp\vehicles\little_bird_mg_cp::additionalrecondronetargets(var_1, level.player);
}

_encstr_91C01648E2AC1173A76439B8509B19B3177B91F81A057FAB(var_0) {
  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(!isDefined(var_1) || var_1 != "_encstr_9584181FB9CDB0781F8310998B0F25186219BD9F1F763835679A") {
      continue;
    }
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isDefined(var_0)) {
      return;
    }
    var_3 = self calloutmarkerping_getsavedzoffset(var_2);

    if([[var_0]](var_2, var_3) == 1)
      return;
  }
}

add_objective(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E))
    self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E = [];

  if(!isDefined(self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D))
    self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D = [];

  if(!isDefined(self._encstr_ABD4115876E025B7EB134B7F028FE00FF3303B))
    self._encstr_ABD4115876E025B7EB134B7F028FE00FF3303B = [];

  if(!isDefined(self._encstr_924C0F7A3043412FC1B2E51B55488317A7) || self._encstr_924C0F7A3043412FC1B2E51B55488317A7 <= var_0)
    self._encstr_924C0F7A3043412FC1B2E51B55488317A7 = var_0 + 1;

  self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0] = 0;
  self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_0] = var_2;
  self._encstr_ABD4115876E025B7EB134B7F028FE00FF3303B[var_0] = var_1;
  self._encstr_861317B8892257CFE85F1CCD9A09F1B57FFAFCEFB28F48672E[var_0] = var_4;
  thread _encstr_B8A81F77230A1DA8CCE40B61018D90C092C3FFD53F32DD08F371539BB678A08D7B(var_3, var_0);
}

_encstr_B8A81F77230A1DA8CCE40B61018D90C092C3FFD53F32DD08F371539BB678A08D7B(var_0, var_1) {
  self endon("_encstr_A1211603730260D8BA8FB16BB48E28B62897E3A9EB3A45B8");
  self endon("_encstr_A3AF090768A9910F4118EF");

  for(;;) {
    self[[var_0]]();

    if(_encstr_B8F718C99F2BB03847753BB01F247055813F557527F2EDA0764F(var_1)) {
      break;
    }
  }
}

_encstr_829915CFDFC0FF5E883B9D70B1C9A89BA78F10D3135DE8(var_0, var_1, var_2) {
  var_3 = getsystemtime();
  var_4 = var_3 - self._encstr_AD0916AAB83A50EB3BB0E8D1AB7976DCA856049803649D89;

  if(var_1 == 0 && var_2 == 0)
    self._encstr_AD0916AAB83A50EB3BB0E8D1AB7976DCA856049803649D89 = var_3;

  self.players[0] dlog_recordplayerevent("_encstr_A5DF1E153DD2EFF67DCB20702BAF6B338B65962BD6BAD7B8228338E033A1635B", ["_encstr_878405507B07A3", self._encstr_8A371547E8B06532E1BB8B479E8F2A3AF9680F3B9808DD, "_encstr_9A2B0A12F03587575B7BBEA5", self._encstr_861317B8892257CFE85F1CCD9A09F1B57FFAFCEFB28F48672E[var_0], "_encstr_B83D0B8F635BB750B937DDD73F", var_4, "_encstr_A9F80907252ACB994257E0", self.player.origin[0], "_encstr_8CF809E8AA3683D9B3DF3B", self.player.origin[1], "_encstr_B1F8090B117753A5285E30", self.player.origin[2], "_encstr_B2130B38D816BC954EBE2FB0EE", scripts\engine\utility::getplayeryaw(self.player), "_encstr_BAC40D7AA5604AC723A9E3BA1386C4", scripts\engine\utility::getplayerpitch(self.player), "_encstr_82DF09529087D947935FE3", var_1, "_encstr_A3AF090768A9910F4118EF", var_2]);
}

_encstr_91E2184F81C54927938BB99993808D833F10769FB0917123FF83(var_0, var_1, var_2, var_3, var_4) {
  level._encstr_8C0312DE13D4B28DE8B4D9B2B9EA4B9C592CC8BC = 0;
  setomnvar("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", var_0 + 1 << 8);
  self._encstr_AD0916AAB83A50EB3BB0E8D1AB7976DCA856049803649D89 = getsystemtime();
  self._encstr_8A371547E8B06532E1BB8B479E8F2A3AF9680F3B9808DD = var_1;
  var_5 = 0;

  for(;;) {
    var_6 = tablelookupbyrow(var_2, var_5, 0);

    if(var_6 == "_encstr_B40101") {
      break;
    }

    var_7 = int(var_6);

    if(var_7 == var_0) {
      var_8 = tablelookupbyrow(var_2, var_5, 1);

      if(var_8 == "_encstr_B40101") {
        iprintln("_encstr_A628272AAAA8402A494AA74A7410DA96B9E64B739D02F698A6566C8E96D9594A220458D140E4BDEE04" + var_5);
        return;
      }

      var_9 = int(var_8);
      var_10 = tablelookupbyrow(var_2, var_5, 3);
      var_11 = 1;

      if(var_10 == "_encstr_B40101") {} else
        var_11 = int(var_10);

      var_12 = tablelookupbyrow(var_2, var_5, 4);
      add_objective(var_9, var_8, var_11, var_3[var_9], var_12);
    }

    var_5++;
  }

  if(isDefined(var_4))
    thread _encstr_83491C5BEDDC4BE87B9CAF7B984DCA361DA5B359B9AF074EDBEC3995379B(var_4);

  level._encstr_8C0312DE13D4B28DE8B4D9B2B9EA4B9C592CC8BC = 1;
}

_encstr_83491C5BEDDC4BE87B9CAF7B984DCA361DA5B359B9AF074EDBEC3995379B(var_0) {
  var_1 = 15000;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  while(!_encstr_84331D8BA10F2E0F15025880BAEBCB816749017107D73145FF8A70A06347DF()) {
    if(var_2 != _encstr_B865194D7BB88FFA701B7B0363A5C2EC8180C6D491306C92D4130F()) {
      _encstr_A573226369C5044F31520FA351A2834B63873B037772D6A3A0902B438D491FCA90DF4BAE::_encstr_A33A0DCF334F8907CE0187D08C2B89();
      var_3 = gettime();
      var_2 = _encstr_B865194D7BB88FFA701B7B0363A5C2EC8180C6D491306C92D4130F();
      var_4 = 0;
    } else if(gettime() - var_3 > var_1) {
      if(!var_4) {
        _encstr_A573226369C5044F31520FA351A2834B63873B037772D6A3A0902B438D491FCA90DF4BAE::_encstr_8D870E4BDD4EAB201790F958124B1389(var_0);
        var_4 = 1;
      }
    }

    wait 0.1;
  }
}

_encstr_97FE11C636AC16E4EBED3153AC363A5ACE95DC() {
  self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E = undefined;
  self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D = undefined;
  self._encstr_ABD4115876E025B7EB134B7F028FE00FF3303B = undefined;
  self._encstr_924C0F7A3043412FC1B2E51B55488317A7 = 0;
  self._encstr_AD0916AAB83A50EB3BB0E8D1AB7976DCA856049803649D89 = 0;
  setomnvar("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", 0);
}

_encstr_88821496738DC9596B56E647D7BD264D568D3AA56795(var_0) {
  self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0]++;

  while(!level._encstr_8C0312DE13D4B28DE8B4D9B2B9EA4B9C592CC8BC)
    wait 0.1;

  if(self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0] < self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_0])
    setomnvarbit("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", var_0, 0);
  else {
    setomnvarbit("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", var_0, 1);

    if(!_encstr_84331D8BA10F2E0F15025880BAEBCB816749017107D73145FF8A70A06347DF())
      _encstr_8C3115388DC25ED7363495B1D68DB4DC3AAFE67BAECD19(0);
  }

  if(isDefined(self._encstr_861317B8892257CFE85F1CCD9A09F1B57FFAFCEFB28F48672E[var_0]))
    _encstr_829915CFDFC0FF5E883B9D70B1C9A89BA78F10D3135DE8(var_0, 0, 0);

  waitframe();

  if(_encstr_84331D8BA10F2E0F15025880BAEBCB816749017107D73145FF8A70A06347DF()) {
    _encstr_8C3115388DC25ED7363495B1D68DB4DC3AAFE67BAECD19(1);
    self notify("_encstr_A1211603730260D8BA8FB16BB48E28B62897E3A9EB3A45B8");
  }
}

_encstr_B8F718C99F2BB03847753BB01F247055813F557527F2EDA0764F(var_0) {
  if(var_0 < self._encstr_924C0F7A3043412FC1B2E51B55488317A7) {
    if(self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0] >= self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_0])
      return 1;
  }

  return 0;
}

_encstr_B865194D7BB88FFA701B7B0363A5C2EC8180C6D491306C92D4130F() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self._encstr_924C0F7A3043412FC1B2E51B55488317A7; var_1++) {
    if(isDefined(self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1]) && self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_1] >= self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_1])
      var_0++;
  }

  return var_0;
}

_encstr_84331D8BA10F2E0F15025880BAEBCB816749017107D73145FF8A70A06347DF() {
  for(var_0 = 0; var_0 < self._encstr_924C0F7A3043412FC1B2E51B55488317A7; var_0++) {
    if(isDefined(self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0]) && self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0] < self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_0])
      return 0;
  }

  return 1;
}

_encstr_860613CF65E301C0273A0E30F2630DA8BBF165B31B() {
  return self._encstr_924C0F7A3043412FC1B2E51B55488317A7;
}

_encstr_A2D817ECCAD1AFD195871DD733EDC9BE7BC435B2D81D5ACE2B(var_0) {
  var_1 = "_encstr_8507034357";

  if(_encstr_B8F718C99F2BB03847753BB01F247055813F557527F2EDA0764F(var_0))
    var_1 = "_encstr_8C0703262F";

  return var_1 + self._encstr_ABD4115876E025B7EB134B7F028FE00FF3303B[var_0] + "_encstr_AC0703C532" + self._encstr_81D118F6894D958D8E2DD959B9FAB06C8EB4EC567DD87BABB98E[var_0] + "_encstr_874C029E" + self._encstr_B11716DBC4A9568D8E96B359B9FA3BDBB063FAC6DE5DE61D[var_0];
}

_encstr_B2F717946D02FBE783EBEB9ABBB541BDBFFBC90BA732C2AE8F(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3)
  thread _encstr_AC600F104BE96B5D89EADDDE8503AD5155(var_5, var_2);
}

_encstr_AC600F104BE96B5D89EADDDE8503AD5155(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = 15.0;

  for(;;) {
    if(!isDefined(var_0._encstr_A5CF0C1B0F2B20E543E7BBB33BCB)) {
      wait(var_1);
      var_2 = var_0.script_noteworthy;

      if(isDefined(var_2)) {
        var_0._encstr_A5CF0C1B0F2B20E543E7BBB33BCB = easepower(var_2, var_0.origin, var_0.angles);
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_0._encstr_A5CF0C1B0F2B20E543E7BBB33BCB);
      }

      continue;
    }

    wait 1.0;
  }
}

init_doors(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2)
  _encstr_B25C0AF058FAD341F90FE7BB(var_4);
}

_encstr_B25C0AF058FAD341F90FE7BB(var_0) {
  if(isDefined(var_0.initialized)) {
    return;
  }
  var_0.heli_intro = var_0.angles;

  if(isDefined(level.player)) {
    var_1 = vectorNormalize(level.player.origin - var_0.origin);

    if(isDefined(var_0.right)) {
      var_2 = vectordot(var_0.right, var_1);
      var_3 = var_2 > 0;
    } else
      var_3 = 1;

    var_0._id_1211F = scripts\engine\utility::ter_op(var_3, var_0.heli_intro - (0, 90, 0), var_0.heli_intro + (0, 90, 0));
  }

  if(isDefined(var_0.target)) {
    var_4 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      switch (var_6.classname) {
        case "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C":
          var_0.clip = var_6;
          var_0.clip linkTo(var_0);
          break;
        case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
          var_0._id_1211F = var_6.angles;
          var_6 delete();
          break;
        default:
          break;
      }
    }
  }

  var_0.initialized = 1;
}

open_door(var_0, var_1) {
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    _encstr_A33711F77367B507C5E0A1A0CB778E81989852(var_4, var_1);
  }

  var_6 = getentitylessscriptablearrayinradius(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_6)) {
    foreach(var_4 in var_6)
    var_4 _encstr_8E881ACBE01DAC33635782B47D2E2B757F937182E09BA2AF9B4B87BE("_encstr_ADB405071B8AE8", var_1);
  }
}

_encstr_A33711F77367B507C5E0A1A0CB778E81989852(var_0, var_1) {
  if(isDefined(var_0.opened) && var_0.opened == 1) {
    return;
  }
  if(!isDefined(var_0.initialized))
    _encstr_B25C0AF058FAD341F90FE7BB(var_0);

  switch (var_0.classname) {
    case "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9":
    case "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C":
    case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
      if(isDefined(var_1))
        thread scripts\engine\utility::play_sound_in_space(var_1, var_0.origin + (0, 0, 30));

      var_0.opened = 1;
      var_0 rotateTo(var_0._id_1211F, 1, 0.2, 0.8);
      break;
    default:
      var_0.opened = 1;
      waitframe();
      break;
  }
}

_id_12116(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1.clip)) {
    var_1.clip = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1.clip linkTo(var_1);
  }

  var_2 = 90;

  if(isDefined(var_1.script_parameters))
    var_2 = float(var_1.script_parameters);

  var_3 = var_1.origin + anglestoright(var_1.angles) * var_2;
  var_4 = 2.8;
  thread scripts\engine\utility::play_sound_in_space("_encstr_A1290CC0EAE3CBEE83652A224DFB", var_1.origin);
  wait 0.55;
  thread scripts\engine\utility::play_sound_in_space("_encstr_B63F1855332BD7E812C7A920D74C01F9E11F40504A316F93EDCB", var_1.origin);
  var_1 moveTo(var_3, var_4, var_4 * 0.1, var_4 * 0.9);

  if(isDefined(var_1.clip)) {
    if(var_1.clip.spawnflags & 1)
      var_1.clip connectpaths();
  }
}

_encstr_831D17F5F31FFF3A3727DBC78338C733078E640DFE74A5B838(var_0) {
  var_1 = self;

  if(!var_1 scriptabledoorisclosed()) {
    return;
  }
  var_1 scriptabledoorfreeze(var_0);
}

close_door(var_0, var_1) {
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    _encstr_9A6A1206EC887FB8C6CA68D9D84BD231A34FB7DB(var_4, var_1);
  }

  var_6 = getentitylessscriptablearrayinradius(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_6)) {
    foreach(var_4 in var_6)
    var_4 _encstr_8E881ACBE01DAC33635782B47D2E2B757F937182E09BA2AF9B4B87BE("_encstr_88950636C6DE9B59", var_1);
  }
}

_encstr_9A6A1206EC887FB8C6CA68D9D84BD231A34FB7DB(var_0, var_1) {
  if(!isDefined(var_0.opened) || var_0.opened == 0) {
    return;
  }
  if(!isDefined(var_0.initialized))
    _encstr_B25C0AF058FAD341F90FE7BB(var_0);

  switch (var_0.classname) {
    case "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9":
    case "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C":
    case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
      if(isDefined(var_1))
        thread scripts\engine\utility::play_sound_in_space(var_1, var_0.origin + (0, 0, 30));

      var_0.opened = 0;
      var_0 rotateTo(var_0.heli_intro, 1, 0.2, 0.8);
      break;
    default:
      var_0.closed = 1;
      waitframe();
      break;
  }
}

_encstr_996119DB0B437742F1257F379889BA372B893F5388FBA99B23B085(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 50;

  var_4 = getEntArray(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_4[0].origin, var_2, "_encstr_B16705D9AFE22E");

  if(var_5.size == 0) {}

  foreach(var_7 in var_5)
  var_7 thread _encstr_8E881ACBE01DAC33635782B47D2E2B757F937182E09BA2AF9B4B87BE(var_0, var_3);
}

_encstr_8E881ACBE01DAC33635782B47D2E2B757F937182E09BA2AF9B4B87BE(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1))
    thread scripts\engine\utility::play_sound_in_space(var_1, var_2.origin + (0, 0, 30));

  switch (var_0) {
    case "_encstr_928A072D2BB2553895":
      var_2 scriptabledoorfreeze(1);
      break;
    case "_encstr_97EF05D134C2BB":
      var_2 scriptabledoorfreeze(0);
      break;
    case "_encstr_ADB405071B8AE8":
      if(var_2 scriptabledoorisclosed())
        var_2 constraintoscriptgoalRadius();

      break;
    case "_encstr_88950636C6DE9B59":
      if(!var_2 scriptabledoorisclosed())
        var_2 vehicle_getinputvalue();

      break;
    case "_encstr_ACAD05F147D03F":
      if(!var_2 scriptabledoorisclosed()) {
        var_2 vehicle_getinputvalue();

        while(!var_2 scriptabledoorisclosed())
          waitframe();
      }

      var_2 scriptabledoorfreeze(1);
      break;
  }
}

_encstr_A5251BF848264C23F80AE1C3CA6BB9BAA7DA7EF7A0B34F58AD404FC308(var_0, var_1) {
  var_2 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(var_3 == level.player) {
      scripts\engine\utility::flag_set(var_1);
      break;
    }
  }
}

_encstr_A14A16F35BCBE7F01717A1E1517830367FB3ABF8B22F2D18() {
  self endon("_encstr_B419059BD17BE0");
  var_0 = self;

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "_encstr_B16705D9AFE22E")
      _encstr_A3B913027178ADD360017F075508DBE2C899BF0F0B();

    if(isstartstr(self.script_parameters, "_encstr_86B206F81AF31772"))
      thread _encstr_82101A5B66A01F5A454259D7B8B9D1E22423B19A183FA1494093D24F();
  }

  if(!scripts\engine\utility::flag_exist(self.script_triggername))
    scripts\engine\utility::flag_init(self.script_triggername);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 == level.player) {
      if(isDefined(self.script_parameters) && self.script_parameters == "_encstr_884806B91ADEE8CD")
        var_1 thread _encstr_96BF164BE3670C80EFC2177FF6591843D71BA6F1BAD3B5D0(self.script_triggername);
      else
        scripts\engine\utility::flag_set(self.script_triggername);

      break;
    }
  }
}

_encstr_8C5E1536DEC232D70E1B5897B293FA3AC9B4EC9D59C96E(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 thread _encstr_A14A16F35BCBE7F01717A1E1517830367FB3ABF8B22F2D18();
}

_encstr_A3101530F54B8F20E9421972DDF1273280C3F9FA623FD5(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon(var_0);

  for(;;) {
    wait 0.5;

    if(!self scriptabledoorisclosed()) {
      scripts\engine\utility::flag_set(var_0);
      break;
    }
  }
}

_encstr_A3B913027178ADD360017F075508DBE2C899BF0F0B() {
  var_0 = self;
  var_1 = 75;

  if(isDefined(var_0.script_radius))
    var_1 = int(var_0.script_radius);

  var_2 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, var_1, "_encstr_B16705D9AFE22E");

  if(!isDefined(var_2) || var_2.size != 1) {
    return;
  }
  var_2[0] thread _encstr_A3101530F54B8F20E9421972DDF1273280C3F9FA623FD5(var_0.script_triggername);
}

_encstr_82101A5B66A01F5A454259D7B8B9D1E22423B19A183FA1494093D24F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon(self.script_triggername);
  var_0 = int(getsubstr(self.script_parameters, 5));

  while(!isDefined(level._encstr_AF8C0B39AD0C5048D23F43536F))
    wait 0.5;

  for(;;) {
    wait 0.5;
    var_1 = 0;

    foreach(var_3 in level._encstr_AF8C0B39AD0C5048D23F43536F) {
      if(isalive(_encstr_85EA240BBFE82443BDE3664AAB386B9B703F8269D340FDC3669ECBF333787BD588AF46EF4FD0::_encstr_B60F0B198D2CA1ED82BBA39167(var_3)))
        var_1 = var_1 + 1;
    }

    if(var_1 < var_0) {
      break;
    }
  }

  scripts\engine\utility::flag_set(self.script_triggername);
}

_encstr_96BF164BE3670C80EFC2177FF6591843D71BA6F1BAD3B5D0(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon(var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  if(!isDefined(self.watch_for_players_touching_ground)) {
    return;
  }
  var_1 = gettime();

  for(;;) {
    wait 0.1;

    if(self.watch_for_players_touching_ground - var_1 > 0) {
      scripts\engine\utility::flag_set(var_0);
      return;
    }
  }
}

_encstr_8FAE1623CAC4AECED7DCD0DEBBAFB65838F589DE57E68C9B(var_0) {
  if(getdvarint("_encstr_A29715CB508E676A3AC6330A9AEB5F0F2365DDDB9BCAE3", 0) == 0) {
    return;
  }
  for(;;) {
    var_1 = (level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[0][1], var_0);
    var_2 = (level.br_level.br_mapbounds[1][0], level.br_level.br_mapbounds[0][1], var_0);
    var_3 = (level.br_level.br_mapbounds[1][0], level.br_level.br_mapbounds[1][1], var_0);
    var_4 = (level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[1][1], var_0);
    var_5 = (level.br_level.delay_set_bomber_traversals[0][0], level.br_level.delay_set_bomber_traversals[0][1], var_0);
    var_6 = (level.br_level.delay_set_bomber_traversals[1][0], level.br_level.delay_set_bomber_traversals[0][1], var_0);
    var_7 = (level.br_level.delay_set_bomber_traversals[1][0], level.br_level.delay_set_bomber_traversals[1][1], var_0);
    var_8 = (level.br_level.delay_set_bomber_traversals[0][0], level.br_level.delay_set_bomber_traversals[1][1], var_0);
    waitframe();
  }
}

circletimer(var_0) {
  return 1;
}

_encstr_AF841788CFCBCB11CFAB1F8230B55B91906ECB588D1BCB7735() {
  while(level.player calloutmarkerping_entityzoffset("_encstr_A9F113AEA5EB4C4EFAC2E4B5BD4EEBC2DABDBA3747") < 1)
    wait 0.1;

  level._encstr_99160AD72DEAC0329396EFE0 = 1;
}

_encstr_8C3115388DC25ED7363495B1D68DB4DC3AAFE67BAECD19(var_0) {
  if(!isDefined(self._encstr_B82F1B89E68B51D9D83FB8C023E1139953CF7B0F3D02F341BC13E0F8EF))
    self._encstr_B82F1B89E68B51D9D83FB8C023E1139953CF7B0F3D02F341BC13E0F8EF = gettime();

  if(self._encstr_B82F1B89E68B51D9D83FB8C023E1139953CF7B0F3D02F341BC13E0F8EF + 0.25 < gettime() || var_0) {
    self._encstr_B82F1B89E68B51D9D83FB8C023E1139953CF7B0F3D02F341BC13E0F8EF = gettime();

    if(var_0)
      level.player playSound("_encstr_9A0714D843AC1BB6C64BB98EFAD8DB5B0ED859D1CA23");
    else
      level.player playSound("_encstr_B6E60F64B31055C19EF797DBC9B5BB95C0");
  }
}