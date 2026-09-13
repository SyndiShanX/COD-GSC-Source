/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_behavior.gsc
***********************************************/

_id_2585B1944B7884C0() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pyro", "molotov_used", scripts\mp\equipment\molotov::molotov_used);
}

_id_304DA84D9A815C01(origin, goalradius, _id_3A21F8213541AEC5) {
  _setgoalpos(origin, goalradius);

  if(istrue(_id_3A21F8213541AEC5))
    level thread _id_05D96B05A065564E(self);
}

_setgoalpos(origin, goalradius, _id_01B6352CEB9BBC1D) {
  if(istrue(self.fixednode) || !isalive(self) || isDefined(self.vehicle)) {
    return;
  }
  if(!istrue(_id_01B6352CEB9BBC1D))
    _id_C6930AC29FE6FF53(goalradius);

  safeorigin = self getclosestreachablepointonnavmesh(origin, 0);

  if(!isDefined(safeorigin)) {
    return;
  }
  if(!isDefined(self.origin)) {
    return;
  }
  dist = distance(self.origin, safeorigin);

  if(dist < 12500 && dist > 20) {
    if(0)
      thread scripts\mp\utility\debug::drawsphere(safeorigin, 32, 10, (0, 1, 0));

    self setgoalpos(safeorigin);
  } else if(dist >= 12500 && !istrue(self._id_9DFC77CE3CD9E879))
    thread _id_9BBF1713A14FA580(self, 1024);
}

_id_C6930AC29FE6FF53(goalradius) {
  if(!isDefined(goalradius))
    goalradius = 128;

  self.goalradius = int(goalradius);
  self._id_9FF99CFC426066A2 = goalradius;
}

_id_B91038B6725A259A(agent, targetent) {
  agent setgoalentity(targetent);
}

_id_AA8F023C16FC448D(node) {
  self setgoalnode(node);
}

_id_61CBC488B27A6E61(origin) {
  _id_B2FA71142F056491 = getclosestpointonnavmesh(origin);
  groundorigin = scripts\engine\utility::drop_to_ground(_id_B2FA71142F056491, 64);
  return groundorigin;
}

_id_1670C315976C767B() {
  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");
}

_id_B11C1964F528574B(agent, _id_BA8B04EB4B683E67, origin) {
  _id_2AE805B43221A762 = origin;

  if(isagent(agent) && !isDefined(origin))
    _id_2AE805B43221A762 = agent.origin;

  if(istrue(_id_BA8B04EB4B683E67))
    _id_D1E130608E4F8487(agent, _id_2AE805B43221A762, _id_BA8B04EB4B683E67);
  else
    _id_E786AA52B93833EB(agent, _id_2AE805B43221A762, 25, 10);

  if(isint(agent)) {
    return;
  }
  agent endon("death");
  agent endon("stealth_investigate");
  agent endon("stealth_hunt");
  agent endon("stealth_combat");
  agent endon("startCombatRush");
  _id_1670C315976C767B();
  wait 1;

  if(isDefined(origin) && distance2dsquared(origin, agent.origin) > 4096) {
    agent _id_304DA84D9A815C01(origin, 32, 1);
    agent waittill("goal");
  } else if(!isDefined(origin))
    origin = agent.origin;

  if(!istrue(_id_BA8B04EB4B683E67))
    agent _id_580A150BA253DE13(agent);
}

_id_9BBF1713A14FA580(agent, radius, _id_C154E6E386654A30, origin) {
  _id_2AE805B43221A762 = origin;

  if(isagent(agent) && !isDefined(origin))
    _id_2AE805B43221A762 = agent.origin;

  if(!isDefined(radius))
    radius = 100;

  if(!isDefined(_id_C154E6E386654A30) || _id_C154E6E386654A30 <= 0)
    _id_C154E6E386654A30 = 50;

  _id_E786AA52B93833EB(agent, _id_2AE805B43221A762, radius, _id_C154E6E386654A30);

  if(isint(agent)) {
    return;
  }
  agent endon("death");
  agent endon("stealth_investigate");
  agent endon("stealth_hunt");
  agent endon("stealth_combat");
  agent endon("startCombatRush");
  agent notify("guardWander");
  agent endon("guardWander");
  _id_1670C315976C767B();
  wait 1;

  if(isDefined(origin) && distance2dsquared(origin, agent.origin) > 4096) {
    agent _id_304DA84D9A815C01(origin, 32, 1);
    agent waittill("goal");
  }

  originalorigin = agent.origin;
  min = radius - _id_C154E6E386654A30;
  max = radius + _id_C154E6E386654A30;
  agent._id_9DFC77CE3CD9E879 = 1;

  while(!isDefined(agent.enemy)) {
    _id_BCFEC646853A95C1 = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_B30A6C38CD4FE517 = (originalorigin[0] + _id_BCFEC646853A95C1, originalorigin[1] + _id_BCFEC546853A938E, originalorigin[2]);

    if(distance2d(agent.origin, _id_B30A6C38CD4FE517) > 20) {
      agent _setgoalpos(_id_B30A6C38CD4FE517, 8);
      agent thread _id_BF182F1600FEC92A(agent);
      agent scripts\engine\utility::waittill_any_2("goal", "refreshGoalPos");
    }

    wait(randomfloatrange(7.5, 10.5));
  }

  agent _setgoalpos(_id_2AE805B43221A762, 768);
  agent._id_9DFC77CE3CD9E879 = undefined;
}

_id_A057EE9ADC9547D5(agent, radius, _id_C154E6E386654A30, origin) {
  _id_2AE805B43221A762 = origin;

  if(isagent(agent) && !isDefined(origin))
    _id_2AE805B43221A762 = agent.origin;

  if(!isDefined(radius))
    radius = 1000;

  if(!isDefined(_id_C154E6E386654A30) || _id_C154E6E386654A30 <= 0)
    _id_C154E6E386654A30 = 200;

  _id_FE5620595915170F(agent, _id_2AE805B43221A762, radius, _id_C154E6E386654A30);

  if(isint(agent)) {
    return;
  }
  agent endon("death");
  agent endon("stealth_investigate");
  agent endon("stealth_hunt");
  agent endon("stealth_combat");
  agent endon("startCombatRush");
  _id_1670C315976C767B();
  wait 1;

  if(isDefined(origin) && distance2dsquared(origin, agent.origin) > 4096) {
    agent _id_304DA84D9A815C01(origin, 32, 1);
    agent waittill("goal");
  }

  originalorigin = agent.origin;
  min = radius - _id_C154E6E386654A30;
  max = radius + _id_C154E6E386654A30;

  for(;;) {
    _id_BCFEC646853A95C1 = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_B30A6C38CD4FE517 = (originalorigin[0] + _id_BCFEC646853A95C1, originalorigin[1] + _id_BCFEC546853A938E, originalorigin[2]);

    if(distance2d(agent.origin, _id_B30A6C38CD4FE517) > 20) {
      agent _setgoalpos(_id_B30A6C38CD4FE517, 8);
      agent thread _id_BF182F1600FEC92A(agent);
      agent scripts\engine\utility::waittill_any_2("goal", "refreshGoalPos");
    }

    wait(randomfloatrange(7.5, 10.5));
  }
}

_id_BF182F1600FEC92A(agent, time) {
  agent endon("goal");
  agent endon("death");
  waittime = 5;

  if(isDefined(time))
    waittime = time;

  wait(waittime);
  agent notify("refreshGoalPos");
}

_id_25CC93D439C3033A(_id_886DFA499937A071, pathstruct, _id_2F55781AF96F22F9, _id_87D4C4075F48EC58, _id_C75025A5B8EB8D36) {
  if(!isDefined(_id_886DFA499937A071[0])) {
    return;
  }
  if(!isDefined(pathstruct) || !isDefined(pathstruct.path)) {
    return;
  }
  level endon("game_ended");
  _id_A1D5907E01730345 = 0;

  foreach(agent in _id_886DFA499937A071) {
    _id_F8BC7ECDD324DD79 = _id_F0C78111CE0CDC0A(agent);

    if(!isDefined(_id_F8BC7ECDD324DD79) || _id_F8BC7ECDD324DD79.behavior != "patrol") {
      if(level._id_FE093E9B2B6C3751)
        _id_4561FE6BFC76F8EC(agent, [agent], pathstruct);
      else
        _id_4561FE6BFC76F8EC(agent, _id_886DFA499937A071, pathstruct);
    }

    if(isagent(agent)) {
      agent notify("patrolStart");
      agent endon("patrolStart");
      agent endon("death");
      agent endon("stealth_investigate");
      agent endon("stealth_hunt");
      agent endon("stealth_combat");
      agent endon("startCombatRush");
      _id_A1D5907E01730345 = 1;
    }
  }

  if(!_id_A1D5907E01730345) {
    return;
  }
  level thread _id_B4FD9F6BD59A64F0(_id_886DFA499937A071);
  path = pathstruct.path;
  pathstruct.claimed = 1;
  index = 1;
  _id_47EA45F5BCF10FC3 = 1;

  if(isDefined(_id_2F55781AF96F22F9)) {
    index = _id_2F55781AF96F22F9;
    index = int(min(index, path.size - 1));
    index = int(max(index, 0));
  }

  _id_1670C315976C767B();
  wait 1;

  for(;;) {
    if(isvector(path[index]))
      point = path[index];
    else
      point = path[index].origin;

    foreach(_id_6843D82ED42EA7DE, agent in _id_886DFA499937A071) {
      if(_id_6843D82ED42EA7DE != 0) {
        _id_BCFEC646853A95C1 = randomfloatrange(30, 31) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
        _id_BCFEC546853A938E = randomfloatrange(30, 31) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
        point = (point[0] + _id_BCFEC646853A95C1, point[1] + _id_BCFEC546853A938E, point[2]);
      }

      agent _setgoalpos(point, scripts\engine\utility::_id_53C4C53197386572(_id_87D4C4075F48EC58, 128));
      wait(randomfloatrange(1.5, 2.5));
    }

    waitframe();
    _id_886DFA499937A071[0] waittill("goal");

    if(istrue(_id_886DFA499937A071[0]._id_CF430336D17E3AFE))
      wait 0.5;
    else
      wait(scripts\engine\utility::_id_53C4C53197386572(_id_C75025A5B8EB8D36, 8));

    if(_id_47EA45F5BCF10FC3)
      index++;
    else
      index--;

    if(!isDefined(path[index])) {
      if(!pathstruct._id_4437E81F60B6B5A0) {
        index = 0;
        continue;
      }

      if(_id_47EA45F5BCF10FC3) {
        index = path.size - 2;
        _id_47EA45F5BCF10FC3 = 0;
        continue;
      }

      index = 1;
      _id_47EA45F5BCF10FC3 = 1;
    }
  }
}

