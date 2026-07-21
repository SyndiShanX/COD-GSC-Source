/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\agents\agents.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0 && !isDefined(game["_encstr_A9310C0449DDA97F583FADB0FD01"])) {
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AB1904852B68", level.script);

    if(level.hardcoremode) {
      var_0 = scripts\cp\utility::getgametype() + "_encstr_B2170410D036";
      setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A5F909EC0B5B2B8EF20ECA", var_0);
    } else
      setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A5F909EC0B5B2B8EF20ECA", scripts\cp\utility::getgametype());

    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B6320E9E25AFD1F98864BF5877AC703E", getbuildversion());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AAD30DC4EA5A8D32AF9BEA5B98CA9C", getbuildnumber());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AA3011D75B916950A86B6B93B12718092B636B", scripts\cp\utility::privatematch());
  }

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0)
    level.maxlogclients = 30;
  else
    level.maxlogclients = 0;

  level.maxlives = 475;
  level.maxnamelength = 26;
  level.maxgameevents = 250;
  level.maxkillstreaks = 64;
  level.maxkillstreaksavailable = 64;
  level.maxnumchallengesperplayer = 10;
  level.maxnumawardsperplayer = 10;
  level.maxsupersavailable = 50;
  level.maxsupersactivated = 50;
  level.maxsupersexpired = 50;
  level.matchdataattachmentstatsenabled = 0;
  level thread endofgamesummarylogger();
}

onmatchstart() {
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_8B18119FE8210F63B1EFFA73D8691AF509490F", getsystemtime());
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_92AE13AAA17A8089CE2F7F274855807143D0FE62E3", level.players.size);
  var_0 = scripts\cp\utility::getgametype();

  if(level.hardcoremode)
    var_0 = var_0 + "_encstr_B2170410D036";

  var_1 = _func_042D();
  getentitylessscriptablearray("_encstr_A92F1EEFC1278A5FA9B887A380C64B12B56437E2207BA2BCB1B077EF987902CB", ["_encstr_AB1904852B68", level.script, "_encstr_81820A4A30E36F4FA39B507D", var_0, "_encstr_87B80C20D24F90210AC7C1FBF703", getdvarint("_encstr_A7B5118A40784F019007B780210850CB955B03"), "_encstr_9B7E0B6AA22A05989A6AA68945", getDvar("_encstr_9B7E0B6AA22A05989A6AA68945"), "_encstr_9B340B80600905FE0177EC7474", var_1]);
  onmatchend();
}

onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B44D0F2DB14089F750E1813BA8390F7128", level.endtimeutcseconds);
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B4B811B8FA66B3E9830FE6E81DCBF337CF4290", level.players.size);
  setmatchdata("_encstr_A9C917D774CD13BFBB0170D97B77EE09A2FD7F59E9F710F5FB", int(scripts\cp\drone\emp_drone::getglobalrankxpmultiplier()));
  setmatchdata("_encstr_A90E17CE8DB73158C6AB950BC1BDDC85C1A97BC82D33B45927", int(scripts\cp\cp_weaponrank::getglobalweaponrankxpmultiplier()));
}

getmatchstarttimeutc() {
  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") == 0)
    return level.starttimeutcseconds;

  return getmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_8B18119FE8210F63B1EFFA73D8691AF509490F");
}

getmatchendtimeutc() {
  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") == 0)
    return level.endtimeutcseconds;

  return getmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B44D0F2DB14089F750E1813BA8390F7128");
}

gettimefrommatchstart(var_0) {
  var_1 = var_0;

  if(isDefined(level.starttimefrommatchstart)) {
    var_1 = var_1 - level.starttimefrommatchstart;

    if(var_1 < 0)
      var_1 = 0;
  } else
    var_1 = 0;

  return var_1;
}

logkillstreakevent(var_0, var_1) {}

loggameevent(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  if(isvalidclient(self) && scripts\cp\utility\entity::isgameparticipant(self)) {
    var_2 = self;

    if(isDefined(self.matchdatalifeindex))
      var_3 = self.matchdatalifeindex;
  }

  var_4 = getmatchdata("_encstr_91490F9DB06B2B2AD99537E8347BAB731D");
  var_5 = var_4 + 1;
  setmatchdata("_encstr_91490F9DB06B2B2AD99537E8347BAB731D", var_5);
  var_6 = gettimefrommatchstart(gettime());
  getentitylessscriptablearray("_encstr_AD85161F8058D1AE578BEF58B9194FFBD81581E0169710B3", ["_encstr_83CD0D5967B2B947AFC1C6855EAC4E", var_2, "_encstr_8A1D0BFA18633D7376A0F1E5CD", var_0, "_encstr_B82419E3E87BC7E759B6E7EDD8C0E74B8F78D92BA83B7A035611E3", var_6, "_encstr_88201217353ADB89526770409B9D063332DF059B", var_3, "_encstr_A33506D8AA82DF6A", var_1[0], "_encstr_9335067B90C6FFD8", var_1[1], "_encstr_9135061CED9BAF9E", var_1[2]]);
}

