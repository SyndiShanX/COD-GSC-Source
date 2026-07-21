/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\targetmarkergroups.gsc
***********************************************/

init() {
  level.activetargetmarkergroups = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B511E42FB086CF705E96BA0904FC3264053DAEB29D033BBB601829A393F271C"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B511E42FB086CF705E96BA0904FC3264053DAEB29D033BBB601829A393F271C")]](::_id_13A7C);
}

targetmarkergroup_on(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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

targetmarkergroup_off(var_0) {
  if(!targetmarkergroupexists(var_0)) {
    return;
  }
  removetargetmarkergroup(var_0);
  targetmarkergroupaddentity(var_0);
}

addtargetmarkergroup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.markerid = var_0;
  var_7.markerowner = var_3;
  var_7.friendlymarker = var_4;
  var_7.showntoents = [];
  var_7.showntoteams = [];
  var_7.markedents = [];
  var_7.markedentsinqueue = [];
  level.activetargetmarkergroups[level.activetargetmarkergroups.size] = var_7;
  level thread targetmarkergroup_handlemarkingfromqueue(var_7, var_0);

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
      foreach(var_12 in var_2)
      targetmarkergroup_markentity(var_12, var_0, var_6);
    } else
      targetmarkergroup_markentity(var_2, var_0, var_6);
  }

  if(istrue(var_5))
    level thread _id_13A7D(var_0, var_6);

  if(istrue(var_6)) {
    level thread targetmarkergroup_watchfornoscopeoutlineperkset(var_0);
    level thread targetmarkergroup_watchfornoscopeoutlineperkunset(var_0);
  }
}

removetargetmarkergroup(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level.activetargetmarkergroups) {
    if(var_4.markerid == var_0) {
      var_1 = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  if(isDefined(var_1))
    var_1 = undefined;

  level.activetargetmarkergroups = var_2;
  level notify("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);
}

targetmarkergroupexists(var_0) {
  var_1 = 0;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerid == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

gettargetmarkergroup(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerid == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_13A7D(var_0, var_1) {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_2);

    if(canbemarkedingroup(var_0, var_2))
      targetmarkergroup_markentity(var_2, var_0, var_1);
  }
}

targetmarkergroup_watchfornoscopeoutlineperkunset(var_0) {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);

  for(;;) {
    level waittill("_encstr_BEF2159B701BDF5441A508C2612863A102651301DFE378", var_1);

    if(canbemarkedingroup(var_0, var_1))
      targetmarkergroup_markentity(var_1, var_0);
  }
}

targetmarkergroup_watchfornoscopeoutlineperkset(var_0) {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);

  for(;;) {
    level waittill("_encstr_8AEC13372BE8F5B97BB9C6B70E597BEA3AB19673AC", var_1);

    if(canbemarkedingroup(var_0, var_1)) {
      var_2 = var_1 getentitynumber();
      targetmarkergroup_unmarkentity(var_1, var_2, var_0);
    }
  }
}

targetmarkergroup_markentity(var_0, var_1, var_2) {
  var_3 = gettargetmarkergroup(var_1);
  var_4 = var_0 getentitynumber();

  if(var_3.markedents.size >= 20) {
    var_0 targetmarkergroup_addtomarkingqueue(var_3, var_1);
    return;
  }

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_2)) {
      var_5 = var_3.markerowner;
      var_6 = isDefined(var_3.friendlymarker);
      var_7 = istrue(var_3.friendlymarker);

      if(var_6) {
        if(!var_7) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
            if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
              return;
          }
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
          return;
      }
    }
  }

  if(!isDefined(var_3.markedents[var_4])) {
    var_3.markedents[var_4] = 1;
    targetmarkergroupremoveentity(var_1, var_0);

    if(isPlayer(var_0)) {
      var_0 thread targetmarkergroup_removefromgroupaction("_encstr_AD75063D571AE108", var_3);
      var_0 thread targetmarkergroup_removefromgroupaction("_encstr_8D820B49520F0EC02DDE6367EC", var_3);
      var_0 thread targetmarkergroup_removefromgroupaction("_encstr_81170C244F9CBDE72C01BB99A298", var_3);
    } else
      var_0 thread targetmarkergroup_removefromgroupaction("_encstr_AD75063D571AE108", var_3);
  }
}

