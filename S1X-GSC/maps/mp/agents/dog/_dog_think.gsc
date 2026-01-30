/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_think.gsc
*********************************************/

main() {
  setupdogstate();
  thread think();
  thread watchownerdamage();
  thread watchownerdeath();
  thread watchownerteamchange();
  thread waitforbadpath();
  thread waitforpathset();
}

setupdogstate() {
  self.blockgoalpos = 0;
  self.ownerradiussq = 20736;
  self.meleeradiussq = 16384;
  self.attackoffset = 25 + self.radius;
  self.attackradiussq = 202500;
  self.warningradiussq = 302500;
  self.warningzheight = 96.0;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.ownerdamagedradiussq = 2250000;
  self.dogdamagedradiussq = 2250000;
  self.keeppursuingtargetradiussq = 1000000;
  self.preferredoffsetfromowner = 76;
  self.minoffsetfromowner = 50;
  self.forceattack = 0;
  self.ignoreclosefoliage = 1;
  self.movemode = "run";
  self.enableextendedkill = 1;
  self.attackstate = "idle";
  self.movestate = "idle";
  self.bhasbadpath = 0;
  self.timeoflastdamage = 0;
  self.allowcrouch = 1;
  self scragentsetgoalradius(24);
}

init() {
  self.animcbs = spawnStruct();
  self.animcbs.onenter = [];
  self.animcbs.onenter["idle"] = maps\mp\agents\dog\_dog_idle::main;
  self.animcbs.onenter["move"] = maps\mp\agents\dog\_dog_move::main;
  self.animcbs.onenter["traverse"] = maps\mp\agents\dog\_dog_traverse::main;
  self.animcbs.onenter["melee"] = maps\mp\agents\dog\_dog_melee::main;
  self.animcbs.onexit = [];
  self.animcbs.onexit["idle"] = maps\mp\agents\dog\_dog_idle::end_script;
  self.animcbs.onexit["move"] = maps\mp\agents\dog\_dog_move::end_script;
  self.animcbs.onexit["melee"] = maps\mp\agents\dog\_dog_melee::end_script;
  self.animcbs.onexit["traverse"] = maps\mp\agents\dog\_dog_traverse::end_script;
  self.watchattackstatefunc = ::watchattackstate;
  self.aistate = "idle";
  self.movemode = "fastwalk";
  self.radius = 15;
  self.height = 40;
}

onenteranimstate(var_0, var_1) {
  self notify("killanimscript");

  if(!isDefined(self.animcbs.onenter[var_1])) {
    return;
  }
  if(var_0 == var_1 && var_1 != "traverse") {
    return;
  }
  if(isDefined(self.animcbs.onexit[var_0])) {
    self[[self.animcbs.onexit[var_0]]]();
  }

  exitaistate(self.aistate);
  self.aistate = var_1;
  enteraistate(var_1);
  self[[self.animcbs.onenter[var_1]]]();
}

think() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
    thread destroyonownerdisconnect(self.owner);
  }

  self thread[[self.watchattackstatefunc]]();
  thread monitorflash();

  for(;;) {
    if(self.aistate != "melee" && !self.statelocked && readytomeleetarget() && !didpastmeleefail()) {
      self scragentbeginmelee(self.curmeleetarget);
    }

    switch (self.aistate) {
      case "idle":
        updateidle();
        break;
      case "move":
        updatemove();
        break;
      case "melee":
        updatemelee();
        break;
    }

    wait 0.05;
  }
}

didpastpursuitfail(var_0) {
  if(isDefined(self.curmeleetarget) && var_0 != self.curmeleetarget) {
    return 0;
  }

  if(!isDefined(self.lastpursuitfailedpos) || !isDefined(self.lastpursuitfailedmypos)) {
    return 0;
  }

  if(distance2dsquared(var_0.origin, self.lastpursuitfailedpos) > 4) {
    return 0;
  }

  if(self.blastpursuitfailedposbad) {
    return 1;
  }

  if(distancesquared(self.origin, self.lastpursuitfailedmypos) > 4096 && gettime() - self.lastpursuitfailedtime > 2000) {
    return 0;
  }

  return 1;
}

