/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\lower_message.gsc
***********************************************/

setlowermessageomnvar(var_0, var_1, var_2) {
  var_3 = getDvar("_encstr_ADE50BEB2F7C519F9918E82B68");

  if(var_3 != "_encstr_839E0CBFD1801B5DB0D34C932998" && var_3 != "_encstr_B6570B78A33FB39B3317E886AB" && var_3 != "_encstr_8B6B0B26FA20C3E85FFAA84F0B") {
    self setclientomnvar("_encstr_AA9611BA96D7637BBB9527F5DAAC9BE60BD956", var_0);

    if(isDefined(var_1))
      self setclientomnvar("_encstr_B26816E3E336F9986F25C57F93811FDE617831519BF81815", var_1);

    if(isDefined(var_2))
      thread clearomnvarsaftertime(var_2);
  }
}

clearomnvarsaftertime(var_0) {
  self notify("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait(var_0);
  var_1 = getDvar("_encstr_ADE50BEB2F7C519F9918E82B68");

  if(var_1 != "_encstr_839E0CBFD1801B5DB0D34C932998" && var_1 != "_encstr_B6570B78A33FB39B3317E886AB" && var_1 != "_encstr_8B6B0B26FA20C3E85FFAA84F0B")
    self setclientomnvar("_encstr_AA9611BA96D7637BBB9527F5DAAC9BE60BD956", 0);
}

_id_1316E(var_0, var_1, var_2) {
  setlowermessageomnvar(removeplayerasexpiredlootleader(var_0), var_1, var_2);
}

removeplayerasexpiredlootleader(var_0) {
  var_1 = tablelookup("_encstr_8FAA0DCD482F74D016A34A0A07B6DE", 1, var_0, 0);
  return int(var_1);
}

setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 0.85;

  if(!isDefined(var_7))
    var_7 = 3.0;

  if(!isDefined(var_8))
    var_8 = 0;

  if(!isDefined(var_9))
    var_9 = 1;

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  updatelowermessage();
}

clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

clearlowermessages() {
  for(var_0 = 0; var_0 < self.lowermessages.size; var_0++)
    self.lowermessages[var_0] = undefined;

  if(!isDefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--)
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];

    self.lowermessages[var_3 + 1] = var_1;
  }
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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

removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self.lowermessages[var_1 - 1];

      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3]))
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
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
  var_0 = getlowermessage();

  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage settext(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
    self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0.shouldfade) {
      self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
      self.lowermessage.alpha = var_0.fadetoalpha;
    }

    if(var_0.time > 0 && var_0.showtimer)
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    else {
      if(var_0.time > 0 && !var_0.showtimer) {
        self.lowertimer settext("_encstr_B40101");
        self.lowermessage fadeovertime(min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(var_0);
        thread clearafterfade(var_0);
        return;
      }

      self.lowertimer settext("_encstr_B40101");
    }
  }
}

clearondeath(var_0) {
  self notify("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  clearlowermessage(var_0.name);
}

clearafterfade(var_0) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
}