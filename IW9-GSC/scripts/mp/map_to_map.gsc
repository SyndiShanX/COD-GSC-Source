/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\map_to_map.gsc
***********************************************/

_id_B0DAEF016957DF38() {
  if(getdvarint("dvar_244DC0B0C771CD3D", 1) == 0) {
    return;
  }
  wait 3;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("map_transition_prompt", ::_id_7E2E0F563FA9008A);
  level._id_A05F3BD63F29EFF9 = spawnStruct();
  level._id_A05F3BD63F29EFF9._id_CC41B5D31D55087B = [];
  level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811 = [];
  level._id_A05F3BD63F29EFF9._id_4261399CE533359A = getdvarint("dvar_5BB49886B748AB20", 25);
  _id_CA410F77E36EB494 = getdvarint("dvar_4499B8ECF41E59CE", 2048);
  level._id_A05F3BD63F29EFF9._id_CA410F77E36EB494 = _id_CA410F77E36EB494 * _id_CA410F77E36EB494;
  _id_3ABE37FEA6EC6FEF = getdvarint("dvar_5EA0B9183C001E76", 4096);
  level._id_A05F3BD63F29EFF9._id_3ABE37FEA6EC6FEF = _id_3ABE37FEA6EC6FEF * _id_3ABE37FEA6EC6FEF;
  _id_80E7F41F01EF7496("biobunker", getdvarint("dvar_B6445FC691760F92", 136));
  level._id_A05F3BD63F29EFF9._id_87E9C184BCDFD9F5 = getdvarint("dvar_196CDAB33A3F0148", 1);
  level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650 = [];
  _id_FC18D697A917021D = getdvarint("dvar_DD30517391DDF811", 1);

  if(!_id_FC18D697A917021D)
    level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650[level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650.size] = "oasis";

  _id_FC18D697A917021D = getdvarint("dvar_EC51BBFC3DC4418F", 1);

  if(!_id_FC18D697A917021D)
    level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650[level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650.size] = "wartorn";

  _id_FC18D697A917021D = getdvarint("dvar_E274C3AEA0268188", 1);

  if(!_id_FC18D697A917021D)
    level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650[level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650.size] = "oilfield";

  _id_FC18D697A917021D = getdvarint("dvar_905734EB55454584", 1);

  if(!_id_FC18D697A917021D)
    level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650[level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650.size] = "moderncity";

  _id_334A8A419BFC02C5("oasis", 1);
  _id_334A8A419BFC02C5("wartorn", 2);
  _id_334A8A419BFC02C5("oilfield", 3);
  _id_334A8A419BFC02C5("moderncity", 4);
  _id_954713C561C4CC55();
}

_id_954713C561C4CC55() {
  _id_70DADFF71BCC3340 = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray("map2map_usePrompt", "script_noteworthy"), scripts\engine\utility::getStructArray("map2map_usePrompt_instant", "script_noteworthy"));

  foreach(_id_1E88D0B4C5322E0E in _id_70DADFF71BCC3340) {
    _id_0742517198D568EA = _id_88CA4DCA7931B39B(_id_1E88D0B4C5322E0E);

    if(isDefined(_id_0742517198D568EA) && !isDefined(level._id_A05F3BD63F29EFF9._id_CC41B5D31D55087B[_id_0742517198D568EA.locname]))
      level._id_A05F3BD63F29EFF9._id_CC41B5D31D55087B[_id_0742517198D568EA.locname] = _id_0742517198D568EA;

    if(istrue(level._id_A05F3BD63F29EFF9._id_87E9C184BCDFD9F5) && _id_1E88D0B4C5322E0E.targetname != "map2map_biobunker_oasis")
      _id_6451879E18908224 = spawnscriptable("map2map_tacmap_location_scriptable", _id_1E88D0B4C5322E0E.origin);
  }
}

