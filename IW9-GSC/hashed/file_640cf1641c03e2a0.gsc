/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_640cf1641c03e2a0.gsc
***********************************************/

_id_CA39A413ACE3C168() {
  setDvar("dvar_0CC838A8EBB92734", 0);
  level._id_E578A787B54AD109 = spawnStruct();
  _id_97AF096F73D8367A();
  _id_07DCCCE8C87EA644();
  level thread _id_A6193FFD30278D98();
}

_id_97AF096F73D8367A() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  level._id_E578A787B54AD109._id_301D639DA97100C9 = scripts\engine\utility::getStructArray("para_landingSpot", "script_noteworthy");
}

_id_07DCCCE8C87EA644() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    while(level._id_B205D90302DA2F07.size == 0)
      waitframe();

    waitframe();

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      struct = spawnStruct();
      struct._id_E574839E9E50E6A7 = [];
      struct._id_932A9B3D757D01E9 = [];
      struct._id_301D639DA97100C9 = [];

      if(istrue(level._id_4CFD75AA6DDDE156)) {
        struct._id_E574839E9E50E6A7 = scripts\engine\utility::getStructArray("ac130_enter", "targetname");
        struct._id_932A9B3D757D01E9 = scripts\engine\utility::getStructArray("ac130_exit", "targetname");
        struct._id_301D639DA97100C9 = scripts\engine\utility::getStructArray("para_landingSpot", "script_noteworthy");
        level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"] = struct;
        continue;
      }

      struct._id_E574839E9E50E6A7 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("ac130_enter", "targetname"), _id_171F90B9C4C76D44);
      struct._id_932A9B3D757D01E9 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("ac130_exit", "targetname"), _id_171F90B9C4C76D44);
      struct._id_301D639DA97100C9 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("para_landingSpot", "script_noteworthy"), _id_171F90B9C4C76D44);
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"] = struct;
    }
  } else {
    level._id_E578A787B54AD109 = spawnStruct();
    level._id_E578A787B54AD109._id_E574839E9E50E6A7 = scripts\engine\utility::getStructArray("ac130_enter", "targetname");
    level._id_E578A787B54AD109._id_932A9B3D757D01E9 = scripts\engine\utility::getStructArray("ac130_exit", "targetname");
    level._id_E578A787B54AD109._id_301D639DA97100C9 = scripts\engine\utility::getStructArray("para_landingSpot", "script_noteworthy");
  }
}

