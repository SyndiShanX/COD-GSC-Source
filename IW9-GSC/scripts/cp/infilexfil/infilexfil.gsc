/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\infilexfil.gsc
************************************************/

infil_add(type, subtype, _id_F30FD2E505C341C8, _id_AA0773494F0D374D, _id_8EE2EF1B890C0C7B, spawn_func, _id_1FC48C4B6E73E047, _id_C2EB4C229CFC9D83) {
  if(getdvarint("dvar_C55DC89EF275CDAA", 0) == 1) {
    if(scripts\engine\utility::flag_exist("infil_complete"))
      scripts\engine\utility::flag_set("infil_complete");

    return;
  }

  level.prematchperiod = 10;

  while(!isDefined(level.teamnamelist))
    waitframe();

  level.requiredplayercount["allies"] = 0;
  level.requiredplayercount["axis"] = 0;

  if(!isDefined(game["infil"])) {
    foreach(team in level.teamnamelist)
    game["infil"][team] = [];
  }

  if(!isDefined(game["infil"]["types"]))
    game["infil"]["types"] = [];

  if(isDefined(game["infil"]["types"][type]) && isDefined(game["infil"]["types"][type][subtype])) {
    if(isDefined(game["infil"]["types"][type][subtype]["persistentVehicle"]))
      self[[game["infil"]["types"][type][subtype]["persistentVehicle"]]](type, subtype);

    if(scripts\engine\utility::flag_exist("infil_complete"))
      scripts\engine\utility::flag_set("infil_complete");

    return;
  }

  game["infil"]["types"][type][subtype] = [];
  game["infil"]["types"][type][subtype]["spawn_func"] = spawn_func;
  game["infil"]["types"][type][subtype]["player_func"] = _id_C2EB4C229CFC9D83;
  game["infil"]["types"][type][subtype]["get_length_func"] = _id_1FC48C4B6E73E047;
  game["infil"]["types"][type][subtype]["seats"] = _id_F30FD2E505C341C8;
  game["infil"]["types"][type][subtype]["required_seats"] = _id_AA0773494F0D374D;
  game["infil"]["types"][type][subtype]["fill_order"] = _id_8EE2EF1B890C0C7B;
  level thread infil_init(type, subtype);
}

infil_init(type, subtype) {
  waittillframeend;

  if(!isDefined(level.prematchperiod) || level.prematchperiod == 0) {
    return;
  }
  scripts\cp\utility::gameflaginit("infil_started", 0);

  if(!scripts\engine\utility::flag_exist("infil_over"))
    scripts\engine\utility::flag_init("infil_over");

  if(!isDefined(level.infilinitonce)) {
    level.infilinitonce = 1;
    level thread onplayerspawned();
    level thread onjoinedteam();
  }

  if(!isDefined(level.prematchallowfunc))
    level.prematchallowfunc = ::infil_player_allow_cp;

  _id_D47AC5A6CBDC6DCF = undefined;
  _id_3EDA0EF65C9478AC = 0;

  foreach(_id_D78FFD67F2183062 in get_all_infils()) {
    if(!_id_D78FFD67F2183062 infil_is_gamemode()) {
      continue;
    }
    team = _id_D78FFD67F2183062.script_team;

    if(_id_D78FFD67F2183062 scripts\cp\cp_infilexfil::infil_is_type(type) && _id_D78FFD67F2183062 scripts\cp\cp_infilexfil::infil_is_subtype(subtype) && isinfilgameplayteam(_id_D78FFD67F2183062.script_team)) {
      _id_643BCFEC059B4AE2 = game["infil"]["types"][type][subtype];
      _id_74DB343D270DE78F = _id_D78FFD67F2183062[[_id_643BCFEC059B4AE2["spawn_func"]]](_id_D78FFD67F2183062.script_team, _id_D78FFD67F2183062.target, _id_D78FFD67F2183062.name);
      _id_74DB343D270DE78F.players = [];
      _id_74DB343D270DE78F.type = _id_D78FFD67F2183062.script_noteworthy;
      _id_74DB343D270DE78F.subtype = _id_D78FFD67F2183062.name;
      team = _id_D78FFD67F2183062.script_team;
      game["infil"][team]["lanes"][type][subtype] = _id_74DB343D270DE78F;
      register_infil_spots(team, _id_74DB343D270DE78F, _id_643BCFEC059B4AE2["seats"], _id_643BCFEC059B4AE2["required_seats"], _id_643BCFEC059B4AE2["fill_order"], _id_643BCFEC059B4AE2["player_func"]);
      _id_4AA73BECADE28233 = _id_74DB343D270DE78F[[_id_643BCFEC059B4AE2["get_length_func"]]](subtype);

      if(!isDefined(_id_D47AC5A6CBDC6DCF)) {
        if(isDefined(_id_4AA73BECADE28233))
          _id_4AA73BECADE28233 = _id_4AA73BECADE28233 + 1.0;
        else
          _id_4AA73BECADE28233 = 1.0;

        _id_D47AC5A6CBDC6DCF = _id_4AA73BECADE28233;
      } else
        _id_4AA73BECADE28233 = _id_4AA73BECADE28233 + 1.0;
    }
  }

  if(gamehasinfil() && isDefined(_id_D47AC5A6CBDC6DCF)) {
    level.prematchperiod = 10;
    level.prematchperiodend = _id_D47AC5A6CBDC6DCF + 1.0;
    level thread infil_setup_ui();
    level thread infil_wait_for_all_players();
  }
}

