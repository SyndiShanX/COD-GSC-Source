/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\entityheadicons.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace entityheadicons;

function init() {
  issharedfuncdefined("<dev string:x1c>", "<dev string:x2d>", 1);

  level.var_32fe21b3c5052471 = getdvarint(@ "hash_8ed0da01bb4e0c5f", 1);
  level.factionfriendlyheadicon = "hud_icon_head_friendly_sm";
  level.factionenemyheadicon = "hud_icon_head_enemy_sm";

  if(function_6ede573723f08c0f()) {
    level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
    level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
  }

  level.activeheadicons = [];
  level.var_b516ed3abe09ea = ["hud_icon_death_spawn", "hud_icon_head_friendly_sm", "hud_icon_head_enemy_sm", "hud_icon_new_marked"];
}

function setheadicon_singleimage(showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap, iconsize) {
  level endon("game_ended");

  if(isDefined(delaytime)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  }

  if(!isDefined(self)) {
    return;
  }

  icon = setheadicon_createnewicon(undefined, overrideorigin);
  setheadiconimage(icon, image);

  if(!isDefined(offset)) {
    offset = 30;
  }

  setheadiconzoffset(icon, offset);

  if(!isDefined(drawthroughgeo)) {
    drawthroughgeo = 0;
  }

  setheadicondrawthroughgeo(icon, drawthroughgeo);

  if(!isDefined(maxdrawdist)) {
    maxdrawdist = 0;
  }

  setheadiconmaxdistance(icon, maxdrawdist);

  if(!isDefined(naturaldist)) {
    naturaldist = 0;
  }

  setheadiconnaturaldistance(icon, naturaldist);

  if(isarray(showto)) {
    foreach(showtoent in showto) {
      if(isPlayer(showtoent)) {
        addclienttoheadiconmask(icon, showtoent);
        continue;
      }

      if(isDefined(showtoent) && isteam(showtoent)) {
        addteamtoheadiconmask(icon, showtoent);
      }
    }
  } else if(isPlayer(showto)) {
    addclienttoheadiconmask(icon, showto);
  } else if(isDefined(showto) && isteam(showto)) {
    addteamtoheadiconmask(icon, showto);
  }

  if(!istrue(var_fa4cf28a58192889)) {
    thread setheadicon_watchdeath(icon);
  }

  if(istrue(var_b3ea37733a1577e5)) {
    setheadiconsnaptoedges(icon, 1);
  }

  if(istrue(showonminimap)) {
    setheadicondrawinmap(icon, 1);
  }

  if(istrue(level.var_32fe21b3c5052471) && level.teambased && isDefined(self.team) && function_670bc5c30525bf6(image)) {
    setheadiconteam(icon, self.team);
    function_ce9d0299637c2c24(icon, 1);
  }

  if(isDefined(iconsize)) {
    function_ddfa1aae9717e4d9(icon, iconsize);
  }

  return icon;
}

function setheadicon_multiimage(showto, friendlyimage, neutralimage, enemyimage, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap) {
  level endon("game_ended");

  if(isDefined(delaytime)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  }

  if(!isDefined(self)) {
    return;
  }

  icon = setheadicon_createnewicon(undefined, overrideorigin);

  if(isDefined(friendlyimage)) {
    setheadiconfriendlyimage(icon, friendlyimage);
  }

  if(isDefined(neutralimage)) {
    setheadiconneutralimage(icon, neutralimage);
  }

  if(isDefined(enemyimage)) {
    setheadiconenemyimage(icon, enemyimage);
  }

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      assertmsg("<dev string:x4a>");
      setheadicon_deleteicon(icon);
      return;
    }

    if(isDefined(self.owner)) {
      setheadiconowner(icon, self.owner);
    }

    if(level.teambased && isDefined(self.team)) {
      setheadiconteam(icon, self.team);
    }
  }

  if(!isDefined(offset)) {
    offset = 30;
  }

  setheadiconzoffset(icon, offset);

  if(!isDefined(drawthroughgeo)) {
    drawthroughgeo = 0;
  }

  setheadicondrawthroughgeo(icon, drawthroughgeo);

  if(!isDefined(maxdrawdist)) {
    maxdrawdist = 0;
  }

  setheadiconmaxdistance(icon, maxdrawdist);

  if(!isDefined(naturaldist)) {
    naturaldist = 0;
  }

  setheadiconnaturaldistance(icon, naturaldist);

  if(isarray(showto)) {
    foreach(showtoent in showto) {
      if(isPlayer(showtoent)) {
        addclienttoheadiconmask(icon, showtoent);
        continue;
      }

      if(isDefined(showtoent) && isteam(showtoent)) {
        addteamtoheadiconmask(icon, showtoent);
      }
    }
  } else if(isPlayer(showto)) {
    addclienttoheadiconmask(icon, showto);
  } else if(isDefined(showto) && isteam(showto)) {
    addteamtoheadiconmask(icon, showto);
  }

  if(!istrue(var_fa4cf28a58192889)) {
    thread setheadicon_watchdeath(icon);
  }

  if(istrue(var_b3ea37733a1577e5)) {
    setheadiconsnaptoedges(icon, 1);
  }

  if(istrue(showonminimap)) {
    setheadicondrawinmap(icon, 1);
  }

  return icon;
}

