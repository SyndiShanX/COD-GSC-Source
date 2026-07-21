/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\cargo_truck_mg.gsc
***********************************************/

init_battlechatter() {
  level._battlechatter = spawnStruct();
  level._battlechatter.fnevaluatemoveevent = ::evaluatemoveevent;
  level._battlechatter.fnevaluatereloadevent = ::evaluatereloadevent;
  level._battlechatter.fnaddthreatevent = ::addthreatevent;
  level._battlechatter.fnevaluateattackevent = ::evaluateattackevent;
  level._battlechatter.fnplaybattlechatter = ::playbattlechatter;
  level._battlechatter.players = [];
  level._battlechatter.ai = [];
  level._battlechatter.nextsaytimes = [];
  level.heightforhighcallout = 96.0;
  level.mindistancecallout = 10.0;
  level.maxdistancecallout = 45.0;
  anim.threatcallouts = [];
  anim.eventchance = [];
  anim.eventtypeminwait = [];
  anim.threatcallouts["_encstr_8E2508591EE07BE6B246"] = 25;
  anim.threatcallouts["_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC"] = 25;
  anim.threatcallouts["_encstr_B1610BB3D781C068F6DC603B42"] = 25;
  anim.threatcallouts["_encstr_86A411B288082775C051A1AB39213E434861AA"] = 20;
  anim.threatcallouts["_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73"] = 20;
  anim.threatcallouts["_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD"] = 20;
  anim.threatcallouts["_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386"] = 25;
  anim.threatcallouts["_encstr_83240CF857AF812BC3C763F89E7A"] = 10;
  anim.threatcallouts["_encstr_A3731036F6731B168EAFD87BD816A3A5DECD"] = 90;
  anim.threatcallouts["_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD"] = 90;
  anim.threatcallouts["_encstr_8F100C0BD2D763EDB116D15ABD9B"] = 100;
  anim.threatcallouts["_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D"] = 95;
  anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_AD6908D8F63B2BE46B56"] = 70;
  anim.eventtypeminwait["_encstr_BA630AF5205B07DF65A89A33"] = [];
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"] = [];
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"] = [];
  anim.eventtypeminwait["_encstr_88720627AD68179B"] = [];
  anim.eventtypeminwait["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_AD6908D8F63B2BE46B56"] = 10000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_878B0A2323D11281F8F8551F"] = 20000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_999A07C61338F9A23A"] = 9000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_8A4F099025A3B8715A6B17"] = 25000;
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"]["_encstr_82F309E237DB1B6B6367E9"] = 7000;
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"]["_encstr_B2BC08303A77613B2FA4"] = 7000;
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"]["_encstr_A20C099FE504225E886B40"] = 7000;
  anim.eventtypeminwait["_encstr_88720627AD68179B"]["_encstr_B40B07666F8BC31783"] = 9000;
  anim.eventtypeminwait["_encstr_88720627AD68179B"]["_encstr_ACA20538F84D39"] = 3000;
  anim._id_13B42 = 120000;
  bcs_setup_countryids();
  level.dialog_system = 1;
}

bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    bcs_setup_voice("_encstr_8A390E2F88D07452C1384E0393EFDA3B", "_encstr_B407036B35", 6, 1);
    bcs_setup_voice("_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754", "_encstr_B407036B35", 6, 1);
    bcs_setup_voice("_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95", "_encstr_B407036B35", 3, 1);
    bcs_setup_voice("_encstr_834D07DCACE823CA33", "_encstr_B807035AA4", 5);
    bcs_setup_voice("_encstr_8BD90D13804B3C120DDFE3AFC9A53B", "_encstr_B81904AA6A6A", 3, 1);
    bcs_setup_voice("_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219", "_encstr_A1E405C39E7441", 1, 1);
    bcs_setup_voice("_encstr_81190403AE66", "_encstr_B81904AA6A6A", 3, 1);
    bcs_setup_voice("_encstr_978D0A1B20CFBFB7B0A77C6D", "_encstr_A1E405C39E7441", 1, 1);
    bcs_setup_voice("_encstr_841804CCB9B0", "_encstr_841804C8A9A0", 3, 1);
    bcs_setup_voice("_encstr_A1440A8C62AA7519DD2FC0B0", "_encstr_99780523350A19", 1, 1);

    switch (getDvar("_encstr_ACCE11131B37AFCCDB396C5654733BB1D23734")) {
      case "_encstr_AF1904A7F929":
      case "_encstr_8E8405EA382B2A":
        bcs_setup_voice("_encstr_9A01098842DA4B0317F42F", "_encstr_B81904AA6A6A", 3);
        bcs_setup_voice("_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D", "_encstr_A1E405C39E7441", 1);
        bcs_setup_voice("_encstr_964A08F5B3EE7B335128", "_encstr_B81904AA6A6A", 3);
        break;
      default:
        bcs_setup_voice("_encstr_9A01098842DA4B0317F42F", "_encstr_8507033F9B", 3);
        bcs_setup_voice("_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D", "_encstr_8D1904284519", 1);
        bcs_setup_voice("_encstr_964A08F5B3EE7B335128", "_encstr_91070355A5", 3);
        break;
    }
  }
}

