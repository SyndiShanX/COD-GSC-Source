/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2777.gsc
**************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  level thread func_C788();
  level thread func_C7A4();
  level thread outlineidswatchpending();
}

outlineenableinternal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0.outlines)) {
    var_0.outlines = [];
  }

  var_8 = spawnStruct();
  var_8.isdisabled = 0;
  var_8.priority = var_5;
  var_8.colorindex = var_1;
  var_8.playersvisibleto = var_2;
  var_8.playersvisibletopending = [];
  var_8.var_525C = var_3;
  var_8.var_6C10 = var_4;
  var_8.type = var_6;

  if(var_6 == "TEAM") {
    var_8.team = var_7;
  }

  var_9 = outlinegenerateuniqueid();
  var_0.outlines[var_9] = var_8;
  outlineaddtogloballist(var_0);
  var_10 = [];

  foreach(var_12 in var_8.playersvisibleto) {
    if(!canoutlineforplayer(var_12)) {
      var_8.playersvisibletopending[var_8.playersvisibletopending.size] = var_12;
      level.outlineidspending[var_9] = var_0;
      continue;
    }

    var_13 = outlinegethighestinfoforplayer(var_0, var_12);

    if(!isDefined(var_13) || var_13 == var_8 || var_13.priority == var_8.priority) {
      var_10[var_10.size] = var_12;
    }
  }

  if(var_10.size > 0) {
    var_0 _hudoutlineenableforclients(var_10, var_8.colorindex, var_8.var_525C, var_8.var_6C10);
  }

  return var_9;
}

outlinedisableinternal(var_0, var_1) {
  if(!isDefined(var_1)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(var_1.outlines)) {
    outlineremovefromgloballist(var_1);
    return;
  }

  var_2 = var_1.outlines[var_0];

  if(!isDefined(var_2) || var_2.isdisabled) {
    return;
  }
  var_2.isdisabled = 1;

  foreach(var_4 in var_2.playersvisibleto) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!canoutlineforplayer(var_4)) {
      var_2.playersvisibletopending[var_2.playersvisibletopending.size] = var_4;
      level.outlineidspending[var_0] = var_1;
      continue;
    }

    var_5 = outlinegethighestinfoforplayer(var_1, var_4);

    if(isDefined(var_5)) {
      if(var_5.priority <= var_2.priority) {
        var_1 _hudoutlineenableforclient(var_4, var_5.colorindex, var_5.var_525C, var_5.var_6C10);
      }

      continue;
    }

    var_1 hudoutlinedisableforclient(var_4);
  }

  if(var_2.playersvisibletopending.size == 0) {
    var_1.outlines[var_0] = undefined;

    if(var_1.outlines.size == 0) {
      outlineremovefromgloballist(var_1);
    }
  }
}

func_C7AB(var_0) {
  if(!isDefined(var_0.outlines) || var_0.outlines.size == 0) {
    return;
  }
  foreach(var_7, var_2 in var_0.outlines) {
    if(!isDefined(var_2) || var_2.isdisabled) {
      continue;
    }
    foreach(var_4 in var_2.playersvisibleto) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = outlinegethighestinfoforplayer(var_0, var_4);

      if(isDefined(var_5)) {
        var_0 _hudoutlineenableforclient(var_4, var_5.colorindex, var_5.var_525C, var_5.var_6C10);
      }
    }
  }
}

func_C788() {
  for(;;) {
    level waittill("connected", var_0);
    level thread func_C7A3(var_0);
  }
}

func_C7A3(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
}

func_C7A4() {
  for(;;) {
    level waittill("joined_team", var_0);

    if(!isDefined(var_0.team) || var_0.team == "spectator") {
      continue;
    }
    thread outlineonplayerjoinedteam_onfirstspawn(var_0);
  }
}

outlineonplayerjoinedteam_onfirstspawn(var_0) {
  var_0 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
  outlineaddplayertoexistingallandteamoutlines(var_0);
}

outlineremoveplayerfromvisibletoarrays(var_0) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(var_2 in level.outlineents) {
    var_3 = 0;

    foreach(var_5 in var_2.outlines) {
      var_5.playersvisibleto = scripts\engine\utility::array_removeundefined(var_5.playersvisibleto);

      if(isDefined(var_0) && scripts\engine\utility::array_contains(var_5.playersvisibleto, var_0)) {
        var_5.playersvisibleto = scripts\engine\utility::array_remove(var_5.playersvisibleto, var_0);
        var_3 = 1;
      }
    }

    if(var_3 && isDefined(var_2) && isDefined(var_0)) {
      var_2 hudoutlinedisableforclient(var_0);
    }
  }
}

