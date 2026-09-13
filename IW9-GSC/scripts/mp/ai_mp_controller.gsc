/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_mp_controller.gsc
***********************************************/

init() {
  if(istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  level._id_289DF80E1DED586F = 1;
  level._id_BDB4D0CD41B1C39D = getdvarint("dvar_ACF59B5E363165C0", scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508());
  level._id_3A89274682239C28 = gettime();
  level._id_7318150D8DC474EA = -1;
  _id_35DE402EFC5ACFB3::init_battlechatter();
  _id_2AD704F5066D8674::main();
  level._id_7DC093FB71342953["prone"] = 1200;
  level._id_7DC093FB71342953["crouch"] = 1800;
  level._id_7DC093FB71342953["stand"] = 2400;
  level._id_3B0034EB96B13650["prone"] = 2000;
  level._id_3B0034EB96B13650["crouch"] = 3200;
  level._id_3B0034EB96B13650["stand"] = 6000;
  level._id_8F3F480583606401["prone"] = 1.2;
  level._id_8F3F480583606401["crouch"] = 1.25;
  level._id_8F3F480583606401["stand"] = 1.3;
  level._id_33CF4079B4096EB8 = getdvarint("dvar_935057B8878CA60C", 1);
  level._id_1BDF3AF6B78DC2CA = getdvarint("dvar_DB81671BBB108B36", 2);
  level._id_8912CCAD342445F7 = getdvarint("dvar_F34E4FBAEB441E24", 2048);
  level._id_E38979EB8FD7F7FD = getdvarint("dvar_E0BF53C6689C5A5C", 24);
  level._id_6BA4985B66D62A71 = getdvarint("dvar_7632DAB7786BD590", 33);
  level._id_7EB56682F591EA8D = getdvarint("dvar_81420364EA25C1EA", 80);
  level._id_9CF526926A72864C = getdvarint("dvar_7ACE3F07AE09FAA9", 17);
  level._id_0E2FBC9E65108B1E = getdvarint("dvar_A3642102F1C5F0AF", 75);
  level._id_47AEDB539717AEA5 = getdvarint("dvar_CCB7C4B155A770F8", 60);
  level._id_4899061E2E21DD13 = getdvarfloat("dvar_B98593547931BA38", 0.6);
  level._id_3E6588E7A225A933 = getdvarint("dvar_9AD5DBDD1DFB3FAC", 3);
  level._id_1B4461E4447DA676 = 0;
  level._id_58AC9EBCF7B87B73 = 0;
  level._id_2EF1C744D35B6312 = getdvarint("dvar_BBB1BDDAA8B9B5E3", 45);
  level._id_D362D0481275DE02 = getdvarint("dvar_A28FC6FEFECA8D04", 30) * 1000;
  level._id_EC80E35C609C1533 = getdvarint("dvar_8A59524527D46B22", 15);
  level._id_8A7245A12448052F = getdvarint("dvar_61A7DE4B7ED90249", 35);
  level._id_A3A884994E83CDBA = getdvarint("dvar_0F7D2F280613A39D", 50);
  level._id_18C5FA4FDEBE1971 = getdvarint("dvar_63DCE1152BB58B16", 65);
  level._id_69173C5E957CCCFF = getdvarint("dvar_D3907CDE9245B595", 1);
  level._id_EF668B618C1C7EC0 = getdvarint("dvar_FB2F8A1043BA19AE", 3);
  level._id_9C981303803AEAB3 = getdvarint("dvar_C50D996D34978B41", 25);
  level._id_5DCCCC815E25C8E2 = getdvarint("dvar_65C413F748899D7F", 10);
  level._id_96ABDB45AEE491FC = getdvarint("dvar_9A629AEB212FA5EB", 10);
  level._id_9D28D5B70AA9F5E4 = _id_120270BD0A747A35::_id_9D28D5B70AA9F5E4;
  _id_371B4C2AB5861E62::_id_03BDEB9EDD6C6F0A();
  _id_4799BFBFBA0CF995();
  _id_371B4C2AB5861E62::_id_B04C0433E8107615();
  _id_7662ACE137F157E5();
  _id_41BA451876D0900C::_id_9A7305EA8EE1E807();
  dialog_init();
  _id_0346DC7F701823DC();
  _id_371B4C2AB5861E62::_id_A09756B37F2E0681();
  _id_01E3A27C2E002CA8();
  _id_0BD14655B29F9A64();
  _id_A09C0A759D909DC9();
  level thread _id_D2D3DDD52666DCF0();
  level thread _id_44B2BAD96489DF87();
  _id_75425E32A1700C73();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level thread _id_003EE960C1C0C8E4();
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "agentPers_getAgentPersData", _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "agentPers_setAgentPersData", _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "subArea_removeAgentFrom", ::_id_C65D2D9103FB2B4A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "ai_deregisterAgent", ::_id_1E5307C0D848A9CA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "ai_registerAgent", ::_id_157C2000284999EB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "priority_removeByDormancyId", ::_id_A12C7E6BF3EBA1ED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "priority_setByDormancyId", ::_id_6FDAD75E06D99A21);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "subArea_findAndAssignForDormancyID", ::_id_ED1DF18568977A9B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "processAgentSpawned", ::_id_50375D63A38A8F8F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage", _id_120270BD0A747A35::_id_580A150BA253DE13);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent", ::_id_EA94A8BF24D3C5EF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "handleDamageFeedback", scripts\mp\damage::handledamagefeedback);
  _id_120270BD0A747A35::_id_2585B1944B7884C0();

  if(getdvarint("dvar_5A01142D62D08A10", 1) == 1)
    _func_401D0838F4F47C3E(1);

  level thread _id_BC423135571B28C1();
}

_id_35BAE74232FF8B77(val) {
  level._id_BDB4D0CD41B1C39D = val;

  foreach(agent in level.agentarray) {
    if(isDefined(agent))
      agent.ignoreall = val;
  }
}

_id_2B36368B8B1B2B30(val) {
  level._id_ED524AE7534D93E6 = val;
}

_id_3C44B8551D08AC1D() {
  level._id_ED524AE7534D93E6 = undefined;
}

_id_003EE960C1C0C8E4() {
  while(!isDefined(level.stealth))
    waitframe();

  setsaveddvar("dvar_AE9C969DF88E37E1", 3000);
  setsaveddvar("dvar_F72CE39DD23B00D1", 3000);
  setsaveddvar("dvar_CDA36D9770CF5189", 128);
  level.stealth._id_792E4B9A380ADE11 = 3000;
  level.stealth._id_094F8771062F2161 = 3000;
  level.stealth._id_E2E3C78D7DC88605 = 16384;
  scripts\stealth\utility::set_detect_ranges(level._id_7DC093FB71342953, level._id_3B0034EB96B13650, level._id_8F3F480583606401);
}

_id_0BD14655B29F9A64() {
  level.spawnset = [];
  level._id_3B54ADCD8ED5B8C0 = [];
  level._id_C0E1DE2E14E458BF = "guard";

  if(!isDefined(level._id_BBC459244382AE0F))
    level._id_BBC459244382AE0F = getDvar("dvar_63C67BEB18BD058D", "mp/spawnset_tuning_base.csv");

  if(!tableexists(level._id_BBC459244382AE0F)) {
    return;
  }
  table = level._id_BBC459244382AE0F;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; istrue(_id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA); _id_AC0E594AC96AA3A8++) {
    _id_FCDC7F62624C71FF = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0));

    if(!isDefined(level.spawnset[_id_FCDC7F62624C71FF]))
      level.spawnset[_id_FCDC7F62624C71FF] = [];

    aitype = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 1));
    _id_C3D87E6AF7949475 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 2);

    if(_id_C3D87E6AF7949475 == "0") {
      continue;
    }
    if(isDefined(_id_C3D87E6AF7949475)) {
      if(!isDefined(level._id_3B54ADCD8ED5B8C0[_id_FCDC7F62624C71FF]))
        level._id_3B54ADCD8ED5B8C0[_id_FCDC7F62624C71FF] = [];

      level._id_3B54ADCD8ED5B8C0[_id_FCDC7F62624C71FF][aitype] = int(_id_C3D87E6AF7949475);
    }

    level.spawnset[_id_FCDC7F62624C71FF][level.spawnset[_id_FCDC7F62624C71FF].size] = aitype;
  }

  foreach(index, _id_D562339438CEC85C in level._id_3B54ADCD8ED5B8C0) {
    _id_BF63953D990800D2 = 0;

    foreach(_id_302E82DA1A1989AD in _id_D562339438CEC85C) {
      if(_id_302E82DA1A1989AD != 0)
        _id_BF63953D990800D2 = 1;
    }

    if(!_id_BF63953D990800D2)
      level._id_3B54ADCD8ED5B8C0[index] = undefined;
  }
}

_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED) {
  if(!isDefined(_id_1439F86640D42E34))
    _id_1439F86640D42E34 = "ar";

  if(!isDefined(_id_7CA24826046F8EE3))
    _id_7CA24826046F8EE3 = 1;

  if(_id_7CA24826046F8EE3 > 3)
    _id_7CA24826046F8EE3 = 3;
  else if(_id_7CA24826046F8EE3 < 1)
    _id_7CA24826046F8EE3 = 1;

  if(!isDefined(_id_8E5A9B658FA525ED))
    _id_8E5A9B658FA525ED = _id_F851A2F41CFFA860();

  if(_id_1439F86640D42E34 == "jugg")
    return "enemy_mp_" + _id_1439F86640D42E34 + "_" + _id_8E5A9B658FA525ED;

  return "enemy_mp_" + _id_1439F86640D42E34 + "_tier" + _id_7CA24826046F8EE3 + "_" + _id_8E5A9B658FA525ED;
}

_id_01E3A27C2E002CA8() {
  level.agent_funcs["soldier"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::callbacksoldieragentdamaged;
  level.agent_funcs["soldier"]["gametype_on_killed"] = scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut"]["on_damaged"] = _id_47FC06D4BB326007::_id_0507D39027ACAF53;
  level.agent_funcs["juggernaut"]["gametype_on_killed"] = scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
}

_id_EA94A8BF24D3C5EF(_id_DCF5E15C58C4152A, _id_CAED821D95874BBB, spawnangles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_5A6A87FA3F95753F, _id_5F0C541B305BF851, _id_80F4BDE7090A4773, _id_D9F5556107463BB5, _id_D1CF55B36FACF5A8, threatbiasgroup) {
  if(!istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  if(!isDefined(category))
    category = "unassigned";

  if(!isDefined(_id_1C9CB43BCF3EB16D))
    _id_1C9CB43BCF3EB16D = "unassigned";

  if(!isDefined(team))
    team = _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC(undefined, _id_DCF5E15C58C4152A);

  _id_97B87477CFF57241 = !istrue(_id_5A6A87FA3F95753F) && istrue(level._id_FE093E9B2B6C3751) && (!isDefined(_id_5F0C541B305BF851) || _id_5F0C541B305BF851);

  if(_id_97B87477CFF57241 && !istrue(_id_D9F5556107463BB5))
    _id_97B87477CFF57241 = !scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done");

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && !isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_CAED821D95874BBB);

  if(!isDefined(_id_D1CF55B36FACF5A8))
    _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_CAED821D95874BBB, _id_171F90B9C4C76D44);

  _id_0644D90DE7685F75 = _id_8C6DBB64C8E1603C(1, category, _id_CAED821D95874BBB, _id_171F90B9C4C76D44, _id_97B87477CFF57241, _id_D1CF55B36FACF5A8);
  _id_1848056A38B1CCA8 = 0;

  if(isDefined(_id_D1CF55B36FACF5A8) && !isDefined(_id_D1CF55B36FACF5A8._id_F27D7498EB54DD99))
    _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99 = 0;

  success = 0;

  if(!_id_0644D90DE7685F75) {
    [success, _id_C9CB5CEEF8C11EEA] = _id_559886EFCD7D1A19(priority, _id_CAED821D95874BBB, _id_97B87477CFF57241);

    if(!success)
      return undefined;

    if(isDefined(_id_D1CF55B36FACF5A8)) {
      _id_1848056A38B1CCA8 = 1;
      _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99++;
    }

    if(!_id_C9CB5CEEF8C11EEA)
      waittillframeend;
  } else if(isDefined(_id_D1CF55B36FACF5A8)) {
    _id_1848056A38B1CCA8 = 1;
    _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99++;
  }

  if(istrue(level._id_45CA3CFB9DCA4F97))
    level thread scripts\mp\utility\debug::drawsphere(_id_CAED821D95874BBB, 128, 500, (0, 1, 0));

  if(isDefined(level._id_E354254E70A6B849) && !isDefined(threatbiasgroup)) {
    _id_8E5A9B658FA525ED = _id_0B71D8F69E7F63ED(_id_DCF5E15C58C4152A);

    if(isDefined(_id_8E5A9B658FA525ED) && isDefined(level._id_5D6209C724CFEAC7) && isDefined(level._id_5D6209C724CFEAC7[_id_8E5A9B658FA525ED]))
      threatbiasgroup = level._id_5D6209C724CFEAC7[_id_8E5A9B658FA525ED];
    else
      threatbiasgroup = "enemy";
  }

  if(_id_97B87477CFF57241) {
    level._id_53DB9BACADEF066D._id_D4053E1A1D2983CE++;
    _id_451A9D27D63C746B = _id_371B4C2AB5861E62::_id_E2FA9B378BBF03A6(_id_DCF5E15C58C4152A, _id_CAED821D95874BBB, spawnangles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, undefined, threatbiasgroup);
    _id_50375D63A38A8F8F(_id_451A9D27D63C746B, _id_80F4BDE7090A4773);
    _id_ED1DF18568977A9B(_id_CAED821D95874BBB, _id_171F90B9C4C76D44, destination, _id_451A9D27D63C746B);
    _id_6FDAD75E06D99A21(_id_451A9D27D63C746B, priority);
    _id_157C2000284999EB(_id_451A9D27D63C746B, category, _id_1C9CB43BCF3EB16D, _id_171F90B9C4C76D44);

    if(_id_1848056A38B1CCA8)
      _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99--;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("analytics", "agent_alloc"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("analytics", "agent_alloc")]](_id_CAED821D95874BBB, _id_DCF5E15C58C4152A);

    return _id_451A9D27D63C746B;
  }

  if(level._id_3A89274682239C28 > gettime()) {
    level._id_3A89274682239C28 = level._id_3A89274682239C28 + level.frameduration;
    wait((level._id_3A89274682239C28 - gettime() - level.frameduration) / 1000);
  }

  if(issubstr(_id_DCF5E15C58C4152A, "riot"))
    _id_F891E067B8802C0D = 1;

  agent = _id_EEA40A1B6180F90A(_id_DCF5E15C58C4152A, _id_CAED821D95874BBB, spawnangles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D);

  if(!isDefined(agent))
    return undefined;

  if(isDefined(threatbiasgroup))
    _id_371B4C2AB5861E62::_id_58203C3739D2D0C6(agent, threatbiasgroup);

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
    agent scripts\stealth\enemy::bt_event_combat();

  if(istrue(_id_F891E067B8802C0D))
    agent.script_groupname = groupname;

  if(_id_1848056A38B1CCA8)
    _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99--;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("analytics", "agent_spawn"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("analytics", "agent_spawn")]](agent);

  if(level._id_3A89274682239C28 <= gettime())
    level._id_3A89274682239C28 = gettime() + level.frameduration;

  level._id_7318150D8DC474EA = gettime();
  _id_50375D63A38A8F8F(agent, _id_80F4BDE7090A4773);
  _id_371B4C2AB5861E62::_id_C26EF480E88413BF(agent, _id_DCF5E15C58C4152A);

  if(isDefined(agent.grenadeweapon))
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "grenadeType", agent.grenadeweapon.basename);

  if(isDefined(level._id_37DAFE68077318F5)) {
    _id_A841A48BDE055043 = agent._id_57956D515CDA7D03 * level._id_37DAFE68077318F5;
    agent _meth_9215CE6FC83759B9(_id_A841A48BDE055043);
  }

  agent._id_8E3405AC46C40E0F = 1;
  agent._id_D5E499E7FE2C490B = 1;
  agent._id_1544C20E168D97C0 = 12000;
  _id_CAF96A86CA85140F(agent);
  _id_0B893EECEEF3AC7A(agent);
  agent._id_C8E1B804E2C8F23F = 1000;
  return agent;
}

_id_EEA40A1B6180F90A(_id_DCF5E15C58C4152A, _id_CAED821D95874BBB, spawnangles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D) {
  if(!isDefined(_id_CAED821D95874BBB)) {
    return;
  }
  _id_94D391B4017FE505 = _id_DCF5E15C58C4152A;

  if(!scripts\engine\utility::string_starts_with(_id_DCF5E15C58C4152A, "actor_"))
    _id_94D391B4017FE505 = "actor_" + _id_DCF5E15C58C4152A;

  if(!isDefined(level.agent_definition[_id_94D391B4017FE505]))
    return undefined;

  agent = scripts\mp\mp_agent::spawnnewagentaitype(_id_DCF5E15C58C4152A, _id_CAED821D95874BBB, spawnangles, team);

  if(!isDefined(agent))
    return undefined;

  agent.baseaccuracy = getdvarfloat("dvar_8AA5333CA3F377E5", 0.66);
  agent.accuracy = agent.baseaccuracy;

  if(agent.behaviortreeasset != "rusher" && agent.behaviortreeasset != "zombie") {
    agent.pathenemylookahead = 120;
    agent.pathenemyfightdist = 512;
    agent.maxsightdistsqrd = 64000000;
    agent.meleechargedistvsplayer = 50;
  }

  agent pushplayer(1);

  if(!getdvarint("dvar_CB7E65D3DFF416A6", 0))
    agent setplayeradvanceduavdot(1);

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_80DD9D6A6BF6BBC1(agent, _id_171F90B9C4C76D44, destination);
    _id_2CB157B29DE9DBFA(agent, _id_171F90B9C4C76D44, destination);
  }

  _id_41BA451876D0900C::_id_E04DBE0BD8A25BE7(agent, _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));
  agent scripts\mp\agents\agent_utility::initplayerscriptvariables(1);
  agent._id_599B158D152C358D = getdvarint("dvar_45A2B4489E57D085", 0);
  agent.category = category;
  agent._id_1C9CB43BCF3EB16D = _id_1C9CB43BCF3EB16D;
  _id_157C2000284999EB(agent, category, _id_1C9CB43BCF3EB16D);
  _id_80136FB230FD0646(agent, priority);
  agent _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "weapon", agent.weapon);
  _id_1E78071B55344CD3 = _id_371B4C2AB5861E62::_id_FB117F8CE12C38E9(_id_DCF5E15C58C4152A);

  if(isDefined(_id_1E78071B55344CD3) && _id_1E78071B55344CD3 > 0)
    agent scripts\mp\mp_agent::set_agent_health(_id_1E78071B55344CD3);

  if(!istrue(level._id_B21AAFD3E06B203D))
    agent thread _id_120270BD0A747A35::_id_7E69553F058C867B(agent);

  if(!issubstr(_id_DCF5E15C58C4152A, "civilian")) {
    if(!istrue(_id_F891E067B8802C0D))
      _id_5D07B6EF455E7876(agent, groupname);

    if(randomint(100) >= level._id_18C5FA4FDEBE1971)
      agent._id_51642E27C7E7D224 = 1;

    _id_371B4C2AB5861E62::_id_1920867DDF76810C(agent, 0);
    agent thread _id_0C11D6400BA31ED7::addtosquad();
    agent thread scripts\mp\weapons::watchgrenadeusage();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai", "dropLootOnAgentDeath"))
      agent thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("ai", "dropLootOnAgentDeath")]](agent, _id_DCF5E15C58C4152A, groupname);
  }

  agent thread _id_7EE4A8954B638ED3(agent);
  _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

  if(!isDefined(_id_C7A4725D05BB7F22))
    _id_C7A4725D05BB7F22 = "undefined";

  dlog_recordevent("dlog_event_dmz_ai_spawn", ["spawn_id", agent._id_8AA9EFE6383C1D5A, "ai_pos_x", _id_CAED821D95874BBB[0], "ai_pos_y", _id_CAED821D95874BBB[1], "ai_pos_z", _id_CAED821D95874BBB[2], "ai_type", _id_DCF5E15C58C4152A, "ai_tier", _id_C7A4725D05BB7F22, "ai_status", "unknown", "ai_category", category, "ai_subcat", _id_1C9CB43BCF3EB16D, "priority", priority, "ai_weapon_primary", agent.primaryweapon.basename, "ai_weapon_secondary", agent.secondaryweapon.basename, "ai_weapon_grenade", agent.grenadeweapon.basename, "match_time_elapsed", gettime()]);
  return agent;
}

_id_D5BC07EABF352ABB(node, _id_171F90B9C4C76D44, _id_FCDC7F62624C71FF, _id_1439F86640D42E34, tier, _id_8E5A9B658FA525ED) {
  if(isDefined(node) && isDefined(node.aitype_override)) {
    aitype = node.aitype_override;
    return aitype;
  }

  if(!isDefined(tier))
    tier = _id_8AF522ADA68B6477(node, _id_171F90B9C4C76D44);

  if(!isDefined(_id_8E5A9B658FA525ED))
    _id_8E5A9B658FA525ED = _id_7722DB2014C7DFBD(node, _id_171F90B9C4C76D44);

  if(!isDefined(_id_1439F86640D42E34)) {
    if(!isDefined(node) || !isDefined(node.script_noteworthy))
      _id_1439F86640D42E34 = _id_ED108FF3EB578327(_id_FCDC7F62624C71FF, tier);
    else
      _id_1439F86640D42E34 = _id_CA51DD295E82F280(node, tier);
  }

  [_id_1439F86640D42E34, tier] = _id_BD5C9A8459875E7A(_id_1439F86640D42E34, tier);
  aitype = _id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, tier, _id_8E5A9B658FA525ED);
  _id_94D391B4017FE505 = aitype;

  if(!scripts\engine\utility::string_starts_with(aitype, "actor_"))
    _id_94D391B4017FE505 = "actor_" + aitype;

  if(!isDefined(level.agent_definition[_id_94D391B4017FE505])) {
    _id_1439F86640D42E34 = _id_ED108FF3EB578327("medium_range", tier);
    aitype = _id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, tier, _id_8E5A9B658FA525ED);
  }

  return aitype;
}

_id_CA51DD295E82F280(node, tier) {
  if(!isDefined(node.script_noteworthy))
    return _id_ED108FF3EB578327(undefined, tier);

  _id_67F14F8315CB0F2F = strtok(tolower(node.script_noteworthy), "_");

  if(_id_67F14F8315CB0F2F.size == 1 || _id_67F14F8315CB0F2F.size == 2 && _id_67F14F8315CB0F2F[1] == "stationary")
    return _id_ED108FF3EB578327(undefined, tier);
  else if(tolower(_id_67F14F8315CB0F2F[0]) == "spawnset" || tolower(_id_67F14F8315CB0F2F[1]) == "spawnset") {
    _id_FCDC7F62624C71FF = _id_F213E61932ACBB15(node);
    return _id_ED108FF3EB578327(_id_FCDC7F62624C71FF, tier);
  } else if(_id_67F14F8315CB0F2F.size >= 3 && _id_67F14F8315CB0F2F[1] == "stationary") {
    if(tolower(_id_67F14F8315CB0F2F[2]) == "spawnset") {
      _id_FCDC7F62624C71FF = _id_F213E61932ACBB15(node);
      return _id_ED108FF3EB578327(_id_FCDC7F62624C71FF, tier);
    } else
      return _id_67F14F8315CB0F2F[2];
  }

  return _id_67F14F8315CB0F2F[1];
}

_id_BD5C9A8459875E7A(type, tier) {
  if(!isDefined(type) || !isDefined(tier))
    return [type, tier];

  if(type == "firebug" && tier != 1)
    return ["firebug", 1];

  if(type == "strikeunit" && tier != 3)
    return ["ar", 1];

  return [type, tier];
}

_id_F213E61932ACBB15(node) {
  if(!isDefined(node.script_noteworthy)) {
    return;
  }
  _id_67F14F8315CB0F2F = strtok(node.script_noteworthy, "_");
  _id_B1378484AC36F0E0 = 15;

  if(_id_67F14F8315CB0F2F[0] == "spawnset")
    _id_B1378484AC36F0E0 = 9;
  else if(_id_67F14F8315CB0F2F[1] == "stationary")
    _id_B1378484AC36F0E0 = 26;

  return getsubstr(node.script_noteworthy, _id_B1378484AC36F0E0, node.script_noteworthy.size);
}

_id_8AF522ADA68B6477(node, _id_171F90B9C4C76D44, origin) {
  if(isDefined(node)) {
    if(scripts\engine\utility::is_equal(node._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4)) {
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);
      node._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
    }

    if(istrue(level._id_7A36D824DA6087EF)) {
      if(!isDefined(_id_171F90B9C4C76D44))
        _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

      _id_737C25E5BCF0380D = _id_6CDA15989D9ABAE0(node.origin, _id_171F90B9C4C76D44);

      if(isDefined(_id_737C25E5BCF0380D))
        return _id_737C25E5BCF0380D;
    }

    if(!isDefined(node.agent_type) || isDefined(node.agent_type) && !issubstr(tolower(node.agent_type), "toptier") && !issubstr(tolower(node.agent_type), "elite"))
      return 1;

    if(!isDefined(node._id_71AD22C5D093D90B)) {
      _id_3A6B42AB825A103E = scripts\engine\utility::ter_op(isDefined(origin), origin, node.origin);
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_3A6B42AB825A103E, _id_171F90B9C4C76D44);
      node._id_71AD22C5D093D90B = _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B;

      if(!isDefined(_id_171F90B9C4C76D44) && !isDefined(node._id_B205D90302DA2F07))
        _id_171F90B9C4C76D44 = _id_D1CF55B36FACF5A8._id_B205D90302DA2F07;
    }

    if(isDefined(node._id_71AD22C5D093D90B)) {
      _id_99461DBF0E248572 = scripts\engine\utility::ter_op(isDefined(node._id_B205D90302DA2F07), node._id_B205D90302DA2F07, _id_171F90B9C4C76D44);

      if(isDefined(_id_99461DBF0E248572) && isDefined(node._id_71AD22C5D093D90B))
        tier = level._id_B205D90302DA2F07[_id_99461DBF0E248572]["subAreas"][node._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;
      else
        return 1;
    } else
      return 1;

    if(!isDefined(tier) || tier != 1 && tier != 2 && tier != 3)
      tier = 1;

    return tier;
  }

  if(!isDefined(_id_171F90B9C4C76D44)) {
    if(!isDefined(origin))
      return 1;

    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
  }

  if(isDefined(_id_171F90B9C4C76D44)) {
    if(istrue(level._id_7A36D824DA6087EF)) {
      _id_737C25E5BCF0380D = _id_6CDA15989D9ABAE0(origin, _id_171F90B9C4C76D44);

      if(isDefined(_id_737C25E5BCF0380D))
        return _id_737C25E5BCF0380D;
    }

    tier = _id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));

    if(tier != 1 && tier != 2 && tier != 3)
      tier = 1;

    return tier;
  }

  return 1;
}

_id_AA34A142B7664DD1(_id_ACA1544C91A292FD) {
  switch (_id_ACA1544C91A292FD) {
    case 1:
    case 0:
      return 1;
    case 3:
    case 2:
      return 2;
    case 4:
      return 3;
  }

  return 1;
}

