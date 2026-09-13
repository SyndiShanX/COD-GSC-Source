/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\infilexfil.gsc
************************************************/

infil_add(type, subtype, _id_F30FD2E505C341C8, _id_AA0773494F0D374D, _id_8EE2EF1B890C0C7B, spawn_func, _id_1FC48C4B6E73E047, _id_C2EB4C229CFC9D83) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils"))
    scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "get_all_infils", ::get_all_infils);

  while(!isDefined(level.teamnamelist))
    waitframe();

  if(!isDefined(game["infil"])) {
    foreach(team in level.teamnamelist)
    game["infil"][team] = [];

    game["infil"][0] = [];
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    _id_95DDBB3C67AF3DDE = get_all_infils(type);

    foreach(infil in _id_95DDBB3C67AF3DDE) {
      if(infil.name == subtype) {
        if(isDefined(infil.script_label) && infil.script_label == level.localeid) {
          break;
        }
      }
    }
  }

  if(isDefined(game["infil"][0][type]) && isDefined(game["infil"][0][type][subtype])) {
    if(isDefined(game["infil"][0][type][subtype][6]))
      self[[game["infil"][0][type][subtype][6]]](type, subtype);

    return;
  }

  game["infil"][0][type][subtype] = [];
  game["infil"][0][type][subtype][0] = spawn_func;
  game["infil"][0][type][subtype][1] = _id_C2EB4C229CFC9D83;
  game["infil"][0][type][subtype][2] = _id_1FC48C4B6E73E047;
  game["infil"][0][type][subtype][3] = _id_F30FD2E505C341C8;
  game["infil"][0][type][subtype][4] = _id_AA0773494F0D374D;
  game["infil"][0][type][subtype][5] = _id_8EE2EF1B890C0C7B;
}

infil_is_interactive() {
  if(!isDefined(level.interactiveinfil))
    level.interactiveinfil = getdvarint("scr_infil_interactive", 0) == 1;

  return level.interactiveinfil;
}

