/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_utility.gsc
********************************/

exploder_sound() {
  if(isdefined(self.script_delay))
    wait(self.script_delay);

  self playsound(level.scr_sound[self.script_sound]);
}

_beginlocationselection(var_0, var_1, var_2, var_3) {
  self beginlocationselection(var_1, var_2, var_3);
  self setclientomnvar("ui_map_location_selector", 1);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("cancel_location");
  thread endselectiononaction("death");
  thread endselectiononaction("disconnect");
  thread endselectiononaction("used");
  thread endselectiononaction("weapon_change");
  self endon("stop_location_selection");
  thread endselectiononendgame();
  thread endselectiononemp();
  thread endselectionohostmigration();
}

stoplocationselection(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = "generic";

  if(!var_0) {
    self setclientomnvar("ui_map_location_selector", 0);
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self.selectinglocation = undefined;
  }

  self notify("stop_location_selection", var_1);
}

endselectiononemp() {
  self endon("stop_location_selection");

  for (;;) {
    level waittill("emp_update");

    if(!isemped()) {
      continue;
    }
    thread stoplocationselection(0, "emp");
    return;
  }
}

endselectiononaction(var_0, var_1) {
  self endon("stop_location_selection");

  if(!isdefined(var_1))
    var_1 = 1;

  while (var_1 > 0) {
    self waittill(var_0);
    var_1--;
  }

  thread stoplocationselection(var_0 == "disconnect", var_0);
}

endselectiononendgame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread stoplocationselection(0, "end_game");
}

endselectionohostmigration() {
  self endon("stop_location_selection");
  level waittill("host_migration_begin");
  thread stoplocationselection(0, "hostmigrate");
}

isattachment(var_0) {
  var_1 = tablelookup("mp\attachmentTable.csv", 3, var_0, 0);

  if(isdefined(var_1) && var_1 != "")
    return 1;
  else
    return 0;
}

getattachmenttype(var_0) {
  var_1 = tablelookup("mp\attachmentTable.csv", 3, var_0, 1);
  return var_1;
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait(var_1);

  if(!isdefined(var_2))
    thread[[var_0]]();
  else if(!isdefined(var_3))
    thread[[var_0]](var_2);
  else if(!isdefined(var_4))
    thread[[var_0]](var_2, var_3);
  else if(!isdefined(var_5))
    thread[[var_0]](var_2, var_3, var_4);
  else if(!isdefined(var_6))
    thread[[var_0]](var_2, var_3, var_4, var_5);
  else
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
}

getplant() {
  var_0 = self.origin + (0, 0, 10);
  var_1 = 11;
  var_2 = anglestoforward(self.angles);
  var_2 = var_2 * var_1;
  var_3[0] = var_0 + var_2;
  var_3[1] = var_0;
  var_4 = bullettrace(var_3[0], var_3[0] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_5 = spawnstruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_4 = bullettrace(var_3[1], var_3[1] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_5 = spawnstruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_3[2] = var_0 + (16, 16, 0);
  var_3[3] = var_0 + (16, -16, 0);
  var_3[4] = var_0 + (-16, -16, 0);
  var_3[5] = var_0 + (-16, 16, 0);
  var_6 = undefined;
  var_7 = undefined;

  for (var_8 = 0; var_8 < var_3.size; var_8++) {
    var_4 = bullettrace(var_3[var_8], var_3[var_8] + (0, 0, -1000), 0, undefined);

    if(!isdefined(var_6) || var_4["fraction"] < var_6) {
      var_6 = var_4["fraction"];
      var_7 = var_4["position"];
    }
  }

  if(var_6 == 1)
    var_7 = self.origin;

  var_5 = spawnstruct();
  var_5.origin = var_7;
  var_5.angles = orienttonormal(var_4["normal"]);
  return var_5;
}

orienttonormal(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  var_2 = length(var_1);

  if(!var_2)
    return (0, 0, 0);

  var_3 = vectornormalize(var_1);
  var_4 = var_0[2] * -1;
  var_5 = (var_3[0] * var_4, var_3[1] * var_4, var_2);
  var_6 = vectortoangles(var_5);
  return var_6;
}

deleteplacedentity(var_0) {
  var_1 = getentarray(var_0, "classname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] delete();
}

issecondarysplitscreenplayer() {
  if(self issplitscreenplayer() && !self issplitscreenplayerprimary())
    return 1;

  return 0;
}

playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isdefined(level.players[0]))
      level.players[0] playlocalsound(var_0);
  } else if(isdefined(var_1)) {
    if(isdefined(var_2)) {
      for (var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issecondarysplitscreenplayer()) {
          continue;
        }
        if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !isexcluded(var_4, var_2))
          var_4 playlocalsound(var_0);
      }
    } else {
      for (var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issecondarysplitscreenplayer()) {
          continue;
        }
        if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_1)
          var_4 playlocalsound(var_0);
      }
    }
  } else if(isdefined(var_2)) {
    for (var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issecondarysplitscreenplayer()) {
        continue;
      }
      if(!isexcluded(var_4, var_2))
        var_4 playlocalsound(var_0);
    }
  } else {
    for (var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issecondarysplitscreenplayer()) {
        continue;
      }
      var_4 playlocalsound(var_0);
    }
  }
}

playloopsoundtoplayers(var_0, var_1, var_2) {
  if(!soundexists(var_0)) {
    return;
  }
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3 endon("death");
  thread common_scripts\utility::delete_on_death(var_3);

  if(isdefined(var_2)) {
    var_3 hide();

    foreach(var_5 in var_2)
    var_3 showtoplayer(var_5);
  }

  if(isdefined(var_1)) {
    var_3.origin = self.origin + var_1;
    var_3.angles = self.angles;
    var_3 linktosynchronizedparent(self);
  } else {
    var_3.origin = self.origin;
    var_3.angles = self.angles;
    var_3 linktosynchronizedparent(self);
  }

  var_3 playloopsound(var_0);
  self waittill("stop sound" + var_0);
  var_3 stoploopsound(var_0);
  var_3 delete();
}

sortlowermessages() {
  for (var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for (var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--)
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];

    self.lowermessages[var_3 + 1] = var_1;
  }
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  foreach(var_11 in self.lowermessages) {
    if(var_11.name == var_0) {
      if(var_11.text == var_1 && var_11.priority == var_3) {
        return;
      }
      var_9 = var_11;
      break;
    }
  }

  if(!isdefined(var_9)) {
    var_9 = spawnstruct();
    self.lowermessages[self.lowermessages.size] = var_9;
  }

  var_9.name = var_0;
  var_9.text = var_1;
  var_9.time = var_2;
  var_9.addtime = gettime();
  var_9.priority = var_3;
  var_9.showtimer = var_4;
  var_9.shouldfade = var_5;
  var_9.fadetoalpha = var_6;
  var_9.fadetoalphatime = var_7;
  var_9.hidewhenindemo = var_8;
  sortlowermessages();
}

removelowermessage(var_0) {
  if(isdefined(self.lowermessages)) {
    for (var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self.lowermessages[var_1 - 1];

      for (var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isdefined(self.lowermessages[var_3]))
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

getlowermessage() {
  return self.lowermessages[0];
}

setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isdefined(var_3))
    var_3 = 1;

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_4))
    var_4 = 0;

  if(!isdefined(var_5))
    var_5 = 0;

  if(!isdefined(var_6))
    var_6 = 0.85;

  if(!isdefined(var_7))
    var_7 = 3.0;

  if(!isdefined(var_8))
    var_8 = 0;

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  updatelowermessage();
}

updatelowermessage() {
  if(!isdefined(self.lowermessage)) {
    return;
  }
  var_0 = getlowermessage();

  if(!isdefined(var_0)) {
    if(isdefined(self.lowermessage) && isdefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage settext(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;

    if(var_0.shouldfade) {
      self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
      self.lowermessage.alpha = var_0.fadetoalpha;
    }

    if(var_0.time > 0 && var_0.showtimer)
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    else {
      if(var_0.time > 0 && !var_0.showtimer) {
        self.lowertimer settext("");
        self.lowermessage fadeovertime(min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(var_0);
        thread clearafterfade(var_0);
        return;
      }

      self.lowertimer settext("");
    }
  }
}

clearondeath(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

clearafterfade(var_0) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

clearlowermessages() {
  for (var_0 = 0; var_0 < self.lowermessages.size; var_0++)
    self.lowermessages[var_0] = undefined;

  if(!isdefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

printonteam(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team != var_1) {
      continue;
    }
    var_3 iprintln(var_0);
  }
}

printboldonteam(var_0, var_1) {
  for (var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isdefined(var_3.pers["team"]) && var_3.pers["team"] == var_1)
      var_3 iprintlnbold(var_0);
  }
}

printboldonteamarg(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_1)
      var_4 iprintlnbold(var_0, var_2);
  }
}

printonteamarg(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_1)
      var_4 iprintln(var_0, var_2);
  }
}

printonplayers(var_0, var_1) {
  var_2 = level.players;

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(var_1)) {
      if(isdefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == var_1)
        var_2[var_3] iprintln(var_0);

      continue;
    }

    var_2[var_3] iprintln(var_0);
  }
}

printandsoundoneveryone(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isdefined(var_4);
  var_8 = 0;

  if(isdefined(var_5))
    var_8 = 1;

  if(!var_7) {
    for (var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_0 && isdefined(var_2)) {
          var_10 iprintln(var_2, var_6);
          continue;
        }

        if(var_11 == var_1 && isdefined(var_3))
          var_10 iprintln(var_3, var_6);
      }
    }
  } else if(var_8) {
    for (var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];

      if(var_10 issecondarysplitscreenplayer()) {
        continue;
      }
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_0) {
          if(isdefined(var_2))
            var_10 iprintln(var_2, var_6);

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isdefined(var_3))
            var_10 iprintln(var_3, var_6);

          var_10 playlocalsound(var_5);
        }
      }
    }
  } else {
    for (var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];

      if(var_10 issecondarysplitscreenplayer()) {
        continue;
      }
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_0) {
          if(isdefined(var_2))
            var_10 iprintln(var_2, var_6);

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isdefined(var_3))
            var_10 iprintln(var_3, var_6);
        }
      }
    }
  }
}

printandsoundonteam(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4.team != var_0) {
      continue;
    }
    var_4 printandsoundonplayer(var_1, var_2);
  }
}

printandsoundonplayer(var_0, var_1) {
  self iprintln(var_0);
  self playlocalsound(var_1);
}

_playlocalsound(var_0) {
  if(level.splitscreen && self getentitynumber() != 0) {
    return;
  }
  self playlocalsound(var_0);
}

dvarintvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getdvar(var_0) == "") {
    setdvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarint(var_0);

  if(var_4 > var_3)
    var_4 = var_3;
  else if(var_4 < var_2)
    var_4 = var_2;
  else
    return var_4;

  setdvar(var_0, var_4);
  return var_4;
}

dvarfloatvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getdvar(var_0) == "") {
    setdvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarfloat(var_0);

  if(var_4 > var_3)
    var_4 = var_3;
  else if(var_4 < var_2)
    var_4 = var_2;
  else
    return var_4;

  setdvar(var_0, var_4);
  return var_4;
}

play_sound_on_tag(var_0, var_1) {
  if(isdefined(var_1))
    playsoundatpos(self gettagorigin(var_1), var_0);
  else
    playsoundatpos(self.origin, var_0);
}

getotherteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "allies")
    return "axis";
  else if(var_0 == "axis")
    return "allies";
  else
    return "none";
}

wait_endon(var_0, var_1, var_2, var_3) {
  self endon(var_1);

  if(isdefined(var_2))
    self endon(var_2);

  if(isdefined(var_3))
    self endon(var_3);

  wait(var_0);
}

initpersstat(var_0) {
  if(!isdefined(self.pers[var_0]))
    self.pers[var_0] = 0;
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incpersstat(var_0, var_1) {
  if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[var_0])) {
    self.pers[var_0] = self.pers[var_0] + var_1;
    maps\mp\gametypes\_persistence::statadd(var_0, var_1);
  }
}

setpersstat(var_0, var_1) {
  self.pers[var_0] = var_1;
}

initplayerstat(var_0, var_1) {
  if(!isdefined(self.stats["stats_" + var_0])) {
    if(!isdefined(var_1))
      var_1 = 0;

    self.stats["stats_" + var_0] = spawnstruct();
    self.stats["stats_" + var_0].value = var_1;

    if(rankingenabled())
      self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "awards", var_0, 0);
  }
}

incplayerstat(var_0, var_1) {
  if(isagent(self)) {
    return;
  }
  var_2 = self.stats["stats_" + var_0];
  var_2.value = var_2.value + var_1;
}

setplayerstat(var_0, var_1) {
  var_2 = self.stats["stats_" + var_0];
  var_2.value = var_1;
  var_2.time = gettime();
}

getplayerstat(var_0) {
  return self.stats["stats_" + var_0].value;
}

getplayerstattime(var_0) {
  return self.stats["stats_" + var_0].time;
}

setplayerstatifgreater(var_0, var_1) {
  var_2 = getplayerstat(var_0);

  if(var_1 > var_2)
    setplayerstat(var_0, var_1);
}

setplayerstatiflower(var_0, var_1) {
  var_2 = getplayerstat(var_0);

  if(var_1 < var_2)
    setplayerstat(var_0, var_1);
}

updatepersratio(var_0, var_1, var_2) {
  if(!rankingenabled()) {
    return;
  }
  var_3 = maps\mp\gametypes\_persistence::statget(var_1);
  var_4 = maps\mp\gametypes\_persistence::statget(var_2);

  if(var_4 == 0)
    var_4 = 1;

  maps\mp\gametypes\_persistence::statset(var_0, int(var_3 * 1000 / var_4));
}

