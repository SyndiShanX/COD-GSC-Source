/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\lower_message.gsc
************************************************/

function setlowermessageomnvar(var0, var1, var2) {
  var3 = getDvar("MOLPOSLOMO");

  if(var3 != "cp_survival" && var3 != "cp_wave_sv" && var3 != "cp_specops") {
    self setclientomnvar("ui_lower_message", var0);

    if(isDefined(var1)) {
      self setclientomnvar("ui_lower_message_time", var1);
    }

    if(isDefined(var2)) {
      thread clearomnvarsaftertime(var2);
      return;
    }

    return;
  }
}

function clearomnvarsaftertime(var0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("death_or_disconnect");
  wait var0;
  var1 = getDvar("MOLPOSLOMO");

  if(var1 != "cp_survival" && var1 != "cp_wave_sv" && var1 != "cp_specops") {
    self setclientomnvar("ui_lower_message", 0);
    return;
  }
}

function ref_1316e(var0, var1, var2) {
  setlowermessageomnvar(removeplayerasexpiredlootleader(var0), var1, var2);
}

function removeplayerasexpiredlootleader(var0) {
  var1 = tablelookup("mp/hints.csv", 1, var0, 0);
  return int(var1);
}

function setlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var6)) {
    var6 = 0.85;
  }

  if(!isDefined(var7)) {
    var7 = 3;
  }

  if(!isDefined(var8)) {
    var8 = 0;
  }

  if(!isDefined(var9)) {
    var9 = 1;
  }

  addlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  updatelowermessage();
}

function clearlowermessage(var0) {
  removelowermessage(var0);
  updatelowermessage();
}

function clearlowermessages() {
  for(var0 = 0; var0 < self.lowermessages.size; var0++) {
    self.lowermessages[var0] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }

  updatelowermessage();
}

function sortlowermessages() {
  for(var0 = 1; var0 < self.lowermessages.size; var0++) {
    var1 = self.lowermessages[var0];
    var2 = var1.priority;

    for(var3 = var0 - 1; var3 >= 0 && var2 > self.lowermessages[var3].priority; var3--) {
      self.lowermessages[var3 + 1] = self.lowermessages[var3];
    }

    self.lowermessages[var3 + 1] = var1;
  }
}

function addlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = undefined;

  foreach(var12 in self.lowermessages) {
    if(var12.name == var0) {
      if(var12.text == var1 && var12.priority == var3) {
        return;
      }

      var10 = var12;
      break;
    }
  }

  if(!isDefined(var10)) {
    var10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var10;
  }

  var10.name = var0;
  var10.text = var1;
  var10.time = var2;
  var10.addtime = gettime();
  var10.priority = var3;
  var10.showtimer = var4;
  var10.shouldfade = var5;
  var10.fadetoalpha = var6;
  var10.fadetoalphatime = var7;
  var10.hidewhenindemo = var8;
  var10.hidewheninmenu = var9;
  sortlowermessages();
}

function removelowermessage(var0) {
  if(isDefined(self.lowermessages)) {
    for(var1 = self.lowermessages.size; var1 > 0; var1--) {
      if(self.lowermessages[var1 - 1].name != var0) {
        continue;
      }

      var2 = self.lowermessages[var1 - 1];

      for(var3 = var1; var3 < self.lowermessages.size; var3++) {
        if(isDefined(self.lowermessages[var3])) {
          self.lowermessages[var3 - 1] = self.lowermessages[var3];
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

  var0 = getlowermessage();

  if(!isDefined(var0)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }

    return;
  }

  self.lowermessage settext(var0.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = var0.hidewhenindemo;
  self.lowermessage.hidewheninmenu = var0.hidewheninmenu;

  if(var0.shouldfade) {
    self.lowermessage fadeovertime(min(var0.fadetoalphatime, 60));
    self.lowermessage.alpha = var0.fadetoalpha;
  }

  if(var0.time > 0 && var0.showtimer) {
    self.lowertimer settimer(max(var0.time - (gettime() - var0.addtime) / 1000, 0.1));
    return;
  }

  if(var0.time > 0 && !var0.showtimer) {
    self.lowertimer settext("");
    self.lowermessage fadeovertime(min(var0.time, 60));
    self.lowermessage.alpha = 0;
    thread clearondeath(var0);
    thread clearafterfade(var0);
    return;
  }

  self.lowertimer settext("");
}

function clearondeath(var0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var0.name);
}

function clearafterfade(var0) {
  wait var0.time;
  clearlowermessage(var0.name);
  self notify("message_cleared");
}