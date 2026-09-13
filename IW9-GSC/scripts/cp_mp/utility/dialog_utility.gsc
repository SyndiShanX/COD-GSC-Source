/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\dialog_utility.gsc
****************************************************/

_id_39DC350193DD4BC4() {
  level._id_C9CB1071EA249E41 = [];
  _id_D4EE35DB6DBB7975 = tablelookupgetnumrows("sound/tables/iw9/dialog/gamedef_ref_table.csv");

  for(_id_09DD5D9E57E7E36D = 0; _id_09DD5D9E57E7E36D < _id_D4EE35DB6DBB7975; _id_09DD5D9E57E7E36D++) {
    _id_C8E0895D07762040 = tablelookupbyrow("sound/tables/iw9/dialog/gamedef_ref_table.csv", _id_09DD5D9E57E7E36D, 0);

    if(!_id_7B8ED176D07A4820(_id_C8E0895D07762040)) {
      continue;
    }
    _id_5C1182CB547CA916 = tablelookupbyrow("sound/tables/iw9/dialog/gamedef_ref_table.csv", _id_09DD5D9E57E7E36D, 3);

    if(!_id_1D467E88533267F6(_id_5C1182CB547CA916, _id_C8E0895D07762040)) {
      continue;
    }
    _id_1F9CCA93E19CF99C = tablelookupbyrow("sound/tables/iw9/dialog/gamedef_ref_table.csv", _id_09DD5D9E57E7E36D, 1);

    if(!_id_13BCCD41285B29FC(_id_1F9CCA93E19CF99C, _id_C8E0895D07762040, _id_5C1182CB547CA916)) {
      continue;
    }
    if(!isDefined(level._id_C9CB1071EA249E41[_id_C8E0895D07762040]))
      level._id_C9CB1071EA249E41[_id_C8E0895D07762040] = [];

    _id_A6461DE9055834B5 = spawnStruct();
    _id_A6461DE9055834B5._id_1F9CCA93E19CF99C = _id_1F9CCA93E19CF99C;
    _id_A6461DE9055834B5._id_5B5EE73ADFDDD952 = tablelookupbyrow("sound/tables/iw9/dialog/gamedef_ref_table.csv", _id_09DD5D9E57E7E36D, 2);
    _id_A6461DE9055834B5.parent = _id_5C1182CB547CA916;
    level._id_C9CB1071EA249E41[_id_C8E0895D07762040][level._id_C9CB1071EA249E41[_id_C8E0895D07762040].size] = _id_A6461DE9055834B5;
  }
}

_id_7B8ED176D07A4820(_id_C8E0895D07762040) {
  if(!isDefined(_id_C8E0895D07762040))
    return 0;

  switch (_id_C8E0895D07762040) {
    case "LoadSpec":
    case "Mode":
    case "ContextVarTmplt":
    case "Location":
    case "Audience":
      return 0;
  }

  return 1;
}

_id_1D467E88533267F6(_id_5C1182CB547CA916, _id_C8E0895D07762040) {
  if(!isDefined(_id_5C1182CB547CA916) || _id_5C1182CB547CA916 == "" && _id_C8E0895D07762040 != "Character")
    return 0;

  _id_67F14F8315CB0F2F = strtok(_id_5C1182CB547CA916, "_");

  if(_id_67F14F8315CB0F2F.size == 0 || _id_67F14F8315CB0F2F[0] == "mp")
    return 1;

  return 0;
}