updatepersratiobuffered(var_0, var_1, var_2) {
  if(!rankingenabled()) {
    return;
  }
  var_3 = maps\mp\gametypes\_persistence::statgetbuffered(var_1);
  var_4 = maps\mp\gametypes\_persistence::statgetbuffered(var_2);

  if(var_4 == 0)
    var_4 = 1;

  maps\mp\gametypes\_persistence::statsetbuffered(var_0, int(var_3 * 1000 / var_4));
}

waittillslowprocessallowed(var_0) {
  if(level.lastslowprocessframe == gettime()) {
    if(isdefined(var_0) && var_0) {
      while (level.lastslowprocessframe == gettime())
        wait 0.05;
    } else {
      wait 0.05;

      if(level.lastslowprocessframe == gettime()) {
        wait 0.05;

        if(level.lastslowprocessframe == gettime()) {
          wait 0.05;

          if(level.lastslowprocessframe == gettime())
            wait 0.05;
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
}

waitfortimeornotify(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
}

waitfortimeornotifies(var_0, var_1) {
  if(isdefined(var_1)) {
    foreach(var_3 in var_1)
    self endon(var_3);
  }

  if(isdefined(var_0) && var_0 > 0)
    wait(var_0);
}

isexcluded(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2])
      return 1;
  }

  return 0;
}

leaderdialog(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(var_0 == "null") {
    return;
  }
  if(!isdefined(var_1))
    leaderdialogbothteams(var_0, "allies", var_0, "axis", var_2, var_3, var_4);
  else {
    if(isdefined(var_3)) {
      for (var_5 = 0; var_5 < level.players.size; var_5++) {
        var_6 = level.players[var_5];

        if(isdefined(var_6.pers["team"]) && var_6.pers["team"] == var_1 && !isexcluded(var_6, var_3)) {
          if(var_6 issecondarysplitscreenplayer()) {
            continue;
          }
          var_6 leaderdialogonplayer(var_0, var_2, undefined, var_4);
        }
      }

      return;
    }

    for (var_5 = 0; var_5 < level.players.size; var_5++) {
      var_6 = level.players[var_5];

      if(isdefined(var_6.pers["team"]) && var_6.pers["team"] == var_1) {
        if(var_6 issecondarysplitscreenplayer()) {
          continue;
        }
        var_6 leaderdialogonplayer(var_0, var_2, undefined, var_4);
      }
    }
  }
}

leaderdialogbothteams(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(level.splitscreen) {
    return;
  }
  if(isdefined(var_5)) {
    for (var_7 = 0; var_7 < level.players.size; var_7++) {
      var_8 = level.players[var_7];
      var_9 = var_8.pers["team"];

      if(!isdefined(var_9)) {
        continue;
      }
      if(isexcluded(var_8, var_5)) {
        continue;
      }
      if(var_8 issecondarysplitscreenplayer()) {
        continue;
      }
      if(var_9 == var_1) {
        var_8 leaderdialogonplayer(var_0, var_4, undefined, var_6);
        continue;
      }

      if(var_9 == var_3)
        var_8 leaderdialogonplayer(var_2, var_4, undefined, var_6);
    }
  } else {
    for (var_7 = 0; var_7 < level.players.size; var_7++) {
      var_8 = level.players[var_7];
      var_9 = var_8.pers["team"];

      if(!isdefined(var_9)) {
        continue;
      }
      if(var_8 issecondarysplitscreenplayer()) {
        continue;
      }
      if(var_9 == var_1) {
        var_8 leaderdialogonplayer(var_0, var_4, undefined, var_6);
        continue;
      }

      if(var_9 == var_3)
        var_8 leaderdialogonplayer(var_2, var_4, undefined, var_6);
    }
  }
}

leaderdialogonplayers(var_0, var_1, var_2, var_3) {
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  foreach(var_5 in var_1)
  var_5 leaderdialogonplayer(var_0, var_2, undefined, var_3);
}

leaderdialogonplayer(var_0, var_1, var_2, var_3) {
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(!isdefined(var_2))
    var_2 = 0;

  var_4 = self.pers["team"];

  if(isdefined(level.ishorde) && issecondarysplitscreenplayer()) {
    return;
  }
  if(isdefined(level.announcerdisabled) && level.announcerdisabled) {
    return;
  }
  if(!isdefined(var_4)) {
    return;
  }
  if(var_4 != "allies" && var_4 != "axis") {
    return;
  }
  if(issecondarysplitscreenplayer()) {
    return;
  }
  if(!isdefined(var_3))
    var_3 = (0, 0, 0);

  if(isdefined(var_1)) {
    if(self.leaderdialoggroup == var_1) {
      if(var_2) {
        if(self.leaderdialogactive != "")
          self stoplocalsound(self.leaderdialogactive);

        thread leaderdialogonplayer_internal(var_0, var_4, var_3);
      }

      return;
    }

    var_5 = isdefined(self.leaderdialoggroups[var_1]);
    self.leaderdialoggroups[var_1] = var_0;
    var_0 = var_1;

    if(var_5)
      return;
  }

  if(self.leaderdialogactive == "")
    thread leaderdialogonplayer_internal(var_0, var_4, var_3);
  else {
    self.leaderdialogqueue[self.leaderdialogqueue.size] = var_0;
    self.leaderdialoglocqueue[self.leaderdialoglocqueue.size] = var_3;
  }
}

leaderdialog_trylockout(var_0, var_1) {
  var_2 = 2;

  if(isdefined(game["dialog"]["lockouts"][var_0])) {
    var_2 = game["dialog"]["lockouts"][var_0];

    if(var_2 == 0)
      return;
  }

  if(!isdefined(var_1.active_vo_lockouts))
    var_1.active_vo_lockouts = [];

  var_1.active_vo_lockouts[var_0] = 1;
  thread leaderdialog_lockoutcleardelayed(var_0, var_1, var_2);
}

leaderdialog_lockoutcleardelayed(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait(var_2);
  var_1.active_vo_lockouts[var_0] = undefined;
}

leaderdialog_islockedout(var_0, var_1) {
  if(isdefined(var_1.active_vo_lockouts)) {
    if(isdefined(var_1.active_vo_lockouts[var_0])) {
      if(isdefined(var_1.active_vo_lockouts[var_0] == 1))
        return 1;
    }
  }

  return 0;
}

leaderdialogonplayer_internal(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("playLeaderDialogOnPlayer");
  self endon("playLeaderDialogOnPlayer");

  if(isdefined(self.leaderdialoggroups[var_0])) {
    var_3 = var_0;
    var_0 = self.leaderdialoggroups[var_3];
    self.leaderdialoggroups[var_3] = undefined;
    self.leaderdialoggroup = var_3;
  }

  if(!isdefined(game["dialog"][var_0])) {
    return;
  }
  if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["leader_dialog"]))
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_2);

  if(issubstr(game["dialog"][var_0], "null")) {
    return;
  }
  if(isdefined(level.ishorde) && level.ishorde) {
    if(issubstr(var_0, "coop_gdn"))
      var_4 = var_0;
    else
      var_4 = "AT_anr0_" + game["dialog"][var_0];
  } else
    var_4 = game["voice"][var_1] + game["dialog"][var_0];

  var_5 = var_4;

  if(level.classicgamemode)
    var_4 = var_4 + "_cl";

  if(soundexists(var_4)) {
    if(leaderdialog_islockedout(game["dialog"][var_0], self)) {
      return;
    }
    self.leaderdialogactive = var_4;
    self playlocalannouncersound(var_4);
    leaderdialog_trylockout(game["dialog"][var_0], self);
  } else if(level.classicgamemode) {
    if(soundexists(var_5)) {

    } else {

    }
  } else {}

  wait 2.0;
  self.leaderdialoglocalsound = "";
  self.leaderdialogactive = "";
  self.leaderdialoggroup = "";

  if(self.leaderdialogqueue.size > 0) {
    var_6 = self.leaderdialogqueue[0];
    var_7 = self.leaderdialoglocqueue[0];

    for (var_8 = 1; var_8 < self.leaderdialogqueue.size; var_8++)
      self.leaderdialogqueue[var_8 - 1] = self.leaderdialogqueue[var_8];

    for (var_8 = 1; var_8 < self.leaderdialoglocqueue.size; var_8++)
      self.leaderdialoglocqueue[var_8 - 1] = self.leaderdialoglocqueue[var_8];

    self.leaderdialogqueue[var_8 - 1] = undefined;
    self.leaderdialoglocqueue[var_8 - 1] = undefined;
    thread leaderdialogonplayer_internal(var_6, var_1, var_7);
  }
}

getnextrelevantdialog() {
  for (var_0 = 0; var_0 < self.leaderdialogqueue.size; var_0++) {
    if(issubstr(self.leaderdialogqueue[var_0], "losing")) {
      if(self.team == "allies") {
        if(issubstr(level.axiscapturing, self.leaderdialogqueue[var_0]))
          return self.leaderdialogqueue[var_0];
        else
          common_scripts\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);
      } else if(issubstr(level.alliescapturing, self.leaderdialogqueue[var_0]))
        return self.leaderdialogqueue[var_0];
      else
        common_scripts\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);

      continue;
    }

    return level.alliescapturing[self.leaderdialogqueue];
  }
}

orderonqueueddialog() {
  self endon("disconnect");
  var_0 = [];
  var_0 = self.leaderdialogqueue;

  for (var_1 = 0; var_1 < self.leaderdialogqueue.size; var_1++) {
    if(issubstr(self.leaderdialogqueue[var_1], "losing")) {
      for (var_2 = var_1; var_2 >= 0; var_2--) {
        if(!issubstr(self.leaderdialogqueue[var_2], "losing") && var_2 != 0) {
          continue;
        }
        if(var_2 != var_1) {
          arrayinsertion(var_0, self.leaderdialogqueue[var_1], var_2);
          common_scripts\utility::array_remove(var_0, self.leaderdialogqueue[var_1]);
          break;
        }
      }
    }
  }

  self.leaderdialogqueue = var_0;
}

flushdialogonplayer() {
  self.leaderdialoggroups = [];
  self.leaderdialogqueue = [];
  self.leaderdialogactive = "";
  self.currentleaderdialoggroup = "";
  self notify("flush_dialog");
}

flushgroupdialog(var_0) {
  foreach(var_2 in level.players)
  var_2 flushgroupdialogonplayer(var_0);
}

arrayremovevalue(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  while (var_2 < var_0.size) {
    if(var_0[var_2] == var_1) {
      var_2++;
      continue;
    }

    if(var_2 != var_3)
      var_0[var_3] = var_0[var_2];

    var_2++;
    var_3++;
  }

  while (var_3 < var_0.size) {
    var_0[var_3] = undefined;
    var_3++;
  }
}

flushgroupdialogonplayer(var_0) {
  self.leaderdialoggroups[var_0] = undefined;
  arrayremovevalue(self.leaderdialogqueue, var_0);

  if(self.leaderdialogqueue.size == 0)
    flushdialogonplayer();
}

updatemainmenu() {
  if(self.pers["team"] == "spectator")
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
  else
    self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

updateobjectivetext() {
  if(self.pers["team"] == "spectator")
    self setclientdvar("cg_objectiveText", "");
  else {
    if(getwatcheddvar("scorelimit") > 0 && !isobjectivebased()) {
      if(level.splitscreen) {
        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
        return;
      }

      self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), getwatcheddvar("scorelimit"));
      return;
      return;
    }

    self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
  }
}

setobjectivetext(var_0, var_1) {
  game["strings"]["objective_" + var_0] = var_1;
}

setobjectivescoretext(var_0, var_1) {
  game["strings"]["objective_score_" + var_0] = var_1;
}

setobjectivehinttext(var_0, var_1) {
  game["strings"]["objective_hint_" + var_0] = var_1;
}

getobjectivetext(var_0) {
  return game["strings"]["objective_" + var_0];
}

getobjectivescoretext(var_0) {
  return game["strings"]["objective_score_" + var_0];
}

getobjectivehinttext(var_0) {
  return game["strings"]["objective_hint_" + var_0];
}

gettimepassed() {
  if(!isdefined(level.starttime) || !isdefined(level.discardtime))
    return 0;

  if(level.timerstopped)
    return level.timerpausetime - level.starttime - level.discardtime;
  else
    return gettime() - level.starttime - level.discardtime;
}

getunpausedtimepassedraw() {
  if(!isdefined(level.matchdurationstarttime))
    return 0;

  return gettime() - level.matchdurationstarttime;
}

getgametimepassedms() {
  var_0 = getmatchdata("gameLengthSeconds") * 1000;
  var_0 = var_0 + getunpausedtimepassedraw();
  return var_0;
}

getgametimepassedseconds() {
  var_0 = getgametimepassedms();
  var_1 = int(var_0 / 1000);
  return var_1;
}

