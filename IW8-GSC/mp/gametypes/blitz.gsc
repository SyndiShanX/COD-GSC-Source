/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\blitz.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }

  updategametypedvars();

  if(level.winrule)
    level.wingamebytype = "_encstr_96040B1D59B0AD35B1F64E599B";
  else
    level.wingamebytype = "_encstr_B81B0A39EDABE69137D5BDCD";

  level.teambased = 1;
  level.objectivebased = 1;
  level.overtimescorewinoverride = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.spawnnodetype = "_encstr_8EE60D40EB97564047873729A16BD8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_BDC80FDC36BAA3EB199B78B1CB542DC9B3";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_ACB10CEBD715AFD85862E041DD8A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_ACB10CEBD715AFD85862E041DD8A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_999514BD955AD32A624BB8480BBE4003C27126376A23"] = "_encstr_999514BD955AD32A624BB8480BBE4003C27126376A23";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_846B1407D569FD585679EBF18BC0844F1729BF220859"] = "_encstr_846B1407D569FD585679EBF18BC0844F1729BF220859";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86B516695DADA073F26B33011B9A311847F973E1430510A0"] = "_encstr_86B516695DADA073F26B33011B9A311847F973E1430510A0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_85EE151DA5502567B68D02DBEA9C0B9EE85F8461C708AD"] = "_encstr_85EE151DA5502567B68D02DBEA9C0B9EE85F8461C708AD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95591238E55BD941C4E378807A9E1F3667993F2D"] = "_encstr_95591238E55BD941C4E378807A9E1F3667993F2D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B44E120D7B40B20A7329532B712FE2D758238552"] = "_encstr_B44E120D7B40B20A7329532B712FE2D758238552";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81A61567E39896A3A393834AB88FD78158BBF4F263A81C"] = "_encstr_81A61567E39896A3A393834AB88FD78158BBF4F263A81C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84691485E38BF21DD34962D5EAF88FB752F8BB25E065"] = "_encstr_84691485E38BF21DD34962D5EAF88FB752F8BB25E065";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA7913F8136B8DC829EBE0189379E1BFB3BE62752D"] = "_encstr_BA7913F8136B8DC829EBE0189379E1BFB3BE62752D";
  setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);
  setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_86E01237B1C9AFC48D4B8EF4FABB2DDC92AB36B2", getmatchrulesdata("_encstr_8AFB0ACE6CA78BFD1F02B828", "_encstr_8AAB08774BE64ABAD8CA"));
  setdynamicdvar("_encstr_A3BB1B43F642C906FAE7A1A52752DFF8FCCBEB1916B798CD82FB9387CB", getmatchrulesdata("_encstr_8AFB0ACE6CA78BFD1F02B828", "_encstr_872E110972A365F0CA35CF9F5637682DAF0A20"));
  setdynamicdvar("_encstr_ABDA150B51063FDE28832C1AD7E0275B2DEB5281F8516F", getmatchrulesdata("_encstr_8AFB0ACE6CA78BFD1F02B828", "_encstr_8B680BAEBFB503F89D89ABC1C9"));
  setdynamicdvar("_encstr_8D691BE66CE4BE138DA5D14FAFCDA17BEE54CDACB6978658939C5A2B9C", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B"));
  setdynamicdvar("_encstr_95B118DC36E4AF31C64B8E3DEB9691B156922B9B95E88AD2ADAC", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_83FA0E968C63594A9537B2A38A96D6CA"));
  setdynamicdvar("_encstr_AFA91572C138F782A94B43633F4FFA0308EB2A33386895", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_B6460B9363B348F07F0B43053F"));
  setdynamicdvar("_encstr_9A2713E61B27F54C1B2D479EAFD0C2B1CCE8966BAC", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_97AB06BBB583D1F5", 0);
  setdynamicdvar("_encstr_B13F127BCF98D99B2130638BDE07838D08AFE4F5", 0);
}

onspawnplayer() {}

onstartgametype() {
  var_0 = scripts\mp\utility\game::inovertime();
  var_1 = game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0;
  var_2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var_0) {
    if(var_1) {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 1);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 1);
    } else if(var_2) {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_991C0AB9ED5B57161FE89B83"], 2, 3));
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_B6A70A23CA6659DC91CAE4DC"], 2, 3));
    } else {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 4);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 4);
    }
  }

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(scripts\mp\utility\game::inovertime())
    setDvar("_encstr_88F615F34B379803A955865A6D455F48EB18957397B8FA", 0);
  else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    setDvar("_encstr_88F615F34B379803A955865A6D455F48EB18957397B8FA", 2);
  else
    setDvar("_encstr_88F615F34B379803A955865A6D455F48EB18957397B8FA", 1);

  if(!isDefined(game["_encstr_83CB139853D7DC20FD0181EF2C673395A34A51A3EB"]))
    game["_encstr_83CB139853D7DC20FD0181EF2C673395A34A51A3EB"] = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_88D61DE92425548615292BA86AAF9E9315D732260AA3AF0A452A50A15A2A94");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8C1B1DDFF1ACADD859536B57A6A7D07E95B1435B7165FFF043FCA79D05CB79");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_B63D23C8FEC8E30D347FE1610F67C4BD40D1D4C186B00FB5DC2351590755BF67894ED8766F");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_87B623E49E5A39B6590785BB77B1E8292DA14D1CF6FF31FDA013ABA54338AE59930E14576F");
  }

  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_93DE11ED1ED5100BC7190377F190C2480B8D20");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_93DE11ED1ED5100BC7190377F190C2480B8D20");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_883422288DF087380F688470478F2DD561E6AFC991D4A1992327377E497D3DFFEC71EE51");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_BE7322AD35293D4045FB3B4FF7E8C87E09FE97E5CDE99FE8350D7F6BB1BD21B789841D7B");
  flag_setupvfx();
  createflagsandhud();
  initspawns();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.winrule = scripts\mp\utility\dvars::dvarintvalue("_encstr_8AAB08774BE64ABAD8CA", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_83FA0E968C63594A9537B2A38A96D6CA", 30, 0, 60);
  level.capturecondition = scripts\mp\utility\dvars::dvarintvalue("_encstr_872E110972A365F0CA35CF9F5637682DAF0A20", 0, 0, 1);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B6460B9363B348F07F0B43053F", 0, 0, 10);
  level.returntime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8B680BAEBFB503F89D89ABC1C9", 0, -1, 25);
}

