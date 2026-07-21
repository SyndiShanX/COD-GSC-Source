/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\pet_watch.gsc
***********************************************/

init() {
  if(!isDefined(level.petconsts) && !scripts\common\utility::iscp())
    level thread checkgreenmassacre();

  level.petconsts = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 1);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_1 = int(var_1);
    var_2 = spawnStruct();
    var_2.phasetime = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 2));
    var_2.bonustimemax = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 3));
    var_2.boredomrate = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 4));
    var_2.dirtyrate = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 5));
    var_2.unrulyrate = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 6));
    var_2.hungryrate = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 7));
    var_2.bonustype = tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 8);
    var_2.boredstart = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 9));
    var_2.dirtystart = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 10));
    var_2.unrulystart = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 11));
    var_2.hungrystart = int(tablelookupbyrow("_encstr_BD0A1593388DC08DEB4101AB2AB32DF0768C1B9DD34238", var_0, 12));
    level.petconsts[var_1] = var_2;
    var_0++;
  }

  level._id_12309 = [];
  level._id_12309["_encstr_A1BD075837DCD29B47"] = 1;
  level._id_12309["_encstr_B82009D8DBE6D9CDD0B7E8"] = 1;
  level._id_12309["_encstr_A90B0B68C75085F316A022DA28"] = 1;
  level._id_12309["_encstr_848909BBD3A7526348E8E3"] = 1;
  level._id_12309["_encstr_977C08697BE705EAA5E3"] = 1;
  level._id_12309["_encstr_95840E3FB94BF8601B9291187A27ADA0"] = 1;
  level._id_12309["_encstr_93150B9B625FB5C8DBEDA79B1B"] = 1;
  level._id_12309["_encstr_811F08C0C726E1953267"] = 1;
  level._id_12309["_encstr_85E10B66B44E6EA3981BBDDE91"] = 1;
  level._id_12309["_encstr_92DF0956DA8F69425F23C8"] = 1;
  level._id_12309["_encstr_87CC098985C65B662D4E59"] = 1;
  level._id_12309["_encstr_A74E0A83F3D19018DA570319"] = 1;
  level._id_12309["_encstr_977411D0727A0F638F88C9B7738FCEE7648A38"] = 1;
  level._id_12309["_encstr_862509E16B2BE74B6BA8E8"] = 1;
  level._id_12309["_encstr_A5340F12B809E7C7BAAFDFC9AF213F2B81"] = 1;
  level._id_12309["_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72"] = 1;
}

checkgreenmassacre() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1.petwatch))
        var_1 feedaction();
    }

    wait 1;
  }
}

setstate(var_0, var_1) {
  self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", var_0 * -1);
  self.petwatch.phase = var_0;
  updateuistate();
}

doaction(var_0) {
  switch (var_0) {
    case 1:
      growpet();
      break;
    case 2:
      feedaction();
      break;
    case 3:
      thread updatepetstatesincelastupdate();
      break;
    case 4:
      initpet(1);
      break;
    case 6:
      initpet(1, "_encstr_A1270A78AAE3BF49BB71A6AA");
      break;
    case 5:
      initpet(1, "_encstr_A7730AAB40E32F3393461E55");
      break;
    case 7:
      initpet(1, "_encstr_A7730AAB40E32F3393461E55", 1);
      break;
  }
}

growpet() {
  var_0 = level.petconsts[self.petwatch.phase].phasetime;
  self.petwatch.growthtime = var_0;
  debugsetlasttime(var_0);
}

_id_12044() {
  self.petwatch = undefined;
}

