/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outline_utility.gsc
***********************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  level thread outlinecatchplayerdisconnect();
  level thread outlineonplayerjoinedteam();
  level thread outlineidswatchpending();
}

outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, type, _id_00FA3B23D51C2DC7) {
  if(!isDefined(_id_F20913FEC7561C5F.outlines))
    _id_F20913FEC7561C5F.outlines = [];

  _id_E1CECB04682E8442 = spawnStruct();
  _id_E1CECB04682E8442.isdisabled = 0;
  _id_E1CECB04682E8442.priority = outlineprioritygroupmap(prioritygroup);
  _id_E1CECB04682E8442.playersvisibleto = playersvisibleto;
  _id_E1CECB04682E8442.playersvisibletopending = [];
  _id_E1CECB04682E8442.hudoutlineassetname = hudoutlineassetname;
  _id_E1CECB04682E8442.type = type;

  if(type == "TEAM")
    _id_E1CECB04682E8442.team = _id_00FA3B23D51C2DC7;

  id = outlinegenerateuniqueid();
  _id_F20913FEC7561C5F.outlines[id] = _id_E1CECB04682E8442;
  outlineaddtogloballist(_id_F20913FEC7561C5F);
  _id_CDA6602A02C53BA3 = [];

  foreach(player in _id_E1CECB04682E8442.playersvisibleto) {
    if(!canoutlineforplayer(player)) {
      _id_E1CECB04682E8442.playersvisibletopending[_id_E1CECB04682E8442.playersvisibletopending.size] = player;
      level.outlineidspending[id] = _id_F20913FEC7561C5F;
      continue;
    }

    _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_F20913FEC7561C5F, player);

    if(!isDefined(_id_25A840A406E8542A) || _id_25A840A406E8542A == _id_E1CECB04682E8442 || _id_25A840A406E8542A.priority == _id_E1CECB04682E8442.priority)
      _id_CDA6602A02C53BA3[_id_CDA6602A02C53BA3.size] = player;
  }

  if(_id_CDA6602A02C53BA3.size > 0)
    _id_F20913FEC7561C5F _hudoutlineenableforclients(_id_CDA6602A02C53BA3, _id_E1CECB04682E8442.hudoutlineassetname);

  return id;
}

outlinedisableinternal(id, _id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(_id_420A996E67989DC4.outlines)) {
    outlineremovefromgloballist(_id_420A996E67989DC4);
    return;
  }

  _id_77C349ECEF6FB0D9 = _id_420A996E67989DC4.outlines[id];

  if(!isDefined(_id_77C349ECEF6FB0D9) || _id_77C349ECEF6FB0D9.isdisabled) {
    return;
  }
  _id_77C349ECEF6FB0D9.isdisabled = 1;

  foreach(player in _id_77C349ECEF6FB0D9.playersvisibleto) {
    if(!isDefined(player)) {
      continue;
    }
    if(!canoutlineforplayer(player)) {
      _id_77C349ECEF6FB0D9.playersvisibletopending[_id_77C349ECEF6FB0D9.playersvisibletopending.size] = player;
      level.outlineidspending[id] = _id_420A996E67989DC4;
      continue;
    }

    _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

    if(isDefined(_id_25A840A406E8542A)) {
      if(_id_25A840A406E8542A.priority <= _id_77C349ECEF6FB0D9.priority)
        _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);

      continue;
    }

    _id_420A996E67989DC4 hudoutlinedisableforclient(player);
  }

  if(_id_77C349ECEF6FB0D9.playersvisibletopending.size == 0) {
    _id_420A996E67989DC4.outlines[id] = undefined;

    if(_id_420A996E67989DC4.outlines.size == 0)
      outlineremovefromgloballist(_id_420A996E67989DC4);
  }
}

outlinerefreshinternal(_id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.outlines.size == 0) {
    return;
  }
  foreach(_id_5454630434983DD7, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    foreach(player in _id_E1CECB04682E8442.playersvisibleto) {
      if(!isDefined(player)) {
        continue;
      }
      _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

      if(isDefined(_id_25A840A406E8542A))
        _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
    }
  }
}

outlinecatchplayerdisconnect() {
  for(;;) {
    level waittill("connected", player);
    level thread outlineonplayerdisconnect(player);
  }
}

outlineonplayerdisconnect(player) {
  level endon("game_ended");
  player waittill("disconnect");
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
}

outlineonplayerjoinedteam() {
  for(;;) {
    level waittill("joined_team", player);

    if(!isDefined(player.team) || player.team == "spectator") {
      continue;
    }
    thread outlineonplayerjoinedteam_onfirstspawn(player);
  }
}