onplayerspawned() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("trying_to_join_infil", player);

    if(playerinfildisabled(player)) {
      continue;
    }
    _id_6FC7BE33ECE5533A = scripts\cp\utility::getotherteam(player.team);

    if(isarray(_id_6FC7BE33ECE5533A))
      playerteam = _id_6FC7BE33ECE5533A[0];
    else
      playerteam = _id_6FC7BE33ECE5533A;

    _id_BE4FBABEAFB491A7 = get_spot_from_player(player, playerteam);

    if(isDefined(_id_BE4FBABEAFB491A7))
      player_free_spot(player, scripts\cp\utility::getotherteam(playerteam));

    if(!scripts\engine\utility::flag("infil_over"))
      player player_join_infil_cp();
  }
}

playerinfildisabled(player) {
  return istrue(player.infil_disabled);
}

disableplayerinfil(player) {
  player.infil_disabled = 1;
}

onjoinedteam() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("joined_team", player);

    if(isDefined(player.team) && player.team == "spectator")
      player thread infilspectatorview();
  }
}

infilspectatorview() {
  self endon("joined_team");
  self endon("disconnect");
  self notify("infilSpectatorView");
  self endon("infilSpectatorView");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0.0, 0.55, "fade_up");
  level waittill("start_scene");
  self notify("fade_up");
}

onplayerdisconnectinfil() {
  self endon("prematch_over");
  team = self.team;
  self waittill("disconnect");
  player_free_spot(self, team);
}

get_all_infils(_id_643BCFEC059B4AE2) {
  if(isDefined(_id_643BCFEC059B4AE2))
    return scripts\engine\utility::getStructArray("infil_type", "script_noteworthy");
  else
    return scripts\engine\utility::getStructArray("cp_infil", "targetname");
}

infil_is_gamemode() {
  self.spawnflags = int(self.spawnflags);

  if(!isDefined(self.spawnflags) || self.spawnflags == 0)
    return 0;

  if(!level.teambased)
    return 0;

  if(self.spawnflags & 1)
    return 1;

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "tjugg":
      case "grind":
      case "conf":
      case "war":
      case "pill":
      case "arm":
        return 1;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "sr":
      case "sd":
      case "dd":
        return 1;
    }
  }

  if(self.spawnflags & 8) {
    switch (level.gametype) {
      case "dom":
      case "siege":
        return 1;
    }
  }

  if(self.spawnflags & 16) {
    switch (level.gametype) {
      case "grnd":
      case "koth":
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
        return 1;
    }
  }

  return 0;
}

