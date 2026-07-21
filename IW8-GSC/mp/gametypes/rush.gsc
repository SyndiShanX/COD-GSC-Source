/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rush.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.lastcaptime = gettime();
  level.capturedecay = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83CC14D916B69547BCC1567D19EDADB4371647D27BCD";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A3210DEE4972B3383AE9B75F0A4D13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A3210DEE4972B3383AE9B75F0A4D13";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_ABBF19B98D27EB275D370DD70B36A3B4B3168EA5F6B922958D0B2F", getmatchrulesdata("_encstr_A9A0094EAB6E3411C2E8B0", "_encstr_A977100B478B7B60B9C3C8ED6D44202132D7"));
  setdynamicdvar("_encstr_A34819F3AA533893D3FB51C7133ED8759713899D533B6F68ECCF55", getmatchrulesdata("_encstr_A9A0094EAB6E3411C2E8B0", "_encstr_8BA01037B0B3B4932D7DC783DE33BB61F850"));
  setdynamicdvar("_encstr_BA2118FA49B07F3BADF7AB7F33D3A3AAC037F4C5216907B285CF", getmatchrulesdata("_encstr_A9A0094EAB6E3411C2E8B0", "_encstr_93B30F804BDCEB63D9CC3935EE82B5F323"));
}

seticonnames() {
  level.iconcapture = "_encstr_8ACE0B630AA199E13B93A848CF";
  level.iconcontested = "_encstr_86130D58EB714FD7382B95DB5BAAD1";
  level.icondefend = "_encstr_9A9F0A40CBE1F1936C357A44";
  level.iconlosing = "_encstr_BECE0A5CFFF78A3F3B10DBF7";
  level.iconneutral = "_encstr_9BB60B3B0F2F0592DB69CBB0CB";
  level.icontaking = "_encstr_95560ABBE1EF1B5B4432D888";
  level.icontarget = "_encstr_971A0AEB3F31A3A8A8E7B278";
}

onstartgametype() {
  seticonnames();

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_85931055A61DD8D31FD1FBBF29589A8147CB");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_85931055A61DD8D31FD1FBBF29589A8147CB");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_AC72164818DAADB514043B953E5D2AE7E709FF07EF5FEBA7");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_8E691557293C076769194EA5F2C88ADB56B8D93C6335C3");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(scripts\mp\utility\game::inovertime()) {
    game["_encstr_976A11E816F72B8134A25001AB4D6FE32FBB6E"] = 0;
    game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"] = 0;
    game["_encstr_991C0AB9ED5B57161FE89B83"] = scripts\engine\utility::ter_op(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0, "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = scripts\engine\utility::ter_op(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

    if(!isDefined(game["_encstr_85ED0E179550E2533320C25888191FDB"]) || !isDefined(game["_encstr_85ED0E179550E2533320C25888191FDB"][game["_encstr_991C0AB9ED5B57161FE89B83"]]))
      game["_encstr_85ED0E179550E2533320C25888191FDB"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = 1.0;

    scripts\mp\utility\game::setovertimelimitdvar(game["_encstr_85ED0E179550E2533320C25888191FDB"][game["_encstr_991C0AB9ED5B57161FE89B83"]]);
  } else {
    game["_encstr_991C0AB9ED5B57161FE89B83"] = scripts\engine\utility::ter_op(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]), "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = scripts\engine\utility::ter_op(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]), "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
  }

  level scripts\mp\gamelogic::enableovertimegameplay();
  initspecatatorcameras();
  thread loopspectatorlocations();
  setupobjectives();
  initspawns();
  thread startgame();
  thread manageovertimestate();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.activationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A977100B478B7B60B9C3C8ED6D44202132D7", 30, 0, 60);
  level.captureduration = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8BA01037B0B3B4932D7DC783DE33BB61F850", 40, 0, 60);
  level.extratimebonus = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_93B30F804BDCEB63D9CC3935EE82B5F323", 60, 0, 300);
}