didpastmeleefail() {
  if(isDefined(self.lastmeleefailedpos) && isDefined(self.lastmeleefailedmypos) && distance2dsquared(self.curmeleetarget.origin, self.lastmeleefailedpos) < 4 && distancesquared(self.origin, self.lastmeleefailedmypos) < 2500) {
    return 1;
  }

  if(wanttoattacktargetbutcant(0)) {
    return 1;
  }

  return 0;
}

enteraistate(var_0) {
  exitaistate(self.aistate);
  self.aistate = var_0;

  switch (var_0) {
    case "idle":
      self.movestate = "idle";
      self.bhasbadpath = 0;
      break;
    case "move":
      self.movestate = "follow";
      break;
    case "melee":
      break;
    default:
      break;
  }
}

exitaistate(var_0) {
  switch (var_0) {
    case "move":
      self.ownerprevpos = undefined;
      break;
    default:
      break;
  }
}

updateidle() {
  updatemovestate();
}

updatemove() {
  updatemovestate();
}

updatemelee() {
  self scragentsetgoalpos(self.origin);
}

updatemovestate() {
  if(self.blockgoalpos) {
    return;
  }
  self.prevmovestate = self.movestate;
  var_0 = undefined;
  var_1 = 0;
  var_2 = 0;
  var_3 = 500;

  if(self.bhasbadpath && gettime() - self.lastbadpathtime < var_3) {
    self.movestate = "follow";
    var_1 = 1;
  } else {
    self.movestate = getmovestate();
  }

  if(self.movestate == "pursuit") {
    var_0 = getattackpoint(self.enemy);
    var_4 = 0;

    if(isDefined(self.lastbadpathtime) && gettime() - self.lastbadpathtime < 3000) {
      if(distance2dsquared(var_0, self.lastbadpathgoal) < 16) {
        var_4 = 1;
      } else if(isDefined(self.lastbadpathmovestate) && self.lastbadpathmovestate == "pursuit" && distance2dsquared(self.lastbadpathultimategoal, self.enemy.origin) < 16) {
        var_4 = 1;
      }
    }

    if(var_4) {
      self.movestate = "follow";
      var_2 = 1;
    } else if(wanttoattacktargetbutcant(1)) {
      self.movestate = "follow";
      var_2 = 1;
    } else if(didpastpursuitfail(self.enemy)) {
      self.movestate = "follow";
      var_2 = 1;
    }
  }

  setpastpursuitfailed(var_2);

  if(self.movestate == "follow") {
    self.curmeleetarget = undefined;
    self.movemode = getfollowmovemode(self.movemode);
    self.barrivalsenabled = 1;
    var_5 = self getpathgoalpos();

    if(!isDefined(var_5)) {
      var_5 = self.origin;
    }

    if(self.owner.sessionstate == "spectator") {
      return;
    }
    if(gettime() - self.timeoflastdamage < 5000) {
      var_1 = 1;
    }

    var_6 = self.owner getstance();

    if(!isDefined(self.owner.prevstance) && isDefined(self.owner)) {
      self.owner.prevstance = var_6;
    }

    var_7 = !isDefined(self.ownerprevpos) || distance2dsquared(self.ownerprevpos, self.owner.origin) > 100;

    if(var_7) {
      self.ownerprevpos = self.owner.origin;
    }

    var_8 = distance2dsquared(var_5, self.owner.origin);

    if(var_1 || var_8 > self.ownerradiussq && var_7 || self.owner.prevstance != var_6 || self.prevmovestate != "idle" && self.prevmovestate != self.movestate) {
      self scragentsetgoalpos(findpointnearowner());
      self.owner.prevstance = var_6;
      return;
    }
  } else if(self.movestate == "pursuit") {
    self.curmeleetarget = self.enemy;
    self.movemode = "sprint";
    self.barrivalsenabled = 0;
    self scragentsetgoalpos(var_0);
  }
}

getmovestate(var_0) {
  if(isDefined(self.enemy)) {
    if(isDefined(self.favoriteenemy) && self.enemy == self.favoriteenemy) {
      return "pursuit";
    }

    if(abs(self.origin[2] - self.enemy.origin[2]) < self.warningzheight && distance2dsquared(self.enemy.origin, self.origin) < self.attackradiussq) {
      return "pursuit";
    }

    if(isDefined(self.curmeleetarget) && self.curmeleetarget == self.enemy) {
      if(distance2dsquared(self.curmeleetarget.origin, self.origin) < self.keeppursuingtargetradiussq) {
        return "pursuit";
      }
    }
  }

  return "follow";
}