infil_has_map_config() {}

infil_init_spawn_selection() {}

infil_player_allow_cp(_id_CD187E38E3DF8F36, _id_B546524B3FD3D9C9) {
  if(self ishost() && getdvarint("dvar_F711F210F6FFD355") == 1) {
    if(!_id_CD187E38E3DF8F36)
      _id_3B64EB40368C1450::set("infil_player", "weapon", 0);
    else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
  } else {
    if(!_id_CD187E38E3DF8F36) {
      _id_3B64EB40368C1450::set("infil_player", "allow_movement", 0);
      _id_3B64EB40368C1450::set("infil_player", "prone", 0);
      _id_3B64EB40368C1450::set("infil_player", "crouch", 0);
      _id_3B64EB40368C1450::set("infil_player", "allow_jump", 0);
      _id_3B64EB40368C1450::set("infil_player", "fire", 0);
      _id_3B64EB40368C1450::set("infil_player", "ads", 0);
      _id_3B64EB40368C1450::set("infil_player", "sprint", 0);
      _id_3B64EB40368C1450::set("infil_player", "melee", 0);
      _id_3B64EB40368C1450::set("infil_player", "reload", 0);
      _id_3B64EB40368C1450::set("infil_player", "lean", 0);
      _id_3B64EB40368C1450::set("infil_player", "slide", 0);
      _id_3B64EB40368C1450::set("infil_player", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("infil_player", "weapon_switch", 0);
      _id_3B64EB40368C1450::set("infil_player", "usability", 0);
      _id_3B64EB40368C1450::set("infil_player", "script_weapon_switch", 0);
      return;
    }

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
  }
}

_id_3B61547ADAFF3B7E(_id_CD187E38E3DF8F36, _id_B546524B3FD3D9C9) {
  if(self ishost() && getdvarint("dvar_F711F210F6FFD355") == 1) {
    if(!_id_CD187E38E3DF8F36)
      _id_3B64EB40368C1450::set("infil_player", "weapon", 0);
    else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
  } else {
    if(!_id_CD187E38E3DF8F36) {
      _id_3B64EB40368C1450::set("infil_player", "allow_movement", 0);
      _id_3B64EB40368C1450::set("infil_player", "prone", 0);
      _id_3B64EB40368C1450::set("infil_player", "crouch", 0);
      _id_3B64EB40368C1450::set("infil_player", "allow_jump", 0);
      _id_3B64EB40368C1450::set("infil_player", "sprint", 0);
      _id_3B64EB40368C1450::set("infil_player", "melee", 0);
      _id_3B64EB40368C1450::set("infil_player", "lean", 0);
      _id_3B64EB40368C1450::set("infil_player", "slide", 0);
      _id_3B64EB40368C1450::set("infil_player", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("infil_player", "weapon_switch", 0);
      _id_3B64EB40368C1450::set("infil_player", "usability", 0);
      _id_3B64EB40368C1450::set("infil_player", "script_weapon_switch", 0);
      return;
    }

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
  }
}

register_infil_spots(team, infil, amount, _id_4B62AA3A1860D0AC, _id_30EC18A4C33AF064, _id_F3F5EF500ADAC836) {
  if(!isDefined(game["infil"][team]["spots"]))
    game["infil"][team]["spots"] = [];

  _id_2F55781AF96F22F9 = game["infil"][team]["spots"].size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    index = game["infil"][team]["spots"].size;

    if(isDefined(_id_30EC18A4C33AF064)) {
      _id_B8EB6872CE4193F8 = 0;

      foreach(priority, _id_4DF083E7CE48A6E5 in _id_30EC18A4C33AF064) {
        foreach(seat in _id_4DF083E7CE48A6E5) {
          if(seat == index - _id_2F55781AF96F22F9) {
            game["infil"][team]["spots"][index]["priority"] = priority;
            _id_B8EB6872CE4193F8 = 1;
            break;
          }
        }

        if(_id_B8EB6872CE4193F8) {
          break;
        }
      }
    } else
      game["infil"][team]["spots"][index]["priority"] = -1;

    game["infil"][team]["spots"][index]["seat"] = _id_AC0E594AC96AA3A8;
    game["infil"][team]["spots"][index]["infil"] = infil;
    game["infil"][team]["spots"][index]["callback"] = _id_F3F5EF500ADAC836;
  }

  if(_id_4B62AA3A1860D0AC > level.requiredplayercount[team])
    level.requiredplayercount[team] = _id_4B62AA3A1860D0AC;
}

player_on_spot(player, _id_E4B9CD561C7C0DE6) {
  if(!isDefined(game["infil"][player.team]["spots"])) {}

  if(!isDefined(game["infil"][player.team]["spots"][_id_E4B9CD561C7C0DE6])) {}

  if(isDefined(game["infil"][player.team]["spots"][_id_E4B9CD561C7C0DE6]["player"])) {}

  game["infil"][player.team]["spots"][_id_E4B9CD561C7C0DE6]["player"] = player;
  return game["infil"][player.team]["spots"][_id_E4B9CD561C7C0DE6];
}

player_free_spot(player, team) {
  if(!isDefined(team))
    team = player.team;

  if(!isDefined(game["infil"][team]["spots"])) {}

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key) && _id_0C3EA9B1A20FF199["player"] == player) {
      game["infil"][team]["spots"][key]["player"] = undefined;
      player notify("player_free_spot");
      return;
    }
  }
}

