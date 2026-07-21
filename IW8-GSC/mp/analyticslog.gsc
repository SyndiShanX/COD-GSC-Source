/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\analyticslog.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_AACB0BD3C4A6A2B49AD25392D4", 0);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive()) {
    return;
  }
  thread watchforconnectedplayers();

  if(analyticslogenabled()) {
    thread logmatchtags();
    thread logallplayerposthink();
    thread logevent_minimapcorners();
  }
}

analyticsactive() {
  if(analyticsspawnlogenabled())
    return 1;

  if(analyticslogenabled())
    return 1;

  return 0;
}

analyticslogenabled() {
  return getdvarint("_encstr_AACB0BD3C4A6A2B49AD25392D4") == 1;
}

getuniqueobjectid() {
  var_0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_0;
}

cacheplayeraction(var_0) {
  if(!isDefined(self.analyticslog.cachedactions))
    self.analyticslog.cachedactions = 0;

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | var_0;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 logevent_playerconnected();
    var_0 thread watchforbasicplayerevents();
    var_0 thread watchforplayermovementevents();
    var_0 thread watchforusermessageevents();
  }
}

watchforbasicplayerevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_143B7("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_AD0607FAAB4AF8ED7B", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A730DD6B72A37C984A7486847CA23", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(var_0 == "_encstr_82EE0F816D2233A3C06BCD7214775D361D") {
      checkstancestatus();
      continue;
    }

    if(var_0 == "_encstr_AD0607FAAB4AF8ED7B") {
      cacheplayeraction(4);
      continue;
    }

    if(var_0 == "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19") {
      cacheplayeraction(8);
      continue;
    }

    if(var_0 == "_encstr_8A730DD6B72A37C984A7486847CA23") {
      cacheplayeraction(16);
      continue;
    }

    if(var_0 == "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527") {
      thread logevent_playerspawn();
      thread logevent_spawnpointupdate();
    }
  }
}

watchforplayermovementevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_143B5("_encstr_85B4109DAF78A271A1D433199F052FF8D050", "_encstr_878E0E7B375DC28CF09C939DB399C6DA", "_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3");

    if(var_0 == "_encstr_85B4109DAF78A271A1D433199F052FF8D050") {
      cacheplayeraction(64);
      continue;
    }

    if(var_0 == "_encstr_878E0E7B375DC28CF09C939DB399C6DA") {
      cacheplayeraction(128);
      continue;
    }

    if(var_0 == "_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3")
      cacheplayeraction(256);
  }
}

watchforusermessageevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isai(self)) {
    return;
  }
  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 0) {
    return;
  }
  self notifyonplayercommand("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_A6380E5AB0C61D4BED7337D87B8E0866");
  self notifyonplayercommand("_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    self waittill("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238");
    var_0 = scripts\engine\utility::_id_143AD("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3");

    if(isDefined(var_0) && var_0 == "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3") {
      self iprintlnbold("_encstr_832F0D5DDBA2902BA6B8E807BC310D");
      logevent_message(self.name, self.origin, "_encstr_BD6813BC459B89CD74023AE97B0F85696FFE2590CC");
    }
  }
}

checkstancestatus() {
  var_0 = self getstance();

  if(var_0 == "_encstr_922406F1A6FD5E05")
    cacheplayeraction(1);
  else if(var_0 == "_encstr_B13D076BED70539F23")
    cacheplayeraction(2);
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!shouldplayerlogevents(var_3)) {
        continue;
      }
      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
        var_3 logevent_path();
        var_3 logevent_scoreupdate();
        waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

recordbreadcrumbdata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getDvar("_encstr_86810B700C22CF5AF105ECF82B") == "_encstr_934C0218") {
    return;
  }
  if(isDefined(scripts\mp\utility\game::getgametype()) && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    var_0 = getdvarfloat("_encstr_B4A60B29D97F914D8B1B06301F", 4.0);
  else
    var_0 = getdvarfloat("_encstr_8A710B27A6D49639984A627A72", 2.0);

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    var_1 = level.players.size;
    var_2 = gettime();

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 20) {
      for(var_4 = 0; var_4 < 20; var_4++) {
        var_5 = var_3 + var_4;
        var_6 = level.players[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(!isDefined(var_6.team)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_6)) {
          continue;
        }
        if(var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
          continue;
        }
        if(var_6.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
          continue;
        }
        if(isai(var_6)) {
          continue;
        }
        if(!isDefined(var_6.matchdatalifeindex)) {
          continue;
        }
        if(!scripts\mp\matchdata::canlogclient(var_6)) {
          continue;
        }
        var_7 = var_6 scripts\mp\utility\player::isplayerads();
        var_8 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
        var_6 recordbreadcrumbdataforplayer(var_8, var_6.matchdatalifeindex, var_7);
      }

      waitframe();
    }

    var_9 = (gettime() - var_2) * 0.001;
    var_10 = max(var_0 - var_9, level.framedurationseconds);
    wait(var_10);
  }
}