setpastpursuitfailed(var_0) {
  if(var_0) {
    if(!isDefined(self.lastpursuitfailedpos)) {
      self.lastpursuitfailedpos = self.enemy.origin;
      self.lastpursuitfailedmypos = self.origin;
      var_1 = maps\mp\agents\_scriptedagents::droppostoground(self.enemy.origin);
      self.blastpursuitfailedposbad = !isDefined(var_1);
      self.lastpursuitfailedtime = gettime();
    }
  } else {
    self.lastpursuitfailedpos = undefined;
    self.lastpursuitfailedmypos = undefined;
    self.blastpursuitfailedposbad = undefined;
    self.lastpursuitfailedtime = undefined;
  }
}

waitforbadpath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path", var_0);
    self.bhasbadpath = 1;
    self.lastbadpathtime = gettime();
    self.lastbadpathgoal = var_0;
    self.lastbadpathmovestate = self.movestate;

    if(self.movestate == "follow" && isDefined(self.owner)) {
      self.lastbadpathultimategoal = self.owner.origin;
      continue;
    }

    if(self.movestate == "pursuit" && isDefined(self.enemy)) {
      self.lastbadpathultimategoal = self.enemy.origin;
    }
  }
}

waitforpathset() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("path_set");
    self.bhasbadpath = 0;
  }
}

getfollowmovemode(var_0) {
  var_1 = 40000;
  var_2 = 65536;
  var_3 = self getpathgoalpos();

  if(isDefined(var_3)) {
    var_4 = distancesquared(var_3, self.origin);

    if(var_0 == "run" || var_0 == "sprint") {
      if(var_4 < var_1) {
        return "fastwalk";
      } else if(var_0 == "sprint") {
        return "run";
      }
    } else if(var_0 == "fastwalk") {
      if(var_4 > var_2) {
        return "run";
      }
    }
  }

  return var_0;
}

iswithinattackheight(var_0) {
  var_1 = var_0[2] - self.origin[2];
  return var_1 <= self.attackzheight && var_1 >= self.attackzheightdown;
}

wanttoattacktargetbutcant(var_0) {
  if(!isDefined(self.curmeleetarget)) {
    return 0;
  }

  return !iswithinattackheight(self.curmeleetarget.origin) && distance2dsquared(self.origin, self.curmeleetarget.origin) < self.meleeradiussq * 0.75 * 0.75 && (!var_0 || self agentcanseesentient(self.curmeleetarget));
}

readytomeleetarget() {
  if(!isDefined(self.curmeleetarget)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self.curmeleetarget)) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(distance2dsquared(self.origin, self.curmeleetarget.origin) > self.meleeradiussq) {
    return 0;
  }

  if(!iswithinattackheight(self.curmeleetarget.origin)) {
    return 0;
  }

  return 1;
}

wantstogrowlattarget() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(abs(self.origin[2] - self.enemy.origin[2]) <= self.warningzheight || self agentcanseesentient(self.enemy)) {
    var_0 = distance2dsquared(self.origin, self.enemy.origin);

    if(var_0 < self.warningradiussq) {
      return 1;
    }
  }

  return 0;
}

getattackpoint(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectornormalize(var_1);
  var_2 = self getpathgoalpos();
  var_3 = self.attackoffset + 4;

  if(isDefined(var_2) && distance2dsquared(var_2, var_0.origin) < var_3 * var_3 && maps\mp\agents\_scriptedagents::canmovepointtopoint(var_0.origin, var_2)) {
    return var_2;
  }

  var_4 = var_0.origin - var_1 * self.attackoffset;
  var_4 = maps\mp\agents\_scriptedagents::droppostoground(var_4);

  if(!isDefined(var_4)) {
    return var_0.origin;
  }

  if(!maps\mp\agents\_scriptedagents::canmovepointtopoint(var_0.origin, var_4)) {
    var_5 = anglesToForward(var_0.angles);
    var_4 = var_0.origin + var_5 * self.attackoffset;

    if(!maps\mp\agents\_scriptedagents::canmovepointtopoint(var_0.origin, var_4)) {
      return var_0.origin;
    }
  }

  return var_4;
}

