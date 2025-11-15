/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2777.gsc
***************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  level thread func_C788();
  level thread func_C7A4();
  level thread outlineidswatchpending();
}

outlineenableinternal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_0.outlines))
    var_0.outlines = [];

  var_08 = spawnStruct();
  var_8.isdisabled = 0;
  var_8.priority = var_05;
  var_8.colorindex = var_01;
  var_8.playersvisibleto = var_02;
  var_8.playersvisibletopending = [];
  var_8.func_525C = var_03;
  var_8.func_6C10 = var_04;
  var_8.type = var_06;

  if(var_06 == "TEAM")
    var_8.team = var_07;

  var_09 = outlinegenerateuniqueid();
  var_0.outlines[var_09] = var_08;
  outlineaddtogloballist(var_00);
  var_10 = [];

  foreach(var_12 in var_8.playersvisibleto) {
    if(!canoutlineforplayer(var_12)) {
      var_8.playersvisibletopending[var_8.playersvisibletopending.size] = var_12;
      level.outlineidspending[var_09] = var_00;
      continue;
    }

    var_13 = outlinegethighestinfoforplayer(var_00, var_12);

    if(!isDefined(var_13) || var_13 == var_08 || var_13.priority == var_8.priority)
      var_10[var_10.size] = var_12;
  }

  if(var_10.size > 0)
    var_00 _hudoutlineenableforclients(var_10, var_8.colorindex, var_8.func_525C, var_8.func_6C10);

  return var_09;
}

outlinedisableinternal(var_00, var_01) {
  if(!isDefined(var_01)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(var_1.outlines)) {
    outlineremovefromgloballist(var_01);
    return;
  }

  var_02 = var_1.outlines[var_00];

  if(!isDefined(var_02) || var_2.isdisabled) {
    return;
  }
  var_2.isdisabled = 1;

  foreach(var_04 in var_2.playersvisibleto) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(!canoutlineforplayer(var_04)) {
      var_2.playersvisibletopending[var_2.playersvisibletopending.size] = var_04;
      level.outlineidspending[var_00] = var_01;
      continue;
    }

    var_05 = outlinegethighestinfoforplayer(var_01, var_04);

    if(isDefined(var_05)) {
      if(var_5.priority <= var_2.priority)
        var_01 _hudoutlineenableforclient(var_04, var_5.colorindex, var_5.func_525C, var_5.func_6C10);

      continue;
    }

    var_01 hudoutlinedisableforclient(var_04);
  }

  if(var_2.playersvisibletopending.size == 0) {
    var_1.outlines[var_00] = undefined;

    if(var_1.outlines.size == 0)
      outlineremovefromgloballist(var_01);
  }
}

func_C7AB(var_00) {
  if(!isDefined(var_0.outlines) || var_0.outlines.size == 0) {
    return;
  }
  foreach(var_07, var_02 in var_0.outlines) {
    if(!isDefined(var_02) || var_2.isdisabled) {
      continue;
    }
    foreach(var_04 in var_2.playersvisibleto) {
      if(!isDefined(var_04)) {
        continue;
      }
      var_05 = outlinegethighestinfoforplayer(var_00, var_04);

      if(isDefined(var_05))
        var_00 _hudoutlineenableforclient(var_04, var_5.colorindex, var_5.func_525C, var_5.func_6C10);
    }
  }
}

func_C788() {
  for(;;) {
    level waittill("connected", var_00);
    level thread func_C7A3(var_00);
  }
}

func_C7A3(var_00) {
  level endon("game_ended");
  var_00 waittill("disconnect");
  outlineremoveplayerfromvisibletoarrays(var_00);
  outlinedisableinternalall(var_00);
}

func_C7A4() {
  for(;;) {
    level waittill("joined_team", var_00);

    if(!isDefined(var_0.team) || var_0.team == "spectator") {
      continue;
    }
    thread outlineonplayerjoinedteam_onfirstspawn(var_00);
  }
}

outlineonplayerjoinedteam_onfirstspawn(var_00) {
  var_00 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_00 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_00 endon("disconnect");
  var_00 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(var_00);
  outlinedisableinternalall(var_00);
  outlineaddplayertoexistingallandteamoutlines(var_00);
}

outlineremoveplayerfromvisibletoarrays(var_00) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(var_02 in level.outlineents) {
    var_03 = 0;

    foreach(var_05 in var_2.outlines) {
      var_5.playersvisibleto = scripts\engine\utility::array_removeundefined(var_5.playersvisibleto);

      if(isDefined(var_00) && scripts\engine\utility::array_contains(var_5.playersvisibleto, var_00)) {
        var_5.playersvisibleto = scripts\engine\utility::array_remove(var_5.playersvisibleto, var_00);
        var_03 = 1;
      }
    }

    if(var_03 && isDefined(var_02) && isDefined(var_00))
      var_02 hudoutlinedisableforclient(var_00);
  }
}