getpathactionvalue() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning())
    var_0 = var_0 | 32;

  return var_0;
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "_encstr_922406F1A6FD5E05")
    var_0 = var_0 | 1;
  else if(var_1 == "_encstr_B13D076BED70539F23")
    var_0 = var_0 | 2;

  if(self isjumping())
    var_0 = var_0 | 4;

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500)
    var_0 = var_0 | 8;

  if(self isreloading())
    var_0 = var_0 | 16;

  return var_0;
}

buildloadoutstring() {
  var_0 = "_encstr_8D2D0B61F03EB3417C37C3B7DB" + self.loadoutarchetype + "_encstr_A54C02F2" + "_encstr_881A0E07B7BBB2398227A5B5B04E5E7A" + self.loadoutequipmentprimary + "_encstr_A54C02F2" + "_encstr_8C801033881B9DDBA7B5D6CD28E1223262B2" + self.loadoutequipmentsecondary + "_encstr_A54C02F2" + "_encstr_970F116F1792BFF0FE82D388F5D950734C6A83" + self.primaryweapon + "_encstr_A54C02F2" + "_encstr_A3E0122FA5E638B70B9909F162334D78FA210943" + self.secondaryweapon + "_encstr_A54C02F2";
  return var_0;
}

buildspawnpointstatestring(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["_encstr_9A8507BA4040188D08"]))
      var_1 = var_1 + ("_encstr_92340ECF9171D225A07D73FE70387C2F" + var_0.lastbucket["_encstr_9A8507BA4040188D08"] + "_encstr_A54C02F2");

    if(isDefined(var_0.lastbucket["_encstr_8E8405EA382B2A"]))
      var_1 = var_1 + ("_encstr_8CEE0C1BA08C48EE1FF2D019EB56" + var_0.lastbucket["_encstr_8E8405EA382B2A"] + "_encstr_A54C02F2");
  }

  return var_1;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("_encstr_A3330C604A05ABC8AB2F4FCFFC33", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_0[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_0[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_0[2], "_encstr_B40B07666F8BC31783", getpathactionvalue(), "_encstr_91B50734CA58631D1A", getsantizedhealth()]);
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var_1 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_932F10897FC235E08BEF57BA49F0DB5769FA", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_8E730808532CB3B053F0", var_1[0], "_encstr_B87308406A623B209C07", var_1[1], "_encstr_AC73084A1BF9A9103462", var_1[2], "_encstr_B1750873B8E9AC3A3BED", buildloadoutstring(), "_encstr_81EF05D197C12B", scripts\engine\utility::ter_op(var_0, "_encstr_85E20624BA8C8CCB", "_encstr_820E07F8E8780B3A4C"), "_encstr_8AEF05472BC2D6", self.team]);
}

logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }
  if(!isDefined(self.analyticslog))
    self.analyticslog = spawnStruct();

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;

  if(!analyticslogenabled()) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self.changedarchetypeinfo))
    var_0 = self.changedarchetypeinfo.super;
  else
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_AB010F01B25370857BA7A99B17335750FA");

  var_1 = self getxuid();
  getentitylessscriptablearray("_encstr_B4421647660FE30B0A2779B0937BE580BF47980D02B76E5C", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_B1540CA9FB5AF3782A89A8412DE5", self.name, "_encstr_84E90C90A37122C32329CB55BC9A", var_1, "_encstr_B15512A9FB5AF3782A890BC36AE5183842371B1B", var_0]);
}