_id_B4FD9F6BD59A64F0(_id_886DFA499937A071) {
  level endon("game_ended");

  foreach(agent in _id_886DFA499937A071) {
    agent endon("stealth_investigate");
    agent endon("stealth_hunt");
    agent endon("stealth_combat");
  }

  _id_37CBBC36D167B305 = 0;

  while(!_id_37CBBC36D167B305) {
    foreach(agent in _id_886DFA499937A071) {
      if(isDefined(agent) && !isalive(agent))
        _id_37CBBC36D167B305 = 1;
    }

    wait 1;
  }

  wait 2.5;

  foreach(agent in _id_886DFA499937A071) {
    if(isDefined(agent) && isalive(agent) && isDefined(agent.stealth) && (isstring(agent._id_FE5EBEFA740C7106) && agent._id_FE5EBEFA740C7106 == "idle")) {
      event = spawnStruct();
      event.type = "investigate";
      event.typeorig = "found_corpse";
      event.origin = agent.origin;
      event.investigate_pos = agent.origin;
      agent scripts\stealth\enemy::bt_set_stealth_state("investigate", event);
    }
  }
}

_id_21014E3C42BCC249(event) {
  agent = self;

  if(isDefined(agent._id_F8BC7ECDD324DD79) && isDefined(agent._id_F8BC7ECDD324DD79._id_39E3177C55F34E64) && isDefined(agent._id_F8BC7ECDD324DD79._id_A34F6FB5917D2093)) {
    self setgoalpos(self._id_F8BC7ECDD324DD79._id_39E3177C55F34E64, self._id_F8BC7ECDD324DD79._id_A34F6FB5917D2093);

    if(isDefined(agent._id_14C360EBEC241178))
      agent.maxsightdistsqrd = agent._id_14C360EBEC241178;
  } else if(event.type == "combat" && !istrue(agent._id_B43F6CAD28078A05))
    self.goalradius = level._id_8912CCAD342445F7;

  return 0;
}

_id_1A2E58FFAAFB1D40(_id_DB585B8134EED64C) {
  foreach(pathstruct in _id_DB585B8134EED64C) {
    if(istrue(pathstruct.claimed))
      continue;
    else {
      pathstruct.claimed = 1;
      return pathstruct;
    }
  }

  return undefined;
}

_id_7E69553F058C867B(agent) {
  agent endon("death");
  _id_8BB792D43ECD8D1E = getdvarint("dvar_401EBD6CA7F17D87", 0);

  for(;;) {
    if([[agent.fnisinstealthidle]]()) {
      if(istrue(agent._id_39F1CF3B225FEFA6)) {
        agent._id_39F1CF3B225FEFA6 = 0;
        _id_447A25AF0131832E(agent);
      }
    } else if([[agent.fnisinstealthinvestigate]]())
      agent._id_39F1CF3B225FEFA6 = 1;
    else if([[agent.fnisinstealthcombat]]()) {
      agent._id_39F1CF3B225FEFA6 = 1;

      if(_id_8BB792D43ECD8D1E <= 0) {
        wait 5;
        continue;
      }

      if(isDefined(agent._id_F8BC7ECDD324DD79) && agent._id_F8BC7ECDD324DD79.behavior == "guard") {
        wait 5;
        continue;
      }

      if(isDefined(agent.enemy)) {
        agent getenemyinfo(agent.enemy);

        if(issubstr(agent.script_stealthgroup, "fortress")) {
          wait 10;
          continue;
        }

        roll = randomint(100);

        if(roll > _id_8BB792D43ECD8D1E)
          _setgoalpos(agent.enemy.origin, 1000);

        wait 10;
      }
    } else if([[agent.fnisinstealthhunt]]()) {
      agent._id_39F1CF3B225FEFA6 = 1;

      if(istrue(level._id_69173C5E957CCCFF))
        agent thread _id_67DDAE411C6C353E(agent);
    }

    wait 5;
  }
}

_id_67DDAE411C6C353E(agent) {
  agent endon("death");
  agent endon("stealth_combat");
  agent endon("startCombatRush");
  interval = 1;
  _id_6B7BEE46F2C6DA28 = 0;

  while(_id_6B7BEE46F2C6DA28 < level._id_EC80E35C609C1533) {
    wait(interval);
    _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + interval;

    if(istrue(agent._id_B43F6CAD28078A05))
      return;
  }

  agent scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
}

_id_447A25AF0131832E(agent) {
  if(!isDefined(agent._id_F8BC7ECDD324DD79))
    _id_D1E130608E4F8487(agent);

  if(agent._id_F8BC7ECDD324DD79.behavior == "patrol") {
    agentarray = [];

    foreach(_id_A49F3E62BA7C6D8A in agent._id_F8BC7ECDD324DD79._id_886DFA499937A071) {
      if(isDefined(_id_A49F3E62BA7C6D8A) && isalive(_id_A49F3E62BA7C6D8A) && isDefined(agent._id_F8BC7ECDD324DD79) && isDefined(_id_A49F3E62BA7C6D8A._id_F8BC7ECDD324DD79) && isDefined(_id_A49F3E62BA7C6D8A._id_F8BC7ECDD324DD79.pathstruct) && agent._id_F8BC7ECDD324DD79.pathstruct == _id_A49F3E62BA7C6D8A._id_F8BC7ECDD324DD79.pathstruct)
        agentarray[agentarray.size] = _id_A49F3E62BA7C6D8A;
    }

    agent._id_F8BC7ECDD324DD79._id_886DFA499937A071 = agentarray;
  }

  _id_580A150BA253DE13(agent);
}

_id_65F6A39E1083FB6B(agent, _id_2BD923437ECC04BD, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  agent endon("death");
  _id_913774985C12C245 = _id_2BD923437ECC04BD;
  _id_6E3DD46C3475CD2D(agent, _id_913774985C12C245, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);

  foreach(index, _id_C5E7FCE963586EC0 in _id_2BD923437ECC04BD) {
    agent thread _id_A5117518725DA028(agent, _id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, 1, _id_1B3D1C2F22B62206);
    agent waittill("combatRushComplete");
    _id_913774985C12C245 = scripts\engine\utility::array_remove(_id_913774985C12C245, _id_C5E7FCE963586EC0);
    _id_6E3DD46C3475CD2D(agent, _id_913774985C12C245, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);
    waitframe();

    if(!isDefined(_id_2BD923437ECC04BD[index + 1])) {
      if(isDefined(_id_1B3D1C2F22B62206)) {
        [[_id_1B3D1C2F22B62206]](agent);
        continue;
      }

      agent thread _id_9BBF1713A14FA580(agent, _id_21F24AECB313E479, _id_E298CEC41261345C, _id_C5E7FCE963586EC0);
    }
  }
}

_id_A5117518725DA028(agent, _id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_066DB74486A8F804, _id_1B3D1C2F22B62206, targetent) {
  if(!isDefined(agent) || !isalive(agent) || !isDefined(_id_C5E7FCE963586EC0)) {
    return;
  }
  if(isDefined(_id_C5E7FCE963586EC0) && !isvector(_id_C5E7FCE963586EC0)) {
    return;
  }
  if(issubstr(agent.agent_type, "jugg")) {
    return;
  }
  if(!isDefined(_id_E298CEC41261345C))
    _id_E298CEC41261345C = 128;

  if(!isDefined(_id_87D4C4075F48EC58))
    _id_87D4C4075F48EC58 = 256;

  if(!isDefined(_id_21F24AECB313E479))
    _id_21F24AECB313E479 = 768;

  if(!isDefined(_id_3E332762C9138001))
    _id_3E332762C9138001 = 1;

  if(isagent(agent) && distance(agent.origin, _id_C5E7FCE963586EC0) > 12500) {
    agent thread _id_9BBF1713A14FA580(agent, 1024);
    return;
  }

  if(!istrue(_id_066DB74486A8F804))
    _id_0BD9ACC7C99AD884(agent, _id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);

  if(isint(agent)) {
    return;
  }
  agent endon("death");
  agent endon("cancelCombatRush");
  agent notify("startCombatRush");
  agent notify("endCQB");
  agent._id_B43F6CAD28078A05 = 1;
  _id_95F125B69BD6E39E = _id_C5E7FCE963586EC0;

  if(_id_E298CEC41261345C > 0)
    _id_95F125B69BD6E39E = _id_95F125B69BD6E39E + (randomfloatrange(-1.0 * _id_E298CEC41261345C, _id_E298CEC41261345C), randomfloatrange(-1.0 * _id_E298CEC41261345C, _id_E298CEC41261345C), 0);

  _id_95F125B69BD6E39E = _id_61CBC488B27A6E61(_id_95F125B69BD6E39E);
  self._id_5323A94889EFF1DE = 1;

  if(isDefined(agent.script_stealthgroup))
    agent._id_9A04C6CFE15E92A7 = _id_95F125B69BD6E39E;

  if(isDefined(agent.fnsetstealthstate))
    agent scripts\stealth\enemy::bt_event_combat();

  agent setbtgoalpos(0, _id_95F125B69BD6E39E);
  agent setbtgoalpos(1, _id_95F125B69BD6E39E);
  agent setbtgoalRadius(0, _id_87D4C4075F48EC58);
  agent setbtgoalRadius(1, _id_87D4C4075F48EC58);
  agent _id_304DA84D9A815C01(_id_95F125B69BD6E39E, _id_87D4C4075F48EC58, !_id_3E332762C9138001);
  agent childthread _id_547DC153B092906D(agent, 1024, undefined, _id_95F125B69BD6E39E, _id_3E332762C9138001, _id_066DB74486A8F804);

  for(;;) {
    dist = distance2d(agent.origin, _id_95F125B69BD6E39E);
    time = max(dist / 50, 10);
    msg = "badMessage";

    while(agent pathdisttogoal() == 0)
      waitframe();

    if(istrue(_id_3E332762C9138001))
      msg = agent scripts\engine\utility::waittill_any_timeout_3(time, "goal", "goal_reached", "bt_goal");
    else {
      msg = agent scripts\engine\utility::waittill_any_timeout_5(time, "goal", "goal_reached", "bad_path", "endBadPathHandler", "bt_goal");
      agent notify("endBadPathHandler");
    }

    if(msg != "bt_goal" || distance2d(agent.origin, _id_95F125B69BD6E39E) < _id_87D4C4075F48EC58) {
      break;
    }
  }

  self._id_5323A94889EFF1DE = 0;

  if(isDefined(agent.script_stealthgroup)) {
    _id_467F737ADF6AEEE4(agent.script_stealthgroup);
    _id_41C0982BEF2FE12B = _id_BA90928315AA754D(agent.script_stealthgroup);

    if(_id_41C0982BEF2FE12B.size == 0)
      _id_41C0982BEF2FE12B = [agent];
  } else
    _id_41C0982BEF2FE12B = [agent];

  if(isDefined(_id_69565040C77112CE))
    _id_41C0982BEF2FE12B = scripts\engine\utility::array_combine_unique(_id_41C0982BEF2FE12B, _id_69565040C77112CE);

  foreach(_id_80EF668C09FFB70F in _id_41C0982BEF2FE12B) {
    _id_2BC30FCFF884B1BA = 0;

    if(_id_80EF668C09FFB70F == agent)
      _id_2BC30FCFF884B1BA = 1;

    _id_80EF668C09FFB70F thread _id_490FF4D545E089BC(_id_80EF668C09FFB70F, _id_2BC30FCFF884B1BA, _id_21F24AECB313E479);
  }

  if(!istrue(_id_066DB74486A8F804)) {
    if(isDefined(_id_1B3D1C2F22B62206))
      [[_id_1B3D1C2F22B62206]](agent, targetent);
    else
      agent thread _id_9BBF1713A14FA580(agent, _id_21F24AECB313E479, _id_E298CEC41261345C, _id_C5E7FCE963586EC0);
  }

  agent notify("combatRushComplete");
  agent._id_9F78B0C726E807FF = 0;
}

