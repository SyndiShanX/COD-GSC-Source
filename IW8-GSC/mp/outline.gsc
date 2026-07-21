/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\outline.gsc
***********************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::outlineonplayerdisconnect);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::outlineonplayerjoinedteam);
  scripts\mp\utility\join_squad_aggregator::registeronplayerjoinsquadcallback(::outlineonplayerjoinedsquad);
  level thread outlineidswatchpending();
}

outlineenableinternal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0.outlines))
    var_0.outlines = [];

  var_7 = spawnStruct();
  var_7.isdisabled = 0;
  var_7.priority = var_3;
  var_7.playersvisibleto = var_1;
  var_7.playersvisibletopending = [];
  var_7.hudoutlineassetname = var_2;
  var_7.type = var_4;
  var_7.team = var_5;
  var_7.squadindex = var_6;
  var_8 = outlinegenerateuniqueid();
  var_0.outlines[var_8] = var_7;
  outlineaddtogloballist(var_0);
  var_9 = [];

  foreach(var_11 in var_7.playersvisibleto) {
    if(!canoutlineforplayer(var_11)) {
      var_7.playersvisibletopending[var_7.playersvisibletopending.size] = var_11;
      level.outlineidspending[var_8] = var_0;
      continue;
    }

    var_12 = outlinegethighestinfoforplayer(var_0, var_11);

    if(!isDefined(var_12) || var_12 == var_7 || var_12.priority == var_7.priority)
      var_9[var_9.size] = var_11;
  }

  if(var_9.size > 0)
    var_0 _hudoutlineenableforclients(var_9, var_7.hudoutlineassetname);

  return var_8;
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
      if(var_5.priority <= var_2.priority)
        var_1 _hudoutlineenableforclient(var_4, var_5.hudoutlineassetname);

      continue;
    }

    var_1 hudoutlinedisableforclient(var_4);
  }

  if(var_2.playersvisibletopending.size == 0) {
    var_1.outlines[var_0] = undefined;

    if(var_1.outlines.size == 0)
      outlineremovefromgloballist(var_1);
  }
}

outlinerefreshinternal(var_0) {
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

      if(isDefined(var_5))
        var_0 _hudoutlineenableforclient(var_4, var_5.hudoutlineassetname);
    }
  }
}

outlineonplayerdisconnect(var_0) {
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
}

outlineonplayerjoinedteam(var_0) {
  if(!isDefined(var_0.team) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0.team == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  thread outlineonplayerjoinedteam_onfirstspawn(var_0);
}

outlineonplayerjoinedteam_onfirstspawn(var_0) {
  var_0 notify("_encstr_B450270D7B70BC5AF00B870B09A982F15023CC9510587D42C513471F2FC0BA06684B3ADBCF83014B20");
  var_0 endon("_encstr_B450270D7B70BC5AF00B870B09A982F15023CC9510587D42C513471F2FC0BA06684B3ADBCF83014B20");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
  outlineaddplayertoexistingallandteamoutlines(var_0);
}

outlineonplayerjoinedsquad(var_0) {
  thread outlineonplayerjoinedsquad_onfirstspawn(var_0);
}

outlineonplayerjoinedsquad_onfirstspawn(var_0) {
  var_0 notify("_encstr_8273284750736C92D5BDC5850FE92A31F9F05B3FD868DD8A474F537E0DE782FE658023C78827708257E8");
  var_0 endon("_encstr_8273284750736C92D5BDC5850FE92A31F9F05B3FD868DD8A474F537E0DE782FE658023C78827708257E8");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  outlineremoveplayerfromvisibletoarrays(var_0, 1);
  outlineaddplayertoexistingsquadoutlines(var_0);
}

outlineremoveplayerfromvisibletoarrays(var_0, var_1) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(var_3 in level.outlineents) {
    var_4 = 0;

    foreach(var_6 in var_3.outlines) {
      if(istrue(var_1)) {
        if(var_6.type != "_encstr_8C950636CAC91B1D")
          continue;
      }

      var_6.playersvisibleto = scripts\engine\utility::array_removeundefined(var_6.playersvisibleto);

      if(isDefined(var_0) && scripts\engine\utility::array_contains(var_6.playersvisibleto, var_0)) {
        var_6.playersvisibleto = scripts\engine\utility::array_remove(var_6.playersvisibleto, var_0);
        var_4 = 1;
      }
    }

    if(var_4 && isDefined(var_3) && isDefined(var_0))
      var_3 hudoutlinedisableforclient(var_0);
  }
}

outlineaddplayertoexistingallandteamoutlines(var_0) {
  foreach(var_2 in level.outlineents) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;

    foreach(var_5 in var_2.outlines) {
      if(var_5.type == "_encstr_AF190427B939" || var_5.type == "_encstr_8AEF05452A82D4" && var_5.team == var_0.team) {
        if(!scripts\engine\utility::array_contains(var_5.playersvisibleto, var_0))
          var_5.playersvisibleto[var_5.playersvisibleto.size] = var_0;
        else {}

        if(!isDefined(var_3) || var_5.priority > var_3.priority)
          var_3 = var_5;
      }
    }

    if(isDefined(var_3))
      var_2 _hudoutlineenableforclient(var_0, var_3.hudoutlineassetname);
  }
}

