/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\persistence.gsc
***********************************************/

init() {
  level.persistentdatainfo = [];
  level thread updatebufferedstats();
  level thread _id_13FC7();
  level thread uploadglobalstatcounters();
  level thread writekdhistorystats();
}

initbufferedstats() {
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];
  self.bufferedchildstats = [];
  self.bufferedchildstats["_encstr_8C4606C9DBD5CD46"] = [];
  self.bufferedchildstats["_encstr_8C4606C9DBD5CD46"]["_encstr_881A0B47B4B6B2286316E59532"] = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532");

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self.bufferedstats["_encstr_972C0B3AF63A8563A6D07B3ADC"] = self getplayerdata("_encstr_8C07031599", "_encstr_972C0B3AF63A8563A6D07B3ADC");
    self.bufferedstats["_encstr_82DD09CFCB90B55651A6EB"] = self getplayerdata("_encstr_8C07031599", "_encstr_82DD09CFCB90B55651A6EB");
    self.bufferedstats["_encstr_8EDA07FF229707BB77"] = self getplayerdata("_encstr_8C07031599", "_encstr_8EDA07FF229707BB77");
    self.bufferedstats["_encstr_88CC0521F3A13B"] = self getplayerdata("_encstr_8C07031599", "_encstr_88CC0521F3A13B");
    self.bufferedchildstats["_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A"] = [];
    self.bufferedchildstats["_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A", 0);
    self.bufferedchildstats["_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A"][1] = self getplayerdata("_encstr_8C07031599", "_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A", 1);
    self.bufferedchildstats["_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A"][2] = self getplayerdata("_encstr_8C07031599", "_encstr_8327173033BD4331A384EFF99CEA552FF13F50E9EB291AEB4A", 2);
    self.bufferedchildstatsmax["_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030"] = [];
    self.bufferedchildstatsmax["_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030", 0);
    self.bufferedchildstatsmax["_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030"][1] = self getplayerdata("_encstr_8C07031599", "_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030", 1);
    self.bufferedchildstatsmax["_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030"][2] = self getplayerdata("_encstr_8C07031599", "_encstr_8DD11ADB98DFC101A5AB60A88202F118D72275DBED07AF619673D030", 2);
    self.bufferedchildstats["_encstr_8E1420698287C998AF9E272B80DAA90D1BDBA073AAFFF5A00B612B1390BD80D3C772"] = [];
    self.bufferedchildstats["_encstr_8E1420698287C998AF9E272B80DAA90D1BDBA073AAFFF5A00B612B1390BD80D3C772"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_8E1420698287C998AF9E272B80DAA90D1BDBA073AAFFF5A00B612B1390BD80D3C772", 0);
    self.bufferedchildstatsmax["_encstr_A5D3236CD0C2D8B156E676CA6105D458C36A5DB1E8A5E0D8B42BE44596D695A0B10B5E2BC8"] = [];
    self.bufferedchildstatsmax["_encstr_A5D3236CD0C2D8B156E676CA6105D458C36A5DB1E8A5E0D8B42BE44596D695A0B10B5E2BC8"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_A5D3236CD0C2D8B156E676CA6105D458C36A5DB1E8A5E0D8B42BE44596D695A0B10B5E2BC8", 0);
    self.bufferedchildstats["_encstr_87A71DC7303150D2F503226DFD891B017BE03737204FB13ACB3F351EE3B3D2"] = [];
    self.bufferedchildstats["_encstr_87A71DC7303150D2F503226DFD891B017BE03737204FB13ACB3F351EE3B3D2"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_87A71DC7303150D2F503226DFD891B017BE03737204FB13ACB3F351EE3B3D2", 0);
    self.bufferedchildstatsmax["_encstr_A1FC20BB2B0B0EB7B92C41A685C3A9AB1B3A4B1CC696CAC9A2D26BAC05C616979523"] = [];
    self.bufferedchildstatsmax["_encstr_A1FC20BB2B0B0EB7B92C41A685C3A9AB1B3A4B1CC696CAC9A2D26BAC05C616979523"][0] = self getplayerdata("_encstr_8C07031599", "_encstr_A1FC20BB2B0B0EB7B92C41A685C3A9AB1B3A4B1CC696CAC9A2D26BAC05C616979523", 0);
    self.bufferedstats["_encstr_9207176036A1C71BD3C0A2A898335673190CFDE94F88EB28C9"] = self getplayerdata("_encstr_8C07031599", "_encstr_9207176036A1C71BD3C0A2A898335673190CFDE94F88EB28C9");
    self.bufferedstats["_encstr_AFC9216B23DDBF6B304FEDD44708360B753FB2E20BA09328D0C1E9F57B49FD87A3911A"] = self getplayerdata("_encstr_8C07031599", "_encstr_AFC9216B23DDBF6B304FEDD44708360B753FB2E20BA09328D0C1E9F57B49FD87A3911A");
    self.bufferedstatsmax["_encstr_87A024D283E0BB830B7727BB7F2DAAEC588F0F1E3B587E79DF4B3F4321DB825D997086E03158"] = self getplayerdata("_encstr_8C07031599", "_encstr_87A024D283E0BB830B7727BB7F2DAAEC588F0F1E3B587E79DF4B3F4321DB825D997086E03158");
    initbestscorestatstable();
  }
}

initbestscorestatstable() {
  var_0 = "_encstr_A2A71BE128E611ABBA2BE860721253CB63A1F566A48759F167B67018FB";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    self.bestscorestats[var_2] = self getplayerdata("_encstr_8C07031599", "_encstr_937C0BC4AC6ED14D36DE9C2BE6", var_2);
    var_1++;
  }
}