_id_13E38() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8EFE1B74EB909EB727B95B102087F35570B51FED37A0A35FD35133AE60");
  self endon("_encstr_8EFE1B74EB909EB727B95B102087F35570B51FED37A0A35FD35133AE60");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_BE3214889F7CEBC3BB2EDB48C3832DF1DFDFA810CF17") {
      switch (var_1) {
        case 1:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_A59813336734F8F70BDF89DFBB234698F77119290F");
          break;
        case 2:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_A75C14AFFD4B7363BB9AF04183933DA94F5F3EAF52A7");
          break;
        case 3:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_AFC015030B85CBD910C1BC491B20F252D0E7C79BFB2142");
          break;
        case 4:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_88D6160E563A77C21D6C34EB8EBAE498BDD7A3B22B37AF0B");
          break;
        case 5:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_96D6163268DD17E1CD0B9949792308D39FDFE045B7465626");
          break;
        case 6:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_9A4815308DB3E76ED930A2E9B0E3627B0878BBD31D582F");
          break;
        case 7:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_8A5C1460676CBFD00BF799F18BAD82B8CA19D3ADB91E");
          break;
        case 8:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_973C1678B58BDFA611E86A11783B5A334030FDE158D3EFEA");
          break;
        case 9:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BDC71457372B874914D710B1934D63E5E2D1CDDE8F43");
          break;
        case 10:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_917E172F7DCBF3E33B1A70C10313BD29CFDF382EC47FDB0322");
          break;
        case 11:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_9698138317F493BB33B653F04B1BA579476738800B");
          break;
        case 12:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_9691173895D1BB851D6C1AD73A5DC9C4EDD737CAB139ACE898");
          break;
        case 13:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_8891170756E8BB58D18DA1AF1DAE93C47BAFE62BC6E42B8E8C");
          break;
        case 14:
          self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_819117B3E7B478778B5F095F3BA3C61877F15BE98E1A50B597");
          break;
        default:
          break;
      }

      continue;
    }

    if(var_0 == "_encstr_8FD2156AC09BAFE00307D886A8E322F67FA1282336794D")
      self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", var_1);
  }
}

initpet(var_0, var_1, var_2) {
  if(!isDefined(self.petwatch)) {
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 0);
    self.petwatch = spawnStruct();
    self.petwatch._id_12314 = var_1;

    if(var_1 == "_encstr_A1270A78AAE3BF49BB71A6AA")
      self.petwatch._id_12533 = "_encstr_A30A12CB57C04C5E886A2B75792BA7603D97DF92";
    else if(var_1 == "_encstr_A7730AAB40E32F3393461E55") {
      self.petwatch._id_12533 = "_encstr_82A712A87A339F19EB23736D39B341D1DBB3B0C8";
      thread _id_13E38();
    } else
      self.petwatch._id_12533 = "_encstr_BE630D6B93D55CD7987A9C4BEEB0DE";

    if(var_0 && !istrue(var_2)) {
      self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", -1);
      setphase(0);
    } else
      setphase(self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_846B0642D9E9E35F"));
  } else {
    if(var_0) {
      self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", -1);
      setphase(0);
    }

    if(self.petwatch.phase == 0)
      resetpet(1);

    if(!istrue(var_0))
      return;
  }

  self.petwatch.isvalidcustomweapon = 0;

  if(self.petwatch.phase == 0)
    resetpet(1);
  else {
    self.petwatch.bonustime = 0;
    self.petwatch.currentbestdist = 0;
    self.petwatch.lastupdatetime = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_95100F814B4B49E17BBB577BC9439FED6B");
    self.petwatch.bored = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_96FF09B5CF53C558C4DD61");
    self.petwatch.dirty = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B84C093B7B9EE3D9B93857");
    self.petwatch.unruly = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_85230A93B025E30B9A8DC5C7");
    self.petwatch.hungry = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_91740A63A04098D38B6D2DEF");
    self.petwatch.currentbestdist = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8B940A1E3055DBE31FD0173F");
    self.petwatch.charged = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B67808D80D16C9765932");
    self.petwatch.growthtime = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_85C20BB973EFF4E85C14EBEB4D");
    self.petwatch.reproductionstreak = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8BE8133547D3EEA084BB817BA46760B66BF3839BC7");
    self.petwatch.damage = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B2BE0788BAF573592F");
    self.petwatch.waittill_player_pings_location = self.petwatch.bored;
    self.petwatch.waittillarenaplayersnotcapturing = self.petwatch.dirty;
    self.petwatch.watch_for_players_in_plane_trigger = self.petwatch.unruly;
    self.petwatch.waittoshow = self.petwatch.hungry;
    var_3 = self.petwatch.reproductionstreak % 10;
    var_4 = var_3 / 10;
    self.petwatch.growthtime = self.petwatch.growthtime + var_4;
    self.petwatch.currentbestdist = self.petwatch.currentbestdist + var_4;
    self.petwatch.reproductionstreak = int(self.petwatch.reproductionstreak / 10);
    self.petwatch._id_13F07 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_866E0BB8826E0F696FFFF00D2B");
    self.petwatch._id_140E2 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_911F0DC6101951196F217A191AF5AA");
    self.petwatch.dragonpoints = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_829E0D091AE9B03872DB7F7B0BFB7E");
    self.petwatch.current_volume_num = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A021152C8D15B32501D6569C7013CB706A10A");
    self.petwatch.currentbestpos = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_82DC0FC4C1F8ACDF5DA5FFCF8BFF73581D");
    self.petwatch.current_zone = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_AF8115B731A9ACC6D1B43B2B4DB1DEE42BA11A2C27D9CA");
    self.petwatch.current_volume_enemy = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_87250C87FB11E2530118569A11D8");
    self.petwatch.topkillstreakcharge = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8D211453F82F374440F1434CA5600ECFCE709ABB410D");
    self.petwatch.nukecharge = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A610BE6BAB6ACA1340B279D59");
    self.petwatch.wingamestop3 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A510D53E4AEF9771A473F4957F366");
    self.petwatch.plantscharge = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_A5870DA38A99B3FB78EED12B061C38");
    self.petwatch.executionscharge = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_859B11A2FA4577A3A0DB7F76C7312CC776B13A");
    self.petwatch.objectivescorecharge = 0;
    self.petwatch.killstreakcharge = 0;
    self.petwatch.wingamescharge = 0;
    self.petwatch.killscharge = 0;
    self.petwatch.waittothrowsmoke = 0;
    self.petwatch.waittill_player_uses_assassination_contract = 0;
    self.petwatch.watch_for_players_joining = 0;
    self.petwatch.waittillhuntersdrop = 0;
  }

  updateuistate();
}

