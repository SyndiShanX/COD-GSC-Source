/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\tjugg.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 150);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.juggswitchtime = 90;
  }

  updategametypedvars();
  level.teambased = 1;
  level.doprematch = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83720FD90BDA2BE8F2E0CAEB8E53BAD9EC";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_BE670C16389FDB88377480F83BA0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_BE670C16389FDB88377480F83BA0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_BE670C16389FDB88377480F83BA0";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_915015A313E36853A297BAE7990B2DDA07A1858F2045E0", getmatchrulesdata("_encstr_88A30A5BA38FCFD7080FD317", "_encstr_A71D0B383BB7BF7CEFE1B1B5F0"));
  setdynamicdvar("_encstr_AFCF19B9C6C9BE47A9AED99DAFD4573BB3CD77968E6CA1E82DAD56", getmatchrulesdata("_encstr_88A30A5BA38FCFD7080FD317", "_encstr_AC210F889BAFF066A37F092F53B9B37845"));
  setdynamicdvar("_encstr_A1EF14584FB2565112F3142C418B611809971890B77F", getmatchrulesdata("_encstr_88A30A5BA38FCFD7080FD317", "_encstr_91DC0A0EC15B05B992AEEC3B"));
  setdynamicdvar("_encstr_8CFC14C37720616B8A6BBAA236DF332470C5424D8760", getmatchrulesdata("_encstr_88A30A5BA38FCFD7080FD317", "_encstr_8A460AE07F50677ADA5539A8"));
  setdynamicdvar("_encstr_BA1F18FA49B07F5B22FB979F47D7E3B398137747600802038CE7", getmatchrulesdata("_encstr_88A30A5BA38FCFD7080FD317", "_encstr_833C0EDA3AA7D4ED68A247A85BA73ABC"));
  setdynamicdvar("_encstr_ADD416F3EF700F0D15E0A894D05B577DAD94EF3709F30752", 0);
  scripts\mp\utility\game::registerroundswitchdvar("_encstr_8E65062BD0CFB4EC", 0, 0, 9);
  setdynamicdvar("_encstr_8B9F1577A0F39F831D750F0748150A7DD82383E738480C", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_8E65062BD0CFB4EC", 1);
  setdynamicdvar("_encstr_868C13B8AF52F6F1B253B44C219B3318A41FC0D05B", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_8E65062BD0CFB4EC", 1);
  setdynamicdvar("_encstr_8D0213DCD8C9FAD19ABA9DD9BE860BD89947A5D62B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8E65062BD0CFB4EC", 0);
  setdynamicdvar("_encstr_B1681DF79F33B8B84A7BC1D9E93830EFFBEF6D7D3F8BF7E88F95A9914D1140", 0);
  setdynamicdvar("_encstr_ABE21BC7AF0388885A6BD1A9992F68542A43534F7BDA64806C47B86138", 0);
  setdynamicdvar("_encstr_BD781816114E3717BA7E6371622989074D6381C601A033E25018", 1);
  setdynamicdvar("_encstr_A621104F98CBD7CB5B27C5719C7583A9D3C0", 0);
  setdynamicdvar("_encstr_AB551286E61B87BB5AFF18206F78B32F320DF505", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  scripts\mp\utility\game::setobjectivetext("_encstr_9A8507BA4040188D08", &"_encstr_8E0711907A1395C753D8E17151A5D1CCC7E70C");
  scripts\mp\utility\game::setobjectivetext("_encstr_8E8405EA382B2A", &"_encstr_8E0711907A1395C753D8E17151A5D1CCC7E70C");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_8E0711907A1395C753D8E17151A5D1CCC7E70C");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_8E0711907A1395C753D8E17151A5D1CCC7E70C");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_B475171FC2EC51D623F8AFF561F61561735F8747BB06B9868F");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_B475171FC2EC51D623F8AFF561F61561735F8747BB06B9868F");
  }

  scripts\mp\utility\game::setobjectivehinttext("_encstr_9A8507BA4040188D08", &"_encstr_A2A616F01A73F5E773F8C151B14531ECE7876C70B827DC81");
  scripts\mp\utility\game::setobjectivehinttext("_encstr_8E8405EA382B2A", &"_encstr_A2A616F01A73F5E773F8C151B14531ECE7876C70B827DC81");
  initspawns();
  scripts\mp\playeractions::registeractionset("_encstr_8E65062BD0CFB4EC", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
  level.respawnoldjugg_fx = loadfx("_encstr_88D827705BB8587F42321508CF0B61F847D33090937B282DAA119E256323BBC6751350D02F0360F7E2");
  level.jugg_available = [];
  level.jugg_available["_encstr_8E8405EA382B2A"] = 1;
  level.jugg_available["_encstr_9A8507BA4040188D08"] = 1;
  level.jugg_attackers = [];
  level.jugg_attackers["_encstr_8E8405EA382B2A"] = [];
  level.jugg_attackers["_encstr_9A8507BA4040188D08"] = [];
  level.jugg_currjugg = [];
  level.jugg_currjugg["_encstr_8E8405EA382B2A"] = undefined;
  level.jugg_currjugg["_encstr_9A8507BA4040188D08"] = undefined;
  level.tjugg_timerdisplay = [];
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"] = scripts\mp\hud_util::createservertimer("_encstr_9A2B0A12F03587575B7BBEA5", 1.4, "_encstr_9A8507BA4040188D08");
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"] scripts\mp\hud_util::setpoint("_encstr_AF9F08DB601069806D49", "_encstr_AF9F08DB601069806D49", 55, 150);
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"].label = &"_encstr_83701504AB39F1538C87DF80B5E914217421575F67A913";
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"].alpha = 0;
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"].archived = 0;
  level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"].hidewheninmenu = 1;
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"] = scripts\mp\hud_util::createservertimer("_encstr_9A2B0A12F03587575B7BBEA5", 1.4, "_encstr_8E8405EA382B2A");
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"] scripts\mp\hud_util::setpoint("_encstr_AF9F08DB601069806D49", "_encstr_AF9F08DB601069806D49", 55, 150);
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"].label = &"_encstr_83701504AB39F1538C87DF80B5E914217421575F67A913";
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"].alpha = 0;
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"].archived = 0;
  level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"].hidewheninmenu = 1;
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["_encstr_9A8507BA4040188D08"]);
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["_encstr_8E8405EA382B2A"]);
  level.favorclosespawnscalar = 5;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.jugghealth = scripts\mp\utility\dvars::dvarintvalue("_encstr_A71D0B383BB7BF7CEFE1B1B5F0", 1000, 1000, 10000);
  level.juggswitchtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AC210F889BAFF066A37F092F53B9B37845", 60, 10, 180);
  level.ppkasjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_91DC0A0EC15B05B992AEEC3B", 2, 1, 100);
  level.ppkonjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A460AE07F50677ADA5539A8", 5, 1, 100);
  level.ppkjuggonjugg = scripts\mp\utility\dvars::dvarintvalue("_encstr_833C0EDA3AA7D4ED68A247A85BA73ABC", 10, 1, 100);
}

