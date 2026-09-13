/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_analytics.gsc
*************************************************/

branalytics_init() {
  if(isDefined(level.matchdata_br_onmatchstart)) {
    return;
  }
  if(!0 && !1) {
    return;
  }
  if(!branalytics_validation()) {
    return;
  }
  scripts\cp_mp\utility\script_utility::registersharedfunc("analytics", "agent_alloc", ::_id_8E6652060309B9DB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("analytics", "agent_spawn", ::_id_252E45FC60E2A731);
  scripts\cp_mp\utility\script_utility::registersharedfunc("analytics", "agent_killed", ::_id_0E3AEF4FCB303CFF);
  level.matchdata_br_onmatchstart = ::onmatchstartbr;
  level.delayedeventtypes = [];
  level._id_47BE1D1BB3B425A6 = getdvarint("dvar_6169803D232444FF", 0);

  if(1) {
    level._id_47BE1D1BB3B425A6 = 1;
    analyticsreset();
  }

  level thread _id_C523B31DD9DC82D0();
  level thread _id_D5DB49ED7A7D77C5();
  level thread _id_A16656B5F9493D2C();
  level thread _id_7635473A21A12DC3();
}

_id_D54188D94E97379C(info, _id_80ED4D4A2AAF5D44) {
  if(isdedicatedserver())
    setDvar("dvar_BD87B6EF2DA571DB", info);

  if(istrue(_id_80ED4D4A2AAF5D44))
    logstring("[KEY_MOMENT] " + info);
}

_id_A16656B5F9493D2C() {
  level endon("game_ended");
  _id_D54188D94E97379C("prematch_waiting");
  level waittill("match_start_timer_beginning");
  wait 1;
  _id_D54188D94E97379C("prematch_countdown begin", 1);

  while(isDefined(level.matchcountdowntime)) {
    _id_D54188D94E97379C("prematch_countdown " + level.matchcountdowntime);
    wait 1;
  }

  _id_D54188D94E97379C("prematch_cinematic begin", 1);
  wait 2;

  while(istrue(level.infilcinematicactive))
    wait 1;

  _id_D54188D94E97379C("prematch_cinematic end", 1);
  wait 1;

  for(;;) {
    circleindex = 0;
    aliveplayers = 0;
    _id_348A980D5B1B2325 = 0;

    foreach(team in level.teamnamelist) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

      if(_id_A6AB8D0FDA441DC2 > 0) {
        aliveplayers = aliveplayers + _id_A6AB8D0FDA441DC2;
        _id_348A980D5B1B2325 = _id_348A980D5B1B2325 + 1;
      }
    }

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
      circleindex = level.br_circle.circleindex;

    info = "circle=" + circleindex + " alive=" + aliveplayers + " squads=" + _id_348A980D5B1B2325;
    _id_D54188D94E97379C(info);
    wait 10;
  }
}

_id_BD6274FAD1216B30() {
  level endon("game_cleanup");
  level waittill("br_ending_start");
  _id_D54188D94E97379C("game_ended, watching exfil", 1);
}

_id_7635473A21A12DC3() {
  level thread _id_BD6274FAD1216B30();
  level waittill("game_ended");
  _id_D54188D94E97379C("game_ended, watching final kill", 1);
  wait 1.5;
  _id_D54188D94E97379C("game_ended, watching splash", 1);

  if(isDefined(level.br_ending_delay))
    wait(level.br_ending_delay);

  level waittill("round_end_finished");
  _id_D54188D94E97379C("game_ended, round_end_finished", 1);
  level waittill("game_cleanup");
  _id_D54188D94E97379C("game_ended, game_cleanup", 1);
}

_id_D5DB49ED7A7D77C5() {
  level endon("game_ended");

  if(!isdedicatedserver()) {
    return;
  }
  level waittill("spawn_brStrongholdSpawn");
  wait 30;
  _func_AA2A76E5B30B25DA("br_peak", 30);
  wait 31;
  maxplayers = getdvarint("party_maxplayers", 0);
  _id_D12A341B40354143 = scripts\engine\utility::getintorzero(level.players.size);

  if(_id_D12A341B40354143 > maxplayers - 20 || getdvarint("dvar_CD9D15D61F6E2380", 0) > 0) {
    _func_EFAAB797904D13E8("br_peak", 1);
    wait 2;
  }

  if(getdvarint("br_endmatchaftercapture", 0) > 0 && isDefined(level._id_B9C50A4FD9223CC7)) {
    logstring("br_endMatchAfterCapture");
    self thread[[level._id_B9C50A4FD9223CC7]](level.brgametype.firstteam, game["end_reason"]["objective_completed"]);
  }
}

_id_C523B31DD9DC82D0() {
  level endon("game_ended");
  level._id_D984DA21AF3906B9 = 0;
  level waittill("prematch_done");
  level._id_D984DA21AF3906B9 = 1;
  humans = 0;
  bots = 0;
  _id_8C23DE1E5DAAC192 = 0;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isbot(player) || istestclient(player)) {
      bots = bots + 1;
      _branalytics_addevent("player_spawned", player getorigin(), 0, "", player);
      continue;
    }

    if(player isplayerheadless()) {
      _id_8C23DE1E5DAAC192 = _id_8C23DE1E5DAAC192 + 1;
      _branalytics_addevent("player_spawned", player getorigin(), 13, "", player);
      continue;
    }

    humans = humans + 1;
    _branalytics_addevent("player_spawned", player getorigin(), 0, "", player);
  }

  logstring("[KEY_MOMENT] Prematch Done");
  logstring("=============================================");
  logstring("bots = " + bots);
  logstring("headless = " + _id_8C23DE1E5DAAC192);
  logstring("humans = " + humans);
  logstring("=============================================");
  _id_4DF1E1A017254690 = _branalytics_geteventtimestamp();
  _id_BB96ECD805545B2E("prematch_done", (0, 0, 0), 0, int(_id_4DF1E1A017254690), "", 0);
  _id_DFEE9DAD130C9312 = -3;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters)) {
    time = _id_4DF1E1A017254690;
    _id_209967C144016964 = level.br_level.br_circleradii.size;
    _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();
    _branalytics_addevent("multiCircleCount", (0, 0, 0), _id_C669C821EE772A3D);

    for(circleindex = 0; circleindex < _id_209967C144016964 - 1; circleindex++) {
      radius = level.br_level.br_circleradii[circleindex];
      _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex] * 1000;
      _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex] * 1000;

      if(_id_C669C821EE772A3D > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
          _id_DFA00CE7873DF6DD = time;
          origin = level._id_B31733F431ED12E0._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[circleindex];
          _id_BB96ECD805545B2E("circle" + scripts\engine\utility::string(_id_AC0E594AC96AA3A8), origin, int(radius), int(_id_DFA00CE7873DF6DD), "start", _id_DFEE9DAD130C9312 - _id_AC0E594AC96AA3A8);
          _id_DFA00CE7873DF6DD = _id_DFA00CE7873DF6DD + _id_3702CBA57F844507;
          _id_BB96ECD805545B2E("circle" + scripts\engine\utility::string(_id_AC0E594AC96AA3A8), origin, int(radius), int(_id_DFA00CE7873DF6DD), "close", _id_DFEE9DAD130C9312 - _id_AC0E594AC96AA3A8);
        }

        time = time + _id_3702CBA57F844507;
        time = time + _id_3D8565E2775A243C;
        continue;
      }

      origin = level.br_level.br_circlecenters[circleindex];

      if(isDefined(_id_3702CBA57F844507) && isDefined(_id_3D8565E2775A243C)) {
        _id_BB96ECD805545B2E("circle", origin, int(radius), int(time), "start", _id_DFEE9DAD130C9312);
        time = time + _id_3702CBA57F844507;
        _id_BB96ECD805545B2E("circle", origin, int(radius), int(time), "close", _id_DFEE9DAD130C9312);
        time = time + _id_3D8565E2775A243C;
      }
    }
  }
}

_branalytics_addeventallowed() {
  if(!branalytics_validation())
    return 0;

  return isDefined(level.delayedeventtypes);
}

_branalytics_geteventtimestamp() {
  time = gettime();
  return time;
}

_id_BB96ECD805545B2E(type, origin, state, time, data, entnum) {
  if(!istrue(level._id_D984DA21AF3906B9)) {
    return;
  }
  if(!isDefined(data) || !isstring(data))
    data = "";

  if(1)
    analyticsaddevent(origin, type, state, time, data, entnum);

  if(0 && type != "breadcrumb")
    logstring("[GAE]," + time + "," + entnum + "," + origin[0] + "," + origin[1] + "," + type + "," + state + "," + data);
}

_branalytics_addevent(type, origin, state, data, ent) {
  if(!isDefined(origin))
    origin = (0, 0, 0);

  if(!isDefined(state))
    state = 0;

  if(!isDefined(data))
    data = "";

  entnum = -1;

  if(isDefined(ent))
    entnum = ent getentitynumber();

  time = _branalytics_geteventtimestamp();
  _id_BB96ECD805545B2E(type, origin, state, time, data, entnum);

  if(isDefined(ent))
    ent _id_F183D915239368B7(time);
}

_id_A48BE354E2F41DB9(type, ent) {
  if(!isDefined(ent)) {
    return;
  }
  _branalytics_addevent(type, ent.origin, 0, "", ent);
}

_id_EEFAA754FC189980(type, ent, state, data) {
  if(!isDefined(ent)) {
    return;
  }
  _branalytics_addevent(type, ent.origin, state, data, ent);
}

_getdeathstatecode(deathtype) {
  if(!isDefined(deathtype))
    return -1;

  switch (deathtype) {
    case "deathType_switchingTeams":
      data = 6;
      break;
    case "deathType_worldDeath":
      data = 3;
      break;
    case "deathType_suicide":
      data = 5;
      break;
    case "deathType_friendlyFire":
      data = 4;
      break;
    case "deathType_inLastStand":
      data = 2;
      break;
    case "deathType_normal":
      data = 1;
      break;
    case "downed":
      data = 0;
      break;
    default:
      data = -1;
      break;
  }

  return data;
}

_branalytics_addeventdelayed(type, origin, ent, data) {
  if(!isDefined(type))
    type = "undefined";

  if(!isDefined(origin))
    origin = (0, 0, 0);

  if(!isDefined(data))
    data = "";

  if(!isDefined(level.delayedeventtypes[type]))
    level.delayedeventtypes[type] = [];

  _id_C30ADB03CA046EDE = spawnStruct();
  _id_C30ADB03CA046EDE.type = type;
  _id_C30ADB03CA046EDE.origin = origin;
  _id_C30ADB03CA046EDE.ent = ent;
  _id_C30ADB03CA046EDE.data = data;
  _id_C30ADB03CA046EDE.state = 0;
  _id_C30ADB03CA046EDE.time = _branalytics_geteventtimestamp();
  _id_FCF163E2DB91EBA2 = level.delayedeventtypes[type].size;
  level.delayedeventtypes[type][_id_FCF163E2DB91EBA2] = _id_C30ADB03CA046EDE;
}

branalytics_seteventdelayedstate(type, ent, state) {
  if(!isDefined(type) || !isDefined(ent) || !isDefined(level.delayedeventtypes) || !isDefined(level.delayedeventtypes[type])) {
    return;
  }
  foreach(_id_C30ADB03CA046EDE in level.delayedeventtypes[type]) {
    if(isDefined(_id_C30ADB03CA046EDE) && isDefined(_id_C30ADB03CA046EDE.ent) && _id_C30ADB03CA046EDE.ent == ent) {
      _id_C30ADB03CA046EDE.time = _branalytics_geteventtimestamp();
      _id_C30ADB03CA046EDE.state = state;
      return;
    }
  }
}

branalytics_validation() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  return 1;
}