gethours(var_0) {
  var_1 = 3600;
  return int(var_0 / var_1);
}

gethourtime(var_0) {
  var_1 = 3600;
  var_2 = 24 * var_1;
  var_3 = var_2 * 365.25;
  var_4 = var_0 / int(var_3);
  var_5 = int(var_0 % var_3) / int(var_2);
  var_6 = int(var_0 % var_2) / int(var_1);
  return int(var_6);
}

testtiming() {
  var_0 = getsystemtime();
  var_1 = var_0 - 300;
  var_2 = var_0 - 7200;
  var_3 = var_0 - 3480;
  var_4 = var_0 - 3720;
  var_5 = var_0 - 43200;
  var_6 = var_0 - 86400;
  var_7 = var_6 - 43200;
  var_8 = var_0 - 604800;
  var_9 = hoursawakesincelastupdate(var_0, var_1).spawn_real_number;
  var_10 = hoursawakesincelastupdate(var_0, var_3).spawn_real_number;
  var_11 = hoursawakesincelastupdate(var_0, var_4).spawn_real_number;
  var_12 = hoursawakesincelastupdate(var_0, var_2).spawn_real_number;
  var_13 = hoursawakesincelastupdate(var_0, var_5).spawn_real_number;
  var_14 = hoursawakesincelastupdate(var_0, var_6).spawn_real_number;
  var_15 = hoursawakesincelastupdate(var_0, var_7).spawn_real_number;
  var_16 = hoursawakesincelastupdate(var_0, var_8).spawn_real_number;
  var_17 = 1;
}

