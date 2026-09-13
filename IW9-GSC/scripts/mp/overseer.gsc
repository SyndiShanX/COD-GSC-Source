/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\overseer.gsc
***********************************************/

_id_495DEC0762963ABD() {
  waitframe();

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  level._id_187C351A4CBE3E54 = spawnStruct();
  _id_72A66B9A0E0BC9C1();
  setdvarifuninitialized("dvar_451B4B1E40B7B2AE", 2);
  setdvarifuninitialized("dvar_C32B050CF4DBED9C", 5);
  _id_5B8657687ECB9E05();
  level waittill("matchStartTimer_done");
  waitframe();
  _id_61672DEE45F8A3A4();
  level thread _id_0BDC80D6CBBC555B();
  level thread _id_279F529842440558();
  _id_368FB9A36D82922C();
}

_id_72A66B9A0E0BC9C1() {
  level._id_187C351A4CBE3E54._id_B205D90302DA2F07 = [];

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44] = spawnStruct();
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5C3A2C7E48245EC9 = 0;
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44].name = _id_171F90B9C4C76D44;
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91 = [];
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_96766B0A5B7ABB48 = 0;
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA = [];
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_560A32AF852A939A = [];
    level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_D11BD6B29C98FC93 = 0;
  }
}

_id_5B8657687ECB9E05() {
  level._id_F08F725BB388BB59 = [];

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 0, 1, 5, undefined);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 0, 2, 10, ::_id_6035ACAB211520A8);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 0, 4, 0, ::_id_5E713676FFAB769B);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 0, 3, 0, ::_id_B9B723D97E9A9A7D);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 0, 5, 0, ::_id_AB3CC3354D465BA9);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 2, 1, 5, undefined);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 2, 2, 10, ::_id_6035ACAB211520A8);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 2, 4, 0, ::_id_5E713676FFAB769B);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 2, 3, 0, ::_id_B9B723D97E9A9A7D);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 2, 5, 0, ::_id_AB3CC3354D465BA9);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 3, 1, 5, undefined);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 3, 2, 10, ::_id_6035ACAB211520A8);
    _id_F06AD65298F474D6(_id_171F90B9C4C76D44, 3, 5, 0, ::_id_AB3CC3354D465BA9);
  }
}

_id_368FB9A36D82922C() {
  foreach(_id_DC1BFDF5C034420E in level._id_187C351A4CBE3E54._id_B205D90302DA2F07)
  _id_DC1BFDF5C034420E thread _id_2F4609F4EC521515();
}

_id_61672DEE45F8A3A4() {
  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    player._id_B17BF051E1D12378 = [];

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      player._id_B17BF051E1D12378[_id_171F90B9C4C76D44] = spawnStruct();
      player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C = [];
      player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91 = [];
      player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_1CF979F3574333C7 = [];
    }
  }
}

_id_F06AD65298F474D6(_id_171F90B9C4C76D44, _id_D73C9918509F8D36, _id_BEEA5B6FFEFAADE1, weight, eventcallback) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(_id_D73C9918509F8D36) || !isDefined(_id_BEEA5B6FFEFAADE1) || !isDefined(weight)) {
    return;
  }
  if(!isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44]))
    level._id_F08F725BB388BB59[_id_171F90B9C4C76D44] = [];

  if(!isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36]))
    level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36] = [];

  level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][_id_BEEA5B6FFEFAADE1] = spawnStruct();
  level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][_id_BEEA5B6FFEFAADE1].weight = weight;
  level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][_id_BEEA5B6FFEFAADE1].event = eventcallback;

  if(!isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][0]))
    level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][0] = 0;

  level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][0] = level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][_id_D73C9918509F8D36][0] + weight;
}

_id_A009C03ABF1D0190(_id_B9DBB989C5B6AB51, _id_171F90B9C4C76D44, _id_D73C9918509F8D36, _id_BEEA5B6FFEFAADE1) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(_id_D73C9918509F8D36) || !isDefined(_id_BEEA5B6FFEFAADE1) || !isDefined(_id_B9DBB989C5B6AB51)) {
    return;
  }
  if(!_id_25E955B1FBB05FD2(_id_171F90B9C4C76D44, _id_D73C9918509F8D36, _id_BEEA5B6FFEFAADE1)) {
    return;
  }
  _id_0BDB0C712066B523 = _id_D73C9918509F8D36;

  if(!isarray(_id_0BDB0C712066B523)) {
    _id_0BDB0C712066B523 = [];
    _id_0BDB0C712066B523[_id_0BDB0C712066B523.size] = _id_D73C9918509F8D36;
  }

  foreach(state in _id_0BDB0C712066B523) {
    if(!isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state])) {
      continue;
    }
    _id_D33CEDBC4B0C84E2 = _id_B9DBB989C5B6AB51 - level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state][_id_BEEA5B6FFEFAADE1].weight;
    level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state][0] = level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state][0] + _id_D33CEDBC4B0C84E2;
    level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state][_id_BEEA5B6FFEFAADE1].weight = _id_B9DBB989C5B6AB51;
  }
}

_id_25E955B1FBB05FD2(_id_171F90B9C4C76D44, _id_D73C9918509F8D36, _id_BEEA5B6FFEFAADE1) {
  if(!isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44]))
    return 0;

  _id_0BDB0C712066B523 = _id_D73C9918509F8D36;

  if(!isarray(_id_0BDB0C712066B523)) {
    _id_0BDB0C712066B523 = [];
    _id_0BDB0C712066B523[_id_0BDB0C712066B523.size] = _id_D73C9918509F8D36;
  }

  foreach(state in _id_0BDB0C712066B523) {
    if(isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state]) && isDefined(level._id_F08F725BB388BB59[_id_171F90B9C4C76D44][state][_id_BEEA5B6FFEFAADE1]))
      return 1;
  }

  return 0;
}