bcs_setup_voice(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  anim.usedids[var_0] = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    anim.usedids[var_0][var_4] = spawnStruct();
    anim.usedids[var_0][var_4].count = 0;
    anim.usedids[var_0][var_4].npcid = "_encstr_B40101" + (var_4 + 1);
  }

  anim.countryids[var_0] = var_1;
  anim.flavorburstvoices[var_0] = var_3;
}

battlechatterenabled() {
  return istrue(level.dialog_system);
}

autoassignquest(var_0) {
  var_0.battlechatterallowed = 1;
  level._battlechatter.ai[level._battlechatter.ai.size] = var_0;
  var_0.battlechatter = spawnStruct();
  var_0.battlechatter.countryid = anim.countryids[var_0.voice];
  var_0 setnpcid();
  thread _id_12BE5(var_0);
  var_0 thread _id_11E60();
}

_id_12BC1(var_0) {
  level._battlechatter.ai = scripts\engine\utility::array_remove(level._battlechatter.ai, var_0);
  var_0 notify("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
}

_id_12BE5(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  _id_12BC1(var_0);
}

setnpcid() {
  var_0 = anim.usedids[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count)
      var_3 = (var_2 + var_4) % var_1;
  }

  thread npcidtracker(var_3);
  self.battlechatter.npcid = var_0[var_3].npcid;
}

npcidtracker(var_0) {
  var_1 = self.voice;
  anim.usedids[var_1][var_0].count++;
  scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!battlechatterenabled()) {
    return;
  }
  anim.usedids[var_1][var_0].count--;
}

_id_11E60() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  for(;;) {
    self waittill("_encstr_88BF06FD784A6393");

    if(isDefined(self.enemy) && isalive(self.enemy))
      _encstr_88C92737B1934B831DDC5E0BE6A5ADCB980B1D1DC6CAB1A12CD1A3AC937DBB9CC2071C59278B3BB9C6::addthreatevent("_encstr_A20C099FE504225E886B40", self.enemy);
  }
}

evaluatemoveevent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!battlechatterenabled() || !isDefined(self.goalpos) || !istrue(self.battlechatterallowed)) {
    return;
  }
  if(distancesquared(self.origin, self.goalpos) < 22500) {
    return;
  }
  if(randomint(100) < anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_AD6908D8F63B2BE46B56"])
    playorderevent("_encstr_B40B07666F8BC31783", "_encstr_AD6908D8F63B2BE46B56", anim.player);
  else
    playorderevent("_encstr_ACA20538F84D39", "_encstr_82EE0B8DE82C13A2187BCEFE14", anim.player);
}

addthreatevent(var_0, var_1, var_2) {
  if(isPlayer(var_1) || isDefined(var_1.aitype)) {
    if(isDefined(self._blackboard))
      self._blackboard.battlechatter_target = var_1;

    var_3 = threatinfantry(var_1, undefined);
  }
}

getthreatinfantrycallouttype(var_0) {
  var_1 = getdirectionfacingclock(self.angles, self.origin, var_0.origin);
  var_2 = var_1;
  var_3 = self;
  var_4 = getdistancemeters(var_3.origin, var_0.origin);
  self.possiblethreatcallouts = [];

  if(isexposed(var_0))
    addpossiblethreatcallout("_encstr_8E2508591EE07BE6B246");

  var_5 = 0;

  if(var_0.origin[2] - var_3.origin[2] >= level.heightforhighcallout) {
    if(addpossiblethreatcallout("_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386"))
      var_5 = 1;
  }

  addpossiblethreatcallout("_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73");

  if(!var_5) {
    if(var_2 == "_encstr_8C0703491D") {
      addpossiblethreatcallout("_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC");

      if(var_4 > level.mindistancecallout && var_4 < level.maxdistancecallout)
        addpossiblethreatcallout("_encstr_B1610BB3D781C068F6DC603B42");
    }

    addpossiblethreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
    addpossiblethreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
    addpossiblethreatcallout("_encstr_83240CF857AF812BC3C763F89E7A");
  }

  if(!self.possiblethreatcallouts.size)
    return undefined;

  var_6 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var_7 = spawnStruct();
  var_7.type = var_6;
  return var_7;
}

