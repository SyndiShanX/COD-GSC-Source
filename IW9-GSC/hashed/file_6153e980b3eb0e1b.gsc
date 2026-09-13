/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6153e980b3eb0e1b.gsc
***********************************************/

_id_48E19AA598E95954() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  level._id_FB4C92E328823A89 = _id_84FFC1F1220CA72B();
  level._id_C5233088F09B986A = _id_D6CC02D264845807();
  level._id_E006C96F4EB13B4F = getdvarint("dvar_3B04CD01C62E849E", 128);
  level thread _id_FA4B99570C140545();
  level._id_FC7E9CF9D867765E = 1;
}

_id_FA4B99570C140545() {
  level endon("game_ended");

  while(!istrue(level._id_B212A36BEC6CF8DA))
    waitframe();

  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement_pop", "pop_wait_spawn", ::_id_BD1C3703FC1E9FF7);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement_pop", "pop_doors_open", ::_id_EC009A967D1D5EB9);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement_pop", "pop_doors_closing", ::_id_8B680B3EF155FC34);
}

_id_84FFC1F1220CA72B() {
  _id_5D71D807F3D89419 = scripts\engine\utility::getStructArray("reinforcementPackage_mainNode", "script_noteworthy");
  _id_1DACE216D1A32D14 = [];

  foreach(_id_11F568BBCEDEBCF0 in _id_5D71D807F3D89419) {
    _id_782866E364DCD2EF = spawnStruct();
    _id_782866E364DCD2EF.origin = _id_11F568BBCEDEBCF0.origin;
    _id_782866E364DCD2EF._id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray(_id_11F568BBCEDEBCF0.target, "targetname");
    _id_782866E364DCD2EF.floor = 0;

    if(isDefined(level._id_172E4B629498723C))
      _id_782866E364DCD2EF.floor = [[level._id_172E4B629498723C]](_id_11F568BBCEDEBCF0.origin);

    _id_1DACE216D1A32D14[_id_11F568BBCEDEBCF0.target] = _id_782866E364DCD2EF;
  }

  return _id_1DACE216D1A32D14;
}

_id_D6CC02D264845807() {
  _id_AA1FC3193D666F74 = scripts\engine\utility::getStructArray("reinforcement_patrolPath", "script_noteworthy");
  _id_D7BAAFC9B07F5094 = [];

  foreach(_id_DEB16FDED9E9E6CF in _id_AA1FC3193D666F74)
  _id_D7BAAFC9B07F5094[_id_DEB16FDED9E9E6CF.targetname] = _id_48814951E916AF89::_id_09EDCF99159ABB0B(_id_DEB16FDED9E9E6CF);

  return _id_D7BAAFC9B07F5094;
}

_id_184496A131FC4014(origin) {
  _id_F8BBDCB816B01611 = sortbydistance(level._id_FB4C92E328823A89, origin);

  if(_id_F8BBDCB816B01611.size > 0)
    return _id_F8BBDCB816B01611[0]._id_B7015A0DBEFEBCE1;

  return [];
}

_id_98FB1EF948F4612B(_id_C5E7FCE963586EC0) {
  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker") {
    _id_EEC55FABA21F3653 = _id_5C118165D3E98A42::_id_92BEB6591366AB26("reinforcement_pop", "elevator_group_reinforcement_pop", "pop_wait_spawn", _id_C5E7FCE963586EC0, "elevator_pick_rule_ideal");

    if(isDefined(_id_EEC55FABA21F3653))
      _id_EEC55FABA21F3653._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;

    return _id_EEC55FABA21F3653;
  } else {
    if(!isDefined(level._id_265FD51BA245ADFD))
      return undefined;

    _id_167DBD5C394D0C31 = undefined;

    foreach(_id_EEC55FABA21F3653 in sortbydistance(level._id_265FD51BA245ADFD, _id_C5E7FCE963586EC0)) {
      if(istrue(_id_EEC55FABA21F3653.inuse)) {
        continue;
      }
      if(!isDefined(_id_167DBD5C394D0C31) || !isDefined(_id_EEC55FABA21F3653._id_6EC188424F7A3018) || isDefined(_id_167DBD5C394D0C31._id_6EC188424F7A3018) && isDefined(_id_EEC55FABA21F3653._id_6EC188424F7A3018) && _id_EEC55FABA21F3653._id_6EC188424F7A3018 < _id_167DBD5C394D0C31._id_6EC188424F7A3018)
        _id_167DBD5C394D0C31 = _id_EEC55FABA21F3653;
    }

    if(isDefined(_id_167DBD5C394D0C31)) {
      _id_167DBD5C394D0C31 thread elevator_think();
      return _id_167DBD5C394D0C31;
    }
  }
}

