/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_419eebc6f24e287.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_28C3893738C043FE = spawnStruct();
  level._id_28C3893738C043FE._id_44E1D98597133755 = getdvarint("dvar_748AB0BC80934DE8", 5000);
  level._id_28C3893738C043FE._id_C9BA50820F3986F6 = getdvarint("dvar_88A9D31F746FDCFD", 3000);
  level._id_28C3893738C043FE._id_55D86774A0BCC0CA = level._id_28C3893738C043FE._id_C9BA50820F3986F6 * level._id_28C3893738C043FE._id_C9BA50820F3986F6;
  level._id_28C3893738C043FE._id_FEB83D3EED59BE1C = getdvarint("dvar_C110A96F83421225", 1000);
  level._id_28C3893738C043FE._id_E3AA1DE9D96E0086 = getdvarint("dvar_7DC3A9F8FFACEC29", 500);
  level._id_28C3893738C043FE._id_58EF8EB47442FBE2 = getdvarint("dvar_8DC01B0B3ABF0A38", 20);
  level._id_28C3893738C043FE._id_06EFF6B94778545A = getdvarint("dvar_34765B5B6345DAE7", 5);
  level._id_28C3893738C043FE.timelimit = getdvarint("dvar_3995EEDE69848E9A", 300);
  level._id_28C3893738C043FE._id_AE4083584090E161 = getdvarfloat("dvar_89B6724F76AA6E23", 80000);
  level._id_28C3893738C043FE._id_55A75BA6640B59F4 = getdvarint("dvar_21134403816F9C13", 3000);
  level._id_28C3893738C043FE._id_09FE72F3581FC4D1 = getdvarint("dvar_AF4FFD6EF7FF488C", 8000);
  level._id_28C3893738C043FE._id_0270E844812934F3 = getdvarint("dvar_BE8A7D28964A6DC2", 8000);
  level._id_28C3893738C043FE._id_886276B7B80850B0 = getdvarfloat("dvar_029632D3BFBE41A8", 240);
  level._id_28C3893738C043FE._id_5572778D2CFFE0FD = getdvarfloat("dvar_1C5B121D784DF846", 40);
  level._id_28C3893738C043FE._id_E01B87EFDEA9BF3B = getdvarfloat("dvar_E6E560E292FA7267", 50);
  level._id_28C3893738C043FE._id_069873ADAF95B11A = getdvarfloat("dvar_C67F8F7BB2B43236", 2.5);
  level._id_28C3893738C043FE._id_E8FA4E2BD0433D43 = getdvarfloat("dvar_A46CE7A6ED335D5B", 60);
  level._id_28C3893738C043FE._id_15B2BBC2239D50E1 = getdvarfloat("dvar_DB4270E079922C25", 0.05);
  level._id_28C3893738C043FE._id_E6932C067E0B2E71 = getdvarint("dvar_9CE7FC426FD9F32E", 900);
  level._id_28C3893738C043FE._id_BB8D6F64E59163F4 = getdvarint("dvar_ABBEEBF5FB8A15D9", 1);
  level._id_28C3893738C043FE._id_B7718B6E41108129 = [];
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_6BDC6F56944DC3AA);
  _id_58E0D036347FD542 = [];
  _id_8B03497B50726BF2 = data.difficulty;
  _id_633F01F8D61A0608 = getentitylessscriptablearray("brloot_activity_starter_hunt");

  foreach(phone in _id_633F01F8D61A0608) {
    origin = phone.origin;
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);
    _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(origin, _id_171F90B9C4C76D44);

    if(isDefined(_id_D1CF55B36FACF5A8) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1) && isDefined(_id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39) && _id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39 >= _id_8B03497B50726BF2) {
      struct = spawnStruct();
      struct.origin = origin;
      struct._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
      _id_58E0D036347FD542[_id_58E0D036347FD542.size] = struct;
    }
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_036F0BA14F05E6AF, _id_58E0D036347FD542);
}