gettimepassedpercentage() {
  return gettimepassed() / (gettimelimit() * 60 * 1000) * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

gettimedeciseconds() {
  return convertmillisecondstodecisecondsandclamptoshort(gettime());
}

gettimepasseddeciseconds() {
  return convertmillisecondstodecisecondsandclamptoshort(gettimepassed());
}

gettimepasseddecisecondsincludingrounds() {
  var_0 = getgametimepassedms();
  return convertmillisecondstodecisecondsandclamptoshort(var_0);
}

convertmillisecondstodecisecondsandclamptoshort(var_0) {
  return clamptoshort(var_0 / 100);
}

clamptoshort(var_0) {
  var_0 = int(var_0);

  if(var_0 > 32767)
    var_0 = 32767;

  if(var_0 < -32768)
    var_0 = -32768;

  return var_0;
}

clamptobyte(var_0) {
  var_0 = int(var_0);

  if(var_0 > 255)
    var_0 = 255;

  if(var_0 < 0)
    var_0 = 0;

  return var_0;
}

clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

isinkillcam() {
  return self.spectatekillcam;
}

isvalidclass(var_0) {
  return isdefined(var_0) && var_0 != "";
}

getvalueinrange(var_0, var_1, var_2) {
  if(var_0 > var_2)
    return var_2;
  else if(var_0 < var_1)
    return var_1;
  else
    return var_0;
}

logxpgains() {
  if(!isdefined(self.pers["summary"])) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_0 = 0;

  if(isdefined(self.timeplayed["total"]))
    var_0 = self.timeplayed["total"];

  reconevent("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s", self.pers["summary"]["xp"], var_0, self.pers["summary"]["score"], self.pers["summary"]["challenge"], self.pers["summary"]["match"], self.pers["summary"]["misc"], level.gametype);
}

registerroundswitchdvar(var_0, var_1, var_2, var_3) {
  registerwatchdvarint("roundswitch", var_1);
  var_0 = "scr_" + var_0 + "_roundswitch";
  level.roundswitchdvar = var_0;
  level.roundswitchmin = var_2;
  level.roundswitchmax = var_3;
  level.roundswitch = getdvarint(var_0, var_1);

  if(level.roundswitch < var_2)
    level.roundswitch = var_2;
  else if(level.roundswitch > var_3)
    level.roundswitch = var_3;
}

registerroundlimitdvar(var_0, var_1) {
  registerwatchdvarint("roundlimit", var_1);
}

registernumteamsdvar(var_0, var_1) {
  registerwatchdvarint("numTeams", var_1);
}

registerwinlimitdvar(var_0, var_1) {
  registerwatchdvarint("winlimit", var_1);
}

registerscorelimitdvar(var_0, var_1) {
  registerwatchdvarint("scorelimit", var_1);
}

registertimelimitdvar(var_0, var_1) {
  registerwatchdvarfloat("timelimit", var_1);
  setdvar("ui_timelimit", gettimelimit());
}

registerhalftimedvar(var_0, var_1) {
  registerwatchdvarint("halftime", var_1);
  setdvar("ui_halftime", gethalftime());
}

registernumlivesdvar(var_0, var_1) {
  registerwatchdvarint("numlives", var_1);
}

setovertimelimitdvar(var_0) {
  setdvar("overtimeTimeLimit", var_0);
}

get_damageable_player(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.isplayer = 1;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_sentry(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.issentry = 1;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_grenade(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_mine(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_player_pos(var_0) {
  return var_0.origin + (0, 0, 32);
}

getstancecenter() {
  if(self getstance() == "crouch")
    var_0 = self.origin + (0, 0, 24);
  else if(self getstance() == "prone")
    var_0 = self.origin + (0, 0, 10);
  else
    var_0 = self.origin + (0, 0, 32);

  return var_0;
}

get_damageable_grenade_pos(var_0) {
  return var_0.origin;
}

getdvarvec(var_0) {
  var_1 = getdvar(var_0);

  if(var_1 == "")
    return (0, 0, 0);

  var_2 = strtok(var_1, " ");

  if(var_2.size < 3)
    return (0, 0, 0);

  setdvar("tempR", var_2[0]);
  setdvar("tempG", var_2[1]);
  setdvar("tempB", var_2[2]);
  return (getdvarfloat("tempR"), getdvarfloat("tempG"), getdvarfloat("tempB"));
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size)
    return var_0;

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
    return getsubstr(var_0, 0, var_0.size - var_1.size);

  return var_0;
}

_takeweaponsexcept(var_0) {
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      continue;
    else
      self takeweapon(var_3);
  }
}

savedata() {
  var_0 = spawnstruct();
  var_0.offhandclass = self gettacticalweapon();
  var_0.actionslots = self.saved_actionslotdata;
  var_0.currentweapon = self getcurrentweapon();
  var_1 = self getweaponslistall();
  var_0.weapons = [];

  foreach(var_3 in var_1) {
    if(weaponinventorytype(var_3) == "exclusive") {
      continue;
    }
    if(weaponinventorytype(var_3) == "altmode") {
      continue;
    }
    var_4 = spawnstruct();
    var_4.name = var_3;
    var_4.clipammor = self getweaponammoclip(var_3, "right");
    var_4.clipammol = self getweaponammoclip(var_3, "left");
    var_4.stockammo = self getweaponammostock(var_3);

    if(isdefined(self.throwinggrenade) && self.throwinggrenade == var_3)
      var_4.stockammo--;

    var_0.weapons[var_0.weapons.size] = var_4;
  }

  self.script_savedata = var_0;
}

restoredata() {
  var_0 = self.script_savedata;
  self settacticalweapon(var_0.offhandclass);

  foreach(var_2 in var_0.weapons) {
    _giveweapon(var_2.name, int(tablelookup("mp\camoTable.csv", 1, self.loadoutprimarycamo, 0)));
    self setweaponammoclip(var_2.name, var_2.clipammor, "right");

    if(issubstr(var_2.name, "akimbo"))
      self setweaponammoclip(var_2.name, var_2.clipammol, "left");

    self setweaponammostock(var_2.name, var_2.stockammo);
  }

  foreach(var_6, var_5 in var_0.actionslots)
  _setactionslot(var_6, var_5.type, var_5.item);

  if(self getcurrentweapon() == "none") {
    var_2 = var_0.currentweapon;

    if(var_2 == "none")
      var_2 = common_scripts\utility::getlastweapon();

    self setspawnweapon(var_2);
    self switchtoweapon(var_2);
  }
}

setextrascore0(var_0) {
  self.extrascore0 = var_0;
  setpersstat("extrascore0", var_0);
}

setextrascore1(var_0) {
  self.extrascore1 = var_0;
  setpersstat("extrascore1", var_0);
}

_setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0].item = var_2;
  self setactionslot(var_0, var_1, var_2);
}

isfloat(var_0) {
  if(int(var_0) != var_0)
    return 1;

  return 0;
}

registerwatchdvarint(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnstruct();
  level.watchdvars[var_2].value = getdvarint(var_2, var_1);
  level.watchdvars[var_2].type = "int";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

registerwatchdvarfloat(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnstruct();
  level.watchdvars[var_2].value = getdvarfloat(var_2, var_1);
  level.watchdvars[var_2].type = "float";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

registerwatchdvar(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnstruct();
  level.watchdvars[var_2].value = getdvar(var_2, var_1);
  level.watchdvars[var_2].type = "string";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

setoverridewatchdvar(var_0, var_1) {
  var_0 = "scr_" + level.gametype + "_" + var_0;
  level.overridewatchdvars[var_0] = var_1;
}

getwatcheddvar(var_0) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(isdefined(level.overridewatchdvars) && isdefined(level.overridewatchdvars[var_0]))
    return level.overridewatchdvars[var_0];

  return level.watchdvars[var_0].value;
}

updatewatcheddvars() {
  while (game["state"] == "playing") {
    var_0 = getarraykeys(level.watchdvars);

    foreach(var_2 in var_0) {
      if(level.watchdvars[var_2].type == "string")
        var_3 = getproperty(var_2, level.watchdvars[var_2].value);
      else if(level.watchdvars[var_2].type == "float")
        var_3 = getfloatproperty(var_2, level.watchdvars[var_2].value);
      else
        var_3 = getintproperty(var_2, level.watchdvars[var_2].value);

      if(var_3 != level.watchdvars[var_2].value) {
        level.watchdvars[var_2].value = var_3;
        level notify(level.watchdvars[var_2].notifystring, var_3);
      }
    }

    wait 1.0;
  }
}

isroundbased() {
  if(!level.teambased)
    return 0;

  if(getwatcheddvar("winlimit") != 1 && getwatcheddvar("roundlimit") != 1)
    return 1;

  return 0;
}

isfirstround() {
  if(!level.teambased)
    return 1;

  if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] == 0)
    return 1;

  if(getwatcheddvar("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0)
    return 1;

  return 0;
}

islastround() {
  if(!level.teambased)
    return 1;

  if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] >= getwatcheddvar("roundlimit") - 1)
    return 1;

  if(getwatcheddvar("winlimit") > 1 && game["roundsWon"]["allies"] >= getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] >= getwatcheddvar("winlimit") - 1)
    return 1;

  return 0;
}

wasonlyround() {
  if(!level.teambased)
    return 1;

  if(isdefined(level.onlyroundoverride))
    return 0;

  if(getwatcheddvar("winlimit") == 1 && hitwinlimit())
    return 1;

  if(getwatcheddvar("roundlimit") == 1)
    return 1;

  if(isdefined(level.overridewasonlyround)) {
    if([
        [level.overridewasonlyround]
      ]())
      return 1;
  }

  return 0;
}

waslastround() {
  if(level.forcedend)
    return 1;

  if(!level.teambased)
    return 1;

  if(hitroundlimit() || hitwinlimit())
    return 1;

  return 0;
}

hitroundlimit() {
  if(getwatcheddvar("roundlimit") <= 0)
    return 0;

  return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

hitscorelimit() {
  if(isobjectivebased())
    return 0;

  if(getwatcheddvar("scorelimit") <= 0)
    return 0;

  if(level.teambased) {
    if(game["teamScores"]["allies"] >= getwatcheddvar("scorelimit") || game["teamScores"]["axis"] >= getwatcheddvar("scorelimit"))
      return 1;
  } else {
    for (var_0 = 0; var_0 < level.players.size; var_0++) {
      var_1 = level.players[var_0];

      if(isdefined(var_1.score) && var_1.score >= getwatcheddvar("scorelimit"))
        return 1;
    }
  }

  return 0;
}

hitwinlimit() {
  if(getwatcheddvar("winlimit") <= 0)
    return 0;

  if(!level.teambased)
    return 1;

  if(getroundswon("allies") >= getwatcheddvar("winlimit") || getroundswon("axis") >= getwatcheddvar("winlimit"))
    return 1;

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(getwatcheddvar("roundlimit"))
      return getwatcheddvar("roundlimit");
    else
      return getwatcheddvar("winlimit");
  } else
    return getwatcheddvar("scorelimit");
}

getroundswon(var_0) {
  return game["roundsWon"][var_0];
}

isobjectivebased() {
  return level.objectivebased;
}

gettimelimit() {
  if(inovertime()) {
    var_0 = float(getdvar("overtimeTimeLimit"));

    if(!isdefined(var_0))
      var_0 = 1;

    return var_0;
  }

  return getwatcheddvar("timelimit");
}

gethalftime() {
  if(inovertime())
    return 0;

  return getwatcheddvar("halftime");
}

inovertime() {
  return isdefined(game["status"]) && isovertimetext(game["status"]);
}

isovertimetext(var_0) {
  return var_0 == "overtime" || var_0 == "overtime_halftime";
}

gamehasstarted() {
  if(isdefined(level.gamehasstarted))
    return level.gamehasstarted;

  if(level.teambased)
    return level.hasspawned["axis"] && level.hasspawned["allies"];

  return level.maxplayercount > 1;
}

getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size)
    return undefined;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

