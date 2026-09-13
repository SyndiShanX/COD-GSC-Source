/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\entityheadicons.gsc
***********************************************/

init() {
  level._id_32FE21B3C5052471 = getdvarint("dvar_8ED0DA01BB4E0C5F", 1);
  level.factionfriendlyheadicon = "hud_icon_head_friendly_sm";
  level.factionenemyheadicon = "hud_icon_head_enemy_sm";

  if(_id_6EDE573723F08C0F()) {
    level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
    level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
  }

  level.activeheadicons = [];
  level._id_00B516ED3ABE09EA = ["hud_icon_death_spawn", "hud_icon_head_friendly_sm", "hud_icon_head_enemy_sm", "hud_icon_new_marked"];
}

setheadicon_singleimage(showto, image, offset, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, _id_74B5B12BB6514385, _id_FA4CF28A58192889, _id_B3EA37733A1577E5, _id_7591ED99E87A77D3, showonminimap) {
  level endon("game_ended");

  if(isDefined(_id_74B5B12BB6514385))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(!isDefined(self)) {
    return;
  }
  icon = setheadicon_createnewicon(undefined, _id_7591ED99E87A77D3);
  setheadiconimage(icon, image);

  if(!isDefined(offset))
    offset = 30;

  setheadiconzoffset(icon, offset);

  if(!isDefined(_id_E0E11F3B4551BE11))
    _id_E0E11F3B4551BE11 = 0;

  setheadicondrawthroughgeo(icon, _id_E0E11F3B4551BE11);

  if(!isDefined(_id_C5409CA7522182B3))
    _id_C5409CA7522182B3 = 0;

  setheadiconmaxdistance(icon, _id_C5409CA7522182B3);

  if(!isDefined(_id_30516B4AFD1763DE))
    _id_30516B4AFD1763DE = 0;

  setheadiconnaturaldistance(icon, _id_30516B4AFD1763DE);

  if(isarray(showto)) {
    foreach(_id_EBCDED206506E726 in showto) {
      if(isPlayer(_id_EBCDED206506E726)) {
        addclienttoheadiconmask(icon, _id_EBCDED206506E726);
        continue;
      }

      if(isDefined(_id_EBCDED206506E726) && isteam(_id_EBCDED206506E726))
        addteamtoheadiconmask(icon, _id_EBCDED206506E726);
    }
  } else if(isPlayer(showto))
    addclienttoheadiconmask(icon, showto);
  else if(isDefined(showto) && isteam(showto))
    addteamtoheadiconmask(icon, showto);

  if(!istrue(_id_FA4CF28A58192889))
    thread setheadicon_watchdeath(icon);

  if(istrue(_id_B3EA37733A1577E5))
    setheadiconsnaptoedges(icon, 1);

  if(istrue(showonminimap))
    setheadicondrawinmap(icon, 1);

  if(istrue(level._id_32FE21B3C5052471) && level.teambased && isDefined(self.team) && _id_0670BC5C30525BF6(image)) {
    setheadiconteam(icon, self.team);
    _func_CE9D0299637C2C24(icon, 1);
  }

  return icon;
}

