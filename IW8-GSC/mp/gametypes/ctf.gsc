/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\ctf.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  var_0[0] = "_encstr_8E1904B3F501";
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
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_93100D771F6BE2CC92405FAFC06B96";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_8E650A73F8A7BE6577E2AB09";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_8E650A73F8A7BE6577E2AB09";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_8E650A73F8A7BE6577E2AB09";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C960B6663B076D7A316DACADC"] = "_encstr_A9C70EC76D8A20398F72167BFA4F65B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE8F0DE7A1DA2CB7E2D0AF8A028179"] = "_encstr_A73A0DED5D93338D0B9DEB23277BE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_855C0E99B185CEEB9C9547AE39B9CA32"] = "_encstr_AA280F329B05F1B10197497AA9BB3DDD25";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2390E02E8D7F7B968BBF0FC7B08FF23"] = "_encstr_BE760DA5D3E81EB2DFA71FD7937F7B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BCD0DC83AA6CFEE97752D2E49BF50"] = "_encstr_AF601092CB5EF37578B7DFEF5B383E370EA0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE62153F855D41B7C12A9DDF6FE91EAAD0801FEBDF77F0"] = "_encstr_8842115BFED7E03B1BBA5981918BF8506E5BD3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD4A11FA601D07E8410DA4B11719F37FB2B9C2"] = "_encstr_84041056732BD6F2CC36C29DF58EC25B59DC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C11138710F0B5436005733F7F08DAE2F87B7A0FC9"] = "_encstr_860A0FCB6EA7904B6B2AC931215B86C8BA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8559141F553552F981B9753EB1A93A6A15CBDBBB3BED"] = "_encstr_9AEA111DA5502567B48D82EA4E962FDB78059E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A121140B7B9271CB8F4F50C937A718BF1BFBD3ADCF2A"] = "_encstr_83270FD84B95401B82C5677C118A73ABEC";
  setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);
  setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_9725109327703167D539097320206B735883", getmatchrulesdata("_encstr_ADFC082954FBC58E38B9", "_encstr_8AAB08774BE64ABAD8CA"));
  setdynamicdvar("_encstr_A63E1953E632B9F60BCBE7A7EF734520EAFFDD284D8CB035B2878D", getmatchrulesdata("_encstr_ADFC082954FBC58E38B9", "_encstr_872E110972A365F0CA35CF9F5637682DAF0A20"));
  setdynamicdvar("_encstr_ABF413BF683B274A69B4590A2D41E3B2CD794F4F20", getmatchrulesdata("_encstr_ADFC082954FBC58E38B9", "_encstr_8B680BAEBFB503F89D89ABC1C9"));
  setdynamicdvar("_encstr_A59019C3C112591FD8F1D19383382F6D8AF9885B2D7F76CD77071E", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B"));
  setdynamicdvar("_encstr_A3531696F60B97495483E94093944145821A059D8312ABF1", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_83FA0E968C63594A9537B2A38A96D6CA"));
  setdynamicdvar("_encstr_B8D9130327C3F99689551E53D457D843F25D37D025", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_B6460B9363B348F07F0B43053F"));
  setdynamicdvar("_encstr_BE51116B468BD7C6F470E869F38CA26B2B50EB", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8E1904B3F501", 0);
}

onspawnplayer() {
  _id_13FFA();
}

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

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_3 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_4 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_4;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_3;
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_88D61DE92425548615292BA86AAF9E9315D732260AA3AF0A452A50A15A2A94");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8C1B1DDFF1ACADD859536B57A6A7D07E95B1435B7165FFF043FCA79D05CB79");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_B63D23C8FEC8E30D347FE1610F67C4BD40D1D4C186B00FB5DC2351590755BF67894ED8766F");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_87B623E49E5A39B6590785BB77B1E8292DA14D1CF6FF31FDA013ABA54338AE59930E14576F");
  }

  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_97670FF8224BCDEF7BE0C9A9B95D2727A3");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_97670FF8224BCDEF7BE0C9A9B95D2727A3");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_883422288DF087380F688470478F2DD561E6AFC991D4A1992327377E497D3DFFEC71EE51");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_BE7322AD35293D4045FB3B4FF7E8C87E09FE97E5CDE99FE8350D7F6BB1BD21B789841D7B");
  flag_setupvfx();
  createflagsandhud();
  initspawns();
  thread removeflag();
  thread placeflag();
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
  level.iconescort = "_encstr_BD2E15FB09E850EAA3CDDB7F3356D2B7583379078D700F";
  level.iconkill = "_encstr_8E1D12A77FE20B1D13C8F359B87117FF18D33424";
  level.iconcaptureflag = "_encstr_922D1337B98850786F22335EEB2722A0A916B99327";
  level.icondefendflag = "_encstr_92BB1560CA8001084F9ECD506C87D1E3AD02A950B2DE57";
  level.iconreturnflag = "_encstr_BEA8161BF0472BD82920DBE7AB513E3F8EC07E117E6031EF";
  level._id_11C5F = "_encstr_87C218EE16E583DE4B9BD1FADA369D7D59D60EA3F2D7CCD8C23B";
  level._id_11C60 = "_encstr_AB8717DDC22F0EF62DE6D1AF5B1B9DBECCAB63B1F53363853B";
  level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = createteamflag(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8E8405EA382B2A");
  level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]] = createteamflag(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9A8507BA4040188D08");
  level.capzones[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = createcapzone(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8E8405EA382B2A");
  level.capzones[game["_encstr_991C0AB9ED5B57161FE89B83"]] = createcapzone(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::_id_11F84(level.capzones[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].objidnum, 1);
  scripts\mp\objidpoolmanager::_id_11F84(level.capzones[game["_encstr_991C0AB9ED5B57161FE89B83"]].objidnum, 1);
}

flag_setupvfx() {}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B6C1101EF493C31E1318DF670829FD0A630E", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AD69185B07AF1BE833F59B0E5877DCF5850FA56EEBDCE8589C47");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_AD69185B07AF1BE833F59B0E5877DCF5850FA56EEBDCE8589C47");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AD69185B07AF1BE833F59B0E5877DCF5850FA56EEBDCE8589C47");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8EE60D40EB97564047873729A16BD8");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8EE60D40EB97564047873729A16BD8");
  assignteamspawns();
  level.ctfteamspawnsetids["_encstr_9A8507BA4040188D08"] = "_encstr_9A8507BA4040188D08";
  level.ctfteamspawnsetids["_encstr_8E8405EA382B2A"] = "_encstr_8E8405EA382B2A";
  scripts\mp\spawnlogic::registerspawnset("_encstr_9A8507BA4040188D08", level.teamspawnpoints["_encstr_9A8507BA4040188D08"]);
  scripts\mp\spawnlogic::registerspawnset("_encstr_8E8405EA382B2A", level.teamspawnpoints["_encstr_8E8405EA382B2A"]);
  scripts\mp\spawnlogic::registerspawnset("_encstr_A7A408B9CA5D1D4E2C63", level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"]);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
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
        var_9.teambase = scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
        level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
        continue;
      }

      if(var_13 > 0.67) {
        var_9.teambase = scripts\mp\utility\game::getotherteam(var_3.ownerteam)[0];
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

  return scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
    }
  } else
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.ctfteamspawnsetids[var_0], "_encstr_A7A408B9CA5D1D4E2C63");

  return var_1;
}