getlivingplayers(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(level.teambased && isdefined(var_0)) {
      if(var_0 == var_3.pers["team"])
        var_1[var_1.size] = var_3;

      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

setusingremote(var_0) {
  if(isdefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_0;
  common_scripts\utility::_disableoffhandweapons();
  self notify("using_remote");
}

getremotename() {
  return self.usingremote;
}

freezecontrolswrapper(var_0) {
  if(isdefined(level.hostmigrationtimer) || is_true(self.phfrozen)) {
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self.controlsfrozen = var_0;
}

freezecontrolswrapperwithdelay(var_0, var_1) {
  wait(var_1);

  if(isdefined(self))
    freezecontrolswrapper(var_0);
}

clearusingremote() {
  if(isdefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;
  common_scripts\utility::_enableoffhandweapons();
  var_0 = self getcurrentweapon();

  if(var_0 == "none" || iskillstreakweapon(var_0))
    self switchtoweapon(common_scripts\utility::getlastweapon());

  freezecontrolswrapper(0);
  playerremotekillstreakshowhud();
  self notify("stopped_using_remote");
}

playerremotekillstreakhidehud() {
  self setclientomnvar("ui_killstreak_remote", 1);
}

playerremotekillstreakshowhud() {
  self setclientomnvar("ui_killstreak_remote", 0);
}

get_water_weapon() {
  if(isdefined(self.underwatermotiontype)) {
    if(self.underwatermotiontype == "shallow" && isdefined(level.shallow_water_weapon))
      return level.shallow_water_weapon;

    if(self.underwatermotiontype == "deep" && isdefined(level.deep_water_weapon))
      return level.deep_water_weapon;

    if(self.underwatermotiontype != "none" && isdefined(level.shallow_water_weapon))
      return level.shallow_water_weapon;
  }

  return "none";
}

isusingremote() {
  return isdefined(self.usingremote);
}

isinremotetransition() {
  return isdefined(self.remoteridetransition);
}

isrocketcorpse() {
  return isdefined(self.isrocketcorpse) && self.isrocketcorpse;
}

queuecreate(var_0) {
  if(!isdefined(level.queues))
    level.queues = [];

  level.queues[var_0] = [];
}

queueadd(var_0, var_1) {
  level.queues[var_0][level.queues[var_0].size] = var_1;
}

queueremovefirst(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level.queues[var_0]) {
    if(!isdefined(var_4)) {
      continue;
    }
    if(!isdefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  level.queues[var_0] = var_2;
  return var_1;
}

_giveweapon(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = -1;

  var_3 = 0;

  if(isdefined(self.pers["toggleScopeStates"]) && isdefined(self.pers["toggleScopeStates"][var_0]))
    var_3 = self.pers["toggleScopeStates"][var_0];

  if(issubstr(var_0, "akimbo") || isdefined(var_2) && var_2 == 1) {
    if(isagent(self))
      self giveweapon(var_0, var_1, 1, -1, 0);
    else
      self giveweapon(var_0, var_1, 1, -1, 0, self, var_3);
  } else if(isagent(self))
    self giveweapon(var_0, var_1, 0, -1, 0);
  else
    self giveweapon(var_0, var_1, 0, -1, 0, self, var_3);
}

_hasperk(var_0) {
  if(isdefined(self.perks) && isdefined(self.perks[var_0]))
    return 1;

  return 0;
}

giveperk(var_0, var_1, var_2) {
  _setperk(var_0, var_1, var_2);
}

_setperk(var_0, var_1, var_2) {
  self.perks[var_0] = 1;
  self.perksperkname[var_0] = var_0;
  self.perksuseslot[var_0] = var_1;

  if(isdefined(level.perksetfuncs[var_0]))
    self thread[[level.perksetfuncs[var_0]]]();

  var_3 = strip_suffix(var_0, "_lefthand");

  if(isdefined(var_2))
    self setperk(var_0, !isdefined(level.scriptperks[var_3]), var_1, var_2);
  else
    self setperk(var_0, !isdefined(level.scriptperks[var_3]), var_1);
}

_unsetperk(var_0) {
  self.perks[var_0] = undefined;
  self.perksperkname[var_0] = undefined;
  self.perksuseslot[var_0] = undefined;
  self.perksperkpower[var_0] = undefined;

  if(isdefined(level.perkunsetfuncs[var_0]))
    self thread[[level.perkunsetfuncs[var_0]]]();

  var_1 = strip_suffix(var_0, "_lefthand");
  self unsetperk(var_0, !isdefined(level.scriptperks[var_1]));
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(isdefined(level.perkunsetfuncs[var_2]))
      self[[level.perkunsetfuncs[var_2]]]();
  }

  self.perks = [];
  self.perksperkname = [];
  self.perksuseslot = [];
  self.perksperkpower = [];
  self.perkscustom = [];
  self clearperks();
}

cangiveability(var_0) {
  return _cangiveability(var_0);
}

_cangiveability(var_0) {
  if(!isdefined(level.abilitycansetfuncs) || !isdefined(level.abilitycansetfuncs[var_0]))
    return 1;

  return self[[level.abilitycansetfuncs[var_0]]]();
}

giveability(var_0, var_1) {
  _setability(var_0, var_1);
}

_setability(var_0, var_1) {
  self.abilities[var_0] = 1;

  if(isplayer(self)) {
    if(isdefined(level.abilitysetfuncs[var_0]))
      self thread[[level.abilitysetfuncs[var_0]]]();
  }

  self setperk(var_0, !isdefined(level.scriptabilities[var_0]), var_1);
}

_unsetability(var_0) {
  self.abilities[var_0] = undefined;

  if(isplayer(self)) {
    if(isdefined(level.abilityunsetfuncs[var_0]))
      self thread[[level.abilityunsetfuncs[var_0]]]();
  }

  self unsetperk(var_0, !isdefined(level.scriptabilities[var_0]));
}

_clearabilities() {
  if(isplayer(self)) {
    if(isdefined(level.abilityunsetfuncs[self.pers["ability"]]))
      self[[level.abilityunsetfuncs[self.pers["ability"]]]]();
  }

  self.abilities = [];
  self clearperks();
}

_hasability(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(var_1) {
    if(isdefined(self.abilities[var_0]) && self.abilities[var_0])
      return 1;
  } else if(isdefined(self.pers["ability"]) && self.pers["ability"] == var_0 && isdefined(self.pers["abilityOn"]) && self.pers["abilityOn"])
    return 1;

  return 0;
}

quicksort(var_0, var_1) {
  return quicksortmid(var_0, 0, var_0.size - 1, var_1);
}

quicksortmid(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isdefined(var_3))
    var_3 = ::quicksort_compare;

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while (var_5 > var_4) {
      while ([
          [var_3]
        ](var_0[var_4], var_6) && var_4 <= var_2 && var_5 > var_4)
        var_4++;

      while (![
          [var_3]
        ](var_0[var_5], var_6) && var_5 >= var_1 && var_5 >= var_4)
        var_5--;

      if(var_5 > var_4)
        var_0 = swap(var_0, var_4, var_5);
    }

    var_0 = swap(var_0, var_1, var_5);
    var_0 = quicksortmid(var_0, var_1, var_5 - 1, var_3);
    var_0 = quicksortmid(var_0, var_5 + 1, var_2, var_3);
  } else
    return var_0;

  return var_0;
}

quicksort_compare(var_0, var_1) {
  return var_0 <= var_1;
}

swap(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

_suicide() {
  if(isusingremote() && !isdefined(self.fauxdead))
    thread maps\mp\gametypes\_damage::playerkilled_internal(self, self, self, 10000, "MOD_SUICIDE", "h1_fraggrenade_mp", (0, 0, 0), "none", 0, 1116, 1, 0);
  else if(!isusingremote() && !isdefined(self.fauxdead))
    self suicide();
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isdefined(var_0.fauxdead))
    return 1;

  return 0;
}

waittill_any_timeout_pause_on_death_and_prematch(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();

  if(isdefined(var_1))
    thread common_scripts\utility::waittill_string_no_endon_death(var_1, var_6);

  if(isdefined(var_2))
    thread common_scripts\utility::waittill_string_no_endon_death(var_2, var_6);

  if(isdefined(var_3))
    thread common_scripts\utility::waittill_string_no_endon_death(var_3, var_6);

  if(isdefined(var_4))
    thread common_scripts\utility::waittill_string_no_endon_death(var_4, var_6);

  if(isdefined(var_5))
    thread common_scripts\utility::waittill_string_no_endon_death(var_5, var_6);

  var_6 thread _timeout_pause_on_death_and_prematch(var_0, self);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_timeout_pause_on_death_and_prematch(var_0, var_1) {
  self endon("die");

  for (var_2 = 0.05; var_0 > 0; var_0 = var_0 - var_2) {
    if(isplayer(var_1) && !isreallyalive(var_1))
      var_1 waittill("spawned_player");

    if(getdvarint("ui_inprematch"))
      level waittill("prematch_over");

    wait(var_2);
  }

  self notify("returned", "timeout");
}

playdeathsound() {
  if(isdefined(level.customplaydeathsound))
    self thread[[level.customplaydeathsound]]();
  else {
    var_0 = randomintrange(1, 8);

    if(self.team == "axis") {
      if(self hasfemalecustomizationmodel())
        self playsound("generic_death_enemy_fm_" + var_0);
      else
        self playsound("generic_death_enemy_" + var_0);
    } else {
      if(self hasfemalecustomizationmodel()) {
        self playsound("generic_death_friendly_fm_" + var_0);
        return;
      }

      self playsound("generic_death_friendly_" + var_0);
    }
  }
}

rankingenabled() {
  if(!isplayer(self))
    return 0;

  return level.rankedmatch && !self.usingonlinedataoffline;
}

privatematch() {
  return !level.onlinegame || getdvarint("xblive_privatematch");
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

setaltsceneobj(var_0, var_1, var_2, var_3) {}

endsceneondeath(var_0) {
  self endon("altscene");
  var_0 waittill("death");
  self notify("end_altScene");
}

getmapname() {
  return getdvar("mapname");
}

getgametypenumlives() {
  return getwatcheddvar("numlives");
}

arrayinsertion(var_0, var_1, var_2) {
  if(var_0.size != 0) {
    for (var_3 = var_0.size; var_3 >= var_2; var_3--)
      var_0[var_3 + 1] = var_0[var_3];
  }

  var_0[var_2] = var_1;
}

getproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvar(var_0, var_1);
  return var_2;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

getfloatproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

ischangingweapon() {
  return isdefined(self.changingweapon);
}

killshouldaddtokillstreak(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_0.requireddeathcount) && isdefined(self.deaths) && self.deaths != var_0.requireddeathcount)
    return 0;

  return 1;
}

isjuggernaut() {
  if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1)
    return 1;

  if(isdefined(self.isjuggernautdef) && self.isjuggernautdef == 1)
    return 1;

  if(isdefined(self.isjuggernautgl) && self.isjuggernautgl == 1)
    return 1;

  if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
    return 1;

  if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
    return 1;

  return 0;
}

iskillstreakweapon(var_0) {
  if(!isdefined(var_0))
    return 0;

  if(var_0 == "none")
    return 0;

  switch (var_0) {
    case "helicopter_mp":
    case "airstrike_mp":
    case "radar_mp":
    case "cobra_20mm_mp":
    case "hind_ffar_mp":
    case "cobra_ffar_mp":
    case "artillery_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

isdestructibleweapon(var_0) {
  if(!isdefined(var_0))
    return 0;

  switch (var_0) {
    case "barrel_mp":
    case "destructible_car":
    case "destructible_toy":
    case "destructible":
      return 1;
  }

  return 0;
}

isaugmentedgamemode() {
  return getdvarint("scr_game_high_jump", 0);
}

isdivisionmode() {
  return getdvarint("scr_game_division", 0);
}

isbombsiteweapon(var_0) {
  if(!isdefined(var_0))
    return 0;

  switch (var_0) {
    case "bomb_site_mp":
    case "briefcase_bomb_mp_defuse_mp":
    case "briefcase_bomb_mp":
      return 1;
  }

  return 0;
}

isenvironmentweapon(var_0) {
  if(!isdefined(var_0))
    return 0;

  if(var_0 == "turret_minigun_mp")
    return 1;

  if(issubstr(var_0, "_bipod_"))
    return 1;

  return 0;
}

islootweapon(var_0) {
  return 0;
}

ismeleeweapon(var_0) {
  switch (var_0) {
    case "h1_meleeshovel_mp":
    case "h1_meleepaddle_mp":
    case "h1_meleeicepick_mp":
    case "h1_meleebottle_mp":
    case "h1_meleeblade_mp":
    case "h1_meleebayonet_mp":
      return 1;
    default:
      return 0;
  }
}

getweaponnametokens(var_0) {
  return strtok(var_0, "_");
}

getweaponclass(var_0) {
  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup("mp\statstable.csv", 4, var_1, 2);

  if(var_2 == "") {
    var_3 = strip_suffix(var_0, "_lefthand");
    var_3 = strip_suffix(var_3, "_mp");
    var_2 = tablelookup("mp\statstable.csv", 4, var_3, 2);
  }

  if(isenvironmentweapon(var_0))
    var_2 = "weapon_mg";
  else if(iskillstreakweapon(var_0))
    var_2 = "killstreak";
  else if(var_0 == "none")
    var_2 = "other";
  else if(var_2 == "")
    var_2 = "other";

  return var_2;
}

getweaponattachmentarrayfromstats(var_0) {
  var_0 = getbaseweaponname(var_0);

  if(!isdefined(level.weaponattachments[var_0])) {
    var_1 = [];

    for (var_2 = 0; var_2 <= 29; var_2++) {
      var_3 = tablelookup("mp\statsTable.csv", 4, var_0, 11 + var_2);

      if(var_3 == "") {
        break;
      }

      var_1[var_1.size] = var_3;
    }

    level.weaponattachments[var_0] = var_1;
  }

  return level.weaponattachments[var_0];
}

getweaponattachmentfromstats(var_0, var_1) {
  var_0 = getbaseweaponname(var_0);
  return tablelookup("mp\statsTable.csv", 4, var_0, 11 + var_1);
}

getbasearrayforattachkit(var_0) {
  if(!isdefined(level.baseattachkits))
    level.baseattachkits = [];

  if(!isdefined(level.baseattachkits[var_0])) {
    var_1 = 2;
    var_2 = 5;
    var_3 = tablelookuprownum("mp\attachkits.csv", 1, var_0);
    var_4 = [];

    for (var_5 = var_1; var_5 <= var_2; var_5++) {
      var_6 = tablelookupbyrow("mp\attachkits.csv", var_3, var_5);

      if(var_6 != "")
        var_4[var_4.size] = var_6;
    }

    level.baseattachkits[var_0] = var_4;
  }

  return level.baseattachkits[var_0];
}

getgroupforattachkitbase(var_0) {
  if(!isdefined(level.attachkitgroup))
    level.attachkitgroup = [];

  if(!isdefined(level.attachkitgroup[var_0])) {
    var_1 = 2;
    var_2 = tablelookuprownum("mp\attachmentbase.csv", 1, var_0);
    level.attachkitgroup[var_0] = tablelookupbyrow("mp\attachmentbase.csv", var_2, var_1);
  }

  return level.attachkitgroup[var_0];
}

getbaseweaponname(var_0) {
  if(!isdefined(var_0) || var_0 == "none" || var_0 == "")
    return var_0;

  var_1 = getweaponnametokens(var_0);
  var_2 = "";

  if(var_1[0] == "iw5" || var_1[0] == "iw6" || var_1[0] == "s1" || var_1[0] == "h1")
    var_2 = var_1[0] + "_" + var_1[1];
  else if(var_1[0] == "alt")
    var_2 = var_1[1] + "_" + var_1[2];
  else if(var_1.size > 1 && (var_1[1] == "grenade" || var_1[1] == "marker"))
    var_2 = var_1[0] + "_" + var_1[1];
  else
    var_2 = var_1[0];

  return var_2;
}

playsoundinspace(var_0, var_1) {
  playsoundatpos(var_1, var_0);
}

limitdecimalplaces(var_0, var_1) {
  var_2 = 1;

  for (var_3 = 0; var_3 < var_1; var_3++)
    var_2 = var_2 * 10;

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 = var_4 / var_2;
  return var_4;
}

rounddecimalplaces(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = "nearest";

  var_3 = 1;

  for (var_4 = 0; var_4 < var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(var_2 == "up")
    var_6 = ceil(var_5);
  else if(var_2 == "down")
    var_6 = floor(var_5);
  else
    var_6 = var_5 + 0.5;

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

playerforclientid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.clientid == var_0)
      return var_2;
  }

  return undefined;
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isdefined(var_1[1])) {
    var_3 = 1;

    for (var_4 = 0; var_4 < var_1[1].size; var_4++)
      var_3 = var_3 * 0.1;

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

setselfunusuable() {
  self makeunusable();

  foreach(var_1 in level.players)
  self disableplayeruse(var_1);
}

maketeamusable(var_0) {
  self makeusable();
  thread _updateteamusable(var_0);
}

_updateteamusable(var_0) {
  self endon("death");

  for (;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
    }

    level waittill("joined_team");
  }
}

makeenemyusable(var_0) {
  self makeusable();
  thread _updateenemyusable(var_0);
}

_updateenemyusable(var_0) {
  self endon("death");
  var_1 = var_0.team;

  for (;;) {
    if(level.teambased) {
      foreach(var_3 in level.players) {
        if(var_3.team != var_1) {
          self enableplayeruse(var_3);
          continue;
        }

        self disableplayeruse(var_3);
      }
    } else {
      foreach(var_3 in level.players) {
        if(var_3 != var_0) {
          self enableplayeruse(var_3);
          continue;
        }

        self disableplayeruse(var_3);
      }
    }

    level waittill("joined_team");
  }
}

getnextlifeid() {
  var_0 = getmatchdata("lifeCount");

  if(var_0 < level.maxlives) {
    setmatchdata("lifeCount", var_0 + 1);
    return var_0;
  } else
    return level.maxlives - 1;
}

initgameflags() {
  if(!isdefined(game["flags"]))
    game["flags"] = [];
}

gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

gameflag(var_0) {
  return game["flags"][var_0];
}

gameflagexists(var_0) {
  return isdefined(game["flags"][var_0]);
}

gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

gameflagclear(var_0) {
  game["flags"][var_0] = 0;
}

gameflagwait(var_0) {
  while (!gameflag(var_0))
    level waittill(var_0);
}

isbulletdamage(var_0) {
  var_1 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0))
    return 1;

  return 0;
}

isfmjdamage(var_0, var_1, var_2) {
  return isdefined(var_2) && isplayer(var_2) && var_2 _hasperk("specialty_bulletpenetration") && isdefined(var_1) && isbulletdamage(var_1);
}

initlevelflags() {
  if(!isdefined(level.levelflags))
    level.levelflags = [];
}

levelflaginit(var_0, var_1) {
  level.levelflags[var_0] = var_1;
}

levelflag(var_0) {
  return level.levelflags[var_0];
}

levelflagset(var_0) {
  level.levelflags[var_0] = 1;
  level notify(var_0);
}

levelflagclear(var_0) {
  level.levelflags[var_0] = 0;
  level notify(var_0);
}

levelflagwait(var_0) {
  while (!levelflag(var_0))
    level waittill(var_0);
}

levelflagwaitopen(var_0) {
  while (levelflag(var_0))
    level waittill(var_0);
}

invirtuallobby() {
  if(!isdefined(level.virtuallobbyactive) || level.virtuallobbyactive == 0)
    return 0;

  return 1;
}

initglobals() {
  if(!isdefined(level.global_tables)) {
    level.global_tables["killstreakTable"] = spawnstruct();
    level.global_tables["killstreakTable"].path = "mp\killstreakTable.csv";
    level.global_tables["killstreakTable"].index_col = 0;
    level.global_tables["killstreakTable"].ref_col = 1;
    level.global_tables["killstreakTable"].name_col = 2;
    level.global_tables["killstreakTable"].desc_col = 3;
    level.global_tables["killstreakTable"].adrenaline_col = 4;
    level.global_tables["killstreakTable"].earned_hint_col = 5;
    level.global_tables["killstreakTable"].sound_col = 6;
    level.global_tables["killstreakTable"].earned_dialog_col = 7;
    level.global_tables["killstreakTable"].allies_dialog_col = 8;
    level.global_tables["killstreakTable"].opfor_dialog_col = 9;
    level.global_tables["killstreakTable"].enemy_use_dialog_col = 10;
    level.global_tables["killstreakTable"].weapon_col = 11;
    level.global_tables["killstreakTable"].score_col = 12;
    level.global_tables["killstreakTable"].icon_col = 13;
    level.global_tables["killstreakTable"].overhead_icon_col = 14;
    level.global_tables["killstreakTable"].overhead_icon_col_plus1 = 15;
    level.global_tables["killstreakTable"].overhead_icon_col_plus2 = 16;
    level.global_tables["killstreakTable"].overhead_icon_col_plus3 = 17;
    level.global_tables["killstreakTable"].dpad_icon_col = 18;
    level.global_tables["killstreakTable"].unearned_icon_col = 19;
  }
}

iskillstreakdenied() {
  if(invirtuallobby())
    return 0;

  return isemped() || isairdenied();
}

isemped() {
  if(self.team == "spectator")
    return 0;

  if(invirtuallobby())
    return 0;

  return 0;
}

isempedbykillstreak() {
  if(self.team == "spectator")
    return 0;

  if(invirtuallobby())
    return 0;

  return 0;
}

isairdenied() {
  return 0;
}

isnuked() {
  if(self.team == "spectator")
    return 0;

  return isdefined(self.nuked);
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0)
      return var_2;
  }

  return undefined;
}

