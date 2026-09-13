/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\squads.gsc
***********************************************/

init() {
  level.maxsquadsize = getdvarint("party_maxSquadSize", 1);

  if(level.maxsquadsize && _id_58BE75C518BF0D40::_id_A9CB1BBCE9EB3D1B())
    level.maxsquadsize = level.maxteamsize;

  level.usesquadleader = getdvarint("dvar_56FE5E64DB58EB48", 1);

  if(_id_58BE75C518BF0D40::shouldmodesetsquads())
    initsquaddata();
}

initsquaddata() {
  level.squaddata = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.squaddata[_id_F90358454413407F] = [];
}

setsquad(team, index) {
  if(!_id_58BE75C518BF0D40::shouldmodesetsquads()) {
    return;
  }
  if(!isDefined(team) || team == "spectator" || team == "codcaster") {
    return;
  }
  if(getdvarint("scr_assign_squad_from_team", 0) != 0) {
    _id_3EDA0EF65C9478AC = 0;

    foreach(index, name in level.teamnamelist) {
      if(name == team) {
        _id_3EDA0EF65C9478AC = index;
        break;
      }
    }

    joinsquad(team, _id_3EDA0EF65C9478AC);
    return;
  }

  if(isbot(self) && isDefined(self._id_B5517A8D74ED63A3))
    _id_69C5807191F92FBB = self._id_B5517A8D74ED63A3 != -1;
  else
    _id_69C5807191F92FBB = self._id_0FF97225579DE16A != -1;

  if(istrue(level.matchmakingmatch) && _id_69C5807191F92FBB && getdvarint("dvar_6595C001520E3EEC", 0) != 1) {
    if(!isDefined(index)) {
      if(isbot(self) && isDefined(self._id_B5517A8D74ED63A3))
        index = self._id_B5517A8D74ED63A3;
      else
        index = self._id_0FF97225579DE16A;
    }

    self.squadassignedfromlobby = 1;
    joinsquad(team, index);
    return;
  }

  if(istrue(level.matchmakingmatch)) {
    _id_06980251E86D0A47 = self getfireteammembers();

    if(isDefined(_id_06980251E86D0A47) && _id_06980251E86D0A47.size > 0) {
      squadindex = undefined;

      foreach(_id_80EF668C09FFB70F in _id_06980251E86D0A47) {
        if(isDefined(_id_80EF668C09FFB70F) && _id_80EF668C09FFB70F._id_0FF97225579DE16A != -1) {
          squadindex = _id_80EF668C09FFB70F._id_0FF97225579DE16A;
          break;
        }
      }

      if(isDefined(squadindex)) {
        joinsquad(team, squadindex);
        return;
      } else {
        requestnewsquad(team, 1);
        return;
      }
    }
  }

  foreach(squad in level.squaddata[team]) {
    isfull = squad.players.size == level.maxsquadsize;

    if(!squad.isfireteam && !isfull) {
      joinsquad(team, squad.index);
      return;
    }
  }

  requestnewsquad(team, 0);
}

createsquad(team, index) {
  if(!isDefined(level._id_9674461D63BE1FD9))
    level._id_9674461D63BE1FD9 = 0;

  if(!isDefined(index))
    index = level._id_9674461D63BE1FD9;

  data = spawnStruct();
  data.index = index;
  data.isfireteam = 0;
  data.players = [];
  data._id_D6EE3E704C6731D4 = undefined;
  data._id_21C2F79E8BFA9162 = undefined;
  level.squaddata[team][index] = data;
  level._id_9674461D63BE1FD9++;
  return index;
}

freesquadindex(team, index) {
  level.squaddata[team][index] = undefined;
}

requestnewsquad(team, isfireteam) {
  index = createsquad(team);
  data = level.squaddata[team][index];
  data.infil = undefined;
  joinsquad(team, index);
}

