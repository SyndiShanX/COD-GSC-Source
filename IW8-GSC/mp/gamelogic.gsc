/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gamelogic.gsc
***********************************************/

onforfeit(var_0) {
  if(isDefined(level.forfeitinprogress)) {
    return;
  }
  level endon("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
  level thread forfeitwaitforabort();
  level.forfeitinprogress = 1;
  level.canprocessot = 0;

  if(!level.teambased && level.players.size > 1)
    wait 10;
  else
    wait 1.05;

  level.forfeit_aborted = 0;
  var_1 = 20.0;
  matchforfeittimer(var_1);
  var_2 = &"_encstr_B40101";

  if(!isDefined(var_0)) {
    var_2 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_83EC12F3E99FBB4DB073C197E86896B263212F3B"];
    var_3 = level.players[0];
  } else {
    if(var_0 == "_encstr_9A8507BA4040188D08")
      var_2 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AB49137F3019CC8B1D775001EC37D366A150FBAF68"];
    else
      var_2 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8A4A125B0B275ACD9537BE33B739CC564B3AB2C8"];

    var_3 = var_0;
  }

  level.forcedend = 1;

  if(isPlayer(var_3))
    logstring("_encstr_8A911CA3838DA999681761AD909B292291C720375F44B3A1687FB28082EF" + var_3 getxuid() + "_encstr_924C021E" + var_3.name + "_encstr_824C0266");
  else
    logstring("_encstr_8A911CA3838DA999681761AD909B292291C720375F44B3A1687FB28082EF" + var_3);

  thread endgame(var_3, var_2);
}

forfeitwaitforabort() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarfloat("_encstr_9A4219B812BA97A1974B8F763CCF8EBDA5ABA8802AD35F9BAB490F") == 1) {
    level.disableforfeit = 1;
    level notify("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
  } else
    level waittill("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");

  level.forfeit_aborted = 1;
  level.canprocessot = 1;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_1 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
  }
}

matchforfeittimer_internal(var_0) {
  waittillframeend;
  level endon("_encstr_9A241EDA0B47360DD7CCF69C33CAD2D1BEE8966BAC93EBC459765A37B9B4E63B");

  while(var_0 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_0);
      var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
    }

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
  }
}

matchforfeittimer(var_0) {
  level notify("_encstr_9A241EDA0B47360DD7CCF69C33CAD2D1BEE8966BAC93EBC459765A37B9B4E63B");
  var_1 = int(var_0);
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_83B01780727008402A3B612F03529688AD8C6BD89D7FD18BB2");
  matchforfeittimer_internal(var_1);
}

default_ondeadevent(var_0) {
  logstring("_encstr_B28312A395C2D680B2B12DAD5A37B04759198E08" + var_0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B")) {
      var_3 = undefined;

      if(istrue(var_2.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"]) || istrue(var_2.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
        var_3 = "_encstr_A6EB0BEB4C4470A3AB1A8B51B2";

      var_2 scripts\cp_mp\utility\game_utility::stopkeyearning(var_3);
    }
  }

  if(var_0 == "_encstr_AF1904A7F929") {
    logstring("_encstr_840E116B96A2B2FA6AD39A8A9351BA403AD259");

    if(level.teambased)
      thread endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8D19048EA595"]);
    else
      thread endgame(undefined, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8D19048EA595"]);
  } else {
    var_8 = scripts\mp\utility\teams::getenemyteams(var_0);
    var_9 = [];

    foreach(var_6 in var_8)
    var_9[var_6] = 0;

    if(!istrue(level.disablespawning)) {
      foreach(var_6 in var_8) {
        foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_6, "_encstr_9775086022BE1B413B8B")) {
          if(!istrue(var_2.hasspawned)) {
            continue;
          }
          var_9[var_6] = var_9[var_6] + var_2.pers["_encstr_8CAA06DB20A31543"];
        }
      }
    }

    var_16 = [];

    foreach(var_6 in var_8) {
      if(scripts\mp\utility\teams::getteamdata(var_6, "_encstr_8A2A0B936CCCC3078547970A8B") || var_9[var_6])
        var_16[var_16.size] = var_6;
    }

    if(var_16.size == 1)
      thread endgame(var_16[0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
  }
}

default_ononeleftevent(var_0) {
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

    if(isDefined(var_1))
      var_1 thread givelastonteamwarning();
  } else {
    var_1 = scripts\mp\utility\game::getlastlivingplayer();
    logstring("_encstr_939A23C86F189357DC04A92B21E4D92E5B3AE361062570257E5FE11C36177C7674981E90EA" + var_1.name);
    thread endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"]);
  }

  return 1;
}

roundend_checkscorelimit(var_0, var_1) {
  checkteamscorelimitsoon(var_0);

  if(istrue(var_1)) {
    level notify("_encstr_B1B919EE0D830D418D7B9849A7C8394FCABAEEF8A27A81289D7F60");
    level endon("_encstr_B1B919EE0D830D418D7B9849A7C8394FCABAEEF8A27A81289D7F60");
    waitframe();
  }

  var_2 = scripts\mp\utility\game::getwingamebytype();

  if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
    if(scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(scripts\mp\utility\game::settimetobeat(var_0)) {
        foreach(var_4 in level.players) {
          var_4 setclientomnvar("_encstr_8FF119C32B2FB02533F57B446ADB08EB42505FD16BA8888B210B5B", scripts\engine\utility::ter_op(var_4.team == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
          var_4 setclientomnvar("_encstr_8A0416B3C8487F75D8237957F9507DA790C3AA99313D27AB", scripts\engine\utility::ter_op(var_4.team != game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
        }

        thread endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"]);
      }
    } else {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        return;
      }
      thread endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"]);
      return;
    }
  } else if(level.roundscorelimit > 0) {
    var_6 = [];

    foreach(var_8 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_8)) {
        continue;
      }
      if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_8] >= level.roundscorelimit)
        var_6[var_6.size] = var_8;
    }

    if(var_6.size > 0) {
      if(var_6.size > 1) {
        var_10 = 0;
        var_11 = undefined;
        var_12 = 0;

        foreach(var_8 in var_6) {
          var_14 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_8];

          if(!isDefined(var_11)) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 > var_10) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 == var_10)
            var_12 = 1;
        }

        if(var_12) {
          thread endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"]);
          return;
        }

        thread endgame(var_11, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"]);
        return;
      } else
        thread endgame(var_6[0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"]);
    }
  }
}

default_ontimelimit() {
  var_0 = "_encstr_8D19048EA595";

  if(level.teambased) {
    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        var_1 = game["_encstr_976A11E816F72B8134A25001AB4D6FE32FBB6E"] + game["_encstr_88B715B79DAC4E472DB5590A27EDEC272B9BCD32C9B06C"];
        var_0 = scripts\mp\utility\game::setscoretobeat(game["_encstr_991C0AB9ED5B57161FE89B83"], var_1 * 60.0);
      } else if(scripts\mp\utility\game::istimetobeatvalid())
        var_0 = game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"];
    } else
      var_0 = scripts\mp\gamescore::gethighestscoringteam();

    logstring("_encstr_AA571F8754A1E91057583021081D49FFB9B3155D310C4B1543C8E16E38FA22CA41" + var_0);
  } else {
    var_0 = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied())
      var_0 = "_encstr_8D19048EA595";

    if(isDefined(var_0) && isPlayer(var_0))
      logstring("_encstr_AA571F8754A1E91057583021081D49FFB9B3155D310C4B1543C8E16E38FA22CA41" + var_0.name);
    else
      logstring("_encstr_A5741D4B6CAB08D8435D6DF32D7911E1638B471BD772B29F780520168DF85F");
  }

  thread endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

default_onhalftime() {
  var_0 = undefined;
  thread endgame("_encstr_AADE09481E247875C2EFAB", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

forceend(var_0) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }
  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_2)) {
        continue;
      }
      scripts\mp\gamescore::updatetotalteamscore(var_2);
    }
  }

  var_4 = undefined;

  if(level.teambased) {
    var_4 = scripts\mp\gamescore::gethighestscoringteam();
    logstring("_encstr_95F9246D69A2CAD7D4D36AA2C92A57020DBDB947102BE619592308D9C26B561680DD4BE64702" + var_4);
  } else {
    var_4 = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(var_4))
      logstring("_encstr_95F9246D69A2CAD7D4D36AA2C92A57020DBDB947102BE619592308D9C26B561680DD4BE64702" + var_4.name);
    else
      logstring("_encstr_A26E2290717D86B1DFA4DF9B6E596956BA177B64D2FB30BD213DE12F93A082EA496B9B02");
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen)
    var_7 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8DA10B959B469591BEB316DA95"];
  else
    var_7 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B84D100B771EE3FFB05897DFF1890F4AF98B"];

  if(isDefined(var_0) && var_0 == 2) {
    if(level.teambased) {
      if(var_4 == "_encstr_9A8507BA4040188D08")
        var_8 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AB49137F3019CC8B1D775001EC37D366A150FBAF68"];
      else
        var_8 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8A4A125B0B275ACD9537BE33B739CC564B3AB2C8"];
    } else
      var_8 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_83EC12F3E99FBB4DB073C197E86896B263212F3B"];
  }

  level notify("_encstr_B2270A3E87C886F7C8C1923A");
  thread endgame(var_4, var_7);
}

onscorelimit(var_0) {
  var_1 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"];
  var_2 = "_encstr_8D19048EA595";

  if(level.teambased) {
    var_2 = scripts\mp\gamescore::freight_lift_door_switch();

    if(var_2 == "_encstr_8BBA05185F8B99")
      var_2 = "_encstr_8D19048EA595";

    logstring("_encstr_B6701F6B96A8B27DA9E935A239457504B9D8B79C59C6A5D62DA3C204BB4B9BA302" + var_2);
  } else {
    var_2 = scripts\mp\gamescore::gethighestscoringplayer();

    if(istrue(var_0) && scripts\mp\gamescore::ishighestscoringplayertied())
      var_2 = "_encstr_8D19048EA595";

    if(isDefined(var_2) && isPlayer(var_2))
      logstring("_encstr_B6701F6B96A8B27DA9E935A239457504B9D8B79C59C6A5D62DA3C204BB4B9BA302" + var_2.name);
    else
      logstring("_encstr_AD491DB55AA22BD7D4E99AA239155702E66CDEC956D85ADA4B1D16048E5A2B");

    var_6 = var_2 scripts\mp\killstreaks\killstreaks::calcstreakcost("_encstr_B8BA05F06B9785");

    if(scripts\mp\utility\game::getscorelimit() == var_6 && var_2.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] == var_6) {
      level._id_11C81 = var_2;
      level.starttime = gettime();
      level.discardtime = 0;
      level.timerpausetime = 0;
      var_7 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
      level.watchdvars[var_7].value = 30;
      level.overridewatchdvars[var_7] = 30;
      level.dontendonscore = 1;
      return;
    }
  }

  thread endgame(var_2, var_1);
  return 1;
}

updategameevents() {
  var_0 = 0;
  level.teamswithplayers = [];

  foreach(var_2 in level.teamnamelist) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_AB580A05672AE35D5FFF50B8");
    var_0 = var_0 + var_3;

    if(var_3)
      level.teamswithplayers[level.teamswithplayers.size] = var_2;
  }

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit)) {
    if(level.teambased) {
      if(level.teamswithplayers.size == 1 && game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
        thread onforfeit(level.teamswithplayers[0]);
        return;
      }

      if(level.teamswithplayers.size > 1) {
        level.forfeitinprogress = undefined;
        level notify("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
      }
    } else {
      var_5 = 0;

      foreach(var_7 in level.teamnamelist)
      var_5 = var_5 + scripts\mp\utility\teams::getteamdata(var_7, "_encstr_AB580A05672AE35D5FFF50B8");

      if(var_5 == 1 && level.maxplayercount > 1) {
        thread onforfeit();
        return;
      }

      if(var_5 > 1) {
        level.forfeitinprogress = undefined;
        level notify("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && (istrue(level.br_debugsolotest) || scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")) {
    return;
  }
  if(!scripts\mp\utility\game::getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }
  if(!scripts\mp\utility\game::gamehasstarted()) {
    return;
  }
  if(level.ingraceperiod && !isDefined(level.overrideingraceperiod)) {
    return;
  }
  if(level.teambased) {
    var_9 = [];

    foreach(var_7 in level.teamnamelist)
    var_9[var_7] = 0;

    foreach(var_13 in level.players) {
      if(!istrue(var_13.hasspawned) || var_13.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_13.team == "_encstr_933E090A10B17DDFB3E522" || var_13.team == "_encstr_BD78059C33C543") {
        continue;
      }
      var_9[var_13.team] = var_9[var_13.team] + var_13.pers["_encstr_8CAA06DB20A31543"];
    }

    if(istrue(level.disablespawning)) {
      foreach(var_7 in level.teamnamelist)
      var_9[var_7] = 0;
    }

    var_17 = 0;

    foreach(var_7 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8A2A0B936CCCC3078547970A8B")) {
        var_17 = 1;
        break;
      }
    }

    var_20 = 0;

    foreach(var_22 in var_9) {
      if(var_22) {
        var_20 = 1;
        break;
      }
    }

    if(!var_17 && !var_20) {
      if(istrue(level.postgameexfil) && level.gameended)
        level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");

      if(istrue(level.nukeincoming)) {
        return;
      }
      if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
        logstring("_encstr_AFFC2AECB719905FA2DB5210D2E2BA719458BD501AACEB8A616AD147F599F7196B33E302705D2F72A14E28B5");

      return [[level.ondeadevent]]("_encstr_AF1904A7F929");
    }

    foreach(var_7 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8A2A0B936CCCC3078547970A8B") && !var_9[var_7]) {
        if(istrue(level.postgameexfil) && level.gameended)
          level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");

        if(!istrue(level.skipondeadevent)) {
          if(istrue(level.nukeincoming)) {
            return;
          }
          if(level.multiteambased) {
            if(!scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8B340BAAD957B3BA5DD33DBB1B") && scripts\mp\utility\teams::getteamdata(var_7, "_encstr_A1310B432F9BDEFBEF4393B0F1")) {
              if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
                logstring("_encstr_88BA3BD15F98E3B642CBFA2027DA628F23E81E37AA95836A531A323F5A5D9AF7BA33B3974D7B38B14F197010DB93EE1B43408DBBA4EA6FCA99411360B2");

              scripts\mp\utility\teams::setteamdata(var_7, "_encstr_8B340BAAD957B3BA5DD33DBB1B", 1);
              [[level.ondeadevent]](var_7);
            }

            continue;
          }

          if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
            logstring("_encstr_B6CB3792EA9096CC625391936647801D5212218A946429A984D102B7E622560BC851D959B9D11096402BCD8E2797402AB20BB640C4B0DCB223");

          return [[level.ondeadevent]](var_7);
        }
      }
    }

    foreach(var_7 in level.teamnamelist) {
      var_27 = scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8A2A0B936CCCC3078547970A8B");

      if(var_27 == 1 || var_27 == 2) {
        var_28 = 0;
        var_29 = undefined;
        var_30 = scripts\mp\utility\teams::getteamdata(var_7, "_encstr_9775086022BE1B413B8B");
        var_31 = [];

        foreach(var_13 in var_30) {
          if(!isalive(var_13)) {
            var_28 = var_28 + var_13.pers["_encstr_8CAA06DB20A31543"];
            continue;
          }

          var_31[var_31.size] = var_13;
        }

        if(var_27 != 1)
          scripts\mp\utility\teams::setteamdata(var_7, "_encstr_A63208900AB769596374", 0);

        if(var_28 == 0) {
          if(var_27 == 1 && !scripts\mp\utility\teams::getteamdata(var_7, "_encstr_A63208900AB769596374") && gettime() > scripts\mp\utility\teams::getteamdata(var_7, "_encstr_AC610CF033ED0C4B1A6B45D30502") + 5000) {
            scripts\mp\utility\teams::setteamdata(var_7, "_encstr_AC610CF033ED0C4B1A6B45D30502", gettime());
            scripts\mp\utility\teams::setteamdata(var_7, "_encstr_A63208900AB769596374", 1);

            if(var_30.size > 1)
              [[level.ononeleftevent]](var_7);
          } else if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_B18D0B5281530117EDEAC82033" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_816E079685517D0975" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E" && var_27 == 2 && var_30.size > 2) {
            var_34 = scripts\engine\utility::random(var_31);
            level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_34, "_encstr_8110100AE8554D5B2028EC19D6EB2753AF48");
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(var_7, "_encstr_A63208900AB769596374", 0);
    }
  } else {
    var_9 = 0;

    foreach(var_13 in level.players) {
      if(var_13.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_13.team == "_encstr_933E090A10B17DDFB3E522") {
        continue;
      }
      var_9 = var_9 + var_13.pers["_encstr_8CAA06DB20A31543"];
    }

    var_38 = 0;

    foreach(var_7 in level.teamnamelist)
    var_38 = var_38 + scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8A2A0B936CCCC3078547970A8B");

    if(!var_38 && !var_9) {
      if(istrue(level.nukeincoming)) {
        return;
      }
      return [[level.ondeadevent]]("_encstr_AF1904A7F929");
    }

    var_41 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_41.size == 1)
      return [[level.ononeleftevent]]("_encstr_AF1904A7F929");
  }
}

timelimitclock_intermission(var_0) {
  setgameendtime(gettime() + int(var_0 * 1000));
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 10.0)
    wait(var_0 - 10.0);

  for(;;) {
    var_1 playSound("_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40");
    wait 1.0;
  }
}

waitforplayers(var_0) {
  var_1 = gettime();

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    var_2 = 0;
  else if(var_0 > 5)
    var_2 = gettime() + getdvarint("_encstr_AFBA0B534DA5D25A963DA0B4D4") * 1000;
  else
    var_2 = 0;

  var_3 = max(1, level.connectingplayers / 2);
  scripts\mp\flags::gameflagwait("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    if(istrue(game["_encstr_8DC30DAA0285FD69FAE113371B1934"])) {
      break;
    }

    var_6 = level.maxplayercount;
    var_7 = round_spawn_vehicles();

    if(!var_4) {
      if(var_7 > 0) {
        var_1 = gettime();
        var_4 = 1;
      } else {
        waitframe();
        continue;
      }
    }

    var_8 = gettime();
    var_9 = var_6 >= var_3;
    var_10 = var_7 >= var_3;

    if(var_10) {
      foreach(var_12 in level.teamnamelist) {
        if(!checkrequiredteamcount(var_12)) {
          var_9 = 0;
          break;
        }
      }
    }

    foreach(var_12 in level.teamnamelist) {
      if(!getquestxprewardinstance(var_12)) {
        if(level.gametype == "_encstr_A9B606B0C956B916" && !var_5)
          setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_97B4127FA888DC3A6D04695F783D1184510BAFE7");

        var_10 = 0;
        break;
      }
    }

    var_16 = var_1 + level.prematchperiod * 1000 - 200;

    if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
      if(var_10 && var_8 > var_2 || var_8 > var_16) {
        break;
      }
    } else if(var_10 && var_9 && var_8 > var_2 || var_8 > var_16) {
      break;
    }

    waitframe();
  }
}

round_spawn_vehicles() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(istrue(var_2.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]))
      var_0++;
  }

  return var_0;
}

checkrequiredteamcount(var_0) {
  return scripts\mp\utility\teams::getteamdata(var_0, "_encstr_A1310B432F9BDEFBEF4393B0F1") >= level.requiredplayercount[var_0];
}

getquestxprewardinstance(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.team) && var_3.team == var_0 && istrue(var_3.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]))
      var_1++;
  }

  return var_1 >= level.requiredplayercount[var_0];
}

prematchperiod() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level._id_1285F) && [[level._id_1285F]]()) {
    return;
  }
  level.connectingplayers = getdvarint("_encstr_87B60BC4DC439930C8178D957F");

  if(getdvarint("_encstr_9AFD0F6EC639D7362DEC2BF5D8DE98895E", 0) == 1 && !istrue(level._id_133E0)) {
    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      logstring("_encstr_A5321E507951F57693359A990ECA02E6E3391948216D0EEFF171D5ECC36BDFA0" + scripts\mp\utility\game::getgametype() + "_encstr_81E71E60B2D6E1376847A315D0A3DB3508BFCBD1B33A5FADA469A58E94F6E8DF");

    game["_encstr_95810CA5B9982DEC9526DEC426F2"] = 1;

    if(getdvarint("_encstr_B8D0231387751F6DEDFAF36082CF0D194B897D1A9E6220EA086DDB47925B75EB7250BBFD23", 0) == 1)
      level thread watchdevoverridematchstart();

    level thread _id_144BF(1);
    level thread watchforminplayersmatchstart();
    level waittill("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      setDvar("_encstr_9AFD0F6EC639D7362DEC2BF5D8DE98895E", 0);

    game["_encstr_95810CA5B9982DEC9526DEC426F2"] = 0;
    game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"] = 1;
    var_0 = 30;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
      var_0 = getdvarint("_encstr_ADB8133F57FB70F09A3958D11B73588873E78BABBB", 60);

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && istrue(level.infilcanusemap))
      var_0 = getdvarint("_encstr_ADB8133F57FB70F09A3958D11B73588873E78BABBB", 25);

    level.allowprematchdamage = 0;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      level.allowprematchdamage = 1;
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::defend_wave_1();

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::handleinfilspawnselectstart();
    }

    level livelobbymatchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", var_0);

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::handleinfilspawnselectend();

      var_2 = 0;
      var_3 = 0;
      var_4 = 0;

      foreach(var_6 in level.players) {
        if(!isDefined(var_6)) {
          continue;
        }
        if(isbot(var_6) || initmaxspeedforpathlengthtable(var_6)) {
          var_3 = var_3 + 1;
          continue;
        }

        if(var_6 calloutmarkerping_getEnt()) {
          var_4 = var_4 + 1;
          continue;
        }

        var_2 = var_2 + 1;
      }

      logstring("_encstr_8581166D5A512BF5353DA9A227515708143959B52C47C6D0");
      logstring("_encstr_8D0E2E6F99C9925D1DE63752AEF2BE53B5993EA932B149A1F3EFBE3D997AFEF2B519538105FBEF77DA8E328A2AE9AB5F");
      logstring("_encstr_96140E6A91854FDCE91BB4811BF2B18A" + var_0);
      logstring("_encstr_91250EE002EB1FF982281F0720AA9201" + var_3);
      logstring("_encstr_A3770E86560B23C6ACB9E6010802E980" + var_4);
      logstring("_encstr_876E0E898F8AEF101B6671798EB072B7" + var_2);
      logstring("_encstr_8D0E2E6F99C9925D1DE63752AEF2BE53B5993EA932B149A1F3EFBE3D997AFEF2B519538105FBEF77DA8E328A2AE9AB5F");
    }

    level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
    level.prematchperiod = 0;

    if(!istrue(level.brkillchainchance))
      game["_encstr_ABC109C4C6BD1BDA929228"] = 1;
  } else if(!istrue(level._id_133E0)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      var_8 = getdvarint("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9");

      if(var_8 != 0) {
        level thread _id_144BF();
        level thread enemy_move_up_and_ignore();
        level waittill("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
      }

      var_0 = 15;

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::handleinfilspawnselectstart();

      level.allowprematchdamage = 0;

      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
        level.allowprematchdamage = 1;

        if(istrue(level.infilcanusemap))
          var_0 = getdvarint("_encstr_ADB8133F57FB70F09A3958D11B73588873E78BABBB", 25);
      }

      level livelobbymatchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", var_0);

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::handleinfilspawnselectend();
    }
  }

  if(istrue(level._id_133E0)) {
    while(!level.players.size)
      waitframe();
  }

  if(istrue(game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"]))
    level waittill("_encstr_8A5E1260A27DBB4003C7EFA8CE2E03C12A40D72B");

  if(istrue(game["_encstr_ABC109C4C6BD1BDA929228"])) {
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
  }

  level notify("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");

  if(istrue(level.debug_show2dvotext))
    level.parachuterestoreweaponscb = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::nakeddrop;

  if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    logstring("_encstr_BAEE3253AFDB58674A5F82D217A0792D47304BDFDC9FBF57CF570AA01B0FABA17BABD3A85B9B4175AB8A202AB2A541F89B59EDBD");

  physics_raycastents(gettimeremaining(), 2);
  level.prematchstarted = 1;

  if(level.prematchperiodend > 0)
    matchstarttimerwaitforplayers();
  else
    matchstarttimerskip();

  scripts\mp\hostmigration::waittillhostmigrationdone();
  physics_raycastents(gettimeremaining(), 0);

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B")
    return;
}

scriptablesstartid() {
  wait 3;

  if(isDefined(level.parachuterestoreweaponscb)) {
    foreach(var_1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_1))
        var_1[[level.parachuterestoreweaponscb]]();
    }
  }
}

graceperiod() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(game["_encstr_B8860D12A893BFB590BB233C83E83F"])) {
    while(getactiveclientcount() == 0)
      waitframe();

    game["_encstr_B8860D12A893BFB590BB233C83E83F"] = 1;
  }

  while(level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level notify("_encstr_96CA149FFDBF3BDB1662F59B54DD9F49C390D4D00E77");
  waitframe();
  scripts\mp\flags::gameflagset("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA");
  level.ingraceperiod = 0;

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B") {
    if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
      logstring("_encstr_8F6C2F925D90696626D4C8E4CC7440234AD31D2394D41247809DC26BACD60837E8583AAC087501094F010E1BB0F25ADCD9");

    return;
  }

  if(scripts\mp\utility\game::getgametypenumlives()) {
    var_0 = level.players;

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(!var_2.hasspawned && var_2.sessionteam != "_encstr_AF8C0A1B6A1D6045925B4F7D" && !isalive(var_2))
        var_2.statusicon = "_encstr_8D2810A1EA91AFE6E816D1D5E6BE8C59C28C";
    }
  }

  level thread[[level.updategameevents]]();
}