addpossiblethreatcallout(var_0) {
  var_1 = 0;

  if(!callouttypewillrepeat(var_0))
    var_1 = 1;

  if(!var_1)
    return var_1;

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var_0;
  return var_1;
}

setlastcallouttype(var_0) {
  level._battlechatter.watch_for_player_going_belowmap_or_oob = var_0;
  level._battlechatter.watch_for_player_in_gulag = gettime();
}

callouttypewillrepeat(var_0) {
  if(!isDefined(level._battlechatter.watch_for_player_going_belowmap_or_oob))
    return 0;

  if(!isDefined(level._battlechatter.watch_for_player_in_gulag))
    return 0;

  var_1 = level._battlechatter.watch_for_player_going_belowmap_or_oob;
  var_2 = level._battlechatter.watch_for_player_in_gulag;
  var_3 = anim._id_13B42;

  if(var_0 == var_1 && gettime() - var_2 < var_3)
    return 1;

  return 0;
}

isexposed(var_0) {
  if(distancesquared(self.origin, var_0.origin) > 2250000)
    return 0;

  var_1 = var_0 bcgetclaimednode();

  if(!isDefined(var_1))
    return 1;

  if(!var_0 isnodecoverorconceal())
    return 0;

  return 1;
}

threatinfantryexposed(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "_encstr_ADB405071B8AE8");
  var_1 = scripts\engine\utility::array_add(var_1, "_encstr_AC7109F8CBB733985F6EB4");
  var_2 = var_1[randomint(var_1.size)];
  addthreatexposedalias(var_2);
}

addthreatexposedalias(var_0) {
  if(var_0 == "_encstr_852906B39CBD5D38")
    var_0 = "_encstr_8C830F47883B9D2ACB3013C1ACCDC23543";

  var_1 = self.owner getbattlechatteralias("_encstr_93D4096861FB67FB2838E6" + var_0);
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

addthreatobviousalias() {
  var_0 = self.owner getbattlechatteralias("_encstr_8C700FD56074F3256E3FB5B7010B7F3B80");
  self.soundaliases[self.soundaliases.size] = var_0;
  return 1;
}

addthreatdistancealias(var_0) {
  var_1 = self.owner getbattlechatteralias("_encstr_AA9E0D9E5F8BBBFBE603B170CABA99") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

getdistancemeters(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

getdistancemetersnormalized(var_0, var_1) {
  var_2 = getdistancemeters(var_0, var_1);

  if(var_2 < 15.0)
    return "_encstr_AF0703133A";
  else if(var_2 < 25.0)
    return "_encstr_990703B2F9";
  else if(var_2 < 35.0)
    return "_encstr_8D070366C0";
  else if(var_2 < 45.0)
    return "_encstr_AA07038618";
  else if(var_2 < 55.0)
    return "_encstr_82070322E1";
  else if(var_2 < 65.0)
    return "_encstr_B107031B8F";
  else if(var_2 < 75.0)
    return "_encstr_B20703B767";
  else if(var_2 < 85.0)
    return "_encstr_840703171A";
  else if(var_2 < 95.0)
    return "_encstr_810703AF78";
  else
    return "_encstr_9A1804890618";
}

getrelativeangles(var_0) {
  var_1 = var_0.angles;

  if(!isPlayer(var_0)) {
    var_2 = var_0 bcgetclaimednode();

    if(isDefined(var_2))
      var_1 = var_2.angles;
  }

  return var_1;
}

bcgetclaimednode() {
  if(isPlayer(self))
    return self.node;
  else
    return _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::getclaimednode();
}

isnodecoverorconceal() {
  var_0 = self.node;

  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0.type, "_encstr_B68E06D0F6B3CA27") || issubstr(var_0.type, "_encstr_8BF608EDC8D8CFD8F9A8"))
    return 1;

  return 0;
}

getdirectionfacingclock(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectorNormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 345 || var_7 < 15)
    var_8 = "_encstr_8C0703491D";
  else if(var_7 < 45)
    var_8 = "_encstr_A34C02BB";
  else if(var_7 < 75)
    var_8 = "_encstr_A74C0222";
  else if(var_7 < 105)
    var_8 = "_encstr_A14C023B";
  else if(var_7 < 135)
    var_8 = "_encstr_AC4C024A";
  else if(var_7 < 165)
    var_8 = "_encstr_B84C027E";
  else if(var_7 < 195)
    var_8 = "_encstr_8F4C026A";
  else if(var_7 < 225)
    var_8 = "_encstr_914C02DC";
  else if(var_7 < 255)
    var_8 = "_encstr_864C02F9";
  else if(var_7 < 285)
    var_8 = "_encstr_8B4C0227";
  else if(var_7 < 315)
    var_8 = "_encstr_AF0703133A";
  else
    var_8 = "_encstr_9A07034C89";

  return var_8;
}