_id_55AB9C6DA96226E7(_id_4AF808CB9330A11A, _id_C5E7FCE963586EC0, _id_3B496ABB2047566B, _id_EC862C2C00C7AB5D, priority, category, _id_1C9CB43BCF3EB16D, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_E7B52C5BAF6D8BE2, _id_94BA23284FA98C04, _id_8890C242B55DBFF1, _id_F891E067B8802C0D, tier, _id_4F200828059689DB, _id_8E5A9B658FA525ED) {
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    return;
  }
  if(!isDefined(_id_4AF808CB9330A11A))
    _id_4AF808CB9330A11A = 5;

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

  if(!isDefined(_id_4F200828059689DB))
    _id_4F200828059689DB = 2048;

  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = getclosestpointonnavmesh(_id_C5E7FCE963586EC0);
  _id_8AF454AAF592B9BA = _id_2673DB74633ED911(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);

  if(!isDefined(_id_8AF454AAF592B9BA))
    _id_8AF454AAF592B9BA = _id_C5E7FCE963586EC0;

  spawners = undefined;

  if(isDefined(_id_EC862C2C00C7AB5D) && isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F))
    spawners = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F;

  spawners = _id_984016D3B51024A2(_id_4AF808CB9330A11A, _id_8AF454AAF592B9BA, spawners, priority, category, _id_171F90B9C4C76D44, 512, tier, team, _id_8E5A9B658FA525ED);

  if(!isDefined(spawners) || spawners.size == 0) {
    return;
  }
  spawner = spawners[0];
  _id_A9B1DA94E346BBA3 = scripts\engine\utility::ter_op(isDefined(_id_3B496ABB2047566B), _id_3B496ABB2047566B, 7000);
  _id_1E4BCE6C927436E0 = spawner.parachute_land_origin + (0, 0, _id_A9B1DA94E346BBA3);

  if(!isDefined(_id_E7B52C5BAF6D8BE2))
    _id_E7B52C5BAF6D8BE2 = (0, randomintrange(1, 360), 0);

  _id_CD36C086AC42B7C6 = _id_1E4BCE6C927436E0 - anglesToForward(_id_E7B52C5BAF6D8BE2) * 512 * (_id_4AF808CB9330A11A / 2);
  _id_B8520B1249ABBB07 = undefined;

  if(!isDefined(_id_E7B52C5BAF6D8BE2))
    _id_B8520B1249ABBB07 = _id_9E7D8E0B07E473F0(_id_1E4BCE6C927436E0, _id_171F90B9C4C76D44);
  else
    _id_B8520B1249ABBB07 = _id_1E4BCE6C927436E0 - anglesToForward(_id_E7B52C5BAF6D8BE2) * 40000;

  if(istrue(_id_8890C242B55DBFF1)) {
    foreach(spawner in spawners)
    spawner.origin = _id_C5E7FCE963586EC0 + (0, 0, _id_A9B1DA94E346BBA3) + (randomfloatrange(-128, 128), randomfloatrange(-128, 128), 0);

    return _id_4F963624AABA7F77(spawners, team, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, _id_94BA23284FA98C04, _id_4F200828059689DB, _id_F891E067B8802C0D);
  } else {
    ac130 = _id_747AD1AB3322F8BC::_id_35669831B02DC8FA(_id_B8520B1249ABBB07, _id_CD36C086AC42B7C6, -2000);

    foreach(spawner in spawners)
    spawner.origin = ac130.origin;

    heading = vectorNormalize(_id_1E4BCE6C927436E0 - _id_B8520B1249ABBB07);
    _id_F7DF9B6A197040A2 = ac130.origin + heading * 60000;
    ac130 thread _id_747AD1AB3322F8BC::_id_16DFD690940AE271(_id_F7DF9B6A197040A2);
    return _id_4F963624AABA7F77(spawners, team, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, _id_94BA23284FA98C04, _id_4F200828059689DB, 1, ac130);
  }
}

_id_4F963624AABA7F77(spawners, team, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, _id_94BA23284FA98C04, _id_4F200828059689DB, _id_F891E067B8802C0D, ac130) {
  riders = [];
  _id_19FA2154A6002EC3 = 0;

  foreach(index, spawner in spawners) {
    spawner.script_demeanor = undefined;
    rider = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(spawner.aitype, spawner.origin, spawner.angles, priority, category, _id_1C9CB43BCF3EB16D, undefined, team, undefined, undefined, _id_F891E067B8802C0D, undefined, 0);

    if(isDefined(rider)) {
      rider._id_B582B10663B5B2A9 = 0;
      rider.spawnpoint = spawner;
      rider._id_48713689EB4DB4B4 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("paraReinforce", "onChutePull"))
        rider._id_48713689EB4DB4B4 = scripts\cp_mp\utility\script_utility::getsharedfunc("paraReinforce", "onChutePull");

      rider._id_55DDEB59DF2DEE74 = ::_id_FA870422EDEFD17D;
      rider._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;
      rider.ac130 = scripts\engine\utility::ter_op(isDefined(ac130), ac130, rider);
      rider thread _id_747AD1AB3322F8BC::create_paratrooper(_id_19FA2154A6002EC3, _id_4F200828059689DB);
      riders[riders.size] = rider;

      if(isDefined(_id_94BA23284FA98C04))
        thread[[_id_94BA23284FA98C04]](rider);

      rider setscriptablepartstate("skydiveVfx", "enabled", 0);
    }

    wait(randomfloatrange(0.1, 0.75));
  }

  return riders;
}

