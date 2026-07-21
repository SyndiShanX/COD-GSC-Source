/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\perkfunctions.gsc
***********************************************/

setbountyhunter() {}

unsetbountyhunter() {}

sethealer() {
  thread radialhealer();
}

radialhealer() {
  self endon("_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!level.teambased) {
    return;
  }
  self.teammateswithhealperk = [];

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 350, self.team, self);

      foreach(var_2 in var_0) {
        if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_BEF4111A80D95E49B0A1D040E6103721326D73")) {
          continue;
        }
        if(self.team == var_2.team && var_2 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_2.healer)) {
          var_3 = var_2 getentitynumber();

          if(self.teammateswithhealperk.size == 0)
            scripts\mp\hud_message::showmiscmessage("_encstr_8E5D1034CA2C63A5733BFAE01B0B5EB2E437");

          var_2.healer = self;
          self.teammateswithhealperk[var_3] = 1;
          var_2 scripts\mp\utility\perk::giveperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
          var_2 scripts\mp\utility\perk::giveperk("_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702");
          var_2 scripts\mp\hud_message::showmiscmessage("_encstr_91C311B8122129518764BB2047577B83D52A40");
          givehealedoverlay(var_2);
          thread healerperkteammatewatcher(var_2);
          thread healerperkteammatedestructor(var_2);
        }
      }
    }

    wait 0.3;
  }
}

healerperkteammatewatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_1 = 400;

    if(distancesquared(self.origin, var_0.origin) > var_1 * var_1 || var_0.team != self.team) {
      var_0 notify("_encstr_BEA81518507397D826B8AB0FE770BC3E9F117EE0763835");
      return;
    }

    var_2 = var_0 getentitynumber();

    if(var_0.health < var_0.maxhealth && var_0.healedoverlay.alpha == var_0.healedoverlay.lowalpha)
      var_0 thread healedoverlayfade(var_0.healedoverlay, self, var_0.healedoverlay.highalpha);
    else if(var_0.health == var_0.maxhealth)
      var_0 thread healedoverlayfade(var_0.healedoverlay, self, var_0.healedoverlay.lowalpha);

    wait 0.1;
  }
}

healerperkteammatedestructor(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 getentitynumber();
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76", self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", var_0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", var_0, "_encstr_BEA81518507397D826B8AB0FE770BC3E9F117EE0763835");

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\perk::removeperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
    var_0 scripts\mp\utility\perk::removeperk("_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702");
    var_0.healer = undefined;
    var_0 scripts\mp\hud_message::showmiscmessage("_encstr_BEA81518507397D826B8AB0FE770BC3E9F117EE0763835");
  }

  if(isDefined(self)) {
    self.teammateswithhealperk[var_1] = undefined;

    if(self.teammateswithhealperk.size == 0)
      scripts\mp\hud_message::showmiscmessage("_encstr_9711135D3F71B3A0F18DB06877E740F9CA0F33EDD7");
  }
}

unsethealer() {
  self notify("_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76");
}

givehealedoverlay(var_0) {
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("_encstr_A2730F7B3B594EB12C5EF53459B01B2BE4", 640, 480);
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.aligny = "_encstr_AC190479FF92";
  var_1.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.alpha = 0;
  var_1.lowalpha = 0;
  var_1.highalpha = 0.75;
  var_0.healedoverlay = var_1;
  var_0 thread healedoverlayfade(var_1, self, var_1.lowalpha);
  var_0 thread healedoverlaydestructor(var_1, self);
}

healedoverlayfade(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BEA81518507397D826B8AB0FE770BC3E9F117EE0763835");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76");
  var_0 fadeovertime(0.5);
  var_0.alpha = var_2;
}

healedoverlaydestructor(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents(level, "_encstr_9B1D0BC7932875276230426AA1", var_1, "_encstr_AC1D0D7BFE52A0BDFFFAD941A2CF76", var_1, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_BEA81518507397D826B8AB0FE770BC3E9F117EE0763835");

  if(isDefined(var_0)) {
    var_0 fadeovertime(1);
    var_0.alpha = 0;
    wait 1;
    var_0 destroy();
  }
}

settank() {}

unsettank() {}

setsurvivor() {}

unsetsurvivor() {}

setstealth() {}

unsetstealth() {}

setbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

unsetbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 0);
}

setsupport() {}

unsetsupport() {}

setdemolitions() {}

unsetdemolitions() {}

setintel() {}

unsetintel() {}

sethunter() {}

unsethunter() {}

setspotter() {}

unsetspotter() {}

setmunitions() {}

unsetmunitions() {}

setoffhandprovider() {
  thread offhandproviderthread();
}

offhandproviderthread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8EB917CBA07FCAD44ED02B2380E1B6A24FC792C51493120D33");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 144, self.team, self);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.ohpequipmentrefills))
        var_2.ohpequipmentrefills = [];

      if(var_2 equipmentusedbyslot("_encstr_BA7F0830B3A7859B60B0") == 0 && var_2 equipmentusedbyslot("_encstr_AC8F0AE74163F85AAA380AD8") == 0) {
        continue;
      }
      if(!isDefined(var_2.ohpequipmentrefills[self getentitynumber()]) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_2.ohpequipmentrefills[self getentitynumber()] = 1;
        var_3 = var_2 refillequipment();

        for(var_4 = 0; var_4 < var_3["_encstr_BA7F0830B3A7859B60B0"]; var_4++)
          var_2 thread ohpequipmentfillednotification(self.name, var_2 scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0"));

        for(var_4 = 0; var_4 < var_3["_encstr_AC8F0AE74163F85AAA380AD8"]; var_4++)
          var_2 thread ohpequipmentfillednotification(self.name, var_2 scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8"));

        thread ohpallowuseonplayerdeath(var_2);
        var_2 playsoundtoplayer("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B", var_2);
      }
    }

    wait 0.1;
  }
}

ohpallowuseonplayerdeath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = self getentitynumber();
  scripts\engine\utility::waittill_any_ents_return(self, "_encstr_8D820B49520F0EC02DDE6367EC", var_0, "_encstr_AD75063D571AE108");
  var_0.ohpequipmentrefills[var_1] = undefined;
}

unsetoffhandprovider() {
  self notify("_encstr_8EB917CBA07FCAD44ED02B2380E1B6A24FC792C51493120D33");
}

refillequipment() {
  var_0 = [];
  var_0["_encstr_BA7F0830B3A7859B60B0"] = equipmentusedbyslot("_encstr_BA7F0830B3A7859B60B0", 1);
  var_0["_encstr_AC8F0AE74163F85AAA380AD8"] = equipmentusedbyslot("_encstr_AC8F0AE74163F85AAA380AD8", 1);
  return var_0;
}

equipmentusedbyslot(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = scripts\mp\equipment::getcurrentequipment(var_0);
  var_3 = getequipmentstartammo(var_0);
  var_4 = scripts\mp\equipment::getequipmentammo(var_2);

  if(var_1 && var_3 - var_4 > 0)
    scripts\mp\equipment::incrementequipmentammo(var_2, var_3 - var_4);

  return var_3 - var_4;
}

getequipmentstartammo(var_0) {
  var_1 = scripts\mp\equipment::getcurrentequipment(var_0);
  var_2 = scripts\mp\equipment::getequipmentstartammo(var_1);

  if(var_0 == "_encstr_BA7F0830B3A7859B60B0" && scripts\mp\utility\perk::_hasperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953"))
    var_2 = scripts\mp\equipment::getequipmentmaxammo(var_1);

  return var_2;
}

ohpequipmentfillednotification(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(self.munitionsnotifications))
    self.munitionsnotifications = [];

  var_2 = self.munitionsnotifications.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 < 2) {
      thread movenotificationup(self.munitionsnotifications[var_3]);
      continue;
    }

    var_4 = self.munitionsnotifications[var_3];
    self.munitionsnotifications[var_3] = undefined;
    var_4 notify("_encstr_A3C31146ACB1564795EBB4D8DE9BD7AC8DB2AD");
  }

  var_5 = 620;
  var_6 = 360;
  var_7 = 352.0;
  var_8 = 264.0;
  var_9 = newclienthudelem(self);
  var_9.x = var_7;
  var_9.y = var_8;
  var_9.alignx = "_encstr_8253060E2B5FE330";
  var_9.aligny = "_encstr_AC190479FF92";
  var_9.sort = 2;
  var_9.alpha = 0;
  var_10 = scripts\mp\equipment::getequipmenttableinfo(var_1);
  var_9 setshader(var_10.image, 25, 25);
  var_9 fadeovertime(0.15);
  var_9 moveovertime(0.35);
  var_9.alpha = 1;
  var_9.x = var_5;
  var_9.y = var_6;
  self.munitionsnotifications = scripts\engine\utility::array_insert(self.munitionsnotifications, var_9, 0);
  var_9 endon("_encstr_A3C31146ACB1564795EBB4D8DE9BD7AC8DB2AD");
  thread ohpcleanupnotificationondeath(var_9);
  var_9.isanimating = 1;
  wait 0.35;
  var_9.isanimating = 0;
  wait 3;
  var_9 fadeovertime(0.5);
  var_9.alpha = 0;
  wait 0.5;
  var_9 notify("_encstr_A3C31146ACB1564795EBB4D8DE9BD7AC8DB2AD");
}

ohpcleanupnotificationondeath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", var_0, "_encstr_A3C31146ACB1564795EBB4D8DE9BD7AC8DB2AD");

  if(isDefined(self))
    self.munitionsnotifications = scripts\engine\utility::array_remove(self.munitionsnotifications, var_0);

  var_0 destroy();
}

movenotificationup(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A3C31146ACB1564795EBB4D8DE9BD7AC8DB2AD");

  if(!istrue(var_0.isanimating))
    var_0 moveovertime(0.35);

  var_0.y = var_0.y - 25;
  wait 0.35;
}

_id_131B3() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A31E0CE75D34C2C817EBD5677AC3");
  self notify("_encstr_BAE20F6E561D5C57A51BB6BECDE82C3947");
  self endon("_encstr_BAE20F6E561D5C57A51BB6BECDE82C3947");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AF("_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B", "_encstr_A7850BCD1CC996E647FA2B3732", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_AD75063D571AE108");
    thread set_train_stopped(var_0);
  }
}

_id_13F6A() {
  self notify("_encstr_A31E0CE75D34C2C817EBD5677AC3");
  self setmovespeedscale(1);
}

set_train_stopped(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(var_0 == "_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B") {
    if(self.lastweaponobj hasattachment("_encstr_BDE70E71CB23AFB812E33F9B053C40FA"))
      self setmovespeedscale(1.04);
  } else if(var_0 == "_encstr_A7850BCD1CC996E647FA2B3732" || var_0 == "_encstr_AD75063D571AE108")
    self setmovespeedscale(1);
  else if(var_0 == "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D") {
    waitframe();

    if(!self.lastweaponobj hasattachment("_encstr_BDE70E71CB23AFB812E33F9B053C40FA"))
      self setmovespeedscale(1);
    else
      self setmovespeedscale(1.04);
  }
}

setoverkillpro() {}

unsetoverkillpro() {}

setempimmune() {}

unsetempimmune() {}

setautospot() {
  if(!isPlayer(self)) {
    return;
  }
  autospotadswatcher();
  autospotdeathwatcher();
}

autospotdeathwatcher() {
  self waittill("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3C7160A906D673BC8AF2BF05730CE3B0E2FC2A399338FB2");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self autospotoverlayoff();
}

unsetautospot() {
  if(!isPlayer(self)) {
    return;
  }
  self notify("_encstr_A3C7160A906D673BC8AF2BF05730CE3B0E2FC2A399338FB2");
  self autospotoverlayoff();
}

autospotadswatcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A3C7160A906D673BC8AF2BF05730CE3B0E2FC2A399338FB2");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  for(;;) {
    waitframe();

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    var_1 = self playerads();

    if(var_1 < 1 && var_0) {
      var_0 = 0;
      self autospotoverlayoff();
    }

    if(var_1 < 1 && !var_0) {
      continue;
    }
    if(var_1 == 1 && !var_0) {
      var_0 = 1;
      self autospotoverlayon();
    }
  }
}

setregenfaster() {}

unsetregenfaster() {}

timeoutregenfaster() {
  self.hasregenfaster = undefined;
  scripts\mp\utility\perk::removeperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
  self setclientdvar("_encstr_81FC21337F29E6C88FB738169F71801D628BEFABCBC238C0A9CD6028C25D48D86A3B2F", 0);
  self notify("_encstr_B49013B3AA8F8549735C85D3775F88CC67E34B1983");
}

sethardshell() {
  self.shellshockreduction = 0.25;
}

unsethardshell() {
  self.shellshockreduction = 0;
}

setsharpfocus() {
  thread monitorsharpfocus();
}

monitorsharpfocus() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_97CD1793A37F82E73838E6E94D80AB8299300B1B39273E07D3");

  for(;;) {
    updatesharpfocus();
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

updatesharpfocus() {
  var_0 = self.currentweapon;
  var_1 = undefined;
  var_2 = scripts\mp\utility\weapon::_id_14584(var_0);

  if(var_2 == 5)
    var_1 = 0.7;
  else if(var_2 == 4)
    var_1 = 0.1;
  else if(var_2 == 2)
    var_1 = 0.05;
  else if(var_2 == 3)
    var_1 = 0.05;
  else if(var_2 == 1)
    var_1 = 0.25;
  else
    var_1 = 0.05;

  scripts\mp\weapons::updateviewkickscale(var_1);
}

unsetsharpfocus() {
  self notify("_encstr_97CD1793A37F82E73838E6E94D80AB8299300B1B39273E07D3");
  scripts\mp\weapons::updateviewkickscale(1.0);
}

updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }
  var_0 = undefined;
  var_1 = scripts\mp\utility\weapon::_id_14584(self.currentweapon);

  if(var_1 == 5)
    var_0 = 0.7;
  else if(var_1 == 4)
    var_0 = 0.1;
  else if(var_1 == 2) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
      var_0 = getdvarfloat("_encstr_AD111A77F3127131075B1803B2DF78B9AF44CBD59BFC480E2F52512B", 0.05);
    else
      var_0 = 0.05;
  } else if(var_1 == 3)
    var_0 = 0.05;
  else if(var_1 == 1)
    var_0 = 0.25;
  else if(var_1 == 6)
    var_0 = getdvarfloat("_encstr_AD111A77F3127131075B1803B2DF78B9AF44CBD59BFC480E2F52512B", 0.05);
  else
    var_0 = 0.05;

  scripts\mp\weapons::updateviewkickscale(var_0);
}

_id_13121() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\mp\utility\perk::giveperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
  wait(getdvarfloat("_encstr_BA71213318E529675BD89885EEA0BFEE6F10DBEAF08B5B97F030AFBC05EB0F738348F2", 5.0));
  scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_131D0() {
  thread _id_11CFC();
}

