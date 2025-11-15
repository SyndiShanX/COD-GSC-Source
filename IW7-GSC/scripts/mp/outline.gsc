/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\outline.gsc
**********************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  level thread func_C788();
  level thread func_C7A4();
  level thread outlineidswatchpending();
}

outlineenableinternal(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_00.outlines)) {
    param_00.outlines = [];
  }

  var_08 = spawnStruct();
  var_08.isdisabled = 0;
  var_08.priority = param_05;
  var_08.colorindex = param_01;
  var_08.playersvisibleto = param_02;
  var_08.playersvisibletopending = [];
  var_08.var_525C = param_03;
  var_08.var_6C10 = param_04;
  var_08.type = param_06;
  if(param_06 == "TEAM") {
    var_08.team = param_07;
  }

  var_09 = outlinegenerateuniqueid();
  param_00.outlines[var_09] = var_08;
  outlineaddtogloballist(param_00);
  var_0A = [];
  foreach(var_0C in var_08.playersvisibleto) {
    if(!canoutlineforplayer(var_0C)) {
      var_08.playersvisibletopending[var_08.playersvisibletopending.size] = var_0C;
      level.outlineidspending[var_09] = param_00;
      continue;
    }

    var_0D = outlinegethighestinfoforplayer(param_00, var_0C);
    if(!isDefined(var_0D) || var_0D == var_08 || var_0D.priority == var_08.priority) {
      var_0A[var_0A.size] = var_0C;
    }
  }

  if(var_0A.size > 0) {
    param_00 _hudoutlineenableforclients(var_0A, var_08.colorindex, var_08.var_525C, var_08.var_6C10);
  }

  return var_09;
}

outlinedisableinternal(param_00, param_01) {
  if(!isDefined(param_01)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(param_01.outlines)) {
    outlineremovefromgloballist(param_01);
    return;
  }

  var_02 = param_01.outlines[param_00];
  if(!isDefined(var_02) || var_02.isdisabled) {
    return;
  }

  var_02.isdisabled = 1;
  foreach(var_04 in var_02.playersvisibleto) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(!canoutlineforplayer(var_04)) {
      var_02.playersvisibletopending[var_02.playersvisibletopending.size] = var_04;
      level.outlineidspending[param_00] = param_01;
      continue;
    }

    var_05 = outlinegethighestinfoforplayer(param_01, var_04);
    if(isDefined(var_05)) {
      if(var_05.priority <= var_02.priority) {
        param_01 _hudoutlineenableforclient(var_04, var_05.colorindex, var_05.var_525C, var_05.var_6C10);
      }

      continue;
    }

    param_01 hudoutlinedisableforclient(var_04);
  }

  if(var_02.playersvisibletopending.size == 0) {
    param_01.outlines[param_00] = undefined;
    if(param_01.outlines.size == 0) {
      outlineremovefromgloballist(param_01);
    }
  }
}

func_C7AB(param_00) {
  if(!isDefined(param_00.outlines) || param_00.outlines.size == 0) {
    return;
  }

  foreach(var_02 in param_00.outlines) {
    if(!isDefined(var_02) || var_02.isdisabled) {
      continue;
    }

    foreach(var_04 in var_02.playersvisibleto) {
      if(!isDefined(var_04)) {
        continue;
      }

      var_05 = outlinegethighestinfoforplayer(param_00, var_04);
      if(isDefined(var_05)) {
        param_00 _hudoutlineenableforclient(var_04, var_05.colorindex, var_05.var_525C, var_05.var_6C10);
      }
    }
  }
}

func_C788() {
  for(;;) {
    level waittill("connected", var_00);
    level thread func_C7A3(var_00);
  }
}

func_C7A3(param_00) {
  level endon("game_ended");
  param_00 waittill("disconnect");
  outlineremoveplayerfromvisibletoarrays(param_00);
  outlinedisableinternalall(param_00);
}

func_C7A4() {
  for(;;) {
    level waittill("joined_team", var_00);
    if(!isDefined(var_00.team) || var_00.team == "spectator") {
      continue;
    }

    thread outlineonplayerjoinedteam_onfirstspawn(var_00);
  }
}

outlineonplayerjoinedteam_onfirstspawn(param_00) {
  param_00 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  param_00 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  param_00 endon("disconnect");
  param_00 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(param_00);
  outlinedisableinternalall(param_00);
  outlineaddplayertoexistingallandteamoutlines(param_00);
}

outlineremoveplayerfromvisibletoarrays(param_00) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
  foreach(var_02 in level.outlineents) {
    var_03 = 0;
    foreach(var_05 in var_02.outlines) {
      var_05.playersvisibleto = scripts\engine\utility::array_removeundefined(var_05.playersvisibleto);
      if(isDefined(param_00) && scripts\engine\utility::array_contains(var_05.playersvisibleto, param_00)) {
        var_05.playersvisibleto = scripts\engine\utility::array_remove(var_05.playersvisibleto, param_00);
        var_03 = 1;
      }
    }

    if(var_03 && isDefined(var_02) && isDefined(param_00)) {
      var_02 hudoutlinedisableforclient(param_00);
    }
  }
}