_id_490FF4D545E089BC(agent, _id_2BC30FCFF884B1BA, _id_145BC4A8E47C0991, _id_34ED52869F44AFBB, _id_1E6879F36E59BEA5) {
  agent endon("death");
  agent notify("end_combat_rush_early_target_think");
  agent clearbtgoal(0);
  agent clearbtgoal(1);
  agent _id_C6930AC29FE6FF53(_id_145BC4A8E47C0991);
  agent._id_B43F6CAD28078A05 = 0;

  if(!istrue(_id_2BC30FCFF884B1BA)) {
    agent notify("cancelCombatRush");
    agent notify("combatRushComplete");
    _id_D1E130608E4F8487(agent);

    if(!isDefined(_id_34ED52869F44AFBB))
      _id_34ED52869F44AFBB = 2;

    if(!isDefined(_id_1E6879F36E59BEA5))
      _id_1E6879F36E59BEA5 = 8;

    wait(randomintrange(_id_34ED52869F44AFBB, _id_1E6879F36E59BEA5));
  }

  agent notify("endBadPathHandler");

  if(isDefined(agent.script_stealthgroup))
    _id_467F737ADF6AEEE4(agent.script_stealthgroup);

  if(isalive(agent) && isDefined(self.fnsetstealthstate))
    agent scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
}

_id_547DC153B092906D(agent, _id_996E8FD3B531DC2A, _id_709ABAA772D0D110, _id_95F125B69BD6E39E, _id_3E332762C9138001, _id_066DB74486A8F804) {
  agent endon("end_combat_rush_early_target_think");

  if(!isDefined(_id_709ABAA772D0D110))
    _id_709ABAA772D0D110 = 1024;

  while(agent pathdisttogoal() == 0)
    waitframe();

  waitframe();

  while(agent pathdisttogoal() > min(128, _id_996E8FD3B531DC2A) || istrue(agent._id_B43F6CAD28078A05)) {
    if(agent isknownenemyinradius(agent.origin, _id_709ABAA772D0D110) && istrue(agent._id_B43F6CAD28078A05)) {
      agent thread _id_55149707E1D77B1E(_id_709ABAA772D0D110, agent.scriptgoalpos, _id_3E332762C9138001, _id_066DB74486A8F804);
      agent._id_B43F6CAD28078A05 = 0;
      agent notify("cancelCombatRush");
    }

    waitframe();
  }
}

_id_55149707E1D77B1E(_id_709ABAA772D0D110, _id_95F125B69BD6E39E, _id_3E332762C9138001, _id_066DB74486A8F804) {
  self notify("engaging_nearby");
  self endon("engaging_nearby");
  self endon("death");
  self setbtgoalpos(1, self.origin);
  self setbtgoalRadius(1, _id_709ABAA772D0D110);
  anchor = self.origin;
  self requestcoverfind(0, 0);
  _id_340723983982AA94 = 3;
  _id_052627F779C5F364 = 1;

  while(_id_052627F779C5F364) {
    while(self isknownenemyinradius(anchor, _id_709ABAA772D0D110))
      wait 2;

    _id_6B7BEE46F2C6DA28 = 0;
    _id_052627F779C5F364 = 0;

    while(_id_6B7BEE46F2C6DA28 <= _id_340723983982AA94 && !_id_052627F779C5F364) {
      wait 1;
      _id_6B7BEE46F2C6DA28++;

      if(self isknownenemyinradius(anchor, _id_709ABAA772D0D110))
        _id_052627F779C5F364 = 1;
    }
  }

  self clearbtgoal(1);
  waitframe();
  thread _id_A5117518725DA028(self, _id_95F125B69BD6E39E, 0, undefined, undefined, _id_3E332762C9138001, undefined, _id_066DB74486A8F804);
}

_id_9AF4D877E8BB0AC1(groupname) {
  group = scripts\stealth\group::getgroup(groupname);

  if(!isDefined(group))
    return;
  else
    group._id_A0D0AC92FCF29AF0 = 1;

  waitframe();

  foreach(_id_B205CC0302DA1270 in group.pods)
  _id_B205CC0302DA1270._id_DFF7984130ECE673 = 1;
}

_id_467F737ADF6AEEE4(groupname) {
  group = scripts\stealth\group::getgroup(groupname);

  foreach(_id_B205CC0302DA1270 in group.pods) {
    _id_B205CC0302DA1270._id_DFF7984130ECE673 = 0;

    foreach(_id_80EF668C09FFB70F in _id_B205CC0302DA1270.members)
    _id_80EF668C09FFB70F notify("endBadPathHandler");
  }

  group._id_A0D0AC92FCF29AF0 = 0;
}

_id_BA90928315AA754D(groupname) {
  group = scripts\stealth\group::getgroup(groupname);
  members = [];

  foreach(_id_B205CC0302DA1270 in group.pods) {
    foreach(_id_80EF668C09FFB70F in _id_B205CC0302DA1270.members)
    members[members.size] = _id_80EF668C09FFB70F;
  }

  return members;
}

_id_05D96B05A065564E(agent) {
  level endon("game_ended");
  agent endon("death");
  agent endon("endBadPathHandler");

  for(;;) {
    agent waittill("bad_path", _id_772EDBDCFE906C73);
    [[level._id_9D28D5B70AA9F5E4]](agent, _id_772EDBDCFE906C73);
    agent notify("endBadPathHandler");
  }
}

_id_9D28D5B70AA9F5E4(agent, _id_772EDBDCFE906C73) {
  agent notify("cancelCombatRush");

  if(isDefined(agent.vehicle)) {
    return;
  }
  _id_21A106FA806846D1 = level._id_F79746DAB56DCA8C;
  origin = undefined;

  if(isDefined(_id_21A106FA806846D1) && _id_21A106FA806846D1.size > 0) {
    _id_21A106FA806846D1 = sortbydistance(_id_21A106FA806846D1, _id_772EDBDCFE906C73);
    origin = _id_21A106FA806846D1[0].origin;
  } else
    origin = agent.origin;

  dist = distance(agent.origin, origin);

  if(dist >= 12500)
    agent thread _id_9BBF1713A14FA580(agent, 1024);
  else {
    agent _id_304DA84D9A815C01(origin, 2048);
    agent setbtgoalpos(0, origin);
    agent setbtgoalpos(1, origin);
  }

  if(0) {
    thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, 15, (1, 0, 1));
    thread scripts\mp\utility\debug::drawsphere(origin, 32, 15, (1, 0, 1));
    thread scripts\cp_mp\utility\debug_utility::drawline(agent.origin, origin, 15, (1, 1, 0));
  }
}