onplayerconnect(var_0) {
  var_0.hasbeenjugg = 0;
  var_0.jugg_allegiance = 0;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
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
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_3 == "_encstr_AB590C99ED78875F650F3951034D" && var_4.basename == "_encstr_8BBA05185F8B99" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
    return;
  }
  var_10 = self;

  if(isDefined(var_10.isjuggmodejuggernaut)) {
    if(isDefined(var_10.juggoverlay))
      var_10.juggoverlay destroy();

    var_10.playerstreakspeedscale = undefined;
    var_10.nostuckdamagekill = 0;
    var_10 scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
    cleanupobjectiveiconsforjugg(var_10);
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;

    if(var_1 == var_10) {
      if(isDefined(var_10.isjuggmodejuggernaut))
        var_12 = 1;
    } else if(var_1.team != var_10.team) {
      if(isDefined(var_10.isjuggmodejuggernaut)) {
        var_12 = 1;

        if(isDefined(var_1.isjuggmodejuggernaut))
          var_13 = 1;
        else
          var_14 = 1;
      } else if(isDefined(var_1.isjuggmodejuggernaut))
        var_15 = 1;

      if(level.jugg_available[var_1.team])
        var_11 = 1;
    } else if(isDefined(var_10.isjuggmodejuggernaut) && var_1.team == var_10.team) {
      var_10 thread givejuggloadout();
      return;
    }

    if(var_11)
      resetjugg(var_1);

    if(var_12) {
      var_18 = getbestteammate(var_10.team, 0);

      if(!isDefined(var_18))
        var_18 = getbestteammate(var_10.team, 1);

      if(!isDefined(var_18))
        var_18 = var_10;

      resetjugg(var_18, var_10);
    }

    if(var_11 || var_12)
      scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");

    if(var_1 != var_10 && var_1.team != var_10.team && !isDefined(var_1.isjuggmodejuggernaut)) {
      if(var_1.hasbeenjugg) {
        var_1.jugg_allegiance = var_1.jugg_allegiance + 25;

        if(var_14)
          var_1.jugg_allegiance = var_1.jugg_allegiance + 75;

        if(isDefined(level.jugg_attackers[var_1.team][var_10.guid])) {
          var_16 = 1;
          var_1.jugg_allegiance = var_1.jugg_allegiance + 50;
          level.jugg_attackers[var_1.team][var_10.guid] = undefined;
        }
      } else {
        var_1.jugg_allegiance = var_1.jugg_allegiance + 50;

        if(var_14)
          var_1.jugg_allegiance = var_1.jugg_allegiance + 100;

        if(isDefined(level.jugg_attackers[var_1.team][var_10.guid])) {
          var_16 = 1;
          var_1.jugg_allegiance = var_1.jugg_allegiance + 100;
          level.jugg_attackers[var_1.team][var_10.guid] = undefined;
        }
      }
    }

    if(var_14) {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BABA10D6A51B63EBA6ABD99DB293DCC2EAA3");
      var_17 = level.ppkonjugg;
    } else if(var_13) {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A6F00D4D1BD7F4B9E5568FFD55CF30");
      var_17 = level.ppkjuggonjugg;
    } else if(var_15) {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A56813EFFB71582FE73636902B0F589D353E56F37B");
      var_17 = level.ppkasjugg;
    }

    if(var_17)
      var_1 scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_17);

    if(var_1.team != var_10.team && game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" && game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1.team] > game["_encstr_96040B1D59B0AD35B1F64E599B"][level.otherteam[var_1.team]]) {
      var_1.finalkill = 1;
      return;
    }
  } else if(isDefined(var_10.isjuggmodejuggernaut)) {
    var_18 = getbestteammate(var_10.team, 0);

    if(!isDefined(var_18))
      var_18 = getbestteammate(var_10.team, 1);

    if(!isDefined(var_18))
      var_18 = var_10;

    resetjugg(var_18, var_10);
  }
}