statgetchild(var_0, var_1) {
  if(var_0 == "_encstr_8C4606C9DBD5CD46")
    return self getplayerdata("_encstr_927C07D787E1823F38", var_0, var_1);
  else
    return self getplayerdata("_encstr_8C07031599", var_0, var_1);
}

statsetchild(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return;
  }
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  if(isDefined(var_3) || !scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(var_0 == "_encstr_8C4606C9DBD5CD46") {
    self setplayerdata("_encstr_927C07D787E1823F38", var_0, var_1, var_2);
    setbestscore(var_1, var_2);
  } else
    self setplayerdata("_encstr_8C07031599", var_0, var_1, var_2);
}

stataddchild(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  var_3 = self getplayerdata("_encstr_8C07031599", var_0, var_1);
  self setplayerdata("_encstr_8C07031599", var_0, var_1, var_3 + var_2);
}

statgetchildbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_2))
    return 0;

  return self.bufferedchildstats[var_0][var_1];
}

statsetchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }
  self.bufferedchildstats[var_0][var_1] = var_2;
}

stataddchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }
  var_4 = statgetchildbuffered(var_0, var_1, var_3);
  statsetchildbuffered(var_0, var_1, var_4 + var_2, var_3);
}

stataddchildbufferedwithmax(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  var_4 = statgetchildbuffered(var_0, var_1) + var_2;

  if(var_4 > var_3)
    var_4 = var_3;

  if(var_4 < statgetchildbuffered(var_0, var_1))
    var_4 = var_3;

  statsetchildbuffered(var_0, var_1, var_4);
}

updatebufferedstats() {
  wait 0.15;
  var_0 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_0 >= level.players.size)
      var_0 = 0;

    if(isDefined(level.players[var_0])) {
      level.players[var_0] writebufferedstats();
      level.players[var_0] updateweaponbufferedstats();
    }

    wait 2.0;
  }
}

_id_13FC7() {
  level endon("_encstr_8F3F0DCF1F807A39380175B16B930B");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    var_1 writebufferedstats();
    var_1 updateweaponbufferedstats();
  }

  level.disableweaponstats = 1;
}

setbestscore(var_0, var_1) {
  var_2 = scripts\mp\utility\game::onlinestatsenabled();

  if(!var_2) {
    return;
  }
  if(isDefined(self.bestscorestats[var_0]) && var_1 > self.bestscorestats[var_0]) {
    self.bestscorestats[var_0] = var_1;
    self.bufferedbestscorestats[var_0] = var_1;
  }
}