flag_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(game["_encstr_991C0AB9ED5B57161FE89B83"]))
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";

  if(!isDefined(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";

  foreach(var_1 in level.flags) {
    switch (var_1.script_label) {
      case "_encstr_B20703DFCF":
        level.default_flag_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_1.origin;
        break;
      case "_encstr_B6070359BA":
        level.default_flag_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_1.origin;
        break;
    }
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

removeflagpickupradiuseffect(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flagradiuseffect[self.team]))
      self._flagradiuseffect[self.team] delete();
  } else if(isDefined(self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]]))
    self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
}

setteaminhuddatafromteamname(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    self setteaminhuddata(1);
  else if(var_0 == "_encstr_9A8507BA4040188D08")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

player_delete_flag_goal_fx(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flageffect[self.team]))
      self._flageffect[self.team] delete();
  } else if(isDefined(self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]]))
    self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
}

getflagpos(var_0) {
  var_1 = getEnt("_encstr_81650A3E6BD0BFBAE11357BF" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  return var_1.origin;
}

createteamflag(var_0, var_1) {
  var_2 = 0;
  var_3 = getEnt("_encstr_8B1F0A8163D2D61AC0589B81" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3)) {
    var_4 = flag_create_team_goal(var_0);
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4.origin - (0, 0, var_4.radius / 2), 0, var_4.radius, 80);
    var_3.no_moving_platfrom_unlink = 1;
    var_3.linktoenabledflag = 1;
    var_3.baseorigin = var_3.origin;
    var_2 = 1;
    var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_5[0] setasgametypeobjective();
    var_5[0] setteaminhuddatafromteamname(var_1);
  } else
    var_5[0] = getEnt("_encstr_81650A3E6BD0BFBAE11357BF" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_5[0])) {}

  if(!var_2) {
    var_6 = 15;

    if(level.pickuptime > 0 || level.returntime > 0)
      var_6 = var_6 * 2;

    var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin, 0, var_6, var_3.height);
    var_3 = var_7;
  }

  if(level.mapname == "_encstr_8E020FABE7B9F00F4EC0F83381FDDA9004") {
    var_3 flag_find_ground();
    var_3.origin = var_3.ground_origin;
    var_5[0].origin = var_3.ground_origin - (0, 0, 0.5);
  }

  var_5[0] setModel(level.flagmodel[var_0]);
  var_5[0] setasgametypeobjective();
  var_5[0] setteaminhuddatafromteamname(var_1);
  var_8 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_9 = scripts\mp\gameobjects::createcarryobject(var_8, var_3, var_5, (0, 0, 85));
  var_9 scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
  var_9 scripts\mp\gameobjects::setteamusetime("_encstr_ACFC091AE8AB2FCBE15119", level.pickuptime);
  var_9 scripts\mp\gameobjects::setteamusetime("_encstr_88BF06FD784A6393", level.returntime);
  var_9 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_9 scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60);
  var_9 scripts\mp\objidpoolmanager::objective_set_play_intro(var_9.objidnum, 0);
  var_9 scripts\mp\objidpoolmanager::objective_set_play_outro(var_9.objidnum, 0);
  var_9 scripts\mp\gameobjects::_id_12B13(::player_infil_already_played);
  var_9.allowweapons = 1;
  var_9._id_1214B = var_8;
  var_9.onpickup = ::onpickup;
  var_9.onpickupfailed = ::onpickup;
  var_9.ondrop = ::ondrop;
  var_9.onreset = ::onreset;
  var_9.tv_station_gas_rise = 1;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 60.0;
        break;
      case 1:
        var_9.objidpingfriendly = 0;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 0.05;
        break;
      case 2:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 1.0;
        break;
      case 3:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 1.5;
        break;
      case 4:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 2.0;
        break;
      case 5:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 3.0;
        break;
      case 6:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 4.0;
        break;
    }

    var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    var_9.pingobjidnum = var_10;
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "_encstr_8267056410C669", var_9.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_10, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_10, 0);
    var_9 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99", var_10);
    objective_setownerteam(var_10, var_0);
    var_9 scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60, var_10);
  } else {
    var_9.objidpingfriendly = 1;
    var_9.objidpingenemy = 0;
    var_9.objpingdelay = 3.0;
  }

  var_9.oldradius = var_3.radius;
  var_11 = var_3.origin + (0, 0, 32);
  var_12 = var_3.origin + (0, 0, -32);
  var_13 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_14 = [];
  var_15 = scripts\engine\trace::ray_trace(var_11, var_12, var_14, var_13);
  var_9.baseeffectpos = var_9.visuals[0].origin;
  var_16 = anglestoup(var_9.visuals[0].angles);
  var_9.baseeffectforward = anglesToForward(var_16);
  level.teamflagbases[var_0] = createteamflagbase(var_0, var_9);
  return var_9;
}