_id_036F0BA14F05E6AF(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_566816B4F552A1C4;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_43C983B9B250D47D;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_0241BC6ED8976306;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_87B69C01124F351D;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_498B6E96E451E96F;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_E7C1495D8E3578D4;
  _id_B8EBE3F71A08AB40.ref = "dmz_hunt";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  level._id_28C3893738C043FE._id_B7718B6E41108129[level._id_28C3893738C043FE._id_B7718B6E41108129.size] = _id_B8EBE3F71A08AB40;
  return _id_B8EBE3F71A08AB40;
}

_id_566816B4F552A1C4() {
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Hostage_Dmz", [self.node.origin], level._id_28C3893738C043FE._id_C9BA50820F3986F6 + level._id_28C3893738C043FE._id_E3AA1DE9D96E0086);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin);
}

_id_0241BC6ED8976306(player) {
  _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
  _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
}

_id_87B69C01124F351D(player) {
  _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
}

_id_6BDC6F56944DC3AA(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
    if(isDefined(_id_B8EBE3F71A08AB40.targetteam)) {
      if(_id_8A04AA0E0755E7E3 == _id_B8EBE3F71A08AB40.targetteam) {
        player.aq_targethudenabled = 0;
        player _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(undefined, 0);

        if(!istrue(_id_B8EBE3F71A08AB40._id_83C49DAEEA20A12C) && isDefined(_id_B8EBE3F71A08AB40.targetplayer) && _id_B8EBE3F71A08AB40.targetplayer == player) {
          _id_6D5ED003AF1F9612 = _id_B8EBE3F71A08AB40 _id_E1DF4982E78536F1(player.origin);

          if(_id_6D5ED003AF1F9612.size)
            _id_B8EBE3F71A08AB40.targetplayer = _id_6D5ED003AF1F9612[0];
          else if(_id_EB06B338608EF354 == _id_B8EBE3F71A08AB40.teams[0]) {
            _id_B8EBE3F71A08AB40 _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_team_assimilation_all", _id_B8EBE3F71A08AB40.teams[0]);
            _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_lost_assimilation", "hunt", 0, _id_B8EBE3F71A08AB40.teams[0]);
            _id_B8EBE3F71A08AB40 _id_56101AA018565C1B();
          } else {
            _id_B8EBE3F71A08AB40 _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_eliminated_external", _id_B8EBE3F71A08AB40.teams[0]);
            _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_eliminated_external", "hunt", _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_B8EBE3F71A08AB40.teams[0]);
            _id_B8EBE3F71A08AB40 _id_56101AA018565C1B(_id_B8EBE3F71A08AB40.teams[0]);
          }
        }
      }

      if(_id_EB06B338608EF354 == _id_B8EBE3F71A08AB40.targetteam)
        _id_B8EBE3F71A08AB40 thread _id_80F01B220827B246(player, 0);
    }
  }
}