setupobjectives() {
  var_0 = getEntArray("_encstr_B2820A93D5E6867D33B12CEC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_85541343633E02DF48F836BFB6283E6A16C5B7933B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    return;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    var_2[var_2.size] = var_0[var_3];

  var_4 = [];

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      var_7 = var_6.script_noteworthy;
      var_4[var_7] = var_6;
    }
  }

  foreach(var_6 in var_2) {
    var_7 = var_6.script_noteworthy;

    if(var_7 == "_encstr_934C0218" || var_7 == "_encstr_AC4C024A") {
      continue;
    }
    if(isDefined(var_4[var_7]))
      var_6 = var_4[var_7];

    var_6.objectivekey = var_7;
    var_6 mapobjectiveicon(var_7);
    var_10 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_6);
    var_10 dompoint_ondisableobjective();
    level.objectives[var_10.objectivekey] = var_10;
    var_10.onbeginuse = ::dompoint_onbeginuse;
    var_10.onuseupdate = ::dompoint_onuseupdate;
    var_10.onuse = ::dompoint_onuse;
    var_10.onenduse = ::dompoint_onenduse;
    var_10.oncontested = ::dompoint_oncontested;
    var_10.onuncontested = ::dompoint_onuncontested;
    var_10.ondisableobjective = ::dompoint_ondisableobjective;
    var_10.onenableobjective = ::dompoint_onenableobjective;
    var_10.onactivateobjective = ::dompoint_onactivateobjective;
    var_10 thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0);
    var_10.defaultownerteam = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    var_10.overrideprogressteam = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_10.ignorestomp = 1;
    var_10.decaygraceperiod = 5.0;
    var_10.permcapturethresholds = [0.33, 0.66];
  }
}

startgame() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
  level.currentobjectiveindex = 1;
  updatecurrentobjective(level.currentobjectiveindex);
}

manageovertimestate() {
  for(;;) {
    waitframe();

    if(istrue(level.timerstoppedforgamemode)) {
      level.canprocessot = 0;
      continue;
    }

    if(isDefined(level.currentobjective))
      level.canprocessot = level.currentobjective.touchlist[game["_encstr_991C0AB9ED5B57161FE89B83"]].size == 0;
  }
}