infil_init() {
  level._id_CAC1C5779002911A = getdvarint("dvar_1B3B51B6F9A78F94", 3.0);
  level._id_333FBCCF73785411 = getdvarint("dvar_C33A1BA677B4AEE9", 3.0);
  level._id_C96464F39952B78A = scripts\mp\utility\infilexfil::_id_C96464F39952B78A;

  if(level.rankedmatch && !isdedicatedserver()) {
    game["infil"] = undefined;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  if(game["roundsPlayed"] > 0 || getdvarint("scr_game_infilSkip", 0) == 1 || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || getdvarint("scr_game_matchstarttime") < 15 || scripts\mp\utility\game::getgametype() == "war" && scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    game["infil"] = undefined;
    level.requiredplayercount["allies"] = 0;
    level.requiredplayercount["axis"] = 0;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  if(!isDefined(level.prematchperiodend) || level.prematchperiodend == 0) {
    game["infil"] = undefined;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  while(!isDefined(level.teamnamelist))
    waitframe();

  if(scripts\mp\gamelogic::shouldmodelognotify())
    logstring("IWH-315293: ALBACORE: level.teamNameList while finished");

  waitframe();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  level.prematchallowfunc = ::infil_player_allow;
  _id_BA9A385288D1A919 = undefined;
  level.infilsactive = 0;
  _id_8FD71CE382F455A2 = [];

  foreach(_id_D78FFD67F2183062 in get_all_infils()) {
    type = _id_D78FFD67F2183062.script_noteworthy;
    subtype = _id_D78FFD67F2183062.name;

    if(!_id_D78FFD67F2183062 infil_is_gamemode()) {
      continue;
    }
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(_id_D78FFD67F2183062.name == subtype) {
        if(!isDefined(_id_D78FFD67F2183062.script_label) || _id_D78FFD67F2183062.script_label != level.localeid)
          continue;
      }
    }

    if(level.mapname == "mp_wartorn" && scripts\mp\utility\game::getgametype() == "rescue")
      _id_D78FFD67F2183062.script_team = scripts\mp\utility\game::getotherteam(_id_D78FFD67F2183062.script_team)[0];

    team = _id_D78FFD67F2183062.script_team;

    if(!scripts\engine\utility::array_contains(_id_8FD71CE382F455A2, team))
      _id_8FD71CE382F455A2[_id_8FD71CE382F455A2.size] = team;
  }

  if(_id_8FD71CE382F455A2.size == level.teamnamelist.size) {
    foreach(_id_D78FFD67F2183062 in get_all_infils()) {
      type = _id_D78FFD67F2183062.script_noteworthy;
      subtype = _id_D78FFD67F2183062.name;

      if(!_id_D78FFD67F2183062 infil_is_gamemode()) {
        continue;
      }
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
        if(_id_D78FFD67F2183062.name == subtype) {
          if(!isDefined(_id_D78FFD67F2183062.script_label) || _id_D78FFD67F2183062.script_label != level.localeid)
            continue;
        }
      }

      if(_id_D78FFD67F2183062 infil_has_map_config())
        infil_init_spawn_selection();

      if(_id_D78FFD67F2183062 infil_is_type(type) && _id_D78FFD67F2183062 infil_is_subtype(subtype) && scripts\mp\utility\teams::isgameplayteam(_id_D78FFD67F2183062.script_team)) {
        level.infilsactive++;
        _id_643BCFEC059B4AE2 = game["infil"][0][type][subtype];
        originalsubtype = subtype;
        _id_6B997733C80961C4 = subtype;

        if(issubstr(_id_6B997733C80961C4, "alpha"))
          _id_6B997733C80961C4 = "alpha";

        if(issubstr(_id_6B997733C80961C4, "bravo"))
          _id_6B997733C80961C4 = "bravo";

        if(!isDefined(_id_643BCFEC059B4AE2))
          _id_643BCFEC059B4AE2 = game["infil"][0][type][_id_6B997733C80961C4];

        _id_74DB343D270DE78F = _id_D78FFD67F2183062[[_id_643BCFEC059B4AE2[0]]](_id_D78FFD67F2183062.script_team, _id_D78FFD67F2183062.target, _id_6B997733C80961C4, originalsubtype);
        _id_74DB343D270DE78F.players = [];
        _id_74DB343D270DE78F.type = type;
        _id_74DB343D270DE78F.originalsubtype = originalsubtype;
        _id_74DB343D270DE78F.subtype = _id_6B997733C80961C4;
        _id_74DB343D270DE78F.infillength = _id_74DB343D270DE78F[[_id_643BCFEC059B4AE2[2]]](originalsubtype);

        if(!isDefined(_id_BA9A385288D1A919) || _id_BA9A385288D1A919 < _id_74DB343D270DE78F.infillength)
          _id_BA9A385288D1A919 = _id_74DB343D270DE78F.infillength;

        team = _id_D78FFD67F2183062.script_team;

        if(getdvarint("dvar_AC31997B109B6BC5", 0) == 1)
          team = scripts\mp\utility\teams::getenemyteams(team)[0];

        game["infil"][team][1][type][subtype] = _id_74DB343D270DE78F;
        register_infil_spots(team, _id_74DB343D270DE78F, _id_643BCFEC059B4AE2[3], _id_643BCFEC059B4AE2[4], _id_643BCFEC059B4AE2[5], _id_643BCFEC059B4AE2[1]);
      }
    }
  }

  if(scripts\mp\utility\game::gamehasinfil() && isDefined(_id_BA9A385288D1A919)) {
    level thread onplayerspawned();
    level thread _id_3C075BF6EADE7262();
    level.prematchperiod = getdvarint("scr_game_graceperiod", 15);
    level.matchcountdowntime = level.prematchperiod + level._id_CAC1C5779002911A + level._id_333FBCCF73785411;
    level.prematchperiodend = _id_BA9A385288D1A919 + level._id_CAC1C5779002911A + level._id_333FBCCF73785411;
    thread scripts\mp\gamelogic::matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
    level thread infil_setup_ui();
    level thread infil_wait_for_players();
    level thread waitandunloadinfils();
    scripts\mp\flags::gameflagset("infil_will_run");
  }

  scripts\mp\flags::gameflagset("infil_setup_complete");
}

onplayerspawned() {
  level endon("infil_started");

  for(;;) {
    level waittill("player_spawned", player);
    player thread waitforstreamsynccomplete();
  }
}

waitforstreamsynccomplete() {
  level endon("infil_started");
  self endon("death_or_disconnect");
  scripts\mp\flags::gameflagwait("infil_setup_complete");

  if(istrue(level._id_2A15D29E8890B785)) {
    return;
  }
  if(isDefined(self.team)) {
    if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
      _id_BA487744C1313B1F = (0, 0, 0);
      count = 0;

      if(isDefined(game["infil"]) && isDefined(game["infil"][self.team]) && isDefined(game["infil"][self.team][1])) {
        foreach(key, array in game["infil"][self.team][1]) {
          foreach(ent in array) {
            _id_BA487744C1313B1F = _id_BA487744C1313B1F + ent.origin;
            count++;
          }
        }
      }

      if(count > 0)
        _id_BA487744C1313B1F = _id_BA487744C1313B1F / count;

      self _meth_B88C89BB7CD1AB8E(_id_BA487744C1313B1F);
    }
  }

  while(!istrue(self.pers["streamSyncComplete"]))
    waitframe();

  _id_BE4FBABEAFB491A7 = get_spot_from_player(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  if(isDefined(_id_BE4FBABEAFB491A7))
    player_free_spot(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  player_join_infil();
}

onplayerdisconnect(player) {
  if(!isDefined(player.infil)) {
    return;
  }
  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  player_free_spot(player, player.team);
}

onplayerchangeteams() {
  level endon("prematch_over");
  self endon("player_free_spot");
  team = self.team;
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  player_free_spot(self, team);
}

get_all_infils(_id_643BCFEC059B4AE2) {
  if(isDefined(_id_643BCFEC059B4AE2))
    return scripts\engine\utility::getStructArray(_id_643BCFEC059B4AE2, "script_noteworthy");
  else
    return scripts\engine\utility::getStructArray("mp_infil", "targetname");
}

infil_is_type(_id_643BCFEC059B4AE2) {
  return self.script_noteworthy == _id_643BCFEC059B4AE2;
}

infil_is_subtype(_id_D099B99A4515F378) {
  return self.name == _id_D099B99A4515F378;
}

infil_is_gamemode() {
  if(!isDefined(self.spawnflags) || self.spawnflags == 0)
    return 0;

  if(!level.teambased)
    return 0;

  if(getdvarint("dvar_078FC5B05AEFC64A", 1) == 1 && level.mapname == "mp_grandprix_pm_2")
    return 0;

  if(self.spawnflags & 1) {
    switch (level.mapname) {
      case "mp_petrograd":
        if(level.gametype == "sd")
          return 0;

        break;
      case "mp_piccadilly":
        if(level.gametype == "sd")
          return 0;

        break;
      case "mp_crash2":
        if(level.gametype == "dd")
          return 0;

        break;
      case "mp_catedral_hlwn":
      case "mp_catedral":
        if(level.gametype == "sd" || level.gametype == "rescue")
          return 0;

        break;
    }

    return 1;
  }

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "tjugg":
      case "grind":
      case "war":
      case "pill":
      case "conf":
        return 1;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "dd":
      case "sr":
      case "sd":
        if(level.mapname == "mp_petrograd" || level.mapname == "mp_piccadilly")
          return 0;
        else
          return 1;
      case "rescue":
        return 1;
    }
  }

  if(self.spawnflags & 8) {
    switch (level.gametype) {
      case "siege":
      case "dom":
        return 1;
    }
  }

  if(self.spawnflags & 16) {
    switch (level.gametype) {
      case "grnd":
      case "koth":
      case "hq":
        return 1;
    }
  }

  if(self.spawnflags & 32) {
    switch (level.gametype) {
      case "ctf":
        return 1;
    }
  }

  if(self.spawnflags & 64) {
    switch (level.gametype) {
      case "cyber":
        return 1;
    }
  }

  if(self.spawnflags & 128) {
    switch (level.gametype) {
      case "cmd":
      case "gwtdm":
      case "gwbomb":
      case "bigctf":
      case "conflict":
      case "risk":
      case "arm":
        return 1;
    }
  }

  return 0;
}

