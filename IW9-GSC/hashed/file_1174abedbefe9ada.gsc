/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1174abedbefe9ada.gsc
***********************************************/

_id_03ACF5939A1DB7A7() {
  level._id_33A2175A9A4306BC = spawnStruct();
  level._id_33A2175A9A4306BC._id_ED47175EEC456EB2 = [getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "startDamage"), 1), getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "spreadingDamage"), 1), getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "finalDamage"), 10)];
  level._id_33A2175A9A4306BC._id_E4F5EA2D49FF1661 = [getdvarfloat(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "startTickTime"), 1.5), getdvarfloat(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "spreadingTickTime"), 1), getdvarfloat(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "finalTickTime"), 1.5)];
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14 = [];
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["angles"] = (getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "originAngleOffsetX"), 14000), getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "originAngleOffsetY"), 14000), 0);
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["origin"] = (getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "originOffsetX"), 9000), getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "originOffsetY"), 9000), 0);
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["spread"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "originSpread"), 4500);
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["maxDist"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "maxDistFromOrigin"), 10000);
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["minDistFromPOI"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "minDistFromPOI"), 11000);
  level._id_33A2175A9A4306BC._id_7FA6D03261608E14["minDistFromSpawn"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "minDistFromSpawn"), 4200);
  level._id_33A2175A9A4306BC._id_17DEA46B55390175 = [];
  level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "startingRadius"), 4000);
  level._id_33A2175A9A4306BC._id_17DEA46B55390175["final"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "finalRadius"), 150000);
  level._id_33A2175A9A4306BC._id_17DEA46B55390175["expTime"] = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "expansionSeconds"), 1200);
  level._id_33A2175A9A4306BC._id_C7D7B451939F1592 = getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "innerRadius"), 0.9);
  level._id_03C96ED7246169C1 = getdvarint("dvar_5B07F4C484333549", 1) == 1;
  level._id_33A2175A9A4306BC._id_693E7D2A8DB6A09D = [40, 75, 100];
  level._id_33A2175A9A4306BC._id_850942263638B598 = 0;
  level._id_33A2175A9A4306BC._id_378D3B538B839D2C = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "dmz_isPointInCircle", ::_id_076EF3C8B8171D2D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("radiation", "radiation_isInit", ::_id_DFA94748AF73C087);
  scripts\cp_mp\utility\script_utility::registersharedfunc("radiation", "radiation_signedDistanceFromRadiationCircle", ::_id_ACC2B78CBA84B235);
  scripts\cp_mp\utility\script_utility::registersharedfunc("radiation", "radiation_isInRadiation", ::_id_26879895DB23C779);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "spawnAtStart"), 1))
    _id_E97390ED5BC4FE34();
}

_id_E97390ED5BC4FE34() {
  level._id_33A2175A9A4306BC _id_A430BF4DDE5DEAA8();
  level._id_33A2175A9A4306BC thread _id_68D3D5B73680C590();
  level._id_33A2175A9A4306BC thread _id_A75A30F41AF1D381();
  level._id_33A2175A9A4306BC thread _id_131E36DA68551999();
  level._id_33A2175A9A4306BC thread _id_94224CF552A24537();
  level._id_33A2175A9A4306BC thread _id_6F9619ADB55E091E();
  level._id_33A2175A9A4306BC thread _id_3CB6790904A3C7D1();
  scripts\mp\flags::gameflaginit("radiation_initialized", 1);
}