logattackerkillevent(var_0, var_1) {}

logvictimkillevent(var_0, var_1) {}

logmultikill(var_0, var_1) {}

logplayerlife() {
  if(!isvalidclient(self))
    return -1;

  var_0 = 0;
  var_1 = (0, 0, 0);
  var_2 = 0;

  if(isDefined(self.spawntime))
    var_0 = self.spawntime;

  if(isDefined(self.spawnpos))
    var_1 = self.spawnpos;

  if(isDefined(self.wasti))
    var_2 = self.wasti;

  var_3 = gettimefrommatchstart(var_0);
  var_4 = game["_encstr_A97F0BA8D3305737C2502325DC"];
  game["_encstr_A97F0BA8D3305737C2502325DC"]++;
  self dlog_recordplayerevent("_encstr_927C16CB81E0220F608B67ADA3D9749ACC3B9F1F211FEBE6", ["_encstr_B4601F1BA8EBFB9BF62D79654D1E73420FA841729869B6FBAE966C61DE43CFCD9F", var_3, "_encstr_96920B36A5992B7D5ACD19593C", var_4, "_encstr_8B8A0C62CAA97F0EE7186DA08768", var_1[0], "_encstr_868A0CB8E341F3C5E112B046217B", var_1[1], "_encstr_9B8A0CAE0A02FFC057C38068979A", var_1[2], "_encstr_8AEF05472BC2D6", self.team, "_encstr_847508D237F5D0DEB91D", self ishost(), "_encstr_938617DD2CCDFA47B08D8E2D8D588DEBA573CD9593D196DECD", var_2]);
  thread monitorweaponfire();
  return var_4;
}

monitorweaponfire() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_84750DC45676D2DCAF99B4C94B9B9D");
    thread _id_11D21();
    var_0 = self.lastdroppableweaponobj;
    var_0 = scripts\cp\cp_weapon::mapweapon(var_0);
    var_1 = createheadicon(var_0);
    thread threadedsetweaponstatbyname(var_1, 1, "_encstr_B4890E63551BDACF88D341922B181C53");
  }
}

threadedsetweaponstatbyname(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waittillframeend;
  setweaponstat(var_0, var_1, var_2);
}

setweaponstat(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }
  var_3 = undefined;

  if(issameweapon(var_0))
    var_3 = var_0;
  else
    var_3 = asmdevgetallstates(var_0);

  if(scripts\cp\cp_weapon::ispickedupweapon(var_3)) {
    return;
  }
  var_4 = var_3.basename;
  var_5 = scripts\cp\cp_weapon::getweapongroup(var_3);
  var_6 = getweaponvariantindex(var_3);

  if(var_5 == "_encstr_85CE0B9770B02C73A1760F06D2" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_92EA0A290B32FF88A90170EB" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3") {
    return;
  }
  if(scripts\cp\utility::isenvironmentweapon(var_3)) {
    return;
  }
  if(var_5 == "_encstr_82F10F832FFB4B67E0E9897260907E55FA" || var_5 == "_encstr_998911DD5916C17BCDD795F01CB17B6E5AB356" || var_4 == "_encstr_92EA0A290B32FF88A90170EB" || var_4 == "_encstr_AAE60D90523A6F0173CD06F38F6FEB") {
    var_4 = scripts\cp\utility::strip_suffix(var_4, "_encstr_851A049F8337");
    return;
  }

  if(!isDefined(self.trackingweapon))
    self.trackingweapon = var_3;

  if(var_3 != self.trackingweapon)
    self.trackingweapon = var_3;

  switch (var_2) {
    case "_encstr_884806B91ADEE8CD":
      self.trackingweaponshots++;
      break;
    case "_encstr_88CC0521F3A13B":
      self.trackingweaponhits++;
      break;
    case "_encstr_96D30A3468575BA7C307A128":
      self.trackingweaponheadshots++;
      break;
    case "_encstr_8E8D0697EB01F243":
      self.trackingweaponkills++;
      break;
  }

  if(var_2 == "_encstr_8E0607055DBFB3919A") {
    var_7 = undefined;
    var_8 = scripts\cp\utility::getweaponrootname(var_3);

    if(!scripts\cp\cp_weapon::iscacprimaryweapon(var_8) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var_8)) {
      return;
    }
    var_9 = scripts\cp\utility::getweaponattachmentsbasenames(var_3);

    foreach(var_11 in var_9) {}
  }
}

_id_11D21() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.watch_for_players_touching_ground = gettime();
  self notify("_encstr_A60516A098E0CF953FC85BA7D11BDFE84D30B32A891A30F7");
  self endon("_encstr_A60516A098E0CF953FC85BA7D11BDFE84D30B32A891A30F7");
  scripts\engine\utility::waittill_either("_encstr_96B20B6DC812E61DB42B2B2E27", "_encstr_AD75063D571AE108");
  self.watch_for_players_regrouping_to_plane = gettime();
}