branalytics_equipmentuse(player, objweapon) {
  if(!branalytics_validation()) {
    return;
  }
  _id_F4692D0892428480 = objweapon.basename;
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "item_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F4692D0892428480;
  player dlog_recordplayerevent("dlog_event_br_equipment_use", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _branalytics_addevent("equipment_use", player.origin, 0, _id_F4692D0892428480, player);
}

branalytics_down(attacker, victim, objweapon, deathtype, meansofdeath) {
  if(!branalytics_validation()) {
    return;
  }
  if(isDefined(attacker.classname) && attacker.classname == "agent") {
    if(_branalytics_addeventallowed()) {
      id = attacker getentitynumber();
      _id_EEFAA754FC189980("down_by_agent", victim, id, deathtype);
    }

    return;
  }

  if(!isent(attacker) || !isPlayer(attacker)) {
    _id_9C46FC77656F0E4B = "world";
    attacker = victim;
  } else if(isDefined(objweapon))
    _id_9C46FC77656F0E4B = objweapon.basename;
  else {
    _id_2A8DBAD5E36EBD27 = attacker getcurrentweapon();
    _id_9C46FC77656F0E4B = _id_2A8DBAD5E36EBD27.basename;
  }

  _id_8367DC8C497F4C02 = scripts\engine\utility::ter_op(scripts\mp\utility\player::isinlaststand(victim) && isDefined(victim.laststandoldweaponobj), victim.laststandoldweaponobj, victim.lastweaponused);
  _id_595B87D05E4A06C4 = "";

  if(isDefined(_id_8367DC8C497F4C02))
    _id_595B87D05E4A06C4 = _id_8367DC8C497F4C02.basename;

  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "victim";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = victim;
  _id_3577D51E5FD643A0 = _branalytics_header(attacker, "attacker");

  foreach(item in _id_3577D51E5FD643A0)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "attacker_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_9C46FC77656F0E4B;
  _id_2D618A34E27D5476 = attacker getclientomnvar("ui_br_objective_index");

  if(!isDefined(_id_2D618A34E27D5476))
    _id_1070D193895B35B4 = "none";
  else
    _id_1070D193895B35B4 = tablelookup("mp/brmissions.csv", 0, _id_2D618A34E27D5476, 1);

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "attacker_active_mission";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1070D193895B35B4;
  _id_0E3056D0A98B080F = _branalytics_headerplayer([], victim, "victim");

  foreach(item in _id_0E3056D0A98B080F)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "victim_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_595B87D05E4A06C4;
  _id_2D618A34E27D5476 = victim getclientomnvar("ui_br_objective_index");

  if(!isDefined(_id_2D618A34E27D5476))
    _id_1070D193895B35B4 = "NONE";
  else
    _id_1070D193895B35B4 = tablelookup("mp/brmissions.csv", 0, _id_2D618A34E27D5476, 1);

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "victim_active_mission";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1070D193895B35B4;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "death_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = deathtype;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "means_of_death";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = meansofdeath;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 1);
  _id_C1DA30005A22582B = 2147483647;

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(_id_F0EA4030349A33D5 == victim) {
      continue;
    }
    dist = distance(victim.origin, _id_F0EA4030349A33D5.origin);

    if(dist < _id_C1DA30005A22582B || _id_C1DA30005A22582B == 2147483647)
      _id_C1DA30005A22582B = dist;
  }

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "closest_victim_teammate_distance";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_C1DA30005A22582B);
  _id_CBC3FCC6B1097835 = 0;

  if(isDefined(victim.pers["summary"]["xp"])) {
    _id_1822F368857BC036 = victim.pers["summary"]["xp"];
    _id_CBC3FCC6B1097835 = _id_1822F368857BC036 - victim.pers["telemetry"].life._id_2148FB703835EC1F;
  }

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "xp_earned";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_CBC3FCC6B1097835;
  attacker dlog_recordplayerevent("dlog_event_br_down", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("down", victim, _getdeathstatecode(deathtype), _id_9C46FC77656F0E4B);
}

branalytics_revive(reviver, _id_22F7E3F7E360775B) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "revivee";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_22F7E3F7E360775B;
  _id_852DBFE03D3EE1B8 = _branalytics_header(reviver, "reviver");

  foreach(item in _id_852DBFE03D3EE1B8)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_090F4FD6FFAA5C31 = _branalytics_headerplayer([], _id_22F7E3F7E360775B, "revivee");

  foreach(item in _id_090F4FD6FFAA5C31)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  reviver dlog_recordplayerevent("dlog_event_br_revive", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_A48BE354E2F41DB9("revive", _id_22F7E3F7E360775B);
}

branalytics_selfrevive(_id_22F7E3F7E360775B) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(_id_22F7E3F7E360775B, "revivee");
  _id_22F7E3F7E360775B dlog_recordplayerevent("dlog_event_br_selfrevive", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_A48BE354E2F41DB9("selfRevive", _id_22F7E3F7E360775B);
}

branalytics_secondwind(_id_22F7E3F7E360775B, laststandattacker, victim, meansofdeath, weaponname, laststandmeansofdeath, _id_A47D4C036F14FC38, _id_1450075A920A7DD5, _id_C9D5089E35E3FF9E, _id_E6EF59BD6DC2938A, _id_6B0DF23A41285117) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "lastStandAttacker";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = laststandattacker;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "victim";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = victim;
  _id_090F4FD6FFAA5C31 = _branalytics_header(_id_22F7E3F7E360775B, "revivee");

  foreach(item in _id_090F4FD6FFAA5C31)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_83EBB50FF7B5CF0E = _branalytics_headerplayer([], laststandattacker, "laststandattacker");

  foreach(item in _id_83EBB50FF7B5CF0E)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_0E3056D0A98B080F = _branalytics_headerplayer([], victim, "victim");

  foreach(item in _id_0E3056D0A98B080F)
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = item;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "only_cleanup";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1450075A920A7DD5;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "only_downed";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C9D5089E35E3FF9E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "bled_out";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_E6EF59BD6DC2938A;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "downed_seconds";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_6B0DF23A41285117;

  if(!isDefined(meansofdeath))
    meansofdeath = "";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "means_of_death";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = meansofdeath;

  if(!isDefined(weaponname))
    weaponname = "";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "weapon_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = weaponname;

  if(!isDefined(laststandmeansofdeath))
    laststandmeansofdeath = "";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "laststand_means_of_death";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = laststandmeansofdeath;

  if(!isDefined(_id_A47D4C036F14FC38))
    _id_A47D4C036F14FC38 = "";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "laststand_weapon_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A47D4C036F14FC38;
  _id_22F7E3F7E360775B dlog_recordplayerevent("dlog_event_br_secondwind", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_A48BE354E2F41DB9("secondWind", _id_22F7E3F7E360775B.origin);
}

branalytics_deployallowed() {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_deploy_allowed", []);
}

branalytics_deploytriggered(player) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  player dlog_recordplayerevent("dlog_event_br_deploy_triggered", _id_EC6A81EAC0E4DC61);
}

branalytics_landing(player) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  player dlog_recordplayerevent("dlog_event_br_deploy_land", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_A48BE354E2F41DB9("land", player);
}

branalytics_playercount(_id_D12A341B40354143) {
  if(!branalytics_validation()) {
    return;
  }
  if(_branalytics_addeventallowed())
    _branalytics_addevent("playerCount", (0, 0, 0), 0, _id_D12A341B40354143);
}

branalytics_lootpickup(player, scriptablename, amount) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "item_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scriptablename;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "amount";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = amount;
  player dlog_recordplayerevent("dlog_event_br_loot_pickup", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("loot_pickup", player, amount, scriptablename);
}

branalytics_lootdrop(player, itemtype, _id_E637EE4FAED5D14D, amount) {
  if(!branalytics_validation()) {
    return;
  }
  _id_E637EE4FAED5D14D = istrue(_id_E637EE4FAED5D14D);
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "item_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = itemtype;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_drop_from_weapon_switch";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_E637EE4FAED5D14D;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "amount";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = amount;
  player dlog_recordplayerevent("dlog_event_br_loot_drop", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("loot_drop", player, amount, itemtype);
}

branalytics_gulagstart(player, type) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = type;
  player dlog_recordplayerevent("dlog_event_br_gulag_start", _id_EC6A81EAC0E4DC61);
}

branalytics_gulagend(player, type) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = type;
  player dlog_recordplayerevent("dlog_event_br_gulag_end", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("gulag_end", player, 0, type);
}

branalytics_respawn(player, _id_99D9696812DF6304) {
  if(!branalytics_validation()) {
    return;
  }
  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("respawn", player, _id_99D9696812DF6304, "");
}

branalytics_disconnect(player, _id_8D4194F42FEFE406) {
  if(!branalytics_validation()) {
    return;
  }
  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("disconnect", player, _id_8D4194F42FEFE406, "");
}

branalytics_dropbagdeployed(player, _id_7BC6BE581F50B614, _id_ADD790A95B329400, crate) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[2];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "spawn_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_ADD790A95B329400;
  player dlog_recordplayerevent("dlog_event_br_dropbag_deployed", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _branalytics_addeventdelayed("dropkit", _id_7BC6BE581F50B614, crate, 0);
}

branalytics_dropbagused(player, _id_7BC6BE581F50B614, crate) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[2];
  player dlog_recordplayerevent("dlog_event_br_dropbag_used", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    branalytics_seteventdelayedstate("dropkit", crate, 1);
}

branalytics_dropbagdestroyed(team, _id_7BC6BE581F50B614) {
  if(!branalytics_validation()) {
    return;
  }
  if(!isDefined(team))
    team = "none";

  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_team";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = team;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "drop_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7BC6BE581F50B614[2];
  dlog_recordevent("dlog_event_br_dropbag_destroyed", _id_EC6A81EAC0E4DC61);
}

branalytics_circleenter(player, time) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_spent_outside";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  player dlog_recordplayerevent("dlog_event_br_circle_enter", _id_EC6A81EAC0E4DC61);
}

branalytics_circleexit(player, time) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_spent_inside";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  player dlog_recordplayerevent("dlog_event_br_circle_exit", _id_EC6A81EAC0E4DC61);
}

_id_14099F0F07C09E69(time) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_circle_start_split";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  dlog_recordevent("dlog_event_br_multi_circle_start_split", _id_EC6A81EAC0E4DC61);
}

_id_C3CA7338446F4FCE(time, _id_3511C7EE351E5C90, _id_4B6B489DAE052A24) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_circle_end_split";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_player_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3511C7EE351E5C90;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_team_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_4B6B489DAE052A24;
  dlog_recordevent("dlog_event_br_multi_circle_end_split", _id_EC6A81EAC0E4DC61);
}

_id_77C1C837C38EFA21(time, _id_3511C7EE351E5C90, _id_4B6B489DAE052A24) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_circle_start_merge";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_player_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3511C7EE351E5C90;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_team_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_4B6B489DAE052A24;
  dlog_recordevent("dlog_event_br_multi_circle_start_merge", _id_EC6A81EAC0E4DC61);
}

_id_4EB4428FE15D7276(time) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_circle_end_merge";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
  dlog_recordevent("dlog_event_br_multi_circle_end_merge", _id_EC6A81EAC0E4DC61);
}

branalytics_planepath(centerpt, yaw, startpt, endpt) {
  if(!branalytics_validation()) {
    return;
  }
  level waittill("prematch_done");
  dlog_recordevent("dlog_event_br_plane_path", ["center_x", centerpt[0], "center_y", centerpt[1], "center_z", centerpt[2], "yaw", yaw, "start_x", startpt[0], "start_y", startpt[1], "start_z", startpt[2], "end_x", endpt[0], "end_y", endpt[1], "end_z", endpt[2]]);

  if(_branalytics_addeventallowed()) {
    _id_DE802962B74D1A6C = -2;
    _id_4DF1E1A017254690 = _branalytics_geteventtimestamp();
    _id_B1EF50B243AD7D22 = _id_4DF1E1A017254690 + 35000;
    _id_432421C6EC2BFCD9 = distance(startpt, endpt);
    _id_20F3BD3EA911BD9D = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() * 1000;
    _id_FC296699DFB028F8 = _id_B1EF50B243AD7D22;
    _id_1ABCF37063053D49 = _id_FC296699DFB028F8 + _id_20F3BD3EA911BD9D;
    _id_BB96ECD805545B2E("plane", startpt, 0, int(_id_FC296699DFB028F8), "", _id_DE802962B74D1A6C);
    _id_BB96ECD805545B2E("plane", endpt, 0, int(_id_1ABCF37063053D49), "", _id_DE802962B74D1A6C);
  }
}