_id_13BCCD41285B29FC(_id_1F9CCA93E19CF99C, _id_C8E0895D07762040, _id_5C1182CB547CA916) {
  if(!isDefined(_id_1F9CCA93E19CF99C) || _id_1F9CCA93E19CF99C == "")
    return 0;

  switch (_id_C8E0895D07762040) {
    case "Map":
      _id_67F14F8315CB0F2F = strtok(_id_1F9CCA93E19CF99C, "_");

      if(_id_67F14F8315CB0F2F.size > 0 && isDefined(_id_67F14F8315CB0F2F[1]) && (_id_67F14F8315CB0F2F[1] == "killstreak" || _id_67F14F8315CB0F2F[1] == "fieldupgrade" || _id_67F14F8315CB0F2F[1] == "equipment"))
        return 1;

      break;
    case "Scene":
      if(isDefined(_id_5C1182CB547CA916)) {
        _id_67F14F8315CB0F2F = strtok(_id_5C1182CB547CA916, "_");

        if(_id_67F14F8315CB0F2F.size > 0 && isDefined(_id_67F14F8315CB0F2F[1]) && (_id_67F14F8315CB0F2F[1] == "killstreak" || _id_67F14F8315CB0F2F[1] == "fieldupgrade" || _id_67F14F8315CB0F2F[1] == "equipment"))
          return 1;
      }

      break;
    case "Character":
      _id_67F14F8315CB0F2F = strtok(_id_1F9CCA93E19CF99C, " ");

      if(_id_67F14F8315CB0F2F.size > 0 && (isDefined(_id_67F14F8315CB0F2F[0]) && (_id_67F14F8315CB0F2F[0] == "SpecGru" || _id_67F14F8315CB0F2F[0] == "KorTac")) || isDefined(_id_67F14F8315CB0F2F[1]) && _id_67F14F8315CB0F2F[1] == "Team")
        return 1;

      break;
    case "Event":
      _id_67F14F8315CB0F2F = strtok(_id_1F9CCA93E19CF99C, "_");

      if(_id_67F14F8315CB0F2F.size > 0 && isDefined(_id_67F14F8315CB0F2F[2]) && (_id_67F14F8315CB0F2F[2] == "leader" || _id_67F14F8315CB0F2F[2] == "operator"))
        return 1;

      break;
  }

  return 0;
}

_id_309F1876DDA94360(typeref, _id_F8853606DE474AE1, _id_5C1182CB547CA916) {
  _id_F69D15D42339AF79 = level._id_C9CB1071EA249E41[typeref];

  if(!isDefined(_id_F69D15D42339AF79)) {}

  _id_B7A853CC2321F34A = undefined;

  foreach(_id_A6461DE9055834B5 in _id_F69D15D42339AF79) {
    if(_id_A6461DE9055834B5._id_1F9CCA93E19CF99C != _id_F8853606DE474AE1) {
      continue;
    }
    if(isDefined(_id_5C1182CB547CA916)) {
      if(_id_A6461DE9055834B5.parent != _id_5C1182CB547CA916)
        continue;
    }

    _id_B7A853CC2321F34A = _id_A6461DE9055834B5._id_5B5EE73ADFDDD952;
    break;
  }

  return _id_B7A853CC2321F34A;
}

_id_B847C6A9CA912337(_id_9E06D56DF7F6385F, _id_8406C878F4FC7DDA, _id_127D392E2057F2B0, _id_817B24CC21EDE559, eventref) {
  _id_DEC9BCCE93873125 = "dx";
  mode = _id_9E06D56DF7F6385F;
  _id_365929041E4386ED = _id_309F1876DDA94360("Map", _id_8406C878F4FC7DDA, _id_9E06D56DF7F6385F);
  scene = _id_309F1876DDA94360("Scene", _id_127D392E2057F2B0, _id_8406C878F4FC7DDA);
  _id_7DC3241E7F3C6B24 = _id_309F1876DDA94360("Character", _id_817B24CC21EDE559);
  event = _id_309F1876DDA94360("Event", eventref, _id_9E06D56DF7F6385F);
  _id_0AD0891EF68549E7 = _id_DEC9BCCE93873125;

  if(isDefined(mode))
    _id_0AD0891EF68549E7 = _id_0AD0891EF68549E7 + "_" + mode;

  if(isDefined(_id_365929041E4386ED))
    _id_0AD0891EF68549E7 = _id_0AD0891EF68549E7 + "_" + _id_365929041E4386ED;

  if(isDefined(scene))
    _id_0AD0891EF68549E7 = _id_0AD0891EF68549E7 + "_" + scene;

  if(isDefined(_id_7DC3241E7F3C6B24))
    _id_0AD0891EF68549E7 = _id_0AD0891EF68549E7 + "_" + _id_7DC3241E7F3C6B24;

  if(isDefined(event))
    _id_0AD0891EF68549E7 = _id_0AD0891EF68549E7 + "_" + event;

  return _id_0AD0891EF68549E7;
}