_id_DF475631E402735A() {
  return isDefined(level._id_187C351A4CBE3E54);
}

_id_17A6FD602315C59B(_id_7BFFED7C5E9294D7, _id_171F90B9C4C76D44) {
  if(!isDefined(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_1CF979F3574333C7[_id_7BFFED7C5E9294D7]))
    return 0;

  if(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_1CF979F3574333C7[_id_7BFFED7C5E9294D7] <= gettime())
    return 0;

  return 1;
}

_id_0EDB852B69FF7126(eventname) {
  switch (eventname) {
    case "check_in":
      return 1;
    case "reinforce_agent":
      return self._id_FE5EBEFA740C7106 != 3 && self._id_FE5EBEFA740C7106 != 2;
    default:
      return 1;
  }
}

_id_D566BF9405D7D49A(_id_7BFFED7C5E9294D7) {
  if(!isDefined(self._id_60A5413E150F62FD))
    return 0;

  if(!isDefined(_id_7BFFED7C5E9294D7))
    return 0;

  if(!isDefined(self._id_60A5413E150F62FD[_id_7BFFED7C5E9294D7]))
    return 0;

  return self._id_60A5413E150F62FD[_id_7BFFED7C5E9294D7] >= gettime();
}

_id_DBAE416BD663B441(_id_7BFFED7C5E9294D7, cooldowntime) {
  if(!isDefined(self._id_60A5413E150F62FD))
    self._id_60A5413E150F62FD = [];

  self._id_60A5413E150F62FD[_id_7BFFED7C5E9294D7] = gettime() + cooldowntime * 1000;
}

_id_BA07B47FA2BC7C1E(_id_646389193279E8EC, origin) {
  if(!isDefined(self.entitynumber))
    return 0;

  if(isDefined(_id_646389193279E8EC[self.entitynumber]))
    return 0;

  if(isDefined(self._id_B600C3754EB17F27) && self._id_B600C3754EB17F27 + 120000 <= gettime())
    return 0;

  if(!isDefined(self.origin) || !isDefined(origin))
    return 0;

  if(distancesquared(origin, self.origin) > 2250000)
    return 0;

  return 1;
}

_id_251A5FBCD306BA20(origin, radius, _id_646389193279E8EC, _id_171F90B9C4C76D44) {
  _id_7E07BDBDA1B67800 = scripts\mp\utility\player::getplayersinradius(origin, radius, "team_hundred_ninety_five");
  _id_7E07BDBDA1B67800 = scripts\engine\utility::array_randomize(_id_7E07BDBDA1B67800);
  _id_2A325306F9EBDD9D = scripts\mp\utility\player::getplayersinradius(origin, 2000, "team_hundred_ninety_five", _id_7E07BDBDA1B67800);
  _id_2A325306F9EBDD9D = scripts\engine\utility::array_randomize(_id_2A325306F9EBDD9D);
  _id_4F0D82757E9E4E91 = [];

  foreach(agent in level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91) {
    if(agent _id_BA07B47FA2BC7C1E(_id_646389193279E8EC, origin))
      _id_4F0D82757E9E4E91[agent.entitynumber] = agent;
  }

  _id_4F0D82757E9E4E91 = scripts\engine\utility::array_randomize(_id_4F0D82757E9E4E91);
  _id_8A10C39962F6D9FD = _id_7E07BDBDA1B67800.size;
  _id_9CC5BE111B6FA65C = scripts\engine\utility::array_combine(_id_7E07BDBDA1B67800, _id_2A325306F9EBDD9D);
  return [_id_9CC5BE111B6FA65C, _id_4F0D82757E9E4E91, _id_8A10C39962F6D9FD];
}

_id_63F2ED030151AA07(_id_BBA978AAB35DB160, _id_7BFFED7C5E9294D7, cooldowntime, _id_171F90B9C4C76D44) {
  players = scripts\mp\utility\player::getplayersinradius(_id_BBA978AAB35DB160, level._id_587DE0E7B537210A);

  if(!isDefined(players)) {
    return;
  }
  if(!isarray(players) && !isai(players))
    players = [players];

  foreach(player in players) {
    if(isai(player) || isbot(player) || !isDefined(player._id_B17BF051E1D12378) || !isDefined(player._id_B17BF051E1D12378[_id_171F90B9C4C76D44])) {
      continue;
    }
    player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_1CF979F3574333C7[_id_7BFFED7C5E9294D7] = gettime() + cooldowntime * 1000;
  }
}

_id_3AACEA8B6BB13D1A(_id_171F90B9C4C76D44, _id_9B1941CB7354665E) {
  switch (_id_9B1941CB7354665E) {
    case 1:
    case 0:
      thread _id_2F4609F4EC521515();
      break;
    case 3:
    case 2:
      thread _id_1682CB99475B8428();
      break;
    case 4:
    default:
      break;
  }
}

_id_32226D6944572EBD(_id_171F90B9C4C76D44) {
  return level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_5C3A2C7E48245EC9;
}

_id_B39E752EF737042B(_id_171F90B9C4C76D44) {
  return level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_324D53D23A396904._id_FE5EBEFA740C7106;
}