printplayerdatastats() {
  var_0 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_846B0642D9E9E35F");
  var_1 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_95100F814B4B49E17BBB577BC9439FED6B");
  var_2 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_96FF09B5CF53C558C4DD61");
  var_3 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B84C093B7B9EE3D9B93857");
  var_4 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_85230A93B025E30B9A8DC5C7");
  var_5 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_91740A63A04098D38B6D2DEF");
  var_6 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8B940A1E3055DBE31FD0173F");
  var_7 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B67808D80D16C9765932");
  var_8 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_85C20BB973EFF4E85C14EBEB4D");
  var_9 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8BE8133547D3EEA084BB817BA46760B66BF3839BC7");
  var_10 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_B2BE0788BAF573592F");
  var_11 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_866E0BB8826E0F696FFFF00D2B");
  var_12 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_911F0DC6101951196F217A191AF5AA");
  var_13 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_829E0D091AE9B03872DB7F7B0BFB7E");
  var_14 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A021152C8D15B32501D6569C7013CB706A10A");
  var_15 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_82DC0FC4C1F8ACDF5DA5FFCF8BFF73581D");
  var_16 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_AF8115B731A9ACC6D1B43B2B4DB1DEE42BA11A2C27D9CA");
  var_17 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_87250C87FB11E2530118569A11D8");
  var_18 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8D211453F82F374440F1434CA5600ECFCE709ABB410D");
  var_19 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A610BE6BAB6ACA1340B279D59");
  var_20 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_8A510D53E4AEF9771A473F4957F366");
  var_21 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_A5870DA38A99B3FB78EED12B061C38");
  var_22 = self getplayerdata("_encstr_927C07D787E1823F38", self.petwatch._id_12533, "_encstr_859B11A2FA4577A3A0DB7F76C7312CC776B13A");
}

testpetdebug(var_0) {
  if(var_0 > 16 && !isDefined(self.petwatch))
    initpet(1, "_encstr_A7730AAB40E32F3393461E55");

  if(!isDefined(self.petwatch)) {
    return;
  }
  switch (var_0) {
    case 1:
      testtiming();
      break;
    case 2:
      printplayerdatastats();
      break;
    case 3:
      addkillcharge();
      break;
    case 4:
      begin_spectate();
      break;
    case 5:
      addobjectivescorecharge("_encstr_8E75065022EE9391", 1);
      break;
    case 6:
      addobjectivescorecharge("_encstr_8E75065022EE9391", 10);
      break;
    case 7:
      addwatchchargewin();
      break;
    case 8:
      addplantingcharge();
      break;
    case 9:
      addexecutioncharge();
      break;
    case 10:
      addwatchchargewintop3();
      break;
    case 11:
      addtopkillstreakcharge();
      break;
    case 12:
      addnukecharge();
      break;
    case 13:
      self.petwatch.damage = 0;
      updateuistate();
      break;
    case 14:
      self.petwatch.damage = 900;
      updateuistate();
      break;
    case 15:
      self.petwatch.damage = 500;
      updateuistate();
      break;
    case 16:
      addkillstreakcharge();
      break;
    case 17:
      self setclientomnvar("_encstr_853D183340911BB2EFBD8337AF876B4350EEAC7D5BE8C28A3699", 2);
      break;
    case 18:
      self setclientomnvar("_encstr_853D183340911BB2EFBD8337AF876B4350EEAC7D5BE8C28A3699", 3);
      break;
    case 19:
      self setclientomnvar("_encstr_853D183340911BB2EFBD8337AF876B4350EEAC7D5BE8C28A3699", 4);
      break;
    case 20:
      self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_BE3214889F7CEBC3BB2EDB48C3832DF1DFDFA810CF17", 1);
      break;
    case 21:
      self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_BE3214889F7CEBC3BB2EDB48C3832DF1DFDFA810CF17", 2);
      break;
    case 22:
      self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_BE3214889F7CEBC3BB2EDB48C3832DF1DFDFA810CF17", 3);
      break;
  }
}

hoursawakesincelastupdate(var_0, var_1, var_2) {
  var_3 = gethourtime(var_0);
  var_4 = gethours(var_0 - var_1);
  var_5 = max(0, var_4);
  var_6 = spawnStruct();
  var_6.spawn_real_number = var_5;
  return var_6;
}

updatepetstatesincelastupdate(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  return;
}

begin_vo() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.wingamescharge++;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 80000 + self.petwatch.wingamescharge);
  }
}

addkillstreakcharge() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.current_volume_num++;
    self.petwatch.killstreakcharge++;
    self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 30000 + self.petwatch.killstreakcharge);
  }
}

battle_tracks_getplayerdataenum() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
    self setclientomnvar("_encstr_8A921C8DA1CEE03AFB077C2933477AD911C7C0F3DAC9A2073A1B72852EE6", 20000);
}

