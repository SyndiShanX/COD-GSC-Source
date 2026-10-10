/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\mp\utility\lower_message.gsc
***************************************************/

#namespace lower_message;

function setlowermessageomnvar(ref, timer, var_c84f97acad5b2088) {
  gamemode = getDvar(@ "ui_gametype");

  if(gamemode != "cp_survival" && gamemode != "cp_wave_sv" && gamemode != "cp_specops") {
    omnvarindex = game["lowerMessageIndex"][ref];

    if(!isDefined(omnvarindex)) {
      assertmsg("setLowerMessageOmnvar() called with unknown ref: " + ref);
      return;
    }

    self setclientomnvar("ui_lower_message", omnvarindex);

    if(isDefined(timer)) {
      self setclientomnvar("ui_lower_message_time", timer);
    }

    if(isDefined(var_c84f97acad5b2088)) {
      thread clearomnvarsaftertime(var_c84f97acad5b2088);
    }
  }
}

function clearomnvarsaftertime(var_c84f97acad5b2088) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("death_or_disconnect");
  wait var_c84f97acad5b2088;
  gamemode = getDvar(@ "ui_gametype");

  if(gamemode != "cp_survival" && gamemode != "cp_wave_sv" && gamemode != "cp_specops") {
    self setclientomnvar("ui_lower_message", 0);
  }
}

function function_5a98c45a6252b4a() {
  game["lowerMessageIndex"] = [];
  numrows = tablelookupgetnumrows("mp/hints.csv");

  for(index = 0; index < numrows; index++) {
    var_c71a87c9229a2e91 = int(tablelookupbyrow("mp/hints.csv", index, 0));
    indexstr = tablelookupbyrow("mp/hints.csv", index, 1);

    if(indexstr == "") {
      continue;
    }

    assertex(!isDefined(game["lowerMessageIndex"][indexstr]), indexstr + " is already defined in game[ lowerMessageIndex ]");
    game["lowerMessageIndex"][indexstr] = var_c71a87c9229a2e91;
  }
}

function setlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  if(!isDefined(priority)) {
    priority = 1;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  if(!isDefined(showtimer)) {
    showtimer = 0;
  }

  if(!isDefined(shouldfade)) {
    shouldfade = 0;
  }

  if(!isDefined(fadetoalpha)) {
    fadetoalpha = 0.85;
  }

  if(!isDefined(fadetoalphatime)) {
    fadetoalphatime = 3;
  }

  if(!isDefined(hidewhenindemo)) {
    hidewhenindemo = 0;
  }

  if(!isDefined(hidewheninmenu)) {
    hidewheninmenu = 1;
  }

  addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu);
  updatelowermessage();
}

function clearlowermessage(name) {
  removelowermessage(name);
  updatelowermessage();
}

function clearlowermessages() {
  if(!isDefined(self) || !isDefined(self.lowermessage) || !isDefined(self.lowermessages)) {
    return;
  }

  for(i = 0; i < self.lowermessages.size; i++) {
    self.lowermessages[i] = undefined;
  }

  updatelowermessage();
}

function sortlowermessages() {
  for(i = 1; i < self.lowermessages.size; i++) {
    message = self.lowermessages[i];
    priority = message.priority;

    for(j = i - 1; j >= 0 && priority > self.lowermessages[j].priority; j--) {
      self.lowermessages[j + 1] = self.lowermessages[j];
    }

    self.lowermessages[j + 1] = message;
  }
}

function addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  newmessage = undefined;

  foreach(message in self.lowermessages) {
    if(message.name == name) {
      if(message.text == text && message.priority == priority) {
        return;
      }

      newmessage = message;
      break;
    }
  }

  if(!isDefined(newmessage)) {
    newmessage = spawnStruct();
    self.lowermessages[self.lowermessages.size] = newmessage;
  }

  newmessage.name = name;
  newmessage.text = text;
  newmessage.time = time;
  newmessage.addtime = gettime();
  newmessage.priority = priority;
  newmessage.showtimer = showtimer;
  newmessage.shouldfade = shouldfade;
  newmessage.fadetoalpha = fadetoalpha;
  newmessage.fadetoalphatime = fadetoalphatime;
  newmessage.hidewhenindemo = hidewhenindemo;
  newmessage.hidewheninmenu = hidewheninmenu;
  sortlowermessages();
}

function removelowermessage(name) {
  if(isDefined(self.lowermessages)) {
    for(i = self.lowermessages.size; i > 0; i--) {
      if(self.lowermessages[i - 1].name != name) {
        continue;
      }

      message = self.lowermessages[i - 1];

      for(j = i; j < self.lowermessages.size; j++) {
        if(isDefined(self.lowermessages[j])) {
          self.lowermessages[j - 1] = self.lowermessages[j];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
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

  message = getlowermessage();

  if(!isDefined(message)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }

    return;
  }

  self.lowermessage settext(message.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = message.hidewhenindemo;
  self.lowermessage.hidewheninmenu = message.hidewheninmenu;

  if(message.shouldfade) {
    self.lowermessage fadeovertime(min(message.fadetoalphatime, 60));
    self.lowermessage.alpha = message.fadetoalpha;
  }

  if(message.time > 0 && message.showtimer) {
    self.lowertimer settimer(max(message.time - (gettime() - message.addtime) / 1000, 0.1));
    return;
  }

  if(message.time > 0 && !message.showtimer) {
    self.lowertimer settext("");
    self.lowermessage fadeovertime(min(message.time, 60));
    self.lowermessage.alpha = 0;
    thread clearondeath(message);
    thread clearafterfade(message);
    return;
  }

  self.lowertimer settext("");
}

function clearondeath(message) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(message.name);
}

function clearafterfade(message) {
  wait message.time;
  clearlowermessage(message.name);
  self notify("message_cleared");
}