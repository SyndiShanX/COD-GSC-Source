/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\targetmarkergroups.gsc
************************************************/

function init() {
  level.activetargetmarkergroups = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerOnPlayerSpawnCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerOnPlayerSpawnCallback")]](&ref_13a7c);
    return;
  }
}

function targetmarkergroup_on(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(level.activetargetmarkergroups.size >= 50) {
    return;
  }

  if(targetmarkergroup_getownedgroups(var_3) >= 2) {
    return;
  }

  var_7 = deletetargetmarkergroup(var_0);

  if(targetmarkergroupexists(var_7)) {
    return;
  }

  addtargetmarkergroup(var_7, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_7;
}

function targetmarkergroup_off(var_0) {
  if(!targetmarkergroupexists(var_0)) {
    return;
  }

  removetargetmarkergroup(var_0);
  targetmarkergroupaddentity(var_0);
}

function addtargetmarkergroup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.markerid = var_0;
  var_7.markerowner = var_3;
  var_7.friendlymarker = var_4;
  var_7.showntoents = [];
  var_7.showntoteams = [];
  var_7.markedents = [];
  var_7.markedentsinqueue = [];
  level.activetargetmarkergroups[level.activetargetmarkergroups.size] = var_7;
  thread targetmarkergroup_handlemarkingfromqueue(level, var_7);

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_9 in var_1) {
        if(isPlayer(var_9)) {
          var_7.showntoents[var_7.showntoents.size] = var_9;
          addteamtotargetmarkergroupmask(var_0, var_9);
          continue;
        }

        if(isteam(var_9)) {
          var_7.showntoteams[var_7.showntoteams.size] = var_9;
          removeclientfromtargetmarkergroupmask(var_0, var_9);
        }
      }
    } else if(isPlayer(var_1)) {
      var_7.showntoents[var_7.showntoents.size] = var_1;
      addteamtotargetmarkergroupmask(var_0, var_1);
    } else if(isteam(var_1)) {
      var_7.showntoteams[var_7.showntoteams.size] = var_1;
      removeclientfromtargetmarkergroupmask(var_0, var_1);
    }
  }

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_12 in var_2) {
        targetmarkergroup_markentity(var_12, var_0, var_6);
      }
    } else {
      targetmarkergroup_markentity(var_2, var_0, var_6);
    }
  }

  if(istrue(var_5)) {
    thread ref_13a7d(level, var_0);
  }

  if(istrue(var_6)) {
    thread targetmarkergroup_watchfornoscopeoutlineperkset(level);
    thread targetmarkergroup_watchfornoscopeoutlineperkunset(level);
    return;
  }
}

function removetargetmarkergroup(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level.activetargetmarkergroups) {
    if(var_4.markerid == var_0) {
      var_1 = var_4;
      continue;
    }

    var_2 = var_4;
  }

  if(isDefined(var_1)) {
    var_1 = undefined;
  }

  level.activetargetmarkergroups = var_2;
  level notify("removed_targetMarkerGroup_" + var_0);
}

function targetmarkergroupexists(var_0) {
  var_1 = 0;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerid == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function gettargetmarkergroup(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerid == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

function ref_13a7d(var_0, var_1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("player_spawned", var_2);

    if(canbemarkedingroup(var_0, var_2)) {
      targetmarkergroup_markentity(var_2, var_0, var_1);
    }
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkunset(var_0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("unset_noscopeoutline", var_1);

    if(canbemarkedingroup(var_0, var_1)) {
      targetmarkergroup_markentity(var_1, var_0);
    }
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkset(var_0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("set_noscopeoutline", var_1);

    if(canbemarkedingroup(var_0, var_1)) {
      var_2 = var_1 getentitynumber();
      targetmarkergroup_unmarkentity(var_1, var_2, var_0);
    }
  }
}

function targetmarkergroup_markentity(var_0, var_1, var_2) {
  var_3 = gettargetmarkergroup(var_1);
  var_4 = var_0 getentitynumber();

  if(var_3.markedents.size >= 20) {
    targetmarkergroup_addtomarkingqueue(var_0, var_3, var_1);
    return;
  }

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_2)) {
      var_5 = var_3.markerowner;
      var_6 = isDefined(var_3.friendlymarker);
      var_7 = istrue(var_3.friendlymarker);

      if(var_6) {
        if(!var_7) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
              return;
            }
          }
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          return;
        }
      }
    }
  }

  if(!isDefined(var_3.markedents[var_4])) {
    var_3.markedents[var_4] = 1;
    targetmarkergroupremoveentity(var_1, var_0);

    if(isPlayer(var_0)) {
      thread targetmarkergroup_removefromgroupaction(var_0, "death");
      thread targetmarkergroup_removefromgroupaction(var_0, "disconnect");
      thread targetmarkergroup_removefromgroupaction(var_0, "joined_team");
      return;
    }

    thread targetmarkergroup_removefromgroupaction(var_0, "death");
    return;
  }
}