_id_6A8AD55C5A4036D1() {
  thread _id_120270BD0A747A35::_id_A5117518725DA028(self, self._id_C5E7FCE963586EC0, 768, undefined, 1024, 0);
}

_id_FA870422EDEFD17D() {
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playSound("mp_parachute_land_ally");
  self notify("para_landed");
  level thread _id_120270BD0A747A35::_id_05D96B05A065564E(self);
}

_id_984016D3B51024A2(_id_4AF808CB9330A11A, origin, spawners, priority, category, _id_171F90B9C4C76D44, _id_5D0B62DF4C7D5D12, tier, team, _id_8E5A9B658FA525ED) {
  if(!isDefined(category))
    category = "reinforcements";

  _id_0644D90DE7685F75 = _id_48814951E916AF89::_id_8C6DBB64C8E1603C(_id_4AF808CB9330A11A, category, origin, _id_171F90B9C4C76D44, 0);

  if(!_id_0644D90DE7685F75 && !_id_48814951E916AF89::_id_359F24553BDCCA92(_id_4AF808CB9330A11A, priority)) {
    return;
  }
  if(!isDefined(spawners)) {
    spawners = [];
    _id_EFA35DED043E4A0F = [];
    _id_3C6BEC636AC35DF8 = [-150, -75, 0, 75, 150];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 5; _id_AC0E5C4AC96AAA41++) {
        offset = (_id_3C6BEC636AC35DF8[_id_AC0E594AC96AA3A8], _id_3C6BEC636AC35DF8[_id_AC0E5C4AC96AAA41], 0);
        _id_1BDC9C3696CABF65 = spawnStruct();
        _id_1BDC9C3696CABF65.origin = origin + offset;
        landing_spot = getgroundposition(_id_1BDC9C3696CABF65.origin, 64);
        _id_EFA35DED043E4A0F[_id_EFA35DED043E4A0F.size] = _id_1BDC9C3696CABF65;
      }
    }

    _id_EFA35DED043E4A0F = scripts\engine\utility::array_randomize(_id_EFA35DED043E4A0F);
  } else
    _id_EFA35DED043E4A0F = spawners;

  if(_id_4AF808CB9330A11A > _id_EFA35DED043E4A0F.size)
    _id_4AF808CB9330A11A = _id_EFA35DED043E4A0F.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4AF808CB9330A11A; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_EFA35DED043E4A0F[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    spawners[_id_AC0E594AC96AA3A8] = _id_EFA35DED043E4A0F[_id_AC0E594AC96AA3A8];
    spawners[_id_AC0E594AC96AA3A8].angles = (0, 0, 0);
    spawners[_id_AC0E594AC96AA3A8].allow_momentum = 1;

    if(!isDefined(spawners[_id_AC0E594AC96AA3A8].parachute_land_origin)) {
      if(!isDefined(spawners[_id_AC0E594AC96AA3A8].origin))
        spawners[_id_AC0E594AC96AA3A8].origin = origin;

      spawners[_id_AC0E594AC96AA3A8].parachute_land_origin = spawners[_id_AC0E594AC96AA3A8].origin;
    }

    if(isDefined(spawners[_id_AC0E594AC96AA3A8].tier))
      tier = spawners[_id_AC0E594AC96AA3A8].tier;

    if(!isDefined(_id_8E5A9B658FA525ED)) {
      _id_8E5A9B658FA525ED = undefined;

      if(isDefined(level._id_72F834B3F8B2A366) && isDefined(level._id_72F834B3F8B2A366[team]))
        _id_8E5A9B658FA525ED = level._id_72F834B3F8B2A366[team];
    }

    if(!isDefined(spawners[_id_AC0E594AC96AA3A8].aitype)) {
      aitype = undefined;

      if(isDefined(spawners[_id_AC0E594AC96AA3A8].type))
        aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(spawners[_id_AC0E594AC96AA3A8].type, tier, _id_8E5A9B658FA525ED);
      else
        aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, _id_171F90B9C4C76D44, undefined, undefined, tier, _id_8E5A9B658FA525ED);

      spawners[_id_AC0E594AC96AA3A8].aitype = aitype;
    }
  }

  return spawners;
}