_id_11CFC() {
  self endon("_encstr_88411198AAE791CB37376EEB180FD3554AF210");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notifyonplayercommand("_encstr_A5EB0F1BCCFFD8A5D2636359BFAA637095", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_A5EB0F1BCCFFD8A5D2636359BFAA637095", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommand("_encstr_A6FB12E3E12F120BD9FA701F3E13C5B2B50B8E5F", "_encstr_BA1E086D0980540AA6C7");
  self notifyonplayercommand("_encstr_A6FB12E3E12F120BD9FA701F3E13C5B2B50B8E5F", "_encstr_91D51A92AF43EBF70B1F50F64AEBCB1D2F882629A6EA1242B37D60C8");

  for(;;) {
    self waittill("_encstr_A5EB0F1BCCFFD8A5D2636359BFAA637095");

    if(self.currentweapon hasattachment("_encstr_866E12F8432D87031BF7790D314C312DB4066021")) {
      if(!scripts\mp\utility\perk::_hasperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583"))
        scripts\mp\utility\perk::giveperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583");
      else
        self notify("_encstr_979713CC6B80A413748342DB0E5E479DB0F35E359B");

      self waittill("_encstr_A6FB12E3E12F120BD9FA701F3E13C5B2B50B8E5F");
      thread lobby_patrol_enemy_watcher();
    }
  }
}

lobby_patrol_enemy_watcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_979713CC6B80A413748342DB0E5E479DB0F35E359B");
  wait 0.2;

  if(self hasperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583"))
    scripts\mp\utility\perk::removeperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583");
}

_id_13F70() {
  self notify("_encstr_88411198AAE791CB37376EEB180FD3554AF210");
  self notifyonplayercommandremove("_encstr_A5EB0F1BCCFFD8A5D2636359BFAA637095", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_A5EB0F1BCCFFD8A5D2636359BFAA637095", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommandremove("_encstr_A6FB12E3E12F120BD9FA701F3E13C5B2B50B8E5F", "_encstr_BA1E086D0980540AA6C7");
  self notifyonplayercommandremove("_encstr_A6FB12E3E12F120BD9FA701F3E13C5B2B50B8E5F", "_encstr_91D51A92AF43EBF70B1F50F64AEBCB1D2F882629A6EA1242B37D60C8");

  if(self hasperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583"))
    scripts\mp\utility\perk::removeperk("_encstr_B8DE14B91C95D8961636D1F2D7D196B334473BE4A583");
}

_id_131B4() {
  thread _id_11D1A();
}

_id_11D1A() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A72E11B8D5966CB5376CB783597D5DCDE6951D");

  for(;;) {
    if(self.currentweapon hasattachment("_encstr_A91E13B857EE73B353B4C8E70BDA87585B9770787F") && self playerads() == 1) {
      thread _id_131B5();

      while(self playerads() == 1)
        waitframe();

      if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
        scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
    }

    waitframe();
  }
}

_id_131B5() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_AC201AEB9BA1D07AE3573F096709B708437373618609792EEB473D19");
  self endon("_encstr_AC201AEB9BA1D07AE3573F096709B708437373618609792EEB473D19");
  self endon("_encstr_A72E11B8D5966CB5376CB783597D5DCDE6951D");

  if(!scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::giveperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");

  wait 1.0;

  if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13F6B() {
  self notify("_encstr_A72E11B8D5966CB5376CB783597D5DCDE6951D");

  if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13159() {
  thread _id_11D08();
}

_id_11D08() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_875E107862BB5DF0BE0FB99B1763409E8F4B");

  for(;;) {
    if(self playerads() == 1) {
      thread _id_1315A();

      while(self playerads() == 1)
        waitframe();

      self notify("_encstr_8B7711386E4A188672F7B1931F5AC7F0F3C720");

      if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
        scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
    }

    waitframe();
  }
}

_id_1315A() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8B7711386E4A188672F7B1931F5AC7F0F3C720");
  self endon("_encstr_875E107862BB5DF0BE0FB99B1763409E8F4B");
  wait 0.5;
  scripts\mp\utility\perk::giveperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13F65() {
  self notify("_encstr_875E107862BB5DF0BE0FB99B1763409E8F4B");

  if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13176() {
  thread _id_11D13();
}

_id_11D13() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9286146A21B64BCF9B7FCEC351E8976B485BE223890D");

  for(;;) {
    if(isDefined(self.health) && isDefined(self.maxhealth) && self.health < self.maxhealth) {
      scripts\mp\utility\perk::giveperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");

      while(self.health < self.maxhealth)
        waitframe();

      scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
    }

    waitframe();
  }
}

_id_13F66() {
  self notify("_encstr_9286146A21B64BCF9B7FCEC351E8976B485BE223890D");

  if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13195() {
  thread _id_11D15();
}

_id_11D15() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(self.currentweapon hasattachment("_encstr_B1340EF27D4AC1099BB82EA0D12EBC7B"))
    thread _id_13196();

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    waitframe();

    if(self.currentweapon hasattachment("_encstr_B1340EF27D4AC1099BB82EA0D12EBC7B")) {
      thread _id_13196();
      continue;
    }

    if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
      scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
  }
}

_id_13196() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_813B13035B6289B61781975013EAB080EA1E322AE3");
  self endon("_encstr_813B13035B6289B61781975013EAB080EA1E322AE3");
  self endon("_encstr_8D270CC1C2B9B4C6BE57B9CDCAE8");

  if(!scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::giveperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");

  wait 3.0;
  scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

_id_13F68() {
  self notify("_encstr_8D270CC1C2B9B4C6BE57B9CDCAE8");

  if(scripts\mp\utility\perk::_hasperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5"))
    scripts\mp\utility\perk::removeperk("_encstr_8A211B9B83566C4BB036A35EAF969B364E95C2DC950B6C1BBA9C161BE5");
}

ammodisabling_run(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0.disabledspeedmod))
    return;
  else
    var_0.disabledspeedmod = -0.05;

  var_0 shellshock("_encstr_A3030E6F0BBA9688DDE528418FBF80CF", 0.8);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  var_0 ammodisabling_impair();
  scripts\engine\utility::_id_143B9(0.8, "_encstr_AD75063D571AE108");
  var_0 ammodisabling_impairend();
  var_0.disabledspeedmod = undefined;
  var_0 scripts\mp\weapons::updatemovespeedscale();
}

ammodisabling_impair() {
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_slide(0);
  scripts\common\utility::allow_jump(0);
}

ammodisabling_impairend() {
  scripts\common\utility::allow_sprint(1);
  scripts\common\utility::allow_slide(1);
  scripts\common\utility::allow_jump(1);
}

setviewkickoverride() {
  self.overrideviewkickscale = 0.05;
  self._id_1218D = 0.05;
  self._id_1218F = 0.14;
  self.overrideviewkickscalesniper = 0.26;
  self.overrideviewkickscalepistol = 0.05;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    self._id_1218E = getdvarfloat("_encstr_AD111A77F3127131075B1803B2DF78B9AF44CBD59BFC480E2F52512B", 0.05) * getdvarfloat("_encstr_93BC187B21762FCEC8DF0E1FBF28525B15FB72218B468F0538AD", 0.7);
  else
    self._id_1218E = 0.05;

  scripts\mp\weapons::updateviewkickscale();
}

unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self._id_1218D = undefined;
  self._id_1218F = undefined;
  self._id_1218E = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\mp\weapons::updateviewkickscale();
}

setaffinityspeedboost() {
  self.weaponaffinityspeedboost = 0.08;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetaffinityspeedboost() {
  self.weaponaffinityspeedboost = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

setaffinityextralauncher() {
  self.weaponaffinityextralauncher = 1;
  var_0 = scripts\mp\class::buildweapon(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  var_1 = scripts\mp\class::buildweapon(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid);

  if(scripts\mp\utility\weapon::getweapongroup(var_0.basename) == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195")
    self setweaponammoclip(var_0, weaponclipsize(var_0));

  if(scripts\mp\utility\weapon::getweapongroup(var_1.basename) == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195")
    self setweaponammoclip(var_1, weaponclipsize(var_1));
}

unsetaffinityextralauncher() {
  self.weaponaffinityextralauncher = undefined;
}

setdoubleload() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AD900E672DDDA8874891CD974CC0D1E2");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    var_0 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("_encstr_AD900E672DDDA8874891CD974CC0D1E2");
}

setmarksman(var_0) {
  return;

  if(!isDefined(var_0))
    var_0 = 10;
  else
    var_0 = int(var_0) * 2;

  scripts\mp\utility\weapon::setrecoilscale(var_0);
  self.recoilscale = var_0;
}

unsetmarksman() {
  return;
  scripts\mp\utility\weapon::setrecoilscale(0);
  self.recoilscale = 0;
}

setfastcrouch() {
  thread watchfastcrouch();
}

watchfastcrouch() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8BE111EB0F4BC33F96E06BB16059C3D5429764");

  for(;;) {
    var_0 = (self getstance() == "_encstr_B13D076BED70539F23" || self getstance() == "_encstr_922406F1A6FD5E05") && !self issprintsliding();

    if(!isDefined(self.fastcrouchspeedmod)) {
      if(var_0) {
        self.fastcrouchspeedmod = 0.25;
        scripts\mp\weapons::updatemovespeedscale();
      }
    } else if(!var_0) {
      self.fastcrouchspeedmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
    }

    waitframe();
  }
}

unsetfastcrouch() {
  self notify("_encstr_8BE111EB0F4BC33F96E06BB16059C3D5429764");

  if(isDefined(self.fastcrouchspeedmod)) {
    self.fastcrouchspeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

setrshieldradar() {
  self endon("_encstr_912E12B8AB63A1E1212AC35BBF1A198FD93B9018");
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

setrshieldradar_cleanup() {
  self endon("_encstr_912E12B8AB63A1E1212AC35BBF1A198FD93B9018");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self))
    unsetrshieldradar();
}

unsetrshieldradar() {
  self clearportableradar();
  self notify("_encstr_912E12B8AB63A1E1212AC35BBF1A198FD93B9018");
}

setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

setrshieldscrambler_cleanup() {
  self endon("_encstr_B15616A3F37BFDF00A8A68402FECA83E927B030B6B32B588");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self))
    unsetrshieldscrambler();
}

unsetrshieldscrambler() {
  self clearscrambler();
  self notify("_encstr_B15616A3F37BFDF00A8A68402FECA83E927B030B6B32B588");
}

setstunresistance(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::unset_relic_grounded())
      var_0 = getdvarint("_encstr_A7E822187860C7D2B6F13B235E6DF04C4DBB6830052823BAA4C8751288DEC7D2B279612A", 2);
    else
      var_0 = 4;
  }

  var_0 = int(var_0);

  if(var_0 == 10)
    self._encstr_8BAE11E63A5D73E4CACDA56EE8CD8D16631693 = 0;
  else
    self._encstr_8BAE11E63A5D73E4CACDA56EE8CD8D16631693 = var_0 / 10;
}

unsetstunresistance() {
  self._encstr_8BAE11E63A5D73E4CACDA56EE8CD8D16631693 = 1;
}

_encstr_99CD0CDB28C8C3AB13A8ED50F367(var_0) {
  self._encstr_92E30F526BEF084D58320997135E4A97BB = getdvarfloat("_encstr_82EF1690ED2E0F61F849453D3F715FBE1D7FEEAA727868FB", 1.4);
}

_encstr_B8310EC8F643DAB32663FD7A95A8830D() {
  self._encstr_92E30F526BEF084D58320997135E4A97BB = 1;
}

_encstr_B15B12C76BA37A7B15788BF2E1E1677258FB684D(var_0) {
  var_1 = var_0 scripts\mp\utility\perk::_hasperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA");
  var_2 = var_0 scripts\mp\utility\perk::_hasperk("_encstr_BD0612A92DDD4809EBA3C64B5BC73001B58F350B");

  if(var_1 && !var_2)
    return "_encstr_A95E0ADC3AAECDBEC62BDCDC";
  else if(var_2 && !var_1)
    return "_encstr_B46A0A7BD353B5DFD8308DFA";

  return "_encstr_816F0C16845D65907E37C328B16B";
}

applystunresistence(var_0, var_1, var_2) {
  var_3 = _encstr_B15B12C76BA37A7B15788BF2E1E1677258FB684D(var_1);

  if(var_3 == "_encstr_A95E0ADC3AAECDBEC62BDCDC" && var_0 != var_1) {
    if(isDefined(var_1._encstr_8BAE11E63A5D73E4CACDA56EE8CD8D16631693) && isDefined(var_2))
      var_2 = var_2 * var_1._encstr_8BAE11E63A5D73E4CACDA56EE8CD8D16631693;

    var_4 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);
    var_5 = scripts\engine\utility::ter_op(isDefined(var_1.owner), var_1.owner, var_1);

    if(isPlayer(var_4) && var_4 != var_1)
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8D760DB8F77343CF62BEB7E3D01013", undefined, undefined, undefined, 1);

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_4, var_5)))
      var_1 scripts\cp\vehicles\vehicle_compass_cp::resistedstun(var_4);
  } else if(!istrue(var_1 scripts\mp\utility\player::is_allowed_to_be_stunned()))
    var_2 = 0.0;
  else if(var_3 == "_encstr_B46A0A7BD353B5DFD8308DFA" && var_0 != var_1) {
    if(isDefined(var_1._encstr_92E30F526BEF084D58320997135E4A97BB) && isDefined(var_2))
      var_2 = var_2 * var_1._encstr_92E30F526BEF084D58320997135E4A97BB;
  }

  if(var_1 scripts\mp\utility\game::ismatchstartprotected())
    var_2 = var_2 * 0.1;

  return var_2;
}

setweaponlaser() {
  if(isagent(self)) {
    return;
  }
  self endon("_encstr_A30711DF7BF8551B910AAF6F778A3152FA879B");
  wait 0.5;
  thread setweaponlaser_internal();
}

unsetweaponlaser() {
  self notify("_encstr_A30711DF7BF8551B910AAF6F778A3152FA879B");

  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron)
    scripts\mp\utility\weapon::disableweaponlaser();

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

setweaponlaser_waitforlaserweapon(var_0) {
  var_0 = getweaponbasename(var_0);

  for(;;) {
    if(isDefined(var_0) && (var_0 == "_encstr_97B60B071863F71A7306699DF7" || var_0 == "_encstr_B6090E3AFBF261AA88BBC37B3AB7D7E3")) {
      break;
    }

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);
    var_0 = var_1.basename;
  }
}

setweaponlaser_internal() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A30711DF7BF8551B910AAF6F778A3152FA879B");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(var_0);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      scripts\mp\utility\weapon::enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      scripts\mp\utility\weapon::disableweaponlaser();
    }
  }
}

setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

  for(;;) {
    self waittill("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");
    childthread setweaponlaser_onweaponswitchstart(var_0);
  }
}

setweaponlaser_onweaponswitchstart(var_0) {
  self notify("_encstr_9B9B23B30B60135F7FDB2A026447CF5788975726F74026531070E19B2825B74CE979D1A219");
  self endon("_encstr_9B9B23B30B60135F7FDB2A026447CF5788975726F74026531070E19B2825B74CE979D1A219");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    scripts\mp\utility\weapon::disableweaponlaser();
  }

  wait(var_0);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility\weapon::enableweaponlaser();
  }
}

setweaponlaser_monitorads() {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          scripts\mp\utility\weapon::disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        scripts\mp\utility\weapon::enableweaponlaser();
      }
    }

    waitframe();
  }
}

setsteadyaimpro() {
  self setaimspreadmovementscale(0.5);
}

unsetsteadyaimpro() {
  self notify("_encstr_912911D812EF4797D36DBF25592F189B5A7B10");
  self setaimspreadmovementscale(1.0);
}

perkusedeathtracker() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  self._useperkenabled = undefined;
}

setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "_encstr_B40101";
  self visionsetnakedforplayer("_encstr_A3AF090768A9910F4118EF", 5);
  thread endgamedeath(7);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

unsetendgame() {
  self notify("_encstr_92460CC754C598B5AB4AEDD1227F");
  self.endgame = undefined;
  scripts\mp\utility\player::restorebasevisionset(1);

  if(!isDefined(self.endgametimer)) {
    return;
  }
  self.endgametimer scripts\mp\hud_util::destroyelem();
  self.endgameicon scripts\mp\hud_util::destroyelem();
}

endgamedeath(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_92460CC754C598B5AB4AEDD1227F");
  wait(var_0 + 1);
  scripts\mp\utility\damage::_suicide();
}

setsaboteur() {
  self.objectivescaler = 1.2;
}

unsetsaboteur() {
  self.objectivescaler = 1;
}

setcombatspeed() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B9311AECD372BA30DF6DA8985D19A0EACB28C");
  self.incombatspeed = 0;
  unsetcombatspeedscalar();

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(!isDefined(var_1.team)) {
      continue;
    }
    if(level.teambased && var_1.team == self.team) {
      continue;
    }
    if(self.incombatspeed) {
      continue;
    }
    setcombatspeedscalar();
    self.incombatspeed = 1;
    thread endofspeedwatcher();
  }
}

endofspeedwatcher() {
  self notify("_encstr_BA3A12538B67A77576E2908D34E7D81BD3908A1D");
  self endon("_encstr_BA3A12538B67A77576E2908D34E7D81BD3908A1D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_8FB50718DD41DB3FA9");
  unsetcombatspeedscalar();
  self.incombatspeed = 0;
}

setcombatspeedscalar() {
  if(self.weaponspeed <= 0.8)
    self.combatspeedscalar = 1.4;
  else if(self.weaponspeed <= 0.9)
    self.combatspeedscalar = 1.3;
  else
    self.combatspeedscalar = 1.2;

  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeedscalar() {
  self.combatspeedscalar = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeed() {
  unsetcombatspeedscalar();
  self notify("_encstr_9B9311AECD372BA30DF6DA8985D19A0EACB28C");
}

setlightweight() {
  if(!isDefined(self.cranked)) {
    self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetlightweight() {
  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

setblackbox() {}

unsetblackbox() {}

setsteelnerves() {
  scripts\mp\utility\perk::giveperk("_encstr_A1C919E233105BA29FF1F3FFAF36AB9C8079DBEEC988F54BE787CF");
  scripts\mp\utility\perk::giveperk("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A");
}

unsetsteelnerves() {
  scripts\mp\utility\perk::removeperk("_encstr_A1C919E233105BA29FF1F3FFAF36AB9C8079DBEEC988F54BE787CF");
  scripts\mp\utility\perk::removeperk("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A");
}

setdelaymine() {}

unsetdelaymine() {}

setlocaljammer() {
  if(scripts\cp_mp\emp_debuff::is_empd())
    self makescrambler();
}

unsetlocaljammer() {
  self clearscrambler();
}

setthermal() {
  self thermalvisionon();
}

unsetthermal() {
  self thermalvisionoff();
}

setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

unsetonemanarmy() {
  self notify("_encstr_ABA717DC477BE0BEB773CAD4169B0AE4B65E2A9C586CB695C9");
}

onemanarmyweaponchangetracker() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ABA717DC477BE0BEB773CAD4169B0AE4B65E2A9C586CB695C9");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(var_0.basename != "_encstr_87EE0E1FD009C5BA6D07229D73673280") {
      continue;
    }
    thread selectonemanarmyclass();
  }
}

isonemanarmymenu(var_0) {
  if(var_0 == game["_encstr_8EAE107A8075FBDF70A0F5E5CFB8EFC28B88"])
    return 1;

  if(isDefined(game["_encstr_8AC92515B30823FF3040C24A89983F5AB813AF64DB106E9F69FBBB51D3EF435488AF0BFA63E075"]) && var_0 == game["_encstr_8AC92515B30823FF3040C24A89983F5AB813AF64DB106E9F69FBBB51D3EF435488AF0BFA63E075"])
    return 1;

  if(isDefined(game["_encstr_A93B23AAE785C8B9EA0E9F27AF03806B6F9B51B60F3F33C0D5D78673C21F039FFA55470B70"]) && var_0 == game["_encstr_A93B23AAE785C8B9EA0E9F27AF03806B6F9B51B60F3F33C0D5D78673C21F039FFA55470B70"])
    return 1;

  return 0;
}

selectonemanarmyclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  thread closeomamenuondeath();
  self waittill("_encstr_A22C0DDA2BCD5793AC9B83ED73B9B2", var_0, var_1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);

  if(var_1 == "_encstr_B69B0589C236B6" || !isonemanarmymenu(var_0) || scripts\mp\utility\player::isusingremote()) {
    var_2 = self getcurrentweapon();

    if(var_2.basename == "_encstr_87EE0E1FD009C5BA6D07229D73673280") {
      scripts\common\utility::allow_weapon_switch(0);
      scripts\common\utility::allow_offhand_weapons(0);
      scripts\common\utility::allow_usability(0);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(scripts\mp\utility\inventory::getlastweapon());
      self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
      scripts\common\utility::allow_weapon_switch(1);
      scripts\common\utility::allow_offhand_weapons(1);
      scripts\common\utility::allow_usability(1);
    }

    return;
  }

  thread giveonemanarmyclass(var_1);
}

closeomamenuondeath() {
  self endon("_encstr_A22C0DDA2BCD5793AC9B83ED73B9B2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);
}

giveonemanarmyclass(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\perk::_hasperk("_encstr_8AB41972403D1B03A14DC8F0562FDA5AC1433A5E0AC7A4D9B68FD2")) {
    var_1 = 3.0;
    scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_B11D1946FF40785798F86A926160E7F2107BC7CA7BF0128F3F9013", "_encstr_A61D192025A0488637FE37A1F6B3DAFB0BF82F5656070327F8130E");
  } else {
    var_1 = 6.0;
    scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_AA39194EF748704F80F0129A7968EFEAE863FFD203E86B8737A81B", "_encstr_8E3A19DD7F15C0A8BF1A5940F2637F50EDD1274D19BFE290931391");
  }

  thread omausebar(var_1);
  scripts\common\utility::allow_weapon(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  wait(var_1);
  scripts\common\utility::allow_weapon(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);
  scripts\mp\class::giveloadout(self.pers["_encstr_8AEF05472BC2D6"], var_0);

  if(isDefined(self.carryflag))
    self attach(self.carryflag, "_encstr_8EEC09559F6238030BFA23", 1);

  self notify("_encstr_8B840CAA40330BB28F412E40DB59");
  level notify("_encstr_8B840CAA40330BB28F412E40DB59");
  scripts\mp\rank::tryresetrankxp();
}

omausebar(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = scripts\mp\hud_util::createprimaryprogressbar();
  var_2 = scripts\mp\hud_util::createprimaryprogressbartext();
  var_2 settext(&"_encstr_ACCF126A8255A4EBD02428E4744A721DBEB4A415");
  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_0);

  for(var_3 = 0; var_3 < var_0 && isalive(self) && !level.gameended; var_3 = var_3 + 0.05)
    wait 0.05;

  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

setafterburner() {
  self energy_setrestorerate(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 1000));
  self energy_setresttimems(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 750, 750));
}

unsetafterburner() {
  self energy_setrestorerate(0, 400);
  self energy_setresttimems(0, 900);
}

setblastshield() {}

unsetblastshield() {}

toggleblastshield(var_0) {}

blastshieldusetracker(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_93D613684DABA79B288860C78379D573A0CB3F7043");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AB430E31C5D0A31B590F750D6BC2E8C8");

    if(!scripts\common\utility::is_offhand_weapons_allowed()) {
      continue;
    }
    self[[var_1]](scripts\mp\utility\perk::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"));
  }
}

