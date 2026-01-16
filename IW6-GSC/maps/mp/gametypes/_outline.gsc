/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_outline.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level.outlineIDs = 0;
  level.outlineEnts = [];

  level thread outlineCatchPlayerDisconnect();
  level thread outlineOnPlayerJoinedTeam();
}

outlineEnableInternal(entToOutline, colorIndex, playersVisibleTo, depthEnable, priorityNum, type, teamVisibleTo) {
  AssertEx(type != "TEAM" || isDefined(teamVisibleTo), "outlineEnableInternal() passed type \"TEAM\" without teamVisibleTo being defined.");

  if(!isDefined(entToOutline.outlines)) {
    entToOutline.outlines = [];
  }

  oInfo = spawnStruct();
  oInfo.priority = priorityNum;
  oInfo.colorIndex = colorIndex;
  oInfo.playersVisibleTo = playersVisibleTo;
  oInfo.depthEnable = depthEnable;
  oInfo.type = type;

  if(type == "TEAM") {
    oInfo.team = teamVisibleTo;
  }

  ID = outlineGenerateUniqueID();
  entToOutline.outlines[ID] = oInfo;

  outlineAddToGlobalList(entToOutline);

  playersToSeeOutline = [];

  foreach(player in oInfo.playersVisibleTo) {
    oInfoHighest = outlineGetHighestInfoForPlayer(entToOutline, player);

    if(!isDefined(oInfoHighest) || oInfoHighest == oInfo || oInfoHighest.priority == oInfo.priority) {
      playersToSeeOutline[playersToSeeOutline.size] = player;
    }
  }

  if(playersToSeeOutline.size > 0) {
    entToOutline HudOutlineEnableForClients(playersToSeeOutline, oInfo.colorIndex, oInfo.depthEnable);
  }

  return ID;
}

outlineDisableInternal(ID, entOutlined) {
  if(!isDefined(entOutlined.outlines)) {
    outlineRemoveFromGlobalList(entOutlined);
    return;
  } else if(!isDefined(entOutlined.outlines[ID])) {
    return;
  }

  oInfoToDisable = entOutlined.outlines[ID];

  outlinesUpdated = [];
  foreach(key, oInfo in entOutlined.outlines) {
    if(oInfo != oInfoToDisable) {
      outlinesUpdated[key] = oInfo;
    }
  }

  if(outlinesUpdated.size == 0) {
    outlineRemoveFromGlobalList(entOutlined);
  }

  if(isDefined(entOutlined)) {
    entOutlined.outlines = outlinesUpdated;

    foreach(player in oInfoToDisable.playersVisibleTo) {
      if(!isDefined(player)) {
        continue;
      }
      oInfoHighest = outlineGetHighestInfoForPlayer(entOutlined, player);

      if(isDefined(oInfoHighest)) {
        if(oInfoHighest.priority <= oInfoToDisable.priority) {
          entOutlined HudOutlineEnableForClient(player, oInfoHighest.colorIndex, oInfoHighest.depthEnable);
        }
      } else {
        entOutlined HudOutlineDisableForClient(player);
      }
    }
  }
}

outlineCatchPlayerDisconnect() {
  while(true) {
    level waittill("connected", player);

    level thread outlineOnPlayerDisconnect(player);
  }
}

outlineOnPlayerDisconnect(player) {
  level endon("game_ended");

  player waittill("disconnect");

  outlineRemovePlayerFromVisibleToArrays(player);
  outlineDisableInternalAll(player);
}

outlineOnPlayerJoinedTeam() {
  while(true) {
    level waittill("joined_team", player);

    if(!isDefined(player.team) || player.team == "spectator") {
      continue;
    }
    thread outlineOnPlayerJoinedTeam_onFirstspawn(player);
  }
}

outlineOnPlayerJoinedTeam_onFirstspawn(player) {
  player notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("disconnect");

  player waittill("spawned_player");

  outlineRemovePlayerFromVisibleToArrays(player);

  outlineDisableInternalAll(player);

  outlineAddPlayerToExistingTeamOutlines(player);
}

outlineRemovePlayerFromVisibleToArrays(player) {
  level.outlineEnts = array_removeUndefined(level.outlineEnts);

  foreach(entOutlined in level.outlineEnts) {
    outlinedForPlayer = false;

    foreach(oInfo in entOutlined.outlines) {
      oInfo.playersVisibleTo = array_removeUndefined(oInfo.playersVisibleTo);

      if(isDefined(player) && array_contains(oInfo.playersVisibleTo, player)) {
        oInfo.playersVisibleTo = array_remove(oInfo.playersVisibleTo, player);
        outlinedForPlayer = true;
      }
    }

    if(outlinedForPlayer && isDefined(entOutlined) && isDefined(player)) {
      entOutlined HudOutlineDisableForClient(player);
    }
  }
}