_id_5867290FDA7A1AC1(spawnpos, _id_5078A08CC4EC9D12, _id_1BFA1D374486DA61, spawnheight) {
  if(!isDefined(_id_1BFA1D374486DA61))
    _id_1BFA1D374486DA61 = 1000;

  _id_4F4704D728A0EB78 = getdvarfloat("dvar_07CEA12FAAEB9D47");
  _id_F77FB43ED7EC5BD2 = 0;

  if(isDefined(_id_4F4704D728A0EB78) && _id_4F4704D728A0EB78 > 0)
    _id_F77FB43ED7EC5BD2 = (_id_4F4704D728A0EB78 - _id_1BFA1D374486DA61) / _id_4F4704D728A0EB78;

  _id_4E333F60B3B1F754 = _func_7C093AAEC980131B(spawnpos, 0);

  if(isDefined(_id_4E333F60B3B1F754) && _id_4E333F60B3B1F754 > _id_F77FB43ED7EC5BD2) {
    if(isDefined(spawnheight) && spawnheight > 0)
      _id_3D2E1A01EDB70022 = (0, 0, spawnheight);
    else
      _id_3D2E1A01EDB70022 = (0, 0, 60);

    players = scripts\common\utility::playersincylinder(spawnpos, _id_1BFA1D374486DA61);

    if(players.size >= 9)
      return 0;

    foreach(player in players) {
      _id_7D3CF95BDBCA0939 = 0;
      _id_B3D7CE1408952F4D = player getEye();

      if(isDefined(_id_5078A08CC4EC9D12) && _id_5078A08CC4EC9D12 > 100) {
        _id_612D65B2BEA1CAA0 = player.origin - spawnpos;

        if(length(_id_612D65B2BEA1CAA0) < _id_5078A08CC4EC9D12 + 20)
          return 0;

        _id_9E7C1F93B9DF1F01 = _id_5078A08CC4EC9D12 * vectorNormalize(rotatevector(_id_612D65B2BEA1CAA0, (0, 90, 0)));
        _id_13A4573340B58DC0 = _id_5078A08CC4EC9D12 * vectorNormalize(rotatevector(_id_612D65B2BEA1CAA0, (0, -90, 0)));
        _id_9E7C1F93B9DF1F01 = getclosestpointonnavmesh(spawnpos + _id_9E7C1F93B9DF1F01);
        _id_13A4573340B58DC0 = getclosestpointonnavmesh(spawnpos + _id_13A4573340B58DC0);
        _id_F4DC0469C31C4CB0 = 0;
        _id_6E4343A0DD67E8D1 = 0;
        _id_42A1B87E920E3A70 = 0;

        if(scripts\engine\utility::within_fov(player.origin, player.angles, _id_9E7C1F93B9DF1F01, 0))
          _id_F4DC0469C31C4CB0 = spawnsighttrace(undefined, _id_9E7C1F93B9DF1F01 + _id_3D2E1A01EDB70022, _id_B3D7CE1408952F4D);

        if(scripts\engine\utility::within_fov(player.origin, player.angles, _id_13A4573340B58DC0, 0))
          _id_6E4343A0DD67E8D1 = spawnsighttrace(undefined, _id_13A4573340B58DC0 + _id_3D2E1A01EDB70022, _id_B3D7CE1408952F4D);

        if(scripts\engine\utility::within_fov(player.origin, player.angles, spawnpos, 0))
          _id_42A1B87E920E3A70 = spawnsighttrace(undefined, spawnpos + _id_3D2E1A01EDB70022, _id_B3D7CE1408952F4D);

        _id_7D3CF95BDBCA0939 = max(max(_id_F4DC0469C31C4CB0, _id_6E4343A0DD67E8D1), _id_42A1B87E920E3A70);
      } else if(scripts\engine\utility::within_fov(player.origin, player.angles, spawnpos, 0))
        _id_7D3CF95BDBCA0939 = spawnsighttrace(undefined, spawnpos + _id_3D2E1A01EDB70022, _id_B3D7CE1408952F4D);

      if(_id_7D3CF95BDBCA0939 > 0.1)
        return 0;
    }
  }

  return 1;
}

_id_D378CC95ABAB583B(origin, _id_171F90B9C4C76D44) {
  if(isDefined(origin))
    return origin;

  level._id_1B4461E4447DA676++;

  if(level._id_1B4461E4447DA676 % level._id_3E6588E7A225A933 == 0) {
    _id_2F28B3B3B8359E4B = [];
    _id_0E5BF5FAC2822316 = level.agentarray;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
      _id_0E5BF5FAC2822316 = _func_7E3F22E620F3F71E(_id_171F90B9C4C76D44, "everybody");

    foreach(agent in _id_0E5BF5FAC2822316) {
      if(isDefined(agent.enemy) && isalive(agent.enemy) && isPlayer(agent.enemy))
        _id_2F28B3B3B8359E4B[_id_2F28B3B3B8359E4B.size] = agent.enemy;
    }

    if(_id_2F28B3B3B8359E4B.size > 0) {
      player = scripts\engine\utility::random(_id_2F28B3B3B8359E4B);
      return player.origin;
    }
  }

  _id_9B3BB378DB91CF83 = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

    _id_9B3BB378DB91CF83 = scripts\engine\utility::array_combine(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_4F922AF45D0CAC6C, level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C9464C89A69010E2);

    if(isDefined(level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1)) {
      foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1) {
        if(_id_276AC5E84835EA87._id_B205D90302DA2F07 == _id_171F90B9C4C76D44)
          _id_9B3BB378DB91CF83[_id_9B3BB378DB91CF83.size] = _id_276AC5E84835EA87;
      }
    }
  } else
    _id_9B3BB378DB91CF83 = scripts\engine\utility::array_combine(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2);

  return scripts\engine\utility::random(_id_9B3BB378DB91CF83).origin;
}

_id_E4275EC4EC5DCDD0(agent, origin, radius) {
  agent endon("death");

  for(;;) {
    wait 4;
    _id_304DA84D9A815C01(origin, radius);
  }
}

_id_38EEB3C2A1B3BD14(agent) {
  level endon("game_ended");
  agent endon("death");
  agent endon("alerted_to_player");

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player) && isalive(player)) {
        if(_id_59565896F06F1220(agent, player)) {
          agent.goalradius = 1024;
          agent.dont_enter_combat = 0;
          agent.combatmode = "cover";
          agent notify("alerted_to_player");
          return;
        }
      }
    }

    wait 0.1;
  }
}

_id_A0E63FE5C7A71428(agent) {
  level endon("game_ended");
  agent endon("death");
  agent endon("alerted_to_player");
  agent waittill("damage", idamage, eattacker);
  agent.goalradius = 250;
  agent.dont_enter_combat = 0;
  agent.combatmode = "no_cover";
  agent notify("alerted_to_player");
}

_id_59565896F06F1220(agent, player) {
  _id_ECE9C1126186017B = distance(agent.origin, player.origin) <= 256;
  _id_30068470264CDE43 = agent cansee(player);
  return _id_ECE9C1126186017B && _id_30068470264CDE43;
}

_id_0A80E7E8F2C9D73C(event) {
  agent = self;
  level endon("game_ended");
  agent endon("death");

  if(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(randomint(100) < 50)
    agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);

  wait(randomintrange(8, 11));
  agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);

  if(level._id_58AC9EBCF7B87B73 + level._id_D362D0481275DE02 > gettime() && randomint(100) < level._id_2EF1C744D35B6312) {
    level thread _id_48814951E916AF89::_id_77ACC10C4823DD8A(3, event.origin, "medium", "reinforcements", "foundCorpse", undefined, agent.team, 1, agent._id_B205D90302DA2F07);
    level._id_58AC9EBCF7B87B73 = gettime();
  }
}

_id_810A6443BDE30366(origin, radius, _id_068CA75F051E913A) {
  agents = scripts\common\utility::_id_2D7FD59D039FA69B(origin, radius, 0);

  if(!isDefined(_id_068CA75F051E913A))
    _id_068CA75F051E913A = origin;

  foreach(agent in agents) {
    if(isDefined(agent.unittype) && agent.unittype == "civilian") {
      continue;
    }
    agent aieventlistenerevent("gunshot", self, _id_068CA75F051E913A);
  }
}

_id_004C61A6FD42FA58(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  if(isarray(nodes) && nodes.size < 1) {
    nodes = self.spawnpoint _id_9ABBCE4B66EE25D4();

    if(nodes.size == 0) {
      self notify("reached_path_end");

      if(isDefined(_id_D25339A42DEEAC35))
        [[_id_D25339A42DEEAC35]]();

      return;
    }
  } else if(!isarray(nodes))
    nodes = [nodes];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
    if(isvector(nodes[_id_AC0E594AC96AA3A8])) {
      struct = spawnStruct();
      struct.origin = nodes[_id_AC0E594AC96AA3A8];
      struct.angles = (0, 0, 0);
      nodes[_id_AC0E594AC96AA3A8] = struct;
    }
  }

  _id_DB64D1E0F2B06482(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
}

_id_9ABBCE4B66EE25D4() {
  _id_764BDB6FE546DACC = _id_EE9A5BCD6B164CE2();

  if(_id_764BDB6FE546DACC.size < 1) {
    if(isDefined(self.target))
      _id_764BDB6FE546DACC = _id_697E9BF539BED8B6(self.target);
  }

  return _id_764BDB6FE546DACC;
}

_id_697E9BF539BED8B6(target) {
  goals = getnodearray(target, "targetname");
  _id_889BE5A52999435E = scripts\engine\utility::getStructArray(target, "targetname");

  foreach(new in _id_889BE5A52999435E)
  goals[goals.size] = new;

  _id_889BE5A52999435E = getEntArray(target, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_889BE5A52999435E.size; _id_AC0E594AC96AA3A8++) {
    new = _id_889BE5A52999435E[_id_AC0E594AC96AA3A8];

    if(!_id_F2D40D9B75CBC023(new)) {
      continue;
    }
    goals[goals.size] = new;
  }

  return goals;
}

_id_F2D40D9B75CBC023(object) {
  if(isspawner(object))
    return 0;

  switch (object.code_classname) {
    case "trigger_once":
    case "misc_turret":
    case "trigger_multiple":
    case "trigger_radius":
      return 0;
  }

  return 1;
}

_id_EE9A5BCD6B164CE2() {
  goals = [];

  if(isDefined(self.script_linkto)) {
    linked_ents = scripts\engine\utility::get_linked_ents();
    _id_3D938A1343D65FED = scripts\engine\utility::get_linked_structs();
    _id_789069F44709F226 = scripts\engine\utility::get_linked_nodes();
    goals = scripts\engine\utility::array_combine(linked_ents, _id_3D938A1343D65FED, _id_789069F44709F226);
  }

  return goals;
}

