/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\overlord.gsc
***********************************************/

init() {
  if(scripts\common\utility::ismp()) {
    if(getDvar("dvar_7611A2790A0BF7FE", "br") != "dmz") {
      return;
    }
    if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
      return;
  }

  level._id_07F5DBF6CA6A4468 = spawnStruct();
  level._id_07F5DBF6CA6A4468.events = [];
  level._id_60FC087BC7DEAADC = ::_id_60FC087BC7DEAADC;
  level thread _id_2B7B925F1037E020();
  level._id_07F5DBF6CA6A4468._id_F122D73BB796754C = getdvarint("dvar_99EE36F514CFDC16", 3);

  if(getdvarint("dvar_B1DBB741DA6AA657", 0) == 1)
    level thread _id_96E4F7AC9D0F56E4();

  if(getdvarint("scr_overlord_enemy_proximity_enabled", 1) && scripts\common\utility::ismp())
    level thread _id_B0C21EABFFCE3FD4();
}

_id_2B7B925F1037E020() {
  _id_A4F08903B38D314B = getDvar("dvar_97EFDE55DF4BCCCD", "mp_cp/overlord_dmz.csv");
  scripts\mp\flags::levelflaginit("overlord_csv_init", 0);
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow(_id_A4F08903B38D314B, _id_CB89110314447B2F, 0);

    if(ref == "") {
      break;
    }

    alias = tablelookupbyrow(_id_A4F08903B38D314B, _id_CB89110314447B2F, 1);
    priority = int(tablelookupbyrow(_id_A4F08903B38D314B, _id_CB89110314447B2F, 2));
    cooldown = int(tablelookupbyrow(_id_A4F08903B38D314B, _id_CB89110314447B2F, 3));
    timeout = lookupsoundlength(alias, 1) / 1000 + 2;
    _id_780B7B802E71FD94(ref, alias, priority, cooldown, timeout);
    _id_CB89110314447B2F++;
  }

  scripts\mp\flags::levelflagset("overlord_csv_init");
}

_id_96E4F7AC9D0F56E4() {
  scripts\mp\flags::levelflagwait("overlord_csv_init");

  for(;;) {
    _id_D87D5DEB069BF8E5("player_civ_kill_third_warning", [level.players[0]]);
    wait 1.0;
    _id_D87D5DEB069BF8E5("player_civ_kill_frst_warning", [level.players[0]]);
    wait 1.0;
    _id_D87D5DEB069BF8E5("player_civ_kill_second_warning", [level.players[0]]);
    wait 5.0;
  }
}

_id_780B7B802E71FD94(ref, alias, priority, cooldown, timeout) {
  event = spawnStruct();
  event.ref = ref;
  event.alias = alias;
  event.priority = priority;
  event.cooldown = cooldown * 1000;
  event.timeout = timeout;
  level._id_07F5DBF6CA6A4468.events[ref] = event;
}

_id_D87D5DEB069BF8E5(eventref, players, delay, _id_3BE94FC7D74BC059) {
  if(!isDefined(level._id_07F5DBF6CA6A4468))
    return 0;

  if(isDefined(delay))
    wait(delay);

  event = level._id_07F5DBF6CA6A4468.events[eventref];

  if(!isDefined(event))
    return 0;

  if(!soundexists(event.alias))
    return 0;

  foreach(player in players) {
    if(!isalive(player) && !istrue(_id_3BE94FC7D74BC059)) {
      continue;
    }
    player _id_D453707F6B8F2C6D();

    if(!player _id_8C3011DCCACE47C4(eventref)) {
      continue;
    }
    _id_A98FC745A78358C9 = player _id_17C324959B47A339(event);
    player queuedialogforplayer(event.alias, event.alias, event.timeout, "overlord", _id_A98FC745A78358C9);
    player._id_5A2916F745D4389A[eventref] = gettime();
  }

  return 1;
}

_id_9793A81BC3BC19E9(eventref, team, delay) {
  if(isDefined(delay))
    wait(delay);

  players = level.players;

  if(isDefined(team)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
      players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](team, "players");
  }

  _id_D87D5DEB069BF8E5(eventref, players);
}

_id_8C3011DCCACE47C4(eventref) {
  if(isDefined(self._id_36C21C8D1AE71882) && level._id_07F5DBF6CA6A4468.events[eventref].priority < self._id_36C21C8D1AE71882)
    return 0;

  return !scripts\engine\utility::array_contains_key(self._id_5A2916F745D4389A, eventref);
}