createflagsandhud() {
  level.flagmodel["_encstr_9A8507BA4040188D08"] = "_encstr_86FE13B3F501B71F03D0E2599041D61F9EDC3D3B0D";
  level.flagbase["_encstr_9A8507BA4040188D08"] = "_encstr_A56913CF75743E17E7397139EFCD689C6F32567259";
  level.carryflag["_encstr_9A8507BA4040188D08"] = "_encstr_BDAF1807E4F683FA8D1DCCFACE2CAD56BE66638576BEEECADC1D";
  level.flagmodel["_encstr_8E8405EA382B2A"] = "_encstr_A2931336D1CCBEB3585B2BEB661B8576EB95C237A3";
  level.flagbase["_encstr_8E8405EA382B2A"] = "_encstr_A56913CF75743E17E7397139EFCD689C6F32567259";
  level.carryflag["_encstr_8E8405EA382B2A"] = "_encstr_A344180732FF4BF7961368991A2E5B21E7CE8177BF9751D3FA7B";
  level.closecapturekiller = [];
  level.closecapturekiller["_encstr_9A8507BA4040188D08"] = undefined;
  level.closecapturekiller["_encstr_8E8405EA382B2A"] = undefined;
  setupwaypointicons();
  level.iconescort = "_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3";
  level.iconkill = "_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D";
  level.iconpickupflag = "_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303";
  level.icongoalflag = "_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB";
  level.iconreturnflag = "_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134";
  level.iconresettingflag = "_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3";
  level.iconlosingflag = "_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97";
  level.icondefendflag = "_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA";
  level.iconpickupdefendflag = "_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3";
  level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = createteamflag(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8E8405EA382B2A");
  level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]] = createteamflag(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9A8507BA4040188D08");
  level.capzones[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = createcapzone(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8E8405EA382B2A");
  level.capzones[game["_encstr_991C0AB9ED5B57161FE89B83"]] = createcapzone(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9A8507BA4040188D08");
}

flag_setupvfx() {}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B6C1101EF493C31E1318DF670829FD0A630E", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AD69185B07AF1BE833F59B0E5877DCF5850FA56EEBDCE8589C47");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8EE60D40EB97564047873729A16BD8");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8EE60D40EB97564047873729A16BD8");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  assignteamspawns();
  level.ctfteamspawnsetids["_encstr_9A8507BA4040188D08"] = "_encstr_9A8507BA4040188D08";
  level.ctfteamspawnsetids["_encstr_8E8405EA382B2A"] = "_encstr_8E8405EA382B2A";
  scripts\mp\spawnlogic::registerspawnset("_encstr_9A8507BA4040188D08", level.teamspawnpoints["_encstr_9A8507BA4040188D08"]);
  scripts\mp\spawnlogic::registerspawnset("_encstr_8E8405EA382B2A", level.teamspawnpoints["_encstr_8E8405EA382B2A"]);
  scripts\mp\spawnlogic::registerspawnset("_encstr_A7A408B9CA5D1D4E2C63", level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"]);
}

assignteamspawns() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["_encstr_8E8405EA382B2A"] = [];
  level.teamspawnpoints["_encstr_9A8507BA4040188D08"] = [];
  level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"] = [];

  if(level.teamflags.size == 2) {
    var_2 = level.teamflags["_encstr_9A8507BA4040188D08"];
    var_3 = level.teamflags["_encstr_8E8405EA382B2A"];
    var_4 = (var_2.curorigin[0], var_2.curorigin[1], 0);
    var_5 = (var_3.curorigin[0], var_3.curorigin[1], 0);
    var_6 = var_5 - var_4;
    var_7 = length2d(var_6);

    foreach(var_9 in var_0) {
      var_10 = (var_9.origin[0], var_9.origin[1], 0);
      var_11 = var_10 - var_4;
      var_12 = vectordot(var_11, var_6);
      var_13 = var_12 / (var_7 * var_7);

      if(var_13 < 0.33) {
        var_9.teambase = var_2.ownerteam;
        level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
        continue;
      }

      if(var_13 > 0.67) {
        var_9.teambase = var_3.ownerteam;
        level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
        continue;
      }

      var_14 = undefined;
      var_15 = undefined;

      if(var_1)
        var_14 = getpathdist(var_9.origin, var_2.curorigin, 999999);

      if(isDefined(var_14) && var_14 != -1)
        var_15 = getpathdist(var_9.origin, var_3.curorigin, 999999);

      if(!isDefined(var_15) || var_15 == -1) {
        var_14 = distance2d(var_2.curorigin, var_9.origin);
        var_15 = distance2d(var_3.curorigin, var_9.origin);
      }

      var_16 = max(var_14, var_15);
      var_17 = min(var_14, var_15);
      var_18 = var_17 / var_16;

      if(var_18 > 0.5)
        level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"][level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"].size] = var_9;
    }
  } else {
    foreach(var_9 in var_0) {
      var_9.teambase = getnearestflagteam(var_9);

      if(var_9.teambase == "_encstr_8E8405EA382B2A") {
        level.teamspawnpoints["_encstr_8E8405EA382B2A"][level.teamspawnpoints["_encstr_8E8405EA382B2A"].size] = var_9;
        continue;
      }

      level.teamspawnpoints["_encstr_9A8507BA4040188D08"][level.teamspawnpoints["_encstr_9A8507BA4040188D08"].size] = var_9;
    }
  }
}