_id_ACAF43595C74730B(state, _id_CB7D9ED4FDE5CB25, _id_E413BDA00C8CB0F3, _id_ACC07047BA207170) {
  if(!isDefined(state))
    return undefined;

  if(_id_ACC07047BA207170)
    _id_927B3199642B75FC = _id_C5A3E4813279AF45();

  _id_927B3199642B75FC = undefined;

  switch (state) {
    case 4:
    case 0:
      _id_927B3199642B75FC = _id_5175A8D4AB6F95F9(_id_E413BDA00C8CB0F3, _id_CB7D9ED4FDE5CB25);
      break;
    case 2:
    case 1:
      _id_927B3199642B75FC = _id_D65F7EC4946CB258();
      break;
    case 3:
      _id_927B3199642B75FC = _id_5533255FD4FBF6E3();
      break;
    default:
      break;
  }

  return _id_927B3199642B75FC;
}

_id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, _id_329FB2E25CDD169F, eventname) {
  if(!isDefined(_id_171F90B9C4C76D44) || !isDefined(_id_329FB2E25CDD169F) || !isDefined(eventname))
    return 0;

  if(!isalive(self))
    return 0;

  if(isbot(self))
    return 0;

  if(!isDefined(self._id_B17BF051E1D12378))
    return 0;

  if(!isDefined(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]))
    return 0;

  switch (_id_329FB2E25CDD169F) {
    case "alive":
      if(!isDefined(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C))
        return 0;

      if(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C.size == 0)
        return 0;

      foreach(agent in self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C) {
        if(agent _id_0EDB852B69FF7126(eventname) && !agent _id_D566BF9405D7D49A(eventname))
          return 1;
      }

      return 0;
    case "dead":
      return isDefined(self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91) && self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91.size != 0;
    case "dead_contacted":
      return isDefined(level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA) && level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA.size != 0;
    default:
      return 0;
  }
}

_id_555A2CDF4916950D(_id_329FB2E25CDD169F, _id_171F90B9C4C76D44, eventname) {
  if(!isDefined(_id_329FB2E25CDD169F))
    return [undefined, 0];

  agentarray = [];

  switch (_id_329FB2E25CDD169F) {
    case "alive":
      agentarray = self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C;
      break;
    case "dead":
      agentarray = self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91;
    default:
      break;
  }

  foreach(index, agent in agentarray) {
    if(!agent _id_D566BF9405D7D49A(eventname)) {
      if(_id_329FB2E25CDD169F == "alive" && !isalive(agent)) {
        continue;
      }
      if(index < self._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_FE505256BDDED6F2)
        return [agent, 0];
      else
        return [agent, 1];
    }
  }

  return [undefined, 0];
}

_id_F65532FC657A4301(_id_A46D287F39A98D69) {
  level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_A46D287F39A98D69._id_B205D90302DA2F07]._id_4F0D82757E9E4E91[_id_A46D287F39A98D69.entitynumber] = _id_A46D287F39A98D69;
  level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_A46D287F39A98D69._id_B205D90302DA2F07]._id_96766B0A5B7ABB48++;
}

_id_30C7AC6784554174(_id_927B3199642B75FC, waittime, priority) {
  self notify("oversser_chatter_quedued");
  self endon("oversser_chatter_quedued");
  self endon("death");
  wait(waittime);
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("investigate", _id_927B3199642B75FC, priority);
}

_id_1F276CA53768BFA9(_id_A5ADF7CA3DDC0CFD, _id_6794F7417ED0B5A2) {
  _id_B5517D24E9DC9A49 = "aqs" + scripts\engine\utility::string(_id_6794F7417ED0B5A2) + "_";
  countryid = "aqs";
  _id_F75BA7B0D6A4B1CB = strtok(_id_A5ADF7CA3DDC0CFD, "_");
  alias = "";

  switch (_id_F75BA7B0D6A4B1CB.size) {
    case 3:
      alias = "dx_bc_" + tolower(countryid) + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_F75BA7B0D6A4B1CB[1] + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[2];
      break;
    case 2:
      alias = "dx_bc_" + tolower(countryid) + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[1];
      break;
    case 1:
      alias = "dx_bc_" + tolower(countryid) + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[0];
      break;
    default:
      break;
  }

  return alias;
}

_id_67E64472BE618168(_id_A5ADF7CA3DDC0CFD, _id_6794F7417ED0B5A2) {
  _id_B5517D24E9DC9A49 = "aqs1_";
  countryid = "aqld";
  _id_F75BA7B0D6A4B1CB = strtok(_id_A5ADF7CA3DDC0CFD, "_");
  alias = "";

  switch (_id_F75BA7B0D6A4B1CB.size) {
    case 3:
      alias = "dx_bc_" + tolower(countryid) + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_F75BA7B0D6A4B1CB[1] + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[2];
      break;
    case 2:
      alias = "dx_bc_" + tolower(countryid) + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[1];
      break;
    case 1:
      alias = "dx_bc_" + tolower(countryid) + "_" + _id_B5517D24E9DC9A49 + _id_F75BA7B0D6A4B1CB[0];
      break;
    default:
      break;
  }

  alias = _id_5D265B4FCA61F070::get_radio_alias(alias);
  return alias;
}

_id_92BACB96846CBA62(alias, _id_6794F7417ED0B5A2) {
  self playsoundonmovingent(alias);
  return undefined;
}

_id_EA67555D03337205(alias, _id_6794F7417ED0B5A2) {
  self stopsounds();
  return undefined;
}