getdegreeselevation(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = atan(var_2 / var_3);

  if(var_4 < 15 || var_4 > 65)
    return var_4;
  else if(var_4 < 25)
    return 20;
  else if(var_4 < 35)
    return 30;
  else if(var_4 < 45)
    return 40;
  else if(var_4 < 55)
    return 50;
  else if(var_4 < 65)
    return 60;
}

addthreatcalloutalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = self.owner getbattlechatteralias("_encstr_95A9101D1AC9CA2CA3F5C6858D63EDBAA3FA" + var_0) + var_1;
  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

getdirectioncompass(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 = var_3 - var_4;

  if(var_3 < 0)
    var_3 = var_3 + 360;
  else if(var_3 > 360)
    var_3 = var_3 - 360;

  if(var_3 < 22.5 || var_3 > 337.5)
    var_5 = "_encstr_887106DCEDC93A34";
  else if(var_3 < 67.5)
    var_5 = "_encstr_882B0A73DB9CD1D0DD95B98E";
  else if(var_3 < 112.5)
    var_5 = "_encstr_88F60573538740";
  else if(var_3 < 157.5)
    var_5 = "_encstr_99E40A0E08AB6BD2B725AED5";
  else if(var_3 < 202.5)
    var_5 = "_encstr_A76006DCF6EAE886";
  else if(var_3 < 247.5)
    var_5 = "_encstr_87790ACB570D8853BFD12E88";
  else if(var_3 < 292.5)
    var_5 = "_encstr_9A6005079F201B";
  else if(var_3 < 337.5)
    var_5 = "_encstr_99960A057008EC123D4B4FAB";
  else
    var_5 = "_encstr_82690B6911D828AB40A4F1B3DF";

  return var_5;
}

normalizecompassdirection(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_887106DCEDC93A34":
      var_1 = "_encstr_AF4C0273";
      break;
    case "_encstr_882B0A73DB9CD1D0DD95B98E":
      var_1 = "_encstr_9A07039BBB";
      break;
    case "_encstr_88F60573538740":
      var_1 = "_encstr_954C0277";
      break;
    case "_encstr_99E40A0E08AB6BD2B725AED5":
      var_1 = "_encstr_8D07036EDD";
      break;
    case "_encstr_A76006DCF6EAE886":
      var_1 = "_encstr_B24C02EF";
      break;
    case "_encstr_87790ACB570D8853BFD12E88":
      var_1 = "_encstr_AC07035727";
      break;
    case "_encstr_9A6005079F201B":
      var_1 = "_encstr_934C02B2";
      break;
    case "_encstr_99960A057008EC123D4B4FAB":
      var_1 = "_encstr_AD0703BA80";
      break;
    case "_encstr_82690B6911D828AB40A4F1B3DF":
      var_1 = "_encstr_82690B6911D828AB40A4F1B3DF";
      break;
    default:
      return;
  }

  return var_1;
}

addthreatelevationalias(var_0) {
  var_1 = self.owner getbattlechatteralias("_encstr_B1A40D1B7BCD47B08D1DD7CA632B3B") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

getweightedchanceroll(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }
    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100)
        continue;
    } else {
      if(var_1[var_5] >= 100) {
        var_2 = var_5;
        var_3 = var_6;
        continue;
      }

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

threatinfantry(var_0, var_1) {
  self endon("_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");
  var_2 = createchatphrase();
  var_2.master = 1;
  var_2.threatent = var_0;
  var_3 = getthreatinfantrycallouttype(var_0);

  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type))
    return 0;

  var_4 = undefined;

  if(isDefined(self.callout_type_override))
    var_4 = self.callout_type_override;
  else
    var_4 = var_3.type;

  switch (var_4) {
    case "_encstr_8E2508591EE07BE6B246":
      var_5 = self;
      var_2 threatinfantryexposed(var_0);
      break;
    case "_encstr_B1610BB3D781C068F6DC603B42":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addthreatobviousalias();
      break;
    case "_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC":
      var_6 = self;
      var_7 = getdistancemetersnormalized(var_6.origin, var_0.origin);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addthreatdistancealias(var_7);
      break;
    case "_encstr_86A411B288082775C051A1AB39213E434861AA":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_A7700D1BDBE63AB0B1471BB1F636AD", var_9);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_A7700D1BDBE63AB0B1471BB1F636AD", var_9);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_883E0C982AA28FE99B3361E80BDF", var_9);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      var_10 = getdegreeselevation(var_6.origin, var_0.origin);

      if(var_10 >= 20 && var_10 <= 60) {
        var_2 addthreatcalloutalias("_encstr_BEAB117BF06B779934A6BB27EF90313891D073", var_9);
        var_2 addthreatelevationalias(var_10);
      } else
        return 0;

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_83240CF857AF812BC3C763F89E7A":
      var_6 = self;
      var_11 = getdirectioncompass(var_6.origin, var_0.origin);
      var_12 = normalizecompassdirection(var_11);

      if(var_12 == "_encstr_82690B6911D828AB40A4F1B3DF")
        return 0;

      var_2 addthreatcalloutalias("_encstr_A5430986C0A24FB07069D1", var_12);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
  }

  setlastcallouttype(var_3.type);
  var_5 = self;
  var_5.curevent = spawnStruct();
  var_5.curevent.eventaction = "_encstr_85CB07BDE04321538B";
  var_5.curevent.eventtype = "_encstr_A20C099FE504225E886B40";

  if(isDefined(self._blackboard))
    self._blackboard.battlechatter_line_ok = 0;

  var_5 playphrase(var_2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return 1;
}