joinsquad(team, index) {
  if(!isDefined(level.squaddata[team][index]))
    createsquad(team, index);

  self._id_0FF97225579DE16A = index;
  self._id_3F78C6A0862F9E25 = _id_EEC90FB96D0AFF02(team, index);
  level.squaddata[team][index].players[level.squaddata[team][index].players.size] = self;
  choosesquadleader(team, index);
  _id_2342B8AAD723994E::onplayerjoinsquad(self);
  self notify("joined_squad");
}

leavesquad(team, index) {
  if(!_id_58BE75C518BF0D40::shouldmodesetsquads()) {
    return;
  }
  if(!isDefined(team) || team == "spectator" || team == "codcaster" || !isDefined(index) || !isDefined(level.squaddata)) {
    return;
  }
  if(level.squaddata[team][index].players.size == 1) {
    freesquadindex(team, index);
    return;
  }

  self._id_71AFB85EC1CC06F8 = self._id_3F78C6A0862F9E25;
  self._id_3F78C6A0862F9E25 = -1;
  _id_AA17B95935A5047F = 0;
  _id_D6EE3E704C6731D4 = _id_58BE75C518BF0D40::getsquadleader(team, index);

  if(istrue(level.usesquadleader) && isDefined(_id_D6EE3E704C6731D4) && _id_D6EE3E704C6731D4 == self) {
    level.squaddata[team][index]._id_D6EE3E704C6731D4 = undefined;
    _id_AA17B95935A5047F = 1;

    foreach(player in level.squaddata[team][index].players)
    player setclientomnvar("ui_squad_leader", undefined);
  }

  _id_2342B8AAD723994E::_id_2A1E4811621FDCDE(self);
  level.squaddata[team][index].players = scripts\engine\utility::array_remove(level.squaddata[team][index].players, self);

  if(istrue(_id_AA17B95935A5047F)) {
    _id_51F2B611A0573B40 = scripts\engine\utility::array_randomize(level.squaddata[team][index].players);

    foreach(player in _id_51F2B611A0573B40) {
      if(isDefined(player)) {
        player choosesquadleader(team, index);
        break;
      }
    }
  }
}

_id_9BE60342A8BABBA5() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "getMaxAssimilationTeamSize"))
      return [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "getMaxAssimilationTeamSize")]]();
  } else
    return level.maxsquadsize;
}

_id_EEC90FB96D0AFF02(team, index) {
  _id_29370C978F7D04B9 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9BE60342A8BABBA5(); _id_AC0E594AC96AA3A8++)
    _id_29370C978F7D04B9[_id_AC0E594AC96AA3A8] = 1;

  foreach(player in level.squaddata[team][index].players) {
    if(player._id_3F78C6A0862F9E25 >= 0)
      _id_29370C978F7D04B9[player._id_3F78C6A0862F9E25] = 0;
  }

  foreach(index, _id_2B11FCB306AA898C in _id_29370C978F7D04B9) {
    if(_id_2B11FCB306AA898C)
      return index;
  }

  return undefined;
}

_id_08A9305612B73A15(team, index) {
  if(isDefined(self._id_0FF97225579DE16A) && self._id_0FF97225579DE16A == index) {
    return;
  }
  leavesquad(team, self._id_0FF97225579DE16A);
  joinsquad(team, index);
}

