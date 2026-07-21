/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\btm.gsc
***********************************************/

main() {
  var_0 = spawnStruct();
  level.btm = var_0;

  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_1[0] = scripts\mp\utility\game::getgametype();
  var_1[1] = "_encstr_B67B0A1A2C279107DBB49BA3";
  var_1[2] = "_encstr_A11904E823B6";
  var_1[3] = "_encstr_8E07030349";
  var_1[4] = "_encstr_8218041DF5FA";
  var_1[5] = "_encstr_B807035284";
  var_1[6] = "_encstr_979A09DA67D0262B70CD82";
  var_1[7] = "_encstr_A65908C41BED1BD62B4E";
  scripts\mp\gameobjects::main(var_1);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onteamscore = ::onteamscore;
  level.onnormaldeath = ::onnormaldeath;
  level.lastcaptime = gettime();
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  level.kothmode = 0;
  level.hqautodestroytime = 60;
  level.promode = 1;
  level.extradelay = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_AC0E136F19B72DBB1343704E303F2255BA58E4D520";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2C30DC06FBD8177D266831BFFFB5B"] = "_encstr_B2C30DC06FBD8177D266831BFFFB5B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6260B26DB5B98F51D16DAAC73"] = "_encstr_B6260B26DB5B98F51D16DAAC73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F850A13DBDA31AF8DED6E1D"] = "_encstr_957D0F22AF0F26E910DDF7B8E7A23B2DE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"] = "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB3D0DE25FE81EF7B7188A42230553"] = "_encstr_AB3D0DE25FE81EF7B7188A42230553";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA920D59E6CA6B2FAF4CDBD631FAB0"] = "_encstr_96D50DB638514326450683D863A990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95920D7910C5AB2FB9D6A72D9ABFED"] = "_encstr_88D50D4CF6B626BE59CDB2AD2FAFC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93E61365C8514FA84FF8120AC077A727692DFB1D55"] = "_encstr_8E061206578F71FF1FAA7830F377B34947D31D8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84B513CA73CADABC7D98BDDAC4AF0E63B0B9D156C8"] = "_encstr_BDAF1226DED613FA959BAC6BF20E8D16DC472B91";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B49115530AF3982033459FED7F9DD0C947B2693B3227CD", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_86550DFA1D220B34D12B80A33FFD29"));
  setdynamicdvar("_encstr_B29C18336A93F8405325FFCD5FBD30AE87F36B7BE327B5C02D05", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59"));
  setdynamicdvar("_encstr_ACAC1CCF7758EF62FB3329F5B566152B5A755B237A45C0B7F6DD4D20EA43", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5"));
  setdynamicdvar("_encstr_B1901CDC8DC9F598D1B5BE9C58E691BD5B26F68D58D1A5B7E63DE419CAC9", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB"));
  setdynamicdvar("_encstr_8FC918B98DE4F526E8DAF50B8C235AE82D67B235C6F6C94B37EC", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_829C10A99FECC0B502436B0F3F4AFE988E37"));
  setdynamicdvar("_encstr_842812E6D839D731A3B67D830BBA6ECA2A96ADCA", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_83FE0A484FBDAB0BF9EC1915"));
  setdynamicdvar("_encstr_86C314A65EE829066BCA3FD9D31917D13F50F6B1D762", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_95F213032FD22116589D902D10C730D9EA1F8D4DBB", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_832F0B5BCFA2A1623A2B6903B6"));
  setdynamicdvar("_encstr_BE16139B1B4EBE31A3D6BEDCC1C2DDCD8C2BB1B0E5", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_8CA10BD013238F78BFFAB053C3"));
  setdynamicdvar("_encstr_A7D113127E3521BA5388975B50E97798E3875D4B53", getmatchrulesdata("_encstr_8D97082E437F993BA47E", "_encstr_A71D0B383BB7BF7CEFE1B1B5F0"));
  setdynamicdvar("_encstr_95D317A2CE6571EA03F8E70BAB59A7FB3753EBDE23C1AA3DC9", getmatchrulesdata("_encstr_8D97082E437F993BA47E", "_encstr_AC210F889BAFF066A37F092F53B9B37845"));
  setdynamicdvar("_encstr_A16512A723A2C106E3FACE1313A74F687CAD0777", getmatchrulesdata("_encstr_8D97082E437F993BA47E", "_encstr_91DC0A0EC15B05B992AEEC3B"));
  setdynamicdvar("_encstr_8AD712626693B1C0F5815F60375F307D7AEBE41A", getmatchrulesdata("_encstr_8D97082E437F993BA47E", "_encstr_8A460AE07F50677ADA5539A8"));
  setdynamicdvar("_encstr_9A79166EC693D726E8B5FA1C83D635BA3BECDB379AEA9D76", getmatchrulesdata("_encstr_8D97082E437F993BA47E", "_encstr_833C0EDA3AA7D4ED68A247A85BA73ABC"));
  setdynamicdvar("_encstr_ABC212E636C9FADADBE834AF0DC2B199474BD6B2", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_BDD705AD7BD143", 0);
}

onstartgametype() {
  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8F8E16FF96E3C81EFCB35DE5A99D2BD71118994F03575FEF");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_92E0155D08136D63C5096F4F23CD382F7F9B9FB87B999C");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  level.objectives = [];
  thread objectiveselectorsetup();
  setupradios();
  setupbtmflags();
  thread dommainloop();
  thread hqmainloop();
  level thread waittospawnvip();
  level thread waittospawnjuggcrate();
  level thread waittospawnbtmbombs();
  setmapsizespawnconsts();
  initspawns();
  seticonnames();
  setupwaypointicons();
  level.usedomflag = 0;
  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", 0);
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", -1);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86550DFA1D220B34D12B80A33FFD29", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59", 0, 0, 30);
  level.zoneactivationdelay = 30;
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_829C10A99FECC0B502436B0F3F4AFE988E37", 0, 0, 1);
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_83FE0A484FBDAB0BF9EC1915", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8CA10BD013238F78BFFAB053C3", 5, 0, 30);
  level.usehqrules = 1;
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 10, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("_encstr_8BB015CC36583BE6A495C5AED2C99546A2F69A36ED9CCA", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA150E0BDD617835235BEBCD2BFAF768", 10, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("_encstr_82730D3B68514312E927CD4410D90B", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("_encstr_87940DB10BE0D1D5E42B88ACC616E5", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("_encstr_A5B60CF9DFD99DEB337D3193BF2F", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("_encstr_813614C07352A6316B87B7D13FF728B02C383CEAE578", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86FA0ABD89A6D41B85630BC9", 4, 1, 10);
  level.jugghealth = scripts\mp\utility\dvars::dvarintvalue("_encstr_A71D0B383BB7BF7CEFE1B1B5F0", 1000, 1000, 10000);
  level.juggswitchtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AC210F889BAFF066A37F092F53B9B37845", 60, 10, 180);
  level.ppkasjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_91DC0A0EC15B05B992AEEC3B", 20, 1, 100);
  level.ppkonjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A460AE07F50677ADA5539A8", 50, 1, 100);
  level.ppkjuggonjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_833C0EDA3AA7D4ED68A247A85BA73ABC", 50, 1, 100);
}

setmapsizespawnconsts() {
  var_0 = getsubstr(level.mapname, 0, 7);

  switch (var_0) {
    case "_encstr_B16A08CBD3E12C504C3D":
    case "_encstr_921D08CBC0A1C805D263":
    case "_encstr_B6D50802506FD777680D":
    case "_encstr_88FE08055947EA608630":
    case "_encstr_9735082D83EF68C9D3BA":
    case "_encstr_BDFF088922C9FF1946BF":
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    default:
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 225000000;
      level.max_relevant_spawn_dist = 5000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
  }
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointbyindex("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");

  if(!level.spawnpoints.size) {
    return;
  }
  foreach(var_1 in level.objectives) {
    var_1.furthestspawndistsq = 0;
    var_1.spawnpoints = [];
    var_1.fallbackspawnpoints = [];
  }

  foreach(var_4 in level.spawnpoints) {
    calculatespawndisttozones(var_4);
    var_5 = scripts\mp\spawnlogic::getoriginidentifierstring(var_4);

    if(isDefined(level.btmextraprimaryspawnpoints) && isDefined(level.btmextraprimaryspawnpoints[var_5])) {
      foreach(var_7 in level.btmextraprimaryspawnpoints[var_5]) {
        var_1 = level.objectives[var_7];
        var_1.spawnpoints[var_1.spawnpoints.size] = var_4;
      }
    }

    var_9 = 0;
    var_10 = var_4.classname == "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    var_11 = var_4.classname == "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318";

    if(var_10 || var_11) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy != "_encstr_B40101") {
        var_9 = 1;
        var_12 = strtok(var_4.script_noteworthy, "_encstr_974C0246");

        foreach(var_7 in var_12) {
          var_1 = level.objectives[var_7];

          if(var_10) {
            var_1.spawnpoints[var_1.spawnpoints.size] = var_4;
            continue;
          }

          var_1.fallbackspawnpoints[var_1.fallbackspawnpoints.size] = var_4;
        }
      }
    }

    if(!var_9) {
      foreach(var_1 in level.objectives) {
        if(var_4.scriptdata.distsqtokothzones[var_1 getentitynumber()] < level.close_spawn_min_dist_sq || var_4.scriptdata.distsqtokothzones[var_1 getentitynumber()] > level.max_spawn_dist_sq)
          var_1.removespawn = 1;

        if(var_10) {
          if(!isDefined(var_1.removespawn))
            var_1.spawnpoints[var_1.spawnpoints.size] = var_4;

          continue;
        }

        var_1.fallbackspawnpoints[var_1.fallbackspawnpoints.size] = var_4;
      }
    }
  }

  foreach(var_19, var_1 in level.objectives) {
    var_1.spawnset = "_encstr_869B056E7B98AF" + var_19;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnset, var_1.spawnpoints);
    var_1.fallbackspawnset = "_encstr_ABA90ECE6D83A9064908C3F388E1F351" + var_19;
    scripts\mp\spawnlogic::registerspawnset(var_1.fallbackspawnset, var_1.fallbackspawnpoints);
  }
}