outlineAddPlayerToExistingTeamOutlines(player) {
  foreach(entOutlined in level.outlineEnts) {
    if(!isDefined(entOutlined)) {
      continue;
    }
    oInfoHighest = undefined;

    foreach(oInfo in entOutlined.outlines) {
      if((oInfo.Type == "ALL") || (oInfo.type == "TEAM" && oInfo.team == player.team)) {
        if(!array_contains(oInfo.playersVisibleTo, player)) {
          oInfo.playersVisibleTo[oInfo.playersVisibleTo.size] = player;
        } else {
          AssertMsg("Found a team outline call on a player's new team that already had a reference to him. This should never happen. Are we letting a player change teams to his own team?");
        }

        if(!isDefined(oInfoHighest) || oInfo.priority > oInfoHighest.priority) {
          oInfoHighest = oInfo;
        }
      }
    }

    if(isDefined(oInfoHighest)) {
      entOutlined HudOutlineEnableForClient(player, oInfoHighest.colorIndex, oInfoHighest.depthEnable);
    }
  }
}

outlineDisableInternalAll(entOutlined) {
  if(!isDefined(entOutlined) || !isDefined(entOutlined.outlines) || entOutlined.outlines.size == 0) {
    return;
  }
  foreach(ID, _ in entOutlined.outlines) {
    outlineDisableInternal(ID, entOutlined);
  }
}

outlineAddToGlobalList(entOutlined) {
  if(!array_contains(level.outlineEnts, entOutlined)) {
    level.outlineEnts[level.outlineEnts.size] = entOutlined;
  }
}

outlineRemoveFromGlobalList(entOutlined) {
  level.outlineEnts = array_remove(level.outlineEnts, entOutlined);
}

outlineGetHighestPriorityID(entOutlined) {
  result = -1;

  if(!isDefined(entOutlined.outlines) || entOutlined.size == 0)
    return result;

  oInfoHighest = undefined;

  foreach(ID, oInfo in entOutlined.outlines) {
    if(!isDefined(oInfoHighest) || oInfo.priority > oInfoHighest.priority) {
      oInfoHighest = oInfo;
      result = ID;
    }
  }

  return result;
}

outlineGetHighestInfoForPlayer(entOutlined, player) {
  oInfoHighest = undefined;

  if(isDefined(entOutlined.outlines) && entOutlined.outlines.size) {
    foreach(ID, oInfo in entOutlined.outlines) {
      if(array_contains(oInfo.playersVisibleTo, player) && (!isDefined(oInfoHighest) || oInfo.priority > oInfoHighest.priority)) {
        oInfoHighest = oInfo;
      }
    }
  }

  return oInfoHighest;
}

outlineGenerateUniqueID() {
  AssertEx(isDefined(level.outlineIDs), "Outline enable called on entity before _outline::init() function has been called.");

  level.outlineIDs++;

  return level.outlineIDs;
}

outlinePriorityGroupMap(priorityGroup) {
  priorityGroup = ToLower(priorityGroup);

  priority = undefined;

  switch (priorityGroup) {
    case "level_script":
      priority = 0;
      break;
    case "equipment":
      priority = 1;
      break;
    case "perk":
      priority = 2;
      break;
    case "killstreak":
      priority = 3;
      break;
    case "killstreak_personal":
      priority = 4;
      break;
    default:
      AssertMsg("Invalid priority group passed to outlinePriorityGroupMap(): " + priorityGroup);
      priority = 0;
      break;
  }

  return priority;
}

outlineColorIndexMap(colorName) {
  colorName = ToLower(colorName);

  idx = undefined;

  switch (colorName) {
    case "white":
      idx = 0;
      break;
    case "red":
      idx = 1;
      break;
    case "green":
      idx = 2;
      break;
    case "cyan":
      idx = 3;
      break;
    case "orange":
      idx = 4;
      break;
    case "yellow":
      idx = 5;
      break;
    case "blue":
      idx = 6;
      break;
    default:
      AssertMsg("Invalid color name passed to outlineColorIndexMap(): " + colorName);
      idx = 0;
      break;
  }

  return idx;
}