_id_A430BF4DDE5DEAA8() {
  origin = _id_DBF56756677D1AE1();
  _id_4673B0931E86514C = "Radiation_Dmz";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    _id_4673B0931E86514C = "Radiation_SM_Dmz";

  if(!isDefined(level._id_33A2175A9A4306BC._id_C075862F37971025)) {
    level._id_33A2175A9A4306BC._id_C075862F37971025 = spawnbrcircle(origin[0], origin[1], level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"]);
    level._id_33A2175A9A4306BC scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_4673B0931E86514C, origin, level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"]);
    level._id_33A2175A9A4306BC scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  } else
    level._id_33A2175A9A4306BC scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(origin);

  _id_9D8AD1FF0851C781(origin);
  _id_BC92DD8EE5D9B16D(level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"]);
}

_id_DBF56756677D1AE1() {
  while(!isnavmeshloaded() || !isDefined(level._id_C40817516B7D2B68) || level._id_C40817516B7D2B68.size <= 0 || !isDefined(level._id_ACF99124377543BB) || level._id_ACF99124377543BB.size <= 0)
    waitframe();

  waitframe();
  _id_8DCEB312A7518E72 = getdvarvector(_func_2EF675C13CA1C4AF("dvar_1829A1208C528E73", "forceOrigin"), (0, 0, 0));

  if(_id_8DCEB312A7518E72 != (0, 0, 0))
    return _id_8DCEB312A7518E72;

  points = [];

  foreach(set in level._id_C40817516B7D2B68) {
    if(isDefined(set.points)) {
      foreach(point in set.points) {
        if(isDefined(point.origin))
          points[points.size] = point;
      }
    }

    if(isDefined(set.origin))
      points[points.size] = set;
  }

  _id_9A288A2EBA51E253 = [];
  _id_43E62C00C7A5C99C = undefined;
  _id_4C8A5AC107F58D50 = undefined;
  _id_8E3A406071EAA1B0 = _id_5B97E85E94D918A6(points);
  _id_C46A79729CBA49DE = [];

  foreach(_id_B205D90302DA2F07, origin in level._id_ACF99124377543BB) {
    if(!issubstr(_id_B205D90302DA2F07, "suburb"))
      _id_C46A79729CBA49DE[_id_C46A79729CBA49DE.size] = origin;
  }

  if(isDefined(level._id_2CDF30478FA435FF)) {
    foreach(loc in level._id_2CDF30478FA435FF) {
      _id_05956C54E54EBF3D = 1;

      foreach(start in points) {
        if(distance2d(start.origin, loc) < level._id_33A2175A9A4306BC._id_7FA6D03261608E14["minDistFromSpawn"]) {
          _id_05956C54E54EBF3D = 0;
          break;
        }
      }

      if(_id_05956C54E54EBF3D)
        _id_9A288A2EBA51E253[_id_9A288A2EBA51E253.size] = loc;
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 40; _id_AC0E594AC96AA3A8++) {
      angle = randomfloatrange(0, 360);
      _id_B58BA569FFDA4497 = (cos(angle) * level._id_33A2175A9A4306BC._id_7FA6D03261608E14["angles"][0], sin(angle) * level._id_33A2175A9A4306BC._id_7FA6D03261608E14["angles"][1], 0) + _id_8E3A406071EAA1B0;
      _id_B58BA569FFDA4497 = _id_B58BA569FFDA4497 + (randomfloat(level._id_33A2175A9A4306BC._id_7FA6D03261608E14["origin"][0]) - level._id_33A2175A9A4306BC._id_7FA6D03261608E14["spread"], randomfloat(level._id_33A2175A9A4306BC._id_7FA6D03261608E14["origin"][1]) - level._id_33A2175A9A4306BC._id_7FA6D03261608E14["spread"], 0);
      _id_1172565ABB556A22 = _id_EF14A88BA5763880(_id_B58BA569FFDA4497, _id_C46A79729CBA49DE);
      _id_0803BC6C7002F79A = _id_EF14A88BA5763880(_id_B58BA569FFDA4497, points);
      _id_C72ADF2F44963EDF = distance2d((0, 0, 0), _id_B58BA569FFDA4497);

      if(_id_C72ADF2F44963EDF < level._id_33A2175A9A4306BC._id_7FA6D03261608E14["maxDist"]) {
        continue;
      }
      if(isDefined(_id_0803BC6C7002F79A) && _id_0803BC6C7002F79A > level._id_33A2175A9A4306BC._id_7FA6D03261608E14["minDistFromSpawn"] && isDefined(_id_1172565ABB556A22) && _id_1172565ABB556A22 > level._id_33A2175A9A4306BC._id_7FA6D03261608E14["minDistFromPOI"])
        _id_9A288A2EBA51E253[_id_9A288A2EBA51E253.size] = _id_B58BA569FFDA4497;

      if(isDefined(_id_0803BC6C7002F79A) && (!isDefined(_id_4C8A5AC107F58D50) || _id_0803BC6C7002F79A > _id_4C8A5AC107F58D50)) {
        _id_4C8A5AC107F58D50 = _id_1172565ABB556A22;
        _id_43E62C00C7A5C99C = _id_B58BA569FFDA4497;
      }
    }
  }

  origin = undefined;

  if(_id_9A288A2EBA51E253.size > 0)
    origin = scripts\engine\utility::random(_id_9A288A2EBA51E253);
  else if(isDefined(_id_43E62C00C7A5C99C))
    origin = _id_43E62C00C7A5C99C;
  else {
    angle = randomfloatrange(0, 360);
    origin = (cos(angle) * 5000, sin(angle) * 5000, 0);
  }

  return origin;
}

_id_E32A9BA4AA8F9FA8() {
  if(!_id_DFA94748AF73C087()) {
    return;
  }
  level._id_33A2175A9A4306BC._id_9957C36D26B92420 = 1;
}

_id_A01F654E559EE5EC() {
  if(!_id_DFA94748AF73C087()) {
    return;
  }
  level notify("dmz_radiation_started");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_radiation_spreading", level.players);
  setomnvar("ui_dmz_radiation_spreading", 1);
  level _id_EA5FB9090223B855(level._id_33A2175A9A4306BC.origin, level._id_33A2175A9A4306BC._id_17DEA46B55390175["final"], level._id_33A2175A9A4306BC._id_17DEA46B55390175["expTime"]);
  _id_378499DB9E139E34();
  level._id_33A2175A9A4306BC._id_009BADBB469626F6 = 1;
  timer = 600;

  if(isDefined(level._id_C5074BF13FFB95EF)) {
    _id_755BC4C5615671AF = _id_2A0C5B28DDED3E06();
    _id_1E6C96F9D4B225C4 = distance2d(level._id_C5074BF13FFB95EF.origin, level._id_33A2175A9A4306BC.origin) - level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"];
    timer = _id_1E6C96F9D4B225C4 / _id_755BC4C5615671AF;
    timer = timer - level._id_C7825757649C018E;
  }

  if(isDefined(level._id_CEDD53BFC3112D91))
    timer = level._id_CEDD53BFC3112D91;

  wait 2;
  level._id_06FC3398B5A13400 = gettime() + int((timer - 2) * 1000);
  setomnvar("ui_hardpoint_timer", level._id_06FC3398B5A13400);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("radiation_start_spread", level.players);
  level thread _id_4C74B6FE35DADC38();
  wait(timer);
  level notify("dmz_radiation_complete");
}

_id_4C74B6FE35DADC38() {
  level endon("game_ended");
  wait 1.5;
  _id_5F5F6114C9D25A18 = 23622;

  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }
    _id_972D1889BBE8CC7C = _id_ACC2B78CBA84B235(player.origin);

    if(_id_972D1889BBE8CC7C > _id_5F5F6114C9D25A18) {
      continue;
    }
    player thread _id_4576AE886852CBFE();
  }
}