branalytics_economy_snapshot(activeplayers) {
  if(!branalytics_validation()) {
    return;
  }
  _id_AAA3A2B391A4D25B = [];
  _id_A059CAB9DFE3D005 = 0;
  _id_618FB04D3FECDEBA = 0;
  _id_61B2BA4D40133C70 = 5000;
  _id_E7A8920E2E79427E = 0;
  _id_E7CC840E2EA19E6C = 5000;

  foreach(player in activeplayers) {
    if(!isDefined(_id_AAA3A2B391A4D25B[player.team]))
      _id_AAA3A2B391A4D25B[player.team] = 0;

    if(isDefined(player.plundercount)) {
      _id_A059CAB9DFE3D005 = _id_A059CAB9DFE3D005 + player.plundercount;
      _id_AAA3A2B391A4D25B[player.team] = _id_AAA3A2B391A4D25B[player.team] + player.plundercount;

      if(player.plundercount > _id_618FB04D3FECDEBA)
        _id_618FB04D3FECDEBA = player.plundercount;

      if(player.plundercount < _id_61B2BA4D40133C70)
        _id_61B2BA4D40133C70 = player.plundercount;
    }

    if(_id_AAA3A2B391A4D25B[player.team] > _id_E7A8920E2E79427E)
      _id_E7A8920E2E79427E = _id_AAA3A2B391A4D25B[player.team];

    if(_id_AAA3A2B391A4D25B[player.team] < _id_E7CC840E2EA19E6C)
      _id_E7CC840E2EA19E6C = _id_AAA3A2B391A4D25B[player.team];
  }

  _id_53DCA488A704D8E7 = int(safedivide(_id_A059CAB9DFE3D005, activeplayers.size));
  _id_8DA025F6DA65D8D3 = int(safedivide(_id_A059CAB9DFE3D005, _id_AAA3A2B391A4D25B.size));
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_players_alive";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(activeplayers.size);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_teams_alive";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(_id_AAA3A2B391A4D25B.size);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "total_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCB7EC4C3306DB25(_id_A059CAB9DFE3D005);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "top_player_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(_id_618FB04D3FECDEBA);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "top_team_total_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(_id_E7A8920E2E79427E);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "avg_player_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(_id_53DCA488A704D8E7);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "avg_team_total_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(_id_8DA025F6DA65D8D3);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "min_player_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(_id_61B2BA4D40133C70);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "min_team_total_plunder_held";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(_id_E7CC840E2EA19E6C);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_items_picked_up";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.plunder_items_picked_up);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_value_picked_up";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.plunder_value_picked_up);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_items_dropped";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.plunder_items_dropped);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_value_dropped";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.plunder_value_dropped);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_awarded_by_missions_total";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.plunder_awarded_by_missions_total);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_spent_total";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(level.br_plunder.kiosk_spent_total);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_num_purchases";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(level.br_plunder.kiosk_num_purchases);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_balloon_total_value";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.extraction_balloon_total_plunder);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_balloon_total_extractions";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(level.br_plunder.extraction_balloon_num_completed);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_helicoptor_total_value";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(level.br_plunder.extraction_helicoptor_total_plunder);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_helicoptor_total_extractions";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(level.br_plunder.extraction_helicoptor_num_completed);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_uncommon_1";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_1"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_uncommon_2";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_2"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_uncommon_3";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_3"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_rare_1";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.itemsinworld["brloot_plunder_cash_rare_1"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_rare_2";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.itemsinworld["brloot_plunder_cash_rare_2"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_epic_1";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.itemsinworld["brloot_plunder_cash_epic_1"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_epic_2";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.itemsinworld["brloot_plunder_cash_epic_2"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ingame_count_legendary_1";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8CFD7CAFBC5981E(level.br_plunder.itemsinworld["brloot_plunder_cash_legendary_1"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "count_unopened_chests";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F8D8C3CAFBCF8AD0(level.br_plunder.itemsinworld["br_loot_cache"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "count_available_missions";

  if(isDefined(level.br_plunder))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_783ACBCF408FA927(level.br_plunder.itemsinworld["missionTablets"]);
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;

  dlog_recordevent("dlog_event_br_plunder_economy_snapshot", _id_EC6A81EAC0E4DC61);
}

br_getprimaryandsecondaryweapons(player) {
  primaryweaponobj = player getcurrentweapon();
  secondaryweaponobj = undefined;

  if(isDefined(player.primaryweaponobj) && primaryweaponobj != player.primaryweaponobj)
    secondaryweaponobj = player.primaryweaponobj;
  else if(isDefined(player.secondaryweaponobj) && primaryweaponobj != player.secondaryweaponobj)
    secondaryweaponobj = player.secondaryweaponobj;

  return [safecheckweapon(primaryweaponobj), safecheckweapon(secondaryweaponobj)];
}

branalytics_inventory_snapshot(player, _id_401C3A2E68AAB0FD) {
  if(!branalytics_validation()) {
    return;
  }
  _id_BD5CCE7508E151A9 = br_getprimaryandsecondaryweapons(player);
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "reason";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_401C3A2E68AAB0FD;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "primary_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_BD5CCE7508E151A9[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "secondary_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_BD5CCE7508E151A9[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "primary_equipment";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(player.equipment["primary"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "secondary_equipment";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(player.equipment["secondary"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "field_equipment";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(player.equipment["super"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "has_gasmask";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = isDefined(player.gasmaskequipped) && player.gasmaskequipped == 1;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "armor_plates";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_783ACBCF408FA927(player scripts\mp\equipment::getequipmentslotammo("health"));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_total";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCB7EC4C3306DB25(player.plundercount);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_banked";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCB7EC4C3306DB25(player.plunderbanked);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ammo_smg";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(player.br_ammo["brloot_ammo_919"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ammo_ar_lmg";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(player.br_ammo["brloot_ammo_762"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ammo_shotgun";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(player.br_ammo["brloot_ammo_12g"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ammo_sniper";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(player.br_ammo["brloot_ammo_50cal"]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ammo_rockets";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FE52B08C657D074(player.br_ammo["brloot_ammo_rocket"]);

  for(index = 0; index < 2; index++) {
    perkname = "specialty_null";

    if(isDefined(player.classstruct) && isDefined(player.classstruct.loadoutperks[index]))
      perkname = player.classstruct.loadoutperks[index];

    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "base_perk_" + (index + 1);
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = perkname;
  }

  _id_13DB3CA1AD2DB644 = "specialty_null";

  if(isDefined(player.classstruct) && isDefined(player.classstruct._id_15F3E6DF722FB1CF))
    _id_13DB3CA1AD2DB644 = player.classstruct._id_15F3E6DF722FB1CF;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "bonus_perk";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_13DB3CA1AD2DB644;
  _id_34FDCA49E62D81EE = "specialty_null";

  if(isDefined(player.classstruct) && isDefined(player.classstruct._id_15F3E5DF722FAF9C))
    _id_34FDCA49E62D81EE = player.classstruct._id_15F3E5DF722FAF9C;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ultimate_perk";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_34FDCA49E62D81EE;
  player dlog_recordplayerevent("dlog_event_br_inventory_snapshot", _id_EC6A81EAC0E4DC61);
}

_id_6039C3FFA983858F(player, _id_465AB95DD1230BD3, weaponref, _id_31553E68A5164E3E) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_spent";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_465AB95DD1230BD3;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_plunder_after_purchase";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player.plundercount;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(weaponref);

  for(_id_9413831C8D06464C = 0; _id_9413831C8D06464C < 7; _id_9413831C8D06464C++) {
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\engine\utility::_id_996B01CD49D0128D(["weapon_attachment_", scripts\engine\utility::string(_id_9413831C8D06464C)]);

    if(isDefined(_id_31553E68A5164E3E[_id_9413831C8D06464C])) {
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_31553E68A5164E3E[_id_9413831C8D06464C]);
      continue;
    }

    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "none";
  }

  player dlog_recordplayerevent("dlog_event_br_kiosk_purchase_loadout_weapon", _id_EC6A81EAC0E4DC61);
}

branalytics_kiosk_purchaseloadout(player, _id_465AB95DD1230BD3, _id_13ECA9A3244E502F) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_spent";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_465AB95DD1230BD3;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_plunder_after_purchase";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player.plundercount;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "primary_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutprimaryfullname);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "secondary_weapon";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutsecondaryfullname);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "primary_equipment";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutequipmentprimary);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "secondary_equipment";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutequipmentsecondary);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "base_perk_1";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutperks[0]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "base_perk_2";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F.loadoutperks[1]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "bonus_perk";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F._id_15F3E6DF722FB1CF);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ultimate_perk";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = safecheckstring(_id_13ECA9A3244E502F._id_15F3E5DF722FAF9C);
  player dlog_recordplayerevent("dlog_event_br_kiosk_purchase_loadout", _id_EC6A81EAC0E4DC61);
}

branalytics_kiosk_purchaseitem(player, _id_465AB95DD1230BD3, _id_75B71E1F4013579E, itemname) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_spent";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(_id_465AB95DD1230BD3);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_plunder_after_purchase";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCAF784C32FDF05B(player.plundercount);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "purchase_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_75B71E1F4013579E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "item_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = itemname;
  player dlog_recordplayerevent("dlog_event_br_kiosk_purchase_item", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed())
    _id_EEFAA754FC189980("purchase", player, _id_465AB95DD1230BD3, itemname);
}

branalytics_kiosk_menu_event(player, _id_A00244F669488912, _id_6C457C5F341BEB23, _id_97AA008EFEEDD23C) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player, "kiosk_menu_owner");
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_event";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A00244F669488912;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_event_param";

  if(isDefined(_id_6C457C5F341BEB23))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_6C457C5F341BEB23;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "none";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_event_time";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = gettime() - level.starttime;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_kiosk";

  if(isDefined(player.br_kiosk))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player.br_kiosk.index;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = -1;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_allowed";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(player.armorykioskpurchaseallowed);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_menu_owner_error";

  if(_id_A00244F669488912 != "menu_close" && !isDefined(player.br_kiosk))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "unexpected_undefined_kiosk";
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "none";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "kiosk_type";

  if(!isDefined(_id_97AA008EFEEDD23C))
    _id_97AA008EFEEDD23C = "standard_kiosk";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_97AA008EFEEDD23C;
  player dlog_recordplayerevent("dlog_event_br_kiosk_menu_event", _id_EC6A81EAC0E4DC61);
}

branalytics_plunder_placed_into_extraction(player, _id_3EAA9F644DBE7834, location, _id_987EBC0A48F683A2) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_method";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3EAA9F644DBE7834;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_placed_into_extraction";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_987EBC0A48F683A2;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_point_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = location[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_point_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = location[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_point_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = location[2];
  player dlog_recordplayerevent("dlog_event_br_plunder_placed_into_extraction", _id_EC6A81EAC0E4DC61);
}

branalytics_plunder_extraction_success(_id_10BF707212FEC686, _id_987EBC0A48F683A2, _id_3EAA9F644DBE7834, _id_235F1174E9FAA6D2, _id_11F463855416AB73) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_depositers";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_10BF707212FEC686;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_extracted";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_987EBC0A48F683A2;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "method";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3EAA9F644DBE7834;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "contains_enemy_plunder";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_235F1174E9FAA6D2;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[2];
  dlog_recordevent("dlog_event_br_plunder_extraction_success", _id_EC6A81EAC0E4DC61);
}

branalytics_plunder_extraction_failure(_id_DD059E3EBA985900, _id_3EAA9F644DBE7834, _id_11F463855416AB73, _id_DCED1621D5483CC2) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "plunder_dropped";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DD059E3EBA985900;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "method";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3EAA9F644DBE7834;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "extraction_origin_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_11F463855416AB73[2];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "destruction_origin_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCED1621D5483CC2[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "destruction_origin_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCED1621D5483CC2[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "destruction_origin_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DCED1621D5483CC2[2];
  dlog_recordevent("dlog_event_br_plunder_extraction_failure", _id_EC6A81EAC0E4DC61);
}

branalytics_bonusxp_debugdata(xp, _id_401C3A2E68AAB0FD) {
  if(!branalytics_validation()) {
    return;
  }
  if(isDefined(self))
    xuid = self getxuid() + " " + _id_401C3A2E68AAB0FD;
  else
    xuid = "none " + _id_401C3A2E68AAB0FD;

  xp = int(xp);

  if(_branalytics_addeventallowed())
    _branalytics_addevent("bonusXpDebug", (0, 0, 0), xp, xuid);
}

branalytics_vehiclespawned(vehicle, refname) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(!branalytics_validation()) {
    return;
  }
  if(_branalytics_addeventallowed() && isDefined(level.prematchendtime))
    _branalytics_addeventdelayed("vehicle", vehicle.origin, vehicle, refname);
}

_id_E77F36370162406C(player) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = _branalytics_header(player);
  player dlog_recordplayerevent("dlog_event_br_redeploy_drone_used", _id_EC6A81EAC0E4DC61);
}

branalytics_inittablets(_id_7C0F9991CF5F3AC7, _id_D3DC2B1148A16722, _id_E9C3E5B8976CF5DC, _id_5638CCCA9C6120D3) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_mission_init", ["num_missions", _id_7C0F9991CF5F3AC7, "num_missions_active", _id_D3DC2B1148A16722, "num_missions_hidden", _id_E9C3E5B8976CF5DC, "hide_percent", _id_5638CCCA9C6120D3]);
}

branalytics_delayedshowtablets(_id_F5A39828804902E2, _id_5347B28D23DA7E3A, _id_36F7B2197683BC82, _id_6CAB9ACAEB50BB75) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_mission_repopulate", ["circle_index", _id_F5A39828804902E2, "show_percent", _id_5347B28D23DA7E3A, "num_valid", _id_36F7B2197683BC82, "num_shown", _id_6CAB9ACAEB50BB75]);
}

branalytics_spawntablet(tablet) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_mission_spawn", ["id", scripts\engine\utility::ter_op(isDefined(tablet.index), "" + tablet.index, "invalid"), "type", tablet.type, "origin_x", tablet.origin[0], "origin_y", tablet.origin[1], "origin_z", tablet.origin[2]]);

  if(_branalytics_addeventallowed() && isDefined(tablet.index))
    _branalytics_addeventdelayed("mission", tablet.origin, "" + tablet.index, tablet.tablettype);
}

branalytics_invalidtablet(tablet) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_mission_invalid", ["id", scripts\engine\utility::ter_op(isDefined(tablet.index), "" + tablet.index, "invalid"), "type", tablet.type, "origin_x", tablet.origin[0], "origin_y", tablet.origin[1], "origin_z", tablet.origin[2]]);
}

branalytics_missionstart(_id_B2B01F6F55F16552, player) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);
  _id_EC6A81EAC0E4DC61 = _branalytics_headerplayerposrow(_id_EC6A81EAC0E4DC61, _id_6D5ED003AF1F9612);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "id";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\engine\utility::ter_op(isDefined(_id_B2B01F6F55F16552.missionid), _id_B2B01F6F55F16552.missionid, "invalid");

  if(isDefined(level.br_circle))
    circleindex = scripts\engine\utility::getintorzero(level.br_circle.circleindex);
  else
    circleindex = -1;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_index";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = circleindex;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "type";

  if(getdvarint("dvar_82BDE055B11E6698", 0))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B2B01F6F55F16552.questcategory;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B2B01F6F55F16552.type.ref;

  player dlog_recordplayerevent("dlog_event_br_mission_start", _id_EC6A81EAC0E4DC61);

  if(_branalytics_addeventallowed() && isDefined(_id_B2B01F6F55F16552.missionid))
    branalytics_seteventdelayedstate("mission", _id_B2B01F6F55F16552.missionid, -1);
}

branalytics_missionend(_id_B2B01F6F55F16552, _id_89EDDDE3DA46BC8D, results, _id_EF08909F6CBF35FC) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_mission_end", ["id", scripts\engine\utility::ter_op(isDefined(_id_B2B01F6F55F16552.missionid), _id_B2B01F6F55F16552.missionid, "invalid"), "result", scripts\engine\utility::ter_op(isDefined(_id_B2B01F6F55F16552.result), _id_B2B01F6F55F16552.result, "unknown"), "reward_tier", _id_89EDDDE3DA46BC8D, "xp", scripts\engine\utility::ter_op(isDefined(results["xp"]), results["xp"], 0), "weapon_xp", scripts\engine\utility::ter_op(isDefined(results["weapon_xp"]), results["weapon_xp"], 0), "plunder", scripts\engine\utility::ter_op(isDefined(results["plunder"]), results["plunder"], 0), "num_teammates_awarded", scripts\engine\utility::ter_op(isDefined(_id_EF08909F6CBF35FC), _id_EF08909F6CBF35FC, 0), "type", _id_B2B01F6F55F16552.questcategory]);

  if(_branalytics_addeventallowed() && isDefined(_id_B2B01F6F55F16552.missionid)) {
    if(isDefined(_id_B2B01F6F55F16552.result) && _id_B2B01F6F55F16552.result == "success")
      branalytics_seteventdelayedstate("mission", _id_B2B01F6F55F16552.missionid, _id_89EDDDE3DA46BC8D);
    else
      branalytics_seteventdelayedstate("mission", _id_B2B01F6F55F16552.missionid, -1);
  }
}