getnearestflagteam(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.teamflags) {
    var_6 = undefined;

    if(var_1)
      var_6 = getpathdist(var_0.origin, var_5.curorigin, 999999);

    if(!isDefined(var_6) || var_6 == -1)
      var_6 = distancesquared(var_5.curorigin, var_0.origin);

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.ownerteam;
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(level.mapname == "_encstr_B6EE0A72AB0863F3C065A5BA") {
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
      var_1 = scripts\mp\utility\game::getotherteam(var_1)[0];
    }

    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_91330E5B0EFAB11D66D7E6E085EE73EB" + var_1 + "_encstr_B4810709B378B9F3F5");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    } else {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_91330E5B0EFAB11D66D7E6E085EE73EB" + var_0 + "_encstr_B4810709B378B9F3F5");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    }
  } else
    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.ctfteamspawnsetids[var_0], "_encstr_A7A408B9CA5D1D4E2C63");

  return var_3;
}

flag_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(game["_encstr_991C0AB9ED5B57161FE89B83"]))
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";

  if(!isDefined(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.flags) {
    switch (var_3.script_label) {
      case "_encstr_B20703DFCF":
        if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
          level.default_flag_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_3.origin;
        else
          level.default_flag_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_3.origin;

        break;
      case "_encstr_B6070359BA":
        if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
          level.default_flag_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_3.origin;
        else
          level.default_flag_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_3.origin;

        break;
    }
  }

  var_5 = getEnt("_encstr_8B1F0A8163D2D61AC0589B81" + game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
      level.default_flag_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_5.origin;
    else
      level.default_flag_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_5.origin;
  }

  var_5 = getEnt("_encstr_8B1F0A8163D2D61AC0589B81" + game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
      level.default_flag_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_5.origin;
    else
      level.default_flag_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_5.origin;
  }
}