outlineaddplayertoexistingsquadoutlines(var_0) {
  if(!isDefined(var_0.squadindex)) {}

  foreach(var_2 in level.outlineents) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;

    foreach(var_5 in var_2.outlines) {
      if(var_5.type == "_encstr_8C950636CAC91B1D" && var_5.team == var_0.team && isDefined(var_5.squadindex) && var_5.squadindex == var_0.squadindex) {
        if(!scripts\engine\utility::array_contains(var_5.playersvisibleto, var_0))
          var_5.playersvisibleto[var_5.playersvisibleto.size] = var_0;
        else {}

        if(!isDefined(var_3) || var_5.priority > var_3.priority)
          var_3 = var_5;
      }
    }

    if(isDefined(var_3))
      var_2 _hudoutlineenableforclient(var_0, var_3.hudoutlineassetname);
  }
}

outlinedisableinternalall(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.outlines) || var_0.outlines.size == 0) {
    return;
  }
  foreach(var_3, var_2 in var_0.outlines)
  outlinedisableinternal(var_3, var_0);
}

outlineaddtogloballist(var_0) {
  if(!scripts\engine\utility::array_contains(level.outlineents, var_0))
    level.outlineents[level.outlineents.size] = var_0;
}

outlineremovefromgloballist(var_0) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, var_0);
}

outlinegethighestpriorityid(var_0) {
  var_1 = -1;

  if(!isDefined(var_0.outlines) || var_0.size == 0)
    return var_1;

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

  if(!isDefined(var_0.outlines) || var_0.size == 0)
    return var_2;

  foreach(var_5, var_4 in var_0.outlines) {
    if(!isDefined(var_4) || var_4.isdisabled) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_4.playersvisibleto, var_1) && (!isDefined(var_2) || var_4.priority > var_2.priority))
      var_2 = var_4;
  }

  return var_2;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

outlineprioritygroupmap(var_0) {
  var_0 = tolower(var_0);
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_A7440781BA73D7D8C1":
      var_1 = 0;
      break;
    case "_encstr_AC760D7A6AE6A9501F43EF73238A0C":
      var_1 = 1;
      break;
    case "_encstr_BE8F0A272F9B2BE97268AE8B":
      var_1 = 2;
      break;
    case "_encstr_960D052F10EBF0":
      var_1 = 3;
      break;
    case "_encstr_849E0E70308587819F95CBA0EE30483B":
      var_1 = 4;
      break;
    case "_encstr_85CE0B9770B02C73A1760F06D2":
      var_1 = 5;
      break;
    case "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB":
      var_1 = 6;
      break;
    case "_encstr_A5510A30AA778D28B3C97D51":
      var_1 = 7;
      break;
    case "_encstr_AC190479FF92":
      var_1 = 8;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

outlineiddowatch() {
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
      if(outlinerefreshpending(var_1, var_3))
        level.outlineidspending[var_3] = undefined;
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

outlinerefreshpending(var_0, var_1) {
  var_2 = var_0.outlines[var_1];

  foreach(var_6, var_4 in var_2.playersvisibletopending) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(canoutlineforplayer(var_4)) {
      var_5 = outlinegethighestinfoforplayer(var_0, var_4);

      if(isDefined(var_5) && var_5.hudoutlineassetname != "_encstr_A2BE0AB4DC3BB46E5A981BAC")
        var_0 hudoutlineenableforclient(var_4, var_5.hudoutlineassetname);
      else
        var_0 hudoutlinedisableforclient(var_4);

      var_2.playersvisibletopending[var_6] = undefined;
    }
  }

  var_2.playersvisibletopending = scripts\engine\utility::array_removeundefined(var_2.playersvisibletopending);

  if(var_2.playersvisibletopending.size == 0) {
    if(var_2.isdisabled)
      var_0.outlines[var_1] = undefined;

    if(var_0.outlines.size == 0)
      outlineremovefromgloballist(var_0);

    return 1;
  }

  return 0;
}

canoutlineforplayer(var_0) {
  return var_0.sessionstate != "_encstr_AF8C0A1B6A1D6045925B4F7D";
}

_hudoutlineenableforclient(var_0, var_1) {
  if(var_1 == "_encstr_A2BE0AB4DC3BB46E5A981BAC")
    self hudoutlinedisableforclient(var_0);
  else
    self hudoutlineenableforclient(var_0, var_1);
}

_hudoutlineenableforclients(var_0, var_1) {
  if(var_1 == "_encstr_A2BE0AB4DC3BB46E5A981BAC")
    self hudoutlinedisableforclients(var_0);
  else
    self hudoutlineenableforclients(var_0, var_1);
}