_id_1D6052577CD7738C(_id_DB62C0CFC8A661CC, _id_1EA736D378B0D412, success) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(_id_DB62C0CFC8A661CC.targetteam, 0);
  _id_F2B8863302006284 = _id_6D5ED003AF1F9612.size;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "end_reason";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1EA736D378B0D412;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "state_progress";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\engine\utility::ter_op(istrue(success), 5, _id_DB62C0CFC8A661CC.state);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_beryllium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("ber", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_plutonium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("plu", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_tritium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("tri", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_gallium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("gal", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_deuterium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("deu", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "collected_neptunium";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D &_id_728FFCEE8CBF30EE::_id_2C126DE0BDB9BFD5(_id_728FFCEE8CBF30EE::_id_6844602F3120E900("nep", 6)));
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_teammates";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F2B8863302006284;

  foreach(player in _id_6D5ED003AF1F9612)
  player dlog_recordplayerevent("dlog_event_br_elite_broken_arrow_end", _id_EC6A81EAC0E4DC61);

  _id_4FD25C3D5A24B069 = istrue(success);
  _branalytics_addevent("elite_broken_arrow_end", (0, 0, 0), _id_4FD25C3D5A24B069, _id_1EA736D378B0D412);
}

_id_F3C107FAA06DC299(player, _id_8DD9F2EB8215A139) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_until_detonation";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8DD9F2EB8215A139;
  player dlog_recordplayerevent("dlog_event_br_elite_broken_arrow_defuse", _id_EC6A81EAC0E4DC61);
  _branalytics_addevent("elite_broken_arrow_defuse", player getorigin(), _id_8DD9F2EB8215A139, "time_until_detonation", player);
}

_id_F36C99358D254EA9(player, _id_F7806D4CF24AACD3) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "element_id";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F7806D4CF24AACD3._id_27DE1507ED41F01E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_from_spawn";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = gettime() - _id_F7806D4CF24AACD3.spawntime;
  player dlog_recordplayerevent("dlog_event_br_elite_broken_arrow_element_collect", _id_EC6A81EAC0E4DC61);
  _branalytics_addevent("elite_broken_arrow_element_collect", player getorigin(), _id_F7806D4CF24AACD3.spawntime, _id_F7806D4CF24AACD3._id_27DE1507ED41F01E, player);
}

_id_0523B126AA6B63C7(player, _id_0436204FBA69D256) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time_from_bombsite_spawn";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_0436204FBA69D256;
  player dlog_recordplayerevent("dlog_event_br_elite_broken_arrow_arm", _id_EC6A81EAC0E4DC61);
  _branalytics_addevent("elite_broken_arrow_arm", player getorigin(), _id_0436204FBA69D256, "time_from_bombsite_spawn", player);
}

_id_77814C1B523FD8A3(_id_D12A341B40354143) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_D12A341B40354143;
  dlog_recordevent("dlog_event_br_elite_broken_arrow_match_invalid", _id_EC6A81EAC0E4DC61);
}

_id_5E512F1540E0E8A3(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("initialize_fortress_kiosk", origin, state);
}

_id_A82F819FDDC8E099(origin, data, player) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("kiosk_unusable_for_player", origin, 0, data, player);
}

_id_1FE361A65F4321B1(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("remove_kiosk", origin, state);
}

_id_D647F8B91EE72E68(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("fortress_rejected", origin, state);
}

_id_CDF333517613E68D(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("spawn_blacksite", origin, state);
}

_id_A9FE2BED8ED8B965(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("spawn_fortress", origin, state);
}

_id_CE58220FBD0824BE(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("unlock_all_blacksite_doors", origin, state);
}

_id_31406A57E628C3FE(origin, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("unlock_all_fortress_interior_doors", origin, state);
}

_id_AAF1156BACF6654E(origin, data) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("spawn_boss", origin, 0, data);
}

_id_5C71B11655C95436(origin) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("unlock_first_blacksite_door", origin);
}

_id_257618A8537D8D10(origin) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("stronghold_captured", origin);
}

_id_2CC353FDC725F4B4(origin, data) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("fortress_loot_zone", origin, 0, data);
}

_id_EA157B4B9615B2DF(origin, data) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("fortress_undefined_zonebounds", origin, 0, data);
}

_id_41082D2A8CF1EE28(origin, data) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("fortress_mismatched_zonebounds", origin, 0, data);
}

_id_3461C9A3DBBCCECF(interrogator, state, data) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("interrogation", interrogator getorigin(), state, data, interrogator);
}

_id_82B50D847253078F(victim, state) {
  if(!branalytics_validation()) {
    return;
  }
  _branalytics_addevent("interrogation_victim", victim getorigin(), state, "", victim);
}

branalytics_teameliminated(team, teamplacement) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_team_eliminated", ["team", team, "placement", teamplacement, "survival_time", gettime() - level.starttime]);
}

_id_CB3B3CBF2D1AC3F3(_id_5746D9F038B58234, _id_CC603E175ABFEF2D, _id_59A52BFE186A64C9, weaponname, player, type) {
  if(!branalytics_validation()) {
    return;
  }
  _id_B4DE36CB26159194 = "xp_event";
  _branalytics_addevent(_id_B4DE36CB26159194, (_id_5746D9F038B58234, _id_CC603E175ABFEF2D, 0), _id_59A52BFE186A64C9, weaponname, player);
}

branalytics_publiceventstarted(eventtype) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_public_event_start", ["type", eventtype]);
}

branalytics_publiceventended(eventtype) {
  if(!branalytics_validation()) {
    return;
  }
  dlog_recordevent("dlog_event_br_public_event_end", ["type", eventtype]);
}

_branalytics_header(player, _id_44375E4D2A4B781B) {
  _id_FAD588394427F934 = [];

  if(!isstring(_id_44375E4D2A4B781B))
    _id_44375E4D2A4B781B = "player";

  _id_FAD588394427F934 = _branalytics_headerplayer(_id_FAD588394427F934, player, _id_44375E4D2A4B781B);

  if(isDefined(level.br_circle))
    circleindex = scripts\engine\utility::getintorzero(level.br_circle.circleindex);
  else
    circleindex = -1;

  _id_FAD588394427F934[_id_FAD588394427F934.size] = "circle_index";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = circleindex;
  return _id_FAD588394427F934;
}