flag_create_team_goal(var_0) {
  var_1 = spawnStruct();

  switch (level.script) {
    default:
      break;
  }

  if(!isDefined(var_1.origin))
    var_1.origin = level.default_flag_origins[var_0];

  var_1 flag_find_ground();
  var_1.origin = var_1.ground_origin;
  var_1.radius = 30;
  var_1.team = var_0;
  var_1.ball_in_goal = 0;
  var_1.highestspawndistratio = 0;
  return var_1;
}

flag_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["_encstr_BD260953AA97E3F014279D"];
  return var_5["_encstr_A53009A25003666B9818C6"] != 0 && var_5["_encstr_A53009A25003666B9818C6"] != 1;
}

showflagradiuseffecttoplayers(var_0, var_1, var_2) {
  if(isDefined(var_1._flagradiuseffect[var_0]))
    var_1._flagradiuseffect[var_0] delete();

  var_3 = undefined;
  var_4 = var_1.team;
  var_5 = var_1 ismlgspectator();

  if(var_5)
    var_4 = var_1 getmlgspectatorteam();
  else if(var_4 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    var_4 = "_encstr_9A8507BA4040188D08";

  if(var_4 == var_0) {
    var_6 = spawnfxforclient(level.flagradiusfxid["_encstr_ACFC091AE8AB2FCBE15119"], var_2, var_1, (0, 0, 1));
    var_6 setfxkilldefondelete();
  } else {
    var_6 = spawnfxforclient(level.flagradiusfxid["_encstr_88BF06FD784A6393"], var_2, var_1, (0, 0, 1));
    var_6 setfxkilldefondelete();
  }

  var_1._flagradiuseffect[var_0] = var_6;
  triggerfx(var_6);
}

showbaseeffecttoplayer(var_0, var_1) {
  if(isDefined(var_1._flageffect[var_0]))
    var_1._flageffect[var_0] delete();

  var_2 = undefined;
  var_3 = var_1.team;
  var_4 = var_1 ismlgspectator();

  if(var_4)
    var_3 = var_1 getmlgspectatorteam();
  else if(var_3 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    var_3 = "_encstr_9A8507BA4040188D08";

  if(var_3 == var_0) {
    var_5 = spawnfxforclient(level.flagbaseglowfxid["_encstr_ACFC091AE8AB2FCBE15119"], self.origin, var_1, self.baseeffectforward);
    var_5 setfxkilldefondelete();
  } else {
    var_5 = spawnfxforclient(level.flagbaseglowfxid["_encstr_88BF06FD784A6393"], self.origin, var_1, self.baseeffectforward);
    var_5 setfxkilldefondelete();
  }

  var_1._flageffect[var_0] = var_5;
  triggerfx(var_5);
}

setteaminhuddatafromteamname(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    self setteaminhuddata(1);
  else if(var_0 == "_encstr_9A8507BA4040188D08")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

createteamflag(var_0, var_1) {
  var_2 = 0;
  var_3 = flag_create_team_goal(var_0);
  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin - (0, 0, var_3.radius / 2), 0, var_3.radius, 80);
  var_4.no_moving_platfrom_unlink = 1;
  var_4.linktoenabledflag = 1;
  var_4.baseorigin = var_4.origin;
  var_2 = 1;
  var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_5[0] setasgametypeobjective();
  var_5[0] setteaminhuddatafromteamname(var_1);

  if(!isDefined(var_5[0])) {}

  if(!var_2) {
    var_6 = 15;

    if(level.pickuptime > 0 || level.returntime > 0)
      var_6 = var_6 * 2;

    var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4.origin, 0, var_6, var_4.height);
    var_4 = var_7;
  }

  var_5[0] setModel(level.flagmodel[var_0]);
  var_5[0] setasgametypeobjective();
  var_5[0] setteaminhuddatafromteamname(var_1);
  var_8 = scripts\mp\gameobjects::createcarryobject(var_0, var_4, var_5, (0, 0, 72));
  var_8 scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
  var_8 scripts\mp\gameobjects::setteamusetime("_encstr_ACFC091AE8AB2FCBE15119", level.pickuptime);
  var_8 scripts\mp\gameobjects::setteamusetime("_encstr_88BF06FD784A6393", level.returntime);
  var_8 scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_8.objidnum, 0);
  var_8.atbase = 1;
  var_8.allowweapons = 1;
  var_8.onpickup = ::onpickup;
  var_8.onpickupfailed = ::onpickup;
  var_8.ondrop = ::ondrop;
  var_8.onreset = ::onreset;
  var_8.onbeginuse = ::onresetstart;
  var_8.onenduse = ::onresetend;

  if(level.pickuptime > 0 || level.returntime > 0) {
    var_8.nousebar = 1;
    var_8.claimgracetime = max(level.pickuptime * 1000, level.returntime * 1000);
    var_8 scripts\mp\gameobjects::pinobjiconontriggertouch();
  }

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 60.0;
        break;
      case 1:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 0.05;
        break;
      case 2:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 1.0;
        break;
      case 3:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 1.5;
        break;
      case 4:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 2.0;
        break;
      case 5:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 3.0;
        break;
      case 6:
        var_8.objidpingfriendly = 0;
        var_8.objidpingenemy = 1;
        var_8.objpingdelay = 4.0;
        break;
    }
  } else {
    var_8.objidpingfriendly = 0;
    var_8.objidpingenemy = 1;
    var_8.objpingdelay = 3.0;
  }

  var_8.oldradius = var_4.radius;
  var_9 = var_4.origin + (0, 0, 32);
  var_10 = var_4.origin + (0, 0, -32);
  var_11 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_12 = [];
  var_13 = scripts\engine\trace::ray_trace(var_9, var_10, var_12, var_11);
  var_8.baseeffectpos = var_8.visuals[0].origin;
  var_14 = anglestoup(var_8.visuals[0].angles);
  var_8.baseeffectforward = anglesToForward(var_14);
  level.teamflagbases[var_0] = createteamflagbase(var_0, var_8);
  return var_8;
}