_id_11D78() {
  var_0 = self playermounttype();

  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_B4DB0B55B8FBF26CF640BFAB98":
        return "_encstr_B4DB0B5DA8BBF04CF6413F2B99";
      case "_encstr_86440CB5BD5DDCA3AF93B43B343A":
        return "_encstr_86440C353D559CA2AF92A43A242A";
      case "_encstr_83230A7F177D22B4413B75BA":
        return "_encstr_83230AFF576D2094413F7DB2";
    }
  }

  return "_encstr_88C90BD4A7AA72A2D7939E7254";
}

logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isvalidclient(self)) {
    return;
  }
  if(var_4 == "_encstr_AA19091676AC738EBED607")
    var_7 = [];
  else {
    var_7 = scripts\cp\utility::getweaponattachmentsbasenames(var_4);
    var_7 = scripts\cp\cp_weapon::attachmentsfilterforstats(var_7, var_4);
  }

  var_8 = gettimefrommatchstart(gettime());
  var_9 = -1;
  var_10 = -1;
  var_11 = [];

  if(isvalidclient(var_1)) {
    var_12 = getweaponbasename(var_4);
    var_13 = var_1;
    var_14 = var_1 scripts\cp\cp_weapon::ispickedupweapon(var_4);
    var_15 = var_1 isalternatemode(var_4);

    if(scripts\cp\cp_weapon::iscacprimaryweapon(var_4) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_4))
      var_16 = var_1 playerads();
    else
      var_16 = 0.0;

    var_17 = 0.4226;
    var_18 = scripts\engine\utility::within_fov(self.origin, self.angles, var_1.origin, var_17);
    var_19 = scripts\engine\utility::within_fov(var_1.origin, var_1.angles, self.origin, var_17);
    var_20 = var_1 _id_11D78();
    var_21 = var_1.origin;
    var_22 = var_1.angles;

    if(isDefined(var_1.matchdatalifeindex))
      var_9 = var_1.matchdatalifeindex;

    if(isDefined(var_1.loadoutindex))
      var_10 = var_1.loadoutindex;

    var_23 = var_1 getplayerbuffs();

    if(istrue(var_23[0]))
      var_11[var_11.size] = "_encstr_BE900B3945440F266129C1C613";

    if(istrue(var_23[1]))
      var_11[var_11.size] = "_encstr_AB4913A3999DFC8953E19F457E63014165B90F6361";

    if(istrue(var_23[2]))
      var_11[var_11.size] = "_encstr_ABC6138428D4FA35A89E284125933AAF419E5D514A";

    var_24 = var_1 getplayerdebuffs();

    if(istrue(var_24[0]))
      var_11[var_11.size] = "_encstr_812E0CA59B916178C8EF4163A350";

    if(istrue(var_24[1]))
      var_11[var_11.size] = "_encstr_9B680A481F69CCF6DB42C78C";

    if(istrue(var_24[2]))
      var_11[var_11.size] = "_encstr_8DDE0B2935D7326205A9842A88";

    if(istrue(var_24[3]))
      var_11[var_11.size] = "_encstr_84C80B70795F0A8B7FE8868595";

    if(istrue(var_24[4]))
      var_11[var_11.size] = "_encstr_B62E07ABD8313D0186";

    if(istrue(var_24[5]))
      var_11[var_11.size] = "_encstr_831A0BAB03F763ADFA369C7325";

    if(istrue(var_24[6]))
      var_11[var_11.size] = "_encstr_ABF50F57E99E2B9803AF5A843801F18545";

    if(istrue(var_24[7]))
      var_11[var_11.size] = "_encstr_82E809A4E47D35533DB4A8";

    if(istrue(var_24[8]))
      var_11[var_11.size] = "_encstr_8C0109929ABEA235A0A211";

    if(istrue(var_24[9]))
      var_11[var_11.size] = "_encstr_8EB715C4B027E9E88C09A7C741C497D151DBDD8A88EB61";

    if(var_1 isnightvisionon())
      var_11[var_11.size] = "_encstr_820F0CF874D16F786E8EB1F4DD61";

    if(isDefined(var_1.modifiers)) {
      if(isDefined(var_1.modifiers["_encstr_848909BBD3A7526348E8E3"]) && istrue(var_1.modifiers["_encstr_848909BBD3A7526348E8E3"]))
        var_11[var_11.size] = "_encstr_8489093B93B7504349ECEB";

      if(isDefined(var_1.modifiers["_encstr_977C08697BE705EAA5E3"]) && istrue(var_1.modifiers["_encstr_977C08697BE705EAA5E3"]))
        var_11[var_11.size] = "_encstr_977C084979EF0DE88563";

      if(isDefined(var_1.modifiers["_encstr_8E460991ACCC59378C56C9"]) && istrue(var_1.modifiers["_encstr_8E460991ACCC59378C56C9"]))
        var_11[var_11.size] = "_encstr_8E460911A88C5127885449";

      if(isDefined(var_1.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]) && istrue(var_1.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]))
        var_11[var_11.size] = "_encstr_93150B9F60DFA5C9D3CDE7DB3B";

      if(isDefined(var_1.modifiers["_encstr_811F08C0C726E1953267"]) && istrue(var_1.modifiers["_encstr_811F08C0C726E1953267"]))
        var_11[var_11.size] = "_encstr_811F08C14706E5D5306F";

      if(isDefined(var_1.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]) && istrue(var_1.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]))
        var_11[var_11.size] = "_encstr_ACE1095A9D8DBABFC3DCA1";

      if(isDefined(var_1.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]) && istrue(var_1.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]))
        var_11[var_11.size] = "_encstr_85E10B64A44A6AA290133D9E11";

      if(isDefined(var_1.modifiers["_encstr_92DF0956DA8F69425F23C8"]) && istrue(var_1.modifiers["_encstr_92DF0956DA8F69425F23C8"]))
        var_11[var_11.size] = "_encstr_92DF095ED80F6D624F03CC";

      if(isDefined(var_1.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]) && istrue(var_1.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]))
        var_11[var_11.size] = "_encstr_B8200998D3E4D14D90A7A8";

      if(isDefined(var_1.modifiers["_encstr_A90B0B68C75085F316A022DA28"]) && istrue(var_1.modifiers["_encstr_A90B0B68C75085F316A022DA28"]))
        var_11[var_11.size] = "_encstr_A90B0B4887518D7306A420D82C";

      if(isDefined(var_1.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]) && istrue(var_1.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]))
        var_11[var_11.size] = "_encstr_97601139DFE12CCFAD25D069CF059F169969B5";
    }

    if(scripts\cp\utility::iskillstreakweapon(var_12))
      var_11[var_11.size] = "_encstr_85CE0B1771B40C71E166070EC2";
  } else {
    var_13 = undefined;
    var_12 = "_encstr_B40101";
    var_14 = 0;
    var_15 = 0;
    var_16 = 0.0;
    var_18 = 0;
    var_19 = 0;
    var_20 = "_encstr_88C90BD4A7AA72A2D7939E7254";
    var_21 = [];
    var_21[0] = 0.0;
    var_21[1] = 0.0;
    var_21[2] = 0.0;
    var_22 = [];
    var_22[0] = 0.0;
    var_22[1] = 0.0;
    var_22[2] = 0.0;
  }

  var_25 = [];
  var_26 = getplayerbuffs();

  if(istrue(var_26[0]))
    var_25[var_25.size] = "_encstr_BE900B3945440F266129C1C613";

  if(istrue(var_26[1]))
    var_25[var_25.size] = "_encstr_AB4913A3999DFC8953E19F457E63014165B90F6361";

  if(istrue(var_26[2]))
    var_25[var_25.size] = "_encstr_ABC6138428D4FA35A89E284125933AAF419E5D514A";

  var_27 = getplayerdebuffs();

  if(istrue(var_27[0]))
    var_25[var_25.size] = "_encstr_812E0CA59B916178C8EF4163A350";

  if(istrue(var_27[1]))
    var_25[var_25.size] = "_encstr_9B680A481F69CCF6DB42C78C";

  if(istrue(var_27[2]))
    var_25[var_25.size] = "_encstr_8DDE0B2935D7326205A9842A88";

  if(istrue(var_27[3]))
    var_25[var_25.size] = "_encstr_84C80B70795F0A8B7FE8868595";

  if(istrue(var_27[4]))
    var_25[var_25.size] = "_encstr_B62E07ABD8313D0186";

  if(istrue(var_27[5]))
    var_25[var_25.size] = "_encstr_831A0BAB03F763ADFA369C7325";

  if(istrue(var_27[6]))
    var_25[var_25.size] = "_encstr_ABF50F57E99E2B9803AF5A843801F18545";

  if(istrue(var_27[7]))
    var_25[var_25.size] = "_encstr_82E809A4E47D35533DB4A8";

  if(istrue(var_27[8]))
    var_25[var_25.size] = "_encstr_8C0109929ABEA235A0A211";

  if(istrue(var_27[9]))
    var_25[var_25.size] = "_encstr_8EB715C4B027E9E88C09A7C741C497D151DBDD8A88EB61";

  if(self isnightvisionon())
    var_25[var_25.size] = "_encstr_820F0CF874D16F786E8EB1F4DD61";

  if(isDefined(self.modifiers)) {
    if(isDefined(self.modifiers["_encstr_848909BBD3A7526348E8E3"]) && istrue(self.modifiers["_encstr_848909BBD3A7526348E8E3"]))
      var_25[var_25.size] = "_encstr_8489093B93B7504349ECEB";

    if(isDefined(self.modifiers["_encstr_977C08697BE705EAA5E3"]) && istrue(self.modifiers["_encstr_977C08697BE705EAA5E3"]))
      var_25[var_25.size] = "_encstr_977C084979EF0DE88563";

    if(isDefined(self.modifiers["_encstr_8E460991ACCC59378C56C9"]) && istrue(self.modifiers["_encstr_8E460991ACCC59378C56C9"]))
      var_25[var_25.size] = "_encstr_8E460911A88C5127885449";

    if(isDefined(self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]) && istrue(self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]))
      var_25[var_25.size] = "_encstr_93150B9F60DFA5C9D3CDE7DB3B";

    if(isDefined(self.modifiers["_encstr_811F08C0C726E1953267"]) && istrue(self.modifiers["_encstr_811F08C0C726E1953267"]))
      var_25[var_25.size] = "_encstr_811F08C14706E5D5306F";

    if(isDefined(self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]) && istrue(self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]))
      var_25[var_25.size] = "_encstr_ACE1095A9D8DBABFC3DCA1";

    if(isDefined(self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]) && istrue(self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]))
      var_25[var_25.size] = "_encstr_85E10B64A44A6AA290133D9E11";

    if(isDefined(self.modifiers["_encstr_92DF0956DA8F69425F23C8"]) && istrue(self.modifiers["_encstr_92DF0956DA8F69425F23C8"]))
      var_25[var_25.size] = "_encstr_92DF095ED80F6D624F03CC";

    if(isDefined(self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]) && istrue(self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]))
      var_25[var_25.size] = "_encstr_B8200998D3E4D14D90A7A8";

    if(isDefined(self.modifiers["_encstr_A90B0B68C75085F316A022DA28"]) && istrue(self.modifiers["_encstr_A90B0B68C75085F316A022DA28"]))
      var_25[var_25.size] = "_encstr_A90B0B4887518D7306A420D82C";

    if(isDefined(self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]) && istrue(self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]))
      var_25[var_25.size] = "_encstr_97601139DFE12CCFAD25D069CF059F169969B5";
  }

  var_28 = undefined;
  var_29 = [];
  var_30 = "_encstr_B40101";

  if(isDefined(self.lastweaponused)) {
    var_28 = self.lastweaponused;
    var_29 = scripts\cp\utility::getweaponattachmentsbasenames(var_28);
    var_29 = scripts\cp\cp_weapon::attachmentsfilterforstats(var_29, var_28);
    var_30 = getweaponbasename(var_28);
    var_31 = scripts\cp\cp_weapon::ispickedupweapon(var_28);
    var_32 = self isalternatemode(var_28);
    var_33 = self playerads();
  } else {
    var_31 = 0;
    var_32 = 0;
    var_33 = 0.0;
  }

  if(scripts\cp\utility::iskillstreakweapon(var_30))
    var_25[var_25.size] = "_encstr_85CE0B1771B40C71E166070EC2";

  var_34 = _id_11D78();
  var_35 = -1;

  if(isDefined(self.loadoutindex))
    var_35 = self.loadoutindex;

  var_36 = 0;

  if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"])) {
    var_37 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];
    var_36 = var_37 - self.pers["_encstr_BE4F0EDB82ED810DE1D87D31FB8183E8"];
    self.pers["_encstr_BE4F0EDB82ED810DE1D87D31FB8183E8"] = var_37;
  }

  var_38 = self.score - self.pers["_encstr_8A2F11B7634DD307C52B73FA97CDE7A933B4C8"];
  self.pers["_encstr_8A2F11B7634DD307C52B73FA97CDE7A933B4C8"] = self.score;
  var_39 = -1;
  self dlog_recordplayerevent("_encstr_9566163943024401659BA1D80377508B2ACFD7B11F8A9580", ["_encstr_AA7B09475984AF0F6F0F0B", var_13, "_encstr_88371F91F948ABF02773E025E3C919426892F7F7939B3BCB3E9F6979C87BAF4F70", var_8, "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B", var_30, "_encstr_A73E1A4B433ECBE1E896AB3749D83FA298EBCBDB3B5652AD805863BA", var_29, "_encstr_9BB6101F8D831BF25C4BCB41A7729190ADDB", var_12, "_encstr_A6DE1C161DE8B08DB6B2277DEECA2CC1DB9B7D8547E858C6A1B595733A6E", var_7, "_encstr_A53817DBD34EBB919806FF87F968A84111471BDFA5E3124280", var_25, "_encstr_A61F1907200BE9BA472502719D73D2A4D0114FB7382D26C2A3464A", var_11, "_encstr_A7EB0DABA3DE2B0108B64A952BC148", self.origin[0], "_encstr_A1EB0D7067A3336B62799F284A7973", self.origin[1], "_encstr_99EB0D43B77279E3D0D099C2A04F78", self.origin[2], "_encstr_93FD0F4B60EF3B87B0B871664C787F0921", self.angles[0], "_encstr_A1FD0FB34B1B8EB4B5AF85379D63ACFA5E", self.angles[1], "_encstr_8FFD0F635B6BFB94A907C18A175BDDB7E3", self.angles[2], "_encstr_BEB40F602B73B319D7E5BE20E81FC307D8", var_21[0], "_encstr_8EB40FCEAD718AC3C8807BC74020AB1103", var_21[1], "_encstr_B8B40F0BE8E82C6CD62B9CAFE0BD6EBEA7", var_21[2], "_encstr_990F11B047D1168DB595937D85CDECB1597DC3", var_22[0], "_encstr_AB0F11583AE80B36ADAC39EB2C73ECD8B2FA2F", var_22[1], "_encstr_A70F11BEF91B71D6986713701EAA2221D04F78", var_22[2], "_encstr_993E0FDA20CB9DCF164096B7ED794FA361", var_3, "_encstr_8EFC1961E9A05E87BAB93BD1C385C75220B527E941086967507142", var_15, "_encstr_85EB1A1991D8260F3221B3694B1D3FDAA83DAF70C338ECDF6D9EDBA3", var_14, "_encstr_8EF1178C991B7C32B128A75FE0607FB68718F38B28B25AA181", var_32, "_encstr_99EC1843B77279E3D0D097623011D0A0E6894BBF24E50BD735D9", var_31, "_encstr_951D1360ECC0683357F348372F7A7A3F6C5868F818", var_16, "_encstr_85AE11AB182844BA919F9F83EF509389B863E7", var_33, "_encstr_856C1BC2D1A358C6D62BE4F5BB0BE6F5B4B9EBB32D8D3A2D6BEBCCEDD9", var_18, "_encstr_852F1BAB49BF7CDA3DE1CC879AAF0996D197E03D73678B69FBF9AF8098", var_19, "_encstr_BA68142290D976A748AD6A4FB110277D3131FB3B1843", var_20, "_encstr_A1701256AB71CB4CCBF1D20A5835C3AF4B0BD8FD", var_34, "_encstr_AF2F0A13317F6999F380EB53", var_36, "_encstr_91EC0D6E1BF6932BEB952C93DC5632", var_38, "_encstr_9697123027E3F3ABA2B951EBCF1AFF18468B2038", var_0, "_encstr_8E3A15FD79D6A8B3B70978EDF24B7868ABF74B551C3F90", var_35, "_encstr_8FD7142E489BB9F0E01FC286686036754FC2C0273761", var_9, "_encstr_8E1C17B1F5434F1E17909359C047D61398DD2C1783E883A719", var_10, "_encstr_AF90151D9936485357293BE1F3C796888DE7BBA131DD08", self isreloading(), "_encstr_8C4606C9DBD5CD46", var_39]);

  if(isvalidclient(var_1)) {
    updatetournamentroundtime(self getxuid(), var_1 getxuid(), var_4, var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799");

    if(isDefined(level.matchrecording_logevent)) {
      var_40 = gettime();
      [[level.matchrecording_logevent]](self.clientid, self.team, "_encstr_AD75062D5F18A10C", self.origin[0], self.origin[1], var_40);

      if(issubstr(tolower(var_3), "_encstr_A6260731BAD8D82BD1") && isDefined(var_4) && !scripts\cp\utility::iskillstreakweapon(var_4))
        [[level.matchrecording_logevent]](var_1.clientid, var_1.team, "_encstr_A6260721AA98982A51", var_1.origin[0], var_1.origin[1], var_40, undefined, self.origin[0], self.origin[1]);
    }
  }
}

