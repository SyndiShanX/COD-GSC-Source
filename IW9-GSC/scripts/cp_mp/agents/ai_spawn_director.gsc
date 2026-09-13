/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\agents\ai_spawn_director.gsc
******************************************************/

_id_EEA40A1B6180F90A(requestid, data) {
  agent = scripts\mp\mp_agent::spawnnewagentaitype(data.aitype, data.origin, data.angles, data.team);

  if(!isDefined(agent))
    return undefined;

  if(isDefined(level._id_F3A4ECD257A6CA36[requestid]) && isDefined(level._id_F3A4ECD257A6CA36[requestid]["OnSpawned"]))
    [[level._id_F3A4ECD257A6CA36[requestid]["OnSpawned"]]](requestid, agent, data);

  if(agent.unittype == "soldier" && isDefined(data.script_stealthgroup))
    agent thread _id_6ECF133B1D8DEE02(data);

  if(isDefined(data._id_EF5A3D5534030ADD)) {
    agent _meth_76B3CFB91EF40B3B(data._id_EF5A3D5534030ADD);

    if(isDefined(data._id_764BDB6FE546DACC))
      agent thread _id_93AE2D91D511DAD8(data._id_764BDB6FE546DACC);
  } else if(isDefined(data._id_764BDB6FE546DACC))
    agent _id_618CF23700C29E56(data._id_764BDB6FE546DACC);
  else
    agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 500, 0, agent.origin);

  _id_5BB577A0F2F9E0D3 = scripts\engine\utility::_id_53C4C53197386572(data._id_5EC625EECD27C095, "spawn");

  if(agent scripts\asm\shared\mp\utility::_id_8FA69650E33C84EF(_id_5BB577A0F2F9E0D3))
    agent thread scripts\asm\shared\mp\utility::_id_577D8ABFF6067C23(_id_5BB577A0F2F9E0D3, "spawn_end");

  return agent;
}

_id_6ECF133B1D8DEE02(data) {
  if(isDefined(data.script_stealthgroup)) {
    self.script_stealthgroup = data.script_stealthgroup;
    thread scripts\stealth\enemy::main();
    thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
    self._id_BA67494935B9726B = 1;
    waitframe();

    if(istrue(data.alert))
      self[[self.fnsetstealthstate]]("combat");
  }
}

_id_5CE6B6B9DE3E6CFF(requestid) {
  if(isDefined(level._id_F3A4ECD257A6CA36[requestid]["ReadyToSpawn"]))
    [[level._id_F3A4ECD257A6CA36[requestid]["ReadyToSpawn"]]](requestid);
  else
    _func_A39E9894083F4513(requestid);
}

_id_13AA577F00697DB2(requestid, data) {
  if(isDefined(level._id_F3A4ECD257A6CA36[requestid]["ShouldReinforce"]))
    return [[level._id_F3A4ECD257A6CA36[requestid]["ShouldReinforce"]]](requestid, data._id_DCFF5961635938A9);

  return 1;
}

_id_386E7FD540012E1F(requestid, data) {
  if(isDefined(level._id_F3A4ECD257A6CA36[requestid]["SpawnReinforcements"]))
    return [[level._id_F3A4ECD257A6CA36[requestid]["SpawnReinforcements"]]](requestid, data._id_DCFF5961635938A9);

  return 1;
}

_id_8516DD2443304F7D(requestid) {
  level notify("ai_ai_encounter_floodfill_shutdown_thread_" + requestid);
  level endon("ai_ai_encounter_floodfill_shutdown_thread_" + requestid);
  level endon("ai_ai_encounter_shutdown_" + requestid);

  for(;;) {
    if(isDefined(level._id_F3A4ECD257A6CA36[requestid]["ShouldShutdownFloodFill"])) {
      if([[level._id_F3A4ECD257A6CA36[requestid]["ShouldShutdownFloodFill"]]](requestid)) {
        break;
      }
    } else
      break;

    waitframe();
  }

  _func_776BDB2810E99635(requestid);
}

_id_ECF64A7AB670FFF0(requestid) {
  level thread _id_8516DD2443304F7D(requestid);
}

_id_9ABE578FE2AF1212(requestid) {
  level notify("ai_ai_encounter_floodfill_spawn_thread_" + requestid);
  level endon("ai_ai_encounter_floodfill_spawn_thread_" + requestid);
  level endon("ai_ai_encounter_shutdown_" + requestid);

  for(;;) {
    if(isDefined(level._id_F3A4ECD257A6CA36[requestid]["ShouldSpawnFloodFill"])) {
      if([[level._id_F3A4ECD257A6CA36[requestid]["ShouldSpawnFloodFill"]]](requestid)) {
        break;
      }
    } else
      break;

    waitframe();
  }

  _func_6F642674E19EBC2A(requestid);
}

_id_D3BA5D80EEA20F95(requestid) {
  level thread _id_9ABE578FE2AF1212(requestid);
}

