/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_358978e883d9f6c2.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_963BA76EE083D599 = spawnStruct();
  level._id_963BA76EE083D599.circleradius = getdvarint("dvar_A3F5F94B78758C13", 2000);
  level._id_963BA76EE083D599._id_E3AA1DE9D96E0086 = getdvarint("dvar_D411B19DD9E74816", 500);
  level._id_963BA76EE083D599._id_0DB715BCDE296BEC = getdvarint("dvar_F1A4AB2D08EA3F3A", 35);
  level._id_963BA76EE083D599._id_BF9C07649959C8CB = getdvarint("dvar_1602179CC49067FD", 1000);
  level._id_963BA76EE083D599._id_24972DB4C00B613B = level._id_963BA76EE083D599._id_BF9C07649959C8CB * level._id_963BA76EE083D599._id_BF9C07649959C8CB;
  level._id_963BA76EE083D599._id_ED2E5CF91BFF3A6F = getdvarfloat("dvar_A1E11094B3A508FC", 0.65);
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_4D5D3ED9256EBCAE, getunusedlootcachepoints());
}

_id_4D5D3ED9256EBCAE(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_9550D61DA5A80965;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_8E898C0492B6FF3A;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_E1AA660996368877;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_C9FB9A277040987E;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_4AD8BD3E796C1B2A;
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.ref = "dmz_search";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_40DBDB41F33299F7 = 0;
  return _id_B8EBE3F71A08AB40;
}

_id_9550D61DA5A80965() {
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  _id_79B9C85900392AD6 = _id_8AFFC7DCDC682B36(self.node);
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Explore_Dmz", [_id_79B9C85900392AD6], level._id_963BA76EE083D599.circleradius);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(_id_79B9C85900392AD6);
  self.circlecenter = _id_79B9C85900392AD6;
  self.circleradius = level._id_963BA76EE083D599.circleradius;
  thread _id_686CA280FF7B1A60();
  _id_E7F010F72A055377(self.node.origin, self.node.angles, self);
}