getplayerbuffs() {
  var_0 = [];
  var_0[0] = scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team);
  var_0[1] = scripts\cp\utility::_hasperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
  var_0[2] = scripts\cp\utility::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
  return var_0;
}

getplayerdebuffs() {
  var_0 = [];
  var_0[0] = scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team);
  var_0[1] = scripts\cp_mp\killstreaks\helper_drone::istargetmarked();
  var_0[2] = istrue(self.flashbanged);
  var_0[3] = istrue(self.concussiongrenadefx);
  var_0[4] = isDefined(self.gastriggerstouching) && self.gastriggerstouching.size > 0 || isDefined(self.lastgastouchtime) && self.lastgastouchtime + 5000 > gettime();
  var_0[5] = isDefined(self.burninginfo) || isDefined(self.lastburntime) && self.lastburntime + 5000 > gettime();
  var_0[6] = isDefined(self.lastsnapshotgrenadetime) && self.lastsnapshotgrenadetime + 5000 > gettime();
  var_0[7] = isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > gettime();
  var_0[8] = istrue(self.empcount);
  var_0[9] = istrue(self.wphealthblock);
  return var_0;
}

logplayerdata(var_0) {
  if(!isvalidclient(self)) {
    return;
  }
  scripts\cp\cp_analytics::_id_119CC(var_0);
  self sendclientnetworktelemetry();
  var_1 = 0;
  var_2 = 0;

  if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"])) {
    return;
  }
  foreach(var_15, var_4 in self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"]) {
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(scripts\cp\utility::getgametype() != "_encstr_B607038AAB") {
      if(isenumvaluevalid("_encstr_927C07D787E1823F38", "_encstr_9AA40EC4BD588CF6AED1BA952C07DE9B", var_4.weapon))
        var_5 = self getplayerdata("_encstr_B8A30FC8463D282A65B07FF929C89DD3F0", "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", var_4.weapon);
    }

    foreach(var_14, var_13 in var_4.stats) {
      if(var_14 == "_encstr_8E0607055DBFB3919A")
        var_7 = var_7 + var_13;

      if(var_14 == "_encstr_96D30A3468575BA3C307A128")
        var_8 = var_8 + var_13;

      if(var_14 == "_encstr_88CC0521F3A13B") {
        var_9 = var_9 + var_13;
        var_2 = var_2 + var_13;
      }

      if(var_14 == "_encstr_8E8D0697EB01F243")
        var_10 = var_10 + var_13;

      if(var_14 == "_encstr_884806B91ADEE8CD") {
        var_11 = var_11 + var_13;
        var_1 = var_1 + var_13;
      }

      if(var_14 == "_encstr_AF2F0A13317F6999F380EB53")
        var_6 = var_6 + var_13;
    }

    if(scripts\cp\utility::getgametype() != "_encstr_B607038AAB")
      self dlog_recordplayerevent("_encstr_BD3C1F8CD8B7D97DCACEACB93AFA38B1C2E55939AFDD5616C1DE73F537A30BD1E6", ["_encstr_AC20072B9FA9487832", var_4.weapon, "_encstr_A2FB0B6B2136B74E68C97759F1", var_4.variantid, "_encstr_85C60EB1E70F014FCBDB59E052A703DA", var_4.loadoutindex, "_encstr_9A1713DCD11627E82D37B3FAEEB258837B37F5871C", var_5, "_encstr_AF2F0A13317F6999F380EB53", var_6, "_encstr_8E0607055DBFB3919A", var_7, "_encstr_96D30A3468575BA3C307A128", var_8, "_encstr_88CC0521F3A13B", var_9, "_encstr_8E8D0697EB01F243", var_10, "_encstr_884806B91ADEE8CD", var_11]);
  }
}

