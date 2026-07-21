/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\matchdata.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0 && !isDefined(game["_encstr_A9310C0449DDA97F583FADB0FD01"])) {
    setmatchdatadef("_encstr_865315D2236367F3687648F25B0FD81360EB105E155832");
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AB1904852B68", level.script);

    if(level.hardcoremode) {
      var_0 = scripts\mp\utility\game::getgametype() + "_encstr_B2170410D036";
      setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A5F909EC0B5B2B8EF20ECA", var_0);
    } else
      setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A5F909EC0B5B2B8EF20ECA", scripts\mp\utility\game::getgametype());

    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B6320E9E25AFD1F98864BF5877AC703E", getbuildversion());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AAD30DC4EA5A8D32AF9BEA5B98CA9C", getbuildnumber());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AA3011D75B916950A86B6B93B12718092B636B", scripts\mp\utility\game::privatematch());
    setmatchdata("_encstr_AD8A18AE1AC06AC43893BAA8915385851D2858CB2A9BF6DD878B", -1);

    if(scripts\mp\utility\game::ismlgmatch())
      setmatchdata("_encstr_8BDC1096A0680D7107E7FBFBC73E5B6CD88B", 1);
  }

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
    if(level.gametype == "_encstr_B607038AAB")
      level.maxlogclients = 200;
    else
      level.maxlogclients = 30;
  } else
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
  level.get_alive_nonspecating_players = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && getdvarint("_encstr_8A2618B9D89CEB8DB79DEB26C9D7772B161CBDCDF5DCA358D1DC", 0) == 1;
  level._id_11B33 = ::onmatchstart;
  level._id_11B34 = ::onroundend;
  level._id_11B2A = ::logkillstreakevent;
  level._id_11B29 = ::loggameevent;
  level._id_11B26 = ::logattackerkillevent;
  level._id_11B30 = ::logvictimkillevent;
  level._id_11B2B = ::logmultikill;
  level._id_11B2E = ::logplayerlife;
  level._id_11B2D = ::logplayerdeath;
  level._id_11B2C = ::logplayerdata;
  level._id_11B2F = ::logscoreevent;
  level._id_11B35 = ::_id_12AA9;
  level._id_11B31 = ::logweaponstat;
  level._id_11B25 = ::logattachmentstat;
  level._id_11B23 = ::buildweaponrootlist;
  level._id_11B28 = ::logchallenge;
  level._id_11B27 = ::logaward;
  level thread endofgamesummarylogger();
}

onmatchstart() {
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_8B18119FE8210F63B1EFFA73D8691AF509490F", getsystemtime());
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_92AE13AAA17A8089CE2F7F274855807143D0FE62E3", level.players.size);
  var_0 = scripts\mp\utility\game::getgametype();
  var_1 = "_encstr_B40101";

  if(var_0 == "_encstr_B607038AAB")
    var_1 = level.disable_super_in_turret.name;

  if(level.hardcoremode)
    var_0 = var_0 + "_encstr_B2170410D036";

  var_2 = getdvarint("_encstr_A7B5118A40784F019007B780210850CB955B03");
  var_3 = getDvar("_encstr_9B7E0B6AA22A05989A6AA68945");
  var_4 = _func_042D();
  getentitylessscriptablearray("_encstr_A92F1EEFC1278A5FA9B887A380C64B12B56437E2207BA2BCB1B077EF987902CB", ["_encstr_AB1904852B68", level.script, "_encstr_81820A4A30E36F4FA39B507D", var_0, "_encstr_87B80C20D24F90210AC7C1FBF703", var_2, "_encstr_A77F10CA3CC195274BB559E6D1FACDC2B52B", var_3, "_encstr_B2C511F047B4E077F3E78E94FFBB2F690DCF78", isdismembermentenabled(), "_encstr_82DB0EC6DD98A0DC51A1D3F7859F3348", var_1, "_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", var_4]);

  if(var_0 == "_encstr_B607038AAB")
    scripts\common\utility::_id_13E0A(level._id_11B22);

  onmatchend();
}

onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B44D0F2DB14089F750E1813BA8390F7128", level.endtimeutcseconds);
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B4B811B8FA66B3E9830FE6E81DCBF337CF4290", level.players.size);
  setmatchdata("_encstr_A9C917D774CD13BFBB0170D97B77EE09A2FD7F59E9F710F5FB", int(scripts\mp\rank::getglobalrankxpmultiplier()));
  setmatchdata("_encstr_A90E17CE8DB73158C6AB950BC1BDDC85C1A97BC82D33B45927", int(scripts\mp\weaponrank::getglobalweaponrankxpmultiplier()));
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

  if(isvalidclient(self) && scripts\mp\utility\entity::isgameparticipant(self)) {
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
    var_0 = scripts\mp\utility\weapon::mapweapon(var_0);
    var_1 = createheadicon(var_0);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_1, 1, "_encstr_B4890E63551BDACF88D341922B181C53");
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

logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isvalidclient(self)) {
    return;
  }
  if(var_4 == "_encstr_AA19091676AC738EBED607")
    var_8 = [];
  else {
    var_8 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_4);
    var_8 = scripts\mp\utility\weapon::attachmentsfilterforstats(var_8, var_4);
  }

  var_9 = gettimefrommatchstart(gettime());
  var_10 = 0;

  if(isDefined(self.spawntime))
    var_10 = self.spawntime;

  var_11 = gettimefrommatchstart(var_10);
  var_12 = -1;
  var_13 = -1;
  var_14 = [];

  if(isvalidclient(var_1)) {
    var_15 = getweaponbasename(var_4);
    var_16 = scripts\mp\utility\weapon::safe_to_authenticate(var_7);
    var_17 = var_1;
    var_18 = var_1 scripts\mp\utility\weapon::ispickedupweapon(var_4);
    var_19 = var_1 isalternatemode(var_4);

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_4))
      var_20 = var_1 playerads();
    else
      var_20 = 0.0;

    var_21 = 0.4226;
    var_22 = scripts\engine\utility::within_fov(self.origin, self.angles, var_1.origin, var_21);
    var_23 = scripts\engine\utility::within_fov(var_1.origin, var_1.angles, self.origin, var_21);
    var_24 = var_1 _id_11D78();
    var_25 = var_1.origin;
    var_26 = var_1.angles;

    if(isDefined(var_1.matchdatalifeindex))
      var_12 = var_1.matchdatalifeindex;

    if(isDefined(var_1.loadoutindex))
      var_13 = var_1.loadoutindex;

    var_27 = var_1 getplayerbuffs();

    if(istrue(var_27[0]))
      var_14[var_14.size] = "_encstr_BE900B3945440F266129C1C613";

    if(istrue(var_27[1]))
      var_14[var_14.size] = "_encstr_AB4913A3999DFC8953E19F457E63014165B90F6361";

    if(istrue(var_27[2]))
      var_14[var_14.size] = "_encstr_ABC6138428D4FA35A89E284125933AAF419E5D514A";

    var_28 = var_1 getplayerdebuffs();

    if(istrue(var_28[0]))
      var_14[var_14.size] = "_encstr_812E0CA59B916178C8EF4163A350";

    if(istrue(var_28[1]))
      var_14[var_14.size] = "_encstr_9B680A481F69CCF6DB42C78C";

    if(istrue(var_28[2]))
      var_14[var_14.size] = "_encstr_8DDE0B2935D7326205A9842A88";

    if(istrue(var_28[3]))
      var_14[var_14.size] = "_encstr_84C80B70795F0A8B7FE8868595";

    if(istrue(var_28[4]))
      var_14[var_14.size] = "_encstr_B62E07ABD8313D0186";

    if(istrue(var_28[5]))
      var_14[var_14.size] = "_encstr_831A0BAB03F763ADFA369C7325";

    if(istrue(var_28[6]))
      var_14[var_14.size] = "_encstr_ABF50F57E99E2B9803AF5A843801F18545";

    if(istrue(var_28[7]))
      var_14[var_14.size] = "_encstr_82E809A4E47D35533DB4A8";

    if(istrue(var_28[8]))
      var_14[var_14.size] = "_encstr_8C0109929ABEA235A0A211";

    if(istrue(var_28[9]))
      var_14[var_14.size] = "_encstr_8EB715C4B027E9E88C09A7C741C497D151DBDD8A88EB61";

    if(var_1 isnightvisionon())
      var_14[var_14.size] = "_encstr_820F0CF874D16F786E8EB1F4DD61";

    if(isDefined(var_1.modifiers)) {
      if(istrue(var_1.modifiers["_encstr_848909BBD3A7526348E8E3"]))
        var_14[var_14.size] = "_encstr_8489093B93B7504349ECEB";

      if(istrue(var_1.modifiers["_encstr_977C08697BE705EAA5E3"]))
        var_14[var_14.size] = "_encstr_977C084979EF0DE88563";

      if(istrue(var_1.modifiers["_encstr_8E460991ACCC59378C56C9"]))
        var_14[var_14.size] = "_encstr_8E460911A88C5127885449";

      if(istrue(var_1.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]))
        var_14[var_14.size] = "_encstr_93150B9F60DFA5C9D3CDE7DB3B";

      if(istrue(var_1.modifiers["_encstr_811F08C0C726E1953267"]))
        var_14[var_14.size] = "_encstr_811F08C14706E5D5306F";

      if(istrue(var_1.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]))
        var_14[var_14.size] = "_encstr_ACE1095A9D8DBABFC3DCA1";

      if(istrue(var_1.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]))
        var_14[var_14.size] = "_encstr_85E10B64A44A6AA290133D9E11";

      if(istrue(var_1.modifiers["_encstr_92DF0956DA8F69425F23C8"]))
        var_14[var_14.size] = "_encstr_92DF095ED80F6D624F03CC";

      if(istrue(var_1.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]))
        var_14[var_14.size] = "_encstr_B8200998D3E4D14D90A7A8";

      if(istrue(var_1.modifiers["_encstr_A90B0B68C75085F316A022DA28"]))
        var_14[var_14.size] = "_encstr_A90B0B4887518D7306A420D82C";

      if(istrue(var_1.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]))
        var_14[var_14.size] = "_encstr_97601139DFE12CCFAD25D069CF059F169969B5";
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var_15))
      var_14[var_14.size] = "_encstr_85CE0B1771B40C71E166070EC2";
  } else {
    var_17 = undefined;
    var_15 = "_encstr_B40101";
    var_16 = undefined;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0.0;
    var_22 = 0;
    var_23 = 0;
    var_24 = "_encstr_88C90BD4A7AA72A2D7939E7254";
    var_25 = [];
    var_25[0] = 0.0;
    var_25[1] = 0.0;
    var_25[2] = 0.0;
    var_26 = [];
    var_26[0] = 0.0;
    var_26[1] = 0.0;
    var_26[2] = 0.0;
  }

  if(!isDefined(var_16))
    var_16 = -1;

  var_29 = [];
  var_30 = getplayerbuffs();

  if(istrue(var_30[0]))
    var_29[var_29.size] = "_encstr_BE900B3945440F266129C1C613";

  if(istrue(var_30[1]))
    var_29[var_29.size] = "_encstr_AB4913A3999DFC8953E19F457E63014165B90F6361";

  if(istrue(var_30[2]))
    var_29[var_29.size] = "_encstr_ABC6138428D4FA35A89E284125933AAF419E5D514A";

  var_31 = getplayerdebuffs();

  if(istrue(var_31[0]))
    var_29[var_29.size] = "_encstr_812E0CA59B916178C8EF4163A350";

  if(istrue(var_31[1]))
    var_29[var_29.size] = "_encstr_9B680A481F69CCF6DB42C78C";

  if(istrue(var_31[2]))
    var_29[var_29.size] = "_encstr_8DDE0B2935D7326205A9842A88";

  if(istrue(var_31[3]))
    var_29[var_29.size] = "_encstr_84C80B70795F0A8B7FE8868595";

  if(istrue(var_31[4]))
    var_29[var_29.size] = "_encstr_B62E07ABD8313D0186";

  if(istrue(var_31[5]))
    var_29[var_29.size] = "_encstr_831A0BAB03F763ADFA369C7325";

  if(istrue(var_31[6]))
    var_29[var_29.size] = "_encstr_ABF50F57E99E2B9803AF5A843801F18545";

  if(istrue(var_31[7]))
    var_29[var_29.size] = "_encstr_82E809A4E47D35533DB4A8";

  if(istrue(var_31[8]))
    var_29[var_29.size] = "_encstr_8C0109929ABEA235A0A211";

  if(istrue(var_31[9]))
    var_29[var_29.size] = "_encstr_8EB715C4B027E9E88C09A7C741C497D151DBDD8A88EB61";

  if(self isnightvisionon())
    var_29[var_29.size] = "_encstr_820F0CF874D16F786E8EB1F4DD61";

  if(isDefined(self.modifiers)) {
    if(istrue(self.modifiers["_encstr_848909BBD3A7526348E8E3"]))
      var_29[var_29.size] = "_encstr_8489093B93B7504349ECEB";

    if(istrue(self.modifiers["_encstr_977C08697BE705EAA5E3"]))
      var_29[var_29.size] = "_encstr_977C084979EF0DE88563";

    if(istrue(self.modifiers["_encstr_8E460991ACCC59378C56C9"]))
      var_29[var_29.size] = "_encstr_8E460911A88C5127885449";

    if(istrue(self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]))
      var_29[var_29.size] = "_encstr_93150B9F60DFA5C9D3CDE7DB3B";

    if(istrue(self.modifiers["_encstr_811F08C0C726E1953267"]))
      var_29[var_29.size] = "_encstr_811F08C14706E5D5306F";

    if(istrue(self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]))
      var_29[var_29.size] = "_encstr_ACE1095A9D8DBABFC3DCA1";

    if(istrue(self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]))
      var_29[var_29.size] = "_encstr_85E10B64A44A6AA290133D9E11";

    if(istrue(self.modifiers["_encstr_92DF0956DA8F69425F23C8"]))
      var_29[var_29.size] = "_encstr_92DF095ED80F6D624F03CC";

    if(istrue(self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]))
      var_29[var_29.size] = "_encstr_B8200998D3E4D14D90A7A8";

    if(istrue(self.modifiers["_encstr_A90B0B68C75085F316A022DA28"]))
      var_29[var_29.size] = "_encstr_A90B0B4887518D7306A420D82C";

    if(istrue(self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]))
      var_29[var_29.size] = "_encstr_97601139DFE12CCFAD25D069CF059F169969B5";
  }

  var_32 = undefined;
  var_33 = [];
  var_34 = "_encstr_B40101";
  var_35 = undefined;

  if(isDefined(self.lastweaponused)) {
    var_32 = self.lastweaponused;
    var_33 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_32);
    var_33 = scripts\mp\utility\weapon::attachmentsfilterforstats(var_33, var_32);
    var_34 = getweaponbasename(var_32);
    var_35 = scripts\mp\utility\weapon::safe_to_authenticate(var_32);
    var_36 = scripts\mp\utility\weapon::ispickedupweapon(var_32);
    var_37 = self isalternatemode(var_32, 0, 1);
    var_38 = self playerads();
  } else {
    var_36 = 0;
    var_37 = 0;
    var_38 = 0.0;
  }

  if(!isDefined(var_35))
    var_35 = -1;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_34))
    var_29[var_29.size] = "_encstr_85CE0B1771B40C71E166070EC2";

  var_39 = _id_11D78();
  var_40 = -1;

  if(isDefined(self.loadoutindex))
    var_40 = self.loadoutindex;

  var_41 = 0;

  if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"])) {
    var_42 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];
    var_41 = var_42 - self.pers["_encstr_BE4F0EDB82ED810DE1D87D31FB8183E8"];
    self.pers["_encstr_BE4F0EDB82ED810DE1D87D31FB8183E8"] = var_42;
  }

  var_43 = self.score - self.pers["_encstr_8A2F11B7634DD307C52B73FA97CDE7A933B4C8"];
  self.pers["_encstr_8A2F11B7634DD307C52B73FA97CDE7A933B4C8"] = self.score;
  var_44 = -1;

  if(scripts\mp\utility\game::isroundbased()) {
    var_44 = game["_encstr_8DC30DAA0285FD69FAE113371B1934"];

    if(var_3 == "_encstr_8A2B0FCB4F87678FC5CF57194FD0E7AD79" || var_3 == "_encstr_8D5110501FCB890155CB9CA54F05E6915048") {
      var_44--;

      if(var_44 < 0)
        var_44 = 0;
    }
  }

  var_45 = 0;

  if(isDefined(var_1) && isDefined(var_1.modifiers))
    var_45 = istrue(var_1.modifiers["_encstr_B48408136397CAC13031"]);

  self dlog_recordplayerevent("_encstr_9566163943024401659BA1D80377508B2ACFD7B11F8A9580", ["_encstr_AA7B09475984AF0F6F0F0B", var_17, "_encstr_88371F91F948ABF02773E025E3C919426892F7F7939B3BCB3E9F6979C87BAF4F70", var_9, "_encstr_B4601F1BA8EBFB9BF62D79654D1E73420FA841729869B6FBAE966C61DE43CFCD9F", var_11, "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B", var_34, "_encstr_A73E1A4B433ECBE1E896AB3749D83FA298EBCBDB3B5652AD805863BA", var_33, "_encstr_9BB6101F8D831BF25C4BCB41A7729190ADDB", var_15, "_encstr_A6DE1C161DE8B08DB6B2277DEECA2CC1DB9B7D8547E858C6A1B595733A6E", var_8, "_encstr_A53817DBD34EBB919806FF87F968A84111471BDFA5E3124280", var_29, "_encstr_A61F1907200BE9BA472502719D73D2A4D0114FB7382D26C2A3464A", var_14, "_encstr_A7EB0DABA3DE2B0108B64A952BC148", self.origin[0], "_encstr_A1EB0D7067A3336B62799F284A7973", self.origin[1], "_encstr_99EB0D43B77279E3D0D099C2A04F78", self.origin[2], "_encstr_93FD0F4B60EF3B87B0B871664C787F0921", self.angles[0], "_encstr_A1FD0FB34B1B8EB4B5AF85379D63ACFA5E", self.angles[1], "_encstr_8FFD0F635B6BFB94A907C18A175BDDB7E3", self.angles[2], "_encstr_BEB40F602B73B319D7E5BE20E81FC307D8", var_25[0], "_encstr_8EB40FCEAD718AC3C8807BC74020AB1103", var_25[1], "_encstr_B8B40F0BE8E82C6CD62B9CAFE0BD6EBEA7", var_25[2], "_encstr_990F11B047D1168DB595937D85CDECB1597DC3", var_26[0], "_encstr_AB0F11583AE80B36ADAC39EB2C73ECD8B2FA2F", var_26[1], "_encstr_A70F11BEF91B71D6986713701EAA2221D04F78", var_26[2], "_encstr_993E0FDA20CB9DCF164096B7ED794FA361", var_3, "_encstr_8EFC1961E9A05E87BAB93BD1C385C75220B527E941086967507142", var_19, "_encstr_85EB1A1991D8260F3221B3694B1D3FDAA83DAF70C338ECDF6D9EDBA3", var_18, "_encstr_8EF1178C991B7C32B128A75FE0607FB68718F38B28B25AA181", var_37, "_encstr_99EC1843B77279E3D0D097623011D0A0E6894BBF24E50BD735D9", var_36, "_encstr_951D1360ECC0683357F348372F7A7A3F6C5868F818", var_20, "_encstr_85AE11AB182844BA919F9F83EF509389B863E7", var_38, "_encstr_856C1BC2D1A358C6D62BE4F5BB0BE6F5B4B9EBB32D8D3A2D6BEBCCEDD9", var_22, "_encstr_852F1BAB49BF7CDA3DE1CC879AAF0996D197E03D73678B69FBF9AF8098", var_23, "_encstr_BA68142290D976A748AD6A4FB110277D3131FB3B1843", var_24, "_encstr_A1701256AB71CB4CCBF1D20A5835C3AF4B0BD8FD", var_39, "_encstr_AF2F0A13317F6999F380EB53", var_41, "_encstr_91EC0D6E1BF6932BEB952C93DC5632", var_43, "_encstr_9697123027E3F3ABA2B951EBCF1AFF18468B2038", var_0, "_encstr_8E3A15FD79D6A8B3B70978EDF24B7868ABF74B551C3F90", var_40, "_encstr_8FD7142E489BB9F0E01FC286686036754FC2C0273761", var_12, "_encstr_8E1C17B1F5434F1E17909359C047D61398DD2C1783E883A719", var_13, "_encstr_AF90151D9936485357293BE1F3C796888DE7BBA131DD08", self isreloading(), "_encstr_B15515A5EF7A751835898B41AADFA0ABF23F2B394712B4", self isinexecutionattack(), "_encstr_8C4606C9DBD5CD46", var_44, "_encstr_816C0B1B8348698B601372D0B5", var_45, "_encstr_84C415DC31C27CE2C851303D7FDBDFEB96C3C2F5E37490", var_35, "_encstr_88C917163AA30B1BDA59E4FA77952C1CDB73D79C16E4B4D12F", var_16]);

  if(isvalidclient(var_1)) {
    updatetournamentroundtime(self getxuid(), var_1 getxuid(), var_4, var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799");

    if(isDefined(level.matchrecording_logevent)) {
      var_46 = gettime();
      [[level.matchrecording_logevent]](self.clientid, self.team, "_encstr_AD75062D5F18A10C", self.origin[0], self.origin[1], var_46);

      if(issubstr(tolower(var_3), "_encstr_A6260731BAD8D82BD1") && isDefined(var_4) && !scripts\mp\utility\weapon::iskillstreakweapon(var_4))
        [[level.matchrecording_logevent]](var_1.clientid, var_1.team, "_encstr_A6260721AA98982A51", var_1.origin[0], var_1.origin[1], var_46, undefined, self.origin[0], self.origin[1]);
    }
  }
}