setfreefall() {}

unsetfreefall() {}

settacticalinsertion() {
  scripts\mp\equipment::giveequipment("_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A", "_encstr_AC8F0AE74163F85AAA380AD8");
}

unsettacticalinsertion() {}

setpainted(var_0) {
  if(isPlayer(self)) {
    var_1 = 0.5;

    if(!scripts\mp\utility\perk::_hasperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565") && !scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      self.painted = 1;
      var_2 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_960D052F10EBF0");
      thread watchpainted(var_2, var_1);
      thread watchpaintedagain(var_2);
    }
  }
}

watchpainted(var_0, var_1) {
  self notify("_encstr_A2970EAB4003560BFFA1F19A1A8ACF33");
  self endon("_encstr_A2970EAB4003560BFFA1F19A1A8ACF33");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143B9(var_1, "_encstr_AD75063D571AE108");
  self.painted = 0;
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("_encstr_A6E60CF81E27AABB10A4D0EF5323");
}

watchpaintedagain(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_A2970EAB4003560BFFA1F19A1A8ACF33", "_encstr_A6E60CF81E27AABB10A4D0EF5323");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

ispainted() {
  return isDefined(self.painted) && self.painted;
}

setassists() {}

unsetassists() {}

setrefillgrenades() {
  if(isDefined(self.primarygrenade))
    self givemaxammo(self.primarygrenade);

  if(isDefined(self.secondarygrenade))
    self givemaxammo(self.secondarygrenade);
}

unsetrefillgrenades() {}

setrefillammo() {
  if(isDefined(self.primaryweapon))
    self givemaxammo(self.primaryweapon);

  if(isDefined(self.secondaryweapon))
    self givemaxammo(self.secondaryweapon);
}

unsetrefillammo() {}

setcomexp() {}

unsetcomexp() {}

settagger() {
  thread settaggerinternal();
}

settaggerinternal() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D5F0C57CDDCB28E2A16D93BB24E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_BD3D07ACF2B2DC3DDC");
    var_0 = self getplayerssightingme();

    foreach(var_2 in var_0) {
      if(level.teambased && var_2.team == self.team) {
        continue;
      }
      if(isalive(var_2) && var_2.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
        if(!isDefined(var_2.perkoutlined))
          var_2.perkoutlined = 0;

        if(!var_2.perkoutlined)
          var_2.perkoutlined = 1;

        var_2 thread outlinewatcher(self);
      }
    }
  }
}

outlinewatcher(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8BDE08E76F89238F9C64");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = 1;
    var_2 = var_0 getplayerssightingme();

    foreach(var_4 in var_2) {
      if(var_4 == self) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      self.perkoutlined = 0;
      self notify("_encstr_8BDE08E76F89238F9C64");
    }

    wait 0.5;
  }
}

unsettagger() {
  self notify("_encstr_8D5F0C57CDDCB28E2A16D93BB24E");
}

setpitcher() {
  thread setpitcherinternal();
}

setpitcherinternal() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86010D2F88936543A9BB0BC613FB1B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_0);
    var_1 = var_0.basename;

    if(var_1 == "_encstr_991712D71B1B4532A71761A8B9EBFAA743F09D87" || var_1 == "_encstr_823D1A21FA6B91D8C0F95551E5A1D8ED9F03DE8802CB5AF05AEF4361" || var_1 == "_encstr_96B7228C2B0ED8DECB58313659BEBBCA161CDE377D1B392C1D2BD76B2C4EB5564ED7DA38")
      self setgrenadethrowscale(1);

    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_2, var_0);
  }
}

unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("_encstr_86010D2F88936543A9BB0BC613FB1B");
}

setboom() {}

setboominternal(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86D60AEBDD3B607570E7BFB3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  waitframe();
  triggerportableradarping(self.origin, var_0, 800, 1500);
  var_0 boomtrackplayers(self.origin, self);
}

boomtrackplayers(var_0, var_1) {
  var_2 = scripts\common\utility::playersinsphere(var_0, 700);

  foreach(var_4 in var_2) {
    if(var_1 == var_4) {
      continue;
    }
    if(scripts\mp\utility\player::isenemy(var_4) && isalive(var_4) && !var_4 scripts\mp\utility\perk::_hasperk("_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693")) {}
  }
}

boomtrackplayerdeath(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_911710C9ACADF6EC9585C98D1AAC8E973859");
  var_2 = scripts\engine\utility::_id_143B9(7.0, "_encstr_AD75063D571AE108");

  if(var_2 == "_encstr_995408F398012F656821" && isDefined(self.markedbyboomperk[var_1]))
    self.markedbyboomperk[var_1] = undefined;
  else {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    self.markedbyboomperk = undefined;
  }
}

unsetboom() {
  self notify("_encstr_86D60AEBDD3B607570E7BFB3");
}

customjuiced(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_AB8D141388FEDF53A99F151B997BDDEFAA032AFA71DD");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.isjuiced = 1;
  self.movespeedscaler = 1.1;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\mp\utility\perk::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  thread unsetcustomjuicedondeath();
  thread unsetcustomjuicedonride();
  thread unsetcustomjuicedonmatchend();
  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {}

  wait(var_0);
  unsetcustomjuiced();
}

unsetcustomjuiced(var_0) {
  if(!isDefined(var_0)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"))
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::removeperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::removeperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\mp\utility\perk::removeperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::removeperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::removeperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  self.isjuiced = undefined;

  if(!isai(self)) {}

  self notify("_encstr_AB8D141388FEDF53A99F151B997BDDEFAA032AFA71DD");
}

unsetcustomjuicedonride() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AB8D141388FEDF53A99F151B997BDDEFAA032AFA71DD");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread unsetcustomjuiced();
      break;
    }
  }
}

unsetcustomjuicedondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AB8D141388FEDF53A99F151B997BDDEFAA032AFA71DD");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_91D70BC8AF032B0F1B734F731A");
  thread unsetcustomjuiced(1);
}

unsetcustomjuicedonmatchend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AB8D141388FEDF53A99F151B997BDDEFAA032AFA71DD");
  level scripts\engine\utility::_id_143A5("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739", "_encstr_9B1D0BC7932875276230426AA1");
  thread unsetcustomjuiced();
}

settriggerhappy() {}

settriggerhappyinternal() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A7261257DCE6B28E454E96CEEC959C842C070E97");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.lastdroppableweaponobj;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  self givestartammo(var_0);
  var_3 = self getweaponammoclip(var_0);
  var_4 = var_3 - var_2;
  var_5 = var_1 - var_4;

  if(var_4 > var_1) {
    self setweaponammoclip(var_0, var_2 + var_1);
    var_5 = 0;
  }

  self setweaponammostock(var_0, var_5);
  self playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
  self setclientomnvar("_encstr_ADB711337F29E570813719519A4F58973383A3", 1);
  wait 0.2;
  self setclientomnvar("_encstr_ADB711337F29E570813719519A4F58973383A3", 0);
}

unsettriggerhappy() {
  self setclientomnvar("_encstr_ADB711337F29E570813719519A4F58973383A3", 0);
  self notify("_encstr_A7261257DCE6B28E454E96CEEC959C842C070E97");
}

setincog() {}

unsetincog() {}

setblindeye() {}

unsetblindeye() {}

setquickswap() {}

unsetquickswap() {}

setextraammo() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_874D103B188F3FB3B6E5283C0619AF45CB78");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.gettingloadout)
    self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  var_0 = scripts\mp\utility\weapon::getvalidextraammoweapons();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !nullweapon(var_2) && var_2 hasattachment("_encstr_B45E080DA3A03EDFD998", 1) && !istrue(var_2.first_equipped)) {
      self givemaxammo(var_2);
      var_2.first_equipped = 1;
    }
  }
}

unsetextraammo() {
  self notify("_encstr_874D103B188F3FB3B6E5283C0619AF45CB78");
}

setextraequipment() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86E91577D0CBCDEB0F05A0DBF61BB2815340DB9F108014");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.gettingloadout)
    self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  var_0 = self.loadoutperkoffhand;

  if(isDefined(var_0) && var_0 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249") {
    if(var_0 != "_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8" && var_0 != "_encstr_8823119675DAFF897F878020BB99612B219D8F" && var_0 != "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9")
      self setweaponammoclip(var_0, 2);
  }
}

unsetextraequipment() {
  self notify("_encstr_86E91577D0CBCDEB0F05A0DBF61BB2815340DB9F108014");
}

setextradeadly() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A24012CDED43BBE337F798F08321B9E30A17C953");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.gettingloadout)
    self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  var_0 = scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_0) && var_0 != "_encstr_8BBA05185F8B99")
    scripts\mp\equipment::incrementequipmentammo(var_0);
}

unsetextradeadly() {
  self notify("_encstr_A24012CDED43BBE337F798F08321B9E30A17C953");
}

setbattleslide() {}

unsetbattleslide() {}

setoverkill() {}

unsetoverkill() {}

setactivereload() {}

unsetactivereload() {}

setlifepack() {
  if(!isDefined(level._effect["_encstr_BDFD1109645AF3DE40AF38406F78D037528BFF"]))
    level._effect["_encstr_BDFD1109645AF3DE40AF38406F78D037528BFF"] = undefined;

  thread watchlifepackkills();
}

watchlifepackkills() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8A800F68F81B83C36F9990D563A15F8E64");
  self endon("_encstr_8A800F68F81B83C36F9990D563A15F8E64");

  for(;;) {
    self waittill("_encstr_8F220B3FC7D11160D8F85169E9", var_0, var_1, var_2);
    var_3 = self.origin;
    var_4 = 20;
    var_5 = 20;
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 10));
    var_6 setModel("_encstr_B1101177592CE07B37AF632D992B7DC158B1AD");
    var_6.owner = self;
    var_6.team = self.team;
    var_6 hidefromplayer(self);
    var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, var_4, var_5);
    var_7 thread watchlifepackuse(var_6);
    var_7 thread watchlifepackdeath(var_6);
    var_6 thread hoverlifepack();
    var_6 rotateYaw(1000, 30, 0.2, 0.2);
    var_6 thread watchlifepacklifetime(10, var_7);
    var_6 thread watchlifepackowner();

    foreach(var_9 in level.players)
    var_6 setlifepackvisualforplayer(var_9);
  }
}

activatelifepackboost(var_0, var_1, var_2) {
  self.lifeboostactive = 1;

  if(isDefined(var_1) && var_1 > 0)
    thread watchlifepackboostlifetime(var_1);

  if(isDefined(var_2) && var_2)
    thread watchlifepackuserdeath();

  scripts\mp\utility\perk::giveperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
  self setclientomnvar("_encstr_ACE90D9B42161AD88410B1F801E392", 1);
  self notify("_encstr_85AD1870300E93952A8B974932A3C397700A87F75F1B4FCF4F05");
  self.lifepackowner = var_0;
  thread scripts\mp\gamescore::trackbuffassistfortime(var_0, self, "_encstr_A31D0FDA2B19A51BBE8DD299591C2CD86D", var_1);
}

watchlifepackboostlifetime(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait(var_0);

  if(isDefined(self.lifeboostactive))
    disablelifepackboost();
}

disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("_encstr_ACE90D9B42161AD88410B1F801E392", 0);
    self notify("_encstr_8C2A196B486EE7F24829E047797761D9DFB1492062174230C09B60");
    scripts\mp\utility\perk::removeperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
    scripts\mp\gamescore::untrackbuffassist(self.lifepackowner, self, "_encstr_A31D0FDA2B19A51BBE8DD299591C2CD86D");
    self.lifepackowner = undefined;
  }
}

setlifepackvisualforplayer(var_0) {
  if(level.teambased && var_0.team == self.team && var_0 != self.owner) {
    setlifepackoutlinestate(var_0);
    self showtoplayer(var_0);
    thread watchlifepackoutlinestate(var_0);
  } else
    self hidefromplayer(var_0);
}

setlifepackoutlinestate(var_0) {
  if(isDefined(var_0.lifeboostactive)) {
    if(isDefined(var_0.lifepackoutlines) && var_0.lifepackoutlines.size > 0) {
      foreach(var_2 in var_0.lifepackoutlines) {
        if(self == var_2.pack) {
          scripts\mp\utility\outline::outlinedisable(var_2.id, var_2.pack);
          var_0.lifepackoutlines = scripts\engine\utility::array_remove(var_0.lifepackoutlines, var_2);
          var_2 = undefined;
        }
      }
    }
  } else {
    if(!isDefined(var_0.lifepackoutlines))
      var_0.lifepackoutlines = [];

    var_4 = spawnStruct();
    var_4.id = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD", "_encstr_BE8F0A272F9B2BE97268AE8B");
    var_4.pack = self;
    var_0.lifepackoutlines = scripts\engine\utility::array_add_safe(var_0.lifepackoutlines, var_4);
  }
}

watchlifepackoutlinestate(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 scripts\engine\utility::_id_143A5("_encstr_85AD1870300E93952A8B974932A3C397700A87F75F1B4FCF4F05", "_encstr_8C2A196B486EE7F24829E047797761D9DFB1492062174230C09B60");
    setlifepackoutlinestate(var_0);
  }
}

hoverlifepack() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82FB16E8A3B95FD737102A43108BCAC7918050794E800FDA");
  var_0 = self.origin;

  for(;;) {
    self moveTo(var_0 + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveTo(var_0, 1, 0.2, 0.2);
    wait 1;
  }
}

watchlifepackuse(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(var_1.team != var_0.team) {
      continue;
    }
    if(isDefined(var_1.lifeboostactive)) {
      continue;
    }
    if(var_1 == var_0.owner) {
      continue;
    }
    var_1 activatelifepackboost(var_0.owner, 5, 1);
    var_1 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    var_2 = spawnfx(scripts\engine\utility::getfx("_encstr_BDFD1109645AF3DE40AF38406F78D037528BFF"), self.origin);
    triggerfx(var_2);
    var_2 thread scripts\mp\utility\script::delayentdelete(2);

    foreach(var_4 in level.players) {
      if(var_4.team == var_1.team) {
        continue;
      }
      var_2 hidefromplayer(var_4);
    }

    var_0 delete();
  }
}

watchlifepackdeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self))
    self delete();
}

watchlifepacklifetime(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  var_1 delete();
  self delete();
}

watchlifepackowner() {
  self endon("_encstr_AD75063D571AE108");
  self.owner waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    self delete();
}

watchlifepackuserdeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  disablelifepackboost();
}

unsetlifepack() {
  disablelifepackboost();
  self notify("_encstr_8A800F68F81B83C36F9990D563A15F8E64");
}

settoughenup() {
  if(!isDefined(level._effect["_encstr_B4B71298CA638F48DF3EF8E5180F134F0AF298B0"]))
    level._effect["_encstr_B4B71298CA638F48DF3EF8E5180F134F0AF298B0"] = loadfx("_encstr_A1C629A3F1F817A294479E67F5B5EB85C8BBDB6A40F8F09E6C8DCB6F116893CFC8C1D5F9A3689793CEBD8B");

  thread watchtoughenup();
}

watchtoughenup() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A31D0FEA73DC95A3A8EDEAD91A59CD550E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = 15;
  var_2 = 7.5;
  var_3 = 4;
  var_4 = 5;
  var_5 = 2;
  var_6 = [];
  var_6 = scripts\engine\utility::array_add_safe(var_6, (35, 0, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (0, 35, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (-35, 0, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (0, -35, 10));
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  for(;;) {
    self waittill("_encstr_8F220B3FC7D11160D8F85169E9", var_7, var_8, var_9);

    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      var_10 = spawnfxforclient(scripts\engine\utility::getfx("_encstr_B4B71298CA638F48DF3EF8E5180F134F0AF298B0"), self getEye(), self);
      triggerfx(var_10);
      thread attachtoughenuparmor("_encstr_83670BB30E764F8E89F392EF25", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_93E815744F11876A3BD8228AC821657B4E27FA15C8D8D7", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_ABE81598984749D26362E8E54EA1078BCF9B928506EE83", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_813B0D4027B390B37585BBC819FD28", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_81941033E6A7397E4A7713397B01CE0B7BFC", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_AFDD09A6FA864B1CBEB156", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
      thread attachtoughenuparmor("_encstr_AFDD09A6FA864B1CBEC996", level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);

      if(var_5 == 1) {
        scripts\mp\utility\damage::sethealthshield(var_1);
        thread watchtoughenuplifetime(var_4);
      } else {
        scripts\mp\lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      var_10 thread watchtoughenupplayerend(self);
      continue;
    }

    if(var_5 == 1) {
      self notify("_encstr_A36F11E8EDEACE34B2CDAFBA07FA3956372B1D");
      thread watchtoughenuplifetime(var_4);
    }
  }
}

attachtoughenuparmor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_0);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_6 setModel(var_1);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);

  if(isDefined(var_2))
    var_7 = var_2;

  if(isDefined(var_3))
    var_8 = var_3;

  var_6.angles = self.angles;
  var_6 linkTo(self, var_0, var_7, var_8);
  var_6 thread watchtoughenupplayerend(self);
  var_6 thread watchtoughenupgameend();
  return var_6;
}

settoughenupmodel(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 50));
  var_4.team = self.owner.team;

  if(var_3 == "_encstr_ACFC091AE8AB2FCBE15119")
    var_4 setModel(level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].friendlymodel);
  else
    var_4 setModel(level.bulletstormshield["_encstr_B1E1089BACB1E8967B37"].enemymodel);

  var_4 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1, (0, 90 * (var_2 + 1), 0));
  var_4 hide();
  var_4 thread watchtoughenupplayerend(self.owner);
  var_4 thread watchtoughenupgameend();
  var_4 thread settoughenupvisiblestate(var_3, self.owner);
}

watchtoughenuplightarmorend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A2BD1339CAB6B7CE59D71B2DB386D1EBB09CADB727");
}

watchtoughenupplayerend(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_84860FCBC7AD627820C829ABE319BD2A8D");
  var_0.toughenedup = undefined;

  if(var_0 scripts\mp\lightarmor::haslightarmor(var_0))
    var_0 unsetlightarmor();

  if(isDefined(self))
    self delete();
}

watchtoughenupgameend() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self delete();
}

watchtoughenuplifetime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A36F11E8EDEACE34B2CDAFBA07FA3956372B1D");

  while(var_0 > 0) {
    var_0 = var_0 - 1;
    wait 1;
  }

  self notify("_encstr_84860FCBC7AD627820C829ABE319BD2A8D");
}

settoughenupvisiblestate(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(canshowtoughenupshield(var_3, var_0))
      self showtoplayer(var_3);

    thread watchtoughenupplayerbegin(var_3, var_0);
  }
}

watchtoughenupplayerbegin(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    self hidefromplayer(var_0);

    if(canshowtoughenupshield(var_0, var_1))
      self showtoplayer(var_0);
  }
}

canshowtoughenupshield(var_0, var_1) {
  var_2 = 0;

  if(var_1 == "_encstr_ACFC091AE8AB2FCBE15119" && var_0.team == self.team || var_1 == "_encstr_88BF06FD784A6393" && var_0.team != self.team)
    var_2 = 1;

  return var_2;
}