logscoreevent(var_0) {
  if(scripts\cp\utility\entity::isgameparticipant(self) == 0) {
    return;
  }
  if(!isvalidclient(self)) {
    return;
  }
  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }
  var_1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("_encstr_AB311E7903420441A55B6118C3B770C91AFFE3DD376BDEF8EAF72E716B75587D", ["_encstr_8CFB19C8FA35BB9ECFF328BCEA1FAD079DC240E882C1CFB3D71A45", var_1, "_encstr_A7380C6ED87B39ACFA95CE2BE6A3", var_0]);
}

endofgamesummarylogger() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    wait 0.05;

    if(!isDefined(var_1)) {
      continue;
    }
    var_1 scripts\cp_mp\utility\game_utility::stopkeyearning();

    if(isDefined(var_1.weaponsused)) {
      var_1 doublebubblesort();
      var_2 = 0;

      if(var_1.weaponsused.size > 3) {
        for(var_3 = var_1.weaponsused.size - 1; var_3 > var_1.weaponsused.size - 3; var_3--) {
          var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      } else {
        for(var_3 = var_1.weaponsused.size - 1; var_3 >= 0; var_3--) {
          var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      }
    } else {
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 0, "_encstr_8BBA05185F8B99");
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 1, "_encstr_8BBA05185F8B99");
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 2, "_encstr_8BBA05185F8B99");
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 0, 0);
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 1, 0);
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 2, 0);
    }

    if(isDefined(var_1.challengescompleted))
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_962116A64B4342E421E00737D91BADF80751EA1DA5C16A34", var_1.challengescompleted.size);
    else
      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_962116A64B4342E421E00737D91BADF80751EA1DA5C16A34", 0);

    for(var_3 = 0; var_3 < 20; var_3++) {
      if(isDefined(var_1.challengescompleted) && isDefined(var_1.challengescompleted[var_3]) && var_1.challengescompleted[var_3] != "_encstr_9BCE0C1B86EB38C956E6E8B43B59" && !issubstr(var_1.challengescompleted[var_3], "_encstr_8CE8077D91C22D1BCB") && !issubstr(var_1.challengescompleted[var_3], "_encstr_B1240818CF2F1117DD5B")) {
        var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", var_3, var_1.challengescompleted[var_3]);
        continue;
      }

      var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", var_3, "_encstr_99FA086C867D9B7B9B95");
    }

    var_4 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
    var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AAAC09D09972B9CC3F2B7F", scripts\cp\utility::getgametype());
    var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AB1904852B68", var_4);

    if(istrue(level.matchmakingmatch)) {
      var_5 = 0;
      var_6 = 0;

      for(var_3 = 0; var_3 < 5; var_3++) {
        var_7 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_3);

        if(var_7 == "_encstr_B40101") {
          var_5 = var_3;
          var_6 = 1;
          break;
        }

        if(var_7 == var_4) {
          var_5 = var_3;
          var_6 = 0;
          break;
        }
      }

      if(var_6 == 1)
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_5, var_4);
      else {
        var_8 = var_5;

        for(var_3 = var_5; var_3 < 4; var_3++) {
          var_8 = var_3 + 1;
          var_7 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_3 + 1);
          var_1 setplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_3, var_7);

          if(var_7 == "_encstr_B40101") {
            var_8 = var_3;
            break;
          }
        }

        var_1 setplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_8, var_4);
      }
    }
  }
}