elevator_think() {
  self.inuse = 1;
  result = scripts\engine\utility::waittill_any_return_2("continue", "terminated");

  if(result != "continue") {
    self.inuse = undefined;
    return;
  }

  _id_7CC3355412E6A85F = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  _id_7CC3355412E6A85F thread _id_5C118165D3E98A42::_id_88C392696FD02DC4();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "open");
  wait 1;

  if(getdvarint("dvar_5E7BFE436C591C5F", 1) == 1) {
    forward = anglesToForward(_id_7CC3355412E6A85F.angles);
    magicgrenademanual("smoke_grenade_mp", _id_7CC3355412E6A85F._id_0646B88B6B0468F9 + (0, 0, 30) + forward * -30, (0, 0, -10) + forward * 50, 0.5);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", _id_7CC3355412E6A85F._id_0646B88B6B0468F9);
  }

  wait 2;
  _id_6B1DA470FCEE5528 = 0;

  for(;;) {
    _id_83ECE631A5C4849A = _id_DD00B8133E41DB1C(_id_7CC3355412E6A85F);

    if(!isDefined(_id_83ECE631A5C4849A)) {
      break;
    }

    if(isDefined(_id_7CC3355412E6A85F._id_3B5E36C5E7A1BDA6)) {
      _id_3450C0E8E0F4333F = _id_83ECE631A5C4849A getclosestreachablepointonnavmesh(_id_7CC3355412E6A85F._id_3B5E36C5E7A1BDA6);

      if(distancesquared(_id_7CC3355412E6A85F._id_3B5E36C5E7A1BDA6, _id_3450C0E8E0F4333F) > 400) {
        foreach(vehicle in vehicle_getarrayinradius(_id_3450C0E8E0F4333F, 300)) {
          vehicle._id_A8F4BB03B366AA80 = 1;
          vehicle thread scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
        }
      }
    }

    if(_id_6B1DA470FCEE5528 >= getdvarint("dvar_934907C8F7ADD660", 30)) {
      break;
    }

    wait 0.2;
    _id_6B1DA470FCEE5528 = _id_6B1DA470FCEE5528 + 0.2;
  }

  _id_7CC3355412E6A85F thread _id_5C118165D3E98A42::_id_D32C693D3A04F8F8();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "close");
  wait 1;
  agentarray = getaiarrayinradius(_id_7CC3355412E6A85F.origin, 250);

  foreach(agent in agentarray) {
    if(!isalive(agent)) {
      continue;
    }
    _id_8BDB743B1288E020 = (agent.origin[0], agent.origin[1], agent.origin[2] + 50);

    if(ispointinvolume(_id_8BDB743B1288E020, _id_7CC3355412E6A85F._id_0907E66D3BF42C5A))
      agent _id_48814951E916AF89::_id_28B90EB2B591003F();
  }

  self._id_6EC188424F7A3018 = gettime();
  wait 5;
  self.inuse = undefined;
}