infil_has_map_config() {
  return 0;
}

infil_init_spawn_selection() {}

infil_player_allow(_id_CD187E38E3DF8F36, _id_B546524B3FD3D9C9) {
  if(self ishost() && getdvarint("dvar_F711F210F6FFD355") == 1) {
    if(!_id_CD187E38E3DF8F36)
      _id_3B64EB40368C1450::set("infil_player", "weapon", 0);
    else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");

    return;
  }

  if(!scripts\mp\utility\game::teamhasinfil(self.team) && !istrue(_id_B546524B3FD3D9C9)) {
    scripts\mp\playerlogic::playerprematchallow(_id_CD187E38E3DF8F36);
    return;
  }

  if(!_id_CD187E38E3DF8F36) {
    _id_3B64EB40368C1450::set("infil_player", "allow_movement", 0);
    _id_3B64EB40368C1450::set("infil_player", "prone", 0);
    _id_3B64EB40368C1450::set("infil_player", "crouch", 0);
    _id_3B64EB40368C1450::set("infil_player", "allow_jump", 0);
    _id_3B64EB40368C1450::set("infil_player", "fire", 0);
    _id_3B64EB40368C1450::set("infil_player", "ads", 0);
    _id_3B64EB40368C1450::set("infil_player", "sprint", 0);
    _id_3B64EB40368C1450::set("infil_player", "melee", 0);
    _id_3B64EB40368C1450::set("infil_player", "lean", 0);
    _id_3B64EB40368C1450::set("infil_player", "slide", 0);
    _id_3B64EB40368C1450::set("infil_player", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("infil_player", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("infil_player", "usability", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
}

register_infil_spots(team, infil, amount, _id_4B62AA3A1860D0AC, _id_30EC18A4C33AF064, _id_F3F5EF500ADAC836) {
  if(!isDefined(game["infil"][team][0]))
    game["infil"][team][0] = [];

  _id_2F55781AF96F22F9 = game["infil"][team][0].size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    index = game["infil"][team][0].size;

    if(isDefined(_id_30EC18A4C33AF064)) {
      _id_B8EB6872CE4193F8 = 0;

      foreach(priority, _id_4DF083E7CE48A6E5 in _id_30EC18A4C33AF064) {
        foreach(seat in _id_4DF083E7CE48A6E5) {
          if(seat == index - _id_2F55781AF96F22F9) {
            game["infil"][team][0][index][3] = priority;
            _id_B8EB6872CE4193F8 = 1;
            break;
          }
        }

        if(_id_B8EB6872CE4193F8) {
          break;
        }
      }
    } else
      game["infil"][team][0][index][3] = -1;

    game["infil"][team][0][index][0] = _id_AC0E594AC96AA3A8;
    game["infil"][team][0][index][1] = infil;
    game["infil"][team][0][index][2] = _id_F3F5EF500ADAC836;
  }

  if(!istrue(level.requiredplayercountoveride))
    level.requiredplayercount[team] = level.requiredplayercount[team] + _id_4B62AA3A1860D0AC;
}

player_on_spot(player, _id_E4B9CD561C7C0DE6) {
  if(!isDefined(game["infil"][player.team][0])) {}

  if(!isDefined(game["infil"][player.team][0][_id_E4B9CD561C7C0DE6])) {}

  if(isDefined(game["infil"][player.team][0][_id_E4B9CD561C7C0DE6][4])) {}

  game["infil"][player.team][0][_id_E4B9CD561C7C0DE6][4] = player;
  return game["infil"][player.team][0][_id_E4B9CD561C7C0DE6];
}

player_free_spot(player, team) {
  player setclientomnvar("ui_player_in_infil", 0);

  if(!isDefined(team))
    team = player.team;

  if(!isDefined(game["infil"][team][0])) {}

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(is_spot_taken(team, key) && _id_0C3EA9B1A20FF199[4] == player) {
      game["infil"][team][0][key][4] = undefined;
      player notify("player_free_spot");
      return;
    }
  }
}

get_player_at_spot(team, _id_E4B9CD561C7C0DE6) {
  return game["infil"][team][0][_id_E4B9CD561C7C0DE6][4];
}

get_spot_from_player(player, team) {
  if(!isDefined(team))
    team = player.team;

  if(!isDefined(game["infil"][team][0]))
    return undefined;

  foreach(_id_AC0E594AC96AA3A8, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(isDefined(_id_0C3EA9B1A20FF199[4]) && _id_0C3EA9B1A20FF199[4] == player)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

is_spot_taken(team, _id_E4B9CD561C7C0DE6) {
  if(!isDefined(game["infil"][team][0])) {}

  if(!isDefined(game["infil"][team][0][_id_E4B9CD561C7C0DE6])) {}

  return isDefined(game["infil"][team][0][_id_E4B9CD561C7C0DE6][4]);
}

get_spot_taken_count(team) {
  if(!isDefined(game["infil"][team][0])) {}

  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(is_spot_taken(team, key))
      count++;
  }

  return count;
}

get_spot_by_priority(team) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(!is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_2849F873DF400420 = getdvarint("dvar_E6526B9EF05103AD", -1);

  if(scripts\engine\utility::array_contains(_id_F9B2403B4571D886, _id_2849F873DF400420))
    return _id_2849F873DF400420;

  _id_FDC11BA76911059E = [];
  _id_5C49327452EF41BB = -1;

  foreach(_id_0C3EA9B1A20FF199 in _id_F9B2403B4571D886) {
    priority = game["infil"][team][0][_id_0C3EA9B1A20FF199][3];

    if(_id_FDC11BA76911059E.size == 0 || priority < _id_5C49327452EF41BB) {
      _id_FDC11BA76911059E = [];
      _id_FDC11BA76911059E[_id_FDC11BA76911059E.size] = _id_0C3EA9B1A20FF199;
      _id_5C49327452EF41BB = priority;
      continue;
    }

    if(priority == _id_5C49327452EF41BB)
      _id_FDC11BA76911059E[_id_FDC11BA76911059E.size] = _id_0C3EA9B1A20FF199;
  }

  return _id_FDC11BA76911059E[randomint(_id_FDC11BA76911059E.size)];
}

get_spot_in_lane(team) {
  while(!isDefined(self.forcedavailablespawnlocation))
    waitframe();

  _id_DEC9BCCE93873125 = scripts\engine\utility::ter_op(team == "allies", "a", "b") + getsubstr(self.forcedavailablespawnlocation, 5, 6);
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(issubstr(_id_0C3EA9B1A20FF199[1].lane, _id_DEC9BCCE93873125) && !is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_FDC11BA76911059E = [];
  _id_5C49327452EF41BB = -1;

  foreach(_id_0C3EA9B1A20FF199 in _id_F9B2403B4571D886) {
    priority = game["infil"][team][0][_id_0C3EA9B1A20FF199][3];

    if(_id_FDC11BA76911059E.size == 0 || priority < _id_5C49327452EF41BB) {
      _id_FDC11BA76911059E = [];
      _id_FDC11BA76911059E[_id_FDC11BA76911059E.size] = _id_0C3EA9B1A20FF199;
      _id_5C49327452EF41BB = priority;
      continue;
    }

    if(priority == _id_5C49327452EF41BB)
      _id_FDC11BA76911059E[_id_FDC11BA76911059E.size] = _id_0C3EA9B1A20FF199;
  }

  return _id_FDC11BA76911059E[randomint(_id_FDC11BA76911059E.size)];
}

get_random_spot(team) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(!is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_F9B2403B4571D886);
  return _id_0C3EA9B1A20FF199;
}

get_taken_spot_count(team) {
  if(!isDefined(game["infil"][team][0]))
    return 0;

  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(is_spot_taken(team, key))
      count++;
  }

  return count;
}

get_taken_spot_percent(team) {
  if(!isDefined(game["infil"][team][0]))
    return 0;

  total = 0;
  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    total++;

    if(is_spot_taken(team, key))
      count++;
  }

  return count / total;
}

get_random_spot_in_infil(team, infil) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team][0]) {
    if(key["infil"] != infil) {
      continue;
    }
    if(!is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_F9B2403B4571D886);
  return _id_0C3EA9B1A20FF199;
}

