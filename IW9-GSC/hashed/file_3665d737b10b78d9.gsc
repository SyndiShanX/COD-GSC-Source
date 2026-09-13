/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3665d737b10b78d9.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  if(!istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  level._id_97818B2FA3F29568 = spawnStruct();
  level._id_97818B2FA3F29568.circleradius = getdvarint("dvar_FFF0FC72EB6BAF5C", 800);
  level._id_97818B2FA3F29568._id_E3AA1DE9D96E0086 = getdvarint("dvar_F1A5F02ED324BE1F", 200);
  level._id_97818B2FA3F29568._id_EB4E83BDEB266116 = getdvarint("dvar_BF58DE61E69C846B", 200);
  level._id_97818B2FA3F29568._id_FBBE0ADF8216FE9A = getdvarint("dvar_160D5DEA50195723", 30);
  level._id_97818B2FA3F29568._id_0C46BEAE1FD1C519 = getdvarint("dvar_CBD3439C13338226", 50);
  level._id_97818B2FA3F29568._id_8EBBA99852AA5265 = getdvarint("dvar_DC9A41086C28C4C2", 20);
  level._id_97818B2FA3F29568._id_77888CEE41A9692D = getdvarint("dvar_6F328864B0B8DC62", 0);
  level._id_97818B2FA3F29568._id_B68C2A8C7C682857 = getdvarint("dvar_18B5F4B80CCA8E31", 80);
  level._id_97818B2FA3F29568._id_92304CBE2F72AE5C = getdvarint("dvar_4767A58A76A283F6", 30);
  level._id_97818B2FA3F29568._id_CAAD6EDA57CD258D = getdvarint("dvar_7B8B57C6513EDD4F", 5);
  level._id_97818B2FA3F29568._id_D930BD12AA1FD3F2 = getdvarint("dvar_1144299C01007574", 10);
  _id_58E0D036347FD542 = scripts\engine\utility::getStructArray("elim_target", "script_noteworthy");
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_3C906415E5828995, _id_58E0D036347FD542);
}

_id_3C906415E5828995(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_4EEAD3091A075F56;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_250B27B303AEE1CF;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_FDFE221DCFF2F6F4;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_792124E8BD5A56C7;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_4B91BB084671306D;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_9AB1E3E53B4B5816;
  _id_B8EBE3F71A08AB40.ref = "dmz_elimination";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40._id_1D4E0C690556A8B2 = 1;
  return _id_B8EBE3F71A08AB40;
}