_branalytics_headerplayer(_id_FAD588394427F934, player, _id_44375E4D2A4B781B) {
  if(!isstring(_id_44375E4D2A4B781B))
    _id_44375E4D2A4B781B = "player";

  _id_FAD588394427F934[_id_FAD588394427F934.size] = _id_44375E4D2A4B781B + "_x";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = player.origin[0];
  _id_FAD588394427F934[_id_FAD588394427F934.size] = _id_44375E4D2A4B781B + "_y";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = player.origin[1];
  _id_FAD588394427F934[_id_FAD588394427F934.size] = _id_44375E4D2A4B781B + "_z";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = player.origin[2];
  _id_FAD588394427F934[_id_FAD588394427F934.size] = _id_44375E4D2A4B781B + "_pitch";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = scripts\engine\utility::getplayerpitch(player);
  _id_FAD588394427F934[_id_FAD588394427F934.size] = _id_44375E4D2A4B781B + "_yaw";
  _id_FAD588394427F934[_id_FAD588394427F934.size] = scripts\engine\utility::getplayeryaw(player);
  return _id_FAD588394427F934;
}

_branalytics_headerplayerposrow(params, players) {
  params[params.size] = "living_player_pos";
  _id_916910D71143DA1D = [];

  foreach(player in players) {
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = "x";
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = player.origin[0];
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = "y";
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = player.origin[1];
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = "z";
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = player.origin[2];
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = "pitch";
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = scripts\engine\utility::getplayerpitch(player);
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = "yaw";
    _id_916910D71143DA1D[_id_916910D71143DA1D.size] = scripts\engine\utility::getplayeryaw(player);
  }

  params[params.size] = _id_916910D71143DA1D;
  return params;
}

safecheckstring(data) {
  if(isDefined(data))
    return data;
  else
    return "empty";
}

safecheckweapon(data) {
  if(isDefined(data))
    return data.basename;
  else
    return "empty";
}

_id_7069250582D42C1A(data, _id_45F5C29DB0C1FD9B, _id_45D1B89DB0996CE5) {
  if(isDefined(_id_45F5C29DB0C1FD9B)) {
    if(data < _id_45F5C29DB0C1FD9B)
      return _id_45F5C29DB0C1FD9B;
  }

  if(isDefined(_id_45D1B89DB0996CE5)) {
    if(data > _id_45D1B89DB0996CE5)
      return _id_45D1B89DB0996CE5;
  }

  return data;
}