_id_4576AE886852CBFE() {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("successful_exfil");

  if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
    _id_C4DB1877814DA988 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_final_classic");
    player setplayermusicstate(_id_C4DB1877814DA988);
  } else {
    _id_C4DB1877814DA988 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_final");
    player setplayermusicstate(_id_C4DB1877814DA988);
  }

  wait 90;

  if(!istrue(player._id_2441210FE6EEA080) && !istrue(player.extracted))
    player setplayermusicstate("");
}

_id_28F7A303238284EE() {
  return isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6);
}

_id_A75A30F41AF1D381() {
  level endon("game_ended");

  for(;;) {
    _id_3C0AD5FCE1B17F47();
    waitframe();
  }
}

_id_68D3D5B73680C590() {
  level endon("game_ended");

  for(;;) {
    _id_2F4C37EDB355CFCC();
    _id_C621C1A0A40CA1BE();
    wait 1;
  }
}

_id_3CB6790904A3C7D1() {
  wait(max(180, getdvarint("scr_br_timelimit", 1800) - 180));
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("radiation_winds_picking_up", level.players);
}

_id_C621C1A0A40CA1BE() {
  if(istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    return;
  }
  foreach(player in level._id_33A2175A9A4306BC._id_378D3B538B839D2C) {
    if(isDefined(player) && isDefined(player.origin) && _id_1AA28AD2C858D3D7(player.origin)) {
      level._id_33A2175A9A4306BC._id_378D3B538B839D2C = scripts\engine\utility::array_remove(level._id_33A2175A9A4306BC._id_378D3B538B839D2C, player);

      if(scripts\cp_mp\gasmask::hasgasmask(player))
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("radiation_approach_with_gas_mask", [player]);
      else
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("radiation_approach", [player]);

      continue;
    }

    if(!isDefined(player))
      level._id_33A2175A9A4306BC._id_378D3B538B839D2C = scripts\engine\utility::array_remove(level._id_33A2175A9A4306BC._id_378D3B538B839D2C, player);
  }
}