doublebubblesort() {
  var_0 = self.weaponxpearned;
  var_1 = self.weaponxpearned.size;

  for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(var_0[var_3 - 1] < var_0[var_3]) {
        var_4 = self.weaponsused[var_3];
        self.weaponsused[var_3] = self.weaponsused[var_3 - 1];
        self.weaponsused[var_3 - 1] = var_4;
        var_5 = self.weaponxpearned[var_3];
        self.weaponxpearned[var_3] = self.weaponxpearned[var_3 - 1];
        self.weaponxpearned[var_3 - 1] = var_5;
        var_0 = self.weaponxpearned;
      }
    }
  }
}

isvalidclient(var_0) {
  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    return 0;

  if(!isDefined(var_0))
    return 0;
  else if(isagent(var_0))
    return 0;
  else if(!isPlayer(var_0))
    return 0;

  return 1;
}

canlogclient(var_0) {
  if(isvalidclient(var_0))
    return var_0.clientid < level.maxlogclients;
  else
    return 0;
}

canloglife(var_0) {
  return var_0 < level.maxlives;
}

logweaponstat(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::iskillstreakweapon(var_0) || scripts\cp\cp_weapon::isvehicleweapon(var_0)) {
    return;
  }
  if(scripts\cp\utility::getgametype() == "_encstr_B607038AAB") {
    return;
  }
  var_4 = var_0;

  if(isDefined(self.loadoutindex))
    var_4 = var_4 + "_encstr_95CD0E65C6BD588CDB573A943719B2C3" + self.loadoutindex;
  else
    return;

  if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4])) {
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4] = spawnStruct();
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].stats = [];
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].weapon = var_0;
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].loadoutindex = self.loadoutindex;

    if(isDefined(var_3))
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].variantid = var_3;
    else
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].variantid = -1;
  }

  if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].stats[var_1]))
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].stats[var_1] = var_2;
  else
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].stats[var_1] = self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_4].stats[var_1] + var_2;
}