sethasdonecombat(var_0, var_1) {
  if(var_1 && !istrue(var_0.hasdonecombat))
    scripts\mp\class::disableclassswapallowed();

  var_0.hasdonecombat = var_1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(var_1 && !istrue(var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
    var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"] = 1;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
      var_0 scripts\mp\utility\stats::incpersstat("_encstr_95B80C17DA7BF867C7ED6BC84D94", 1);

    if(isDefined(var_0.pers["_encstr_8F910D1A0B9BA6C21DB13426EDCDCD"]) && var_0.pers["_encstr_8F910D1A0B9BA6C21DB13426EDCDCD"]) {
      return;
    }
    updatelossstats(var_0);
  }
}

updatewinstats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
    return;
  }
  if(istrue(var_0.pers["_encstr_95F40D132396A012D8950D14F04283"]))
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_8AF80C496F93A9AD572260B06AEA", scripts\mp\utility\game::getgametype());
  var_1 = var_0 scripts\mp\playerstats_interface::getplayerstat("_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");

  if(var_1 > var_0 scripts\mp\playerstats_interface::getplayerstat("_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_929A11C6B737B3ACCD47D55AE64D479C95B0AD"))
    var_0 scripts\mp\playerstats_interface::setplayerstat(var_1, "_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_929A11C6B737B3ACCD47D55AE64D479C95B0AD");

  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_91190447C232", 1);
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8CAD05DB100303", 0);
}

updatelossstats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
    return;
  }
  var_0.pers["_encstr_8F910D1A0B9BA6C21DB13426EDCDCD"] = 1;

  if(!istrue(self.joinedinprogress)) {
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_0.pers["_encstr_95F40D132396A012D8950D14F04283"] = 1;
  }

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8CAD05DB100303", 1);
}

updatetiestats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
    return;
  }
  if(istrue(var_0.pers["_encstr_95F40D132396A012D8950D14F04283"])) {
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_0 scripts\mp\playerstats_interface::setplayerstat(0, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
  }

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_AA270B12190951B94784B87C6B", "_encstr_8CEF0531B18F48");
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8CAD05DB100303", 0);
}

updatewinlossstats(var_0) {
  if(scripts\mp\utility\game::privatematch()) {
    return;
  }
  if(!scripts\mp\utility\game::waslastround()) {
    return;
  }
  level.processedwinloss = 1;
  var_1 = level.players;
  updateplayercombatstatus();

  if(!isDefined(var_0) || isDefined(var_0) && isstring(var_0) && var_0 == "_encstr_8D19048EA595") {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
        continue;
      }

      updatetiestats(var_3);
    }
  } else if(isPlayer(var_0)) {
    if(level.hostforcedend && var_0 ishost()) {
      var_0 scripts\mp\playerstats_interface::setplayerstat(0, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
      return;
    }

    if(isDefined(level.lastplayerwins))
      updatewinstats(level.placement["_encstr_AF1904A7F929"][0]);
    else {
      for(var_5 = 0; var_5 < min(level.placement["_encstr_AF1904A7F929"].size, 3); var_5++)
        updatewinstats(level.placement["_encstr_AF1904A7F929"][var_5]);
    }
  } else if(isstring(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
        continue;
      }

      if(var_0 == "_encstr_8D19048EA595") {
        updatetiestats(var_3);
        continue;
      }

      if(var_3.pers["_encstr_8AEF05472BC2D6"] == var_0) {
        updatewinstats(var_3);
        continue;
      }

      if(istrue(var_3.pers["_encstr_95F40D132396A012D8950D14F04283"]))
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "_encstr_AA270B12190951B94784B87C6B", "_encstr_85C71136FD43C35B0DDB19E0526A219B77914A");
    }
  }

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !var_3 scripts\mp\utility\game::onlinestatsenabled()) {
      continue;
    }
    if(isai(var_3)) {
      continue;
    }
    var_9 = var_3 scripts\mp\playerstats_interface::getplayerstat("_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");

    if(var_9 >= 5)
      var_3 giveachievement("_encstr_A2CB116A14BE288642255495A2D42A27157D13");
  }
}

updateplayercombatstatus() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_AAE507E8423F63C163") {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" && !var_1.spectatekillcam)
      continue;
    else if(istrue(var_1.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"]))
      continue;
    else if(var_1.team == "_encstr_8E8405EA382B2A")
      continue;
    else
      var_1 sethasdonecombat(var_1, 1);
  }
}

freezeplayerforroundend(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(var_0))
    var_0 = level.framedurationseconds;

  wait(var_0);
  scripts\mp\playeractions::allowactionset("_encstr_A5DD0E76585B56517332199395594FAC", 0);

  if(self isonground() || self isonladder())
    self allowmovement(0);
  else
    thread playerzombiesupersprint();
}

playerzombiesupersprint() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0.0;

  while(var_0 < 1) {
    if(!isDefined(self)) {
      return;
    }
    if(!self isonground())
      var_0 = var_0 + level.framedurationseconds;
    else {
      self allowmovement(0);
      break;
    }

    wait(level.framedurationseconds);
  }

  self allowmovement(0);
}

updatematchbonusscores(var_0) {
  if(!game["_encstr_B18F0BDD815F4151AECB982052"]) {
    return;
  }
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(!scripts\mp\utility\game::gettimelimit() || level.forcedend) {
    var_1 = scripts\mp\utility\game::gettimepassed() / 1000;
    var_1 = min(var_1, 1200);
  } else
    var_1 = scripts\mp\utility\game::gettimelimit();

  if(level.teambased) {
    if(var_0 != "_encstr_8D19048EA595")
      setwinningteam(var_0);

    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(!var_3 scripts\mp\utility\game::rankingenabled()) {
        continue;
      }
      if(var_3.timeplayed["_encstr_BE7D0633C08849E2"] < 1 || var_3.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] < 1) {
        continue;
      }
      if(level.hostforcedend && var_3 ishost()) {
        continue;
      }
      if(!istrue(var_3.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
        continue;
      }
      if(var_0 == "_encstr_8D19048EA595") {
        var_4 = var_3 calculatematchbonus("_encstr_8D19048EA595", var_1);
        var_3 thread givematchbonus("_encstr_8D19048EA595", var_4);
        var_3.matchbonus = var_4;
      } else if(isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]) && var_3.pers["_encstr_8AEF05472BC2D6"] == var_0) {
        var_4 = var_3 calculatematchbonus("_encstr_91190447C232", var_1);
        var_3 thread givematchbonus("_encstr_91190447C232", var_4);
        var_3.matchbonus = var_4;
      } else if(isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]) && scripts\mp\utility\teams::isgameplayteam(var_3.pers["_encstr_8AEF05472BC2D6"]) && var_3.pers["_encstr_8AEF05472BC2D6"] != var_0) {
        var_4 = var_3 calculatematchbonus("_encstr_8CAD05DB100303", var_1);
        var_3 thread givematchbonus("_encstr_8CAD05DB100303", var_4);
        var_3.matchbonus = var_4;
      }

      var_3 freight_lift_button_activation(var_1);
    }
  } else {
    var_6 = "_encstr_91190447C232";
    var_7 = "_encstr_8CAD05DB100303";

    if(!isDefined(var_0)) {
      var_6 = "_encstr_8D19048EA595";
      var_7 = "_encstr_8D19048EA595";
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(var_3.timeplayed["_encstr_BE7D0633C08849E2"] < 1 || var_3.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] < 1) {
        continue;
      }
      if(!istrue(var_3.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
        continue;
      }
      var_9 = 0;

      for(var_10 = 0; var_10 < min(level.placement["_encstr_AF1904A7F929"].size, 3); var_10++) {
        if(level.placement["_encstr_AF1904A7F929"][var_10] != var_3) {
          continue;
        }
        var_9 = 1;
      }

      if(var_9) {
        var_4 = var_3 calculatematchbonus(var_6, var_1);
        var_3 thread givematchbonus("_encstr_91190447C232", var_4);
        var_3.matchbonus = var_4;
      } else {
        var_4 = var_3 calculatematchbonus(var_7, var_1);
        var_3 thread givematchbonus("_encstr_8CAD05DB100303", var_4);
        var_3.matchbonus = var_4;
      }

      var_3 freight_lift_button_activation(var_1);
    }
  }
}

calculatematchbonus(var_0, var_1) {
  var_2 = getdvarint("_encstr_A23E1ACEAE53CF62181F30589B2338ADEA9545564EDA5F09FCDF1060", 250);
  var_3 = var_1 / 60;
  var_4 = scripts\mp\rank::getscoreinfovalue(var_0);
  var_5 = self.timeplayed["_encstr_BE7D0633C08849E2"] / var_1;
  var_6 = scripts\mp\rank::getgametypexpmultiplier();
  var_7 = int(var_2 * var_4 * var_3 * var_5 * var_6);
  var_7 = int(min(var_7, 16384));
  return var_7;
}

givematchbonus(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_B18D0B5281530117EDEAC82033" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
    return;
  }
  level waittill("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
  scripts\mp\rank::giverankxp(var_0, var_1, undefined, 1, 1);

  if(var_0 == "_encstr_91190447C232")
    thread scripts\mp\awards::givemidmatchaward("_encstr_950113DAC247C643EB1BB7B583D8B2E8CAEBEE4B9B");
  else
    thread scripts\mp\awards::givemidmatchaward("_encstr_8C170FBFCB3D3268019935BDD3B0ADFB1D");
}

freight_lift_button_activation(var_0) {
  if(istrue(self.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"]) || !isDefined(self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"])) {
    return;
  }
  var_1 = scripts\mp\weaponrank::reload_handle_hintstring() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50.0);
  var_5 = self.timeplayed["_encstr_BE7D0633C08849E2"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 = var_7 - int(self.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] * var_6);

  if(var_7 <= 0) {
    return;
  }
  var_8 = 0;

  foreach(var_10 in self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"])
  var_8 = var_8 + (var_3 - var_10.killcount);

  if(var_8 <= 0) {
    return;
  }
  foreach(var_19, var_10 in self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]) {
    var_13 = (var_3 - var_10.killcount) / var_8;
    var_14 = int(var_7 * var_13);
    scripts\mp\rank::incrankxp(0, var_10, var_14, "_encstr_8112116B459E81CF2691EFBB82B0B1AF684B0F");

    foreach(var_18, var_16 in self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16.stats["_encstr_8E8D0697EB01F243"]) && var_10.killcount > 0) {
          var_17 = var_13 * (var_16.stats["_encstr_8E8D0697EB01F243"] / var_10.killcount);
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16.stats["_encstr_AF2F0A13317F6999F380EB53"]))
            var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] = var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] + var_14;
          else
            var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] = var_14;
        }
      }
    }
  }
}

setxenonranks(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.score) || !isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]))
      continue;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    ammobox_onplayerholduse(var_3);
  }
}

ammobox_onplayerholduse(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(istrue(var_0.pers["_encstr_A70A0DE97D8D683843123098D977ED"])) {
    return;
  }
  if(!isDefined(var_0.kills) || !isDefined(var_0.deaths)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    if(1 > var_0.timeplayed["_encstr_BE7D0633C08849E2"]) {
      return;
    }
    if(!isDefined(var_0.arenadamage)) {
      return;
    }
    var_2 = var_0.arenadamage;
    setplayerteamrank(var_0, var_0.clientid, var_2);
    var_0.pers["_encstr_A70A0DE97D8D683843123098D977ED"] = 1;
  } else if(scripts\mp\utility\game::validate_track()) {
    var_3 = 1000 - var_1;
    setplayerteamrank(var_0, var_0.clientid, var_3);
    var_0.pers["_encstr_A70A0DE97D8D683843123098D977ED"] = 1;
  } else {
    if(120 > var_0.timeplayed["_encstr_BE7D0633C08849E2"]) {
      return;
    }
    var_4 = 0;

    if(getdvarint("_encstr_AB8E2573297E37975883053797D01E43A6818A8B3656D74C30933C156F59271340B8C17359A017") == 1)
      var_4 = var_0 scripts\mp\utility\stats::getpersstat("_encstr_A68209DFE7B79AEC5BF76E");

    var_5 = (var_0.kills - (var_0.deaths - var_4)) / (var_0.timeplayed["_encstr_BE7D0633C08849E2"] / 60);
    setplayerteamrank(var_0, var_0.clientid, var_5);
    var_0.pers["_encstr_A70A0DE97D8D683843123098D977ED"] = 1;
  }
}

checktimelimit(var_0) {
  if(isDefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }
  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B") {
    setgameendtime(0);
    return;
  }

  runjiprules();

  if(scripts\mp\utility\game::gettimelimit() <= 0) {
    if(isDefined(level.starttime))
      setgameendtime(level.starttime);
    else
      setgameendtime(0);

    return;
  }

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level.starttime)) {
    return;
  }
  if(istrue(level.timerstopped)) {
    return;
  }
  var_1 = gettimeremaining();
  setgameendtime(gettime() + int(var_1));
  var_2 = istrue(level.ontimelimitgraceperiod);

  if(var_1 > 0 && !isDefined(level.playerplaygestureweaponanim)) {
    if(var_2) {
      if(istrue(level._id_13124))
        setomnvarforallclients("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
      else
        setomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
    }

    return;
  }

  if(var_2) {
    scripts\mp\flags::gameflagset("_encstr_A9071177F53082F3938062C92B75DFFAD04BF4");

    if(!isDefined(level.overtimetotal))
      level.overtimetotal = 0;
    else
      level.overtimetotal = level.overtimetotal + level.frameduration;

    if(isDefined(level.ontimelimitot)) {
      [[level.ontimelimitot]]();
      level.ontimelimitot = undefined;
    }

    if(istrue(level.canprocessot))
      level.currenttimelimitdelay = level.currenttimelimitdelay + level.framedurationseconds;
    else
      level.currenttimelimitdelay = 0;

    var_3 = clamp(1.0 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0.0, 1.0);

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      if(istrue(level._id_13124)) {
        if(!isDefined(level.playerparachutedetachresetomnvars))
          setomnvarforallclients("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 1);

        setomnvarforallclients("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_3);
      } else {
        setomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 1);
        setomnvar("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_3);
      }

      setomnvar("_encstr_B8891173088897B318DD34218B70B1A3CB20CA", gettime() + level.ontimelimitgraceperiod * 1000);
    } else {
      if(istrue(level._id_13124)) {
        setomnvarforallclients("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
        setomnvarforallclients("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_3);
      } else {
        setomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
        setomnvar("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_3);
      }

      setomnvar("_encstr_B8891173088897B318DD34218B70B1A3CB20CA", gettime() + level.ontimelimitgraceperiod * 1000);
    }

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod)
      return;
  }

  [[level.ontimelimit]]();
}

enableovertimegameplay() {
  level.ontimelimitgraceperiod = 5.0;
  level.currenttimelimitdelay = 0.0;
}

runjiprules() {
  if(!level.matchmakingmatch) {
    return;
  }
  if(!isDefined(level.nojip))
    level.nojip = 0;

  if(!level.nojip) {
    if(scripts\mp\utility\game::isroundbased() && !level.nojip) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "_encstr_8218041DF5FA":
        case "_encstr_AA5606FD1AF05085":
          var_0 = checkdomjiprules();
          break;
        case "_encstr_ACF906B79752C5E8":
        case "_encstr_A54F06D32A2F0498":
        case "_encstr_9B0703CD93":
        case "_encstr_B807035284":
        case "_encstr_A9B606B0C956B916":
          var_0 = checksdjiprules();
          break;
        case "_encstr_8E1904B3F501":
          var_0 = checkctfjiprules();
          break;
        case "_encstr_819B0572BF80BB":
          var_0 = checkballjiprules();
          break;
        case "_encstr_B60703EACA":
          var_0 = checkddjiprules();
          break;
        case "_encstr_B607038AAB":
          var_0 = getfilterformodifier();
          break;
        default:
          var_0 = checkdefaultjiprules();
          break;
      }

      if(var_0) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
        return;
      }
    } else if(!istrue(level.brkillchainchance) && scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1, 1);
      level.nojip = 1;
    }
  }
}

checkdomjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    foreach(var_1 in level.teamnamelist) {
      if(getteamscoreint(var_1) > 150)
        return 1;
    }

    if(scripts\mp\utility\game::gettimepassedpercentage() > 75)
      return 1;
  }

  return 0;
}

checksdjiprules() {
  var_0 = 3;

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      var_0 = 3;
      break;
    case "_encstr_A54F06D32A2F0498":
      var_0 = 2;
      break;
    case "_encstr_ACF906B79752C5E8":
      var_0 = 2;
      break;
    case "_encstr_A9B606B0C956B916":
      var_0 = 3;
      break;
    default:
      var_0 = 3;
      break;
  }

  if(scripts\mp\utility\game::isanymlgmatch())
    var_0 = 5;

  foreach(var_2 in level.teamnamelist) {
    if(scripts\mp\utility\game::getroundswon(var_2) >= var_0)
      return 1;
  }

  return 0;
}

checkctfjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = getteamscoreint(var_3);

    if(!isDefined(var_0) || var_4 < var_0)
      var_0 = var_4;

    if(!isDefined(var_1) || var_4 > var_1)
      var_1 = var_4;
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 10)
    return 1;

  return 0;
}

checkballjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = getteamscoreint(var_3);

    if(!isDefined(var_0) || var_4 < var_0)
      var_0 = var_4;

    if(!isDefined(var_1) || var_4 > var_1)
      var_1 = var_4;
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 15)
    return 1;

  return 0;
}

checkddjiprules() {
  var_0 = 0;

  foreach(var_2 in level.teamnamelist)
  var_0 = var_0 + scripts\mp\utility\game::getroundswon(var_2);

  if(var_0 >= 2)
    return 1;

  return 0;
}

checkdefaultjiprules() {
  if(scripts\mp\utility\game::nextroundisfinalround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  return 0;
}

getfilterformodifier() {
  return !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
}

getteamscoreint(var_0) {
  return int(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0]);
}

gettimeremaining() {
  return scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
}

gettimeremainingpercentage() {
  var_0 = scripts\mp\utility\game::gettimelimit() * 1000;
  return (var_0 - scripts\mp\utility\game::gettimepassed()) / var_0;
}

checkteamscorelimitsoon(var_0) {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }
  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_AFDD05A6AB763B") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  var_1 = 0;

  if(_id_132ED())
    var_1 = closetoscorelimit(var_0);
  else if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    var_2 = closetoscorelimit(var_0);
    var_3 = gettimeremaining() < scripts\mp\utility\game::gettimelimit() * 0.075;
    var_1 = var_2 || var_3;
  } else if(scripts\mp\utility\game::gettimepassed() > 45000)
    var_1 = estimatedtimetillscorelimit(var_0) < 0.5;

  if(!isDefined(level.playedmatchendingsoon))
    level.playedmatchendingsoon = 0;

  if(!level.playedmatchendingsoon && var_1) {
    level.playedmatchendingsoon = 1;
    level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_82FB06EB26785BD7");
  }

  if(!level.playedmatchendingsoon && scripts\mp\utility\game::canplayhalfwayvo()) {
    if(getteamscore(var_0) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\dialog::leaderdialog("_encstr_A2B8170D2C6399DD16CB7D3339D22B37911BCBBEB936DE9C2B", var_0, "_encstr_A16D07532531CB4BF7");
      thread scripts\mp\music_and_dialog::_id_11BDD(var_0);
      var_4 = scripts\mp\utility\teams::getenemyteams(var_0);

      foreach(var_6 in var_4)
      scripts\mp\utility\dialog::leaderdialog("_encstr_925114D016C699EE85E5EB56E6566BE5BEB9C6F6C959", var_6, "_encstr_A16D07532531CB4BF7");

      level.didhalfscorevoboost = 1;
    }
  }
}

_id_132ED() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_959105B99040BD":
    case "_encstr_85EF050CB150E7":
    case "_encstr_8218041DF5FA":
    case "_encstr_B81904B04E6B":
      return 1;
    default:
      return 0;
  }
}

checkplayerscorelimitsoon() {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }
  if(level.teambased) {
    return;
  }
  if(scripts\mp\utility\game::gettimepassed() < 60000) {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.nojip) && !level.nojip && scripts\mp\utility\game::getgametype() != "_encstr_AAE507E8423F63C163")
    scripts\mp\gamescore::checkffascorejip();

  if(scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75") {
    if(self.score == 14)
      level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_82FB06EB26785BD7");
  } else {
    var_0 = estimatedtimetillscorelimit();

    if(var_0 < 2)
      level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_82FB06EB26785BD7");
  }
}

checkscorelimit(var_0) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill())
    var_0 = 1;

  if(istrue(var_0)) {
    if(isPlayer(self) && !level.teambased && self.score >= level.roundscorelimit)
      level._id_12F0F = 1;

    level notify("_encstr_8382100ED8F8B37A6E07077B63B902E530E3");
    level endon("_encstr_8382100ED8F8B37A6E07077B63B902E530E3");
    waitframe();
  }

  if(scripts\mp\utility\game::isobjectivebased())
    return 0;

  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride)
    return 0;

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  if(level.roundscorelimit <= 0)
    return 0;

  if(level.teambased) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(level.teamnamelist[var_2])) {
        continue;
      }
      if(game["_encstr_96040B1D59B0AD35B1F64E599B"][level.teamnamelist[var_2]] >= level.roundscorelimit)
        var_1 = 1;
    }

    if(!var_1)
      return 0;
  } else {
    if(!isPlayer(self))
      return 0;

    if(self.score < level.roundscorelimit && !istrue(level._id_12F0F))
      return 0;
  }

  if(!istrue(level.dontendonscore))
    return onscorelimit(var_0);
}

updategametypedvars() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

matchstarttimerwaitforplayers() {
  thread matchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", level.prematchperiod + level.prematchperiodend);
  level thread prematchcountdownnotify();
  waitforplayers(level.prematchperiod);

  if(level.prematchperiodend > 0 && !isDefined(level.hostmigrationtimer)) {
    var_0 = level.prematchperiodend;
    level notify("_encstr_924C1B4A90714E33663EF41956EB27D28B38E2E1182F83733BADE70760", var_0);

    if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0 && !scripts\cp_mp\utility\game_utility::isarenamap())
      level thread _id_1335D();

    thread matchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", var_0);
    thread prematchcountdownnotify(var_0);
    level waittill("_encstr_BE9515BA4155FF6CE169E9E27101F40F759B11B2E820BF");
  }
}

_id_1335D() {
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 1);
  level scripts\engine\utility::waittill_notify_or_timeout("_encstr_BE9515BA4155FF6CE169E9E27101F40F759B11B2E820BF", 8.0);
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", -1);
}

prematchcountdownnotify(var_0) {
  level notify("_encstr_AFEC1880D6415FBE09C052F8B853357319300F0670A8E344C538");
  level endon("_encstr_AFEC1880D6415FBE09C052F8B853357319300F0670A8E344C538");

  if(isDefined(var_0))
    wait(max(var_0 - 5, 0));
  else
    wait(max(level.prematchperiod + level.prematchperiodend - 5, 0));

  scripts\mp\flags::gameflagset("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
}

startmodeobjidnotify(var_0) {
  self notify("_encstr_84F60B682391A301104EF26BD7");
  self endon("_encstr_84F60B682391A301104EF26BD7");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284")
    var_1 = 6;
  else
    var_1 = 5;

  if(var_0 > var_1) {
    var_0 = var_0 - var_1;
    max(var_0, 0);
    wait(var_0);
  } else
    wait 0.5;

  level notify("_encstr_8F55118F8B711B6436974A09E1173783D313D9");
}

matchstarttimer(var_0, var_1) {
  self notify("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  self endon("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  level notify("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");
  var_2 = int(var_1);
  level thread startmodeobjidnotify(var_2);

  if(var_2 >= 2) {
    setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", var_0);
    var_3 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";
    matchstarttimerperplayer_internal(var_2, var_3);
  }

  visionsetnaked("_encstr_B40101", 0.0);
  level notify("_encstr_BE9515BA4155FF6CE169E9E27101F40F759B11B2E820BF");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || istrue(level.testrandomrealismclients)) {
    foreach(var_5 in level.players) {
      if(istrue(level.testrandomrealismclients)) {
        if(!isDefined(var_5.isrealismenabled)) {
          if(scripts\engine\utility::cointoss()) {
            var_5 setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 0);
            var_5 setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 1);
            var_5.isrealismenabled = 1;
          }
        }

        continue;
      }

      var_5 setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 0);
      var_5 setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 1);
    }
  }
}

matchstarttimerperplayer_internal(var_0, var_1) {
  waittillframeend;
  level endon("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");
  var_1 = istrue(var_1);
  var_2 = int(var_0);

  if(var_1)
    childthread _id_11B42(var_2);

  foreach(var_4 in level.teamnamelist)
  childthread teamstarttimer(var_4, var_2, var_1);

  var_6 = ["_encstr_AF8C0A1B6A1D6045925B4F7D", "_encstr_933E090A10B17DDFB3E522"];

  foreach(var_4 in var_6)
  childthread teamstarttimer(var_4, var_2, var_1);

  childthread clearvisionsettimer(var_2);
  wait(var_2);
}

_id_11B42(var_0) {
  level endon("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");

  if(!isDefined(level.heli_arrived)) {
    level.heli_arrived = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    level.heli_arrived hide();
  }

  level.matchcountdowntime = var_0;

  while(var_0 > 0 && !level.gameended) {
    if(var_0 < 6) {
      var_1 = scripts\engine\utility::ter_op(var_0 < 4, "_encstr_A9FA1589667BFF386FE78010DB7C1619720E7218FC72E7", "_encstr_9AFA15B00ACBA650D97BE93B82FB21F56782C87E12CBC5");
      level.heli_arrived playSound(var_1);
    }

    level.matchcountdowntime = var_0;
    var_0--;
    wait 1.0;
  }

  level.matchcountdowntime = undefined;
  level.heli_arrived delete();
}