outlineonplayerjoinedteam_onfirstspawn(player) {
  player notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("disconnect");
  player waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
  outlineaddplayertoexistingteamoutlines(player);
}

outlineremoveplayerfromvisibletoarrays(player) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(_id_420A996E67989DC4 in level.outlineents) {
    _id_8408CBA753ABA3E3 = 0;

    foreach(_id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
      _id_E1CECB04682E8442.playersvisibleto = scripts\engine\utility::array_removeundefined(_id_E1CECB04682E8442.playersvisibleto);

      if(isDefined(player) && scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player)) {
        _id_E1CECB04682E8442.playersvisibleto = scripts\engine\utility::array_remove(_id_E1CECB04682E8442.playersvisibleto, player);
        _id_8408CBA753ABA3E3 = 1;
      }
    }

    if(_id_8408CBA753ABA3E3 && isDefined(_id_420A996E67989DC4) && isDefined(player))
      _id_420A996E67989DC4 hudoutlinedisableforclient(player);
  }
}

outlineaddplayertoexistingteamoutlines(player) {
  foreach(_id_420A996E67989DC4 in level.outlineents) {
    if(!isDefined(_id_420A996E67989DC4)) {
      continue;
    }
    _id_25A840A406E8542A = undefined;

    foreach(_id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
      if(_id_E1CECB04682E8442.type == "ALL" || _id_E1CECB04682E8442.type == "TEAM" && _id_E1CECB04682E8442.team == player.team) {
        if(!scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player))
          _id_E1CECB04682E8442.playersvisibleto[_id_E1CECB04682E8442.playersvisibleto.size] = player;
        else {}

        if(!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority)
          _id_25A840A406E8542A = _id_E1CECB04682E8442;
      }
    }

    if(isDefined(_id_25A840A406E8542A))
      _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
  }
}

outlinedisableinternalall(_id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4) || !isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.outlines.size == 0) {
    return;
  }
  foreach(id, _ in _id_420A996E67989DC4.outlines)
  outlinedisableinternal(id, _id_420A996E67989DC4);
}

outlineaddtogloballist(_id_420A996E67989DC4) {
  if(!scripts\engine\utility::array_contains(level.outlineents, _id_420A996E67989DC4))
    level.outlineents[level.outlineents.size] = _id_420A996E67989DC4;
}

outlineremovefromgloballist(_id_420A996E67989DC4) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, _id_420A996E67989DC4);
}

outlinegethighestpriorityid(_id_420A996E67989DC4) {
  result = -1;

  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.size == 0)
    return result;

  _id_25A840A406E8542A = undefined;

  foreach(id, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    if(!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority) {
      _id_25A840A406E8542A = _id_E1CECB04682E8442;
      result = id;
    }
  }

  return result;
}

outlinegethighestinfoforplayer(_id_420A996E67989DC4, player) {
  _id_25A840A406E8542A = undefined;

  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.size == 0)
    return _id_25A840A406E8542A;

  foreach(id, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    if(scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player) && (!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority))
      _id_25A840A406E8542A = _id_E1CECB04682E8442;
  }

  return _id_25A840A406E8542A;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

outlineprioritygroupmap(prioritygroup) {
  prioritygroup = tolower(prioritygroup);
  priority = undefined;

  switch (prioritygroup) {
    case "lowest":
      priority = 0;
      break;
    case "level_script":
      priority = 1;
      break;
    case "equipment":
      priority = 2;
      break;
    case "perk":
      priority = 3;
      break;
    case "perk_superior":
      priority = 4;
      break;
    case "killstreak":
      priority = 5;
      break;
    case "killstreak_personal":
      priority = 6;
      break;
    case "laststand":
      priority = 7;
      break;
    default:
      priority = 0;
      break;
  }

  return priority;
}

outlineiddowatch() {
  foreach(index, ent in level.outlineidspending) {
    if(!isDefined(ent)) {
      continue;
    }
    if(!isDefined(ent.outlines)) {
      continue;
    }
    _id_E1CECB04682E8442 = ent.outlines[index];

    if(!isDefined(_id_E1CECB04682E8442)) {
      continue;
    }
    if(_id_E1CECB04682E8442.playersvisibletopending.size > 0) {
      if(outlinerefreshpending(ent, index))
        level.outlineidspending[index] = undefined;
    }
  }
}

outlineidswatchpending() {
  for(;;) {
    waittillframeend;
    outlineiddowatch();
    waitframe();
  }
}

