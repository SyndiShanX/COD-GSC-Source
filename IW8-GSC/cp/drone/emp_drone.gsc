/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\drone\emp_drone.gsc
***********************************************/

init() {
  level.scoreinfo = [];
  var_0 = getdvarint("_encstr_B6F00BA4D4072B85F1F10A99AF");

  if(var_0 > 4 || var_0 < 0)
    exitlevel(0);

  addglobalrankxpmultiplier(var_0, "_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856");
  var_1 = getdvarint("_encstr_83670B2B6F5B07122F6EE127B2");

  if(var_1 > 4 || var_1 < 0)
    exitlevel(0);

  battle_tracks_playerinlisteningzoneinternal(var_1, "_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223");
  level.ranktable = [];
  level.weaponranktable = [];
  var_2 = _func_428();
  level.maxrank = int(tablelookup(var_2, 0, "_encstr_ADF308608F704BC31A2C", 1));
  level._id_11B5C = int(tablelookup(var_2, 0, "_encstr_A15B098159DB91995F1AC0", 1));

  for(var_3 = 0; var_3 <= level.maxrank; var_3++) {
    level.ranktable[var_3]["_encstr_9562065BB4CD0B41"] = tablelookup(var_2, 0, var_3, 2);
    level.ranktable[var_3]["_encstr_A6F409424B1BF0316740D9"] = tablelookup(var_2, 0, var_3, 3);
    level.ranktable[var_3]["_encstr_B2A406EDCF721B62"] = tablelookup(var_2, 0, var_3, 7);
    level.ranktable[var_3]["_encstr_8AC9070B9918264FB3"] = tablelookup(var_2, 0, var_3, 15);
  }

  scripts\cp\cp_weaponrank::init();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level.prestigeextras = [];
  level thread onplayerconnect();
}

molotov_delete_trigger() {
  self notify("_encstr_B40E0F55CA0D7AD2E77B7A5817A4B7E058");
  self endon("_encstr_B40E0F55CA0D7AD2E77B7A5817A4B7E058");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = "_encstr_91010E2BAF1B17997AF06DCEFB565B6A";

  while(!scripts\cp_mp\utility\player_utility::_isalive())
    waitframe();

  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave()) {
    if(!scripts\engine\utility::ent_flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
      scripts\engine\utility::ent_flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

    scripts\engine\utility::ent_flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  } else
    wait 15;

  self.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"] = 0;
  var_1 = self.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"];

  for(;;) {
    if(var_1 == self.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"]) {
      waitframe();
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      waitframe();
      continue;
    }

    var_2 = getscoreinfovalue(var_0);
    thread giverankxp(var_0, var_2, undefined, 1);
    var_1 = self.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"];
    wait 60;
  }
}

isregisteredevent(var_0) {
  if(isDefined(level.scoreinfo[var_0]))
    return 1;
  else
    return 0;
}

registerscoreinfo(var_0, var_1, var_2) {
  level.scoreinfo[var_0][var_1] = var_2;

  if(var_0 == "_encstr_ABD70578F3D02C" && var_1 == "_encstr_BA94069D16D8ABAC")
    setomnvar("_encstr_A91718CF50F64732F39DE123FBB10A3718C82313490BB92AEBA5", int(var_2));
}

getscoreinfovalue(var_0) {
  var_1 = "_encstr_AF1805EFE726E9" + scripts\cp\utility::getgametype() + "_encstr_8F4508C13AAFE0B555E7" + var_0;

  if(getDvar(var_1) != "_encstr_B40101")
    return getdvarint(var_1);
  else
    return level.scoreinfo[var_0]["_encstr_BA94069D16D8ABAC"];
}

getscoreinfocategory(var_0, var_1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var_0])) {
    return;
  }
  switch (var_1) {
    case "_encstr_BA94069D16D8ABAC":
      var_2 = "_encstr_AF1805EFE726E9" + scripts\cp\utility::getgametype() + "_encstr_8F4508C13AAFE0B555E7" + var_0;

      if(getDvar(var_2) != "_encstr_B40101")
        return getdvarint(var_2);
      else
        return level.scoreinfo[var_0]["_encstr_BA94069D16D8ABAC"];
    default:
      return level.scoreinfo[var_0][var_1];
  }
}