setheadicon_multiimage(showto, _id_74CE33B771C6CA07, _id_9830D857024187A1, _id_36A93664071874B4, offset, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, _id_74B5B12BB6514385, _id_FA4CF28A58192889, _id_B3EA37733A1577E5, _id_7591ED99E87A77D3, showonminimap) {
  level endon("game_ended");

  if(isDefined(_id_74B5B12BB6514385))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(!isDefined(self)) {
    return;
  }
  icon = setheadicon_createnewicon(undefined, _id_7591ED99E87A77D3);

  if(isDefined(_id_74CE33B771C6CA07))
    setheadiconfriendlyimage(icon, _id_74CE33B771C6CA07);

  if(isDefined(_id_9830D857024187A1))
    setheadiconneutralimage(icon, _id_9830D857024187A1);

  if(isDefined(_id_36A93664071874B4))
    setheadiconenemyimage(icon, _id_36A93664071874B4);

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      setheadicon_deleteicon(icon);
      return;
    }

    if(isDefined(self.owner))
      setheadiconowner(icon, self.owner);

    if(level.teambased && isDefined(self.team))
      setheadiconteam(icon, self.team);
  }

  if(!isDefined(offset))
    offset = 30;

  setheadiconzoffset(icon, offset);

  if(!isDefined(_id_E0E11F3B4551BE11))
    _id_E0E11F3B4551BE11 = 0;

  setheadicondrawthroughgeo(icon, _id_E0E11F3B4551BE11);

  if(!isDefined(_id_C5409CA7522182B3))
    _id_C5409CA7522182B3 = 0;

  setheadiconmaxdistance(icon, _id_C5409CA7522182B3);

  if(!isDefined(_id_30516B4AFD1763DE))
    _id_30516B4AFD1763DE = 0;

  setheadiconnaturaldistance(icon, _id_30516B4AFD1763DE);

  if(isarray(showto)) {
    foreach(_id_EBCDED206506E726 in showto) {
      if(isPlayer(_id_EBCDED206506E726)) {
        addclienttoheadiconmask(icon, _id_EBCDED206506E726);
        continue;
      }

      if(isDefined(_id_EBCDED206506E726) && isteam(_id_EBCDED206506E726))
        addteamtoheadiconmask(icon, _id_EBCDED206506E726);
    }
  } else if(isPlayer(showto))
    addclienttoheadiconmask(icon, showto);
  else if(isDefined(showto) && isteam(showto))
    addteamtoheadiconmask(icon, showto);

  if(!istrue(_id_FA4CF28A58192889))
    thread setheadicon_watchdeath(icon);

  if(istrue(_id_B3EA37733A1577E5))
    setheadiconsnaptoedges(icon, 1);

  if(istrue(showonminimap))
    setheadicondrawinmap(icon, 1);

  return icon;
}

setheadicon_factionimage(showtoallfactions, offset, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, _id_74B5B12BB6514385, _id_FA4CF28A58192889, ownerinvisible, _id_7591ED99E87A77D3, showonminimap) {
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    return;
  }
  level endon("game_ended");

  if(isDefined(_id_74B5B12BB6514385))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(!isDefined(self)) {
    return;
  }
  icon = setheadicon_createnewicon(undefined, _id_7591ED99E87A77D3);
  _id_B7F8C8834DE6D664 = spawnStruct();
  _id_B7F8C8834DE6D664.icon = icon;
  _id_B7F8C8834DE6D664.entowner = self.owner;
  _id_B7F8C8834DE6D664.showtoallfactions = showtoallfactions;
  _id_B7F8C8834DE6D664.ownerinvisible = ownerinvisible;

  if(!isDefined(offset))
    offset = 30;

  setheadiconzoffset(_id_B7F8C8834DE6D664.icon, offset);

  if(!isDefined(_id_E0E11F3B4551BE11))
    _id_E0E11F3B4551BE11 = 0;

  setheadicondrawthroughgeo(_id_B7F8C8834DE6D664.icon, _id_E0E11F3B4551BE11);

  if(!isDefined(_id_C5409CA7522182B3))
    _id_C5409CA7522182B3 = 768;

  setheadiconmaxdistance(_id_B7F8C8834DE6D664.icon, _id_C5409CA7522182B3);

  if(!isDefined(_id_30516B4AFD1763DE))
    _id_30516B4AFD1763DE = 0;

  setheadiconnaturaldistance(_id_B7F8C8834DE6D664.icon, _id_30516B4AFD1763DE);

  if(!istrue(_id_FA4CF28A58192889))
    thread setheadicon_watchdeath(_id_B7F8C8834DE6D664.icon);

  if(istrue(showonminimap))
    setheadicondrawinmap(icon, 1);

  _updateiconowner(_id_B7F8C8834DE6D664);
  thread setheadicon_watchfornewowner(_id_B7F8C8834DE6D664);
  _id_8B82F9F802C09D2D = getdvarint("dvar_264312901607C2AC", 1);

  if(_id_8B82F9F802C09D2D)
    thread setheadicon_watchforteamswitch(_id_B7F8C8834DE6D664);

  return _id_B7F8C8834DE6D664.icon;
}