getplayerbuffs() {
  var_0 = [];
  var_0[0] = scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team);
  var_0[1] = scripts\mp\utility\perk::_hasperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939") && !scripts\mp\utility\perk::_hasperk("_encstr_A7140F937898399A89DBB96DC863D2C5E3");
  var_0[2] = scripts\mp\utility\perk::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
  return var_0;
}

getplayerdebuffs() {
  var_0 = gettime();
  var_1 = [];
  var_1[0] = scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team);
  var_1[1] = scripts\cp_mp\killstreaks\helper_drone::istargetmarked();
  var_1[2] = istrue(self.flashbanged);
  var_1[3] = istrue(self.concussiongrenadefx);
  var_1[4] = isDefined(self.gastriggerstouching) && self.gastriggerstouching.size > 0 || isDefined(self.lastgastouchtime) && self.lastgastouchtime + 5000 > var_0;
  var_1[5] = isDefined(self.burninginfo) || isDefined(self.lastburntime) && self.lastburntime + 5000 > var_0;
  var_1[6] = isDefined(self.lastsnapshotgrenadetime) && self.lastsnapshotgrenadetime + 5000 > var_0;
  var_1[7] = isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > var_0;
  var_1[8] = istrue(self.empcount);
  var_1[9] = istrue(self.wphealthblock);
  return var_1;
}