getrankinfominxp(var_0) {
  return int(level.ranktable[var_0]["_encstr_9562065BB4CD0B41"]);
}

getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0]["_encstr_A6F409424B1BF0316740D9"]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0]["_encstr_B2A406EDCF721B62"]);
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["_encstr_851207B317B203FA5A"] = var_0 getplayerdata("_encstr_B8A30FC8463D282A65B07FF929C89DD3F0", "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8BFF0A63E8D78F37E0C7F8F8");
        var_1 = var_0 getplayerdata("_encstr_B8A30FC8463D282A65B07FF929C89DD3F0", "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");

        if(!isDefined(var_0.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"]))
          var_0.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] = 0;
      } else {
        var_1 = 0;
        var_0.pers["_encstr_851207B317B203FA5A"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["_encstr_851207B317B203FA5A"] = 0;
    }

    var_0.pers["_encstr_A1ED09400BA5D351227715"] = var_1;

    if(var_0.pers["_encstr_851207B317B203FA5A"] < 0)
      var_0.pers["_encstr_851207B317B203FA5A"] = 0;

    var_2 = var_0 getrankforxp(var_0 getrankxp());
    var_0.pers["_encstr_A51F05CB11A052"] = var_2;
    var_0 setrank(var_2, var_1);
    var_0.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 0;
    var_0.scoreupdatetotal = 0;
    var_0.scorepointsqueue = 0;
    var_0.scoreeventqueue = [];
    var_0.postgamepromotion = 0;
    var_0 setclientdvar("_encstr_B4F10DEAA5F5C1E4F6B57B3A4BDE73", 0);

    if(!isDefined(var_0.pers["_encstr_AA3B085BC34075B70E12"])) {
      var_0.pers["_encstr_AA3B085BC34075B70E12"] = [];
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = 0;
    }

    var_0 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 0);

    if(level.playerxpenabled) {
      var_3 = getdvarint("_encstr_82040BEBF751F74784D0BADE77");
      var_4 = var_0 getprivatepartysize() > 1;

      if(var_4)
        var_0 addrankxpmultiplier(var_3, "_encstr_921218BF8D102002158FD27BE110D2C39B0F165BF307FA6F0AC1");

      if(var_0 getplayerdata("_encstr_8C07031599", "_encstr_9207176036A1C71BD3C0A2A898335673190CFDE94F88EB28C9"))
        var_0.prestigedoubleweaponxp = 1;
      else
        var_0.prestigedoubleweaponxp = 0;

      var_5 = getdvarint("_encstr_87FB0DDCC639EBF0837D63B46BA5A3", 40000);
      var_0._id_11B7F = var_5;
      var_0.totalxpearned = 0;
    }

    var_0.scoreeventcount = 0;
    var_0.scoreeventlistindex = 0;
    var_0._id_13BF3 = 0;
    var_0._id_11B67 = 3000;

    if(!scripts\cp\utility::tryingtoleave() && !scripts\cp\utility::turn_off_sniper_laser())
      var_0 thread molotov_delete_trigger();
  }
}

onplayerspawned() {
  if(isai(self)) {} else if(!level.playerxpenabled)
    self.pers["_encstr_851207B317B203FA5A"] = 0;
  else if(!scripts\cp\utility::tryingtoleave()) {}

  playerupdaterank();
  _id_125E5();
}

playerupdaterank() {
  if(self.pers["_encstr_851207B317B203FA5A"] < 0)
    self.pers["_encstr_851207B317B203FA5A"] = 0;

  var_0 = getrankforxp(getrankxp());
  self.pers["_encstr_A51F05CB11A052"] = var_0;

  if(isai(self) || !isDefined(self.pers["_encstr_A1ED09400BA5D351227715"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats))
      var_1 = getprestigelevel();
    else
      var_1 = 0;

    self setrank(var_0, var_1);
    self.pers["_encstr_A1ED09400BA5D351227715"] = var_1;
  }
}