calculatespawndisttozones(var_0) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_2 in level.objectives) {
    var_3 = getpathdist(var_0.origin, var_2.origin, level.max_relevant_spawn_dist);

    if(var_3 < 0)
      var_3 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_2.origin);
    else
      var_3 = var_3 * var_3;

    var_0.scriptdata.distsqtokothzones[var_2 getentitynumber()] = var_3;

    if(var_3 > var_2.furthestspawndistsq)
      var_2.furthestspawndistsq = var_3;
  }
}

setupradios() {
  var_0 = [];
  var_1 = getEntArray("_encstr_88620DCAC0F75CC773054047ABD8DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size < 2)
    var_0[var_0.size] = "_encstr_85793A3320C91A3A31C7E2DF9F4552C4B9C00B6A98A14103A14FFA86151D9B919B78C7BF925BB1BBF15773CE86274234A0907F6F2A19E2D2319BBD16";

  var_2 = getEntArray("_encstr_83FC0D584FACE81FFB2A1B1447C26D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = 0;
    var_5 = var_1[var_3];
    var_5.trig = undefined;

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      if(var_5 istouching(var_2[var_6])) {
        if(isDefined(var_5.trig)) {
          var_0[var_0.size] = "_encstr_8D760A82D77704C85637F389" + var_5.origin + "_encstr_919B32A9813AE2E56783A1C82A0B149AD5EF95AB702368A7BBEE3870F20A7EC06E7C2B07CC0A38FCB75293F18EB30E4007D74BB5";
          var_4 = 1;
          break;
        }

        var_5.trig = var_2[var_6];
        break;
      }
    }

    if(!isDefined(var_5.trig)) {
      if(!var_4)
        var_0[var_0.size] = "_encstr_8D760A82D77704C85637F389" + var_5.origin + "_encstr_B6C42A46FBB75636B0C0EAD708EBF9DA63A79E4D5BB92E521968C7C730E3A192CFADA2D66F49E381E108CF4B";

      var_5.trig = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5.origin, 0, 128, 128);
      var_4 = 0;
    }

    var_5.trigorigin = var_5.trig.origin;
    var_7 = [];
    var_7[0] = var_5;
    var_8 = getEntArray(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_6 = 0; var_6 < var_8.size; var_6++)
      var_7[var_7.size] = var_8[var_6];

    var_5.visuals = var_7;
    var_5 scripts\mp\gameobjects::setmodelvisibility(0);
    var_5.gameobject = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_5.trig, var_5.visuals, var_5.origin - var_5.trigorigin + (0, 0, 60));
    var_5.gameobject scripts\mp\gameobjects::disableobject();
    var_5.gameobject scripts\mp\gameobjects::setmodelvisibility(0);
    var_5.trig.useobj = var_5.gameobject;
  }

  if(var_0.size > 0) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {}
  }

  foreach(var_10 in var_1)
  level.objectives[level.objectives.size] = var_10;

  level.radios = var_1;
  level.radios2 = var_1;
  level.prevradio = undefined;
  level.prevradio2 = undefined;
  return 1;
}

setupbtmflags() {
  var_0 = getEntArray("_encstr_AA8B11062BE28FE144A720E9CB72D833CA5203", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    var_1 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = getEntArray("_encstr_B40B0FA771DFC427F7DB8BD0FDB4F90ED8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_3 = 0; var_3 < var_1.size; var_3++)
      level.primaryflags[level.primaryflags.size] = var_1[var_3];

    for(var_3 = 0; var_3 < var_2.size; var_3++)
      level.primaryflags[level.primaryflags.size] = var_2[var_3];

    level thread runnormaldomflags(var_1, var_2);
  } else {
    level.primaryflags = var_0;
    level.primaryflags2 = var_0;
    level.prevflag = undefined;
    level.prevflag2 = undefined;
    level thread runbtmflags();
  }

  foreach(var_5 in level.primaryflags)
  level.objectives[level.objectives.size] = var_5;
}

dommainloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread updatedomscores();
}

runbtmflags() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    level waittill("_encstr_8E770EE8732E97B0FFEAB521FF3B581B");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B67B0A122C279107DBB49BA3", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    var_0 = pickflagtospawn();
    var_0.script_label = "_encstr_B20703DFCF";
    var_1 = "_encstr_B20703DFCF";
    var_2 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_0);
    var_2.origin = var_0.origin;
    var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_2 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var_2.ignorestomp = 1;
    level.btmflagobject = var_2;
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(30000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 2);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_B1B30F5BD979A0176B69FBA0C2EF5E68CA");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

    foreach(var_4 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("_encstr_A6C30C07ABABC19F9B3FC5A3936D", var_4);

      if(scripts\mp\utility\teams::getteamdata(var_4, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_91E3185845D2E8974B07DF5D5A48E7CBB39545E5099156E46FCF", var_4, 4);
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    level.btmflagobject _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(60000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("_encstr_A79A1869C2293FF9A2B7E8C827C5B22FD26DD3E11CD2E3839D73");

    foreach(var_4 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_4, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_B8B0174DB6BAED8EDFC9C650E7D2872D5429B7EBE1D1283D0D", var_4, 4);
    }

    level.btmflagobject _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
    level removedompoint(var_1);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    level getnextobjective("_encstr_8218041DF5FA");
  }
}

runnormaldomflags(var_0, var_1) {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    level waittill("_encstr_8E770EE8732E97B0FFEAB521FF3B581B");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);

    switch (level.usedomflag) {
      case 0:
        var_2 = "_encstr_B40703E96D";
        break;
      case 1:
        var_2 = "_encstr_B20703DFCF";
        break;
      case 2:
        var_2 = "_encstr_B6070359BA";
        break;
      default:
        var_2 = "_encstr_B40703E96D";
        break;
    }

    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B67B0A122C279107DBB49BA3", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    var_3 = [];

    for(var_4 = 0; var_4 < var_0.size; var_4++)
      var_3[var_3.size] = var_0[var_4];

    for(var_4 = 0; var_4 < var_1.size; var_4++)
      var_3[var_3.size] = var_1[var_4];

    foreach(var_6 in var_3) {
      if(var_6.script_label == var_2) {
        var_7 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_6);
        var_7 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
        var_7.ignorestomp = 1;
        level.btmflagobject = var_7;
        break;
      }
    }

    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(30000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 2);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_B1B30F5BD979A0176B69FBA0C2EF5E68CA");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

    foreach(var_10 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("_encstr_A6C30C07ABABC19F9B3FC5A3936D", var_10);

      if(scripts\mp\utility\teams::getteamdata(var_10, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_91E3185845D2E8974B07DF5D5A48E7CBB39545E5099156E46FCF", var_10, 4);
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    level.btmflagobject _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(60000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("_encstr_A79A1869C2293FF9A2B7E8C827C5B22FD26DD3E11CD2E3839D73");

    foreach(var_10 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_10, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_B8B0174DB6BAED8EDFC9C650E7D2872D5429B7EBE1D1283D0D", var_10, 4);
    }

    level.btmflagobject _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
    level removedompoint(var_2);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    level getnextobjective("_encstr_8218041DF5FA");
  }
}

updatedomscores() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8E770EE8732E97B0FFEAB521FF3B581B");
  var_0 = undefined;
  var_1 = undefined;

  while(!level.gameended) {
    wait 5.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(level.scoretick))
      level.scoretick = [];

    foreach(var_3 in level.teamnamelist)
    level.scoretick[var_3] = 0;

    if(isDefined(level.btmflagobject)) {
      var_5 = level.btmflagobject scripts\mp\gameobjects::getownerteam();

      if(var_5 == "_encstr_A7A408B9CA5D1D4E2C63") {
        continue;
      }
      level.scoretick[var_5] = level.scoretick[var_5] + level.pointsperflag;
      updatescores();
    }
  }
}

updatescores() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2] + level.scoretick[var_2];

    if(var_3 >= level.roundscorelimit)
      var_0[var_0.size] = var_2;
  }

  if(var_0.size == 1)
    level.scoretick[var_0[0]] = level.roundscorelimit - game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0[0]];

  foreach(var_2 in level.teamnamelist) {
    if(level.scoretick[var_2] > 0)
      scripts\mp\gamescore::giveteamscoreforobjective(var_2, level.scoretick[var_2], 1);
  }
}

