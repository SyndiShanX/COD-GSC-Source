/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\utility.gsc
**********************************/

exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
  }

  self playSound(level.scr_sound[self.script_sound]);
}

_beginlocationselection(var_0, var_1, var_2, var_3) {
  self beginlocationselection(var_1, var_2, 0, var_3);
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
  if(isDefined(var_0) && self.team != "spectator") {
    if(isDefined(self.var_110E9)) {
      self.var_110E9 destroy();
    }

    if(self issplitscreenplayer()) {
      self.var_110E9 = scripts\mp\hud_util::createfontstring("default", 1.3);
      self.var_110E9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
    } else {
      self.var_110E9 = scripts\mp\hud_util::createfontstring("default", 1.6);
      self.var_110E9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
    }

    var_4 = func_7F47(var_0);
    self.var_110E9 settext(var_4);
  }
}

stoplocationselection(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "generic";
  }

  if(!var_0) {
    self setblurforplayer(0, 0.3);
    self _meth_80DE();
    self.selectinglocation = undefined;
    if(isDefined(self.var_110E9)) {
      self.var_110E9 destroy();
    }
  }

  self notify("stop_location_selection", var_1);
}

endselectiononemp() {
  self endon("stop_location_selection");
  for(;;) {
    level waittill("emp_update");
    if(!scripts\mp\killstreaks\_emp_common::isemped()) {
      continue;
    }

    thread stoplocationselection(0, "emp");
  }
}

endselectiononaction(var_0) {
  self endon("stop_location_selection");
  self waittill(var_0);
  thread stoplocationselection(var_0 == "disconnect", var_0);
}

endselectiononendgame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread stoplocationselection(0, "end_game");
}

isattachment(var_0) {
  var_1 = tablelookup("mp\attachmentTable.csv", 4, var_0, 0);
  if(isDefined(var_1) && var_1 != "") {
    return 1;
  }

  return 0;
}

getattachmenttype(var_0) {
  var_1 = tablelookup("mp\attachmentTable.csv", 4, var_0, 2);
  return var_1;
}

func_2287(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

getplant() {
  var_0 = self.origin + (0, 0, 10);
  var_1 = 11;
  var_2 = anglesToForward(self.angles);
  var_2 = var_2 * var_1;
  var_3[0] = var_0 + var_2;
  var_3[1] = var_0;
  var_4 = bulletTrace(var_3[0], var_3[0] + (0, 0, -18), 0, undefined);
  if(var_4["fraction"] < 1) {
    var_5 = spawnStruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_5 = bulletTrace(var_4[1], var_4[1] + (0, 0, -18), 0, undefined);
  if(var_5["fraction"] < 1) {
    var_5 = spawnStruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_4[2] = var_1 + (16, 16, 0);
  var_4[3] = var_1 + (16, -16, 0);
  var_4[4] = var_1 + (-16, -16, 0);
  var_4[5] = var_1 + (-16, 16, 0);
  var_6 = undefined;
  var_7 = undefined;
  for(var_8 = 0; var_8 < var_4.size; var_8++) {
    var_5 = bulletTrace(var_4[var_8], var_4[var_8] + (0, 0, -1000), 0, undefined);
    if(!isDefined(var_6) || var_5["fraction"] < var_6) {
      var_6 = var_5["fraction"];
      var_7 = var_5["position"];
    }
  }

  if(var_6 == 1) {
    var_7 = self.origin;
  }

  var_5 = spawnStruct();
  var_8.origin = var_6;
  var_8.angles = orienttonormal(var_4["normal"]);
  return var_8;
}

orienttonormal(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  var_2 = length(var_1);
  if(!var_2) {
    return (0, 0, 0);
  }

  var_3 = vectornormalize(var_1);
  var_4 = var_0[2] * -1;
  var_5 = (var_3[0] * var_4, var_3[1] * var_4, var_2);
  var_6 = vectortoangles(var_5);
  return var_6;
}

deleteplacedentity(var_0) {
  var_1 = getEntArray(var_0, "classname");
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2] delete();
  }
}

playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
      return;
    }

    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];
        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !isexcluded(var_4, var_2)) {
          var_4 playlocalsound(var_0);
        }
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];
      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_4 playlocalsound(var_0);
      }
    }

    return;
  }

  if(isDefined(var_3)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
        continue;
      }

      if(!isexcluded(level.players[var_3], var_2)) {
        level.players[var_3] playlocalsound(var_0);
      }
    }

    return;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var_3] playlocalsound(var_0);
  }
}

sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;
    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--) {
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];
    }

    self.lowermessages[var_3 + 1] = var_1;
  }
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = undefined;
  foreach(var_0C in self.lowermessages) {
    if(var_0C.name == var_0) {
      if(var_0C.text == var_1 && var_0C.priority == var_3) {
        return;
      }

      var_0A = var_0C;
      break;
    }
  }

  if(!isDefined(var_0A)) {
    var_0A = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_0A;
  }

  var_0A.name = var_0;
  var_0A.text = var_1;
  var_0A.time = var_2;
  var_0A.addtime = gettime();
  var_0A.priority = var_3;
  var_0A.showtimer = var_4;
  var_0A.shouldfade = var_5;
  var_0A.fadetoalphatime = var_6;
  var_0A.fadetoalphatime = var_7;
  var_0A.hidewhenindemo = var_8;
  var_0A.hidewheninmenu = var_9;
  sortlowermessages();
}

removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }

      var_2 = self.lowermessages[var_1 - 1];
      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3])) {
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages)) {
    return undefined;
  }

  return self.lowermessages[0];
}

setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  if(!isDefined(var_9)) {
    var_9 = 1;
  }

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  updatelowermessage();
}

updatelowermessage() {
  if(!isDefined(self)) {
    return;
  }

  var_0 = getlowermessage();
  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }

    return;
  }

  self.lowermessage settext(var_0.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
  self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;
  if(var_0.shouldfade) {
    self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
    self.lowermessage.alpha = var_0.fadetoalphatime;
  }

  if(var_0.time > 0 && var_0.showtimer) {
    self.lowertimer settimer(max(var_0.time - gettime() - var_0.addtime / 1000, 0.1));
    return;
  }

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
  for(var_0 = 0; var_0 < self.lowermessages.size; var_0++) {
    self.lowermessages[var_0] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
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
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_1) {
      var_3 iprintlnbold(var_0);
    }
  }
}

printboldonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];
    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintlnbold(var_0, var_2);
    }
  }
}

printonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];
    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintln(var_0, var_2);
    }
  }
}

printonplayers(var_0, var_1) {
  var_2 = level.players;
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_1)) {
      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == var_1) {
        var_2[var_3] iprintln(var_0);
      }

      continue;
    }

    var_2[var_3] iprintln(var_0);
  }
}

printandsoundoneveryone(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isDefined(var_4);
  var_8 = 0;
  if(isDefined(var_5)) {
    var_8 = 1;
  }

  if(level.splitscreen || !var_7) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_0A = level.players[var_9];
      var_0B = var_0A.team;
      if(isDefined(var_0B)) {
        if(var_0B == var_0 && isDefined(var_2)) {
          var_0A iprintln(var_2, var_6);
          continue;
        }

        if(var_0B == var_1 && isDefined(var_3)) {
          var_0A iprintln(var_3, var_6);
        }
      }
    }

    if(var_7) {
      level.players[0] playlocalsound(var_4);
      return;
    }

    return;
  }

  if(var_0B) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_0A = level.players[var_9];
      var_0B = var_0A.team;
      if(isDefined(var_0B)) {
        if(var_0B == var_0) {
          if(isDefined(var_2)) {
            var_0A iprintln(var_2, var_6);
          }

          var_0A playlocalsound(var_4);
          continue;
        }

        if(var_0B == var_1) {
          if(isDefined(var_3)) {
            var_0A iprintln(var_3, var_6);
          }

          var_0A playlocalsound(var_5);
        }
      }
    }

    return;
  }

  for(var_9 = 0; var_9 < level.players.size; var_9++) {
    var_0A = level.players[var_9];
    var_0B = var_0A.team;
    if(isDefined(var_0B)) {
      if(var_0B == var_0) {
        if(isDefined(var_2)) {
          var_0A iprintln(var_2, var_6);
        }

        var_0A playlocalsound(var_4);
        continue;
      }

      if(var_0B == var_1) {
        if(isDefined(var_3)) {
          var_0A iprintln(var_3, var_6);
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
  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

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
  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setdvar(var_0, var_4);
  return var_4;
}

play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
    return;
  }

  playsoundatpos(self.origin, var_0);
}

func_D526(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(var_1, var_0);
    var_2 = lookupsoundlength(var_0) / 1000;
    wait(var_2);
    return;
  }

  self playSound(var_1);
  var_2 = lookupsoundlength(var_1) / 1000;
  wait(var_2);
}

getotherteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "allies") {
    return "axis";
  } else if(var_0 == "axis") {
    return "allies";
  } else {
    return "none";
  }
}

wait_endon(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  wait(var_0);
}

initpersstat(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
  }
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incperstat(var_0, var_1, var_2) {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] = self.pers[var_0] + var_1;
    if(!isDefined(var_2) || var_2 == 0) {
      scripts\mp\persistence::statadd(var_0, var_1);
    }
  }
}

setpersstat(var_0, var_1) {
  self.pers[var_0] = var_1;
}

updatepersratio(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) || !rankingenabled()) {
    return;
  }

  var_4 = scripts\mp\persistence::statget(var_1);
  var_5 = scripts\mp\persistence::statget(var_2);
  if(var_5 == 0) {
    var_5 = 1;
  }

  scripts\mp\persistence::func_10E54(var_0, int(var_4 * 1000 / var_5));
}

func_12EE9(var_0, var_1, var_2) {
  if(!rankingenabled()) {
    return;
  }

  var_3 = scripts\mp\persistence::statgetbuffered(var_1);
  var_4 = scripts\mp\persistence::statgetbuffered(var_2);
  if(var_4 == 0) {
    var_4 = 1;
  }

  scripts\mp\persistence::func_10E55(var_0, int(var_3 * 1000 / var_4));
}

func_13842(var_0) {
  if(level.var_A9F1 == gettime()) {
    if(isDefined(var_0) && var_0) {
      while(level.var_A9F1 == gettime()) {
        wait(0.05);
      }
    } else {
      wait(0.05);
      if(level.var_A9F1 == gettime()) {
        wait(0.05);
        if(level.var_A9F1 == gettime()) {
          wait(0.05);
          if(level.var_A9F1 == gettime()) {
            wait(0.05);
          }
        }
      }
    }
  }

  level.var_A9F1 = gettime();
}

waitfortimeornotify(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
}

isexcluded(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

leaderdialog(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  if(level.teambased && !isDefined(var_1)) {
    return;
  }

  for(var_5 = 0; var_5 < level.players.size; var_5++) {
    var_6 = level.players[var_5];
    if(isDefined(var_3) && isexcluded(var_6, var_3)) {
      continue;
    }

    if(var_6 issplitscreenplayer() && !var_6 issplitscreenplayerprimary()) {
      continue;
    }

    if(level.teambased && !isDefined(var_6.pers["team"]) || var_6.pers["team"] != var_1) {
      continue;
    }

    var_6 leaderdialogonplayer_internal(var_0, var_2, undefined, var_4);
  }
}

func_98D3() {
  level.var_AA1D["allies"] = 0;
  level.var_AA1D["axis"] = 0;
}

statusdialog(var_0, var_1, var_2) {
  if(istrue(level.gameended)) {
    return;
  }

  var_3 = gettime();
  if(gettime() < level.var_AA1D[var_1] + 5000 && !isDefined(var_2) || !var_2) {
    return;
  }

  thread func_5100(var_0, var_1);
  level.var_AA1D[var_1] = gettime();
}

func_5100(var_0, var_1) {
  level endon("game_ended");
  wait(0.1);
  func_13842();
  leaderdialog(var_0, var_1);
}

leaderdialogonplayers(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_1) {
    var_5 leaderdialogonplayer(var_0, var_2, undefined, var_3);
  }
}

leaderdialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4);
}

leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_4 = var_4 * 1000;
    if(gettime() < self.var_AA1D["time"] + var_4 && self.var_AA1D["dialog"] == var_0) {
      return;
    }

    self.var_AA1D["time"] = gettime();
    self.var_AA1D["dialog"] = var_0;
  }

  var_5 = self.pers["team"];
  if(isDefined(var_5) && var_5 == "axis" || var_5 == "allies") {
    var_6 = self getplayerdata("common", "mp_announcer_type");
    if(var_6 > 0) {
      var_7 = tablelookupistringbyrow("mp\announcervoicedata.csv", var_6, 3);
      var_8 = var_7 + "_1mc_" + game["dialog"][var_0];
    } else {
      var_8 = game["voice"][var_6] + "1mc_" + game["dialog"][var_1];
    }

    var_8 = tolower(var_8);
    self _meth_8252(var_8, var_0, 2, var_1, var_2, var_3);
  }
}

func_98D4() {
  self.var_AA1D["time"] = 0;
  self.var_AA1D["dialog"] = "";
}

func_D4B7(var_0) {
  var_1 = self.team;
  var_2 = [self];
  var_3 = self getothersplitscreenplayer();
  if(isDefined(var_3)) {
    var_2[var_2.size] = var_3;
  }

  func_C638(var_0 + "_use");
  if(level.teambased) {
    leaderdialog(var_1 + "_friendly_" + var_0 + "_inbound", var_1, undefined, var_2);
    if(func_7F40(var_0)) {
      leaderdialog(var_1 + "_enemy_" + var_0 + "_inbound", level.otherteam[var_1], undefined, var_2);
      return;
    }

    return;
  }

  if(func_7F40(var_0)) {
    leaderdialog(var_1 + "_enemy_" + var_0 + "_inbound", undefined, undefined, var_2);
  }
}

playkillstreakdialogonplayer(var_0, var_1, var_2, var_3) {
  if(level.showingfinalkillcam) {
    return;
  }

  var_0 = getbasekillstreakdialog(var_0);
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = game["dialog"][var_0];
  if(issubstr(var_4, "op_" + var_0) || var_4 == "op_" + var_0) {
    func_C638(var_0, var_1, var_2, var_3);
    return;
  }

  leaderdialogonplayer(var_0, var_1, var_2, var_3);
}

getbasekillstreakdialog(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = undefined;
  foreach(var_6, var_4 in var_1) {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    } else {
      var_2 = var_2 + var_4;
    }

    var_5 = var_1[var_6 + 1];
    if(isDefined(var_5)) {
      if(var_5 == "rare" || var_5 == "legend" || var_5 == "epic") {
        break;
      } else {
        var_2 = var_2 + "_";
      }
    }
  }

  return var_2;
}

func_C638(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = game["dialog"][var_0];
  self _meth_8252(var_4, var_0, 2, var_1, var_2, var_3);
}

func_7FEB() {
  for(var_0 = 0; var_0 < self.leaderdialogqueue.size; var_0++) {
    if(issubstr(self.leaderdialogqueue[var_0], "losing")) {
      if(self.team == "allies") {
        if(issubstr(level.axiscapturing, self.leaderdialogqueue[var_0])) {
          return self.leaderdialogqueue[var_0];
        } else {
          scripts\engine\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);
        }
      } else if(issubstr(level.alliescapturing, self.leaderdialogqueue[var_0])) {
        return self.leaderdialogqueue[var_0];
      } else {
        scripts\engine\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);
      }

      continue;
    }

    return level.alliescapturing[self.leaderdialogqueue];
  }
}

func_C6E4() {
  self endon("disconnect");
  var_0 = [];
  var_0 = self.leaderdialogqueue;
  for(var_1 = 0; var_1 < self.leaderdialogqueue.size; var_1++) {
    if(issubstr(self.leaderdialogqueue[var_1], "losing")) {
      for(var_2 = var_1; var_2 >= 0; var_2--) {
        if(!issubstr(self.leaderdialogqueue[var_2], "losing") && var_2 != 0) {
          continue;
        }

        if(var_2 != var_1) {
          func_22DB(var_0, self.leaderdialogqueue[var_1], var_2);
          scripts\engine\utility::array_remove(var_0, self.leaderdialogqueue[var_1]);
          break;
        }
      }
    }
  }

  self.leaderdialogqueue = var_0;
}

updatemainmenu() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
    return;
  }

  self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

updateobjectivetext() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("cg_objectiveText", "");
    return;
  }

  if(level.roundscorelimit > 0 && !isobjectivebased()) {
    if(isDefined(getobjectivescoretext(self.pers["team"]))) {
      if(level.splitscreen) {
        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
        return;
      }

      self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
      return;
    }

    return;
  }

  if(isDefined(getobjectivetext(self.pers["team"]))) {
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
  if(!isDefined(level.starttime) || !isDefined(level.var_561F)) {
    return 0;
  }

  if(level.var_1191F) {
    return level.var_1191E - level.starttime - level.var_561F;
  }

  return gettime() - level.starttime - level.var_561F;
}