infil_player_array_handler(player) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, player);
  player waittill("death_or_disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, player);
}

player_join_infil() {
  if(scripts\mp\flags::gameflag("infil_started")) {
    return;
  }
  if(game["infil"][self.team].size == 0) {
    return;
  }
  if(self ishost() && getdvarint("dvar_F711F210F6FFD355") == 1) {
    player_ai_fill();
    return;
  }

  _id_AD497B2F2391DFE1 = 0;
  _id_047691436552AC69 = game["infil"][self.team][0][0][3] != -1;

  if(_id_AD497B2F2391DFE1)
    _id_E4B9CD561C7C0DE6 = get_spot_taken_count(self.team);
  else if(_id_047691436552AC69)
    _id_E4B9CD561C7C0DE6 = get_spot_by_priority(self.team);
  else
    _id_E4B9CD561C7C0DE6 = get_random_spot(self.team);

  if(!isDefined(_id_E4B9CD561C7C0DE6)) {
    return;
  }
  _id_0C3EA9B1A20FF199 = player_on_spot(self, _id_E4B9CD561C7C0DE6);
  _id_0C3EA9B1A20FF199[1] thread infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self.infil = _id_0C3EA9B1A20FF199[1];
  self thread[[_id_0C3EA9B1A20FF199[2]]](_id_0C3EA9B1A20FF199[1], _id_0C3EA9B1A20FF199[0]);
  self setclientomnvar("ui_player_in_infil", 1);
  thread onplayerchangeteams();
  thread clearinfilstateatinfilend();
  player_ai_fill();
}