_id_892161AB9AD430E3(numagents, _id_EC862C2C00C7AB5D, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_180734F7C2A9866F, _id_F03B10101D704759, _id_FB59C1AB2600D2F6, _id_8E5A9B658FA525ED, _id_96E335EAE30651E5) {
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_61CBC488B27A6E61(_id_C5E7FCE963586EC0);

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

  if(isDefined(level._id_D32282F99E9D01B8)) {
    if(!istrue([[level._id_D32282F99E9D01B8]](_id_C5E7FCE963586EC0)))
      return undefined;
  }

  _id_EEC55FABA21F3653 = _id_98FB1EF948F4612B(_id_C5E7FCE963586EC0);

  if(!isDefined(_id_EEC55FABA21F3653)) {
    if(istrue(level._id_BA36989C7E24E4FF)) {}

    return undefined;
  }

  if(level.mapname == "mp_biobunker" && _id_EEC55FABA21F3653.id == "elevator_50")
    numagents = min(numagents, 3);

  if(isDefined(_id_EEC55FABA21F3653._id_B586C70B173DD02B))
    _id_B586C70B173DD02B = _id_EEC55FABA21F3653._id_B586C70B173DD02B;
  else
    _id_B586C70B173DD02B = _id_184496A131FC4014(_id_EEC55FABA21F3653.car.origin);

  if(istrue(level._id_BA36989C7E24E4FF)) {}

  agents = [];
  _id_AC0E594AC96AA3A8 = 0;

  foreach(loc in _id_B586C70B173DD02B) {
    tier = undefined;

    if(isDefined(level._id_8209A75B03499110))
      tier = [[level._id_8209A75B03499110]](_id_171F90B9C4C76D44);
    else
      tier = _id_48814951E916AF89::_id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));

    type = undefined;
    _id_177DB62B63710F5D = undefined;

    if(isDefined(_id_EC862C2C00C7AB5D) && isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F) && isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8])) {
      if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type))
        type = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type;

      if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier))
        tier = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier;

      if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED))
        _id_177DB62B63710F5D = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED;
    }

    _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;

    if(tier != 1 && tier != 2 && tier != 3)
      tier = 1;

    tier = scripts\engine\utility::_id_53C4C53197386572(_id_96E335EAE30651E5, tier);
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(loc, undefined, "guard", type, tier, scripts\engine\utility::_id_53C4C53197386572(_id_177DB62B63710F5D, _id_8E5A9B658FA525ED));
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "medium", "reinforcements", "elevatorSpawn", undefined, team, undefined, _id_171F90B9C4C76D44);

    if(isDefined(agent))
      agents[agents.size] = agent;
    else if(istrue(level._id_BA36989C7E24E4FF)) {}

    if(agents.size >= numagents) {
      break;
    }
  }

  if(istrue(level._id_BA36989C7E24E4FF)) {}

  if(isDefined(level._id_D5078BBAD0790AE7))
    [[level._id_D5078BBAD0790AE7]](agents, _id_171F90B9C4C76D44);

  if(agents.size > 0) {
    _id_EEC55FABA21F3653 notify("continue");
    _id_DB76C4BB596D090E = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0];

    if(isDefined(_id_EEC55FABA21F3653.exitposition))
      _id_2BD923437ECC04BD = [_id_EEC55FABA21F3653.exitposition, _id_C5E7FCE963586EC0];
    else
      _id_2BD923437ECC04BD = [_id_DB76C4BB596D090E._id_BD440A13487263EF, _id_C5E7FCE963586EC0];

    _id_FAE1573B43B85605 = [32, level._id_E006C96F4EB13B4F];

    foreach(agent in agents)
    agent thread _id_A2500A5266B0321A(agent, _id_2BD923437ECC04BD, 0, _id_FAE1573B43B85605, undefined, undefined, undefined, level._id_1C8CBD78AF4920D0);
  } else {
    _id_EEC55FABA21F3653 notify("terminated");

    if(istrue(level._id_BA36989C7E24E4FF)) {}
  }

  return agents;
}