unsettoughenup() {
  scripts\mp\utility\damage::clearhealthshield();
  unsetlightarmor();
  self notify("_encstr_A31D0FEA73DC95A3A8EDEAD91A59CD550E");
}

setscoutping() {
  thread updatescoutping();
}

updatescoutping() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF190FF7FDA64A6C8961DDA37B69893274");
  var_0 = 50;
  var_1 = 1200;
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

  for(;;) {
    var_3 = var_0;
    var_4 = var_1;

    if(isDefined(self.scoutpingradius))
      var_3 = self.scoutpingradius;

    if(isDefined(self.scoutsweeptime))
      var_4 = self.scoutsweeptime;

    var_3 = int(var_3);
    var_4 = int(var_4);

    if(var_3 != var_0) {
      if(istrue(var_2) && getdvarint("_encstr_A37123E66CE4BEB032CEB037362B32F5371BDBAB1DD738D29B3B7DB92E578546D7F67336F2", 0)) {
        var_5 = level.squaddata[self.team][self.squadindex].players;

        foreach(var_7 in var_5)
        triggerportableradarping(self.origin, self, var_3, var_4);
      } else
        triggerportableradarpingteam(self.origin, self.team, var_3, var_4);
    }

    wait(var_1 / 1200);
  }
}

updatescoutpingvalues(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 3000;

  if(isDefined(self.scoutpingmod))
    var_1 = self.scoutpingmod;

  if(isDefined(self.scoutpingpreviousstage)) {
    if(var_0 > self.scoutpingpreviousstage) {
      var_4 = var_0 - self.scoutpingpreviousstage;
      var_1 = var_1 + var_4 / 10;
    } else if(var_0 < self.scoutpingpreviousstage) {
      var_4 = self.scoutpingpreviousstage - var_0;
      var_1 = var_1 - var_4 / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(var_1 > self.scoutpingmod || var_1 < self.scoutpingmod) {
      var_2 = var_2 + var_2 * var_1 * 1.5;
      var_3 = var_3 - var_3 * var_1 / 1.5;
      self.scoutpingradius = var_2;
      self.scoutsweeptime = var_3;
    }
  }

  if(var_0 == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = var_1;
  self.scoutpingpreviousstage = var_0;
}

unsetscoutping() {
  self.scoutpingradius = undefined;
  self.scoutsweeptime = undefined;
  self.scoutpingmod = undefined;
  self.scoutpingpreviousstage = undefined;
  self notify("_encstr_AF190FF7FDA64A6C8961DDA37B69893274");
}

setphasespeed() {
  thread watchphasespeedshift();
  thread watchphasespeedendshift();
}

watchphasespeedshift() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_A98F12D0181AABC7EF5E802B8005FF8EC96762F3");
    self.phasespeedmod = 0.2;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

watchphasespeedendshift() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_BA47162003C1F3536152B3CBEF2BDF39278FA8789F8C4919");
    self.phasespeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetphasespeed() {
  self.phasespeedmod = undefined;
}

setdodge() {
  self allowdodge(1);
}

unsetdodge() {
  self allowdodge(0);
}

setextradodge() {
  self energy_setmax(1, 100);
  self energy_setenergy(1, 100);
}

unsetextradodge() {
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
}

_id_133AF(var_0) {
  if(!scripts\mp\utility\perk::_hasperk("_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756"))
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0.team == self.team)
    return 0;

  if(distancesquared(var_0.origin, self.origin) > 16000000)
    return 0;

  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_818B1DB9C1AC8D962C1B47CBAF37D20FE834EBDC2BB99BCAAF96B6B5D573B2"))
    return 0;

  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && isDefined(var_1.vehiclename)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0);

    if(var_2) {
      if(var_1.vehiclename != "_encstr_AF390B295782C3585F1B21D8C4" && var_1.vehiclename != "_encstr_86510C82737817CD40B38B720A15")
        return 0;
    } else if(var_1.vehiclename == "_encstr_86510C82737817CD40B38B720A15")
      return 0;
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    var_3 = var_0 scripts\mp\utility\player::getremotename();

    if(var_3 == "_encstr_86FD08B775CD07DC1338" || var_3 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_3 == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A" || var_3 == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053" || var_3 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")
      return 0;
  }

  return 1;
}

_id_133AD(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_2;
  var_5 = vectordot(var_4, var_3);

  if(var_5 <= 0)
    return 0;

  var_6 = length(var_4);
  var_7 = 12;
  var_7 = var_7 + -0.15 * sqrt(var_6);
  var_8 = scripts\engine\math::keypad_increase_failnum(var_7);
  var_9 = 1 - 0.5 * var_8 * var_8;

  if(var_5 < var_9 * var_6)
    return 0;

  return 1;
}

_id_133AE(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = vectordot(var_0, vectorNormalize(var_3));

  if(var_4 < 0.382683)
    return 1;

  return 0;
}

sixthsense_think_internal() {
  var_0 = scripts\engine\trace::create_default_contents(1);
  var_1 = 0;
  var_2 = getdvarint("_encstr_997C1CB936937DDCA5C38E34F5E6ACDCCDB27DEADCB2D759CBB29BF5EDB9") == 1;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = getsystemtimeinmicroseconds();

  foreach(var_28, var_8 in level.sixth_sense_players) {
    if(!isDefined(var_8)) {
      level.sixth_sense_players[var_28] = undefined;
      break;
    }

    var_9 = 0;

    if(var_2 && !isbot(var_8)) {
      if(!var_8 scripts\mp\utility\perk::_hasperk("_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756")) {
        continue;
      }
      if(!var_8 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      var_10 = var_8 scripts\mp\utility\player::getstancecenter();
      var_11 = var_8 getplayerssightingme();

      foreach(var_13 in var_11) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level.sixth_sense_players[var_28] = undefined;
          break;
        }

        if(!var_8 _id_133AF(var_13)) {
          continue;
        }
        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!var_8 _id_133AD(var_13, var_10, var_14, var_15)) {
          continue;
        }
        var_9 = var_9 | var_8 roof_rpg_covers(var_13);
      }
    } else {
      var_10 = var_8 gettagorigin("_encstr_83890D9CA8EF0B79D830939788913A");
      var_17 = var_8 getEye();
      var_18 = anglesToForward(var_8 getplayerangles());

      foreach(var_13 in level.players) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level.sixth_sense_players[var_28] = undefined;
          break;
        }

        if(!var_8 _id_133AF(var_13)) {
          continue;
        }
        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!var_8 _id_133AD(var_13, var_10, var_14, var_15)) {
          continue;
        }
        if(_id_133AE(var_18, var_10, var_14)) {
          var_3 = var_3 + 2;
          var_20 = [var_8];
          var_21 = var_13 scripts\cp_mp\utility\player_utility::getvehicle();

          if(isDefined(var_21)) {
            var_22 = getchildoutlineents(var_21);

            foreach(var_24 in var_22)
            var_20[var_20.size] = var_24;
          }

          var_26 = var_13.currentturret;

          if(isDefined(var_26))
            var_20[var_20.size] = var_26;

          if(scripts\engine\trace::ray_trace_detail_passed(var_14, var_17, var_20, var_0)) {
            var_9 = 255;
            break;
          }
        }
      }
    }

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_83F31F44A6E5034F0158AF93805B050A93B04EBF05054A9EA938EF836873E8E235("_encstr_8E601037C8FB3D6B4782C3ABF204F2B395E3"))
      var_9 = var_9 | _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36("_encstr_8E601037C8FB3D6B4782C3ABF204F2B395E3", var_8);

    var_8 updatesixthsensevfx(var_9);
  }
}

sixthsense_think() {
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

setsixthsense() {
  if(getdvarint("_encstr_81F018A363AAE3D7DA9413CCC96FB2F5B3F2613058013322D9E8", 0) == 1) {
    return;
  }
  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = self;
}

unsetsixthsense() {
  thread health_reduction();
}

health_reduction() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("_encstr_8648116DEDDDF844EF41406A1BF3EE10B553DB");
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = undefined;
  waitframe();
  updatesixthsensevfx(0);
}

setenhancedsixthsense() {}

unsetenhancedsixthsense() {}

updatesixthsensevfx(var_0) {
  self setclientomnvar("_encstr_8F090D605A191B594785485C94BFE3", var_0);
}

roof_rpg_covers(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388)
    return 2;
  else if(var_5 >= 0.5)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  else if(var_5 >= 0.5)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  else if(var_5 >= -0.707107)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  else
    return 16;
}

markassixthsensesource(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8382178DF940BBD87E671F5341ABA1ED0803079AD0806A325D");
  self endon("_encstr_8382178DF940BBD87E671F5341ABA1ED0803079AD0806A325D");
  var_1 = var_0 getentitynumber();
  self.sixthsensesource[var_1] = 1;
  var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["_encstr_AD75063D571AE108"], 10);
  self.sixthsensesource[var_1] = 0;
}

setcamoelite() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");

  for(;;) {
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isDefined(var_4) || !var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_4.team == self.team) {
        continue;
      }
      if(var_4 scripts\mp\utility\perk::_hasperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA")) {
        continue;
      }
      var_5 = self.origin - var_4.origin;
      var_6 = anglesToForward(var_4 getplayerangles());
      var_7 = vectordot(var_5, var_6);

      if(var_7 <= 0) {
        continue;
      }
      var_8 = vectorNormalize(var_5);
      var_9 = vectorNormalize(var_6);
      var_7 = vectordot(var_8, var_9);

      if(var_7 < 12) {
        continue;
      }
      var_0++;
      var_10 = var_4 getEye();
      var_11 = self getEye();

      if(scripts\engine\trace::ray_trace_passed(var_10, var_11, self, scripts\engine\trace::create_default_contents(1))) {
        var_2 = 1;
        break;
      }

      if(var_0 >= 10) {
        waitframe();
        var_0 = 0;
      }
    }

    updatecamoeliteoverlay(var_2);
    waitframe();
  }
}

updatecamoeliteoverlay(var_0) {}

unsetcamoelite() {}

setcarepackage() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("_encstr_85B5101FA940A47EE093911F1E232E68F880", 0, 0, self);
}

unsetcarepackage() {}

setuav() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("_encstr_851904B59B34", 0, 0, self);
}

unsetuav() {}

setjuiced(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B6C10D1378B7022CB630BFD76029F4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.isjuiced = 1;
  self.movespeedscaler = 1.25;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\mp\utility\perk::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  thread unsetjuicedonmatchend();

  if(!isDefined(var_0))
    var_0 = 10;

  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {}

  wait(var_0);
  unsetjuiced();
}

unsetjuiced(var_0) {
  if(!isDefined(var_0)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"))
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::removeperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::removeperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\mp\utility\perk::removeperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::removeperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::removeperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  self.isjuiced = undefined;

  if(!isai(self)) {}

  self notify("_encstr_B6C10D1378B7022CB630BFD76029F4");
}

unsetjuicedonride() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B6C10D1378B7022CB630BFD76029F4");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B6C10D1378B7022CB630BFD76029F4");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_91D70BC8AF032B0F1B734F731A");
  thread unsetjuiced(1);
}

unsetjuicedonmatchend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B6C10D1378B7022CB630BFD76029F4");
  level scripts\engine\utility::_id_143A5("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739", "_encstr_9B1D0BC7932875276230426AA1");
  thread unsetjuiced();
}

hasjuiced() {
  return isDefined(self.isjuiced);
}

setcombathigh() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A35711BD66C7A1F9C12A58401266A158C7174B");
  level endon("_encstr_A3AF090768A9910F4118EF");
  self.damageblockedtotal = 0;

  if(level.splitscreen) {
    var_0 = 56;
    var_1 = 21;
  } else {
    var_0 = 112;
    var_1 = 32;
  }

  if(isDefined(self.juicedtimer))
    self.juicedtimer destroy();

  if(isDefined(self.juicedicon))
    self.juicedicon destroy();

  self.combathighoverlay = newclienthudelem(self);
  self.combathighoverlay.x = 0;
  self.combathighoverlay.y = 0;
  self.combathighoverlay.alignx = "_encstr_A5AD056A019C63";
  self.combathighoverlay.aligny = "_encstr_AC190479FF92";
  self.combathighoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.combathighoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.combathighoverlay setshader("_encstr_B25813D8DB5B982CD1342DB31AD7F667AC271B58F2", 640, 480);
  self.combathighoverlay.sort = -10;
  self.combathighoverlay.archived = 1;
  self.combathightimer = scripts\mp\hud_util::createtimer("_encstr_B8B209842D94DB0579ECFC", 1.0);
  self.combathightimer scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_0);
  self.combathightimer settimer(10.0);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = scripts\mp\hud_util::createicon("_encstr_8694156ECA8217E0A9731878D7D0B95B9AB4EB79257AFD", var_1, var_1);
  self.combathighicon.alpha = 0;
  self.combathighicon scripts\mp\hud_util::setparent(self.combathightimer);
  self.combathighicon scripts\mp\hud_util::setpoint("_encstr_A146079E6DF9115CFD", "_encstr_AC190439DF9A");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0.0;
  self.combathighoverlay fadeovertime(1.0);
  self.combathighicon fadeovertime(1.0);
  self.combathighoverlay.alpha = 1.0;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait 8;
  self.combathighicon fadeovertime(2.0);
  self.combathighicon.alpha = 0.0;
  self.combathighoverlay fadeovertime(2.0);
  self.combathighoverlay.alpha = 0.0;
  self.combathightimer fadeovertime(2.0);
  self.combathightimer.alpha = 0.0;
  wait 2;
  self.damageblockedtotal = undefined;
  scripts\mp\utility\perk::removeperk("_encstr_9949151BA8E3FE87312164715099578515C8F322D84F74");
}

unsetcombathighondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A35711BD66C7A1F9C12A58401266A158C7174B");
  self waittill("_encstr_AD75063D571AE108");
  thread scripts\mp\utility\perk::removeperk("_encstr_9949151BA8E3FE87312164715099578515C8F322D84F74");
}

unsetcombathighonride() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A35711BD66C7A1F9C12A58401266A158C7174B");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread scripts\mp\utility\perk::removeperk("_encstr_9949151BA8E3FE87312164715099578515C8F322D84F74");
      break;
    }
  }
}

unsetcombathigh() {
  self notify("_encstr_A35711BD66C7A1F9C12A58401266A158C7174B");
  self.combathighoverlay destroy();
  self.combathighicon destroy();
  self.combathightimer destroy();
}

setlightarmor() {
  scripts\mp\lightarmor::setlightarmorvalue(self, 150);
}

unsetlightarmor() {
  scripts\mp\lightarmor::lightarmor_unset(self);
}

setrevenge() {
  self notify("_encstr_8A200C9BA3F60E92B23B2B9BB356");
  waitframe();

  if(!isDefined(self.lastkilledby)) {
    return;
  }
  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }
  var_0 = spawnStruct();
  var_0.showto = self;
  var_0.icon = "_encstr_99A2148DB7DA38C237DC382D373B7DC9B2D995DC9D2B";
  var_0.offset = (0, 0, 64);
  var_0.width = 10;
  var_0.height = 10;
  var_0.archived = 0;
  var_0.delay = 1.5;
  var_0.constantsize = 0;
  var_0.pintoscreenedge = 1;
  var_0.fadeoutpinnedicon = 0;
  var_0.is3d = 0;
  self.revengeparams = var_0;
  self.lastkilledby thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0.showto, var_0.icon, var_0.offset, undefined, undefined, undefined, var_0.delay);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

watchrevengedeath() {
  self endon("_encstr_8A200C9BA3F60E92B23B2B9BB356");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self.lastkilledby;

  for(;;) {
    var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay);
  }
}

watchrevengekill() {
  self endon("_encstr_8A200C9BA3F60E92B23B2B9BB356");
  self waittill("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");
  self notify("_encstr_8A200C9BA3F60E92B23B2B9BB356");
}

watchrevengedisconnected() {
  self endon("_encstr_8A200C9BA3F60E92B23B2B9BB356");
  self.lastkilledby waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8A200C9BA3F60E92B23B2B9BB356");
}

watchstoprevenge() {
  var_0 = self.lastkilledby;
  self waittill("_encstr_8A200C9BA3F60E92B23B2B9BB356");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3, var_2 in var_0.entityheadicons) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 destroy();
  }
}

watchrevengevictimdisconnected() {
  var_0 = self.objidfriendly;
  var_1 = self.lastkilledby;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8A200C9BA3F60E92B23B2B9BB356");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_1.entityheadicons) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 destroy();
  }
}

unsetrevenge() {
  self notify("_encstr_8A200C9BA3F60E92B23B2B9BB356");
}

setphaseslide() {
  self.canphaseslide = 1;
}

unsetphaseslide() {
  self.canphaseslide = 0;
}

setteleslide() {
  self.canteleslide = 1;
}

unsetteleslide() {
  self.canteleslide = 0;
}

setphaseslashrephase() {
  self.hasrephase = 1;
}

unsetphaseslashrephase() {
  self.hasrephase = 0;
}

setphasefall() {}

unsetphasefall() {}

setextenddodge() {}

unsetextenddodge() {}

setauraquickswap() {
  scripts\mp\archetypes\archassault::auraquickswap_run();
}

unsetauraquickswap() {}

setauraspeed() {}

unsetauraspeed() {}

setmarktargets() {
  scripts\mp\perks\perk_mark_targets::marktarget_init();
}

unsetmarktargets() {}

setbatterypack() {}

unsetbatterypack() {}

setcamoclone() {}

unsetcamoclone() {}

setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
}

unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
}

setscorestreakpack() {}

unsetscorestreakpack() {}

setsuperpack() {}

unsetsuperpack() {}

setspawncloak() {}

unsetspawncloak() {}

setdodgedefense() {
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_BD740DAC17E81747F57182BA38469F", 0.5, 0, ::dodgedefenseignorefunc);
}

unsetdodgedefense() {
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_BD740DAC17E81747F57182BA38469F", 0);
}

dodgedefenseignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!(isDefined(var_2.dodging) && var_2.dodging && var_2 scripts\mp\utility\perk::_hasperk("_encstr_864E18A373482BFBE0426B73E901E01350AFE1FA9548A238835D")))
    return 1;

  return 0;
}

setdodgewave() {}

unsetdodgewave() {}

setgroundpound() {}

unsetgroundpound() {}

setmeleekill() {
  self giveweapon("_encstr_AC49113F207BFFC27B16AB62FF1BFB831E68D3");
  self assignweaponmeleeslot("_encstr_AC49113F207BFFC27B16AB62FF1BFB831E68D3");

  if(self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")) {
    var_0 = self getcurrentweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    self giveweapon("_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9");

    if(var_0.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9");

      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
        self.spawnweaponobj = getcompleteweaponname("_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9");
        self setspawnweapon(self.spawnweaponobj);
      }
    }
  }
}

unsetmeleekill() {
  scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_AC49113F207BFFC27B16AB62FF1BFB831E68D3");

  if(self hasweapon("_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9")) {
    var_0 = self.currentweapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9");
    self giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

    if(var_0.basename == "_encstr_841413F97F2A41032BCBEB83307503C4E0215775C9")
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  }
}