_id_4EEAD3091A075F56() {
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  _id_79B9C85900392AD6 = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self.node.origin, level._id_97818B2FA3F29568.circleradius);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(_id_79B9C85900392AD6 + (0, 0, 300));
  _id_6C4E8CEA70BF4B6D::_id_8CD2AC82037F025C("Hostage_Dmz", _id_79B9C85900392AD6, level._id_97818B2FA3F29568.circleradius + 200);
  _id_30B708220BB23467 = [];
  targetorigin = getclosestpointonnavmesh(self.node.origin);
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  _id_9006453DB9F3E663 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, targetorigin, self.node.angles, "absolute", "mission", "elimTarget", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 0);

  if(!isDefined(_id_9006453DB9F3E663)) {
    _id_0565A5CA9EEF7C50();
    return;
  }

  _id_9006453DB9F3E663._id_B582B10663B5B2A9 = 0;
  _id_7E1FF9AFA225E8A1 = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];
  _id_A664AAD02EE98BD2 = scripts\engine\utility::random(_id_7E1FF9AFA225E8A1);
  armor = 500;
  helmet = 3;
  body = scripts\engine\utility::random(["body_dmz_opforce_cartel_1_1", "body_dmz_opforce_cartel_1_2", "body_dmz_opforce_cartel_1_3", "body_dmz_opforce_cartel_2_1", "body_dmz_opforce_cartel_2_2", "body_dmz_opforce_cartel_2_3", "body_dmz_opforce_cartel_3_1", "body_dmz_opforce_cartel_3_2", "body_dmz_opforce_cartel_3_3"]);
  head = scripts\engine\utility::random(["head_sp_opforce_cartel_tier_2_2_1", "head_sp_opforce_cartel_tier_2_5_1", "head_sp_opforce_cartel_tier_2_6_1"]);
  _id_9006453DB9F3E663 _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, _id_3FA9AA825ADA06DD(), _id_A664AAD02EE98BD2, 4, armor, helmet);

  if(getdvarint("dvar_49B37FC622A4D585", 0) == 1)
    _id_9006453DB9F3E663 _meth_3DE79443C911D4A5(1, 4, "MP_DMZ_MISSIONS/BOSS_NAME_YEGOR");

  _id_30B708220BB23467[0] = _id_9006453DB9F3E663;
  self.enemy = _id_9006453DB9F3E663;
  thread _id_47EF6B3F2A53E9C1();
  thread _id_120270BD0A747A35::_id_B11C1964F528574B(_id_9006453DB9F3E663, undefined, self.node.origin);
  _id_F78A17463EEBCB84 = [];

  if(isDefined(self.node.target)) {
    _id_F78A17463EEBCB84 = _id_0E9591DF01126977(self.node.target, self.enemy.origin);

    if(isDefined(_id_F78A17463EEBCB84) && _id_F78A17463EEBCB84.size > 0)
      _id_30B708220BB23467 = scripts\engine\utility::array_combine(_id_30B708220BB23467, _id_F78A17463EEBCB84);
  }

  foreach(agent in _id_F78A17463EEBCB84)
  thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, level._id_97818B2FA3F29568._id_EB4E83BDEB266116, 0);

  _id_C704F6B8763D15B4(self.enemy);
  self.enemy.dontkilloff = 1;
  self.enemy thread _id_BCAD41AB1C2F02B4(self);
  self.name = _id_C393B86B6A285ACF();
}

_id_FDFE221DCFF2F6F4(player) {
  if(istrue(self.started))
    _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565([player], "dmz_elimination_start", undefined, "dmz_elimination_start_classic");
}

_id_792124E8BD5A56C7(player) {
  player setplayermusicstate("");
}

_id_4B91BB084671306D(_id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_elim_assigned", _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  thread _id_6C4E8CEA70BF4B6D::_id_9E357E07833A0D1A(_id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_elimination_start", 1.0, "dmz_elimination_start_classic");

  if(!istrue(self._id_9F3AA3D57FC5ACB5)) {
    if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_assigned_" + scripts\engine\utility::random(["hpt", "hvt"]), _id_FABF84450735DD93, 2.0);
    else
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_assigned_" + self.name, _id_FABF84450735DD93, 2.0);
  } else if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_enemy_generic", _id_FABF84450735DD93, 2.5);
  else
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_enemy", _id_FABF84450735DD93, 2.5);
}

_id_250B27B303AEE1CF(_id_FABF84450735DD93) {
  thread _id_914887DEA271D706(_id_FABF84450735DD93);
}

_id_9AB1E3E53B4B5816(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players)
  player setplayermusicstate("");

  if(!istrue(self._id_0AF8D4CC519C65DE))
    _id_0565A5CA9EEF7C50();
}