_id_C26B1E049DB4D841(_id_927B3199642B75FC) {
  self notify("overseer_chatter");
  self endon("overseer_chatter");
  self endon("death");
  _id_BD670C1E0F4290DA = undefined;
  _id_6794F7417ED0B5A2 = randomintrange(1, 4);

  foreach(index, item in _id_927B3199642B75FC) {
    if(isDefined(_id_BD670C1E0F4290DA)) {
      self thread[[level._id_9A62261B5B534B06]](_id_BD670C1E0F4290DA);
      _id_BD670C1E0F4290DA = undefined;
      waitframe();
      self waittill("dialogue_done");
    }

    if(isnumber(item))
      wait(item);

    if(isfunction(item))
      _id_BD670C1E0F4290DA = self[[item]](_id_927B3199642B75FC[index + 1], _id_6794F7417ED0B5A2);
  }
}

_id_2F4609F4EC521515() {
  self notify("changed_state");
  level endon("game_ended");
  self endon("changed_state");
  self._id_5C3A2C7E48245EC9 = 0;

  for(;;) {
    _id_D4B9E030F49735D5 = level._id_F08F725BB388BB59[self.name][0][0];
    _id_7E1B02C65B1197C8 = randomint(_id_D4B9E030F49735D5) + 1;
    func = undefined;
    _id_DB9267D0D9167FD8 = 0;

    foreach(_id_BEEA5B6FFEFAADE1, data in level._id_F08F725BB388BB59[self.name][0]) {
      if(_id_BEEA5B6FFEFAADE1 == 0) {
        continue;
      }
      _id_DB9267D0D9167FD8 = _id_DB9267D0D9167FD8 + data.weight;

      if(_id_DB9267D0D9167FD8 >= _id_7E1B02C65B1197C8) {
        func = data.event;
        break;
      }
    }

    if(isDefined(func) && isfunction(func))
      self[[func]](self.name);

    wait(self._id_D11BD6B29C98FC93 + randomintrange(getdvarint("dvar_451B4B1E40B7B2AE"), getdvarint("dvar_C32B050CF4DBED9C")));
  }
}

_id_1682CB99475B8428() {
  self notify("changed_state");
  level endon("game_ended");
  self endon("changed_state");
  self._id_5C3A2C7E48245EC9 = 2;

  for(;;) {
    _id_D4B9E030F49735D5 = level._id_F08F725BB388BB59[self.name][2][0];
    _id_7E1B02C65B1197C8 = randomint(_id_D4B9E030F49735D5) + 1;
    func = undefined;
    _id_DB9267D0D9167FD8 = 0;

    foreach(_id_BEEA5B6FFEFAADE1, data in level._id_F08F725BB388BB59[self.name][2]) {
      if(_id_BEEA5B6FFEFAADE1 == 0) {
        continue;
      }
      _id_DB9267D0D9167FD8 = _id_DB9267D0D9167FD8 + data.weight;

      if(_id_DB9267D0D9167FD8 >= _id_7E1B02C65B1197C8) {
        func = data.event;
        break;
      }
    }

    if(isDefined(func) && isfunction(func))
      self[[func]](self.name);

    wait(self._id_D11BD6B29C98FC93 + randomintrange(getdvarint("dvar_451B4B1E40B7B2AE"), getdvarint("dvar_C32B050CF4DBED9C")));
  }
}

_id_6035ACAB211520A8(_id_171F90B9C4C76D44) {
  if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size == 0) {
    return;
  }
  _id_00DEB2FBB32E4132 = 0;

  foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
    if(!player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "alive", "check_in") || player _id_17A6FD602315C59B("check_in", _id_171F90B9C4C76D44)) {
      continue;
    }
    [_id_E413BDA00C8CB0F3, _id_ACC07047BA207170] = player _id_555A2CDF4916950D("alive", _id_171F90B9C4C76D44, "check_in");

    if(!isDefined(_id_E413BDA00C8CB0F3) || !isDefined(_id_ACC07047BA207170)) {
      continue;
    }
    _id_00DEB2FBB32E4132 = 1;
    _id_927B3199642B75FC = _id_ACAF43595C74730B(self._id_5C3A2C7E48245EC9, undefined, _id_E413BDA00C8CB0F3, _id_ACC07047BA207170);

    if(_id_ACC07047BA207170) {
      _id_CF7F716E388D5067 = _id_EF9999B04345F5D4();
      _id_E413BDA00C8CB0F3 playsoundonmovingent(_id_CF7F716E388D5067);
    } else
      _id_E413BDA00C8CB0F3 thread _id_C26B1E049DB4D841(_id_927B3199642B75FC);

    _id_63F2ED030151AA07(_id_E413BDA00C8CB0F3.origin, "check_in", 30, _id_171F90B9C4C76D44);
    _id_E413BDA00C8CB0F3 _id_DBAE416BD663B441("check_in", 120);
  }

  if(_id_00DEB2FBB32E4132)
    self._id_D11BD6B29C98FC93 = 10;
}