_id_D453707F6B8F2C6D() {
  if(!isDefined(self._id_5A2916F745D4389A)) {
    self._id_5A2916F745D4389A = [];
    return;
  }

  _id_BF0609730FEBA76C = [];
  currenttime = gettime();

  foreach(eventref, time in self._id_5A2916F745D4389A) {
    if(time + level._id_07F5DBF6CA6A4468.events[eventref].cooldown < currenttime)
      _id_BF0609730FEBA76C[eventref] = time;
  }

  foreach(eventref, time in _id_BF0609730FEBA76C)
  self._id_5A2916F745D4389A[eventref] = undefined;
}

_id_50EBF0029301BE3F(player, eventref) {
  if(!isDefined(player._id_5A2916F745D4389A))
    return 0;

  if(!isDefined(player._id_5A2916F745D4389A[eventref]))
    return 0;

  if(!isDefined(level._id_07F5DBF6CA6A4468.events[eventref]))
    return 0;

  if(!isDefined(level._id_07F5DBF6CA6A4468.events[eventref].cooldown))
    return 0;

  _id_B4C04337A6A90C84 = player._id_5A2916F745D4389A[eventref];
  cooldowntime = level._id_07F5DBF6CA6A4468.events[eventref].cooldown;
  currenttime = gettime();
  return _id_B4C04337A6A90C84 + cooldowntime >= currenttime;
}

_id_17C324959B47A339(event) {
  foreach(eventref, time in self._id_5A2916F745D4389A) {
    _id_E0CF0C68C0BFFA13 = time + level._id_07F5DBF6CA6A4468.events[eventref].timeout * 1000 + lookupsoundlength(level._id_07F5DBF6CA6A4468.events[eventref].alias, 1);

    if(_id_E0CF0C68C0BFFA13 && event.priority <= level._id_07F5DBF6CA6A4468.events[eventref].priority)
      return 0;
  }

  return 1;
}

_id_4831C2AA1655CE23(player) {
  _id_D90809392748E640 = player _id_098B53A7358927D9::_id_87072B42853A9C58("specialty_pc_stealth");
  return !istrue(_id_D90809392748E640);
}

isvalidplayer(player) {
  _id_D1B01CA13019C169 = 1;

  if(isDefined(level._id_76EBA5FACACD254B) && isfunction(level._id_76EBA5FACACD254B))
    _id_D1B01CA13019C169 = [[level._id_76EBA5FACACD254B]](player);

  return isDefined(player) && isDefined(player.team) && isDefined(player.origin) && isalive(player) && !isDefined(player.fauxdead) && !istrue(player.delayedspawnedplayernotify) && istrue(_id_D1B01CA13019C169);
}

_id_B0C21EABFFCE3FD4() {
  _id_DEB4634FF3CFF859 = getdvarint("scr_overlord_enemy_proximity_radius", 4096);
  _id_DEB4634FF3CFF859 = _id_DEB4634FF3CFF859 * _id_DEB4634FF3CFF859;
  _id_5CC086A792B04FCE = getdvarfloat("dvar_32244D6ACF101808", 60.0);
  _id_A93508890D2545D1 = [];

  foreach(team in level.teamnamelist)
  _id_A93508890D2545D1[team] = [];

  for(;;) {
    validplayers = [];

    foreach(player in level.players) {
      if(isvalidplayer(player))
        validplayers[validplayers.size] = player;
    }

    _id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28(validplayers, 2500);

    foreach(player in validplayers) {
      if(!isvalidplayer(player)) {
        continue;
      }
      foreach(_id_BAB0D10E51188531 in _id_2B6807C7DF9A2B2D scripts\engine\utility::_id_0DF633F460888A47(player.origin)) {
        foreach(_id_F7632B4589B2BED4 in _id_BAB0D10E51188531) {
          if(!isvalidplayer(_id_F7632B4589B2BED4) || !_id_4831C2AA1655CE23(_id_F7632B4589B2BED4)) {
            continue;
          }
          if(player.team == _id_F7632B4589B2BED4.team || distancesquared(player.origin, _id_F7632B4589B2BED4.origin) > _id_DEB4634FF3CFF859) {
            continue;
          }
          _id_BA24B605D8B9C100 = _id_F240C299B9341E8F(player, _id_F7632B4589B2BED4, _id_A93508890D2545D1, _id_5CC086A792B04FCE);

          if(_id_BA24B605D8B9C100) {
            _id_C1D6D0EDD4194945 = _id_098B53A7358927D9::_id_9563F2D4E690856D(_id_F7632B4589B2BED4.team, "players");
            _id_83F8BFE8C7A7EE0B = _id_098B53A7358927D9::_id_9563F2D4E690856D(player.team, "players");
            _id_571AEAF27DBB7E22 = [];

            foreach(player in _id_83F8BFE8C7A7EE0B) {
              if(getdvarint("dvar_C53AFAEA3F55391A", 0) && player _id_098B53A7358927D9::_id_87072B42853A9C58("specialty_pc_comms")) {
                continue;
              }
              _id_571AEAF27DBB7E22[_id_571AEAF27DBB7E22.size] = player;
            }

            _id_D87D5DEB069BF8E5(scripts\engine\utility::ter_op(_id_C1D6D0EDD4194945.size > level._id_07F5DBF6CA6A4468._id_F122D73BB796754C, "nearby_big_team", "player_enemy_player_nearby"), _id_571AEAF27DBB7E22);
            _id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team] = gettime();
          }
        }
      }

      waitframe();
    }

    wait 3;
  }
}