gettimepassedpercentage() {
  var_0 = gettimelimit();
  if(var_0 == 0) {
    return 0;
  }

  return gettimepassed() / gettimelimit() * 60 * 1000 * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

clearkillcamstate() {
  self.missile_createrepulsorent = -1;
  self.setclientmatchdatadef = -1;
  self.var_4A = 0;
  self.box = 0;
  self.clearstartpointtransients = 0;
}

isinkillcam() {
  if(isai(self)) {
    return 0;
  }

  if(self.clearstartpointtransients) {
    if(self.missile_createrepulsorent == -1 && self.setclientmatchdatadef == -1) {
      return 0;
    }
  }

  return self.clearstartpointtransients;
}

setuipostgamefade(var_0, var_1) {
  self endon("disconnect");
  if(!isDefined(self.var_6AB3)) {
    self.var_6AB3 = 0;
  }

  if(self.var_6AB3 == var_0) {
    return;
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self notify("setUIPostGameFade");
  self endon("setUIPostGameFade");
  if(self.var_6AB3 < var_0) {
    self.var_6AB3 = clamp(self.var_6AB3 + 0.5 * abs(self.var_6AB3 - var_0), 0, 1);
  } else {
    self.var_6AB3 = clamp(self.var_6AB3 - 0.5 * abs(self.var_6AB3 - var_0), 0, 1);
  }

  self setclientomnvar("ui_post_game_fade", self.var_6AB3);
  wait(0.1);
  self.var_6AB3 = var_0;
  self setclientomnvar("ui_post_game_fade", self.var_6AB3);
}

isvalidclass(var_0) {
  return isDefined(var_0) && var_0 != "";
}

makevehiclesolidcapsule(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_2;
  }

  if(var_0 < var_1) {
    return var_1;
  }

  return var_0;
}

func_136EE(var_0) {
  var_1 = gettime();
  var_2 = gettime() - var_1 / 1000;
  if(var_2 < var_0) {
    wait(var_0 - var_2);
    return var_0;
  }

  return var_2;
}

registerroundswitchdvar(var_0, var_1, var_2, var_3) {
  registerwatchdvarint("roundswitch", var_1);
  var_0 = "scr_" + var_0 + "_roundswitch";
  level.var_E766 = var_0;
  level.var_E768 = var_2;
  level.var_E767 = var_3;
  level.var_E765 = getdvarint(var_0, var_1);
  if(level.var_E765 < var_2) {
    level.var_E765 = var_2;
    return;
  }

  if(level.var_E765 > var_3) {
    level.var_E765 = var_3;
  }
}

registerroundlimitdvar(var_0, var_1) {
  registerwatchdvarint("roundlimit", var_1);
}

func_DF03(var_0, var_1) {
  registerwatchdvarint("numTeams", var_1);
}

registerwinlimitdvar(var_0, var_1) {
  registerwatchdvarint("winlimit", var_1);
}

registerwinbytwoenableddvar(var_0, var_1) {
  registerwatchdvarint("winbytwoenabled", var_1);
}

registerwinbytwomaxroundsdvar(var_0, var_1) {
  registerwatchdvarint("winbytwomaxrounds", var_1);
}

registerdogtagsenableddvar(var_0, var_1) {
  registerwatchdvarint("dogtags", var_1);
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
  setdvar("ui_halftime", func_7EEF());
}

registernumlivesdvar(var_0, var_1) {
  registerwatchdvarint("numlives", var_1);
}

botgetworldsize(var_0, var_1) {
  return getdvarint(var_0, getdvarint(var_1));
}

botgetworldclosestedge(var_0, var_1) {
  return getdvarfloat(var_0, getdvarfloat(var_1));
}

func_F7D3(var_0) {
  setdvar("overtimeTimeLimit", var_0);
}

func_7920(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 1;
  var_2.var_9D26 = 0;
  var_2.issplitscreen = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

func_7922(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.var_9D26 = 0;
  var_2.issentry = 1;
  var_2.issplitscreen = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

func_791D(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.var_9D26 = 0;
  var_2.issplitscreen = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

func_791F(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.var_9D26 = 0;
  var_2.issplitscreen = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

func_7921(var_0) {
  return var_0.origin + (0, 0, 32);
}

getstancecenter() {
  if(self getstance() == "crouch") {
    var_0 = self.origin + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var_0 = self.origin + (0, 0, 10);
  } else {
    var_0 = self.origin + (0, 0, 32);
  }

  return var_0;
}

func_791E(var_0) {
  return var_0.origin;
}

func_7E8A(var_0) {
  var_1 = getdvar(var_0);
  if(var_1 == "") {
    return (0, 0, 0);
  }

  var_2 = strtok(var_1, " ");
  if(var_2.size < 3) {
    return (0, 0, 0);
  }

  setdvar("tempR", var_2[0]);
  setdvar("tempG", var_2[1]);
  setdvar("tempB", var_2[2]);
  return (getdvarfloat("tempR"), getdvarfloat("tempG"), getdvarfloat("tempB"));
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

_takeweaponsexcept(var_0) {
  var_1 = self getweaponslistall();
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      continue;
    } else {
      _takeweapon(var_3);
    }
  }
}

_setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0].randomintrange = var_2;
  self setactionslot(var_0, var_1, var_2);
}

isfloat(var_0) {
  if(int(var_0) != var_0) {
    return 1;
  }

  return 0;
}

registerwatchdvarint(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.var_13A08[var_2] = spawnStruct();
  level.var_13A08[var_2].value = getdvarint(var_2, var_1);
  level.var_13A08[var_2].type = "int";
  level.var_13A08[var_2].var_C174 = "update_" + var_0;
}

registerwatchdvarfloat(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.var_13A08[var_2] = spawnStruct();
  level.var_13A08[var_2].value = getdvarfloat(var_2, var_1);
  level.var_13A08[var_2].type = "float";
  level.var_13A08[var_2].var_C174 = "update_" + var_0;
}

registerwatchdvar(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.var_13A08[var_2] = spawnStruct();
  level.var_13A08[var_2].value = getdvar(var_2, var_1);
  level.var_13A08[var_2].type = "string";
  level.var_13A08[var_2].var_C174 = "update_" + var_0;
}

setoverridewatchdvar(var_0, var_1) {
  var_0 = "scr_" + level.gametype + "_" + var_0;
  level.var_C827[var_0] = var_1;
}

getwatcheddvar(var_0) {
  var_0 = "scr_" + level.gametype + "_" + var_0;
  if(isDefined(level.var_C827) && isDefined(level.var_C827[var_0])) {
    return level.var_C827[var_0];
  }

  return level.var_13A08[var_0].value;
}

func_12F5B() {
  while(game["state"] == "playing") {
    var_0 = getarraykeys(level.var_13A08);
    foreach(var_2 in var_0) {
      if(level.var_13A08[var_2].type == "string") {
        var_3 = _meth_80A2(var_2, level.var_13A08[var_2].value);
      } else if(level.var_13A08[var_2].type == "float") {
        var_3 = func_7EBF(var_2, level.var_13A08[var_2].value);
      } else {
        var_3 = getintproperty(var_2, level.var_13A08[var_2].value);
      }

      if(var_3 != level.var_13A08[var_2].value) {
        level.var_13A08[var_2].value = var_3;
        level notify(level.var_13A08[var_2].var_C174, var_3);
      }
    }

    wait(1);
  }
}

isroundbased() {
  if(!level.teambased) {
    return 0;
  }

  if(level.winlimit != 1 && level.roundlimit != 1) {
    return 1;
  }

  if(level.gametype == "sr" || level.gametype == "sd" || level.gametype == "siege") {
    return 1;
  }

  return 0;
}

func_9DF6() {
  if(!level.teambased) {
    return 1;
  }

  if(level.roundlimit > 1 && game["roundsPlayed"] == 0) {
    return 1;
  }

  if(level.winlimit > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0) {
    return 1;
  }

  return 0;
}

nextroundisfinalround() {
  if(level.var_72B3) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype()) {
    return 1;
  }

  if(func_9ECF() && hitroundlimit() || hitwinlimit()) {
    if(shouldplaywinbytwo() && islastwinbytwo()) {
      return 1;
    } else if(istimetobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1) {
        return 1;
      }
    } else if(!level.playovertime) {
      return 1;
    }
  }

  var_0 = level.winlimit > 0 && getroundswon("allies") == level.winlimit - 1 || getroundswon("axis") == level.winlimit - 1;
  var_1 = abs(getroundswon("allies") - getroundswon("axis"));
  if(var_0 && var_1 == 0) {
    if(func_9ECF()) {
      return 0;
    } else {
      return 1;
    }
  }

  return 0;
}

wasonlyround() {
  if(level.playovertime) {
    return 0;
  }

  if(!level.teambased) {
    return 1;
  }

  if(isDefined(level.onlyroundoverride)) {
    return 0;
  }

  if(level.winlimit == 1 && hitwinlimit()) {
    return 1;
  }

  if(level.roundlimit == 1) {
    return 1;
  }

  return 0;
}

waslastround() {
  if(level.var_72B3) {
    return 1;
  }

  if(wasonlyround()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(hitroundlimit() || hitwinlimit()) {
    return !level.playovertime;
  }

  return 0;
}

iswinbytworulegametype() {
  switch (level.gametype) {
    case "sd":
    case "sr":
    case "siege":
      return getdvarint("scr_" + level.gametype + "_winByTwoEnabled", 0) == 1;
  }

  return 0;
}

getmaxwinbytworounds() {
  return getdvarint("scr_" + level.gametype + "_winByTwoMaxRounds", level.winlimit);
}

shouldplaywinbytwo() {
  var_0 = game["roundsWon"]["allies"];
  var_1 = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(var_0 - var_1) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

istimetobeatrulegametype() {
  switch (level.gametype) {
    case "ball":
    case "ctf":
      return 1;
  }

  return 0;
}

settimetobeat(var_0) {
  if(!istimetobeatrulegametype()) {
    return 0;
  }

  var_1 = getsecondspassed();
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);
  if(!istimetobeatvalid() || var_1 < game["timeToBeat"] && var_2 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_0) {
      game["timeToBeatOld"] = game["timeToBeat"];
    }

    game["timeToBeat"] = var_1;
    game["timeToBeatTeam"] = var_0;
    game["timeToBeatScore"] = var_2;
    return 1;
  }

  return 0;
}

istimetobeatvalid() {
  return game["timeToBeat"] != 0;
}

forceplaytimetobeat() {
  return isgamebattlematch() && game["timeToBeat"] == 0;
}

func_1005B() {
  if(isgamebattlematch() && game["overtimeRoundsPlayed"] == 1) {
    return 1;
  } else if(istimetobeatvalid() && game["overtimeRoundsPlayed"] == 1) {
    return 1;
  } else if(forceplaytimetobeat() && game["overtimeRoundsPlayed"] > 1) {
    return 1;
  }

  return 0;
}

func_9ECF() {
  if(isgamebattlematch() && !iswinbytworulegametype()) {
    return 1;
  }

  switch (level.gametype) {
    case "ball":
    case "ctf":
      return 1;

    case "sd":
    case "dd":
    case "sr":
    case "siege":
      return iswinbytworulegametype();
  }

  return 0;
}

func_7F9C() {
  if(isgamebattlematch() && !iswinbytworulegametype()) {
    return -1;
  }

  var_0 = 0;
  switch (level.gametype) {
    case "ball":
    case "ctf":
    case "sd":
    case "sr":
    case "siege":
      var_0 = 2;
      break;

    case "dd":
      var_0 = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype()) {
    return -1;
  }

  return var_0;
}

getwingamebytype() {
  if(!isDefined(level.wingamebytype)) {
    if(!isroundbased() || !isobjectivebased() || ismoddedroundgame()) {
      level.wingamebytype = "teamScores";
    } else {
      level.wingamebytype = "roundsWon";
    }
  }

  return level.wingamebytype;
}

issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled)) {
    level.simultaneouskillenabled = getdvarint("killswitch_simultaneous_deaths", 0) == 0;
  }

  if(isgamebattlematch()) {
    level.simultaneouskillenabled = 0;
  }

  return level.simultaneouskillenabled;
}

cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled()) {
    return 0;
  }

  var_0 = 0;
  switch (level.gametype) {
    case "gun":
    case "dm":
    case "war":
    case "front":
      var_0 = 1;
      break;
  }

  return var_0;
}

func_1004B() {
  if(!hitroundlimit() && !hitwinlimit()) {
    return 0;
  }

  if(!func_9ECF()) {
    return 0;
  }

  var_0 = getwingamebytype();
  var_1 = game[var_0]["allies"];
  var_2 = game[var_0]["axis"];
  var_3 = var_1 == var_2;
  if(var_3 && inovertime()) {
    var_4 = func_7F9C();
    var_3 = scripts\engine\utility::ter_op(var_4 == -1, 1, game["overtimeRoundsPlayed"] < var_4);
  }

  var_5 = shouldplaywinbytwo();
  var_6 = func_1005B();
  if(isgamebattlematch() && istimetobeatrulegametype()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      var_3 = 0;
      if(var_1 == var_2) {
        var_3 = 1;
      }
    } else if(!var_6) {
      var_3 = 0;
    }
  }

  return !level.var_72B3 && var_3 || var_5 || var_6;
}

func_E269() {
  return level.gametype == "ctf" && !inovertime() && getwingamebytype() == "roundsWon";
}

func_38F3() {
  if(!isDefined(level.didhalfscorevoboost)) {
    level.didhalfscorevoboost = 0;
  }

  if(level.didhalfscorevoboost) {
    return 0;
  }

  switch (level.gametype) {
    case "tdef":
    case "conf":
    case "dm":
    case "war":
    case "ball":
    case "grnd":
    case "koth":
    case "front":
    case "dd":
    case "grind":
    case "dom":
      return 1;

    case "mp_zomb":
    case "gun":
    case "ctf":
    case "sd":
    case "sr":
    case "siege":
    case "infect":
      return 0;

    default:
      return 0;
  }
}

hittimelimit() {
  if(getwatcheddvar("timelimit") <= 0) {
    return 0;
  }

  var_0 = scripts\mp\gamelogic::gettimeremaining();
  if(var_0 > 0) {
    return 0;
  }

  return 1;
}

hitroundlimit() {
  if(level.roundlimit <= 0) {
    return 0;
  }

  return game["roundsPlayed"] >= level.roundlimit;
}

hitscorelimit() {
  if(isobjectivebased()) {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  if(level.teambased) {
    if(game["teamScores"]["allies"] >= level.roundscorelimit || game["teamScores"]["axis"] >= level.roundscorelimit) {
      return 1;
    }
  } else {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      var_1 = level.players[var_0];
      if(isDefined(var_1.destroynavrepulsor) && var_1.destroynavrepulsor >= level.roundscorelimit) {
        return 1;
      }
    }
  }

  return 0;
}

hitwinlimit() {
  if(level.winlimit <= 0) {
    return 0;
  }

  if(!level.teambased) {
    return 1;
  }

  if(getroundswon("allies") >= level.winlimit || getroundswon("axis") >= level.winlimit) {
    return 1;
  }

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit) {
      return level.roundlimit;
    }

    return level.winlimit;
  }

  return level.roundscorelimit;
}

getroundswon(var_0) {
  return game["roundsWon"][var_0];
}

isobjectivebased() {
  return level.objectivebased;
}

gettimelimit() {
  if(inovertime() && !isDefined(game["inNukeOvertime"]) || !game["inNukeOvertime"]) {
    if(istrue(game["timeToBeat"])) {
      return game["timeToBeat"] / 60;
    }

    var_0 = getdvarfloat("overtimeTimeLimit");
    if(var_0 > 0) {
      return var_0;
    }

    return getwatcheddvar("timelimit");
  }

  if(isDefined(level.extratime) && level.extratime > 0) {
    return getwatcheddvar("timelimit") + level.extratime;
  }

  return getwatcheddvar("timelimit");
}

func_7EEF() {
  if(inovertime()) {
    return 0;
  }

  if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"]) {
    return 0;
  }

  return getwatcheddvar("halftime");
}

inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted)) {
    return level.gamehasstarted;
  }

  if(level.teambased) {
    return level.hasspawned["axis"] && level.hasspawned["allies"];
  }

  return level.maxplayercount > 1;
}

func_7DEA(var_0) {
  var_1 = (0, 0, 0);
  if(!var_0.size) {
    return undefined;
  }

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3.origin;
  }

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

    if(level.teambased && isDefined(var_0)) {
      if(var_0 == var_3.pers["team"]) {
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

setusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var_0;
  scripts\engine\utility::allow_offhand_weapons(0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self playlocalsound("mp_killstreak_screen_start");
  self notify("using_remote");
}

_meth_80E8() {
  return self.usingremote;
}

freezecontrolswrapper(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerFreezeStack"]++;
  } else if(scripts\engine\utility::istrue(var_1)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
    return;
  }

  self freezecontrols(1);
  self.controlsfrozen = 1;
}

clearusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  if(!isDefined(var_0)) {
    scripts\engine\utility::allow_offhand_weapons(1);
    freezecontrolswrapper(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self playlocalsound("mp_killstreak_screen_end");
  self notify("stopped_using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

istryingtousekillstreak() {
  return isDefined(self.tryingtousekillstreak);
}

func_DB8D(var_0) {
  if(!isDefined(level.var_DB95)) {
    level.var_DB95 = [];
  }

  level.var_DB95[var_0] = [];
}

func_DB8B(var_0, var_1) {
  level.var_DB95[var_0][level.var_DB95[var_0].size] = var_1;
}

func_DB94(var_0) {
  var_1 = undefined;
  var_2 = [];
  foreach(var_4 in level.var_DB95[var_0]) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(!isDefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  level.var_DB95[var_0] = var_2;
  return var_1;
}

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(issubstr(var_0, "_akimbo") || isDefined(var_2) && var_2 == 1) {
    self giveweapon(var_0, var_1, 1, -1, var_3);
    return;
  }

  self giveweapon(var_0, var_1, 0, -1, var_3);
}

_switchtoweapon(var_0) {
  func_4F5B("___ SwitchToWeapon() - " + var_0);
  self switchtoweapon(var_0);
}

_switchtoweaponimmediate(var_0) {
  func_4F5B("___ SwitchToWeaponImmediate() - " + var_0);
  self switchtoweaponimmediate(var_0);
}

_takeweapon(var_0) {
  if(self _meth_856D() == var_0) {
    self _meth_8570(var_0);
  }

  self takeweapon(var_0);
}

takeweaponwhensafe(var_0) {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!iscurrentweapon(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  _takeweapon(var_0);
}

perksenabled() {
  return level.allowperks;
}

_hasperk(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

giveperk(var_0) {
  scripts\mp\perks\_perks::_setperk(var_0);
  scripts\mp\perks\_perks::_setextraperks(var_0);
}

removeperk(var_0) {
  scripts\mp\perks\_perks::_unsetperk(var_0);
  scripts\mp\perks\_perks::func_142F(var_0);
}

blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    scripts\mp\perks\_perks::func_1431(var_0);
    foreach(var_6, var_2 in level.extraperkmap) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self.perksblocked[var_4])) {
            self.perksblocked[var_4] = 1;
          } else {
            self.perksblocked[var_4]++;
          }

          if(self.perksblocked[var_4] == 1) {
            scripts\mp\perks\_perks::func_1431(var_4);
          }
        }

        break;
      }
    }
  }
}

unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;
  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;
    if(_hasperk(var_0)) {
      scripts\mp\perks\_perks::func_13D2(var_0);
      foreach(var_6, var_2 in level.extraperkmap) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self.perksblocked[var_4]--;
            if(self.perksblocked[var_4] == 0) {
              scripts\mp\perks\_perks::func_13D2(var_4);
              self.perksblocked[var_4] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

quicksort(var_0, var_1) {
  return func_DBA1(var_0, 0, var_0.size - 1, var_1);
}

func_DBA1(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;
  if(!isDefined(var_3)) {
    var_3 = ::func_DBA0;
  }

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];
    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4], var_6) && var_4 <= var_2 && var_5 > var_4) {
        var_4++;
      }

      while(![[var_3]](var_0[var_5], var_6) && var_5 >= var_1 && var_5 >= var_4) {
        var_5--;
      }

      if(var_5 > var_4) {
        var_0 = func_11304(var_0, var_4, var_5);
      }
    }

    var_0 = func_11304(var_0, var_1, var_5);
    var_0 = func_DBA1(var_0, var_1, var_5 - 1, var_3);
    var_0 = func_DBA1(var_0, var_5 + 1, var_2, var_3);
  } else {
    return var_1;
  }

  return var_0;
}

func_DBA0(var_0, var_1) {
  return var_0 <= var_1;
}

func_11304(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

_suicide() {
  if(isusingremote() && !isDefined(self.fauxdeath)) {
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", "none", (0, 0, 0), "none", 0, 1116, 1);
    return;
  }

  if(!isusingremote() && !isDefined(self.fauxdeath)) {
    self suicide();
  }
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdeath)) {
    return 1;
  }

  return 0;
}

waittill_any_timeout_pause_on_death_and_prematch(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  if(isDefined(var_1)) {
    thread scripts\engine\utility::waittill_string_no_endon_death(var_1, var_6);
  }

  if(isDefined(var_2)) {
    thread scripts\engine\utility::waittill_string_no_endon_death(var_2, var_6);
  }

  if(isDefined(var_3)) {
    thread scripts\engine\utility::waittill_string_no_endon_death(var_3, var_6);
  }

  if(isDefined(var_4)) {
    thread scripts\engine\utility::waittill_string_no_endon_death(var_4, var_6);
  }

  if(isDefined(var_5)) {
    thread scripts\engine\utility::waittill_string_no_endon_death(var_5, var_6);
  }

  var_6 thread func_1429(var_0, self);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

func_1429(var_0, var_1) {
  self endon("die");
  var_2 = 0.05;
  while(var_0 > 0) {
    if(isplayer(var_1) && !isreallyalive(var_1)) {
      var_1 waittill("spawned_player");
    }

    if(getomnvar("ui_prematch_period")) {
      level waittill("prematch_over");
    }

    wait(var_2);
    var_0 = var_0 - var_2;
  }

  self notify("returned", "timeout");
}

playdeathsound() {
  var_0 = randomintrange(1, 8);
  var_1 = "generic";
  if(isfemale()) {
    var_1 = "female";
  }

  if(func_9D48("archetype_scout")) {
    self playSound("c6_death_vox");
    return;
  }

  if(self.team == "axis") {
    self playSound(var_1 + "_death_russian_" + var_0);
    return;
  }

  self playSound(var_1 + "_death_american_" + var_0);
}

rankingenabled() {
  if(!isplayer(self)) {
    return 0;
  }

  return level.rankedmatch && !self.usingonlinedataoffline;
}

func_D957() {
  return level.onlinegame && getdvarint("xblive_privatematch");
}

lobbyteamselectenabled() {
  return getdvarint("systemlink") || func_D957() && getdvarint("lobby_team_select", 0);
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

setaltsceneobj(var_0, var_1, var_2, var_3) {}

func_6383(var_0) {
  self endon("altscene");
  var_0 waittill("death");
  self notify("end_altScene");
}

getgametypenumlives() {
  return getwatcheddvar("numlives");
}

setturretminimapvisible(var_0) {
  self.combathigh = var_0;
}

func_22DB(var_0, var_1, var_2) {
  if(var_0.size != 0) {
    for(var_3 = var_0.size; var_3 >= var_2; var_3--) {
      var_0[var_3 + 1] = var_0[var_3];
    }
  }

  var_0[var_2] = var_1;
}

_meth_80A2(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvar(var_0, var_1);
  return var_2;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

func_7EBF(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

func_A679(var_0) {
  if(var_0 == "venomxgun_mp" || var_0 == "venomxproj_mp") {
    return 1;
  }

  if(_hasperk("specialty_explosivebullets")) {
    return 0;
  }

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1) {
    return 0;
  }

  var_1 = self.pers["killstreaks"];
  if(isDefined(level.killstreakweildweapons[var_0]) && isDefined(self.streaktype) && self.streaktype != "support") {
    for(var_2 = 1; var_2 < 4; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2].streakname) && var_1[var_2].streakname == level.killstreakweildweapons[var_0] && isDefined(var_1[var_2].lifeid) && var_1[var_2].lifeid == self.pers["deaths"]) {
        return streakstate(level.killstreakweildweapons[var_0]);
      }
    }

    return 0;
  }

  return !iskillstreakweapon(var_1);
}

streakstate(var_0) {
  var_1 = scripts\mp\killstreaks\_killstreaks::getstreakcost(var_0);
  var_2 = scripts\mp\killstreaks\_killstreaks::func_7FEE();
  var_3 = scripts\mp\killstreaks\_killstreaks::getstreakcost(var_2);
  return var_1 < var_3;
}

func_9D48(var_0) {
  return isDefined(self.loadoutarchetype) && var_0 == self.loadoutarchetype;
}

isjuggernaut() {
  if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautdef) && self.isjuggernautdef == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautgl) && self.isjuggernautgl == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1) {
    return 1;
  }

  return 0;
}

_meth_8238(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isrc8weapon(var_0)) {
    return "killstreak";
  }

  if(iscacprimaryweapon(var_0)) {
    return "primary";
  }

  if(iscacsecondaryweapon(var_0)) {
    return "secondary";
  }

  if(iskillstreakweapon(var_0)) {
    return "killstreak";
  }

  if(scripts\mp\powers::func_9F0A(var_0)) {
    return "power";
  }

  if(issuperweapon(var_0)) {
    return "super";
  }

  if(func_9E0D(var_0)) {
    return "gamemode";
  }

  if(isstrstart(var_0, "destructible_")) {
    return "destructible";
  }

  var_1 = getequipmenttype(var_0);
  if(isDefined(var_1)) {
    return var_1;
  }

  if(var_0 == "none") {
    return "worldspawn";
  }

  if(var_0 == "bomb_site_mp") {
    return var_0;
  }

  if(isstrstart(var_0, "spaceship_")) {
    return "spaceship";
  }
}

getequipmenttype(var_0) {
  switch (var_0) {
    case "throwingknife_mp":
    case "wristrocket_proj_mp":
    case "power_exploding_drone_mp":
    case "split_grenade_mp":
    case "trip_mine_mp":
    case "power_spider_grenade_mp":
    case "wristrocket_mp":
    case "splash_grenade_mp":
    case "blackhole_grenade_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_mp":
    case "c4_mp":
      var_1 = "lethal";
      break;

    case "flare_mp":
    case "deployable_cover_mp":
    case "blackout_grenade_mp":
    case "trophy_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
    case "domeshield_mp":
    case "cryo_mine_mp":
      var_1 = "tactical";
      break;

    case "groundpound_mp":
    case "player_trophy_system_mp":
      var_1 = "trait";
      break;

    case "kineticpulse_emp_mp":
    case "kineticpulse_concuss_mp":
    case "kineticpulse_mp":
    case "super_trophy_mp":
    case "blackhat_mp":
    case "coneflash_mp":
    case "distortionfield_grenade_mp":
    case "fear_grenade_mp":
    case "virus_grenade_mp":
    case "ammo_box_mp":
    case "sonic_sensor_mp":
    case "transponder_mp":
    case "portal_generator_mp":
    case "forcepush_mp":
    case "speed_strip_mp":
    case "copycat_grenade_mp":
    case "adrenaline_mist_mp":
    case "proxy_bomb_mp":
    case "gas_grenade_mp":
    case "bulletstorm_device_mp":
    case "proto_ricochet_device_mp":
    case "emp_grenade_mp":
    case "mobile_radar_mp":
    case "motion_sensor_mp":
    case "gravity_grenade_mp":
    case "sensor_grenade_mp":
    case "smoke_grenadejugg_mp":
    case "flash_grenade_mp":
    case "chargemode_mp":
    case "phaseslash_grenade_mp":
    case "power_attack_drone_mp":
    case "armorup_mp":
    case "eng_drone_gun_mp":
    case "portal_grenade_mp":
    case "micro_turret_gun_mp":
    case "pulse_grenade_mp":
    case "thruster_mp":
    case "battleslide_mp":
    case "mortarmount_mp":
    case "shard_ball_mp":
    case "case_bomb_mp":
    case "disc_marker_mp":
    case "frag_grenade_short_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncingbetty_mp":
    case "throwingreaper_mp":
    case "throwingknifehack_mp":
    case "throwingknifesiphon_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifeteleport_mp":
    case "claymore_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      var_1 = "equipment_other";
      break;

    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

func_9F93(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var_0) {
    case "blackout_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
    case "cryo_mine_mp":
      return 1;

    case "deployable_cover_mp":
    case "trophy_mp":
    case "domeshield_mp":
      return 0;

    default:
      return 0;
  }
}

func_24ED() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(level.ac130player) && self == level.ac130player) {
    return 1;
  }

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner) {
    return 1;
  }

  if(isDefined(level.reminder_reaction_pointat) && isDefined(level.reminder_reaction_pointat.triggerportableradarping) && self == level.reminder_reaction_pointat.triggerportableradarping) {
    return 1;
  }

  if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
    return 1;
  }

  if(isDefined(self.using_remote_tank) && self.using_remote_tank) {
    return 1;
  } else if(isDefined(self.using_remote_a10)) {
    return 1;
  }

  return 0;
}

isenvironmentweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "turret_minigun_mp") {
    return 1;
  }

  return 0;
}

isjuggernautweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw6_axe_mp":
    case "throwingknifejugg_mp":
    case "iw6_riotshieldjugg_mp":
    case "iw6_p226jugg_mp":
    case "iw6_magnumjugg_mp":
    case "iw6_minigunjugg_mp":
    case "smoke_grenadejugg_mp":
    case "mortar_shelljugg_mp":
      return 1;
  }

  return 0;
}

issuperweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 = getweaponrootname(var_0);
  if(isDefined(level.superweapons) && isDefined(level.superweapons[var_0])) {
    return 1;
  }

  return 0;
}

issuperdamagesource(var_0) {
  if(issuperweapon(var_0)) {
    return 1;
  }

  if(var_0 == "chargemode_mp") {
    return 1;
  }

  if(var_0 == "micro_turret_gun_mp") {
    return 1;
  }

  if(var_0 == "super_trophy_mp") {
    return 1;
  }

  return 0;
}

func_9E0D(var_0) {
  if(isbombsiteweapon(var_0)) {
    return 1;
  }

  switch (var_0) {
    case "iw7_tdefball_mp":
    case "iw7_uplinkball_mp":
      return 1;

    default:
      return 0;
  }

  return 0;
}

isrc8weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw7_minigun_c8_mp":
    case "iw7_chargeshot_c8_mp":
    case "iw7_c8offhandshield_mp":
    case "iw7_c8landing_mp":
    case "iw7_c8shutdown_mp":
    case "iw7_c8destruct_mp":
      return 1;

    default:
      return 0;
  }

  return 0;
}