_id_498B6E96E451E96F(_id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  origin = _id_E2B2BBD9E6539F11[0].origin;
  _id_7EF6A8808A48F958 = undefined;
  _id_D414BA671EB56685 = -1;
  _id_6FD17AE0A8AE99B7 = "generic";

  foreach(player in level.players) {
    _id_07C9CFF27853AB50 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_07C9CFF27853AB50) {
      if(istrue(_id_F0EA4030349A33D5._id_E6204058F06B94E5))
        continue;
    }

    if(player.team != _id_FABF84450735DD93 && player scripts\cp_mp\utility\player_utility::_isalive() && !_id_1A210F388465478B(player.team) && !_id_6D337A1FD1D54C5F::_id_F35A110D69D42DC9(player.team)) {
      _id_C2B66043FA920D3E = _id_3F853155C6CA8319(player, origin);
      _id_75D4749AEE656536 = 0;
      _id_FFA9696E9E1067E5 = 0;
      _id_9953FCFDA245DF5B = "generic";

      foreach(type, score in _id_C2B66043FA920D3E) {
        _id_75D4749AEE656536 = _id_75D4749AEE656536 + score;

        if(type != "generic" && score > _id_FFA9696E9E1067E5) {
          _id_FFA9696E9E1067E5 = score;
          _id_9953FCFDA245DF5B = type;
        }
      }

      if(_id_75D4749AEE656536 > _id_D414BA671EB56685) {
        _id_D414BA671EB56685 = _id_75D4749AEE656536;
        _id_6FD17AE0A8AE99B7 = _id_9953FCFDA245DF5B;
        _id_7EF6A8808A48F958 = player;
      }
    }
  }

  if(!isDefined(_id_7EF6A8808A48F958)) {
    _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_no_targets", "hunt", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
    _id_56101AA018565C1B(_id_FABF84450735DD93);
    return;
  }

  self._id_C37342FD449D3E53 = [];
  _id_6C4E8CEA70BF4B6D::_id_89951899F85B3465(_id_FABF84450735DD93, 0);
  thread _id_6C4E8CEA70BF4B6D::_id_995813AD75B83C53(_id_FABF84450735DD93, 0);
  thread _id_24D85909C1178470(_id_7EF6A8808A48F958.team, 0);
  thread _id_24D85909C1178470(_id_FABF84450735DD93, 1);
  self._id_2635B7B9E2AE9719 = _id_FABF84450735DD93;
  self.targetteam = _id_7EF6A8808A48F958.team;
  self.targetplayer = _id_7EF6A8808A48F958;
  self._id_313BC02483DE4BC0 = 0;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_assigned_" + _id_6FD17AE0A8AE99B7, _id_FABF84450735DD93);
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_assigned_others_" + _id_6FD17AE0A8AE99B7, self.targetteam);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_assigned", _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_assigned_others", self.targetteam);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  thread _id_27493477868A1DBB(self.targetteam, 0);
  _id_AFC29C10D530D13E = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");
  self.missiontime = gettime() + level._id_28C3893738C043FE.timelimit * 1000;

  foreach(player in _id_AFC29C10D530D13E) {
    thread _id_80F01B220827B246(player, 0);
    player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);
  }

  foreach(player in _id_E2B2BBD9E6539F11)
  player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

  thread _id_53CA0DA8B6967DBB(0);
  thread _id_17705FC9356447FB();
}

_id_43C983B9B250D47D(_id_FABF84450735DD93) {}

_id_E7C1495D8E3578D4(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players)
  player setplayermusicstate("");

  if(isDefined(self.targetteam))
    thread _id_0AD81DCA98401B58();

  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self._id_7EF0FA7A21303CCC = 1;
  level._id_28C3893738C043FE._id_B7718B6E41108129 = scripts\engine\utility::array_remove(level._id_28C3893738C043FE._id_B7718B6E41108129, self);
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  if(isDefined(self.targetteam)) {
    _id_07C9CFF27853AB50 = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");

    foreach(player in _id_07C9CFF27853AB50) {
      player.aq_targethudenabled = 0;
      player setclientomnvar("ui_br_assassination_target", 0);
    }
  }
}

_id_56101AA018565C1B(team) {
  _id_8250FD658E3AAE32();

  if(isDefined(team)) {
    _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(team);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  }

  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(team);
}

_id_1A210F388465478B(team) {
  foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
    if(!istrue(_id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC) && isDefined(_id_B8EBE3F71A08AB40.targetteam) && _id_B8EBE3F71A08AB40.targetteam == team)
      return 1;
  }

  return 0;
}

_id_3F853155C6CA8319(player, origin) {
  _id_C2B66043FA920D3E = [];
  dist = distance(origin, player.origin);
  maxdist = level._id_28C3893738C043FE._id_AE4083584090E161;
  _id_7A73315D7CA78155 = max(level._id_28C3893738C043FE._id_886276B7B80850B0 * (1 - dist / maxdist), 0);
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_6D038A7052E9467C = 0;

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(player scripts\mp\utility\perk::_hasperk("specialty_ghost"))
      _id_6D038A7052E9467C++;
  }

  _id_4AA32C116C698FF6 = level._id_28C3893738C043FE._id_5572778D2CFFE0FD * (_id_A6AB8D0FDA441DC2.size - _id_6D038A7052E9467C);
  _id_C2B66043FA920D3E["generic"] = _id_7A73315D7CA78155 + _id_4AA32C116C698FF6;
  _id_C2B66043FA920D3E["civs"] = level._id_28C3893738C043FE._id_E01B87EFDEA9BF3B * scripts\engine\utility::ter_op(isDefined(player._id_18CCF3F412948903), player._id_18CCF3F412948903, 0);
  _id_C2B66043FA920D3E["agents"] = level._id_28C3893738C043FE._id_069873ADAF95B11A * scripts\engine\utility::ter_op(isDefined(player._id_2B00EAA34070C8F7), player._id_2B00EAA34070C8F7, 0);
  _id_C2B66043FA920D3E["operators"] = level._id_28C3893738C043FE._id_E8FA4E2BD0433D43 * scripts\engine\utility::ter_op(isDefined(player.pers["kills"]), player.pers["kills"], 0);
  _id_C2B66043FA920D3E["valuables"] = level._id_28C3893738C043FE._id_15B2BBC2239D50E1 * (player.plundercount + player _id_6FC415FF6A905DC1::_id_E2F4F470C55123B8(undefined, 1));
  return _id_C2B66043FA920D3E;
}