_id_783ACBCF408FA927(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = -128;
    _id_E1A10A5F7E086BCC = 127;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_F8CFD7CAFBC5981E(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = -32768;
    _id_E1A10A5F7E086BCC = 32767;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_F8D8C3CAFBCF8AD0(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = undefined;
    _id_E1A10A5F7E086BCC = 2147483647;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_F8CB57CAFBC088C7(data) {
  if(isDefined(data) && isnumber(data))
    return data;

  return 0;
}

_id_3FE52B08C657D074(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = 0;
    _id_E1A10A5F7E086BCC = 255;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_DCAF784C32FDF05B(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = 0;
    _id_E1A10A5F7E086BCC = 65535;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_DCB7EC4C3306DB25(data) {
  if(isDefined(data) && isnumber(data)) {
    _id_E1C5185F7E31054E = 0;
    _id_E1A10A5F7E086BCC = 4294967295;
    return _id_7069250582D42C1A(data, _id_E1C5185F7E31054E, _id_E1A10A5F7E086BCC);
  }

  return 0;
}

_id_DCA1E84C32EE9F26(data) {
  if(isDefined(data) && isnumber(data))
    return data;

  return 0;
}

safedivide(data, _id_F1563935AEEB5199) {
  if(!isDefined(_id_F1563935AEEB5199) || _id_F1563935AEEB5199 <= 0)
    return data / 1;
  else
    return data / _id_F1563935AEEB5199;
}

branalytics_endgame() {
  if(_branalytics_addeventallowed()) {
    if(isDefined(level.delayedeventtypes["vehicle"])) {
      foreach(_id_C30ADB03CA046EDE in level.delayedeventtypes["vehicle"]) {
        if(!isDefined(_id_C30ADB03CA046EDE.ent)) {
          _id_C30ADB03CA046EDE.state = 1;
          continue;
        }

        if(distancesquared(_id_C30ADB03CA046EDE.origin, _id_C30ADB03CA046EDE.ent.origin) > squared(1000))
          _id_C30ADB03CA046EDE.state = 1;
      }
    }

    if(isDefined(level.br_armory_kiosk)) {
      foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
        state = 0;

        if(istrue(_id_15B89FF206500554.visible))
          state = 1;

        time = 0;
        entnum = -1;
        _id_BB96ECD805545B2E("kiosk", _id_15B89FF206500554.origin, state, time, "", entnum);
      }
    }

    foreach(_id_BAFEF05479604422 in level.delayedeventtypes) {
      foreach(_id_CE203D78F57223DE in _id_BAFEF05479604422) {
        if(isDefined(_id_CE203D78F57223DE))
          _id_BB96ECD805545B2E(_id_CE203D78F57223DE.type, _id_CE203D78F57223DE.origin, _id_CE203D78F57223DE.state, _id_CE203D78F57223DE.time, _id_CE203D78F57223DE.data, -1);
      }
    }
  }

  if(1)
    analyticswritecsv();
}

_id_B9C4D225E9548D8B() {
  if(!isDefined(level.prematchendtime))
    return 0;

  if(!istrue(level._id_47BE1D1BB3B425A6))
    return 0;

  if(isPlayer(self))
    return 1;

  if(isagent(self))
    return 1;

  return 0;
}

_id_90D7BFD05ED0FBE9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("brAnalytics_agent_killed");
  entnum = self getentitynumber();
  state = 0;
  data = "";
  _id_7DBFB7362717CE21 = 0;
  _id_A81180FE2DF07C44 = "";

  for(;;) {
    wait 30.0;

    if(!isalive(self)) {
      continue;
    }
    if(isDefined(self.gulag) && self.gulag == 1) {
      continue;
    }
    if(isagent(self)) {
      if(isDefined(self.enemy))
        _id_7DBFB7362717CE21 = self.enemy getentitynumber();
      else
        _id_7DBFB7362717CE21 = 0;

      if(isDefined(self._id_F8BC7ECDD324DD79))
        _id_A81180FE2DF07C44 = self._id_F8BC7ECDD324DD79.behavior;
      else
        _id_A81180FE2DF07C44 = "";
    } else if(isPlayer(self)) {
      if(isDefined(self.plundercount))
        _id_7DBFB7362717CE21 = int(self.plundercount);

      if(isDefined(self.team))
        _id_A81180FE2DF07C44 = self.team;
    }

    time = _branalytics_geteventtimestamp();

    if(!isDefined(self._id_D5C444A3FBB7D030))
      self._id_D5C444A3FBB7D030 = time;

    if(self._id_D5C444A3FBB7D030 < time - 30.0 || state != _id_7DBFB7362717CE21 || data != _id_A81180FE2DF07C44) {
      self._id_D5C444A3FBB7D030 = time;
      state = _id_7DBFB7362717CE21;
      data = _id_A81180FE2DF07C44;
      _id_BB96ECD805545B2E("breadcrumb", self.origin, state, time, data, entnum);
    }
  }
}

_id_F183D915239368B7(time) {
  if(!_id_B9C4D225E9548D8B()) {
    return;
  }
  if(!isDefined(self._id_D5C444A3FBB7D030)) {
    self._id_D5C444A3FBB7D030 = time;
    thread _id_90D7BFD05ED0FBE9();
  } else
    self._id_D5C444A3FBB7D030 = time;
}

_id_8E6652060309B9DB(origin, data) {
  if(!_branalytics_addeventallowed()) {
    return;
  }
  _branalytics_addevent("agent_alloc", origin, 0, data);
}

_id_252E45FC60E2A731(ent) {
  if(!isDefined(ent) || !_branalytics_addeventallowed()) {
    return;
  }
  state = 0;

  if(isDefined(ent.category) && ent.category == "gulag")
    state = 1;

  data = ent.agent_type;
  _id_EEFAA754FC189980("agent_spawn", ent, state, data);
}

_id_0E3AEF4FCB303CFF(ent, _id_8227176423F57171, attacker) {
  if(!isDefined(ent) || !_branalytics_addeventallowed()) {
    return;
  }
  ent notify("brAnalytics_agent_killed");

  if(_id_8227176423F57171)
    _id_9C46FC77656F0E4B = "dormancy";
  else if(!isDefined(attacker) || !(isagent(attacker) || isPlayer(attacker)) || !isDefined(attacker.classname) || attacker.classname == "worldspawn" || attacker.classname == "script_vehicle" || attacker.classname == "script_model" || attacker.classname == "misc_turret" || attacker.classname == "misc_samsite" || attacker.classname == "trigger_hurt" || attacker.classname == "trigger_multiple" || attacker.classname == "script_origin")
    _id_9C46FC77656F0E4B = "world";
  else {
    _id_2A8DBAD5E36EBD27 = attacker getcurrentweapon();
    _id_9C46FC77656F0E4B = _id_2A8DBAD5E36EBD27.basename;
  }

  state = 0;

  if(isDefined(_id_8227176423F57171) && _id_8227176423F57171 == 1)
    state = 1;

  if(isDefined(level._id_91ABB8090412CC15) && _id_9C46FC77656F0E4B != "world" && _id_9C46FC77656F0E4B != "dormancy")
    [[level._id_91ABB8090412CC15]](ent, attacker);

  _id_EEFAA754FC189980("agent_down", ent, state, _id_9C46FC77656F0E4B);
}

_id_5BD0A2D95D2E42A5(origin, state) {
  if(!_branalytics_addeventallowed()) {
    return;
  }
  _branalytics_addevent("stronghold_spawn", origin, state);
}

_id_F3CFF8F31F5CDBF4(origin) {
  if(!_branalytics_addeventallowed()) {
    return;
  }
  _branalytics_addevent("stronghold_despawn", origin);
}

_id_97EC7995C587BF25() {
  if(!getdvarint("dvar_EC7375CC2A0CA633", 1)) {
    return;
  }
  level._id_0536CD4E9DE6C69E = [];

  if(!_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onPlayerKilled"))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::_id_4EB467C8F2A4C7AE);

  if(!_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onPickupTakenIntoBackpack"))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPickupTakenIntoBackpack", ::_id_A9C8B07AF07F6F06);

  level._id_E17717792ADE97B2 = ::_id_35E00E890DFEE7B4;
  level._id_3AFACC0C3B10B7FE = ::_id_CD1564CA587BCD0D;
  level._id_722DA533CA224C88 = ::_id_2D1B322DE840D5F1;
  level._id_91ABB8090412CC15 = ::_id_179B94929CC4C682;
  level._id_D127A6A056D31D74 = ::_id_16A3F35CBAB3325A;
  level._id_18889818BACE4953 = ::_id_99571774BEB8163B;

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_D584FAAFA7C6C60C);

  thread _id_C116FF94EF26D3B0();
}

_id_C116FF94EF26D3B0() {
  level waittill("game_ended");

  if(isDefined(level._id_F1073FBD45B59A06._id_DF987907A483DF89) && level._id_F1073FBD45B59A06._id_DF987907A483DF89.size > 0) {
    foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89)
    _id_276AC5E84835EA87 _id_DF74213F854433F9();
  }
}

_id_16A3F35CBAB3325A(player) {
  if(!isPlayer(player)) {
    return;
  }
  if(!isDefined(self._id_276AC5E84835EA87)) {
    return;
  }
  if(!player _id_82043961042627E2(self._id_276AC5E84835EA87)) {
    return;
  }
  if(isDefined(player._id_02C2F43DD4153F5A) && isDefined(player._id_02C2F43DD4153F5A._id_276AC5E84835EA87)) {
    if(player._id_02C2F43DD4153F5A._id_276AC5E84835EA87 == self._id_276AC5E84835EA87) {
      if(istrue(player._id_02C2F43DD4153F5A._id_E6A3B7922938D197))
        player._id_02C2F43DD4153F5A._id_E6A3B7922938D197 = 0;

      return;
    } else {
      proxtrigger = player._id_02C2F43DD4153F5A._id_276AC5E84835EA87._id_AAC94CE6A0278A36;

      if(isDefined(proxtrigger)) {
        _id_F9419EF8D4E4B8C1 = _id_7D3C7B86D9EFCDDB(player, self, proxtrigger);

        if(!isDefined(_id_F9419EF8D4E4B8C1) || _id_F9419EF8D4E4B8C1 != self)
          return;
      }
    }
  } else {
    _id_022547840E146C1E = undefined;
    _id_EB5819F16AB7D1A6 = undefined;

    foreach(_id_CDD12B78F51B4E2A in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
      if(!isDefined(_id_CDD12B78F51B4E2A) || !player _id_82043961042627E2(_id_CDD12B78F51B4E2A)) {
        continue;
      }
      dist = undefined;

      if(isDefined(_id_CDD12B78F51B4E2A._id_E1DD7BED632A13C3) && isDefined(_id_CDD12B78F51B4E2A._id_E1DD7BED632A13C3.origin))
        dist = _id_5B8DE0654B1464A5(player, _id_CDD12B78F51B4E2A._id_E1DD7BED632A13C3);
      else if(isDefined(_id_CDD12B78F51B4E2A._id_AAC94CE6A0278A36) && isDefined(_id_CDD12B78F51B4E2A._id_AAC94CE6A0278A36.origin))
        dist = _id_5B8DE0654B1464A5(player, _id_CDD12B78F51B4E2A._id_AAC94CE6A0278A36);

      if(isDefined(dist) && (!isDefined(_id_022547840E146C1E) || dist < _id_EB5819F16AB7D1A6)) {
        _id_022547840E146C1E = _id_CDD12B78F51B4E2A;
        _id_EB5819F16AB7D1A6 = dist;
      }
    }

    if(isDefined(_id_022547840E146C1E))
      player _id_3A1F84A4281D12F9(_id_022547840E146C1E);

    return;
  }

  player _id_3A1F84A4281D12F9(self._id_276AC5E84835EA87);
}

_id_3A1F84A4281D12F9(_id_276AC5E84835EA87, timestamp) {
  if(isDefined(self._id_9FCD93EB0B17894D) && scripts\engine\utility::array_contains(self._id_9FCD93EB0B17894D, _id_276AC5E84835EA87)) {
    return;
  }
  if(isDefined(self._id_02C2F43DD4153F5A) && isDefined(self._id_02C2F43DD4153F5A._id_276AC5E84835EA87)) {
    if(self._id_02C2F43DD4153F5A._id_276AC5E84835EA87 == _id_276AC5E84835EA87) {
      if(istrue(self._id_02C2F43DD4153F5A._id_E6A3B7922938D197))
        self._id_02C2F43DD4153F5A._id_E6A3B7922938D197 = 0;

      return;
    } else
      _id_0708329F09283076("entered_different_stronghold", 0);
  }

  self._id_02C2F43DD4153F5A = spawnStruct();
  self._id_02C2F43DD4153F5A._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  self._id_02C2F43DD4153F5A._id_AE4763248A440471 = 1;

  if(!isDefined(timestamp))
    timestamp = gettime();

  _id_276AC5E84835EA87 _id_36FC8BC7E3143858(self, timestamp);
}

_id_0708329F09283076(_id_401C3A2E68AAB0FD, success, timestamp) {
  if(!isDefined(self._id_02C2F43DD4153F5A) || !isDefined(self._id_02C2F43DD4153F5A._id_276AC5E84835EA87)) {
    return;
  }
  _id_276AC5E84835EA87 = self._id_02C2F43DD4153F5A._id_276AC5E84835EA87;

  if(istrue(self._id_02C2F43DD4153F5A._id_E6A3B7922938D197))
    self._id_02C2F43DD4153F5A._id_E6A3B7922938D197 = 0;

  _id_276AC5E84835EA87 _id_17F1328AA045B61D(self, _id_401C3A2E68AAB0FD, success, timestamp);
  self._id_02C2F43DD4153F5A = undefined;

  if(isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[self.team].activeplayers) && _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[self.team].activeplayers.size <= 0)
    _id_276AC5E84835EA87 _id_28E81A288CB740FD(self.team, success);
}

_id_82043961042627E2(_id_276AC5E84835EA87) {
  if(!_id_744CAD313ED0A87E::_id_0397209B257DF87A())
    return 0;

  if(isDefined(_id_276AC5E84835EA87._id_04756733ECC825A2) && _id_276AC5E84835EA87._id_04756733ECC825A2 == self.team)
    return 0;

  if(istrue(_id_276AC5E84835EA87._id_933F9685674999FB))
    return istrue(_id_276AC5E84835EA87._id_7BE8B486A10B3DE8) && !istrue(_id_276AC5E84835EA87._id_6DFAEE5EE2B3FA4B);

  return 1;
}

_id_7D3C7B86D9EFCDDB(player, _id_906F8A71B90DF05E, _id_906F8971B90DEE2B) {
  if(!isDefined(_id_906F8A71B90DF05E))
    return _id_906F8971B90DEE2B;
  else if(!isDefined(_id_906F8971B90DEE2B))
    return _id_906F8A71B90DF05E;

  _id_585D11C8B1DB05FA = ispointinvolume(player.origin, _id_906F8A71B90DF05E);
  _id_585D10C8B1DB03C7 = ispointinvolume(player.origin, _id_906F8971B90DEE2B);

  if(!_id_585D11C8B1DB05FA) {
    if(!_id_585D10C8B1DB03C7)
      return undefined;
    else
      return _id_906F8971B90DEE2B;
  } else if(!_id_585D10C8B1DB03C7)
    return _id_906F8A71B90DF05E;

  _id_75837491258E8569 = distance(player.origin, _id_906F8A71B90DF05E.origin);
  _id_4F2883195384EECC = distance(player.origin, _id_906F8971B90DEE2B.origin);

  if(_id_4F2883195384EECC > _id_75837491258E8569)
    return _id_906F8A71B90DF05E;
  else if(_id_75837491258E8569 > _id_4F2883195384EECC)
    return _id_906F8971B90DEE2B;

  return undefined;
}

_id_5B8DE0654B1464A5(player, volume) {
  if(isDefined(player) && isDefined(player.origin) && isDefined(volume) && isDefined(volume.origin))
    return distance(player.origin, volume.origin);

  return undefined;
}

_id_99571774BEB8163B(player) {
  if(!isPlayer(player)) {
    return;
  }
  if(isDefined(player._id_02C2F43DD4153F5A)) {
    if(istrue(player._id_02C2F43DD4153F5A._id_E6A3B7922938D197)) {
      return;
    }
    player._id_02C2F43DD4153F5A._id_E6A3B7922938D197 = 1;
    player._id_02C2F43DD4153F5A._id_414A62FAFEB49300 = gettime();
    thread _id_E751288A23E6E9EA(player);
  }
}

_id_E751288A23E6E9EA(player) {
  player endon("stop_timeout");
  player endon("death_or_disconnect");

  while(isDefined(player._id_02C2F43DD4153F5A) && istrue(player._id_02C2F43DD4153F5A._id_E6A3B7922938D197)) {
    currenttime = gettime();

    if(currenttime - player._id_02C2F43DD4153F5A._id_414A62FAFEB49300 >= getdvarint("dvar_F09A64CED68B366E", 5000) && istrue(player._id_02C2F43DD4153F5A._id_E6A3B7922938D197)) {
      _id_CF0F7529918E7772(player);
      return;
    }

    wait 0.2;
  }
}

_id_4EB467C8F2A4C7AE(damagedata) {
  victim = damagedata.victim;

  if(isDefined(victim.modifiers) && istrue(victim.modifiers["victiminstronghold"])) {
    _id_831B0DF5DBB687CF = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(victim.origin);

    if(isDefined(_id_831B0DF5DBB687CF)) {
      if(!isDefined(_id_831B0DF5DBB687CF._id_B5AD6CA10E5301D7))
        _id_831B0DF5DBB687CF._id_B5AD6CA10E5301D7 = 0;

      _id_831B0DF5DBB687CF._id_B5AD6CA10E5301D7++;
      victim _id_0708329F09283076("killed", 0);
    }
  }
}

_id_CF0F7529918E7772(player) {
  player _id_0708329F09283076("timeout", 0);
}

_id_179B94929CC4C682(ent, attacker) {
  if(!isDefined(ent)) {
    return;
  }
  _id_A5DAF6A4BAF26AAF = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(ent, "agentStruct");

  if(isDefined(_id_A5DAF6A4BAF26AAF)) {
    _id_276AC5E84835EA87 = _id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87;

    if(isDefined(_id_276AC5E84835EA87)) {
      if(!isDefined(_id_276AC5E84835EA87.agentskilled))
        _id_276AC5E84835EA87.agentskilled = 0;

      _id_276AC5E84835EA87.agentskilled++;
    }
  }
}

_id_A9C8B07AF07F6F06(pickupent) {
  if(_id_7E52B56769FA7774::_id_02D86BA79A58BB62(pickupent.scriptablename)) {
    _id_276AC5E84835EA87 = undefined;
    _id_1FAF51A7DC279A8B = undefined;

    if(isDefined(pickupent.instance)) {
      _id_276AC5E84835EA87 = pickupent.instance._id_A88417917D64076C;
      _id_1FAF51A7DC279A8B = pickupent.instance._id_1FAF51A7DC279A8B;
    } else {
      _id_276AC5E84835EA87 = pickupent._id_A88417917D64076C;
      _id_1FAF51A7DC279A8B = pickupent._id_1FAF51A7DC279A8B;
    }

    if(isDefined(_id_276AC5E84835EA87))
      _id_276AC5E84835EA87._id_EA7ACCBB6EDC9B55 = 1;

    if(isDefined(_id_1FAF51A7DC279A8B))
      _id_1FAF51A7DC279A8B._id_EA7ACCBB6EDC9B55 = 1;
  }
}

_id_2D1B322DE840D5F1(door, player) {
  _id_F0A9A5C4D6084AE7 = door._id_276AC5E84835EA87;

  if(istrue(_id_F0A9A5C4D6084AE7._id_933F9685674999FB) && !isDefined(_id_F0A9A5C4D6084AE7._id_606F47FE5A7A935D))
    _id_F0A9A5C4D6084AE7._id_606F47FE5A7A935D = 1;
}

_id_CD1564CA587BCD0D(_id_FABF84450735DD93, success) {
  if(!isDefined(self._id_AB822267AA74C573))
    self._id_AB822267AA74C573 = istrue(success);

  _id_B8EBE3F71A08AB40 = self._id_B8EBE3F71A08AB40;
  teams = _id_A86BDE7020AD5A77(_id_B8EBE3F71A08AB40);

  if(!isDefined(teams) || teams.size <= 0)
    teams = [_id_FABF84450735DD93];

  foreach(team in teams) {
    if(isDefined(team) && isDefined(self._id_1B0D1620DF6B0CFE) && isDefined(self._id_1B0D1620DF6B0CFE[team]) && isDefined(self._id_1B0D1620DF6B0CFE[team].activeplayers)) {
      _id_7273312620004BC3 = level.teamdata[team]["players"];
      _id_401C3A2E68AAB0FD = undefined;

      if(istrue(success) && team == _id_FABF84450735DD93)
        _id_401C3A2E68AAB0FD = "mission_success";
      else if(istrue(success))
        _id_401C3A2E68AAB0FD = "mission_completed_by_another_team";
      else
        _id_401C3A2E68AAB0FD = "mission_failed";

      foreach(player in _id_7273312620004BC3) {
        if(istrue(success)) {
          if(team == _id_FABF84450735DD93 || istrue(self._id_933F9685674999FB)) {
            if(!isDefined(player._id_9FCD93EB0B17894D))
              player._id_9FCD93EB0B17894D = [];

            player._id_9FCD93EB0B17894D[player._id_9FCD93EB0B17894D.size] = self;
          }
        }

        if(scripts\engine\utility::array_contains(self._id_1B0D1620DF6B0CFE[team].activeplayers, player))
          player _id_0708329F09283076(_id_401C3A2E68AAB0FD, istrue(success) && team == _id_FABF84450735DD93);
      }
    }
  }
}

_id_35E00E890DFEE7B4(_id_FABF84450735DD93, success) {
  _id_7273312620004BC3 = level.teamdata[_id_FABF84450735DD93]["players"];
  _id_401C3A2E68AAB0FD = undefined;

  if(istrue(success))
    _id_401C3A2E68AAB0FD = "mission_success";
  else
    _id_401C3A2E68AAB0FD = "mission_failed";

  foreach(player in _id_7273312620004BC3) {
    if(istrue(success)) {
      if(!isDefined(player._id_9FCD93EB0B17894D))
        player._id_9FCD93EB0B17894D = [];

      player._id_9FCD93EB0B17894D[player._id_9FCD93EB0B17894D.size] = self;
    }

    if(scripts\engine\utility::array_contains(self._id_1B0D1620DF6B0CFE[_id_FABF84450735DD93].activeplayers, player))
      player _id_0708329F09283076(_id_401C3A2E68AAB0FD, istrue(success));
  }
}

_id_A86BDE7020AD5A77(_id_B8EBE3F71A08AB40) {
  if(isDefined(_id_B8EBE3F71A08AB40.teams) && _id_B8EBE3F71A08AB40.teams.size > 0)
    return _id_B8EBE3F71A08AB40.teams;

  teams = [];

  foreach(player in level.players) {
    if(!scripts\engine\utility::array_contains(teams, player.team) && isDefined(player._id_02C2F43DD4153F5A) && isDefined(player._id_02C2F43DD4153F5A._id_276AC5E84835EA87) && player._id_02C2F43DD4153F5A._id_276AC5E84835EA87._id_B8EBE3F71A08AB40 == _id_B8EBE3F71A08AB40)
      teams[teams.size] = player.team;
  }

  return teams;
}

_id_D584FAAFA7C6C60C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(isDefined(player._id_02C2F43DD4153F5A) && isDefined(player._id_02C2F43DD4153F5A._id_276AC5E84835EA87)) {
    _id_276AC5E84835EA87 = player._id_02C2F43DD4153F5A._id_276AC5E84835EA87;

    if(isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE) && scripts\engine\utility::array_contains_key(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE, _id_8A04AA0E0755E7E3)) {
      _id_276AC5E84835EA87 _id_17F1328AA045B61D(self, "assimilation", 0, undefined, _id_8A04AA0E0755E7E3);

      if(isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3].activeplayers) && _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3].activeplayers.size <= 0) {
        if(isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3]._id_5F8FC154303502FA) && (_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3]._id_5F8FC154303502FA.size > 1 || _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3]._id_5F8FC154303502FA.size == 1 && _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3]._id_5F8FC154303502FA[0] != player))
          _id_276AC5E84835EA87 _id_28E81A288CB740FD(_id_8A04AA0E0755E7E3, 0);
        else
          _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[_id_8A04AA0E0755E7E3] = undefined;
      }
    }

    _id_276AC5E84835EA87 _id_36FC8BC7E3143858(player, undefined, "assimilation");
  }
}