writebestscores() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      foreach(var_4, var_3 in var_1.bufferedbestscorestats)
      var_1 setplayerdata("_encstr_8C07031599", "_encstr_937C0BC4AC6ED14D36DE9C2BE6", var_4, var_3);
    }
  }
}

writebufferedstats() {
  var_0 = scripts\mp\utility\game::onlinestatsenabled();

  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats)
    self setplayerdata("_encstr_8C07031599", var_3, var_2);

    if(!isai(self)) {
      foreach(var_3, var_2 in self.squadmemberbufferedstats)
      self setplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", var_3, var_2);
    }
  }

  foreach(var_3, var_2 in self.bufferedchildstats) {
    foreach(var_8, var_7 in var_2) {
      if(var_3 == "_encstr_8C4606C9DBD5CD46") {
        self setplayerdata("_encstr_927C07D787E1823F38", var_3, var_8, var_7);
        setbestscore(var_8, var_7);
        continue;
      }

      if(var_0)
        self setplayerdata("_encstr_8C07031599", var_3, var_8, var_7);
    }
  }
}

writekdhistorystats() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.1;

  if(scripts\mp\utility\game::waslastround() || !scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::hittimelimit()) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(var_1.pers["_encstr_ABAB0B8A63871B13AD20BBEFA0"]) && var_1.pers["_encstr_ABAB0B8A63871B13AD20BBEFA0"] > 0) {
        var_3 = var_1.pers["_encstr_ABAB0B8A63871B13AD20BBEFA0"];
        var_4 = 0;

        if(isDefined(var_1.pers["_encstr_826D099BD308330249988B"]))
          var_4 = var_1.pers["_encstr_826D099BD308330249988B"];

        var_2 = int(100 * (var_4 / var_3));
      }

      var_1 incrementrankedreservedhistory(var_1.kills, var_1.deaths, var_1.pers["_encstr_96D30A3468575BA3C307A128"], var_2, var_1.pers["_encstr_B2BE0788BAF573592F"]);
    }
  }
}

incrementrankedreservedhistory(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  for(var_5 = 0; var_5 < 4; var_5++) {
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_81F60B6BC9415CC735F83BB344", var_5 + 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_81F60B6BC9415CC735F83BB344", var_5, var_6);
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_A3F60BAF3C6C99C87B0D8EBBA3", var_5 + 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_A3F60BAF3C6C99C87B0D8EBBA3", var_5, var_6);
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_92BA10988A86298B4B9FCDDB61DF93F7AAD3", var_5 + 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_92BA10988A86298B4B9FCDDB61DF93F7AAD3", var_5, var_6);
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_8E2C101A10CF5BCBD14689A06BBB1B655568", var_5 + 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_8E2C101A10CF5BCBD14689A06BBB1B655568", var_5, var_6);
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_A2120EB2D9417F272899796BC950AAA7", var_5 + 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_A2120EB2D9417F272899796BC950AAA7", var_5, var_6);
  }

  self setplayerdata("_encstr_8C07031599", "_encstr_81F60B6BC9415CC735F83BB344", 4, int(clamp(var_0, 0, 255)));
  self setplayerdata("_encstr_8C07031599", "_encstr_A3F60BAF3C6C99C87B0D8EBBA3", 4, int(clamp(var_1, 0, 255)));
  self setplayerdata("_encstr_8C07031599", "_encstr_92BA10988A86298B4B9FCDDB61DF93F7AAD3", 4, int(clamp(var_2, 0, 255)));
  self setplayerdata("_encstr_8C07031599", "_encstr_8E2C101A10CF5BCBD14689A06BBB1B655568", 4, int(var_3));
  self setplayerdata("_encstr_8C07031599", "_encstr_A2120EB2D9417F272899796BC950AAA7", 4, var_4);
}

incrementweaponstat(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0)) {
    return;
  }
  if(istrue(level.disableweaponstats)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_0, var_1);
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_0, var_1, var_3 + var_2);
  }
}

