/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\outline.gsc
***********************************************/

function init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&outlineonplayerdisconnect);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&outlineonplayerjoinedteam);
  scripts\mp\utility\join_squad_aggregator::registeronplayerjoinsquadcallback(&outlineonplayerjoinedsquad);
  thread outlineidswatchpending();
}

function outlineenableinternal(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var0.outlines)) {
    var0.outlines = [];
  }

  var7 = spawnStruct();
  var7.isdisabled = 0;
  var7.priority = var3;
  var7.playersvisibleto = var1;
  var7.playersvisibletopending = [];
  var7.hudoutlineassetname = var2;
  var7.type = var4;
  var7.team = var5;
  var7.squadindex = var6;
  var8 = outlinegenerateuniqueid();
  var0.outlines[var8] = var7;
  outlineaddtogloballist(var0);
  var9 = [];

  foreach(var11 in var7.playersvisibleto) {
    if(!canoutlineforplayer(var11)) {
      var7.playersvisibletopending[var7.playersvisibletopending.size] = var11;
      level.outlineidspending[var8] = var0;
      continue;
    }

    var12 = outlinegethighestinfoforplayer(var0, var11);

    if(!isDefined(var12) || var12 == var7 || var12.priority == var7.priority) {
      var9 = var11;
    }
  }

  if(var9.size > 0) {
    _hudoutlineenableforclients(var0, var9, var7.hudoutlineassetname);
  }

  return var8;
}

function outlinedisableinternal(var0, var1) {
  if(!isDefined(var1)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(var1.outlines)) {
    outlineremovefromgloballist(var1);
    return;
  }

  var2 = var1.outlines[var0];

  if(!isDefined(var2) || var2.isdisabled) {
    return;
  }

  var2.isdisabled = 1;

  foreach(var4 in var2.playersvisibleto) {
    if(!isDefined(var4)) {
      continue;
    }

    if(!canoutlineforplayer(var4)) {
      var2.playersvisibletopending[var2.playersvisibletopending.size] = var4;
      level.outlineidspending[var0] = var1;
      continue;
    }

    var5 = outlinegethighestinfoforplayer(var1, var4);

    if(isDefined(var5)) {
      if(var5.priority <= var2.priority) {
        _hudoutlineenableforclient(var1, var4, var5.hudoutlineassetname);
      }

      continue;
    }

    var1 hudoutlinedisableforclient(var4);
  }

  if(var2.playersvisibletopending.size == 0) {
    var1.outlines[var0] = undefined;

    if(var1.outlines.size == 0) {
      outlineremovefromgloballist(var1);
      return;
    }

    return;
  }
}

function outlinerefreshinternal(var0) {
  if(!isDefined(var0.outlines) || var0.outlines.size == 0) {
    return;
  }

  foreach(var2 in var0.outlines) {
    if(!isDefined(var2) || var2.isdisabled) {
      continue;
    }

    foreach(var4 in var2.playersvisibleto) {
      if(!isDefined(var4)) {
        continue;
      }

      var5 = outlinegethighestinfoforplayer(var0, var4);

      if(isDefined(var5)) {
        _hudoutlineenableforclient(var0, var4, var5.hudoutlineassetname);
      }
    }
  }
}

function outlineonplayerdisconnect(var0) {
  outlineremoveplayerfromvisibletoarrays(var0);
  outlinedisableinternalall(var0);
}

function outlineonplayerjoinedteam(var0) {
  if(!isDefined(var0.team) || var0.team == "spectator" || var0.team == "follower") {
    return;
  }

  thread outlineonplayerjoinedteam_onfirstspawn(var0);
}

function outlineonplayerjoinedteam_onfirstspawn(var0) {
  var0 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var0 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(var0);
  outlinedisableinternalall(var0);
  outlineaddplayertoexistingallandteamoutlines(var0);
}

function outlineonplayerjoinedsquad(var0) {
  thread outlineonplayerjoinedsquad_onfirstspawn(var0);
}

function outlineonplayerjoinedsquad_onfirstspawn(var0) {
  var0 notify("outlineOnPlayerJoinedSquad_onFirstSpawn");
  var0 endon("outlineOnPlayerJoinedSquad_onFirstSpawn");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(var0, 1);
  outlineaddplayertoexistingsquadoutlines(var0);
}

function outlineremoveplayerfromvisibletoarrays(var0, var1) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(var3 in level.outlineents) {
    var4 = 0;

    foreach(var6 in var3.outlines) {
      if(istrue(var1)) {
        if(var6.type != "SQUAD") {
          continue;
        }
      }

      var6.playersvisibleto = scripts\engine\utility::array_removeundefined(var6.playersvisibleto);

      if(isDefined(var0) && scripts\engine\utility::array_contains(var6.playersvisibleto, var0)) {
        var6.playersvisibleto = scripts\engine\utility::array_remove(var6.playersvisibleto, var0);
        var4 = 1;
      }
    }

    if(var4 && isDefined(var3) && isDefined(var0)) {
      var3 hudoutlinedisableforclient(var0);
    }
  }
}

