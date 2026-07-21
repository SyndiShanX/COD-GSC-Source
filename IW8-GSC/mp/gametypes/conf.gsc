/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\conf.gsc
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
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 1);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83F717762C6B598EE507B2FA6D96C6D86CDB9B664BC9B62BC8";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C"] = "_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2FD0AD06BC8A3BFFDE1A2EB"] = "_encstr_B2FD0AD06BC8A3BFFDE1A2EB";
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_BD2A1AFA49B07F2AA0CD937F195872B668D3BAC7C36107B20CFBDB4F", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_A757117208D3F254D23987DB050FE6379A626A"));
  setdynamicdvar("_encstr_A797176606FB67B9BF73F04173C7B04DC3AA4FE5DA70EBC081", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_86030E3B80D06E43EF274F8205FBDA31"));
  setdynamicdvar("_encstr_9AC61D8F6126C72720A0C9AE53249CD906E3CE1FFEE727C74B5744EADBB0F3", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_910B142799F5885E33FB79E172B718D00FE19DB33D5F"));
  setdynamicdvar("_encstr_887D12CDB1E47D1BB773CCF58685D899A396AD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_959105B99040BD", 0);
  setdynamicdvar("_encstr_844411E78F23A8107F8DD1CE324A38F9AAFBB3", 0);
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
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_AB22107FC51A687B9104B34F7F7243F4C055");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_AB22107FC51A687B9104B34F7F7243F4C055");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_85E016F42149A81A1552598A4DCB347AE4197DD41AA7A42A");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_BA4715D9ABEA351FD1DCACDDA29EE7BC0623D1592FB66F");
  }

  initspawns();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::dogtagenemyonusecb;
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
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
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.scoreconfirm = scripts\mp\utility\dvars::dvarintvalue("_encstr_A757117208D3F254D23987DB050FE6379A626A", 1, 0, 25);
  level.scoredeny = scripts\mp\utility\dvars::dvarintvalue("_encstr_86030E3B80D06E43EF274F8205FBDA31", 0, 0, 25);
  level.vocalloutstring = scripts\mp\utility\dvars::dvarintvalue("_encstr_910B142799F5885E33FB79E172B718D00FE19DB33D5F", 0, 0, 1);
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
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_1;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

onspawnplayer() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 33);
}

dogtagallyonusecb(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B64E070F391562989D"]);
    var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.scoredeny, 0);
  }
}

dogtagenemyonusecb(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C", undefined, undefined, undefined, 4);
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);

    if(istrue(level.vocalloutstring)) {
      if(!var_0 scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"))
        var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("_encstr_95EB0866891B23FB85B3", 1, 0);
      else
        var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("_encstr_95EB0866891B23FB85B3", 1, 150);
    }
  }

  var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.scoreconfirm, 0);
}