resetjugg(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 notify("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
    var_1.isjuggmodejuggernaut = undefined;
  } else
    level.jugg_available[var_0.team] = 0;

  level.jugg_currjugg[var_0.team] = undefined;
  level.tjugg_timerdisplay[var_0.team].alpha = 0;
  level.jugg_attackers[var_0.team] = [];

  foreach(var_3 in level.players) {
    if(var_3.team == var_0.team)
      var_3.jugg_allegiance = 0;
  }

  var_0 thread givejuggloadout();
}

givejuggloadout() {
  if(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote()) {
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");
    thread resetjuggloadoutondisconnect(0);

    while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote())
      waitframe();

    self notify("_encstr_8C23211F7081B922F9C0F7BB21D3EFE23918E6D7681B4357E061FFBF9048AE3A33A62B");
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  if(istrue(self.isjuggmodejuggernaut)) {
    self notify("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
    waitframe();
  }

  self.isjuggmodejuggernaut = 1;
  level.jugg_currjugg[self.team] = self;
  self.hasbeenjugg = 1;
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  createjuggobjectiveicon(self);
  thread updatejuggpingorigin();
  self.isjuggernaut = 1;
  self.maxhealth = level.jugghealth;
  self.health = self.maxhealth;
  self.nostuckdamagekill = 1;
  scripts\mp\class::loadout_clearweapons(1);
  scripts\mp\playeractions::allowactionset("_encstr_8E65062BD0CFB4EC", 0);
  var_0 = scripts\mp\class::buildweapon("_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4", ["_encstr_BACC05C9770D68"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(var_0);
  scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_0);
  var_0 = scripts\mp\class::buildweapon("_encstr_BA090ED4634AD742CFC7BBABA36F5A77", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(var_0);
  self givemaxammo(var_0);
  scripts\mp\utility\perk::giveperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA");
  scripts\mp\utility\perk::giveperk("_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363");
  scripts\mp\utility\player::_setsuit("_encstr_934212925C82495C700FDF7F3A22E3AB1B11EAC7");
  self.playerstreakspeedscale = -0.2;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\juggernaut::jugg_setModel();
  self.juggoverlay = newclienthudelem(self);
  self.juggoverlay.x = 0;
  self.juggoverlay.y = 0;
  self.juggoverlay.alignx = "_encstr_A5AD056A019C63";
  self.juggoverlay.aligny = "_encstr_AC190479FF92";
  self.juggoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.juggoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.juggoverlay setshader("_encstr_A9701619AE8B904F33A7AFC7FB7A0E20315E86F1D7CC1077", 640, 480);
  self.juggoverlay.sort = -10;
  self.juggoverlay.archived = 1;
  self.juggoverlay.alpha = 1.0;
  self.friendlyoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "_encstr_A7DA197F2B857AD1C0013FC418E8DF92D091DFFBC123F19310E935", "_encstr_85CE0B9770B02C73A1760F06D2");
  thread resetjuggloadoutondisconnect(1);
  thread resetjuggloadoutonchangeteam();
  thread rewardteammateproximity();
  thread logattackers();

  if(level.juggswitchtime != 0)
    thread nextjuggtimeout();
}

nextjuggtimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level.tjugg_timerdisplay[self.team].label = &"_encstr_83701504AB39F1538C87DF80B5E914217421575F67A913";
  level.tjugg_timerdisplay[self.team] settimer(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 0;
  var_0 = getbestteammate(self.team, 0);

  if(!isDefined(var_0))
    var_0 = getbestteammate(self.team, 1);

  if(!isDefined(var_0))
    var_0 = self;

  scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
  resetjugg(var_0, self);

  if(var_0 != self)
    thread respawnoldjugg();
}

respawnoldjugg() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote())
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  playFX(level.respawnoldjugg_fx, self.origin);
  self notify("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
  waitframe();

  while(!self isonground())
    waitframe();

  self notify("_encstr_91D70BC8AF032B0F1B734F731A");

  if(isDefined(self.juggoverlay))
    self.juggoverlay destroy();

  self.faux_spawn_stance = self getstance();
  self.playerstreakspeedscale = undefined;
  self.isjuggernaut = 0;
  self.nostuckdamagekill = 0;
  scripts\mp\utility\outline::outlinedisable(self.friendlyoutlineid, self);
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");
  thread scripts\mp\playerlogic::spawnplayer(1);
  scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
  scripts\mp\weapons::updatemovespeedscale();
  cleanupobjectiveiconsforjugg(self);
}

rewardteammateproximity() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    wait 1.0;

    foreach(var_1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_1) && !var_1 scripts\mp\utility\player::isusingremote() && var_1 != self && var_1.team == self.team && distancesquared(var_1.origin, self.origin) < 48400) {
        if(var_1.hasbeenjugg) {
          var_1.jugg_allegiance = var_1.jugg_allegiance + 15;
          continue;
        }

        var_1.jugg_allegiance = var_1.jugg_allegiance + 25;
      }
    }
  }
}