_id_119CC(var_0) {
  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = "_encstr_B40101";

  if(level.teambased)
    var_2 = int(scripts\mp\rank::getteamrankxpmultiplier(self.team));
  else
    var_2 = 0;

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"]))
      var_3 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"]))
      var_4 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"]))
      var_5 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"]))
      var_6 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"]))
      var_7 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC84B"]))
      var_8 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC84B"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"]))
      var_9 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"];
  }

  var_10 = scripts\mp\rank::getrankxp();
  var_11 = scripts\mp\rank::getrankforxp(var_10);

  if(scripts\mp\utility\game::rankingenabled() && self hasplayerdata()) {
    var_12 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
    var_13 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");
    var_14 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");
    var_15 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
    var_16 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_17 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
    var_18 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
    var_19 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_AC410A68C2CD019167865C4E");
    var_20 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8FD00BB9B22C27A6A5CDCDB2DC");
    var_21 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
    var_22 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_8893104796DA2B14B185E5B2198A7BE80B36");
    var_23 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_82FB06EB26785BD7");
    var_24 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");
    var_25 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");
  } else {
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;
    var_25 = 0;
  }

  var_26 = -1;
  var_27 = 0;
  var_28 = 0;

  if(isDefined(var_0)) {
    if(scripts\mp\utility\game::isroundbased())
      var_26 = game["_encstr_8DC30DAA0285FD69FAE113371B1934"];

    if(level.teambased) {
      if(isDefined(self.team)) {
        if(self.team == "_encstr_9A8507BA4040188D08") {
          var_27 = getteamscore("_encstr_9A8507BA4040188D08");
          var_28 = getteamscore("_encstr_8E8405EA382B2A");
        } else if(self.team == "_encstr_8E8405EA382B2A") {
          var_27 = getteamscore("_encstr_8E8405EA382B2A");
          var_28 = getteamscore("_encstr_9A8507BA4040188D08");
        }
      }
    }
  }

  if(isDefined(self.segments) && self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] >= 30) {
    var_29 = self.segments["_encstr_A2900CD6BDECD237D9157B8E161B"] / (self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] / 5) * 100;
    var_30 = self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] / self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"];
  } else {
    var_30 = 0.0;
    var_29 = 0.0;
  }

  var_31 = 0;

  if(isDefined(self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"]))
    var_31 = self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"];

  var_32 = 0.0;

  if(isDefined(self.pers["_encstr_B1A81263104592BBB74837413915989D6123EAE5"]))
    var_32 = float(self.pers["_encstr_B1A81263104592BBB74837413915989D6123EAE5"]);

  var_33 = 0.0;

  if(isDefined(self.pers["_encstr_ABAB0B8A63871B13AD20BBEFA0"]) && isDefined(self.pers["_encstr_826D099BD308330249988B"])) {
    var_34 = scripts\mp\utility\stats::getpersstat("_encstr_ABAB0B8A63871B13AD20BBEFA0");

    if(var_34 > 0)
      var_33 = float(scripts\mp\utility\stats::getpersstat("_encstr_826D099BD308330249988B") / var_34 * 100);
  }

  var_35 = 0;

  if(isDefined(self.pers["_encstr_A68209DFE7B79AEC5BF76E"]))
    var_35 = scripts\mp\utility\stats::getpersstat("_encstr_A68209DFE7B79AEC5BF76E");

  var_36 = [];
  var_36["_encstr_A1050D832759376EAFE4B1362DB1AD"] = 0;
  var_36["_encstr_87DB0D7B72E22BA740DD43519A529A"] = 0;
  var_36["_encstr_99420F386A6BD3B6E9C94B094B10BEF4A2"] = 0;
  var_36["_encstr_A2610EB72B820FBB37DFBADA2D9B0AA0"] = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" && isDefined(self.setaardata)) {
    var_36["_encstr_A1050D832759376EAFE4B1362DB1AD"] = istrue(self.setaardata["_encstr_B24E0D50E350E3C33B479B573BCBF0"]);
    var_36["_encstr_87DB0D7B72E22BA740DD43519A529A"] = istrue(self.setaardata["_encstr_8C380CF1AD53430B0D8B78C0A3E2"]);
    var_36["_encstr_99420F386A6BD3B6E9C94B094B10BEF4A2"] = istrue(self.setaardata["_encstr_85AD0950914BBF136ACB7F"]);
    var_36["_encstr_A2610EB72B820FBB37DFBADA2D9B0AA0"] = istrue(self.setaardata["_encstr_8E560870BA92B979E304"]);
  }

  var_37 = 0;
  var_38 = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    foreach(var_40 in level.teamnamelist) {
      var_41 = scripts\mp\utility\teams::getteamcount(var_40, 1);
      var_37 = var_37 + var_41;

      if(var_41 > 0)
        var_38++;
    }
  }

  self dlog_recordplayerevent("_encstr_81081C7A248788A7399389B51DEFF3A483A8E77DCFE51873976B410AF0A7", ["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57", var_31, "_encstr_911316D58E6CF5C8A5CD8DBD9BCDAC363AD747966B56F5B9", getsystemtime(), "_encstr_82FB06EB26785BD7", scripts\mp\utility\stats::getpersstat("_encstr_82FB06EB26785BD7"), "_encstr_A1F308589BCD96CD476E", scripts\mp\utility\stats::getpersstat("_encstr_A1F308589BCD96CD476E"), "_encstr_B4F90F481DA6F07DE30B5F0F23DBB5184B", scripts\mp\utility\stats::getpersstat("_encstr_87F20E78EA85EF89E7449E053AC771BF"), "_encstr_8E8D0697EB01F243", scripts\mp\utility\stats::getpersstat("_encstr_8E8D0697EB01F243"), "_encstr_8E0607055DBFB3919A", scripts\mp\utility\stats::getpersstat("_encstr_8E0607055DBFB3919A"), "_encstr_96D30A3468575BA3C307A128", scripts\mp\utility\stats::getpersstat("_encstr_96D30A3468575BA3C307A128"), "_encstr_82B30BB521F80E0FE5C81A1293", scripts\mp\utility\stats::getpersstat("_encstr_82B30BB521F80E0FE5C81A1293"), "_encstr_821A1317353ADB895267D0887F95ED29425F03150A", int(scripts\mp\rank::getrankxpmultipliertotal()), "_encstr_BE18111DCA85D6FA3C07BEB67B32A5CC5A954E", var_2, "_encstr_95BB1377AC0BE0F6CD7D870EEBD6F6C896664BB24E", int(scripts\mp\weaponrank::getweaponrankxpmultipliertotal()), "_encstr_8663174C2CD11DB1AC832CDCDCEBE10EEB6BBDC82D995AB24E", int(scripts\mp\rank::registerpublicevent()), "_encstr_AF250998CA2383C837286F", var_3, "_encstr_BA17096BDE6798BDE1FBC1", var_4, "_encstr_93FC0D1A68EB3D93B120776D50FA2B", var_5, "_encstr_A279099D7721FAB83E1823", var_6, "_encstr_BEDA097D95E13A5CDEF883", var_7, "_encstr_BE7609E690080D43C099A3", var_8, "_encstr_914C08B5B49B1BFAE1C1", var_9, "_encstr_A51F05CB11A052", var_11, "_encstr_83250C68679183370209EE7F5D0A", var_25, "_encstr_938A079F08E09F3B8F", var_12, "_encstr_B2CC0A83A89A1EF34B4409D6", var_13, "_encstr_91610B1D9513517A5D4B1360C2", var_14, "_encstr_8432090DAE532E27943240", var_15, "_encstr_8AF40B2BCD8CBEB1B76EB92B37", var_16, "_encstr_BDA30903738A6090B1C38B", var_17, "_encstr_B1A40B2B738CF5B6A5DCDCCA9B", var_18, "_encstr_978E0F7A58E1F1FF31217C57CED9530737", var_19, "_encstr_82A40F2BCA378FF8AF217EF931AF03B35A", var_20, "_encstr_8FCB11B2B9C8F576C2DA569BEB831BC22F5632", var_21, "_encstr_83CC1659E6327D47B4B5567D1C8D2CBCB246F5E87B8EC2D8", var_22, "_encstr_A7480A75CD30C1D7AEC80B62", var_23, "_encstr_84AA0D8F68917F23CD9DEA23F39F0A", var_24, "_encstr_AC99122C6FF0283880FEE84FE3BFD61FC1D03DF2", var_1, "_encstr_97FA19C1362CCB2BE4FAE2ABA53AD727DB5DE632D737AB6B31CA27", var_26, "_encstr_865517FFDDD23311CACF20083FE46E913A06F990F22AD7BB85", var_27, "_encstr_88132053F0B9E1CA4508F2EB0B21218FE378B7D760F03791913DFEE578173A470B48", var_28, "_encstr_8EBC1B169DAC2785762BAFB91CB25691F546AE272D379D7DB585A3C6A1", var_30, "_encstr_9563141CB24E6C95E68EF5A3B4B6CAF5DAB7EC969BD9", var_29, "_encstr_91D40CD8AF05BAEF0DCFCD751AF3", scripts\mp\utility\stats::getpersstat("_encstr_B2BE0788BAF573592F"), "_encstr_B2310D943398AE674DEE4B0270958B", scripts\mp\utility\stats::getpersstat("_encstr_A7630C1916DAC2762BA20BB65673"), "_encstr_8A3A126BB0937412D5BE4FC91DD52A3EF963E713", var_32, "_encstr_BAFC10DDB20B1CDB73FAB01B1B5727C2D897", var_33, "_encstr_A68209DFE7B79AEC5BF76E", var_35, "_encstr_81820A4A30E36F4FA39B507D", scripts\mp\utility\game::getgametype(), "_encstr_8F4C1FE00787BB31DA1B8818F5F27180EFE399D08B5573EF01867695CC1BA3CB4D", var_36["_encstr_99420F386A6BD3B6E9C94B094B10BEF4A2"], "_encstr_96DE1E4C73611F4B6A8735B180CA4B63976CF8FBA23DB88B91879FB20309B6E8", var_36["_encstr_A2610EB72B820FBB37DFBADA2D9B0AA0"], "_encstr_96011DD9DDAF6E07B077CDD76BAC8E34F632D738E495CDCDEB1B8DC64BB1B6", var_36["_encstr_87DB0D7B72E22BA740DD43519A529A"], "_encstr_8B261D3103BF78DFFA2F25BFBF422568575FBE6BEAED9B16311337D1870AE2", var_36["_encstr_A1050D832759376EAFE4B1362DB1AD"], "_encstr_B6900C6BCB61F01D2FE21039BB4F", self calloutmarkerping_getEnt(), "_encstr_A54D12D411BF9EAF271398E88A3A791077AD5E45", self _meth_87D6() != 1, "_encstr_9B2B154A1ECEEB47C3189AE2B02D3FA7C389D1D93D33A7", var_37, "_encstr_8F4813C813879B1B1A9E0B80F4425766F4E768388F", var_38, "_encstr_96640CC5114E63C67D301B7130B9", self _meth_87C4()]);
}