function setheadicon_factionimage(showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, ownerinvisible, overrideorigin, showonminimap) {
  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    return;
  }

  level endon("game_ended");

  if(isDefined(delaytime)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  }

  if(!isDefined(self)) {
    return;
  }

  icon = setheadicon_createnewicon(undefined, overrideorigin);
  icondata = spawnStruct();
  icondata.icon = icon;
  icondata.entowner = self.owner;
  icondata.showtoallfactions = showtoallfactions;
  icondata.ownerinvisible = ownerinvisible;

  if(!isDefined(offset)) {
    offset = 30;
  }

  setheadiconzoffset(icondata.icon, offset);

  if(!isDefined(drawthroughgeo)) {
    drawthroughgeo = 0;
  }

  setheadicondrawthroughgeo(icondata.icon, drawthroughgeo);

  if(!isDefined(maxdrawdist)) {
    maxdrawdist = 768;
  }

  setheadiconmaxdistance(icondata.icon, maxdrawdist);

  if(!isDefined(naturaldist)) {
    naturaldist = 0;
  }

  setheadiconnaturaldistance(icondata.icon, naturaldist);

  if(!istrue(var_fa4cf28a58192889)) {
    thread setheadicon_watchdeath(icondata.icon);
  }

  if(istrue(showonminimap)) {
    setheadicondrawinmap(icon, 1);
  }

  _updateiconowner(icondata);
  thread setheadicon_watchfornewowner(icondata);
  useteamswitch = getdvarint(@ "hash_264312901607c2ac", 1);

  if(useteamswitch) {
    thread setheadicon_watchforteamswitch(icondata);
  }

  return icondata.icon;
}

function _updateiconowner(icondata) {
  self notify("_updateIconOwner()");

  if(istrue(icondata.showtoallfactions)) {
    setheadiconfriendlyimage(icondata.icon, level.factionfriendlyheadicon);
    setheadiconneutralimage(icondata.icon, level.factionenemyheadicon);
    setheadiconenemyimage(icondata.icon, level.factionenemyheadicon);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        assertmsg("<dev string:xaf>");
        setheadicon_deleteicon(icondata.icon);
        return;
      }

      if(isDefined(self.owner)) {
        setheadiconowner(icondata.icon, self.owner);
      }

      if(level.teambased && isDefined(self.team)) {
        setheadiconteam(icondata.icon, self.team);
      }
    }
  } else {
    image = level.factionfriendlyheadicon;
    setheadiconimage(icondata.icon, image);

    if(istrue(level.var_32fe21b3c5052471) && level.teambased && isDefined(self.team) && function_670bc5c30525bf6(image)) {
      setheadiconteam(icondata.icon, self.team);
      function_ce9d0299637c2c24(icondata.icon, 1);
    }
  }

  foreach(player in level.players) {
    removeclientfromheadiconmask(icondata.icon, player);
  }

  if(istrue(icondata.showtoallfactions)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      addclienttoheadiconmask(icondata.icon, player);
    }

    thread setheadicon_watchforlateconnect(icondata.icon);
    return;
  }

  if(!isDefined(self.owner)) {
    assertmsg("<dev string:x128>");
    setheadicon_deleteicon(icondata.icon);
    return;
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(level.teambased && isDefined(self.owner.team) && player.team != self.owner.team) {
      continue;
    }

    if(!level.teambased && player != self.owner) {
      continue;
    }

    if(istrue(icondata.ownerinvisible) && player == self.owner) {
      continue;
    }

    addclienttoheadiconmask(icondata.icon, player);
  }
}

function setheadicon_watchforlateconnect(icon) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    thread setheadicon_watchforlatespawn(icon, player);
  }
}

function setheadicon_watchforlatespawn(icon, player) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  while(true) {
    player waittill("spawned_player");
    addclienttoheadiconmask(icon, player);
  }
}

function setheadicon_watchfornewowner(icondata) {
  self endon("death");
  self endon("headicon_deleted");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  while(true) {
    if(icondata.entowner != self.owner) {
      icondata.entowner = self.owner;
      _updateiconowner(icondata);
    }

    wait 0.1;
  }
}