logattachmentstat(var_0, var_1, var_2, var_3) {
  if(!level.matchdataattachmentstatsenabled)
    return;
}

buildweaponrootlist() {
  var_0 = [];
  var_1 = 149;

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 4);
    var_4 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 2);

    if(!issubstr(var_4, "_encstr_B2010820C5337B67C8CF")) {
      continue;
    }
    if(var_4 == "_encstr_A5EB0D7BCFF9182842D76F51639AEE") {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

logchallenge(var_0, var_1) {}

logaward(var_0) {
  if(!isvalidclient(self)) {
    return;
  }
  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }
  var_1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("_encstr_87B81881157F28B84AFBE3EDEBB17738092829DB71D9706FD39B", ["_encstr_8CFB19C8FA35BB9ECFF328BCEA1FAD079DC240E882C1CFB3D71A45", var_1, "_encstr_999D06112722EA95", var_0]);
}

initpersstat(var_0) {
  if(!isDefined(self.pers[var_0]))
    self.pers[var_0] = 0;
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incpersstat(var_0, var_1) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0]))
    self.pers[var_0] = self.pers[var_0] + var_1;
}

setextrascore0(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore0 = var_0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = var_0;
}

setextrascore1(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore1 = var_0;
  self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"] = var_0;
}

setextrascore2(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore2 = var_0;
  self.pers["_encstr_AD220CACE18E93C2B98DEDE4B223"] = var_0;
}

setextrascore3(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore3 = var_0;
  self.pers["_encstr_85220C92C329223FDB1EC7D225EB"] = var_0;
}

getplayerdataloadoutgroup() {
  if(level.rankedmatch)
    return "_encstr_B8A30FC8463D282A65B07FF929C89DD3F0";

  return "_encstr_A6DC101B53ABFB7E88FB542F8B7085BF4DEB";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "_encstr_AAE507E8423F63C163";
}

getstreakrecordtype(var_0) {
  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_9ABE1BAC7F5C689FF27787979B0ADED0F2D7B1C06AA4E8CD98F3F38BA7", var_0))
    return "_encstr_97C417B1ED5B80538DA9B8D093E72F5B2B954FBA73E369B1B2";

  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_B2D31C69F367A3BDF8992BE35793C7678D8B82F298AECB76E0CB04ED7B20", var_0))
    return "_encstr_81671883BB2BDF9842AC770FAF2A802643A3D949E20F15101B83";

  return undefined;
}