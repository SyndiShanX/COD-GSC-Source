/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\targetmarkergroups.gsc
*************************************************/

#using scripts\common\values;
#using scripts\engine\utility;
#namespace targetmarkergroups;

function init() {
  level.activetargetmarkergroups = [];

  if(utility::issharedfuncdefined(#"game", #"registeronplayerspawncallback")) {
    [[utility::getsharedfunc(#"game", #"registeronplayerspawncallback")]](&targetmarkergroup_clearcacheonspawn);
  }

  utility::registersharedfunc(#"game", #"targetmarkergroup_off", &targetmarkergroup_off);
  utility::registersharedfunc(#"game", #"targetmarkergroup_on", &targetmarkergroup_on);
}

function targetmarkergroup_on(markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_95a52af3f6c1e040) {
  if(level.activetargetmarkergroups.size >= 50) {
    assertmsg("<dev string:x24>");
    return;
  }

  if(targetmarkergroup_getownedgroups(groupowner) >= 2) {
    assertmsg("<dev string:x95>");
    return;
  }

  newtargetmarkergroupid = createtargetmarkergroup(markerwidgetname);

  if(!isDefined(newtargetmarkergroupid)) {
    assertmsg("<dev string:x10a>");
    return;
  } else if(targetmarkergroupexists(newtargetmarkergroupid)) {
    assertmsg("<dev string:x15f>" + newtargetmarkergroupid + "<dev string:x1ad>");
    return;
  }

  addtargetmarkergroup(newtargetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_95a52af3f6c1e040);
  return newtargetmarkergroupid;
}

function targetmarkergroup_off(targetmarkergroupid) {
  if(!targetmarkergroupexists(targetmarkergroupid)) {
    assertmsg("<dev string:x1c1>" + targetmarkergroupid + "<dev string:x1f6>");
    return;
  }

  removetargetmarkergroup(targetmarkergroupid);
  deletetargetmarkergroup(targetmarkergroupid);
}

function function_1415edba0bc26712(ent) {
  var_be981a017273740f = 0;

  foreach(markergroup in level.activetargetmarkergroups) {
    if(arraycontains(markergroup.showntoents, ent)) {
      var_be981a017273740f++;
    }
  }

  return var_be981a017273740f;
}

function function_83fbfe930a9cf11a(targetmarkergroupid, showto) {
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  assert(isDefined(markergroup), "<dev string:x1fb>");

  if(isDefined(showto)) {
    if(isPlayer(showto)) {
      if(arraycontains(markergroup.showntoents, showto)) {
        return;
      }

      if(function_1415edba0bc26712(showto) >= 2) {
        assertmsg("<dev string:x242>");
        return;
      }

      markergroup.showntoents[markergroup.showntoents.size] = showto;
      addclienttotargetmarkergroupmask(targetmarkergroupid, showto);
    }
  }
}

function function_3e662c31dc892192(targetmarkergroupid, showto) {
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  assert(isDefined(markergroup), "<dev string:x1fb>");
  assert(isDefined(showto), "<dev string:x2c0>");
  assert(isarray(showto), "<dev string:x304>");

  foreach(showtoent in showto) {
    if(isPlayer(showtoent)) {
      if(arraycontains(markergroup.showntoents, showtoent)) {
        continue;
      }

      if(function_1415edba0bc26712(showtoent) >= 2) {
        assertmsg("<dev string:x242>");
        continue;
      }

      markergroup.showntoents[markergroup.showntoents.size] = showtoent;
      addclienttotargetmarkergroupmask(targetmarkergroupid, showtoent);
    }
  }
}

function function_a389874604afecb8(targetmarkergroupid, showto) {
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  assert(isDefined(markergroup), "<dev string:x1fb>");

  if(isDefined(showto)) {
    if(isteam(showto)) {
      if(arraycontains(markergroup.showntoteams, showto)) {
        return;
      }

      teaments = level.teamdata[showto]["Da\fP&X\xfc"];

      foreach(player in teaments) {
        if(function_1415edba0bc26712(player) >= 2) {
          assertmsg("<dev string:x242>");
          return;
        }
      }

      markergroup.showntoteams[markergroup.showntoteams.size] = showto;
      addteamtotargetmarkergroupmask(targetmarkergroupid, showto);
    }
  }
}

function function_6bfc1b58594d6ef4(targetmarkergroupid, showto) {
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  assert(isDefined(markergroup), "<dev string:x1fb>");
  assert(isDefined(showto), "<dev string:x359>");
  assert(isarray(showto), "<dev string:x3a1>");

  foreach(showtoent in showto) {
    if(isteam(showtoent)) {
      if(arraycontains(markergroup.showntoteams, showtoent)) {
        continue;
      }

      teaments = level.teamdata[showtoent]["Da\fP&X\xfc"];

      foreach(player in teaments) {
        if(function_1415edba0bc26712(player) >= 2) {
          assertmsg("<dev string:x242>");
          break;
        }
      }

      markergroup.showntoteams[markergroup.showntoteams.size] = showtoent;
      addteamtotargetmarkergroupmask(targetmarkergroupid, showtoent);
    }
  }
}

function function_9906767915980001(targetmarkergroupid, var_6ddc7bbfb894afa) {
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  assert(isDefined(markergroup), "<dev string:x1fb>");

  if(isDefined(var_6ddc7bbfb894afa)) {
    if(isarray(var_6ddc7bbfb894afa)) {
      foreach(remove in var_6ddc7bbfb894afa) {
        if(isPlayer(var_6ddc7bbfb894afa)) {
          if(arraycontains(markergroup.showntoents, remove)) {
            markergroup.showntoents = arrayremove(markergroup.showntoents, remove);
            removeclientfromtargetmarkergroupmask(targetmarkergroupid, remove);
          }

          continue;
        }

        if(isteam(var_6ddc7bbfb894afa)) {
          if(arraycontains(markergroup.showntoteams, remove)) {
            markergroup.showntoteams = arrayremove(markergroup.showntoteams, remove);
            removeteamfromtargetmarkergroupmask(targetmarkergroupid, remove);
          }
        }
      }

      return;
    }

    if(isPlayer(var_6ddc7bbfb894afa)) {
      if(arraycontains(markergroup.showntoents, var_6ddc7bbfb894afa)) {
        markergroup.showntoents = arrayremove(markergroup.showntoents, var_6ddc7bbfb894afa);
        removeclientfromtargetmarkergroupmask(targetmarkergroupid, var_6ddc7bbfb894afa);
      }

      return;
    }

    if(isteam(var_6ddc7bbfb894afa)) {
      if(arraycontains(markergroup.showntoteams, var_6ddc7bbfb894afa)) {
        markergroup.showntoteams = arrayremove(markergroup.showntoteams, var_6ddc7bbfb894afa);
        removeteamfromtargetmarkergroupmask(targetmarkergroupid, var_6ddc7bbfb894afa);
      }
    }
  }
}

function addtargetmarkergroup(targetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_95a52af3f6c1e040) {
  markergroup = spawnStruct();
  markergroup.markerid = targetmarkergroupid;
  markergroup.markerowner = groupowner;
  markergroup.friendlymarker = friendlymarker;
  markergroup.showntoents = [];
  markergroup.showntoteams = [];
  markergroup.markedents = [];
  markergroup.markedentsinqueue = [];
  level.activetargetmarkergroups[level.activetargetmarkergroups.size] = markergroup;
  level thread targetmarkergroup_handlemarkingfromqueue(targetmarkergroupid);

  if(isDefined(showto)) {
    if(isarray(showto)) {
      foreach(showtoent in showto) {
        if(function_1415edba0bc26712(showtoent) >= 2) {
          assertmsg("<dev string:x242>");
          continue;
        }

        if(isPlayer(showtoent)) {
          markergroup.showntoents[markergroup.showntoents.size] = showtoent;
          addclienttotargetmarkergroupmask(targetmarkergroupid, showtoent);
          continue;
        }

        if(isteam(showtoent)) {
          markergroup.showntoteams[markergroup.showntoteams.size] = showtoent;
          addteamtotargetmarkergroupmask(targetmarkergroupid, showtoent);
        }
      }
    } else if(isPlayer(showto)) {
      markergroup.showntoents[markergroup.showntoents.size] = showto;
      addclienttotargetmarkergroupmask(targetmarkergroupid, showto);
    } else if(isteam(showto)) {
      markergroup.showntoteams[markergroup.showntoteams.size] = showto;
      addteamtotargetmarkergroupmask(targetmarkergroupid, showto);
    }
  }

  if(isDefined(tomark)) {
    if(isarray(tomark)) {
      foreach(enttomark in tomark) {
        targetmarkergroup_markentity(enttomark, targetmarkergroupid, var_95a52af3f6c1e040);
      }
    } else {
      targetmarkergroup_markentity(tomark, targetmarkergroupid, var_95a52af3f6c1e040);
    }
  }

  if(istrue(markonspawn)) {
    level thread targetmarkergroup_watchmarkonspawn(targetmarkergroupid, var_95a52af3f6c1e040);
  }

  if(istrue(var_95a52af3f6c1e040)) {
    level thread targetmarkergroup_watchfornoscopeoutlineperkset(targetmarkergroupid);
    level thread targetmarkergroup_watchfornoscopeoutlineperkunset(targetmarkergroupid);
  }
}

function function_e46faca783438004(targetmarkergroupid) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + targetmarkergroupid);

  while(targetmarkergroupexists(targetmarkergroupid)) {
    markergroup = gettargetmarkergroup(targetmarkergroupid);

    if(markergroup.markedentsinqueue.size > 0) {
      entnum = undefined;

      foreach(ent in markergroup.markedents) {
        entnum = ent function_906f5114a8800801();

        if(isDefined(entnum)) {
          ent function_a8d4e864e31ad2c6(markergroup);
          wait randomfloatrange(0.1, 0.2);
          break;
        }
      }
    }

    waitframe();
  }
}

function setnewowner(targetmarkergroupid, newowner) {
  tmg = gettargetmarkergroup(targetmarkergroupid);
  tmg.markerowner = newowner;
}

function removetargetmarkergroup(targetmarkergroupid) {
  grouptoremove = undefined;
  var_2c5c510a48a2d26 = [];

  foreach(markergroup in level.activetargetmarkergroups) {
    if(markergroup.markerid == targetmarkergroupid) {
      grouptoremove = markergroup;
      continue;
    }

    var_2c5c510a48a2d26[var_2c5c510a48a2d26.size] = markergroup;
  }

  if(isDefined(grouptoremove)) {
    grouptoremove = undefined;
  }

  level.activetargetmarkergroups = var_2c5c510a48a2d26;
  level notify("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + targetmarkergroupid);
}

function targetmarkergroupexists(targetmarkergroupid) {
  groupexists = 0;

  if(!isDefined(targetmarkergroupid)) {
    assertmsg("<dev string:x3eb>");
    return groupexists;
  }

  foreach(markergroup in level.activetargetmarkergroups) {
    if(markergroup.markerid == targetmarkergroupid) {
      groupexists = 1;
      break;
    }
  }

  return groupexists;
}

function gettargetmarkergroup(targetmarkergroupid) {
  targetmarkergroup = undefined;

  if(!isDefined(targetmarkergroupid)) {
    assertmsg("<dev string:x426>");
    return targetmarkergroup;
  }

  foreach(markergroup in level.activetargetmarkergroups) {
    if(markergroup.markerid == targetmarkergroupid) {
      targetmarkergroup = markergroup;
      break;
    }
  }

  return targetmarkergroup;
}

function targetmarkergroup_watchmarkonspawn(targetmarkergroupid, var_95a52af3f6c1e040) {
  level endon("\xcb\xfeR\x1f\xa3\xab\xe5\xe5\xc9\xf8\n");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + targetmarkergroupid);

  while(true) {
    level waittill("z9\x7fnm\x12X\xa2\xcb9\f\xbe)\xc2", player);

    if(canbemarkedingroup(targetmarkergroupid, player)) {
      player thread function_be18bf43d59811c7(targetmarkergroupid, var_95a52af3f6c1e040);
    }
  }
}

function function_be18bf43d59811c7(targetmarkergroupid, var_95a52af3f6c1e040) {
  spawnprotectiontimeremaining = level.spawnprotectiontimer - (gettime() - self.spawntime) * 0.001;

  if(spawnprotectiontimeremaining > 0) {
    wait spawnprotectiontimeremaining;
  }

  if(isDefined(self)) {
    targetmarkergroup_markentity(self, targetmarkergroupid, var_95a52af3f6c1e040);
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkunset(targetmarkergroupid) {
  level endon("\xcb\xfeR\x1f\xa3\xab\xe5\xe5\xc9\xf8\n");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + targetmarkergroupid);

  while(true) {
    level waittill("\xcfm\xf7\xdd\xa2`\xcaD\v\x81d\xe1\xdd_W\xd4-c\xe3\x91", player);

    if(canbemarkedingroup(targetmarkergroupid, player)) {
      targetmarkergroup_markentity(player, targetmarkergroupid);
    }
  }
}

function targetmarkergroup_watchfornoscopeoutlineperkset(targetmarkergroupid) {
  level endon("\xcb\xfeR\x1f\xa3\xab\xe5\xe5\xc9\xf8\n");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + targetmarkergroupid);

  while(true) {
    level waittill("}Zj\x1a\x80\xd6\f_\x7fP\xb8\x83\xc6\xfd\xad\x02`]", player);

    if(canbemarkedingroup(targetmarkergroupid, player)) {
      targetmarkergroup_unmarkentity(player, targetmarkergroupid);
    }
  }
}

function private function_906f5114a8800801() {
  outxuid = undefined;

  if(isDefined(self) && isent(self)) {
    if(isPlayer(self) && !isbot(self)) {
      outxuid = self getxuid();
    } else if(isDefined(self.owner) && !isbot(self.owner) && isPlayer(self.owner)) {
      outxuid = self.owner getxuid();
    } else {
      outxuid = self getentitynumber();
    }
  }

  return outxuid;
}

function targetmarkergroup_markentity(ent, targetmarkergroupid, var_95a52af3f6c1e040) {
  if(!ent val::get("\x81\xed\x8d;\xb7\x89\xe1\x8c\xaa\xe9\t\xf0\xe9\x1ds\xae\x83")) {
    return;
  }

  markergroup = gettargetmarkergroup(targetmarkergroupid);

  if(!isDefined(markergroup)) {
    return;
  }

  entnum = ent function_906f5114a8800801();

  if(!isDefined(entnum)) {
    return;
  }

  if(markergroup.markedents.size >= 20) {
    ent targetmarkergroup_addtomarkingqueue(markergroup);
    return;
  }

  if(isDefined(ent) && isPlayer(ent)) {
    if(istrue(ent.liveragdoll)) {
      return;
    }

    if(istrue(var_95a52af3f6c1e040)) {
      markerowner = markergroup.markerowner;
      checkteam = isDefined(markergroup.friendlymarker);
      isfriendlymarker = istrue(markergroup.friendlymarker);

      if(checkteam) {
        if(!isfriendlymarker) {
          if(utility::issharedfuncdefined(#"perk", #"hasperk")) {
            if(ent[[utility::getsharedfunc(#"perk", #"hasperk")]]("\xfc\x8d\x9fd>\xab\xb3\xf0}\x12$\xf2\xad\xf7\xd5\"+\x15b\x0e\xbdh\xa7}")) {
              return;
            }
          }
        }
      } else if(utility::issharedfuncdefined(#"perk", #"hasperk")) {
        if(ent[[utility::getsharedfunc(#"perk", #"hasperk")]]("\xfc\x8d\x9fd>\xab\xb3\xf0}\x12$\xf2\xad\xf7\xd5\"+\x15b\x0e\xbdh\xa7}")) {
          return;
        }
      }
    }
  }

  if(!arraycontains(markergroup.markedents, ent)) {
    markergroup.markedents[entnum] = ent;
    targetmarkergroupaddentity(targetmarkergroupid, ent);

    if(isPlayer(ent)) {
      ent thread targetmarkergroup_removefromgroupaction("\x1e\xfd\xd1\xa2\a", markergroup);
      ent thread targetmarkergroup_removefromgroupaction("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16", markergroup);
      ent thread targetmarkergroup_removefromgroupaction("Ah\x1d{\xc5+\x80\x80\xaf.\xae", markergroup);
      ent thread targetmarkergroup_removefromgroupaction("\xb2\xcd\x8e\xac\x9c\xbec\xa5\xec\xb2\xeb9,\xd9\x19\xed\x1b6", markergroup);
      return;
    }

    ent thread targetmarkergroup_removefromgroupaction("\x1e\xfd\xd1\xa2\a", markergroup);
  }
}

function function_a8d4e864e31ad2c6(markergroup) {
  entnum = function_906f5114a8800801();
  markergroup endon("\x80|\xcc\x19s\xfcQ0\xd5\xc1\xe9\xd0" + entnum);
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + markergroup.markerid);
  targetmarkergroup_addtomarkingqueue(markergroup);
  targetmarkergroup_unmarkentity(self, markergroup.markerid, entnum);
}

function targetmarkergroup_removefromgroupaction(action, markergroup) {
  entnum = function_906f5114a8800801();
  markergroup endon("\x80|\xcc\x19s\xfcQ0\xd5\xc1\xe9\xd0" + entnum);
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + markergroup.markerid);
  self waittill(action);
  targetmarkergroup_unmarkentity(self, markergroup.markerid, entnum);
}

function targetmarkergroup_addtomarkingqueue(markergroup) {
  if(isDefined(self) && !arraycontains(markergroup.markedentsinqueue, self)) {
    markergroup.markedentsinqueue[markergroup.markedentsinqueue.size] = self;

    if(isPlayer(self)) {
      thread function_fc236663fe477f72("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16", markergroup);
      return;
    }

    thread function_fc236663fe477f72("\x1e\xfd\xd1\xa2\a", markergroup);
  }
}

function function_fc236663fe477f72(removenotify, markergroup) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + markergroup.markerid);
  self waittill(removenotify);
  targetmarkergroup_removefrommarkingqueue(markergroup);
}

function targetmarkergroup_removefrommarkingqueue(markergroup) {
  if(!isDefined(markergroup)) {
    assertmsg("<dev string:x45e>");
    return;
  }

  newlist = [];

  if(isDefined(self)) {
    newlist = arrayremove(markergroup.markedentsinqueue, self);
  } else {
    newlist = utility::array_removeundefined(markergroup.markedentsinqueue);
  }

  markergroup.markedentsinqueue = newlist;
}

function targetmarkergroup_handlemarkingfromqueue(markergroupid) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level endon("\x93\xac\xd6\xb7\xce+d\xeb:X\x93\xd9\x95\xa35,'[e\x9c\xd1r\xde\xae\xc1_" + markergroupid);

  while(targetmarkergroupexists(markergroupid)) {
    level waittill("?\xcd\x1d<3\xd8yA\xb2\xbd\xe0\x92+\xacM+KJ\xb7\xd9\x13\xc0\x96!\x90\x16\x90\xd2\xe9", var_73791ea9ab0be347);
    markergroup = gettargetmarkergroup(markergroupid);

    if(!isDefined(markergroup)) {
      assertmsg("<dev string:x4a9>");
      break;
    }

    if(var_73791ea9ab0be347 != markergroup) {
      continue;
    }

    if(markergroup.markedentsinqueue.size == 0) {
      continue;
    }

    enttoadd = undefined;

    if(isDefined(markergroup.markedentsinqueue[0])) {
      enttoadd = markergroup.markedentsinqueue[0];
    }

    enttoadd targetmarkergroup_removefrommarkingqueue(markergroup);
    targetmarkergroup_markentity(enttoadd, markergroupid);
  }
}

function targetmarkergroup_unmarkentity(ent, targetmarkergroupid, entnumoverride) {
  entnum = ent function_906f5114a8800801();

  if(isDefined(entnumoverride)) {
    entnum = entnumoverride;
  }

  markergroup = gettargetmarkergroup(targetmarkergroupid);

  if(isDefined(markergroup) && isDefined(markergroup.markedents)) {
    markergroup.markedents = function_b1bcd7a846b3b5(markergroup.markedents, ent);

    if(isDefined(ent)) {
      targetmarkergroupremoveentity(targetmarkergroupid, ent);
    }

    level notify("?\xcd\x1d<3\xd8yA\xb2\xbd\xe0\x92+\xacM+KJ\xb7\xd9\x13\xc0\x96!\x90\x16\x90\xd2\xe9", markergroup);
    markergroup notify("\x80|\xcc\x19s\xfcQ0\xd5\xc1\xe9\xd0" + entnum);
  }
}

function function_b1bcd7a846b3b5(markedents, enttoremove) {
  newarray = [];

  foreach(ent in markedents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(isDefined(enttoremove) && enttoremove == ent) {
      continue;
    }

    newarray[entnumindex] = ent;
  }

  return newarray;
}

function function_387edf5c131d8176(target, targetmarkergroupid) {
  entnum = target function_906f5114a8800801();
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  return isDefined(entnum) && isDefined(markergroup.markedents) && isDefined(markergroup) && isDefined(markergroup.markedents[entnum]);
}

function targetmarkergroup_getownedgroups(groupowner) {
  groupcount = 0;

  foreach(markergroup in level.activetargetmarkergroups) {
    if(markergroup.markerowner == groupowner) {
      groupcount++;
    }
  }

  return groupcount;
}

function targetmarkergroup_clearcacheonspawn() {
  self setclientomnvar("\x05H\xaa:\xd1\xed\xc0?\x904^\fZ\xdc~\xac\x16\xbc\xce\xc00f\xf4", gettime());
}

function isteam(showto) {
  if(showto == "H1\x06\x96\xd4\xa3\x86\a\xc5") {
    return true;
  }

  foreach(teamname in level.teamnamelist) {
    if(showto == teamname) {
      return true;
    }
  }

  return false;
}

function canbemarkedingroup(targetmarkergroupid, ent) {
  canbemarked = 0;
  markergroup = gettargetmarkergroup(targetmarkergroupid);
  markergroupowner = markergroup.markerowner;
  checkteam = istrue(level.teambased);
  isfriendlymarker = istrue(markergroup.friendlymarker);

  if(!isDefined(markergroupowner)) {
    return canbemarked;
  }

  if(checkteam) {
    if(isfriendlymarker) {
      if(ent.team == markergroupowner.team) {
        canbemarked = 1;
      }
    } else if(ent.team != markergroupowner.team) {
      canbemarked = 1;
    }
  } else if(isfriendlymarker) {
    if(ent == markergroupowner) {
      canbemarked = 1;
    }
  } else if(ent != markergroupowner) {
    canbemarked = 1;
  }

  return canbemarked;
}