logattackers() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isPlayer(var_1) && var_1.team != self.team) {
      if(!isDefined(level.jugg_attackers[self.team][var_1.guid]))
        level.jugg_attackers[self.team][var_1.guid] = 1;
    }
  }
}

resetjuggloadoutondisconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0)
    self endon("_encstr_AD75063D571AE108");
  else
    self endon("_encstr_8C23211F7081B922F9C0F7BB21D3EFE23918E6D7681B4357E061FFBF9048AE3A33A62B");

  var_1 = self.team;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = getbestteammate(var_1, 0);

  if(!isDefined(var_2))
    var_2 = getbestteammate(var_1, 1);

  if(isDefined(var_2)) {
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
    resetjugg(var_2);
  } else {
    level.jugg_available[var_1] = 1;
    level.jugg_currjugg[var_1] = undefined;
    level.tjugg_timerdisplay[var_1].alpha = 0;
    level.jugg_attackers[var_1] = [];

    foreach(var_4 in level.players) {
      if(var_4.team == var_1)
        var_4.jugg_allegiance = 0;
    }
  }
}

resetjuggloadoutonchangeteam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self.team;
  scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self.isjuggmodejuggernaut = undefined;
  var_1 = getbestteammate(var_0, 0);

  if(!isDefined(var_1))
    var_1 = getbestteammate(var_0, 1);

  if(isDefined(var_1)) {
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
    resetjugg(var_1);
  } else {
    level.jugg_available[var_0] = 1;
    level.jugg_currjugg[var_0] = undefined;
    level.tjugg_timerdisplay[var_0].alpha = 0;
    level.jugg_attackers[var_0] = [];

    foreach(var_3 in level.players) {
      if(var_3.team == var_0)
        var_3.jugg_allegiance = 0;
    }
  }
}