outlineaddplayertoexistingallandteamoutlines(var_00) {
  foreach(var_02 in level.outlineents) {
    if(!isDefined(var_02)) {
      continue;
    }
    var_03 = undefined;

    foreach(var_05 in var_2.outlines) {
      if(var_5.type == "ALL" || var_5.type == "TEAM" && var_5.team == var_0.team) {
        if(!scripts\engine\utility::array_contains(var_5.playersvisibleto, var_00))
          var_5.playersvisibleto[var_5.playersvisibleto.size] = var_00;
        else {}

        if(!isDefined(var_03) || var_5.priority > var_3.priority)
          var_03 = var_05;
      }
    }

    if(isDefined(var_03))
      var_02 _hudoutlineenableforclient(var_00, var_3.colorindex, var_3.func_525C, var_3.func_6C10);
  }
}

outlinedisableinternalall(var_00) {
  if(!isDefined(var_00) || !isDefined(var_0.outlines) || var_0.outlines.size == 0) {
    return;
  }
  foreach(var_03, var_02 in var_0.outlines)
  outlinedisableinternal(var_03, var_00);
}

outlineaddtogloballist(var_00) {
  if(!scripts\engine\utility::array_contains(level.outlineents, var_00))
    level.outlineents[level.outlineents.size] = var_00;
}

outlineremovefromgloballist(var_00) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, var_00);
}

outlinegethighestpriorityid(var_00) {
  var_01 = -1;

  if(!isDefined(var_0.outlines) || var_0.size == 0)
    return var_01;

  var_02 = undefined;

  foreach(var_05, var_04 in var_0.outlines) {
    if(!isDefined(var_04) || var_4.isdisabled) {
      continue;
    }
    if(!isDefined(var_02) || var_4.priority > var_2.priority) {
      var_02 = var_04;
      var_01 = var_05;
    }
  }

  return var_01;
}

outlinegethighestinfoforplayer(var_00, var_01) {
  var_02 = undefined;

  if(!isDefined(var_0.outlines) || var_0.size == 0)
    return var_02;

  foreach(var_05, var_04 in var_0.outlines) {
    if(!isDefined(var_04) || var_4.isdisabled) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_4.playersvisibleto, var_01) && (!isDefined(var_02) || var_4.priority > var_2.priority))
      var_02 = var_04;
  }

  return var_02;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

func_C7A9(var_00) {
  var_00 = tolower(var_00);
  var_01 = undefined;

  switch (var_00) {
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

func_C78A(var_00) {
  var_00 = tolower(var_00);
  var_01 = undefined;

  switch (var_00) {
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
      if(!isDefined(var_1.outlines)) {
        continue;
      }
      var_02 = var_1.outlines[var_03];

      if(!isDefined(var_02)) {
        continue;
      }
      if(var_2.playersvisibletopending.size > 0) {
        if(outlinerefreshpending(var_01, var_03))
          level.outlineidspending[var_03] = undefined;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

outlinerefreshpending(var_00, var_01) {
  var_02 = var_0.outlines[var_01];

  foreach(var_06, var_04 in var_2.playersvisibletopending) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(canoutlineforplayer(var_04)) {
      var_05 = outlinegethighestinfoforplayer(var_00, var_04);

      if(isDefined(var_05))
        var_00 hudoutlineenableforclient(var_04, var_5.colorindex, var_5.func_525C, var_5.func_6C10);
      else
        var_00 hudoutlinedisableforclient(var_04);

      var_2.playersvisibletopending[var_06] = undefined;
    }
  }

  var_2.playersvisibletopending = scripts\engine\utility::array_removeundefined(var_2.playersvisibletopending);

  if(var_2.playersvisibletopending.size == 0) {
    if(var_2.isdisabled)
      var_0.outlines[var_01] = undefined;

    if(var_0.outlines.size == 0)
      outlineremovefromgloballist(var_00);

    return 1;
  }

  return 0;
}

canoutlineforplayer(var_00) {
  return var_0.sessionstate != "spectator";
}

_hudoutlineenableforclient(var_00, var_01, var_02, var_03) {
  if(var_01 == 7)
    self hudoutlinedisableforclient(var_00);
  else
    self hudoutlineenableforclient(var_00, var_01, var_02, var_03);
}

_hudoutlineenableforclients(var_00, var_01, var_02, var_03) {
  if(var_01 == 7)
    self hudoutlinedisableforclients(var_00);
  else
    self hudoutlineenableforclients(var_00, var_01, var_02, var_03);
}