_id_841597CA2FE91D6D(requestid, _id_FA2C135047E3DA22) {
  if(isDefined(_id_FA2C135047E3DA22))
    level._id_F3A4ECD257A6CA36[requestid]["ShouldSpawnFloodFill"] = _id_FA2C135047E3DA22;
}

_id_F4EE5A4DF8CE51BE(requestid, _id_FA2C135047E3DA22) {
  if(isDefined(_id_FA2C135047E3DA22))
    level._id_F3A4ECD257A6CA36[requestid]["ShouldShutdownFloodFill"] = _id_FA2C135047E3DA22;
}

_id_9C54BDA96991B25C(requestid) {
  level notify("ai_ai_encounter_shutdown_" + requestid);
  level._id_F3A4ECD257A6CA36[requestid] = undefined;
}

_id_CF12CD77AB7CDC78(_id_65769CBDBC09AD59, requestid, data) {
  switch (_id_65769CBDBC09AD59) {
    case "spawn_ai":
      return _id_EEA40A1B6180F90A(requestid, data);
    case "ready_to_spawn":
      _id_5CE6B6B9DE3E6CFF(requestid);
      break;
    case "should_reinforce":
      return _id_13AA577F00697DB2(requestid, data);
    case "spawn_reinforcements":
      _id_386E7FD540012E1F(requestid, data);
      break;
    case "flood_fill_spawn_ready":
      _id_D3BA5D80EEA20F95(requestid);
      break;
    case "flood_fill_shutdown_ready":
      _id_ECF64A7AB670FFF0(requestid);
      break;
    case "shutdown":
      _id_9C54BDA96991B25C(requestid);
      break;
  }
}

_id_930897C0D1A7EB24(targetname) {
  requestid = _func_941528A2553E5D82(targetname);

  if(isDefined(requestid) && !isDefined(level._id_F3A4ECD257A6CA36[requestid]))
    level._id_F3A4ECD257A6CA36[requestid] = [];

  return requestid;
}

_id_F0CC0F2E6E1D085E(requestid, _id_FA2C135047E3DA22) {
  if(isDefined(_id_FA2C135047E3DA22))
    level._id_F3A4ECD257A6CA36[requestid]["ReadyToSpawn"] = _id_FA2C135047E3DA22;
}

_id_E4A67FE4DDCA7ED5(requestid, _id_FA2C135047E3DA22) {
  if(!isDefined(level._id_F3A4ECD257A6CA36[requestid])) {
    return;
  }
  level._id_F3A4ECD257A6CA36[requestid]["OnSpawned"] = _id_FA2C135047E3DA22;
}

_id_07A2920BE35F4386(requestid, _id_FA2C135047E3DA22) {
  if(!isDefined(level._id_F3A4ECD257A6CA36[requestid])) {
    return;
  }
  level._id_F3A4ECD257A6CA36[requestid]["ShouldReinforce"] = _id_FA2C135047E3DA22;
}

_id_6E43CC397B953A97(requestid, _id_FA2C135047E3DA22) {
  if(!isDefined(level._id_F3A4ECD257A6CA36[requestid])) {
    return;
  }
  level._id_F3A4ECD257A6CA36[requestid]["SpawnReinforcements"] = _id_FA2C135047E3DA22;
}

_id_54DA428AD4A96F2E(_id_52ACC86BF2482C55, origin, radius, _id_C27E2CE1DDCBBE12) {
  requestid = _func_148FD200D203457A(_id_52ACC86BF2482C55, origin, radius, _id_C27E2CE1DDCBBE12);

  if(isDefined(requestid))
    level._id_F3A4ECD257A6CA36[requestid] = [];

  return requestid;
}

_id_9950E6E485BF5261(requestid) {
  _func_22993FE73B6D16F4(requestid);
}

_id_DAA39D0822248E1C() {
  if(isDefined(level._id_03AE5F7DE11D142F)) {
    return;
  }
  level._id_03AE5F7DE11D142F = ::_id_CF12CD77AB7CDC78;
  level._id_4FE0C43951F6CE37 = getdvarint("dvar_2E4907CCD20A8761", 0);
  level._id_F3A4ECD257A6CA36 = [];
  level._id_BB30AF111A46C7A3 = [];
}

_id_618CF23700C29E56(_id_764BDB6FE546DACC) {
  if(!isDefined(level._id_BB30AF111A46C7A3[_id_764BDB6FE546DACC[0].id])) {
    pathstruct = spawnStruct();
    pathstruct._id_765DA0DC0411DBBD = [];
    pathstruct._id_765DA0DC0411DBBD[pathstruct._id_765DA0DC0411DBBD.size] = self;
    pathstruct.path = _id_764BDB6FE546DACC;
    pathstruct._id_508557C68A1CDF96 = _id_764BDB6FE546DACC[0]._id_508557C68A1CDF96;
    pathstruct._id_60482E24FA2925E8 = _id_764BDB6FE546DACC[0]._id_60482E24FA2925E8;
    level._id_BB30AF111A46C7A3[_id_764BDB6FE546DACC[0].id] = pathstruct;
    level thread _id_0A5C643ECFDE39FA(_id_764BDB6FE546DACC[0].id, pathstruct);
  } else {
    path = level._id_BB30AF111A46C7A3[_id_764BDB6FE546DACC[0].id];
    path._id_765DA0DC0411DBBD[path._id_765DA0DC0411DBBD.size] = self;
  }
}

