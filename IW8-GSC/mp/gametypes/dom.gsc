/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\dom.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_8218041DF5FA", 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.lastcaptime = gettime();
  level.onobjectivecomplete = ::onflagcapture;

  if(level.numflagsscoreonkill)
    thread updatescoremod();

  level.domflag_setneutral = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral;
  level.dompoint_setcaptured = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_setcaptured;
  level.onflagcapture = ::onflagcapture;
  level.gamemodegesturecalloutassign = ::assigngamemodecallout;
  level.gamemodegesturecalloutverify = ::verifygamemodecallout;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.playholdtwovo = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83CC14D916B69547BCC1567D19EDADB4371647D27BCD";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_81650A7E0898939B78197777";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_81650A7E0898939B78197777";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7270B37CAC6BA4E96CD76BE2C"] = "_encstr_A7270B37CAC6BA4E96CD76BE2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB270BF3CD11AFEAA31812A940"] = "_encstr_AB270BF3CD11AFEAA31812A940";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99270B0B3F0BC056E2C34F371F"] = "_encstr_99270B0B3F0BC056E2C34F371F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91270B68A22E13B3A766BCB844"] = "_encstr_91270B68A22E13B3A766BCB844";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F270B380596131AEB68C8A788"] = "_encstr_8F270B380596131AEB68C8A788";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7010A03FD5FFFE3521A09C8"] = "_encstr_A7010A03FD5FFFE3521A09C8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B010A0FFD30CD6AE50956EB"] = "_encstr_9B010A0FFD30CD6AE50956EB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99010A734743881E7AA38787"] = "_encstr_99010A734743881E7AA38787";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B010A9BC5CF20CDF9FAE19D"] = "_encstr_8B010A9BC5CF20CDF9FAE19D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83010ACD591B5DC959C87D56"] = "_encstr_83010ACD591B5DC959C87D56";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDC098D7BCD96DC76FA2C"] = "_encstr_9BDC098D7BCD96DC76FA2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83DC0901B70A98F85731F1"] = "_encstr_83DC0901B70A98F85731F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BDC0955A0D021A28C87BF"] = "_encstr_8BDC0955A0D021A28C87BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93DC09C6F637B437CEEB19"] = "_encstr_93DC09C6F637B437CEEB19";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1DC0929273333A5D46689"] = "_encstr_A1DC0929273333A5D46689";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_AD68071BF6B9A3BE0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976807690FAFEBD7F6"] = "_encstr_976807690FAFEBD7F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA68071BD0C3C4417F"] = "_encstr_AA68071BD0C3C4417F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A66807089AB2999EEB"] = "_encstr_A66807089AB2999EEB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B26807A5E0B3C99E27"] = "_encstr_B26807A5E0B3C99E27";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_966911714585885B197F3BE1DB43262B5C9113"] = "_encstr_91BB11B1C21CD1BA2759327D8CBECADCACB62F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A7C145C8D088D7088502087026ED7C3F7D34AC14722"] = "_encstr_830D146CC283A3BA9C5646F564AF99E496B2B98CD897";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391"] = "_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADEB153721758558B118E452917348D0D33C50409BBE91"] = "_encstr_ADEB153721758558B118E452917348D0D33C50409BBE91";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_851C18B39F361708BF2AD1BAB24190EE70B7031B8ACBC993DB0D", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA"));
  setdynamicdvar("_encstr_A56A1D8FFE7E3E14E03936F06D8E5896753552F3D8831AD183AA6AE67ACBE7", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_8BB015CC36583BE6A495C5AED2C99546A2F69A36ED9CCA"));
  setdynamicdvar("_encstr_A33316C06AC2DFE9D71DD847E73750416AC1F870901DDBC1", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_BA150E0BDD617835235BEBCD2BFAF768"));
  setdynamicdvar("_encstr_A1821BAB2FD31FF10F983772F4B9C965053D53935119A822D2CBDF4082", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60"));
  setdynamicdvar("_encstr_82651C9BD839EB46DBADBEDCAEDA641BB0D9DC6A1BDEC9CAE9CD96A5D8C6", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_813614C07352A6316B87B7D13FF728B02C383CEAE578"));
  setdynamicdvar("_encstr_B22B12B812BA97A18F5590F032F30FB7264A9038", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_86FA0ABD89A6D41B85630BC9"));
  setdynamicdvar("_encstr_86F815CD8D27D723BD6BFAC13959860B07057BD2DCD1DC", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_82730D3B68514312E927CD4410D90B"));
  setdynamicdvar("_encstr_B69914CDC627F5467BDAAF360BC1D157E45645E5E095", getmatchrulesdata("_encstr_8C2E0C7708EF6DE58B29E13B7557", "_encstr_A5B60CF9DFD99DEB337D3193BF2F"));
  setdynamicdvar("_encstr_BED4157E1EE37F31D70751B81FE00B934B076D8DF60AFB", getmatchrulesdata("_encstr_8C2E0C7708EF6DE58B29E13B7557", "_encstr_87940DB10BE0D1D5E42B88ACC616E5"));
  setdynamicdvar("_encstr_ABE611A08802495777D28EE8CE910EEBA38385", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8218041DF5FA", 0);
}

seticonnames() {
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.icondefending = "_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
}

onstartgametype() {
  seticonnames();

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_964615086EAD9DA5BF6883B71B556D601C7F9141DFB9ED");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_B404149E2125A8685125958A6A5E11D335F509299C2A");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(level.scoremod["_encstr_ABD70578F3D02C"] > 0) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
  }

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_3 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_4 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_4;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_3;
  }

  initspawns();
  thread domflags();
  thread updatedomscores();
  thread removedompoint();
  thread placedompoint();
  _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::inittankspawns();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 10, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("_encstr_8BB015CC36583BE6A495C5AED2C99546A2F69A36ED9CCA", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA150E0BDD617835235BEBCD2BFAF768", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("_encstr_82730D3B68514312E927CD4410D90B", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("_encstr_87940DB10BE0D1D5E42B88ACC616E5", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("_encstr_A5B60CF9DFD99DEB337D3193BF2F", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("_encstr_813614C07352A6316B87B7D13FF728B02C383CEAE578", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86FA0ABD89A6D41B85630BC9", 4, 1, 10);
}

initspawns() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_973807485A3B8A88D4", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  else if(istrue(level.binoculars_clearuidata))
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A1580B11DE5B5A9B0BA35AEDCD", "_encstr_829A0D0F1AF8FB5ED127855073F940");

  if(getdvarint("_encstr_8BF21B436895B9F749E93D0FFD53A7FAF90B8B0A4003AD37E14D092718", 0) == 1) {
    level.gamemodestartspawnpointnames = [];
    level.gamemodestartspawnpointnames["_encstr_9A8507BA4040188D08"] = "_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B";
    level.gamemodestartspawnpointnames["_encstr_8E8405EA382B2A"] = "_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B";
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["_encstr_9A8507BA4040188D08"] = "_encstr_92A00D235071922868E7FBEB2148FB";
    level.gamemodespawnpointnames["_encstr_8E8405EA382B2A"] = "_encstr_92A00D235071922868E7FBEB2148FB";
  }

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_92A00D235071922868E7FBEB2148FB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_92A00D235071922868E7FBEB2148FB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_92A00D235071922868E7FBEB2148FB");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8218041DF5FA", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_B15C0DC47FC871331F387AE2E1664F", var_3);

  if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = getteamdompoints(var_0);
  var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_3 = getteamdompoints(var_2);
  var_4 = getpreferreddompoints(var_1, var_3, var_0, var_2);
  var_5 = [];
  var_5["_encstr_A57C1399B32A4CA8FA123911B7DFD0EF22472DE9DF"] = var_4["_encstr_95830AC1C9CACCCAC939CAC8"];
  var_5["_encstr_BA38137FA7A6E765EDA628911497B859DF983A1137"] = var_4["_encstr_AC8F0AE74163F85AAA380AD8"];

  if(istrue(level.binoculars_clearuidata)) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
        var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
      } else {
        scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
        var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
      var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
    }
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7", undefined, var_5);
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207", undefined, var_5);
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_8218041DF5FA");
    var_6 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_8218041DF5FA", "_encstr_B15C0DC47FC871331F387AE2E1664F", undefined, var_5);
  }

  return var_6;
}

getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

getpreferreddompoints(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_0.size == level.objectives.size) {
    var_5 = level.bestspawnflag[var_3];

    foreach(var_7 in var_0) {
      if(var_7 != var_5)
        var_4[var_4.size] = var_7;
    }
  } else if(var_0.size > 0) {
    foreach(var_7 in var_0)
    var_4[var_4.size] = var_7;
  } else if(var_0.size == 0) {
    var_11 = level.bestspawnflag[var_2];

    if(var_1.size > 0 && var_1.size < level.objectives.size)
      var_11 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart(var_2);

    var_4[var_4.size] = var_11;
  }

  var_12 = 0;
  var_13 = 0;

  foreach(var_7 in var_4) {
    if(var_7 scripts\mp\gameobjects::getclaimteam() == "_encstr_8BBA05185F8B99") {
      var_12 = var_12 | var_7.spawnflagid;
      continue;
    }

    var_13 = var_13 | var_7.spawnflagid;
  }

  if(var_12 & 1 && var_12 & 2)
    var_12 = var_12 | 32;

  if(var_12 & 4 && var_12 & 2)
    var_12 = var_12 | 64;

  if(var_12 & 1 && var_12 & 4)
    var_12 = var_12 | 128;

  var_16 = [];
  var_16["_encstr_95830AC1C9CACCCAC939CAC8"] = var_12;
  var_16["_encstr_AC8F0AE74163F85AAA380AD8"] = var_13;
  return var_16;
}