_id_36FC8BC7E3143858(player, timestamp, _id_401C3A2E68AAB0FD) {
  _id_276AC5E84835EA87 = self;

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE = [];

  _id_276AC5E84835EA87 _id_3A3FA57E7D5A15BC(player.team);

  if(!scripts\engine\utility::array_contains(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_5F8FC154303502FA, player))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_5F8FC154303502FA[_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_5F8FC154303502FA.size] = player;

  if(!scripts\engine\utility::array_contains(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team].activeplayers, player))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team].activeplayers[_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team].activeplayers.size] = player;

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F = [];

  _id_011074D7853CC966 = spawnStruct();
  _id_011074D7853CC966._id_593C8D0670688506 = player _meth_7A32B0201993D7F7();
  _id_011074D7853CC966.type = "attempt_enter";

  if(isDefined(_id_401C3A2E68AAB0FD))
    _id_011074D7853CC966._id_401C3A2E68AAB0FD = _id_401C3A2E68AAB0FD;
  else
    _id_011074D7853CC966._id_401C3A2E68AAB0FD = "enter_volume";

  if(isDefined(timestamp))
    _id_011074D7853CC966.timestamp = timestamp;
  else
    _id_011074D7853CC966.timestamp = gettime();

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F = [];

  _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F[_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[player.team]._id_93FA0AFA04AE392F.size] = _id_011074D7853CC966;
}

_id_17F1328AA045B61D(player, _id_401C3A2E68AAB0FD, success, timestamp, team) {
  _id_276AC5E84835EA87 = self;

  if(!isDefined(team))
    team = player.team;

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE = [];

  if(!scripts\engine\utility::array_contains_key(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE, team))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team] = spawnStruct();

  if(isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team].activeplayers) && scripts\engine\utility::array_contains(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team].activeplayers, player))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team].activeplayers = scripts\engine\utility::array_remove(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team].activeplayers, player);

  _id_011074D7853CC966 = spawnStruct();
  _id_011074D7853CC966._id_593C8D0670688506 = player _meth_7A32B0201993D7F7();
  _id_011074D7853CC966.type = "attempt_exit";
  _id_011074D7853CC966._id_401C3A2E68AAB0FD = _id_401C3A2E68AAB0FD;

  if(isDefined(timestamp))
    _id_011074D7853CC966.timestamp = timestamp;
  else
    _id_011074D7853CC966.timestamp = gettime();

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team]._id_93FA0AFA04AE392F))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team]._id_93FA0AFA04AE392F = [];

  _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team]._id_93FA0AFA04AE392F[_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team]._id_93FA0AFA04AE392F.size] = _id_011074D7853CC966;
}

_id_3A3FA57E7D5A15BC(team) {
  _id_276AC5E84835EA87 = self;

  if(!isDefined(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE))
    _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE = [];

  if(scripts\engine\utility::array_contains_key(_id_276AC5E84835EA87._id_1B0D1620DF6B0CFE, team)) {
    return;
  }
  _id_2838F16E236F9729 = spawnStruct();
  _id_2838F16E236F9729.activeplayers = [];
  _id_2838F16E236F9729._id_276AC5E84835EA87 = scripts\engine\utility::string(_id_276AC5E84835EA87.name);
  _id_2838F16E236F9729.starttime = gettime();
  _id_2838F16E236F9729.endtime = undefined;
  _id_2838F16E236F9729.team = team;
  _id_2838F16E236F9729._id_5F8FC154303502FA = [];
  _id_2838F16E236F9729._id_AA1ED8F12D71A7A5 = _id_276AC5E84835EA87._id_B8EBE3F71A08AB40.ref;

  if(isDefined(_id_276AC5E84835EA87._id_AB822267AA74C573))
    _id_2838F16E236F9729._id_AA1ED8F12D71A7A5 = "secondary_objective";

  _id_276AC5E84835EA87._id_1B0D1620DF6B0CFE[team] = _id_2838F16E236F9729;
}

_id_28E81A288CB740FD(team, success) {
  if(!isDefined(self._id_C4B448E975A0779B))
    self._id_C4B448E975A0779B = 0;

  self._id_C4B448E975A0779B++;

  if(istrue(success)) {
    if(!isDefined(self._id_AA5411BE41E77330))
      self._id_AA5411BE41E77330 = 0;

    self._id_AA5411BE41E77330++;
  } else {
    if(!isDefined(self._id_1806AED2B99E26C2))
      self._id_1806AED2B99E26C2 = 0;

    self._id_1806AED2B99E26C2++;
  }

  _id_670E5879926B51EF = self._id_1B0D1620DF6B0CFE[team];
  _id_670E5879926B51EF.endtime = gettime();
  _id_670E5879926B51EF.success = success;
  _id_670E5879926B51EF._id_0774C9CA5D1D6221 = scripts\mp\utility\teams::getteamcount(team, 0);
  self._id_1B0D1620DF6B0CFE[team] = undefined;
  _id_F36FB22C2233A40C(_id_670E5879926B51EF);
}

_id_F36FB22C2233A40C(_id_AF25493332D5CA3A) {
  _id_333514EF00DADB65 = [];

  if(isDefined(_id_AF25493332D5CA3A._id_93FA0AFA04AE392F) && _id_AF25493332D5CA3A._id_93FA0AFA04AE392F.size > 0) {
    foreach(_id_CE0F3C78F560174F in _id_AF25493332D5CA3A._id_93FA0AFA04AE392F)
    _id_333514EF00DADB65[_id_333514EF00DADB65.size] = ["event_type", _id_CE0F3C78F560174F.type, "reason", _id_CE0F3C78F560174F._id_401C3A2E68AAB0FD, "timestamp", _id_CE0F3C78F560174F.timestamp, "uno_id", _id_CE0F3C78F560174F._id_593C8D0670688506];
  }

  _id_0775FF28D397A2B6 = ["player_events", _id_333514EF00DADB65, "fortress", _id_AF25493332D5CA3A._id_276AC5E84835EA87, "success", _id_AF25493332D5CA3A.success, "mission", _id_AF25493332D5CA3A._id_AA1ED8F12D71A7A5, "start_time", _id_AF25493332D5CA3A.starttime, "end_time", _id_AF25493332D5CA3A.endtime, "team", _id_AF25493332D5CA3A.team, "team_size", _id_AF25493332D5CA3A._id_0774C9CA5D1D6221, "team_participation_count", _id_AF25493332D5CA3A._id_5F8FC154303502FA.size];
  dlog_recordevent("dlog_event_br_stronghold_attempt", _id_0775FF28D397A2B6);
}

_id_DF74213F854433F9() {
  _id_B205D90302DA2F07 = "unknown";
  _id_4CC263F13D4416B1 = "unknown";
  _id_F2F70EFC26EEC1EC = "unknown";
  _id_6F9B9B4E74136C02 = _id_744CAD313ED0A87E::_id_B7A9796C95AA8E8D();
  _id_C4B448E975A0779B = 0;
  _id_AA5411BE41E77330 = 0;
  _id_1806AED2B99E26C2 = 0;
  _id_B5AD6CA10E5301D7 = 0;
  _id_25087194B5E05D51 = 0;
  _id_5B9DE011A1715B33 = 0;
  _id_AB822267AA74C573 = 0;
  _id_EA7ACCBB6EDC9B55 = istrue(self._id_EA7ACCBB6EDC9B55);
  _id_7BE8B486A10B3DE8 = istrue(self._id_933F9685674999FB) && istrue(self._id_7BE8B486A10B3DE8);

  if(isDefined(self._id_B205D90302DA2F07))
    _id_B205D90302DA2F07 = self._id_B205D90302DA2F07;

  if(isDefined(self.name))
    _id_4CC263F13D4416B1 = scripts\engine\utility::string(self.name);

  if(isDefined(self.origin))
    _id_F2F70EFC26EEC1EC = scripts\engine\utility::string(self.origin);

  if(isDefined(self._id_C4B448E975A0779B))
    _id_C4B448E975A0779B = self._id_C4B448E975A0779B;

  if(isDefined(self._id_AA5411BE41E77330))
    _id_AA5411BE41E77330 = self._id_AA5411BE41E77330;

  if(isDefined(self._id_1806AED2B99E26C2))
    _id_1806AED2B99E26C2 = self._id_1806AED2B99E26C2;

  if(isDefined(self._id_B5AD6CA10E5301D7))
    _id_B5AD6CA10E5301D7 = self._id_B5AD6CA10E5301D7;

  if(isDefined(self.agentskilled))
    _id_25087194B5E05D51 = self.agentskilled;

  if(isDefined(self.crate) && isDefined(self.crate._id_4261EB2AB67DB6F7))
    _id_5B9DE011A1715B33 = self.crate._id_4261EB2AB67DB6F7.size;

  if(isDefined(self._id_AB822267AA74C573))
    _id_AB822267AA74C573 = istrue(self._id_AB822267AA74C573);

  _id_434809FD34BABEE0 = ["poi", _id_B205D90302DA2F07, "name", _id_4CC263F13D4416B1, "origin", _id_F2F70EFC26EEC1EC, "tier", _id_6F9B9B4E74136C02, "is_blacksite", istrue(self._id_933F9685674999FB), "attempts", _id_C4B448E975A0779B, "successes", _id_AA5411BE41E77330, "failures", _id_1806AED2B99E26C2, "player_deaths", _id_B5AD6CA10E5301D7, "ai_deaths", _id_25087194B5E05D51, "loadouts_taken", _id_5B9DE011A1715B33, "mission_cleared", _id_AB822267AA74C573, "key_picked_up", _id_EA7ACCBB6EDC9B55, "blacksite_unlocked", _id_7BE8B486A10B3DE8];
  dlog_recordevent("dlog_event_br_stronghold_data", _id_434809FD34BABEE0);
}