_id_17705FC9356447FB() {
  level endon("game_ended");
  self endon("task_ended");
  wait(level._id_28C3893738C043FE.timelimit);

  if(istrue(self._id_7EF0FA7A21303CCC)) {
    return;
  }
  _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_lost_time", "hunt", 0, self.teams[0]);
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_lose_time", self.teams[0]);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_lose", 0.0, "dmz_activity_lose_classic");
  thread _id_0AD81DCA98401B58();
  _id_56101AA018565C1B();
}

_id_0AD81DCA98401B58() {
  level endon("game_ended");
  _id_1B4ADA49A21B51CA = scripts\engine\utility::ter_op(level._id_28C3893738C043FE._id_BB8D6F64E59163F4, "dmz_hunt_target_survived_uav", "dmz_hunt_target_survived");
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF(_id_1B4ADA49A21B51CA, self.targetteam);

  if(level._id_28C3893738C043FE._id_BB8D6F64E59163F4) {
    wait 2.0;
    owner = undefined;
    players = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");

    foreach(player in players) {
      if(player scripts\cp_mp\utility\player_utility::_isalive() && !istrue(player.extracted)) {
        owner = player;
        break;
      }
    }

    if(isDefined(owner)) {
      owner endon("disconnect");
      streakname = "uav";
      streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, owner);
      streakinfo.skipequippedstreakcheck = 1;
      streakinfo._id_02495B93AC241A91 = 1;

      if(isDefined(level.killstreaktriggeredfunc)) {
        if(!level[[level.killstreaktriggeredfunc]](streakinfo))
          return;
      }

      if(isDefined(level.killstreakbeginusefunc)) {
        if(!level[[level.killstreakbeginusefunc]](streakinfo))
          return 0;
      }

      _id_509A782DD5B89CF1::_id_E24C416C5028BCCC(owner, streakinfo);
    }
  }
}