clearinfilstateatinfilend() {
  self endon("death_or_disconnect");
  level waittill("prematch_done");
  self setcinematicmotionoverride("iw9_playermotion");
  result = 0;

  while(!result) {
    result = self setdemeanorviewmodel("normal");
    waitframe();
  }
}

blockswaploadouts() {
  self endon("disconnect");
  self.delayswaploadout = 1;
  level waittill("prematch_over");
  self.delayswaploadout = 0;
}

player_ai_fill() {}

infil_setup_ui() {
  setomnvar("ui_in_infil", 3);
  level waittill("infil_started");
  _id_BB5B77F0E312FDC6 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);

  if(!isDefined(level.bypassclasschoicefunc)) {
    setomnvarforallclients("ui_skip_loadout", 0);
    level.bypassclasschoicefunc = undefined;
  }

  level thread infil_show_countdown();
  _id_43F804996BA3F50E = getdvarint("cg_drawCrosshair");
  _id_BE6DC7D2B85389BA = getdvarint("cg_drawCrosshairNames");
  _id_C3F949F19AD560E2 = getdvarint("cg_drawFriendlyNamesAlways");
  setDvar("cg_drawCrosshair", 0);
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 1);
  level waittill("prematch_done");
  _id_AE38D1B160669269 = scripts\mp\utility\player::alwaysshowminimap();

  foreach(player in level.players) {
    if(_id_AE38D1B160669269) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  setomnvar("ui_in_infil", -1);
  setomnvar("ui_always_show_nameplates", _id_BB5B77F0E312FDC6);
  setDvar("cg_drawCrosshair", _id_43F804996BA3F50E);
  setDvar("cg_drawCrosshairNames", _id_BE6DC7D2B85389BA);
  setDvar("cg_drawFriendlyNamesAlways", _id_C3F949F19AD560E2);
}