bearwatch() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.plantscharge++;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 40000 + self.petwatch.plantscharge);
  }
}

battle_tracks_vehicleallowlisteningoutsideoccupancy() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 40000);
}

battle_tracks_standingonsamevehiclewithsametracksowner() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.nukecharge++;
    self setclientomnvar("_encstr_B2921C9B980139EA1310BF91D9AABA971EB780F7B3C7AFD7BB9D41E8A9A1", 10000 + self.petwatch.nukecharge);
  }
}

bhasriotshieldattached() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 90000 + self.petwatch.wingamestop3);
  }
}

round_vehicle_logic() {
  var_0 = level.gametype;

  if(var_0 == "_encstr_B607038AAB") {
    var_1 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101");

    if(var_1 != "_encstr_B40101")
      return var_1;
  }

  return var_0;
}

below_player_eye_allowance() {
  var_0 = round_vehicle_logic();

  if(level.gametype == "_encstr_B607038AAB" && (var_0 == "_encstr_B607038AAB" || var_0 == "_encstr_AFDD05A6AB763B" || var_0 == "_encstr_87A205AF50D049")) {
    if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
      self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 90000);
  }
}

bhasthermitestucktoshield() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 80000);
}

_id_13FBD() {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91")) {
    return;
  }
  var_0 = game["_encstr_8DC30DAA0285FD69FAE113371B1934"];

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_2];
    var_4 = var_3 / level.winlimit;
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91")]](var_2, "_encstr_9775086022BE1B413B8B");

    foreach(var_7 in var_5) {
      if(isDefined(var_7.petwatch) && var_7.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
        var_7 _id_13E23(var_4, 2);
    }
  }
}

_id_13E23(var_0, var_1) {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    var_0 = min(1.0, var_0);
    self setclientomnvar("_encstr_B2921C9B980139EA1310BF91D9AABA971EB780F7B3C7AFD7BB9D41E8A9A1", 50000 + int(var_0 * 10) + var_1 * 100);
  }
}

_id_13C43(var_0) {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    if(!isDefined(var_0.get_search_node_closest_to_spotlight_goal_node)) {
      var_0.get_search_node_closest_to_spotlight_goal_node = [];
      var_0.get_safe_set_spawn_weapons = [];
    }

    var_1 = -1;

    foreach(var_4, var_3 in var_0.get_search_node_closest_to_spotlight_goal_node) {
      if(var_3 == self) {
        var_1 = var_4;
        break;
      }
    }

    if(var_1 == -1) {
      var_1 = var_0.get_search_node_closest_to_spotlight_goal_node.size;
      var_0.get_search_node_closest_to_spotlight_goal_node[var_1] = self;
      var_0.get_safe_set_spawn_weapons[var_1] = 1;
    } else
      var_0.get_safe_set_spawn_weapons[var_1]++;

    _id_13E23(var_0.get_safe_set_spawn_weapons[var_1] / 10, 3);
  }
}

getfullweaponobjforscriptablepartname() {
  if(isDefined(self.get_search_node_closest_to_spotlight_goal_node)) {
    var_0 = 0;

    foreach(var_4, var_2 in self.get_search_node_closest_to_spotlight_goal_node) {
      var_3 = isDefined(var_2.petwatch) && var_2.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55";

      if(!var_3) {
        continue;
      }
      var_0 = self.get_safe_set_spawn_weapons[var_4];

      if(var_0 >= 10)
        var_2 setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 10000);
    }
  }
}

getfullweaponobjforpickup(var_0) {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    if(isDefined(var_0.get_search_node_closest_to_spotlight_goal_node)) {
      var_1 = 0;

      foreach(var_4, var_3 in var_0.get_search_node_closest_to_spotlight_goal_node) {
        if(var_3 == self) {
          var_1 = var_0.get_safe_set_spawn_weapons[var_4];
          break;
        }
      }

      if(var_1 >= 10)
        self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 10000);
    }
  }
}

addnukecharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.nukecharge++;
    var_0 = 10000 + self.petwatch.nukecharge;

    if(self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
      var_0 = var_0 + 100;

    self setclientomnvar("_encstr_B2921C9B980139EA1310BF91D9AABA971EB780F7B3C7AFD7BB9D41E8A9A1", var_0);
  }
}

addtopkillstreakcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.topkillstreakcharge++;
    self setclientomnvar("_encstr_8A921C8DA1CEE03AFB077C2933477AD911C7C0F3DAC9A2073A1B72852EE6", 20000 + self.petwatch.topkillstreakcharge);
  }
}

battle_tracks_getnewtogglestate() {
  if(isDefined(self.petwatch))
    self setclientomnvar("_encstr_8A921C8DA1CEE03AFB077C2933477AD911C7C0F3DAC9A2073A1B72852EE6", 20001);
}

addplantingcharge() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 != "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.plantscharge++;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 40000 + self.petwatch.plantscharge);
  }
}

addobjectivescorecharge(var_0, var_1) {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 != "_encstr_A7730AAB40E32F3393461E55" && (!istrue(level._id_12309[var_0]) && !issubstr(var_0, "_encstr_ABD70578F3D02C"))) {
    self.petwatch.current_zone = self.petwatch.current_zone + var_1;
    self.petwatch.objectivescorecharge = self.petwatch.objectivescorecharge + var_1;
    self setclientomnvar("_encstr_85921CDB33378BF51B617F2F10D1A02125586553A68F123923F00F233183", 50000 + self.petwatch.objectivescorecharge);
  }
}

begin_spectate() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge = self.petwatch.killscharge + 10;
    self.petwatch.current_volume_enemy = self.petwatch.current_volume_enemy + 10;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 60000 + self.petwatch.killscharge);
  }
}

addkillcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge++;
    self.petwatch.current_volume_enemy++;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 60000 + self.petwatch.killscharge);
  }
}

addexecutioncharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.executionscharge++;
    self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 70000 + self.petwatch.executionscharge);
  }
}

addwatchchargewin() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 != "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.currentbestpos++;
    self.petwatch.wingamescharge++;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", 80000 + self.petwatch.wingamescharge);
    feedaction();
  }
}

addwatchchargewintop3() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 != "_encstr_A7730AAB40E32F3393461E55") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 90000 + self.petwatch.wingamestop3);
  }
}

_id_1230A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AA9919B1169B1B2B637D0756E8EB83D8AB9B465627AFA3966BCA4E");
  self.petwatch._id_127CF = 1;
  var_0 = 180.0;
  var_1 = var_0 / 5;

  for(var_2 = 1; var_2 <= 5; var_2++) {
    wait(var_1);
    _id_13E23(var_2 / 5, 4);
  }

  battle_tracks_vehicleallowlisteningoutsideoccupancy();
}

_id_13FFD(var_0) {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")
    _id_13E23(var_0, 1);
}

_id_1206D() {
  if(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    if(self.plundercount > 5000) {
      if(!isDefined(self.petwatch._id_127CF))
        thread _id_1230A();
    } else if(isDefined(self.petwatch._id_127CF)) {
      self notify("_encstr_AA9919B1169B1B2B637D0756E8EB83D8AB9B465627AFA3966BCA4E");
      self.petwatch._id_127CF = undefined;
      _id_13E23(0, 0);
    }
  }
}

setphase(var_0) {
  self.petwatch.phase = var_0;
  self.pers["_encstr_BDF0137BD145DFDE2857F0E46B10E6B7EFE8E233B9"] = var_0;
}

updateuistate() {
  var_0 = 0;

  if(self.petwatch.bored < 0)
    var_0 = var_0 + 20;

  if(self.petwatch.dirty < 0)
    var_0 = var_0 + 100;

  if(self.petwatch.unruly < 0)
    var_0 = var_0 + 1000;

  if(self.petwatch.hungry < 0)
    var_0 = var_0 + 10000;

  var_1 = int(self.petwatch.damage / 100) - 1;
  var_1 = int(max(0, min(var_1, 9)));
  var_0 = var_0 + 100000 * var_1;
  var_2 = var_0 + self.petwatch.phase;
  self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", var_2);
}