_id_125E5() {
  scripts\cp\agents\agents::initpersstat("_encstr_B41C1363859BE812D51B639547B45A1B1B152DADB2");
  scripts\cp\agents\agents::initpersstat("_encstr_A3E90D5AF8980A358B475340F59F60");
  scripts\cp\agents\agents::initpersstat("_encstr_A1F308589BCD96CD476E");
}

tryresetrankxp() {
  if(issubstr(self.class, "_encstr_BD34078D57B9A37BD6")) {
    if(!level.playerxpenabled)
      self.pers["_encstr_851207B317B203FA5A"] = 0;
    else if(isai(self))
      self.pers["_encstr_851207B317B203FA5A"] = 0;
    else {}
  }
}

giverankxp(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.owner) && !isbot(self) && self.owner != self) {
    self.owner giverankxp(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  var_4 = botnodeavailabletoteam(self);
  var_1 = int(var_1 * var_4);

  if(!level.playerxpenabled) {
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var_1, var_0);
    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }
  var_5 = getscoreinfocategory(var_0, "_encstr_852906B39CBD5D38");
  var_6 = getscoreinfocategory(var_0, "_encstr_889C0B0BD88DBDBB48ED37ABB9");
  var_7 = 1.0;
  var_8 = var_1;
  var_9 = 0;

  if(istrue(var_6)) {
    var_7 = getrankxpmultipliertotal();
    var_8 = int(var_1 * var_7);
    var_9 = int(max(var_8 - var_1, 0));
  }

  if(!istrue(var_3))
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var_8, var_0);

  thread waitandapplyxp(var_0, var_1, var_8, var_9, var_2);
}

waitandapplyxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  var_5 = getrankxp();

  if(updaterank(var_5))
    thread updaterankannouncehud();

  syncxpstat();
  var_6 = 0;

  if(isDefined(var_4) && scripts\cp\cp_weaponrank::weaponshouldgetxp(var_4.basename)) {
    var_6 = var_1;
    var_6 = var_6 * scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
    var_6 = int(var_6);
  }

  incrankxp(var_2, var_4, var_6, var_0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_4) && (scripts\cp\cp_weapon::iscacprimaryweapon(var_4) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_4)) && !scripts\cp\cp_weapon::ispickedupweapon(var_4)) {}
  }

  recordxpgains(var_0, var_1, var_3);
  var_7 = getprestigelevel();
  var_8 = getrank();
}

recordxpgains(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  var_4 = getscoreinfocategory(var_0, "_encstr_852906B39CBD5D38");

  if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] + var_1;
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
    return;
  }

  switch (var_4) {
    case "_encstr_851E0C12C829661B5E9EC7CE2DE3":
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_932E0A09FB023CC0DA8D7FFF":
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_BDC706D9372AABE8":
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    default:
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
  }
}

updaterank(var_0) {
  var_1 = getrank();
  var_2 = getprestigelevel();
  var_3 = self.pers["_encstr_A51F05CB11A052"] + self.pers["_encstr_A1ED09400BA5D351227715"];
  var_4 = var_1 + var_2;
  self.pers["_encstr_A51F05CB11A052"] = var_1;
  self.pers["_encstr_A1ED09400BA5D351227715"] = var_2;

  if(var_4 == var_3 || var_4 >= level.maxrank + level._id_11B5C)
    return 0;

  self setrank(var_1, var_2);
  return 1;
}

updaterankannouncehud() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_92B10CEBAF2A86AB452F3B3B905F");
  self endon("_encstr_92B10CEBAF2A86AB452F3B3B905F");
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!scripts\mp\flags::levelflag("_encstr_ACCF0A3B0BD6B2EBDB3BAC27"))
    level scripts\engine\utility::waittill_notify_or_timeout("_encstr_ACCF0A3B0BD6B2EBDB3BAC27", 0.25);

  var_1 = self.pers["_encstr_A51F05CB11A052"] + self.pers["_encstr_A1ED09400BA5D351227715"];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    var_4 = var_3.pers["_encstr_8AEF05472BC2D6"];

    if(isDefined(var_4) && var_4 == var_0) {}
  }
}