_id_7722DB2014C7DFBD(node, _id_171F90B9C4C76D44) {
  if(isDefined(node)) {
    if(isDefined(node._id_8E5A9B658FA525ED))
      return node._id_8E5A9B658FA525ED;

    if(!isDefined(_id_171F90B9C4C76D44)) {
      if(isDefined(node._id_B205D90302DA2F07))
        _id_171F90B9C4C76D44 = node._id_B205D90302DA2F07;
      else
        _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);
    }

    if(!isDefined(node._id_71AD22C5D093D90B))
      node._id_71AD22C5D093D90B = _id_0A44E168E8CCED18(node.origin, _id_171F90B9C4C76D44)._id_71AD22C5D093D90B;

    if(isDefined(node._id_71AD22C5D093D90B)) {
      if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][node._id_71AD22C5D093D90B]))
        return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][node._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1._id_A42C3E0E1B2DC645;
    }
  }
}

_id_0B71D8F69E7F63ED(_id_DCF5E15C58C4152A) {
  if(issubstr(_id_DCF5E15C58C4152A, "_aq"))
    return "aq";
  else if(issubstr(_id_DCF5E15C58C4152A, "_cartel"))
    return "cartel";
  else if(issubstr(_id_DCF5E15C58C4152A, "_merc"))
    return "merc";
  else if(issubstr(_id_DCF5E15C58C4152A, "_ru"))
    return "ru";

  return;
}

_id_CB53E3ABD2B63E1D(spawnset, tier) {
  _id_6186300AF3BE06D6 = [];
  _id_80BF10A2DED77927 = [];

  foreach(_id_A7ECB72624160E3C, _id_E75DDF2170309EEA in level._id_C7796321C3D97413) {
    if(_id_A7ECB72624160E3C == tier) {
      continue;
    }
    _id_80BF10A2DED77927 = scripts\engine\utility::array_combine(_id_80BF10A2DED77927, _id_E75DDF2170309EEA);
  }

  foreach(aitype in spawnset) {
    if(!scripts\engine\utility::array_contains(_id_80BF10A2DED77927, aitype))
      _id_6186300AF3BE06D6[_id_6186300AF3BE06D6.size] = aitype;
  }

  return _id_6186300AF3BE06D6;
}

_id_ED108FF3EB578327(_id_FCDC7F62624C71FF, tier) {
  if(!isDefined(_id_FCDC7F62624C71FF) || !isDefined(level.spawnset[_id_FCDC7F62624C71FF]))
    _id_FCDC7F62624C71FF = level._id_C0E1DE2E14E458BF;

  spawnset = level.spawnset[_id_FCDC7F62624C71FF];

  if(isDefined(tier))
    spawnset = _id_CB53E3ABD2B63E1D(spawnset, tier);

  if(isDefined(level._id_3B54ADCD8ED5B8C0[_id_FCDC7F62624C71FF])) {
    _id_50F2EE11200531A9 = [];

    foreach(index, _id_4CD66E97D14EC4F7 in level._id_3B54ADCD8ED5B8C0[_id_FCDC7F62624C71FF]) {
      if(scripts\engine\utility::array_contains(spawnset, index))
        _id_50F2EE11200531A9[index] = _id_4CD66E97D14EC4F7;
    }

    _id_EB6F2E9E793E992E = 0;

    foreach(index, _id_4CD66E97D14EC4F7 in _id_50F2EE11200531A9)
    _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_4CD66E97D14EC4F7;

    roll = randomint(_id_EB6F2E9E793E992E);
    _id_0DB4D4D3DCAE5375 = 0;

    foreach(index, _id_4CD66E97D14EC4F7 in _id_50F2EE11200531A9) {
      _id_0DB4D4D3DCAE5375 = _id_0DB4D4D3DCAE5375 + _id_4CD66E97D14EC4F7;

      if(roll <= _id_0DB4D4D3DCAE5375)
        return index;
    }
  }

  return spawnset[randomint(spawnset.size)];
}

_id_59CDFE39E161A336(node) {
  if(istrue(level._id_6827E5668EBC95C0) && isDefined(node.script_stealthgroup))
    return node.script_stealthgroup;

  return undefined;
}

_id_06D1E55C48E2C12F() {
  return _id_ED108FF3EB578327("guard");
}

_id_F851A2F41CFFA860() {
  if(isDefined(level._id_75041B516B3785C6))
    return level._id_75041B516B3785C6;

  return "aq";
}

_id_0346DC7F701823DC(_id_5B027BECA4DF0AF8) {
  if(!isDefined(_id_5B027BECA4DF0AF8)) {
    if(issubstr(level.mapname, "cruce"))
      _id_5B027BECA4DF0AF8 = "mx";
    else if(issubstr(level.mapname, "saba"))
      _id_5B027BECA4DF0AF8 = "aq";
    else if(issubstr(level.mapname, "bio_lab"))
      _id_5B027BECA4DF0AF8 = "ru";
    else if(issubstr(level.mapname, "delta"))
      _id_5B027BECA4DF0AF8 = "ru";
    else if(issubstr(level.mapname, "sealion")) {
      if(scripts\mp\utility\game::getsubgametype() == "dmz")
        _id_5B027BECA4DF0AF8 = "ru";
      else
        _id_5B027BECA4DF0AF8 = "merc";
    } else
      _id_5B027BECA4DF0AF8 = "aq";
  }

  level._id_75041B516B3785C6 = _id_5B027BECA4DF0AF8;
}

_id_559886EFCD7D1A19(priority, _id_1A532FBE5A6451E4, _id_97B87477CFF57241) {
  [success, _id_C9CB5CEEF8C11EEA] = _id_56E8FD646957529C(priority, 0, _id_1A532FBE5A6451E4, _id_97B87477CFF57241);

  if(!success)
    [success, _id_C9CB5CEEF8C11EEA] = _id_56E8FD646957529C(priority, 1, _id_1A532FBE5A6451E4, _id_97B87477CFF57241);

  return [success, _id_C9CB5CEEF8C11EEA];
}

_id_56E8FD646957529C(priority, _id_51A5A8B593BF4AA1, _id_1A532FBE5A6451E4, _id_97B87477CFF57241) {
  _id_CDDBF16FFCF0B1E8 = 0;
  _id_01992EF28A62E7CE = scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, priority);
  _id_2231DF82D7283C43 = 0;
  _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_1A532FBE5A6451E4);

  if(isDefined(_id_D1CF55B36FACF5A8))
    _id_EF017FF00EBC23CE = scripts\engine\utility::ter_op(isDefined(_id_D1CF55B36FACF5A8._id_F27D7498EB54DD99), _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99, 0);
  else
    _id_EF017FF00EBC23CE = 0;

  if(isDefined(_id_D1CF55B36FACF5A8) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E) && isarray(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) && _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size + 1 + _id_EF017FF00EBC23CE <= _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E)
    _id_2231DF82D7283C43 = 1;

  foreach(_id_EE318F2C0C39C1ED in level._id_41670C1C65F3D3CF._id_1D7DE2571D2C82A7) {
    if(scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, _id_EE318F2C0C39C1ED) <= _id_01992EF28A62E7CE) {
      break;
    }

    _id_D3D06E31985486A6 = [];

    if(!istrue(_id_97B87477CFF57241)) {
      if(isDefined(_id_D1CF55B36FACF5A8) && !_id_2231DF82D7283C43) {
        _id_27D81DC45E0B6D94 = [];

        foreach(agent in _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) {
          if(isagent(agent)) {
            _id_9F16B05DEF83031E = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "priority");

            if(scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, _id_9F16B05DEF83031E) <= _id_01992EF28A62E7CE) {
              continue;
            }
            _id_D3D06E31985486A6[_id_D3D06E31985486A6.size] = agent;
            continue;
          }

          if(isint(agent)) {
            _id_9F16B05DEF83031E = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent).priority;

            if(_id_9F16B05DEF83031E <= _id_01992EF28A62E7CE) {
              continue;
            }
            _id_27D81DC45E0B6D94[_id_27D81DC45E0B6D94.size] = agent;
          }
        }

        _id_D3D06E31985486A6 = scripts\engine\utility::array_combine(_id_D3D06E31985486A6, _id_27D81DC45E0B6D94);

        if(_id_D3D06E31985486A6.size == 0)
          return [0, undefined];
      } else {
        _id_D3D06E31985486A6 = scripts\engine\utility::array_randomize(_id_44C0059E33F55F00(_id_EE318F2C0C39C1ED));

        if(isDefined(_id_D1CF55B36FACF5A8))
          _id_D3D06E31985486A6 = _id_BAFFA48BBD15CDC6(_id_D1CF55B36FACF5A8, _id_D3D06E31985486A6);
      }
    } else if(isDefined(_id_D1CF55B36FACF5A8) && !_id_2231DF82D7283C43) {
      foreach(agent in _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) {
        if(isint(agent)) {
          _id_9F16B05DEF83031E = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent).priority;

          if(_id_9F16B05DEF83031E <= _id_01992EF28A62E7CE) {
            continue;
          }
          _id_D3D06E31985486A6[_id_D3D06E31985486A6.size] = agent;
        }
      }

      if(_id_D3D06E31985486A6.size == 0)
        return [0, undefined];
    } else {
      _id_D3D06E31985486A6 = scripts\engine\utility::array_randomize(_id_72AE84D7068BE83F(_id_EE318F2C0C39C1ED));

      if(isDefined(_id_D1CF55B36FACF5A8))
        _id_D3D06E31985486A6 = _id_BAFFA48BBD15CDC6(_id_D1CF55B36FACF5A8, _id_D3D06E31985486A6);
    }

    foreach(agent in _id_D3D06E31985486A6) {
      if(!isagent(agent)) {
        if(isDefined(_id_D1CF55B36FACF5A8) && !_id_2231DF82D7283C43 && !_id_97B87477CFF57241 && _id_E8C0AC958D093EC2() + 1 == _id_3813364E2323B789()) {
          _id_6EC0829ABBD65125 = _id_67224249BA9C2E2E(_id_EE318F2C0C39C1ED, 1, _id_1A532FBE5A6451E4, _id_D1CF55B36FACF5A8);

          if(!_id_6EC0829ABBD65125)
            return [0, undefined];
        }

        _id_371B4C2AB5861E62::_id_4E065F1747AADD51(agent);
        return [1, 1];
      } else if(agent _id_F31BFD56E7806AFB(_id_51A5A8B593BF4AA1)) {
        agent _id_28B90EB2B591003F();
        return [1, 0];
      }

      _id_CDDBF16FFCF0B1E8++;

      if(_id_CDDBF16FFCF0B1E8 % 30 == 0)
        waitframe();
    }
  }

  return [0, undefined];
}

_id_67224249BA9C2E2E(priority, _id_51A5A8B593BF4AA1, _id_1A532FBE5A6451E4, _id_D1CF55B36FACF5A8) {
  _id_CDDBF16FFCF0B1E8 = 0;
  _id_01992EF28A62E7CE = scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, priority);

  if(!isDefined(_id_D1CF55B36FACF5A8))
    _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_1A532FBE5A6451E4);

  foreach(_id_EE318F2C0C39C1ED in level._id_41670C1C65F3D3CF._id_1D7DE2571D2C82A7) {
    if(scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, _id_EE318F2C0C39C1ED) <= _id_01992EF28A62E7CE) {
      break;
    }

    _id_D3D06E31985486A6 = scripts\engine\utility::array_randomize(_id_44C0059E33F55F00(_id_EE318F2C0C39C1ED));
    _id_D3D06E31985486A6 = _id_BAFFA48BBD15CDC6(_id_D1CF55B36FACF5A8, _id_D3D06E31985486A6);

    foreach(agent in _id_D3D06E31985486A6) {
      if(agent _id_F31BFD56E7806AFB(_id_51A5A8B593BF4AA1)) {
        if(istrue(level._id_45CA3CFB9DCA4F97))
          level thread scripts\mp\utility\debug::drawsphere(agent.origin, 64, 500, (1, 0, 0));

        agent _id_28B90EB2B591003F();
        return 1;
      }

      _id_CDDBF16FFCF0B1E8++;

      if(_id_CDDBF16FFCF0B1E8 % 30 == 0)
        waitframe();
    }
  }

  return 0;
}

_id_28B90EB2B591003F() {
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "skipDeathCount", 1);
  self.nocorpse = 1;
  self kill();
}

_id_F31BFD56E7806AFB(_id_51A5A8B593BF4AA1) {
  if(!isalive(self))
    return 0;

  if(self.health < 1)
    return 0;

  if(istrue(self.dontkilloff))
    return 0;

  if(istrue(self.playing_skit))
    return 0;

  if(_id_120270BD0A747A35::is_specified_unittype("juggernaut"))
    return 0;

  if(is_riding_vehicle())
    return 0;

  if(!istrue(_id_51A5A8B593BF4AA1)) {
    if(isDefined(self.enemy) && self canshootenemy())
      return 0;
  }

  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 0;

  if(istrue(_id_51A5A8B593BF4AA1))
    return 1;

  _id_934F2BD9F0E5C04B = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module))
    _id_99189C9718781C5D = 1000000;
  else
    _id_99189C9718781C5D = 4000000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

    if(distancesquared(_id_678A0776298909D1.origin, self.origin) < _id_99189C9718781C5D)
      return 0;

    if(self seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B))
      return 0;
  }

  return 1;
}

get_see_recently_time_overrides() {
  if(isDefined(self.see_recently_override))
    return self.see_recently_override;
  else if(isDefined(self.group)) {
    if(isDefined(self.group.last_seen_time_override))
      return self.group.last_seen_time_override;
    else if(istrue(self.group.cqb_module))
      return 2;
    else
      return 6;
  } else
    return 6;
}

is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

_id_93ADD0B65DB9F722(function, context) {
  if(!isDefined(level._id_DA2AAD7AF92CE2D0))
    level._id_DA2AAD7AF92CE2D0 = [];

  if(!isDefined(context))
    context = self;

  info = spawnStruct();
  info.function = function;
  info.context = context;
  level._id_DA2AAD7AF92CE2D0[level._id_DA2AAD7AF92CE2D0.size] = info;
}

_id_66A6064FAD612BF3(function, context) {
  if(!isDefined(context))
    context = self;

  if(isDefined(level._id_DA2AAD7AF92CE2D0)) {
    for(index = 0; index < level._id_DA2AAD7AF92CE2D0.size; index++) {
      if(isDefined(level._id_DA2AAD7AF92CE2D0[index]) && level._id_DA2AAD7AF92CE2D0[index].function == function && level._id_DA2AAD7AF92CE2D0[index].context == context)
        level._id_DA2AAD7AF92CE2D0[index] = undefined;
    }
  }
}

_id_BE9C6FBD4DC69254(agent, _id_6181DE250AFA5BB6) {
  if(isDefined(level._id_DA2AAD7AF92CE2D0)) {
    foreach(info in level._id_DA2AAD7AF92CE2D0)
    info.context thread[[info.function]](agent, _id_6181DE250AFA5BB6);
  }
}

_id_D2D3DDD52666DCF0() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_7B8A64E4EC045A1B();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || (getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm") || getdvarint("dvar_61829D18989706CF", 1) == 0) {
    _id_AE8293438B86CA23();
    _id_B0BB893F94E993B4();
    _id_1D0B1E527BD1BD48();
  }

  _id_BEBC5768175D5170();
  _id_1353821E73926C69();
  level._id_F79746DAB56DCA8C = scripts\engine\utility::getStructArray("para_landingSpot", "script_noteworthy");
}

_id_7B8A64E4EC045A1B() {
  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  _id_078FA8D928A0C292 = [];

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    if(isDefined(_id_B205D90302DA2F07) && isDefined(_id_B205D90302DA2F07["subAreas"])) {
      foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
        if(isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44]) && isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]))
          _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1 = level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B];
      }
    }
  }

  level._id_7DA9883D4168B7F1 = undefined;
}

_id_AE8293438B86CA23() {
  _id_C034726A93BBFF6E = scripts\engine\utility::getStructArray("spawnPackage_mainNode", "script_noteworthy");

  foreach(_id_F44BDB70807D60A9 in _id_C034726A93BBFF6E) {
    if(!isDefined(_id_F44BDB70807D60A9.target)) {
      continue;
    }
    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      if(!isDefined(_id_F44BDB70807D60A9._id_B205D90302DA2F07) || scripts\engine\utility::is_equal(_id_F44BDB70807D60A9._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4))
        _id_F44BDB70807D60A9._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_F44BDB70807D60A9.origin);

      if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_F44BDB70807D60A9._id_B205D90302DA2F07) && !istrue(level._id_4CFD75AA6DDDE156))
        continue;
    }

    _id_9000AA3A8F0B6304 = spawnStruct();
    _id_9000AA3A8F0B6304.origin = _id_F44BDB70807D60A9.origin;
    _id_9000AA3A8F0B6304._id_2EF873E30A270BCF = [];
    _id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094 = [];
    _id_9000AA3A8F0B6304._id_6C25FE44FF159D0E = [];
    _id_171F90B9C4C76D44 = undefined;
    _id_D1CF55B36FACF5A8 = undefined;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      _id_171F90B9C4C76D44 = _id_F44BDB70807D60A9._id_B205D90302DA2F07;
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_F44BDB70807D60A9.origin, _id_F44BDB70807D60A9._id_B205D90302DA2F07);
    }

    if(!isDefined(_id_D1CF55B36FACF5A8)) {
      if(isDefined(_id_F44BDB70807D60A9._id_B205D90302DA2F07)) {} else {}

      return;
    } else {
      _id_9000AA3A8F0B6304._id_71AD22C5D093D90B = _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B;
      _id_9000AA3A8F0B6304._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
      _id_9000AA3A8F0B6304._id_8E5A9B658FA525ED = _id_F44BDB70807D60A9._id_8E5A9B658FA525ED;
    }

    _id_DA8B6C7C8AD40CE1 = scripts\engine\utility::getStructArray(_id_F44BDB70807D60A9.target, "targetname");

    foreach(node in _id_DA8B6C7C8AD40CE1) {
      if(isDefined(node.script_noteworthy)) {
        script_noteworthy = tolower(node.script_noteworthy);
        node._id_71AD22C5D093D90B = _id_9000AA3A8F0B6304._id_71AD22C5D093D90B;
        node._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;

        if(issubstr(script_noteworthy, "guard"))
          _id_9000AA3A8F0B6304._id_2EF873E30A270BCF[_id_9000AA3A8F0B6304._id_2EF873E30A270BCF.size] = node;
        else if(issubstr(script_noteworthy, "patrolstart") || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = _id_09EDCF99159ABB0B(node, issubstr(script_noteworthy, "looped"));
          _id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094[_id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094.size] = pathstruct;
        }

        if(issubstr(script_noteworthy, "civ"))
          _id_9000AA3A8F0B6304._id_6C25FE44FF159D0E[_id_9000AA3A8F0B6304._id_6C25FE44FF159D0E.size] = node;
      }
    }

    if(isDefined(_id_F44BDB70807D60A9._id_4B62AA3A1860D0AC) && _id_F44BDB70807D60A9._id_4B62AA3A1860D0AC == "1") {
      _id_D1CF55B36FACF5A8._id_D276B08C96430BFC[_id_D1CF55B36FACF5A8._id_D276B08C96430BFC.size] = _id_9000AA3A8F0B6304;
      continue;
    }

    _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D[_id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D.size] = _id_9000AA3A8F0B6304;
  }
}

_id_1D0B1E527BD1BD48() {
  _id_C9E457777CE86549 = scripts\engine\utility::getStructArray("roofPackage_mainNode", "script_noteworthy");

  foreach(_id_51AB38BB8D2E56E0 in _id_C9E457777CE86549) {
    if(!isDefined(_id_51AB38BB8D2E56E0.target)) {
      continue;
    }
    _id_D1CF55B36FACF5A8 = undefined;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      if(!isDefined(_id_51AB38BB8D2E56E0._id_B205D90302DA2F07) || scripts\engine\utility::is_equal(_id_51AB38BB8D2E56E0._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4))
        _id_51AB38BB8D2E56E0._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_51AB38BB8D2E56E0.origin);

      if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_51AB38BB8D2E56E0._id_B205D90302DA2F07) && !istrue(level._id_4CFD75AA6DDDE156)) {
        continue;
      }
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_51AB38BB8D2E56E0.origin, _id_51AB38BB8D2E56E0._id_B205D90302DA2F07);
    }

    if(!isDefined(_id_D1CF55B36FACF5A8)) {
      continue;
    }
    _id_D1CF55B36FACF5A8._id_78B67865EF2A33D3 = scripts\engine\utility::getStructArray(_id_51AB38BB8D2E56E0.target, "targetname");
  }
}

_id_B0BB893F94E993B4() {
  _id_89028783941C2CB5 = scripts\engine\utility::getStructArray("patrolPackage_mainNode", "script_noteworthy");

  foreach(_id_3E7F36981B173D04 in _id_89028783941C2CB5) {
    if(!isDefined(_id_3E7F36981B173D04.target)) {
      continue;
    }
    _id_D1CF55B36FACF5A8 = undefined;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      if(!isDefined(_id_3E7F36981B173D04._id_B205D90302DA2F07) || scripts\engine\utility::is_equal(_id_3E7F36981B173D04._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4))
        _id_3E7F36981B173D04._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_3E7F36981B173D04.origin);

      if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_3E7F36981B173D04._id_B205D90302DA2F07) && !istrue(level._id_4CFD75AA6DDDE156)) {
        continue;
      }
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_3E7F36981B173D04.origin, _id_3E7F36981B173D04._id_B205D90302DA2F07);
    }

    if(!isDefined(_id_D1CF55B36FACF5A8)) {
      continue;
    }
    _id_D1CF55B36FACF5A8._id_2976480563DE74DF = scripts\engine\utility::getStructArray(_id_3E7F36981B173D04.target, "targetname");

    foreach(_id_C229D93C0BB4F8E8 in _id_D1CF55B36FACF5A8._id_2976480563DE74DF) {
      _id_E0C08758EB0006BE = _id_09EDCF99159ABB0B(_id_C229D93C0BB4F8E8);
      _id_C229D93C0BB4F8E8._id_E0C08758EB0006BE = _id_E0C08758EB0006BE;
    }
  }
}

_id_F41C155E991AF4F9() {
  _id_3EBBAC089A29E000 = scripts\engine\utility::getStructArray("skit_mainNode", "script_noteworthy");

  foreach(_id_6FF17F9F9E0EA073 in _id_3EBBAC089A29E000) {
    _id_887D46B1410C42CA = spawnStruct();
    _id_887D46B1410C42CA.origin = _id_6FF17F9F9E0EA073.origin;
    _id_887D46B1410C42CA._id_2EF873E30A270BCF = [];
    _id_887D46B1410C42CA._id_D7BAAFC9B07F5094 = [];
    _id_887D46B1410C42CA._id_6C25FE44FF159D0E = [];
    _id_DA8B6C7C8AD40CE1 = scripts\engine\utility::getStructArray(_id_6FF17F9F9E0EA073.target, "targetname");

    foreach(node in _id_DA8B6C7C8AD40CE1) {
      if(isDefined(node.script_noteworthy)) {
        script_noteworthy = tolower(node.script_noteworthy);

        if(issubstr(script_noteworthy, "guard"))
          _id_887D46B1410C42CA._id_2EF873E30A270BCF[_id_887D46B1410C42CA._id_2EF873E30A270BCF.size] = node;
        else if(script_noteworthy == "patrolstart" || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = _id_09EDCF99159ABB0B(node, issubstr(script_noteworthy, "looped"));
          _id_887D46B1410C42CA._id_D7BAAFC9B07F5094[_id_887D46B1410C42CA._id_D7BAAFC9B07F5094.size] = pathstruct;
        } else if(issubstr(script_noteworthy, "civilian"))
          _id_887D46B1410C42CA._id_6C25FE44FF159D0E[_id_887D46B1410C42CA._id_6C25FE44FF159D0E.size] = node;
      }
    }

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      _id_171F90B9C4C76D44 = _id_6FF17F9F9E0EA073._id_B205D90302DA2F07;
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_6FF17F9F9E0EA073.origin, _id_171F90B9C4C76D44);
    } else
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_6FF17F9F9E0EA073.origin);

    _id_D1CF55B36FACF5A8._id_37C530D20DF6BCDB[_id_D1CF55B36FACF5A8._id_37C530D20DF6BCDB.size] = _id_887D46B1410C42CA;
  }
}

_id_BEBC5768175D5170() {
  level._id_4E8126C3305A5431 = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("patrolPaths");

  _id_B575289437FB9924 = scripts\engine\utility::getStructArray("patrolPath_Fortress", "script_noteworthy");
  _id_B575289437FB9924 = scripts\engine\utility::array_combine(_id_B575289437FB9924, scripts\engine\utility::getStructArray("patrolStart", "script_noteworthy"));

  foreach(node in _id_B575289437FB9924) {
    pathstruct = _id_09EDCF99159ABB0B(node);

    if(isDefined(pathstruct)) {
      pathstruct.origin = node.origin;
      level._id_4E8126C3305A5431[level._id_4E8126C3305A5431.size] = pathstruct;

      if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
        _id_171F90B9C4C76D44 = node._id_B205D90302DA2F07;

        if(!isDefined(node._id_B205D90302DA2F07) || scripts\engine\utility::is_equal(node._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4))
          _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "patrolPaths", pathstruct);
      }
    }
  }

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    level thread _id_7132401E09A9CCC7();
}

_id_7132401E09A9CCC7() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("fortress", "spawn")) {
    level waittill("infils_ready");
    level._id_4E8126C3305A5431 = undefined;
  } else {
    while(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done"))
      waitframe();

    level._id_4E8126C3305A5431 = undefined;
  }
}

_id_09EDCF99159ABB0B(node, _id_298FCB67E460E16F) {
  path = [];
  index = 0;
  path[index] = node;
  _id_4437E81F60B6B5A0 = 0;

  if(!isDefined(path[index].target)) {
    return;
  }
  nextnode = scripts\engine\utility::getStruct(path[index].target, "targetname");

  if(!isDefined(nextnode)) {
    return;
  }
  for(;;) {
    if(!isDefined(path[index].target)) {
      if(!istrue(_id_298FCB67E460E16F))
        _id_4437E81F60B6B5A0 = 1;

      break;
    }

    nextnode = scripts\engine\utility::getStruct(path[index].target, "targetname");

    if(!isDefined(nextnode) || node == nextnode || path[index] == nextnode) {
      break;
    }

    index++;
    path[index] = nextnode;
  }

  pathstruct = spawnStruct();
  pathstruct.path = path;
  pathstruct.claimed = 0;
  pathstruct._id_4437E81F60B6B5A0 = _id_4437E81F60B6B5A0;
  return pathstruct;
}

_id_1353821E73926C69() {
  level._id_23D3E499C3DDE07B = [];
  _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("looseGuardNodes");
  level._id_EB96A5F866DD19FE = [];
  _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("firstKillFodderNodes");
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "guard")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(!isDefined(node.targetname)) {
          if(!isDefined(node._id_B205D90302DA2F07) || scripts\engine\utility::is_equal(node._id_B205D90302DA2F07, level._id_4FF0A3720D67CCF4))
            node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

          if(tolower(key) == "guard" || issubstr(tolower(key), "guard_stationary") || issubstr(tolower(key), "guard_spawnset")) {
            level._id_23D3E499C3DDE07B[level._id_23D3E499C3DDE07B.size] = node;
            _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(node._id_B205D90302DA2F07, "looseGuardNodes", node);
            continue;
          }

          if(issubstr(node.script_noteworthy, "firstKillFodder")) {
            level._id_EB96A5F866DD19FE[level._id_EB96A5F866DD19FE.size] = node;
            _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(node._id_B205D90302DA2F07, "firstKillFodderNodes", node);
            continue;
          }

          if(!isDefined(node.target) && !issubstr(tolower(key), "boss")) {
            level._id_23D3E499C3DDE07B[level._id_23D3E499C3DDE07B.size] = node;
            _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(node._id_B205D90302DA2F07, "looseGuardNodes", node);
          }
        }
      }
    }
  }
}