infil_show_countdown() {
  waittime = level.prematchperiodend - level._id_333FBCCF73785411 - 5;
  wait(waittime);
  setomnvar("ui_in_infil", 2);
}

alwaysgamemodeclass() {
  clantag = self getclantag();

  if(clantag == "AR")
    class = "default1";
  else if(clantag == "SMG")
    class = "default2";
  else if(clantag == "LMG")
    class = "default3";
  else {
    _id_5570CB3187DBA152 = [];
    _id_5570CB3187DBA152[0] = "default1";
    _id_5570CB3187DBA152[1] = "default2";
    _id_5570CB3187DBA152[2] = "default3";
    class = scripts\engine\utility::random(_id_5570CB3187DBA152);
  }

  self.pers["class"] = class;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return class;
}

#using_animtree("script_model");

infil_player_rig(animname, _id_486DB5FA512A3B6B, _id_40A4287D8D2E7EF9) {
  self.animname = animname;
  player_rig = spawn("script_model", (0, 0, 0));
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig setModel(_id_486DB5FA512A3B6B);
  self.player_rig hide();
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(_id_40A4287D8D2E7EF9) && _id_40A4287D8D2E7EF9)
    self playersetgroundreferenceent(self.player_rig);

  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(isDefined(self)) {
    if(isDefined(_id_40A4287D8D2E7EF9) && _id_40A4287D8D2E7EF9)
      self playersetgroundreferenceent(undefined);

    self unlink();
  }

  if(isDefined(player_rig))
    player_rig delete();
}

infil_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.players)
  player playsoundtoplayer(alias, player);
}

infil_wait_for_players() {
  level endon("game_ended");
  level endon("force_end");
  level waittill("match_start_real_countdown");
  setomnvar("ui_in_infil", 1);
  level._id_2A15D29E8890B785 = 1;
  wait(level._id_CAC1C5779002911A);
  scripts\mp\flags::gameflagset("infil_started");

  if(getdvarint("dvar_837A5E61131F5464", 0) == 1)
    level thread manageinteractiveslowmo();

  if(getdvarint("dvar_F84371D2F3A2A3AC", 0) == 1) {
    foreach(player in level.players)
    iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
  }
}

heli_path(vehicle) {
  if(!isDefined(vehicle))
    vehicle = self;

  vehicle endon("death");

  if(isDefined(vehicle.hasstarted))
    return;
  else
    vehicle.hasstarted = 1;

  vehicle scripts\engine\utility::script_delay();
  vehicle notify("start_vehiclepath");
  vehicle notify("start_dynamicpath");
}

vehicle_paths_helicopter(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(_id_269FB0EC10B51524))
    _id_269FB0EC10B51524 = 0;

  if(isDefined(node))
    self.attachedpath = node;

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }
  _id_4989043D54BCFB7C = pathstart;

  if(_id_269FB0EC10B51524)
    self waittill("start_dynamicpath");

  if(isDefined(_id_CFA3AAFB71B08D36)) {
    _id_4EA3A41043B7ADBC = spawnStruct();
    _id_4EA3A41043B7ADBC.origin = (self.origin[0], self.origin[1], self.origin[2] + _id_CFA3AAFB71B08D36);
    heli_wait_node(_id_4EA3A41043B7ADBC, undefined);
  }

  _id_B7AB7579B3C791B1 = undefined;
  nextpoint = pathstart;
  _id_6A4AD94DB7F006E2 = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(isDefined(nextpoint.script_parameters))
      readnodeevents(nextpoint);

    if(isDefined(nextpoint.script_linkto))
      set_lookat_from_dest(nextpoint);

    heli_wait_node(nextpoint, _id_B7AB7579B3C791B1, _id_CFA3AAFB71B08D36);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = nextpoint;
    nextpoint notify("trigger", self);

    if(isDefined(nextpoint.script_helimove)) {
      self setyawspeedbyname(nextpoint.script_helimove);

      if(nextpoint.script_helimove == "faster")
        self setmaxpitchroll(25, 50);
    }

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_team))
      self.script_team = nextpoint.script_team;

    if(isDefined(nextpoint.script_unload)) {
      self notify("unload");
      scripts\engine\utility::waittill_notify_or_timeout("unloaded", self.unload_time);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(nextpoint.script_pathtype))
        self.veh_pathtype = nextpoint.script_pathtype;
    }

    if(isDefined(nextpoint.script_flag_wait)) {
      scripts\engine\utility::flag_wait(nextpoint.script_flag_wait);

      if(isDefined(nextpoint.script_delay_post))
        wait(nextpoint.script_delay_post);

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    _id_B7AB7579B3C791B1 = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[_id_6A4AD94DB7F006E2]](nextpoint.target);

    if(!isDefined(nextpoint)) {
      nextpoint = _id_B7AB7579B3C791B1;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove))
    self delete();
}

