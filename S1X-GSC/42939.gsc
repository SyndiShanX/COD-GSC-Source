/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42939.gsc
**************************************/

init() {
  if(!level.teambased) {
    return;
  }
  level.streaksupportqueueallies = [];
  level.streaksupportqueueaxis = [];
  level.streaksuppordisabledcount = [];
  setDvar("scr_coop_util_delay", "1");
}

promptforstreaksupport(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!level.teambased) {
    return;
  }
  var_7 = (0, 0, 0);

  if(isDefined(var_5)) {
    var_7 = var_5.origin;
  }

  var_8 = spawn("script_model", var_7);
  var_8 hide();
  var_8.team = var_0;
  var_8.needsupportvo = var_3;
  var_8.buddyjoinedvo = var_4;
  var_8.streakplayer = var_5;
  var_8.joinedvo = var_6;
  var_8.jointext = var_1;
  var_8.splashref = var_2;
  var_8.active = 0;
  var_8.promptid = getuniquestreakpromptid();

  if(isDefined(var_5)) {
    var_8 disableplayeruse(var_5);
  }

  addstreaksupportprompt(var_8);
  return var_8.promptid;
}

stoppromptforstreaksupport(var_0) {
  if(!level.teambased) {
    return;
  }
  foreach(var_2 in level.streaksupportqueueallies) {
    if(var_2.promptid == var_0) {
      thread removestreaksupportprompt(var_2);
      return;
    }
  }

  foreach(var_2 in level.streaksupportqueueaxis) {
    if(var_2.promptid == var_0) {
      thread removestreaksupportprompt(var_2);
      return;
    }
  }
}

waittillbuddyjoinedstreak(var_0) {
  for(;;) {
    level waittill("buddyJoinedStreak", var_1, var_2);

    if(var_2 == var_0) {
      return var_1;
    }
  }
}

playersetupcoopstreak(var_0) {
  playersetupcoopstreakinternal(var_0);
}

playerresetaftercoopstreak() {
  playerresetaftercoopstreakinternal();
}

playerstoppromptforstreaksupport() {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(level.streaksuppordisabledcount[self.guid])) {
    level.streaksuppordisabledcount[self.guid] = 0;
  }

  level.streaksuppordisabledcount[self.guid]++;

  if(level.streaksuppordisabledcount[self.guid] > 1) {
    return;
  }
  if(self.team == "allies") {
    foreach(var_1 in level.streaksupportqueueallies) {
      var_1 disableplayeruse(self);
    }
  } else {
    foreach(var_1 in level.streaksupportqueueaxis) {
      var_1 disableplayeruse(self);
    }
  }
}

playerstartpromptforstreaksupport() {
  if(!level.teambased) {
    return;
  }
  level.streaksuppordisabledcount[self.guid]--;

  if(level.streaksuppordisabledcount[self.guid] > 0) {
    return;
  }
  if(self.team == "allies") {
    foreach(var_1 in level.streaksupportqueueallies) {
      if(self != var_1.streakplayer) {
        var_1 enableplayeruse(self);
      }
    }
  } else {
    foreach(var_1 in level.streaksupportqueueaxis) {
      if(self != var_1.streakplayer) {
        var_1 enableplayeruse(self);
      }
    }
  }
}

addstreaksupportprompt(var_0) {
  if(var_0.team == "allies") {
    level.streaksupportqueueallies[level.streaksupportqueueallies.size] = var_0;

    if(level.streaksupportqueueallies.size == 1) {
      level thread startstreaksupportprompt(var_0);
    }
  } else {
    level.streaksupportqueueaxis[level.streaksupportqueueaxis.size] = var_0;

    if(level.streaksupportqueueaxis.size == 1) {
      level thread startstreaksupportprompt(var_0);
    }
  }
}

removestreaksupportprompt(var_0) {
  var_1 = var_0.active;
  var_0.active = 0;
  var_0 notify("streakPromptStopped");

  if(var_0.team == "allies") {
    level.streaksupportqueueallies = common_scripts\utility::array_remove(level.streaksupportqueueallies, var_0);

    if(var_1 && level.streaksupportqueueallies.size > 0) {
      level thread startstreaksupportprompt(level.streaksupportqueueallies[0]);
    }
  } else {
    level.streaksupportqueueaxis = common_scripts\utility::array_remove(level.streaksupportqueueaxis, var_0);

    if(var_1 && level.streaksupportqueueaxis.size > 0) {
      level thread startstreaksupportprompt(level.streaksupportqueueaxis[0]);
    }
  }

  thread delaydeleteprompt(var_0);
}