teamstarttimer(var_0, var_1, var_2) {
  level endon("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");
  var_3 = !istrue(var_2);
  var_4 = undefined;

  if(var_3) {
    var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_4 hide();
    level.matchcountdowntime = var_1;
  }

  if(!level.gameended) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1285E(var_0);
      thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12854(var_0);
      thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calculateeventstarttime();
    }

    while(var_1 > 0 && !level.gameended) {
      if(var_3 && var_1 < 6) {
        if(var_1 < 4)
          var_4 playSound("_encstr_A9FA1589667BFF386FE78010DB7C1619720E7218FC72E7");
        else
          var_4 playSound("_encstr_9AFA15B00ACBA650D97BE93B82FB21F56782C87E12CBC5");
      }

      var_5 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

      foreach(var_7 in var_5) {
        if(var_1 <= 80) {
          var_7 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_1);
          var_7 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
        }
      }

      var_1--;

      if(var_3)
        level.matchcountdowntime = var_1;

      wait 1.0;
    }

    if(var_3) {
      level.matchcountdowntime = undefined;
      var_4 delete();
    }

    if(getdvarint("_encstr_A39721FFD7C2B9A0DA9D68EE583B49B7191FFC7F033A52DA07400AF9D72F9004886FBF", 1) == 0) {
      var_5 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

      foreach(var_7 in var_5) {
        scripts\mp\playerlogic::clearprematchlook(var_7);
        var_7 scripts\mp\utility\player::_freezecontrols(0, 1);
        var_7 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
        var_7 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
      }
    }
  }
}

clearvisionsettimer(var_0) {
  while(var_0 > 0 && !level.gameended) {
    var_0--;
    wait 1.0;
  }

  visionsetnaked("_encstr_B40101", 0);
}

matchstarttimerskip() {
  visionsetnaked("_encstr_B40101", 0);
}

onroundswitch(var_0) {
  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(var_0) {
    level.halftimetype = "_encstr_8B6D0940CC35339149DA08";

    if(scripts\mp\utility\game::islastwinbytwo()) {
      var_1 = getbetterteam();

      if(var_1 != game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
        game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
        level.switchedsides = 1;
        return;
      }

      level.switchedsides = undefined;
      return;
    } else {
      game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
      level.switchedsides = 1;
    }
  } else if(istrue(level.skipdefendersadvantage)) {
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
    level.switchedsides = 1;
  } else if(shouldgivedefendersadvantage()) {
    var_1 = getbetterteam();

    if(var_1 != game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
      game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
      level.switchedsides = 1;
      return;
    }

    level.switchedsides = undefined;
    return;
  } else {
    level.halftimetype = "_encstr_AADE09481E247875C2EFAB";
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
    level.switchedsides = 1;
  }
}

shouldgivedefendersadvantage() {
  return game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_9A8507BA4040188D08"] == scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1") - 1 && game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_8E8405EA382B2A"] == scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1") - 1;
}

checkroundswitch(var_0) {
  if(!level.teambased)
    return 0;

  if(!isDefined(level.roundswitch) || !level.roundswitch)
    return 0;

  if(losqueuehighindex()) {
    if(_id_12DBB())
      return 1;
  } else if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.roundswitch == 0 || var_0)
    return 1;

  return 0;
}

losqueuehighindex() {
  switch (level.gametype) {
    case "_encstr_A9B606B0C956B916":
      if(level.roundswitch == 2 && getdvarint("_encstr_85321DC8DF22A68B6367379FF1DACF299C577068B7C0B95D1A0F1690531211", 2) == 2)
        return 1;

      return 0;
    default:
      return 0;
  }
}

_id_12DBB() {
  switch (level.gametype) {
    case "_encstr_A9B606B0C956B916":
      if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.roundswitch == 1)
        return 1;

      return 0;
    default:
      return 0;
  }
}

timeuntilroundend() {
  if(level.gameended) {
    var_0 = (gettime() - level.gameendtime) / 1000;
    var_1 = level.postroundtime - var_0;

    if(var_1 < 0)
      return 0;

    return var_1;
  }

  if(scripts\mp\utility\game::gettimelimit() <= 0)
    return undefined;

  if(!isDefined(level.starttime))
    return undefined;

  var_2 = scripts\mp\utility\game::gettimelimit();
  var_0 = (gettime() - level.starttime) / 1000;
  var_1 = level.discardtime / 1000 + scripts\mp\utility\game::gettimelimit() - var_0;

  if(isDefined(level.timepaused))
    var_1 = var_1 + level.timepaused;

  return var_1 + level.postroundtime;
}

freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] scripts\mp\hud_util::destroyelem();
      self.perkname[0] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] scripts\mp\hud_util::destroyelem();
      self.perkname[1] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] scripts\mp\hud_util::destroyelem();
      self.perkname[2] scripts\mp\hud_util::destroyelem();
    }
  }

  self notify("_encstr_8DFC0D2BC0A39BC347CB5C1725EBCA");

  if(!level.doeomcombat) {
    self.lowermessage scripts\mp\hud_util::destroyelem();
    self.lowertimer scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.proxbar))
    self.proxbar scripts\mp\hud_util::destroyelem();

  if(isDefined(self.proxbartext))
    self.proxbartext scripts\mp\hud_util::destroyelem();
}

gethostplayer() {
  var_0 = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost())
      return var_0[var_1];
  }
}

hostidledout() {
  var_0 = gethostplayer();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0.selectedclass))
    return 1;

  return 0;
}

roundendwait(var_0, var_1) {
  if(isDefined(level._id_12DB7)) {
    level[[level._id_12DB7]](var_0, var_1);
    return;
  }

  if(!level.doeomcombat) {
    wait(level._id_127FE + 0.1);
    setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);
  }

  foreach(var_3 in level.players)
  var_3 thread scripts\mp\utility\game::setuipostgamefade(0.0);

  if(!var_1)
    wait(var_0);
  else {
    wait(var_0 / 2);
    level notify("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
    wait(var_0 / 2);
  }

  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
  level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
}

roundenddof(var_0) {
  scripts\mp\utility\player::setdof_spectator();
}

setwaypointiconinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.waypointcolors[var_0] = var_2;
  level.waypointbgtype[var_0] = var_1;
  level.waypointstring[var_0] = var_3;
  level.waypointshader[var_0] = var_4;
  level.waypointpulses[var_0] = var_5;
}