function outlineaddplayertoexistingallandteamoutlines(var0) {
  foreach(var2 in level.outlineents) {
    if(!isDefined(var2)) {
      continue;
    }

    var3 = undefined;

    foreach(var5 in var2.outlines) {
      if(var5.type == "ALL" || var5.type == "TEAM" && var5.team == var0.team) {
        if(!scripts\engine\utility::array_contains(var5.playersvisibleto, var0)) {
          var5.playersvisibleto[var5.playersvisibleto.size] = var0;
        }

        if(!isDefined(var3) || var5.priority > var3.priority) {
          var3 = var5;
        }
      }
    }

    if(isDefined(var3)) {
      _hudoutlineenableforclient(var2, var0, var3.hudoutlineassetname);
    }
  }
}

function outlineaddplayertoexistingsquadoutlines(var0) {
  if(isDefined(var0.squadindex)) {}

  foreach(var2 in level.outlineents) {
    if(!isDefined(var2)) {
      continue;
    }

    var3 = undefined;

    foreach(var5 in var2.outlines) {
      if(var5.type == "SQUAD" && var5.team == var0.team && isDefined(var5.squadindex) && var5.squadindex == var0.squadindex) {
        if(!scripts\engine\utility::array_contains(var5.playersvisibleto, var0)) {
          var5.playersvisibleto[var5.playersvisibleto.size] = var0;
        }

        if(!isDefined(var3) || var5.priority > var3.priority) {
          var3 = var5;
        }
      }
    }

    if(isDefined(var3)) {
      _hudoutlineenableforclient(var2, var0, var3.hudoutlineassetname);
    }
  }
}

function outlinedisableinternalall(var0) {
  if(!isDefined(var0) || !isDefined(var0.outlines) || var0.outlines.size == 0) {
    return;
  }

  foreach(var2 in var0.outlines) {
    outlinedisableinternal(var3, var0);
  }
}

function outlineaddtogloballist(var0) {
  if(!scripts\engine\utility::array_contains(level.outlineents, var0)) {
    level.outlineents[level.outlineents.size] = var0;
    return;
  }
}

function outlineremovefromgloballist(var0) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, var0);
}

function outlinegethighestpriorityid(var0) {
  var1 = -1;

  if(!isDefined(var0.outlines) || var0.size == 0) {
    return var1;
  }

  var2 = undefined;

  foreach(var4 in var0.outlines) {
    if(!isDefined(var4) || var4.isdisabled) {
      continue;
    }

    if(!isDefined(var2) || var4.priority > var2.priority) {
      var2 = var4;
      var1 = var5;
    }
  }

  return var1;
}

function outlinegethighestinfoforplayer(var0, var1) {
  var2 = undefined;

  if(!isDefined(var0.outlines) || var0.size == 0) {
    return var2;
  }

  foreach(var4 in var0.outlines) {
    if(!isDefined(var4) || var4.isdisabled) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var4.playersvisibleto, var1) && (!isDefined(var2) || var4.priority > var2.priority)) {
      var2 = var4;
    }
  }

  return var2;
}

function outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

function outlineprioritygroupmap(var0) {
  var0 = tolower(var0);
  var1 = undefined;

  switch (var0) {
    case "lowest":
      var1 = 0;
      break;
    case "level_script":
      var1 = 1;
      break;
    case "equipment":
      var1 = 2;
      break;
    case "perk":
      var1 = 3;
      break;
    case "perk_superior":
      var1 = 4;
      break;
    case "killstreak":
      var1 = 5;
      break;
    case "killstreak_personal":
      var1 = 6;
      break;
    case "laststand":
      var1 = 7;
      break;
    case "top":
      var1 = 8;
      break;
    default:
      var1 = 0;
      break;
  }

  return var1;
}

function outlineiddowatch() {
  foreach(var3, var1 in level.outlineidspending) {
    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.outlines)) {
      continue;
    }

    var2 = var1.outlines[var3];

    if(!isDefined(var2)) {
      continue;
    }

    if(var2.playersvisibletopending.size > 0) {
      if(outlinerefreshpending(var1, var3)) {
        level.outlineidspending[var3] = undefined;
      }
    }
  }
}

function outlineidswatchpending() {
  for(;;) {
    waittillframeend();
    outlineiddowatch();
    waitframe();
  }
}

function outlinerefreshpending(var0, var1) {
  var2 = var0.outlines[var1];

  foreach(var4 in var2.playersvisibletopending) {
    if(!isDefined(var4)) {
      continue;
    }

    if(canoutlineforplayer(var4)) {
      var5 = outlinegethighestinfoforplayer(var0, var4);

      if(isDefined(var5) && var5.hudoutlineassetname != "invisible") {
        var0 hudoutlineenableforclient(var4, var5.hudoutlineassetname);
      } else {
        var0 hudoutlinedisableforclient(var4);
      }

      var2.playersvisibletopending[var6] = undefined;
    }
  }

  var2.playersvisibletopending = scripts\engine\utility::array_removeundefined(var2.playersvisibletopending);

  if(var2.playersvisibletopending.size == 0) {
    if(var2.isdisabled) {
      var0.outlines[var1] = undefined;
    }

    if(var0.outlines.size == 0) {
      outlineremovefromgloballist(var0);
    }

    return true;
  }

  return false;
}

function canoutlineforplayer(var0) {
  return var0.sessionstate != "spectator";
}

function _hudoutlineenableforclient(var0, var1) {
  if(var1 == "invisible") {
    self hudoutlinedisableforclient(var0);
    return;
  }

  self hudoutlineenableforclient(var0, var1);
}

function _hudoutlineenableforclients(var0, var1) {
  if(var1 == "invisible") {
    self hudoutlinedisableforclients(var0);
    return;
  }

  self hudoutlineenableforclients(var0, var1);
}