_id_88CA4DCA7931B39B(_id_1E88D0B4C5322E0E) {
  _id_0742517198D568EA = spawnStruct();
  _id_67F14F8315CB0F2F = strtok(_id_1E88D0B4C5322E0E.targetname, "_");
  mapname = tolower(_id_67F14F8315CB0F2F[1]);
  _id_0742517198D568EA._id_D99531C79FCAE1F0 = mapname;
  locname = tolower(_id_67F14F8315CB0F2F[2]);
  _id_0742517198D568EA.locname = locname;

  if(scripts\engine\utility::array_contains(level._id_A05F3BD63F29EFF9._id_E5EE4CCA24584650, locname))
    _id_0742517198D568EA = undefined;
  else {
    _id_0742517198D568EA.useprompt = _id_7E139D3AB9ACB1A9(_id_1E88D0B4C5322E0E);
    _id_0742517198D568EA.useprompt._id_D99531C79FCAE1F0 = _id_0742517198D568EA._id_D99531C79FCAE1F0;
    _id_0742517198D568EA.useprompt._id_756408641D217B57 = _id_5EE910117A53F7E0(locname);
    _id_0742517198D568EA.useprompt.locname = locname;

    if(!istrue(_id_0742517198D568EA.useprompt._id_0586E6FFC8BEF794)) {
      triggers = _func_F159C10D5CF8F0B4(_id_1E88D0B4C5322E0E.targetname, "targetname");

      if(isDefined(triggers))
        _id_0742517198D568EA.useprompt.trigger = triggers[0];

      _id_0742517198D568EA.useprompt thread _id_E43E0F078B1006CE(_id_0742517198D568EA.useprompt.trigger, _id_0742517198D568EA.useprompt._id_756408641D217B57);
    }
  }
}

_id_7E139D3AB9ACB1A9(_id_1E88D0B4C5322E0E) {
  scriptable = spawnscriptable("map_transition_prompt", _id_1E88D0B4C5322E0E.origin);
  scriptable setscriptablepartstate("map_transition_prompt", "on");

  if(issubstr(_id_1E88D0B4C5322E0E.script_noteworthy, "_instant"))
    scriptable._id_0586E6FFC8BEF794 = 1;

  return scriptable;
}

_id_7E2E0F563FA9008A(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance.locname) && instance.locname == "oasis")
    _id_6A8EC730B2BFA844::_id_B49C89AD7EDCF17B(player);

  if(istrue(instance._id_0586E6FFC8BEF794)) {
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);
    _id_3209B7C7F08A12DA(_id_E2B2BBD9E6539F11, instance._id_D99531C79FCAE1F0, instance._id_756408641D217B57);
    return;
  }

  if(isDefined(level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[player.team])) {
    return;
  }
  _id_DCE86BBE8B64B892(player.team, instance);

  if(getdvarint("dvar_FDF7B751C4C1AA5C", 1) == 1)
    _id_DB49FA5C1EE8814D(player.team);

  instance thread _id_5B878641633E68B1(player.team, level._id_A05F3BD63F29EFF9._id_4261399CE533359A, instance._id_D99531C79FCAE1F0, instance._id_756408641D217B57);
}

_id_DB49FA5C1EE8814D(team) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer")) {
    return;
  }
  foreach(player in level.teamdata[team]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "map2map_warp");
}

_id_C6B9237B5132CE26(team) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "enablePlayer")) {
    return;
  }
  foreach(player in level.teamdata[team]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](player, "map2map_warp");
}

_id_5B878641633E68B1(team, time, _id_D99531C79FCAE1F0, _id_756408641D217B57) {
  useprompt = self;
  level endon("game_ended");
  _id_E2297E7E8E96DE9F = scripts\mp\utility\teams::getfriendlyplayers(team);
  _id_B440527AD8CB0B15 = [];

  foreach(player in _id_E2297E7E8E96DE9F) {
    if(isDefined(player) && !player scripts\cp_mp\utility\player_utility::_isalive())
      _id_B440527AD8CB0B15[_id_B440527AD8CB0B15.size] = player;
  }

  trigger = useprompt.trigger;

  if(isDefined(team) && !isDefined(level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team])) {
    level endon("map2map_warp_cancel" + team);
    level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = time;
  } else
    return;

  while(level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] >= 0) {
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(team);
    playersintrigger = _id_F1097A7BA31434E4(team, useprompt.trigger);

    if(!isDefined(playersintrigger) || playersintrigger.size == 0)
      _id_ED32D36F2BB763EE(team, useprompt);
    else if(_id_E2B2BBD9E6539F11.size == playersintrigger.size) {
      if(level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] > 5)
        level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = 5;
    }

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!isDefined(player)) {
        continue;
      }
      useprompt disablescriptableplayeruse(player);
      player setclientomnvar("ui_dmz_map_to_map_prompt_visible", 0);
      player setclientomnvar("ui_dmz_warp_hazard", _id_E0947372B9A0F240(_id_756408641D217B57));

      if(player scripts\cp_mp\utility\player_utility::_isalive() && scripts\engine\utility::array_contains(_id_B440527AD8CB0B15, player))
        _id_B440527AD8CB0B15 = scripts\engine\utility::array_remove(_id_B440527AD8CB0B15, player);
      else if(!player scripts\cp_mp\utility\player_utility::_isalive() && !scripts\engine\utility::array_contains(_id_B440527AD8CB0B15, player)) {
        _id_B440527AD8CB0B15[_id_B440527AD8CB0B15.size] = player;

        if(distance2dsquared(player.origin, useprompt.origin) < level._id_A05F3BD63F29EFF9._id_CA410F77E36EB494)
          _id_ED32D36F2BB763EE(team, useprompt);
      }

      if(scripts\engine\utility::array_contains(playersintrigger, player))
        player setclientomnvar("ui_dmz_warp_proximity", 0);
      else if(distance2dsquared(player.origin, useprompt.origin) < level._id_A05F3BD63F29EFF9._id_3ABE37FEA6EC6FEF)
        player setclientomnvar("ui_dmz_warp_proximity", 1);
      else
        player setclientomnvar("ui_dmz_warp_proximity", 2);

      player setclientomnvar("ui_dmz_warp_timer", level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team]);
    }

    wait 1;
    level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] - 1;
  }

  _id_C03A8F0CF1D4156F(team, useprompt);
  level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = undefined;
}