_id_94224CF552A24537() {
  level endon("game_ended");

  for(;;) {
    if(istrue(level._id_289DF80E1DED586F)) {
      if(isDefined(level.agentarray)) {
        _id_87FEAEF653A8C7DA = scripts\engine\utility::array_randomize(level.agentarray);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_87FEAEF653A8C7DA.size; _id_AC0E594AC96AA3A8++) {
          if(_id_AC0E594AC96AA3A8 % 3 == 0)
            waitframe();

          agent = _id_87FEAEF653A8C7DA[_id_AC0E594AC96AA3A8];

          if(isDefined(agent) && isalive(agent) && _id_26879895DB23C779(agent.origin))
            _id_6153AD0458D8F809(agent);
        }
      }
    }

    wait 1;
  }
}

_id_6153AD0458D8F809(agent) {
  if(istrue(agent._id_65771500F49956C1)) {
    return;
  }
  damage = _id_D6EEDDEF703CE569();
  damagemultiplier = scripts\engine\utility::ter_op(isDefined(agent.maxhealth), agent.maxhealth * 0.01, 1);
  agent dodamage(int(damage * damagemultiplier), agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "torso_upper");

  if(!isalive(agent)) {
    return;
  }
  _id_01011B2AA6F43C79(agent);
}

_id_6F9619ADB55E091E() {
  for(;;) {
    damage = _id_D00E59CFB504DA1A();

    if(!isDefined(damage)) {
      return;
    }
    foreach(player in level.players) {
      if(isDefined(player)) {
        if(isDefined(player.origin) && !istrue(player.plotarmor) && _id_26879895DB23C779(player.origin) && !istrue(player._id_E6204058F06B94E5))
          _id_C4A3072CE7B3F1FD(player, damage);
      }
    }

    wait(_id_E083E00474123EF3());
  }
}

_id_C4A3072CE7B3F1FD(player, damage, _id_A9D135071A6DC843) {
  if(_id_156835EF9924856A::_id_3ABD8504E2419FCE(player)) {
    if(level._id_03C96ED7246169C1)
      damage = 0;
    else
      damage = player _id_156835EF9924856A::_id_AC74FF0686D2886E(damage);
  }

  if(!istrue(_id_A9D135071A6DC843) && scripts\cp_mp\gasmask::hasgasmask(player) && damage > 0)
    player scripts\cp_mp\gasmask::processdamage(damage);
  else if(damage > 0) {
    if(player scripts\mp\utility\killstreak::isjuggernaut())
      damage = _id_29C32B7117E01180::modifybrgasdamage(damage);

    player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
    player _id_07C40FA80892A721::damagearmor(damage);

    if(randomint(100) >= 60)
      player thread _id_2695A20D4011076D::tryplaycoughaudio();
  }
}

_id_D00E59CFB504DA1A() {
  return level._id_33A2175A9A4306BC._id_ED47175EEC456EB2[level._id_33A2175A9A4306BC._id_850942263638B598] + scripts\engine\utility::_id_53C4C53197386572(level._id_33A2175A9A4306BC._id_28DA8386C5007CB1, 0);
}

_id_9BC063861B9330F1(damage) {
  if(!_id_DFA94748AF73C087()) {
    return;
  }
  if(!isDefined(level._id_33A2175A9A4306BC._id_28DA8386C5007CB1))
    level._id_33A2175A9A4306BC._id_28DA8386C5007CB1 = 0;

  level._id_33A2175A9A4306BC._id_28DA8386C5007CB1 = level._id_33A2175A9A4306BC._id_28DA8386C5007CB1 + int(damage);
}

_id_D6EEDDEF703CE569() {
  return level._id_33A2175A9A4306BC._id_693E7D2A8DB6A09D[level._id_33A2175A9A4306BC._id_850942263638B598];
}

_id_E083E00474123EF3() {
  return level._id_33A2175A9A4306BC._id_E4F5EA2D49FF1661[level._id_33A2175A9A4306BC._id_850942263638B598];
}

_id_378499DB9E139E34() {
  level._id_33A2175A9A4306BC._id_850942263638B598 = int(min(level._id_33A2175A9A4306BC._id_850942263638B598 + 1, level._id_33A2175A9A4306BC._id_ED47175EEC456EB2.size - 1));
}