getweapongroup(var_0) {
  if(var_0 == "none" || var_0 == "alt_none") {
    return "other";
  }

  var_1 = getweaponrootname(var_0);
  var_2 = weapongroupmap(var_1);
  if(!isDefined(var_2)) {
    if(issuperweapon(var_0)) {
      var_2 = "super";
    } else if(isenvironmentweapon(var_0)) {
      var_2 = "weapon_mg";
    } else if(iskillstreakweapon(var_0)) {
      var_2 = "killstreak";
    } else if(func_9E0D(var_0)) {
      var_2 = "gamemode";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

getweaponattachmentarrayfromstats(var_0) {
  var_0 = getweaponrootname(var_0);
  if(!isDefined(level.weaponattachments)) {
    level.weaponattachments = [];
  }

  if(!isDefined(level.weaponattachments[var_0])) {
    var_1 = [];
    for(var_2 = 0; var_2 <= 19; var_2++) {
      var_3 = tablelookup("mp\statsTable.csv", 4, var_0, 10 + var_2);
      if(var_3 == "") {
        break;
      }

      var_1[var_1.size] = var_3;
    }

    level.weaponattachments[var_0] = var_1;
  }

  return level.weaponattachments[var_0];
}

getweaponbarsize(var_0, var_1) {
  var_2 = getweaponattachmentarrayfromstats(var_0);
  var_3 = [];
  foreach(var_5 in var_2) {
    if(getattachmenttype(var_5) == var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

getweaponattachmentfromstats(var_0, var_1) {
  var_0 = getweaponrootname(var_0);
  return tablelookup("mp\statsTable.csv", 4, var_0, 10 + var_1);
}

attachmentscompatible(var_0, var_1) {
  if(func_248E(var_0) && func_248E(var_1)) {
    return 0;
  }

  var_0 = attachmentmap_tobase(var_0);
  var_1 = attachmentmap_tobase(var_1);
  var_2 = 1;
  if(var_0 == var_1) {
    var_2 = 0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var_3 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_2 = !isDefined(level.attachmentmap_conflicts[var_3[0] + "_" + var_3[1]]);
  } else if(var_0 != "none" && var_1 != "none") {
    var_4 = tablelookuprownum("mp\attachmentcombos.csv", 0, var_1);
    if(tablelookup("mp\attachmentcombos.csv", 0, var_0, var_4) == "no") {
      var_2 = 0;
    }
  }

  return var_2;
}

getweaponrootname(var_0) {
  var_1 = strtok(var_0, "_");
  if(var_1[0] == "iw6" || var_1[0] == "iw7") {
    var_0 = var_1[0] + "_" + var_1[1];
    if(var_1[1] == "chargeshot" && isDefined(var_1[2]) && var_1[2] == "c8") {
      var_0 = var_1[0] + "_" + var_1[1] + "_" + var_1[2];
    }
  } else if(var_1[0] == "alt") {
    var_0 = var_1[1] + "_" + var_1[2];
  }

  return var_0;
}

getweaponbasedsmokegrenadecount(var_0) {
  if(var_0 != "none") {
    var_0 = getweaponbasename(var_0);
  }

  return var_0;
}

func_E0CF(var_0) {
  if(scripts\mp\weapons::isaltmodeweapon(var_0)) {
    var_0 = getsubstr(var_0, 4);
  }

  return var_0;
}

isclassicweapon(var_0) {
  var_1 = getweaponrootname(var_0);
  if(var_1 == "iw7_g18c" || var_1 == "iw7_ump45c" || var_1 == "iw7_cheytacc" || var_1 == "iw7_m1c" || var_1 == "iw7_spasc" || var_1 == "iw7_arclassic") {
    return 1;
  }

  return 0;
}

isburstfireweapon(var_0) {
  var_1 = getweaponrootname(var_0);
  if(var_1 == "iw7_rvn" || var_1 == "iw7_cheytac" || var_1 == "iw7_tacburst") {
    return 1;
  }

  var_2 = getweaponvariantindex(var_0);
  if(isDefined(var_2)) {
    if(var_1 == "iw7_sdfar" && var_2 != 3 && var_2 != 35) {
      return 1;
    }

    if(var_1 == "iw7_revolver" && var_2 != 3 && var_2 != 35) {
      return 1;
    }

    if(var_1 == "iw7_gauss" && var_2 == 1 || var_2 == 33 || var_2 == 2 || var_2 == 34 || var_2 == 3 || var_2 == 35) {
      return 1;
    }

    if(var_1 == "iw7_sonic" && var_2 == 4 || var_2 == 36) {
      return 1;
    }

    if(var_1 == "iw7_m8" && var_2 == 4 || var_2 == 36) {
      return 1;
    }

    if(var_1 == "iw7_emc" && var_2 == 3 || var_2 == 35) {
      return 1;
    }
  } else if(var_1 == "iw7_sdfar" || var_1 == "iw7_revolver") {
    return 1;
  }

  return 0;
}

getbaseperkname(var_0) {
  if(isendstr(var_0, "_ks")) {
    var_0 = getsubstr(var_0, 0, var_0.size - 3);
  }

  return var_0;
}

getvalidextraammoweapons() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    var_4 = weaponclass(var_3);
    if(!iskillstreakweapon(var_3) && var_4 != "grenade" && var_4 != "rocketlauncher" && self getweaponammostock(var_3) != 0) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

riotshield_hasweapon() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(scripts\mp\weapons::isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

riotshield_hastwo() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(scripts\mp\weapons::isriotshield(var_3)) {
      var_0++;
    }

    if(var_0 == 2) {
      break;
    }
  }

  return var_0 == 2;
}

riotshield_attach(var_0, var_1) {
  var_2 = undefined;
  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "tag_shield_back";
  }

  self attachshieldmodel(var_1, var_2);
  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "tag_weapon_right";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "tag_shield_back";
  }

  self detachshieldmodel(var_1, var_2);
  if(var_0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "tag_weapon_right";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "tag_shield_back";
    var_2 = "tag_weapon_right";
  }

  self moveshieldmodel(var_3, var_1, var_2);
  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var_3;
  self.riotshieldmodelstowed = undefined;
}

riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

riotshield_getmodel() {
  return scripts\engine\utility::ter_op(isjuggernaut(), "weapon_riot_shield_jug_iw6", "weapon_riot_shield_iw6");
}

func_C793(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.players;
  var_6 = scripts\mp\outline::func_C78A(var_1);
  var_7 = scripts\mp\outline::func_C7A9(var_4);
  return scripts\mp\outline::outlineenableinternal(var_0, var_6, var_5, var_2, var_3, var_7, "ALL");
}

outlineenableforteam(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getteamarray(var_2, 0);
  var_7 = scripts\mp\outline::func_C78A(var_1);
  var_8 = scripts\mp\outline::func_C7A9(var_5);
  return scripts\mp\outline::outlineenableinternal(var_0, var_7, var_6, var_3, var_4, var_8, "TEAM", var_2);
}

outlineenableforplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\outline::func_C78A(var_1);
  var_7 = scripts\mp\outline::func_C7A9(var_5);
  if(isagent(var_2)) {
    return scripts\mp\outline::outlinegenerateuniqueid();
  }

  return scripts\mp\outline::outlineenableinternal(var_0, var_6, [var_2], var_3, var_4, var_7, "ENTITY");
}

outlinedisable(var_0, var_1) {
  scripts\mp\outline::outlinedisableinternal(var_0, var_1);
}

func_C7AA(var_0) {
  scripts\mp\outline::func_C7AB(var_0);
}

func_98AA() {
  level.var_C7A1 = [];
  level.var_C7A2 = 0;
}

func_180C(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.weaponisauto = var_0;
  var_2.fgetarg = var_1;
  var_3 = level.var_C7A2;
  level.var_C7A1[var_3] = var_2;
  level.var_C7A2++;
  return var_3;
}

func_E14A(var_0) {
  level.var_C7A1[var_0] = undefined;
}

func_C7A0(var_0, var_1) {
  foreach(var_3 in level.var_C7A1) {
    if(!isDefined(var_3) || !isDefined(var_3.weaponisauto) || !isDefined(var_3.fgetarg)) {
      continue;
    }

    if(scripts\engine\utility::segmentvssphere(var_0, var_1, var_3.weaponisauto, var_3.fgetarg)) {
      return 1;
    }
  }

  return 0;
}

playsoundinspace(var_0, var_1) {
  playsoundatpos(var_1, var_0);
}

func_ACDD(var_0, var_1) {
  var_2 = 1;
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 = var_2 * 10;
  }

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 = var_4 / var_2;
  return var_4;
}

func_E75C(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "nearest";
  }

  var_3 = 1;
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;
  if(var_2 == "up") {
    var_6 = ceil(var_5);
  } else if(var_3 == "down") {
    var_6 = floor(var_6);
  } else {
    var_6 = var_6 + 0.5;
  }

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

func_D38F(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.clientid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

func_1114F(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);
  if(isDefined(var_1[1])) {
    var_3 = 1;
    for(var_4 = 0; var_4 < var_1[1].size; var_4++) {
      var_3 = var_3 * 0.1;
    }

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

func_F63C() {
  foreach(var_1 in level.players) {
    self disableplayeruse(var_1);
  }
}

func_B2B4(var_0) {
  self makeusable();
  thread func_1438(var_0);
}

func_1438(var_0) {
  self endon("death");
  for(;;) {
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
  thread func_1437(var_0);
}

func_1437(var_0) {
  self endon("death");
  var_1 = var_0.team;
  for(;;) {
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

initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

gameflag(var_0) {
  return game["flags"][var_0];
}

gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

gameflagclear(var_0) {
  game["flags"][var_0] = 0;
}

gameflagwait(var_0) {
  while(!gameflag(var_0)) {
    level waittill(var_0);
  }
}

func_9F0D(var_0) {
  if(var_0 == "MOD_RIFLE_BULLET" || var_0 == "MOD_PISTOL_BULLET") {
    return 1;
  }

  return 0;
}

isfmjdamage(var_0, var_1) {
  var_2 = 0;
  if(isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_3 = getweaponattachmentsbasenames(var_0);
    foreach(var_5 in var_3) {
      if(var_5 == "fmj" || var_5 == "reflect") {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
  }
}

levelflaginit(var_0, var_1) {
  level.levelflags[var_0] = var_1;
}

levelflag(var_0) {
  return level.levelflags[var_0];
}

func_ABF4(var_0) {
  level.levelflags[var_0] = 1;
  level notify(var_0);
}

levelflagclear(var_0) {
  level.levelflags[var_0] = 0;
  level notify(var_0);
}

func_ABF5(var_0) {
  while(!levelflag(var_0)) {
    level waittill(var_0);
  }
}

func_ABF6(var_0) {
  while(levelflag(var_0)) {
    level waittill(var_0);
  }
}

iskillstreakdenied() {
  return scripts\mp\killstreaks\_emp_common::isemped() || isairdenied();
}

isairdenied() {
  if(self.team == "spectator") {
    return 0;
  }

  if(level.teambased) {
    return level.teamairdenied[self.team];
  }

  return isDefined(level.airdeniedplayer) && level.airdeniedplayer != self;
}

func_9EBB() {
  if(self.team == "spectator") {
    return 0;
  }

  return isDefined(self.nuked);
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

teamplayercardsplash(var_0, var_1, var_2, var_3) {
  if(level.hardcoremode) {
    return;
  }

  foreach(var_5 in level.players) {
    if(var_5 ismlgspectator()) {
      var_6 = var_5 getspectatingplayer();
      if(isDefined(var_6) && isDefined(var_2) && var_6.team != var_2) {
        continue;
      }
    } else {
      if(isDefined(var_2) && var_5.team != var_2) {
        continue;
      }

      if(!isplayer(var_5)) {
        continue;
      }
    }

    var_5 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
  }
}

ispickedupweapon(var_0) {
  if(iscacprimaryweapon(var_0) || iscacsecondaryweapon(var_0)) {
    if(issubstr(var_0, "alt_") && var_0 != "iw7_venomx_mp+venomxalt_burst") {
      var_0 = getsubstr(var_0, 4, var_0.size);
    }

    var_1 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_0;
    var_2 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_0;
    if(!var_1 && !var_2) {
      return 1;
    }
  }

  return 0;
}

iscacprimaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_riot":
    case "weapon_shotgun":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_smg":
      return 1;

    default:
      return 0;
  }
}

iscacsecondaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_machine_pistol":
    case "weapon_projectile":
    case "weapon_rail":
    case "weapon_beam":
    case "weapon_pistol":
    case "weapon_melee":
      return 1;

    default:
      return 0;
  }
}

iscacmeleeweapon(var_0) {
  return getweapongroup(var_0) == "weapon_melee";
}

getlastlivingplayer(var_0) {
  var_1 = undefined;
  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }

    if(!isreallyalive(var_3) && !var_3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(var_3.switching_teams) && var_3.switching_teams) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

getpotentiallivingplayers() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(!isreallyalive(var_2) && !var_2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      if(var_2 ismlgspectator()) {
        continue;
      }
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

waittillrecoveredhealth(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_2 = 0;
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  for(;;) {
    if(self.health != self.maxhealth) {
      var_2 = 0;
    } else {
      var_2 = var_2 + var_1;
    }

    wait(var_1);
    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls)) {
    self.weaponlasercalls = 0;
  }

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;
  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

attachmentmap_tounique(var_0, var_1) {
  var_2 = getweaponrootname(var_1);
  if(var_2 != var_1) {
    var_3 = getweaponbasename(var_1);
    if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_3][level.attachmentmap_uniquetobase[var_0]])) {
      var_4 = level.attachmentmap_uniquetobase[var_0];
      return level.attachmentmap_basetounique[var_3][var_4];
    } else if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_1])) {
      return level.attachmentmap_basetounique[var_4][var_1];
    } else {
      var_5 = strtok(var_4, "_");
      if(var_5.size > 3) {
        var_6 = var_5[0] + "_" + var_5[1] + "_" + var_5[2];
        if(isDefined(level.attachmentmap_basetounique[var_6]) && isDefined(level.attachmentmap_basetounique[var_6][var_1])) {
          return level.attachmentmap_basetounique[var_6][var_1];
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_basetounique[var_3][var_1])) {
    return level.attachmentmap_basetounique[var_3][var_1];
  } else {
    var_7 = weapongroupmap(var_3);
    if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_1])) {
      return level.attachmentmap_basetounique[var_7][var_1];
    }
  }

  return var_1;
}

attachmentperkmap(var_0) {
  if(isDefined(level.attachmentmap_attachtoperk[var_0])) {
    return level.attachmentmap_attachtoperk[var_0];
  }

  return undefined;
}

func_13C75(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].var_23B0)) {
    var_0 = level.weaponmapdata[var_0].var_23B0;
  }

  return var_0;
}

func_13CB4(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].perk)) {
    return level.weaponmapdata[var_0].perk;
  }

  return undefined;
}

weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group)) {
    return level.weaponmapdata[var_0].group;
  }

  return undefined;
}

func_13CAC(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].number)) {
    return level.weaponmapdata[var_0].number;
  }
}

weaponattachdefaultmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaults)) {
    return level.weaponmapdata[var_0].attachdefaults;
  }

  return undefined;
}

func_13C86(var_0) {
  return isDefined(level.weaponmapdata[var_0]);
}

weaponattachremoveextraattachments(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(level.attachmentextralist[var_3])) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

func_9D55(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  return func_9D56(var_2, var_1);
}

func_9D56(var_0, var_1) {
  var_2 = 0;
  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;
    if(var_0[0] == "alt") {
      var_3 = 1;
    }

    if(var_0.size >= 3 + var_3 && var_0[var_3] == "iw6" || var_0[var_3] == "iw7") {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper") {
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
      }
    }
  }

  return var_2;
}

getweaponattachmentsbasenames(var_0) {
  if(var_0 != "none") {
    var_1 = getweaponattachments(var_0);
    foreach(var_4, var_3 in var_1) {
      var_1[var_4] = attachmentmap_tobase(var_3);
    }

    return var_1;
  }

  return [];
}

getattachmentlistbasenames() {
  var_0 = [];
  var_1 = 0;
  var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 5);
  while(var_2 != "") {
    var_3 = tablelookup("mp\attachmentTable.csv", 0, var_1, 2);
    if(var_3 != "none" && !scripts\engine\utility::array_contains(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
    var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 5);
  }

  return var_0;
}

attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0])) {
    var_0 = level.attachmentmap_uniquetobase[var_0];
  }

  return var_0;
}

attachmentmap_toextra(var_0) {
  var_1 = undefined;
  if(isDefined(level.attachmentmap_uniquetoextra[var_0])) {
    var_1 = level.attachmentmap_uniquetoextra[var_0];
  }

  return var_1;
}

func_13CA1(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "domeshield_plant_mp":
        var_0 = "domeshield_mp";
        break;

      case "power_exploding_drone_transform_mp":
        var_0 = "power_exploding_drone_mp";
        break;

      case "semtexproj_mp":
        var_0 = "iw6_mk32_mp";
        break;

      case "iw6_semtexshards_mp":
        var_0 = "venomproj_mp";
        break;

      case "globproj_mp":
        var_0 = "splash_grenade_mp";
        break;

      case "niagara_mini_mp":
        var_0 = "iw7_niagara_mp";
        break;

      case "wristrocket_proj_mp":
        var_0 = "wristrocket_mp";
        break;

      case "split_grenade_mini_mp":
        var_0 = "split_grenade_mp";
        break;

      case "destructible_toy":
        if(isDefined(var_1)) {
          if(isDefined(var_1.weapon_name)) {
            var_0 = var_1.weapon_name;
          } else {
            var_0 = "destructible_car";
          }

          if(!istrue(var_2)) {
            var_0 = func_13CA1(var_0, var_1, 1);
          }
        }
        break;

      case "iw7_spas_mpr_focus":
        var_0 = "iw7_spas_mpr";
        break;

      case "iw7_erad_mp_jump_spread":
        var_0 = "iw7_erad_mp";
        break;

      case "gltacburst":
        var_0 = "alt_iw7_tacburst_mp";
        break;

      case "gltacburst_regen":
      case "gltacburst_big":
        var_0 = "alt_iw7_tacburst_mpl";
        break;

      default:
        var_3 = self;
        if(var_0 != "alt_none" && getweaponrootname(var_0) == "iw7_axe") {
          if(isDefined(var_1)) {
            var_3 = var_1;
            if(!isplayer(var_1) && isDefined(var_1.triggerportableradarping)) {
              var_3 = var_1.triggerportableradarping;
            }

            if(isDefined(var_1.classname) && var_1.classname != "grenade" && var_3 getweaponammoclip(var_0) == 0) {
              var_0 = "iw7_fists_mp";
            }
          }
        }
        break;
    }
  }

  return var_0;
}