domflags() {
  var_0 = [];
  level.changenumdomflags = 0;

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_1 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level.localeid) {
        var_0[var_0.size] = var_3;
        continue;
      }

      var_3 delete();
    }
  } else {
    level.changenumdomflags = getdvarint("_encstr_96BB12ABF20B10986DDD176DF4D6B8C6D70B80B3", 0);
    var_0 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  var_5 = getEntArray("_encstr_B40B0FA771DFC427F7DB8BD0FDB4F90ED8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size + var_5.size < 2) {
    return;
  }
  if(level.changenumdomflags == 3)
    setomnvar("_encstr_85511125C469453BFDF7A07BC737918952EF9E", level.changenumdomflags);
  else
    setomnvar("_encstr_85511125C469453BFDF7A07BC737918952EF9E", var_0.size);

  var_6 = [];

  for(var_7 = 0; var_7 < var_0.size; var_7++)
    var_6[var_6.size] = var_0[var_7];

  for(var_7 = 0; var_7 < var_5.size; var_7++)
    var_6[var_6.size] = var_5[var_7];

  if(level.changenumdomflags == 3 || level.mapname == "_encstr_9B8808AD1CD7E457DC1D") {
    foreach(var_9 in var_6)
    var_9 remapdomtriggerscriptlabel();
  }

  foreach(var_9 in var_6) {
    if(level.changenumdomflags == 3) {
      if(var_9.script_label == "_encstr_A2070318DC" || var_9.script_label == "_encstr_950703EBCA")
        continue;
    }

    _id_11CA0(var_9);
    var_12 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_9, undefined, 1, 1);
    level.objectives[var_12.objectivekey] = var_12;
  }

  var_14 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  var_15 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  level.startpos["_encstr_9A8507BA4040188D08"] = var_15[0].origin;
  level.startpos["_encstr_8E8405EA382B2A"] = var_14[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["_encstr_9A8507BA4040188D08"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_9A8507BA4040188D08", undefined);
  level.bestspawnflag["_encstr_8E8405EA382B2A"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_8E8405EA382B2A", level.bestspawnflag["_encstr_9A8507BA4040188D08"]);
  flagsetup();
  thread modifieddefendradiussetup();

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  foreach(var_3 in level.objectives) {
    var_17 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getreservedobjid(var_3.objectivekey);
    var_3 scripts\mp\gameobjects::requestid(1, 1, var_17);
    var_3.onuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse;
    var_3.onbeginuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin;
    var_3.onuseupdate = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseupdate;
    var_3.onenduse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend;
    var_3.oncontested = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested;
    var_3.onuncontested = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested;
    var_3.onunoccupied = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onunoccupied;
    var_3.onpinnedstate = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onpinnedstate;
    var_3.onunpinnedstate = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onunpinnedstate;
    var_3.stompprogressreward = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_stompprogressreward;
    var_3 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");
    var_3 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_3 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral(undefined, 1);
  }

  if(level.precappoints)
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::precap();

  if(level.codcasterenabled)
    thread _id_1402B();
}

_id_11CA0(var_0) {
  switch (level.mapname) {
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      switch (var_0.script_label) {
        case "_encstr_B20703DFCF":
          var_0.origin = (983, 303, 110);
          break;
        case "_encstr_B40703E96D":
          var_0.origin = (-1064, -525, 110);
          break;
        case "_encstr_B6070359BA":
          var_0.origin = (-1605, -2298, 60);
          break;
      }

      break;
    case "_encstr_82740C4F78166D12D1B3CA0495DD":
      if(level._id_11AD3) {
        switch (var_0.script_label) {
          case "_encstr_B20703DFCF":
            var_0.origin = (-520, 632.25, 16);
            break;
        }
      }

      break;
  }
}

remapdomtriggerscriptlabel() {
  if(level.mapname == "_encstr_93FB0A6B1C7D2CB92D5EB00D" || level.mapname == "_encstr_A2CB0D6B1CBE2CDC4BE5161AAF076B") {
    if(self.script_label == "_encstr_950703EBCA" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_encstr_B6070359BA";
      self.remappedscriptlabel = 1;
    } else if(self.script_label == "_encstr_B6070359BA" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_encstr_950703EBCA";
      self.remappedscriptlabel = 1;
    }
  } else if(level.mapname == "_encstr_9B8808AD1CD7E457DC1D") {
    if(self.script_label == "_encstr_B20703DFCF")
      self.script_label = "_encstr_B40703E96D";
    else if(self.script_label == "_encstr_B40703E96D")
      self.script_label = "_encstr_B20703DFCF";
  }
}

updatedomscores() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(!level.gameended) {
    var_2 = 5.0;
    var_3 = scripts\mp\gamelogic::gettimeremaining();

    if(var_3 < 5000 && var_3 > 0)
      var_2 = var_3 / 1000;

    wait(var_2);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_4 = getowneddomflags();

    if(!isDefined(level.scoretick))
      level.scoretick = [];

    foreach(var_6 in level.teamnamelist)
    level.scoretick[var_6] = 0;

    if(var_4.size) {
      for(var_8 = 1; var_8 < var_4.size; var_8++) {
        var_9 = var_4[var_8];
        var_10 = gettime() - var_9.capturetime;

        for(var_11 = var_8 - 1; var_11 >= 0 && var_10 > gettime() - var_4[var_11].capturetime; var_11--)
          var_4[var_11 + 1] = var_4[var_11];

        var_4[var_11 + 1] = var_9;
      }

      foreach(var_9 in var_4) {
        var_13 = var_9 scripts\mp\gameobjects::getownerteam();
        var_0 = getteamscore(var_13);
        var_14 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_13);

        if(var_14 >= level.flagsrequiredtoscore)
          level.scoretick[var_13] = level.scoretick[var_13] + level.pointsperflag;
      }
    }

    updatescores();
    checkendgame(var_4.size);
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

  var_5 = scripts\mp\gamescore::freight_lift_door_switch();

  foreach(var_2 in level.teamnamelist) {
    if(level.scoretick[var_2] > 0)
      scripts\mp\gamescore::giveteamscoreforobjective(var_2, level.scoretick[var_2], 1, undefined, 1);
  }

  var_8 = scripts\mp\gamescore::freight_lift_door_switch();

  if(var_5 != var_8)
    scripts\mp\gamescore::_id_12762(var_8, 1, var_5);
}

checkendgame(var_0) {
  var_1 = gettime() - level.lastcaptime;

  if(scripts\mp\utility\game::matchmakinggame() && var_0 < 2 && var_1 > 120000) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A7680E91ED5BAFCCDE278D597D2B9B8C"]);
    return;
  }

  if(level.objectives.size == 3 && level.playholdtwovo && var_1 > 30000) {
    foreach(var_3 in level.teamnamelist) {
      if(_encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_3) == 2) {
        var_4 = scripts\mp\utility\game::getotherteam(var_3)[0];
        scripts\mp\utility\dialog::statusdialog("_encstr_966911714585885B197F3BE1DB43262B5C9113", var_4);
        scripts\mp\utility\dialog::statusdialog("_encstr_8A7C145C8D088D7088502087026ED7C3F7D34AC14722", var_3);
        level.playholdtwovo = 0;
        break;
      }
    }
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level.teamscoresonkill[var_1.team])
    _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(var_2 scripts\mp\gameobjects::getownerteam() != "_encstr_A7A408B9CA5D1D4E2C63" && isDefined(var_2.capturetime))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(var_1 in level.objectives)
  var_1.spawnflagid = getflagspawnidforobjectivekey(var_1.objectivekey);

  var_3 = level.spawnpoints;

  foreach(var_5 in var_3)
  var_5.scriptdata.domflagassignments = getspawnpointflagassignment(var_5);
}