cross2d(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

findpointnearowner() {
  var_0 = vectornormalize(self.origin - self.owner.origin);
  var_1 = anglesToForward(self.owner.angles);
  var_1 = (var_1[0], var_1[1], 0);
  var_1 = vectornormalize(var_1);
  var_2 = cross2d(var_0, var_1);
  var_3 = getclosestnodeinsight(self.owner.origin);

  if(!isDefined(var_3)) {
    return self.origin;
  }

  var_4 = getlinkednodes(var_3);
  var_5 = 5;
  var_6 = 10;
  var_7 = 15;
  var_8 = -15;
  var_9 = gettime() - self.timeoflastdamage < 5000;
  var_10 = 0;
  var_11 = 0;
  var_4[var_4.size] = var_3;

  foreach(var_13 in var_4) {
    var_14 = 0;
    var_15 = var_13.origin - self.owner.origin;
    var_16 = length(var_15);

    if(var_16 >= self.preferredoffsetfromowner) {
      var_14 = var_14 + var_5;
    } else if(var_16 < self.minoffsetfromowner) {
      var_17 = 1 - (self.minoffsetfromowner - var_16) / self.minoffsetfromowner;
      var_14 = var_14 + var_5 * var_17 * var_17;
    } else {
      var_14 = var_14 + var_5 * var_16 / self.preferredoffsetfromowner;
    }

    if(var_16 == 0) {
      var_16 = 1;
    }

    var_15 = var_15 / var_16;
    var_18 = vectordot(var_1, var_15);
    var_19 = self.owner getstance();

    switch (var_19) {
      case "stand":
        if(var_18 < cos(35) && var_18 > cos(45)) {
          var_14 = var_14 + var_6;
        }

        break;
      case "crouch":
        if(var_18 < cos(75) && var_18 > cos(90)) {
          var_14 = var_14 + var_6;
        }

        break;
      case "prone":
        if(var_18 < cos(125) && var_18 > cos(135)) {
          var_14 = var_14 + var_6;
        }

        break;
    }

    var_20 = cross2d(var_15, var_1);

    if(var_20 * var_2 > 0) {
      var_14 = var_14 + var_7;
    }

    if(var_9) {
      var_21 = vectordot(self.damagedownertome, var_15);
      var_14 = var_14 + var_21 * var_8;
    }

    if(var_14 > var_10) {
      var_10 = var_14;
      var_11 = var_13;
    }
  }

  if(!isDefined(var_11)) {
    return self.origin;
  }

  var_23 = var_11.origin - self.owner.origin;
  var_24 = length(var_23);

  if(var_24 > self.preferredoffsetfromowner) {
    var_25 = var_3.origin - self.owner.origin;

    if(vectordot(var_25, var_23 / var_24) < 0) {
      var_26 = var_11.origin;
    } else {
      var_27 = vectornormalize(var_11.origin - var_3.origin);
      var_26 = var_3.origin + var_27 * self.preferredoffsetfromowner;
    }
  } else {
    var_26 = var_11.origin;
  }

  var_26 = maps\mp\agents\_scriptedagents::droppostoground(var_26);

  if(!isDefined(var_26)) {
    return self.origin;
  }

  if(self.bhasbadpath && distance2dsquared(var_26, self.lastbadpathgoal) < 4) {
    return self.origin;
  }

  return var_26;
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 common_scripts\utility::waittill_any("disconnect", "joined_team");
  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self notify("killanimscript");

  if(isDefined(self.animcbs.onexit[self.aistate])) {
    self[[self.animcbs.onexit[self.aistate]]]();
  }

  self suicide();
}

watchattackstate() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(self.aistate == "melee") {
      if(self.attackstate != "melee") {
        self.attackstate = "melee";
        setsoundstate(undefined);
      }
    } else if(self.movestate == "pursuit") {
      if(self.attackstate != "attacking") {
        self.attackstate = "attacking";
        setsoundstate("bark", "attacking");
      }
    } else if(self.attackstate != "warning") {
      if(wantstogrowlattarget()) {
        self.attackstate = "warning";
        setsoundstate("growl", "warning");
      } else {
        self.attackstate = self.aistate;
        setsoundstate("pant");
      }
    } else if(!wantstogrowlattarget()) {
      self.attackstate = self.aistate;
      setsoundstate("pant");
    }

    wait 0.05;
  }
}