_id_BCAD41AB1C2F02B4(_id_B8EBE3F71A08AB40) {
  _id_B8EBE3F71A08AB40 endon("task_ended");
  level endon("game_ended");
  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_5EA1BE154AEB609B))
    _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_5EA1BE154AEB609B _id_03314ADD7998AB13::_id_66DA9365BBFEA8B7();

  _id_25FA090D20D9D23F = undefined;
  _id_34521C3F3A06B3B4 = 0;
  _id_CEB879BBC20E2D82 = undefined;
  origin = self.origin;

  if(_id_6181DE250AFA5BB6 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    _id_25FA090D20D9D23F = _id_6181DE250AFA5BB6.ownerteam;
    _id_34521C3F3A06B3B4 = 1;
  } else if(isPlayer(_id_6181DE250AFA5BB6)) {
    _id_25FA090D20D9D23F = _id_6181DE250AFA5BB6.team;
    _id_34521C3F3A06B3B4 = 1;
  }

  if(isDefined(_id_B8EBE3F71A08AB40.teams[0]))
    _id_CEB879BBC20E2D82 = _id_B8EBE3F71A08AB40 _id_4FDC05FFDA09146E(origin, 300, _id_B8EBE3F71A08AB40.teams[0]);
  else if(isDefined(_id_25FA090D20D9D23F))
    _id_CEB879BBC20E2D82 = _id_B8EBE3F71A08AB40 _id_4FDC05FFDA09146E(origin, 300, _id_25FA090D20D9D23F);

  wait 1;

  if(isDefined(_id_B8EBE3F71A08AB40.teams[0])) {
    if(isDefined(_id_CEB879BBC20E2D82) && _id_CEB879BBC20E2D82.team == _id_B8EBE3F71A08AB40.teams[0]) {
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_B8EBE3F71A08AB40.teams[0]);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_elim_complete", "elim", _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_B8EBE3F71A08AB40.teams[0]);
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_yegor_kia_confirmed", _id_B8EBE3F71A08AB40.teams[0], 2.5);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_B8EBE3F71A08AB40.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      _id_B8EBE3F71A08AB40 thread _id_0565A5CA9EEF7C50(_id_B8EBE3F71A08AB40.teams[0]);
      return;
    } else if(isDefined(_id_25FA090D20D9D23F) && _id_25FA090D20D9D23F == _id_B8EBE3F71A08AB40.teams[0]) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_yegor_killed", _id_B8EBE3F71A08AB40.teams[0], 2.5);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_B8EBE3F71A08AB40.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
    } else {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_enemy", _id_B8EBE3F71A08AB40.teams[0], 2.5);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_B8EBE3F71A08AB40.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
    }

    if(!isDefined(_id_CEB879BBC20E2D82)) {
      _id_B8EBE3F71A08AB40 _id_6FEA61F1F7158926(origin, _id_B8EBE3F71A08AB40.teams[0]);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_elim_complete", "elim", _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_B8EBE3F71A08AB40.teams[0]);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_B8EBE3F71A08AB40.teams[0]);

      if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_confirmed_no_contract_" + scripts\engine\utility::random(["hpt", "hvt"]), _id_B8EBE3F71A08AB40.teams[0], 2.5);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_confirmed_no_contract_" + _id_B8EBE3F71A08AB40.name, _id_B8EBE3F71A08AB40.teams[0], 2.5);

      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_B8EBE3F71A08AB40.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      _id_B8EBE3F71A08AB40 thread _id_0565A5CA9EEF7C50(_id_B8EBE3F71A08AB40.teams[0]);
    }
  } else if(isDefined(_id_25FA090D20D9D23F)) {
    if(isDefined(_id_CEB879BBC20E2D82)) {
      if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_not_assigned_" + scripts\engine\utility::random(["hpt", "hvt"]), _id_25FA090D20D9D23F, 2.5);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_not_assigned_" + _id_B8EBE3F71A08AB40.name, _id_25FA090D20D9D23F, 2.5);

      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_25FA090D20D9D23F, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_25FA090D20D9D23F);
      _id_B8EBE3F71A08AB40 thread _id_0565A5CA9EEF7C50(undefined);
    } else {
      if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_no_contract_no_confirmation_" + scripts\engine\utility::random(["hpt", "hvt"]), _id_25FA090D20D9D23F, 2.5);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_killed_no_contract_no_confirmation_" + _id_B8EBE3F71A08AB40.name, _id_25FA090D20D9D23F, 2.5);

      _id_B8EBE3F71A08AB40 _id_6FEA61F1F7158926(origin, _id_25FA090D20D9D23F);

      if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_confirmed_no_contract_" + scripts\engine\utility::random(["hpt", "hvt"]), _id_25FA090D20D9D23F, 2.5);
      else
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_confirmed_no_contract_" + _id_B8EBE3F71A08AB40.name, _id_25FA090D20D9D23F, 2.5);

      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_25FA090D20D9D23F, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_25FA090D20D9D23F);
      _id_B8EBE3F71A08AB40 thread _id_0565A5CA9EEF7C50();
    }
  }
}