initcashtracking() {
  level.cashtypes = [];
  level.cashtypes[level.cashtypes.size] = "loot";
  level.cashtypes[level.cashtypes.size] = "mission";
  level.cashtypes[level.cashtypes.size] = "combat";
  level.cashtypes[level.cashtypes.size] = "cache";
  level.cashtypes[level.cashtypes.size] = "cache_legendary";
  level.cashtypes[level.cashtypes.size] = "cache_scavenger";
  level.cashtypes[level.cashtypes.size] = "cache_secretstash";
  level.cashtypes[level.cashtypes.size] = "reusable_cache";
  level.cashtypes[level.cashtypes.size] = "cache_personal_supply";
  level.cashtypes[level.cashtypes.size] = "loot_chopper";
  level.cashtypes[level.cashtypes.size] = "c130_box";
  level.cashmetrics = [];

  foreach(team in level.teamnamelist) {
    data = spawnStruct();
    data.sources = [];
    data.totaldata = [];

    foreach(type in level.cashtypes) {
      data.sources[type] = 0;
      data.totaldata[type] = 0;
    }

    level.cashmetrics[team] = data;
  }

  level waittill("prematch_done");
  level thread recordinterval();
}

recordinterval() {
  for(waittime = 60.0; !istrue(level.gameended); waittime = max(60.0 - _id_48A78BEE31DAA649, 0)) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_ended", waittime);
    starttime = gettime();
    _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();

    foreach(team in level.teamnamelist) {
      if(!isDefined(team)) {
        continue;
      }
      time = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      _id_EC6A81EAC0E4DC61 = [];
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_complete";
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time";
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "team";
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = team;
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "placement";
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C3E10A42A81ADE25[team];

      foreach(type in level.cashtypes) {
        value = level.cashmetrics[team].sources[type];
        _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "cash_source_" + type;
        _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = value;
        level.cashmetrics[team].totaldata[type] = level.cashmetrics[team].totaldata[type] + value;
        level.cashmetrics[team].sources[type] = 0;
      }

      dlog_recordevent("dlog_event_blood_money_interval", _id_EC6A81EAC0E4DC61);
      waitframe();
    }

    _id_48A78BEE31DAA649 = (gettime() - starttime) * 0.001;
  }

  time = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();

  foreach(team in level.teamnamelist) {
    _id_EC6A81EAC0E4DC61 = [];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_complete";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 1;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "time";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = time;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "team";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = team;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "placement";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C3E10A42A81ADE25[team];

    foreach(type in level.cashtypes) {
      value = level.cashmetrics[team].totaldata[type];
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "cash_source_" + type;
      _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = value;
    }

    dlog_recordevent("dlog_event_blood_money_interval", _id_EC6A81EAC0E4DC61);
  }
}

trackcashevent(player, type, amount) {
  if(!isDefined(level.cashmetrics) || !isDefined(player) || !isDefined(player.team)) {
    return;
  }
  team = player.team;
  level.cashmetrics[team].sources[type] = level.cashmetrics[team].sources[type] + amount;
}

onmatchstartbr() {
  thread _onmatchstartbr();
}

_onmatchstartbr() {
  waittillframeend;
  _id_FAF0D2FAC3F47583 = level.brgametype.name;
  maxteamsize = scripts\engine\utility::getintorzero(level.maxteamsize);
  _id_D12A341B40354143 = scripts\engine\utility::getintorzero(level.players.size);
  _id_652F47620AC4713F = getteamcount();
  _id_B287376C626B75B6 = 0;

  foreach(player in level.players) {
    if(isbot(player) || player isplayerheadless()) {
      continue;
    }
    _id_B287376C626B75B6++;
  }

  if(isDefined(level.br_armory_kiosk))
    _id_A3D16EC55B882CCD = scripts\engine\utility::getintorzero(level.br_armory_kiosk.teamrevivecost);
  else
    _id_A3D16EC55B882CCD = 0;

  _id_5CEAEA1D11F6F7F5 = scripts\engine\utility::getintorzero(level.usegulag);

  if(isDefined(level.gulag)) {
    _id_F2C958A504A3BD33 = scripts\engine\utility::getintorzero(level.gulag.maxuses);
    _id_55F22A96A43D437E = scripts\engine\utility::getintorzero(level.gulag.numarmorhealth);
    _id_41046871E0C8B9A8 = scripts\engine\utility::getintorzero(level.gulag.spawnloot);
  } else {
    _id_F2C958A504A3BD33 = 0;
    _id_55F22A96A43D437E = 0;
    _id_41046871E0C8B9A8 = 0;
  }

  _id_9D8974FF163F463D = [];

  if(getdvarint("scr_br_quests_enabled", 1) && isDefined(level.questinfo)) {
    foreach(type, info in level.questinfo.tabletinfo) {
      _id_9D8974FF163F463D[_id_9D8974FF163F463D.size] = "name";
      _id_9D8974FF163F463D[_id_9D8974FF163F463D.size] = type;
      _id_E60552DD6ABCC4AA = isDefined(info) && istrue(info.enabled);
      _id_9D8974FF163F463D[_id_9D8974FF163F463D.size] = "is_enabled";
      _id_9D8974FF163F463D[_id_9D8974FF163F463D.size] = _id_E60552DD6ABCC4AA;
    }
  }

  _id_85D8DAEAC55B1742 = scripts\engine\utility::getintorzero(getplaylistid());

  if(isDefined(level.prematchendtime))
    prematchendtime = level.prematchendtime;
  else
    prematchendtime = -1;

  _id_527BEDD9C6434673 = _func_676CFE2AB64EA758();
  dlog_recordevent("dlog_event_br_server_match_start", ["br_mission_type_info", _id_9D8974FF163F463D, "map", level.script, "sub_game_type", _id_FAF0D2FAC3F47583, "max_team_size", maxteamsize, "player_count", _id_D12A341B40354143, "human_player_count", _id_B287376C626B75B6, "team_count", _id_652F47620AC4713F, "kiosk_respawn_cost", _id_A3D16EC55B882CCD, "gulag_active", _id_5CEAEA1D11F6F7F5, "gulag_max_uses", _id_F2C958A504A3BD33, "gulag_starting_armor", _id_55F22A96A43D437E, "gulag_spawn_loot", _id_41046871E0C8B9A8, "prematch_end_time", prematchendtime, "playlist_id", _id_85D8DAEAC55B1742, "frame_duration", _id_527BEDD9C6434673]);
}

getteamcount() {
  _id_652F47620AC4713F = 0;

  foreach(team in level.teamnamelist) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

    if(_id_A6AB8D0FDA441DC2.size > 0 || isDefined(level._id_7B37B2193F163B9B) && scripts\mp\utility\teams::getteamdata(team, "UIBotCount") > 0)
      _id_652F47620AC4713F++;
  }

  return _id_652F47620AC4713F;
}

_id_AFD45555767F3079() {
  if(!branalytics_validation()) {
    return;
  }
  _id_C2B11EB497782122 = 0;
  _id_0B94285D34C4E325 = 0;
  _id_2235CD5C616A1881 = 0;

  if(isDefined(level.gulag) && isDefined(level.gulag.arenas)) {
    foreach(arena in level.gulag.arenas) {
      _id_C2B11EB497782122 = _id_C2B11EB497782122 + scripts\engine\utility::_id_53C4C53197386572(arena._id_19FE32F41A41C7FF, 0);
      _id_0B94285D34C4E325 = _id_0B94285D34C4E325 + scripts\engine\utility::_id_53C4C53197386572(arena._id_60AF67BCAAC1AA55, 0);
      _id_2235CD5C616A1881 = _id_2235CD5C616A1881 + scripts\engine\utility::_id_53C4C53197386572(arena._id_2235CD5C616A1881, 0);
    }
  }

  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "guards_attacked";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C2B11EB497782122;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "riots_triggered";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_0B94285D34C4E325;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "riots_completed";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_2235CD5C616A1881;
  dlog_recordevent("dlog_event_br_riot_totals", _id_EC6A81EAC0E4DC61);
}

_id_05098EE655AFED5D(_id_2212B25A680741D1, circleindex, result, participants, _id_0CF016AC8C9A85B7, _id_5101B29AC9644518) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "arena";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_2212B25A680741D1;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_index";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = circleindex;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "result";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = result;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "participants";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = participants;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "leftovers";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_0CF016AC8C9A85B7;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "released";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_5101B29AC9644518;
  dlog_recordevent("dlog_event_gulagbreak_result", _id_EC6A81EAC0E4DC61);
}

_id_885C6DAF0ECE2CF6(result, _id_7279F52998D85006) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "result";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = result;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "fail_reason";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7279F52998D85006;
  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    circleindex = level.br_circle.circleindex;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_index";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = circleindex;
  self dlog_recordplayerevent("dlog_event_reinforcement_flare_use", _id_EC6A81EAC0E4DC61);
}

_id_9D458FB3A5D1E86A(_id_456A8CDC6ECB54ED, placement, _id_BBAC576AADE31A1E, _id_F2982F79DD4F09F2, contracts, _id_675C2867DF19DCB8, _id_30B39E4F74A74528, _id_6ED21B763A987591) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "total_squad_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_456A8CDC6ECB54ED);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "placement";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(placement);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "total_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_BBAC576AADE31A1E);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "looted_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_F2982F79DD4F09F2);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "contract_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(contracts);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "valuable_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_675C2867DF19DCB8);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "cash_lost_on_death";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_30B39E4F74A74528);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "cash_lost_on_purchase";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_6ED21B763A987591);
  dlog_recordevent("dlog_event_br_plunder_match_totals", _id_EC6A81EAC0E4DC61);
}

_id_FDD0A4EFCD97F3BE(_id_8C52D6B43EF599D2, _id_44BB89567F147219, location) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "axis_contracts_completed";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8C52D6B43EF599D2;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "allies_contracts_completed";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_44BB89567F147219;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "location";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = location;
  dlog_recordevent("dlog_event_br_clash_contracts_completed", _id_EC6A81EAC0E4DC61);
}

_id_2F0FB1B1516DF8F8(_id_A0FF08200C2D1BAD, _id_E19CF53A2B0BC17E, location) {
  if(!branalytics_validation()) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "axis_score";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A0FF08200C2D1BAD;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "allies_score";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_E19CF53A2B0BC17E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "location";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = location;
  dlog_recordevent("dlog_event_br_clash_team_scores", _id_EC6A81EAC0E4DC61);
}