teamplayercardsplash(var_0, var_1, var_2, var_3) {
  if(level.hardcoremode) {
    return;
  }
  foreach(var_5 in level.players) {
    if(isdefined(var_2) && var_5.team != var_2) {
      continue;
    }
    if(!isplayer(var_5)) {
      continue;
    }
    var_5 thread maps\mp\gametypes\_hud_message::playercardsplashnotify(var_0, var_1, var_3);
  }
}

iscacprimaryweapon(var_0) {
  switch (getweaponclass(var_0)) {
    case "weapon_special":
    case "weapon_heavy":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_riot":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    default:
      return 0;
  }
}

iscacsecondaryweapon(var_0) {
  switch (getweaponclass(var_0)) {
    case "weapon_sec_special":
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_projectile":
      return 1;
    default:
      return 0;
  }
}

iscacmeleeweapon(var_0) {
  if(var_0 == "none")
    return 0;

  switch (getweaponclass(var_0)) {
    case "weapon_melee":
      return 1;
    default:
      return 0;
  }
}

getlastlivingplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isdefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!isreallyalive(var_3) && !var_3 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    var_1 = var_3;
  }

  return var_1;
}

getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!isreallyalive(var_2) && !var_2 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

waittillrecoveredhealth(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_2 = 0;

  if(!isdefined(var_1))
    var_1 = 0.05;

  if(!isdefined(var_0))
    var_0 = 0;

  for (;;) {
    if(self.health != self.maxhealth)
      var_2 = 0;
    else
      var_2 = var_2 + var_1;

    wait(var_1);

    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }

  return;
}

isattachmentsniperscopedefault(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  return isattachmentsniperscopedefaulttokenized(var_2, var_1);
}

isattachmentsniperscopedefaulttokenized(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isdefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "alt")
      var_3 = 1;

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "iw5" || var_0[var_3] == "iw6" || var_0[var_3] == "h1")) {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper")
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
    }
  }

  return var_2;
}

getweaponattachmentsbasenames(var_0) {
  var_1 = getweaponattachments(var_0);

  foreach(var_4, var_3 in var_1)
  var_1[var_4] = attachmentmap_tobase(var_3);

  return var_1;
}

getattachmentlistbasenames() {
  var_0 = [];
  var_1 = 0;

  for (var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 4); var_2 != ""; var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 4)) {
    if(!common_scripts\utility::array_contains(var_0, var_2))
      var_0[var_0.size] = var_2;

    var_1++;
  }

  return var_0;
}

getattachmentlistuniqenames() {
  var_0 = [];
  var_1 = 0;

  for (var_2 = tablelookupbyrow("mp\attachoverrides.csv", var_1, 2); var_2 != ""; var_2 = tablelookupbyrow("mp\attachoverrides.csv", var_1, 2)) {
    var_0[var_0.size] = var_2;
    var_1++;
  }

  return var_0;
}

buildattachmentmaps() {
  var_0 = getattachmentlistuniqenames();
  level.attachmentmap_uniquetobase = [];

  foreach(var_2 in var_0) {
    var_3 = tablelookup("mp\attachoverrides.csv", 2, var_2, 1);

    if(var_2 == var_3) {
      continue;
    }
    level.attachmentmap_uniquetobase[var_2] = var_3;
  }
}

attachmentmap_tobase(var_0) {
  if(isdefined(level.attachmentmap_uniquetobase[var_0]))
    var_0 = level.attachmentmap_uniquetobase[var_0];

  return var_0;
}

_objective_delete(var_0) {
  objective_delete(var_0);

  if(!isdefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_0;
  } else
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_0;
}

touchingbadtrigger() {
  var_0 = getentarray("trigger_hurt", "classname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2))
      return 1;
  }

  var_4 = getentarray("radiation", "targetname");

  foreach(var_2 in var_4) {
    if(self istouching(var_2))
      return 1;
  }

  if(isdefined(level.ishorde) && level.ishorde) {
    if(getmapname() == "mp_torqued") {
      if(isdefined(level.hordeavalanche) && level.hordeavalanche && isdefined(level.dyneventavalanche.status) && level.dyneventavalanche.status != "post_avalanche") {
        var_7 = getentarray("quake_kill_volume01", "targetname");

        foreach(var_9 in var_7) {
          if(self istouching(var_9))
            return 1;
        }
      }
    } else if(getmapname() == "mp_lost") {
      foreach(var_12 in level.hordekilltriggers) {
        if(self istouching(var_12))
          return 1;
      }
    }
  }

  if(getdvar("g_gametype") == "hp" && isdefined(level.zone) && isdefined(level.zone.trig) && self istouching(level.zone.trig))
    return 1;

  return 0;
}

setthirdpersondof(var_0) {
  if(var_0)
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  else
    self setdepthoffield(0, 0, 512, 512, 4, 0);
}

killtrigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);

  for (;;) {
    var_3 waittill("trigger", var_4);

    if(!isplayer(var_4)) {
      continue;
    }
    var_4 suicide();
  }
}

findisfacing(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_4 = anglestoforward(var_0.angles);
  var_5 = var_1.origin - var_0.origin;
  var_4 = var_4 * (1, 1, 0);
  var_5 = var_5 * (1, 1, 0);
  var_5 = vectornormalize(var_5);
  var_4 = vectornormalize(var_4);
  var_6 = vectordot(var_5, var_4);

  if(var_6 >= var_3)
    return 1;
  else
    return 0;
}

drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for (var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

drawsphere(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for (var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

setrecoilscale(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = 0;

  if(!isdefined(self.recoilscale))
    self.recoilscale = var_0;
  else
    self.recoilscale = self.recoilscale + var_0;

  if(isdefined(var_1)) {
    if(isdefined(self.recoilscale) && var_1 < self.recoilscale)
      var_1 = self.recoilscale;

    var_2 = 100 - var_1;
  } else
    var_2 = 100 - self.recoilscale;

  if(var_2 < 0)
    var_2 = 0;

  if(var_2 > 100)
    var_2 = 100;

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

cleanarray(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isdefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_4];
  }

  return var_1;
}

notusableforjoiningplayers(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");

  for (;;) {
    level waittill("player_spawned", var_1);

    if(isdefined(var_1) && var_1 != var_0)
      self disableplayeruse(var_1);
  }
}

isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

disableallstreaks() {
  level.killstreaksdisabled = 1;
}

enableallstreaks() {
  level.killstreaksdisabled = undefined;
}

validateusestreak(var_0, var_1) {
  if(isdefined(var_0))
    var_2 = var_0;
  else {
    var_3 = self.pers["killstreaks"];
    var_2 = var_3[self.killstreakindexweapon].streakname;
  }

  if(isdefined(level.killstreaksdisabled) && level.killstreaksdisabled)
    return 0;

  if(!self isonground() && isridekillstreak(var_2))
    return 0;

  if(isusingremote() || isinremotetransition())
    return 0;

  if(isdefined(self.selectinglocation))
    return 0;

  if(shouldpreventearlyuse(var_2) && level.killstreakrounddelay) {
    var_4 = 0;

    if(isdefined(level.prematch_done_time))
      var_4 = (gettime() - level.prematch_done_time) / 1000;

    if(var_4 < level.killstreakrounddelay) {
      var_5 = int(level.killstreakrounddelay - var_4 + 0.5);

      if(!var_5)
        var_5 = 1;

      if(!(isdefined(var_1) && var_1))
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", var_5);

      return 0;
    }
  }

  if(isemped() && (!isdefined(level.iszombiegame) || !level.iszombiegame)) {
    if(!(isdefined(var_1) && var_1)) {
      if(isdefined(level.emptimeremaining) && level.emptimeremaining > 0)
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP", level.emptimeremaining);
      else if(isdefined(self.empendtime) && int((self.empendtime - gettime()) / 1000) > 0)
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", int((self.empendtime - gettime()) / 1000));
    }

    return 0;
  }

  if(self isusingturret() && (isridekillstreak(var_2) || iscarrykillstreak(var_2))) {
    if(!(isdefined(var_1) && var_1))
      self iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");

    return 0;
  }

  if(isdefined(self.laststand) && !_hasperk("specialty_finalstand")) {
    if(!(isdefined(var_1) && var_1))
      self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");

    return 0;
  }

  if(!common_scripts\utility::isweaponenabled())
    return 0;

  return 1;
}

isridekillstreak(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

iscarrykillstreak(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

shouldpreventearlyuse(var_0) {
  return 0;
}

iskillstreakaffectedbyemp(var_0) {
  switch (var_0) {
    default:
      return 1;
  }
}

iskillstreakaffectedbyjammer(var_0) {
  return iskillstreakaffectedbyemp(var_0) && !isflyingkillstreak(var_0);
}

isflyingkillstreak(var_0) {
  switch (var_0) {
    default:
      return 1;
  }
}

isallteamstreak(var_0) {
  var_1 = getkillstreakallteamstreak(var_0);

  if(!isdefined(var_1))
    return 0;

  if(int(var_1) == 1)
    return 1;

  return 0;
}

getkillstreakrownum(var_0) {
  return tablelookuprownum(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0);
}

getkillstreakindex(var_0) {
  var_1 = "mp\killstreakTable.csv";
  var_2 = 0;
  var_3 = 1;
  var_4 = tablelookup(var_1, var_3, var_0, var_2);

  if(var_4 == "")
    var_5 = -1;
  else
    var_5 = int(var_4);

  return var_5;
}

getkillstreakreference(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].ref_col);
}

getkillstreakname(var_0) {
  return tablelookupistring(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].name_col);
}

getkillstreakdescription(var_0) {
  return tablelookupistring(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].desc_col);
}