_id_6FEA61F1F7158926(origin, team) {
  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_confirm_kill");
  self._id_9F3AA3D57FC5ACB5 = 1;
  _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(origin + (0, 0, 50));
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();

  for(;;) {
    _id_F0EA4030349A33D5 = _id_4FDC05FFDA09146E(origin, 200, team);

    if(isDefined(_id_F0EA4030349A33D5)) {
      break;
    }

    wait 1;
  }
}

_id_0565A5CA9EEF7C50(_id_EC15CE3E7A9D1D86) {
  self._id_0AF8D4CC519C65DE = 1;
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_EC15CE3E7A9D1D86);
}

_id_4FDC05FFDA09146E(origin, range, team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(distance(player.origin, origin) < range)
      return player;
  }

  return undefined;
}

_id_C704F6B8763D15B4(agent) {
  categories = [1, 2, 3, 4];

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    categories = ["1_sealion", "2_sealion", "3_sealion", "4_sealion"];
  else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    categories = ["1_delta", "2_delta", "3_delta", "4_delta"];

  weights = [level._id_97818B2FA3F29568._id_B68C2A8C7C682857, level._id_97818B2FA3F29568._id_92304CBE2F72AE5C, level._id_97818B2FA3F29568._id_CAAD6EDA57CD258D, level._id_97818B2FA3F29568._id_D930BD12AA1FD3F2];
  _id_5EDDC5152A128D55 = _id_57D3850A12CF1D8F::_id_F4C3A9C8DA53FBC9(categories, weights, 20, 60, 20);

  if(isDefined(_id_5EDDC5152A128D55))
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, _id_5EDDC5152A128D55);

  _id_48814951E916AF89::_id_63A043D47490F90D(agent, undefined, 8395, undefined, 50);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "loot_key_fortress", undefined, 0.35);
}

_id_914887DEA271D706(_id_FABF84450735DD93) {
  level endon("game_ended");
  self endon("task_ended");

  for(;;) {
    wait 1;

    if(!isDefined(self.enemy)) {
      continue;
    }
    if(!isalive(self.enemy)) {
      return;
    }
    _id_4C66C3B205357C89(self.enemy.origin, _id_FABF84450735DD93);
  }
}

_id_47EF6B3F2A53E9C1() {
  level endon("game_ended");
  self endon("task_ended");
  self.enemy endon("death");

  for(;;) {
    circle = self._id_B0F4BF8621B96C0A[0].mapcircle.origin;
    radius = circle[2];
    origin = (circle[0], circle[1], 0);
    dist = distance2dsquared(self.enemy.origin, origin);

    if(dist > level._id_97818B2FA3F29568.circleradius * level._id_97818B2FA3F29568.circleradius) {
      _id_79B9C85900392AD6 = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self.enemy.origin, level._id_97818B2FA3F29568.circleradius);
      _id_78EEA6F74E9C5481 = (_id_79B9C85900392AD6[0], _id_79B9C85900392AD6[1], radius);
      self._id_B0F4BF8621B96C0A[0].mapcircle moveTo(_id_78EEA6F74E9C5481, 1.0, 0.25, 0.25);
      _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE((_id_79B9C85900392AD6[0], _id_79B9C85900392AD6[1], self.enemy.origin[2] + 300));
    }

    wait 1.0;
  }
}

_id_4C66C3B205357C89(_id_40963CE79D073E53, _id_FABF84450735DD93) {
  if(!istrue(self._id_47CAA213EFE9FD6A)) {
    players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(player in players) {
      if(isalive(player) && distancesquared(player.origin, _id_40963CE79D073E53) < 1000000) {
        self._id_47CAA213EFE9FD6A = 1;
        player thread _id_46E515BF7F51FC5A(self.enemy.origin, _id_FABF84450735DD93);

        if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
          thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_near_generic", _id_FABF84450735DD93, 2.0);
        else
          thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("elim_target_near", _id_FABF84450735DD93, 2.0);

        break;
      }
    }
  }
}