logevent_playerdeath(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "_encstr_B24C02EF";
  var_12 = 0;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = var_0.analyticslog.playerid;

    if(isDefined(var_0.team)) {
      if(var_0.team == "_encstr_8E8405EA382B2A")
        var_11 = "_encstr_994C023A";
      else
        var_11 = "_encstr_A54C0259";
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0.lifeid))
      var_12 = var_0.lifeid;

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8BBA05085F8B99");
  var_15 = "_encstr_B24C02EF";

  if(self.team == "_encstr_8E8405EA382B2A")
    var_15 = "_encstr_994C023A";
  else
    var_15 = "_encstr_A54C0259";

  getentitylessscriptablearray("_encstr_841609A1F7328F0F2F2B2A", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_3[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_3[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_3[2], "_encstr_AC20072B9FA9487832", var_2, "_encstr_B23C0EADCAB0E67DB7CCEB3259164786", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_8BBA05085F8B99"), "_encstr_8FC70BB0D1E81636D6CA274B8C", var_4, "_encstr_B40B07666F8BC31783", buildkilldeathactionvalue(), "_encstr_B81010A3EF135B789A7774955743B06FCF8D", var_14, "_encstr_9697123027E3F3ABA2B951EBCF1AFF18468B2038", self.lifeid, "_encstr_8FD7142E489BB9F0E01FC286686036754FC2C0273761", var_12, "_encstr_BA490CF653989B2F397EDBF28101", var_15, "_encstr_8FA50E7363F307A0AB9F833EC38DF849", var_11, "_encstr_BEB40F602B73B319D7E5BE20E81FC307D8", var_5, "_encstr_8EB40FCEAD718AC3C8807BC74020AB1103", var_6, "_encstr_B8B40F0BE8E82C6CD62B9CAFE0BD6EBEA7", var_7, "_encstr_B287158A834396DFB75F665FBFEBAD1748E88A61CD4D43", var_8, "_encstr_A68715920BBD0F56C853D2F77F105DAF68A36A5AD015A7", var_9, "_encstr_8A8715FB4C2B389E877253FE7AD7C01105A2137BCE93A8", var_10, "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B", self.primaryweapon]);

  if(getdvarint("_encstr_A30B0B338319CF1289E8387F4B")) {
    var_16 = "_encstr_87700CC567A9FFC13C3E1D14D7C2";

    if(isDefined(var_0) && isPlayer(var_0))
      var_16 = var_0 playermounttype();

    var_17 = self playermounttype();
    getentitylessscriptablearray("_encstr_8FF41ED221EFB87F35E6574EEBB914AE02515D1AD9C995870348E99D27983D41", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_3[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_3[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_3[2], "_encstr_AC20072B9FA9487832", var_2, "_encstr_B23C0EADCAB0E67DB7CCEB3259164786", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_8BBA05085F8B99"), "_encstr_8FC70BB0D1E81636D6CA274B8C", var_4, "_encstr_B40B07666F8BC31783", buildkilldeathactionvalue(), "_encstr_B81010A3EF135B789A7774955743B06FCF8D", var_14, "_encstr_9697123027E3F3ABA2B951EBCF1AFF18468B2038", self.lifeid, "_encstr_8FD7142E489BB9F0E01FC286686036754FC2C0273761", var_12, "_encstr_BA490CF653989B2F397EDBF28101", var_15, "_encstr_8FA50E7363F307A0AB9F833EC38DF849", var_11, "_encstr_BEB40F602B73B319D7E5BE20E81FC307D8", var_5, "_encstr_8EB40FCEAD718AC3C8807BC74020AB1103", var_6, "_encstr_B8B40F0BE8E82C6CD62B9CAFE0BD6EBEA7", var_7, "_encstr_B287158A834396DFB75F665FBFEBAD1748E88A61CD4D43", var_8, "_encstr_A68715920BBD0F56C853D2F77F105DAF68A36A5AD015A7", var_9, "_encstr_8A8715FB4C2B389E877253FE7AD7C01105A2137BCE93A8", var_10, "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B", self.primaryweapon, "_encstr_BA68142290D976A748AD6A4FB110277D3131FB3B1843", var_16, "_encstr_A1701256AB71CB4CCBF1D20A5835C3AF4B0BD8FD", var_17]);
  }

  if(isDefined(var_1) && isexplosivedamagemod(var_1))
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_979608DF73C8E70B73A1"), self.origin, var_0, 1.0);

  if(isDefined(self.attackers)) {
    foreach(var_19 in self.attackers) {
      if(isDefined(var_19) && isPlayer(var_19) && var_19 != var_0)
        logevent_assist(var_19.analyticslog.playerid, var_14, var_2);
    }
  }
}

logevent_playerkill(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("_encstr_B2500CF8F36B658501777A3F298D", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_3[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_3[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_3[2], "_encstr_AC20072B9FA9487832", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8BBA05085F8B99"), "_encstr_A5490DD915F7B8C7A5E271C80ABD69", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_8BBA05085F8B99"), "_encstr_B89509D92DD8E85AD6D246", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0.analyticslog.playerid, "_encstr_B10703DD0F"), "_encstr_B40B07666F8BC31783", buildkilldeathactionvalue(), "_encstr_A56110C2D1A358C6B65627F5A1CA0B8DD10D", getsantizedhealth(), "_encstr_A1C913A310204CA29997E3BFE1B53AAFF8389B2D2B", 0]);
}

logevent_explosion(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = (1, 0, 0);

  getentitylessscriptablearray("_encstr_B473114FE12550C1B399C95253FB88A87C77D5", ["_encstr_A2F8090B80BFF74F88F34C", var_2.analyticslog.playerid, "_encstr_814C02A2", var_1[0], "_encstr_AA4C0279", var_1[1], "_encstr_964C02E5", var_1[2], "_encstr_8E730808532CB3B053F0", var_4[0], "_encstr_B87308406A623B209C07", var_4[1], "_encstr_AC73084A1BF9A9103462", var_4[2], "_encstr_A7AC09C857E458475AED37", var_3, "_encstr_81EF05D197C12B", var_0]);
}

logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(level.spawnpoints)) {
    return;
  }
  foreach(var_1 in level.spawnpoints)
  getentitylessscriptablearray("_encstr_8BC31307A3083FDF579E4B83A12C1B793817B18611", ["_encstr_814C02A2", var_1.origin[0], "_encstr_AA4C0279", var_1.origin[1], "_encstr_964C02E5", var_1.origin[2], "_encstr_A5390D87D9C96A9D68063A063858A5", scripts\engine\utility::ter_op(isDefined(var_1.lastscore["_encstr_9A8507BA4040188D08"]), var_1.lastscore["_encstr_9A8507BA4040188D08"], 0), "_encstr_8E230B850F2D37F5DC8DB79C2B", scripts\engine\utility::ter_op(isDefined(var_1.lastscore["_encstr_8E8405EA382B2A"]), var_1.lastscore["_encstr_8E8405EA382B2A"], 0), "_encstr_912B1118A37C20C33329415FF82937A9D763B0", scripts\engine\utility::ter_op(isDefined(var_1.totalpossiblescore), var_1.totalpossiblescore, 0), "_encstr_83A30F0B87D2B9EB6B0BC3D7CDC6B793CA", scripts\engine\utility::ter_op(isDefined(var_1.totalpossiblescore), var_1.totalpossiblescore, 0), "_encstr_A1AD062E09D98338", buildspawnpointstatestring(var_1)]);
}

logevent_frontlineupdate(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_B2D9123A7F938F8F818FF9425FB25D59A04BF040", ["_encstr_826D079BDDC92BC329", var_0[0], "_encstr_BD6D077BC3FF9B4B90", var_0[1], "_encstr_9A60050718982B", var_1[0], "_encstr_8C600556DC465E", var_1[1], "_encstr_86130D79CA120FB7506F10DC1FDB52", var_3[0], "_encstr_A5130DEE8B6B8B9FA9E06B0BC8A381", var_3[1], "_encstr_9B470F373DF251AD6AE186A5D0D908DA78", var_2[0], "_encstr_99470FB0ED7990BD880E4B2B38A3BFF263", var_2[1], "_encstr_A1AD062E09D98338", var_4]);
}

logevent_gameobject(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_AA180E7616AD2BADE0F5F6989A2BC6A3", ["_encstr_91D409509304BBA70D17CD", var_1, "_encstr_814C02A2", var_2[0], "_encstr_AA4C0279", var_2[1], "_encstr_964C02E5", var_2[2], "_encstr_A32908801BD3D5F0043C", var_3, "_encstr_81EF05D197C12B", var_0, "_encstr_A1AD062E09D98338", var_4]);
}

logevent_message(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_A34D0F718A2F25F892D75BB303BA50FCD7", ["_encstr_A32908801BD3D5F0043C", var_0, "_encstr_814C02A2", var_1[0], "_encstr_AA4C0279", var_1[1], "_encstr_964C02E5", var_1[2], "_encstr_A9B508B69537CD16D9CA", var_2]);
}

logevent_tag(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("_encstr_ACD3114F9788B745F9E9DA125837FC0BE10CC3", "_encstr_92170BBD9BF3F0F214B5062E23", var_0);
}

logevent_powerused(var_0, var_1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_82D30DB358D6955B0EAF83F6EEB2E4", ["_encstr_A32908801BD3D5F0043C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_8E730808532CB3B053F0", var_2[0], "_encstr_B87308406A623B209C07", var_2[1], "_encstr_AC73084A1BF9A9103462", var_2[2], "_encstr_81EF05D197C12B", var_0, "_encstr_A1AD062E09D98338", var_1]);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_BD061287291D6889FBC14349EADBB5E835813509", ["_encstr_A32908801BD3D5F0043C", self.analyticslog.playerid, "_encstr_82FB06EB26785BD7", self.score]);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }
  getentitylessscriptablearray("_encstr_A5F50BE7DED8D2FF482F7F114F", ["_encstr_A27B0A1E702D2AB59BD09F0B", var_0[0].origin[0], "_encstr_957B0A23AF73254AA81E1F3A", var_0[0].origin[1], "_encstr_B47B0A3E756D4AA79273A12A", var_0[1].origin[0], "_encstr_957B0A23AF73254AA8DE1F3A", var_0[1].origin[1], "_encstr_887106DCEDC93A34", getnorthyaw()]);
}