setpowercell() {}

unsetpowercell() {}

sethardline() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
  self.hardlineactive["_encstr_A1F308589BCD96CD476E"] = 0;
}

watchhardlineassists() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");
}

unsethardline() {
  self.hardlineactive = undefined;
  self notify("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");
}

setoverclock() {}

unsetoverclock() {}

setovercharge() {
  thread _calloutmarkerping_handleluinotify_added::_id_1313D("_encstr_B6E70E6310C157539DCDAFBBD33E8A95", 1);
}

unsetovercharge() {
  thread _calloutmarkerping_handleluinotify_added::_id_1313D("_encstr_B6E70E6310C157539DCDAFBBD33E8A95", 0);
}

setsupersprintenhanced() {
  thread watchforsupersprintenhancedused();
}

unsetsupersprintenhanced() {
  self notify("_encstr_912B19B8AB63A1E131A3CF5D7AE9318BD11338A1C368799D1A4FCD");
}

watchforsupersprintenhancedused() {
  self endon("_encstr_912B19B8AB63A1E131A3CF5D7AE9318BD11338A1C368799D1A4FCD");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0;

  while(2000 > var_0) {
    waitframe();

    if(isDefined(self) && istrue(self issupersprinting())) {
      var_1 = level.frameduration;
      var_0 = var_0 + var_1;
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

settracker() {}

unsettracker() {}

setpersonaltrophy() {}

unsetpersonaltrophy() {}

setdisruptorpunch() {}

unsetdisruptorpunch() {}

setequipmentping() {
  if(!scripts\mp\utility\game::lpcfeaturegated())
    level.equipmentpingactive = 1;
}

unsetequipmentping() {}

setruggedeqp() {}

unsetruggedeqp() {}

feedbackruggedeqp(var_0, var_1, var_2, var_3) {}

setmanatarms() {}

unsetmanatarms() {}

setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

outlinekillstreaks_enablemarksafterprematch() {
  self endon("_encstr_862617A3AD5FDD13C8A0E8F849A8AA5A630D55DF452D8561B2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 1000000;

  if(level.gametype == "_encstr_B607038AAB")
    var_0 = 1000;

  if(isDefined(self)) {
    self enableentitymarks("_encstr_85CE0B9770B02C73A1760F06D2", var_0);
    self enableentitymarks("_encstr_A1940FD903FBCF747BC05AA328652FEF30", var_0);
    self.perkoutlinekillstreaksset = 1;
    _calloutmarkerping_predicted_timeout::_id_14130(self);
  }
}

unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("_encstr_85CE0B9770B02C73A1760F06D2");
    self disableentitymarks("_encstr_A1940FD903FBCF747BC05AA328652FEF30");
    self.perkoutlinekillstreaksset = undefined;
  }

  _calloutmarkerping_predicted_timeout::_id_14130(self);
  self notify("_encstr_862617A3AD5FDD13C8A0E8F849A8AA5A630D55DF452D8561B2");
}

setengineer() {
  thread engineer_enablemarksafterprematch();
}

engineer_enablemarksafterprematch() {
  self endon("_encstr_9A960E077D9A97B9BFF84FEBD50BAAE8");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 1000000;

  if(level.gametype == "_encstr_B607038AAB")
    var_0 = 1000;

  if(isDefined(self)) {
    self enableentitymarks("_encstr_BE8F0A272F9B2BE97268AE8B", var_0);
    self.perkengineerset = 1;
  }
}

unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("_encstr_BE8F0A272F9B2BE97268AE8B");
    self.perkengineerset = undefined;
  }

  self notify("_encstr_9A960E077D9A97B9BFF84FEBD50BAAE8");
}

setnoscopeoutline() {
  if(!isDefined(level.noscopeoutlinesetnotifs)) {
    level.noscopeoutlinesetnotifs = [];
    level.noscopeoutlineunsetnotifs = [];
    level thread processnoscopeoutlinesetnotifs();
    level thread processnoscopeoutlineunsetnotifs();
  }

  level.noscopeoutlinesetnotifs[level.noscopeoutlinesetnotifs.size] = self;
}

unsetnoscopeoutline() {
  level.noscopeoutlineunsetnotifs[level.noscopeoutlineunsetnotifs.size] = self;
}

processnoscopeoutlinesetnotifs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(level.noscopeoutlinesetnotifs.size > 0) {
      var_0 = 0;

      while(isDefined(level.noscopeoutlinesetnotifs[var_0])) {
        level notify("_encstr_8AEC13372BE8F5B97BB9C6B70E597BEA3AB19673AC", level.noscopeoutlinesetnotifs[var_0]);
        level.noscopeoutlinesetnotifs[var_0] notify("_encstr_8AEC13372BE8F5B97BB9C6B70E597BEA3AB19673AC");
        var_0++;
        waitframe();
      }

      level.noscopeoutlinesetnotifs = [];
      continue;
    }

    waitframe();
  }
}

processnoscopeoutlineunsetnotifs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(level.noscopeoutlineunsetnotifs.size > 0) {
      var_0 = 0;

      while(isDefined(level.noscopeoutlineunsetnotifs[var_0])) {
        level notify("_encstr_BEF2159B701BDF5441A508C2612863A102651301DFE378", level.noscopeoutlineunsetnotifs[var_0]);
        level.noscopeoutlineunsetnotifs[var_0] notify("_encstr_BEF2159B701BDF5441A508C2612863A102651301DFE378");
        var_0++;
        waitframe();
      }

      level.noscopeoutlineunsetnotifs = [];
      continue;
    }

    waitframe();
  }
}

setcloak() {}

unsetcloak() {}

setwalllock() {}

unsetwalllock() {}

setrush() {}

unsetrush() {
  self notify("_encstr_86B01178BAB52F3B6F43B0B97AA7A3A91C2220");
  self.speedonkillmod = undefined;
}

sethover() {
  thread runhover();
}

unsethover() {}

setmomentum() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self.momentumspeedincrease = 0;
  scripts\mp\weapons::updatemovespeedscale();

  for(;;) {
    self waittill("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");
    thread _id_11CD0();
  }
}

unsetmomentum() {
  self notify("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self.momentumspeedincrease = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

_id_11CD0() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self.momentumspeedincrease = self.momentumspeedincrease + 0.04;
  self.momentumspeedincrease = min(self.momentumspeedincrease, 0.12);
  scripts\mp\weapons::updatemovespeedscale();
  thread _id_11CCF();
}

_id_11CCF() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_A2E015B8580B20600C5B8D09326D56BF9B8F43B09F408A");
  self endon("_encstr_A2E015B8580B20600C5B8D09326D56BF9B8F43B09F408A");
  wait 5.0;
  self.momentumspeedincrease = 0;
  scripts\mp\weapons::updatemovespeedscale();
}

setscavengereqp() {}

unsetscavengereqp() {}

setspawnview() {}

unsetspawnview() {
  foreach(var_1 in level.players)
  var_1 notify("_encstr_88320E3D0812EF3B8BEA14C2E357A7A7");
}

setheadgear(var_0) {}

unsetheadgear() {}

setftlslide() {}

unsetftlslide() {}

setimprovedprone() {}

unsetimprovedprone() {}

setghost() {
  thread startgpsjammer();
}

unsetghost() {
  thread removegpsjammer();
}

setsupportkillstreaks() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BD4C19FA831517AAE113A4BC3F40726FB77813506860CFA2D063A4");

  if(!isDefined(self.streakdata.streaks[1])) {
    foreach(var_1 in self.streakdata.streaks["_encstr_85190CAB8B3971B0A4DB2BCAC253"])
    var_1.earned = 0;
  }
}

unsetsupportkillstreaks() {
  self notify("_encstr_914B18953723FA9BD5C138DE27A3FA5B5A63B1B98E275658B6DC");
}

setoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = 0.98;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = undefined;
}

setcloakaerial() {}

unsetcloakaerial() {}

setspawnradar() {
  self.hasspawnradar = 1;
}

unsetspawnradar() {
  self.hasspawnradar = 1;
}

setimprovedmelee() {}

unsetimprovedmelee() {}

setthief() {}

unsetthief() {}

setadsawareness() {
  thread runadsawareness();
  self setscriptablepartstate("_encstr_85331210C739A1990367379D3FE9F7A99627F050", "_encstr_8B1608EC43B8D647A113");
}

runadsawareness() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A22612C3509BFDD32F01CF7F9FD77B353099FACA");
  self.awarenessradius = 256;
  self.awarenessqueryrate = 2.0;
  thread awarenessmonitorstance();

  for(;;) {
    wait(self.awarenessqueryrate);
    var_0 = scripts\common\utility::playersinsphere(self.origin, self.awarenessradius);

    foreach(var_2 in level.players) {
      if(var_2.team == self.team) {
        continue;
      }
      if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532")) {
        continue;
      }
      if(var_2 isonground() && !var_2 issprinting() && !var_2 iswallrunning() && !var_2 issprintsliding()) {
        continue;
      }
      thread playincomingwarning(var_2);
    }
  }
}

playincomingwarning(var_0) {
  self setscriptablepartstate("_encstr_85331210C739A1990367379D3FE9F7A99627F050", "_encstr_93BA0B7B2176EB81D88B0403B3");
  self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  var_0 playsoundtoplayer("_encstr_A38D122140F05343EFE3BF687F1DDFB0775BD58F", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("_encstr_85331210C739A1990367379D3FE9F7A99627F050", "_encstr_8B1608EC43B8D647A113");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

      if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive())
        var_0 playsoundtoplayer("_encstr_A38D122140F05343EFE3BF687F1DDFB0775BD58F", self);
    }
  }
}

awarenessmonitorstance() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = self getstance();
    var_1 = self getvelocity();

    switch (var_0) {
      case "_encstr_A5AD069B231F0BAF":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2.0;
        break;
      case "_encstr_B13D076BED70539F23":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1.0;
        break;
      case "_encstr_922406F1A6FD5E05":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait 0.01;
  }
}

awarenessaudiopulse() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_817B0F63F08F52376984594295D087DA1F");

  for(;;) {
    playsoundatpos(self.origin + (0, 0, 5), "_encstr_A38D122140F05343EFE3BF687F1DDFB0775BD58F");
    wait 2.0;
  }
}

unsetadsawareness() {
  self notify("_encstr_A22612C3509BFDD32F01CF7F9FD77B353099FACA");
  self setscriptablepartstate("_encstr_85331210C739A1990367379D3FE9F7A99627F050", "_encstr_8B1608EC43B8D647A113");
}

setrearguard() {}

unsetrearguard() {
  self.hasrearguardshield = undefined;
}

setsolobuddyboost() {
  self.hassolobuddyboost = 1;
}

unsetsolobuddyboost() {
  self.hassolobuddyboost = undefined;
}

setthrowingknifemelee() {
  self giveweapon(self._id_13B5C);
  self assignweaponmeleeslot(self._id_13B5C);
  thread watchthrowingknifescavenge();

  if(self._id_13B5C == "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB")
    thread _id_144FD();
  else if(self._id_13B5C == "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9")
    thread _id_144FC();
}

unsetthrowingknifemelee() {
  if(isDefined(self._id_13B5C) && self hasweapon(self._id_13B5C))
    self takeweapon(self._id_13B5C);

  self notify("_encstr_8D2022231BA5974428F14441FF600AB7DB7379DBA0866F3BB0CD4F0B8538173F6849E262");

  if(isDefined(self._id_13B5C) && self._id_13B5C == "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB")
    votesys_think();
  else if(isDefined(self._id_13B5C) && self._id_13B5C == "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9")
    votesys_new();
}

_id_144FD() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D2022231BA5974428F14441FF600AB7DB7379DBA0866F3BB0CD4F0B8538173F6849E262");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(var_0.basename == "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB") {
      self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A3BD0DE135515883DADFDF8DFF02DD");
      self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
      self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
    }
  }
}

votesys_think() {
  self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
}

_id_144FC() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D2022231BA5974428F14441FF600AB7DB7379DBA0866F3BB0CD4F0B8538173F6849E262");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(var_0.basename == "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9") {
      self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_8FC80EB2B1CA3647E4D2365ACD4B99CA");
      self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
      self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
    }
  }
}

votesys_new() {
  self setscriptablepartstate("_encstr_B87B13377AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
}

watchthrowingknifescavenge() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D2022231BA5974428F14441FF600AB7DB7379DBA0866F3BB0CD4F0B8538173F6849E262");

  for(;;) {
    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_0);

    if(scripts\mp\utility\weapon::isthrowingknife(var_0)) {
      var_1 = self getammocount(var_0);

      if(var_1 == 0) {
        if(isDefined(self._id_13B5C) && self hasweapon(self._id_13B5C))
          self takeweapon(self._id_13B5C);
      }

      while(self getammocount(var_0) == 0)
        wait 0.05;

      self giveweapon(self._id_13B5C);
      self assignweaponmeleeslot(self._id_13B5C);
    }
  }
}

setbulletoutline() {
  self.bulletoutline = spawnStruct();
  self.bulletoutline.player = self;
  self.bulletoutline.enemies = [];
  self.bulletoutline.enemyids = [];
  self.bulletoutline.enemyendtimes = [];
  self.bulletoutline thread watchbulletoutline();
  self.bulletoutline thread watchbulletoutlinecleanup();
}

unsetbulletoutline() {
  self notify("_encstr_A18513FB1A8069ABF203F1CBDD4819AB33A941D337");
  self.bulletoutline = undefined;
}

watchbulletoutline() {
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.player endon("_encstr_A18513FB1A8069ABF203F1CBDD4819AB33A941D337");

  while(isDefined(self.player)) {
    var_0 = gettime();

    foreach(var_3, var_2 in self.enemies) {
      if(!isDefined(var_2)) {
        bulletoutlineremoveenemy(undefined, var_3);
        continue;
      }

      if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
        bulletoutlineremoveenemy(var_2, var_3);
        continue;
      }

      if(var_0 >= self.enemyendtimes[var_3])
        bulletoutlineremoveenemy(var_2, var_3);
    }

    waitframe();
  }
}

watchbulletoutlinecleanup() {
  self.player scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_A18513FB1A8069ABF203F1CBDD4819AB33A941D337");

  foreach(var_2, var_1 in self.enemies) {
    if(isDefined(var_1))
      bulletoutlineremoveenemy(var_1, var_2);
  }
}

bulletoutlineaddenemy(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_4 = gettime() + var_1 * 1000;
  self.enemies[var_3] = var_0;

  if(!isDefined(self.enemyids[var_3]))
    self.enemyids[var_3] = scripts\mp\utility\outline::outlineenableforplayer(var_0, self.player, "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_960D052F10EBF0");

  if(!isDefined(self.enemyendtimes[var_3]) || !isDefined(var_2) || var_2)
    self.enemyendtimes[var_3] = var_4;
}

bulletoutlineremoveenemy(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0 getentitynumber();

  self.enemies[var_1] = undefined;
  self.enemyendtimes[var_1] = undefined;

  if(isDefined(var_0))
    scripts\mp\utility\outline::outlinedisable(self.enemyids[var_1], var_0);

  self.enemyids[var_1] = undefined;
}

bulletoutlinecheck(var_0, var_1, var_2, var_3) {
  if(!(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799" || var_3 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_3 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_3 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return;
  }
  var_4 = var_0;

  if(isDefined(var_0.owner))
    var_4 = var_0.owner;

  var_5 = var_1;

  if(isDefined(var_1.owner))
    var_5 = var_1.owner;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_4, var_5))) {
    return;
  }
  if(isPlayer(var_0) && isPlayer(var_1) && scripts\mp\utility\outline::outlineoccluded(var_0 getEye(), var_1 getEye())) {
    return;
  }
  if(isDefined(var_0.bulletoutline) && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
    var_0.bulletoutline bulletoutlineaddenemy(var_1, 1);

  if(isDefined(var_1.bulletoutline) && !var_0 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
    var_1.bulletoutline bulletoutlineaddenemy(var_0, 2.0, 0);
}

markempsignatures(var_0, var_1) {
  if(!isDefined(var_0.empmarked))
    var_0.empmarked = [];

  if(isDefined(var_0.empmarked[var_1]) && var_0.empmarked[var_1] == "_encstr_930B07BB1B6B3854FF") {
    return;
  }
  var_0.empmarked[var_1] = "_encstr_930B07BB1B6B3854FF";
  thread empvfx(var_0, var_1);
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_BA0A0A568DF0E932D0B3CBFB");
  var_0.empmarked[var_1] = undefined;
}

empvfx(var_0, var_1) {
  var_2 = ["_encstr_A9B30EA6BECD347BAE3623569CBEC95A", "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156", "_encstr_AFDD09A6FA864B1CBEC996", "_encstr_AFDD09A6FA864B1CBEB156", "_encstr_8EEC09159F6238030BFA23", "_encstr_83190BED4757A3B3B20C5E83E0", "_encstr_A1190BD4FABB9396DC47EB8DAC"];
  var_0.empmarked[var_1] = undefined;
}

startgpsjammer() {
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isai(self)) {
    while(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
      waitframe();
  }

  if(level.minspeedsq == 0) {
    return;
  }
  if(level.timeperiod < 0.05) {
    return;
  }
  self.timesincelastweaponfire = 0.0;
  thread ghostadvanceduavwatcher();

  if(scripts\mp\utility\game::unset_relic_grounded() && getdvarint("_encstr_A32B1DC3CBC64AA7C8E03D025B31AF52916BF7A7B9E38255E1A8354B90D0EF", 1))
    thread _id_11D12();
  else {
    self setplayerghost(1);
    self._id_122FE = 1;
  }

  self.timesincelastweaponfire = 0.0;

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0);

    if(scripts\mp\class::vehicle_checkpiggybackexploit(var_0)) {
      continue;
    }
    doghostweaponfired();
  }
}

doghostweaponfired() {
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setplayerghost(0);
  self.playbattlechattersound = 1;
  thread checkforghostweaponfire();

  while(self.timesincelastweaponfire < 3.0) {
    wait(level.timeperiod);
    self.timesincelastweaponfire = self.timesincelastweaponfire + level.timeperiod;
  }

  self notify("_encstr_87720F9DD0DE6E8EBE9395DCD1B79CB219");
  self.timesincelastweaponfire = 0.0;

  if(self._id_122FE)
    self setplayerghost(1);

  self.playbattlechattersound = undefined;
}

checkforghostweaponfire() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self endon("_encstr_87720F9DD0DE6E8EBE9395DCD1B79CB219");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    self.timesincelastweaponfire = 0.0;
  }
}

ghostadvanceduavwatcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  var_0 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(var_0) {
    self setplayeradvanceduavdot(1);
    return;
  }

  for(;;) {
    if(level.teambased) {
      var_1 = sat_setup_interactions();

      if(var_1) {
        self setplayeradvanceduavdot(1);
        self setplayerghost(0);

        while(var_1) {
          waitframe();
          var_1 = sat_setup_interactions();
        }

        self setplayerghost(1);
        self setplayeradvanceduavdot(0);
      }
    } else {
      foreach(var_3 in level.players) {
        if(var_3 == self) {
          continue;
        }
        if(istrue(level.activeadvanceduavs[var_3.guid]) && level.activeadvanceduavs[var_3.guid] > 0) {
          self setplayeradvanceduavdot(1);
          self setplayerghost(0);

          while(istrue(level.activeadvanceduavs[var_3.guid]) && level.activeadvanceduavs[var_3.guid] > 0)
            level waittill("_encstr_8B540B6DB903360BFAAAF85852");

          self setplayerghost(1);
          self setplayeradvanceduavdot(0);
        }
      }
    }

    waitframe();
  }
}