_id_ED32D36F2BB763EE(team, useprompt) {
  _id_F7A553353C2C4F99(team, useprompt);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(team);

  foreach(player in _id_E2B2BBD9E6539F11) {
    useprompt enablescriptableplayeruse(player);
    player setclientomnvar("ui_dmz_map_to_map_prompt_visible", 1);
    player._id_1F313499D1F87A24 = undefined;
    player _id_396A814D39E7044F::_id_24A08F8A03BE8244();
    player setplayermusicstate("");
    player._id_43653D344AA392AF = undefined;
  }

  level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = undefined;
  level notify("map2map_warp_cancel" + team);
}

_id_51AAD52CC5171DF3(_id_F3B6838B04870FC4) {
  if(_id_F3B6838B04870FC4)
    self._id_1F313499D1F87A24 = 1;
}

_id_C03A8F0CF1D4156F(team, useprompt) {
  level endon("map2map_warp_cancel" + team);
  level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = 30;
  _id_C8B6A0CFA05E1CCC = 0;
  _id_E0A412433514E56A = scripts\mp\utility\teams::getfriendlyplayers(team);

  while(!_id_C8B6A0CFA05E1CCC) {
    playersintrigger = _id_F1097A7BA31434E4(team, useprompt.trigger);

    if(playersintrigger.size == 0 || level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] == 0)
      _id_ED32D36F2BB763EE(team, useprompt);

    foreach(player in playersintrigger) {
      if(!isDefined(player._id_43653D344AA392AF))
        player thread scripts\mp\music_and_dialog::_id_C080EBBCDCC3176F();

      player setclientomnvar("ui_dmz_warp_state", 3);

      if(!player _id_396A814D39E7044F::_id_74C8EB2AAF9F5D14(5))
        player thread _id_396A814D39E7044F::_id_36EDF91561322753(5, level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team], ::_id_51AAD52CC5171DF3);

      if(isDefined(player._id_1F313499D1F87A24))
        _id_C8B6A0CFA05E1CCC = 1;
    }

    foreach(player in _id_E0A412433514E56A) {
      if(scripts\engine\utility::array_contains(playersintrigger, player))
        player setclientomnvar("ui_dmz_warp_proximity", 0);
      else {
        if(player _id_396A814D39E7044F::_id_74C8EB2AAF9F5D14(5))
          player _id_396A814D39E7044F::_id_24A08F8A03BE8244();

        if(distance2dsquared(player.origin, useprompt.origin) < level._id_A05F3BD63F29EFF9._id_3ABE37FEA6EC6FEF)
          player setclientomnvar("ui_dmz_warp_proximity", 1);
        else
          player setclientomnvar("ui_dmz_warp_proximity", 2);
      }

      player setclientomnvar("ui_dmz_warp_timer", level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team]);
    }

    wait 1;
    _id_E0A412433514E56A = scripts\mp\utility\teams::getfriendlyplayers(team);
    level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] - 1;

    if(level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] < 0)
      level._id_A05F3BD63F29EFF9._id_9BA3E89771B7D811[team] = 0;
  }

  _id_E0A412433514E56A = scripts\mp\utility\teams::getfriendlyplayers(team);
  playersintrigger = _id_F1097A7BA31434E4(team, useprompt.trigger);
  _id_7073126D9ED50BF2 = [];
  _id_0797722CED855104 = [];

  foreach(player in _id_E0A412433514E56A) {
    _id_F5A62EA4F4C7F032 = 0;

    if(scripts\engine\utility::array_contains(playersintrigger, player))
      _id_F5A62EA4F4C7F032 = 1;

    if(player scripts\cp_mp\utility\player_utility::_isalive() && _id_F5A62EA4F4C7F032) {
      _id_7073126D9ED50BF2[_id_7073126D9ED50BF2.size] = player;
      continue;
    }

    player setplayermusicstate("");
    player._id_43653D344AA392AF = undefined;
    _id_0797722CED855104[_id_0797722CED855104.size] = player;
  }

  playsoundatpos(useprompt.origin, "dmz_biobunker_radiation_vault_door_open");
  _id_3209B7C7F08A12DA(_id_7073126D9ED50BF2, useprompt._id_D99531C79FCAE1F0, useprompt._id_756408641D217B57);

  foreach(player in _id_0797722CED855104)
  player setclientomnvar("ui_dmz_warp_state", 4);

  wait 5;

  if(getdvarint("dvar_FDF7B751C4C1AA5C", 1) == 1)
    _id_C6B9237B5132CE26(team);

  foreach(player in _id_0797722CED855104) {
    if(!isDefined(player)) {
      continue;
    }
    useprompt enablescriptableplayeruse(player);
    player setclientomnvar("ui_dmz_map_to_map_prompt_visible", 1);
    player setclientomnvar("ui_dmz_warp_state", 5);
  }
}