incrementattachmentstat(var_0, var_1, var_2, var_3) {
  if(istrue(level.disableweaponstats)) {
    return;
  }
  if(!scripts\mp\utility\weapon::attachmentlogsstats(var_0, var_3)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_4 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9AD211F9AD1B175659E82A92C887829B111553", var_0, var_1);
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9AD211F9AD1B175659E82A92C887829B111553", var_0, var_1, var_4 + var_2);
  }
}

updateweaponbufferedstats(var_0) {
  if(!isDefined(self.trackingweapon)) {
    return;
  }
  if(nullweapon(self.trackingweapon)) {
    return;
  }
  if(scripts\mp\utility\weapon::issuperweapon(self.trackingweapon)) {
    if(!istrue(scripts\mp\supers::shouldtracksuperweaponstats(self.trackingweapon)))
      return;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(self.trackingweapon) || scripts\mp\utility\weapon::isenvironmentweapon(self.trackingweapon) || scripts\mp\utility\weapon::isbombsiteweapon(self.trackingweapon)) {
    return;
  }
  var_1 = self.trackingweapon;
  var_2 = undefined;

  if(var_1.isalternate) {
    var_3 = scripts\mp\utility\weapon::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "_encstr_A65B084B38A76BEFC350" || var_3 == "_encstr_8A07035972" || var_3 == "_encstr_AA7608ECD89B6BDE5B59" || var_3 == "_encstr_97D506F770BFFFBB" || var_3 == "_encstr_ADBD0780C4884FEE86" || var_3 == "_encstr_873708FFA8104C0AAEC1" || var_3 == "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5" || var_3 == "_encstr_A78B09ECB16E2B5B47590F" || var_3 == "_encstr_8435070CAC0F080BD2") {
      var_2 = var_3;
      perslog_attachmentstats(var_2, var_1);
      persclear_stats();
      return;
    }
  }

  if(!isDefined(var_2)) {
    var_4 = var_1.basename;

    if(getsubstr(var_4, 0, 4) == "_encstr_83C5052DBBC1FA" || getsubstr(var_4, 0, 3) == "_encstr_81190403FB70")
      var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_2) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_2)) {
    return;
  }
  var_5 = getweaponvariantindex(var_1);
  persincrement_weaponstats(var_2, var_5);

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo))
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && getdvarint("_encstr_88ED216E6CC9BE3A27B036B57D38D2C6D69591D7BA38D7772B0B0EB737D7DC3A2CA39B", 1) == 1;

  if(!scripts\mp\utility\weapon::ispickedupweapon(var_1) || istrue(level.get_audio_approved_length_extender_for_non_english_vo))
    perslog_weaponstats(var_2, var_5, var_0);

  var_6 = getweaponattachments(var_1);

  foreach(var_3 in var_6) {
    var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_3);

    if(!scripts\mp\utility\weapon::attachmentlogsstats(var_8, var_1)) {
      continue;
    }
    switch (var_8) {
      case "_encstr_A65B084B38A76BEFC350":
      case "_encstr_8435070CAC0F080BD2":
      case "_encstr_A78B09ECB16E2B5B47590F":
      case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
      case "_encstr_873708FFA8104C0AAEC1":
      case "_encstr_ADBD0780C4884FEE86":
      case "_encstr_97D506F770BFFFBB":
      case "_encstr_AA7608ECD89B6BDE5B59":
      case "_encstr_8A07035972":
        continue;
    }

    perslog_attachmentstats(var_8, var_1);
  }

  persclear_stats();
}

persclear_stats() {
  self.trackingweapon = isundefinedweapon();
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self.trackingweaponhits = 0;
  self.trackingweaponheadshots = 0;
  self.trackingweapondeaths = 0;
}