getkillstreakkills(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].adrenaline_col);
}

getkillstreakearnedhint(var_0) {
  return tablelookupistring(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].earned_hint_col);
}

getkillstreaksound(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].sound_col);
}

getkillstreakearneddialog(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].earned_dialog_col);
}

getkillstreakalliesdialog(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].allies_dialog_col);
}

getkillstreakenemydialog(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].enemy_dialog_col);
}

getkillstreakenemyusedialog(var_0) {
  return int(tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].enemy_use_dialog_col));
}

getkillstreakweapon(var_0, var_1) {
  if(isdefined(var_1) && var_1.size > 0) {
    var_2 = _getmodulekillstreakweapon(var_0, var_1);

    if(isdefined(var_2))
      return var_2;
  }

  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].weapon_col);
}

_getmodulekillstreakweapon(var_0, var_1) {}

getkillstreakscore(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].score_col);
}

getkillstreakicon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].icon_col);
}

getkillstreakoverheadicon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].overhead_icon_col);
}

getkillstreakdpadicon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].dpad_icon_col);
}

getkillstreakunearnedicon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].unearned_icon_col);
}

getkillstreakallteamstreak(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].all_team_streak_col);
}

currentactivevehiclecount(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;

  var_1 = var_0;

  if(isdefined(level.helis))
    var_1 = var_1 + level.helis.size;

  if(isdefined(level.littlebirds))
    var_1 = var_1 + level.littlebirds.size;

  if(isdefined(level.ugvs))
    var_1 = var_1 + level.ugvs.size;

  if(isdefined(level.ishorde) && level.ishorde) {
    if(isdefined(level.flying_attack_drones))
      var_1 = var_1 + level.flying_attack_drones.size;

    if(isdefined(level.trackingdrones))
      var_1 = var_1 + level.trackingdrones.size;
  }

  return var_1;
}

maxvehiclesallowed() {
  return 8;
}

incrementfauxvehiclecount() {
  level.fauxvehiclecount++;
}

decrementfauxvehiclecount() {
  level.fauxvehiclecount--;

  if(level.fauxvehiclecount < 0)
    level.fauxvehiclecount = 0;
}

lightweightscalar(var_0) {
  return 1.07;
}

allowteamchoice() {
  if(!isshipbuild() && getdvarint("scr_skipclasschoice", 0) > 0)
    return 0;

  if(ishodgepodgemm())
    return 0;

  var_0 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 4));
  return var_0;
}

allowclasschoice() {
  if(!isshipbuild() && getdvarint("scr_skipclasschoice", 0) > 0)
    return 0;

  if(level.oldschool)
    return 0;

  if(ishodgepodgemm() || ishodgepodgerpgonly())
    return 0;

  if(ishodgepodgeph() && (!level.madpropsmode || isdefined(self.team) && level.madpropsmode && self.team == game["defenders"]))
    return 0;

  var_0 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 5));
  return var_0;
}

showgenericmenuonmatchstart() {
  if(allowclasschoice())
    return 0;

  if(ishodgepodgeph())
    return 1;

  if(matchmakinggame() && self.sessionteam != "none")
    var_0 = 0;
  else if(!matchmakinggame() && !forceautoassign() && allowteamchoice())
    var_0 = 1;
  else
    var_0 = 0;

  if(var_0)
    return 0;

  if(level.oldschool)
    return 1;

  if(ishodgepodgemm())
    return 1;

  var_1 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 8));
  return var_1;
}

forceautoassign() {
  if(ishodgepodgemm())
    return 1;

  var_0 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 10));
  return var_0;
}

isbuffequippedonweapon(var_0, var_1) {
  return 0;
}

setcommonrulesfrommatchrulesdata(var_0) {
  var_1 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + level.gametype + "_timeLimit", var_1);
  registertimelimitdvar(level.gametype, var_1);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + level.gametype + "_scoreLimit", var_2);
  registerscorelimitdvar(level.gametype, var_2);
  setdynamicdvar("scr_game_matchstarttime", getmatchrulesdata("commonOption", "preMatchTimer"));
  setdynamicdvar("scr_game_roundstarttime", getmatchrulesdata("commonOption", "preRoundTimer"));
  setdynamicdvar("scr_game_suicidespawndelay", getmatchrulesdata("commonOption", "suicidePenalty"));
  setdynamicdvar("scr_team_teamkillspawndelay", getmatchrulesdata("commonOption", "teamKillPenalty"));
  setdynamicdvar("scr_team_teamkillkicklimit", getmatchrulesdata("commonOption", "teamKillKickLimit"));
  var_3 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + level.gametype + "_numLives", var_3);
  registernumlivesdvar(level.gametype, var_3);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = 0;
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_lockspectatorpov", getmatchrulesdata("commonOption", "spectateModePOV"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay", getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar("scr_" + level.gametype + "_waverespawndelay", getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.customclasspickcount = getmatchrulesdata("commonOption", "classPickCount");
  setdynamicdvar("scr_game_disablesprint", getmatchrulesdata("commonOption", "disableSprint"));
  setdynamicdvar("scr_game_deleteturrets", getmatchrulesdata("commonOption", "deleteTurrets"));
  setdynamicdvar("scr_game_hardpoints", 1);
  setdynamicdvar("scr_game_perks", 1);
  setdynamicdvar("g_hardcore", getmatchrulesdata("commonOption", "hardcoreModeOn"));
  setdynamicdvar("scr_thirdPerson", getmatchrulesdata("commonOption", "forceThirdPersonView"));
  setdynamicdvar("camera_thirdPerson", getmatchrulesdata("commonOption", "forceThirdPersonView"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isdefined(var_0))
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "ffType"));

  setdynamicdvar("scr_game_killstreakdelay", getmatchrulesdata("commonOption", "streakGracePeriod"));
  setdynamicdvar("scr_game_chatterDisabled", getmatchrulesdata("commonOption", "chatterDisabled"));
  level.chatterdisabled = getintproperty("scr_game_chatterDisabled", 0);
  level.announcerdisabled = getmatchrulesdata("commonOption", "announcerDisabled");
  level.matchrules_switchteamdisabled = getmatchrulesdata("commonOption", "switchTeamDisabled");
  level.grenadegraceperiod = getmatchrulesdata("commonOption", "grenadeGracePeriod");
  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));
  setdynamicdvar("g_oldschool", getmatchrulesdata("commonOption", "oldSchoolModeOn"));
  setdynamicdvar("scr_killstreak_kills_uav", getmatchrulesdata("commonOption", "killstreakUAVKills"));
  setdynamicdvar("scr_killstreak_kills_airstrike", getmatchrulesdata("commonOption", "killstreakAirStrikeKills"));
  setdynamicdvar("scr_killstreak_kills_heli", getmatchrulesdata("commonOption", "killstreakHeliKills"));
  setdynamicdvar("scr_killcount_persists", getmatchrulesdata("commonOption", "killCountPersists"));
}

reinitializematchrulesonmigration() {
  for (;;) {
    level waittill("host_migration_begin");
    [
      [level.initializematchrules]
    ]();
  }
}

reinitializethermal(var_0) {
  self endon("disconnect");

  if(isdefined(var_0))
    var_0 endon("death");

  for (;;) {
    level waittill("host_migration_begin");

    if(isdefined(self.lastvisionsetthermal))
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
  }
}

getmatchrulesspecialclass(var_0, var_1) {
  var_2 = [];
  var_2["loadoutPrimary"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "weapon");
  var_3 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "kit", "attachKit");
  var_4 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "kit", "furnitureKit");
  var_2["loadoutPrimaryAttachKit"] = tablelookup("mp\attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
  var_2["loadoutPrimaryFurnitureKit"] = tablelookup("mp\furniturekits.csv", 0, common_scripts\utility::tostring(var_4), 1);
  var_2["loadoutPrimaryCamo"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryReticle"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutSecondary"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "weapon");
  var_3 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "kit", "attachKit");
  var_4 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "kit", "furnitureKit");
  var_2["loadoutSecondaryAttachKit"] = tablelookup("mp\attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
  var_2["loadoutSecondaryFurnitureKit"] = tablelookup("mp\furniturekits.csv", 0, common_scripts\utility::tostring(var_4), 1);
  var_2["loadoutSecondaryCamo"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryReticle"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutEquipment"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipment", 0);
  var_2["loadoutOffhand"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipment", 1);

  for (var_5 = 0; var_5 < 3; var_5++)
    var_2["loadoutPerks"][var_5] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "perkSlots", var_5);

  var_2["loadoutMelee"] = "none";
  return var_2;
}

recipeclassapplyjuggernaut(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isdefined(level.ishorde)) {
    if(level.ingraceperiod && !self.hasdonecombat)
      self waittill("applyLoadout");
    else
      self waittill("spawned_player");
  } else
    self waittill("applyLoadout");

  if(var_0) {
    self notify("lost_juggernaut");
    wait 0.5;
  }

  if(!isdefined(self.isjuiced)) {
    self.movespeedscaler = 0.7;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
  }

  self.juggmovespeedscaler = 0.7;
  self disableweaponpickup();

  if(!getdvarint("camera_thirdPerson") && !isdefined(level.ishorde)) {
    self.juggernautoverlay = newclienthudelem(self);
    self.juggernautoverlay.x = 0;
    self.juggernautoverlay.y = 0;
    self.juggernautoverlay.alignx = "left";
    self.juggernautoverlay.aligny = "top";
    self.juggernautoverlay.horzalign = "fullscreen";
    self.juggernautoverlay.vertalign = "fullscreen";
    self.juggernautoverlay setshader(level.juggsettings["juggernaut"].overlay, 640, 480);
    self.juggernautoverlay.sort = -10;
    self.juggernautoverlay.archived = 1;
    self.juggernautoverlay.hidein3rdperson = 1;
  }

  if(level.gametype != "jugg" || isdefined(level.matchrules_showjuggradaricon) && level.matchrules_showjuggradaricon)
    self setperk("specialty_radarjuggernaut", 1, 0);

  if(isdefined(self.isjuggmodejuggernaut) && self.isjuggmodejuggernaut) {
    var_1 = spawn("script_model", self.origin);
    var_1.team = self.team;
    var_1 makeportableradar(self);
    self.personalradar = var_1;
  }

  level notify("juggernaut_equipped", self);
}

updatesessionstate(var_0) {
  var_1 = self.sessionstate;
  self.sessionstate = var_0;
  self setclientomnvar("ui_session_state", var_0);

  if(var_1 != var_0)
    level notify("playerSessionStateChanged", self);
}

cac_getcustomclassloc() {
  if(isdefined(level.forcecustomclassloc))
    return level.forcecustomclassloc;

  if(getdvarint("xblive_privatematch") || issystemlink())
    return "privateMatchCustomClasses";
  else
    return "customClasses";
}

getclassindex(var_0) {
  return level.classmap[var_0];
}

isteaminlaststand() {
  var_0 = getlivingplayers(self.team);

  foreach(var_2 in var_0) {
    if(var_2 != self && (!isdefined(var_2.laststand) || !var_2.laststand))
      return 0;
  }

  return 1;
}

killteaminlaststand(var_0) {
  var_1 = getlivingplayers(var_0);

  foreach(var_3 in var_1) {
    if(isdefined(var_3.laststand) && var_3.laststand)
      var_3 thread maps\mp\gametypes\_damage::dieaftertime(randomintrange(1, 3));
  }
}

switch_to_last_weapon(var_0) {
  if(!isai(self))
    self switchtoweapon(var_0);
  else
    self switchtoweapon("none");
}

isaiteamparticipant(var_0) {
  if(isagent(var_0) && var_0.agent_teamparticipant == 1)
    return 1;

  if(isbot(var_0))
    return 1;

  return 0;
}

isteamparticipant(var_0) {
  if(isaiteamparticipant(var_0))
    return 1;

  if(isplayer(var_0))
    return 1;

  return 0;
}

isaigameparticipant(var_0) {
  if(isagent(var_0) && var_0.agent_gameparticipant == 1)
    return 1;

  if(isbot(var_0))
    return 1;

  return 0;
}

isgameparticipant(var_0) {
  if(isaigameparticipant(var_0))
    return 1;

  if(isplayer(var_0))
    return 1;

  return 0;
}