player_infil_already_played(var_0) {
  return !var_0 scripts\cp_mp\utility\player_utility::isinvehicle();
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
  var_6 scripts\mp\gameobjects::allowuse("_encstr_ACFC091AE8AB2FCBE15119");
  var_6 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_6 scripts\mp\gameobjects::_id_1317F(level.icondefendflag, level.iconcaptureflag, level._id_11C60);
  var_6 scripts\mp\gameobjects::setusetime(0);
  var_6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var_0)[0]]);
  var_6.onuse = ::onuse;
  var_6.oncantuse = ::oncantuse;
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
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.droppedteam)) {
    if(self.droppedteam == var_0.team) {
      scripts\mp\gameobjects::setownerteam(self.droppedteam);
      var_3 = self.droppedteam;
    } else {
      scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_0.team)[0]);
      var_3 = self.droppedteam;
    }

    self.droppedteam = undefined;
  }

  var_4 = var_0.pers["_encstr_8AEF05472BC2D6"];

  if(var_4 == "_encstr_9A8507BA4040188D08")
    var_5 = "_encstr_8E8405EA382B2A";
  else
    var_5 = "_encstr_9A8507BA4040188D08";

  if(var_4 != var_3) {
    if(isDefined(level.closecapturekiller[var_0.team]) && level.closecapturekiller[var_0.team] == var_0)
      var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_8FAD0ECDB06437611BA30FCF33B8D8ED");

    level.closecapturekiller[var_0.team] = undefined;
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8B040C3941CBB0971BEA2B158058");

    if(level.codcasterenabled)
      level.capzones[var_0.team] scripts\mp\gameobjects::_id_12C75();

    thread returnflag();
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_AD620BCF8E92F1DBC5B8552DB5", var_0.origin);
    scripts\mp\utility\print::printandsoundoneveryone(var_4, scripts\mp\utility\game::getotherteam(var_4)[0], undefined, undefined, "_encstr_AD9C10802BB708257A01F675A3E34D50F513", "_encstr_AD9C10802BB708257A01F675A3E34D50F513", var_0);
    scripts\mp\utility\dialog::leaderdialog("_encstr_8559141F553552F981B9753EB1A93A6A15CBDBBB3BED", var_5, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_855C0E99B185CEEB9C9547AE39B9CA32", var_4, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\game::setmlgannouncement(18, var_0.team, var_0 getentitynumber());
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_A9F70806677BD37B5EE7", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A9F70806677BD37B5EE7", var_0.pers["_encstr_A9F70806677BD37B5EE7"]);

    if(isPlayer(var_0))
      var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_A9F70806677BD37B5EE7"]);

    if(self._id_1214B == "_encstr_9A8507BA4040188D08")
      setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);
    else
      setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_4]))
      var_0 thread applyflagcarrierclass();
    else
      var_0 attachflag();

    var_0 scripts\mp\utility\stats::incpersstat("_encstr_A17908687A36275B3B73", 1);
    level.closecapturekiller[var_5] = undefined;

    if(self._id_1214B == "_encstr_9A8507BA4040188D08")
      setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", var_0 getentitynumber());
    else
      setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", var_0 getentitynumber());

    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 1);

    if(isDefined(level.showenemycarrier)) {
      if(level.showenemycarrier == 0)
        scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
      else {
        scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
        objective_state(self.pingobjidnum, "_encstr_AF5A081BBAC993AC73A3");
        scripts\mp\gameobjects::updatecompassicon("_encstr_88BF06FD784A6393", self.pingobjidnum);
        objective_icon(self.pingobjidnum, "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36");
        scripts\mp\objidpoolmanager::_id_11F7D(self.pingobjidnum, 1);
      }
    }

    scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60);

    if(level.capturecondition == 0)
      level.capzones[var_5] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

    level.capzones[var_5] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    level.capzones[var_5] scripts\mp\gameobjects::_id_13172(level._id_11C5F);
    scripts\mp\utility\print::printandsoundoneveryone(var_4, var_5, undefined, undefined, "_encstr_A9270D032BDE1829E38E33C7DB0D26", "_encstr_A72E13B6C1F5AC3756ADBCFADB899AEBE885DA2B9B", var_0);
    scripts\mp\utility\dialog::leaderdialog("_encstr_BD4A11FA601D07E8410DA4B11719F37FB2B9C2", var_4);
    scripts\mp\utility\dialog::leaderdialog("_encstr_8BCD0DC83AA6CFEE97752D2E49BF50", var_5);
    thread scripts\mp\hud_util::teamplayercardsplash("_encstr_9A041398929D516047EC3094DC3F293184DAA0A01B", var_0);

    if(!isDefined(self.previouscarrier) || self.previouscarrier != var_0)
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BD130A5D809EB9A92F6B2169");

    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
    self.previouscarrier = var_0;

    if(level.codcasterenabled)
      var_0 setgametypevip(1);

    var_0 thread superabilitywatcher();
  }
}