_id_BACB634331B86A93() {
  self notify("_behavior_gotoNodeEnd");
  self endon("_behavior_gotoNodeEnd");
  self endon("death");
  level endon("game_ended");
  self.using_goto_node = 1;
  result = scripts\engine\utility::waittill_any_return_2("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

_id_95419B47267B7DEA(array) {
  if(array.size == 1)
    return array[0];

  array = scripts\engine\utility::array_randomize(array);
  _id_AD98B0B8CE2A6FDE = array[0];

  if(!isDefined(_id_AD98B0B8CE2A6FDE.used_time))
    _id_AD98B0B8CE2A6FDE.used_time = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    node = array[_id_AC0E594AC96AA3A8];

    if(!isDefined(node.used_time))
      node.used_time = 0;

    if(node.used_time < _id_AD98B0B8CE2A6FDE.used_time)
      _id_AD98B0B8CE2A6FDE = node;
  }

  _id_AD98B0B8CE2A6FDE.used_time = gettime();
  return _id_AD98B0B8CE2A6FDE;
}

_id_DB4AD034E4606091(node, startnode) {
  array = [];
  count = 0;

  for(;;) {
    array[array.size] = node;
    count++;

    if(count == 16) {
      break;
    }

    if(_id_91DFF8E3EC6780C3(node)) {
      break;
    }

    if(!isDefined(node.target) && !isDefined(node.script_linkto)) {
      break;
    }

    _id_6EC865F8E82F3AE6 = node _id_9ABBCE4B66EE25D4();

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = _id_95419B47267B7DEA(_id_6EC865F8E82F3AE6);

    if(node == startnode) {
      break;
    }
  }

  return array;
}

_id_D0EA0BD3D1A6C928(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self setgoalpath(patharray);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < patharray.size; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8;
    _id_E0386CBFBCCBBC5B = patharray[_id_AC0E594AC96AA3A8];
    self.currentnode = _id_E0386CBFBCCBBC5B;
    _id_4DEA69A8C26A5378(_id_E0386CBFBCCBBC5B);
    patharrayindex = waittill_subgoal();

    if(index == patharray.size - 1) {
      self waittill("goal");
      break;
    }

    _id_E0386CBFBCCBBC5B notify("trigger", self);
    _id_8D1FD30657566AEA(_id_E0386CBFBCCBBC5B, _id_D25339A42DEEAC35);
    _id_EF3A20CDB3C82B48(_id_E0386CBFBCCBBC5B);
    _id_05DCBED48DF675E1(_id_E0386CBFBCCBBC5B, _id_5E38F20C9628AE25);
  }
}

is_specified_unittype(unittype) {
  return isDefined(self.unittype) && self.unittype == unittype;
}

_id_43C2F1D3946E3EA8(_id_F7EE87DC76B45E62) {
  _id_F7EE87DC76B45E62 = _id_CD64ED2EDDF5CB1C(_id_F7EE87DC76B45E62);

  if(is_specified_unittype("civilian"))
    scripts\asm\asm_bb::bb_setcivilianstate(_id_F7EE87DC76B45E62);
  else if(!is_specified_unittype("juggernaut"))
    scripts\common\utility::demeanor_override(_id_F7EE87DC76B45E62);
}

_id_CD64ED2EDDF5CB1C(_id_F7EE87DC76B45E62) {
  switch (_id_F7EE87DC76B45E62) {
    case "casual_gun":
    case "casual":
      return "patrol";
    default:
      return _id_F7EE87DC76B45E62;
  }
}

_id_4DEA69A8C26A5378(node) {}

_id_8D1FD30657566AEA(node, _id_D25339A42DEEAC35) {
  if(isDefined(_id_D25339A42DEEAC35))
    [[_id_D25339A42DEEAC35]](node);

  if(isDefined(node.script_flag_set))
    scripts\engine\utility::flag_set(node.script_flag_set);

  if(isDefined(node.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(node.script_ent_flag_set);

  if(isDefined(node.script_flag_clear))
    scripts\engine\utility::flag_clear(node.script_flag_clear);
}

_id_EF3A20CDB3C82B48(node) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(level.global_stealth_broken) && !istrue(self.entered_combat) && isDefined(node.script_animation_type)) {
    _id_DD1921916C4E99C7 = undefined;
    _id_4B7479AE0DF07570 = strtok(node.script_animation_type, ",");
    _id_DD1921916C4E99C7 = scripts\engine\utility::random(_id_4B7479AE0DF07570);

    if(isDefined(_id_DD1921916C4E99C7)) {
      if(!istrue(node.script_looping))
        self.single_loop = 1;
      else
        self.single_loop = undefined;

      self.playing_skit = 1;
      _id_FDE914F2364973E2(node, _id_DD1921916C4E99C7);
      self.playing_skit = undefined;

      while(istrue(self.playing_skit))
        wait 0.05;
    }
  }
}

_id_FDE914F2364973E2(node, _id_DD1921916C4E99C7) {
  self endon("death");

  if(istrue(self.single_loop))
    self endon("patrol_" + _id_DD1921916C4E99C7 + "_loop");

  _setgoalpos(node.origin, undefined, 1);
  self thread[[level.spawn_skits[_id_DD1921916C4E99C7].skit_func]]();

  while(istrue(self.playing_skit))
    wait 0.05;
}

_id_05DCBED48DF675E1(node, _id_5E38F20C9628AE25) {
  if(isDefined(node.script_soundalias)) {
    if(soundexists(node.script_soundalias))
      self playSound(node.script_soundalias);
  }

  if(isDefined(node.script_forcegoal))
    _id_C6930AC29FE6FF53(node.script_forcegoal);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(node.script_delay_post))
    wait(node.script_delay_post);

  while(isDefined(node.script_requires_player)) {
    node.script_requires_player = 0;

    if(_id_557601291BB22FAA(node, ::_id_9ABBCE4B66EE25D4)) {
      node.script_requires_player = 1;
      node notify("script_requires_player");
      break;
    }

    wait 0.25;
  }

  if(isDefined(node.script_demeanor_post))
    _id_43C2F1D3946E3EA8(node.script_demeanor_post);

  if(isDefined(_id_5E38F20C9628AE25))
    [[_id_5E38F20C9628AE25]](node);

  if(isDefined(node.script_death) && node.script_death)
    scripts\mp\agents\agent_utility::_id_CB7D1454840BB597();

  if(isDefined(node.script_delete) && node.script_delete)
    self delete();
}

_id_557601291BB22FAA(node, _id_98EA791865528A70) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin))
      return 1;

    if(!isDefined(node.script_dist_only)) {
      _id_06A3A1033FFC2699 = anglesToForward(self.angles);

      if(isDefined(node.target)) {
        temp = node[[_id_98EA791865528A70]](node.target);

        if(temp.size == 1)
          _id_06A3A1033FFC2699 = vectorNormalize(temp[0].origin - node.origin);
        else if(isDefined(node.angles))
          _id_06A3A1033FFC2699 = anglesToForward(node.angles);
      } else if(isDefined(node.angles))
        _id_06A3A1033FFC2699 = anglesToForward(node.angles);

      _id_9601C525B7890A11 = [];
      _id_9601C525B7890A11[_id_9601C525B7890A11.size] = vectorNormalize(player.origin - self.origin);

      foreach(value in _id_9601C525B7890A11) {
        if(vectordot(_id_06A3A1033FFC2699, value) > 0)
          return 1;
      }
    }

    dist = 300;

    if(node.script_requires_player > dist)
      dist = node.script_requires_player;

    if(distancesquared(player.origin, self.origin) < squared(dist))
      return 1;

    return 0;
  }
}

waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", index);
  return index;
}

_id_91DFF8E3EC6780C3(_id_9DA7DD4834E89D17) {
  if(!isDefined(_id_9DA7DD4834E89D17))
    return 1;

  if(!isDefined(_id_9DA7DD4834E89D17.target))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_add))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_ent_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_post))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_requires_player))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_idle))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_stopnode))
    return 1;

  return 0;
}

