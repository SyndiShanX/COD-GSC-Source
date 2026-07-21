/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\war.gsc
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
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;

  if(getdvarint("_encstr_BE420C23FE03375C9F9852DA58F1", 0) != 0)
    level.onplayerkilled = ::_id_12040;

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8D110DCAB7E1501459D3B2418BD9FF";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  level.testtdmanywhere = getdvarint("_encstr_AC29107FFB0A69B51B5255B8FBBF6360A255", 0);
  level.tdmanywhere_dropheight = getdvarfloat("_encstr_83A51C9B36E4AF8E236B0A9BE5EE342BE42BEB46277B38D70D592D9D43E8", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat("_encstr_ACA51EFB79457E1D2ADF69151B97510DD5EB9643A94E32D99B29570C2B479128", 2048);
  level.tdmanywhere_distoffset = getdvarfloat("_encstr_99761CBB361DFE595155E91B5FBBF0F8B6E2E1E90366A441CF1B2DEAC550", 4092);

  if(istrue(level.testtdmanywhere))
    scripts\cp_mp\parachute::initparachutedvars();

  if(scripts\mp\utility\game::matchmakinggame())
    level._id_132FE = ::_id_132FE;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B2AF110E512049EFF7D29830EE010773889B8D", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("_encstr_8CEB103FBB4A29744FE356BB8B1F21F06715", 0);
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

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  }

  if(isDefined(level.totalapacheresponses))
    [[level.totalapacheresponses]]();
  else
    initspawns();

  _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::inittankspawns();

  if(getdvarint("_encstr_BE420C23FE03375C9F9852DA58F1", 0) != 0)
    thread _id_11D09();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_973807485A3B8A88D4", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");

  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);

  if(istrue(level.testtdmanywhere)) {
    var_4 = getdvarfloat("_encstr_AAE1182B9E3AB17512EFE3B5970BB3B8D2F756A1879EA0A50B23", randomfloatrange(-4096, 4096));
    var_5 = getdvarfloat("_encstr_81E11813A7F0B1BB5DD86862A22C03F72803878B337803A77E76", randomfloatrange(-4096, 4096));
    var_6 = getdvarfloat("_encstr_ADE118BBE21B6068DFAD3B6DD143D035B33AB6216A932D287282", randomfloatrange(0, 512));
    level.mapcenter = (var_4, var_5, var_6);
    tdmanywhere_debugshowlocs();
  } else {
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = undefined;

  if(istrue(level.testtdmanywhere)) {
    var_2 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1.0, level.tdmanywhere_perpenoffset);
    var_3 = undefined;

    if(var_0 == "_encstr_8E8405EA382B2A")
      var_3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1.0;
    else
      var_3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;

    var_1 = spawnStruct();
    var_1.origin = level.mapcenter + var_2 + var_3 + (0, 0, level.tdmanywhere_dropheight);
    var_1.angles = (0, 0, 0);
    var_1.index = 1;
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
  }

  return var_1;
}

onspawnplayer() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);

  if(!istrue(level.testtdmanywhere)) {
    return;
  }
  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08")
    var_0 = "_encstr_91AB08AC45BB5539F95B";
  else if("_encstr_8D19048EA595")
    var_0 = "_encstr_8B6D0940CC35339149DA08";

  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline))
    waitframe();

  var_0 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var_1 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_0, level.mapcenter + var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_0, level.mapcenter + var_0 - var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_0, level.mapcenter - var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_0, level.mapcenter - var_0 - var_1, 1000, (0, 0, 1));
}

_id_11D09() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.outlinedplayers = [];
  level.spawn_player_vehicle = 0;
  var_0 = 0;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2.spawn_race_dogtags)) {
        var_2.spawn_queue_think = 0;
        var_2.spawn_race_dogtags = var_2.origin;
        var_2.armorbox_used = var_2.origin;
      }

      var_2.spawn_queue_think = var_2.spawn_queue_think + distancesquared(var_2.spawn_race_dogtags, var_2.origin);
      var_2.spawn_race_dogtags = var_2.origin;
    }

    var_0 = var_0 + level.framedurationseconds;

    if(var_0 > 3.0) {
      if(level.spawn_player_vehicle >= 2) {
        level.spawn_player_vehicle = 0;

        foreach(var_2 in level.players) {
          if(!isDefined(var_2.armorbox_used))
            var_2.armorbox_used = var_2.origin;

          var_2.playeriscinematiclayeron = distancesquared(var_2.armorbox_used, var_2.origin) < 4225;
          var_2.armorbox_used = var_2.origin;
        }
      }

      foreach(var_2 in level.players) {
        var_7 = var_2 getentitynumber();
        var_8 = var_2.pers["_encstr_8AEF05472BC2D6"];

        if(var_8 == "_encstr_9A8507BA4040188D08")
          var_9 = "_encstr_8E8405EA382B2A";
        else
          var_9 = "_encstr_9A8507BA4040188D08";

        if(isalive(var_2) && (istrue(var_2.playeriscinematiclayeron) || var_2.spawn_queue_think < 4225 && !istrue(var_2.spawn_real_letter))) {
          var_2.playeriscinematiclayeron = 0;

          if(!isDefined(level.outlinedplayers[var_7])) {
            level.outlinedplayers[var_7] = var_2;
            var_2.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var_2, var_8, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
            var_2.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var_2, var_9, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
            var_2 scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF", 0);
          }
        } else {
          if(isalive(var_2))
            var_2.spawn_real_letter = 0;

          var_2.playeriscinematiclayeron = 0;

          if(isDefined(level.outlinedplayers[var_7])) {
            scripts\mp\utility\outline::outlinedisable(var_2.outlineidfriend, var_2);
            scripts\mp\utility\outline::outlinedisable(var_2.outlineidenemy, var_2);
            var_2 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            var_2.outlineidfriend = undefined;
            var_2.outlineidenemy = undefined;
            level.outlinedplayers[var_7] = undefined;
          }
        }

        var_2.spawn_queue_think = 0;
      }

      var_0 = 0;
    }

    level.spawn_player_vehicle++;
    waitframe();
  }
}

_id_12040(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var_10] = undefined;
  }

  self.spawn_real_letter = 1;
}

_id_132FE() {
  var_0 = int(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"]);
  var_1 = int(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"]);
  var_2 = var_0 - var_1;
  return var_2 < 10;
}