createteamflagbase(var_0, var_1) {
  var_2 = var_1.visuals[0].origin;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel(level.flagbase[var_0]);
  var_3.ownerteam = var_0;
  var_3 setasgametypeobjective();
  var_3 setteaminhuddatafromteamname(var_0);
  var_3.baseeffectpos = var_2;
  var_4 = anglestoup(var_1.visuals[0].angles);
  var_3.baseeffectforward = anglesToForward(var_4);
  return var_3;
}

createcapzone(var_0, var_1) {
  var_2 = flag_create_team_goal(var_0);
  var_3 = getEnt("_encstr_8B1F0A8163D2D61AC0589B81" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3)) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin - (0, 0, var_2.radius / 2), 0, var_2.radius, 80);
    var_3.no_moving_platfrom_unlink = 1;
    var_3.linktoenabledflag = 1;
    var_3.baseorigin = var_3.origin;
    var_3.height = 80;
  }

  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin, 0, 15, var_3.height);
  var_3 = var_4;
  var_5 = [];
  var_6 = scripts\mp\gameobjects::createuseobject(var_0, var_3, var_5, (0, 0, 85));
  var_6 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_6 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_6 scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  var_6 scripts\mp\gameobjects::setusetime(0);
  var_6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var_0)[0]]);
  var_6.onuse = ::onuse;
  var_7 = var_3.origin + (0, 0, 32);
  var_8 = var_3.origin + (0, 0, -32);
  var_9 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(var_7, var_8, var_10, var_9);
  var_12 = vectortoangles(var_11["_encstr_820E07FAE8780B3A4C"]);
  var_13 = anglesToForward(var_12);
  var_14 = anglestoright(var_12);
  return var_6;
}