func_249F(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(func_2490(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

func_2490(var_0) {
  if(func_248F(var_0)) {
    return 0;
  }

  if(func_248E(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "glmp28_smoke":
    case "glsmoke_slow":
    case "glsmoke":
    case "shotgunlongshot":
    case "meleervn":
    case "axefists":
    case "arripper":
    case "arm8":
    case "gltacburst_regen":
    case "gltacburst_big":
    case "gltacburst":
    case "scope":
      return 0;
  }

  return 1;
}

func_13C94(var_0) {
  return 0;
}

func_13C9B(var_0) {
  if(func_13C91(var_0)) {
    return 1;
  }

  return weaponhasattachment(var_0, "firetypeburst");
}

func_13C9C(var_0) {
  var_1 = getweaponrootname(var_0);
  return var_1 == "iw7_spas" || var_1 == "iw7_spasc" || var_1 == "iw7_sonic";
}

func_13C91(var_0) {
  var_1 = getweaponrootname(var_0);
  if(var_1 == "iw7_sdfar") {
    var_2 = getweaponattachmentsbasenames(var_0);
    foreach(var_4 in var_2) {
      if(var_4 == "firetypeauto" || var_4 == "firetypesingle") {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

func_13C93(var_0) {
  return var_0 == "iw6_g28";
}

func_13C92(var_0) {
  return var_0 == "iw6_cbjms";
}

func_13C95(var_0) {
  var_1 = getweaponrootname(var_0);
  if(var_1 == "iw6_dlcweap03") {
    var_2 = getweaponattachments(var_0);
    foreach(var_4 in var_2) {
      if(isstrstart(var_4, "dlcweap03")) {
        return 1;
      }
    }
  }

  return 0;
}

weaponhasattachment(var_0, var_1) {
  var_2 = getweaponattachmentsbasenames(var_0);
  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_9EE8() {
  return self getweaponrankinfominxp() > 0.5;
}

touchingbadtrigger() {
  var_0 = getEntArray("trigger_hurt", "classname");
  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  var_4 = getEntArray("radiation", "targetname");
  foreach(var_2 in var_4) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

func_11A44() {
  if(istrue(self.allowedintrigger)) {
    return 0;
  }

  foreach(var_1 in level.var_C7B3) {
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size)) {
    return 0;
  }

  self.allowedintrigger = 0;
  foreach(var_1 in level.ballallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size)) {
    return 0;
  }

  self.allowedintrigger = 0;
  foreach(var_1 in level.playerallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

setthirdpersondof(var_0) {
  if(var_0) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
    return;
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

killtrigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(!isplayer(var_4)) {
      continue;
    }

    var_4 suicide();
  }
}

findisfacing(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_4 = anglesToForward(var_0.angles);
  var_5 = var_1.origin - var_0.origin;
  var_4 = var_4 * (1, 1, 0);
  var_5 = var_5 * (1, 1, 0);
  var_5 = vectornormalize(var_5);
  var_4 = vectornormalize(var_4);
  var_6 = vectordot(var_5, var_4);
  if(var_6 >= var_3) {
    return 1;
  }

  return 0;
}

func_5B75(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(var_3 * 20);
  for(var_6 = 0; var_6 < var_5; var_6++) {
    wait(0.05);
  }
}

drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait(0.05);
  }
}

drawsphere(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait(0.05);
  }
}

setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var_0;
  } else {
    self.recoilscale = self.recoilscale + var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale) {
      var_1 = self.recoilscale;
    }

    var_2 = 100 - var_1;
  } else {
    var_2 = 100 - self.recoilscale;
  }

  if(var_2 < 0) {
    var_2 = 0;
  }

  if(var_2 > 100) {
    var_2 = 100;
  }

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

cleanarray(var_0) {
  var_1 = [];
  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
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
  self endon("makeExplosiveUnusable");
  for(;;) {
    level waittill("player_spawned", var_1);
    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
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
  if(isDefined(level.killstreaksdisabled) && level.killstreaksdisabled) {
    return 0;
  }

  if((!self isonground() || self iswallrunning()) && func_9F2C(var_0) || func_9D82(var_0) || func_9FB7(var_0) || func_9E90(var_0)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(isusingremote()) {
    return 0;
  }

  if(isDefined(self.selectinglocation)) {
    return 0;
  }

  if(scripts\mp\killstreaks\_emp_common::isemped()) {
    if(iskillstreakaffectedbyemp(var_0)) {
      if(!isDefined(var_1) && var_1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_WHEN_JAMMED");
      }

      return 0;
    }
  }

  if(isairdenied()) {
    if(isflyingkillstreak(var_0) && var_0 != "air_superiority") {
      if(!isDefined(var_1) && var_1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_WHEN_AA");
      }

      return 0;
    }
  }

  if(self isusingturret() && func_9F2C(var_0) || func_9D82(var_0) || func_9FB7(var_0)) {
    if(!isDefined(var_1) && var_1) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_USING_TURRET");
    }

    return 0;
  }

  if(isDefined(self.setlasermaterial) && !_hasperk("specialty_finalstand")) {
    if(!isDefined(level.var_1C99) || !level.var_1C99 || var_0 != "agent") {
      if(!isDefined(var_1) && var_1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");
      }

      return 0;
    }
  }

  if(!scripts\engine\utility::isweaponallowed()) {
    return 0;
  }

  if(isDefined(level.var_3FD9) && isflyingkillstreak(var_0)) {
    if(!isDefined(var_1) && var_1) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CIVILIAN_AIR_TRAFFIC");
    }

    return 0;
  }

  if(isDefined(var_0) && var_0 == "sentry_shock" && isinarbitraryup()) {
    if(!isDefined(var_1) && var_1) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    }

    return 0;
  }

  return 1;
}

func_9F2C(var_0) {
  switch (var_0) {
    case "thor":
    case "minijackal":
    case "drone_hive":
    case "venom":
      return 1;

    default:
      return 0;
  }
}

func_9E90(var_0) {
  switch (var_0) {
    case "bombardment":
    case "precision_airstrike":
      return 1;

    default:
      return 0;
  }
}

func_9EF0(var_0) {
  if(!isDefined(var_0.var_165A)) {
    return 0;
  }

  switch (var_0.var_165A) {
    case "remote_c8":
    case "spiderbot":
      return 1;

    default:
      return 0;
  }
}

func_9D82(var_0) {
  switch (var_0) {
    case "ims":
    case "deployable_exp_ammo":
    case "deployable_grenades":
    case "deployable_ammo":
    case "deployable_vest":
      return 1;

    default:
      return 0;
  }
}

func_9FBA(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "directional_uav":
    case "counter_uav":
    case "uav":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9D35(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "precision_airstrike":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9E7F(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "airdrop":
    case "dronedrop":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9E2D(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "jammer":
    case "jackal":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9F67(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "minijackal":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9D61(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "ball_drone_backup":
    case "venom":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9FB7(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "super_trophy":
    case "sentry_shock":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9F0F(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "bombardment":
    case "thor":
    case "drone_hive":
      var_1 = 1;
      break;
  }

  return var_1;
}

func_9D80(var_0) {
  return isDefined(var_0) && isDefined(var_0.id) && var_0.id == "care_package";
}

func_10060(var_0) {
  switch (var_0) {
    case "dronedrop":
    case "directional_uav":
    case "counter_uav":
    case "uav":
      return 0;

    default:
      return 1;
  }
}

iskillstreakaffectedbyemp(var_0) {
  switch (var_0) {
    case "fleet_swarm":
    case "zerosub_level_killstreak":
    case "dome_seekers":
    case "guard_dog":
    case "recon_agent":
    case "deployable_ammo":
    case "deployable_vest":
    case "precision_airstrike":
    case "minijackal":
    case "agent":
    case "spiderbot":
      return 0;

    default:
      return 1;
  }
}

iskillstreakaffectedbyjammer(var_0) {
  return iskillstreakaffectedbyemp(var_0) && !isflyingkillstreak(var_0);
}

func_9E6A(var_0) {
  switch (var_0) {
    case "bombardment":
      return 0;

    default:
      return 1;
  }
}

isflyingkillstreak(var_0) {
  switch (var_0) {
    case "orbital_deployment":
    case "ac130":
    case "ca_a10_strafe":
    case "vanguard":
    case "odin_assault":
    case "odin_support":
    case "heli_pilot":
    case "airdrop_juggernaut_maniac":
    case "airdrop_assault":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "fleet_swarm":
    case "airdrop":
    case "precision_airstrike":
    case "thor":
    case "drone_hive":
    case "air_superiority":
      return 1;

    default:
      return 0;
  }
}

func_7F4D(var_0) {
  return tablelookuprownum("mp\killstreakTable.csv", 1, var_0);
}

getkillstreakindex(var_0) {
  var_1 = tablelookup("mp\killstreakTable.csv", 1, var_0, 0);
  if(var_1 == "") {
    var_2 = -1;
  } else {
    var_2 = int(var_2);
  }

  return var_2;
}

func_7F4B(var_0) {
  return tablelookup("mp\killstreakTable.csv", 0, var_0, 1);
}

func_7F4C(var_0) {
  return tablelookup("mp\killstreakTable.csv", 12, var_0, 1);
}

func_7F47(var_0) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_0, 2);
}

func_7F38(var_0) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_0, 3);
}

func_7F46(var_0) {
  var_1 = scripts\engine\utility::ter_op(_hasperk("specialty_support_killstreaks"), 5, 4);
  return tablelookup("mp\killstreakTable.csv", 1, var_0, var_1);
}

getenemyinfo(var_0) {
  var_1 = strtok(var_0, "_");
  return var_1[1];
}

func_7F3C(var_0) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_0, 6);
}

func_7F51(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 7);
}

func_7F3B(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 8);
}

func_7F34(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 9);
}

func_7F3E(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 10);
}

func_7F40(var_0) {
  return int(tablelookup("mp\killstreakTable.csv", 1, var_0, 11));
}

getkillstreakweapon(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 12);
}

func_7F4E(var_0) {
  return int(tablelookup("mp\killstreakTable.csv", 1, var_0, 13));
}

func_7F43(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 14);
}

getkillstreakoverheadicon(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 15);
}

func_7F39(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 16);
}

func_7F53(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 17);
}

func_7F4F(var_0) {
  return tablelookup("mp\killstreakTable.csv", 1, var_0, 18);
}

currentactivevehiclecount(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = var_0;
  if(isDefined(level.helis)) {
    var_1 = var_1 + level.helis.size;
  }

  if(isDefined(level.littlebirds)) {
    var_1 = var_1 + level.littlebirds.size;
  }

  if(isDefined(level.ugvs)) {
    var_1 = var_1 + level.ugvs.size;
  }

  return var_1;
}

maxvehiclesallowed() {
  return 8;
}

fauxvehiclecount() {
  return level.fauxvehiclecount;
}

incrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0)) {
    level.fauxvehiclecount++;
    return;
  }

  level.fauxvehiclecount = level.fauxvehiclecount + var_0;
}

decrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0)) {
    level.fauxvehiclecount--;
  } else {
    level.fauxvehiclecount = level.fauxvehiclecount - var_0;
  }

  if(level.fauxvehiclecount < 0) {
    level.fauxvehiclecount = 0;
  }
}

lightweightscalar() {
  return 1.06;
}

allowteamassignment() {
  if(level.gametype == "gun" || level.gametype == "infect") {
    return 0;
  }

  if(!isDefined(self.pers["isBot"])) {
    if(isgamebattlematch()) {
      return 0;
    }

    if(getdvarint("com_codcasterEnabled", 0) > 0) {
      return 1;
    }
  }

  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout()) {
    return 0;
  }

  if(level.gametype == "cranked" || level.gametype == "mp_zomb") {
    return level.teambased;
  }

  var_0 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 4));
  return var_0;
}

allowclasschoice() {
  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout()) {
    return 0;
  }

  var_0 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 5));
  return var_0;
}

skiploadout() {
  return istrue(level.aonrules);
}

showfakeloadout() {
  return 0;
}

func_F6FF(var_0, var_1) {
  var_2 = getweaponrootname(var_0);
  var_3 = [];
  if(var_2 != "iw7_knife") {
    var_3 = getweaponattachments(var_0);
  }

  if(isDefined(var_2)) {
    var_4 = tablelookuprownum("mp\statsTable.csv", 4, var_2);
  }

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = -1;
    if(isDefined(var_3[var_5])) {
      if(!func_9D55(var_0, var_3[var_5])) {
        var_6 = tablelookuprownum("mp\attachmentTable.csv", 4, var_3[var_5]);
      }
    }
  }
}

setcommonrulesfrommatchdata(var_0) {
  var_1 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + level.gametype + "_timeLimit", var_1);
  registertimelimitdvar(level.gametype, var_1);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + level.gametype + "_scoreLimit", var_2);
  registerscorelimitdvar(level.gametype, var_2);
  var_3 = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar("scr_" + level.gametype + "_winLimit", var_3);
  registerwinlimitdvar(level.gametype, var_3);
  var_4 = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar("scr_" + level.gametype + "_roundLimit", var_4);
  registerroundlimitdvar(level.gametype, var_4);
  var_5 = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar("scr_" + level.gametype + "_roundSwitch", var_5);
  registerroundswitchdvar(level.gametype, var_5, 0, 9);
  var_6 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar("scr_" + level.gametype + "_winByTwoEnabled", var_6);
  registerwinbytwoenableddvar(level.gametype, var_6);
  var_7 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar("scr_" + level.gametype + "_winByTwoMaxRounds", var_7);
  registerwinbytwomaxroundsdvar(level.gametype, var_7);
  var_8 = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar("scr_" + level.gametype + "_dogTags", var_8);
  registerdogtagsenableddvar(level.gametype, var_8);
  var_9 = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar("scr_" + level.gametype + "_spawnProtectionTimer", var_9);
  var_0A = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + level.gametype + "_numLives", var_0A);
  registernumlivesdvar(level.gametype, var_0A);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = 0;
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdvar("camera_allow3rdspectate", getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdvar("lobby_team_select", getmatchrulesdata("commonOption", "teamAssignmentAllowed"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay", getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar("scr_" + level.gametype + "_waverespawndelay", getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.var_B409 = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.supportintel = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar("scr_" + level.gametype + "_allowKillstreaks", getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar("scr_" + level.gametype + "_allowPerks", getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar("scr_" + level.gametype + "_allowSupers", getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar("scr_" + level.gametype + "_ffPunishLimit", getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar("scr_" + level.gametype + "_doubleJump", getmatchrulesdata("commonOption", "doubleJumpEnabled"));
  setdynamicdvar("scr_" + level.gametype + "_wallRun", getmatchrulesdata("commonOption", "wallRunEnabled"));
  setdynamicdvar("scr_game_casualScoreStreaks", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar("scr_game_superFastChargeRate", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar("scr_game_superPointsMod", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar("scr_game_spawnProtectionTimer", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  level.crankedbombtimer = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar("scr_" + level.gametype + "_crankedBombTimer", level.crankedbombtimer);
  func_DEE9(level.gametype, level.crankedbombtimer);
  setdynamicdvar("scr_game_tacticalmode", getmatchrulesdata("commonOption", "tacticalMode"));
  setdynamicdvar("scr_game_cwltuning", getmatchrulesdata("commonOption", "bulletBounce"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));
  if(!isDefined(var_0)) {
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));
  }

  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));
  setdynamicdvar("scr_" + level.gametype + "_pointsPerKill", getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar("scr_" + level.gametype + "_pointsPerDeath", getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar("scr_" + level.gametype + "_pointsHeadshotBonus", getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar("scr_modDefense", 0);
  setdynamicdvar("scr_devRemoveDomFlag", "");
  setdynamicdvar("scr_devPlaceDomFlag", "");
  if(func_D957() || getdvarint("systemlink")) {
    setdvar("com_codcasterEnabled", getmatchrulesdata("commonOption", "codcasterEnabled"));
  }
}

func_DEE9(var_0, var_1) {
  registerwatchdvarint("crankedBombTimer", var_1);
}

func_F6A7() {}

func_B2AC(var_0) {
  leaderdialogonplayer(var_0);
  setcrankedplayerbombtimer("kill");
  self.cranked = 1;
  giveperk("specialty_fastreload");
  giveperk("specialty_quickdraw");
  giveperk("specialty_fastoffhand");
  giveperk("specialty_fastsprintrecovery");
  giveperk("specialty_marathon");
  giveperk("specialty_quickswap");
  giveperk("specialty_stalker");
  giveperk("specialty_sprintfire");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

oncranked(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 cleanupcrankedplayertimer();
  }

  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  if(isDefined(var_1.cranked)) {
    var_3 = "kill_cranked";
    var_1 thread func_C4DD(var_3);
  } else if(isreallyalive(var_1)) {
    var_1 func_B2AC("begin_cranked");
    var_1 thread scripts\mp\rank::scoreeventpopup("begin_cranked");
  }

  var_1 playsoundtoplayer("mp_bodycount_tick_positive", var_1);
  if(isDefined(var_0) && isDefined(var_0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_5 in var_0.attackers) {
      if(!isDefined(_validateattacker(var_5))) {
        continue;
      }

      if(var_5 == var_1) {
        continue;
      }

      if(var_0 == var_5) {
        continue;
      }

      if(!isDefined(var_5.cranked)) {
        continue;
      }

      var_5 thread func_C4DC("assist_cranked");
      var_5 thread scripts\mp\rank::scoreeventpopup("assist_cranked");
      var_5 playsoundtoplayer("mp_bodycount_tick_positive", var_5);
    }
  }
}

cleanupcrankedplayertimer() {
  self notify("stop_cranked");
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
}

func_C4DD(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  setcrankedplayerbombtimer("kill");
}

func_C4DC(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  setcrankedplayerbombtimer("assist");
}

setcrankedplayerbombtimer(var_0) {
  var_1 = level.crankedbombtimer;
  var_2 = 0;
  if(level.gametype == "conf" || level.gametype == "grind") {
    var_2 = 1;
  }

  if(isDefined(var_2) && var_2) {
    if(isDefined(self.cranked) && self.cranked && isDefined(self.cranked_end_time)) {
      var_1 = int(min(self.cranked_end_time - gettime() / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    } else {
      var_1 = int(var_1 * 0.5);
    }
  }

  if(var_0 == "assist" && !var_2) {
    var_1 = int(min(self.cranked_end_time - gettime() / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  }

  var_3 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_3);
  self.cranked_end_time = var_3;
  thread func_139E3();
  thread func_139E0(var_1);
  thread func_139E1();
}

func_139E3() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_cranked");
  level waittill("host_migration_begin");
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();
  if(self.cranked_end_time + var_0 < 5) {
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(var_0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_0);
    return;
  }

  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

func_139E1() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death");
  self endon("disconnect");
  self endon("stop_cranked");
  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait(0.1);
  }
}

func_139E0(var_0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_cranked");
  var_1 = 5;
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(var_0 - var_1 - 1);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  while(var_1 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1);
    var_1--;
  }

  if(isDefined(self) && isreallyalive(self) && level.gametype != "tdef") {
    self playSound("frag_grenade_explode");
    playFX(level.mine_explode, self.origin + (0, 0, 32));
    _suicide();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

reinitializematchrulesonmigration() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level.initializematchrules]]();
  }
}

reinitializethermal(var_0) {
  self endon("disconnect");
  if(isDefined(var_0)) {
    var_0 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");
    if(isDefined(self.lastvisionsetthermal)) {
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
    }
  }
}

getmatchrulesspecialclass(var_0, var_1) {
  var_2 = [];
  var_2["loadoutPrimaryAttachment2"] = "none";
  var_2["loadoutSecondaryAttachment2"] = "none";
  var_3 = [];
  var_2["loadoutPrimary"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "weapon");
  var_2["loadoutPrimaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachment", 0);
  var_2["loadoutPrimaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "attachment", 1);
  var_2["loadoutPrimaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutSecondary"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "weapon");
  var_2["loadoutSecondaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachment", 0);
  var_2["loadoutSecondaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "attachment", 1);
  var_2["loadoutSecondaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutPerks"] = var_3;
  var_2["loadoutKillstreak1"] = ::scripts\mp\class::recipe_getkillstreak(var_0, var_1, 0);
  var_2["loadoutKillstreak2"] = ::scripts\mp\class::recipe_getkillstreak(var_0, var_1, 1);
  var_2["loadoutKillstreak3"] = ::scripts\mp\class::recipe_getkillstreak(var_0, var_1, 2);
  var_2["loadoutJuggernaut"] = getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "juggernaut");
  return var_2;
}

func_DDD9(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  if(level.ingraceperiod && !self.hasdonecombat) {
    self waittill("giveLoadout");
  } else {
    self waittill("spawned_player");
  }

  if(var_0) {
    self notify("lost_juggernaut");
    wait(0.5);
  }

  if(!isDefined(self.isjuiced)) {
    self.movespeedscaler = 0.7;
    scripts\mp\weapons::updatemovespeedscale();
  }

  self.var_A4AA = 0.7;
  self disableweaponpickup();
  if(!getdvarint("camera_thirdPerson")) {
    self setclientomnvar("ui_juggernaut", 1);
  }

  thread scripts\mp\killstreaks\_juggernaut::func_A4A9();
  if(level.gametype != "jugg" || isDefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled) {
    self setperk("specialty_radarjuggernaut", 1);
  }

  if(isDefined(self.var_9E61) && self.var_9E61) {
    self makeportableradar(self);
  }

  level notify("juggernaut_equipped", self);
  thread scripts\mp\killstreaks\_juggernaut::func_A4AC();
}

updatesessionstate(var_0, var_1) {
  switch (var_0) {
    case "intermission":
    case "playing":
      var_1 = "";
      break;

    case "dead":
    case "spectator":
      if(istrue(level.doingbroshot)) {
        var_1 = "";
      } else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable)) {
          var_1 = "hud_status_dogtag";
        } else {
          var_1 = "hud_status_dead";
        }
      } else {
        var_1 = "hud_status_dead";
      }
      break;
  }

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self.sessionstate = var_0;
  self.getgrenadefusetime = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

getclassindex(var_0) {
  return level.classmap[var_0];
}

isteaminlaststand() {
  var_0 = getlivingplayers(self.team);
  foreach(var_2 in var_0) {
    if(var_2 != self && !isDefined(var_2.setlasermaterial) || !var_2.setlasermaterial) {
      return 0;
    }
  }

  return 1;
}

func_A6C7(var_0) {
  var_1 = getlivingplayers(var_0);
  foreach(var_3 in var_1) {
    if(isDefined(var_3.setlasermaterial) && var_3.setlasermaterial) {
      var_3 thread scripts\mp\damage::func_54C8(randomintrange(1, 3));
    }
  }
}

func_1136C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isai(self)) {
    if(isDefined(var_0) && issuperweapon(var_0)) {
      var_0 = undefined;
    }

    if(!isDefined(var_0)) {
      var_0 = scripts\engine\utility::getlastweapon();
      if(!self hasweapon(var_0)) {
        var_0 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
      }

      func_1136C(var_0, var_1);
    }

    if(var_1) {
      _switchtoweaponimmediate(var_0);
      return;
    }

    _switchtoweapon(var_0);
    return;
  }

  _switchtoweapon("none");
}