_id_EA5FB9090223B855(_id_D4CF75E8A617D80C, goalradius, _id_2FB858D06D406750) {
  level._id_33A2175A9A4306BC._id_D4CF75E8A617D80C = _id_D4CF75E8A617D80C;
  level._id_33A2175A9A4306BC.goalradius = goalradius;
  level._id_33A2175A9A4306BC._id_2FB858D06D406750 = _id_2FB858D06D406750;
  level._id_33A2175A9A4306BC.startorigin = level._id_33A2175A9A4306BC.origin;
  level._id_33A2175A9A4306BC._id_ACC4F45C61ED5FF1 = level._id_33A2175A9A4306BC.radius;
  level._id_33A2175A9A4306BC._id_9421D616EE332897 = 0;
  level._id_33A2175A9A4306BC._id_C075862F37971025 brcirclemoveTo(_id_D4CF75E8A617D80C[0], _id_D4CF75E8A617D80C[1], goalradius, _id_2FB858D06D406750);
}

_id_770129186512680C(pos) {
  _id_607A972C1F87910A = distance2d(pos, level._id_33A2175A9A4306BC.startorigin);
  _id_9ED6827753DB2370 = (level._id_33A2175A9A4306BC._id_17DEA46B55390175["final"] - level._id_33A2175A9A4306BC.origin) / level._id_33A2175A9A4306BC._id_17DEA46B55390175["expTime"];
  return _id_607A972C1F87910A / _id_9ED6827753DB2370;
}

_id_2A0C5B28DDED3E06() {
  return (level._id_33A2175A9A4306BC._id_17DEA46B55390175["final"] - level._id_33A2175A9A4306BC._id_17DEA46B55390175["starting"]) / level._id_33A2175A9A4306BC._id_17DEA46B55390175["expTime"];
}

_id_3C0AD5FCE1B17F47() {
  if(!isDefined(level._id_33A2175A9A4306BC._id_2FB858D06D406750) || !isDefined(level._id_33A2175A9A4306BC._id_9421D616EE332897) || level._id_33A2175A9A4306BC._id_9421D616EE332897 > level._id_33A2175A9A4306BC._id_2FB858D06D406750) {
    return;
  }
  _id_CD9EB3EBDB1CFFA0 = level._id_33A2175A9A4306BC._id_9421D616EE332897 / level._id_33A2175A9A4306BC._id_2FB858D06D406750;

  if(isDefined(level._id_33A2175A9A4306BC._id_D4CF75E8A617D80C) && isDefined(level._id_33A2175A9A4306BC.startorigin))
    _id_9D8AD1FF0851C781(vectorlerp(level._id_33A2175A9A4306BC.startorigin, level._id_33A2175A9A4306BC._id_D4CF75E8A617D80C, _id_CD9EB3EBDB1CFFA0));

  if(isDefined(level._id_33A2175A9A4306BC.goalradius) && isDefined(level._id_33A2175A9A4306BC._id_ACC4F45C61ED5FF1))
    _id_BC92DD8EE5D9B16D(scripts\engine\math::lerp(level._id_33A2175A9A4306BC._id_ACC4F45C61ED5FF1, level._id_33A2175A9A4306BC.goalradius, _id_CD9EB3EBDB1CFFA0));

  level._id_33A2175A9A4306BC._id_9421D616EE332897 = level._id_33A2175A9A4306BC._id_9421D616EE332897 + level.framedurationseconds;
}

_id_131E36DA68551999() {
  level endon("game_ended");

  for(;;) {
    if(istrue(level._id_289DF80E1DED586F) && (istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6) || istrue(level._id_33A2175A9A4306BC._id_9957C36D26B92420))) {
      _id_9F14E5AD8CAC3258 = scripts\engine\utility::array_randomize(level.agentarray);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9F14E5AD8CAC3258.size; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 % 3 == 0)
          waitframe();

        agent = _id_9F14E5AD8CAC3258[_id_AC0E594AC96AA3A8];

        if(isDefined(agent) && isDefined(agent.origin) && isalive(agent) && _id_A47ED2D2B0485893(agent.origin))
          _id_01011B2AA6F43C79(agent);
      }

      wait 5;
      continue;
    }

    wait 5;
  }
}