_id_DCE86BBE8B64B892(team, instance) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(team);

  foreach(player in _id_E2B2BBD9E6539F11)
  player setclientomnvar("ui_dmz_warp_state", 2);
}

_id_F7A553353C2C4F99(team, instance) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(team);

  foreach(player in _id_E2B2BBD9E6539F11)
  player setclientomnvar("ui_dmz_warp_state", 0);

  if(getdvarint("dvar_FDF7B751C4C1AA5C", 1) == 1)
    _id_C6B9237B5132CE26(team);
}

_id_3209B7C7F08A12DA(players, _id_D99531C79FCAE1F0, _id_756408641D217B57) {
  foreach(player in players) {
    player._id_DED04CDD264A7E00 = 1;
    player._id_1F313499D1F87A24 = undefined;
    player setclientomnvar("ui_dmz_warp_state", 5);
    player notify("map_to_map_warp");
    player _id_5307834CD39B435C::_id_DF3BFE2C77975120();
  }

  _func_D296788A307D5162(players, _id_2364A3AE41C2CE7F(_id_D99531C79FCAE1F0), _id_756408641D217B57);
}

_id_E43E0F078B1006CE(trigger, _id_756408641D217B57) {
  level endon("game_ended");

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    thread _id_8AD822E2A2CEFA44(trigger, _id_756408641D217B57);
    return;
  }

  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(trigger.origin);

  for(;;) {
    if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) && isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])) {
      foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
        if(ispointinvolume(player.origin, trigger)) {}
      }
    }

    waitframe();
  }
}

_id_8AD822E2A2CEFA44(trigger, _id_756408641D217B57) {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(ispointinvolume(player.origin, trigger)) {}
    }

    waitframe();
  }
}

_id_F1097A7BA31434E4(team, trigger) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
  playersintrigger = [];

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(ispointinvolume(player.origin, trigger))
      playersintrigger[playersintrigger.size] = player;
  }

  return playersintrigger;
}

_id_80E7F41F01EF7496(_id_7040AF990F6CE27A, _id_85D8DAEAC55B1742) {
  if(!isDefined(level._id_A05F3BD63F29EFF9._id_B700A350075400C3))
    level._id_A05F3BD63F29EFF9._id_B700A350075400C3 = [];

  level._id_A05F3BD63F29EFF9._id_B700A350075400C3[_id_7040AF990F6CE27A] = _id_85D8DAEAC55B1742;
}

_id_2364A3AE41C2CE7F(_id_7040AF990F6CE27A) {
  return level._id_A05F3BD63F29EFF9._id_B700A350075400C3[_id_7040AF990F6CE27A];
}

_id_334A8A419BFC02C5(_id_8F3CECEFC2DE967C, id) {
  if(!isDefined(level._id_A05F3BD63F29EFF9._id_756408641D217B57))
    level._id_A05F3BD63F29EFF9._id_756408641D217B57 = [];

  level._id_A05F3BD63F29EFF9._id_756408641D217B57[_id_8F3CECEFC2DE967C] = id;
}

_id_5EE910117A53F7E0(_id_8F3CECEFC2DE967C) {
  return level._id_A05F3BD63F29EFF9._id_756408641D217B57[_id_8F3CECEFC2DE967C];
}

_id_E0947372B9A0F240(_id_756408641D217B57) {
  switch (_id_756408641D217B57) {
    case 1:
      return 2;
    case 2:
      return 1;
    case 3:
      return 0;
    case 4:
      return 0;
    default:
      return 0;
  }
}