initdialog() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!self hasplayerdata()) {
    return;
  }
  var_0 = scripts\mp\utility\game::getgametype();
  var_1 = scripts\mp\utility\stats::getpersstat("_encstr_8E8D0697EB01F243");
  var_2 = scripts\mp\utility\stats::getpersstat("_encstr_8E0607055DBFB3919A");
  var_3 = scripts\mp\utility\stats::getpersstat("_encstr_96D30A3468575BA3C307A128");
  var_4 = scripts\mp\utility\stats::getpersstat("_encstr_A1F308589BCD96CD476E");
  var_5 = scripts\mp\utility\stats::getpersstat("_encstr_A68209DFE7B79AEC5BF76E");
  var_6 = scripts\mp\utility\stats::getpersstat("_encstr_82FB06EB26785BD7");
  var_7 = scripts\mp\rank::getrankxp();
  var_8 = scripts\mp\rank::getrankforxp(var_7);
  var_9 = scripts\mp\utility\stats::getpersstat("_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57");
  var_10 = getsystemtime() - var_9;
  self getcurrentusereloadconfig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_8, var_10);
}

logplayerdata(var_0) {
  if(!isvalidclient(self)) {
    return;
  }
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8BFF0A63E8D78F37E0C7F8F8");
  _id_119CC(var_0);
  initdialog();

  if(!isai(self) && !scripts\mp\utility\game::rankingenabled()) {
    var_2 = scripts\mp\rank::initcpammoarmorcrate(self);
    scripts\mp\rank::initcprooftopcrate(self.initdismembermentlist, var_2);
  }

  self sendclientnetworktelemetry();
  self radiusdamagestepped();
  var_3 = 0;
  var_4 = 0;

  foreach(var_23, var_6 in self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"]) {
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
      if(isenumvaluevalid("_encstr_927C07D787E1823F38", "_encstr_9AA40EC4BD588CF6AED1BA952C07DE9B", var_6.weapon))
        var_7 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", var_6.weapon);
    }

    foreach(var_18, var_17 in var_6.stats) {
      if(var_18 == "_encstr_8E0607055DBFB3919A")
        var_9 = var_9 + var_17;

      if(var_18 == "_encstr_96D30A3468575BA3C307A128")
        var_10 = var_10 + var_17;

      if(var_18 == "_encstr_88CC0521F3A13B") {
        var_11 = var_11 + var_17;
        var_4 = var_4 + var_17;
      }

      if(var_18 == "_encstr_8E8D0697EB01F243")
        var_12 = var_12 + var_17;

      if(var_18 == "_encstr_884806B91ADEE8CD") {
        var_13 = var_13 + var_17;
        var_3 = var_3 + var_17;
      }

      if(var_18 == "_encstr_AF2F0A13317F6999F380EB53")
        var_8 = var_8 + var_17;

      if(var_18 == "_encstr_B2BE0788BAF573592F")
        var_14 = var_14 + var_17;

      if(var_18 == "_encstr_B8C8158BF5BB5A662070A8392990A29218611F3FBBD402")
        var_15 = var_15 + var_17;
    }

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
      self dlog_recordplayerevent("_encstr_BD3C1F8CD8B7D97DCACEACB93AFA38B1C2E55939AFDD5616C1DE73F537A30BD1E6", ["_encstr_AC20072B9FA9487832", var_6.weapon, "_encstr_A2FB0B6B2136B74E68C97759F1", var_6.variantid, "_encstr_85C60EB1E70F014FCBDB59E052A703DA", var_6.loadoutindex, "_encstr_9A1713DCD11627E82D37B3FAEEB258837B37F5871C", var_7, "_encstr_AF2F0A13317F6999F380EB53", var_8, "_encstr_8E0607055DBFB3919A", var_9, "_encstr_96D30A3468575BA3C307A128", var_10, "_encstr_88CC0521F3A13B", var_11, "_encstr_8E8D0697EB01F243", var_12, "_encstr_884806B91ADEE8CD", var_13, "_encstr_B2BE0788BAF573592F", var_14, "_encstr_B8C8158BF5BB5A662070A8392990A29218611F3FBBD402", var_15]);
      continue;
    }

    var_19 = isDefined(var_6.iscustomweapon);
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;

    if(isDefined(var_6.stats["_encstr_B1680CF9B7C2A5E155FA81B9E93B"]))
      var_22 = var_6.stats["_encstr_B1680CF9B7C2A5E155FA81B9E93B"];

    self dlog_recordplayerevent("_encstr_BADE228CC6DBD9F595B356DCD1BE0E3616CBB2E4EBEE5916E0B7CDD7B91D16A3E6FAC427", ["_encstr_AC20072B9FA9487832", var_6.weapon, "_encstr_A2FB0B6B2136B74E68C97759F1", var_6.variantid, "_encstr_86A60DC2EB101F79D067A1AC0F70FB", var_19, "_encstr_9267057B2785D7", var_20, "_encstr_B1680CF9B7C2A5E155FA81B9E93B", var_22, "_encstr_BDCB1559B58AA7C9138BA908E74CC6E982DACD574DF27B", var_21, "_encstr_8E0607055DBFB3919A", var_9, "_encstr_96D30A3468575BA3C307A128", var_10, "_encstr_88CC0521F3A13B", var_11, "_encstr_8E8D0697EB01F243", var_12, "_encstr_884806B91ADEE8CD", var_13, "_encstr_B2BE0788BAF573592F", var_14, "_encstr_87850D501B43A309CB1DC548FCEF9B", var_6.attachments[0], "_encstr_96850D583AD10B6CA16BCADC47AF26", var_6.attachments[1], "_encstr_82850D58A33A58361AB6CA733AFA64", var_6.attachments[2], "_encstr_BD850D851DE82C36346BB2738ED766", var_6.attachments[3], "_encstr_AA850D17BBE363F1F027A0F0AB2FE3", var_6.attachments[4], "_encstr_87070A63F53AFBCCE99A8107", var_6._id_138A8[0], "_encstr_96070A287082C64A09539917", var_6._id_138A8[1], "_encstr_82070A1069B43E30CDA5BF7D", var_6._id_138A8[2], "_encstr_BD070AAF3C1C588AAF13C643", var_6._id_138A8[3], "_encstr_925008E456475A6CB195", var_6.reticle, "_encstr_91211446E80B90032BE8BA2FEAF56B60D76115DD165B", var_6.impactfunc_carbon, "_encstr_B19005D885B5F6", var_6.camo, "_encstr_84831525CF69B2E066303F17805EA3EB1357EB5F25970B", var_6.pickuptime]);
  }
}