_id_B9B723D97E9A9A7D(_id_171F90B9C4C76D44) {
  if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size == 0) {
    return;
  }
  _id_00DEB2FBB32E4132 = 0;
  _id_6F2742EC8C61B8D8 = 1;
  _id_CED51C14E5171EC4 = [];

  foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
    if(!player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "dead") || player _id_17A6FD602315C59B("dead_agent_contacted", _id_171F90B9C4C76D44)) {
      continue;
    }
    [_id_E413BDA00C8CB0F3, _id_ACC07047BA207170] = player _id_555A2CDF4916950D("dead", _id_171F90B9C4C76D44, "check_in");

    if(!isDefined(_id_E413BDA00C8CB0F3)) {
      continue;
    }
    _id_00DEB2FBB32E4132 = 1;
    _id_7E1B02C65B1197C8 = min(100, level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_96766B0A5B7ABB48 * 10);
    ignore = scripts\engine\utility::_id_51D76700600CEBE3(_id_7E1B02C65B1197C8);
    _id_E413BDA00C8CB0F3 notify("radio_spam");
    _id_CED51C14E5171EC4[_id_CED51C14E5171EC4.size] = _id_E413BDA00C8CB0F3;

    if(!ignore) {
      level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA[_id_E413BDA00C8CB0F3.entitynumber] = undefined;
      _id_48814951E916AF89::_id_3DAEFB936272829F(_id_171F90B9C4C76D44, _id_E413BDA00C8CB0F3.origin);
      _id_927B3199642B75FC = _id_B19E15D68738642B();
      _id_6F2742EC8C61B8D8 = 0;
    } else
      _id_927B3199642B75FC = _id_0E8391F9BF6B9AED();

    _id_E413BDA00C8CB0F3 thread _id_C26B1E049DB4D841(_id_927B3199642B75FC);
    _id_63F2ED030151AA07(_id_E413BDA00C8CB0F3.origin, "dead_agent_contacted", 120, _id_171F90B9C4C76D44);
    _id_E413BDA00C8CB0F3 _id_DBAE416BD663B441("check_in", 120);
  }

  if(_id_00DEB2FBB32E4132) {
    if(!_id_6F2742EC8C61B8D8) {
      _id_A009C03ABF1D0190(0, _id_171F90B9C4C76D44, [0, 2], 3);
      _id_A009C03ABF1D0190(10, _id_171F90B9C4C76D44, [2], 4);
    }

    self._id_D11BD6B29C98FC93 = 0;
    wait 20;

    foreach(agent in _id_CED51C14E5171EC4)
    thread _id_FC9A15646315764C(agent);

    if(!_id_6F2742EC8C61B8D8)
      _id_3AACEA8B6BB13D1A(_id_171F90B9C4C76D44, 2);
  }
}

_id_5E713676FFAB769B(_id_171F90B9C4C76D44) {
  if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size == 0) {
    return;
  }
  _id_17FDC82450AAB9E3 = [];
  _id_00DEB2FBB32E4132 = 0;

  foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
    if(!player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "alive", "reinforce_agent") || !player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "dead_contacted") || player _id_17A6FD602315C59B("reinforce_agent", _id_171F90B9C4C76D44)) {
      continue;
    }
    [_id_E413BDA00C8CB0F3, _id_ACC07047BA207170] = player _id_555A2CDF4916950D("alive", _id_171F90B9C4C76D44, "reinforce_agent");

    if(!isDefined(_id_E413BDA00C8CB0F3)) {
      continue;
    }
    _id_00DEB2FBB32E4132 = 1;
    _id_927B3199642B75FC = _id_E84132896F105965(_id_E413BDA00C8CB0F3, undefined);
    _id_E413BDA00C8CB0F3 thread _id_C26B1E049DB4D841(_id_927B3199642B75FC);
    _id_17FDC82450AAB9E3[_id_E413BDA00C8CB0F3 getentitynumber()] = spawnStruct();
    _id_17FDC82450AAB9E3[_id_E413BDA00C8CB0F3 getentitynumber()]._id_88645F30685A5058 = scripts\engine\utility::random(level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA);
    _id_17FDC82450AAB9E3[_id_E413BDA00C8CB0F3 getentitynumber()].agent = _id_E413BDA00C8CB0F3;
    _id_63F2ED030151AA07(_id_E413BDA00C8CB0F3.origin, "reinforce_agent", 120, _id_171F90B9C4C76D44);
  }

  if(_id_00DEB2FBB32E4132) {
    _id_A009C03ABF1D0190(0, _id_171F90B9C4C76D44, 2, 4);
    self._id_D11BD6B29C98FC93 = 0;
    wait 10;

    foreach(_id_30885FE6C65240B8 in _id_17FDC82450AAB9E3) {
      origin = getclosestpointonnavmesh(_id_30885FE6C65240B8._id_88645F30685A5058.origin + (randomfloatrange(-256.0, 256.0), randomfloatrange(-256.0, 256.0), 0));
      _id_30885FE6C65240B8.agent thread _id_120270BD0A747A35::_id_A5117518725DA028(_id_30885FE6C65240B8.agent, origin);
      level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_324D53D23A396904 = _id_30885FE6C65240B8.agent;
      level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_86E45DBD699CC9FA[_id_30885FE6C65240B8._id_88645F30685A5058.entitynumber] = undefined;
      level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_96766B0A5B7ABB48 = 0;
      level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_560A32AF852A939A[_id_30885FE6C65240B8._id_88645F30685A5058.entitynumber] = _id_30885FE6C65240B8._id_88645F30685A5058;
    }
  }
}