heli_wait_node(nextpoint, _id_B7AB7579B3C791B1, _id_CFA3AAFB71B08D36) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    _id_8DBF20B18391BDA1 = 0;

    if(isDefined(nextpoint.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset))
        _id_8DBF20B18391BDA1 = self.unload_land_offset;
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset))
      _id_8DBF20B18391BDA1 = self.unload_hover_offset;
    else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset_max)) {
      _id_01230EA36A300368 = scripts\common\utility::groundpos(nextpoint.origin);
      _id_8DBF20B18391BDA1 = nextpoint.origin[2] - _id_01230EA36A300368[2];

      if(_id_8DBF20B18391BDA1 >= self.unload_hover_offset_max)
        _id_8DBF20B18391BDA1 = self.unload_hover_offset_max;
      else if(isDefined(self.unload_hover_land_height) && _id_8DBF20B18391BDA1 < self.unload_hover_land_height)
        _id_8DBF20B18391BDA1 = self.unload_hover_land_height;
    }

    nextpoint.radius = 2;

    if(isDefined(nextpoint.ground_pos))
      nextpoint.origin = nextpoint.ground_pos + (0, 0, _id_8DBF20B18391BDA1);
    else {
      _id_B48C995A0A557FF1 = scripts\common\utility::groundpos(nextpoint.origin) + (0, 0, _id_8DBF20B18391BDA1);

      if(_id_B48C995A0A557FF1[2] > nextpoint.origin[2] - 2000)
        nextpoint.origin = scripts\common\utility::groundpos(nextpoint.origin) + (0, 0, _id_8DBF20B18391BDA1);
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(_id_B7AB7579B3C791B1)) {
    _id_B1DA74CE505DD34A = _id_B7AB7579B3C791B1.script_airresistance;
    speed = _id_B7AB7579B3C791B1.speed;
    accel = _id_B7AB7579B3C791B1.script_accel;
    decel = _id_B7AB7579B3C791B1.script_decel;
  } else {
    _id_B1DA74CE505DD34A = undefined;
    speed = undefined;
    accel = undefined;
    decel = undefined;
  }

  _id_3E6E337291CA2A19 = isDefined(nextpoint.script_stopnode) && nextpoint.script_stopnode;
  _id_58EAF93DC5DB5926 = isDefined(nextpoint.script_unload);
  flag_wait = isDefined(nextpoint.script_flag_wait) && !scripts\engine\utility::flag(nextpoint.script_flag_wait);
  _id_CCF44CFF39A902F0 = !isDefined(nextpoint.target);
  _id_038D31613EE1A416 = isDefined(nextpoint.script_delay);

  if(isDefined(nextpoint.angles))
    yaw = nextpoint.angles[1];
  else
    yaw = 0;

  if(self.health <= 0) {
    return;
  }
  origin = nextpoint.origin;

  if(isDefined(_id_CFA3AAFB71B08D36))
    origin = (origin[0], origin[1], origin[2] + _id_CFA3AAFB71B08D36);

  if(isDefined(self.heliheightoverride))
    origin = (origin[0], origin[1], self.heliheightoverride);

  self vehicle_helisetai(origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, _id_B1DA74CE505DD34A, _id_038D31613EE1A416, _id_3E6E337291CA2A19, _id_58EAF93DC5DB5926, flag_wait, _id_CCF44CFF39A902F0);

  if(isDefined(nextpoint.radius)) {
    self setneargoalnotifydist(nextpoint.radius);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  } else
    self waittill("goal");

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(nextpoint);

  self notify("continuepath");
}

get_path_getfunc(_id_4989043D54BCFB7C) {
  _id_6A4AD94DB7F006E2 = ::get_from_vehicle_node;

  if(isDefined(_id_4989043D54BCFB7C.target)) {
    if(isDefined(get_from_entity(_id_4989043D54BCFB7C.target)))
      _id_6A4AD94DB7F006E2 = ::get_from_entity;

    if(isDefined(get_from_spawnStruct(_id_4989043D54BCFB7C.target)))
      _id_6A4AD94DB7F006E2 = ::get_from_spawnstruct;
  }

  return _id_6A4AD94DB7F006E2;
}

get_from_vehicle_node(target) {
  return getvehiclenode(target, "targetname");
}

get_from_spawnStruct(target) {
  array = scripts\engine\utility::getStructArray(target, "targetname");

  if(array.size == 1)
    return array[0];
  else {
    foreach(_id_F7806D4CF24AACD3 in array) {
      if(isDefined(_id_F7806D4CF24AACD3._id_B205D90302DA2F07) && isDefined(self._id_B205D90302DA2F07) && _id_F7806D4CF24AACD3._id_B205D90302DA2F07 == self._id_B205D90302DA2F07)
        return _id_F7806D4CF24AACD3;
    }
  }
}