logevent_assist(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_87410FBF113540D1A3A97923739F9680CA", ["_encstr_A2F8090B80BFF74F88F34C", var_0, "_encstr_B81010A3EF135B789A7774955743B06FCF8D", var_1, "_encstr_AC20072B9FA9487832", var_2]);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(var_0) {
  if(!analyticslogenabled())
    return 0;

  if(!isDefined(var_0.team) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0.sessionstate != "_encstr_877508C1D8C22F2DDC3B" && var_0.sessionstate != "_encstr_84670547C3E9F4")
    return 0;

  return 1;
}

logmatchtags() {
  var_0 = getDvar("_encstr_A975122F47EB60D8B68668C2EB6910AED1E3839F", "_encstr_B40101");

  if(var_0 != "_encstr_B40101")
    logevent_tag(var_0);

  if(scripts\mp\utility\game::matchmakinggame())
    logevent_tag("_encstr_A63E0CD4A52C08701A679B89E7F2");
  else if(getdvarint("_encstr_93390B136AA2628AA8A93529D4"))
    logevent_tag("_encstr_84920D61F0B3C3DFDBFD05210D4183");
  else if(!getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7"))
    logevent_tag("_encstr_85480DD333CCB15AE62BA9B0A38D34");
}

logevent_superended(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_4 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_8D0414589B8563E51DB48DDCBED683BEDC57C15693E6", ["_encstr_B4970B6EEA07ACE4EBCD2CD6AC", var_0, "_encstr_A23B0CCDAC223B069C5F217807A5", var_1, "_encstr_87DB099A7562AECB5BDB53", var_2, "_encstr_96420A1AA3E3DEA0183A0D3A", var_3, "_encstr_86FF0AA0F9E12F9F254122EA", var_4]);
}

logevent_superearned(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  var_1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_1 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_ABDE1AE39B3211E0446C512B9935E0C04B5F796373396DF87A8599C1", ["_encstr_A9960BD109BB01A1A13BC8E0C2", var_0, "_encstr_86FF0AA0F9E12F9F254122EA", var_1]);
}

logevent_awardgained(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_A12314037BD2F1CBA48CB18B399580A00AF7FBADCB5B", ["_encstr_852F0EDA57B77A0A0F70C5CF9A57079D", var_0]);
}

logevent_giveplayerxp(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_4 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_B6541768DB01D0AB1314F686E1FAC1FE784BE0105FCA4E617B", ["_encstr_AFE5111B5727E456DCA3FA83C9B2E6D15AB356", var_0, "_encstr_998F0EE8A36A1D51BB7CA02145F39999", var_1, "_encstr_BEE30A73FB5867A648D5757C", var_2, "_encstr_9B490A2353C176B5E81AA64B", var_3, "_encstr_86FF0AA0F9E12F9F254122EA", var_4]);
}

logevent_givempweaponxp(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  var_5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_5 = self.analyticslog.playerid;

  var_6 = createheadicon(var_0);
  getentitylessscriptablearray("_encstr_A66417912DF8ED1FC5283A23F691F3E9F093090857E87923EF", ["_encstr_AC20072B9FA9487832", var_6, "_encstr_AFE5111B5727E456DCA3FA83C9B2E6D15AB356", var_1, "_encstr_998F0EE8A36A1D51BB7CA02145F39999", var_2, "_encstr_BEE30A73FB5867A648D5757C", var_3, "_encstr_9B490A2353C176B5E81AA64B", var_4, "_encstr_86FF0AA0F9E12F9F254122EA", var_5]);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0[var_2] = 0;
    var_1[var_2] = "_encstr_B40101";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0[var_2] = var_4.analyticslog.playerid;
      var_1[var_2] = var_4 getxuid();
    }

    var_2 = var_2 + 1;
  }

  getentitylessscriptablearray("_encstr_870D2285E65836BC3A9636DCEBAD2CD1C6D0FA0E8DC2F2959CEBB43791591EF5A5CDD247", ["_encstr_A5C40E83E14EE339B39B593B580FF151", var_0[0], "_encstr_AF3C0D2F34F9F8AD9ACBF9D08B7703", var_1[0], "_encstr_ABF70E0EB10BBCCA93237DA573C856F0", var_0[1], "_encstr_8E900DA7E46FB061A3B7AF41331A49", var_1[1], "_encstr_B8750ECFEDE203419A2E219873A41959", var_0[2], "_encstr_83720D1C63C2CBCAE466BE0FAE4B32", var_1[2], "_encstr_83ED0EF3E99FBB4DB09BC154C8D89563", var_0[3], "_encstr_B6050D87A5AA4B19C27A595847E1F1", var_1[3], "_encstr_85080EFBE187A355B883C94CC0209D6B", var_0[4], "_encstr_93E20D220983D32D03FA2783C058E4", var_1[4], "_encstr_A5560E0E63B0E52BE48DAFA5B98C560F", var_0[5], "_encstr_B6C50D527993C33D13D21793D0A8F4", var_1[5], "_encstr_8F8F0E81814F0B97DA4F4FC97A4F05E0", var_0[6], "_encstr_A9190D21ACE670057BDF4E92C32F4D", var_1[6], "_encstr_B2580E1C1B585EACC91CEBB49B195687", var_0[7], "_encstr_B6A50D83D8165ECAC970BE1EBA5A23", var_1[7], "_encstr_BAB10E03C1E0D0F5FB63794BD8D85F2B", var_0[8], "_encstr_B68E0D1CC60BF256E493AFE1572D91", var_1[8], "_encstr_BE100FD98B2A83683A0253B63C1E583513", var_0[9], "_encstr_91FF0E57757A9BC9129ED2B1A34D2DE9", var_1[9], "_encstr_86F50F1CD8169759274C62BE2DCDC8CA3C", var_0[10], "_encstr_A9A50E377C973AD38237A2C9BB1B83D1", var_1[10], "_encstr_836B0FDB687163056B5FE717A32861D21B", var_0[11], "_encstr_8A500EB3A5A10875EB16BD5F0BA34B28", var_1[11]]);
}

