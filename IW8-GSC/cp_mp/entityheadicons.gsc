/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\entityheadicons.gsc
***********************************************/

init() {
  level.factionfriendlyheadicon = "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118";
  level.factionenemyheadicon = "_encstr_A6371ED0BAC8D74B6C7BE6BE43AC58C8AFCA17575A0E5B2B73E8BE56E656B697";
  level.activeheadicons = [];
}

setheadicon_singleimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_6))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);

  if(!isDefined(self)) {
    return;
  }
  var_11 = setheadicon_createnewicon(undefined, var_9);
  setheadiconfriendlyimage(var_11, var_1);

  if(!isDefined(var_2))
    var_2 = 30;

  addclienttoheadiconmask(var_11, var_2);

  if(!isDefined(var_3))
    var_3 = 0;

  setheadiconzoffset(var_11, var_3);

  if(!isDefined(var_4))
    var_4 = 0;

  setheadiconsnaptoedges(var_11, var_4);

  if(!isDefined(var_5))
    var_5 = 0;

  setheadiconmaxdistance(var_11, var_5);

  if(isarray(var_0)) {
    foreach(var_13 in var_0) {
      if(isPlayer(var_13)) {
        addteamtoheadiconmask(var_11, var_13);
        continue;
      }

      if(isDefined(var_13) && isteam(var_13))
        removeclientfromheadiconmask(var_11, var_13);
    }
  } else if(isPlayer(var_0))
    addteamtoheadiconmask(var_11, var_0);
  else if(isDefined(var_0) && isteam(var_0))
    removeclientfromheadiconmask(var_11, var_0);

  if(!istrue(var_7))
    thread setheadicon_watchdeath(var_11);

  if(istrue(var_8))
    setheadicondrawthroughgeo(var_11, 1);

  if(istrue(var_10))
    objective_sethideelevation(var_11, 1);

  return var_11;
}

setheadicon_multiimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_8))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_8);

  if(!isDefined(self)) {
    return;
  }
  var_13 = setheadicon_createnewicon(undefined, var_11);

  if(isDefined(var_1))
    setheadiconenemyimage(var_13, var_1);

  if(isDefined(var_2))
    setheadiconnaturaldistance(var_13, var_2);

  if(isDefined(var_3))
    setheadiconneutralimage(var_13, var_3);

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var_13);
      return;
    }

    if(isDefined(self.owner))
      createtargetmarkergroup(var_13, self.owner);

    if(level.teambased && isDefined(self.team))
      setheadiconowner(var_13, self.team);
  }

  if(!isDefined(var_4))
    var_4 = 30;

  addclienttoheadiconmask(var_13, var_4);

  if(!isDefined(var_5))
    var_5 = 0;

  setheadiconzoffset(var_13, var_5);

  if(!isDefined(var_6))
    var_6 = 0;

  setheadiconsnaptoedges(var_13, var_6);

  if(!isDefined(var_7))
    var_7 = 0;

  setheadiconmaxdistance(var_13, var_7);

  if(isarray(var_0)) {
    foreach(var_15 in var_0) {
      if(isPlayer(var_15)) {
        addteamtoheadiconmask(var_13, var_15);
        continue;
      }

      if(isDefined(var_15) && isteam(var_15))
        removeclientfromheadiconmask(var_13, var_15);
    }
  } else if(isPlayer(var_0))
    addteamtoheadiconmask(var_13, var_0);
  else if(isDefined(var_0) && isteam(var_0))
    removeclientfromheadiconmask(var_13, var_0);

  if(!istrue(var_9))
    thread setheadicon_watchdeath(var_13);

  if(istrue(var_10))
    setheadicondrawthroughgeo(var_13, 1);

  if(istrue(var_12))
    objective_sethideelevation(var_13, 1);

  return var_13;
}

setheadicon_factionimage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_5))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);

  if(!isDefined(self)) {
    return;
  }
  var_10 = setheadicon_createnewicon(undefined, var_8);
  var_11 = spawnStruct();
  var_11.icon = var_10;
  var_11.entowner = self.owner;
  var_11.showtoallfactions = var_0;
  var_11.ownerinvisible = var_7;

  if(!isDefined(var_1))
    var_1 = 30;

  addclienttoheadiconmask(var_11.icon, var_1);

  if(!isDefined(var_2))
    var_2 = 0;

  setheadiconzoffset(var_11.icon, var_2);

  if(!isDefined(var_3))
    var_3 = 768;

  setheadiconsnaptoedges(var_11.icon, var_3);

  if(!isDefined(var_4))
    var_4 = 0;

  setheadiconmaxdistance(var_11.icon, var_4);

  if(!istrue(var_6))
    thread setheadicon_watchdeath(var_11.icon);

  if(istrue(var_9))
    objective_sethideelevation(var_10, 1);

  _updateiconowner(var_11);
  thread setheadicon_watchfornewowner(var_11);
  var_12 = getdvarint("_encstr_A7281837C6E4AF0D562C46926CBD9BF58E562CD6A9DD5A3AC6A1", 1);

  if(var_12)
    thread setheadicon_watchforteamswitch(var_11);

  return var_11.icon;
}