_id_525668DFDC6F8421() {
  level._id_82E8EB77E9B274E6 = level._id_23D3E499C3DDE07B;

  foreach(pathstruct in level._id_4E8126C3305A5431) {
    foreach(node in pathstruct.path)
    level._id_82E8EB77E9B274E6[level._id_82E8EB77E9B274E6.size] = node;
  }
}

_id_645BFE3907DCC2A0() {
  level._id_F81CB9EAD7B61AC1 = [];
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "spawn_area")) {
      struct = spawnStruct();
      struct.origin = level.struct_class_names["script_noteworthy"][key][0].origin;
      struct._id_2EF873E30A270BCF = [];
      struct._id_4E8126C3305A5431 = [];
      _id_171F90B9C4C76D44 = level.struct_class_names["script_noteworthy"][key][0]._id_B205D90302DA2F07;

      if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && isDefined(_id_171F90B9C4C76D44)) {
        _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("subAreas");
        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "subAreas", struct, key);
      } else {
        if(!isDefined(level._id_21D3078030950348))
          level._id_F81CB9EAD7B61AC1 = [];

        level._id_F81CB9EAD7B61AC1[key] = struct;
      }
    }
  }

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
    _id_C1E539C16AEB4BD1(_id_171F90B9C4C76D44);
  } else if(isDefined(level._id_21D3078030950348) && level._id_F81CB9EAD7B61AC1.size > 0) {
    level._id_947CC8C185B0EA9C = 1;
    _id_C1E539C16AEB4BD1();
  }
}

_id_C1E539C16AEB4BD1(_id_171F90B9C4C76D44) {
  if(isDefined(_id_171F90B9C4C76D44)) {
    _id_2EF873E30A270BCF = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"];
    _id_D09AECDB0D855501 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"];
  } else {
    _id_2EF873E30A270BCF = level._id_23D3E499C3DDE07B;
    _id_D09AECDB0D855501 = level._id_F81CB9EAD7B61AC1;
  }

  if(_id_D09AECDB0D855501.size == 0) {
    return;
  }
  foreach(node in _id_2EF873E30A270BCF) {
    _id_E6FD13E3873E27FC = undefined;
    _id_42CA41C7DADAE0C0 = undefined;

    foreach(key, area in _id_D09AECDB0D855501) {
      dist = distance2dsquared(node.origin, area.origin);

      if(!isDefined(_id_E6FD13E3873E27FC)) {
        _id_E6FD13E3873E27FC = key;
        _id_42CA41C7DADAE0C0 = dist;
        continue;
      }

      if(dist < _id_42CA41C7DADAE0C0) {
        _id_E6FD13E3873E27FC = key;
        _id_42CA41C7DADAE0C0 = dist;
      }
    }

    if(isDefined(_id_171F90B9C4C76D44)) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_E6FD13E3873E27FC]._id_2EF873E30A270BCF[level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_E6FD13E3873E27FC]._id_2EF873E30A270BCF.size] = node;
      continue;
    }

    level._id_F81CB9EAD7B61AC1[_id_E6FD13E3873E27FC]._id_2EF873E30A270BCF[level._id_F81CB9EAD7B61AC1[_id_E6FD13E3873E27FC]._id_2EF873E30A270BCF.size] = node;
  }

  if(isDefined(_id_171F90B9C4C76D44))
    _id_4E8126C3305A5431 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["patrolPaths"];
  else
    _id_4E8126C3305A5431 = level._id_4E8126C3305A5431;

  foreach(pathstruct in _id_4E8126C3305A5431) {
    _id_E6FD13E3873E27FC = undefined;
    _id_42CA41C7DADAE0C0 = undefined;

    foreach(key, area in _id_D09AECDB0D855501) {
      dist = distance2dsquared(pathstruct.path[0].origin, area.origin);

      if(!isDefined(_id_E6FD13E3873E27FC)) {
        _id_E6FD13E3873E27FC = key;
        _id_42CA41C7DADAE0C0 = dist;
        continue;
      }

      if(dist < _id_42CA41C7DADAE0C0) {
        _id_E6FD13E3873E27FC = key;
        _id_42CA41C7DADAE0C0 = dist;
      }
    }

    if(isDefined(_id_171F90B9C4C76D44)) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_E6FD13E3873E27FC]._id_4E8126C3305A5431[level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"][_id_E6FD13E3873E27FC]._id_4E8126C3305A5431.size] = pathstruct;
      continue;
    }

    level._id_F81CB9EAD7B61AC1[_id_E6FD13E3873E27FC]._id_4E8126C3305A5431[level._id_F81CB9EAD7B61AC1[_id_E6FD13E3873E27FC]._id_4E8126C3305A5431.size] = pathstruct;
  }
}

_id_7662ACE137F157E5() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  waittillframeend;
  level._id_41670C1C65F3D3CF = spawnStruct();
  level._id_41670C1C65F3D3CF._id_25087194B5E05D51 = 0;
  level._id_41670C1C65F3D3CF._id_EF41BD897F02797B = [];
  _func_572838690D80D959("everybody");
  _id_C05702CC1F931B44();

  if(isDefined(level._id_428703950599C9E9))
    [[level._id_428703950599C9E9]]();
  else
    _id_268C4DA1EF6A20A8::_id_428703950599C9E9();

  level._id_41670C1C65F3D3CF.maxagents = getmaxagents() - 1;

  if(isDefined(level._id_B205D90302DA2F07)) {
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07 = [];

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      struct = spawnStruct();
      struct._id_25087194B5E05D51 = 0;
      _func_B49CDE2A52702967(_id_171F90B9C4C76D44, "everybody");
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44] = struct;
    }
  }

  scripts\engine\utility::flag_set("aiBudget_init");
}

_id_2FC80954FA70D153() {
  while(!isDefined(level.agentarray))
    waitframe();

  while(!isDefined(level._id_41670C1C65F3D3CF))
    waitframe();

  while(!isDefined(level._id_41670C1C65F3D3CF.maxagents))
    waitframe();

  maxagents = _id_3813364E2323B789();

  while(level.agentarray.size < maxagents)
    waitframe();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    while(!istrue(level._id_9589C5A19C1A71FC))
      waitframe();
  }

  waitframe();
}

_id_B1D1E7E3B23E0DFE(_id_8DC7C013853F3F4E) {
  level._id_4CDD253DC5F7CD32 = _id_8DC7C013853F3F4E;
  _func_1C161B20F0C6C6B5(_id_8DC7C013853F3F4E);
}

_id_BA4022744DCE59F6(category, maxagents) {
  if(isDefined(maxagents))
    level._id_41670C1C65F3D3CF._id_EF41BD897F02797B[category] = maxagents;

  level._id_4CDD253DC5F7CD32 = scripts\engine\utility::array_add_safe(level._id_4CDD253DC5F7CD32, category);
  _func_572838690D80D959(category);
}

_id_157C2000284999EB(agent, category, _id_1C9CB43BCF3EB16D, _id_171F90B9C4C76D44) {
  if(isagent(agent)) {
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "category", category);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "subcategory", _id_1C9CB43BCF3EB16D);
  }

  _func_E812B7065161DA79(agent, category);

  if(category != "everybody")
    _func_E812B7065161DA79(agent, "everybody");

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(isagent(agent) && isDefined(agent._id_B205D90302DA2F07))
      _id_171F90B9C4C76D44 = agent._id_B205D90302DA2F07;

    if(!isDefined(_id_171F90B9C4C76D44)) {
      return;
    }
    _func_A0CFB616F44B7907(agent, _id_171F90B9C4C76D44, category);

    if(category != "everybody")
      _func_A0CFB616F44B7907(agent, _id_171F90B9C4C76D44, "everybody");
  }
}

_id_1E5307C0D848A9CA(agent, _id_171F90B9C4C76D44) {
  if(!isDefined(agent)) {
    return;
  }
  category = undefined;
  _id_1C9CB43BCF3EB16D = undefined;

  if(isagent(agent)) {
    category = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "category");
    _id_1C9CB43BCF3EB16D = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "subcategory");
  } else if(isint(agent)) {
    _id_7D2909FDC2B71387 = level._id_879053468F168806[agent];
    category = _id_7D2909FDC2B71387.category;
    _id_1C9CB43BCF3EB16D = _id_7D2909FDC2B71387._id_1C9CB43BCF3EB16D;
  }

  _func_C36F897D56E28169(agent, category);

  if(category != "everybody")
    _func_C36F897D56E28169(agent, "everybody");

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && isDefined(_id_171F90B9C4C76D44)) {
    _func_D57D61C9F7B4AA77(agent, _id_171F90B9C4C76D44, category);

    if(category != "everybody")
      _func_D57D61C9F7B4AA77(agent, _id_171F90B9C4C76D44, "everybody");
  }
}

_id_9368FB9261E4CD0A(category) {
  return _func_9A83377C98BCE82A(category);
}

_id_5069C21DDC5C2227(category) {
  _id_8728595177092026 = level._id_41670C1C65F3D3CF._id_EF41BD897F02797B[category];

  if(!isDefined(_id_8728595177092026))
    return undefined;

  return _id_8728595177092026 - _id_9368FB9261E4CD0A(category);
}

_id_8C6DBB64C8E1603C(number, category, origin, _id_171F90B9C4C76D44, _id_97B87477CFF57241, _id_D1CF55B36FACF5A8) {
  _id_868C5168078FEACF = !istrue(_id_97B87477CFF57241) && _id_E8C0AC958D093EC2() + number <= _id_3813364E2323B789() || istrue(_id_97B87477CFF57241) && _id_371B4C2AB5861E62::_id_B27FE8A834C5EDDA() + number <= _id_371B4C2AB5861E62::_id_3B45C895D8D984EE();

  if(getdvarint("dvar_A0CB2262BEBB424B", 0))
    return _id_868C5168078FEACF;

  _id_2231DF82D7283C43 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_2231DF82D7283C43 = 0;

    if(!isDefined(_id_D1CF55B36FACF5A8))
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);

    if(isDefined(_id_D1CF55B36FACF5A8))
      _id_EF017FF00EBC23CE = scripts\engine\utility::ter_op(isDefined(_id_D1CF55B36FACF5A8._id_F27D7498EB54DD99), _id_D1CF55B36FACF5A8._id_F27D7498EB54DD99, 0);
    else
      _id_EF017FF00EBC23CE = 0;

    if(getdvarint("dvar_9F36593603489C07", 0) == 1)
      _id_2231DF82D7283C43 = 1;

    if(isint(number) && isDefined(_id_D1CF55B36FACF5A8) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E) && isarray(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) && _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size + number + _id_EF017FF00EBC23CE <= _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E)
      _id_2231DF82D7283C43 = 1;
  }

  _id_74F7067D31B382F9 = undefined;

  if(isDefined(category))
    _id_74F7067D31B382F9 = _id_5069C21DDC5C2227(category);

  _id_FF9FF42ED5501237 = !isDefined(_id_74F7067D31B382F9) || _id_74F7067D31B382F9 >= number;
  return _id_868C5168078FEACF && _id_FF9FF42ED5501237 && (!isDefined(_id_2231DF82D7283C43) || _id_2231DF82D7283C43);
}

_id_359F24553BDCCA92(number, priority) {
  _id_944B7BC21500684A = 0;
  _id_01992EF28A62E7CE = scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, priority);

  foreach(_id_EE318F2C0C39C1ED in level._id_41670C1C65F3D3CF._id_1D7DE2571D2C82A7) {
    if(scripts\engine\utility::array_find(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89, _id_EE318F2C0C39C1ED) <= _id_01992EF28A62E7CE) {
      break;
    }

    _id_944B7BC21500684A = _id_944B7BC21500684A + _id_44C0059E33F55F00(_id_EE318F2C0C39C1ED).size;
  }

  return _id_E8C0AC958D093EC2() + number - _id_944B7BC21500684A <= _id_3813364E2323B789();
}

_id_E884D14C5B07B811() {
  return _func_9A83377C98BCE82A("everybody");
}

_id_E8C0AC958D093EC2() {
  return _func_718D435F9750C1B5("everybody");
}

_id_BD71347864330395(array) {
  if(!isDefined(array))
    return _id_E8C0AC958D093EC2();

  _id_3D2E4B298E935C8D = 0;

  foreach(agent in array) {
    if(isagent(agent))
      _id_3D2E4B298E935C8D++;
  }

  return _id_3D2E4B298E935C8D;
}

_id_3813364E2323B789() {
  return level._id_41670C1C65F3D3CF.maxagents;
}

_id_7EE4A8954B638ED3(agent, _id_028173FD6B5A461F) {
  agent waittill("death", _id_6181DE250AFA5BB6, meansofdeath);
  _id_506B3DEBE7F6D9D0 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "vehicleKiller");
  _id_8571123198E1B65C = undefined;

  if(isDefined(_id_506B3DEBE7F6D9D0))
    _id_6181DE250AFA5BB6 = _id_506B3DEBE7F6D9D0;

  if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6)) {
    _id_AF65ABF8CF095694 = "none";
    _id_22CAF6654438C835 = 0;

    if(isDefined(meansofdeath)) {
      _id_AF65ABF8CF095694 = meansofdeath;

      if(meansofdeath == "MOD_HEAD_SHOT")
        _id_22CAF6654438C835 = 1;
    }

    _id_19F06B9A4A523B5F = _id_6181DE250AFA5BB6 getcurrentweapon();
    _id_8571123198E1B65C = _id_19F06B9A4A523B5F issilenced();
    _id_6181DE250AFA5BB6 dlog_recordplayerevent("dlog_event_dmz_player_killed_ai", ["means_of_death", _id_AF65ABF8CF095694, "playerweapon", _id_19F06B9A4A523B5F.basename, "isheadshot", _id_22CAF6654438C835]);
  }

  _id_8227176423F57171 = isDefined(meansofdeath) && meansofdeath == "MOD_DESPAWN";
  _id_171F90B9C4C76D44 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "poiName");
  _id_D1CF55B36FACF5A8 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "subArea");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("analytics", "agent_killed"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("analytics", "agent_killed")]](agent, _id_8227176423F57171, _id_6181DE250AFA5BB6);

  if(!istrue(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "skipDeathCount")) && !istrue(_id_8227176423F57171)) {
    level._id_41670C1C65F3D3CF._id_25087194B5E05D51++;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && isDefined(_id_171F90B9C4C76D44))
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51++;

    _id_3DAEFB936272829F(_id_171F90B9C4C76D44, agent.origin, gettime(), _id_D1CF55B36FACF5A8);
    thread _id_BE9C6FBD4DC69254(agent, _id_6181DE250AFA5BB6);
    agent thread _id_CDCCE09B74C7CD1B(meansofdeath);

    if(isDefined(_id_028173FD6B5A461F))
      _id_028173FD6B5A461F._id_13235D60C661E10B--;

    team = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "team");
    _id_B33A80B19A9BF0BC = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "assignedObjective");

    if(isDefined(_id_B33A80B19A9BF0BC))
      _id_B33A80B19A9BF0BC._id_99669E1E71DBD643[team] = scripts\engine\utility::array_remove(_id_B33A80B19A9BF0BC._id_99669E1E71DBD643[team], agent);

    _id_A5DAF6A4BAF26AAF = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "agentStruct");

    if(isDefined(_id_A5DAF6A4BAF26AAF)) {
      if(isDefined(_id_A5DAF6A4BAF26AAF.group))
        [[_id_A5DAF6A4BAF26AAF.ondeath]](agent, _id_6181DE250AFA5BB6);
      else if(isDefined(level._id_59CFFB78293FE83C) && isDefined(level._id_59CFFB78293FE83C.ondeath))
        [[level._id_59CFFB78293FE83C.ondeath]](agent, _id_6181DE250AFA5BB6);
    }
  }

  _id_1E5307C0D848A9CA(agent, _id_171F90B9C4C76D44);
  _id_691D163CD3F6FD1A(agent);

  if(isDefined(_id_D1CF55B36FACF5A8)) {
    _id_C65D2D9103FB2B4A(agent, _id_D1CF55B36FACF5A8);

    if(!istrue(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "skipDeathCount"))) {
      delay = 0;
      _id_9803106556B1A53D = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "lastNonSilencedDamageTime");

      if(istrue(_id_8571123198E1B65C) && (!isDefined(_id_9803106556B1A53D) || isDefined(_id_9803106556B1A53D) && gettime() - _id_9803106556B1A53D > level._id_96ABDB45AEE491FC * 1000))
        delay = level._id_5DCCCC815E25C8E2;

      level thread _id_95C315B1E51BD9C5(_id_D1CF55B36FACF5A8, delay);
    }
  }

  _id_E8C88FA7F10040ED = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "cqbNode");

  if(isDefined(_id_E8C88FA7F10040ED))
    _id_120270BD0A747A35::_id_25190883A02FDEF7(_id_E8C88FA7F10040ED);

  waittillframeend;
  _id_371B4C2AB5861E62::_id_51DE6DA7B0DCF26F(agent);
}

_id_1D52040F64B0D854(_id_171F90B9C4C76D44) {
  idle = 0;
  _id_297E24357423A680 = 0;
  combat = 0;
  hunt = 0;

  if(isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"])) {
    foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]) {
      foreach(agent in _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) {
        if(!isagent(agent)) {
          idle++;
          continue;
        }

        if(!istrue(agent.stealth_enabled)) {
          if(isDefined(agent.enemy))
            combat++;
          else
            idle++;

          continue;
        }

        if(agent[[agent.fnisinstealthidle]]()) {
          idle++;
          continue;
        }

        if(agent[[agent.fnisinstealthinvestigate]]()) {
          _id_297E24357423A680++;
          continue;
        }

        if(agent[[agent.fnisinstealthcombat]]()) {
          combat++;
          continue;
        }

        if(agent[[agent.fnisinstealthhunt]]())
          hunt++;
      }
    }
  } else if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      if(!isalive(agent)) {
        continue;
      }
      if(agent[[agent.fnisinstealthidle]]()) {
        idle++;
        continue;
      }

      if(agent[[agent.fnisinstealthinvestigate]]()) {
        _id_297E24357423A680++;
        continue;
      }

      if(agent[[agent.fnisinstealthcombat]]()) {
        combat++;
        continue;
      }

      if(agent[[agent.fnisinstealthhunt]]())
        hunt++;
    }
  }

  return [idle, _id_297E24357423A680, combat, hunt];
}

_id_BC423135571B28C1() {
  level endon("game_ended");

  for(;;) {
    if(getdvarint("dvar_27877364A9AF40A5", 0) == 1) {
      _id_FA77D17200596805 = getaicount();
      logstring("Current agent count = " + _id_FA77D17200596805);
      wait 30;
      continue;
    }

    wait 1;
  }
}

_id_C05702CC1F931B44() {
  level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89 = ["absolute", "high", "medium", "low", "filler"];
  level._id_41670C1C65F3D3CF._id_1D7DE2571D2C82A7 = scripts\engine\utility::array_reverse(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89);
  _func_1C161B20F0C6C6B5(level._id_41670C1C65F3D3CF._id_09162C9F5F3A9D89);
}

_id_80136FB230FD0646(agent, priority) {
  agent.priority = priority;
  _func_E812B7065161DA79(agent, priority);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "priority", priority);
}

_id_6FDAD75E06D99A21(_id_451A9D27D63C746B, priority) {
  _func_E812B7065161DA79(_id_451A9D27D63C746B, priority);
}

_id_691D163CD3F6FD1A(agent) {
  priority = _id_2F6E6BB2B1FE3EEA(agent);
  _func_C36F897D56E28169(agent, priority);
}

_id_A12C7E6BF3EBA1ED(_id_451A9D27D63C746B) {
  priority = _id_371B4C2AB5861E62::_id_072D6808216B4D44(level._id_879053468F168806[_id_451A9D27D63C746B].priority);
  _func_C36F897D56E28169(_id_451A9D27D63C746B, priority);
}

_id_2F6E6BB2B1FE3EEA(agent) {
  return _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "priority");
}

_id_DAEB7849456192A9(priority) {
  return _func_B4B9401715CF98EA(priority);
}

_id_44C0059E33F55F00(priority) {
  return _func_7EB04CA16D045775(priority);
}

_id_72AE84D7068BE83F(priority) {
  return _func_5508DDEA3A84DF39(priority);
}

_id_80CD0109B7F5161D() {
  level._id_360542B7EA0D5403 = getdvarint("dvar_2AC28FC028BD24F6", 1);

  if(isDefined(level._id_B205D90302DA2F07)) {
    foreach(_id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
        if(!istrue(_id_D1CF55B36FACF5A8._id_1673E56336A38D1B))
          _id_567F8F8CD379059C(_id_D1CF55B36FACF5A8);
      }
    }
  }
}

_id_B4367B762AB15E1F() {
  if(isDefined(level._id_B205D90302DA2F07))
    _id_18076FC4F3FBC0D4();
  else
    _id_271DAFF60F7D1DE3();
}

_id_591B22E0CA8A8BE1(node, _id_A784428198C5658B, _id_BA8B04EB4B683E67, priority, category, _id_1C9CB43BCF3EB16D, _id_171F90B9C4C76D44, _id_D1CF55B36FACF5A8) {
  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = node._id_B205D90302DA2F07;

  if(!isDefined(_id_171F90B9C4C76D44))
    node._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

  aitype = _id_D5BC07EABF352ABB(node, _id_171F90B9C4C76D44);
  groupname = _id_59CDFE39E161A336(node);
  agent = _id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, undefined, undefined, _id_171F90B9C4C76D44, undefined, undefined, undefined, node.agent_type, undefined, _id_D1CF55B36FACF5A8);

  if(isDefined(agent)) {
    if(isagent(agent)) {
      if(istrue(_id_A784428198C5658B))
        agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, _id_BA8B04EB4B683E67);
      else if(isDefined(level._id_1C8CBD78AF4920D0))
        agent thread[[level._id_1C8CBD78AF4920D0]](agent);
      else
        agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent);
    } else if(isint(agent)) {
      if(istrue(_id_A784428198C5658B))
        _id_120270BD0A747A35::_id_D1E130608E4F8487(agent, node.origin, _id_BA8B04EB4B683E67);
      else
        _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, node.origin);
    }
  }

  return agent;
}

_id_3DCF83BCEF7081BA(pathstruct, _id_7ADE8FAC6578B011, maxagents, _id_F28F3885995A439D, priority, category, _id_1C9CB43BCF3EB16D) {
  agents = [];
  path = pathstruct.path;
  angles = (0, 0, 0);

  if(isDefined(path[0].angles))
    angles = path[0].angles;

  if(isDefined(path[0]._id_7ADE8FAC6578B011))
    _id_7ADE8FAC6578B011 = path[0]._id_7ADE8FAC6578B011;

  if(!isDefined(_id_7ADE8FAC6578B011))
    _id_7ADE8FAC6578B011 = 1;
  else
    _id_7ADE8FAC6578B011 = int(_id_7ADE8FAC6578B011);

  if(isDefined(path[0].maxagents))
    maxagents = path[0].maxagents;

  if(!isDefined(maxagents))
    maxagents = 1;
  else
    maxagents = int(maxagents);

  numagents = _id_7ADE8FAC6578B011;

  if(_id_7ADE8FAC6578B011 < maxagents)
    numagents = randomintrange(_id_7ADE8FAC6578B011, maxagents);

  _id_10AC129919E367B5 = [];
  _id_10AC129919E367B5[0] = path[0]._id_26242E8921AE5B22;
  _id_10AC129919E367B5[1] = path[0]._id_26242D8921AE58EF;
  _id_10AC129919E367B5[2] = path[0]._id_26242C8921AE56BC;
  _id_10AC129919E367B5[3] = path[0]._id_26242B8921AE5489;
  _id_10AC129919E367B5[4] = path[0]._id_26242A8921AE5256;
  _id_10AC129919E367B5[5] = path[0]._id_2624298921AE5023;
  groupname = undefined;

  if(isDefined(_id_F28F3885995A439D))
    groupname = _id_F28F3885995A439D.name;

  min = 30;
  max = 31;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    _id_FCDC7F62624C71FF = undefined;
    _id_1439F86640D42E34 = undefined;

    if(isDefined(_id_10AC129919E367B5[_id_AC0E594AC96AA3A8])) {
      if(issubstr(tolower(_id_10AC129919E367B5[_id_AC0E594AC96AA3A8]), "spawnset"))
        _id_FCDC7F62624C71FF = getsubstr(_id_10AC129919E367B5[_id_AC0E594AC96AA3A8], 9, _id_10AC129919E367B5[_id_AC0E594AC96AA3A8].size);
      else
        _id_1439F86640D42E34 = _id_10AC129919E367B5[_id_AC0E594AC96AA3A8];
    } else {
      _id_FCDC7F62624C71FF = "spawnset_patrol_primary";

      if(_id_AC0E594AC96AA3A8 > 0)
        _id_FCDC7F62624C71FF = "spawnset_patrol_secondary";
    }

    _id_E0386CBFBCCBBC5B = spawnStruct();
    _id_E0386CBFBCCBBC5B.agent_type = path[0].agent_type;
    _id_E0386CBFBCCBBC5B._id_B205D90302DA2F07 = path[0]._id_B205D90302DA2F07;
    _id_E0386CBFBCCBBC5B._id_71AD22C5D093D90B = path[0]._id_71AD22C5D093D90B;
    _id_E0386CBFBCCBBC5B.origin = path[0].origin;
    _id_E0386CBFBCCBBC5B._id_8E5A9B658FA525ED = path[0]._id_8E5A9B658FA525ED;
    _id_E0386CBFBCCBBC5B.script_noteworthy = scripts\engine\utility::ter_op(isDefined(_id_10AC129919E367B5[_id_AC0E594AC96AA3A8]), _id_10AC129919E367B5[_id_AC0E594AC96AA3A8], _id_FCDC7F62624C71FF);
    aitype = _id_D5BC07EABF352ABB(_id_E0386CBFBCCBBC5B, path[0]._id_B205D90302DA2F07, _id_FCDC7F62624C71FF, _id_1439F86640D42E34);
    angles = (angles[0], randomint(360), angles[2]);
    _id_BCFEC646853A95C1 = randomfloatrange(min, max) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(min, max) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    _id_FB1DEF007972B25A = _id_120270BD0A747A35::_id_61CBC488B27A6E61(path[0].origin + (_id_BCFEC646853A95C1, _id_BCFEC546853A938E, 0));
    agent = _id_EA94A8BF24D3C5EF(aitype, _id_FB1DEF007972B25A, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, undefined, undefined, path[0]._id_B205D90302DA2F07, undefined, undefined, undefined, path[0].agent_type);

    if(isDefined(agent))
      agents[_id_AC0E594AC96AA3A8] = agent;
  }

  waitframe();
  _id_F646EFE73AAE53DC = 1;

  foreach(agent in agents) {
    if(isint(agent)) {
      _id_F646EFE73AAE53DC = 0;
      break;
    }
  }

  if(_id_F646EFE73AAE53DC)
    level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(agents, pathstruct);
  else {
    foreach(agent in agents)
    level thread _id_120270BD0A747A35::_id_25CC93D439C3033A([agent], pathstruct);
  }

  return agents;
}