removedompoint(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  level.btmflagobject scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  level.btmflagobject scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.btmflagobject scripts\mp\gameobjects::releaseid();
  level.btmflagobject.trigger = undefined;
  level.btmflagobject notify("_encstr_8BE208E31FA8E1631D65");
  level.btmflagobject.visibleteam = "_encstr_8BBA05185F8B99";
  level.btmflagobject.scriptable delete();
  level.btmflagobject.flagmodel delete();
}

pickflagtospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3.dist = 0;

    if(var_3.team == "_encstr_9A8507BA4040188D08") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level.primaryflags.size == 0)
      level.primaryflags = level.primaryflags2;

    for(var_5 = level.primaryflags[randomint(level.primaryflags.size)]; isDefined(level.prevflag) && var_5 == level.prevflag; var_5 = level.primaryflags[randomint(level.primaryflags.size)]) {}

    level.prevflag2 = level.prevflag;
    level.prevflag = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_0.size; var_7++) {
      var_8 = distancesquared(var_0[var_6].origin, var_0[var_7].origin);
      var_0[var_6].dist = var_0[var_6].dist + var_8;
      var_0[var_7].dist = var_0[var_7].dist + var_8;
    }
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6].dist = var_1[var_6].dist + var_8;
      var_1[var_7].dist = var_1[var_7].dist + var_8;
    }
  }

  var_9 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["_encstr_9A8507BA4040188D08"] = var_9.origin;
  var_9 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["_encstr_8E8405EA382B2A"] = var_1[0].origin;
  var_15 = undefined;
  var_16 = undefined;

  for(var_6 = 0; var_6 < level.primaryflags.size; var_6++) {
    var_5 = level.primaryflags[var_6];
    var_17 = abs(distance(var_5.origin, var_12["_encstr_9A8507BA4040188D08"]) - distance(var_5.origin, var_12["_encstr_8E8405EA382B2A"]));

    if(isDefined(level.prevflag) && var_5 == level.prevflag) {
      continue;
    }
    if(isDefined(level.prevflag2) && var_5 == level.prevflag2) {
      if(level.primaryflags.size > 2)
        continue;
      else
        var_17 = var_17 + 512;
    }

    if(!isDefined(var_16) || var_17 < var_16) {
      var_16 = var_17;
      var_15 = var_5;
    }
  }

  level.prevflag2 = level.prevflag;
  level.prevflag = var_15;
  return var_15;
}

hqmainloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.hqrevealtime = -100000;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    level waittill("_encstr_AC270D7FE8CE28B8F7A2F3D899C3EF");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", 0);
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", -1);
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B67B0A122C279107DBB49BA3", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    var_0 = pickradiotospawn();
    var_0 makeradioactive();
    scripts\mp\utility\sound::playsoundonplayers("_encstr_B1B30F5BD979A0176B69FBA0C2EF5E68CA");
    var_1 = var_0.gameobject;
    var_1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_1 scripts\mp\gameobjects::setmodelvisibility(1);
    var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked, level.iconlocked);
    level.radioobject = var_1;
    level.hqrevealtime = gettime();

    if(level.zoneactivationdelay) {
      setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(30000 + gettime()));
      setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 2);
      wait(level.zoneactivationdelay);
    }

    waittillframeend;
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

    foreach(var_3 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("_encstr_A6C30C07ABABC19F9B3FC5A3936D", var_3);

      if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_A6BA1650D56251C07370CB57C770ED19837CBF52AB01649B", var_3, 4);
    }

    var_1 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    var_1 scripts\mp\gameobjects::setusetime(level.zonecapturetime);
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_1.onuse = ::onradiocapture;
    var_1.onbeginuse = ::onbeginuse;
    var_1.onenduse = ::onenduse;
    var_1.onuncontested = ::onuncontested;
    var_1.oncontested = ::oncontested;
    var_1.id = "_encstr_B67B0A1A2C279107DBB49BA3";
    var_1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_1 scripts\mp\gameobjects::setcapturebehavior("_encstr_820E07FAE8780B3A4C");
    level.radioobject = var_1;
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(60000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    thread destroyhqaftertime(60);
    var_5 = level scripts\engine\utility::_id_143AD("_encstr_86280C0D6AEFDB473BA8E03B45E9", "_encstr_A7B30DE9FFC90D683B531BB0381558");

    if(var_5 == "_encstr_86280C0D6AEFDB473BA8E03B45E9") {
      var_6 = var_1 scripts\mp\gameobjects::getownerteam();
      var_7 = scripts\mp\utility\game::getotherteam(var_6);

      if(level.hqautodestroytime)
        thread destroyhqaftertime(level.hqautodestroytime, var_6);
      else
        level.hqdestroyedbytimer = 0;

      for(;;) {
        var_6 = var_1 scripts\mp\gameobjects::getownerteam();
        var_7 = scripts\mp\utility\game::getotherteam(var_6);

        if(var_6 == "_encstr_9A8507BA4040188D08") {} else {}

        var_1 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
        var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);

        if(!level.kothmode)
          var_1 scripts\mp\gameobjects::setusetext(&"_encstr_96881153287D22A84DA2A49E95A4C9747D4245");

        var_1.onuse = ::onradiodestroy;
        level waittill("_encstr_A7B30DE9FFC90D683B531BB0381558");

        if(!level.kothmode || level.hqdestroyedbytimer) {
          break;
        }

        thread forcespawnteam(var_6);
        var_1 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_6)[0]);
      }
    }

    scripts\mp\utility\sound::playsoundonplayers("_encstr_A79A1869C2293FF9A2B7E8C827C5B22FD26DD3E11CD2E3839D73");

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
        scripts\mp\utility\print::teamhudtutorialmessage("_encstr_8F2416D996DC732B758C41CF39773999D1C7163D513B31FD", var_3, 4);
    }

    var_6 = var_1 scripts\mp\gameobjects::getownerteam();
    var_1 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var_1 scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    var_1 scripts\mp\gameobjects::setmodelvisibility(0);
    var_0 makeradioinactive();
    level.radioobject = undefined;

    if(var_6 != "_encstr_A7A408B9CA5D1D4E2C63")
      thread forcespawnteam(var_6, level.extradelay);

    level.usedomflag++;

    if(level.usedomflag == 3)
      level.usedomflag = 0;

    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    wait 1;
    level getnextobjective("_encstr_BDD705AD7BD143");
  }
}