onpickupfailed(var_0) {
  return;
}

returnflag() {
  scripts\mp\gameobjects::returnhome();
}

ondrop(var_0) {
  if(isDefined(var_0.leaving_team)) {
    self.droppedteam = var_0.leaving_team;
    var_0.leaving_team = undefined;
  } else if(!isDefined(var_0))
    self.droppedteam = self._id_1214B;
  else
    self.droppedteam = var_0.team;

  if(isDefined(var_0))
    var_0 _id_13FFA();

  scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(self.droppedteam)[0]);
  var_1 = self.droppedteam;
  var_2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  objective_state(self.pingobjidnum, "_encstr_8267056410C669");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::_id_1317F(level.iconreturnflag, level.iconcaptureflag, level._id_11C60);
  else {
    scripts\mp\gameobjects::_id_1317F(level.icondefendflag, level.iconcaptureflag, level._id_11C60);
    scripts\mp\objidpoolmanager::_id_11F7D(self.objidnum, 1);
  }

  if(self._id_1214B == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -1);
  else
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -1);

  if(isDefined(var_0))
    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);

  var_3 = self.visuals[0] gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0))
      var_0.carryobject.previouscarrier = undefined;

    if(isDefined(var_0.carryflag))
      var_0 detachflag();

    scripts\mp\utility\print::printandsoundoneveryone(var_2, "_encstr_8BBA05185F8B99", undefined, undefined, "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", "_encstr_B40101", var_0);

    if(level.codcasterenabled)
      var_0 setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);

  scripts\mp\utility\dialog::leaderdialog("_encstr_8C11138710F0B5436005733F7F08DAE2F87B7A0FC9", self._id_1214B, "_encstr_A16D07532531CB4BF7");
  scripts\mp\utility\dialog::leaderdialog("_encstr_BE8F0DE7A1DA2CB7E2D0AF8A028179", scripts\mp\utility\game::getotherteam(self._id_1214B)[0], "_encstr_A16D07532531CB4BF7");

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
  if(isDefined(self.droppedteam))
    scripts\mp\gameobjects::setownerteam(self.droppedteam);

  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  self.droppedteam = undefined;
  scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(self._id_1214B == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_864C1163E1519845E381A1E84ACFE8303049F7", -2);
  else
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);

  level.capzones[var_1] scripts\mp\gameobjects::allowuse("_encstr_ACFC091AE8AB2FCBE15119");
  level.capzones[var_1] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.capzones[var_1] scripts\mp\gameobjects::_id_1317F(level.icondefendflag, level.iconcaptureflag, level._id_11C60);
  self.previouscarrier = undefined;
}