getflagspawnidforobjectivekey(var_0) {
  switch (var_0) {
    case "_encstr_B20703DFCF":
      return 1;
    case "_encstr_B40703E96D":
      return 2;
    case "_encstr_B6070359BA":
      return 4;
    case "_encstr_A2070318DC":
      return 8;
    case "_encstr_950703EBCA":
      return 16;
  }

  return undefined;
}

getspawnpointflagassignment(var_0) {
  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(var_0.script_noteworthy == "_encstr_A34C02BB" || var_0.script_noteworthy == "_encstr_A74C0222" || var_0.script_noteworthy == "_encstr_A14C023B")
      var_0.script_noteworthy = "_encstr_B40101";
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "_encstr_B40101" && var_0.script_noteworthy != "_encstr_8A1804CF18C5" && var_0.script_noteworthy != "_encstr_B27706C1CF833659") {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_1 = parseflagassignmentstring(var_0.script_noteworthy);

      if(isDefined(var_1))
        return var_1;
    }
  }

  var_2 = findnearestdompoint(var_0.origin);
  return var_2.spawnflagid;
}

parseflagassignmentstring(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "_encstr_994C023A":
      return 1;
    case "_encstr_8B4C024C":
      return 2;
    case "_encstr_834C02D8":
      return 4;
    case "_encstr_A14C02D1":
      return 8;
    case "_encstr_934C02B2":
      return 16;
    case "_encstr_A10703AAA1":
    case "_encstr_8D07032C89":
      return 32;
    case "_encstr_AB0703988D":
    case "_encstr_AC0703773B":
      return 64;
    case "_encstr_A307038747":
    case "_encstr_AF070319EE":
      return 128;
    default:
      break;
  }
}