function targetmarkergroup_removefromgroupaction(var_0, var_1) {
  var_2 = self getentitynumber();
  var_1 endon("ent_removed_" + var_2);
  level endon("removed_targetMarkerGroup_" + var_1.markerid);
  self waittill(var_0);
  targetmarkergroup_unmarkentity(self, var_2, var_1.markerid);
}

function targetmarkergroup_addtomarkingqueue(var_0, var_1) {
  if(!targetmarkergroupexists(var_1)) {
    return;
  }

  var_0.markedentsinqueue[var_0.markedentsinqueue.size] = self;
  thread targetmarkergroup_handleremovequeueondisconnect(var_0, var_1);
}

function targetmarkergroup_handleremovequeueondisconnect(var_0, var_1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var_1);
  self waittill("disconnect");
  targetmarkergroup_removefrommarkingqueue(var_0, var_1);
}

function targetmarkergroup_removefrommarkingqueue(var_0, var_1) {
  if(!targetmarkergroupexists(var_1)) {
    return;
  }

  var_2 = [];

  foreach(var_4 in var_0.markedentsinqueue) {
    if(var_4 == self) {
      continue;
    }

    var_2 = var_4;
  }

  var_0.markedentsinqueue = var_2;
}

function targetmarkergroup_handlemarkingfromqueue(var_0, var_1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var_1);

  while(targetmarkergroupexists(var_1)) {
    level waittill("ent_removed_from_marker_group", var_2);

    if(var_2 != var_0) {
      continue;
    }

    if(var_0.markedentsinqueue.size == 0) {
      continue;
    }

    var_3 = undefined;

    if(!isDefined(var_0.markedentsinqueue[0])) {
      continue;
    } else {
      var_3 = var_0.markedentsinqueue[0];
    }

    var_4 = var_3 getentitynumber();

    if(!isDefined(var_0.markedents[var_4])) {
      var_0.markedents[var_4] = 1;
      targetmarkergroup_removefrommarkingqueue(var_3, var_0, var_1);
      targetmarkergroup_markentity(var_3, var_1);
    }
  }
}

function targetmarkergroup_unmarkentity(var_0, var_1, var_2) {
  var_3 = gettargetmarkergroup(var_2);

  if(isDefined(var_3) && isDefined(var_3.markedents[var_1])) {
    var_3.markedents[var_1] = undefined;

    if(isDefined(var_0)) {
      targetmarkergroupsetentitystate(var_2, var_0);
    }

    var_3 notify("ent_removed_" + var_1);
    level notify("ent_removed_from_marker_group", var_3);
    return;
  }
}

function targetmarkergroup_getownedgroups(var_0) {
  var_1 = 0;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerowner == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function ref_13a7c() {
  self setclientomnvar("ui_clear_target_markers", gettime());
}

function isteam(var_0) {
  if(var_0 == "spectator") {
    return true;
  }

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2) {
      return true;
    }
  }

  return false;
}

function canbemarkedingroup(var_0, var_1) {
  var_2 = 0;
  var_3 = gettargetmarkergroup(var_0);
  var_4 = var_3.markerowner;
  var_5 = istrue(level.teambased) && isDefined(var_3.friendlymarker);
  var_6 = istrue(var_3.friendlymarker);

  if(!isDefined(var_4)) {
    return var_2;
  }

  if(var_5) {
    if(var_6) {
      if(var_1.team == var_4.team) {
        var_2 = 1;
      }
    } else if(var_1.team != var_4.team) {
      var_2 = 1;
    }
  } else if(var_6) {
    if(isPlayer(var_1) && var_1 == var_4) {
      var_2 = 1;
    }
  } else {
    var_2 = 1;
  }

  return var_2;
}