/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_conf.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  level.tacopssublevel = "_encstr_879E08D32031AB328875";
  level.currentmode = "_encstr_879E08D32031AB328875";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ontimelimit = scripts\mp\gamelogic::default_ontimelimit;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  _encstr_AC802A60CA62D30BDB6380A9588E71974B530A9062BB5F267F99B99534BF7B5B798B90F11A95AD590287BE9E::setup_callbacks();
  _encstr_AC802A60CA62D30BDB6380A9588E71974B530A9062BB5F267F99B99534BF7B5B798B90F11A95AD590287BE9E::setup_bot_conf();
  onstartgametype();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A6D91D2B71265F3B508F5B2F956089B7C74BC283197E1BB6B8C5542DB970C8", 5);
  setdynamicdvar("_encstr_A512216A065D49B428315F679021A773D32477A2FD8773E973C05B77983949B9ABB1BB", 10);
  setdynamicdvar("_encstr_BD2A1AFA49B07F2AA0CD937F195872B668D3BAC7C36107B20CFBDB4F", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_A757117208D3F254D23987DB050FE6379A626A"));
  setdynamicdvar("_encstr_A797176606FB67B9BF73F04173C7B04DC3AA4FE5DA70EBC081", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_86030E3B80D06E43EF274F8205FBDA31"));
  setdynamicdvar("_encstr_887D12CDB1E47D1BB773CCF58685D899A396AD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_959105B99040BD", 0);
  setdynamicdvar("_encstr_844411E78F23A8107F8DD1CE324A38F9AAFBB3", 0);
}

onstartgametype() {
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 6);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

updategametypedvars() {
  level.overridewatchdvars["_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8316094F78B8E72DB90F9B"] = 1;
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.scoreconfirm = scripts\mp\utility\dvars::dvarintvalue("_encstr_A757117208D3F254D23987DB050FE6379A626A", 1, 0, 25);
  level.scoredeny = scripts\mp\utility\dvars::dvarintvalue("_encstr_86030E3B80D06E43EF274F8205FBDA31", 0, 0, 25);
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_2 = undefined;
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_0);
    var_2 = undefined;
  }

  return var_2;
  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

onspawnplayer() {
  var_0 = 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    var_0 = 1;
  else if(self.team == "_encstr_8E8405EA382B2A")
    var_0 = 2;

  self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);
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
  }

  var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.scoreconfirm, 0);
}