_id_18076FC4F3FBC0D4() {
  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    if(isDefined(_id_B205D90302DA2F07["subAreas"]) && _id_B205D90302DA2F07["subAreas"].size > 0) {
      foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
        if(!istrue(_id_D1CF55B36FACF5A8._id_1673E56336A38D1B))
          _id_B2B01599B30CFE2F(_id_D1CF55B36FACF5A8);
      }

      continue;
    } else {
      _id_FC617751F654A141 = 0;

      if(_func_ABBD4595D76CCC5E(_id_171F90B9C4C76D44, "everybody") < level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"]._id_74FD03286DAECF85)
        _id_FC617751F654A141 = int(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"]._id_74FD03286DAECF85 - _func_ABBD4595D76CCC5E(_id_171F90B9C4C76D44, "everybody"));
      else
        return;

      _id_D8FDD5B8B53E1735 = int(_id_FC617751F654A141 / 2);
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"] = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"]);

      foreach(_id_FB1DEF007972B25A in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"]) {
        if(_id_4948CDF739393D2D::_id_2CDE636A73AEAD3D(_id_FB1DEF007972B25A.origin)) {
          continue;
        }
        _id_A784428198C5658B = issubstr(_id_FB1DEF007972B25A.script_noteworthy, "stationary") || istrue(_id_FB1DEF007972B25A._id_A784428198C5658B);
        agent = _id_591B22E0CA8A8BE1(_id_FB1DEF007972B25A, _id_A784428198C5658B, undefined, "low", "extraGuards", undefined, _id_171F90B9C4C76D44);

        if(isDefined(agent)) {
          _id_D8FDD5B8B53E1735--;
          _id_FC617751F654A141--;

          if(_id_D8FDD5B8B53E1735 == 0) {
            break;
          }
        }
      }

      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["patrolPaths"] = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["patrolPaths"]);

      foreach(pathstruct in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["patrolPaths"]) {
        if(istrue(pathstruct.claimed))
          continue;
        else {
          pathstruct.claimed = 1;
          agents = _id_3DCF83BCEF7081BA(pathstruct, min(_id_FC617751F654A141, level._id_33CF4079B4096EB8), min(_id_FC617751F654A141, level._id_1BDF3AF6B78DC2CA), undefined, "low", "extraPatrols");

          if(isDefined(agents))
            _id_FC617751F654A141 = _id_FC617751F654A141 - agents.size;

          if(_id_FC617751F654A141 <= 0) {
            break;
          }
        }
      }
    }
  }
}

_id_B2B01599B30CFE2F(_id_D1CF55B36FACF5A8) {
  _id_FC617751F654A141 = 0;

  if(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85)
    _id_FC617751F654A141 = int(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85 - _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size);
  else
    return;

  _id_D8FDD5B8B53E1735 = int(_id_FC617751F654A141 / 2);
  level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["looseGuardNodes"] = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["looseGuardNodes"]);

  foreach(_id_FB1DEF007972B25A in level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["looseGuardNodes"]) {
    if(_id_FB1DEF007972B25A._id_71AD22C5D093D90B != _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B) {
      continue;
    }
    if(_id_4948CDF739393D2D::_id_2CDE636A73AEAD3D(_id_FB1DEF007972B25A.origin)) {
      continue;
    }
    _id_FB1DEF007972B25A._id_01E9D8E53EEEC48A = 1;
    _id_A784428198C5658B = issubstr(_id_FB1DEF007972B25A.script_noteworthy, "stationary") || istrue(_id_FB1DEF007972B25A._id_A784428198C5658B);
    agent = _id_591B22E0CA8A8BE1(_id_FB1DEF007972B25A, _id_A784428198C5658B, undefined, "low", "extraGuards", undefined, _id_D1CF55B36FACF5A8._id_B205D90302DA2F07, _id_D1CF55B36FACF5A8);

    if(isDefined(agent)) {
      _id_D8FDD5B8B53E1735--;
      _id_FC617751F654A141--;

      if(_id_D8FDD5B8B53E1735 == 0) {
        break;
      }
    }
  }

  level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["patrolPaths"] = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["patrolPaths"]);

  foreach(pathstruct in level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["patrolPaths"]) {
    if(pathstruct._id_71AD22C5D093D90B != _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B) {
      continue;
    }
    if(istrue(pathstruct.claimed))
      continue;
    else {
      pathstruct.claimed = 1;
      pathstruct._id_01E9D8E53EEEC48A = 1;
      agents = _id_3DCF83BCEF7081BA(pathstruct, min(_id_FC617751F654A141, level._id_33CF4079B4096EB8), min(_id_FC617751F654A141, level._id_1BDF3AF6B78DC2CA), undefined, "low", "extraPatrols");

      if(isDefined(agents))
        _id_FC617751F654A141 = _id_FC617751F654A141 - agents.size;

      if(_id_FC617751F654A141 <= 0) {
        break;
      }
    }
  }
}

_id_271DAFF60F7D1DE3() {
  if(istrue(level._id_947CC8C185B0EA9C)) {
    foreach(area in level._id_F81CB9EAD7B61AC1) {
      if(!istrue(area._id_1673E56336A38D1B))
        _id_B2B01599B30CFE2F(area);
    }

    return;
  }

  level._id_23D3E499C3DDE07B = scripts\engine\utility::array_randomize(level._id_23D3E499C3DDE07B);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getdvarint("dvar_C70617339B76D58B", 15); _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level._id_23D3E499C3DDE07B[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    _id_A784428198C5658B = issubstr(level._id_23D3E499C3DDE07B[_id_AC0E594AC96AA3A8].script_noteworthy, "stationary") || istrue(level._id_23D3E499C3DDE07B[_id_AC0E594AC96AA3A8]._id_A784428198C5658B);
    _id_591B22E0CA8A8BE1(level._id_23D3E499C3DDE07B[_id_AC0E594AC96AA3A8], _id_A784428198C5658B, undefined, "low", "extraGuards");
  }

  _id_3B7047DEA3E6835C = getdvarint("dvar_6091D5BB83AF8214", 15);
  _id_BEEC4BCF2979EE14 = 0;
  level._id_4E8126C3305A5431 = scripts\engine\utility::array_randomize(level._id_4E8126C3305A5431);

  foreach(pathstruct in level._id_4E8126C3305A5431) {
    if(istrue(pathstruct.claimed))
      continue;
    else {
      pathstruct.claimed = 1;
      _id_BEEC4BCF2979EE14++;
      _id_3DCF83BCEF7081BA(pathstruct, level._id_33CF4079B4096EB8, level._id_1BDF3AF6B78DC2CA, undefined, "low", "extraPatrols");

      if(_id_BEEC4BCF2979EE14 >= _id_3B7047DEA3E6835C)
        return;
    }
  }
}

_id_0A767DBCB4DD41CE(_id_C40817516B7D2B68) {
  if(!istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  while(!isDefined(level.struct_class_names))
    waitframe();

  waitframe();
  _id_A620CB0E6444887F = getdvarint("dvar_453F9B238F7679A9", 5);
  spawned = 0;

  foreach(startpoint in _id_C40817516B7D2B68) {
    count = 0;

    if(randomint(100) < 25)
      count = 2;
    else if(randomint(100) < 50)
      count = 1;

    if(count > 0) {
      nodes = _id_5649CFAC1074189A(count, startpoint);

      foreach(node in nodes) {
        if(isDefined(node) && !istrue(node.used) && (!_id_5DEF7AF2A9F04234::_id_47D356083884F913() || isDefined(node._id_B205D90302DA2F07) && _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(node._id_B205D90302DA2F07))) {
          node.script_noteworthy = "guard";
          _id_591B22E0CA8A8BE1(node, 1, 1, "low", "firstKillFodder");
          node.used = 1;
          spawned++;
        }
      }
    }

    if(spawned >= _id_A620CB0E6444887F) {
      break;
    }
  }
}

_id_5649CFAC1074189A(num, origin) {
  nodes = level._id_EB96A5F866DD19FE;
  level._id_62BA049E99D59E0F = origin;
  nodes = scripts\engine\utility::array_sort_with_func(nodes, ::_id_5DB95EDAC4AD7C26);
  level._id_62BA049E99D59E0F = undefined;
  return scripts\engine\utility::array_slice(nodes, 0, num);
}

_id_5DB95EDAC4AD7C26(_id_61EE04CD86F17F18, _id_61EE07CD86F185B1) {
  return distance(_id_61EE04CD86F17F18.origin, level._id_62BA049E99D59E0F) < distance(_id_61EE07CD86F185B1.origin, level._id_62BA049E99D59E0F);
}

_id_636FA0FF324B1B2F() {
  _id_FC617751F654A141 = getdvarint("dvar_74A83BB7BCB5E738", 2);
  level._id_612698C6D5AB4C3B = scripts\engine\utility::array_randomize(level._id_612698C6D5AB4C3B);
  _id_CDF5B236E13A9CAE = scripts\engine\utility::random(["smg", "shotgun", "sniper"]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level._id_612698C6D5AB4C3B[_id_AC0E594AC96AA3A8])) {
      agent = _id_591B22E0CA8A8BE1(level._id_612698C6D5AB4C3B[_id_AC0E594AC96AA3A8], undefined, undefined, "medium", "elites");

      if(isDefined(agent))
        _id_371B4C2AB5861E62::_id_2C222AA74D0401F4(agent, _id_CDF5B236E13A9CAE);
    }
  }
}

_id_A09C0A759D909DC9() {
  level._id_7DA9883D4168B7F1 = [];

  if(!isDefined(level._id_09FAB40ED3326F8B)) {
    return;
  }
  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  _id_0F9382E7642D4762();
  _id_559F1C9CC3C11793();

  if(istrue(level._id_7A36D824DA6087EF))
    level thread _id_454DEE65B310ED1C();

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"] = spawnStruct();
    _id_6409D4F5F62F669C = 0;
    _id_74FD03286DAECF85 = 0;
    _id_63E6C2F5F608F74E = 0;

    if(isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44])) {
      foreach(_id_D1CF55B36FACF5A8 in level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44]) {
        _id_6409D4F5F62F669C = _id_6409D4F5F62F669C + _id_D1CF55B36FACF5A8._id_6409D4F5F62F669C;
        _id_74FD03286DAECF85 = _id_74FD03286DAECF85 + _id_D1CF55B36FACF5A8._id_74FD03286DAECF85;
        _id_63E6C2F5F608F74E = _id_63E6C2F5F608F74E + _id_D1CF55B36FACF5A8._id_63E6C2F5F608F74E;
      }
    }

    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"]._id_6409D4F5F62F669C = _id_6409D4F5F62F669C;
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"]._id_74FD03286DAECF85 = _id_74FD03286DAECF85;
    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tuning"]._id_63E6C2F5F608F74E = _id_63E6C2F5F608F74E;
  }

  level._id_9589C5A19C1A71FC = 1;
}

_id_0F9382E7642D4762() {
  table = level._id_09FAB40ED3326F8B;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);

    if(!isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44]))
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44] = [];

    _id_71AD22C5D093D90B = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 1));

    if(issubstr(_id_71AD22C5D093D90B, "tieroverride") || _id_71AD22C5D093D90B == "minVehicleSpawns")
      continue;
    else {
      _id_5C5663EBC92BF309 = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 2));
      _id_2C6BFD0B6A00FDA6 = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 3));
      _id_165262BFF9D18643 = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 4));

      if(!isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]))
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B] = spawnStruct();

      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44)) {
        _id_FA93BDF94E856F94 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 17);

        if(isDefined(_id_FA93BDF94E856F94) && _id_FA93BDF94E856F94 != "")
          _id_9110FD7B0154B211 = int(_id_FA93BDF94E856F94);
        else
          _id_9110FD7B0154B211 = getdvarfloat("dvar_5AC522852D2666D5", 2.0);

        _id_5C5663EBC92BF309 = int(_id_5C5663EBC92BF309 * _id_9110FD7B0154B211);
        _id_2C6BFD0B6A00FDA6 = int(_id_2C6BFD0B6A00FDA6 * _id_9110FD7B0154B211);
        _id_165262BFF9D18643 = int(_id_165262BFF9D18643 * _id_9110FD7B0154B211);
      }

      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_6409D4F5F62F669C = _id_5C5663EBC92BF309;
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_74FD03286DAECF85 = _id_2C6BFD0B6A00FDA6;
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_63E6C2F5F608F74E = _id_165262BFF9D18643;
      _id_F1BAB2A8FA8FE3F0 = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 7));
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_F1BAB2A8FA8FE3F0 = _id_F1BAB2A8FA8FE3F0;
      _id_A42C3E0E1B2DC645 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 8);

      if(isDefined(_id_A42C3E0E1B2DC645) && _id_A42C3E0E1B2DC645 != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_A42C3E0E1B2DC645 = _id_A42C3E0E1B2DC645;

      _id_CAB6F6D27832069A = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 9);

      if(isDefined(_id_CAB6F6D27832069A) && _id_CAB6F6D27832069A != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_CAB6F6D27832069A = _id_CAB6F6D27832069A;

      _id_1832752381C598DA = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 13);

      if(isDefined(_id_1832752381C598DA) && _id_1832752381C598DA != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_1832752381C598DA = int(_id_1832752381C598DA);

      _id_FE9D8027D120B1B6 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 14);

      if(isDefined(_id_FE9D8027D120B1B6) && _id_FE9D8027D120B1B6 != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_FE9D8027D120B1B6 = int(_id_FE9D8027D120B1B6);

      _id_A766D7C366509879 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 15);

      if(isDefined(_id_A766D7C366509879) && _id_A766D7C366509879 != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_A766D7C366509879 = int(_id_A766D7C366509879);

      _id_A743E9C3662A7857 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 16);

      if(isDefined(_id_A743E9C3662A7857) && _id_A743E9C3662A7857 != "")
        level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_A743E9C3662A7857 = int(_id_A743E9C3662A7857);
    }
  }
}

_id_559F1C9CC3C11793() {
  table = level._id_09FAB40ED3326F8B;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_171F90B9C4C76D44 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 0);

    if(_id_171F90B9C4C76D44 == "minVehicleSpawns") {
      continue;
    }
    if(issubstr(_id_171F90B9C4C76D44, "tieroverride")) {
      if(!isDefined(level._id_28AF753DEF4AB495))
        level._id_28AF753DEF4AB495 = [];

      level._id_28AF753DEF4AB495[_id_171F90B9C4C76D44] = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 5));
      continue;
    }

    if(!isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44]))
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44] = [];

    _id_71AD22C5D093D90B = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 1));
    _id_3F6D7E79D3ECD73C = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, 5));

    if(!isDefined(level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]))
      level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B] = spawnStruct();

    level._id_7DA9883D4168B7F1[_id_171F90B9C4C76D44][_id_71AD22C5D093D90B]._id_84ECAEAB58167D39 = _id_3F6D7E79D3ECD73C;
  }
}

_id_17F07BED46B1496B(_id_D1CF55B36FACF5A8) {
  if(isDefined(_id_D1CF55B36FACF5A8) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39))
    return _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;

  return 1;
}

_id_9B6306B0CD33BD79(origin) {
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
  return _id_17F07BED46B1496B(_id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44));
}

_id_BED4C95709497A6C(origin, _id_D1CF55B36FACF5A8, _id_171F90B9C4C76D44) {
  if(!isDefined(_id_D1CF55B36FACF5A8)) {
    if(!isDefined(origin))
      return _id_F851A2F41CFFA860();
    else
      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);
  }

  if(isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A42C3E0E1B2DC645))
    return _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A42C3E0E1B2DC645;

  return _id_F851A2F41CFFA860();
}

_id_454DEE65B310ED1C() {
  _id_0208F18767BE10BC = _func_F159C10D5CF8F0B4("tierOverrideVolume", "targetname");

  foreach(volume in _id_0208F18767BE10BC) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(volume.origin, 0, 1);

    if(!isDefined(_id_171F90B9C4C76D44)) {
      continue;
    }
    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"]))
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"] = [];

    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"][level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"].size] = volume;
  }
}

_id_6CDA15989D9ABAE0(origin, _id_171F90B9C4C76D44) {
  if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_171F90B9C4C76D44)) {
    return;
  }
  if(!isDefined(origin)) {
    return;
  }
  if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"])) {
    foreach(volume in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["tierOverrideVolumes"]) {
      if(ispointinvolume(origin, volume))
        return level._id_28AF753DEF4AB495[volume.script_label];
    }
  }
}

_id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

    if(isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"])) {
      foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]) {
        if(isDefined(_id_D1CF55B36FACF5A8.trigger) && ispointinvolume(origin, _id_D1CF55B36FACF5A8.trigger))
          return _id_D1CF55B36FACF5A8;
      }
    }

    return _id_6A35E8934F78D810(_id_171F90B9C4C76D44);
  }
}

_id_6A35E8934F78D810(_id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      return undefined;

    if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
      foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]) {
        if(_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B == "orphan")
          return _id_D1CF55B36FACF5A8;
      }
    }
  }
}

_id_2CB157B29DE9DBFA(agent, _id_171F90B9C4C76D44, destination) {
  origin = agent.origin;

  if(isDefined(destination))
    origin = destination;

  _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);

  if(isDefined(_id_D1CF55B36FACF5A8)) {
    _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA[_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size] = agent;
    agent._id_D1CF55B36FACF5A8 = _id_D1CF55B36FACF5A8;
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "subArea", _id_D1CF55B36FACF5A8);
  }
}

_id_ED1DF18568977A9B(origin, _id_171F90B9C4C76D44, destination, _id_451A9D27D63C746B) {
  if(!isDefined(level._id_879053468F168806[_id_451A9D27D63C746B])) {
    return;
  }
  if(isDefined(destination))
    origin = destination;

  _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);
  level._id_879053468F168806[_id_451A9D27D63C746B]._id_D1CF55B36FACF5A8 = _id_D1CF55B36FACF5A8;

  if(isDefined(_id_D1CF55B36FACF5A8))
    _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA[_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size] = _id_451A9D27D63C746B;
}

_id_C65D2D9103FB2B4A(agent, _id_D1CF55B36FACF5A8) {
  _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA = _id_371B4C2AB5861E62::_id_0F3D88B5D7353A90(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA, agent);
}

_id_F23BAC39C13E1651(_id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44)) {
      return;
    }
    foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]) {
      _id_CAB6F6D27832069A = _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_CAB6F6D27832069A;

      if(isDefined(_id_CAB6F6D27832069A)) {
        continue;
      }
      if(!isDefined(_id_D1CF55B36FACF5A8._id_5E5915F98AD5B6EA)) {
        _id_D1CF55B36FACF5A8._id_7FD57938F9F24446 = int(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E * level._id_6D6312580311C77C);
        _id_D1CF55B36FACF5A8._id_5E5915F98AD5B6EA = _id_D1CF55B36FACF5A8._id_7FD57938F9F24446;
      }

      if(istrue(_id_D1CF55B36FACF5A8._id_B3A410141A91BA67)) {
        if(_id_D1CF55B36FACF5A8._id_C2F6414586A60B86 + level._id_64E7362F9D520136 < gettime()) {
          _id_D1CF55B36FACF5A8._id_B3A410141A91BA67 = 0;
          _id_D1CF55B36FACF5A8._id_5E5915F98AD5B6EA = _id_D1CF55B36FACF5A8._id_25087194B5E05D51 + _id_D1CF55B36FACF5A8._id_7FD57938F9F24446;
        }

        continue;
      }

      if(_id_D1CF55B36FACF5A8._id_25087194B5E05D51 >= _id_D1CF55B36FACF5A8._id_5E5915F98AD5B6EA) {
        _id_D1CF55B36FACF5A8._id_B3A410141A91BA67 = 1;
        _id_D1CF55B36FACF5A8._id_C2F6414586A60B86 = gettime();
      }
    }
  }
}

_id_BAFFA48BBD15CDC6(_id_D1CF55B36FACF5A8, array) {
  _id_DE1EF71D45AD3463 = [];
  _id_E293F8F41792AF61 = [];

  foreach(agent in array) {
    _id_D6A935A3A4E7C7D1 = undefined;

    if(!isagent(agent)) {
      origin = level._id_879053468F168806[agent].origin;
      _id_171F90B9C4C76D44 = level._id_879053468F168806[agent]._id_B205D90302DA2F07;
      _id_D6A935A3A4E7C7D1 = _id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);
    } else
      _id_D6A935A3A4E7C7D1 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "subArea");

    if(!isDefined(_id_D6A935A3A4E7C7D1)) {
      continue;
    }
    if(isDefined(_id_D1CF55B36FACF5A8) && _id_D6A935A3A4E7C7D1 == _id_D1CF55B36FACF5A8) {
      _id_DE1EF71D45AD3463[_id_DE1EF71D45AD3463.size] = agent;
      continue;
    }

    _id_E293F8F41792AF61[_id_E293F8F41792AF61.size] = agent;
  }

  _id_BFC65A378A6D8EFE = scripts\engine\utility::array_combine(_id_DE1EF71D45AD3463, _id_E293F8F41792AF61);
  return _id_BFC65A378A6D8EFE;
}

_id_567F8F8CD379059C(_id_D1CF55B36FACF5A8) {
  _id_D1CF55B36FACF5A8._id_D276B08C96430BFC = scripts\engine\utility::array_randomize(_id_D1CF55B36FACF5A8._id_D276B08C96430BFC);

  foreach(_id_9000AA3A8F0B6304 in _id_D1CF55B36FACF5A8._id_D276B08C96430BFC)
  _id_376608277AA1067C(_id_9000AA3A8F0B6304, _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39, undefined, "medium", _id_D1CF55B36FACF5A8._id_B205D90302DA2F07, _id_D1CF55B36FACF5A8);

  _id_976521B91D6E7E81(_id_D1CF55B36FACF5A8);
  _id_E0389C76602A47B5(_id_D1CF55B36FACF5A8);
  _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D = scripts\engine\utility::array_randomize(_id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D);
  _id_CC08CE7CBE6143AB = 0;
  _id_2A51460B1677AB99 = 1;
  _id_00FD177C6ECC7E47 = _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_F1BAB2A8FA8FE3F0;

  if(!isDefined(_id_00FD177C6ECC7E47))
    _id_00FD177C6ECC7E47 = 1;

  while(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85 && _id_2A51460B1677AB99) {
    _id_9000AA3A8F0B6304 = _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D[_id_CC08CE7CBE6143AB];

    if(isDefined(_id_9000AA3A8F0B6304) && !istrue(_id_9000AA3A8F0B6304.spawned)) {
      agents = _id_376608277AA1067C(_id_9000AA3A8F0B6304, _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39, undefined, undefined, _id_D1CF55B36FACF5A8._id_B205D90302DA2F07, _id_D1CF55B36FACF5A8);

      if(isDefined(agents) && agents.size > 0)
        _id_CC08CE7CBE6143AB++;

      continue;
    }

    _id_2A51460B1677AB99 = 0;
  }

  _id_D1CF55B36FACF5A8._id_D276B08C96430BFC = undefined;
  _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D = undefined;
}

_id_976521B91D6E7E81(_id_D1CF55B36FACF5A8) {
  if(!isDefined(_id_D1CF55B36FACF5A8._id_78B67865EF2A33D3)) {
    return;
  }
  _id_F198C878F78DD4AB = 0;
  index = 0;
  _id_D1CF55B36FACF5A8._id_78B67865EF2A33D3 = scripts\engine\utility::array_randomize(_id_D1CF55B36FACF5A8._id_78B67865EF2A33D3);

  if(isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_1832752381C598DA)) {
    while(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85 && _id_F198C878F78DD4AB < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_1832752381C598DA) {
      _id_FB1DEF007972B25A = _id_D1CF55B36FACF5A8._id_78B67865EF2A33D3[index];

      if(!isDefined(_id_FB1DEF007972B25A)) {
        return;
      }
      _id_FB1DEF007972B25A.script_noteworthy = "guard_sniper";
      agent = _id_591B22E0CA8A8BE1(_id_FB1DEF007972B25A, 0, undefined, "medium", "spawnPackage", undefined, _id_D1CF55B36FACF5A8._id_B205D90302DA2F07, _id_D1CF55B36FACF5A8);

      if(isDefined(agent)) {
        _id_F198C878F78DD4AB++;
        index++;
      }
    }
  }

  _id_F198C878F78DD4AB = 0;

  if(isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_FE9D8027D120B1B6)) {
    while(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85 && _id_F198C878F78DD4AB < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_FE9D8027D120B1B6) {
      _id_FB1DEF007972B25A = _id_D1CF55B36FACF5A8._id_78B67865EF2A33D3[index];

      if(!isDefined(_id_FB1DEF007972B25A)) {
        return;
      }
      _id_FB1DEF007972B25A.script_noteworthy = "guard_rpg";
      agent = _id_591B22E0CA8A8BE1(_id_FB1DEF007972B25A, 0, undefined, "medium", "spawnPackage", undefined, _id_D1CF55B36FACF5A8._id_B205D90302DA2F07, _id_D1CF55B36FACF5A8);

      if(isDefined(agent)) {
        _id_F198C878F78DD4AB++;
        index++;
      }
    }
  }
}

_id_E0389C76602A47B5(_id_D1CF55B36FACF5A8) {
  if(!isDefined(_id_D1CF55B36FACF5A8._id_2976480563DE74DF)) {
    return;
  }
  if(!isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A766D7C366509879) || !isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A743E9C3662A7857)) {
    return;
  }
  _id_3682D28DF3CAF8B0 = 0;
  index = 0;
  _id_D1CF55B36FACF5A8._id_2976480563DE74DF = scripts\engine\utility::array_randomize(_id_D1CF55B36FACF5A8._id_2976480563DE74DF);
  _id_66FE80516790F17D = randomintrange(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A766D7C366509879, _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A743E9C3662A7857 + 1);

  while(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size < _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85 && _id_3682D28DF3CAF8B0 < _id_66FE80516790F17D) {
    _id_FB1DEF007972B25A = _id_D1CF55B36FACF5A8._id_2976480563DE74DF[index];

    if(!isDefined(_id_FB1DEF007972B25A)) {
      return;
    }
    _id_E0C08758EB0006BE = _id_FB1DEF007972B25A._id_E0C08758EB0006BE;

    if(!isDefined(_id_E0C08758EB0006BE)) {
      return;
    }
    _id_E0C08758EB0006BE.claimed = 1;
    agents = _id_3DCF83BCEF7081BA(_id_E0C08758EB0006BE, undefined, undefined, undefined, "medium", "spawnPackage");

    if(isDefined(agents)) {
      _id_3682D28DF3CAF8B0++;
      index++;
    }
  }
}

