/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\entityheadicons.gsc
***********************************************/

function init() {
  level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
  level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
  level.activeheadicons = [];
}

function setheadicon_singleimage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  level endon("game_ended");

  if(isDefined(var6)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var6);
  }

  if(!isDefined(self)) {
    return;
  }

  var11 = setheadicon_createnewicon(undefined, var9);
  setheadiconfriendlyimage(var11, var1);

  if(!isDefined(var2)) {
    var2 = 30;
  }

  addclienttoheadiconmask(var11, var2);

  if(!isDefined(var3)) {
    var3 = 0;
  }

  setheadiconzoffset(var11, var3);

  if(!isDefined(var4)) {
    var4 = 0;
  }

  setheadiconsnaptoedges(var11, var4);

  if(!isDefined(var5)) {
    var5 = 0;
  }

  setheadiconmaxdistance(var11, var5);

  if(isarray(var0)) {
    foreach(var13 in var0) {
      if(isPlayer(var13)) {
        addteamtoheadiconmask(var11, var13);
        continue;
      }

      if(isDefined(var13) && isteam(var13)) {
        removeclientfromheadiconmask(var11, var13);
      }
    }
  } else if(isPlayer(var0)) {
    addteamtoheadiconmask(var11, var0);
  } else if(isDefined(var0) && isteam(var0)) {
    removeclientfromheadiconmask(var11, var0);
  }

  if(!istrue(var7)) {
    thread setheadicon_watchdeath(var11);
  }

  if(istrue(var8)) {
    setheadicondrawthroughgeo(var11, 1);
  }

  if(istrue(var10)) {
    objective_sethideelevation(var11, 1);
  }

  return var11;
}

function setheadicon_multiimage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  level endon("game_ended");

  if(isDefined(var8)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var8);
  }

  if(!isDefined(self)) {
    return;
  }

  var13 = setheadicon_createnewicon(undefined, var11);

  if(isDefined(var1)) {
    setheadiconenemyimage(var13, var1);
  }

  if(isDefined(var2)) {
    setheadiconnaturaldistance(var13, var2);
  }

  if(isDefined(var3)) {
    setheadiconneutralimage(var13, var3);
  }

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var13);
      return;
    }

    if(isDefined(self.owner)) {
      createtargetmarkergroup(var13, self.owner);
    }

    if(level.teambased && isDefined(self.team)) {
      setheadiconowner(var13, self.team);
    }
  }

  if(!isDefined(var4)) {
    var4 = 30;
  }

  addclienttoheadiconmask(var13, var4);

  if(!isDefined(var5)) {
    var5 = 0;
  }

  setheadiconzoffset(var13, var5);

  if(!isDefined(var6)) {
    var6 = 0;
  }

  setheadiconsnaptoedges(var13, var6);

  if(!isDefined(var7)) {
    var7 = 0;
  }

  setheadiconmaxdistance(var13, var7);

  if(isarray(var0)) {
    foreach(var15 in var0) {
      if(isPlayer(var15)) {
        addteamtoheadiconmask(var13, var15);
        continue;
      }

      if(isDefined(var15) && isteam(var15)) {
        removeclientfromheadiconmask(var13, var15);
      }
    }
  } else if(isPlayer(var0)) {
    addteamtoheadiconmask(var13, var0);
  } else if(isDefined(var0) && isteam(var0)) {
    removeclientfromheadiconmask(var13, var0);
  }

  if(!istrue(var9)) {
    thread setheadicon_watchdeath(var13);
  }

  if(istrue(var10)) {
    setheadicondrawthroughgeo(var13, 1);
  }

  if(istrue(var12)) {
    objective_sethideelevation(var13, 1);
  }

  return var13;
}

function setheadicon_factionimage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }

  level endon("game_ended");

  if(isDefined(var5)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var5);
  }

  if(!isDefined(self)) {
    return;
  }

  var10 = setheadicon_createnewicon(undefined, var8);
  var11 = spawnStruct();
  var11.icon = var10;
  var11.entowner = self.owner;
  var11.showtoallfactions = var0;
  var11.ownerinvisible = var7;

  if(!isDefined(var1)) {
    var1 = 30;
  }

  addclienttoheadiconmask(var11.icon, var1);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  setheadiconzoffset(var11.icon, var2);

  if(!isDefined(var3)) {
    var3 = 768;
  }

  setheadiconsnaptoedges(var11.icon, var3);

  if(!isDefined(var4)) {
    var4 = 0;
  }

  setheadiconmaxdistance(var11.icon, var4);

  if(!istrue(var6)) {
    thread setheadicon_watchdeath(var11.icon);
  }

  if(istrue(var9)) {
    objective_sethideelevation(var10, 1);
  }

  _updateiconowner(var11);
  thread setheadicon_watchfornewowner(var11);
  var12 = getdvarint("scr_headIcon_teamSwitch", 1);

  if(var12) {
    thread setheadicon_watchforteamswitch(var11);
  }

  return var11.icon;
}