findnearestdompoint(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_3.navmeshpos = getclosestpointonnavmesh(var_3.trigger.origin);
    var_1[var_1.size] = var_3.navmeshpos;
  }

  var_5 = findclosestnonlospointwithinvolume(var_1, getclosestpointonnavmesh(var_0));
  var_6 = undefined;

  if(!isDefined(var_5)) {
    var_7 = undefined;

    foreach(var_3 in level.objectives) {
      var_9 = distancesquared(var_3.trigger.origin, var_0);

      if(!isDefined(var_6) || var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  } else {
    foreach(var_3 in level.objectives) {
      if(distance2dsquared(var_3.navmeshpos, var_5) < 1.0) {
        var_6 = var_3;
        break;
      }
    }
  }

  return var_6;
}

modifieddefendradiussetup() {
  if(level.mapname == "_encstr_86890CB583D73393EDB98E4BB29C") {
    foreach(var_1 in level.objectives) {
      if(var_1.objectivekey == "_encstr_B40703E96D")
        var_1.trigger.modifieddefendcheck = 1;
    }
  }
}

onspawnplayer() {
  thread updatematchstatushintonspawn();
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / scripts\mp\utility\game::getminutespassed();
}

getcapxpscale() {
  if(self.cpm < 4)
    return 1;
  else
    return 0.25;
}

onplayerconnect(var_0) {
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  var_0 thread onplayerspawned();
}

onplayerspawned(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BA350853C128FB939DB9");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["_encstr_B1F7085B03F492AE98DB"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_B1F7085B03F492AE98DB"]);
  }
}