isaiteamparticipant(var_0) {
  if(isagent(var_0) && var_0.agent_teamparticipant == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

isteamparticipant(var_0) {
  if(isaiteamparticipant(var_0)) {
    return 1;
  }

  if(isplayer(var_0)) {
    return 1;
  }

  return 0;
}

isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

isgameparticipant(var_0) {
  if(isaigameparticipant(var_0)) {
    return 1;
  }

  if(isplayer(var_0)) {
    return 1;
  }

  return 0;
}

isoffhandweaponreadytothrow(var_0) {
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

getteamarray(var_0, var_1) {
  var_2 = [];
  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in level.players) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

isheadshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.triggerportableradarping)) {
      if(var_3.var_9F == "script_vehicle") {
        return 0;
      }

      if(var_3.var_9F == "misc_turret") {
        return 0;
      }

      if(var_3.var_9F == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien") {
        return 0;
      }
    }
  }

  if(var_2 == "MOD_EXPLOSIVE") {
    return 0;
  }

  return (var_1 == "head" || var_1 == "helmet") && var_2 != "MOD_MELEE" && var_2 != "MOD_IMPACT" && var_2 != "MOD_SCARAB" && var_2 != "MOD_CRUSH" && !isenvironmentweapon(var_0);
}

func_9E7D(var_0, var_1, var_2, var_3) {
  if(var_3 != "MOD_MELEE") {
    return 0;
  }

  if(!isDefined(var_1) || !isplayer(var_1)) {
    return 0;
  }

  if(var_1 scripts\mp\heavyarmor::hasheavyarmor()) {
    return 0;
  }

  if(var_0 _hasperk("passive_meleekill") || var_0 _hasperk("passive_meleekill_silent")) {
    return 1;
  }

  if(scripts\mp\weapons::isknifeonly(var_2)) {
    return 1;
  }

  if(scripts\mp\weapons::isballweapon(var_2)) {
    return 1;
  }

  if(scripts\mp\weapons::isaxeweapon(var_2) && var_0 getweaponammoclip(var_2) > 0) {
    return 1;
  }

  if(var_0 _meth_8519(var_2) && getweaponrootname(var_2) == "iw7_rvn") {
    return 1;
  }

  if(issubstr(var_2, "iw7_katana_mp") || issubstr(var_2, "iw7_nunchucks_mp")) {
    return 1;
  }

  return 0;
}

attackerishittingteam(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.triggerportableradarping)) {
    var_1 = var_1.triggerportableradarping;
  }

  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1) || !isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  if(level.gametype == "infect" && var_0.pers["team"] == var_1.team && isDefined(var_1.teamchangedthisframe)) {
    return 0;
  }

  if(level.gametype == "infect" && var_0.pers["team"] != var_1.team && isDefined(var_1.teamchangedthisframe)) {
    return 1;
  }

  if(isDefined(var_1.scrambled) && var_1.scrambled) {
    return 0;
  }

  if(func_9EF6(var_0, var_1)) {
    return 0;
  }

  if(isagent(var_0) && isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping == var_1) {
    return 0;
  }

  if(var_0.team == var_1.team) {
    return 1;
  }

  return 0;
}

func_F401(var_0) {
  if(!isDefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, var_0)) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, var_0);
    var_0 notify("calculate_new_level_targets");
  }
}

func_1758(var_0, var_1) {
  if(isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.use_time = var_1;
    var_0.bot_interaction_type = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
  }
}

func_E016(var_0) {
  if(isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
  }
}

func_1757(var_0) {
  if(isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.bot_interaction_type = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
  }
}

func_E015(var_0) {
  if(isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
  }
}

notify_enemy_bots_bomb_used(var_0) {
  if(isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"])) {
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var_0);
  }
}

get_rank_xp_for_bot() {
  if(isDefined(level.bot_funcs["bot_get_rank_xp"])) {
    return self[[level.bot_funcs["bot_get_rank_xp"]]]();
  }
}

bot_israndom() {
  return self getownerteam();
}

isassaultkillstreak(var_0) {
  switch (var_0) {
    case "uplink":
    case "vanguard":
    case "odin_assault":
    case "heli_pilot":
    case "airdrop_juggernaut_maniac":
    case "airdrop_assault":
    case "airdrop_juggernaut":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "guard_dog":
    case "ball_drone_backup":
    case "directional_uav":
    case "uav":
    case "ims":
    case "minijackal":
    case "drone_hive":
    case "sentry":
      return 1;

    default:
      return 0;
  }
}

func_9F25(var_0) {
  switch (var_0) {
    case "uav_3dping":
    case "aa_launcher":
    case "uplink_support":
    case "ball_drone_radar":
    case "sam_turret":
    case "uplink":
    case "orbital_deployment":
    case "odin_support":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "recon_agent":
    case "ball_drone_backup":
    case "jammer":
    case "deployable_ammo":
    case "deployable_vest":
    case "air_superiority":
      return 1;

    default:
      return 0;
  }
}

issupportkillstreak(var_0) {
  switch (var_0) {
    case "deployable_adrenaline_mist":
    case "deployable_speed_strip":
    case "uav_3dping":
    case "aa_launcher":
    case "uplink_support":
    case "ball_drone_radar":
    case "sam_turret":
    case "odin_support":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "recon_agent":
    case "jammer":
    case "deployable_ammo":
    case "deployable_vest":
    case "sentry_shock":
    case "air_superiority":
      return 1;

    default:
      return 0;
  }
}

isspecialistkillstreak(var_0) {
  switch (var_0) {
    case "specialty_chain_reaction_ks":
    case "specialty_deadeye_ks":
    case "specialty_boom_ks":
    case "specialty_twoprimaries_ks":
    case "specialty_hardline_ks":
    case "specialty_gambler_ks":
    case "specialty_explosivedamage_ks":
    case "specialty_extra_attachment_ks":
    case "specialty_extra_deadly_ks":
    case "specialty_extra_equipment_ks":
    case "specialty_extraammo_ks":
    case "specialty_gunsmith_ks":
    case "specialty_blastshield_ks":
    case "specialty_stun_resistance_ks":
    case "specialty_sharp_focus_ks":
    case "specialty_regenfaster_ks":
    case "specialty_falldamage_ks":
    case "specialty_comexp_ks":
    case "specialty_selectivehearing_ks":
    case "specialty_detectexplosive_ks":
    case "specialty_scavenger_ks":
    case "specialty_paint_ks":
    case "specialty_incog_ks":
    case "specialty_quieter_ks":
    case "specialty_gpsjammer_ks":
    case "specialty_blindeye_ks":
    case "specialty_silentkill_ks":
    case "specialty_sprintreload_ks":
    case "specialty_quickdraw_ks":
    case "specialty_bulletaccuracy_ks":
    case "specialty_pitcher_ks":
    case "specialty_quickswap_ks":
    case "specialty_reducedsway_ks":
    case "specialty_stalker_ks":
    case "specialty_marathon_ks":
    case "specialty_lightweight_ks":
    case "specialty_fastreload_ks":
    case "specialty_fastsprintrecovery_ks":
      return 1;

    default:
      return 0;
  }
}

bot_is_fireteam_mode() {
  var_0 = botautoconnectenabled() == 2;
  if(var_0) {
    if(!level.teambased || level.gametype != "war" && level.gametype != "dom") {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }

  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  }

  if(!isDefined(level.var_13E0F)) {
    level.var_13E0F = getdvar("xenonGame") == "true";
  }

  if(!isDefined(level.var_DADB)) {
    level.var_DADB = getdvar("ps3Game") == "true";
  }

  if(!isDefined(level.var_13E0E)) {
    level.var_13E0E = getdvar("xb3Game") == "true";
  }

  if(!isDefined(level.var_DADC)) {
    level.var_DADC = getdvar("ps4Game") == "true";
  }
}

func_9BEE() {
  if(level.var_13E0E || level.var_DADC || !level.console) {
    return 1;
  }

  return 0;
}

func_F6DB(var_0, var_1, var_2) {
  if(!isDefined(level.console) || !isDefined(level.var_13E0E) || !isDefined(level.var_DADC)) {
    func_F305();
  }

  if(func_9BEE()) {
    setdvar(var_0, var_2);
    return;
  }

  setdvar(var_0, var_1);
}

func_9FE7(var_0, var_1, var_2) {
  return isDefined(var_2.team) && var_2.team == var_1;
}

func_9FD8(var_0, var_1, var_2) {
  return isDefined(var_2.triggerportableradarping) && !isDefined(var_0) || var_2.triggerportableradarping != var_0;
}

gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

gethelipilottraceoffset() {
  return (0, 0, 2500);
}

func_7F78() {
  var_0 = [];
  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");
      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

get_players_watching(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];
  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }

    var_6 = 0;
    if(!var_1) {
      if(isDefined(var_5.team) && var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();
        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5.missile_createrepulsorent == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.setclientmatchdatadef == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);
  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");
    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      var_8 thread reset_visionset_on_team_change(self, var_1 + var_2);
      var_8 thread reset_visionset_on_disconnect(self);
      if(var_8 isinkillcam()) {
        var_8 thread reset_visionset_on_spawn();
      }
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0);
}

reset_visionset_on_team_change(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;
  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    wait(0.05);
  }
}

reset_visionset_on_disconnect(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");
  self visionsetnakedforplayer("", 0);
}

_validateattacker(var_0) {
  if(isagent(var_0) && !isDefined(var_0.isactive) || !var_0.isactive) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

func_143B(var_0) {
  if(!isreallyalive(var_0)) {
    return undefined;
  }

  return var_0;
}

_magicbullet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = magicbullet(var_0, var_1, var_2, var_3, var_4);
  if(isDefined(var_5) && isDefined(var_3)) {
    var_5 setotherent(var_3);
  }

  return var_5;
}

_launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);
  if(!isDefined(var_4)) {
    var_6.notthrown = 1;
  } else {
    var_6.notthrown = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

func_1377B() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);
    if(!func_85E0(var_0)) {
      continue;
    }

    _meth_85C6(var_0, var_1, var_2, var_3);
    self notify("grenade_throw");
    return var_0;
  }
}

func_85E0(var_0) {
  return !isDefined(var_0.notthrown) || !var_0.notthrown;
}

_meth_85C7() {
  return self _meth_854D() != "none";
}

func_7EE5() {
  var_0 = self _meth_854D();
  if(isDefined(self.gestureweapon) && var_0 == self.gestureweapon) {
    var_0 = "none";
  }

  return var_0;
}

_meth_85C6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.weapon_name)) {
    var_0.weapon_name = var_1;
  }

  if(!isDefined(var_0.triggerportableradarping)) {
    var_0.triggerportableradarping = self;
  }

  if(!isDefined(var_0.team)) {
    var_0.team = self.team;
  }

  if(!isDefined(var_0.tickpercent)) {
    var_0.tickpercent = var_2;
  }

  if(!isDefined(var_0.ticks) && isDefined(var_0.tickpercent)) {
    var_0.ticks = roundup(4 * var_2);
  }

  var_4 = scripts\mp\powers::func_D737(var_1);
  if(isDefined(var_4)) {
    var_0.power = var_4;
    var_0.var_9F07 = 1;
  }

  var_0.threwback = isDefined(var_3);
}

waittill_missile_fire() {
  self waittill("missile_fire", var_0, var_1);
  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      var_0.weapon_name = getweaponbasedsmokegrenadecount(var_1);
    }

    if(!isDefined(var_0.triggerportableradarping)) {
      var_0.triggerportableradarping = self;
    }

    if(!isDefined(var_0.team)) {
      var_0.team = self.team;
    }
  }

  return var_0;
}

_setnameplatematerial(var_0, var_1) {
  if(!isDefined(self.var_BE4C)) {
    self.var_BE4C = [];
    self.var_D8B9 = [];
  } else {
    self.var_D8B9[0] = self.var_BE4C[0];
    self.var_D8B9[1] = self.var_BE4C[1];
  }

  self.var_BE4C[0] = var_0;
  self.var_BE4C[1] = var_1;
  self _meth_8315(var_0, var_1);
}

func_13B6() {
  if(isDefined(self.var_D8B9)) {
    self _meth_8315(self.var_D8B9[0], self.var_D8B9[1]);
  } else {
    self _meth_8315("", "");
  }

  self.var_BE4C = undefined;
  self.var_D8B9 = undefined;
}

isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.bombzones)) {
    foreach(var_2 in level.bombzones) {
      if(self istouching(var_2.noweapondropallowedtrigger)) {
        return 0;
      }
    }
  }

  return 1;
}

func_13C9A(var_0, var_1) {
  if(issuperweapon(var_0)) {
    return 1;
  }

  var_0 = getweaponbasedsmokegrenadecount(var_0);
  if(var_0 == "heli_pilot_turret_mp" || var_0 == "bomb_site_mp" || var_0 == "sentry_shock_mp" || var_0 == "portal_grenade_mp" || var_0 == "blackout_grenade_mp" || var_0 == "concussion_grenade_mp" || var_0 == "cryo_mine_mp" || var_0 == "fear_grenade_mp" || var_0 == "chargemode_mp" || var_0 == "emp_grenade_mp" || var_0 == "minijackal_strike_mp" || var_0 == "bombproj_mp" || var_0 == "iw7_blackholegun_mp" || var_0 == "iw7_cheytac_mpr_projectile" || var_0 == "artillery_mp" || var_0 == "groundpound_mp" || var_0 == "drone_hive_projectile_mp" || var_0 == "swtich_blade_child_mp" || var_0 == "thorproj_mp" || var_0 == "thorproj_zoomed_mp" || var_0 == "thorproj_tracking_mp") {
    return 1;
  }

  if(var_0 == "iw7_revolver_mpr_explosive" && isDefined(var_1) && var_1 != "none") {
    return 1;
  }

  return 0;
}

func_9F7E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_1.stuckenemyentity)) {
    return 0;
  }

  if(var_1.stuckenemyentity != var_0) {
    return 0;
  }

  return 1;
}

func_9F7F(var_0, var_1, var_2, var_3) {
  if(!func_9F7E(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return 1;
}

restorebasevisionset(var_0) {
  self visionsetnakedforplayer("", var_0);
}

playplayerandnpcsounds(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playsoundtoteam(var_2, "allies", var_0);
  var_0 playsoundtoteam(var_2, "axis", var_0);
}

isenemy(var_0) {
  if(level.teambased) {
    return isplayeronenemyteam(var_0);
  }

  return isplayerffaenemy(var_0);
}

isplayeronenemyteam(var_0) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_0) {
  if(isDefined(var_0.triggerportableradarping)) {
    return var_0.triggerportableradarping != self;
  }

  return var_0 != self;
}

setextrascore0(var_0) {
  self.istransientqueued = var_0;
  setpersstat("extrascore0", var_0);
}

setextrascore1(var_0) {
  self.isturretactive = var_0;
  setpersstat("extrascore1", var_0);
}

func_1C9B() {
  if(level.gametype == "infect") {
    return 0;
  }

  return 1;
}

getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();
  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

setkillstreakpoints() {
  var_0 = scripts\engine\utility::array_removeundefined(level.players);
  for(;;) {
    if(!var_0.size) {
      return;
    }

    var_1 = randomintrange(0, var_0.size);
    var_2 = var_0[var_1];
    if(!isreallyalive(var_2) || var_2.sessionstate != "playing") {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      continue;
    }

    return var_2;
  }
}

getmapname() {
  if(!isDefined(level.mapname)) {
    level.mapname = getdvar("mapname");
  }

  return level.mapname;
}

issinglehitweapon(var_0) {
  var_0 = getweaponbasedsmokegrenadecount(var_0);
  switch (var_0) {
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
      return 1;

    default:
      return 0;
  }
}

gamehasneutralcrateowner(var_0) {
  switch (var_0) {
    case "sotf_ffa":
    case "sotf":
      return 1;

    default:
      return 0;
  }
}

func_22B1(var_0, var_1) {
  var_2 = [];
  foreach(var_5, var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_5] = var_4;
    }
  }

  return var_2;
}

array_remove_index(var_0, var_1) {
  var_2 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_3 == var_1) {
      continue;
    }

    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

isanymlgmatch() {
  if(getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning")) {
    return 1;
  }

  return 0;
}

ismlgsystemlink() {
  if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning")) {
    return 1;
  }

  return 0;
}

ismlgprivatematch() {
  if(func_D957() && getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning")) {
    return 1;
  }

  return 0;
}

ismlgmatch() {
  if(ismlgsystemlink() || ismlgprivatematch()) {
    return 1;
  }

  return 0;
}

setmlgannouncement(var_0, var_1, var_2, var_3) {
  if(var_1 == "axis") {
    var_0 = var_0 + 2000;
  } else if(var_1 == "allies") {
    var_0 = var_0 + 1000;
  }

  if(isDefined(var_2)) {
    var_0 = var_0 + var_2 + 1 * 10000;
  }

  if(isDefined(var_3)) {
    if(isnumber(var_3)) {
      var_0 = var_0 + var_3 + 1 * 1000000;
    } else {
      scripts\engine\utility::error("mlg announcement extra data supports numbers only. Invalid extra data: " + var_3);
    }
  }

  setomnvar("ui_mlg_announcement", var_0);
}