persincrement_weaponstats(var_0, var_1) {
  if(self.trackingweaponshots > 0)
    incrementweaponstat(var_0, "_encstr_884806B91ADEE8CD", self.trackingweaponshots);

  if(self.trackingweaponkills > 0)
    incrementweaponstat(var_0, "_encstr_8E8D0697EB01F243", self.trackingweaponkills);

  if(self.trackingweaponhits > 0)
    incrementweaponstat(var_0, "_encstr_88CC0521F3A13B", self.trackingweaponhits);

  if(self.trackingweaponheadshots > 0)
    incrementweaponstat(var_0, "_encstr_96D30A3468575BA7C307A128", self.trackingweaponheadshots);

  if(self.trackingweapondeaths > 0)
    incrementweaponstat(var_0, "_encstr_8E0607055DBFB3919A", self.trackingweapondeaths);
}

perslog_weaponstats(var_0, var_1, var_2) {
  if(self.trackingweaponshots > 0)
    scripts\common\utility::_id_13E0A(level._id_11B31, var_0, "_encstr_884806B91ADEE8CD", self.trackingweaponshots, var_1, var_2);

  if(self.trackingweaponkills > 0)
    scripts\common\utility::_id_13E0A(level._id_11B31, var_0, "_encstr_8E8D0697EB01F243", self.trackingweaponkills, var_1, var_2);

  if(self.trackingweaponhits > 0)
    scripts\common\utility::_id_13E0A(level._id_11B31, var_0, "_encstr_88CC0521F3A13B", self.trackingweaponhits, var_1, var_2);

  if(self.trackingweaponheadshots > 0)
    scripts\common\utility::_id_13E0A(level._id_11B31, var_0, "_encstr_96D30A3468575BA3C307A128", self.trackingweaponheadshots, var_1, var_2);

  if(self.trackingweapondeaths > 0)
    scripts\common\utility::_id_13E0A(level._id_11B31, var_0, "_encstr_8E0607055DBFB3919A", self.trackingweapondeaths, var_1, var_2);
}

perslog_attachmentstats(var_0, var_1) {
  if(!scripts\mp\utility\weapon::attachmentlogsstats(var_0, var_1)) {
    return;
  }
  if(self.trackingweaponshots > 0 && var_0 != "_encstr_99C209E34FC743616118AB") {
    incrementattachmentstat(var_0, "_encstr_884806B91ADEE8CD", self.trackingweaponshots, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B25, var_0, "_encstr_884806B91ADEE8CD", self.trackingweaponshots, var_1);
  }

  if(self.trackingweaponkills > 0 && var_0 != "_encstr_99C209E34FC743616118AB") {
    incrementattachmentstat(var_0, "_encstr_8E8D0697EB01F243", self.trackingweaponkills, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B25, var_0, "_encstr_8E8D0697EB01F243", self.trackingweaponkills, var_1);
  }

  if(self.trackingweaponhits > 0 && var_0 != "_encstr_99C209E34FC743616118AB") {
    incrementattachmentstat(var_0, "_encstr_88CC0521F3A13B", self.trackingweaponhits, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B25, var_0, "_encstr_88CC0521F3A13B", self.trackingweaponhits, var_1);
  }

  if(self.trackingweaponheadshots > 0 && var_0 != "_encstr_99C209E34FC743616118AB") {
    incrementattachmentstat(var_0, "_encstr_96D30A3468575BA7C307A128", self.trackingweaponheadshots, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B25, var_0, "_encstr_96D30A3468575BA7C307A128", self.trackingweaponheadshots, var_1);
  }

  if(self.trackingweapondeaths > 0) {
    incrementattachmentstat(var_0, "_encstr_8E0607055DBFB3919A", self.trackingweapondeaths, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B25, var_0, "_encstr_8E0607055DBFB3919A", self.trackingweapondeaths, var_1);
  }
}