onflagcapture(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.usestartspawns = 0;
  var_6 = undefined;
  var_7 = scripts\mp\utility\game::getotherteam(var_3)[0];

  if(_encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_3) == level.objectives.size)
    var_6 = "_encstr_8A5919A8037FCD80ADAF2539B91739062F9B03D34BCF75C9466429";
  else
    var_6 = "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1";

  thread scripts\mp\utility\print::printandsoundoneveryone(var_3, var_7, undefined, undefined, var_6, "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_2);

  if(_encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_3) < level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.objectivekey, var_3);

    if(isDefined(var_4) && var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_encstr_B6070359BA" || self.objectivekey == "_encstr_A2070318DC") || self.objectivekey == "_encstr_B40703E96D")
        scripts\mp\utility\dialog::statusdialog("_encstr_86AD05B1F6B9A3" + self.objectivekey, var_7);
    } else
      scripts\mp\utility\dialog::statusdialog("_encstr_86AD05B1F6B9A3" + self.objectivekey, var_7);
  } else {
    thread scripts\mp\music_and_dialog::dominating_music(var_3);
    scripts\mp\utility\dialog::statusdialog("_encstr_ADEB153721758558B118E452917348D0D33C50409BBE91", var_3);
    scripts\mp\utility\dialog::statusdialog("_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391", var_7);
  }
}

updatescoremod() {
  wait 1;
  level.onnormaldeath = ::onnormaldeath;
  level.teamscoresonkill = [];

  foreach(var_1 in level.teamnamelist)
  level.teamscoresonkill[var_1] = 0;

  level.scoremod["_encstr_ABD70578F3D02C"] = 1;
}

removedompoint() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");

      foreach(var_2 in level.objectives) {
        if(isDefined(var_2.objectivekey) && var_2.objectivekey == var_0) {
          var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
          var_2.trigger = undefined;
          var_2 notify("_encstr_8BE208E31FA8E1631D65");
          var_2.visibleteam = "_encstr_8BBA05185F8B99";
          var_2 scripts\mp\gameobjects::setobjectivestatusicons(undefined);
          var_3 = [];

          foreach(var_5 in level.objectives) {
            if(var_5.objectivekey != var_0)
              var_3[var_5.objectivekey] = var_5;
          }

          level.objectives = var_3;
          break;
        }
      }

      setdynamicdvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");
    }

    wait 1;
  }
}