_id_53CA0DA8B6967DBB(_id_3EDA0EF65C9478AC) {
  level endon("game_ended");
  self endon("task_ended");
  _id_0C017034A3F48C26 = 0;

  for(;;) {
    if(isDefined(self.targetplayer) && isDefined(self._id_C37342FD449D3E53[_id_3EDA0EF65C9478AC]) && isDefined(self.targetplayer.guid) && isDefined(self._id_C37342FD449D3E53[_id_3EDA0EF65C9478AC][self.targetplayer.guid])) {
      _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
      closestplayer = scripts\engine\utility::getclosest(self._id_C37342FD449D3E53[_id_3EDA0EF65C9478AC][self.targetplayer.guid], _id_E2B2BBD9E6539F11);

      if(!isDefined(closestplayer)) {
        wait 1.0;
        continue;
      }

      dist = distance(self._id_C37342FD449D3E53[1][closestplayer.guid], self._id_C37342FD449D3E53[_id_3EDA0EF65C9478AC][self.targetplayer.guid]);
      threatlevel = 0;

      if(dist > level._id_28C3893738C043FE._id_09FE72F3581FC4D1)
        threatlevel = 0;
      else if(dist > level._id_28C3893738C043FE._id_55A75BA6640B59F4)
        threatlevel = 1;
      else
        threatlevel = 2;

      if(!istrue(_id_0C017034A3F48C26) && dist < level._id_28C3893738C043FE._id_0270E844812934F3) {
        _id_7F96D62F3ABBF9B9 = _func_767CEA82B001F645(self._id_C37342FD449D3E53[_id_3EDA0EF65C9478AC][self.targetplayer.guid] - closestplayer.origin);
        _id_9563AB8C74BF32FB = 0.92388;
        _id_7E0FADF7957F3341 = 0.707107;
        alias = "hunt_near_generic";

        if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (1, 0, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_east";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (0, 1, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_north";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (-1, 0, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_west";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (0, -1, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_south";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (_id_7E0FADF7957F3341, _id_7E0FADF7957F3341, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_northeast";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (0.0 - _id_7E0FADF7957F3341, _id_7E0FADF7957F3341, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_northwest";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (0.0 - _id_7E0FADF7957F3341, 0.0 - _id_7E0FADF7957F3341, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_southwest";
        else if(_func_C1AA7C066EC92CA5(_id_7F96D62F3ABBF9B9, (_id_7E0FADF7957F3341, 0.0 - _id_7E0FADF7957F3341, 0), 1) > _id_9563AB8C74BF32FB)
          alias = "hunt_near_southeast";

        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9(alias, self.teams[0]);
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_near_others", self.targetteam);
        _id_0C017034A3F48C26 = 1;
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.targetteam, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
      }

      _id_07C9CFF27853AB50 = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");

      foreach(player in _id_07C9CFF27853AB50) {
        player.aq_targethudenabled = 1;
        player _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(self.targetplayer, threatlevel);
      }
    }

    wait 1.0;
  }
}

_id_27493477868A1DBB(team, _id_4EB72456A6876373) {
  level endon("game_ended");
  self endon("task_ended");
  _id_07C9CFF27853AB50 = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");

  if(!isDefined(self.targetplayer) || self.targetplayer.team != self.targetteam) {
    _id_DA33C7081FAA4A77 = 0;

    foreach(player in _id_07C9CFF27853AB50) {
      if(player scripts\cp_mp\utility\player_utility::_isalive()) {
        self.targetplayer = player;
        _id_DA33C7081FAA4A77 = 1;
        break;
      }
    }

    if(!istrue(_id_DA33C7081FAA4A77))
      return;
  }

  self._id_DABF4CF09B2C06CA = self._id_C37342FD449D3E53[_id_4EB72456A6876373][self.targetplayer.guid];
  _id_C7111E2F9F477BEC = -999999;

  for(;;) {
    currenttime = gettime();
    _id_07C9CFF27853AB50 = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");
    self._id_AFC29C10D530D13E = [];
    points = [];

    foreach(player in _id_07C9CFF27853AB50) {
      if(istrue(player._id_E6204058F06B94E5)) {
        _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_lost_escaped", "hunt", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, self.teams[0]);
        _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_target_over", self.targetteam);
        thread _id_56101AA018565C1B(self.teams[0]);
        return;
      }
    }

    if(!isDefined(self.targetplayer) || self.targetplayer.team != self.targetteam) {
      _id_DA33C7081FAA4A77 = 0;

      foreach(player in _id_07C9CFF27853AB50) {
        if(player scripts\cp_mp\utility\player_utility::_isalive()) {
          self.targetplayer = player;
          _id_DA33C7081FAA4A77 = 1;
          break;
        }
      }

      if(!istrue(_id_DA33C7081FAA4A77))
        return;
    }

    if(!isDefined(self.targetplayer) || !isDefined(self._id_C37342FD449D3E53[_id_4EB72456A6876373][self.targetplayer.guid])) {
      return;
    }
    _id_F17269C0D177F1EB = level._id_28C3893738C043FE._id_58EF8EB47442FBE2;
    invehicle = self.targetplayer scripts\cp_mp\utility\player_utility::isinvehicle(0);

    if(invehicle)
      _id_F17269C0D177F1EB = level._id_28C3893738C043FE._id_06EFF6B94778545A;

    if(currenttime - _id_C7111E2F9F477BEC > _id_F17269C0D177F1EB * 1000) {
      radius = scripts\engine\utility::ter_op(invehicle, level._id_28C3893738C043FE._id_FEB83D3EED59BE1C, level._id_28C3893738C043FE._id_C9BA50820F3986F6);
      circleorigin = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self._id_DABF4CF09B2C06CA, radius);
      circleorigin = (circleorigin[0], circleorigin[1], level._id_28C3893738C043FE._id_C9BA50820F3986F6 + level._id_28C3893738C043FE._id_E3AA1DE9D96E0086);
      self._id_B0F4BF8621B96C0A[0].mapcircle moveTo(circleorigin, 1.0, 0.25, 0.25);
      thread _id_E31CA14144DFA042();
      self._id_DABF4CF09B2C06CA = self._id_C37342FD449D3E53[_id_4EB72456A6876373][self.targetplayer.guid];
      _id_C7111E2F9F477BEC = currenttime;
    }

    wait 1.0;
  }
}

_id_E31CA14144DFA042() {
  self endon("task_ended");
  endtime = gettime() + 1200;

  while(gettime() < endtime && isDefined(self._id_B0F4BF8621B96C0A) && isDefined(self._id_B0F4BF8621B96C0A[0]) && isDefined(self._id_B0F4BF8621B96C0A[0].mapcircle) && isDefined(self._id_B0F4BF8621B96C0A[0].mapcircle.origin)) {
    _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(self._id_B0F4BF8621B96C0A[0].mapcircle.origin);
    waitframe();
  }
}

_id_80F01B220827B246(targetplayer, _id_D52E150DDD057E83) {
  level endon("game_ended");
  self endon("task_ended");

  for(;;) {
    targetplayer scripts\engine\utility::waittill_any_4("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp");

    if(istrue(self._id_7EF0FA7A21303CCC)) {
      return;
    }
    if(!isDefined(targetplayer) || isDefined(targetplayer.team) && targetplayer.team != self.targetteam) {
      return;
    }
    if(istrue(targetplayer.extracted) || istrue(targetplayer._id_DED04CDD264A7E00)) {
      if(targetplayer == self.targetplayer) {
        _id_6D5ED003AF1F9612 = _id_E1DF4982E78536F1(self._id_C37342FD449D3E53[_id_D52E150DDD057E83][targetplayer.guid]);

        if(_id_6D5ED003AF1F9612.size == 0) {
          _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_lost_exfilled", "hunt", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, self.teams[0]);
          _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_target_over", self.targetteam);
          thread _id_56101AA018565C1B();
          return;
        } else
          self.targetplayer = _id_6D5ED003AF1F9612[0];
      }
    } else if(!targetplayer scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!isDefined(targetplayer.lastkilledby) || !isDefined(targetplayer.lastkilledby.team) || targetplayer.lastkilledby.team != self.teams[0]) {
        if(!istrue(self._id_83C49DAEEA20A12C)) {
          _id_6D5ED003AF1F9612 = _id_E1DF4982E78536F1(self._id_C37342FD449D3E53[_id_D52E150DDD057E83][targetplayer.guid]);

          if(targetplayer == self.targetplayer) {
            if(_id_6D5ED003AF1F9612.size == 0) {
              _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_eliminated_external", self.teams[0]);
              _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_eliminated_external", "hunt", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, self.teams[0]);
              _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_target_over", self.targetteam);
              thread _id_56101AA018565C1B(self.teams[0]);
              return;
            } else
              self.targetplayer = _id_6D5ED003AF1F9612[0];
          }
        }
      } else {
        self._id_83C49DAEEA20A12C = 1;

        if(!istrue(self._id_DA2879CC9668BFA5)) {
          self.targetplayer = targetplayer;
          self._id_DA2879CC9668BFA5 = 1;
          thread _id_D85CC7847F7FC492(self._id_C37342FD449D3E53[_id_D52E150DDD057E83][targetplayer.guid]);
        }
      }
    }

    targetplayer waittill("tr_respawned");

    if(isDefined(targetplayer) && isDefined(self.targetplayer) && self.targetplayer == targetplayer)
      self notify("stop_monitoring_distance");
  }
}

_id_24D85909C1178470(team, index) {
  level endon("game_ended");
  self endon("task_ended");
  self._id_C37342FD449D3E53[index] = [];

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players)
    self._id_C37342FD449D3E53[index][player.guid] = player.origin;

    waitframe();
  }
}