_id_01011B2AA6F43C79(agent) {
  _id_193A6F23EE4897C4 = _id_106F0ECFA08284CD(agent.origin) * 2000;
  _id_2E74A81498D831F9 = agent.origin - (_id_193A6F23EE4897C4[0], _id_193A6F23EE4897C4[1], 0);
  _id_8DE8F1B340A002BE = getclosestpointonnavmesh(_id_2E74A81498D831F9);

  if(length(_id_2E74A81498D831F9 - _id_8DE8F1B340A002BE) > 1000) {
    if(scripts\mp\agents\agent_utility::iscivilian(agent))
      agent _meth_B661B022700BA72F("systemic", 0);

    return;
  }

  if(scripts\mp\agents\agent_utility::iscivilian(agent))
    agent _meth_B661B022700BA72F("script", 1);

  thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_2E74A81498D831F9);
}

_id_2F4C37EDB355CFCC() {
  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.origin) && scripts\cp_mp\gasmask::hasgasmask(player) && !istrue(player.gasmaskswapinprogress)) {
      if(_id_26879895DB23C779(player.origin)) {
        player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("radiation");
        continue;
      }

      player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("radiation");
    }
  }
}

_id_1509B788F4410B94(player) {
  if(_id_DFA94748AF73C087()) {
    level._id_33A2175A9A4306BC._id_378D3B538B839D2C = scripts\engine\utility::array_add(level._id_33A2175A9A4306BC._id_378D3B538B839D2C, player);
    player thread _id_FF259762D4378A33();
  }
}

_id_FF259762D4378A33() {
  self endon("disconnect");

  for(;;) {
    if(istrue(self.extracted)) {
      return;
    }
    if(_id_DFA94748AF73C087() && scripts\mp\utility\player::isreallyalive(self)) {
      _id_744AF42B66F6D746 = _id_55436CE00AB60754(self.origin);

      if(isDefined(_id_744AF42B66F6D746)) {
        self playlocalsound("iw9_mp_radiation_tick");
        wait(_id_744AF42B66F6D746);
      } else
        wait 1;

      continue;
    }

    wait 1;
  }
}

_id_55436CE00AB60754(_id_1CFCCAC3E5778BBB) {
  _id_80BC91A54F223618 = _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB);

  if(_id_80BC91A54F223618 < level._id_33A2175A9A4306BC._id_77D736BCAD3660A0)
    return randomfloatrange(0.05, 0.2);
  else if(_id_80BC91A54F223618 < level._id_33A2175A9A4306BC._id_D7F903BDC28D6F6F)
    return randomfloatrange(0.1, 0.25);
  else if(_id_80BC91A54F223618 < level._id_33A2175A9A4306BC._id_13609B12CABEAA49)
    return randomfloatrange(0.15, 0.45);
  else if(_id_80BC91A54F223618 < level._id_33A2175A9A4306BC._id_1CB5A1B1DDCF5E52)
    return randomfloatrange(0.2, 0.8);

  return undefined;
}

_id_EF14A88BA5763880(origin, nodes) {
  if(!isDefined(origin))
    return undefined;

  _id_636C8575D7A7768B = undefined;

  foreach(node in nodes) {
    dist = undefined;

    if(isvector(node))
      dist = distance2d(node, origin);
    else if(isDefined(node.origin))
      dist = distance2d(node.origin, origin);

    if(isDefined(dist) && (!isDefined(_id_636C8575D7A7768B) || dist < _id_636C8575D7A7768B))
      _id_636C8575D7A7768B = dist;
  }

  return _id_636C8575D7A7768B;
}

_id_F3FB60F986F267C5() {
  if(_id_DFA94748AF73C087())
    return level._id_33A2175A9A4306BC.origin;
}

_id_5CE400665EE103F9() {
  if(_id_DFA94748AF73C087())
    return level._id_33A2175A9A4306BC.radius;
}

_id_9D8AD1FF0851C781(origin) {
  level._id_33A2175A9A4306BC scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(origin);
  level._id_33A2175A9A4306BC.origin = origin;
}

