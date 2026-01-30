/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42879.gsc
**************************************/

init() {
  if(!isDefined(level.battlebuddywaitlist)) {
    level.battlebuddywaitlist = [];
  }

  level thread onplayerspawned();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", var_0);
    var_0 thread initteamspawnelements();
    var_0 thread onbattlebuddymenuselection();
    var_0 thread ondisconnect();
  }
}

onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(!isai(var_0)) {
      var_0.isspawningonbattlebuddy = undefined;

      if(var_0 wantsbattlebuddy()) {
        if(!var_0 hasbattlebuddy()) {
          var_0.firstspawn = 0;
          var_0 findbattlebuddy();
        }

        continue;
      }

      if(var_0 hasbattlebuddy()) {
        var_0 clearbattlebuddy();
      }
    }
  }
}

initteamspawnelements() {
  if(!isDefined(self.kc_teamspawntext)) {
    self.kc_teamspawntext = newclienthudelem(self);
    self.kc_teamspawntext.archived = 0;
    self.kc_teamspawntext.y = 34;
    self.kc_teamspawntext.alignx = "left";
    self.kc_teamspawntext.aligny = "top";
    self.kc_teamspawntext.horzalign = "center";
    self.kc_teamspawntext.vertalign = "middle";
    self.kc_teamspawntext.sort = 10;
    self.kc_teamspawntext.font = "small";
    self.kc_teamspawntext.foreground = 1;
    self.kc_teamspawntext.hidewheninmenu = 1;

    if(level.splitscreen) {
      self.kc_teamspawntext.x = 16;
      self.kc_teamspawntext.fontscale = 1.2;
    } else {
      self.kc_teamspawntext.x = 62;
      self.kc_teamspawntext.fontscale = 1.6;
    }
  }

  if(!isDefined(self.kc_randomspawntext)) {
    self.kc_randomspawntext = newclienthudelem(self);
    self.kc_randomspawntext.archived = 0;
    self.kc_randomspawntext.y = 58;
    self.kc_randomspawntext.alignx = "left";
    self.kc_randomspawntext.aligny = "top";
    self.kc_randomspawntext.horzalign = "center";
    self.kc_randomspawntext.vertalign = "middle";
    self.kc_randomspawntext.sort = 10;
    self.kc_randomspawntext.font = "small";
    self.kc_randomspawntext.foreground = 1;
    self.kc_randomspawntext.hidewheninmenu = 1;

    if(level.splitscreen) {
      self.kc_randomspawntext.x = 16;
      self.kc_randomspawntext.fontscale = 1.2;
    } else {
      self.kc_randomspawntext.x = 62;
      self.kc_randomspawntext.fontscale = 1.6;
    }
  }
}

onbattlebuddymenuselection() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "battlebuddy_update") {
      var_2 = !wantsbattlebuddy();
      self setplayerdata("enableBattleBuddy", var_2);

      if(var_2) {
        findbattlebuddy();
      } else if(hasbattlebuddy()) {
        if(!isalive(self.battlebuddy)) {
          self.battlebuddy setupforrandomspawn();
        } else if(!isalive(self)) {
          setupforrandomspawn();
        }

        clearbattlebuddy();
      } else {
        removefrombattlebuddywaitlist(self);
        self setclientdvar("ui_battle_buddy_entity_num", -1);
      }

      continue;
    }

    if(var_0 == "team_select") {
      removefrombattlebuddywaitlist(self);
    }
  }
}

ondisconnect() {}

waitforplayerrespawnchoice() {
  maps\mp\_utility::updatesessionstate("spectator");
  self.forcespectatorclient = self.battlebuddy getentitynumber();
  self forcethirdpersonwhenfollowing();
  waitforbuddyspawntimer();
}

watchforrandomspawnbutton() {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  level endon("game_ended");
  self.kc_randomspawntext settext(&"PLATFORM_PRESS_TO_RESPAWN");
  self.kc_randomspawntext.alpha = 1;
  self notifyonplayercommand("respawn_random", "+usereload");
  wait 0.5;
  self waittill("respawn_random");
  setupforrandomspawn();
}

setupforrandomspawn() {
  clearbuddymessage();
  self.isspawningonbattlebuddy = undefined;
  self notify("randomSpawnPressed");
  cleanupbuddyspawn();
}

waitforbuddyspawntimer() {
  self endon("randomSpawnPressed");
  level endon("game_ended");

  if(!isDefined(self.kc_teamspawntext)) {
    initteamspawnelements();
  }

  self.isspawningonbattlebuddy = undefined;
  thread watchforrandomspawnbutton();

  if(isDefined(self.battlebuddyrespawntimestamp)) {
    var_0 = 4000 - (gettime() - self.battlebuddyrespawntimestamp);

    if(var_0 < 2000) {
      var_0 = 2000;
    }
  } else {
    var_0 = 4000;
  }

  var_1 = checkbuddyspawn();

  if(var_1.status == -1 || var_1.status == -3) {
    self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_COMBAT");
  } else {
    self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_INCOMING");
  }

  updatetimer(&"MP_BUDDY_TIME_UNTIL_SPAWN", var_0);

  for(var_1 = checkbuddyspawn(); var_1.status != 0; var_1 = checkbuddyspawn()) {
    if(var_1.status == -1 || var_1.status == -3) {
      displaybuddystatusmessage(&"MP_BUDDY_WAITING_COMBAT");
      self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_COMBAT");
    } else if(var_1.status == -2) {
      displaybuddystatusmessage(&"MP_BUDDY_WAITING_POINT");
      self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_POINT");
    }

    wait 0.5;
  }

  self.isspawningonbattlebuddy = 1;
  thread displaybuddyspawnsuccessful();
  self playlocalsound("copycat_steal_class");
  self notify("teamSpawnPressed");
}