initwaypointbackgrounds() {
  var_0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_8CA606F38878410D":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_93A2056DBB5853":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_B81904B04E6B":
      setwaypointiconinfo("_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_A66F12DC3EF381B031EBE8B9EB5148CBEA27406F", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
      setwaypointiconinfo("_encstr_B26F125BA948F08AC3ADBB1FB1FFF25158F1D966", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
      setwaypointiconinfo("_encstr_846F12EE855EE0DE2D9B8EF58E856DB437B3FAC6", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
      setwaypointiconinfo("_encstr_8A6F12BBC297E0BDD2CDA3FAA358DAD2CDECBE23", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
      setwaypointiconinfo("_encstr_856F12EE85CB1CDED273E8F53A0BD696379DEB2B", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
      setwaypointiconinfo("_encstr_A16713EE0B2F07DE2D9B3AFAB1B007D157E4ACEB2C", var_0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_A76713DD2C5E38EDD2E6D1D78D0B1C8EAB27B2FA26", var_0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_AB6713D436FB898809E3F0B1CF5923C9439A45480E", var_0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_996713670663383028FDA50107AAB3DB3DAB3D682D", var_0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_9B6713AB7B0B6B7D37D003979FE2AB9CEDEB1D37F5", var_0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_9373123807F973A7E2F55DF04F1A8D99468BF1F0", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_A173126339ABDBC568F544678960CFF758F179BA", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_A77312B760427082AB489B59A56BCADD08F09F7F", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_B873124CAE6311ED815B78295BA579637A97D05D", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_AC7312CB2AE90B3029E0B3D6A5CF1EE11368FFDF", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_B26A1563E7F2C198172EC97F81814BD58060B01DD74978", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_B46A153B71D2891F58B08159BA8B535030B9786D1CBE8D", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_B66A15EE2CE538ED96E6A3F591CA332BE619D2E676BE6C", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_A26A1518B2F8494017D68568B44F293B654A50584A99A9", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_956A151F7763CF80699D83FE074D338DAACBBBA517691D", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_BDD114BB85F2E0ED5AE6A3AF9863B71B5BB4B99DF50B", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
      setwaypointiconinfo("_encstr_BED1149BF7BB4B3F7828B31760F0E7A2771B25177035", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
      setwaypointiconinfo("_encstr_92D114C739501008B325D1C7C0A05A3B53E318AF5971", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
      setwaypointiconinfo("_encstr_88D1141FF7BB38609BE62DC80A9A4509A71B737F4104", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
      setwaypointiconinfo("_encstr_81D11477852FC1BD2DCDD1D73163B76C6DB4DC767D59", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
      setwaypointiconinfo("_encstr_917013FF4B40922F2350E359F989770EB83B644FE3", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
      setwaypointiconinfo("_encstr_8E7013FC1ED3A1D0518B88D9937CE83F5A87FD1036", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
      setwaypointiconinfo("_encstr_B87013DF5170A89087FA9BE6224B58F80CAD7117FB", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
      setwaypointiconinfo("_encstr_937013EE85BC07B7D2E61DEB4C1BBDC6B52B46D78C", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
      setwaypointiconinfo("_encstr_A1701357AF32DBCDC3784309E031055FA805CCC735", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
      setwaypointiconinfo("_encstr_AAE91218B2F8494017D68568BC678B23657AE120", var_0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
      setwaypointiconinfo("_encstr_85E912837A8F5F180436B9F72CEDB0ABAB721EA9", var_0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
      setwaypointiconinfo("_encstr_ADE9129F974911BF3A3A750F5ABF9F042DAF77B7", var_0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
      setwaypointiconinfo("_encstr_84E912A8976903D79265CD40FD2A37E8D63761A8", var_0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
      setwaypointiconinfo("_encstr_8AE912DDB0F20EDBA5E6D17DD8BDB9969BB3EB95", var_0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
      setwaypointiconinfo("_encstr_AD371ABBE173130D903D9CAF3F0812CB9D7B12B2C9CD5B02B811BF99", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_85371A076F7BD78891658BE6CE41A80D139BABAD17C39D28B1FD1659", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_8A371A27F0D270F2DB380BC996F33B3CFBF0E73BB80BCCEB23C1D9FE", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_96371ABCAA0B7AA028A89159D3273335EBD207F859BB28B5BF7A497A", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_88371AF379882B104B1B0817EF2ADBC3B863CDFB9B8B2CA3F9A13FF9", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_BA411567BF22CBDDD388B319F8075513191EECED458ED7", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
      setwaypointiconinfo("_encstr_954115DD2CE583F6D2731DF5D8DE37E8CA9B3A9532EB26", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
      setwaypointiconinfo("_encstr_A24115CC2EE3918001DBF8A9C72FF8C14AD2C55DC7397F", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
      setwaypointiconinfo("_encstr_B64115D436FB898809E3F0B1CF57E0C942DACD55CF3179", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
      setwaypointiconinfo("_encstr_B44115C331D068E2BBD5D38737503AA4E8DBBBCF098905", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
      setwaypointiconinfo("_encstr_996F16CB2AB8A880B348609750B080796C70CAC895F467E9", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_9B6F16DDB0970EF6B4E6D1FA91B7DAF53A164E76AC3AD726", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_836F16436F0820279B23899125872D21FB621A5713945709", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_8B6F168047293BA749EA80F9E1FFDB678B333BCAE3BB1741", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_866F167846E8871777E320983C483BB83D8F030F27247961", var_0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      break;
    case "_encstr_B60703EACA":
    case "_encstr_B807035284":
      setwaypointiconinfo("_encstr_B4010EEEB0BC0EEDA5B91DBE4CDEB598", 2, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A2331D2BF34113C98796647D09A781D999A6B7BD63A94EF9D53E2EB5A640B1", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 1);
      setwaypointiconinfo("_encstr_92441AF343C568B8CF1A2AF3024FE87011DD4F5FE7EAC0E0B3D2A0B9", 1, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_858B12C75EAF919F5888F34FC38A7B2253F57739", 0, "_encstr_88BF06FD784A6393", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_8A8B128FE7F35F1019EDF36E93F9301CEA1B672D", 0, "_encstr_88BF06FD784A6393", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_9AFE19EEC2BC1CB72DDCA3F5C4DE5B89D7C859CCEA6E4B37ECFA16", 0, "_encstr_88BF06FD784A6393", "_encstr_B494219439479341FF69BB934FD589C987262CFDA4EF5D41C7158F83B60F39068F6927", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_A5FE1903C927DB2A823ECBA72A5A707A770F57570BF32BE0E0B63E", 0, "_encstr_88BF06FD784A6393", "_encstr_B494219439479341FF69BB934FD589C987262CFDA4EF5D41C7158F83B60F39068F6927", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_863C19EF87933F70798D93CEB657287EA9ABA14B23EB0BA08F2939", 0, "_encstr_88BF06FD784A6393", "_encstr_93B221C1EBF78C3DE8C62925A980F5D409FE49313B5FE741D03DBDDBF5388F7DB99B21", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_A53C19B3E97B0B15980594B735805D9BB023FA5A9055270D907FBA", 0, "_encstr_88BF06FD784A6393", "_encstr_93B221C1EBF78C3DE8C62925A980F5D409FE49313B5FE741D03DBDDBF5388F7DB99B21", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_970712EEB0CB0E7B2D9B47BEC8CA335DE659D758", 0, "_encstr_88BF06FD784A6393", "_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_8A07125BA25797D0FCCE712FEC2740DD971AD661", 0, "_encstr_88BF06FD784A6393", "_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_BE3F17DF5170A89087FA9BE6224759F001AC7365FD1D50F0CF", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_AC3F1768C28839304786D55862B7B8E5F97A60683AE5594E33", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_9373123807F973A7E2F55DF04F1A8D99468BF1F0", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
      setwaypointiconinfo("_encstr_A173126339ABDBC568F544678960CFF758F179BA", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
      setwaypointiconinfo("_encstr_A77312B760427082AB489B59A56BCADD08F09F7F", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
      setwaypointiconinfo("_encstr_B873124CAE6311ED815B78295BA579637A97D05D", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
      setwaypointiconinfo("_encstr_AC7312CB2AE90B3029E0B3D6A5CF1EE11368FFDF", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
      setwaypointiconinfo("_encstr_AA9E159451D73BE764A2E8A91A3FBDD347FD0880BCA7C1", 0, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_969E157716CBE07B2DE68EEB32563357CDB2D7378EF54C", 0, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_A1681AEE0B2F07DE2D9B3AFA31B7D689F5C8ACCCAC3719AFB9D1FAC2", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      setwaypointiconinfo("_encstr_A7681ADD2C5E38EDD2E6D1D7897B5B4CFA46B23356E68CFA733AEB13", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_8566134AC0074DAF2377B9C8188823933F60928250", 0);
      break;
    case "_encstr_A9190405B4E5":
    case "_encstr_8E07030349":
      setwaypointiconinfo("_encstr_8ACE0B630AA199E13B93A848CF", 0, "_encstr_88BF06FD784A6393", "_encstr_8F9D2020714FBCD30D7F959568548BB52BF2884809F7273767DDB287037E770EE1B9", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_9A9F0A40CBE1F1936C357A44", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_A25F0D7023E1F191DB2D786509D399", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_9BB60B3B0F2F0592DB69CBB0CB", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_86130D58EB714FD7382B95DB5BAAD1", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_BECE0A5CFFF78A3F3B10DBF7", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
      setwaypointiconinfo("_encstr_971A0AEB3F31A3A8A8E7B278", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0);
      setwaypointiconinfo("_encstr_95560ABBE1EF1B5B4432D888", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_83AA23C9FF07B85E797F958FA9217159FE754FED41714CF80F118DE09F44DDAF193D26211F", "_encstr_841211F957E80DE724893BB350736BC3112979", 0);
    default:
      break;
  }

  setwaypointiconinfo("_encstr_8ECD1123407BEFC751BD31889F2789592B50D7", 1, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_973E1461B6E8BB2923B80A72B013DAC72128F7F4DFB1", 0);
  setwaypointiconinfo("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_973E1461B6E8BB2923B80A72B013DAC72128F7F4DFB1", 0);
  setwaypointiconinfo("_encstr_976E17BB2CE583B7B4B98EEB19EDB33A85B3E67D9BB5571BC6", 1, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_A2D11AB4B1B7B9D75B96E65A6B161CD746B7CEA3589DBEDC5BBA6336", 0);
  setwaypointiconinfo("_encstr_95641ADDB02F0EBD96CD47FA32B7CE47C2B3E6F5DCDAD51B36F59927", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_A2D11AB4B1B7B9D75B96E65A6B161CD746B7CEA3589DBEDC5BBA6336", 0);
  setwaypointiconinfo("_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_ACF51FDBEFB74BBED0134FE5886701802148580E382749E117ECE99D30456718C9", "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0);
  setwaypointiconinfo("_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD", 0, "_encstr_88BF06FD784A6393", "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E", "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36", 0);
  setwaypointiconinfo("_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB", "_encstr_B14C15A536B7B9AFEE58E5387BD29BD1FA959BB1DB4E8E", 0);
}

_id_12443(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_3 = var_2 getentitynumber();

      if(var_3 == var_0) {
        if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
          var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2.team, var_2.squadindex);
        else
          var_4 = scripts\mp\utility\teams::getteamdata(var_2.team, "_encstr_9775086022BE1B413B8B");

        if(isDefined(var_2._id_12444))
          var_2._id_12444 = !var_2._id_12444;
        else
          var_2._id_12444 = 1;

        foreach(var_6 in var_4) {
          if(isDefined(var_6)) {
            var_6 setclientomnvar("_encstr_835D123B0CAF5AAD31034547D21DAD0FC1808A9F", var_0);
            waitframe();
          }
        }

        if(istrue(scripts\mp\utility\game::matchmakinggame())) {
          if(isDefined(var_2) && var_2 isfireteamleader()) {
            var_8 = var_2 getfireteammembers();

            foreach(var_10 in var_8) {
              if(!isDefined(var_10)) {
                continue;
              }
              var_11 = var_10 getentitynumber();

              if(var_11 != var_3) {
                if(isDefined(var_10._id_12444))
                  var_10._id_12444 = !var_10._id_12444;
                else
                  var_10._id_12444 = 1;

                foreach(var_6 in var_4) {
                  if(isDefined(var_6)) {
                    var_6 setclientomnvar("_encstr_835D123B0CAF5AAD31034547D21DAD0FC1808A9F", var_11);
                    waitframe();
                  }
                }
              }
            }
          }
        }

        break;
      }
    }
  }

  return;
}

setupelevatordoor() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(!scripts\mp\utility\game::privatematch() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
      var_0 = [];

      foreach(var_2 in level.players) {
        if(!isDefined(var_2)) {
          continue;
        }
        if(isDefined(var_2._id_12444) && var_2._id_12444) {
          var_3 = var_2.team;
          var_4 = 0;
          var_5 = var_0.size;

          for(var_6 = 0; var_6 < var_5; var_6++) {
            if(var_0[var_6] == var_3)
              var_4 = 1;
          }

          if(!var_4) {
            var_0[var_5] = var_3;
            var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2.team, var_2.squadindex);
            var_8 = [];

            foreach(var_2 in var_7) {
              if(!isDefined(var_2)) {
                continue;
              }
              if(isDefined(var_2._id_12444) && var_2._id_12444)
                var_8[var_8.size] = var_2;
            }

            _func_427(var_8);
            waitframe();
          }
        }
      }
    }
  }
}

callback_startgametype() {
  scripts\mp\load::main();

  if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"])) {
    if(drawentitybounds())
      analyticsstreamerlogfilewritetobuffer();

    game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 0;
    game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] = 0;
  }

  scripts\mp\flags::gameflaginit("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", 0);
  scripts\mp\flags::gameflaginit("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F", 0);
  scripts\mp\flags::gameflaginit("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68", 0);
  scripts\mp\flags::gameflaginit("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA", 0);
  scripts\mp\flags::gameflaginit("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B", 0);
  scripts\mp\flags::gameflaginit("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B", 0);
  scripts\mp\flags::gameflaginit("_encstr_8C0D0E8410E8B112602F133F559DCAF4", 0);
  scripts\mp\flags::gameflaginit("_encstr_A9071177F53082F3938062C92B75DFFAD04BF4", 0);
  scripts\mp\flags::levelflaginit("_encstr_B1D70B39F657B932EBF6B3CAC9", 0);
  scripts\mp\flags::levelflaginit("_encstr_ACCF0A3B0BD6B2EBDB3BAC27", 0);
  scripts\mp\flags::levelflaginit("_encstr_A3980FDDEB85B6C0395D388BB85A53B517", 0);
  scripts\mp\flags::levelflaginit("_encstr_A9181D21AF6218182FBA0831613BCDC03F34F7F35E4F70D5A7D2C11BEABBF5", 0);
  scripts\mp\flags::levelflaginit("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F", 0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
  level.postgamenotifies = 0;
  level.intermission = 0;
  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", getdvarint("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D") == 1);
  setDvar("_encstr_82450B7DA6498471B6F76549B0", istrue(level.noweaponfalloff));
  setDvar("_encstr_816C0B09BDC1239643DBE4D980", istrue(level.armoronweaponswitchlongpress));

  if(scripts\mp\utility\game::matchmakinggame())
    setDvar("_encstr_976F124B6E350B3AB1A1A92CDA2D37B31DB0DA95", 1);
  else
    setDvar("_encstr_976F124B6E350B3AB1A1A92CDA2D37B31DB0DA95", 0);

  level thread initwaypointbackgrounds();

  if(!isDefined(game["_encstr_A9310C0449DDA97F583FADB0FD01"])) {
    game["_encstr_A3D2091BD84BB29B8EA519"] = 0;
    game["_encstr_AF851340BBA7C53FD36B0F07A1B438A990EE8E188E"] = 0;
    game["_encstr_A97F0BA8D3305737C2502325DC"] = 0;

    if(!isDefined(game["_encstr_991C0AB9ED5B57161FE89B83"]) || !isDefined(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
      thread scripts\engine\utility::error("_encstr_85FA36159546AEE1E309980AA715CB6887529810E9FDC3B0D4C5EBEBA21065A7B0369F0F47782565E96ACADB59E02B534139B6D0CF0A9F05");

    if(!isDefined(game["_encstr_991C0AB9ED5B57161FE89B83"]))
      game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";

    if(!isDefined(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
      game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";

    if(!isDefined(game["_encstr_A1AD062E09D98338"]))
      game["_encstr_A1AD062E09D98338"] = "_encstr_877508C1D8C22F2DDC3B";

    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_92A00F1952D2E3C82EB1E7196370C7131E"] = &"_encstr_A1ED12A983EFB71DE07A0E3083783F1F385FF149";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_85731176D2DA27089F03986873C7C35F23FD65"] = &"_encstr_85CD140FB9D81341CBE4C58940FBF9DC7E318F97A16D";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_8C8510035741B7FDDF68925A7887F3A7383D"] = &"_encstr_B8BA139439869EB17E7FBDA75615F14C9FA1ED9CE1";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_BABB19E6C158BBCDF583DBA537A3BEC6C2838EAE9C95AFDDC24BA3"] = &"_encstr_A93C1C6A82799AA005D539D705A794932AF5680A82A8AAA4157DBA82A42A";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_87CF12CDC1C2BBE6EB4E593B4BEC56BEBBB096A3"] = &"_encstr_A66515BD518A22BB5FEFE8E157856B6CF9D3372F0BD1BB";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_AF931B1780B650D09FFB790352631D594BE9AB8107DE50AD9FB2306BEB"] = &"_encstr_AD9D1E81ABC78F41C803E8682AE005B4C69789D95709A7A720FD751DB778DBDF";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_9B291483BB076725392DB5AE3358AF7F36B1FACAC3ED"] = &"_encstr_85D317853156A649037F6D672773B59F8F2DAFF6B3C1986DB5";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A1E40F8F0FF1C84EE108EB9FE70B66F148"] = &"_encstr_AF8F12DC6257E15790D70D27F3B81439878EC477";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_BA9D11DDB05AE82DE6D9FAD1BDEBCD838577DC"] = &"_encstr_936E149A419775A0924552C9E8D7519EAF9A0550EA39";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_AD3010732B0F47D7D1CAB0B5FA371CB0BB37"] = &"_encstr_8E2D13D889579517F6DDAFBC7DFDFF69172180F101";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_87B40FA056640823E9EFC1F3F303FB280F"] = &"_encstr_9BD71235D9022D87ADE51069CF85BF527173BE47";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_841C0D6C34B09B3BB2AF8D36B09B37"] = &"_encstr_A6FE1BBF1702B1746896A55DA6E3ACD6C7977920B7E1744F11390F2728";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_B4CA0D6517E33338F541F128F6CB58"] = &"_encstr_8A031B30EF70E7FCF965474DAF0135379627A988D5A3F361597FAD5EA1";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A2280B469090F6E23D374BDFBF"] = &"_encstr_822622790B48E7FC1573E9C10778F89780A6C074974105A43F1F39197B540E6FA9DEC468";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_B8411DCD634B3D09A31F5DED7F23FFCC30F2A178F3D8A95907681F08291895"] = &"_encstr_A97627538B396BA19F8E4C45214F7931B18EE7DB53202639EFD534DD1F67E97589CB2767B7199FD9C6";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_91350DDCAC63B2D847D7E6E085EE73"] = &"_encstr_853F103D67123B3079D35F1BFF9E2961A9CC";
    game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_B2C00CC86FA7E12D82621814FE0B"] = &"_encstr_AA1213A905BCA17ABA509211A9F5BA5065BE3DAA51";
    game["_encstr_928707BA60B92F0A9B"]["_encstr_83AB065EE1391A7B"] = (0, 0, 0);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_998806DD1A96D12B"] = (1, 1, 1);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_9972053972333A"] = (0.5, 0.5, 0.5);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_8690056688C20D"] = (0.35, 0.7, 0.9);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_B8BC07D01BBF370877"] = (0.9, 0.6, 0);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_B29B0550F33591"] = (0.2, 0.3, 0.7);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_8419044EB232"] = (0.75, 0.25, 0.25);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_932906F74A6F1818"] = (0.25, 0.75, 0.25);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_957407BAC223B9F05B"] = (0.65, 0.65, 0);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_ACFC091AE8AB2FCBE15119"] = (0.258824, 0.639216, 0.87451);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_88BF06FD784A6393"] = (0.929412, 0.231373, 0.141176);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_93B508770F528D90B3DB"] = (1, 0.858824, 0);
    game["_encstr_928707BA60B92F0A9B"]["_encstr_A7A408B9CA5D1D4E2C63"] = (1, 1, 1);
    [[level.onprecachegametype]]();
    setdvarifuninitialized("_encstr_AFBA0B534DA5D25A963DA0B4D4", 5);

    if(!level.splitscreen) {
      level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_8F170C57538A2E88D8F7FB901DB4");
      level.prematchperiodend = getdvarint("_encstr_85F6186F966321C7B788A810A5332B2B8053CC380BD9E150DDC5", 15);
    }

    if(_func_426()) {
      setnojipscore(1, 1);
      setnojiptime(1, 1);
    } else {
      setnojipscore(0, 1);
      setnojiptime(0, 1);
    }
  } else {
    setdvarifuninitialized("_encstr_AFBA0B534DA5D25A963DA0B4D4", 5);

    if(!level.splitscreen) {
      scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_8F170C57538A2E88D8F7FB901DB4");
      level.prematchperiodend = getdvarint("_encstr_ACCD189B1B27AFEC58B6ACF5277BABB9C8373A58393A8E5AB6B2", 5);
    }
  }

  if(!isDefined(game["_encstr_9A8507BA4040188D08"]))
    game["_encstr_9A8507BA4040188D08"] = "_encstr_81190407A676";

  if(!isDefined(game["_encstr_8E8405EA382B2A"]))
    game["_encstr_8E8405EA382B2A"] = "_encstr_921F052955D419";

  if(!isDefined(game["_encstr_9B920B8EAC166BFAD186E49595"]))
    game["_encstr_9B920B8EAC166BFAD186E49595"] = "_encstr_83E4052BCF5026";

  if(!isDefined(game["_encstr_8DB30A47B216ADEB99EDAE39"]))
    game["_encstr_8DB30A47B216ADEB99EDAE39"] = "_encstr_AF18056FA33E78";

  if(!isDefined(game["_encstr_B6B30A098586B0784B5A0B11"]))
    game["_encstr_B6B30A098586B0784B5A0B11"] = "_encstr_81190407A676";

  if(!isDefined(game["_encstr_93ED097B8081DD415F0BD8"]))
    game["_encstr_93ED097B8081DD415F0BD8"] = "_encstr_921F052955D419";

  if(!isDefined(game["_encstr_A16D07532531CB4BF7"]))
    game["_encstr_A16D07532531CB4BF7"] = "_encstr_820E07FAE8780B3A4C";

  setDvar("_encstr_8ADD0CABA5AFEDECB2271D2DB6AC", scripts\mp\utility\game::inovertime());

  if(!isDefined(game["_encstr_B18F0BDD815F4151AECB982052"]))
    game["_encstr_B18F0BDD815F4151AECB982052"] = 0;

  if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]))
    game["_encstr_8DC30DAA0285FD69FAE113371B1934"] = 0;

  if(!isDefined(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"]))
    game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] = 0;

  if(!isDefined(game["_encstr_8A800BA8806B8FB3601890C541"]))
    game["_encstr_8A800BA8806B8FB3601890C541"] = 0;

  if(!isDefined(game["_encstr_96DF0BCC92723B8A59E7F338A1"]))
    game["_encstr_96DF0BCC92723B8A59E7F338A1"] = 0;

  if(!isDefined(game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"]))
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = "_encstr_B40101";

  setomnvar("_encstr_96230E23CB3F42E9E330E76BD01BAE8A", game["_encstr_96DF0BCC92723B8A59E7F338A1"]);

  if(!isDefined(game["_encstr_B81B0A39EDABE69137D5BDCD"]))
    game["_encstr_B81B0A39EDABE69137D5BDCD"] = [];

  if(!isDefined(game["_encstr_96040B1D59B0AD35B1F64E599B"]))
    game["_encstr_96040B1D59B0AD35B1F64E599B"] = [];

  if(!isDefined(game["_encstr_8AC00BAB7C452B05C2338B8B83"]))
    game["_encstr_8AC00BAB7C452B05C2338B8B83"] = 0;

  if(!isDefined(game["_encstr_AD900E232359BABC98958F964BC1DCE2"]))
    game["_encstr_AD900E232359BABC98958F964BC1DCE2"] = 0;

  if(!isDefined(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"]))
    game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] = "_encstr_8BBA05185F8B99";

  if(!isDefined(game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"]))
    game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"] = 0;

  if(!isDefined(game["_encstr_883713937828897747AB8029C109B9058012E7F399"]))
    game["_encstr_883713937828897747AB8029C109B9058012E7F399"] = 0;

  level.initship = 0;
  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("_encstr_B2020AE1F36BF74429D93F01");
  setdvarifuninitialized("_encstr_955E13729906EFE7B9AF24378161E7AF2E90FA8AA0", 0);
  setdvarifuninitialized("_encstr_8D9B112D074310378FF7141FC16538FB931B25", 0);
  level.testrandomrealismclients = getdvarint("_encstr_B41F175780D3FF836B98AF65716FFB8DD960B7EF58AE303B49", 0) == 1;
  level.get_wave_max_count = getdvarint("_encstr_AC2013AB1EBA317CC26F2B577FBA31B055B5108087", 0);
  level.loadout_updateclassdefault_weapons = scripts\mp\utility\game::isanymlgmatch();
  level.tacticalmode = scripts\mp\utility\game::matchmakinggame() && getdvarint("_encstr_8BFF0D53095E177378BFF4E15790BD") || getdvarint("_encstr_925916E7EF1ED14710B857D173F88B9B7B0737134BC82A3D");

  if(level.tacticalmode)
    setomnvar("_encstr_8AF91045697F4BC356D250B8FAE19BA0CB0D", 1);

  if(level.tacticalmode) {
    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

    setDvar("_encstr_8C5A0B269C9EA5152A1413B4A7", 1);
    setDvar("_encstr_B488137F51963AC6A314CFD68B811582E78D8BBFD1", 0);
  }

  if(level.hardcoremode)
    logstring("_encstr_97331427A1DD6588DDFA210F4A87CA47BD5083E563E5");

  level.diehardmode = getdvarint("_encstr_96050CDCD839EB46B4560D58938C");
  level.casualscorestreaks = getdvarint("_encstr_AF9C1C4776324FA223DAF53FC9909A2B51ABDA1668434737C55A4A76B2B7");
  level._id_145EC = getdvarint("_encstr_B13819BFD77BF0580935D9965BE2909FB46709393F432E2B218C03");

  if(!isDefined(level.crankedbombtimer))
    level.crankedbombtimer = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_91B612AFC69C0B9BDA2B4609B7AD4C452DDA5993", 0);

  level.supportcranked = scripts\engine\utility::ter_op(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_91B612AFC69C0B9BDA2B4609B7AD4C452DDA5993") > 0, 1, 0);

  if(!level.teambased)
    level.diehardmode = 0;

  if(level.diehardmode)
    logstring("_encstr_ADEC1337217585C28368F452C8621050577CD7C31D");

  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95630BD73B2CADC1964E969BB6", "_encstr_8575137616EB7729A10F98517BF92061E2FAE3FE6D");

  if(level.matchrules_vampirism)
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

  level.finalkillcamtype = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_BA4F0D51325B4AFCF99017FB78B3AD", "_encstr_96C315C3E8153977C969BD8F729003BD5F80AA2990A96F");

  if(level.finalkillcamtype == 2)
    level.skipfinalkillcam = 1;

  level.allowkillstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95591220F12318474310E0D07A1A39937F99B2AE", "_encstr_BA491AF3471051173F38CA5181817315607F9164C1B0239BD551229B");
  level.roundretainstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_9214148FB570C0029582523B020922E79B2351CA4207", "_encstr_A9BB1C33693E77D718C34577D5401BEB6D272ACBB11B7B0248E57D519FF8");
  level.roundretainstreakprog = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95AB17D79CBDEACD2325CAD12C4BCDA9A39395B0DA05277B9D", "_encstr_8E091F8E5BF3D68F1E9A78A143B5934803F21D85B14738AF03136068CA82552077");
  level.deathretainstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_B1CC147D19B20BD1A1252B47C296CD9A3A9CACC25BCD", "_encstr_99C41C224EE5F16F21788F5F0899210B894E2F9B277B5A836B6887AF1833");
  level.allowperks = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_97390CEB58638DDE77055993B56E", "_encstr_A53A14CFC7C6099FF840BF09F9A8AC421C391FB3BFEE");
  level.allowsupers = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_ADCD0D3760636950DFF10BF3376B03", "_encstr_97CE1593B8454907B939EDDFC7E0D38DA7A17B1B201D3A");
  level.superfastchargerate = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_879115AF9BEAC195E4322C6EE834A1C239EC564AB0D156", "_encstr_81751D4F98CBD7FA5321C7711653C3B593D97FC7B84528428DCCCF3A7709AA");
  level.superpointsmod = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_87141028FB5F835B0A99D8E052A32F7C5F94", "_encstr_858F18D7DE83CFBF1890D14F02CB5B027DE71738ED342E77A527");
  level.spawnprotectiontimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_AD2E167DE60E85EE370593F61DAC6C47D2DB9BA296D62BE4", "_encstr_8ECC1E63506D78E759BB13885A19495F35E9D3E049D7031D2B8568D5784F3033");
  level.lethaldelay = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F870DFA1BCA3A342C8D88598D165E", "_encstr_ACFE154B609DA1EF41D1050779E9EB34E37040A28013E0");
  level.equipmentmatchstartshieldms = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_ACD814F595C5AE96836B59E647D4358227DB8E2BD88E", "_encstr_8EC81CCD8D93AF9D85B5ACF5AC17AE4BE0B695B9E8D46A41C97BD12B8D47") * 1000;
  level.magcount = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_810D0A69F05B4F1F603DEE0C", "_encstr_932D120B7E330FA19A8B7B714540FFA76F4BA86C");

  if(!isDefined(level.practiceround))
    level.practiceround = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_AB010FC6324238867BE78F9B1392D508EC", "_encstr_95E2176EC693D7CE58DAB2FA072785D8E896369592B7BAB923");

  level.postgameexfil = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_82ED0FBF67A03FD3596349FF25FB4D3314", "_encstr_82DB17C6CB18A0DC51A1D3F787C753C00C8F893781B885ECE5");
  level.exfilactivetimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A38C1226E148469223A5A7B84B0EF335FB5917DB", "_encstr_91631A0BD64B514A5953575747B86C5B4DEF3123A933070FC8CF0F2A");
  level.exfilextracttimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8FB213FACAF0CCD21B51F0E839B0B11D2A96B5CA27", "_encstr_81A61B7BCF98D98FA7B072D99903D30C63FBF8E445B81E0BC528CA6203");
  level.useammorestocklocs = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_888514FA57DCCA28ADB5ED25569B8EDE6CDA62B7B16E", "_encstr_B6AC1CDC6C39BE3B16B6957D5D9B59506BDA7B2959DCE8DBC65B26F68DB9");
  level._id_136D8 = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_AC0C128F19B324D80F4EC829E8B735D6BB99A3C3", "_encstr_8D711AF8DB2640CF4E2A3D4F7F4103675F8BC2504AA3A5539CA8984D");
  setDvar("_encstr_9B270A70DC9083EA9955848B", level._id_136D8);
  level.laststand = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_A5510A30AA778D28B3C97D51");
  setomnvar("_encstr_91A013D52DEBB185E6D1F5E6D1169B8CEBD197C12B", level.laststand);

  if(scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    scripts\mp\teamrevive::init();

  if(scripts\mp\utility\game::usingfallback())
    getintorzero();

  level.minimaponbydefault = (getdvarint("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669") != 0 || getdvarint("_encstr_9195174B1146FF5AC84FEFE46380E61FE16B2092D8938F16E0") != 0) && !istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]);
  var_0 = scripts\mp\utility\game::getgametype();
  level.radarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + var_0 + "_encstr_A9FE105F9286F8671B48E831E2EB2BE05F0B", "_encstr_9B7018DCB127EB76B0D695FAC9B0C81639842D46AC285AE6CECD");
  setomnvar("_encstr_9B5825EAB4AF36DB5BC185CDE6AF862D192BAFEE59C283BDDC7D83A5DCEC6EBEB5A59B4BB6C238", level.radarhideshots);
  level.navbarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + var_0 + "_encstr_A3EC11673719EBBEEBB0988228CBE24F107CB3", "_encstr_8A3F19076FC348D091AD51EE9579900E2A83C9BBEBDAB7F8A6079B");
  setomnvar("_encstr_A1A5242812514F6027E82F1EC3C7C803C7BA01B04A76A1B8D3DFAF1BA67F93A7AD42C080A24A", level.navbarhideshots);
  level.navbarhideenemies = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + var_0 + "_encstr_B68711EBB90BD94885E4214B46CA2ACD566BE5", "_encstr_B6A01973C790D197BFB84AD1E0879BDE508D30E15180EF6B555083");
  setomnvar("_encstr_87531D1713108AD7D8A3FE42FB71E8E2559337AFF5A5D2892108F60B31683A", level.navbarhideenemies);
  level.disablesupersprint = getdvarint("_encstr_92B31E6A264B092BC11117337037231243783E7CC10BFB4133223723527088C3");
  level.loadout_updateammo = getdvarint("_encstr_AF7F18B9B1C9EBE0B1B0BC2BC9AFC8D29BB0988D5653DEABE6D1");
  level.disablebattlechatter = getdvarint("_encstr_8FE51EB3E9BEF7579843C5F779F01A57EE60AA283115934D4007F0D12140A7D3");
  level.little_bird_mg_mp_init = getdvarint("_encstr_82DB1AC6CB18A0DC51A1D3F78DDF53689EBB8DA7D80897EB654EBD7A");
  level.scoremod = [];
  level.scoremod["_encstr_ABD70578F3D02C"] = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172");
  level.scoremod["_encstr_AD75063D571AE108"] = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_82A310D12BF5E3F8EB336FFD2A73C1BB9B12");
  level.scoremod["_encstr_848909BBD3A7526348E8E3"] = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_AC5C15FF61C8EA16D0037407796833B290F10347356DF3");
  level.scoremod["_encstr_B452070CBB88B90AF1"] = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A6D511FA38DBA5CDA3CD0A2BC9D235B42DB136");

  if(level.practiceround && !isDefined(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"] = 1;
    level.roundretainstreaks = 0;
    level.roundretainstreakprog = 0;
    level.ignorescoring = 1;
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_8271138F5748770231D88B9241513A1FE1451903FD";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_8271138F5748770231D88B9241513A1FE1451903FD";
  }

  setomnvar("_encstr_8A601657B4F5ADB03A1B867D1D96D6599CFA4396198C95CD", 1);

  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(scripts\mp\utility\game_utility_mp::_id_11C7F()) {
      level.allowkillstreaks = 0;
      setomnvar("_encstr_A5661797FBE85919EE3F91A02F01389B093CD2B3BBF25ACF4A", 1);
    } else
      setomnvar("_encstr_A5661797FBE85919EE3F91A02F01389B093CD2B3BBF25ACF4A", 0);
  } else {
    setomnvar("_encstr_A5661797FBE85919EE3F91A02F01389B093CD2B3BBF25ACF4A", 0);
    setomnvar("_encstr_85D719BDA2513D8067493554C147D51FE9044365D9D406F794FA0A", 0);
  }

  level.disablecopycatloadout = 1;
  setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
  scripts\cp_mp\utility\game_utility::getlocaleid();
  logstring("_encstr_8EDF1BAD96A82BEB35E9A62A724557106A8E2C27A31D58B6B28AF238CA");
  logstring("_encstr_8A0D262BA2A2A1639A7F9FC1C1CFDA3175AAA9776E5DC90572CA82BDDA62970A29A2158AD9DEB5C1");
  logstring("_encstr_B1E710081035B00747040840010240081001" + level.script);
  logstring("_encstr_93841080044D1B27B4C18E47800804048001" + scripts\mp\utility\game::getgametype());
  logstring("_encstr_87091030DF28F98AC9AB822645C226F81289" + level.hardcoremode);
  logstring("_encstr_A31210EE57CD82920397D239526EC6890FC6" + level.diehardmode);
  logstring("_encstr_85F610C946776AC1B22FA886222F6872C820" + getdvarint("_encstr_82570B397A4D3192935192A562"));
  logstring("_encstr_828C10F1FEAA8045E29B6559A22E27427056" + game["_encstr_8DC30DAA0285FD69FAE113371B1934"]);
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_B1680DAFDF22A088453D2D98643C52" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_88520CD11BF6EF7BAF2CF3F931B3"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_85490DD793EDD59B46632DB64BD110" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_BE630CD7BD584DEB188ADCEFECB0"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_8FA70B0F6F2280D8A99DE05BD6" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_B28B0AAFBB2DB9B1B4DA2DE8"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_AAAF0C862BCFD14845318B9B343E" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_8D700B99D6A5590D4C9B3DFF7A" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D311D9826EB896"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_84170BCF41988D03A5887AE2B9" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A6F20AA6CACF71702351EBE3"));
  logstring("_encstr_A1B807F66AC3E220A1" + scripts\mp\utility\game::getgametype() + "_encstr_87280E57CD90734E387BD35C73E880DE" + getDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_85730D60523A2308A47708E073FB80"));
  logstring("_encstr_8A0D262BA2A2A1639A7F9FC1C1CFDA3175AAA9776E5DC90572CA82BDDA62970A29A2158AD9DEB5C1");
  level.usestartspawns = 1;
  level thread scripts\mp\infilexfil\infilexfil::infil_init();
  scripts\mp\utility\spawn_event_aggregator::init();
  scripts\mp\utility\lui_game_event_aggregator::init();
  scripts\mp\utility\disconnect_event_aggregator::init();
  scripts\mp\utility\player_frame_update_aggregator::init();
  scripts\cp_mp\ent_manager::init();
  scripts\mp\playerlogic::init();
  scripts\cp_mp\utility\game_utility::teamwipedobituary();
  level.maxallowedteamkills = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A34C0F76FA03BF3815E167A93C3C30FB93", "_encstr_849C17681B85578FD7996971E448AF4B98B8809AF86AB83FC9");
  thread scripts\mp\init_cp_mp::init();
  thread scripts\mp\teams::init();
  _calloutmarkerping_handleluinotify_cleared::_id_13A9E();
  scripts\cp_mp\utility\player_utility::temp_debug_wait_and_stop_music_loop();
  thread scripts\common\utility::allow_init();
  thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  thread scripts\cp_mp\utility\game_utility::game_utility_init();
  thread scripts\mp\playeractions::init();
  thread scripts\mp\healthoverlay::init();
  thread scripts\mp\killcam::init();
  thread scripts\mp\final_killcam::initfinalkillcam();
  thread scripts\cp\vehicles\vehicle_compass_cp::init();
  thread scripts\mp\equipment\fulton::init();
  scripts\mp\utility\dialog::initstatusdialog();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    thread scripts\mp\battlechatter_mp::init();
  else if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\battlechatter_mp::init();
  else
    level.battlechatterenabled = 0;

  thread scripts\mp\music_and_dialog::init();
  thread scripts\mp\class::init();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\persistence::init();

  thread scripts\mp\rank::init();
  thread scripts\mp\playercards::init();
  thread scripts\mp\menus::init();
  thread scripts\mp\hud::init();
  thread scripts\mp\serversettings::init();
  thread scripts\mp\weapons::init();
  thread scripts\mp\outline::init();
  thread scripts\mp\shellshock::init();
  thread scripts\mp\deathicons::init();
  thread scripts\mp\damagefeedback::init();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    thread scripts\cp_mp\vehicles\vehicle_collision::init();
    thread scripts\cp_mp\vehicles\little_bird_mg::init();
  } else {
    thread scripts\mp\matchdata::init();
    thread scripts\mp\clientmatchdata::init();
  }

  thread scripts\mp\awards::init();
  thread scripts\mp\playerlogic::initsegmentstats();

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\mp\playerlogic::updateinputtypewatcher);

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\mp\weapons::set_cp_vehicle_health_values);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
    level scripts\common\ui::lui_registercallback("_encstr_A7AB19E0C6C25EF558ECB0A5CDAFDCE2570B19AFE459C5AECACD1D", ::_id_12443);

  thread scripts\mp\passives::init();
  thread scripts\mp\perks\perks::init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
    thread scripts\cp_mp\killstreaks\init::init();
    thread scripts\mp\perks\perks::initspecialistkillstreaks();
  }

  thread scripts\mp\events::init();
  thread scripts\mp\archetypes\archcommon::init();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\whizby::init();

  thread scripts\mp\analyticslog::init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    thread scripts\mp\loot::init();
    thread scripts\mp\supers::init();
    thread scripts\mp\supers::watchsuperdelay();
  }

  thread scripts\mp\callouts::init();
  thread scripts\mp\bounty::init();
  thread allow_weapon_mp_init();
  thread ismp_init();
  thread scripts\cp_mp\gestures::init();
  thread scripts\mp\gestures_mp::init_mp();
  thread scripts\mp\accessories::init();
  thread scripts\cp_mp\execution::execution_init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    thread scripts\mp\turret::init();

  thread scripts\mp\laststand::init();
  thread scripts\mp\equipment::init();
  thread scripts\mp\matchstats::init();
  thread scripts\mp\playerstats::init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    thread scripts\cp_mp\auto_ascender::init();
    thread scripts\cp\utility\script::init();
    thread scripts\mp\outofbounds::initoob();
    thread scripts\cp_mp\targetmarkergroups::init();
  }

  thread scripts\mp\potg::init();
  thread scripts\mp\utility\trigger::triggerutilityinit();
  thread scripts\cp_mp\entityheadicons::init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    thread scripts\mp\spawnselection::init();
    thread scripts\mp\spawncamera::init();
    thread scripts\mp\juggernaut::init();
    thread scripts\mp\door::door_dynamic_setup();
    thread scripts\mp\flashpoint::init();
    thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  }

  thread scripts\mp\hud_message::init();
  level.allowreviveweapons = getdvarint("_encstr_B8241B93B845495B183FF1E54E86AB0FA5704B4AA01FBF0F1117E01768", 0);
  scripts\mp\playeractions::registeractionset("_encstr_81CA0CCAF9E0392BF5E79B8FF725", ["_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_8F0508CE59DCA357392B", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_AD1904291F7B", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8"]);
  scripts\mp\playeractions::registeractionset("_encstr_A5DD0E76585B56517332199395594FAC", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_AD1904291F7B", "_encstr_88780599B4E495", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", "_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_964E0BB08D63B7BBF553EA5BC1", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_A6C7065BACB1CA95"]);

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata())
    thread scripts\mp\codcasterclientmatchdata::init();

  thread scripts\mp\accolades::init();
  thread scripts\cp_mp\utility\train_utility::init();
  scripts\common\utility::allow_add("_encstr_BE8F0A272F9B2BE97268AE8B", scripts\mp\equipment::allow_equipment);
  scripts\common\utility::allow_add("_encstr_8F0508CE59DCA357392B", scripts\mp\utility\player::allow_gesture);
  scripts\common\utility::allow_add("_encstr_BEF4071AA87BDF5220", scripts\common\utility::allow_supers);
  scripts\common\utility::allow_add("_encstr_A9350D834DDE8871B8C7AD38FF21E2", scripts\mp\utility\player::allow_health_regen);
  scripts\common\utility::allow_add("_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F", scripts\mp\utility\player::allow_one_hit_melee_victim);
  scripts\common\utility::allow_add("_encstr_8E400866D8589B1AB2C8", scripts\mp\utility\player::allow_flashed);
  scripts\common\utility::allow_add("_encstr_8ED90887F39B73AD5BFF", scripts\mp\utility\player::allow_stunned);
  scripts\common\utility::allow_add("_encstr_83290B682399813F110463F9DD", scripts\mp\utility\player::allow_stick_kill);

  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      if(!isDefined(game["_encstr_B81B0A39EDABE69137D5BDCD"][var_2]))
        game["_encstr_B81B0A39EDABE69137D5BDCD"][var_2] = 0;

      if(!isDefined(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2]))
        game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2] = 0;
    }
  }

  if(game["_encstr_A16D07532531CB4BF7"] != "_encstr_8B6D0940CC35339149DA08" && game["_encstr_A16D07532531CB4BF7"] != "_encstr_AADE09481E247875C2EFAB") {
    if(!(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0 && scripts\mp\utility\game::ismoddedroundgame())) {
      game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"] = 0;
      game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"] = 0;
    }
  }

  setomnvar("_encstr_8CCC15AEB4BEB49BD7ED9D5693A34BDA59D7C9DBD5E68C", game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08");
  game["_encstr_A9310C0449DDA97F583FADB0FD01"] = 1;
  level.currentround = game["_encstr_8DC30DAA0285FD69FAE113371B1934"] + 1;
  level.maxplayercount = 0;
  level.activeplayers = [];

  foreach(var_5 in level.teamnamelist) {
    level.wavedelay[var_5] = 0;
    level.lastwave[var_5] = 0;
    level.waveplayerspawnindex[var_5] = 0;
    level.aliveplayers[var_5] = [];

    if(!istrue(level._id_12C49))
      level.requiredplayercount[var_5] = 0;
  }

  setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", 0);
  setDvar("_encstr_A744140DDAF1C720F1D777172C20C0A5FFC0163BF76B", 1);

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 0);
    setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 0);
  }

  if(scripts\mp\utility\game::getgametypenumlives())
    setDvar("_encstr_8C3C0A99C0159584534AB827", 0);
  else
    setDvar("_encstr_8C3C0A99C0159584534AB827", 1);

  updatewavespawndelay();
  level.graceperiod = 15;
  level.ingraceperiod = level.graceperiod;

  if(!isDefined(level.roundenddelay))
    level.roundenddelay = 6;

  level.playovertime = 0;
  level.finalroundenddelay = 3;
  level.halftimeroundenddelay = 3;
  level._id_127FE = 0.25;
  level.scorelimit = scripts\mp\utility\dvars::getwatcheddvar("_encstr_B6FB0B93B87F020F183BE5E94D");
  level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("_encstr_95BD0B27EDABDC468DA5D62D8E");
  level.winlimit = scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1");

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    setomnvar("_encstr_BA0211D5D2FAD8D5399CCA37A3F539F657E646", level.currentround);
  else if(level.roundlimit != 1)
    setomnvar("_encstr_BA0211D5D2FAD8D5399CCA37A3F539F657E646", level.currentround);

  if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * (game["_encstr_8DC30DAA0285FD69FAE113371B1934"] + 1);
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(scripts\mp\utility\game::resetscoreonroundstart()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = 0;
    setteamscore(game["_encstr_991C0AB9ED5B57161FE89B83"], 0);
    game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = 0;
    setteamscore(game["_encstr_B6A70A23CA6659DC91CAE4DC"], 0);
  }

  if(scripts\mp\utility\game::isovertimesupportedgametype() && scripts\mp\utility\game::inovertime())
    scripts\mp\gamescore::updateovertimescore();

  if(level.teambased) {
    foreach(var_5 in level.teamnamelist)
    scripts\mp\gamescore::updateteamscore(var_5);
  }

  thread updateuiscorelimit();
  level notify("_encstr_8C2B122F80E5E7E4696E583FF81B01F8E98B4898");

  if(isDefined(level.matchrecording_init))
    level thread[[level.matchrecording_init]]();

  if(getdvarint("_encstr_BA9B1A0FFE401F51F4B8981F5F60A3634332A3AF92478E4737E0D486", 0) == 0 || scripts\mp\utility\game::tv_station_intro_camera())
    setomnvar("_encstr_8FD919F880F16D662B3B898F9A940FB5795158FD586BAB1D8DA3EB", 1);

  [[level.onstartgametype]]();
  level thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::onplayerconnectcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(_encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::onplayerdisconnectcommon);
  level.scorepercentagecutoff = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_87891AA16B86BF2BFF2F4FCDFA1F3175ABD2E8C801DEF3A33F375CB4", 70);
  level.timepercentagecutoff = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F2A19AFE85A5B56AF38B293C6CADC3A16B356AFB1578EAFBD66CC", 70);

  if(getDvar("_encstr_962E0A23568CD236C2E85946") == "_encstr_993D154A20C15C8FD1CD958CCF5CCF2DF138C2A3C0ABD2" || getDvar("_encstr_962E0A23568CD236C2E85946") == "_encstr_A3751A4656234B362C3ACA23089673D1CA4EB9CA4710CDCA4E675627")
    thread verifydedicatedconfiguration();

  thread startgame();
  level thread scripts\mp\utility\dvars::updatewatcheddvars();

  if(!istrue(level.istacops))
    level thread timelimitthread();

  level thread updateleaderboardstatscontinuous();
  level thread scripts\mp\playerlogic::updateplayerwindmaterial();
  level thread _id_12C14();
}

updatewavespawndelay(var_0, var_1) {
  if(isDefined(var_0))
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122", var_0);

  if(isDefined(var_1))
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_868016716B3753D79353D3D873BB5D436D60EA9BF69FF34B", var_1);

  var_2 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122");
  var_3 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_868016716B3753D79353D3D873BB5D436D60EA9BF69FF34B");

  if(var_2) {
    foreach(var_5 in level.teamnamelist) {
      level.wavedelay[var_5] = var_2;
      level.lastwave[var_5] = 0;
    }

    level thread wavespawntimer();
  }
}

verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("_encstr_93390B136AA2628AA8A93529D4"))
      exitlevel(0);

    if(getDvar("_encstr_962E0A23568CD236C2E85946") != "_encstr_993D154A20C15C8FD1CD958CCF5CCF2DF138C2A3C0ABD2" && getDvar("_encstr_962E0A23568CD236C2E85946") != "_encstr_A3751A4656234B362C3ACA23089673D1CA4EB9CA4710CDCA4E675627")
      exitlevel(0);

    wait 5;
  }
}

timelimitthread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\mp\utility\game::gettimepassed();

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    waittillframeend;
    thread checktimelimit(var_0);
    var_0 = scripts\mp\utility\game::gettimepassed();

    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000 || istrue(level.playerplaygestureweaponanim)) {
        waitframe();
        continue;
      }
    }

    wait 1;
  }
}

updateuiscorelimit() {
  for(;;) {
    level scripts\engine\utility::waittill_either("_encstr_8C2B122F80E5E7E4696E583FF81B01F8E98B4898", "_encstr_99DD1075E1205EDBBDFE6BB2E001E7151081");

    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("_encstr_8FF119C32B2FB02533F57B446ADB08EB42505FD16BA8888B210B5B", scripts\engine\utility::ter_op(var_1.team == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
          var_1 setclientomnvar("_encstr_8A0416B3C8487F75D8237957F9507DA790C3AA99313D27AB", scripts\engine\utility::ter_op(var_1.team != game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
        }

        setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"], 1));
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("_encstr_8FF119C32B2FB02533F57B446ADB08EB42505FD16BA8888B210B5B", scripts\engine\utility::ter_op(var_1.team == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
          var_1 setclientomnvar("_encstr_8A0416B3C8487F75D8237957F9507DA790C3AA99313D27AB", scripts\engine\utility::ter_op(var_1.team != game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
        }

        setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"], 1));
      } else if(scripts\mp\utility\game::iswinbytworulegametype()) {
        var_5 = game["_encstr_B81B0A39EDABE69137D5BDCD"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]];
        var_6 = game["_encstr_B81B0A39EDABE69137D5BDCD"][game["_encstr_991C0AB9ED5B57161FE89B83"]];
        var_7 = 0;

        if(var_5 == var_6)
          var_7 = var_5 + 2;
        else if(var_5 > var_6)
          var_7 = var_5 + 1;
        else
          var_7 = var_6 + 1;

        setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", var_7);
      } else
        usenormalscorelimit();

      continue;
    }

    usenormalscorelimit();
  }
}

usenormalscorelimit() {
  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", level.totalscorelimit);
    thread checkscorelimit();
  } else
    setomnvar("_encstr_97390EAE5AFA6EC6F6275963B4ADB48E", level.winlimit);
}

playtickingsound() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A3410DDE7B9281B62CF750189F5EC9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.bombtimer;

  for(;;) {
    self playSound("_encstr_BE3D19DB59F9401F5F2BBB2043775F788FAA6773FA51D0EBFF6253");

    if(var_0 > 5) {
      var_0 = var_0 - 1;
      wait 1;
    } else {
      var_0 = var_0 - 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify("_encstr_A3410DDE7B9281B62CF750189F5EC9");
}

relic_bang_and_boom_dropfunc(var_0) {
  if(var_0 > 20)
    return "_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40";
  else if(var_0 > 10)
    return "_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603";
  else if(var_0 > 5)
    return "_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B";
  else if(var_0 > 1.5)
    return "_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D";
  else
    return "_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7";
}

timelimitclock() {
  level endon("_encstr_88B018F8678EB113121977882D5A4B58EBEFF8A1DB5109C90A3F");
  waitframe();

  if(isDefined(level._id_13B7E)) {
    thread[[level._id_13B7E]]();
    return;
  }

  if(scripts\mp\utility\game::gettimelimit() == 0) {
    return;
  }
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_0 hide();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted)) {
      var_5 = gettimeremaining() / 1000;
      var_6 = int(var_5 + 0.5);
      var_7 = 0;

      if(var_4 == 2 && var_6 % 2 == 1)
        var_7 = 1;

      if(!var_1 && (var_7 == 1 && var_6 == 61 || var_7 == 0 && var_6 == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("_encstr_B6D10E47B4AD569BD5E0D7E6B41ED197");
        level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_84EF055338A18F");
        var_1 = 1;
      } else if(!var_2 && (var_7 == 1 && var_6 == 31 || var_7 == 0 && var_6 == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("_encstr_991A0FAC63784712234049F3E8730A5B52");
        var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("_encstr_865408FD9C120BD3CD73");
        level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_84EF055338A18F");
        var_2 = 1;
      } else if(!var_1 && !var_2 && !var_3 && (var_6 >= 30 && var_6 <= 45)) {
        var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("_encstr_865408FD9C120BD3CD73");
        level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_84EF055338A18F");
      }

      if(var_6 <= 10 || var_6 <= 30 && var_6 % var_4 == var_7) {
        if(!var_3 && var_6 <= 10)
          var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("_encstr_865408FD9C120BD3CD73", var_6);

        level notify("_encstr_A15F178159EB5191911A2078F2F5B76E4BC596038F2F18D785");
        var_8 = 1;

        if(var_6 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var_6)
          var_8 = 0;

        if(var_8) {
          var_9 = relic_bang_and_boom_dropfunc(var_5);
          var_0 playSound(var_9);
        }
      }

      if(var_5 - floor(var_5) >= 0.05) {
        wait(var_5 - floor(var_5));
        continue;
      }
    }

    wait 1.0;
  }
}

_id_1330A() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_ACF906B79752C5E8":
    case "_encstr_B807035284":
    case "_encstr_A9B606B0C956B916":
      return 1;
    default:
      return 0;
  }
}

gametimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(game["_encstr_AF90181784B678DDB34A7861A07318C8C5E991AF309290AFC3B3"]))
    level.starttimefrommatchstart = game["_encstr_AF90181784B678DDB34A7861A07318C8C5E991AF309290AFC3B3"];

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level.starttime = gettime();
  level.discardtime = 0;
  level.overtimetotal = 0;

  if(!isDefined(game["_encstr_AF90181784B678DDB34A7861A07318C8C5E991AF309290AFC3B3"])) {
    game["_encstr_AF90181784B678DDB34A7861A07318C8C5E991AF309290AFC3B3"] = gettime();
    level.starttimefrommatchstart = gettime();
    scripts\common\utility::_id_13E0A(level._id_11B33);
  }

  if(isDefined(game["_encstr_887E1F277BD5B9196A96C6C65ACD566CF6B932CD14B1E4958532F20516B99BACC8"])) {
    level.starttime = level.starttime - game["_encstr_887E1F277BD5B9196A96C6C65ACD566CF6B932CD14B1E4958532F20516B99BACC8"];
    game["_encstr_887E1F277BD5B9196A96C6C65ACD566CF6B932CD14B1E4958532F20516B99BACC8"] = undefined;
  }

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] < 24)
    setmatchdata("_encstr_923919CFF1A6317FA0C8E72263E8AA8B9563170727DD6A274091DA", game["_encstr_8DC30DAA0285FD69FAE113371B1934"], getsystemtime());

  var_0 = gettime();

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    if(!level.timerstopped)
      game["_encstr_B18F0BDD815F4151AECB982052"] = game["_encstr_B18F0BDD815F4151AECB982052"] + (gettime() - var_0);

    var_0 = gettime();
    wait 1.0;
  }
}