outlineaddplayertoexistingallandteamoutlines(param_00) {
  foreach(var_02 in level.outlineents) {
    if(!isDefined(var_02)) {
      continue;
    }

    var_03 = undefined;
    foreach(var_05 in var_02.outlines) {
      if(var_05.type == "ALL" || var_05.type == "TEAM" && var_05.team == param_00.team) {
        if(!scripts\engine\utility::array_contains(var_05.playersvisibleto, param_00)) {
          var_05.playersvisibleto[var_05.playersvisibleto.size] = param_00;
        } else {}

        if(!isDefined(var_03) || var_05.priority > var_03.priority) {
          var_03 = var_05;
        }
      }
    }

    if(isDefined(var_03)) {
      var_02 _hudoutlineenableforclient(param_00, var_03.colorindex, var_03.var_525C, var_03.var_6C10);
    }
  }
}

outlinedisableinternalall(param_00) {
  if(!isDefined(param_00) || !isDefined(param_00.outlines) || param_00.outlines.size == 0) {
    return;
  }

  foreach(var_03, var_02 in param_00.outlines) {
    outlinedisableinternal(var_03, param_00);
  }
}

outlineaddtogloballist(param_00) {
  if(!scripts\engine\utility::array_contains(level.outlineents, param_00)) {
    level.outlineents[level.outlineents.size] = param_00;
  }
}

outlineremovefromgloballist(param_00) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, param_00);
}

outlinegethighestpriorityid(param_00) {
  var_01 = -1;
  if(!isDefined(param_00.outlines) || param_00.size == 0) {
    return var_01;
  }

  var_02 = undefined;
  foreach(var_05, var_04 in param_00.outlines) {
    if(!isDefined(var_04) || var_04.isdisabled) {
      continue;
    }

    if(!isDefined(var_02) || var_04.priority > var_02.priority) {
      var_02 = var_04;
      var_01 = var_05;
    }
  }

  return var_01;
}

outlinegethighestinfoforplayer(param_00, param_01) {
  var_02 = undefined;
  if(!isDefined(param_00.outlines) || param_00.size == 0) {
    return var_02;
  }

  foreach(var_04 in param_00.outlines) {
    if(!isDefined(var_04) || var_04.isdisabled) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_04.playersvisibleto, param_01) && !isDefined(var_02) || var_04.priority > var_02.priority) {
      var_02 = var_04;
    }
  }

  return var_02;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

func_C7A9(param_00) {
  param_00 = tolower(param_00);
  var_01 = undefined;
  switch (param_00) {
    case "lowest":
      var_01 = 0;
      break;

    case "level_script":
      var_01 = 1;
      break;

    case "equipment":
      var_01 = 2;
      break;

    case "perk":
      var_01 = 3;
      break;

    case "perk_superior":
      var_01 = 4;
      break;

    case "killstreak":
      var_01 = 5;
      break;

    case "killstreak_personal":
      var_01 = 6;
      break;

    default:
      var_01 = 0;
      break;
  }

  return var_01;
}

func_C78A(param_00) {
  param_00 = tolower(param_00);
  var_01 = undefined;
  switch (param_00) {
    case "white":
      var_01 = 0;
      break;

    case "red":
      var_01 = 1;
      break;

    case "green":
      var_01 = 2;
      break;

    case "cyan":
      var_01 = 3;
      break;

    case "orange":
      var_01 = 4;
      break;

    case "yellow":
      var_01 = 5;
      break;

    case "blue":
      var_01 = 6;
      break;

    case "none":
      var_01 = 7;
      break;

    default:
      var_01 = 0;
      break;
  }

  return var_01;
}

outlineidswatchpending() {
  for(;;) {
    waittillframeend;
    foreach(var_03, var_01 in level.outlineidspending) {
      if(!isDefined(var_01)) {
        continue;
      }

      if(!isDefined(var_01.outlines)) {
        continue;
      }

      var_02 = var_01.outlines[var_03];
      if(!isDefined(var_02)) {
        continue;
      }

      if(var_02.playersvisibletopending.size > 0) {
        if(outlinerefreshpending(var_01, var_03)) {
          level.outlineidspending[var_03] = undefined;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

outlinerefreshpending(param_00, param_01) {
  var_02 = param_00.outlines[param_01];
  foreach(var_06, var_04 in var_02.playersvisibletopending) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(canoutlineforplayer(var_04)) {
      var_05 = outlinegethighestinfoforplayer(param_00, var_04);
      if(isDefined(var_05)) {
        param_00 hudoutlineenableforclient(var_04, var_05.colorindex, var_05.var_525C, var_05.var_6C10);
      } else {
        param_00 hudoutlinedisableforclient(var_04);
      }

      var_02.playersvisibletopending[var_06] = undefined;
    }
  }

  var_02.playersvisibletopending = scripts\engine\utility::array_removeundefined(var_02.playersvisibletopending);
  if(var_02.playersvisibletopending.size == 0) {
    if(var_02.isdisabled) {
      param_00.outlines[param_01] = undefined;
    }

    if(param_00.outlines.size == 0) {
      outlineremovefromgloballist(param_00);
    }

    return 1;
  }

  return 0;
}

canoutlineforplayer(param_00) {
  return param_00.sessionstate != "spectator";
}

_hudoutlineenableforclient(param_00, param_01, param_02, param_03) {
  if(param_01 == 7) {
    self hudoutlinedisableforclient(param_00);
    return;
  }

  self hudoutlineenableforclient(param_00, param_01, param_02, param_03);
}

_hudoutlineenableforclients(param_00, param_01, param_02, param_03) {
  if(param_01 == 7) {
    self hudoutlinedisableforclients(param_00);
    return;
  }

  self hudoutlineenableforclients(param_00, param_01, param_02, param_03);
}