forcespawnteam(var_0, var_1) {
  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(isalive(var_3)) {
        continue;
      }
      if(var_3.pers["_encstr_8AEF05472BC2D6"] == var_0)
        var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_1 * 1000));
    }

    wait(var_1);
  }

  foreach(var_3 in level.players) {
    if(var_3.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

      if(!isalive(var_3))
        var_3.forcespawnnearteammates = 1;

      var_3 notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
    }
  }
}

onbeginuse(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
}

onenduse(var_0, var_1, var_2) {
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_2) {
    return;
  }
  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
  else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);
    return;
  }
}

oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcontested);
}

onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcapture, level.iconhqdefend);
}

onradiocapture(var_0) {
  var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];
  scripts\mp\gamescore::giveplayerscore("_encstr_95EB0866891B23FB85B3", var_0);

  foreach(var_3 in self.touchlist[var_1]) {
    var_4 = var_3.player;
    var_4 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_4 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);
  }

  var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_0.origin);
  var_6 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var_1);

  if(!level.kothmode)
    scripts\mp\gameobjects::setusetime(level.zonecapturetime);

  var_7 = "_encstr_8E8405EA382B2A";

  if(var_1 == "_encstr_8E8405EA382B2A")
    var_7 = "_encstr_9A8507BA4040188D08";

  thread scripts\mp\utility\sound::playsoundonplayers("_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", var_1);
  thread scripts\mp\utility\sound::playsoundonplayers("_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_7);
  level thread awardhqpoints(var_1);
  var_0 notify("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_B1CF098D5838A3D5C95623");
  level notify("_encstr_86280C0D6AEFDB473BA8E03B45E9");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1, 17, 16);
}

onradiodestroy(var_0) {
  var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];
  var_2 = "_encstr_8E8405EA382B2A";

  if(var_1 == "_encstr_8E8405EA382B2A")
    var_2 = "_encstr_9A8507BA4040188D08";

  scripts\mp\gamescore::giveplayerscore("_encstr_95EB0866891B23FB85B3", var_0);

  foreach(var_4 in self.touchlist[var_1]) {
    var_5 = var_4.player;
    var_5 scripts\mp\utility\stats::incpersstat("_encstr_8B460D8A6176034A70279C992770D2", 1);
    var_5 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B460D8A6176034A70279C992770D2", var_0.pers["_encstr_8B460D8A6176034A70279C992770D2"]);
  }

  var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_AFCB082AC1D6A3EA7B73", var_0.origin);

  if(level.kothmode) {} else {}

  thread scripts\mp\utility\sound::playsoundonplayers("_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", var_1);
  thread scripts\mp\utility\sound::playsoundonplayers("_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_2);
  level notify("_encstr_A7B30DE9FFC90D683B531BB0381558");

  if(level.kothmode)
    level thread awardhqpoints(var_1);
  else
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 20);
}

destroyhqaftertime(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BD6009F0EB87CED8328D09");
  level notify("_encstr_9A7111F8376643DF67503399C08B15D7D89D6C");
  level endon("_encstr_9A7111F8376643DF67503399C08B15D7D89D6C");
  level.hqdestroytime = gettime() + var_0 * 1000;
  level.hqdestroyedbytimer = 0;
  wait(var_0);
  level.hqdestroyedbytimer = 1;

  if(isDefined(var_1))
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 5);

  level notify("_encstr_A7B30DE9FFC90D683B531BB0381558");
}

awardhqpoints(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A7B30DE9FFC90D683B531BB0381558");
  level notify("_encstr_93A1151F4061F67F0189C1222D15D3FF4205405874C8A7");
  level endon("_encstr_93A1151F4061F67F0189C1222D15D3FF4205405874C8A7");
  var_1 = 12;
  var_2 = 5;
  var_3 = 5;
  var_4 = 5;

  if(level.promode)
    var_5 = int(level.hqautodestroytime / var_1);
  else
    var_5 = 5;

  var_6 = 0;

  while(!level.gameended) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, 15);
    var_6++;
    wait(var_5);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

makeradioactive() {
  self.gameobject scripts\mp\gameobjects::setmodelvisibility(0);
  self.gameobject scripts\mp\gameobjects::cancontestclaim(1);
  self.gameobject scripts\mp\gameobjects::enableobject();
  self.gameobject.ignorestomp = 1;
  self.trig.useobj = self.gameobject;
}

makeradioinactive() {
  self.gameobject scripts\mp\gameobjects::releaseid();
  self.gameobject scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  self.gameobject scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  level.radios = scripts\engine\utility::array_remove(level.radios, self);
}

pickradiotospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3.dist = 0;

    if(var_3.team == "_encstr_9A8507BA4040188D08") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level.radios.size == 0)
      level.radios = level.radios2;

    for(var_5 = level.radios[randomint(level.radios.size)]; isDefined(level.prevradio) && var_5 == level.prevradio; var_5 = level.radios[randomint(level.radios.size)]) {}

    level.prevradio2 = level.prevradio;
    level.prevradio = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_0.size; var_7++) {
      var_8 = distancesquared(var_0[var_6].origin, var_0[var_7].origin);
      var_0[var_6].dist = var_0[var_6].dist + var_8;
      var_0[var_7].dist = var_0[var_7].dist + var_8;
    }
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6].dist = var_1[var_6].dist + var_8;
      var_1[var_7].dist = var_1[var_7].dist + var_8;
    }
  }

  var_9 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["_encstr_9A8507BA4040188D08"] = var_9.origin;
  var_9 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["_encstr_8E8405EA382B2A"] = var_1[0].origin;
  var_15 = undefined;
  var_16 = undefined;

  for(var_6 = 0; var_6 < level.radios.size; var_6++) {
    var_5 = level.radios[var_6];
    var_17 = abs(distance(var_5.origin, var_12["_encstr_9A8507BA4040188D08"]) - distance(var_5.origin, var_12["_encstr_8E8405EA382B2A"]));

    if(isDefined(level.prevradio) && var_5 == level.prevradio) {
      continue;
    }
    if(isDefined(level.prevradio2) && var_5 == level.prevradio2) {
      if(level.radios.size > 2)
        continue;
      else
        var_17 = var_17 + 512;
    }

    if(!isDefined(var_16) || var_17 < var_16) {
      var_16 = var_17;
      var_15 = var_5;
    }
  }

  level.prevradio2 = level.prevradio;
  level.prevradio = var_15;
  return var_15;
}

updaterespawntimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level endon("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
  var_0 = gettime();

  if(level.zoneduration > 0)
    var_1 = var_0 + level.zoneduration * 1000;
  else
    var_1 = var_0 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();

  var_2 = var_0;

  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = (var_1 - var_2) / 1000;
    waitframe();
  }
}

onteamscore(var_0, var_1, var_2) {}

waittospawnvip() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_87770ECDE0C2EECDBE13D15B7D3B5A38");
  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", 0);
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", -1);
  level.spawnedvip = 1;
  level.hostagespawnpos = pickviptospawn();
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.onteamscore = undefined;
  level.hostagecarrystates = [];
  level.hostages[0] = scripts\mp\tac_ops\hostage_utility::spawnhostage(level.hostagespawnpos, "_encstr_A7A408B9CA5D1D4E2C63");
  level thread spawnextractzones();
  scripts\mp\utility\sound::playsoundonplayers("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("_encstr_A6C30C07ABABC19F9B3FC5A3936D", var_1);

    if(scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
      scripts\mp\utility\print::teamhudtutorialmessage("_encstr_9B78173DCE65A0BB7749530781C07328E97D33E22527C989DF", var_1, 4);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 10, 10);
}

spawnextractzones() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.vipextractzones = [];
  var_0 = getextractionbtmflag();
  var_1 = getextractionbtmflag(var_0);
  setupextractgoal(var_0, "_encstr_9A8507BA4040188D08");
  setupextractgoal(var_1, "_encstr_8E8405EA382B2A");
}

getextractionbtmflag(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1000000;

  foreach(var_5 in level.primaryflags2) {
    var_6 = scripts\engine\utility::distance_2d_squared(level.hostagespawnpos, var_5.origin);

    if(isDefined(var_0)) {
      if(var_6 > var_3 && var_0 != var_5.origin)
        var_2 = var_5;

      continue;
    }

    if(var_6 > 1000000)
      var_2 = var_5;
  }

  return var_2.origin;
}