updatetimerpausedness(var_0) {
  var_1 = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && var_1) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
    var_2 = gettimeremaining();

    if(isDefined(var_0))
      setgameendtime(var_0);
    else
      setgameendtime(gettime() + int(var_2));

    setomnvar("_encstr_B1CE17D55AAF6B85D13643F5E896AD2B39D76EE87BC1835932", 1);
  } else if(level.timerstopped && !var_1) {
    level.timerstopped = 0;
    level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
    var_2 = gettimeremaining();

    if(isDefined(var_0))
      setgameendtime(var_0);
    else
      setgameendtime(gettime() + int(var_2));

    setomnvar("_encstr_B1CE17D55AAF6B85D13643F5E896AD2B39D76EE87BC1835932", 0);
  }
}

pausetimer(var_0) {
  if(!level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness(var_0);
  }
}

resumetimer(var_0) {
  if(level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness(var_0);
  }
}

startgame() {
  setslowmotion(1, 1, 0);
  thread gametimer();
  level.timerstopped = 0;
  level.timerstoppedforgamemode = 0;
  setomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F", 1);
  prematchperiod();
  sysprint("_encstr_978F12092BEB3FC719247F7AEF9D578531C88393");
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(getdvarint("_encstr_A39721FFD7C2B9A0DA9D68EE583B49B7191FFC7F033A52DA07400AF9D72F9004886FBF", 1) == 1) {
    foreach(var_1 in level.players) {
      scripts\mp\playerlogic::clearprematchlook(var_1);
      var_1 scripts\mp\utility\player::_freezecontrols(0, 1);
      var_1 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
      var_1 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
      var_1 setmoverantilagged();

      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        var_1 scripts\mp\persistence::touchedmovingplatform();
    }
  }

  scripts\mp\flags::gameflagset("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F", 0);

  if(_id_1330A() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    logstring("_encstr_8E0727936F1B98270A1FC29257E0392DA3E50E9582C79D834FF09A62790A7B606F7C9673481B400DAF");

  updatetimerpausedness();
  var_3 = scripts\mp\utility\game::gettimelimit();

  if(var_3 > 0)
    level thread waitthenshowtimer();
  else
    setomnvar("_encstr_8A601657B4F5ADB03A1B867D1D96D6599CFA4396198C95CD", 1);

  cleanpatchablecollision();
  thread timelimitclock();
  thread graceperiod();
  thread scripts\cp\vehicles\vehicle_compass_cp::roundbegin();

  if(getdvarint("_encstr_87750A3D9EA82A699EA24953", 0) > 30 && !istrue(level.multiteambased))
    setDvar("_encstr_B8F20B31E043F917232347D1D2", 1);

  thread scripts\mp\analyticslog::recordbreadcrumbdata();

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata())
    thread _id_119AE();
}

waitthenshowtimer() {
  setomnvar("_encstr_8A601657B4F5ADB03A1B867D1D96D6599CFA4396198C95CD", 1);
  wait 0.25;
  setomnvar("_encstr_8A601657B4F5ADB03A1B867D1D96D6599CFA4396198C95CD", 0);
}

cleanpatchablecollision() {
  var_0 = [];
  var_0[0] = getEnt("_encstr_BDD40C8D63A58366C8C3CC23E1C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[1] = getEnt("_encstr_AFBD0ED8B1B41C9964E166231E4C4670", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[2] = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[3] = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[4] = getEnt("_encstr_B4CD0EC6B14BE0C643F0D81AC34C4607", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[5] = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[6] = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[7] = getEnt("_encstr_AA2B10691D61889737FAD14BFABF7BC255E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[8] = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[9] = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[10] = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[11] = getEnt("_encstr_8CFE10D369F8AA7225034BF77BFC13B29A69", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[12] = getEnt("_encstr_96DF0E4EC202196F2F82B0DA8BFF4822", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[13] = getEnt("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[14] = getEnt("_encstr_A2BD0EB1D8B438668C1ECC463C23D4C6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[15] = getEnt("_encstr_A2B10E0E63C2CB954E338C0F66C81EC1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[16] = getEnt("_encstr_91B90F38D858CB599C9923E199460F3346", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[17] = getEnt("_encstr_830B10821090E1C2B6EF4A9B177EDB61D232", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[18] = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[19] = getEnt("_encstr_B61B103863B05ECA93631AC363D087919A6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[20] = getEnt("_encstr_A71B10E8AA3683D9B3B69DB3AE72A2DB4A57", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[21] = getEnt("_encstr_AA3A0F58F12070A70EFB07CB93458BFB22", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[22] = getEnt("_encstr_AFD90E076316CB59E4D843E1B1863CC1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[23] = getEnt("_encstr_8B4612CB407F378F4883DAC8098A82FA1B731737", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[24] = getEnt("_encstr_8746126AA23F6089939E27BFF36142B2032B92E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[25] = getEnt("_encstr_883C10B8FA66B3E983614E4310B63BF98827", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[26] = getEnt("_encstr_A574126088E35EC53D021515414A97CD533D26BD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[27] = getEnt("_encstr_A574126088E35EC53D021515414A97CD533B3AA1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[28] = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[29] = getEnt("_encstr_ADAC10810C0690E59B1F637BB3FE878218C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3, var_2 in var_0) {
    if(isDefined(var_2)) {
      if(isDefined(level._id_121F2) && istrue(level._id_121F2[var_3])) {
        level._id_121F2[var_3] = undefined;
        continue;
      }

      var_2 delete();
    }
  }

  level._id_121F1 = 1;

  if(isDefined(level._id_121F2)) {
    foreach(var_3, var_5 in level._id_121F2) {}
  }

  level._id_121F2 = undefined;
}

_id_12C4C(var_0) {
  if(istrue(level._id_121F1)) {
    return;
  }
  if(!isDefined(level._id_121F2))
    level._id_121F2 = [];

  level._id_121F2[var_0] = 1;
}

wavespawntimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_AD250FCBFAF4BF2A619753E0ADF793C2C3");
  level endon("_encstr_AD250FCBFAF4BF2A619753E0ADF793C2C3");

  if(isDefined(level.tacopssublevel))
    thread wavetimerwatcher();

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    var_0 = gettime();

    foreach(var_2 in level.teamnamelist) {
      if(var_0 - level.lastwave[var_2] > level.wavedelay[var_2] * 1000) {
        level notify("_encstr_8FD30EABE0BBBD11C31FC3630BA33E68" + var_2);
        level.lastwave[var_2] = var_0;
        level.waveplayerspawnindex[var_2] = 0;
      }
    }

    waitframe();
  }
}

wavetimerwatcher() {
  level endon("_encstr_AD250FCBFAF4BF2A619753E0ADF793C2C3");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_8EE61403FA33551942BD3729A16BD8301742F848028F", "_encstr_84D912030F1B5AF96E20E371A710C86E21E0DB3F");
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + 1000 * level.wavedelay["_encstr_9A8507BA4040188D08"]);
  }
}

getbetterteam() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.teamnamelist) {
    var_0[var_3] = 0;
    var_1[var_3] = 0;
  }

  foreach(var_6 in level.players) {
    var_7 = var_6.pers["_encstr_8AEF05472BC2D6"];

    if(isDefined(var_7) && scripts\mp\utility\teams::isgameplayteam(var_7)) {
      var_0[var_7] = var_0[var_7] + var_6.kills;
      var_1[var_7] = var_1[var_7] + var_6.deaths;
    }
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 0;

  foreach(var_3 in level.teamnamelist) {
    var_16 = var_0[var_3];

    if(!isDefined(var_9) || var_16 > var_9) {
      var_9 = var_16;
      var_10 = var_3;
      var_11 = 0;
    } else if(var_9 == var_16)
      var_11 = 1;

    var_17 = var_1[var_3];

    if(!isDefined(var_12) || var_17 < var_12) {
      var_12 = var_17;
      var_13 = var_3;
      var_14 = 0;
      continue;
    }

    if(var_12 == var_17)
      var_14 = 1;
  }

  if(!var_11)
    return var_10;

  if(!var_14)
    return var_13;

  var_19 = randomint(level.teamnamelist.size);
  return level.teamnamelist[var_19];
}

rankedmatchupdates(var_0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    setxenonranks();

    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("_encstr_A6340FA81A3219F15F6431BD7CA2C0D35B");
      endlobby();
    }

    updatematchbonusscores(var_0);
  }

  updatewinlossstats(var_0);
}

displayroundend(var_0, var_1, var_2) {
  thread scripts\mp\music_and_dialog::round_end_music(var_0, var_1, var_2);

  if(!level.doeomcombat && scripts\mp\utility\game::ismoddedroundgame() && game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 0)
    var_0 = "_encstr_955109F3386D63C7C83594";

  level.roundendextramessage = 0;

  if(!scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && !istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    if(checkroundswitch(level.playovertime))
      level.roundendextramessage = game["_encstr_BDCE1039BDEADC8CD7567332D72B3C6B9BB3"]["_encstr_A3AB101B947003FFB2DB8B80D186FAA138EF"];
  }

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::_id_1332B()) {
    var_0 = "_encstr_8D19048EA595";
    var_1 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4EA0F7F73A869FA58669BA3989114C2F5"];
    var_2 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4EA0F7F73A869FA58669BA3989114C2F5"];
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 1, var_1, var_2, level.roundendextramessage);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

displaygameend(var_0, var_1, var_2) {
  setomnvar("_encstr_91340E5D2DFAB65847D8D0BEBDEC2B4E", 1);

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::_id_1332B()) {
    var_0 = "_encstr_8D19048EA595";
    var_1 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4EA0F7F73A869FA58669BA3989114C2F5"];
    var_2 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4EA0F7F73A869FA58669BA3989114C2F5"];
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

displayroundswitch() {
  level notify("_encstr_AC1F16ABDAA970F842632F57571A3D38527510238219F8A0");

  if(isDefined(level._id_11C68))
    [[level._id_11C68]]();

  var_0 = remove_player_from_focus_fire_attacker_list();

  foreach(var_2 in level.players)
  var_2 thread scripts\mp\playerlogic::spawnintermission(var_0);

  var_4 = level.halftimetype;

  if(var_4 == "_encstr_AADE09481E247875C2EFAB") {
    if(level.roundlimit) {
      if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] * 2 == level.roundlimit)
        var_4 = "_encstr_AADE09481E247875C2EFAB";
      else
        var_4 = "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258";
    } else
      var_4 = "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258";
  }

  level notify("_encstr_8CBD0DDE3DB33D51871F70886BD3A8", var_4);
  var_5 = 0;

  if(game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 1)
    var_4 = "_encstr_8FB90C16DBA0EF7DDFC8A21B30F1";
  else if(game["_encstr_8A800BA8806B8FB3601890C541"] == 1) {
    var_4 = "_encstr_85AF0C6D199053AA88C1A7B7D5C5";

    if(scripts\mp\utility\game::iswinbytworulegametype() && game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_9A8507BA4040188D08"] == game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_8E8405EA382B2A"])
      var_4 = "_encstr_BD920B17B310B1E3D39E3BF360";
  }

  if(isDefined(level.switchedsides)) {
    var_5 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A3AB101B947003FFB2DB8B80D186FAA138EF"];
    level.roundendextramessage = 0;

    if(var_4 != "_encstr_8FB90C16DBA0EF7DDFC8A21B30F1" && var_4 != "_encstr_85AF0C6D199053AA88C1A7B7D5C5")
      var_4 = "_encstr_A3AB101B947003FFB2DB8B80D186FAA138EF";
  }

  foreach(var_2 in level.players)
  var_2 thread scripts\mp\hud_message::teamoutcomenotify(var_4, 1, var_5, var_5, level.roundendextramessage);

  roundendwait(level.halftimeroundenddelay, 0);
}

freezeallplayers(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_0 > 0 && var_3)
    thread slowmotionendofgame(var_0);

  thread sendgameendedfrozennotify(var_0);
  var_4 = scripts\mp\utility\game::updatetextongamepadchange();

  foreach(var_6 in level.players) {
    var_6 enableplayerbreathsystem(0);
    var_6 thread freezeplayerforroundend(var_0);
    var_6 thread roundenddof(4.0);
    var_6 freegameplayhudelems();
    var_6 setclientdvars("_encstr_A3D20B62A25A2854A94194A839", var_4, "_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      if(var_1 == "_encstr_A11E0A5D8FF1E1519E04D72C" && var_6 issplitscreenplayer())
        var_6 setclientdvars(var_1, 0.75);

      var_6 setclientdvars(var_1, var_2);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(var_9 in level.agentarray)
    var_9 scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_868511999359B2D3AC058D63281BB0972B9CDC");
  }
}

endofroundvisionset(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  visionsetfadetoblack("_encstr_BA07031663", 0.75);
}

slowmotionendofgame(var_0) {
  setslowmotion(1.0, 0.4, var_0);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  setslowmotion(1.0, 1, 0);
  resetsoundtimescalefactor();
}

setendofroundsoundtimescalefactor() {
  if(!isDefined(level.never_kill_off_after_stealth)) {
    createheadiconatorigin("_encstr_88450D5BFE9771301B893B8033E37D");
    level.never_kill_off_after_stealth = 1;
    level._id_12C62 = undefined;
  }
}

resetsoundtimescalefactor() {
  if(!isDefined(level._id_12C62)) {
    createheadiconatorigin("_encstr_88F20627959BCAE8");
    level.never_kill_off_after_stealth = undefined;
    level._id_11EF8 = undefined;
    level._id_12C62 = 1;
  }
}

sendgameendedfrozennotify(var_0) {
  wait(var_0);
  level notify("_encstr_832F12198722C8E1F79A6D033D760C95D58B452D");
}

restart() {
  if(isDefined(level._id_12059))
    [[level._id_12059]]();

  level notify("_encstr_92DF0B127AF74B41D63488E317");
  game["_encstr_A1AD062E09D98338"] = "_encstr_877508C1D8C22F2DDC3B";
  map_restart(1);
}

endgame(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1))
    logstring("_encstr_839416438F31485F81C4E0688C652F6E595DF4E773A88F6A" + var_1);
  else
    logstring("_encstr_8F0115B6D251CAF5A67A53547245AE08A2CD231D85B6CA");

  if(isDefined(level._id_11C81))
    var_0 = level._id_11C81;

  if(isDefined(level.endgame))
    [[level.endgame]](var_0, var_1, undefined, var_5);
  else
    endgame_regularmp(var_0, var_1, var_2, var_3, var_4);
}