_id_8E898C0492B6FF3A(_id_FABF84450735DD93) {
  scripts\mp\utility\dialog::leaderdialog("dmz_mission_search_assigned", _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_65A2513D3692EA1A(_id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  _id_6C4E8CEA70BF4B6D::_id_C573D8A23F7FAF06(self._id_B038ED928EC17A81, [_id_FABF84450735DD93]);
}

_id_E1AA660996368877(player) {
  _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
  self._id_B038ED928EC17A81 enablescriptableplayeruse(player);
}

_id_C9FB9A277040987E(player) {
  _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  self._id_B038ED928EC17A81 disablescriptableplayeruse(player);
}

_id_4AD8BD3E796C1B2A(_id_FABF84450735DD93) {}

_id_1A3230D55BB4D008(_id_FABF84450735DD93) {
  self notify("task_ended");
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  foreach(team in self.teams) {
    _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_search_complete", team);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  }
}

_id_7554F9EE8A843336(instance, player) {
  instance._id_B8EBE3F71A08AB40 _id_1A3230D55BB4D008(player.team);
  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_6F6F83AB76483811(instance, player);
}

_id_E7F010F72A055377(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6, _id_B8EBE3F71A08AB40) {
  _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache", _id_7E05C139FBBD8374, _id_5B9C864B21207FF6);
  _id_B038ED928EC17A81 setscriptablepartstate("body", "open");
  _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40._id_B038ED928EC17A81 = _id_B038ED928EC17A81;
  _id_B038ED928EC17A81.contents = [];
  _id_B038ED928EC17A81.contents[0]["quantity"] = 1;
  _id_B038ED928EC17A81.contents[0]["lootID"] = 8608;
  _id_B038ED928EC17A81.contents[0]["callback"] = ::_id_7554F9EE8A843336;
  _id_B038ED928EC17A81.contents[1]["quantity"] = 50;
  _id_B038ED928EC17A81.contents[1]["lootID"] = 8395;
}

_id_092DB4F6A28F9685(opener, _id_69E96A4CAA72D794) {
  return _id_6C4E8CEA70BF4B6D::_id_8158903A6E2F32FD(_id_69E96A4CAA72D794._id_B8EBE3F71A08AB40, opener);
}

_id_8AFFC7DCDC682B36(location) {
  return location.origin + scripts\engine\utility::_id_6174330574A2A273() * level._id_963BA76EE083D599.circleradius;
}

_id_C373F127DAFC389A(team) {
  level endon("game_ended");
  self endon("task_ended");

  if(getdvarint("dvar_02A539568E55A221", 0)) {
    return;
  }
  wait 2.0;

  if(isDefined(self.objidnum))
    objective_setplayintro(self.objidnum, 0);

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  for(;;) {
    _id_C0D6A48951EAA35E = 0;

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      _id_8C64FAA69E531014 = distance2dsquared(player.origin, self.circlecenter);

      if(_id_8C64FAA69E531014 <= self.circleradius * self.circleradius) {
        _id_C0D6A48951EAA35E = 1;
        _id_02E9225DC26A7C8A = [];

        foreach(point in self.points) {
          _id_C2DA92F3A0A86861 = distance2dsquared(player.origin, point);

          if(_id_C2DA92F3A0A86861 < self.circleradius * self.circleradius * level._id_963BA76EE083D599._id_ED2E5CF91BFF3A6F) {
            _id_2EE77C55C3E4AFB5 = distance2dsquared(point, self.circlecenter);

            if(_id_8C64FAA69E531014 < _id_2EE77C55C3E4AFB5)
              continue;
          }

          _id_02E9225DC26A7C8A[_id_02E9225DC26A7C8A.size] = point;
        }

        self.points = _id_02E9225DC26A7C8A;
      }
    }

    wait 1.0;
  }
}

_id_686CA280FF7B1A60() {
  level endon("game_ended");
  self endon("task_ended");

  if(getdvarint("dvar_02A539568E55A221", 0)) {
    return;
  }
  self.points = [];
  _id_6D395A31C3C0CE80 = 2.61792;
  _id_25C47B2199752C52 = sqrt(level._id_963BA76EE083D599._id_0DB715BCDE296BEC);

  for(pointindex = 0.0; pointindex < level._id_963BA76EE083D599._id_0DB715BCDE296BEC; pointindex = pointindex + 1.0) {
    radius = sqrt(pointindex) / _id_25C47B2199752C52 * level._id_963BA76EE083D599.circleradius;
    angle = 360.0 * pointindex / _id_6D395A31C3C0CE80;
    offset = (radius * cos(angle), radius * sin(angle), 0.0);
    point = self.circlecenter + offset;
    self.points[self.points.size] = point;
  }

  for(;;) {
    _id_D38BB255D7409A76 = self.points;
    _id_D38BB255D7409A76[_id_D38BB255D7409A76.size] = self.node.origin;
    circle = _id_6A93240E9338FDB9(_id_D38BB255D7409A76, self.node.origin[2]);

    if(circle[1] + level._id_963BA76EE083D599._id_E3AA1DE9D96E0086 < self.circleradius)
      thread _id_C1AE6352210D1C54(circle[0], circle[1] + level._id_963BA76EE083D599._id_E3AA1DE9D96E0086, 0.8);

    wait 1.0;
  }
}

_id_C1AE6352210D1C54(_id_DA9544331D11402C, _id_A66785EDEC9E567B, duration) {
  level endon("game_ended");
  self endon("task_ended");
  time = 0;

  while(time < duration) {
    time = time + level.framedurationseconds;
    frac = time / duration;
    pos = vectorlerp(self.circlecenter, _id_DA9544331D11402C, frac);
    _id_CB920E03144E9344 = (_id_A66785EDEC9E567B - self.circleradius) * frac + self.circleradius;
    self._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(pos);
    self._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(_id_CB920E03144E9344);
    _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(pos + (0, 0, 750));
    waitframe();
  }

  self.circlecenter = _id_DA9544331D11402C;
  self.circleradius = _id_A66785EDEC9E567B;
}

_id_6A93240E9338FDB9(points, height) {
  _id_3C590D0EE220B409 = points[0][0];
  _id_C978C90E8E5AB1F7 = points[0][0];
  _id_3C590C0EE220B1D6 = points[0][1];
  _id_C978C80E8E5AAFC4 = points[0][1];

  foreach(point in points) {
    if(_id_3C590D0EE220B409 > point[0])
      _id_3C590D0EE220B409 = point[0];

    if(_id_C978C90E8E5AB1F7 < point[0])
      _id_C978C90E8E5AB1F7 = point[0];

    if(_id_3C590C0EE220B1D6 > point[1])
      _id_3C590C0EE220B1D6 = point[1];

    if(_id_C978C80E8E5AAFC4 < point[1])
      _id_C978C80E8E5AAFC4 = point[1];
  }

  center = ((_id_C978C90E8E5AB1F7 + _id_3C590D0EE220B409) / 2, (_id_C978C80E8E5AAFC4 + _id_3C590C0EE220B1D6) / 2, height);
  radiussq = 0;

  foreach(point in points) {
    distsq = distance2dsquared(center, point);

    if(radiussq <= distsq)
      radiussq = distsq;
  }

  return [center, sqrt(radiussq)];
}