queuescorepointspopup(var_0) {
  self.scorepointsqueue = self.scorepointsqueue + var_0;
}

flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

flushscorepointspopupqueueonspawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_874124BD1C33F0532F6AB803127B98688D7C1F49B7DA18A7CF23F1EB7A2FC041A2C16FBD6854");
  self endon("_encstr_874124BD1C33F0532F6AB803127B98688D7C1F49B7DA18A7CF23F1EB7A2FC041A2C16FBD6854");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.1;
  flushscorepointspopupqueue();
}

scorepointspopup(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(var_0 == 0) {
    return;
  }
  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    if(!istrue(var_1) || scripts\cp\utility\player::isinkillcam()) {
      queuescorepointspopup(var_0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("_encstr_A67011DEBE9285F108EF4B30EB432FC70BA3D7");
  self endon("_encstr_A67011DEBE9285F108EF4B30EB432FC70BA3D7");
  self.scoreupdatetotal = self.scoreupdatetotal + var_0;
  self setclientomnvar("_encstr_91D01073C4AF0BBA383004680F417A1A3BB3", self.scoreupdatetotal);
  self setclientomnvar("_encstr_A174174338B8DBC568F5444BFFC88DA3D573797A4085777F30", gettime());
  wait 1.0;
  self.scoreupdatetotal = 0;
}

notifyplayerscore() {
  waitframe();
  level notify("_encstr_936A14BA3823B03A59D7C18DB0F295C9F537B17B93CA", self, self.scoreupdatetotal);
}

queuescoreeventpopup(var_0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var_0;
}

flushscoreeventpopupqueue() {
  foreach(var_1 in self.scoreeventqueue)
  scoreeventpopup(var_1);

  self.scoreeventqueue = [];
}

flushscoreeventpopupqueueonspawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_A9712339ED8D60CB3187CFFDB7780C683E43679092D5306F8B67E3EB07B2C608C91B28056C");
  self endon("_encstr_A9712339ED8D60CB3187CFFDB7780C683E43679092D5306F8B67E3EB07B2C608C91B28056C");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.1;
  flushscoreeventpopupqueue();
}

getscoreeventpriority(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_978C092BB8FBFDEB302D69");

  if(!istrue(var_1))
    return 0;

  return var_1;
}

scoreeventalwaysshowassplash(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_BA9D118536DDC22F37D443BDDD6AC1638537D0");

  if(!istrue(var_1))
    return 0;

  return 1;
}

scoreeventhastext(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359");
  var_2 = getscoreinfocategory(var_0, "_encstr_81EF05D156E1A3");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "_encstr_B40101")
    return 0;

  return 1;
}

scoreeventpopup(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1) {
    return;
  }
  if(isDefined(self.owner) && self.owner != self)
    self.owner scoreeventpopup(var_0);

  if(!isPlayer(self)) {
    return;
  }
  var_1 = getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359");
  var_2 = getscoreinfocategory(var_0, "_encstr_81EF05D156E1A3");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "_encstr_B40101") {
    return;
  }
  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    queuescoreeventpopup(var_0);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;

    if(self.scoreeventlistsize > 5) {
      self.scoreeventlistsize = 5;
      return;
    }
  }

  self setclientomnvar("_encstr_85231593887F62375896CDFF254317ED81A18AAAB0F1D1" + self.scoreeventlistindex, var_1);
  self setclientomnvar("_encstr_88C91757B4FA9B1BDB9CCAFA56D9AC9B1DFAD8DBE6E839BD8D", self.scoreeventcount % 10);
  self.scoreeventlistindex++;
  self.scoreeventlistindex = self.scoreeventlistindex % 5;
  self.scoreeventcount++;
}

clearscoreeventlistafterwait() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_826C1F8BD14967427FC83AE3903B3B0F40453C09F6B32F8FE9C0F3C9A85B73F210");
  self endon("_encstr_826C1F8BD14967427FC83AE3903B3B0F40453C09F6B32F8FE9C0F3C9A85B73F210");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.5);
  self.scoreeventlistsize = undefined;
}