endgame_regularmp(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && level.gameended) {
    return;
  }
  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] < 24)
    setmatchdata("_encstr_81551713E417A30793DAEFE583F41D58E8E7E7C9CEB0EEFF02", game["_encstr_8DC30DAA0285FD69FAE113371B1934"], getsystemtime());

  scripts\common\utility::_id_13E0A(level._id_11B34);
  var_5 = 0;

  if(level.hostforcedend || level.forcedend)
    var_5 = 1;

  if(scripts\mp\utility\game::inovertime()) {
    if(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0)
      setmatchdata("_encstr_AD8A18AE1AC06AC43893BAA8915385851D2858CB2A9BF6DD878B", game["_encstr_8DC30DAA0285FD69FAE113371B1934"]);

    if(!var_5)
      game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"]++;
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
      if(!var_5) {
        if(isDefined(var_4))
          game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0] = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0] + var_4;
        else
          game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0]++;
      }

      if(!isDefined(level.finalkillcam_winner))
        level.finalkillcam_winner = var_0;
    } else {
      if(isDefined(var_0) && var_0 == "_encstr_8D19048EA595" && shouldmodescoreonties()) {
        foreach(var_7 in level.teamnamelist)
        game["_encstr_B81B0A39EDABE69137D5BDCD"][var_7]++;
      }

      if(!isDefined(level.finalkillcam_winner))
        level.finalkillcam_winner = "_encstr_8BBA05185F8B99";
    }

    if(!istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
      foreach(var_7 in level.teamnamelist)
      scripts\mp\gamescore::updateteamscore(var_7);

      if(scripts\mp\utility\game::isroundbased() && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] < 24 && scripts\mp\utility\game::getgametype() != "_encstr_BDD705AD7BD143") {
        setmatchdata("_encstr_BE7D1176A0484172A6BDAFDFDDC5D983A88BEF", game["_encstr_8DC30DAA0285FD69FAE113371B1934"], getteamscore("_encstr_9A8507BA4040188D08"));
        setmatchdata("_encstr_A56F0FEBCBBA96A1576388C18203104ED2", game["_encstr_8DC30DAA0285FD69FAE113371B1934"], getteamscore("_encstr_8E8405EA382B2A"));
      }
    }
  } else {
    if(isDefined(var_0) && isPlayer(var_0) && !var_5)
      game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0.guid]++;

    if(!isDefined(level.finalkillcam_winner)) {
      if(!isDefined(var_0) || isstring(var_0) && var_0 == "_encstr_8D19048EA595")
        level.finalkillcam_winner = "_encstr_8BBA05185F8B99";
      else
        level.finalkillcam_winner = var_0.guid;
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!var_5)
    game["_encstr_8DC30DAA0285FD69FAE113371B1934"]++;

  level.playovertime = scripts\mp\utility\game::shouldplayovertime();

  if(scripts\mp\utility\game::nextroundisfinalround())
    game["_encstr_96DF0BCC92723B8A59E7F338A1"] = 1;
  else if(scripts\mp\utility\game::nextroundismatchpoint())
    game["_encstr_8A800BA8806B8FB3601890C541"] = 1;

  if(isDefined(var_0) && scripts\mp\utility\game::waslastround())
    var_0 = checkmodeoverridetie(var_0);

  level.initcircuitbreakers = istrue(var_3) && scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501";

  if(isDefined(var_0) && level.initcircuitbreakers) {
    var_11 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
    game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0] = 1;
    game["_encstr_B81B0A39EDABE69137D5BDCD"][var_11] = 0;
    game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] = 1;
    game["_encstr_96040B1D59B0AD35B1F64E599B"][var_11] = 0;
    setteamscore(var_0, 1);
    setteamscore(var_11, 0);
  }

  var_12 = endgame_endround(var_0, var_1, var_2, var_3);

  foreach(var_14 in level.players) {
    if(!isbot(var_14) && isDefined(var_14.team) && var_14.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_14.team != "_encstr_933E090A10B17DDFB3E522")
      _id_119AF(var_14);
  }

  if(var_12 && scripts\mp\utility\game::waslastround())
    endgame_endgame(var_0, var_1, var_2, var_3);
}

shouldmodescoreonties() {
  return istrue(game["_encstr_AD3F0EB158739AC6EDE456F43751B495"]);
}

checkmodeoverridetie(var_0) {
  var_1 = shouldmodescoreonties() && var_0 == "_encstr_8D19048EA595";
  var_2 = scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501" && var_0 == "_encstr_8D19048EA595" && !level.winrule;

  if(var_1 || var_2) {
    scripts\mp\gamescore::updatetotalteamscore("_encstr_8E8405EA382B2A");
    scripts\mp\gamescore::updatetotalteamscore("_encstr_9A8507BA4040188D08");
    var_3 = getteamscore("_encstr_9A8507BA4040188D08");
    var_4 = getteamscore("_encstr_8E8405EA382B2A");

    if(var_3 != var_4)
      var_0 = scripts\engine\utility::ter_op(var_3 > var_4, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
  }

  return var_0;
}

endgame_showkillcam() {
  if(istrue(level.nukedetonated)) {
    return;
  }
  if(istrue(level.disable_back_light)) {
    return;
  }
  if(getdvarint("_encstr_8E7E1CD7BF13983B211DE1BE8203384779037B654F1A40587135C8312EFD", 0) == 1) {
    return;
  }
  if(istrue(level.skipfinalkillcam)) {
    return;
  }
  scripts\mp\flags::levelflagwait("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");

  if(level.finalkillcamenabled) {
    var_0 = 0;

    if(isDefined(level.finalkillcam_winner))
      var_0 = 1;

    if(var_0)
      var_0 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(var_0) && !var_0) {
      postroundfadenokillcam();
      return;
    }
  } else if(level.potgenabled) {
    var_1 = scripts\mp\potg::getcurpotgscene();

    if(isDefined(var_1.primaryentity)) {
      level scripts\mp\final_killcam::dopotgkillcam();
      return;
    }

    level.finalkillcamenabled = 1;
    var_0 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(var_0) && !var_0) {
      postroundfadenokillcam();
      return;
    }

    return;
  } else {}
}

postroundfadenokillcam() {
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }
    var_1 thread scripts\mp\utility\game::setuipostgamefade(1.0, 0.1);

    if(level.gametype == "_encstr_A9B606B0C956B916")
      var_1 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
    else
      var_1 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);

    var_1 thread _id_1284E();
  }

  wait 0.5;
}

_id_1284E() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = scripts\mp\playerlogic::getspectatepoint();
  self predictstreampos(var_0.origin, 1);

  while(self.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
    waitframe();

  waitframe();
  self clearpredictedstreampos();
}

_id_13153(var_0) {
  game["_encstr_A1AD062E09D98338"] = "_encstr_ACE709DA22939BA8075060";
  level notify("_encstr_9B1D0BC7932875276230426AA1", var_0);
  scripts\mp\flags::levelflagset("_encstr_ACCF0A3B0BD6B2EBDB3BAC27");
  scripts\mp\flags::levelflagset("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
}

mp_vacant_patch_thread(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == 1 || var_0 == 2) {
      level.apc_rus_monitordriverturretreload = 0;
      level.allow_momentum = var_0;
      level notify("_encstr_820910E043F73DD4D5D389D30757DF3340E6");
    }
  }
}

endgame_endround(var_0, var_1, var_2, var_3) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::isroundbased()) {
      logstring("_encstr_9A917754EF412DCF6F9B2206BFD2C6F0A114DCEEC7F97236A4DB4B630B9E8E0520B94F6FF8C0F52A5161334771CF134DD8C983B5391194A6F455E202F94F8FC018687F7A096257CA2EC98F0F910612ED3871A41409BB074389A19203BF3DAE32D891EA8FFB12D9AAF765A76795ED766A9043E757D96B97C2BD");
      level.forcedend = 1;
    }

    return 1;
  }

  if(getdvarint("_encstr_A27A0F1A762D39B538B09F6788506A02C9")) {
    if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916" && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      level.doeomcombat = 1;
  }

  updateleaderboardstats();
  waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  thread scripts\mp\potg::onroundended(var_0);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("_encstr_88B018F8678EB113121977882D5A4B58EBEFF8A1DB5109C90A3F");

  if(scripts\mp\utility\game::isteamreviveenabled())
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();

  if(scripts\mp\utility\game::waslastround()) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
      if(scripts\mp\utility\teams::isgameplayteam(var_0))
        var_4 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
      else
        var_4 = level.placement["_encstr_AF1904A7F929"];

      var_5 = int(min(3, var_4.size));

      foreach(var_7 in level.players) {
        var_8 = 0;

        for(var_9 = 0; var_9 < var_5; var_9++) {
          if(var_7 == var_4[var_9])
            var_8 = 1;
        }

        if(var_8) {
          if(var_7 == var_4[0])
            var_7 scripts\cp_mp\pet_watch::bhasthermitestucktoshield();
        }
      }
    }

    level notify("_encstr_8F79154EEBE21563B77FD0B85F9F5B7B7A59CFD547DAE7", var_0);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(var_0 != "_encstr_8D19048EA595")
        level waittill("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");
    }
  } else
    level notify("_encstr_8A4B109C7B579B8C7D56DC23AFB6EA374BB1", var_0);

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      _id_13153(var_0);
      level waittill("_encstr_AA9716B1D619FA1B7BB94796DCAE2BBE3B58D656F5B27346");
      setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);

      foreach(var_7 in level.players) {
        if(level.teambased) {
          var_7 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1, var_2);
          continue;
        }

        var_7 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
      }

      freezeallplayers(3, "_encstr_A11E0A5D8FF1E1519E04D72C", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    } else if(level.gametype == "_encstr_B607038AAB") {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var_0, var_1, var_2);
      game["_encstr_A1AD062E09D98338"] = "_encstr_ACE709DA22939BA8075060";
      level notify("_encstr_9B1D0BC7932875276230426AA1", var_0);
      scripts\mp\flags::levelflagset("_encstr_ACCF0A3B0BD6B2EBDB3BAC27");
      scripts\mp\flags::levelflagset("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
      waitframe();
    } else if(!(level.gametype == "_encstr_A53E0883E976B715503F" && isDefined(level.tacopssublevel))) {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var_0, var_1, var_2);
      freezeallplayers(2.5, "_encstr_A11E0A5D8FF1E1519E04D72C", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      _id_13153(var_0);
      waitframe();
    }

    foreach(var_7 in level.players) {
      var_7 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        var_7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var_7 scripts\mp\bounty::playerresetbountystreak();
      }

      var_7 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
    }
  } else {
    if(!(level.gametype == "_encstr_A53E0883E976B715503F" && isDefined(level.tacopssublevel)) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
      thread waitforhitmarkerspostgame();
      _id_13153(var_0);
    }

    waitframe();

    foreach(var_7 in level.players) {
      var_7 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 1);

      if((scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) && !istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
        var_7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var_7 scripts\mp\bounty::playerresetbountystreak();
      }

      var_7 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
    }

    freezeallplayers(1.0, "_encstr_A11E0A5D8FF1E1519E04D72C", 1, 0);
  }

  setgameendtime(0);
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled())
    scripts\mp\analyticslog::analyticsstorespawndata();

  clearmatchhasmorethan1playervariablesonroundend();

  if(isDefined(level.matchrecording_dump))
    [[level.matchrecording_dump]]();

  rankedmatchupdates(var_0);
  setDvar("_encstr_8C3C0A99C0159584534AB827", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("_encstr_A744140DDAF1C720F1D777172C20C0A5FFC0163BF76B", 0);
  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", 0);

  foreach(var_7 in level.players)
  var_7 scripts\mp\class::loadout_clearperks();

  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) && !istrue(level.forcedend)) {
    game["_encstr_8DC30DAA0285FD69FAE113371B1934"] = 0;

    foreach(var_20 in level.teamnamelist) {
      game["_encstr_B81B0A39EDABE69137D5BDCD"][var_20] = 0;
      game["_encstr_96040B1D59B0AD35B1F64E599B"][var_20] = 0;
    }

    var_0 = "_encstr_8D19048EA595";
    var_1 = game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A36614A8EEF95FD31BD8EA41387FCB33F1C00F268D63"];
  }

  displayroundend(var_0, var_1, var_2);
  level thread endofroundvisionset(level.roundenddelay - 1.0);

  if(!scripts\mp\utility\game::waslastround()) {
    level notify("_encstr_83F10A82A8CBC24CC6889FFB", var_0);
    roundendwait(level.roundenddelay, 1);
  } else
    roundendwait(level.roundenddelay, 1);

  level notify("_encstr_8F3F0DCF1F807A39380175B16B930B");
  endgame_showkillcam();
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();

  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) && !istrue(level.forcedend)) {
    game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"] = 0;

    if(level.allowsupers && !scripts\mp\utility\game::runleanthreadmode()) {
      foreach(var_7 in level.players) {
        var_7 scripts\mp\supers::clearsuper();
        var_7 scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
    restart();
    return 0;
  } else {
    if(level.teambased) {
      foreach(var_25 in level.teamnamelist) {
        if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_25)) {
          continue;
        }
        scripts\mp\gamescore::updatetotalteamscore(var_25);
      }
    }

    if(!scripts\mp\utility\game::wasonlyround()) {
      if(!scripts\mp\utility\game::waslastround()) {
        if(level.playovertime) {
          var_0 = "_encstr_8B6D0940CC35339149DA08";
          game["_encstr_A16D07532531CB4BF7"] = "_encstr_8B6D0940CC35339149DA08";
        }

        scripts\mp\flags::levelflagclear("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
        var_27 = checkroundswitch(level.playovertime);

        if(var_27)
          onroundswitch(level.playovertime);

        if(var_27 || game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 1 || game["_encstr_8A800BA8806B8FB3601890C541"] == 1) {
          var_28 = 1;

          if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
            if(scripts\mp\utility\game::shouldplaywinbytwo()) {} else if(game["_encstr_8A800BA8806B8FB3601890C541"] == 1 && !istrue(game["_encstr_81B214E944CF327529C890144977980FD94F2F69D5B8"]))
              game["_encstr_81B214E944CF327529C890144977980FD94F2F69D5B8"] = 1;
            else if(game["_encstr_96DF0BCC92723B8A59E7F338A1"] != 1)
              var_28 = 0;
          }

          if(var_28)
            displayroundswitch();
        }

        foreach(var_7 in level.players) {
          var_7.pers["_encstr_88AD06120BDE0B17"] = var_7.stats;

          if(isalive(var_7) && isDefined(var_7.matchdatalifeindex))
            var_7 scripts\common\utility::_id_13E0A(level._id_11B2D, var_7.matchdatalifeindex, undefined, undefined, "_encstr_8D5110501FCB890155CB9CA54F05E6915048", "_encstr_8BBA05185F8B99", undefined, undefined, undefined);
        }

        restart();
        return 0;
      }

      if(!level.forcedend)
        var_1 = updateroundendreasontext(var_0);
    }
  }

  return 1;
}

tacopsroundendwait(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!var_5 scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  foreach(var_5 in level.players)
  var_5 thread scripts\mp\utility\game::setuipostgamefade(0.0);

  wait(var_0);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
  level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
}

compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

endgame_endgame(var_0, var_1, var_2, var_3) {
  spawnscriptable();
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.music_timer_10seconds = var_0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !level.forcedend) {
    level.apc_rus_monitordriverturretreload = 1;
    level scripts\common\ui::lui_registercallback("_encstr_B49E167DD05A212EB37F18A033C72159E23DE3706E63DB71", ::mp_vacant_patch_thread);
  }

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level._id_132FE) && [[level._id_132FE]]())
    createnavobstaclebyshape();

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend))
    updatewinlossstats(var_0);

  scripts\cp\vehicles\vehicle_compass_cp::roundend(var_0);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("_encstr_8203171FF34881076042AFC5B1E20E5F79D57B87971B398347");
  updateleaderboardstats();
  level scripts\mp\accolades::obj_riverbed();
  level.doingbroshot = scripts\mp\broshot::initbroshot(var_0);
  var_4 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_9194142AB04D9FDEE05BD1CE4198227F638BC392F810");

  if(!level.doingbroshot && istrue(var_4)) {
    level notify("_encstr_AC1F16ABDAA970F842632F57571A3D38527510238219F8A0");
    var_5 = remove_player_from_focus_fire_attacker_list();

    foreach(var_7 in level.players) {
      var_7 thread scripts\mp\utility\game::setuipostgamefade(0.0);

      if(!isDefined(level._id_11C85) || !var_7[[level._id_11C85]]())
        var_7 thread scripts\mp\playerlogic::spawnintermission(var_5);
    }
  }

  if(istrue(var_3) && !istrue(level.nukecancel)) {
    scripts\mp\utility\player::_visionsetnaked(level.nukevisionset, 0);
    visionsetfadetoblack("_encstr_B40101", 0.75);
  } else {
    scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);
    visionsetfadetoblack("_encstr_B40101", 0.75);
  }

  displaygameend(var_0, var_1, var_2);
  scripts\mp\flags::levelflagclear("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
  level.intermission = 1;

  if(!level.doingbroshot) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::spawn_carriable_at_struct();

      if(isDefined(level.multieventdebug)) {
        foreach(var_7 in level.players) {
          if(!isDefined(var_7)) {
            continue;
          }
          var_7 thread _id_12465();
        }
      } else {
        setomnvarforallclients("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
        setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 14);
      }

      if(getdvarint("_encstr_B2DF1D83F69BE8EBECC2B5CA7D383616CBF5859D2CA59BEBAC9B854C365646", 1) == 1) {
        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
          if(isDefined(level.multieventdebug))
            wait(level.multieventdebug._id_142AE);
          else if(getdvarint("_encstr_82BD0B6CF2BAB1C6B1B7A1AB43") == 1)
            wait 20;
          else if(scripts\mp\utility\game::privatematch())
            wait 6;
          else
            wait 20;
        } else {
          if(istrue(level.apc_rus_monitordriverturretreload))
            level waittill("_encstr_820910E043F73DD4D5D389D30757DF3340E6");

          level.postroundtime = 0;
        }

        setupelevatordoor();
        wait 10;
      }
    }

    setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 5);

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      roundendwait(level.postroundtime, 1);
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_816E079685517D0975" || scripts\mp\utility\game::updatex1stashhud() || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E")
    processlobbydata();

  if(level.doingbroshot) {
    setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 7);
    wait 0.1;
    scripts\mp\broshot::startbroshot(var_0);
    level waittill("_encstr_865A114B0BE39DD39358848169795B696F08D3");
    scripts\mp\broshot::endbroshot();
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
      setmatchdata("_encstr_BEB407D8FAB69998B3", var_0);
      var_11 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
    } else {
      setmatchdata("_encstr_BEB407D8FAB69998B3", "_encstr_8BBA05185F8B99");
      var_11 = level.placement["_encstr_AF1904A7F929"];
    }

    setmatchdata("_encstr_BEFF0C0BA4DD880D7781C148BB07", getteamscore("_encstr_9A8507BA4040188D08"));
    setmatchdata("_encstr_B15B0AC151E87AE71E589B92", getteamscore("_encstr_8E8405EA382B2A"));
  } else {
    setmatchdata("_encstr_BEB407D8FAB69998B3", "_encstr_8BBA05185F8B99");
    var_11 = level.placement["_encstr_AF1904A7F929"];
  }

  foreach(var_7 in level.players) {
    var_7 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8F50132BE6C8A4CA16DCEDB9A2590F1D929B8CAC3C", var_1);
    var_7 scripts\cp_mp\utility\game_utility::stopkeyearning(var_0);

    if(isalive(var_7) && isDefined(var_7.matchdatalifeindex))
      var_7 scripts\common\utility::_id_13E0A(level._id_11B2D, var_7.matchdatalifeindex, undefined, undefined, "_encstr_8A2B0FCB4F87678FC5CF57194FD0E7AD79", "_encstr_8BBA05185F8B99", undefined, undefined, undefined);

    var_13 = int(min(3, var_11.size));
    var_14 = 0;

    for(var_15 = 0; var_15 < var_13; var_15++) {
      if(var_7 == var_11[var_15])
        var_14 = 1;
    }

    if(var_14)
      var_7 scripts\cp_mp\pet_watch::addwatchchargewintop3();

    if(level.teambased) {
      if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
        if(isDefined(var_7.team)) {
          if(var_7.team == var_0) {
            var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_91190447C232");
            var_7 scripts\cp_mp\pet_watch::addwatchchargewin();
          } else
            var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_8CAD05DB100303");
        } else
          var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_8BBA05185F8B99");
      } else if(scripts\mp\utility\game::allteamstied())
        var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_AF660584E6F107");
      else
        var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_8BBA05185F8B99");
    } else if(isPlayer(var_0) && var_0.clientid == var_7.clientid) {
      var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_91190447C232");
      var_7 scripts\cp_mp\pet_watch::addwatchchargewin();
    } else
      var_7 logplayerendmatchdatamatchresult(var_7.clientid, "_encstr_8CAD05DB100303");

    var_7 scripts\common\utility::_id_13E0A(level._id_11B2C);
  }

  scripts\common\utility::_id_13E0A(level._id_11B35);

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
    if(isgamebattlematch()) {
      foreach(var_7 in level.players) {
        var_18 = var_7 getxuid();
        var_19 = var_7.team;
        var_20 = var_7 scripts\mp\utility\stats::getpersstat("_encstr_82FB06EB26785BD7");
        setgamebattlematchstats(var_18, var_19, var_20);
      }

      var_22 = level.mapname;
      var_23 = scripts\mp\utility\game::getgametype();
      var_24 = getmatchdata("_encstr_BEB407D8FAB69998B3");
      var_25 = getteamscore("_encstr_9A8507BA4040188D08");
      var_26 = getteamscore("_encstr_8E8405EA382B2A");
      var_27 = scripts\mp\matchdata::getmatchstarttimeutc();
      var_28 = scripts\mp\matchdata::getmatchendtimeutc();
      requestgamelobbyremainintact(var_22, var_23, var_24, var_25, var_26, var_27, var_28);
    }
  }

  _id_1301F();
  _func_042A();

  foreach(var_7 in level.players)
  var_7.pers["_encstr_88AD06120BDE0B17"] = var_7.stats;

  if(getdvarint("_encstr_B2DF1D83F69BE8EBECC2B5CA7D383616CBF5859D2CA59BEBAC9B854C365646", 1) == 0)
    wait 1;
  else if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    wait 1;
  else if(!var_3 && !level.postgamenotifies) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility\game::wasonlyround())
        wait 6.0;
      else
        wait(min(5.0, 4.0 + level.postgamenotifies));
    }
  } else
    wait(min(10.0, 4.0 + level.postgamenotifies));

  settournamentwinner(var_0);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
  scripts\mp\flags::levelflagwaitopen("_encstr_A9181D21AF6218182FBA0831613BCDC03F34F7F35E4F70D5A7D2C11BEABBF5");

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    scripts\mp\flags::levelflagclear("_encstr_A3980FDDEB85B6C0395D388BB85A53B517");
    game["_encstr_AC581242886BE5F778CE681560201F6CF5685ADB"] = 1;
    game["_encstr_B18F0BDD815F4151AECB982052"] = 0;
    game["_encstr_8DC30DAA0285FD69FAE113371B1934"] = 0;
    game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] = 0;
    game["_encstr_8A800BA8806B8FB3601890C541"] = 0;
    game["_encstr_96DF0BCC92723B8A59E7F338A1"] = 0;
    game["_encstr_A9310C0449DDA97F583FADB0FD01"] = undefined;
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = "_encstr_B40101";

    foreach(var_19 in level.teamnamelist) {
      game["_encstr_B81B0A39EDABE69137D5BDCD"][var_19] = 0;
      game["_encstr_96040B1D59B0AD35B1F64E599B"][var_19] = 0;
      setteamscore(var_19, int(0));
    }

    if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3) {
      if(isDefined(level.droplaunchchunkbots))
        level[[level.droplaunchchunkbots]]();

      wait 1;
    }

    if(!level.hostforcedend && !level.forcedend) {
      restart();
      return 0;
    }
  }

  level notify("_encstr_88BC11FDBA8A5109E0A34075FFF167A4699A0D");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && isDefined(level.allow_momentum) && level.allow_momentum == 2) {
    scripts\mp\bots\bots::drop_bots(1, level.player.team);
    restart();
  } else
    exitlevel(0);
}

