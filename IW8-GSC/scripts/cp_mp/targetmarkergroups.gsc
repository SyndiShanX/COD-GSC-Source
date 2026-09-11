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

function targetmarkergroup_on(var0, var1, var2, var3, var4, var5, var6) {
  if(level.activetargetmarkergroups.size >= 50) {
    return;
  }

  if(targetmarkergroup_getownedgroups(var3) >= 2) {
    return;
  }

  var7 = deletetargetmarkergroup(var0);

  if(targetmarkergroupexists(var7)) {
    return;
  }

  addtargetmarkergroup(var7, var1, var2, var3, var4, var5, var6);
  return var7;
}

function targetmarkergroup_off(var0) {
  if(!targetmarkergroupexists(var0)) {
    return;
  }

  removetargetmarkergroup(var0);
  targetmarkergroupaddentity(var0);
}

function addtargetmarkergroup(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7.markerid = var0;
  var7.markerowner = var3;
  var7.friendlymarker = var4;
  var7.showntoents = [];
  var7.showntoteams = [];
  var7.markedents = [];
  var7.markedentsinqueue = [];
  level.activetargetmarkergroups[level.activetargetmarkergroups.size] = var7;
  thread targetmarkergroup_handlemarkingfromqueue(level, var7);

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var9 in var1) {
        if(isPlayer(var9)) {
          var7.showntoents[var7.showntoents.size] = var9;
          addteamtotargetmarkergroupmask(var0, var9);
          continue;
        }

        if(isteam(var9)) {
          var7.showntoteams[var7.showntoteams.size] = var9;
          removeclientfromtargetmarkergroupmask(var0, var9);
        }
      }
    } else if(isPlayer(var1)) {
      var7.showntoents[var7.showntoents.size] = var1;
      addteamtotargetmarkergroupmask(var0, var1);
    } else if(isteam(var1)) {
      var7.showntoteams[var7.showntoteams.size] = var1;
      removeclientfromtargetmarkergroupmask(var0, var1);
    }
  }

  if(isDefined(var2)) {
    if(isarray(var2)) {
      foreach(var12 in var2) {
        targetmarkergroup_markentity(var12, var0, var6);
      }
    } else {
      targetmarkergroup_markentity(var2, var0, var6);
    }
  }

  if(istrue(var5)) {
    thread ref_13a7d(level, var0);
  }

  if(istrue(var6)) {
    thread targetmarkergroup_watchfornoscopeoutlineperkset(level);
    thread targetmarkergroup_watchfornoscopeoutlineperkunset(level);
    return;
  }
}

function removetargetmarkergroup(var0) {
  var1 = undefined;
  var2 = [];

  foreach(var4 in level.activetargetmarkergroups) {
    if(var4.markerid == var0) {
      var1 = var4;
      continue;
    }

    var2 = var4;
  }

  if(isDefined(var1)) {
    var1 = undefined;
  }

  level.activetargetmarkergroups = var2;
  level notify("removed_targetMarkerGroup_" + var0);
}