get_player_at_spot(team, _id_E4B9CD561C7C0DE6) {
  return game["infil"][team]["spots"][_id_E4B9CD561C7C0DE6]["player"];
}

get_spot_from_player(player, team) {
  if(!isDefined(team)) {
    if(isDefined(player.team))
      team = player.team;
    else
      team = "allies";
  }

  if(!isDefined(game["infil"][team]["spots"]))
    return undefined;

  foreach(_id_AC0E594AC96AA3A8, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(isDefined(_id_0C3EA9B1A20FF199["player"]) && _id_0C3EA9B1A20FF199["player"] == player)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

is_spot_taken(team, _id_E4B9CD561C7C0DE6) {
  if(!isDefined(game["infil"][team]["spots"])) {}

  if(!isDefined(game["infil"][team]["spots"][_id_E4B9CD561C7C0DE6])) {}

  return isDefined(game["infil"][team]["spots"][_id_E4B9CD561C7C0DE6]["player"]);
}

get_spot_taken_count(team) {
  if(!isDefined(game["infil"][team]["spots"])) {}

  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key))
      count++;
  }

  return count;
}

get_spot_by_priority(team) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
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
    priority = game["infil"][team]["spots"][_id_0C3EA9B1A20FF199]["priority"];

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

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(!is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_F9B2403B4571D886);
  return _id_0C3EA9B1A20FF199;
}

get_taken_spot_count(team) {
  if(!isDefined(game["infil"][team]["spots"]))
    return 0;

  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key))
      count++;
  }

  return count;
}

get_taken_spot_percent(team) {
  if(!isDefined(game["infil"][team]["spots"]))
    return 0;

  total = 0;
  count = 0;

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    total++;

    if(is_spot_taken(team, key))
      count++;
  }

  return count / total;
}