_id_1301F() {
  if(!isDefined(level.needs_power)) {
    getentitylessscriptablearray("_encstr_85E91CE1AAD7D499072E9B9534E1B0ADDB6359AB21771F385E18E78B4617", ["_encstr_8B18119FE8210F63B1EFFA73D8691AF509490F", scripts\mp\matchdata::getmatchstarttimeutc(), "_encstr_B44D0F2DB14089F750E1813BA8390F7128", scripts\mp\matchdata::getmatchendtimeutc()]);

    if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
      setmatchdata("_encstr_A5CC05588D2BF8", level.hostname);

      if(scripts\mp\utility\game::matchmakinggame()) {
        setmatchdata("_encstr_9AD410E8A1B977955B183B1140858AEFD018", getplaylistversion());
        setmatchdata("_encstr_A2A00B0763165E1B96373A9411", getplaylistid());
        setmatchdata("_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", _func_41F());
        setmatchdata("_encstr_ACDC0C96CD11AC464B1B58475646", isdedicatedserver());
        setmatchdata("_encstr_9AC711892126EC4F26B8294A486591530D234E", getdvarint("_encstr_87750A3D9EA82A699EA24953", 0));
      }

      isalliedsentient();
      sendmatchdata();
    }
  }

  level.needs_power = 1;
}

settournamentwinner(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!level.teambased) {
    logtournamentdeath(var_0);
    return;
  } else if(var_0 != "_encstr_9A8507BA4040188D08" && var_0 != "_encstr_8E8405EA382B2A") {
    var_1 = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B");
    var_2 = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B");

    if(var_1.size == 0)
      var_0 = "_encstr_8E8405EA382B2A";
    else if(var_2.size == 0)
      var_0 = "_encstr_9A8507BA4040188D08";
    else
      var_0 = getbetterteam();
  }

  logtournamentdeath(var_0);
}

waitforhitmarkerspostgame() {
  wait(level._id_127FE);
  level notify("_encstr_A28713C1DE37A3D7B3C2AD59BE5D5AAFE68EB0938E");
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
}

eomcombatwaitforhitmarkersanddelaystartpostgameui(var_0, var_1, var_2) {
  wait(level._id_127FE);
  level notify("_encstr_A28713C1DE37A3D7B3C2AD59BE5D5AAFE68EB0938E");

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

remove_player_from_focus_fire_attacker_list() {
  var_0 = undefined;

  switch (level.mapname) {
    case "_encstr_A9940CCB60D9B8B3B33AD901B212":
      var_0 = spawnStruct();
      var_0.origin = (1478, -3039, 981);
      var_0.angles = (388.74, 144.97, 0);
      break;
    case "_encstr_8E2D0CDA88B79E8791429C87E593":
      var_0 = spawnStruct();
      var_0.origin = (1835, 1347, 749);
      var_0.angles = (361, 224, 0);
      break;
    case "_encstr_ACF70BABB3814330E4DF603B83":
      var_0 = spawnStruct();
      var_0.origin = (-871, -1578, 458);
      var_0.angles = (6, 65, 0);
      break;
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370") {
    var_0 = spawnStruct();
    var_0.origin = level.endsuperdisableweaponbr._id_136DC.origin;
    var_0.angles = level.endsuperdisableweaponbr._id_136DC.angles;
  }

  return var_0;
}

eomcamerapullout(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_2 scripts\common\utility::allow_ads(0);
    var_3 = var_2 getEye() + (0, 0, 100) + anglesToForward(var_2.angles) * -100;
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_4.angles = var_2.angles;
    var_2.spawncameraent = var_4;
    var_5 = var_2 getEye();
    var_6 = var_2.angles;
    var_7 = var_3 + (0, 0, 5000);
    var_7 = var_7 + anglesToForward(var_6) * -100;
    var_2 cameralinkTo(var_2.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 1);
    var_2.spawncameraent moveTo(var_7, 5.0, 4.0, 0.1);
    var_8 = vectorNormalize(var_5 - var_4.origin);
    var_9 = scripts\mp\utility\script::vectortoanglessafe(var_8, (0, 0, 1));
    var_2.spawncameraent.angles = var_9;
    var_2 thread lookatplayerupdate(var_6);
    wait 2.0;
    var_2 visionsetnakedforplayer("_encstr_99120F5E030B4F21971861D8B997FDFB72", 2.0);
  }
}

lookatplayerupdate(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BA6618F248EFF42FAB377471BB513BB339E8AAEBB037AAB3A00F");

  for(;;) {
    var_1 = self getEye();
    var_2 = vectorNormalize(var_1 - self.spawncameraent.origin);
    var_3 = scripts\mp\utility\script::vectortoanglessafe(var_2, (0, 0, 1));
    self.spawncameraent rotateTo(var_3, 0.75);
    waitframe();
  }
}

updateroundendreasontext(var_0) {
  if(!level.teambased)
    return 1;

  if(scripts\mp\utility\game::ismoddedroundgame()) {
    if(scripts\mp\utility\game::hitscorelimit())
      return game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"];

    if(scripts\mp\utility\game::hittimelimit())
      return game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"];
  } else if(scripts\mp\utility\game::hitroundlimit())
    return game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8BA11473C013AE8277F98C855319097AB928BFE378E9"];

  if(scripts\mp\utility\game::hitwinlimit())
    return game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CBA145E3E120571876380A81FC44E7DDA26DE6B177A"];

  return game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"];
}

estimatedtimetillscorelimit(var_0) {
  if(!scripts\mp\utility\game::ismoddedroundgame()) {
    var_1 = getscoreperminute(var_0);
    var_2 = getscoreremaining(var_0);
    var_3 = 999999;

    if(var_1)
      var_3 = var_2 / var_1;

    return var_3;
  } else {
    var_1 = getscoreperminute(var_0);
    var_2 = getscoreperminute(var_0);
    var_3 = 999999;

    if(var_1)
      var_3 = var_2 / var_1;

    return var_3;
  }
}

closetoscorelimit(var_0) {
  var_1 = 10;
  var_2 = 20;
  var_3 = level.roundscorelimit;

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_85EF050CB150E7":
    case "_encstr_8218041DF5FA":
      var_2 = 20;
      break;
    case "_encstr_959105B99040BD":
      var_2 = 10;
    case "_encstr_B81904B04E6B":
      var_2 = var_3 * 0.1;
      break;
    default:
      break;
  }

  var_4 = getteamscore(var_0);
  var_5 = var_3 - var_4;

  if(var_5 <= scripts\engine\utility::ter_op(istrue(game["_encstr_96DF0BCC92723B8A59E7F338A1"]), var_2, var_1))
    return 1;

  return 0;
}

getscoreperminute(var_0) {
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self))
    var_2 = self.score / var_1;
  else
    var_2 = getteamscore(var_0) / var_1;

  return var_2;
}

getscoreremaining(var_0) {
  var_1 = level.roundscorelimit;

  if(isPlayer(self))
    var_2 = var_1 - self.score;
  else
    var_2 = var_1 - getteamscore(var_0);

  return var_2;
}

getscoreperminuteroundbased(var_0) {
  var_1 = level.roundscorelimit;

  if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_1 = var_1 / 2;
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_3 = getteamscore(var_0) / var_2;
  } else {
    var_1 = int(var_1 / 2);
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_4 = getteamscore(var_0);

    if(var_4 >= var_1)
      var_3 = (var_4 - var_1) / var_2;
    else
      return 0;
  }

  return var_3;
}

givelastonteamwarning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_88101078BE5C37CD984FAC9EDB23672DB507");
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AB591C8E66FAE1D845FBD978977B7319B28E7101FF4245C12AC748582385", self, self.pers["_encstr_8AEF05472BC2D6"]);

  foreach(var_1 in level.teamnamelist) {
    if(self.pers["_encstr_8AEF05472BC2D6"] != var_1)
      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", self, var_1);
  }

  level notify("_encstr_B6420BE367A3B0A1F7EB43C33F", self);
}

processlobbydata() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    _id_128AF(var_1);
  }

  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
      setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 1);
    else
      setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 0);
  }

  scripts\mp\scoreboard::processlobbyscoreboards();

  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0)
    sendclientmatchdata();

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata())
    thread scripts\mp\codcasterclientmatchdata::sendcodcastermatchdata();
}

cargo_truck_mg_explode(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
  }
}

_id_128AF(var_0) {
  if(istrue(var_0._id_128AF)) {
    return;
  }
  var_0._id_128AF = 1;
  cargo_truck_mg_explode(var_0);
  var_1 = var_0.name;

  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_91C008E832AE2577876F", var_0 getclantag());
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_823C09A2FB0F95E1C4FF41", var_0 getxuidhigh());
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_B12B0878EBE4094C77A7", var_0 getxuidlow());
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_87FA065AE621EDE8", isbot(var_0));
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_9BDC0FAE73A517EA561A8D96CAB9A3A446", var_0.clientid);
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_9BB5094F0EC73D22DE5BBA", var_1);
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BE260BC66BC0F7FF0D71A25ADA", var_0 _meth_87D2());

    if(var_0 isps4player())
      setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_A31904E09B0D");
    else if(var_0 isxb3player())
      setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8D19040F89CC");
    else if(var_0 ispcplayer())
      setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_B49B054CDC568E");
    else
      setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8BBA05185F8B99");
  }

  var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_882A111B1B5A95DC1D35B08ED81A29CD1995E1", var_0.clientmatchdataid);
  var_0 scripts\mp\scoreboard::setplayerscoreboardinfo();
  var_2 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AAAC09D09972B9CC3F2B7F", scripts\mp\utility\game::getgametype());
  var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AB1904852B68", var_2);
  scripts\mp\matchdata::_id_13154(var_0);
}

trackleaderboarddeathstats(var_0, var_1, var_2, var_3) {
  var_1 thread threadedsetweaponstatbyname(var_2, 1, "_encstr_8E0607055DBFB3919A");
  var_1 thread threadedsetweaponstatbyname(var_2, distancesquared(var_0.origin, var_1.origin), "_encstr_A5D71D6CEADAEAB1164796EC95F546590BA31A7DC8A5E6E8B073C656F537C5");
}

trackattackerleaderboarddeathstats(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(var_3 != "_encstr_87A10C9D24E997A01F21838F3D34") {
      if(var_3 == "_encstr_8DED0A21C79B660BC7588981" && issubstr(var_2, "_encstr_99C209E34FC743616118AB")) {
        var_0 scripts\common\utility::_id_13E0A(level._id_11B25, "_encstr_99C209E34FC743616118AB", "_encstr_8E8D0697EB01F243", 1, var_2);
        var_0 scripts\common\utility::_id_13E0A(level._id_11B25, "_encstr_99C209E34FC743616118AB", "_encstr_88CC0521F3A13B", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("_encstr_99C209E34FC743616118AB", "_encstr_8E8D0697EB01F243", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("_encstr_99C209E34FC743616118AB", "_encstr_88CC0521F3A13B", 1, var_2);
        return;
      }

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981" && !scripts\mp\riotshield::isriotshield(var_2) && !scripts\mp\utility\weapon::isknifeonly(var_2) && !scripts\mp\utility\weapon::turret_aimed_at_last_known(var_2) && !scripts\mp\utility\weapon::isaxeweapon(var_2)) {
        var_0 scripts\common\utility::_id_13E0A(level._id_11B25, "_encstr_8BBA05185F8B99", "_encstr_8E8D0697EB01F243", 1, var_2);
        var_0 scripts\common\utility::_id_13E0A(level._id_11B25, "_encstr_8BBA05185F8B99", "_encstr_88CC0521F3A13B", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("_encstr_8BBA05185F8B99", "_encstr_8E8D0697EB01F243", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("_encstr_8BBA05185F8B99", "_encstr_88CC0521F3A13B", 1, var_2);
        return;
      }

      var_0 thread threadedsetweaponstatbyname(var_2, 1, "_encstr_8E8D0697EB01F243");
      var_0 thread threadedsetweaponstatbyname(var_2, distancesquared(var_0.origin, var_1.origin), "_encstr_AADA1CFF53CA4B8C96F3205B618944D068A160C870462B2B1A51DD17C7C2");
    }

    if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
      var_0 thread threadedsetweaponstatbyname(var_2, 1, "_encstr_96D30A3468575BA7C307A128");
  }
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

  if(isDefined(var_3._id_121D9))
    var_3 = var_3._id_121D9;

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo))
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && getdvarint("_encstr_88ED216E6CC9BE3A27B036B57D38D2C6D69591D7BA38D7772B0B0EB737D7DC3A2CA39B", 1) == 1;

  if(scripts\mp\utility\weapon::ispickedupweapon(var_3) && !istrue(level.get_audio_approved_length_extender_for_non_english_vo)) {
    return;
  }
  var_4 = var_3.basename;
  var_5 = scripts\mp\utility\weapon::getweapongroup(var_3);
  var_6 = getweaponvariantindex(var_3);

  if(var_5 == "_encstr_BEB406F03B72BB3B") {
    var_7 = scripts\mp\supers::shouldtracksuperweaponstats(var_3);

    if(isDefined(var_7) && !var_7)
      return;
  }

  if(var_5 == "_encstr_85CE0B9770B02C73A1760F06D2" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_92EA0A290B32FF88A90170EB" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9" || var_5 == "_encstr_8261067B1D34AC27" && var_4 != "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3") {
    return;
  }
  if(scripts\mp\utility\weapon::isenvironmentweapon(var_3)) {
    return;
  }
  if(var_5 == "_encstr_82F10F832FFB4B67E0E9897260907E55FA" || var_5 == "_encstr_998911DD5916C17BCDD795F01CB17B6E5AB356" || var_4 == "_encstr_92EA0A290B32FF88A90170EB" || var_4 == "_encstr_AAE60D90523A6F0173CD06F38F6FEB") {
    var_4 = scripts\mp\utility\script::strip_suffix(var_4, "_encstr_851A049F8337");
    scripts\mp\persistence::incrementweaponstat(var_4, var_2, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B31, var_4, var_2, var_1, var_6, var_3);
    return;
  }

  if(!isDefined(self.trackingweapon))
    self.trackingweapon = var_3;

  if(var_3 != self.trackingweapon) {
    scripts\mp\persistence::updateweaponbufferedstats(var_3);
    self.trackingweapon = var_3;
  }

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
    var_8 = undefined;
    var_9 = scripts\mp\utility\weapon::getweaponrootname(var_3);

    if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_9) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_9)) {
      return;
    }
    var_10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_3);
    scripts\mp\persistence::incrementweaponstat(var_9, var_2, var_1);
    scripts\common\utility::_id_13E0A(level._id_11B31, var_9, "_encstr_8E0607055DBFB3919A", var_1, var_6, var_3);

    foreach(var_12 in var_10) {
      scripts\mp\persistence::incrementattachmentstat(var_12, var_2, var_1, var_3);
      scripts\common\utility::_id_13E0A(level._id_11B25, var_12, var_2, var_1, var_3);
    }
  }
}

setinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 setweaponstat(var_2, 1, "_encstr_88CC0521F3A13B");
    return;
  }

  if(!isDefined(var_0.playeraffectedarray))
    var_0.playeraffectedarray = [];

  var_3 = 1;

  for(var_4 = 0; var_4 < var_0.playeraffectedarray.size; var_4++) {
    if(var_0.playeraffectedarray[var_4] == self) {
      var_3 = 0;
      break;
    }
  }

  if(var_3) {
    var_0.playeraffectedarray[var_0.playeraffectedarray.size] = self;
    var_1 setweaponstat(var_2, 1, "_encstr_88CC0521F3A13B");
  }
}

threadedsetweaponstatbyname(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isPlayer(self) && !isagent(self)) {
    return;
  }
  waittillframeend;
  setweaponstat(var_0, var_1, var_2);
}

updatespmstats() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = getmatchspm(var_1);
      var_3 = scripts\engine\utility::ter_op(level.teambased, var_1.score, var_1.pers["_encstr_A7E80EB868982F22383F6F4FD680F85D"]);
      var_4 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_B47D0A3FB5578AB715B7D98C");
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
      var_4 = var_4 * (var_5 - 1);
      var_6 = var_2;

      if(var_5 > 0)
        var_6 = (var_4 + var_2) / var_5;

      var_1 setplayerdata("_encstr_8C07031599", "_encstr_B47D0A3FB5578AB715B7D98C", int(var_6));
      var_7 = getgametypeindex(scripts\mp\utility\game::getgametype());
      var_8 = 5;
      var_9 = 32;

      if(var_7 >= 0 && var_7 < var_9) {
        for(var_10 = 0; var_10 < 4; var_10++) {
          var_11 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_9555103CF127390345E280F12A1A39302381", var_10 + 1);
          var_1 setplayerdata("_encstr_8C07031599", "_encstr_9555103CF127390345E280F12A1A39302381", var_10, var_11);
        }

        var_1 setplayerdata("_encstr_8C07031599", "_encstr_9555103CF127390345E280F12A1A39302381", 4, scripts\mp\utility\game::getgametype());
        var_12 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_B6D815D958D65635ED19569AD8DEC92B0996E6D1ED4EBC", var_7, "_encstr_B48F06CC58B0F50B");
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_B6D815D958D65635ED19569AD8DEC92B0996E6D1ED4EBC", var_7, "_encstr_AB0B07DC8DDBC9ACB9", var_12, int(var_2));
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_B6D815D958D65635ED19569AD8DEC92B0996E6D1ED4EBC", var_7, "_encstr_A1C80D6651984D22198FAFA7F5B5CB", var_12, int(var_3));
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_B6D815D958D65635ED19569AD8DEC92B0996E6D1ED4EBC", var_7, "_encstr_AAAC09D09972B9CC3F2B7F", scripts\mp\utility\game::getgametype());
        var_12 = (var_12 + 1) % var_8;
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_B6D815D958D65635ED19569AD8DEC92B0996E6D1ED4EBC", var_7, "_encstr_B48F06CC58B0F50B", var_12);
      }
    }
  }
}

checkforpersonalbests() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = var_1 getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8E8D0697EB01F243");
      var_3 = var_1 getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8E0607055DBFB3919A");
      var_4 = var_1.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_85BF0EDA20B17DAF746011058FBBA704");
      var_6 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_8E790F8C5958E8D0B9253705A90B8E6C43");
      var_7 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_8EE60BE2EBCFD0E98DB9390FA8");
      var_8 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_8C5D0831CAE63AD40A53", "_encstr_82FB06EB26785BD7");
      var_9 = var_1 getplayerdata("_encstr_8C07031599", "_encstr_8BCD07E8AA22E96C1B", "_encstr_82FB06EB26785BD7");

      if(var_2 > var_5)
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_2, "_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_85BF0EDA20B17DAF746011058FBBA704");

      if(var_4 > var_7)
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_4, "_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_8EE60BE2EBCFD0E98DB9390FA8");

      if(var_3 > var_6)
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_3, "_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_8E790F8C5958E8D0B9253705A90B8E6C43");

      var_10 = var_2;

      if(var_3 > 1)
        var_10 = var_10 / var_3;

      var_10 = int(var_10 * 1000);

      if(var_10 > var_9) {
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_8BCD07E8AA22E96C1B", "_encstr_82FB06EB26785BD7", var_10);
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_8BCD07E8AA22E96C1B", "_encstr_84EF055338A18F", getsystemtime());
      }

      var_11 = getmatchspm(var_1);

      if(var_11 > var_8) {
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_8C5D0831CAE63AD40A53", "_encstr_82FB06EB26785BD7", int(var_11));
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_8C5D0831CAE63AD40A53", "_encstr_84EF055338A18F", getsystemtime());
      }

      var_1 checkforbestweapon();
    }
  }
}

brking_addtoc130infil() {
  return level.onlinestatsenabled && isleaderboardsupportedmode();
}

updateleaderboardstatscontinuous() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8203171FF34881076042AFC5B1E20E5F79D57B87971B398347");

  if(!brking_addtoc130infil()) {
    return;
  }
  var_0 = 0;

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0)
      waitframe();

    if(var_0 >= level.players.size)
      var_0 = 0;

    var_1 = level.players[var_0];

    if(!isDefined(var_1) || isai(var_1))
      waitframe();
    else {
      var_1 _id_14008();
      wait 0.1;
    }

    var_0++;
  }
}

updateleaderboardstats() {
  if(!brking_addtoc130infil()) {
    return;
  }
  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || isai(var_1)) {
      continue;
    }
    var_1 _id_14008();
  }
}

updateplayerleaderboardstats() {
  if(!brking_addtoc130infil()) {
    return;
  }
  if(!isDefined(self) || isai(self)) {
    return;
  }
  _id_14008();
}

isleaderboardsupportedmode() {
  if(level.hardcoremode)
    var_0 = "_encstr_8A19042AB017";
  else
    var_0 = "_encstr_B40101";

  var_0 = var_0 + scripts\mp\utility\game::getgametype();

  switch (var_0) {
    case "_encstr_8E3C0786C6D70B9CB6":
    case "_encstr_A955091A1B7D6C5E1356C9":
    case "_encstr_8C57060D6CD743C5":
    case "_encstr_AA380940EFD176FB85F052":
    case "_encstr_8FB20843C6BE8EC85999":
    case "_encstr_8F5706B969B67A7D":
    case "_encstr_A21D08866CEB1B7BDCCC":
    case "_encstr_A757067468C82344":
    case "_encstr_B63C075BB699A1880D":
    case "_encstr_BE3B070D1BF5BB0B4E":
    case "_encstr_9719046E3182":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_9707038CB6":
    case "_encstr_B41904BB8593":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_8A1804DAAB75":
    case "_encstr_959105B99040BD":
    case "_encstr_B60703EACA":
    case "_encstr_8E1904B3F501":
    case "_encstr_ACF906B79752C5E8":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
    case "_encstr_8218041DF5FA":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_A9B606B0C956B916":
    case "_encstr_B607038AAB":
    case "_encstr_B81904B04E6B":
      return 1;
    default:
      return 0;
  }

  return 0;
}

generate_randomized_primary_weapon_objs(var_0) {
  return isDefined(var_0) && (var_0 == "_encstr_BE180419DAE9" || var_0 == "_encstr_8AE1099A0B999F2D28AF15" || var_0 == "_encstr_9B1F05BE4B9B52" || var_0 == "_encstr_B18D0B5281530117EDEAC82033" || var_0 == "_encstr_816E079685517D0975" || var_0 == "_encstr_A1D0081CC297B1EDB08C" || var_0 == "_encstr_885107303AB2D1D8B7" || var_0 == "_encstr_866209ECEDB1197DEE0B4E");
}