_id_AB3CC3354D465BA9(_id_171F90B9C4C76D44) {
  if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size == 0) {
    return;
  }
  _id_00DEB2FBB32E4132 = 0;

  foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
    if(!player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "alive", "outside_reinforce") || player _id_17A6FD602315C59B("outside_reinforce", _id_171F90B9C4C76D44)) {
      continue;
    }
    [_id_E413BDA00C8CB0F3, _id_ACC07047BA207170] = player _id_555A2CDF4916950D("alive", _id_171F90B9C4C76D44, "outside_reinforce");

    if(!isDefined(_id_E413BDA00C8CB0F3)) {
      continue;
    }
    _id_00DEB2FBB32E4132 = 1;
    _id_927B3199642B75FC = _id_1000F4A1C18A2766(_id_E413BDA00C8CB0F3);
    _id_E413BDA00C8CB0F3 thread _id_C26B1E049DB4D841(_id_927B3199642B75FC);
    _id_63F2ED030151AA07(_id_E413BDA00C8CB0F3.origin, "outside_reinforce", 120, _id_171F90B9C4C76D44);
    _id_E413BDA00C8CB0F3 _id_DBAE416BD663B441("outside_reinforce", 120);
  }

  if(_id_00DEB2FBB32E4132) {
    _id_A009C03ABF1D0190(0, _id_171F90B9C4C76D44, [0, 2], 4);
    self._id_D11BD6B29C98FC93 = 10;
  }
}

_id_0BDC80D6CBBC555B() {
  level endon("game_ended");

  for(;;) {
    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])) {
        continue;
      }
      foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
        if(!isDefined(player._id_B17BF051E1D12378) || !isalive(player) || !isDefined(player.origin) || isbot(player)) {
          continue;
        }
        _id_646389193279E8EC = level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_560A32AF852A939A;
        [_id_9CC5BE111B6FA65C, _id_4F0D82757E9E4E91, _id_FE505256BDDED6F2] = _id_251A5FBCD306BA20(player.origin, 1500, _id_646389193279E8EC, _id_171F90B9C4C76D44);
        player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_9CC5BE111B6FA65C = _id_9CC5BE111B6FA65C;
        player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_FE505256BDDED6F2 = _id_FE505256BDDED6F2;
        player._id_B17BF051E1D12378[_id_171F90B9C4C76D44]._id_4F0D82757E9E4E91 = _id_4F0D82757E9E4E91;

        if(player _id_0A79B8410BFCB03A(_id_171F90B9C4C76D44, "dead"))
          _id_A009C03ABF1D0190(level._id_187C351A4CBE3E54._id_B205D90302DA2F07[_id_171F90B9C4C76D44]._id_96766B0A5B7ABB48, _id_171F90B9C4C76D44, [0, 2], 3);
      }
    }

    wait 5;
  }
}

_id_279F529842440558() {
  level endon("game_ended");

  for(;;) {
    foreach(_id_DC1BFDF5C034420E in level._id_187C351A4CBE3E54._id_B205D90302DA2F07) {
      if(!isDefined(_id_DC1BFDF5C034420E._id_324D53D23A396904)) {
        continue;
      }
      _id_329FB2E25CDD169F = _id_B39E752EF737042B(_id_DC1BFDF5C034420E.name);

      if(_id_32226D6944572EBD(_id_DC1BFDF5C034420E.name) != _id_329FB2E25CDD169F && _id_329FB2E25CDD169F != 4)
        _id_DC1BFDF5C034420E _id_3AACEA8B6BB13D1A(_id_DC1BFDF5C034420E.name, _id_329FB2E25CDD169F);
    }

    wait 1;
  }
}

_id_D2C0773F378A239A() {
  alias = [];
  alias[alias.size] = "s_idnm_safi";
  alias[alias.size] = "s_idnm_abbasi";
  alias[alias.size] = "s_idnm_kinan";
  alias[alias.size] = "s_idnm_hamed";
  alias[alias.size] = "s_idnm_hadi";
  alias[alias.size] = "s_idnm_waseem";
  alias[alias.size] = "s_idnm_abuelbaz";
  alias[alias.size] = "s_idnm_beshara";
  alias[alias.size] = "s_idnm_kamal";
  alias[alias.size] = "s_idnm_abujamil";
  alias[alias.size] = "s_idnm_jabour";
  alias[alias.size] = "s_idnm_yaser";
  alias[alias.size] = "s_idnm_fayad";
  alias[alias.size] = "s_idnm_daoud";
  alias[alias.size] = "s_idnm_laham";
  alias[alias.size] = "s_idnm_abunazar";
  alias[alias.size] = "s_idnm_abuodeh";
  alias[alias.size] = "s_idnm_amran";
  alias[alias.size] = "s_idnm_basr";
  alias[alias.size] = "s_idnm_karam";
  alias[alias.size] = "s_idnm_brother";
  return scripts\engine\utility::random(alias);
}

_id_F2F1A8B4044EF6E9() {
  alias = [];
  alias[alias.size] = "s_idrr_nothinghere";
  alias[alias.size] = "s_idrr_allclear";
  alias[alias.size] = "s_idrr_weregoodbrother";
  alias[alias.size] = "s_idrr_goodhere";
  alias[alias.size] = "s_idrr_quietherebrother";
  return scripts\engine\utility::random(alias);
}

_id_473352D13A0ABBD9() {
  alias = [];
  alias[alias.size] = "s_idlc_roger";
  alias[alias.size] = "s_idlc_copy";
  alias[alias.size] = "s_idlc_copythat";
  return scripts\engine\utility::random(alias);
}