sat_setup_interactions() {
  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(level.audio_heli_end_fade_out) || !isDefined(level.activeadvanceduavs))
    return var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

  if(istrue(var_1) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
    var_2 = 0;

    foreach(var_5, var_4 in level.squaddata[self.team])
    var_2 = var_2 + level.activeadvanceduavs[self.team + var_5];

    var_0 = level.audio_heli_end_fade_out - var_2 > 0;
  } else
    var_0 = level.audio_heli_end_fade_out - level.activeadvanceduavs[self.team] > 0;

  return var_0;
}

_id_11D12() {
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_93571B832BC9B5BEECD0DBB93AAF37E0ACB232AFE8D04EACB9A1DB8D23", 190);
  self._id_122FE = 0;
  var_1 = 0;

  for(;;) {
    var_2 = self.super;
    var_3 = isDefined(var_2) && isDefined(var_2.staticdata.ref) && isDefined(var_2.usepercent);

    if(var_3 && var_2.staticdata.ref == "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D" && var_2.usepercent > 0 || isDefined(self.vehicle)) {
      if(!self._id_122FE) {
        self._id_122FE = 1;
        var_1 = 0;
        self setplayerghost(1);
      }

      if(var_1 && self._id_122FE) {
        self notify("_encstr_8FCF0D95372C2636957D9D34DBB9E8");
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    var_4 = self getvelocity();
    var_5 = abs(var_4[0]) + abs(var_4[1]) + abs(var_4[2]);

    if(var_5 >= var_0 && !self._id_122FE && !self isjumping() && !istrue(self.playbattlechattersound)) {
      self._id_122FE = 1;
      var_1 = 0;
      self setplayerghost(1);
    } else if(var_5 >= var_0 && var_1 && self._id_122FE) {
      self notify("_encstr_8FCF0D95372C2636957D9D34DBB9E8");
      var_1 = 0;
    } else if(var_5 < var_0 && self._id_122FE && !var_1) {
      thread _id_122FD();
      var_1 = 1;
    }

    waitframe();
  }
}

_id_122FD() {
  self endon("_encstr_8FCF0D95372C2636957D9D34DBB9E8");
  self endon("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(getdvarfloat("_encstr_8E8F19FBF30E826F1028C5CA83F99EFAE9097F2B6D203A0D301178", 2.0));

  if(!isDefined(self)) {
    return;
  }
  self._id_122FE = 0;
  self setplayerghost(0);
}

removegpsjammer() {
  self notify("_encstr_A15F110E5D8FD0AD1FB968D853F4BB2827C596");
  self setplayerghost(0);
  self._id_122FE = undefined;
  self setplayeradvanceduavdot(0);
}

setgroundpoundshield() {
  level._effect["_encstr_A94A197693DBBAB92328DE57B9C83586B4598DC8EB4B6B83161BE8"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
}

unsetgroundpoundshield() {
  self notify("_encstr_A1DE182FBA1FCFA3BA59873860316A748337449BF1834698B0C3");
}

groundpoundshield_onimpact(var_0) {
  thread groundpoundshield_raiseondelay();
}

groundpoundshield_raiseondelay() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_8722103FDE37BB9E7979BFDF609164229D7D");
  wait 0.25;
  groundpoundshield_raise();
}

groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield))
    thread groundpoundshield_lower(self.groundpoundshield);

  var_0 = self.origin + anglesToForward(self.angles) * 5;
  var_1 = self.angles + (0, 90, 0);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_B2511878FB60EF053D77FB3B230DE74F2E8A8CA1B8DFA019D045");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.angles = var_1;
  var_3 setModel("_encstr_AD8417DBA15F33A8952FB798830A4FD3B802323106528873DD");
  var_3.outlineid = scripts\mp\utility\outline::outlineenableforall(var_3, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_BE8F0A272F9B2BE97268AE8B");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4.angles = var_1;
  var_4 setModel("_encstr_A96617DDB2160EB7B9EB6E0D5A739D57164EC87D59DCF5BB5B");
  var_4.outlineid = scripts\mp\utility\outline::outlineenableforall(var_4, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_BE8F0A272F9B2BE97268AE8B");
  var_2.visfr = var_3;
  var_2.visen = var_4;
  var_2.owner = self;
  var_2 setCanDamage(1);
  var_2.health = 9999;
  var_2.shieldhealth = 210;
  self.groundpoundshield = var_2;
  var_5 = level.characters;

  foreach(var_7 in var_5) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(level.teambased && var_7.team == self.team) {
      var_4 hidefromplayer(var_7);
      continue;
    }

    var_3 hidefromplayer(var_7);
  }

  thread groundpoundshield_monitorjoinedteam(var_2);
  thread groundpoundshield_loweronleavearea(var_2);
  thread groundpoundshield_lowerontime(var_2, 3.25);
  thread groundpoundshield_loweronjump(var_2);
  thread groundpoundshield_deleteondisconnect(var_2);
  thread groundpoundshield_monitorhealth(var_2);
  thread groundpound_raisefx();
  return var_2;
}

groundpoundshield_lower(var_0) {
  self notify("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");

  if(!isDefined(var_0)) {
    return;
  }
  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_break(var_0) {
  self notify("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");

  if(!isDefined(var_0)) {
    return;
  }
  thread groundpoundshield_breakfx();
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_monitorhealth(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2)) {
      if(var_2 == self || var_2.team != self.team)
        var_0.shieldhealth = var_0.shieldhealth - var_1;
    }

    var_0.health = 9999;
    thread groundpoundshield_damagedfx(var_2, var_4, var_3);

    if(var_0.shieldhealth <= 0) {
      thread groundpoundshield_break(var_0);
      return;
    } else if(var_0.shieldhealth <= 105.0) {
      if(var_0.visfr.model != "_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305") {
        var_0.visfr setModel("_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305");
        scripts\mp\utility\outline::outlinerefresh(var_0.visfr);
      }

      if(var_0.visen.model != "_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305") {
        var_0.visen setModel("_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305");
        scripts\mp\utility\outline::outlinerefresh(var_0.visen);
      }
    }
  }
}

groundpoundshield_loweronjump(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
  var_1 = self isjumping();
  var_2 = undefined;

  for(;;) {
    var_2 = var_1;
    var_1 = self isjumping();

    if(!var_2 && var_1) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

groundpoundshield_lowerontime(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
  wait(var_1);
  thread groundpoundshield_lower(var_0);
}

groundpoundshield_loweronleavearea(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");

  while(isDefined(var_0)) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

groundpoundshield_deleteondisconnect(var_0) {
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_monitorjoinedteam(var_0) {}

groundpoundshield_deleteshield(var_0) {
  self notify("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
  scripts\mp\utility\outline::outlinedisable(var_0.visen.outlineid, var_0.visen);
  scripts\mp\utility\outline::outlinedisable(var_0.visfr.outlineid, var_0.visfr);
  var_0.visfr delete();
  var_0.visen delete();
  var_0 delete();
}

groundpound_raisefx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
}

groundpoundshield_lowerfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
}

groundpoundshield_damagedfx(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
  playFX(scripts\engine\utility::getfx("_encstr_A94A197693DBBAB92328DE57B9C83586B4598DC8EB4B6B83161BE8"), var_1, -1 * var_2);
  playsoundatpos(var_1, "_encstr_8A661119DCFA3786D2B21B46EBB4DAC185D88E");
  var_0 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A94E0F34D23A985D8D63AC1D6E477B9CDA");
}

groundpoundshield_breakfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_853E16B723101D826DF9EF9F9D05194858A9EDFF3EE8DEDA");
  self endon("_encstr_BA201FFF6B5855FA25B1B7D725DDD1B08011B58766580D928DC187B73173FAFC50");
}

setgroundpoundshock() {
  level._effect["_encstr_93301B0A33C8571DA831F7D575906A6B608942F13891FB167891CFDB1B"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level._effect["_encstr_AAF91C77E3D0DD42AD392F5F5D4559082829ECF1386880CA7659E7338DFC"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
}

unsetgroundpoundshock() {
  self notify("_encstr_AFD71737BE97DD1BB287572BB2E8C983C080B80FCDC8AE25E1");
}

groundpoundshock_onimpact(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_887112CE4EBDBA3723287B5DB932EBD537CD591D");
  self endon("_encstr_AFD71737BE97DD1BB287572BB2E8C983C080B80FCDC8AE25E1");
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_B1DF153B4EB7EAE62328BDEA37C826169BC8455ACA9381":
      var_2 = scripts\engine\utility::getfx("_encstr_93301B0A33C8571DA831F7D575906A6B608942F13891FB167891CFDB1B");
      var_1 = 144;
      break;
    case "_encstr_BADF15EC27DB5DE69182F6EAB9C889B0E6232AD2AC4E4C":
      var_2 = scripts\engine\utility::getfx("_encstr_93301B0A33C8571DA831F7D575906A6B608942F13891FB167891CFDB1B");
      var_1 = 180;
      break;
    case "_encstr_95DF15ECE47B5DDC19A0B7ABE6463158DC4645A52B3919":
      var_2 = scripts\engine\utility::getfx("_encstr_AAF91C77E3D0DD42AD392F5F5D4559082829ECF1386880CA7659E7338DFC");
      var_1 = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(var_1, var_2);
  var_3 = undefined;

  if(level.teambased)
    var_3 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);
  else
    var_3 = level.characters;

  var_4 = var_1 * var_1;
  var_5 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 0, 0);

  foreach(var_7 in var_3) {
    if(lengthsquared(var_7 getEye() - self getEye()) > var_4) {
      continue;
    }
    var_8 = physics_raycast(self getEye(), var_7 getEye(), var_5, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }
    thread groundpoundshock_empplayer(var_7);
  }
}

groundpoundshock_empplayer(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread scripts\mp\gamescore::trackdebuffassistfortime(self, var_0, "_encstr_A5520F519B070DC0B7D87F73FE9F81D9A3", 3);
}

groundpoundshock_onimpactfx(var_0, var_1) {
  playFX(var_1, self.origin + (0, 0, 20), (0, 0, 1));
}

setgroundpoundboost() {}

unsetgroundpoundboost() {
  self notify("_encstr_851217E29EA21D385FDFE7C775E18DE5F8578B07B33BF348FB");
}

groundpoundboost_onimpact(var_0) {
  scripts\common\utility::set_doublejumpenergy(self energy_getmax(0));
}

setbattleslideshield() {
  level._effect["_encstr_BD8C19466F09A38441694BA728B973AAEBF54D7FD8418ADDE9E067"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  thread battleslideshield_monitor();
}

unsetbattleslideshield() {
  self notify("_encstr_AFA61829914333A09FBA0A971FED2F43E78BB3C36663B852CA6B");
}

battleslideshield_monitor() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self notify("_encstr_815B1A7D3FFB85A0AD1A58F0FF95613382B7E9892FB2C0F8C9AB20AB");
  self endon("_encstr_815B1A7D3FFB85A0AD1A58F0FF95613382B7E9892FB2C0F8C9AB20AB");

  for(;;) {
    self waittill("_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3");
    thread battleslideshield_raise();
  }
}

battleslideshield_monitorhealth(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread battleslideshield_damagedfx(var_0, var_2, var_4, var_3);

    if(var_0.health <= 0) {
      thread battleslideshield_break(var_0);
      var_0 delete();
      continue;
    }

    if(var_0.health <= 125.0) {
      if(var_0.model != "_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305")
        var_0 setModel("_encstr_A3F3188B32E76720CD0FAF9151B518AD8FDB61368A3F1169A305");

      continue;
    }

    if(var_0.model != "_encstr_99F214EEAC8583F6B9EB9BA1D2B976ABB09391D7BBDA")
      var_0 setModel("_encstr_99F214EEAC8583F6B9EB9BA1D2B976ABB09391D7BBDA");
  }
}

battleslideshield_raise() {
  if(isDefined(self.battleslideshield))
    thread battleslideshield_lower(self.battleslideshield);

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 setModel("_encstr_99F214EEAC8583F6B9EB9BA1D2B976ABB09391D7BBDA");
  var_0 setCanDamage(1);
  var_0.health = 250;
  var_0 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (30, 0, 0), (0, 90, 0));
  var_0 show();
  self.battleslideshield = var_0;
  thread battleslideshield_killonjumpfall(var_0);
  thread battleslideshield_killonsprint(var_0);
  thread battleslideshield_killontime(var_0);
  thread battleslideshield_unlinkonstop(var_0);
  thread battleslideshield_monitorhealth(var_0);
  thread battleslideshield_killondeathdisconnectunset(var_0);
  thread battleslideshield_raisefx(var_0);
  return var_0;
}

battleslideshield_lower(var_0) {
  self notify("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");

  if(!isDefined(var_0)) {
    return;
  }
  thread battleslideshield_lowerfx(var_0);
  var_0 delete();
}

battleslideshield_killondeathdisconnectunset(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  var_0 delete();
}

battleslideshield_killonjumpfall(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!self isonground()) {
      var_0 delete();
      self notify("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
      return;
    }

    waitframe();
  }
}

battleslideshield_killonsprint(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B");
  var_0 delete();
  self notify("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
}

battleslideshield_loweronleavearea(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread battleslideshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

battleslideshield_lowerontime(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 3.5;
  thread battleslideshield_lower(var_0);
}

battleslideshield_unlink(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 unlink();
  self notify("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
  thread battleslideshield_lowerontime(var_0);
  thread battleslideshield_loweronleavearea(var_0);
  self notify("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
}

battleslideshield_killontime(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_A67411E610AB48B57381E0E01A8F6B462FA6E5");
  wait 0.75;
  var_0 delete();
  self notify("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
}

battleslideshield_unlinkonstop(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  self endon("_encstr_8B641989163AA3D8CAD4B1B446CA4D3496AC1B91F5AE9BB12DB96D");
  self endon("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_A67411E610AB48B57381E0E01A8F6B462FA6E5");

  for(;;) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(var_0);
      return;
    }

    waitframe();
  }
}

battleslideshield_break(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  thread battleslideshield_breakfx(var_0);
  self notify("_encstr_83A116BBF3156B4408770D5489D0A36263030B3B27359204");
}

battleslideshield_raisefx(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  var_0 endon("_encstr_AD75063D571AE108");
}

battleslideshield_lowerfx(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  var_0 endon("_encstr_AD75063D571AE108");
}

battleslideshield_damagedfx(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A345120E2193CB91176138282A2F3F2323DB05FD");
  var_0 endon("_encstr_AD75063D571AE108");
  playFX(scripts\engine\utility::getfx("_encstr_BD8C19466F09A38441694BA728B973AAEBF54D7FD8418ADDE9E067"), var_2, -1 * var_3);
  playsoundatpos(var_2, "_encstr_8A661119DCFA3786D2B21B46EBB4DAC185D88E");
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A94E0F34D23A985D8D63AC1D6E477B9CDA");
}

battleslideshield_breakfx(var_0) {}

setbattleslideoffense() {}

unsetbattleslideoffense() {}

getbattleslideoffensedamage() {
  return 100;
}

setthruster() {
  level._effect["_encstr_A62E0E4B63BD0B13EB40BB338801DE83"] = loadfx("_encstr_A2F63F6BC133AE4CA04F0753E7D017E6D17B7693480C5F4268575450B5C05A7310913A0A53653E3BF8014734B993E3272DAE5262F9BEEBB9301B74216B2021AB56");
  level._effect["_encstr_842E0E835310038E153DBA9EA9882F22"] = loadfx("_encstr_87F63F9DCC3CE5D2BBDC79B17BC92BF2D607F2E0B7BBB293CDBCE8349C5DE6A3FA26B185371D97D99987FA1DD09C5D9B47F5133658E63AF54EC2195AAECDFA5937");
  thrusterwatchdoublejump();
}

unsetthruster() {
  if(isDefined(self.thrustfxent))
    self.thrustfxent delete();

  self notify("_encstr_848B0F1CB9F833BF4DD1A3793BA867EF60");
}

thrusterwatchdoublejump() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_848B0F1CB9F833BF4DD1A3793BA867EF60");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_9948156A50C3BE93B1326565C7BD5705376090F2A853F5");
    thread thrusterloop();
    thread thrusterdamageloop();
  }
}

thrusterloop() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_848B0F1CB9F833BF4DD1A3793BA867EF60");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BABE13C8BD5D138D56525DB53812DEDEE6A3A8CD19");
  thread thrusterstopfx();

  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.thrustfxent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  } else
    self.thrustfxent.origin = self.origin;

  waitframe();

  for(;;) {
    self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
    earthquake(0.1, 0.3, self.origin, 120);
    var_0 = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = var_0;
    self.thrustfxent.angles = (90, 0, 0);
    waitframe();
    wait 0.33;
  }
}

thrusterdamageloop() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_848B0F1CB9F833BF4DD1A3793BA867EF60");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BABE13C8BD5D138D56525DB53812DEDEE6A3A8CD19");

  for(;;) {
    scripts\mp\utility\damage::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "_encstr_A1ED0BA9FF84562B60BA073E83", "_encstr_91320C1D0D93BADC4759E4BEB5E0", 1);
    wait 0.05;
  }
}

thrusterstopfx() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_BABE13C8BD5D138D56525DB53812DEDEE6A3A8CD19", "_encstr_848B0F1CB9F833BF4DD1A3793BA867EF60");
  waitframe();
}

runhover() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(self ishighjumping() && self playerads() > 0.3 && self energy_getenergy(0) > 0) {
      executehover();
      thread watchhoverend();
      self waittill("_encstr_93B70C610FD305289F9FCD59878C");
      endhover();
    }

    wait 0.1;
  }
}

watchhoverend() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8EDE0FBBC28D8D8DBD6CB5FA2BE619B28C");

  while(self playerads() > 0.3)
    waitframe();

  self notify("_encstr_93B70C610FD305289F9FCD59878C");
}

executehover() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.ishovering = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("_encstr_8E651267C0A7BE6577A3FF48620F6289A1E99B63");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self playerlinkTo(var_0);
  thread managetimeout(var_0);
}

managetimeout(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self energy_getrestorerate(0);
  self energy_setrestorerate(0, 1.0);
  wait 2;
  self notify("_encstr_93B70C610FD305289F9FCD59878C");
  self energy_setrestorerate(0, var_1);
  self energy_setenergy(0, 0);
}

endhover() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.ishovering = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("_encstr_862E12876BBF531C86C8FF33E87EC4FA51770EFC");
  self unlink();
}

setadsmarktarget() {}