setupextractgoal(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = (0, 270, 0);
  var_2.team = var_1;
  var_2.ownerteam = var_1;
  var_2.curorigin = var_0;
  var_2.offset3d = (0, 0, 32);
  var_2.compassicons = [];
  var_2.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_2 setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  var_2 setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_8419044EB232");
  var_2 playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 120, 128);
  var_2 scripts\mp\gameobjects::requestid(1, 1);
  var_2 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  var_3.goalent = var_2;
  var_3 thread goaltriggerwatcher();
  level.vipextractzones[var_1] = var_3;
  waitframe();
  playFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

goaltriggerwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(level.hostagecarrier) && var_0 == level.hostagecarrier && var_0.team == self.goalent.team) {
      scripts\mp\tac_ops\hostage_utility::drophostage(var_0, level.hostages[0], var_0.origin);
      level.hostages[0].trigger makeunusable();
      level.hostages[0] makeunusable();
      level.hostages[0].useobj unlink();
      level.hostages[0].useobj makeunusable();
      level.hostages[0].trackedobject scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      level.hostages[0].trackedobject scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
      level.hostages[0].trackedobject scripts\mp\gameobjects::releaseid();
      level.hostages[0] notify("_encstr_AC7C1348F71DC1B742C4E5FE5BC9F989749F58C04B");
      level.hostages[0] delete();
      self.goalent scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
      self.goalent scripts\mp\gameobjects::releaseid();
      scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 200, 0);
      level notify("_encstr_8D7E0B0B520310206EDF4D6BFC");
      level.spawnedvip = 0;
      self.chopper thread _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::littlebirdleave();
      playannouncerbattlechatter(self.chopper.team, "_encstr_925F2662F0D9B2AF4925477CB37323FD13D82A8BB8376DF7610C49665C3E3F494DF0D2727029A57F", 10);

      foreach(var_2 in level.vipextractzones) {
        stopFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], var_2.goalent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_2.goalent stoploopsound();
        var_2.goalent delete();
        var_2.goalent = undefined;
        var_2 delete();
      }

      thread scripts\mp\utility\sound::playsoundonplayers("_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", var_0.team);
      thread scripts\mp\utility\sound::playsoundonplayers("_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", scripts\mp\utility\game::getotherteam(var_0.team)[0]);

      foreach(var_5 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_5, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
          scripts\mp\utility\print::teamhudtutorialmessage("_encstr_827918A748A48A34A89459A2D4BC6525057DA10AA0155525A288", var_5, 4);
      }

      level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
      break;
    }

    waitframe();
  }

  level.objectiveselector.objectivetypes[2] = "_encstr_8A18059BF07BBA";
  level getnextobjective("_encstr_951904D8F1E0");
}

summonextractchopper(var_0) {
  if(!isDefined(var_0.chopper)) {
    var_1 = _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::spawnextractchopper(var_0, var_0.origin);
    var_1.invulnerable = 1;
    var_0.chopper = var_1;
    self iprintlnbold("_encstr_B8B61C2AF0E84E2CC6A35AB7DC806CDE073A594E02ACB90193DBEA47AC84");
    var_1.extractzone = var_0;
    var_1.extractteam = self.team;
    var_0.curorigin = var_0.origin;
    var_0.offset3d = (0, 0, 30);
    var_0 thread extracttriggerwatcher(var_1);
  }
}

extracttriggerwatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_BAFC0789BA3BD35DA3");
  var_0 waittill("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
  self.extractionactive = 1;
  playannouncerbattlechatter(var_0.extractteam, "_encstr_8E2D245AC8E19A8791CDAF846B5B1BA57BB002A350DF968BC8B69DBF77460BEA8B10FABAB84B", 10);
}

playannouncerbattlechatter(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = "_encstr_8EE40543DB3BD1";
  var_4 = "_encstr_816908616B9751608687" + var_3 + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + var_2;

  if(soundexists(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0)
        var_6 queuedialogforplayer(var_4, var_1, 2);
    }
  }
}

pickviptospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3.dist = 0;

    if(var_3.team == "_encstr_9A8507BA4040188D08") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = level.primaryflags2;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level.prevspawnpos) && var_6 == level.prevspawnpos; var_6 = var_5[randomint(var_5.size)]) {}

    level.prevspawnpos2 = level.prevspawnpos;
    level.prevspawnpos = var_6;
    return var_6.origin;
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_0.size; var_8++) {
      var_9 = distancesquared(var_0[var_7].origin, var_0[var_8].origin);
      var_0[var_7].dist = var_0[var_7].dist + var_9;
      var_0[var_8].dist = var_0[var_8].dist + var_9;
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7].dist = var_1[var_7].dist + var_9;
      var_1[var_8].dist = var_1[var_8].dist + var_9;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3.dist < var_10.dist)
      var_10 = var_3;
  }

  var_13["_encstr_9A8507BA4040188D08"] = var_10.origin;
  var_10 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3.dist < var_10.dist)
      var_10 = var_3;
  }

  var_13["_encstr_8E8405EA382B2A"] = var_1[0].origin;
  var_16 = undefined;
  var_17 = undefined;

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6 = var_5[var_7];
    var_18 = abs(distance(var_6.origin, var_13["_encstr_9A8507BA4040188D08"]) - distance(var_6.origin, var_13["_encstr_8E8405EA382B2A"]));

    if(isDefined(level.prevspawnpos) && var_6 == level.prevspawnpos) {
      continue;
    }
    if(isDefined(level.prevspawnpos2) && var_6 == level.prevspawnpos2) {
      if(var_5.size > 2)
        continue;
      else
        var_18 = var_18 + 512;
    }

    if(!isDefined(var_17) || var_18 < var_17) {
      var_17 = var_18;
      var_16 = var_6;
    }
  }

  level.prevspawnpos2 = level.prevspawnpos;
  level.prevspawnpos = var_16;
  return var_16.origin;
}

waittospawnjuggcrate() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_96120F8BB30F1F5D3115AC8D57A0A397A4");
  level.spawnedjugg = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\utility\sound::playsoundonplayers("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("_encstr_A6C30C07ABABC19F9B3FC5A3936D", var_1);

    if(scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8") > 0)
      scripts\mp\utility\print::teamhudtutorialmessage("_encstr_9A47185924B4A345637114E503E60DF36AC93139E819755F1767", var_1, 4);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 19, 19);
  level.spawnedjugg = 1;
  level.juggcratespawnpos = pickviptospawn();
  initjugg();
  level.btmjuggcrate = createjuggcrate(level.juggcratespawnpos, (0, 0, 0));
  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(30000 + gettime()));
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 2);
  wait 30;
  level.btmjuggcrate thread juggcratemanageuse();
  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", 0);
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", -1);
  objective_icon(level.juggcrateobjid, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
}

createjuggcrate(var_0, var_1) {
  var_2 = getgroundposition(var_0, 32);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2 + (0, 0, 40));
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3.cratemodel = var_4;
  var_3.cratemodel.angles = var_1;
  var_3.cratemodel setModel("_encstr_BD78271950415B156ABA63362640691C635FA04FE33B6701705BC3FF87496040306FA28A5962BBFCD7");
  var_3.crateid = var_3 getentitynumber();
  createjuggcrateobjective(var_3);
  return var_3;
}

juggcratemanageuse() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self setuserange(120);
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(&"_encstr_9B41183541D7A67A882AEB25558E90AC79349228A22AD755A615");
  self setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  self makeusable();
  self.inuse = 0;
  thread juggcratewatchuseprogress();
  thread juggcratewatchusecompleted();
  thread juggcratewatchstopuseprogress();
}

juggcrateused(var_0) {
  activatenewjuggernaut(var_0);
  juggcratecleanup();
  level notify("_encstr_A5460CC460B78F019829D70DC75B");
  level.objectiveselector.objectivetypes[3] = "_encstr_8A18059BF07BBA";
  level getnextobjective("_encstr_AFDD05A6AB763B");
  self.cratemodel delete();
  self delete();
}

juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objid);
}

juggcratewatchusecompleted() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    juggcrateused(var_0);
    return;
  }
}

juggcratewatchuseprogress() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_0);
    self.usingplayer = var_0;
    self.inuse = 1;
    self.lastusetime = gettime();
  }
}