_id_46E515BF7F51FC5A(_id_40963CE79D073E53, _id_FABF84450735DD93) {
  if(!istrue(self._id_1DC3B597975D2719)) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
    _id_EF269077A28646EB = [];

    foreach(player in _id_A6AB8D0FDA441DC2) {
      if(isalive(player) && distancesquared(player.origin, _id_40963CE79D073E53) < 2250000) {
        _id_EF269077A28646EB[_id_EF269077A28646EB.size] = player;
        player._id_1DC3B597975D2719 = 1;
      }
    }

    _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_EF269077A28646EB, "dmz_elimination_approach", 0.0, "dmz_elimination_approach_classic");
  }
}

_id_3FA9AA825ADA06DD() {
  _id_289245099AF802F6 = scripts\engine\utility::random(["brloot_weapon_ar_akilo105_epic", "brloot_weapon_ar_mike4_rare", "brloot_weapon_ar_scharlie_elim_hvt"]);
  return level.br_lootiteminfo[_id_289245099AF802F6].fullweaponobj;
}

_id_0E9591DF01126977(target, _id_6C8EE20B233CA1AA) {
  _id_BD0799062EAD03A4 = scripts\engine\utility::getStructArray(target, "targetname");
  _id_F78A17463EEBCB84 = [];
  _id_D4B9E030F49735D5 = level._id_97818B2FA3F29568._id_FBBE0ADF8216FE9A + level._id_97818B2FA3F29568._id_0C46BEAE1FD1C519 + level._id_97818B2FA3F29568._id_8EBBA99852AA5265;
  _id_B8DA46C98DAD35FA = level._id_97818B2FA3F29568._id_FBBE0ADF8216FE9A / _id_D4B9E030F49735D5;
  _id_7AC6D26C235B0601 = level._id_97818B2FA3F29568._id_0C46BEAE1FD1C519 / _id_D4B9E030F49735D5 + _id_B8DA46C98DAD35FA;
  _id_25BAF6DC730B79AD = level._id_97818B2FA3F29568._id_8EBBA99852AA5265 / _id_D4B9E030F49735D5;
  _id_FEE76566EDC91600 = _id_48814951E916AF89::_id_9B6306B0CD33BD79(self.node.origin);

  foreach(node in _id_BD0799062EAD03A4) {
    _id_00AE14C5A8B1B582 = randomfloat(1.0);
    spawnset = "guard";
    _id_1439F86640D42E34 = undefined;
    tier = _id_FEE76566EDC91600 + 1;

    if(_id_00AE14C5A8B1B582 < _id_B8DA46C98DAD35FA) {} else if(_id_00AE14C5A8B1B582 < _id_7AC6D26C235B0601)
      tier = _id_FEE76566EDC91600;
    else {
      _id_1439F86640D42E34 = "strikeunit";
      tier = _id_FEE76566EDC91600 + 1;
    }

    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, spawnset, _id_1439F86640D42E34, tier);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, "high", "mission", "elimGuards", undefined, undefined, undefined, undefined, 0);

    if(isDefined(agent))
      _id_F78A17463EEBCB84[_id_F78A17463EEBCB84.size] = agent;
  }

  return _id_F78A17463EEBCB84;
}

_id_C393B86B6A285ACF() {
  if(!isDefined(level._id_A5D60AB4A5489C7F))
    level._id_A5D60AB4A5489C7F = 0;

  names = ["machado", "crybaby", "montoya", "navarro", "estrada", "romero", "toreador", "chavez"];
  name = names[level._id_A5D60AB4A5489C7F % names.size];
  level._id_A5D60AB4A5489C7F++;
  return name;
}

_id_49F737A7C10FB88F() {
  self endon("death");

  for(;;) {
    if(getdvarint("dvar_BEEA5652FD628E2E", 0) == 1) {
      if(isalive(self))
        thread scripts\mp\utility\debug::drawsphere(self.origin, 64, 1.0, (1, 0, 1));
    }

    wait 1.0;
  }
}