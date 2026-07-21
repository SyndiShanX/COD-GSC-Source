/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\mapselect.gsc
***********************************************/

init() {}

getmapselectweapon() {
  return "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3";
}

getselectmappoint(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = 0;

  if(scripts\mp\utility\killstreak::isnavmeshkillstreak(var_0.streakname))
    var_3 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  scripts\common\utility::allow_offhand_weapons(0);
  thread watchmapselectexit(var_0);
  thread _id_144E5();
  thread watchownertimeoutdeath();
  var_4 = undefined;
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(var_0.streakname, 0.05);
  var_4 = gathermappointinfo(var_1, var_2);
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0.75);
  return var_4;
}

gathermappointinfo(var_0, var_1) {
  var_2 = 1;

  if(var_0 <= 1) {
    self setclientomnvar("_encstr_B2D7130B70F0D73EE8CF0BE551B8467B186BE3B29B", -1);
    var_2 = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  var_3 = [];
  thread watchmapselectweapon();

  if(istrue(var_2)) {
    self setclientomnvar("_encstr_B2D7130B70F0D73EE8CF0BE551B8467B186BE3B29B", var_0);
    self setclientomnvar("_encstr_92B914EAA5FADAC20EEBDCAC8D56C647EBC6DBAE738E", var_0);
  }

  while(self.mapselectpickcounter < var_0) {
    var_4 = waittill_confirm_or_cancel("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", "_encstr_91A21017B155D07573493840921FB5C8AD06");

    if(!isDefined(var_4) || var_4.string == "_encstr_91A21017B155D07573493840921FB5C8AD06") {
      var_3 = undefined;
      break;
    }

    var_5 = var_4.location + (0, 0, 10000);
    var_6 = var_4.location - (0, 0, 10000);
    var_7 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
    var_8 = level.activekillstreaks;
    var_9 = scripts\engine\utility::array_combine(var_7, var_8);
    var_10 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
    var_11 = scripts\engine\trace::ray_trace(var_5, var_6, var_9, var_10, 0, 1);
    var_4.location = var_11["_encstr_BD260953AA97E3F014279D"];
    var_3[var_3.size] = var_4;
    self.mapselectpickcounter++;

    if(istrue(var_2))
      self setclientomnvar("_encstr_B2D7130B70F0D73EE8CF0BE551B8467B186BE3B29B", var_0 - self.mapselectpickcounter);
  }

  self setclientomnvar("_encstr_92B914EAA5FADAC20EEBDCAC8D56C647EBC6DBAE738E", -1);
  self notify("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");

  if(isDefined(var_3))
    self.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 0;

  return var_3;
}

watchmapselectweapon() {
  self endon("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename != "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3") {
      self notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
      break;
    }

    waitframe();
  }
}

watchmapselectexit(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");
  stopmapselectsequence(var_0);
}

_id_144E5() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      self notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
      break;
    }

    waitframe();
  }
}

watchownertimeoutdeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_938420D52D7D63F6B1858E2DBD9BEB6E9563958DA3A5F6DCEB6CDB579B8EC87BBBB9", gettime() + 30000);
  scripts\engine\utility::_id_143B9(30, "_encstr_AD75063D571AE108");
  self notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
}

startmapselectsequence(var_0, var_1, var_2, var_3) {
  if(!self.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"]) {
    triggeroneoffradarsweep(self);
    self.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 1;
  }

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self beginlocationselection(var_0, var_1, var_2, 1, var_3);
}

stopmapselectsequence(var_0) {
  self.mapselectpickcounter = undefined;
  self.mapselectdircounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\mp\utility\player::isreallyalive(self)) {
    scripts\common\utility::allow_offhand_weapons(1);
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  } else
    self.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 0;

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);

  if(isDefined(self))
    self endlocationselection();
}

waittill_confirm_or_cancel(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_3 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_return(var_0, var_3);

  if(isDefined(var_1))
    childthread waittill_return(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_return(var_2, var_3);

  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4, var_5, var_6);
  var_3 notify("_encstr_B81804322D2B");
  var_7 = spawnStruct();
  var_7.location = var_4;
  var_7.angles = var_5;
  var_7.string = var_6;
  return var_7;
}

waittill_return(var_0, var_1) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_2, var_3, var_0);
}