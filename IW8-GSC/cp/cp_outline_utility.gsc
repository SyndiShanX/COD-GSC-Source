/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_outline_utility.gsc
***********************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  level thread outlinecatchplayerdisconnect();
  level thread outlineonplayerjoinedteam();
  level thread outlineidswatchpending();
}

outlineenableinternal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0.outlines))
    var_0.outlines = [];

  var_6 = spawnStruct();
  var_6.isdisabled = 0;
  var_6.priority = var_3;
  var_6.playersvisibleto = var_1;
  var_6.playersvisibletopending = [];
  var_6.hudoutlineassetname = var_2;
  var_6.type = var_4;

  if(var_4 == "_encstr_8AEF05452A82D4")
    var_6.team = var_5;

  var_7 = outlinegenerateuniqueid();
  var_0.outlines[var_7] = var_6;
  outlineaddtogloballist(var_0);
  var_8 = [];

  foreach(var_10 in var_6.playersvisibleto) {
    if(!canoutlineforplayer(var_10)) {
      var_6.playersvisibletopending[var_6.playersvisibletopending.size] = var_10;
      level.outlineidspending[var_7] = var_0;
      continue;
    }

    var_11 = outlinegethighestinfoforplayer(var_0, var_10);

    if(!isDefined(var_11) || var_11 == var_6 || var_11.priority == var_6.priority)
      var_8[var_8.size] = var_10;
  }

  if(var_8.size > 0)
    var_0 _hudoutlineenableforclients(var_8, var_6.hudoutlineassetname);

  return var_7;
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

outlinecatchplayerdisconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    level thread outlineonplayerdisconnect(var_0);
  }
}

outlineonplayerdisconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
}

outlineonplayerjoinedteam() {
  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_0);

    if(!isDefined(var_0.team) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    thread outlineonplayerjoinedteam_onfirstspawn(var_0);
  }
}

outlineonplayerjoinedteam_onfirstspawn(var_0) {
  var_0 notify("_encstr_B450270D7B70BC5AF00B870B09A982F15023CC9510587D42C513471F2FC0BA06684B3ADBCF83014B20");
  var_0 endon("_encstr_B450270D7B70BC5AF00B870B09A982F15023CC9510587D42C513471F2FC0BA06684B3ADBCF83014B20");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  outlineremoveplayerfromvisibletoarrays(var_0);
  outlinedisableinternalall(var_0);
  outlineaddplayertoexistingteamoutlines(var_0);
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

    if(var_3 && isDefined(var_2) && isDefined(var_0))
      var_2 hudoutlinedisableforclient(var_0);
  }
}

outlineaddplayertoexistingteamoutlines(var_0) {
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

      if(isDefined(var_5))
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
  self hudoutlineenableforclient(var_0, var_1);
}

_hudoutlineenableforclients(var_0, var_1) {
  self hudoutlineenableforclients(var_0, var_1);
}

outlineenableforall(var_0, var_1, var_2) {
  var_3 = level.players;
  var_4 = outlineprioritygroupmap(var_2);
  return outlineenableinternal(var_0, var_3, var_1, var_4, "_encstr_AF190427B939");
}

outlineenableforteam(var_0, var_1, var_2, var_3) {
  var_4 = getteamdata(var_1, "_encstr_9775086022BE1B413B8B");
  var_5 = outlineprioritygroupmap(var_3);
  return outlineenableinternal(var_0, var_4, var_2, var_5, "_encstr_8AEF05452A82D4", var_1);
}

outlineenableforplayer(var_0, var_1, var_2, var_3) {
  var_4 = outlineprioritygroupmap(var_3);

  if(isagent(var_1))
    return outlinegenerateuniqueid();

  return outlineenableinternal(var_0, [var_1], var_2, var_4, "_encstr_850E073B8BF1131999");
}

outlinedisable(var_0, var_1) {
  outlinedisableinternal(var_0, var_1);
}

outlinerefresh(var_0) {
  outlinerefreshinternal(var_0);
}

initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

addoutlineoccluder(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.position = var_0;
  var_2.radius = var_1;
  var_3 = level.outlineoccludersid;
  level.outlineoccluders[var_3] = var_2;
  level.outlineoccludersid++;
  return var_3;
}

removeoutlineoccluder(var_0) {
  level.outlineoccluders[var_0] = undefined;
}

outlineoccluded(var_0, var_1) {
  foreach(var_3 in level.outlineoccluders) {
    if(!isDefined(var_3) || !isDefined(var_3.position) || !isDefined(var_3.radius)) {
      continue;
    }
    if(scripts\engine\math::segmentvssphere(var_0, var_1, var_3.position, var_3.radius))
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

_hudoutlineviewmodelenable(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(var_0);
    return;
  }

  self hudoutlineviewmodelenable(var_0);
}

hudoutlineviewmodelenableonnextspawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BA350853C128FB939DB9");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self hudoutlineviewmodelenable(var_0);
}

getteamdata(var_0, var_1) {
  return level.teamdata[var_0][var_1];
}