juggcratewatchstopuseprogress() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.inuse;
  var_1 = self.usingplayer;

  for(;;) {
    wait 0.2;

    if(self.inuse) {
      if(self.lastusetime < gettime() - 200.0) {
        self.inuse = 0;
        self.usingplayer = undefined;
        self.lastusetime = undefined;
        continue;
      }

      var_2 = isDefined(var_1) && isDefined(self.usingplayer) && var_1 != self.usingplayer;

      if(!var_0 || var_2)
        updatejuggcrateobjectivestate(self);
    } else if(var_0)
      updatejuggcrateobjectivestate(self);

    var_0 = self.inuse;
    var_1 = self.usingplayer;
  }
}

createjuggcrateobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  level.juggcrateobjid = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_2, level.iconlocked);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);
  objective_setneutrallabel(var_1, "_encstr_A2CA1C6A14BEA99E2215F594AA7412ACCB0D258215A2F5D00541A2AA292A");
  objective_setfriendlylabel(var_1, "_encstr_8E441E350ABE53A788547D25553A90B279D0A4508A54AF0D82A02A55259493A3");
  objective_setenemylabel(var_1, "_encstr_96F51B31C8E7343FB7F84929911F5DCE4E4326BF6457BEF1ADA1E1B1A8");
  updatejuggcrateobjectivestate(var_0);
}

updatejuggcrateobjectivestate(var_0) {
  var_1 = var_0.objid;
  var_2 = istrue(var_0.inuse);

  if(var_2) {
    objective_setownerteam(var_1, var_0.usingplayer.team);
    objective_sethot(var_1, 1);
  } else {
    objective_setownerteam(var_1, undefined);
    objective_sethot(var_1, 0);
  }
}

activatenewjuggernaut(var_0) {
  var_1 = level.btm;
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_3 = var_0 getentitynumber();
  var_2.id = var_3;
  var_1.activejuggernauts[var_3] = var_0;
  var_0.btmjugginfo = var_2;
  setupplayerasjugg(var_0);
  createjuggobjective(var_0, var_2);
}

setupplayerasjugg(var_0) {
  var_1 = level.btm.juggconfig;
  var_0 scripts\mp\juggernaut::jugg_makejuggernaut(var_1);
  var_0 givemaxammo(var_0.classstruct.loadoutprimaryobject);
  var_0 givemaxammo(var_0.classstruct.loadoutsecondaryobject);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_3 = var_2[0];
  var_0.isjuggernaut = 1;
}

createjuggobjective(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_1.juggobjid = var_2;
  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_AF5A081BBAC993AC73A3", var_0.origin, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_2, 90);
  objective_setownerteam(var_2, var_0.team);
  objective_setfriendlylabel(var_2, "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA");
  objective_setenemylabel(var_2, "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E");
}

initjugg() {
  var_0 = scripts\mp\juggernaut::jugg_createconfig();
  level.btm.juggconfig = var_0;
  var_1 = getjuggmaxhealth();
  var_0.maxhealth = var_1;
  var_0.startinghealth = var_1;
  var_0.suit = "_encstr_926B184F5F2B194DB3F9E7554EC55B45C3EFEA77C71A183ACEE9";
  var_0.allows["_encstr_B13D076BED70539F23"] = 0;
  var_0.allows["_encstr_92100762872552A643"] = 0;
  var_0.allows["_encstr_9BE40A0BC09BCEF7C0F33441"] = 0;
  var_0.allows["_encstr_A60F0E030703D180A0665F43BA558F28"] = undefined;
  var_0.classstruct.loadoutprimary = "_encstr_BD060D9B3F48B9098FC1A169DAA7B4";
  var_0.classstruct.loadoutprimaryattachments = ["_encstr_BACC05C9770D68"];
  var_0.classstruct.loadoutsecondary = "_encstr_88FE0D0157202970845121C58E802F";
}

cleanupobjectiveiconsforjugg(var_0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0.btmjugginfo.juggobjid);
}

getjuggmaxhealth() {
  return getdvarint("_encstr_A7D113127E3521BA5388975B50E97798E3875D4B53");
}

waittospawnbtmbombs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level waittill("_encstr_99270D0B7A09D05881F36953EFDA95");
  level.bombexploded = 0;
  level.multibomb = 1;
  level.bombsplanted = 0;
  level.bombtimer = 45;
  level.defusetime = 5;
  level.planttime = 5;
  level.bombzones = [];
  level.aplanted = 0;
  level.bplanted = 0;
  level thread applybombstoplayers();
  var_0 = getfirstbtmbombloc();
  var_1 = getsecondbtmbombloc(var_0);
  var_0 = getgroundposition(var_0.origin, 64);
  var_1 = getgroundposition(var_1.origin, 64);
  level.resetprogress = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  var_2 = getEntArray("_encstr_979A09DA67D0262B70CD82", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = _encstr_8E601C3798D3B367DBE3C668A37F02A393ED8CEBA218B780ABDB35AC073A::removebombzonec(var_2);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = getEntArray(var_2[var_3].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_3 == 0) {
      var_2[var_3] = modifybombzonecollision(var_4, var_2[var_3], var_0);
      var_2[var_3].origin = var_0;
      var_4[0].origin = var_0;
    } else {
      var_2[var_3] = modifybombzonecollision(var_4, var_2[var_3], var_1);
      var_2[var_3].origin = var_1;
      var_4[0].origin = var_1;
    }

    var_5 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_2[var_3], var_4, (0, 0, 64));
    var_5 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_6 = var_2[var_3].script_label;

    if(isDefined(var_2[var_3].objectivekey))
      var_5.objectivekey = var_2[var_3].objectivekey;
    else
      var_5.objectivekey = var_5 scripts\mp\gameobjects::getlabel();

    if(isDefined(var_2[var_3].iconname))
      var_5.iconname = var_2[var_3].iconname;
    else
      var_5.iconname = var_5 scripts\mp\gameobjects::getlabel();

    var_5.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
    var_5.trigger setusepriority(-3);
    var_5 scripts\mp\gameobjects::setusetime(level.planttime);
    var_5 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    var_5 scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");

    if(var_5.objectivekey == "_encstr_B6070359BA") {
      var_5.objectivekey = "_encstr_B20703DFCF";
      var_5.iconname = "_encstr_B20703DFCF";
    }

    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_5.onbeginuse = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onbeginuse;
    var_5.onenduse = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onenduse;
    var_5.onuse = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onuseplantobject;
    var_5.oncantuse = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_oncantuse;
    var_5.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
    var_5.bombplanted = 0;
    var_5.bombexploded = undefined;
    var_5.resetprogress = level.resetprogress;

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      if(isDefined(var_4[var_7].script_exploder)) {
        var_5.exploderindex = var_4[var_7].script_exploder;
        var_4[var_7] thread _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupkillcament(var_5);
        break;
      }
    }

    var_5.bombdefusetrig = getEnt(var_4[0].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5.bombdefusetrig.origin = var_5.bombdefusetrig.origin + (0, 0, -10000);
    var_5.bombdefusetrig.label = var_6;
    var_5.noweapondropallowedtrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5.trigger.origin, 0, 140, 100);
    level.objectives[var_5.objectivekey] = var_5;
    level.bombzones[level.bombzones.size] = var_5;
  }

  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(30000 + gettime()));
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 2);
  wait 30;

  foreach(var_5 in level.bombzones) {
    var_5 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
  }

  setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", 0);
  setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", -1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 20, 20);
}

applybombstoplayers() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
      var_1.isplanting = 0;
      var_1.isdefusing = 0;
      var_1.isbombcarrier = 1;
    }
  }
}

resetbombzone() {
  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
  self.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");
  self.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
  self.bombexploded = undefined;
  self.bombplanted = 0;
}

bombhandler(var_0, var_1, var_2) {
  level.bombsplanted = level.bombsplanted - 1;

  if(self.objectivekey == "_encstr_B20703DFCF")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }
  if(var_1 == "_encstr_860808CB78E2984063BA") {
    self.bombexploded = 1;
    self.bombplanted = 0;
    scripts\mp\gameobjects::releaseid();
    scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 100);

    if(level.bombexploded > 1) {
      level.objectiveselector.objectivetypes[4] = "_encstr_8A18059BF07BBA";
      level getnextobjective("_encstr_B60703EACA");
    }
  } else {
    var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + self.objectivekey);
    self notify("_encstr_9A7B088CCA335D37CA91");
    resetbombzone();
  }
}