_id_2673DB74633ED911(origin, _id_171F90B9C4C76D44) {
  _id_0F32859820CD51FE = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin, 0, 1);

    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_301D639DA97100C9) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_301D639DA97100C9.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_301D639DA97100C9;
  } else {
    if(!isDefined(level._id_E578A787B54AD109._id_301D639DA97100C9) || level._id_E578A787B54AD109._id_301D639DA97100C9.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_E578A787B54AD109._id_301D639DA97100C9;
  }

  if(isDefined(origin)) {
    _id_BB1B37BC627CB745 = sortbydistance(level._id_E578A787B54AD109._id_301D639DA97100C9, origin);
    _id_0F32859820CD51FE = [];

    foreach(loc in _id_BB1B37BC627CB745) {
      dist = distance2dsquared(loc.origin, origin);

      if(dist > 65536 && dist < 2250000)
        _id_0F32859820CD51FE[_id_0F32859820CD51FE.size] = loc;
    }

    if(_id_0F32859820CD51FE.size > 0)
      return scripts\engine\utility::random(_id_0F32859820CD51FE).origin;
    else
      return _id_BB1B37BC627CB745[0].origin;
  }

  return scripts\engine\utility::random(_id_0F32859820CD51FE).origin;
}

_id_9E7D8E0B07E473F0(origin, _id_171F90B9C4C76D44) {
  _id_0F32859820CD51FE = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin, 0, 1);

    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_E574839E9E50E6A7) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_E574839E9E50E6A7.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_E574839E9E50E6A7;
  } else {
    if(!isDefined(level._id_E578A787B54AD109._id_E574839E9E50E6A7) || level._id_E578A787B54AD109._id_E574839E9E50E6A7.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_E578A787B54AD109._id_E574839E9E50E6A7;
  }

  return scripts\engine\utility::random(_id_0F32859820CD51FE).origin;
}

_id_1CD198F23CFFC84F(origin, _id_171F90B9C4C76D44) {
  _id_0F32859820CD51FE = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin, 0, 1);

    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_932A9B3D757D01E9) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_932A9B3D757D01E9.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["paraReinforceStruct"]._id_932A9B3D757D01E9;
  } else {
    if(!isDefined(level._id_E578A787B54AD109._id_932A9B3D757D01E9) || level._id_E578A787B54AD109._id_932A9B3D757D01E9.size == 0) {
      return;
    }
    _id_0F32859820CD51FE = level._id_E578A787B54AD109._id_932A9B3D757D01E9;
  }

  return scripts\engine\utility::random(_id_0F32859820CD51FE).origin;
}

_id_A6193FFD30278D98() {
  for(;;) {
    if(getdvarint("dvar_0CC838A8EBB92734", 0) == 1) {
      foreach(node in level._id_E578A787B54AD109._id_301D639DA97100C9)
      thread scripts\mp\utility\debug::drawsphere(node.origin, 64, 1, (0, 1, 0));
    }

    wait 1;
  }
}

_id_9DFD191F35F0C0EB() {
  for(;;) {
    if(getdvarint("dvar_2F74ED938AB306BA", 0) == 1) {
      foreach(node in level._id_E578A787B54AD109._id_301D639DA97100C9)
      thread scripts\mp\utility\debug::drawsphere(node.origin, 64, 1, (0, 1, 0));
    }

    wait 1;
  }
}