_id_376608277AA1067C(_id_9000AA3A8F0B6304, _id_84ECAEAB58167D39, _id_9E82F18DE5C8C18B, _id_81FEE161ED3B0CCD, _id_171F90B9C4C76D44, _id_D1CF55B36FACF5A8) {
  if(istrue(_id_9000AA3A8F0B6304.spawned)) {
    return;
  }
  priority = "low";

  if(isDefined(_id_81FEE161ED3B0CCD))
    priority = _id_81FEE161ED3B0CCD;

  _id_D5234F1AE07F781B = 0;
  _id_9000AA3A8F0B6304.spawned = 1;
  _id_709BA5EBD730FFAE = [];

  foreach(_id_7D5ACB0650804B86 in _id_9000AA3A8F0B6304._id_2EF873E30A270BCF) {
    if(isDefined(_id_9E82F18DE5C8C18B) && _id_D5234F1AE07F781B >= _id_9E82F18DE5C8C18B)
      return _id_D5234F1AE07F781B;

    if(!isDefined(_id_7D5ACB0650804B86._id_8E5A9B658FA525ED))
      _id_7D5ACB0650804B86._id_8E5A9B658FA525ED = _id_9000AA3A8F0B6304._id_8E5A9B658FA525ED;

    _id_A784428198C5658B = issubstr(_id_7D5ACB0650804B86.script_noteworthy, "stationary");
    agent = _id_591B22E0CA8A8BE1(_id_7D5ACB0650804B86, _id_A784428198C5658B, undefined, priority, "spawnPackage", undefined, _id_171F90B9C4C76D44, _id_D1CF55B36FACF5A8);

    if(isDefined(agent)) {
      _id_D5234F1AE07F781B++;
      _id_709BA5EBD730FFAE[_id_709BA5EBD730FFAE.size] = agent;
    }
  }

  foreach(pathstruct in _id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094) {
    if(isDefined(_id_9E82F18DE5C8C18B) && _id_D5234F1AE07F781B >= _id_9E82F18DE5C8C18B)
      return _id_D5234F1AE07F781B;

    if(isDefined(pathstruct.path) && isDefined(pathstruct.path[0]) && !isDefined(pathstruct.path[0]._id_8E5A9B658FA525ED))
      pathstruct.path[0]._id_8E5A9B658FA525ED = _id_9000AA3A8F0B6304._id_8E5A9B658FA525ED;

    agents = _id_3DCF83BCEF7081BA(pathstruct, undefined, undefined, undefined, priority, "spawnPackage");

    if(isDefined(agents)) {
      _id_D5234F1AE07F781B = _id_D5234F1AE07F781B + agents.size;
      _id_709BA5EBD730FFAE = scripts\engine\utility::array_combine(_id_709BA5EBD730FFAE, agents);
    }
  }

  if(getdvarint("dvar_5FC378F6FC9470F7", 0)) {
    foreach(_id_0E66DD9043BFECC9 in _id_9000AA3A8F0B6304._id_6C25FE44FF159D0E)
    _id_34874C98AB154F37::_id_5FAE75AF200A8054(_id_0E66DD9043BFECC9, undefined, undefined, undefined, undefined, 1, undefined, "low");
  }

  return _id_709BA5EBD730FFAE;
}

_id_50375D63A38A8F8F(agent, _id_80F4BDE7090A4773) {
  if(!isDefined(agent)) {
    return;
  }
  _id_371B4C2AB5861E62::_id_EA83C1B372E16F6D(agent, _id_80F4BDE7090A4773);

  if(isint(agent)) {
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "processSpawnedDormantAgent", ::_id_1ADB426E2765BCB2);
    return;
  }

  tier = 1;
  _id_F0EFF45E6FD10D70 = 1;

  if(issubstr(agent.agent_type, "jugg")) {
    _id_371B4C2AB5861E62::_id_E43F4000CAC35BA2(agent);
    subtype = undefined;

    if(issubstr(agent.agent_type, "merc"))
      subtype = "merc";

    agent _id_47FC06D4BB326007::_id_1CBB19FC0CAEAB00(subtype);
    agent setscriptablepartstate("loop_sounds", "music", 0);
    _id_F0EFF45E6FD10D70 = 0;
  } else if(issubstr(agent.agent_type, "tier1"))
    _id_371B4C2AB5861E62::_id_DC01679146E5F53C(agent);
  else if(issubstr(agent.agent_type, "tier2")) {
    _id_371B4C2AB5861E62::_id_DC016A9146E5FBD5(agent);
    tier = 2;
  } else if(issubstr(agent.agent_type, "tier3")) {
    _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(agent);
    tier = 3;
  }

  if(issubstr(agent.agent_type, "riotshield")) {
    _id_371B4C2AB5861E62::_id_C6EBE7215624D5A2(agent);
    _id_F0EFF45E6FD10D70 = 0;
  }

  if(isDefined(_id_80F4BDE7090A4773) && tolower(_id_80F4BDE7090A4773) == "elite")
    _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent, tier);

  if(istrue(_id_F0EFF45E6FD10D70)) {
    agent _meth_8BBCAEB23A1512EF("all", 1);
    agent _meth_859A90C664DBA240(1);
  }

  _id_D0BD037164B77387 = strtok(agent.agent_type, "_");
  _id_E97377032A878881 = _id_D0BD037164B77387[3];

  if(isDefined(level._id_9F0B40FBEB9CDDE2) && scripts\engine\utility::array_contains_key(level._id_9F0B40FBEB9CDDE2, _id_E97377032A878881)) {
    _id_64C6CED6D550CD33 = level._id_9F0B40FBEB9CDDE2[_id_E97377032A878881];
    agent _id_371B4C2AB5861E62::_id_77B8B5AF85F319D8(_id_64C6CED6D550CD33);
  }

  if(issubstr(agent.agent_type, "affected")) {
    agent setscriptablepartstate("headglow", "on");
    _id_371B4C2AB5861E62::_id_D93591A14F62DAA5(agent);
  }

  if(isDefined(level._id_A3941B9965BDD8D2))
    [[level._id_A3941B9965BDD8D2]](agent);
}

_id_95C315B1E51BD9C5(_id_D1CF55B36FACF5A8, delay) {
  if(!isDefined(_id_D1CF55B36FACF5A8)) {
    return;
  }
  if(!isDefined(delay))
    delay = 0;

  wait(delay);
  _id_D1CF55B36FACF5A8._id_25087194B5E05D51++;
}

_id_1ADB426E2765BCB2(agent) {
  if(issubstr(agent.agent_type, "affected"))
    agent setscriptablepartstate("headglow", "on");
}

set_maxsightdistsquared(value) {
  self.maxsightdistsqrd = value;
}

_id_4799BFBFBA0CF995() {
  level._id_0F5F783A9D656258 = spawnStruct();
  level._id_0F5F783A9D656258._id_1E7483D4A9C09E57 = [];

  if(getdvarint("dvar_BE15DBB5DB51168A", 0))
    level._id_0F5F783A9D656258._id_1E7483D4A9C09E57[level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size] = "heli";

  if(getdvarint("dvar_EF18872F775CBF51", 0))
    level._id_0F5F783A9D656258._id_1E7483D4A9C09E57[level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size] = "ground";

  if(getdvarint("dvar_AF2A5BCFEAB0313A", 0))
    level._id_0F5F783A9D656258._id_1E7483D4A9C09E57[level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size] = "closet";

  if(getdvarint("dvar_05BA4DA9311EC46D", 0))
    level._id_0F5F783A9D656258._id_1E7483D4A9C09E57[level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size] = "para";

  if(getdvarint("dvar_E61C7BE770AE9DE8", 1))
    level._id_0F5F783A9D656258._id_1E7483D4A9C09E57[level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size] = "elevator";

  level._id_0F5F783A9D656258._id_445E0EEDD2EC048B = [];

  if(getdvarint("dvar_A00601DC39BF335D", 0))
    level._id_0F5F783A9D656258._id_445E0EEDD2EC048B[level._id_0F5F783A9D656258._id_445E0EEDD2EC048B.size] = "sedan";

  if(getdvarint("dvar_606C2B2D9E94162D", 0))
    level._id_0F5F783A9D656258._id_445E0EEDD2EC048B[level._id_0F5F783A9D656258._id_445E0EEDD2EC048B.size] = "overland";

  if(getdvarint("dvar_A116A13B4AE556C2", 0))
    level._id_0F5F783A9D656258._id_445E0EEDD2EC048B[level._id_0F5F783A9D656258._id_445E0EEDD2EC048B.size] = "cargo";

  if(getdvarint("dvar_CAAD3249A4AF6B4B", 0))
    level._id_0F5F783A9D656258._id_445E0EEDD2EC048B[level._id_0F5F783A9D656258._id_445E0EEDD2EC048B.size] = "techo";

  if(getdvarint("dvar_C6458DE3AC612272", 0))
    level._id_0F5F783A9D656258._id_445E0EEDD2EC048B[level._id_0F5F783A9D656258._id_445E0EEDD2EC048B.size] = "jltv";

  level._id_0F5F783A9D656258._id_8F0798696A41DA93 = getdvarint("dvar_06CF658B24A4F657", 5);
  level._id_0F5F783A9D656258._id_533CFE7944A02B81 = getdvarint("dvar_FA2B8AB8386F3DF2", 3);
  level._id_F51AF0D7EFEDDF0F = getDvar("dvar_0A8E4F619345DD4F", "none");
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76 = [];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[0] = ["tier1_ground", "tier1_closet"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["0_chance"] = [50, 50];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[1] = ["tier1_ground", "tier1_closet"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["1_chance"] = [50, 50];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[2] = ["tier1_ground", "tier2_ground", "tier2_heli", "tier1_closet"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["2_chance"] = [10, 10, 15, 40];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[3] = ["tier2_ground", "tier2_heli", "tier2_closet"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["3_chance"] = [33, 44, 23];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[4] = ["tier3_ground", "tier3_heli", "tier3_para_c130", "tier3_closet"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["4_chance"] = [10, 10, 40, 25];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1 = [];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[1] = ["tier1_heli", "tier1_ground", "tier1_closet"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["1_chance"] = [35, 55, 10];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[2] = ["tier2_ground", "tier2_heli"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["2_chance"] = [35, 65];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[3] = ["tier3_ground", "tier3_heli", "tier3_para_c130"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["3_chance"] = [40, 60, 15];
  level._id_0F5F783A9D656258._id_5B02052A040E1210 = [];
  level._id_0F5F783A9D656258._id_5B02052A040E1210[0] = "tier1_heli";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[1] = "tier1_heli";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[2] = "tier2_heli";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[3] = "tier2_heli";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[4] = "tier3_heli";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F = [];
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[1] = "tier1_heli";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[2] = "tier2_heli";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[3] = "tier3_heli";
  level._id_0F5F783A9D656258._id_87F044EDA76AE14A = [];
  level._id_0F5F783A9D656258._id_87F044EDA76AE14A["tier1"] = ["sedan", "overland"];
  level._id_0F5F783A9D656258._id_87F044EDA76AE14A["tier2"] = ["overland", "cargo"];
  level._id_0F5F783A9D656258._id_87F044EDA76AE14A["tier3"] = ["jltv", "techo"];
  level._id_0F5F783A9D656258._id_48D4812167FBB628 = [];
  level._id_0F5F783A9D656258._id_48D4812167FBB628["veh9_sedan_hatchback_1985"] = ["black"];
  level._id_0F5F783A9D656258._id_48D4812167FBB628["veh9_overland_2016"] = ["black"];
  level._id_0F5F783A9D656258._id_48D4812167FBB628["veh9_mil_cargo_truck"] = ["black"];
  level._id_0F5F783A9D656258._id_48D4812167FBB628["veh9_jltv"] = ["shdw"];
  level._id_28DDEB5728C40AA2 = 1048576;
  level._id_2CEAFE81D4233D2B = 7000;
  _id_EDFC4CC2D317C6C1();
}

_id_EDFC4CC2D317C6C1() {
  if(level._id_0F5F783A9D656258._id_1E7483D4A9C09E57.size == 0) {
    return;
  }
  foreach(_id_ACA1544C91A292FD, _id_794C60CA9377A38D in level._id_0F5F783A9D656258._id_1432BD2B78DBED76) {
    _id_34D5CAA5C1FF84CE = [];
    _id_7033EACC35DA81A7 = [];

    if(!isint(_id_ACA1544C91A292FD)) {
      continue;
    }
    foreach(index, _id_64B9885277977CA8 in _id_794C60CA9377A38D) {
      _id_67F14F8315CB0F2F = strtok(_id_64B9885277977CA8, "_");

      if(!scripts\engine\utility::array_contains(level._id_0F5F783A9D656258._id_1E7483D4A9C09E57, _id_67F14F8315CB0F2F[1])) {
        _id_34D5CAA5C1FF84CE[_id_34D5CAA5C1FF84CE.size] = _id_64B9885277977CA8;
        _id_7033EACC35DA81A7[_id_7033EACC35DA81A7.size] = level._id_0F5F783A9D656258._id_1432BD2B78DBED76[_id_ACA1544C91A292FD + "_chance"][index];
      }
    }

    level._id_0F5F783A9D656258._id_1432BD2B78DBED76[_id_ACA1544C91A292FD] = _id_34D5CAA5C1FF84CE;
    level._id_0F5F783A9D656258._id_1432BD2B78DBED76[_id_ACA1544C91A292FD + "_chance"] = _id_7033EACC35DA81A7;
  }

  foreach(_id_B8559ECE1D5B1862, _id_AB614B4F9329340C in level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1) {
    _id_34D5CAA5C1FF84CE = [];
    _id_7033EACC35DA81A7 = [];

    if(!isint(_id_B8559ECE1D5B1862)) {
      continue;
    }
    foreach(index, _id_64B9885277977CA8 in _id_AB614B4F9329340C) {
      _id_67F14F8315CB0F2F = strtok(_id_64B9885277977CA8, "_");

      if(!scripts\engine\utility::array_contains(level._id_0F5F783A9D656258._id_1E7483D4A9C09E57, _id_67F14F8315CB0F2F[1])) {
        _id_34D5CAA5C1FF84CE[_id_34D5CAA5C1FF84CE.size] = _id_64B9885277977CA8;
        _id_7033EACC35DA81A7[_id_7033EACC35DA81A7.size] = level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[_id_B8559ECE1D5B1862 + "_chance"][index];
      }
    }

    level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[_id_B8559ECE1D5B1862] = _id_34D5CAA5C1FF84CE;
    level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[_id_B8559ECE1D5B1862 + "_chance"] = _id_7033EACC35DA81A7;
  }
}

_id_77ACC10C4823DD8A(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_083C3368707C68E6, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, _id_8E5A9B658FA525ED) {
  if(!istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    return;
  }
  agents = [];

  if(!isDefined(team)) {
    if(isDefined(level._id_4B195D3DD0024B9C))
      team = level._id_4B195D3DD0024B9C;
    else
      team = "team_hundred_ninety_five";
  }

  if(!isDefined(_id_083C3368707C68E6))
    _id_083C3368707C68E6 = "Unknown";

  _id_0F5F783A9D656258 = undefined;
  _id_206197E10A7A9E87 = undefined;
  _id_EFDC2688D5BFF83F = undefined;

  if(isDefined(_id_EC862C2C00C7AB5D)) {
    numagents = _id_EC862C2C00C7AB5D.numagents;
    _id_083C3368707C68E6 = _id_EC862C2C00C7AB5D._id_083C3368707C68E6;
    _id_0F5F783A9D656258 = [_id_EC862C2C00C7AB5D._id_083C3368707C68E6];
    _id_206197E10A7A9E87 = [100];
  } else if(_id_083C3368707C68E6 == "Unknown") {
    _id_6B9806915982D089 = undefined;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      if(!isDefined(_id_171F90B9C4C76D44))
        _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

      _id_D1CF55B36FACF5A8 = _id_0A44E168E8CCED18(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);

      if(isDefined(_id_D1CF55B36FACF5A8))
        _id_6B9806915982D089 = _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;
    }

    if(isDefined(_id_8E5A9B658FA525ED) && _id_8E5A9B658FA525ED == "merc" && issubstr(level.mapname, "saba")) {
      _id_0F5F783A9D656258 = ["tier1_heli", "tier2_heli", "tier3_heli", "tier3_para_c130", "tier3_closet"];
      _id_206197E10A7A9E87 = [15, 45, 25, 15, 5];
      _id_EFDC2688D5BFF83F = "tier1_heli_lbravo";
    } else {
      _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44);
      _id_0F5F783A9D656258 = level._id_0F5F783A9D656258._id_1432BD2B78DBED76[_id_ACA1544C91A292FD];
      _id_206197E10A7A9E87 = level._id_0F5F783A9D656258._id_1432BD2B78DBED76[_id_ACA1544C91A292FD + "_chance"];
      _id_EFDC2688D5BFF83F = level._id_0F5F783A9D656258._id_5B02052A040E1210[_id_ACA1544C91A292FD];

      if(isDefined(_id_6B9806915982D089) && _id_6B9806915982D089 > _id_ACA1544C91A292FD) {
        _id_0F5F783A9D656258 = level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[_id_6B9806915982D089];
        _id_206197E10A7A9E87 = level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[_id_6B9806915982D089 + "_chance"];
        _id_EFDC2688D5BFF83F = level._id_0F5F783A9D656258._id_9FF30F8C5842928F[_id_6B9806915982D089];
      }

      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44)) {
        _id_0F5F783A9D656258[_id_0F5F783A9D656258.size] = "tier3_para_c130";
        _id_206197E10A7A9E87[_id_206197E10A7A9E87.size] = 60;
        _id_0F5F783A9D656258[_id_0F5F783A9D656258.size] = "tier2_heli";
        _id_206197E10A7A9E87[_id_206197E10A7A9E87.size] = 60;
      }
    }
  }

  if(_id_083C3368707C68E6 != "Unknown")
    agents = _id_2F3B04FC531B4115(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_083C3368707C68E6, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, _id_8E5A9B658FA525ED);
  else {
    while(_id_0F5F783A9D656258.size > 0 && (!isDefined(agents) || agents.size == 0)) {
      index = _id_9B23664358B0ECC2(_id_0F5F783A9D656258, _id_206197E10A7A9E87);
      _id_083C3368707C68E6 = _id_0F5F783A9D656258[index];

      if(!isDefined(_id_EC862C2C00C7AB5D)) {
        tier = int(getsubstr(_id_083C3368707C68E6, 4, 5));
        _id_EC862C2C00C7AB5D = _id_AB14D6652E44FDA0(numagents, undefined, tier, level._id_C0E1DE2E14E458BF);
      }

      agents = _id_2F3B04FC531B4115(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_083C3368707C68E6, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, _id_8E5A9B658FA525ED);

      if(!isDefined(agents) || agents.size == 0) {
        _id_0F5F783A9D656258 = scripts\engine\utility::array_remove_index(_id_0F5F783A9D656258, index);
        _id_206197E10A7A9E87 = scripts\engine\utility::array_remove_index(_id_206197E10A7A9E87, index);

        if(_id_0F5F783A9D656258.size == 0 && isDefined(_id_EFDC2688D5BFF83F)) {
          if(istrue(level._id_BA36989C7E24E4FF)) {}

          _id_0F5F783A9D656258 = [_id_EFDC2688D5BFF83F];
          _id_206197E10A7A9E87 = [100];
          _id_EFDC2688D5BFF83F = undefined;
        }

        continue;
      }

      break;
    }
  }

  if(isDefined(agents) && isarray(agents) && agents.size > 0) {
    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && !isDefined(_id_171F90B9C4C76D44) && isDefined(agents[0]._id_B205D90302DA2F07))
      _id_171F90B9C4C76D44 = agents[0]._id_B205D90302DA2F07;

    _id_41BA451876D0900C::_id_96B7B6431450DFC0(agents.size, _id_171F90B9C4C76D44);

    if(isDefined(level._id_D1A95E3C3D6EA9FC))
      level thread _id_346CAF10322931C8(_id_171F90B9C4C76D44, _id_C5E7FCE963586EC0);
  }

  if(isDefined(agents) && isDefined(agents[0]) && isai(agents[0]))
    agents[0]._id_083C3368707C68E6 = _id_083C3368707C68E6;

  return agents;
}

_id_2F3B04FC531B4115(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_083C3368707C68E6, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, _id_8E5A9B658FA525ED) {
  agents = undefined;
  vehicle = undefined;

  if(isDefined(_id_8E5A9B658FA525ED))
    team = _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC(_id_8E5A9B658FA525ED);

  if(issubstr(_id_083C3368707C68E6, "closet") || _id_083C3368707C68E6 == "Monster Closet")
    agents = _id_9EA6EDDB437EACA5(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, undefined, undefined, undefined, _id_8E5A9B658FA525ED);
  else if((issubstr(_id_083C3368707C68E6, "ground") || _id_083C3368707C68E6 == "Ground Vehicle") && istrue(level._id_CE783FC59EA392D1)) {
    if(!istrue(level._id_0F5F783A9D656258._id_A0AA36163157D746)) {
      level._id_0F5F783A9D656258._id_A0AA36163157D746 = 1;

      foreach(index, tier in level._id_0F5F783A9D656258._id_87F044EDA76AE14A)
      level._id_0F5F783A9D656258._id_87F044EDA76AE14A[index] = scripts\engine\utility::array_remove_array(tier, level._id_0F5F783A9D656258._id_445E0EEDD2EC048B);
    }

    if(isDefined(level._id_F51AF0D7EFEDDF0F) && level._id_F51AF0D7EFEDDF0F != "none")
      vehicleoverride = level._id_F51AF0D7EFEDDF0F;
    else {
      _id_420415FFDA562173 = getsubstr(_id_083C3368707C68E6, 0, 5);

      if(!isDefined(level._id_0F5F783A9D656258._id_87F044EDA76AE14A[_id_420415FFDA562173])) {
        if(isDefined(_id_EC862C2C00C7AB5D) && isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0]) && isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0].tier))
          _id_420415FFDA562173 = "tier" + _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0].tier;
        else
          _id_420415FFDA562173 = "tier" + _id_8AF522ADA68B6477(undefined, _id_171F90B9C4C76D44, _id_C5E7FCE963586EC0);
      }

      vehicleoverride = scripts\engine\utility::random(level._id_0F5F783A9D656258._id_87F044EDA76AE14A[_id_420415FFDA562173]);
    }

    [vehicle, agents] = _id_1C47017BA325709A::_id_A5B0665E0A814BE6(numagents, _id_EC862C2C00C7AB5D, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_8E5A9B658FA525ED, vehicleoverride);
  } else if((issubstr(_id_083C3368707C68E6, "heli") || _id_083C3368707C68E6 == "Helicopter") && istrue(level._id_425DF8E23AAEF18C))
    agents = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, undefined, undefined, _id_8E5A9B658FA525ED, undefined);
  else if((issubstr(_id_083C3368707C68E6, "para") || _id_083C3368707C68E6 == "Paratroopers") && isDefined(level._id_E578A787B54AD109)) {
    _id_7ADE8FAC6578B011 = level._id_0F5F783A9D656258._id_8F0798696A41DA93;

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
      _id_7ADE8FAC6578B011 = level._id_0F5F783A9D656258._id_533CFE7944A02B81;

    if(numagents >= _id_7ADE8FAC6578B011)
      agents = _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(numagents, _id_C5E7FCE963586EC0, 10000, _id_EC862C2C00C7AB5D, priority, category, _id_1C9CB43BCF3EB16D, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, undefined, undefined, undefined, undefined, undefined, undefined, _id_8E5A9B658FA525ED);
  } else if((issubstr(_id_083C3368707C68E6, "elevator") || _id_083C3368707C68E6 == "Elevator") && (istrue(level._id_B212A36BEC6CF8DA) || isDefined(level._id_265FD51BA245ADFD)))
    agents = _id_6153E980B3EB0E1B::_id_892161AB9AD430E3(numagents, _id_EC862C2C00C7AB5D, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, undefined, undefined, undefined, _id_8E5A9B658FA525ED);

  data = spawnStruct();
  data.agents = agents;
  data._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
  data.origin = _id_C5E7FCE963586EC0;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_dmz_on_reinforce", data);
  return agents;
}

_id_9B23664358B0ECC2(_id_0F5F783A9D656258, _id_206197E10A7A9E87) {
  _id_EB6F2E9E793E992E = 0;

  foreach(_id_4CD66E97D14EC4F7 in _id_206197E10A7A9E87)
  _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_4CD66E97D14EC4F7;

  roll = randomint(_id_EB6F2E9E793E992E);
  _id_6D85FFDCB29DB6EF = 0;

  foreach(index, _id_083C3368707C68E6 in _id_0F5F783A9D656258) {
    _id_6D85FFDCB29DB6EF = _id_6D85FFDCB29DB6EF + _id_206197E10A7A9E87[index];

    if(roll < _id_6D85FFDCB29DB6EF)
      return index;
  }
}

_id_9EA6EDDB437EACA5(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_180734F7C2A9866F, _id_F03B10101D704759, _id_FB59C1AB2600D2F6, _id_8E5A9B658FA525ED, _id_15383A2C0BA96765) {
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    return;
  }
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_61CBC488B27A6E61(_id_C5E7FCE963586EC0);

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

  _id_276AC5E84835EA87 = _id_9C5A68CA1385322E(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44, _id_180734F7C2A9866F, _id_F03B10101D704759, undefined, _id_15383A2C0BA96765, 1);

  if(!isDefined(_id_276AC5E84835EA87) || !isDefined(_id_276AC5E84835EA87._id_52914617670842A1))
    return undefined;

  _id_B586C70B173DD02B = _id_276AC5E84835EA87._id_52914617670842A1;
  agents = [];
  _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44);
  _id_FCDC7F62624C71FF = "guard";

  foreach(loc in _id_B586C70B173DD02B) {
    loc.script_noteworthy = undefined;
    tier = _id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));

    if(tier != 1 && tier != 2 && tier != 3)
      tier = 1;

    aitype = _id_D5BC07EABF352ABB(loc, undefined, _id_FCDC7F62624C71FF, undefined, tier, _id_8E5A9B658FA525ED);
    agents[agents.size] = _id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "medium", "reinforcements", "closetSpawn", "closetSpawn", team, undefined, _id_171F90B9C4C76D44);

    if(agents.size >= numagents) {
      break;
    }
  }

  foreach(agent in agents)
  agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_C5E7FCE963586EC0, _id_FB59C1AB2600D2F6, undefined, undefined, 0);

  return agents;
}

_id_9C5A68CA1385322E(origin, _id_171F90B9C4C76D44, _id_5477815D6F43AECF, _id_00749DB74AA58843, _id_B1A6A85296574C99, _id_15383A2C0BA96765, _id_D815080564690FD2) {
  if(!isDefined(level._id_F1073FBD45B59A06)) {
    return;
  }
  if(!isDefined(level._id_F1073FBD45B59A06._id_7B0FE1AC52DD48E3))
    level._id_F1073FBD45B59A06._id_7B0FE1AC52DD48E3 = (getdvarint("dvar_5F174BBB593EF9F4", 60) + getdvarint("dvar_623DE28F7E6A71A2", 10)) * 1000;

  if(!isDefined(origin)) {
    return;
  }
  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

  if(!isDefined(level._id_B205D90302DA2F07) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size)) {
    return;
  }
  if(!isDefined(_id_5477815D6F43AECF))
    _id_5477815D6F43AECF = 2359296;
  else
    _id_5477815D6F43AECF = _id_5477815D6F43AECF * _id_5477815D6F43AECF;

  if(!isDefined(_id_00749DB74AA58843))
    _id_00749DB74AA58843 = 21233664;
  else
    _id_00749DB74AA58843 = _id_00749DB74AA58843 * _id_00749DB74AA58843;

  if(!isDefined(_id_B1A6A85296574C99))
    _id_B1A6A85296574C99 = 1048576;
  else
    _id_B1A6A85296574C99 = _id_B1A6A85296574C99 * _id_B1A6A85296574C99;

  _id_CE5B743E3B2DD235 = [];

  if(!istrue(_id_15383A2C0BA96765)) {
    foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1) {
      if(!isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07))
        _id_276AC5E84835EA87._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_276AC5E84835EA87.origin);

      if(_id_276AC5E84835EA87._id_B205D90302DA2F07 == _id_171F90B9C4C76D44)
        _id_CE5B743E3B2DD235[_id_CE5B743E3B2DD235.size] = _id_276AC5E84835EA87;
    }
  } else
    _id_CE5B743E3B2DD235 = level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1;

  if(_id_CE5B743E3B2DD235.size == 0)
    return undefined;

  if(istrue(_id_D815080564690FD2)) {
    _id_62B44D25259ADAA7 = [];

    foreach(_id_276AC5E84835EA87 in _id_CE5B743E3B2DD235) {
      if(isDefined(_id_276AC5E84835EA87._id_52914617670842A1) && _id_276AC5E84835EA87._id_52914617670842A1.size > 0)
        _id_62B44D25259ADAA7[_id_62B44D25259ADAA7.size] = _id_276AC5E84835EA87;
    }

    _id_CE5B743E3B2DD235 = _id_62B44D25259ADAA7;
  }

  _id_CE5B743E3B2DD235 = sortbydistance(_id_CE5B743E3B2DD235, origin);

  foreach(_id_276AC5E84835EA87 in _id_CE5B743E3B2DD235) {
    _id_32363473B223123A = 0;

    if(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size == 0) {
      _id_CE5B743E3B2DD235[0]._id_842600F7224E9A7A = gettime() + level._id_F1073FBD45B59A06._id_7B0FE1AC52DD48E3;
      return _id_CE5B743E3B2DD235[0];
    }

    if(_id_FD909D6B5CD7D4D7(_id_276AC5E84835EA87)) {
      continue;
    }
    _id_8C17B4EF1CF1B7E4 = distance2dsquared(origin, _id_276AC5E84835EA87.origin);

    if(_id_8C17B4EF1CF1B7E4 < _id_B1A6A85296574C99)
      continue;
    else if(_id_8C17B4EF1CF1B7E4 > _id_00749DB74AA58843) {
      break;
    } else {
      foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
        _id_2E6DBAD7FB1FE43B = distance2dsquared(player.origin, _id_276AC5E84835EA87.origin);

        if(_id_2E6DBAD7FB1FE43B < _id_5477815D6F43AECF) {
          _id_32363473B223123A = 1;
          continue;
        }

        if(_id_32363473B223123A) {
          break;
        }
      }
    }

    if(!_id_32363473B223123A) {
      _id_276AC5E84835EA87._id_842600F7224E9A7A = gettime() + level._id_F1073FBD45B59A06._id_7B0FE1AC52DD48E3;
      return _id_276AC5E84835EA87;
    }
  }

  return undefined;
}