getteamindex(var_0) {
  var_1 = 0;

  if(level.teambased) {
    switch (var_0) {
      case "axis":
        var_1 = 1;
        break;
      case "allies":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

ismeleemod(var_0) {
  return var_0 == "MOD_MELEE" || var_0 == "MOD_MELEE_ALT";
}

isheadshot(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3)) {
    if(isdefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle")
        return 0;

      if(var_3.code_classname == "misc_turret")
        return 0;

      if(var_3.code_classname == "script_model")
        return 0;
    }

    if(isdefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien")
        return 0;
    }
  }

  return (var_1 == "head" || var_1 == "helmet") && !ismeleemod(var_2) && var_2 != "MOD_IMPACT" && !isenvironmentweapon(var_0);
}

attackerishittingteam(var_0, var_1) {
  if(!level.teambased)
    return 0;
  else if(!isdefined(var_1) || !isdefined(var_0))
    return 0;
  else if(!isdefined(var_0.team) || !isdefined(var_1.team))
    return 0;
  else if(var_0 == var_1)
    return 0;
  else if(var_0.pers["team"] == var_1.team && isdefined(var_1.teamchangedthisframe))
    return 0;
  else if(isdefined(var_1.scrambled) && var_1.scrambled)
    return 0;
  else if(var_0.team == var_1.team)
    return 1;
  else
    return 0;
}

set_high_priority_target_for_bot(var_0) {
  if(!(isdefined(self.high_priority_for) && common_scripts\utility::array_contains(self.high_priority_for, var_0))) {
    self.high_priority_for = common_scripts\utility::array_add(self.high_priority_for, var_0);
    var_0 notify("calculate_new_level_targets");
  }
}

add_to_bot_use_targets(var_0, var_1) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.use_time = var_1;
    var_0.bot_interaction_type = "use";
    [
      [level.bot_funcs["bots_add_to_level_targets"]]
    ](var_0);
  }
}

remove_from_bot_use_targets(var_0) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
}

add_to_bot_damage_targets(var_0) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.bot_interaction_type = "damage";
    [
      [level.bot_funcs["bots_add_to_level_targets"]]
    ](var_0);
  }
}

remove_from_bot_damage_targets(var_0) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
}

notify_enemy_bots_bomb_used(var_0) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["notify_enemy_bots_bomb_used"]))
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var_0);
}

get_rank_xp_and_prestige_for_bot() {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bot_get_rank_xp_and_prestige"]))
    return self[[level.bot_funcs["bot_get_rank_xp_and_prestige"]]]();
}

set_rank_xp_and_prestige_for_bot() {
  var_0 = get_rank_xp_and_prestige_for_bot();

  if(isdefined(var_0)) {
    self.pers["rankxp"] = var_0.rankxp;
    self.pers["prestige"] = var_0.prestige;
    self.pers["prestige_fake"] = var_0.prestige;
  }
}

set_rank_options_for_bot() {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bot_set_rank_options"]))
    self[[level.bot_funcs["bot_set_rank_options"]]]();
}

set_console_status() {
  if(!isdefined(level.console))
    level.console = getdvar("consoleGame") == "true";
  else {}

  if(!isdefined(level.xenon))
    level.xenon = getdvar("xenonGame") == "true";
  else {}

  if(!isdefined(level.ps3))
    level.ps3 = getdvar("ps3Game") == "true";
  else {}

  if(!isdefined(level.xb3))
    level.xb3 = getdvar("xb3Game") == "true";
  else {}

  if(!isdefined(level.ps4))
    level.ps4 = getdvar("ps4Game") == "true";
  else {}
}

is_gen4() {
  if(level.xb3 || level.ps4 || !level.console)
    return 1;
  else
    return 0;
}

setdvar_cg_ng(var_0, var_1, var_2) {
  if(!isdefined(level.console) || !isdefined(level.xb3) || !isdefined(level.ps4))
    set_console_status();

  if(is_gen4())
    setdvar(var_0, var_2);
  else
    setdvar(var_0, var_1);
}

isvalidteamtarget(var_0, var_1) {
  return isdefined(var_1.team) && var_1.team != var_0.team;
}

isvalidffatarget(var_0, var_1) {
  return isdefined(var_1.owner) && var_1.owner != var_0;
}

gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

gethelipilottraceoffset() {
  return (0, 0, 2500);
}

revertvisionsetforplayer(var_0) {
  if(!isdefined(var_0))
    var_0 = 1;

  if(isdefined(level.nukedetonated) && isdefined(level.nukevisionset)) {
    self setclienttriggervisionset(level.nukevisionset, var_0);
    self visionsetnakedforplayer(level.nukevisionset, var_0);
    set_visionset_for_watching_players(level.nukevisionset, var_0);
  } else if(isdefined(self.usingremote) && isdefined(self.ridevisionset)) {
    self setclienttriggervisionset(self.ridevisionset, var_0);
    self visionsetnakedforplayer(self.ridevisionset, var_0);
    set_visionset_for_watching_players(self.ridevisionset, var_0);
  } else {
    self setclienttriggervisionset("", var_0);
    self visionsetnakedforplayer("", var_0);
    set_visionset_for_watching_players("", var_0);
  }
}

set_light_set_for_player(var_0) {
  if(!isplayer(self)) {
    return;
  }
  if(isdefined(level.lightset_current))
    level.lightset_previous = level.lightset_current;

  level.lightset_current = var_0;
  self lightsetforplayer(var_0);
}

clear_light_set_for_player() {
  if(!isplayer(self)) {
    return;
  }
  var_0 = getmapcustom("map");

  if(isdefined(level.lightset_previous)) {
    var_0 = level.lightset_previous;
    level.lightset_previous = undefined;
  }

  level.lightset_current = var_0;
  self lightsetforplayer(var_0);
}

light_set_override_for_player(var_0, var_1, var_2, var_3) {
  if(!isplayer(self)) {
    return;
  }
  self lightsetoverrideenableforplayer(var_0, var_1);
  waitfortimeornotifies(var_2, ["death", "disconnect"]);

  if(isdefined(self))
    self lightsetoverridedisableforplayer(var_3);
}

getuniqueid() {
  if(isdefined(self.pers["guid"]))
    return self.pers["guid"];

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isdefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

get_players_watching(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = 0;

  if(!isdefined(var_1))
    var_1 = 0;

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(!isdefined(var_5) || var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(isdefined(var_5.team) && var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();

        if(isdefined(var_7) && var_7 == self)
          var_6 = 1;
      }

      if(var_5.forcespectatorclient == var_2)
        var_6 = 1;
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2)
        var_6 = 1;
    }

    if(var_6)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = get_players_watching(var_4, var_5);

  foreach(var_9 in var_7) {
    var_9 notify("changing_watching_visionset");

    if(isdefined(var_3) && var_3)
      var_9 visionsetmissilecamforplayer(var_0, var_1);
    else if(isdefined(var_6) && var_6)
      var_9 visionsetpostapplyforplayer(var_0, var_1);
    else
      var_9 visionsetnakedforplayer(var_0, var_1);

    if(var_0 != "" && isdefined(var_2)) {
      var_9 thread reset_visionset_on_team_change(self, var_1 + var_2, var_6);
      var_9 thread reset_visionset_on_disconnect(self, var_6);

      if(var_9 isinkillcam())
        var_9 thread reset_visionset_on_spawn();
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0.0);
  self visionsetpostapplyforplayer("", 0.0);
}

reset_visionset_on_team_change(var_0, var_1, var_2) {
  self endon("changing_watching_visionset");
  var_0 endon("disconnect");
  var_3 = gettime();
  var_4 = self.team;

  while (gettime() - var_3 < var_1 * 1000) {
    if(self.team != var_4 || !common_scripts\utility::array_contains(var_0 get_players_watching(), self)) {
      if(isdefined(var_2) && var_2)
        self visionsetpostapplyforplayer("", 0.0);
      else
        self visionsetnakedforplayer("", 0.0);

      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

reset_visionset_on_disconnect(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");

  if(isdefined(var_1) && var_1)
    self visionsetpostapplyforplayer("", 0.0);
  else
    self visionsetnakedforplayer("", 0.0);
}

_validateattacker(var_0) {
  if(isagent(var_0) && (!isdefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  return var_0;
}

_setnameplatematerial(var_0, var_1) {
  if(!isdefined(self.nameplatematerial)) {
    self.nameplatematerial = [];
    self.prevnameplatematerial = [];
  } else {
    self.prevnameplatematerial[0] = self.nameplatematerial[0];
    self.prevnameplatematerial[1] = self.nameplatematerial[1];
  }

  self.nameplatematerial[0] = var_0;
  self.nameplatematerial[1] = var_1;
  self setnameplatematerial(var_0, var_1);
}

_restorepreviousnameplatematerial() {
  if(isdefined(self.prevnameplatematerial))
    self setnameplatematerial(self.prevnameplatematerial[0], self.prevnameplatematerial[1]);
  else
    self setnameplatematerial("", "");

  self.nameplatematerial = undefined;
  self.prevnameplatematerial = undefined;
}

findandplayanims(var_0, var_1) {
  var_2 = getentarray(var_0, "targetname");

  if(var_2.size > 0) {
    foreach(var_4 in var_2) {
      var_5 = 0;

      if(isdefined(var_4.script_animation)) {
        if(isdefined(var_4.script_parameters) && var_4.script_parameters == "delta_anim")
          var_5 = 1;

        var_4 thread playanim(var_1, var_5);
      }
    }
  }
}

playanim(var_0, var_1) {
  if(var_0 == 1)
    wait(randomfloatrange(0.0, 1));

  if(var_1 == 0)
    self scriptmodelplayanim(self.script_animation);
  else
    self scriptmodelplayanimdeltamotion(self.script_animation);
}

playerallowhighjump(var_0, var_1) {
  _playerallow("highjump", var_0, var_1, ::allowhighjump);
}

playerallowhighjumpdrop(var_0, var_1) {
  _playerallow("highjumpdrop", var_0, var_1, ::allowhighjumpdrop);
}

playerallowboostjump(var_0, var_1) {
  _playerallow("boostjump", var_0, var_1, ::allowboostjump);
}

playerallowpowerslide(var_0, var_1) {
  _playerallow("powerslide", var_0, var_1, ::allowpowerslide);
}

playerallowdodge(var_0, var_1) {
  _playerallow("dodge", var_0, var_1, ::allowdodge);
}

_playerallow(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(self.playerdisableabilitytypes))
    self.playerdisableabilitytypes = [];

  if(!isdefined(self.playerdisableabilitytypes[var_0]))
    self.playerdisableabilitytypes[var_0] = [];

  if(!isdefined(var_2))
    var_2 = "default";

  if(!isdefined(var_4))
    var_4 = 1;

  if(var_1) {
    self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_remove(self.playerdisableabilitytypes[var_0], var_2);

    if(!self.playerdisableabilitytypes[var_0].size) {
      if(var_4)
        self call[[var_3]](1);
      else
        self[[var_3]](1);
    }
  } else {
    if(!isdefined(common_scripts\utility::array_find(self.playerdisableabilitytypes[var_0], var_2)))
      self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_add(self.playerdisableabilitytypes[var_0], var_2);

    if(var_4)
      self call[[var_3]](0);
    else
      self[[var_3]](0);
  }
}

makegloballyusablebytype(var_0, var_1, var_2, var_3) {
  var_4 = 500;

  switch (var_0) {
    case "killstreakRemote":
      var_4 = 300;
      break;
    case "coopStreakPrompt":
      var_4 = 301;
      break;
    default:
      break;
  }

  _insertintoglobalusablelist(var_4, var_0, var_2, var_3);
  self makeglobalusable(var_4, var_2, var_3);
  self sethintstring(var_1);
  self setcursorhint("HINT_NOICON");
}

_insertintoglobalusablelist(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.globalusableents))
    level.globalusableents = [];

  var_4 = -1;

  for (var_5 = 0; var_5 < level.globalusableents.size; var_5++) {
    var_6 = level.globalusableents[var_5];

    if(var_6.priority > var_0) {
      if(var_4 == -1)
        var_4 = var_5;

      break;
    }

    if(var_6.priority == var_0) {
      var_6.priority = var_6.priority + 0.01;

      if(var_6.enabled)
        var_6.ent makeglobalusable(var_6.priority, var_6.player, var_6.team);

      if(var_4 == -1)
        var_4 = var_5;
    }
  }

  if(var_4 == -1)
    var_4 = 0;

  var_7 = spawnstruct();
  var_7.ent = self;
  var_7.priority = var_0;
  var_7.type = var_1;
  var_7.player = var_2;
  var_7.team = var_3;
  var_7.enabled = 1;
  level.globalusableents = common_scripts\utility::array_insert(level.globalusableents, var_7, var_4);
}

makegloballyunusablebytype() {
  var_0 = undefined;

  foreach(var_2 in level.globalusableents) {
    if(var_2.ent == self) {
      var_0 = var_2;
      break;
    }
  }

  if(isdefined(var_0)) {
    var_4 = var_0.priority;
    level.globalusableents = common_scripts\utility::array_remove(level.globalusableents, var_0);
    self makeglobalunusable();

    foreach(var_2 in level.globalusableents) {
      if(var_4 > var_2.priority && int(var_4) == int(var_2.priority)) {
        var_2.priority = var_2.priority - 0.01;

        if(var_2.enabled)
          var_2.ent makeglobalusable(var_2.priority, var_2.player, var_2.team);
      }
    }
  }
}

disablegloballyusablebytype() {
  foreach(var_1 in level.globalusableents) {
    if(var_1.ent == self) {
      if(var_1.enabled) {
        var_1.ent makeglobalunusable();
        var_1.enabled = 0;
      }

      break;
    }
  }
}

enablegloballyusablebytype() {
  foreach(var_1 in level.globalusableents) {
    if(var_1.ent == self) {
      if(!var_1.enabled) {
        var_1.ent makeglobalusable(var_1.priority, var_1.player, var_1.team);
        var_1.enabled = 1;
      }

      break;
    }
  }
}

setdof(var_0) {
  self setdepthoffield(var_0["nearStart"], var_0["nearEnd"], var_0["farStart"], var_0["farEnd"], var_0["nearBlur"], var_0["farBlur"]);
}

isenemy(var_0) {
  if(level.teambased)
    return isplayeronenemyteam(var_0);
  else
    return isplayerffaenemy(var_0);
}

isplayeronenemyteam(var_0) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_0) {
  if(isdefined(var_0.owner))
    return var_0.owner != self;
  else
    return var_0 != self;
}

ismlgsystemlink() {
  if(issystemlink() && getdvarint("xblive_competitionmatch"))
    return 1;

  return 0;
}

ismlgsplitscreen() {
  if(issplitscreen() && getdvarint("xblive_competitionmatch"))
    return 1;

  return 0;
}

ismlgprivatematch() {
  if(privatematch() && getdvarint("xblive_competitionmatch"))
    return 1;

  return 0;
}

ismlgmatch() {
  if(ismlgsystemlink() || ismlgsplitscreen() || ismlgprivatematch())
    return 1;

  return 0;
}

spawnfxshowtoteam(var_0, var_1, var_2, var_3) {
  var_4 = spawnfx(var_0, var_2, var_3);
  var_4 fxshowtoteam(var_1);
  return var_4;
}

fxshowtoteam(var_0) {
  thread showfxtoteam(var_0);
  setfxkillondelete(self, 1);
  triggerfx(self);
}

showfxtoteam(var_0) {
  self endon("death");
  self endon("stopShowFXToTeam");
  level endon("game_ended");

  for (;;) {
    self hide();

    foreach(var_2 in level.players) {
      var_3 = var_2.team;

      if(var_3 != "axis" || var_2 ismlgspectator())
        var_3 = "allies";

      if(var_0 == var_3 || var_0 == "neutral")
        self showtoplayer(var_2);
    }

    level waittill("joined_team");
  }
}

get_spawn_weapon_name(var_0) {
  var_1 = "h1_ak47_mp";

  if(isdefined(var_0.primaryname) && var_0.primaryname != "none")
    var_1 = var_0.primaryname;
  else if(isdefined(var_0.secondaryname) && var_0.secondaryname != "none")
    var_1 = var_0.secondaryname;

  return var_1;
}

playersaveangles() {
  self.restoreangles = self getplayerangles();
}

playerrestoreangles() {
  if(isdefined(self.restoreangles)) {
    if(self.team != "spectator")
      self setplayerangles(self.restoreangles);

    self.restoreangles = undefined;
  }
}

setmlgicons(var_0, var_1) {
  var_0 maps\mp\gametypes\_gameobjects::set2dicon("mlg", var_1);
  var_0 maps\mp\gametypes\_gameobjects::set3dicon("mlg", var_1);
}

spawnpatchclip(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(!isdefined(var_3))
    return undefined;

  var_4 = spawn("script_model", var_1);
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_4.angles = var_2;
  return var_4;
}

hardpointvisualsswap(var_0, var_1) {
  var_2 = getentarray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_1 + "_" + var_4.script_noteworthy;
    var_6 = getent(var_5, "targetname");

    if(!isdefined(var_6)) {
      continue;
    }
    var_6.script_noteworthy = var_4.script_noteworthy;
    var_6.script_gameobjectname = "hp";
    var_6.targetname = var_4.targetname;
    var_4 delete();
  }
}

hardpointtriggerswap(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_3 = getentarray("hp_zone_trigger", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < 1) {
      var_4 = var_6;
      break;
    }
  }

  var_9 = getentarray("hp_zone_center", "targetname");
  var_10 = undefined;

  foreach(var_12 in var_9) {
    if(var_12 istouching(var_4)) {
      var_10 = var_12;
      break;
    }
  }

  if(!var_10 istouching(var_2))
    var_10.origin = var_2.origin;

  var_2.targetname = "hp_zone_trigger";
  var_4 delete();
}