_id_5175A8D4AB6F95F9(_id_E413BDA00C8CB0F3, _id_CB7D9ED4FDE5CB25) {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_F2F1A8B4044EF6E9();
  _id_0F04627E8327A207 = _id_473352D13A0ABBD9();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 2, ::_id_1F276CA53768BFA9, _id_D879231278CE8E83, 2, ::_id_67E64472BE618168, _id_0F04627E8327A207];
  return _id_927B3199642B75FC;
}

_id_6CAB75076EC4334E() {
  alias = [];
  alias[alias.size] = "s_idli_areyouokaybrother";
  alias[alias.size] = "s_idli_areyouthere";
  alias[alias.size] = "s_idli_wheredyougo";
  alias[alias.size] = "s_idli_canyouhearme";
  return scripts\engine\utility::random(alias);
}

_id_8EE10B8E4567C2A1() {
  alias = [];
  alias[alias.size] = "s_comm_ret0";
  alias[alias.size] = "s_comm_reo0";
  return scripts\engine\utility::random(alias);
}

_id_7EB00C3F02C593D0() {
  alias = [];
  alias[alias.size] = "s_misc_con0";
  alias[alias.size] = "s_misc_con2";
  return scripts\engine\utility::random(alias);
}

_id_B19E15D68738642B() {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_6CAB75076EC4334E();
  _id_0F04627E8327A207 = _id_8EE10B8E4567C2A1();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 4, ::_id_67E64472BE618168, _id_D879231278CE8E83, 4, ::_id_67E64472BE618168, _id_0F04627E8327A207];
  return _id_927B3199642B75FC;
}

_id_0E8391F9BF6B9AED() {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_6CAB75076EC4334E();
  _id_0F04627E8327A207 = _id_7EB00C3F02C593D0();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 4, ::_id_67E64472BE618168, _id_D879231278CE8E83, 4, ::_id_67E64472BE618168, _id_0F04627E8327A207];
  return _id_927B3199642B75FC;
}

_id_23DD8208F1BA025B() {
  alias = [];
  alias[alias.size] = "s_comm_rhy0";
  alias[alias.size] = "s_conf_cop0";
  return scripts\engine\utility::random(alias);
}

_id_CE3ABE01C9D8B928() {
  alias = [];
  alias[alias.size] = "s_seor_oft0";
  alias[alias.size] = "s_invt_ori0";
  alias[alias.size] = "s_geno_ocl1";
  return scripts\engine\utility::random(alias);
}

_id_E84132896F105965(_id_E413BDA00C8CB0F3, _id_CB7D9ED4FDE5CB25) {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_23DD8208F1BA025B();
  _id_7E647CF8075915B0 = "s_comm_alu0";
  _id_6433DF6D847032EF = _id_CE3ABE01C9D8B928();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 2, ::_id_1F276CA53768BFA9, _id_D879231278CE8E83, 2, ::_id_67E64472BE618168, _id_7E647CF8075915B0, ::_id_67E64472BE618168, _id_6433DF6D847032EF];
  return _id_927B3199642B75FC;
}

_id_6B75C6C72CD1D5A8() {
  alias = [];
  alias[alias.size] = "s_seor_orb1";
  alias[alias.size] = "s_seor_orb0";
  alias[alias.size] = "s_seor_osa1";
  alias[alias.size] = "s_seor_osa1";
  return scripts\engine\utility::random(alias);
}

_id_D65F7EC4946CB258() {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_6B75C6C72CD1D5A8();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 2, ::_id_67E64472BE618168, _id_D879231278CE8E83];
  return _id_927B3199642B75FC;
}

_id_5533255FD4FBF6E3() {
  _id_9F99A28120FFFC67 = _id_D2C0773F378A239A();
  _id_D879231278CE8E83 = _id_6B75C6C72CD1D5A8();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 2, ::_id_67E64472BE618168, _id_D879231278CE8E83];
  return _id_927B3199642B75FC;
}

_id_B35D0C3A9E1070E9() {
  alias = [];
  alias[alias.size] = "s_moac_moa0";
  alias[alias.size] = "s_moac_mot0";
  return scripts\engine\utility::random(alias);
}

_id_1000F4A1C18A2766(_id_E413BDA00C8CB0F3) {
  _id_9F99A28120FFFC67 = "s_comm_neb0";
  _id_D879231278CE8E83 = _id_B35D0C3A9E1070E9();
  _id_927B3199642B75FC = [::_id_67E64472BE618168, _id_9F99A28120FFFC67, 2, ::_id_67E64472BE618168, _id_D879231278CE8E83];
  return _id_927B3199642B75FC;
}

_id_EF9999B04345F5D4() {
  alias = [];
  alias[alias.size] = "st_radioburst_10";
  alias[alias.size] = "st_radioburst_11";
  alias[alias.size] = "st_radioburst_12";
  alias[alias.size] = "st_radioburst_13";
  alias[alias.size] = "st_radioburst_14";
  alias[alias.size] = "st_radioburst_15";
  alias[alias.size] = "st_radioburst_16";
  alias[alias.size] = "st_radioburst_17";
  alias[alias.size] = "st_radioburst_18";
  alias[alias.size] = "st_radioburst_19";
  alias[alias.size] = "st_radioburst_20";
  alias[alias.size] = "st_radioburst_21";
  alias[alias.size] = "st_radioburst_22";
  alias[alias.size] = "st_radioburst_23";
  alias[alias.size] = "st_radioburst_24";
  alias[alias.size] = "st_radioburst_25";
  alias[alias.size] = "st_radioburst_26";
  return scripts\engine\utility::random(alias);
}