_id_DB64D1E0F2B06482(node, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  level endon("game_ended");

  if(!isarray(node))
    node = [node];

  thread _id_BACB634331B86A93();
  _id_A749CE9B52022669 = 0;
  patharrayindex = 0;
  patharray = undefined;
  startnode = node[0];

  for(;;) {
    if(!_id_A749CE9B52022669) {
      node = _id_95419B47267B7DEA(node);
      patharray = _id_DB4AD034E4606091(node, startnode);

      if(patharray.size > 1)
        _id_A749CE9B52022669 = 1;
    }

    self.currentnode = node;

    if(_id_A749CE9B52022669) {
      node = patharray[patharray.size - 1];
      _id_D0EA0BD3D1A6C928(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
      patharray = undefined;
      _id_A749CE9B52022669 = 0;
    } else {
      _id_4DEA69A8C26A5378(node);
      _id_E04E9F343593BF4E(node);
      self waittill("goal");
    }

    node notify("trigger", self);
    _id_8D1FD30657566AEA(node, _id_D25339A42DEEAC35);
    _id_EF3A20CDB3C82B48(node);
    node scripts\engine\utility::script_delay();

    if(isDefined(node.script_flag_wait))
      scripts\engine\utility::flag_wait(node.script_flag_wait);

    if(isDefined(node.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(node.script_ent_flag_wait);

    node scripts\engine\utility::script_wait();
    _id_05DCBED48DF675E1(node, _id_5E38F20C9628AE25);

    if(!isDefined(node.target) && !isDefined(node.script_linkto)) {
      break;
    }

    _id_6EC865F8E82F3AE6 = node _id_9ABBCE4B66EE25D4();

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = _id_6EC865F8E82F3AE6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  volume = self getgoalvolume();

  if(isDefined(volume))
    self setgoalvolumeauto(volume, volume _id_4B6A41E8B3EE5932());
}

_id_4B6A41E8B3EE5932() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}

_id_A2FFE923E7D0A34C(node) {
  _id_AA8F023C16FC448D(node);
  self notify("go_to_node_new_goal");
}

_id_E04E9F343593BF4E(ent) {
  if(isnode(ent))
    _id_A2FFE923E7D0A34C(ent);
  else if(isstruct(ent))
    _id_DAE5FD9C1E198E1A(ent);
  else if(isent(ent))
    _id_3CFE299BAAF790B5(ent);

  if(isstruct(ent) || isnode(ent))
    ent.patrol_stop = _id_91DFF8E3EC6780C3(ent);
}

_id_3CFE299BAAF790B5(ent) {
  if(ent.code_classname == "info_volume") {
    self setgoalvolumeauto(ent, ent _id_4B6A41E8B3EE5932());
    self notify("go_to_node_new_goal");
    return;
  }

  _id_DAE5FD9C1E198E1A(ent);
}

_id_DAE5FD9C1E198E1A(ent) {
  _setgoalpos(ent.origin);
  self notify("go_to_node_new_goal");
}

_id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79) {
  if(isagent(agent))
    agent._id_F8BC7ECDD324DD79 = _id_F8BC7ECDD324DD79;
  else if(isint(agent) && isDefined(level._id_879053468F168806[agent]))
    level._id_879053468F168806[agent]._id_F8BC7ECDD324DD79 = _id_F8BC7ECDD324DD79;
}

_id_D1E130608E4F8487(agent, origin, _id_BA8B04EB4B683E67, _id_39E3177C55F34E64, _id_A34F6FB5917D2093) {
  _id_F8BC7ECDD324DD79 = _id_2F254CF573DA1A36(origin, _id_BA8B04EB4B683E67, _id_39E3177C55F34E64, _id_A34F6FB5917D2093);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_2F254CF573DA1A36(origin, _id_BA8B04EB4B683E67, _id_39E3177C55F34E64, _id_A34F6FB5917D2093) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "guard";
  _id_F8BC7ECDD324DD79.origin = origin;
  _id_F8BC7ECDD324DD79._id_BA8B04EB4B683E67 = _id_BA8B04EB4B683E67;

  if(isDefined(_id_39E3177C55F34E64) && isDefined(_id_A34F6FB5917D2093)) {
    _id_F8BC7ECDD324DD79._id_39E3177C55F34E64 = _id_39E3177C55F34E64;
    _id_F8BC7ECDD324DD79._id_A34F6FB5917D2093 = _id_A34F6FB5917D2093;
  }

  return _id_F8BC7ECDD324DD79;
}

_id_E786AA52B93833EB(agent, origin, radius, _id_C154E6E386654A30) {
  _id_F8BC7ECDD324DD79 = _id_F592B31E1A9C245C(origin, radius, _id_C154E6E386654A30);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_F592B31E1A9C245C(origin, radius, _id_C154E6E386654A30) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "wander";
  _id_F8BC7ECDD324DD79.origin = origin;
  _id_F8BC7ECDD324DD79.radius = radius;
  _id_F8BC7ECDD324DD79._id_C154E6E386654A30 = _id_C154E6E386654A30;
  return _id_F8BC7ECDD324DD79;
}

_id_FE5620595915170F(agent, origin, radius, _id_C154E6E386654A30) {
  _id_F8BC7ECDD324DD79 = _id_F9A6BEB9CE9044E8(origin, radius, _id_C154E6E386654A30);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_F9A6BEB9CE9044E8(origin, radius, _id_C154E6E386654A30) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "combatwander";
  _id_F8BC7ECDD324DD79.origin = origin;
  _id_F8BC7ECDD324DD79.radius = radius;
  _id_F8BC7ECDD324DD79._id_C154E6E386654A30 = _id_C154E6E386654A30;
  return _id_F8BC7ECDD324DD79;
}

_id_4561FE6BFC76F8EC(agent, _id_886DFA499937A071, pathstruct, _id_39E3177C55F34E64, _id_A34F6FB5917D2093) {
  _id_F8BC7ECDD324DD79 = _id_57D602C47BB19473(_id_886DFA499937A071, pathstruct, _id_39E3177C55F34E64, _id_A34F6FB5917D2093);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_57D602C47BB19473(_id_886DFA499937A071, pathstruct, _id_39E3177C55F34E64, _id_A34F6FB5917D2093) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "patrol";
  _id_F8BC7ECDD324DD79.pathstruct = pathstruct;
  _id_F8BC7ECDD324DD79._id_886DFA499937A071 = _id_886DFA499937A071;

  if(isDefined(_id_39E3177C55F34E64) && isDefined(_id_A34F6FB5917D2093)) {
    _id_F8BC7ECDD324DD79._id_39E3177C55F34E64 = _id_39E3177C55F34E64;
    _id_F8BC7ECDD324DD79._id_A34F6FB5917D2093 = _id_A34F6FB5917D2093;
  }

  return _id_F8BC7ECDD324DD79;
}

_id_0BD9ACC7C99AD884(agent, _id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  _id_F8BC7ECDD324DD79 = _id_4B8038FE29027D5F(_id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_4B8038FE29027D5F(_id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "combatRush";
  _id_F8BC7ECDD324DD79._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;
  _id_F8BC7ECDD324DD79._id_E298CEC41261345C = _id_E298CEC41261345C;
  _id_F8BC7ECDD324DD79._id_87D4C4075F48EC58 = _id_87D4C4075F48EC58;
  _id_F8BC7ECDD324DD79._id_21F24AECB313E479 = _id_21F24AECB313E479;
  _id_F8BC7ECDD324DD79._id_3E332762C9138001 = _id_3E332762C9138001;
  _id_F8BC7ECDD324DD79._id_69565040C77112CE = _id_69565040C77112CE;
  _id_F8BC7ECDD324DD79._id_1B3D1C2F22B62206 = _id_1B3D1C2F22B62206;
  return _id_F8BC7ECDD324DD79;
}

_id_6E3DD46C3475CD2D(agent, _id_2BD923437ECC04BD, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  _id_F8BC7ECDD324DD79 = _id_4B8735C04ECE8334(_id_2BD923437ECC04BD, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_4B8735C04ECE8334(_id_2BD923437ECC04BD, _id_E298CEC41261345C, _id_87D4C4075F48EC58, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "combatRushChain";
  _id_F8BC7ECDD324DD79._id_2BD923437ECC04BD = _id_2BD923437ECC04BD;
  _id_F8BC7ECDD324DD79._id_E298CEC41261345C = _id_E298CEC41261345C;
  _id_F8BC7ECDD324DD79._id_87D4C4075F48EC58 = _id_87D4C4075F48EC58;
  _id_F8BC7ECDD324DD79._id_21F24AECB313E479 = _id_21F24AECB313E479;
  _id_F8BC7ECDD324DD79._id_3E332762C9138001 = _id_3E332762C9138001;
  _id_F8BC7ECDD324DD79._id_69565040C77112CE = _id_69565040C77112CE;
  _id_F8BC7ECDD324DD79._id_1B3D1C2F22B62206 = _id_1B3D1C2F22B62206;
  return _id_F8BC7ECDD324DD79;
}

_id_29B1F7F88B879860(agent, _id_F1548C57038E1B7A, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239) {
  _id_F8BC7ECDD324DD79 = _id_D9B313747ECDF8A9(_id_F1548C57038E1B7A, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239);
  _id_37E5A190E3C946D5(agent, _id_F8BC7ECDD324DD79);
}

_id_D9B313747ECDF8A9(_id_F1548C57038E1B7A, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239) {
  _id_F8BC7ECDD324DD79 = spawnStruct();
  _id_F8BC7ECDD324DD79.behavior = "cqb";
  _id_F8BC7ECDD324DD79._id_F1548C57038E1B7A = _id_F1548C57038E1B7A;
  _id_F8BC7ECDD324DD79._id_BC0D4C6360EFC237 = _id_BC0D4C6360EFC237;
  _id_F8BC7ECDD324DD79._id_C7988FD0B09710BC = _id_C7988FD0B09710BC;
  _id_F8BC7ECDD324DD79._id_3431921FAC306239 = _id_3431921FAC306239;
  return _id_F8BC7ECDD324DD79;
}

_id_F0C78111CE0CDC0A(agent) {
  if(isagent(agent))
    return agent._id_F8BC7ECDD324DD79;
  else if(isint(agent) && isDefined(level._id_879053468F168806) && isDefined(level._id_879053468F168806[agent]))
    return level._id_879053468F168806[agent]._id_F8BC7ECDD324DD79;

  return undefined;
}

_id_580A150BA253DE13(agent) {
  agent endon("death");

  if(!isDefined(agent._id_F8BC7ECDD324DD79)) {
    return;
  }
  switch (agent._id_F8BC7ECDD324DD79.behavior) {
    case "guard":
      agent thread _id_B11C1964F528574B(agent, agent._id_F8BC7ECDD324DD79._id_BA8B04EB4B683E67, agent._id_F8BC7ECDD324DD79.origin);
      break;
    case "wander":
      if(isDefined(level._id_1C8CBD78AF4920D0))
        agent thread[[level._id_1C8CBD78AF4920D0]](agent, agent._id_F8BC7ECDD324DD79.radius, agent._id_F8BC7ECDD324DD79._id_C154E6E386654A30, agent._id_F8BC7ECDD324DD79.origin);
      else
        agent thread _id_9BBF1713A14FA580(agent, agent._id_F8BC7ECDD324DD79.radius, agent._id_F8BC7ECDD324DD79._id_C154E6E386654A30, agent._id_F8BC7ECDD324DD79.origin);

      break;
    case "combatwander":
      agent thread _id_A057EE9ADC9547D5(agent, agent._id_F8BC7ECDD324DD79.radius, agent._id_F8BC7ECDD324DD79._id_C154E6E386654A30, agent._id_F8BC7ECDD324DD79.origin);
      break;
    case "patrol":
      level thread _id_25CC93D439C3033A([agent], agent._id_F8BC7ECDD324DD79.pathstruct);
      break;
    case "combatRush":
      bp = agent._id_F8BC7ECDD324DD79;
      agent thread _id_A5117518725DA028(agent, bp._id_C5E7FCE963586EC0, bp._id_E298CEC41261345C, bp._id_87D4C4075F48EC58, bp._id_21F24AECB313E479, bp._id_3E332762C9138001, bp._id_69565040C77112CE);
      break;
    case "combatRushChain":
      bp = agent._id_F8BC7ECDD324DD79;
      agent thread _id_65F6A39E1083FB6B(agent, bp._id_2BD923437ECC04BD, bp._id_E298CEC41261345C, bp._id_87D4C4075F48EC58, bp._id_21F24AECB313E479, bp._id_3E332762C9138001, bp._id_69565040C77112CE);
      break;
    case "cqb":
      bp = agent._id_F8BC7ECDD324DD79;
      agent thread _id_C7307D56A1A61172(agent, bp._id_F1548C57038E1B7A, bp._id_BC0D4C6360EFC237, bp._id_C7988FD0B09710BC, bp._id_3431921FAC306239);
      break;
  }
}

_id_8DAD0C97C82FB52F(agent, targetent) {
  node = agent findbestcovernode(undefined, 0, agent.origin);

  if(isDefined(node)) {
    if(!isDefined(agent.node) || agent.node != node) {
      agent.keepclaimednode = 0;
      agent.keepclaimednodeifvalid = 0;
      agent usecovernode(node);
    }
  }
}

_id_C7307D56A1A61172(agent, _id_F1548C57038E1B7A, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239) {
  _id_29B1F7F88B879860(agent, _id_F1548C57038E1B7A, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239);

  if(isint(agent)) {
    return;
  }
  if(!isDefined(_id_F1548C57038E1B7A) || _id_F1548C57038E1B7A.size == 0) {
    _id_9815FCE1944A6AE0 = _id_2E33F8E46F95167C(agent.origin, 512, 1);
    _id_F1548C57038E1B7A = scripts\engine\utility::array_combine(_id_9815FCE1944A6AE0._id_E67F0B2EA7AE69ED, _id_9815FCE1944A6AE0._id_8A055A821DDA7DA0);

    if(_id_F1548C57038E1B7A.size < 2)
      _id_F1548C57038E1B7A = scripts\engine\utility::array_combine(_id_F1548C57038E1B7A, _id_9815FCE1944A6AE0._id_3288C473E8336AB4);

    if(_id_F1548C57038E1B7A.size == 0) {
      return;
    }
    _id_F1548C57038E1B7A = _id_3A17F0CCDDC999B4(agent.origin, _id_F1548C57038E1B7A, 2);

    if(_id_F1548C57038E1B7A.size == 0) {
      return;
    }
    _id_F1548C57038E1B7A = scripts\engine\utility::array_randomize(_id_F1548C57038E1B7A);
  }

  agent.balwayscoverexposed = 1;
  _id_2B26D000F2CCFC11(agent, _id_F1548C57038E1B7A[0]);
  agent thread _id_64045EA3246C7B09(agent, _id_F1548C57038E1B7A[0].origin, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239);

  if(!isDefined(_id_F1548C57038E1B7A[0].script_noteworthy) || isDefined(_id_F1548C57038E1B7A[0].script_noteworthy) && !issubstr(_id_F1548C57038E1B7A[0].script_noteworthy, "dont_move"))
    agent thread _id_C78DDDF4B72B2BB8(agent, _id_F1548C57038E1B7A);
  else
    agent thread _id_A1D0E5EA1A887436(agent, _id_F1548C57038E1B7A[0]);
}

_id_2E33F8E46F95167C(origin, _id_85EE6BB88B16100B, _id_D0E8277402331171) {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_E67F0B2EA7AE69ED = [];
  _id_8A055A821DDA7DA0 = [];
  _id_3288C473E8336AB4 = [];
  _id_EA8744DFDF5A7FD3 = getnodesinradius(origin, _id_85EE6BB88B16100B, 0, _id_85EE6BB88B16100B);

  foreach(node in _id_EA8744DFDF5A7FD3) {
    if(isDefined(node.script_noteworthy) && issubstr(node.script_noteworthy, "cqb_node")) {
      if(issubstr(node.script_noteworthy, "dont_move"))
        _id_8A055A821DDA7DA0[_id_8A055A821DDA7DA0.size] = node;
      else
        _id_E67F0B2EA7AE69ED[_id_E67F0B2EA7AE69ED.size] = node;

      continue;
    }

    if(istrue(_id_D0E8277402331171) && node.type != "path")
      _id_3288C473E8336AB4[_id_3288C473E8336AB4.size] = node;
  }

  struct = spawnStruct();
  struct._id_E67F0B2EA7AE69ED = scripts\engine\utility::array_randomize(_id_E67F0B2EA7AE69ED);
  struct._id_8A055A821DDA7DA0 = scripts\engine\utility::array_randomize(_id_8A055A821DDA7DA0);
  struct._id_3288C473E8336AB4 = scripts\engine\utility::array_randomize(_id_3288C473E8336AB4);
  return struct;
}

_id_B60B5AFFD510926C(_id_276AC5E84835EA87, _id_D0E8277402331171) {
  _id_85EE6BB88B16100B = 1024;

  if(isDefined(_id_276AC5E84835EA87._id_1A4D8A1DF4DA9847))
    _id_85EE6BB88B16100B = _id_276AC5E84835EA87._id_1A4D8A1DF4DA9847;
  else if(_id_276AC5E84835EA87._id_0C8C070D7375EF1E == "hero")
    _id_85EE6BB88B16100B = 2560;

  struct = _id_2E33F8E46F95167C(_id_276AC5E84835EA87.origin, _id_85EE6BB88B16100B, _id_D0E8277402331171);
  _id_50F783A5617F8940 = [];

  foreach(node in struct._id_E67F0B2EA7AE69ED) {
    if(_id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = node;
  }

  _id_276AC5E84835EA87._id_E67F0B2EA7AE69ED = _id_50F783A5617F8940;
  _id_50F783A5617F8940 = [];

  foreach(node in struct._id_8A055A821DDA7DA0) {
    if(_id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = node;
  }

  _id_276AC5E84835EA87._id_8A055A821DDA7DA0 = _id_50F783A5617F8940;
  _id_50F783A5617F8940 = [];

  if(istrue(_id_D0E8277402331171)) {
    foreach(node in struct._id_3288C473E8336AB4) {
      if(_id_4948CDF739393D2D::_id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87))
        _id_50F783A5617F8940[_id_50F783A5617F8940.size] = node;
    }
  }

  _id_276AC5E84835EA87._id_3288C473E8336AB4 = _id_50F783A5617F8940;
}

_id_984E27D6C139A63D(_id_F1548C57038E1B7A) {
  _id_F1548C57038E1B7A = scripts\engine\utility::array_randomize(_id_F1548C57038E1B7A);

  foreach(node in _id_F1548C57038E1B7A) {
    if(!istrue(node.claimed))
      return node;
  }

  return undefined;
}

_id_3A17F0CCDDC999B4(origin, _id_F1548C57038E1B7A, _id_76045CF7C0669684, _id_8758DA22D0D9D169, _id_D557A0584F34F219) {
  _id_06BC750307EF572F = sortbydistance(_id_F1548C57038E1B7A, origin);
  _id_7CA632D869621E0D = [];
  _id_5AD587BDAEC2C87A = 16384;

  if(!isDefined(_id_76045CF7C0669684))
    _id_76045CF7C0669684 = 1;

  if(!isDefined(_id_8758DA22D0D9D169))
    _id_8758DA22D0D9D169 = 75;

  foreach(node in _id_06BC750307EF572F) {
    if(_id_7CA632D869621E0D.size == _id_76045CF7C0669684)
      return _id_7CA632D869621E0D;

    if(istrue(node.reserved)) {
      continue;
    }
    if(!istrue(_id_D557A0584F34F219) && istrue(node.claimed)) {
      continue;
    }
    if(abs(origin[2] - node.origin[2]) >= _id_8758DA22D0D9D169) {
      continue;
    }
    _id_CB63B425C600B043 = 0;

    foreach(_id_3DA66F9BE4E79ECC in _id_7CA632D869621E0D) {
      if(distance2dsquared(_id_3DA66F9BE4E79ECC.origin, node.origin) < _id_5AD587BDAEC2C87A) {
        _id_CB63B425C600B043 = 1;
        break;
      }
    }

    if(_id_CB63B425C600B043) {
      continue;
    }
    _id_5DEE42277BB33B87 = isDefined(node.script_noteworthy) && issubstr(node.script_noteworthy, "dont_move");

    if(_id_5DEE42277BB33B87 && _id_7CA632D869621E0D.size > 0) {
      continue;
    }
    node.reserved = 1;
    _id_7CA632D869621E0D[_id_7CA632D869621E0D.size] = node;

    if(_id_5DEE42277BB33B87)
      return _id_7CA632D869621E0D;
  }

  foreach(node in _id_06BC750307EF572F) {
    if(_id_7CA632D869621E0D.size == _id_76045CF7C0669684)
      return _id_7CA632D869621E0D;

    if(!istrue(_id_D557A0584F34F219) && istrue(node.claimed)) {
      continue;
    }
    if(abs(origin[2] - node.origin[2]) >= _id_8758DA22D0D9D169) {
      continue;
    }
    foreach(_id_3DA66F9BE4E79ECC in _id_7CA632D869621E0D) {
      if(distance2dsquared(_id_3DA66F9BE4E79ECC.origin, node.origin) < _id_5AD587BDAEC2C87A)
        continue;
    }

    _id_5DEE42277BB33B87 = isDefined(node.script_noteworthy) && issubstr(node.script_noteworthy, "dont_move");

    if(_id_5DEE42277BB33B87 && _id_7CA632D869621E0D.size > 0) {
      continue;
    }
    _id_7CA632D869621E0D[_id_7CA632D869621E0D.size] = node;

    if(_id_5DEE42277BB33B87)
      return _id_7CA632D869621E0D;
  }

  return _id_7CA632D869621E0D;
}

_id_93EC69284851C54E(node) {
  if(isDefined(node))
    node.claimed = 1;
}

_id_25190883A02FDEF7(node) {
  if(isDefined(node))
    node.claimed = 0;
}

_id_2B26D000F2CCFC11(agent, node) {
  if(!isDefined(node) || istrue(node.claimed))
    return 0;

  self.keepclaimednode = 0;
  agent.keepclaimednode = 0;
  _id_93EC69284851C54E(node);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "cqbNode", node);
  agent usecovernode(node);
  agent _id_304DA84D9A815C01(node.origin, 32);
  agent.alertlevel = "combat";
  return 1;
}

_id_C78DDDF4B72B2BB8(agent, nodes, _id_30F2848645468450, _id_30CF7A864520269A) {
  agent endon("death");
  agent endon("endCQB");

  if(!isDefined(nodes) || nodes.size <= 1) {
    return;
  }
  if(!isDefined(_id_30F2848645468450))
    _id_30F2848645468450 = 8;

  if(!isDefined(_id_30CF7A864520269A))
    _id_30CF7A864520269A = 12;

  _id_AA2C4B3D41B3E85C = randomintrange(_id_30F2848645468450, _id_30CF7A864520269A);
  currenttime = 0;
  interval = 1;
  _id_8C36129F39216B9A = 0;
  node = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "cqbNode");

  if(!isDefined(node)) {
    node = _id_984E27D6C139A63D(nodes);
    _id_8C36129F39216B9A = _id_2B26D000F2CCFC11(agent, node);
    thread _id_A1D0E5EA1A887436(agent, node, _id_AA2C4B3D41B3E85C);
  }

  for(;;) {
    if(currenttime >= _id_AA2C4B3D41B3E85C) {
      _id_AA2C4B3D41B3E85C = randomintrange(_id_30F2848645468450, _id_30CF7A864520269A);
      currenttime = 0;

      if(!agent isinscriptedstate()) {
        if(_id_8C36129F39216B9A)
          _id_25190883A02FDEF7(node);

        node = _id_984E27D6C139A63D(nodes);
        _id_8C36129F39216B9A = _id_2B26D000F2CCFC11(agent, node);
        thread _id_A1D0E5EA1A887436(agent, node, _id_AA2C4B3D41B3E85C);
      }
    }

    wait 1;
    currenttime = currenttime + interval;
  }
}

_id_64045EA3246C7B09(agent, origin, _id_BC0D4C6360EFC237, _id_C7988FD0B09710BC, _id_3431921FAC306239) {
  agent endon("death");
  interval = 1;
  lastshoottime = agent._blackboard._id_060DCAA3D3BE97AB;
  _id_8963DF9EB4AA344B = agent.enemy;
  _id_4FD41AADC35B28E0 = 0;
  _id_509B688B66616418 = 1;
  _id_B82F2E5E14761B97 = [];
  _id_149518F76F493448 = 0;
  _id_15864B7B1533B47D = 0;
  _id_7D91E6095747F0B2 = 2;

  while(_id_509B688B66616418) {
    foreach(index, enemy in _id_B82F2E5E14761B97) {
      _id_031CA5DBBE353500 = isalive(enemy);
      canseeenemy = undefined;

      if(_id_031CA5DBBE353500)
        canseeenemy = agent cansee(enemy);

      if(!istrue(_id_031CA5DBBE353500) || !istrue(canseeenemy) || istrue(canseeenemy) && (istrue(enemy.inlaststand) || !isalive(enemy)))
        _id_B82F2E5E14761B97 = scripts\engine\utility::array_remove(_id_B82F2E5E14761B97, enemy);
    }

    enemy = agent.enemy;

    if(isDefined(enemy) && !scripts\engine\utility::array_contains(_id_B82F2E5E14761B97, enemy))
      _id_B82F2E5E14761B97[_id_B82F2E5E14761B97.size] = enemy;

    foreach(enemy in _id_B82F2E5E14761B97) {
      canseeenemy = agent cansee(enemy);

      if(istrue(canseeenemy) && !_id_149518F76F493448) {
        _id_149518F76F493448 = 1;
        _id_15864B7B1533B47D = 0;
        break;
      }
    }

    if(istrue(_id_149518F76F493448)) {
      if(_id_15864B7B1533B47D >= _id_7D91E6095747F0B2) {
        _id_509B688B66616418 = 0;
        continue;
      } else if(_id_B82F2E5E14761B97.size == 0)
        _id_149518F76F493448 = 0;
      else
        _id_15864B7B1533B47D = _id_15864B7B1533B47D + interval;
    }

    wait(interval);
  }

  agent notify("endCQB");
  agent _id_304DA84D9A815C01(origin, 1024);
}

_id_9BCF6B76EA52EE4C() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_31EC5C74EBB7EF91 = scripts\engine\utility::getStructArray("ambush_spawn", "script_noteworthy");
  _id_C229D93C0BB4F8E8 = scripts\engine\utility::random(_id_31EC5C74EBB7EF91);
  _id_E67F0B2EA7AE69ED = [];
  _id_8A055A821DDA7DA0 = [];
  _id_EA8744DFDF5A7FD3 = getnodesinradius(_id_C229D93C0BB4F8E8.origin, 512, 0, 512);

  foreach(node in _id_EA8744DFDF5A7FD3) {
    if(isDefined(node.script_noteworthy) && issubstr(node.script_noteworthy, "cqb_node")) {
      if(issubstr(node.script_noteworthy, "dont_move")) {
        node._id_8D756F0D1B8F56F7 = 1;
        _id_8A055A821DDA7DA0[_id_8A055A821DDA7DA0.size] = node;
        continue;
      }

      _id_E67F0B2EA7AE69ED[_id_E67F0B2EA7AE69ED.size] = node;
    }
  }

  wait 10;
  covernode = _id_E67F0B2EA7AE69ED[0];
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  level._id_7CE9081BCF4AF5A6 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, covernode.origin, _id_C229D93C0BB4F8E8.angles, "high", "reinforcements", "debug");

  if(isDefined(level._id_7CE9081BCF4AF5A6)) {
    level thread _id_249321AEBDEE5DDC(level._id_7CE9081BCF4AF5A6, _id_E67F0B2EA7AE69ED);
    level thread _id_64045EA3246C7B09(level._id_7CE9081BCF4AF5A6, covernode.origin);
  }

  covernode = _id_E67F0B2EA7AE69ED[1];
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  level._id_7CE9081BCF4AF5A6 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, covernode.origin, _id_C229D93C0BB4F8E8.angles, "high", "reinforcements", "debug");

  if(isDefined(level._id_7CE9081BCF4AF5A6)) {
    level thread _id_249321AEBDEE5DDC(level._id_7CE9081BCF4AF5A6, _id_E67F0B2EA7AE69ED);
    level thread _id_64045EA3246C7B09(level._id_7CE9081BCF4AF5A6, covernode.origin);
  }

  covernode = _id_8A055A821DDA7DA0[0];
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("shotgun");
  level._id_7CE9081BCF4AF5A6 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, covernode.origin, _id_C229D93C0BB4F8E8.angles, "high", "reinforcements", "debug");

  if(isDefined(level._id_7CE9081BCF4AF5A6)) {
    _id_2B26D000F2CCFC11(level._id_7CE9081BCF4AF5A6, covernode);
    level thread _id_64045EA3246C7B09(level._id_7CE9081BCF4AF5A6, covernode.origin);
  }
}

_id_249321AEBDEE5DDC(agent, nodes) {
  agent endon("death");
  agent endon("endCQB");
  _id_AA2C4B3D41B3E85C = 5;
  currenttime = 0;
  interval = 1;
  node = undefined;

  for(;;) {
    if(currenttime >= _id_AA2C4B3D41B3E85C) {
      currenttime = 0;
      _id_25190883A02FDEF7(node);
      node = _id_984E27D6C139A63D(nodes);
      _id_2B26D000F2CCFC11(agent, node);
      thread _id_A1D0E5EA1A887436(agent, node, _id_AA2C4B3D41B3E85C);
    }

    wait 1;
    currenttime = currenttime + interval;
  }
}

_id_A1D0E5EA1A887436(agent, node, time) {
  if(!0) {
    return;
  }
  if(!isDefined(node) || istrue(node.claimed)) {
    return;
  }
  agent endon("death");
  interval = 0.05;

  for(currenttime = 0; !isDefined(time) || currenttime < time; currenttime = currenttime + interval) {
    agent thread scripts\mp\utility\debug::drawsphere(node.origin, 32, interval, (1, 0, 1));
    agent thread scripts\cp_mp\utility\debug_utility::drawline(node.origin, agent.origin, interval, (0, 1, 0));
    wait(interval);
  }
}

_id_B8687F27CFC0719C(agent, nodes) {
  agent endon("death");
  interval = 0.05;

  for(;;) {
    foreach(node in nodes) {
      agent thread scripts\mp\utility\debug::drawsphere(agent.origin, 16, 0.05, (0, 0, 1));
      agent thread scripts\cp_mp\utility\debug_utility::drawline(node.origin, agent.origin, interval, (0, 1, 0));
    }

    wait(interval);
  }
}

_id_1EFA739F9E55871F() {
  level endon("game_ended");
  agents = [];
  interval = 0.05;

  for(;;) {
    if(getdvarint("dvar_B85B66DBDC0853F9", 0) == 1) {
      foreach(agent in agents)
      agent kill();

      waitframe();
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(level.players[0].origin);
      team = level.players[0].team;

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        team = "team_hundred_ninety_five";

      agents = _id_48814951E916AF89::_id_6214774E8E021663(1, level.players[0].origin, "absolute", "reinforcements", "combatRushTest", undefined, team, _id_171F90B9C4C76D44, 256, 257);
    }

    if(getdvarint("dvar_B85B66DBDC0853F9", 0) == 2) {
      foreach(agent in agents)
      agent thread _id_A5117518725DA028(agent, level.players[0].origin);
    }

    if(getdvarint("dvar_B85B66DBDC0853F9", 0) == 3)
      agents = _id_48814951E916AF89::_id_353FECD1549F5F42(level.players[0].origin, 50000, level.players[0].team, 100, "all", undefined, undefined, 1);

    if(getdvarint("dvar_B85B66DBDC0853F9", 0) == 4) {
      foreach(agent in agents)
      agent thread _id_65F6A39E1083FB6B(agent, level._id_32988D8B3D823F40);
    }

    foreach(agent in agents)
    agent thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, interval, (1, 0, 1));

    wait(interval);
  }
}