_id_D85CC7847F7FC492(origin) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("stop_monitoring_distance");

  for(;;) {
    count = _id_A5F450D405D9D197(origin);

    if(count == 0) {
      self._id_4048AF728F427CA2 = 1;

      if(scripts\mp\utility\teams::_id_3D0F2343793D709B(self.targetteam, undefined, 1).size) {
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_eliminated_ran_away", self.teams[0]);
        _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hunt_target_over", self.targetteam);
      } else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hunt_eliminated_no_dog_tags", self.teams[0]);

      _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hunt_won", "hunt", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, self.teams[0]);
      _id_56101AA018565C1B(self.teams[0]);
    }

    self._id_B98634BF2BAE674B = count;
    wait 1.0;
  }
}

_id_E1DF4982E78536F1(origin) {
  players = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");
  _id_6D5ED003AF1F9612 = [];

  foreach(player in players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive() && !istrue(player.extracted) && !istrue(player._id_DED04CDD264A7E00) && distancesquared(player.origin, origin) < level._id_28C3893738C043FE._id_55D86774A0BCC0CA)
      _id_6D5ED003AF1F9612[_id_6D5ED003AF1F9612.size] = player;
  }

  return _id_6D5ED003AF1F9612;
}

_id_A5F450D405D9D197(origin) {
  return _id_E1DF4982E78536F1(origin).size;
}