outlineaddplayertoexistingallandteamoutlines(var_0) {
  foreach(var_2 in level.outlineents) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;

    foreach(var_5 in var_2.outlines) {
      if(var_5.type == "ALL" || var_5.type == "TEAM" && var_5.team == var_0.team) {
        if(!scripts\engine\utility::array_contains(var_5.playersvisibleto, var_0)) {
          var_5.playersvisibleto[var_5.playersvisibleto.size] = var_0;
        }

        if(!isDefined(var_3) || var_5.priority > var_3.priority) {
          var_3 = var_5;
        }
      }
    }

    if(isDefined(var_3)) {
      var_2 _hudoutlineenableforclient(var_0, var_3.colorindex, var_3.var_525C, var_3.var_6C10);
    }
  }
}

outlinedisableinternalall(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.outlines) || var_0.outlines.size == 0) {
    return;
  }
  foreach(var_3, var_2 in var_0.outlines) {
    outlinedisableinternal(var_3, var_0);
  }
}

outlineaddtogloballist(var_0) {
  if(!scripts\engine\utility::array_contains(level.outlineents, var_0)) {
    level.outlineents[level.outlineents.size] = var_0;
  }
}

outlineremovefromgloballist(var_0) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, var_0);
}

outlinegethighestpriorityid(var_0) {
  var_1 = -1;

  if(!isDefined(var_0.outlines) || var_0.size == 0) {
    return var_1;
  }

  var_2 = undefined;

  foreach(var_5, var_4 in var_0.outlines) {
    if(!isDefined(var_4) || var_4.isdisabled) {
      continue;
    }
    if(!isDefined(var_2) || var_4.priority > var_2.priority) {
      var_2 = var_4;
      var_1 = var_5;
    }
  }

  return var_1;
}

outlinegethighestinfoforplayer(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0.outlines) || var_0.size == 0) {
    return var_2;
  }

  foreach(var_5, var_4 in var_0.outlines) {
    if(!isDefined(var_4) || var_4.isdisabled) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_4.playersvisibleto, var_1) && (!isDefined(var_2) || var_4.priority > var_2.priority)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

func_C7A9(var_0) {
  var_0 = tolower(var_0);
  var_1 = undefined;

  switch (var_0) {
    case "lowest":
      var_1 = 0;
      break;
    case "level_script":
      var_1 = 1;
      break;
    case "equipment":
      var_1 = 2;
      break;
    case "perk":
      var_1 = 3;
      break;
    case "perk_superior":
      var_1 = 4;
      break;
    case "killstreak":
      var_1 = 5;
      break;
    case "killstreak_personal":
      var_1 = 6;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

func_C78A(var_0) {
  var_0 = tolower(var_0);
  var_1 = undefined;

  switch (var_0) {
    case "white":
      var_1 = 0;
      break;
    case "red":
      var_1 = 1;
      break;
    case "green":
      var_1 = 2;
      break;
    case "cyan":
      var_1 = 3;
      break;
    case "orange":
      var_1 = 4;
      break;
    case "yellow":
      var_1 = 5;
      break;
    case "blue":
      var_1 = 6;
      break;
    case "none":
      var_1 = 7;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

outlineidswatchpending() {
  for(;;) {
    waittillframeend;

    foreach(var_3, var_1 in level.outlineidspending) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!isDefined(var_1.outlines)) {
        continue;
      }
      var_2 = var_1.outlines[var_3];

      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2.playersvisibletopending.size > 0) {
        if(outlinerefreshpending(var_1, var_3)) {
          level.outlineidspending[var_3] = undefined;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

outlinerefreshpending(var_0, var_1) {
  var_2 = var_0.outlines[var_1];

  foreach(var_6, var_4 in var_2.playersvisibletopending) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(canoutlineforplayer(var_4)) {
      var_5 = outlinegethighestinfoforplayer(var_0, var_4);

      if(isDefined(var_5)) {
        var_0 hudoutlineenableforclient(var_4, var_5.colorindex, var_5.var_525C, var_5.var_6C10);
      } else {
        var_0 hudoutlinedisableforclient(var_4);
      }

      var_2.playersvisibletopending[var_6] = undefined;
    }
  }

  var_2.playersvisibletopending = scripts\engine\utility::array_removeundefined(var_2.playersvisibletopending);

  if(var_2.playersvisibletopending.size == 0) {
    if(var_2.isdisabled) {
      var_0.outlines[var_1] = undefined;
    }

    if(var_0.outlines.size == 0) {
      outlineremovefromgloballist(var_0);
    }

    return 1;
  }

  return 0;
}

canoutlineforplayer(var_0) {
  return var_0.sessionstate != "spectator";
}

_hudoutlineenableforclient(var_0, var_1, var_2, var_3) {
  if(var_1 == 7) {
    self hudoutlinedisableforclient(var_0);
  } else {
    self hudoutlineenableforclient(var_0, var_1, var_2, var_3);
  }
}

_hudoutlineenableforclients(var_0, var_1, var_2, var_3) {
  if(var_1 == 7) {
    self hudoutlinedisableforclients(var_0);
  } else {
    self hudoutlineenableforclients(var_0, var_1, var_2, var_3);
  }
}