_id_A2500A5266B0321A(agent, _id_2BD923437ECC04BD, _id_E298CEC41261345C, _id_446DCC73FA900995, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206) {
  agent endon("death");
  _id_913774985C12C245 = _id_2BD923437ECC04BD;
  _id_120270BD0A747A35::_id_0BD9ACC7C99AD884(agent, _id_913774985C12C245, _id_E298CEC41261345C, _id_446DCC73FA900995, _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);

  foreach(index, _id_C5E7FCE963586EC0 in _id_2BD923437ECC04BD) {
    agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_C5E7FCE963586EC0, _id_E298CEC41261345C, _id_446DCC73FA900995[index], _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, 1, _id_1B3D1C2F22B62206);
    msg = agent scripts\engine\utility::waittill_any_return_2("combatRushComplete", "bad_path");

    if(msg == "bad_path") {
      agent notify("cancelCombatRush");
      agent clearbtgoal(0);
      agent clearbtgoal(1);
      self.goalradius = 1000;
      self._id_9FF99CFC426066A2 = self.goalradius;
      agent._id_B43F6CAD28078A05 = 0;

      if(isalive(agent) && isDefined(self.fnsetstealthstate))
        agent scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);

      agent._id_5DB03B1BF90D04EE = 1;
    }

    _id_913774985C12C245 = scripts\engine\utility::array_remove(_id_913774985C12C245, _id_C5E7FCE963586EC0);
    _id_120270BD0A747A35::_id_6E3DD46C3475CD2D(agent, _id_913774985C12C245, _id_E298CEC41261345C, _id_446DCC73FA900995[index], _id_21F24AECB313E479, _id_3E332762C9138001, _id_69565040C77112CE, _id_1B3D1C2F22B62206);
    waitframe();

    if(!isDefined(_id_2BD923437ECC04BD[index + 1])) {
      if(isDefined(_id_1B3D1C2F22B62206)) {
        [[_id_1B3D1C2F22B62206]](agent);
        continue;
      }

      agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, _id_21F24AECB313E479, _id_E298CEC41261345C, _id_C5E7FCE963586EC0);
    }
  }
}

_id_BD1C3703FC1E9FF7() {
  result = scripts\engine\utility::waittill_any_return_2("continue", "terminated");

  if(result == "continue")
    self.state = "pop_doors_open";
  else if(result == "terminated")
    _id_5C118165D3E98A42::_id_1526944EF1762358();
}

_id_EC009A967D1D5EB9() {
  _id_DB76C4BB596D090E = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D connectpaths();
  _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D.origin = _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D.origin + (0, 0, 2000);
  _id_DB76C4BB596D090E thread _id_5C118165D3E98A42::_id_88C392696FD02DC4();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "open");
  doors = _id_DB76C4BB596D090E.doors;

  foreach(door in doors) {
    if(isDefined(door._id_9932BF8D872AEC43))
      door._id_9932BF8D872AEC43.origin = door.clip._id_C2FAC7A209524732;
  }

  wait 3;
  _id_3D5F0A2BBD7C908C = 1;
  _id_6B1DA470FCEE5528 = 0;
  self._id_3D2410757012B419 = [];

  for(self._id_7A27C9558344447A = []; _id_3D5F0A2BBD7C908C; _id_6B1DA470FCEE5528 = _id_6B1DA470FCEE5528 + 0.2) {
    _id_3D5F0A2BBD7C908C = isDefined(_id_DD00B8133E41DB1C(_id_DB76C4BB596D090E));

    if(!_id_3D5F0A2BBD7C908C) {
      _id_D0F6F9E250EB7CA4();
      break;
    } else
      _id_30D8131DC6519A0A(_id_DB76C4BB596D090E);

    if(_id_6B1DA470FCEE5528 >= getdvarint("dvar_934907C8F7ADD660", 30)) {
      agentarray = getaiarrayinradius(_id_DB76C4BB596D090E.origin, 250);

      foreach(agent in agentarray) {
        if(isalive(agent) && agent istouching(_id_DB76C4BB596D090E._id_90DABE3606074803)) {
          _id_95F125B69BD6E39E = getclosestpointonnavmesh(self._id_C5E7FCE963586EC0);
          agent._id_A417FDCE20C4D0D7 = _id_95F125B69BD6E39E;
          agent._id_01339FF53060F729 = agent.goalpos;
        }
      }

      break;
    }

    wait 0.2;
  }

  self.state = "pop_doors_closing";
}