_id_D3C62D251D2AF8E6(team) {
  _id_5EC35B0D0E09922D = _id_592C1F6B3E44AC25(team);

  if(!isDefined(_id_5EC35B0D0E09922D)) {
    return;
  }
  return _id_5EC35B0D0E09922D + " Team Leader";
}

_id_592C1F6B3E44AC25(team) {
  _id_04FDF99C19DE6454 = isDefined(team) && scripts\engine\utility::array_contains(level.teamnamelist, team);

  if(!istrue(_id_04FDF99C19DE6454)) {
    return;
  }
  _id_B0E57D9E56C84230 = undefined;

  switch (game[team]) {
    case "ZVIR":
    case "RUSF":
    case "SEVEN":
      _id_B0E57D9E56C84230 = "RS";
      break;
    case "ICORPS":
    case "SABF":
      _id_B0E57D9E56C84230 = "SA";
      break;
    case "USMC":
    case "FIVE":
    case "SAS":
      _id_B0E57D9E56C84230 = "UK";
      break;
    case "GRP9":
    case "SIX":
      _id_B0E57D9E56C84230 = "DE";
      break;
    default:
      _id_B0E57D9E56C84230 = "UK";
      break;
  }

  return _id_B0E57D9E56C84230;
}

_id_13C4FF9B1A423445(dialog, group, _id_21D6D994B0F4FAF1, _id_061ACBEB6CCCD6BD, _id_7F23D950A1672F12) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  foreach(player in level.players)
  _id_E71772DE3D54144F(dialog, group, _id_21D6D994B0F4FAF1, _id_061ACBEB6CCCD6BD, _id_7F23D950A1672F12);
}

_id_3B08BE23BF113FCF(dialog, team, group, _id_21D6D994B0F4FAF1, _id_061ACBEB6CCCD6BD, _id_7F23D950A1672F12) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  if(!isDefined(team)) {
    return;
  }
  playerlist = undefined;

  if(isDefined(team)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
      playerlist = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](team, "players");
  }

  if(isDefined(playerlist) && playerlist.size > 0) {
    foreach(player in playerlist) {
      if(isDefined(_id_21D6D994B0F4FAF1) && scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player)) {
        continue;
      }
      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }
      _id_E71772DE3D54144F(dialog, player, group, _id_061ACBEB6CCCD6BD, _id_7F23D950A1672F12);
    }
  }
}

_id_E71772DE3D54144F(dialog, player, group, _id_061ACBEB6CCCD6BD, _id_7F23D950A1672F12) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  if(!istrue(_id_7F23D950A1672F12)) {
    if(istrue(level.disableannouncer)) {
      return;
    }
    if(isDefined(level.modeplayerskipdialog) && self[[level.modeplayerskipdialog]](dialog))
      return;
  }

  _id_0AD0891EF68549E7 = game["dialog"][dialog];

  if(isDefined(_id_061ACBEB6CCCD6BD)) {
    _id_9E06D56DF7F6385F = _id_061ACBEB6CCCD6BD.mode;
    _id_8406C878F4FC7DDA = _id_061ACBEB6CCCD6BD._id_365929041E4386ED;
    _id_127D392E2057F2B0 = _id_061ACBEB6CCCD6BD.scene;
    _id_817B24CC21EDE559 = _id_061ACBEB6CCCD6BD._id_7DC3241E7F3C6B24;
    eventref = _id_061ACBEB6CCCD6BD.event;
    _id_0AD0891EF68549E7 = "dx_" + _id_9E06D56DF7F6385F + "_" + _id_8406C878F4FC7DDA + "_" + _id_127D392E2057F2B0 + "_" + _id_817B24CC21EDE559 + "tl_" + eventref;
  }

  _id_CB3339ECE72DBDEB = tolower(_id_0AD0891EF68549E7);

  if(_func_D03495FE6418377B(dialog))
    dialog = _func_0F28FD66285FA2C9(dialog);

  player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2, group);
}