uploadglobalstatcounters() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in level.players)
  var_5 = var_5 + var_7.timeplayed["_encstr_BE7D0633C08849E2"];

  getentitylessscriptablearray("_encstr_AA5C1AF4B96017514BC8228AC0E797F3D81679645848772543302A53", ["_encstr_86EB0A077D2EBBFDF8211D63", int(var_5 / 60)]);

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }
  waitframe();

  foreach(var_7 in level.players) {
    var_0 = var_0 + var_7.kills;
    var_1 = var_1 + var_7.deaths;
    var_2 = var_2 + var_7.assists;
    var_3 = var_3 + var_7 scripts\mp\utility\stats::getpersstat("_encstr_96D30A3468575BA3C307A128");
    var_4 = var_4 + var_7 scripts\mp\utility\stats::getpersstat("_encstr_A68209DFE7B79AEC5BF76E");
  }

  getentitylessscriptablearray("_encstr_8D3618BD957A476EE5A35818B307A199C2BEA73121520330C45F", ["_encstr_86EB0A077D2EBBFDF8211D63", var_0]);
  getentitylessscriptablearray("_encstr_9ADE19B959EF6701DA2C6920D119D0DB9543AF1AA711927FA338F7", ["_encstr_86EB0A077D2EBBFDF8211D63", var_1]);
  getentitylessscriptablearray("_encstr_B1B41CE5CD221F26AD1B90C07BFF79518AF6EF79E9AAD329941780D0430B", ["_encstr_86EB0A077D2EBBFDF8211D63", var_3]);
  getentitylessscriptablearray("_encstr_8EB71B8FA147EAFF091827036026BF222FCE560580A7030111D83B5740", ["_encstr_86EB0A077D2EBBFDF8211D63", var_4]);
  getentitylessscriptablearray("_encstr_82E3184291451858CF9BEB8B1311B049906E1994F93823AD8850", ["_encstr_86EB0A077D2EBBFDF8211D63", 1]);

  if(!isDefined(level.assists_disabled))
    getentitylessscriptablearray("_encstr_8FEA1A6CE0B7EF395DC557860B4F2A6A9028F6A43937203F601FCB53", ["_encstr_86EB0A077D2EBBFDF8211D63", var_2]);
}

touchedmovingplatform() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  for(var_0 = 4; var_0 > 0; var_0--) {
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_AD86115B635DD64B54EBE77E817A5BD1C802E3", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_AD86115B635DD64B54EBE77E817A5BD1C802E3", var_0, var_1);
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7271557E6CAAF0E96CD76BE2C8DDAF50D966E47B79C5E", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_A7271557E6CAAF0E96CD76BE2C8DDAF50D966E47B79C5E", var_0, var_1);
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_8D1217108BE77FCB6FBE64708D4B51D348D17008637BA7C347", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_8D1217108BE77FCB6FBE64708D4B51D348D17008637BA7C347", var_0, var_1);
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_9B471567FA6267AAEB8398A2A8F778F710BC1FFCB0C843", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_9B471567FA6267AAEB8398A2A8F778F710BC1FFCB0C843", var_0, var_1);
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_9240139B0337915EF73B788312471B68CA7C270DA1", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_9240139B0337915EF73B788312471B68CA7C270DA1", var_0, var_1);
    var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_86831BD3EB35F7D23853D3DC0FA01D67E760AA4BB180E30CF069F7C23B", var_0 - 1);
    self setplayerdata("_encstr_8C07031599", "_encstr_86831BD3EB35F7D23853D3DC0FA01D67E760AA4BB180E30CF069F7C23B", var_0, var_1);
  }

  self setplayerdata("_encstr_8C07031599", "_encstr_AD86115B635DD64B54EBE77E817A5BD1C802E3", 0, 0);
  self setplayerdata("_encstr_8C07031599", "_encstr_A7271557E6CAAF0E96CD76BE2C8DDAF50D966E47B79C5E", 0, 0);
  self setplayerdata("_encstr_8C07031599", "_encstr_8D1217108BE77FCB6FBE64708D4B51D348D17008637BA7C347", 0, 0);
  self setplayerdata("_encstr_8C07031599", "_encstr_9B471567FA6267AAEB8398A2A8F778F710BC1FFCB0C843", 0, 0);
  self setplayerdata("_encstr_8C07031599", "_encstr_9240139B0337915EF73B788312471B68CA7C270DA1", 0, 0);
  self setplayerdata("_encstr_8C07031599", "_encstr_86831BD3EB35F7D23853D3DC0FA01D67E760AA4BB180E30CF069F7C23B", 0, 0);
}