delaydeleteprompt(var_0) {
  wait 1;
  var_0 delete();
}

getuniquestreakpromptid(var_0) {
  var_1 = 0;

  foreach(var_3 in level.streaksupportqueueallies) {
    if(var_3.promptid >= var_1) {
      var_1 = var_3.promptid + 1;
    }
  }

  foreach(var_3 in level.streaksupportqueueaxis) {
    if(var_3.promptid >= var_1) {
      var_1 = var_3.promptid + 1;
    }
  }

  return var_1;
}

startstreaksupportprompt(var_0) {
  var_0.active = 1;
  level thread handleprompt(var_0);
  level thread onconnectprompt(var_0);

  foreach(var_2 in level.players) {
    if(isDefined(var_0.streakplayer) && var_2 == var_0.streakplayer) {
      continue;
    }
    if(maps\mp\_utility::isreallyalive(var_2) && var_2.team == var_0.team) {
      var_2 thread playersetupstreakprompt(var_0);
    }

    var_2 thread playeronspawnprompt(var_0);
  }
}

onconnectprompt(var_0) {
  level endon("game_ended");
  var_0 endon("streakPromptStopped");

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread playeronspawnprompt(var_0);
  }
}

playeronspawnprompt(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("streakPromptStopped");

  for(;;) {
    self waittill("spawned_player");

    if(self.team == var_0.team) {
      thread playersetupstreakprompt(var_0);
    }
  }
}

playersetupstreakprompt(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("streakPromptStopped");

  while(maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition()) {
    waitframe();
  }

  playerdisabledwait(var_0);
  thread playerdisplayjoinrequest(var_0);
  thread playertakestreaksupportinput(var_0);
}

playerdisabledwait(var_0) {
  if(!isDefined(level.streaksuppordisabledcount[self.guid])) {
    return;
  }
  if(level.streaksuppordisabledcount[self.guid] > 0) {
    var_0 disableplayeruse(self);

    while(level.streaksuppordisabledcount[self.guid] > 0) {
      waitframe();
    }
  }
}

playerdisplayjoinrequest(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("streakPromptStopped");

  if(isDefined(var_0.splashref)) {
    thread maps\mp\gametypes\_hud_message::coopkillstreaksplashnotify(var_0.splashref, var_0.needsupportvo);
  }
}

waittillplayercanbebuddy(var_0, var_1) {
  if(maps\mp\_utility::isinremotetransition()) {
    var_0 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
  }

  waitframe();

  if(maps\mp\_utility::isusingremote()) {
    var_0 waittill("stopped_using_remote");
  }
}

waittillpromptactivated(var_0) {
  var_0 endon("streakPromptStopped");
  var_0 waittill("trigger");
  return 1;
}

playertakestreaksupportinput(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    waittillplayercanbebuddy(self);
    var_1 = waittillpromptactivated(var_0);

    if(!isDefined(var_1)) {
      return;
    }
    if(!var_0.active) {
      return;
    }
    if(isDefined(self playergetuseent()) && self playergetuseent() == var_0 && self usebuttonpressed() && self isonground()) {
      var_2 = playergetusetime();
      var_1 = playerhandlejoining(var_0, var_2);

      if(var_1 || !var_0.active) {
        return;
      }
    }
  }
}

playergetusetime() {
  if(getdvarint("scr_coop_util_delay", 1) == 0) {
    return 1.25;
  } else {
    var_0 = self.score;
    var_1 = self.score;

    for(var_2 = 1; var_2 < level.players.size; var_2++) {
      var_3 = level.players[var_2];

      if(var_3.team != self.team) {
        continue;
      }
      if(var_3.score > var_1) {
        var_1 = var_3.score;
        continue;
      }

      if(var_3.score < var_0) {
        var_0 = var_3.score;
      }
    }

    var_4 = var_1 - var_0;

    if(var_4 == 0) {
      return 1.25;
    }

    var_5 = (self.score - var_0) / var_4;
    var_6 = 1.25;
    var_7 = 1.25 + var_5 * var_6;
    return var_7;
  }
}

handleprompt(var_0) {
  var_0 maps\mp\_utility::makegloballyusablebytype("coopStreakPrompt", var_0.jointext, undefined, var_0.team);
  var_0 waittill("streakPromptStopped");
  var_0 maps\mp\_utility::makegloballyunusablebytype();
}