perk_adsmarktarget_think() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A51613E6951FF9A18BF0470B89C18AB2BB28F26775");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(self playerads() > 0.5) {
      foreach(var_1 in level.players) {
        if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
          continue;
        }
        if(var_1.team == self.team) {
          continue;
        }
        if(istrue(var_1.isperk_adsmarked)) {
          continue;
        }
        if(istrue(var_1.ischeckingadsmarking)) {
          continue;
        }
        var_1.ischeckingadsmarking = 1;
        thread perk_adstargetmark_disconnectcleanupthink(var_1);
        var_1 thread perk_adstargetmark_disconnectcleanupthink(var_1);

        if(perk_adsmarktarget_check(var_1)) {
          thread perk_adsmarktarget_confirmtargetandmark(var_1);
          continue;
        }

        var_1.ischeckingadsmarking = 0;
      }
    }

    wait 0.2;
  }
}

perk_adsmarktarget_check(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A51613E6951FF9A18BF0470B89C18AB2BB28F26775");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_2 = distance(var_0.origin, self.origin);
  var_3 = 0;

  if(var_2 != 0)
    var_3 = 1000 * (10 / var_2);

  var_4 = var_0 getEye();

  if(var_0.team != self.team && (self worldpointinreticle_circle(var_0.origin + (0, 0, 24), 90, var_3) || self worldpointinreticle_circle(var_4, 90, var_3))) {
    var_5 = self getEye();
    var_6 = var_4;
    var_7 = physics_raycast(var_5, var_6, var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_7) && var_7.size == 0)
      return 1;

    waitframe();
    var_6 = var_0.origin + (0, 0, 24);
    var_8 = physics_raycast(var_5, var_6, var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_8) && var_8.size == 0)
      return 1;
  }

  return 0;
}

perk_adsmarktarget_confirmtargetandmark(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A51613E6951FF9A18BF0470B89C18AB2BB28F26775");
  var_1 = undefined;
  var_2 = getdvarfloat("_encstr_937A23E0AC4EAD7D16C8DCFADA0B93B67D8E0BC93B95E8F534ED1B19EBD15ADACAD7C9B25C");

  if(scripts\mp\utility\perk::_hasperk("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6"))
    var_2 = var_2 * getdvarfloat("_encstr_87431D6A3273F0CE11DF337B222219D092ADC74DD4B13D87AE827F4820D5A5");

  wait(var_2);

  if(self playerads() > 0.5 && perk_adsmarktarget_check(var_0)) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);

    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_4 = 0;
      var_5 = 5000;
      var_6 = 100;
    } else {
      var_4 = 1;
      var_5 = 5000;
      var_6 = 0;
    }

    var_7 = var_3 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(getlivingplayers_team(self.team), "_encstr_96321214C71FF589CDD31BCE79D3311565109703", 35, var_4, var_5, var_6, undefined, 1);
    var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self, "_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF", "_encstr_BE8F0A272F9B2BE97268AE8B");
    var_0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", 0);
    var_0.isperk_adsmarked = 1;
    thread perk_trackadsmarktargetoutline(var_7, var_3, var_1, var_0);
  } else
    var_0.ischeckingadsmarking = 0;
}

perk_trackadsmarktargetoutline(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.6;
  scripts\mp\utility\outline::outlinedisable(var_2, var_3);

  if(isDefined(var_3))
    var_3 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

  var_4 = getdvarfloat("_encstr_BD162471C85A38A9AEA963CE584E1837FF54EE554FEAB92914CBFAA9FA9187AA531163418F01");

  if(scripts\mp\utility\perk::_hasperk("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6"))
    var_4 = var_4 * getdvarfloat("_encstr_86F81FC19527DAFAD10B939DB21DBE6B16275BCAC87D1BBD73B32BC9F5E40B1DAC");

  wait(var_4 - 0.6);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0);
  var_1 delete();

  if(isDefined(var_3)) {
    var_3.isperk_adsmarked = 0;
    var_3.ischeckingadsmarking = 0;
  }

  self notify("_encstr_B4670E5AD193B3273B32D7FA1A895F58");
}

getlivingplayers_team(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

perk_adstargetmark_disconnectcleanupthink(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_A51613E6951FF9A18BF0470B89C18AB2BB28F26775", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0))
    var_0.ischeckingadsmarking = 0;
}

unsetadsmarktarget() {
  self notify("_encstr_A51613E6951FF9A18BF0470B89C18AB2BB28F26775");
}

sethelmet() {}

unsethelmet() {}

setarmorvest() {
  self.tookvesthit = 0;
}

unsetarmorvest() {}

setladder() {}

unsetladder() {}

setdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

unsetdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
}

setdoorsense() {
  if(!isDefined(level.playerswithdoorsense))
    level.playerswithdoorsense = 1;
  else
    level.playerswithdoorsense = level.playerswithdoorsense + 1;
}

unsetdoorsense() {
  level.playerswithdoorsense = level.playerswithdoorsense - 1;
}

setworsenedgunkick() {
  updateweaponkick();
}

unsetworsenedgunkick() {
  updateweaponkick(1);
}

updateweaponkick(var_0) {
  if(!isDefined(self.weaponkickrecoil))
    self.weaponkickrecoil = 0;

  var_1 = -25;

  if(scripts\mp\utility\perk::_hasperk("_encstr_B8331AF8E881BAC72F65FC0BA7AB528640955D8769F23DE51A3422C8") && !istrue(var_0)) {
    if(isDefined(self.currentweapon)) {
      switch (self.currentweapon.classname) {
        case "_encstr_965306392D3336B2":
          var_1 = -20;
          break;
        case "_encstr_BE0703A54C":
          var_1 = -20;
          break;
      }
    }
  } else
    var_1 = 0;

  if(var_1 != self.weaponkickrecoil) {
    scripts\mp\utility\weapon::setrecoilscale(-1 * self.weaponkickrecoil);
    scripts\mp\utility\weapon::setrecoilscale(var_1);
    self.weaponkickrecoil = var_1;
  }
}

setkillstreaktoscorestreak() {
  var_0 = undefined;

  if(isDefined(self.pers["_encstr_AB321F6717728120B45A61F904BC88563AA7CDF3871B56A8F9742E50AC762BE322"]) && self.pers["_encstr_AB321F6717728120B45A61F904BC88563AA7CDF3871B56A8F9742E50AC762BE322"] == self.lifeid) {
    var_0 = self.pers["_encstr_A5E41897E78271D024CAF149B42CF826AA175D0317ABC63849E4"];
    self.pers["_encstr_A5E41897E78271D024CAF149B42CF826AA175D0317ABC63849E4"] = undefined;
    self.pers["_encstr_AB321F6717728120B45A61F904BC88563AA7CDF3871B56A8F9742E50AC762BE322"] = undefined;
  } else
    var_0 = vote_player_reset(self.streakpoints);

  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(var_0);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

unsetkillstreaktoscorestreak() {
  self.pers["_encstr_A5E41897E78271D024CAF149B42CF826AA175D0317ABC63849E4"] = self.streakpoints;
  self.pers["_encstr_AB321F6717728120B45A61F904BC88563AA7CDF3871B56A8F9742E50AC762BE322"] = self.lifeid;
  var_0 = vote_player_set(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(var_0);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

vote_player_reset(var_0) {
  return var_0 * 125;
}

vote_player_set(var_0) {
  return int(var_0 / 125);
}

_id_13137() {
  if(self.streakpoints <= 0)
    self.pers["_encstr_86CE0D1BA9C3F853B0B89B34E2EBB5"] = 1;
}

_id_13F64() {
  if(!istrue(level.gameended))
    self.pers["_encstr_86CE0D1BA9C3F853B0B89B34E2EBB5"] = undefined;
}

setscrapweapons() {
  if(getdvarint("_encstr_A670195F3F43B7B63F9B40F0AF42C8DD2AA7D670975A6BD9ECFF70") == 1)
    self setclientomnvar("_encstr_B8290FF3E81F4753B9B4EDF2C021EB0FAD", 1);
}

unsetscrapweapons() {
  self setclientomnvar("_encstr_B8290FF3E81F4753B9B4EDF2C021EB0FAD", 0);
}

setdooralarm() {
  self.alarmeddoors = [];
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 1);
}

unsetdooralarm() {
  foreach(var_1 in self.alarmeddoors)
  var_1 scripts\mp\door::removealarmdoor(0);

  self.alarmeddoors = undefined;
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 0);
}

setreviveuseweapon() {
  thread proximityrevivethink();
}

proximityrevivethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_925618FFF59E7254E15B579BD0408D29752727DF7FCD7A2838E0");

  if(!isDefined(self.proximityrevivefauxtrigger)) {
    var_0 = spawnStruct();
    var_0.usetime = getdvarfloat("_encstr_A97E1B48CB906F372255672BCBE9D983FC84A7370AE3828C4F17A8D2C7") * scripts\mp\utility\dvars::getwatcheddvar("_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B");
    var_0.curprogress = 0;
    var_0.owner = undefined;
    var_0.id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
    var_0.trigger = spawnStruct();
    var_0.trigger.id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
    self.proximityrevivefauxtrigger = var_0;
  }

  var_0 = self.proximityrevivefauxtrigger;

  if(!isDefined(self.hiddenreviveents))
    self.hiddenreviveents = [];

  self.canrevivewithweapon = 1;

  if(isDefined(level.revivetriggers)) {
    foreach(var_3, var_2 in level.revivetriggers) {
      if(!isDefined(self.hiddenreviveents[var_3])) {
        var_2.trigger disableplayeruse(self);
        self.hiddenreviveents[var_3] = var_2.trigger;
      }
    }
  }

  foreach(var_3, var_2 in level.laststandreviveents) {
    if(!isDefined(self.hiddenreviveents[var_3])) {
      var_2 disableplayeruse(self);
      self.hiddenreviveents[var_3] = var_2;
    }
  }

  for(;;) {
    var_5 = scripts\mp\utility\player::getplayersinradius(self.origin, 150, self.team, self);

    foreach(var_7 in var_5) {
      if(istrue(var_7.inlaststand) && !istrue(var_7.stuckinlaststand) && !istrue(var_7.laststandhealisactive) && !istrue(var_7 scripts\mp\utility\player::registerpuzzleinteractions()) && !isDefined(var_0.owner))
        thread proximityrevive(var_7, var_0);
    }

    if(isDefined(level.revivetriggers)) {
      foreach(var_10 in level.revivetriggers) {
        if(var_10.ownerteam == self.team) {
          if(!istrue(var_10.trigger.owner scripts\mp\utility\player::registerpuzzleinteractions()) && !isDefined(var_0.owner)) {
            if(distancesquared(var_10.trigger.origin, self.origin) <= 22500)
              thread proximityrevive(var_10.trigger.owner, var_0, var_10);
          }
        }
      }
    }

    wait 0.1;
  }
}

proximityrevive(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_925618FFF59E7254E15B579BD0408D29752727DF7FCD7A2838E0");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  var_0 scripts\mp\utility\player::_id_1312B(1);
  var_1.owner = var_0;
  var_1.trigger.owner = var_0;
  thread watchproximityrevivefail(var_0, var_1, var_2);

  if(isDefined(var_2)) {
    var_2.trigger hide();
    var_2.trigger makeunusable();
    var_2 scripts\mp\teamrevive::revivetriggerholdonusebegin(self, 1);
  } else if(isDefined(var_0.laststandreviveent)) {
    var_0.laststandreviveent hide();
    var_0.laststandreviveent makeunusable();
  }

  var_0 notify("_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");
  var_0 scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_95F410330D9518D49099052119C7D3E1E35F");

  while(var_1.curprogress < var_1.usetime) {
    if(distancesquared(self.origin, var_0.origin) > 90000) {
      self notify("_encstr_BE1D111CE4BD87FA3956ECB4B3B27DCC58A58D");
      return;
    }

    scripts\mp\gameobjects::updateuiprogress(var_1, 1);
    var_1.curprogress = var_1.curprogress + level.framedurationseconds;
    waitframe();
  }

  scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  var_0 scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_95F410330D9518D49099052119C7D3E1E35F");
  var_1.curprogress = 0;
  var_1.owner = undefined;
  var_1.trigger.owner = undefined;

  if(istrue(var_0.inlaststand))
    var_0 notify("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  else {
    var_2 scripts\mp\teamrevive::revivetriggerholdonuseend(self.team, self, 1, 1);
    var_2 scripts\mp\teamrevive::revivetriggerholdonuse(self);
  }
}

watchproximityrevivefail(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  var_0 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_3 = var_0.team;
  scripts\engine\utility::waittill_any_ents_return(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_925618FFF59E7254E15B579BD0408D29752727DF7FCD7A2838E0", self, "_encstr_BE1D111CE4BD87FA3956ECB4B3B27DCC58A58D", var_0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", var_0, "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");

  if(isDefined(var_2)) {
    var_2.trigger show();
    var_2.trigger makeusable();
    var_2 scripts\mp\teamrevive::revivetriggerholdonuseend(var_3, self, 0, 1);
  }

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\player::_id_1312B(0);
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
    var_0 scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_95F410330D9518D49099052119C7D3E1E35F");

    if(isDefined(var_0.laststandreviveent)) {
      var_0.laststandreviveent show();
      var_0.laststandreviveent makeusable();
    }

    var_0 notify("_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");
  }

  if(isDefined(self)) {
    var_1.owner = undefined;
    var_1.trigger.owner = undefined;
    var_1.curprogress = 0;
    scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  }
}

unsetreviveuseweapon() {
  self notify("_encstr_925618FFF59E7254E15B579BD0408D29752727DF7FCD7A2838E0");
  self.canrevivewithweapon = undefined;

  foreach(var_2, var_1 in self.hiddenreviveents) {
    if(isDefined(var_1) && var_1.owner != self) {
      var_1 showtoplayer(self);
      var_1 enableplayeruse(self);
    }
  }
}

setlocationmarking() {}

unsetlocationmarking() {}

setremotedefuse() {}

unsetremotedefuse() {}

setalwaysminimap() {
  scripts\mp\utility\player::showminimap();
}

unsetalwaysminimap() {
  scripts\mp\utility\player::hideminimap();
}

supersprintkillrefresh_init() {
  level._effect["_encstr_8DC415EAA307EBABF1D363BE1A7824E803E3CE4B405382"] = loadfx("_encstr_AA971F3B661E794BBBE0F5D6E0E583CA93DAF267663CFA86ABE68E8DB2B867331E");
  level._effect["_encstr_B4641B1B80C97FEBF6AE607A4B383B0935E8D283B8677427889B7F68DD"] = loadfx("_encstr_A70F257BDD9AB8541B12B6695ABE53A5689F2D53907361BBB34304A3FF3FBADC61398C60ACC439");
}

supersprintkillrefresh_onkill() {
  self refreshsprinttime();
}

setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

setfastreloadlaunchers() {}

unsetfastreloadlaunchers() {
  if(istrue(self.fastreloadlaunchers)) {
    scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
    self.fastreloadlaunchers = undefined;
  }
}

setreduceregendelay() {
  self.regendelayspeed = 2;
}

unsetreduceregendelay() {
  self.regendelayspeed = 1;
}

regendelayreduce_onkill() {
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_1 = self isnightvisionon();
  var_2 = var_0 && !var_1;
  var_3 = scripts\engine\utility::ter_op(var_2, scripts\engine\utility::getfx("_encstr_B4641B1B80C97FEBF6AE607A4B383B0935E8D283B8677427889B7F68DD"), scripts\engine\utility::getfx("_encstr_8DC415EAA307EBABF1D363BE1A7824E803E3CE4B405382"));
  playfxontagforclients(var_3, self, "_encstr_A130084D2FDAD8AA8F62", self);
  thread _id_12ACF();
}

_id_12ACF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_B2931EEBF882135A100DD391C3B96A7B95AFD85FA4B38BD70B8B61597807ED6D");
  self endon("_encstr_B2931EEBF882135A100DD391C3B96A7B95AFD85FA4B38BD70B8B61597807ED6D");
  var_0 = gettime();

  while(var_0 + 140 > gettime()) {
    scripts\mp\healthoverlay::reducehealthregendelay(10000);
    waitframe();
  }
}

_id_131B8() {
  if(isDefined(self.waittoopenaltbunker) && self.waittoopenaltbunker == gettime())
    regendelayreduce_onkill();
}

_id_13F6C() {}

_id_12AD0() {
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_1 = self isnightvisionon();
  var_2 = var_0 && !var_1;
  var_3 = scripts\engine\utility::ter_op(var_2, scripts\engine\utility::getfx("_encstr_B4641B1B80C97FEBF6AE607A4B383B0935E8D283B8677427889B7F68DD"), scripts\engine\utility::getfx("_encstr_8DC415EAA307EBABF1D363BE1A7824E803E3CE4B405382"));
  playfxontagforclients(var_3, self, "_encstr_A130084D2FDAD8AA8F62", self);
  thread _id_12ACF();
}

_id_131BA() {
  if(isDefined(self.tracking_max_health) && istrue(self.tracking_max_health))
    _id_12AD0();
}

setreduceregendelayonobjective() {
  updatereduceregendelayonobjective();
  thread monitorreduceregendelayonobjective();
}

unsetreduceregendelayonobjective() {
  self notify("_encstr_8A8C218BDB53D5C8222FF12B56FD311DCA5F05616FCAAFF807C59CC13CA5C0CD82EB9B");
  updatereduceregendelayonobjective(1);
}

monitorreduceregendelayonobjective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8A8C218BDB53D5C8222FF12B56FD311DCA5F05616FCAAFF807C59CC13CA5C0CD82EB9B");

  for(;;) {
    wait 0.5;
    updatereduceregendelayonobjective();
  }
}

updatereduceregendelayonobjective(var_0) {
  var_1 = isDefined(self.carryobject);
  var_2 = isDefined(self.touchinggameobjects) && self.touchinggameobjects.size > 0;
  var_3 = isDefined(self.usinggameobjects) && self.usinggameobjects.size > 0;
  var_4 = var_1 || var_2 || var_3;

  if(var_4 && !istrue(var_0)) {
    if(!istrue(self.isonobjective)) {
      self.isonobjective = 1;
      scripts\mp\utility\perk::giveperk("_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702");
    }
  } else if(istrue(self.isonobjective)) {
    self.isonobjective = 0;
    scripts\mp\utility\perk::removeperk("_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702");
  }
}

setrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }
  self notify("_encstr_AD2B15CDCA8E49ACB1860B27D9ACA817EA5A1C6B56E6A3");
  level.perkrechargeequipmentplayers = scripts\engine\utility::array_add(level.perkrechargeequipmentplayers, self);
}

unsetrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }
  level.perkrechargeequipmentplayers = scripts\engine\utility::array_remove(level.perkrechargeequipmentplayers, self);
  thread rechargeequipment_clearplayer(self);
}

rechargeequipmentthink_init() {
  level.perkrechargeequipmentplayers = [];
  var_0 = int(ceil(0.5 / level.framedurationseconds));

  for(;;) {
    var_1 = level.perkrechargeequipmentplayers;
    var_2 = int(ceil(var_1.size / var_0));

    for(var_3 = 0; var_3 < var_0; var_3++) {
      for(var_4 = 0; var_4 < var_2; var_4++) {
        var_5 = var_3 * var_2 + var_4;

        if(var_5 > var_1.size) {
          break;
        }

        var_6 = var_1[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(!var_6 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_6.inlaststand) || istrue(self.stuckinlaststand)) {
          continue;
        }
        rechargeequipment_updatestate(var_6);
      }

      waitframe();
    }
  }
}