function _updateiconowner(var0) {
  self notify("_updateIconOwner()");

  if(istrue(var0.showtoallfactions)) {
    setheadiconenemyimage(var0.icon, level.factionfriendlyheadicon);
    setheadiconnaturaldistance(var0.icon, level.factionenemyheadicon);
    setheadiconneutralimage(var0.icon, level.factionenemyheadicon);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        setheadicon_deleteicon(var0.icon);
        return;
      }

      if(isDefined(self.owner)) {
        createtargetmarkergroup(var0.icon, self.owner);
      }

      if(level.teambased && isDefined(self.team)) {
        setheadiconowner(var0.icon, self.team);
      }
    }
  } else {
    var1 = level.factionfriendlyheadicon;
    setheadiconfriendlyimage(var0.icon, var1);
  }

  foreach(var4, var3 in level.players) {
    removeteamfromheadiconmask(var0.icon, var3);
  }

  if(istrue(var0.showtoallfactions)) {
    foreach(var3 in level.players) {
      if(!isDefined(var3)) {
        continue;
      }

      addteamtoheadiconmask(var0.icon, var3);
    }

    thread setheadicon_watchforlateconnect(var0.icon);
    return;
  }

  if(!isDefined(self.owner) && !isDefined(self.team)) {
    setheadicon_deleteicon(var0.icon);
    return;
  }

  if(isDefined(self.owner)) {
    var7 = self.owner.team;
  } else {
    var7 = self.team;
  }

  foreach(var4 in level.players) {
    if(!isDefined(var4)) {
      continue;
    }

    if(level.teambased && var4.team != var7) {
      continue;
    }

    if(isDefined(self.owner) && !level.teambased && var4 != self.owner) {
      continue;
    }

    if(isDefined(self.owner) && istrue(var2.ownerinvisible) && var4 == self.owner) {
      continue;
    }

    addteamtoheadiconmask(var2.icon, var4);
  }
}

function setheadicon_watchforlateconnect(var0) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    thread setheadicon_watchforlatespawn(var0, var1);
  }
}

function setheadicon_watchforlatespawn(var0, var1) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    var1 waittill("spawned_player");
    addteamtoheadiconmask(var0, var1);
  }
}

function setheadicon_watchfornewowner(var0) {
  self endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    if(var0.entowner != self.owner) {
      var0.entowner = self.owner;
      _updateiconowner(var0);
    }

    wait 0.1;
  }
}

function setheadicon_watchforteamswitch(var0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self endon("death");

  for(;;) {
    level waittill("add_to_team", var1);
    removeteamfromheadiconmask(var0.icon, var1);

    if(istrue(var0.showtoallfactions)) {
      addteamtoheadiconmask(var0.icon, var1);
      continue;
    }

    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var0.icon);
      return;
    }

    if(isDefined(self.owner)) {
      var2 = self.owner.team;
    } else {
      var2 = self.team;
    }

    if(var1.team != var2) {
      continue;
    }

    addteamtoheadiconmask(var0.icon, var1);
  }
}

function setheadicon_watchdeath(var0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self waittill("death_or_disconnect");
  setheadicon_deleteicon(var0);
}

function isteam(var0) {
  if(var0 == "spectator" || var0 == "follower") {
    return true;
  }

  foreach(var2 in level.teamnamelist) {
    if(var0 == var2) {
      return true;
    }
  }

  return false;
}

function setheadicon_createnewicon(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!setheadicon_allowiconcreation()) {
    setheadicon_removeoldicon(var0);
  }

  var2 = undefined;

  if(isDefined(var1)) {
    var2 = setheadicondrawinmap(var1);
  } else {
    var2 = deleteheadicon(self);
  }

  if(!isDefined(var2) || var2 < 0) {
    return;
  }

  var4 = spawnStruct();
  var4.icon = var2;
  var4.entmarked = self;
  var4.prioritygroup = var0;
  var4.timecreated = gettime();
  level.activeheadicons[var4.icon] = var4;
  return var4.icon;
}

function setheadicon_deleteicon(var0) {
  var1 = setheadicon_getexistingiconinfo(var0);

  if(isDefined(var1)) {
    if(isDefined(var1.entmarked)) {
      var1.entmarked notify("headicon_deleted");
    }

    setheadiconimage(var1.icon);
    level.activeheadicons[var1.icon] = undefined;
    return;
  }
}

function setheadicon_allowiconcreation() {
  return level.activeheadicons.size < 1023;
}

function setheadicon_getexistingiconinfo(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(level.activeheadicons[var0])) {
    return;
  }

  return level.activeheadicons[var0];
}

function setheadicon_removeoldicon(var0) {
  var1 = setheadicon_findlowestprioritygroup(var0);
  var2 = setheadicon_findoldestcreatedicon(var1);
  setheadicon_deleteicon(var2);
}

function setheadicon_findlowestprioritygroup(var0) {
  var1 = var0;

  foreach(var3 in level.activeheadicons) {
    if(var1 > var3.prioritygroup) {
      var1 = var3.prioritygroup;
    }
  }

  return var1;
}

function setheadicon_findoldestcreatedicon(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.activeheadicons) {
    if(!isDefined(var1) && !isDefined(var2) || var1.timecreated > var4.timecreated) {
      var1 = var4;
      var2 = var4.icon;
    }
  }

  return var2;
}

function ref_1315d(var0, var1) {
  var2 = setheadicon_getexistingiconinfo(var0);

  if(isDefined(var2)) {
    addteamtoheadiconmask(var0, var1);
    return;
  }
}

function ref_1315e(var0, var1) {
  var2 = setheadicon_getexistingiconinfo(var0);

  if(isDefined(var2)) {
    removeteamfromheadiconmask(var0, var1);
    return;
  }
}