_id_FD909D6B5CD7D4D7(_id_276AC5E84835EA87) {
  if(!isDefined(_id_276AC5E84835EA87._id_842600F7224E9A7A))
    return 0;

  if(_id_276AC5E84835EA87._id_842600F7224E9A7A < gettime())
    return 0;

  return 1;
}

_id_51014D65A15CF0F9() {
  if(getdvarint("dvar_C121E4A8E6B78C34", 0) == 1) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  level._id_D1A95E3C3D6EA9FC = getdvarint("dvar_3D859BF85679053C", 200) * 1000;
  level._id_E5FD74B71BDF51FA = [];
  level._id_1171D24DD4142369 = [];
  level._id_64E7362F9D520136 = getdvarint("dvar_599C5453CD5CD717", 180) * 1000;
  level._id_6D6312580311C77C = getdvarfloat("dvar_90240383479EF5F3", 1);

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
    level thread _id_EAA1254A3231F38E(_id_171F90B9C4C76D44);
  } else
    level thread _id_30EF4D9086400A2D();
}

_id_EAA1254A3231F38E(_id_171F90B9C4C76D44) {
  if(istrue(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))) {
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5DA316FB1C149F28 = getdvarint("dvar_A3AB56523EF108FD", 4);
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_D6EF83D5D956AFF0 = getdvarint("dvar_84B8647805672921", 15);
  } else
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5DA316FB1C149F28 = getdvarint("dvar_69535AA7C07DD140", 5);

  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1 = [];
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF = [];
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9 = [];
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_8BCD79921BA8147E = 0;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_9D2F71782A11C15C = 0;

  if(getdvarint("dvar_8EC821E080A0B50D", 1) == 1) {
    level._id_E5FD74B71BDF51FA[_id_171F90B9C4C76D44] = gettime();
    level._id_1171D24DD4142369[_id_171F90B9C4C76D44] = 0;
  }

  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Initalizing";
  level thread _id_E358232A03764C9B(_id_171F90B9C4C76D44);

  if(istrue(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44)))
    _id_2ACD3064A749D3BD = 1;
  else
    _id_2ACD3064A749D3BD = getdvarint("dvar_3BB3561DDB301247", 180) + randomintrange(0, 7);

  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Waiting for Initial Delay of " + _id_2ACD3064A749D3BD + " seconds.";
  wait(_id_2ACD3064A749D3BD);
  level thread _id_4BCC15A45628DA41(_id_171F90B9C4C76D44);
}

_id_E358232A03764C9B(_id_171F90B9C4C76D44) {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  _id_D2CA218EA05FA7CC = getdvarint("dvar_5F174BBB593EF9F4", 60);
  _id_08E1193FCB0683B6 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51;
  _id_205E40ADE16DAABF = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5DA316FB1C149F28;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_8BCD79921BA8147E = _id_08E1193FCB0683B6 + _id_205E40ADE16DAABF;
  _id_0745537A1E27D4E8 = 0;

  for(;;) {
    if(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51 >= level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_8BCD79921BA8147E) {
      _id_CCFBFA89358D9C83 = 2;

      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44))
        _id_CCFBFA89358D9C83 = 1;

      _id_2F977E27FA739602 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5DA316FB1C149F28 + randomintrange(_id_CCFBFA89358D9C83 * -1, _id_CCFBFA89358D9C83);
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_8BCD79921BA8147E = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_8BCD79921BA8147E + _id_2F977E27FA739602;
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1[level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1.size] = _id_2F977E27FA739602;
    }

    if(!_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44) && level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51 > 0 && level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51 != _id_0745537A1E27D4E8 && level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51 % level._id_8A7245A12448052F == 0) {
      _id_0745537A1E27D4E8 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_25087194B5E05D51;
      _id_374ECACAD63BB411(level._id_A3A884994E83CDBA, _id_171F90B9C4C76D44, "Full POI Pause");
    }

    wait 1;
  }
}

_id_4BCC15A45628DA41(_id_171F90B9C4C76D44) {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  _id_D2CA218EA05FA7CC = getdvarint("dvar_5F174BBB593EF9F4", 60);
  _id_214EFD966BF0021D = getdvarint("dvar_623DE28F7E6A71A2", 10);
  _id_E9B3C44468154BA3 = getdvarfloat("dvar_840FB3ACC78A1482", 0.5);

  for(;;) {
    if(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1.size > 0) {
      if(_id_171F90B9C4C76D44 != "saba_S5Reveal" && !istrue(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44)))
        _id_F23BAC39C13E1651(_id_171F90B9C4C76D44);

      [_id_C5E7FCE963586EC0, _id_D1CF55B36FACF5A8] = _id_08D4C6890CBEA3D1(_id_171F90B9C4C76D44);

      if(isDefined(_id_C5E7FCE963586EC0)) {
        _id_AD55D9B021F40BE1 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1[0];
        level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Queue Activated. Reinforcements requested.";

        if(istrue(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44) && isDefined(level._id_0C129FA020D92B91))) {
          _id_ED62176958DAE2EC = [];

          foreach(id in level._id_0C129FA020D92B91)
          _id_ED62176958DAE2EC[id] = 0;

          foreach(agent in _func_7E3F22E620F3F71E(_id_171F90B9C4C76D44, "everybody")) {
            if(isagent(agent)) {
              foreach(id in level._id_0C129FA020D92B91) {
                if(issubstr(agent.agent_type, "_" + id)) {
                  _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(agent.origin);

                  if(isDefined(_id_276AC5E84835EA87) && _id_4948CDF739393D2D::_id_771F278C8C749A28(_id_276AC5E84835EA87))
                    _id_ED62176958DAE2EC[id] = _id_ED62176958DAE2EC[id] + _id_E9B3C44468154BA3;

                  _id_ED62176958DAE2EC[id] = _id_ED62176958DAE2EC[id] + 1;
                }
              }

              continue;
            }

            if(isint(agent)) {
              _id_824705FCB077E8D6 = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

              foreach(id in level._id_0C129FA020D92B91) {
                if(issubstr(_id_824705FCB077E8D6.aitype, "_" + id)) {
                  _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_824705FCB077E8D6.origin);

                  if(isDefined(_id_276AC5E84835EA87) && _id_4948CDF739393D2D::_id_771F278C8C749A28(_id_276AC5E84835EA87))
                    _id_ED62176958DAE2EC[id] = _id_ED62176958DAE2EC[id] + _id_E9B3C44468154BA3;

                  _id_ED62176958DAE2EC[id] = _id_ED62176958DAE2EC[id] + 1;
                }
              }
            }
          }

          _id_8E5A9B658FA525ED = undefined;

          foreach(id, count in _id_ED62176958DAE2EC) {
            if(!isDefined(_id_8E5A9B658FA525ED))
              _id_8E5A9B658FA525ED = id;

            if(count < _id_ED62176958DAE2EC[_id_8E5A9B658FA525ED])
              _id_8E5A9B658FA525ED = id;
          }
        } else {
          _id_8E5A9B658FA525ED = _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_A42C3E0E1B2DC645;

          if(!isDefined(_id_8E5A9B658FA525ED))
            _id_8E5A9B658FA525ED = level._id_75041B516B3785C6;
        }

        if(istrue(level._id_BA36989C7E24E4FF)) {}

        _id_083C3368707C68E6 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("determineReinforceType", _id_171F90B9C4C76D44);
        _id_C5E7FCE963586EC0 = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("determineReinforceOrigin", _id_171F90B9C4C76D44, _id_083C3368707C68E6), _id_C5E7FCE963586EC0);
        agents = _id_77ACC10C4823DD8A(_id_AD55D9B021F40BE1, _id_C5E7FCE963586EC0, "medium", "reinforcements", undefined, undefined, undefined, undefined, _id_171F90B9C4C76D44, _id_083C3368707C68E6, undefined, undefined, undefined, _id_8E5A9B658FA525ED);

        if(isDefined(agents) && agents.size > 0) {
          level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1 = scripts\engine\utility::array_remove_index(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_51BAA9A0E1D139D1, 0);

          if(isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_D6EF83D5D956AFF0))
            _id_74B5B12BB6514385 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_D6EF83D5D956AFF0;
          else
            _id_74B5B12BB6514385 = _id_D2CA218EA05FA7CC + randomfloatrange(_id_214EFD966BF0021D * -1, _id_214EFD966BF0021D);

          if(istrue(level._id_BA36989C7E24E4FF)) {}

          _id_374ECACAD63BB411(_id_74B5B12BB6514385, _id_171F90B9C4C76D44, "Success");
        } else {
          if(istrue(level._id_BA36989C7E24E4FF)) {}

          level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Request Failed: Will Try Again";
          _id_374ECACAD63BB411(1, _id_171F90B9C4C76D44);
        }
      } else {
        level thread _id_81B32EA3E7797125(_id_171F90B9C4C76D44, 5, "No good reinforce loc found.");
        _id_374ECACAD63BB411(5, _id_171F90B9C4C76D44);
      }
    } else {
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Queue Empty";
      _id_374ECACAD63BB411(1, _id_171F90B9C4C76D44);
    }

    _id_E332D48077F00441(_id_171F90B9C4C76D44);
  }
}

_id_81B32EA3E7797125(_id_171F90B9C4C76D44, time, _id_401C3A2E68AAB0FD) {
  timeremaining = time;
  interval = 0.1;

  if(!isDefined(_id_401C3A2E68AAB0FD))
    _id_401C3A2E68AAB0FD = "";
  else
    _id_401C3A2E68AAB0FD = _id_401C3A2E68AAB0FD + " - ";

  while(timeremaining > 0) {
    _id_48F1DBF87DD99400 = scripts\mp\utility\script::limitdecimalplaces(timeremaining, 1);
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = _id_401C3A2E68AAB0FD + "Queue Delay : " + _id_48F1DBF87DD99400;
    wait(interval);
    timeremaining = timeremaining - interval;
  }

  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_A87122636FF072D3 = "Delay Complete. New Request Available";
}

_id_08D4C6890CBEA3D1(_id_171F90B9C4C76D44, _id_04A5B97D6BBD597A) {
  if(!isDefined(_id_04A5B97D6BBD597A))
    _id_04A5B97D6BBD597A = 1;

  _id_BE60021F92D78965 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      return [undefined, undefined];

    [origin, _id_D1CF55B36FACF5A8] = _id_A7F1B9BB31F445F1(_id_171F90B9C4C76D44);

    if(isDefined(origin))
      return [origin, _id_D1CF55B36FACF5A8];

    _id_BE60021F92D78965 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"];
  } else
    return [undefined, undefined];

  _id_955568EE845FFF79 = [];
  _id_C31CD0019EE19FA2 = [];

  foreach(_id_D1CF55B36FACF5A8 in _id_BE60021F92D78965) {
    if(istrue(_id_D1CF55B36FACF5A8._id_B3A410141A91BA67)) {
      continue;
    }
    if(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size + _id_04A5B97D6BBD597A <= _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_74FD03286DAECF85) {
      _id_955568EE845FFF79[_id_955568EE845FFF79.size] = _id_D1CF55B36FACF5A8;
      continue;
    }

    if(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA.size + _id_04A5B97D6BBD597A <= _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_63E6C2F5F608F74E)
      _id_C31CD0019EE19FA2[_id_C31CD0019EE19FA2.size] = _id_D1CF55B36FACF5A8;
  }

  if(_id_955568EE845FFF79.size > 0) {
    _id_BB61678DCE6AE026 = scripts\engine\utility::random(_id_955568EE845FFF79);
    return [_id_99B2104C78855A16(_id_BB61678DCE6AE026), _id_BB61678DCE6AE026];
  }

  if(_id_C31CD0019EE19FA2.size > 0) {
    _id_BB61678DCE6AE026 = scripts\engine\utility::random(_id_C31CD0019EE19FA2);
    return [_id_99B2104C78855A16(_id_BB61678DCE6AE026), _id_BB61678DCE6AE026];
  }

  return [undefined, undefined];
}

_id_99B2104C78855A16(_id_D1CF55B36FACF5A8) {
  _id_D80097C88DA19027 = scripts\engine\utility::array_combine(level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["paraReinforceStruct"]._id_301D639DA97100C9, level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["heliReinforceStruct"]._id_C9464C89A69010E2);

  if(isDefined(level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["elevatorReinforceLocs"]))
    _id_D80097C88DA19027 = scripts\engine\utility::array_combine(level._id_B205D90302DA2F07[_id_D1CF55B36FACF5A8._id_B205D90302DA2F07]["elevatorReinforceLocs"]);

  if(_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B != "orphan") {
    _id_ABC2B29E98E397C7 = [];

    foreach(loc in _id_D80097C88DA19027) {
      _id_4B70D7484F56A682 = _id_0A44E168E8CCED18(loc.origin, _id_D1CF55B36FACF5A8._id_B205D90302DA2F07);

      if(_id_D1CF55B36FACF5A8._id_71AD22C5D093D90B == _id_4B70D7484F56A682._id_71AD22C5D093D90B)
        _id_ABC2B29E98E397C7[_id_ABC2B29E98E397C7.size] = loc;
    }

    if(_id_ABC2B29E98E397C7.size == 0)
      return _id_D1CF55B36FACF5A8.trigger.origin;

    return scripts\engine\utility::random(_id_ABC2B29E98E397C7).origin;
  } else {
    if(_id_D80097C88DA19027.size == 0) {
      return;
    }
    return scripts\engine\utility::random(_id_D80097C88DA19027).origin;
  }
}

_id_3DAEFB936272829F(_id_171F90B9C4C76D44, origin, time, _id_D1CF55B36FACF5A8) {
  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    return;
  }
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
    return;
  }
  if(!isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9)) {
    return;
  }
  if(!isDefined(time))
    time = gettime();

  if(isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_7DE558B0868A5D85)) {
    dist = distance2dsquared(origin, level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_7DE558B0868A5D85.origin);

    if(time - level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_7DE558B0868A5D85.time < level._id_2CEAFE81D4233D2B && dist <= level._id_28DDEB5728C40AA2)
      return;
  }

  struct = spawnStruct();
  struct.origin = origin;
  struct.time = gettime();
  struct._id_D1CF55B36FACF5A8 = _id_D1CF55B36FACF5A8;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9[level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9.size] = struct;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_7DE558B0868A5D85 = struct;
}

_id_A7F1B9BB31F445F1(_id_171F90B9C4C76D44) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]))
    return [undefined, undefined];

  currenttime = gettime();
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9 = scripts\engine\utility::array_randomize(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9);

  foreach(index, loc in level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9) {
    if(currenttime > loc.time + 45000) {
      level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9[index] = undefined;
      continue;
    }

    origin = loc.origin;
    _id_D1CF55B36FACF5A8 = loc._id_D1CF55B36FACF5A8;
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_3E25B99D959168B9[index] = undefined;
    return [origin, _id_D1CF55B36FACF5A8];
  }

  return [undefined, undefined];
}

_id_D4E513AB9AAE6AA6(_id_171F90B9C4C76D44) {
  _id_25DD3020969AA0F6 = [];

  foreach(node in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"]) {
    if(node._id_71AD22C5D093D90B == "orphan")
      _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = node;
  }

  node = scripts\engine\utility::random(_id_25DD3020969AA0F6);

  if(isDefined(node))
    return node.origin;

  return;
}

_id_B9D78FCE07834C95(_id_CF627BF100B5BAFC, _id_083C3368707C68E6) {
  _id_92DFFF01879248E6 = spawnStruct();
  _id_92DFFF01879248E6.numagents = _id_CF627BF100B5BAFC.size;
  _id_92DFFF01879248E6._id_DD4F509B9C56C76F = _id_CF627BF100B5BAFC;
  _id_92DFFF01879248E6._id_083C3368707C68E6 = _id_083C3368707C68E6;
  return _id_92DFFF01879248E6;
}

_id_DE59D7CB310C1AFF(type, tier, _id_8E5A9B658FA525ED) {
  _id_3170CA906B2241A6 = spawnStruct();

  if(!isDefined(type))
    type = _id_ED108FF3EB578327(undefined, tier);

  _id_3170CA906B2241A6.type = type;

  if(!isDefined(tier))
    tier = 1;

  _id_3170CA906B2241A6.tier = tier;
  _id_3170CA906B2241A6._id_8E5A9B658FA525ED = _id_8E5A9B658FA525ED;
  return _id_3170CA906B2241A6;
}

_id_AB14D6652E44FDA0(_id_DF3D07EBCF4ABE8A, _id_B1A6916F4FA58587, tier, _id_FCDC7F62624C71FF, _id_083C3368707C68E6) {
  _id_DD4F509B9C56C76F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DF3D07EBCF4ABE8A; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_FCDC7F62624C71FF))
      type = _id_ED108FF3EB578327(_id_FCDC7F62624C71FF, tier);
    else
      type = scripts\engine\utility::random(_id_B1A6916F4FA58587);

    _id_DD4F509B9C56C76F[_id_DD4F509B9C56C76F.size] = _id_DE59D7CB310C1AFF(type, tier);
  }

  return _id_B9D78FCE07834C95(_id_DD4F509B9C56C76F, _id_083C3368707C68E6);
}

_id_374ECACAD63BB411(_id_74B5B12BB6514385, _id_171F90B9C4C76D44, _id_8395C669FC96C418) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
    return;
  }
  if(!isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF)) {
    return;
  }
  _id_86416DF79600093C = spawnStruct();
  _id_86416DF79600093C._id_74B5B12BB6514385 = _id_74B5B12BB6514385;
  _id_86416DF79600093C._id_8395C669FC96C418 = _id_8395C669FC96C418;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF[level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF.size] = _id_86416DF79600093C;
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_9D2F71782A11C15C = 1;
}

_id_E332D48077F00441(_id_171F90B9C4C76D44) {
  level endon("game_ended");

  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
    return;
  }
  while(level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_9D2F71782A11C15C) {
    _id_70BCBF0AD5028219 = level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF;
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5531002F0448BFAF = [];
    level._id_41670C1C65F3D3CF._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_9D2F71782A11C15C = 0;

    foreach(_id_86416DF79600093C in _id_70BCBF0AD5028219) {
      if(istrue(level._id_BA36989C7E24E4FF)) {}

      level thread _id_81B32EA3E7797125(_id_171F90B9C4C76D44, _id_86416DF79600093C._id_74B5B12BB6514385, _id_86416DF79600093C._id_8395C669FC96C418);
      wait(_id_86416DF79600093C._id_74B5B12BB6514385);
    }
  }
}

_id_346CAF10322931C8(_id_171F90B9C4C76D44, origin) {
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44) || !scripts\engine\utility::array_contains(getarraykeys(level._id_B205D90302DA2F07), _id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

    if(!level._id_1171D24DD4142369[_id_171F90B9C4C76D44] && _id_6B7BEE46F2C6DA28 - level._id_E5FD74B71BDF51FA[_id_171F90B9C4C76D44] > level._id_D1A95E3C3D6EA9FC) {
      level._id_1171D24DD4142369[_id_171F90B9C4C76D44] = 1;
      level._id_E5FD74B71BDF51FA[_id_171F90B9C4C76D44] = _id_6B7BEE46F2C6DA28;
      _id_600052562A9F7FA4 = [];

      foreach(player in level.players) {
        if(isDefined(player._id_DA28916E7827AF7C) && player._id_DA28916E7827AF7C == _id_171F90B9C4C76D44)
          _id_600052562A9F7FA4[_id_600052562A9F7FA4.size] = player;
      }

      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("poi_ai_reinforce", _id_600052562A9F7FA4);
      level._id_1171D24DD4142369[_id_171F90B9C4C76D44] = 0;
    }
  } else if(!level._id_1171D24DD4142369 && (!isDefined(level._id_E5FD74B71BDF51FA) || _id_6B7BEE46F2C6DA28 - level._id_E5FD74B71BDF51FA > level._id_D1A95E3C3D6EA9FC)) {
    level._id_1171D24DD4142369 = 1;
    level._id_E5FD74B71BDF51FA = _id_6B7BEE46F2C6DA28;
    level._id_1171D24DD4142369 = 0;
  }
}

_id_353FECD1549F5F42(origin, radius, team, _id_20291AE8A5F418F1, _id_03E7224D25CB04B6, _id_87D4C4075F48EC58, _id_03618CBD8ED07704, _id_2E2A816782A04D24, _id_1B3D1C2F22B62206, targetent) {
  _id_B9999A265AA15583 = 0;

  if(!isDefined(team))
    team = "team_hundred_ninety_five";

  if(!isDefined(radius))
    radius = 1024;

  agents = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(origin, radius, team);
  _id_50F783A5617F8940 = [];

  foreach(agent in agents) {
    if(!isPlayer(agent))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = agent;
  }

  agents = _id_50F783A5617F8940;

  if(!isDefined(_id_20291AE8A5F418F1))
    _id_20291AE8A5F418F1 = 5;

  if(!isDefined(_id_03E7224D25CB04B6))
    _id_03E7224D25CB04B6 = ["extraGuards", "extraPatrols", "reinforcements", "firstKillFodder", "spawnPackage"];

  agents = sortbydistance(agents, origin);
  _id_C5A227521B066BDD = [];

  foreach(agent in agents) {
    if(isPlayer(agent)) {
      continue;
    }
    if(issubstr(agent.agent_type, "jugg")) {
      continue;
    }
    if(_id_C5A227521B066BDD.size >= _id_20291AE8A5F418F1) {
      break;
    }

    if(!istrue(_id_2E2A816782A04D24) && istrue(agent._id_9F78B0C726E807FF) || isDefined(agent.vehicle_position) && isint(agent.vehicle_position)) {
      continue;
    }
    if(!(isstring(_id_03E7224D25CB04B6) && _id_03E7224D25CB04B6 == "all") && !scripts\engine\utility::array_contains(_id_03E7224D25CB04B6, agent.category)) {
      continue;
    }
    _id_C5A227521B066BDD[_id_C5A227521B066BDD.size] = agent;
    agent._id_9F78B0C726E807FF = 1;

    if(!isDefined(_id_87D4C4075F48EC58))
      _id_87D4C4075F48EC58 = 256;

    if(!isDefined(_id_03618CBD8ED07704))
      _id_03618CBD8ED07704 = 512;

    agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin, _id_03618CBD8ED07704, _id_87D4C4075F48EC58, undefined, 1, agents, 0, _id_1B3D1C2F22B62206, targetent);
  }

  return _id_C5A227521B066BDD;
}

_id_6214774E8E021663(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_171F90B9C4C76D44, _id_B1A6A85296574C99, _id_00749DB74AA58843) {
  if(!isDefined(_id_B1A6A85296574C99))
    _id_B1A6A85296574C99 = 512;

  if(!isDefined(_id_00749DB74AA58843))
    _id_00749DB74AA58843 = 1024;

  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_61CBC488B27A6E61(_id_C5E7FCE963586EC0);
  _id_35BA2A054F831D58 = 360 / numagents;
  agents = [];
  _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= numagents; _id_AC0E594AC96AA3A8++) {
    spawnorigin = (0, randomintrange(_id_B1A6A85296574C99, _id_00749DB74AA58843), 0);
    spawnorigin = _id_C5E7FCE963586EC0 + rotatepointaroundvector((0, 0, 1), spawnorigin, _id_35BA2A054F831D58 * _id_AC0E594AC96AA3A8);
    spawnorigin = _id_120270BD0A747A35::_id_61CBC488B27A6E61(spawnorigin);
    aitype = _id_D5BC07EABF352ABB();
    agents[agents.size] = _id_EA94A8BF24D3C5EF(aitype, spawnorigin, (0, 0, 0), priority, category, _id_1C9CB43BCF3EB16D, groupname, team, undefined, _id_171F90B9C4C76D44);
  }

  return agents;
}

_id_30EF4D9086400A2D() {
  level._id_41670C1C65F3D3CF._id_5DA316FB1C149F28 = getdvarint("dvar_69535AA7C07DD140", 5);
  level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1 = [];
  level._id_41670C1C65F3D3CF._id_5531002F0448BFAF = [];
  level._id_41670C1C65F3D3CF._id_9D2F71782A11C15C = 0;

  if(getdvarint("dvar_8EC821E080A0B50D", 1) == 1) {
    level._id_D1A95E3C3D6EA9FC = getdvarint("dvar_3D859BF85679053C", 200) * 1000;
    level._id_E5FD74B71BDF51FA = 0;
    level._id_1171D24DD4142369 = 0;
  }

  level._id_A87122636FF072D3 = "Initalizing";
  level thread _id_01DDBAD36141B379();
  _id_2ACD3064A749D3BD = getdvarint("dvar_3BB3561DDB301247", 180);
  level._id_A87122636FF072D3 = "Waiting for Initial Delay of " + _id_2ACD3064A749D3BD + " seconds.";
  wait(_id_2ACD3064A749D3BD);
  level thread _id_0CC76799172C6A0F();
}

_id_01DDBAD36141B379() {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  _id_D2CA218EA05FA7CC = getdvarint("dvar_5F174BBB593EF9F4", 60);
  _id_08E1193FCB0683B6 = level._id_41670C1C65F3D3CF._id_25087194B5E05D51;
  _id_205E40ADE16DAABF = level._id_41670C1C65F3D3CF._id_5DA316FB1C149F28;
  threshold = _id_08E1193FCB0683B6 + _id_205E40ADE16DAABF;
  _id_0745537A1E27D4E8 = 0;

  for(;;) {
    if(level._id_41670C1C65F3D3CF._id_25087194B5E05D51 >= threshold) {
      _id_2F977E27FA739602 = level._id_41670C1C65F3D3CF._id_5DA316FB1C149F28 + randomintrange(-2, 2);
      threshold = threshold + _id_2F977E27FA739602;
      level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1[level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1.size] = _id_2F977E27FA739602;
    }

    if(level._id_41670C1C65F3D3CF._id_25087194B5E05D51 > 0 && level._id_41670C1C65F3D3CF._id_25087194B5E05D51 != _id_0745537A1E27D4E8 && level._id_41670C1C65F3D3CF._id_25087194B5E05D51 % level._id_8A7245A12448052F == 0) {
      _id_0745537A1E27D4E8 = level._id_41670C1C65F3D3CF._id_25087194B5E05D51;
      _id_7BBE6BC34F2E7EDF(level._id_A3A884994E83CDBA);
    }

    wait 1;
  }
}