analyticsspawnlogenabled() {
  return getdvarint("_encstr_AABE0B211185FFF44F26C9DECD") != 0;
}

is_spawnid_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}

analyticsstorespawndata() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    game["_encstr_AD0F0B77E0D630B08F8ADBA023"] = level.spawncount;
    game["_encstr_ABC219E60785BB9B52C8B92AED849552E69B4739BAADACDCD1B232"] = level.spawnidstobeinstrumented;
    game["_encstr_85891A30AA1BCD69F2890F05841DA91D8772EBFB4387892B8D742319"] = level.nextspawntobeinstrumented;
  }
}

analyticsdoesspawndataexist() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented))
    return 1;

  return 0;
}

analyticsinitspawndata() {
  var_0 = game["_encstr_AD0F0B77E0D630B08F8ADBA023"];
  var_1 = game["_encstr_ABC219E60785BB9B52C8B92AED849552E69B4739BAADACDCD1B232"];
  var_2 = game["_encstr_85891A30AA1BCD69F2890F05841DA91D8772EBFB4387892B8D742319"];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    level.spawncount = var_0;
    level.spawnidstobeinstrumented = var_1;
    level.nextspawntobeinstrumented = var_2;
  } else {
    level.spawncount = 0;
    level.spawnidstobeinstrumented = [];
    level.nextspawntobeinstrumented = 0;
    var_3 = getdvarint("_encstr_9AE40AB117674CBF3985272D");
    var_4 = analytics_getmaxspawneventsforcurrentmode();
    var_5 = [];

    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_7 = randomintrange(20, var_4);

      if(isDefined(var_5[var_7])) {
        level.spawnidstobeinstrumented[var_6] = -1;
        continue;
      }

      var_5[var_7] = 1;
      level.spawnidstobeinstrumented[var_6] = var_7;
    }

    level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, ::is_spawnid_a_less_than_b);
  }
}