onuse(var_0) {
  if(!level.gameended) {
    if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }
    var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];

    if(var_1 == "_encstr_9A8507BA4040188D08")
      var_2 = "_encstr_8E8405EA382B2A";
    else
      var_2 = "_encstr_9A8507BA4040188D08";

    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
    scripts\mp\utility\dialog::leaderdialog("_encstr_A121140B7B9271CB8F4F50C937A718BF1BFBD3ADCF2A", var_1, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_B2390E02E8D7F7B968BBF0FC7B08FF23", var_2, "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\game::setmlgannouncement(17, var_0.team, var_0 getentitynumber());
    objective_state(level.teamflags[var_2].pingobjidnum, "_encstr_8267056410C669");
    var_0 _id_13FFA();
    thread scripts\mp\hud_util::teamplayercardsplash("_encstr_967F14610EC5C907153BF1724148102977B3153B9365", var_0);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_AFEF0D96D9C1773127D0D38B685DF7");
    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_95780D2DAF2BE7E9205BFBFE8F42DB");
    var_0 notify("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_B1CF098D5838A3D5C95623");
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_0.origin);

    if(level.codcasterenabled)
      var_0 setgametypevip(0);

    var_0 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

    if(isPlayer(var_0))
      var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\print::printandsoundoneveryone(var_1, var_2, undefined, undefined, "_encstr_82C6102771207AEAD096AE366BF8256385E1", "_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39", var_0);

    if(isDefined(var_0.carryflag))
      var_0 detachflag();

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1]))
      var_0 thread removeflagcarrierclass();

    level.closecapturekiller[var_1] = undefined;
    level.closecapturekiller[var_2] = undefined;

    if(level.codcasterenabled)
      level.capzones[var_2] scripts\mp\gameobjects::_id_12C75();

    level.teamflags[var_2] returnflag();
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
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

