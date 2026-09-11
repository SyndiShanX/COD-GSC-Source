/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outline_utility.gsc
***********************************************/

function init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  thread outlinecatchplayerdisconnect();
  thread outlineonplayerjoinedteam();
  thread outlineidswatchpending();
}

function outlineenableinternal(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0.outlines)) {
    var0.outlines = [];
  }

  var6 = spawnStruct();
  var6.isdisabled = 0;
  var6.priority = var3;
  var6.playersvisibleto = var1;
  var6.playersvisibletopending = [];
  var6.hudoutlineassetname = var2;
  var6.type = var4;

  if(var4 == "TEAM") {
    var6.team = var5;
  }

  var7 = outlinegenerateuniqueid();
  var0.outlines[var7] = var6;
  outlineaddtogloballist(var0);
  var8 = [];

  foreach(var10 in var6.playersvisibleto) {
    if(!canoutlineforplayer(var10)) {
      var6.playersvisibletopending[var6.playersvisibletopending.size] = var10;
      level.outlineidspending[var7] = var0;
      continue;
    }

    var11 = outlinegethighestinfoforplayer(var0, var10);

    if(!isDefined(var11) || var11 == var6 || var11.priority == var6.priority) {
      var8 = var10;
    }
  }

  if(var8.size > 0) {
    _hudoutlineenableforclients(var0, var8, var6.hudoutlineassetname);
  }

  return var7;
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

function outlinecatchplayerdisconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread outlineonplayerdisconnect(level);
  }
}

function outlineonplayerdisconnect(var0) {
  level endon("game_ended");
  var0 waittill("disconnect");
  outlineremoveplayerfromvisibletoarrays(var0);
  outlinedisableinternalall(var0);
}

function outlineonplayerjoinedteam() {
  for(;;) {
    level waittill("joined_team", var0);

    if(!isDefined(var0.team) || var0.team == "spectator") {
      continue;
    }

    thread outlineonplayerjoinedteam_onfirstspawn(var0);
  }
}

function outlineonplayerjoinedteam_onfirstspawn(var0) {
  var0 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var0 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(var0);
  outlinedisableinternalall(var0);
  outlineaddplayertoexistingteamoutlines(var0);
}

function outlineremoveplayerfromvisibletoarrays(var0) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(var2 in level.outlineents) {
    var3 = 0;

    foreach(var5 in var2.outlines) {
      var5.playersvisibleto = scripts\engine\utility::array_removeundefined(var5.playersvisibleto);

      if(isDefined(var0) && scripts\engine\utility::array_contains(var5.playersvisibleto, var0)) {
        var5.playersvisibleto = scripts\engine\utility::array_remove(var5.playersvisibleto, var0);
        var3 = 1;
      }
    }

    if(var3 && isDefined(var2) && isDefined(var0)) {
      var2 hudoutlinedisableforclient(var0);
    }
  }
}

function outlineaddplayertoexistingteamoutlines(var0) {
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

      if(isDefined(var5)) {
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
  self hudoutlineenableforclient(var0, var1);
}

function _hudoutlineenableforclients(var0, var1) {
  self hudoutlineenableforclients(var0, var1);
}

function outlineenableforall(var0, var1, var2) {
  var3 = level.players;
  var4 = outlineprioritygroupmap(var2);
  return outlineenableinternal(var0, var3, var1, var4, "ALL");
}

function outlineenableforteam(var0, var1, var2, var3) {
  var4 = getteamdata(var1, "players");
  var5 = outlineprioritygroupmap(var3);
  return outlineenableinternal(var0, var4, var2, var5, "TEAM", var1);
}

function outlineenableforplayer(var0, var1, var2, var3) {
  var4 = outlineprioritygroupmap(var3);

  if(isagent(var1)) {
    return outlinegenerateuniqueid();
  }

  return outlineenableinternal(var0, [var1], var2, var4, "ENTITY");
}

function outlinedisable(var0, var1) {
  outlinedisableinternal(var0, var1);
}

function outlinerefresh(var0) {
  outlinerefreshinternal(var0);
}

function initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

function addoutlineoccluder(var0, var1) {
  var2 = spawnStruct();
  var2.position = var0;
  var2.radius = var1;
  var3 = level.outlineoccludersid;
  level.outlineoccluders[var3] = var2;
  level.outlineoccludersid++;
  return var3;
}

function removeoutlineoccluder(var0) {
  level.outlineoccluders[var0] = undefined;
}

function outlineoccluded(var0, var1) {
  foreach(var3 in level.outlineoccluders) {
    if(!isDefined(var3) || !isDefined(var3.position) || !isDefined(var3.radius)) {
      continue;
    }

    if(scripts\engine\math::segmentvssphere(var0, var1, var3.position, var3.radius)) {
      return true;
    }
  }

  return false;
}

function _hudoutlineviewmodeldisable() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  self hudoutlineviewmodeldisable();
}

function _hudoutlineviewmodelenable(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!var1 && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(var1 && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(var0);
    return;
  }

  self hudoutlineviewmodelenable(var0);
}

function hudoutlineviewmodelenableonnextspawn(var0) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isDefined(self)) {
    return;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  self hudoutlineviewmodelenable(var0);
}

function getteamdata(var0, var1) {
  return level.teamdata[var0][var1];
}