onbeginuse(var_0) {
  var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];

  if(var_1 == scripts\mp\gameobjects::getownerteam())
    self.trigger.radius = 1024;
  else
    self.trigger.radius = self.oldradius;
}

onenduse(var_0, var_1, var_2) {
  self.trigger.radius = self.oldradius;
}

onpickup(var_0, var_1, var_2) {
  self notify("_encstr_9A990A13739E149BF7605DD9");
  var_0 notify("_encstr_BD920E0FA530B1ABDB19CAD2013877B2");
  var_3 = var_0.pers["_encstr_8AEF05472BC2D6"];

  if(var_3 == "_encstr_9A8507BA4040188D08")
    var_4 = "_encstr_8E8405EA382B2A";
  else
    var_4 = "_encstr_9A8507BA4040188D08";

  if(var_3 != scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[var_0.team]) && level.closecapturekiller[var_0.team] == var_0)
      var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_8FAD0ECDB06437611BA30FCF33B8D8ED");

    level.closecapturekiller[var_0.team] = undefined;
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8B040C3941CBB0971BEA2B158058");
    thread returnflag(var_3);
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_AD620BCF8E92F1DBC5B8552DB5", var_0.origin);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AD9C10802BB708257A01F675A3E34D50F513", var_3);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AD9C10802BB708257A01F675A3E34D50F513", scripts\mp\utility\game::getotherteam(var_3)[0]);
    scripts\mp\utility\dialog::leaderdialog("_encstr_84691485E38BF21DD34962D5EAF88FB752F8BB25E065", var_4, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_86B516695DADA073F26B33011B9A311847F973E1430510A0", var_3, "_encstr_A16D07532531CB4BF7");
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_A9F70806677BD37B5EE7", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A9F70806677BD37B5EE7", var_0.pers["_encstr_A9F70806677BD37B5EE7"]);

    if(isPlayer(var_0))
      var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_A9F70806677BD37B5EE7"]);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_3]))
      var_0 thread applyflagcarrierclass();
    else
      var_0 attachflag();

    self.atbase = 0;
    level.closecapturekiller[var_4] = undefined;

    if(var_0.team == "_encstr_9A8507BA4040188D08")
      setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", var_0 getentitynumber());
    else
      setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", var_0 getentitynumber());

    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 1);

    if(isDefined(level.showenemycarrier)) {
      if(level.showenemycarrier == 0)
        scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      else
        scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

    if(level.teamflags[var_4].atbase)
      level.capzones[var_4] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
    else {
      level.capzones[var_4] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      level.capzones[var_4] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
    }

    level.capzones[var_3] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

    if(level.capturecondition == 0) {}

    scripts\mp\utility\sound::playsoundonplayers("_encstr_A9270D032BDE1829E38E33C7DB0D26", var_3);
    scripts\mp\utility\dialog::leaderdialog("_encstr_BA7913F8136B8DC829EBE0189379E1BFB3BE62752D", var_3);
    thread scripts\mp\hud_util::teamplayercardsplash("_encstr_9A041398929D516047EC3094DC3F293184DAA0A01B", var_0);

    if(!isDefined(self.previouscarrier) || self.previouscarrier != var_0)
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BD130A5D809EB9A92F6B2169");

    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
    self.previouscarrier = var_0;

    if(level.codcasterenabled)
      var_0 setgametypevip(1);
  }
}

returnflag(var_0) {
  self.atbase = 1;

  if(var_0 == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
  else
    setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);

  scripts\mp\gameobjects::returnhome();
}

ondrop(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  objective_setpings(self.objidnum, 0);

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.icongoalflag);

  if(var_1 == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -1);
  else
    setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -1);

  if(isDefined(var_0))
    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);

  var_3 = self.visuals[0] gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0))
      var_0.carryobject.previouscarrier = undefined;

    if(isDefined(var_0.carryflag))
      var_0 detachflag();

    scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);

    if(level.codcasterenabled)
      var_0 setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);

  scripts\mp\utility\dialog::leaderdialog("_encstr_846B1407D569FD585679EBF18BC0844F1729BF220859", var_2, "_encstr_A16D07532531CB4BF7");
  scripts\mp\utility\dialog::leaderdialog("_encstr_B44E120D7B40B20A7329532B712FE2D758238552", var_1, "_encstr_A16D07532531CB4BF7");

  if(level.idleresettime > 0)
    thread returnaftertime();
}