logscoreevent(var_0) {
  if(scripts\mp\utility\entity::isgameparticipant(self) == 0) {
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

_id_13154(var_0) {
  if(getdvarint("_encstr_8ED90B7760E79BE90BB5143983") == 1)
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_BAB7113799ADD84957A2717C3A530398C4F565", "_encstr_99C209E34FC743616118AB");
  else if(getdvarint("_encstr_AAE70BC991F201278BEB95E09F") == 1)
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_BAB7113799ADD84957A2717C3A530398C4F565", "_encstr_8E0409A16FF2D1FF40C2F8");
  else
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_BAB7113799ADD84957A2717C3A530398C4F565", "_encstr_820E07FAE8780B3A4C");
}

endofgamesummarylogger() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1", var_0);

  foreach(var_2 in level.players) {
    wait 0.05;

    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2.weaponsused)) {
      var_2 doublebubblesort();
      var_3 = 0;

      if(var_2.weaponsused.size > 3) {
        for(var_4 = var_2.weaponsused.size - 1; var_4 > var_2.weaponsused.size - 3; var_4--) {
          var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", var_3, var_2.weaponsused[var_4]);
          var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", var_3, var_2.weaponxpearned[var_4]);
          var_3++;
        }
      } else {
        for(var_4 = var_2.weaponsused.size - 1; var_4 >= 0; var_4--) {
          var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", var_3, var_2.weaponsused[var_4]);
          var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", var_3, var_2.weaponxpearned[var_4]);
          var_3++;
        }
      }
    } else {
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 0, "_encstr_8BBA05185F8B99");
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 1, "_encstr_8BBA05185F8B99");
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8EB00CDB806BBA1F502EC5FBCDF9", 2, "_encstr_8BBA05185F8B99");
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 0, 0);
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 1, 0);
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_96880FDDB28583EDB9C2E08A1639CD5691", 2, 0);
    }

    if(isDefined(var_2.challengescompleted))
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_962116A64B4342E421E00737D91BADF80751EA1DA5C16A34", var_2.challengescompleted.size);
    else
      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_962116A64B4342E421E00737D91BADF80751EA1DA5C16A34", 0);

    for(var_4 = 0; var_4 < 20; var_4++) {
      if(isDefined(var_2.challengescompleted) && isDefined(var_2.challengescompleted[var_4]) && var_2.challengescompleted[var_4] != "_encstr_9BCE0C1B86EB38C956E6E8B43B59" && !issubstr(var_2.challengescompleted[var_4], "_encstr_8CE8077D91C22D1BCB") && !issubstr(var_2.challengescompleted[var_4], "_encstr_B1240818CF2F1117DD5B")) {
        var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", var_4, var_2.challengescompleted[var_4]);
        continue;
      }

      var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", var_4, "_encstr_99FA086C867D9B7B9B95");
    }

    var_5 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
    var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AAAC09D09972B9CC3F2B7F", scripts\mp\utility\game::getgametype());
    var_2 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AB1904852B68", var_5);
    _id_13154(var_2);
  }
}