_id_93AE2D91D511DAD8(_id_764BDB6FE546DACC) {
  level endon("game_ended");
  self endon("death");
  self endon("stealth_investigate");
  self endon("stealth_hunt");
  self endon("stealth_combat");
  self endon("startCombatRush");
  self waittill("bseq_user_deleted");
  _id_618CF23700C29E56(_id_764BDB6FE546DACC);
}

_id_0A5C643ECFDE39FA(_id_D6A24DD68967019E, pathstruct) {
  level endon("game_ended");
  _id_A48CD860F6F87E26 = [];
  path = pathstruct.path;
  pathstruct.claimed = 1;
  index = 0;
  _id_47EA45F5BCF10FC3 = 1;

  for(;;) {
    _id_886DFA499937A071 = level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E]._id_765DA0DC0411DBBD;
    point = path[index].origin;

    foreach(_id_6843D82ED42EA7DE, agent in _id_886DFA499937A071) {
      if(!isDefined(_id_A48CD860F6F87E26[_id_6843D82ED42EA7DE])) {
        agent endon("death");
        agent endon("stealth_investigate");
        agent endon("stealth_hunt");
        agent endon("stealth_combat");
        agent endon("startCombatRush");
        _id_A48CD860F6F87E26[_id_6843D82ED42EA7DE] = agent;
        agent thread _id_C2B8E94711BE96D9(_id_D6A24DD68967019E);
      }

      if(_id_6843D82ED42EA7DE != 0) {
        _id_BCFEC646853A95C1 = randomfloatrange(30, 31) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
        _id_BCFEC546853A938E = randomfloatrange(30, 31) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
        point = (point[0] + _id_BCFEC646853A95C1, point[1] + _id_BCFEC546853A938E, point[2]);
      }

      if(isDefined(path[index]._id_EF5A3D5534030ADD) && path[index]._id_EF5A3D5534030ADD != -1) {
        agent _meth_EA63241A4D3092C4();
        agent _id_120270BD0A747A35::_setgoalpos(_func_BBFC94714C82788B(path[index]._id_EF5A3D5534030ADD), 64);
        agent _meth_76B3CFB91EF40B3B(path[index]._id_EF5A3D5534030ADD);
      } else {
        agent _meth_EA63241A4D3092C4();
        agent _id_120270BD0A747A35::_setgoalpos(point, 64);
      }

      if(_id_886DFA499937A071.size > 1 && _id_6843D82ED42EA7DE == 0)
        wait 3.0;

      if(_id_886DFA499937A071.size > 1 && _id_6843D82ED42EA7DE != 0)
        wait(randomfloatrange(1.5, 2.5));
    }

    waitframe();
    _id_886DFA499937A071[0] scripts\engine\utility::waittill_any_2("goal", "bt_goal");

    if(path[index]._id_3DC216F2A253C048 < path[index]._id_F042BA4E1F3DE84E)
      wait(randomfloatrange(path[index]._id_3DC216F2A253C048, path[index]._id_F042BA4E1F3DE84E));
    else
      wait(path[index]._id_3DC216F2A253C048);

    if(_id_47EA45F5BCF10FC3)
      index++;
    else
      index--;

    if(!isDefined(path[index])) {
      if(!pathstruct._id_508557C68A1CDF96 && !pathstruct._id_60482E24FA2925E8) {
        break;
      } else {
        if(pathstruct._id_60482E24FA2925E8) {
          index = 0;
          continue;
        }

        if(_id_47EA45F5BCF10FC3) {
          index = path.size - 1;
          _id_47EA45F5BCF10FC3 = 0;
          continue;
        }

        index = 0;
        _id_47EA45F5BCF10FC3 = 1;
      }
    }
  }
}

_id_C2B8E94711BE96D9(_id_D6A24DD68967019E) {
  self waittill("death");

  foreach(_id_6843D82ED42EA7DE, agent in level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E]._id_765DA0DC0411DBBD) {
    if(agent == self) {
      level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E]._id_765DA0DC0411DBBD[_id_6843D82ED42EA7DE] = undefined;
      break;
    }
  }

  if(istrue(level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E].claimed) && level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E]._id_765DA0DC0411DBBD.size == 0)
    level._id_BB30AF111A46C7A3[_id_D6A24DD68967019E].claimed = 0;
}