playbattlechatter(var_0) {}

evaluatereloadevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }
  thread playinformevent("_encstr_878B0A2323D11281F8F8551F", "_encstr_979608DF73C8E70B73A1");
}

evaluateattackevent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }
  var_1 = "_encstr_8A78055C8D488C";

  switch (var_0) {
    case "_encstr_8A78055C8D488C":
      var_1 = "_encstr_8A78055C8D488C";
      break;
    case "_encstr_8C8D08671D451291C849":
      var_1 = "_encstr_8C8D08671D451291C849";
      break;
    case "_encstr_8B1804DF2043":
      var_1 = "_encstr_9748067348F0C794";
      break;
    case "_encstr_9AA80EDECC6686857346E61AB4CA8D23":
      var_1 = "_encstr_A32D07CFD14BAA94D0";
      break;
    case "_encstr_847205CE57E6E6":
      var_1 = "_encstr_8C180C3FC8C9981A2D58275B38FF";
      break;
    case "_encstr_86C808FF9BFE73295899":
      var_1 = "_encstr_83CE0FDD56B0C1F6377DD6A5DC6E2D36B2";
      break;
    case "_encstr_B1A9062B08CFA39F":
      var_1 = "_encstr_8DEA0D3CED0F834F0D6990C8A22203";
      break;
    case "_encstr_8DCB085BEF657B4DCF0B":
      var_1 = "_encstr_8DCB085BEF657B4DCF0B";
      break;
  }

  thread playinformevent(var_1, "_encstr_999A07C61338F9A23A");
}

playinformevent(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_3 = var_2 createchatphrase();
  var_3 addinformalias(var_0);
  var_2.curevent = spawnStruct();
  var_2.curevent.eventaction = "_encstr_85E507408AF3D0F005";
  var_2.curevent.eventtype = var_1;
  var_2 playphrase(var_3, self);
}

playorderevent(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_3 = self;
  var_3.curevent = spawnStruct();
  var_3.curevent.eventaction = "_encstr_88720627AD68179B";
  var_3.curevent.eventtype = var_0;

  switch (var_0) {
    case "_encstr_B40B07666F8BC31783":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = anim.player;

      _id_1213B(var_1, var_2);
      break;
    case "_encstr_ACA20538F84D39":
      _id_1213B(var_1, var_2);
      break;
    case "_encstr_933609192D9B8363C2B156":
      _id_1213B(var_1);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

_id_1213B(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_3 = var_2 createchatphrase();
  var_3 addorderalias("_encstr_B40B07666F8BC31783", var_0);
  var_2 playphrase(var_3, self);
}

createchatphrase() {
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0.soundevents = [];
  var_0.soundaliases = [];
  var_0.responsealiases = [];
  var_0.master = 0;
  return var_0;
}

addinformalias(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_B40101";
  else
    var_2 = "_encstr_BA4C02DF" + var_2;

  if(!issubstr(var_1, "_encstr_AC20072B9FA9487832"))
    var_0 = "_encstr_8B2108C0E5D2D01BD07E" + var_0;
  else
    var_0 = "_encstr_B40101";

  var_3 = self.owner getbattlechatteralias(var_0 + var_1 + var_2);
  self.soundaliases[self.soundaliases.size] = var_3;
}

addorderalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = self.owner getbattlechatteralias("_encstr_88720627AD68179B" + var_1);

  if(!isDefined(var_2))
    return 0;

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

stop_speaking(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_1)) {
    var_1 stopsounds();
    waitframe();

    if(isDefined(var_1)) {
      var_1 notify(var_0);
      var_1 delete();
    }
  }
}