ismoddedroundgame() {
  if(level.gametype == "ball" || level.gametype == "dom" || level.gametype == "front" || level.gametype == "ctf") {
    return 1;
  }

  return 0;
}

isusingdefaultclass(var_0, var_1) {
  var_2 = 0;
  if(isDefined(var_1)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "inUse")) {
      var_2 = 1;
    }
  } else {
    for(var_1 = 0; var_1 < 6; var_1++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "inUse")) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

func_3899(var_0) {
  var_1 = 1;
  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom && isDefined(self.var_3938) && !self[[self.var_3938]](var_0)) {
    var_1 = 0;
  }

  return var_1;
}

func_D911() {
  if(isDefined(self.var_A699)) {
    [[self.var_A699]]();
  }
}

func_F5C6(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getrestorerate(var_0);
  self.var_116D0 = 1;
  self goalflag(var_0, var_1);
  if(!isDefined(var_3) || !var_3) {
    wait(var_2);
  } else {
    var_5 = self energy_getmax(var_0);
    for(;;) {
      if(self goal_position(var_0) >= var_5) {
        break;
      }

      wait(0.05);
    }
  }

  self goalflag(var_0, var_4);
  self.var_116D0 = 0;
}

func_F5C5(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getresttimems(var_0);
  self.var_116D1 = 1;
  self goal_type(var_0, var_1);
  if(!isDefined(var_3) || !var_3) {
    wait(var_2);
  } else {
    var_5 = self energy_getmax(var_0);
    for(;;) {
      if(self goal_position(var_0) >= var_5) {
        break;
      }

      wait(0.05);
    }
  }

  self goal_type(var_0, var_4);
  self.var_116D1 = 0;
}

func_13AF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  self radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

delayentdelete(var_0) {
  self endon("death");
  wait(var_0);
  if(isDefined(self)) {
    self delete();
  }
}

hashealthshield(var_0) {
  return isDefined(var_0) && isDefined(var_0.var_8CC8);
}

func_7EF7(var_0) {
  return int(var_0 * self.var_8CC9);
}

func_F741(var_0) {
  self.var_8CC8 = 1;
  if(!isDefined(self.var_8CC9)) {
    self.var_8CC9 = 1;
  }

  var_0 = int(clamp(var_0, 0, 100));
  var_1 = 100 - var_0 / 100;
  if(var_1 < self.var_8CC9) {
    self.var_8CC9 = var_1;
  }
}

clearhealthshield() {
  self.var_8CC8 = undefined;
  self.var_8CC9 = undefined;
}

func_108CB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnfx(scripts\engine\utility::getfx(var_2), var_1);
  triggerfx(var_5);
  foreach(var_7 in level.players) {
    var_8 = scripts\mp\damage::isfriendlyfire(var_0, var_7);
    if(var_7 == var_0 && isDefined(var_4)) {
      var_8 = var_4;
    }

    if(!var_8) {
      var_5 hidefromplayer(var_7);
    }
  }

  var_0A = spawnfx(scripts\engine\utility::getfx(var_3), var_1);
  triggerfx(var_0A);
  foreach(var_7 in level.players) {
    var_8 = scripts\mp\damage::isfriendlyfire(var_0, var_7);
    if(var_7 == var_0 && isDefined(var_4)) {
      var_8 = var_4;
    }

    if(var_8) {
      var_0A hidefromplayer(var_7);
    }
  }

  var_0D = [];
  var_0D[0] = var_5;
  var_0D[1] = var_0A;
  return var_0D;
}

func_D486(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in level.players) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(isDefined(var_7) && scripts\engine\utility::array_contains(var_7, var_9)) {
      continue;
    }

    if(isDefined(var_5) && scripts\engine\utility::array_contains(var_5, var_9)) {
      var_0A = 1;
    } else if(isDefined(var_6) && scripts\engine\utility::array_contains(var_6, var_9)) {
      var_0A = 0;
    } else {
      var_0A = func_9E05(var_2, var_9);
    }

    if(var_0A) {
      playfxontagforclients(var_3, var_0, var_1, var_9);
      continue;
    }

    playfxontagforclients(var_4, var_0, var_1, var_9);
  }
}

func_11071(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in level.players) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(isDefined(var_7) && scripts\engine\utility::array_contains(var_7, var_9)) {
      continue;
    }

    if(isDefined(var_5) && scripts\engine\utility::array_contains(var_5, var_9)) {
      var_0A = 1;
    } else if(isDefined(var_6) && scripts\engine\utility::array_contains(var_6, var_9)) {
      var_0A = 0;
    } else {
      var_0A = func_9E05(var_2, var_9);
    }

    if(var_0A) {
      stopfxontagforclients(var_3, var_0, var_1, var_9);
      continue;
    }

    stopfxontagforclients(var_4, var_0, var_1, var_9);
  }
}

playteamfxforclient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  if(self.team != var_0) {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_3), var_1, self);
  } else {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_2), var_1, self);
  }

  if(isDefined(var_6)) {
    triggerfx(var_6);
  }

  var_6 thread delayentdelete(var_4);
  if(isDefined(var_5) && var_5) {
    var_6 thread deleteonplayerdeathdisconnect(self);
  }

  return var_6;
}

deleteonplayerdeathdisconnect(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self delete();
}

getmatchrulesdatawithteamandindex(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 == "axis") {
    var_2 = var_2 + 6;
  }

  if(isDefined(var_6)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5);
  }

  return getmatchrulesdata(var_0, var_2, var_3, var_4);
}

func_7D91(var_0, var_1) {
  return var_0 * 5 + var_1;
}

clearscrambler(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_player"];
  return func_7E9B(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

getplayersinradiusview(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_player"];
  var_5 = [];
  var_6 = func_7E9B(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
  foreach(var_8 in var_6) {
    var_9 = undefined;
    var_0A = [var_8 gettagorigin("j_head"), var_8 gettagorigin("j_mainroot"), var_8 gettagorigin("tag_origin")];
    for(var_0B = 0; var_0B < var_0A.size; var_0B++) {
      if(!scripts\common\trace::ray_trace_passed(var_0, var_0A[var_0B], level.characters, scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }

      if(!isDefined(var_9)) {
        var_5[var_5.size] = spawnStruct();
        var_5[var_5.size - 1].player = var_8;
        var_5[var_5.size - 1].visiblelocations = [];
        var_9 = 1;
      }

      var_5[var_5.size - 1].visiblelocations[var_5[var_5.size - 1].visiblelocations.size] = var_0A[var_0B];
    }
  }

  return var_5;
}

botpredictseepoint(var_0, var_1, var_2, var_3) {
  return func_7E9B(var_0, var_1, var_2, var_3, scripts\common\trace::create_character_contents());
}

func_7E9B(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0) {
    return [];
  }

  var_5 = undefined;
  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_5 = var_3;
    } else {
      var_5 = [var_3];
    }
  }

  var_6 = physics_querypoint(var_0, var_1, var_4, var_5, "physicsquery_all");
  var_7 = [];
  if(!isDefined(var_2)) {
    foreach(var_9 in var_6) {
      var_0A = var_9["entity"];
      var_7[var_7.size] = var_0A;
    }
  } else {
    foreach(var_9 in var_9) {
      var_0A = var_9["entity"];
      if(isDefined(var_0A.team) && var_0A.team == var_2) {
        var_7[var_7.size] = var_0A;
      }
    }
  }

  return var_7;
}

roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5) {
    return int(var_0 + 1);
  }

  return int(var_0);
}

func_9E05(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isplayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0 != var_1.team) {
    return 0;
  }

  return 1;
}

playersareenemies(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return undefined;
  }

  if(level.teambased) {
    return var_0.team != var_1.team;
  }

  return var_0 != var_1;
}

istrue(var_0) {
  return isDefined(var_0) && var_0;
}

adddamagemodifier(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var_0] = var_1;
    if(isDefined(var_3)) {
      if(!isDefined(self.var_17DE)) {
        self.var_17DE = [];
      }

      self.var_17DE[var_0] = var_3;
      return;
    }

    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var_0] = var_1;
  if(isDefined(var_3)) {
    if(!isDefined(self.var_BDC7)) {
      self.var_BDC7 = [];
    }

    self.var_BDC7[var_0] = var_3;
  }
}

removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var_0] = undefined;
    if(!isDefined(self.var_17DE)) {
      return;
    }

    self.var_17DE[var_0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var_0] = undefined;
  if(!isDefined(self.var_BDC7)) {
    return;
  }

  self.var_BDC7[var_0] = undefined;
}

getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1;
  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_0B, var_9 in self.additivedamagemodifiers) {
      var_0A = 0;
      if(isDefined(self.var_17DE) && isDefined(self.var_17DE[var_0B])) {
        var_0A = [[self.var_17DE[var_0B]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_0A) {
        var_7 = var_7 + var_9 - 1;
      }
    }
  }

  var_0C = 1;
  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_0B, var_9 in self.multiplicativedamagemodifiers) {
      var_0A = 0;
      if(isDefined(self.var_BDC7) && isDefined(self.var_BDC7[var_0B])) {
        var_0A = [[self.var_BDC7[var_0B]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_0A) {
        var_0C = var_0C * var_9;
      }
    }
  }

  return var_7 * var_0C;
}

cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.var_17DE = [];
  self.var_BDC7 = [];
}

_enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1) {
      self enablecollisionnotifies(0);
    }

    self.enabledcollisionnotifies--;
  }
}

func_1C4A(var_0) {
  if(self.loadoutarchetype != "archetype_heavy") {
    return;
  }

  if(var_0) {
    if(!isDefined(self.var_55CB)) {
      self.var_55CB = 0;
    }

    self.var_55CB--;
    if(!self.var_55CB) {
      self allowgroundpound(1);
      return;
    }

    return;
  }

  if(!isDefined(self.var_55CB)) {
    self.var_55CB = 0;
  }

  self.var_55CB++;
  self allowgroundpound(0);
}

func_1C41(var_0) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }

  if(var_0) {
    if(!isDefined(self.var_55C4)) {
      self.var_55C4 = 0;
    }

    self.var_55C4--;
    if(!self.var_55C4) {
      self allowdodge(1);
      return;
    }

    return;
  }

  if(!isDefined(self.var_55C4)) {
    self.var_55C4 = 0;
  }

  self.var_55C4++;
  self allowdodge(0);
}

func_1C47(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55C9)) {
      self.var_55C9 = 0;
    } else {
      self.var_55C9--;
    }

    if(!self.var_55C9) {
      if(scripts\engine\utility::is_player_gamepad_enabled()) {
        _setactionslot(3, "taunt");
        return;
      }

      _setactionslot(7, "taunt");
      return;
    }

    return;
  }

  if(!isDefined(self.var_55C9)) {
    self.var_55C9 = 0;
  }

  self.var_55C9++;
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    _setactionslot(3, "");
    return;
  }

  _setactionslot(7, "");
}

func_13A1E(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var_5 = undefined;
    if(var_4) {
      var_5 = clearscrambler(self.origin, var_0);
    } else {
      var_5 = func_7E9B(self.origin, var_0);
    }

    if(var_5.size > 0) {
      if(!var_3) {
        self notify(var_1, var_5);
      } else {
        var_6 = [];
        foreach(var_8 in var_5) {
          var_9 = self getorigin();
          var_0A = scripts\engine\utility::ter_op(var_4, var_8 getEye(), var_8.origin);
          var_0B = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_canshootclip"]);
          var_0C = physics_raycast(var_9, var_0A, var_0B, undefined, 0, "physicsquery_closest");
          if(var_0C.size <= 0) {
            var_6[var_6.size] = var_8;
          }
        }

        self notify(var_1, var_6);
      }
    }

    wait(var_2);
  }
}

func_3880() {
  self notify("end_entities_in_radius");
}

isleft2d(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

radiusplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  var_0A = scripts\common\trace::create_character_contents();
  var_0B = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_0C = [];
  foreach(var_0E in level.characters) {
    if(!isDefined(var_0E)) {
      continue;
    }

    if(!isreallyalive(var_0E)) {
      var_0C[var_0C.size] = var_0E;
      continue;
    }

    if(var_9 && var_0E == var_5) {
      var_0C[var_0C.size] = var_0E;
      continue;
    }

    if(level.teambased && var_0E.team == var_5.team) {
      var_0C[var_0C.size] = var_0E;
    }
  }

  var_10 = physics_querypoint(var_5.origin, var_2, var_0A, var_0C, "physicsquery_all");
  if(isDefined(var_10) && var_10.size > 0) {
    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = var_10[var_11]["entity"];
      var_13 = var_10[var_11]["distance"];
      var_14 = var_10[var_11]["position"];
      var_15 = physics_raycast(var_0, var_14, var_0B, undefined, 0, "physicsquery_closest");
      if(isDefined(var_15) && var_15.size > 0) {
        continue;
      }

      var_16 = max(var_13, var_1) / var_2;
      var_17 = var_3 + var_4 - var_3 * var_16;
      var_12 dodamage(var_17, var_0, var_5, var_6, var_7, var_8);
    }
  }
}

func_9EAF(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "orbital_deployment":
      return 1;
  }

  return var_1;
}

func_1824(var_0, var_1, var_2) {
  func_50A5(var_0, var_2);
  if(isDefined(var_2)) {
    self.var_EC52[var_0][var_2] = self.var_EC52[var_0][var_2] + var_1;
    return;
  }

  self.var_EC51[var_0] = self.var_EC51[var_0] + var_1;
}

func_E165(var_0, var_1, var_2) {
  func_50A5(var_0, var_2);
  if(isDefined(var_2)) {
    self.var_EC52[var_0][var_2] = self.var_EC52[var_0][var_2] - var_1;
    return;
  }

  self.var_EC51[var_0] = self.var_EC51[var_0] - var_1;
}

_meth_8101(var_0, var_1) {
  func_50A5(var_0, var_1);
  if(isDefined(var_1)) {
    return self.var_EC52[var_0][var_1];
  }

  return self.var_EC51[var_0];
}

func_50A5(var_0, var_1) {
  if(!isDefined(self.var_EC52)) {
    self.var_EC52 = [];
  }

  if(!isDefined(self.var_EC51)) {
    self.var_EC51 = [];
  }

  if(isDefined(var_1)) {
    if(!isDefined(self.var_EC52[var_0])) {
      self.var_EC52[var_0] = [];
    }

    if(!isDefined(self.var_EC52[var_0][var_1])) {
      self.var_EC52[var_0][var_1] = 1;
      return;
    }

    return;
  }

  if(!isDefined(self.var_EC51[var_0])) {
    self.var_EC51[var_0] = 1;
  }
}

func_DE39(var_0) {
  foreach(var_3, var_2 in self.powers) {
    func_DE38(var_3, var_0);
  }
}

func_DE38(var_0, var_1) {
  var_2 = self.powers[var_0];
  var_3 = level.powers[var_0];
  var_4 = var_3.cooldowntime;
  var_5 = var_2.var_4617;
  if(!isDefined(var_4) || !isDefined(var_5) || var_5 <= 0 || var_5 >= var_4) {
    return;
  }

  var_5 = var_5 + var_1;
  if(var_5 >= var_4) {
    var_5 = var_4;
  }

  scripts\mp\powers::func_D74F(var_0, var_5);
}

pointvscone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 - var_1;
  var_9 = vectordot(var_8, var_2);
  var_0A = vectordot(var_8, var_3);
  if(var_9 > var_4) {
    return 0;
  }

  if(var_9 < var_5) {
    return 0;
  }

  if(isDefined(var_7)) {
    if(abs(var_0A) > var_7) {
      return 0;
    }
  }

  if(scripts\engine\utility::anglebetweenvectors(var_2, var_8) > var_6) {
    return 0;
  }

  return 1;
}

func_D64A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = vectordot(var_5, var_3);
  if(var_6 < 0 || var_6 > var_1) {
    return 0;
  }

  var_5 = var_5 - var_6 * var_3;
  var_7 = lengthsquared(var_5);
  if(var_7 > var_0) {
    return 0;
  }

  return 1;
}

func_1319B(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

func_9EF6(var_0, var_1) {
  var_2 = 0;
  if(isagent(var_0) && isDefined(var_0.agent_type) && var_0.agent_type == "playerProxy") {
    if(var_0.triggerportableradarping == var_1) {
      var_2 = 1;
    }
  }

  return var_2;
}

givestreakpointswithtext(var_0, var_1, var_2) {
  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  var_3 = func_B93D(var_0, var_3, var_1);
  scripts\mp\killstreaks\_killstreaks::_meth_83A7(var_0, var_3);
  displayscoreeventpoints(var_3, var_0);
  if(var_0 == "assist_hardline") {
    scripts\mp\missions::func_D991("ch_hardline_extra_score", var_3);
  }
}

giveunifiedpoints(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.ignorescoring) && !issubstr(var_0, "assist")) {
    return;
  }

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  var_6 = func_B93D(var_0, var_6, var_1);
  scripts\mp\gamescore::giveplayerscore(var_0, var_6);
  scripts\mp\killstreaks\_killstreaks::_meth_83A7(var_0, var_6);
  if(!istrue(var_5)) {
    thread scripts\mp\rank::giverankxp(var_0, var_6, var_1);
  }

  if(shouldgivesuperpoints(var_0) && var_6 > 0) {
    scripts\mp\supers::stopshellshock(var_6);
  }

  if(!istrue(var_4)) {
    displayscoreeventpoints(var_6, var_0);
  }
}