headquarterstriggerswap(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_3 = getentarray("radiotrigger", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < 1) {
      var_4 = var_6;
      break;
    }
  }

  var_9 = getentarray("hq_hardpoint", "targetname");
  var_10 = undefined;

  foreach(var_12 in var_9) {
    if(var_12 istouching(var_4)) {
      var_10 = var_12;
      break;
    }
  }

  if(!var_10 istouching(var_2))
    var_10.origin = var_2.origin;

  var_2.targetname = "radiotrigger";
  var_4 delete();
}

headquartersradiomove(var_0, var_1, var_2) {
  var_3 = getentarray("hq_hardpoint", "targetname");
  var_4 = undefined;
  var_5 = isdefined(var_1);
  var_6 = isdefined(var_2);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);

  foreach(var_10 in var_3) {
    var_11 = distancesquared(var_10.origin, var_0);

    if(var_11 < 1) {
      var_4 = var_10;

      if(var_5)
        var_7 = var_1 - var_10.origin;

      if(var_6)
        var_8 = var_2 - var_10.angles;

      break;
    }
  }

  if(var_5)
    var_4.origin = var_1;

  if(var_6)
    var_4.angles = var_2;

  var_13 = getentarray(var_4.target, "targetname");

  foreach(var_15 in var_13) {
    if(var_5)
      var_15.origin = var_15.origin + var_7;

    if(var_6)
      var_15.angles = var_15.angles + var_8;
  }
}

demolitiontriggermove(var_0, var_1, var_2) {
  var_3 = getentarray("dd_bombzone", "targetname");

  foreach(var_5 in var_3) {
    var_6 = distancesquared(var_5.origin, var_0);

    if(var_6 < 1) {
      if(isdefined(var_1))
        var_5.origin = var_1;

      if(isdefined(var_2))
        var_5.angles = var_2;

      return;
    }
  }
}

demolitionsitemove(var_0, var_1, var_2) {
  var_3 = getentarray("dd_bombzone", "targetname");
  var_4 = isdefined(var_1);
  var_5 = isdefined(var_2);
  var_6 = (0, 0, 0);
  var_7 = (0, 0, 0);
  var_8 = undefined;

  foreach(var_10 in var_3) {
    if(isdefined(var_10.script_label) && var_10.script_label == var_0) {
      var_8 = var_10;

      if(var_4)
        var_6 = var_1 - var_8.origin;

      if(var_5)
        var_7 = var_2 - var_8.angles;

      break;
    }
  }

  if(!isdefined(var_8)) {
    return;
  }
  var_12 = getentarray(var_8.target, "targetname");
  var_13 = getent(var_12[0].target, "targetname");
  var_14 = getent("dd_bombzone_clip" + var_0, "targetname");
  var_15 = undefined;
  var_16 = undefined;

  for (var_17 = 0; var_17 < var_12.size; var_17++) {
    if(isdefined(var_12[var_17].script_exploder)) {
      var_16 = var_12[var_17].script_exploder;
      break;
    }
  }

  if(!isdefined(var_16)) {
    return;
  }
  var_18 = getentarray("exploder", "targetname");

  foreach(var_20 in var_18) {
    if(var_20.script_exploder == var_16) {
      var_15 = var_20;
      break;
    }
  }

  if(!isdefined(var_15)) {
    return;
  }
  if(var_4) {
    var_8.origin = var_1;

    foreach(var_23 in var_12)
    var_23.origin = var_23.origin + var_6;

    var_13.origin = var_13.origin + var_6;
    var_14.origin = var_14.origin + var_6;
    var_15.origin = var_15.origin + var_6;
  }

  if(var_5) {
    var_8.angles = var_2;

    foreach(var_23 in var_12)
    var_23.angles = var_23.angles + var_7;

    var_13.angles = var_13.angles + var_7;
    var_14.angles = var_14.angles + var_7;
    var_15.angles = var_15.angles + var_7;
  }
}

iscoop() {
  if(isdefined(level.ishorde) && level.ishorde)
    return 1;

  if(isdefined(level.iszombiegame) && level.iszombiegame)
    return 1;

  return 0;
}

setlightingstate_patched(var_0) {
  var_1 = getentarray();
  setomnvar("lighting_state", var_0);

  if(!getdvarint("r_reflectionProbeGenerate")) {
    foreach(var_3 in var_1) {
      if(isdefined(var_3.lightingstate) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3.lightingstate == 0) {
          continue;
        }
        if(var_3.lightingstate == var_0) {
          var_3 common_scripts\utility::show_solid();
          var_3 _meth_8550();
          continue;
        }

        var_3 notify("hidingLightingState");
        var_3 common_scripts\utility::hide_notsolid();
      }
    }
  }
}

gettimeutc_for_stat_recording() {
  return gettimeutc();
}

is_true(var_0) {
  return isdefined(var_0) && var_0;
}

waittillplayersnextsnapshot(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0 getsnapshotindexforclient();

  if(!isdefined(var_1)) {
    return;
  }
  for (;;) {
    waitframe();
    var_2 = var_0 getsnapshotacknowledgedindexforclient();

    if(!isdefined(var_2)) {
      return;
    }
    if(var_2 > var_1) {
      break;
    }
  }
}

setgameplayactive(var_0) {
  setdvar("bg_mpGameplayActive", var_0);
}

gameplayactivewatch() {
  level endon("game_ended");

  for (;;) {
    var_0 = 0;

    if(isdefined(level.players)) {
      foreach(var_2 in level.players) {
        var_3 = isdefined(var_2.sessionstate) && (var_2.sessionstate == "playing" || var_2.sessionstate == "dead");

        if(var_3 && !isai(var_2) && !istestclient(var_2))
          var_0++;
      }
    }

    var_5 = var_0 >= 2;
    setgameplayactive(var_5);
    level common_scripts\utility::waittill_any("playerCountChanged", "playerSessionStateChanged");
  }
}

setcarrierloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", "defaultClass", 5, "class", "inUse"))
    level.carrierloadouts["axis"] = getmatchrulesspecialclass("axis", 5);

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", "defaultClass", 5, "class", "inUse"))
    level.carrierloadouts["allies"] = getmatchrulesspecialclass("allies", 5);
}

applycarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isdefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while (self ismantling() || !self isonground())
    wait 0.05;

  if(isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = level.carrierloadouts[self.team];
  self.gamemode_chosenclass = self.class;
  self.gamemode_carrierclass = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");
}

removecarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isdefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while (self ismantling() || !self isonground())
    wait 0.05;

  while (isbombsiteweapon(self getcurrentweapon()))
    wait 0.05;

  if(isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class);
}

streamcarrierweaponstoplayers(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isdefined(level.carrierloadouts)) {
    wait 1.0;

    if(!isdefined(level.carrierloadouts))
      return;
  }

  var_3 = [];
  var_4 = [];
  var_5 = [];

  foreach(var_18, var_7 in level.carrierloadouts) {
    if(!common_scripts\utility::array_contains(var_1, var_18)) {
      continue;
    }
    var_5[var_5.size] = var_18;
    var_8 = var_7["loadoutPrimary"];
    var_9 = var_7["loadoutPrimaryAttachKit"];
    var_10 = var_7["loadoutPrimaryFurnitureKit"];
    var_11 = var_7["loadoutPrimaryCamo"];
    var_12 = var_7["loadoutPrimaryReticle"];
    var_13 = int(tablelookup("mp\camoTable.csv", 1, var_11, 0));
    var_14 = int(tablelookup("mp\reticleTable.csv", 1, var_12, 0));
    var_15 = maps\mp\gametypes\_class::buildweaponname(var_8, var_9, var_10, var_13, var_14, 0);
    var_4[var_18] = [var_15];
    var_16 = weaponclass(var_15);
    var_17 = spawnstruct();
    var_17.team = var_18;
    var_17.weapon = var_15;
    var_3[var_18][var_16] = var_17;
  }

  if(var_5.size == 0) {
    return;
  }
  for (;;) {
    foreach(var_20 in level.players) {
      if(!isalive(var_20) || !isdefined(var_20.team)) {
        continue;
      }
      if(!common_scripts\utility::array_contains(var_5, var_20.team)) {
        continue;
      }
      if(![
          [var_2]
        ](var_0, var_20)) {
        continue;
      }
      var_21 = var_0.curorigin;

      if(isdefined(var_0.carrier))
        var_21 = var_0.carrier.origin;

      if(distancesquared(var_20.origin, var_21) > 90000) {
        continue;
      }
      var_20 hasloadedcustomizationplayerview(var_3[var_20.team], var_4[var_20.team]);
    }

    wait 0.5;
  }
}

array_remove_index(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

streamnextspectatorweaponsifnecessary(var_0) {
  if(isai(self)) {
    return;
  }
  var_1 = undefined;

  if(canspectatesometeam() && !(self isspectating("freelook") && var_0))
    var_1 = getnextspectateclient();

  if(isdefined(var_1))
    streamspectatorweaponsforclient(var_1);
}

canspectatesometeam() {
  if(level.teambased) {
    if(self isspectating("allies") || self isspectating("axis"))
      return 1;
  } else if(self isspectating("allies") || self isspectating("axis") || self isspectating("none"))
    return 1;

  return 0;
}

getnextspectateclient() {
  var_0 = getnumberofclients();
  var_1 = self getentitynumber();

  for (var_2 = common_scripts\utility::mod(var_1 + 1, var_0); var_2 != var_1; var_2 = common_scripts\utility::mod(var_2 + 1, var_0)) {
    if(self _meth_857E(var_2)) {
      break;
    }
  }

  if(var_2 != var_1) {
    foreach(var_4 in level.players) {
      if(var_4 getentitynumber() == var_2)
        return var_4;
    }
  }

  return undefined;
}

streamspectatorweaponsforclient(var_0) {
  var_1 = spawnstruct();
  var_1.team = var_0.team;
  var_1.weapon = var_0.primaryweapon;
  var_2 = var_0 _meth_857F();
  return self hasloadedcustomizationplayerview(var_1, var_2);
}

ishodgepodgemm() {
  return isdefined(level.hodgepodgemode) && level.hodgepodgemode == 2;
}

ishodgepodgerpgonly() {
  return isdefined(level.hodgepodgemode) && (level.hodgepodgemode == 6 || level.hodgepodgemode == 7);
}

ishodgepodgeph() {
  return isdefined(level.hodgepodgemode) && level.hodgepodgemode == 9;
}