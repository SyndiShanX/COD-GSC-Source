/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\entityheadicons.gsc
***********************************************/

function init() {
  level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
  level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
  level.activeheadicons = [];
}

function setheadicon_singleimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level endon("game_ended");

  if(isDefined(var_6)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);
  }

  if(!isDefined(self)) {
    return;
  }

  var_11 = setheadicon_createnewicon(undefined, var_9);
  setheadiconfriendlyimage(var_11, var_1);

  if(!isDefined(var_2)) {
    var_2 = 30;
  }

  addclienttoheadiconmask(var_11, var_2);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  setheadiconzoffset(var_11, var_3);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  setheadiconsnaptoedges(var_11, var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  setheadiconmaxdistance(var_11, var_5);

  if(isarray(var_0)) {
    foreach(var_13 in var_0) {
      if(isPlayer(var_13)) {
        addteamtoheadiconmask(var_11, var_13);
        continue;
      }

      if(isDefined(var_13) && isteam(var_13)) {
        removeclientfromheadiconmask(var_11, var_13);
      }
    }
  } else if(isPlayer(var_0)) {
    addteamtoheadiconmask(var_11, var_0);
  } else if(isDefined(var_0) && isteam(var_0)) {
    removeclientfromheadiconmask(var_11, var_0);
  }

  if(!istrue(var_7)) {
    thread setheadicon_watchdeath(var_11);
  }

  if(istrue(var_8)) {
    setheadicondrawthroughgeo(var_11, 1);
  }

  if(istrue(var_10)) {
    objective_sethideelevation(var_11, 1);
  }

  return var_11;
}

function setheadicon_multiimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level endon("game_ended");

  if(isDefined(var_8)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_8);
  }

  if(!isDefined(self)) {
    return;
  }

  var_13 = setheadicon_createnewicon(undefined, var_11);

  if(isDefined(var_1)) {
    setheadiconenemyimage(var_13, var_1);
  }

  if(isDefined(var_2)) {
    setheadiconnaturaldistance(var_13, var_2);
  }

  if(isDefined(var_3)) {
    setheadiconneutralimage(var_13, var_3);
  }

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var_13);
      return;
    }

    if(isDefined(self.owner)) {
      createtargetmarkergroup(var_13, self.owner);
    }

    if(level.teambased && isDefined(self.team)) {
      setheadiconowner(var_13, self.team);
    }
  }

  if(!isDefined(var_4)) {
    var_4 = 30;
  }

  addclienttoheadiconmask(var_13, var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  setheadiconzoffset(var_13, var_5);

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  setheadiconsnaptoedges(var_13, var_6);

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  setheadiconmaxdistance(var_13, var_7);

  if(isarray(var_0)) {
    foreach(var_15 in var_0) {
      if(isPlayer(var_15)) {
        addteamtoheadiconmask(var_13, var_15);
        continue;
      }

      if(isDefined(var_15) && isteam(var_15)) {
        removeclientfromheadiconmask(var_13, var_15);
      }
    }
  } else if(isPlayer(var_0)) {
    addteamtoheadiconmask(var_13, var_0);
  } else if(isDefined(var_0) && isteam(var_0)) {
    removeclientfromheadiconmask(var_13, var_0);
  }

  if(!istrue(var_9)) {
    thread setheadicon_watchdeath(var_13);
  }

  if(istrue(var_10)) {
    setheadicondrawthroughgeo(var_13, 1);
  }

  if(istrue(var_12)) {
    objective_sethideelevation(var_13, 1);
  }

  return var_13;
}

function setheadicon_factionimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }

  level endon("game_ended");

  if(isDefined(var_5)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  }

  if(!isDefined(self)) {
    return;
  }

  var_10 = setheadicon_createnewicon(undefined, var_8);
  var_11 = spawnStruct();
  var_11.icon = var_10;
  var_11.entowner = self.owner;
  var_11.showtoallfactions = var_0;
  var_11.ownerinvisible = var_7;

  if(!isDefined(var_1)) {
    var_1 = 30;
  }

  addclienttoheadiconmask(var_11.icon, var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  setheadiconzoffset(var_11.icon, var_2);

  if(!isDefined(var_3)) {
    var_3 = 768;
  }

  setheadiconsnaptoedges(var_11.icon, var_3);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  setheadiconmaxdistance(var_11.icon, var_4);

  if(!istrue(var_6)) {
    thread setheadicon_watchdeath(var_11.icon);
  }

  if(istrue(var_9)) {
    objective_sethideelevation(var_10, 1);
  }

  _updateiconowner(var_11);
  thread setheadicon_watchfornewowner(var_11);
  var_12 = getdvarint("scr_headIcon_teamSwitch", 1);

  if(var_12) {
    thread setheadicon_watchforteamswitch(var_11);
  }

  return var_11.icon;
}