_id_7562A66C42D923DC() {
  if(isDefined(level._id_28C3893738C043FE) && isDefined(level._id_28C3893738C043FE._id_B7718B6E41108129)) {
    foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
      if(!isDefined(_id_B8EBE3F71A08AB40.teams[0]))
        _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_5EA1BE154AEB609B _id_03314ADD7998AB13::_id_66DA9365BBFEA8B7();
    }

    scripts\mp\flags::gameflagwait("prematch_done");
    wait(level._id_28C3893738C043FE._id_E6932C067E0B2E71);

    foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
      if(!isDefined(_id_B8EBE3F71A08AB40.teams[0]))
        _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_5EA1BE154AEB609B _id_03314ADD7998AB13::_id_5220F38B5239EAC8();
    }

    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hunt_contracts_revealed", level.players);
  }
}

_id_9AFA2021A101589A() {
  if(isDefined(level._id_28C3893738C043FE) && isDefined(level._id_28C3893738C043FE._id_B7718B6E41108129)) {
    foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
      if(!isDefined(_id_B8EBE3F71A08AB40.teams) || !isDefined(_id_B8EBE3F71A08AB40.teams[0]))
        _id_B8EBE3F71A08AB40 _id_56101AA018565C1B();
    }
  }
}

_id_5FAC7D775590ECDD(_id_2635B7B9E2AE9719, _id_6D915EF0D70DA0F8) {
  if(!isDefined(_id_2635B7B9E2AE9719) || !isDefined(_id_6D915EF0D70DA0F8))
    return 0;

  if(!isDefined(level._id_28C3893738C043FE) || !isDefined(level._id_28C3893738C043FE._id_B7718B6E41108129))
    return 0;

  foreach(_id_B8EBE3F71A08AB40 in level._id_28C3893738C043FE._id_B7718B6E41108129) {
    if(isDefined(_id_B8EBE3F71A08AB40.teams[0]) && _id_B8EBE3F71A08AB40.teams[0] == _id_2635B7B9E2AE9719 && isDefined(_id_B8EBE3F71A08AB40.targetteam) && _id_B8EBE3F71A08AB40.targetteam == _id_6D915EF0D70DA0F8)
      return 1;
  }

  return 0;
}

_id_68BE04907D120C43() {
  level endon("game_ended");

  for(;;) {
    if(getdvarint("dvar_8F9EB7D050279C5D", 0)) {
      setDvar("dvar_8F9EB7D050279C5D", 0);
      _id_6640C2677653D96F = spawnStruct();
      _id_6640C2677653D96F.teams = [level.players[0].team];
      _id_6640C2677653D96F.targetteam = level.players[0].team;
      _id_6640C2677653D96F.node = spawnStruct();
      _id_6640C2677653D96F thread _id_0AD81DCA98401B58();
    }

    waitframe();
  }
}