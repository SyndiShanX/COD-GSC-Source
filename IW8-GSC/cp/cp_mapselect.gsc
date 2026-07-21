/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_mapselect.gsc
***********************************************/

init() {
  level._effect["_encstr_975C109AE3693F411F962910F1B9D5B928C0"] = loadfx("_encstr_977C257E7AA0550AB7CAF9783BF0FBFC4319188F3398ABABF090C73821C058AB748F8BA0968DEB");
}

tablet_enabled_check_dvar() {
  if(getdvarint("_encstr_A56514E68D93D7E81626C656D1BE232DCD2C1363AC91", 0) == 0)
    return 0;

  return 0;
}

getselectmappoint(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  thread watchownertimeoutdeath();
  var_3 = undefined;
  var_3 = gathermappointinfo(var_1, var_2);
  return var_3;
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

    var_3[var_3.size] = var_4;
    self.mapselectpickcounter++;

    if(istrue(var_2))
      self setclientomnvar("_encstr_B2D7130B70F0D73EE8CF0BE551B8467B186BE3B29B", var_0 - self.mapselectpickcounter);
  }

  self setclientomnvar("_encstr_92B914EAA5FADAC20EEBDCAC8D56C647EBC6DBAE738E", -1);
  self notify("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_B40101", self, 0);

  if(isDefined(var_3))
    self.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 0;

  return var_3;
}

watchmapselectweapon() {
  self endon("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename != "_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1") {
      self notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
      break;
    }

    waitframe();
  }
}

watchmapselectexit() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_858F10AF5E8BCFEF3898D173C3690AD34BF5");
  stopmapselectsequence();
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

stopmapselectsequence() {
  self endlocationselection();
  self.mapselectpickcounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive())
    self notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
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

setmaplocationselection() {}

set_uav_radarstrength(var_0) {
  var_1 = getuavstrengthmax();
  var_0.radarstrength = var_1;
}