analyticssend_shouldsenddata(var_0) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1)
        level.nextspawntobeinstrumented++;

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == var_0) {
        level.nextspawntobeinstrumented++;
        return 1;
      }
    }
  }

  return 0;
}

analyticssend_spawntype(var_0, var_1, var_2, var_3) {
  var_4 = getglobalfrontlineinfo();
  var_5 = var_4.midpoint;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  if(isDefined(var_5)) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
  }

  var_9 = 0;

  if(isDefined(var_4.teamdiffyaw))
    var_9 = var_4.teamdiffyaw;

  var_10 = var_4.isactive[var_1];
  var_11 = 0;

  if(isDefined(var_4.disabledreason) && isDefined(var_4.disabledreason[var_1]))
    var_11 = var_4.disabledreason[var_1];

  var_12 = level.spawnglobals.logicvariantid;
  var_13 = 0;

  if(isDefined(level.spawnglobals.buddyplayerid)) {
    var_13 = level.spawnglobals.buddyplayerid;
    level.spawnglobals.buddyplayerid = 0;
  }

  bbreportspawntypes(var_6, var_7, var_8, var_9, var_3, var_10, var_11, var_2, var_12, var_13);
}

analyticssend_spawnplayerdetails(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var_4)) {
      var_5 = var_4 getplayerangles();
      var_6 = vectortoyaw(var_5);
      var_7 = var_4.origin[0];
      var_8 = var_4.origin[1];
      var_9 = var_4.origin[2];
      var_10 = 0;

      if(var_4 == var_0)
        var_10 = 1;

      var_11 = 0;

      if(isDefined(var_0.lastattacker) && var_0.lastattacker == var_4)
        var_11 = 1;

      var_12 = 0;

      if(var_4.team == "_encstr_8E8405EA382B2A")
        var_12 = 1;
      else if(var_4.team == "_encstr_9A8507BA4040188D08")
        var_12 = 2;

      var_13 = 0;

      if(isDefined(var_4.analyticslog.playerid))
        var_13 = var_4.analyticslog.playerid;

      bbreportspawnplayerdetails(var_2, var_6, var_7, var_8, var_9, var_13, var_12, var_10, var_11);
    }
  }
}

analyticssend_spawnfactors(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.spawnglobals.spawnpointslist) {
    var_6 = var_5.totalscore;
    var_7 = var_5.analytics.allyaveragedist;
    var_8 = var_5.analytics.enemyaveragedist;
    var_9 = var_5.analytics.timesincelastspawn;
    var_10 = 0;

    if(isDefined(var_0.lastspawnpoint) && var_0.lastspawnpoint == var_5)
      var_10 = 1;

    var_11 = 0;

    if(var_3 == var_5)
      var_11 = 1;

    var_12 = var_5.analytics.maxenemysightfraction;
    var_13 = var_5.analytics.randomscore;
    var_14 = var_5.analytics.spawnusedbyenemies;
    var_15 = 0;

    if(isDefined(var_5.lastspawnteam) && var_5.lastspawnteam == "_encstr_8E8405EA382B2A")
      var_15 = 1;
    else if(isDefined(var_5.lastspawnteam) && var_5.lastspawnteam == "_encstr_9A8507BA4040188D08")
      var_15 = 2;

    var_16 = var_5.lastspawntime;
    var_17 = var_5.analytics.maxjumpingenemysightfraction;
    var_18 = 0;

    if(isDefined(var_5.index) && var_5.index <= 1023)
      var_18 = var_5.index;

    var_19 = 0;

    if(isDefined(var_5.analytics) && isDefined(var_5.analytics.spawntype))
      var_19 = var_5.analytics.spawntype;

    var_20 = 0;

    if(isDefined(var_5.badspawnreason))
      var_20 = var_5.badspawnreason;

    bbreportspawnfactors(2, var_6, var_12, var_17, var_13, var_2, var_7, var_8, var_11, var_10, var_15, var_18, var_14, var_9, var_19, var_20);
  }
}