rechargeequipment_updatestate(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  rechargeequipment_updateslot(var_0, "_encstr_BA7F0830B3A7859B60B0");
  rechargeequipment_updateslot(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  rechargeequipment_updateui(var_0);
}

rechargeequipment_updateslot(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1]))
    var_2.progress[var_1] = 0;

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = relic_squadlink_remove_visionset(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_7 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(isDefined(level.playerzombiewaittillinputreturn))
    var_8 = level.playerzombiewaittillinputreturn;
  else if(var_4 == "_encstr_B419040BB1A3")
    var_8 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB", 0.00833333, 0.02);
  else
    var_8 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB", 0.0166667, 0.02);

  if(var_1 == "_encstr_AC8F0AE74163F85AAA380AD8" && var_5 < var_6 && var_7 > 1)
    var_2.progress[var_1] = var_2.progress[var_1] + var_8 * 2;
  else if(var_5 < var_6)
    var_2.progress[var_1] = var_2.progress[var_1] + var_8;
  else
    var_2.progress[var_1] = 0;

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
  }
}

relic_squadlink_remove_visionset(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_820F114AE740032B7F8680CAD930B1D239F212":
      var_1 = "_encstr_B419040BB1A3";
      break;
    default:
      var_1 = "_encstr_820E07FAE8780B3A4C";
      break;
  }

  return var_1;
}

rechargeequipment_clearplayer(var_0) {
  var_0 endon("_encstr_AD2B15CDCA8E49ACB1860B27D9ACA817EA5A1C6B56E6A3");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.rechargeequipmentstate = undefined;
  waitframe();
  rechargeequipment_updateui(var_0);
}

rechargeequipment_updateui(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["_encstr_BA7F0830B3A7859B60B0"]))
      var_1 = var_4.progress["_encstr_BA7F0830B3A7859B60B0"];

    if(isDefined(var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"]))
      var_2 = var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"];

    foreach(var_7, var_6 in var_4.recharged) {
      if(var_7 == "_encstr_BA7F0830B3A7859B60B0") {
        var_3 = var_3 + 1;
        var_0 playlocalsound("_encstr_B229132D8BA1C2F7DEE3824AE8202BFF1011B18C17");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }

      if(var_7 == "_encstr_AC8F0AE74163F85AAA380AD8") {
        var_3 = var_3 + 2;
        var_0 playlocalsound("_encstr_871E14BB5357CB959B58BF8748F65C22877504B6CF49");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }
    }
  }

  var_0 setclientomnvar("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", var_1);
  var_0 setclientomnvar("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", var_2);
  var_0 setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", var_3);
  var_0 clearladderstate("_encstr_BA7F0830B3A7859B60B0", var_1);
  var_0 clearladderstate("_encstr_AC8F0AE74163F85AAA380AD8", var_2);
}

markequipment_monitorlook() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!isDefined(self.markequipmentstate)) {
    self.markequipmentstate = spawnStruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
  }

  for(;;) {
    self waittill("_encstr_AC8B15DBC172FA8B19901980D2873C09AEB87FA5FA1085", var_0);
    var_1 = isDefined(var_0) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = var_0;
    self.markequipmentstate.markingtime = 0;

    if(var_1)
      thread markequipment_updatestate();
  }
}

markequipment_updatestate() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  var_0 = gettime();
  var_1 = 0;

  if(self entityhasmark("_encstr_A1940FD903FBCF747BC05AA328652FEF30", self.markequipmentstate.markingent))
    var_1 = getdvarint("_encstr_B2FF21C8732864BF7E618229C95B33D148F35C2CB7C0EA1F2FD839A2D0AEE316184FCD");
  else if(self entityhasmark("_encstr_85CE0B9770B02C73A1760F06D2", self.markequipmentstate.markingent))
    var_1 = getdvarint("_encstr_816C1D9795DE6F90631FB2B9BB7F21FAE67C5BAFA70B193F7BE33823026E01");
  else if(self entityhasmark("_encstr_BE8F0A272F9B2BE97268AE8B", self.markequipmentstate.markingent))
    var_1 = getdvarint("_encstr_993C1C0B20EDDC7F934595B76DFB1FE451C8C262D0DF579F4B35998E7601");
  else {}

  var_2 = var_1 * var_1;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self)) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > var_2) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self.markequipmentstate.markingtime = self.markequipmentstate.markingtime + var_4;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\mp\utility\player::isplayerads()) {
        var_5 = self.markequipmentstate.markedentindex;
        var_6 = self.markequipmentstate.markedents[var_5];

        if(isDefined(var_6)) {
          var_6 filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(var_6);
        }

        if(level.teambased)
          self.markequipmentstate.markingent filterinplayermarks(self.team);
        else
          self.markequipmentstate.markingent filterinplayermarks(self);

        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self playlocalsound("_encstr_A93722EAAF10999A1B3FCB07261771AB5F969B34571B35C6123F8E82E2C745BBEB674709");

        if(level.teambased && _calloutmarkerping_predicted_timeout::_id_14126(self.markequipmentstate.markingent)) {
          self.markequipmentstate.markingent._id_13AB2 = self.team;
          var_7 = scripts\mp\utility\player::getteamarray(self.markequipmentstate.markingent._id_13AB2);

          foreach(var_9 in var_7)
          _calloutmarkerping_predicted_timeout::_id_14132(self.markequipmentstate.markingent, var_9);
        }

        self.markequipmentstate.markedents[var_5] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(1);
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(0);

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

unmarkafterduration(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  self endon("_encstr_AA460B4BD0A9A7BA70BB5634F7" + self getentitynumber());
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = getdvarint("_encstr_B42E1D0BA7A822CFED2BC858412B53EDB728700AD68CC7344FD8EEE580A55B");
  scripts\engine\utility::_id_143BF(var_1, "_encstr_8D820B49520F0EC02DDE6367EC");
  unmarkent(var_0);
}

unmarkent(var_0) {
  var_0 filterinplayermarks(undefined);

  if(isDefined(var_0._id_13AB2)) {
    if(level.teambased && _calloutmarkerping_predicted_timeout::_id_14126(var_0)) {
      var_1 = scripts\mp\utility\player::getteamarray(var_0._id_13AB2);

      foreach(var_3 in var_1)
      _calloutmarkerping_predicted_timeout::_id_14132(var_0, var_3);
    }

    var_0._id_13AB2 = undefined;
  }

  if(isDefined(self)) {
    self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, var_0);
    var_0 notify("_encstr_AA460B4BD0A9A7BA70BB5634F7" + self getentitynumber());
  }
}

setmarkequipment() {
  if(!level.teambased) {
    return;
  }
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

unsetmarkequipment() {
  if(!level.teambased) {
    return;
  }
  if(isDefined(self.markequipmentstate)) {
    foreach(var_1 in self.markequipmentstate.markedents) {
      if(isDefined(var_1))
        unmarkent(var_1);
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
}

getchildoutlineents(var_0) {
  if(!isDefined(var_0))
    return [];

  if(!isDefined(var_0.childoutlineents))
    return [var_0];

  return var_0.childoutlineents;
}

outlinehelper_getallplayers(var_0, var_1) {
  return level.players;
}

outlinehelper_validplayer(var_0) {
  return 1;
}

outlinehelper_verifydata(var_0) {
  if(!isDefined(var_0.getplayers))
    var_0.getplayers = ::outlinehelper_getallplayers;

  if(!isDefined(var_0.validplayer))
    var_0.validplayer = ::outlinehelper_validplayer;

  if(!isDefined(var_0.hudoutlineassetname))
    var_0.hudoutlineassetname = "_encstr_A6DD112B13A8F33B2BD5672E97F006A3C429D3";

  if(!isDefined(var_0.prioritygroup))
    var_0.prioritygroup = "_encstr_960D052F10EBF0";

  if(!isDefined(var_0.waittime))
    var_0.waittime = 0.1;
}

outlinehelper_updateentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    outlinehelper_disableentityoutline(var_1);
    outlinehelper_enableentityoutline(var_0);
  }
}

outlinehelper_enableentityoutline(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getentitynumber();
  var_2 = self.entityoutlines[var_1];

  if(isDefined(var_2)) {
    return;
  }
  var_3 = undefined;

  if(self entitymarkfilteredin(var_0)) {
    var_3 = spawnStruct();
    var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
    var_3.hudoutlineassetname = "_encstr_86AA0FCD07B7A38EB2E47DE80B4EB3AC3A";
    outlinehelper_verifydata(var_3);
  }

  var_4 = self entitymarkfilteredin(var_0);

  if(self entityhasmark("_encstr_A1940FD903FBCF747BC05AA328652FEF30", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_993E1E3B88D71BD351CEAF9C6F9B57E75959221210B992EB6BBD998B688137EA";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_B67D20DC0EF6D1475939D7737B3AC2E4ECACE8EBB54B1BC66E4727AC2CB5EB2C5A93";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("_encstr_85CE0B9770B02C73A1760F06D2", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_82441AB2373FBC589D33A101813A1FE7AB7990038D839BB875DDA19F";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_93111C72976FF3CC1150B76BA06B91DBC7A53BE1F28BAAECFB080B4FF860";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("_encstr_BE8F0A272F9B2BE97268AE8B", var_0)) {
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_B6BF1923523FF06D0AABD799FFA33CB0DC6169FBBB9188A962F389";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_BEF91B4763529D08D52A560815ACE8D68A9FF197AF5BE538F8C519CDFB";
    }

    outlinehelper_verifydata(var_3);
  }

  if(isDefined(var_3)) {
    var_2 = spawnStruct();
    self.entityoutlines[var_1] = var_2;
    var_2.list = [];
    var_2.ent = var_0;
    var_5 = getchildoutlineents(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\mp\utility\outline::outlineenableforplayer(var_7, self, var_3.hudoutlineassetname, var_3.prioritygroup);
      var_9 = spawnStruct();
      var_9.ent = var_7;
      var_9.id = var_8;
      var_10 = var_7 getentitynumber();
      var_2.list[var_10] = var_9;
    }
  }
}

outlinehelper_disableentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = self.entityoutlines[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1.list)
      scripts\mp\utility\outline::outlinedisable(var_3.id, var_3.ent);

      self.entityoutlines[var_0] = undefined;
    }
  }
}

_id_11B0B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

markedentities_think() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.entityoutlines = [];

  for(;;) {
    self waittill("_encstr_A51F0EB71123523E31C179F6951A15A7", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0)
      outlinehelper_disableentityoutline(var_4);

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = _id_11B0B(self.markequipmentstate.markedents, var_0);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size)
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1)
      outlinehelper_disableentityoutline(var_7);
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2)
      outlinehelper_enableentityoutline(var_10);
    }
  }
}

_id_1312C() {
  self notify("_encstr_A30824874710565F48A92EE56C2BA563F1A7F79E7B33A8EDB60371EF390598184FB3EA83118C");
  self.should_drop_scavenger_bag = 1;
  _id_14022(self.team);
  thread ks_airdroppercircle();
}

_id_13F63() {}

ks_airdroppercircle() {
  var_0 = self.team;
  var_1 = self.squadindex;
  self endon("_encstr_A30824874710565F48A92EE56C2BA563F1A7F79E7B33A8EDB60371EF390598184FB3EA83118C");
  scripts\engine\utility::_id_143A5("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    self.should_drop_scavenger_bag = undefined;

  _id_14022(var_0, var_1);
}

_id_14022(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardangles(var_0);

  if(!isDefined(level.clearlethalonunresolvedcollision))
    level.clearlethalonunresolvedcollision = [];

  var_3 = 0;

  if(isDefined(level.clearlethalonunresolvedcollision[var_0]))
    var_3 = level.clearlethalonunresolvedcollision[var_0];

  var_4 = var_2 - var_3;

  if(var_4 != 0)
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::battletracksmusicstate(var_0, var_4, var_1);

  level.clearlethalonunresolvedcollision[var_0] = var_2;
}

_id_131C2() {
  self clearvehicleturretstickers(1);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    self setclientomnvar("_encstr_AD5A1BBA5AFADCE0AC1B2D58D85ADC1DFA98DBCD5DDCD7581BD15A9DCA", 1);
}

_id_13F6E() {
  self clearvehicleturretstickers(0);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    self setclientomnvar("_encstr_AD5A1BBA5AFADCE0AC1B2D58D85ADC1DFA98DBCD5DDCD7581BD15A9DCA", 0);
}

_id_13199() {
  self._id_12369 = spawnStruct();
  self._id_12369._id_13A72 = [];
  self._id_12369.targetids = [];
  self._id_12369._id_12367 = [];
  self._id_12369.instant_revived = 0;

  for(var_0 = 0; var_0 < 4; var_0++)
    self._id_12369._id_12367[var_0] = -1;
}

maxmuncurrencycap(var_0) {
  if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }
  if(var_0.team == self.team) {
    return;
  }
  if(isDefined(self._id_12369)) {
    _id_1236A(var_0);
    _id_1236B(var_0);
    var_0._id_13A70 = 1;
  }
}

_id_1236A(var_0) {
  var_1 = "_encstr_86A815A15732FA2DB1DEB9BE43ACB08CAFB5584EB5ACC8";
  var_2 = 8;
  var_3 = 1;
  var_4 = 0;
  var_5 = 500;

  if(isDefined(var_0._id_13A70)) {
    return;
  }
  var_6 = self._id_12369._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_6)) {
    self._id_12369._id_13A72[var_0 getentitynumber()] = var_0;
    var_6 = var_0;
    var_7 = self._id_12369.instant_revived;
    self._id_12369.instant_revived = (self._id_12369.instant_revived + 1) % 4;

    if(isDefined(self._id_12369._id_13A72[self._id_12369._id_12367[var_7]])) {
      var_8 = self._id_12369._id_13A72[self._id_12369._id_12367[var_7]];
      self._id_12369._id_12367[var_7] = -1;
      var_8 thread _id_1236D(var_8, var_8.headicon);
      thread _id_12372(var_8);
    }

    self._id_12369._id_12367[var_7] = var_0 getentitynumber();
    var_9 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);
    var_6.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_9, var_1, var_2, var_3, var_4, var_5, undefined, 1, 1);
    self playlocalsound("_encstr_B69F1F62E5F91A9F3678E932A10CC7D540A31CD77FB06507DD16C23A0BEADF0D88", self);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1276A("_encstr_B69F1F62E5F91A9F3678E932A10CC7D540A31CD77FB06507DD16C23A0BEADF0D88", self.team, var_0);
    var_0 thread _id_1236F(var_0, var_6.headicon);
    thread _id_12373(var_0);
  }
}

_id_1236B(var_0) {
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self, "_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF", "_encstr_960D052F10EBF0");
  var_0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_851510A39042189B5C38D18F72E308667D7B", 0);

  if(!isDefined(var_0._id_13A70))
    var_0 playlocalsound("_encstr_B4C52299F3AFF7E05AAB0773CC0398B0F73AD1A60BA7A0A8F3871B6BE2AC700D5F03688B");

  var_0 thread _id_12371(var_1, var_0);
}

_id_1236F(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0 getentitynumber();
  var_0 endon("_encstr_8F57108DA9F0CA667103EA03C10177975547" + var_2);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 3.0);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

_id_12373(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_85EA1708AB08A7BFB005824A891C2FD7F8239374C3906E9BED");
  var_1 = var_0 getentitynumber();
  self endon("_encstr_9BC80E9B2FF0A838671DF845900D13A7" + var_1);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 3.0);

  if(isDefined(self._id_12369) && isDefined(self._id_12369._id_13A72)) {
    var_2 = self._id_12369._id_13A72[var_1];

    if(isDefined(var_2)) {
      var_0._id_13A70 = undefined;
      self._id_12369._id_13A72[var_1] = undefined;
    }
  }

  foreach(var_5, var_4 in self._id_12369._id_12367) {
    if(var_4 == var_1) {
      self._id_12369._id_12367[var_5] = -1;
      return;
    }
  }
}

_id_1236D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0 getentitynumber();
  var_0 notify("_encstr_8F57108DA9F0CA667103EA03C10177975547" + var_2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

_id_12372(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_85EA1708AB08A7BFB005824A891C2FD7F8239374C3906E9BED");
  var_1 = var_0 getentitynumber();
  self notify("_encstr_9BC80E9B2FF0A838671DF845900D13A7" + var_1);

  if(isDefined(self._id_12369) && isDefined(self._id_12369._id_13A72)) {
    var_2 = self._id_12369._id_13A72[var_1];

    if(isDefined(var_2)) {
      var_0._id_13A70 = undefined;
      self._id_12369._id_13A72[var_1] = undefined;
    }
  }
}

_id_12371(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.6);
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
  var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

_id_12374() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self._id_11B14)) {
    return;
  }
  self._id_11B14 = 1;
  self iprintlnbold(&"_encstr_BE8820CBF4D12136B9CF05BF243BF8D95B195FBFFEA197D31FE878813081FDB9EA4F");
  self playlocalsound("_encstr_AD852A9E434033E992FF07B9998B49E5A8153231131690F39BEFD0FA05F08360E79FAA58A3E246438799B833", self);
  wait 1.0;
  self._id_11B14 = undefined;
}

_id_13F69() {
  if(isDefined(self._id_12369._id_13A72) && self._id_12369._id_13A72.size > 0) {
    foreach(var_1 in self._id_12369._id_13A72) {
      if(isDefined(var_1))
        thread _id_12372(var_1);
    }
  }

  self._id_12369 = undefined;
  self notify("_encstr_85EA1708AB08A7BFB005824A891C2FD7F8239374C3906E9BED");
}

_id_121B7(var_0) {
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_at_max(self.team, self.squadindex, "_encstr_965019BA2DFAB9B8570BC8D7C9599673CCDB9C365623D71CAC4EDA");

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = scripts\engine\utility::ter_op(isDefined(self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]), self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] - 1, 0);
  var_3 = 1 << var_2;
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), var_1 | var_3, var_1 ^ var_3);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131C3(self.team, self.squadindex, "_encstr_965019BA2DFAB9B8570BC8D7C9599673CCDB9C365623D71CAC4EDA", var_4);
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_7 in var_5)
  var_7 setclientomnvar("_encstr_965019BA2DFAB9B8570BC8D7C9599673CCDB9C365623D71CAC4EDA", var_4);
}

_id_13928() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!self isonground()) {
    self waittill("_encstr_8D1213082A6629E87F8F6C6F9B8F71CB4D32086812");

    if(istrue(self.instantclassswapallowed))
      scripts\mp\class::disableclassswapallowed();
  }
}

_id_131C5() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A")) {
    return;
  }
  thread _id_13928();
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
  _id_121B7(1);
}

_id_13F6F() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A")) {
    return;
  }
  if(istrue(self.instantclassswapallowed))
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(0);

  _id_121B7(0);
}

_id_13716() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self._id_11B14)) {
    return;
  }
  self._id_11B14 = 1;
  self playlocalsound("_encstr_AD852A9E434033E992FF07B9998B49E5A8153231131690F39BEFD0FA05F08360E79FAA58A3E246438799B833", self);
  wait 1.0;
  self._id_11B14 = undefined;
}