_id_C5A3E4813279AF45() {
  _id_9F99A28120FFFC67 = _id_EF9999B04345F5D4();
  _id_D879231278CE8E83 = _id_EF9999B04345F5D4();
  _id_927B3199642B75FC = [::_id_92BACB96846CBA62, _id_9F99A28120FFFC67, 4, ::_id_92BACB96846CBA62, _id_D879231278CE8E83];
  return _id_927B3199642B75FC;
}

_id_96BBC7B40274A3A8(waittime) {
  self notify("radio_marked");
  self endon("death");
  self endon("radio_marked");
  wait(waittime);
  self stopsounds();
}

_id_7289A8868BC4BC3A(agents, players) {
  level endon("game_ended");

  foreach(agent in agents) {
    if(isalive(agent)) {
      agent playsoundonmovingent("mp_dmz_overseer_radio_tag");
      agent thread _id_96BBC7B40274A3A8(0.75);

      if(isDefined(agent._id_665888749D290FDB))
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(agent._id_665888749D290FDB);

      icon = agent thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(players, "hud_icon_head_marked", 8, 1);
      agent._id_665888749D290FDB = icon;
      agent thread _id_4EBC27BAA42965CD(icon);
      agent thread _id_B9B06DB9105DB58F(icon, getdvarfloat("dvar_BB001ED900888502", 10.0));
      wait(randomfloatrange(0.25, 0.4));
    }
  }
}

_id_CD4716D7459F4E90(players, origin, team, agentteam) {
  level endon("game_ended");
  _id_17B71F62DEAF8F29 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    foreach(player in players) {
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_pc_comms"))
          _id_17B71F62DEAF8F29 = 1;
      }
    }
  }

  _id_0DD9AFC233A67E2C = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(origin, 2000, agentteam);
  _id_0DD9AFC233A67E2C = sortbydistance(_id_0DD9AFC233A67E2C, origin);
  level thread _id_7289A8868BC4BC3A(_id_0DD9AFC233A67E2C, players);
  thread _id_3E61541E7C85F0DD(players, origin, 2000, 12);
  _id_7EBE382BCACFE466 = 0;
  _id_9639F9FCAED0FAF6 = 3 + scripts\engine\utility::ter_op(_id_17B71F62DEAF8F29, getdvarint("dvar_1F416FC1D07D0B07", 2), 0);

  while(_id_7EBE382BCACFE466 < _id_9639F9FCAED0FAF6) {
    triggerportableradarpingteam(origin, team, 2000, int(2000));
    _id_7EBE382BCACFE466++;
    wait 2;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
    foreach(player in players) {
      if(isDefined(player))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }
}

_id_3E61541E7C85F0DD(players, origin, radius, time) {
  struct = spawnStruct();
  struct.players = players;
  struct.origin = origin;
  struct.radius = radius;

  if(!isDefined(level._id_A68DCD3B5A82712D))
    level._id_A68DCD3B5A82712D = [];

  level._id_A68DCD3B5A82712D[level._id_A68DCD3B5A82712D.size] = struct;
  wait(time);
  level._id_A68DCD3B5A82712D = scripts\engine\utility::array_remove(level._id_A68DCD3B5A82712D, struct);
}

_id_4EBC27BAA42965CD(icon) {
  self notify("headicon_death_watch");
  self endon("overseer_headicon_deleted");
  self endon("headicon_death_watch");
  level endon("game_ended");
  self waittill("death");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self._id_665888749D290FDB = undefined;
  self notify("overseer_headicon_deleted");
}

_id_B9B06DB9105DB58F(icon, waittime) {
  self notify("headicon_timeout");
  self endon("overseer_headicon_deleted");
  self endon("headicon_timeout");
  level endon("game_ended");
  wait(waittime);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self._id_665888749D290FDB = undefined;
  self notify("overseer_headicon_deleted");
}

_id_4CC3562C55625E70(instance) {
  self notify("radio_activated");
  instance notify("radio_spam");
  level endon("game_ended");
  self endon("death");
  self endon("radio_activated");
  _id_171F90B9C4C76D44 = instance._id_B205D90302DA2F07;
  _id_95110DE3B1417922 = instance.origin;
  instance setscriptablepartstate("brloot_dead_agent_radio", "pulse");
  playsoundatpos(_id_95110DE3B1417922, "mp_dmz_overseer_radio_sweep");
  players = scripts\mp\utility\teams::getteamdata(self.team, "players");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B029CAF23FE6242C");
  _id_6A8EC730B2BFA844::_id_3D12FCE128D424B1(self, instance);

  if(!isDefined(players)) {
    return;
  }
  agentteam = level._id_4B195D3DD0024B9C;

  if(isDefined(instance.droppedteam))
    agentteam = instance.droppedteam;

  level thread _id_CD4716D7459F4E90(players, _id_95110DE3B1417922, self.team, agentteam);
  wait 2;
  _id_7E52B56769FA7774::loothide(instance);
}

_id_FC9A15646315764C(_id_A46D287F39A98D69) {
  if(!isDefined(_id_A46D287F39A98D69)) {
    return;
  }
  _id_A46D287F39A98D69 notify("radio_spam");
  _id_A46D287F39A98D69 endon("radio_spam");
  wait 3;

  while(isDefined(_id_A46D287F39A98D69) && isDefined(_id_A46D287F39A98D69.origin)) {
    alias = _id_EF9999B04345F5D4();
    playsoundatpos(_id_A46D287F39A98D69.origin, alias);
    wait 4;
  }
}