_updateiconowner(_id_B7F8C8834DE6D664) {
  self notify("_updateIconOwner()");

  if(istrue(_id_B7F8C8834DE6D664.showtoallfactions)) {
    setheadiconfriendlyimage(_id_B7F8C8834DE6D664.icon, level.factionfriendlyheadicon);
    setheadiconneutralimage(_id_B7F8C8834DE6D664.icon, level.factionenemyheadicon);
    setheadiconenemyimage(_id_B7F8C8834DE6D664.icon, level.factionenemyheadicon);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        setheadicon_deleteicon(_id_B7F8C8834DE6D664.icon);
        return;
      }

      if(isDefined(self.owner))
        setheadiconowner(_id_B7F8C8834DE6D664.icon, self.owner);

      if(level.teambased && isDefined(self.team))
        setheadiconteam(_id_B7F8C8834DE6D664.icon, self.team);
    }
  } else {
    image = level.factionfriendlyheadicon;
    setheadiconimage(_id_B7F8C8834DE6D664.icon, image);

    if(istrue(level._id_32FE21B3C5052471) && level.teambased && isDefined(self.team) && _id_0670BC5C30525BF6(image)) {
      setheadiconteam(_id_B7F8C8834DE6D664.icon, self.team);
      _func_CE9D0299637C2C24(_id_B7F8C8834DE6D664.icon, 1);
    }
  }

  foreach(player in level.players)
  removeclientfromheadiconmask(_id_B7F8C8834DE6D664.icon, player);

  if(istrue(_id_B7F8C8834DE6D664.showtoallfactions)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      addclienttoheadiconmask(_id_B7F8C8834DE6D664.icon, player);
    }

    thread setheadicon_watchforlateconnect(_id_B7F8C8834DE6D664.icon);
  } else {
    if(!isDefined(self.owner)) {
      setheadicon_deleteicon(_id_B7F8C8834DE6D664.icon);
      return;
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(level.teambased && player.team != self.owner.team) {
        continue;
      }
      if(!level.teambased && player != self.owner) {
        continue;
      }
      if(istrue(_id_B7F8C8834DE6D664.ownerinvisible) && player == self.owner) {
        continue;
      }
      addclienttoheadiconmask(_id_B7F8C8834DE6D664.icon, player);
    }
  }
}

setheadicon_watchforlateconnect(icon) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self))
    self endon("disconnect");

  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    thread setheadicon_watchforlatespawn(icon, player);
  }
}

setheadicon_watchforlatespawn(icon, player) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self))
    self endon("disconnect");

  level endon("game_ended");

  for(;;) {
    player waittill("spawned_player");
    addclienttoheadiconmask(icon, player);
  }
}

setheadicon_watchfornewowner(_id_B7F8C8834DE6D664) {
  self endon("death");

  if(isPlayer(self))
    self endon("disconnect");

  level endon("game_ended");

  for(;;) {
    if(_id_B7F8C8834DE6D664.entowner != self.owner) {
      _id_B7F8C8834DE6D664.entowner = self.owner;
      _updateiconowner(_id_B7F8C8834DE6D664);
    }

    wait 0.1;
  }
}

setheadicon_watchforteamswitch(_id_B7F8C8834DE6D664) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self endon("death");

  for(;;) {
    level waittill("add_to_team", player);
    removeclientfromheadiconmask(_id_B7F8C8834DE6D664.icon, player);

    if(istrue(_id_B7F8C8834DE6D664.showtoallfactions)) {
      addclienttoheadiconmask(_id_B7F8C8834DE6D664.icon, player);
      continue;
    }

    if(!isDefined(self.owner)) {
      setheadicon_deleteicon(_id_B7F8C8834DE6D664.icon);
      return;
    }

    if(player.team != self.owner.team) {
      continue;
    }
    addclienttoheadiconmask(_id_B7F8C8834DE6D664.icon, player);
  }
}

setheadicon_watchdeath(icon) {
  level endon("game_ended");
  self endon("headicon_deleted");

  if(isPlayer(self) && !isbot(self))
    self waittill("death_or_disconnect");
  else
    self waittill("death");

  setheadicon_deleteicon(icon);
}

isteam(showto) {
  if(showto == "spectator" || showto == "codcaster")
    return 1;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(showto == _id_FABF84450735DD93)
      return 1;
  }

  return 0;
}