analytics_getmaxspawneventsforcurrentmode() {
  var_0 = 120;

  if(isDefined(scripts\mp\utility\game::getgametype())) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B41904BB8593")
      var_0 = 120;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_8218041DF5FA")
      var_0 = 120;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_959105B99040BD")
      var_0 = 120;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_AA5606FD1AF05085")
      var_0 = 40;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284")
      var_0 = 50;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_9707038CB6")
      var_0 = 50;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143")
      var_0 = 125;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501")
      var_0 = 50;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
      var_0 = 120;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_A54F06D32A2F0498")
      var_0 = 25;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75")
      var_0 = 50;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_9B0703CD93")
      var_0 = 25;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C")
      var_0 = 75;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_A20D05FBEB01F2")
      var_0 = 75;
    else if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB")
      var_0 = 50;
  }

  return var_0;
}

logevent_reportgamescore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  var_3 = 1;

  if(!isDefined(var_2))
    var_2 = -1;

  getentitylessscriptablearray("_encstr_AFA1190FF0212943099AF6674EF05A6E4397D55238F747A34D5D5B", ["_encstr_BD840BCDD8DE4E56AFA3BC83AC", var_3, "_encstr_87940DB91BDEC995BE83ED2DDC47CD", var_0, "_encstr_A9900EF773D598B57FAA3B41020B7BE0", var_2, "_encstr_84820AA7CF5BD2D703D82F37", var_1, "_encstr_86FF0AA0F9E12F9F254122EA", self.analyticslog.playerid]);
}

logevent_reportstreakscore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  var_3 = 2;

  if(!isDefined(var_2))
    var_2 = -1;

  getentitylessscriptablearray("_encstr_AFA1190FF0212943099AF6674EF05A6E4397D55238F747A34D5D5B", ["_encstr_BD840BCDD8DE4E56AFA3BC83AC", var_3, "_encstr_87940DB91BDEC995BE83ED2DDC47CD", var_0, "_encstr_A9900EF773D598B57FAA3B41020B7BE0", var_2, "_encstr_84820AA7CF5BD2D703D82F37", var_1, "_encstr_86FF0AA0F9E12F9F254122EA", self.analyticslog.playerid]);
}

logevent_reportsuperscore(var_0, var_1) {
  if(!analyticslogenabled()) {
    return;
  }
  var_2 = 3;
  getentitylessscriptablearray("_encstr_AFA1190FF0212943099AF6674EF05A6E4397D55238F747A34D5D5B", ["_encstr_BD840BCDD8DE4E56AFA3BC83AC", var_2, "_encstr_87940DB91BDEC995BE83ED2DDC47CD", var_0, "_encstr_84820AA7CF5BD2D703D82F37", var_1, "_encstr_86FF0AA0F9E12F9F254122EA", self.analyticslog.playerid]);
}

logevent_nvgtoggled(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!analyticslogenabled()) {
    return;
  }
  var_6 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_6 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_85581D1B5130F2DF50BB37FDD3A92F2A99EBA7C34FE8ABDF5903AD87A94875", ["_encstr_A2F8090B80BFF74F88F34C", var_6, "_encstr_84820AA7CF5BD2D703D82F37", var_0, "_encstr_88201217353ADB89526770409B9D063332DF059B", var_1, "_encstr_814C02A2", var_2[0], "_encstr_AA4C0279", var_2[1], "_encstr_964C02E5", var_2[2], "_encstr_A18008BD35E222F01BD0", var_3, "_encstr_A7AC09C857E458475AED37", var_4, "_encstr_86440F91A5DCC213362BAF93B2B0DCDBE6", var_5]);
}

getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["_encstr_9A8507BA4040188D08"] = 0;
    level.frontlineinfo.isactive["_encstr_8E8405EA382B2A"] = 0;
    level.frontlineinfo.uptime = 0.0;
    level.frontlineinfo.downtime = 0.0;
  }

  return level.frontlineinfo;
}

logevent_playerhealed(var_0, var_1, var_2) {
  var_3 = isDefined(var_2);

  if(!var_3)
    var_2 = var_0;

  var_0 dlog_recordplayerevent("_encstr_824117216A171459C7EE5B55F4A1E869D7D3996BE1A35DD0DD", ["_encstr_B442086D6763FB3D4F0A", var_2, "_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_A33506D8AA82DF6A", var_0.origin[0], "_encstr_9335067B90C6FFD8", var_0.origin[1], "_encstr_9135061CED9BAF9E", var_0.origin[2], "_encstr_A6650D983BF8ED874FA8DAE2B310E3", var_1, "_encstr_85F40C24C6AB27DBF553C8C8E70C", var_3]);
}

_id_119B7(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_8662188C8DBDD97DACB3AC9B1DEBC18D2CCB95E4EBC959B3ACB9", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_AFA30C68111730399E353AE79DFC", var_1]);
}