isradioline(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(getsubstr(var_0, var_0.size - 2, var_0.size) == "_encstr_9207034F36")
    return 1;

  if(issubstr(var_0, "_encstr_A21A04F54EEB"))
    return 1;

  if(issubstr(var_0, "_encstr_8DCA083FE12218EFBB99"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_962407F798BB453A39", 1);

  if(issubstr(var_0, "_encstr_96CA087FDBB73475B3A9"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_8F2407590712215AF0", 1);

  if(issubstr(var_0, "_encstr_B6C5089976BB92691399"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_A2280749D330F48720", 1);

  if(issubstr(var_0, "_encstr_96C50801601BF522AB70"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_AB2807DF46D3CBFACF", 1);

  return 0;
}

dotypelimit(var_0, var_1) {
  if(!isDefined(level._battlechatter.nextsaytimes[var_0]))
    level._battlechatter.nextsaytimes[var_0] = [];

  level._battlechatter.nextsaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

cansay(var_0, var_1, var_2) {
  if(!istrue(self.battlechatterallowed))
    return 0;

  if(isDefined(level._battlechatter.nextsaytimes[var_0]) && isDefined(level._battlechatter.nextsaytimes[var_0][var_1]) && gettime() < level._battlechatter.nextsaytimes[var_0][var_1])
    return 0;

  if(issentient(self) && self.ignoreall)
    return 0;

  if(self isinscriptedstate())
    return 0;

  return 1;
}

playphrase(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3 = 0;

  if(isDefined(var_2))
    return var_3;

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking)
    return var_3;

  if(!var_1 cansay(var_1.curevent.eventaction, var_1.curevent.eventtype))
    return var_3;

  var_1 thread _id_13164(var_1.curevent.eventaction, var_1.curevent.eventtype);

  for(var_4 = 0; var_4 < var_0.soundaliases.size; var_4++) {
    if(!self.battlechatterallowed) {
      continue;
    }
    if(!isDefined(self._animactive) || isDefined(self._animactive) && self._animactive > 0) {
      continue;
    }
    if(!soundexists(var_0.soundaliases[var_4])) {
      continue;
    }
    var_5 = gettime();

    if(isradioline(var_0.soundaliases[var_4])) {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AFDD09A4FA844B1CBE4994"));
      var_6 linkTo(var_1);
    } else {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AADA07DBF19A4A81D7"));
      var_6 linkTo(var_1);
    }

    thread stop_speaking(var_0.soundaliases[var_4], var_6);
    self notify(var_0.soundaliases[var_4] + "_encstr_8F1F0907DBD1F2F84D395C");
    var_3 = 1;
    var_6 playSound(var_0.soundaliases[var_4]);
    wait(lookupsoundlength(var_0.soundaliases[var_4]) / 1000);
    self notify(var_0.soundaliases[var_4]);
    var_6 delete();
  }

  self notify("_encstr_9710106133923B09F80AB1CBF7E7E0783A7F");
  return var_3;
}

_id_13164(var_0, var_1) {
  self.battlechatter.isspeaking = 1;
  scripts\engine\utility::_id_143A5("_encstr_9710106133923B09F80AB1CBF7E7E0783A7F", "_encstr_AD75063D571AE108");

  if(isDefined(self.battlechatter))
    self.battlechatter.isspeaking = 0;

  dotypelimit(var_0, var_1);
}

getbcstate() {
  return "_encstr_AA7C07466F9DA30713";
}

bc_prefix(var_0) {
  if(isDefined(var_0) && var_0 == "_encstr_BD34078D57B9A37BD6")
    return tolower("_encstr_B21C08C8F0D7CEB75BF5" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
  else if(isDefined(var_0) && var_0 == "_encstr_A22F0DC6AB6E477BAD01932C23B4B7")
    return tolower("_encstr_B444074120C7C50F4D");
  else if(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93") != "_encstr_BA19049F4B2D") {
    if(isarray(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"))) {
      if(isDefined(self.team) && scripts\engine\utility::array_contains(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"), self.team))
        return tolower("_encstr_A1580819F0D7DB1D73FA" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
    } else if(isDefined(self.team) && self.team == getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"))
      return tolower("_encstr_A1580819F0D7DB1D73FA" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
    else
      return tolower("_encstr_8D7B08B073CFE14DB2A9" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
  } else
    return tolower("_encstr_8D7B08B073CFE14DB2A9" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
}

getbattlechatteralias(var_0) {
  var_1 = undefined;
  var_2 = bc_prefix();

  switch (var_0) {
    case "_encstr_A6B60B3FF019DB0A7FF4944A6D":
      var_1 = var_2 + "_encstr_A31514CBF52B133237DFC55E98EA92E1AA318D48B6E9";
      break;
    case "_encstr_97BB0DB1F673D8851D7DD88D7B36B5":
      var_1 = var_2 + getbcstate() + "_encstr_B66B0FEB6CBD376C1647FA36B1DE1B5BF5";
      break;
    case "_encstr_8F3C0FCE27E01ADA809873BF67D2299FCF":
      var_1 = var_2 + getbcstate() + "_encstr_86F511D7C6F6E6D8161DBEC6EDADE0C2B96EAF";
      break;
    case "_encstr_9BDD0C6C7BB936C247FA8C96E6D1":
      var_1 = var_2 + getbcstate() + "_encstr_ADE50ECF9F5F2DB3BA9BE0790AA39189";
      break;
    case "_encstr_97E90C47B0CDB3C23170BFF545ED":
      var_1 = var_2 + getbcstate() + "_encstr_8BFE0E9109D0D3B67891DFED49B03BCF";
      break;
    case "_encstr_92200CB1BD9B8D58E8EBC69533A3":
      var_1 = var_2 + getbcstate() + "_encstr_AFBF0DD78DB79B1BC2D1BEC659998E";
      break;
    case "_encstr_97630D1BA708A607BD66B30A499B6B":
      var_1 = var_2 + getbcstate() + "_encstr_85920E5136576AF3B938DF63F851A093";
      break;
    case "_encstr_87EF0E2FD868CBBA5918669FF831B282":
      var_1 = var_2 + getbcstate() + "_encstr_87060F4F7E5AF6CE699C81AE459633BD5B";
      break;
    case "_encstr_87630EB1EDE61BC23AFAA385C9D995E8":
      var_1 = var_2 + getbcstate() + "_encstr_84AC0F671BF04E12EB15E123F7B52A0DFB";
      break;
    case "_encstr_AA9E0D9E5F8BBBFBE603B170CABA99":
      var_1 = var_2 + "_encstr_91A10E8DEDCDD185C6D1F5C8A5371DEB";
      break;
    case "_encstr_B1A40D1B7BCD47B08D1DD7CA632B3B":
      var_1 = var_2 + "_encstr_A2B70E6CED73D15836A37D2B36CAB3AF";
      break;
    case "_encstr_8D4517EF8083A3BA678B391BA0C665B062E2C349FC627D336F":
      var_1 = var_2 + "_encstr_8D4517EF8083A3BA678B391BA0C665B062E2C349FC627D336F";
      break;
    case "_encstr_9A5E11E75289184BC21079F77EC337DA36F329":
      var_1 = var_2 + "_encstr_9A5E11E75289184BC21079F77EC337DA36F329";
      break;
    case "_encstr_8CCF11AC3CE0B7DC598CD726932B0BD65A9B9D":
      var_1 = var_2 + "_encstr_8CCF11AC3CE0B7DC598CD726932B0BD65A9B9D";
      break;
    case "_encstr_979511AB184220EEC70AAE90C2F3AD785F9601":
      var_1 = var_2 + "_encstr_979511AB184220EEC70AAE90C2F3AD785F9601";
      break;
    case "_encstr_B4B51710BB229F2BDF34F8E907ABD153CF421039A27A27A3E3":
      var_1 = var_2 + "_encstr_B4B51710BB229F2BDF34F8E907ABD153CF421039A27A27A3E3";
      break;
    case "_encstr_A9940DDB681270BE97BA1EEDE34FF8":
      var_1 = var_2 + "_encstr_A9940DDB681270BE97BA1EEDE34FF8";
      break;
    case "_encstr_A29D0F967366DB9CD6F5B327599B852395":
    case "_encstr_959B0CD29B66DE9CB6EB664EC29D":
      var_1 = var_2 + "_encstr_A29D0F967366DB9CD6F5B327599B852395";
      break;
    case "_encstr_A7C1186B9834905B93494030582015E81802519723BD30226022":
      var_1 = var_2 + "_encstr_A7C1186B9834905B93494030582015E81802519723BD30226022";
      break;
    case "_encstr_924E18D2E666DB4EB57D6D96C6C633A5E4B6BE37BD1B2396CA39":
    case "_encstr_B4601BBA58E5FDEBB0B87B61C978738435A84102384FB7CF0B187975DD":
      var_1 = var_2 + "_encstr_924E18D2E666DB4EB57D6D96C6C633A5E4B6BE37BD1B2396CA39";
      break;
    case "_encstr_BD870FA59BCCED27B6FAB67B8DDBE8DE3B":
      var_1 = var_2 + "_encstr_BD870FA59BCCED27B6FAB67B8DDBE8DE3B";
      break;
    case "_encstr_ADBF11F0C6A04FF20597433962025B7A2DB03F":
      var_1 = var_2 + "_encstr_ADBF11F0C6A04FF20597433962025B7A2DB03F";
      break;
    case "_encstr_ADE213F8324B78589D9F5173C3C4E034070A70036A":
      var_1 = var_2 + "_encstr_ADE213F8324B78589D9F5173C3C4E034070A70036A";
      break;
    case "_encstr_B68D121BF61BC247D2F6377D27ACCD83F673B9B2":
      var_1 = var_2 + getbcstate() + "_encstr_BA230FF1A858430A2DC3B7BB47D6B2AB48";
      break;
    case "_encstr_AD740EB8924AC34B5F77885877AA600B":
      var_1 = var_2 + "_encstr_AD740EB8924AC34B5F77885877AA600B";
      break;
    case "_encstr_8B86116A903927E3016028A8DD77FDC18E5B0D":
      var_1 = var_2 + "_encstr_83E6125F4BC23518CFCD706BF7E7D8780A633BE1";
      break;
    case "_encstr_B19814A81BB4612D31E5B794FF7A4F481BD73058BF5C":
      var_1 = var_2 + "_encstr_8B0E15ED9C232B39FAD6F6CE95BECD7B9BC6EDB5C416D1";
      break;
    case "_encstr_8C700FD56074F3256E3FB5B7010B7F3B80":
      var_1 = var_2 + "_encstr_8C700FD56074F3256E3FB5B7010B7F3B80";
      break;
    case "_encstr_BE7C12B281204B63ABC7AB77C747DB95D848ABF8":
      var_1 = var_2 + "_encstr_BE7C12B281204B63ABC7AB77C747DB95D848ABF8";
      break;
    case "_encstr_9565179CB22C6CD196EDE6FA34B7E647D236CAF5985DC9DC3A":
      var_1 = var_2 + "_encstr_9565179CB22C6CD196EDE6FA34B7E647D236CAF5985DC9DC3A";
      break;
    case "_encstr_9A311408CA42414813C30510A95FB057AE622068131D":
      var_1 = var_2 + "_encstr_9A311408CA42414813C30510A95FB057AE622068131D";
      break;
    case "_encstr_AC8E17E54173774A0AA81DE9E3C43AD8AFA487BBEA08039528":
      var_1 = var_2 + "_encstr_AC8E17E54173774A0AA81DE9E3C43AD8AFA487BBEA08039528";
      break;
    case "_encstr_8BA61432CA8373373002D59E930B3B83BFC191537D77":
      var_1 = var_2 + "_encstr_8BA61432CA8373373002D59E930B3B83BFC191537D77";
      break;
    case "_encstr_AD2906FBFA7593E3":
      var_1 = var_2 + "_encstr_AD2906FBFA7593E3";
      break;
    case "_encstr_8E8318D99313853034912179450408C5CBE76B7F0F8B5B907D37":
      var_1 = var_2 + "_encstr_B6110A798E29F0EB43FFB9C7";
      break;
    case "_encstr_96BA184B420B0DB0ABEF6F63F495F8CDBBA921110B8BB38086A4":
      var_1 = var_2 + "_encstr_96460ACAA6DDB9E0F8EA0D31";
      break;
    case "_encstr_BA1F1C3B28B0450A2DAF878721D912AD6856764540D8096205EFA3472772":
      var_1 = var_2 + "_encstr_99430FA02D7D33BF086B772728D83EEB01";
      break;
    case "_encstr_96A9174734392B853AF58D0BB18DB7EAA3F56EA5B3A1E8958C":
      var_1 = var_2 + "_encstr_A6950966897FE801B7B201";
      break;
    case "_encstr_A3421B05288BE98B53A14068AA6D5F234BF78D77AA7751F9FEFA287032":
      var_1 = var_2 + "_encstr_9B280EF3998E27E76077B3B43FF02C7F";
      break;
    case "_encstr_9A99200371DA9793F3604BFB55190AD0A459CCF813E7E7FB1080681024407B738C7A":
      var_1 = var_2 + "_encstr_B273138467826FF3136119E4D2A18F9FB20A9058DF";
      break;
    default:
  }

  return var_1;
}