player_join_infil_cp() {
  if(game["infil"][self.team].size == 0) {
    return;
  }
  if(isPlayer(self) && self ishost() && getdvarint("dvar_F711F210F6FFD355") == 1) {
    player_ai_fill();
    return;
  }

  _id_AD497B2F2391DFE1 = 0;
  _id_047691436552AC69 = game["infil"][self.team]["spots"][0]["priority"] != -1;

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
  _id_0C3EA9B1A20FF199["infil"] thread scripts\cp\cp_infilexfil::infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self thread[[_id_0C3EA9B1A20FF199["callback"]]](_id_0C3EA9B1A20FF199["infil"], _id_0C3EA9B1A20FF199["seat"]);
  thread blockswaploadouts();
  thread onplayerdisconnectinfil();
  player_ai_fill();
}

blockswaploadouts() {
  self endon("disconnect");
  self.delayswaploadout = 1;
  level waittill("prematch_over");
  self.delayswaploadout = 0;
}

player_ai_fill() {}

infil_setup_ui() {
  foreach(player in level.players)
  player setclientomnvar("ui_hide_hud", 1);

  level.bypassclasschoicefunc = scripts\cp\cp_infilexfil::alwaysgamemodeclass;
  level.infil_in_progress_buffer = 1;
  level waittill("infil_started");

  foreach(player in level.players)
  player setclientomnvar("ui_hide_hud", 1);

  _id_BB5B77F0E312FDC6 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);
  level.bypassclasschoicefunc = undefined;
  level.infil_in_progress = 1;
  _id_43F804996BA3F50E = getdvarint("cg_drawCrosshair");
  _id_BE6DC7D2B85389BA = getdvarint("cg_drawCrosshairNames");
  _id_C3F949F19AD560E2 = getdvarint("cg_drawFriendlyNamesAlways");
  setDvar("cg_drawCrosshair", 0);
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 1);
  level waittill("prematch_over");

  foreach(player in level.players) {
    player setclientomnvar("ui_hide_hud", 0);
    player setclientomnvar("ui_hide_minimap", 1);
  }

  setomnvar("ui_always_show_nameplates", _id_BB5B77F0E312FDC6);
  setDvar("cg_drawCrosshair", _id_43F804996BA3F50E);
  setDvar("cg_drawCrosshairNames", _id_BE6DC7D2B85389BA);
  setDvar("cg_drawFriendlyNamesAlways", _id_C3F949F19AD560E2);
  level.infil_in_progress = undefined;
  wait 2;
  level.infil_in_progress_buffer = undefined;

  if(scripts\engine\utility::flag_exist("infil_complete"))
    scripts\engine\utility::flag_set("infil_complete");
}

infil_show_countdown() {
  wait(level.prematchperiodend - 5);
  setomnvar("ui_in_infil", 2);
}

infil_wait_for_all_players() {
  level waittill("trying_to_join_infil", player);
  level.num_of_player_ready_to_infil = 1;
  wait_for_all_players_or_timeout();
  scripts\cp\utility::gameflagset("infil_started");

  if(getdvarint("dvar_F84371D2F3A2A3AC", 0) == 1) {
    foreach(player in level.players)
    iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
  }
}

wait_for_all_players_or_timeout() {
  level thread player_trying_to_join_infil_monitor();
  level thread max_wait_for_infil_to_start();
  level waittill("ready_to_start_infil");
}

player_trying_to_join_infil_monitor() {
  level endon("ready_to_start_infil");

  for(;;) {
    level waittill("trying_to_join_infil", player);
    level.num_of_player_ready_to_infil++;

    if(level.num_of_player_ready_to_infil == 2)
      level notify("ready_to_start_infil");
  }
}

max_wait_for_infil_to_start() {
  level endon("ready_to_start_infil");
  _id_95BD6EC3D906B671 = 5;
  wait(_id_95BD6EC3D906B671);
  level notify("ready_to_start_infil");
}

gamehasinfil() {
  if(!isDefined(game["infil"]))
    return 0;

  return 1;
}

isinfilgameplayteam(team) {
  return isDefined(team) && scripts\engine\utility::array_contains(level.teamnamelist, team);
}