placedompoint() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
      var_1 = spawnStruct();
      var_1.origin = level.players[0].origin;
      var_1.angles = level.players[0].angles;
      var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, 120, 128);
      var_1.trigger = var_2;
      var_1.trigger.script_label = var_0;
      var_1.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
      var_3 = var_1.origin + (0, 0, 32);
      var_4 = var_1.origin + (0, 0, -32);
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, undefined, scripts\engine\trace::create_default_contents(1));
      var_1.origin = var_5["_encstr_BD260953AA97E3F014279D"];
      var_1.upangles = vectortoangles(var_5["_encstr_820E07FAE8780B3A4C"]);
      var_1.forward = anglesToForward(var_1.upangles);
      var_1.right = anglestoright(var_1.upangles);
      var_1.visuals[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
      var_1.visuals[0].angles = var_1.angles;
      var_6 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_1.trigger, var_1.visuals, (0, 0, 100));
      var_6 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
      var_6 scripts\mp\gameobjects::setusetime(10);

      if(isDefined(var_2.objectivekey))
        var_6.objectivekey = var_2.objectivekey;
      else
        var_6.objectivekey = var_6 scripts\mp\gameobjects::getlabel();

      if(isDefined(var_2.iconname))
        var_6.iconname = var_2.iconname;
      else
        var_6.iconname = var_6 scripts\mp\gameobjects::getlabel();

      var_6 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconneutral);
      var_6 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      var_6.onuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse;
      var_6.onbeginuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin;
      var_6.onuseupdate = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseupdate;
      var_6.onenduse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend;
      var_6.nousebar = 1;
      var_6.id = "_encstr_87D9083A6F628DDB5F1F";
      var_6.firstcapture = 1;
      var_6.claimgracetime = 10000;
      var_6.decayrate = 50;
      var_3 = var_1.visuals[0].origin + (0, 0, 32);
      var_4 = var_1.visuals[0].origin + (0, 0, -32);
      var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_8 = [];
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, var_8, var_7);
      var_6.baseeffectpos = var_5["_encstr_BD260953AA97E3F014279D"];
      var_9 = vectortoangles(var_5["_encstr_820E07FAE8780B3A4C"]);
      var_6.baseeffectforward = anglesToForward(var_9);
      var_6 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::initializematchrecording();
      var_6 thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
      level.objectives[var_6.objectivekey] = var_6;
      setdynamicdvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
    }

    wait 1;
  }
}

assigngamemodecallout() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = 250000;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  foreach(var_11 in level.objectives) {
    var_12 = vectorNormalize(var_11.trigger.origin - var_0);
    var_13 = vectordot(var_2, var_12);
    var_14 = distancesquared(var_11.trigger.origin, var_0);

    if(!isDefined(var_5) || var_5 < var_13) {
      var_5 = var_13;
      var_7 = var_14;
      var_6 = var_11;
    }

    if(!isDefined(var_8) || var_8 > var_14) {
      var_8 = var_14;
      var_9 = var_11;
    }
  }

  var_11 = undefined;
  var_16 = undefined;
  var_17 = undefined;

  if(isDefined(var_5) && var_5 > var_3) {
    var_11 = var_6;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
      var_16 = self.name + "_encstr_B1F30B9ACA0B69A17B6B169516" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_95EB0866891B23FB85B3";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + "_encstr_BE270B92E989F72B057082CED1" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_A20C07ABF304625E08";
    } else {
      var_16 = self.name + "_encstr_AF760B5217DD0F9BA70B03E508" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_AB3508737F830710ACDB";
    }
  } else if(isDefined(var_8) && var_8 < var_4) {
    var_11 = var_9;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
      var_16 = self.name + "_encstr_B1F30B9ACA0B69A17B6B169516" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_95EB0866891B23FB85B3";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + "_encstr_BE270B92E989F72B057082CED1" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_A20C07ABF304625E08";
    } else {
      var_16 = self.name + "_encstr_AF760B5217DD0F9BA70B03E508" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_AB3508737F830710ACDB";
    }
  }

  if(isDefined(var_11))
    thread scripts\cp_mp\gestures::applygamemodecallout(var_11, var_16, var_17);

  return isDefined(var_11);
}

verifygamemodecallout(var_0, var_1) {
  var_2 = 0;

  switch (var_0) {
    case "_encstr_95EB0866891B23FB85B3":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
    case "_encstr_A20C07ABF304625E08":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
    case "_encstr_AB3508737F830710ACDB":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
  }

  return var_2;
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 27);
}

_id_1402B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(!level.gameended) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      foreach(var_4 in level.objectives) {
        if(var_1 istouching(var_4.trigger) && isalive(var_1)) {
          var_2 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getreservedobjid(var_4.objectivekey) + 1;
          break;
        }
      }

      if(!isDefined(var_1._id_11C62) || var_1._id_11C62 != var_2) {
        var_1 setmlgthirdpersonenabled(var_2);
        var_1._id_11C62 = var_2;
        var_1 setgametypevip(1);
      }

      if(var_2 == 0)
        var_1 setgametypevip(0);
    }

    waitframe();
  }
}