_id_0CC76799172C6A0F() {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  _id_D2CA218EA05FA7CC = getdvarint("dvar_5F174BBB593EF9F4", 60);
  _id_214EFD966BF0021D = getdvarint("dvar_623DE28F7E6A71A2", 10);
  _id_409904714E01634A = undefined;

  for(;;) {
    if(level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1.size > 0) {
      if(!istrue(_id_409904714E01634A)) {
        level._id_A87122636FF072D3 = "Queue Activated: Waiting 10-15 secs before request.";
        wait(randomintrange(10, 15));
      }

      success = 0;
      timeout = 10000;
      _id_3BB065B9FA6A9D77 = gettime();
      _id_AD55D9B021F40BE1 = level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1[0];

      while(!success && _id_3BB065B9FA6A9D77 + timeout > gettime()) {
        level._id_A87122636FF072D3 = "Queue Activated. Reinforcements requested.";
        agents = _id_77ACC10C4823DD8A(_id_AD55D9B021F40BE1, getrandomnavpoint((0, 0, 0), 10000), "medium", "reinforcements", "maintainPopulation");

        if(isDefined(agents))
          success = 1;

        wait 0.25;
      }

      if(success) {
        level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1 = scripts\engine\utility::array_remove_index(level._id_41670C1C65F3D3CF._id_51BAA9A0E1D139D1, 0);
        _id_74B5B12BB6514385 = _id_D2CA218EA05FA7CC + randomfloatrange(_id_214EFD966BF0021D * -1, _id_214EFD966BF0021D);
        level._id_A87122636FF072D3 = "Request Successful: Delay of " + _id_74B5B12BB6514385 + " seconds.";
        _id_409904714E01634A = 1;
        wait(_id_74B5B12BB6514385);
      }
    } else {
      level._id_A87122636FF072D3 = "Queue Empty";
      _id_409904714E01634A = 0;
    }

    _id_BFDB4389E23AC40F();
    wait 1;
    _id_BFDB4389E23AC40F();
  }
}

_id_7BBE6BC34F2E7EDF(_id_74B5B12BB6514385) {
  level._id_41670C1C65F3D3CF._id_5531002F0448BFAF[level._id_41670C1C65F3D3CF._id_5531002F0448BFAF.size] = _id_74B5B12BB6514385;
  level._id_41670C1C65F3D3CF._id_9D2F71782A11C15C = 1;
}

_id_BFDB4389E23AC40F() {
  level endon("game_ended");

  while(level._id_41670C1C65F3D3CF._id_9D2F71782A11C15C) {
    _id_70BCBF0AD5028219 = level._id_41670C1C65F3D3CF._id_5531002F0448BFAF;
    level._id_41670C1C65F3D3CF._id_5531002F0448BFAF = [];
    level._id_41670C1C65F3D3CF._id_9D2F71782A11C15C = 0;

    foreach(_id_86416DF79600093C in _id_70BCBF0AD5028219) {
      level._id_A87122636FF072D3 = "Queue Paused: Current pause of " + _id_86416DF79600093C._id_74B5B12BB6514385 + " secs.";
      wait(_id_86416DF79600093C._id_74B5B12BB6514385);
    }
  }
}

_id_571151294C1A740B(tier, _id_602836E9DCD142F4) {
  while(!isDefined(level._id_0F5F783A9D656258) || !isDefined(level._id_0F5F783A9D656258._id_87F044EDA76AE14A))
    waitframe();

  level._id_0F5F783A9D656258._id_87F044EDA76AE14A["tier" + tier] = _id_602836E9DCD142F4;
}

_id_5033963EC182AFC1(type, _id_602836E9DCD142F4) {
  while(!isDefined(level._id_0F5F783A9D656258) || !isDefined(level._id_0F5F783A9D656258._id_48D4812167FBB628))
    waitframe();

  level._id_0F5F783A9D656258._id_48D4812167FBB628[type] = _id_602836E9DCD142F4;
}

_id_8DD097014829EB21() {
  wait 5;
  player = level.players[0];
  _id_F5CCB6C745FF8F0B = _id_EA94A8BF24D3C5EF(_id_7F1A2E2EBE0C1693("ar"), player.origin, player.angles, "mission", undefined, 1, player.team);
  _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(_id_F5CCB6C745FF8F0B);

  if(isDefined(_id_F5CCB6C745FF8F0B))
    _id_BEC44D71336F2D1E(_id_F5CCB6C745FF8F0B, player);
}

_id_BEC44D71336F2D1E(agent, player) {
  level endon("game_ended");
  agent endon("death");

  for(;;) {
    agent _id_120270BD0A747A35::_id_304DA84D9A815C01(player.origin, 128, 1);
    agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
    wait 3;
  }
}

_id_654314B2D2451989(agent) {
  for(;;) {
    _id_BCFEC646853A95C1 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_B30A6C38CD4FE517 = (agent.origin[0] + _id_BCFEC646853A95C1, agent.origin[1] + _id_BCFEC546853A938E, agent.origin[2]);
    agent _id_120270BD0A747A35::_setgoalpos(_id_120270BD0A747A35::_id_61CBC488B27A6E61(_id_B30A6C38CD4FE517), 10);
    wait 5;
  }
}

_id_5D07B6EF455E7876(agent, groupname) {
  if(!isDefined(level._id_455529C46F41B5E9))
    level._id_455529C46F41B5E9 = 0;

  if(!isDefined(groupname)) {
    if(isDefined(agent._id_B205D90302DA2F07))
      groupname = _id_D2D6E405DB635DC8(agent._id_B205D90302DA2F07);
    else if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
      groupname = _id_D2D6E405DB635DC8(undefined);
    else
      groupname = _id_1C52F5EDE022AFFE(agent);
  }

  if(isDefined(agent.group) && isDefined(agent.group.group_name))
    agent.script_stealthgroup = agent.group.group_name;
  else if(isDefined(groupname))
    agent.script_stealthgroup = groupname;
  else {
    if(!isDefined(groupname)) {
      groupname = "group_" + level._id_455529C46F41B5E9;
      level._id_455529C46F41B5E9++;
    }

    agent.script_stealthgroup = groupname;
  }

  if(isDefined(agent.spawnpoint)) {
    if(isDefined(agent.spawnpoint.script_stealthgroup))
      agent.script_stealthgroup = agent.spawnpoint.script_stealthgroup;

    if(isDefined(agent.spawnpoint.script_sightrange))
      agent.stealth.override_damage_auto_range = int(agent.script_sightrange);
  }

  agent thread scripts\stealth\enemy::main();
  agent thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  agent._id_BA67494935B9726B = 1;
  agent.stealth.funcs["event_combat"] = _id_120270BD0A747A35::_id_21014E3C42BCC249;
}

_id_D2D6E405DB635DC8(_id_171F90B9C4C76D44, numagents) {
  if(!isDefined(numagents))
    numagents = 1;

  if(isDefined(level._id_B205D90302DA2F07) && isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44])) {
    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"])) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"] = spawnStruct();
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_455529C46F41B5E9 = 1;
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_8C2675F7696D48FC = 0;
    }

    if(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_8C2675F7696D48FC >= 40) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_455529C46F41B5E9 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_455529C46F41B5E9 + 1;
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_8C2675F7696D48FC = 0;
    }

    level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_8C2675F7696D48FC = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_8C2675F7696D48FC + numagents;
    return _id_171F90B9C4C76D44 + "_" + level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["stealthGroupIndexing"]._id_455529C46F41B5E9;
  } else {
    if(!isDefined(level._id_50BD497EB91DC04A)) {
      level._id_50BD497EB91DC04A = 1;
      level._id_EF80E5300D000127 = 0;
    }

    if(level._id_EF80E5300D000127 >= 40) {
      level._id_50BD497EB91DC04A = level._id_50BD497EB91DC04A + 1;
      level._id_EF80E5300D000127 = 0;
    }

    level._id_EF80E5300D000127 = level._id_EF80E5300D000127 + numagents;
    return "noProvidedPOIName_" + level._id_50BD497EB91DC04A;
  }
}

_id_1C52F5EDE022AFFE(agent) {
  if(!isDefined(level._id_5A4DBA9129517D67)) {
    level._id_5A4DBA9129517D67 = [];
    level._id_C316383DD3BC8BE6 = [];
  }

  if(!isDefined(level._id_5A4DBA9129517D67[agent.team])) {
    level._id_5A4DBA9129517D67[agent.team] = 1;
    level._id_C316383DD3BC8BE6[agent.team] = 0;
  }

  if(level._id_C316383DD3BC8BE6[agent.team] >= 4) {
    level._id_5A4DBA9129517D67[agent.team] = level._id_5A4DBA9129517D67[agent.team] + 1;
    level._id_C316383DD3BC8BE6[agent.team] = 0;
  }

  level._id_C316383DD3BC8BE6[agent.team] = level._id_C316383DD3BC8BE6[agent.team] + 1;
  return "stealthGroup_" + agent.team + "_" + level._id_5A4DBA9129517D67[agent.team];
}

_id_C8393014DD7F8AB6() {
  level.default_goalradius = 2048;
  _id_07CAEBC5D4875185::main();
  scripts\engine\utility::flag_set("level_stealth_initialized");

  if(isDefined(level._id_3EED4E0BC4A30B72))
    _id_D2126DBDECED47F6 = level._id_3EED4E0BC4A30B72;
  else
    _id_D2126DBDECED47F6 = "br_saba_aieventlist";

  _func_71A28A935629A941(_id_D2126DBDECED47F6);
  level.nopathnodes = 1;
  setDvar("dvar_0DAA8C29D1AF4AB6", 1);
  _id_53DA3333B83B3527::init_gameskill();
}

_id_779B9979FD853E26(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self._id_A4738C70736D3A61))
    [[self._id_A4738C70736D3A61]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  else
    _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_912903818A06C431() {
  agent = _id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", (-14, 488, 106), (0, 0, 0), "high", "elites", "debug");

  if(!isDefined(agent)) {
    return;
  }
  _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
}

_id_78759441C259F58A(origin, numagents) {
  if(isDefined(origin)) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
    return _id_D2D6E405DB635DC8(_id_171F90B9C4C76D44, numagents);
  }

  if(!isDefined(level._id_2F98AD635074949A))
    level._id_2F98AD635074949A = 1;
  else
    level._id_2F98AD635074949A++;

  return "reinforce_" + level._id_2F98AD635074949A;
}

_id_8352FD5060043037(origin, radius) {
  if(!isDefined(origin)) {
    return;
  }
  if(!isDefined(radius))
    radius = 64;

  _id_F1A894F81AD453AF = getnodesinradius(origin, radius, 0, radius);

  foreach(node in _id_F1A894F81AD453AF) {
    if(node.type == "Begin")
      destroynavlink(node);
  }
}

_id_C9DAD3876B9D8755(agent, _id_A938130624194F25) {
  if(!isDefined(agent) || !isDefined(_id_A938130624194F25)) {
    return;
  }
  agent _meth_D493E7FE15E5EAF4(_id_A938130624194F25);
}

_id_F55D225B544277E8(agent, time) {
  if(!isDefined(agent) || !isDefined(time)) {
    return;
  }
  agent._id_CC2849446D443FFF = time * 1000;
  agent._id_226535B4DA429452 = time * 1000;
}

_id_C9B9FE3F7F739586(agent) {
  if(istrue(agent._id_102A9D2CF99AB325)) {
    return;
  }
  agent._id_65771500F49956C1 = 1;
  agent._id_102A9D2CF99AB325 = 1;
  agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");

  if(istrue(level._id_291B51C7AF8D1204))
    _id_63A043D47490F90D(agent, "brloot_equip_gasmask_durable", undefined, 0.3, 216);
  else
    _id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, 0.25, 108);

  agent._id_CD6A3A50F09688B9 = ::_id_85AEA9DB068BC292;
}

_id_85AEA9DB068BC292(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_65771500F49956C1 = 0;
  _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(agent, attacker);
}

_id_CAF96A86CA85140F(agent) {
  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087()) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_485B5A399DEF53D0(agent.origin) > level._id_33A2175A9A4306BC.radius + 1500) {
    return;
  }
  if(isDefined(agent.category) && agent.category == "BOSSES") {
    return;
  }
  _id_C9B9FE3F7F739586(agent);
}

_id_0B893EECEEF3AC7A(agent) {
  if(isDefined(level._id_184726567A9F58D8) && isDefined(level._id_808A69414F52F6BC)) {
    if(issubstr(agent.agent_type, "ar") || issubstr(agent.agent_type, "smg") || issubstr(agent.agent_type, "lmg")) {
      _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

      if(randomfloat(1) <= level._id_184726567A9F58D8 * _id_C7A4725D05BB7F22)
        _id_17DCF4B7D0A92BC3(agent);
    }
  }
}

_id_17DCF4B7D0A92BC3(agent) {
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, level.br_lootiteminfo[scripts\engine\utility::random(level._id_808A69414F52F6BC)].fullweaponobj);
}

_id_E57289D4E2128A53(_id_20450EF8C1F7BE0D) {
  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087())
    return 0;

  foreach(origin in _id_20450EF8C1F7BE0D) {
    if(_id_1174ABEDBEFE9ADA::_id_485B5A399DEF53D0(origin) < level._id_33A2175A9A4306BC.radius + 256)
      return 1;
  }

  return 0;
}

_id_8B178E05801F2DAF(path) {
  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087())
    return 0;

  foreach(loc in path) {
    if(_id_1174ABEDBEFE9ADA::_id_485B5A399DEF53D0(loc.origin) < level._id_33A2175A9A4306BC.radius + 256)
      return 1;
  }

  return 0;
}

_id_75425E32A1700C73() {
  _id_6FDC19DBCD9F04D3 = scripts\engine\utility::getStructArray("traversal_invalid", "script_noteworthy");

  foreach(loc in _id_6FDC19DBCD9F04D3)
  _id_8352FD5060043037(loc.origin);
}

_id_AF3034A7C69D7EDB(team) {
  if(!isDefined(level._id_9F08A58AA6A97F2E))
    level._id_9F08A58AA6A97F2E = [];

  level thread _id_44B88041ADC4A861(team, (0, 0, 0));

  while(!isDefined(level._id_9F08A58AA6A97F2E[team]))
    waitframe();

  return level._id_9F08A58AA6A97F2E[team];
}

_id_44B88041ADC4A861(team, _id_1F92DF5629595BC9) {
  if(isDefined(level._id_9F08A58AA6A97F2E[team])) {
    return;
  }
  level notify("spawn_hidden_agent_" + team);
  level endon("spawn_hidden_agent_" + team);
  _id_2FC80954FA70D153();
  aitype = _id_7F1A2E2EBE0C1693("ar");

  if(!isDefined(level.agent_definition["actor_" + aitype]))
    aitype = _id_7F1A2E2EBE0C1693("ar", undefined, "ru");

  if(!isDefined(level.agent_definition["actor_" + aitype]))
    aitype = _id_7F1A2E2EBE0C1693("ar", undefined, "merc");

  _id_B205D90302DA2F07 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("bossArea"))
    _id_B205D90302DA2F07 = "bossArea";

  agent = _id_EA94A8BF24D3C5EF(aitype, _id_1F92DF5629595BC9, (0, 0, 0), "absolute", "reinforcements", "hidden", undefined, team, undefined, _id_B205D90302DA2F07, 1, undefined, 0);

  if(!isDefined(agent)) {
    return;
  }
  agent.ignoreall = 1;
  agent.dontevershoot = 1;
  agent._id_B582B10663B5B2A9 = 0;
  agent.invulnerable = 1;
  agent.speedscalemult = 0;
  agent forceteleport(_id_1F92DF5629595BC9, (0, 0, 0));
  agent takeallweapons();
  agent hide();
  level._id_9F08A58AA6A97F2E[team] = agent;
}

_id_44B2BAD96489DF87() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_5F6E843FB2C4CB88 = 1;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("stealthVolumeCenters");
  else {
    level._id_9B2C6C28EEC57AFC = [];
    _id_5F6E843FB2C4CB88 = 0;
  }

  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "_stealthVolume_")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(_id_5F6E843FB2C4CB88) {
          _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1, 1);
          _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "stealthVolumeCenters", node);
          continue;
        }

        level._id_9B2C6C28EEC57AFC[level._id_9B2C6C28EEC57AFC.size] = node;
      }
    }
  }
}

_id_E86762BE42BB72B0(origin, _id_171F90B9C4C76D44) {
  if(!isDefined(origin))
    return undefined;

  _id_A0B3A72BB77AAFDD = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44) || _id_171F90B9C4C76D44 == "bossArea")
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

    _id_A0B3A72BB77AAFDD = _id_5DEF7AF2A9F04234::_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, "stealthVolumeCenters");
  } else {
    if(!isDefined(level._id_9B2C6C28EEC57AFC) || level._id_9B2C6C28EEC57AFC.size == 0)
      return undefined;

    _id_A0B3A72BB77AAFDD = level._id_9B2C6C28EEC57AFC;
  }

  if(!isDefined(_id_A0B3A72BB77AAFDD) || _id_A0B3A72BB77AAFDD.size == 0)
    return undefined;

  _id_068680CB275F40BF = sortbydistance(_id_A0B3A72BB77AAFDD, origin);
  return _id_068680CB275F40BF[0].script_noteworthy;
}

dialog_init() {}

_id_454A478E5E1FC4F2(alias, _id_171F90B9C4C76D44) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])) {
    return;
  }
  foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])
  player scripts\mp\utility\dialog::leaderdialogonplayer(alias);
}

_id_CDCCE09B74C7CD1B(meansofdeath) {
  if(istrue(level._id_9D615A366EC2FB6F) || isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION" || isDefined(self.agentteam) && self.agentteam == "civilian") {
    return;
  }
  _id_00AE14C5A8B1B582 = randomintrange(1, 8);
  type = "generic";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    type = "female";

  if(isagent(self)) {
    if(isDefined(self.unittype) && self.unittype == "zombie")
      self playSound("zmb_npc_death_generic");
    else if(isDefined(self.team) && self.team == "allies")
      self playSound(type + "_death_american_" + _id_00AE14C5A8B1B582);
    else
      self playSound(type + "_death_russian_" + _id_00AE14C5A8B1B582);
  }
}

_id_5AEE5D819F7DFD1C() {
  if(!isDefined(level.br_pickups)) {
    return;
  }
  level._id_370EED78AA5C01A5 = [];
  level._id_370EED78AA5C01A5["thermite_mp"] = "brloot_offhand_thermite";
  level._id_370EED78AA5C01A5["semtex_mp"] = "brloot_offhand_semtex";
  level._id_370EED78AA5C01A5["frag_grenade_mp"] = "brloot_offhand_frag";
  level._id_370EED78AA5C01A5["molotov_mp"] = "brloot_offhand_molotov";
  level._id_370EED78AA5C01A5["smoke_grenade_mp"] = "brloot_offhand_smoke";
  level._id_370EED78AA5C01A5["concussion_grenade_mp"] = "brloot_offhand_concussion";
  level._id_370EED78AA5C01A5["flash_grenade_mp"] = "brloot_offhand_flash";
  level._id_370EED78AA5C01A5["snapshot_grenade_mp"] = "brloot_offhand_snapshot";
  level._id_370EED78AA5C01A5["gas_mp"] = "brloot_offhand_gas";
  level._id_370EED78AA5C01A5["decoy_grenade_mp"] = "brloot_offhand_decoy";
  level._id_370EED78AA5C01A5["equip_adrenaline"] = "brloot_health_adrenaline";
  level.br_pickups.br_weapontoscriptable["iw9_ar_akilo_mp"] = "brloot_weapon_ar_akilo47_comm";
  level.br_pickups.br_weapontoscriptable["iw9_lm_mkilo3_mp"] = "brloot_weapon_lm_mkilo3_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sh_mbravo_mp"] = "brloot_weapon_sh_romeo870_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sm_mpapa5_mp"] = "brloot_weapon_sm_augolf_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sn_alpha50_mp"] = "brloot_weapon_sn_alpha50_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sm_aviktor_mp"] = "brloot_weapon_sm_uzulu_comm";
  level.br_pickups.br_weapontoscriptable["iw9_dm_mike24_mp"] = "brloot_weapon_sn_mike14_comm";
  level.br_pickups.br_weapontoscriptable["iw9_ar_augolf_mp"] = "brloot_weapon_ar_scharlie_rare";
  level.br_pickups.br_weapontoscriptable["iw9_ar_mike4_mp"] = "brloot_weapon_ar_mike4_epic";
  level.br_pickups.br_weapontoscriptable["iw9_sm_mpapa7_mp"] = "brloot_weapon_sm_mpapa7_epic";
  level.br_pickups.br_weapontoscriptable["iw8_lm_kilo121_mp"] = "brloot_weapon_lm_kilo121_lege";
  level.br_pickups.br_weapontoscriptable["iw9_sh_charlie725_mp"] = "brloot_weapon_sh_charlie725_lege";
  level.br_pickups.br_weapontoscriptable["iw8_sm_uzulu_mpv2"] = "brloot_weapon_sm_uzulu_epic";
  level.br_pickups.br_weapontoscriptable["iw9_la_rpapa7_mp"] = "brloot_weapon_la_rpapa7_rare";
}

_id_63A043D47490F90D(agent, scriptablename, lootid, _id_B5858D9A2232E324, count) {
  _id_8C8C6DBF143AB5B2(agent, _id_EDABF4238E9D70B5(scriptablename, lootid, undefined, _id_B5858D9A2232E324, count));
}

_id_8C8C6DBF143AB5B2(agent, _id_1BE58AA13BA9F7DA) {
  if(!isDefined(_id_1BE58AA13BA9F7DA.lootid))
    _id_1BE58AA13BA9F7DA.lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_1BE58AA13BA9F7DA.scriptablename);

  _id_AF94D7637FCF193E = scripts\engine\utility::_id_53C4C53197386572(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "forcedDrops"), []);
  _id_AF94D7637FCF193E[_id_AF94D7637FCF193E.size] = _id_1BE58AA13BA9F7DA;
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "forcedDrops", _id_AF94D7637FCF193E);
}