setheadicon_createnewicon(prioritygroup, _id_7591ED99E87A77D3) {
  if(!isDefined(prioritygroup))
    prioritygroup = 0;

  if(!setheadicon_allowiconcreation())
    setheadicon_removeoldicon(prioritygroup);

  _id_4D8A0737086AFD98 = undefined;

  if(isDefined(_id_7591ED99E87A77D3))
    _id_4D8A0737086AFD98 = createheadiconatorigin(_id_7591ED99E87A77D3);
  else
    _id_4D8A0737086AFD98 = createheadicon(self);

  if(!isDefined(_id_4D8A0737086AFD98) || _id_4D8A0737086AFD98 < 0) {
    return;
  }
  _id_D89E953F27063A40 = spawnStruct();
  _id_D89E953F27063A40.icon = _id_4D8A0737086AFD98;
  _id_D89E953F27063A40.entmarked = self;
  _id_D89E953F27063A40.prioritygroup = prioritygroup;
  _id_D89E953F27063A40.timecreated = gettime();
  level.activeheadicons[_id_D89E953F27063A40.icon] = _id_D89E953F27063A40;
  return _id_D89E953F27063A40.icon;
}

setheadicon_deleteicon(icon) {
  _id_D89E953F27063A40 = setheadicon_getexistingiconinfo(icon);

  if(isDefined(_id_D89E953F27063A40)) {
    if(isDefined(_id_D89E953F27063A40.entmarked))
      _id_D89E953F27063A40.entmarked notify("headicon_deleted");

    deleteheadicon(_id_D89E953F27063A40.icon);
    level.activeheadicons[_id_D89E953F27063A40.icon] = undefined;
  }
}

setheadicon_allowiconcreation() {
  return level.activeheadicons.size < 1023;
}

setheadicon_getexistingiconinfo(icon) {
  if(!isDefined(icon)) {
    return;
  }
  if(!isDefined(level.activeheadicons[icon])) {
    return;
  }
  return level.activeheadicons[icon];
}

setheadicon_removeoldicon(_id_85C943684CFC2305) {
  _id_52F4CF8472153AD7 = setheadicon_findlowestprioritygroup(_id_85C943684CFC2305);
  _id_9633A62391F17533 = setheadicon_findoldestcreatedicon(_id_52F4CF8472153AD7);
  setheadicon_deleteicon(_id_9633A62391F17533);
}

setheadicon_findlowestprioritygroup(_id_85C943684CFC2305) {
  _id_52F4CF8472153AD7 = _id_85C943684CFC2305;

  foreach(_id_D89E953F27063A40 in level.activeheadicons) {
    if(_id_52F4CF8472153AD7 > _id_D89E953F27063A40.prioritygroup)
      _id_52F4CF8472153AD7 = _id_D89E953F27063A40.prioritygroup;
  }

  return _id_52F4CF8472153AD7;
}

setheadicon_findoldestcreatedicon(_id_49D4316FCE0B35B7) {
  _id_4A38995D4F273F6B = undefined;
  _id_7A69631FD4B42A1F = undefined;

  foreach(_id_D89E953F27063A40 in level.activeheadicons) {
    if(!isDefined(_id_4A38995D4F273F6B) && !isDefined(_id_7A69631FD4B42A1F) || _id_4A38995D4F273F6B.timecreated > _id_D89E953F27063A40.timecreated) {
      _id_4A38995D4F273F6B = _id_D89E953F27063A40;
      _id_7A69631FD4B42A1F = _id_D89E953F27063A40.icon;
    }
  }

  return _id_7A69631FD4B42A1F;
}

setheadicon_addclienttomask(headicon, _id_2C6CA80E296FED3A) {
  _id_D89E953F27063A40 = setheadicon_getexistingiconinfo(headicon);

  if(isDefined(_id_D89E953F27063A40))
    addclienttoheadiconmask(headicon, _id_2C6CA80E296FED3A);
}

setheadicon_removeclientfrommask(headicon, _id_2C6CA80E296FED3A) {
  _id_D89E953F27063A40 = setheadicon_getexistingiconinfo(headicon);

  if(isDefined(_id_D89E953F27063A40))
    removeclientfromheadiconmask(headicon, _id_2C6CA80E296FED3A);
}

_id_0670BC5C30525BF6(_id_D63C50F8A63DC1A5) {
  foreach(name in level._id_00B516ED3ABE09EA) {
    if(name == _id_D63C50F8A63DC1A5)
      return 1;
  }

  return 0;
}

_id_6EDE573723F08C0F() {
  return getdvarint("dvar_1D8C3EB547F8C176", 0);
}