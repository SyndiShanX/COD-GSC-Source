/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\lower_message.gsc
************************************************/

setlowermessageomnvar(ref, timer, _id_C84F97ACAD5B2088) {
  _id_B2FF82EC901486E4 = getDvar("ui_gametype");

  if(_id_B2FF82EC901486E4 != "cp_survival" && _id_B2FF82EC901486E4 != "cp_wave_sv" && _id_B2FF82EC901486E4 != "cp_specops") {
    _id_D861F893072A477E = game["lowerMessageIndex"][ref];

    if(!isDefined(_id_D861F893072A477E)) {
      return;
    }
    self setclientomnvar("ui_lower_message", _id_D861F893072A477E);

    if(isDefined(timer))
      self setclientomnvar("ui_lower_message_time", timer);

    if(isDefined(_id_C84F97ACAD5B2088))
      thread clearomnvarsaftertime(_id_C84F97ACAD5B2088);
  }
}

clearomnvarsaftertime(_id_C84F97ACAD5B2088) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("death_or_disconnect");
  wait(_id_C84F97ACAD5B2088);
  _id_B2FF82EC901486E4 = getDvar("ui_gametype");

  if(_id_B2FF82EC901486E4 != "cp_survival" && _id_B2FF82EC901486E4 != "cp_wave_sv" && _id_B2FF82EC901486E4 != "cp_specops")
    self setclientomnvar("ui_lower_message", 0);
}

_id_05A98C45A6252B4A() {
  game["lowerMessageIndex"] = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/hints.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    _id_C71A87C9229A2E91 = int(tablelookupbyrow("mp/hints.csv", index, 0));
    _id_9C3353F4C1204BFE = tablelookupbyrow("mp/hints.csv", index, 1);

    if(_id_9C3353F4C1204BFE == "") {
      continue;
    }
    game["lowerMessageIndex"][_id_9C3353F4C1204BFE] = _id_C71A87C9229A2E91;
  }
}

setlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  if(!isDefined(priority))
    priority = 1;

  if(!isDefined(time))
    time = 0;

  if(!isDefined(showtimer))
    showtimer = 0;

  if(!isDefined(shouldfade))
    shouldfade = 0;

  if(!isDefined(fadetoalpha))
    fadetoalpha = 0.85;

  if(!isDefined(fadetoalphatime))
    fadetoalphatime = 3.0;

  if(!isDefined(hidewhenindemo))
    hidewhenindemo = 0;

  if(!isDefined(hidewheninmenu))
    hidewheninmenu = 1;

  addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu);
  updatelowermessage();
}

clearlowermessage(name) {
  removelowermessage(name);
  updatelowermessage();
}

clearlowermessages() {
  if(!isDefined(self) || !isDefined(self.lowermessage) || !isDefined(self.lowermessages)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.lowermessages.size; _id_AC0E594AC96AA3A8++)
    self.lowermessages[_id_AC0E594AC96AA3A8] = undefined;

  updatelowermessage();
}

sortlowermessages() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self.lowermessages.size; _id_AC0E594AC96AA3A8++) {
    message = self.lowermessages[_id_AC0E594AC96AA3A8];
    priority = message.priority;

    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && priority > self.lowermessages[_id_AC0E5C4AC96AAA41].priority; _id_AC0E5C4AC96AAA41--)
      self.lowermessages[_id_AC0E5C4AC96AAA41 + 1] = self.lowermessages[_id_AC0E5C4AC96AAA41];

    self.lowermessages[_id_AC0E5C4AC96AAA41 + 1] = message;
  }
}

addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  _id_28B0F661494FA67C = undefined;

  foreach(message in self.lowermessages) {
    if(message.name == name) {
      if(message.text == text && message.priority == priority) {
        return;
      }
      _id_28B0F661494FA67C = message;
      break;
    }
  }

  if(!isDefined(_id_28B0F661494FA67C)) {
    _id_28B0F661494FA67C = spawnStruct();
    self.lowermessages[self.lowermessages.size] = _id_28B0F661494FA67C;
  }

  _id_28B0F661494FA67C.name = name;
  _id_28B0F661494FA67C.text = text;
  _id_28B0F661494FA67C.time = time;
  _id_28B0F661494FA67C.addtime = gettime();
  _id_28B0F661494FA67C.priority = priority;
  _id_28B0F661494FA67C.showtimer = showtimer;
  _id_28B0F661494FA67C.shouldfade = shouldfade;
  _id_28B0F661494FA67C.fadetoalpha = fadetoalpha;
  _id_28B0F661494FA67C.fadetoalphatime = fadetoalphatime;
  _id_28B0F661494FA67C.hidewhenindemo = hidewhenindemo;
  _id_28B0F661494FA67C.hidewheninmenu = hidewheninmenu;
  sortlowermessages();
}

removelowermessage(name) {
  if(isDefined(self.lowermessages)) {
    for(_id_AC0E594AC96AA3A8 = self.lowermessages.size; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
      if(self.lowermessages[_id_AC0E594AC96AA3A8 - 1].name != name) {
        continue;
      }
      message = self.lowermessages[_id_AC0E594AC96AA3A8 - 1];

      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41 < self.lowermessages.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(self.lowermessages[_id_AC0E5C4AC96AAA41]))
          self.lowermessages[_id_AC0E5C4AC96AAA41 - 1] = self.lowermessages[_id_AC0E5C4AC96AAA41];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages))
    return undefined;

  return self.lowermessages[0];
}

updatelowermessage() {
  if(!isDefined(self)) {
    return;
  }
  message = getlowermessage();

  if(!isDefined(message)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage settext(message.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = message.hidewhenindemo;
    self.lowermessage.hidewheninmenu = message.hidewheninmenu;

    if(message.shouldfade) {
      self.lowermessage fadeovertime(min(message.fadetoalphatime, 60));
      self.lowermessage.alpha = message.fadetoalpha;
    }

    if(message.time > 0 && message.showtimer)
      self.lowertimer settimer(max(message.time - (gettime() - message.addtime) / 1000, 0.1));
    else {
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
  }
}

clearondeath(message) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(message.name);
}

clearafterfade(message) {
  wait(message.time);
  clearlowermessage(message.name);
  self notify("message_cleared");
}