_id_BC92DD8EE5D9B16D(radius) {
  level._id_33A2175A9A4306BC scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(radius);
  level._id_33A2175A9A4306BC.radius = radius;
  level._id_33A2175A9A4306BC._id_153347A332086343 = level._id_33A2175A9A4306BC.radius * 0.9;
  level._id_33A2175A9A4306BC._id_4DC2E5CF9D2F5BA6 = level._id_33A2175A9A4306BC.radius * 0.75;
  level._id_33A2175A9A4306BC._id_17944FCCB70BB441 = level._id_33A2175A9A4306BC.radius * level._id_33A2175A9A4306BC._id_C7D7B451939F1592;
  level._id_33A2175A9A4306BC._id_AA30A34E39048796 = level._id_33A2175A9A4306BC.radius * 1.25;
  level._id_33A2175A9A4306BC._id_1CB5A1B1DDCF5E52 = level._id_33A2175A9A4306BC.radius * 1.4;
  level._id_33A2175A9A4306BC._id_13609B12CABEAA49 = level._id_33A2175A9A4306BC.radius * 1.15;
  level._id_33A2175A9A4306BC._id_D7F903BDC28D6F6F = level._id_33A2175A9A4306BC.radius * 1.0;
  level._id_33A2175A9A4306BC._id_77D736BCAD3660A0 = level._id_33A2175A9A4306BC.radius * 0.3;
  level._id_33A2175A9A4306BC._id_5169808B5E9BFA77 = level._id_33A2175A9A4306BC.radius * 1.3;
}

_id_A47ED2D2B0485893(_id_1CFCCAC3E5778BBB) {
  _id_A01833997C5F87A9 = _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB);
  return _id_A01833997C5F87A9 < level._id_33A2175A9A4306BC._id_AA30A34E39048796 && _id_A01833997C5F87A9 > level._id_33A2175A9A4306BC._id_17944FCCB70BB441;
}

_id_26879895DB23C779(_id_1CFCCAC3E5778BBB) {
  return _id_DFA94748AF73C087() && _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) < level._id_33A2175A9A4306BC.radius;
}

_id_130808A5EA3B1A16(_id_1CFCCAC3E5778BBB) {
  return _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) < level._id_33A2175A9A4306BC._id_153347A332086343;
}

_id_C757B7694243CC8F(_id_1CFCCAC3E5778BBB) {
  return _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) < level._id_33A2175A9A4306BC._id_4DC2E5CF9D2F5BA6;
}

_id_1AA28AD2C858D3D7(_id_1CFCCAC3E5778BBB) {
  return _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) < level._id_33A2175A9A4306BC._id_5169808B5E9BFA77;
}

_id_CDCAB1374DB7F007(_id_1CFCCAC3E5778BBB) {
  if(_id_DFA94748AF73C087())
    return _id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) < level._id_33A2175A9A4306BC.radius + 1500;
  else
    return 0;
}

_id_485B5A399DEF53D0(_id_1CFCCAC3E5778BBB) {
  return distance2d(_id_1CFCCAC3E5778BBB, level._id_33A2175A9A4306BC.origin);
}

_id_ACC2B78CBA84B235(origin) {
  return distance2d(origin, level._id_33A2175A9A4306BC.origin) - level._id_33A2175A9A4306BC.radius;
}

_id_106F0ECFA08284CD(origin) {
  return vectorNormalize(level._id_33A2175A9A4306BC.origin - origin);
}

_id_5B97E85E94D918A6(points) {
  _id_3C590D0EE220B409 = undefined;
  _id_C978C90E8E5AB1F7 = undefined;
  _id_3C590C0EE220B1D6 = undefined;
  _id_C978C80E8E5AAFC4 = undefined;

  foreach(point in points) {
    if(!isDefined(_id_3C590D0EE220B409) || point.origin[0] < _id_3C590D0EE220B409)
      _id_3C590D0EE220B409 = point.origin[0];

    if(!isDefined(_id_C978C90E8E5AB1F7) || point.origin[0] > _id_C978C90E8E5AB1F7)
      _id_C978C90E8E5AB1F7 = point.origin[0];

    if(!isDefined(_id_3C590C0EE220B1D6) || point.origin[1] < _id_3C590C0EE220B1D6)
      _id_3C590C0EE220B1D6 = point.origin[1];

    if(!isDefined(_id_C978C80E8E5AAFC4) || point.origin[1] > _id_C978C80E8E5AAFC4)
      _id_C978C80E8E5AAFC4 = point.origin[1];
  }

  return ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
}

_id_076EF3C8B8171D2D(origin) {
  if(_id_DFA94748AF73C087())
    return _id_26879895DB23C779(origin);
  else
    return _id_2695A20D4011076D::_id_024C5A8D31AE262F(origin);
}

_id_DFA94748AF73C087() {
  return isDefined(level._id_33A2175A9A4306BC) && isDefined(level._id_33A2175A9A4306BC.origin);
}