_updateiconowner(var_0) {
  self notify("_encstr_96E813887B23E9316C874118479E0C372AE7968BC4");

  if(istrue(var_0.showtoallfactions)) {
    setheadiconenemyimage(var_0.icon, level.factionfriendlyheadicon);
    setheadiconnaturaldistance(var_0.icon, level.factionenemyheadicon);
    setheadiconneutralimage(var_0.icon, level.factionenemyheadicon);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        setheadicon_deleteicon(var_0.icon);
        return;
      }

      if(isDefined(self.owner))
        createtargetmarkergroup(var_0.icon, self.owner);

      if(level.teambased && isDefined(self.team))
        setheadiconowner(var_0.icon, self.team);
    }
  } else {
    var_1 = level.factionfriendlyheadicon;
    setheadiconfriendlyimage(var_0.icon, var_1);
  }

  foreach(var_3 in level.players)
  removeteamfromheadiconmask(var_0.icon, var_3);

  if(istrue(var_0.showtoallfactions)) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      addteamtoheadiconmask(var_0.icon, var_3);
    }

    thread setheadicon_watchforlateconnect(var_0.icon);
  } else {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var_0.icon);
      return;
    }

    if(isDefined(self.owner))
      var_7 = self.owner.team;
    else
      var_7 = self.team;

    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(level.teambased && var_3.team != var_7) {
        continue;
      }
      if(isDefined(self.owner) && !level.teambased && var_3 != self.owner) {
        continue;
      }
      if(isDefined(self.owner) && istrue(var_0.ownerinvisible) && var_3 == self.owner) {
        continue;
      }
      addteamtoheadiconmask(var_0.icon, var_3);
    }
  }
}

setheadicon_watchforlateconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_96E813887B23E9316C874118479E0C372AE7968BC4");

  if(isPlayer(self))
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    thread setheadicon_watchforlatespawn(var_0, var_1);
  }
}

setheadicon_watchforlatespawn(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_96E813887B23E9316C874118479E0C372AE7968BC4");

  if(isPlayer(self))
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    addteamtoheadiconmask(var_0, var_1);
  }
}

setheadicon_watchfornewowner(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isPlayer(self))
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(var_0.entowner != self.owner) {
      var_0.entowner = self.owner;
      _updateiconowner(var_0);
    }

    wait 0.1;
  }
}

setheadicon_watchforteamswitch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A25E1170626EF110CF2778F804FFF84B93CA88");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_B1750C47E049978B0F78C3BF5F23", var_1);
    removeteamfromheadiconmask(var_0.icon, var_1);

    if(istrue(var_0.showtoallfactions)) {
      addteamtoheadiconmask(var_0.icon, var_1);
      continue;
    }

    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(var_0.icon);
      return;
    }

    if(isDefined(self.owner))
      var_2 = self.owner.team;
    else
      var_2 = self.team;

    if(var_1.team != var_2) {
      continue;
    }
    addteamtoheadiconmask(var_0.icon, var_1);
  }
}

setheadicon_watchdeath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A25E1170626EF110CF2778F804FFF84B93CA88");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  setheadicon_deleteicon(var_0);
}

isteam(var_0) {
  if(var_0 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0 == "_encstr_933E090A10B17DDFB3E522")
    return 1;

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

setheadicon_createnewicon(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!setheadicon_allowiconcreation())
    setheadicon_removeoldicon(var_0);

  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = setheadicondrawinmap(var_1);
  else
    var_2 = deleteheadicon(self);

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

setheadicon_deleteicon(var_0) {
  var_1 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_1.entmarked))
      var_1.entmarked notify("_encstr_A25E1170626EF110CF2778F804FFF84B93CA88");

    setheadiconimage(var_1.icon);
    level.activeheadicons[var_1.icon] = undefined;
  }
}

setheadicon_allowiconcreation() {
  return level.activeheadicons.size < 1023;
}

setheadicon_getexistingiconinfo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.activeheadicons[var_0])) {
    return;
  }
  return level.activeheadicons[var_0];
}

setheadicon_removeoldicon(var_0) {
  var_1 = setheadicon_findlowestprioritygroup(var_0);
  var_2 = setheadicon_findoldestcreatedicon(var_1);
  setheadicon_deleteicon(var_2);
}

setheadicon_findlowestprioritygroup(var_0) {
  var_1 = var_0;

  foreach(var_3 in level.activeheadicons) {
    if(var_1 > var_3.prioritygroup)
      var_1 = var_3.prioritygroup;
  }

  return var_1;
}

setheadicon_findoldestcreatedicon(var_0) {
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

_id_1315D(var_0, var_1) {
  var_2 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_2))
    addteamtoheadiconmask(var_0, var_1);
}

_id_1315E(var_0, var_1) {
  var_2 = setheadicon_getexistingiconinfo(var_0);

  if(isDefined(var_2))
    removeteamfromheadiconmask(var_0, var_1);
}