_id_82ED67AE79913551(agent, _id_DCF5E15C58C4152A, groupname) {
  _id_171F90B9C4C76D44 = agent._id_B205D90302DA2F07;
  agent notify("endLootDropThread");
  agent endon("endLootDropThread");
  _id_9AA01C8BC06A2A47 = agent._id_8AA9EFE6383C1D5A;
  droppeditems = [];
  _id_0286DE5B161DD4D9 = [];
  _id_8003724EAD57BA09 = [];
  _id_15B6FBF6B37B61AF = [];
  agent._id_0D544C62EA2BC64B = [];
  self waittill("death", _id_6181DE250AFA5BB6, meansofdeath);

  if(getdvarint("dvar_307FC239DC43BE41", 0)) {
    return;
  }
  if(isDefined(meansofdeath) && meansofdeath == "MOD_DESPAWN") {
    return;
  }
  if(istrue(agent.nocorpse)) {
    return;
  }
  if(!isDefined(level._id_370EED78AA5C01A5)) {
    return;
  }
  _id_38A6F3995A34460C = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "skipDeathCount");

  if(istrue(_id_38A6F3995A34460C)) {
    return;
  }
  _id_E99FB9EAA6B7C3DB = 0;
  _id_9A191895544553FE = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropBackpack");
  _id_A31A0BAEDB971FE5 = istrue(_id_E99FB9EAA6B7C3DB) && (!isDefined(_id_9A191895544553FE) || istrue(_id_9A191895544553FE));
  _id_63535454F47FF46A = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "weapon");
  _id_A1BD2D917C546946 = undefined;
  _id_00C100A8C1ADD8B3 = undefined;

  if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6)) {
    _id_A1BD2D917C546946 = _id_6181DE250AFA5BB6 getcurrentweapon();
    _id_00C100A8C1ADD8B3 = _id_6181DE250AFA5BB6 getentitynumber();
  }

  agent.contents = [];
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  if(isDefined(level._id_D3FB932F0373554C))
    agent[[level._id_D3FB932F0373554C]](_id_6181DE250AFA5BB6, dropstruct);

  _id_A29C2459DEC85FDE(agent, _id_DCF5E15C58C4152A, _id_63535454F47FF46A, _id_A1BD2D917C546946, !_id_A31A0BAEDB971FE5, dropstruct);
  _id_B66240F19684FF3A(agent, _id_00C100A8C1ADD8B3, !_id_A31A0BAEDB971FE5, dropstruct);
  dropweapon = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropWeapon");
  _id_9298B37ACC09B5BB = (!isDefined(dropweapon) || istrue(dropweapon)) && (!istrue(level._id_291B51C7AF8D1204) || randomfloat(1.0) < getdvarfloat("dvar_B140A55D95652FD5", 0.1));

  if(isDefined(_id_63535454F47FF46A) && _id_9298B37ACC09B5BB) {
    _id_9A9319E9E51F06AE = agent.origin;
    _id_885FB70D5302370B = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "weaponDropOrigin");

    if(isDefined(_id_885FB70D5302370B))
      _id_9A9319E9E51F06AE = _id_885FB70D5302370B;

    maxammo = undefined;

    if(issubstr(_id_63535454F47FF46A.basename, "lm_dblmg"))
      maxammo = 1;

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_9A9319E9E51F06AE, agent.angles, agent, undefined, undefined, undefined, 1);
    [ammo, _id_04F04B15053655BA, _id_35EAD47ED0D7507E] = _id_4480C6CE37B2BDF3::_id_5C9E1BD30347CB36(_id_63535454F47FF46A, maxammo);

    if(scripts\mp\utility\game::getsubgametype() == "dmz" && ammo < _id_63535454F47FF46A.clipsize)
      ammo = _id_63535454F47FF46A.clipsize;

    _id_B55314BFAEF43C59 = _id_7E52B56769FA7774::spawnpickup(_id_63535454F47FF46A.basename, _id_CB4FAD49263E20C4, ammo, undefined, _id_63535454F47FF46A, undefined, _id_04F04B15053655BA, _id_35EAD47ED0D7507E);

    if(isDefined(_id_B55314BFAEF43C59))
      _id_B55314BFAEF43C59 setscriptablepartstate(_id_B55314BFAEF43C59.type, "dropped");

    _id_19F6FBD1C4BEC7E9 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && dropstruct.dropcount == 1;

    if(_id_19F6FBD1C4BEC7E9) {
      ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_63535454F47FF46A);

      if(isDefined(ammotype)) {
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_9A9319E9E51F06AE, agent.angles, agent, undefined, undefined, undefined, 1);
        _id_E3AB82CFFD9E9B66 = int(level.br_pickups.counts[ammotype] * (1 + randomfloat(2)));
        item = _id_7E52B56769FA7774::spawnpickup(ammotype, _id_CB4FAD49263E20C4, _id_E3AB82CFFD9E9B66);
      }
    }
  }

  _id_AF94D7637FCF193E = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "forcedDrops");

  if(isDefined(_id_AF94D7637FCF193E)) {
    foreach(_id_F96A2EA6B07E345C in _id_AF94D7637FCF193E) {
      if(randomfloat(1.0) <= _id_F96A2EA6B07E345C._id_B5858D9A2232E324)
        _id_305B1BA9C9B7F7B4(!_id_A31A0BAEDB971FE5, _id_F96A2EA6B07E345C, agent, dropstruct);
    }
  }

  _id_88732A0A3C17BE02 = agent.category;
  _id_FDD4AB2C52E64567 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropKey");
  _id_DDDF3A91DAABEBD2 = !issubstr(_id_DCF5E15C58C4152A, "biolab") && _id_15497E2309BC8671(isDefined(_id_88732A0A3C17BE02) && issubstr(_id_88732A0A3C17BE02, "fortress")) && (!isDefined(_id_FDD4AB2C52E64567) || istrue(_id_FDD4AB2C52E64567));

  if(_id_DDDF3A91DAABEBD2) {
    _id_8F7EDDC9C0864A1B = scripts\engine\utility::ter_op(isDefined(level._id_4450F123BD5CD62E), level._id_4450F123BD5CD62E, "loot_key_fortress");

    if(issubstr(_id_DCF5E15C58C4152A, "merc")) {
      if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
        roll = randomint(100);

        if(roll < level._id_9C981303803AEAB3)
          _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 1, 1, 0, 0, 0, 1, 0, 20, 60, 20, "sealion");
      } else if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
        roll = randomint(100);

        if(roll < level._id_9C981303803AEAB3) {
          _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

          switch (_id_C7A4725D05BB7F22) {
            case 1:
              _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, "sabacrash");
              break;
            case 2:
              _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 1, 0, 1, 0, 80, 0, 10, 20, 60, 20, "sabacrash");
              break;
            case 3:
              _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 0, 1, 1, 0, 0, 70, 20, 20, 60, 20, "sabacrash");
              break;
            default:
              _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, "sabacrash");
              break;
          }
        }
      }
    } else if(issubstr(_id_DCF5E15C58C4152A, "aq")) {
      if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
        roll = randomint(100);

        if(roll < level._id_9C981303803AEAB3)
          _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
      }
    } else if(issubstr(_id_DCF5E15C58C4152A, "cartel")) {
      if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
        roll = randomint(100);

        if(roll < level._id_9C981303803AEAB3)
          _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
      }
    } else if(issubstr(_id_DCF5E15C58C4152A, "ru")) {
      if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
        roll = randomint(100);

        if(roll < level._id_9C981303803AEAB3)
          _id_8F7EDDC9C0864A1B = _id_57D3850A12CF1D8F::_id_23326C8AC97C60C7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, "delta");
      }
    }

    _id_E5FE6C50EC351711 = _id_EDABF4238E9D70B5(_id_8F7EDDC9C0864A1B, _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_8F7EDDC9C0864A1B), _id_8F7EDDC9C0864A1B);
    _id_305B1BA9C9B7F7B4(!_id_A31A0BAEDB971FE5, _id_E5FE6C50EC351711, agent, dropstruct);
  }

  if(!scripts\mp\loot::_id_23A3BB1172216C05(agent) && _id_A31A0BAEDB971FE5) {
    dropstruct._id_DFBA5A2C3C6F0A07 = dropstruct._id_DFBA5A2C3C6F0A07 + 2;
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
    _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup("brloot_backpack", _id_CB4FAD49263E20C4, 1);

    if(isDefined(_id_87583859F07B58E3)) {
      _id_87583859F07B58E3.contents = agent.contents;
      _id_87583859F07B58E3._id_46A3A8565AC0C17C = 2;
    }

    callback = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropCallback");

    if(isDefined(callback)) {
      if(!isDefined(_id_87583859F07B58E3)) {
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(scripts\engine\utility::drop_to_ground(agent.origin));
        _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup("brloot_backpack", _id_CB4FAD49263E20C4, 1);
        _id_87583859F07B58E3.contents = agent.contents;
        _id_87583859F07B58E3._id_46A3A8565AC0C17C = 2;
      }

      _id_AA1ED8F12D71A7A5 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "mission");
      _id_87583859F07B58E3._id_BBC200BC77C5DB2B = 1;
      thread[[callback]](agent, _id_87583859F07B58E3, _id_AA1ED8F12D71A7A5);
    }

    if(isDefined(_id_87583859F07B58E3) && isDefined(_id_87583859F07B58E3.contents)) {
      foreach(item in _id_87583859F07B58E3.contents) {
        if(isDefined(item["lootID"]) && isDefined(item["quantity"])) {
          _id_8003724EAD57BA09[_id_8003724EAD57BA09.size] = item["lootID"];
          _id_15B6FBF6B37B61AF[_id_15B6FBF6B37B61AF.size] = item["quantity"];
        }
      }
    }
  }

  agent.contents = undefined;

  if(getdvarint("dvar_B79EF01DD49B83D2", 0) || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    if(!isDefined(level._id_45E6A8385ED4F50C))
      level._id_45E6A8385ED4F50C = getdvarfloat("dvar_2CAC446C3FBE830F", 0.95);

    _id_8AF080ECC5DC34AB = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropRadio");
    _id_892F4FDD2D43920E = !isDefined(_id_8AF080ECC5DC34AB) || istrue(_id_8AF080ECC5DC34AB);

    if(randomfloat(1) > level._id_45E6A8385ED4F50C && istrue(_id_892F4FDD2D43920E)) {
      _id_C1E53D069AC3A949 = spawnscriptable("vfx_dmz_blood_pool", agent.origin, agent.angles);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
      _id_A46D287F39A98D69 = _id_7E52B56769FA7774::spawnpickup("brloot_dead_agent_radio", _id_CB4FAD49263E20C4);

      if(isDefined(_id_A46D287F39A98D69)) {
        _id_A46D287F39A98D69.entitynumber = agent getentitynumber();
        _id_A46D287F39A98D69._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
        _id_A46D287F39A98D69.droppedteam = agent.agentteam;
        thread _id_2880C23DEADCDD8F::_id_FC9A15646315764C(_id_A46D287F39A98D69);
      }
    }
  }

  if(isDefined(agent) && isDefined(_id_171F90B9C4C76D44) && _id_171F90B9C4C76D44 == "saba_S5Reveal" && isDefined(level._id_27ACC3A1E116209D) && randomfloat(1) < level._id_27ACC3A1E116209D) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
    _id_FEE0552B747A5B17 = _id_7E52B56769FA7774::spawnpickup("brloot_reveal_agent_radio", _id_CB4FAD49263E20C4);

    if(isDefined(_id_FEE0552B747A5B17)) {
      level thread _id_2880C23DEADCDD8F::_id_FC9A15646315764C(_id_FEE0552B747A5B17);
      _id_FEE0552B747A5B17 thread _id_164622EB2B0F5390::_id_1FB0A9B18699986B();
    }
  }

  if(isDefined(agent._id_0D544C62EA2BC64B)) {
    foreach(item in agent._id_0D544C62EA2BC64B) {
      if(!isDefined(item.count))
        item.count = 1;

      if(isDefined(item.lootid)) {
        droppeditems[droppeditems.size] = item.lootid;
        _id_0286DE5B161DD4D9[_id_0286DE5B161DD4D9.size] = item.count;
      }
    }
  }

  dlog_recordevent("dlog_event_dmz_ai_death", ["spawn_id", _id_9AA01C8BC06A2A47, "ai_pos_x", agent.origin[0], "ai_pos_y", agent.origin[1], "ai_pos_z", agent.origin[2], "dropped_weapon", scripts\engine\utility::ter_op(isDefined(_id_63535454F47FF46A), _id_63535454F47FF46A.basename, "undefined"), "dropped_pack_contents", _id_8003724EAD57BA09, "dropped_pack_item_count", _id_15B6FBF6B37B61AF, "ground_items", droppeditems, "ground_item_count", _id_0286DE5B161DD4D9, "match_time_elapsed", gettime()]);
  agent._id_0D544C62EA2BC64B = undefined;
}

_id_B66240F19684FF3A(agent, _id_00C100A8C1ADD8B3, _id_C6D51ABE72F8B012, dropstruct) {
  if(!isDefined(_id_00C100A8C1ADD8B3))
    return 0;

  if(!isDefined(level._id_0ADBE2E8C944C2F1))
    level._id_4FC2AB8A1090C195 = 0;

  if(!isDefined(level._id_AEB6974202E8F2DB))
    level._id_AEB6974202E8F2DB = [];

  if(!isDefined(level._id_AEB6974202E8F2DB[_id_00C100A8C1ADD8B3]))
    level._id_AEB6974202E8F2DB[_id_00C100A8C1ADD8B3] = 1;
  else
    level._id_AEB6974202E8F2DB[_id_00C100A8C1ADD8B3] = level._id_AEB6974202E8F2DB[_id_00C100A8C1ADD8B3] + 1;

  _id_4312B985C2B7C9A1 = getdvarint("dvar_ED1C109FEB095475", 0);
  _id_3B73FA3A33104EEE = getdvarint("dvar_2A74DBBDEE7B0DDA", 5);
  _id_5215312348D094A9 = getdvarint("dvar_CC254E298E64F975", 10);
  _id_C1569C52E0E8302C = getdvarint("dvar_1CE4D184EEEF06C8", 20);

  if(_id_4312B985C2B7C9A1) {
    _id_5298EFB8454B371D = level._id_AEB6974202E8F2DB[_id_00C100A8C1ADD8B3];
    _id_0526ECE09009A248 = undefined;

    if(_id_5298EFB8454B371D == _id_3B73FA3A33104EEE)
      _id_0526ECE09009A248 = _id_2958A3067F4AF3AF("agent_milestone_kills1", level._id_4FC2AB8A1090C195);
    else if(_id_5298EFB8454B371D == _id_5215312348D094A9)
      _id_0526ECE09009A248 = _id_2958A3067F4AF3AF("agent_milestone_kills2", level._id_4FC2AB8A1090C195);
    else if(_id_5298EFB8454B371D == _id_C1569C52E0E8302C)
      _id_0526ECE09009A248 = _id_2958A3067F4AF3AF("agent_milestone_kills3", level._id_4FC2AB8A1090C195);

    if(isDefined(_id_0526ECE09009A248)) {
      foreach(_id_5B63AED4A779B0AA in _id_0526ECE09009A248)
      _id_305B1BA9C9B7F7B4(_id_C6D51ABE72F8B012, _id_5B63AED4A779B0AA, agent, dropstruct);

      level._id_4FC2AB8A1090C195 = level._id_4FC2AB8A1090C195 + 1;
    }
  }
}

_id_A29C2459DEC85FDE(agent, _id_DCF5E15C58C4152A, _id_63535454F47FF46A, _id_A1BD2D917C546946, _id_C6D51ABE72F8B012, dropstruct) {
  _id_597B60C5387D1344 = _id_E266E0DFC04C07A9(agent);
  _id_85AD9C82D49013C0 = 0;
  droparmor = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropArmor");

  if(!isDefined(droparmor) || istrue(droparmor)) {
    _id_DBB496F03BD142A0 = _id_BC5D7FF26AD67A45(agent, _id_DCF5E15C58C4152A);

    if(getdvarint("dvar_F262CC542053D01C", 0) == 1) {
      _id_305B1BA9C9B7F7B4(_id_C6D51ABE72F8B012, _id_4FC5B97F88757E83(_id_DBB496F03BD142A0), agent, dropstruct);
      _id_85AD9C82D49013C0++;
    } else
      _id_597B60C5387D1344 = _id_6B1DC8167C1C7378(_id_597B60C5387D1344, _id_DBB496F03BD142A0);
  }

  dropgrenade = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropGrenade");

  if(!isDefined(dropgrenade) || istrue(dropgrenade)) {
    _id_4A354A51B7352EF8 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "grenadeType");

    if(isDefined(_id_4A354A51B7352EF8))
      _id_597B60C5387D1344 = _id_0D0F2EC7F450FCB7(_id_597B60C5387D1344, _id_4A354A51B7352EF8, agent.grenadeammo);
  }

  _id_529D1703ABC7BED6 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "dropAmmo");

  if(!isDefined(_id_529D1703ABC7BED6) || istrue(_id_529D1703ABC7BED6))
    _id_597B60C5387D1344 = _id_4FD2E36BFD98B4C2(_id_597B60C5387D1344, _id_63535454F47FF46A, _id_A1BD2D917C546946);

  if(!isDefined(level._id_0B9A2A6440DAF029))
    level._id_0B9A2A6440DAF029 = getdvarfloat("dvar_3545CA86FF96CB37", 0.34);

  _id_2B4DBEDAECF1251D = getdvarint("dvar_DF87D80BE0DF6F2E", 0);

  if(_id_2B4DBEDAECF1251D == 0)
    _id_2B4DBEDAECF1251D = scripts\engine\utility::ter_op(randomfloat(1) > level._id_0B9A2A6440DAF029, 0, int(ceil(1 / level._id_0B9A2A6440DAF029)) + scripts\engine\utility::ter_op(randomfloat(1) < 0.4, 1, 0));

  while(_id_85AD9C82D49013C0 < _id_2B4DBEDAECF1251D) {
    _id_74C58851D21ECFF0 = scripts\engine\utility::random(_id_597B60C5387D1344);

    if(!isDefined(_id_74C58851D21ECFF0)) {
      break;
    }

    if(randomfloat(1) < _id_74C58851D21ECFF0._id_B5858D9A2232E324) {
      _id_305B1BA9C9B7F7B4(_id_C6D51ABE72F8B012, _id_74C58851D21ECFF0, agent, dropstruct);
      _id_85AD9C82D49013C0++;
      _id_597B60C5387D1344 = scripts\engine\utility::array_remove(_id_597B60C5387D1344, _id_74C58851D21ECFF0);
    }
  }
}

_id_79946C09EBE3B406(_id_8051A869C25EB076, _id_78EBFE48861E28D8) {
  _id_0C4BBE0143CBB761 = undefined;
  _id_A6825F20B535B471 = getscriptcachecontents(_id_8051A869C25EB076, _id_78EBFE48861E28D8);

  if(isDefined(_id_A6825F20B535B471)) {
    _id_0C4BBE0143CBB761 = [];

    foreach(_id_2F44E3B98C77C7CC in _id_A6825F20B535B471)
    _id_0C4BBE0143CBB761[_id_0C4BBE0143CBB761.size] = _id_EDABF4238E9D70B5(_id_2F44E3B98C77C7CC, _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_2F44E3B98C77C7CC), _id_2F44E3B98C77C7CC, 1.0, level.br_pickups.counts[_id_2F44E3B98C77C7CC]);
  }

  return _id_0C4BBE0143CBB761;
}

_id_2958A3067F4AF3AF(_id_8051A869C25EB076, _id_78EBFE48861E28D8) {
  _id_0C4BBE0143CBB761 = _id_79946C09EBE3B406(_id_8051A869C25EB076, _id_78EBFE48861E28D8);

  if(!isDefined(_id_0C4BBE0143CBB761))
    _id_0C4BBE0143CBB761 = [];

  return _id_0C4BBE0143CBB761;
}

_id_E266E0DFC04C07A9(agent) {
  if(!isDefined(level._id_08973F9DA378E47D))
    level._id_08973F9DA378E47D = 0;

  _id_936E7B00C9A00D11 = scripts\engine\utility::_id_53C4C53197386572(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "overrideLootSet"), "agent_backpack");
  _id_0C4BBE0143CBB761 = _id_79946C09EBE3B406(_id_936E7B00C9A00D11, level._id_08973F9DA378E47D);

  if(isDefined(agent) && istrue(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "overrideLoot")))
    _id_0C4BBE0143CBB761 = [];

  if(!isDefined(_id_0C4BBE0143CBB761)) {
    if(level._id_08973F9DA378E47D != 0) {
      level._id_08973F9DA378E47D = 0;
      _id_0C4BBE0143CBB761 = _id_E266E0DFC04C07A9(agent);
      return _id_0C4BBE0143CBB761;
    } else
      _id_0C4BBE0143CBB761 = [];
  }

  level._id_08973F9DA378E47D = level._id_08973F9DA378E47D + 1;
  return _id_0C4BBE0143CBB761;
}

_id_0D0F2EC7F450FCB7(_id_0C4BBE0143CBB761, _id_195927E09B405481, _id_E954455D19376FF0) {
  if(_id_E954455D19376FF0 > 0) {
    _id_E954455D19376FF0 = int(min(_id_E954455D19376FF0, 2));
    _id_EACD3EFFDADD831E = scripts\mp\equipment::_id_7F245729FCB6414D(_id_195927E09B405481);

    if(!isDefined(_id_EACD3EFFDADD831E))
      return _id_0C4BBE0143CBB761;

    _id_0C4BBE0143CBB761[_id_0C4BBE0143CBB761.size] = _id_EDABF4238E9D70B5(level._id_370EED78AA5C01A5[_id_195927E09B405481], _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_EACD3EFFDADD831E), _id_EACD3EFFDADD831E, 1.0, _id_E954455D19376FF0);
  }

  return _id_0C4BBE0143CBB761;
}

_id_4FD2E36BFD98B4C2(_id_0C4BBE0143CBB761, _id_63535454F47FF46A, _id_A1BD2D917C546946) {
  if(!isDefined(_id_63535454F47FF46A))
    return _id_0C4BBE0143CBB761;

  _id_0F8C397F70608ABC = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_63535454F47FF46A);

  if(isDefined(_id_A1BD2D917C546946) && (!isDefined(_id_0F8C397F70608ABC) || scripts\engine\utility::cointoss())) {
    _id_5ABA2FFF7E326F4D = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_A1BD2D917C546946);

    if(isDefined(_id_5ABA2FFF7E326F4D))
      _id_0F8C397F70608ABC = _id_5ABA2FFF7E326F4D;
  }

  if(!isDefined(_id_0F8C397F70608ABC))
    return _id_0C4BBE0143CBB761;

  _id_0C4BBE0143CBB761[_id_0C4BBE0143CBB761.size] = _id_EDABF4238E9D70B5(_id_0F8C397F70608ABC, _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_0F8C397F70608ABC), _id_0F8C397F70608ABC, 1.0, level.br_pickups.counts[_id_0F8C397F70608ABC] * 2);
  return _id_0C4BBE0143CBB761;
}

_id_6B1DC8167C1C7378(_id_0C4BBE0143CBB761, _id_F7EA2887B1E3535B) {
  _id_0C4BBE0143CBB761[_id_0C4BBE0143CBB761.size] = _id_4FC5B97F88757E83(_id_F7EA2887B1E3535B);
  return _id_0C4BBE0143CBB761;
}

_id_4FC5B97F88757E83(_id_F7EA2887B1E3535B) {
  return _id_EDABF4238E9D70B5("brloot_armor_plate", _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_plate"), "armor_plate", 1.0, _id_F7EA2887B1E3535B);
}

_id_BC5D7FF26AD67A45(agent, _id_DCF5E15C58C4152A) {
  tier = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

  if(issubstr(_id_DCF5E15C58C4152A, "jugg"))
    return 3;
  else if(isDefined(tier) && tier > 1)
    return 2;

  return 1;
}

_id_EDABF4238E9D70B5(scriptablename, lootid, ref, _id_B5858D9A2232E324, count, _id_B926A393855A8B89, _id_557507AD5619DACA, _id_FAFCDAA6B732231A, _id_69F4F638ABF12FBF) {
  struct = spawnStruct();
  struct.scriptablename = scriptablename;
  struct.lootid = lootid;
  struct.ref = ref;
  struct._id_B5858D9A2232E324 = scripts\engine\utility::ter_op(isDefined(_id_B5858D9A2232E324), _id_B5858D9A2232E324, 1.0);
  struct.count = scripts\engine\utility::ter_op(isDefined(count), count, 1);
  struct._id_B926A393855A8B89 = _id_B926A393855A8B89;
  struct.callback = _id_557507AD5619DACA;
  struct._id_FAFCDAA6B732231A = _id_FAFCDAA6B732231A;
  struct._id_69F4F638ABF12FBF = _id_69F4F638ABF12FBF;
  struct._id_B30D9F22E554E6EE = _id_C7663426FBFDA6F3(scriptablename);
  return struct;
}

_id_C7663426FBFDA6F3(scriptablename) {
  isequipment = isDefined(scriptablename) && _id_2CEDCC356F1B9FC8::isequipment(scriptablename);
  isarmor = isDefined(scriptablename) && _id_2CEDCC356F1B9FC8::isarmor(scriptablename);
  isammo = isDefined(scriptablename) && _id_2CEDCC356F1B9FC8::isammo(scriptablename);
  return isequipment || isarmor || isammo;
}

_id_305B1BA9C9B7F7B4(_id_C6D51ABE72F8B012, _id_1BE58AA13BA9F7DA, agent, dropstruct) {
  if(!isDefined(level._id_8A7F9029342F8CB9))
    level._id_8A7F9029342F8CB9 = [];

  if(istrue(_id_1BE58AA13BA9F7DA._id_B926A393855A8B89)) {
    if(istrue(level._id_8A7F9029342F8CB9[_id_1BE58AA13BA9F7DA.lootid]))
      return 0;
    else
      level._id_8A7F9029342F8CB9[_id_1BE58AA13BA9F7DA.lootid] = 1;
  }

  if(!isDefined(level._id_7C24540CB1744AD9))
    level._id_7C24540CB1744AD9 = getdvarint("dvar_6991420CA3598113", 1);

  _id_C6D51ABE72F8B012 = _id_C6D51ABE72F8B012 | (level._id_7C24540CB1744AD9 && istrue(_id_1BE58AA13BA9F7DA._id_B30D9F22E554E6EE));
  _id_C6D51ABE72F8B012 = _id_C6D51ABE72F8B012 | getdvarint("dvar_142657A7943B806A", 0);

  if(_id_C6D51ABE72F8B012 && isDefined(_id_1BE58AA13BA9F7DA.scriptablename)) {
    count = 1;

    if(isDefined(_id_1BE58AA13BA9F7DA.count))
      count = _id_1BE58AA13BA9F7DA.count;

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);

    if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(_id_1BE58AA13BA9F7DA.lootid)) {
      [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(_id_1BE58AA13BA9F7DA.count);
      spawned = _id_7E52B56769FA7774::spawnpickup(_id_1BE58AA13BA9F7DA.scriptablename, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 0, undefined, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
    } else
      spawned = _id_7E52B56769FA7774::spawnpickup(_id_1BE58AA13BA9F7DA.scriptablename, _id_CB4FAD49263E20C4, count);

    if(isDefined(spawned))
      spawned setscriptablepartstate(spawned.type, "dropped");

    if(!isDefined(agent._id_0D544C62EA2BC64B))
      agent._id_0D544C62EA2BC64B = [];

    agent._id_0D544C62EA2BC64B[agent._id_0D544C62EA2BC64B.size] = _id_1BE58AA13BA9F7DA;
    return 1;
  } else if(!_id_C6D51ABE72F8B012) {
    _id_A6F8D8115E0F1E79 = agent.contents.size;
    agent.contents[_id_A6F8D8115E0F1E79] = [];
    agent.contents[_id_A6F8D8115E0F1E79]["lootID"] = _id_1BE58AA13BA9F7DA.lootid;
    agent.contents[_id_A6F8D8115E0F1E79]["quantity"] = _id_1BE58AA13BA9F7DA.count;
    agent.contents[_id_A6F8D8115E0F1E79]["visibilityCondition"] = _id_1BE58AA13BA9F7DA._id_FAFCDAA6B732231A;

    if(isDefined(_id_1BE58AA13BA9F7DA.callback))
      agent.contents[_id_A6F8D8115E0F1E79]["callback"] = _id_1BE58AA13BA9F7DA.callback;

    if(isDefined(_id_1BE58AA13BA9F7DA._id_69F4F638ABF12FBF))
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropCallback", _id_1BE58AA13BA9F7DA._id_69F4F638ABF12FBF);

    return 0;
  }

  return 0;
}

_id_15497E2309BC8671(_id_F1AEF3EEFC117534) {
  result = 0;
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  switch (_id_FAF0D2FAC3F47583) {
    case "exgm":
    case "dmz":
      result = _id_32DC1E6E351C8B4D(_id_F1AEF3EEFC117534);
      break;
    case "aladdin":
    case "resurgence":
    case "br":
      result = _id_58681402EC6C855E(_id_F1AEF3EEFC117534);
      break;
    default:
      return 0;
  }

  return result;
}

_id_32DC1E6E351C8B4D(_id_F1AEF3EEFC117534) {
  if(getdvarint("dvar_8FBB625100A40644", 1) == 0)
    return 0;

  if(!isDefined(level._id_0FC7F3410261C195))
    level._id_0FC7F3410261C195 = 1;

  if(!isDefined(level._id_C466CC3233C90122))
    level._id_C466CC3233C90122 = _id_2234322152162663(level._id_0FC7F3410261C195);

  if(istrue(_id_F1AEF3EEFC117534))
    level._id_C466CC3233C90122 = level._id_C466CC3233C90122 - 3;
  else
    level._id_C466CC3233C90122 = level._id_C466CC3233C90122 - 1;

  if(level._id_C466CC3233C90122 <= 0) {
    if(level._id_0FC7F3410261C195 < level._id_EF668B618C1C7EC0)
      level._id_0FC7F3410261C195 = level._id_0FC7F3410261C195 + 1;

    level._id_C466CC3233C90122 = _id_2234322152162663(level._id_0FC7F3410261C195);
    return 1;
  }

  return 0;
}

_id_58681402EC6C855E(_id_F1AEF3EEFC117534) {
  return 0;
}

_id_2234322152162663(_id_98EA5AFB293A76A2) {
  return randomintrange(3 * _id_98EA5AFB293A76A2, 5 * _id_98EA5AFB293A76A2);
}

_id_46C2D826EBB9E2CC(owner, origin, radius) {
  owner endon("death");
  streakname = "precision_airstrike";
  animname = level.scr_anim["precision_airstrike"]["airstrike_flyby"];
  _id_4C4796C182975686 = getanimlength(animname);
  _id_B333EE8FEA365230 = _id_4C4796C182975686 - 5;

  if(!isDefined(radius))
    radius = 0;

  origin = origin + (randomfloatrange(-1.0 * radius, radius), randomfloatrange(-1.0 * radius, radius), 0);
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, owner);
  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(owner, owner.team, 2048, streakname, origin);
  scripts\cp_mp\killstreaks\airstrike::callstrike(owner, origin, undefined, undefined, streakinfo, animname);
}

_id_4A618B49270CFD25(owner, origin, radius) {
  owner endon("death");
  streakname = "toma_strike";
  _id_A3F9130B1D11DFFB = randomintrange(3, 6);
  _id_EBFC9454321CB5C3 = 1;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, owner);
  _id_D77253C873D2B420 = anglesToForward(owner.angles);
  _id_558047C7AC5A2D65 = anglesToForward(owner.angles);
  _id_3C5A1B26C6973C2A = anglestoright(owner.angles);

  if(!isDefined(radius))
    radius = 0;

  origin = origin + (randomfloatrange(-1.0 * radius, radius), randomfloatrange(-1.0 * radius, radius), 0);
  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(owner, owner.team, 2048, streakname, origin);

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_A3F9130B1D11DFFB; _id_AC0E5C4AC96AAA41++) {
    _id_FA378E997A33A137 = owner scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(origin, 1024, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
    owner thread scripts\cp_mp\killstreaks\toma_strike::tomastrike_firestrike(_id_EBFC9454321CB5C3, _id_FA378E997A33A137, streakinfo);
    _id_0CF1441229A2390C = randomfloatrange(0.25, 1.0);
    wait(_id_0CF1441229A2390C);
  }
}