getsecondbtmbombloc(var_0) {
  var_1 = 1000000;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!isalive(var_5)) {
      continue;
    }
    var_5.dist = 0;

    if(var_5.team == "_encstr_9A8507BA4040188D08") {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  var_7 = level.primaryflags2;

  if(!var_2.size || !var_3.size) {
    for(var_8 = var_7[randomint(var_7.size)]; isDefined(level.prevbomb) && var_8 == level.prevbomb; var_8 = var_7[randomint(var_7.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var_8;
    return var_8;
  }

  for(var_9 = 0; var_9 < var_2.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_2.size; var_10++) {
      var_11 = distancesquared(var_2[var_9].origin, var_2[var_10].origin);
      var_2[var_9].dist = var_2[var_9].dist + var_11;
      var_2[var_10].dist = var_2[var_10].dist + var_11;
    }
  }

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_3.size; var_10++) {
      var_11 = distancesquared(var_3[var_9].origin, var_3[var_10].origin);
      var_3[var_9].dist = var_3[var_9].dist + var_11;
      var_3[var_10].dist = var_3[var_10].dist + var_11;
    }
  }

  var_12 = var_2[0];

  foreach(var_5 in var_2) {
    if(var_5.dist < var_12.dist)
      var_12 = var_5;
  }

  var_15["_encstr_9A8507BA4040188D08"] = var_12.origin;
  var_12 = var_3[0];

  foreach(var_5 in var_3) {
    if(var_5.dist < var_12.dist)
      var_12 = var_5;
  }

  var_15["_encstr_8E8405EA382B2A"] = var_3[0].origin;
  var_18 = undefined;
  var_19 = undefined;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_8 = var_7[var_9];
    var_20 = abs(distance(var_8.origin, var_15["_encstr_9A8507BA4040188D08"]) - distance(var_8.origin, var_15["_encstr_8E8405EA382B2A"]));

    if(isDefined(level.prevbomb) && var_8 == level.prevbomb) {
      continue;
    }
    if(isDefined(level.prevbomb2) && var_8 == level.prevbomb2) {
      if(var_7.size > 2)
        continue;
      else
        var_20 = var_20 + 512;
    }

    var_11 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_8.origin);

    if(isDefined(var_0)) {
      if(var_11 > var_1 && var_0.origin != var_8.origin)
        var_18 = var_8;
    } else if(var_11 > 1000000)
      var_18 = var_8;

    if(!isDefined(var_19) || var_20 < var_19) {
      var_19 = var_20;
      var_18 = var_8;
    }
  }

  level.prevbomb2 = level.prevbomb;
  level.prevbomb = var_18;
  return var_18;
}

getfirstbtmbombloc() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3.dist = 0;

    if(var_3.team == "_encstr_9A8507BA4040188D08") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = level.primaryflags2;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level.prevbomb) && var_6 == level.prevbomb; var_6 = var_5[randomint(var_5.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var_6;
    return var_6;
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_0.size; var_8++) {
      var_9 = distancesquared(var_0[var_7].origin, var_0[var_8].origin);
      var_0[var_7].dist = var_0[var_7].dist + var_9;
      var_0[var_8].dist = var_0[var_8].dist + var_9;
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7].dist = var_1[var_7].dist + var_9;
      var_1[var_8].dist = var_1[var_8].dist + var_9;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3.dist < var_10.dist)
      var_10 = var_3;
  }

  var_13["_encstr_9A8507BA4040188D08"] = var_10.origin;
  var_10 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3.dist < var_10.dist)
      var_10 = var_3;
  }

  var_13["_encstr_8E8405EA382B2A"] = var_1[0].origin;
  var_16 = undefined;
  var_17 = undefined;

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6 = var_5[var_7];
    var_18 = abs(distance(var_6.origin, var_13["_encstr_9A8507BA4040188D08"]) - distance(var_6.origin, var_13["_encstr_8E8405EA382B2A"]));

    if(isDefined(level.prevbomb) && var_6 == level.prevbomb) {
      continue;
    }
    if(isDefined(level.prevbomb2) && var_6 == level.prevbomb2) {
      if(var_5.size > 2)
        continue;
      else
        var_18 = var_18 + 512;
    }

    if(!isDefined(var_17) || var_18 < var_17) {
      var_17 = var_18;
      var_16 = var_6;
    }
  }

  level.prevbomb2 = level.prevbomb;
  level.prevbomb = var_16;
  return var_16;
}

modifybombzonecollision(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = modifiedbombzones(var_1, var_3, var_0, var_2);
  return var_4;
}

modifiedbombzones(var_0, var_1, var_2, var_3) {
  var_2[0].origin = var_3;
  var_2[0].angles = (0, 0, 0);
  var_0.origin = var_3;
  var_0.angles = (0, 0, 0);
  setmodifiedbombzonescollision((0, 0, 35), (0, 0, 0), var_1, var_2);
  setexplodermodel(var_1, var_2);
  return var_0;
}

setmodifiedbombzonescollision(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_gameobjectname) && var_6.script_gameobjectname == "_encstr_979A09DA67D0262B70CD82") {
      if(distance(var_6.origin, var_2) < 100) {
        var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3[0].origin + var_0);
        var_7.angles = var_1;
        var_7 clonebrushmodeltoscriptmodel(var_6);
        var_7 disconnectPaths();
        var_6 delete();
        break;
      }
    }
  }
}

setexplodermodel(var_0, var_1) {
  var_2 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3].script_exploder)) {
      if(isDefined(var_2[var_3].targetname) && var_2[var_3].targetname == "_encstr_A63B09CA3CE01B7B8C2B27" && distance(var_2[var_3].origin, var_0) < 100) {
        var_2[var_3].origin = var_1[0].origin;
        var_2[var_3].angles = var_1[0].angles;
      }
    }
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else if(isDefined(level.radioobject)) {
    var_1 = removespawnsinactivehq(level.radioobject.spawnpoints);
    var_3 = removespawnsinactivehq(level.radioobject.fallbackspawnpoints);
    var_4 = getobjzonedeadzonedist();
    var_5 = [];
    var_5["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"] = level.radioobject.visuals[0] getentitynumber();
    var_5["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"] = level.radioobject.visuals[0].furthestspawndistsq;
    var_5["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"] = var_4 * var_4;
    var_5["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"] = level.enemy_spawn_influence_dist_sq;
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.radioobject.visuals[0].spawnset, level.radioobject.visuals[0].fallbackspawnset, undefined, var_5);
  } else if(isDefined(level.btmflagobject)) {
    var_1 = removespawnsinactiveflag(level.btmflagobject.trigger.spawnpoints);
    var_3 = removespawnsinactiveflag(level.btmflagobject.trigger.fallbackspawnpoints);
    var_4 = getobjzonedeadzonedist();
    var_5 = [];
    var_5["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"] = level.btmflagobject.trigger getentitynumber();
    var_5["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"] = level.btmflagobject.trigger.furthestspawndistsq;
    var_5["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"] = var_4 * var_4;
    var_5["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"] = level.enemy_spawn_influence_dist_sq;
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.btmflagobject.trigger.spawnset, level.btmflagobject.trigger.fallbackspawnset, undefined, var_5);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

removespawnsinactivehq(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.radioobject.trigger))
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

removespawnsinactiveflag(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.btmflagobject.trigger))
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }
    var_2 notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
    wait 0.1;
  }
}

onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.forcespawnnearteammates = undefined;
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", -1);
  thread updatematchstatushintonspawn();

  if(istrue(level.multibomb)) {
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  }
}

