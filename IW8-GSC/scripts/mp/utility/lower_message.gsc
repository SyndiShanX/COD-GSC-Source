/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\lower_message.gsc
************************************************/

function setlowermessageomnvar(var_0, var_1, var_2) {
  var_3 = getDvar("ui_gametype");

  if(var_3 != "cp_survival" && var_3 != "cp_wave_sv" && var_3 != "cp_specops") {
    self setclientomnvar("ui_lower_message", var_0);

    if(isDefined(var_1)) {
      self setclientomnvar("ui_lower_message_time", var_1);
    }

    if(isDefined(var_2)) {
      thread clearomnvarsaftertime(var_2);
      return;
    }

    return;
  }
}

function clearomnvarsaftertime(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("death_or_disconnect");
  wait var_0;
  var_1 = getDvar("ui_gametype");

  if(var_1 != "cp_survival" && var_1 != "cp_wave_sv" && var_1 != "cp_specops") {
    self setclientomnvar("ui_lower_message", 0);
    return;
  }
}

function ref_1316e(var_0, var_1, var_2) {
  setlowermessageomnvar(removeplayerasexpiredlootleader(var_0), var_1, var_2);
}

function removeplayerasexpiredlootleader(var_0) {
  var_1 = tablelookup("mp/hints.csv", 1, var_0, 0);
  return int(var_1);
}

function setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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

function clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

function clearlowermessages() {
  for(var_0 = 0; var_0 < self.lowermessages.size; var_0++) {
    self.lowermessages[var_0] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }

  updatelowermessage();
}

function sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--) {
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];
    }

    self.lowermessages[var_3 + 1] = var_1;
  }
}

function addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = undefined;

  foreach(var_12 in self.lowermessages) {
    if(var_12.name == var_0) {
      if(var_12.text == var_1 && var_12.priority == var_3) {
        return;
      }

      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_10;
  }

  var_10.name = var_0;
  var_10.text = var_1;
  var_10.time = var_2;
  var_10.addtime = gettime();
  var_10.priority = var_3;
  var_10.showtimer = var_4;
  var_10.shouldfade = var_5;
  var_10.fadetoalpha = var_6;
  var_10.fadetoalphatime = var_7;
  var_10.hidewhenindemo = var_8;
  var_10.hidewheninmenu = var_9;
  sortlowermessages();
}

function removelowermessage(var_0) {
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
    return;
  }
}

function getlowermessage() {
  if(!isDefined(self.lowermessages)) {
    return undefined;
  }

  return self.lowermessages[0];
}

function updatelowermessage() {
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
    self.lowermessage.alpha = var_0.fadetoalpha;
  }

  if(var_0.time > 0 && var_0.showtimer) {
    self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
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

function clearondeath(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

function clearafterfade(var_0) {
  wait var_0.time;
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}