_id_12C76() {
  self.petwatch.bored = level.petconsts[self.petwatch.phase].boredstart;
  self.petwatch.dirty = level.petconsts[self.petwatch.phase].dirtystart;
  self.petwatch.unruly = level.petconsts[self.petwatch.phase].unrulystart;
  self.petwatch.hungry = level.petconsts[self.petwatch.phase].hungrystart;
  self.petwatch.waittothrowsmoke = 0;
  self.petwatch.waittill_player_uses_assassination_contract = 0;
  self.petwatch.watch_for_players_joining = 0;
  self.petwatch.waittillhuntersdrop = 0;
  self.petwatch.charged = 0;
  self.petwatch.growthtime = 0;
  self.petwatch.currentbestdist = 0;
  self.petwatch.bonustime = 0;
  self.petwatch.damage = 0;
  self.petwatch._id_13F07 = 0;
  self.petwatch._id_140E2 = 0;
  self.petwatch.dragonpoints = 0;
  self.petwatch.current_volume_num = 0;
  self.petwatch.killstreakcharge = 0;
  self.petwatch.currentbestpos = 0;
  self.petwatch.wingamescharge = 0;
  self.petwatch.current_zone = 0;
  self.petwatch.objectivescorecharge = 0;
  self.petwatch.current_volume_enemy = 0;
  self.petwatch.killscharge = 0;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
}

resetpet(var_0, var_1) {
  if(isDefined(var_1))
    setphase(var_1);
  else
    setphase(1);

  self.petwatch.lastupdatetime = getsystemtime();
  _id_12C76();
}

debugsetlasttime(var_0) {
  self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", var_0);
}

feedaction() {
  if(!isDefined(self.petwatch)) {
    return;
  }
  if(self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55") {
    return;
  }
  if(self.petwatch.phase == 15) {
    return;
  }
  var_0 = self.petwatch.killstreakcharge * 20;
  var_1 = self.petwatch.wingamescharge * 20;
  var_2 = self.petwatch.objectivescorecharge * 0.5;
  var_3 = self.petwatch.killscharge * 1;
  var_4 = self.petwatch.waittothrowsmoke < var_3;
  var_5 = self.petwatch.waittillhuntersdrop < var_1;
  var_6 = self.petwatch.waittill_player_uses_assassination_contract < var_0;
  var_7 = self.petwatch.watch_for_players_joining < var_2;

  if(!var_4 && !var_5 && !var_6 && !var_7) {
    return;
  }
  var_0 = max(-240, min(var_0, 240));
  var_1 = max(-240, min(var_1, 240));
  var_2 = max(-240, min(var_2, 240));
  var_3 = max(-240, min(var_3, 240));

  if(var_5) {
    var_1 = int(var_1);

    if(var_1 == 0)
      var_1 = 1;

    self setclientomnvar("_encstr_AA331AA7419169E840F947D6931BB8CEA865EF1264B0C1027C8ED8F0", var_1);
  }

  if(var_7) {
    var_2 = int(var_2);

    if(var_2 == 0)
      var_2 = 1;

    self setclientomnvar("_encstr_AF291B90AAE9A1E99B0FECEF1CFF70378CF2B8A093FC47A39B4AF551F9", int(var_2));
  }

  if(var_4) {
    var_3 = int(var_3);

    if(var_3 == 0)
      var_3 = 1;

    self setclientomnvar("_encstr_A98D1BF819F99BC743489F2F108EC898F177A6F043FC79B318638FD2FB", int(var_3));
  }

  if(var_6) {
    var_0 = int(var_0);

    if(var_0 == 0)
      var_0 = 1;

    self setclientomnvar("_encstr_8B4F1A57D2F507CA3AF577C23A6C0DD7D0ACB036D11AD798ED935991", int(var_0));
  }

  self.petwatch.waittothrowsmoke = var_3;
  self.petwatch.waittillhuntersdrop = var_1;
  self.petwatch.waittill_player_uses_assassination_contract = var_0;
  self.petwatch.watch_for_players_joining = var_2;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
  self.petwatch.bored = var_0;
  self.petwatch.dirty = var_1;
  self.petwatch.unruly = var_2;
  self.petwatch.hungry = var_3;
}