setsoundstate(var_0, var_1) {
  if(!isDefined(var_0)) {
    self notify("end_dog_sound");
    self.soundstate = undefined;
    return;
  }

  if(!isDefined(self.soundstate) || self.soundstate != var_0) {
    self notify("end_dog_sound");
    self.soundstate = var_0;

    if(var_0 == "bark") {
      thread playbark(var_1);
    } else if(var_0 == "growl") {
      thread playgrowl(var_1);
    } else if(var_0 == "pant") {
      thread playpanting();
    } else {}
  }
}

playbark(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(!isDefined(self.barking_sound)) {
    self.barking_sound = 1;
    thread watchbarking();
  }
}

watchbarking() {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  wait(randomintrange(5, 10));
  self.barking_sound = undefined;
}

playgrowl(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self.lastgrowlplayedtime) && gettime() - self.lastgrowlplayedtime < 3000) {
    wait 3;
  }

  for(;;) {
    self.lastgrowlplayedtime = gettime();
    wait(randomintrange(3, 6));
  }
}

playpanting(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self.lastpantplayedtime) && gettime() - self.lastpantplayedtime < 3000) {
    wait 3;
  }

  self.lastpantplayedtime = gettime();

  for(;;) {
    if(self.aistate == "idle") {
      wait 3;
      continue;
    }

    self.lastpantplayedtime = gettime();
    wait(randomintrange(6, 8));
  }
}

watchownerdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("damage", var_0, var_1);

    if(isplayer(var_1) && var_1 != self.owner) {
      if(self.attackstate == "attacking") {
        continue;
      }
      if(distancesquared(self.owner.origin, self.origin) > self.ownerdamagedradiussq) {
        continue;
      }
      if(distancesquared(self.owner.origin, var_1.origin) > self.ownerdamagedradiussq) {
        continue;
      }
      self.favoriteenemy = var_1;
      self.forceattack = 1;
      thread watchfavoriteenemydeath();
    }
  }
}

watchownerdeath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("death");

    switch (level.gametype) {
      case "sd":
        maps\mp\agents\_agent_utility::killdog();
        break;
      case "sr":
        var_0 = level common_scripts\utility::waittill_any_return("sr_player_eliminated", "sr_player_respawned");

        if(isDefined(var_0) && var_0 == "sr_player_eliminated") {
          maps\mp\agents\_agent_utility::killdog();
        }

        break;
    }
  }
}

watchownerteamchange() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    var_0 = self.owner common_scripts\utility::waittill_any_return_no_endon_death("joined_team", "joined_spectators");

    if(isDefined(var_0) && (var_0 == "joined_team" || var_0 == "joined_spectators")) {
      maps\mp\agents\_agent_utility::killdog();
    }
  }
}

watchfavoriteenemydeath() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self.favoriteenemy common_scripts\utility::waittill_any_timeout(5.0, "death", "disconnect");
  self.favoriteenemy = undefined;
  self.forceattack = 0;
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.timeoflastdamage = gettime();

  if(isDefined(self.owner)) {
    self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
  }

  if(shouldplayhitreaction(var_2, var_5, var_4)) {
    switch (self.aistate) {
      case "idle":
        thread maps\mp\agents\dog\_dog_idle::ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        break;
      case "move":
        thread maps\mp\agents\dog\_dog_move::ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        break;
    }
  }
}

shouldplayhitreaction(var_0, var_1, var_2) {
  if(isDefined(var_1) && weaponclass(var_1) == "sniper") {
    return 1;
  }

  if(isDefined(var_2) && isexplosivedamagemod(var_2) && var_0 >= 10) {
    return 1;
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(var_1) && var_1 == "concussion_grenade_mp") {
    return 1;
  }

  return 0;
}

monitorflash() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self.owner) {
      continue;
    }
    switch (self.aistate) {
      case "idle":
        maps\mp\agents\dog\_dog_idle::onflashbanged();
        break;
      case "move":
        maps\mp\agents\dog\_dog_move::onflashbanged();
        break;
    }
  }
}