updatesquadomnvars(team, squadindex) {
  if(!_id_58BE75C518BF0D40::shouldmodesetsquads() || !isDefined(level.squaddata)) {
    return;
  }
  _id_D6EE3E704C6731D4 = _id_58BE75C518BF0D40::getsquadleader(team, squadindex);

  foreach(player in level.squaddata[team][squadindex].players) {
    _id_4F87BC92D01FA479 = squadindex;
    _id_4F87BC92D01FA479 = _id_4F87BC92D01FA479 + (level.squaddata[team][squadindex].players.size << 5);

    if(isDefined(_id_D6EE3E704C6731D4) && _id_D6EE3E704C6731D4 == player)
      _id_4F87BC92D01FA479 = _id_4F87BC92D01FA479 + 256;

    player setclientomnvar("ui_squad_data", _id_4F87BC92D01FA479);

    if(isDefined(level.gametype) && (level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "arena" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl")) {
      _id_69FE4A18F948739C = player.game_extrainfo & 65528;
      player.game_extrainfo = _id_69FE4A18F948739C | player._id_3F78C6A0862F9E25 + 1;

      if(isDefined(_id_D6EE3E704C6731D4) && _id_D6EE3E704C6731D4 == player)
        player.game_extrainfo = player.game_extrainfo | 256;
      else
        player.game_extrainfo = player.game_extrainfo &~256;

      _id_F31235F8D2BEC0F0 = player getentitynumber();

      if(isDefined(_id_D6EE3E704C6731D4) && _id_D6EE3E704C6731D4 == player)
        _id_F31235F8D2BEC0F0 = _id_F31235F8D2BEC0F0 + 2048;

      if(isalive(player))
        _id_F31235F8D2BEC0F0 = _id_F31235F8D2BEC0F0 + 4096;

      player setclientomnvar("ui_arm_squadmember_0", _id_F31235F8D2BEC0F0);
      _id_AAA863033D6D0DCD = scripts\engine\utility::array_remove(level.squaddata[team][squadindex].players, player);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
        _id_C98AAC0E8E6EAF8C = _id_AAA863033D6D0DCD[_id_AC0E594AC96AA3A8];

        if(isDefined(_id_C98AAC0E8E6EAF8C)) {
          _id_F31235F8D2BEC0F0 = _id_C98AAC0E8E6EAF8C getentitynumber();

          if(isDefined(_id_D6EE3E704C6731D4) && _id_D6EE3E704C6731D4 == _id_C98AAC0E8E6EAF8C)
            _id_F31235F8D2BEC0F0 = _id_F31235F8D2BEC0F0 + 2048;

          if(isalive(_id_C98AAC0E8E6EAF8C))
            _id_F31235F8D2BEC0F0 = _id_F31235F8D2BEC0F0 + 4096;
        } else
          _id_F31235F8D2BEC0F0 = -1;

        player setclientomnvar("ui_arm_squadmember_" + (_id_AC0E594AC96AA3A8 + 1), _id_F31235F8D2BEC0F0);
      }
    }
  }
}

choosesquadleader(team, index) {
  if(!istrue(level.usesquadleader)) {
    return;
  }
  _id_DDB8D98C593D15DE = 0;

  if(istrue(level.matchmakingmatch)) {
    _id_06980251E86D0A47 = self getfireteammembers();

    if(isDefined(_id_06980251E86D0A47) && _id_06980251E86D0A47.size > 0)
      _id_DDB8D98C593D15DE = self isfireteamleader();
  }

  _id_8F7C03EC5F22FE86 = self;

  if(!_id_DDB8D98C593D15DE) {
    _id_CC0BB577353A4C93 = _id_58BE75C518BF0D40::getsquadleader(team, index);

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      if(isDefined(_id_CC0BB577353A4C93) && !isai(_id_CC0BB577353A4C93)) {
        return;
      }
      if(isai(_id_8F7C03EC5F22FE86)) {
        _id_BEB6C9F3D61CF4E1 = 0;

        foreach(player in level.squaddata[team][index].players) {
          if(!isai(player)) {
            _id_8F7C03EC5F22FE86 = player;
            _id_BEB6C9F3D61CF4E1 = 1;
            break;
          }
        }

        if(!_id_BEB6C9F3D61CF4E1 && isDefined(_id_CC0BB577353A4C93))
          return;
      }
    } else if(isDefined(_id_CC0BB577353A4C93))
      return;
  }

  level.squaddata[team][index]._id_D6EE3E704C6731D4 = _id_8F7C03EC5F22FE86;

  foreach(player in level.squaddata[team][index].players)
  player setclientomnvar("ui_squad_leader", _id_8F7C03EC5F22FE86);
}