targetmarkergroup_removefromgroupaction(var_0, var_1) {
  var_2 = self getentitynumber();
  var_1 endon("_encstr_96310D17DD29B9E061CB8AC4F98B31" + var_2);
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_1.markerid);
  self waittill(var_0);
  targetmarkergroup_unmarkentity(self, var_2, var_1.markerid);
}

targetmarkergroup_addtomarkingqueue(var_0, var_1) {
  if(!targetmarkergroupexists(var_1)) {
    return;
  }
  var_0.markedentsinqueue[var_0.markedentsinqueue.size] = self;
  thread targetmarkergroup_handleremovequeueondisconnect(var_0, var_1);
}

targetmarkergroup_handleremovequeueondisconnect(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_1);
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  targetmarkergroup_removefrommarkingqueue(var_0, var_1);
}

targetmarkergroup_removefrommarkingqueue(var_0, var_1) {
  if(!targetmarkergroupexists(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in var_0.markedentsinqueue) {
    if(var_4 == self) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_0.markedentsinqueue = var_2;
}

targetmarkergroup_handlemarkingfromqueue(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_1);

  while(targetmarkergroupexists(var_1)) {
    level waittill("_encstr_BA261E95371DF5E459B6DB67958CFACC39ED6BFA5BB0935B59E4D7EC9C7BAB83", var_2);

    if(var_2 != var_0) {
      continue;
    }
    if(var_0.markedentsinqueue.size == 0) {
      continue;
    }
    var_3 = undefined;

    if(!isDefined(var_0.markedentsinqueue[0]))
      continue;
    else
      var_3 = var_0.markedentsinqueue[0];

    var_4 = var_3 getentitynumber();

    if(!isDefined(var_0.markedents[var_4])) {
      var_0.markedents[var_4] = 1;
      var_3 targetmarkergroup_removefrommarkingqueue(var_0, var_1);
      targetmarkergroup_markentity(var_3, var_1);
    }
  }
}

targetmarkergroup_unmarkentity(var_0, var_1, var_2) {
  var_3 = gettargetmarkergroup(var_2);

  if(isDefined(var_3) && isDefined(var_3.markedents[var_1])) {
    var_3.markedents[var_1] = undefined;

    if(isDefined(var_0))
      targetmarkergroupsetentitystate(var_2, var_0);

    var_3 notify("_encstr_96310D17DD29B9E061CB8AC4F98B31" + var_1);
    level notify("_encstr_BA261E95371DF5E459B6DB67958CFACC39ED6BFA5BB0935B59E4D7EC9C7BAB83", var_3);
  }
}

targetmarkergroup_getownedgroups(var_0) {
  var_1 = 0;

  foreach(var_3 in level.activetargetmarkergroups) {
    if(var_3.markerowner == var_0)
      var_1++;
  }

  return var_1;
}

_id_13A7C() {
  self setclientomnvar("_encstr_B678185D2DF58DC659B09CFAA3B0E4CEAC8EBEADB093DA564E37", gettime());
}

isteam(var_0) {
  if(var_0 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 1;

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

canbemarkedingroup(var_0, var_1) {
  var_2 = 0;
  var_3 = gettargetmarkergroup(var_0);
  var_4 = var_3.markerowner;
  var_5 = istrue(level.teambased) && isDefined(var_3.friendlymarker);
  var_6 = istrue(var_3.friendlymarker);

  if(!isDefined(var_4))
    return var_2;

  if(var_5) {
    if(var_6) {
      if(var_1.team == var_4.team)
        var_2 = 1;
    } else if(var_1.team != var_4.team)
      var_2 = 1;
  } else if(var_6) {
    if(isPlayer(var_1) && var_1 == var_4)
      var_2 = 1;
  } else
    var_2 = 1;

  return var_2;
}