getbestteammate(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in level.players) {
    if((var_1 || !var_5 scripts\mp\utility\player::isusingremote()) && var_5 != self && var_5.team == var_0 && var_5.jugg_allegiance > var_3) {
      var_2 = var_5;
      var_3 = var_5.jugg_allegiance;
    }
  }

  return var_2;
}

hidetimerdisplayongameend(var_0) {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_0.alpha = 0;
}

createjuggobjectiveicon(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.juggobjid = var_1;
  var_0.offset3d = (0, 0, 90);
  var_0.visibleteam = "_encstr_9A19040BCDBC";
  var_0.ownerteam = var_0.team;
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_0.origin, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, var_0.offset3d[2]);
  objective_setownerteam(var_1, var_0.team);
  objective_setfriendlylabel(var_1, "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA");
  objective_setenemylabel(var_1, "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E");
}

cleanupobjectiveiconsforjugg(var_0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0.juggobjid);
  var_0.juggobjid = undefined;
}

updatejuggcurorigin() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");

  for(;;) {
    self.curorigin = self.origin + (0, 0, 90);
    waitframe();
  }
}

updatejuggpingorigin() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
  thread updatejuggcurorigin();

  if(!isDefined(self.objpingdelay))
    self.objpingdelay = 4.0;

  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      if(!scripts\mp\gameobjects::isfriendlyteam(var_1)) {
        objective_setpingsforteam(self.juggobjid, var_1);
        objective_ping(self.juggobjid);
      }
    }

    scripts\engine\utility::_id_143BF(self.objpingdelay);
  }
}

setspecialloadouts() {
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_BA090ED4634AD742CFC7BBABA36F5A77";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_A393109FCF38E936DA97CCE3177050314CB8";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBB0B9D41E718D9E922D8582A";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_84CB0CB2680B841B3E76A5AF0201";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3", "_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"];
  level.tjugg_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
}