movezoneaftertime(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_A6940FED853B0E2535D3E028F988FFE0AF");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(isDefined(level.radioobject)) {
    var_10 = level.radioobject.ownerteam;

    if(!isDefined(var_10)) {
      return;
    }
    if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
      return;
    }
    var_11 = self;
    var_12 = 0;
    var_13 = var_1.team;

    if(level.zonecapturetime > 0 && var_1 istouching(level.radioobject.trigger)) {
      if(var_10 != var_13)
        var_12 = 1;
    }

    if(var_13 != var_10) {
      if(var_11 istouching(level.radioobject.trigger)) {
        if(var_12)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");

        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        thread scripts\common\utility::_id_13E0A(level._id_11B24._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
      }
    } else if(var_1 istouching(level.radioobject.trigger)) {
      if(var_12)
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");

      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
    }
  }

  if(istrue(level.spawnedjugg)) {
    if(var_3 == "_encstr_AB590C99ED78875F650F3951034D" && var_4.basename == "_encstr_8BBA05185F8B99" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
      return;
    }
    var_11 = self;

    if(isDefined(var_11.isjuggernaut)) {
      level.spawnedjugg = 0;

      if(isDefined(var_11.juggoverlay))
        var_11.juggoverlay destroy();

      var_11.playerstreakspeedscale = undefined;
      var_11.nostuckdamagekill = 0;
      var_11 scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
      cleanupobjectiveiconsforjugg(var_11);
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_14 = 0;
      var_15 = 0;
      var_16 = 0;
      var_17 = 0;
      var_18 = 0;
      var_19 = 0;

      if(var_1.team != var_11.team) {
        if(isDefined(var_11.isjuggernaut)) {
          if(isDefined(var_1.isjuggernaut))
            var_15 = 1;
          else
            var_16 = 1;
        } else if(isDefined(var_1.isjuggernaut))
          var_17 = 1;
      }

      if(var_16) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BABA10D6A51B63EBA6ABD99DB293DCC2EAA3");
        var_19 = level.ppkonjugg;
      } else if(var_15)
        var_19 = level.ppkjuggonjugg;
      else if(var_17)
        var_19 = level.ppkasjugg;

      if(var_19)
        var_1 scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_19);

      if(var_1.team != var_11.team && game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" && game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1.team] > game["_encstr_96040B1D59B0AD35B1F64E599B"][level.otherteam[var_1.team]])
        var_1.finalkill = 1;
    }
  }
}

objectiveselectorsetup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.objectiveselector = spawnStruct();
  level.objectiveselector.objectivetypes = [];
  level.objectiveselector.objectivetypes[0] = "_encstr_8218041DF5FA";
  level.objectiveselector.objectivetypes[1] = "_encstr_BDD705AD7BD143";
  level.objectiveselector.objectivetypes[2] = "_encstr_951904D8F1E0";
  level.objectiveselector.objectivetypes[3] = "_encstr_AFDD05A6AB763B";
  level.objectiveselector.objectivetypes[4] = "_encstr_B60703EACA";
  level.objectiveselector.prevobj = undefined;
  level.objectiveselector.currentobj = undefined;
  level getnextobjective();
}

getnextobjective(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(isDefined(var_0)) {
    level.objectiveselector.prevobj = var_0;

    for(;;) {
      var_1 = randomint(level.objectiveselector.objectivetypes.size);

      if(var_0 != level.objectiveselector.objectivetypes[var_1] && level.objectiveselector.objectivetypes[var_1] != "_encstr_8A18059BF07BBA") {
        break;
      }

      waitframe();
    }

    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(45000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 1);
    wait 45;
  } else {
    var_1 = randomint(level.objectiveselector.objectivetypes.size);
    setomnvar("_encstr_82190D9574D9EDAB4D67B040B79DA3", int(60000 + gettime()));
    setomnvar("_encstr_8AC50E8B7C773815E247A7A1D71BDDE8", 1);
    wait 60;
  }

  switch (var_1) {
    case 0:
      startbtmflag();
      break;
    case 1:
      starthq();
      break;
    case 2:
      startvip();
      break;
    case 3:
      startjugg();
      break;
    case 4:
      startddbombs();
      break;
    default:
      startbtmflag();
      break;
  }
}

startbtmflag() {
  level notify("_encstr_8E770EE8732E97B0FFEAB521FF3B581B");
}

starthq() {
  level notify("_encstr_AC270D7FE8CE28B8F7A2F3D899C3EF");
}

startvip() {
  level notify("_encstr_87770ECDE0C2EECDBE13D15B7D3B5A38");
}

startjugg() {
  level notify("_encstr_96120F8BB30F1F5D3115AC8D57A0A397A4");
}

startddbombs() {
  level notify("_encstr_99270D0B7A09D05881F36953EFDA95");
}

give_capture_credit(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.lastcaptime = gettime();
  var_5 = var_4;

  if(isDefined(var_5.owner))
    var_5 = var_5.owner;

  if(isPlayer(var_5)) {
    if(!isscoreboosting(var_5)) {
      var_5 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_5.origin);
      var_5 thread scripts\mp\awards::givemidmatchaward("_encstr_B2A70FEDC8F1EFA1A1E8916B788F63FB89");

      if(isDefined(level.radioobject.lastactivatetime) && gettime() - level.radioobject.lastactivatetime <= 2100)
        var_5 thread scripts\mp\awards::givemidmatchaward("_encstr_97D91205E8A9323760F0074720B8C31A07768EFA");

      if(var_5.lastkilltime + 500 > gettime()) {} else
        var_5 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_5);
    }
  }

  var_6 = getarraykeys(var_0);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_0[var_6[var_7]].player;
    var_8 updatecapsperminute(var_3);

    if(!isscoreboosting(var_8)) {
      var_8 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
      var_8 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_8.pers["_encstr_81CF0936850ED1D54EACCD"]);
    } else {}

    wait 0.05;
  }
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["_encstr_BE7D0633C08849E2"]))
    var_1 = self.timeplayed["_encstr_BE7D0633C08849E2"] / 60;

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(var_0) {
  if(var_0.capsperminute > 3)
    return 1;

  return 0;
}

onplayerconnect(var_0) {
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);

  thread onplayerspawned(var_0);
}

onplayerspawned(var_0) {
  for(;;)
    var_0 waittill("_encstr_BA350853C128FB939DB9");
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

getrespawndelay() {
  if(!level.delayplayer)
    return undefined;

  if(!isDefined(level.radioobject))
    return undefined;

  var_0 = level.radioobject.ownerteam;

  if(isDefined(var_0)) {
    if(self.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      if(!level.spawndelay)
        return undefined;

      return level.spawndelay;
    }
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.btmflagobject)) {
    if(isDefined(level.btmflagobject.ownerteam)) {
      if(level.btmflagobject.ownerteam == self.team)
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 15);
      else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 14);
    }
  } else if(isDefined(level.radioobject)) {
    if(isDefined(level.radioobject.ownerteam)) {
      if(level.radioobject.ownerteam == self.team)
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 17);
      else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 16);
    }
  } else if(istrue(level.spawnedvip)) {
    if(isDefined(level.hostagecarrier)) {
      if(level.hostagecarrier.team == self.team) {
        if(level.hostagecarrier == self)
          self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 13);
        else
          self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 11);
      } else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
    } else if(level.hostages[0].team == self.team)
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 10);
    else
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
  } else if(istrue(level.spawnedjugg))
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 19);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);
}

seticonnames() {
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
  level.icontarget = "_encstr_BD911417A3A87AD7DBB83B7101201779180BAA8F33A8";
  level.iconlocked = "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219";
  level.iconhqtarget = "_encstr_971A0AEB3F31A3A8A8E7B278";
  level.iconhqneutral = "_encstr_9BB60B3B0F2F0592DB69CBB0CB";
  level.iconhqcapture = "_encstr_8ACE0B630AA199E13B93A848CF";
  level.iconhqdefend = "_encstr_9A9F0A40CBE1F1936C357A44";
  level.iconhqcontested = "_encstr_86130D58EB714FD7382B95DB5BAAD1";
  level.iconhqtaking = "_encstr_95560ABBE1EF1B5B4432D888";
  level.iconhqlosing = "_encstr_BECE0A5CFFF78A3F3B10DBF7";
  level.iconrecover = "_encstr_9AB415BB16F2C1BDD2738EBE935936DED9B293BE3B4B83";
  level.iconescort = "_encstr_99281C8B3E11E8D8E2C3693707AB16C8B2D33623A460D9865AAB9D433FE3";
  level.iconkill = "_encstr_81FE1A375F4BE79881757B16DC797811C19B83810FB22738B28C414B";
  level.iconextract = "_encstr_93D215F853DF1B784868838695DAC573A0CB43A1530373";
  level.iconpreventextract = "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A";
  level.iconplant = "_encstr_BD3014DD16BC837B96DCD1BED11639D9568ED726E8B5";
}

setupwaypointicons() {}