getrank() {
  var_0 = self.pers["_encstr_851207B317B203FA5A"];
  var_1 = self.pers["_encstr_A51F05CB11A052"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1))
    return var_1;
  else
    return getrankforxp(var_0);
}

getrankforxp(var_0) {
  var_1 = level.maxrank;

  if(var_0 >= getrankinfominxp(var_1))
    return var_1;
  else
    var_1--;

  while(var_1 > 0) {
    if(var_0 >= getrankinfominxp(var_1) && var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1))
      return var_1;

    var_1--;
  }

  return var_1;
}

getmatchbonusspm() {
  var_0 = getrank() + 1;
  return (3 + var_0 * 0.5) * 10;
}

getprestigelevel() {
  if(isai(self) && isDefined(self.pers["_encstr_ABF70E0EC92BB9E84B76957D33C2B6CA"]))
    return self.pers["_encstr_ABF70E0EC92BB9E84B76957D33C2B6CA"];
  else
    return self getplayerdata("_encstr_B8A30FC8463D282A65B07FF929C89DD3F0", "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");
}

getrankxp() {
  return self.pers["_encstr_851207B317B203FA5A"];
}

incrankxp(var_0, var_1, var_2, var_3) {
  if(!level.playerxpenabled) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(level._id_11B53))
    level._id_11B53 = getdvarint("_encstr_847B13A0B74ADEF57A3BAFB8551209068C47709813", 0);

  if(level._id_11B53 > 0 && getrank() + 1 >= level._id_11B53)
    var_0 = 0;

  if(isDefined(self.totalxpearned) && isDefined(self._id_11B7F)) {
    if(self.totalxpearned > self._id_11B7F)
      var_0 = 0;
    else
      self.totalxpearned = self.totalxpearned + var_0;
  }

  var_4 = getrankxp();
  var_5 = int(min(var_4 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["_encstr_A51F05CB11A052"] == level.maxrank && var_5 >= getrankinfomaxxp(level.maxrank))
    var_5 = getrankinfomaxxp(level.maxrank);

  self.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] = self.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] + var_0;
  self.pers["_encstr_851207B317B203FA5A"] = var_5;
  var_6 = "_encstr_B40101";

  if(isDefined(var_1))
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.basename);

  if(isDefined(var_6) && var_6 != "_encstr_B40101") {
    if(isDefined(self._id_13BFC) && isDefined(self._id_11B7E)) {
      if(self._id_13BFC > self._id_11B7E)
        var_2 = 0;
      else
        self._id_13BFC = self._id_13BFC + var_2;
    }
  }

  var_7 = registerpublicevent();
  var_8 = var_0 * var_7;
  var_9 = getrankxpmultipliertotal();
  var_10 = scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
  var_11 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000.0);
  self reportchallengeuserevent("_encstr_ABD0095B07D716468C3C83", var_0, scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team), var_6, var_2, var_8, int(var_9 * 100.0), int(var_10 * 100.0), int(var_7 * 100.0), var_11);
  scripts\cp\cp_analytics::_id_119BF(self, var_0, var_6, var_2, var_3);
}

registerpublicevent() {
  var_0 = registerpreviousprop();
  var_1 = remindermessage();
  var_2 = radiusdamagestepped(self);
  var_3 = var_0 * var_1 * var_2;
  return var_3;
}

syncxpstat() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");

  if(var_1 > var_0) {
    return;
  }
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B", var_0);
}

getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier))
    level.gametypexpmodifier = float(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\cp\utility::getgametype(), 17));

  return level.gametypexpmodifier;
}

addglobalrankxpmultiplier(var_0, var_1) {
  level addrankxpmultiplier(var_0, var_1);
}

getglobalrankxpmultiplier() {
  var_0 = level getrankxpmultiplier();

  if(var_0 > 4 || var_0 < 0)
    exitlevel(0);

  return var_0;
}

respawntagsfreed() {
  if(self resetclientkillstreakindexes())
    return getbnetigrweaponxpmultiplier();

  return 1.0;
}

addrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.rankxpmultipliers))
    self.rankxpmultipliers = [];

  if(isDefined(self.rankxpmultipliers[var_1]))
    self.rankxpmultipliers[var_1] = max(self.rankxpmultipliers[var_1], var_0);
  else
    self.rankxpmultipliers[var_1] = var_0;
}

getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.rankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

removeglobalrankxpmultiplier(var_0) {
  level removerankxpmultiplier(var_0);
}

removerankxpmultiplier(var_0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }
  if(!isDefined(self.rankxpmultipliers[var_0])) {
    return;
  }
  self.rankxpmultipliers[var_0] = undefined;
}

addteamrankxpmultiplier(var_0, var_1, var_2) {
  if(!level.teambased)
    var_1 = "_encstr_AF1904A7F929";

  if(!isDefined(self.teamrankxpmultipliers))
    level.teamrankxpmultipliers = [];

  if(!isDefined(level.teamrankxpmultipliers[var_1]))
    level.teamrankxpmultipliers[var_1] = [];

  if(isDefined(level.teamrankxpmultipliers[var_1][var_2]))
    level.teamrankxpmultipliers[var_1][var_2] = max(self.teamrankxpmultipliers[var_1][var_2], var_0);
  else
    level.teamrankxpmultipliers[var_1][var_2] = var_0;
}

removeteamrankxpmultiplier(var_0, var_1) {
  if(!level.teambased)
    var_0 = "_encstr_AF1904A7F929";

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[var_0])) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[var_0][var_1])) {
    return;
  }
  level.teamrankxpmultipliers[var_0][var_1] = undefined;
}

getteamrankxpmultiplier(var_0) {
  if(!level.teambased)
    var_0 = "_encstr_AF1904A7F929";

  if(!isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var_0]))
    return 1.0;

  var_1 = 1.0;

  foreach(var_3 in level.teamrankxpmultipliers[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1 = var_1 * var_3;
  }

  return var_1;
}

getrankxpmultipliertotal() {
  var_0 = getrankxpmultiplier();
  var_1 = getglobalrankxpmultiplier();
  var_2 = getteamrankxpmultiplier(self.team);
  var_3 = respawntagsfreed();
  return var_0 * var_1 * var_2 * var_3;
}

battle_tracks_playerinlisteningzoneinternal(var_0, var_1) {
  level battle_tracks_gettogglestate(var_0, var_1);
}

remindermessage() {
  var_0 = level registerpreviousprop();
  var_1 = getdvarint("_encstr_968F1ACD6CC9D7C82DDCB098C656F51E0EAFE6C685C656D717BA4BD1", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1)
    exitlevel(0);

  return var_0;
}

battle_tracks_gettogglestate(var_0, var_1) {
  var_2 = 4 / level registerpreviousprop();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self.cleanupfunc))
    self.cleanupfunc = [];

  if(isDefined(self.cleanupfunc[var_1]))
    self.cleanupfunc[var_1] = max(self.cleanupfunc[var_1], var_0);
  else
    self.cleanupfunc[var_1] = var_0;
}

registerpreviousprop() {
  if(!isDefined(self.cleanupfunc))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.cleanupfunc) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

rankedmatchupdates(var_0) {
  setxenonranks(var_0);

  if(hostidledout()) {}

  scripts\cp\agents\gametype_cp_wave_sv::updatematchbonusscores(var_0);
}

gethostplayer() {
  var_0 = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost())
      return var_0[var_1];
  }
}

hostidledout() {
  var_0 = gethostplayer();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0.selectedclass))
    return 1;

  return 0;
}

setxenonranks(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.score) || !isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]))
      continue;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.kills) || !isDefined(var_3.deaths)) {
      continue;
    }
    if(120 > var_3.timeplayed["_encstr_BE7D0633C08849E2"]) {
      continue;
    }
    var_4 = (var_3.kills - var_3.deaths) / (var_3.timeplayed["_encstr_BE7D0633C08849E2"] / 60);
    setplayerteamrank(var_3, var_3.clientid, var_4);
  }
}