function _updateiconowner(var_0) {
  self notify("_updateIconOwner()");

  if(istrue(var_0.showtoallfactions)) {
    setheadiconenemyimage(var_0.icon, level.factionfriendlyheadicon);
    setheadiconnaturaldistance(var_0.icon, level.factionenemyheadicon);
    setheadiconneutralimage(var_0.icon, level.factionenemyheadicon);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        setheadicon_deleteicon(var_0.icon);
        return;
      }

      if(isDefined(self.owner)) {
        createtargetmarkergroup(var_0.icon, self.owner);
      }

      if(level.teambased && isDefined(self.team)) {
        setheadiconowner(var_0.icon, self.team);
      }
    }
  } else {
    var_1 = level.factionfriendlyheadicon;
    setheadiconfriendlyimage(var_0.icon, var_1);
  }

  foreach(var_4, var_3 in level.players) {
    removeteamfromheadiconmask(var_0.icon, var_3);
  }

  if(istrue(var_0.showtoallfactions)) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }

      addteamtoheadiconmask(var_0.icon, var_3);
    }

    thread setheadicon_watchforlateconnect(var_0.icon);
    return;
  }

  if(!isDefined(self.owner) && !isDefined(self.team)) {
    setheadicon_deleteicon(var_0.icon);
    return;
  }

  if(isDefined(self.owner)) {
    var_7 = self.owner.team;
  } else {
    var_7 = self.team;
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(level.teambased && var_4.team != var_7) {
      continue;
    }

    if(isDefined(self.owner) && !level.teambased && var_4 != self.owner) {
      continue;
    }

    if(isDefined(self.owner) && istrue(var_2.ownerinvisible) && var_4 == self.owner) {
      continue;
    }

    addteamtoheadiconmask(var_2.icon, var_4);
  }
}

function setheadicon_watchforlateconnect(var_0) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    thread setheadicon_watchforlatespawn(var_0, var_1);
  }
}

function setheadicon_watchforlatespawn(var_0, var_1) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    var_1 waittill("spawned_player");
    addteamtoheadiconmask(var_0, var_1);
  }
}

function setheadicon_watchfornewowner(var_0) {
  self endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    if(var_0.entowner != self.owner) {
      var_0.entowner = self.owner;
      _updateiconowner(var_0);
    }

    wait 0.1;
  }
}

function setheadicon_watchforteamswitch(var_0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self endon("death");

  for(;;) {
    level waittill("add_to_team", var_1);
    removeteamfromheadiconmask(var_0.icon, var_1);

    if(istrue(var_0.showtoallfactions)) {
      addteamtoheadiconmask(var_0.icon, var_1);
      continue;
    }

    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var_0.icon);
      return;
    }

    if(isDefined(self.owner)) {
      var_2 = self.owner.team;
    } else {
      var_2 = self.team;
    }

    if(var_1.team != var_2) {
      continue;
    }

    addteamtoheadiconmask(var_0.icon, var_1);
  }
}

function setheadicon_watchdeath(var_0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self waittill("death_or_disconnect");
  setheadicon_deleteicon(var_0);
}

function isteam(var_0) {
  if(var_0 == "spectator" || var_0 == "follower") {
    return true;
  }

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2) {
      return true;
    }
  }

  return false;
}

function setheadicon_createnewicon(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!setheadicon_allowiconcreation()) {
    setheadicon_removeoldicon(var_0);
  }

  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = setheadicondrawinmap(var_1);
  } else {
    var_2 = deleteheadicon(self);
  }

  if(!isDefined(var_2) || var_2 < 0) {
    return;
  }

  var_4 = spawnStruct();
  var_4.icon = var_2;
  var_4.entmarked = self;
  var_4.prioritygroup = var_0;
  var_4.timecreated = gettime();
  level.activeheadicons[var_4.icon] = var_4;
  return var_4.icon;
}

function setheadicon_deleteicon(var_0) {
  var_1 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_1.entmarked)) {
      var_1.entmarked notify("headicon_deleted");
    }

    setheadiconimage(var_1.icon);
    level.activeheadicons[var_1.icon] = undefined;
    return;
  }
}

function setheadicon_allowiconcreation() {
  return level.activeheadicons.size < 1023;
}

function setheadicon_getexistingiconinfo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.activeheadicons[var_0])) {
    return;
  }

  return level.activeheadicons[var_0];
}

function setheadicon_removeoldicon(var_0) {
  var_1 = setheadicon_findlowestprioritygroup(var_0);
  var_2 = setheadicon_findoldestcreatedicon(var_1);
  setheadicon_deleteicon(var_2);
}

function setheadicon_findlowestprioritygroup(var_0) {
  var_1 = var_0;

  foreach(var_3 in level.activeheadicons) {
    if(var_1 > var_3.prioritygroup) {
      var_1 = var_3.prioritygroup;
    }
  }

  return var_1;
}

function setheadicon_findoldestcreatedicon(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.activeheadicons) {
    if(!isDefined(var_1) && !isDefined(var_2) || var_1.timecreated > var_4.timecreated) {
      var_1 = var_4;
      var_2 = var_4.icon;
    }
  }

  return var_2;
}

function ref_1315D(var_0, var_1) {
  var_2 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_2)) {
    addteamtoheadiconmask(var_0, var_1);
    return;
  }
}

function ref_1315E(var_0, var_1) {
  var_2 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_2)) {
    removeteamfromheadiconmask(var_0, var_1);
    return;
  }
}