clearbuddymessage() {
  self.kc_randomspawntext.alpha = 0;
  self.kc_teamspawntext.alpha = 0;
  maps\mp\_utility::clearlowermessage("kc_info");
  maps\mp\_utility::clearlowermessage("waiting_info");

  if(isDefined(self.battlebuddy)) {
    self.battlebuddy maps\mp\_utility::clearlowermessage("waiting_info");
  }
}

displaybuddystatusmessage(var_0) {
  maps\mp\_utility::setlowermessage("waiting_info", var_0, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

displaybuddyspawnsuccessful() {
  clearbuddymessage();

  if(isDefined(self.battlebuddy)) {
    self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_SPAWNED_ON_YOU");
    wait 1.5;
    self.battlebuddy maps\mp\_utility::clearlowermessage("waiting_info");
  }
}

checkbuddyspawn() {
  var_0 = spawnStruct();

  if(maps\mp\gametypes\_spawnscoring::isplayerincombat(self.battlebuddy)) {
    var_0.status = -1;
  } else {
    var_1 = maps\mp\gametypes\_spawnscoring::findspawnlocationnearplayer(self.battlebuddy);

    if(isDefined(var_1)) {
      var_2 = spawnStruct();
      var_2.maxtracecount = 18;
      var_2.currenttracecount = 0;

      if(!maps\mp\gametypes\_spawnscoring::issafetospawnon(self.battlebuddy, var_1, var_2)) {
        var_0.status = -3;
      } else {
        var_0.status = 0;
        var_0.origin = var_1;
        var_0.angles = self.battlebuddy.angles;
      }
    } else {
      var_0.status = -2;
    }
  }

  return var_0;
}

cleanupbuddyspawn() {
  thread maps\mp\gametypes\_spectating::setspectatepermissions();
  self.forcespectatorclient = -1;
  maps\mp\_utility::updatesessionstate("dead");
  self disableforcethirdpersonwhenfollowing();
  self.isspawningonbattlebuddy = undefined;
  self notify("abort_battlebuddy_spawn");
}

updatetimer(var_0, var_1) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  var_2 = var_1 * 0.001;
  maps\mp\_utility::setlowermessage("kc_info", var_0, var_2, 1, 1);
  wait(var_2);
  maps\mp\_utility::clearlowermessage("kc_info");
}

updateprogressbar(var_0, var_1) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0, 25);
  var_3 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 25);
  var_3 settext(var_0);
  var_4 = 1.0 / var_1;
  var_5 = gettime();
  var_6 = 1.0;
  var_2 maps\mp\gametypes\_hud_util::updatebar(var_6);
  var_2 maps\mp\gametypes\_hud_util::showelem();
  var_3 maps\mp\gametypes\_hud_util::showelem();

  while(!level.gameended && var_6 > 0.0) {
    var_7 = var_1 - (gettime() - var_5);
    var_6 = var_7 * var_4;
    var_6 = clamp(var_6, 0.0, 1.0);
    var_2 maps\mp\gametypes\_hud_util::updatebar(var_6);
    wait 0.1;
  }

  var_2 maps\mp\gametypes\_hud_util::destroyelem();
  var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

wantsbattlebuddy() {
  return self getplayerdata("enableBattleBuddy");
}

hasbattlebuddy() {
  return isDefined(self.battlebuddy);
}

needsbattlebuddy() {
  return wantsbattlebuddy() && !hasbattlebuddy();
}

isvalidbattlebuddy(var_0) {
  return var_0 needsbattlebuddy() && self.team == var_0.team;
}

pairbattlebuddy(var_0) {
  if(self.team == var_0.team) {
    removefrombattlebuddywaitlist(var_0);
    self.battlebuddy = var_0;
    var_0.battlebuddy = self;
    self setclientdvar("ui_battle_buddy_entity_num", var_0 getentitynumber());
    var_0 setclientdvar("ui_battle_buddy_entity_num", self getentitynumber());
  } else {}
}

getwaitingbattlebuddy() {
  return level.battlebuddywaitlist[self.team];
}

addtobattlebuddywaitlist(var_0) {
  level.battlebuddywaitlist[var_0.team] = var_0;
}

removefrombattlebuddywaitlist(var_0) {
  if(isDefined(level.battlebuddywaitlist[var_0.team]) && var_0 == level.battlebuddywaitlist[var_0.team]) {
    level.battlebuddywaitlist[var_0.team] = undefined;
  }
}

findbattlebuddy() {
  if(level.onlinegame) {
    self.fireteammembers = self getfireteammembers();

    if(self.fireteammembers.size >= 1) {
      foreach(var_1 in self.fireteammembers) {
        if(isvalidbattlebuddy(var_1)) {
          pairbattlebuddy(var_1);
        }
      }
    }
  }

  if(!isDefined(self.battlebuddy)) {
    var_1 = getwaitingbattlebuddy();

    if(isDefined(var_1)) {
      pairbattlebuddy(var_1);
    } else {
      addtobattlebuddywaitlist(self);
      self setclientdvar("ui_battle_buddy_entity_num", -1);
    }
  }
}

clearbattlebuddy() {
  var_0 = self.battlebuddy;
  self setclientdvar("ui_battle_buddy_entity_num", -1);
  self.battlebuddy = undefined;
  var_0 setclientdvar("ui_battle_buddy_entity_num", -1);
  var_0.battlebuddy = undefined;
  self setplayerdata("enableBattleBuddy", 0);
  var_0 findbattlebuddy();
}