returnaftertime() {
  self endon("_encstr_9A990A13739E149BF7605DD9");
  var_0 = 0.0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "_encstr_8BBA05185F8B99")
      var_0 = var_0 + level.framedurationseconds;
  }

  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\utility\sound::playsoundonplayers("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255", var_1);
  scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);
  scripts\mp\gameobjects::returnhome();
}

onreset() {
  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  objective_setpings(self.objidnum, 0);

  if(var_0 == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
  else
    setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);

  if(level.teamflags[var_0].atbase)
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);

  if(level.teamflags[var_1].atbase)
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  else
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

  level.capzones[var_0] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  self.previouscarrier = undefined;
}

onresetstart(var_0) {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingflag, level.iconresettingflag);
}

onresetend(var_0, var_1, var_2) {
  if(!var_2)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
}

onuse(var_0) {
  if(!level.gameended) {
    var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];

    if(var_1 == "_encstr_9A8507BA4040188D08")
      var_2 = "_encstr_8E8405EA382B2A";
    else
      var_2 = "_encstr_9A8507BA4040188D08";

    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
    scripts\mp\utility\dialog::leaderdialog("_encstr_95591238E55BD941C4E378807A9E1F3667993F2D", var_1, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_999514BD955AD32A624BB8480BBE4003C27126376A23", var_2, "_encstr_A16D07532531CB4BF7");
    thread scripts\mp\hud_util::teamplayercardsplash("_encstr_967F14610EC5C907153BF1724148102977B3153B9365", var_0);
    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_95780D2DAF2BE7E9205BFBFE8F42DB");
    var_0 notify("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_B1CF098D5838A3D5C95623");
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_0.origin);

    if(level.codcasterenabled)
      var_0 setgametypevip(0);

    var_0 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

    if(isPlayer(var_0))
      var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\sound::playsoundonplayers("_encstr_82C6102771207AEAD096AE366BF8256385E1", var_1);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39", scripts\mp\utility\game::getotherteam(var_1)[0]);

    if(isDefined(var_0.carryflag))
      var_0 detachflag();

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1]))
      var_0 thread removeflagcarrierclass();

    level.closecapturekiller[var_1] = undefined;
    level.closecapturekiller[var_2] = undefined;

    if(level.teamflags[scripts\mp\utility\game::getotherteam(var_1)[0]].atbase)
      level scripts\mp\gamescore::giveteamscoreforobjective(var_1, 2, 0);
    else
      level scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);

    level.teamflags[var_1] returnflag(var_1);
  }
}

onplayerconnect(var_0) {
  var_0._flageffect = [];
  var_0._flagradiuseffect = [];
  var_0 thread onplayerspawned();
}

onplayerspawned() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BA350853C128FB939DB9");
    self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["_encstr_A9F70806677BD37B5EE7"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_A9F70806677BD37B5EE7"]);
  }
}

applyflagcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.ctf_loadouts[self.team];
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.lastclass = "_encstr_AAAC09D09972B9C83F2B7F";
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  thread waitattachflag();
}

waitattachflag() {
  level endon("_encstr_B8050AFF97F37A6F9948D3DF");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  attachflag();
}

removeflagcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = undefined;
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = var_1.origin;
  var_12 = 0;

  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["_encstr_8AEF05472BC2D6"] != self.pers["_encstr_8AEF05472BC2D6"]) {
    if(isDefined(var_1.carryflag) && var_12) {
      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_AB2818EDC8F1EFA1B7C802A9089B2583CEAC618CD33E5BB55BB8");
      var_10 = 1;
    }

    if(isDefined(self.carryflag)) {
      var_13 = distancesquared(self.origin, level.capzones[self.team].trigger.origin);

      if(var_13 < 90000)
        level.closecapturekiller[var_1.team] = var_1;
      else
        level.closecapturekiller[var_1.team] = undefined;

      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_AA5316225A58AD509873B5299F9BE261513606D07368ADFE");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_852F09FA41FB7ADB3968C4");
      var_10 = 1;
    }

    if(!var_10) {
      var_14 = 0;
      var_15 = 0;

      foreach(var_17 in level.teamflags) {
        var_18 = distsquaredcheck(var_11, self.origin, var_17.curorigin);

        if(var_18) {
          if(var_17.ownerteam == self.team) {
            var_14 = 1;
            continue;
          }

          var_15 = 1;
        }
      }

      if(var_14) {
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
      } else if(var_15) {
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
      }
    }
  }

  if(isDefined(self.carryflag))
    detachflag();
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000)
    return 1;
  else
    return 0;
}