_id_AEA00C3815B226DA(player) {
  player notify("monitor_enemy_prox");
  player endon("disconnect");
  player endon("death");
  level endon("game_ended");
  player endon("monitor_enemy_prox");
  _id_DEB4634FF3CFF859 = getdvarint("scr_overlord_enemy_proximity_radius", 4096);
  _id_DEB4634FF3CFF859 = _id_DEB4634FF3CFF859 * _id_DEB4634FF3CFF859;
  _id_5CC086A792B04FCE = getdvarfloat("dvar_32244D6ACF101808", 60.0);
  _id_A93508890D2545D1 = [];

  foreach(team in level.teamnamelist)
  _id_A93508890D2545D1[team] = [];

  for(;;) {
    validplayers = [];

    foreach(validplayer in level.players) {
      if(isvalidplayer(validplayer))
        validplayers[validplayers.size] = validplayer;
    }

    _id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28(validplayers, 2500);

    foreach(_id_BAB0D10E51188531 in _id_2B6807C7DF9A2B2D scripts\engine\utility::_id_0DF633F460888A47(player.origin)) {
      foreach(_id_F7632B4589B2BED4 in _id_BAB0D10E51188531) {
        if(!isvalidplayer(_id_F7632B4589B2BED4) || !_id_4831C2AA1655CE23(_id_F7632B4589B2BED4)) {
          continue;
        }
        if(player.team == _id_F7632B4589B2BED4.team || distancesquared(player.origin, _id_F7632B4589B2BED4.origin) > _id_DEB4634FF3CFF859) {
          continue;
        }
        _id_BA24B605D8B9C100 = !isDefined(_id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team]) || (gettime() - _id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team]) / 1000 > _id_5CC086A792B04FCE;

        if(_id_BA24B605D8B9C100) {
          _id_C1D6D0EDD4194945 = _id_098B53A7358927D9::_id_9563F2D4E690856D(_id_F7632B4589B2BED4.team, "players");
          _id_D87D5DEB069BF8E5(scripts\engine\utility::ter_op(_id_C1D6D0EDD4194945.size > level._id_07F5DBF6CA6A4468._id_F122D73BB796754C, "nearby_big_team", "player_enemy_player_nearby"), [player]);
          _id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team] = gettime();
        }
      }
    }

    wait 3;
  }
}

_id_60FC087BC7DEAADC(val) {
  self._id_36C21C8D1AE71882 = val;
}

_id_2C722A2EF9574E87(players, tag, priority) {
  foreach(player in players)
  player _id_3B64EB40368C1450::set(tag, "overlord_locked_priority", priority);
}

_id_70979C1EABF04180(players, tag) {
  foreach(player in players)
  player _id_3B64EB40368C1450::_id_462E6336A0DC84A8(tag, "overlord_locked_priority");
}

_id_F240C299B9341E8F(player, _id_F7632B4589B2BED4, _id_A93508890D2545D1, _id_5CC086A792B04FCE) {
  _id_BA24B605D8B9C100 = !isDefined(_id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team]) || (gettime() - _id_A93508890D2545D1[player.team][_id_F7632B4589B2BED4.team]) / 1000 > _id_5CC086A792B04FCE;

  if(getdvarint("dvar_C53AFAEA3F55391A", 0)) {
    _id_C1D6D0EDD4194945 = _id_098B53A7358927D9::_id_9563F2D4E690856D(_id_F7632B4589B2BED4.team, "players");
    return _id_BA24B605D8B9C100 && _id_C1D6D0EDD4194945.size > level._id_07F5DBF6CA6A4468._id_F122D73BB796754C;
  }

  return _id_BA24B605D8B9C100;
}