_id_12AA9() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
    var_1 = getdvarint("_encstr_878A0BD371CD10B041BCDA9214");

    foreach(var_3 in level.players) {
      for(var_4 = 31; var_4 > 0; var_4--) {
        var_5 = var_3 getplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_4 - 1);
        var_3 setplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", var_4, var_5);
      }

      var_3 setplayerdata("_encstr_8C07031599", "_encstr_92210BB6851CCD14D82C979532", 0, var_0);

      for(var_4 = 4; var_4 > 0; var_4--) {
        var_6 = var_3 getplayerdata("_encstr_8C07031599", "_encstr_B8CB12D3C9BF9B644893EBBC69408002075B0F1B", var_4 - 1);
        var_3 setplayerdata("_encstr_8C07031599", "_encstr_B8CB12D3C9BF9B644893EBBC69408002075B0F1B", var_4, var_6);
      }

      var_3 setplayerdata("_encstr_8C07031599", "_encstr_B8CB12D3C9BF9B644893EBBC69408002075B0F1B", 0, var_1);
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

logweaponstat(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0) || scripts\mp\utility\weapon::isvehicleweapon(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !istrue(level.get_alive_nonspecating_players)) {
    return;
  }
  var_5 = var_0;

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(isDefined(self.loadoutindex))
      var_5 = var_5 + "_encstr_95CD0E65C6BD588CDB573A943719B2C3" + self.loadoutindex;
    else
      return;
  } else if(isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5]) && isDefined(var_4)) {
    if(!getjuggmazebutton(var_4, var_5)) {
      var_6 = 1;
      var_7 = var_5 + "_encstr_BA4C02DF" + var_6;

      for(;;) {
        if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_7]) || getjuggmazebutton(var_4, var_7)) {
          break;
        }

        var_6++;
        var_7 = var_5 + "_encstr_BA4C02DF" + var_6;
      }

      var_5 = var_7;
    }
  }

  if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5])) {
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5] = spawnStruct();
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].stats = [];
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].weapon = var_0;
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].loadoutindex = self.loadoutindex;

    if(isDefined(var_3))
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].variantid = var_3;
    else
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].variantid = -1;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && isDefined(var_4)) {
      var_8 = scripts\engine\utility::ter_op(isDefined(var_4.camo), var_4.camo, "_encstr_8BBA05185F8B99");
      var_9 = scripts\engine\utility::ter_op(isDefined(var_4.visual), var_4.visual, "_encstr_8BBA05185F8B99");
      var_10 = scripts\engine\utility::ter_op(isDefined(var_4.reticle), var_4.reticle, "_encstr_8BBA05185F8B99");
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].iscustomweapon = isDefined(var_4.customweaponname);
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].camo = var_8;
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].impactfunc_carbon = var_9;
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].reticle = var_10;
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].pickuptime = scripts\cp_mp\utility\game_utility::gettimesincegamestart();
      var_11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_4);
      var_12 = [];

      for(var_13 = 0; var_13 < 5; var_13++)
        var_12[var_13] = "_encstr_8BBA05185F8B99";

      var_14 = 0;

      foreach(var_16 in var_11) {
        if(scripts\mp\utility\weapon::attachmentlogsstats(var_16, var_4)) {
          var_12[var_14] = var_16;
          var_14++;
        }
      }

      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].attachments = var_12;
      var_18 = [];
      var_18[var_18.size] = var_4.stickerslot0;
      var_18[var_18.size] = var_4.stickerslot1;
      var_18[var_18.size] = var_4.stickerslot2;
      var_18[var_18.size] = var_4.stickerslot3;
      self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5]._id_138A8 = var_18;
    }
  }

  if(!isDefined(self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].stats[var_1]))
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].stats[var_1] = var_2;
  else
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].stats[var_1] = self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_5].stats[var_1] + var_2;
}

getjuggmazebutton(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.camo), var_0.camo, "_encstr_8BBA05185F8B99");

  if(var_2 != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1].camo)
    return 0;

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.visual), var_0.visual, "_encstr_8BBA05185F8B99");

  if(var_3 != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1].impactfunc_carbon)
    return 0;

  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.reticle), var_0.reticle, "_encstr_8BBA05185F8B99");

  if(var_4 != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1].reticle)
    return 0;

  var_5 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

  if(var_5.size != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1].attachments.size)
    return 0;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1].attachments[var_6])
      return 0;
  }

  var_7 = [];
  var_7[var_7.size] = var_0.stickerslot0;
  var_7[var_7.size] = var_0.stickerslot1;
  var_7[var_7.size] = var_0.stickerslot2;
  var_7[var_7.size] = var_0.stickerslot3;

  if(var_7.size != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1]._id_138A8.size)
    return 0;

  for(var_6 = 0; var_6 < var_7.size; var_6++) {
    if(var_7[var_6] != self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"][var_1]._id_138A8[var_6])
      return 0;
  }

  return 1;
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