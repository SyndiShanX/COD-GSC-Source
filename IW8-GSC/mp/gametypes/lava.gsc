/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\lava.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onsuicidedeath = ::onsuicidedeath;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B272098461C963F3B1D378";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A5EE0E780BFD08A5321F7B07635AE040"] = &"_encstr_8F180FE58F40BBCC3D09C97169E9B567C5";
  level thread watchplayerconnect();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A32515035AA3C863062E93F732ED802883331BC8934F9B", 0);
  scripts\mp\utility\game::registerroundswitchdvar("_encstr_83AD0559672E3A", 0, 0, 9);
  setdynamicdvar("_encstr_8E0414976EF2B6C347C6D84743E79BD00CC060EBF3A5", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_83AD0559672E3A", 1);
  setdynamicdvar("_encstr_8FF312A33F9B791937E6477FDBDA90ED42505C1B", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_83AD0559672E3A", 1);
  setdynamicdvar("_encstr_993E123B10EDD1B3D1CC91B7EBF97B2759E842D2", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_83AD0559672E3A", 0);
  setdynamicdvar("_encstr_AA8B118EEE138FA049FB10E9CB7218332AD70D", 0);
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
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_84091060D3EA6F99B7FC0BBF17D891EDAE63");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_84091060D3EA6F99B7FC0BBF17D891EDAE63");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8FC816A709945434A892652A6A791382CA14AF3586F4492A");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_86ED159F25BAC8DB31A4132F1F122C406CBB573B9BD0A1");
  }

  initspawns();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
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
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_2 = undefined;
  }

  return var_2;
}

onsuicidedeath(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(var_0.pers["_encstr_8AEF05472BC2D6"])[0], var_1, 0);
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

watchplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 watchplayeronground();
  }
}

watchplayeronground() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self)) {
      if(self isonground() &!self iswallrunning()) {
        self dodamage(8.0, self.origin, self, undefined, "_encstr_AB590C99ED78875F650F3951034D");
        wait 1.0;
      }
    }

    waitframe();
  }
}