displayscoreeventpoints(var_0, var_1) {
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    foreach(var_3 in level.players) {
      if(var_3 ismlgspectator()) {
        var_4 = var_3 getspectatingplayer();
        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();
          if(var_5 == var_6) {
            var_3 thread scripts\mp\rank::scorepointspopup(var_0);
            var_3 thread scripts\mp\rank::scoreeventpopup(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level.var_10269)) {
    var_8 = 0;
    if(issimultaneouskillenabled()) {
      var_8 = var_1 == "kill";
    }

    thread scripts\mp\rank::scorepointspopup(var_0, var_8);
  }

  thread scripts\mp\rank::scoreeventpopup(var_1);
}

func_B93D(var_0, var_1, var_2) {
  var_3 = var_1;
  switch (var_0) {
    case "damage":
      return 0;

    default:
      break;
  }

  var_4 = 0;
  var_4 = var_4 + scripts\mp\supers\super_amplify::func_1E58(var_3);
  var_5 = _meth_8101(var_0, var_2);
  var_5 = var_5 - 1;
  var_4 = var_4 + var_3 * var_5;
  var_1 = var_1 + var_4;
  if(isDefined(level.modifyunifiedpointscallback)) {
    var_1 = [[level.modifyunifiedpointscallback]](var_1, var_0, self, var_2);
  }

  return int(var_1);
}

shouldgivesuperpoints(var_0) {
  switch (var_0) {
    case "super_pack":
    case "scorestreak_pack":
    case "battery_pack":
      return 0;

    case "medal_mode_sd_last_defuse_score":
    case "medal_mode_sd_defuse_score":
    case "plant":
      return !isanymlgmatch();

    default:
      return 1;
  }
}

func_248F(var_0) {
  if(isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "mod_")) {
    return 1;
  }

  return 0;
}

func_248E(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "cos_");
}

_hudoutlineviewmodeldisable() {
  if(!isreallyalive(self)) {
    return;
  }

  self _meth_8192();
}

_hudoutlineviewmodelenable(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isplayer(self)) {}

  if(!var_1 && !isreallyalive(self)) {}

  if(var_1 && !isreallyalive(self)) {
    thread func_91AE(var_0);
    return;
  }

  self gettag(var_0, var_2);
}

func_91AE(var_0) {
  level endon("game_ended");
  self waittill("spawned");
  if(!isDefined(self)) {
    return;
  }

  if(!isreallyalive(self)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  self gettag(var_0);
}

func_627A(var_0, var_1) {
  if(var_0) {
    physics_setgravityragdollscalar(var_1);
    level.var_DC24 = 1;
    return;
  }

  physics_setgravityragdollscalar(1);
  level.var_DC24 = undefined;
}

isragdollzerog() {
  return istrue(level.var_DC24);
}

isbombsiteweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "briefcase_bomb_mp":
    case "bomb_site_mp":
      return 1;
  }

  return 0;
}

isgesture(var_0) {
  if(issubstr(var_0, "ges_plyr")) {
    return 1;
  }

  if(issubstr(var_0, "devilhorns_mp")) {
    return 1;
  }

  return 0;
}

iskillstreakweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(scripts\engine\utility::isdestructibleweapon(var_0)) {
    return 0;
  }

  if(isbombsiteweapon(var_0)) {
    return 0;
  }

  if(isgesture(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "killstreak")) {
    return 1;
  }

  if(issubstr(var_0, "remote_tank_projectile")) {
    return 1;
  }

  if(issubstr(var_0, "minijackal_")) {
    return 1;
  }

  if(isDefined(level.killstreakweildweapons) && isDefined(level.killstreakweildweapons[var_0])) {
    return 1;
  }

  var_0 = func_1717(var_0);
  if(scripts\engine\utility::isairdropmarker(var_0)) {
    return 1;
  }

  var_1 = weaponinventorytype(var_0);
  if(isDefined(var_1) && var_1 == "exclusive") {
    return 1;
  }

  return 0;
}

func_1717(var_0) {
  if(issubstr(var_0, "iw7") || issubstr(var_0, "iw6")) {
    var_1 = getweaponrootname(var_0);
    var_0 = func_13C75(var_1);
    if(var_0 == var_1) {
      var_0 = var_0 + "_mp";
    }
  } else {
    var_2 = strtok(var_0, "_");
    if(!scripts\engine\utility::string_starts_with(var_2[var_2.size - 1], "mp")) {
      var_0 = var_0 + "_mp";
    }
  }

  return var_0;
}

placeequipmentfailed(var_0, var_1, var_2, var_3) {
  self playlocalsound("scavenger_pack_pickup");
  if(istrue(var_1)) {
    var_4 = undefined;
    if(isDefined(var_3)) {
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
    } else {
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
    }

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
  }

  switch (var_0) {
    case "micro_turret_mp":
    case "shard_ball_mp":
    case "deployable_cover_mp":
    case "trophy_mp":
    case "domeshield_mp":
    case "cryo_mine_mp":
    case "trip_mine_mp":
    case "blackhole_grenade_mp":
      if(isplayer(self) && isreallyalive(self)) {
        self iprintlnbold("Placement Failed");
      }

      break;
  }
}

func_CC18() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
}

placeequipmentfailedcleanup(var_0) {
  wait(2);
  var_0 delete();
}

bufferednotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  level endon("game_ended");
  var_9 = "bufferedNotify_" + var_0;
  self notify(var_9);
  self endon(var_9);
  if(!isDefined(self.bufferednotifications)) {
    self.bufferednotifications = [];
  }

  if(!isDefined(self.bufferednotifications[var_0])) {
    self.bufferednotifications[var_0] = [];
  }

  var_0A = spawnStruct();
  var_0A.var_C8E5 = var_1;
  var_0A.var_C8E6 = var_2;
  var_0A.var_C8E7 = var_3;
  var_0A.var_C8E8 = var_4;
  var_0A.var_C8E9 = var_5;
  var_0A.var_C8EA = var_6;
  var_0A.var_C8EB = var_7;
  var_0A.var_C8EC = var_8;
  self.bufferednotifications[var_0][self.bufferednotifications[var_0].size] = var_0A;
  waittillframeend;
  while(self.bufferednotifications[var_0].size > 0) {
    var_0A = self.bufferednotifications[var_0][0];
    self notify(var_0, var_0A.var_C8E5, var_0A.var_C8E6, var_0A.var_C8E7, var_0A.var_C8E8, var_0A.var_C8E9, var_0A.var_C8EA, var_0A.var_C8EB, var_0A.var_C8EC);
    self.bufferednotifications[var_0] = array_remove_index(self.bufferednotifications[var_0], 0);
    wait(0.05);
  }
}

clearanim() {
  if(level.rankedmatch) {
    return "mp";
  }

  return "mp_private";
}

clearalltextafterhudelem() {
  if(level.rankedmatch) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

func_F7F1() {
  level.var_10E59 = clearanim();
  level.loadoutsgroup = clearalltextafterhudelem();
}

func_F751() {
  self.var_9331 = 1;
}

func_41BA() {
  self.var_9331 = undefined;
}

notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

func_7F9B() {
  return 3;
}

getmaxoutofboundscooldown() {
  return 3;
}

getcurrentmonitoredweaponswitchweapon() {
  validatelistener();
  var_0 = self _meth_856D();
  if(!isDefined(var_0) || var_0 == "none") {
    return undefined;
  }

  return var_0;
}

isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

isreliablyswitchingtoweapon(var_0) {
  var_1 = getcurrentmonitoredweaponswitchweapon();
  return isDefined(var_1) && var_1 == var_0 && !iscurrentweapon(var_0);
}

func_391B(var_0) {
  if(!self hasweapon(var_0)) {
    return 0;
  }

  var_1 = getcurrentmonitoredweaponswitchweapon();
  if(isDefined(var_1)) {
    var_2 = 0;
    if(var_0 == "briefcase_bomb_mp" || var_0 == "briefcase_bomb_defuse_mp" || var_0 == "iw7_uplinkball_mp" || var_0 == "iw7_tdefball_mp") {
      var_2 = 1;
    } else if(weaponinventorytype(var_1) == "primary") {
      var_2 = 1;
    }

    if(!var_2) {
      return 0;
    }
  }

  if(iscurrentweapon(var_0)) {
    return 0;
  }

  return 1;
}

func_1529(var_0) {
  func_4F5B("+++ ABORT - " + var_0);
  if(self _meth_856D() == var_0) {
    self _meth_8570(var_0);
  }

  _takeweapon(var_0);
}

_visionsetnaked(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isai(var_3)) {
      continue;
    }

    var_3 visionsetnakedforplayer(var_0, var_1);
  }
}

func_11383(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  func_4F5B(">>> BEGIN switchToWeaponReliable() - " + var_0);
  if(!func_391B(var_0)) {
    func_4F5B(">>> FAIL (early) switchToWeaponReliable() - " + var_0);
    return 0;
  }

  if(isanymonitoredweaponswitchinprogress()) {
    self _meth_8570(getcurrentmonitoredweaponswitchweapon());
  }

  self _meth_856F(var_0);
  if(istrue(var_1)) {
    _switchtoweaponimmediate(var_0);
  }

  for(;;) {
    if(iscurrentweapon(var_0)) {
      validatelistener();
      func_4F5B(">>> SUCCESS switchToWeaponReliable() - " + var_0);
      return 1;
    }

    if(!self _meth_856E(var_0) || !self hasweapon(var_0)) {
      func_4F5B(">>> FAIL switchToWeaponReliable() - " + var_0);
      return 0;
    }

    scripts\engine\utility::waitframe();
  }
}

validatelistener() {
  var_0 = self getcurrentweapon();
  if(self _meth_856E(var_0)) {
    self _meth_8570(var_0);
  }
}

forcethirdpersonwhenfollowing(var_0) {
  self endon("death");
  self endon("disconnect");
  if(!self hasweapon(var_0)) {
    return;
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  while(isanymonitoredweaponswitchinprogress()) {
    scripts\engine\utility::waitframe();
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  var_1 = undefined;
  if(isbot(self)) {
    var_1 = 1;
  }

  var_2 = func_11383(self.lastdroppableweaponobj, var_1);
  _takeweapon(var_0);
  self notify("bomb_allow_offhands");
  if(!var_2) {
    func_72ED();
  }
}

func_72ED(var_0) {
  self endon("death");
  self endon("disconnect");
  while(self getcurrentweapon() == "none") {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_1 = var_0;
    if(!isDefined(var_1) || !self hasweapon(var_1)) {
      if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj == "none") {
        break;
      }

      var_1 = self.lastdroppableweaponobj;
    }

    var_2 = getcurrentprimaryweaponsminusalt();
    if(isDefined(var_1) && getweaponbasedsmokegrenadecount(var_1) == "iw7_axe_mp" && self getweaponammoclip(var_1) == 0 && var_2.size == 1) {
      var_1 = "iw7_fists_mp";
    }

    func_11383(var_1);
    scripts\engine\utility::waitframe();
  }
}

iscurrentweapon(var_0) {
  var_1 = self getcurrentweapon();
  if(isstrstart(var_0, "alt_")) {
    var_0 = getsubstr(var_0, 4);
  }

  if(isstrstart(var_1, "alt_")) {
    var_1 = getsubstr(var_1, 4);
  }

  return var_1 == var_0;
}

func_9F72(var_0) {
  return istrue(var_0.var_9F72);
}

func_9F22(var_0) {
  if(!isDefined(var_0.var_165A)) {
    return 0;
  }

  return var_0.var_165A == "remote_c8";
}

func_9F8C(var_0) {
  var_1 = var_0 getentitynumber();
  if(!isDefined(level.supertrophy)) {
    return 0;
  }

  if(!isDefined(level.supertrophy.trophies)) {
    return 0;
  }

  if(!isDefined(level.supertrophy.trophies[var_1])) {
    return 0;
  }

  return level.supertrophy.trophies[var_1] == var_0;
}

ismicroturret(var_0) {
  var_1 = var_0 getentitynumber();
  if(!isDefined(level.microturrets)) {
    return 0;
  }

  if(!isDefined(level.microturrets[var_1])) {
    return 0;
  }

  return level.microturrets[var_1] == var_0;
}

isjackal(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  return var_0.streakinfo.streakname == "jackal";
}

isturret(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "misc_turret";
}

isdronepackage(var_0) {
  return isDefined(var_0.cratetype);
}

_enableignoreme() {
  if(!isDefined(self.ignorme_count)) {
    self.ignorme_count = 0;
  }

  if(self.ignorme_count == 0) {
    self.ignoreme = 1;
  }

  self.ignorme_count++;
}

_disableignoreme() {
  if(self.ignorme_count == 1) {
    self.ignoreme = 0;
  }

  self.ignorme_count--;
}

_resetenableignoreme() {
  self.ignorme_count = undefined;
  self.ignoreme = 0;
}

func_1254() {
  if(!isDefined(self.enabledequipdeployvfx)) {
    self.enabledequipdeployvfx = 0;
  }

  if(self.enabledequipdeployvfx == 0) {
    self getrankinfolevel(1);
  }

  self.enabledequipdeployvfx++;
}

func_11DB() {
  if(self.enabledequipdeployvfx == 1) {
    self getrankinfolevel(0);
  }

  self.enabledequipdeployvfx--;
}

func_8EC6() {
  if(!isDefined(self.var_12B1F)) {
    self.var_8EC7 = 0;
  }

  if(self.var_8EC7 == 0) {
    self setclientomnvar("ui_hide_hud", 1);
  }

  self.var_8EC7++;
}

func_8EC4() {
  if(self.var_8EC7 == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.var_8EC7--;
}

func_8ECD() {
  if(!isDefined(self.var_8ECE)) {
    self.var_8ECE = 0;
  }

  if(self.var_8ECE == 0) {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  self.var_8ECE++;
}

func_8ECC() {
  if(self.var_8ECE == 1) {
    self setclientomnvar("ui_hide_minimap", 0);
  }

  self.var_8ECE--;
}

func_4F5B(var_0) {}

iscontrollingproxyagent() {
  var_0 = 0;
  if(isDefined(self.playerproxyagent) && isalive(self.playerproxyagent)) {
    var_0 = 1;
  }

  return var_0;
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");
  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");
  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    if(isDefined(var_0) && isDefined(var_0.phys_sound_func)) {
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

func_9FAE(var_0) {
  return istrue(var_0.var_1D44);
}

istouchingboundsnullify(var_0) {
  var_1 = 0;
  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(var_3 in level.outofboundstriggerpatches) {
      if(isplayer(var_0) && var_0 istouching(var_3)) {
        if(isDefined(var_3.var_336) && var_3.var_336 == "apex_unoutofbounds") {
          break;
        }

        var_1 = 1;
        break;
      } else if(!isplayer(var_0) && var_0 istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

printgameaction(var_0, var_1) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }

  var_2 = "";
  if(isDefined(var_1)) {
    var_2 = "[" + var_1 getentitynumber() + ":" + var_1.name + "] ";
  }
}

delaysetclientomnvar(var_0, var_1, var_2) {
  self endon("disconnect");
  wait(var_0);
  self setclientomnvar(var_1, var_2);
}

isfemale() {
  return self.gender == "female";
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && level.gametype != "infect" && !isDefined(level.aonrules) || level.aonrules == 0;
}

getstreakrecordtype(var_0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

getlowestclientnum(var_0, var_1) {
  var_2 = undefined;
  foreach(var_4 in var_0) {
    if(var_4.team != "spectator" && !var_1 || isreallyalive(var_4)) {
      if(!isDefined(var_2) || var_4 getentitynumber() < var_2) {
        var_2 = var_4 getentitynumber();
      }
    }
  }

  return var_2;
}

isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

getcurrentprimaryweaponsminusalt() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(!issubstr(var_3, "alt_")) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

initarbitraryuptriggers() {
  if(isDefined(level.arbitraryuptriggers)) {
    return;
  }

  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];
  if(getmapname() == "mp_junk") {
    var_0 = getEntArray("mag_up", "targetname");
    if(!isDefined(var_0) || var_0.size == 0) {
      return;
    }

    level.arbitraryuptriggers = var_0;
    foreach(var_2 in var_0) {
      var_3 = var_2 getentitynumber();
      var_4 = spawnStruct();
      var_4.trigger = var_2;
      var_4.var_2857 = undefined;
      var_4.entsinside = [];
      if(isDefined(var_2.target)) {
        var_4.var_2857 = getent(var_2.target, "targetname");
        var_4.blinkloc = var_4.var_2857.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[var_3] = var_4;
      thread watcharbitraryuptriggerenter(var_4);
      thread watcharbitraryuptriggerexit(var_4);
    }
  }
}

watcharbitraryuptriggerenter(var_0) {
  for(;;) {
    var_0.trigger waittill("trigger", var_1);
    if(!isDefined(var_1)) {
      continue;
    }

    if(!shouldaddtoarbitraryuptrigger(var_0, var_1)) {
      continue;
    }

    var_2 = var_1 getentitynumber();
    var_0.entsinside[var_2] = var_1;
    var_1.arbitraryuptriggerstruct = var_0;
  }
}

watcharbitraryuptriggerexit(var_0) {
  for(;;) {
    foreach(var_2 in var_0.entsinside) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(!shouldremovefromarbitraryuptrigger(var_0, var_2)) {
        continue;
      }

      var_3 = var_2 getentitynumber();
      var_0.entsinside[var_3] = undefined;
      if(isDefined(var_2.arbitraryuptriggerstruct) && var_2.arbitraryuptriggerstruct == var_0) {
        var_2.arbitraryuptriggerstruct = undefined;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

shouldaddtoarbitraryuptrigger(var_0, var_1) {
  if(!isplayer(var_1)) {
    return 0;
  }

  var_2 = var_1 getentitynumber();
  if(isDefined(var_0.entsinside[var_2])) {
    return 0;
  }

  return 1;
}

shouldremovefromarbitraryuptrigger(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger)) {
    return 1;
  }

  return 0;
}

getarbitraryuptrigger() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.trigger;
}

getarbitraryuptriggerbase() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.var_2857;
}

getarbitraryuptriggerblinkloc() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.blinkloc;
}

isinarbitraryup() {
  if(isplayer(self)) {
    if(self getworldupreferenceangles() != (0, 0, 0)) {
      return 1;
    }
  }

  return 0;
}

isprojectiledamage(var_0) {
  var_1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";
  if(issubstr(var_1, var_0)) {
    return 1;
  }

  return 0;
}