function setheadicon_watchforteamswitch(icondata) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self endon("death");

  while(true) {
    level waittill("add_to_team", player);
    removeclientfromheadiconmask(icondata.icon, player);

    if(istrue(icondata.showtoallfactions)) {
      addclienttoheadiconmask(icondata.icon, player);
      continue;
    }

    if(!isDefined(self.owner)) {
      setheadicon_deleteicon(icondata.icon);
      return;
    }

    if(player.team != self.owner.team) {
      continue;
    }

    addclienttoheadiconmask(icondata.icon, player);
  }
}

function setheadicon_watchdeath(icon) {
  level endon("game_ended");
  self endon("headicon_deleted");

  if(isPlayer(self) && !isbot(self)) {
    self waittill("death_or_disconnect");
  } else {
    self waittill("death");
  }

  setheadicon_deleteicon(icon);
}

function isteam(showto) {
  if(showto == "spectator" || showto == "codcaster") {
    return true;
  }

  foreach(teamname in level.teamnamelist) {
    if(showto == teamname) {
      return true;
    }
  }

  return false;
}

function setheadicon_createnewicon(prioritygroup, overrideorigin) {
  if(!isDefined(prioritygroup)) {
    prioritygroup = 0;
  }

  if(!setheadicon_allowiconcreation()) {
    setheadicon_removeoldicon(prioritygroup);
  }

  newicon = undefined;

  if(isDefined(overrideorigin)) {
    newicon = createheadiconatorigin(overrideorigin);
  } else {
    newicon = createheadicon(self);
  }

  if(!isDefined(newicon) || newicon < 0) {
    enttonotify = self;

    if(isDefined(self.owner)) {
      enttonotify = self.owner;
    }

    enttonotify iprintlnbold("<dev string:x1a1>");

    return;
  }

  iconinfo = spawnStruct();
  iconinfo.icon = newicon;
  iconinfo.entmarked = self;
  iconinfo.prioritygroup = prioritygroup;
  iconinfo.timecreated = gettime();
  level.activeheadicons[iconinfo.icon] = iconinfo;
  return iconinfo.icon;
}

function setheadicon_deleteicon(icon) {
  iconinfo = setheadicon_getexistingiconinfo(icon);

  if(isDefined(iconinfo)) {
    if(isDefined(iconinfo.entmarked)) {
      iconinfo.entmarked notify("headicon_deleted");
    }

    deleteheadicon(iconinfo.icon);
    level.activeheadicons[iconinfo.icon] = undefined;
  }
}

function setheadicon_allowiconcreation() {
  return level.activeheadicons.size < 1023;
}

function setheadicon_getexistingiconinfo(icon) {
  if(!isDefined(icon)) {
    return;
  }

  if(!isDefined(level.activeheadicons[icon])) {
    return;
  }

  return level.activeheadicons[icon];
}

function setheadicon_removeoldicon(var_85c943684cfc2305) {
  lowestpriority = setheadicon_findlowestprioritygroup(var_85c943684cfc2305);
  oldestcreatedicon = setheadicon_findoldestcreatedicon(lowestpriority);
  setheadicon_deleteicon(oldestcreatedicon);
}

function setheadicon_findlowestprioritygroup(var_85c943684cfc2305) {
  lowestpriority = var_85c943684cfc2305;

  foreach(iconinfo in level.activeheadicons) {
    if(lowestpriority > iconinfo.prioritygroup) {
      lowestpriority = iconinfo.prioritygroup;
    }
  }

  return lowestpriority;
}

function setheadicon_findoldestcreatedicon(var_49d4316fce0b35b7) {
  var_4a38995d4f273f6b = undefined;
  oldesticon = undefined;

  foreach(iconinfo in level.activeheadicons) {
    if(!isDefined(var_4a38995d4f273f6b) && !isDefined(oldesticon) || var_4a38995d4f273f6b.timecreated > iconinfo.timecreated) {
      var_4a38995d4f273f6b = iconinfo;
      oldesticon = iconinfo.icon;
    }
  }

  return oldesticon;
}

function setheadicon_addclienttomask(headicon, client) {
  iconinfo = setheadicon_getexistingiconinfo(headicon);

  if(isDefined(iconinfo)) {
    addclienttoheadiconmask(headicon, client);
  }
}

function setheadicon_removeclientfrommask(headicon, client) {
  iconinfo = setheadicon_getexistingiconinfo(headicon);

  if(isDefined(iconinfo)) {
    removeclientfromheadiconmask(headicon, client);
  }
}

function function_670bc5c30525bf6(imagename) {
  foreach(name in level.var_b516ed3abe09ea) {
    if(name == imagename) {
      return true;
    }
  }

  return false;
}

function function_6ede573723f08c0f() {
  return getdvarint(@ "hash_1d8c3eb547f8c176", 0);
}