outlinerefreshpending(_id_420A996E67989DC4, id) {
  _id_E1CECB04682E8442 = _id_420A996E67989DC4.outlines[id];

  foreach(index, player in _id_E1CECB04682E8442.playersvisibletopending) {
    if(!isDefined(player)) {
      continue;
    }
    if(canoutlineforplayer(player)) {
      _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

      if(isDefined(_id_25A840A406E8542A))
        _id_420A996E67989DC4 hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
      else
        _id_420A996E67989DC4 hudoutlinedisableforclient(player);

      _id_E1CECB04682E8442.playersvisibletopending[index] = undefined;
    }
  }

  _id_E1CECB04682E8442.playersvisibletopending = scripts\engine\utility::array_removeundefined(_id_E1CECB04682E8442.playersvisibletopending);

  if(_id_E1CECB04682E8442.playersvisibletopending.size == 0) {
    if(_id_E1CECB04682E8442.isdisabled)
      _id_420A996E67989DC4.outlines[id] = undefined;

    if(_id_420A996E67989DC4.outlines.size == 0)
      outlineremovefromgloballist(_id_420A996E67989DC4);

    return 1;
  }

  return 0;
}

canoutlineforplayer(player) {
  return player.sessionstate != "spectator";
}

_hudoutlineenableforclient(_id_2C6CA80E296FED3A, hudoutlineassetname) {
  self hudoutlineenableforclient(_id_2C6CA80E296FED3A, hudoutlineassetname);
}

_hudoutlineenableforclients(_id_B66F9E35E36435BB, hudoutlineassetname) {
  self hudoutlineenableforclients(_id_B66F9E35E36435BB, hudoutlineassetname);
}

outlineenableforall(_id_F20913FEC7561C5F, hudoutlineassetname, prioritygroup) {
  playersvisibleto = level.players;
  return outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL");
}

outlineenableforteam(_id_F20913FEC7561C5F, _id_00FA3B23D51C2DC7, hudoutlineassetname, prioritygroup) {
  playersvisibleto = getteamdata(_id_00FA3B23D51C2DC7, "players");
  return outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", _id_00FA3B23D51C2DC7);
}

outlineenableforplayer(_id_F20913FEC7561C5F, _id_18EBEB29BB7541E3, hudoutlineassetname, prioritygroup) {
  if(isagent(_id_18EBEB29BB7541E3))
    return outlinegenerateuniqueid();

  return outlineenableinternal(_id_F20913FEC7561C5F, [_id_18EBEB29BB7541E3], hudoutlineassetname, prioritygroup, "ENTITY");
}

outlinedisable(id, _id_420A996E67989DC4) {
  outlinedisableinternal(id, _id_420A996E67989DC4);
}

outlinerefresh(_id_420A996E67989DC4) {
  outlinerefreshinternal(_id_420A996E67989DC4);
}

initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

addoutlineoccluder(position, radius) {
  _id_F676533B6410938E = spawnStruct();
  _id_F676533B6410938E.position = position;
  _id_F676533B6410938E.radius = radius;
  id = level.outlineoccludersid;
  level.outlineoccluders[id] = _id_F676533B6410938E;
  level.outlineoccludersid++;
  return id;
}

removeoutlineoccluder(id) {
  level.outlineoccluders[id] = undefined;
}

outlineoccluded(startpoint, endpoint) {
  foreach(occluder in level.outlineoccluders) {
    if(!isDefined(occluder) || !isDefined(occluder.position) || !isDefined(occluder.radius)) {
      continue;
    }
    if(scripts\engine\math::segmentvssphere(startpoint, endpoint, occluder.position, occluder.radius))
      return 1;
  }

  return 0;
}

_hudoutlineviewmodeldisable() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self hudoutlineviewmodeldisable();
}

_hudoutlineviewmodelenable(hudoutlineassetname, _id_DAFD99B070FB282A) {
  if(!isDefined(_id_DAFD99B070FB282A))
    _id_DAFD99B070FB282A = 0;

  if(!_id_DAFD99B070FB282A && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(_id_DAFD99B070FB282A && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(hudoutlineassetname);
    return;
  }

  self hudoutlineviewmodelenable(hudoutlineassetname);
}

hudoutlineviewmodelenableonnextspawn(hudoutlineassetname) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self hudoutlineviewmodelenable(hudoutlineassetname);
}

getteamdata(team, _id_8E9EF05D6E84968C) {
  return level.teamdata[team][_id_8E9EF05D6E84968C];
}