updatecurrentobjective(var_0) {
  if(!isDefined(level.objectives[scripts\engine\utility::string(var_0)])) {
    return;
  }
  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();

  level.currentobjectiveindex = var_0;
  level.currentobjective = level.objectives[scripts\engine\utility::string(var_0)];
  updatespectatorcamera("_encstr_846A06C2E3ABF8D1" + level.currentobjectiveindex);

  if(isDefined(level.currentobjective.onenableobjective))
    level.currentobjective[[level.currentobjective.onenableobjective]]();

  if(level.activationdelay > 0) {
    level scripts\mp\gamelogic::pausetimer();
    var_1 = int(gettime() + level.activationdelay * 1000);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", var_1);
    wait(level.activationdelay);
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective))
    level.currentobjective[[level.currentobjective.onactivateobjective]]();

  var_2 = 0;

  switch (var_0) {
    case 1:
      var_2 = 10;
      break;
    case 2:
      var_2 = 10;
      break;
    case 3:
      var_2 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var_2);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B8061BD590E9985082F4CF73880BCFF3A74B841D9AE727411ADB5FCBB5");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_84961999F749233D2E0C01186F7AE8D3C9874080FEB1E0E323D2E3");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_ADAF15C5502928B3930DB1C3E3B717C64EBFB20871896A", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_864113DBC3F13EA0630CF64B3259F878A9EF895B57", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_1 in level.objectives) {
    var_1.spawnpoints = [];
    var_1.spawnpoints["_encstr_9A8507BA4040188D08"] = [];
    var_1.spawnpoints["_encstr_8E8405EA382B2A"] = [];
  }

  foreach(var_4 in level.spawnpoints) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = var_4.script_noteworthy;

      if(var_5 == "_encstr_934C0218" || var_5 == "_encstr_AC4C024A") {
        continue;
      }
      if(var_4.classname == "_encstr_ADAF15C5502928B3930DB1C3E3B717C64EBFB20871896A") {
        level.objectives[var_5].spawnpoints["_encstr_9A8507BA4040188D08"][level.objectives[var_5].spawnpoints["_encstr_9A8507BA4040188D08"].size] = var_4;
        continue;
      }

      if(var_4.classname == "_encstr_864113DBC3F13EA0630CF64B3259F878A9EF895B57")
        level.objectives[var_5].spawnpoints["_encstr_8E8405EA382B2A"][level.objectives[var_5].spawnpoints["_encstr_8E8405EA382B2A"].size] = var_4;
    }
  }

  foreach(var_8, var_1 in level.objectives) {
    var_1.spawnpointsets = [];
    var_1.spawnpointsets["_encstr_9A8507BA4040188D08"] = "_encstr_8E0E0D1E7B13F1F679A368486F830E" + var_8;
    var_1.spawnpointsets["_encstr_8E8405EA382B2A"] = "_encstr_8FDB0BC06033AC571FBB384A39" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnpointsets["_encstr_9A8507BA4040188D08"], var_1.spawnpoints["_encstr_9A8507BA4040188D08"]);
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnpointsets["_encstr_8E8405EA382B2A"], var_1.spawnpoints["_encstr_8E8405EA382B2A"]);
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_991C0FB5EF3E1B932F80498328634B3396" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    self.startspawnpoint = var_2;
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.currentobjective.spawnpointsets[var_0]);

  return var_2;
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

mapobjectiveicon(var_0) {
  self.iconname = "_encstr_B40101";
}

disabledomflagscriptable() {
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0);
}

awardcapturepoints() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  level endon("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level.framedurationseconds;

      if(self.stalemate)
        var_2 = 0.0;
    }

    var_3 = self.claimteam;

    if(var_3 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    if(!self.stalemate) {
      foreach(var_5 in self.touchlist[var_3])
      var_5.player thread scripts\mp\utility\points::giveunifiedpoints("_encstr_88400B20CA22FF68F30FE06E02");
    }
  }
}

dompoint_onbeginuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin(var_0);
  self.didstatusnotify = 1;
}

dompoint_onuseupdate(var_0, var_1, var_2, var_3) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseupdate(var_0, var_1, var_2, var_3);

  if(scripts\mp\utility\game::inovertime()) {
    var_4 = self.teamprogress[game["_encstr_991C0AB9ED5B57161FE89B83"]] / self.usetime;

    if(var_4 > game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"])
      game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"] = var_4;

    var_5 = game["_encstr_976A11E816F72B8134A25001AB4D6FE32FBB6E"] + game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"];

    if(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 1 && scripts\mp\utility\game::setscoretobeat(var_0, var_5 * 60.0) == var_0)
      thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  }
}

dompoint_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  level.usestartspawns = 0;
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_2, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);
  scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
  var_3 = level.currentobjectiveindex;
  var_3++;

  if(var_3 == 4) {
    var_4 = scripts\mp\gamelogic::gettimeremaining();
    var_4 = var_4 / 60000.0;
    game["_encstr_85ED0E179550E2533320C25888191FDB"][var_1] = max(1.0, var_4);

    if(scripts\mp\utility\game::inovertime()) {
      var_5 = scripts\mp\utility\game::setscoretobeat(var_1, 180.0);
      thread scripts\mp\gamelogic::endgame(var_5, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
      return;
    }

    thread scripts\mp\gamelogic::endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
    return;
  } else {
    if(level.extratimebonus > 0) {
      level.extratime = level.currentobjectiveindex * level.extratimebonus;
      var_4 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(var_4));
    }

    if(scripts\mp\utility\game::inovertime()) {
      game["_encstr_976A11E816F72B8134A25001AB4D6FE32FBB6E"]++;
      game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"] = 0;
    }

    updatecurrentobjective(var_3);
  }
}

dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested();
}

dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested(var_0);
  self.didstatusnotify = 1;
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  var_1 = scripts\mp\gameobjects::getownerteam();
}

dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  self notify("_encstr_83D00F5D37B23D26359536D111AC6CB0BC");
  scripts\engine\utility::delaythread(0.1, ::disabledomflagscriptable);
}

dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(self.defaultownerteam, 0);
  } else {
    scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
  }
}

dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("_encstr_B2EB1E52833FA6C7D85E0914F8A0972BC9603BBB111B1E63B0BC112C8DC88374");
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  thread awardcapturepoints();
  level.flagcapturetime = level.captureduration;
  scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "_encstr_AB9D07E3FB679359D2";
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7B213D1BF0A90383892BEF03E708136621B7D134F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "_encstr_A11E11297F3177A8BC8C718B399B08B94AE3FB":
          setteammapposition(var_3, "_encstr_9A8507BA4040188D08", var_6);
          break;
        case "_encstr_8C500F3ADBFAC2F02DB9EB6CB0DACA39B0":
          setteammapposition(var_3, "_encstr_8E8405EA382B2A", var_6);
          break;
      }
    }
  }
}

setteammapposition(var_0, var_1, var_2) {
  if(!isDefined(level.spectatorcameras[var_0]))
    level.spectatorcameras[var_0] = [];

  level.spectatorcameras[var_0][var_1] = var_2;
}

startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getvieworigin());
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_2;
  self.spectatorcament = var_3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  thread dohalfwayflash();
  var_3 movecameratomappos(self, var_1, var_2);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  thread runslamzoomonspawn();
}

updatespectatorcamera(var_0) {
  level.currentspectatorcamref = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.spectatorcament)) {
      var_3 = var_2.team;
      var_4 = getdvarint("_encstr_82C8145F57B679EBE8F1A1B6493035638797CB9F3B51", -1);

      if(var_4 != -1)
        var_3 = scripts\engine\utility::ter_op(var_4 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

      var_5 = level.spectatorcameras[level.currentspectatorcamref][var_3];
      var_2.spectatorcament movecameratomappos(var_2, var_5.origin, var_5.angles);
    }
  }
}

movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_1, 1.0, 0.5, 0.5);
  var_0 playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  var_0 setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
  self rotateTo(var_2, 1.0, 0.5, 0.5);
  var_0 thread startoperatorsound();
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.spectatorcament, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("_encstr_A39D1618AAE7A00982B7171B57BACE084F80C0D0153F38B0");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("_encstr_B40101", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
  self cameraunlink();
  self.spectatorcament delete();
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

startoperatorsound() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.5;
}

applythermal() {
  self visionsetthermalforplayer("_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

loopspectatorlocations() {
  var_0 = 1;

  for(;;) {
    if(getdvarint("_encstr_840915A357F6079890B74927DF90C38B995FA7D30ABB17", 0) == 1) {
      if(isalive(level.players[0]))
        level.players[0] suicide();

      var_1 = getdvarint("_encstr_8C6E15D2E86287072863A03E23E87F2B10B74AE5553508", -1);

      if(var_1 != -1)
        var_0 = var_1;

      updatespectatorcamera("_encstr_846A06C2E3ABF8D1" + var_0);
      var_2 = getdvarfloat("_encstr_A10915BBE1B6EF4EF069F7D37BA89713571E4242A887AF", 1.0);
      wait(var_2);
      var_0++;

      if(var_0 > 3)
        var_0 = 1;

      if(getdvarint("_encstr_840915A357F6079890B74927DF90C38B995FA7D30ABB17", 0) == 0)
        level.players[0] notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");

      continue;
    }

    waitframe();
  }
}