function targetmarkergroupexists(var0) {
  var1 = 0;

  foreach(var3 in level.activetargetmarkergroups) {
    if(var3.markerid == var0) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function gettargetmarkergroup(var0) {
  var1 = undefined;

  foreach(var3 in level.activetargetmarkergroups) {
    if(var3.markerid == var0) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function ref_13a7d(var0, var1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var0);

  for(;;) {
    level waittill("player_spawned", var2);

    if(canbemarkedingroup(var0, var2)) {
      targetmarkergroup_markentity(var2, var0, var1);
    }
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkunset(var0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var0);

  for(;;) {
    level waittill("unset_noscopeoutline", var1);

    if(canbemarkedingroup(var0, var1)) {
      targetmarkergroup_markentity(var1, var0);
    }
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkset(var0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var0);

  for(;;) {
    level waittill("set_noscopeoutline", var1);

    if(canbemarkedingroup(var0, var1)) {
      var2 = var1 getentitynumber();
      targetmarkergroup_unmarkentity(var1, var2, var0);
    }
  }
}

function targetmarkergroup_markentity(var0, var1, var2) {
  var3 = gettargetmarkergroup(var1);
  var4 = var0 getentitynumber();

  if(var3.markedents.size >= 20) {
    targetmarkergroup_addtomarkingqueue(var0, var3, var1);
    return;
  }

  if(isDefined(var0) && isPlayer(var0)) {
    if(istrue(var2)) {
      var5 = var3.markerowner;
      var6 = isDefined(var3.friendlymarker);
      var7 = istrue(var3.friendlymarker);

      if(var6) {
        if(!var7) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
              return;
            }
          }
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          return;
        }
      }
    }
  }

  if(!isDefined(var3.markedents[var4])) {
    var3.markedents[var4] = 1;
    targetmarkergroupremoveentity(var1, var0);

    if(isPlayer(var0)) {
      thread targetmarkergroup_removefromgroupaction(var0, "death");
      thread targetmarkergroup_removefromgroupaction(var0, "disconnect");
      thread targetmarkergroup_removefromgroupaction(var0, "joined_team");
      return;
    }

    thread targetmarkergroup_removefromgroupaction(var0, "death");
    return;
  }
}

function targetmarkergroup_removefromgroupaction(var0, var1) {
  var2 = self getentitynumber();
  var1 endon("ent_removed_" + var2);
  level endon("removed_targetMarkerGroup_" + var1.markerid);
  self waittill(var0);
  targetmarkergroup_unmarkentity(self, var2, var1.markerid);
}

function targetmarkergroup_addtomarkingqueue(var0, var1) {
  if(!targetmarkergroupexists(var1)) {
    return;
  }

  var0.markedentsinqueue[var0.markedentsinqueue.size] = self;
  thread targetmarkergroup_handleremovequeueondisconnect(var0, var1);
}

function targetmarkergroup_handleremovequeueondisconnect(var0, var1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var1);
  self waittill("disconnect");
  targetmarkergroup_removefrommarkingqueue(var0, var1);
}

function targetmarkergroup_removefrommarkingqueue(var0, var1) {
  if(!targetmarkergroupexists(var1)) {
    return;
  }

  var2 = [];

  foreach(var4 in var0.markedentsinqueue) {
    if(var4 == self) {
      continue;
    }

    var2 = var4;
  }

  var0.markedentsinqueue = var2;
}

function targetmarkergroup_handlemarkingfromqueue(var0, var1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var1);

  while(targetmarkergroupexists(var1)) {
    level waittill("ent_removed_from_marker_group", var2);

    if(var2 != var0) {
      continue;
    }

    if(var0.markedentsinqueue.size == 0) {
      continue;
    }

    var3 = undefined;

    if(!isDefined(var0.markedentsinqueue[0])) {
      continue;
    } else {
      var3 = var0.markedentsinqueue[0];
    }

    var4 = var3 getentitynumber();

    if(!isDefined(var0.markedents[var4])) {
      var0.markedents[var4] = 1;
      targetmarkergroup_removefrommarkingqueue(var3, var0, var1);
      targetmarkergroup_markentity(var3, var1);
    }
  }
}

function targetmarkergroup_unmarkentity(var0, var1, var2) {
  var3 = gettargetmarkergroup(var2);

  if(isDefined(var3) && isDefined(var3.markedents[var1])) {
    var3.markedents[var1] = undefined;

    if(isDefined(var0)) {
      targetmarkergroupsetentitystate(var2, var0);
    }

    var3 notify("ent_removed_" + var1);
    level notify("ent_removed_from_marker_group", var3);
    return;
  }
}

function targetmarkergroup_getownedgroups(var0) {
  var1 = 0;

  foreach(var3 in level.activetargetmarkergroups) {
    if(var3.markerowner == var0) {
      var1++;
    }
  }

  return var1;
}

function ref_13a7c() {
  self setclientomnvar("ui_clear_target_markers", gettime());
}

function isteam(var0) {
  if(var0 == "spectator") {
    return true;
  }

  foreach(var2 in level.teamnamelist) {
    if(var0 == var2) {
      return true;
    }
  }

  return false;
}

function canbemarkedingroup(var0, var1) {
  var2 = 0;
  var3 = gettargetmarkergroup(var0);
  var4 = var3.markerowner;
  var5 = istrue(level.teambased) && isDefined(var3.friendlymarker);
  var6 = istrue(var3.friendlymarker);

  if(!isDefined(var4)) {
    return var2;
  }

  if(var5) {
    if(var6) {
      if(var1.team == var4.team) {
        var2 = 1;
      }
    } else if(var1.team != var4.team) {
      var2 = 1;
    }
  } else if(var6) {
    if(isPlayer(var1) && var1 == var4) {
      var2 = 1;
    }
  } else {
    var2 = 1;
  }

  return var2;
}