superabilitywatcher() {
  self notify("_encstr_BDD60DCDABC12BE45D0BD136A12B4E");
  self endon("_encstr_BDD60DCDABC12BE45D0BD136A12B4E");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(var_0 == "_encstr_9A8507BA4040188D08")
    var_1 = "_encstr_8E8405EA382B2A";
  else
    var_1 = "_encstr_9A8507BA4040188D08";

  level.teamflags[var_1] endon("_encstr_88F20627959BCAE8");

  for(;;) {
    self waittill("_encstr_97E30E6EAB1CCA93D76EE816E4479591");
    var_2 = level.teamflags[var_1];

    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = self.super;

    switch (var_3.staticdata.ref) {
      case "_encstr_95520DE37BEF4F42190D958FD3780F":
        scripts\engine\utility::_id_143A5("_encstr_A70C11FBDB18F112183BD3709A1B62A6D0FF3A", "_encstr_AF260FA86AE39388DB0FEEE50BFFD16F4A");
        var_2 thread scripts\mp\gameobjects::setdropped();
        return;
    }
  }
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

oncantuse(var_0) {}

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
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_B4010DC6B0394E2D95C9D7D62DD8B1");
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
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_A3B80D06F148AA427D2DEF1F6991AB", 1);
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_852F09FA41FB7ADB3968C4");
      scripts\mp\utility\game::setmlgannouncement(20, var_1.team, var_1 getentitynumber());
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
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_BADE092C37DC5857B1A337", 1);
      } else if(var_15) {
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
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
  _id_13FF9();
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

removeflag() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");

      if(var_0 == "_encstr_B20703DFCF")
        var_1 = "_encstr_9A8507BA4040188D08";
      else
        var_1 = "_encstr_8E8405EA382B2A";

      if(var_1 == "_encstr_9A8507BA4040188D08") {
        if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
          var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
        else
          var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
      } else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
        var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
      else
        var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

      level.teamflags[var_1].trigger notify("_encstr_8DD610AD1F709FB77CF90AB2EDC6AB571BC1");
      level.teamflags[var_1] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      level.teamflags[var_1].trigger = undefined;
      level.teamflags[var_1] notify("_encstr_8BE208E31FA8E1631D65");
      level.teamflags[var_1].visuals[0] delete();
      level.teamflagbases[var_1] delete();
      level.capzones[var_1] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      level.capzones[var_1].trigger = undefined;
      level.capzones[var_1] notify("_encstr_8BE208E31FA8E1631D65");

      foreach(var_3 in level.players)
      var_3 player_delete_flag_goal_fx(var_1);

      level.teamflags[var_1].visibleteam = "_encstr_8BBA05185F8B99";
      level.teamflags[var_1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.capzones[var_1].visibleteam = "_encstr_8BBA05185F8B99";
      level.capzones[var_1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.teamflags[var_1] = undefined;
      setdynamicdvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");
    }

    wait 1;
  }
}