_id_8B680B3EF155FC34() {
  _id_DB76C4BB596D090E = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  _id_4B1E414172FEC3A8 = _id_DB76C4BB596D090E._id_0E4118BDA122B112;
  _id_DB76C4BB596D090E thread _id_5C118165D3E98A42::_id_D32C693D3A04F8F8();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "close");
  _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D.origin = _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D.origin + (0, 0, -2000);
  _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D disconnectPaths();
  doors = _id_DB76C4BB596D090E.doors;

  foreach(door in doors) {
    if(isDefined(door._id_9932BF8D872AEC43))
      door._id_9932BF8D872AEC43.origin = door.clip._id_F16D407674809F11;
  }

  wait 1;
  agentarray = getaiarrayinradius(_id_DB76C4BB596D090E.origin, 250);

  foreach(agent in agentarray) {
    if(isalive(agent)) {
      _id_8BDB743B1288E020 = (agent.origin[0], agent.origin[1], agent.origin[2] + 50);

      if(ispointinvolume(_id_8BDB743B1288E020, _id_DB76C4BB596D090E._id_0907E66D3BF42C5A))
        self._id_7A27C9558344447A[self._id_7A27C9558344447A.size] = agent;
    }
  }

  if(self._id_7A27C9558344447A.size > 0) {
    logstring("=============== Kill agents in Elevator===============");

    if(!isDefined(self._id_EA3E3B2121E6713A))
      self._id_EA3E3B2121E6713A = "Reinforcement pop";

    logstring("Event notification: " + self._id_EA3E3B2121E6713A);
    logstring("Elevator Id: " + self.id);
    logstring("Elevator Front Position: " + _id_DB76C4BB596D090E._id_BD440A13487263EF);

    foreach(agent in self._id_7A27C9558344447A) {
      _id_08EB298B7C41C360 = "[ Kill agent ] Orign: " + agent.origin + " agent_type: " + agent.agent_type;

      if(isDefined(agent._id_A417FDCE20C4D0D7))
        _id_08EB298B7C41C360 = _id_08EB298B7C41C360 + " NavAdjustedCombatRushOrigin: " + agent._id_A417FDCE20C4D0D7;
      else {
        _id_95F125B69BD6E39E = getclosestpointonnavmesh(self._id_C5E7FCE963586EC0);
        _id_08EB298B7C41C360 = _id_08EB298B7C41C360 + "NavAdjustedCombatRushOrigin: " + _id_95F125B69BD6E39E;
      }

      if(isDefined(agent._id_01339FF53060F729))
        _id_08EB298B7C41C360 = _id_08EB298B7C41C360 + " GoalPos: " + agent._id_01339FF53060F729;
      else
        _id_08EB298B7C41C360 = _id_08EB298B7C41C360 + " GoalPos: " + agent.goalpos;

      logstring(_id_08EB298B7C41C360);
      agent setOrigin((agent.origin[0], agent.origin[1], -2000));
    }

    waitframe();

    foreach(agent in self._id_7A27C9558344447A)
    agent kill();

    logstring("=============== Kill agents in Elevator End ===============");
  }

  _id_4B1E414172FEC3A8 setscriptablepartstate("model", "off", 0);
  _id_5C118165D3E98A42::_id_1526944EF1762358();
}

_id_30D8131DC6519A0A(_id_C8F6F1542970369C) {
  foreach(player in level.players) {
    if(isalive(player)) {
      if(distancesquared(player.origin, _id_C8F6F1542970369C.doors[0].clip.origin) < 10000) {
        if(!scripts\engine\utility::array_contains(self._id_3D2410757012B419, player)) {
          player scripts\mp\utility\lower_message::setlowermessageomnvar("br_dmz_biolab_reinforcement_door");
          self._id_3D2410757012B419[self._id_3D2410757012B419.size] = player;
        }

        continue;
      }

      if(scripts\engine\utility::array_contains(self._id_3D2410757012B419, player)) {
        player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
        self._id_3D2410757012B419 = scripts\engine\utility::array_remove(self._id_3D2410757012B419, player);
      }
    }
  }
}

_id_D0F6F9E250EB7CA4() {
  foreach(player in self._id_3D2410757012B419) {
    if(isalive(player))
      player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }
}

_id_DD00B8133E41DB1C(_id_C8F6F1542970369C) {
  _id_DA96C8943126A950 = getaiarrayinradius(_id_C8F6F1542970369C.origin, 250);

  foreach(ai in _id_DA96C8943126A950) {
    if(!isalive(ai)) {
      continue;
    }
    if(ai.agent_type == "actor_enemy_mp_boss_velikan")
      return ai;
    else if(ai istouching(_id_C8F6F1542970369C._id_90DABE3606074803))
      return ai;
  }

  return undefined;
}