get_from_entity(target) {
  ent = getEntArray(target, "targetname");

  if(isDefined(ent) && ent.size > 0)
    return ent[randomint(ent.size)];

  return undefined;
}

set_lookat_from_dest(_id_815D30728A6EF9D9) {
  _id_9AE5B7230AF98AF5 = getEnt(_id_815D30728A6EF9D9.script_linkto, "script_linkname");

  if(!isDefined(_id_9AE5B7230AF98AF5)) {
    return;
  }
  self setlookatent(_id_9AE5B7230AF98AF5);
  self.set_lookat_point = 1;
}

parsehelipathlength() {
  if(!isDefined(self.path))
    return 0.0;

  if(isDefined(self.pathduration))
    return self.pathduration;

  self.pathduration = 0.0;
  node = self.path;
  speed = node.speed;

  for(;;) {
    if(isDefined(node.script_unload)) {
      break;
    }

    if(!isDefined(node.target)) {
      break;
    }

    next = scripts\engine\utility::getStruct(node.target, "targetname");

    if(!isDefined(next)) {
      break;
    }

    _id_9EB9E52B1DCD019D = distance(node.origin, next.origin);

    if(isDefined(node.speed))
      speed = node.speed;

    _id_965BC0EEC4F74BB1 = 17.6;
    _id_5DF47F4F5B20F4CE = 1.1;
    self.pathduration = self.pathduration + _id_9EB9E52B1DCD019D * _id_5DF47F4F5B20F4CE / (speed * _id_965BC0EEC4F74BB1);
    node = next;
  }

  return self.pathduration;
}

readnodeevents(node) {
  events = strtok(node.script_parameters, ",");

  foreach(event in events) {
    _id_CBF22C9EDB76E72D = strtok(event, ":");

    if(!isDefined(_id_CBF22C9EDB76E72D)) {
      return;
    }
    if(_id_CBF22C9EDB76E72D.size != 2) {
      return;
    }
    thread processtimelineevent(_id_CBF22C9EDB76E72D[0], float(_id_CBF22C9EDB76E72D[1]));
  }
}

processtimelineevent(event, delay) {
  if(!isDefined(self.timelineevents))
    self.timelineevents = [];

  if(delay > 0)
    wait(delay);

  switch (event) {
    case "shake_low":
      self.timelineevents["shake"] = "low";

      foreach(player in self.infil.players)
      scripts\mp\utility\infilexfil::cam_shake_low(player);

      break;
    case "shake_off":
      self.timelineevents["shake"] = "off";

      foreach(player in self.infil.players)
      scripts\mp\utility\infilexfil::cam_shake_off(player);

      break;
    case "event_intro":
      self.infil notify("event_intro");
      break;
    case "event_shootingWindow_open":
      self.infil notify("event_shootingWindow_open");
      break;
    case "event_shootingWindow_closed":
      self.infil notify("event_shootingWindow_closed");
      break;
  }
}

manageinteractiveslowmo() {
  if(!isDefined(level.interactiveinfilstart) || !isDefined(level.interactiveinfilwindow)) {
    return;
  }
  wait(level.interactiveinfilstart);
  setslowmotion(1, 0.5, 1);
  wait(level.interactiveinfilwindow);
  setslowmotion(0.5, 1, 0.5);
}

waitandunloadinfils() {
  scripts\mp\flags::gameflagwait("prematch_done");

  while(level.infilsactive != 0)
    waitframe();

  unloadallinfilintrotransients();
  level notify("unload_audio_soundbank");
}

_id_3C075BF6EADE7262() {
  level waittill("unload_audio_soundbank");
}

_id_D41CBA513A03D958(waittime) {
  self endon("death_or_disconnect");
  wait(waittime);
  scripts\mp\class::blockclasschange();
}

_id_4DCA5340DFD36C76(scene_node, vehicle, waittime, animname, _id_643BCFEC059B4AE2) {
  if(!isDefined(scene_node) || !isDefined(scene_node.target)) {
    return;
  }
  _id_19B99157406B12A1 = getEntArray(scene_node.target, "targetname");
  _id_54B174A893636475 = scene_node.origin;
  _id_9CA1B8FD292FEFFA = scene_node.angles;

  if(!isDefined(_id_19B99157406B12A1[0])) {
    return;
  }
  _id_19B99157406B12A1[0].canmove = 1;
  _id_19B99157406B12A1[0] setscriptablepartstate("visibility", "hide", 1);
  wait(waittime);
  vehicle delete();
  _id_19B99157406B12A1[0] setscriptablepartstate("visibility", "show");
}