playerhandlejoining(var_0, var_1) {
  var_2 = var_1 * 1000;

  if(var_0 useholdthink(self, var_2, var_0)) {
    level notify("buddyJoinedStreak", self, var_0.promptid);
    thread maps\mp\_events::killstreakjoinevent();

    if(isDefined(var_0.streakplayer) && isalive(var_0.streakplayer)) {
      if(isDefined(var_0.joinedvo)) {
        thread maps\mp\_utility::leaderdialogonplayer(var_0.joinedvo);
      }

      if(isDefined(var_0.buddyjoinedvo)) {
        var_0.streakplayer thread maps\mp\_utility::leaderdialogonplayer(var_0.buddyjoinedvo);
      }

      if(isDefined(var_0.streakplayer.currentkillstreakindex)) {
        setmatchdata("killstreaks", var_0.streakplayer.currentkillstreakindex, "coopPlayerIndex", self.clientid);
      }
    }

    var_0 notify("streakPromptStopped");
    return 1;
  }

  return 0;
}

useholdthink(var_0, var_1, var_2) {
  var_0 playerlinkto(var_2);
  var_0 playerlinkedoffsetenable();
  var_0.manuallyjoiningkillstreak = 1;
  thread useholdthinkcleanuponplayerdeath(var_0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var_1;

  if(isDefined(var_0.inwater)) {
    var_0 allowcrouch(0);
    var_0 allowprone(0);
  }

  var_0 maps\mp\_utility::_giveweapon("killstreak_remote_turret_mp");
  var_0 switchtoweapon("killstreak_remote_turret_mp");
  var_0 disableweaponswitch();
  var_0 thread personalusebar(self, var_2);
  var_3 = useholdthinkloop(var_0, var_2);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isalive(var_0) && !var_3) {
    var_0 playerresetaftercoopstreakinternal();
  }

  self.inuse = 0;
  self.curprogress = 0;

  if(isDefined(var_0)) {
    var_0.manuallyjoiningkillstreak = 0;
    var_0 setclientomnvar("ui_use_bar_text", 0);
    var_0 setclientomnvar("ui_use_bar_end_time", 0);
    var_0 setclientomnvar("ui_use_bar_start_time", 0);
  }

  self notify("coopUtilUseHoldThinkComplete");
  return var_3;
}

useholdthinkcleanuponplayerdeath(var_0) {
  self endon("coopUtilUseHoldThinkComplete");
  var_0 common_scripts\utility::waittill_any("death", "disconnect");

  if(isDefined(var_0)) {
    var_0 playerresetaftercoopstreakinternal();
    var_0.manuallyjoiningkillstreak = 0;
    var_0 setclientomnvar("ui_use_bar_text", 0);
    var_0 setclientomnvar("ui_use_bar_end_time", 0);
    var_0 setclientomnvar("ui_use_bar_start_time", 0);
  }
}

playerresetaftercoopstreakinternal() {
  maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe("killstreak_predator_missile_mp");
  maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe("killstreak_remote_turret_mp");
  self allowcrouch(1);
  self allowprone(1);
  self enableweaponswitch();
  self switchtoweapon(common_scripts\utility::getlastweapon());
  thread playerdelaycontrol();
  self unlink();
}

playersetupcoopstreakinternal(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  self enableweaponswitch();
  maps\mp\_utility::_giveweapon("killstreak_predator_missile_mp");
  self switchtoweaponimmediate("killstreak_predator_missile_mp");
  maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe("killstreak_remote_turret_mp");
  self disableweaponswitch();
}

playerdelaycontrol() {
  self endon("disconnect");
  maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.5;
  maps\mp\_utility::freezecontrolswrapper(0);
}

personalusebar(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("streakPromptStopped");
  self setclientomnvar("ui_use_bar_text", 2);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      if(var_0.userate > 0) {
        var_3 = gettime();
        var_4 = var_0.curprogress / var_0.usetime;
        var_5 = var_3 + (1 - var_4) * (var_0.usetime / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_5));
      }

      var_2 = var_0.userate;
    }

    wait 0.05;
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

useholdthinkloop(var_0, var_1) {
  var_1 endon("streakPromptStopped");

  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 usebuttonpressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    if(self.curprogress >= self.usetime) {
      return maps\mp\_utility::isreallyalive(var_0);
    }

    wait 0.05;
  }

  return 0;
}