attachflag() {
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];
  self attach(level.carryflag[var_0], "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1);
  self.carryflag = level.carryflag[var_0];
}

detachflag() {
  self detach(self.carryflag, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
  self.carryflag = undefined;
}

setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", "_encstr_8E8405EA382B2A", 5, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
    level.ctf_loadouts["_encstr_8E8405EA382B2A"] = scripts\mp\utility\game::getmatchrulesspecialclass("_encstr_8E8405EA382B2A", 5);

  if(isusingmatchrulesdata() && getmatchrulesdata("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", "_encstr_9A8507BA4040188D08", 5, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
    level.ctf_loadouts["_encstr_9A8507BA4040188D08"] = scripts\mp\utility\game::getmatchrulesspecialclass("_encstr_9A8507BA4040188D08", 5);
}

setupwaypointicons() {
  level.waypointcolors["_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D"] = "_encstr_88BF06FD784A6393";
  level.waypointbgtype["_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D"] = 1;
  level.waypointstring["_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D"] = "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E";
  level.waypointshader["_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D"] = "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36";
  level.waypointpulses["_encstr_933814DD2CCB837BD23747AF261B5A8E4FBE5BB4368D"] = 0;
  level.waypointcolors["_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303"] = 0;
  level.waypointstring["_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303"] = "_encstr_84E61F79534F249570AE514D31284D4CE116E19953375FD318C455CF19801B7733";
  level.waypointshader["_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_AF2416802A60A1A8EF3E6DF00AC3506108513088E23C1303"] = 1;
  level.waypointcolors["_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB"] = "_encstr_88BF06FD784A6393";
  level.waypointbgtype["_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB"] = 0;
  level.waypointstring["_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB"] = "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F";
  level.waypointshader["_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB"] = "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F";
  level.waypointpulses["_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB"] = 0;
  level.waypointcolors["_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3"] = 2;
  level.waypointstring["_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3"] = "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB";
  level.waypointshader["_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_B8AF16432789D88578EEE4F185C8A1EB58291F3FC8409BB3"] = 0;
  level.waypointcolors["_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA"] = 0;
  level.waypointstring["_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA"] = "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA";
  level.waypointshader["_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA"] = "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F";
  level.waypointpulses["_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA"] = 0;
  level.waypointcolors["_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134"] = 0;
  level.waypointstring["_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134"] = "_encstr_A7ED1E47D1C0F8265975051FAE417EE0BB57C7E34D6891E511DD4B914519A8E9";
  level.waypointshader["_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_BEAE155F88AAF87A43A083719E6152A49211339F808134"] = 0;
  level.waypointcolors["_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3"] = "_encstr_88BF06FD784A6393";
  level.waypointbgtype["_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3"] = 0;
  level.waypointstring["_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3"] = "_encstr_878C22DF494870AEE1FD9D9756C9E65823DF4F6BC590095D9945C3AB8CF937A1969BBB97";
  level.waypointshader["_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_918819BB2CBC38B7D2B9E8AF898DD2D13D7D39CA9B59A33AA5B9B3"] = 0;
  level.waypointcolors["_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97"] = 0;
  level.waypointstring["_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97"] = "_encstr_84E61F79534F249570AE514D31284D4CE116E19953375FD318C455CF19801B7733";
  level.waypointshader["_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_9BB91D4707B73932DC5DAB41F3E299B0E81F1368A2775367E785CF0FF89D97"] = 1;
  level.waypointcolors["_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3"] = "_encstr_ACFC091AE8AB2FCBE15119";
  level.waypointbgtype["_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3"] = 0;
  level.waypointstring["_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3"] = "_encstr_84C92630615F8CE33D6F858518449B853B02987819873237954285E8300D7FDFBB61B021A9137A07";
  level.waypointshader["_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3"] = "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576";
  level.waypointpulses["_encstr_BE271DDF6B60B20F0370833999E94FEBD0AF505987083BBB2029EAB24130B3"] = 0;
}