placeflag() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");

      if(var_0 == "_encstr_B20703DFCF")
        var_1 = "_encstr_9A8507BA4040188D08";
      else
        var_1 = "_encstr_8E8405EA382B2A";

      if(var_1 == "_encstr_9A8507BA4040188D08") {
        if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
          var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
        else
          var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
      } else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
        var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
      else
        var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

      var_2 = undefined;
      var_2 = spawnStruct();
      var_2 dev_flag_find_ground();
      var_2.origin = var_2.ground_origin;
      var_2.radius = 30;
      var_2.team = var_1;
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin, 0, 30, 80);
      var_4[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
      var_4[0] setModel(level.flagmodel[var_1]);
      var_5 = scripts\mp\gameobjects::createcarryobject(var_1, var_3, var_4, (0, 0, 85));
      var_5 scripts\mp\gameobjects::setteamusetext("_encstr_88BF06FD784A6393", &"_encstr_936A11A62879A32950900929278E7D19C414A3");
      var_5 scripts\mp\gameobjects::setteamusetext("_encstr_ACFC091AE8AB2FCBE15119", &"_encstr_A6C0122563BE8207F1ADD66D20F851FF6C2987B7");
      var_5 scripts\mp\gameobjects::allowcarry("_encstr_88BF06FD784A6393");
      var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
      var_5 scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60);
      var_5.objidpingfriendly = 1;
      var_5.allowweapons = 1;
      var_5.onpickup = ::onpickup;
      var_5.onpickupfailed = ::onpickup;
      var_5.ondrop = ::ondrop;
      var_5.onreset = ::onreset;
      var_5.oldradius = var_3.radius;
      var_5.origin = var_2.origin;
      var_5.label = var_1;
      var_5.previouscarrier = undefined;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\engine\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_5.baseeffectpos = var_10["_encstr_BD260953AA97E3F014279D"];
      var_11 = vectortoangles(var_10["_encstr_820E07FAE8780B3A4C"]);
      var_5.baseeffectforward = anglesToForward(var_11);
      level.teamflagbases[var_1] = createteamflagbase(var_1, var_5);

      if(var_1 == "_encstr_9A8507BA4040188D08") {
        if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
          level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_5;
        else
          level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_5;
      } else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
        level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_5;
      else
        level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_5;

      var_4 = [];
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin - (0, 0, var_2.radius / 2), 0, var_2.radius, 80);
      var_3.no_moving_platfrom_unlink = 1;
      var_3.linktoenabledflag = 1;
      var_3.baseorigin = var_3.origin;
      var_12 = scripts\mp\gameobjects::createuseobject(var_1, var_3, var_4, (0, 0, 115));
      var_12 scripts\mp\gameobjects::allowuse("_encstr_ACFC091AE8AB2FCBE15119");
      var_12 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      var_12 scripts\mp\gameobjects::_id_1317F(level.icondefendflag, level.iconcaptureflag, level._id_11C60);
      var_12 scripts\mp\gameobjects::setusetime(0);
      var_12 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var_1)[0]]);
      level.capzones[scripts\mp\utility\game::getotherteam(var_1)[0]] scripts\mp\gameobjects::setkeyobject(var_5);
      var_12.onuse = ::onuse;
      var_12.oncantuse = ::oncantuse;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\engine\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_11 = vectortoangles(var_10["_encstr_820E07FAE8780B3A4C"]);
      var_13 = anglesToForward(var_11);
      var_14 = anglestoright(var_11);

      if(var_1 == "_encstr_9A8507BA4040188D08") {
        if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
          level.capzones[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_12;
        else
          level.capzones[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_12;
      } else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
        level.capzones[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_12;
      else
        level.capzones[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_12;

      setdynamicdvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
    }

    wait 1;
  }
}

dev_flag_find_ground() {
  var_0 = level.players[0].origin + (0, 0, 32);
  var_1 = level.players[0].origin + (0, 0, -1000);
  var_2 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_3 = [];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, var_3, var_2);
  self.ground_origin = var_4["_encstr_BD260953AA97E3F014279D"];
  return var_4["_encstr_A53009A25003666B9818C6"] != 0 && var_4["_encstr_A53009A25003666B9818C6"] != 1;
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8E1D12A77FE20B1D13C8F359B87117FF18D33424", 2, "_encstr_88BF06FD784A6393", "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E", "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BEA8161BF0472BD82920DBE7AB513E3F8EC07E117E6031EF", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B89220350AD792937482D4A2F5F49CC4B2E59E9052D749A20D9EAC5449FAD050A06A", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BD2E15FB09E850EAA3CDDB7F3356D2B7583379078D700F", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_922D1337B98850786F22335EEB2722A0A916B99327", 2, "_encstr_88BF06FD784A6393", "_encstr_A5D31DA9A0BE92397414D48A7DF4E413CA79D309947DA882A52ABE3414054D", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_92BB1560CA8001084F9ECD506C87D1E3AD02A950B2DE57", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_87C218EE16E583DE4B9BD1FADA369D7D59D60EA3F2D7CCD8C23B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A9BD2232E835875688F1455A8F709EEF68860B9AB2977F8C98E94753A150A90F01DBB383", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AB8717DDC22F0EF62DE6D1AF5B1B9DBECCAB63B1F53363853B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_866E21D8C5AF0E0B1F8BA80E074B27A03090A3035720F8E0762BD88743CCAF5FD7C5EB", 0);
}

_id_13FFA() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 37);
}

_id_13FF9() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 38);
}