logevent_fieldupgradeearned(var_0, var_1) {
  var_0 dlog_recordplayerevent("_encstr_97D8274769BF1237C1C0EF3B287ED06A7B7B8F7A58C58A55C8780F5F2051AAE2D99D99373F55329D91", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_A33506D8AA82DF6A", var_0.origin[0], "_encstr_9335067B90C6FFD8", var_0.origin[1], "_encstr_9135061CED9BAF9E", var_0.origin[2], "_encstr_97AE1466D2951B8CEBABC19D935846CAFAB4B946590F", var_1]);
}

logevent_fieldupgradeactivated(var_0, var_1) {
  var_0 dlog_recordplayerevent("_encstr_8FE72AC208301759B875C5C65941DA636FC2AA2BF61CE70F0849C7C529D8629F05F98182D9ED5F834881F5DC", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_A33506D8AA82DF6A", var_0.origin[0], "_encstr_9335067B90C6FFD8", var_0.origin[1], "_encstr_9135061CED9BAF9E", var_0.origin[2], "_encstr_97AE1466D2951B8CEBABC19D935846CAFAB4B946590F", var_1]);
}

logevent_fieldupgradeexpired(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  var_0 dlog_recordplayerevent("_encstr_A17A28C82A353F1E6F76B5386C5F23E11EC348E0710F7B11638C50AD40D72B4387EA21D09B22B3CB3FB4", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_A33506D8AA82DF6A", var_0.origin[0], "_encstr_9335067B90C6FFD8", var_0.origin[1], "_encstr_9135061CED9BAF9E", var_0.origin[2], "_encstr_97AE1466D2951B8CEBABC19D935846CAFAB4B946590F", var_1, "_encstr_853A0923738A5BE899262A", var_2, "_encstr_BA970E07FF481FF1FD40400B9FB08312", var_3]);
}

logevent_killstreakavailable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 dlog_recordplayerevent("_encstr_AD88211F8058D1AE578BEF58B91943EBD01C8150145295F65CEFB08B23B00181F353BD", ["_encstr_9BA20A63C706F18BB257F503", var_1, "_encstr_BE0710244BD9C27B83808FA770DE2E5A83D5", var_2, "_encstr_9B94146D2DC6639BD127CA85AD7D832D6CB5AC8CAB07", var_3, "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1", var_4, "_encstr_A1A20B8342DE7B215BE8281EC8", var_5[0], "_encstr_A7A20BC1D8585EAC4E83DE9B5E", var_5[1], "_encstr_A3A20B1C8D85CBB293C1EDCD9E", var_5[2]]);
}

logevent_killstreakactivated(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 dlog_recordplayerevent("_encstr_926C21B59D724F961DAB40108B0F28EBEA05A046F3FB0399CBF778409341C33393EFA5", ["_encstr_9BA20A63C706F18BB257F503", var_1, "_encstr_BE0710244BD9C27B83808FA770DE2E5A83D5", var_2, "_encstr_9B94146D2DC6639BD127CA85AD7D832D6CB5AC8CAB07", var_3, "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1", var_4, "_encstr_A1A20B8342DE7B215BE8281EC8", var_5[0], "_encstr_A7A20BC1D8585EAC4E83DE9B5E", var_5[1], "_encstr_A3A20B1C8D85CBB293C1EDCD9E", var_5[2]]);
}

logevent_killstreakexpired(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  var_11 = scripts\mp\matchdata::gettimefrommatchstart(var_4);
  var_0 dlog_recordplayerevent("_encstr_8C301F328DDED9D7563B9537E8EBB55A3636BE9B8E4E5958B57D56C3E02D4ECAC8", ["_encstr_9BA20A63C706F18BB257F503", var_1, "_encstr_BE0710244BD9C27B83808FA770DE2E5A83D5", var_2, "_encstr_9B94146D2DC6639BD127CA85AD7D832D6CB5AC8CAB07", var_3, "_encstr_A30E16B8E1C80C8869449472DDF1234268DFF94A272FE1B1", var_6, "_encstr_884806B91ADEE8CD", var_7, "_encstr_88CC0521F3A13B", var_8, "_encstr_8E8D0697EB01F243", var_9, "_encstr_82FB06EB26785BD7", var_10, "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1", var_11, "_encstr_A1A20B8342DE7B215BE8281EC8", var_5[0], "_encstr_A7A20BC1D8585EAC4E83DE9B5E", var_5[1], "_encstr_A3A20B1C8D85CBB293C1EDCD9E", var_5[2]]);
}

_id_119BF(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = "_encstr_B40101";

  var_0 dlog_recordplayerevent("_encstr_8F551CA188B04A4F71FBEA1DC3173B91960BF3DB776B2A71234943C518D3", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_8CCE110E36C2BC599CEB1E07FA2B0BE49B5991", var_1, "_encstr_A2EC090827D1A37742492E", var_2, "_encstr_88BA11EF190A5998B886A872FF3167BA6D9A0D", var_3, "_encstr_9B8309C3E0EB56EC2BCDE8", var_4]);
}

_id_119BA(var_0, var_1) {
  var_0 dlog_recordplayerevent("_encstr_AD2928FA2A78B7294BCB72E0BD2FA952A1EB1FC3AFC0C3B193B2D3C33985C7EB8CB01860E3C0FFF3A3CF", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_991B0AAB6558471621884A52", var_1]);
}

_id_119B1(var_0, var_1, var_2, var_3) {
  var_0 dlog_recordplayerevent("_encstr_9A772A321BBDD97DB2B395E647BEE01BB0CB59C9FA6C0D16D8C6569B76ACAF963AACB5AFAB9B8DEDB1B5AC91", ["_encstr_834E1073230A6507A53BC292DFA8D11247CC", var_1, "_encstr_922A0A0BAC8FB8601B53B319", var_2, "_encstr_916D08E161A0D5EF2311", var_3]);
}