_id_14008() {
  var_0 = undefined;

  if(level.hardcoremode)
    var_0 = "_encstr_8A19042AB017";
  else
    var_0 = "_encstr_B40101";

  var_0 = var_0 + scripts\mp\utility\game::getgametype();

  if(getdvarint("_encstr_ADBD2420CB937FE987A6E0DBF20179FA013B3DD3E71A40BF696F63FD18BB63E19FAFFB47A353", 0)) {
    return;
  }
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name)) {
    switch (level.disable_super_in_turret.name) {
      case "_encstr_A254085207A6B7334B5A":
      case "_encstr_87A205AF50D049":
      case "_encstr_9936086E0BB9324CDBC3":
      case "_encstr_816005BF2BE883":
      case "_encstr_86370883AB0B76583B43":
      case "_encstr_A1D0081CC297B1EDB08C":
      case "_encstr_B18D0B5281530117EDEAC82033":
      case "_encstr_8AE1099A0B999F2D28AF15":
      case "_encstr_BE180419DAE9":
        var_0 = var_0 + ("_encstr_BA4C02DF" + level.disable_super_in_turret.name);
        break;
      case "_encstr_866209ECEDB1197DEE0B4E":
        var_0 = var_0 + "_encstr_A5430589E8BDC8";
        break;
      case "_encstr_AD51088015D1E2D47930":
      case "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95":
      case "_encstr_AD300C932B4C969CD1D0AF911346":
      case "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8":
        var_0 = var_0 + "_encstr_A2C609FA9CCA4CD293D186";
        break;
      case "_encstr_A919041BADA2":
      case "_encstr_920A0862BD63CB5FC758":
      case "_encstr_91190446A2B3":
      case "_encstr_9286085A21B8034D3863":
      case "_encstr_AAEF05B85A86E9":
      case "_encstr_A11804C81332":
      case "_encstr_831904FDF363":
      case "_encstr_B40101":
        break;
      default:
        return;
    }
  }

  var_1 = scripts\engine\utility::ter_op(level.teambased, self.score, self.watchvehicleingas["_encstr_A7E80EB868982F22383F6F4FD680F85D"]);
  incrementleaderboardstat("_encstr_82FB06EB26785BD7", var_0, var_1);
  var_2 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);
  incrementleaderboardstat("_encstr_881A0B47B4B6B2286316E59532", var_0, var_2);
  incrementleaderboardstat("_encstr_8E8D0697EB01F243", var_0, self.watchvehicleingas["_encstr_8E8D0697EB01F243"]);
  incrementleaderboardstat("_encstr_8E0607055DBFB3919A", var_0, self.watchvehicleingas["_encstr_8E0607055DBFB3919A"]);

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_B41904BB8593":
      incrementleaderboardstat("_encstr_A1F308589BCD96CD476E", var_0, self.watchvehicleingas["_encstr_A1F308589BCD96CD476E"]);
      break;
    case "_encstr_A9B606B0C956B916":
      incrementleaderboardstat("_encstr_B2BE0788BAF573592F", var_0, self.watchvehicleingas["_encstr_B2BE0788BAF573592F"]);
      incrementleaderboardstat("_encstr_A1F308589BCD96CD476E", var_0, self.watchvehicleingas["_encstr_A1F308589BCD96CD476E"]);
      break;
    case "_encstr_B81904B04E6B":
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_ACF906B79752C5E8":
      incrementleaderboardstat("_encstr_B642089B65A658E8F597", var_0, self.watchvehicleingas["_encstr_8294083A0938C3CB2577"]);
      incrementleaderboardstat("_encstr_8FB00783D8C2CDE8DC", var_0, self.watchvehicleingas["_encstr_8FB00783D8C2CDE8DC"]);
      break;
    case "_encstr_9707038CB6":
      updateleaderboardstatmaximum("_encstr_ADD807BF2CCA78FFE7", var_0, self.watchvehicleingas["_encstr_8B560B62B16B5067FCFAB88833"]);
      break;
    case "_encstr_8218041DF5FA":
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_B807035284":
      incrementleaderboardstat("_encstr_8FB00783D8C2CDE8DC", var_0, self.watchvehicleingas["_encstr_8FB00783D8C2CDE8DC"]);
      incrementleaderboardstat("_encstr_817B0812789D1387E986", var_0, self.watchvehicleingas["_encstr_817B0812789D1387E986"]);
      break;
    case "_encstr_959105B99040BD":
      incrementleaderboardstat("_encstr_AA4A0963483063AC1580D3", var_0, self.watchvehicleingas["_encstr_820E0A2AE8981DBA528588DC"]);
      incrementleaderboardstat("_encstr_8B4E0746CAE696CAB9", var_0, self.watchvehicleingas["_encstr_B64E070F391562989D"]);
      break;
    case "_encstr_8E07030349":
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_BDD705AD7BD143":
      incrementleaderboardstat("_encstr_ACF5089FF6827199725B", var_0, self.watchvehicleingas["_encstr_ACF5089FF6827199725B"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_8E1904B3F501":
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_A9F70806677BD37B5EE7", var_0, self.watchvehicleingas["_encstr_A9F70806677BD37B5EE7"]);
      break;
    case "_encstr_9B0703CD93":
      incrementleaderboardstat("_encstr_8FB00783D8C2CDE8DC", var_0, self.watchvehicleingas["_encstr_8FB00783D8C2CDE8DC"]);
      incrementleaderboardstat("_encstr_8294083A0938C3CB2577", var_0, self.watchvehicleingas["_encstr_8294083A0938C3CB2577"]);
      break;
    case "_encstr_A54F06D32A2F0498":
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_B642089B65A658E8F597", var_0, self.watchvehicleingas["_encstr_8294083A0938C3CB2577"]);
      break;
    case "_encstr_A7290676E4D2378C":
      incrementleaderboardstat("_encstr_A78106C4B0B9AD37", var_0, self.watchvehicleingas["_encstr_820E0A2AE8981DBA528588DC"]);
      incrementleaderboardstat("_encstr_8B4E0746CAE696CAB9", var_0, self.watchvehicleingas["_encstr_B64E070F391562989D"]);
      break;
    case "_encstr_AAE507E8423F63C163":
      incrementleaderboardstat("_encstr_84EF055338A18F", var_0, scripts\mp\utility\stats::getpersstat("_encstr_8A220C2BC3474E0BB9B17B9CB203"));
      incrementleaderboardstat("_encstr_87FC09E8423F63C163DD8D", var_0, self.watchvehicleingas["_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91"]);
      break;
    case "_encstr_8A1804DAAB75":
      incrementleaderboardstat("_encstr_AAAD06703BB2590B", var_0, self.watchvehicleingas["_encstr_AAAD06703BB2590B"]);
      incrementleaderboardstat("_encstr_AD7F0937568E090B1B6D37", var_0, self.watchvehicleingas["_encstr_AD7F0937568E890B1B6D37"]);
      break;
    case "_encstr_9A7205B39CB919":
      incrementleaderboardstat("_encstr_ACF5089FF6827199725B", var_0, self.watchvehicleingas["_encstr_ACF5089FF6827199725B"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_9719046E3182":
      incrementleaderboardstat("_encstr_A1F308589BCD96CD476E", var_0, self.watchvehicleingas["_encstr_A1F308589BCD96CD476E"]);
      incrementleaderboardstat("_encstr_81CF0936850ED1D54EACCD", var_0, self.watchvehicleingas["_encstr_81CF0936850ED1D54EACCD"]);
      incrementleaderboardstat("_encstr_B1F7085B03F492AE98DB", var_0, self.watchvehicleingas["_encstr_B1F7085B03F492AE98DB"]);
      break;
    case "_encstr_A20D05FBEB01F2":
      incrementleaderboardstat("_encstr_A78106C4B0B9AD37", var_0, self.watchvehicleingas["_encstr_820E0A2AE8981DBA528588DC"]);
      incrementleaderboardstat("_encstr_8B4E0746CAE696CAB9", var_0, self.watchvehicleingas["_encstr_B64E070F391562989D"]);
      break;
    case "_encstr_B607038AAB":
      incrementleaderboardstat("_encstr_A9AB06297DDFD816", var_0, self.watchvehicleingas["_encstr_A9AB06297DDFD816"]);
      incrementleaderboardstat("_encstr_A77D0ABAF0559B4B51C6041B", var_0, self.watchvehicleingas["_encstr_A77D0ABAF0559B4B51C6041B"]);
      incrementleaderboardstat("_encstr_A9F6058464DADF", var_0, self.watchvehicleingas["_encstr_A9F6058464DADF"]);
      incrementleaderboardstat("_encstr_ADF208A8B778CDD39BAF", var_0, self.watchvehicleingas["_encstr_ADF208A8B778CDD39BAF"]);
      incrementleaderboardstat("_encstr_82190715F52B81894E", var_0, self.watchvehicleingas["_encstr_82190715F52B81894E"]);
      incrementleaderboardstat("_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1", var_0, self.watchvehicleingas["_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1"]);
      incrementleaderboardstat("_encstr_95B80C17DA7BF867C7ED6BC84D94", var_0, self.watchvehicleingas["_encstr_95B80C17DA7BF867C7ED6BC84D94"]);
      incrementleaderboardstat("_encstr_B642089B65A658E8F597", var_0, self.watchvehicleingas["_encstr_8294083A0938C3CB2577"]);
      incrementleaderboardstat("_encstr_B49005512AF703", var_0, self.watchvehicleingas["_encstr_B49005512AF703"]);
      incrementleaderboardstat("_encstr_ACF5089FF6827199725B", var_0, self.watchvehicleingas["_encstr_ACF5089FF6827199725B"]);
      break;
  }
}

incrementleaderboardstat(var_0, var_1, var_2) {
  if(!isDefined(self.leaderboardstartvalues))
    self.leaderboardstartvalues = [];

  if(!isDefined(self.leaderboardstartvalues[var_0]))
    self.leaderboardstartvalues[var_0] = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_B4490A358778072F5D41334B", var_1, var_0);

  var_3 = int(max(self.leaderboardstartvalues[var_0] + var_2, self.leaderboardstartvalues[var_0]));
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_B4490A358778072F5D41334B", var_1, var_0, var_3);
}

updateleaderboardstatmaximum(var_0, var_1, var_2) {
  var_3 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_B4490A358778072F5D41334B", var_1, var_0);

  if(var_2 > var_3)
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_B4490A358778072F5D41334B", var_1, var_0, var_2);
}

getmatchspm(var_0) {
  var_1 = scripts\engine\utility::ter_op(level.teambased, var_0.score, var_0.pers["_encstr_A7E80EB868982F22383F6F4FD680F85D"]);
  var_2 = var_0 scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = var_2 / 60;
    var_1 = var_1 / var_3;
  }

  return var_1;
}

isvalidbestweapon(var_0) {
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  return isDefined(var_0) && var_0 != "_encstr_B40101" && !scripts\mp\utility\weapon::iskillstreakweapon(var_0) && var_1 != "_encstr_85CE0B9770B02C73A1760F06D2" && var_1 != "_encstr_8261067B1D34AC27";
}

checkforbestweapon() {
  var_0 = scripts\common\utility::_id_13E0A(level._id_11B23);
  var_1 = "_encstr_B40101";
  var_2 = -1;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_4);

    if(isvalidbestweapon(var_4)) {
      if(!isenumvaluevalid("_encstr_8C07031599", "_encstr_8DA90CC379020F88735B8D023998", var_4)) {
        continue;
      }
      var_5 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_4, "_encstr_8E8D0697EB01F243");

      if(var_5 > var_2) {
        var_1 = var_4;
        var_2 = var_5;
      }
    }
  }

  var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_1, "_encstr_884806B91ADEE8CD");
  var_7 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_1, "_encstr_96D30A3468575BA7C307A128");
  var_8 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_1, "_encstr_88CC0521F3A13B");
  var_9 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_8DA90CCB79020F88735B8D023998", var_1, "_encstr_8E0607055DBFB3919A");
  var_10 = 0;
  self setplayerdata("_encstr_8C07031599", "_encstr_BE440B32FD239B938B3033DA50", "_encstr_8E8D0697EB01F243", var_2);
  self setplayerdata("_encstr_8C07031599", "_encstr_BE440B32FD239B938B3033DA50", "_encstr_884806B91ADEE8CD", var_6);
  self setplayerdata("_encstr_8C07031599", "_encstr_BE440B32FD239B938B3033DA50", "_encstr_96D30A3468575BA7C307A128", var_7);
  self setplayerdata("_encstr_8C07031599", "_encstr_BE440B32FD239B938B3033DA50", "_encstr_88CC0521F3A13B", var_8);
  self setplayerdata("_encstr_8C07031599", "_encstr_BE440B32FD239B938B3033DA50", "_encstr_8E0607055DBFB3919A", var_9);
  self setplayerdata("_encstr_8C07031599", "_encstr_9A800D6A5B033364ED9BB1500E36D7", var_10);
  var_11 = int(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_1, 0));
  self setplayerdata("_encstr_8C07031599", "_encstr_9157104CCA9BE8BA2BB083F6B94ADC32B2C3", var_11);
}

allow_weapon_mp(var_0) {
  self notify("_encstr_929212E9E8297F7C6957212B902048C19161E48E");

  if(var_0) {
    if(isDefined(self.allowweaponcache) && !self hasweapon(self.allowweaponcache) && !scripts\mp\utility\killstreak::isjuggernaut())
      scripts\mp\utility\inventory::switchtolastweapon();

    self.allowweaponcache = undefined;
  } else {
    self.allowweaponcache = self.lastnormalweaponobj;
    thread watchinvalidweaponswitchduringdisableweapon();
  }
}

allow_weapon_mp_init() {
  level.allow_weapon_mp = ::allow_weapon_mp;
}

watchinvalidweaponswitchduringdisableweapon() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_929212E9E8297F7C6957212B902048C19161E48E");

  for(;;) {
    self waittill("_encstr_9645168BA7FB3B20F809CA3B218389F35EA778E86748C1C9", var_0);
    self.allowweaponcache = var_0;
  }
}

ismp_init() {
  level.ismp = 1;
}

_id_144BF(var_0) {
  if(!istrue(level._id_11A5D)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0;

  level endon("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
  var_1 = getdvarint("_encstr_AC0C244311DB2DDE393F48E9B82033D03DDBE4C1A8B2A151D70389EB3250590660F877A5DD86", 1);
  var_2 = -1;
  var_3 = gettime();

  for(;;) {
    var_4 = getdvarint("_encstr_995B16634B6756BEB1DE9813E57D8DEDDDC1DEE0D75B2D37", 50);
    var_5 = getdvarfloat("_encstr_A99517C9799320A8B30AB9A173A7F9B86BD84769277B1889BF", 300) * 1000;
    var_6 = scripts\engine\utility::ter_op(var_0, getactiveclientcount(var_1), level.players.size);

    if(var_2 >= 0) {
      var_7 = var_2 + var_5;

      if(var_6 >= var_4 && gettime() >= var_7 && !istrue(level.devoverridematchstart)) {
        break;
      }
    } else if(var_6 >= var_4)
      var_2 = gettime();

    waitframe();
  }

  var_8 = getdvarint("_encstr_815B16611FDB0D39A4159991B8AF98B063E3EFA12FB2C748", 100);
  var_6 = scripts\engine\utility::ter_op(var_0, getactiveclientcount(var_1), level.players.size);

  if(var_6 <= var_8) {
    level._id_11A5E = 1;
    var_9 = gettime() - var_3;
    var_10 = getdvarfloat("_encstr_A99517C9799320A8B30AB9A173A7F9B86BD84769277B1889BF", 300);
    getentitylessscriptablearray("_encstr_8A7519DDF51A270E8503F8B813E7207FE3514FD04AB1D793693B78", ["_encstr_AC3E0E48938E3D539F98D947799F5BC7", var_6, "_encstr_BACF0DF7794CB0A0DB92505919576E", var_9, "_encstr_A53B1487C7C56A8ED8063EC5F8E0AEF3085F37AFB56D", var_0, "_encstr_BA3F0B7CB8E3CBDDE101227A90", var_4, "_encstr_813F0B81378BD0F88BB19019AB", var_8, "_encstr_BA550C36BDDD0E7B0ED7D196D6B2", var_10]);

    if(isDefined(level._id_12056))
      [[level._id_12056]]();
  }

  level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
}

watchforminplayersmatchstart() {
  level endon("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
  var_0 = getdvarint("_encstr_AC0C244311DB2DDE393F48E9B82033D03DDBE4C1A8B2A151D70389EB3250590660F877A5DD86", 1);
  var_1 = gettime();
  var_2 = var_1;
  var_3 = getdvarint("_encstr_882B1C635A9D95BE1BBD314C5ED7AD2D9BC1B10B9795276EF56E47B0393A");

  if(var_3 != 0) {
    for(;;) {
      if(istrue(level.devoverridematchstart)) {
        break;
      }

      var_4 = (var_2 - var_1) / 1000;
      var_5 = getdvarint("_encstr_BACC14C1718B38A0BBF2B1B97B9F61C0A0EF4943ED37", 300);

      if(var_5 > 0 && var_4 >= var_5) {
        break;
      }

      if(var_4 <= getdvarint("_encstr_A317182AF38B423101AFC2F94899B2C3AFF28B8EB7E91B8F08E0", 15)) {
        if(getactiveclientcount(0) >= getdvarint("_encstr_882B1C635A9D95BE1BBD314C5ED7AD2D9BC1B10B9795276EF56E47B0393A")) {
          break;
        }
      } else if(getactiveclientcount(var_0) >= getdvarint("_encstr_882B1C635A9D95BE1BBD314C5ED7AD2D9BC1B10B9795276EF56E47B0393A")) {
        break;
      }

      waitframe();
      var_2 = gettime();
    }
  }

  level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
}

enemy_move_up_and_ignore() {
  level endon("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");

  while(level.players.size < getdvarint("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9") || istrue(level.devoverridematchstart))
    waitframe();

  level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
}

watchdevoverridematchstart() {
  level.startbuttons = [];
  var_0 = getEntArray("_encstr_A1451406A3AA5D3BEF1BD8881BF19699430CF4847F33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread waitforoverridematchstartdvar();
  level thread waitforoverridematchstartnotify();

  if(var_0.size == 0)
    level thread waitforinitialplayerloadspawnflag();
  else {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.target))
        var_3[0] = getEnt(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      else {
        var_3[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
        var_3[0].angles = var_2.angles;
      }

      var_4 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_2, var_3, (0, 0, 64), undefined, 1);
      var_4 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
      var_4.id = "_encstr_AB19049D0FC0";
      var_4.trigger setuseprioritymax();
      var_4 scripts\mp\gameobjects::setusetime(3);
      var_4 scripts\mp\gameobjects::setusehinttext(&"_encstr_97DA220D77DFF02685794F97717CEE680B50C435D181E964ACA13FDBA9F78C019F8F1D3F");
      var_4.onuse = ::startbutton_onuse;
      level.startbuttons[level.startbuttons.size] = var_4;
    }
  }
}

waitforinitialplayerloadspawnflag() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
  level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  var_0 waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  waitframe();
  var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 = var_1[0];
  var_1[0] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 = "_encstr_9A19040BCDBC";
  var_4 = 3;
  var_5 = (31983, -35229, -458);
  var_2.team = "_encstr_A7A408B9CA5D1D4E2C63";
  level.startbuttons[0] = scripts\mp\gameobjects::createholduseobject(var_3, var_2, var_1, (0, 0, 0));
  level.startbuttons[0].curorigin = var_5;
  level.startbuttons[0].trigger.origin = var_5;
  level.startbuttons[0].visuals[0].origin = var_5;
  level.startbuttons[0].trigger makeusable();
  level.startbuttons[0].ownerteam = var_2.team;
  level.startbuttons[0].trigger.owner = level.players[0];
  level.startbuttons[0].interactteam = "_encstr_9A19040BCDBC";
  level.startbuttons[0].curprogress = 0;
  level.startbuttons[0].userate = 1;
  level.startbuttons[0].id = "_encstr_AB19049D0FC0";
  level.startbuttons[0].exclusiveuse = 0;
  level.startbuttons[0].exclusiveclaim = 1;
  level.startbuttons[0].skiptouching = 1;
  level.startbuttons[0].skipminimapids = 1;
  level.startbuttons[0].trigger setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  level.startbuttons[0].trigger setusehideprogressbar(1);
  level.startbuttons[0].trigger setHintString(&"_encstr_97DA220D77DFF02685794F97717CEE680B50C435D181E964ACA13FDBA9F78C019F8F1D3F");
  level.startbuttons[0].trigger setuseprioritymax();
  level.startbuttons[0].onuse = ::startbutton_onuse;
  level.startbuttons[0].flagmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  level.startbuttons[0].flagmodel setModel("_encstr_8BFA128B6BD08309FEA84F3F61F02B4BF84E3729");
  level.startbuttons[0].usabilitytrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5, 0, 32, 128);
  level.startbuttons[0] scripts\mp\gameobjects::setusetime(var_4);
}

waitforoverridematchstartdvar() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B65E1A23CA3BAF33EDE4D8ACD7DC8E0BE4D1EB1BF65BE06359A3AC91");

  for(;;) {
    if(getdvarint("_encstr_AC5918B39865A9F33BC00C056C23936ECDB8FA9BC03D5A171135", 0)) {
      dev_forcelivelobbystart();
      break;
    }

    wait 0.5;
  }
}

waitforoverridematchstartnotify() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B65E1A23CA3BAF33EDE4D8ACD7DC8E0BE4D1EB1BF65BE06359A3AC91");
  level waittill("_encstr_91A11099ED4E8D95DA8547C6A1371D2C4ED1");
  dev_forcelivelobbystart();
}

startbutton_onuse(var_0) {
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  dev_forcelivelobbystart();
}

dev_forcelivelobbystart() {
  level thread scripts\mp\utility\sound::playsoundonplayers("_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1");

  foreach(var_1 in level.teamnamelist)
  scripts\mp\utility\print::teamhudtutorialmessage("_encstr_9B69220819694C358F47E78DE7F46CA4C13E0C0BE1AD193F57B92D990ED3839E126F8F11", var_1, 10);

  setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 1);
  setDvar("_encstr_882B1C635A9D95BE1BBD314C5ED7AD2D9BC1B10B9795276EF56E47B0393A", 1);
  level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");

  foreach(var_4 in level.startbuttons) {
    var_4 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_4.trigger = undefined;
    var_4.visibleteam = "_encstr_8BBA05185F8B99";
    var_4.flagmodel delete();
    var_4 notify("_encstr_8BE208E31FA8E1631D65");
  }

  level notify("_encstr_B65E1A23CA3BAF33EDE4D8ACD7DC8E0BE4D1EB1BF65BE06359A3AC91");
}

livelobbyroundendwait(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 thread scripts\mp\utility\game::setuipostgamefade(0.0);

  wait(var_0);
  level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
}

livelobbymatchstarttimer(var_0, var_1) {
  self notify("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  self endon("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  level notify("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", var_0);
    var_3 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";
    matchstarttimerperplayer_internal(var_2, var_3);
  }

  visionsetnaked("_encstr_B40101", 0.0);
}

clearmatchhasmorethan1playervariablesonroundend() {
  game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] = 0;
  game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 0;
}

updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  var_0 = game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"];
  game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"]++;

  if(!game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] > 1)
      game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 1;
  }

  if(game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++)
        level.players[var_1] setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 1);
    } else
      self setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 1);
  }
}

updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  var_0 = game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"];
  game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"]--;

  if(game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] <= 1)
      game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 0;
  }

  if(!game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++)
        level.players[var_1] setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 0);
    }
  }
}

_id_12C14() {
  wait 10;
  var_0 = [];
  var_0[1] = "_encstr_A6FB14E3E927D37F593ED08858714532B59898479FF3";
  var_0[2] = "_encstr_815E0C7F0B2A8702B0C0DA9BABC6";
  var_0[3] = "_encstr_99BE0E29D1D1E75FE3979AE119923385";
  var_0[4] = "_encstr_BAFB0FD80B464656C9A62B1D16D8C8D8A1";
  var_0[5] = "_encstr_BD8E0EC56F29A28DA34947BF2833190F";
  var_0[6] = "_encstr_A7FB0F63B0C891AC4EA95947581BC49319";
  var_0[7] = "_encstr_911A095DA283A56B9B2211";
  var_0[8] = "_encstr_AA9508ADB7EA9BA3C61A";
  var_0[9] = "_encstr_BE9508BA80D5CB6BE2E5";
  var_0[10] = "_encstr_841A09ADB7BA9BA3199AD8";
  var_0[11] = "_encstr_928E0E3967A2D5C0822310E8172A9235";
  var_0[12] = "_encstr_830B1105709BF1E2BB614AAE1D5B7F65F23A28";
  var_0[13] = "_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A";
  var_0[14] = "_encstr_8E130FA8F2D7C858269F0D3DBD524AAE4A";
  var_0[15] = "_encstr_8DAF0AD6B0E68E8D9546A61B";
  var_0[16] = "_encstr_83AF0AC0361ED0412A46EDE1";
  var_0[17] = "_encstr_919109AA5148539DA0FDAC";
  var_0[18] = "_encstr_9B9109AD2CE6A363953364";
  var_0[19] = "_encstr_8B3414DBFB57F41B465C39B353B4E813E97023B39242";
  var_0[20] = "_encstr_BDBA1437478596E43719AE1B8DC8364B3B0DD1C48CC1";

  foreach(var_2 in var_0)
  scripts\cp_mp\utility\game_utility::_id_12C10(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

reinforcement_icon_objective_id() {
  return 9;
}

getintorzero() {
  level.allowsupers = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::round_vehicle_logic() + "_encstr_ADCD0D3760636950DFF10BF3376B03", level.allowsupers);
}

_id_119AE() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1))
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_1, "_encstr_99F30B8C2CB50B7695887BB9CA", var_1 scripts\mp\utility\stats::getpersstat("_encstr_B2BE0788BAF573592F"));
  }
}

_id_119AF(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }
  if(!istrue(level.teambased) || istrue(level.multiteambased)) {
    return;
  }
  var_1 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2 = var_0.team;
  var_3 = level.teamnamelist[0];

  if(var_2 == var_3)
    var_3 = level.teamnamelist[1];

  var_4 = getteamscore(var_2);
  var_5 = getteamscore(var_3);
  var_6 = 0;

  if(isDefined(var_0.isbecomingzombie))
    var_6 = var_0.isbecomingzombie;

  var_0 dlog_recordplayerevent("_encstr_B8BA18B1FA8784C9775EEBC564D1D0D873212879515BC8C0CD24", ["_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_1, "_encstr_AD57115AE08FFB490B814BA0E9AD906071BD9F", var_2, "_encstr_95E210ACDC2B5BF2D7E8B20BD6F5B958DA56", var_3, "_encstr_A78512C11B85975627FAA3B2B0ADD76E36F6E4B2", var_4, "_encstr_A3721156E62B6B97EB3ACA0B5BF59B8DDE4E95", var_5, "_encstr_9B33129577356364423F8B909013205387ABE8C5", var_6]);
}

_id_12465() {
  self setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 0);
  self setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", 0);
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack(1);
  wait 1;
  self.multieventdisabled = 1;
  _id_12767(level.multieventdebug._id_142AF, level.multieventdebug._id_142AE, level.multieventdebug.unmarkplayeraseliminated);
  self.multieventdisabled = undefined;
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 14);
}

_id_12767(var_0, var_1, var_2) {
  self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 12);
  self setsoundsubmix("_encstr_9ACE2D371F79E2E733B8B75BB8C9934AB7A73D2DE893EBE3392813A798A35BD2A7D0C625EDBF132B23D87B3320B953", 0.5);
  scripts\mp\utility\player::_freezecontrols(1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 0);
  var_3 = getDvar("_encstr_B8F20B31E043F917232347D1D2");
  var_4 = getDvar("_encstr_97720B8110327704CFACD8A143");
  var_5 = getDvar("_encstr_AB150B27C9D4134DA69CA8A745");
  setDvar("_encstr_B8F20B31E043F917232347D1D2", 1);
  setDvar("_encstr_97720B8110327704CFACD8A143", 1);
  setDvar("_encstr_AB150B27C9D4134DA69CA8A745", -1);
  self preloadcinematicforplayer(var_0, 1, var_2);
  var_6 = gettime();
  _id_133DD(var_6, var_1 * 1000);
  self skydive_cutparachuteoff();
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("_encstr_8FD213EB904ABBC08743DF6240E039FD6911986635", var_3);
  setDvar("_encstr_AF0514E0EF39218341A280137CCAC38B81FFA8E00FD1", var_4);
  setDvar("_encstr_A54015A328734797513D8F9023905CC3A3672A0A70D54F", var_5);
  scripts\mp\utility\player::_freezecontrols(0);
  self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  self clearsoundsubmix("_encstr_9ACE2D371F79E2E733B8B75BB8C9934AB7A73D2DE893EBE3392813A798A35BD2A7D0C625EDBF132B23D87B3320B953", 0.5);
}

_id_133DD(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 2;
  var_2 = gettime();
  var_3 = 0;

  while(gettime() - var_0 < var_1 && gettime() - var_2 < 1000) {
    waitframe();

    if(self useButtonPressed()) {
      if(!var_3)
        var_3 = 1;

      continue;
    }

    var_3 = 0;
    var_2 = gettime();
  }
}